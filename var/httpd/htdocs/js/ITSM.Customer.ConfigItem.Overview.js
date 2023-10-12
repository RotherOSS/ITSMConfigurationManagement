// --
// OTOBO is a web-based ticketing system for service organisations.
// --
// Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
// Copyright (C) 2019-2023 Rother OSS GmbH, https://otobo.de/
// --
// This program is free software: you can redistribute it and/or modify it under
// the terms of the GNU General Public License as published by the Free Software
// Foundation, either version 3 of the License, or (at your option) any later version.
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
// You should have received a copy of the GNU General Public License
// along with this program. If not, see <https://www.gnu.org/licenses/>.
// --

"use strict";

var ITSM = ITSM || {};
ITSM.Customer = ITSM.Customer || {};
ITSM.Customer.ConfigItem = ITSM.Customer.ConfigItem || {};

/**
 * @namespace ITSM.Customer.ConfigItem.Overview
 * @memberof ITSM.Customer.ConfigItem
 * @author Rother OSS GmbH
 * @description
 *      This namespace contains the special module functions for the config item overview navbar.
 */
ITSM.Customer.ConfigItem.Overview = (function (TargetNS) {

    /*
    * @name Init
    * @memberof ITSM.Customer.ConfigItem.Overview
    * @function
    * @description
    *      This function initializes the overview behaviours.
    */
    TargetNS.Init = function () {
        var ITSMConfigItemSearch    = Core.Config.Get('ITSMConfigItemSearch');

        var URL, ColumnFilter, NewColumnFilterStrg, MyRegEx, SessionInformation, $MasterActionLink;

        $('#ShowContextSettingsDialog').on('click', function (Event) {
            Core.UI.Dialog.ShowContentDialog($('#ContextSettingsDialogContainer'), Core.Language.Translate("Settings"), '15%', 'Center', true,
                [
                    {
                        Label: Core.Language.Translate("Submit"),
                        Type: 'Submit',
                        Class: 'Primary',
                        Function: function () {
                            var $ListContainer = $('.AllocationListContainer').find('.AssignedFields'),
                                Filter = $('li.Active > a').text(),
                                FieldID;
                            if (isJQueryObject($ListContainer) && $ListContainer.length) {
                                $.each($ListContainer.find('li'), function() {
                                    FieldID = 'UserFilterColumnsEnabled-' + $(this).attr('data-fieldname') + '-' + Filter;

                                    // only add this field if its not already there. This could happen
                                    // if e.g. the save button is clicked multiple times
                                    if (!$('#' + Core.App.EscapeSelector(FieldID)).length) {
                                        $('<input name="UserFilterColumnsEnabled" type="hidden" />').attr('id', FieldID).val($(this).attr('data-fieldname')).appendTo($ListContainer.closest('div'));
                                    }
                                });
                            }
                            return true;
                        }
                    }
                ], true);
            Event.preventDefault();
            Event.stopPropagation();
            Core.Customer.TableFilters.SetAllocationList();
            return false;
        });

        if (ITSMConfigItemSearch) {
            $('#ITSMConfigItemSearch').on('click', function () {
                ITSM.Customer.ConfigItem.Search.OpenSearchDialog(
                    'CustomerITSMConfigItemSearch',
                    Core.App.EscapeSelector(ITSMConfigItemSearch.Profile),
                    Core.App.EscapeSelector(ITSMConfigItemSearch.ClassID)
                );
                return false;
            });
        }

        Core.UI.InitCheckboxSelection($('table td.Checkbox'));

        // change event for column filter
        $('.ColumnFilter').on('change', function () {

            // define variables
            URL = Core.Config.Get("Baselink") + 'Action=' + Core.Config.Get("Action") + ';' + Core.Config.Get('LinkPage');
            SessionInformation = Core.App.GetSessionInformation();
            $.each(SessionInformation, function (Key, Value) {
                URL += encodeURIComponent(Key) + '=' + encodeURIComponent(Value) + ';';
            });
            ColumnFilter = $(this)[0].name;
            NewColumnFilterStrg = $(this)[0].name + '=' + encodeURIComponent($(this).val()) + ';';

            MyRegEx = new  RegExp(ColumnFilter+"=[^;]*;");

            // check for already set parameter and replace
            if (URL.match(MyRegEx)) {
                URL = URL.replace(MyRegEx, NewColumnFilterStrg);
            }

            // otherwise add the new column filter
            else {
                URL = URL + NewColumnFilterStrg;
            }

            // redirect
            window.location.href =  URL;
        });

        // click event on table header trigger
        $('.OverviewHeader').off('click').on('click', '.ColumnSettingsTrigger', function() {
            var $TriggerObj = $(this),
                FilterName;

            if ($TriggerObj.hasClass('Active')) {
                $TriggerObj
                    .next('.ColumnSettingsContainer')
                    .find('.ColumnSettingsBox')
                    .fadeOut('fast', function() {
                        $TriggerObj.removeClass('Active');
                    });
            }
            else {

                // slide up all open settings widgets
                $('.ColumnSettingsTrigger')
                    .next('.ColumnSettingsContainer')
                    .find('.ColumnSettingsBox')
                    .fadeOut('fast', function() {
                        $(this).parent().prev('.ColumnSettingsTrigger').removeClass('Active');
                    });

                // show THIS settings widget
                $TriggerObj
                    .next('.ColumnSettingsContainer')
                    .find('.ColumnSettingsBox')
                    .fadeIn('fast', function() {

                        $TriggerObj.addClass('Active');

                        // refresh filter dropdown
                        FilterName = $TriggerObj
                            .next('.ColumnSettingsContainer')
                            .find('select')
                            .attr('name');

                        if (
                                $TriggerObj.closest('th').hasClass('CustomerID') ||
                                $TriggerObj.closest('th').hasClass('CustomerUserID') ||
                                $TriggerObj.closest('th').hasClass('Responsible') ||
                                $TriggerObj.closest('th').hasClass('Owner')
                            ) {

                            if (!$TriggerObj.parent().find('.SelectedValue').length) {
                                Core.AJAX.FormUpdate($('#Nothing'), 'AJAXFilterUpdate', FilterName, [ FilterName ], function() {
                                    var AutoCompleteValue = $TriggerObj
                                            .next('.ColumnSettingsContainer')
                                            .find('select')
                                            .val(),
                                        AutoCompleteText  = $TriggerObj
                                            .next('.ColumnSettingsContainer')
                                            .find('select')
                                            .find('option:selected')
                                            .text();

                                    if (AutoCompleteValue !== 'DeleteFilter') {

                                        $TriggerObj
                                            .next('.ColumnSettingsContainer')
                                            .find('select')
                                            .after('<span class="SelectedValue Hidden">' + AutoCompleteText + ' (' + AutoCompleteValue + ')</span>')
                                            .parent()
                                            .find('input[type=text]')
                                            .after('<a href="#" class="DeleteFilter"><i class="fa fa-trash-o"></i></a>')
                                            .parent()
                                            .find('a.DeleteFilter')
                                            .off()
                                            .on('click', function() {
                                                $(this)
                                                    .closest('.ColumnSettingsContainer')
                                                    .find('select')
                                                    .val('DeleteFilter')
                                                    .trigger('change');

                                                return false;
                                            });
                                    }
                                });
                            }
                        }
                        else {
                            Core.AJAX.FormUpdate($('#ColumnFilterAttributes'), 'AJAXFilterUpdate', FilterName, [ FilterName ]);
                        }
                });
            }

            return false;
        });

        $('.MasterAction').on('click', function (Event) {
            var $MasterActionLink = $(this).find('.MasterActionLink');
            // only act if the link was not clicked directly
            if (Event.target !== $MasterActionLink.get(0)) {
                window.location = $MasterActionLink.attr('href');
                return false;
            }
        });
    };

    Core.Init.RegisterNamespace(TargetNS, 'APP_MODULE');

    return TargetNS;
}(ITSM.Customer.ConfigItem.Overview || {}));

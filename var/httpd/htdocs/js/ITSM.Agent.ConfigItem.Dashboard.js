// --
// OTOBO is a web-based ticketing system for service organisations.
// --
// Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
// Copyright (C) 2019-2025 Rother OSS GmbH, https://otobo.io/
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
ITSM.Agent = ITSM.Agent || {};
ITSM.Agent.ConfigItem = ITSM.Agent.ConfigItem || {};

/**
 * @namespace ITSM.Agent.ConfigItem.Dashboard
 * @memberof ITSM.Agent.ConfigItem
 * @author Rother OSS GmbH
 * @description
 *      This namespace contains the special module functions for the config item overview navbar.
 */
ITSM.Agent.ConfigItem.Dashboard = (function (TargetNS) {

    /*
    * @name Init
    * @memberof ITSM.Agent.ConfigItem.Dashboard
    * @function
    * @description
    *      This function initializes the overview behaviours.
    */
    TargetNS.Init = function () {

        var DashletData = Core.Config.Get('ITSMConfigItemGeneric');

        if (typeof DashletData !== 'undefined') {
            ITSMConfigItemGeneric(DashletData);

            // Subscribe to ContentUpdate event to initiate ticket generic events on widget update
            Core.App.Subscribe('Event.AJAX.ContentUpdate.Callback', function($WidgetElement) {
                if (typeof $WidgetElement !== 'undefined' && $WidgetElement.search(DashletData.Name) !== parseInt('-1', 10)) {
                    ITSMConfigItemGeneric(DashletData);
                }
            });
        }
    };

    /**
     * @private
     * @name ITSMConfigItemGeneric
     * @memberof ITSM.Agent.ConfigItem.Dashboard
     * @function
     * @param {Object} DashletData - Hash with container name and HTML name
     * @description
     *      Initializes dashboard widget ITSMConfigItemGeneric
     */
    function ITSMConfigItemGeneric (DashletData) {

            $('#Dashboard' + Core.App.EscapeSelector(DashletData.Name) + '-box').find('.Tab.Actions li a').off('click').on('click', function() {
                var CustomerID,
                    CustomerUserID,
                    Filter;

                CustomerID      = $('input[name=CustomerID]').val() || '';
                CustomerUserID  = $('input[name=CustomerUserID]').val() || '';
                Filter          = $(this).attr('data-filter');

                $('#Dashboard' + Core.App.EscapeSelector(DashletData.Name) + '-box').addClass('Loading');
                Core.AJAX.ContentUpdate($('#Dashboard' + Core.App.EscapeSelector(DashletData.Name)), Core.Config.Get('Baselink') + 'Action=' + Core.Config.Get('Action') + ';Subaction=Element;Name=' + DashletData.Name + ';CustomerID=' + encodeURIComponent(CustomerID) + ';CustomerUserID=' + encodeURIComponent(CustomerUserID) + ';Filter=' + Filter, function () {
                    $('#Dashboard' + Core.App.EscapeSelector(DashletData.Name) + '-box').removeClass('Loading');
                });
                return false;
            });

            $('#Dashboard' + Core.App.EscapeSelector(DashletData.Name) + '-box').find('.DataTable th a').off('click').on('click', function() {
                var CustomerID,
                    CustomerUserID,
                    SortBy          = $(this).attr('data-column'),
                    OrderBy         = '',
                    $OrderByObj     = $('#Dashboard' + Core.App.EscapeSelector(DashletData.Name) + '-box').find('th.SortDescendingLarge, th.SortAscendingLarge');

                CustomerID      = $('input[name=CustomerID]').val() || '';
                CustomerUserID  = $('input[name=CustomerUserID]').val() || '';

                if ($OrderByObj && $OrderByObj.hasClass('SortDescendingLarge')) {
                    OrderBy = 'Down';
                }
                else if ($OrderByObj && $OrderByObj.hasClass('SortAscendingLarge')) {
                    OrderBy = 'Up';
                }

                $('#Dashboard' + Core.App.EscapeSelector(DashletData.Name) + '-box').addClass('Loading');
                Core.AJAX.ContentUpdate($('#Dashboard' + Core.App.EscapeSelector(DashletData.Name)), Core.Config.Get('Baselink') + 'Action=' + Core.Config.Get('Action') + ';Subaction=Element;Name=' + DashletData.Name + ';CustomerID=' + encodeURIComponent(CustomerID) + ';CustomerUserID=' + encodeURIComponent(CustomerUserID) + ';SortBy=' + SortBy + ';OrderBy=' + OrderBy, function () {
                    $('#Dashboard' + Core.App.EscapeSelector(DashletData.Name) + '-box').removeClass('Loading');
                });
                return false;
            });
    }

    Core.Init.RegisterNamespace(TargetNS, 'APP_MODULE');

    return TargetNS;
}(ITSM.Agent.ConfigItem.Dashboard || {}));

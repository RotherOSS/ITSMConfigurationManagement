// --
// OTOBO is a web-based ticketing system for service organisations.
// --
// Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
// Copyright (C) 2019-2024 Rother OSS GmbH, https://otobo.de/
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
ITSM.Admin = ITSM.Admin || {};

/**
* @namespace ITSM.Admin.ITSMConfigItem
* @memberof ITSM.Admin
* @author
* @description
*      [description_placeholder]
*/
ITSM.Admin.ITSMConfigItem = (function (TargetNS) {

    $('#Import').on('click', function() {

        // validate dropdown
        var ClassValidation = Core.Form.Validate.ValidateElement($('#ExampleClass'));
        if ( ClassValidation == false ) {
            return false;
        }

        var ImportItem = $('#ExampleClass').val();

        Core.AJAX.FunctionCall(
            Core.Config.Get('CGIHandle'),
            'Action=' + 'AdminITSMConfigItem' + ';Subaction=FileClassList;ExampleFile=' + ImportItem,
            function (Response) {

                if (!Response) {
                    alert(Core.Language.Translate("An error occurred during communication."));
                }

                var ItemList = Response;

                var HTMLString = Core.Template.Render('Agent/ITSMConfigurationManagement/ClassImportConfirm', {
                    'Classes': ItemList.Classes,
                    'Roles': ItemList.Roles,
                });
                var UpdateExistingEntities = $('#UpdateExistingEntities').prop('checked') ? '1' : '0';

                Core.UI.Dialog.ShowDialog({
                    Title: Core.Language.Translate("Overview and Confirmation"),
                    HTML: HTMLString,
                    Modal: true,
                    CloseOnClickOutside: false,
                    CloseOnEscape: false,
                    PositionTop: '20%',
                    PositionLeft: 'Center',
                    AllowAutoGrow: true,
                    Buttons: [
                        {
                            Label: Core.Language.Translate('Confirm'),
                            Type: undefined,
                            Class: 'Confirm CallForAction',
                            Function: function() {

                                var DialogTemplate = Core.Template.Render('Dialog/Waiting', {
                                    Text: Core.Language.Translate("Importing classes/roles and their related fields")
                                });
                                Core.UI.Dialog.ShowDialog({
                                    HTML: DialogTemplate,
                                    Title: "",   // Not applicable if header is hidden
                                    Modal: true,
                                    CloseOnClickOutside: false,
                                    CloseOnEscape: false,
                                    PositionTop: '20%',
                                    PositionLeft: 'Center',
                                    AllowAutoGrow: false,
                                    HideHeader: true,
                                    HideFooter: true
                                });
                                Core.AJAX.FunctionCall(
                                    Core.Config.Get('CGIHandle'),
                                    'Action=' + 'AdminITSMConfigItem' + ';Subaction=ClassImport;ExampleClass=' + ImportItem + ';UpdateExistingEntities=' + UpdateExistingEntities,
                                    function (Response) {
                                        if (!Response || !Response.Success) {
                                            Core.UI.Dialog.ShowAlert(
                                                Core.Language.Translate('An error occurred during class import.'),
                                                Core.Language.Translate( Response.ErrorMessage || 'Class import failed.' ),
                                            );
                                            return false;
                                        }
                                        Core.UI.Dialog.CloseDialog($('.Dialog:visible'));
                                        window.location.reload();
                                    }
                                );
                            },
                        },
                        {
                            Label: Core.Language.Translate('Dismiss'),
                            Type: 'Close',
                        }
                    ]
                });
            },
        );
    });

    Core.Init.RegisterNamespace(TargetNS, 'APP_MODULE');

    return TargetNS;
}(ITSM.Admin.ITSMConfigItem || {}));

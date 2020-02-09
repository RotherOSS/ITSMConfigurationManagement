// --
// OTOBO is a web-based ticketing system for service organisations.
// --
// Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
// Copyright (C) 2019-2020 Rother OSS GmbH, https://otobo.de/
// --
// This program is free software: you can redistribute it and/or modify it under
// the terms of the GNU General Public License as published by the Free Software
// Foundation, either version 3 of the License, or (at your option) any later version.
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
// You should have received a copy of the GNU General Public License
// along with this program. If not, see <https://www.gnu.org/licenses/>.

"use strict";

var ITSM = ITSM || {};
ITSM.Agent = ITSM.Agent || {};
ITSM.Agent.ConfigItem = ITSM.Agent.ConfigItem || {};

/**
 * @namespace ITSM.Agent.ConfigItem.Zoom
 * @memberof ITSM.Agent.ConfigItem
 * @author Rother OSS GmbH
 * @description
 *      This namespace contains the special module functions for the config item add.
 */
ITSM.Agent.ConfigItem.Zoom = (function (TargetNS) {

    /*
    * @name Init
    * @memberof ITSM.Agent.ConfigItem.Zoom
    * @function
    * @description
    *      This function initializes config item zoom section.
    */
    TargetNS.Init = function () {
        var ITSMShowConfirmDialog = Core.Config.Get('ITSMShowConfirmDialog');

        ITSM.Agent.Zoom.Init(Core.Config.Get('UserConfigItemZoomTableHeight'));

        $('ul.Actions a.AsPopup').on('click', function () {
            Core.UI.Popup.OpenPopup($(this).attr('href'), 'Action');
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

        // Initialize allocation list for link object table.
        Core.Agent.TableFilters.SetAllocationList();

        if (ITSMShowConfirmDialog) {
            $.each(ITSMShowConfirmDialog, function(Key, Data) {
                ITSM.Agent.ConfirmDialog.BindConfirmDialog({
                    ElementID:                  Data.MenuID,
                    ElementSelector:            Data.ElementSelector,
                    DialogContentQueryString:   Data.DialogContentQueryString,
                    ConfirmedActionQueryString: Data.ConfirmedActionQueryString,
                    DialogTitle:                Data.DialogTitle,
                    TranslatedText:             {
                        Yes: Core.Language.Translate("Yes"),
                        No:  Core.Language.Translate("No"),
                        Ok:  Core.Language.Translate("Ok")
                    }
                });
            });
        }
    };

    Core.Init.RegisterNamespace(TargetNS, 'APP_MODULE');

    return TargetNS;
}(ITSM.Agent.ConfigItem.Zoom || {}));

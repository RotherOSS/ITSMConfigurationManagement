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
ITSM.Agent = ITSM.Agent || {};
ITSM.Agent.ConfigItem = ITSM.Agent.ConfigItem || {};

/**
 * @namespace ITSM.Agent.ConfigItem.Overview
 * @memberof ITSM.Agent.ConfigItem
 * @author Rother OSS GmbH
 * @description
 *      This namespace contains the special module functions for the config item overview navbar.
 */
ITSM.Agent.ConfigItem.Overview = (function (TargetNS) {

    /*
    * @name Init
    * @memberof ITSM.Agent.ConfigItem.Overview
    * @function
    * @description
    *      This function initializes the overview behaviours.
    */
    TargetNS.Init = function () {
        var ITSMConfigItemSearch    = Core.Config.Get('ITSMConfigItemSearch');
        var ITSMConfigItemActionRow = Core.Config.Get('ITSMConfigItemActionRow') || {};

        $('#ShowContextSettingsDialog').on('click', function (Event) {
            Core.UI.Dialog.ShowContentDialog($('#ContextSettingsDialogContainer'), Core.Language.Translate("Settings"), '20%', 'Center', true, [
                {
                    Label: Core.Language.Translate("Submit"),
                    Type: 'Submit',
                    Class: 'Primary'
                }
            ]);
            Event.preventDefault();
            Event.stopPropagation();

            return false;
        });

        if (ITSMConfigItemSearch) {
            $('#ITSMConfigItemSearch').on('click', function () {
                ITSM.Agent.ConfigItem.Search.OpenSearchDialog(
                    'AgentITSMConfigItemSearch',
                    Core.App.EscapeSelector(ITSMConfigItemSearch.Profile),
                    Core.App.EscapeSelector(ITSMConfigItemSearch.ClassID)
                );
                return false;
            });
        }

        $.each(ITSMConfigItemActionRow, function(Key, Data) {
            ITSM.UI.ConfigItemActionRow.AddActions($('#ConfigItemID_' + Key), Data);
        });

        ITSM.UI.ConfigItemActionRow.Init();

        Core.UI.InitCheckboxSelection($('table td.Checkbox'));

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
}(ITSM.Agent.ConfigItem.Overview || {}));

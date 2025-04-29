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
 * @namespace ITSM.Agent.ConfigItem.Edit
 * @memberof ITSM.Agent
 * @author Rother OSS GmbH
 * @description
 *      This namespace contains the special module functions for the config item edit.
 */
ITSM.Agent.ConfigItem.Edit = (function (TargetNS) {

    /*
    * @name Init
    * @memberof ITSM.Agent.ConfigItem.Edit
    * @function
    * @description
    *      This function initializes the form submittion.
    */
    TargetNS.Init = function () {
        $('#CancelButton').on('click', function () {
            if (Core.UI.Popup.CurrentIsPopupWindow()) {
                Core.UI.Popup.ClosePopup();
                return false;
            }
        });

        OpenRelevantPages();
        $('form').on('submit', OpenRelevantPages);
    };

    /**
     * @function
     * @description
     *      Opens the details of all pages that contain invalid form input fields or contain a currently focused element.
     */
    function OpenRelevantPages() {
        let $RelevantDetailsOpened = false;
        $('details').each(function () {
            if ($(this).find('.Error').length > 0) {
                $(this).attr('open', true);
                $RelevantDetailsOpened = true;
            }
            else if ($(this).find(':focus').length > 0) {
                $(this).attr('open', true);
                $RelevantDetailsOpened = true;
            }
        });
        if (!$RelevantDetailsOpened) {
            $('details:first-of-type').attr('open', true);
        }
    }

    Core.Init.RegisterNamespace(TargetNS, 'APP_MODULE');

    return TargetNS;
}(ITSM.Agent.ConfigItem.Edit || {}));

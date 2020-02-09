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
        $('#SubmitButton').on('click', function () {
            $('input[name=SubmitSave]').val('1');
        });

        $('#CancelButton').on('click', function () {
            if (Core.UI.Popup.CurrentIsPopupWindow()) {
                Core.UI.Popup.ClosePopup();
                return false;
            }
        });

        $('.DisableValidation').on('click', function () {
            $('input[name=SubmitSave]').val('0');
            Core.Form.Validate.DisableValidation($('#ClassItem'));
            // fix for Safari: race condition with submit in Core.Form.Validate.js
            // fixed in OTOBO 3.0.5, this line remains here for backwards compatibility reasons
            $('#ClassItem').removeClass('PreventMultipleSubmits');
        });

        // Register return key. But not in textareas.
        $('#ClassItem').off('keypress.FilterInput').on('keypress.FilterInput', function (Event) {
            if ((Event.charCode || Event.keyCode) === 13 && ($(Event.target).prop('tagName') !== 'TEXTAREA')) {
                $('#SubmitButton').click();
                return false;
            }
        });
    };

    Core.Init.RegisterNamespace(TargetNS, 'APP_MODULE');

    return TargetNS;
}(ITSM.Agent.ConfigItem.Edit || {}));

// --
// OTOBO is a web-based ticketing system for service organisations.
// --
// Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
// Copyright (C) 2019-2021 Rother OSS GmbH, https://otobo.de/
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

/*eslint-disable no-window*/

"use strict";

var ITSM = ITSM || {};
ITSM.Agent = ITSM.Agent || {};
ITSM.Agent.ConfigItem = ITSM.Agent.ConfigItem || {};

/**
 * @namespace ITSM.Agent.ConfigItem.History
 * @memberof ITSM.Agent.ConfigItem
 * @author Rother OSS GmbH
 * @description
 *      This namespace contains the special module functions for the config item history.
 */
ITSM.Agent.ConfigItem.History = (function (TargetNS) {

    /*
    * @name Init
    * @memberof ITSM.Agent.ConfigItem.History
    * @function
    * @description
    *      This function initializes the popup.
    */
    TargetNS.Init = function () {
        $('a.LinkZoomView').on('click', function () {
            window.opener.Core.UI.Popup.FirePopupEvent('URL', { URL: $(this).attr('href')});
            Core.UI.Popup.ClosePopup();
        });
    };

    Core.Init.RegisterNamespace(TargetNS, 'APP_MODULE');

    return TargetNS;
}(ITSM.Agent.ConfigItem.History || {}));

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
ITSM.Customer.ConfigItem.Zoom = (function (TargetNS) {

    /*
    * @name Init
    * @memberof ITSM.Customer.ConfigItem.Zoom
    * @function
    * @description
    *      This function initializes the overview behaviours.
    */
    TargetNS.Init = function () {
        $('#VersionSelection').on('change', function () {
            var Redirect = $(this).val();
            if ( Redirect ) {
                window.location = Redirect;
            }
        });

        $('#Attachments').on('click', function () {
            $('#AttachmentBox').css(
                'right', $(window).width() - $('#Attachments').offset().left - $('#Attachments').width() - 24
            );
            $('#AttachmentBox').toggle();
        });

        // scroll events
        $(window).scroll( function() {
            // change Header on scroll
            if ( $(window).width() > 767 ) {
                if ( $(window).scrollTop() > 90 && $("#oooHeader").height() > 56 ) {
                    $("#oooHeader").height( '48px' );
                    $("#oooHeader").css( 'padding-top', '8px' );
                    $("#oooHeader").css( 'padding-bottom', '8px' );
                    $("#CIInfoBar").fadeOut(200);
                }
                else if ( $(window).scrollTop() < 8 ) {
                    $("#oooHeader").height( '101px' );
                    $("#oooHeader").css( 'padding-top', '22px' );
                    $("#oooHeader").css( 'padding-bottom', '22px' );
                    $("#CIInfoBar").fadeIn(200);
                }
            }
        });
    };

    Core.Init.RegisterNamespace(TargetNS, 'APP_MODULE');

    return TargetNS;
}(ITSM.Customer.ConfigItem.Zoom || {}));

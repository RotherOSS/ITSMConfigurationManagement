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

    /**
     * @name IframeAutoHeight
     * @memberof ITSM.Customer.ConfigItem.Zoom
     * @function
     * @param {jQueryObject} $Iframe - The iframe which should be auto-heighted
     * @description
     *      Set iframe height automatically based on real content height and hardcoded max height.
     */
    TargetNS.IframeAutoHeight = function ($Iframe) {

        var NewHeight,
            IframeBodyHeight,

            // max height
            DescriptionHeightMax = 1000;

        if (isJQueryObject($Iframe)) {
            IframeBodyHeight = $Iframe.contents().find('body').height();
            NewHeight = $Iframe.contents().height();
            if (!NewHeight || isNaN(NewHeight)) {

                // default height
                NewHeight = 100;
            }
            else {
                if (IframeBodyHeight > DescriptionHeightMax
                    || NewHeight > DescriptionHeightMax) {
                    NewHeight = DescriptionHeightMax;
                }
                else if (IframeBodyHeight > NewHeight) {
                    NewHeight = IframeBodyHeight;
                }
            }

            // add delta for scrollbar
            NewHeight = parseInt(NewHeight, 10) + 25;

            // make sure the minimum height is in line with the avatar images
            if (NewHeight < 46) {
                NewHeight = 46;
            }

            $Iframe.height(NewHeight + 'px');
        }
    };

    Core.Init.RegisterNamespace(TargetNS, 'APP_MODULE');

    return TargetNS;
}(ITSM.Customer.ConfigItem.Zoom || {}));

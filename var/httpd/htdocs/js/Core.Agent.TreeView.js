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

var Core = Core || {};
Core.Agent = Core.Agent || {};

/**
 * @namespace Core.Agent.TreeView
 * @memberof Core.Agent
 * @author Rother OSS GmbH
 * @description
 *      This namespace contains the special module functions for the config item TreeView.
 */
Core.Agent.TreeView = (function (TargetNS) {

    /**
     * @private
     * @name Instance
     * @memberof Core.Agent.Admin.ProcessManagement.Canvas
     * @member {Array}
     * @description
     *      local variable for JSPlumb
     */

    var Instance;

    /*
    * @name Init
    * @memberof Core.Agent.TreeView
    * @function
    * @description
    *      This function initializes the TreeView.
    */

    TargetNS.Init = function () {

        $( document ).ready(function() {
            UpdateTree();
        });

        $("#Depth").bind('keyup mouseup', function () {
            UpdateTree();
        });

        $("#Zoom").bind('keydown mousedown', function () {
            $("#LastZoom").val($("#Zoom").val());
        });

        $("#Zoom").bind('keyup mouseup', function () {
            ZoomInOut();
        });

        $("#TreeViewCloseLink").bind('click', function () {
            window.close();
        });

        window.setZoom = function(zoom, instance, transformOrigin) {

            transformOrigin = transformOrigin || [0.5, 0.5];
            var el = instance.getContainer();

            var p = ["webkit", "moz", "ms", "o"],
              s = "scale(" + zoom + ")",
              oString = (transformOrigin[0] * 100) + "% " + (transformOrigin[1] * 100) + "%";

            for (var i = 0; i < p.length; i++) {
              el.style[p[i] + "Transform"] = s;
              el.style[p[i] + "TransformOrigin"] = oString;
            }

            el.style["transform"] = s;
            el.style["transformOrigin"] = oString;

            instance.setZoom(zoom);
            instance.repaintEverything();
        };

        $(window).resize(function(){
            Instance.repaintEverything();
        });
    };

    /**
    * @private
    * @name ZoomInOut
    * @memberof Core.Agent.TreeView
    * @author Rother OSS GmbH
    * @function
    * @description
    *      Apply Zoom in or Out of the TreeView Graphic.
    */

    function ZoomInOut() {
        window.setZoom(parseInt($("#Zoom").val())/100, Instance, null);
        window.dispatchEvent(new Event('resize'));
        return;
    }

    /**
    * @private
    * @name UpdateTree
    * @memberof Core.Agent.TreeView
    * @author Rother OSS GmbH
    * @function
    * @description
    *      Update TreeView with desired depth level for the selected ConfigItem.
    *      The tree nodes are put into the HTML element 'Canvas'.
    *      Also included in the Canvas are the hidden input fields LinkDataSource and LinkDataTarget
    *      which list the relationship between the nodes.
    */

    function UpdateTree() {
        jsPlumb.reset();
        $('#Canvas').empty();

        let RequestParams = {
            Action:       'AgentITSMConfigItemTreeView',
            Subaction:    'LoadTreeView',
            ConfigItemID: encodeURIComponent($("#ConfigItemID").val()),
            VersionID:    encodeURIComponent($("#VersionID").val()),
            Depth:        encodeURIComponent($("#Depth").val())
        };

        $("#Depth").prop('disabled', true);
        $("#AJAXLoaderDepth").css("display", "block");

        Core.AJAX.FunctionCall(
            Core.Config.Get('CGIHandle'),
            RequestParams,
            function (Response) {
                $("#Canvas").html(Response);

                Instance = jsPlumb.getInstance({
                    PaintStyle: {
                        lineWidth: 0.1,
                        strokeStyle: "#000",
                        outlineColor: "#000",
                        outlineWidth: 0.1
                    },
                    Connector: ["Straight"],
                    anchor: ['Perimeter', {shape: 'Circle'}],
                    Endpoint: ['Dot', {radius: 3}],
                    endpointStyle: {fill: 'rgb(80, 81, 81)'},
                    container: 'Canvas'
                });

                drawConnections( Instance, $("#LinkDataSource").val(), 'Source' );
                drawConnections( Instance, $("#LinkDataTarget").val(), 'Target' );

                $("#AJAXLoaderDepth").css("display", "none");
                $("#Depth").prop('disabled', false);

                if ( parseInt($("#Depth").val()) > parseInt($("#MaxDepth").val()) ) {
                    $("#Depth").val($("#MaxDepth").val());
                    $("#TreeViewMessages").removeClass("Hidden");
                    setTimeout(() => {
                        $("#TreeViewMessages").addClass("Hidden");
                        Instance.repaintEverything();
                    }, 3000);
                }
                else {
                    $("#TreeViewMessages").addClass("Hidden");
                }
                Instance.repaintEverything();
            },
            'html'
        );

        return;
    }

    /**
     * @private
     * @name drawConnections
     * @memberof Core.Agent.TreeeView
     * @author Rother OSS GmbH
     * @function
     * @param {instance}  JsPlumb Instance
     * @param {link_data} link list, separated by semicolon
     * @param {option} Specify Target/Source
     * @description
     *      Write arcs (arrows) between elements in the graphic.
     */

    function drawConnections(instance, link_data, option) {

        // nothing to do when the input is empte
        if (link_data === "") return;

        var Connections    = link_data.split(";");
        var Direction      = option;
        var ShowLinkLabels = $("#ShowLinkLabels").val();

        Connections.forEach(element => {
            var Link = element.split(",");

            let Params = {
                source: Link[1],
                target: Link[0],
                scope: "TreeView",
                anchor: ["Bottom", "Top"],
                parameters: {
                    ConnectionID: Direction + Link[1] + "-" + Link[0] + "-" + Link[2]
                }
            };

            if ( ShowLinkLabels === "Yes" ) {
                Object.assign(Params, {
                    overlays:[
                        [ "Arrow", { width:9, length:10, location: 0.96, id:"arrow" } ],
                        [ "Label", { label: Link[2], location:0.5, id:"Label", style: "background-color: #ffffff" } ]
                    ]
                });
            } else {
                Object.assign(Params, {
                    overlays:[
                        [ "Arrow", { width:9, length:10, location: 0.96, id:"arrow" } ]
                    ]
                });
            }

            // assuming valid input
            instance.connect(Params);
        });

        return;
    }

    Core.Init.RegisterNamespace(TargetNS, 'APP_MODULE');

    return TargetNS;
}(Core.Agent.TreeView || {}));

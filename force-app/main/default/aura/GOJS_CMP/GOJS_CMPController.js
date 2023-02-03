({
    loadJquery : function(component, event, helper) {

            //if (window.goSamples) goSamples();  // init for these samples -- you don't need to call this
            var $ = go.GraphObject.make;
            
            var myDiagram =
                $(go.Diagram, "CMPDiagramDiv",
                  {
                      fixedBounds: new go.Rect(0, 0, 500, 300),  // document is always 500x300 units
                      allowHorizontalScroll: false,  // disallow scrolling or panning
                      allowVerticalScroll: false,
                      allowZoom: false,              // disallow zooming
                      "animationManager.isEnabled": false,
                      "undoManager.isEnabled": true,
                      "ModelChanged": function(e) {     // just for demonstration purposes,
                          if (e.isTransactionFinished) {  // show the model data in the page's TextArea
                              document.getElementById("mySavedModel").textContent = e.model.toJson();
                          }
                      }
                  });
            
            // the background Part showing the fixed bounds of the diagram contents
            myDiagram.add(
                $(go.Part,
                  { layerName: "Grid", position: myDiagram.fixedBounds.position },
                  $(go.Shape, { fill: "oldlace", strokeWidth: 0, desiredSize: myDiagram.fixedBounds.size })
                 ));
            
            // this function is the Node.dragComputation, to limit the movement of the parts
            function stayInFixedArea(part, pt, gridpt) {
                var diagram = part.diagram;
                if (diagram === null) return pt;
                // compute the document area without padding
                var v = diagram.documentBounds.copy();
                v.subtractMargin(diagram.padding);
                // get the bounds of the part being dragged
                var b = part.actualBounds;
                var loc = part.location;
                // now limit the location appropriately
                var x = Math.max(v.x, Math.min(pt.x, v.right - b.width)) + (loc.x - b.x);
                var y = Math.max(v.y, Math.min(pt.y, v.bottom - b.height)) + (loc.y - b.y);
                return new go.Point(x, y);
            }
            
            myDiagram.nodeTemplate =
                $(go.Node, "Auto",
                  { dragComputation: stayInFixedArea },
                  // get the size from the model data
                  new go.Binding("desiredSize", "size", go.Size.parse),
                  // get and set the position in the model data
                  new go.Binding("position", "pos", go.Point.parse).makeTwoWay(go.Point.stringify),
                  // temporarily put selected nodes in Foreground layer
                  new go.Binding("layerName", "isSelected", function(s) { return s ? "Foreground" : ""; }).ofObject(),
                  $(go.Shape, "Rectangle",
                    { strokeWidth: 0 },  // avoid extra thickness from the stroke
                    new go.Binding("fill", "color")),
                  $(go.TextBlock,
                    new go.Binding("text", "color"))
                 );
            
            myDiagram.model = new go.GraphLinksModel([
                { "key": "Alpha", "pos": "0 0", "size": "50 50", "color": "lightblue" },
                { "key": "Beta", "pos": "276 19", "size": "100 100", "color": "orange" },
                { "key": "Gamma", "pos": "44 214", "size": "100 50", "color": "lightgreen" },
                { "key": "Delta", "pos": "239 171", "size": "50 100", "color": "pink" }
            ],
                                                     [
                                                         { from: "Alpha", to: "Beta" },
                                                         { from: "Alpha", to: "Gamma" },
                                                         { from: "Gamma", to: "Delta" },
                                                         { from: "Delta", to: "Alpha" }
                                                     ]);
        }
    
})
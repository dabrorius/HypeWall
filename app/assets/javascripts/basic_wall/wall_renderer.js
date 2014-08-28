$(document).ready(function(){// Get the canvas element from our HTML above
  var canvas = document.getElementById("renderCanvas");

  // Load the BABYLON 3D engine
  var engine = new BABYLON.Engine(canvas, true);

  var createScene = function () {
    // Now create a basic Babylon Scene object 
    var scene = new BABYLON.Scene(engine);

    // This creates and positions a free camera
    var camera = new BABYLON.FreeCamera("camera1", new BABYLON.Vector3(0, 0, -10), scene);
    camera.setTarget(new BABYLON.Vector3.Zero());
    camera.attachControl(canvas, false);

    // This creates a light, aiming 0,1,0 - to the sky.
    var light = new BABYLON.HemisphericLight("light1", new BABYLON.Vector3(0, 1, 0), scene);
    light.intensity = 1;

    // Create image
    var u1 = new Frame("/ultra/1.jpg", scene);
    u1.moveToPosition(-2);
    var u1 = new Frame("/ultra/2.jpg", scene);
    u1.moveToPosition(-1);
    var u1 = new Frame("/ultra/3.jpg", scene);
    u1.moveToPosition(0);
    var u1 = new Frame("/ultra/4.jpg", scene);
    u1.moveToPosition(1);
    var u1 = new Frame("/ultra/5.jpg", scene);
    u1.moveToPosition(2);
    // Leave this function
    return scene;
  };  // End of createScene function

  var scene = createScene();

  // Register a render loop to repeatedly render the scene
  engine.runRenderLoop(function () {
    scene.render();
  });

   // Watch for browser/canvas resize events
  window.addEventListener("resize", function () {
    engine.resize();
  });
});
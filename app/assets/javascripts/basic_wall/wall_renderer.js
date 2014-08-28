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
    u1.moveToPosition(-3);
    var u2 = new Frame("/ultra/2.jpg", scene);
    u2.moveToPosition(-2);
    var u3 = new Frame("/ultra/3.jpg", scene);
    u3.moveToPosition(-1);
    var u4 = new Frame("/ultra/4.jpg", scene);
    u4.moveToPosition(0);
    var u5 = new Frame("/ultra/5.jpg", scene);
    u5.moveToPosition(1);
    var u6 = new Frame("/ultra/6.jpg", scene);
    u6.moveToPosition(2);
    var u7 = new Frame("/ultra/7.jpg", scene);
    u7.moveToPosition(3);
    // Leave this function

    window.setInterval(function(){
      u1.moveToNextPosition()
      u2.moveToNextPosition()
      u3.moveToNextPosition()
      u4.moveToNextPosition()
      u5.moveToNextPosition()
      u6.moveToNextPosition()
      u7.moveToNextPosition()
    }, 4000);
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
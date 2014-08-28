$(document).ready(function(){// Get the canvas element from our HTML above
  var canvas = document.getElementById("renderCanvas");

  // Load the BABYLON 3D engine
  var engine = new BABYLON.Engine(canvas, true);

  var createScene = function () {

    // Now create a basic Babylon Scene object 
    var scene = new BABYLON.Scene(engine);

    // This creates and positions a free camera
    var camera = new BABYLON.FreeCamera("camera1", new BABYLON.Vector3(0, 0, -10), scene);

    // This targets the camera to scene origin
    camera.setTarget(new BABYLON.Vector3.Zero());

    // This attaches the camera to the canvas
    camera.attachControl(canvas, false);

    // This creates a light, aiming 0,1,0 - to the sky.
    var light = new BABYLON.HemisphericLight("light1", new BABYLON.Vector3(0, 1, 0), scene);

    // Dim the light a small amount
    light.intensity = 1;

    var plane = BABYLON.Mesh.CreatePlane("plane", 10.0, scene);
    plane.position.z = 10;

    var planeMaterial = new BABYLON.StandardMaterial("texture1", scene);
    plane.material = planeMaterial;
    // planeMaterial.diffuseColor = new BABYLON.Color3(1.0, 0.2, 0.7);
    planeMaterial.diffuseTexture = new BABYLON.Texture("/ultra/1.jpg", scene);

    // Animating it
    var animation = new BABYLON.Animation(
      "tutoAnimation",
      "rotation.x",
      30,
      BABYLON.Animation.ANIMATIONTYPE_FLOAT,
      BABYLON.Animation.ANIMATIONLOOPMODE_CYCLE);

    var keys = [];  

    //At the animation key 0, the value of scaling is "1"
    keys.push({
        frame: 0,
        value: 0
    });

    //At the animation key 20, the value of scaling is "0.2"
    keys.push({
        frame: 20,
        value: -0.4
    });

    //At the animation key 100, the value of scaling is "1"
    keys.push({
        frame: 45,
        value: 0.7
    });

    keys.push({
        frame: 70,
        value: 0
    });


    animation.setKeys(keys);
    plane.animations.push(animation);

    scene.beginAnimation(plane, 0, 100, true);

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
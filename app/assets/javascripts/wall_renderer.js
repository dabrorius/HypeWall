$(document).ready(function(){// Get the canvas element from our HTML above
  var canvas = document.getElementById("renderCanvas");

  // Load the BABYLON 3D engine
  var engine = new BABYLON.Engine(canvas, true);

  var moveTo = function(image, scene, newX, newZ, newRotation) {
    var positionAnimation = new BABYLON.Animation(
      "tutoAnimation", "position", 15,
      BABYLON.Animation.ANIMATIONTYPE_VECTOR3,
      BABYLON.Animation.ANIMATIONLOOPMODE_CONSTANT);
    positionAnimation.setKeys([
      { frame: 0, value: image.position }, 
      { frame: 10, value: new BABYLON.Vector3(newX,0,newZ) }
    ]);
    image.animations.push(positionAnimation);

    var rotationAnimation = new BABYLON.Animation(
      "tutoAnimation", "rotation.y", 15,
      BABYLON.Animation.ANIMATIONTYPE_FLOAT,
      BABYLON.Animation.ANIMATIONLOOPMODE_CONSTANT);
    rotationAnimation.setKeys([
      { frame: 0, value: image.rotation.y },
      { frame: 10, value: newRotation }
    ]);
    image.animations.push(rotationAnimation);

    scene.beginAnimation(image, 0, 15, true);
  }

  var createImage = function(url, scene) {
    var newImage = BABYLON.Mesh.CreatePlane("newImage", 10.0, scene);
    newImage.position.z = 10;
    var planeMaterial = new BABYLON.StandardMaterial("texture1", scene);
    newImage.material = planeMaterial;
    // planeMaterial.diffuseColor = new BABYLON.Color3(1.0, 0.2, 0.7);
    newImage.material.diffuseTexture = new BABYLON.Texture(url, scene);
    return newImage;
  }

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
    var plane = createImage("/ultra/1.jpg", scene);
    moveTo(plane, scene, 15, 20, -1);

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
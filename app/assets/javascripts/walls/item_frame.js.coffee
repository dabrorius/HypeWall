class @ItemFrame
  constructor: (scene) ->
    @scene = scene
    @mesh = BABYLON.Mesh.CreatePlane("Frame", 5, scene)
    @mesh.material = new BABYLON.StandardMaterial

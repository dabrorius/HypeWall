class @Animations
  @createAlphaAnimation: ->
    new BABYLON.Animation( 
        "pAnim", "material.alpha", 15,
        BABYLON.Animation.ANIMATIONTYPE_FLOAT,
        BABYLON.Animation.ANIMATIONLOOPMODE_CONSTANT )
/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_hub_allies_lighting.gsc
**********************************************/

func_00F9() {
  thread func_6B82();
}

func_6B82() {
  level endon("game_ended");
  for(;;) {
    level waittill("player_spawned", var_00);
    var_00 vignettesetparams(level.var_A4B5["intensity"], level.var_A4B5["falloff"], level.var_A4B5["scaleX"], level.var_A4B5["scaleY"], level.var_A4B5["squareAspectRatio"]);
    var_00 setscriptmotionblurparams(level.var_6465["velocityscaler"], level.var_6465["cameraRotationInfluence"], level.var_6465["cameraTranslationInfluence"]);
  }
}
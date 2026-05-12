/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_hub_allies_slim.gsc
*********************************************/

func_00F9() {
  level.var_A1FE = getdvarint("4476", 0) != 0;
  level.var_A220 = level.var_A1FE;
  level.var_A259 = 1;
  maps\mp\gametypes\_hub_stats::func_4F3E();
  lib_04AE::func_F9();
  lib_0416::func_F9();
  lib_04AD::func_F9();
  maps\mp\_load::func_F9();
  maps\mp\mp_hub_allies_lighting::func_F9();
  maps\mp\mp_hub_allies_aud::func_F9();
  maps\mp\_compass::func_8A2F("");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.var_A4B5["intensity"] = 0.2;
  level.var_A4B5["falloff"] = 1.2;
  level.var_A4B5["scaleX"] = 1;
  level.var_A4B5["scaleY"] = 1;
  level.var_A4B5["squareAspectRatio"] = 0;
  level.var_A4B5["lerpDuration"] = 0.1;
  level.var_A4BE["intensity"] = 0.5;
  level.var_A4BE["falloff"] = 1.2;
  level.var_A4BE["scaleX"] = 1;
  level.var_A4BE["scaleY"] = 1;
  level.var_A4BE["squareAspectRatio"] = 0;
  level.var_A4BE["lerpDuration"] = 0.4;
  level.var_6465["velocityscaler"] = 0;
  level.var_6465["cameraRotationInfluence"] = 0;
  level.var_6465["cameraTranslationInfluence"] = 0;
  setDvar("4135", "allies");
  level.var_ACBC = undefined;
  level.var_ACBA = undefined;
  level.var_ACC0 = undefined;
  level.var_ACBD = undefined;
  level.var_ACBB = undefined;
  level.var_ACBF = undefined;
  thread spawnspecialqmlighting();
  thread spawnspecialeventents();
  maps\mp\mp_hub_allies::func_897E();
}

spawnspecialqmlighting() {
  level endon("game_ended");
  level waittill("connected", var_00);
  var_00 endon("disconnect");
  wait(3);
  if(getdvarint("spv_hub_special_qm", 0) == 1) {
    var_01 = spawn("script_model", (-13312, -2992, 216));
    var_01.var_1D = (348.993, 246.801, 110.334);
    var_01 setModel("tag_origin");
    playFXOnTag(level.var_611["quartermaster_rim"], var_01, "tag_origin");
    var_02 = spawn("script_model", (-13029.8, -2966.69, 200));
    var_02.var_1D = (1.5344, 15.2113, 82.9237);
    var_02 setModel("tag_origin");
    playFXOnTag(level.var_611["quartermaster_kick"], var_02, "tag_origin");
  }
}

spawnspecialeventents() {
  if(getdvarint("spv_hub_st_patricks_event_enabled", 0) == 1) {
    var_00 = spawn("script_model", (-23398.9, -3078.1, -267.2));
    var_00 setModel("hub_theme_st_patricks_15");
    var_01 = spawn("script_model", (-23398.9, -3078.1, -267.2));
    var_01 setModel("hub_theme_st_patricks_16");
    var_02 = spawn("script_model", (496.5, 988.1, -14));
    var_02 setModel("hub_theme_st_patricks_03");
    var_02.var_1D = (0.564662, 359.989, -1.12971);
    var_03 = spawn("script_model", (-23397.5, -3983.5, -31.5));
    var_03 setModel("shamrock_flag_phys");
    var_03.var_1D = (0, 90, 0);
    var_04 = spawn("script_model", (-23270, -4112.5, 48));
    var_04 setModel("ireland_flag_phys");
    var_04.var_1D = (0, 90, 0);
  }
}
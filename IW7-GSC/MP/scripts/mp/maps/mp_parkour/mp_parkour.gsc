/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_parkour\mp_parkour.gsc
*****************************************************/

main() {
  scripts\mp\maps\mp_parkour\mp_parkour_precache::main();
  scripts\mp\maps\mp_parkour\gen\mp_parkour_art::main();
  scripts\mp\maps\mp_parkour\mp_parkour_fx::main();
  scripts\mp\load::main();
  level._id_C7B3 = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_parkour");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  setDvar("r_tessellationCutoffFalloffBase", 600);
  setDvar("r_tessellationCutoffDistanceBase", 2000);
  setDvar("r_tessellationCutoffFalloff", 600);
  setDvar("r_tessellationCutoffDistance", 2000);
  setDvar("r_umbraAccurateOcclusionThreshold", 1200);
  setDvar("r_umbraMinObjectContribution", 6);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread _id_90EF("dropship", "dropThrust");
  thread scripts\mp\animation_suite::animationsuite();
  thread _id_CDA4("mp_parkour_rules");
  thread fix_collision();
}

fix_collision() {
  var_0 = getEnt("player512x512x8", "targetname");
  var_1 = spawn("script_model", (-1152, 1656, 768));
  var_1.angles = (0, 315, -90);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("player32x32x8", "targetname");
  var_3 = spawn("script_model", (-652, 3340, -26));
  var_3.angles = (285, 315, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getEnt("player32x32x8", "targetname");
  var_5 = spawn("script_model", (-795, 2944, -28));
  var_5.angles = (286, 0, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getEnt("player512x512x8", "targetname");
  var_7 = spawn("script_model", (864, 152, 832));
  var_7.angles = (0, 45, -90);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = spawn("script_model", (-318, 642.5, 280));
  var_8.angles = (90, 315, -90);
  var_8 setModel("panel_metal_03_16x208");
}

_id_90EF(var_0, var_1) {
  var_2 = getEnt(var_0, "targetname");
  var_2.startpos = var_2.origin;
  var_2._id_10D6C = var_2.angles;
  var_2._id_BE10 = getEntArray(var_1, "targetname");
  var_2._id_BE1E = getEntArray("vfx_drop_ship_thrusters", "script_noteworthy");
  var_2._id_BE10 = scripts\engine\utility::array_combine(var_2._id_BE10, var_2._id_BE1E);

  foreach(var_4 in var_2._id_BE10) {
    var_4 linkTo(var_2);
  }

  thread _id_5EE7(var_2);
  thread _id_5EE1(var_2);
  thread _id_5EE9(var_2);
}

_id_5EE1(var_0) {
  for(;;) {
    var_1 = randomintrange(4, 10);
    var_0.goalpos = var_0.startpos + (randomintrange(-16, 16), randomintrange(-16, 16), randomintrange(-8, 32));
    var_0 moveTo(var_0.goalpos, var_1, var_1 * 0.25, var_1 * 0.25);
    wait(var_1);
  }
}

_id_5EE9(var_0) {
  for(;;) {
    var_1 = randomintrange(5, 8);
    var_0._id_8433 = var_0._id_10D6C + (randomintrange(-5, 0), randomintrange(-3, 3), randomintrange(-4, 4));
    var_0 rotateTo(var_0._id_8433, var_1, var_1 * 0.25, var_1 * 0.25);
    wait(var_1);
  }
}

_id_5EE7(var_0) {
  foreach(var_2 in var_0._id_BE1E) {
    var_2 thread _id_5EE8();
  }
}

_id_5EE8() {
  wait 5;
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 show();
  var_0 linkTo(self);
  scripts\engine\utility::waitframe();

  if(isDefined(self.targetname)) {
    playFXOnTag(scripts\engine\utility::getfx(self.targetname), var_0, "tag_origin");
  }
}

_id_CDA4(var_0) {
  level scripts\engine\utility::waittill_either("allRigsBooted", "prematch_done");
  playcinematicforalllooping(var_0);
}
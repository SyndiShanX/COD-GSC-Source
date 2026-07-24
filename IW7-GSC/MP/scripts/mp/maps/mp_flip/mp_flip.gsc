/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_flip\mp_flip.gsc
***********************************************/

main() {
  scripts\mp\maps\mp_flip\mp_flip_precache::main();
  scripts\mp\maps\mp_flip\gen\mp_flip_art::main();
  scripts\mp\maps\mp_flip\mp_flip_fx::main();
  scripts\mp\load::main();
  level._id_C7B3 = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_flip");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("pmovePerfSkipWorldUpVolumeCheck", 0);
  setDvar("deploy_allowInWater", 1);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread scripts\mp\animation_suite::animationsuite();
  thread _id_CDA4("mp_flip_screen");
  thread rotatefans();
  var_0 = getEntArray("floatingJackal", "targetname");

  foreach(var_2 in var_0)
  thread _id_90EF(var_2);

  thread fix_via_models();
  thread runmodespecifictriggers();
}

runmodespecifictriggers() {
  if(level.gametype == "ball" || level.gametype == "tdef") {
    wait 1;
    var_0 = spawn("trigger_radius", (532, -48, 16), 0, 32, 52);
    var_0.targetname = "uplink_nozone";
    var_0 hide();
    level.nozonetriggers[level.nozonetriggers.size] = var_0;
  }
}

fix_via_models() {
  _id_107CC("p7_picture_frame_modern_01_mp_flip_patch", (-840, 691.5, 92), (0, 270, 0));
  _id_107CC("p7_picture_frame_modern_01_mp_flip_patch", (-796, 691.5, 92), (0, 270, 0));
  _id_107CC("p7_picture_frame_modern_01_mp_flip_patch", (-696, 691.5, 92), (0, 270, 0));
  _id_107CC("p7_picture_frame_modern_01_mp_flip_patch", (-652, 691.5, 92), (0, 270, 0));
}

_id_107CC(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_1);
  var_3 setModel(var_0);
  var_3.angles = var_2;
}

_id_CDA4(var_0) {
  wait 30;
  playcinematicforalllooping(var_0);
}

_id_90EF(var_0) {
  var_0.startpos = var_0.origin;
  var_0._id_10D6C = var_0.angles;
  thread _id_5EE1(var_0);
  thread _id_5EE9(var_0);
}

_id_5EE1(var_0) {
  var_1 = 1;

  for(;;) {
    var_2 = randomintrange(6, 13);
    var_0.goalpos = var_0.startpos + (randomintrange(-16, 16), randomintrange(-16, 16), var_1 * randomintrange(4, 16));
    var_0 moveTo(var_0.goalpos, var_2, var_2 * 0.4, var_2 * 0.4);
    var_1 = var_1 * -1;
    wait(var_2);
  }
}

_id_5EE9(var_0) {
  var_1 = 1;

  for(;;) {
    var_2 = randomintrange(7, 10);
    var_0._id_8433 = var_0._id_10D6C + (var_1 * randomintrange(1, 3), randomintrange(-2, 2), randomintrange(-3, 3));
    var_0 rotateTo(var_0._id_8433, var_2, var_2 * 0.4, var_2 * 0.4);
    var_1 = var_1 * -1;
    wait(var_2);
  }
}

_id_5EE7(var_0) {
  foreach(var_2 in var_0._id_BE1E)
  var_2 thread _id_5EE8();
}

_id_5EE8() {
  wait 5;
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 show();
  var_0 linkTo(self);
  scripts\engine\utility::waitframe();

  if(isDefined(self.targetname))
    playFXOnTag(scripts\engine\utility::getfx(self.targetname), var_0, "tag_origin");
}

rotatefans() {
  var_0 = getEntArray("rotating_fan", "targetname");

  foreach(var_2 in var_0) {
    var_3 = 3 + randomint(8);
    var_2 thread _id_E72B(var_3);
  }
}

_id_E72B(var_0) {
  level endon("game_ended");
  var_1 = "roll";

  if(isDefined(self.script_noteworthy))
    var_1 = self.script_noteworthy;

  var_2 = "Custom rotation axis must be one of yaw/pitch/roll";

  for(;;) {
    if(var_1 == "yaw")
      self rotateYaw(360, var_0, 0, 0);
    else if(var_1 == "pitch")
      self rotatepitch(360, var_0, 0, 0);
    else if(var_1 == "roll")
      self rotateroll(360, var_0, 0, 0);

    wait(var_0);
  }
}
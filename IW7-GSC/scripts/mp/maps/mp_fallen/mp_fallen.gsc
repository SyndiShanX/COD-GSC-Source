/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_fallen\mp_fallen.gsc
***************************************************/

main() {
  scripts\mp\maps\mp_fallen\mp_fallen_precache::main();
  scripts\mp\maps\mp_fallen\gen\mp_fallen_art::main();
  scripts\mp\maps\mp_fallen\mp_fallen_fx::main();
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("compass_map_mp_fallen");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread _id_F9BA();
  thread _id_CBF3();
  level._id_C7B3 = getEntArray("OutOfBounds", "targetname");
  thread scripts\mp\animation_suite::animationsuite();
  thread _id_C853();
}

_id_C853() {
  level endon("game_ended");
  wait 0.2;
  var_0 = spawn("script_origin", (1583, 253, 988));
  var_0 playLoopSound("amb_mp_fallen_pa_amb");
}

_id_CBF3() {
  var_0 = scripts\engine\utility::getStruct("pitching_machine", "script_noteworthy");

  if(isDefined(var_0)) {
    var_0 thread _id_CBF1();
  }
}

_id_CBF1() {
  level endon("game_ended");
  precachemodel("baseball_single_fn_01_dyn");
  level waittill("connected", var_0);
  var_1 = _id_CBF0();
  var_2 = getEntArray("pitching_wheel", "script_noteworthy");

  foreach(var_4 in var_2) {
    var_4.physicsactivated = 0;
  }

  for(;;) {
    for(var_6 = 0; var_6 < 5; var_6++) {
      wait 5;
      var_1[var_6] notify("pitching_machine_ball_reset");
      thread _id_CBF2(var_1[var_6]);
    }
  }
}

_id_CBF0() {
  var_0 = [];

  for(var_1 = 0; var_1 < 5; var_1++) {
    var_0[var_1] = _id_CBF4();
  }

  return var_0;
}

_id_CBF4() {
  var_0 = spawn("script_model", self.origin);
  var_0 setModel("baseball_single_fn_01_dyn");
  var_0._id_9037 = spawn("trigger_radius", self.origin, 0, 40, 40);
  var_0._id_9037 enablelinkTo();
  var_0._id_9037 linkTo(var_0);
  var_0 hide();
  return var_0;
}

_id_CBF2(var_0) {
  var_0.physicsactivated = 0;
  var_0 hide();
  var_0.origin = self.origin;
  var_1 = anglesToForward(self.angles);
  var_2 = (2000 + randomint(500)) * var_1;
  scripts\engine\utility::waitframe();
  var_0 show();
  var_0 thread _id_139A8();
  var_0 thread _id_139A9();
  var_0 physicslaunchserver(self.origin, var_2);
  var_0.physicsactivated = 1;
}

_id_139A9() {
  self endon("death");
  wait 1;
  self notify("ball_initial_pitch_over");
}

_id_139A8() {
  self endon("death");
  self endon("ball_initial_pitch_over");

  for(;;) {
    self._id_9037 waittill("trigger", var_0);

    if(isPlayer(var_0) && scripts\mp\utility::isreallyalive(var_0)) {
      var_0 dodamage(35, self.origin, self, self, "MOD_IMPACT");
      thread _id_10830(self.origin);
      break;
    }
  }
}

_id_10830(var_0) {
  self hide();
  var_1 = spawn("script_model", var_0);
  var_1 setModel("baseball_single_fn_01_dyn");
  var_1.physicsactivated = 1;
  var_2 = (0, 0, 0);
  var_1 physicslaunchserver(var_0, var_2);
  self waittill("pitching_machine_ball_reset");
  var_1 delete();
}

_id_10A0E(var_0, var_1) {
  var_2 = getEnt(var_0, "targetname");

  for(;;) {
    var_2 rotatepitch(-360, var_1, 0, 0);
    wait 1;
  }
}

_id_F9BA() {
  level._id_A582 = 600;
  level._id_A583 = 1200;
  level._id_BF47 = -1.0;
  var_0 = getEntArray("beer_keg", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread _id_13957();
  }
}

_id_13957() {
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(!issubstr(var_4, "BULLET")) {
      continue;
    }
    if(!_id_3827()) {
      continue;
    }
    var_5 = _id_7A63(var_1, var_2, var_3);

    if(!isDefined(var_5)) {
      continue;
    }
    _id_B27C();
    var_5 = vectortoangles(var_5);
    playFX(level._effect["vfx_imp_sm_beer_pallet"], var_3, anglesToForward(var_5), anglestoup(var_5));
    playFX(level._effect["vfx_fallen_beer_stream"], var_3, anglesToForward(var_5), anglestoup(var_5));
    playsoundatpos(var_3, "emt_beer_puncture");
  }
}

_id_7A63(var_0, var_1, var_2) {
  var_3 = var_0.origin;
  var_4 = var_2 - var_3;
  var_5 = bulletTrace(var_3, var_3 + 1.5 * var_4, 0, var_0, 0);

  if(isDefined(var_5["normal"]) && isDefined(var_5["entity"]) && var_5["entity"] == self) {
    return var_5["normal"];
  }

  return undefined;
}

_id_3827() {
  if(gettime() < level._id_BF47) {
    return 0;
  }

  return 1;
}

_id_B27C() {
  level._id_BF47 = gettime() + randomfloatrange(level._id_A582, level._id_A583);
}
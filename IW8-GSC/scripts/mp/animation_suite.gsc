/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\animation_suite.gsc
***********************************************/

function animationsuite() {
  while(!istrue(game["gamestarted"])) {
    waitframe();
  }

  var_0 = getEntArray("animObj", "targetname");
  var_1 = gathergroups(var_0);
  setupvfxobjs(var_0);
  setupsfxobjs(var_0);

  foreach(var_3 in var_0) {
    if(scripts\cp_mp\utility\game_utility::islargemap()) {
      var_3 unmarkkeyframedmover(1);
    }

    if(isDefined(var_3.script_animation_type)) {
      switch (var_3.script_animation_type) {
        case "rotation_continuous":
        case "rotation_pingpong":
          thread animsuite_rotation(var_3);
          break;
        case "translation_once":
        case "translation_pingpong":
          thread animsuite_translation(var_3);
          break;
      }
    }
  }
}

function setupvfxobjs(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy) && scripts\engine\utility::string_starts_with(var_2.script_noteworthy, "vfx_")) {
      var_3 = var_2 scripts\engine\utility::spawn_tag_origin();
      var_3 show();
      var_3 linkTo(var_2);
      waitframe();

      if(!van_stop_vo("setupVFXObjs(): obj", var_2)) {
        continue;
      }

      if(!van_stop_vo("setupVFXObjs(): model", var_3)) {
        continue;
      }

      thread delayfxcall(scripts\engine\utility::getfx(var_2.script_noteworthy), var_3, "tag_origin");
    }
  }
}

function delayfxcall(var_0, var_1, var_2) {
  wait 5;

  if(!van_stop_vo("delayFXCall()", var_1)) {
    return;
  }

  playFXOnTag(var_0, var_1, var_2);
}

function setupsfxobjs(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy) && scripts\engine\utility::string_starts_with(var_2.script_noteworthy, "sfx_")) {
      var_2 setModel("tag_origin");
      var_2 thread scripts\engine\utility::play_loop_sound_on_entity("mp_quarry_lg_crane_loop");
    }
  }
}

function debug_temp_sphere() {
  for(;;) {
    scripts\mp\utility\debug::drawsphere(self.origin, 32, 0.1, (0, 0, 255));
    wait 0.1;
  }
}

function gathergroups(var_0) {
  var_1 = [];
  var_2 = [];

  foreach(var_4 in var_0) {
    if(isDefined(var_4.script_noteworthy) && issubstr(var_4.script_noteworthy, "group")) {
      var_1 = scripts\engine\utility::array_add(var_1, var_4);
    }
  }

  foreach(var_7 in var_1) {
    if(!isDefined(var_2[var_7.script_noteworthy])) {
      var_2 = [var_7];
      continue;
    }

    var_2 = scripts\engine\utility::array_add(var_2[var_7.script_noteworthy], var_7);
  }

  foreach(var_10 in var_2) {
    var_11 = animsuite_getparentobject(var_10);
    animsuite_linkchildrentoparentobject(var_11, var_10);
  }

  return var_2;
}

function animsuite_getparentobject(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_linkname)) {
      return var_2;
    }
  }
}

function animsuite_linkchildrentoparentobject(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(var_3 == var_0) {
        continue;
      }

      var_3 linkTo(var_0);
    }

    return;
  }
}

function animsuite_translation(var_0) {
  if(issubstr(var_0, "pingpong")) {
    thread animsuite_translation_pingpong();
  }

  if(issubstr(var_0, "once")) {
    thread animsuite_translation_once();
    return;
  }
}

function animsuite_translation_pingpong() {
  level endon("game_ended");
  var_0 = (0, 90, 0);
  var_1 = 5;
  var_2 = 0.5;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  if(isDefined(self.script_translation_amount)) {
    var_0 = self.script_translation_amount;
  }

  if(isDefined(self.script_translation_time)) {
    var_1 = self.script_translation_time;
  }

  jumpiffalse(isDefined(self.script_audio_parameters)) LOC_00000098;

  if(issubstr(self.script_audio_parameters, "start")) {
    var_3 = "mp_quarry_lg_crane_start";
  }

  if(issubstr(self.script_audio_parameters, "stop")) {
    var_4 = "mp_quarry_lg_crane_stop";
  }

  jumpiffalse(issubstr(self.script_audio_parameters, "loop")) LOC_00000098;
  var_5 = "mp_quarry_lg_crane_loop";

  for(;;) {
    var_6 = self.origin;
    self moveTo(self.origin + var_0, var_1[0], var_1[1], var_1[2]);

    if(isDefined(var_4)) {
      thread animsuite_playthreadedsound(var_1[0], var_4);
    }

    wait var_1[0] + var_2;

    if(!van_stop_vo("animSuite_Translation_PingPong()", self)) {
      return;
    }

    if(isDefined(var_3)) {
      playsoundatpos(self.origin, var_3);
    }

    self moveTo(var_6, var_1[0], var_1[1], var_1[2]);

    if(isDefined(var_4)) {
      thread animsuite_playthreadedsound(var_1[0], var_4);
    }

    wait var_1[0] + var_2;

    if(!van_stop_vo("animSuite_Translation_PingPong()", self)) {
      return;
    }

    if(isDefined(var_3)) {
      playsoundatpos(self.origin, var_3);
    }
  }
}

function animsuite_playthreadedsound(var_0, var_1) {
  wait var_0;

  if(!van_stop_vo("animSuite_playThreadedSound()", self)) {
    return;
  }

  playsoundatpos(self.origin, var_1);
}

function animsuite_translation_once() {
  level endon("game_ended");
  var_0 = (0, 90, 0);
  var_1 = 5;

  if(isDefined(self.script_translation_amount)) {
    var_0 = self.script_translation_amount;
  }

  if(isDefined(self.script_translation_time)) {
    var_1 = length(self.script_translation_time);
  }

  for(;;) {
    self rotateby(var_0, var_1, 0, 0);
    wait var_1;

    if(!van_stop_vo("animSuite_Translation_Once()", self)) {
      return;
    }
  }
}

function animsuite_rotation(var_0) {
  if(issubstr(var_0, "pingpong")) {
    thread animsuite_rotation_pingpong();
  }

  if(issubstr(var_0, "continuous")) {
    thread animsuite_rotation_continuous();
    return;
  }
}

function animsuite_rotation_pingpong() {
  level endon("game_ended");
  var_0 = (0, 90, 0);
  var_1 = (5, 0, 0);
  var_2 = 0;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  if(isDefined(self.script_rotation_amount)) {
    var_0 = self.script_rotation_amount;
  }

  if(isDefined(self.script_rotation_speed)) {
    var_1 = self.script_rotation_speed;
  }

  for(;;) {
    self rotateby(var_0, var_1[0], var_1[1], var_1[2]);

    if(isDefined(var_4)) {
      thread animsuite_playthreadedsound(var_1[0] * 0.9, var_4);
    }

    wait var_1[0] + var_2;

    if(!van_stop_vo("animSuite_Rotation_PingPong()", self)) {
      return;
    }

    if(isDefined(var_3)) {
      playsoundatpos(self.origin, var_3);
    }

    self rotateby(var_0 * -1, var_1[0], var_1[1], var_1[2]);

    if(isDefined(var_4)) {
      thread animsuite_playthreadedsound(var_1[0] * 0.9, var_4);
    }

    wait var_1[0] + var_2;

    if(!van_stop_vo("animSuite_Rotation_PingPong()", self)) {
      return;
    }

    if(isDefined(var_3)) {
      playsoundatpos(self.origin, var_3);
    }
  }
}

function animsuite_rotation_continuous() {
  level endon("game_ended");
  var_0 = (0, 90, 0);
  var_1 = (5, 0, 0);
  var_2 = 0.5;

  if(isDefined(self.script_rotation_amount)) {
    var_0 = self.script_rotation_amount;
  }

  if(isDefined(self.script_rotation_speed)) {
    var_1 = self.script_rotation_speed;
  }

  if(isDefined(self.target)) {
    var_3 = getEnt(self.target, "targetname");

    if(isDefined(var_3) && var_3.classname == "script_brushmodel") {
      var_3 linkTo(self);
    }
  }

  for(;;) {
    self rotateby(var_0, var_1[0], var_1[1], var_1[2]);
    wait var_1[0];

    if(!van_stop_vo("animSuite_Rotation_Continuous()", self)) {
      return;
    }
  }
}

function van_stop_vo(var_0, var_1) {
  if(!isDefined(var_1)) {
    return false;
  }

  return true;
}
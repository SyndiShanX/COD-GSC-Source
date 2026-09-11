/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\animation_suite.gsc
***********************************************/

function animationsuite() {
  while(!istrue(game["gamestarted"])) {
    waitframe();
  }

  var0 = getEntArray("animObj", "targetname");
  var1 = gathergroups(var0);
  setupvfxobjs(var0);
  setupsfxobjs(var0);

  foreach(var3 in var0) {
    if(scripts\cp_mp\utility\game_utility::islargemap()) {
      var3 unmarkkeyframedmover(1);
    }

    if(isDefined(var3.script_animation_type)) {
      switch (var3.script_animation_type) {
        case "rotation_continuous":
        case "rotation_pingpong":
          thread animsuite_rotation(var3);
          break;
        case "translation_once":
        case "translation_pingpong":
          thread animsuite_translation(var3);
          break;
      }
    }
  }
}

function setupvfxobjs(var0) {
  foreach(var2 in var0) {
    if(isDefined(var2.script_noteworthy) && scripts\engine\utility::string_starts_with(var2.script_noteworthy, "vfx_")) {
      var3 = var2 scripts\engine\utility::spawn_tag_origin();
      var3 show();
      var3 linkTo(var2);
      waitframe();

      if(!van_stop_vo("setupVFXObjs(): obj", var2)) {
        continue;
      }

      if(!van_stop_vo("setupVFXObjs(): model", var3)) {
        continue;
      }

      thread delayfxcall(scripts\engine\utility::getfx(var2.script_noteworthy), var3, "tag_origin");
    }
  }
}

function delayfxcall(var0, var1, var2) {
  wait 5;

  if(!van_stop_vo("delayFXCall()", var1)) {
    return;
  }

  playFXOnTag(var0, var1, var2);
}

function setupsfxobjs(var0) {
  foreach(var2 in var0) {
    if(isDefined(var2.script_noteworthy) && scripts\engine\utility::string_starts_with(var2.script_noteworthy, "sfx_")) {
      var2 setModel("tag_origin");
      var2 thread scripts\engine\utility::play_loop_sound_on_entity("mp_quarry_lg_crane_loop");
    }
  }
}

function debug_temp_sphere() {
  for(;;) {
    scripts\mp\utility\debug::drawsphere(self.origin, 32, 0.1, (0, 0, 255));
    wait 0.1;
  }
}

function gathergroups(var0) {
  var1 = [];
  var2 = [];

  foreach(var4 in var0) {
    if(isDefined(var4.script_noteworthy) && issubstr(var4.script_noteworthy, "group")) {
      var1 = scripts\engine\utility::array_add(var1, var4);
    }
  }

  foreach(var7 in var1) {
    if(!isDefined(var2[var7.script_noteworthy])) {
      var2 = [var7];
      continue;
    }

    var2 = scripts\engine\utility::array_add(var2[var7.script_noteworthy], var7);
  }

  foreach(var10 in var2) {
    var11 = animsuite_getparentobject(var10);
    animsuite_linkchildrentoparentobject(var11, var10);
  }

  return var2;
}

function animsuite_getparentobject(var0) {
  foreach(var2 in var0) {
    if(isDefined(var2.script_linkname)) {
      return var2;
    }
  }
}

function animsuite_linkchildrentoparentobject(var0, var1) {
  if(isDefined(var0) && isDefined(var1)) {
    foreach(var3 in var1) {
      if(var3 == var0) {
        continue;
      }

      var3 linkTo(var0);
    }

    return;
  }
}

function animsuite_translation(var0) {
  if(issubstr(var0, "pingpong")) {
    thread animsuite_translation_pingpong();
  }

  if(issubstr(var0, "once")) {
    thread animsuite_translation_once();
    return;
  }
}

function animsuite_translation_pingpong() {
  level endon("game_ended");
  var0 = (0, 90, 0);
  var1 = 5;
  var2 = 0.5;
  var3 = undefined;
  var4 = undefined;
  var5 = undefined;

  if(isDefined(self.script_translation_amount)) {
    var0 = self.script_translation_amount;
  }

  if(isDefined(self.script_translation_time)) {
    var1 = self.script_translation_time;
  }

  jumpiffalse(isDefined(self.script_audio_parameters)) LOC_00000098;

  if(issubstr(self.script_audio_parameters, "start")) {
    var3 = "mp_quarry_lg_crane_start";
  }

  if(issubstr(self.script_audio_parameters, "stop")) {
    var4 = "mp_quarry_lg_crane_stop";
  }

  jumpiffalse(issubstr(self.script_audio_parameters, "loop")) LOC_00000098;
  var5 = "mp_quarry_lg_crane_loop";

  for(;;) {
    var6 = self.origin;
    self moveTo(self.origin + var0, var1[0], var1[1], var1[2]);

    if(isDefined(var4)) {
      thread animsuite_playthreadedsound(var1[0], var4);
    }

    wait var1[0] + var2;

    if(!van_stop_vo("animSuite_Translation_PingPong()", self)) {
      return;
    }

    if(isDefined(var3)) {
      playsoundatpos(self.origin, var3);
    }

    self moveTo(var6, var1[0], var1[1], var1[2]);

    if(isDefined(var4)) {
      thread animsuite_playthreadedsound(var1[0], var4);
    }

    wait var1[0] + var2;

    if(!van_stop_vo("animSuite_Translation_PingPong()", self)) {
      return;
    }

    if(isDefined(var3)) {
      playsoundatpos(self.origin, var3);
    }
  }
}

function animsuite_playthreadedsound(var0, var1) {
  wait var0;

  if(!van_stop_vo("animSuite_playThreadedSound()", self)) {
    return;
  }

  playsoundatpos(self.origin, var1);
}

function animsuite_translation_once() {
  level endon("game_ended");
  var0 = (0, 90, 0);
  var1 = 5;

  if(isDefined(self.script_translation_amount)) {
    var0 = self.script_translation_amount;
  }

  if(isDefined(self.script_translation_time)) {
    var1 = length(self.script_translation_time);
  }

  for(;;) {
    self rotateby(var0, var1, 0, 0);
    wait var1;

    if(!van_stop_vo("animSuite_Translation_Once()", self)) {
      return;
    }
  }
}

function animsuite_rotation(var0) {
  if(issubstr(var0, "pingpong")) {
    thread animsuite_rotation_pingpong();
  }

  if(issubstr(var0, "continuous")) {
    thread animsuite_rotation_continuous();
    return;
  }
}

function animsuite_rotation_pingpong() {
  level endon("game_ended");
  var0 = (0, 90, 0);
  var1 = (5, 0, 0);
  var2 = 0;
  var3 = undefined;
  var4 = undefined;
  var5 = undefined;

  if(isDefined(self.script_rotation_amount)) {
    var0 = self.script_rotation_amount;
  }

  if(isDefined(self.script_rotation_speed)) {
    var1 = self.script_rotation_speed;
  }

  for(;;) {
    self rotateby(var0, var1[0], var1[1], var1[2]);

    if(isDefined(var4)) {
      thread animsuite_playthreadedsound(var1[0] * 0.9, var4);
    }

    wait var1[0] + var2;

    if(!van_stop_vo("animSuite_Rotation_PingPong()", self)) {
      return;
    }

    if(isDefined(var3)) {
      playsoundatpos(self.origin, var3);
    }

    self rotateby(var0 * -1, var1[0], var1[1], var1[2]);

    if(isDefined(var4)) {
      thread animsuite_playthreadedsound(var1[0] * 0.9, var4);
    }

    wait var1[0] + var2;

    if(!van_stop_vo("animSuite_Rotation_PingPong()", self)) {
      return;
    }

    if(isDefined(var3)) {
      playsoundatpos(self.origin, var3);
    }
  }
}

function animsuite_rotation_continuous() {
  level endon("game_ended");
  var0 = (0, 90, 0);
  var1 = (5, 0, 0);
  var2 = 0.5;

  if(isDefined(self.script_rotation_amount)) {
    var0 = self.script_rotation_amount;
  }

  if(isDefined(self.script_rotation_speed)) {
    var1 = self.script_rotation_speed;
  }

  if(isDefined(self.target)) {
    var3 = getEnt(self.target, "targetname");

    if(isDefined(var3) && var3.classname == "script_brushmodel") {
      var3 linkTo(self);
    }
  }

  for(;;) {
    self rotateby(var0, var1[0], var1[1], var1[2]);
    wait var1[0];

    if(!van_stop_vo("animSuite_Rotation_Continuous()", self)) {
      return;
    }
  }
}

function van_stop_vo(var0, var1) {
  if(!isDefined(var1)) {
    return false;
  }

  return true;
}
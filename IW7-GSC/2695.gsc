/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2695.gsc
***************************************/

animationsuite() {
  while(!scripts\mp\utility\game::istrue(game["gamestarted"]))
    wait 0.05;

  var_00 = getEntArray("animObj", "targetname");
  var_01 = gathergroups(var_00);
  setupvfxobjs(var_00);
  setupsfxobjs(var_00);

  foreach(var_03 in var_00) {
    if(isDefined(var_3.script_animation_type)) {
      switch (var_3.script_animation_type) {
        case "rotation_continuous":
        case "rotation_pingpong":
          var_03 thread animsuite_rotation(var_3.script_animation_type);
          break;
        case "translation_once":
        case "translation_pingpong":
          var_03 thread animsuite_translation(var_3.script_animation_type);
          break;
      }
    }
  }
}

setupvfxobjs(var_00) {
  foreach(var_02 in var_00) {
    if(isDefined(var_2.script_noteworthy) && scripts\engine\utility::string_starts_with(var_2.script_noteworthy, "vfx_")) {
      var_03 = var_02 scripts\engine\utility::spawn_tag_origin();
      var_03 show();
      var_03 linkto(var_02);
      scripts\engine\utility::waitframe();
      thread delayfxcall(scripts\engine\utility::getfx(var_2.script_noteworthy), var_03, "tag_origin");
    }
  }
}

delayfxcall(var_00, var_01, var_02) {
  wait 5;
  playFXOnTag(var_00, var_01, var_02);
}

setupsfxobjs(var_00) {
  foreach(var_02 in var_00) {
    if(isDefined(var_2.script_noteworthy) && scripts\engine\utility::string_starts_with(var_2.script_noteworthy, "sfx_")) {
      var_02 setModel("tag_origin");
      var_02 thread scripts\engine\utility::play_loop_sound_on_entity("mp_quarry_lg_crane_loop");
    }
  }
}

debug_temp_sphere() {
  for(;;) {
    scripts\mp\utility\game::drawsphere(self.origin, 32, 0.1, (0, 0, 255));
    wait 0.1;
  }
}

gathergroups(var_00) {
  var_01 = [];
  var_02 = [];

  foreach(var_04 in var_00) {
    if(isDefined(var_4.script_noteworthy) && issubstr(var_4.script_noteworthy, "group"))
      var_01 = scripts\engine\utility::array_add(var_01, var_04);
  }

  foreach(var_07 in var_01) {
    if(!isDefined(var_2[var_7.script_noteworthy])) {
      var_2[var_7.script_noteworthy] = [var_07];
      continue;
    }

    var_2[var_7.script_noteworthy] = ::scripts\engine\utility::array_add(var_2[var_7.script_noteworthy], var_07);
  }

  foreach(var_10 in var_02) {
    var_11 = animsuite_getparentobject(var_10);
    animsuite_linkchildrentoparentobject(var_11, var_10);
  }

  return var_02;
}

animsuite_getparentobject(var_00) {
  foreach(var_02 in var_00) {
    if(isDefined(var_2.script_linkname))
      return var_02;
  }
}

animsuite_linkchildrentoparentobject(var_00, var_01) {
  if(isDefined(var_00) && isDefined(var_01)) {
    foreach(var_03 in var_01) {
      if(var_03 == var_00) {
        continue;
      }
      var_03 linkto(var_00);
    }
  }
}

animsuite_translation(var_00) {
  if(issubstr(var_00, "pingpong"))
    thread animsuite_translation_pingpong();

  if(issubstr(var_00, "once"))
    thread animsuite_translation_once();
}

animsuite_translation_pingpong() {
  level endon("game_ended");
  var_00 = (0, 90, 0);
  var_01 = 5;
  var_02 = 0.5;
  var_03 = undefined;
  var_04 = undefined;
  var_05 = undefined;

  if(isDefined(self.script_translation_amount))
    var_00 = self.script_translation_amount;

  if(isDefined(self.script_translation_time))
    var_01 = self.script_translation_time;

  if(isDefined(self.script_audio_parameters)) {
    if(issubstr(self.script_audio_parameters, "start"))
      var_03 = "mp_quarry_lg_crane_start";

    if(issubstr(self.script_audio_parameters, "stop"))
      var_04 = "mp_quarry_lg_crane_stop";

    if(issubstr(self.script_audio_parameters, "loop"))
      var_05 = "mp_quarry_lg_crane_loop";
  }

  for(;;) {
    var_06 = self.origin;
    self moveto(self.origin + var_00, var_1[0], var_1[1], var_1[2]);

    if(isDefined(var_04))
      thread animsuite_playthreadedsound(var_1[0], var_04);

    wait(var_1[0] + var_02);

    if(isDefined(var_03))
      playLoopSound(self.origin, var_03);

    self moveto(var_06, var_1[0], var_1[1], var_1[2]);

    if(isDefined(var_04))
      thread animsuite_playthreadedsound(var_1[0], var_04);

    wait(var_1[0] + var_02);

    if(isDefined(var_03))
      playLoopSound(self.origin, var_03);
  }
}

animsuite_playthreadedsound(var_00, var_01) {
  wait(var_00);
  playLoopSound(self.origin, var_01);
}

animsuite_translation_once() {
  level endon("game_ended");
  var_00 = (0, 90, 0);
  var_01 = 5;

  if(isDefined(self.script_translation_amount))
    var_00 = self.script_translation_amount;

  if(isDefined(self.script_translation_time))
    var_01 = length(self.script_translation_time);

  for(;;) {
    self rotateby(var_00, var_01, 0, 0);
    wait(var_01);
  }
}

animsuite_rotation(var_00) {
  if(issubstr(var_00, "pingpong"))
    thread animsuite_rotation_pingpong();

  if(issubstr(var_00, "continuous"))
    thread animsuite_rotation_continuous();
}

animsuite_rotation_pingpong() {
  level endon("game_ended");
  var_00 = (0, 90, 0);
  var_01 = (5, 0, 0);
  var_02 = 0.5;
  var_03 = undefined;
  var_04 = undefined;
  var_05 = undefined;

  if(isDefined(self.script_rotation_amount))
    var_00 = self.script_rotation_amount;

  if(isDefined(self.script_rotation_speed))
    var_01 = self.script_rotation_speed;

  if(self.model == "jackal_arena_aa_turret_01_mp_sml") {
    var_03 = "divide_turret_move_start";
    var_04 = "divide_turret_move_end";
    thread scripts\engine\utility::play_loop_sound_on_entity("divide_turret_move_lp");
  }

  for(;;) {
    self rotateby(var_00, var_1[0], var_1[1], var_1[2]);

    if(isDefined(var_04))
      thread animsuite_playthreadedsound(var_1[0] * 0.9, var_04);

    wait(var_1[0] + var_02);

    if(isDefined(var_03))
      playLoopSound(self.origin, var_03);

    self rotateby(var_00 * -1, var_1[0], var_1[1], var_1[2]);

    if(isDefined(var_04))
      thread animsuite_playthreadedsound(var_1[0] * 0.9, var_04);

    wait(var_1[0] + var_02);

    if(isDefined(var_03))
      playLoopSound(self.origin, var_03);
  }
}

animsuite_rotation_continuous() {
  level endon("game_ended");
  var_00 = (0, 90, 0);
  var_01 = (5, 0, 0);
  var_02 = 0.5;

  if(isDefined(self.script_rotation_amount))
    var_00 = self.script_rotation_amount;

  if(isDefined(self.script_rotation_speed))
    var_01 = self.script_rotation_speed;

  for(;;) {
    self rotateby(var_00, var_1[0], var_1[1], var_1[2]);
    wait(var_1[0]);
  }
}
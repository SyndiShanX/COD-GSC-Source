/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\animation_suite.gsc
*********************************************/

animationsuite() {
  while(!scripts\mp\utility::istrue(game["gamestarted"])) {
    wait(0.05);
  }

  var_0 = getEntArray("animObj", "targetname");
  var_1 = gathergroups(var_0);
  setupvfxobjs(var_0);
  setupsfxobjs(var_0);
  foreach(var_3 in var_0) {
    if(isDefined(var_3.script_animation_type)) {
      switch (var_3.script_animation_type) {
        case "rotation_continuous":
        case "rotation_pingpong":
          var_3 thread animsuite_rotation(var_3.script_animation_type);
          break;

        case "translation_once":
        case "translation_pingpong":
          var_3 thread animsuite_translation(var_3.script_animation_type);
          break;
      }
    }
  }
}

setupvfxobjs(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy) && scripts\engine\utility::string_starts_with(var_2.script_noteworthy, "vfx_")) {
      var_3 = var_2 scripts\engine\utility::spawn_tag_origin();
      var_3 show();
      var_3 linkto(var_2);
      scripts\engine\utility::waitframe();
      thread delayfxcall(scripts\engine\utility::getfx(var_2.script_noteworthy), var_3, "tag_origin");
    }
  }
}

delayfxcall(var_0, var_1, var_2) {
  wait(5);
  playFXOnTag(var_0, var_1, var_2);
}

setupsfxobjs(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy) && scripts\engine\utility::string_starts_with(var_2.script_noteworthy, "sfx_")) {
      var_2 setModel("tag_origin");
      var_2 thread scripts\engine\utility::play_loop_sound_on_entity("mp_quarry_lg_crane_loop");
    }
  }
}

debug_temp_sphere() {
  for(;;) {
    scripts\mp\utility::drawsphere(self.origin, 32, 0.1, (0, 0, 255));
    wait(0.1);
  }
}

gathergroups(var_0) {
  var_1 = [];
  var_2 = [];
  foreach(var_4 in var_0) {
    if(isDefined(var_4.script_noteworthy) && issubstr(var_4.script_noteworthy, "group")) {
      var_1 = scripts\engine\utility::array_add(var_1, var_4);
    }
  }

  foreach(var_7 in var_1) {
    if(!isDefined(var_2[var_7.script_noteworthy])) {
      var_2[var_7.script_noteworthy] = [var_7];
      continue;
    }

    var_2[var_7.script_noteworthy] = ::scripts\engine\utility::array_add(var_2[var_7.script_noteworthy], var_7);
  }

  foreach(var_0A in var_2) {
    var_0B = animsuite_getparentobject(var_0A);
    animsuite_linkchildrentoparentobject(var_0B, var_0A);
  }

  return var_2;
}

animsuite_getparentobject(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2.destroynavobstacle)) {
      return var_2;
    }
  }
}

animsuite_linkchildrentoparentobject(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(var_3 == var_0) {
        continue;
      }

      var_3 linkto(var_0);
    }
  }
}

animsuite_translation(var_0) {
  if(issubstr(var_0, "pingpong")) {
    thread animsuite_translation_pingpong();
  }

  if(issubstr(var_0, "once")) {
    thread animsuite_translation_once();
  }
}

animsuite_translation_pingpong() {
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

  if(isDefined(self.script_audio_parameters)) {
    if(issubstr(self.script_audio_parameters, "start")) {
      var_3 = "mp_quarry_lg_crane_start";
    }

    if(issubstr(self.script_audio_parameters, "stop")) {
      var_4 = "mp_quarry_lg_crane_stop";
    }

    if(issubstr(self.script_audio_parameters, "loop")) {
      var_5 = "mp_quarry_lg_crane_loop";
    }
  }

  for(;;) {
    var_6 = self.origin;
    self moveto(self.origin + var_0, var_1[0], var_1[1], var_1[2]);
    if(isDefined(var_4)) {
      thread animsuite_playthreadedsound(var_1[0], var_4);
    }

    wait(var_1[0] + var_2);
    if(isDefined(var_3)) {
      playsoundatpos(self.origin, var_3);
    }

    self moveto(var_6, var_1[0], var_1[1], var_1[2]);
    if(isDefined(var_4)) {
      thread animsuite_playthreadedsound(var_1[0], var_4);
    }

    wait(var_1[0] + var_2);
    if(isDefined(var_3)) {
      playsoundatpos(self.origin, var_3);
    }
  }
}

animsuite_playthreadedsound(var_0, var_1) {
  wait(var_0);
  playsoundatpos(self.origin, var_1);
}

animsuite_translation_once() {
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
    self ghost_killed_update_func(var_0, var_1, 0, 0);
    wait(var_1);
  }
}

animsuite_rotation(var_0) {
  if(issubstr(var_0, "pingpong")) {
    thread animsuite_rotation_pingpong();
  }

  if(issubstr(var_0, "continuous")) {
    thread animsuite_rotation_continuous();
  }
}

animsuite_rotation_pingpong() {
  level endon("game_ended");
  var_0 = (0, 90, 0);
  var_1 = (5, 0, 0);
  var_2 = 0.5;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  if(isDefined(self.script_rotation_amount)) {
    var_0 = self.script_rotation_amount;
  }

  if(isDefined(self.script_rotation_speed)) {
    var_1 = self.script_rotation_speed;
  }

  if(self.model == "jackal_arena_aa_turret_01_mp_sml") {
    var_3 = "divide_turret_move_start";
    var_4 = "divide_turret_move_end";
    thread scripts\engine\utility::play_loop_sound_on_entity("divide_turret_move_lp");
  }

  for(;;) {
    self ghost_killed_update_func(var_0, var_1[0], var_1[1], var_1[2]);
    if(isDefined(var_4)) {
      thread animsuite_playthreadedsound(var_1[0] * 0.9, var_4);
    }

    wait(var_1[0] + var_2);
    if(isDefined(var_3)) {
      playsoundatpos(self.origin, var_3);
    }

    self ghost_killed_update_func(var_0 * -1, var_1[0], var_1[1], var_1[2]);
    if(isDefined(var_4)) {
      thread animsuite_playthreadedsound(var_1[0] * 0.9, var_4);
    }

    wait(var_1[0] + var_2);
    if(isDefined(var_3)) {
      playsoundatpos(self.origin, var_3);
    }
  }
}

animsuite_rotation_continuous() {
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

  for(;;) {
    self ghost_killed_update_func(var_0, var_1[0], var_1[1], var_1[2]);
    wait(var_1[0]);
  }
}
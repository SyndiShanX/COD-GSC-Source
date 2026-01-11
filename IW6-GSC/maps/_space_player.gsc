/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_space_player.gsc
*****************************************************/

init_player_space() {
  precacheshellshock("underwater_swim");
  precachemodel("viewhands_us_space");
  precachemodel("viewhands_player_us_space");
  precacherumble("light_1s");
  common_scripts\utility::flag_init("spacesprint");
  common_scripts\utility::flag_init("boostAnim");
  common_scripts\utility::flag_init("wall_push_flag_left");
  common_scripts\utility::flag_init("floor_push");
  common_scripts\utility::flag_init("no_push_zone");
  common_scripts\utility::flag_init("stop_wall_pushing");
  common_scripts\utility::flag_init("wall_push_tweak_player");
  common_scripts\utility::flag_init("set_player_interior_speed");
  common_scripts\utility::flag_init("set_player_exterior_speed");
  common_scripts\utility::flag_init("clear_to_tweak_player");
  common_scripts\utility::flag_init("enable_player_thruster_audio");
  common_scripts\utility::flag_init("prologue_ready_for_thrusters");
  level.sfx_player_breathing_started = 0;
}

init_player_space_anims() {
  player_space_anims();
}

shellshock_forever() {}

enable_player_space() {
  setsaveddvar("cg_footsteps", 0);
  setsaveddvar("cg_equipmentSounds", 0);
  setsaveddvar("cg_landingSounds", 0);
  thread shellshock_forever();
  level.water_current = (0, 0, 0);
  level.drift_vec = (0, 0, 0);
  thread moving_water();
  thread impulse_push();
  self.player_mover = common_scripts\utility::spawn_tag_origin();
  thread maps\_space::player_space();
  thread space_thruster_audio();
  setsaveddvar("player_spaceEnabled", "1");
  thread reloading_anim_clip_throw();
  self allowswim(1);
  level.space_friction = 15;
  level.space_speed = 80;
  level.space_accel = 75;
  level.space_vertical_speed = 65;
  level.space_vertical_accel = 85;
  setsaveddvar("player_swimFriction", level.space_friction);
  setsaveddvar("player_swimAcceleration", level.space_accel);
  setsaveddvar("player_swimVerticalFriction", 45);
  setsaveddvar("player_swimVerticalSpeed", 65);
  setsaveddvar("player_swimVerticalAcceleration", 85);
  setsaveddvar("player_swimSpeed", level.space_speed);
  thread direction_change_smoothing();
  thread space_sprint();
  setsaveddvar("player_sprintUnlimited", "1");
  wait 1;

  if(isDefined(level.player.has_pushanims) && level.player.has_pushanims == 1) {
    var_0 = maps\_utility::spawn_anim_model("player_rig");
    var_0 dontcastshadows();
    var_0.origin = level.player.origin;
    var_0.angles = level.player.angles;
    var_0 linktoplayerview(level.player, "tag_origin", (0, 0, 0), (0, 0, 0), 1);
    var_0 hide();
    thread wall_push(var_0);
    thread speed_direction_check();
    thread contuing_to_move_check();
  }
}

disable_player_space() {
  level notify("disable_space");
  self notify("disable_space");
  setsaveddvar("cg_footsteps", 1);
  setsaveddvar("cg_equipmentSounds", 1);
  setsaveddvar("cg_landingSounds", 1);
  setsaveddvar("player_swimFriction", 30);
  setsaveddvar("player_swimAcceleration", 100);
  setsaveddvar("player_swimVerticalFriction", 40);
  setsaveddvar("player_swimVerticalSpeed", 120);
  setsaveddvar("player_swimVerticalAcceleration", 160);
  setsaveddvar("player_swimSpeed", 80);
  setsaveddvar("player_sprintUnlimited", "1");
  setsaveddvar("player_swimWaterCurrent", (0, 0, 0));
  setsaveddvar("player_spaceEnabled", "0");
  thread maps\_space::player_space_helmet_disable();
  thread maps\_space::space_hud_enable(0);
  self allowlean(1);
  self allowsprint(1);
  self allowswim(0);
}

player_location_check(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  switch (var_0) {
    case "exterior":
      level.space_speed = level.space_speed * 1.5;
      setsaveddvar("player_swimSpeed", level.space_speed);
      break;
    case "interior":
      level.space_speed = level.space_speed / 1.5;
      setsaveddvar("player_swimSpeed", level.space_speed);
      break;
  }
}

reloading_anim_clip_throw() {
  level endon("stop_weapon_drop_scripts");

  if(level.script == "loki" || level.script == "odin" || level.script == "prologue") {
    for(;;) {
      var_0 = level.player getcurrentweapon();

      if(var_0 == "arx160_space+acog_sp+glarx160_sp" || var_0 == "microtar_space_interior+acogsmg_sp" || var_0 == "microtar_space+acogsmg_sp" || var_0 == "microtar_space_interior+acogsmg_sp+spaceshroud_sp" || var_0 == "microtar_space+acogsmg_sp+spaceshroud_sp") {
        level.player waittill("reload_start");

        if(level.player isreloading() == 1) {
          var_1 = spawn("script_model", (0, 0, 0));
          var_1 setModel("tag_origin");

          if(var_0 == "microtar_space_interior+acogsmg_sp+spaceshroud_sp" || var_0 == "microtar_space_interior+acogsmg_sp") {
            wait 1.3;
            var_1 linktoplayerview(self, "magazine0_JNT", (0, 0, 0), (0, 0, 0), 1);
            playFXOnTag(common_scripts\utility::getfx("space_clip_reload"), var_1, "tag_origin");
          } else if(var_0 == "microtar_space+acogsmg_sp+spaceshroud_sp" || var_0 == "microtar_space+acogsmg_sp") {} else {
            wait 0.7;
            var_1 linktoplayerview(self, "J_WristTwist_LE", (0, -10, 0), (-30, -20, 0), 1);
            playFXOnTag(common_scripts\utility::getfx("space_clip_reload_arx"), var_1, "tag_origin");
          }

          wait 1;
          var_1 delete();
        }
      }

      wait 0.75;
    }
  }
}

wall_push(var_0) {
  level endon("wall_push_over");
  level endon("start_transition_to_youngblood");
  thread stop_space_push(var_0);

  while(!common_scripts\utility::flag("stop_wall_pushing")) {
    common_scripts\utility::flag_wait("wall_push_flag");
    common_scripts\utility::flag_waitopen("no_push_zone");
    var_1 = undefined;
    var_2 = undefined;
    var_3 = getEntArray("wall_push_org", "targetname");

    foreach(var_5 in var_3) {
      var_6 = distancesquared(level.player.origin, var_5.origin);

      if(!isDefined(var_1) || var_6 < var_1) {
        var_1 = var_6;
        var_2 = var_5;
      }
    }

    switch (var_2.script_parameters) {
      case "left":
        random_player_wall_push(var_2, var_0);
        break;
      case "up":
        break;
      case "down":
        random_player_wall_pushdownup(var_2, var_0);
        break;
    }

    wait 0.1;
  }

  var_0 unlink();
  var_0 delete();
}

stop_space_push(var_0) {
  common_scripts\utility::flag_wait("stop_wall_pushing");
  level notify("wall_push_over");
  var_0 unlink();
  var_0 delete();
}

speed_direction_check() {
  level endon("disable_space");
  level.timecheck = 0;

  for(;;) {
    var_0 = level.player getnormalizedmovement();

    if(var_0[0] > 0.4) {
      wait 0.1;
      level.timecheck = level.timecheck + 0.1;
      continue;
    }

    level.timecheck = 0;
    wait 0.1;
  }
}

contuing_to_move_check() {
  level endon("start_transition_to_youngblood");
  level.bmovingstraight = 0;
  var_0 = level.player getorigin();
  var_1[0] = var_0[0];
  var_1[1] = var_0[1];
  var_2[0] = var_1[0];
  var_2[1] = var_1[1];

  for(;;) {
    var_0 = level.player getorigin();
    var_1[0] = var_0[0];
    var_1[1] = var_0[1];

    for(var_3 = 0; var_3 < 2; var_3++) {
      if(var_1[var_3] < 0) {
        var_1[var_3] = var_1[var_3] * -1;
      }

      if(var_2[var_3] < 0) {
        var_2[var_3] = var_2[var_3] * -1;
      }

      var_4 = var_1[var_3] - var_2[var_3];
      var_5 = var_2[var_3] - var_1[var_3];

      if((var_1[var_3] - var_2[var_3] >= 2 || var_1[var_3] - var_2[var_3] <= -2) && level.player isreloading() == 0 && level.player maps\_utility::isads() == 0) {
        level.bmovingstraight = 1;
        break;
      } else
        level.bmovingstraight = 0;
    }

    wait 0.01;
    var_2[0] = var_1[0];
    var_2[1] = var_1[1];
  }
}

#using_animtree("player");

random_player_wall_push(var_0, var_1) {
  var_2 = [];
  var_2["player_rig"] = var_1;
  var_3 = var_0.angles[1];
  var_4 = 0;
  var_5 = 40;

  if(var_3 <= 0) {
    var_3 = var_3 + 360;
  }

  var_6 = 0;

  while(common_scripts\utility::flag("wall_push_flag")) {
    var_7 = randomintrange(1, 10);
    var_8 = level.player getnormalizedmovement();
    var_9 = level.player getnormalizedmovement();
    level.player maps\_anim::anim_first_frame(var_2, "viewmodel_space_l_arm_sidepush");
    var_10 = level.player.angles[1];

    if(var_10 <= 0) {
      var_10 = var_10 + 360;
    }

    if(var_3 + var_5 > 360) {
      var_4 = var_3 + var_5 - 360;

      if(var_10 > var_3 || var_10 < var_4) {
        var_6 = 1;
      }
    } else if(var_10 > var_3 - var_5 && var_10 < var_3 + var_5)
      var_6 = 1;

    if(var_7 < 6) {}

    var_11 = 1;

    if(common_scripts\utility::flag("spacesprint")) {
      var_11 = 1.1;
    }

    if(var_6 == 1 && var_9[0] > 0.4 && level.timecheck > 1 && level.bmovingstraight == 1) {
      var_1 show();
      var_1 setanimrestart( % viewmodel_space_l_arm_sidepush, 1, 0, var_11);
      var_1 setanimtime( % viewmodel_space_l_arm_sidepush, 0.25);
      common_scripts\utility::flag_set("wall_push_tweak_player");

      if(level.script == "odin" || level.script == "prologue") {
        level.player playSound("space_plr_wall_push");
      }

      wait 1;
      thread anim_boost();
      wait 0.67;
      var_1 hide();
      wait 1;
    }

    var_6 = 0;
    wait 0.05;
  }
}

random_player_wall_pushdownup(var_0, var_1) {
  var_2 = [];
  var_2["player_rig"] = var_1;
  var_3 = var_0.angles[1];
  var_4 = 0;
  var_5 = 40;

  if(var_3 <= 0) {
    var_3 = var_3 + 360;
  }

  var_6 = 0;

  while(common_scripts\utility::flag("wall_push_flag")) {
    var_7 = randomintrange(1, 10);
    var_8 = level.player getplayerangles();
    var_9 = level.player getnormalizedmovement();
    level.player maps\_anim::anim_first_frame(var_2, "viewmodel_space_l_arm_downpush");
    var_10 = level.player.angles[1];

    if(var_10 <= 0) {
      var_10 = var_10 + 360;
    }

    if(var_3 + var_5 > 360) {
      var_4 = var_3 + var_5 - 360;

      if(var_10 > var_3 - var_5 || var_10 < var_4) {
        if(var_8[0] > -10 && var_8[0] < 30) {
          var_6 = 1;
        }
      }
    } else if(var_10 > var_3 - var_5 && var_10 < var_3 + var_5) {
      if(var_8[0] > -20 && var_8[0] < 30) {
        var_6 = 1;
      }
    }

    if(var_7 < 6) {}

    var_11 = 1;

    if(common_scripts\utility::flag("spacesprint")) {
      var_11 = 1.1;
    }

    if(var_6 == 1 && var_9[0] > 0.4 && level.timecheck > 1 && level.bmovingstraight == 1) {
      var_1 show();
      var_1 setanimrestart( % viewmodel_space_l_arm_downpush, 1, 0, var_11);
      var_1 setanimtime( % viewmodel_space_l_arm_downpush, 0.25);
      common_scripts\utility::flag_set("wall_push_tweak_player");

      if(level.script == "odin" || level.script == "prologue") {
        level.player playSound("space_plr_wall_push");
      }

      wait 1;
      thread anim_up_down_boost();
      wait 0.67;
      var_1 hide();
      wait 1;
    }

    var_6 = 0;
    wait 0.05;
  }
}

anim_up_down_boost() {
  common_scripts\utility::flag_set("boostAnim");
  setsaveddvar("player_swimSpeed", level.space_speed * 1.1);
  wait 0.7;
  common_scripts\utility::flag_clear("boostAnim");
  setsaveddvar("player_swimSpeed", level.space_speed);
}

anim_boost() {
  common_scripts\utility::flag_set("boostAnim");
  setsaveddvar("player_swimSpeed", level.space_speed * 1.1);
  wait 0.5;
  common_scripts\utility::flag_clear("boostAnim");
  setsaveddvar("player_swimSpeed", level.space_speed);
}

moving_water() {
  var_0 = getEntArray("moving_water_flags", "script_noteworthy");

  foreach(var_2 in var_0) {
  thread moving_water_flag(var_2);
  }
}

moving_water_flag(var_0) {
  level endon("disable_space");
  var_1 = 40;
  var_2 = getent(var_0.target, "targetname");
  var_3 = anglesToForward(var_2.angles) * var_1;

  for(;;) {
    common_scripts\utility::flag_wait(var_0.script_flag);
    level.water_current = var_3;
    common_scripts\utility::flag_waitopen(var_0.script_flag);
    level.water_current = (0, 0, 0);
  }
}

player_space_anims() {
  level.scr_animtree["playerhands"] = #animtree;
  level.scr_model["playerhands"] = "viewhands_player_us_space";
}

direction_change_smoothing() {
  level endon("start_transition_to_youngblood");
  level endon("disable_space");
  self endon("death");
  var_0 = level.player getnormalizedmovement();
  var_1 = var_0;

  if(!isDefined(level.wall_friction_enabled)) {
    level.wall_friction_enabled = 1;
  }

  if(!isDefined(level.wall_friction_trace_dist)) {
    level.wall_friction_trace_dist = 5;
  }

  if(!isDefined(level.wall_friction_offset_dist)) {
    level.wall_friction_offset_dist = 2;
  }

  for(;;) {
    var_0 = level.player getnormalizedmovement();

    if(var_0[0] > 0.15) {
      var_2 = "positive";
    }
    else {
      var_2 = "neutral";
    }

    if(var_0[1] > 0.15) {
      var_3 = "positive";
    }
    else {
      var_3 = "neutral";
    }

    if(var_0[0] < -0.15) {
      var_2 = "negative";
    }

    if(var_0[1] < -0.15) {
      var_3 = "negative";
    }

    if(var_1[0] > 0.15) {
      var_4 = "positive";
    }
    else {
      var_4 = "neutral";
    }

    if(var_1[1] > 0.15) {
      var_5 = "positive";
    }
    else {
      var_5 = "neutral";
    }

    if(var_1[0] < -0.15) {
      var_4 = "negative";
    }

    if(var_1[1] < -0.15) {
      var_5 = "negative";
    }

    var_6 = 0;

    if(level.wall_friction_enabled) {
      var_7 = vectornormalize(level.player getvelocity());
      var_8 = anglestoright(vectortoangles(var_7));
      var_9 = anglestoup(vectortoangles(var_7));
      var_10 = level.wall_friction_offset_dist;
      var_11 = level.player.origin + (var_8[0] * var_10, var_8[1] * var_10, var_8[2] * var_10);
      var_11 = var_11 + (var_9[0] * var_10, var_9[1] * var_10, var_9[2] * var_10);
      var_12 = level.player.origin - (var_8[0] * var_10, var_8[1] * var_10, var_8[2] * var_10);
      var_12 = var_12 - (var_9[0] * var_10, var_9[1] * var_10, var_9[2] * var_10);
      var_10 = level.wall_friction_trace_dist;
      var_13 = var_11 + (var_7[0] * var_10, var_7[1] * var_10, var_7[2] * var_10);
      var_14 = level.player aiphysicstrace(var_11, var_13);

      if(var_13 != var_14) {
        var_6 = 1;
      }
      else {
        var_13 = var_12 + (var_7[0] * var_10, var_7[1] * var_10, var_7[2] * var_10);
        var_14 = level.player aiphysicstrace(var_12, var_13);

        if(var_13 != var_14) {
          var_6 = 1;
        }
      }
    }

    if(level.wall_friction_enabled && var_6 == 1) {
      setsaveddvar("player_swimFriction", 120);
      wait 0.15;
    } else if(var_3 == "neutral" && var_2 == "neutral" || var_5 == "positive" && var_4 == "positive" && var_3 == "positive" && var_2 == "positive" || var_5 == "negative" && var_4 == "negative" && var_3 == "negative" && var_2 == "negative" || var_5 == "negative" && var_4 == "positive" && var_3 == "negative" && var_2 == "positive" || var_5 == "positive" && var_4 == "negative" && var_3 == "positive" && var_2 == "negative") {
      if(getdvarint("player_swimFriction", 15) != level.space_friction) {
        setsaveddvar("player_swimFriction", level.space_friction);
      }

      if(getdvarint("player_swimAcceleration", 66) != 66) {
        setsaveddvar("player_swimAcceleration", 66);
      }
    } else {
      setsaveddvar("player_swimFriction", 120);
      setsaveddvar("player_swimAcceleration", 200);
      wait 0.1;
    }

    if(var_2 != "neutral" && var_3 != "neutral ") {
      var_1 = var_0;
    }

    wait 0.1;
  }
}

space_sprint() {
  level endon("disable_space");
  var_0 = 0;

  for(;;) {
    if(level.player issprinting()) {
      if(var_0 == 0) {
        level.player playrumbleonentity("light_1s");
        wait 0.05;
        level.player stoprumble("light_1s");
        var_0 = 1;
      }
    } else
      var_0 = 0;

    wait 0.05;
  }
}

sprint_fade(var_0) {
  level endon("sprinting");

  for(;;) {
    if(var_0 > 1) {
      setsaveddvar("player_swimSpeed", level.space_speed * var_0);
      var_0 = var_0 - 0.05;
    } else
      return;

    wait 0.05;
  }
}

impulse_push() {
  level endon("disable_space");

  for(;;) {
    level.player waittill("damage", var_0, var_1, var_2, var_3, var_4);
    common_scripts\utility::flag_clear("clear_to_tweak_player");
    var_5 = [];
    var_5[0] = var_2[0];
    var_5[1] = var_2[1];
    var_5[2] = var_2[2];
    var_6 = 0.25;
    var_7 = 3000;
    var_8 = 1;

    if(var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE" || var_4 == "MOD_GRENADE_SPLASH") {
      var_6 = 0.5;
      var_7 = 7000;
      var_8 = 1;
    }

    for(var_9 = 0; var_9 < 3; var_9++) {
      var_5[var_9] = var_5[var_9] * 0.25 * (var_0 * var_6);

      if(var_5[var_9] > var_7) {
        var_5[var_9] = var_7;
      }

      if(var_5[var_9] < 0 - var_7) {
        var_5[var_9] = 0 - var_7;
      }
    }

    setsaveddvar("player_swimWaterCurrent", (var_5[0], var_5[1], var_5[2]));
    wait(var_8);

    for(var_9 = 0; var_9 < 3; var_9++) {
      for(var_9 = 0; var_9 < 3; var_9++) {
        var_5[var_9] = var_5[var_9] * 0.5;
      }

      setsaveddvar("player_swimWaterCurrent", (var_5[0], var_5[1], var_5[2]));
      wait(var_8 * 0.25);
    }

    setsaveddvar("player_swimWaterCurrent", (0, 0, 0));
    common_scripts\utility::flag_set("clear_to_tweak_player");
  }
}

player_recoil() {
  for(;;) {
    self waittill("weapon_fired");
    var_0 = level.player getcurrentweapon();

    if(var_0 == "microtar_space") {
      common_scripts\utility::flag_clear("clear_to_tweak_player");
      var_1 = self getplayerangles();
      var_2 = anglesToForward(var_1);
      var_3 = [];
      var_3[0] = var_2[0];
      var_3[1] = var_2[1];
      var_3[2] = var_2[2];
      var_4 = 2500;
      var_5 = 1;

      for(var_6 = 0; var_6 < 3; var_6++) {
        var_3[var_6] = var_3[var_6] * var_4 * -1;
      }

      setsaveddvar("player_swimWaterCurrent", (var_3[0], var_3[1], var_3[2]));
      wait(var_5);

      for(var_6 = 0; var_6 < 3; var_6++) {
        for(var_6 = 0; var_6 < 3; var_6++) {
          var_3[var_6] = var_3[var_6] * 0.5;
        }

        setsaveddvar("player_swimWaterCurrent", (var_3[0], var_3[1], var_3[2]));
        wait(var_5 * 0.25);
      }

      setsaveddvar("player_swimWaterCurrent", (0, 0, 0));
      common_scripts\utility::flag_set("clear_to_tweak_player");
    }
  }
}

space_thruster_audio() {
  level endon("disable_space");
  common_scripts\utility::flag_set("enable_player_thruster_audio");
  level.thruster_timer = 1;
  level.thruster_sprint_timer = 1;
  level.thruster_sprint = spawn("script_origin", (0, 0, 0));
  level.thruster_oneshot = spawn("script_origin", (0, 0, 0));
  level.axes = ["x", "y", "z_up", "z_down"];
  level.player thread player_thruster_logic();
  level.player thread thruster_audio_logic();
  level waittill("kill_thrusters");
  level.thruster_sprint delete();
  level.thruster_oneshot delete();
}

player_space_breathing() {
  wait 0.02;

  if(level.sfx_player_breathing_started == 0) {
    level.sfx_player_breathing_started = 1;

    if(!issplitscreen()) {
      thread player_space_breathe_sound();
    }
    else if(self == level.player) {
      thread player_space_breathe_sound();
    }
  }
}

player_space_breathe_sound() {
  level endon("start_transition_to_youngblood");
  self endon("death");
  self notify("start_scuba_breathe");
  self endon("start_scuba_breathe");
  self endon("stop_scuba_breathe");
  level.pressurized = 0;
  level.space_intense_breathing = 0;

  for(;;) {
    if(level.space_intense_breathing == 1) {
      wait 0.75;
    }
    else if(level.space_intense_breathing == 2) {
      wait 0.01;
    }
    else if(level.space_intense_breathing == 3) {
      wait 0.25;
    }
    else {
      wait 2.75;
    }

    if(level.space_breathing_enabled == 1) {
      if(level.pressurized == 0) {
        if(level.space_intense_breathing == 1 || level.space_intense_breathing == 2) {
          self playlocalsound("space_breathe_player_fast_inhale", "scuba_breathe_sound_done");
        }
        else if(level.space_intense_breathing == 3) {
          self playlocalsound("space_breathe_player_inhale_slomo", "scuba_breathe_sound_done");
        }
        else {
          self playlocalsound("space_breathe_player_inhale", "scuba_breathe_sound_done");
        }

        self waittill("scuba_breathe_sound_done");
      }

      if(level.pressurized == 0) {
        if(level.space_intense_breathing == 1 || level.space_intense_breathing == 2) {
          self playlocalsound("space_breathe_player_fast_exhale", "scuba_breathe_sound_done");
        }
        else if(level.space_intense_breathing == 3) {
          self playlocalsound("space_breathe_player_exhale_slomo", "scuba_breathe_sound_done");
        }
        else {
          self playlocalsound("space_breathe_player_exhale", "scuba_breathe_sound_done");
        }

        self waittill("scuba_breathe_sound_done");
      }
    }
  }
}

attach_audio_points_to_player() {
  level endon("kill_thrusters");

  for(;;) {
    common_scripts\utility::flag_wait("enable_player_thruster_audio");
    level._thruster_rig = spawn("script_model", (0, 0, 0));
    level._thruster_rig.origin = self.origin;
    level._thruster_rig.angles = self.angles;
    level._thruster_rig setModel("viewhands_us_space");
    level._thruster_rig dontcastshadows();
    level._thruster_rig hide();
    level._thruster_rig linktoplayerview(self, "tag_player", (0, 0, 0), (0, 0, 0), 1);

    for(var_0 = 0; var_0 < 6; var_0++) {
      var_1 = spawn("script_model", (0, 0, 0));
      var_1 setModel("tag_origin");

      if(var_0 == 0) {
        var_1.origin = level._thruster_rig gettagorigin("tag_jet_top");
        var_1 linkto(level._thruster_rig, "tag_jet_top", (0, 0, 0), (0, 0, 0));
      } else if(var_0 == 1) {
        var_1.origin = level._thruster_rig gettagorigin("tag_jet_bottom");
        var_1 linkto(level._thruster_rig, "tag_jet_bottom", (0, 0, 0), (0, 0, 0));
      } else if(var_0 == 2) {
        var_1.origin = level._thruster_rig gettagorigin("tag_jet_front");
        var_1 linkto(level._thruster_rig, "tag_jet_front", (0, 0, 0), (0, 0, 0));
      } else if(var_0 == 3) {
        var_1.origin = level._thruster_rig gettagorigin("tag_jet_left");
        var_1 linkto(level._thruster_rig, "tag_jet_left", (0, 0, 0), (0, 0, 0));
      } else if(var_0 == 4) {
        var_1.origin = level._thruster_rig gettagorigin("tag_jet_right");
        var_1 linkto(level._thruster_rig, "tag_jet_right", (0, 0, 0), (0, 0, 0));
      } else if(var_0 == 5) {
        var_1.origin = level._thruster_rig gettagorigin("tag_jet_back");
        var_1 linkto(level._thruster_rig, "tag_jet_back", (0, 0, 0), (0, 0, 0));
      }

      var_1 thread thruster_audio_logic(var_0);
      level._thruster_ents[var_0] = var_1;
    }

    common_scripts\utility::flag_waitopen("enable_player_thruster_audio");

    foreach(var_1 in level._thruster_ents) {
      var_1 notify("stop");
      var_1 delete();
    }

    level._thruster_rig delete();
  }
}

thruster_audio_logic() {
  level endon("kill_thrusters");
  self endon("death");
  self.prev_intensity = [];
  self.prev_intensity["x"] = 0;
  self.prev_intensity["y"] = 0;
  self.prev_intensity["z_up"] = 0;
  self.prev_intensity["z_down"] = 0;

  if(isDefined(level.prologue) && level.prologue == 1) {
    common_scripts\utility::flag_wait("prologue_ready_for_thrusters");
  }

  for(;;) {
    self waittill("thruster_update", var_0, var_1);
    level.bob_value = var_0;

    if("z_up" == var_1 || "z_down" == var_1) {
      level.bob_axis = "z";
    }
    else {
      level.bob_axis = var_1;
    }

    if(int(var_0) != self.prev_intensity[var_1]) {
      thread play_thruster_loop_audio(abs(var_0));
    }

    self.prev_intensity[var_1] = int(var_0);
  }
}

play_thruster_loop_audio(var_0) {
  switch (int(var_0)) {
    case 0:
      break;
    case 1:
      break;
    case 2:
      if(level.thruster_timer > 0) {
        thread thruster_timer_logic();
        level.thruster_oneshot stopsounds();
        level.thruster_oneshot playSound("space_jetpack_boost_oneshot");
      }

      break;
    case 3:
      if(level.thruster_timer > 0) {
        self playSound("space_jetpack_boost_start_large");
        thread thruster_timer_logic();
        level.thruster_oneshot stopsounds();
        level.thruster_oneshot playSound("space_jetpack_boost_oneshot_big");
      }

      break;
    case 4:
      if(level.thruster_sprint_timer > 0) {
        self playSound("space_jetpack_boost_start_sprint");
        thread thruster_sprint_interval();
        level.thruster_sprint stopsounds();
        level.thruster_sprint playSound("space_jetpack_boost_oneshot_sprint");
      }

      break;
  }
}

thruster_sprint_interval() {
  level.thruster_sprint_timer = 0;
  wait 0.5;
  level.thruster_sprint_timer = 1;
}

thruster_timer_logic() {
  level.thruster_timer = 0;
  wait 0.1;
  level.thruster_timer = 1;
}

player_thruster_logic() {
  level endon("kill_thrusters");
  self endon("death");

  for(;;) {
    common_scripts\utility::flag_wait("enable_player_thruster_audio");
    var_0 = [0, 0, 0, 0];

    while(common_scripts\utility::flag("enable_player_thruster_audio")) {
      var_1 = parse_input_data_for_thruster();

      if(var_1[0] != var_0[0] || var_1[1] != var_0[1] || var_1[2] != var_0[2] || var_1[3] != var_0[3]) {
        set_player_thruster_data(var_1, var_0);
      }

      var_0 = var_1;
      wait 0.05;
    }
  }
}

parse_input_data_for_thruster() {
  var_0 = [0, 0, 0, 0];
  var_1 = self getnormalizedmovement();

  for(var_2 = 0; var_2 < 2; var_2++) {
    var_0[var_2] = 0;

    if(abs(var_1[var_2]) > 0.1) {
      var_0[var_2] = 2;
    }

    if(var_0[var_2] > 0 && self issprinting()) {
      var_0[var_2] = 4;
    }

    if(var_1[var_2] < 0) {
      var_0[var_2] = var_0[var_2] * -1;
    }
  }

  if(self jumpbuttonpressed() || self fragbuttonpressed()) {
    var_0[2] = var_0[2] + common_scripts\utility::ter_op(self fragbuttonpressed(), 3, 2);
  }

  if(is_change_stance_pressed() || self secondaryoffhandbuttonpressed()) {
    var_0[3] = var_0[3] + common_scripts\utility::ter_op(self secondaryoffhandbuttonpressed(), 3, 2);
  }

  return var_0;
}

is_change_stance_pressed() {
  var_0 = 0;

  if(self buttonpressed("BUTTON_CROUCH") || self buttonpressed("BUTTON_PRONE") || self buttonpressed("BUTTON_B") || self buttonpressed("BUTTON_RSTICK")) {
    var_0 = 1;
  }

  return var_0;
}

set_player_thruster_data(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2] != var_1[var_2]) {
      level.player notify("thruster_update", var_0[var_2], level.axes[var_2]);
      wait 0.05;
    }
  }
}

get_thrusters_by_axis(var_0, var_1) {
  var_2 = [];

  switch (var_0) {
    case 0:
      if(var_1 >= 0) {
        var_2[var_2.size] = 5;
      }

      if(var_1 <= 0) {
        var_2[var_2.size] = 2;
      }

      break;
    case 1:
      if(var_1 >= 0) {
        var_2[var_2.size] = 3;
      }

      if(var_1 <= 0) {
        var_2[var_2.size] = 4;
      }

      break;
    case 2:
      if(var_1 >= 0) {
        var_2[var_2.size] = 1;
      }

      if(var_1 <= 0) {
        var_2[var_2.size] = 0;
      }

      break;
    default:
  }

  return var_2;
}

debug_thruster_text(var_0, var_1) {
  var_2 = [];

  if(isDefined(var_0)) {
    if(0 == var_0) {
      var_2[var_2.size] = "TOP";
    }
    else if(1 == var_0) {
      var_2[var_2.size] = "BOTTOM";
    }
    else if(2 == var_0) {
      var_2[var_2.size] = "FRONT";
    }
    else if(3 == var_0) {
      var_2[var_2.size] = "LEFT";
    }
    else if(4 == var_0) {
      var_2[var_2.size] = "RIGHT";
    }
    else if(5 == var_0) {
      var_2[var_2.size] = "BACK";
    }
  } else
    var_2[var_2.size] = "";

  if(isDefined(var_1)) {
    if(0 == var_1) {
      var_2[var_2.size] = "OFF";
    }
    else if(1 == var_1) {
      var_2[var_2.size] = "LOW";
    }
    else if(2 == var_1) {
      var_2[var_2.size] = "MEDIUM";
    }
    else {
      var_2[var_2.size] = "HIGH";
    }
  } else
    var_2[var_2.size] = "";

  return var_2;
}

debug_test_thruster_audio() {
  for(;;) {
    for(var_0 = 1; var_0 < 4; var_0++) {
      for(var_1 = 0; var_1 < level._thruster_ents.size; var_1++) {
        var_2 = debug_thruster_text(var_1, var_0);
        iprintln("Playing thruster " + var_2[0] + "'s " + var_2[1] + " burst audio");

        switch (var_0) {
          case 1:
            level._thruster_ents[var_1] playSound("space_jetpack_boost_start_small");
            break;
          case 2:
            level._thruster_ents[var_1] playSound("space_jetpack_boost_start_med");
            break;
          case 3:
            level._thruster_ents[var_1] playSound("space_jetpack_boost_start_large");
        }

        wait 2.0;
      }
    }

    for(var_0 = 0; var_0 < 2; var_0++) {
      for(var_1 = 0; var_1 < level._thruster_ents.size; var_1++) {
        var_2 = debug_thruster_text(var_1, var_0);

        switch (var_0) {
          case 0:
            iprintln("Playing thruster " + var_2[0] + "'s loop audio");
            break;
          case 1:
            iprintln("Playing thruster " + var_2[0] + "'s sprint loop audio");
            break;
        }

        wait 2.0;
        level._thruster_ents[var_1] stoploopsound();
        wait 1.0;
      }
    }
  }
}

wtf_is_it(var_0, var_1) {
  for(;;) {
    var_2 = level.player.origin;

    if(isDefined(var_1)) {} else {}

    wait 1.0;
  }
}
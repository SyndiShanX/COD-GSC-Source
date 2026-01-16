/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\loki_util.gsc
*****************************************************/

player_move_to_checkpoint_start(var_0) {
  var_1 = getent(var_0, "targetname");
  level.player setorigin(var_1.origin);
  level.player setplayerangles(var_1.angles);
}

allies_move_to_checkpoint_start(var_0, var_1) {
  for(var_2 = 0; var_2 < 3; var_2++) {
    var_3 = var_0 + "_ally_" + var_2;
    var_4 = common_scripts\utility::getstruct(var_3, "targetname");
    level.allies[var_2] forceteleport(var_4.origin, var_4.angles);

    if(isDefined(var_1)) {
      level.allies[var_2] maps\_utility::clear_force_color();
      level.allies[var_2] setgoalpos(var_4.origin);
    }
  }
}

spawn_allies() {
  level.allies = [];
  level.allies[level.allies.size] = spawn_ally("ally_0");
  level.allies[level.allies.size] = spawn_ally("ally_1");
  level.allies[level.allies.size] = spawn_ally("ally_2");
}

spawn_ally(var_0, var_1) {
  var_2 = undefined;

  if(!isDefined(var_1))
    var_2 = level.start_point + "_" + var_0;
  else
    var_2 = var_1 + "_" + var_0;

  var_3 = spawn_targetname_at_struct_targetname(var_0, var_2);

  if(!isDefined(var_3))
    return undefined;

  var_3 maps\_utility::make_hero();

  if(!isDefined(var_3.magic_bullet_shield)) {
    var_3 maps\_utility::magic_bullet_shield();
    var_3.animname = var_0;
  }

  return var_3;
}

spawn_targetname_at_struct_targetname(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  var_3 = common_scripts\utility::getstruct(var_1, "targetname");

  if(isDefined(var_2) && isDefined(var_3)) {
    var_2 maps\_utility::add_spawn_function(maps\_space_ai::enable_space);
    var_4 = var_2 maps\_utility::spawn_ai();

    if(!isDefined(var_3.angles))
      var_3.angles = level.player.angles;

    var_4 forceteleport(var_3.origin, var_3.angles);
    return var_4;
  }

  if(isDefined(var_2)) {
    var_2 maps\_utility::add_spawn_function(maps\_space_ai::enable_space);
    var_4 = var_2 maps\_utility::spawn_ai();
    iprintlnbold("Add a script struct called: " + var_1 + " to spawn him in the correct location.");
    var_4 teleport(level.player.origin, level.player.angles);
    return var_4;
  }

  iprintlnbold("failed to spawn " + var_0 + " at " + var_1);
  return undefined;
}

spawn_space_ai(var_0, var_1) {
  var_2 = var_0 maps\_utility::spawn_ai(1);
  var_2 thread maps\_space_ai::enable_space();
  var_3 = var_0 common_scripts\utility::get_target_ent();

  if(!isDefined(var_3.angles))
    var_3.angles = var_0.angles;

  var_2 forceteleport(var_3.origin, var_3.angles);

  if(isDefined(var_1) && var_1) {
    var_4 = getnode(var_3.target, "targetname");
    var_2 forceteleport(var_4.origin, var_4.angles);
  }

  var_2 thread follow_space_node_path(var_3);
  return var_2;
}

follow_space_node_path(var_0) {
  self endon("death");
  self endon("stop_following_node_path");

  while(isDefined(var_0) && isDefined(var_0.target)) {
    set_space_goal_node(var_0);
    self.goalradius = 8;
    self waittill("goal");
    var_0 = getnode(var_0.target, "targetname");
  }

  self notify("initial_path_completed");
}

set_space_goal_node(var_0) {
  var_1 = getnode(var_0.target, "targetname");

  if(isDefined(var_1)) {
    common_scripts\utility::waitframe();
    self setgoalnode(var_1);
  }
}

spawn_space_ai_from_targetname(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  var_2 = getent(var_0, "targetname");
  var_3 = spawn_space_ai(var_2, var_1);
  return var_3;
}

spawn_space_ais_from_targetname(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  var_2 = getEntArray(var_0, "targetname");
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = spawn_space_ai(var_5, var_1);
    var_3[var_3.size] = var_6;
  }

  return var_3;
}

xm25_destroy_hud(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.data_value))
    var_0.data_value destroy();

  if(isDefined(var_0.data_value_suffix))
    var_0.data_value_suffix destroy();

  var_0 destroy();
}

cleanup_ads_at_death() {
  self waittill("death");

  if(isDefined(self.hud0))
    xm25_destroy_hud(self.hud0);
}

watchweaponswitch(var_0) {
  self endon("death");

  for(;;) {
    self waittill("weapon_switch_started");

    if(isDefined(self.hud0))
      xm25_destroy_hud(self.hud0);

    if(!self.cg_drawbreathhint && self getcurrentweapon() != var_0) {
      setsaveddvar("cg_drawBreathHint", 1);
      self.cg_drawbreathhint = 1;
    }

    if(self getcurrentweapon() == var_0)
      self.weapon_change_timer = 20;
  }
}

watchads(var_0) {
  thread cleanup_ads_at_death();
  self endon("death");
  self.cg_drawbreathhint = 1;
  self.weapon_change_timer = 0;
  thread watchweaponswitch(var_0);

  for(;;) {
    var_1 = self adsbuttonpressed();
    var_2 = self getcurrentweapon();

    if(var_2 == var_0) {
      if(var_1 || self playerads() >= 0) {
        setsaveddvar("cg_drawBreathHint", 0);
        self.cg_drawbreathhint = 0;
      } else {
        setsaveddvar("cg_drawBreathHint", 1);
        self.cg_drawbreathhint = 1;
      }
    }

    if(!var_1 || var_2 != var_0 || self isreloading() || !isalive(self)) {
      if(isDefined(self.hud0))
        xm25_destroy_hud(self.hud0);

      if(isDefined(self.hud1))
        xm25_destroy_hud(self.hud1);
    }

    if(var_2 == var_0 && var_1 && self playerads() >= 0.75 && !isDefined(self.hud) && self.weapon_change_timer <= 0) {
      if(!isDefined(self.hud0))
        self.hud0 = create_hud_xm25_screen(1, 1, self);

      if(!isDefined(self.hud1))
        self.hud1 = create_hud_xm25_scanlines(1, 1);
    }

    if(isDefined(self.hud1)) {
      self.hud1.y = self.hud1.y + 1;

      if(self.hud1.y > 8)
        self.hud1.y = -4;
    }

    self.weapon_change_timer--;

    if(self.weapon_change_timer == 0) {
      if(var_2 == var_0) {
        setsaveddvar("cg_drawBreathHint", 0);
        self.cg_drawbreathhint = 0;
      } else {
        setsaveddvar("cg_drawBreathHint", 1);
        self.cg_drawbreathhint = 1;
      }
    }

    wait 0.05;
  }
}

create_hud_xm25_screen(var_0, var_1, var_2) {
  var_3 = "hud_xm25_temp";
  var_4 = newclienthudelem(var_2);
  var_4.x = 0;
  var_4.y = 0;
  var_4.sort = var_0;
  var_4.horzalign = "fullscreen";
  var_4.vertalign = "fullscreen";
  var_4.alpha = var_1;
  var_4 setshader(var_3, 640, 480);
  return var_4;
}

create_hud_xm25_scanlines(var_0, var_1) {
  var_2 = "hud_xm25_scanlines";
  var_3 = newhudelem();
  var_3.x = 0;
  var_3.y = 0;
  var_3.sort = var_0;
  var_3.horzalign = "fullscreen";
  var_3.vertalign = "fullscreen";
  var_3.alpha = var_1;
  var_3 setshader(var_2, 640, 480);
  return var_3;
}

jkuline(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(level.jkudebug) && level.jkudebug) {
    if(!isDefined(var_2)) {
      return;
    }
    if(!isDefined(var_3)) {
      return;
    }
    if(!isDefined(var_4)) {
      return;
    }
    if(!isDefined(var_5)) {
      return;
    }
    return;
    return;
    return;
    return;
  }
}

jkupoint(var_0, var_1, var_2, var_3) {
  if(isDefined(level.jkudebug) && level.jkudebug) {
    if(!isDefined(var_1))
      var_1 = 6;

    if(!isDefined(var_2))
      var_2 = (1, 1, 1);

    if(!isDefined(var_3))
      var_3 = 9999;
  }
}

jkuprint(var_0, var_1) {
  if(isDefined(level.jkudebug) && level.jkudebug)
    iprintln(var_0);
}

reassign_goal_volume(var_0, var_1) {
  if(!isarray(var_0))
    var_0 = maps\_utility::make_array(var_0);

  var_0 = maps\_utility::array_removedead_or_dying(var_0);
  var_2 = getent(var_1, "targetname");

  foreach(var_4 in var_0)
  var_4 setgoalvolumeauto(var_2);
}

enemy_marker() {
  var_0 = newhudelem();
  var_0 setshader("apache_target_lock", 1, 1);
  var_0.alpha = 0.0;
  var_0.color = (1, 0, 0);
  var_0 setwaypoint(1);
  var_1 = self.bulletsinclip;
  var_2 = 0;
  var_3 = 1.0;
  var_4 = 0.18;
  var_5 = 1;
  var_6 = 0;
  var_7 = 0;
  var_8 = 1;
  var_9 = 2;
  var_10 = 0.2;
  var_11 = 0;
  var_12 = 0;
  var_13 = 1;
  var_14 = 0;
  var_15 = 0;

  while(isalive(self) && isalive(level.player)) {
    var_0.x = self gettagorigin("j_spinelower")[0];
    var_0.y = self gettagorigin("j_spinelower")[1];
    var_0.z = self gettagorigin("j_spinelower")[2];

    if(var_14) {
      if(level.player playerads() == 1)
        var_10 = 0.997;
      else
        var_10 = 0.95;

      if(maps\_utility::player_looking_at(self.origin, var_10, 1))
        var_12 = 1;
      else
        var_12 = 0;
    }

    if(var_13) {
      if(maps\_utility::player_looking_at(self.origin, 0.2))
        var_2 = 1;
      else
        var_2 = 0;
    }

    if(var_15) {
      if(self.bulletsinclip != var_1)
        var_11 = 1;
      else
        var_11 = 0;

      var_1 = self.bulletsinclip;
    }

    if(var_6 == var_7) {
      if(var_2 && (var_12 && var_14 || var_11 && var_15)) {
        var_6 = var_8;
        var_3 = 1.0;
        var_5 = 1;
      } else if(var_2 && var_13)
        var_6 = var_9;
      else
        var_0.alpha = 0.0;
    }

    if(var_6 == var_8) {
      if(!var_2 && var_13)
        var_6 = var_7;
      else if(var_3 > 0) {
        var_6 = var_8;

        if(var_5) {
          var_0.alpha = 0.0;
          var_3 = var_3 - var_4;
          var_5 = 0;
        } else {
          var_0.alpha = 0.25;
          var_3 = var_3 - var_4;
          var_5 = 1;
        }
      } else
        var_6 = var_9;
    }

    if(var_6 == var_9) {
      if(!var_2 && var_13)
        var_6 = var_7;
      else if(var_11 && var_15) {
        var_6 = var_8;
        var_3 = 1.0;
      } else {
        var_6 = var_9;
        var_0.alpha = 0.25;
      }
    }

    common_scripts\utility::waitframe();
  }

  var_0 destroy();
}

spawn_enemy_death_hud_element(var_0) {
  var_1 = newhudelem();
  var_1 setshader("veh_hud_target_invalid", 1, 1);
  var_1.alpha = 0.25;
  var_1.color = (1, 0, 0);
  var_1.x = var_0[0];
  var_1.y = var_0[1];
  var_1.z = var_0[2];
  var_1 setwaypoint(1);
  wait 1.0;
  var_1 destroy();
}

player_boundaries_on(var_0, var_1, var_2, var_3) {
  level.player endon("death");

  if(!common_scripts\utility::flag("boundary_system_on")) {
    common_scripts\utility::flag_set("boundary_system_on");
    level thread player_boundary_check(var_0, var_1, var_2, var_3);

    if(!isDefined(var_1) || var_1 == 0)
      level thread player_boundary_vo_player(var_3);
  }
}

player_boundary_check(var_0, var_1, var_2, var_3) {
  level.player endon("death");
  level endon("boundary_system_off");

  if(!isDefined(var_2))
    var_2 = 7;

  while(common_scripts\utility::flag("boundary_system_on")) {
    common_scripts\utility::flag_waitopen("in_combat_area");

    if(!isDefined(var_0))
      level thread player_boundary_ai_focus();

    if(!isDefined(var_1) || var_1 == 0)
      level thread player_boundary_vo_player(var_3);

    level thread player_boundary_fail(var_2);
    common_scripts\utility::flag_wait("in_combat_area");

    if(!isDefined(var_0))
      level thread player_boundary_ai_return();
  }
}

player_boundary_ai_focus() {
  level.player endon("death");
  level endon("in_combat_area");
  level endon("boundary_system_off");
  wait 1.0;
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    var_2.favoriteenemy = level.player;
    var_2.baseaccuracy = 50;
  }
}

player_boundary_ai_return() {
  level.player endon("death");
  wait 1.0;
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    self.favoriteenemy = undefined;
    self.baseaccuracy = level.accuracy_enemy;
  }
}

player_boundary_vo_player(var_0) {
  level.player endon("death");
  level endon("in_combat_area");
  level endon("boundary_system_off");
  wait 1.5;
  var_1 = getaicount("axis");

  if(!isDefined(var_0)) {
    if(var_1 > 2)
      var_0 = ["loki_kgn_thompsonstickwiththe", "loki_kgn_thompsonweneedsupport", "loki_kgn_thompsonweretakingheavy", "loki_kgn_thompsonstayinformation", "loki_kgn_weresurrounded", "loki_kgn_therestoomanyof"];
    else
      var_0 = ["loki_kgn_thompsonstickwiththe", "loki_kgn_thompsonweneedsupport", "loki_kgn_thompsonstayinformation"];
  }

  level.allies[0] thread play_nag(var_0, "in_combat_area", 1, 8, 1, 8, "boundary_fail");
}

player_boundary_fail(var_0) {
  level.player endon("death");
  level endon("in_combat_area");
  level endon("boundary_system_off");
  wait(var_0);
  level.allies[0] notify("boundary_fail");
  wait 1.0;

  if(common_scripts\utility::flag("space_breach_done"))
    setdvar("ui_deadquote", & "LOKI_CONTROL_BOUNDS_FAIL");
  else
    setdvar("ui_deadquote", & "LOKI_BOUNDS_FAIL");

  level thread maps\_utility::missionfailedwrapper();
}

player_boundaries_off() {
  common_scripts\utility::flag_clear("boundary_system_on");
  common_scripts\utility::flag_set("in_combat_area");
  level.allies[0] notify("boundary_fail");
  level notify("boundary_system_off");
  level thread player_boundary_ai_return();
}

loki_autosave_now(var_0) {
  level.player endon("death");

  if(isDefined(var_0))
    level endon(var_0);

  if(common_scripts\utility::flag("boundary_system_on"))
    common_scripts\utility::flag_wait("in_combat_area");

  maps\_utility::autosave_now();
}

loki_autosave_by_name_silent(var_0, var_1) {
  level.player endon("death");

  if(isDefined(var_1))
    level endon(var_1);

  if(common_scripts\utility::flag("boundary_system_on"))
    common_scripts\utility::flag_wait("in_combat_area");

  maps\_utility::autosave_by_name_silent(var_0);
}

loki_autosave_by_name(var_0, var_1) {
  level.player endon("death");

  if(isDefined(var_1))
    level endon(var_1);

  if(common_scripts\utility::flag("boundary_system_on"))
    common_scripts\utility::flag_wait("in_combat_area");

  maps\_utility::autosave_by_name(var_0);
}

play_nag(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("death");
  self endon("stop nags");

  if(isDefined(var_6))
    self endon(var_6);

  var_9 = var_2;

  if(!isDefined(var_3))
    var_3 = 30;

  var_10 = 0;
  var_11 = 1;
  var_12 = 0;

  while(!common_scripts\utility::flag(var_1)) {
    var_10 = randomint(var_0.size);

    if(var_0.size > 1) {
      while(var_11 == var_10) {
        var_10 = randomint(var_0.size);
        wait 0.05;
      }
    }

    var_11 = var_10;
    var_13 = var_0[var_10];

    if(isDefined(var_7)) {
      var_14 = var_7[randomint(var_7.size)];
      thread maps\_anim::anim_single_solo(self, var_14);
    }

    if(!common_scripts\utility::flag(var_1)) {
      level notify("nagging");

      if(isDefined(var_8))
        maps\_space_ai::smart_radio_dialogue_facial(var_13, var_13);
      else
        maps\_utility::smart_radio_dialogue(var_13);
    } else
      break;

    wait(randomfloatrange(var_9 * 0.8, var_9 * 1.2));

    if(var_3 > var_9) {
      var_12 = var_12 + 1;

      if(var_12 == var_4) {
        var_12 = 0;
        var_9 = var_9 * var_5;

        if(var_3 < var_9)
          var_9 = var_3;
      }
    }
  }
}

space_death_fx() {
  playFXOnTag(common_scripts\utility::getfx("swim_ai_death_blood"), self, "j_spineupper");
  playFXOnTag(common_scripts\utility::getfx("sp_blood_float"), self, "j_spineupper");
  playFXOnTag(common_scripts\utility::getfx("factory_roof_steam_small_01"), self, "j_spineupper");
}

watch_input_infil(var_0, var_1) {
  level.player endon("death");
  level endon("infil_done");
  level.infil_allow_movement = 1;
  level.infil_path_offset = 0;
  level.infil_allowed_slide = 150;
  level.infil_movement_step = 3;

  for(;;) {
    var_2 = level.player getnormalizedmovement();

    if(var_2[1] >= 0.15) {
      iprintln(distance2d(level.player.origin, var_1.origin));
      common_scripts\utility::flag_clear("left_pressed");
      common_scripts\utility::flag_set("right_pressed");

      if(level.infil_allow_movement) {
        var_3 = anglestoright(var_1.angles);
        var_4 = var_0.origin + level.infil_movement_step * var_3;

        if(distance2d(var_4, var_1.origin) <= level.infil_allowed_slide) {
          var_0.origin = var_4;
          var_0 linkto(var_1, "tag_player");
        }
      }
    } else if(var_2[1] <= -0.15) {
      iprintln(distance2d(level.player.origin, var_1.origin));
      common_scripts\utility::flag_clear("right_pressed");
      common_scripts\utility::flag_set("left_pressed");

      if(level.infil_allow_movement) {
        var_3 = anglestoright(var_1.angles);
        var_4 = var_0.origin + level.infil_movement_step * -1 * var_3;

        if(distance2d(var_4, var_1.origin) <= level.infil_allowed_slide) {
          var_0.origin = var_4;
          var_0 linkto(var_1, "tag_player");
        }
      }
    } else {
      common_scripts\utility::flag_clear("left_pressed");
      common_scripts\utility::flag_clear("right_pressed");
    }

    common_scripts\utility::waitframe();
  }
}

adjust_movement_step_up(var_0, var_1) {
  level.player endon("death");
  level endon("infil_done");
  var_2 = var_1 * 20;
  var_3 = 0;
  var_4 = var_0 / var_2;

  for(var_5 = 0; var_5 < var_2; var_5++) {
    level.infil_movement_step = var_3;
    var_3 = var_3 + var_4;
    common_scripts\utility::waitframe();
  }
}

spawn_and_link_models_to_tags(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0;

  var_3 = 0;
  var_4 = getnumparts(self.model);

  for(var_5 = 0; var_5 < var_4; var_5++) {
    var_6 = getpartname(self.model, var_5);

    if(getsubstr(var_6, 0, 4) == "mdl_") {
      var_7 = getsubstr(var_6, 4, var_6.size - 4);
      jkuprint(var_7);

      if(var_6 == "mdl_loki_exterior_round_hatch_000")
        var_8 = level.combat_one_door;
      else if(var_6 == "mdl_space_exterior_airlock_entrance_000")
        var_8 = spawn("script_model", self gettagorigin(var_6));
      else if(var_6 == "mdl_space_module_5_000")
        var_8 = spawn("script_model", self gettagorigin(var_6));
      else {
        var_8 = spawn("script_model", self gettagorigin(var_6));
        var_8 setModel(var_7);
      }

      var_8.angles = self gettagangles(var_6);
      var_8 linkto(self, var_6);

      if(isDefined(var_0))
        var_8.targetname = var_0;

      if(isDefined(var_1))
        var_8 retargetscriptmodellighting(var_1);

      switch (var_6) {
        case "mdl_loki_truss_sail_003":
          level.hitsail = var_8;
          break;
        case "mdl_space_solar_array_damage_000":
          level.solar_array0 = var_8;
          break;
        case "mdl_space_solar_array_damage_001":
          level.solar_array1 = var_8;
          break;
        case "mdl_loki_cargo_container_01_000":
          level.cargo_container = var_8;
          var_8 thread maps\loki_audio::play_sound_on_moving_cover_object("scn_loki_moving_cover_obj_03_lr", 3.2);
          break;
        case "mdl_space_module_2_dest_split_01_000":
          level.module_ext = var_8;
          break;
        case "mdl_space_module_2_dest_split_01_int_000":
          level.module_int = var_8;
          break;
        case "mdl_space_module_2_dest_split_01_int_props_01_000":
          level.module_int_props01 = var_8;
          break;
        case "mdl_space_module_2_dest_split_01_int_props_02_000":
          level.module_int_props02 = var_8;
          var_8 thread maps\loki_audio::play_sound_on_moving_cover_object("scn_loki_moving_cover_obj_02_lr", 3.2);
          break;
        case "mdl_space_a25_ams_000":
          level.ams = var_8;
          var_8 thread maps\loki_audio::play_sound_on_moving_cover_object("scn_loki_moving_cover_obj_01_lr", 4.8);
          break;
        case "mdl_loki_crate_01_000":
          level.space_crate_01 = var_8;
          break;
        case "mdl_loki_crate_01_001":
          level.space_crate_02 = var_8;
          break;
        case "mdl_vehicle_space_shuttle_000":
          level.space_shuttle = var_8;
          break;
        case "mdl_loki_antenna_2_000":
          level.antenna_2 = var_8;
          break;
        case "mdl_loki_p6_battery_000":
          level.p6_battery = var_8;
          break;
      }
    }

    if(!var_2) {
      common_scripts\utility::waitframe();
      continue;
    }

    if(var_3 == 2) {
      var_3 = 0;
      common_scripts\utility::waitframe();
      continue;
    }

    var_3++;
  }
}

track_origin() {
  for(;;) {
    iprintln(self.origin);
    common_scripts\utility::waitframe();
  }
}

ammo_hack(var_0) {
  while(!isDefined(var_0) || var_0.size == 0) {
    var_0 = self getweaponslistall();
    wait 0.05;
  }

  for(var_1 = 0; var_1 < var_0.size; var_1++)
    self givestartammo(var_0[var_1]);
}

loki_drop_weapon(var_0, var_1) {
  var_2 = self.a.weaponpos["right"];
  jkuprint(getweaponmodel(var_2));
  jkuprint(getweaponattachments(var_2).size);

  if(var_2 != "none") {
    var_3 = create_world_model_from_ent_weapon(var_2);
    var_3 hide();
    var_3.origin = self gettagorigin("tag_weapon");
    var_3.angles = self gettagangles("tag_weapon");
    var_3 linkto(self, "tag_weapon");

    if(isDefined(var_1))
      common_scripts\utility::waittill_any("death", "damage");
    else
      self waittill("death");

    var_4 = create_drop_weapon_trigger(var_3);
    var_3 show();
    animscripts\shared::placeweaponon(var_2, "none");

    if(common_scripts\utility::cointoss())
      var_5 = randomintrange(-400, -100);
    else
      var_5 = randomintrange(100, 400);

    if(common_scripts\utility::cointoss())
      var_6 = randomintrange(-400, -100);
    else
      var_6 = randomintrange(100, 400);

    if(isDefined(var_0))
      var_3 physicslaunchserver(var_3.origin + (0, 0, 10), var_0);
    else if(common_scripts\utility::cointoss())
      var_3 physicslaunchserver(var_3.origin + (0, 0, 10), (var_5, 0, 0));
    else if(maps\_utility::within_fov_2d(self.origin, self.angles, level.player.origin, cos(45))) {
      jkuprint("launching weapon towards player");
      var_7 = bulletTrace(self.origin, self.origin + anglesToForward(self.angles) * 60, 0);

      if(var_7["surfacetype"] == "none")
        var_3 physicslaunchserver(var_3.origin + (0, 0, 10), anglesToForward(self.angles) * 1000);
      else
        jkuprint("trace failed");
    } else {
      jkuprint("not launching weapon towards player");
      var_3 physicslaunchserver(var_3.origin + (0, 0, 10), (var_5, 0, 0));
    }

    var_3 thread loki_drop_weapon_cleanup(var_4);
  }
}

create_drop_weapon_trigger(var_0, var_1) {
  var_2 = spawn("trigger_radius", var_0.origin, 0, 20, 20);
  var_2 enablelinkto();
  var_2 linkto(var_0);
  var_2 thread loki_drop_weapon_trigger(var_0, var_1);
  return var_2;
}

create_pushed_dropped_weapon(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", var_0);
  var_4.angles = var_1;
  var_4 setModel(var_2);
  var_4 hidepart("tag_clip");
  var_4.attachments = var_3;
  var_4 create_world_model_from_ent_weapon();
  var_4 physicslaunchserver(var_4.origin, anglesToForward(level.player.angles) * 2500, 500000, 5);
  wait 0.5;
  var_5 = create_drop_weapon_trigger(var_4, 1);
  var_4 thread loki_drop_weapon_cleanup(var_5, 10);
}

loki_drop_weapon_trigger(var_0, var_1) {
  var_0 endon("death");
  self waittill("trigger");

  if(!isDefined(var_1)) {
    var_2 = level.player getcurrentprimaryweapon();
    var_3 = weaponaltweaponname(var_2);
    var_4 = level.player getweaponammostock(var_2);
    var_5 = level.player getweaponammostock(var_3);
    jkuprint(var_4 + " " + var_2);
    jkuprint(var_5 + " " + var_3);
    level.player playSound("weap_pickup_large_plr");
    level.player setweaponammostock(var_2, var_4 + randomintrange(30, 60));
    level.player setweaponammostock(var_3, var_5 + 1);
    var_0 hidepart("tag_clip");
  }

  level thread create_pushed_dropped_weapon(var_0.origin, var_0.angles, var_0.model, var_0.attachments);
  var_0 delete();
  self delete();
}

loki_drop_weapon_cleanup(var_0, var_1) {
  self endon("death");

  if(!isDefined(var_1))
    var_1 = 45;

  wait(var_1);

  while(maps\_utility::player_looking_at(self.origin, 0.4, 1))
    common_scripts\utility::waitframe();

  if(isDefined(var_0) && isalive(var_0))
    var_0 delete();

  self delete();
}

create_world_model_from_ent_weapon(var_0) {
  if(isDefined(var_0)) {
    var_1 = getweaponmodel(var_0);
    var_2 = spawn("script_model", (0, 0, -10000));
    var_2 setModel(var_1);
    var_2.attachments = getweaponattachments(var_0);
  } else {
    var_2 = self;
    var_1 = self.model;
    var_2.attachments = self.attachments;
  }

  jkuprint("weapon attachment number: " + var_2.attachments.size);

  foreach(var_4 in var_2.attachments) {
    var_5 = getsubstr(var_4, 0, 4);

    switch (var_5) {
      case "acog":
        jkuprint(var_4);
        var_2 hidepart("tag_sight_on", var_1);
        var_2 attach("weapon_acog_iw6", "tag_acog_2", 1);
        break;
      case "eote":
        jkuprint(var_4);
        var_2 hidepart("tag_sight_on", var_1);
        var_2 attach("weapon_eotech_iw6", "tag_eotech", 1);
        break;
      case "refl":
        jkuprint(var_4);
        var_2 hidepart("tag_sight_on", var_1);
        var_2 attach("weapon_reflex_reddot", "tag_red_dot", 1);
        break;
      case "sile":
        jkuprint(var_4);
        var_2 attach("weapon_silencer_01", "tag_silencer", 1);
        break;
      default:
        jkuprint("attachment failed: " + var_4);
        break;
    }
  }

  return var_2;
}

create_rumble_ent(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    var_0 = 0;

  var_3 = common_scripts\utility::spawn_tag_origin();
  var_3.origin = level.player.origin + (0, 0, var_0);
  var_3 linkto(level.player);

  if(isDefined(var_1))
    var_3.script_noteworthy = var_1;

  if(isDefined(var_2))
    var_3 common_scripts\utility::delaycall(var_2, ::delete);

  return var_3;
}

player_physics_pulse(var_0) {
  if(isDefined(level.player.physics_pulse_on) && level.player.physics_pulse_on) {
    return;
  }
  level.player.physics_pulse_on = 1;
  var_1 = 0.15;
  var_2 = 96;

  while(!common_scripts\utility::flag(var_0)) {
    physicsexplosionsphere(level.player.origin, var_2, 1, var_1);
    wait 0.05;
  }
}

ally_physics_pulse(var_0) {
  level endon("death");

  if(isDefined(self.physics_pulse_on) && self.physics_pulse_on) {
    return;
  }
  self.physics_pulse_on = 1;

  while(!common_scripts\utility::flag(var_0)) {
    physicsexplosionsphere(self.origin, 45, 32, 0.15);
    wait 0.05;
  }
}

waittill_trigger_activate_looking_at(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 0.5;

  if(isDefined(var_3))
    var_7 = var_3;

  var_8 = 64;

  if(isDefined(var_2))
    var_8 = var_2;

  var_9 = var_0;

  if(isDefined(var_4)) {
    var_9 = var_0 common_scripts\utility::spawn_tag_origin();
    var_9 linkto(var_0, var_4, (0, 0, 0), (0, 0, 0));
  }

  if(!isDefined(var_5))
    var_5 = 5;

  var_10 = var_1;

  if(!common_scripts\utility::flag_exist(var_10))
    common_scripts\utility::flag_init(var_10);

  var_11 = 0;
  var_12 = 0;

  for(;;) {
    if(level.player ismeleeing()) {
      common_scripts\utility::flag_clear(var_10);
      var_12 = 0;
      level.player enableweaponpickup();
    } else if(level.player maps\_utility::player_looking_at(var_9.origin, var_7, 1)) {
      if(isDefined(var_6)) {
        if(level.player istouching(var_6)) {
          if(!common_scripts\utility::flag(var_10))
            var_11 = 1;
        } else {
          common_scripts\utility::flag_clear(var_10);
          var_12 = 0;
          level.player enableweaponpickup();
        }
      } else if(distance(level.player getEye(), var_9.origin) <= var_8) {
        if(!common_scripts\utility::flag(var_10))
          var_11 = 1;
      } else {
        common_scripts\utility::flag_clear(var_10);
        var_12 = 0;
        level.player enableweaponpickup();
      }
    } else {
      common_scripts\utility::flag_clear(var_10);
      var_12 = 0;
      level.player enableweaponpickup();
    }

    if(level.player usebuttonpressed())
      var_12++;

    if(common_scripts\utility::flag(var_10) && var_12 >= var_5) {
      break;
    }

    if(var_11) {
      common_scripts\utility::flag_set(var_10);
      maps\_utility::display_hint_timeout(var_1);
      var_11 = 0;
      level.player disableweaponpickup();
    }

    wait 0.05;
  }

  level.player enableweaponpickup();
  common_scripts\utility::flag_clear(var_10);

  if(isDefined(var_4))
    var_9 delete();
}

waittill_fire_trigger_activate(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = 5;

  var_3 = var_0;

  if(!common_scripts\utility::flag_exist(var_3))
    common_scripts\utility::flag_init(var_3);

  var_4 = 0;

  for(;;) {
    if(level.player attackbuttonpressed())
      var_4++;
    else
      var_4 = 0;

    if(level.player ismeleeing()) {
      common_scripts\utility::flag_clear(var_3);
      var_4 = 0;
    }

    if(common_scripts\utility::flag(var_3) && var_4 >= var_1) {
      break;
    }

    common_scripts\utility::flag_set(var_3);

    if(!isDefined(var_2) || isDefined(var_2) && !common_scripts\utility::flag(var_2))
      maps\_utility::display_hint_timeout(var_0);
    else
      common_scripts\utility::flag_clear(var_3);

    common_scripts\utility::waitframe();
  }

  common_scripts\utility::flag_clear(var_3);
}
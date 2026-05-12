/******************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\sg_events_v1\very_important_zombie.gsc
******************************************************************/

func_00D5() {
  precacheshader("zm_hud_type_escort_icon");
  precacheshader("zm_hud_type_escort_icon");
  basic_vip_init();
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_register_defaults("type_assassinate_common", ::basic_assassinate_run, 30, 0, 1);
}

basic_assassinate_run(param_00) {
  if(maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::not_the_final_objective()) {
    level.var_1CC0 = ["zombie_generic"];
  }

  var_01 = basic_vip_run(param_00, "assassinate_common");
  level.var_1CC0 = undefined;
  return common_scripts\utility::func_562E(var_01);
}

basic_assassinate_skip_cleanup(param_00) {
  level endon("sg_obj_timeout");
  level endon("flag_sg_VIP_killed");
  level endon("flag_sg_VIP_complete");
  level endon("flag_sg_VIP_timeout");
  level waittill("skipWave");
  param_00 lib_0563::func_AB99(undefined, undefined, 1000, undefined, "MOD_BULLET", "m1911_zm", param_00.var_116, (0, 0, 0), "tag_origin", 0, "tag_weapon");
}

basic_assassinate_model_swap() {
  self detachall();
  self setModel("ger_m_valtunic_r1");
  self.var_4BF2 = "zom_head_fdr04_org1";
  self attach(self.var_4BF2);
  self.var_4B5A = 1;
  self.var_4B6E = 0;
  self.var_4CAA = "ger_alfakey_valhat_r1c1";
  self attach(self.var_4CAA);
  self attach("ger_m_valpants_r1");
  self attach("ger_m_valbag_r1c1");
}

basic_assassinate_sprint_when_near_death() {
  level endon("sg_obj_timeout");
  level endon("flag_sg_VIP_killed");
  level endon("flag_sg_VIP_complete");
  level endon("flag_sg_VIP_timeout");
  wait_for_low_health_or_lack_of_patience();
  self.var_297D = ::basic_vip_custom_movemode_sprint;
}

wait_for_low_health_or_lack_of_patience() {
  level endon("sg_obj_timeout");
  level endon("flag_sg_VIP_killed");
  level endon("flag_sg_VIP_complete");
  level endon("flag_sg_VIP_timeout");
  var_00 = 0;
  var_01 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("type_assassinate_common_run_start");
  var_02 = self.var_BC;
  while(self.var_BC > var_02 / 2 && var_00 < var_01) {
    var_00 = var_00 + 0.15;
    wait(0.15);
  }
}

basic_vip_run(param_00, param_01) {
  lib_0547::func_A6F6();
  var_02 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("type_assassinate_common_other_zombies_count");
  var_03 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("type_assassinate_common_repitions");
  if(!lib_0547::func_5565(param_01, "assassinate_common")) {
    var_03 = 1;
  }

  if(level.objectivescompleted == 0) {
    var_04 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("type_assassinate_common_repitions_first_max");
    if(var_03 > var_04) {
      var_03 = var_04;
    }
  }

  var_05 = undefined;
  switch (param_01) {
    case "assassinate_common":
      level thread maps\mp\zombies\shotgun\_zombies_shotgun_rideau_global::run_rideau_bomber_comment();
      var_05 = common_scripts\utility::func_46B7("sg_assassinate_spawn_point", "targetname");
      break;

    case "type_escort":
      level thread maps\mp\zombies\shotgun\_zombies_shotgun_rideau_global::run_rideau_escort_bomber_comment();
      var_05 = common_scripts\utility::func_46B7("sg_escort_spawn_point", "targetname");
      break;
  }

  foreach(var_07 in var_05) {
    if(isDefined(var_07.var_8260)) {
      var_07.var_8C95 = 1;
    }

    var_07.ignoreforcedzombietype = 1;
  }

  var_05 = common_scripts\utility::func_F92(var_05);
  var_09 = 0;
  var_0A = 1;
  var_0B = 0;
  if(lib_0547::func_5565(param_01, "assassinate_common")) {
    var_0C = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("type_assassinate_common_red_skull_repitions");
    if(var_0C > 0) {
      var_03 = var_0C;
    }

    var_0D = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("type_assassinate_common_red_skull_count");
    if(var_0D > 0) {
      var_0A = var_0D;
    }

    if(var_0C == 0 && level.objectivescompleted >= 2 && level.var_744A.size > 1) {
      var_0B = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("type_assassinate_common_double_trouble_chance");
    }
  }

  var_0E = randomint(100);
  if(var_0E < var_0B) {
    var_0A = 2;
    var_03 = 1;
  }

  for(var_0F = 0; var_0F < var_03; var_0F++) {
    basic_vip_clear();
    if(var_09 == var_05.size) {
      var_09 = 0;
    }

    var_10 = spawn_new_important_bomber(param_00, param_01, var_02, var_05, var_09, var_0A);
    var_09++;
    maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::clear_all_waypoints();
    if(!common_scripts\utility::func_562E(var_10)) {
      break;
    } else {
      setomnvar("ui_zm_waypoint_ents_type", 0);
    }

    if(var_0F != var_03 - 1) {
      wait(maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("type_assassinate_common_next_spawn_time"));
    }
  }

  level thread maps\mp\_utility::func_6F74(::maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::set_waypoints_to_enemy, 0, "sg_VIP_finished");
  level notify("sg_VIP_finished");
  if(lib_0547::func_5565(param_01, "assassinate_common")) {
    if(common_scripts\utility::func_3C77("flag_sg_VIP_complete")) {
      common_scripts\utility::func_3C7B("flag_sg_VIP_complete");
      common_scripts\utility::func_3C7B("flag_sg_VIP_killed");
      common_scripts\utility::func_3C7B("flag_sg_VIP_timeout");
      return 0;
    }

    common_scripts\utility::func_3C7B("flag_sg_VIP_complete");
    common_scripts\utility::func_3C7B("flag_sg_VIP_killed");
    common_scripts\utility::func_3C7B("flag_sg_VIP_timeout");
    return 1;
  }

  if(common_scripts\utility::func_3C77("flag_sg_VIP_complete")) {
    common_scripts\utility::func_3C7B("flag_sg_VIP_complete");
    common_scripts\utility::func_3C7B("flag_sg_VIP_killed");
    common_scripts\utility::func_3C7B("flag_sg_VIP_timeout");
    return 1;
  }

  common_scripts\utility::func_3C7B("flag_sg_VIP_complete");
  common_scripts\utility::func_3C7B("flag_sg_VIP_killed");
  common_scripts\utility::func_3C7B("flag_sg_VIP_timeout");
  return 0;
}

basic_vip_get_waypoints(param_00) {
  var_01 = self;
  var_02 = [];
  while(isDefined(var_01.var_1A2)) {
    var_03 = common_scripts\utility::func_46B5(var_01.var_1A2, "targetname");
    var_02[var_02.size] = var_03;
    var_01 = var_03;
  }

  return var_02;
}

get_player_push_nodes(param_00, param_01) {
  var_02 = 14;
  var_03 = param_00.var_116;
  var_04 = [];
  var_05 = distance(param_00.var_116, param_01.var_116);
  var_06 = 0;
  var_07 = vectortoangles(param_01.var_116 - param_00.var_116);
  while(var_06 < var_05 - var_02) {
    var_06 = var_06 + var_02;
    var_08 = getclosestpointonnavmesh(vectorlerp(param_00.var_116, param_01.var_116, var_06 / var_05), self);
    var_09 = var_08 + var_02 * vectornormalize(anglestoright(var_07));
    var_0A = var_08 + var_02 * vectornormalize(anglestoright(var_07 + (0, 180, 0)));
    var_04 = common_scripts\utility::func_F6F(var_04, var_09);
    var_04 = common_scripts\utility::func_F6F(var_04, var_0A);
  }

  return var_04;
}

basic_vip_skip_cleanup(param_00) {
  level endon("sg_obj_timeout");
  level endon("flag_sg_VIP_timeout");
  level endon("flag_sg_VIP_complete");
  level endon("flag_sg_VIP_killed");
  level waittill("skipWave");
  param_00 lib_0563::func_AB99(undefined, undefined, 1000, undefined, "MOD_BULLET", "m1911_zm", param_00.var_116, (0, 0, 0), "tag_origin", 0, "tag_weapon");
}

basic_vip_move_to_destination(param_00, param_01) {
  var_02 = self;
  var_02 endon("death");
  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  if(param_01 < 2) {
    level thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::single_ent_health_display_start(var_02, -40, 1);
  }

  var_02 thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::important_zombie_show_destination(param_00, var_02.waypoints[var_02.waypoints.size - 1].var_116);
  var_02 childthread pushplayervib();
  for(var_03 = 0; var_03 < var_02.waypoints.size; var_03++) {
    var_02.var_1928 = var_02.waypoints[var_03];
    if(var_03 > 0) {
      var_02.previousbosswaitingpoint = var_02.waypoints[var_03 - 1];
    } else {
      var_02.previousbosswaitingpoint = var_02.waypoints[var_03];
    }

    while(distance(var_02.var_116, var_02.waypoints[var_03].var_116) > 75) {
      wait 0.05;
    }
  }

  common_scripts\utility::func_3C8F("flag_sg_VIP_complete");
  var_02.exploder_godmode = 0;
  var_02 lib_0563::func_AB99(undefined, undefined, var_02.var_BC + 1, undefined, "MOD_BULLET", "m1911_zm", var_02.var_116, (0, 0, 0), "tag_origin", 0, "tag_weapon");
  var_02 endon("death");
  wait 0.05;
  if(isDefined(var_02)) {
    var_02 suicide();
  }
}

pushplayervib() {
  var_00 = 85;
  var_01 = 25;
  var_02 = 32;
  for(;;) {
    var_03 = 0;
    var_04 = self.var_116 + var_01 * vectornormalize(anglesToForward(self.var_1D));
    foreach(var_06 in level.var_744A) {
      if(var_06 istouching(self) || distance2d(var_06.var_116, var_04) < var_02 && abs(var_06.var_116[2] - var_04[2]) < 64) {
        if(!isDefined(var_06.lastvibpush)) {
          var_06.lastvibpush = gettime();
        }

        if(var_06 isonground() && gettime() - var_06.lastvibpush > 300) {
          var_03 = 1;
          var_06.lastvibpush = gettime();
          var_07 = var_06.var_116 - self.var_116;
          var_07 = (var_07[0], var_07[1], 0);
          var_08 = var_00 * vectornormalize(var_07);
          var_08 = (var_08[0], var_08[1], 50);
          var_06 dodamage(20, self.var_116, self, self);
          var_06 setvelocity(var_08);
        }
      }
    }

    wait 0.05;
  }
}

basic_vip_custom_movemode_walk() {
  return "walk";
}

basic_vip_custom_movemode_sprint() {
  self.var_2FA4 = 1;
  return "sprint";
}

basic_vip_waitfor_done_death_or_timeout(param_00, param_01, param_02) {
  level endon("round complete");
  if(!common_scripts\utility::func_562E(param_00)) {
    foreach(var_04 in param_01) {
      thread basic_vip_timeout_listener(var_04);
    }
  }

  thread basic_vip_kill_listener(param_01);
  common_scripts\utility::func_3CA2("flag_sg_VIP_killed", "flag_sg_VIP_complete", "flag_sg_VIP_timeout");
  if(isDefined(param_02)) {
    param_02 notify("stop_modifying_wave");
  }

  return common_scripts\utility::func_3C77("flag_sg_VIP_killed");
}

basic_vip_timeout_listener(param_00) {
  level endon("sg_VIP_finished");
  level common_scripts\utility::knock_off_battery("sg_obj_timeout", "round complete");
  common_scripts\utility::func_3C8F("flag_sg_VIP_timeout");
  param_00 lib_0563::func_AB99(level.var_721C, level.var_721C, 1000, undefined, "MOD_BULLET", "m1911_zm", param_00.var_116, (0, 0, 0), "tag_origin", 0, "tag_weapon");
}

basic_vip_kill_listener(param_00) {
  level endon("sg_VIP_finished");
  var_01 = 1;
  while(!common_scripts\utility::func_3C77("flag_sg_VIP_complete") && any_vib_alive(param_00)) {
    wait 0.05;
  }

  common_scripts\utility::func_3C8F("flag_sg_VIP_killed");
}

any_vib_alive(param_00) {
  foreach(var_02 in maps\mp\agents\_agent_utility::func_43FD("all")) {
    if(common_scripts\utility::func_562E(var_02.sgvip)) {
      return 1;
    }
  }

  return 0;
}

basic_vip_init() {
  common_scripts\utility::func_3C87("flag_sg_VIP_complete");
  common_scripts\utility::func_3C87("flag_sg_VIP_killed");
  common_scripts\utility::func_3C87("flag_sg_VIP_timeout");
}

basic_vip_clear() {
  common_scripts\utility::func_3C7B("flag_sg_VIP_complete");
  common_scripts\utility::func_3C7B("flag_sg_VIP_killed");
  common_scripts\utility::func_3C7B("flag_sg_VIP_timeout");
}

spawn_new_important_bomber(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = [];
  level.zmb_event_waypoints = [];
  if(isDefined(level.zmb_waypoint_ents)) {
    foreach(var_08 in level.zmb_waypoint_ents) {
      if(isDefined(var_08)) {
        var_08 unlink();
        var_08 delete();
      }
    }
  }

  if(param_05 > 1) {
    for(var_0A = 0; var_0A < param_05; var_0A++) {
      var_06[var_06.size] = new_important_bomber(param_00, param_01, param_02, param_03[var_0A], param_05);
    }

    level thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::double_ent_health_display_setup(var_06[0], var_06[1]);
  } else {
    var_06[var_06.size] = new_important_bomber(param_00, param_01, param_02, param_03[param_04], param_05);
  }

  var_0B = spawnStruct();
  var_0B.zombie_count = param_02;
  var_0B thread maps\mp\mp_zombie_nest_ee_wave_manipulation::enforce_zombie_limit("stop_modifying_wave");
  return basic_vip_waitfor_done_death_or_timeout(level.zmb_sg_objectives[param_00].timeout_win, var_06, var_0B);
}

new_important_bomber(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_01) || param_01 == "type_escort") {
    var_05 = lib_054D::func_90BA("zombie_exploder", param_03, "escort guy", 0, 1, 0);
    var_05.var_57E8 = 1;
    var_05.var_55AB = 1;
  } else {
    var_05 = lib_054D::func_90BA("zombie_exploder", param_04, "vip", 0, 1, 0);
    var_05.nomutilate = 1;
    var_05.nopairmelee = 1;
    var_05.var_57FD = 1;
    var_05.var_57E8 = 1;
    var_05.ripsaw_hardened = 1;
  }

  var_05.waypoints = param_03 basic_vip_get_waypoints(var_05);
  var_05.var_1928 = var_05.waypoints[0];
  var_05.escort_zombie = 1;
  var_05.sgvip = 1;
  var_05.var_6701 = 1;
  var_05.var_55AB = 1;
  var_05.var_562B = 1;
  var_05.ispassiveexempt = 1;
  var_05.is_flamethrower_resistent = 1;
  var_05.shouldnotpreventlaststand = 1;
  var_05.var_6816 = 1;
  var_05.var_C29 = 0;
  var_05.var_297D = ::basic_vip_custom_movemode_walk;
  var_05.noenergyholdsecondary = 1;
  var_05.notthrowable = 1;
  if(isDefined(param_01) && param_01 == "assassinate_common") {
    level thread maps\mp\_utility::func_6F74(::maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::set_waypoints_to_enemy, 2, "sg_VIP_finished");
    var_05.var_9 = &"ZOMBIE_DLC3_IMPORTANT_TARGET";
    var_05 maps\mp\agents\_agent_common::func_83FD(maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("type_assassinate_common_health"));
    var_05 thread basic_vip_move_to_destination("zm_hud_type_escort_icon", param_04);
    var_05 thread basic_assassinate_sprint_when_near_death();
    var_05.exploder_godmode = 1;
    if(0) {
      var_05 basic_assassinate_model_swap();
    }

    var_06 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("type_assassinate_common_energy_hold");
    if(var_06 != 1) {
      var_05.noenergyhold = 1;
    }
  } else {
    level thread maps\mp\_utility::func_6F74(::maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::set_waypoints_to_enemy, 1, "sg_VIP_finished");
    var_05 maps\mp\agents\_agent_utility::func_83FE(level.var_746E);
    var_07 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("type_escort_health");
    var_07 = var_07 * maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("type_escort_health_redskull");
    var_05 maps\mp\agents\_agent_common::func_83FD(int(var_07));
    var_05 thread basic_vip_move_to_destination("zm_hud_type_escort_icon");
  }

  var_05.var_66EC = 1;
  return var_05;
}
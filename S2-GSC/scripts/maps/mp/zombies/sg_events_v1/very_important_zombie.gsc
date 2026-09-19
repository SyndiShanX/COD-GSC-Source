/**************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\sg_events_v1\very_important_zombie.gsc
**************************************************************************/

init() {
  _func_13F("zm_hud_type_escort_icon");
  _func_13F("zm_hud_type_escort_icon");
  basic_vip_init();
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_register_defaults("type_assassinate_common", ::basic_assassinate_run, 30, 0, 1);
}

basic_assassinate_run(var_0) {
  if(maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::not_the_final_objective())
    level._id_1CC0 = ["zombie_generic"];

  var_1 = basic_vip_run(var_0, "assassinate_common");
  level._id_1CC0 = undefined;
  return common_scripts\utility::_id_562E(var_1);
}

basic_assassinate_skip_cleanup(var_0) {
  level endon("sg_obj_timeout");
  level endon("flag_sg_VIP_killed");
  level endon("flag_sg_VIP_complete");
  level endon("flag_sg_VIP_timeout");
  level waittill("skipWave");
  var_0 _id_0563::_id_AB99(undefined, undefined, 1000, undefined, "MOD_BULLET", "m1911_zm", var_0.origin, (0, 0, 0), "tag_origin", 0, "tag_weapon");
}

basic_assassinate_model_swap() {
  self detachall();
  self setModel("ger_m_valtunic_r1");
  self.headmodel = "zom_head_fdr04_org1";
  self attach(self.headmodel);
  self._id_4B5A = 1;
  self._id_4B6E = 0;
  self._id_4CAA = "ger_alfakey_valhat_r1c1";
  self attach(self._id_4CAA);
  self attach("ger_m_valpants_r1");
  self attach("ger_m_valbag_r1c1");
}

basic_assassinate_sprint_when_near_death() {
  level endon("sg_obj_timeout");
  level endon("flag_sg_VIP_killed");
  level endon("flag_sg_VIP_complete");
  level endon("flag_sg_VIP_timeout");
  wait_for_low_health_or_lack_of_patience();
  self._id_297D = ::basic_vip_custom_movemode_sprint;
}

wait_for_low_health_or_lack_of_patience() {
  level endon("sg_obj_timeout");
  level endon("flag_sg_VIP_killed");
  level endon("flag_sg_VIP_complete");
  level endon("flag_sg_VIP_timeout");
  var_0 = 0;
  var_1 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("type_assassinate_common_run_start");
  var_2 = self.health;

  while(self.health > var_2 / 2 && var_0 < var_1) {
    var_0 = var_0 + 0.15;
    wait 0.15;
  }
}

basic_vip_run(var_0, var_1) {
  _id_0547::_id_A6F6();
  var_2 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("type_assassinate_common_other_zombies_count");
  var_3 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("type_assassinate_common_repitions");

  if(!_id_0547::_id_5565(var_1, "assassinate_common"))
    var_3 = 1;

  if(level.objectivescompleted == 0) {
    var_4 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("type_assassinate_common_repitions_first_max");

    if(var_3 > var_4)
      var_3 = var_4;
  }

  var_5 = undefined;

  switch (var_1) {
    case "assassinate_common":
      level thread maps\mp\zombies\shotgun\_zombies_shotgun_rideau_global::run_rideau_bomber_comment();
      var_5 = common_scripts\utility::_id_46B7("sg_assassinate_spawn_point", "targetname");
      break;
    case "type_escort":
      level thread maps\mp\zombies\shotgun\_zombies_shotgun_rideau_global::run_rideau_escort_bomber_comment();
      var_5 = common_scripts\utility::_id_46B7("sg_escort_spawn_point", "targetname");
      break;
  }

  foreach(var_7 in var_5) {
    if(isDefined(var_7._id_8260))
      var_7._id_8C95 = 1;

    var_7.ignoreforcedzombietype = 1;
  }

  var_5 = common_scripts\utility::array_randomize(var_5);
  var_9 = 0;
  var_10 = 1;
  var_11 = 0;

  if(_id_0547::_id_5565(var_1, "assassinate_common")) {
    var_12 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("type_assassinate_common_red_skull_repitions");

    if(var_12 > 0)
      var_3 = var_12;

    var_13 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("type_assassinate_common_red_skull_count");

    if(var_13 > 0)
      var_10 = var_13;

    if(var_12 == 0 && level.objectivescompleted >= 2 && level.players.size > 1)
      var_11 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("type_assassinate_common_double_trouble_chance");
  }

  var_14 = randomint(100);

  if(var_14 < var_11) {
    var_10 = 2;
    var_3 = 1;
  }

  for(var_15 = 0; var_15 < var_3; var_15++) {
    basic_vip_clear();

    if(var_9 == var_5.size)
      var_9 = 0;

    var_16 = spawn_new_important_bomber(var_0, var_1, var_2, var_5, var_9, var_10);
    var_9++;
    maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::clear_all_waypoints();

    if(!common_scripts\utility::_id_562E(var_16)) {
      break;
    } else
      _func_032("ui_zm_waypoint_ents_type", 0);

    if(var_15 != var_3 - 1)
      wait(maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("type_assassinate_common_next_spawn_time"));
  }

  level thread maps\mp\_utility::_id_6F74(maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::set_waypoints_to_enemy, 0, "sg_VIP_finished");
  level notify("sg_VIP_finished");

  if(_id_0547::_id_5565(var_1, "assassinate_common")) {
    if(common_scripts\utility::_id_3C77("flag_sg_VIP_complete")) {
      common_scripts\utility::_id_3C7B("flag_sg_VIP_complete");
      common_scripts\utility::_id_3C7B("flag_sg_VIP_killed");
      common_scripts\utility::_id_3C7B("flag_sg_VIP_timeout");
      return 0;
    } else {
      common_scripts\utility::_id_3C7B("flag_sg_VIP_complete");
      common_scripts\utility::_id_3C7B("flag_sg_VIP_killed");
      common_scripts\utility::_id_3C7B("flag_sg_VIP_timeout");
      return 1;
    }
  } else if(common_scripts\utility::_id_3C77("flag_sg_VIP_complete")) {
    common_scripts\utility::_id_3C7B("flag_sg_VIP_complete");
    common_scripts\utility::_id_3C7B("flag_sg_VIP_killed");
    common_scripts\utility::_id_3C7B("flag_sg_VIP_timeout");
    return 1;
  } else {
    common_scripts\utility::_id_3C7B("flag_sg_VIP_complete");
    common_scripts\utility::_id_3C7B("flag_sg_VIP_killed");
    common_scripts\utility::_id_3C7B("flag_sg_VIP_timeout");
    return 0;
  }
}

basic_vip_get_waypoints(var_0) {
  var_1 = self;

  for(var_2 = []; isDefined(var_1.target); var_1 = var_3) {
    var_3 = common_scripts\utility::_id_46B5(var_1.target, "targetname");
    var_2[var_2.size] = var_3;
  }

  return var_2;
}

get_player_push_nodes(var_0, var_1) {
  var_2 = 14;
  var_3 = var_0.origin;
  var_4 = [];
  var_5 = distance(var_0.origin, var_1.origin);
  var_6 = 0;

  for(var_7 = vectortoangles(var_1.origin - var_0.origin); var_6 < var_5 - var_2; var_4 = common_scripts\utility::_id_0F6F(var_4, var_10)) {
    var_6 = var_6 + var_2;
    var_8 = _func_2E1(_func_10A(var_0.origin, var_1.origin, var_6 / var_5), self);
    var_9 = var_8 + var_2 * vectorNormalize(anglestoright(var_7));
    var_10 = var_8 + var_2 * vectorNormalize(anglestoright(var_7 + (0, 180, 0)));
    var_4 = common_scripts\utility::_id_0F6F(var_4, var_9);
  }

  return var_4;
}

basic_vip_skip_cleanup(var_0) {
  level endon("sg_obj_timeout");
  level endon("flag_sg_VIP_timeout");
  level endon("flag_sg_VIP_complete");
  level endon("flag_sg_VIP_killed");
  level waittill("skipWave");
  var_0 _id_0563::_id_AB99(undefined, undefined, 1000, undefined, "MOD_BULLET", "m1911_zm", var_0.origin, (0, 0, 0), "tag_origin", 0, "tag_weapon");
}

basic_vip_move_to_destination(var_0, var_1) {
  var_2 = self;
  var_2 endon("death");

  if(!isDefined(var_1))
    var_1 = 1;

  if(var_1 < 2)
    level thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::single_ent_health_display_start(var_2, -40, 1);

  var_2 thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::important_zombie_show_destination(var_0, var_2.waypoints[var_2.waypoints.size - 1].origin);
  var_2 childthread pushplayervib();

  for(var_3 = 0; var_3 < var_2.waypoints.size; var_3++) {
    var_2._id_1928 = var_2.waypoints[var_3];

    if(var_3 > 0)
      var_2.previousbosswaitingpoint = var_2.waypoints[var_3 - 1];
    else
      var_2.previousbosswaitingpoint = var_2.waypoints[var_3];

    while(distance(var_2.origin, var_2.waypoints[var_3].origin) > 75)
      waitframe();
  }

  common_scripts\utility::flag_set("flag_sg_VIP_complete");
  var_2.exploder_godmode = 0;
  var_2 _id_0563::_id_AB99(undefined, undefined, var_2.health + 1, undefined, "MOD_BULLET", "m1911_zm", var_2.origin, (0, 0, 0), "tag_origin", 0, "tag_weapon");
  var_2 endon("death");
  waitframe();

  if(isDefined(var_2))
    var_2 suicide();
}

pushplayervib() {
  var_0 = 85;
  var_1 = 25;
  var_2 = 32;

  for(;;) {
    var_3 = 0;
    var_4 = self.origin + var_1 * vectorNormalize(anglesToForward(self.angles));

    foreach(var_6 in level.players) {
      if(var_6 istouching(self) || _func_0E1(var_6.origin, var_4) < var_2 && _func_0AE(var_6.origin[2] - var_4[2]) < 64) {
        if(!isDefined(var_6.lastvibpush))
          var_6.lastvibpush = gettime();

        if(var_6 _meth_8346() && gettime() - var_6.lastvibpush > 300) {
          var_3 = 1;
          var_6.lastvibpush = gettime();
          var_7 = var_6.origin - self.origin;
          var_7 = (var_7[0], var_7[1], 0);
          var_8 = var_0 * vectorNormalize(var_7);
          var_8 = (var_8[0], var_8[1], 50);
          var_6 _meth_8059(20, self.origin, self, self);
          var_6 _meth_82F7(var_8);
        }
      }
    }

    waitframe();
  }
}

basic_vip_custom_movemode_walk() {
  return "walk";
}

basic_vip_custom_movemode_sprint() {
  self._id_2FA4 = 1;
  return "sprint";
}

basic_vip_waitfor_done_death_or_timeout(var_0, var_1, var_2) {
  level endon("round complete");

  if(!common_scripts\utility::_id_562E(var_0)) {
    foreach(var_4 in var_1)
    thread basic_vip_timeout_listener(var_4);
  }

  thread basic_vip_kill_listener(var_1);
  common_scripts\utility::_id_3CA2("flag_sg_VIP_killed", "flag_sg_VIP_complete", "flag_sg_VIP_timeout");

  if(isDefined(var_2))
    var_2 notify("stop_modifying_wave");

  return common_scripts\utility::_id_3C77("flag_sg_VIP_killed");
}

basic_vip_timeout_listener(var_0) {
  level endon("sg_VIP_finished");
  level common_scripts\utility::_id_A70A("sg_obj_timeout", "round complete");
  common_scripts\utility::flag_set("flag_sg_VIP_timeout");
  var_0 _id_0563::_id_AB99(level.player, level.player, 1000, undefined, "MOD_BULLET", "m1911_zm", var_0.origin, (0, 0, 0), "tag_origin", 0, "tag_weapon");
}

basic_vip_kill_listener(var_0) {
  level endon("sg_VIP_finished");
  var_1 = 1;

  while(!common_scripts\utility::_id_3C77("flag_sg_VIP_complete") && any_vib_alive(var_0))
    waitframe();

  common_scripts\utility::flag_set("flag_sg_VIP_killed");
}

any_vib_alive(var_0) {
  foreach(var_2 in maps\mp\agents\_agent_utility::_id_43FD("all")) {
    if(common_scripts\utility::_id_562E(var_2.sgvip))
      return 1;
  }

  return 0;
}

basic_vip_init() {
  common_scripts\utility::flag_init("flag_sg_VIP_complete");
  common_scripts\utility::flag_init("flag_sg_VIP_killed");
  common_scripts\utility::flag_init("flag_sg_VIP_timeout");
}

basic_vip_clear() {
  common_scripts\utility::_id_3C7B("flag_sg_VIP_complete");
  common_scripts\utility::_id_3C7B("flag_sg_VIP_killed");
  common_scripts\utility::_id_3C7B("flag_sg_VIP_timeout");
}

spawn_new_important_bomber(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];
  level.zmb_event_waypoints = [];

  if(isDefined(level.zmb_waypoint_ents)) {
    foreach(var_8 in level.zmb_waypoint_ents) {
      if(isDefined(var_8)) {
        var_8 _meth_8057();
        var_8 delete();
      }
    }
  }

  if(var_5 > 1) {
    for(var_10 = 0; var_10 < var_5; var_10++)
      var_6[var_6.size] = new_important_bomber(var_0, var_1, var_2, var_3[var_10], var_5);

    level thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::double_ent_health_display_setup(var_6[0], var_6[1]);
  } else
    var_6[var_6.size] = new_important_bomber(var_0, var_1, var_2, var_3[var_4], var_5);

  var_11 = spawnStruct();
  var_11.zombie_count = var_2;
  var_11 thread maps\mp\mp_zombie_nest_ee_wave_manipulation::enforce_zombie_limit("stop_modifying_wave");
  return basic_vip_waitfor_done_death_or_timeout(level.zmb_sg_objectives[var_0].timeout_win, var_6, var_11);
}

new_important_bomber(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1) || var_1 == "type_escort") {
    var_5 = _id_054D::_id_90BA("zombie_exploder", var_3, "escort guy", 0, 1, 0);
    var_5._id_57E8 = 1;
    var_5._id_55AB = 1;
  } else {
    var_5 = _id_054D::_id_90BA("zombie_exploder", var_3, "vip", 0, 1, 0);
    var_5.nomutilate = 1;
    var_5.nopairmelee = 1;
    var_5._id_57FD = 1;
    var_5._id_57E8 = 1;
    var_5.ripsaw_hardened = 1;
  }

  var_5.waypoints = var_3 basic_vip_get_waypoints(var_5);
  var_5._id_1928 = var_5.waypoints[0];
  var_5.escort_zombie = 1;
  var_5.sgvip = 1;
  var_5._id_6701 = 1;
  var_5._id_55AB = 1;
  var_5._id_562B = 1;
  var_5.ispassiveexempt = 1;
  var_5.is_flamethrower_resistent = 1;
  var_5.shouldnotpreventlaststand = 1;
  var_5._id_6816 = 1;
  var_5._id_0C29 = 0;
  var_5._id_297D = ::basic_vip_custom_movemode_walk;
  var_5.noenergyholdsecondary = 1;
  var_5.notthrowable = 1;

  if(isDefined(var_1) && var_1 == "assassinate_common") {
    level thread maps\mp\_utility::_id_6F74(maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::set_waypoints_to_enemy, 2, "sg_VIP_finished");
    var_5._id_0009 = &"ZOMBIE_DLC3_IMPORTANT_TARGET";
    var_5 maps\mp\agents\_agent_common::_id_83FD(maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("type_assassinate_common_health"));
    var_5 thread basic_vip_move_to_destination("zm_hud_type_escort_icon", var_4);
    var_5 thread basic_assassinate_sprint_when_near_death();
    var_5.exploder_godmode = 1;

    if(0)
      var_5 basic_assassinate_model_swap();

    var_6 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("type_assassinate_common_energy_hold");

    if(var_6 != 1)
      var_5.noenergyhold = 1;
  } else {
    level thread maps\mp\_utility::_id_6F74(maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::set_waypoints_to_enemy, 1, "sg_VIP_finished");
    var_5 maps\mp\agents\_agent_utility::_id_83FE(level._id_746E);
    var_7 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("type_escort_health");
    var_7 = var_7 * maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("type_escort_health_redskull");
    var_5 maps\mp\agents\_agent_common::_id_83FD(int(var_7));
    var_5 thread basic_vip_move_to_destination("zm_hud_type_escort_icon");
  }

  var_5._id_66EC = 1;
  return var_5;
}
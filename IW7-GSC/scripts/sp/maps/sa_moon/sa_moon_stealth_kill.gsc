/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_moon\sa_moon_stealth_kill.gsc
************************************************************/

_id_E971() {
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_10626();
  thread _id_0F16::_id_3E3E("stealth_kill_start");
  thread _id_0F16::_id_3E3D("stealth_kill_start", undefined, 1);
  thread _id_0F16::_id_8EA3();
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_10ED3();
  visionsetalternate(5, 0);

  if(!isDefined(level._id_9DD0)) {
    level thread _id_0F16::_id_991E(undefined, 1);
    scripts\sp\maps\sa_moon\sa_moon_util::_id_E9CA(0);
    level thread _id_0E4B::_id_1348D(1);
    thread scripts\sp\maps\sa_moon\sa_moon_util::_id_8E92(1);
  }

  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_13EF9(0, 1);
  scripts\engine\utility::flag_set("stealth_kill_checkpoint_start");
  scripts\sp\utility::_id_F44E(1);
  wait 1;
  level.player _id_0B2A::_id_11429();
}

_id_E967() {
  level._id_4D9B = scripts\engine\utility::getStruct("data_center_door_open_anim_pos", "targetname");
  var_0 = scripts\sp\utility::_id_10639("generic_prop_x3");
  level._id_4D9B scripts\sp\anim::_id_1EC3(var_0, "fleet_data_enter");
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_10ED2();
  scripts\sp\maps\sa_moon\sa_moon_fx::_id_132CF(1);
  level._id_E99E["server_room_exit_door"] _id_0F05::_id_AED6(0);
  level._id_6754 thread _id_E96B();
  level._id_C47F thread _id_E96E(var_0);
  level._id_EA2C thread _id_E970();
  level thread _id_E96C();
  level thread _id_E96F();
  level thread _id_E972();
  level thread _id_E968();
  level thread _id_E96D();
  setsaveddvar("bg_cinematicFullScreen", "0");
  cinematicingameloopresident("sa_moon_fleet_data_loop_1");
  var_1 = getEntArray("fleet_data_screen_static", "targetname");

  foreach(var_3 in var_1) {
    var_3 hide();
  }

  scripts\engine\utility::flag_wait("stealth_kill_done");
  scripts\sp\utility::_id_2679();
}

_id_E968() {
  scripts\engine\utility::flag_wait_all("stealth_kill_guys_dead", "stealth_kill_runners_dead");
  scripts\engine\utility::flag_set("stealth_kill_done");
}

_id_E96B() {
  scripts\sp\utility::_id_F415(1);
  scripts\sp\utility::_id_F416(1);
  scripts\sp\utility::_id_F39F();
  self _meth_8250(1);
  scripts\sp\utility::_id_51E1("cqb");
  self allowedstances("crouch");
  scripts\engine\utility::flag_wait("stealth_kill_guys_alerted");
  self allowedstances("stand", "crouch", "prone");
  scripts\sp\utility::_id_54F7();
  var_0 = getnode("ethan_stealth_kill_node_01", "targetname");
  scripts\sp\utility::_id_F3E0(var_0.radius);
  self _meth_82EE(var_0);
  wait(randomfloatrange(0.5, 1.0));
  scripts\sp\utility::_id_F415(0);
  scripts\sp\utility::_id_F416(0);
  scripts\sp\utility::_id_551B();
  self._id_C3B2 = self._id_2894;
  scripts\sp\utility::_id_F2D8(5.0);
  scripts\engine\utility::flag_wait_all("stealth_kill_guys_dead", "stealth_kill_runners_dead");
  scripts\sp\utility::_id_F415(1);
  scripts\sp\utility::_id_F416(1);
  scripts\sp\utility::_id_F2D8(self._id_C3B2);
}

_id_E96E(var_0) {
  scripts\sp\utility::_id_F415(1);
  scripts\sp\utility::_id_F416(1);
  scripts\sp\utility::_id_F39F();
  self _meth_8250(1);
  scripts\sp\utility::_id_51E1("cqb");
  self allowedstances("crouch");

  if(!isDefined(level._id_9DD0)) {
    var_1 = getnode("omar_maintenance_node_04", "targetname");
    scripts\sp\utility::_id_F3E0(var_1.radius);
    self _meth_82EE(var_1);
    self waittill("goal");
    scripts\engine\utility::flag_set("open_maintenance_hatch_02_enabled");
    scripts\engine\utility::flag_wait("open_maintenance_hatch_02");
  }

  scripts\sp\utility::_id_54F7();
  level._id_4D9B scripts\sp\anim::_id_1F17(self, "fleet_data_enter");
  level thread scripts\sp\maps\sa_moon\sa_moon_maintenance::_id_E95A(var_0);
  self allowedstances("stand", "crouch", "prone");
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_B251(var_0);
  level._id_4D9B scripts\sp\anim::_id_1F2C([self, var_0], "fleet_data_enter");
  level.player scripts\sp\utility::_id_2B78(100, 1);
  level.player allowsprint(1);
  scripts\engine\utility::flag_set("stealth_kill_got_movement");
  var_1 = getnode("omar_stealth_kill_node_01", "targetname");
  scripts\sp\utility::_id_F3E0(var_1.radius);
  self _meth_82EE(var_1);
  var_2 = scripts\engine\utility::getStruct("omar_antigrav_grenade_target_org", "targetname");
  scripts\engine\utility::flag_wait("stealth_kill_guys_alerted");
  wait(randomfloatrange(0.75, 1.25));
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_F415(0);
  scripts\sp\utility::_id_F416(0);
  scripts\sp\utility::_id_551B();
  self._id_C3B2 = self._id_2894;
  scripts\sp\utility::_id_F2D8(5.0);
  scripts\engine\utility::flag_wait_all("stealth_kill_guys_dead", "stealth_kill_runners_dead");
  scripts\sp\utility::_id_28D7();
  scripts\sp\utility::_id_CF8B();
  scripts\sp\utility::_id_F415(1);
  scripts\sp\utility::_id_F416(1);
  scripts\sp\utility::_id_F2D8(self._id_C3B2);
  scripts\engine\utility::flag_wait("fleet_data_bink_start");
  var_0 delete();
}

_id_E970() {
  scripts\sp\utility::_id_F415(1);
  scripts\sp\utility::_id_F416(1);
  scripts\sp\utility::_id_F39F();
  self _meth_8250(1);
  scripts\sp\utility::_id_51E1("cqb");
  self allowedstances("crouch");
  scripts\engine\utility::flag_wait("stealth_kill_got_movement");
  scripts\sp\utility::_id_54F7();
  var_0 = getnode("salter_maintenance_node_04", "targetname");
  scripts\sp\utility::_id_F3E0(var_0.radius);
  self _meth_82EE(var_0);
  self allowedstances("stand", "crouch", "prone");
  var_0 = getnode("salter_stealth_kill_node_01", "targetname");
  scripts\sp\utility::_id_F3E0(var_0.radius);
  self _meth_82EE(var_0);
  wait(randomfloatrange(0.5, 1.0));
  scripts\engine\utility::flag_wait("stealth_kill_guys_alerted");
  scripts\sp\utility::_id_F415(0);
  scripts\sp\utility::_id_F416(0);
  scripts\sp\utility::_id_551B();
  self._id_C3B2 = self._id_2894;
  scripts\sp\utility::_id_F2D8(5.0);
  scripts\engine\utility::flag_wait_all("stealth_kill_guys_dead", "stealth_kill_runners_dead");
  scripts\sp\utility::_id_F415(1);
  scripts\sp\utility::_id_F416(1);
  scripts\sp\utility::_id_F2D8(self._id_C3B2);
}

_id_E972() {
  if(scripts\engine\utility::flag_exist("secondary_intro_vo")) {
    scripts\engine\utility::flag_wait("secondary_intro_vo");
  }

  scripts\sp\utility::_id_266F();
  level._id_6754 scripts\sp\utility::_id_10346("mn_eth_one_deck_down");
  level.player scripts\sp\utility::_id_1034D("mn_plr_get_it_open");
  wait 4;
  level._id_C47F scripts\sp\utility::_id_10346("mn_omr_got_movement");
  wait 4;
  level._id_EA2C scripts\sp\utility::_id_10346("mn_slt_check_low");
  scripts\engine\utility::flag_wait("stealth_kill_guys_alerted");
  level.player scripts\sp\utility::_id_1034D("mn_plr_lightem_up");
  scripts\engine\utility::flag_wait_all("stealth_kill_guys_dead", "stealth_kill_runners_dead");
  level._id_6754 scripts\sp\utility::_id_10346("mn_eth_clear_201");
  level._id_C47F scripts\sp\utility::_id_10346("mn_omr_all_clear_202");
}

_id_E96C() {
  scripts\sp\utility::_id_22CA("stealth_kill_guys", ::_id_10ED4);
  scripts\sp\utility::_id_22CA("stealth_kill_guys", ::_id_10ED5);
  var_0 = scripts\sp\utility::_id_22CD("stealth_kill_guys", 1);
}

_id_10ED5() {
  level endon("stealth_kill_guys_alerted");
  self endon("death");
  scripts\sp\utility::_id_F415(1);
  scripts\sp\utility::_id_F416(1);
  self.health = 20;
  scripts\sp\utility::_id_F2A8(1);
  self._id_1EF6 = scripts\engine\utility::getStruct(self.target, "targetname");

  for(;;) {
    self._id_1EF6 scripts\sp\anim::_id_1EC7(self, self._id_1EF6.script_noteworthy + "_enter");
    thread scripts\sp\anim::_id_1ECC(self, self._id_1EF6.script_noteworthy + "_loop", "stop_anim_loop");

    if(!isDefined(self._id_1EF6.target)) {
      break;
    }

    for(var_0 = 0; var_0 < randomintrange(2, 5); var_0++) {
      self waittillmatch("looping anim", "end");
    }

    self notify("stop_anim_loop");
    scripts\sp\anim::_id_1EC7(self, self._id_1EF6.script_noteworthy + "_exit");
    self._id_1EF6 = scripts\engine\utility::getStruct(self._id_1EF6.target, "targetname");
  }
}

_id_10ED4() {
  self addaieventlistener("gunshot");
  self addaieventlistener("gunshot_teammate");
  self addaieventlistener("silenced_shot");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("death");
  self addaieventlistener("projectile_impact");
  self addaieventlistener("grenade danger");
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "ai_events");
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "damage");
  level scripts\sp\utility::_id_178D(scripts\engine\utility::flag_wait, "stealth_kill_guys_alerted");
  level scripts\sp\utility::_id_178D(scripts\engine\utility::flag_wait, "player_wakes_server_room");
  scripts\sp\utility::_id_57D6();
  scripts\engine\utility::flag_set("stealth_kill_guys_alerted");

  if(isDefined(self) && isalive(self)) {
    self notify("stop_anim_loop");

    if(isDefined(self._id_1EF6)) {
      self._id_1EF6 notify("stop_anim_loop");
    }

    if(self _meth_81A6()) {
      scripts\sp\utility::anim_stopanimScripted();
    }

    wait(randomfloatrange(0.5, 1.0));
    var_0 = getEnt("stealth_kill_guys_gv", "targetname");

    if(isDefined(self) && isalive(self)) {
      scripts\sp\utility::_id_F39E();
      self _meth_82F1(var_0);
      scripts\sp\utility::_id_F415(0);
      scripts\sp\utility::_id_F416(0);
    }
  }
}

_id_E96F() {
  scripts\sp\utility::_id_22CA("stealth_kill_runners", ::_id_10ED6);
  scripts\sp\utility::_id_22CA("stealth_kill_runners", ::_id_10ED4);
  scripts\engine\utility::flag_wait("spawn_stealth_kill_runners");
  var_0 = scripts\sp\utility::_id_22CD("stealth_kill_runners", 1);
  wait 1.0;
  level endon("stealth_kill_guys_alerted");

  if(isDefined(var_0[0]) && isalive(var_0[0])) {
    var_0[0] scripts\sp\utility::_id_10347("mn_ss2_bridge_is_down");
  }

  if(isDefined(var_0[1]) && isalive(var_0[1])) {
    var_0[1] scripts\sp\utility::_id_10347("mn_ss3_cordon_and_search");
  }

  if(isDefined(var_0[0]) && isalive(var_0[0])) {
    var_0[0] scripts\sp\utility::_id_10347("mn_ss2_move_out_195");
  }
}

_id_10ED6() {
  level endon("stealth_kill_guys_alerted");
  self endon("death");
  scripts\sp\utility::_id_F415(1);
  scripts\sp\utility::_id_F416(1);
  self.health = 20;
  scripts\sp\utility::_id_C971(randomintrange(75, 100));
  var_0 = getnode(self.target, "targetname");
  scripts\sp\utility::_id_F3E0(var_0.radius);
  self _meth_82EE(var_0);
  self waittill("goal");
  self delete();
}

_id_E96D() {
  scripts\sp\maps\sa_moon\sa_moon_util::_id_1723("obj_shutdown_secondary_defenses", "current", &"SA_MOON_OBJ_SHUTDOWN_SECONDARY_DEFENSES");

  if(!isDefined(level._id_9DD0)) {
    scripts\engine\utility::flag_wait("open_maintenance_hatch_02");
  }

  objective_position(scripts\sp\utility::_id_C264("obj_shutdown_secondary_defenses"), (0, 0, 0));
}

#using_animtree("generic_human");

_id_E969() {
  level._id_EC85["omar"]["fleet_data_enter"] = % sa_moon_maintenance_hall_mco;
  level._id_EC85["generic"]["console_enter"] = % hm_grnd_yel_patrol_creepwalk_console_enter;
  var_0 = [];
  var_0[var_0.size] = % hm_grnd_yel_patrol_creepwalk_console_loop;
  var_0[var_0.size] = % hm_grnd_yel_patrol_creepwalk_console_twitch_adjustgun;
  var_0[var_0.size] = % hm_grnd_yel_patrol_creepwalk_console_loop;
  var_0[var_0.size] = % hm_grnd_yel_patrol_creepwalk_console_twitch_stepback;
  var_0[var_0.size] = % hm_grnd_yel_patrol_creepwalk_console_loop;
  var_0[var_0.size] = % hm_grnd_yel_patrol_creepwalk_console_twitch_touchscreen;
  var_0[var_0.size] = % hm_grnd_yel_patrol_creepwalk_console_loop;
  var_0[var_0.size] = % hm_grnd_yel_patrol_creepwalk_console_twitch_radio;
  var_0[var_0.size] = % hm_grnd_yel_patrol_creepwalk_console_loop;
  var_0[var_0.size] = % hm_grnd_yel_patrol_creepwalk_console_twitch_type1;
  var_0[var_0.size] = % hm_grnd_yel_patrol_creepwalk_console_loop;
  var_0[var_0.size] = % hm_grnd_yel_patrol_creepwalk_console_twitch_type2;
  level._id_EC85["generic"]["console_loop"] = var_0;
  level._id_EC85["generic"]["console_exit"] = % hm_grnd_yel_patrol_creepwalk_console_exit;
  level._id_EC85["generic"]["wall_panel_enter"] = % hm_grnd_yel_patrol_seekclear_repairwallunit_enter;
  var_1 = [];
  var_1[var_1.size] = % hm_grnd_yel_patrol_repairwallunit_loop;
  var_1[var_1.size] = % hm_grnd_yel_patrol_repairwallunit_twitch_switchtool;
  var_1[var_1.size] = % hm_grnd_yel_patrol_repairwallunit_loop;
  var_1[var_1.size] = % hm_grnd_yel_patrol_repairwallunit_twitch_sparkreact_sm;
  var_1[var_1.size] = % hm_grnd_yel_patrol_repairwallunit_loop;
  var_1[var_1.size] = % hm_grnd_yel_patrol_repairwallunit_twitch_sparkreact_md;
  var_1[var_1.size] = % hm_grnd_yel_patrol_repairwallunit_loop;
  var_1[var_1.size] = % hm_grnd_yel_patrol_repairwallunit_twitch_sparkreact_lg;
  var_1[var_1.size] = % hm_grnd_yel_patrol_repairwallunit_loop;
  var_1[var_1.size] = % hm_grnd_yel_patrol_repairwallunit_twitch_reachin;
  level._id_EC85["generic"]["wall_panel_loop"] = var_1;
  level._id_EC85["generic"]["wall_panel_exit"] = % hm_grnd_yel_patrol_seekclear_repairwallunit_exit;
  level._id_EC85["generic"]["floor_panel_enter"] = % hm_grnd_yel_patrol_seekclear_repairfloorunit_enter;
  var_2 = [];
  var_2[var_2.size] = % hm_grnd_yel_patrol_repairfloorunit_loop;
  var_2[var_2.size] = % hm_grnd_yel_patrol_repairfloorunit_twitch_switchtool;
  var_2[var_2.size] = % hm_grnd_yel_patrol_repairfloorunit_loop;
  var_2[var_2.size] = % hm_grnd_yel_patrol_repairfloorunit_twitch_sparkreact_sm;
  var_2[var_2.size] = % hm_grnd_yel_patrol_repairfloorunit_loop;
  var_2[var_2.size] = % hm_grnd_yel_patrol_repairfloorunit_twitch_sparkreact_md;
  var_2[var_2.size] = % hm_grnd_yel_patrol_repairfloorunit_loop;
  var_2[var_2.size] = % hm_grnd_yel_patrol_repairfloorunit_twitch_reachin;
  level._id_EC85["generic"]["floor_panel_loop"] = var_2;
  level._id_EC85["generic"]["floor_panel_exit"] = % hm_grnd_yel_patrol_seekclear_repairfloorunit_exit;
}

#using_animtree("script_model");

_id_E96A() {
  level._id_EC87["generic_prop_x3"] = #animtree;
  level._id_EC8C["generic_prop_x3"] = "generic_prop_x3";
  level._id_EC85["generic_prop_x3"]["fleet_data_enter"] = % sa_moon_maintenance_hall_door;
}
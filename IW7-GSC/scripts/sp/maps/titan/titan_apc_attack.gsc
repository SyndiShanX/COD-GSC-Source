/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\titan\titan_apc_attack.gsc
******************************************************/

_id_205A() {
  thread _id_2058("ridge");
  thread _id_956B();
  level._id_AB34 = [];
  level._id_E511 = [];
  level._id_2056 = [];
  var_0 = scripts\engine\utility::getStruct("start_apc_omar", "targetname");
  var_1 = scripts\engine\utility::getStruct("start_apc_atom", "targetname");
  var_2 = scripts\engine\utility::getStruct("start_apc_brooks", "targetname");
  var_3 = scripts\engine\utility::getStruct("start_apc_kashima", "targetname");
  var_4 = getEnt("c12_spawner_apc_attack", "targetname");
  level._id_AB34 = scripts\sp\utility::_id_22CD("gate_friendlies_left");
  level._id_E511 = scripts\sp\utility::_id_22CD("gate_friendlies_right");
  scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("start_apc", "targetname"));
  thread _id_739D(var_4);
  scripts\engine\utility::flag_set("c12_friendly_activate");
  scripts\engine\utility::flag_set("freighter_flyby");
  scripts\sp\maps\titan\titan_code::_id_10733();
  level._id_C47F _meth_80F1(var_0.origin, var_0.angles);
  level._id_2429 _meth_80F1(var_1.origin, var_1.angles);
  level._id_B33B _meth_80F1(var_2.origin, var_2.angles);
  level._id_B33E _meth_80F1(var_3.origin, var_3.angles);
  level._id_2093 = scripts\sp\utility::_id_8201("APC", "targetname");
  scripts\engine\utility::array_thread(level._id_2093, ::_id_2077);
  thread _id_109B0();
  setaudiotriggerstate("default", "nowind", 0);
  setaudiotriggerstate("titan_ext", "nowind", 0);
  setaudiotriggerstate("indoorrooms", "nowind", 0);
  scripts\engine\utility::exploder("fx_apc_drop_zone");
  scripts\engine\utility::exploder("fx_background_mist_1");
}

_id_2057() {
  scripts\engine\utility::flag_wait("freighter_flyby");

  if(scripts\sp\utility::_id_93A6()) {
    thread scripts\sp\specialist_MAYBE::_id_2683();
  }

  wait 0.05;

  if(!level.console) {
    waitforalltransients();
  }

  thread _id_2061();
  thread plr_sliding_check_apc_attack();
  thread _id_953F();
  thread _id_353B();
  thread _id_208D();
  thread _id_10636();
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_eth_anotherfreighter");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_ksh_thisplacegetsa");
  scripts\engine\utility::flag_wait("tower_spotted");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_ksh_towerleftside");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_brk_goteyesonthe");

  foreach(var_1 in level._id_10AC8) {
    var_1 scripts\sp\utility::_id_51E1("combat");
  }

  level._id_B33B scripts\sp\utility::_id_F3B5("blue");
  level._id_B33E scripts\sp\utility::_id_F3B5("blue");
  level._id_C47F scripts\sp\utility::_id_F3B5("blue");
  level._id_2429 scripts\sp\utility::_id_F3B5("orange");
  level.player scripts\sp\utility::_id_F526("normal");
  level._id_739C _id_A5C3();
  thread _id_2058("ridge");
  setsaveddvar("r_umbraAccurateOcclusionThreshold", 2000);
  setdvarifuninitialized("apc_debug", 0);
  var_3 = getaiarray("allies");
  var_3 = scripts\engine\utility::array_remove_array(var_3, level._id_10AC8);
  var_3 = scripts\engine\utility::array_remove(var_3, level._id_739C);

  foreach(var_5 in var_3) {
    var_5 scripts\sp\utility::_id_F3B5("r");
  }

  thread _id_F98C();
  scripts\engine\utility::flag_wait("c12_fight_transition");
  setsaveddvar("r_umbraAccurateOcclusionThreshold", -1);
  scripts\engine\utility::flag_set("apc_gate_crash_1");
  thread scripts\sp\maps\titan\titan_c12fight::_id_2151("init_arena_squads", 4, "fallback_pipes_front", "arena_ally_advance_1");
  thread scripts\sp\maps\titan\titan_c12fight::_id_2151("fallback_pipes_front", 0, "fallback_pipes_mid", "arena_ally_advance_2");
}

plr_sliding_check_apc_attack() {
  level endon("apc_gate_crash_1");
  level.player waittill("is_sliding");
  var_0 = scripts\engine\utility::play_loopsound_in_space("titan_hill_slide_plr_loop_lr", level.player.origin);
  var_0 linkTo(level.player);

  for(;;) {
    if(level.player scripts\sp\utility::_id_65DF("is_sliding") && level.player scripts\sp\utility::_id_65DB("is_sliding")) {
      wait 0.05;
      continue;
    }

    break;
  }

  var_0 stoploopsound();
}

_id_8316() {
  if(!scripts\engine\utility::flag("player_has_td")) {
    level.player scripts\sp\utility::_id_8294("apc_target_designator");
    level.player thread _id_11506();
  }

  scripts\engine\utility::flag_set("player_has_td");
}

_id_953F() {
  var_0 = getEntArray("base_attack_dropship", "targetname");
  var_1 = getEntArray("front_jeep", "targetname");
  var_2 = getspawnerarray("ref_gate_guys");
  scripts\engine\utility::flag_wait("tower_spotted");
  var_3 = getspawnerteamarray("axis");
  scripts\sp\utility::_id_22C7(var_3, ::_id_8EF2);
  var_4 = scripts\sp\utility::_id_22C6(var_2);

  foreach(var_6 in var_0) {
    var_6 scripts\sp\vehicle::_id_1080B();
  }

  foreach(var_9 in var_1) {
    var_9 scripts\sp\vehicle::_id_1080B();
  }

  level._id_76E2 = [];
  level._id_76E2 = getaiarray("axis");

  foreach(var_12 in level._id_76E2) {
    var_12 scripts\sp\utility::_id_51E1("casual_gun");
  }
}

_id_2058(var_0) {
  var_1 = 1.0;
  var_2 = 0.8;

  if(var_0 == "ridge") {
    var_2 = 0.8;
  } else if(var_0 == "gate") {
    var_2 = 0.4;
  }
}

_id_73E6() {
  var_0 = getEnt("spawner_left_apc", "targetname");
  var_1 = getEnt("spawner_right_apc", "targetname");
  var_2 = scripts\engine\utility::getStruct("left_tp_point_1", "targetname");
  var_3 = scripts\engine\utility::getStruct("left_tp_point_2", "targetname");
  var_4 = scripts\engine\utility::getStruct("left_tp_point_3", "targetname");
  var_5 = scripts\engine\utility::getStruct("right_tp_point_1", "targetname");
  var_6 = scripts\engine\utility::getStruct("right_tp_point_2", "targetname");
  var_7 = scripts\engine\utility::getStruct("right_tp_point_3", "targetname");
  scripts\engine\utility::flag_wait("tp_spawners_1");
  var_0.origin = var_2.origin;
  var_1.origin = var_5.origin;
  scripts\engine\utility::flag_wait("tp_spawners_2");
  var_0.origin = var_3.origin;
  var_1.origin = var_6.origin;
  scripts\engine\utility::flag_wait("tp_spawners_3");
  var_0.origin = var_4.origin;
  var_1.origin = var_7.origin;
}

_id_3A99() {
  scripts\engine\utility::flag_wait("freighter_flyby");
  var_0 = undefined;
  var_1 = undefined;

  while(!isDefined(var_1)) {
    var_0 = scripts\sp\utility::_id_7D43("tower_dropships", "targetname");

    if(var_0.size > 0) {
      foreach(var_3 in var_0) {
        if(var_3.classname == "script_vehicle_capitalship_freighter_small") {
          var_1 = var_3;
          break;
        }
      }
    }

    wait 0.05;
  }

  var_5 = var_1 scripts\sp\maps\titan\titan_code::_id_79D9(3900, var_1.angles);
  var_1._id_7442 = spawn("script_origin", var_5 - (0, 0, 100));
  var_1._id_7442 linkTo(var_1);
  var_1._id_7442.alias = "veh_freighter_thruster_01_lp";
  var_1._id_3BA8 = spawn("script_origin", var_1.origin);
  var_1._id_3BA8 linkTo(var_1);
  var_1._id_3BA8.alias = "veh_freighter_thruster_lfe_lp";
  var_6 = var_1 scripts\sp\maps\titan\titan_code::_id_79D9(3900, var_1.angles, 1);
  var_1._id_2722 = spawn("script_origin", var_6 + (0, 0, -300));
  var_1._id_2722 linkTo(var_1);
  var_1._id_2722.alias = "veh_freighter_thruster_02_lp";
  var_7 = [var_1._id_7442, var_1._id_3BA8, var_1._id_2722];

  foreach(var_9 in var_7) {
    if(soundexists(var_9.alias)) {
      var_9 scripts\sp\utility::_id_10461(var_9.alias, 1, 2, 1);
    }
  }

  var_1 waittill("death");
  var_1._id_2722 delete();
  var_1._id_7442 delete();
  var_1._id_3BA8 delete();
}

_id_208D() {
  scripts\engine\utility::flag_wait("tp_spawners_3");
  var_0 = scripts\sp\utility::_id_7C84("apc_enemy_spawners", "script_noteworthy");
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(isspawner(var_3)) {
      var_3 delete();
      var_1++;
    }
  }
}

_id_F98C() {
  level._id_209A = 0;
  scripts\sp\utility::_id_9329("axis", "allies");
  scripts\engine\utility::trigger_off("front_ally_triggers", "targetname");
  scripts\engine\utility::flag_wait("move_to_cliff");
  scripts\sp\utility::_id_15F1("cliffside_colors", "targetname");
  thread _id_7275();
  thread scripts\sp\maps\titan\titan_code::_id_C48A("titan_usf_letsformupon");
  thread _id_421C();
  thread _id_DFCF();
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0) {
    var_2 thread _id_4791();
  }

  level.player thread _id_2858();
  scripts\engine\utility::flag_set("refinery_intro_done");
  _id_DE50();
}

_id_353B() {
  var_0 = scripts\engine\utility::getStruct("bridge_sound", "targetname");
  var_1 = getEnt("bridge_path", "targetname");
  var_1 notsolid();
  var_1 connectpaths();
  level waittill("c12_destroy_bridge");
  level._id_739C scripts\sp\maps\titan\titan_code::_id_3550("right", 1);
  level._id_739C _id_0A05::_id_360D("right", var_0, "indirect_rockets_fired", 0);
  level._id_739C scripts\sp\utility::_id_135F1("indirect_rockets_fired", 3);
  level notify("destroy_bridge");
  level._id_739C _id_0A05::_id_352D("right");
  level._id_739C scripts\sp\maps\titan\titan_code::_id_3550("right", 0);
  var_1 disconnectPaths();
  wait 1;
  level notify("bridge_destroyed");
}

_id_7275() {
  level._id_2429 scripts\sp\utility::_id_F3B5("o");
  level._id_C47F scripts\sp\utility::_id_F3B5("p");
  level._id_B33B scripts\sp\utility::_id_F3B5("b");
  level._id_B33E scripts\sp\utility::_id_F3B5("b");
}

_id_4791() {
  scripts\sp\utility::_id_51E1("cqb");
  self.goalradius = 20;
  self waittill("goal");
  scripts\sp\utility::_id_4145();
}

_id_2061() {
  var_0 = getEntArray("trigger_multiple", "code_classname");
  var_1 = 0;
  var_2 = -42792;
  var_3 = -43593;
  var_4 = -63785.5;

  foreach(var_7, var_6 in var_0) {
    if(var_6.origin[0] < var_2 && var_6.origin[1] > var_3 && var_6.origin[2] < var_4) {
      var_6 delete();
      var_1++;
    }
  }
}

_id_421C() {
  var_0 = [];
  var_0 = scripts\engine\utility::array_combine(var_0, level._id_10AC8);
  var_1 = scripts\engine\utility::getStruct("c12_slide_anim", "targetname");
  var_0 = scripts\engine\utility::array_remove(var_0, level._id_B33E);
  thread _id_421B();
  thread _id_4219();

  foreach(var_3 in var_0) {
    var_3 thread _id_4215();
  }
}

_id_421B() {
  var_0 = getEnt("reload_toggle", "targetname");
  var_0 waittill("trigger", var_1);
  level.player scripts\engine\utility::allow_reload(0);
  _id_421A(var_0);
}

_id_421A(var_0) {
  while(level.player istouching(var_0)) {
    scripts\engine\utility::waitframe();
  }

  level.player scripts\engine\utility::allow_reload(1);
  _id_421B();
}

_id_DE50() {
  level endon("base_alerted");
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    var_2 scripts\sp\utility::_id_51E1("casual_gun");
  }

  level._id_C47F.goalradius = 10;
  level._id_C47F waittill("goal");
}

_id_6D16() {
  wait 7.5;

  if(level._id_209A == 0) {
    thread _id_D86C();
  }

  thread scripts\sp\maps\titan\titan_code::_id_D1D5("titan_plr_check");
  level._id_739C _meth_82EE(getnode("c12_cliffedge", "targetname"));

  if(!scripts\engine\utility::flag("player_has_td")) {
    _id_8316();
  }
}

_id_2858() {
  thread _id_2859();
  scripts\engine\utility::flag_wait("front_jeep_spawned");
  level notify("toggle_c12_teleportation");
  thread _id_1294A();
  thread _id_12948();
  scripts\sp\utility::_id_28D7("allies");
  scripts\sp\utility::_id_28D7("axis");
  level.player thread monitor_assault_launch();
  level waittill("launch_assault");
  level._id_C47F scripts\sp\maps\titan\titan_code::_id_10FC2();

  if(issubstr(self getcurrentweapon(), "apc_target_designator")) {
    var_0 = level._id_76E2.size;

    while(level._id_76E2.size == var_0) {
      level._id_76E2 = scripts\sp\utility::array_removedeadvehicles(level._id_76E2);
      scripts\engine\utility::waitframe();
    }
  }

  wait 1.3;
  scripts\engine\utility::flag_set("base_alerted");
  scripts\sp\utility::_id_28D8("allies");
  scripts\sp\utility::_id_28D8("axis");
  scripts\sp\utility::_id_CF8D();
}

monitor_assault_launch() {
  var_0 = 3600;
  var_1 = getEnt("apc_gate_1", "targetname");

  while(!scripts\engine\utility::flag("player_launched_assault")) {
    scripts\engine\utility::waittill_any("weapon_fired", "grenade_fire");
    var_2 = distance2d(var_1.origin, self.origin);

    if(var_2 < var_0) {
      scripts\engine\utility::flag_set("player_launched_assault");
    }

    scripts\engine\utility::waitframe();
  }

  level notify("launch_assault");
}

_id_2859() {
  scripts\engine\utility::flag_clear("crush_main_gate");
  var_0 = getEnt("base_alerted_volume", "targetname");
  var_1 = getEnt("front_gate_volume", "targetname");
  var_2 = scripts\engine\utility::getStruct("alarm_sound", "targetname");
  thread _id_9643(var_2);
  var_3 = getEnt("jeep_punch_veh_coll", "targetname");
  var_3 connectpaths();
  thread _id_A44E();
  scripts\engine\utility::flag_wait("base_alerted");
  scripts\sp\utility::_id_BDEC(4);
  scripts\sp\utility::clearthreatbias("axis", "allies");

  if(!scripts\engine\utility::flag("player_has_td")) {
    _id_8316();
  }

  thread _id_1070E();
  scripts\engine\utility::delaythread(3, ::_id_287C);
  thread scripts\sp\maps\titan\titan_code::_id_C48A("titan_usf_weregoinhot", 1);
  thread _id_76E3();
  thread _id_DE52();
  wait 0.05;

  if(!level.console) {
    waitforalltransients();
  }

  thread _id_DE51();
  thread _id_52A9();
  thread _id_529A();
  var_4 = scripts\sp\utility::_id_7D43("pipes_jeeps", "targetname");

  foreach(var_6 in var_4) {
    var_6 thread _id_A450(var_6.script_noteworthy);
  }

  wait 0.1;
  level._id_76E2 = scripts\sp\utility::array_removedeadvehicles(level._id_76E2);

  foreach(var_9 in level._id_10AC8) {
    var_9 thread scripts\sp\utility::_id_5522();
  }

  foreach(var_12 in level._id_76E2) {
    if(isalive(var_12)) {
      var_12 _meth_82F1(var_0);
    }
  }

  scripts\sp\utility::_id_15F1("jeep_destroyed_trigger", "targetname");
  var_14 = getaiarray("axis");

  foreach(var_12 in var_14) {
    var_12 scripts\sp\utility::_id_51E1("frantic");
  }

  level._id_2052 scripts\sp\utility::_id_65DD("hold_fire");
  var_17 = thread scripts\engine\utility::play_loopsound_in_space("emt_titan_alarm_01_lp", var_2.origin);
  var_2 thread _id_C847();

  if(level._id_209A == 0) {
    thread _id_D86C();
    thread _id_12FB3();
  }

  while(level._id_76E2.size > 2) {
    level._id_76E2 = scripts\sp\utility::array_removedeadvehicles(level._id_76E2);
    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_wait("jeep_destroyed");

  while(level._id_76E2.size > 0) {
    level._id_76E2 = scripts\sp\utility::array_removedeadvehicles(level._id_76E2);
    scripts\engine\utility::waitframe();
  }

  thread _id_288A();
  var_18 = getEnt("cliff_end_colors", "targetname");

  if(isDefined(var_18)) {
    scripts\engine\utility::trigger_off("cliff_end_colors", "targetname");
  }

  scripts\engine\utility::flag_set("refinery_reinforce");
  wait 15;
  var_17 delete();
}

_id_A450(var_0) {}

_id_287C() {
  var_0 = getEnt("basegate_right_door", "targetname");
  var_1 = getEnt("basegate_left_door", "targetname");
  var_2 = getEnt("basegate_lt_door_coll", "targetname");
  var_3 = getEnt("basegate_rt_door_coll", "targetname");
  thread _id_287B();
  thread _id_287D(var_0, var_3, 6);
  thread _id_287D(var_1, var_2, 6);
  thread _id_287F();
}

_id_287D(var_0, var_1, var_2) {
  wait(randomfloatrange(0.1, 0.6));
  var_0 rotateTo(var_0.angles + (0, 160, 0), 1, 0.15, 0.3);
  var_1 notsolid();
  var_1 connectpaths();
  scripts\engine\utility::flag_wait_or_timeout("crush_main_gate", var_2);
  wait 0.5;
  var_0 rotateTo(var_0.angles + (0, -160, 0), 1, 0.15, 0.3);
  var_1 solid();
  var_1 disconnectPaths();
  level notify("kill_stranded");
  wait 5;
  level notify("toggle_stranded_kill");
}

_id_287B() {
  var_0 = getEnt("base_garage_door", "targetname");
  var_0 moveTo(var_0.origin + (0, 0, 96), 1, 0.2, 0.3);
  var_0 connectpaths();
  wait 6;
  var_0 moveTo(var_0.origin + (0, 0, -96), 1, 0.15, 0.3);
  var_0 disconnectPaths();
}

_id_287F() {
  var_0 = getEntArray("base_gate_kill_trig", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread _id_287E();
  }
}

_id_287E() {
  level waittill("kill_stranded");

  while(!scripts\engine\utility::flag("init_mid_jeep")) {
    var_0 = getaiarray("axis");

    foreach(var_2 in var_0) {
      if(var_2 istouching(self) && (isai(var_2) && isalive(var_2))) {
        var_2 dodamage(var_2.health + 1000, var_2.origin);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

_id_C847() {
  wait 1;

  while(!scripts\engine\utility::flag("gate_destroyed")) {
    scripts\engine\utility::play_sound_in_space("titan_sf1_baseisunderattack", self.origin);
    wait 15;
  }

  scripts\engine\utility::play_sound_in_space("titan_sf1_enemiesareinside", self.origin);
  level notify("pa_dialogue_off");
}

_id_9643(var_0) {
  scripts\engine\utility::flag_wait("base_alerted");
  var_1 = scripts\sp\utility::_id_7D43("checkpoint_jeep", "script_noteworthy");
  var_1 = sortbydistance(var_1, var_0.origin);
  thread _id_3619(var_1[0]);
  wait 0.1;
  var_1[0] thread _id_A457();
  var_1[1] thread _id_A458();
  var_1[2] thread _id_A458();
}

_id_A457() {
  wait(randomfloatrange(0.1, 1.0));
  self vehicle_setspeed(randomintrange(35, 41), 10);
  scripts\engine\utility::flag_wait("jeep_at_final_location");
  scripts\sp\vehicle::_id_13253();
  self _meth_83E8();
}

_id_A458() {
  if(self.classname != "script_vehicle_corpse") {
    self vehicle_setspeed(0, 5);
    scripts\sp\vehicle::_id_13253();
    self _meth_83E8();
  }
}

_id_9798() {
  thread _id_1319F(self.script_noteworthy, self.script_parameters);
}

_id_1319F(var_0, var_1) {
  var_2 = getEnt(var_0, "targetname");
  var_2 notsolid();
  var_2 connectpaths();
  scripts\engine\utility::flag_wait(var_1);
  var_2 disconnectPaths();
}

_id_1319E() {
  var_0 = getEnt("midjeep_path_block", "targetname");
  var_1 = getEnt("jeep1_path_block", "targetname");
  var_2 = getEnt("jeep2_path_block", "targetname");
  var_0 notsolid();
  var_1 notsolid();
  var_2 notsolid();

  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "jeep1_path_block") {
      var_1 connectpaths();
      scripts\engine\utility::flag_wait("jeep_1_arrived");
      var_1 disconnectPaths();
    }

    if(self.script_noteworthy == "jeep2_path_block") {
      var_2 connectpaths();
      scripts\engine\utility::flag_wait("jeep_2_arrived");
      var_2 disconnectPaths();
    }

    if(self.script_noteworthy == "midjeep_path_block") {
      var_1 connectpaths();
      scripts\engine\utility::flag_wait("jeep_mid_arrived");
      var_1 disconnectPaths();
    }
  }
}

_id_B95F() {
  self waittill("damage", var_0, var_1);
  wait 1;
}

_id_A44E() {
  var_0 = getEntArray("jeep_punch_coll", "targetname");
  var_1 = getEnt("jeep_punch_veh_coll", "targetname");
  var_2 = getEnt("jeep_punch_damage", "targetname");
  level waittill("jeep_punched");
  thread _id_FBAD(var_1.origin);

  foreach(var_4 in var_0) {
    var_4 connectpaths();
  }

  wait 1;
  var_6 = getaiarray("axis");

  foreach(var_8 in var_6) {
    if(var_8 istouching(var_2)) {
      if(isalive(var_8)) {
        var_8 dodamage(1000, var_8.origin);
      }
    }
  }

  var_1 solid();
  var_1 disconnectPaths();
}

_id_FBAD(var_0) {
  wait 1.9;
  thread scripts\engine\utility::play_sound_in_space("scn_C12_titan_jeep_expl", var_0);
}

_id_52A9() {
  var_0 = getnode("shoot_bridge_node", "targetname");
  var_1 = getnode("post_shoot_node", "targetname");
  var_2 = getEnt("apc_gate_1", "targetname");
  var_2._id_1FBB = "refinery_gate";
  var_2 scripts\sp\utility::_id_23B7();
  var_3 = getEnt("apc_gate_coll_lt", "targetname");
  var_4 = getEnt("apc_gate_coll_rt", "targetname");
  var_3 linkTo(var_2, "titan_gate_anim_jnt_right_door");
  var_4 linkTo(var_2, "titan_gate_anim_jnt_left_door");
  var_3 disconnectPaths();
  var_4 disconnectPaths();
  var_5 = spawnStruct();
  var_5.origin = var_2.origin;
  var_5.angles = var_2.angles;
  level._id_739C._id_9BC1 = 1;
  var_6 = [var_2, level._id_739C];
  var_5 thread scripts\sp\anim::_id_1EC3(var_2, "second_gate_breakthrough");
  scripts\engine\utility::flag_wait("refinery_reinforce");
  var_5 thread destroy_gate_c12_anim(var_6);
  level waittill("c12_gate_destroy_ready");
  scripts\sp\utility::_id_15F5("move_marines_gate_crush");
  scripts\engine\utility::exploder("fx_c12_gate_destroy");
  scripts\engine\utility::exploder("fx_background_mist_1_opt");
  scripts\sp\utility::_id_10FEC("fx_background_mist_1");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_usf_standclear");
  wait 7;
  var_3 notsolid();
  var_4 notsolid();
  var_3 connectpaths();
  var_4 connectpaths();
  scripts\engine\utility::flag_set("gate_destroyed");
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 3);
  thread _id_547F();
  level notify("fallback_clear_1");
  scripts\sp\utility::_id_15F5("allies_gate_advance");
  level._id_739C._id_872A scripts\sp\utility::_id_F3D9(var_0);
  level._id_739C._id_872A scripts\sp\utility::_id_F3DD(64);
  level._id_739C._id_872A waittill("goal");
  level._id_739C scripts\sp\utility::_id_61C7();
  level notify("c12_destroy_bridge");

  if(!scripts\engine\utility::flag("tp_spawners_1")) {
    scripts\sp\utility::_id_15F5("front_c12_color_trigger");
  }

  thread _id_B98F();
  thread _id_B989();
  thread _id_B98A();
  level waittill("bridge_destroyed");
  level._id_739C._id_872A scripts\sp\utility::_id_F3D9(var_1);
  level._id_739C._id_872A scripts\sp\utility::_id_F3DD(64);
  level._id_739C._id_872A waittill("goal");
  level waittill("player_dir_known");
  level._id_C47F scripts\sp\utility::_id_F3B5("b");
}

destroy_gate_c12_anim(var_0) {
  level._id_739C scripts\sp\utility::_id_54F7();
  scripts\sp\anim::_id_1F17(level._id_739C, "second_gate_breakthrough");
  level notify("c12_gate_destroy_ready");
  scripts\sp\anim::_id_1F2C(var_0, "second_gate_breakthrough");
  level._id_739C scripts\sp\utility::_id_61C7();
}

_id_529A() {
  var_0 = scripts\engine\utility::getStruct("bridge_sound", "targetname");
  var_1 = scripts\engine\utility::spawn_tag_origin();
  var_1.origin = var_0.origin;
  level waittill("destroy_bridge");
  earthquake(0.75, 1.5, var_1.origin, 850);

  for(var_2 = 0; var_2 < 5; var_2++) {
    var_1.origin = var_0.origin + scripts\engine\utility::randomvectorrange(-256, 256);
    playFX(scripts\engine\utility::getfx("vfx_hms_c12_rocket_explosion_burst"), var_1.origin);
    var_1 playSound("rocket_explode");
    wait(randomfloatrange(0.1, 0.2));
  }

  var_1 delete();
  scripts\engine\utility::exploder("fx_c12_bridge_destroy");
  thread scripts\engine\utility::play_sound_in_space("scn_titan_catwalk_fall", var_0.origin);
  wait 0.2;
  thread scripts\engine\utility::play_sound_in_space("scn_titan_c12_bridge_rocket_exp", (-36309.7, -42500.5, -64672.5));
  wait 0.2;
  thread scripts\engine\utility::play_sound_in_space("scn_titan_c12_bridge_rocket_exp", (-36392.3, -42293.3, -64678.6));
  level._id_739C._id_9BC1 = undefined;
  scripts\engine\utility::flag_set("enable_c12_kill_reaction_vo");
}

_id_1065B() {
  var_0 = getspawnerarray("bridge_guy_spawners");
  var_1 = scripts\sp\utility::_id_22C6(var_0);

  foreach(var_3 in var_1) {
    var_3 scripts\sp\utility::_id_F3DD(32);
    var_3.forceragdollimmediate = 1;
    var_3 _meth_82EE(getnode(var_3.target, "targetname"));
  }

  level waittill("destroy_bridge");

  foreach(var_3 in var_1) {
    if(isalive(var_3)) {
      var_3 _meth_81D0();
    }
  }
}

_id_DFCF() {
  var_0 = getEntArray("titan_bridge_08_brushmodel", "targetname");
  var_1 = getEntArray("titan_bridge_08_model", "targetname");
  var_2 = getEntArray("titan_bridge_08_des_brushmodel", "targetname");
  var_3 = getEntArray("titan_bridge_08_des_model", "targetname");
  var_4 = scripts\engine\utility::array_combine(var_0, var_1);
  var_5 = scripts\engine\utility::array_combine(var_2, var_3);

  foreach(var_7 in var_5) {
    var_7 hide();
  }

  level waittill("destroy_bridge");

  foreach(var_7 in var_4) {
    var_7 delete();
  }

  foreach(var_7 in var_5) {
    var_7 show();
  }
}

_id_B989() {
  level endon("dir_known");
  scripts\sp\utility::_id_127B3("switch_omar_to_blue_left");
  scripts\engine\utility::waitframe();
  scripts\engine\utility::trigger_off("switch_omar_to_blue_right", "targetname");
  scripts\engine\utility::flag_set("fallback_to_rear");
  level notify("player_dir_known");
  level notify("dir_known");
}

_id_B98A() {
  level endon("dir_known");
  scripts\sp\utility::_id_127B3("switch_omar_to_blue_right");
  scripts\engine\utility::waitframe();
  scripts\engine\utility::trigger_off("switch_omar_to_blue_left", "targetname");
  scripts\engine\utility::flag_set("fallback_to_rear");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_plr_flankinem");
  level notify("player_dir_known");
  level notify("dir_known");
}

_id_D23C(var_0) {
  level endon("player_dir_known");
  self waittill("trigger", var_1);
  var_2 = getEnt(var_0, "targetname");

  if(isDefined(var_2)) {
    scripts\engine\utility::trigger_off(var_0, "targetname");
  }
}

_id_B98F() {
  var_0 = getEnt("switch_omar_to_blue_left", "targetname");
  var_1 = getEnt("switch_omar_to_blue_right", "targetname");
  var_2 = getEnt("right_path_1", "targetname");
  var_3 = getEnt("right_path_2", "targetname");
  var_1 thread _id_D23C("switch_omar_to_blue_left");
  var_2 thread _id_D23C("switch_omar_to_blue_left");
  var_2 thread _id_D23C("switch_omar_to_blue_right");
  var_3 thread _id_D23C("right_path_1");
  var_0 thread _id_D23C("switch_omar_to_blue_right");
}

_id_288A() {
  thread _id_B99B();
  thread _id_B99C();
  thread _id_1064C("apc_axis_left_front", "init_front_left_flank");
  thread _id_1064C("apc_axis_first_spawn", "refinery_reinforce");
  thread _id_1064C("apc_axis_right_building", "init_front_right_upper");
  thread _id_1064C("apc_axis_left_building", "init_front_left_building");
  thread _id_1064C("apc_axis_balcony_backup", "init_mid_balcony");
  thread _id_1064C("apc_axis_mid_spawn", "init_mid_lower");
  thread _id_1064C("apc_axis_second_spawn", "init_rear_left_bridge");
  thread _id_1064C("apc_axis_right_front", "init_rear_right_front");
  thread _id_1064C("apc_axis_rear_right_building", "init_rear_right_top");
  thread _id_1064C("apc_axis_rear_right_building_2", "init_rear_right_backup");
  thread _id_1064C("apc_axis_rear_2_support", "init_rear_2_support");
  thread _id_1064C("apc_axis_c12_arena", "init_arena_squads");
  thread _id_1064C("apc_axis_c12_arena_reinforce", "fallback_pipes_front");
  thread _id_1064E("jeep_mid_interior", "init_mid_jeep");
  thread _id_1064E("pipes_jeeps", "init_pipe_squads");
  thread _id_FBC0();
  thread scripts\sp\maps\titan\titan_c12fight::_id_FB54();
}

_id_FBC0() {
  scripts\engine\utility::flag_wait("init_mid_jeep");
  wait 2;
  thread scripts\engine\utility::play_sound_in_space("scn_titan_jeep_skid_02", (-34151, -41585, -65072));
}

_id_B99C() {
  level endon("player_rushed");
  scripts\engine\utility::flag_wait("refinery_reinforce");
  thread _id_1065B();
  thread _id_B956();
  thread _id_B991();
  thread _id_546A();
  level._id_739C thread _id_B99E();
  _id_B99A("crush_main_gate", "init_front_right_upper", undefined, 15, "fallback_to_front", undefined, undefined);
  _id_B99A("init_front_left_building", "init_mid_balcony", "init_mid_lower", 15, "fallback_to_mid", "front_base_mid_fork", undefined);
  _id_B99A(undefined, undefined, undefined, 13, "fallback_to_mid_2", "front_base_mid_fork_2", undefined);
  _id_B99A("init_rear_left_bridge", "init_rear_right_front", undefined, 10, "fallback_to_rear", "front_base_mid_fork_3", undefined);
  _id_B99A("init_rear_right_top", "init_rear_right_backup", "init_rear_2_support", 16, "fallback_to_rear_2", "left_path_1", "init_mid_jeep");
  _id_B99A(undefined, undefined, undefined, 8, "fallback_to_final", "pre_dropship_color", undefined);
  level notify("open_doors");
  _id_B99A(undefined, undefined, undefined, 4, "fallback_transition", "c12_transition", undefined);
}

_id_B99D() {
  level endon("toggle_refinery_teleport");
  level waittill("start_rush_teleport");
  var_0 = scripts\engine\utility::getStructArray("refinery_rush_tp_point_right", "targetname");
  var_1 = scripts\engine\utility::getStructArray("refinery_rush_tp_point_left", "targetname");

  foreach(var_3 in level._id_AD92) {
    var_4 = distance(level.player.origin, var_3.origin);

    if(isalive(var_3) && isai(var_3)) {
      if(!scripts\engine\utility::within_fov(level.player getEye(), level.player.angles, var_3 getEye(), cos(65))) {
        if(var_4 > 512) {
          if(scripts\engine\utility::flag("init_right_side_reinforcements")) {
            var_3 _id_1163B(var_0, 4);
          }

          if(scripts\engine\utility::flag("init_left_side_reinforcements")) {
            var_3 _id_1163B(var_1, 4);
          }
        }
      }
    }
  }
}

_id_1163B(var_0, var_1) {
  var_0 = sortbydistance(var_0, level.player.origin);
  var_2 = _id_9778(var_0, var_1);
  var_3 = randomintrange(0, var_1 - 1);
  self _meth_80F1(var_0[var_3].origin, var_0[var_3].angles);
  self cleargoalvolume();
  self _meth_82F1(var_2[var_3]);
}

_id_9778(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_1; var_3++) {
    var_4 = getEnt(var_0[var_3].target, "targetname");
    var_2 = scripts\engine\utility::array_add(var_2, var_4);
  }

  return var_2;
}

_id_76E3() {
  var_0 = getEnt("front_gate_volume", "targetname");
  var_1 = getEnt("front_gate", "targetname");
  scripts\engine\utility::flag_wait("jeep_destroyed");

  foreach(var_3 in level._id_76E2) {
    level._id_76E2 = scripts\sp\utility::array_removedeadvehicles(level._id_76E2);

    if(isalive(var_3)) {
      var_3 cleargoalvolume();
      var_3 _meth_82F1(var_0);
    }
  }

  scripts\engine\utility::flag_wait("gate_destroyed");

  foreach(var_3 in level._id_76E2) {
    level._id_76E2 = scripts\sp\utility::array_removedeadvehicles(level._id_76E2);

    if(isalive(var_3)) {
      var_3 cleargoalvolume();
      var_3 _meth_82F1(var_1);
    }
  }
}

_id_1070E() {
  var_0 = getEntArray("gate_backup", "targetname");
  var_1 = scripts\sp\utility::_id_22C6(var_0);
  level._id_76E2 = scripts\sp\utility::_id_22A2(level._id_76E2, var_1);
  scripts\engine\utility::flag_wait("init_mid_jeep");

  if(level._id_76E2.size > 0) {
    foreach(var_3 in level._id_76E2) {
      if(isDefined(var_3)) {
        var_3 _meth_81D0();
      }
    }
  }
}

_id_1064C(var_0, var_1) {
  scripts\engine\utility::flag_wait(var_1);
  var_2 = getEntArray(var_0, "targetname");

  foreach(var_4 in var_2) {
    if(level._id_AD92.size < level._id_AD93) {
      if(level._id_AD8F.size < level._id_AD90) {
        var_4 scripts\sp\utility::_id_10619();
        var_4.count = 3;
        scripts\engine\utility::waitframe();
      }
    }

    scripts\engine\utility::waitframe();
  }
}

_id_1064E(var_0, var_1) {
  scripts\engine\utility::flag_wait(var_1);
  var_2 = getEntArray(var_0, "targetname");

  foreach(var_4 in var_2) {
    var_5 = var_4 scripts\sp\vehicle::_id_1080B();
    var_5 thread _id_1319E();
  }
}

_id_B99E() {
  level endon("player_rushed");
  scripts\engine\utility::flag_wait("fallback_to_mid");
  scripts\engine\utility::flag_wait("fallback_to_mid_2");
  self waittill("goal");
  scripts\engine\utility::flag_set("c12_fork");
}

_id_B956() {
  level endon("player_dir_known");

  while(!scripts\engine\utility::flag("c12_fork")) {
    scripts\engine\utility::waitframe();
  }

  level notify("toggle_rush");
  level notify("toggle_rightside");
  level notify("dir_known");
  level notify("player_dir_known");
  scripts\engine\utility::trigger_off("switch_omar_to_blue_left", "targetname");
  scripts\engine\utility::trigger_off("switch_omar_to_blue_right", "targetname");
}

_id_B991() {
  level endon("toggle_rush");
  scripts\engine\utility::flag_wait_all("player_rushes", "tp_spawners_2");
  scripts\engine\utility::flag_wait_either("init_left_side_reinforcements", "init_right_side_reinforcements");
  _id_DE53(level._id_AD92, 1000);
  level notify("player_rushed");
  var_0 = ["init_mid_balcony", "init_front_left_building", "init_mid_lower", "init_rear_right_top", "init_rear_right_front"];
  var_1 = ["fallback_to_front", "fallback_to_mid", "fallback_to_mid_2", "fallback_to_rear"];
  var_2 = ["front_c12_color_trigger", "front_base_mid_fork", "front_base_mid_fork_2", "front_base_mid_fork_3"];
  _id_971A(var_0);
  _id_971A(var_1);
  _id_971B(var_2);
  thread _id_B99D();
  scripts\sp\utility::_id_6E7C("fallback_to_rear", ::_id_1064C, "apc_axis_rear_2_support", "init_rear_2_support");
  scripts\sp\utility::_id_6E7C("fallback_to_rear", scripts\sp\utility::_id_15F5, "trig_rush_goals");
  scripts\sp\utility::_id_6E7C("fallback_to_rear_2", scripts\sp\utility::_id_15F5, "trig_rush_goals_2");
  scripts\sp\utility::_id_6E7C("fallback_to_final", scripts\sp\utility::_id_15F5, "trig_rush_goals_3");
  level notify("start_rush_teleport");
  _id_B99A("init_rear_left_bridge", "init_rear_right_backup", "init_rear_2_support", 10, "fallback_to_rear", undefined, "init_mid_jeep");
  _id_B99A("init_rear_2_support", undefined, undefined, 10, "fallback_to_rear_2", "left_path_1", undefined);
  _id_B99A(undefined, undefined, undefined, 6, "fallback_to_final", "pre_dropship_color", undefined);
  _id_B99A(undefined, undefined, undefined, 4, "fallback_transition", "c12_transition", undefined);
  level notify("open_doors");
}

_id_971B(var_0) {
  foreach(var_2 in var_0) {
    scripts\sp\utility::_id_15F5(var_2);
    scripts\engine\utility::waitframe();
  }
}

_id_971A(var_0) {
  foreach(var_2 in var_0) {
    scripts\engine\utility::flag_set(var_2);
    scripts\engine\utility::waitframe();
  }
}

_id_B99B() {
  level endon("kill_refinery_enemy_counter");
  level._id_AD92 = [];
  level._id_AD91 = [];
  level._id_AD8F = [];
  level._id_AD93 = 22;
  level._id_AD90 = 32;

  for(;;) {
    level._id_AD92 = getaiarray("axis");
    level._id_AD91 = getaiarray("allies");
    level._id_AD92 = scripts\sp\utility::array_removedeadvehicles(level._id_AD92);
    level._id_AD91 = scripts\sp\utility::array_removedeadvehicles(level._id_AD91);
    level._id_AD8F = scripts\sp\utility::_id_22A2(level._id_AD92, level._id_AD91);
    scripts\engine\utility::waitframe();
  }
}

_id_DE53(var_0, var_1) {
  foreach(var_3 in var_0) {
    var_4 = distance(level.player.origin, var_3.origin);

    if(isalive(var_3) && isai(var_3)) {
      if(!scripts\engine\utility::within_fov(level.player getEye(), level.player.angles, var_3 getEye(), cos(65))) {
        if(var_4 > var_1) {
          var_3 _meth_81D0();
        }
      }
    }
  }
}

_id_DE52() {
  var_0 = getEnt("refinery_dropship_1_spawner", "targetname");
  scripts\engine\utility::flag_wait("init_dropship_seq");
  wait 3;
  var_1 = var_0 scripts\sp\vehicle::_id_1080B();
  var_1 scripts\sp\vehicle::_id_8441();
  var_1 scripts\engine\utility::waittill_notify_or_timeout("unloaded", 15);
  var_1 notify("unloaded");
  thread scripts\sp\maps\titan\titan_apc_canyon::_id_B987("player_ceiling_base");
  scripts\sp\utility::_id_10FEC("fx_c12_flip_car");
  level waittill("open_doors");
  wait 5;
  scripts\engine\utility::flag_wait("init_pipe_squads");
  level notify("kill_refinery_enemy_counter");
  level notify("kill_exploit_monitor");
  wait 5;
  scripts\engine\utility::flag_set("apc_move_up_3");
  scripts\engine\utility::flag_wait("c12_fight");
}

_id_DE51() {
  var_0 = 100;
  var_1 = getEnt("dropship_guys", "targetname");
  var_2 = getEnt("arena_door", "targetname");
  var_3 = getEnt("arena_door2", "targetname");
  var_2 moveTo(var_2.origin + (0, 0, 0), 0.5);
  var_3 moveTo(var_3.origin + (0, 0, 0), 0.5);
  var_2 disconnectPaths();
  var_3 disconnectPaths();
  level waittill("open_doors");
  playworldsound("scn_refinery_roll_up_door", var_2.origin);
  wait 0.05;

  if(!level.console) {
    waitforalltransients();
  }

  var_2 moveTo(var_2.origin + (0, 0, 200), 2);
  var_2 connectpaths();

  while(level._id_AD92.size > 0) {
    wait 0.5;
  }

  wait 1;
  scripts\sp\utility::_id_15F5("trig_ally_color_transition");
  wait 2;
  scripts\sp\utility::_id_15F5("transition_color");
  wait 2;
  playworldsound("scn_refinery_roll_up_door", var_3.origin);
  var_3 moveTo(var_3.origin + (0, 0, 216), 2);
  var_3 connectpaths();
  scripts\engine\utility::flag_set("init_arena_squads");
  scripts\engine\utility::flag_set("init_pipe_squads");
  scripts\engine\utility::flag_wait("c12_fight");
  var_2 moveTo(var_2.origin + (0, 0, -200), 0.5);
  var_2 disconnectPaths();

  if(scripts\engine\utility::flag("player_rushes") && scripts\engine\utility::flag("c12_fight") && !scripts\engine\utility::flag("c12_fight_ally")) {
    var_4 = getvehiclenode("apc1_gate_tp_point", "targetname");

    if(isDefined(level._id_2050)) {
      level._id_2050 vehicle_teleport(var_4.origin, var_4.angles);
    }

    var_5 = getvehiclenode("apc2_gate_tp_point", "targetname");

    if(isDefined(level._id_2052)) {
      level._id_2052 vehicle_teleport(var_5.origin, var_5.angles);
    }

    var_6 = getnode("c12_gate_tp_point", "targetname");

    if(isDefined(level._id_739C)) {
      level._id_739C _meth_80F1(var_6.origin, var_6.angles);
    }

    var_7 = scripts\engine\utility::getStructArray("tp_point_3_spot", "targetname");

    foreach(var_9 in level._id_10AC8) {
      for(var_10 = 0; var_10 < var_7.size; var_10++) {
        var_9 _meth_80F1(var_7[var_10].origin, var_7[var_10].angles);
      }
    }
  }
}

_id_B99A(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level endon("player_rushed");

  if(isDefined(var_2)) {
    scripts\engine\utility::flag_set(var_2);
  }

  if(isDefined(var_1)) {
    scripts\engine\utility::flag_set(var_1);
  }

  if(isDefined(var_0)) {
    scripts\engine\utility::flag_set(var_0);
  }

  wait 1;

  if(isDefined(var_3)) {
    while(level._id_AD92.size > var_3) {
      wait 3;
    }
  }

  if(isDefined(var_4)) {
    scripts\engine\utility::flag_set(var_4);
  }

  wait(randomfloatrange(4, 6));

  if(isDefined(var_6)) {
    while(!scripts\engine\utility::flag(var_6)) {
      scripts\engine\utility::waitframe();
    }
  }

  if(isDefined(var_5)) {
    scripts\sp\utility::_id_15F5(var_5);
  }
}

_id_7D04() {
  scripts\sp\utility::_id_F415(1);
  self waittill("goal");
  scripts\sp\utility::_id_F415(0);
}

_id_547F() {
  thread _id_5454();
  thread _id_546B();
  thread _id_5440();
  thread _id_545F();
  scripts\engine\utility::flag_wait("init_front_left_flank");
  scripts\sp\maps\titan\titan_code::_id_D1D5("titan_plr_punchinleft");
  scripts\sp\maps\titan\titan_code::_id_A556("titan_ksh_gotyourback");
  scripts\sp\maps\titan\titan_code::_id_30FC("titan_brk_imwithyoucaptain");
  scripts\sp\maps\titan\titan_code::_id_C48A("titan_usf_hittintheotherside");
}

_id_5454() {
  scripts\engine\utility::flag_wait("apc_move_up_2");

  if(level._id_209A == 1 || level._id_209A == 0) {
    level._id_209A = 0;
    thread _id_D86C();
    thread _id_12FB3();
  }
}

_id_546B() {
  scripts\engine\utility::flag_wait("dialogue_multiple_contacts");
  scripts\sp\maps\titan\titan_code::_id_30FC("titan_brk_multiplecontacts");
}

_id_5440() {
  scripts\engine\utility::flag_wait("gate_destroyed");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_ksh_holycrapyousee");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_ksh_youseewhatitdid");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_usf_Weremovingup");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_ksh_gotoneonthe");
  level waittill("pa_dialogue_off");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_brk_theyrefallinback");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_usf_keeppushin");
  scripts\sp\utility::_id_127AE("pipes_jeeps", "target");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_ksh_wereabouthalfway");
}

_id_545F() {
  scripts\engine\utility::flag_wait("init_pipe_squads");
  wait 2;
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_brk_enemyreinforcementstake");
}

_id_546A() {
  level._id_ACE5 = [1, 2, 3, 4, 5];
  wait 15;

  if(!scripts\engine\utility::flag("fallback_to_mid")) {
    _id_5469();
  }

  wait 20;

  if(!scripts\engine\utility::flag("fallback_to_rear_2")) {
    _id_5469();
  }

  wait 15;

  if(!scripts\engine\utility::flag("fallback_to_final")) {
    _id_5469();
  }

  wait 10;

  if(!scripts\engine\utility::flag("fallback_transition")) {
    _id_5469();
  }

  wait 25;

  if(!scripts\engine\utility::flag("fallback_pipes_front")) {
    _id_5469();
  }
}

_id_5469(var_0) {
  level._id_ACE5 = scripts\engine\utility::array_randomize(level._id_ACE5);

  if(level._id_ACE5[0] == 1) {
    scripts\sp\maps\titan\titan_code::_id_134B7("titan_omr_stayfocusedmiss");
    level._id_ACE5 = scripts\sp\utility::array_remove_index(level._id_ACE5, 1);
  } else if(level._id_ACE5[0] == 2) {
    scripts\sp\maps\titan\titan_code::_id_134B7("titan_brk_objectivenag9");
    level._id_ACE5 = scripts\sp\utility::array_remove_index(level._id_ACE5, 2);
  } else if(level._id_ACE5[0] == 3) {
    scripts\sp\maps\titan\titan_code::_id_134B7("titan_usf_keephittinemwith");
    level._id_ACE5 = scripts\sp\utility::array_remove_index(level._id_ACE5, 3);
  } else if(level._id_ACE5[0] == 4) {
    scripts\sp\maps\titan\titan_code::_id_134B7("titan_brk_objectivenag6");
    level._id_ACE5 = scripts\sp\utility::array_remove_index(level._id_ACE5, 4);
  } else if(level._id_ACE5[0] == 5) {
    scripts\sp\maps\titan\titan_code::_id_134B7("titan_eth_objectivenag7");
    level._id_ACE5 = scripts\sp\utility::array_remove_index(level._id_ACE5, 5);
  }
}

_id_D86C() {
  var_0 = newhudelem();
  var_0 settext(&"TITAN_USE_TARGETING_SYSTEM");
  var_0.horzalign = "center";
  var_0.vertalign = "middle";
  var_0.x = -185;
  var_0.y = -25;
  var_0.alpha = 0;
  var_0.fontscale = 2;
  var_1 = newhudelem();
  var_1 settext(&"TITAN_FIRE_APC");
  var_1.horzalign = "center";
  var_1.vertalign = "middle";
  var_1.x = -100;
  var_1.y = -25;
  var_1.alpha = 0;
  var_1.fontscale = 2;
  _id_35A3(var_0, var_1);
  level.player _meth_8497(1);
}

_id_35A3(var_0, var_1) {
  self endon("timeout");
  thread scripts\sp\utility::timeout(12);

  while(level._id_209A == 0) {
    if(!issubstr(level.player getcurrentweapon(), "apc_target_designator")) {
      level.player _meth_8496(&"TITAN_USE_TARGETING_SYSTEM");
      thread _id_11981();
    }

    level.player scripts\engine\utility::waittill_any("weapon_change", "weapon_dropped");

    if(issubstr(level.player getcurrentweapon(), "apc_target_designator")) {
      level.player _meth_8496(&"TITAN_FIRE_APC");
      thread _id_11982();
    }
  }
}

_id_11981() {
  var_0 = 0;

  while(var_0 < 12) {
    level.player playSound("ui_chyron_plusminus");
    var_0 = var_0 + 1;
    wait 0.05;
  }
}

_id_11982() {
  var_0 = 0;

  while(var_0 < 9) {
    level.player playSound("ui_chyron_plusminus");
    var_0 = var_0 + 1;
    wait 0.05;
  }
}

_id_208B(var_0, var_1) {
  wait 1;

  while(!scripts\engine\utility::flag("apc_attack_done") && isDefined(var_0)) {
    while(var_0.size >= 1) {
      wait 0.5;
      var_0 = scripts\sp\utility::_id_DFEB(var_0);
    }

    var_2 = var_1 scripts\sp\utility::_id_10619();

    if(isDefined(var_2) && isalive(var_2)) {
      if(scripts\engine\utility::flag("tp_spawners_1")) {
        var_2 thread scripts\sp\maps\titan\titan_apc_canyon::_id_B976("tp_point_1_spot");
      } else if(scripts\engine\utility::flag("tp_spawners_2")) {
        var_2 thread scripts\sp\maps\titan\titan_apc_canyon::_id_B976("tp_point_2_spot");
      } else if(scripts\engine\utility::flag("tp_spawners_3")) {
        var_2 thread scripts\sp\maps\titan\titan_apc_canyon::_id_B976("tp_point_3_spot");
      }

      var_0 = scripts\engine\utility::add_to_array(var_0, var_2);
      var_1.count = var_1.count + 1;
    }

    wait 0.5;
  }
}

_id_8EF2() {
  self._id_4E46 = ::_id_4199;
}

_id_114FF() {
  var_0 = [];
  var_0["r_hudoutlineWidth"] = 1;
  var_0["r_hudoutlineFillColor0"] = "0.5 0.5 0.5 1";
  var_0["r_hudoutlineFillColor1"] = "0.5 0.5 0.5 0.2";
  var_0["r_hudoutlineOccludedOutlineColor"] = "0.5 0.5 0.5 1";
  var_0["r_hudoutlineOccludedInlineColor"] = "0.7 0.7 0.7 1";
  var_0["r_hudoutlineOccludedInteriorColor"] = "0.5 0.5 0.5 1";
  var_0["r_hudOutlineOccludedColorFromFill"] = 1;
  return var_0;
}

_id_B994() {
  level.player endon("death");
  level.player notifyonplayercommand("swapping_weapons", "+actionslot 1");

  for(;;) {
    level.player waittill("swapping_weapons");
    _id_110A7();
  }
}

_id_11506() {
  self endon("death");
  self endon("disable_target_designator");
  scripts\sp\utility::_id_65E0("rockets_ready");
  scripts\sp\utility::_id_65E1("rockets_ready");
  level._id_11597 = scripts\engine\utility::spawn_tag_origin();
  level._id_26E4 = getaiarray("axis");
  level._id_11586 = [];
  level._id_C2C7 = [];
  level._id_11598 = 6;
  level._id_8773 = 0;
  level._id_35A4 = 0;
  level._id_BFDD = newhudelem();
  level._id_BFDD settext("Reloading");
  level._id_BFDD.alpha = 0;
  level._id_BFDD.horzalign = "center";
  level._id_BFDD.vertalign = "middle";
  level._id_BFDD.x = -40;
  level._id_35B2 = 0;
  level._id_35B0 = 0;
  level.c12_confirming_kills = 0;
  thread _id_1159A();
  thread td_dialogue_think();
  thread _id_B994();

  for(;;) {
    scripts\engine\utility::waittill_any("weapon_change", "weapon_dropped");

    if(issubstr(self getcurrentweapon(), "apc_target_designator")) {
      childthread _id_114FC();
      childthread _id_114FE();
      self setviewmodel("viewmodel_base_viewhands_iw7_desert");
      childthread _id_1294E();
      wait 0.5;

      if(!isDefined(level._id_11505)) {
        level._id_11505 = spawn("script_origin", level.player.origin);
        level._id_11505 linkTo(level.player);
      }

      level._id_35A4 = 1;
      level.player _id_11507();
      level.player playSound("c12_targeting_hud_start_lr");
      level._id_11505 playLoopSound("c12_targeting_hud_loop_lr");
      level.player setclienttriggeraudiozonepartialwithfade("c12_targeting_hud_filter", 0.5, "mix", "filter");
      scripts\sp\utility::_id_9199("c12Targeting", 1);
      setomnvar("ui_c12_active", 1);
      visionsetnaked("", 0.01);
      visionsetnaked("titan_apc_targetting", 0.2);
      scripts\engine\utility::flag_clear("titan_apc_targetting_off");
      setsaveddvar("r_volumetrics", 0);
      level._id_26E4 = getaiarray("axis");
    }
  }
}

_id_110A7() {
  level.player._id_D8A7 = level.player getcurrentweapon();
}

_id_E2CE() {
  level.player switchtoweaponimmediate(level.player._id_D8A7);
  wait 0.05;
  level.player enableweapons();
}

_id_11507() {
  if(level._id_35A4 == 1) {
    scripts\engine\utility::allow_offhand_weapons(0);
    scripts\engine\utility::allow_offhand_secondary_weapons(0);
    scripts\engine\utility::allow_melee(0);
  } else {
    if(isDefined(self.disabledoffhandweapons) && self.disabledoffhandweapons != 0) {
      scripts\engine\utility::allow_offhand_weapons(1);
    }

    if(isDefined(self.disabledoffhandsecondaryweapons) && self.disabledoffhandsecondaryweapons != 0) {
      scripts\engine\utility::allow_offhand_secondary_weapons(1);
    }

    if(isDefined(self.disabledmelee) && self.disabledmelee != 0) {
      scripts\engine\utility::allow_melee(1);
    }
  }
}

_id_11599(var_0) {
  if(var_0 == 1) {
    level._id_BFDD.alpha = 1;
    setsaveddvar("cg_drawCrosshair", 0);
  } else {
    level._id_BFDD.alpha = 0;
    setsaveddvar("cg_drawCrosshair", 1);
  }
}

_id_1159A() {
  for(;;) {
    level.player waittill("update_td_ammo");
    level.player setweaponammoclip("apc_target_designator", level._id_11598);
  }
}

td_dialogue_think() {
  for(;;) {
    level waittill("c12_dialogue_safe");
    wait 5;
    level.c12_confirming_kills = 0;
  }
}

_id_12FB3() {
  wait 2;

  if(scripts\engine\utility::cointoss()) {
    scripts\sp\maps\titan\titan_code::_id_134B7("titan_eth_reeseusethe");
  } else {
    scripts\sp\maps\titan\titan_code::_id_134B7("titan_usf_usetheapcsto");
  }
}

_id_1294E() {
  scripts\engine\utility::waittill_any("weapon_change", "weapon_dropped", "disable_c12_targeting_system");
  scripts\engine\utility::allow_offhand_weapons(0);
  _id_5518();
  scripts\engine\utility::allow_offhand_weapons(1);
}

_id_5518() {
  if(!issubstr(self getcurrentweapon(), "apc_target_designator")) {
    level.player playSound("c12_targeting_hud_end_lr");
    level.player clearclienttriggeraudiozone(0.1);

    if(isDefined(level._id_11505)) {
      level._id_11505 stoploopsound();
    }

    level._id_35A4 = 0;
    level.player _id_11507();
    visionsetnaked("", 0.01);
    scripts\engine\utility::flag_set("titan_apc_targetting_off");
    setomnvar("ui_c12_active", 0);
    scripts\sp\utility::_id_9199("c12Targeting", 0);

    for(var_0 = 0; var_0 < 6; var_0++) {
      setomnvar("ui_reticles_" + var_0 + "_lock_state", 0);
      setomnvar("ui_reticles_" + var_0 + "_target_ent", undefined);
    }
  }
}

_id_4153() {
  scripts\engine\utility::waittill_any("weapon_change", "weapon_dropped");
  _id_4150();
}

_id_4150() {
  var_0 = getaiarray("axis");
  wait 0.05;

  foreach(var_2 in var_0) {
    var_2 _id_4199();
  }
}

_id_114FC() {
  self endon("weapon_change");
  self endon("weapon_dropped");
  thread _id_4153();
  thread _id_11504();
}

_id_4199() {
  if(isDefined(target_istarget(self)) && target_istarget(self)) {
    target_remove(self);
  }

  scripts\sp\utility::_id_9193("c12Targeting");

  if(isDefined(self)) {
    self notify("clear_targeting_hudoutline");
  }

  if(isDefined(level._id_11586)) {
    level._id_11586 = scripts\engine\utility::array_remove(level._id_11586, self);
  }

  self._id_11584 = undefined;
  return 0;
}

_id_11504() {
  level.player endon("death");
  self endon("weapon_change");
  self endon("weapon_dropped");
  var_0 = [];
  level._id_11555 = [];
  wait 0.4;

  for(;;) {
    scripts\sp\utility::_id_65E3("rockets_ready");
    var_1 = anglesToForward(level.player getplayerangles());
    var_2 = level.player.origin + var_1 * 1500;
    var_3 = bulletTrace(self getEye(), var_2, 0, self);
    level._id_26E4 = getaiarray("axis");
    var_0 = scripts\sp\utility::array_removedeadvehicles(level._id_26E4);

    if(isDefined(level._id_3508)) {
      var_0 = scripts\engine\utility::add_to_array(var_0, level._id_3508);
    }

    var_0 = scripts\engine\utility::array_remove_array(var_0, level._id_AEEE);
    var_0 = sortbydistance(var_0, var_3["position"]);

    for(var_4 = 0; var_4 < 12; var_4++) {
      if(isDefined(level._id_3508) && !isDefined(level._id_3508._id_11584)) {
        if(scripts\sp\maps\titan\titan_code::_id_35D8()) {
          level._id_11586 = scripts\engine\utility::array_add(level._id_11586, level._id_3508);
          level._id_3508._id_11584 = 1;
        }
      }

      if(_id_5267(var_0[var_4])) {
        if(level.player _id_3921(var_0[var_4])) {
          if(level._id_11598 > 0) {
            if(level._id_11586.size < level._id_11598) {
              level._id_11586 = scripts\engine\utility::array_add(level._id_11586, var_0[var_4]);
              var_0[var_4]._id_11584 = 1;
              var_5 = level._id_11586.size - 1;

              if(level._id_11586.size == level._id_11598 && !isDefined(level._id_2083)) {
                level._id_739C._id_872A playSound("weap_c12_targeting");
                thread _id_2084();
              }
            }
          }
        }

        continue;
      }

      if(isDefined(var_0[var_4])) {
        var_0[var_4] scripts\sp\utility::_id_9193("c12Targeting");
        var_0[var_4] notify("clear_targeting_hudoutline");

        if(isDefined(var_0[var_4]._id_11584)) {
          if(target_istarget(var_0[var_4])) {
            target_remove(var_0[var_4]);
          }

          var_0[var_4]._id_11584 = undefined;
          level._id_11586 = scripts\engine\utility::array_remove(level._id_11586, var_0[var_4]);
        }
      }
    }

    level._id_11597.origin = var_3["position"];
    wait 0.05;
  }
}

_id_1368B() {
  self endon("weapon_change");
  self endon("weapon_dropped");

  for(;;) {
    if(_id_5267(self)) {
      if(level.player _id_3921(self)) {
        if(!_id_C7F7()) {
          break;
        }
      }
    } else
      break;

    wait 0.05;
  }
}

_id_6C91() {
  var_0 = self;

  foreach(var_3, var_2 in level._id_C2C7) {
    if(var_2 == var_0) {
      return var_3;
    }
  }
}

_id_2084() {
  level._id_2083 = 1;
  wait 20;
  level._id_2083 = undefined;
}

_id_205F() {
  level._id_205E = 1;
  wait 20;
  level._id_205E = undefined;
}

_id_114FE() {
  self endon("weapon_change");
  self endon("weapon_dropped");
  level._id_AEEE = [];
  var_0 = [];
  childthread _id_E5CD();

  for(;;) {
    self waittill("weapon_fired", var_1, var_2);
    level._id_209A = 1;
    level._id_AEEE = scripts\sp\utility::_id_22A2(level._id_AEEE, level._id_11586);
    level._id_11586 = scripts\engine\utility::array_remove_array(level._id_11586, level._id_AEEE);

    if(level._id_AEEE.size <= 0) {
      level.player setweaponammoclip("apc_target_designator", level._id_11598);
      continue;
    }

    var_3 = level._id_11597.origin;
    var_4 = level._id_739C._id_872A;

    if(isDefined(var_4)) {
      thread _id_2074(var_4, var_3);
      _id_E2CE();
    }
  }
}

c12_rocket_cooldown_timer() {
  level.player scripts\sp\utility::_id_1C34(0);
  thread c12_rocket_cooldown_vo();
  wait 15;
  thread scripts\sp\maps\titan\titan_code::_id_2081("titan_un4_apcreadytofire");
  level.player scripts\sp\utility::_id_1C34(1);
  level.player notify("c12_target_designator_ready");

  if(level._id_11598 == 0) {
    level._id_11598 = level._id_11598 + 1;
  }
}

c12_rocket_cooldown_vo() {
  level.player endon("c12_target_designator_ready");

  for(;;) {
    if(level.player buttonPressed("DPAD_UP")) {
      thread scripts\sp\maps\titan\titan_code::_id_2081("titan_un4_weaponsnotready");
      wait 7;
    }

    scripts\engine\utility::waitframe();
  }
}

_id_E5CD() {
  var_0 = 0;
  var_1 = 0;

  for(;;) {
    while(var_0 == var_1) {
      wait 0.05;
      var_0 = var_1;
      wait 0.05;
      var_1 = level._id_11586.size;
    }

    _id_12F06();
    wait 0.05;
    var_0 = var_1;
  }
}

_id_12F06() {
  var_0 = 6 - level._id_11586.size;

  if(level._id_11586.size > 0) {
    for(var_1 = 0; var_1 < level._id_11586.size; var_1++) {
      setomnvar("ui_reticles_" + var_1 + "_lock_state", 1);
      setomnvar("ui_reticles_" + var_1 + "_target_ent", level._id_11586[var_1]);
      level._id_11586[var_1] scripts\sp\utility::_id_9196(0, 1, 1, "c12Targeting");
    }
  }

  if(var_0 > 0) {
    for(var_1 = 6 - var_0; var_1 < 6; var_1++) {
      if(isDefined(level._id_AEEE[var_1])) {
        level._id_AEEE[var_1] thread _id_4167(var_1);
        continue;
      }

      setomnvar("ui_reticles_" + var_1 + "_lock_state", 0);
      setomnvar("ui_reticles_" + var_1 + "_target_ent", undefined);
    }
  }
}

_id_4167(var_0) {
  wait 1.5;

  while(isDefined(level._id_739C._id_9BE2)) {
    wait 0.05;
  }

  setomnvar("ui_reticles_" + var_0 + "_lock_state", 0);
  setomnvar("ui_reticles_" + var_0 + "_target_ent", undefined);

  if(isalive(self)) {
    scripts\sp\utility::_id_9193("c12Targeting");
    self notify("clear_targeting_hudoutline");
  }
}

_id_35E7() {
  self endon("stop_rocket_tracking");

  for(;;) {
    self waittill("rocket_fired", var_0);
    level thread _id_E5D2(var_0);
  }
}

_id_E5D2(var_0) {
  var_1 = var_0._id_1155F;
  var_2 = var_1._id_11550;
  setomnvar("ui_reticles_" + var_2 + "_lock_state", 2);
  scripts\engine\utility::waittill_any_ents(var_1, "death", var_0, "death");
  setomnvar("ui_reticles_" + var_2 + "_lock_state", 0);
  setomnvar("ui_reticles_" + var_2 + "_target_ent", undefined);
}

_id_2074(var_0, var_1) {
  level.player endon("death");
  var_2 = level._id_739C getEye();
  var_3 = [];
  var_4 = [];
  var_5 = [];
  var_3 = var_0._id_38C4;
  var_6 = 6 - level._id_AEEE.size;
  var_7 = level._id_AEEE.size;
  var_8 = [];
  var_8[0] = "TAG_Missile_Top_RI";
  var_8[1] = "TAG_Missile_Bottom_RI";
  var_9 = scripts\engine\utility::spawn_script_origin((0, 0, 0));

  foreach(var_11 in level._id_AEEE) {
    var_11 thread _id_11A98();
  }

  level notify("missile_fired");
  thread c12_rocket_cooldown_timer();
  level._id_11598 = level._id_11598 - level._id_AEEE.size;
  level.player notify("update_td_ammo");
  wait 0.4;
  level.player scripts\sp\utility::_id_65DD("rockets_ready");
  var_13 = getaiarray("axis");
  level._id_739C._id_9BE2 = 1;

  for(var_14 = 0; var_14 < var_7; var_14++) {
    wait 0.2;

    if(isDefined(level._id_AEEE[var_14])) {
      level._id_AEEE[var_14]._id_11550 = var_14;
      var_9.origin = var_9.origin + level._id_AEEE[var_14].origin;
    }
  }

  if(level._id_AEEE.size == 0) {
    return;
  }
  var_9.origin = (var_9.origin + (0, 0, 64)) / level._id_AEEE.size;
  level._id_739C scripts\sp\maps\titan\titan_code::_id_3550("right", 1);
  level._id_739C scripts\sp\maps\titan\titan_code::_id_3550("left", 0);

  if(level.c12_confirming_kills != 1) {
    thread _id_A674();
  }

  level._id_739C _id_0A05::_id_360D("right", var_9, "indirect_rockets_fired", 1);

  while(!level._id_739C _id_0C08::_id_9F30("right", var_9.origin)) {
    scripts\engine\utility::waitframe();
  }

  level._id_739C _id_0A05::_id_352D("right");
  level._id_739C scripts\sp\maps\titan\titan_code::_id_3550("right", 0);

  for(var_14 = 0; var_14 < level._id_AEEE.size; var_14++) {
    if(!_id_35AA(level._id_739C, level._id_AEEE[var_14])) {
      level._id_AEEE = scripts\engine\utility::array_remove(level._id_AEEE, level._id_AEEE[var_14]);
      continue;
    }

    thread _id_356D(level._id_739C, level._id_AEEE[var_14], var_8);
    wait(randomfloatrange(0.25, 0.35));
  }

  while(level._id_AEEE.size > 0) {
    level._id_AEEE = scripts\sp\utility::array_removedeadvehicles(level._id_AEEE);
    scripts\engine\utility::waitframe();
  }

  level._id_739C notify("missiles_fired");
  level.player scripts\sp\utility::_id_65E1("rockets_ready");
  level._id_739C scripts\sp\maps\titan\titan_code::_id_3550("left", 1);
  level._id_AEEE = scripts\engine\utility::array_remove_array(level._id_AEEE, level._id_AEEE);
  var_0 thread _id_DF5D(var_0, var_7);
}

_id_35AA(var_0, var_1) {
  if(!isDefined(var_1) || !isalive(var_1)) {
    return 0;
  }

  var_2 = distance2d(var_0.origin, var_1.origin);

  if(var_2 < 64) {
    return 0;
  }

  if(!scripts\engine\utility::within_fov(var_0 getEye(), var_0.angles, var_1.origin, 0.258819)) {
    return 0;
  }

  if(!var_0 scripts\sp\utility::_id_3849(var_1.origin + (0, 0, 96))) {
    return 0;
  }

  return 1;
}

_id_356D(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    var_3 = scripts\engine\utility::random(var_2);
    var_4 = scripts\engine\utility::spawn_tag_origin(var_0 gettagorigin(var_3), var_0.angles);
    var_5 = scripts\engine\utility::spawn_tag_origin();
    var_5.origin = var_1.origin + (0, 0, 32);
    var_6 = distance(var_0.origin, var_5.origin);
    playFXOnTag(scripts\engine\utility::getfx("vfx_c12_rocket_trail"), var_4, "tag_origin");
    playFXOnTag(scripts\engine\utility::getfx("vfx_hms_c12_rocket_ignite"), var_0, var_3);
    var_0 playSound("weap_c12rocket_fire");
    earthquake(0.3, 0.65, var_0.origin, 1024);
    wait(randomfloatrange(0.1, 0.2));
    var_7 = var_6 / 4000;
    var_4 moveTo(var_5.origin, var_7);
    wait(var_7);
    var_4 delete();

    if(isDefined(var_1)) {
      var_1 dodamage(var_1.health + 100, var_1.origin, var_0, var_0, "MOD_EXPLOSIVE");
    }

    for(var_8 = 0; var_8 < 3; var_8++) {
      var_9 = var_5.origin + (randomintrange(-128, 128), randomintrange(-128, 128), 0);
      playFX(scripts\engine\utility::getfx("vfx_hms_c12_rocket_explosion_burst"), var_9);
      earthquake(0.35, 0.5, var_9, 1024);
      radiusdamage(var_9, 256, 25, 0, var_0, "MOD_EXPLOSIVE");
      var_5 playSound("rocket_explode");
      wait(randomfloatrange(0.2, 0.3));
    }

    var_5 delete();
  }
}

_id_DF5D(var_0, var_1) {
  level endon("missile_fired");
  level.player endon("death");

  if(level._id_11598 == 0) {
    var_0._id_AE14 = 0;
  }

  while(level._id_11598 < 6) {
    _id_6A9E();
    level._id_11598 = level._id_11598 + 1;

    if(level._id_35A4 == 1) {
      level.player playSound("c12_targeting_hud_missile_ready");
    }

    level.player notify("update_td_ammo");
    var_0._id_AE14 = 1;
  }
}

_id_6A9E() {
  var_0 = 0;
  var_1 = 0.0166667;

  while(var_0 < 1) {
    var_0 = var_0 + var_1;
    setomnvar("ui_c12_missile_recharge", var_0);
    scripts\engine\utility::waitframe();
  }
}

_id_11A98() {
  self waittill("death");
  level._id_8773 = level._id_8773 + 1;
}

_id_A674() {
  level._id_739C waittill("missiles_fired");
  wait 2;
  level._id_739C._id_9BE2 = undefined;
  level.c12_confirming_kills = 1;

  if(level._id_8773 == 1) {
    scripts\sp\maps\titan\titan_code::_id_2081("titan_un4_oneconfirmedkill");
  } else if(level._id_8773 == 2) {
    scripts\sp\maps\titan\titan_code::_id_2081("titan_un4_twoconfirmedkills");
  } else if(level._id_8773 == 3) {
    scripts\sp\maps\titan\titan_code::_id_2081("titan_un4_threeconfirmedkills");
  } else if(level._id_8773 == 4) {
    scripts\sp\maps\titan\titan_code::_id_2081("titan_un4_fourconfirmedkills");
  } else if(level._id_8773 == 5) {
    scripts\sp\maps\titan\titan_code::_id_2081("titan_un4_fiveconfirmedkills");
  } else if(level._id_8773 == 6) {
    scripts\sp\maps\titan\titan_code::_id_2081("titan_un4_sixconfirmedkills");
  } else if(level._id_8773 > 6) {
    scripts\sp\maps\titan\titan_code::_id_2081("titan_un4_goodkills");
  }

  if(scripts\engine\utility::flag("enable_c12_kill_reaction_vo")) {
    if(level._id_8773 <= 4) {
      _id_35B1();
    } else {
      _id_35AF();
    }
  }

  level._id_8773 = 0;
  level notify("c12_dialogue_safe");
}

_id_35B1() {
  if(level._id_35B2 == 1) {
    return;
  }
  wait 2;
  scripts\sp\maps\titan\titan_code::_id_A556("titan_ksh_thatthingstearingshit");
  level._id_35B2 = 1;
}

_id_35AF() {
  if(level._id_35B0 == 1) {
    return;
  }
  wait 2;
  scripts\sp\maps\titan\titan_code::_id_A556("titan_ksh_holyshitcanyou");
  wait 0.5;
  scripts\sp\maps\titan\titan_code::_id_2434("titan_eth_icandoittoyou");
  level._id_35B0 = 1;
}

_id_3921(var_0) {
  if(isDefined(var_0)) {
    if(level._id_11598 <= 0) {
      return 0;
    }

    if(isDefined(var_0._id_11584)) {
      return 0;
    }

    if(!isalive(var_0)) {
      return 0;
    }

    if(var_0 scripts\sp\utility::_id_58DA() || var_0.delayeddeath) {
      return 0;
    }

    return 1;
  }

  return 0;
}

_id_5267(var_0) {
  if(isDefined(var_0)) {
    if(isai(var_0)) {
      if(!scripts\sp\utility::_id_CFAC(var_0)) {
        return 0;
      }
    }

    if(!scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_0.origin, 0.65)) {
      return 0;
    }

    if(!isalive(var_0)) {
      return 0;
    }

    if(var_0 scripts\sp\utility::_id_58DA() || var_0.delayeddeath) {
      return 0;
    }

    return 1;
  }

  return 0;
}

_id_C7F7() {
  var_0 = self.origin + (0, 0, 1500);
  var_1 = scripts\common\trace::ray_trace_detail(level._id_739C._id_872A._id_38C4[0].origin, self.origin + (0, 0, 40));

  if(level._id_11586.size >= level._id_11598) {
    return 1;
  }

  if(isai(self)) {
    if(isDefined(var_1["entity"]) && var_1["entity"] == self) {
      return 0;
    }

    var_2 = scripts\common\trace::ai_trace_passed(self.origin, var_0, undefined, self);

    if(!var_2) {
      return 1;
    }
  }

  return 0;
}

_id_109B0() {
  level._id_1098B = scripts\engine\utility::getStruct("apc_speed_end", "targetname");
}

_id_8775(var_0) {
  var_1 = getaiarray("allies");
  var_2 = var_0 * var_0;

  foreach(var_4 in var_1) {
    if(distancesquared(var_4.origin, self.origin) < var_2 && scripts\engine\utility::within_fov(self.origin, self.angles, var_4.origin, self._id_1C13)) {
      return 1;
    }
  }

  return 0;
}

_id_26EC(var_0, var_1) {
  var_2 = getaiarray("axis");
  var_3 = 0;
  var_4 = var_0 * var_0;

  foreach(var_6 in var_2) {
    if(distancesquared(var_6.origin, self.origin) < var_4 && scripts\engine\utility::within_fov(self.origin, self.angles, var_6.origin, self._id_207D)) {
      var_3++;

      if(var_3 >= var_1) {
        return 1;
      }
    }
  }

  return 0;
}

_id_2059() {
  scripts\sp\utility::_id_10FEC("refinery_reveal_clouds");
  var_0 = getEntArray("freighter_ships", "targetname");

  foreach(var_2 in var_0) {
    var_2 delete();
  }

  scripts\engine\utility::flag_set("tp_spawners_3");
  _id_2061();
}

_id_2077() {
  if(self.script_noteworthy == "APC_right") {
    level._id_2050 = scripts\sp\utility::_id_10808();
    level._id_2056 = scripts\engine\utility::add_to_array(level._id_2056, level._id_2050);
    level._id_2050._id_101AD = "right";
    level._id_E513 = self.vehicle;
    level._id_2050 thread _id_208E();
    level._id_2050 thread _id_2088();
    level._id_2050 thread _id_2457("apc1", 0.1);
    wait 0.05;
  } else {
    level._id_2052 = scripts\sp\utility::_id_10808();
    level._id_2056 = scripts\engine\utility::add_to_array(level._id_2056, level._id_2052);
    level._id_2052._id_101AD = "left";
    level._id_2052 thread _id_208E();
    level._id_2052 thread _id_2088();
    level._id_2052 thread _id_2457("apc2", 0.1);
  }
}

_id_208E() {
  var_0 = getEnt("spawner_left_apc", "targetname");
  var_1 = getEnt("spawner_right_apc", "targetname");
  self._id_1C13 = cos(50);
  self._id_207D = cos(100);
  thread scripts\sp\maps\titan\titan_audio::_id_1194A();
  self setvehicleteam("allies");
  self startpath();
  wait 0.1;
  scripts\sp\vehicle::_id_8441();
  thread _id_2089();
  _id_F8C6();
}

_id_F8C6() {
  self._id_BEFF = scripts\engine\utility::spawn_tag_origin();
  self.new_badplace_mid = scripts\engine\utility::spawn_tag_origin();
  self._id_BF00 = scripts\engine\utility::spawn_tag_origin();
  self._id_BEFF linkTo(self, "tag_origin", (200, 0, 0), (0, 0, 0));
  self.new_badplace_mid linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  self._id_BF00 linkTo(self, "tag_origin", (-200, 0, 0), (0, 0, 0));
  createnavrepulsor("front_of_apc", 0, self._id_BEFF, 150, 1);
  createnavrepulsor("mid_of_apc", 0, self._id_BEFF, 150, 1);
  createnavrepulsor("rear_of_apc", 0, self._id_BF00, 150, 1);
}

_id_205D() {
  self._id_38C4 = [];
  self._id_38C4[0] = ::scripts\engine\utility::spawn_tag_origin();
  self._id_38C4[1] = ::scripts\engine\utility::spawn_tag_origin();
  self._id_38C4[2] = ::scripts\engine\utility::spawn_tag_origin();
  self._id_38C4[3] = ::scripts\engine\utility::spawn_tag_origin();
  self._id_38C4[4] = ::scripts\engine\utility::spawn_tag_origin();
  self._id_38C4[5] = ::scripts\engine\utility::spawn_tag_origin();
  self._id_38C4[0] linkTo(self, "tag_origin", (40, -85, 160), (270, 270, 90));
  self._id_38C4[1] linkTo(self, "tag_origin", (20, -85, 160), (270, 270, 90));
  self._id_38C4[2] linkTo(self, "tag_origin", (0, -85, 160), (270, 270, 90));
  self._id_38C4[3] linkTo(self, "tag_origin", (40, -70, 160), (270, 270, 90));
  self._id_38C4[4] linkTo(self, "tag_origin", (20, -70, 160), (270, 270, 90));
  self._id_38C4[5] linkTo(self, "tag_origin", (0, -70, 160), (270, 270, 90));
  self._id_AE14 = 1;
}

_id_2088(var_0) {
  scripts\sp\utility::_id_65E0("hold_fire");
  var_1 = self.mgturret[0];
  var_1 setturretteam("allies");
  var_1._id_5041 = "manual";
  var_1 setmode("manual");
  var_1 turretfireenable();

  if(isDefined(var_0)) {
    var_0 unlink();
    self._id_129D4 = var_0;
    self._id_129D4 scripts\engine\utility::delaycall(0.05, ::linkto, self.mgturret[0], "tag_aim", (0, 0, 0), (0, 0, 0));
  }

  thread _id_2099();
  scripts\sp\utility::_id_65E1("hold_fire");
}

_id_2098() {
  var_0 = undefined;
  var_1 = getEntArray("apc_turret_clip", "targetname");

  foreach(var_3 in var_1) {
    if(!isDefined(var_3.used)) {
      var_3.used = 1;
      var_0 = var_3;
      break;
    }
  }

  var_0 dontinterpolate();
  self._id_129D4 = var_0;
  self._id_129D4 linkTo(self, "tag_aim", (0, 0, 0), (0, 0, 0));
}

_id_2099() {
  self endon("death");
  self endon("emp_death");
  var_0 = self.mgturret[0];
  self._id_EE15 = 0;
  var_1 = 2;
  var_2 = 2;
  var_3 = 2;
  var_4 = 5;
  var_5 = 0.25;
  var_6 = 100;
  var_7 = var_6 * var_6;
  var_8 = 0.8;

  for(;;) {
    if(scripts\sp\utility::_id_65DB("hold_fire") || self._id_EE15) {
      wait 1.0;
      continue;
    }

    var_9 = getaiarray("axis");
    var_10 = undefined;
    var_10 = _id_2087();

    if(!isDefined(var_10)) {
      wait 1.0;
      continue;
    }

    var_0 settargetentity(var_10, (0, 0, 45));
    var_0 _id_13638(var_10);

    if(!isDefined(var_10)) {
      wait 0.1;
      continue;
    }

    var_11 = bulletTrace(var_0 gettagorigin("TAG_FLASH"), var_10.origin + (0, 0, 65), 0, var_0);

    if(var_11["fraction"] == 1) {
      var_4 = randomintrange(6, 8);
    } else {
      var_4 = randomintrange(3, 4);
    }

    for(var_12 = 0; var_12 < var_4; var_12++) {
      if(!isDefined(var_10) || !isalive(var_10)) {
        break;
      }

      var_11 = bulletTrace(var_0 gettagorigin("TAG_FLASH"), var_10.origin + (0, 0, 65), 0, var_0);

      if(var_11["fraction"] >= var_8) {
        _id_2085();
      }

      wait(randomfloatrange(0.3, 1.5));
    }

    wait(var_1);
  }
}

_id_2087() {
  if(self._id_EE15) {
    return;
  }
  var_0 = getaiarray("axis");
  var_1 = undefined;
  var_2 = 5;
  var_3 = squared(750);
  var_4 = 500;

  for(var_5 = 0; var_5 < var_2; var_5++) {
    var_0 = sortbydistance(var_0, self.origin);
    var_6 = var_0[0];

    if(isDefined(var_6) && isalive(var_6) && !isDefined(var_6._id_2086) && distancesquared(self.origin, var_6.origin) > var_3) {
      var_1 = var_6;
      return var_1;
    } else
      var_0 = scripts\engine\utility::array_remove(var_0, var_6);

    wait 0.1;
  }

  return undefined;
}

_id_13638(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    self endon("waittill_aim_timeout");
    thread scripts\sp\utility::_id_C12D("waittill_aim_timeout", var_2);
  }

  if(issentient(var_0)) {
    var_0 endon("death");
  }

  if(isDefined(var_1)) {
    for(;;) {
      if(scripts\engine\utility::within_fov(self gettagorigin("tag_flash"), self gettagangles("tag_flash"), var_0.origin, cos(10))) {
        if(bullettracepassed(self gettagorigin("tag_flash"), var_0.origin, 0, self)) {
          return;
        }
      }

      wait 0.15;
    }

    return;
  }

  while(!scripts\engine\utility::within_fov(self gettagorigin("tag_flash"), self gettagangles("tag_flash"), var_0.origin, cos(10))) {
    wait 0.15;
  }
}

_id_2085(var_0) {
  if(scripts\sp\utility::_id_65DB("hold_fire")) {
    return;
  }
  var_1 = self.mgturret[0];
  var_1 endon("stop_firing_mg");
  var_1._id_9BE2 = 1;

  if(!isDefined(var_0)) {
    var_0 = randomfloatrange(2, 5);
  }

  for(var_2 = 0; var_2 < var_0; var_2++) {
    scripts\vehicle\apache::_id_035A();
  }
}

_id_2064() {}

_id_2065(var_0, var_1, var_2, var_3) {
  if(_id_2064()) {
    if(!isDefined(var_2)) {
      var_2 = "red";
    }

    if(!isDefined(var_3)) {
      var_3 = 3;
    }

    switch (var_2) {
      case "red":
      case "r":
        thread scripts\engine\utility::draw_line_for_time(var_0, var_1, 1, 0, 0, var_3);
        break;
      case "green":
      case "g":
        thread scripts\engine\utility::draw_line_for_time(var_0, var_1, 0, 1, 0, var_3);
        break;
      case "blue":
      case "b":
        thread scripts\engine\utility::draw_line_for_time(var_0, var_1, 0, 0, 1, var_3);
        break;
      case "white":
      case "w":
        thread scripts\engine\utility::draw_line_for_time(var_0, var_1, 1, 1, 1, var_3);
        break;
      default:
        break;
    }
  }
}

_id_206C() {
  level.player scripts\sp\utility::_id_F526("normal");
  scripts\engine\utility::exploder("refinery_reveal_clouds");
  scripts\engine\utility::exploder("refinery_clouds_top");
  thread scripts\sp\maps\titan\titan_code::_id_D250(2);
  scripts\engine\utility::exploder("fx_apc_drop_zone");
}

_id_2051() {
  var_0 = getEnt("spawner_right_apc", "targetname");
  self.target = "apc1_start_node";
  self._id_101AD = "right";
  level._id_E513 = self;
  self._id_1C13 = cos(50);
  self._id_207D = cos(100);
  thread scripts\sp\maps\titan\titan_audio::_id_1194A();
  thread _id_205D();
  thread scripts\sp\vehicle_paths::_id_8023();
  scripts\sp\vehicle_paths::_id_845A(self);
  scripts\sp\vehicle::_id_8441();
  thread _id_2089();
  _id_F8C6();
}

_id_2053() {
  var_0 = getEnt("spawner_left_apc", "targetname");
  self.target = "apc2_start_node";
  self._id_101AD = "left";
  self._id_1C13 = cos(50);
  self._id_207D = cos(100);
  thread scripts\sp\maps\titan\titan_audio::_id_1194A();
  thread scripts\sp\vehicle_paths::_id_8023();
  scripts\sp\vehicle_paths::_id_845A(self);
  scripts\sp\vehicle::_id_8441();
  thread _id_2089();
  _id_F8C6();
}

_id_C155(var_0) {
  while(distance(self.origin, self._id_1EB7.origin) > 500) {
    wait 0.15;
  }

  var_0 notify("landed");
}

_id_5DB2() {
  self waittill("single anim");
  var_0 = scripts\engine\utility::getStruct("dropship_goal", "targetname");
  self vehicle_setspeed(160, 40, 40);
  self setvehgoalpos(var_0.origin + (-20000, -20000, -5000));
  scripts\engine\utility::waittill_any("goal", "near_goal");
  self delete();
}

_id_739D(var_0) {
  level._id_739C = var_0 scripts\sp\utility::_id_10619();
  level._id_739C thread scripts\sp\utility::_id_5131();
  level._id_739C._id_1FBB = "friendly_c12";
  level._id_739C._id_11B06 = 1;
  level._id_739C scripts\sp\utility::_id_65E0("enable_auto_move");
  level._id_739C endon("death");
  level._id_739C._id_872A = level._id_739C;
  level._id_739C._id_872A show();
  level._id_739C thread _id_205D();
  level._id_739C thread _id_35CA();
  level._id_739C.name = "";
  level._id_739C._id_1C78 = 0;
  level._id_739C._id_BFED = 1;
  level._id_739C thread _id_245D(1);
}

_id_2457(var_0, var_1) {
  wait(var_1);
  var_2 = getEnt(var_0 + "LightL", "targetname");
  var_3 = getEnt(var_0 + "LightR", "targetname");
  var_2.origin = (0, 0, 0);
  var_2.angles = (0, 0, 0);
  var_3.origin = (0, 0, 0);
  var_3.angles = (0, 0, 0);
  var_2 linkTo(self, "TAG_HEADLIGHTS_LEFT", (0, 0, 0), (0, 0, 0));
  var_3 linkTo(self, "TAG_HEADLIGHTS_RIGHT", (0, 0, 0), (0, 0, 0));
  playFXOnTag(scripts\engine\utility::getfx("vfx_utility_light_lflare_blue_sml"), self, "TAG_HEADLIGHTS_LEFT");
  playFXOnTag(scripts\engine\utility::getfx("vfx_utility_light_lflare_blue_sml"), self, "TAG_HEADLIGHTS_RIGHT");
}

_id_12948() {
  var_0 = getEnt("apc1LightL", "targetname");
  var_1 = getEnt("apc1LightR", "targetname");
  var_0 setlightintensity(0.0);
  var_1 setlightintensity(0.0);
  var_0.origin = var_0.origin + (0, 0, 10000);
  var_1.origin = var_1.origin + (0, 0, 10000);
  stopFXOnTag(scripts\engine\utility::getfx("vfx_utility_light_lflare_blue_sml"), level._id_2050, "TAG_HEADLIGHTS_LEFT");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_utility_light_lflare_blue_sml"), level._id_2050, "TAG_HEADLIGHTS_RIGHT");
  var_2 = getEnt("apc2LightL", "targetname");
  var_3 = getEnt("apc2LightR", "targetname");
  var_2 setlightintensity(0.0);
  var_3 setlightintensity(0.0);
  var_2.origin = var_2.origin + (0, 0, 10000);
  var_3.origin = var_3.origin + (0, 0, 10000);
  stopFXOnTag(scripts\engine\utility::getfx("vfx_utility_light_lflare_blue_sml"), level._id_2052, "TAG_HEADLIGHTS_LEFT");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_utility_light_lflare_blue_sml"), level._id_2052, "TAG_HEADLIGHTS_RIGHT");
}

_id_245D(var_0) {
  if(isDefined(self.bt._id_71C9)) {
    self[[self.bt._id_71C9]]();
  }

  self endon("death");
  scripts\engine\utility::flag_wait("c12_friendly_activate");
  var_1 = getEnt("c12_friendly_omni_a", "targetname");
  var_2 = getEnt("c12_friendly_omni_b", "targetname");
  var_3 = getEnt("c12_friendly_spot_a", "targetname");
  var_1.origin = (0, 0, 0);
  var_1.angles = (0, 0, 0);
  var_1 setlightintensity(0.01);
  var_1 linkTo(self, "J_Clavicle_Inner_RI", (10, -7, 1), (0, 0, 0));
  var_2.origin = (0, 0, 0);
  var_2.angles = (0, 0, 0);
  var_2 setlightintensity(0.01);
  var_2 linkTo(self, "J_Clavicle_Inner_LE", (10, -7, 1), (0, 0, 0));
  var_3.origin = (0, 0, 0);
  var_3.angles = (0, 0, 0);
  var_3 setlightintensity(0.01);
  var_3 _meth_82FD(110, 50);
  var_3 linkTo(self, "J_frontCamera", (4.5, 4, -1), (0, 90, 0));
  self._id_6A59 = var_3;

  if(!var_0) {
    var_4 = var_3 _meth_8136();
    var_3 _meth_8300(var_4 * 0.5);
  }

  wait 1.0;
  var_1 setlightintensity(0.25);
  wait 1.0;
  var_2 setlightintensity(0.25);
  wait 1.0;
  var_3 setlightintensity(200);
  thread _id_245C();
  thread _id_356A();
}

_id_245C() {
  self endon("death");
  self._id_AC92 = spawn("script_model", (0, 0, 0));
  self._id_AC92 setModel("tag_origin");
  self._id_AC92 linkTo(self, "J_frontCamera", (4.5, 4, -1), (0, 90, 0));
  var_0 = scripts\engine\utility::getfx("c12_headlight_ally");
  playFXOnTag(var_0, self._id_AC92, "tag_origin");
}

_id_1294A() {
  var_0 = getEnt("c12_friendly_spot_a", "targetname");
  var_0 _meth_8300(250);
  wait 4;
  var_0 _meth_8300(13);
  var_0.origin = var_0.origin + (0, 0, 10000);
  var_1 = getEnt("c12_friendly_omni_a", "targetname");
  var_1 _meth_8300(12.5);
  var_1.origin = var_1.origin + (0, 0, 10000);
  var_2 = getEnt("c12_friendly_omni_b", "targetname");
  var_2 _meth_8300(12.5);
  var_2.origin = var_2.origin + (0, 0, 10000);
}

_id_356A() {
  scripts\engine\utility::flag_wait("c12_fight_turn_off_eye_spotlight");
  self._id_6A59 setlightintensity(0.01);
  killfxontag(level._effect["c12_headlight_ally"], self._id_AC92, "tag_origin");
  thread _id_356B();
}

_id_356B() {
  scripts\engine\utility::flag_wait("c12_fight_turn_on_eye_spotlight");
  var_0 = 0;

  for(var_1 = 0; var_1 < 100; var_1++) {
    if(var_0 == 0) {
      self._id_6A59 setlightintensity(100);
    } else {
      self._id_6A59 setlightintensity(1);
    }

    wait(randomfloatrange(0.1, 0.3));
  }

  self._id_6A59 setlightintensity(200);
  thread _id_245C();
}

_id_A5C3() {
  self endon("death");
  self notify("kill_flashlight");
  stopFXOnTag(level._effect["c12_headlight"], self._id_AC92, "tag_origin");
}

_id_35CA() {
  self endon("stop_move_along_struct_path");
  var_0 = scripts\engine\utility::getStructArray("c12_path", "targetname");
  var_1 = (0, 0, 0);

  foreach(var_3 in var_0) {
    _id_3578(var_3);
  }

  var_5 = squared(75.0);
  var_6 = squared(150.0);

  for(;;) {
    scripts\sp\utility::_id_65E3("enable_auto_move");
    scripts\sp\utility::_id_54F7();
    self._id_3599 = _id_3579(var_0);
    var_7 = scripts\common\trace::ray_trace_passed(var_1, var_1 + (0, 0, 1000));

    if(var_7 == 1) {
      scripts\sp\utility::_id_F3DD(128);
      self setgoalpos(self._id_3599);
      wait 2;

      for(var_8 = distance2dsquared(self.origin, level.player.origin); var_8 > var_5 && var_8 < var_6; var_8 = distance2dsquared(self.origin, level.player.origin)) {
        wait 0.05;
      }
    }
  }
}

_id_3578(var_0) {
  var_1 = 0;

  for(var_2 = var_0; isDefined(var_2.target); var_2 = var_3) {
    var_3 = scripts\engine\utility::getStruct(var_2.target, "targetname");
    var_2._id_5701 = distance(var_2.origin, var_3.origin);
    var_2.forward = vectorNormalize(var_3.origin - var_2.origin);
    var_1 = var_1 + var_2._id_5701;
  }

  return var_1;
}

_id_3579(var_0) {
  var_1 = (0, 0, 0);
  var_2 = var_0[0];

  foreach(var_4 in var_0) {
    var_5 = var_4;

    while(isDefined(var_5.target)) {
      var_6 = scripts\engine\utility::getStruct(var_5.target, "targetname");
      var_7 = pointonsegmentnearesttopoint(var_5.origin, var_6.origin, level.player.origin);

      if(distancesquared(var_7, level.player.origin) < distancesquared(var_1, level.player.origin)) {
        var_2 = var_5;
        var_1 = var_7;
      }

      var_5 = var_6;
      wait 0.05;
    }
  }

  var_1 = _id_35C9(var_2, var_1);
  var_9 = scripts\sp\math::_id_DCA0() * 50;
  var_1 = var_1 + var_9;

  if(isDefined(self._id_3599)) {
    var_1 = _id_35CB(var_1, var_0[0]);
  }

  return var_1;
}

_id_35CB(var_0, var_1) {
  var_2 = _id_7889(var_0, var_1);
  var_3 = _id_7889(self._id_3599, var_1);

  if(var_2 > var_3) {
    return var_0;
  }

  return self._id_3599;
}

_id_7889(var_0, var_1) {
  var_2 = var_1;
  var_3 = 0;

  for(var_4 = 0; var_3 == 0 && isDefined(var_2.target); var_2 = var_5) {
    var_5 = scripts\engine\utility::getStruct(var_2.target, "targetname");

    if(distancesquared(var_2.origin, var_0) < distancesquared(var_2.origin, var_5.origin)) {
      var_4 = var_4 + distance(var_2.origin, var_0);
      var_3 = 1;
      continue;
    }

    var_2._id_5701 = distance(var_2.origin, var_5.origin);
    var_2.forward = vectorNormalize(var_5.origin - var_2.origin);
    var_4 = var_4 + var_2._id_5701;
  }

  return var_4;
}

_id_35C9(var_0, var_1) {
  var_2 = var_1 + var_0.forward * 300;

  if(distancesquared(var_0.origin, var_2) < squared(var_0._id_5701)) {
    return var_2;
  } else {
    var_3 = distance(var_0.origin, var_2) - var_0._id_5701;
    var_4 = scripts\engine\utility::getStruct(var_0.target, "targetname");

    if(isDefined(var_4.forward)) {
      var_2 = var_4.origin + var_4.forward * var_3;
    } else {
      var_2 = var_4.origin;
    }

    return var_2;
  }
}

_id_2089() {
  self endon("death");
  self endon("stop_move_along_struct_path");
  var_0 = getvehiclenode(self.target, "targetname");
  var_1 = _id_2075(var_0);
  var_2 = var_0.origin;
  var_3 = 1;
  var_4 = 1;
  thread scripts\sp\maps\titan\titan_audio::_id_1194C();

  while(!scripts\engine\utility::flag("apc_move_up_5")) {
    var_2 = _id_2076(var_0, var_2);
    var_5 = _id_7825(var_2);
    var_6 = _id_7C6F();
    var_5 = var_5 * var_6;

    if(var_5 > 0) {
      if(var_5 > 15) {
        var_5 = 15;
      }

      if(var_5 > self vehicle_getspeed() || var_5 == 15) {
        self vehicle_setspeed(var_5, 2);
      } else {
        self vehicle_setspeed(var_5, var_3);
      }

      var_3 = var_5;
      var_4 = 0;
    } else {
      if(_id_D119(205) == 1 || _id_C741(400) == 1) {
        self vehicle_setspeedimmediate(0, 30);
        self notify("apc_sfx_stop");
      } else {
        self notify("apc_sfx_slowing");
        self vehicle_setspeed(var_5, var_3);
      }

      var_4 = 1;
    }

    wait 0.05;
  }

  self vehicle_setspeed(15, 1);
}

_id_7C6F() {
  if(_id_9B54(400, 700, 400, 500, 3)) {
    return 0;
  }

  if(_id_9B54(500, 800, 500, 600, 6)) {
    return 0.25;
  }

  if(_id_9B54(600, 900, 600, 700, 9)) {
    return 0.5;
  }

  return 1;
}

_id_9B54(var_0, var_1, var_2, var_3, var_4) {
  if(_id_D119(var_0)) {
    return 1;
  }

  if(_id_8775(var_2)) {
    return 1;
  }

  if(_id_C741(var_1)) {
    return 1;
  }

  if(_id_26EC(var_3, var_4)) {
    return 1;
  }

  return 0;
}

_id_D119(var_0) {
  if(scripts\engine\utility::within_fov(self.origin, self.angles, level.player.origin, self._id_1C13) && scripts\sp\utility::_id_D40E(var_0, self.origin)) {
    return 1;
  } else {
    return 0;
  }
}

_id_C741(var_0) {
  if(isDefined(level._id_2052) && self == level._id_2052) {
    return 0;
  }

  if(scripts\engine\utility::within_fov(self.origin, self.angles, level._id_2052.origin, self._id_207D) && distancesquared(level._id_2052.origin, self.origin) < squared(var_0)) {
    return 1;
  }

  return 0;
}

_id_2076(var_0, var_1) {
  var_2 = var_1;
  var_3 = var_0;
  var_4 = var_3;

  while(isDefined(var_3.target)) {
    var_5 = getvehiclenode(var_3.target, "targetname");
    var_6 = pointonsegmentnearesttopoint(var_3.origin, var_5.origin, level._id_739C.origin);

    if(distancesquared(var_6, level._id_739C.origin) < distancesquared(var_2, level._id_739C.origin)) {
      var_4 = var_3;
      var_2 = var_6;
    }

    var_3 = var_5;
    scripts\engine\utility::waitframe();
  }

  var_2 = _id_A56C(var_4, var_2);
  return var_2;
}

_id_A56C(var_0, var_1) {
  var_2 = getvehiclenodearray(var_0.targetname, "target");

  if(var_2.size > 0) {
    var_3 = var_1 - var_0.forward * 700;

    if(var_2.size > 1) {
      if(isDefined(var_2[0].script_index) && var_2[0].script_noteworthy == 1) {
        var_4 = var_2[1];
      } else {
        var_4 = var_2[0];
      }
    } else
      var_4 = var_2[0];

    if(distancesquared(var_0.origin, var_3) < squared(var_4._id_5701)) {
      return var_3;
    } else {
      var_5 = distance(var_0.origin, var_3) - var_4._id_5701;
      var_6 = getvehiclenodearray(var_0.targetname, "target");

      if(var_6.size > 1) {
        if(isDefined(var_6[0].script_index) && var_6[0].script_noteworthy == 1) {
          var_7 = var_6[1];
        } else {
          var_7 = var_6[0];
        }
      } else
        var_7 = var_6[0];

      if(isDefined(var_4.forward)) {
        var_3 = var_4.origin + var_4.forward * var_5;
      } else {
        var_3 = var_4.origin;
      }
    }
  } else
    var_3 = var_0.origin;

  return var_3;
}

_id_2075(var_0) {
  var_1 = 0;

  for(var_2 = var_0; isDefined(var_2.target); var_2 = var_3) {
    var_3 = getvehiclenode(var_2.target, "targetname");
    var_2._id_5701 = distance(var_2.origin, var_3.origin);
    var_2.forward = vectorNormalize(var_3.origin - var_2.origin);
    var_1 = var_1 + var_2._id_5701;
  }

  return var_1;
}

_id_7825(var_0) {
  var_1 = 0.5;
  var_2 = self.angles;
  var_3 = self.origin;
  var_4 = vectorNormalize(var_0 - var_3);
  var_5 = vectordot(anglesToForward(var_2), var_4);

  if(var_5 <= var_1 * -1) {
    return 0;
  }

  var_6 = distance(self.origin, var_0);
  var_7 = var_6 * 0.01;
  return var_7;
}

_id_9EC4() {
  var_0 = self getmovingplatformparent();

  if(isDefined(var_0) && isDefined(var_0.vehicletype) && var_0.vehicletype == "apc") {
    return 1;
  } else {
    return 0;
  }
}

_id_4219() {
  var_0 = scripts\engine\utility::getStruct("c12_slide_anim", "targetname");
  var_1 = getnode("kashima_cliff_node", "targetname");
  level._id_B33E._id_1EB7 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  level._id_B33E scripts\sp\utility::_id_54F7();
  level._id_B33E scripts\sp\utility::_id_F3DD(32);
  level._id_B33E _meth_82EE(var_1);

  if(!scripts\engine\utility::flag("base_alerted")) {
    level._id_B33E._id_1EB7 scripts\sp\anim::_id_1F17(level._id_B33E, "cliffside_approach");
    level._id_B33E._id_1EB7 thread scripts\sp\anim::_id_1F35(level._id_B33E, "cliffside_approach");
    wait 3.87;
    level._id_B33E._id_1EB7 thread scripts\sp\anim::_id_1EEA(level._id_B33E, "cliffside_idle", "stop_loop");
  }

  scripts\engine\utility::flag_wait("base_alerted");
  level._id_B33E._id_1EB7 notify("stop_loop");
  level._id_B33E notify("stop_anim");
  level._id_B33E playSound("titan_hill_slide_npc");
  level._id_B33E._id_1EB7 scripts\sp\anim::_id_1F35(level._id_B33E, "cliffside_exit");
  level._id_B33E scripts\sp\utility::_id_61C7();
  level._id_B33E scripts\sp\utility::_id_F3DD(32);
  level._id_B33E._id_1EB7 delete();
}

_id_4215() {
  var_0 = scripts\engine\utility::getStruct("c12_slide_anim", "targetname");
  self._id_1EB7 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);

  if(self == level._id_C47F || self == level._id_2429) {
    if(!scripts\engine\utility::flag("base_alerted")) {
      thread _id_167B(self._id_1EB7);
    }
  }

  if(self == level._id_B33B) {
    self._id_1EB7 scripts\sp\anim::_id_1F17(self, "cliffside_idle");

    if(!scripts\engine\utility::flag("base_alerted")) {
      self._id_1EB7 thread scripts\sp\anim::_id_1EEA(self, "cliffside_idle", "stop_loop");
    }
  }

  scripts\engine\utility::flag_wait("base_alerted");
  scripts\sp\anim::_id_1F12();
  self._id_1EB7 notify("stop_loop");
  self notify("stop_anim");
  self playSound("titan_hill_slide_npc");
  self._id_1EB7 scripts\sp\anim::_id_1F17(self, "cliffside_exit");
  self._id_1EB7 scripts\sp\anim::_id_1F35(self, "cliffside_exit");
  scripts\sp\utility::_id_61C7();
  scripts\sp\utility::_id_F3DD(32);
  thread _id_4218();
  wait 5;
  self._id_1EB7 delete();
}

_id_4218() {
  var_0 = getnode("omar_exit_goal", "targetname");
  var_1 = getnode("ethen_exit_goal", "targetname");
  var_2 = getnode("brooks_exit_goal", "targetname");
  var_3 = getnode("kashima_exit_goal", "targetname");

  if(self == level._id_C47F) {
    self _meth_82EE(var_0);
  }

  if(self == level._id_2429) {
    self _meth_82EE(var_1);
  }

  if(self == level._id_B33B) {
    self _meth_82EE(var_2);
  }

  if(self == level._id_B33E) {
    self _meth_82EE(var_3);
  }
}

_id_167B(var_0) {
  self endon("stop_anim");
  var_0 scripts\sp\anim::_id_1F0D(self, "cliffside_approach");
  var_0 scripts\sp\anim::_id_1F35(self, "cliffside_approach");
  var_0 thread scripts\sp\anim::_id_1EEA(self, "cliffside_idle", "stop_loop");

  if(self == level._id_2429) {
    scripts\engine\utility::flag_wait("ethan_cliffside_chat");
    var_0 notify("stop_loop");
    waittillframeend;
    thread _id_6D16();
    var_0 scripts\sp\anim::_id_1F35(level._id_2429, "cliffside_chat");

    if(scripts\engine\utility::flag("base_alerted") == 0) {
      var_0 notify("stop_loop");
      scripts\engine\utility::waitframe();
      var_0 thread scripts\sp\anim::_id_1EEA(level._id_2429, "cliffside_idle", "stop_loop");
    }
  }
}

_id_3619(var_0) {
  var_1 = getEntArray("jeep_toss_model", "script_noteworthy");
  var_2 = scripts\engine\utility::getStruct("c12_slide_anim", "targetname");
  var_3 = scripts\engine\utility::getStruct("jeep_toss_animation", "targetname");
  var_0._id_1FBB = "jeep";
  level._id_739C._id_9BC1 = 1;
  level._id_739C scripts\sp\utility::_id_54F7();
  var_2 scripts\sp\anim::_id_1F17(level._id_739C, "slide_down");
  var_2 scripts\sp\anim::_id_1F35(level._id_739C, "slide_down");
  var_0._id_5958 = 1;
  var_3 scripts\sp\anim::_id_1F17(level._id_739C, "jeep_punch");
  var_3 thread c12_desteoy_jeep();

  foreach(var_5 in var_1) {
    var_5 delete();
  }

  var_0 delete();
  showmayhem("jeep_toss_mayhem");
  playmayhem("jeep_toss_mayhem");
  thread _id_0B0A::_id_583D(3.0);
  scripts\engine\utility::exploder("fx_c12_flip_car");
  level notify("jeep_punched");
  scripts\engine\utility::flag_wait("jeep_destroyed");
  var_7 = spawn("script_origin", (-37539, -43096, -64812));
  var_7 playLoopSound("scn_c12_jeep_fire_med_lp");
  wait 1;
  thread scripts\sp\maps\titan\titan_code::_id_A556("titan_ksh_thatsawesome");

  if(level._id_76E2.size > 0) {
    level._id_739C scripts\sp\utility::_id_61C7();
  }

  level._id_739C._id_9BC1 = undefined;
}

c12_desteoy_jeep() {
  scripts\sp\anim::_id_1F35(level._id_739C, "jeep_punch");
  scripts\engine\utility::flag_set("jeep_destroyed");
}

_id_A44B(var_0) {
  scripts\engine\utility::flag_wait("jeep_destroyed");

  while(!scripts\engine\utility::flag("apc_move_up_1")) {
    var_1 = distance((-37622, -43066, -64812), level.player.origin);
    var_2 = (-37622, -43066, -64812) - level.player.origin;
    var_3 = vectorNormalize(var_2);
    var_4 = anglesToForward(level.player.angles);
    var_5 = vectordot(var_4, var_3);

    if(var_5 > 0 || var_1 < 400) {
      showmayhem("jeep_toss_mayhem");
    } else if(var_1 > 400) {
      hidemayhem("jeep_toss_mayhem");
    }

    wait 0.3;
  }
}

_id_10636() {
  var_0 = getEntArray("freighter_ships", "targetname");
  var_1 = getEntArray("cargo_ship_1", "targetname");
  var_0 = sortbydistance(var_0, level.player.origin);
  var_1 = sortbydistance(var_1, level.player.origin);

  foreach(var_5, var_3 in var_0) {
    var_4 = var_1[var_5] scripts\sp\utility::_id_10808();
    var_3.origin = var_4.origin;
    var_3 linkTo(var_4, "tag_origin");
    var_3 thread _id_0BAF::_id_11868();
    var_3.vehicle = var_4;
  }

  scripts\engine\utility::flag_wait("front_jeep_spawned");

  foreach(var_3 in var_0) {
    wait(randomintrange(8, 12));
    var_3 thread _id_3A7D();
  }
}

_id_3A7D() {
  thread scripts\sp\vehicle_paths::_id_845A(self.vehicle);
  self.vehicle scripts\engine\utility::waittill_any_timeout(60, "reached_dynamic_path_end");

  if(isDefined(self) && isDefined(self.vehicle)) {
    self.vehicle delete();
  }

  if(isDefined(self)) {
    self delete();
  }
}

_id_956B() {
  var_0 = getEnt("canyon_blocker_clip", "targetname");
  var_1 = getEnt("canyon_blocker_patch", "targetname");
  var_2 = getEntArray("canyon_blocker", "targetname");
  var_1 connectpaths();
  var_1 notsolid();
  var_1 hide();
  var_0 connectpaths();
  var_0 notsolid();

  foreach(var_4 in var_2) {
    var_4 hide();
  }

  if(level._id_10CDA != "apc_base_attack") {
    scripts\engine\utility::flag_wait_all("freighter_flyby", "base_alerted");
  }

  var_1 disconnectPaths();
  var_1 solid();
  var_1 show();
  var_0 disconnectPaths();
  var_0 solid();

  foreach(var_4 in var_2) {
    var_4 show();
  }
}

init_apc_teleport() {
  var_0 = getvehiclenode("apc_left_tp_node", "targetname");
  var_1 = getvehiclenode("apc_right_tp_node", "targetname");
  var_2 = 250;
  var_3 = getaiarray("allies");

  foreach(var_5 in var_3) {
    var_6 = distance2d(var_5.origin, var_0.origin);

    while(var_6 < var_2) {
      scripts\engine\utility::waitframe();
    }
  }

  level._id_2052 thread apc_teleport_forward(var_0);

  foreach(var_5 in var_3) {
    var_6 = distance2d(var_5.origin, var_1.origin);

    while(var_6 < var_2) {
      scripts\engine\utility::waitframe();
    }
  }

  level._id_2050 thread apc_teleport_forward(var_1);
}

apc_teleport_forward(var_0) {
  self notify("stop_move_along_struct_path");
  self vehicle_teleport(var_0.origin, var_0.angles);
  self startpath();
  wait 0.1;
  scripts\sp\vehicle::_id_8441();
  thread _id_2089();
}
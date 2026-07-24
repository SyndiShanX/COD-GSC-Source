/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\marsbase\marsbase_hill_gate.gsc
***********************************************************/

_id_10C5B() {
  scripts\engine\utility::flag_init("flag_hill_gate_aa_left_down");
  scripts\engine\utility::flag_init("flag_hill_gate_aa_right_down");
  scripts\engine\utility::flag_init("flag_hill_gate_final_aa_down");
  scripts\engine\utility::flag_init("flag_hill_gate_back_c12_enter");
  scripts\sp\maps\marsbase\marsbase_util::_id_7271("flag_hill_c8s_destroyed");
  _id_16EA();
  var_0 = ["salter", "ethan", "brooks", "mccallum", "griff"];
  scripts\sp\maps\marsbase\marsbase_util::_id_10626(var_0, "ally_start_endgate");
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("player_start_endgate", "targetname"));
  scripts\sp\maps\marsbase\marsbase_util::_id_F3B6();
  scripts\sp\maps\marsbase\marsbase_util::_id_6F56("hill_gate_left_mid_robots_floodspawn");
  level thread _id_F5F1();
  scripts\sp\maps\marsbase\marsbase_code::_id_14EB("aa_gun_3");
  scripts\sp\maps\marsbase\marsbase_code::_id_14EB("aa_gun_4");
  level notify("loot_crate_aa1_cleanup");
  level notify("loot_crate_greenhouse_cleanup");
  level notify("loot_crate_aa2_cleanup");
}

_id_B1E6() {
  scripts\sp\utility::_id_2669("End Gate");
  scripts\engine\utility::flag_init("flag_hill_gate_c12_ready");
  scripts\engine\utility::flag_init("flag_hill_gate_jackal_sacrifice_start");
  scripts\engine\utility::flag_init("flag_hill_gate_aa_3_hit");
  scripts\engine\utility::flag_init("flag_hill_gate_jackal_03_hit");
  scripts\engine\utility::flag_init("flag_hill_gate_aa_gun_03_hit");
  scripts\engine\utility::flag_init("flag_hill_gate_aa_gun_04_hit");
  scripts\engine\utility::flag_clear("flag_hill_gate_jackals_weapons_loose");
  scripts\engine\utility::flag_init("flag_hill_jackals_on_task");
  scripts\engine\utility::flag_init("flag_hill_gate_jackal_copy");
  scripts\engine\utility::flag_init("flag_hill_c12_dropped");
  scripts\engine\utility::flag_init("flag_hill_gate_c12_dropship_ready");
  scripts\engine\utility::flag_init("flag_hill_gate_aa_call_for_fire");
  scripts\engine\utility::flag_init("flag_hill_gate_no_strike");
  scripts\engine\utility::flag_init("flag_hill_gate_jackal_final_run");
  scripts\engine\utility::flag_init("flag_hill_gate_aa_call_for_kamikazi");
  scripts\engine\utility::flag_init("flag_hill_gate_jackal_final_words");
  scripts\engine\utility::flag_init("flag_hill_gate_jackal_intial_flyby");
  level thread scripts\sp\maps\marsbase\marsbase_dialogue::_id_8F7D();
  level thread _id_8F77();
  level thread _id_8912();
  level thread _id_8910();
  var_0 = getspawnerarray();
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_1747, ::_id_5572);
  level thread _id_10666();
  scripts\sp\maps\marsbase\marsbase_util::_id_6F57("hill_fill_floodspawn", undefined, 1);
  scripts\sp\maps\marsbase\marsbase_util::_id_6F56("hill_gate_c12_follow_floodspawn");
  scripts\sp\maps\marsbase\marsbase_util::_id_F47B();
  scripts\engine\utility::waitframe();
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_10685("hill_gate_right_spawn_closet_airlock_small", "flag_bridgewalk_end", "flag_hill_battle_elevator_started");
  scripts\sp\maps\marsbase\marsbase_code::_id_C2AC("aa3");
  scripts\engine\utility::flag_wait("flag_hill_gate_reached");
  var_1 = getEnt("hill_end_gate_kill_trig", "targetname");
  var_1 thread _id_8F79();
  _id_1070F();
  scripts\engine\utility::flag_set("flag_endgate_start");
  scripts\engine\utility::flag_wait_all("flag_hill_gate_back_c12_enter", "flag_hill_gate_c12_dropship_ready", "flag_hill_gate_c12_ready");
  level notify("hill_gate_c12_lockdown_initiated");
  wait 2;
  var_2 = spawn("script_origin", (38717, 26228, -10152));
  wait 1;
  var_3 = getnodearray("hill_gate_c12_escort_advance_node", "targetname");
  scripts\engine\utility::array_call(var_3, ::_meth_80AC);
  scripts\sp\maps\marsbase\marsbase_code::_id_106B2("endgate_droppod_1");
  _id_1070F();
  _id_0B77::_id_A67F(50);
  scripts\engine\utility::flag_wait("flag_hill_gate_final_aa_down");
  var_2 playSound("mars_base_jackal_explo_1");
  wait 3.0;
  level thread scripts\sp\maps\marsbase\marsbase_dialogue::_id_5414();
  scripts\sp\maps\marsbase\marsbase_util::_id_6F57("hill_gate_left_mid_robots_floodspawn", undefined, 1);
  scripts\engine\utility::flag_set("flag_endgate_end");
  scripts\engine\utility::flag_wait("flag_hill_gate_sdf_retreat");
  _id_8F7E();
  thread scripts\sp\maps\marsbase\marsbase_elevator::_id_60CA();
  var_2 delete();
}

_id_F5F1() {
  thread set_up_spawn_initial_gate_enemies_c12();
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_6E55("flag_hill_gate_reached", ::_id_8911);
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_6E55("flag_hill_c8s_destroyed", scripts\sp\utility::_id_22CD, ["hill_gate_back_robots"]);
}

set_up_spawn_initial_gate_enemies_c12() {
  scripts\engine\utility::flag_wait_any("flag_hill_c8s_destroyed", "flag_hill_gate_init");
  thread _id_10667();
}

_id_8F77() {
  scripts\engine\utility::flag_wait("flag_hill_c8s_destroyed");
  scripts\sp\maps\marsbase\marsbase_util::_id_6F57("hill_intro_redshirt_floodspawn", undefined, 1);
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2.damageshield) || var_2.damageshield == 0) {
      var_2 _meth_81D0();
      continue;
    }

    var_2.attackeraccuracy = 0;
  }

  wait 1;
  scripts\sp\utility::_id_15F5("hill_gate_intro_colortrig");
  level thread scripts\engine\utility::flag_set_delayed("flag_hill_gate_battle_advance", 3);
  level scripts\sp\maps\marsbase\marsbase_util::_id_6E55("flag_hill_gate_battle_advance", scripts\sp\utility::_id_15F5, ["hill_gate_advance_colortrig"], ["flag_hill_gate_sdf_retreat"]);
  scripts\engine\utility::flag_wait("flag_hill_gate_c12_ready");
  scripts\sp\utility::_id_15F5("hill_gate_advance_colortrig");
  scripts\sp\utility::_id_15F5("hill_gate_c12_escort_colortrig");
  scripts\engine\utility::flag_wait("flag_hill_gate_aa_left_down");
  var_4 = getaiarray("axis");
  scripts\engine\utility::array_thread(var_4, scripts\sp\maps\marsbase\marsbase_util::_id_B3A5);
  scripts\engine\utility::flag_wait("flag_hill_gate_final_aa_down");
  var_5 = getspawnerarray();
  scripts\engine\utility::array_thread(var_5, scripts\sp\utility::_id_1747, scripts\sp\maps\marsbase\marsbase_util::_id_B3A5);

  while(isalive(level._id_19DA))
    wait 1;

  scripts\engine\utility::flag_set("flag_hill_gate_sdf_retreat");
  var_4 = getaiarray("axis");
  scripts\engine\utility::array_thread(var_4, ::_id_8F78);
  scripts\sp\utility::_id_15F5("hill_gate_push_colortrig");
  scripts\engine\utility::flag_wait("flag_hill_gate_allies_stairs");
  scripts\sp\utility::_id_15F5("trig_allies_bridgewalk");
  scripts\engine\utility::flag_wait("flag_bridgewalk_end");
  var_5 = getspawnerarray();
  scripts\engine\utility::array_thread(var_5, scripts\sp\utility::_id_E08B, scripts\sp\maps\marsbase\marsbase_util::_id_B3A5);
}

_id_8F78() {
  self endon("death");
  thread scripts\sp\maps\marsbase\marsbase_util::_id_13BF3();

  if(isDefined(self._id_ECE7) && self._id_ECE7 == "hill_gate_retreat_snipers")
    level scripts\engine\utility::flag_wait_or_timeout("flag_hill_gate_allies_stairs", 10);

  if(scripts\sp\maps\marsbase\marsbase_util::_id_9CA8()) {
    self _meth_81D0(self.origin + (0, 0, 512));
    return;
  }

  scripts\sp\utility::_id_F4B2(1);
  scripts\sp\utility::_id_F2D8(0);
  scripts\sp\utility::_id_F3B5("r");
  scripts\sp\maps\marsbase\marsbase_util::_id_B3A5();
}

_id_5572() {
  if(scripts\sp\maps\marsbase\marsbase_util::_id_9CA8()) {
    self.noragdoll = 1;
    self._id_C061 = 1;
  }
}

_id_10740() {
  var_0 = scripts\sp\utility::_id_77DF("hill_gate_c6_idle_ready");
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_1747, ::_id_92E6);

  foreach(var_2 in var_0)
  var_3 = var_2 scripts\sp\utility::_id_10619(1);
}

_id_8911() {
  thread scripts\sp\maps\marsbase\marsbase_code::_id_C601("gate_endgate_side", 0, 2);
  scripts\sp\utility::_id_15F5("enemy_trig_endgate_vehicles");
  scripts\engine\utility::delaythread(2, scripts\sp\maps\marsbase\marsbase_code::_id_426D, "gate_endgate_side");
  scripts\engine\utility::waitframe();
  var_0 = scripts\sp\utility::_id_8201("vehicle_endgate_atv_1", "script_noteworthy");
  var_1 = scripts\sp\utility::_id_8201("vehicle_endgate_atv_2", "script_noteworthy");
  var_0 = scripts\engine\utility::array_combine(var_0, var_1);
  scripts\sp\utility::_id_228A(var_0);
  var_2 = getEntArray("vehicle_endgate_atv_1", "script_noteworthy");
  var_3 = getEntArray("vehicle_endgate_atv_2", "script_noteworthy");
  var_2 = scripts\engine\utility::array_combine(var_2, var_3);
  var_4 = [];

  foreach(var_6 in var_2) {
    if(var_6 scripts\sp\vehicle::_id_9FEF() && var_6.classname == "script_vehicle_atv")
      var_4 = scripts\engine\utility::array_add(var_4, var_6);
  }

  scripts\sp\utility::_id_22D8(var_4, "reached_end_node");
  scripts\engine\utility::flag_set("flag_hill_gate_back_c12_enter");
  level notify("loot_crate_aa1_cleanup");
  level notify("loot_crate_greenhouse_cleanup");
  level notify("loot_crate_aa2_cleanup");
}

_id_10C5C() {
  var_0 = ["salter", "ethan", "brooks", "mccallum", "griff"];
  scripts\sp\maps\marsbase\marsbase_util::_id_10626(var_0, "ally_start_endgate");
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("player_start_endgate", "targetname"));
  scripts\sp\maps\marsbase\marsbase_code::_id_DFB4("aa_gun_3", 1);
  scripts\sp\maps\marsbase\marsbase_code::_id_DFB4("aa_gun_4", 1);
}

_id_B1E7() {
  scripts\engine\utility::flag_init("elevator_dropship_docked");
  scripts\sp\utility::_id_2669("Gate Support 3");
  level notify("hill_battle_jackals_stop");
  scripts\sp\maps\marsbase\marsbase_code::_id_C2AC("aa3_complete");
  scripts\sp\maps\marsbase\marsbase_util::_id_F338();
  level thread _id_88E5();
  level thread scripts\sp\maps\marsbase\marsbase_elevator_retreat::_id_88B9();
  level thread scripts\sp\maps\marsbase\marsbase_elevator_retreat::_id_CCF3();
  scripts\engine\utility::flag_set("flag_gate_support_3_end");
  var_0 = getnodearray("hill_gate_traversal", "script_noteworthy");
  scripts\engine\utility::array_call(var_0, ::_meth_80AC);
  scripts\sp\utility::_id_15F5("trig_allies_bridgestart");
  scripts\engine\utility::flag_wait("flag_bridgewalk_start");
}

_id_3B73() {
  scripts\engine\utility::flag_init("elevator_dropship_docked");
  _id_8F7B();
}

_id_16EA() {
  var_0 = getspawner("enemy_endgate_c12", "targetname");
  var_1 = getspawner("enemy_endgate_center_c12", "targetname");
  var_2 = scripts\sp\maps\marsbase\marsbase_code::_id_77E6("hill_gate_back_c8_group");
  var_3 = scripts\sp\utility::_id_8200("hill_gate_intro_jackal_01", "targetname");
  var_4 = scripts\sp\utility::_id_8200("hill_gate_intro_jackal_02", "targetname");
  var_5 = scripts\sp\utility::_id_8200("hill_gate_intro_jackal_03", "targetname");
  var_6 = scripts\sp\utility::_id_8200("hill_gate_intro_jackal_02_real", "targetname");
  scripts\engine\utility::array_thread([var_3, var_4, var_5], scripts\sp\utility::_id_1747, ::_id_76EB);
  var_0 scripts\sp\utility::_id_1747(::_id_8F38);
  var_1 scripts\sp\utility::_id_1747(::_id_8F39);
  scripts\engine\utility::array_thread(var_2, scripts\sp\utility::_id_1747, ::_id_2724);
}

_id_2724() {
  self endon("death");
  scripts\sp\utility::_id_F2D8(0);
  _id_0A04::_id_3454(0);
  self waittill("goal");
  _id_0A04::_id_3454(1);
  scripts\sp\utility::_id_F3E0(256);
}

_id_8F38() {
  var_0 = scripts\engine\utility::getStruct("hill_gate_c12_drop_align", "targetname");
  scripts\sp\utility::_id_F415(1);
  scripts\sp\utility::_id_F416(1);
  _id_0A05::_id_3551(0);
  var_0 waittill("c12_dropoff");
  _id_8F7A();
}

_id_8F39() {
  self endon("death");
  scripts\sp\utility::_id_F416(1);
  _id_0A05::_id_3551(0);
  scripts\engine\utility::flag_wait("flag_hill_gate_reached");
  thread scripts\sp\anim::_id_1F2C([self], "c12_poweron");
  self waittill("c12_poweron");
  scripts\sp\utility::_id_1101B();
  thread _id_76DC();
  scripts\engine\utility::flag_wait_either("flag_hill_gate_aa_left_down", "flag_hill_gate_final_aa_down");
  playFX(scripts\engine\utility::getfx("aa_explosion"), self.origin);
  playworldsound("frag_grenade_explode", self.origin);
  self dodamage(self.maxhealth, self.origin + (0, 0, 512), self, self, "MOD_EXPLOSIVE");
}

_id_92E6() {
  self endon("death");
  scripts\sp\utility::_id_F3E0(16);
  scripts\sp\utility::_id_F415(1);
  scripts\sp\utility::_id_23B7("c6_idle");
  wait(randomfloatrange(0.2, 0.4));
  thread scripts\sp\anim::_id_1EEA(self, "c6_idle_1");
  var_0 = scripts\sp\utility::_id_7DC1("c6_idle_1");
  scripts\engine\utility::delaycall(0.05, ::_meth_82B0, var_0[0], randomfloat(1));
  scripts\engine\utility::flag_wait("flag_hill_gate_reached");
  scripts\engine\utility::flag_wait("flag_hill_gate_back_c12_enter");
  wait(randomfloatrange(0.5, 1));
  self notify("stop_loop");
  scripts\sp\anim::_id_1F35(self, "c6_ready_1");
  scripts\sp\utility::_id_F415(0);
  scripts\sp\utility::_id_F3E0(1024);
}

_id_76EB() {
  self setneargoalnotifydist(1);
  self.ignoreme = 1;
  self._id_2713 = 1;
  self setCanDamage(0);
  self notsolid();
}

_id_10666() {
  level._id_191F = _id_106B6();
  wait 1.5;
  scripts\sp\maps\marsbase\marsbase_code::_id_426B("gate_elevator_bridge_left", "gate_elevator_bridge_right", undefined, undefined, 128);
  var_0 = getnodearray("hill_gate_traversal", "script_noteworthy");
  scripts\engine\utility::array_call(var_0, ::_meth_808B);
  var_1 = getEnt("gate_elevator_bridge_left", "targetname");
  var_2 = getEnt("gate_elevator_bridge_right", "targetname");
  var_1 disconnectPaths();
  var_2 disconnectPaths();
}

_id_10667() {
  level._id_19DA = _id_10665();
  _id_10740();
}

_id_8F7A() {
  self endon("death");
  scripts\sp\utility::_id_F3E0(64);
  var_0 = scripts\engine\utility::getStruct("struct_hill_gate_c12_goal", "targetname");
  var_1 = scripts\sp\utility::_id_864C(var_0.origin);
  level scripts\engine\utility::flag_set("flag_hill_gate_c12_ready");
  self setgoalpos(var_1);
  self waittill("goal");
  _id_0A05::_id_352D("left");
  _id_0A05::_id_352D("right");
  scripts\sp\utility::_id_F415(0);
  wait 1;
  self._id_1494 = scripts\sp\utility::_id_22B9(self._id_1494);
  scripts\engine\utility::array_thread(self._id_1494, scripts\sp\utility::_id_F3B5, "g");
  wait 3;
  var_2 = getnode("hill_gate_no_mans_areanode", "targetname");
  self._id_1492 = scripts\sp\utility::_id_22B9(self._id_1492);
  scripts\engine\utility::array_thread(self._id_1492, scripts\sp\utility::_id_54F7);
  scripts\engine\utility::array_call(self._id_1492, ::_meth_82EE, var_2);
  scripts\engine\utility::array_thread(self._id_1492, scripts\sp\utility::_id_F3E0, 1024);
  thread _id_76DB();
  scripts\engine\utility::flag_wait("flag_hill_gate_final_aa_down");
  playFX(scripts\engine\utility::getfx("aa_explosion"), self.origin);
  playworldsound("frag_grenade_explode", self.origin);
  self dodamage(self.maxhealth, self.origin + (0, 0, 512), self, self, "MOD_EXPLOSIVE");
}

_id_76DB() {
  self endon("death");
  var_0 = getnodearray("hill_gate_c12_walk_nodes", "targetname");

  for(;;) {
    var_0 = scripts\engine\utility::array_randomize(var_0);

    foreach(var_2 in var_0) {
      scripts\sp\utility::_id_F3E0(randomintrange(16, 64));
      self setgoalpos(var_2.origin);
      self waittill("goal");
      wait(randomfloat(5));
    }
  }
}

_id_76DC() {
  self endon("death");
  var_0 = "enemy_endgate_center_c12_node";

  for(;;) {
    var_1 = getnode(var_0, "targetname");
    scripts\sp\utility::_id_F3E0(randomintrange(64, 96));
    self setgoalpos(var_1.origin);
    self waittill("goal");
    var_0 = var_1.target;
    wait(randomintrange(1, 5));
  }
}

_id_13785(var_0, var_1) {
  while(isalive(var_0) && var_0.health / var_0.maxhealth * 100 > var_1)
    wait 0.5;
}

_id_8912() {
  scripts\engine\utility::flag_wait("flag_hill_gate_jackal_copy");
  level thread _id_76EA();
  scripts\engine\utility::flag_wait_all("flag_hill_gate_back_c12_enter", "flag_hill_jackals_on_task");
  level thread _id_76D3();
  wait 5;
  scripts\engine\utility::flag_wait_all("flag_hill_gate_jackal_final_run", "flag_hill_gate_aa_call_for_kamikazi", "flag_hill_gate_jackal_final_words");
  level thread _id_76D2();
  level thread _id_A536();
  scripts\engine\utility::flag_wait("flag_hill_gate_jackal_ram_gun");
  wait 0.2;
  scripts\engine\utility::flag_set("flag_hill_gate_final_aa_down");
  _id_301B();
}

_id_76EA() {
  var_0 = scripts\engine\utility::getStruct("fxanim_sp_mars_jackal_run_01", "targetname");
  var_1 = scripts\engine\utility::getStruct("fxanim_sp_mars_jackal_run_02", "targetname");
  var_2 = scripts\engine\utility::getStruct("fxanim_sp_mars_jackal_run_03", "targetname");
  var_3 = scripts\sp\vehicle::_id_1080C("hill_gate_intro_jackal_01");
  var_4 = scripts\sp\vehicle::_id_1080C("hill_gate_intro_jackal_02");
  var_5 = scripts\sp\vehicle::_id_1080C("hill_gate_intro_jackal_03");
  var_3 scripts\sp\utility::_id_23B7("jackal_run_01");
  var_4 scripts\sp\utility::_id_23B7("jackal_run_02");
  var_5 scripts\sp\utility::_id_23B7("jackal_run_03");
  level.gun["aa_gun_3"] thread scripts\sp\maps\marsbase\marsbase_code::_id_14E2([var_3, var_4, var_5], 3, 1);
  level.gun["aa_gun_4"] thread scripts\sp\maps\marsbase\marsbase_code::_id_14E2([var_3, var_4, var_5], 3, 1);
  var_0 thread scripts\sp\anim::_id_1F35(var_3, "jackal_run_initial");
  var_1 thread scripts\sp\anim::_id_1F35(var_4, "jackal_run_initial");
  var_2 thread scripts\sp\anim::_id_1F35(var_5, "jackal_run_initial");
  scripts\engine\utility::flag_set_delayed("flag_hill_gate_jackal_intial_flyby", 5);
  scripts\sp\utility::_id_22D8([var_0, var_1, var_2], "jackal_run_initial");
  level.gun["aa_gun_3"] thread scripts\sp\maps\marsbase\marsbase_code::_id_14E2(undefined, 3, 1);
  level.gun["aa_gun_4"] thread scripts\sp\maps\marsbase\marsbase_code::_id_14E2(undefined, 3, 1);
  scripts\sp\maps\marsbase\marsbase_util::_id_EA01(var_3);
  scripts\sp\maps\marsbase\marsbase_util::_id_EA01(var_4);
  scripts\sp\maps\marsbase\marsbase_util::_id_EA01(var_5);
}

_id_76D3() {
  var_0 = scripts\engine\utility::getStruct("fxanim_sp_mars_jackal_bomb_run_01", "targetname");
  var_1 = scripts\engine\utility::getStruct("fxanim_sp_mars_jackal_bomb_run_02", "targetname");
  var_2 = scripts\engine\utility::getStruct("fxanim_sp_mars_jackal_bomb_run_03", "targetname");
  var_3 = scripts\sp\vehicle::_id_1080C("hill_gate_intro_jackal_01");
  var_4 = scripts\sp\vehicle::_id_1080C("hill_gate_intro_jackal_02_real");
  var_5 = scripts\sp\vehicle::_id_1080C("hill_gate_intro_jackal_03");
  var_3 scripts\sp\utility::_id_23B7("jackal_run_01");
  var_4 scripts\sp\utility::_id_23B7("jackal_run_02");
  var_5 scripts\sp\utility::_id_23B7("jackal_run_03");
  var_0 thread scripts\sp\anim::_id_1F35(var_3, "jackal_run_gun");
  var_1 thread scripts\sp\anim::_id_1F35(var_4, "jackal_run_gun");
  var_2 thread scripts\sp\anim::_id_1F35(var_5, "jackal_run_gun");
  var_6 = scripts\engine\utility::getStruct("hill_battle_gate_gun_02_explode", "targetname");
  var_7 = scripts\engine\utility::spawn_tag_origin(var_6.origin, var_6.angles);
  var_4 thread _id_0C1B::_id_FE60();
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_6E55("flag_hill_gate_jackal_01_hit", scripts\sp\maps\marsbase\marsbase_sky_cowbell::_id_A1BF, [4, var_7]);
  var_7 scripts\engine\utility::delaycall(10, ::delete);
  level thread scripts\engine\utility::flag_set_delayed("flag_hill_gate_jackals_weapons_loose", 2);
  scripts\sp\utility::_id_22D8([var_0, var_1, var_2], "jackal_run_gun");
  scripts\sp\maps\marsbase\marsbase_util::_id_EA01(var_3);
  scripts\sp\maps\marsbase\marsbase_util::_id_EA01(var_4);
  scripts\sp\maps\marsbase\marsbase_util::_id_EA01(var_5);
}

_id_76D2() {
  var_0 = scripts\engine\utility::getStruct("fxanim_sp_mars_jackal_bomb_run_04", "targetname");
  var_1 = scripts\sp\vehicle::_id_1080C("hill_gate_intro_jackal_02");
  var_1 scripts\sp\utility::_id_23B7("jackal_run_02");
  var_0 scripts\sp\anim::_id_1F35(var_1, "jackal_run_kamakazi");
  scripts\sp\maps\marsbase\marsbase_util::_id_EA01(var_1);
}

_id_3B72() {
  scripts\engine\utility::flag_set("flag_endgate_end");
  _id_8F7E();
  thread scripts\sp\maps\marsbase\marsbase_elevator::_id_60CA();
  level.player scripts\sp\maps\marsbase\marsbase_killstreak::_id_1143D();
  scripts\engine\utility::delaythread(2, ::_id_301B);
}

_id_8F88(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];
  var_7 = undefined;
  var_8 = getcsplineidarray(var_0);
  var_8 = scripts\engine\utility::array_randomize(var_8);
  var_5 = scripts\engine\utility::ter_op(isDefined(var_5), var_5, "hill_gate_jackal_friendly");

  foreach(var_10 in var_8) {
    if(var_2 == "allies") {
      if(isDefined(var_5))
        var_7 = scripts\sp\vehicle::_id_1080C(var_5);
      else
        var_7 = scripts\sp\maps\marsbase\marsbase_sky_cowbell::_id_10747("hill_gate_jackal_friendly");
    } else
      var_7 = scripts\sp\maps\marsbase\marsbase_sky_cowbell::_id_10747("ambient_crashing_jackal_enemy");

    if(isDefined(var_7)) {
      var_7 _id_0BDC::_id_19A0(1);
      var_7 notsolid();
      var_11 = getcsplinepointposition(var_10, 0);
      var_7 vehicle_teleport(var_11, var_7.angles);

      if(isDefined(var_3)) {
        var_12 = var_3;
        var_7._id_2715 = 1;
      } else
        var_12 = scripts\sp\maps\marsbase\marsbase_sky_cowbell::_id_F429(250, 500);

      var_7 thread _id_0BDC::_id_A1EF(var_10, var_12, 16);
      var_6 = scripts\engine\utility::array_add(var_6, var_7);
      wait(var_1);
    }
  }

  return var_6;
}

_id_8910() {
  var_0 = scripts\engine\utility::getStruct("hill_battle_gate_gun_02_explode", "targetname");
  var_1 = scripts\engine\utility::getStruct("hill_battle_gate_gun_01_explode", "targetname");
  thread scripts\sp\maps\marsbase\marsbase_code::_id_14E8("aa_gun_3", 1);
  thread scripts\sp\maps\marsbase\marsbase_code::_id_14E8("aa_gun_4", 1);
  scripts\engine\utility::flag_wait_all("flag_hill_gate_reached", "flag_hill_gate_no_strike");
  scripts\sp\maps\marsbase\marsbase_util::_id_6F56("hill_gate_aa4_snipers_floodspawn");
  scripts\sp\maps\marsbase\marsbase_util::_id_6E43("flag_hill_gate_aa_call_for_fire", var_1, undefined, 5.0);
  level.player scripts\engine\utility::delaycall(0.05, ::_meth_80D1);
  level.player scripts\engine\utility::delaythread(0.05, scripts\sp\utility::_id_D08C, "ges_point", level.gun["aa_gun_4"]._id_38D6);
  level.player scripts\engine\utility::delaycall(1, ::_meth_80A1);
  scripts\engine\utility::flag_wait("flag_hill_gate_jackals_weapons_loose");
  wait 1;
  scripts\engine\utility::flag_set("flag_hill_gate_aa_left_down");
  level notify("aagun_destroyed", "aa_gun_4");
  var_0 thread _id_15B7();
  scripts\sp\maps\marsbase\marsbase_util::_id_6F57("hill_gate_aa4_snipers_floodspawn", undefined, 1);
  level thread _id_8F7C();
  scripts\engine\utility::delaythread(2, scripts\sp\maps\marsbase\marsbase_util::_id_6F56, "hill_gate_aa3_snipers_floodspawn");
  scripts\engine\utility::flag_wait("flag_hill_gate_jackal_final_run");
  scripts\sp\maps\marsbase\marsbase_util::_id_6E43("flag_hill_gate_aa_call_for_kamikazi", var_1, undefined, 2.0);
  scripts\engine\utility::flag_wait("flag_hill_gate_final_aa_down");
  scripts\engine\utility::flag_set("flag_hill_gate_aa_right_down");
  scripts\sp\utility::_id_2669("AA4 Down");
  var_1 thread _id_15B7();
  var_2 = scripts\engine\utility::spawn_tag_origin(var_1.origin, var_1.angles);
  level.player scripts\engine\utility::delaycall(0.1, ::_meth_80D1);
  level.player scripts\engine\utility::delaythread(0.2, scripts\sp\utility::_id_D090, "ges_frag_block", var_2);
  level.player scripts\engine\utility::delaycall(0.5, ::_meth_80A1);
  earthquake(0.75, 1.8, var_2.origin, 4000);
  level.player _meth_8244("artillery_rumble");
  level.player scripts\engine\utility::delaycall(1.8, ::stoprumble, "artillery_rumble");
  scripts\sp\maps\marsbase\marsbase_util::_id_6F57("hill_gate_aa3_snipers_floodspawn", undefined, 1);
  var_3 = scripts\engine\utility::getStruct("glass_break_1", "targetname");
  var_4 = scripts\engine\utility::getStruct("glass_break_2", "targetname");
  glassradiusdamage(var_3.origin, 128, 1000, 1000);
  wait 0.5;
  glassradiusdamage(var_4.origin, 128, 1000, 1000);
  wait 2;
  var_2 delete();
}

_id_15B7() {
  radiusdamage(self.origin, 768, 10000, 8000, undefined, "MOD_EXPLOSIVE");
  wait 0.5;
  physicsexplosionsphere(self.origin, 768, 512, 100);
}

_id_88E5() {
  var_0 = _id_10659("elevator_retreat_enemy");
  scripts\engine\utility::flag_wait("flag_hill_gate_allies_stairs");
  var_1 = _id_10659("elevator_retreat_enemy2");
  var_0 = scripts\engine\utility::array_combine(var_0, var_1);
  scripts\engine\utility::flag_wait_all("flag_gate_support_3_end", "flag_bridgewalk_end");
  var_0 = scripts\sp\utility::_id_22B9(var_0);
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_F415, 1);
}

_id_10659(var_0) {
  var_1 = getspawnerarray(var_0);
  var_2 = [];

  foreach(var_5, var_4 in var_1) {
    var_2[var_5] = var_4 scripts\sp\utility::_id_10619();

    if(!isalive(var_2[var_5])) {
      continue;
    }
    var_2[var_5] thread scripts\sp\maps\marsbase\marsbase_util::_id_13BF3();
    var_2[var_5] scripts\sp\utility::_id_F3B5("r");
    var_2[var_5] scripts\sp\utility::_id_F3E0(16);
    var_2[var_5].accuracy = 0.1;

    if(!isDefined(var_4.script_noteworthy) || var_4.script_noteworthy != "no_pacifist")
      var_2[var_5] scripts\sp\utility::_id_F4B2(1);
  }

  var_2 = scripts\engine\utility::array_removeundefined(var_2);
  return var_2;
}

_id_7272(var_0) {
  self setgoalpos(self getorigin());
  scripts\sp\utility::_id_7226(var_0);
}

_id_106B6() {
  var_0 = scripts\engine\utility::getStruct("hill_gate_c12_drop_align", "targetname");
  var_1 = getEnt("dropship_endgate_c12", "targetname");
  var_1.count = 1;
  var_1 scripts\sp\utility::_id_1747(scripts\sp\vehicle::_id_8441);
  var_2 = var_1 scripts\sp\utility::_id_10808();
  var_2.ignoreme = 1;
  var_2._id_1FBB = "dropship";
  var_3 = scripts\engine\utility::getStruct("dropship_endgate_c12_start", "targetname");
  var_4 = getEnt("enemy_endgate_c12", "targetname");
  var_4.count = 1;
  var_5 = var_4 scripts\sp\utility::_id_10619(1, 1);
  var_5._id_1FBB = "c12";
  var_5.script_pushable = 0;
  level.c12_1 = var_5;
  var_0 scripts\sp\anim::_id_1EC3(var_2, "c12_dropoff");
  var_0 scripts\sp\anim::_id_1EC3(var_5, "c12_dropoff");
  var_2._id_1F50 = var_2.origin;
  var_2._id_1F4D = var_2.angles;
  var_5 linkTo(var_2);
  var_2 vehicle_teleport(var_3.origin, var_3.angles);
  var_2 sethoverparams(0, 0, 0);
  scripts\engine\utility::flag_wait("flag_hill_gate_c12_dropship_ready");
  var_2 setneargoalnotifydist(256);
  var_2 thread scripts\sp\vehicle::_id_1321A(var_3);
  wait 2.5;
  var_2 notify("newpath");
  var_2._id_1F4F = scripts\engine\utility::spawn_tag_origin(var_2.origin, var_2.angles);
  var_2 linkTo(var_2._id_1F4F);
  var_2._id_1F4F rotateTo(var_2._id_1F4D, 1.2, 0.1, 0.2);
  var_2._id_1F4F moveTo(var_2._id_1F50, 1.2, 0.1, 0.2);
  wait 1.2;
  var_2 unlink();
  var_2._id_1F4F delete();
  var_5._id_1492 = scripts\sp\maps\marsbase\marsbase_code::_id_1061E("hill_gate_c12_escort_group");
  var_5._id_1494 = scripts\sp\maps\marsbase\marsbase_code::_id_1061E("hill_gate_c12_follow_group");
  var_5._id_1494 = scripts\engine\utility::array_combine(var_5._id_1494, var_5._id_1492);
  var_2 playSound("mars_base_gate_dropship_flyby");
  var_0 thread scripts\sp\anim::_id_1F35(var_2, "c12_dropoff");
  var_2 thread _id_5DCA();
  var_5 unlink();
  var_0 scripts\sp\anim::_id_1F35(var_5, "c12_dropoff");
  var_5 scripts\sp\utility::_id_1101B();
  scripts\engine\utility::flag_set("flag_hill_c12_dropped");
  return var_5;
}

_id_5DCA() {
  self endon("death");
  wait 2;
  self _meth_83A1();
  self setneargoalnotifydist(64);
  var_0 = scripts\engine\utility::getStruct("dropship_endgate_c12_exit", "targetname");
  self.speed = 50;
  scripts\sp\vehicle::_id_1321A(var_0);
  self delete();
}

_id_10665() {
  var_0 = getEnt("enemy_endgate_center_c12", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_10619(1, 1);
  var_1._id_1FBB = "c12";
  var_1.script_pushable = 0;
  level.c12_2 = var_1;
  var_1 scripts\sp\anim::_id_1EC1([var_1], "c12_poweron");
}

_id_35C7() {
  self endon("death");
  self endon("stop_missles");

  for(;;) {
    _id_0A05::_id_360C(randomintrange(10, 50));
    _id_0A05::_id_3555("left", 1);
    self waittill("shoot_rocket_finished");
    _id_0A05::_id_360C(randomintrange(10, 50));
    _id_0A05::_id_3555("right", 1);
    wait(randomfloat(5));
  }
}

_id_1070F() {
  var_0 = sortbydistance(getEntArray("dropped_endgate", "script_noteworthy"), level.player.origin);

  for(var_1 = var_0.size - 1; var_1 > -1; var_1--)
    var_0[var_1] scripts\engine\utility::delaythread((var_0.size - var_1) * 0.6, ::_id_10795);
}

_id_10795() {
  var_0 = scripts\sp\utility::_id_10808();
  var_0 waittill("landed");
  var_0 delete();
}

_id_8F7C() {
  var_0 = getEntArray("hill_gate_destructibles", "script_noteworthy");

  foreach(var_2 in var_0) {
    wait(randomfloat(0.2));
    var_2 dodamage(10000, var_2.origin + (0, 0, 512), undefined, undefined, "MOD_EXPLOSIVE");
  }
}

_id_8F7B() {
  var_0 = getEntArray("hill_gate_destructibles", "script_noteworthy");
  scripts\sp\utility::_id_228A(var_0);
}

_id_301C() {
  var_0 = getEnt("gate_elevator_bridge_left", "targetname");
  var_1 = getEnt("gate_elevator_bridge_right", "targetname");
  var_2 = getEnt("gate_elevator_bridge_left_m", "targetname");
  var_3 = getEnt("gate_elevator_bridge_right_m", "targetname");
  var_2 linkTo(var_0);
  var_3 linkTo(var_1);
}

_id_301B(var_0) {
  var_1 = getEnt("gate_elevator_bridge_left", "targetname");
  var_2 = getEnt("gate_elevator_bridge_right", "targetname");
  var_3 = getEnt("gate_elevator_bridge_left_m", "targetname");
  var_4 = getEnt("gate_elevator_bridge_right_m", "targetname");
  var_5 = scripts\engine\utility::getStruct("hill_gate_destruction_fx", "targetname");
  var_0 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, 0);

  if(!var_0 && isDefined(var_5))
    playFX(scripts\engine\utility::getfx("vfx_mars_gate_explosion"), var_5.origin);

  scripts\sp\maps\marsbase\marsbase_util::_id_EA01(var_1);
  scripts\sp\maps\marsbase\marsbase_util::_id_EA01(var_2);
  scripts\sp\maps\marsbase\marsbase_util::_id_EA01(var_3);
  scripts\sp\maps\marsbase\marsbase_util::_id_EA01(var_4);
}

_id_8F79() {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_0);

    if(isPlayer(var_0)) {
      playFX(scripts\engine\utility::getfx("aa_explosion"), var_0.origin);
      playworldsound("frag_grenade_explode", var_0.origin);
    }
  }
}

_id_8F7E() {
  scripts\sp\maps\marsbase\marsbase_util::_id_6F57("hill_gate_c12_follow_floodspawn", undefined, 1);
  var_0 = getEnt("trig_hill_gate_right_spawn_closet_airlock_small", "targetname");
  var_1 = getaiarray("axis");

  foreach(var_3 in var_1) {
    if(var_3 istouching(var_0)) {
      if(scripts\engine\utility::is_true(var_3.damageshield))
        var_3 scripts\sp\utility::_id_1101B();

      if(isalive(var_3) && var_3.unittype != "c12")
        var_3 _meth_81D0();
    }
  }

  thread hill_gate_ents_clean_up_c12(level.c12_1);
  thread hill_gate_ents_clean_up_c12(level.c12_2);
  scripts\sp\utility::_id_228A(getEntArray("hill_gate_ents", "script_noteworthy"));
  var_5 = getEnt("hill_end_gate_kill_trig", "targetname");
  var_5 delete();
}

hill_gate_ents_clean_up_c12(var_0) {
  if(isalive(var_0)) {
    while(isDefined(var_0._blackboard._id_E5FD) && var_0._blackboard._id_E5FD)
      wait 0.1;

    if(isalive(var_0))
      var_0 dodamage(var_0.maxhealth, var_0.origin + (0, 0, 512), var_0, var_0, "MOD_EXPLOSIVE");
  }
}

_id_A537() {
  var_0 = getEnt("fxanim_sp_mars_aa_turret_kamikaze", "targetname");
  var_1 = getEnt("fxanim_sp_mars_aa_turret_gun_pristine_kamikaze", "targetname");
  var_2 = getEnt("fxanim_sp_mars_kamikaze_strike_playspace_debris", "targetname");
  var_3 = getEnt("fxanim_sp_mars_kamikaze_strike_scraps", "targetname");
  var_4 = getEnt("fxanim_sp_mars_kamikaze_strike_lower_tower_dmg", "targetname");
  var_1 delete();
  var_0 hide();
  var_2 hide();
  var_3 hide();
  var_4 hide();
}

_id_A536() {
  var_0 = getEnt("fxanim_sp_mars_aa_turret_kamikaze", "targetname");
  var_1 = getEnt("fxanim_sp_mars_kamikaze_strike_playspace_debris", "targetname");
  var_2 = getEnt("fxanim_sp_mars_kamikaze_strike_scraps", "targetname");
  var_3 = getEnt("fxanim_sp_mars_kamikaze_strike_lower_tower_dmg", "targetname");
  var_4 = getEntArray("aa_gun_3_destruction", "script_noteworthy");
  var_0 scripts\sp\utility::_id_23B7("animname_aa_gun_kamikazi");
  var_1 scripts\sp\utility::_id_23B7("animname_aa_kamikazi_debris");
  var_2 scripts\sp\utility::_id_23B7("animname_aa_kamikazi_scraps");
  var_2 thread scripts\sp\anim::_id_1F35(var_2, "fxanim_aa_gun_strike");
  var_1 thread scripts\sp\anim::_id_1F35(var_1, "fxanim_aa_gun_strike");
  scripts\engine\utility::flag_wait("flag_hill_gate_jackal_ram_gun");
  level notify("aagun_destroyed", "aa_gun_3");
  wait 0.2;
  var_0 thread scripts\sp\anim::_id_1F35(var_0, "fxanim_aa_gun_strike");
  var_1 show();
  var_0 show();
  var_2 show();
  var_3 show();
  scripts\sp\utility::_id_228A(var_4);
}
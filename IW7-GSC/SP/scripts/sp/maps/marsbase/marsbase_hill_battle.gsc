/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\marsbase\marsbase_hill_battle.gsc
*************************************************************/

_id_10C7B() {
  scripts\engine\utility::flag_init("flag_hill_c8s_destroyed");
  var_0 = ["salter", "ethan", "brooks", "mccallum", "griff"];
  scripts\sp\maps\marsbase\marsbase_util::_id_10626(var_0, "ally_start_hill_combat");
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("player_start_hill_combat", "targetname"));
  scripts\sp\maps\marsbase\marsbase_util::_id_6F56("hill_intro_redshirt_floodspawn");
  scripts\sp\maps\marsbase\marsbase_util::_id_F3B6();
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_1080A("hill_intro_atv", undefined, scripts\sp\maps\marsbase\marsbase_util::_id_B39B);
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_127B1("hill_battle_lower_left_elevator_spawntrig", ::_id_8F21);
  level thread _id_3A80();
  scripts\sp\maps\marsbase\marsbase_code::_id_14EB("aa_gun_3");
  scripts\sp\maps\marsbase\marsbase_code::_id_14EB("aa_gun_4");
  level notify("loot_crate_aa1_cleanup");
  level notify("loot_crate_greenhouse_cleanup");
  level notify("loot_crate_aa2_cleanup");
  scripts\sp\maps\marsbase\marsbase_code::_id_C2AC("aa2_complete");
}

_id_B1F5() {
  scripts\engine\utility::flag_init("flag_hill_battle_elevator_started");
  scripts\engine\utility::flag_init("flag_hill_monorail_jackal_crash");
  scripts\engine\utility::flag_init("flag_hill_battle_right_spawn_closet_airlock_large_spawn");
  scripts\engine\utility::flag_init("flag_hill_battle_left_spawn_closet_airlock_small_spawn");
  scripts\sp\utility::_id_2669("Hill Battle");
  level thread scripts\sp\maps\marsbase\marsbase_dialogue::_id_5455();
  level thread _id_8F1B();
  level thread _id_88EA();
  scripts\sp\maps\marsbase\marsbase_util::_id_6F56("hill_intro_fill_floodspawn");
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_6E55("flag_hill_battle_lower_fallback", scripts\sp\maps\marsbase\marsbase_util::_id_6F57, ["hill_fill_floodspawn", undefined, 1]);
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_6E55("flag_hill_battle_lower_fallback", scripts\sp\maps\marsbase\marsbase_util::_id_6F56, ["hill_fill_floodspawn"]);
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_6E55("flag_hill_combat_start", ::_id_CCFA, ["tag_align_left_hill_officer", "uphill_commander_left", "uphill_battle_left"]);
  level thread _id_8F26();
  level thread _id_8F27();
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_6E43("flag_hill_battle_right_spawn_closet_airlock_large_spawn", scripts\engine\utility::getStruct("hill_battle_lower_right_spawn_closet_airlock_floodspawn_look", "targetname"), 0);
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_6E55("flag_hill_battle_right_spawn_closet_airlock_large_spawn", scripts\sp\maps\marsbase\marsbase_util::_id_6F56, "hill_battle_lower_right_spawn_closet_airlock_floodspawn", undefined, ["flag_hill_c8s_destroyed"]);
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_6E43("flag_hill_battle_left_spawn_closet_airlock_small_spawn", scripts\engine\utility::getStruct("hill_battle_lower_left_spawn_closet_airlock_floodspawn_look", "targetname"), 0);
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_6E55("flag_hill_battle_left_spawn_closet_airlock_small_spawn", scripts\sp\maps\marsbase\marsbase_util::_id_6F56, "hill_battle_lower_left_spawn_closet_airlock_floodspawn", undefined, ["flag_hill_c8s_destroyed"]);
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_10685("hill_battle_left_spawn_closet_airlock_small", "flag_hill_c8s_destroyed", "flag_hill_combat_end", ::_id_AB4D);
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_10685("hill_battle_left_spawn_closet_airlock_large", "flag_hill_c8s_destroyed", "flag_hill_combat_end", ::_id_AB4C);
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_10685("hill_battle_right_spawn_closet_airlock_small_01", "flag_hill_c8s_destroyed", "flag_hill_combat_end", ::_id_E528);
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_10685("hill_battle_right_spawn_closet_airlock_large_01", "flag_hill_c8s_destroyed", "flag_hill_combat_end", ::_id_E527);
  level thread _id_8F29();
}

_id_8F29() {
  scripts\engine\utility::flag_wait("flag_hill_battle_lower_fallback");
  _id_8F1D();
  var_0 = getnodearray("hill_gate_traversal", "script_noteworthy");
  scripts\engine\utility::array_call(var_0, ::_meth_80AC);
}

_id_3B6E() {
  scripts\engine\utility::flag_init("flag_hill_monorail_jackal_crash");
  _id_8F1D();
  level.player giveweapon("iw7_steeldragon");
  level.player switchtoweapon("iw7_steeldragon");
  scripts\sp\maps\marsbase\marsbase_hill_intro::_id_3B74();
  var_0 = getnodearray("hill_gate_traversal", "script_noteworthy");
  scripts\engine\utility::array_call(var_0, ::_meth_80AC);
}

_id_8F1D() {
  scripts\sp\maps\marsbase\marsbase_util::_id_7271("flag_hill_battle_lower_left_push");
  scripts\sp\maps\marsbase\marsbase_util::_id_7271("flag_hill_battle_lower_right_push");
  scripts\sp\maps\marsbase\marsbase_util::_id_7271("flag_hill_battle_lower_fallback");
}

_id_8F1B() {
  scripts\sp\utility::_id_15F5("hill_intro_end_allies_colortrig");
  scripts\sp\utility::_id_15F5("hill_battle_lower_enemy_colortrig");
  scripts\engine\utility::flag_wait("flag_hill_battle_lower_fallback");
  var_0 = scripts\sp\utility::_id_77DA("hill_battle_left_lower_floodgroup");
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_F3B5, "y");
  scripts\sp\utility::_id_15F5("hill_battle_lower_fallback_colortrig");
  scripts\engine\utility::flag_wait("flag_hill_lower_enemies_fallback");
  scripts\sp\utility::_id_15F5("hill_battle_lower_enemy_fallback_colortrig");
}

_id_AB4C() {
  _id_10686("trig_kill_hill_battle_left_spawn_closet_airlock_large", "trig_flag_hill_battle_left_spawn_closet_airlock_large");
}

_id_E527() {
  _id_10686("trig_kill_hill_battle_right_spawn_closet_airlock_large_01", "trig_flag_hill_battle_right_spawn_closet_airlock_large_01");
}

_id_E528() {
  _id_10686("trig_kill_hill_battle_right_spawn_closet_airlock_small_01", "trig_flag_hill_battle_right_spawn_closet_airlock_small_01");
}

_id_AB4D() {
  _id_10686("trig_kill_hill_battle_left_spawn_closet_airlock_small", "trig_flag_hill_battle_left_spawn_closet_airlock_small");
}

_id_10686(var_0, var_1) {
  scripts\sp\utility::_id_127AE(var_0, "targetname");
  var_2 = getEnt(var_1, "targetname");
  var_3 = getaiarray("axis");

  foreach(var_5 in var_3) {
    if(var_5 istouching(var_2)) {
      if(scripts\engine\utility::is_true(var_5.damageshield))
        var_5 scripts\sp\utility::_id_1101B();

      var_5 _meth_81D0();
    }
  }

  scripts\engine\utility::flag_clear(var_2._id_ED9A);
  var_2 delete();
}

_id_10C7C() {
  scripts\engine\utility::flag_init("flag_hill_c8s_destroyed");
  var_0 = ["salter", "ethan", "brooks", "mccallum", "griff"];
  scripts\sp\maps\marsbase\marsbase_util::_id_10626(var_0, "ally_start_hill_c8");
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("player_start_hill_c8", "targetname"));
  scripts\sp\maps\marsbase\marsbase_util::_id_F3B6();
  scripts\sp\maps\marsbase\marsbase_util::_id_6F56("hill_intro_redshirt_floodspawn");
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_10685("hill_battle_left_spawn_closet_airlock_small", "flag_hill_c8s_destroyed", "flag_hill_combat_end");
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_10685("hill_battle_left_spawn_closet_airlock_large", "flag_hill_c8s_destroyed", "flag_hill_combat_end");
  scripts\sp\maps\marsbase\marsbase_util::_id_6F56("hill_intro_fill_floodspawn");
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_6E55("flag_hill_battle_lower_fallback", scripts\sp\maps\marsbase\marsbase_util::_id_6F57, ["hill_fill_floodspawn", undefined, 1]);
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_6E55("flag_hill_battle_lower_fallback", scripts\sp\maps\marsbase\marsbase_util::_id_6F56, ["hill_fill_floodspawn"]);
  level thread _id_3A80();
  scripts\sp\maps\marsbase\marsbase_code::_id_14EB("aa_gun_3");
  scripts\sp\maps\marsbase\marsbase_code::_id_14EB("aa_gun_4");
  level notify("loot_crate_aa1_cleanup");
  level notify("loot_crate_greenhouse_cleanup");
  level notify("loot_crate_aa2_cleanup");
  scripts\sp\maps\marsbase\marsbase_code::_id_C2AC("aa2_complete");
}

_id_B1F6() {
  scripts\engine\utility::flag_init("flag_hill_gate_back_c12_enter");
  scripts\engine\utility::flag_init("flag_hill_gate_aa_left_down");
  scripts\engine\utility::flag_init("flag_hill_gate_aa_right_down");
  scripts\engine\utility::flag_init("flag_hill_gate_final_aa_down");
  scripts\sp\maps\marsbase\marsbase_hill_gate::_id_16EA();
  level thread scripts\sp\maps\marsbase\marsbase_dialogue::_id_5457();
  level thread _id_8F2E();
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_6E55("flag_hill_c8_spawn", ::_id_8F37);
  scripts\engine\utility::flag_wait("flag_hill_c8_spawn");
  level._id_2705 = 1;
  scripts\sp\maps\marsbase\marsbase_util::_id_6F57("hill_fill_floodspawn", undefined, 1);
  scripts\sp\maps\marsbase\marsbase_util::_id_6F56("hill_c8_floodspawn");
  scripts\sp\utility::_id_2669("Hill C8");
  scripts\sp\maps\marsbase\marsbase_hill_gate::_id_F5F1();
  scripts\engine\utility::flag_wait("flag_hill_c8s_destroyed");
  var_0 = scripts\sp\maps\marsbase\marsbase_code::_id_77E5("hill_c8_bulding_group");
  scripts\engine\utility::array_call(var_0, ::_meth_81D0);
  scripts\sp\maps\marsbase\marsbase_util::_id_6F56("hill_gate_left_mid_robots_floodspawn");
  scripts\engine\utility::flag_set("flag_hill_combat_end");
  _id_8F1E();
  _id_8F31();
}

_id_5DB1() {
  self endon("death");
  wait 25;
  self delete();
}

_id_10C7D() {
  scripts\engine\utility::flag_init("flag_hill_battle_elevator_started");
  scripts\engine\utility::flag_init("flag_hill_c8s_destroyed");
  var_0 = ["salter", "ethan", "brooks", "mccallum", "griff"];
  scripts\sp\maps\marsbase\marsbase_util::_id_10626(var_0, "ally_start_hill_cargofall");
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("player_start_hill_cargofall", "targetname"));
  scripts\sp\maps\marsbase\marsbase_util::_id_F3B6();
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_127B1("hill_battle_lower_left_elevator_spawntrig", ::_id_8F21);
  scripts\sp\maps\marsbase\marsbase_util::_id_6F56("hill_intro_redshirt_floodspawn");
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_10685("hill_battle_left_spawn_closet_airlock_small", "flag_hill_c8s_destroyed", "flag_hill_combat_end");
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_10685("hill_battle_left_spawn_closet_airlock_large", "flag_hill_c8s_destroyed", "flag_hill_combat_end");
  level thread _id_107B8();
  scripts\sp\maps\marsbase\marsbase_util::_id_6F56("hill_fill_floodspawn");
  level thread _id_3A80();
  scripts\sp\maps\marsbase\marsbase_code::_id_14EB("aa_gun_3");
  scripts\sp\maps\marsbase\marsbase_code::_id_14EB("aa_gun_4");
  level notify("loot_crate_aa1_cleanup");
  level notify("loot_crate_greenhouse_cleanup");
  level notify("loot_crate_aa2_cleanup");
  scripts\sp\maps\marsbase\marsbase_code::_id_C2AC("aa2_complete");
}

_id_B1F7() {
  scripts\engine\utility::flag_wait("flag_hill_battle_dropped_container_started");
}

_id_3B71() {
  scripts\sp\maps\marsbase\marsbase_util::_id_7271("flag_hill_battle_dropped_container_started");
  scripts\sp\maps\marsbase\marsbase_util::_id_EA01(getEnt("hill_battle_lower_left_elevator_spawntrig", "targetname"));
}

_id_8F20() {
  var_0 = getEnt("elevator", "targetname");
  var_0.partnerheli = getEntArray("hill_battle_elevator_destructible", "script_noteworthy");
  var_0._id_DC2B = getEntArray("elevator_railing_large", "script_noteworthy");
  var_0._id_DC2C = getEntArray("elevator_railing_large", "targetname");
  var_1 = getEntArray("elevator_railing_small", "script_noteworthy");
  var_2 = getEntArray("elevator_railing_small", "targetname");

  foreach(var_4 in var_0.partnerheli)
  var_4 linkTo(var_0);

  foreach(var_8, var_7 in var_0._id_DC2B) {
    if(isDefined(var_0._id_DC2C[var_8]))
      var_0._id_DC2C[var_8] linkTo(var_7);
  }

  foreach(var_11, var_10 in var_1) {
    if(isDefined(var_2[var_11]))
      var_2[var_11] linkTo(var_10);
  }

  var_0.origin = var_0.origin + (0, 0, -256);

  foreach(var_7 in var_1)
  var_7.origin = var_7.origin + (0, 0, -40);
}

_id_8F21() {
  if(isDefined(level.hill_elevator_up)) {
    return;
  }
  level.hill_elevator_up = 1;
  var_0 = getEnt("elevator", "targetname");
  var_1 = getEntArray("elevator_railing_small", "script_noteworthy");
  wait 1;
  scripts\engine\utility::flag_set("flag_hill_battle_elevator_started");
  var_0 playSound("mars_cargo_lift_start");
  wait 0.88;
  var_0 playLoopSound("mars_cargo_lift_loop");
  var_0 movez(256, 3, 0.1, 0.1);

  foreach(var_3 in var_1)
  var_3 movez(40, 0.6, 0.2, 0.2);

  var_0 waittill("movedone");
  var_0 playSound("mars_cargo_lift_stop");
  var_0 stoploopsound();

  foreach(var_6 in var_0._id_DC2B)
  var_6 movez(-40, 0.6, 0.3, 0.1);

  scripts\sp\utility::_id_22D8(var_0._id_DC2B, "movedone");

  foreach(var_9, var_6 in var_0._id_DC2B) {
    if(isDefined(var_0._id_DC2C[var_9]))
      var_0._id_DC2C[var_9] connectpaths();
  }
}

_id_3B6F() {
  scripts\engine\utility::flag_init("flag_hill_battle_elevator_started");
  scripts\engine\utility::waitframe();
  var_0 = getEnt("elevator", "targetname");

  if(isDefined(var_0)) {
    var_0.origin = var_0.origin + (0, 0, 256);

    foreach(var_2 in var_0._id_DC2B)
    var_2.origin = var_2.origin + (0, 0, -40);

    foreach(var_5, var_2 in var_0._id_DC2B) {
      if(isDefined(var_0._id_DC2C[var_5]))
        var_0._id_DC2C[var_5] connectpaths();
    }
  }

  scripts\engine\utility::flag_set("flag_hill_battle_elevator_started");
}

_id_8F1F() {
  while(!scripts\engine\utility::flag_exist("flag_hill_battle_elevator_started"))
    wait 2;

  scripts\engine\utility::flag_wait("flag_hill_battle_elevator_started");
  var_0 = getEnt("elevator", "targetname");
  var_0.partnerheli = getEntArray("hill_battle_elevator_destructible", "script_noteworthy");
  var_0._id_DC2B = getEntArray("elevator_railing_large", "script_noteworthy");
  var_0._id_DC2C = getEntArray("elevator_railing_large", "targetname");
  var_1 = getEntArray("elevator_railing_small", "script_noteworthy");
  var_2 = getEntArray("elevator_railing_small", "targetname");
  scripts\sp\utility::_id_228A(var_0.partnerheli);
  scripts\sp\utility::_id_228A(var_0._id_DC2B);
  scripts\sp\utility::_id_228A(var_0._id_DC2C);
  scripts\sp\utility::_id_228A(var_1);
  scripts\sp\utility::_id_228A(var_2);
  scripts\sp\maps\marsbase\marsbase_util::_id_EA01(var_0);
}

_id_BA41() {
  self endon("death");
  thread _id_F037();
  _id_BA42();
}

_id_BA42() {
  self waittill("unloaded");
  self sethoverparams(54, 15, 7);
  level scripts\engine\utility::flag_wait("flag_hill_c8_spawn");
  self.mgturret[0] notify("stop_fire");
  var_0 = scripts\engine\utility::getStruct("hill_battle_monorail_dropship_exit_path", "targetname");
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  self setneargoalnotifydist(64);
  self setvehgoalpos(var_0.origin, 0);
  self waittill("near_goal");
  self setvehgoalpos(var_1.origin, 0);
  self waittill("near_goal");
  self delete();
}

_id_F037(var_0) {
  if(!isDefined(var_0))
    var_0 = "auto_nonai";

  self.health = 100000;
  scripts\sp\utility::_id_16B7(::_id_F03B);
  self.mgturret[0] setturretteam("axis");
  self.mgturret[0] setmode(var_0);
  self.mgturret[0] setleftarc(45);
  self.mgturret[0] setrightarc(45);
  self.mgturret[0] setbottomarc(500);
  self.mgturret[0] thread _id_5ECF();
}

_id_F03B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isPlayer(self.attacker))
    self.health = self.health + var_0;
}

_id_5ECF(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("stop_fire");
  self endon("death");
  var_5 = scripts\engine\utility::ter_op(isDefined(var_5), var_5, 0.15);
  var_7 = 0.6;
  var_8 = 1.2;

  if(isDefined(var_0)) {
    var_7 = var_0[0];
    var_8 = var_0[1];
  }

  for(;;) {
    wait(randomfloatrange(var_7, var_8));
    var_9 = randomintrange(8, 18);

    for(var_10 = 0; var_10 < var_9; var_10++) {
      self shootturret("tag_flash");
      wait(var_5);
    }
  }
}

_id_8F22() {
  var_0 = [];
  var_0["veh_spawner"] = "hill_battle_left_dropship";
  var_0["turret"] = "hill_battle_left_dropship_mg";
  var_0["light"] = "hill_battle_left_dropship_light";
  var_1 = [];
  var_1["n_deviate_x"] = 10;
  var_1["n_deviate_y"] = 10;
  var_1["stop_shooting_on_exit"] = 1;
  var_2 = [];
  var_2["start"] = "hill_battle_left_dropship_path";
  var_2["exit"] = "hill_battle_left_dropship_exit";
  var_2["func_shoot"] = ::_id_8F24;
  var_2["func_exit"] = ::_id_8F23;
  scripts\sp\maps\marsbase\marsbase_util::_id_2CDF(var_0, var_1, var_2);
}

_id_8F24(var_0) {
  scripts\sp\vehicle::_id_8441();
  wait 2.4;
  thread _id_0BBD::_id_5DB9("right");
  wait 1;
  thread _id_F037();
  self.turret thread scripts\sp\maps\marsbase\marsbase_util::_id_035A(var_0);
}

_id_8F23() {
  _id_145E();
  wait 3;
  self.turret notify("stop_fire");
  wait 1.5;
  thread _id_0BBD::_id_5DB7("right");
}

_id_145E() {
  self endon("unloaded");
  scripts\engine\utility::flag_wait("flag_hill_battle_dropped_container_started");
}

_id_8F37() {
  var_0 = scripts\sp\utility::_id_77DF("hill_c8_cannonfodder");
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_1747, ::_id_8F30);
  var_1 = [];
  var_2 = 0;
  var_3 = 4;

  foreach(var_6, var_5 in var_0) {
    var_1[var_6] = var_5 scripts\sp\utility::_id_10619();

    if(isalive(var_1[var_6]))
      var_2++;

    if(var_2 >= var_3) {
      break;
    }
  }

  _id_0B77::_id_A67F(206);
  var_1 = scripts\sp\utility::_id_22B9(var_1);
  wait 0.3;
  var_7 = getspawnerarray("hill_c8");
  var_8 = [];
  scripts\engine\utility::array_thread(var_7, scripts\sp\utility::_id_1747, ::_id_8FA0, var_1);

  foreach(var_6, var_5 in var_7) {
    var_8[var_6] = var_5 scripts\sp\utility::_id_10619(1);
    wait(randomfloatrange(0.2, 0.45));
  }

  var_8 _id_13741();
  scripts\engine\utility::flag_set("flag_hill_c8s_destroyed");

  if(!level.console)
    waitfortransient("marsbase_combat_elevator_tr");
}

_id_8F2E() {
  scripts\engine\utility::flag_wait("flag_hill_c8_spawn");
  scripts\sp\utility::_id_15F5("hill_battle_middle_colortrig");
  scripts\engine\utility::flag_wait("flag_hill_c8s_destroyed");
  var_0 = scripts\sp\maps\marsbase\marsbase_code::_id_77E5("hill_battle_left_building_top_group");
  scripts\engine\utility::array_call(var_0, ::_meth_81D0);
  scripts\sp\utility::_id_15F5("hill_c8_battle_colortrig");
}

_id_8F28(var_0) {
  var_1 = scripts\sp\utility::_id_79C7();

  if(isDefined(var_1) && (var_1 == "r" || var_1 == "y" || var_1 == "o") || (self.classname == "actor_enemy_sdf_rpg" || self.classname == "actor_enemy_sdf_sniper")) {
    return;
  }
  self _meth_82F1(level._id_8438[var_0]);
}

_id_13741() {
  var_0 = scripts\sp\utility::_id_22B9(self);

  while(var_0.size > 0) {
    scripts\sp\utility::_id_22D8(var_0, "death", 2);
    var_0 = scripts\sp\utility::_id_22B9(var_0);

    if(var_0.size < 1) {
      var_1 = getaiarray("axis");
      scripts\engine\utility::array_thread(var_1, ::_id_8F28, "hill_gate_goalvol");
      continue;
    }

    if(var_0.size < 2) {
      var_1 = getaiarray("axis");
      scripts\engine\utility::array_thread(var_1, ::_id_8F28, "hill_fill_goalvol");
      continue;
    }

    if(var_0.size < 3) {
      level notify("hill_c8_down");
      _id_0B77::_id_A67F(203);
    }
  }
}

_id_3B70() {
  _id_0B77::_id_A67F(203);
  _id_8F1E();
  _id_8F31();
  scripts\engine\utility::flag_set("flag_hill_combat_end");
  level thread _id_3B6F();
  scripts\sp\maps\marsbase\marsbase_util::_id_6F57("hill_intro_fill_floodspawn", undefined, 1);
  scripts\sp\maps\marsbase\marsbase_util::_id_6F57("hill_fill_floodspawn", undefined, 1);
}

_id_8F1E() {
  scripts\sp\maps\marsbase\marsbase_util::_id_6F57("hill_battle_left_lower_enemy_reinforce_floodspawn", undefined, 1);
  scripts\sp\maps\marsbase\marsbase_util::_id_6F57("hill_battle_right_lower_enemy_reinforce_floodspawn", undefined, 1);
  scripts\sp\maps\marsbase\marsbase_util::_id_6F57("hill_battle_left_lower_enemy_floodspawn", undefined, 1);
  var_0 = getEntArray("hill_battle_ents", "script_noteworthy");
  scripts\sp\utility::_id_228A(var_0);
  _id_0B77::_id_A67F(200);
  _id_0B77::_id_A67F(201);
  _id_0B77::_id_A67F(207);
}

_id_8F31() {
  scripts\sp\maps\marsbase\marsbase_util::_id_6F57("hill_c8_floodspawn", undefined, 1);
  scripts\sp\maps\marsbase\marsbase_util::_id_6F57("hill_intro_left_rooftop_floodspawn", undefined, 1);
  _id_0B77::_id_A67F(206);
  _id_0B77::_id_A67F(30);
  _id_0B77::_id_A67F(31);
  var_0 = getEnt("hill_battle_enemy_cleanup_vol", "targetname");
  var_1 = getaiarray("axis");
  var_2 = getspawnerarray();

  foreach(var_4 in var_2) {
    if(var_4 istouching(var_0)) {
      if(!isDefined(var_4.dontdeletemehacking) || !var_4.dontdeletemehacking)
        var_4 delete();
    }
  }

  foreach(var_7 in var_1) {
    if(var_7 istouching(var_0)) {
      if(!scripts\engine\utility::is_true(var_7.damageshield))
        var_7 _meth_81D0();
    }
  }

  var_0 delete();
  var_9 = getEntArray("hill_c8_ents", "script_noteworthy");
  scripts\sp\utility::_id_228A(var_9);
  scripts\sp\maps\marsbase\marsbase_util::_id_EA01(getEnt("hill_battle_lower_left_elevator_spawntrig", "targetname"));
  thread _id_8F21();
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_40AB();
}

_id_8FA0(var_0) {
  self._id_1FBB = "c8";
  var_1 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  wait(randomfloatrange(0.1, 0.3));
  var_1 scripts\sp\anim::_id_1F35(self, "c8_hill_intro");
  var_1 delete();
  scripts\sp\utility::_id_F3E0(64);
  thread _id_8F9F(var_0);
  self waittill("death");
}

_id_8F9F(var_0) {
  self endon("death");
  self._id_C3B1 = self._id_2894;
  scripts\sp\utility::_id_F2D8(10000);
  _id_0A04::_id_3454(0);
  scripts\sp\utility::_id_22D8(var_0, "death");
  scripts\sp\utility::_id_F2D8(5);
  scripts\sp\utility::_id_F3E0(96);
  self waittill("goal");
  _id_0A04::_id_3454(1);
  wait 5;
}

_id_8F2F() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(isai(var_1) && scripts\engine\utility::is_true(var_1.damageshield) && level.player scripts\sp\utility::_id_3849(self getEye())) {
      self dodamage(int(var_0 * 5), var_1.origin, var_1, var_1, "MOD_EXPLOSIVE");
      scripts\engine\utility::waitframe();
    }
  }
}

_id_8F30() {
  self endon("death");
  scripts\sp\utility::_id_F3E0(108);
  wait 1.6;
}

_id_8F26() {
  scripts\sp\maps\marsbase\marsbase_util::_id_6F56("hill_battle_left_lower_enemy_floodspawn");
  scripts\sp\maps\marsbase\marsbase_util::_id_6F56("hill_battle_left_lower_enemy_reinforce_floodspawn");
  scripts\engine\utility::flag_wait("flag_hill_battle_lower_left_push");
}

_id_8F27() {
  scripts\sp\maps\marsbase\marsbase_util::_id_6F56("hill_battle_right_lower_enemy_floodspawn");
  scripts\sp\maps\marsbase\marsbase_util::_id_6F56("hill_battle_right_lower_enemy_reinforce_floodspawn");
}

_id_8F25() {
  var_0 = getEnt("hill_battle_side_gate_left", "targetname");
  var_1 = getEnt("hill_battle_side_gate_left_spawntrig", "targetname");
  var_0 connectpaths();
  var_0 rotateYaw(90, 0.1);
  var_1 waittill("trigger");
  var_0 rotateYaw(-90, 1.5, 0.5, 0.5);
}

_id_CCFA(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_3.angles = (0, 0, 0);
  var_4 = getspawner("hill_battle_officer_vign_guy", "targetname");
  var_5 = var_4 scripts\sp\utility::_id_10619(1);
  var_5._id_1FBB = var_1;
  var_5 endon("death");
  var_5._id_10265 = 1;
  var_5.onlytakedamagefromplayer = 1;
  var_5 _meth_84AE();
  var_5 scripts\sp\utility::_id_F416(1);
  var_5 scripts\sp\utility::_id_F415(1);
  var_5 scripts\sp\utility::_id_16B7(scripts\sp\maps\marsbase\marsbase_util::_id_1916);
  var_3 scripts\sp\anim::_id_1F35(var_5, var_2);
  var_5._id_10265 = undefined;
  var_5.onlytakedamagefromplayer = 0;
  var_5 _meth_84AD();
  var_5 scripts\sp\utility::_id_F416(0);
  var_5 scripts\sp\utility::_id_F415(0);
  var_5 scripts\sp\utility::_id_DFE6(scripts\sp\maps\marsbase\marsbase_util::_id_1916);
}

_id_88EA() {
  level thread _id_107B8();
  scripts\engine\utility::flag_wait("flag_hill_battle_lower_fallback");
  _id_107B8();
}

_id_107B8() {
  if(!scripts\engine\utility::flag_exist("flag_ridge_reinforcements_spawning"))
    scripts\engine\utility::flag_init("flag_ridge_reinforcements_spawning");

  if(scripts\engine\utility::flag("flag_ridge_reinforcements_spawning"))
    scripts\engine\utility::flag_waitopen("flag_ridge_reinforcements_spawning");

  scripts\engine\utility::flag_set("flag_ridge_reinforcements_spawning");
  var_0 = sortbydistance(getEntArray("droppod_ridge", "script_noteworthy"), level.player.origin);

  for(var_1 = var_0.size - 1; var_1 > -1; var_1--)
    var_0[var_1] scripts\engine\utility::delaythread((var_0.size - var_1) * 0.6, ::_id_10795);

  wait 3;
  scripts\engine\utility::flag_clear("flag_ridge_reinforcements_spawning");
}

_id_10795() {
  var_0 = scripts\sp\utility::_id_10808();
  var_0 waittill("landed");
  var_0 delete();
}

_id_3A80() {
  thread _id_3A7F(_id_317E("cargo_train_a"), "cargotrain_rail_a");
  thread _id_3A7F(_id_317E("cargo_train_b"), "cargotrain_rail_b");
  thread _id_3A7F(_id_317E("cargo_train_c"), "cargotrain_rail_c");
  thread _id_3A7F(_id_317E("cargo_train_d"), "cargotrain_rail_d");
}

_id_3A7F(var_0, var_1) {
  var_0 endon("death");
  var_0 childthread _id_3A7E();
  wait(randomfloatrange(2, 7));
  var_0 playLoopSound("emt_train_rail");

  while(!scripts\engine\utility::flag("flag_hill_combat_end")) {
    var_2 = scripts\engine\utility::getStruct(var_1, "targetname");
    var_0 dontinterpolate();
    var_0.origin = var_2.origin;

    for(var_0.angles = (var_0.angles[0], var_2.angles[1], var_0.angles[2]); isDefined(var_2.target); var_2 = var_3) {
      var_3 = var_2 scripts\engine\utility::get_target_ent();
      var_4 = length(var_3.origin - var_2.origin) / 1000;
      var_5 = (var_0.angles[0], var_3.angles[1], var_0.angles[2]);
      var_0 moveTo(var_3.origin, var_4);
      var_0 rotateTo(var_5, var_4);
      wait(var_4);
    }

    wait(randomfloatrange(2, 10));
  }

  var_0._id_7441 delete();
  var_0._id_0056 delete();
  var_0 delete();
}

_id_3A7E() {
  for(;;) {
    earthquake(0.25, 0.05, self.origin, 600);
    wait 0.05;
  }
}

_id_317E(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0, "script_noteworthy");
  var_2 = scripts\engine\utility::spawn_tag_origin(var_1.origin + (0, 0, -32), var_1.angles);
  var_3 = undefined;
  var_4 = undefined;

  foreach(var_6 in getEntArray(var_0, "script_noteworthy")) {
    if(isDefined(var_6.script_parameters)) {
      switch (var_6.script_parameters) {
        case "front":
          var_3 = var_6;
          break;
        case "back":
          var_4 = var_6;
          break;
        default:
      }
    }
  }

  var_3 linkTo(var_2);
  var_4 linkTo(var_2);
  var_2._id_7441 = var_3;
  var_2._id_0056 = var_4;
  return var_2;
}
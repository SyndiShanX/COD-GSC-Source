/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\marsbase\marsbase_greenhouse.gsc
************************************************************/

_id_10C66() {
  var_0 = ["salter", "gator", "griff", "ethan"];
  var_1 = scripts\sp\maps\marsbase\marsbase_code::_id_77E6("group_ally_dropship2_engineers");
  scripts\sp\maps\marsbase\marsbase_util::_id_10626(scripts\engine\utility::array_combine(var_0, var_1), "ally_start_gh_approach");
  scripts\sp\maps\marsbase\marsbase_code::_id_426B("gate_base_intro_left", "gate_base_intro_right", 1, 0.1, undefined, "aa1");
  level notify("loot_crate_aa1_cleanup");
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("player_start_gh_approach", "targetname"));
  thread _id_A4EF();
  level scripts\engine\utility::delaythread(0.05, scripts\sp\maps\marsbase\marsbase_intro::_id_5E1C);
  scripts\sp\maps\marsbase\marsbase_code::_id_C2AC("aa1_complete");
}

_id_B1EB() {
  scripts\sp\utility::_id_2669("Greenhouse Approach");
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_DC75();
  level waittill("open_gate");
  thread _id_F046(0);
  thread scripts\sp\maps\marsbase\marsbase_dialogue::_id_5410();
  _id_856E(0);
  scripts\sp\utility::_id_15F5("orbit_a2");
  scripts\engine\utility::array_thread([level._id_6754, level._id_EA2C], scripts\sp\utility::_id_F3B5, "r");
  scripts\engine\utility::array_thread([level._id_8604, level._id_76FB], scripts\sp\utility::_id_F3B5, "y");
  scripts\engine\utility::waitframe();
  scripts\engine\utility::delaythread(1, scripts\sp\utility::_id_15F5, "trig_gha_allies_1");
  level waittill("gate_c8_dead");
  wait 1;
  level notify("greenhouse_approach_done");
}

_id_8551() {}

_id_A4EF() {
  var_0 = scripts\engine\utility::getStruct("engineers_gate", "targetname");
  var_0.angles = (0, 0, 0);
  var_1 = scripts\sp\maps\marsbase\marsbase_code::_id_77E5("group_ally_dropship2_engineers");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_1[var_2]._id_1FBB = "engineer" + (var_2 + 1);
    var_0 thread scripts\sp\anim::_id_1EEA(var_1[var_2], "engineer_gate_arrive_idle");
  }

  var_0 scripts\sp\maps\marsbase\marsbase_intro::_id_65CB(var_1);
}

_id_10C67() {
  var_0 = ["salter", "gator", "griff", "ethan"];
  var_1 = scripts\sp\maps\marsbase\marsbase_code::_id_77E6("group_ally_dropship2_engineers");
  scripts\sp\maps\marsbase\marsbase_util::_id_10626(scripts\engine\utility::array_combine(var_0, var_1), "ally_start_gh_approach");
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("player_start_gh_approach", "targetname"));
  thread _id_F046(1, 1);
  thread _id_A4F0();
  var_2 = getEnt("mdl_gate_c8_bustwall", "targetname");

  if(isDefined(var_2))
    var_2 delete();

  level thread scripts\sp\maps\marsbase\marsbase_util::_id_DC75();
  scripts\sp\utility::_id_15F5("orbit_a2");
  level scripts\engine\utility::delaythread(0.05, scripts\sp\maps\marsbase\marsbase_intro::_id_5E1C);
  scripts\sp\maps\marsbase\marsbase_code::_id_C2AC("aa1_complete");
}

_id_A4F0() {
  var_0 = 70;
  _id_76E1("open", "gate_base_intro_left", "gate_base_intro_right", var_0);
}

_id_76E1(var_0, var_1, var_2, var_3) {
  var_0 = tolower(var_0);
  var_4 = getEnt(var_1, "targetname");
  var_5 = getEnt(var_2, "targetname");
  var_6 = getEnt(var_1 + "_clip", "targetname");
  var_7 = getEnt(var_2 + "_clip", "targetname");

  if(isDefined(var_6) && !var_6 islinked())
    var_6 linkTo(var_4);

  if(isDefined(var_7) && !var_7 islinked())
    var_7 linkTo(var_5);

  if(!isDefined(var_3))
    var_3 = float(var_4._id_EE52);

  switch (var_0) {
    case "open":
      var_3 = var_3 * -1;
      break;
    case "closed":
      break;
    default:
  }

  var_8 = var_4.origin + (var_3, 0, 0);
  var_9 = var_5.origin + (var_3 * -1, 0, 0);
  var_4 moveTo(var_8, 0.05);
  var_5 moveTo(var_9, 0.05);
  var_4 waittill("movedone");
  var_6 disconnectPaths();
  var_7 disconnectPaths();
  var_4.script_parameters = var_0;
}

_id_B1EC() {
  scripts\sp\utility::_id_2669("Greenhouse Battle");
  thread _id_8AEA("burning_man_done");
  scripts\engine\utility::array_thread([level._id_6754, level._id_EA2C], scripts\sp\utility::_id_F3B5, "r");
  scripts\engine\utility::array_thread([level._id_8604, level._id_76FB], scripts\sp\utility::_id_F3B5, "y");
  var_0 = scripts\sp\maps\marsbase\marsbase_code::_id_77E5("group_ally_dropship2_engineers");
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_F3B5, "o");
  level._id_149F = var_0;
  thread scripts\sp\maps\marsbase\marsbase_util::_id_113D4("group_greenhouse_enemies_01", "greenhouse_enemies_01");
  thread scripts\sp\maps\marsbase\marsbase_util::_id_113D4("group_greenhouse_enemies_02", "greenhouse_enemies_02");
  thread scripts\sp\maps\marsbase\marsbase_util::_id_113D4("group_greenhouse_enemies_03", "greenhouse_enemies_03");
  thread scripts\sp\maps\marsbase\marsbase_util::_id_113D4("group_greenhouse_enemies_03_lower", "greenhouse_enemies_03_lower");
  thread scripts\sp\maps\marsbase\marsbase_util::_id_113D4("aigroup_greenhouse_cqb", "greenhouse_enemies_cqb");
  thread scripts\sp\maps\marsbase\marsbase_util::_id_113D4("aigroup_greenhouse_cqb", "greenhouse_enemies_cqb_right_path");
  thread scripts\sp\maps\marsbase\marsbase_util::_id_113D4("group_enemies_greenhouse_c8", "greenhouse_enemies_c8");
  thread scripts\sp\maps\marsbase\marsbase_util::_id_113D4("group_sdf_gate_support_1", "sdf_gate_support_1");
  thread _id_8573();
  thread _id_8574();
  scripts\engine\utility::waitframe();
  level thread scripts\sp\maps\marsbase\marsbase_dialogue::_id_53FD();
  thread scripts\sp\maps\marsbase\marsbase_caves::_id_856B();
  thread _id_8568();
  thread _id_8554();
  scripts\engine\utility::delaythread(1, scripts\sp\utility::_id_15F5, "trig_friendlies_move_up");
  scripts\engine\utility::delaythread(2.25, scripts\sp\utility::_id_15F5, "trig_first_droppod");
  _id_8572();
  _id_8556();
  scripts\sp\maps\marsbase\marsbase_intro::_id_5ED5();
  level scripts\engine\utility::flag_set("greenhouse_done");
  level notify("greenhouse_battle_done");
}

_id_8555() {
  level thread scripts\sp\maps\marsbase\marsbase_code::_id_426B("gate_base_intro_left", "gate_base_intro_right", 1, 0.1, 80, "aa1");
  level notify("loot_crate_aa1_cleanup");
  _id_855F();
  level thread scripts\sp\maps\marsbase\marsbase_intro::_id_515F(1);
}

_id_8572() {
  var_0 = scripts\sp\utility::_id_77DF("group_greenhouse_enemies_01");
  var_1 = scripts\sp\utility::_id_77DF("group_greenhouse_enemies_02");
  var_2 = scripts\sp\utility::_id_77DF("group_greenhouse_enemies_03");
  var_3 = scripts\sp\utility::_id_77DF("group_greenhouse_enemies_03_lower");
  var_4 = scripts\sp\utility::_id_77DF("group_enemies_greenhouse_c8");
  var_5 = scripts\sp\utility::_id_77DF("group_greenhouse_droppod_c6");
  var_6 = [var_0, var_1, var_2, var_3, var_4, var_5];
  var_7 = scripts\sp\maps\marsbase\marsbase_util::_id_2281(var_6);

  foreach(var_9 in var_7) {
    if(isspawner(var_9))
      var_9 scripts\sp\utility::_id_1747(::_id_8571, var_9.targetname);
  }
}

_id_8571(var_0) {
  self.targetname = var_0;
}

_id_8573() {
  var_0 = getEnt("trig_first_droppod", "targetname");
  var_0 waittill("trigger");
  thread scripts\sp\maps\marsbase\marsbase_code::_id_106B2("greenhouse_droppod_01", undefined, "aa1");
  level._id_6754 thread scripts\sp\utility::_id_10350("marsbase_eth_droppodscomingin");
}

_id_8574() {
  var_0 = getEnt("trig_second_droppod", "targetname");
  var_0 waittill("trigger");
  thread scripts\sp\maps\marsbase\marsbase_code::_id_106B2("greenhouse_droppod_02", undefined, "aa1");
  wait 2.0;
  thread scripts\sp\maps\marsbase\marsbase_code::_id_106B2("greenhouse_droppod_03", undefined, "aa1");
}

_id_855F() {
  _id_8566();
  _id_8560();
  var_0 = getEnt("trig_inside_greenhouse", "targetname");

  if(isDefined(var_0))
    var_0 delete();

  var_1 = getspawner("veh_base_dropship3", "targetname");

  if(isDefined(var_1))
    var_1 delete();

  var_2 = scripts\sp\utility::_id_77DF("group_greenhouse_enemies_01");
  var_3 = scripts\sp\utility::_id_77DF("group_greenhouse_enemies_02");
  var_4 = scripts\sp\utility::_id_77DF("group_greenhouse_enemies_03");
  var_5 = scripts\sp\utility::_id_77DF("group_greenhouse_enemies_03_lower");
  var_6 = getEntArray("spawner_droppod_cheap", "targetname");

  foreach(var_8 in var_2) {
    if(isDefined(var_8))
      var_8 delete();
  }

  foreach(var_8 in var_3) {
    if(isDefined(var_8))
      var_8 delete();
  }

  foreach(var_8 in var_4) {
    if(isDefined(var_8))
      var_8 delete();
  }

  foreach(var_8 in var_5) {
    if(isDefined(var_8))
      var_8 delete();
  }

  foreach(var_8 in var_6) {
    if(isDefined(var_8))
      var_8 delete();
  }
}

_id_8560() {
  var_0 = getEntArray("trig_greenhouse_spawn_enemies", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 delete();
}

_id_8561() {
  thread scripts\sp\utility::_id_4074("aa1");
  scripts\sp\maps\marsbase\marsbase_util::_id_5196("fxanim_tarps_area_02");
  scripts\sp\utility::_id_10FEC("vfx_exp_turret_one");
  scripts\sp\utility::_id_10FEC("vfx_exp_turret_two");
}

_id_8570() {
  level endon("greenhouse_enemies_cleared");
  level endon("greenhouse_battle_done");
  var_0 = 30;
  var_1 = 0.1;
  var_2 = getEnt("trig_right_path_auto_advance", "targetname");
  var_3 = getEnt("trig_player_right_path", "targetname");
  var_4 = 0;
  var_5 = 0;

  for(;;) {
    scripts\sp\utility::_id_127AE("trig_player_right_path", "targetname");
    var_6 = 0;

    while(isDefined(var_3) && level.player istouching(var_3) && !scripts\engine\utility::is_true(var_4)) {
      if(!scripts\engine\utility::is_true(var_5)) {
        var_5 = 1;
        level notify("greenhouse_cqb_right_path_stop");
      }

      wait(var_1);
      var_6++;

      if(var_6 * var_1 >= var_0) {
        scripts\engine\utility::flag_set("flag_right_path_lock");
        wait 1;
        scripts\sp\utility::_id_15F1("trig_right_path_advance_gator_and_griff", "targetname");
        var_4 = 1;
      }
    }

    wait(var_1);
  }
}

_id_856F() {
  var_0 = scripts\sp\maps\marsbase\marsbase_code::_id_77E5("group_ally_dropship2_engineers");
  level._id_149F = var_0;

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isalive(var_2)) {
      var_2.grenadeawareness = 0.9;
      var_2.allowdeath = 1;
      var_2 notify("magic_bullet_shield");
      var_2._id_B14F = 1;
      var_2.damageshield = 1;
    }
  }

  scripts\sp\utility::_id_127B3("trig_friendlies_move_up2");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isalive(var_2)) {
      var_2.grenadeawareness = 0;
      var_2.allowdeath = 0;
      var_2._id_B14F = undefined;
      var_2.damageshield = 0;
      var_2 notify("internal_stop_magic_bullet_shield");
      var_2.health = 500;
    }
  }
}

_id_854E() {
  var_0 = scripts\sp\utility::_id_77DA("group_greenhouse_enemies_01");
  var_1 = scripts\sp\utility::_id_77DA("group_greenhouse_enemies_02");
  var_2 = scripts\sp\utility::_id_77DA("group_greenhouse_enemies_03");
  var_3 = scripts\sp\utility::_id_77DA("group_enemies_greenhouse_c8");
}

_id_8566() {
  var_0 = getEntArray("trig_greenhouse_nav_allies", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 delete();
}

_id_8556() {
  level thread _id_856F();
  level thread _id_8570();
  level thread _id_664C();
  level thread _id_855C();
  thread _id_8557();
  scripts\engine\utility::delaythread(5, ::_id_8565);
  scripts\engine\utility::flag_wait("flag_gate_approach_end");
  wait 2;
  thread scripts\sp\maps\marsbase\marsbase_dialogue::_id_53FF();
  wait 1.0;
  scripts\sp\utility::_id_15F5("trig_enemies_go_to_exitdoor");
  level notify("enemies_going_to_exitdoor");
  _id_1C0F();
  _id_8563();
  _id_8566();
  wait 1;
  level notify("exitdoor_cleared");
  level notify("dropship_3_go");
  var_0 = getaiarray("axis");
  var_1 = getaiarray("allies");
  thread scripts\sp\maps\marsbase\marsbase_code::_id_A657(var_0, var_1);
  var_2 = 0;
  var_3 = 0;

  while(!(var_2 && var_3)) {
    level waittill("flag_obj_gh_infil_start", var_4);

    if(var_4 == level.player) {
      var_2 = 1;
      continue;
    }

    if(var_4 == level._id_6754)
      var_3 = 1;
  }
}

_id_8557() {
  var_0 = getEnt("bridge_upper_check", "targetname");
  var_1 = getEnt("bridge_upper_check_volume", "targetname");
  var_0 endon("exitdoor_cleared");
  var_0 waittill("trigger");
  var_2 = var_1 scripts\sp\utility::_id_77E3("axis");

  if(var_2.size > 4) {
    var_3 = var_2.size - 4;

    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_2[var_4] _meth_82EE(getnode("areanode_lower_01", "targetname"));
      var_2[var_4] scripts\sp\utility::_id_F3BC();
    }
  }
}

_id_1C0F() {
  var_0 = 8;
  var_1 = 3;
  var_2 = _id_46A8();

  while(!scripts\engine\utility::flag("greenhouse_done") && var_2 > var_0) {
    var_2 = _id_46A8();
    wait 0.25;
  }

  scripts\sp\utility::_id_15F5("trig_allies_penultimate");
  thread scripts\sp\maps\marsbase\marsbase_dialogue::_id_544A();
  scripts\engine\utility::flag_wait("flag_greenhouse_end_c8_dead");
  var_2 = _id_46A8();

  while(!scripts\engine\utility::flag("greenhouse_done") && var_2 > var_1) {
    var_2 = _id_46A8();
    wait 0.25;
  }

  thread _id_5D63();
  var_3 = getaiarray("axis");

  foreach(var_5 in var_3)
  var_5 thread _id_54C7();

  while(var_3.size > 0) {
    wait 0.1;

    foreach(var_5 in var_3) {
      if(!isDefined(var_5) || !isalive(var_5))
        var_3 = scripts\engine\utility::array_remove(var_3, var_5);
    }
  }

  scripts\engine\utility::array_thread([level._id_6754, level._id_EA2C], scripts\sp\utility::_id_F3B5, "r");
  scripts\engine\utility::array_thread([level._id_8604, level._id_76FB], scripts\sp\utility::_id_F3B5, "y");
  wait 1;
  level notify("greenhouse_enemies_cleared");
  wait 1;
  scripts\sp\utility::_id_15F5("trig_greenhouse_infil_allies_1");
  thread _id_76FE();
  thread salter_cheat_teleport();
  thread _id_675B();
}

_id_76FE() {
  level endon("exitdoor_opened");
  scripts\sp\utility::_id_127AE("trig_greenhouse_near_exitdoor", "targetname");
  var_0 = getEnt("trig_greenhouse_near_exitdoor", "targetname");
  var_1 = getnode("node_gator_cheat", "targetname");

  while(!level._id_76FB istouching(var_0)) {
    if(!level.player scripts\sp\maps\marsbase\marsbase_util::_id_9BDD(level._id_76FB, 0.5) && !level.player scripts\sp\maps\marsbase\marsbase_util::_id_9BDD(var_1)) {
      level._id_76FB scripts\sp\maps\marsbase\marsbase_util::_id_B399(var_1);
      break;
    }

    wait 0.1;
  }
}

salter_cheat_teleport() {
  level endon("exitdoor_opened");
  scripts\sp\utility::_id_127AE("trig_greenhouse_near_exitdoor", "targetname");
  var_0 = getEnt("trig_greenhouse_near_exitdoor", "targetname");
  var_1 = getnode("node_salter_cheat", "targetname");

  while(!level._id_EA2C istouching(var_0)) {
    if(!level.player scripts\sp\maps\marsbase\marsbase_util::_id_9BDD(level._id_EA2C, 0.5) && !level.player scripts\sp\maps\marsbase\marsbase_util::_id_9BDD(var_1)) {
      level._id_EA2C scripts\sp\maps\marsbase\marsbase_util::_id_B399(var_1);
      break;
    }

    wait 0.1;
  }
}

_id_675B() {
  level endon("exitdoor_opened");
  scripts\sp\utility::_id_127AE("trig_greenhouse_near_exitdoor", "targetname");
  var_0 = getEnt("trig_greenhouse_near_exitdoor", "targetname");
  var_1 = getnode("node_ethan_cheat", "targetname");

  while(!level._id_6754 istouching(var_0)) {
    if(!level.player scripts\sp\maps\marsbase\marsbase_util::_id_9BDD(level._id_6754, 0.5) && !level.player scripts\sp\maps\marsbase\marsbase_util::_id_9BDD(var_1)) {
      level._id_6754 scripts\sp\maps\marsbase\marsbase_util::_id_B399(var_1);
      break;
    }

    wait 0.1;
  }
}

_id_46A8() {
  var_0 = scripts\sp\utility::_id_77DA("group_greenhouse_enemies_01");
  var_1 = scripts\sp\utility::_id_77DA("group_greenhouse_enemies_02");
  var_2 = scripts\sp\utility::_id_77DA("group_greenhouse_enemies_03");
  var_3 = scripts\sp\utility::_id_77DA("group_greenhouse_enemies_03_lower");
  var_4 = scripts\sp\utility::_id_77DA("group_enemies_greenhouse_c8");
  var_5 = scripts\sp\utility::_id_77DA("group_greenhouse_droppod_c6");
  var_6 = var_0.size + var_1.size + var_2.size + var_3.size + var_4.size + var_5.size;
  return var_6;
}

_id_54C7() {
  self endon("death");

  while(isDefined(level.player._id_883D) && level.player._id_883D == "controllingrobot" || level.player scripts\sp\maps\marsbase\marsbase_util::_id_9BDD(self, 0.5) || scripts\engine\utility::is_true(self._id_B14F))
    wait 0.1;

  self _meth_81D0();
}

_id_664C() {
  scripts\sp\utility::_id_127B3("trig_entrance_doors_close");
  _id_426C();
  level notify("stop_ambient_jackals_intro");
  level thread scripts\sp\maps\marsbase\marsbase_intro::_id_515F();
  level thread scripts\sp\maps\marsbase\marsbase_intro::_id_4058();
  scripts\sp\maps\marsbase\marsbase_util::_id_5196("fxanim_tarps_area_01");
}

_id_426C() {
  var_0 = getEnt("trig_inside_greenhouse", "targetname");
  var_1 = 0;

  while(isDefined(var_0) && !scripts\engine\utility::is_true(var_1)) {
    var_1 = level.player istouching(var_0);
    var_1 = var_1 && level._id_6754 istouching(var_0);
    var_1 = var_1 && level._id_76FB istouching(var_0);
    var_1 = var_1 && level._id_8604 istouching(var_0);
    var_1 = var_1 && level._id_EA2C istouching(var_0);

    if(level._id_149F.size > 0) {
      foreach(var_3 in level._id_149F) {
        var_4 = isDefined(var_3) && isalive(var_3);

        if(scripts\engine\utility::is_true(var_4)) {
          var_5 = var_3 istouching(var_0);
          var_1 = var_1 && var_5;
          continue;
        }

        level._id_149F = scripts\engine\utility::array_remove(level._id_149F, var_3);
      }
    }

    wait 0.1;
  }

  scripts\sp\maps\marsbase\marsbase_code::_id_426B("gate_base_intro_left", "gate_base_intro_right", 0, 1, 80, "aa1");
  level notify("loot_crate_aa1_cleanup");
}

_id_106D4() {
  wait 2;
  var_0 = getnode("node_guard_stairs", "targetname");

  if(isDefined(var_0)) {
    var_1 = 0;

    for(var_2 = 50; !level.player scripts\sp\maps\marsbase\marsbase_util::_id_9BDD(var_0, 0.6) && var_1 < var_2; var_1++)
      wait 0.1;

    var_3 = getEnt("spawner_enemy_stairs", "targetname");

    if(!scripts\engine\utility::flag("greenhouse_cull_back_nodes") && isDefined(var_3))
      scripts\sp\maps\marsbase\marsbase_util::_id_10711("spawner_enemy_stairs");
  }
}

_id_855C() {
  createthreatbiasgroup("enemy_c8s");
  createthreatbiasgroup("player");
  level.player setthreatbiasgroup("player");
  var_0 = [];
  var_0[0] = getspawner("greenhouse_c8_left", "script_noteworthy");
  var_0[1] = getspawner("greenhouse_c8_right", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 scripts\sp\utility::_id_1747(::_id_855B);

  thread _id_34AE();
}

_id_855B() {
  thread _id_8553();
  self._id_5580 = 1;
  scripts\sp\utility::_id_F2D8(160);
  self setthreatbiasgroup("enemy_c8s");
  level.player setthreatbiasgroup("player");
  setthreatbias("enemy_c8s", "player", 500);
  var_0 = getnode(self.target, "targetname");
  scripts\sp\utility::_id_F3DD(64);
  scripts\sp\utility::_id_F3D9(var_0);
  self waittill("goal");
  scripts\sp\utility::_id_F3D5(self);
  wait 3;

  if(isDefined(self) && isalive(self)) {
    var_1 = "node_wander_" + self.script_noteworthy;
    var_2 = getnodearray(var_1, "targetname");
    thread scripts\sp\maps\marsbase\marsbase_util::_id_138D6(var_2, 5, 10, 3, 4);
  }
}

_id_8553() {
  self waittill("death");
  scripts\sp\utility::_id_2669("greenhouse_c8_killed");
}

_id_34AE() {
  var_0 = getnode("areanode_c8_right", "targetname");
  scripts\engine\utility::flag_wait("flag_right_c8_droppod_spawn");
  var_1 = getEnt("spawner_c8_right", "targetname");

  if(isDefined(var_1)) {
    var_2 = scripts\sp\maps\marsbase\marsbase_util::_id_5D45("spawner_c8_right", "targetname", "droppod_c8_right_path");
    var_2 thread _id_34AF();
    var_2 waittill("death");
  }

  scripts\engine\utility::flag_set("flag_greenhouse_end_c8_dead");
}

_id_34AF() {
  self endon("death");
  var_0 = [];
  var_0[0] = getEnt("trig_right_path_auto_advance", "targetname");
  var_0[1] = getEnt("trig_player_right_path", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      var_2 endon("death");
  }

  var_4 = "not_aggro";

  for(;;) {
    foreach(var_6 in var_0) {
      if(level.player istouching(var_6) && var_4 != "aggro") {
        var_4 = "aggro";
        scripts\sp\utility::_id_F2D8(800);
        continue;
      }

      var_4 = "not_aggro";
      scripts\sp\utility::_id_F2D8(160);
    }

    wait 0.5;
  }
}

_id_8565() {
  scripts\sp\maps\marsbase\marsbase_util::_id_6F56("s_trig_greenhouse_cqb", "targetname", ::_id_8564);
  var_0 = ["greenhouse_cqb_right_path_stop", "flag_right_c8_droppod_spawn"];
  level._id_E8E7 = spawnStruct();
  level._id_E8E7 thread _id_856C("s_trig_greenhouse_cqb_right_path", ::_id_8564, var_0, 1);
  thread scripts\sp\maps\marsbase\marsbase_util::_id_10685("airlock_greenhouse_right", "greenhouse_done", "greenhouse_done", undefined, "aa1");
  scripts\engine\utility::flag_wait("flag_right_c8_droppod_spawn");
  _id_8563();
}

_id_8564(var_0) {
  self.goalradius = 512;
  self setgoalentity(level.player);
  self.targetname = "enemy_greenhouse_cqb";
}

_id_8563() {
  scripts\sp\maps\marsbase\marsbase_util::_id_6F57("s_trig_greenhouse_cqb", "targetname", 1);
  scripts\sp\maps\marsbase\marsbase_util::_id_6F57("s_trig_greenhouse_cqb_right_path", "targetname", 1);
  var_0 = scripts\sp\maps\marsbase\marsbase_code::_id_77E5("aigroup_greenhouse_cqb");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isalive(var_2))
      var_2.health = 5;
  }
}

_id_856C(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_5 = getspawnerarray(var_4.target);

  foreach(var_7 in var_5)
  var_7 scripts\sp\utility::_id_1747(var_1, var_4.target);

  thread scripts\sp\maps\marsbase\marsbase_util::_id_6F56(var_0, "targetname");

  if(scripts\engine\utility::is_true(var_3))
    thread _id_856D(var_0);

  level scripts\engine\utility::waittill_any_in_array_return(var_2);
  scripts\sp\maps\marsbase\marsbase_util::_id_6F57(var_0, "targetname", 1);
}

_id_856D(var_0) {
  level endon("greenhouse_flood_spawn_stop");
  var_1 = var_0 + "_close";

  for(;;) {
    scripts\engine\utility::flag_wait(var_1);
    scripts\sp\maps\marsbase\marsbase_util::_id_6F57(var_0, "targetname", 0);

    while(scripts\engine\utility::flag(var_1))
      wait 0.5;

    scripts\sp\maps\marsbase\marsbase_util::_id_6F56(var_0, "targetname");
    wait 0.5;
  }
}

_id_8554() {
  scripts\engine\utility::flag_wait("greenhouse_cull_back_nodes");
  var_0 = getnodearray("back_node", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 _meth_80AC();

  var_4 = getspawnerarray();
  var_5 = [];

  foreach(var_7 in var_4) {
    if(isDefined(var_7.script_noteworthy) && var_7.script_noteworthy == "back_spawners")
      var_5 = scripts\engine\utility::array_add(var_5, var_7);
  }

  foreach(var_10 in var_5) {
    if(isDefined(var_10))
      var_10 delete();
  }

  var_12 = getnodearray("node_greenhouse_bridge_left", "script_noteworthy");

  foreach(var_14 in var_12)
  var_14 _meth_80AC();
}

_id_855E() {
  var_0 = getEntArray("spawner_droppod_cheap", "targetname");
  var_1 = 2.0;
  var_2 = 3.8;

  while(!scripts\engine\utility::flag("greenhouse_done")) {
    var_3 = randomfloatrange(var_1, var_2);
    wait(var_3);
    var_4 = undefined;
    var_5 = [];

    foreach(var_7 in var_0) {
      if(level.player scripts\sp\maps\marsbase\marsbase_util::_id_9BDD(var_7, 0.5, 1))
        var_5 = scripts\engine\utility::array_add(var_5, var_7);
    }

    if(var_5.size > 1)
      var_4 = var_5[randomint(var_5.size - 1)];
    else if(var_5.size == 1)
      var_4 = var_5[0];

    if(isDefined(var_4))
      var_4 thread _id_855D();
  }
}

_id_855D() {
  var_0 = scripts\sp\utility::_id_10808();
  var_0 waittill("landed");
  var_0 delete();
}

_id_856E(var_0) {
  var_1 = getEnt("gate_base_intro_left_clip", "targetname");
  var_2 = getEnt("gate_base_intro_right_clip", "targetname");

  if(scripts\engine\utility::is_true(var_0))
    var_3 = 0.1;
  else {
    var_0 = 0;
    var_3 = 3;
  }

  scripts\sp\maps\marsbase\marsbase_code::_id_C600("gate_base_intro_left", "gate_base_intro_right", var_0, var_3, 80, "aa1");
  var_1 disconnectPaths();
  var_2 disconnectPaths();
}

_id_8562() {}

_id_8550() {
  level endon("greenhouse_enemies_cleared");
  var_0 = 2;
  var_1 = 1;
  var_2 = 7;
  var_3 = ["veh_greenhouse_jackal_enemy", "veh_greenhouse_jackal_friendly"];
  var_4 = ["spl_greenhouse_aerials_1", "spl_greenhouse_aerials_2", "spl_greenhouse_aerials_3", "spl_greenhouse_aerials_4", "spl_greenhouse_aerials_5", "spl_greenhouse_aerials_6"];
  var_5 = 129;
  var_6 = 219;
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;

  for(;;) {
    for(var_10 = 0; var_10 < var_0; var_10++) {
      var_11 = scripts\engine\utility::array_randomize(var_3);
      var_12 = scripts\engine\utility::array_randomize(var_4);
      var_13 = var_11[0];
      var_14 = var_12[0];
      level thread _id_854F(var_13, var_14, var_5, var_6, var_7, var_8, var_9);
      wait(randomfloatrange(var_1, var_2));
    }
  }
}

_id_854F(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level endon("greenhouse_enemies_cleared");
  var_7 = randomfloatrange(var_2, var_3);
  var_8 = scripts\sp\vehicle::_id_1080C(var_0);
  var_8 endon("death");
  var_8 notsolid();
  var_8.targetname = var_0;
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_A1CA(var_8, var_1, var_7, 10);

  if(!scripts\engine\utility::is_true(var_4)) {
    if(randomint(10) > 2)
      var_8 thread _id_854D();
  }

  if(!scripts\engine\utility::is_true(var_5)) {
    if(randomint(10) < 2)
      var_8 thread _id_0BDC::_id_1991();
  }

  if(!scripts\engine\utility::is_true(var_6)) {
    if(randomint(10) < 4)
      var_8 thread _id_854C();
  }
}

_id_854B() {
  self endon("death");
  thread _id_0BDC::_id_1991();
}

_id_854C() {
  self endon("death");
  wait(randomfloatrange(0.5, 1.5));
  playFX(scripts\engine\utility::getfx("vfx_jackal_explode"), self.origin);
}

_id_854D() {
  level endon("greenhouse_enemies_cleared");
  self endon("death");
  var_0 = randomintrange(5, 9);
  var_1 = 0.25;
  var_2 = spawnStruct();

  for(var_3 = 0; var_3 < var_0; var_3++) {
    var_2.origin = self gettagorigin("tag_origin") + anglesToForward(self gettagangles("tag_origin")) * 100;
    thread _id_0B76::_id_1992("tag_origin", var_2, 1);
    wait(var_1);
  }
}

_id_F046(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStruct("engineers_gate_align", "targetname");
  var_4 = scripts\engine\utility::getStruct("slider", "targetname");
  var_5 = getEntArray("sdf_gate_support_1", "targetname");
  var_6 = [];

  if(!scripts\engine\utility::is_true(var_1))
    var_4 thread _id_76E4();

  if(!scripts\engine\utility::is_true(var_1))
    thread _id_76D4();
  else
    scripts\engine\utility::flag_set("gate_c8_destroyed");

  wait 0.5;
  thread scripts\sp\utility::_id_12641("marsbase_olympus_mons_guts_tr");
  var_7 = min(8, var_5.size);

  if(!isDefined(var_2)) {
    for(var_8 = 0; var_8 < var_7; var_8++) {
      var_9 = var_5[var_8];
      var_10 = var_9 scripts\sp\utility::_id_10619(1);
      var_6[var_8] = var_10;
      var_10._id_1FBB = "greenhouse_enemy" + (var_8 + 1);
      var_10 scripts\sp\utility::_id_F3DD(64);
    }
  }

  scripts\sp\maps\marsbase\marsbase_code::_id_A657(var_6, level._id_1684);
  scripts\engine\utility::flag_wait("gate_c8_destroyed");
  scripts\sp\utility::_id_15F5("trig_allies_gate_cover");
}

_id_76E4() {
  var_0 = getspawner("spawner_greenhouse_gate_enemy_slide_in", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_10619(1);

  if(isDefined(var_1) && isalive(var_1)) {
    var_1._id_1FBB = "generic";
    scripts\sp\anim::_id_1EC3(var_1, "greenhouse_gate_enemy_slide_in");

    if(isDefined(var_1) && isalive(var_1))
      scripts\sp\anim::_id_1F35(var_1, "greenhouse_gate_enemy_slide_in");
  }
}

_id_76E6(var_0) {
  scripts\sp\utility::_id_13753(var_0, var_0.size);
  scripts\engine\utility::flag_set("gate_engineers_dead");
}

_id_76D4() {
  wait 2.0;
  var_0 = getEnt("trig_at_greenhouse_gate", "targetname");
  var_1 = getEnt("spawner_gate_c8", "targetname");
  var_2 = 0;

  for(var_3 = 0; !(var_2 && var_3) && !scripts\engine\utility::flag("flag_c8_bypass"); var_3 = level.player scripts\sp\maps\marsbase\marsbase_util::_id_9BDD(var_1, 0.9)) {
    wait 0.1;
    var_2 = level.player istouching(var_0);
  }

  _id_76D7();
}

_id_76D7() {
  var_0 = getEnt("spawner_gate_c8", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_10619(1);
  var_1 scripts\sp\utility::_id_F2D8(70);

  if(isDefined(var_1)) {
    var_1._id_5580 = 1;
    var_1 scripts\sp\utility::_id_F415(1);
    var_1 scripts\sp\utility::_id_F3E0(16);
    var_1 _id_76D5();
    var_1 thread _id_76D8();
    var_2 = getaiarray("axis");

    foreach(var_4 in var_2) {
      if(isalive(var_4))
        var_4.grenadeammo = 0;
    }

    var_1 thread _id_76D9();
    var_1 thread _id_76DA();
    level scripts\engine\utility::waittill_any("gate_c8_dead", "gate_c8_bypassed");
    level notify("gate_c8_dead");
    scripts\engine\utility::flag_set("gate_c8_destroyed");
    var_6 = 0;

    foreach(var_4 in var_2) {
      if(isalive(var_4)) {
        if(var_6 == 0) {
          var_4.grenadeammo = 2;
          var_6++;
        } else
          var_6++;

        if(var_6 >= 3)
          var_6 = 0;
      }
    }
  }
}

_id_76D8() {
  self endon("death");
  var_0 = getnodearray("node_gate_c8", "targetname");
  thread scripts\sp\maps\marsbase\marsbase_util::_id_138D6(var_0, 5, 6, 2, 4);
  scripts\engine\utility::flag_wait("greenhouse_cull_back_nodes");
  self notify("stop_wandering");
  wait 0.1;
  var_1 = "node_wander_greenhouse_gate_c8";
  var_2 = getnodearray(var_1, "targetname");
  thread scripts\sp\maps\marsbase\marsbase_util::_id_138D6(var_2, 5, 10, 3, 4);
}

_id_76DA() {
  level endon("gate_c8_bypassed");
  self waittill("death");
  level notify("gate_c8_dead");
}

_id_76D9() {
  self endon("death");
  scripts\sp\utility::_id_127AE("trig_inside_greenhouse", "targetname");
  level notify("gate_c8_bypassed");

  if(isDefined(self) && isalive(self))
    scripts\sp\utility::_id_F2D8(500);
}

_id_76D5() {
  var_0 = "s_ref_gate_c8";
  var_1 = "greenhouse_c8_jumpdown_01";
  var_2 = "node_gate_c8";
  thread scripts\sp\maps\marsbase\marsbase_util::_id_341E(var_0, var_1, var_2);
  self waittill("c8_anim_jump_down_start");
  var_3 = scripts\engine\utility::getStruct("s_gate_c8_bustwall_fx", "targetname");
  self playSound("mars_base_c8_burst");
  var_4 = getEnt("mdl_gate_c8_bustwall", "targetname");

  if(isDefined(var_4))
    var_4 delete();

  var_5 = getEnt("fxanim_sp_mars_wall_explode_01", "targetname");

  if(isDefined(var_5)) {
    var_5 scripts\sp\utility::_id_23B7("fxanim_gate_c8_wall");
    var_5 thread scripts\sp\anim::_id_1F35(var_5, "explode", "tag_origin");
    scripts\sp\utility::_id_16AE(var_5, "aa1");
  }

  self waittill("c8_anim_jump_down_done");
  level notify("gate_c8_intro_done");
}

_id_62DD() {
  scripts\sp\utility::_id_127AE("trig_auto2163", "targetname");
  wait 3;
  var_0 = getspawnerarray("spawner_endsniper");
  createthreatbiasgroup("greenhouse_end_left_defender");

  foreach(var_2 in var_0) {
    var_3 = var_2 scripts\sp\utility::_id_10619(1);
    var_3.targetname = "greenhouse_endsniper";
    var_3 scripts\sp\utility::_id_F3E0(64);
    var_3 setthreatbiasgroup("greenhouse_end_left_defender");
    setthreatbias("greenhouse_end_left_defender", "player", 1000);
  }
}

_id_62DB() {
  var_0 = "s_ref_end_left_c8";
  var_1 = "greenhouse_c8_jumpdown_02";
  var_2 = "areanode_c8_area_l_upper";
  scripts\sp\utility::_id_127AE("trig_auto2163", "targetname");
  wait 3;
  var_3 = getEnt("end_left_c8", "targetname");
  var_4 = var_3 scripts\sp\utility::_id_10619(1);

  if(isDefined(var_4)) {
    var_4._id_5580 = 1;
    var_4 scripts\sp\utility::_id_F415(1);
    var_4 scripts\sp\utility::_id_F3E0(16);
    var_4._id_1FBB = "c8";
    var_4 _id_62DC(var_0, var_1, var_2);
    var_4 waittill("death");
    level notify("end_left_c8_dead");
  }
}

_id_62DC(var_0, var_1, var_2) {
  thread scripts\sp\maps\marsbase\marsbase_util::_id_341E(var_0, var_1, var_2);
  self waittill("c8_anim_jump_down_start");
  var_3 = scripts\engine\utility::getStruct("s_end_left_c8_bustwall_fx", "targetname");
  radiusdamage(var_3.origin, 128, 500, 250, self, "MOD_EXPLOSIVE");
  playFX(scripts\engine\utility::getfx("drop_pod_impact"), self.origin, anglestoup(self.angles), anglesToForward(self.angles));
  self waittill("c8_anim_jump_down_done");
  level notify("end_left_c8_intro_done");
}

_id_8568() {
  level thread _id_855E();
  level thread _id_62DD();
}

_id_F4AB(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = 60;

  if(!isDefined(var_1))
    var_1 = 0;

  scripts\sp\utility::_id_75C4("burning_arm_left", "j_shoulder_le");
  scripts\sp\utility::_id_75C4("burning_arm_right", "j_shoulder_ri");
  scripts\sp\utility::_id_75C4("burning_chest", "j_chest");
  scripts\sp\utility::_id_75C4("burning_legs", "j_hip_le");
  scripts\sp\utility::_id_75C4("burning_legs", "j_hip_ri");

  if(scripts\engine\utility::is_true(var_1))
    wait(var_0);
  else
    scripts\engine\utility::waittill_any_timeout(var_0, "death");

  if(isDefined(self)) {
    stopFXOnTag(scripts\engine\utility::getfx("burning_arm_left"), self, "j_shoulder_le");
    stopFXOnTag(scripts\engine\utility::getfx("burning_arm_right"), self, "j_shoulder_ri");
    stopFXOnTag(scripts\engine\utility::getfx("burning_chest"), self, "j_chest");
    stopFXOnTag(scripts\engine\utility::getfx("burning_legs"), self, "j_hip_le");
    stopFXOnTag(scripts\engine\utility::getfx("burning_legs"), self, "j_hip_ri");
  }
}

_id_5D63() {
  var_0 = _id_0BBF::_id_5DFE();
  var_0._id_10871 = "veh_base_dropship3";
  var_0._id_1325F = "dropship3_parts";
  var_0._id_1325C = "col_dropship3";
  level._id_5D63 = _id_0BBF::_id_106B8(undefined, undefined, undefined, undefined, undefined, var_0);
  level thread _id_5D6D();
  level._id_5D63 scripts\sp\utility::_id_23B7("dropship3");
  var_1 = scripts\engine\utility::getStruct("airship_crash", "targetname");
  var_1.angles = (0, 0, 0);
  var_1 thread scripts\sp\anim::_id_1F35(level._id_5D63, "flyin");
  level waittill("dropship3_open_door");
  level._id_5D63 playSound("mars_base_dropship_door_open");
  level._id_5D63 thread _id_0BBC::_id_C5F1("back");
  var_1 waittill("flyin");
  var_2 = scripts\sp\maps\marsbase\marsbase_code::_id_77E6("group_ally_dropship3_marines");
  var_3 = ["s_spawn_dropship3_marine1", "s_spawn_dropship3_marine1"];
  var_4 = ["node_dropship3_marine1", "node_dropship3_marine2"];
  var_5 = [];
  scripts\sp\maps\marsbase\marsbase_util::_id_1065E("s_spawn_dropship3_brooks");
  level._id_30F6 scripts\sp\utility::_id_F3B5("b");

  for(var_6 = 0; var_6 < var_3.size; var_6++) {
    var_7 = scripts\engine\utility::getStruct(var_3[var_6], "targetname");
    var_8 = var_2[var_6] scripts\sp\utility::_id_10619(1);
    var_8 _meth_80F1(var_7.origin, var_7.angles);
    var_5 = scripts\engine\utility::array_add(var_5, var_8);
    var_8.target = var_3[var_6];
  }

  level notify("dropship3_marines_spawned");
  var_1 thread scripts\sp\anim::_id_1EEA(level._id_5D63, "idle");
  wait 0.5;
  var_9 = [["node_dropship3_jump1_begin", "node_dropship3_jump1_end"], ["node_dropship3_jump2_begin", "node_dropship3_jump2_end"], ["node_dropship3_jump3_begin", "node_dropship3_jump3_end"]];
  level._id_5D63 scripts\sp\maps\marsbase\marsbase_code::_id_2879(var_9);
  level notify("dropship3_unload");
  level._id_30F6 scripts\sp\utility::_id_F3B5("b");
  wait 0.25;
  scripts\sp\utility::_id_15F5("trig_gha_dropship3_brooks_disembark");
  scripts\sp\utility::_id_15F5("trig_gha_dropship3_tactical");
  thread _id_5D68();
  _id_5D6A(var_5);
  var_5 = scripts\sp\maps\marsbase\marsbase_code::_id_77E5("group_ally_dropship3_marines");
  var_10 = getEnt("trig_dropship3_still_onboard", "targetname");

  foreach(var_12 in var_5) {
    if(isDefined(var_12) && isalive(var_12) && var_12 istouching(var_10))
      var_12 delete();
  }

  var_1 notify("stop_loop");
  level._id_5D63 _id_5D66(var_1);
}

_id_5D68() {
  level endon("dropship3_unload_done");

  for(;;) {
    wait 1;
    scripts\sp\utility::_id_15F5("trig_gha_dropship3_brooks_disembark");
    scripts\sp\utility::_id_15F5("trig_gha_dropship3_tactical");
  }
}

_id_5D6D() {
  if(isDefined(level._id_5D63)) {
    var_0 = spawn("script_origin", level._id_5D63.origin);
    var_1 = spawn("script_origin", level._id_5D63.origin);
    var_0 linkTo(level._id_5D63);
    var_1 linkTo(level._id_5D63);
    wait 0.1;
    var_0 playSound("mars_base_dropship3_flyin");
    var_0 playLoopSound("mars_base_dropship_2_main");
    level waittill("dropship3_hit_snd");
    var_0 playSound("mars_base_dropship3_explo");
    wait 0.5;
    var_1 playSound("mars_base_dropship3_fall");
    var_0 stoploopsound();
    wait 4.5;
    var_0 playSound("mars_base_dropship3_crash");
    wait 12;
    var_0 delete();
    var_1 delete();
  }
}

_id_5D6A(var_0) {
  level endon("dropship3_unload_abort");
  var_1 = getEnt("trig_dropship3_still_onboard", "targetname");
  var_2 = getEnt("trig_dropship3_unload", "targetname");
  var_3 = var_0;
  var_3[var_3.size] = level._id_30F6;

  while(var_3.size > 0) {
    foreach(var_5 in var_3) {
      if(!isDefined(var_5) || !isalive(var_5) || var_5 istouching(var_2)) {
        var_5 scripts\sp\utility::_id_F415(0);
        var_5 scripts\sp\utility::_id_F416(0);
        var_3 = scripts\engine\utility::array_remove(var_3, var_5);
      }
    }

    wait 0.1;
  }

  level notify("dropship3_unload_done");
}

_id_5D6B() {
  var_0 = getEnt("trig_dropship3_still_onboard", "targetname");
  wait 6;

  if(level._id_30F6 istouching(var_0))
    scripts\sp\utility::_id_15F5("trig_gha_dropship3_tactical");

  level notify("dropship3_unload_abort");
}

_id_5D66(var_0) {
  if(isDefined(self)) {
    var_1 = getEnt("spawner_burning_marine", "targetname");
    var_2 = var_1.origin;
    var_3 = scripts\engine\utility::getStruct("s_dropship3_targeted_rocket_start", "targetname");
    level notify("dropship3_hit");
    var_4 = var_3.origin;
    var_5 = scripts\engine\utility::getStruct("s_dropship3_targeted_rocket_end", "targetname").origin;
    var_6 = magicbullet("spaceship_forward_missile", var_4, var_5);
    var_6 thread _id_B802();
    level thread _id_5D67();
    var_6 waittill("death");
    playFX(level._effect["vfx_bombardment_strike_explosion"], var_2);
    earthquake(0.15, 0.5, var_2, 600);
    wait 0.05;
    playFX(level._effect["vfx_bombardment_strike_explosion"], self.origin);
    earthquake(0.15, 0.5, self.origin, 2000);
    thread _id_5D64();
    var_7 = scripts\engine\utility::getStruct("s_dropship3_crash_pos", "targetname");
    var_0 notify("stop_loop");
    level notify("dropship3_hit_snd");
    thread _id_5D65(1);
    level._id_5D63 scripts\sp\utility::_id_23B7("dropship3");
    var_0 thread scripts\sp\anim::_id_1F35(level._id_5D63, "dropship_crash");
    wait 5.35;
    level notify("dropship3_crash_snd");
    magicbullet("spaceship_forward_missile", level._id_5D63.origin, level._id_5D63.origin);
    playFX(level._effect["vfx_bombardment_strike_explosion"], level._id_5D63.origin);
    playFX(level._effect["vfx_pcr_lingering_smoke_rise"], level._id_5D63.origin);
    magicgrenade("frag", level._id_5D63.origin, level._id_5D63.origin, 0, 0);
    earthquake(0.15, 0.5, var_7.origin, 600);
    level._id_5D63 _id_0BBF::_id_F455();
    wait 1;
    var_8 = level._id_5D63.origin;
    var_9 = level._id_5D63.angles;
    playFX(level._effect["vfx_bombardment_strike_explosion"], level._id_5D63.origin);
    var_10 = scripts\sp\maps\marsbase\marsbase_util::_id_B3AA("dropship3_destroyed");
    var_10.origin = var_8;
    var_10.angles = var_9;
    wait 0.1;
    level._id_5D63 _id_5D69();
    level._id_5D63 delete();
    scripts\sp\utility::_id_16AE(var_10, "aa1");
  }
}

_id_5D69() {
  _id_0BBE::_id_A61F();
}

_id_5D65(var_0) {
  if(scripts\engine\utility::is_true(var_0))
    wait 4.5;

  var_1 = getEnt("fxanim_dropship_crash", "targetname");
  var_1 scripts\sp\utility::_id_23B7("dropship3_crash");
  var_1 thread scripts\sp\anim::_id_1F35(var_1, "impact");
  scripts\sp\utility::_id_16AE(var_1, "aa1");
}

_id_B802() {
  self playSound("mars_base_dropship3_missile");
}

_id_5D64() {
  var_0 = getEnt("spawner_burning_marine", "targetname");
  var_1 = scripts\engine\utility::getStruct("s_burning_marine_ejected_pos", "targetname");
  var_2 = scripts\sp\maps\marsbase\marsbase_util::_id_10711("spawner_burning_marine", "s_burning_marine_ejected_pos");
  var_3 = scripts\sp\maps\marsbase\marsbase_util::_id_10711("spawner_burning_marine_2", "s_burning_marine_ejected_pos_2");
  var_4 = scripts\engine\utility::getStruct("airship_crash", "targetname");
  var_2 thread _id_F4AB(30, 1);
  var_3 thread _id_F4AB(30, 1);
  var_5 = [];
  var_5[0] = "dropship3_burning_marine_01";
  var_5[1] = "dropship3_burning_marine_02";
  var_4 thread scripts\sp\anim::_id_1F35(var_2, var_5[0]);
  wait(randomfloatrange(0.05, 0.15));
  var_4 scripts\sp\anim::_id_1F35(var_3, var_5[1]);

  if(isDefined(var_2) && isalive(var_2))
    var_2 _meth_81D0();

  if(isDefined(var_3) && isalive(var_3))
    var_3 _meth_81D0();
}

_id_5D67() {
  wait 0.5;
  scripts\sp\maps\marsbase\marsbase_util::_id_A1CA("veh_enemy_jackal_greenhouse", "spl_enemy_jackal_strafe_dropship3_01", 190, 5);
}

_id_8AEA(var_0) {
  var_1 = getEntArray("fxanim_gp_wires_hanging_01", "targetname");
  var_2 = getEntArray("fxanim_gp_wires_hanging_02", "targetname");
  var_3 = getEntArray("fxanim_gp_wires_hanging_03", "targetname");
  var_4 = getEntArray("fxanim_gp_wire_sparking_xlong_thick", "targetname");
  var_5 = getEntArray("fxanim_gp_wire_sparking_ground_01", "targetname");

  foreach(var_7 in var_1) {
    var_7 thread _id_57D9("fxanim_wires_hanging_01", "wire_idle", var_0);
    wait(randomfloatrange(0.05, 0.38));
  }

  foreach(var_7 in var_2) {
    var_7 thread _id_57D9("fxanim_wires_hanging_01", "wire_idle", var_0);
    wait(randomfloatrange(0.05, 0.38));
  }

  foreach(var_7 in var_3) {
    var_7 thread _id_57D9("fxanim_wires_hanging_01", "wire_idle", var_0);
    wait(randomfloatrange(0.05, 0.38));
  }

  foreach(var_7 in var_4) {
    var_7 thread _id_57D9("fxanim_wires_sparking_xlong_thick", "wire_idle", var_0);
    wait(randomfloatrange(0.05, 0.38));
  }

  foreach(var_7 in var_5) {
    var_7 thread _id_57D9("fxanim_wires_sparking_ground_01", "wire_idle", var_0);
    wait(randomfloatrange(0.05, 0.38));
  }
}

_id_57D9(var_0, var_1, var_2) {
  scripts\sp\utility::_id_23B7(var_0);
  thread scripts\sp\anim::_id_1EEA(self, var_1);

  if(isDefined(var_2)) {
    level waittill(var_2);
    self _meth_83A1();
  }

  self delete();
}
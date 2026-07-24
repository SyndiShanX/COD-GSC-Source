/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\titan\titan_apc_canyon.gsc
******************************************************/

_id_206B(var_0) {
  var_1 = 1.0;

  if(var_0 == "canyon_begin") {
    var_2 = 0.8;
  } else if(var_0 == "canyon_movement") {
    var_2 = 0.8;
  } else {
    var_2 = 0.5;
  }
}

_id_206D() {
  thread _id_206B("");
  setsaveddvar("r_hudoutlineenable", 1);
  scripts\sp\maps\titan\titan_code::_id_BC52("apc_dropoff_player");
  scripts\sp\utility::_id_E81F("apc_dropoff_color_trigs", scripts\engine\utility::trigger_off);
  scripts\engine\utility::flag_set("dropships_inbound");
  var_0 = scripts\engine\utility::getStruct("omar_dropoff_tp", "targetname");
  var_1 = scripts\engine\utility::getStruct("atom_dropoff_tp", "targetname");
  var_2 = scripts\engine\utility::getStruct("marine_1_dropoff_tp", "targetname");
  var_3 = scripts\engine\utility::getStruct("marine_2_dropoff_tp", "targetname");
  scripts\sp\maps\titan\titan_code::_id_10733();
  level._id_C47F _meth_80F1(var_0.origin, var_0.angles);
  level._id_2429 _meth_80F1(var_1.origin, var_1.angles);
  level._id_B33B _meth_80F1(var_2.origin, var_2.angles);
  level._id_B33E _meth_80F1(var_3.origin, var_3.angles);
  setaudiotriggerstate("default", "nowind", 0);
  setaudiotriggerstate("titan_ext", "nowind", 0);
  setaudiotriggerstate("indoorrooms", "nowind", 0);
  scripts\engine\utility::array_thread(level._id_8E42, scripts\sp\utility::_id_54F7);
  thread scripts\sp\maps\titan\titan_code::_id_D250(2);
  scripts\engine\utility::exploder("fx_apc_drop_zone");
  scripts\engine\utility::exploder("fx_apc_zone_lensflare_on");
  scripts\engine\utility::exploder("fx_background_mist_1");
  thread _id_119B6("dropship1_nav", "dropship1_nav_block_on", "dropship1_nav_block_off");
  thread _id_119B6("dropship2_nav", "dropship2_nav_block_on", "dropship2_nav_block_off");
  thread _id_B965("dropship_coll", "dropship1_nav_block_on", "dropship1_nav_block_off");
  thread _id_B965("dropship2_coll", "dropship2_nav_block_on", "dropship2_nav_block_off");
  thread _id_119C2();
}

_id_206A() {
  thread _id_5D2F();
  thread _id_B987("player_ceiling");

  foreach(var_1 in level._id_10AC8) {
    var_1 scripts\sp\utility::_id_51E1("casual_gun");
  }

  scripts\engine\utility::array_thread(level._id_10AC8, scripts\sp\utility::_id_F3DD, 32);
  level._id_C47F scripts\sp\utility::_id_F3B5("purple");
  level._id_2429 scripts\sp\utility::_id_F3B5("orange");
  level._id_B33B scripts\sp\utility::_id_F3B5("cyan");
  level._id_B33E scripts\sp\utility::_id_F3B5("yellow");
  var_3 = scripts\engine\utility::getStruct("apc_drop_script_node", "targetname");
  thread _id_8740(level._id_C47F, "omar_dropoff_temp_node", 0);
  thread _id_8740(level._id_2429, "atom_dropoff_temp_node", 4.25);
  thread _id_8740(level._id_B33B, "brooks_dropoff_temp_node", 2);
  thread _id_8740(level._id_B33E, "kashima_dropoff_temp_node", 5.25);
  wait 6;
  thread _id_5E08(var_3, level._id_C47F, "apc_dropoff");
  thread _id_5E08(var_3, level._id_2429, "apc_dropoff");
  thread _id_5E08(var_3, level._id_B33B, "apc_dropoff");
  thread _id_5E08(var_3, level._id_B33E, "apc_dropoff");
  level._id_EF4E = _id_107C8();
  level._id_EF4E scripts\sp\utility::_id_65DD("dynamicThrusters");
  level._id_EF4E thread _id_D23F(2000, 0.35);
  level._id_EF4E thread _id_119B7("dropship1_rear_door_coll");
  level._id_EF4E castspotshadows(0);
  level._id_6AD8 = scripts\sp\utility::_id_10639("apc");
  level._id_6AD8 attach("veh_mil_lnd_un_apc_turret", "tag_turret");
  level._id_6AD8 thread scripts\sp\maps\titan\titan_apc_attack::_id_2098();
  var_4 = getEnt("friendly_c12_spawner", "targetname");
  scripts\sp\maps\titan\titan_apc_attack::_id_739D(var_4);
  scripts\sp\utility::_id_15F1("pre_gate_redshirt_color_trig", "targetname");
  level._id_EF4E thread _id_5DC0(var_3);
  level._id_739C thread _id_3549(var_3);
  level._id_6AD8 thread _id_2069(var_3);
  thread _id_106B0();
  thread _id_106AF();
  thread _id_B966("dropship_kill");
  thread _id_5D99(7.85, "dropship1_nav_block_on", 12, "dropship1_nav_block_off");
  thread _id_5D99(5, "dropship2_nav_block_on", 20.25, "dropship2_nav_block_off");
  wait 1;
  thread _id_354B();
  level waittill("walk_allies_up");
  scripts\engine\utility::flag_set("apc_dropship_landed");
  var_5 = getnode("omar_gate_goal", "targetname");
  var_6 = getnode("ethan_gate_goal", "targetname");
  var_7 = getnode("brooks_gate_goal", "targetname");
  var_8 = getnode("kash_gate_goal", "targetname");
  level._id_AB34 scripts\engine\utility::array_add(level._id_AB34, level._id_2068);
  var_3 thread scripts\sp\anim::_id_1F35(level._id_B33B, "apc_dropoff");
  level._id_B33B.fixednode = 0;
  level waittill("start_dropoff_guys");
  var_3 thread scripts\sp\anim::_id_1F35(level._id_B33E, "apc_dropoff");
  level._id_B33E.fixednode = 0;
  level waittill("start_dropoff_dropship");
  level._id_C24B scripts\sp\utility::_id_51E1("casual_gun");
  level._id_2068 scripts\sp\utility::_id_51E1("casual_gun");
  var_3 notify("stop_drop_idle");
  var_3 thread scripts\sp\anim::_id_1F35(level._id_2429, "apc_dropoff");
  level._id_2429.fixednode = 0;
  level._id_C47F _meth_82EE(var_5);
  level._id_2429 _meth_82EE(var_6);
  level._id_B33B _meth_82EE(var_7);
  level._id_B33E _meth_82EE(var_8);
  level._id_C47F.fixednode = 0;
  var_3 scripts\sp\anim::_id_1F35(level._id_C47F, "apc_dropoff");
  level notify("gate_prep");
  scripts\sp\utility::_id_15F1("gate_1_colors", "targetname");
  level._id_C47F scripts\sp\utility::_id_F3B5("purple");
  level._id_2429 scripts\sp\utility::_id_F3B5("orange");
  level._id_B33B scripts\sp\utility::_id_F3B5("cyan");
  level._id_B33E scripts\sp\utility::_id_F3B5("yellow");
  scripts\engine\utility::array_thread(level._id_10AC8, scripts\sp\utility::_id_61C7);
  scripts\sp\utility::_id_15F1("gate_1_colors_heroes", "targetname");
  var_3 scripts\sp\anim::_id_1F17(level._id_C47F, "apc_dropoff_2");
  level notify("move_apcs_up");
  var_3 scripts\sp\anim::_id_1F35(level._id_C47F, "apc_dropoff_2");
  level._id_C47F _meth_82EE(var_5);
  scripts\engine\utility::flag_wait("canyon_begin");
  thread _id_206B("canyon_begin");
  level._id_2068 scripts\sp\utility::_id_1101B();
  _id_3947();
}

_id_106AF() {
  var_0 = scripts\engine\utility::getStruct("apc_drop_script_node", "targetname");
  level waittill("start_LZ_dropship_guys");
  level._id_C24B = scripts\sp\utility::_id_107EA("nunez");
  level._id_C24B._id_1FBB = "nunez";
  level._id_C24B.name = "Nunez";
  level._id_C24B._id_134DB = scripts\sp\maps\titan\titan_code::_id_C24D;
  level._id_C24B._id_1C78 = 0;
  level._id_C24B scripts\sp\utility::_id_B14F(1);
  level._id_C24B._id_EDAD = "b";
  level._id_2068 = scripts\sp\utility::_id_107EA("dropoff_guy_2");
  level._id_2068._id_1FBB = "apc_drop_redshirt";
  level._id_2068.name = "Sopchak";
  level._id_2068._id_1C78 = 0;
  level._id_2068 scripts\sp\utility::_id_B14F(1);
  level._id_2068._id_EDAD = "r";
  var_1 = [level._id_C24B, level._id_2068];

  foreach(var_3 in var_1) {
    var_0 thread _id_5E07(var_3);
    var_3 scripts\sp\utility::_id_51E1("casual_gun");
  }
}

_id_5E07(var_0) {
  var_1 = spawnStruct();
  var_1.origin = self.origin;
  var_1.angles = self.angles;
  var_1 scripts\sp\anim::_id_1F35(var_0, "apc_dropoff");

  if(var_0._id_1FBB == "nunez") {
    var_0 scripts\sp\utility::_id_F3B5("blue");
  } else {
    var_0 scripts\sp\utility::_id_F3B5("red");
  }

  var_0 scripts\sp\utility::_id_51E1("casual_gun");
}

_id_5E08(var_0, var_1, var_2) {
  var_0 thread scripts\sp\anim::_id_1F0D(var_1, var_2);
}

_id_8740(var_0, var_1, var_2) {
  wait(var_2);
  var_3 = getnode(var_1, "targetname");
  var_0 _meth_82EE(var_3);
  var_0 waittill("goal");
  var_0 orientmode("face angle", var_3.angles[1]);
  var_0.fixednode = 1;
}

_id_D23F(var_0, var_1) {
  self endon("death");
  var_2 = 1500;

  for(;;) {
    var_3 = randomfloatrange(0.05, 0.15);
    var_4 = distance(self.origin, level.player.origin);
    var_5 = max(0, 1 - var_4 / var_0);

    if(var_4 < var_0) {
      earthquake(var_1 * var_5, var_3, self.origin, var_2);

      if(var_4 > var_0 / 2.5) {
        playrumbleonposition("c12_footstep_small", level.player.origin);
      } else {
        playrumbleonposition("c12_footstep_large", level.player.origin);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

_id_5D2F() {
  level.player scripts\sp\utility::_id_10350("titan_hqr_CopyActforcesinboundTA");
  level._id_B33E thread scripts\sp\maps\titan\titan_code::_id_1962("hold");
  level._id_B33E scripts\sp\utility::_id_10346("titan_ksh_tensecondstotouch");
  level._id_C47F thread scripts\sp\utility::_id_77B7("hold");
  level._id_C47F scripts\sp\utility::_id_10346("titan_usf_standclearofthebea");
  wait(randomfloatrange(1, 2));
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_brk_objectivenag2");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_eth_objectivenag8");
}

_id_5DC0(var_0) {
  var_0 scripts\sp\anim::_id_1F35(self, "apc_dropoff");
  var_0 scripts\sp\anim::_id_1EEA(self, "apc_dropoff_idle", "stop_drop_idle");
  level notify("apc_dropship_drop_complete");
  self notify("dropship_exit");
  var_0 scripts\sp\anim::_id_1F35(self, "apc_dropoff_exit");
  self delete();
  level notify("kill_exploit_monitor");
}

_id_354B() {
  var_0 = scripts\engine\utility::getStruct("apc_drop_script_node", "targetname");
  var_1 = getnode("hookup_goal", "targetname");
  var_2 = [level._id_AB34[0], level._id_C88E];
  level._id_AB34[0]._id_1FBB = "left_allies";
  var_0 scripts\sp\anim::_id_1F0D(level._id_AB34[0], "c12_unhook");
  scripts\engine\utility::flag_wait("c12_friendly_activate");
  var_0 scripts\sp\anim::_id_1F2C(var_2, "c12_unhook");
  level._id_AB34[0] notify("single_anim", "end");
  level._id_AB34[0] notify("stop_going_to_node");
  level._id_AB34[0] notify("new_anim_reach");
  level._id_AB34[0] scripts\sp\utility::_id_51E1("casual_gun");
  wait 1;
  level._id_AB34[0] scripts\sp\utility::_id_61C7();
  level._id_AB34[0] scripts\sp\utility::_id_F3B5("blue");
  var_2[0] _meth_82EE(var_1);
  level waittill("gate_prep");
  var_2[0] waittill("goal");
  var_2[0] scripts\sp\utility::_id_51E1("combat");
}

_id_3549(var_0) {
  var_1 = getEnt("gate_crash_c12_bad_place", "targetname");
  var_2 = getEnt("gate_crash_1_col", "targetname");
  var_3 = getEnt("gate_crash_1_gate", "targetname");
  var_3._id_1FBB = "second_gate";
  level._id_C88E = scripts\sp\utility::_id_10639("pallet");
  var_3 scripts\sp\utility::_id_23B7();
  var_1 notsolid();
  var_1 disconnectPaths();
  self hide();
  self setgoalpos(self.origin);
  self show();
  var_4 = [self, level._id_C88E];
  var_0 scripts\sp\anim::_id_1F2C(var_4, "apc_dropoff");
  level._id_C88F solid();
  var_0 scripts\sp\anim::_id_1EE0(self, "apc_dropoff");
  var_0 waittill("stop_drop_idle");
  scripts\engine\utility::flag_set("c12_friendly_activate");
  var_0 scripts\sp\anim::_id_1F35(self, "apc_dropoff_exit");
  scripts\sp\utility::_id_51E1("casual");
  wait 0.05;
  thread sfx_c12_palette_steps();
  var_5 = [self, var_3];
  var_3 scripts\sp\anim::_id_1F17(self, "apc_dropoff_gate");
  var_3 scripts\sp\anim::_id_1F2C(var_5, "apc_dropoff_gate");
  thread _id_10C7A(var_2);
  scripts\engine\utility::flag_set("canyon_begin");
  level notify("dropoff_gate_ripped");
  scripts\sp\utility::_id_51E1("combat");
  scripts\sp\utility::_id_61C7();
  scripts\sp\utility::_id_F3B5("g");
  var_3 notsolid();
  var_2 notsolid();
  wait 4.2;
  var_1 connectpaths();
  var_1 notsolid();
}

sfx_c12_palette_steps() {
  wait 0.4;
  self _meth_822B("c12_step_walk", "terrain", "dirt");
  wait 1.1;
  self _meth_822B("c12_step_walk", "terrain", "dirt");
}

#using_animtree("c12");

_id_10C7A(var_0) {
  scripts\engine\utility::flag_wait("canyon_begin");

  while(level._id_739C islegacyagent(%titan_first_gate_breakthrough_c12) <= 0.85) {
    wait 0.05;
  }

  foreach(var_2 in level._id_10AC8) {
    var_2 scripts\sp\utility::_id_F3B5("orange");
    var_2 scripts\sp\utility::_id_51E1("cqb");
  }

  var_0 connectpaths();
  scripts\sp\utility::_id_15F1("gate_1_destroyed_colors_00", "targetname");
  wait 1;
  scripts\sp\utility::_id_15F1("gate_1_destroyed_colors_01", "targetname");
  wait 4;
  scripts\sp\utility::_id_15F1("gate_1_destroyed_colors_02", "targetname");
}

_id_2069(var_0) {
  self hide();
  self show();
  var_0 scripts\sp\anim::_id_1F35(self, "apc_dropoff");
  level notify("swap_out_apcs");
  scripts\engine\utility::waitframe();
  thread _id_1130E();
  thread _id_1130F();
}

_id_1130E() {
  while(!isDefined(level._id_6AD7)) {
    wait 0.05;
  }

  while(!isDefined(level._id_6AD7._id_1FBD)) {
    wait 0.05;
  }

  level waittill("move_apcs_up");
  level._id_2050 = _id_10784();
  level._id_2050 scripts\sp\vehicle::_id_8441();
  level._id_2050._id_101AD = "right";
  level._id_2050 thread scripts\sp\maps\titan\titan_apc_attack::_id_2051();
  level._id_2050 thread scripts\sp\maps\titan\titan_apc_attack::_id_2457("apc1", 2.1);
  level._id_2050 setvehicleteam("allies");
}

_id_1130F() {
  level._id_2052 = _id_107C7();
  level._id_2052 setvehicleteam("allies");
  level._id_2052 scripts\sp\vehicle::_id_8441();
  level._id_2052 thread scripts\sp\maps\titan\titan_audio::_id_1194A();
  level waittill("move_apcs_up");
  level._id_2052._id_101AD = "left";
  level._id_2052 thread scripts\sp\maps\titan\titan_apc_attack::_id_2053();
  level._id_2052 thread scripts\sp\maps\titan\titan_apc_attack::_id_2457("apc2", 0.1);
}

_id_3947() {
  thread _id_206B("canyon_movement");
  thread _id_1161B();
  thread scripts\sp\maps\titan\titan_apc_attack::_id_956B();
  thread scripts\sp\maps\titan\titan_code::_id_D250(2);
  scripts\engine\utility::exploder("fx_background_mist_1");
  thread scripts\sp\maps\titan\titan_apc_attack::_id_3A99();
  level._id_C24B scripts\sp\utility::_id_51E1("cqb");
  level._id_2068 scripts\sp\utility::_id_51E1("cqb");
  scripts\engine\utility::flag_set("apc_gate_crash_1");
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0) {
    var_2 scripts\sp\utility::_id_51E1("sprint");
  }

  level._id_739C scripts\sp\utility::_id_51E1("sprint");
  scripts\sp\utility::_id_127AE("start_canyon_convo", "targetname");
  level.player scripts\sp\utility::_id_F526("relaxed");
  thread _id_3943();
  var_4 = ["titan_eth_beadvisedtherehave", "titan_brk_whatkindofincidents", "titan_eth_theyhaveatendency", "titan_ksh_holyshitthat", "titan_eth_no", "titan_plr_buttonitupethan", "titan_eth_yessir"];
  scripts\sp\maps\titan\titan_code::_id_48BD(var_4);
  wait 0.5;
  scripts\sp\maps\titan\titan_code::_id_C48A("titan_usf_scanyoursectorswere");
  thread _id_BE06();
  scripts\engine\utility::flag_wait("midway_through_canyon");
  scripts\engine\utility::exploder("refinery_reveal_clouds");
  scripts\engine\utility::exploder("refinery_clouds_top");
  level.player playSound("titan_canyon_quake_passby_lr");
}

_id_BE06() {
  setmusicstate("mx_194_canyon_overlook");
  wait 20;
  setmusicstate("");
}

_id_3943() {
  var_0 = getEnt("canyon_flyover_trig", "targetname");
  var_1 = getEnt("enemy_canyon_flyover_ds_00", "targetname");
  var_2 = getEnt("enemy_canyon_flyover_ds_01", "targetname");
  var_3 = getEnt("freighter_flyover", "targetname");
  var_4 = scripts\engine\utility::getStruct("enemy_canyon_flyover_node_00", "targetname");
  var_5 = scripts\engine\utility::getStruct("enemy_canyon_flyover_node_01", "targetname");
  var_6 = getvehiclenode("freighter_end", "targetname");
  var_7 = scripts\sp\utility::_id_8201("tower_dropships", "targetname");
  var_0 waittill("trigger");

  foreach(var_9 in var_7) {
    if(var_9.classname == "script_vehicle_dropship_enemy") {
      var_10 = var_9 scripts\sp\vehicle::_id_1080B();
      var_10 thread _id_40D7();
      continue;
    }

    var_10 = var_9 scripts\sp\utility::_id_10808();
    var_10 thread _id_3949();
    var_10 thread _id_40D7();
  }

  var_12 = var_3 scripts\sp\vehicle::_id_1080B();
}

_id_40D7() {
  scripts\engine\utility::flag_wait("c12_fight_transition");

  if(isDefined(self)) {
    self delete();
  }
}

_id_3949() {
  scripts\engine\utility::flag_wait("freighter_flyby");

  if(isDefined(self.target) && self.classname != "script_vehicle_dropship_enemy") {
    self startpath(getvehiclenode(self.target, "targetname"));
  }
}

_id_3942(var_0, var_1) {
  var_2 = var_0 scripts\sp\vehicle::_id_1080B();
  var_2._id_E7D0 = 0;
  var_2 scripts\sp\vehicle::_id_8441();
  var_1 waittill("trigger");
  var_2 delete();
}

_id_106B0() {
  level notify("unload_vehicles");
  level._id_B67D = [];
  thread scripts\sp\maps\titan\titan_apc_attack::_id_109B0();
  level._id_AB34 = scripts\sp\utility::_id_22CD("dropoff_friendlies_left");

  foreach(var_1 in level._id_AB34) {
    var_1 thread _id_B976("friendlies_sp");
    var_1 scripts\sp\utility::_id_F3B5("b");
  }

  var_3 = _id_B92B("apc_dropoff_anim_ent2", "dropship_infantry", undefined, undefined, "APC_left", level._id_EF4E);
  level._id_2056 = scripts\engine\utility::add_to_array(level._id_2056, level._id_2052);
  wait 1;
  level._id_E511 = scripts\sp\utility::_id_22CD("dropoff_friendlies_right");

  foreach(var_1 in level._id_E511) {
    var_1 thread _id_B976("friendlies_sp");
  }

  level._id_B67D = scripts\sp\utility::_id_22A2(level._id_E511, level._id_AB34);

  foreach(var_1 in level._id_B67D) {
    var_1._id_1C78 = 0;
    var_1 thread _id_116A0();
  }

  var_8 = _id_73AD("apc_dropoff_anim_ent", "dropship_infantry", level._id_E511, "scn_dropship_apc");
  level._id_E511 = scripts\sp\utility::_id_22A2(level._id_E511, var_8);

  foreach(var_10 in level._id_E511) {
    if(var_10.code_classname == "script_vehicle") {
      level._id_2050 = var_10;
      level._id_2056 = scripts\engine\utility::add_to_array(level._id_2056, level._id_2050);
      level._id_E511 = scripts\engine\utility::array_remove(level._id_E511, var_10);
    }

    var_10 scripts\sp\utility::_id_F3B5("r");
  }

  thread _id_9528("apc1_coll", level._id_6AD7);
  thread _id_9528("apc2_coll", level._id_6AD8);
  level waittill("dropoff_gate_ripped");
}

_id_9528(var_0, var_1) {
  var_2 = getEnt(var_0, "targetname");
  var_3 = var_1 scripts\engine\utility::spawn_tag_origin();
  var_2.origin = var_1.origin;
  var_2.angles = var_1.angles;
  var_2 linkTo(var_1, "tag_origin", (0, 0, 48), (0, 0, 0));
  thread _id_B966(var_0);
  level waittill("swap_out_apcs");
  var_2 delete();
}

_id_B966(var_0) {
  level endon("swap_out_apcs");
  var_1 = getEntArray(var_0, "targetname");
  level waittill("toggle_dropship_coll_on");

  for(;;) {
    foreach(var_3 in var_1) {
      if(level.player istouching(var_3)) {
        level.player dodamage(500, level.player.origin);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

_id_B965(var_0, var_1, var_2) {
  var_3 = getEntArray(var_0, "targetname");

  foreach(var_5 in var_3) {
    var_5 notsolid();
    var_5 connectpaths();
  }

  scripts\engine\utility::flag_wait(var_1);

  foreach(var_5 in var_3) {
    var_5 solid();
  }

  scripts\engine\utility::flag_wait(var_2);

  foreach(var_5 in var_3) {
    var_5 notsolid();
  }
}

_id_119B6(var_0, var_1, var_2) {
  var_3 = getEntArray(var_0, "targetname");

  foreach(var_5 in var_3) {
    var_5 notsolid();
    var_5 connectpaths();
  }

  scripts\engine\utility::flag_wait(var_1);
  level notify("toggle_dropship_coll_on");

  foreach(var_5 in var_3) {
    var_5 disconnectPaths();
  }

  scripts\engine\utility::flag_wait(var_2);
  level notify("toggle_dropships_coll_off");

  foreach(var_5 in var_3) {
    var_5 connectpaths();
  }
}

_id_5D99(var_0, var_1, var_2, var_3) {
  wait(var_0);
  scripts\engine\utility::flag_set(var_1);

  if(isDefined(var_2)) {
    wait(var_2);
    scripts\engine\utility::flag_set(var_3);
  }
}

_id_119C2() {
  level._id_C88F = getEnt("pallet_coll", "targetname");
  level._id_C88F notsolid();
  level._id_C88F connectpaths();
}

_id_119B7(var_0) {
  var_1 = getEnt(var_0, "targetname");
  var_1.origin = self gettagorigin("j_midbackdoor");
  var_1.angles = self gettagangles("j_midbackdoor");
  var_1.angles = var_1.angles + (-35, 0, 0);
  var_1 linkTo(self, "j_midbackdoor");
  self waittill("dropship_exit");
  var_1 delete();
}

_id_116A0() {
  scripts\sp\utility::_id_B14F();
  wait 30;
  scripts\sp\utility::_id_1101B();
}

_id_107C8() {
  var_0 = scripts\sp\vehicle::_id_1080C("dropship_spawner");
  var_0._id_1FBB = "dropship";
  return var_0;
}

_id_107C7(var_0) {
  if(isDefined(var_0)) {
    var_1 = scripts\sp\utility::_id_8201(var_0, "script_noteworthy");

    foreach(var_3 in var_1) {
      if(var_3.classname == "script_vehicle_apc_turret") {
        var_3.script_team = "allies";
        var_4 = var_3 scripts\sp\utility::_id_10808();
        var_4._id_1FBB = "apc";
        var_4 thread scripts\sp\maps\titan\titan_apc_attack::_id_2088(level._id_6AD8._id_129D4);
        return var_4;
      }
    }
  } else {
    var_4 = scripts\sp\vehicle::_id_1080C("apc_spawner");
    var_4._id_1FBB = "apc";
    var_4 thread scripts\sp\maps\titan\titan_apc_attack::_id_2088(level._id_6AD8._id_129D4);
    var_4 vehicle_teleport(level._id_6AD8.origin, level._id_6AD8.angles);
    level._id_6AD8 delete();
    return var_4;
  }
}

_id_10784(var_0) {
  if(isDefined(var_0)) {
    var_1 = scripts\sp\utility::_id_8201(var_0, "script_noteworthy");

    foreach(var_3 in var_1) {
      if(var_3.classname == "script_vehicle_apc_turret") {
        var_3.script_team = "allies";
        var_4 = var_3 scripts\sp\utility::_id_10808();
        var_4 thread scripts\sp\maps\titan\titan_apc_attack::_id_2088(level._id_6AD7._id_129D4);
        var_4 vehicle_teleport(level._id_6AD7.origin, level._id_6AD7.angles);
        level._id_6AD7 delete();
        return var_4;
      }
    }
  } else {
    var_4 = scripts\sp\vehicle::_id_1080C("apc_spawner");
    var_4 vehicle_teleport(level._id_6AD7.origin, level._id_6AD7.angles);
    var_4 thread scripts\sp\maps\titan\titan_apc_attack::_id_2088(level._id_6AD7._id_129D4);
    level._id_6AD7 delete();
    return var_4;
  }
}

_id_73AD(var_0, var_1, var_2, var_3, var_4) {
  if(isstring(var_0)) {
    var_0 = scripts\sp\maps\titan\titan_code::_id_7988(var_0);
  }

  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_5 = spawnStruct();
  var_5._id_1EB7 = var_0;
  var_6 = scripts\engine\utility::getStructArray("beacon_holo", "targetname");

  foreach(var_8 in var_6) {
    if(var_8.script_noteworthy == var_0.targetname) {
      var_5._id_9079 = var_8;
      break;
    }
  }

  var_5._id_9079 = scripts\engine\utility::getStruct(var_0.targetname, "script_noteworthy");
  var_5._id_1684 = [];
  var_5._id_5D6C = scripts\sp\vehicle::_id_1080C("dropship_spawner_2");
  var_5._id_5D6C._id_1FBB = "dropship";
  var_5._id_5D6C._id_1EB7 = var_5._id_1EB7;
  var_5._id_5D6C thread scripts\sp\maps\titan\titan_apc_attack::_id_5DB2();
  var_5._id_5D6C thread _id_119B7("dropship2_rear_door_coll");
  var_5._id_5D6C castspotshadows(0);

  if(isDefined(var_3)) {
    var_5._id_5D6C playSound(var_3);
  }

  var_5._id_2054 = scripts\sp\utility::_id_10639("apc");
  var_5._id_2054 attach("veh_mil_lnd_un_apc_turret", "tag_turret");
  level._id_6AD7 = var_5._id_2054;
  level._id_6AD7 thread scripts\sp\maps\titan\titan_apc_attack::_id_2098();
  var_5._id_1684 = scripts\engine\utility::add_to_array(var_5._id_1684, var_5._id_5D6C);
  var_5._id_1684 = scripts\engine\utility::add_to_array(var_5._id_1684, var_5._id_2054);

  if(isstring(var_1)) {
    var_10 = scripts\sp\maps\titan\titan_code::_id_7988(var_1);
  } else {
    var_10 = var_1;
  }

  foreach(var_13, var_12 in var_2) {
    var_12._id_1FBB = "dropship1_ally" + var_13;
    var_5._id_1684 = scripts\engine\utility::add_to_array(var_5._id_1684, var_12);
    wait 0.05;
  }

  foreach(var_15 in var_5._id_1684) {
    var_15._id_1EB7 = spawn("script_origin", var_0.origin);
    var_15._id_1EB7.angles = var_0.angles;
  }

  foreach(var_15 in var_5._id_1684) {
    var_15._id_1EB7 thread scripts\sp\anim::_id_1F35(var_15, "dropoff1");
  }

  level._id_6AD7._id_1FBD = var_5._id_2054._id_1EB7;

  foreach(var_15 in var_5._id_1684) {
    if(var_15 != level._id_6AD7) {
      var_15._id_1EB7 scripts\engine\utility::delaycall(10, ::delete);
    }
  }

  var_5._id_5D6C thread scripts\sp\utility::_id_C12D("dropship_exit", 15);
  var_5._id_1684 = scripts\engine\utility::array_remove(var_5._id_1684, var_5._id_5D6C);
  return var_5._id_1684;
}

_id_B92B(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isstring(var_0)) {
    var_0 = scripts\sp\maps\titan\titan_code::_id_7988(var_0);
  }

  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_6 = spawnStruct();
  var_6._id_1EB7 = var_0;
  var_6._id_9079 = scripts\engine\utility::getStruct(var_0.targetname, "script_noteworthy");
  var_6._id_1684 = [];

  if(isDefined(var_3)) {
    var_5 playSound(var_3);
  }

  if(isstring(var_1)) {
    var_7 = scripts\sp\maps\titan\titan_code::_id_7988(var_1);
  } else {
    var_7 = var_1;
  }

  foreach(var_9 in var_6._id_1684) {
    var_9._id_1EB7 = spawn("script_origin", var_0.origin);
    var_9._id_1EB7.angles = var_0.angles;
  }

  var_5._id_1EB7 = var_6._id_1EB7;

  foreach(var_9 in var_6._id_1684) {
    var_9._id_1EB7 thread scripts\sp\anim::_id_1F35(var_9, "dropoff1");
  }

  foreach(var_9 in var_6._id_1684) {
    var_9._id_1EB7 scripts\engine\utility::delaycall(10, ::delete);
  }

  return var_6._id_1684;
}

_id_B976(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    if(!scripts\engine\utility::within_fov(level.player getEye(), level.player.angles, var_3.origin, 0.422618)) {
      self _meth_80F1(var_3.origin, var_3.angles);
    }
  }
}

_id_B987(var_0) {
  level endon("kill_exploit_monitor");
  var_1 = getEnt(var_0, "targetname");

  for(;;) {
    var_1 waittill("trigger", var_2);

    if(isDefined(level.player) && level.player istouching(var_1)) {
      level.player dodamage(100, level.player.origin);
    }

    scripts\engine\utility::waitframe();
  }
}

_id_1161B() {
  thread _id_B9A6("canyon_tp_1");
  thread _id_B9A6("canyon_tp_2");
  thread _id_B9A6("canyon_tp_3");
  thread _id_B9A6("canyon_tp_4");
  thread _id_B9A6("canyon_tp_5");
  thread _id_B9A6("canyon_tp_6");
}

_id_B9A6(var_0) {
  level endon("toggle_c12_teleportation");
  var_1 = getnode(var_0, "targetname");
  var_2 = getEnt(var_0, "targetname");

  for(;;) {
    var_2 waittill("trigger", var_3);

    if((var_3 == level._id_739C || var_3 == level.player) && !scripts\engine\utility::flag(var_0)) {
      break;
    } else
      continue;
  }

  if(_id_3801(var_1)) {
    var_4 = level._id_739C.goalpos;
    level._id_739C _meth_80F1(var_1.origin, var_1.angles);
    scripts\engine\utility::waitframe();
    level._id_739C setgoalpos(var_4);
  }

  var_2 scripts\engine\utility::trigger_off();
  scripts\engine\utility::flag_set(var_0);
}

_id_3801(var_0) {
  if(!scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_0.origin, 0.422618)) {
    if(!scripts\engine\utility::within_fov(level.player.origin, level.player.angles, level._id_739C.origin, 0.422618)) {
      return 1;
    }
  }

  return 0;
}
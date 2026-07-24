/**************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\marsbase\marsbase_elevator_igc.gsc
**************************************************************/

_id_10C30() {
  var_0 = ["salter", "ethan", "brooks", "mccallum", "griff"];
  scripts\sp\maps\marsbase\marsbase_util::_id_10626(var_0, "ally_start_elevator_door", 1);
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("player_start_elevator_door", "targetname"));
  scripts\sp\maps\marsbase\marsbase_elevator::_id_608C("elevator_sunfake_off");
  scripts\sp\maps\marsbase\marsbase_code::_id_DFB4("aa_gun_3");
  scripts\sp\maps\marsbase\marsbase_code::_id_DFB4("aa_gun_4");
  level thread scripts\sp\maps\marsbase\marsbase_elevator_retreat::_id_3B5C();
  scripts\sp\maps\marsbase\marsbase_code::_id_C2AC("aa3_complete");
}

_id_B1CE() {
  scripts\sp\utility::_id_2669("Elevator Door");
  level thread scripts\sp\maps\marsbase\marsbase_dialogue::_id_5419();
  scripts\sp\maps\marsbase\marsbase_util::_id_F338();
  _id_CCF4();
  level notify("loot_crate_gate_cleanup");
  level.player scripts\sp\maps\marsbase\marsbase_util::_id_F475();
  level thread scripts\sp\maps\marsbase\marsbase_burning_man::delete_door();
  level thread scripts\sp\maps\marsbase\marsbase_hill_battle::_id_8F1F();
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_10682("hill_battle_left_spawn_closet_airlock_small");
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_10682("hill_battle_left_spawn_closet_airlock_large");
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_10682("hill_battle_right_spawn_closet_airlock_small_01");
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_10682("hill_battle_right_spawn_closet_airlock_large_01");
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_10682("hill_gate_right_spawn_closet_airlock_small");
}

_id_6085() {
  level thread _id_3B5F();
  level.player scripts\sp\maps\marsbase\marsbase_util::_id_F475();
  scripts\sp\maps\marsbase\marsbase_burning_man::delete_door();
  level thread scripts\sp\maps\marsbase\marsbase_hill_battle::_id_8F1F();
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_10682("hill_battle_left_spawn_closet_airlock_small");
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_10682("hill_battle_left_spawn_closet_airlock_large");
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_10682("hill_battle_right_spawn_closet_airlock_small_01");
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_10682("hill_battle_right_spawn_closet_airlock_large_01");
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_10682("hill_gate_right_spawn_closet_airlock_small");
}

_id_CCF4() {
  thread _id_8606();
  thread _id_30FD();
  var_0 = scripts\engine\utility::getStruct("tag_align_elevator_final_gate", "script_noteworthy");
  var_1 = scripts\engine\utility::getStruct("elevator_final_gate_interact", "script_noteworthy");
  var_2 = var_1 scripts\engine\utility::spawn_tag_origin();
  thread _id_60AE(var_2);
  var_2 _id_0E46::_id_48C4("tag_origin", (0, 0, 0), &"SCRIPT_DOORPEEK_OPEN", 0.5, 10000);
  var_2 waittill("trigger");
  level.player scripts\engine\utility::delaycall(1.75, ::playsound, "mars_elevator_gate_start");
  level.player scripts\engine\utility::delaycall(2.4, ::playsound, "mars_elevator_gate_end");
  scripts\sp\maps\marsbase\marsbase_code::_id_C2AC("gain_access_complete");
  level thread scripts\sp\utility::_id_13C3C();
  level notify("elevator_igc_started");
  setmusicstate("");
  var_2 delete();
  level thread _id_88CC();
  level.player._id_E505 = scripts\sp\utility::_id_10639("player_rig");
  level.player._id_E505 hide();
  var_0 scripts\sp\anim::_id_1EC3(level.player._id_E505, "elevator_gate_enter");
  scripts\engine\utility::waitframe();
  level.player disableweapons();
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player _meth_823C(level.player._id_E505, "tag_player", 0.5);
  wait 0.5;
  level.player._id_E505 show();
  var_3 = getEntArray("elevator_final_gate", "targetname");
  var_4 = undefined;

  foreach(var_6 in var_3) {
    if(var_6.classname == "script_model") {
      var_4 = var_6;
    }
  }

  var_8 = scripts\sp\utility::_id_10639("elevator_mag", (0, 0, 0), (0, 0, 0));
  var_9 = scripts\sp\utility::_id_10639("engineer_gate_open_torch", (0, 0, 0), (0, 0, 0));
  var_8 scripts\sp\utility::_id_23B7("elevator_mag");
  var_9 scripts\sp\utility::_id_23B7("elevator_torch");
  var_4 scripts\sp\utility::_id_23B7("elevator_gate");
  level._id_2BFF = scripts\sp\maps\marsbase\marsbase_util::_id_10652();
  level._id_A6F4 = scripts\sp\maps\marsbase\marsbase_util::_id_10750();
  var_10 = _id_106BC("elevator_igc_flight_deck_director", ::_id_604D);
  var_11 = _id_106BC("elevator_igc_crew_ship_fem", ::_id_604D);
  var_12 = _id_106BC("elevator_igc_crew_ship_mal", ::_id_604D);
  var_10._id_1FBB = "elevator_fscm";
  var_11._id_1FBB = "elevator_mscm";
  var_12._id_1FBB = "elevator_mfcm";
  var_13 = getspawnerarray("elevator_igc_engineer");
  var_14 = [];

  foreach(var_17, var_16 in var_13) {
    var_14[var_17] = var_16 scripts\sp\utility::_id_10619(1);
    var_14[var_17] scripts\sp\utility::_id_5131();
    var_14[var_17]._id_1FBB = "elevator_igc_engineer_" + var_17;
  }

  var_18 = [level._id_EA2C, level._id_B4F1, level._id_6754, level._id_2BFF, level._id_A6F4, var_10, var_11, var_12];
  var_19 = [var_10, var_11, var_12, level._id_2BFF, level._id_A6F4];
  var_20 = [level._id_8604, var_14[0], var_14[1], var_14[2]];
  level._id_76E5 = [var_14[0], var_14[1], var_14[2]];
  var_0 thread _id_CD23(var_18, var_19);
  var_0 thread _id_CD32(var_20, level._id_76E5);
  var_9 thread _id_76EF();
  var_0 thread scripts\sp\anim::_id_1F2C([var_8, var_9], "elevator_gate_enter");
  var_0 thread scripts\sp\anim::_id_1F2C([var_4], "elevator_gate_enter");
  var_4 thread _id_E7C1();
  var_0 thread _id_CDCB();
  thread _id_60DA();
  var_0 scripts\sp\anim::_id_1F2C([level._id_30F6], "elevator_gate_enter");
  scripts\sp\maps\marsbase\marsbase_elevator::_id_60D4();
  level waittill("elevator_gate_scene_done");
  level.player _meth_82C0("marsbase_elevator_section", 1.0);
  var_8 delete();
}

_id_60AE(var_0) {
  level endon("elevator_igc_started");

  while(distance2d(level.player.origin, var_0.origin) > 1024) {
    wait 0.25;
  }

  wait 10.0;
  level._id_B4F1 scripts\sp\utility::_id_10350("marsbase_mac_letsgetthegate");
}

_id_C1AD(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_2 delete();
    }
  }
}

_id_60DA() {
  var_0 = [getEnt("vehicle_endgate_atv_1", "noteworthy"), getEnt("vehicle_endgate_atv_2", "noteworthy"), getEnt("vehicle_hill_intro_atv", "noteworthy")];
  _id_C1AD(var_0);
  _id_C1AD(getEntArray("script_vehicle_dropship_player", "classname"));
  _id_C1AD(getEntArray("script_vehicle_dropship_player_plane", "classname"));
  _id_C1AD(getEntArray("script_vehicle_dropship_friendly", "classname"));
  _id_C1AD(getEntArray("script_vehicle_dropship_friendly_plane", "classname"));
  _id_C1AD(getEntArray("script_vehicle_dropship_enemy", "classname"));
  _id_C1AD(getEntArray("script_vehicle_dropship_enemy_plane", "classname"));
  _id_C1AD(getEntArray("script_vehicle_atv", "classname"));
  _id_C1AD(getEntArray("script_vehicle_jackal_friendly", "classname"));
  _id_C1AD(getEntArray("script_vehicle_jackal_fake_friendly", "classname"));
  _id_C1AD(getEntArray("script_vehicle_jackal_enemy", "classname"));
  _id_C1AD(getEntArray("script_vehicle_jackal_fake_enemy", "classname"));
  wait 1.0;
  thread scripts\sp\utility::_id_12651(["marsbase_tunnel_airlock_tr", "marsbase_dropship_hero_tr", "marsbase_prime_tr", "marsbase_combat_meatgrinder_tr", "marsbase_combat_to_grinder_tr", "marsbase_vista_train_station_tr"]);
  wait 0.5;
  thread scripts\sp\utility::_id_BF97();
  thread scripts\sp\utility::_id_BF98();
}

_id_106BC(var_0, var_1) {
  var_2 = getspawner(var_0, "targetname");

  if(isDefined(var_1)) {
    var_2 scripts\sp\utility::_id_1747(var_1);
  }

  return var_2 scripts\sp\utility::_id_10619(1);
}

_id_604D() {
  scripts\sp\utility::_id_72EC("iw7_m4", "primary");
}

_id_76EF() {
  level waittill("torch_off");
  wait 5;
  self delete();
}

_id_3B5F() {
  var_0 = getspawnerarray("elevator_igc_engineer");
  level._id_76E5 = [];

  for(var_1 = 0; var_1 < 3; var_1++) {
    level._id_76E5[var_1] = var_0[var_1] scripts\sp\utility::_id_10619(1);
    level._id_76E5[var_1]._id_1FBB = "elevator_igc_engineer_" + var_1;
  }
}

_id_CDCB() {
  scripts\sp\anim::_id_1F2C([level.player._id_E505], "elevator_gate_enter");
  level.player unlink();
  level.player._id_E505 delete();
  level.player enableweapons();
  level.player allowcrouch(1);
  level.player allowprone(1);
  level notify("elevator_gate_scene_done");
  playworldsound("mars_elevator_gate_close", (38114, 28897, -10716));
}

_id_CD32(var_0, var_1) {
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_F416, 1);
  scripts\sp\anim::_id_1F2C(var_0, "elevator_gate_enter");
  var_0 = scripts\sp\utility::_id_22B9(var_0);
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_414F);
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_51E1, "cqb");
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_F3E0, 16);
  var_2 = getnodearray("elevator_igc_engineer_node", "script_noteworthy");
  var_3 = getnode("elevator_igc_griff_node", "script_noteworthy");
  level._id_8604 _meth_82EE(var_3);
  level._id_8604 scripts\sp\utility::_id_F3DD(64);

  foreach(var_5 in var_2) {
    var_6 = sortbydistance(var_1, var_5.origin);

    foreach(var_9, var_8 in var_6) {
      if(var_9 > 0) {
        continue;
      }
      var_8 scripts\engine\utility::delaycall(randomfloatrange(0.25, 0.35), ::_meth_82EE, var_5);
    }
  }
}

_id_E7C1() {
  wait 0.75;
  level.player playRumbleOnEntity("damage_light");
  wait 0.4;
  level.player playRumbleOnEntity("damage_light");
  wait 0.25;
  self _meth_8244("tank_rumble");
  wait 2.3;
  self stoprumble("tank_rumble");
  wait 0.5;
  self playRumbleOnEntity("damage_heavy");
  level notify("gate_raised");
  wait 20;
  level.player playRumbleOnEntity("viewmodel_small");
}

_id_CD23(var_0, var_1) {
  scripts\sp\anim::_id_1F2C(var_0, "elevator_gate_enter");
  scripts\sp\utility::_id_228A(var_1);
}

_id_1061A(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0; var_2++) {
    var_1[var_2] = ::scripts\sp\utility::_id_10619(1);
  }

  return var_1;
}

_id_88CC() {
  var_0 = scripts\sp\vehicle::_id_1080C("elevator_igc_dropship");
  var_0 endon("death");
  var_0 playSound("mars_base_eigc_dropship_flyin");
  var_0 playLoopSound("mars_base_eigc_dropship_main");
  var_0 sethoverparams(64, 18, 10);
  var_0 _id_0BBC::_id_C5F1("back", undefined, 1);
  level waittill("gate_raised");
  var_0 playSound("mars_base_eigc_dropship_door_close");
  wait 2;
  var_0 _id_0BBC::_id_4265("back");
  wait 4;
  var_0 playSound("mars_base_eigc_dropship_flyout");
  var_0._id_EF05 = 1;
  var_0 scripts\sp\vehicle::_id_1321A(scripts\engine\utility::getStruct("elevator_igc_dropship_path", "targetname"));
}

#using_animtree("generic_human");

_id_8606(var_0) {
  level._id_8604 waittillmatch("single anim", "mayhem_start");
  level._id_8604 _meth_82A2(%mayhem_mar_10_21_base_arm_through_gate_01, 1.0, 0.0, 1.0);
  level._id_8604 detach(level._id_8604.headmodel);
  level._id_8604._id_1169A = level._id_8604.hatmodel;
  level._id_8604 detach(level._id_8604.hatmodel);
  level._id_8604.hatmodel = undefined;
  level._id_8604 waittillmatch("single anim", "mayhem_end");
  level._id_8604 clearanim(%mayhem_mar_10_21_base_arm_through_gate_01, 0.0);
  level._id_8604 waittillmatch("single anim", "mayhem_start");
  level._id_8604 _meth_82A2(%mayhem_mar_10_21_base_arm_through_gate_02, 1.0, 0.0, 1.0);
  wait 1;
  level._id_8604 waittillmatch("single anim", "mayhem_end");
  level._id_8604 clearanim(%mayhem_mar_10_21_base_arm_through_gate_02, 0.0);
  level._id_8604 attach(level._id_8604.headmodel);
  level._id_8604.hatmodel = level._id_8604._id_1169A;
  level._id_8604._id_1169A = undefined;
  level._id_8604 attach(level._id_8604.hatmodel);
}

_id_30FD(var_0) {
  level._id_30F6 waittillmatch("single anim", "mayhem_start");
  level._id_30F6 _meth_82A2(%mayhem_mar_10_21_base_mr1_through_gate_01, 1.0, 0.0, 1.0);
  level._id_30F6 detach(level._id_30F6.headmodel);
  level._id_30F6._id_1169A = level._id_30F6.hatmodel;
  level._id_30F6 detach(level._id_30F6.hatmodel);
  level._id_30F6.hatmodel = undefined;
  level._id_30F6 waittillmatch("single anim", "mayhem_end");
  level._id_30F6 waittillmatch("single anim", "mayhem_start");
  level._id_30F6 clearanim(%mayhem_mar_10_21_base_mr1_through_gate_01, 0.0);
  level._id_30F6 _meth_82A2(%mayhem_mar_10_21_base_mr1_through_gate_02, 1.0, 0.0, 1.0);
  scripts\engine\utility::waitframe();
  level._id_30F6 waittillmatch("single anim", "mayhem_end");
  level._id_30F6 waittillmatch("single anim", "mayhem_start");
  level._id_30F6 clearanim(%mayhem_mar_10_21_base_mr1_through_gate_02, 0.0);
  level._id_30F6 _meth_82A2(%mayhem_mar_10_21_base_mr1_through_gate_03, 1.0, 0.0, 1.0);
  scripts\engine\utility::waitframe();
  level._id_30F6 waittillmatch("single anim", "mayhem_end");
  level._id_30F6 clearanim(%mayhem_mar_10_21_base_mr1_through_gate_03, 0.0);
  level._id_30F6 attach(level._id_30F6.headmodel);
  level._id_30F6.hatmodel = level._id_30F6._id_1169A;
  level._id_30F6._id_1169A = undefined;
  level._id_30F6 attach(level._id_30F6.hatmodel);
}
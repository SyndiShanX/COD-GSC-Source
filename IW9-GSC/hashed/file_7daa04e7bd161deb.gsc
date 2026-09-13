/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7daa04e7bd161deb.gsc
***********************************************/

main() {
  _id_51B4CA3537C603A8::main();
  _id_29876472F6C5DE88::main();
  _id_4259EF11E5397D26::main();

  if(level.createfx_enabled) {
    return;
  }
  scripts\cp\utility::add_start("trap_platforms");
  scripts\cp\utility::add_start("trap_platforms_puzzle");
  scripts\cp\utility::add_start("trap_rappel");
  scripts\cp\utility::add_start("trap_rappel_top");
  scripts\cp\utility::add_start("trap_doubleback");
  scripts\cp\utility::add_start("trap_oldrooms");
  scripts\cp\utility::add_start("trap_room");
  scripts\cp\utility::add_start("trap_room_puzzle");
  scripts\cp\utility::add_start("trap_room_final_wave");
  scripts\cp\utility::add_start("trap_room_escape");
  scripts\cp\utility::add_start("trap_escape_airlock");
  _id_116171939929AF39::_id_8619B71F2573363B(0);
  scripts\cp\utility::coop_mode_enable();
  _id_D525F1534752BFC7();
  _id_2CFEF434CE6A1C44();
  _id_279964C2C969DDA3();
  _id_3861EB0A004E0D38();
  _id_C4D555BF9485AC3B();
  level.disable_start_spawn_on_navmesh = 1;
  level._id_2EF07FD2D78A7B63 = 0;
}

_id_2CFEF434CE6A1C44() {
  level.custom_onspawnplayer_func = ::onplayerspawned;
  level.custom_onplayerconnect_func = ::onplayerconnect;
}

onplayerconnect(player) {}

onplayerspawned() {
  self._id_4D572A54ED8571C4 = 1;
  _id_79823539CA298145::_id_82E02994003CFFF7(self);
}

_id_279964C2C969DDA3() {
  self._id_4D572A54ED8571C4 = 1;
}

_id_FFE7738C672BE109() {
  _id_CB385B838E10F79E = getDvar("start");

  if(!isDefined(_id_CB385B838E10F79E) || _id_CB385B838E10F79E == "")
    return 0;
  else if(_id_CB385B838E10F79E == "trap_room")
    return 1;

  return 0;
}

_id_3861EB0A004E0D38() {
  level.objectivesfunc = ::_id_C2A86F682BF1AB71;
  level thread scripts\cp\cp_objectives::objectives_init();
  level thread _id_746B6A89A2EA92F5::init();
}

_id_C4D555BF9485AC3B() {
  scripts\cp\utility::_id_BB3E0C926B0667C4("trap_platforms,trap_rappel,trap_doubleback,trap_oldrooms,trap_room,trap_room_escape");
  level thread _id_79823539CA298145::_id_952A793B3FEF082B();
  setup_create_script();
  _id_12211F3913136213::setup_functions();
  _id_16591A48F7D6F223::main();
  level thread _id_FC4803DC319A81D2();
  _id_7641CF498A158DCB::_id_B04F37F19C6631E0();
  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(isDefined(checkpoint) && checkpoint != "" && isDefined(level.registered_checkpoint_funcs[checkpoint]))
    level thread[[level.registered_checkpoint_funcs[checkpoint]]]();
  else
    level thread _id_12211F3913136213::_id_3EA3DD41E55B1C07();

  _id_12E2FB553EC1605E::_id_E2D370937C694C58("iw9_ar_mike4_mp", ["ammo_556n", "bar_ar_p01", "comp_ar_08", "hybridtherm01", "iw9_rec_mike4", "laserbox_ads04", "mag_ar_large_p01", "pgrip_ass_p01", "selectsemi_mike4", "stock_ar_p01_mike4"], "iw9_pi_golf17_mp", ["pgrip_tac"]);
  _id_12E2FB553EC1605E::_id_EBF2582B122904FC("equip_semtex", "equip_shockstick");
  level._id_5966C39CB60075F1 = ::_id_1C8C03372BADE56E;
  level._id_364C64AC310725A0 = 1;

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
    _id_01EC781F5C365546 = getdvarint("dvar_6B92186116FA2C1A", 120);
    _id_3AE8C243F1C86858 = getdvarint("dvar_72523AD696A1466C", 80);
    _id_B02AE2D8D510669A = getdvarint("dvar_F85AFB0CAFB8CEDA", 40);
  } else {
    _id_01EC781F5C365546 = getdvarint("dvar_57825A5CAF4A6BA6", 90);
    _id_3AE8C243F1C86858 = getdvarint("dvar_3C9CD8B3E1743AA8", 60);
    _id_B02AE2D8D510669A = getdvarint("dvar_1E73113AA67EC8A6", 30);
  }

  _id_1E22D314CC16F807::_id_6CCB377E839D87C4(_id_01EC781F5C365546 * 60, _id_3AE8C243F1C86858 * 60, _id_B02AE2D8D510669A * 60);
  thread scripts\cp\intel\cp_intel::intel_init();
  level._id_95B8B02E43BCA8DB = _id_16591A48F7D6F223::_id_41FAFD8966CE1F16;
}

_id_1C8C03372BADE56E() {
  self endon("death_or_disconnect");
  self endon("last_stand");
  level waittill("player_spawned_with_loadout");
  scripts\cp\utility::giveperk("specialty_hack");
}

setup_create_script() {
  scripts\cp\cp_create_script_utility::init_create_script_for_level();
  scripts\cp\cp_create_script_utility::register_create_script_arrays("cp_raid1_trap_create_script", "cp_raid1_trap_create_script", level.scripted_spawner_func.size, _id_33BBCA99F3D476F2::main);
  scripts\cp\cp_create_script_utility::register_create_script_arrays("cp_raid_complex_cs_trap_room", "cp_raid_complex_trap_room", level.scripted_spawner_func.size, _id_599C2C15EA11F1EC::main);
  scripts\cp\cp_create_script_utility::register_create_script_arrays("cp_raid1_trap_plat_cs", "cp_raid1_trap_plat_cs", level.scripted_spawner_func.size, _id_4F12C5BA7AA12DF8::main);
  scripts\cp\cp_create_script_utility::register_create_script_arrays("cp_raid1_trap_drones_cs", "cp_raid1_trap_drones_cs", level.scripted_spawner_func.size, _id_731F14C50BAAC052::main);
}

_id_FC4803DC319A81D2() {
  level thread wait_for_pre_game_period();
  level thread wait_for_strike_init_complete();
}

wait_for_pre_game_period() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("bsp_structs_initialized");
  scripts\engine\utility::flag_wait("level_ready_for_script");
}

wait_for_strike_init_complete() {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("strike_init_done"))
    scripts\engine\utility::flag_wait("strike_init_done");

  level scripts\cp\intel\cp_intel::_id_4F08AFA61F734625();
}

_id_C2A86F682BF1AB71() {
  level.objectives_table = "cp/cp_raid1_trap_objectives.csv";
  level.objectivesmatrixtable = "cp/cp_raid1_trap_objectives_matrix.csv";
  level.objectiveregistration = ::_id_77765E5DD4C9DB54;
  scripts\cp\cp_objectives::parseobjectivestable(level.objectives_table);
}

_id_77765E5DD4C9DB54() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  scripts\engine\utility::flag_wait("objective_table_parsed");
  _id_16591A48F7D6F223::register_trap_room_objectives();
}

_id_D525F1534752BFC7() {
  setDvar("sm_sunSampleSizeNear", 1.25);
  setDvar("r_umbraMinObjectContribution", 4);
  setDvar("r_umbraAccurateOcclusionThreshold", 2048);
  setDvar("sm_roundRobinPrioritySpotShadows", 8);
  setDvar("sm_spotUpdateLimit", 8);
  setDvar("dvar_F3F4556449D659F1", 1);
  setDvar("bg_enablehangpmove", 1);
  setDvar("dvar_AAE8E9A472853241", 3);
  setDvar("dvar_B7428962A5B346FD", 1);
  level._id_3DC8BA65070D0F42 = "damage_deathsdoor_cpraid1trap";
  scripts\engine\utility::flag_set("infil_complete");
}
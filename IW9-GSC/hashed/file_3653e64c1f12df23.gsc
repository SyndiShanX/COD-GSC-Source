/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3653e64c1f12df23.gsc
***********************************************/

main() {
  level.default_player_spawns = "default_player_start_intro";
  level.disable_start_spawn_on_navmesh = 1;
  _id_13821817DB931DEB::main();
  _id_4386BC93A28CE1D2::main();
  _id_61AA83FFD57BC190::main();
  _id_3B98159468E43AAE::main();
  scripts\cp\compass::setupminimap("compass_map_cp_raid1");

  if(level.createfx_enabled) {
    return;
  }
  scripts\cp\utility::coop_mode_enable("sp_stealth");
  _id_165F87DC9B28463B::_id_1F763DFECFC35564();
  _id_D525F1534752BFC7();
  _id_2CFEF434CE6A1C44();
  _id_279964C2C969DDA3();
  _id_3861EB0A004E0D38();
  _id_C4D555BF9485AC3B();
  scripts\cp\utility::add_start("raid1_intro", undefined, ::_id_D182D43FFFB04A6E);
  scripts\cp\utility::add_start("raid1_intro_puzzle", undefined, ::_id_78C7D2A2A0E2C303);
  scripts\cp\utility::add_start("raid1_maze", undefined, ::_id_B380CCB1F44139A3);
  scripts\cp\utility::add_start("raid1_maze_mid", undefined, ::_id_4D53871DE4816611);
  scripts\cp\utility::add_start("raid1_maze_armory", undefined, ::_id_BE4368835F25DF86);
  scripts\cp\utility::add_start("raid1_nums", undefined, ::_id_96FC06C5ED8EB8DD);
  scripts\cp\utility::add_start("raid1_nums_skiptopuzzle", undefined, ::_id_1387E29FF8BE0D68);
  scripts\cp\utility::add_start("raid1_nums_defend", undefined, ::_id_BC0FE526FF5131B2);
  scripts\cp\utility::add_start("raid1_nums_outro", undefined, ::_id_7325C636B983A005);
  scripts\cp\utility::set_default_start("raid1_intro");
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_47B7445B595408F7", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_F5740209893CDF46", 1, 0);
  level._id_633EE74E2649AAC7 = ::_id_633EE74E2649AAC7;
  level._id_4F2AB335EF95E1E3 = 1;
  level._id_0FD357ADEA109F55 = ::_id_27322B3878E4F055;
  thread _id_4D4CB4FA1FCAFE0B();
  level._id_364C64AC310725A0 = 1;
  thread scripts\cp\intel\cp_intel::intel_init();
  thread _id_2090D8F05F91E013::intel_init();
}

_id_633EE74E2649AAC7(_id_97282C14346A7FCF) {
  setDvar("start", "raid1_intro");
  scripts\cp\cp_checkpoint::checkpoint_set("");
}

_id_2CFEF434CE6A1C44() {
  level scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::_id_61B94EDD8B09D340);
  level.custom_onplayerconnect_func = ::onplayerconnect;
  level.disable_start_spawn_on_navmesh = 1;
}

onplayerconnect(player) {}

_id_61B94EDD8B09D340() {
  thread setup_player_stealth(1);
  thread _id_26006D6955F78888::_id_1C8C03372BADE56E();
  thread _id_293D38BA5ADE4FA6();
}

onplayerspawned() {
  thread setup_player_stealth();
  thread _id_293D38BA5ADE4FA6();
}

_id_279964C2C969DDA3() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "updateSwimOverlayColor", scripts\cp\utility\player::_id_678EED0AF59B69EB);
  level thread _id_25B81C664131D50B::setup_functions();
  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(isDefined(checkpoint) && checkpoint != "" && isDefined(level.registered_checkpoint_funcs[checkpoint]))
    level thread[[level.registered_checkpoint_funcs[checkpoint]]]();
}

_id_3861EB0A004E0D38() {
  level.objectivesfunc = ::_id_C2A86F682BF1AB71;
  level thread scripts\cp\cp_objectives::objectives_init();
  level._id_9023ACDD4F7E61F4 = _id_669C0F6CB0B7F0CD::_id_0127760A23DFB596;
  level.drone_turrets = [];
  level thread scripts\cp\cp_enemy_drone_turret::init();
  level thread _id_6E2CD47141F9745B::init();
  level._id_BF8AA3F39F981625[level._id_BF8AA3F39F981625.size] = _id_669C0F6CB0B7F0CD::_id_FC4EE8E475C450C3;
}

_id_C4D555BF9485AC3B() {
  setup_create_script();
  level thread _id_FC4803DC319A81D2();
  _id_0448EF4D9E70CE5E::_id_3E689374A8C8C3A2(33);

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
    _id_0448EF4D9E70CE5E::_id_3E689374A8C8C3A2(16, 12);

  _id_CB385B838E10F79E = scripts\cp\utility::_id_BB3E0C926B0667C4;
  [[_id_CB385B838E10F79E]]("raid1_intro,raid1_intro_puzzle,raid1_maze,raid1_maze_mid,raid1_maze_armory,raid1_nums,raid1_nums_skiptopuzzle,raid1_nums_defend,raid1_nums_outro");
  _id_2090D8F05F91E013::_id_B04F37F19C6631E0();
  _id_12E2FB553EC1605E::_id_E2D370937C694C58("iw9_dm_mike14_mp", ["fourxtherm02_highzoom", "laser", "silencer"], "iw9_pi_papa220_mp", ["pgrip_tac", "silencer"]);
  _id_12E2FB553EC1605E::_id_EBF2582B122904FC("equip_throwing_knife", "equip_flash");
  level thread _id_26006D6955F78888::main();
  scripts\engine\utility::flag_init("maze_pickedup_mask");
  scripts\cp\tripwire_cp::init();
  scripts\cp_mp\tripwire::precachetrap("tripwire_trap_frag", "offhand_wm_grenade_mike67", 1);
  level._id_3FD34375D8E0A2B5 = _id_03DAF8A4D8E82EAD::_id_510DCDCBF4FC993C;
  level thread _id_34D2771929BD6022::_id_0BCD7DBE50E5AF96();
  level _id_4AA198AF4457349E::_id_9C660C8EF32706C8();
  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(!isDefined(checkpoint) || checkpoint == "")
    level thread scripts\cp\cp_objectives::run_debug_start_objective("raid1_intro");

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
    _id_01EC781F5C365546 = getdvarint("dvar_6B92186116FA2C1A", 90);
    _id_3AE8C243F1C86858 = getdvarint("dvar_72523AD696A1466C", 60);
    _id_B02AE2D8D510669A = getdvarint("dvar_F85AFB0CAFB8CEDA", 40);
  } else {
    _id_01EC781F5C365546 = getdvarint("dvar_57825A5CAF4A6BA6", 90);
    _id_3AE8C243F1C86858 = getdvarint("dvar_3C9CD8B3E1743AA8", 60);
    _id_B02AE2D8D510669A = getdvarint("dvar_1E73113AA67EC8A6", 40);
  }

  _id_1E22D314CC16F807::_id_6CCB377E839D87C4(_id_01EC781F5C365546 * 60, _id_3AE8C243F1C86858 * 60, _id_B02AE2D8D510669A * 60);
}

setup_create_script() {
  scripts\cp\cp_create_script_utility::init_create_script_for_level();
  scripts\cp\cp_create_script_utility::register_create_script_arrays("cp_raid1_create_script", "cp_raid1_create_script", level.scripted_spawner_func.size, _id_52DC0A14BB6E0ADA::main);
  scripts\cp\cp_create_script_utility::register_create_script_arrays("cp_raid1_intro_cs_container", "cp_raid1_intro_cs_container", level.scripted_spawner_func.size, _id_01F1D2116A0E079E::main);
  scripts\cp\cp_create_script_utility::register_cs_offsets("cp_raid1_maze_cctv_cs", (5512, 13201.7, 601.494), (0, 90, 0));
  scripts\cp\cp_create_script_utility::register_cs_offsets("cp_raid1_maze_create_script", (5512, 13201.7, 601.494), (0, 90, 0));
  scripts\cp\cp_create_script_utility::register_cs_offsets("cp_raid1_nums_create_script", (-230.92, 2737.6, -898.506), (0, 270, 0));
  scripts\cp\cp_create_script_utility::register_cs_offsets("cp_raid1_nums_puzzle_cs", (-230.92, 2737.6, -898.506), (0, 270, 0));
  scripts\cp\cp_create_script_utility::register_cs_offsets("cp_raid1_nums_dronegrid_cs", (-230.92, 2737.6, -898.506), (0, 270, 0));
  level thread _id_36D555EC16DCC9B1();
  level thread _id_F0B783AA0289A13A();
  level thread _id_F69911EE43D37218();
}

_id_36D555EC16DCC9B1() {
  scripts\engine\utility::flag_wait("cp_raid1_create_script_completed");
  _id_2FFD3BE60E5DD768 = scripts\engine\utility::getStruct("raid_load_struct_cctv", "targetname");
  radiussq = squared(int(_id_2FFD3BE60E5DD768.radius));

  while(!scripts\cp\utility::any_player_nearby(_id_2FFD3BE60E5DD768.origin, radiussq))
    wait 1;

  scripts\cp\cp_create_script_utility::register_create_script_arrays("cp_raid1_maze_cctv_cs", "cp_raid1_maze_cctv_cs", level.scripted_spawner_func.size, _id_71C6BDA7756BD877::main);
  wait 0.05;
  _id_71C6BDA7756BD877::main();
  _id_65C8C1CF92C616D7::main();
  scripts\engine\utility::flag_wait("cp_raid1_maze_cctv_cs_completed");
  scripts\engine\utility::flag_wait("cp_raid1_nums_dronegrid_cs_completed");
  level thread _id_03DAF8A4D8E82EAD::_id_7861D97D45065917();
}

_id_F0B783AA0289A13A() {
  scripts\engine\utility::flag_wait("cp_raid1_create_script_completed");
  _id_BA03B296E2C12819 = scripts\engine\utility::getStruct("raid_load_struct_cctv", "targetname");
  _id_E8BFB6131CA5744F = scripts\engine\utility::getStruct("raid_load_struct_armorymaze", "targetname");
  radiussq = squared(int(_id_BA03B296E2C12819.radius));

  while(!scripts\cp\utility::any_player_nearby(_id_BA03B296E2C12819.origin, radiussq) && !scripts\cp\utility::any_player_nearby(_id_E8BFB6131CA5744F.origin, radiussq))
    wait 1;

  scripts\cp\cp_create_script_utility::register_create_script_arrays("cp_raid1_maze_create_script", "cp_raid1_maze_create_script", level.scripted_spawner_func.size, _id_77B026535F50DF1A::main);
  wait 0.05;
  _id_77B026535F50DF1A::main();
  scripts\engine\utility::flag_wait("cp_raid1_maze_create_script_completed");
  level thread _id_772B9CDEF8A5624F();
  level thread _id_A3028D250C2B9478();
  level thread scripts\cp\killstreaks\airdrop_cp::_id_20C12AA7546FCAA5();
}

_id_F69911EE43D37218() {
  scripts\engine\utility::flag_wait("cp_raid1_create_script_completed");
  _id_E7C1D5F198601061 = scripts\engine\utility::getStructArray("raid_load_struct_nums", "targetname");
  _id_9F925F5509626DF1 = 0;

  for(;;) {
    foreach(_id_2FFD3BE60E5DD768 in _id_E7C1D5F198601061) {
      if(scripts\cp\utility::any_player_nearby(_id_2FFD3BE60E5DD768.origin, squared(_id_2FFD3BE60E5DD768.radius))) {
        _id_9F925F5509626DF1 = 1;
        break;
      }
    }

    if(_id_9F925F5509626DF1) {
      break;
    }

    wait 1;
  }

  scripts\cp\cp_create_script_utility::register_create_script_arrays("cp_raid1_nums_create_script", "cp_raid1_nums_create_script", level.scripted_spawner_func.size, _id_45A743B568D6BEDA::main);
  scripts\cp\cp_create_script_utility::register_create_script_arrays("cp_raid1_nums_puzzle_cs", "cp_raid1_nums_puzzle_cs", level.scripted_spawner_func.size, _id_4FA9A93DA6728BC7::main);
  scripts\cp\cp_create_script_utility::register_create_script_arrays("cp_raid1_nums_dronegrid_cs", "cp_raid1_nums_dronegrid_cs", level.scripted_spawner_func.size, _id_65C8C1CF92C616D7::main);
  wait 0.05;
  _id_45A743B568D6BEDA::main();
  _id_4FA9A93DA6728BC7::main();
  _id_65C8C1CF92C616D7::main();
  scripts\engine\utility::flag_wait("cp_raid1_nums_create_script_completed");
  scripts\engine\utility::flag_wait("cp_raid1_nums_puzzle_cs_completed");
  scripts\engine\utility::flag_wait("cp_raid1_nums_dronegrid_cs_completed");
  level thread _id_4AA198AF4457349E::main();
  level thread _id_4AA198AF4457349E::_id_5EE15FF9CC6E092B();
}

_id_FC4803DC319A81D2() {
  level thread wait_for_pre_game_period();
  level thread wait_for_strike_init_complete();
}

wait_for_pre_game_period() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("bsp_structs_initialized");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  wait 5;
  thread _id_435C3F85A3D06576::_id_491A6611A0B52B99();
}

wait_for_strike_init_complete() {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("strike_init_done"))
    scripts\engine\utility::flag_wait("strike_init_done");

  level scripts\cp\intel\cp_intel::_id_4F08AFA61F734625();
}

_id_4D4CB4FA1FCAFE0B() {
  scripts\engine\utility::flag_init("stealth_music_pause");
  scripts\engine\utility::flag_wait("both_players_intro_binks_complete");
  start = getDvar("start");
  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if((start == "raid1_intro" || start == "") && (checkpoint == "" || checkpoint == "checkpoint_maze_armory")) {
    if(getdvarint("dvar_F5740209893CDF46", 0))
      level thread scripts\stealth\init::set_stealth_mode(1, "mx_cp_raid1_stealth_hidden", "mx_cp_raid1_stealth_spotted");
  }
}

_id_C2A86F682BF1AB71() {
  level.objectives_table = "cp/cp_raid1_objectives.csv";
  level.objectivesmatrixtable = "cp/cp_raid1_objectives_matrix.csv";
  level.objectiveregistration = ::_id_77765E5DD4C9DB54;
  scripts\cp\cp_objectives::parseobjectivestable(level.objectives_table);
}

_id_77765E5DD4C9DB54() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  scripts\engine\utility::flag_wait("objective_table_parsed");
  _id_26006D6955F78888::register_objectives();
}

_id_D525F1534752BFC7() {
  setDvar("sm_sunSampleSizeNear", 1.25);
  setDvar("r_umbraMinObjectContribution", 4);
  setDvar("r_umbraAccurateOcclusionThreshold", 2048);
  setDvar("sm_roundRobinPrioritySpotShadows", 8);
  setDvar("sm_spotUpdateLimit", 8);
  setDvar("dvar_F8332F8A8CEDCA1C", 1);
  setDvar("dvar_EBD98E5EECC1322B", 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_0ACD3891A0644E00", 1, 0);
  level._id_BF6C149BC4124962 = 5;

  if(getdvarint("dvar_ECDB04395FA52527", 0) == 1)
    level.spectaterulesfunc = ::_id_1B69D5D23CC11E7D;

  scripts\engine\utility::flag_set("infil_complete");
  level thread _id_CF7A5138F594A14D();
  level thread _id_920E7A0A54B12C62();
}

_id_1B69D5D23CC11E7D(player) {
  player allowspectateteam("allies", 0);
  player allowspectateteam("axis", 1);
  player allowspectateteam("freelook", 0);
  player allowspectateteam("none", 1);
}

setup_player_stealth(_id_E40F5A786E919D6D) {
  self notify("setup_player_stealth");
  self endon("setup_player_stealth");
  self endon("disconnect");

  if(scripts\cp\coop_stealth::level_should_run_sp_stealth()) {
    scripts\engine\utility::flag_wait("level_stealth_initialized");
    scripts\stealth\player::main();
    thread _id_7C110E744404EE81::_id_9FF225017EF5CE19();

    if(getdvarint("dvar_38FC4761564144DC", 0) != 0)
      scripts\engine\utility::ent_flag_set("stealth_use_real_lighting");
    else
      scripts\engine\utility::ent_flag_clear("stealth_use_real_lighting");

    thread scripts\cp\coop_stealth::suspicious_door_monitor();
  }

  if(istrue(_id_E40F5A786E919D6D))
    childthread _id_EDBA579A82218DD4();
}

_id_EDBA579A82218DD4() {
  scripts\engine\utility::flag_wait("both_players_intro_binks_complete");
  waitframe();
  start = getDvar("start");
  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if((start == "raid1_intro" || start == "") && checkpoint == "") {
    if(_func_EAC0CD99C9C6D8EE() != "spotted") {
      if(!scripts\stealth\manager::anyone_in_combat()) {
        level._id_7CAA8AB2F4145CFA = "mx_cp_raid1_stealth";
        self setplayermusicstate(level._id_7CAA8AB2F4145CFA);
      }
    }
  }
}

_id_293D38BA5ADE4FA6() {
  if(!isDefined(level._id_B6217B906C6BE73E))
    level._id_B6217B906C6BE73E = [];

  if(isstartstr(self._id_DC196D396886FB97.name, "price")) {
    level.price = self;
    level._id_B6217B906C6BE73E["price"] = self;
    self._id_938E8B2CA6549759 = "price";
  } else if(isstartstr(self._id_DC196D396886FB97.name, "farah")) {
    level.farah = self;
    level._id_B6217B906C6BE73E["farah"] = self;
    self._id_938E8B2CA6549759 = "farah";
  } else {
    level._id_E0632103DFA5BB19 = self;
    level._id_B6217B906C6BE73E["gaz"] = self;
    self._id_938E8B2CA6549759 = "gaz";
  }
}

_id_D182D43FFFB04A6E() {
  level.default_player_spawns = "default_player_start_intro";
  level.disable_start_spawn_on_navmesh = 1;
  level.skip_nav_check_on_spectate_respawn = 0;
}

_id_78C7D2A2A0E2C303() {
  level.default_player_spawns = "default_player_start_intro";
  level.disable_start_spawn_on_navmesh = 1;
  level.skip_nav_check_on_spectate_respawn = 0;
  level thread _id_A20A8C8669BD8AFD();
}

_id_A20A8C8669BD8AFD() {
  level endon("game_ended");
  wait 1;
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  wait 1;
  _id_5CAA739F456ADF7C = (1828, 18881, 1615);
  _id_5CAA739F456ADF7C = getclosestpointonnavmesh(_id_5CAA739F456ADF7C) + (0, 0, 5);
  level.players[0] setOrigin(_id_5CAA739F456ADF7C, 1);
}

_id_B380CCB1F44139A3() {
  level notify("stop_intro_vo");
  _id_77B026535F50DF1A::main();
  level.getspawnpoint = ::_id_E8D84CBE99CDF926;
}

_id_4D53871DE4816611() {
  level notify("stop_intro_vo");
  _id_77B026535F50DF1A::main();
  level.getspawnpoint = ::_id_E8D84CBE99CDF926;
  thread _id_8786CDFE4AD73B2F();
}

_id_8786CDFE4AD73B2F() {
  level notify("stop_intro_vo");
  level endon("game_ended");
  wait 1;
  announcement("^2Pick up oxygen mask to teleport!");
  level waittill("player_given_oxygenmask");
  wait 1;
  thread scripts\cp\utility::teleportallplayersinteamtostructs("allies", "watermaze_debug_start_loc_2", 1);
}

_id_BE4368835F25DF86() {
  level notify("stop_intro_vo");
  level scripts\cp\utility\spawn_event_aggregator::_id_DE35280460AE9411(::_id_61B94EDD8B09D340);
  level scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);
  _id_77B026535F50DF1A::main();
  level thread _id_22E6F6A5E38449D2();
  level._id_E1F6DB0A259574B7 = 1;
  scripts\cp\cp_checkpoint::checkpoint_set("checkpoint_maze_armory");
  level thread scripts\cp\utility::thread_teleportplayertoteamstructs_latejoin("allies", "startpoint_armory");
  level thread _id_67673120F043631E::start_puzzle(1);
}

_id_22E6F6A5E38449D2() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("cp_raid1_maze_create_script_completed");

  if(isDefined(level._id_3FD34375D8E0A2B5))
    level thread[[level._id_3FD34375D8E0A2B5]]();

  wait 1;

  if(isDefined(level.start_point) && level.start_point == "raid1_maze_armory")
    level thread scripts\cp\utility::teleportallplayersinteamtostructs("allies", "startpoint_armory", 1);
}

_id_96FC06C5ED8EB8DD() {
  level notify("stop_intro_vo");
  level._id_E1F6DB0A259574B7 = 1;
  level scripts\cp\utility\spawn_event_aggregator::_id_DE35280460AE9411(::_id_61B94EDD8B09D340);
  level scripts\cp\utility\spawn_event_aggregator::_id_DE35280460AE9411(::onplayerspawned);
  level scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);
  _id_45A743B568D6BEDA::main();
  _id_4FA9A93DA6728BC7::main();
  _id_65C8C1CF92C616D7::main();
  scripts\engine\utility::flag_wait("cp_raid1_nums_create_script_completed");
  scripts\engine\utility::flag_wait("cp_raid1_nums_puzzle_cs_completed");
  scripts\engine\utility::flag_wait("cp_raid1_nums_dronegrid_cs_completed");
  level thread _id_4AA198AF4457349E::_id_B6E0E3CEF865C8F7(1);
}

_id_1387E29FF8BE0D68() {
  level notify("stop_intro_vo");
  level._id_E1F6DB0A259574B7 = 1;
  _id_45A743B568D6BEDA::main();
  _id_4FA9A93DA6728BC7::main();
  _id_65C8C1CF92C616D7::main();
  scripts\engine\utility::flag_wait("cp_raid1_nums_create_script_completed");
  scripts\engine\utility::flag_wait("cp_raid1_nums_puzzle_cs_completed");
  scripts\engine\utility::flag_wait("cp_raid1_nums_dronegrid_cs_completed");
  scripts\cp\cp_checkpoint::checkpoint_set("checkpoint_nums_ready_puzzle");
  level thread scripts\cp\utility::thread_teleportplayertoteamstructs_latejoin("allies", "numbers_debug_start_loc");
  _id_25B81C664131D50B::_id_14333AFFFB5B92A8();
  _id_96FC06C5ED8EB8DD();
}

_id_BC0FE526FF5131B2() {
  level notify("stop_intro_vo");
  level._id_E1F6DB0A259574B7 = 1;
  _id_45A743B568D6BEDA::main();
  _id_4FA9A93DA6728BC7::main();
  _id_65C8C1CF92C616D7::main();
  scripts\engine\utility::flag_wait("cp_raid1_nums_create_script_completed");
  scripts\engine\utility::flag_wait("cp_raid1_nums_puzzle_cs_completed");
  scripts\engine\utility::flag_wait("cp_raid1_nums_dronegrid_cs_completed");
  scripts\cp\cp_checkpoint::checkpoint_set("checkpoint_nums_ready_finale");
  level thread scripts\cp\utility::thread_teleportplayertoteamstructs_latejoin("allies", "numbers_checkpoint_defend_debug_start_loc");
  _id_25B81C664131D50B::_id_0C973364A950A769();
  _id_96FC06C5ED8EB8DD();
}

_id_7325C636B983A005() {
  level._id_A70195BBD734F8DA = 1;
  thread _id_BC0FE526FF5131B2();
}

_id_A3028D250C2B9478() {
  if(istrue(level._id_BC53C613A7E7DB4D)) {
    level scripts\cp\utility\spawn_event_aggregator::_id_DE35280460AE9411(::_id_61B94EDD8B09D340);
    level scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);
    level thread _id_22E6F6A5E38449D2();
    level thread _id_67673120F043631E::_id_4E51A1FCB5CBA3D7(4);
    level thread _id_67673120F043631E::start_puzzle(1);
  }
}

_id_772B9CDEF8A5624F() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("cp_raid1_maze_create_script_completed");
  level thread _id_3FF8DBF9F1E48678();
  struct = scripts\engine\utility::getStruct("watermaze_oxygenmask", "targetname");
  mask = level _id_4D5D872A7BD5C0C3::_id_18DFEA62F135DEF6(struct.origin, struct.angles);

  if(!isDefined(mask)) {
    return;
  }
  mask waittill("death");
  scripts\engine\utility::flag_set("picked_up_oxygen_mask");

  foreach(player in level.players)
  player scripts\engine\utility::delaythread(1, scripts\engine\utility::send_notify, "update_flashlight_tags");

  scripts\cp\cp_checkpoint::checkpoint_set("checkpoint_water_maze");
  level thread _id_67673120F043631E::start_puzzle();
}

_id_3FF8DBF9F1E48678() {
  level endon("game_ended");
  struct = scripts\engine\utility::getStruct("maze_start_checkpoint_spawns_struct", "targetname");
  radius = 500;

  if(isDefined(struct.radius))
    radius = struct.radius;

  _id_1A96B3062BB2C598 = squared(radius);

  while(!scripts\cp\utility::any_player_nearby(struct.origin, _id_1A96B3062BB2C598))
    wait 0.5;

  level thread _id_82CAD1CD6DC65797();
}

_id_82CAD1CD6DC65797() {
  level.getspawnpoint = ::_id_E8D84CBE99CDF926;
  level.enter_spectator_func = ::_id_9FB146E9DA2F38E4;
  level.skip_nav_check_on_spectate_respawn = 1;
  level.all_players_skip_last_stand = 1;
  level._id_307AD42B8F2CCE95 = 1;
  _id_0AFB7E332AEE4BF2::_id_C11E262E2E29094F(0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_B80F97B9C08F17F5", 1, 0);
  _id_526D28D8642C8C69 = getEntArray("watermaze_respawn_point", "targetname");
  scripts\engine\utility::array_thread(_id_526D28D8642C8C69, ::respawn_trigger_think);
  level thread set_respawn_points();
  level._id_AB681BAC7287696B = ::_id_4DF431177FCD9A12;

  foreach(_id_1730C8D8475566CD in level.players) {
    if(istrue(_id_1730C8D8475566CD.inlaststand)) {
      _id_1730C8D8475566CD thread _id_0AFB7E332AEE4BF2::finishreviveplayer("self_revive_success", _id_1730C8D8475566CD);

      if(istrue(_id_1730C8D8475566CD._id_B24E609023CE8208)) {
        _id_1730C8D8475566CD._id_B24E609023CE8208 = undefined;
        return;
      }

      _id_1730C8D8475566CD notify("last_stand_revived");
      _id_1730C8D8475566CD notify("last_stand_finished");
      continue;
    }

    if(isDefined(_id_1730C8D8475566CD.dogtag)) {
      _id_1730C8D8475566CD _id_0AFB7E332AEE4BF2::instant_revive(_id_1730C8D8475566CD);
      _id_1730C8D8475566CD notify("last_stand_finished");
    }
  }
}

_id_4DF431177FCD9A12() {
  level.getspawnpoint = _id_0598E0C00C8151F7::getspawnpoint;
  level.enter_spectator_func = _id_0AFB7E332AEE4BF2::enable_dogtag_revive;
  level.skip_nav_check_on_spectate_respawn = undefined;
  level.all_players_skip_last_stand = undefined;
  level._id_307AD42B8F2CCE95 = undefined;
  _id_0AFB7E332AEE4BF2::_id_C11E262E2E29094F(1);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_B80F97B9C08F17F5", 0, 0);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    level.players[_id_AC0E594AC96AA3A8].respawn_index = undefined;
    level.players[_id_AC0E594AC96AA3A8].shouldskiplaststand = undefined;
  }

  level notify("watermaze_done");
}

_id_E8D84CBE99CDF926() {
  _id_89770FE705541944 = scripts\engine\utility::getStructArray("watermaze_dogtags", "targetname");
  _id_5BE51D5841E0DB4E(_id_89770FE705541944);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    if(self == level.players[_id_AC0E594AC96AA3A8]) {
      if(!isDefined(level.player_respawn))
        level.player_respawn = [];

      if(!isDefined(level.player_respawn[_id_AC0E594AC96AA3A8])) {
        self.respawn_index = _id_AC0E594AC96AA3A8;
        self.shouldskiplaststand = 1;
        level.player_respawn[_id_AC0E594AC96AA3A8] = _id_89770FE705541944[_id_AC0E594AC96AA3A8];
      }

      return level.player_respawn[_id_AC0E594AC96AA3A8];
    }
  }
}

_id_5BE51D5841E0DB4E(_id_BFE291B401A9BF2A) {
  if(isDefined(_id_BFE291B401A9BF2A) && _id_BFE291B401A9BF2A.size > 0 && !isDefined(getclosestpointonnavmesh(_id_BFE291B401A9BF2A[0].origin)))
    level.disable_start_spawn_on_navmesh = 1;
}

_id_9FB146E9DA2F38E4(downed_player) {
  _id_E0CBA2B0A5510D09 = level.player_respawn[downed_player.respawn_index];
  downed_player.respawn_forcespawnorigin = _id_E0CBA2B0A5510D09.origin;
  downed_player.respawn_forcespawnangles = _id_E0CBA2B0A5510D09.angles;
  timer = 5;
  _id_19F0135BD917C05D = getdvarint("dvar_114BC53B0EDA1B83", 0);

  if(_id_19F0135BD917C05D != 0)
    timer = _id_19F0135BD917C05D;

  wait(timer);

  foreach(key, value in downed_player.br_ammo)
  downed_player.br_ammo[key] = 0;

  downed_player _id_0AFB7E332AEE4BF2::instant_revive(downed_player);
  downed_player notify("last_stand_finished");
  downed_player thread _id_116171939929AF39::player_init_health_regen();
  downed_player thread _id_0B1829361018D3AE();
  downed_player thread _id_507CC76FFA4376A9();
}

_id_0B1829361018D3AE() {
  self endon("death_or_disconnect");
  thread scripts\cp\utility::clearlowermessages();
  waitframe();
  time = 3.5;
  hintstring = &"CP_RAID_WATERMAZE/CHECKPOINT_RESPAWN";
  thread scripts\cp\utility::setlowermessage("checkpoint", hintstring, time, 1, 0, 1, 0, time, 0, 1);
  wait(time);
  thread scripts\cp\utility::clearlowermessages();
}

_id_507CC76FFA4376A9() {
  self endon("disconnect");
  wait 0.5;

  if(self _meth_6F55D55CCFF20D14())
    self notify("swim_breathing_disabled_begin");
}

set_respawn_points() {
  level endon("watermaze_done");

  if(!isDefined(level.player_respawn))
    level.player_respawn = [];

  _id_89770FE705541944 = scripts\engine\utility::getStructArray("watermaze_dogtags", "targetname");
  _id_D3CF746E0DF9ED86 = getEnt("watermaze_respawn_default_trigger", "targetname");

  for(;;) {
    _id_D3CF746E0DF9ED86 waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(!isDefined(player.respawn_index)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
        if(player == level.players[_id_AC0E594AC96AA3A8]) {
          player.respawn_index = _id_AC0E594AC96AA3A8;
          player.shouldskiplaststand = 1;
          level.player_respawn[_id_AC0E594AC96AA3A8] = _id_89770FE705541944[_id_AC0E594AC96AA3A8];
        }
      }
    }

    waitframe();
  }
}

respawn_trigger_think() {
  self endon("death");
  level endon("watermaze_done");

  if(!isDefined(level.player_respawn))
    level.player_respawn = [];

  for(;;) {
    self waittill("trigger", player);
    thread _id_68D91FFAB4C9A409();

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(!isDefined(player.respawn_index)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
        if(player == level.players[_id_AC0E594AC96AA3A8])
          player.respawn_index = _id_AC0E594AC96AA3A8;
      }
    }

    if(!isDefined(level.player_respawn[player.respawn_index]) || level.player_respawn[player.respawn_index] != self) {
      player thread set_respawn_loc_delayed(self);
      player thread _id_E61CAD35A7701E43(self);
    } else
      continue;

    waitframe();
  }
}

_id_68D91FFAB4C9A409() {
  if(!isDefined(level._id_A7367042530D7107))
    level._id_A7367042530D7107 = [];

  if(isDefined(self.script_noteworthy)) {
    if(scripts\engine\utility::array_contains(level._id_A7367042530D7107, self.script_noteworthy)) {
      return;
    }
    level._id_A7367042530D7107[level._id_A7367042530D7107.size] = self.script_noteworthy;
    scripts\cp\cp_analytics::_id_BFE1744EF18F30F9("Maze Checkpoint Reached: " + self.script_noteworthy);
  } else {}
}

set_respawn_loc_delayed(loc) {
  level endon("game_ended");
  level endon("watermaze_done");
  self endon("new_respawn_loc");
  self endon("death");
  wait 0.5;

  if(isalive(self)) {
    if(!isDefined(self.respawn_index)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
        if(self == level.players[_id_AC0E594AC96AA3A8])
          self.respawn_index = _id_AC0E594AC96AA3A8;
      }
    }

    if(isDefined(loc.target)) {
      _id_C57CF07E9216555D = scripts\engine\utility::getStruct(loc.target, "targetname");

      if(isDefined(_id_C57CF07E9216555D) && isstruct(_id_C57CF07E9216555D))
        loc = _id_C57CF07E9216555D;
    }

    level.player_respawn[self.respawn_index] = loc;
    self notify("new_respawn_loc");
  }
}

_id_E61CAD35A7701E43(trigger) {
  if(!istrue(self.hasspawned)) {
    return;
  }
  if(!isDefined(trigger.script_noteworthy)) {
    return;
  }
  if(isDefined(self._id_BF49F20536CC5D08)) {
    if(self._id_BF49F20536CC5D08 == trigger.script_noteworthy)
      return;
  }

  self._id_BF49F20536CC5D08 = trigger.script_noteworthy;
  thread scripts\cp\cp_hud_message::tutorialprint(&"COOP_GAME_PLAY/SAFE_AREA", 1.6);
}

_id_2ABA062264F3352F() {
  _id_526D28D8642C8C69 = getEntArray("watermaze_respawn_point", "targetname");
  scripts\engine\utility::array_thread(_id_526D28D8642C8C69, ::delete_ent);
}

delete_ent() {
  self delete();
}

_id_CF7A5138F594A14D() {
  level endon("game_ended");
  _id_23D6B103E44C84B4 = 0;
  _id_23D6B403E44C8B4D = 0;
  _id_23D6B303E44C891A = 0;
  _id_23D6AE03E44C7E1B = 0;
  _id_AB48F5F77BBEFD32 = 730;

  for(;;) {
    wait 5;
    _id_1D2BE7531AAF82AF = getEntArray();

    if(_id_1D2BE7531AAF82AF.size >= _id_AB48F5F77BBEFD32) {
      if(!_id_23D6B103E44C84B4) {
        logprint("*** GSC WARNING: Running low on entities. Running raid1 delete group 1.");
        level thread _id_18AF78602B67B70C::_id_ED39B08FB6EE314A();
        level thread scripts\cp\utility::removepatchablecollision_delayed();
        _id_C006D02A2BAC88FC = getEntArray("silo_thrust_platform", "targetname");

        foreach(entity in _id_C006D02A2BAC88FC)
        entity delete();

        _id_C006D02A2BAC88FC = getEntArray("silo_thrust_platform_clip", "targetname");

        foreach(entity in _id_C006D02A2BAC88FC)
        entity delete();

        _id_160EF06FA8851428 = getEntArray("silo_gyro_1", "targetname");

        foreach(light in _id_160EF06FA8851428)
        light delete();

        for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= 10; _id_AC0E594AC96AA3A8++) {
          _id_160EF06FA8851428 = getEntArray("silo_light_" + _id_AC0E594AC96AA3A8, "targetname");

          foreach(light in _id_160EF06FA8851428)
          light delete();
        }

        _id_23D6B103E44C84B4 = 1;
        continue;
      }

      if(!_id_23D6B403E44C8B4D) {
        logprint("*** GSC WARNING: Running low on entities. Running raid1 delete group 2.");
        level thread _id_71717E6C4597A196::_id_3A552AD0C6822236();
        level thread _id_1DB8D0E02A99C5E2::_id_D0E0B1A0DC489379();
        _id_23D6B403E44C8B4D = 1;
        continue;
      }

      if(!_id_23D6B303E44C891A && isDefined(level.tripwires) && isDefined(level.tripwires.traps) && level.tripwires.traps.size > 0) {
        logprint("*** GSC WARNING: Running low on entities. Running raid1 delete group 3.");
        _id_23D6B303E44C891A = 1;
        continue;
      }

      if(!_id_23D6AE03E44C7E1B) {
        logprint("*** GSC WARNING: Running low on entities. Running raid1 delete group 4.");
        _id_FC9ED0C98D505043 = getEntArray("info_volume_stealth_all", "classname");

        foreach(entity in _id_FC9ED0C98D505043)
        entity delete();

        _id_540E67C54116D1A7 = getEntArray("loadout_drop", "targetname");

        foreach(_id_3D4EE6AB49DD447E in _id_540E67C54116D1A7)
        _id_3D4EE6AB49DD447E delete();

        _id_23D6AE03E44C7E1B = 1;
        continue;
      }
    }
  }
}

_id_920E7A0A54B12C62() {
  level endon("game_ended");
  wait 3;
  _id_C99DF96C1B95FE49 = [];
  struct = spawnStruct();
  struct.origin = (8425, 9656, 2212);
  struct.angles = (0, 32, 0);
  _id_C99DF96C1B95FE49[_id_C99DF96C1B95FE49.size] = struct;
  struct = spawnStruct();
  struct.origin = (8436, 9897, 1858);
  struct.angles = (0, 272, 0);
  _id_C99DF96C1B95FE49[_id_C99DF96C1B95FE49.size] = struct;
  struct = spawnStruct();
  struct.origin = (8431, 10139, 2075);
  struct.angles = (0, 267, 0);
  _id_C99DF96C1B95FE49[_id_C99DF96C1B95FE49.size] = struct;
  struct = spawnStruct();
  struct.origin = (7919, 10142, 2088);
  struct.angles = (0, 228, 0);
  _id_C99DF96C1B95FE49[_id_C99DF96C1B95FE49.size] = struct;

  foreach(_id_0E09373392EB59E0 in _id_C99DF96C1B95FE49)
  _id_0E09373392EB59E0 childthread _id_B584BD26C794C0BC();
}

_id_B584BD26C794C0BC() {
  while(level.players.size == 0)
    wait 1;

  origin = scripts\engine\utility::drop_to_ground(self.origin, 200, -250);
  childthread _id_26006D6955F78888::spawn_enemy_claymore(origin, self.angles);
}

_id_27322B3878E4F055() {
  self endon("disconnect");
  level endon("game_ended");

  if(!isPlayer(self)) {
    return;
  }
  player = self;
  soundalias = undefined;
  breathlevel = undefined;
  _id_65859F82944FD162 = undefined;

  if(player._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43 > 80)
    breathlevel = "01";
  else if(player._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43 > 60)
    breathlevel = "02";
  else if(player._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43 > 30)
    breathlevel = "03";
  else if(player._id_C3A0F3B16CCE4CA9._id_410DBF9EB4F2AE43 > 15)
    breathlevel = "04";
  else
    breathlevel = "05";

  if(isDefined(level.farah) && player == level.farah)
    _id_65859F82944FD162 = "farrah";
  else if(isDefined(level.price) && player == level.price)
    _id_65859F82944FD162 = "price";
  else
    _id_65859F82944FD162 = "gaz";

  soundalias = "dx_cp_raid1_" + _id_65859F82944FD162 + "_surfacing_breath_" + breathlevel;
  scripts\cp\cp_dialogue::play_vo_to_player(player, soundalias);
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5caec4f45b7f7605.gsc
***********************************************/

main() {
  if(!isDefined(game["restart_checkpoint"]))
    game["objectives_completed"] = undefined;

  if(isDefined(game["objectives_completed"])) {
    site = game["objectives_completed"];

    switch (site) {
      case "a":
        level.default_player_spawns = "checkpoint_spawner_a";
        break;
      case "b":
        level.default_player_spawns = "checkpoint_spawner_b";
        break;
      case "c":
        level.default_player_spawns = "checkpoint_spawner_c";
        break;
      default:
        level.default_player_spawns = "checkpoint_spawner_c";
        break;
    }
  } else {
    start = tolower(getDvar("start"));

    if(start == "exfil_area")
      level.default_player_spawns = "checkpoint_spawner_c";
    else
      level.default_player_spawns = "hydro_parachute_spawn_abc";
  }

  _id_91DF1C649A724F2B();
  level._id_1F9A4D8F7E4586BB = 1;
  level._id_3423C60CBB355C81 = 1;
  level.skip_nav_check_on_spectate_respawn = 1;
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_47B7445B595408F7", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("skydive_always_weapon_raise", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_5820CD337A0495F5", 1, 0);
  scripts\smartobjects\utility::init_smartobjects();
  scripts\cp_mp\utility\game_utility::registernightmap();

  if(getdvarint("dvar_758C85E3F85BA055", 1))
    scripts\cp\utility\player::overridevisionsetnightforlevel("nvg_base_color_hydro");
  else
    scripts\cp\utility\player::overridevisionsetnightforlevel("nvg_base_cp_hydro");

  _id_4FCAC5EE2403C31C::main();
  _id_01B28300F549B77E::main();
  _id_2C8A930B946F6B04::main();
  thread _id_41F1D2B91C165DB8::setup_functions();
  thread _id_1C0C872AA3BF0CB0::update_vfx_shadow_limit();
  scripts\cp\utility::add_start("stealth_container", undefined, ::_id_8EA228BABDBF10BA);
  scripts\cp\utility::add_start("exfil_area", undefined, ::_id_B0F6D6910F3B8AF8);
  thread _id_03436B3C09CB828B();

  if(level.createfx_enabled) {
    return;
  }
  scripts\cp\utility::coop_mode_enable(["sp_stealth"]);
  scripts\cp\utility::coop_mode_enable();
  _id_D525F1534752BFC7();
  _id_2CFEF434CE6A1C44();
  _id_279964C2C969DDA3();
  _id_3861EB0A004E0D38();
  _id_C4D555BF9485AC3B();
  level._id_1387AE867B17D83F = 1;
  thread scripts\cp\intel\cp_intel::intel_init();

  if(!isDefined(level.vehicle._id_AAB9695C92B0ED96))
    level.vehicle._id_AAB9695C92B0ED96 = [];
}

_id_2CFEF434CE6A1C44() {
  level._id_FC46CD90F0A40C87 = _id_3858411D0B73D352::_id_424183E9E991FBA4;
  level.callbackplayerlaststand = _id_0AFB7E332AEE4BF2::callback_playerlaststand;
  level.custom_onspawnplayer_func = ::onplayerspawned;
  level.custom_onplayerconnect_func = ::onplayerconnect;
  level.playermaxhealth = ::defaultplayermaxhealth;
  level.fnoffhandfire = _id_74502A9E0EF1F19C::ai_offhandfiremanager;
  level.post_customization_func = ::_id_3A16250F47BAECA6;
  level.maxagents = 48;
  level._id_633EE74E2649AAC7 = ::_id_633EE74E2649AAC7;
  level.disable_start_spawn_on_navmesh = 1;
  level._id_71AFB87754F28AF8 = ::_id_614DE4F5A6A2452F;
  level.onfirstlandcallback = ::_id_E3B9AC9F21349689;
  level.post_loadout_spawn_func = ::_id_E7F65C4152B55648;
  level._id_B8F29EA4E4DCA22A = ::targetmarkergroup_removefromgroupaction;
  level._id_88714F70DBEA9FE4 = ::onplayerdisconnect;
  level._id_193EACBF6D2D8179 = ::_id_C7455F9FAC560115;
}

_id_C7455F9FAC560115(player) {
  return 0;
}

_id_614DE4F5A6A2452F(itemtype, _id_3793828403C6873E) {
  if(istrue(level._id_1387AE867B17D83F)) {
    if(itemtype == 2) {
      slot = _id_531CB1BE084314F7::_id_4967838290CB31B9(_id_3793828403C6873E);
      _id_F4692D0892428480 = scripts\engine\utility::array_find(level.br_pickups.br_equipname, self.equipment[slot]);

      if(isDefined(_id_F4692D0892428480)) {
        if(issubstr(_id_F4692D0892428480, "geiger")) {
          _id_66122A002AFF5D57::_id_F0A8D592BDDE9818();
          self playlocalsound("br_pickup_deny");
          scripts\cp\cp_hud_message::showerrormessage("COOP_GAME_PLAY/CANNOT_DROP_MISSION_ITEM");
          thread _id_613662165F17A93A::_id_65C017643E8CF5A0();
          return 0;
        }
      }
    }

    if(itemtype == 10) {
      [lootid, quantity] = _id_531CB1BE084314F7::_id_6738846DA50730F1(_id_3793828403C6873E);

      if(lootid == 0)
        return 1;

      equipname = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);

      if(isDefined(equipname)) {
        if(issubstr(equipname, "geiger")) {
          thread _id_613662165F17A93A::_id_65C017643E8CF5A0();
          _id_66122A002AFF5D57::_id_F0A8D592BDDE9818();
          self playlocalsound("br_pickup_deny");
          scripts\cp\cp_hud_message::showerrormessage("COOP_GAME_PLAY/CANNOT_DROP_MISSION_ITEM");
          return 0;
        }
      }
    }
  }

  return 1;
}

_id_F022034D3185CA22() {
  _id_1A0FE414F9014246 = randomintrange(1, 6);

  switch (_id_1A0FE414F9014246) {
    case 1:
      _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_acst_lasw_11keepthatgeigercoun");
      break;
    case 2:
      _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_acst_lasw_12keepthatgeigercoun");
      break;
    case 3:
      _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_acst_lasw_keepthatgeigercounte");
      break;
    case 4:
      _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_acst_lasw_wedontknowwhattheobj");
      break;
    case 5:
      _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_acst_lasw_youneedthatgeigercou");
      break;
  }
}

_id_633EE74E2649AAC7(_id_8B065B1B8825808B) {
  if(istrue(_id_8B065B1B8825808B)) {
    game["objectives_completed"] = undefined;
    game["stealth_was_broken"] = undefined;
    game["alarms_triggered"] = undefined;
  }

  setDvar("start", "stealth_container");
  scripts\cp\cp_checkpoint::checkpoint_set("");
}

_id_EA15F64544CA8529() {
  wait 5;
  announcement("Ready for debug");
  player = level.players[0];
  value = getdvarint("dvar_2DDBA5D8A23C7E23", 0);
  _id_6AEC809BE13C61CC = value;

  for(;;) {
    if(value != _id_6AEC809BE13C61CC) {
      player thread _id_9E21709B337843D9(player, value);
      _id_6AEC809BE13C61CC = value;
    }

    wait 0.25;
    value = getdvarint("dvar_2DDBA5D8A23C7E23", 0);
  }
}

onplayerconnect(player) {
  player.gameskill = scripts\cp\cp_gameskill::get_gameskill();
  player scripts\cp\cp_gameskill::set_difficulty_from_locked_settings(2);
}

onplayerdisconnect(player) {
  if(istrue(player._id_9FC03D4C05F67987)) {
    level._id_21F3C3F7EADF3C57 = scripts\engine\utility::array_add(level._id_21F3C3F7EADF3C57, int(30));
    level._id_27856C6130F4DDCA = undefined;
    player._id_9FC03D4C05F67987 = undefined;
  } else {
    level._id_21F3C3F7EADF3C57 = scripts\engine\utility::array_add(level._id_21F3C3F7EADF3C57, int(20));
    level._id_4F59DD9DFFBD1F73 = undefined;
    player._id_7545BF2A64A655EC = undefined;
  }
}

setup_player_stealth() {
  self notify("setup_player_stealth");
  self endon("setup_player_stealth");
  self endon("disconnect");

  if(scripts\cp\coop_stealth::level_should_run_sp_stealth()) {
    scripts\engine\utility::flag_wait("level_stealth_initialized");
    scripts\stealth\player::main();

    if(getdvarint("dvar_38FC4761564144DC", 0) != 0)
      _func_531194F673A06DE5(1);
    else
      _func_531194F673A06DE5(0);

    thread scripts\cp\coop_stealth::suspicious_door_monitor();
  }
}

onplayerspawned() {
  thread _id_1A3033642418C706();
  thread setup_player_stealth();
  _id_7AB5B649FA408138::_id_0F1AED36AB4598EA("saba_cp_hydro");
  thread _id_5D7A5D368329104B();
  thread _id_5858717B36E2DC73();
  thread _id_3AE866A6DD08DAF9::_id_1B0D0F614DDF4A43();
  scripts\engine\utility::ent_flag_init("laser_spotted_player");

  if(isDefined(self.pers)) {
    if(!isDefined(self.pers["intel"]))
      self.pers["intel"] = 0;
  }

  if(!isDefined(game["objectives_completed"])) {
    start = tolower(getDvar("start"));

    if(start != "exfil_area") {
      if(!scripts\engine\utility::flag("cleared_to_play_intro_vo")) {} else {
        self setclientomnvar("ui_hide_bigmap", 0);
        self setclientomnvar("ui_show_tac_map", 1);
      }

      thread _id_0DD4001D1E4DCFC5();
      return;
    }
  } else
    self nightvisionviewon(1);
}

_id_1A3033642418C706() {
  self notify("vo_toggleBcWhenPlayersAreNotInCombat");
  self endon("vo_toggleBcWhenPlayersAreNotInCombat");
  self endon("disconnect");

  for(;;) {
    waitframe();

    if(_func_8CE5803B7D377D72(self) == 1 || _func_EAC0CD99C9C6D8EE() == "spotted") {
      self.bcdisabled = undefined;
      continue;
    }

    _id_8881ECC9E8DD1E67 = scripts\engine\utility::getclosest(self.origin, getaiarray("axis"), 1000);

    if(isDefined(_id_8881ECC9E8DD1E67))
      self.bcdisabled = 1;
    else
      self.bcdisabled = undefined;
  }
}

_id_61E0B726DBE0C9BD() {
  return istrue(self.bcdisabled);
}

_id_BFEAA60EB5F7E2F3() {
  self endon("death");

  for(;;)
    wait 1;
}

_id_279964C2C969DDA3() {
  if(!scripts\engine\utility::flag_exist("scriptables_ready"))
    scripts\engine\utility::flag_init("scriptables_ready");

  scripts\cp_mp\utility\game_utility::registerlargemap();
  scripts\vehicle\mindia8::main("veh8_mil_air_mindia8_open_back_playerride", "mindia8_minimap", "script_vehicle_iw8_mindia8_playerride");
  level thread _id_56EF8D52FE1B48A1::init_super();
  level._id_028BCDD92F005721 = 0;
  scripts\cp\cp_gameskill::init_gameskill();
  level thread scripts\cp\cp_movers::main();
  _id_780514F14B1134ED::_id_957D3897064478FF();
  level thread _id_390BB92B200E27FA::_id_B1E1270400324B2C();
  scripts\cp\utility::_id_B4CA8A0FC3169F35();

  if(getdvarint("scr_skip_infils", 0) == 1)
    scripts\engine\utility::flag_set("infil_complete");
  else {
    checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

    if(!isDefined(checkpoint) || checkpoint == "") {}

    scripts\engine\utility::flag_set("infil_complete");
  }

  _func_36B8314B47A6A7DF(1);
}

_id_3861EB0A004E0D38() {
  _id_6FFC63D2AC18AABE();
  level.objectivesfunc = ::levelobjectives_init;
  level thread scripts\cp\cp_objectives::objectives_init();
  level.get_bleed_out_time = ::_id_840A5E4F7961DF6B;
}

_id_840A5E4F7961DF6B() {
  return undefined;
}

_id_6FFC63D2AC18AABE() {}

_id_C4D555BF9485AC3B() {
  if(scripts\cp\cp_relics::is_relic_active("relic_oneInTheChamber")) {
    scripts\cp_mp\utility\script_utility::registersharedfunc("game", "checkpoint_set", ::_id_42D6477866DDFA66);
    _id_1E22D314CC16F807::_id_A133C2FF48B59DD7("scripted");

    if(isDefined(game["alarms_triggered"])) {
      [_id_CD673A4C98138C74, _id_F8375DAC9AA7968E, _id_E1275A0810098760] = scripts\cp\coop_stealth::_id_A38FAD5164D90667();

      if(game["alarms_triggered"] >= _id_F8375DAC9AA7968E) {
        if(game["alarms_triggered"] >= _id_CD673A4C98138C74)
          _id_1E22D314CC16F807::_id_26DC2F0B0BD90E86(1);
        else
          _id_1E22D314CC16F807::_id_26DC2F0B0BD90E86(2);

        level._id_1D4C5A0449D1C023 = game["alarms_triggered"];
        setomnvar("num_bombs_planted", game["alarms_triggered"]);
      }
    } else {
      _id_1E22D314CC16F807::_id_26DC2F0B0BD90E86(3);
      setomnvar("num_bombs_planted", 0);
    }
  }

  level._id_5966C39CB60075F1 = ::_id_EAED11F8AA2BFE58;
  scripts\cp\cp_snakecam::_id_D63C50E6896930EA("nvg_base_color_hydro");
  scripts\cp\utility::_id_BB3E0C926B0667C4("exfil_area,stealth_container");
  _id_9EAA4CAF3C05202D();
  setDvar("dvar_8663F57403D7BD15", 2);
  setDvar("dvar_17C69FFF0DF1C8BD", 1);
  setDvar("dvar_BD445B33649DDB33", 1);
  setDvar("dvar_FA53D7293EC88067", 1);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_B80F97B9C08F17F5", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_F5740209893CDF46", 1, 0);
  thread scripts\cp\coop_stealth::_id_778F9D9E0731E729();
  level._id_34867328231CA54B = 100;
  level._id_BF6C149BC4124962 = 1;
  _id_12E2FB553EC1605E::_id_E2D370937C694C58("iw9_dm_xmike2010_mp", ["silencer", "laser"], "iw9_sm_apapa_mp", ["silencer", "laser"]);
  _id_12E2FB553EC1605E::_id_EBF2582B122904FC("equip_throwing_knife", "equip_geigercounter");
  setup_create_script();
  level thread _id_FC4803DC319A81D2();
  scripts\cp\compass::setupminimap("compass_map_cp_hydro", 2);
  _id_8F861516AC2B8347();

  if(scripts\cp\coop_stealth::level_should_run_sp_stealth())
    scripts\engine\utility::flag_set("level_stealth_initialized");

  level._id_E9363E4BB08955E4 = "hvt_region_spawners";

  if(_id_17CA3AF80F14CE7E::_id_5E1050E3208C8C06())
    thread _id_17CA3AF80F14CE7E::_id_2B1E89BBEBAB6964();

  if(_id_476B6443E3798F5E::_id_AB29F5844AA437FB())
    thread _id_476B6443E3798F5E::_id_B661F9FCA2D11CDB();

  if(_id_0BE6CB102C46939E::_id_777C44BDFC80C0BB())
    thread _id_0BE6CB102C46939E::_id_ADA79477E276D617();

  level thread _id_F98BF6B7B70B76AA();
  _id_2ECF1DD833850F15::_id_B04F37F19C6631E0();
  _id_613662165F17A93A::_id_032566017AA4406B();
  level._id_A8DC22C62BA69B88["chase_truck"] = _id_3F36F922FAC89B88::_id_D7675700AAA4AA7B;
  level._id_A8DC22C62BA69B88["patrolling_truck"] = _id_3F36F922FAC89B88::_id_17FC1AB81CB61842;
  level._id_A8DC22C62BA69B88["ammo_cache"] = _id_0F3B4A4783EDE654::_id_0F55C14F9168585A;
}

_id_42D6477866DDFA66() {
  if(isDefined(level._id_1D4C5A0449D1C023))
    game["alarms_triggered"] = level._id_1D4C5A0449D1C023;
}

_id_8EA228BABDBF10BA() {
  scripts\cp\cp_objectives::run_objective("stealth_container");
}

_id_B0F6D6910F3B8AF8() {
  if(istrue(level._id_AC775ED66AAEB771)) {
    return;
  }
  scripts\cp\cp_objectives::run_objective("exfil_area");
}

setup_create_script() {
  scripts\common\create_script_utility::init_create_script_for_level();
  scripts\common\create_script_utility::register_create_script_arrays("cp_hydro_create_script", "cp_hydro_create_script", level.scripted_spawner_func.size, _id_141BF091275CDDE0::main);
}

_id_FC4803DC319A81D2() {
  level thread wait_for_pre_game_period();
  level thread wait_for_strike_init_complete();
  level thread _id_96A92DD02CA90C97();
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

  wait 1;
  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(isDefined(checkpoint) && checkpoint != "" && isDefined(level.registered_checkpoint_funcs[checkpoint]))
    level thread[[level.registered_checkpoint_funcs[checkpoint]]]();

  wait 4;
  scripts\engine\utility::flag_init("stealth_music_pause");

  if(getdvarint("dvar_F5740209893CDF46", 0))
    level thread scripts\stealth\init::set_stealth_mode(1, "", "mx_cp_hydro_stealth_spotted");
  else
    level thread scripts\stealth\init::set_stealth_mode(1, "", "mx_tmp_estate_hallwayrun");
}

_id_C2A86F682BF1AB71() {
  level.objectives_table = "cp/cp_hydro_objectives.csv";
  level.objectivesmatrixtable = "cp/cp_hydro_objectives_matrix.csv";
  level.objectiveregistration = ::_id_77765E5DD4C9DB54;
  scripts\cp\cp_objectives::parseobjectivestable(level.objectives_table);
}

_id_77765E5DD4C9DB54() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  scripts\engine\utility::flag_wait("objective_table_parsed");
}

_id_D525F1534752BFC7() {
  if(!isDefined(anim._id_463C0093DFF0F81C))
    anim._id_463C0093DFF0F81C = [];

  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_2D950B6324A825D9", 1, 0);
  scripts\engine\utility::flag_set("infil_complete");
}

_id_EF24852E3DD47373() {
  scripts\cp\cp_player_battlechatter::registerbcsoundtype("stat_8545DA6DD67C6763", "enum_5137F98B1BA67374", 1.0, 1.0);
  scripts\cp\cp_player_battlechatter::registerbcsoundtype("stat_2DD6D8E505E44F82", "enum_75B8C3D3B48D9E11", 1.0, 1.0);
  scripts\cp\cp_player_battlechatter::registerbcsoundtype("stat_518DBCC3021DB184", "enum_2516215B5DEEE881", 1.0, 1.0);
  scripts\cp\cp_player_battlechatter::registerbcsoundtype("stat_C75CFEA420D58A45", "enum_7C7103C7C4C29DE2", 1.0, 1.0);
  scripts\cp\cp_player_battlechatter::registerbcsoundtype("stat_128194340206E3B1", "enum_65B3F12A06792B12", 1.0, 1.0);
  scripts\cp\cp_player_battlechatter::registerbcsoundtype("stat_280D5C45C1521302", "enum_09FFEB50A501BDD3", 1.0, 1.0);
}

_id_03436B3C09CB828B() {
  thread _id_E0125729CABDA438();
  thread _id_EF24852E3DD47373();
  _id_23502CEE3FA89FC2::_id_6BFAF3AC92CA133A();
  setDvar("dvar_4F84BC7BB1801DC0", 1);
  setDvar("dvar_E1CC4FA6A0EDE111", 1);
  setDvar("dvar_445A9F67C9BA0CAB", 666);
  setdvarifuninitialized("dvar_9804C42649D377C6", 0);
  setdvarifuninitialized("dvar_BCE38029084A7EB5", 0.1);
  setdvarifuninitialized("dvar_CD55457316748B46", 20);
  setDvar("dvar_F8332F8A8CEDCA1C", 1);
  setdvarifuninitialized("scr_player_maxhealth", 100);
  setdvarifuninitialized("dvar_304D06530BF638B0", 1);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_296C4DCD03CEE72B", 1, 0);
  setdvarifuninitialized("dvar_C564069EC13375CB", 1);
  setdvarifuninitialized("dvar_0770339DF7C5B6CA", 1);
  setdvarifuninitialized("dvar_EB2F6D009F65CB77", 1);
  setdvarifuninitialized("dvar_884081E00DE21B0C", 1);
  setdvarifuninitialized("dvar_2D59DEB63C029EA8", 1);
  setDvar("dvar_52500D90411D2058", 1656);
  setDvar("dvar_3C1BE1756FB521C7", 1536);
  setDvar("dvar_B70103E1C59E5DBD", 1400);
  setDvar("dvar_FF951E1686E0157C", 1280);
  setDvar("dvar_FA1BA7EA176F6C82", 1024);
  setdvarifuninitialized("dvar_3BD8C43F07F76C70", 1);
  setdvarifuninitialized("dvar_8176A27457E933CC", 1);
  setdvarifuninitialized("dvar_E637894E145488A7", 0);
  setdvarifuninitialized("dvar_E410C11BCB9D47E6", 0);
  setdvarifuninitialized("dvar_9A8052AC099141AF", 1);
  setdvarifuninitialized("dvar_E9B58655E7876F05", 1);
  setDvar("r_spotLightEntityShadows", 1);
  scripts\cp\utility::_id_0C72FF775CD61B11("scr_parachute_redeploy_min_height", 666, 256);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_B14F25E83A3E8215", 1, 0);
  _id_56EF8D52FE1B48A1::init_super();
  level._id_21F3C3F7EADF3C57 = [];
  level._id_21F3C3F7EADF3C57[level._id_21F3C3F7EADF3C57.size] = 30;
  level._id_21F3C3F7EADF3C57[level._id_21F3C3F7EADF3C57.size] = 20;
  level._id_21F3C3F7EADF3C57[level._id_21F3C3F7EADF3C57.size] = 10;
  level._id_8ACA98661B1886B1 = 1;
  level._id_79928EC6A4845A9C = 1;
  level._id_004B47EEDAC44A48 = 180;
}

_id_E0125729CABDA438() {
  _id_0E80538EF14D00E1::register_combined_vehicles(_id_2F9A1176C2E0CD08::main, "veh8_mil_lnd_atango_physics", "veh9_atango_physics_sp", "script_vehicle_iw9_atango_physics", undefined, "atango_ai", "atango_ai");
  _id_0E80538EF14D00E1::register_combined_vehicles(scripts\vehicle\techo::main, "veh8_civ_lnd_techo_rebel_physics", "veh9_techo_physics_cp", "script_vehicle_iw9_truck_techo_rebel", undefined, "techo_ai", "techo_ai");
  _id_0E80538EF14D00E1::register_combined_vehicles(scripts\vehicle\lbravo::main, "veh8_mil_air_lbravo", "lbravo_infil_cp", "script_vehicle_iw8_lbravo_c4", undefined, "lbravo_c4", "lbravo_c4");
  _id_0E80538EF14D00E1::register_combined_vehicles(_id_3AF63BEEAAB2E0A7::main, "veh9_civ_lnd_techo_rebel_armor_cp", "veh9_techo_physics_cp", "script_vehicle_iw9_truck_techo_rebel_armor", undefined, "techo_ai_armor", "techo_ai_armor");
  _id_4BEC22BA9253C63C::main("veh9_mil_lnd_jltv_turret_vehphys_mp", "veh9_jltv_physics_sp", "script_vehicle_iw9_jltv_turret_physics");

  if(!scripts\engine\utility::flag_exist("create_script_initialized"))
    scripts\engine\utility::flag_init("create_script_initialized");

  scripts\engine\utility::flag_wait("create_script_initialized");
}

_id_F98BF6B7B70B76AA() {
  _id_703FDBB02501D31E::_id_38924FB7672B340D("brloot_ammo_762", 40);
  _id_703FDBB02501D31E::_id_38924FB7672B340D("brloot_ammo_rocket", 10);
  _id_703FDBB02501D31E::_id_38924FB7672B340D("brloot_ammo_rocket_rpg_ai", 100);
  _id_703FDBB02501D31E::_id_38924FB7672B340D("brloot_ammo_919", 40);
  _id_703FDBB02501D31E::_id_38924FB7672B340D("brloot_ammo_50cal", 30);
  _id_703FDBB02501D31E::_id_38924FB7672B340D("brloot_ammo_12g", 10);
  _id_703FDBB02501D31E::_id_38924FB7672B340D("drop_random_ammo_types", 50);
}

_id_96A92DD02CA90C97() {
  level waittill("level_systems_loaded");
  scripts\cp\cp_gameskill::_id_2B72A5CF9E5597F9(1);
  scripts\cp\cp_gameskill::updategameskill();
  scripts\cp\cp_gameskill::updatealldifficulty();
}

_id_3A16250F47BAECA6() {
  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.execution))
    scripts\cp_mp\execution::_giveexecution(self.operatorcustomization.execution);

  if(!scripts\cp\utility::is_raid_gamemode() && !istrue(level.dogtag_revive)) {
    self skydive_beginfreefall();

    if(getdvarint("dvar_1755EF863BAF2D58", 0) != 0) {
      self skydive_setforcethirdpersonstatus(1);
      self skydive_deployparachute();
      thread _id_B680439514992C9C();
    }

    scripts\cp\utility::allow_player_basejumping(1, "hydro_post_customization");
  }

  if(!scripts\engine\utility::flag_exist("player_spawned_with_loadout"))
    scripts\engine\utility::flag_init("player_spawned_with_loadout");

  scripts\engine\utility::flag_set("player_spawned_with_loadout");

  if(!scripts\engine\utility::ent_flag_exist("player_spawned_with_loadout"))
    scripts\engine\utility::ent_flag_init("player_spawned_with_loadout");

  scripts\engine\utility::ent_flag_set("player_spawned_with_loadout");

  if(getdvarint("dvar_2D950B6324A825D9", 0) != 0)
    self nightvisionviewon();

  if(getdvarint("dvar_585589DF68844733", 0) != 0)
    thread _id_23502CEE3FA89FC2::_id_ED2A70219724DA49();
}

_id_B680439514992C9C() {
  self endon("death");
  self notify("para3pWatcher");
  self endon("para3pWatcher");
  _id_AE45F441D9699C77 = getdvarint("dvar_7C9E3EB0EF5A532E", 10);
  wait(_id_AE45F441D9699C77);
  self skydive_beginfreefall();
  delay = getdvarint("dvar_730D0E72A18BD378", 5);
  wait(delay);
  self skydive_setforcethirdpersonstatus(0);
}

_id_9E21709B337843D9(player, _id_887D4CB1410C4FFC) {
  if(_id_887D4CB1410C4FFC == 30) {
    level._id_27856C6130F4DDCA = 1;
    player._id_9FC03D4C05F67987 = 1;
  } else {
    level._id_4F59DD9DFFBD1F73 = 1;
    player._id_7545BF2A64A655EC = 1;
  }

  player.operatorcustomization.gender = _id_12E2FB553EC1605E::getoperatorgender(_id_887D4CB1410C4FFC);
  player.operatorcustomization.skinref = _id_887D4CB1410C4FFC;
  body = tablelookup("operatorskins.csv", 0, _id_887D4CB1410C4FFC, 4);
  head = tablelookup("operatorskins.csv", 0, _id_887D4CB1410C4FFC, 5);
  operator = tablelookup("operatorskins.csv", 0, _id_887D4CB1410C4FFC, 2);
  suit = tablelookup("operators.csv", 1, operator, 19);
  player.operatorcustomization.suit = suit;

  if(body == "" || head == "") {
    return;
  }
  player._id_B05E0E6E083DA4D4 = _id_887D4CB1410C4FFC;
  _id_41BD2EEDA1C033D2 = _id_12E2FB553EC1605E::getplayerviewmodelfrombody(body);
  player setcustomization(body, head);
  bodymodelname = player getcustomizationbody();
  headmodelname = player getcustomizationhead();
  _id_41BD2EEDA1C033D2 = player getcustomizationviewmodel();

  if(player.operatorcustomization.suit == "iw9_defaultsuit_mp")
    player.operatorcustomization.suit = "iw9_suit_cp";

  player scripts\cp\utility\player::_setsuit(player.operatorcustomization.suit);
  player setcharactermodels(bodymodelname, headmodelname, _id_41BD2EEDA1C033D2);
  _id_E89FD4C2E2E797B9 = player _id_12E2FB553EC1605E::getplayerfoleytype(_id_887D4CB1410C4FFC);

  if(_id_E89FD4C2E2E797B9 == "")
    _id_E89FD4C2E2E797B9 = "vestlight";

  player setclothtype(_id_E89FD4C2E2E797B9);

  if(player.operatorcustomization.gender == "female")
    self _meth_555E2D32E2756625("female");

  player.operatorcustomization.voice = _id_12E2FB553EC1605E::getoperatorvoice(operator);
  player.operatorcustomization.clothtype = _id_12E2FB553EC1605E::getoperatorclothtype(_id_887D4CB1410C4FFC);
  player.operatorcustomization.superfaction = _id_12E2FB553EC1605E::getoperatorsuperfaction(operator);
  player.operatorcustomization.execution = _id_12E2FB553EC1605E::getoperatorexecution(operator);
  player.operatorcustomization.executionquip = _id_12E2FB553EC1605E::getoperatorexecutionquip(operator);
}

setcharactermodels(bodymodelname, headmodelname, _id_41BD2EEDA1C033D2) {
  if(isDefined(self.headmodel))
    self detach(self.headmodel);

  if(!isagent(self)) {
    bodymodelname = self getcustomizationbody();
    headmodelname = self getcustomizationhead();
    _id_41BD2EEDA1C033D2 = self getcustomizationviewmodel();
  }

  self setModel(bodymodelname);
  self setviewmodel(_id_41BD2EEDA1C033D2);

  if(isDefined(headmodelname)) {
    self attach(headmodelname, "", 1);
    self.headmodel = headmodelname;
  }
}

_id_EAED11F8AA2BFE58(_id_86DB2022C4F0F4BF, _id_185EA69B2FE37360, _id_7CB3CE39E2414126, _id_9B02313FE7FF70DA) {
  self visionsetthermalforplayer("flir_2_color_gradient");
  scripts\common\utility::trycall(level.perkunsetfuncs["specialty_tracker"]);
  scripts\common\utility::trycall(level.perkunsetfuncs["specialty_tracker_pro"]);
  scripts\common\utility::trycall(level.perkunsetfuncs["specialty_huntmaster"]);
  scripts\cp\utility::giveperk("specialty_sixth_sense");
  scripts\cp\utility::giveperk("specialty_hack");
  thread scripts\cp\execution::_id_94C333BD965E6685();

  if(istrue(self._id_A8440DA4D5F5A9AD)) {
    return;
  }
  scripts\cp\utility::allow_player_basejumping(1, "give_loadout_override");
  _id_C64B92D56EC838B3 = scripts\cp\loot_system::get_empty_munition_slot(self);
  _id_644C18834356D9DC::give_munition_to_slot("nvg", _id_C64B92D56EC838B3);
  self.pers["useNVG"] = 1;
  _id_644C18834356D9DC::check_for_empty_munitions();
  _id_644C18834356D9DC::assign_highest_full_slot_to_active();
  self.munition_splash_supress = undefined;
  _id_5E5507D57BBBB709::_id_4A1FD54AFFDAA367("recon_drone", 1, 1, 1);
  self._id_A8440DA4D5F5A9AD = 1;
  _id_531CB1BE084314F7::br_forcegivecustompickupitem(self, "brloot_offhand_semtex", 0, 2, 0, 0);
}

levelobjectives_init() {
  level.objectives_table = "cp/cp_hydro_objectives.csv";
  level.objectivesmatrixtable = "cp/cp_hydro_objectives_matrix.csv";
  level.objectiveregistration = ::_id_77765E5DD4C9DB54;
  scripts\cp\cp_objectives::parseobjectivestable(level.objectives_table);
}

targetmarkergroup_removefromgroupaction(timeout, _id_C8462289EDFC0ACA) {
  entnum = self getxuid();
  _id_C8462289EDFC0ACA endon("ent_removed_" + entnum);
  level endon("removed_targetMarkerGroup_" + _id_C8462289EDFC0ACA.markerid);

  if(!isDefined(timeout)) {
    return;
  }
  wait(timeout);
  scripts\cp_mp\targetmarkergroups::targetmarkergroup_unmarkentity(self, _id_C8462289EDFC0ACA.markerid);
}

_id_0DD4001D1E4DCFC5() {
  self endon("disconnect");
  level endon("game_ended");

  if(!scripts\engine\utility::ent_flag_exist("player_spawned_with_loadout"))
    scripts\engine\utility::ent_flag_init("player_spawned_with_loadout");

  scripts\engine\utility::ent_flag_wait("player_spawned_with_loadout");

  if(istrue(self._id_544210FBCDDBB97B) && level.players.size > 1) {
    if(isDefined(self.pers)) {
      if(isDefined(self.pers["intel"]) && self.pers["intel"] > 0) {
        if(!scripts\engine\utility::flag_exist("laser_arrays_setup"))
          scripts\engine\utility::flag_init("laser_arrays_setup");

        scripts\engine\utility::flag_wait("laser_arrays_setup");

        if(isDefined(self.pers)) {
          if(isDefined(self.pers["intel"]) && self.pers["intel"] > 0) {
            _id_8164F8B29CDABF6A = scripts\engine\utility::getStructArray("laserarray_origin", "script_noteworthy");
            _id_31B87E5786093E10 = scripts\engine\utility::get_array_of_closest(self.origin, _id_8164F8B29CDABF6A, undefined, 24, 2048);

            foreach(laser in _id_31B87E5786093E10)
            laser notify("laser_destroyed");
          }
        }

        return;
      }
    }

    if(isDefined(level._id_D0ADA23E81337306) && level._id_D0ADA23E81337306.size > 0) {
      if(!scripts\engine\utility::flag_exist("laser_arrays_setup"))
        scripts\engine\utility::flag_init("laser_arrays_setup");

      scripts\engine\utility::flag_wait("laser_arrays_setup");

      if(isDefined(self.pers)) {
        if(isDefined(self.pers["intel"]) && self.pers["intel"] > 0) {
          _id_8164F8B29CDABF6A = scripts\engine\utility::getStructArray("laserarray_origin", "script_noteworthy");
          _id_31B87E5786093E10 = scripts\engine\utility::get_array_of_closest(self.origin, _id_8164F8B29CDABF6A, undefined, 24, 2048);

          foreach(laser in _id_31B87E5786093E10)
          laser notify("laser_destroyed");
        }
      }

      return;
    }

    checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

    if(checkpoint != "") {
      return;
    }
    if(!istrue(self._id_86B400F3BC4F6255)) {
      _id_1925D24D0AE333E6 = scripts\engine\utility::getStructArray("hydro_stealth_spawn_abc", "targetname");

      if(!istrue(level._id_0843D8B9846DF884))
        _id_1925D24D0AE333E6 = scripts\engine\utility::getStructArray("hydro_parachute_spawn_abc", "targetname");
      else
        _id_1925D24D0AE333E6 = scripts\engine\utility::getStructArray("hydro_stealth_spawn_abc", "targetname");

      index = self getentitynumber();
      _id_1925D24D0AE333E6[index].angles = scripts\engine\utility::ter_op(isDefined(_id_1925D24D0AE333E6[index].angles), _id_1925D24D0AE333E6[index].angles, (0, 0, 0));
      _id_0310B7A0412AAEAD = _id_1925D24D0AE333E6[index];

      if(level.players.size > 1)
        self setOrigin(_id_0310B7A0412AAEAD.origin, 1);

      self._id_86B400F3BC4F6255 = undefined;
    }

    return;
  }

  if(getdvarint("dvar_9A8052AC099141AF") != 0) {
    if(isDefined(self.pers)) {
      if(isDefined(self.pers["intel"]) && self.pers["intel"] > 0) {
        if(!scripts\engine\utility::flag_exist("laser_arrays_setup"))
          scripts\engine\utility::flag_init("laser_arrays_setup");

        scripts\engine\utility::flag_wait("laser_arrays_setup");

        if(isDefined(self.pers)) {
          if(isDefined(self.pers["intel"]) && self.pers["intel"] > 0) {
            _id_8164F8B29CDABF6A = scripts\engine\utility::getStructArray("laserarray_origin", "script_noteworthy");
            _id_31B87E5786093E10 = scripts\engine\utility::get_array_of_closest(self.origin, _id_8164F8B29CDABF6A, undefined, 24, 2048);

            foreach(laser in _id_31B87E5786093E10)
            laser notify("laser_destroyed");
          }
        }

        return;
      }
    }

    if(isDefined(level._id_D0ADA23E81337306) && level._id_D0ADA23E81337306.size > 0) {
      if(!scripts\engine\utility::flag_exist("laser_arrays_setup"))
        scripts\engine\utility::flag_init("laser_arrays_setup");

      scripts\engine\utility::flag_wait("laser_arrays_setup");

      if(isDefined(self.pers)) {
        if(isDefined(self.pers["intel"]) && self.pers["intel"] > 0) {
          _id_8164F8B29CDABF6A = scripts\engine\utility::getStructArray("laserarray_origin", "script_noteworthy");
          _id_31B87E5786093E10 = scripts\engine\utility::get_array_of_closest(self.origin, _id_8164F8B29CDABF6A, undefined, 24, 2048);

          foreach(laser in _id_31B87E5786093E10)
          laser notify("laser_destroyed");
        }
      }

      return;
    }

    checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

    if(checkpoint != "") {
      return;
    }
    _id_0C973260F1E32269();
  }
}

_id_E3B9AC9F21349689(_id_6D2BAD4E4EB8DFBC) {
  if(scripts\cp\cp_objectives::is_objective_active("exfil_area")) {
    return;
  }
  start = tolower(getDvar("start"));

  if(start == "exfil_area") {
    return;
  }
  scripts\cp\utility::allow_player_basejumping(1, "hydro_first_land");
  thread _id_613662165F17A93A::_id_D672E33250D61C2D();
  scripts\cp\utility::_id_4CBAED764C116A25(0);
}

_id_E7F65C4152B55648() {
  if(!scripts\engine\utility::flag_exist("laser_arrays_setup"))
    scripts\engine\utility::flag_init("laser_arrays_setup");

  scripts\engine\utility::flag_wait("laser_arrays_setup");

  if(isDefined(self.pers)) {
    if(isDefined(self.pers["intel"]) && self.pers["intel"] > 0) {
      _id_8164F8B29CDABF6A = scripts\engine\utility::getStructArray("laserarray_origin", "script_noteworthy");
      _id_31B87E5786093E10 = scripts\engine\utility::get_array_of_closest(self.origin, _id_8164F8B29CDABF6A, undefined, 24, 2048);

      foreach(laser in _id_31B87E5786093E10)
      laser notify("laser_destroyed");
    }
  }
}

_id_5858717B36E2DC73() {
  self notify("third_person_hint_monitor");
  self endon("third_person_hint_monitor");
  self endon("disconnect");
  scripts\engine\utility::flag_wait("cleared_to_play_intro_vo");
  player = self;

  for(;;) {
    wait 5;

    if(istrue(level._id_AC775ED66AAEB771)) {
      return;
    }
    if(istrue(player._id_4A92FA61D642BC3C)) {
      return;
    }
    if(!player isonground()) {
      continue;
    }
    if(isDefined(player._id_B048AD4FDB04DD40)) {
      continue;
    }
    if(istrue(player._id_6863ACEA0BD6BF64)) {
      continue;
    }
    if(_func_EAC0CD99C9C6D8EE() == "spotted") {
      continue;
    }
    if(!player _meth_C1092F42B6BBE490() && !isDefined(player._id_59BE4F978F28AE72))
      player thread _id_522C905CE92D1A76::_id_1FFF43B972955992();
  }
}

_id_5D7A5D368329104B() {
  self notify("nvg_hint_monitor");
  self endon("nvg_hint_monitor");
  self endon("disconnect");
  player = self;
  scripts\engine\utility::flag_wait("laswell_infil_briefing_done");

  for(;;) {
    wait 2;

    if(istrue(level._id_AC775ED66AAEB771)) {
      return;
    }
    if(istrue(player._id_2825B40BC5D1EE90)) {
      return;
    }
    if(istrue(player._id_4D572A54ED8571C4)) {
      return;
    }
    if(isDefined(player._id_59BE4F978F28AE72)) {
      continue;
    }
    if(!player isonground()) {
      continue;
    }
    if(istrue(player._id_6863ACEA0BD6BF64)) {
      continue;
    }
    if(_func_EAC0CD99C9C6D8EE() == "spotted") {
      continue;
    }
    if(!player isnightvisionon() && !isDefined(player._id_B048AD4FDB04DD40))
      player thread _id_522C905CE92D1A76::_id_997763E2011CFF7A();
  }
}

_id_9DF4608032376B69(_id_0310B7A0412AAEAD) {
  self endon("disconnect");
  self._id_6863ACEA0BD6BF64 = undefined;
  self _meth_BC667001F9DD3808(_id_0310B7A0412AAEAD.origin);
  self setallstreamloaddist(0);
  self dontinterpolate();
  self skydive_beginfreefall();

  if(getdvarint("dvar_1755EF863BAF2D58", 0) != 0) {
    self skydive_setforcethirdpersonstatus(1);
    self skydive_deployparachute();
    thread _id_B680439514992C9C();
  }

  thread scripts\cp_mp\parachute::startfreefall(2, 0, undefined, undefined, 0, 0);
  thread _id_2118CD9A1625964F();

  while(!self ispredictedstreamposready())
    wait 0.5;

  self clearpredictedstreampos();
}

_id_2118CD9A1625964F() {
  self endon("death");
  self endon("disconnect");
  self notify("vo_watchForDzWithinFOV");
  self endon("vo_watchForDzWithinFOV");
  self endon("moved_far_away_from_dz");
  level endon("one_player_saw_lz");

  for(;;) {
    waitframe();

    if(scripts\engine\utility::within_fov(self getEye(), self getplayerangles(), level._id_5E5D0BB4EF6EC41F.origin, cos(65)))
      thread _id_613662165F17A93A::_id_07D93773035E730C(self);
  }
}

defaultplayermaxhealth() {
  return getdvarint("scr_player_maxhealth", 100);
}

_id_9EAA4CAF3C05202D() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("vo", "onPing", _id_7E1A468DA43087E3::_id_929BB46251E5E4F2);
}

_id_B33CB337B3E7001A() {
  level endon("game_ended");
  start = tolower(getDvar("start"));

  if(start == "exfil_area") {
    return;
  }
  if(scripts\cp\cp_objectives::is_objective_active("exfil_area")) {
    return;
  }
  if(isDefined(game["objectives_completed"])) {
    scripts\engine\utility::flag_set("cleared_to_play_intro_vo");
    scripts\engine\utility::flag_set("laswell_intro_vo_done");
    scripts\engine\utility::flag_set("laswell_infil_briefing_done");
    infil_struct = scripts\engine\utility::getStructArray("hydro_parachute_spawn_abc", "targetname")[0];
    level._id_CA39B64FE98D1BD2 = scripts\engine\utility::getclosest(infil_struct.origin, level._id_F3AF0989226D9CF0, 666);
    _id_C783F70D16243559 = getEntArray("infil_interactables", "script_noteworthy");

    foreach(ent in _id_C783F70D16243559) {
      if(isDefined(ent))
        ent delete();
    }

    if(isDefined(level._id_CA39B64FE98D1BD2))
      level._id_CA39B64FE98D1BD2 scripts\cp_mp\killstreaks\airdrop::deletecrate(0.05);

    return;
  }

  scripts\engine\utility::flag_wait("intro_binks_complete");
  _id_A74D682E98DA3BB9();

  if(scripts\cp\cp_relics::is_relic_active("relic_oneInTheChamber")) {} else
    thread _id_613662165F17A93A::_id_510DCDCBF4FC993C();

  foreach(player in level.players) {
    player scripts\cp\utility::allow_player_ignore_me(1);
    player thread _id_592687BBE4844AB0();
    player setclientomnvar("ui_radar_blocked", 1);
  }

  level thread _id_8F9FE25C427BF1D1();
  level._id_CA39B64FE98D1BD2 = scripts\engine\utility::getclosest(level.players[0].origin, level._id_F3AF0989226D9CF0, 666);
  level._id_BF8F84AC20A265E7 = getentarrayinradius("script_model", "code_classname", (-2514.54, 4780.81, -1147), 666, 1);

  if(isDefined(level._id_BF8F84AC20A265E7)) {
    foreach(_id_317FD4FD03F0A8B4 in level._id_BF8F84AC20A265E7) {
      if(_id_317FD4FD03F0A8B4.model == "veh9_mil_air_cargo_plane") {
        level._id_CC3D86BA33BC302D = _id_317FD4FD03F0A8B4;
        playFXOnTag(level._effect["infil_clouds_by_plane_windows_fx"], _id_317FD4FD03F0A8B4, "tag_body_animate");
      }
    }
  }

  foreach(player in level.players)
  player.disable_super = 1;

  level.no_aerial_munitions = 1;

  if(!istrue(game["map_restarted"]))
    wait 2;

  if(istrue(game["map_restarted"])) {
    scripts\engine\utility::flag_set("laswell_infil_briefing_done");
    scripts\engine\utility::flag_set("iodine_pills_taken");
    scripts\engine\utility::flag_set("players_infil_briefing_done");

    foreach(player in level.players)
    player.disable_super = 1;
  } else {
    _id_908CC9CAE0CB4FE0();

    foreach(player in level.players)
    player thread _id_613662165F17A93A::_id_EAE8042E1B821D04();

    scripts\engine\utility::flag_wait("iodine_pills_taken");
    wait 0.75;
    _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_ntro_lasw_youreclearedtodrop");
    _id_613662165F17A93A::_id_57A8C25A4A5F3B82();
    wait 1;
    scripts\engine\utility::flag_set("players_infil_briefing_done");
  }

  thread _id_2DE98F1598880AD9();
}

_id_592687BBE4844AB0() {
  self endon("disconnect");
  level endon("game_ended");

  if(!scripts\engine\utility::ent_flag_exist("intro_binks_complete"))
    scripts\engine\utility::ent_flag_init("intro_binks_complete");

  scripts\engine\utility::ent_flag_wait("intro_binks_complete");
  scripts\engine\utility::flag_wait("intro_binks_complete");
  self setclienttriggeraudiozone("hydro_c130_cp_loadout_selection", 1);
  self setplayermusicstate("mx_cp_hydro_plane");
}

_id_908CC9CAE0CB4FE0() {
  _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_ntro_lasw_breaker1youreoverthe");
  wait 1.5;
  _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_ntro_lasw_darknessisyouronlyfr");
  scripts\engine\utility::flag_set("laswell_infil_briefing_done");
}

_id_0C973260F1E32269() {
  if(!scripts\engine\utility::ent_flag_exist("player_spawned_with_loadout"))
    scripts\engine\utility::ent_flag_init("player_spawned_with_loadout");

  scripts\engine\utility::ent_flag_wait("player_spawned_with_loadout");
  self nightvisionviewon(1);
  waitframe();
  self setclientomnvar("ui_hide_bigmap", 1);
  self setclientomnvar("ui_show_tac_map", 0);
  self setclientomnvar("ui_hide_objectives", 1);
}

_id_8F9FE25C427BF1D1() {
  level endon("game_ended");
  level endon("laswell_intro_vo_done");

  for(;;) {
    foreach(player in level.players) {
      if(istrue(player._id_9CC16D2EFCAE947B)) {
        continue;
      }
      player scripts\cp\utility::_id_4CBAED764C116A25(1);
      player._id_9CC16D2EFCAE947B = 1;
    }

    wait 0.5;
  }
}

_id_2DE98F1598880AD9() {
  level._id_DEB683436640A4D3 = getEntArray("infil_interaction", "targetname");
  level._id_882065A62FA64689 = [];

  foreach(ent in level._id_DEB683436640A4D3) {
    ent makeusable();
    ent setHintString(&"COOP_GAME_PLAY/RESPAWN_HINT");
    ent setCursorHint("HINT_BUTTON");
    ent sethintdisplayrange(1000);
    ent sethintdisplayfov(65);
    ent setusefov(65);
    ent setuserange(65);
    ent sethintonobstruction("show");
    ent thread _id_6FADF5EE5750EEEE();
  }
}

_id_6FADF5EE5750EEEE() {
  self notify("infilUseLoop");
  self endon("infilUseLoop");
  self endon("death");
  level endon("game_ended");
  level.players_in_respawn_queue = [];

  for(;;) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    if(scripts\engine\utility::array_contains(level._id_882065A62FA64689, player)) {
      continue;
    }
    if(!scripts\engine\utility::flag("players_infil_briefing_done")) {
      player playlocalsound("br_pickup_deny");
      player scripts\cp\cp_hud_message::showerrormessage("MP/CANNOT_USE_GENERIC");
      continue;
    }

    player playlocalsound("cp_jump_confirm");
    self disableplayeruse(player);
    level._id_882065A62FA64689 = scripts\engine\utility::array_add(level._id_882065A62FA64689, player);
    thread _id_A1D852C4EF384CB0(player);

    if(level._id_882065A62FA64689.size >= level.players.size) {
      foreach(guy in level._id_882065A62FA64689)
      guy scripts\cp\cp_hud_message::showsplash("cp_squad_spawn", undefined, guy);

      wait 1.5;
      level notify("infil_watchForRemainingPlayersDisconnecting");
      thread _id_ADE082D66B3A2550();
      continue;
    }

    foreach(g in level.players) {
      if(scripts\engine\utility::array_contains(level._id_882065A62FA64689, g)) {
        continue;
      }
      g thread _id_247030EC6E9F1A3C();
    }
  }
}

_id_A1D852C4EF384CB0(_id_92CD24E1B3AD1D93) {
  level endon("infil_watchForRemainingPlayersDisconnecting");
  _id_92CD24E1B3AD1D93 waittill("disconnect");

  if(scripts\engine\utility::array_contains(level._id_882065A62FA64689, _id_92CD24E1B3AD1D93))
    level._id_882065A62FA64689 = scripts\engine\utility::array_remove(level._id_882065A62FA64689, _id_92CD24E1B3AD1D93);
}

_id_247030EC6E9F1A3C() {
  level endon("infil_watchForRemainingPlayersDisconnecting");
  self waittill("disconnect");
  wait 0.1;
  level.players = scripts\engine\utility::array_removeundefined(level.players);

  if(level._id_882065A62FA64689.size >= level.players.size) {
    thread _id_ADE082D66B3A2550();
    level notify("infil_watchForRemainingPlayersDisconnecting");
  }
}

_id_ADE082D66B3A2550() {
  level._id_0843D8B9846DF884 = 1;

  if(isDefined(game["objectives_completed"])) {
    site = game["objectives_completed"];

    switch (site) {
      case "a":
        level.default_player_spawns = "checkpoint_spawner_a";
        break;
      case "b":
        level.default_player_spawns = "checkpoint_spawner_b";
        break;
      case "c":
        level.default_player_spawns = "checkpoint_spawner_c";
        break;
      default:
        level.default_player_spawns = "checkpoint_spawner_c";
        break;
    }
  } else {
    start = tolower(getDvar("start"));

    if(start == "exfil_area")
      level.default_player_spawns = "checkpoint_spawner_c";
    else
      level.default_player_spawns = "hydro_stealth_spawn_abc";
  }

  _id_EA856EC0B3C4CFC6(0, level.players);
  stopFXOnTag(level._effect["infil_clouds_by_plane_windows_fx"], level._id_CC3D86BA33BC302D, "tag_body_animate");
  _id_C783F70D16243559 = getEntArray("infil_interactables", "script_noteworthy");

  foreach(ent in _id_C783F70D16243559) {
    if(isDefined(ent))
      ent delete();
  }

  foreach(scriptable in level._id_6801276E72CB11EE)
  scriptable freescriptable();

  if(isDefined(level._id_CA39B64FE98D1BD2))
    level._id_CA39B64FE98D1BD2 scripts\cp_mp\killstreaks\airdrop::deletecrate(0.05);

  _id_C5D0119E66BC4574();
  level._id_47648DF0E92E671D.players = level.players;

  foreach(ent in level.infilstruct._id_2739B8C6B038BA5E.ents) {
    ent dontinterpolate();
    ent scriptmodelplayanim(level.scr_animname[ent.animname][level.infilstruct._id_2739B8C6B038BA5E.anime], ent.animname);
  }

  foreach(guy in level._id_47648DF0E92E671D.players) {
    guy scripts\cp\utility::allow_player_ignore_me(0);
    scripts\cp_mp\calloutmarkerping::_id_5991BC039B1244EC(guy);
    guy setclientomnvar("ui_hide_hud", 1);
    level.infilstruct._id_2739B8C6B038BA5E _id_6D8AC534AD288AA5(guy);
    level.infilstruct._id_2739B8C6B038BA5E _id_0B1E3C932D90E6D7(guy);
    guy allowcrouch(0);
    guy allowprone(0);
    guy allowfire(0);
    guy allowads(0);
    guy disableweapons();
    guy clearclienttriggeraudiozone(1);
    guy setclientomnvar("ui_stop_armor_hint", 1);
    guy setclientomnvar("ui_radar_blocked", 0);
  }

  waitandpause(1.5);
  level._id_47648DF0E92E671D notify("start_moving");
}

waitandpause(_id_80B642A0F8C9659D) {
  wait(_id_80B642A0F8C9659D);
}

_id_E0036D7074BF1860() {
  self endon("disconnect");
  self waittill("infil_jump_done");
  _id_12BDF221B82E9EA1();
  self _meth_0DF8FAD503896462("enum_016737CFA86D4521");
  self allowcrouch(1);
  self allowprone(1);
  self allowfire(1);
  self allowads(1);
  self enableweapons();
  self setclientomnvar("ui_stop_armor_hint", 0);
  scripts\cp\cp_outofbounds::disableoobimmunity(self);
  _id_1925D24D0AE333E6 = scripts\engine\utility::getStructArray("hydro_stealth_spawn_abc", "targetname");

  if(!isDefined(_id_1925D24D0AE333E6) || _id_1925D24D0AE333E6.size < 4) {
    return;
  }
  index = self getentitynumber();
  _id_1925D24D0AE333E6[index].angles = scripts\engine\utility::ter_op(isDefined(_id_1925D24D0AE333E6[index].angles), _id_1925D24D0AE333E6[index].angles + (0, 90, 0), (0, 0, 0));
  _id_0310B7A0412AAEAD = _id_1925D24D0AE333E6[index];
  self nightvisionviewon(1);
  thread _id_9DF4608032376B69(_id_0310B7A0412AAEAD);
}

_id_12BDF221B82E9EA1() {
  _id_1925D24D0AE333E6 = scripts\engine\utility::getStructArray("hydro_stealth_spawn_abc", "targetname");
  index = self getentitynumber();
  _id_1925D24D0AE333E6[index].angles = scripts\engine\utility::ter_op(isDefined(_id_1925D24D0AE333E6[index].angles), _id_1925D24D0AE333E6[index].angles, (0, 0, 0));
  self._id_80F9D0AEAA47CC0C.origin = _id_1925D24D0AE333E6[index].origin;
  self._id_80F9D0AEAA47CC0C.angles = _id_1925D24D0AE333E6[index].angles;
}

_id_EA856EC0B3C4CFC6(_id_CD1BD4A1058452DA, players) {
  foreach(player in players)
  player _id_10F93BB3F3966751(_id_CD1BD4A1058452DA);
}

_id_7F3AD8FE6DF1B8FE(_id_1BB7594C18D17443, players) {
  level thread _id_6B9A694AC71B6342(_id_1BB7594C18D17443, players);
}

_id_6B9A694AC71B6342(_id_1BB7594C18D17443, players) {
  foreach(player in players)
  player _id_1162DBFDB942D179(_id_1BB7594C18D17443);

  wait(_id_1BB7594C18D17443);

  foreach(player in players)
  player _id_046B5C06F8D7AC31();
}

_id_10F93BB3F3966751(_id_CD1BD4A1058452DA) {
  overlay = newclienthudelem(self);
  overlay.x = 0;
  overlay.y = 0;
  overlay setshader("black", 640, 480);
  overlay.alignx = "left";
  overlay.aligny = "top";
  overlay.horzalign = "fullscreen";
  overlay.vertalign = "fullscreen";
  overlay.sort = -1;
  overlay setshowinrealism(1);
  self.infilblackoverlay = overlay;

  if(isDefined(_id_CD1BD4A1058452DA) && _id_CD1BD4A1058452DA > 0) {
    self.infilblackoverlay.alpha = 0;
    self.infilblackoverlay fadeovertime(_id_CD1BD4A1058452DA);
    self.infilblackoverlay.alpha = 1;
  } else
    self.infilblackoverlay.alpha = 1;
}

_id_1162DBFDB942D179(_id_1BB7594C18D17443) {
  if(isDefined(_id_1BB7594C18D17443) && _id_1BB7594C18D17443 > 0) {
    self.infilblackoverlay.alpha = 1;
    self.infilblackoverlay fadeovertime(_id_1BB7594C18D17443);
    self.infilblackoverlay.alpha = 0;
    self clearsoundsubmix("deaths_door_mp");
  } else
    self.infilblackoverlay.alpha = 0;
}

_id_046B5C06F8D7AC31() {
  self.infilblackoverlay destroy();
  self.infilblackoverlay = undefined;
}

_id_C5D0119E66BC4574() {
  setnojipscore(1, 1);
  setnojiptime(1, 1);
  level._id_42829953C9C016B8 = 1;
}

_id_A74D682E98DA3BB9() {
  level._id_5E5D0BB4EF6EC41F = scripts\engine\utility::getStruct("lz_location", "targetname");
  _id_F9CBFF5134DA960B = level._id_5E5D0BB4EF6EC41F.origin;
  _id_E5BD279D3767139F = level._id_ADDF1FC5251608BC;
  pathstruct = spawnc130pathstructnew(level._id_5E5D0BB4EF6EC41F.origin, _id_E5BD279D3767139F);
  updatec130pathomnvars(pathstruct);
  dist = distance(pathstruct.startpt, pathstruct.endpt);
  time = dist / getc130speed();
  _id_8F56F6C6C54E17D9 = 1;
  _id_58BB50874E340160 = undefined;
  level._id_47648DF0E92E671D = gunship_spawn("veh9_mil_air_cargo_plane", undefined, pathstruct.startpt, pathstruct.endpt, time, _id_8F56F6C6C54E17D9, _id_58BB50874E340160);
  level._id_47648DF0E92E671D.pathstruct = pathstruct;
  level._id_47648DF0E92E671D.pathstruct.droppoint = level._id_5E5D0BB4EF6EC41F.origin;
  level.infilstruct.c130 = level._id_47648DF0E92E671D;
  _id_856F3155AB36A710(level.infilstruct);
}

spawn_script_model(modelname, animname, _id_31093158B2292193) {
  model = spawn("script_model", self.origin);
  model setModel(modelname);
  model forcenetfieldhighlod(1);

  if(!isDefined(animname))
    animname = modelname;

  model.animname = animname;

  if(isDefined(_id_31093158B2292193)) {
    model.linkedents = [];

    foreach(_id_C30D717B67553796 in _id_31093158B2292193) {
      extra = spawn("script_model", self.origin);
      extra setModel(_id_C30D717B67553796[0]);
      extra forcenetfieldhighlod(1);
      extra linkTo(model, _id_C30D717B67553796[1], (0, 0, 0), (0, 0, 0));
      model.linkedents[model.linkedents.size] = extra;
    }
  }

  return model;
}

_id_19EA8F6D547DC8BC(player) {
  cameraent = self._id_2336099A20080602.ent;
  _id_1EDD840D40B43222 = self._id_2336099A20080602.tag;
  return [cameraent, _id_1EDD840D40B43222];
}

_id_BDA88F27A0337EAA(player) {
  [cameraent, _id_1EDD840D40B43222] = _id_19EA8F6D547DC8BC(player);
  player cameralinkTo(cameraent, _id_1EDD840D40B43222, 1, 1);
}

_id_30E6FEA31A50CD06(gunship) {
  gunship endon("death");
  self endon("disconnect");
  gunship thread _id_0AB9914D5F76E9FE();

  for(;;) {
    if(distance2dsquared(gunship.origin, gunship.pathstruct.droppoint) <= 1048576) {
      break;
    } else
      waitframe();
  }

  gunship.jumptype = "objectiveJump";
  gunship notify("halo_jump_c130");
}

_id_0AB9914D5F76E9FE() {
  level._id_47648DF0E92E671D endon("death");
  level._id_47648DF0E92E671D waittill("halo_jump_c130");
  setomnvar("ui_hide_player_icons", 0);
  level.no_aerial_munitions = undefined;

  foreach(guy in level._id_47648DF0E92E671D.players) {
    guy.disable_super = 0;
    guy setplayermusicstate("mx_cp_hydro_infil");
    guy thread watchinfiljumpanim();
    guy thread _id_E0036D7074BF1860();
  }

  thread _id_613662165F17A93A::_id_F13E0885BA2B6863();
  wait 6.9;
  scripts\engine\utility::flag_set("cleared_to_play_intro_vo");
}

_id_0B1E3C932D90E6D7(player) {
  player _meth_451319F93D30EBE5("enum_016737CFA86D4521");
  player._id_6863ACEA0BD6BF64 = 1;
  _id_8839D2F2F530A0B9(player);
  scripts\cp\cp_outofbounds::enableoobimmunity(player);
  setomnvar("ui_hide_player_icons", 1);
}

gunship_spawn(planemodel, _id_954A35001716E7CB, startpt, endpt, time, _id_8F56F6C6C54E17D9, _id_58BB50874E340160) {
  if(!isDefined(_id_8F56F6C6C54E17D9))
    _id_8F56F6C6C54E17D9 = 1;

  gunship = spawn("script_model", startpt);
  gunship setModel("veh9_mil_air_cargo_plane");
  gunship forcenetfieldhighlod(1);
  gunship setCanDamage(0);
  gunship.maxhealth = 100000;
  gunship.health = gunship.maxhealth;
  gunship.cleanme = 1;
  gunship.startpt = startpt;
  gunship.endpt = endpt;
  gunship.dir = vectorNormalize(endpt - startpt);
  gunship.angles = vectortoangles(gunship.dir);

  if(isDefined(_id_954A35001716E7CB)) {
    gunship.innards = spawn("script_model", startpt);
    gunship.innards setModel(_id_954A35001716E7CB);
    gunship.innards forcenetfieldhighlod(1);
    gunship.innards.cleanme = 1;
    gunship.innards linkTo(gunship, "", (0, 0, 0), (0, 0, 0));
  }

  gunship.playeroffsets = [(32, 30, -500), (-32, 30, -500), (0, 30, -500), (16, 30, -500), (-16, 30, -500)];
  gunship.currentplayeroffset = 0;

  if(isDefined(_id_58BB50874E340160))
    gunship thread[[_id_58BB50874E340160]](endpt, time);
  else
    gunship thread gunship_handlemovement(endpt, time);

  return gunship;
}

gunship_handlemovement(_id_C7F46EF27D351CD0, movetime) {
  level endon("game_ended");
  self endon("death");

  if(!scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73()) {
    self hide();

    if(isDefined(self.innards))
      self.innards hide();
  }

  self scriptmodelplayanim("wz_infil_cargoplane_idle_sh010");
  self waittill("start_moving");

  foreach(player in self.players) {
    player setallstreamloaddist(0);
    player _meth_47933F5EB9F65AFE(self.endpt);
    player nightvisionviewon(1);
    thread _id_912D16274BBECEE7(player, 1);
  }

  _id_7F3AD8FE6DF1B8FE(1, self.players);
  thread _id_30E6FEA31A50CD06(self);

  if(!scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73()) {
    self show();

    if(isDefined(self.innards))
      self.innards show();
  }

  self moveTo(_id_C7F46EF27D351CD0, movetime);
  thread killaftertime(movetime);
  thread gunship_spawnvfx();
  self playLoopSound("br_ac130_lp");
}

_id_912D16274BBECEE7(player, delay) {
  player endon("disconnect");
  wait(delay);
  player setclientomnvar("ui_show_tac_map", 1);
  player setclientomnvar("ui_hide_bigmap", 0);
  player setclientomnvar("ui_hide_objectives", 0);
  player setclientomnvar("ui_hide_hud", 0);
  _id_51023E7DB5068D92::_id_F7F781BE810D09F2();
}

gunship_spawnvfx() {
  level endon("game_ended");
  wait 0.1;
  self setscriptablepartstate("br_fx", "clouds");
  self setscriptablepartstate("running_lights", "on");
  self setscriptablepartstate("int_lights_green", "on");

  if(1) {
    return;
  }
  _id_A910600EADF5E31C = level._effect["vfx_snatch_ac130_clouds"];

  if(!isDefined(_id_A910600EADF5E31C)) {
    return;
  }
  wait 0.1;
  playFXOnTag(_id_A910600EADF5E31C, self, "tag_body");
  return;
}

killaftertime(time) {
  level endon("game_ended");
  self endon("death");
  wait(time);

  if(isDefined(self.players)) {
    foreach(_id_AC0E424AC96A7113 in self.players) {
      if(!isDefined(_id_AC0E424AC96A7113)) {
        continue;
      }
      _id_AC0E424AC96A7113.jumptype = "outOfBounds";
      _id_AC0E424AC96A7113 notify("halo_kick_c130");
      _id_AC0E424AC96A7113 notify("halo_jump_c130");
      _id_AC0E424AC96A7113.kickedfromc130 = 1;
    }
  }

  wait 0.1;

  if(isDefined(self.innards))
    self.innards delete();

  self delete();
}

spawnc130pathstructnew(_id_1AC3DEC2A5426BD4, _id_E5BD279D3767139F, _id_B2D2EEC29DBABA05) {
  centerpt = level.br_level.br_mapcenter;

  if(isDefined(_id_1AC3DEC2A5426BD4))
    centerpt = _id_1AC3DEC2A5426BD4;

  _id_F434D604C09196AA = getplanepathsaferadiusfromcenter(_id_E5BD279D3767139F);
  _id_6768A915ED3C9351 = randomfloat(360);
  _id_F36436FA7801BB1C = anglesToForward((0, _id_6768A915ED3C9351, 0));
  _id_F36436FA7801BB1C = _id_F36436FA7801BB1C * (_id_F434D604C09196AA * randomfloatrange(-1, 1));
  _id_F36436FA7801BB1C = _id_F36436FA7801BB1C + (0, 0, getc130knownsafeheight());
  centerpt = getdvarvector("dvar_3956F0CA6C9C5F89", centerpt);
  _id_D8235976EA87D0D2 = (0, randomfloatrange(0, 360), 0);
  _id_D8235976EA87D0D2 = (0, getdvarfloat("dvar_7343D5620B46BBC3", _id_D8235976EA87D0D2[1]), 0);
  circleradius = level.br_level.br_circleradii[0];

  if(isDefined(_id_E5BD279D3767139F))
    circleradius = _id_E5BD279D3767139F;

  _id_5619B7BBC3745888 = circleradius * 2;
  pathstruct = spawnc130pathstructnewinternal(centerpt, _id_D8235976EA87D0D2, _id_5619B7BBC3745888, _id_B2D2EEC29DBABA05);
  _id_FDFE2D4AAF8EC33D = scripts\cp_mp\parachute::getc130height();
  pathstruct.startpt = (pathstruct.startpt[0], pathstruct.startpt[1], _id_FDFE2D4AAF8EC33D);
  pathstruct.endpt = (pathstruct.endpt[0], pathstruct.endpt[1], _id_FDFE2D4AAF8EC33D);
  return pathstruct;
}

getplanepathsaferadiusfromcenter(_id_E5BD279D3767139F) {
  _id_18404860CD4BEDBA = getdvarfloat("dvar_95884EB90393FA6D", 0.7);
  _id_4BC476776E118554 = (level.br_level.br_mapsize[0] / 2 + level.br_level.br_mapsize[1] / 2) / 2;

  if(isDefined(_id_E5BD279D3767139F))
    _id_4BC476776E118554 = _id_E5BD279D3767139F;
  else if(isDefined(level._id_ADDF1FC5251608BC))
    _id_4BC476776E118554 = level._id_ADDF1FC5251608BC;

  _id_F434D604C09196AA = _id_18404860CD4BEDBA * _id_4BC476776E118554;
  return _id_F434D604C09196AA;
}

getc130speed() {
  if(isDefined(level.br_level) && isDefined(level.br_level.c130_speedoverride))
    return level.br_level.c130_speedoverride;

  return 3044;
}

getc130knownsafeheight() {
  return 8000;
}

spawnc130pathstructnewinternal(centerpt, angles, _id_5619B7BBC3745888, _id_B2D2EEC29DBABA05) {
  pathdir = anglesToForward(angles);

  if(!isDefined(_id_5619B7BBC3745888))
    _id_5619B7BBC3745888 = level.br_level.br_circleradii[0] * 2;

  startpt = centerpt - pathdir * _id_5619B7BBC3745888;
  endpt = centerpt + pathdir * _id_5619B7BBC3745888;
  startptui = startpt;
  endptui = endpt;

  if(!ispointinbounds(startpt))
    startptui = snappointtooutofboundstriggertrace(centerpt, startpt);

  if(!ispointinbounds(endpt))
    endptui = snappointtooutofboundstriggertrace(centerpt, endpt);

  pathdir = vectorNormalize(endpt - startpt);
  _id_88BE2123B5A143A0 = 10;

  if(isDefined(_id_B2D2EEC29DBABA05))
    _id_88BE2123B5A143A0 = _id_88BE2123B5A143A0 + _id_B2D2EEC29DBABA05;

  startpt = startpt - pathdir * getc130speed() * _id_88BE2123B5A143A0;
  endpt = endpt + pathdir * 100000;
  pathstruct = spawnStruct();
  pathstruct.startpt = startpt;
  pathstruct.endpt = endpt;
  pathstruct.startptui = startptui;
  pathstruct.endptui = endptui;
  pathstruct.angle = angles;
  pathstruct.pathdir = pathdir;
  pathstruct.centerpt = centerpt;
  return pathstruct;
}

inmapbounds(_id_CDCD3178F5176585) {
  _id_DC8625458EE5ED14 = level.br_level.br_mapbounds;

  if(isDefined(level.br_level.br_mapboundsfull))
    _id_DC8625458EE5ED14 = level.br_level.br_mapboundsfull;

  inmapbounds = _id_CDCD3178F5176585[0] < _id_DC8625458EE5ED14[0][0] && _id_CDCD3178F5176585[0] > _id_DC8625458EE5ED14[1][0] && _id_CDCD3178F5176585[1] < _id_DC8625458EE5ED14[0][1] && _id_CDCD3178F5176585[1] > _id_DC8625458EE5ED14[1][1];
  return inmapbounds;
}

ispointinbounds(_id_CDCD3178F5176585, _id_776E4CFC1D04CA70) {
  inmapbounds = inmapbounds(_id_CDCD3178F5176585);

  if(!inmapbounds)
    return 0;

  if(iswithinplanepathsaferadius(_id_CDCD3178F5176585))
    return 1;

  outofbounds = scripts\cp\cp_outofbounds::ispointinoutofbounds(_id_CDCD3178F5176585);

  if(outofbounds)
    return 0;

  if(istrue(_id_776E4CFC1D04CA70)) {
    _id_7E5AF16F0F9F7C87 = 16;
    contents = physics_createcontents(["physicscontents_trigger"]);
    results = physics_spherecast(_id_CDCD3178F5176585, _id_CDCD3178F5176585, _id_7E5AF16F0F9F7C87, contents, undefined, "physicsquery_all");

    foreach(result in results) {
      ent = result["entity"];

      if(isDefined(ent) && isDefined(ent.targetname) && ent.targetname == "OutOfBounds")
        return 0;
    }
  }

  return 1;
}

iswithinplanepathsaferadius(_id_CDCD3178F5176585) {
  centerpt = level.br_level.br_mapcenter;
  _id_F434D604C09196AA = getplanepathsaferadiusfromcenter();
  dist = distance2d(centerpt, _id_CDCD3178F5176585);
  return dist < _id_F434D604C09196AA;
}

updatec130pathomnvars(_id_BCEAE96AF86616DD) {
  if(!isDefined(_id_BCEAE96AF86616DD)) {
    return;
  }
  if(!isDefined(_id_BCEAE96AF86616DD.startpt) || !isDefined(_id_BCEAE96AF86616DD.endpt) || !isDefined(_id_BCEAE96AF86616DD.angle)) {
    return;
  }
  setomnvar("ui_br_c130_path_start_x", int(_id_BCEAE96AF86616DD.startptui[0]));
  setomnvar("ui_br_c130_path_start_y", int(_id_BCEAE96AF86616DD.startptui[1]));
  setomnvar("ui_br_c130_path_end_x", int(_id_BCEAE96AF86616DD.endptui[0]));
  setomnvar("ui_br_c130_path_end_y", int(_id_BCEAE96AF86616DD.endptui[1]));
}

setc130heightoverrides(_id_45ACCFF1681E0276, _id_0924F9394B6FEB3E) {
  if(isDefined(_id_45ACCFF1681E0276))
    level.br_level.c130_heightoverride = _id_45ACCFF1681E0276;

  if(isDefined(_id_0924F9394B6FEB3E))
    level.br_level.c130_sealeveloverride = _id_0924F9394B6FEB3E;

  setomnvar("ui_br_altimeter_c130_height", scripts\cp_mp\parachute::getc130height());
  setomnvar("ui_br_altimeter_sea_height", scripts\cp_mp\parachute::getc130sealevel());
}

_id_8F861516AC2B8347() {
  level.br_level = spawnStruct();
  setc130heightoverrides(16000);
  _id_3C590D0EE220B409 = level.mapcorners[0].origin[0];
  _id_C978C90E8E5AB1F7 = level.mapcorners[1].origin[0];
  _id_3C590C0EE220B1D6 = level.mapcorners[1].origin[1];
  _id_C978C80E8E5AAFC4 = level.mapcorners[0].origin[1];
  level.br_level.br_mapboundsfull = [];
  level.br_level.br_mapboundsfull[0] = (_id_C978C90E8E5AB1F7, _id_C978C80E8E5AAFC4, 0);
  level.br_level.br_mapboundsfull[1] = (_id_3C590D0EE220B409, _id_3C590C0EE220B1D6, 0);
  _id_3C590D0EE220B409 = level.mapcorners[0].origin[0] * 0.8;
  _id_C978C90E8E5AB1F7 = level.mapcorners[1].origin[0] * 0.8;
  _id_3C590C0EE220B1D6 = level.mapcorners[1].origin[1] * 0.8;
  _id_C978C80E8E5AAFC4 = level.mapcorners[0].origin[1] * 0.8;
  level.br_level.br_mapbounds = [];
  level.br_level.br_mapbounds[0] = (_id_C978C90E8E5AB1F7, _id_C978C80E8E5AAFC4, 0);
  level.br_level.br_mapbounds[1] = (_id_3C590D0EE220B409, _id_3C590C0EE220B1D6, 0);
  level.br_level.br_mapcenter = ((_id_3C590D0EE220B409 + _id_C978C90E8E5AB1F7) / 2, (_id_3C590C0EE220B1D6 + _id_C978C80E8E5AAFC4) / 2, 0);
  _id_FDFE2D4AAF8EC33D = scripts\cp_mp\parachute::getc130height();
  _id_33DD915945FCA005 = scripts\cp_mp\parachute::getc130sealevel();
  level.br_level.br_mapsize = (abs(_id_C978C90E8E5AB1F7 - _id_3C590D0EE220B409), abs(_id_C978C80E8E5AAFC4 - _id_3C590C0EE220B1D6), abs(_id_FDFE2D4AAF8EC33D - _id_33DD915945FCA005));
  level.br_level.br_mapcenter = (-8328, 8624, 0);
  level._id_ADDF1FC5251608BC = 512;
  level.br_level.br_circleclosetimes = [270, 220, 170, 110, 70, 50, 50, 100];
  level.br_level.br_circledelaytimes = [220, 90, 75, 60, 60, 45, 30, 0];
  level.br_level.br_circleshowdelaydanger = [220, 0, 0, 0, 0, 0, 0, 0];
  level.br_level.br_circleshowdelaysafe = [0, 0, 0, 0, 0, 0, 0, 0];
  level.br_level.br_circleminimapradii = [10500, 10500, 10500, 10500, 10500, 9000, 8000, 5500];
  level.br_level.br_circleradii = [81600, 57300, 37500, 22200, 12300, 6000, 3000, 1500, 0];

  if(!isDefined(level.infilstruct))
    level.infilstruct = spawnStruct();

  level.infilstruct._id_AE9E4023110ACC6E = ::_id_AD4A7A73C7D7D9E0;
  level.infilstruct._id_8D5C19A9B693E913 = ::_id_8D5C19A9B693E913;
  level.infilstruct._id_DC0BC83A31193177 = ::_id_DC0BC83A31193177;
  _id_1809E16510055E87 = ["cam_orbit_br_infil_ac130_nexus_player1", "cam_orbit_br_infil_ac130_nexus_player2", "cam_orbit_br_infil_ac130_nexus_player3", "cam_orbit_br_infil_ac130_nexus_player4", "cam_orbit_br_infil_ac130_nexus_player1"];
  _id_226E337633A44059(_id_1809E16510055E87);
}

_id_226E337633A44059(_id_4F748FB021262DBA, _id_C242A4A69C2BEED3) {
  level.infilstruct._id_6D575C4DFA5D6788 = _id_4F748FB021262DBA;

  if(isDefined(_id_C242A4A69C2BEED3))
    level.infilstruct._id_AD3C883FBFF215B5 = _id_C242A4A69C2BEED3;
  else
    level.infilstruct._id_AD3C883FBFF215B5 = undefined;
}

makepathstruct(_id_40240AE50B8189B1) {
  r = _id_40240AE50B8189B1.r;
  randomangle = _id_40240AE50B8189B1.randomangle;
  endangleoffset = _id_40240AE50B8189B1.endangleoffset;
  centerpt = _id_40240AE50B8189B1.centerpt;
  _id_02E499CD16746F2D = (randomangle + endangleoffset) % 360;
  startpt = (r * cos(randomangle), r * sin(randomangle), scripts\cp_mp\parachute::getc130height()) + centerpt;
  endpt = (r * cos(_id_02E499CD16746F2D), r * sin(_id_02E499CD16746F2D), scripts\cp_mp\parachute::getc130height()) + centerpt;
  pathdir = vectorNormalize(endpt - startpt);
  endpt = endpt + pathdir * r;
  startpt = startpt - pathdir * r * 2;
  pathstruct = spawnStruct();
  pathstruct.startpt = startpt;
  pathstruct.endpt = endpt;
  pathstruct.angle = vectortoangles(pathdir);
  return pathstruct;
}

snappointtomapbounds2d(point) {
  _id_DC8625458EE5ED14 = level.br_level.br_mapbounds;

  if(point[0] < _id_DC8625458EE5ED14[1][0])
    point = (_id_DC8625458EE5ED14[1][0], point[1], point[2]);
  else if(point[0] > _id_DC8625458EE5ED14[0][0])
    point = (_id_DC8625458EE5ED14[0][0], point[1], point[2]);

  if(point[1] < _id_DC8625458EE5ED14[1][1])
    point = (point[0], _id_DC8625458EE5ED14[1][1], point[2]);
  else if(point[1] > _id_DC8625458EE5ED14[0][1])
    point = (point[0], _id_DC8625458EE5ED14[0][1], point[2]);

  return point;
}

ray_trace_trigger_radius_2d(start, end, _id_5C7118560E119AEB) {
  points = [];

  foreach(_id_D73D5D86BF007C1A in _id_5C7118560E119AEB) {
    point = scripts\engine\math::_id_CC2AD02DCF5030D8(start, end, _id_D73D5D86BF007C1A.origin, _id_D73D5D86BF007C1A.radius);
    points[points.size] = point;
  }

  _id_D73F53A8E479F9FC = undefined;
  _id_7B076D31304FE0A4 = 0;

  foreach(point in points) {
    distsq = distance2dsquared(start, point);

    if(!isDefined(_id_D73F53A8E479F9FC) || distsq < _id_7B076D31304FE0A4) {
      _id_D73F53A8E479F9FC = point;
      _id_7B076D31304FE0A4 = distsq;
    }
  }

  return _id_D73F53A8E479F9FC;
}

snappointtooutofboundstriggertrace(startpoint, _id_C1E273BA6CEF8058) {
  if(!isDefined(level.outofboundstriggers) || level.outofboundstriggers.size == 0)
    return snappointtomapbounds2d(_id_C1E273BA6CEF8058);

  if(!isDefined(level.outofboundstriggersplanetrace))
    level.outofboundstriggersplanetrace = level.outofboundstriggers;

  contents = physics_createcontents(["physicscontents_trigger"]);
  trace = scripts\engine\trace::ray_trace_ents(startpoint, _id_C1E273BA6CEF8058, level.outofboundstriggersplanetrace, contents);

  if(trace["fraction"] < 1.0)
    _id_C1E273BA6CEF8058 = trace["position"];

  if(isDefined(level.outofboundstriggersspawned) && level.outofboundstriggersspawned.size > 0 && getdvarint("dvar_B6F6771F7D380C01", 0) == 0) {
    _id_B735EC48CD0B4308 = ray_trace_trigger_radius_2d(startpoint, _id_C1E273BA6CEF8058, level.outofboundstriggersspawned);

    if(isDefined(_id_B735EC48CD0B4308)) {
      _id_3E6D55080731EC2A = distance2dsquared(startpoint, _id_C1E273BA6CEF8058);
      _id_E1B832ABA05BC49A = distance2dsquared(startpoint, _id_B735EC48CD0B4308);

      if(_id_E1B832ABA05BC49A < _id_3E6D55080731EC2A)
        _id_C1E273BA6CEF8058 = (_id_B735EC48CD0B4308[0], _id_B735EC48CD0B4308[1], _id_C1E273BA6CEF8058[2]);
    }
  }

  return _id_C1E273BA6CEF8058;
}

watchinfiljumpanim() {
  self endon("death_or_disconnect");

  if(isDefined(level.infilstruct._id_8D5C19A9B693E913))
    self thread[[level.infilstruct._id_8D5C19A9B693E913]]();

  if(!isDefined(level.infiljumpentsspawned))
    level.infiljumpentsspawned = 0;

  _id_A2117EA816A8B7F1 = getdvarint("dvar_8BE4ACC5EEBB19CA", 1) != 0;
  _id_77B785278F139079 = undefined;

  if(_id_A2117EA816A8B7F1) {
    _id_77B785278F139079 = 0;
    [_id_8DEC95713EC1F7BA, _id_4D261EF98868B4E6, _id_66809387054FC02A, _id_D337825DF4506344] = self[[level.infilstruct._id_AE9E4023110ACC6E]]();
    _id_539C2DCC0A467746 = level.infilstruct.c130;
    _id_9B145EB55513DBB5["parent"] = spawn("script_model", _id_539C2DCC0A467746.origin);
    level.infiljumpentsspawned++;
    _id_9B145EB55513DBB5["parent"] setModel("generic_prop_x10");
    _id_9B145EB55513DBB5["parent"] forcenetfieldhighlod(1);
    _id_9B145EB55513DBB5["parent"] linkTo(_id_539C2DCC0A467746, "tag_body", (0, 0, 0), (0, 0, 0));
    _id_9B145EB55513DBB5[_id_D337825DF4506344] = spawn("script_model", _id_9B145EB55513DBB5["parent"] gettagorigin(_id_D337825DF4506344));
    level.infiljumpentsspawned++;
    _id_9B145EB55513DBB5[_id_D337825DF4506344] setModel("tag_player");
    _id_9B145EB55513DBB5[_id_D337825DF4506344] forcenetfieldhighlod(1);
    _id_9B145EB55513DBB5[_id_D337825DF4506344] linkTo(_id_9B145EB55513DBB5["parent"], _id_D337825DF4506344, (0, 0, 0), (0, 0, 0));
    self playerlinkTo(_id_9B145EB55513DBB5[_id_D337825DF4506344], "tag_player");
    scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76(1);
    self playanimscriptsceneevent("scripted_scene", _id_66809387054FC02A);
    self.infilanimindex = undefined;
    self._id_DB122A8941DFEE14 = undefined;
    self playlocalsound("evt_br_infil_jump_stinger");
    _id_9B145EB55513DBB5["parent"] scriptmodelplayanim(_id_8DEC95713EC1F7BA, "prop");
    _id_7A79E5C326955318 = getanimlength(_id_4D261EF98868B4E6);
    _id_886F7978500ACB10 = 1.0;
    _id_7A79E5C326955318 = max(_id_7A79E5C326955318, _id_886F7978500ACB10 + 0.1);
    wait(_id_7A79E5C326955318 - _id_886F7978500ACB10);
    self cameradefault();

    if(isDefined(level.infilstruct._id_DC0BC83A31193177))
      self thread[[level.infilstruct._id_DC0BC83A31193177]]();

    wait(_id_886F7978500ACB10);

    foreach(ent in _id_9B145EB55513DBB5) {
      ent delete();
      level.infiljumpentsspawned--;
    }
  }

  self.infilanimindex = undefined;
  self._id_DB122A8941DFEE14 = undefined;
  self stopanimscriptsceneevent();
  self notify("infil_jump_done");
}

_id_AD4A7A73C7D7D9E0() {
  if(!isDefined(self.infilanimindex))
    self.infilanimindex = 1;

  infilanimindex = self.infilanimindex;

  if(infilanimindex >= 5)
    infilanimindex = 1;

  _id_8E3AFD40D3C95B46 = "j_prop_" + (infilanimindex + 1);
  return ["wz_infil_gprop_standard_sh010", level._id_1A209BD995A7FA83["wz_infil_gprop_standard_sh010"], "wz_infil_standardforward_jump_sh010", _id_8E3AFD40D3C95B46];
}

_id_00D99D934D14E73D() {
  self endon("disconnect");
  wait 5;
  self _meth_0DF8FAD503896462("enum_016737CFA86D4521");
}

_id_8D5C19A9B693E913() {
  thread _id_00D99D934D14E73D();
}

_id_DC0BC83A31193177() {
  self endon("disconnect");
  wait 1;
  self setclientdvar("cg_disable_user_fov", 0);
}

_id_856F3155AB36A710(animstruct) {
  animstruct.origin = getdvarvector("br_infil_anim_pos", (0, 0, 0));
  animstruct.angles = (0, 0, 0);
  animstruct._id_E73CE295AE9D4104 = animstruct spawn_script_model("generic_prop_x30", "camera");
  animstruct._id_E73CE295AE9D4104 linkTo(animstruct.c130, "", (0, 0, 0), (0, 0, 0));
  animstruct.crates = [];
  animstruct.crates[0] = animstruct spawn_script_model("military_carepackage_03_br", "crate1");
  animstruct.crates[0] linkTo(animstruct._id_E73CE295AE9D4104, "j_prop_8", (0, 0, 0), (0, 0, 0));
  animstruct._id_0B50860E78D9E1E5 = [];
  animstruct._id_0B50860E78D9E1E5[0] = animstruct spawn_script_model("tag_player", "playerTag1");
  animstruct._id_0B50860E78D9E1E5[1] = animstruct spawn_script_model("tag_player", "playerTag2");
  animstruct._id_0B50860E78D9E1E5[2] = animstruct spawn_script_model("tag_player", "playerTag3");
  animstruct._id_0B50860E78D9E1E5[3] = animstruct spawn_script_model("tag_player", "playerTag4");
  animstruct._id_0B50860E78D9E1E5[4] = animstruct spawn_script_model("tag_player", "playerTag5");
  animstruct._id_0B50860E78D9E1E5[0] linkTo(animstruct._id_E73CE295AE9D4104, "j_prop_2", (0, 0, 0), (0, 0, 0));
  animstruct._id_0B50860E78D9E1E5[1] linkTo(animstruct._id_E73CE295AE9D4104, "j_prop_3", (0, 0, 0), (0, 0, 0));
  animstruct._id_0B50860E78D9E1E5[2] linkTo(animstruct._id_E73CE295AE9D4104, "j_prop_4", (0, 0, 0), (0, 0, 0));
  animstruct._id_0B50860E78D9E1E5[3] linkTo(animstruct._id_E73CE295AE9D4104, "j_prop_5", (0, 0, 0), (0, 0, 0));
  animstruct._id_0B50860E78D9E1E5[4] linkTo(animstruct._id_E73CE295AE9D4104, "j_prop_15", (0, 0, 0), (0, 0, 0));
  n = 0;
  _id_B8607DFC73CB2296 = "wz_infil_g_prop_idle_sh010nexus";
  animstruct.packs = [];
  animstruct.packs[n] = animstruct create_animpack("looping", 1);
  animstruct.c130.animname = "c130";
  animstruct.packs[n] add_pack_modelanim(animstruct.crates[0], level._id_1A209BD995A7FA83["wz_infil_cargobox_sh120"]);
  animstruct.packs[n] add_pack_modelanim(animstruct.c130, level._id_1A209BD995A7FA83["wz_infil_cargoplane_idle_sh010"]);
  animstruct.packs[n] add_pack_modelanim(animstruct._id_E73CE295AE9D4104, level._id_1A209BD995A7FA83["wz_infil_g_prop_idle_sh010nexus"]);
  animstruct.packs[n] _id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[0], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_idle_sh010"]);
  animstruct.packs[n] _id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[1], level._id_1A209BD995A7FA83["wz_infil_drone_guy2_idle_sh010"]);
  animstruct.packs[n] _id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[2], level._id_1A209BD995A7FA83["wz_infil_drone_guy3_idle_sh010"]);
  animstruct.packs[n] _id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[3], level._id_1A209BD995A7FA83["wz_infil_drone_guy4_idle_sh010"]);
  animstruct.packs[n] _id_AD0BCAC98781E0AB(animstruct._id_0B50860E78D9E1E5[4], level._id_1A209BD995A7FA83["wz_infil_drone_guy1_idle_sh010"]);
  animstruct.packs[n] _id_D4561AB1BA4F5DE9(animstruct._id_E73CE295AE9D4104, ::_id_E128261218FAFDAA);
  animstruct._id_2739B8C6B038BA5E = animstruct.packs[n];
}

add_pack_modelanim(ent, animation) {
  level.scr_anim[ent.animname][self.anime] = animation;
  level.scr_animname[ent.animname][self.anime] = getanimname(animation);
  self.ents[self.ents.size] = ent;
}

create_animpack(anime, _id_79D924275E2B5029) {
  pack = spawnStruct();
  pack.ents = [];
  pack._id_FB299ADFD0F8BFC5 = [];
  pack._id_6F8E05E25EB697A4 = [];
  pack._id_3BD5282B118D27F8 = [];
  pack._id_5BA8DB57A9811D96 = [];
  pack.anime = anime;
  pack._id_79D924275E2B5029 = istrue(_id_79D924275E2B5029);
  return pack;
}

_id_AD0BCAC98781E0AB(ent, animation) {
  index = self._id_6F8E05E25EB697A4.size;
  _id_A7B23DAE3BCFE5F8 = spawnStruct();
  _id_A7B23DAE3BCFE5F8.ent = ent;
  _id_A7B23DAE3BCFE5F8.animation = animation;
  _id_A7B23DAE3BCFE5F8.animname = getanimname(animation);
  self._id_6F8E05E25EB697A4[index] = _id_A7B23DAE3BCFE5F8;
}

#using_animtree("script_model");

_id_91DF1C649A724F2B() {
  level._id_1A209BD995A7FA83["wz_infil_g_prop_sh120"] = % wz_infil_g_prop_sh120;
  level._id_1A209BD995A7FA83["wz_infil_g_prop_sh120nexus"] = % wz_infil_g_prop_sh120nexus;
  level._id_1A209BD995A7FA83["wz_infil_g_prop_idle_sh010"] = % wz_infil_g_prop_idle_sh010;
  level._id_1A209BD995A7FA83["wz_infil_g_prop_idle_sh010nexus"] = % wz_infil_g_prop_idle_sh010nexus;
  level._id_1A209BD995A7FA83["wz_infil_cargobox_sh120"] = % wz_infil_cargobox_sh120;
  level._id_1A209BD995A7FA83["wz_infil_cargobox_sh120nexus"] = % wz_infil_cargobox_sh120nexus;
  level._id_1A209BD995A7FA83["wz_infil_cargobox_idle_sh010"] = % wz_infil_cargobox_idle_sh010;
  level._id_1A209BD995A7FA83["wz_infil_cargoplane_sh120"] = % wz_infil_cargoplane_sh120;
  level._id_1A209BD995A7FA83["wz_infil_cargoplane_sh120nexus"] = % wz_infil_cargoplane_sh120nexus;
  level._id_1A209BD995A7FA83["wz_infil_cargoplane_idle_sh010"] = % wz_infil_cargoplane_idle_sh010;
  level._id_1A209BD995A7FA83["wz_infil_drone_guy1_sh120"] = % wz_infil_drone_guy1_sh120;
  level._id_1A209BD995A7FA83["wz_infil_drone_guy1_sh120nexus"] = % wz_infil_drone_guy1_sh120nexus;
  level._id_1A209BD995A7FA83["wz_infil_drone_guy1_idle_sh010"] = % wz_infil_drone_guy1_idle_sh010;
  level._id_1A209BD995A7FA83["wz_infil_drone_guy2_sh120"] = % wz_infil_drone_guy2_sh120;
  level._id_1A209BD995A7FA83["wz_infil_drone_guy2_sh120nexus"] = % wz_infil_drone_guy2_sh120nexus;
  level._id_1A209BD995A7FA83["wz_infil_drone_guy2_idle_sh010"] = % wz_infil_drone_guy2_idle_sh010;
  level._id_1A209BD995A7FA83["wz_infil_drone_guy3_sh120"] = % wz_infil_drone_guy3_sh120;
  level._id_1A209BD995A7FA83["wz_infil_drone_guy3_sh120nexus"] = % wz_infil_drone_guy3_sh120nexus;
  level._id_1A209BD995A7FA83["wz_infil_drone_guy3_idle_sh010"] = % wz_infil_drone_guy3_idle_sh010;
  level._id_1A209BD995A7FA83["wz_infil_drone_guy4_sh120"] = % wz_infil_drone_guy4_sh120;
  level._id_1A209BD995A7FA83["wz_infil_drone_guy4_sh120nexus"] = % wz_infil_drone_guy4_sh120nexus;
  level._id_1A209BD995A7FA83["wz_infil_drone_guy4_idle_sh010"] = % wz_infil_drone_guy4_idle_sh010;
  level._id_1A209BD995A7FA83["wz_infil_solowin_guy1_sh110"] = % wz_infil_solowin_guy1_sh110;
  level._id_1A209BD995A7FA83["wz_infil_solowin_guy1_sh120"] = % wz_infil_solowin_guy1_sh120;
  level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc1_sh120"] = % wz_infil_drone_guy_npc1_sh120;
  level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc1_sh120nexus"] = % wz_infil_drone_guy_npc1_sh120nexus;
  level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc1idle_sh010"] = % wz_infil_drone_guy_npc1idle_sh010;
  level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc2_sh120"] = % wz_infil_drone_guy_npc2_sh120;
  level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc2_sh120nexus"] = % wz_infil_drone_guy_npc2_sh120nexus;
  level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc2idle_sh010"] = % wz_infil_drone_guy_npc2idle_sh010;
  level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc3_sh120"] = % wz_infil_drone_guy_npc3_sh120;
  level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc3_sh120nexus"] = % wz_infil_drone_guy_npc3_sh120nexus;
  level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc3idle_sh010"] = % wz_infil_drone_guy_npc3idle_sh010;
  level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc4_sh120"] = % wz_infil_drone_guy_npc4_sh120;
  level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc4_sh120nexus"] = % wz_infil_drone_guy_npc4_sh120nexus;
  level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc4idle_sh010"] = % wz_infil_drone_guy_npc4idle_sh010;
  level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc5_sh120"] = % wz_infil_drone_guy_npc5_sh120;
  level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc5_sh120nexus"] = % wz_infil_drone_guy_npc5_sh120nexus;
  level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc5idle_sh010"] = % wz_infil_drone_guy_npc5idle_sh010;
  level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc6_sh120"] = % wz_infil_drone_guy_npc6_sh120;
  level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc6_sh120nexus"] = % wz_infil_drone_guy_npc6_sh120nexus;
  level._id_1A209BD995A7FA83["wz_infil_drone_guy_npc6idle_sh010"] = % wz_infil_drone_guy_npc6idle_sh010;
  level._id_1A209BD995A7FA83["wz_infil_gprop_l180_sh010"] = % wz_infil_gprop_l180_sh010;
  level._id_1A209BD995A7FA83["wz_infil_gprop_r180_sh010"] = % wz_infil_gprop_r180_sh010;
  level._id_1A209BD995A7FA83["wz_infil_gprop_l90_sh010"] = % wz_infil_gprop_l90_sh010;
  level._id_1A209BD995A7FA83["wz_infil_gprop_r90_sh010"] = % wz_infil_gprop_r90_sh010;
  level._id_1A209BD995A7FA83["wz_infil_gprop_standard_sh010"] = % wz_infil_gprop_standard_sh010;
  level._id_1A209BD995A7FA83["wz_infil_l180_jump_sh010"] = % wz_infil_l180_jump_sh010;
  level._id_1A209BD995A7FA83["wz_infil_r180_jump_sh010"] = % wz_infil_r180_jump_sh010;
  level._id_1A209BD995A7FA83["wz_infil_l90_jump_sh010"] = % wz_infil_l90_jump_sh010;
  level._id_1A209BD995A7FA83["wz_infil_r90_jump_sh010"] = % wz_infil_r90_jump_sh010;
  level._id_1A209BD995A7FA83["wz_infil_standardforward_jump_sh010"] = % wz_infil_standardforward_jump_sh010;
  level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_redux_players_cam"] = % sdr_mp_infil_ac130_redux_players_cam;
  level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_redux_players_ac130"] = % sdr_mp_infil_ac130_redux_players_ac130;
  level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_redux_character_link"] = % sdr_mp_infil_ac130_redux_character_link;
  level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_redux_player1"] = % sdr_mp_infil_ac130_redux_player1;
  level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_redux_player2"] = % sdr_mp_infil_ac130_redux_player2;
  level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_redux_player3"] = % sdr_mp_infil_ac130_redux_player3;
  level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_redux_player4"] = % sdr_mp_infil_ac130_redux_player4;
  level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_redux_doorchief"] = % sdr_mp_infil_ac130_redux_doorchief;
  level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_loop2_plane"] = % sdr_mp_infil_ac130_loop2_plane;
  level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_loop_genpropx10"] = % sdr_mp_infil_ac130_loop_genpropx10;
  level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_loop_pl01"] = % sdr_mp_infil_ac130_loop_pl01;
  level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_loop_pl02"] = % sdr_mp_infil_ac130_loop_pl02;
  level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_loop_pl03"] = % sdr_mp_infil_ac130_loop_pl03;
  level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_loop_pl04"] = % sdr_mp_infil_ac130_loop_pl04;
  level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_loop_doorchief"] = % sdr_mp_infil_ac130_loop_doorchief;
  level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_jump_genpropx10"] = % sdr_mp_infil_ac130_jump_genpropx10;
  level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_jump_genpropx10_90_l"] = % sdr_mp_infil_ac130_jump_genpropx10_90_l;
  level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_jump_genpropx10_180_l"] = % sdr_mp_infil_ac130_jump_genpropx10_180_l;
  level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_jump_genpropx10_90_r"] = % sdr_mp_infil_ac130_jump_genpropx10_90_r;
  level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_jump_genpropx10_180_r"] = % sdr_mp_infil_ac130_jump_genpropx10_180_r;
  level._id_1A209BD995A7FA83["sdr_mp_infil_ac130_redux_player1"] = % sdr_mp_infil_ac130_redux_player1;
  level._id_74320167A9D0ECAC = ::_id_BEA4801EA91BD2F4;
}

_id_BEA4801EA91BD2F4(animname) {
  if(!isDefined(level._id_1A209BD995A7FA83) || !isDefined(level._id_1A209BD995A7FA83[animname]))
    return 0;

  return getanimlength(level._id_1A209BD995A7FA83[animname]);
}

_id_E128261218FAFDAA(player) {
  _id_4A99009E075A9364 = "j_prop_1";
  _id_4FEBD9F54A7E9968 = "j_prop_17";
  _id_1EDD840D40B43222 = _id_4A99009E075A9364;
  return _id_1EDD840D40B43222;
}

_id_BA06F4E43FDA185E() {}

_id_6D8AC534AD288AA5(player) {
  _id_384446A35F40358C = undefined;
  _id_F5B09A636E6E3153 = [1, 2, 3, 4];
  _id_A6AB8D0FDA441DC2 = level.players;
  player._id_DB122A8941DFEE14 = _id_A6AB8D0FDA441DC2.size;

  foreach(_id_736D8D9188CCBD45 in _id_A6AB8D0FDA441DC2) {
    if(_id_736D8D9188CCBD45 == player) {
      continue;
    }
    if(isDefined(_id_736D8D9188CCBD45.infilanimindex))
      _id_F5B09A636E6E3153 = scripts\engine\utility::array_remove(_id_F5B09A636E6E3153, _id_736D8D9188CCBD45.infilanimindex);
  }

  if(_id_F5B09A636E6E3153.size == 0)
    _id_F5B09A636E6E3153[0] = 1;

  player.infilanimindex = _id_F5B09A636E6E3153[0];
}

_id_8839D2F2F530A0B9(player) {
  _id_599217E02A6DA3FA = self._id_6F8E05E25EB697A4[player.infilanimindex - 1].ent;
  animname = self._id_6F8E05E25EB697A4[player.infilanimindex - 1].animname;
  player playerlinkTo(_id_599217E02A6DA3FA, "tag_player");
  player playanimscriptsceneevent("scripted_scene", animname);
  _id_C7F1D28E52436ECD = _id_0F18696AC7694ED9();
  player cameraset(_id_C7F1D28E52436ECD);
}

_id_0F18696AC7694ED9() {
  if(isDefined(level.infilstruct._id_AD3C883FBFF215B5) && isDefined(self._id_DB122A8941DFEE14) && self._id_DB122A8941DFEE14 == 1)
    return level.infilstruct._id_AD3C883FBFF215B5;

  if(isarray(level.infilstruct._id_6D575C4DFA5D6788)) {
    _id_015314DA30B44470 = 0;

    if(isDefined(self.infilanimindex))
      _id_015314DA30B44470 = self.infilanimindex - 1;

    return level.infilstruct._id_6D575C4DFA5D6788[_id_015314DA30B44470];
  }

  return level.infilstruct._id_6D575C4DFA5D6788;
}

_id_D4561AB1BA4F5DE9(ent, _id_E6783D526B4A7212, animation, _id_437B6BB41D98DF26) {
  self._id_2336099A20080602 = spawnStruct();
  self._id_2336099A20080602.ent = ent;
  self._id_2336099A20080602._id_E6783D526B4A7212 = _id_E6783D526B4A7212;

  if(isDefined(_id_437B6BB41D98DF26)) {
    self._id_2336099A20080602._id_437B6BB41D98DF26 = _id_437B6BB41D98DF26;

    if(!self._id_79D924275E2B5029) {
      _id_8355076D4ED3FC96 = _func_4358B309FDCC6D44(_id_437B6BB41D98DF26);
      _id_8355076D4ED3FC96 = _id_8355076D4ED3FC96 - 0.033;
      _id_8355076D4ED3FC96 = _id_8355076D4ED3FC96 - scripts\engine\utility::mod(_id_8355076D4ED3FC96, 0.05);
      self._id_2336099A20080602._id_8355076D4ED3FC96 = _id_8355076D4ED3FC96;
    }
  } else if(!self._id_79D924275E2B5029)
    self._id_2336099A20080602.animlength = getanimlength(animation);
}

_id_645E253A5ACFF80C(wait_time) {
  level endon("game_ended");
  level notify("start_infil_timer");
  level endon("start_infil_timer");
  self endon("death");
  setomnvar("cp_countdown_color", 0);
  _id_E84E755251284EC2 = gettime() + wait_time * 1000;
  setomnvar("cp_wave_timer", int(_id_E84E755251284EC2));

  if(wait_time - 10 > 0) {
    wait(wait_time - 10);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++) {
      setomnvar("cp_countdown_color", 2);
      wait 1;
    }
  }

  setomnvar("cp_wave_timer", 0);
}
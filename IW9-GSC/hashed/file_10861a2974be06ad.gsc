/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_10861a2974be06ad.gsc
***********************************************/

main() {
  if(!scripts\engine\utility::flag_exist("pause_trigger_spawn"))
    scripts\engine\utility::flag_init("pause_trigger_spawn");

  level.interactions_disabled = 1;
  level.disable_nvg = 1;
  _id_755EED203B240B2C::main();
  _id_16F78C89995034F6::main();
  _id_678ADBED602DA5EB::_id_534445B413445ADE();
  _id_75A661841BEB405C::main();
  _id_16F78C89995034F6::main();
  setomnvar("requires_scriptmover_ladder_checks", 1);

  if(getdvarint("dvar_742CAA13B3C2E685", 0)) {
    return;
  }
  if(!_id_0598E0C00C8151F7::_id_54F6F9D73EB5378C()) {
    scripts\cp\utility::_id_3069B525E1C98FAF("Intro");
    setDvar("dvar_47B7445B595408F7", 1);
    level._id_D9B24DFD45B657CB = 1;
    level._id_633EE74E2649AAC7 = ::_id_633EE74E2649AAC7;
    level.default_player_spawns = "start_spawners";
    level._id_3ABDB45E8244CE30 = 1;

    if(!isDefined(game["restart_checkpoint"]))
      game["startAtSamSite"] = undefined;

    if(isDefined(game["startAtSamSite"])) {
      scripts\engine\utility::flag_set("pause_trigger_spawn");
      site = game["startAtSamSite"];

      switch (site) {
        case "a":
          level.default_player_spawns = "samsite_a_spawners";
          break;
        case "b":
          level.default_player_spawns = "samsite_b_spawners";
          break;
        case "c":
          level.default_player_spawns = "samsite_c_spawners";
          break;
      }
    }
  } else {
    scripts\cp\utility\player::overridevisionsetnightforlevel("nvg_base_color");
    level.coop_gameshouldendfunc = _id_0AFB7E332AEE4BF2::_id_05ECCC8D9829E62A;
    _id_4C2E15BC834E979B::_id_1DE23056D804ED55();
    level.default_player_spawns = "heli_escort_spawners";
    level._id_CEE48B761F8CA747 = 1;
  }

  level.disable_start_spawn_on_navmesh = 1;
  setDvar("bg_compassShowEnemies", 0);
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_st_lodDistanceScale", 1.0);
  setDvar("cg_defaultWindFrequencyScale", 1.2);
  setDvar("cg_defaultWindAmplitudeScale", 2);
  setDvar("cg_defaultWindAreaScale", 50);
  setDvar("cg_defaultWindNoiseScale", 0.1);
  setDvar("cg_defaultWindStrength", 300);
  setDvar("cg_defaultWindDir", (1, 0, 0));
  setDvar("r_vertexDeformCutOffDist", 6000);
  setDvar("r_shimmereffectinteriorfillintensityfar", 1);
  setDvar("r_shimmerEffectInteriorFillIntensityNear", 0);
  setDvar("r_shimmereffectexteriorlinestrength", 0.6);
  setDvar("r_shimmereffectfardistance", 1000);
  setDvar("dvar_F8332F8A8CEDCA1C", 1);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_2D59DEB63C029EA8", 0, 1);
  level._id_D39DF167F3A996B0 = 1;

  if(level.createfx_enabled) {
    return;
  }
  scripts\cp\utility::coop_mode_enable(["sp_stealth"]);
  _id_D525F1534752BFC7();
  _id_2CFEF434CE6A1C44();
  _id_279964C2C969DDA3();
  _id_3861EB0A004E0D38();

  if(!_id_0598E0C00C8151F7::_id_54F6F9D73EB5378C()) {
    level._id_D1D6757F3C58E700 = ::_id_244B885B7CEAEF36;
    level.post_loadout_spawn_func = ::_id_E7F65C4152B55648;
    level._id_F42102B6DE7CE00D = ::_id_886E427DAE095878;
  } else
    level._id_F42102B6DE7CE00D = ::_id_DD53497DEB7A9D07;

  _id_C4D555BF9485AC3B();
  _id_E0125729CABDA438();
  level thread _id_73B8B21BF4E3319E::_id_FFDF58E4D2F91BBF();
  level thread _id_7EA61A73C7EE5FEC::_id_4199FA5F46D84613();
  level thread _id_86879C458815AB94();
  level._id_2F11073BD9CEB3E0 = 1;
  level._id_CEE48B761F8CA747 = 1;
  scripts\cp_mp\utility\script_utility::registersharedfunc("scriptablePickup", "takeEquipment", ::_id_4C79FF40C1F97323);
  scripts\cp_mp\utility\script_utility::registersharedfunc("flares", "playFx", ::flares_playfx);

  if(_id_0598E0C00C8151F7::_id_54F6F9D73EB5378C())
    thread _id_60A9B20AF403D893::setup_functions();
  else
    _id_6EC6FB09E17942A9::setup_functions();

  scripts\cp\utility::add_start("gauntlet_intro", undefined, _id_6AFE98B58D628734::_id_808702446B6BFFB3);
  scripts\cp\utility::add_start("gauntlet_intro_complete", undefined, _id_6AFE98B58D628734::_id_4E26236569C2AE4A);
  scripts\cp\utility::add_start("gauntlet_exfil", undefined, _id_6AFE98B58D628734::_id_28DDC63BC1259ED1);
  scripts\cp\utility::add_start("gauntlet_apache_test", undefined, _id_6AFE98B58D628734::_id_FBCF2C9080275089);
  scripts\cp\utility::add_start("gauntlet_c4heli_test", undefined, _id_6AFE98B58D628734::_id_9C72EF06652E87C4);
  scripts\cp\utility::add_start("gauntlet_intro_flyby", undefined, _id_6AFE98B58D628734::_id_77845A860B8AC76D);
  scripts\cp\utility::add_start("support_heli_monument");
  scripts\cp\utility::add_start("support_heli_house");
  scripts\cp\utility::add_start("support_heli_gasstaation");
  scripts\cp\utility::add_start("support_heli_culdesac");
  scripts\cp\utility::add_start("support_heli_escape");
  scripts\cp\utility::add_start("support_heli_profile");
  level._id_364C64AC310725A0 = 1;
  thread scripts\cp\intel\cp_intel::intel_init();
  level._id_C511DF4AAA679C10 = ["brloot_plate_pouch", "brloot_offhand_molotov", "brloot_offhand_semtex", "brloot_self_revive", "brloot_offhand_c4"];
}

_id_DD53497DEB7A9D07(eattacker, enemy, sweapon) {
  if(isDefined(level._id_AC4465139E7E9D5B) && isDefined(level._id_AC4465139E7E9D5B.script_noteworthy)) {
    _id_B3D3AF7B735AFB37 = "";

    if(isDefined(self._id_AC19F9B9C6C841B9)) {
      if(self._id_AC19F9B9C6C841B9 == "chopper")
        _id_B3D3AF7B735AFB37 = "Chopper Pilot: ";
      else
        _id_B3D3AF7B735AFB37 = "Ground Soldier: ";
    }

    return _id_B3D3AF7B735AFB37 + level._id_AC4465139E7E9D5B.script_noteworthy;
  }

  return "Intro";
}

_id_886E427DAE095878(eattacker, enemy, sweapon) {
  _id_B7BC529921E4AD54 = "";

  if(scripts\engine\utility::flag_exist("intro_completed") && !scripts\engine\utility::flag("intro_completed"))
    return "Intro";
  else if(scripts\engine\utility::flag_exist("start_samsites") && scripts\engine\utility::flag("start_samsites"))
    return "Post-intro";
  else if(scripts\engine\utility::flag_exist("sites_destroyed") && scripts\engine\utility::flag("sites_destroyed"))
    return "Exfil";
  else {
    _id_BC24CC2430B71F0A = _id_6AFE98B58D628734::_id_22CDC9BDD0A96C1E();

    if(_id_BC24CC2430B71F0A == "intro")
      return "Intro";

    return "Sam Site: " + _id_BC24CC2430B71F0A;
  }
}

_id_2ED2B6259AF70E03() {
  if(istrue(level._id_AC775ED66AAEB771))
    return "exfil";

  _id_45407CE4220025A8 = spawnStruct();
  _id_45407CE4220025A8.origin = (-6801, 13823, 1068);
  _id_45407CE4220025A8.name = "objective_a";
  _id_8731843E94692097 = spawnStruct();
  _id_8731843E94692097.origin = (-1424, 4846, 1413);
  _id_8731843E94692097.name = "objective_b";
  _id_A560D36F3F48EDE2 = spawnStruct();
  _id_A560D36F3F48EDE2.origin = (-13559, 6517, 901);
  _id_A560D36F3F48EDE2.name = "objective_c";
  objective_array = [_id_45407CE4220025A8, _id_8731843E94692097, _id_A560D36F3F48EDE2];
  _id_9FA1D7E22A0F8C85 = sortbydistance(objective_array, self.origin);
  _id_6BC9557C53B7E270 = _id_9FA1D7E22A0F8C85[0];
  _id_923DC60F0CAEF99E = _id_6BC9557C53B7E270.name;
  return _id_923DC60F0CAEF99E;
}

_id_633EE74E2649AAC7(_id_8B065B1B8825808B) {
  if(istrue(_id_8B065B1B8825808B)) {
    game["samsites_completed"] = undefined;
    game["startAtSamSite"] = undefined;
  }

  setDvar("start", "gauntlet_intro");
  scripts\cp\cp_checkpoint::checkpoint_set("");
}

_id_244B885B7CEAEF36(attacker, type, objweapon) {
  if(isDefined(objweapon) && istrue(objweapon._id_AFCD53CFA79ABCCF))
    return 1;

  if(isDefined(attacker) && istrue(attacker._id_AFCD53CFA79ABCCF))
    return 1;

  return 0;
}

_id_2CFEF434CE6A1C44() {
  level.custom_onspawnplayer_func = ::onplayerspawned;
  level.custom_onplayerconnect_func = ::onplayerconnect;
  level.maxagents = 48;
}

onplayerconnect(player) {}

onplayerspawned() {
  if(!_id_0598E0C00C8151F7::_id_54F6F9D73EB5378C()) {
    thread _id_699EA627E58D5D01();
    thread _id_1C8C03372BADE56E();
  } else
    thread _id_8A9CA5A605B94F6D();

  _id_7AB5B649FA408138::_id_0F1AED36AB4598EA("saba_cp_mission_esc");
}

_id_87A00D574D761103() {
  _id_60F8C3142E229A97 = scripts\cp\cp_objectives::get_active_objectives();

  if(_id_60F8C3142E229A97.size <= 0)
    return _id_0598E0C00C8151F7::_id_54F6F9D73EB5378C();

  _id_682644DBD89854FD = ["support_heli_monument", "support_heli_house", "support_heli_mid", "support_heli_gasstaation", "support_heli_blueroof", "support_heli_culdesac", "support_heli_escape"];

  foreach(objective in _id_60F8C3142E229A97) {
    if(scripts\engine\utility::array_contains(_id_682644DBD89854FD, objective.objname))
      return 1;
  }

  return 0;
}

_id_E7F65C4152B55648() {
  if(!istrue(_id_87A00D574D761103())) {
    return;
  }
  if(!isDefined(level._id_481E8B82B0934EB3))
    level._id_481E8B82B0934EB3 = scripts\engine\utility::getStructArray("hills_player_start", "script_noteworthy");

  if(level._id_481E8B82B0934EB3.size > 0) {
    self setOrigin(level._id_481E8B82B0934EB3[0].origin, 1);
    scripts\engine\utility::array_remove(level._id_481E8B82B0934EB3, level._id_481E8B82B0934EB3[0]);
  }
}

setup_player_stealth() {
  if(istrue(_id_87A00D574D761103())) {
    return;
  }
  if(scripts\cp\coop_stealth::level_should_run_sp_stealth()) {
    scripts\engine\utility::flag_wait("level_stealth_initialized");
    scripts\stealth\player::main();
    thread scripts\cp\coop_stealth::suspicious_door_monitor();
  }
}

_id_699EA627E58D5D01() {
  self endon("death_or_disconnect");

  if(!istrue(_id_87A00D574D761103())) {
    return;
  }
  wait 2;
  self.perk_data["friendly_explosive_damage_reduction"] = 0.1;
}

_id_279964C2C969DDA3() {
  scripts\cp\cp_gameskill::init_gameskill();
  level thread scripts\cp\cp_movers::main();
  scripts\cp\coop_stealth::_id_53C55A0C7AF36050();
  scripts\cp\coop_stealth::_id_18CD746FF947FF3C("intro_guys");
}

_id_3861EB0A004E0D38() {
  level.objectivesfunc = ::levelobjectives_init;
  level thread scripts\cp\cp_objectives::objectives_init();
}

_id_C4D555BF9485AC3B() {
  scripts\cp\utility::_id_BB3E0C926B0667C4("gauntlet_intro,gauntlet_samsites,gauntlet_exfil,support_heli_monument,support_heli_house,support_heli_gasstaation,support_heli_culdesac");
  setup_create_script();
  _id_1D4B3317D05E305E = ["gauntlet_intro", "gauntlet_samsites", "gauntlet_exfil"];
  _id_646EB55FB1C0ED7A = ::_id_BE5411238BC6CD04;
  scripts\cp\cp_checkpoint::_id_9DF80FF2F32ED96D("veh_escape", _id_1D4B3317D05E305E, _id_646EB55FB1C0ED7A, undefined);
  scripts\cp\cp_checkpoint::_id_A83214EC9CBF5BC8("veh_escape", "gauntlet_intro_complete", _id_6EC6FB09E17942A9::_id_1C8293D147FFDB05, undefined);
  scripts\cp\cp_checkpoint::_id_A83214EC9CBF5BC8("veh_escape", "gauntlet_sam1destroyed", _id_6EC6FB09E17942A9::_id_2957CE9B885714F2, undefined);
  scripts\cp\cp_checkpoint::_id_A83214EC9CBF5BC8("veh_escape", "gauntlet_sam2destroyed", _id_6EC6FB09E17942A9::_id_2957CE9B885714F2, undefined);
  scripts\cp\cp_checkpoint::_id_A83214EC9CBF5BC8("veh_escape", "gauntlet_sam3destroyed", _id_6EC6FB09E17942A9::_id_2957CE9B885714F2, undefined);
  _id_CAA8F08C7F0667A2 = ["support_heli_monument", "support_heli_house", "support_heli_gasstaation", "support_heli_culdesac", "support_heli_profile"];
  _id_B3DD9B12BD388316 = _id_60A9B20AF403D893::_id_0BB848A1122EC21B;
  scripts\cp\cp_checkpoint::_id_9DF80FF2F32ED96D("heli_escort", _id_CAA8F08C7F0667A2, _id_B3DD9B12BD388316, "heli_escort_spawners");
  scripts\cp\cp_checkpoint::_id_A83214EC9CBF5BC8("heli_escort", "checkpoint_monument", _id_60A9B20AF403D893::_id_9E10A8CCA3D36B8D, "heli_escort_spawners");
  scripts\cp\cp_checkpoint::_id_A83214EC9CBF5BC8("heli_escort", "checkpoint_house", _id_60A9B20AF403D893::_id_E4C00EEFAFF67902, "heli_escort_spawners");
  scripts\cp\cp_checkpoint::_id_A83214EC9CBF5BC8("heli_escort", "checkpoint_gasstation", _id_60A9B20AF403D893::_id_F7F3CE6AE1E4CA8B, "heli_escort_spawners");
  scripts\cp\cp_checkpoint::_id_A83214EC9CBF5BC8("heli_escort", "checkpoint_culdesac", _id_60A9B20AF403D893::_id_EA9B50FEF7A93398, "heli_escort_spawners");
  level thread _id_FC4803DC319A81D2();
  scripts\engine\utility::flag_set("interactions_initialized");

  if(!_id_0598E0C00C8151F7::_id_54F6F9D73EB5378C()) {
    scripts\cp\compass::setupminimap("compass_map_cp_mission_esc", 2);
    _id_2B8328ECE93D27E8 = getdvarint("dvar_015E07AE1EDA1E54", 40);
    _id_4318EE1BD183877A = getdvarint("dvar_2184A29399EFB56E", 25);
    _id_769605765556618C = getdvarint("dvar_A46BB3AA1C5C9640", 16);
    _id_7EA61A73C7EE5FEC::_id_4A3F0DF20443F4DA();
    _id_F13A4CA1FF3C4E13();
    _id_1A347438F95AE421();
  } else {
    level.localeid = "locale_heli_escort_1";
    scripts\cp\compass::setupminimap("compass_map_cp_heli_escort_1", 2, 1);
    _id_2B8328ECE93D27E8 = getdvarint("dvar_63D4117E6E4964B4", 50);
    _id_4318EE1BD183877A = getdvarint("dvar_47D0ABA115C84ECE", 20);
    _id_769605765556618C = getdvarint("dvar_23F372CABCEBDBA0", 15);
    _id_12E2FB553EC1605E::_id_E2D370937C694C58("iw9_dm_mike14_mp", ["grip"], "iw9_pi_papa220_mp", ["pgrip_tac"]);
    _id_12E2FB553EC1605E::_id_EBF2582B122904FC("equip_semtex", "equip_flash");
    _id_A4EF1CBF2EB8657A();
    _id_4AE04797EA1C5E08::main();
  }

  _id_1E22D314CC16F807::_id_6CCB377E839D87C4(_id_2B8328ECE93D27E8 * 60, _id_4318EE1BD183877A * 60, _id_769605765556618C * 60);

  if(scripts\cp\coop_stealth::level_should_run_sp_stealth())
    scripts\engine\utility::flag_set("level_stealth_initialized");
}

_id_E0125729CABDA438() {
  _id_6FBA7DF440C493C4::init_vehicles();
  _id_0E80538EF14D00E1::register_combined_vehicles(_id_3AF63BEEAAB2E0A7::main, "veh9_civ_lnd_techo_rebel_armor_cp", "veh9_techo_physics_cp", "script_vehicle_iw9_truck_techo_rebel_armor", undefined, "techo_ai_armor", "techo_ai_armor");
  _id_0E80538EF14D00E1::register_combined_vehicles(_id_516851C4CA47F492::main, "veh9_mil_air_heli_medium_vehphys_mp", "veh9_mil_air_heli_medium_mp", "script_vehicle_heli_medium", undefined, "veh9_mil_air_heli_medium_mp", "veh9_mil_air_heli_medium_mp");
  _id_4BEC22BA9253C63C::main("veh9_mil_lnd_jltv_turret_vehphys_mp", "veh9_jltv_physics_sp", "script_vehicle_iw9_jltv_physics");
  _id_4BEC22BA9253C63C::main("veh9_mil_lnd_jltv_turret_vehphys_mp", "veh9_jltv_mg_physics_mp", "script_vehicle_veh9_jltv_mg_ai");
}

_id_F13A4CA1FF3C4E13() {
  _id_12E2FB553EC1605E::_id_E2D370937C694C58("iw9_dm_mike14_mp", ["fourxtherm02_highzoom", "laser", "silencer"], "iw9_pi_papa220_mp", ["pgrip_tac", "reflex", "silencer", "laser"]);
  _id_12E2FB553EC1605E::_id_EBF2582B122904FC("equip_semtex", "equip_flash");
}

setup_create_script() {
  scripts\cp\cp_create_script_utility::init_create_script_for_level();

  if(_id_0598E0C00C8151F7::_id_54F6F9D73EB5378C())
    scripts\cp\cp_create_script_utility::register_create_script_arrays("cp_heli_escort_cs", "cp_heli_escort_cs", level.scripted_spawner_func.size, _id_14F6E2B0E69FB499::main);
  else
    scripts\cp\cp_create_script_utility::register_create_script_arrays("cp_mission_esc_create_script", "cp_mission_esc_create_script", level.scripted_spawner_func.size, _id_0AACD4ED271A8158::main);
}

_id_FC4803DC319A81D2() {
  level thread wait_for_pre_game_period();
  level thread wait_for_strike_init_complete();
}

wait_for_pre_game_period() {
  level endon("game_ended");
  wait 0.2;
}

wait_for_strike_init_complete() {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("strike_init_done"))
    scripts\engine\utility::flag_wait("strike_init_done");

  wait 1;
  _id_7EA61A73C7EE5FEC::_id_F7A95F0080A7221B();

  if(!istrue(_id_87A00D574D761103())) {
    scripts\cp\cp_spawning_util::_id_5EBBD91D2F142DBC();
    _id_573394DB6CBE57E3();
  }

  level thread scripts\cp\cp_checkpoint::_id_D4CDC242233C15B3();
}

_id_573394DB6CBE57E3() {
  _id_7EA61A73C7EE5FEC::_id_10FBBCF3D0D12043();
  thread _id_70617E61BC4D13CA();
  level thread _id_0F0F82FC78960925();
  level thread _id_7EA61A73C7EE5FEC::_id_033C0CF13AB46538();
  level thread _id_7EA61A73C7EE5FEC::_id_21DCD2A775A0726C();
}

_id_BE5411238BC6CD04() {
  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(isDefined(checkpoint) && checkpoint != "" && isDefined(level.registered_checkpoint_funcs[checkpoint]))
    level thread[[level.registered_checkpoint_funcs[checkpoint]]]();
}

_id_0F0F82FC78960925() {
  _id_30AB6942C287EEDA = scripts\engine\utility::getStructArray("beacon_fx", "targetname");

  foreach(beacon in _id_30AB6942C287EEDA)
  playFX(level._effect["vfx_ammo_beacon"], beacon.origin);
}

levelobjectives_init() {
  level.objectives_table = "cp/cp_mission_esc_objectives.csv";
  level.objectivesmatrixtable = "cp/cp_mission_esc_objectives_matrix.csv";
  level.objectiveregistration = ::_id_77765E5DD4C9DB54;
  scripts\cp\cp_objectives::parseobjectivestable(level.objectives_table);
}

_id_77765E5DD4C9DB54() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  scripts\engine\utility::flag_wait("objective_table_parsed");

  if(_id_0598E0C00C8151F7::_id_54F6F9D73EB5378C())
    _id_4C2E15BC834E979B::_id_60E2E00DE592B581();
  else
    _id_6AFE98B58D628734::register_objectives();
}

_id_D525F1534752BFC7() {
  setDvar("sm_sunSampleSizeNear", 1.25);
  setDvar("r_umbraMinObjectContribution", 4);
  setDvar("r_umbraAccurateOcclusionThreshold", 2048);
  setDvar("sm_roundRobinPrioritySpotShadows", 8);
  setDvar("sm_spotUpdateLimit", 8);
  setDvar("dvar_85759DB2B09D61B3", 1);
  scripts\engine\utility::flag_set("infil_complete");
}

onplayerspawneddevguisetup(player) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    if(level.players[_id_AC0E594AC96AA3A8] == player) {
      player thread _id_CAB08C75E0639EA0(player, _id_AC0E594AC96AA3A8);
      break;
    }
  }
}

_id_A4EF1CBF2EB8657A() {
  _id_28133FB056DA986B = getEntArray("heli_escort_init_blockers", "script_noteworthy");
  _id_F9D724F17D83E748 = getEntArray("heli_escort_start_collision", "targetname");

  foreach(_id_32595262B98E6F31 in _id_F9D724F17D83E748)
  _id_32595262B98E6F31 moveTo((-28368, -43328, 2180), 0.1, 0, 0);

  _id_AB8B1D2C5D33156A = getEntArray("poi_truck_collision", "targetname");
  _id_75F8193973203BFA = getEntArray("veh_escape_init_blockers", "targetname");
  _id_C70EF01F81E274D3 = scripts\cp\utility::array_merge(_id_AB8B1D2C5D33156A, _id_75F8193973203BFA);

  foreach(_id_32595262B98E6F31 in _id_C70EF01F81E274D3)
  _id_32595262B98E6F31 delete();
}

_id_1A347438F95AE421() {
  _id_AB8B1D2C5D33156A = getEntArray("poi_truck_collision", "targetname");

  foreach(_id_32595262B98E6F31 in _id_AB8B1D2C5D33156A)
  _id_32595262B98E6F31 moveTo((-28368, -43328, 2180), 0.1, 0, 0);

  _id_28133FB056DA986B = getEntArray("heli_escort_init_blockers", "script_noteworthy");
  _id_44E5ABF211186908 = getEntArray("heli_escort_start_collision", "targetname");
  _id_930D61B39E386DB9 = getEntArray("heli_servers", "targetname");
  _id_998DF5268EA6CC05 = scripts\cp\utility::array_merge(_id_28133FB056DA986B, _id_44E5ABF211186908);
  _id_998DF5268EA6CC05 = scripts\cp\utility::array_merge(_id_998DF5268EA6CC05, _id_930D61B39E386DB9);

  if(isDefined(_id_998DF5268EA6CC05) && _id_998DF5268EA6CC05.size > 0) {
    foreach(_id_32595262B98E6F31 in _id_998DF5268EA6CC05)
    _id_32595262B98E6F31 delete();
  }

  _id_8B7841F349CB3F9C = getEntArray("heli_start_lamp", "targetname");

  if(isDefined(_id_8B7841F349CB3F9C)) {
    foreach(_id_7785552B2CB13D87 in _id_8B7841F349CB3F9C)
    _id_7785552B2CB13D87 setlightintensity(0);
  }
}

_id_CAB08C75E0639EA0(player, num) {
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Players/" + player.name + "/Change to Thorne\" \"set change_char " + num + " 20\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Players/" + player.name + "/Change to Nikto\" \"set change_char " + num + " 10\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
}

_id_70617E61BC4D13CA() {
  _id_2C2B546872E8E8FB = scripts\engine\utility::getStructArray("gl_pickup", "targetname");
  _id_22AA68498BA39190 = scripts\engine\utility::getStructArray("lmg_pickup", "targetname");
  _id_8820F7AB0A58562D = scripts\engine\utility::getStructArray("pila_pickup", "targetname");
  sniper_pickup = scripts\engine\utility::getStruct("sniper_pickup", "targetname");

  foreach(_id_CE292778F57C122A in _id_2C2B546872E8E8FB) {
    objweapon = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("iw9_la_mike32_mp");
    weapon = _id_66122A002AFF5D57::createspawnweaponatpos(_id_CE292778F57C122A.origin + (0, -2.5, 0), _id_CE292778F57C122A.angles + (0, 90, 270), objweapon, 1);
    weapon _id_66122A002AFF5D57::_id_86321FC8F45C2A9B(1);
    weapon _id_66122A002AFF5D57::_id_B10EE40ED82D45C9(1);
  }

  foreach(_id_47175B042B5B15BB in _id_22AA68498BA39190) {
    objweapon = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("iw9_lm_kilo21_mp");
    objweapon = objweapon _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["holo", "silencer"]);
    weapon = _id_66122A002AFF5D57::createspawnweaponatpos(_id_47175B042B5B15BB.origin, _id_47175B042B5B15BB.angles + (0, 90, 0), objweapon, 1);
    weapon _id_66122A002AFF5D57::_id_86321FC8F45C2A9B(0);
    weapon _id_66122A002AFF5D57::_id_B10EE40ED82D45C9(1);
  }

  foreach(_id_3E90559F2EF41445 in _id_8820F7AB0A58562D) {
    objweapon = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("iw9_la_gromeo_mp");
    weapon = _id_66122A002AFF5D57::createspawnweaponatpos(_id_3E90559F2EF41445.origin + (1, 2, 0), _id_3E90559F2EF41445.angles + (0, 90, 270), objweapon, 1);
    weapon _id_66122A002AFF5D57::_id_86321FC8F45C2A9B(1);
    weapon _id_66122A002AFF5D57::_id_B10EE40ED82D45C9(1);
  }

  objweapon = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("iw9_sn_limax_mp");
  objweapon = objweapon _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["bar_sn_p23", "bgrip_sn_p23", "iw9_snprscope_alpha50", "mag_sn_p23", "rec_alpha50", "silencer04_sn", "stock_sn_p23"]);
  weapon = _id_66122A002AFF5D57::createspawnweaponatpos(sniper_pickup.origin, sniper_pickup.angles, objweapon, 1);
  weapon _id_66122A002AFF5D57::_id_86321FC8F45C2A9B(1);
  weapon _id_66122A002AFF5D57::_id_B10EE40ED82D45C9(1);
  molotovs = scripts\engine\utility::getStructArray("molotov_pickup", "targetname");
  grenades = scripts\engine\utility::getStructArray("semtex_pickup", "targetname");
  c4s = scripts\engine\utility::getStructArray("c4_pickup", "targetname");
  _id_DB515C2CA5561EFA = scripts\engine\utility::getStructArray("self_revive_pickup", "targetname");

  foreach(molotov in molotovs) {
    _id_06FE80416B4BE165 = _id_66122A002AFF5D57::getitemdropinfo(molotov.origin, (0, 0, -90));
    _id_CD9D13143E83EEC9 = "brloot_offhand_molotov";
    item = _id_66122A002AFF5D57::spawnpickup(_id_CD9D13143E83EEC9, _id_06FE80416B4BE165, 4, undefined, undefined, 0);
    waitframe();
  }

  foreach(grenade in grenades) {
    _id_06FE80416B4BE165 = _id_66122A002AFF5D57::getitemdropinfo(grenade.origin, (0, 0, 0));
    _id_CD9D13143E83EEC9 = "brloot_offhand_semtex";
    item = _id_66122A002AFF5D57::spawnpickup(_id_CD9D13143E83EEC9, _id_06FE80416B4BE165, 4, undefined, undefined, 0);
    waitframe();
  }

  foreach(c4 in c4s) {
    _id_06FE80416B4BE165 = _id_66122A002AFF5D57::getitemdropinfo(c4.origin, c4.angles + (0, 0, -90));
    _id_CD9D13143E83EEC9 = "brloot_offhand_c4";
    item = _id_66122A002AFF5D57::spawnpickup(_id_CD9D13143E83EEC9, _id_06FE80416B4BE165, 4, undefined, undefined, 0);
    waitframe();
  }

  foreach(_id_E751C7771E6A1E5C in _id_DB515C2CA5561EFA) {
    _id_06FE80416B4BE165 = _id_66122A002AFF5D57::getitemdropinfo(_id_E751C7771E6A1E5C.origin, _id_E751C7771E6A1E5C.angles);
    _id_CD9D13143E83EEC9 = "brloot_self_revive";
    item = _id_66122A002AFF5D57::spawnpickup(_id_CD9D13143E83EEC9, _id_06FE80416B4BE165, 1, 1);
  }
}

_id_24B4CDFB8AFEE3FF(type) {
  for(;;) {
    self waittill("trigger", player);
    player _id_66122A002AFF5D57::_id_EE5540242EF172D4();

    switch (type) {
      case "c4":
        player _id_1E17EB66A58DFDFA();
        break;
      case "semtex":
        player _id_2222C4BC97447AD9();
        break;
      case "molotov":
        player _id_5DE630FED2CA5161();
        break;
      case "armor":
        player _id_07C40FA80892A721::_id_9C6E9A6643B6C9A6(5);
        break;
    }
  }
}

_id_8A9CA5A605B94F6D() {
  self endon("death_or_disconnect");
  self endon("last_stand");
  level waittill("player_spawned_with_loadout");
  _id_07C40FA80892A721::givestartingarmor(180, 5);
}

_id_1C8C03372BADE56E() {
  self endon("death_or_disconnect");
  self endon("last_stand");
  level waittill("player_spawned_with_loadout");

  if(scripts\cp\cp_relics::is_relic_active("relic_rocket_kill_ammo")) {
    scripts\cp\utility::giveperk("specialty_blastshield");
    scripts\cp\utility::giveperk("specialty_fastreload_launchers");
  }

  self._id_4D572A54ED8571C4 = 1;
}

_id_4C79FF40C1F97323(instance) {
  switch (instance.scriptablename) {
    case "brloot_offhand_semtex":
      _id_2222C4BC97447AD9();
      break;
    case "brloot_offhand_molotov":
      _id_5DE630FED2CA5161();
      break;
    case "brloot_offhand_c4":
      _id_1E17EB66A58DFDFA();
      break;
  }

  self playlocalsound("weap_ammo_pickup");
  thread _id_354C862768CFE202::hudicontype("ammobox");
  return 1;
}

_id_1E17EB66A58DFDFA() {
  _id_940EBB321300CD65 = 4;
  _id_34D1187370A405EE = _id_4C99D5F08C48ED71::_id_E5EA666722BE9CD0(_id_940EBB321300CD65);
  _id_7EF95BBA57DC4B82::giveequipment("equip_c4", "primary");
  _id_7EF95BBA57DC4B82::setequipmentammo("equip_c4", _id_34D1187370A405EE);
}

_id_2222C4BC97447AD9() {
  _id_940EBB321300CD65 = 4;
  _id_34D1187370A405EE = _id_4C99D5F08C48ED71::_id_E5EA666722BE9CD0(_id_940EBB321300CD65);
  _id_7EF95BBA57DC4B82::giveequipment("equip_semtex", "primary");
  _id_7EF95BBA57DC4B82::setequipmentammo("equip_semtex", _id_34D1187370A405EE);
}

_id_5DE630FED2CA5161() {
  _id_940EBB321300CD65 = 4;
  _id_34D1187370A405EE = _id_4C99D5F08C48ED71::_id_E5EA666722BE9CD0(_id_940EBB321300CD65);
  _id_7EF95BBA57DC4B82::giveequipment("equip_molotov", "primary");
  _id_7EF95BBA57DC4B82::setequipmentammo("equip_molotov", _id_34D1187370A405EE);
}

_id_86879C458815AB94() {
  while(!scripts\engine\utility::flag_exist("scriptables_ready"))
    waitframe();

  scripts\engine\utility::flag_wait("scriptables_ready");
  barrels = getscriptablearray("scriptable_decor_barrels_gameplay_flammable_lowhealth", "classname");
  scripts\engine\utility::array_thread(barrels, ::_id_19964212851CA7EE);

  for(;;) {
    dead = 0;

    foreach(_id_DDC4E4BDECFF28CD in barrels) {
      if(!scripts\engine\utility::is_equal(_id_DDC4E4BDECFF28CD getscriptablepartstate("base", 1), "dead") || istrue(_id_DDC4E4BDECFF28CD.dead)) {
        continue;
      }
      _id_DDC4E4BDECFF28CD notify("stop_logic");
      _id_DDC4E4BDECFF28CD.dead = 1;
      dead++;
      waitframe();
    }

    if(dead == barrels.size) {
      return;
    }
    wait 1;
  }
}

_id_91555B291A7F8586() {
  if(!isDefined(level._id_6D758B6DAD2E27A9))
    level._id_6D758B6DAD2E27A9 = [(-13699.5, -24575.9, 2468.27), (-13714.6, -24603.2, 2469.1), (-13707.1, -24590.2, 2512.27), (-14124.5, -24322.7, 2425.77), (-14148.2, -24345.1, 2425.16), (-12950.8, -22864.9, 2472.96), (-12982.5, -22849, 2471.46), (-13176, -23776.7, 2504.48), (-13142.8, -23785.9, 2504.36), (-27357.8, -42932, 2204.96), (-27337.5, -42895.5, 2204.99), (-27625.7, -42623.5, 2227.99), (-27657.7, -42543.5, 2228), (-27641.7, -42591.5, 2228), (-32054, -12254.6, 2037.8), (-32034, -12228.6, 2037.8), (-30934, -12348.8, 2096.54), (-31482, -12321.2, 2038.58), (-31512, -12315.2, 2038.58), (-851.942, 15530.5, 5128.15), (-2259.94, 16746.5, 5188.16), (-3100.62, 7289.05, 4665.74), (-885.942, 15540.5, 5129.79), (-873.942, 15502.5, 5128.03), (-739.916, 16297, 5179.58), (-726.217, 16326.2, 5180.19), (-1813.22, 7943.29, 4680.98), (-1008.17, 9982.3, 4738.64)];

  if(scripts\engine\utility::array_contains(level._id_6D758B6DAD2E27A9, self.origin))
    return 1;

  return 0;
}

_id_19964212851CA7EE() {
  if(_id_91555B291A7F8586()) {
    self setscriptablepartstate("base", "removed");
    return;
  }

  self endon("stop_logic");
  self.health = 40;
  self._id_689D46E1E37CC5AD = ::_id_42A278B3CCDCFAD0;

  for(;;) {
    self waittill("damage", amount, attacker, direction_vec, damagelocation, meansofdeath, modelname, tagname, partname, _id_44E290FB31B85206, objweapon);
    _id_354C862768CFE202::process_damage_feedback(attacker, attacker, amount, _id_44E290FB31B85206, meansofdeath, objweapon, direction_vec, direction_vec, partname, undefined, self);
  }
}

_id_42A278B3CCDCFAD0(idamage) {
  if(idamage >= self.health)
    return 1;

  return 0;
}

flares_playFX(_id_74DA9C68920FF387, _id_5991F0E5DA9F9BD5) {
  _id_0023E275144756D0 = "tag_origin";

  if(isDefined(_id_5991F0E5DA9F9BD5))
    _id_0023E275144756D0 = _id_5991F0E5DA9F9BD5;

  playsoundatpos(self gettagorigin(_id_0023E275144756D0), "ks_apache_flares");

  if(self.vehicletype == "veh_apache_cp")
    playFXOnTag(level._effect["apache_flares"], self, _id_0023E275144756D0);
  else
    playFXOnTag(level._effect["lbravo_flares"], self, _id_0023E275144756D0);
}
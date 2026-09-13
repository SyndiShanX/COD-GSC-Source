/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6e1b074d84f0ab19.gsc
***********************************************/

main() {
  _id_0AA220B970A95554::main();
  _id_3851D05A27FF808A::main();
  _id_3543C05D3655E220::main();

  if(level.createfx_enabled) {
    return;
  }
  scripts\cp\utility::coop_mode_enable();
  _id_D525F1534752BFC7();
  _id_2CFEF434CE6A1C44();
  _id_279964C2C969DDA3();
  _id_3861EB0A004E0D38();
  _id_C4D555BF9485AC3B();
  _id_E0125729CABDA438();
  level.starting_currency = 4000;
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_47B7445B595408F7", 1, 0);
  level._id_633EE74E2649AAC7 = ::_id_633EE74E2649AAC7;
  level thread _id_510DCDCBF4FC993C();
  scripts\cp\utility::add_start("defender_infil", undefined, ::_id_F2220F29B3639954);
  scripts\cp\utility::add_start("defender_intro", undefined, ::_id_BEC3302A49F19844);
  scripts\cp\utility::add_start("defender_wave1", undefined, ::_id_AC10774E24A6A3DE);
  scripts\cp\utility::add_start("defender_wave2", undefined, ::_id_AC10764E24A6A1AB);
  scripts\cp\utility::add_start("defender_wave3", undefined, ::_id_AC10754E24A69F78);
  scripts\cp\utility::add_start("defender_wave4", undefined, ::_id_AC107C4E24A6AEDD);
  scripts\cp\utility::add_start("defender_wave5", undefined, ::_id_AC107B4E24A6ACAA);
  scripts\cp\utility::add_start("defender_wave6", undefined, ::_id_AC107A4E24A6AA77);
  scripts\cp\utility::add_start("defender_ending", undefined, ::_id_A3DB32CB6503E9B1);
  scripts\cp\utility::set_default_start("defender_infil");
  level._id_364C64AC310725A0 = 1;
  level.outofboundstime = 5;
  thread scripts\cp\intel\cp_intel::intel_init();
  thread _id_79F95F5F6D9EEB19::_id_5F2CDAE2726B2ACF();
}

_id_633EE74E2649AAC7(_id_97282C14346A7FCF) {
  level._id_0F3D1630DE429691 = 1;
  setDvar("start", "defender_infil");
  scripts\cp\cp_checkpoint::checkpoint_set("");
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_8169ECBE42B9A407", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_7D7E0BBD84A4488F", 0, 0);
}

_id_F2220F29B3639954() {
  level thread _id_3E19322333AD204C::main();
}

_id_BEC3302A49F19844() {
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_8169ECBE42B9A407", 1, 0);
  level thread _id_3E19322333AD204C::main();
}

_id_AC10774E24A6A3DE() {
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_8169ECBE42B9A407", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_7D7E0BBD84A4488F", 1, 0);
  level thread _id_3E19322333AD204C::main();
}

_id_AC10764E24A6A1AB() {
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_8169ECBE42B9A407", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_7D7E0BBD84A4488F", 1, 0);
  level._id_51444070C494BD3E = 2;
  level thread _id_3E19322333AD204C::main();
}

_id_AC10754E24A69F78() {
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_8169ECBE42B9A407", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_7D7E0BBD84A4488F", 1, 0);
  level._id_51444070C494BD3E = 3;
  level thread _id_3E19322333AD204C::main();
}

_id_AC107C4E24A6AEDD() {
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_8169ECBE42B9A407", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_7D7E0BBD84A4488F", 1, 0);
  level._id_51444070C494BD3E = 4;
  level thread _id_3E19322333AD204C::main();
}

_id_AC107B4E24A6ACAA() {
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_8169ECBE42B9A407", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_7D7E0BBD84A4488F", 1, 0);
  level._id_51444070C494BD3E = 5;
  level thread _id_3E19322333AD204C::main();
}

_id_AC107A4E24A6AA77() {
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_8169ECBE42B9A407", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_7D7E0BBD84A4488F", 1, 0);
  level._id_51444070C494BD3E = 6;
  level thread _id_3E19322333AD204C::main();
}

_id_A3DB32CB6503E9B1() {
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_8169ECBE42B9A407", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_7D7E0BBD84A4488F", 1, 0);
  scripts\cp\challenges_cp::_id_51BBBA3794076BF4();
  level._id_51444070C494BD3E = 7;
  level thread _id_3E19322333AD204C::main();
}

_id_2CFEF434CE6A1C44() {
  level scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);
  level.custom_onplayerconnect_func = ::onplayerconnect;
}

onplayerconnect(player) {}

onplayerspawned() {
  thread _id_19A7DFA4CBC97660();
}

_id_510DCDCBF4FC993C() {
  scripts\engine\utility::flag_wait("level_ready_for_script");

  if(getdvarint("dvar_16C27BD9C165F4D6")) {
    return;
  }
  if(scripts\cp\cp_relics::_id_30D732F612695BA8()) {
    return;
  }
  weapons = [];
  _id_CDE2EC78F52F00F9 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mike4");
  _id_CDE2EC78F52F00F9 = _id_CDE2EC78F52F00F9 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["holo", "ub_"]);
  _id_CDE2E978F52EFA60 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("sbeta");
  _id_CDE2E978F52EFA60 = _id_CDE2E978F52EFA60 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["fourx", "tactical"]);
  _id_CDE2EA78F52EFC93 = makeweaponfromstring("iw9_dm_scromeo_mp+ammo_65cm+bar_sn_long_p05+arscope_therm01+grip_angled01+mag_sn_p05+pgrip_aim_p05+rec_scromeo+stock_sn_light_p05");
  _id_CDE2EF78F52F0792 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("limax");
  _id_CDE2F078F52F09C5 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("akilo");
  _id_CDE2F078F52F09C5 = _id_CDE2F078F52F09C5 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["bar_ar_light", "stock_ar_light", "reddot"]);
  _id_CDE2ED78F52F032C = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("papa220");
  _id_CDE2ED78F52F032C = _id_CDE2ED78F52F032C _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["silencer", "reddot"]);
  _id_CDE2EE78F52F055F = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("kilo21");
  _id_CDE2EE78F52F055F = _id_CDE2EE78F52F055F _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00("belt_lm_large");
  _id_CDE2F378F52F105E = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("aviktor");
  _id_CDE2F378F52F105E = _id_CDE2F378F52F105E _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["holo", "mag_sm_large", "stock_sm_light"]);
  _id_CDE2F478F52F1291 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("beta");
  _id_CDE2F478F52F1291 = _id_CDE2F478F52F1291 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["holo", "stockno"]);
  _id_F90ED703365EBA0B = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mbravo");
  _id_F90ED603365EB7D8 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("aviktor");
  _id_F90ED603365EB7D8 = _id_F90ED603365EB7D8 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["holo", "mag_sm_xlarge", "stock_sm_heavy"]);
  _id_F90ED903365EBE71 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("akilo105");
  _id_F90ED903365EBE71 = _id_F90ED903365EBE71 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["reddot", "ub_"]);
  _id_F90ED803365EBC3E = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("rpapa7");
  weapons = [_id_CDE2EC78F52F00F9, _id_CDE2E978F52EFA60, _id_CDE2EA78F52EFC93, _id_CDE2EF78F52F0792, _id_CDE2F078F52F09C5, _id_CDE2ED78F52F032C, _id_CDE2EE78F52F055F, _id_CDE2F378F52F105E, _id_CDE2F478F52F1291, _id_F90ED703365EBA0B, _id_F90ED603365EB7D8, _id_F90ED903365EBE71, _id_F90ED803365EBC3E];
  _id_A13FD508CAD5931C = scripts\engine\utility::getStructArray("weapon_wall", "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A13FD508CAD5931C.size; _id_AC0E594AC96AA3A8++) {
    _id_28A6B68460F4FD6B = _id_A13FD508CAD5931C[_id_AC0E594AC96AA3A8];
    weapon_object = undefined;

    if(!isDefined(_id_28A6B68460F4FD6B.weaponinfo)) {
      continue;
    }
    switch (_id_28A6B68460F4FD6B.weaponinfo) {
      case "weapon_wm_ar_mike4_brprop":
        weapon_object = _id_CDE2EC78F52F00F9;
        break;
      case "weapon_wm_sn_sbeta_brprop":
        weapon_object = _id_CDE2F478F52F1291;
        break;
      case "weapon_wm_sn_mike14_brprop":
        weapon_object = _id_CDE2EA78F52EFC93;
        break;
      case "weapon_wm_sn_alpha50_brprop":
        weapon_object = _id_CDE2EF78F52F0792;
        break;
      case "weapon_wm_ar_akilo47_brprop":
        weapon_object = _id_CDE2F078F52F09C5;
        break;
      case "weapon_wm_pi_mike1911_brprop":
        weapon_object = _id_CDE2ED78F52F032C;
        break;
      case "weapon_wm_lm_kilo121_brprop":
        weapon_object = _id_CDE2EE78F52F055F;
        break;
      case "weapon_wm_sm_mpapa5_brprop":
        weapon_object = _id_CDE2F378F52F105E;
        break;
      case "weapon_wm_sm_beta_brprop":
        weapon_object = _id_CDE2F478F52F1291;
        break;
      case "weapon_wm_sh_charlie725_brprop":
        weapon_object = _id_F90ED703365EBA0B;
        break;
      case "weapon_wm_sm_mpapa7_brprop":
        weapon_object = _id_F90ED603365EB7D8;
        break;
      case "weapon_wm_ar_kilo433_brprop":
        weapon_object = _id_F90ED903365EBE71;
        break;
      case "weapon_wm_la_rpapa7":
        weapon_object = _id_F90ED803365EBC3E;
        break;
    }

    if(isDefined(weapon_object)) {
      _id_28A6B68460F4FD6B _id_3E19322333AD204C::_id_9655BF427A5ABDB8(undefined, weapon_object);
      continue;
    }
  }

  level thread _id_3E19322333AD204C::_id_F0DB4DDA6F417EA1();
  scripts\cp\utility::_id_C0D2C91F2688ECE4(1);
}

_id_19A7DFA4CBC97660() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(!scripts\engine\utility::flag_exist("player_spawned_with_loadout"))
    scripts\engine\utility::flag_init("player_spawned_with_loadout");

  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  wait 1;
  _id_07C40FA80892A721::givestartingarmor(100);

  if(!scripts\cp\cp_relics::_id_30D732F612695BA8()) {
    foreach(weapon in self.weaponlist) {
      clip_ammo = weaponclipsize(weapon);
      self setweaponammoclip(weapon, clip_ammo);
      _id_66122A002AFF5D57::_id_4172A10AE7CBDB41(weapon);
    }
  }

  if(istrue(self._id_AA6914D5FEBE3CFB)) {
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("readyroom");
    self setclientomnvar("ui_hide_bigmap", 0);
    self setclientomnvar("ui_show_tac_map", 1);
    self setclientomnvar("ui_radar_blocked", 0);
    self setclientomnvar("ui_hide_minimap", 0);
    self._id_AA6914D5FEBE3CFB = undefined;
  }
}

_id_C7100CF2295F89FC() {
  weapons = self getweaponslistprimaries();
  _id_20396DBFBD491B25 = self getcurrentprimaryweapon();
  _id_70465B40A37A1010 = undefined;

  foreach(weapon in weapons)
  scripts\cp_mp\utility\inventory_utility::_takeweapon(weapon);

  _id_9EF97DB737B5030E = makeweaponfromstring("iw9_ar_kilo53_mp+bar_ar_short_p02+mag_ar_p02+pgrip_ar_ass_p02+rec_kilo53+reflex_west01+iw9_selectsemi+stock_ar_assault_p02");
  _id_66122A002AFF5D57::_id_4172A10AE7CBDB41(_id_9EF97DB737B5030E);
  scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_9EF97DB737B5030E);
  _id_88350DAC5063D94E = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("papa220");
  _id_66122A002AFF5D57::_id_4172A10AE7CBDB41(_id_88350DAC5063D94E);
  scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_88350DAC5063D94E);
  self.last_stand_pistol = _id_88350DAC5063D94E;
  _id_12E2FB553EC1605E::_id_A01818AE9EDECBE6();
  _id_12E2FB553EC1605E::_id_A6EB74F88574F882();
  thread scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(_id_9EF97DB737B5030E, 1);
}

_id_BC3FA9E472A01E1A(_id_86DB2022C4F0F4BF, _id_185EA69B2FE37360, _id_7CB3CE39E2414126, _id_9B02313FE7FF70DA) {
  if(istrue(self._id_A1E9B37782A5D8D8)) {
    return;
  }
  _id_7EF95BBA57DC4B82::_id_707926E6CE8DDC60("primary", level._id_377071435EDF746D);
  _id_7EF95BBA57DC4B82::_id_707926E6CE8DDC60("secondary", level._id_1126CD09894FF2E1);
  self._id_A1E9B37782A5D8D8 = 1;
}

_id_279964C2C969DDA3() {
  level.dogtag_revive = 0;
}

_id_3861EB0A004E0D38() {
  _id_6FFC63D2AC18AABE();
  level.objectivesfunc = ::_id_C2A86F682BF1AB71;
  level thread scripts\cp\cp_objectives::objectives_init();
}

_id_6FFC63D2AC18AABE() {}

_id_C4D555BF9485AC3B() {
  level._id_377071435EDF746D = 3;
  level._id_1126CD09894FF2E1 = 3;
  level._id_5966C39CB60075F1 = ::_id_BC3FA9E472A01E1A;
  level._id_7EA1A9DB4C78BE14 = ::_id_7EA1A9DB4C78BE14;
  _id_12E2FB553EC1605E::_id_B82B35CA0F5529AA(0);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "spawn_jugg_key", _id_79F95F5F6D9EEB19::_id_B862C8C3E072A786);
  scripts\cp\utility::_id_BB3E0C926B0667C4("defender_infil,defender_intro,defender_wave1,defender_wave2,defender_wave3,defender_wave4,defender_wave5,defender_wave6,defender_ending");
  setup_create_script();
  _id_1E22D314CC16F807::_id_A133C2FF48B59DD7("scripted");
  _id_12E2FB553EC1605E::_id_E2D370937C694C58("iw9_ar_kilo53_mp", undefined, "iw9_pi_golf18_mp", ["pgrip_tac"]);
  _id_12E2FB553EC1605E::_id_EBF2582B122904FC("equip_frag", "equip_flash");
  level thread _id_FC4803DC319A81D2();
  scripts\cp\cp_compass::setupminimap("compass_map_cp_observatory", 2);
  _id_79F95F5F6D9EEB19::_id_B04F37F19C6631E0();
  _id_780514F14B1134ED::_id_957D3897064478FF();
  level thread scripts\cp\cp_objectives::run_debug_start_objective();
  level thread _id_7F3DCDD10D9F4895::main();
}

_id_7EA1A9DB4C78BE14(ref, slot) {
  if(isDefined(slot)) {
    if(slot == "primary" && isDefined(level._id_377071435EDF746D)) {
      _id_A5801084C24535F9 = 0;

      if(scripts\cp\utility::_hasperk("specialty_extra_deadly") && slot == "primary")
        _id_A5801084C24535F9 = 1;

      return level._id_377071435EDF746D + _id_A5801084C24535F9;
    } else if(slot == "secondary" && isDefined(level._id_1126CD09894FF2E1)) {
      _id_A5801084C24535F9 = 0;

      if(scripts\cp\utility::_hasperk("specialty_extra_tactical") && slot == "secondary")
        _id_A5801084C24535F9 = 1;

      return level._id_1126CD09894FF2E1 + _id_A5801084C24535F9;
    } else
      return undefined;
  } else
    return undefined;
}

_id_E0125729CABDA438() {
  _id_6FBA7DF440C493C4::init_vehicles();
  _id_0E80538EF14D00E1::register_combined_vehicles(scripts\vehicle\techo::main, "veh8_civ_lnd_techo_rebel_physics", "veh9_techo_physics_cp", "script_vehicle_iw9_truck_techo_rebel", undefined, "techo_ai", "techo_ai");
  _id_0E80538EF14D00E1::register_combined_vehicles(_id_3AF63BEEAAB2E0A7::main, "veh9_civ_lnd_techo_rebel_armor_vehphys_cp", "veh9_techo_physics_cp", "script_vehicle_iw9_truck_techo_rebel_armor", undefined, "techo_ai_armor", "techo_ai_armor");
  _id_0E80538EF14D00E1::register_combined_vehicles(scripts\vehicle\lbravo::main, "veh8_mil_air_lbravo_personnel_cp", "lbravo_infil_cp", "script_vehicle_iw8_lbravo_carrier", undefined, "lbravo_carrier_hover", "lbravo_carrier_hover");
  _id_0E80538EF14D00E1::register_combined_vehicles(_id_516851C4CA47F492::main, "veh9_mil_air_heli_medium_vehphys_mp", "veh9_mil_air_heli_medium_mp", "script_vehicle_heli_medium", undefined, "veh9_mil_air_heli_medium_mp", "veh9_mil_air_heli_medium_mp");
  scripts\vehicle\blima::main("veh8_mil_air_blima", "lbravo_infil_cp", "script_vehicle_iw8_blima");
  _id_4BEC22BA9253C63C::main("veh9_mil_lnd_jltv_turret_vehphys_mp", "veh9_jltv_physics_sp", "script_vehicle_iw9_jltv_physics");
}

setup_create_script() {
  level.gametype_interaction_func = ::_id_4C7526B061EF7294;
  level._id_B6F920E6490405E8 = "cp_observatory_defend_systems_cs";
  scripts\cp\cp_create_script_utility::init_create_script_for_level();
  scripts\cp\cp_create_script_utility::register_create_script_arrays("cp_observatory_create_script", "cp_observatory_create_script", level.scripted_spawner_func.size, _id_53970508014CD194::main);
  scripts\cp\cp_create_script_utility::register_create_script_arrays("cp_observatory_defend_systems_cs", "cp_observatory_defend_systems_cs", level.scripted_spawner_func.size, _id_731F26AF56AE23DA::main);
  scripts\cp\cp_create_script_utility::register_create_script_arrays("cp_observatory_defend_spawners_cs", "cp_observatory_defend_spawners_cs", level.scripted_spawner_func.size, _id_02A04DF6B459A9BB::main);
  scripts\cp\cp_create_script_utility::register_create_script_arrays("cp_observatory_defend_spawners_heli_cs", "cp_observatory_defend_spawners_heli_cs", level.scripted_spawner_func.size, _id_72A149353EE37DF6::main);
  scripts\cp\cp_create_script_utility::register_create_script_arrays("cp_observatory_defend_intro_cs", "cp_observatory_defend_intro_cs", level.scripted_spawner_func.size, _id_645F8AE0BB0AB6BE::main);
  scripts\cp\cp_create_script_utility::register_create_script_arrays("cp_observatory_defend_outro_cs", "cp_observatory_defend_outro_cs", level.scripted_spawner_func.size, _id_1A0CC9D07B7B3971::main);
}

_id_4C7526B061EF7294() {
  wait 1;
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
}

_id_C2A86F682BF1AB71() {
  level.objectives_table = "cp/cp_observatory_objectives.csv";
  level.objectivesmatrixtable = "cp/cp_observatory_objectives_matrix.csv";
  level.objectiveregistration = ::_id_77765E5DD4C9DB54;
  scripts\cp\cp_objectives::parseobjectivestable(level.objectives_table);
}

_id_77765E5DD4C9DB54() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  scripts\engine\utility::flag_wait("objective_table_parsed");
}

_id_D525F1534752BFC7() {
  setDvar("sm_sunSampleSizeNear", 1.25);
  setDvar("r_umbraMinObjectContribution", 4);
  setDvar("r_umbraAccurateOcclusionThreshold", 2048);
  setDvar("sm_roundRobinPrioritySpotShadows", 8);
  setDvar("sm_spotUpdateLimit", 8);
  setDvar("ui_gametype", "missions");

  if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()))
    setDvar("scr_localeID", 24);

  if(getdvarint("dvar_11F7475AB2848C04", 1) > 0) {
    setdvarifuninitialized("dvar_49A51BE00848D9B8", 1);
    setdvarifuninitialized("scr_player_maxhealth", 100);
  }

  _id_FDC0D9A769107478 = (-2312, -12462, 4802);
  _id_FDC0DCA769107B11 = (-1331, -12499, 4765);
  level thread _id_47CDA72D298FE8F7();
  level thread _id_BE1328457AEBB1BD();
  level thread _id_C2E59E1398458001();
  level._id_D49C99AD85354BD6 = 100;
  level._id_96D46B3DE782E4E7 = 2500;

  if(!isDefined(level.vehicle._id_AAB9695C92B0ED96))
    level.vehicle._id_AAB9695C92B0ED96 = [];

  scripts\engine\utility::flag_set("infil_complete");
}

_id_C2E59E1398458001() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("create_script_initialized");
  scripts\engine\utility::flag_wait("objectives_registered");
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  if(istrue(level._id_EFE609BCE901CAA8))
    scripts\cp\utility::gameflagwait("infil_started");

  wait 1;
  origin = (-3644, -12299, 4794);
  radius = 110;
  level thread _id_3C6FD4EDCAA9BAD0(origin, radius);
}

_id_3C6FD4EDCAA9BAD0(origin, radius) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  wait 10;
  _id_CDC5DD6C28C9709D = radius * radius;
  locationorigin = spawnStruct();
  locationorigin.origin = origin;
  _id_A02118632C7F1621 = scripts\engine\utility::getStructArray("defender_hardpoint", "script_noteworthy");

  for(;;) {
    nearbyplayer = locationorigin scripts\cp\utility::get_closest_living_player(_id_CDC5DD6C28C9709D);

    if(isDefined(nearbyplayer))
      nearbyplayer setOrigin(_id_A02118632C7F1621[1].origin);

    wait 0.25;
  }
}

_id_47CDA72D298FE8F7() {
  wait 1;
  _id_12B397CBEAAB23B6 = (-528, -13622, 5246);
  origin2 = (1960, -9797, 5261);
  _id_12B395CBEAAB1F50 = (-2832, -12861, 4798);
  _id_802D0FD828B5B783 = createnavbadplacebybounds(_id_12B397CBEAAB23B6, (700, 700, 200), (0, 0, 0));
  _id_802D10D828B5B9B6 = createnavbadplacebybounds(origin2, (350, 350, 300), (0, 0, 0));
  _id_802D11D828B5BBE9 = createnavbadplacebybounds(_id_12B395CBEAAB1F50, (70, 70, 40), (0, 0, 0));
}

_id_BE1328457AEBB1BD() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  wait 2;
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  origin = (0, 0, 0);

  if(isDefined(level.players) && isDefined(level.players[0]))
    origin = level.players[0].origin - (0, 0, 1000);

  playFX(level.g_effect["human_gib_fullbody"], origin);
  playFX(level.g_effect["vfx_suicide_bomber_gib_explode"], origin);
}
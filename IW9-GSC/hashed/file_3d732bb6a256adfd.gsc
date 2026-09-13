/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3d732bb6a256adfd.gsc
***********************************************/

main() {
  level._id_09FAB40ED3326F8B = getDvar("dvar_83CEDBB376315732", "mp/subarea_tuning_mp_biobunker.csv");
  _id_7B5BD31E6151298C::main();
  _id_06D3E39FA43B6DE6::main();
  _id_536975D191174D0C::main();
  scripts\mp\load::main();
  scripts\mp\utility\player::overridevisionsetnightforlevel("nvg_mp_biobunker");
  scripts\common\create_script_utility::initialize_create_script();
  _func_EB7F544259415A09("mp_biobunker_dmz");
  level thread _id_1D26D0C516C64C6D::main();
  level thread _id_703A26AA2D2ABAB5::main();
  level thread _id_10BD0245FAA15B56::main();
  level thread _id_12391776C00CA692::main();
  level thread _id_648A0E5F36C1FEA4::main();
  level thread _id_48EDCF0B9ECE9CFF::main();
  level thread _id_4ABB1177ECE3F03F::main();
  level thread _id_7896859EB0E311ED::main();
  level thread _id_6B289C667A6A2F66::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_biobunker");
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("dvar_1891A7C9188F098A", 2);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level._id_4D8386ECA283E9C4 = "biobunker_";
  level thread _id_5DEF7AF2A9F04234::_id_C08668FE290FC31A();
  scripts\cp_mp\tripwire::init();
  level._id_E9A6FC11B0AA7EB2 = ::_id_2B0725F69E10C949;
  _id_0518AE857A3D351C::init();
  _id_4480C6CE37B2BDF3::_id_DBE369AF1ABC2991();

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(scripts\mp\utility\game::getsubgametype() == "dmz") {
      level._id_400484D15C2CFD6B = getdvarint("dvar_1E69EF33B46F5773", 400);
      level._id_FD915E8BD20B6D09 = _id_5C55C87B89467A29::_id_93E3FE0E5693889B;
      level.skipprematchdropspawn = 1;
      level._id_1A200BB001752E5F = scripts\engine\utility::getStructArray("radiation_start_point", "targetname");
      level._id_2CDF30478FA435FF = [];

      foreach(start_point in level._id_1A200BB001752E5F)
      level._id_2CDF30478FA435FF[level._id_2CDF30478FA435FF.size] = start_point.origin;

      level._id_FC458DDEC84C95A0 = ::_id_FC458DDEC84C95A0;
      level._id_98AE8DC756286ACA = ::_id_E0D501A53A5B64C8;
      level thread _id_D31C6F7E15184CE8();
      level._id_4450F123BD5CD62E = "loot_key_biobunker_fortress";
      level thread _id_54130ACF7E2328CD::init();
      level thread _id_164E99D8D824A8E2::init();
      level thread _id_B42821BB65F6792A();
      level thread _id_58158742F2DE3DD3();
      _id_58B1ECA22500284F::_id_88FBE091EBBDA87C();
    }

    level.br_prematchspawnlocations = [_id_1E4A61DB11011446::createspawnlocation((2620, -2239, 1000), 0, 5000)];
    _id_4FF6C6ED304E05BB::init();
    brinit();
    _id_362C58E8BB39BCDA::registerbrgametypefunc("onPickupTakenIntoBackpack", ::_id_A74604666BDE595B);
  }

  level._id_B76E1ACDF15010D2 = getdvarint("dvar_701F899E8B328500", 1) == 1;
  level.ttlos_suppressasserts = 1;
  level._id_68805521E53BDF40 = 0;
  level._id_00524F19850C0129 = 0;

  if(istrue(level._id_289DF80E1DED586F)) {
    _id_00DF0D2C049C5588();
    level._id_6827E5668EBC95C0 = 1;
    level._id_6B8D9782315FF51B = 0;
    level._id_1C8CBD78AF4920D0 = _id_2D9C29F869A29FCA::_id_CEE3B39981879330;
    level._id_A3941B9965BDD8D2 = ::_id_50375D63A38A8F8F;
    level._id_3EED4E0BC4A30B72 = "br_biobunker_aieventlist";
    level._id_D32282F99E9D01B8 = ::_id_D32282F99E9D01B8;
    level._id_D5078BBAD0790AE7 = ::_id_D5078BBAD0790AE7;
    level._id_8209A75B03499110 = ::_id_8209A75B03499110;
    _id_48814951E916AF89::_id_C8393014DD7F8AB6();
    level thread _id_2D9C29F869A29FCA::_id_6D19FE96E8F91A3C("mp/reinforcement_events_biobunker.csv");
    level thread _id_2D9C29F869A29FCA::_id_3FB0D650BE8286CE();
    _id_E17D55EB83D261B3();
    level thread _id_28C33EF10A3CB4A1::_id_8FA25CA58F24B519();
    _id_77DDA09AFB222DE3::_id_93A03EB03BC2C8AE();
  }

  setDvar("r_umbraMinObjectContribution", 8);
  _id_72AF5A878A9D3397::_id_F6C977AD89F51B9C(level.script, level.mapcorners);
  _id_701449195235BE31::_id_17FD42AE13D8ABC9();
  level thread _id_5C118165D3E98A42::_id_D8DE1E0BC05F3B3A("mp/dmz_biobunker_elevator_pick.csv");
  level thread _id_6849C870429C1CBE();
  _id_26778943BA1601A4();
  level thread _id_62EF5A31B91BB69D::init();
  _id_5C118165D3E98A42::_id_FA81150E9ADA1F6A(0);
  level._id_E26F46A3B89CD3BB = getdvarint("dvar_9B4464211CD3A434", 30);
  level._id_A0F6CF876AB471E6 = getdvarint("dvar_174E9721C13FDDB9", 20);
  level._id_D99059956F0D1F3D = getdvarint("dvar_4EAA5933431CE770", 10);
  level._id_A25720E982F459FB = 1;
  level._id_D2F37A175B858B63 = 1;
  level thread _id_D62CE6271CADD6AD();
  level thread _id_D8DF6AC7C62A1EBA();
  level thread _id_CC63EF945DA87741();
  level thread _id_701449195235BE31::_id_4C866681BC6481BE("mp/dmz_biobunker_spawn_items.csv");
  level thread _id_701449195235BE31::_id_F39400365156886F("mp/dmz_biobunker_note_spawn.csv");
  level thread _id_888023B4DE84B640();
  level thread _id_D584D797F379D7F0();
  level thread _id_1084379FB31A445C();
  level thread _id_9C1D247CD2138289();
  level thread _id_78B84E35139D8BE9();

  if(_id_0A661C5FAD6BEDD8::_id_BC586652AA211EE1())
    level _id_0A661C5FAD6BEDD8::_id_FCD6214D8DD46123(level.br_level.c130_sealeveloverride);

  level thread _id_B09BDA767D8E5510();
  level._id_FE38A7ECE3409052 = 1;
  _id_E987D05AE9425609();
  level thread _id_901A222297174F03();
  _id_4EF38295E7BA94D2();
  level.override_unresolved_collision = ::override_unresolved_collision;
}

_id_58158742F2DE3DD3() {
  while(!isDefined(level.br_pickups))
    waitframe();

  _id_3AACF02225CA0DA5::_id_F9EC88C3D71324CD("brloot_weaponcase_biobunker");
  _id_203302B9AC91E7F4 = _id_7E52B56769FA7774::getitemdropinfo((-8720, 16583, 1854), (0, 165, 0));
  _id_918249FD5219A579 = _id_7E52B56769FA7774::spawnpickup("brloot_weaponcase_biobunker", _id_203302B9AC91E7F4, 1);
  _id_918249FD5219A579._id_BBC200BC77C5DB2B = 1;
}

brinit() {
  level.br_level = spawnStruct();
  _id_45B2B4A889E633FA::setc130heightoverrides(19000, 128);
  _id_3C590D0EE220B409 = level.mapcorners[0].origin[0];
  _id_C978C90E8E5AB1F7 = level.mapcorners[1].origin[0];
  _id_3C590C0EE220B1D6 = level.mapcorners[1].origin[1];
  _id_C978C80E8E5AAFC4 = level.mapcorners[0].origin[1];
  level.br_level.br_mapboundsfull = [];
  level.br_level.br_mapboundsfull[0] = (_id_C978C90E8E5AB1F7, _id_C978C80E8E5AAFC4, 0);
  level.br_level.br_mapboundsfull[1] = (_id_3C590D0EE220B409, _id_3C590C0EE220B1D6, 0);
  _id_3C590D0EE220B409 = level.mapcorners[0].origin[0] * 0.95;
  _id_C978C90E8E5AB1F7 = level.mapcorners[1].origin[0] * 0.95;
  _id_3C590C0EE220B1D6 = level.mapcorners[1].origin[1] * 0.95;
  _id_C978C80E8E5AAFC4 = level.mapcorners[0].origin[1] * 0.95;
  level.br_level.br_mapbounds = [];
  level.br_level.br_mapbounds[0] = (_id_C978C90E8E5AB1F7, _id_C978C80E8E5AAFC4, 0);
  level.br_level.br_mapbounds[1] = (_id_3C590D0EE220B409, _id_3C590C0EE220B1D6, 0);
  level.br_level.br_mapcenter = ((_id_3C590D0EE220B409 + _id_C978C90E8E5AB1F7) / 2, (_id_3C590C0EE220B1D6 + _id_C978C80E8E5AAFC4) / 2, 0);
  level.br_level.br_mapsize = (abs(_id_C978C90E8E5AB1F7 - _id_3C590D0EE220B409), abs(_id_C978C80E8E5AAFC4 - _id_3C590C0EE220B1D6), abs(level.br_level.c130_heightoverride - level.br_level.c130_sealeveloverride));
}

_id_E987D05AE9425609() {
  game["dialog"]["bio_bunker_match_start"] = "dx_br_dmzo_biob_ovld_nwmt";
  game["dialog"]["bio_bunker_extract_success"] = "dx_br_dmzo_biob_ovld_xtrc";
  game["dialog"]["bio_bunker_squad_eliminated"] = "dx_br_dmzo_biob_ovld_sqdl";
  game["dialog"]["bio_bunker_radiation_approach"] = "dx_br_dmzo_biob_ovld_raap";
  game["dialog"]["bio_bunker_exfil_called_final"] = "dx_br_dmzo_biob_ovld_ecfi";
  game["dialog"]["bio_bunker_enemy_warn"] = "dx_br_dmzo_biob_ovld_ewrn";
  game["dialog"]["bio_bunker_player_ai_alerted"] = "dx_br_dmzo_biob_ovld_plaa";
  game["dialog"]["bio_bunker_boss_rusher_approach_first_time"] = "dx_br_dbos_bbbf_dbrs_skft";
  game["dialog"]["bio_bunker_boss_rusher_approach_first_time_alert"] = "dx_br_dbos_bbbf_dbrs_afta";
  game["dialog"]["bio_bunker_boss_rusher_approach_first_time_resp"] = "dx_br_dbos_bbbf_dbrs_aftr";
  game["dialog"]["bio_bunker_boss_rusher_take_damage"] = "dx_br_dbos_bbbf_dbrs_tkdm";
  game["dialog"]["bio_bunker_boss_rusher_player_taken_down"] = "dx_br_dbos_bbbf_dbrs_ptdw";
  game["dialog"]["bio_bunker_boss_rusher_player_reinforcement_coming"] = "dx_br_dbos_bbbf_dbrs_rnfc";
  game["dialog"]["bio_bunker_boss_rusher_combat_disengage"] = "dx_br_dbos_bbbf_dbrs_cmbd";
  game["dialog"]["bio_bunker_boss_rusher_bark_combat"] = "dx_br_dbos_bbbf_dbrs_brkc";
  game["dialog"]["bio_bunker_boss_rusher_bark_idle"] = "dx_br_dbos_bbbf_dbrs_brki";
  game["dialog"]["bio_bunker_boss_sniper_approach_first_time"] = "dx_br_dbos_bbbf_dbsn_skft";
  game["dialog"]["bio_bunker_boss_sniper_approach_first_time_alert"] = "dx_br_dbos_bbbf_dbsn_afta";
  game["dialog"]["bio_bunker_boss_sniper_approach_first_time_resp"] = "dx_br_dbos_bbbf_dbsn_afta";
  game["dialog"]["bio_bunker_boss_sniper_take_damage"] = "dx_br_dbos_bbbf_dbsn_tkdm";
  game["dialog"]["bio_bunker_boss_sniper_player_taken_down"] = "dx_br_dbos_bbbf_dbsn_ptdw";
  game["dialog"]["bio_bunker_boss_sniper_player_reinforcement_coming"] = "dx_br_dbos_bbbf_dbsn_rnfc";
  game["dialog"]["bio_bunker_boss_sniper_combat_disengage"] = "dx_br_dbos_bbbf_dbsn_cmbd";
  game["dialog"]["bio_bunker_boss_sniper_bark_combat"] = "dx_br_dbos_bbbf_dbsn_brkc";
  game["dialog"]["bio_bunker_boss_sniper_bark_idle"] = "dx_br_dbos_bbbf_dbrs_brki";
  game["dialog"]["bio_bunker_boss_sniper_rusher_down"] = "dx_br_dbos_bbbf_dbsn_rshd";
}

_id_901A222297174F03() {
  level endon("game_ended");
  level waittill("matchStartTimer_done");
  _id_5307834CD39B435C::_id_9FDF14C5AAC8CE53("bio_bunker_match_start");
}

_id_00DF0D2C049C5588() {
  level._id_0F5F783A9D656258._id_1432BD2B78DBED76 = [];
  level._id_0F5F783A9D656258._id_1432BD2B78DBED76[0] = ["tier1_elevator"];
  level._id_0F5F783A9D656258._id_1432BD2B78DBED76["0_chance"] = [100];
  level._id_0F5F783A9D656258._id_1432BD2B78DBED76[1] = ["tier1_elevator"];
  level._id_0F5F783A9D656258._id_1432BD2B78DBED76["1_chance"] = [100];
  level._id_0F5F783A9D656258._id_1432BD2B78DBED76[2] = ["tier1_elevator", "tier2_elevator"];
  level._id_0F5F783A9D656258._id_1432BD2B78DBED76["2_chance"] = [50, 50];
  level._id_0F5F783A9D656258._id_1432BD2B78DBED76[3] = ["tier2_elevator"];
  level._id_0F5F783A9D656258._id_1432BD2B78DBED76["3_chance"] = [100];
  level._id_0F5F783A9D656258._id_1432BD2B78DBED76[4] = ["tier3_elevator"];
  level._id_0F5F783A9D656258._id_1432BD2B78DBED76["4_chance"] = [100];
  level._id_0F5F783A9D656258._id_2170B8BBBF7FB5D1 = [];
  level._id_0F5F783A9D656258._id_2170B8BBBF7FB5D1[1] = ["tier1_elevator"];
  level._id_0F5F783A9D656258._id_2170B8BBBF7FB5D1["1_chance"] = [100];
  level._id_0F5F783A9D656258._id_2170B8BBBF7FB5D1[2] = ["tier2_elevator"];
  level._id_0F5F783A9D656258._id_2170B8BBBF7FB5D1["2_chance"] = [100];
  level._id_0F5F783A9D656258._id_2170B8BBBF7FB5D1[3] = ["tier3_elevator"];
  level._id_0F5F783A9D656258._id_2170B8BBBF7FB5D1["3_chance"] = [100];
  level._id_0F5F783A9D656258._id_5B02052A040E1210 = [];
  level._id_0F5F783A9D656258._id_5B02052A040E1210[0] = "tier1_elevator";
  level._id_0F5F783A9D656258._id_5B02052A040E1210[1] = "tier1_elevator";
  level._id_0F5F783A9D656258._id_5B02052A040E1210[2] = "tier2_elevator";
  level._id_0F5F783A9D656258._id_5B02052A040E1210[3] = "tier2_elevator";
  level._id_0F5F783A9D656258._id_5B02052A040E1210[4] = "tier3_elevator";
  level._id_0F5F783A9D656258._id_9FF30F8C5842928F = [];
  level._id_0F5F783A9D656258._id_9FF30F8C5842928F[1] = "tier1_elevator";
  level._id_0F5F783A9D656258._id_9FF30F8C5842928F[2] = "tier2_elevator";
  level._id_0F5F783A9D656258._id_9FF30F8C5842928F[3] = "tier3_elevator";
  _id_48814951E916AF89::_id_EDFC4CC2D317C6C1();
}

_id_50375D63A38A8F8F(agent) {
  if(!isDefined(agent)) {
    return;
  }
  if(issubstr(agent.agent_type, "sniper") || issubstr(agent.agent_type, "rusher")) {
    return;
  }
  if(agent._id_B205D90302DA2F07 == "biobunker_boss" && (agent._id_D1CF55B36FACF5A8._id_71AD22C5D093D90B == "arenalv1" || agent._id_D1CF55B36FACF5A8._id_71AD22C5D093D90B == "arenalv2")) {
    return;
  }
  if(!issubstr(agent.agent_type, "bomber")) {
    if(agent._id_B205D90302DA2F07 == "biobunker_datacenter")
      agent _id_701449195235BE31::_id_7B3877AFD4D12BC9("flashlight_box02");
    else if(agent._id_B205D90302DA2F07 == "biobunker_dark")
      agent _id_701449195235BE31::_id_7B3877AFD4D12BC9();
  }

  if(agent._id_B205D90302DA2F07 == "biobunker_radiation") {
    if(istrue(agent._id_102A9D2CF99AB325)) {
      return;
    }
    agent._id_65771500F49956C1 = 1;
    agent._id_102A9D2CF99AB325 = 1;
    agent attach("hat_child_hadir_gas_mask_wm_br", "j_head");
    _id_48814951E916AF89::_id_63A043D47490F90D(agent, "brloot_equip_gasmask", undefined, 0.25, 108);
    agent._id_CD6A3A50F09688B9 = _id_48814951E916AF89::_id_85AEA9DB068BC292;
  } else if(agent._id_B205D90302DA2F07 == "biobunker_dark") {
    agent attach("hat_spetsnaz_helmet_cloth_a_nvg");
    _id_48814951E916AF89::_id_63A043D47490F90D(agent, "brloot_nvg", undefined, 0.5, 1);
  }
}

_id_8209A75B03499110(_id_171F90B9C4C76D44) {
  if(_id_171F90B9C4C76D44 == "biobunker_dark")
    return 3;
  else
    return _id_48814951E916AF89::_id_AA34A142B7664DD1(_id_41BA451876D0900C::_id_5CC0C507E92F7B47(_id_171F90B9C4C76D44));
}

_id_D32282F99E9D01B8(_id_C5E7FCE963586EC0) {
  _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_C5E7FCE963586EC0);
  _id_D1CF55B36FACF5A8 = _id_48814951E916AF89::_id_0A44E168E8CCED18(_id_C5E7FCE963586EC0, _id_171F90B9C4C76D44);

  if(_id_171F90B9C4C76D44 == "biobunker_boss" && _id_D1CF55B36FACF5A8._id_71AD22C5D093D90B == "arenalv1")
    return 0;

  return 1;
}

_id_D5078BBAD0790AE7(agents, _id_171F90B9C4C76D44) {
  if(agents.size <= 0) {
    return;
  }
  if(_id_171F90B9C4C76D44 == "biobunker_dark") {
    if(!istrue(level._id_68805521E53BDF40) && istrue(level._id_6B8D9782315FF51B)) {
      _id_AC73C550BACCD148 = ["loot_key_biobunker_hub_a_worn"];
      _id_D48D14622FA5BEA7 = agents[randomint(agents.size)];
      _id_5EDDC5152A128D55 = _id_AC73C550BACCD148[randomint(_id_AC73C550BACCD148.size)];
      _id_48814951E916AF89::_id_63A043D47490F90D(_id_D48D14622FA5BEA7, _id_5EDDC5152A128D55, undefined, 1, 1);
    }
  }

  if(isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["players"]))
    _id_5307834CD39B435C::_id_0EFD3004BCAA728F("bio_bunker_enemy_warn", level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["players"]);
}

_id_A74604666BDE595B(pickupent) {
  if(pickupent.scriptablename == "loot_key_biobunker_hub_a_worn") {
    if(istrue(level._id_289DF80E1DED586F) && !istrue(level._id_00524F19850C0129)) {
      level._id_00524F19850C0129 = 1;
      level thread _id_82DAF38D9DDEC482();
    }
  }
}

_id_82DAF38D9DDEC482() {
  level endon("game_ended");
  level endon("door_dark_to_boss_opened");
  waittime = getdvarint("dvar_3168613DF5796EAD", 180);
  wait(waittime);
  level._id_6B8D9782315FF51B = 1;
}

_id_6849C870429C1CBE() {
  level endon("game_ended");

  if(!_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    return;
  }
  if(!isDefined(level._id_6FDFDC44A9268868)) {
    return;
  }
  level._id_A7B24F3D620B203D = [];
  level._id_A7B24F3D620B203D["biobunker_controlroom_monitor"] = getEnt("subarea_controlroom_monitor", "script_noteworthy");
  level._id_A7B24F3D620B203D["biobunker_office_brainwash"] = getEnt("subarea_office_brainwash", "script_noteworthy");
  level._id_F452F0FEAEC7883B = [];

  foreach(node in level._id_6FDFDC44A9268868) {
    _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(node.origin);
    _id_D1CF55B36FACF5A8 = _id_48814951E916AF89::_id_0A44E168E8CCED18(node.origin, _id_171F90B9C4C76D44);

    if(isDefined(_id_D1CF55B36FACF5A8)) {
      key = _id_171F90B9C4C76D44 + "_" + _id_D1CF55B36FACF5A8._id_71AD22C5D093D90B;

      if(isDefined(level._id_A7B24F3D620B203D[key])) {
        if(!isDefined(level._id_F452F0FEAEC7883B[key]))
          level._id_F452F0FEAEC7883B[key] = [];

        level._id_F452F0FEAEC7883B[key][level._id_F452F0FEAEC7883B[key].size] = node;
      }
    }
  }

  for(;;) {
    foreach(nodes in level._id_F452F0FEAEC7883B) {
      foreach(node in nodes)
      node.enable = 1;
    }

    teamdata = [];

    if(isDefined(level.players)) {
      foreach(player in level.players) {
        if(!isalive(player)) {
          continue;
        }
        foreach(area, volume in level._id_A7B24F3D620B203D) {
          if(!isDefined(teamdata[area]))
            teamdata[area] = [];

          if(ispointinvolume(player.origin, volume)) {
            if(!isDefined(teamdata[area][player.team]))
              teamdata[area][player.team] = [];

            teamdata[area][player.team][teamdata[area][player.team].size] = player;
          }
        }
      }
    }

    foreach(area, data in teamdata) {
      _id_6B4878A3F7C1498F = 0;

      foreach(team, members in data) {
        _id_652F47620AC4713F = scripts\mp\utility\teams::getteamdata(team, "teamCount");

        if(members.size < _id_652F47620AC4713F / 2) {
          _id_6B4878A3F7C1498F = 1;
          break;
        }
      }

      if(_id_6B4878A3F7C1498F) {
        foreach(node in level._id_F452F0FEAEC7883B[area])
        node.enable = 0;
      }
    }

    wait 1;
  }
}

_id_E17D55EB83D261B3() {
  level endon("game_ended");

  if(getdvarint("dvar_70D8CBA45C5014EC", 1) == 0) {
    return;
  }
  while(!isDefined(level.struct_class_names))
    waitframe();

  _id_B9A2DFFF1288B930 = "aiSentryTurret";
  level._id_B08CAEEDD32CFDAF = spawnStruct();
  level._id_B08CAEEDD32CFDAF._id_44EEC9282C8F5EE3 = getdvarint("dvar_A9F06D839483D2A1", 1);
  level._id_B08CAEEDD32CFDAF._id_A4CD5B9AE4A509F4 = [];
  level._id_B08CAEEDD32CFDAF._id_325F9F15252B4928 = ::_id_7AB7C9A736F862DD;
  level._id_B08CAEEDD32CFDAF._id_FD5EA9CB37C309D3 = scripts\engine\utility::array_randomize(scripts\engine\utility::getStructArray(_id_B9A2DFFF1288B930, "script_noteworthy"));
  level.sentrysettings["ai_sentry_turret"] = spawnStruct();
  level.sentrysettings["ai_sentry_turret"].health = 999999;
  level.sentrysettings["ai_sentry_turret"].maxhealth = 650;
  level.sentrysettings["ai_sentry_turret"].burstmin = 20;
  level.sentrysettings["ai_sentry_turret"].burstmax = 120;
  level.sentrysettings["ai_sentry_turret"].pausemin = 0.15;
  level.sentrysettings["ai_sentry_turret"].pausemax = 0.35;
  level.sentrysettings["ai_sentry_turret"].lockstrength = 6;
  level.sentrysettings["ai_sentry_turret"].sentrymodeon = "sentry";
  level.sentrysettings["ai_sentry_turret"]._id_7C46D96A6FEDD4CD = "manual";
  level.sentrysettings["ai_sentry_turret"].sentrymodeoff = "sentry_offline";
  level.sentrysettings["ai_sentry_turret"].spinuptime = 1.5;
  level.sentrysettings["ai_sentry_turret"].overheattime = 8.0;
  level.sentrysettings["ai_sentry_turret"].cooldowntime = 0.3;
  level.sentrysettings["ai_sentry_turret"]._id_AA507124549D7490 = 4;
  level.sentrysettings["ai_sentry_turret"]._id_6265B628C3ED1103 = 3;
  level.sentrysettings["ai_sentry_turret"]._id_87D927A08CBFDF3F = 1;
  level.sentrysettings["ai_sentry_turret"].leftarc = 80;
  level.sentrysettings["ai_sentry_turret"].rightarc = 80;
  level.sentrysettings["ai_sentry_turret"].fxtime = 0.3;
  level.sentrysettings["ai_sentry_turret"]._id_951AF53D31931D09 = 2048;
  level.sentrysettings["ai_sentry_turret"].weaponinfo = "sentry_turret_mp";
  level.sentrysettings["ai_sentry_turret"].playerweaponinfo = "sentry_turret_mp";
  level.sentrysettings["ai_sentry_turret"].modelbaseground = "wpn_wm_p45_mg_auto_sentry_v0_mp";
  level.sentrysettings["ai_sentry_turret"].modeldestroyedground = "wpn_wm_p45_mg_auto_sentry_v0_mp";
  level.sentrysettings["ai_sentry_turret"].scorepopup = "destroyed_sentry";
  level.sentrysettings["ai_sentry_turret"].lightfxtag = "tag_fx";

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913())
    _id_5DEF7AF2A9F04234::_id_44739FE1CF82E29A("aiSentryTurrets");
}

_id_7AB7C9A736F862DD() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("create_script_initialized");

  if(!_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    return;
  }
  foreach(_id_FB1DEF007972B25A in level._id_B08CAEEDD32CFDAF._id_FD5EA9CB37C309D3) {
    _id_DE58CA0235EE107B = 0;

    if(!isDefined(_id_FB1DEF007972B25A._id_B205D90302DA2F07))
      _id_FB1DEF007972B25A._id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_FB1DEF007972B25A.origin);

    if(isDefined(_id_FB1DEF007972B25A._id_B205D90302DA2F07) && _id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE(_id_FB1DEF007972B25A._id_B205D90302DA2F07)) {
      _id_EF2F7E4F923F3DDE = isDefined(_id_FB1DEF007972B25A.script_label) && _id_FB1DEF007972B25A.script_label == "random";

      if(_id_EF2F7E4F923F3DDE) {
        if(isDefined(level._id_B205D90302DA2F07[_id_FB1DEF007972B25A._id_B205D90302DA2F07]["aiSentryTurrets"]) && level._id_B205D90302DA2F07[_id_FB1DEF007972B25A._id_B205D90302DA2F07]["aiSentryTurrets"].size < level._id_B08CAEEDD32CFDAF._id_44EEC9282C8F5EE3)
          _id_DE58CA0235EE107B = 1;
      } else
        _id_DE58CA0235EE107B = 1;
    }

    if(_id_DE58CA0235EE107B) {
      _id_FB1DEF007972B25A._id_1B096843A2175F92 = 1;
      turret = _id_60E3273DF6B5F7D1::_id_F33B0AFADF9107EB(_id_FB1DEF007972B25A);
      level._id_B08CAEEDD32CFDAF._id_A4CD5B9AE4A509F4[level._id_B08CAEEDD32CFDAF._id_A4CD5B9AE4A509F4.size] = turret;
      turret.colmodel show();

      if(isDefined(_id_FB1DEF007972B25A._id_B205D90302DA2F07)) {
        level._id_B205D90302DA2F07[_id_FB1DEF007972B25A._id_B205D90302DA2F07]["aiSentryTurrets"][level._id_B205D90302DA2F07[_id_FB1DEF007972B25A._id_B205D90302DA2F07]["aiSentryTurrets"].size] = turret;
        _id_5DEF7AF2A9F04234::_id_D0E7647E5538EB9D(_id_FB1DEF007972B25A._id_B205D90302DA2F07, "aiSentryTurrets", turret);
      }
    }
  }
}

_id_D62CE6271CADD6AD() {
  level endon("game_ended");
  level._id_95DE4B6BB41FBBFA = [];
  level._id_C7825757649C018E = getdvarint("dvar_1D32C1595DE57577", 15);
  level._id_04C057B408385BB1 = [];
  level._id_04C057B408385BB1["elevator_15"] = ["boss_stronghold_exfil_reinforcement", 32];
  level._id_04C057B408385BB1["elevator_16"] = ["boss_stronghold_exfil_reinforcement", 32];
  level._id_04C057B408385BB1["elevator_20"] = ["dark_exfil_reinforcement", 32];
  level._id_04C057B408385BB1["elevator_21"] = ["dark_exfil_reinforcement", 32];
  level._id_04C057B408385BB1["elevator_22"] = ["dark_exfil_reinforcement", 32];
  level._id_04C057B408385BB1["elevator_48"] = ["datacenter_exfil_reinforcement", 64];
  level._id_04C057B408385BB1["elevator_60"] = ["datacenter_stronghold_exfil_reinforcement", 32];
  level._id_04C057B408385BB1["elevator_61"] = ["datacenter_stronghold_exfil_reinforcement", 32];
  level._id_04C057B408385BB1["elevator_62"] = ["datacenter_stronghold_exfil_reinforcement", 32];

  while(!istrue(level._id_B212A36BEC6CF8DA))
    waitframe();

  scripts\engine\scriptable::scriptable_addusedcallbackbypart("elevator_ext_button", ::_id_E48F0D3775F2A3DA);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("elevator_int_button", ::_id_0D23A307DE97A0A8);
  _id_5C118165D3E98A42::_id_BA13D98DAB57CA7E("elevator_group_exfil", "waiting", ::_id_4497EC9C55F12123);
  _id_5C118165D3E98A42::_id_BA13D98DAB57CA7E("elevator_group_exfil", "doors_warming", ::_id_EACD3D40FF26ED40);
  _id_5C118165D3E98A42::_id_BA13D98DAB57CA7E("elevator_group_exfil", "doors_open", ::_id_EC009A967D1D5EB9);
  _id_5C118165D3E98A42::_id_BA13D98DAB57CA7E("elevator_group_exfil", "doors_closing", ::_id_8B680B3EF155FC34);
  level thread _id_B9730BFE1E8B9F81();
}

_id_D8DF6AC7C62A1EBA() {
  level waittill("matchStartTimer_done");
  _id_D2B374E59BED267D = [scripts\engine\utility::random(["elevator_20", "elevator_21", "elevator_22"]), "elevator_48"];
  _id_D2B374E59BED267D = scripts\engine\utility::array_randomize(_id_D2B374E59BED267D);
  level thread _id_701449195235BE31::_id_256740E934855015();
  _id_8D4B6EE0E1D72512 = getdvarint("dvar_C305742BFDD2EF83", 600);
  _id_3E3E41683DC1BCDD = getdvarint("dvar_479803C125F6F887", 300);
  wait(_id_8D4B6EE0E1D72512);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D2B374E59BED267D.size; _id_AC0E594AC96AA3A8++) {
    _id_5C118165D3E98A42::_id_20E0F2F56A5BA71F("exfil", "elevator_group_exfil", "waiting", _id_D2B374E59BED267D[_id_AC0E594AC96AA3A8], undefined);
    wait(_id_3E3E41683DC1BCDD);
  }
}

_id_B08C53A8C68C1491(players, _id_6958D396E4AD3B95, _id_55F38A9ECA24F5B8) {
  _id_ABDA98D4F5975707 = spawnStruct();
  _id_ABDA98D4F5975707._id_6958D396E4AD3B95 = _id_6958D396E4AD3B95;
  _id_ABDA98D4F5975707._id_55F38A9ECA24F5B8 = _id_55F38A9ECA24F5B8;
  _id_ABDA98D4F5975707._id_5ABB8DC2E7CD678E = players;
  _id_ABDA98D4F5975707.priority = int(_func_2E84A570D6AF300A(self.id, "elevator_"));
  _id_ABDA98D4F5975707.id = self.id;
  _id_ABDA98D4F5975707._id_26237A5432EF38B6 = self.car.origin;
  _id_ABDA98D4F5975707 thread _id_701449195235BE31::_id_FF5183505692184F();
}

_id_E48F0D3775F2A3DA(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(instance._id_EEC55FABA21F3653.group != "elevator_group_exfil") {
    return;
  }
  if(!isDefined(player)) {
    return;
  }
  instance setscriptablepartstate("elevator_button_lights", "down", 0);
  instance setscriptablepartstate("elevator_ext_button", "disabled");
  _id_F49A04061E6EB63D = instance._id_EEC55FABA21F3653._id_3EAD649FC902FEC2 - instance._id_EEC55FABA21F3653._id_33DE00DF8A9FBBE0;

  if(_id_F49A04061E6EB63D < 0)
    instance._id_0E4118BDA122B112 setscriptablepartstate("model", "down", 0);
  else
    instance._id_0E4118BDA122B112 setscriptablepartstate("model", "up", 0);

  instance._id_EEC55FABA21F3653.playerteam = player.team;
  players = scripts\mp\utility\teams::getteamdata(player.team, "players");
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("br_dmz_bio_labs_exfil_activate", players);

  foreach(_id_B2810E8D06E0A042 in players)
  _id_B2810E8D06E0A042 setplayermusicstate("iw9_mp_dmz_biobunker_exfil");

  instance._id_EEC55FABA21F3653 notify("exfil_elevator_start_warm");
  instance._id_EEC55FABA21F3653 _id_B08C53A8C68C1491(players, level._id_E26F46A3B89CD3BB, 0);

  if(isDefined(level._id_04C057B408385BB1[instance._id_EEC55FABA21F3653.id])) {
    info = level._id_04C057B408385BB1[instance._id_EEC55FABA21F3653.id];
    _id_2D9C29F869A29FCA::_id_844DFE93476D59AB(info[0], instance.origin, info[1]);
  }

  playerteam = player.team;
  wait(level._id_E26F46A3B89CD3BB);
  _id_024AECB67BB3A207 = scripts\mp\utility\teams::getenemyplayers(playerteam, 1);
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("br_dmz_bio_labs_exfil_warn", _id_024AECB67BB3A207);
}

_id_0D23A307DE97A0A8(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(instance.entity._id_EEC55FABA21F3653.group != "elevator_group_exfil") {
    return;
  }
  instance.entity._id_EEC55FABA21F3653 notify("exfil_elevator_start_extract");
}

_id_4497EC9C55F12123() {
  self._id_E108D0ABDB42CFF6[self._id_3EAD649FC902FEC2] _id_086D19A1E5F2B563("ui_map_icon_extraction", 1);
  self._id_E108D0ABDB42CFF6[self._id_3EAD649FC902FEC2] setscriptablepartstate("elevator_ext_button", "usable");
  _id_F49A04061E6EB63D = self._id_3EAD649FC902FEC2 - self._id_33DE00DF8A9FBBE0;
  self waittill("exfil_elevator_start_warm");
  self.state = "doors_warming";
}

_id_EACD3D40FF26ED40() {
  _id_5C118165D3E98A42::_id_AB1C91150C30299A();
  self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0] setscriptablepartstate("elevator_ext_button", "disabled");
  self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0] setscriptablepartstate("sound", "touched");
  objective_delete(self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0].waypointid);
  self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0]._id_CE7F7E62DF1E0B51 _id_086D19A1E5F2B563("ui_map_icon_elevator", 1);
  wait(level._id_E26F46A3B89CD3BB);
  self.state = "doors_open";
}

_id_086D19A1E5F2B563(iconname, _id_AE52C3C4A761FB73, zoffset) {
  if(!isDefined(self.waypointid))
    self.waypointid = scripts\mp\objidpoolmanager::requestobjectiveid();

  origin = self.origin;

  if(isDefined(zoffset))
    origin = origin + (0, 0, zoffset);

  scripts\mp\objidpoolmanager::objective_add_objective(self.waypointid, "current", origin, iconname, "icon_regular");
  objective_setplayintro(self.waypointid, 0);
  objective_setbackground(self.waypointid, 1);
  objective_setfadedisabled(self.waypointid, 0);
  objective_setshowoncompass(self.waypointid, 1);
  objective_setshowdistance(self.waypointid, _id_AE52C3C4A761FB73);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(self.waypointid);
}

_id_EC009A967D1D5EB9() {
  _id_C8F6F1542970369C = self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0];
  _id_C8F6F1542970369C setscriptablepartstate("elevator_button_lights", "off", 0);
  _id_C8F6F1542970369C._id_0E4118BDA122B112 setscriptablepartstate("model", "arrived", 0);
  _id_DB76C4BB596D090E = self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0];
  self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0] thread _id_5C118165D3E98A42::_id_FEA8A1D17E4D669F();
  self.car thread scripts\common\anim::anim_single_solo(self.car, "open");
  wait 0.4;
  doors = self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0].doors;

  foreach(door in doors)
  door.clip.origin = door.clip._id_C2FAC7A209524732;

  scripts\engine\utility::waittill_any_timeout_1(level._id_D99059956F0D1F3D, "exfil_elevator_start_extract");
  self.state = "doors_closing";
}

_id_8B680B3EF155FC34() {
  _id_4B1E414172FEC3A8 = self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0]._id_0E4118BDA122B112;
  self.car setscriptablepartstate("elevator_int_button", "disabled");
  players = scripts\mp\utility\teams::getteamdata(self.playerteam, "players");
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("br_dmz_bio_labs_exfil_extracting", players);
  _id_B08C53A8C68C1491(players, level._id_A0F6CF876AB471E6, 1);
  self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0] thread _id_5C118165D3E98A42::_id_7C2ABB1B0D147A89();
  self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0] setscriptablepartstate("elevator_ext_button", "disabled");
  doors = self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0].doors;

  foreach(door in doors) {
    _id_295832D2FC0E963C = door.clip._id_F16D407674809F11;
    _id_F2B34DBC14E4C1ED = door.clip._id_C2FAC7A209524732;
    _id_804D947B6EEE1F7C = vectorlerp(_id_F2B34DBC14E4C1ED, _id_295832D2FC0E963C, 1);
    door.clip moveTo(_id_804D947B6EEE1F7C, level._id_A0F6CF876AB471E6);
  }

  wait(level._id_A0F6CF876AB471E6);
  self.car thread scripts\common\anim::anim_single_solo(self.car, "close");

  foreach(door in doors)
  door.clip moveTo(door.clip._id_F16D407674809F11, 0.1);

  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("br_dmz_bio_labs_exfil_extracted", level.players);
  _id_309C0A11484CC0DB = [];

  foreach(player in level.players) {
    if(player istouching(self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0]._id_0907E66D3BF42C5A)) {
      if(scripts\mp\utility\player::isreallyalive(player)) {
        _id_309C0A11484CC0DB[_id_309C0A11484CC0DB.size] = player;
        continue;
      }

      player setplayermusicstate("");
      player thread _id_7FADAFCF58E33879();
    }
  }

  _id_975F82D85855F22A(_id_309C0A11484CC0DB);
  _id_5307834CD39B435C::_id_309C0A11484CC0DB(_id_309C0A11484CC0DB);
  wait 4;
  _id_5307834CD39B435C::_id_0EFD3004BCAA728F("bio_bunker_extract_success", _id_309C0A11484CC0DB);

  if(isDefined(self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0]._id_CE7F7E62DF1E0B51.waypointid))
    objective_delete(self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0]._id_CE7F7E62DF1E0B51.waypointid);

  self.playerteam = undefined;
  self.car setscriptablepartstate("elevator_int_button", "usable");
  _id_4B1E414172FEC3A8 setscriptablepartstate("model", "off", 0);
  wait 5;
  exfil = self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0];

  if(_id_1174ABEDBEFE9ADA::_id_26879895DB23C779(exfil.origin))
    _id_5C118165D3E98A42::_id_1526944EF1762358();
  else
    self.state = "waiting";
}

_id_975F82D85855F22A(_id_309C0A11484CC0DB) {
  if(!isDefined(level._id_11D0C321045F514F))
    level._id_11D0C321045F514F = [];

  foreach(player in _id_309C0A11484CC0DB) {
    if(!isDefined(level._id_11D0C321045F514F[player.team])) {
      _id_5940F376A254619D = spawn("script_model", (-9165.76, 12818.9, 1818.57));
      _id_5940F376A254619D.angles = (0, player.angles[1], 0);
      _id_5940F376A254619D setModel("tag_origin");
      level._id_11D0C321045F514F[player.team] = _id_5940F376A254619D;
    }

    if(player isnightvisionon())
      player nightvisionviewoff(1);
  }
}

_id_7FADAFCF58E33879() {
  level endon("game_ended");

  if(isDefined(self)) {
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0.1);
    self allowmovement(0);
    self allowfire(0);
    scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
    self sethidenameplate(0);
    self disableoffhandprimaryweapons(0);
    self disableoffhandsecondaryweapons(0);
    self disableweapons(0);
    self disableweaponswitch(0);
    self setcamerathirdperson(1);
    self allowcrouch(0);
    self allowmelee(0);
    self allowjump(0);
    self allowprone(0);
    self.ignoreme = 1;
    level thread _id_F330414BF82DDADC(self);
    _id_4480C6CE37B2BDF3::_id_0865B1A5A62C49D7();
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 0.1);
  }
}

_id_F330414BF82DDADC(player) {
  _id_1E4A61DB11011446::updateclientmatchdata(player);

  if(isDefined(player)) {
    player _id_6A5D3BF7A5B7064A::onexitdeathsdoor(0);

    if(scripts\engine\utility::array_contains(level.teamdata[player.team]["alivePlayers"], player))
      player scripts\mp\playerlogic::removefromalivecount(1);

    scripts\mp\utility\teams::validatealivecount("remove", player.team, player);
    player _id_6489FCDFE6FA2E36::spawnintermissionatplayer(player);
    player setclientomnvar("ui_br_squad_eliminated_active", 1);
    player setclientomnvar("ui_round_end_title", game["round_end"]["defeat"]);
    player setclientomnvar("ui_round_end_reason", game["end_reason"]["br_eliminated"]);
    player setclientdvar("ui_opensummary", 1);
  }

  level thread _id_4480C6CE37B2BDF3::_id_DA0FA1AFAA8835CF();
}

_id_B9730BFE1E8B9F81() {
  level endon("game_ended");

  while(!isDefined(level._id_33A2175A9A4306BC))
    waitframe();

  while(!isDefined(level._id_33A2175A9A4306BC.origin))
    waitframe();

  if(_id_4948CDF739393D2D::_id_2D421D1F793F6F93()) {
    _id_CDC5DD6C28C9709D = undefined;

    foreach(_id_276AC5E84835EA87 in level._id_F1073FBD45B59A06._id_DF987907A483DF89) {
      distsq = distance2dsquared(_id_276AC5E84835EA87.origin, level._id_33A2175A9A4306BC.origin);

      if(!isDefined(level._id_34B414922367F3C3) || distsq > _id_CDC5DD6C28C9709D) {
        level._id_34B414922367F3C3 = _id_276AC5E84835EA87;
        _id_CDC5DD6C28C9709D = distsq;
      }
    }

    if(isDefined(level._id_34B414922367F3C3)) {
      _id_02C7CC7FE73CF59E = level._id_34B414922367F3C3.script_label;
      _id_0B672455A42D115B = _id_5C118165D3E98A42::_id_E8F746DFA279CEFD(_id_02C7CC7FE73CF59E);

      if(isDefined(_id_0B672455A42D115B))
        level._id_C5074BF13FFB95EF = _id_0B672455A42D115B;
      else {}
    }
  }

  if(!isDefined(level._id_C5074BF13FFB95EF)) {
    _id_B95A019FC748357A = ["elevator_15", "elevator_16", "elevator_60", "elevator_62"];
    _id_4A2AE044A51A3FD7 = 0;

    foreach(exfil in _id_B95A019FC748357A) {
      _id_0B672455A42D115B = _id_5C118165D3E98A42::_id_E8F746DFA279CEFD(exfil);

      if(isDefined(_id_0B672455A42D115B)) {
        distsq = distance2dsquared(_id_0B672455A42D115B.origin, level._id_33A2175A9A4306BC.origin);

        if(_id_4A2AE044A51A3FD7 < distsq) {
          _id_A1EE03B4E27DCD27 = distsq;
          level._id_C5074BF13FFB95EF = _id_0B672455A42D115B;
        }

        continue;
      }
    }
  }

  level waittill("dmz_radiation_started");

  if(!_id_1174ABEDBEFE9ADA::_id_DFA94748AF73C087()) {
    return;
  }
  wait 5;
  _id_5307834CD39B435C::_id_9FDF14C5AAC8CE53("bio_bunker_exfil_called_final");
  level thread _id_C4590990651ABC27();
}

_id_C4590990651ABC27() {
  level endon("game_ended");

  for(;;) {
    _id_B1A09404F1D5C53E = _id_5C118165D3E98A42::_id_EA03313F519B9E06("elevator_group_exfil");

    if(isDefined(_id_B1A09404F1D5C53E) && _id_B1A09404F1D5C53E.size > 0) {
      foreach(_id_DC47AF52F5E37EB9 in _id_B1A09404F1D5C53E) {
        exfil = _id_DC47AF52F5E37EB9._id_E108D0ABDB42CFF6[_id_DC47AF52F5E37EB9._id_33DE00DF8A9FBBE0];

        if(_id_1174ABEDBEFE9ADA::_id_26879895DB23C779(exfil.origin))
          _id_DC47AF52F5E37EB9 _id_94EE6837BFDF0FD5();
      }
    } else {
      if(isDefined(level._id_34B414922367F3C3) && !istrue(level._id_34B414922367F3C3._id_7BE8B486A10B3DE8)) {
        level._id_34B414922367F3C3._id_7BE8B486A10B3DE8 = 1;
        _id_F8EECAA13F830D2B(level._id_34B414922367F3C3, 0);
      }

      _id_5C118165D3E98A42::_id_20E0F2F56A5BA71F("exfil", "elevator_group_exfil", "waiting", level._id_C5074BF13FFB95EF._id_32E27AD06C3E7804, undefined);
      return;
    }

    wait 1;
  }
}

_id_94EE6837BFDF0FD5() {
  if(self.state == "waiting") {
    foreach(_id_C8F6F1542970369C in self._id_E108D0ABDB42CFF6) {
      if(isDefined(_id_C8F6F1542970369C.waypointid))
        objective_delete(_id_C8F6F1542970369C.waypointid);

      _id_C8F6F1542970369C setscriptablepartstate("elevator_ext_button", "disabled");
    }

    _id_5C118165D3E98A42::_id_1526944EF1762358();
  }
}

_id_78B84E35139D8BE9() {
  level endon("game_ended");

  while(!isDefined(level.struct_class_names))
    waitframe();

  _id_B6D0B139576C3A83 = scripts\engine\utility::getStructArray("laser_sentry_defuse", "script_noteworthy");

  if(getdvarint("dvar_84DF84DF37E514FD", 1)) {
    _id_BFE291B401A9BF2A = [];
    spawncount = [];
    spawncount["random_1"] = 2;
    spawncount["random_2"] = 1;
    spawncount["random_3"] = 1;
    spawncount["random_4"] = 1;
    spawncount["random_5"] = 1;
    _id_B65EBBB448FE3556 = [];

    foreach(_id_ADB161E045B9B602 in _id_B6D0B139576C3A83) {
      groupname = _id_ADB161E045B9B602.script_label;

      if(isDefined(groupname) && issubstr(groupname, "random")) {
        if(!isDefined(_id_B65EBBB448FE3556[groupname]))
          _id_B65EBBB448FE3556[groupname] = [];

        _id_B65EBBB448FE3556[groupname][_id_B65EBBB448FE3556[groupname].size] = _id_ADB161E045B9B602;
        continue;
      }

      _id_BFE291B401A9BF2A[_id_BFE291B401A9BF2A.size] = _id_ADB161E045B9B602;
    }

    foreach(groupname, group in _id_B65EBBB448FE3556) {
      group = scripts\engine\utility::array_randomize(group);

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < group.size && _id_AC0E594AC96AA3A8 < spawncount[groupname]; _id_AC0E594AC96AA3A8++)
        _id_BFE291B401A9BF2A[_id_BFE291B401A9BF2A.size] = group[_id_AC0E594AC96AA3A8];
    }

    _id_B6D0B139576C3A83 = _id_BFE291B401A9BF2A;
  }

  _id_AC376160E4D44BCA = [];

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    _id_063EE6E4480D0312 = getDvar("dvar_8A97EF5B97633B1B", 0);

    if(isstring(_id_063EE6E4480D0312) && _id_063EE6E4480D0312 != "")
      _id_AC376160E4D44BCA = strtok(_id_063EE6E4480D0312, ",");
  }

  foreach(_id_ADB161E045B9B602 in _id_B6D0B139576C3A83) {
    _id_9713301690B896D5 = 1;

    foreach(_id_B205D90302DA2F07 in _id_AC376160E4D44BCA) {
      if(_id_5DEF7AF2A9F04234::_id_9802DD00208B0F03(_id_ADB161E045B9B602.origin, "biobunker_" + _id_B205D90302DA2F07)) {
        _id_9713301690B896D5 = 0;
        break;
      }
    }

    if(!_id_9713301690B896D5) {
      continue;
    }
    _id_ADB161E045B9B602.turrets = [];
    _id_07ADCF39D92D1DAE = scripts\engine\utility::getStructArray(_id_ADB161E045B9B602.target, "targetname");

    foreach(_id_7A1692829A8809E9 in _id_07ADCF39D92D1DAE)
    _id_ADB161E045B9B602.turrets[_id_ADB161E045B9B602.turrets.size] = _id_0518AE857A3D351C::_id_9C405FFA3BB2DCF0(_id_7A1692829A8809E9, "team_hundred_ninety_five", undefined, undefined, _id_ADB161E045B9B602, _id_7A1692829A8809E9._id_4FE5CDFF2560E8C6);

    level thread _id_0518AE857A3D351C::_id_2CC59EA2A67BD2F4(_id_ADB161E045B9B602, _id_ADB161E045B9B602.turrets);
  }
}

_id_2B0725F69E10C949(_id_801C53C0ED06495B) {
  _id_F17895B3929D1BF5 = 1;

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    _id_AC376160E4D44BCA = [];
    _id_063EE6E4480D0312 = getDvar("dvar_CEDACE19D1DEB62F", 0);

    if(isstring(_id_063EE6E4480D0312) && _id_063EE6E4480D0312 != "")
      _id_AC376160E4D44BCA = strtok(_id_063EE6E4480D0312, ",");

    foreach(_id_B205D90302DA2F07 in _id_AC376160E4D44BCA) {
      _id_171F90B9C4C76D44 = "biobunker_" + _id_B205D90302DA2F07;

      if(isDefined(_id_801C53C0ED06495B._id_B205D90302DA2F07) && _id_801C53C0ED06495B._id_B205D90302DA2F07 == _id_171F90B9C4C76D44 || _id_5DEF7AF2A9F04234::_id_9802DD00208B0F03(_id_801C53C0ED06495B.origin, _id_171F90B9C4C76D44)) {
        _id_F17895B3929D1BF5 = 0;
        break;
      }
    }
  }

  if(_id_F17895B3929D1BF5)
    scripts\cp_mp\tripwire::_id_186D7AC95077704B(_id_801C53C0ED06495B);
  else if(isDefined(level._id_D9D80893720B39DF))
    [[level._id_D9D80893720B39DF]](_id_801C53C0ED06495B);
}

_id_FC458DDEC84C95A0(_id_7D04A3A2B5F14957, index) {
  logstring("[spawnPlayer] player " + self.name + " team:" + self.team + " index:" + index + " default spawn origin:" + _id_7D04A3A2B5F14957.origin);

  if(!isDefined(_id_7D04A3A2B5F14957) || !isDefined(_id_7D04A3A2B5F14957.target) || index == 0)
    return _id_7D04A3A2B5F14957;

  point = _id_7D04A3A2B5F14957;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < index; _id_AC0E594AC96AA3A8++) {
    point = scripts\engine\utility::getStruct(point.target, "targetname");

    if(!isDefined(point) || !isDefined(point.target)) {
      break;
    }
  }

  if(isDefined(point)) {
    _id_572211C19BA28F44 = scripts\engine\utility::drop_to_ground(point.origin, 20, 0);
    spawnpoint = spawnStruct();
    spawnpoint.origin = _id_572211C19BA28F44;
    spawnpoint.angles = point.angles;
    logstring("[spawnPlayer] adjusted spawnPoint: origin:" + spawnpoint.origin + " target:" + scripts\engine\utility::ter_op(isDefined(point.target), point.target, _id_7D04A3A2B5F14957.target));
    return spawnpoint;
  } else
    return _id_7D04A3A2B5F14957;
}

_id_F8EECAA13F830D2B(_id_276AC5E84835EA87, _id_941D03AE58F7EA93) {
  foreach(door in _id_276AC5E84835EA87._id_E2CD8AA8B46D18AC) {
    if(door _meth_FAC544C98A3D9EB4()) {
      _id_57D3850A12CF1D8F::_id_B092780F9EC4496E(door);

      if(isDefined(door._id_5C493302B016B154))
        door._id_5C493302B016B154 scriptabledoorfreeze(0);
    }
  }

  if(_id_941D03AE58F7EA93) {
    _id_02C7CC7FE73CF59E = _id_276AC5E84835EA87.script_label;

    if(isDefined(_id_02C7CC7FE73CF59E) && issubstr(_id_02C7CC7FE73CF59E, "elevator_"))
      _id_5C118165D3E98A42::_id_20E0F2F56A5BA71F("exfil", "elevator_group_exfil", "waiting", _id_02C7CC7FE73CF59E, undefined);
  }
}

_id_46A4A210C0D4AF90(player) {
  _id_F8EECAA13F830D2B(self._id_276AC5E84835EA87, 1);
}

_id_D31C6F7E15184CE8() {
  level endon("game_ended");

  while(!isDefined(level._id_F1073FBD45B59A06) || !istrue(level._id_F1073FBD45B59A06._id_9B87FDB80920F442))
    waitframe();

  foreach(_id_276AC5E84835EA87 in level._id_F1073FBD45B59A06._id_DF987907A483DF89) {
    foreach(door in _id_276AC5E84835EA87._id_E2CD8AA8B46D18AC)
    door._id_783CE7DF56CE2748 = ::_id_46A4A210C0D4AF90;
  }
}

_id_B09BDA767D8E5510() {
  level endon("game_ended");

  while(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "showMiniMap"))
    waitframe();

  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "showMiniMap", ::showminimap);
}

showminimap() {}

_id_D50D0A086958E440(event, _id_401C3A2E68AAB0FD) {
  if(!isDefined(self.team)) {
    return;
  }
  foreach(player in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    player scripts\mp\utility\points::_id_0366980B6A8796AE(event);

    if(isDefined(_id_401C3A2E68AAB0FD)) {
      if(_id_401C3A2E68AAB0FD == "doorsUnlocked") {
        if(!isDefined(player._id_BD3FCBFDEDA97E97))
          player._id_BD3FCBFDEDA97E97 = 0;

        player._id_BD3FCBFDEDA97E97++;
        continue;
      }

      if(_id_401C3A2E68AAB0FD == "missionCompleted") {
        if(!isDefined(player.brmissionscompleted))
          player.brmissionscompleted = 0;

        player.brmissionscompleted++;
      }
    }
  }
}

_id_B42821BB65F6792A() {
  level endon("game_ended");
  level waittill("matchStartTimer_done");

  foreach(door in level._id_F64C6EF6F688A407) {
    if(isDefined(door._id_8F7EDDC9C0864A1B) && issubstr(door._id_8F7EDDC9C0864A1B, "force_open")) {
      _id_57D3850A12CF1D8F::_id_B092780F9EC4496E(door);
      door scriptabledooropen("away", door.origin);
    }

    if(isDefined(door._id_8F7EDDC9C0864A1B) && door._id_8F7EDDC9C0864A1B == "need_lock")
      _id_57D3850A12CF1D8F::_id_FBBFE6F05EDA5EB1(door);

    switch (door.type) {
      case "door_stairwell_metal_01a_mp":
      case "biobunker_datacenter_puzzle_door":
      case "biobunker_datacenter_puzzle_door_right":
        door._id_534FFC051D7244A7 = 1;
        break;
      default:
        door._id_534FFC051D7244A7 = 0;
    }
  }
}

_id_E0D501A53A5B64C8(points) {
  if(getdvarint("dvar_4B5D38DD0A79B7B3", 0) == 1) {
    _id_8EF89542D7D7C021 = self _meth_ 951 FA1A564714E1();

    foreach(_id_15556BCBD050DD2E in points) {
      foreach(point in _id_15556BCBD050DD2E) {
        if(point._id_78C002BE5BC09AEA == _id_8EF89542D7D7C021)
          return point;
      }

      break;
    }
  }

  return undefined;
}

_id_9C1D247CD2138289() {
  level endon("game_ended");

  while(!isDefined(level.struct_class_names) || !isDefined(level.br_pickups))
    waitframe();

  nodes = scripts\engine\utility::getStructArray("dmz_loot_crate", "script_noteworthy");

  foreach(node in nodes) {
    scriptable = spawnscriptable("dmz_crate_wood", node.origin, node.angles);
    scriptable setscriptablepartstate("body", "closed_usable");
  }
}

_id_D584D797F379D7F0() {
  level endon("game_ended");

  while(!isDefined(level.struct_class_names) || !isDefined(level.br_pickups))
    waitframe();

  _id_8493C2F9041C9204 = getdvarint("dvar_C9EB76855CA8C020", 3);
  nodes = scripts\engine\utility::getStructArray("nvg_spawn_group", "script_noteworthy");

  foreach(node in nodes) {
    _id_A942AE9112CD6BDE = scripts\engine\utility::getStructArray(node.target, "targetname");
    _id_4EFC16030B7AC1F9 = scripts\engine\utility::array_randomize(_id_A942AE9112CD6BDE);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_8493C2F9041C9204; _id_AC0E594AC96AA3A8++) {
      if(_id_AC0E594AC96AA3A8 >= _id_4EFC16030B7AC1F9.size) {
        break;
      }

      _id_FB1DEF007972B25A = _id_4EFC16030B7AC1F9[_id_AC0E594AC96AA3A8];
      dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
      _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, _id_FB1DEF007972B25A.origin, _id_FB1DEF007972B25A.angles, undefined, 0, 0);
      item = _id_7E52B56769FA7774::spawnpickup("brloot_nvg", _id_CB4FAD49263E20C4);
    }
  }
}

_id_26778943BA1601A4() {
  level._id_80DF8D4934892857 = [];
  level._id_80DF8D4934892857["xp_door_boss_saferoom"] = "stat_95F9ED42EF9AC79A";
  level._id_80DF8D4934892857["xp_door_flooded_to_boss"] = "stat_1DA43ECD73FE96D8";
  level._id_80DF8D4934892857["xp_door_radiation_to_boss"] = "stat_1DA43ECD73FE96D8";
  level._id_80DF8D4934892857["xp_door_dark_to_boss"] = "stat_1DA441CD73FE9BF1";
  level._id_80DF8D4934892857["xp_door_flooded_to_dark"] = "stat_32CC2C1E56E5B931";
  level._id_80DF8D4934892857["xp_door_radiation_to_dark"] = "stat_32CC2C1E56E5B931";
  level._id_80DF8D4934892857["xp_door_control_to_dark"] = "stat_32CC291E56E5B418";
  level._id_80DF8D4934892857["xp_door_office_to_dark"] = "stat_32CC291E56E5B418";
  level._id_80DF8D4934892857["xp_door_dark_to_data"] = "stat_B89531208DD457D9";
  level._id_859A0B2D45BCDF20 = ::_id_859A0B2D45BCDF20;
  level._id_6AB07FA19E534F51 = ::_id_6AB07FA19E534F51;
  level thread _id_4A7F448ED5FA7FEC::init(["brloot_valuable_car_battery", "brloot_valuable_jumper_cables", "loot_key_biobunker_rad_a_worn", "loot_key_biobunker_rad_b_worn", "loot_key_biobunker_water_a_worn", "loot_key_biobunker_water_b_worn", "loot_key_biobunker_boss_b_worn", "loot_key_biobunker_hub_a_worn", "loot_key_biobunker_hub_b_worn"]);
}

_id_859A0B2D45BCDF20(_id_9D1AD4A955F114E4) {
  event = level._id_80DF8D4934892857[_id_9D1AD4A955F114E4];
  _id_D50D0A086958E440(event, "doorsUnlocked");
}

_id_6AB07FA19E534F51(_id_9D1AD4A955F114E4) {
  if(_id_9D1AD4A955F114E4 == "xp_door_dark_to_boss") {
    level._id_68805521E53BDF40 = 1;
    level notify("door_dark_to_boss_opened");
  }
}

_id_4EF38295E7BA94D2() {
  _id_0995980EFC9B9A92 = getEntArray("mp_global_intermission", "classname");

  if(_id_0995980EFC9B9A92.size > 0) {
    _id_0995980EFC9B9A92[0].origin = (-9165.76, 12818.9, 1818.57);
    _id_0995980EFC9B9A92[0].angles = (15, 15, 0);
  }
}

_id_888023B4DE84B640() {
  level endon("game_ended");

  while(!isDefined(level.struct_class_names))
    waitframe();

  scripts\engine\utility::flag_wait("scriptables_ready");

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= 2; _id_AC0E594AC96AA3A8++) {
    _id_5163685A5DF9D437 = scripts\engine\utility::getStructArray("hotzone" + _id_AC0E594AC96AA3A8 + "_cache_lege", "script_noteworthy");
    _id_CFB1980CFDFD1812 = scripts\engine\utility::getStructArray("hotzone" + _id_AC0E594AC96AA3A8 + "_cache", "script_noteworthy");
    _id_AF7458F59A4160EE = scripts\engine\utility::_id_7A2AAA4A09A4D250(_id_5163685A5DF9D437);

    if(isDefined(_id_AF7458F59A4160EE)) {
      _id_BDE79363ADDF2F12 = spawnscriptable("br_loot_cache_lege", _id_AF7458F59A4160EE.origin, _id_AF7458F59A4160EE.angles);
      _id_BDE79363ADDF2F12 setscriptablepartstate("body", "closed_usable");
    }

    foreach(_id_2076A994E0E7C929 in _id_CFB1980CFDFD1812) {
      if(isDefined(_id_2076A994E0E7C929)) {
        _id_B038ED928EC17A81 = spawnscriptable("br_loot_cache", _id_2076A994E0E7C929.origin, _id_2076A994E0E7C929.angles);
        _id_B038ED928EC17A81 setscriptablepartstate("body", "closed_usable");
      }
    }
  }
}

override_unresolved_collision(player, _id_4258FB168FB20BA6) {
  player dodamage(1000, self.origin, self, self, "MOD_CRUSH");
}

_id_CC63EF945DA87741() {
  level endon("game_ended");
  level waittill("matchStartTimer_done");

  foreach(player in level.players) {
    _id_F5C0017750F207A3 = player scripts\mp\equipment::getcurrentequipment("primary");

    if(isDefined(_id_F5C0017750F207A3)) {
      _id_8E11B48A74EF4309 = player scripts\mp\equipment::getequipmentmaxammo(_id_F5C0017750F207A3);
      player scripts\mp\equipment::setequipmentammo(_id_F5C0017750F207A3, _id_8E11B48A74EF4309);
    }

    _id_702915CBE6AD0CE3 = player scripts\mp\equipment::getcurrentequipment("secondary");

    if(isDefined(_id_702915CBE6AD0CE3)) {
      _id_13DA218E5372BA49 = player scripts\mp\equipment::getequipmentmaxammo(_id_702915CBE6AD0CE3);
      player scripts\mp\equipment::setequipmentammo(_id_702915CBE6AD0CE3, _id_13DA218E5372BA49);
    }
  }
}

_id_1084379FB31A445C() {
  level endon("game_ended");

  while(!isDefined(level.struct_class_names) || !isDefined(level.br_pickups))
    waitframe();

  precachestring(&"MP_DMZ_LOCKS/LOCKED_DIAMOND_DRILL");
  _id_264B612E41417E70 = scripts\engine\utility::getStruct("dmz_s4_mission_safe", "script_noteworthy");
  _id_3543E7A2D78FF836 = scripts\engine\utility::getStruct("dmz_s4_mission_drill", "script_noteworthy");
  level._id_766099E2DC3031AA = 1;
  _id_32605DB102447D94 = spawnscriptable("dmz_safe_konni", _id_264B612E41417E70.origin, _id_264B612E41417E70.angles);
  _id_32605DB102447D94._id_CEB543956C7203E7 = ::_id_9618CC73546D253D;
  _id_32605DB102447D94._id_AB0E150EDA2B5E13 = ::_id_7C5EEFD0CBCE6520;
  _id_32605DB102447D94 setscriptablepartstate("safe", "usable_not_open");
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, _id_3543E7A2D78FF836.origin, _id_3543E7A2D78FF836.angles, undefined, 0, 0);
  item = _id_7E52B56769FA7774::spawnpickup("brloot_diamond_drill", _id_CB4FAD49263E20C4);
  item._id_8C6CE30A6A5126B1 = 1;
  item._id_BBC200BC77C5DB2B = 1;
}

_id_9618CC73546D253D(_id_69E96A4CAA72D794, player) {
  if(!isDefined(_id_69E96A4CAA72D794) || !isDefined(player)) {
    return;
  }
  _id_69E96A4CAA72D794 setscriptablepartstate("safe", "open_usable");
}

_id_7C5EEFD0CBCE6520(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(state == "usable_not_open") {
    _id_5D10FD4182B17097 = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("brloot_diamond_drill");

    if(!player _id_2D9D24F7C63AC143::_id_36B1968BFE78916B(_id_5D10FD4182B17097)) {
      player scripts\mp\hud_message::showerrormessage("MP_DMZ_LOCKS/LOCKED_DIAMOND_DRILL");
      return 0;
    } else
      player _id_2D9D24F7C63AC143::_id_6F39F9916649AC48(_id_5D10FD4182B17097, 1);

    instance setscriptablepartstate(part, "unusable");
    instance._id_B14A331BA425C286 = 0;
    instance thread _id_662CBAC61C1AE7E2::_id_24765A7AABF0093E(player);
    instance _id_662CBAC61C1AE7E2::_id_7F10E8E120314F4B(player, part);

    if(istrue(instance._id_B14A331BA425C286)) {
      _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_bunker_safe_defend_started", level.players);
      wait 1;
      instance thread _id_04B2E6BD87A657B6();
      return;
    }

    instance setscriptablepartstate(part, "usable_not_open");
    return;
  } else if(state == "open_usable") {
    if(instance getscriptableparthasstate(part, "unusable"))
      instance setscriptablepartstate(part, "unusable");

    if(!isDefined(instance.contents)) {
      items = ["interactable_note_bunker_safe", "brloot_valuable_bunker_notes_unique", "brloot_plate_carrier_3_comms", "brloot_plate_carrier_3_medic", "brloot_plate_carrier_3_stealth"];
      instance._id_46A3A8565AC0C17C = 4;
      instance _id_552B8E4EA5FF7DF1::lootcachespawncontents(items, 1, player, instance.contents);
    } else
      instance _id_552B8E4EA5FF7DF1::lootcachespawncontents(undefined, 1, player, instance.contents);
  } else if(state == "usable_drilling") {
    instance.paused = 0;
    instance setscriptablepartstate("safe", "unusable_drilling");
  }
}

_id_D0C5BF4C2D924D87() {
  objid = self._id_75F558A60D4866EA;
  self.progress = 0;
  _id_28C33EF10A3CB4A1::_id_D30610B7162215A2("boss_reinforcement_left_hard");
  _id_28C33EF10A3CB4A1::_id_D30610B7162215A2("boss_reinforcement_right_hard");
  capturetime = 180;

  while(self.progress < 1) {
    if(self._id_78122E18403A8DC4.size > 0 && !istrue(self.paused)) {
      _id_BFBD5393EF742E6E = clamp(self.progress + level.framedurationseconds / capturetime, 0, 1);
      self.progress = _id_BFBD5393EF742E6E;
      scripts\mp\objidpoolmanager::objective_set_progress(objid, self.progress);
    } else if(!istrue(self.paused)) {
      min = 0;

      if(self.progress > 0.67)
        min = 0.671;
      else if(self.progress > 0.33)
        min = 0.331;

      self.progress = clamp(self.progress - level.framedurationseconds / 180, min, 1);
      scripts\mp\objidpoolmanager::objective_set_progress(objid, self.progress);
    }

    waitframe();
  }

  _id_E188C0417CE5BA50();
  _id_28C33EF10A3CB4A1::_id_D30610B7162215A2("boss_reinforcement_left_hard");
  _id_28C33EF10A3CB4A1::_id_D30610B7162215A2("boss_reinforcement_right_hard");
}

_id_E188C0417CE5BA50() {
  self notify("captured");
  self._id_6DFAEE5EE2B3FA4B = 1;
  _id_1B8524F934EDD790 = [];

  foreach(player in self._id_78122E18403A8DC4) {
    scripts\mp\objidpoolmanager::objective_unpin_player(self._id_75F558A60D4866EA, player);
    scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(self._id_75F558A60D4866EA, player);
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self._id_75F558A60D4866EA, player);
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self._id_DB3EC7BAD51739CA, player);

    if(!isDefined(player._id_35B94C88CC1CEA97))
      player._id_35B94C88CC1CEA97 = 0;

    player._id_35B94C88CC1CEA97++;
    _id_6A8EC730B2BFA844::_id_D8BAE32458CE35B7(player);
    player scripts\mp\utility\points::_id_0366980B6A8796AE("stat_C02C8C802F07C908");

    if(isDefined(player) && isDefined(player.team) && !isDefined(_id_1B8524F934EDD790[player.team]))
      _id_1B8524F934EDD790[player.team] = 1;
  }

  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_bunker_safe_defend_unlocked", self._id_78122E18403A8DC4);
  self.objidnum = self._id_75F558A60D4866EA;
  scripts\mp\gameobjects::releaseid();
  self setscriptablepartstate("safe", "opening");
}

_id_04B2E6BD87A657B6() {
  thread _id_DE90BD6BD487DBA7();
  thread _id_D0C5BF4C2D924D87();
}

_id_DE90BD6BD487DBA7() {
  self endon("captured");
  self.curorigin = self.origin;
  self.offset3d = (0, 0, 70);
  scripts\mp\gameobjects::requestid(1, 0, undefined, 1);
  _id_DB3EC7BAD51739CA = self.objidnum;
  self._id_DB3EC7BAD51739CA = _id_DB3EC7BAD51739CA;
  objective_setpings(_id_DB3EC7BAD51739CA, 1);
  objective_setzoffset(_id_DB3EC7BAD51739CA, 70);
  objective_icon(_id_DB3EC7BAD51739CA, "ui_map_icon_safe");
  objective_setbackground(_id_DB3EC7BAD51739CA, 1);
  objective_state(_id_DB3EC7BAD51739CA, "current");
  objective_setownerteam(_id_DB3EC7BAD51739CA, undefined);
  objective_setprogressteam(_id_DB3EC7BAD51739CA, undefined);
  scripts\mp\objidpoolmanager::_id_79A1A16DE6B22B2D(_id_DB3EC7BAD51739CA, 16);
  scripts\mp\objidpoolmanager::objective_set_play_intro(_id_DB3EC7BAD51739CA, 1);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(_id_DB3EC7BAD51739CA);
  scripts\mp\gameobjects::requestid(1, 0, undefined, 1);
  _id_75F558A60D4866EA = self.objidnum;
  self._id_75F558A60D4866EA = _id_75F558A60D4866EA;
  scripts\mp\objidpoolmanager::update_objective_icon(_id_75F558A60D4866EA, "ui_map_icon_safe");
  scripts\mp\objidpoolmanager::update_objective_setbackground(_id_75F558A60D4866EA, 1);
  scripts\mp\objidpoolmanager::objective_pin_global(_id_75F558A60D4866EA, 1);
  scripts\mp\objidpoolmanager::_id_D7E3C4A08682C1B9(_id_75F558A60D4866EA, 1);
  scripts\mp\objidpoolmanager::objective_set_play_intro(_id_75F558A60D4866EA, 0);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(_id_75F558A60D4866EA);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(_id_75F558A60D4866EA, 70);
  scripts\mp\objidpoolmanager::update_objective_state(_id_75F558A60D4866EA, "invisible");
  objective_setshowprogress(_id_75F558A60D4866EA, 1);
  self._id_78122E18403A8DC4 = [];
  self._id_7F678C2DC78B1EAB = 0;
  _id_D83AA4B44EFF7B60 = gettime();
  _id_47FD265041DEA4AB = 0;

  for(;;) {
    _id_C8DADD43AEFDC396 = [];

    foreach(player in level.players) {
      if(isDefined(player.origin) && distancesquared(self.origin, player.origin) < 640000)
        _id_C8DADD43AEFDC396[_id_C8DADD43AEFDC396.size] = player;
    }

    if(_id_C8DADD43AEFDC396.size > 0)
      _id_D83AA4B44EFF7B60 = gettime();

    _id_BA2E680C7043AB1F = gettime() - _id_D83AA4B44EFF7B60 > 20000;

    if(self._id_7F678C2DC78B1EAB && !_id_BA2E680C7043AB1F && istrue(self._id_2847F8D00AEE9DC7) && isDefined(self.heli))
      self.heli notify("newpath");

    self._id_7F678C2DC78B1EAB = _id_BA2E680C7043AB1F;
    _id_0E34E332590AC462 = scripts\engine\utility::array_difference(_id_C8DADD43AEFDC396, self._id_78122E18403A8DC4);
    _id_EA6B4EEEAEA5CDC3 = scripts\engine\utility::array_difference(self._id_78122E18403A8DC4, _id_C8DADD43AEFDC396);

    if(istrue(self.paused) ^ _id_47FD265041DEA4AB) {
      foreach(player in self._id_78122E18403A8DC4) {
        if(isDefined(player)) {
          scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(_id_75F558A60D4866EA, player);
          scripts\mp\objidpoolmanager::objective_playermask_hidefrom(_id_75F558A60D4866EA, player);
        }
      }

      self._id_78122E18403A8DC4 = [];
      _id_47FD265041DEA4AB = istrue(self.paused);
      waitframe();
      continue;
    }

    _id_47FD265041DEA4AB = istrue(self.paused);
    _id_9DE1C91D7176D1BB = scripts\engine\utility::ter_op(_id_47FD265041DEA4AB, &"MP_DMZ_MISSIONS/SAFE_PAUSED", &"MP_DMZ_MISSIONS/OPENING_SAFE");

    foreach(player in _id_0E34E332590AC462) {
      if(isDefined(player)) {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(_id_75F558A60D4866EA, player);
        scripts\mp\objidpoolmanager::_id_CE702E5925E31FC9(_id_75F558A60D4866EA, player, 2, 2, _id_9DE1C91D7176D1BB);
      }
    }

    foreach(player in _id_EA6B4EEEAEA5CDC3) {
      if(isDefined(player)) {
        scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(_id_75F558A60D4866EA, player);
        scripts\mp\objidpoolmanager::objective_playermask_hidefrom(_id_75F558A60D4866EA, player);
      }
    }

    self._id_78122E18403A8DC4 = _id_C8DADD43AEFDC396;
    _id_4B6B489DAE052A24 = [];

    foreach(player in _id_C8DADD43AEFDC396) {
      if(!isDefined(player.team)) {
        continue;
      }
      if(!isDefined(_id_4B6B489DAE052A24[player.team]))
        _id_4B6B489DAE052A24[player.team] = 0;

      _id_4B6B489DAE052A24[player.team] = _id_4B6B489DAE052A24[player.team] + 1;
    }

    max = 0;
    _id_2E0BDB36F81A37E4 = "team_hundred_ninety_five";

    foreach(team, count in _id_4B6B489DAE052A24) {
      if(count > max) {
        _id_2E0BDB36F81A37E4 = team;
        max = count;
        continue;
      }

      if(count == max)
        _id_2E0BDB36F81A37E4 = "team_hundred_ninety_five";
    }

    objective_setownerteam(_id_75F558A60D4866EA, _id_2E0BDB36F81A37E4);
    objective_setprogressteam(_id_75F558A60D4866EA, _id_2E0BDB36F81A37E4);
    objective_setownerteam(_id_DB3EC7BAD51739CA, _id_2E0BDB36F81A37E4);
    objective_setprogressteam(_id_DB3EC7BAD51739CA, _id_2E0BDB36F81A37E4);
    objective_setpulsate(_id_DB3EC7BAD51739CA, 1);
    wait 1;
  }
}
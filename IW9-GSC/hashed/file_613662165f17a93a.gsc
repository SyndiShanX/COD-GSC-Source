/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_613662165f17a93a.gsc
***********************************************/

_id_032566017AA4406B() {
  _id_41F1DBEC9B231DA5();
  _id_3858411D0B73D352::load_vfx();
  level thread scripts\cp\cp_enemy_drone_turret::init();
  level.fnplaysoundonentity = scripts\cp\utility::play_sound_on_entity;
  level.fnplaysoundontag = scripts\cp\utility::play_sound_on_tag;
  setDvar("dvar_F94319AFACA59ED6", 1);
  level._id_72069798E35CC6BC = [];
  level._id_EF796AC0B0326726 = _id_51023E7DB5068D92::_id_5D07E8092CB10167;
  level._id_42354BFD2F2F8439 = _id_51023E7DB5068D92::_id_C6477B99E150A457;
  objname = getDvar("dvar_555D54BF3BDC1791", "stealth_container");
  level._id_6C5A3DD9183FA65E = _id_51023E7DB5068D92::_id_6C5A3DD9183FA65E;
  level._id_06B67B924A327783 = _id_51023E7DB5068D92::_id_27C39909E6A63240;
  level._id_9EE21672DC268105 = ::_id_C99DAEC6F4F98A53;
  level._id_54DA6E863D463AC0 = ::_id_E33986803D2B414B;
  level._id_B42368D46E1FDFDD = [];
  level._id_2418F6A5C3E407A5 = ::_id_776A6FA5EEEB2228;
  level._id_F42102B6DE7CE00D = ::_id_177B0449EB6DA0D2;
  level._id_8332A0D90935D5E8 = [];
  level._id_8332A0D90935D5E8["stealth_a"] = 0;
  level._id_8332A0D90935D5E8["stealth_b"] = 0;
  level._id_8332A0D90935D5E8["stealth_c"] = 0;
  level._id_8332A0D90935D5E8["exfil_area"] = 0;
  level._id_DE5C23C3A2FA91CB = 0;
  level._id_56FA11DD909C10E7 = 0;
  scripts\engine\utility::flag_init("leave_lz");
  scripts\engine\utility::flag_init("hover_lz");
  scripts\engine\utility::flag_init("reached_hover_pos");
  _id_EA0FBAC82EEC8FC1 = getEnt("exfil_heli_spawner", "targetname");

  if(isDefined(_id_EA0FBAC82EEC8FC1))
    _id_EA0FBAC82EEC8FC1 hide();

  if(!scripts\engine\utility::flag_exist("cp_hydro_create_script_completed"))
    scripts\engine\utility::flag_init("cp_hydro_create_script_completed");

  scripts\engine\utility::flag_wait("cp_hydro_create_script_completed");
  thread _id_5CAEC4F45B7F7605::_id_B33CB337B3E7001A();
  thread scripts\cp\cp_outofbounds::initoob();
  _id_3858411D0B73D352::load_systems();
  thread _id_0F0F82FC78960925();
  _id_51023E7DB5068D92::_id_A6464C518CB4A509();
  _id_BE963B21C8D5D979();
  level thread _id_1C2CC25B48084563();
  level thread _id_7E1A468DA43087E3::_id_B7148080659216FE();
  level._id_2D101818F128EF41 = scripts\engine\utility::getStruct("heli_landing_zone", "targetname");
  level._id_AE2B1C58C455781E = scripts\engine\utility::getStruct("auto15906", "targetname");
  level._id_AE2B1B58C45575EB = scripts\engine\utility::getStruct("auto15902", "targetname");
  thread _id_3858411D0B73D352::_id_CF8E838AFE1B1AAD();
}

_id_9D53746527A565C4() {
  for(;;) {
    if(!isDefined(level._id_DF588BF29C7FF9BC)) {
      waitframe();
      continue;
    }

    iprintln("3D Distance To Chopper ^1" + distance(level._id_2D101818F128EF41.origin, level._id_DF588BF29C7FF9BC.origin));
    wait 1;
  }
}

_id_177B0449EB6DA0D2(eattacker, enemy, sweapon) {
  if(isDefined(eattacker))
    _id_6BC9557C53B7E270 = eattacker _id_2ED2B6259AF70E03();
  else
    _id_6BC9557C53B7E270 = _id_2ED2B6259AF70E03();

  return _id_6BC9557C53B7E270;
}

_id_2ED2B6259AF70E03() {
  if(istrue(level._id_AC775ED66AAEB771))
    return "exfil";

  if(!isPlayer(self))
    return "init_no_objective";

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

_id_BE963B21C8D5D979() {
  scripts\cp\cp_objectives::registerobjective("stealth_container", ::_id_BBF81E33F7B06817, ::_id_62B49D388C4CA4A3, ::_id_D3ED4BF5030BA9D2, scripts\cp\cp_objectives::debugbeatobjective, ::_id_7D5B93E817BAD968);
  scripts\cp\cp_objectives::registerobjective("exfil_area", ::_id_F60EE28DE6796358, ::_id_9A64F73C558D3864, ::_id_B8C003D496D6747B, scripts\cp\cp_objectives::debugbeatobjective, ::_id_1763A9613C977A65);
}

_id_BBF81E33F7B06817(objectivestruct, _id_5DCDFD3A4EFF9961) {
  level._id_346468EE3644046F = 1;
  scripts\engine\utility::flag_wait("cp_hydro_create_script_completed");

  if(istrue(level._id_23577A5CAF4D5B54)) {
    return;
  }
  level._id_23577A5CAF4D5B54 = 1;
  level._id_CA6CEFECC2DC7F98 = objectivestruct;
  level.hvts_identified = 1;
  thread _id_CE1647535676EC18(objectivestruct, _id_5DCDFD3A4EFF9961);
  thread _id_EAA580BFFF8B72FC(objectivestruct, _id_5DCDFD3A4EFF9961);
}

_id_EAA580BFFF8B72FC(objectivestruct, _id_5DCDFD3A4EFF9961) {
  level._id_5E5D0BB4EF6EC41F = scripts\engine\utility::getStruct("lz_location", "targetname");
  thread _id_20C177BF79748216(objectivestruct, _id_5DCDFD3A4EFF9961);
}

_id_20C177BF79748216(objectivestruct, _id_5DCDFD3A4EFF9961) {
  level waittill("clear_dz_point");
}

_id_CE1647535676EC18(objectivestruct, _id_5DCDFD3A4EFF9961) {
  if(!scripts\engine\utility::flag("cleared_to_play_intro_vo")) {
    foreach(player in level.players)
    player setclientomnvar("ui_hide_objectives", 0);
  }

  _id_7E1A468DA43087E3::_id_0DE018603BD4D720();
  _id_5634333FDFCEF66F = ["a", "b", "c"];

  foreach(obj in _id_5634333FDFCEF66F) {
    _id_4BABF1F5FAC3C4E2 = scripts\engine\utility::getStructArray("level_crate_spawn_struct_" + obj, "targetname");
    _id_7E1A468DA43087E3::level_offhand_spawn(_id_4BABF1F5FAC3C4E2);
  }

  _id_4BABF1F5FAC3C4E2 = scripts\engine\utility::getStructArray("level_crate_spawn_struct", "targetname");
  _id_7E1A468DA43087E3::level_offhand_spawn(_id_4BABF1F5FAC3C4E2);
  level thread _id_F7A95F0080A7221B();
  scripts\engine\utility::flag_wait("both_players_intro_binks_complete");

  if(!isDefined(level._id_7B5771F0D3E048A0))
    level._id_7B5771F0D3E048A0 = [];

  if(getdvarint("dvar_BF87B155F253D7FD", 0) == 0) {
    if(isDefined(level._id_D0ADA23E81337306)) {
      if(!scripts\engine\utility::array_contains(level._id_D0ADA23E81337306, "c")) {
        _id_8BDD1937DC080CCA = scripts\engine\utility::getStructArray("laser_sentry_defuse", "script_noteworthy");

        foreach(_id_FF03DED389B65A7D in _id_8BDD1937DC080CCA) {
          if(istrue(level._id_2473C417153EFC50)) {
            continue;
          }
          _id_FF03DED389B65A7D.turrets = [];
          _id_C3336162B80CD5D1 = scripts\engine\utility::getStructArray(_id_FF03DED389B65A7D.target, "targetname");

          foreach(_id_573F54C927E2EB98 in _id_C3336162B80CD5D1)
          _id_FF03DED389B65A7D.turrets = scripts\engine\utility::array_add(_id_FF03DED389B65A7D.turrets, _id_3AE866A6DD08DAF9::_id_9C405FFA3BB2DCF0(_id_573F54C927E2EB98, undefined, "electronics_ir_laser_device_rig_skeleton", _id_FF03DED389B65A7D));

          _id_3AE866A6DD08DAF9::_id_2CC59EA2A67BD2F4(_id_FF03DED389B65A7D, _id_FF03DED389B65A7D.turrets);
          level._id_7B5771F0D3E048A0 = scripts\engine\utility::array_add(level._id_7B5771F0D3E048A0, _id_FF03DED389B65A7D);
        }

        level._id_2473C417153EFC50 = 1;
      }
    } else {
      _id_8BDD1937DC080CCA = scripts\engine\utility::getStructArray("laser_sentry_defuse", "script_noteworthy");

      foreach(_id_FF03DED389B65A7D in _id_8BDD1937DC080CCA) {
        if(istrue(level._id_2473C417153EFC50)) {
          continue;
        }
        _id_FF03DED389B65A7D.turrets = [];
        _id_C3336162B80CD5D1 = scripts\engine\utility::getStructArray(_id_FF03DED389B65A7D.target, "targetname");

        foreach(_id_573F54C927E2EB98 in _id_C3336162B80CD5D1)
        _id_FF03DED389B65A7D.turrets = scripts\engine\utility::array_add(_id_FF03DED389B65A7D.turrets, _id_3AE866A6DD08DAF9::_id_9C405FFA3BB2DCF0(_id_573F54C927E2EB98, undefined, "electronics_ir_laser_device_rig_skeleton", _id_FF03DED389B65A7D));

        _id_3AE866A6DD08DAF9::_id_2CC59EA2A67BD2F4(_id_FF03DED389B65A7D, _id_FF03DED389B65A7D.turrets);
        level._id_7B5771F0D3E048A0 = scripts\engine\utility::array_add(level._id_7B5771F0D3E048A0, _id_FF03DED389B65A7D);
      }

      level._id_2473C417153EFC50 = 1;
    }
  }
}

_id_62B49D388C4CA4A3(objectivestruct, _id_5DCDFD3A4EFF9961) {
  if(isDefined(level._id_D0ADA23E81337306) && level._id_D0ADA23E81337306.size == 3) {
    return;
  }
  scripts\cp\cp_player_battlechatter::togglecpplayerbc(1);

  if(getdvarint("dvar_9A8052AC099141AF") != 0 && (!isDefined(level._id_D0ADA23E81337306) || isDefined(level._id_D0ADA23E81337306) && level._id_D0ADA23E81337306.size == 0))
    thread _id_BDDFCADCE5C8FC1E();
  else
    _id_BDDFCADCE5C8FC1E();

  _id_18A73A64992DD07D::run_spawn_module("ambient_ai_barracks");
  _id_18A73A64992DD07D::run_spawn_module("ambient_ai_comms");
  _id_18A73A64992DD07D::run_spawn_module("ambient_ai_armory");

  if(getdvarint("dvar_A5984DB78C4346DB", 0) != 0)
    _id_7E1A468DA43087E3::_id_3703DAD2AF353FB0();

  _id_479E458F6F530F0D::_id_58BF160252F94E21();

  if(getdvarint("dvar_A157C901F4E94F29", 0) == 0)
    thread _id_76496243536813FF();

  thread _id_A784F21FBC09B7A6();
  _id_51023E7DB5068D92::_id_DB3A84DB2F2EF16F(objectivestruct.objectiveindex);
  thread scripts\cp\utility::objective_update("stealth_container", undefined, undefined, undefined, undefined, level._id_F30F234DCD5FE40B.size);
  scripts\engine\utility::flag_init("safe_to_start_exfil_briefing");

  if(isDefined(level._id_D0ADA23E81337306) && level._id_D0ADA23E81337306.size > 0) {
    switch (level._id_D0ADA23E81337306.size) {
      case 2:
      case 1:
        while(level._id_324A6E68A953D960 + level._id_D0ADA23E81337306.size < level._id_A9B2958FE504A4E6.size)
          waitframe();

        break;
      case 3:
        break;
    }
  } else {
    while(level._id_324A6E68A953D960 < level._id_A9B2958FE504A4E6.size)
      waitframe();
  }

  scripts\cp\cp_achievement::_id_EE76C2B537F53629();
  scripts\cp\challenges_cp::_id_B7193191C525B263();
}

_id_A784F21FBC09B7A6() {
  if(istrue(level._id_800C60CFEEAF3222)) {
    return;
  }
  level._id_800C60CFEEAF3222 = 1;
  level thread _id_3F36F922FAC89B88::_id_9B4E08F8DE0B4636();
}

_id_D3ED4BF5030BA9D2(objectivestruct, _id_5DCDFD3A4EFF9961) {
  scripts\cp\cp_objectives::overridenextstep(objectivestruct, "exfil_area");
}

_id_7D5B93E817BAD968(objectivestruct) {
  scripts\engine\utility::flag_wait("cp_hydro_create_script_completed");
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(scripts\cp\equipment\nvg::runnvg);
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(_id_7E1A468DA43087E3::_id_7CD97A856163B260);
  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(checkpoint != "") {
    foreach(player in level.players)
    player scripts\cp\equipment\nvg::runnvg();

    return;
  }

  if(getdvarint("dvar_69CB90D22E939F4F", 0) != 0) {
    scripts\cp\utility::teleportallplayersinteamtostructs("allies", "checkpoint_spawner_c", 1);
    setDvar("dvar_76EC06326708E615", 1);
  }

  foreach(player in level.players)
  player scripts\cp\equipment\nvg::runnvg();
}

_id_9C72267F1FA89140() {
  _id_7E1A468DA43087E3::_id_0DE018603BD4D720();
}

_id_F60EE28DE6796358(objectivestruct, _id_5DCDFD3A4EFF9961) {
  if(istrue(level._id_AC775ED66AAEB771)) {
    return;
  }
  scripts\engine\utility::flag_set("laswell_intro_vo_done");
  scripts\engine\utility::flag_set("laswell_infil_briefing_done");
  scripts\engine\utility::flag_set("cleared_to_play_intro_vo");
  scripts\engine\utility::flag_set("exfil_triggered");
  level notify("end_laswell_stealth_vo_threads");
  level notify("vo_areaSecureThreadCleanup");
  level._id_346468EE3644046F = 1;

  if(!scripts\engine\utility::flag_exist("player_spawned_with_loadout"))
    scripts\engine\utility::flag_init("player_spawned_with_loadout");

  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  _id_8164F8B29CDABF6A = scripts\engine\utility::getStructArray("laserarray_origin", "script_noteworthy");

  foreach(laser in _id_8164F8B29CDABF6A)
  laser notify("laser_destroyed");

  _id_18A73A64992DD07D::stop_all_groups();
  scripts\cp\cp_checkpoint::checkpoint_set("checkpoint_exfil");
  thread _id_7E1A468DA43087E3::_id_2DD223C2D3A19995();
  objectivestruct._id_57C09087194B74FC = scripts\cp\cp_objectives::requestworldid("exfil_obj" + objectivestruct.index, 1 + int(objectivestruct.index));
  objective_setdescription(objectivestruct._id_57C09087194B74FC, &"CP_BAD_SITUATION_OBJ/GOTO_EXFIL");
  objective_setlabel(objectivestruct._id_57C09087194B74FC, &"CP_BAD_SITUATION_OBJ/EXFIL_LABEL");
  objective_setplayintro(objectivestruct._id_57C09087194B74FC, 1);
  objective_setplayoutro(objectivestruct._id_57C09087194B74FC, 1);
  objective_setlocation(objectivestruct._id_57C09087194B74FC, 0, getEnt("leave_player_trigger", "targetname").origin);
  _id_6878C17402762BFB(scripts\engine\utility::getStruct("exfil_flare", "targetname").origin, scripts\engine\utility::getStruct("exfil_flare", "targetname").angles);
  objective_state(objectivestruct._id_57C09087194B74FC, "current");
  objective_icon(objectivestruct._id_57C09087194B74FC, "icon_waypoint_objective_general");
}

_id_6878C17402762BFB(pos, angles) {
  level._id_47A7971C0FC4AB20 = spawn("script_model", pos);
  level._id_47A7971C0FC4AB20.angles = angles;
  level._id_47A7971C0FC4AB20.team = "allies";
  level._id_47A7971C0FC4AB20 setModel("tag_origin");
  level._id_47A7971C0FC4AB20 thread _id_6AD3E7AF06250123();
}

_id_6AD3E7AF06250123() {
  for(;;) {
    level._id_47A7971C0FC4AB20 thread _id_7B6555362BBE3F95();

    foreach(player in level.players) {
      if(isDefined(player) && scripts\cp\utility\player::isreallyalive(player)) {
        if(distance(level._id_47A7971C0FC4AB20.origin, player.origin) < 5000) {
          playFXOnTag(level._effect["vfx_smk_signal_dmz"], level._id_47A7971C0FC4AB20, "tag_origin");
          return;
        }
      }
    }

    wait 1;
  }
}

_id_7B6555362BBE3F95() {
  if(!isDefined(self._id_0BA3396E2B7597B2)) {
    waitframe();
    self._id_0BA3396E2B7597B2 = 1;
    self playSound("smoke_carepackage_expl_trans");
    self playLoopSound("smoke_carepackage_smoke_lp");
  }
}

_id_F10A44AA44A8FB03() {
  stopFXOnTag(level._effect["vfx_smk_signal_dmz"], level._id_47A7971C0FC4AB20, "tag_origin");
  playFXOnTag(level._effect["vfx_smk_signal_dmz_diss"], level._id_47A7971C0FC4AB20, "tag_origin");
  level._id_47A7971C0FC4AB20 playSound("smoke_canister_tail_dissipate");
  wait 1;
  level._id_47A7971C0FC4AB20 stoploopsound();
  level._id_47A7971C0FC4AB20._id_0BA3396E2B7597B2 = undefined;
}

_id_9A64F73C558D3864(objectivestruct, _id_5DCDFD3A4EFF9961) {
  if(istrue(level._id_AC775ED66AAEB771)) {
    return;
  }
  level._id_AC775ED66AAEB771 = 1;
  _id_742F61B6768A1AAB::_id_86B3E62128DEF56C(3);
  thread _id_3858411D0B73D352::outro_main(objectivestruct._id_57C09087194B74FC);
  thread _id_3F36F922FAC89B88::_id_1D0378AEFD2D7FA5();
  thread _id_CD93259FC7F33354();
  scripts\cp\cp_player_battlechatter::togglecpplayerbc(1);

  if(!scripts\engine\utility::flag_exist("leave_lz"))
    scripts\engine\utility::flag_init("leave_lz");

  scripts\engine\utility::flag_wait("leave_lz");
  scripts\cp\cp_analytics::_id_B6283AC45A607764("exfil_area");
  scripts\cp\cp_checkpoint::checkpoint_set("checkpoint_start");
  wait 10;
  level notify("escort_heli_delete_heli");
}

_id_6A84AE2D55CEE7B7() {
  _id_18A73A64992DD07D::run_spawn_module("exfil_exterior_reinforcement_" + _id_742F61B6768A1AAB::_id_D70F981E9EBE2A90());
}

_id_CD93259FC7F33354() {
  thread _id_6A84AE2D55CEE7B7();
  _id_CBD652D85EF24B68 = getEnt("spawn_all_exfil_vehicles", "targetname");

  if(isDefined(_id_CBD652D85EF24B68))
    _id_3F36F922FAC89B88::_id_611022CAB305A8F5(_id_CBD652D85EF24B68);

  scripts\engine\utility::flag_wait("exfil_intro_vo_done");

  for(_id_F940C1E878A94160 = 1; _id_F940C1E878A94160 <= 9; _id_F940C1E878A94160++) {
    _id_F940C1E878A94160 = int(clamp(_id_F940C1E878A94160, 1, 9));
    spawner = scripts\engine\utility::getStruct("exfil_vehicle_" + _id_F940C1E878A94160, "targetname");

    if(!isDefined(spawner)) {
      continue;
    }
    spawner._id_79FA6BD3C9BF6A0D = 1;
    thread _id_102A94F32E01AD69(spawner);
    wait 3;
  }
}

_id_102A94F32E01AD69(spawner) {
  _id_3F36F922FAC89B88::_id_DEF7A7EC079353A0(spawner);
  _id_BCD3A5DE2E863472();
  thread scripts\cp\cp_spawning_util::_id_94E3A9862B435632(spawner);
}

_id_BCD3A5DE2E863472(_id_C48A8DA587D19F4B) {
  level endon("game_ended");

  for(;;) {
    foreach(area, _id_9215D834F0060ABD in level._id_3221D2DB1C467EED) {
      _id_9215D834F0060ABD = scripts\engine\utility::array_removedead_or_dying(_id_9215D834F0060ABD);
      _id_9215D834F0060ABD = scripts\engine\utility::array_removeundefined(_id_9215D834F0060ABD);
      maxdist = 4000;

      if(isDefined(_id_C48A8DA587D19F4B))
        maxdist = _id_C48A8DA587D19F4B;

      _id_CDC5DD6C28C9709D = squared(maxdist);

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_9215D834F0060ABD.size; _id_AC0E594AC96AA3A8++) {
        if(isalive(_id_9215D834F0060ABD[_id_AC0E594AC96AA3A8])) {
          if(_id_9215D834F0060ABD[_id_AC0E594AC96AA3A8] _id_35DE402EFC5ACFB3::_id_9F810AAE92AC7BF1(3)) {
            continue;
          }
          if(isDefined(_id_9215D834F0060ABD[_id_AC0E594AC96AA3A8].vehicle)) {
            continue;
          }
          if(isDefined(_id_9215D834F0060ABD[_id_AC0E594AC96AA3A8].ridingvehicle)) {
            continue;
          }
          _id_9215D834F0060ABD[_id_AC0E594AC96AA3A8].dontkilloff = 0;
          _id_D26C161386B2B083 = 0;

          foreach(player in level.players) {
            if(distance2dsquared(player.origin, _id_9215D834F0060ABD[_id_AC0E594AC96AA3A8].origin) < _id_CDC5DD6C28C9709D)
              _id_D26C161386B2B083 = 1;

            if(_id_2B79931B08683E0A::player_can_see_ai(player, _id_9215D834F0060ABD[_id_AC0E594AC96AA3A8]))
              _id_D26C161386B2B083 = 1;
          }

          if(!_id_D26C161386B2B083)
            _id_9215D834F0060ABD[_id_AC0E594AC96AA3A8] _id_18A73A64992DD07D::script_kill_ai();
        }
      }
    }

    if(getaiarray("axis").size < 32) {
      break;
    }

    wait 1;
  }

  waitframe();
}

_id_1BA5516CB29B671F() {
  _id_B272B0FF03EF37D6 = 6.0;
  _id_AAFB47C968E733BC = 0.5;
  _id_AAD835C968C0C46E = 1.0;
  _id_0036743E75FE4A30 = scripts\engine\utility::getStructArray("smoke_end_struct", "targetname");

  foreach(_id_D0697AF2ECA83D63 in _id_0036743E75FE4A30) {
    magicgrenademanual("smoke_grenade_mp", _id_D0697AF2ECA83D63.origin, (0, 0, 4), 0.05);
    _id_3D5486C42744F400 = randomfloatrange(_id_AAFB47C968E733BC, _id_AAD835C968C0C46E);
    wait(_id_3D5486C42744F400);
  }

  _id_18A73A64992DD07D::run_spawn_module("bs_exfil_riotshield");
  _id_18A73A64992DD07D::run_spawn_module("bs_exfil_rpg");
  _id_18A73A64992DD07D::run_spawn_module("bs_exfil_lmg");
  _id_18A73A64992DD07D::run_spawn_module("bs_exfil_shotgun");
  _id_18A73A64992DD07D::run_spawn_module("bs_exfil_jugg");
}

_id_B8C003D496D6747B(objectivestruct, _id_5DCDFD3A4EFF9961) {
  _id_7E1A468DA43087E3::_id_A9B8DD7261DE2FAD();
}

_id_1763A9613C977A65(objectivestruct) {
  level._id_D0ADA23E81337306 = ["a", "b", "c"];
  scripts\engine\utility::flag_wait("cp_hydro_create_script_completed");
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(scripts\cp\equipment\nvg::runnvg);
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "checkpoint_spawner_c", 1);

  foreach(player in level.players) {
    _id_8164F8B29CDABF6A = scripts\engine\utility::getStructArray("laserarray_origin", "script_noteworthy");
    _id_31B87E5786093E10 = scripts\engine\utility::get_array_of_closest(player.origin, _id_8164F8B29CDABF6A, undefined, 24, 2048);

    foreach(laser in _id_31B87E5786093E10)
    laser notify("laser_destroyed");

    player scripts\cp\equipment\nvg::runnvg();
  }
}

_id_0CAFA8983CA48CFD(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isDefined(instance) || !isDefined(instance.type)) {
    return;
  }
  if(instance.type == "cp_veh_cache") {
    instance setscriptablepartstate("body", "opening");
    player _id_66122A002AFF5D57::_id_EE5540242EF172D4();

    foreach(weapon in player.weaponlist) {
      clip_ammo = weaponclipsize(weapon);
      player setweaponammoclip(weapon, clip_ammo);
      player _id_66122A002AFF5D57::_id_4172A10AE7CBDB41(weapon);
    }

    scripts\cp\cp_grenade_crate::refill_grenades(player);
  } else if(instance.type == "brloot_plate_pouch") {
    player _id_66122A002AFF5D57::_id_EE5540242EF172D4();
    player _id_780514F14B1134ED::_id_2D0D93AD3713479C(1);
  }
}

_id_DD334E2C61B2ED30() {
  level._id_B0007705DF77736D = getEntArray("third_person_toggle", "targetname");

  if(getdvarint("dvar_0770339DF7C5B6CA", 0) != 0) {
    scripts\engine\utility::array_call(level._id_B0007705DF77736D, ::delete);
    return;
  }

  foreach(ent in level._id_B0007705DF77736D) {
    ent makeusable();
    ent sethinttag("j_neck");
    ent setCursorHint("HINT_BUTTON");
    ent setHintString(&"COOP_GAME_PLAY/THIRD_PERSON");
    ent sethintdisplayrange(400);
    ent sethintdisplayfov(360);
    ent setusefov(120);
    ent setuserange(64);
    ent sethintonobstruction("hide");
    ent thread _id_6E93CC52776E96E5();
  }
}

_id_6E93CC52776E96E5() {
  self notify("thirdPersonLoop");
  self endon("thirdPersonLoop");
  self endon("death");

  for(;;) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    if(!istrue(player._id_911B640702FEC71A)) {
      player setcamerathirdperson(1);
      player _meth_5762CF97C6F1A2C1("first_person");
      player._id_911B640702FEC71A = 1;
      continue;
    }

    player._id_911B640702FEC71A = undefined;
    player setcamerathirdperson(0);
    player _meth_5762CF97C6F1A2C1("none");
  }
}

_id_F7A95F0080A7221B() {
  level._id_1462DC4EBE91527E = getEntArray("geiger_counter_interaction", "targetname");
  level._id_6801276E72CB11EE = [];

  if(getdvarint("dvar_E45EBE94A1AC60BD", 0) != 0) {
    scripts\engine\utility::array_call(level._id_1462DC4EBE91527E, ::delete);
    return;
  }

  foreach(ent in level._id_1462DC4EBE91527E) {
    ent makeusable();
    ent setHintString(&"COOP_GAME_PLAY/GEIGER_COUNTER_INTERACTION");
    ent setCursorHint("HINT_BUTTON");
    ent sethinticon("hud_icon_equipment_geiger");
    ent sethintdisplayrange(300);
    ent sethintdisplayfov(65);
    ent setusefov(65);
    ent setuserange(65);
    ent sethintonobstruction("hide");
    scriptable = spawnscriptable("brloot_offhand_geigercounter", ent.origin - (0, 0, 1), ent.angles);

    if(isDefined(ent.script_noteworthy) && ent.script_noteworthy == "infil_interactables")
      level._id_6801276E72CB11EE = scripts\engine\utility::array_add(level._id_6801276E72CB11EE, scriptable);

    _id_66122A002AFF5D57::registerscriptableinstance(scriptable);
    ent thread _id_E2D62A38A7CB8C2B();
    ent delete();
  }
}

_id_E2D62A38A7CB8C2B() {
  self notify("geigerCounterUseLoop");
  self endon("geigerCounterUseLoop");
  self endon("death");

  for(;;) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    if(player _id_7EF95BBA57DC4B82::hasequipment("equip_geigercounter")) {
      player playlocalsound("br_pickup_deny");
      continue;
    }

    player playsoundtoplayer("br_pickup_generic", player);
    player thread _id_7EF95BBA57DC4B82::giveequipment("equip_geigercounter", "secondary");
    player _id_7EF95BBA57DC4B82::setequipmentammo("equip_geigercounter", 1);
  }
}

_id_BDDFCADCE5C8FC1E() {
  if(!scripts\engine\utility::flag_exist("player_spawned_with_loadout"))
    scripts\engine\utility::flag_init("player_spawned_with_loadout");

  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  thread _id_7E1A468DA43087E3::_id_30F7459EFB07516F();

  foreach(player in level.players) {
    if(isDefined(player.pers) && istrue(player.pers["restarted"])) {
      _id_467F0FDFDD155A45::_id_936FCCB404737EEF();
      return;
    }
  }
}

_id_4A9CDEB3B22CE2A2(_id_9A7FF62DAB06AE5F) {
  scripts\engine\utility::flag_wait("cleared_to_play_intro_vo");
  _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_ntro_lasw_targetbuildingsarema");
  wait 1.5;
  _id_57A8C25A4A5F3B82();
  wait 1;

  if(scripts\engine\utility::cointoss())
    _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_ntro_lasw_imageryshowedanetwor");
  else if(scripts\engine\utility::cointoss())
    _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_ntro_lasw_trytousetherooftopsa");
  else
    _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_ntro_lasw_theroofsandthatriver");

  if(!istrue(_id_9A7FF62DAB06AE5F))
    scripts\engine\utility::flag_set("laswell_intro_vo_done");
}

_id_07D93773035E730C(_id_F8DD038CB08737AF) {
  level notify("one_player_saw_lz");
  wait 0.5;
}

_id_AF18E039D3A83CB9(_id_3FB1875119D7D640) {
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(_id_3FB1875119D7D640, "stat_62360CDADA95B7C8");
  wait 1;
  _id_CEB1FF9428033CFD = _id_7E1A468DA43087E3::_id_1F35F09BD3F3DC51(_id_3FB1875119D7D640);

  foreach(player in _id_CEB1FF9428033CFD)
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_BCA5E472447F8C73");

  wait 1;

  if(scripts\engine\utility::cointoss()) {
    if(scripts\engine\utility::cointoss())
      _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_ntro_lasw_nicelydone");
    else
      _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_ntro_lasw_tightwindowwaytostic");
  } else
    _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_ntro_lasw_goodjump");
}

_id_4C3B0684A48C38FF(_id_3FB1875119D7D640) {
  while(_func_EAC0CD99C9C6D8EE() == "spotted" || !self isonground() || (istrue(self isinfreefall()) || istrue(self isskydiving()) || istrue(self isparachuting())))
    waitframe();

  _id_ABDFB7B864BC330D = ["a", "b", "c"];

  foreach(objname in _id_ABDFB7B864BC330D) {
    if(istrue(_id_46C9504B591B6E4D(objname)) || _func_8CE5803B7D377D72(_id_3FB1875119D7D640) == 1 || _func_EAC0CD99C9C6D8EE() == "spotted")
      return;
  }

  wait 2;

  if(scripts\engine\utility::cointoss()) {
    if(scripts\engine\utility::cointoss())
      _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_ntro_lasw_talktome12areyoutaki");
    else
      _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_ntro_lasw_whatsyourstatus12hav");
  } else if(scripts\engine\utility::cointoss())
    _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_ntro_lasw_talktome11areyoutaki");
  else
    _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_ntro_lasw_whatsyourstatus11hav");

  wait 2;
  waittime = scripts\cp\cp_player_battlechatter::trysaylocalsound(_id_3FB1875119D7D640, "stat_69EB281E78451991");
  wait(waittime + 1.5);

  if(scripts\engine\utility::cointoss())
    _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_ntro_lasw_letskeepitthatwaysti");
  else
    _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_ntro_lasw_goodrolleasymaintain");
}

_id_4EF93A03C9C03B1E(_id_3FB1875119D7D640) {}

_id_F13E0885BA2B6863() {
  level endon("game_ended");
  level waittill("player_death", victim, deathtype);

  if(!isDefined(deathtype)) {
    return;
  }
  if(deathtype == "deathType_normal" || deathtype == "deathType_worldDeath")
    thread _id_5791C2AD299351D4(victim);
}

_id_5791C2AD299351D4(_id_578A11908815F352) {
  _id_CEB1FF9428033CFD = _id_7E1A468DA43087E3::_id_1F35F09BD3F3DC51(_id_578A11908815F352);

  foreach(player in _id_CEB1FF9428033CFD)
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_C8122B0900BA529D");
}

_id_57A8C25A4A5F3B82() {
  waittime = 1;

  foreach(player in level.players)
  waittime = thread _id_357CDA3CAD047534(player);

  wait(waittime);
}

_id_5D8B346A33EEA49A() {
  foreach(player in level.players)
  thread _id_357CDA3CAD047534(player);

  wait 0.4;

  foreach(player in level.players)
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_BA319E2ACFE6AC4C");
}

_id_357CDA3CAD047534(player) {
  waittime = 1;

  if(scripts\engine\utility::cointoss())
    waittime = level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_BCA5E472447F8C73");
  else if(scripts\engine\utility::cointoss())
    waittime = level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_D40E9C698C76A57F");
  else
    waittime = level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_11FA7946DDF751CD");

  return waittime;
}

_id_0256B4743906AC2F(object, tag) {
  origin = object.origin;

  if(isDefined(tag))
    origin = object gettagorigin(tag);

  if(scripts\cp\utility::player_looking_at(origin, 0.95))
    return 1;

  return 0;
}

_id_752678E865643683(object, tag) {
  origin = object.origin;

  if(isDefined(tag))
    origin = object gettagorigin(tag);

  if(scripts\engine\utility::within_fov(self getEye(), self getplayerangles(), origin, cos(65)))
    return 1;

  return 0;
}

_id_43F97C28DF7F8049(heli) {
  self endon("disconnect");
  self endon("clean_other_threads_viewExfilHeli");
  scripts\engine\utility::flag_wait("exfil_intro_vo_done");

  for(;;) {
    if(_id_752678E865643683(heli, undefined)) {
      _id_CEB1FF9428033CFD = _id_7E1A468DA43087E3::_id_1F35F09BD3F3DC51(self);

      foreach(guy in _id_CEB1FF9428033CFD)
      guy notify("clean_other_threads_viewExfilHeli");

      waittime = level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "stat_0AB3839C038DF043");

      if(isDefined(waittime))
        wait(waittime);

      thread _id_7E1A468DA43087E3::_id_F7A83698420E4D76();
      return;
    }

    waitframe();
  }
}

_id_685806AB85A1384A(object, tag) {
  if(!isDefined(self._id_18FCCDA1BF5C34D1))
    self._id_18FCCDA1BF5C34D1 = gettime();

  if(self._id_18FCCDA1BF5C34D1 <= gettime()) {
    if(_id_0256B4743906AC2F(object, tag)) {
      waittime = undefined;

      if(scripts\engine\utility::cointoss())
        waittime = level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "stat_2A647E3265A23CCA");
      else
        waittime = level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "stat_D0BADE1E795540D0");

      self._id_18FCCDA1BF5C34D1 = self._id_18FCCDA1BF5C34D1 + waittime * 1000 * 2;
    }
  }
}

_id_C99DAEC6F4F98A53(_id_B46496BA73DC641B, _id_CC4B9CFA93202799) {
  if(!isDefined(level._id_7A30C5A0D11223A1))
    level._id_7A30C5A0D11223A1 = [];

  if(istrue(level._id_7A30C5A0D11223A1[_id_B46496BA73DC641B])) {
    return;
  }
  if(scripts\cp\cp_objectives::is_objective_active("exfil_area")) {
    return;
  }
  if(!scripts\engine\utility::flag("cleared_to_play_intro_vo")) {
    return;
  }
  level._id_7A30C5A0D11223A1[_id_B46496BA73DC641B] = 1;
  _id_14169AA1F7C66164 = 0;

  foreach(player in level.players) {
    if(player _id_644C18834356D9DC::has_munition("recon_drone")) {
      _id_14169AA1F7C66164 = 1;
      break;
    }
  }

  if(!istrue(level._id_BFE5BB3BA83502E3)) {
    level._id_DE5C23C3A2FA91CB++;

    if(istrue(_id_14169AA1F7C66164)) {
      switch (level._id_DE5C23C3A2FA91CB) {
        case 1:
          _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_appr_lasw_useyourrecondronetor");
          break;
        case 2:
          _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_appr_lasw_youcanuseyourrecondr");
          break;
        case 3:
          _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_appr_lasw_yourrecondronecanhel");
          break;
      }
    }

    level._id_3F61BFABF1B6F3E4 = 0;
  }

  wait 3;

  if(scripts\cp\cp_objectives::is_objective_active("exfil_area")) {
    return;
  }
  thread _id_22EE11244C00C7CD(_id_B46496BA73DC641B, _id_CC4B9CFA93202799);
}

_id_22EE11244C00C7CD(_id_B46496BA73DC641B, _id_CC4B9CFA93202799) {
  _id_A84F15427A3BE55F = 0;
  _id_E5D8B2684646A4DE = undefined;

  if(isDefined(_id_CC4B9CFA93202799)) {
    _id_6D8E8725698EEFC2 = scripts\engine\utility::get_array_of_closest(_id_CC4B9CFA93202799.origin, level.players, undefined, undefined, 2048);

    if(isDefined(_id_6D8E8725698EEFC2) && _id_6D8E8725698EEFC2.size > 0) {
      foreach(player in _id_6D8E8725698EEFC2) {
        if(_id_CC4B9CFA93202799 scripts\engine\utility::within_fov(player getEye(), player getplayerangles(), _id_CC4B9CFA93202799.origin, cos(65))) {
          _id_A84F15427A3BE55F = 1;
          _id_E5D8B2684646A4DE = player;
          break;
        }
      }

      if(istrue(_id_A84F15427A3BE55F) && isDefined(_id_E5D8B2684646A4DE))
        level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(_id_E5D8B2684646A4DE, "stat_950A284047C4C938");
      else
        level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(scripts\engine\utility::random(level.players), "stat_950A284047C4C938");
    }
  } else
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(scripts\engine\utility::random(level.players), "stat_950A284047C4C938");

  wait 2;

  switch (_id_B46496BA73DC641B) {
    case "stealth_a":
      if(scripts\engine\utility::cointoss()) {
        _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_appr_lasw_copyyoureattheirbarr");
        _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_appr_lasw_ourintelplacesmultip");
      } else if(scripts\engine\utility::cointoss())
        _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_appr_lasw_copyourintelshowsmul");
      else
        _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_appr_lasw_copyisrshowsaskyligh");

      break;
    case "stealth_b":
      if(scripts\engine\utility::cointoss())
        _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_appr_lasw_copythatstheaqcommsc");
      else if(scripts\engine\utility::cointoss())
        _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_appr_lasw_copysurveillanceiden");
      else
        _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_appr_lasw_surveillancereported");

      break;
    case "stealth_c":
      if(scripts\engine\utility::cointoss())
        _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_appr_lasw_copythatstheirarmory");
      else
        _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_appr_lasw_copythatsurveillance");

      break;
    case "exfil_area":
      if(istrue(level._id_0E7E708854355FF7)) {
        return;
      }
      break;
  }

  wait 1;
  _id_57A8C25A4A5F3B82();
  wait 2;
  _id_3D2B347B4893E2BF = level._id_D0ADA23E81337306.size + level._id_324A6E68A953D960;

  if(_id_3D2B347B4893E2BF >= 2)
    _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_fndo_lasw_thisisthelastobjecti");

  scripts\engine\utility::flag_set("laswell_objective_briefing_done");
}

_id_65C017643E8CF5A0() {
  if(!isDefined(level._id_E66ECF6949E1194D))
    level._id_E66ECF6949E1194D = gettime();

  if(level._id_E66ECF6949E1194D > gettime()) {
    return;
  }
  level._id_E66ECF6949E1194D = gettime() + 25000;
  _id_2ADBA961C731BAF6 = randomintrange(1, 6);
  alias = "";

  switch (_id_2ADBA961C731BAF6) {
    case 1:
      alias = "dx_cp_cphy_acst_lasw_11keepthatgeigercoun";
      break;
    case 2:
      alias = "dx_cp_cphy_acst_lasw_12keepthatgeigercoun";
      break;
    case 3:
      alias = "dx_cp_cphy_acst_lasw_keepthatgeigercounte";
      break;
    case 4:
      alias = "dx_cp_cphy_acst_lasw_wedontknowwhattheobj";
      break;
    case 5:
      alias = "dx_cp_cphy_acst_lasw_youneedthatgeigercou";
      break;
  }

  if(alias != "")
    _id_7E1A468DA43087E3::_id_775CD164C569E279(alias);
}

_id_6F2681C879ABB86D() {
  _id_A35FB191F7C5C892 = 0;
  _id_CD02ACFFECC193BE = _id_25F74761A2DF7DEC();
  _id_948DEDD8369D1AF5 = [1, 2, 3, 4];

  for(;;) {
    wait 30;

    if(_id_948DEDD8369D1AF5.size == 0) {
      return;
    }
    if(isDefined(level.dialogue_huds) && level.dialogue_huds.size == 0) {
      continue;
    }
    if(_func_EAC0CD99C9C6D8EE() == "spotted") {
      continue;
    }
    _id_A35FB191F7C5C892 = _id_25F74761A2DF7DEC();

    if(_id_CD02ACFFECC193BE >= _id_A35FB191F7C5C892) {
      continue;
    }
    val = scripts\engine\utility::random(_id_948DEDD8369D1AF5);
    thread _id_F054EEE102FA726C(val);
    _id_948DEDD8369D1AF5 = scripts\engine\utility::array_remove(_id_948DEDD8369D1AF5, val);
    _id_CD02ACFFECC193BE = _id_A35FB191F7C5C892;
  }
}

_id_25F74761A2DF7DEC() {
  _id_A35FB191F7C5C892 = 0;

  foreach(player in level.players) {
    if(isDefined(player.pers["participation"]))
      _id_A35FB191F7C5C892 = _id_A35FB191F7C5C892 + player.pers["participation"];
  }

  return _id_A35FB191F7C5C892;
}

_id_F054EEE102FA726C(_id_DC061F521C45D732) {
  switch (_id_DC061F521C45D732) {
    case 3:
    case 1:
      break;
    case 4:
    case 2:
      break;
  }
}

_id_A9C5227A892717BA() {
  if(!isDefined(level._id_9430E1D31A142131))
    level._id_9430E1D31A142131 = [1, 2, 3];

  if(level._id_9430E1D31A142131.size == 0) {
    return;
  }
  val = scripts\engine\utility::random(level._id_9430E1D31A142131);

  switch (val) {
    case 1:
      _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_guid890b4c0920554277940a1e5fc6e84230");
      break;
    case 2:
      _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_guid25895d410c11413b9dc93a6396f5d8ee");
      break;
    case 3:
      _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_guid9f4a55695ebe467d8520d2bfb77d1f28");
      break;
  }

  level._id_9430E1D31A142131 = scripts\engine\utility::array_remove(level._id_9430E1D31A142131, val);
}

_id_45530849345CAAD8() {
  if(_id_12E2FB553EC1605E::_id_6C2AE2B932A9FD51())
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "stat_280D5C45C1521302");
  else
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "stat_8545DA6DD67C6763");
}

_id_E33986803D2B414B(_id_B46496BA73DC641B, _id_6D8E8725698EEFC2, _id_B205D90302DA2F07) {
  if(istrue(level._id_DA9DB406A115FEC2[_id_B46496BA73DC641B])) {
    return;
  }
  _id_0E54DEB5F403A7A7 = undefined;

  if(isDefined(_id_6D8E8725698EEFC2)) {
    foreach(player in _id_6D8E8725698EEFC2) {
      level._id_E7B157FD6CF95460 = scripts\engine\utility::array_removeundefined(level._id_E7B157FD6CF95460);
      _id_D34CD6F0897A5D61 = scripts\engine\utility::get_array_of_closest(player.origin, level._id_E7B157FD6CF95460, undefined, undefined, 512);

      if(istrue(player._id_8B865BC6FCCF805B) || isDefined(_id_D34CD6F0897A5D61) && _id_D34CD6F0897A5D61.size > 0) {
        _id_0E54DEB5F403A7A7 = 1;
        return;
      }

      player playlocalsound("cp_geiger_hit");
    }
  }

  level._id_DA9DB406A115FEC2[_id_B46496BA73DC641B] = 1;

  if(istrue(_id_0E54DEB5F403A7A7)) {
    return;
  }
  foreach(player in _id_6D8E8725698EEFC2)
  player thread _id_D463F155DA302AF5(_id_B205D90302DA2F07);

  if(!isDefined(level._id_3C9FC717329F3100))
    level._id_3C9FC717329F3100 = [1, 2, 3];

  val = scripts\engine\utility::random(level._id_3C9FC717329F3100);

  switch (val) {
    case 1:
      _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_aclo_lasw_11youregettingahiton");
      break;
    case 2:
      _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_aclo_lasw_12imhearingahitonyou");
      break;
    case 3:
      _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_aclo_lasw_gettingwarmonthatgei");
      break;
  }

  level._id_B42368D46E1FDFDD[_id_B205D90302DA2F07] = gettime() + 25000;
  level._id_3C9FC717329F3100 = scripts\engine\utility::array_remove(level._id_3C9FC717329F3100, val);
}

_id_D463F155DA302AF5(_id_B205D90302DA2F07) {
  player = self;

  if(isDefined(player._id_D8C1657269BA71F8)) {
    if(istrue(player._id_D8C1657269BA71F8[_id_B205D90302DA2F07]))
      return;
  }

  _id_5ED03D43B94F5668 = scripts\engine\utility::getclosest(player.origin, level._id_E7B157FD6CF95460, 1024);

  if(isDefined(_id_5ED03D43B94F5668)) {
    player._id_294EF29A452328DA = 1;
    player sethudtutorialmessage(&"COOP_GAME_PLAY/HINT_GEIGER_COUNTER", 1);
    _id_5ED03D43B94F5668 thread _id_3858411D0B73D352::_id_762EECECFACA8B67(8, player);
    _id_5ED03D43B94F5668 thread _id_3858411D0B73D352::_id_24D6D22DEE70B61D(player);
  }
}

_id_0F0F82FC78960925() {
  wait 15;
  _id_30AB6942C287EEDA = scripts\engine\utility::getStructArray("beacon_fx", "targetname");

  foreach(beacon in _id_30AB6942C287EEDA)
  playFX(level._effect["vfx_ammo_beacon"], beacon.origin);
}

_id_776A6FA5EEEB2228(origin) {
  playFX(level._effect["vfx_laser_destroy"], origin);
  _id_8164F8B29CDABF6A = scripts\engine\utility::getStructArray("laserarray_origin", "script_noteworthy");
  _id_31B87E5786093E10 = scripts\engine\utility::get_array_of_closest(origin, _id_8164F8B29CDABF6A, undefined, 24, 233);

  foreach(laser in _id_31B87E5786093E10)
  laser notify("laser_destroyed");
}

_id_76496243536813FF() {
  if(scripts\engine\utility::flag_exist("cleared_to_play_intro_vo"))
    scripts\engine\utility::flag_wait("cleared_to_play_intro_vo");
  else
    wait 15;

  if(istrue(level._id_E511EC249FBC2FF1)) {
    return;
  }
  spawner = scripts\engine\utility::getStruct("vehicle_patroller_poi_b", "targetname");

  if(!isDefined(spawner)) {
    return;
  }
  spawner._id_79FA6BD3C9BF6A0D = 1;
  thread scripts\cp\cp_spawning_util::_id_94E3A9862B435632(spawner);
  spawner = scripts\engine\utility::getStruct("vehicle_patroller_poi_c", "targetname");

  if(!isDefined(spawner)) {
    return;
  }
  spawner._id_79FA6BD3C9BF6A0D = 1;
  thread scripts\cp\cp_spawning_util::_id_94E3A9862B435632(spawner);
  level._id_E511EC249FBC2FF1 = 1;
}

_id_693C533D6EE0937D() {
  thread _id_7E1A468DA43087E3::_id_17955A30568AFCBF();
  heli = self;
  level._id_2D101818F128EF41 _id_7E1A468DA43087E3::_id_E36D49E7BA544F23([heli], "exfil_land", undefined, 7, 2, 1);
  wait 7;
  iprintln(" Starting the anim now!! ");
}

_id_3A30C8B011AE3527() {
  actor = self;
  actor hudoutlineenable("outline_depth_cyan");
  actor vehphys_forcekeyframedmotion();
  level._id_2D101818F128EF41 scripts\common\anim::anim_single_solo(actor, "exfil_idle");
}

_id_444E69F224AD3406() {
  actor = self;
  actor hudoutlineenable("outline_depth_red");
  actor vehphys_forcekeyframedmotion();
  level._id_2D101818F128EF41 scripts\common\anim::anim_single_solo(actor, "exfil_land");
}

_id_0D0FB3E5EED9DAE9() {
  actor = self;
  actor hudoutlineenable("outline_depth_green");
  actor vehphys_forcekeyframedmotion();
  level._id_2D101818F128EF41 scripts\common\anim::anim_single_solo(actor, "exfil_takeoff");
}

_id_EAE8042E1B821D04() {
  level endon("game_ended");

  while(_func_EAC0CD99C9C6D8EE() == "spotted" || !self isonground() || (istrue(self isinfreefall()) || istrue(self isskydiving()) || istrue(self isparachuting())))
    waitframe();

  waittime = 1.5;

  foreach(guy in level.players) {
    waittime = level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(guy, "stat_7AADF5BCC4BBF699");
    weaponobj = makeweapon("iodine_pills_mp");
    guy thread _id_8D719B752873DF14();
    guy giveandfireoffhand(weaponobj);
  }

  wait(waittime + 3);

  if(scripts\engine\utility::cointoss())
    _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_ntro_lasw_thosepillswillgiveyo");
  else
    _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_ntro_lasw_yourpackislinedwithl");

  scripts\engine\utility::flag_set("iodine_pills_taken");
}

_id_8D719B752873DF14() {
  self playlocalsound("cp_iodine_pills_open");
  wait 1;
  self playlocalsound("cp_iodine_pills_use");
}

_id_D672E33250D61C2D() {
  level notify("clear_dz_point");
  self._id_544210FBCDDBB97B = 1;

  if(scripts\engine\utility::flag("landed_event_vo_triggered")) {
    return;
  }
  scripts\engine\utility::flag_set("landed_event_vo_triggered");

  if(_func_8CE5803B7D377D72(self) == 1 || _func_EAC0CD99C9C6D8EE() == "spotted") {
    _id_37CDF376B91B147C = scripts\cp\coop_stealth::get_player_who_most_recently_fired_weapon();
    _id_F887DC8BAA1FB9C4 = 0;
    _id_BC08E2B32A09AB5A = gettime();

    if(isDefined(_id_37CDF376B91B147C)) {
      _id_BC08E2B32A09AB5A = abs(gettime() - _id_37CDF376B91B147C.last_weapon_fired_time);
      _id_F887DC8BAA1FB9C4 = _id_BC08E2B32A09AB5A <= 4000;
    }

    if(!istrue(_id_F887DC8BAA1FB9C4)) {
      _id_D78A4CA8E4CCA2DE = scripts\engine\utility::getclosest(self.origin, getaiarray("axis"), 1024);

      if(isDefined(_id_D78A4CA8E4CCA2DE)) {
        if(!scripts\engine\utility::time_has_passed(_id_D78A4CA8E4CCA2DE._blackboard._id_060DCAA3D3BE97AB, int(4.0)))
          _id_F887DC8BAA1FB9C4 = 1;
      }
    }

    if(istrue(_id_F887DC8BAA1FB9C4)) {
      if(scripts\engine\utility::cointoss()) {
        _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_ntro_lasw_breakcontactbreakcon");
        wait 1;
        _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_ntro_lasw_disengage");
        wait 1;
        _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_ntro_lasw_breaker1defendyourse");
      } else
        _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_ntro_lasw_breaker1getclearandr");
    } else {}

    scripts\engine\utility::flag_set("laswell_intro_vo_done");
  } else if(distance2dsquared(self.origin, level._id_5E5D0BB4EF6EC41F.origin) <= 4194304) {
    _id_AF18E039D3A83CB9(self);
    _id_4A9CDEB3B22CE2A2();
  } else {
    level._id_E7B157FD6CF95460 = scripts\engine\utility::array_removeundefined(level._id_E7B157FD6CF95460);
    _id_D34CD6F0897A5D61 = scripts\engine\utility::get_array_of_closest(self.origin, level._id_E7B157FD6CF95460, undefined, undefined, 2048);

    if(istrue(self._id_8B865BC6FCCF805B) || isDefined(_id_D34CD6F0897A5D61) && _id_D34CD6F0897A5D61.size > 0) {
      scripts\engine\utility::flag_wait("cleared_to_play_intro_vo");
      scripts\engine\utility::flag_set("laswell_intro_vo_done");
    } else {
      _id_4A9CDEB3B22CE2A2(1);
      _id_4C3B0684A48C38FF(self);
      scripts\engine\utility::flag_set("laswell_intro_vo_done");
    }
  }
}

_id_1C2CC25B48084563() {
  level endon("disconnect");
  level endon("vo_areaSecureThreadCleanup");
  level._id_33C8D2BBE3B2EC00 = undefined;

  for(;;) {
    level waittill("area_cleared", _id_7E352803B2D9BC36, attacker, _id_B8E63723A1B8C7BB);
    _id_777C28A36B45A8D1 = 0;
    objname = "";

    switch (_id_7E352803B2D9BC36) {
      case "ambient_a":
        continue;
      case "ambient_b":
        break;
      case "ambient_c":
        break;
      case "stealth_a":
        objname = "a";
        break;
      case "stealth_b":
        objname = "b";
        break;
      case "stealth_c":
        objname = "c";
        break;
      case "stealth_a_interior":
        objname = "a";
        break;
      case "stealth_b_interior":
        objname = "b";
        break;
      case "stealth_c_interior":
        objname = "c";
        break;
    }

    if(objname == "")
      continue;
    else {
      _id_777C28A36B45A8D1 = _id_46C9504B591B6E4D(objname);
      _id_09AF1E41229DF772 = _id_7E352803B2D9BC36;

      if(_id_7E352803B2D9BC36 == "stealth_a_interior")
        _id_09AF1E41229DF772 = "stealth_a";

      if(_id_7E352803B2D9BC36 == "stealth_b_interior")
        _id_09AF1E41229DF772 = "stealth_b";

      if(_id_7E352803B2D9BC36 == "stealth_c_interior")
        _id_09AF1E41229DF772 = "stealth_c";

      if(isDefined(level._id_A359CB3E2BFA1964[_id_09AF1E41229DF772]) && level._id_A359CB3E2BFA1964[_id_09AF1E41229DF772] > 0)
        _id_777C28A36B45A8D1 = 1;

      if(isDefined(level._id_9EEAB63C54988C55[_id_09AF1E41229DF772]) && level._id_9EEAB63C54988C55[_id_09AF1E41229DF772] > 0)
        _id_777C28A36B45A8D1 = 1;

      if(isDefined(level._id_359C318944444B78[_id_09AF1E41229DF772]) && level._id_359C318944444B78[_id_09AF1E41229DF772] > 0)
        _id_777C28A36B45A8D1 = 1;
    }

    if(!istrue(_id_777C28A36B45A8D1)) {
      alias = "";

      if(isDefined(attacker) && isPlayer(attacker)) {
        while(!_id_7E1A468DA43087E3::_id_73709F2B96C09080(getaiarray("axis"), 1, attacker))
          waitframe();

        level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(attacker, "stat_29C83D721F765AB4", undefined, 0.75);
        _id_CEB1FF9428033CFD = _id_7E1A468DA43087E3::_id_1F35F09BD3F3DC51(attacker);
        wait 2;

        foreach(guy in _id_CEB1FF9428033CFD)
        waittime = guy thread scripts\cp\cp_player_battlechatter::trysaylocalsound(guy, "stat_7CB1A871B292B051", undefined, 0.2);

        wait 2;
      }

      if(!istrue(_id_A3BA3D17613320E9(objname))) {
        if(istrue(_id_B8E63723A1B8C7BB)) {} else if(scripts\engine\utility::cointoss())
          _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_acst_lasw_excellentworknowlets");
        else if(scripts\engine\utility::cointoss())
          _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_acst_lasw_textbookletssecureth");
        else
          _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_acst_lasw_outstandingnowtofind");
      } else {
        if(isDefined(attacker) && isPlayer(attacker)) {
          if(_func_8CE5803B7D377D72(attacker) == 1 || _func_EAC0CD99C9C6D8EE() == "spotted")
            continue;
        }

        waittime = 1;

        if(isPlayer(attacker))
          waittime = level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(attacker, "stat_8545DA6DD67C6763");
      }

      continue;
    }

    if(isDefined(attacker) && isPlayer(attacker)) {
      if(_func_8CE5803B7D377D72(attacker) == 1 || _func_EAC0CD99C9C6D8EE() == "spotted")
        continue;
    }

    if(istrue(level._id_33C8D2BBE3B2EC00))
      continue;
    else
      level._id_33C8D2BBE3B2EC00 = 1;

    waittime = 1;

    if(isPlayer(attacker))
      waittime = level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(attacker, "stat_8545DA6DD67C6763");

    wait(waittime + 1);
    _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_ntro_lasw_dontmakeahabitofthat");
  }
}

_id_46C9504B591B6E4D(objname) {
  if(objname == "a")
    return level._id_B4987EEEBA421B86;

  if(objname == "b")
    return level._id_F6F2A8878CAC1484;

  if(objname == "c")
    return level._id_F9580383F29FDD61;
}

_id_A3BA3D17613320E9(objname) {
  return level._id_BB07CFB91B5A51E8[objname];
}

_id_7E77BB046BD77095() {
  level notify("vo_watchForPlayersLingeringInTheCenter");
  level endon("vo_watchForPlayersLingeringInTheCenter");
  level endon("exfil_triggered");
  waittime = 120;

  for(;;) {
    wait(waittime);

    if(scripts\engine\utility::flag("exfil_triggered")) {
      return;
    }
    if(_func_EAC0CD99C9C6D8EE() == "spotted") {
      waittime = 30;
      continue;
    }

    if(!istrue(level._id_C2D845CA09FB7053)) {
      waittime = 30;
      continue;
    }

    while(istrue(level._id_BFE5BB3BA83502E3))
      wait 0.5;

    pos = scripts\cp\utility\entity::getaverageorigin(level.players);
    level._id_E7B157FD6CF95460 = scripts\engine\utility::array_removeundefined(level._id_E7B157FD6CF95460);
    _id_CC4B9CFA93202799 = scripts\engine\utility::getclosest(pos, level._id_E7B157FD6CF95460, 1024);

    if(isDefined(_id_CC4B9CFA93202799)) {
      _id_6D8E8725698EEFC2 = scripts\engine\utility::get_array_of_closest(_id_CC4B9CFA93202799.origin, level.players, undefined, undefined, 1024);

      if(isDefined(_id_6D8E8725698EEFC2) && _id_6D8E8725698EEFC2.size > 0) {
        if(scripts\engine\utility::cointoss())
          _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_aclo_lasw_whatsgoingondownther");
        else if(scripts\engine\utility::cointoss()) {
          _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_aclo_lasw_12soundslikeyoureget");
          _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_aclo_lasw_useyourgeigercounter");
        } else
          _id_7E1A468DA43087E3::_id_775CD164C569E279("dx_cp_cphy_aclo_lasw_equipyourgeigercount");

        waittime = 30;
        continue;
      }
    }

    _id_2ADBA961C731BAF6 = randomintrange(1, 7);
    alias = "";

    switch (_id_2ADBA961C731BAF6) {
      case 1:
        alias = "dx_cp_cphy_ntro_lasw_11youneedtomove";
        break;
      case 2:
        alias = "dx_cp_cphy_ntro_lasw_12getmoving";
        break;
      case 3:
        alias = "dx_cp_cphy_ntro_lasw_dontgetcomfortabledo";
        break;
      case 4:
        alias = "dx_cp_cphy_ntro_lasw_targetbuildingcoordi";
        break;
      case 5:
        alias = "dx_cp_cphy_ntro_lasw_ifwedontseizethosema";
        break;
      case 6:
        alias = "dx_cp_cphy_ntro_lasw_thecoordinatesaremar";
        break;
    }

    if(alias != "")
      _id_7E1A468DA43087E3::_id_775CD164C569E279(alias);

    waittime = 120;
  }
}

#using_animtree("script_model");

_id_41F1DBEC9B231DA5() {
  level.scr_animtree["nuke"] = #animtree;
  level.scr_anim["nuke"]["nuke_open"] = % cp_prop_nuclear_warhead_open;
  level.scr_animname["nuke"]["nuke_open"] = "cp_prop_nuclear_warhead_open";
}

opennukecrate(crate) {
  crate useanimtree(#animtree);
  crate.animname = "nuke";
  crate thread scripts\common\anim::anim_first_frame_solo(crate, "nuke_open");
}

_id_9361AFAA74964914() {
  scripts\engine\utility::flag_wait("level_ready_for_script");
  weapons = [];
  _id_CDE2EC78F52F00F9 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mike4");
  _id_CDE2EC78F52F00F9 = _id_CDE2EC78F52F00F9 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["holo", "silencer", "laser"]);
  _id_CDE2E978F52EFA60 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("sbeta");
  _id_CDE2E978F52EFA60 = _id_CDE2E978F52EFA60 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["fourx", "tactical", "silencer", "laser"]);
  _id_CDE2EA78F52EFC93 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("scromeo");
  _id_CDE2EF78F52F0792 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("limax");
  _id_CDE2F078F52F09C5 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("akilo");
  _id_CDE2F078F52F09C5 = _id_CDE2F078F52F09C5 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["bar_ar_light", "stock_ar_light", "reddot", "silencer", "laser"]);
  _id_CDE2ED78F52F032C = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("papa220");
  _id_CDE2ED78F52F032C = _id_CDE2ED78F52F032C _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["reddot", "silencer", "laser"]);
  _id_CDE2EE78F52F055F = _id_2669878CF5A1B6BC::buildweapon("iw9_lm_rkilo_mp", scripts\engine\utility::array_combine(_func_6527364C1ECCA6C6("iw9_lm_rkilo_mp"), ["bipod_rkilo", "fourx02"]));
  _id_CDE2EE78F52F055F = _id_CDE2EE78F52F055F _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["reddot", "silencer", "laser"]);
  _id_CDE2F378F52F105E = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("aviktor");
  _id_CDE2F378F52F105E = _id_CDE2F378F52F105E _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["holo", "stock_sm_light", "silencer", "laser"]);
  _id_CDE2F478F52F1291 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("beta");
  _id_CDE2F478F52F1291 = _id_CDE2F478F52F1291 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["holo", "stockno", "silencer", "laser"]);
  _id_F90ED703365EBA0B = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mbravo");
  _id_F90ED603365EB7D8 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mpapa7");
  _id_F90ED603365EB7D8 = _id_F90ED603365EB7D8 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["holo", "stock_sm_heavy", "silencer", "laser"]);
  _id_F90ED903365EBE71 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("akilo105");
  _id_F90ED903365EBE71 = _id_F90ED903365EBE71 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["reddot", "silencer", "laser"]);
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
      _id_28A6B68460F4FD6B _id_9655BF427A5ABDB8(undefined, weapon_object);
      continue;
    }
  }
}

_id_510DCDCBF4FC993C() {
  scripts\engine\utility::flag_wait("level_ready_for_script");
  weapons = [];
  _id_CDE2EC78F52F00F9 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mike4");
  _id_CDE2EC78F52F00F9 = _id_CDE2EC78F52F00F9 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["holo", "silencer", "laser"]);
  _id_CDE2E978F52EFA60 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("sbeta");
  _id_CDE2E978F52EFA60 = _id_CDE2E978F52EFA60 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["fourx", "tactical", "silencer", "laser"]);
  _id_CDE2EA78F52EFC93 = makeweaponfromstring("iw9_dm_scromeo_mp+ammo_65cm+bar_sn_long_p05+arscope_therm01+grip_angled01+mag_sn_p05+pgrip_aim_p05+rec_scromeo+stock_sn_light_p05");
  _id_CDE2EF78F52F0792 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("limax");
  _id_CDE2F078F52F09C5 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("akilo");
  _id_CDE2F078F52F09C5 = _id_CDE2F078F52F09C5 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["bar_ar_light", "stock_ar_light", "reddot", "silencer", "laser"]);
  _id_CDE2ED78F52F032C = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("papa220");
  _id_CDE2ED78F52F032C = _id_CDE2ED78F52F032C _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["reddot", "silencer", "laser"]);
  _id_CDE2EE78F52F055F = _id_2669878CF5A1B6BC::buildweapon("iw9_lm_rkilo_mp", scripts\engine\utility::array_combine(_func_6527364C1ECCA6C6("iw9_lm_rkilo_mp"), ["bipod_rkilo", "fourx02"]));
  _id_CDE2EE78F52F055F = _id_CDE2EE78F52F055F _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["reddot", "silencer", "laser"]);
  _id_CDE2F378F52F105E = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("aviktor");
  _id_CDE2F378F52F105E = _id_CDE2F378F52F105E _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["holo", "mag_sm_large", "stock_sm_light", "silencer", "laser"]);
  _id_CDE2F478F52F1291 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("beta");
  _id_CDE2F478F52F1291 = _id_CDE2F478F52F1291 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["holo", "stockno", "silencer", "laser"]);
  _id_F90ED703365EBA0B = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mbravo");
  _id_F90ED603365EB7D8 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mpapa7");
  _id_F90ED603365EB7D8 = _id_F90ED603365EB7D8 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["holo", "mag_sm_xlarge", "stock_sm_heavy", "silencer", "laser"]);
  _id_F90ED903365EBE71 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("akilo105");
  _id_F90ED903365EBE71 = _id_F90ED903365EBE71 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["reddot", "silencer", "laser"]);
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
      _id_28A6B68460F4FD6B _id_9655BF427A5ABDB8(undefined, weapon_object);
      continue;
    }
  }
}

_id_9655BF427A5ABDB8(sweapon, _id_E6C13F566F945346) {
  if(!isDefined(_id_E6C13F566F945346))
    objweapon = makeweaponfromstring(sweapon);
  else
    objweapon = _id_E6C13F566F945346;

  sweapon = getcompleteweaponname(objweapon);
  _id_B8F5AC23CE0DFDE3 = spawn("weapon_" + sweapon, self.origin, 17);
  _id_B8F5AC23CE0DFDE3.angles = self.angles;
  _id_AEC66C8D309A2AFA = 0;
  _id_5D9B5B689A1846C8 = undefined;
  clipammo = weaponclipsize(objweapon);
  stockammo = weaponstartammo(objweapon);

  if(scripts\cp\cp_relics::is_relic_active("relic_oneInTheChamber")) {
    clipammo = 1;
    stockammo = 0;
  }

  if(istrue(objweapon.hasalternate)) {
    _id_5D9B5B689A1846C8 = objweapon getaltweapon();
    _id_AEC66C8D309A2AFA = weaponclipsize(_id_5D9B5B689A1846C8);
    _id_B8F5AC23CE0DFDE3 itemweaponsetammo(weaponclipsize(objweapon), weaponstartammo(objweapon), weaponclipsize(objweapon), 1);
  } else
    _id_B8F5AC23CE0DFDE3 itemweaponsetammo(weaponclipsize(objweapon), weaponstartammo(objweapon));

  _id_B8F5AC23CE0DFDE3 thread _id_74502A9E0EF1F19C::watchweaponpickup(weaponclipsize(objweapon), weaponstartammo(objweapon));
  return _id_B8F5AC23CE0DFDE3;
}

_id_D612A0B61112564A() {
  self endon("leaving");
  self endon("death");
  level endon("game_ended");
  self endon("kill_sweep_vehicles_thread");
  _id_7346EB0E818B60C5 = scripts\engine\trace::create_vehicle_contents();

  for(;;) {
    vehicles = getentarrayinradius("script_vehicle", "classname", self.origin, getdvarfloat("test_radius", 600));

    if(vehicles.size <= 1) {
      wait 0.5;
      continue;
    }

    _id_B65B7AEAB526E1AC = rotatevector((120, 0, 0), self.angles);
    start = self.origin + _id_B65B7AEAB526E1AC - (0, 0, 290);
    end = self.origin - _id_B65B7AEAB526E1AC - (0, 0, 290);
    hits = physics_spherecast(start, end, 50, _id_7346EB0E818B60C5, [self], "physicsquery_all");

    foreach(hit in hits) {
      ent = hit["entity"];

      if(isDefined(ent) && ent entisalivevehicle() && !istrue(ent._id_DADBA5BB000D27DC)) {
        ent._id_A8F4BB03B366AA80 = 1;
        ent._id_DADBA5BB000D27DC = 1;
        ent scripts\cp_mp\vehicles\vehicle::_id_AB08028468AB68F9();
      }
    }

    wait 0.5;
  }
}

_id_A66D0F06DA3EF875() {
  self endon("leaving");
  self endon("death");
  level endon("game_ended");
  self endon("kill_sweep_vehicles_thread");
  contents = physics_createcontents(["physicscontents_item", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_playerclip", "physicscontents_characterproxy"]);

  for(;;) {
    players = scripts\cp\utility::getplayersinradius(self.origin, getdvarfloat("test_radius", 600));

    if(players.size <= 0) {
      wait 0.5;
      continue;
    }

    _id_B65B7AEAB526E1AC = rotatevector((120, 0, 0), self.angles);
    start = self.origin + _id_B65B7AEAB526E1AC - (0, 0, 290);
    end = self.origin - _id_B65B7AEAB526E1AC - (0, 0, 290);
    hits = physics_spherecast(start, end, 50, contents, [self], "physicsquery_all");

    foreach(hit in hits) {
      ent = hit["entity"];

      if(isDefined(ent) && isPlayer(ent) && ent getstance() == "stand" && !istrue(ent._id_DADBA5BB000D27DC)) {
        ent._id_DADBA5BB000D27DC = 1;
        ent.shouldskipdeathsshield = 1;
        ent dodamage(ent.health + 10000, ent.origin, undefined, undefined, "MOD_CRUSH");
      }
    }

    wait 0.5;
  }
}

entisalivevehicle() {
  return isalive(self) && (scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "script_vehicle");
}
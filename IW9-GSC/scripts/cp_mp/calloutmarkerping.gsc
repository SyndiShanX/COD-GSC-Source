/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\calloutmarkerping.gsc
***********************************************/

calloutmarkerping_initcommon() {
  if(!isDefined(level.brloottablename)) {
    level.brloottablename = getDvar("loot_table_name", "mp/loot/br/default/loot_item_defs.csv");

    if(level.brloottablename == "")
      level.brloottablename = "mp/loot/br/default/loot_item_defs.csv";
  }

  if(!isDefined(level._id_30E5550B80A4D53F))
    _id_32F4D806ACF080D1();

  level thread calloutmarkerpingvo_debouncegarbagecollector();
  setdvarifuninitialized("dvar_28FFDE533F721522", 0);
}

_id_32F4D806ACF080D1() {
  level._id_30E5550B80A4D53F = ["IGNORE_PING", "INVALID", "NAVIGATION", "DANGER", "GSC_OBJECTIVE", "REQUEST", "VEHICLE", "LETHAL", "SUPPLY_BOX", "ENEMY", "GASCAN_ENTITY", "CUAV", "CIVILIAN", "JOIN_ENEMY_TEAM", "JOIN_MY_TEAM", "DROPPED_WEAPON", "QUEST_CIRCLE", "CYBER_REVIVE", "LOOT", "KIOSK", "TABLET", "GASCAN_SCRIPTABLE", "SCRIPTABLE_OBJECTIVE", "DOOR", "OPEN_CACHE", "FULTON", "AMMO_RESTOCK", "SENTRY_TURRET", "RADIAL1", "RADIAL2", "RADIAL3", "RADIAL4", "RADIAL5", "RADIAL6", "RADIAL7", "RADIAL8"];
}

calloutmarkerping_enemytodangerdecaycreate(_id_394466C2DDB208CB, _id_93B12C2DCE7C2AA8) {
  player = self;
  player calloutmarkerping_removecallout(_id_394466C2DDB208CB);
  _id_ED8C23BF6B457573 = getdvarint("dvar_0299D210181A853A", 82);

  if(!isDefined(_id_93B12C2DCE7C2AA8.origin)) {
    return;
  }
  _id_E847BB702009C980 = _id_93B12C2DCE7C2AA8.origin + (0, 0, _id_ED8C23BF6B457573);
  _id_D0AE85B60EC1F5F7 = player calloutmarkerping_create(6, _id_E847BB702009C980, 0);
  player thread _calloutmarkerping_predicted_timeout(_id_D0AE85B60EC1F5F7);
  _calloutmarkerping_predicted_log("Enemy switched to danger");
}

_calloutmarkerping_predicted_log(message) {}

_id_C648F0FD527E089A(_id_A1823E6B1CB4B46D) {
  return _id_A1823E6B1CB4B46D >= 18 && _id_A1823E6B1CB4B46D <= 27;
}

_id_810652BCEC49286C(_id_A1823E6B1CB4B46D) {
  return _id_A1823E6B1CB4B46D == 1;
}

_id_5DACC89A40A58737(_id_A1823E6B1CB4B46D) {
  return _id_A1823E6B1CB4B46D == 9;
}

_id_476D89B12DFE07A1(_id_A1823E6B1CB4B46D) {
  return _id_A1823E6B1CB4B46D == 13 || _id_A1823E6B1CB4B46D == 14;
}

_id_D3789A9A4BE5DF2E(_id_A1823E6B1CB4B46D) {
  return _id_A1823E6B1CB4B46D >= 6 && _id_A1823E6B1CB4B46D <= 17;
}

_id_74EC310D8F99B6E2(_id_A1823E6B1CB4B46D) {
  return _id_A1823E6B1CB4B46D == 3;
}

_id_2A301A38103BD61E(_id_A1823E6B1CB4B46D) {
  return _id_A1823E6B1CB4B46D == 35;
}

_id_666D78F715B8321F(_id_A1823E6B1CB4B46D) {
  return _id_A1823E6B1CB4B46D == 28 || _id_A1823E6B1CB4B46D == 29;
}

_id_87DF78670540E9B2(_id_A1823E6B1CB4B46D) {
  return _id_A1823E6B1CB4B46D >= 28 && _id_A1823E6B1CB4B46D <= 35;
}

_id_D0006D07465A279C(_id_A1823E6B1CB4B46D, scriptable) {
  player = self;
  brgametype = scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508();

  if(_id_A1823E6B1CB4B46D == 20) {
    waittime = getdvarfloat("dvar_817BED798637D38E", 120.0);

    if(brgametype)
      waittime = getdvarfloat("dvar_95248E22B4B46E33", 60.0);
  } else if(_id_C648F0FD527E089A(_id_A1823E6B1CB4B46D)) {
    if(_id_A1823E6B1CB4B46D == 22) {
      waittime = getdvarfloat("dvar_8BD5E52AD7441F43", 120.0);

      if(brgametype)
        waittime = getdvarfloat("dvar_CCE27A6C00A3B750", 0.0);
    } else {
      waittime = getdvarfloat("dvar_4710528047B1660D", 30.0);

      if(brgametype)
        waittime = getdvarfloat("dvar_E6261A609EC4112A", 30.0);
    }

    if(isDefined(scriptable) && isDefined(scriptable.type)) {
      if(scriptable.type == "br_plunder_box" && brgametype)
        waittime = getdvarfloat("dvar_CCE27A6C00A3B750", 0.0);
      else if(scriptable.type == "dmz_supply_drop" || scriptable.type == "dmz_supply_drop_boss" || scriptable.type == "dmz_supply_drop_samsite" || scriptable.type == "dmz_supply_drop_supply")
        waittime = getdvarfloat("dvar_CCE27A6C00A3B750", 0.0);
    }
  } else if(_id_5DACC89A40A58737(_id_A1823E6B1CB4B46D)) {
    waittime = 3.0;

    if(brgametype)
      waittime = 3.0;
  } else if(_id_D3789A9A4BE5DF2E(_id_A1823E6B1CB4B46D)) {
    waittime = getdvarfloat("dvar_F1ED16D72234A0CC", 60.0);

    if(brgametype)
      waittime = getdvarfloat("dvar_BE114E61E75D4839", 120.0);
  } else if(_id_87DF78670540E9B2(_id_A1823E6B1CB4B46D)) {
    waittime = getdvarfloat("dvar_7C74D4814E0665D5", 60.0);

    if(brgametype)
      waittime = getdvarfloat("dvar_9CDD2E8A0A819ED2", 60.0);
  } else {
    switch (_id_A1823E6B1CB4B46D) {
      case 3:
        waittime = getdvarfloat("dvar_ABE00A149EB51FC0", 15.0);

        if(brgametype)
          waittime = getdvarfloat("dvar_5F52828B2CCF6CBD", 15.0);

        break;
      case 16:
      case 2:
        waittime = getdvarfloat("dvar_7C74D4814E0665D5", 60.0);

        if(brgametype)
          waittime = getdvarfloat("dvar_9CDD2E8A0A819ED2", 60.0);

        break;
      case 4:
        waittime = getdvarfloat("dvar_F2B483D963525879", 60.0);

        if(brgametype)
          waittime = getdvarfloat("dvar_CCD1BCD6036C7446", 120.0);

        break;
      case 6:
        waittime = getdvarfloat("dvar_D25A3E0BE5E90C21", 60.0);

        if(brgametype)
          waittime = getdvarfloat("dvar_1B586A47DBF318AE", 120.0);

        break;
      case 5:
        waittime = getdvarfloat("dvar_4DA39A287B93388C", 30.0);

        if(brgametype)
          waittime = getdvarfloat("dvar_5BCEF0D3E309D5F9", 60.0);

        break;
      case 12:
        waittime = getdvarfloat("dvar_DCAB804F9C532B7F", 9.0);

        if(brgametype)
          waittime = getdvarfloat("dvar_CBF3B191A8E466FC", 9.0);

        break;
      default:
        waittime = 2;
    }
  }

  return waittime;
}

_id_76ECF74C7D722B52(_id_A1823E6B1CB4B46D) {
  player = self;

  if(isDefined(player)) {
    for(_id_394466C2DDB208CB = 0; _id_394466C2DDB208CB < 21; _id_394466C2DDB208CB++) {
      if(_id_A1823E6B1CB4B46D == player calloutmarkerping_gettype(_id_394466C2DDB208CB))
        return _id_394466C2DDB208CB;
    }
  }
}

_id_4E740F30357C2C3A(_id_F4CE1797C79492D1) {
  player = self;

  if(isDefined(player)) {
    for(_id_394466C2DDB208CB = 0; _id_394466C2DDB208CB < 21; _id_394466C2DDB208CB++) {
      if(_id_F4CE1797C79492D1 == player _meth_DBEA4C5599DD67DE(_id_394466C2DDB208CB))
        return _id_394466C2DDB208CB;
    }
  }
}

_calloutmarkerping_predicted_timeout(_id_394466C2DDB208CB) {
  player = self;
  _id_A1823E6B1CB4B46D = player calloutmarkerping_gettype(_id_394466C2DDB208CB);
  level endon("game_ended");
  player endon("disconnect");
  player notify("predictiveCalloutClear_" + _id_394466C2DDB208CB);
  player endon("predictiveCalloutClear_" + _id_394466C2DDB208CB);
  waittime = 2;
  _id_93B12C2DCE7C2AA8 = undefined;

  if(_id_D3789A9A4BE5DF2E(_id_A1823E6B1CB4B46D)) {
    ent = player calloutmarkerping_getEnt(_id_394466C2DDB208CB);

    if(isDefined(ent)) {
      _id_19CC31E0FDF2A990 = getdvarint("dvar_C022BD4A1215CD2C", 1);

      if(_id_19CC31E0FDF2A990 && _calloutmarkerping_isenemy(ent, player)) {
        if(isagent(ent))
          waittime = getdvarfloat("dvar_DCAB804F9C532B7F", 9.0);
        else if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
          waittime = getdvarfloat("dvar_DAFD6B4196557939", 0.0);
        else if(isDefined(level.lootleaders) && getDvar("dvar_7611A2790A0BF7FE", "") == "kingslayer" && scripts\engine\utility::array_contains(level.lootleaders, ent))
          waittime = getdvarfloat("dvar_736F9D37695743D5", 0.0);
        else
          waittime = getdvarfloat("dvar_EAC22ABE7A18C2D3", 3.0);

        _id_93B12C2DCE7C2AA8 = ent;
        _calloutmarkerping_predicted_log("Enemy tracked!");
      }

      if(_id_A1823E6B1CB4B46D == 6)
        player thread calloutmarkerping_removevehiclecalloutonspecialconditions(_id_394466C2DDB208CB, ent);

      player thread _id_632CC7F8CBF11AE1(_id_394466C2DDB208CB, ent);
    }
  } else if(_id_C648F0FD527E089A(_id_A1823E6B1CB4B46D)) {
    _id_D9D7F39E028CEE38 = player calloutmarkerping_getEnt(_id_394466C2DDB208CB);
    player thread calloutmarkerping_watchscriptabledeath(_id_394466C2DDB208CB, _id_D9D7F39E028CEE38);
  } else if(_id_A1823E6B1CB4B46D == 2) {
    if(getdvarint("dvar_0A20128C96EE00A7", 0))
      player thread calloutmarkerping_navigationcancelproximity(_id_394466C2DDB208CB);
  } else if(_id_A1823E6B1CB4B46D == 4) {
    _id_93BC7962739FD49E = self calloutmarkerping_getgscobjectiveindex(_id_394466C2DDB208CB);

    if(_id_93BC7962739FD49E == -1)
      calloutmarkerping_removecallout(_id_394466C2DDB208CB);
    else {
      player thread calloutmarkerping_watchwhenobjectivestartsprogress(_id_394466C2DDB208CB, _id_93BC7962739FD49E);
      player thread calloutmarkerping_watchwhenobjectivedeleted(_id_394466C2DDB208CB, _id_93BC7962739FD49E);
    }
  } else if(_id_A1823E6B1CB4B46D == 5)
    player thread calloutmarkerping_watchplayerdeathordisconnect(_id_394466C2DDB208CB);

  if(!isDefined(_id_93B12C2DCE7C2AA8)) {
    _id_D9D7F39E028CEE38 = player calloutmarkerping_getEnt(_id_394466C2DDB208CB);
    waittime = player _id_D0006D07465A279C(_id_A1823E6B1CB4B46D, _id_D9D7F39E028CEE38);

    if(waittime == 0)
      return;
  }

  _calloutmarkerping_predicted_log("Timeout value before wait: " + waittime + " | pingIndex: " + _id_394466C2DDB208CB + " Type: " + _id_A1823E6B1CB4B46D);
  wait(waittime);

  if(isDefined(_id_93B12C2DCE7C2AA8) && isDefined(player) && isalive(_id_93B12C2DCE7C2AA8) && _id_A1823E6B1CB4B46D == 9)
    player thread calloutmarkerping_enemytodangerdecaycreate(_id_394466C2DDB208CB, _id_93B12C2DCE7C2AA8);
  else {
    _calloutmarkerping_predicted_log("Ping timed out: " + _id_394466C2DDB208CB + " Type: " + _id_A1823E6B1CB4B46D);
    player calloutmarkerping_removecallout(_id_394466C2DDB208CB);
  }
}

_calloutmarkerping_predicted_isanypingactive() {
  player = self;

  for(_id_394466C2DDB208CB = 0; _id_394466C2DDB208CB < 21; _id_394466C2DDB208CB++) {
    if(player calloutmarkerping_getactive(_id_394466C2DDB208CB))
      return 1;
  }

  return 0;
}

_calloutmarkerping_predicted_listenfornotifies() {
  _id_93A0836A10E99C34 = self;
  level endon("game_ended");
  _id_93A0836A10E99C34 endon("disconnect");

  for(;;) {
    _id_93A0836A10E99C34 waittill("luinotifyserver", _id_EA3E3B2121E6713A, _id_394466C2DDB208CB, _id_60FDFB1CFD734D00);

    if(!isDefined(_id_EA3E3B2121E6713A) || !isDefined(_id_394466C2DDB208CB)) {
      continue;
    }
    _calloutmarkerping_predicted_log("Notification " + _id_EA3E3B2121E6713A + " for ping " + _id_394466C2DDB208CB);

    switch (_id_EA3E3B2121E6713A) {
      case "calloutmarkerping_added":
        _id_93A0836A10E99C34 _calloutmarkerping_handleluinotify_added(_id_394466C2DDB208CB);
        break;
      case "calloutmarkerping_cleared":
        _id_93A0836A10E99C34 _calloutmarkerping_handleluinotify_cleared(_id_394466C2DDB208CB);
        break;
      case "calloutmarkerping_acknowledged":
        _id_93A0836A10E99C34 _calloutmarkerping_handleluinotify_acknowledged(_id_394466C2DDB208CB, _id_60FDFB1CFD734D00);
        break;
      case "calloutmarkerping_acknowledged_cancel":
        _id_93A0836A10E99C34 _calloutmarkerping_handleluinotify_acknowledgedcancel(_id_394466C2DDB208CB, _id_60FDFB1CFD734D00);
        break;
      case "calloutmarkerping_enemy_repinged":
        _id_93A0836A10E99C34 _calloutmarkerping_handleluinotify_enemyrepinged(_id_394466C2DDB208CB);
        break;
      case "map_ping_delete_marker":
        _id_93A0836A10E99C34 _calloutmarkerping_handleluinotify_mappingdeletemarker();
        break;
      case "loot_ping_request":
        _id_93A0836A10E99C34 _id_BDDCF3549133ED79(_id_394466C2DDB208CB);
        break;
      case "request_assim":
        _id_F9A23942C0CD9461(_id_93A0836A10E99C34, _id_394466C2DDB208CB);
        break;
      case "confirm_assim_request":
        if([[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "isWaitingForAssimResponse")]](_id_93A0836A10E99C34))
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "resolveAssimRequest")]](_id_93A0836A10E99C34, _id_394466C2DDB208CB);

        break;
      default:
        break;
    }
  }
}

_id_C1A654559682AEA3(_id_394466C2DDB208CB) {
  _id_93A0836A10E99C34 = self;
  _id_394466C2DDB208CB = _id_93A0836A10E99C34 _meth_8AA0A62972A0035E();
  _id_A1823E6B1CB4B46D = _id_93A0836A10E99C34 calloutmarkerping_gettype(_id_394466C2DDB208CB);
  _id_6AF180049459B405 = level._id_30E5550B80A4D53F[_id_A1823E6B1CB4B46D];
  _id_93A0836A10E99C34 dlog_recordplayerevent("dlog_event_tactical_map_ping", ["pinged_item_name", _id_6AF180049459B405, "zoom_level", _id_93A0836A10E99C34._id_82FB4DC4CA3061FD]);
}

_id_663C4DB94F4E1C60() {
  _id_93A0836A10E99C34 = self;
  level endon("game_ended");
  _id_93A0836A10E99C34 endon("disconnect");

  for(;;) {
    _id_93A0836A10E99C34 waittill("luinotifyserver", _id_EA3E3B2121E6713A, _id_D8E598524DB9ED22);

    if(!isDefined(_id_EA3E3B2121E6713A)) {
      continue;
    }
    if(_id_EA3E3B2121E6713A == "map_ping_add_marker")
      _id_93A0836A10E99C34._id_82FB4DC4CA3061FD = _id_D8E598524DB9ED22;
  }
}

calloutmarkerping_initplayer() {
  player = self;

  if(!isDefined(player.calloutmarkerpingvohandlerpool))
    player.calloutmarkerpingvohandlerpool = [];

  if(!isDefined(player._id_03A9AAF3E5A5C0B5))
    player._id_03A9AAF3E5A5C0B5 = [];

  player thread _calloutmarkerping_predicted_listenfornotifies();
  player thread _id_663C4DB94F4E1C60();
}

_calloutmarkerping_scriptableisusable(_id_DB376EE90688810D) {
  if(!isDefined(_id_DB376EE90688810D))
    return 0;

  return _id_DB376EE90688810D _meth_6954A8D7BA8CD9FB();
}

_id_CB9269A1545AD6E4(ent) {
  if(isDefined(ent._id_0566868292EE2A1B))
    ent = ent._id_0566868292EE2A1B;

  if(!isDefined(ent))
    return 0;

  if(!isDefined(ent._id_47BDE44B1ACEC603))
    return 0;

  if(ent._id_47BDE44B1ACEC603 == "")
    return 0;

  return 1;
}

_calloutmarkerping_isenemy(ent, player) {
  if(!isDefined(ent))
    return 0;

  if(!isPlayer(ent) && !isagent(ent))
    return 0;

  if(!isDefined(ent.team))
    return 0;

  if(ent.team == "neutral" || ent.team == "civilian")
    return 0;

  return ent.team != player.team;
}

_calloutmarkerping_isplunderextract(ent) {
  if(!isDefined(ent))
    return 0;

  if(!isent(ent))
    return issubstr(ent.type, "brloot_plunder_extraction") || issubstr(ent.type, "equip_fulton_mp");

  if(!isDefined(ent.model))
    return 0;

  return ent.model == "military_skyhook_far";
}

_calloutmarkerping_isdropcrate(ent) {
  if(!isDefined(ent))
    return 0;

  if(!isent(ent))
    return 0;

  if(!isDefined(ent.cratetype))
    return 0;

  if(istrue(ent._id_28EB33FFD1AA3E63))
    return 1;

  return ent.cratetype == "killstreak" || ent.cratetype == "juggernaut" || ent.cratetype == "manual_turret";
}

calloutmarkerping_ismunitionsbox(ent) {
  return isDefined(ent.equipmentref) && ent.equipmentref == "equip_munitionsbox";
}

_id_E6DEC83247484340(ent) {
  return isDefined(ent.equipmentref) && ent.equipmentref == "equip_hauntedbox";
}

_id_0AB2631F444DB868(ent) {
  return isDefined(ent.equipmentref) && ent.equipmentref == "equip_trophy";
}

_id_23C0A0BD88667B79(ent) {
  return isDefined(ent.equipmentref) && ent.equipmentref == "sound_veil_mp";
}

_id_FABA04054D6E029A(ent) {
  return isDefined(ent.equipmentref) && ent.equipmentref == "sonar_pulse_mp";
}

_id_3F392603242529BA(ent) {
  return isDefined(ent.equipmentref) && ent.equipmentref == "equip_deployed_decoy";
}

_id_032BFB4F432F417F(ent) {
  return isDefined(ent.streakinfo) && isDefined(ent.streakinfo.airdroptype);
}

_id_A1B34A5B82E7A92E(ent) {
  return isDefined(ent.classname) && scripts\engine\utility::string_starts_with(ent.classname, "weapon");
}

_calloutmarkerping_iskiosk(ent) {
  if(!isDefined(ent))
    return 0;

  if(!ent getscriptableisloot())
    return 0;

  if(ent.type != "br_plunder_box")
    return 0;

  return 1;
}

_id_ABFF9F14E6D75A76(ent) {
  if(isagent(ent))
    return 0;

  if(!isDefined(ent))
    return 0;

  if(!isent(ent))
    return 0;

  return issubstr(ent.classname, "grenade") || issubstr(ent.classname, "c4_") || issubstr(ent.classname, "proximity_explosive_") || issubstr(ent.classname, "claymore_");
}

calloutmarkerping_canplayerping(player, _id_F1C1336C7BBE5FE0) {
  if(player _meth_8420670EAFC8D391() || player isspectatingplayer())
    return 0;

  if(!isalive(player))
    return 0;

  if(istrue(player.mapmarkermodeenabled) && !isDefined(_id_F1C1336C7BBE5FE0))
    return 0;

  if(player scripts\cp_mp\utility\player_utility::isusingremote())
    return 0;

  return 1;
}

_id_3087D1219984F7F1(lootid) {
  _id_39F686831584C7E6 = getscriptbundle("enum_1FA1138FA9606D79");
  _id_0D5B0D5D2B48F0F5 = _id_39F686831584C7E6._id_EF8FE4F81B324297.size;

  for(_id_9846FEDA68A7EDED = 0; _id_9846FEDA68A7EDED < _id_0D5B0D5D2B48F0F5; _id_9846FEDA68A7EDED++) {
    _id_DB96936D84EC563B = "calloutmarkerpingitem:" + _id_39F686831584C7E6._id_EF8FE4F81B324297[_id_9846FEDA68A7EDED]._id_9A914262B416FD8A;
    _id_9A914262B416FD8A = getscriptbundle(_id_DB96936D84EC563B);

    if(_id_9A914262B416FD8A.lootid == lootid && isDefined(_id_9A914262B416FD8A._id_C4E1D2EE105CFD3B))
      return _id_9A914262B416FD8A._id_C4E1D2EE105CFD3B;
  }

  logprint("CalloutMarkerPing: Could not get request VO for loot ID " + lootid);
  return undefined;
}

_id_442948452E540D3E(lootid) {
  _id_D3EB0030DE8DF73E = _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(lootid);

  if(_id_D3EB0030DE8DF73E == "calloutmarkerpingitem")
    return _id_3087D1219984F7F1(lootid);
  else {
    if(isDefined(level.brloottablename)) {
      _id_44044F276471D2BB = tablelookuprownum(level.brloottablename, 5, lootid);

      if(_id_44044F276471D2BB >= 0) {
        _id_30E078555972E3B8 = tablelookupbyrow(level.brloottablename, _id_44044F276471D2BB, 29);

        if(isDefined(_id_30E078555972E3B8) && _id_30E078555972E3B8 != "")
          return _id_30E078555972E3B8;
        else if(_id_D3EB0030DE8DF73E == "weapon") {
          weaponname = tablelookupbyrow(level.brloottablename, _id_44044F276471D2BB, 1);
          return _id_8D17E607A79FD65F(weaponname);
        }
      }
    }

    return "stat_9DFFC2E6FE1C2F36";
  }
}

_id_D1C8C0F877165808(lootid) {
  _id_92FCE7B1696254E3 = tablelookup(level.brloottablename, 5, lootid, 8);
  _id_CCE9361200C5117C = _id_2669878CF5A1B6BC::_id_0C9AF9FE37668DF2(_id_92FCE7B1696254E3);

  if(isDefined(_id_CCE9361200C5117C)) {
    switch (_id_CCE9361200C5117C) {
      case "ar":
        return "stat_6441432D931347CD";
      case "sm":
        return "stat_11EFAF925E9C7E43";
      case "lm":
        return "stat_C62B1C92C4397E9A";
      case "sh":
        return "stat_C2A31B765DC5EABC";
      case "sn":
        return "stat_226BF222DC8C769D";
      case "dm":
        return "stat_81EEB1929DDFC2A9";
      case "pi":
        return "stat_156D3011CE7F63E5";
      case "la":
        return "stat_06BC99A3B53F92BA";
      case "me":
        if(issubstr(_id_92FCE7B1696254E3, "riotshield"))
          return "stat_D89B5D4E0FFAA25D";
        else
          return "stat_CB9999BD61CCF0EE";
      default:
        logprint("CalloutMarkerPing: Could not get request VO for loot ID " + lootid);
        return undefined;
    }
  } else {
    logprint("CalloutMarkerPing: Could not get request VO for loot ID " + lootid);
    return undefined;
  }
}

_id_F4293E5A97E51D76(lootid) {
  _id_D3EB0030DE8DF73E = _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(lootid);

  if(_id_D3EB0030DE8DF73E == "calloutmarkerpingitem")
    return _id_3087D1219984F7F1(lootid);
  else {
    _id_2C50B12FEE8841C9 = tablelookup(level.brloottablename, 5, lootid, 2);

    switch (_id_2C50B12FEE8841C9) {
      case "weapon":
        return _id_D1C8C0F877165808(lootid);
      case "lethal":
        return "stat_9E388E6ACE07D134";
      case "tactical":
        return "stat_527F18A9A3DC8433";
      case "revive":
        return "stat_F943577880CA24E0";
      case "plunder":
        return "stat_7C03E32AB0A4310E";
      case "killstreak":
        return "stat_5982A0B9BD7A5629";
      case "super":
        return "stat_04990DD9059FD943";
      case "key":
        return "stat_F3FB4B644E42AFF8";
      case "keycard":
        return "stat_C67D85EBDF3423D6";
      case "dogtag":
        return "stat_B49586FDF063238B";
      case "valuable":
        return "stat_80947D079E88DB1B";
      default:
        scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);

        switch (scriptablename) {
          case "brloot_armor_plate":
            return "stat_8F0DA2F929B5E678";
          case "brloot_ammo_919":
            return "stat_9FD48685F78DCCE5";
          case "brloot_ammo_762":
            return "stat_139B0BD39823AD92";
          case "brloot_ammo_50cal":
            return "stat_7655B388C76711C4";
          case "brloot_ammo_12g":
            return "stat_6BDAD0211B2B864E";
          case "brloot_ammo_rocket":
            return "stat_6DB132798DDBF954";
          case "brloot_equip_gasmask_scuba":
          case "brloot_equip_gasmask_durable":
          case "brloot_equip_gasmask":
            return "stat_B3E904AA1E989D76";
          default:
            logprint("CalloutMarkerPing: Could not get request VO for loot ID " + lootid);
            return undefined;
        }
    }
  }
}

_id_B9E51DCDDB9DF228(lootid) {
  _id_D3EB0030DE8DF73E = _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(lootid);

  if(_id_D3EB0030DE8DF73E == "calloutmarkerpingitem")
    return _id_3087D1219984F7F1(lootid);
  else {
    _id_2C50B12FEE8841C9 = tablelookup(level.brloottablename, 5, lootid, 2);

    switch (_id_2C50B12FEE8841C9) {
      case "plunder":
        return "stat_AD67C90BD02E70B4";
      default:
        scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);

        switch (scriptablename) {
          case "brloot_ammo_919":
            return "stat_DFBADA2220A5A84A";
          case "brloot_ammo_762":
            return "stat_A4A8C0A0A1357B15";
          case "brloot_ammo_50cal":
            return "stat_31535F4A432B583D";
          case "brloot_ammo_12g":
            return "stat_B876B92D2E364260";
          case "brloot_ammo_rocket":
            return "stat_B2152EDF398F29D7";
          default:
            return _id_F4293E5A97E51D76(lootid);
        }
    }
  }
}

_id_2F7AC61EE301EA30(_id_BB224CEE75D433A2, lootid) {
  switch (_id_BB224CEE75D433A2) {
    case 22:
      return _id_B9E51DCDDB9DF228(lootid);
    case 23:
      return _id_F4293E5A97E51D76(lootid);
    case 25:
    case 24:
    case 17:
      return _id_442948452E540D3E(lootid);
    default:
      return undefined;
  }
}

_id_1E8231AEE9E6076B(_id_41A4A181B6606B16) {
  player = self;
  _id_70B1F16774D513D5 = undefined;

  switch (_id_41A4A181B6606B16) {
    case 23:
    case 22:
      _id_70B1F16774D513D5 = spawnStruct();
      _id_70B1F16774D513D5.object = player;
      _id_70B1F16774D513D5.index = player getentitynumber();
      _id_70B1F16774D513D5.origin = (0, 0, 0);
      break;
    case 17:
      _id_70B1F16774D513D5 = spawnStruct();
      _id_70B1F16774D513D5.object = player.br_kiosk;
      _id_70B1F16774D513D5.index = player.br_kiosk.index;
      _id_70B1F16774D513D5.origin = player.br_kiosk.origin;
      break;
    case 25:
    case 24:
      if(!isDefined(player._id_02FA5B49969DEF47)) {
        break;
      }

      _id_70B1F16774D513D5 = spawnStruct();
      _id_70B1F16774D513D5.object = player._id_02FA5B49969DEF47;
      _id_70B1F16774D513D5.index = player._id_02FA5B49969DEF47.index;
      _id_70B1F16774D513D5.origin = player._id_02FA5B49969DEF47.origin;
      break;
    case 2:
    case 0:
      break;
    default:
      break;
  }

  return _id_70B1F16774D513D5;
}

_id_22A98596C2F7F9EF(object, player) {
  _id_DA07265F8351BD9E = player _meth_368AF07F7897FD79(5);

  if(_id_DA07265F8351BD9E) {
    _id_394466C2DDB208CB = player _id_76ECF74C7D722B52(5);
    _id_E14FF7E54E23B1BA = player calloutmarkerping_getEnt(_id_394466C2DDB208CB);

    if(object == _id_E14FF7E54E23B1BA)
      return 1;
  }

  return 0;
}

_id_6A4A22B07CD4A96F(object, team) {
  _id_7273312620004BC3 = level.teamdata[team]["players"];

  foreach(_id_80EF668C09FFB70F in _id_7273312620004BC3) {
    if(_id_22A98596C2F7F9EF(object, _id_80EF668C09FFB70F))
      return 1;
  }

  return 0;
}

_id_FAA3CBEC7243FE72() {
  player = self;
  _id_26F4287F15A26580 = player.br_kiosk;
  _id_2A4CA7D150630600 = player._id_02FA5B49969DEF47;

  if(isDefined(_id_26F4287F15A26580) && _id_6A4A22B07CD4A96F(_id_26F4287F15A26580, player.team)) {
    player setclientomnvar("ui_show_lootid_item_pings", 1);
    return;
  }

  if(isDefined(_id_2A4CA7D150630600) && _id_6A4A22B07CD4A96F(_id_2A4CA7D150630600, player.team)) {
    player setclientomnvar("ui_show_lootid_item_pings", 1);
    return;
  }

  player setclientomnvar("ui_show_lootid_item_pings", 0);
}

_id_6C9B8F9429B7FDCA(team) {
  _id_7273312620004BC3 = level.teamdata[team]["players"];

  foreach(_id_80EF668C09FFB70F in _id_7273312620004BC3)
  _id_80EF668C09FFB70F _id_FAA3CBEC7243FE72();
}

_id_A3CB3FA19D3D1D11(_id_E14FF7E54E23B1BA, _id_41A4A181B6606B16, _id_93E35211AE22777A) {
  player = self;
  _id_DA07265F8351BD9E = player _meth_368AF07F7897FD79(5);

  if(_id_DA07265F8351BD9E) {
    _id_4D0DD5009AED72DE = player _id_76ECF74C7D722B52(5);
    _id_010DD7119141CC69 = player calloutmarkerping_getEnt(_id_4D0DD5009AED72DE);
    _id_BBB883CEE81E54CB = player _meth_0A7E757D42B550A6(_id_4D0DD5009AED72DE);
    _id_645600FDEAF0AFF1 = player _meth_C4E0716FBD549E2D(_id_4D0DD5009AED72DE);
    _id_77030A9BCA370BBA = _id_41A4A181B6606B16 == 22 || _id_41A4A181B6606B16 == 23;
    _id_69C13EEEC400A0F0 = getdvarint("dvar_B2C4034E4C2ED9E7", 0);

    if(!_id_77030A9BCA370BBA || _id_69C13EEEC400A0F0)
      player calloutmarkerping_removecallout(_id_4D0DD5009AED72DE);

    _id_F19D25CE7FCF3460 = _id_E14FF7E54E23B1BA == _id_010DD7119141CC69 && _id_41A4A181B6606B16 == _id_BBB883CEE81E54CB && _id_93E35211AE22777A == _id_645600FDEAF0AFF1;
    _id_B54143D3EFE5F0A9 = getdvarint("dvar_B2C4034E4C2ED9E7", 0);

    if(_id_F19D25CE7FCF3460 && (!_id_77030A9BCA370BBA || _id_B54143D3EFE5F0A9)) {
      player calloutmarkerping_playteamsoundfx("uin_ping_cancel", _id_4D0DD5009AED72DE);
      return 1;
    }
  }

  return 0;
}

_id_1CED737A22161A49(_id_41A4A181B6606B16, lootid) {
  player = self;

  if(!calloutmarkerping_canplayerping(player)) {
    return;
  }
  _id_6B10A57D86C5874A = player _id_1E8231AEE9E6076B(_id_41A4A181B6606B16);

  if(isDefined(_id_6B10A57D86C5874A)) {
    if(_id_A3CB3FA19D3D1D11(_id_6B10A57D86C5874A.object, _id_41A4A181B6606B16, lootid))
      _id_6C9B8F9429B7FDCA(player.team);
    else {
      _id_394466C2DDB208CB = player calloutmarkerping_create(_id_41A4A181B6606B16, _id_6B10A57D86C5874A.origin, _id_6B10A57D86C5874A.index, lootid);
      player thread _calloutmarkerping_predicted_timeout(_id_394466C2DDB208CB);
      player thread _id_6B813A30256C8BC7(_id_41A4A181B6606B16, lootid);
      _id_6C9B8F9429B7FDCA(player.team);
      player calloutmarkerping_playteamsoundfx("uin_ping_item", _id_394466C2DDB208CB);
    }
  }
}

_id_6B813A30256C8BC7(_id_41A4A181B6606B16, lootid) {
  player = self;
  wait(getdvarfloat("dvar_355F123C0BFF2170", 0.5));
  _id_5AB0DC648937D4EA = _id_2F7AC61EE301EA30(_id_41A4A181B6606B16, lootid);

  if(isDefined(_id_5AB0DC648937D4EA) && isDefined(player)) {
    _id_394466C2DDB208CB = player _meth_368AF07F7897FD79(5);

    if(isDefined(_id_394466C2DDB208CB))
      player calloutmarkerpingvo_play(_id_5AB0DC648937D4EA, _id_394466C2DDB208CB);
  }
}

_calloutmarkerping_checkforbuybackrequest(_id_394466C2DDB208CB) {
  player = self;

  if(isalive(player)) {
    return;
  }
  _id_A1823E6B1CB4B46D = player calloutmarkerping_gettype(_id_394466C2DDB208CB);

  if(!_id_C648F0FD527E089A(_id_A1823E6B1CB4B46D)) {
    return;
  }
  instance = player calloutmarkerping_getEnt(_id_394466C2DDB208CB);

  if(!_calloutmarkerping_iskiosk(instance)) {
    return;
  }
  player notify("buybackRequested");
}

_id_2ECDD6EB53BBD808(_id_A1823E6B1CB4B46D, _id_394466C2DDB208CB) {
  player = self;

  if(_id_87DF78670540E9B2(_id_A1823E6B1CB4B46D)) {
    _id_7A183AE28B9C66F5 = player _meth_0A7E757D42B550A6(_id_394466C2DDB208CB);
    return player _meth_31F315111C6A03C2(_id_7A183AE28B9C66F5);
  } else
    return undefined;
}

calloutmarkerpingvo_createcalloutbattlechatter(_id_394466C2DDB208CB) {
  if(!isDefined(_id_394466C2DDB208CB)) {
    return;
  }
  player = self;
  _id_C1074AB6CAC2169F = player calloutmarkerping_getEnt(_id_394466C2DDB208CB);
  _id_3EF0FDCEE94CADFF = undefined;
  _id_A1823E6B1CB4B46D = player calloutmarkerping_gettype(_id_394466C2DDB208CB);

  if(_id_810652BCEC49286C(_id_A1823E6B1CB4B46D)) {
    return;
  }
  if(_id_C648F0FD527E089A(_id_A1823E6B1CB4B46D)) {
    _id_3EF0FDCEE94CADFF = player _id_F9AA0F44521459D7(_id_394466C2DDB208CB, _id_C1074AB6CAC2169F);

    if(!isDefined(_id_3EF0FDCEE94CADFF))
      return;
  } else if(_id_A1823E6B1CB4B46D == 22)
    _id_3EF0FDCEE94CADFF = player calloutmarkerpingvo_getcalloutaliasstringworld(_id_394466C2DDB208CB);
  else if(_id_D3789A9A4BE5DF2E(_id_A1823E6B1CB4B46D) && (_id_A1823E6B1CB4B46D != 6 || _id_CB9269A1545AD6E4(_id_C1074AB6CAC2169F)) && _id_A1823E6B1CB4B46D != 17)
    _id_3EF0FDCEE94CADFF = player calloutmarkerpingvo_getcalloutaliasstringentity(_id_C1074AB6CAC2169F);
  else if(_id_74EC310D8F99B6E2(_id_A1823E6B1CB4B46D))
    _id_3EF0FDCEE94CADFF = "stat_E3B4682201D84039";
  else if(_id_87DF78670540E9B2(_id_A1823E6B1CB4B46D))
    _id_3EF0FDCEE94CADFF = _id_2ECDD6EB53BBD808(_id_A1823E6B1CB4B46D, _id_394466C2DDB208CB);
  else {
    switch (_id_A1823E6B1CB4B46D) {
      case 17:
      case 16:
      case 2:
        if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && isDefined(player.br_infil_type))
          _id_3EF0FDCEE94CADFF = "stat_92DDD951EC0801D5";
        else
          _id_3EF0FDCEE94CADFF = "stat_950A284047C4C938";

        break;
      case 6:
        _id_3EF0FDCEE94CADFF = player calloutmarkerpingvo_getcalloutaliasstringvehicle(_id_C1074AB6CAC2169F);

        if(isDefined(_id_3EF0FDCEE94CADFF) && _id_3EF0FDCEE94CADFF == "invalid_ufo") {
          return;
        }
        break;
      case 4:
        _id_3EF0FDCEE94CADFF = player calloutmarkerpingvo_getcalloutaliasstringworld(_id_394466C2DDB208CB);
        break;
      default:
        break;
    }
  }

  player calloutmarkerpingvo_play(_id_3EF0FDCEE94CADFF, _id_394466C2DDB208CB, undefined, _id_C1074AB6CAC2169F);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vo", "onPing"))
    player[[scripts\cp_mp\utility\script_utility::getsharedfunc("vo", "onPing")]](_id_394466C2DDB208CB, _id_A1823E6B1CB4B46D, _id_3EF0FDCEE94CADFF, _id_C1074AB6CAC2169F);
}

_calloutmarkerping_onpingchallenge(_id_394466C2DDB208CB) {
  player = self;
  _id_A1823E6B1CB4B46D = player calloutmarkerping_gettype(_id_394466C2DDB208CB);
  player scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("pmc_missions", "onPing", _id_394466C2DDB208CB, _id_A1823E6B1CB4B46D);

  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "onPing")) {
    return;
  }
  if(_id_C648F0FD527E089A(_id_A1823E6B1CB4B46D))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onPing")]]("object");
  else if(_id_D3789A9A4BE5DF2E(_id_A1823E6B1CB4B46D)) {
    ent = self calloutmarkerping_getEnt(_id_394466C2DDB208CB);

    if(isDefined(ent)) {
      if(_calloutmarkerping_isenemy(ent, self)) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onPing")]]("enemy");
        return;
      }

      if(!isPlayer(ent)) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onPing")]]("object");
        return;
      }

      return;
      return;
    }
  } else if(_id_74EC310D8F99B6E2(_id_A1823E6B1CB4B46D))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onPing")]]("danger");
  else {
    switch (_id_A1823E6B1CB4B46D) {
      case 6:
      case 5:
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onPing")]]("object");
        break;
      case 4:
      case 2:
        break;
    }
  }
}

calloutmarkerpingvo_getcalloutaliasstringentity(_id_07A5B847EA66815F) {
  _id_27E49251BB3376EA = self;

  if(isDefined(_id_07A5B847EA66815F) && isent(_id_07A5B847EA66815F))
    ent = _id_07A5B847EA66815F;
  else
    return "";

  isfriendly = scripts\engine\utility::is_equal(ent.team, _id_27E49251BB3376EA.team);

  if(isPlayer(ent) && isfriendly)
    return "stat_BA35331E5424E961";
  else if(isDefined(ent.juggcontext) || istrue(ent.isjuggernaut)) {
    if(!_id_6641A5B759148E1B()) {
      if(isfriendly)
        return "stat_F9D0187FEE631069";
      else
        return "stat_8EF3DF121EB09344";
    } else if(isDefined(ent._id_9329E0D3CE1D5CA8))
      return "stat_B1184FFADD1841E1";
    else
      return "stat_C280C66C7D0377BE";
  } else if(isDefined(ent.streakname)) {
    _id_EC1C995BEC9DF0D0 = _id_0E57C4849C7935DA(ent, _id_27E49251BB3376EA);

    if(isDefined(_id_EC1C995BEC9DF0D0))
      return _id_EC1C995BEC9DF0D0;
  } else if(calloutmarkerping_ismunitionsbox(ent) || _id_E6DEC83247484340(ent)) {
    if(isfriendly)
      return "stat_BEED927AD14272F6";
    else
      return "stat_9D85348FE7F7FD17";
  } else if(_id_0AB2631F444DB868(ent)) {
    if(isfriendly)
      return "stat_87DFB0A97D487905";
    else
      return "stat_2791DF8F0FEBAA08";
  } else if(_id_23C0A0BD88667B79(ent)) {
    if(isfriendly)
      return "stat_E2FD444152D125A6";
    else
      return "stat_422E7DACAF02E067";
  } else if(_id_FABA04054D6E029A(ent)) {
    if(isfriendly)
      return "stat_1A192C08A51AA187";
    else
      return "stat_9FEE601F6A38D0AE";
  } else if(_id_3F392603242529BA(ent)) {
    if(isfriendly)
      return "stat_50318DAB695E2D91";
    else
      return "stat_FBAA88946C97859C";
  } else if(_id_032BFB4F432F417F(ent)) {
    airdroptype = ent.streakinfo.airdroptype;

    switch (airdroptype) {
      case "airdrop_multiple":
      case "airdrop":
        airdroptype = "carepackage";
        break;
      case "juggernaut":
        airdroptype = "juggernaut_box";
        break;
      case "loadout_drop":
        airdroptype = "loadoutdrop";
        break;
    }

    _id_A1823E6B1CB4B46D = "killstreak";

    if(airdroptype == "loadoutdrop")
      _id_A1823E6B1CB4B46D = "fieldupgrade";

    _id_9D38FF79B3A86204 = undefined;

    if(level.teambased) {
      if(isDefined(ent.team) && self.team != ent.team)
        _id_9D38FF79B3A86204 = "hostile";
    } else if(isDefined(ent.owner) && self != ent.owner)
      _id_9D38FF79B3A86204 = "hostile";

    _id_51134E8308C78A49 = "ping_" + _id_A1823E6B1CB4B46D + "_" + airdroptype;

    if(isDefined(_id_9D38FF79B3A86204))
      _id_51134E8308C78A49 = _id_51134E8308C78A49 + "_" + _id_9D38FF79B3A86204;

    return _func_1823FF50BB28148D(_id_51134E8308C78A49);
  } else if(_id_A1B34A5B82E7A92E(ent)) {
    if(istrue(ent.iscustomweapon))
      return "stat_61E45880333EA885";

    weaponname = strtok(ent.classname, "+")[0];
    return _id_8D17E607A79FD65F(weaponname);
  } else if(isDefined(ent.equipmentref) && ent.equipmentref == "equip_armorbox") {
    if(isfriendly)
      return "stat_EEB2F76AA07B1207";
    else
      return "stat_DBAED258B9AC512E";
  } else if(isDefined(ent.cratetype) && ent.cratetype == "loadout_drop_cp")
    return "stat_AAF81E97912A54F4";
  else if(_id_ABFF9F14E6D75A76(ent)) {
    if(istrue(ent._id_C5ED7E1AF63FB508))
      return "stat_2791DF8F0FEBAA08";

    _id_DEC9BCCE93873125 = "stat_51A14B1BF8223917";
    _id_49E6EF3EDADD524E = _func_F581838CE4328F7A(ent.weapon_object);
    _id_C7FAED30FB7D597C = "";

    if(_id_7EF95BBA57DC4B82::isequipmentlethal(_id_49E6EF3EDADD524E))
      _id_C7FAED30FB7D597C = "lethal_generic";
    else if(_id_7EF95BBA57DC4B82::isequipmenttactical(_id_49E6EF3EDADD524E))
      _id_C7FAED30FB7D597C = "tactical_generic";

    switch (_id_49E6EF3EDADD524E) {
      case "bunkerbuster":
        _id_C7FAED30FB7D597C = "buster";
        break;
      case "c4":
        _id_C7FAED30FB7D597C = "c4";
        break;
      case "claymore":
        _id_C7FAED30FB7D597C = "claymore";
        break;
      case "decoy_grenade":
        _id_C7FAED30FB7D597C = "decoy";
        break;
      case "gas_grenade":
        _id_C7FAED30FB7D597C = "gas";
        break;
      case "at_mine":
        _id_C7FAED30FB7D597C = "proxmine";
        break;
      case "shock_stick":
        _id_C7FAED30FB7D597C = "shockstick";
        break;
      case "thermite":
        _id_C7FAED30FB7D597C = "thermite";
        break;
      case "smoke_grenade":
        _id_C7FAED30FB7D597C = "smoke";
        break;
      case "flare":
        if(isfriendly)
          return "stat_511D39B9A1EE9CC8";
        else
          return "stat_5E910C8FE775BABD";
    }

    if(isfriendly)
      return _func_2EF675C13CA1C4AF(_id_DEC9BCCE93873125, _id_C7FAED30FB7D597C);
    else
      return _func_2EF675C13CA1C4AF(_id_DEC9BCCE93873125, _id_C7FAED30FB7D597C, "_hostile");
  } else if(_calloutmarkerping_isplunderextract(ent))
    return "stat_C370A434325EEFAE";
  else if(ent.model == "military_ammo_restock_location" || ent.model == "military_ammo_restock_location_solid")
    return "stat_DFC8971B3A3D7A81";
  else if(ent.model == "military_armor_station_01_open_full")
    return "stat_EEB2F76AA07B1207";
  else if(issubstr(ent.model, "offhand_wm_container_gas_tank"))
    return "stat_489F4C169E5ADB27";
  else if(issubstr(ent.model, "train_"))
    return "stat_950A284047C4C938";
  else if(issubstr(ent.model, "cuniform"))
    return "stat_4F145E816E953CB9";
  else if(_id_6641A5B759148E1B() && isDefined(ent._id_1C9CB43BCF3EB16D) && ent._id_1C9CB43BCF3EB16D == "elimTarget")
    return "stat_BC91EBC8EF1FBFA4";
  else if(_id_6641A5B759148E1B() && istrue(ent._id_950C1AB89C9C4E2A))
    return "stat_63D201BEC507D7CF";
  else if(_id_6641A5B759148E1B() && _id_CB9269A1545AD6E4(ent)) {
    if(isDefined(ent._id_0566868292EE2A1B))
      ent = ent._id_0566868292EE2A1B;

    if(ent._id_47BDE44B1ACEC603 == "chemist")
      return "stat_16063B12E7E0E407";
    else if(ent._id_47BDE44B1ACEC603 == "pyro")
      return "stat_966C59C3D2889590";
    else if(ent._id_47BDE44B1ACEC603 == "trapper")
      return "stat_9B6B7DA0814A3DD7";

    return "stat_B1184FFADD1841E1";
  } else if(_calloutmarkerping_isenemy(ent, self)) {
    _id_BADBB95AF1209ECF = ent getcurrentweapon();

    if(isPlayer(ent)) {
      if(istrue(ent.inlaststand))
        return "stat_5063297C85D5385E";
      else if(!scripts\cp_mp\utility\player_utility::isreallyalive(ent))
        return "stat_7F659E0D3CE8B202";
    }

    if(scripts\cp_mp\utility\weapon_utility::isriotshield(_id_BADBB95AF1209ECF))
      return "stat_D55968F5896ED400";
    else if(isweapon(_id_BADBB95AF1209ECF) && !isnullweapon(_id_BADBB95AF1209ECF) && weaponclass(_id_BADBB95AF1209ECF) == "sniper")
      return "stat_56FBAECE3612BDF8";
    else if(isDefined(ent.basearchetype) && ent.basearchetype == "rusher")
      return "stat_526F96D183A4EE53";

    if(_id_6641A5B759148E1B() && isDefined(level._id_0D7B3BD9AD64C74B) && isDefined(level._id_0D7B3BD9AD64C74B[ent getentitynumber()]) && isDefined(level._id_0D7B3BD9AD64C74B[ent getentitynumber()]["tier"])) {
      tier = level._id_0D7B3BD9AD64C74B[ent getentitynumber()]["tier"];
      _id_3B28A86AF95D6CEA = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(ent, "elite");

      switch (tier) {
        case 1:
          return scripts\engine\utility::ter_op(istrue(_id_3B28A86AF95D6CEA), "stat_766AD1C8B387E329", "stat_6D3407B8A9E701D6");
        case 2:
          return scripts\engine\utility::ter_op(istrue(_id_3B28A86AF95D6CEA), "stat_7667B1C8B38576F2", "stat_6D3406B8A9E70023");
        case 3:
          return scripts\engine\utility::ter_op(istrue(_id_3B28A86AF95D6CEA), "stat_7663CDC8B381BDAF", "stat_6D3405B8A9E6FE70");
        default:
          return "stat_C280C66C7D0377BE";
      }
    }
  } else if(issubstr(ent.model, "mortar"))
    return "stat_3EB64C04862D60EE";
  else if(issubstr(ent.model, "oxygen"))
    return "stat_43C6735EF7FE8279";
  else if(issubstr(ent.model, "turret"))
    return "stat_2FC2274289B135CF";
  else if(issubstr(ent.model, "gas_cutter"))
    return "stat_836741B5A9A3BAD5";

  return "stat_C280C66C7D0377BE";
}

_id_F9AA0F44521459D7(_id_394466C2DDB208CB, _id_C1074AB6CAC2169F) {
  player = self;
  _id_3EF0FDCEE94CADFF = "";
  _id_DB376EE90688810D = undefined;
  _id_9DA49B7A0E592D6D = 0;
  _id_8B819C2AF4C98EAD = 0;
  _id_3D5823CC55965DD7 = 0;
  isusable = 0;

  if(isDefined(_id_C1074AB6CAC2169F))
    _id_DB376EE90688810D = _id_C1074AB6CAC2169F;
  else
    return undefined;

  if(isDefined(_id_DB376EE90688810D)) {
    _id_9DA49B7A0E592D6D = _id_DB376EE90688810D scriptableisdoor();

    if(_id_9DA49B7A0E592D6D)
      _id_8B819C2AF4C98EAD = _id_DB376EE90688810D scriptabledoorisclosed();
    else
      _id_3D5823CC55965DD7 = _id_DB376EE90688810D scriptableislootcache();
  }

  if(_id_3D5823CC55965DD7) {
    if(_id_DB376EE90688810D getscriptablehaspart("body") && _id_DB376EE90688810D getscriptablepartstate("body") != "fully_opening_unusable")
      _id_3EF0FDCEE94CADFF = player calloutmarkerpingvo_getcalloutaliasstringloot(_id_394466C2DDB208CB, _id_DB376EE90688810D);
    else if(isDefined(_id_DB376EE90688810D._id_46A3A8565AC0C17C) && (_id_DB376EE90688810D._id_46A3A8565AC0C17C == 15 || _id_DB376EE90688810D._id_46A3A8565AC0C17C == 13) || isDefined(_id_DB376EE90688810D.type) && issubstr(_id_DB376EE90688810D.type, "dmz_supply_drop"))
      _id_3EF0FDCEE94CADFF = player calloutmarkerpingvo_getcalloutaliasstringloot(_id_394466C2DDB208CB, _id_DB376EE90688810D);
  } else if(_id_9DA49B7A0E592D6D && !_id_8B819C2AF4C98EAD)
    _id_3EF0FDCEE94CADFF = "stat_395D52D740AEE345";
  else if(_id_9DA49B7A0E592D6D)
    return undefined;
  else if(isDefined(_id_DB376EE90688810D.customweaponname) && _id_DB376EE90688810D.customweaponname != "")
    _id_3EF0FDCEE94CADFF = "stat_61E45880333EA885";
  else if(isDefined(_id_DB376EE90688810D) && isDefined(_id_DB376EE90688810D.entity)) {
    if(_calloutmarkerping_isdropcrate(_id_DB376EE90688810D.entity)) {
      if(_id_DB376EE90688810D.entity.cratetype == "battle_royale_cash_crate")
        _id_3EF0FDCEE94CADFF = "stat_377EABE3259D7176";
      else if(!isDefined(_id_DB376EE90688810D.entity.team) || _id_DB376EE90688810D.entity.team == player.team)
        _id_3EF0FDCEE94CADFF = "stat_AAF81E97912A54F4";
      else
        _id_3EF0FDCEE94CADFF = "stat_DF79177AD830A4E1";
    } else if(istrue(_id_DB376EE90688810D.entity.isjuggernaut)) {
      if(!isDefined(_id_DB376EE90688810D.entity.team) || _id_DB376EE90688810D.entity.team == player.team)
        _id_3EF0FDCEE94CADFF = "stat_96902B2A9D7757FF";
      else
        _id_3EF0FDCEE94CADFF = "stat_719A5222C33FB876";
    } else if(_calloutmarkerping_isplunderextract(_id_C1074AB6CAC2169F) || isDefined(_id_C1074AB6CAC2169F.type) && _id_C1074AB6CAC2169F.type == "dmz_exfil_site")
      _id_3EF0FDCEE94CADFF = "stat_C78FBE4067075AFD";
    else if(isDefined(_id_DB376EE90688810D.entity.model) && (_id_DB376EE90688810D.entity.model == "military_ammo_restock_location" || _id_DB376EE90688810D.entity.model == "military_ammo_restock_location_solid"))
      _id_3EF0FDCEE94CADFF = "stat_DFC8971B3A3D7A81";
    else if(isDefined(_id_DB376EE90688810D.model) && (_id_DB376EE90688810D.model == "veh9_mil_air_drone_redeploy_relocate" || _id_DB376EE90688810D.model == "veh9_mil_air_drone_redeploy_relocate_hack"))
      _id_3EF0FDCEE94CADFF = "stat_B2E52B074F412495";
    else if(isDefined(_id_DB376EE90688810D.entity.vehiclename) && _id_DB376EE90688810D.entity.vehiclename == "cargo_train")
      _id_3EF0FDCEE94CADFF = "stat_4F581684012440EC";
    else if(isDefined(_id_DB376EE90688810D.entity._id_08862825A0618BDA) && _id_DB376EE90688810D.entity._id_08862825A0618BDA == "tacCam") {
      if(_id_DB376EE90688810D.entity.team == player.team)
        _id_3EF0FDCEE94CADFF = "stat_F9F87D4203F5CDEE";
      else
        _id_3EF0FDCEE94CADFF = "stat_059B1FBFABD1D2BF";
    } else if(isDefined(_id_DB376EE90688810D.type) && _id_DB376EE90688810D.type == "veh9_mil_air_cargo_plane_airdrop_dmz")
      _id_3EF0FDCEE94CADFF = "stat_4F581684012440EC";
    else
      _id_3EF0FDCEE94CADFF = "stat_950A284047C4C938";
  } else if(isDefined(_id_C1074AB6CAC2169F.type) && (_id_C1074AB6CAC2169F.type == "dmz_gas_station" || _id_C1074AB6CAC2169F.type == "dmz_gas_station_marine"))
    return undefined;
  else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pickups", "isDogTag") && isDefined(_id_DB376EE90688810D.type) && [[scripts\cp_mp\utility\script_utility::getsharedfunc("pickups", "isDogTag")]](_id_DB376EE90688810D.type)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("dogtag", "getDogTagVictimAndKiller")) {
      _id_E9A68E6D68D81012 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("dogtag", "getDogTagVictimAndKiller")]](_id_DB376EE90688810D.count)[0];

      if(isDefined(level._id_B287C5D31BEE8267) && isDefined(level._id_B287C5D31BEE8267[_id_E9A68E6D68D81012]) && isDefined(level._id_B287C5D31BEE8267[_id_E9A68E6D68D81012].team) && self.team == level._id_B287C5D31BEE8267[_id_E9A68E6D68D81012].team)
        _id_3EF0FDCEE94CADFF = "stat_97E406A910AACD64";
      else
        _id_3EF0FDCEE94CADFF = player calloutmarkerpingvo_getcalloutaliasstringloot(_id_394466C2DDB208CB, _id_C1074AB6CAC2169F);
    } else
      _id_3EF0FDCEE94CADFF = player calloutmarkerpingvo_getcalloutaliasstringloot(_id_394466C2DDB208CB, _id_C1074AB6CAC2169F);
  } else if(isDefined(_id_DB376EE90688810D) && isDefined(_id_DB376EE90688810D.type) && _id_DB376EE90688810D.type == "portal_object")
    _id_3EF0FDCEE94CADFF = "stat_ABCAD83420C34C7D";
  else if(isDefined(_id_DB376EE90688810D) && isDefined(_id_DB376EE90688810D.type) && _id_DB376EE90688810D.type == "map2map_tacmap_location_scriptable")
    _id_3EF0FDCEE94CADFF = "stat_950A284047C4C938";
  else
    _id_3EF0FDCEE94CADFF = player calloutmarkerpingvo_getcalloutaliasstringloot(_id_394466C2DDB208CB, _id_C1074AB6CAC2169F);

  return _id_3EF0FDCEE94CADFF;
}

calloutmarkerpingvo_getcalloutaliasstringvehicle(_id_07A5B847EA66815F) {
  player = self;

  if(isDefined(_id_07A5B847EA66815F) && isent(_id_07A5B847EA66815F))
    _id_F5013BAE6266622F = _id_07A5B847EA66815F;
  else
    return "";

  if(istrue(_id_F5013BAE6266622F._id_4924D9899B8D3124) || istrue(_id_F5013BAE6266622F._id_47F322B0E1BD7A7C))
    return "invalid_ufo";

  if(isDefined(_id_F5013BAE6266622F.streakname)) {
    _id_EC1C995BEC9DF0D0 = _id_0E57C4849C7935DA(_id_F5013BAE6266622F, player);

    if(isDefined(_id_EC1C995BEC9DF0D0))
      return _id_EC1C995BEC9DF0D0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("ping", "ping_cp_getCPVehicleCallout")) {
    result = [[scripts\cp_mp\utility\script_utility::getsharedfunc("ping", "ping_cp_getCPVehicleCallout")]](_id_F5013BAE6266622F);

    if(isDefined(result) && istrue(result.bshouldreturnvalue))
      return result.vocalloutstring;
  }

  if(isDefined(_id_F5013BAE6266622F.infil) && isDefined(level._id_C96464F39952B78A)) {
    vehiclename = [[level._id_C96464F39952B78A]](_id_F5013BAE6266622F);
    return _func_2EF675C13CA1C4AF("stat_F2FFB8C48B7BA213", vehiclename, "_neutral");
  }

  if(!isDefined(_id_F5013BAE6266622F.vehiclename))
    return "stat_DBE73992C2A084D2";

  _id_7731ADEF63E19B0C = _id_F5013BAE6266622F scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();
  _id_EE8EF5BA92AB121D = undefined;
  _id_5011B777ABE6B90E = undefined;

  if(isDefined(_id_7731ADEF63E19B0C))
    _id_5011B777ABE6B90E = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle(_id_7731ADEF63E19B0C);

  if(isDefined(_id_5011B777ABE6B90E))
    _id_EE8EF5BA92AB121D = _id_5011B777ABE6B90E._id_EE8EF5BA92AB121D;

  if(!isDefined(_id_EE8EF5BA92AB121D) || _id_EE8EF5BA92AB121D == "")
    _id_EE8EF5BA92AB121D = "generic";

  if(_id_F5013BAE6266622F scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_isburningdown())
    return _func_2EF675C13CA1C4AF("stat_09216F9FDF0E7CCD", _id_EE8EF5BA92AB121D);

  if(istrue(_id_F5013BAE6266622F scripts\cp_mp\vehicles\vehicle::_id_B7148A3BFC4DEFB2()))
    return _func_2EF675C13CA1C4AF("stat_3CDAF22EA7689E07", _id_EE8EF5BA92AB121D);

  if(_id_6641A5B759148E1B() && isDefined(_id_7731ADEF63E19B0C)) {
    if(_id_7731ADEF63E19B0C == "veh9_palfa")
      return "stat_0AB3839C038DF043";
    else if(_id_7731ADEF63E19B0C == "veh9_blima")
      return "stat_50E215208A82D207";
  }

  _id_044502C6387EC229 = _calloutmarkerping_isvehicleoccupiedbyenemy(_id_F5013BAE6266622F, player.team) || isDefined(_id_7731ADEF63E19B0C) && _id_7731ADEF63E19B0C == "dmz_boss_chopper";

  if(istrue(_id_044502C6387EC229))
    return _func_2EF675C13CA1C4AF("stat_F2FFB8C48B7BA213", _id_EE8EF5BA92AB121D, "_hostile");
  else
    return _func_2EF675C13CA1C4AF("stat_F2FFB8C48B7BA213", _id_EE8EF5BA92AB121D, "_neutral");
}

_id_0E57C4849C7935DA(ent, player) {
  if(!isDefined(ent) || !isDefined(ent.streakname))
    return undefined;

  switch (ent.streakname) {
    case "gunship":
      if(ent.team == player.team)
        return "stat_59408556A75167B3";
      else
        return "stat_7966E41DE8CB58E2";
    case "chopper_gunner":
      if(ent.team == player.team)
        return "stat_FC944993A946B947";
      else
        return "stat_6F281585CF73646E";
    case "cruise_predator":
      if(ent.team == player.team)
        return "stat_D9C435BE4F34EDD2";
      else
        return "stat_13C1846B179FBBBB";
    case "auto_drone":
      if(ent.team == player.team)
        return "stat_7114A9557A202484";
      else
        return "stat_E456FA711248FA51";
    case "chopper_support":
    case "airdrop_escort":
      if(ent.team == player.team)
        return "stat_BE6F026064897FCC";
      else
        return "stat_406AF2DF399AE929";
    case "pac_sentry":
      if(ent.team == player.team)
        return "stat_360F10C75FF6DDFC";
      else
        return "stat_4D95DA7E5634EDB9";
    case "airdrop_multiple":
      if(ent.team == player.team)
        return "stat_E351B2FE727BE6CF";
      else
        return "stat_AB3AAFAFEC352426";
    case "airdrop":
    case "bradley":
    case "juggernaut":
      if(ent.team == player.team)
        return "stat_9D7B23B318712100";
      else
        return "stat_5CF853DA13E8C3E5";
    case "sentry_gun":
      if(ent.team == player.team)
        return "stat_AD2379A582FC4DA4";
      else
        return "stat_1BEC31AF9B0E7F31";
    case "hover_jet":
      if(ent.team == player.team)
        return "stat_8FC0E5069411C5F0";
      else
        return "stat_E8E93CDA7053AB35";
    case "napalm_strike":
    case "white_phosphorus":
    case "toma_strike":
    case "precision_airstrike":
    case "fuel_airstrike":
      if(ent.team == player.team)
        return "stat_CDEA6DB76FFAFEAB";
      else
        return "stat_6905E10CB42D87AA";
    case "directional_uav":
      if(ent.team == player.team)
        return "stat_307D8AD9D54E300A";
      else
        return "stat_36B6C6096F34A903";
    case "uav_bigmap":
    case "uav":
      if(ent.team == player.team)
        return "stat_CBC2104AB33F85DB";
      else
        return "stat_DCF31D1198C3587A";
    case "counter_uav":
    case "scrambler_drone_guard":
      if(ent.team == player.team)
        return "stat_4F145E816E953CB9";
      else
        return "stat_34238A0A2D34BFF4";
    case "cluster_spike":
      if(ent.team == player.team)
        return "stat_8CA459B6A15C00B2";
      else
        return "stat_D4713AC3C37A175B";
    case "assault_drone":
      if(ent.team == player.team)
        return "stat_A57F8806E4B78AE1";
      else
        return "stat_51236CFF45BC900C";
    case "radar_drone_recon":
      if(ent.team == player.team)
        return "stat_6805124B5ACC8EB0";
      else
        return "stat_08F7ADF3133703F5";
    default:
  }

  return undefined;
}

calloutmarkerpingvo_getcalloutaliasstringworld(_id_394466C2DDB208CB) {
  player = self;

  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    return "stat_950A284047C4C938";

  _id_6D7CFF43E352D995 = player calloutmarkerping_getgscobjectiveindex(_id_394466C2DDB208CB);

  if(isDefined(level.questinfo) && isDefined(level.questinfo.quests) && isDefined(level.questinfo.quests["vip"]) && isDefined(level.questinfo.quests["vip"].instances)) {
    foreach(_id_FABF84450735DD93, _id_A8899121A97B2449 in level.questinfo.quests["vip"].instances) {
      _id_C00E9479F3C48B03 = _id_A8899121A97B2449.objectiveiconid;

      if(!isDefined(_id_C00E9479F3C48B03)) {
        continue;
      }
      if(_id_C00E9479F3C48B03 == _id_6D7CFF43E352D995)
        return "stat_C280C66C7D0377BE";
    }
  }

  if(isDefined(level._id_DBBD13CC9AD757C1) && isDefined(level._id_DBBD13CC9AD757C1._id_807FFB67240349F5)) {
    foreach(_id_3170CA906B2241A6 in level._id_DBBD13CC9AD757C1._id_807FFB67240349F5) {
      if(!isDefined(_id_3170CA906B2241A6.objid) || _id_3170CA906B2241A6.objid != _id_6D7CFF43E352D995) {
        continue;
      }
      return "stat_819B611AC5CCD652";
    }
  }

  _id_2D618A34E27D5476 = undefined;

  if(player _meth_929EE540AD474F2F("ui_br_objective_index"))
    _id_2D618A34E27D5476 = player getclientomnvar("ui_br_objective_index");

  if(!isDefined(_id_2D618A34E27D5476) || _id_2D618A34E27D5476 == 0)
    return "stat_950A284047C4C938";

  _id_B92F1CF567538EEE = tablelookup("mp/brmissions.csv", 0, _id_2D618A34E27D5476, 1);
  _id_1070D193895B35B4 = tablelookup("mp/brmissions.csv", 0, _id_2D618A34E27D5476, 18);
  _id_962B7EF0A10E1038 = "stat_F2A9FF4E59BB1F21";

  if(isDefined(_id_1070D193895B35B4) && _id_1070D193895B35B4 != "") {
    switch (_id_1070D193895B35B4) {
      case "blueprintextract":
      case "assassination":
      case "smokinggun":
        return "stat_F576F46190038D0F";
      case "x1stash":
        return "stat_E28085AADFAE5D1C";
      case "x1fin":
      case "history":
        return "stat_E28085AADFAE5D1C";
      case "scavenger":
        return "stat_52858A3F5DE1854C";
      case "timedrun":
        return "stat_39C77413B23B120F";
      case "vip":
        return "stat_1DACCAFD917E11F4";
      case "intel":
        return "stat_6D1373895A7152E3";
      case "safecracker":
        return _id_962B7EF0A10E1038;
      case "dom":
        if(isDefined(_id_B92F1CF567538EEE) && _id_B92F1CF567538EEE == "dmz_domination")
          return "stat_3BBA1ED64A43B055";
        else
          return "stat_66CC0EF5625F2905";
      case "elim":
        return "stat_A2509D6E12C5AF05";
      case "search":
      case "trap":
        return "stat_DF615C25AF2DAF17";
      case "hostage":
        if(_id_2D618A34E27D5476 == 46)
          return "stat_63D201BEC507D7CF";
        else
          return "stat_2C71ED5D278CA7AA";
      case "geiger":
        return "stat_D09EB4ECD4F2077F";
      case "hunt":
        return "stat_BC91EBC8EF1FBFA4";
      case "boatdrive":
      case "vehicledrive":
        return "stat_EFB7D5D607796B80";
      case "demo":
        return "stat_950A284047C4C938";
      default:
        return "genericContractAlias";
    }
  }

  return "stat_950A284047C4C938";
}

_id_D7FB39F0E6E8F752(scriptablename) {
  if(isDefined(level.br_pickups._id_11FEB85E78E7CEE8))
    _id_CB89110314447B2F = tablelookuprownum_reversefromrow(level.brloottablename, 1, scriptablename, level.br_pickups._id_11FEB85E78E7CEE8 - 1);
  else
    _id_CB89110314447B2F = tablelookuprownum(level.brloottablename, 1, scriptablename);

  return _id_CB89110314447B2F;
}

calloutmarkerpingvo_getcalloutaliasstringloot(_id_394466C2DDB208CB, _id_394382528911801D) {
  player = self;

  if(isDefined(_id_394382528911801D) && isDefined(_id_394382528911801D.type)) {
    _id_869D699197F920A2 = _id_394382528911801D.type;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("loot", "lootGetScriptableName"))
      _id_869D699197F920A2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("loot", "lootGetScriptableName")]](_id_394382528911801D);

    if(!isDefined(_id_869D699197F920A2))
      return "";
  } else
    return "";

  if(issubstr(_id_869D699197F920A2, "activity_starter")) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pmc_missions", "onPingContractPhone"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("pmc_missions", "onPingContractPhone")]](player);
  }

  _id_CB89110314447B2F = _id_D7FB39F0E6E8F752(_id_869D699197F920A2);

  if(!isDefined(_id_CB89110314447B2F) || _id_CB89110314447B2F < 0) {
    if(_id_869D699197F920A2 == "brloot_plunder_extraction_site_01" || _id_869D699197F920A2 == "brloot_plunder_extraction_site_02" || _id_869D699197F920A2 == "equip_fulton_mp")
      return "stat_C370A434325EEFAE";
    else if(_id_869D699197F920A2 == "ks_airdrop_crate_br")
      return "stat_5E9B42BB250430C0";
    else if(_id_869D699197F920A2 == "br_carriable_propane" || _id_869D699197F920A2 == "br_carriable_neurotoxin")
      return "stat_B4E5D4709FDE95AC";
    else if(_id_869D699197F920A2 == "fortress_tacmap_location" || _id_869D699197F920A2 == "fortress_tacmap_location_scriptable")
      return "stat_AA0B34E2E32D1DE8";
    else if(_id_869D699197F920A2 == "br_plunder_box")
      return "stat_86E6AA05DFA9ED3E";
    else if(_id_869D699197F920A2 == "dmz_activity_icon")
      return "stat_F2A9FF4E59BB1F21";
    else if(_id_869D699197F920A2 == "military_ammo_restock_noent")
      return "stat_DFC8971B3A3D7A81";
    else if(_id_869D699197F920A2 == "dmz_samsite_icon") {
      if(isDefined(_id_394382528911801D.team) && isDefined(player) && isDefined(player.team)) {
        if(player.team == _id_394382528911801D.team)
          return "stat_C4BB81A4113340DC";
        else
          return "stat_904B835819B20803";
      }

      return "stat_9B893E8E80C5182E";
    } else if(_id_869D699197F920A2 == "dmz_uav_tower") {
      if(isDefined(_id_394382528911801D._id_DCC5F31EC71D6D8A) && isDefined(player) && isDefined(player.team)) {
        if(player.team == _id_394382528911801D._id_DCC5F31EC71D6D8A)
          return "stat_B27BFFE6B0B70E83";
        else
          return "stat_C42F31AA52CDC1CA";
      }

      return "stat_872E13B3730CED3B";
    } else if(_id_869D699197F920A2 == "scriptable_redeploy_drone")
      return "stat_B2E52B074F412495";
    else if(_id_869D699197F920A2 == "sealion_chance_machine")
      return "stat_AA42356A6E397720";

    return "stat_9DFFC2E6FE1C2F36";
  }

  type = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 2);

  if(type == "weapon")
    return _id_8D17E607A79FD65F(_id_869D699197F920A2);

  if(type == "questsafe" && isDefined(_id_394382528911801D._id_65F2E31BA81E1B45) && isDefined(_id_394382528911801D._id_B8EBE3F71A08AB40) && _id_394382528911801D._id_B8EBE3F71A08AB40.teams[0] != player.team)
    return "stat_950A284047C4C938";

  _id_832AD168567520F7 = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 29);

  if(!isDefined(_id_832AD168567520F7) || _id_832AD168567520F7 == "")
    return "stat_9DFFC2E6FE1C2F36";

  if(!_func_D03495FE6418377B(_id_832AD168567520F7)) {
    if(_id_832AD168567520F7 == "ping_loot_ammo_midcaliber" && scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "lookupCurrentOperator")) {
      if(player[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "lookupCurrentOperator")]](player.team) == "luna_western")
        return "stat_139B0BD39823AD92";
    }

    return _func_1823FF50BB28148D(_id_832AD168567520F7);
  }

  return _id_832AD168567520F7;
}

_id_8D17E607A79FD65F(weaponname) {
  if(isDefined(level.br_lootiteminfo) && isDefined(level.br_lootiteminfo[weaponname]) && isDefined(level.br_lootiteminfo[weaponname].fullweaponobj))
    weaponname = level.br_lootiteminfo[weaponname].fullweaponobj.basename;

  if(isDefined(weaponname) && (issubstr(weaponname, "iw9_dm_la700") || issubstr(weaponname, "iw9_dm_xmike2010")))
    weaponname = scripts\engine\utility::ter_op(weaponname == "iw9_dm_la700", "iw9_sn_la700", "iw9_sn_xmike2010");

  if(issubstr(weaponname, "_me_riotshield"))
    return "stat_E6879B73C425B645";
  else if(issubstr(weaponname, "_me_") || isendstr(weaponname, "_me"))
    return "stat_0009A82A986F78B6";
  else if(issubstr(weaponname, "_pi_") || isendstr(weaponname, "_pi"))
    return "stat_CD5F060D817D69AD";
  else if(issubstr(weaponname, "_sh_") || isendstr(weaponname, "_sh"))
    return "stat_7C509A84250D2DF4";
  else if(issubstr(weaponname, "_sm_") || isendstr(weaponname, "_sm"))
    return "stat_6B8874A19007433B";
  else if(issubstr(weaponname, "_ar_") || isendstr(weaponname, "_ar"))
    return "stat_F856404F7930D595";
  else if(issubstr(weaponname, "_lm_") || isendstr(weaponname, "_lm"))
    return "stat_80D611A10ADCE102";
  else if(!issubstr(weaponname, "crossbow") && (issubstr(weaponname, "_dm_") || isendstr(weaponname, "_dm")))
    return "stat_C5EB56A131EE4D21";
  else if(!issubstr(weaponname, "crossbow") && (issubstr(weaponname, "_sn_") || isendstr(weaponname, "_sn")))
    return "stat_F0B69038DDB805B5";
  else if(issubstr(weaponname, "_la_") || isendstr(weaponname, "_la"))
    return "stat_C96F150EEA6F45E2";
  else if(issubstr(weaponname, "_br_") || isendstr(weaponname, "_br"))
    return "stat_F856404F7930D595";
  else
    return "stat_9DFFC2E6FE1C2F36";
}

_id_9BB1120B45CFA775(_id_394466C2DDB208CB) {
  player = self;
  _id_C1074AB6CAC2169F = player calloutmarkerping_getEnt(_id_394466C2DDB208CB);

  if(!isDefined(_id_C1074AB6CAC2169F))
    return "stat_BE4CC85A249D4AF5";

  if(!isent(_id_C1074AB6CAC2169F))
    return "stat_BE4CC85A249D4AF5";

  _id_7731ADEF63E19B0C = _id_C1074AB6CAC2169F scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();

  if(!isDefined(_id_7731ADEF63E19B0C))
    return "stat_BE4CC85A249D4AF5";

  if(_id_6641A5B759148E1B()) {
    if(_id_7731ADEF63E19B0C == "veh9_palfa")
      return "stat_28E8CCEDD7FD880C";
  }

  return "stat_BE4CC85A249D4AF5";
}

_id_BEFA2CBD9D478179(_id_394466C2DDB208CB) {
  player = self;
  _id_2D618A34E27D5476 = undefined;

  if(player _meth_929EE540AD474F2F("ui_br_objective_index"))
    _id_2D618A34E27D5476 = player getclientomnvar("ui_br_objective_index");

  if(!isDefined(_id_2D618A34E27D5476) || _id_2D618A34E27D5476 == 0)
    return "stat_BCA5E472447F8C73";

  _id_1070D193895B35B4 = tablelookup("mp/brmissions.csv", 0, _id_2D618A34E27D5476, 18);
  _id_962B7EF0A10E1038 = "stat_F2A9FF4E59BB1F21";

  if(isDefined(_id_1070D193895B35B4) && _id_1070D193895B35B4 != "") {
    switch (_id_1070D193895B35B4) {
      case "dom":
        return "stat_92E9C29AAF5DF02E";
      case "hostage":
        return "stat_63D201BEC507D7CF";
      default:
        return "stat_BCA5E472447F8C73";
    }
  }

  return "stat_BCA5E472447F8C73";
}

calloutmarkerpingvo_getaffirmaliasstringloot(_id_394466C2DDB208CB, _id_394382528911801D, _id_DFB9F3C233E2B8F3) {
  player = self;

  if(isDefined(_id_394382528911801D) && isDefined(_id_394382528911801D.type))
    _id_869D699197F920A2 = _id_394382528911801D.type;
  else {
    _id_A1823E6B1CB4B46D = player calloutmarkerping_gettype(_id_394466C2DDB208CB);
    return "";
  }

  _id_CB89110314447B2F = _id_D7FB39F0E6E8F752(_id_869D699197F920A2);

  if(!isDefined(_id_CB89110314447B2F) || _id_CB89110314447B2F < 0) {
    if(isDefined(_id_394382528911801D) && isDefined(_id_394382528911801D.entity)) {
      if(_calloutmarkerping_isdropcrate(_id_394382528911801D.entity))
        return "stat_4A7F14FA17B76265";
    }

    if(_id_869D699197F920A2 == "brloot_plunder_extraction_site_01" || _id_869D699197F920A2 == "brloot_plunder_extraction_site_02" || _id_869D699197F920A2 == "equip_fulton_mp")
      return "stat_2F0E31588EEE8365";
    else if(_id_869D699197F920A2 == "br_plunder_box")
      return "stat_4B2E7401EB29AAB5";
    else if(_id_869D699197F920A2 == "dmz_samsite_icon")
      return "stat_D58AEB2B1B4050F9";
    else if(_id_869D699197F920A2 == "dmz_uav_tower")
      return "stat_340B075CC2841A64";
    else if(_id_869D699197F920A2 == "fortress_tacmap_location" || _id_869D699197F920A2 == "fortress_tacmap_location_scriptable")
      return "stat_89076FD71C7C42BF";
    else if(_id_869D699197F920A2 == "dmz_exfil_site")
      return "stat_11FA7946DDF751CD";
    else if(isDefined(_id_394382528911801D.entity) && isDefined(_id_394382528911801D.entity.vehiclename) && _id_394382528911801D.entity.vehiclename == "cargo_train")
      return "stat_BE4CC85A249D4AF5";

    return "stat_DF30101EBCF2D491";
  }

  type = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 2);

  if(type == "weapon")
    return "stat_1B67E457EDE92DC0";

  _id_832AD168567520F7 = tablelookupbyrow(level.brloottablename, _id_CB89110314447B2F, 30);

  if(!isDefined(_id_832AD168567520F7) || _id_832AD168567520F7 == "")
    return "stat_DF30101EBCF2D491";

  return _id_832AD168567520F7;
}

calloutmarkerping_removecallout(_id_394466C2DDB208CB) {
  player = self;

  if(!isDefined(player)) {
    return;
  }
  _calloutmarkerping_predicted_log("Remove Callout ID Start: " + _id_394466C2DDB208CB);
  _id_A1823E6B1CB4B46D = player calloutmarkerping_gettype(_id_394466C2DDB208CB);

  if(isDefined(_id_A1823E6B1CB4B46D) && _id_A1823E6B1CB4B46D >= 2 && _id_A1823E6B1CB4B46D < 36) {
    if(_id_A1823E6B1CB4B46D == 2) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("ping", "calloutMarkerPing_squadLeaderBeaconKillForPlayer"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("ping", "calloutMarkerPing_squadLeaderBeaconKillForPlayer")]](player);
    }

    player calloutmarkerping_delete(_id_394466C2DDB208CB);
    _calloutmarkerping_predicted_log("Remove Callout ID Notify: " + _id_394466C2DDB208CB);
    player notify("predictiveCalloutClear_" + _id_394466C2DDB208CB);

    if(_id_A1823E6B1CB4B46D == 5)
      player _id_6C9B8F9429B7FDCA(player.team);
  }
}

calloutmarkerping_watchwhenobjectivestartsprogress(_id_394466C2DDB208CB, _id_93BC7962739FD49E) {
  self endon("disconnect");
  self endon("predictiveCalloutClear_" + _id_394466C2DDB208CB);

  for(;;) {
    level waittill("Objective_SetShowProgress", _id_8A2E167F6894D193);

    if(_id_53EBC25DCFE48D00(self, _id_8A2E167F6894D193) && isDefined(_id_8A2E167F6894D193) && _id_8A2E167F6894D193 == _id_93BC7962739FD49E) {
      _calloutmarkerping_predicted_log("gscObjectiveStartedProgress: " + _id_394466C2DDB208CB + " | gscObjID: " + _id_93BC7962739FD49E);
      break;
    }
  }

  calloutmarkerping_removecallout(_id_394466C2DDB208CB);
}

calloutmarkerping_watchwhenobjectivedeleted(_id_394466C2DDB208CB, _id_93BC7962739FD49E) {
  self endon("disconnect");
  self endon("predictiveCalloutClear_" + _id_394466C2DDB208CB);

  for(;;) {
    level waittill("Objective_Delete", _id_E2AC79B49840672C);

    if(isDefined(_id_E2AC79B49840672C) && _id_E2AC79B49840672C == _id_93BC7962739FD49E) {
      _calloutmarkerping_predicted_log("gscObjectiveDeleted: " + _id_394466C2DDB208CB + " | gscObjID: " + _id_93BC7962739FD49E);
      break;
    }
  }

  calloutmarkerping_removecallout(_id_394466C2DDB208CB);
}

_id_632CC7F8CBF11AE1(_id_394466C2DDB208CB, ent) {
  self endon("disconnect");
  self endon("predictiveCalloutClear_" + _id_394466C2DDB208CB);
  _calloutmarkerping_predicted_log("Watch Entity Death or Enemy Disconnect: " + _id_394466C2DDB208CB);

  if(!isDefined(ent)) {}

  if(!isent(ent))
    ent scripts\engine\utility::waittill_any_3("death", "pickup", "explode");
  else if(isPlayer(ent)) {
    val = ent scripts\engine\utility::waittill_any_return_2("death", "disconnect");

    if(val == "disconnect") {
      calloutmarkerping_removecallout(_id_394466C2DDB208CB);
      return;
    }

    thread calloutmarkerping_enemytodangerdecaycreate(_id_394466C2DDB208CB, ent);
    return;
  } else if(isagent(ent)) {
    ent waittill("death");
    thread calloutmarkerping_enemytodangerdecaycreate(_id_394466C2DDB208CB, ent);
  } else {
    if(!istrue(ent.isdestroyed))
      ent scripts\engine\utility::waittill_any_3("death", "pickup", "explode");

    calloutmarkerping_removecallout(_id_394466C2DDB208CB);
  }
}

calloutmarkerping_watchplayerdeathordisconnect(_id_394466C2DDB208CB) {
  player = self;
  self endon("predictiveCalloutClear_" + _id_394466C2DDB208CB);
  _calloutmarkerping_predicted_log("watchPlayerDeathOrDisconnect: " + _id_394466C2DDB208CB);
  _id_41A4A181B6606B16 = player _meth_0A7E757D42B550A6(_id_394466C2DDB208CB);

  switch (_id_41A4A181B6606B16) {
    case 23:
    case 22:
      lootid = player _meth_C4E0716FBD549E2D(_id_394466C2DDB208CB);
      _id_C08EEEE95B85512A = isDefined(lootid) && _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(lootid) != "calloutmarkerpingitem";

      if(_id_C08EEEE95B85512A) {
        scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);
        scripts\engine\utility::waittill_any_2("death_or_disconnect", "self_pickedupitem_" + scriptablename);
      } else
        scripts\engine\utility::waittill_any_2("death_or_disconnect");

      break;
    case 25:
    case 24:
      if(getdvarint("dvar_06F618729986D661", 1) && scripts\common\utility::ismp() && scripts\cp_mp\utility\script_utility::issharedfuncdefined("ping", "calloutMarkerPing_watchItemTakenFromContainer")) {
        lootid = player _meth_C4E0716FBD549E2D(_id_394466C2DDB208CB);
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("ping", "calloutMarkerPing_watchItemTakenFromContainer")]](player, player._id_02FA5B49969DEF47, lootid);
      } else
        scripts\engine\utility::waittill_any_2("death_or_disconnect");

      break;
    default:
      scripts\engine\utility::waittill_any_2("death_or_disconnect");
      break;
  }

  calloutmarkerping_removecallout(_id_394466C2DDB208CB);
}

calloutmarkerping_watchscriptabledeath(_id_394466C2DDB208CB, _id_DB376EE90688810D) {
  self endon("disconnect");
  self endon("predictiveCalloutClear_" + _id_394466C2DDB208CB);
  _calloutmarkerping_predicted_log("Watch scriptable death ID: " + _id_394466C2DDB208CB);

  if(!isDefined(_id_DB376EE90688810D)) {} else if(_id_DB376EE90688810D.type == "equip_fulton_mp") {
    ent = _id_DB376EE90688810D.entity;

    if(!isDefined(ent)) {
      return;
    }
    ent scripts\engine\utility::waittill_any_2("death", "fulton_takeoff");
  } else {
    _id_122CECC87707E886 = scripts\engine\utility::_id_CE51E08DCC037220(_id_DB376EE90688810D.origin, "undefined", "CalloutMarkerPing: : scriptableInstance.entity.script_noteworthy is undefined");

    if(isDefined(_id_DB376EE90688810D.entity) && isDefined(_id_DB376EE90688810D.entity.script_noteworthy))
      _id_F060782B4775F90E = _id_DB376EE90688810D.entity.script_noteworthy;
    else
      _id_F060782B4775F90E = _id_122CECC87707E886;

    _id_825EB5C6ACF63494 = scripts\engine\utility::_id_CE51E08DCC037220(_id_DB376EE90688810D.type, 1, "CalloutMarkerPing: : scriptableInstance.type is invalid");
    level scripts\engine\utility::waittill_any_6("pickedupweapon_kill_callout_" + _id_825EB5C6ACF63494 + _id_122CECC87707E886, "lootcache_opened_kill_callout" + _id_122CECC87707E886, "dropbag_kill_callout_" + _id_122CECC87707E886, "tablethide_kill_callout_" + _id_122CECC87707E886, "carriable_kill_callout_" + _id_122CECC87707E886, "forced_kill_callout_" + _id_F060782B4775F90E);
  }

  _calloutmarkerping_predicted_log("Watch scriptable death Remove ID: " + _id_394466C2DDB208CB);
  calloutmarkerping_removecallout(_id_394466C2DDB208CB);
}

calloutmarkerping_onplayerdisconnect(player) {
  if(!isDefined(player)) {
    return;
  }
  player calloutmarkerping_removeallcalloutsforplayer();
}

calloutmarkerpingvo_calculatesounddebouncelength(_id_93A0836A10E99C34, _id_394466C2DDB208CB, _id_E64B7437E7151A62) {
  player = self;
  _id_A1823E6B1CB4B46D = _id_93A0836A10E99C34 calloutmarkerping_gettype(_id_394466C2DDB208CB);

  if(_id_C648F0FD527E089A(_id_A1823E6B1CB4B46D))
    return _id_E64B7437E7151A62 + 500;
  else if(_id_D3789A9A4BE5DF2E(_id_A1823E6B1CB4B46D))
    return _id_E64B7437E7151A62 + 500;
  else if(_id_74EC310D8F99B6E2(_id_A1823E6B1CB4B46D))
    return _id_E64B7437E7151A62 + 500;
  else if(_id_87DF78670540E9B2(_id_A1823E6B1CB4B46D))
    return _id_E64B7437E7151A62 + 500;
  else {
    switch (_id_A1823E6B1CB4B46D) {
      case 2:
        return _id_E64B7437E7151A62 + 500;
      case 6:
        return _id_E64B7437E7151A62 + 500;
      case 4:
        return _id_E64B7437E7151A62 + 500;
      case 5:
        return _id_E64B7437E7151A62 + 500;
      default:
        return _id_E64B7437E7151A62 + 500;
    }
  }
}

_id_BB7FE8982D035C10(_id_9090AF2A5C319A58) {
  player = self;

  if(!isDefined(player.calloutmarkerpingvohandlerpool[_id_9090AF2A5C319A58]))
    return 0;

  return 1;
}

calloutmarkerpingvo_handleraddnewelement(_id_93A0836A10E99C34, _id_394466C2DDB208CB, _id_0F1A9809EED7E8F0, _id_9090AF2A5C319A58, _id_E64B7437E7151A62) {
  player = self;
  _id_37F40CB76AEADD2A = player.calloutmarkerpingvohandlerpool.size;

  if(_id_37F40CB76AEADD2A > 10)
    return 0;

  _id_E42BEA5E21788553 = player calloutmarkerpingvo_calculatesounddebouncelength(_id_93A0836A10E99C34, _id_394466C2DDB208CB, _id_E64B7437E7151A62);
  _id_A4E4C581C371283D = _id_E42BEA5E21788553 + _id_0F1A9809EED7E8F0;
  _id_0C8895C40CA12D15 = spawnStruct();
  _id_0C8895C40CA12D15.sounddebouncetimestamp = _id_A4E4C581C371283D;
  _id_0C8895C40CA12D15._id_394466C2DDB208CB = _id_394466C2DDB208CB;
  _id_0C8895C40CA12D15.cancelled = 0;
  player.calloutmarkerpingvohandlerpool[_id_9090AF2A5C319A58] = _id_0C8895C40CA12D15;
  return 1;
}

calloutmarkerpingvo_canplaywithspamavoidance(_id_93A0836A10E99C34, _id_394466C2DDB208CB, _id_5AB0DC648937D4EA, _id_E64B7437E7151A62) {
  player = self;

  if(!isDefined(player) || !isPlayer(player))
    return 0;

  if(!isDefined(_id_93A0836A10E99C34) || !isPlayer(_id_93A0836A10E99C34))
    return 0;

  if(istrue(level._id_5D4C8322D01B9C50))
    return 0;

  if(istrue(player._id_5D4C8322D01B9C50) || getdvarint("dvar_28FFDE533F721522", 0))
    return 0;

  _id_0F1A9809EED7E8F0 = gettime();
  _id_A1823E6B1CB4B46D = player calloutmarkerping_gettype(_id_394466C2DDB208CB);
  _id_9090AF2A5C319A58 = "pingType" + _id_A1823E6B1CB4B46D;
  _id_C7704A4BC6945A9F = player _id_BB7FE8982D035C10(_id_9090AF2A5C319A58);

  if(_id_C7704A4BC6945A9F) {
    sounddebouncetimestamp = player.calloutmarkerpingvohandlerpool[_id_9090AF2A5C319A58].sounddebouncetimestamp;

    if(_id_0F1A9809EED7E8F0 >= sounddebouncetimestamp) {
      _id_964D2B3A97D9ACDA = player calloutmarkerpingvo_handleraddnewelement(_id_93A0836A10E99C34, _id_394466C2DDB208CB, _id_0F1A9809EED7E8F0, _id_9090AF2A5C319A58, _id_E64B7437E7151A62);
      return istrue(_id_964D2B3A97D9ACDA);
    }

    if(_id_5AB0DC648937D4EA == "stat_6D43A076A8B18354" && player.calloutmarkerpingvohandlerpool[_id_9090AF2A5C319A58].cancelled == 0) {
      player.calloutmarkerpingvohandlerpool[_id_9090AF2A5C319A58].cancelled = 1;
      return 1;
    }

    return 0;
  } else if(_id_5AB0DC648937D4EA == "stat_6D43A076A8B18354")
    return 0;
  else {
    _id_964D2B3A97D9ACDA = player calloutmarkerpingvo_handleraddnewelement(_id_93A0836A10E99C34, _id_394466C2DDB208CB, _id_0F1A9809EED7E8F0, _id_9090AF2A5C319A58, _id_E64B7437E7151A62);
    return istrue(_id_964D2B3A97D9ACDA);
  }
}

calloutmarkerpingvo_debouncegarbagecollector() {
  level endon("game_ended");

  for(;;) {
    wait 10;
    currenttime = gettime();

    for(_id_ACCFE4F0F3B0D4FD = 0; _id_ACCFE4F0F3B0D4FD < level.players.size; _id_ACCFE4F0F3B0D4FD++) {
      player = level.players[_id_ACCFE4F0F3B0D4FD];

      if(!isDefined(player) || !isDefined(player.calloutmarkerpingvohandlerpool)) {
        continue;
      }
      foreach(key, _id_12A061CEEA3EE7CB in player.calloutmarkerpingvohandlerpool) {
        if(currenttime > _id_12A061CEEA3EE7CB.sounddebouncetimestamp)
          player.calloutmarkerpingvohandlerpool[key] = undefined;
      }
    }
  }
}

calloutmarkerpingvo_getmaxsoundaliaslength(_id_C197335AAD9F5E31, _id_A542114A7EE5ABB5, _id_C1934D5AAD9BA188, _id_A53CEB4A7EDF2F4C) {
  _id_196FFC81C8206C2A = 0;

  if(_id_C197335AAD9F5E31) {
    _id_1DC4F593A85F62DF = lookupsoundlength(_id_A542114A7EE5ABB5, 1);

    if(_id_1DC4F593A85F62DF > _id_196FFC81C8206C2A)
      _id_196FFC81C8206C2A = _id_1DC4F593A85F62DF;
  }

  if(_id_C1934D5AAD9BA188) {
    _id_1DC4F593A85F62DF = lookupsoundlength(_id_A53CEB4A7EDF2F4C, 1);

    if(_id_1DC4F593A85F62DF > _id_196FFC81C8206C2A)
      _id_196FFC81C8206C2A = _id_1DC4F593A85F62DF;
  }

  return _id_196FFC81C8206C2A;
}

calloutmarkerping_playteamsoundfx(alias, _id_394466C2DDB208CB) {
  player = self;

  if(!isDefined(player) || !isPlayer(player) || !isDefined(alias)) {
    return;
  }
  if(!soundexists(alias)) {}

  _id_82076CFFF3BD567A = undefined;
  _id_8512C523DCA1FD8F = undefined;

  if(isDefined(_id_394466C2DDB208CB)) {
    _id_82076CFFF3BD567A = player calloutmarkerping_getEnt(_id_394466C2DDB208CB);
    _id_8512C523DCA1FD8F = player calloutmarkerping_getorigin(_id_394466C2DDB208CB);
  }

  _id_96674628376EABA6 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getSquadmates")]](player.team, player._id_0FF97225579DE16A, 1);

  foreach(_id_F0EA4030349A33D5 in _id_96674628376EABA6) {
    if(player != _id_F0EA4030349A33D5) {
      if(istrue(player.gulagarena) && !istrue(_id_F0EA4030349A33D5.gulagarena) || !istrue(player.gulagarena) && istrue(_id_F0EA4030349A33D5.gulagarena)) {
        continue;
      }
      _id_5C0879E9DEA157AF = _id_F0EA4030349A33D5 _meth_4076AA2E6C3DE4C8();

      if(_id_5C0879E9DEA157AF)
        continue;
    }

    if(player isspectatingplayer())
      _id_DD7368DF13BC1A31 = _id_F0EA4030349A33D5;
    else if(isDefined(_id_82076CFFF3BD567A)) {
      _id_DD7368DF13BC1A31 = spawn("script_origin", _id_82076CFFF3BD567A.origin);
      _id_DD7368DF13BC1A31.istempsfxent = 1;
    } else if(isDefined(_id_8512C523DCA1FD8F)) {
      _id_DD7368DF13BC1A31 = spawn("script_origin", _id_8512C523DCA1FD8F);
      _id_DD7368DF13BC1A31.istempsfxent = 1;
    } else
      _id_DD7368DF13BC1A31 = player;

    _id_DD7368DF13BC1A31 playsoundtoplayer(alias, _id_F0EA4030349A33D5);

    if(isDefined(_id_DD7368DF13BC1A31.istempsfxent))
      _id_DD7368DF13BC1A31 delete();
  }
}

calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias2d(_id_5BB586139A747C1C) {
  player = self;

  if(!isDefined(player.operatorcustomization) || !isDefined(player.operatorcustomization.voice)) {
    return;
  }
  _id_A542114A7EE5ABB5 = "dx_mpp_" + player.operatorcustomization.voice + "_" + _id_5BB586139A747C1C;
  return _id_A542114A7EE5ABB5;
}

calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(_id_5BB586139A747C1C) {
  player = self;

  if(!isDefined(player.operatorcustomization) || !isDefined(player.operatorcustomization.voice)) {
    return;
  }
  _id_A53CEB4A7EDF2F4C = "dx_mpb_" + player.operatorcustomization.voice + "_" + _id_5BB586139A747C1C;
  return _id_A53CEB4A7EDF2F4C;
}

calloutmarkerpingvo_play(_id_5AB0DC648937D4EA, _id_394466C2DDB208CB, _id_DFB9F3C233E2B8F3, targetent) {
  _id_93A0836A10E99C34 = self;

  if(!isDefined(_id_93A0836A10E99C34) || !isPlayer(_id_93A0836A10E99C34) || !scripts\cp_mp\utility\player_utility::isreallyalive(_id_93A0836A10E99C34)) {
    return;
  }
  if(!isDefined(_id_394466C2DDB208CB)) {
    return;
  }
  if(!isDefined(_id_5AB0DC648937D4EA) || _id_5AB0DC648937D4EA == "") {
    return;
  }
  _id_4F632C1568AF9FC0 = level.bcinfo["asset"][_func_1823FF50BB28148D(_id_5AB0DC648937D4EA)];

  if(isPlayer(_id_DFB9F3C233E2B8F3))
    _id_4D0CE2D79BF45D54 = _id_DFB9F3C233E2B8F3;
  else
    _id_4D0CE2D79BF45D54 = _id_93A0836A10E99C34;

  _id_196FFC81C8206C2A = 2000;
  _id_57D0946B275FEA34 = _id_4D0CE2D79BF45D54 calloutmarkerpingvo_canplaywithspamavoidance(_id_93A0836A10E99C34, _id_394466C2DDB208CB, _id_5AB0DC648937D4EA, _id_196FFC81C8206C2A);

  if(istrue(_id_57D0946B275FEA34)) {
    logprint("calloutmarkerping::calloutMarkerPingVO_play - PlaySoundEvent()");
    logprint("self = " + _id_4D0CE2D79BF45D54.name);
    logprint("sessionstate = " + _id_4D0CE2D79BF45D54.sessionstate);
    logprint("targetEnt= " + isDefined(targetent));

    if(isDefined(targetent)) {
      logprint("tEntclassname = " + targetent.classname);
      logprint("tEntOrigin= " + targetent.origin);

      if(isent(targetent) && isPlayer(targetent))
        logprint("tEntSessionstate = " + targetent.sessionstate);
    }

    if(isDefined(_id_4F632C1568AF9FC0)) {
      if(isDefined(targetent) && isent(targetent))
        _id_4D0CE2D79BF45D54 _meth_C664A2459D6F3EAA(_id_4F632C1568AF9FC0, targetent);
      else
        _id_4D0CE2D79BF45D54 _meth_C664A2459D6F3EAA(_id_4F632C1568AF9FC0);
    }
  }
}

calloutmarkerping_navigationcancelproximity(_id_394466C2DDB208CB) {
  self endon("disconnect");
  self endon("predictiveCalloutClear_" + _id_394466C2DDB208CB);
  self notify("calloutMarkerPing_navigationCancelProximity");
  self endon("calloutMarkerPing_navigationCancelProximity");
  _id_220A4DC6346CBCE8 = getdvarfloat("dvar_7C74D4814E0665D5", 60.0);
  _id_C1C5F124F3099349 = getdvarint("dvar_37DFB2340C8F1DED", 10);
  wait(_id_C1C5F124F3099349);

  if(!self calloutmarkerping_getactive(_id_394466C2DDB208CB)) {
    return;
  }
  _id_A0C7EFBC36968A9D = self calloutmarkerping_getorigin(_id_394466C2DDB208CB);
  _id_24E75A7F4FF07F6A = getdvarint("dvar_AA5168815ED6F2F9", 47089);
  _id_DFF4AE73CFF54257 = getdvarint("dvar_93E80752445801C0", 1);
  _id_8D61D476BCB70D31 = getdvarint("dvar_F53AF4867EF2F684", 1.0);

  for(;;) {
    if(_id_DFF4AE73CFF54257 == 1)
      _id_4EB801042B324702 = distancesquared(self.origin, _id_A0C7EFBC36968A9D);
    else {
      _id_4EB801042B324702 = _id_24E75A7F4FF07F6A;
      _id_96674628376EABA6 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](self.team, 1);

      foreach(_id_F0EA4030349A33D5 in _id_96674628376EABA6) {
        _id_2C32A427B3BD3226 = distancesquared(_id_F0EA4030349A33D5.origin, _id_A0C7EFBC36968A9D);

        if(_id_2C32A427B3BD3226 < _id_4EB801042B324702)
          _id_4EB801042B324702 = _id_2C32A427B3BD3226;
      }
    }

    if(_id_4EB801042B324702 < _id_24E75A7F4FF07F6A) {
      calloutmarkerping_playteamsoundfx("uin_ping_cancel", _id_394466C2DDB208CB);
      calloutmarkerping_removecallout(_id_394466C2DDB208CB);
      return;
    }

    wait(_id_8D61D476BCB70D31);
  }
}

calloutmarkerping_removeallcalloutsforplayer() {
  player = self;

  if(isDefined(player)) {
    for(_id_394466C2DDB208CB = 0; _id_394466C2DDB208CB < 21; _id_394466C2DDB208CB++)
      player calloutmarkerping_removecallout(_id_394466C2DDB208CB);
  }
}

calloutmarkerping_removeallcalloutsforallplayers(_id_884A98392CE1109B) {
  _id_C502004B162C0807 = 0;

  foreach(player in level.players) {
    player calloutmarkerping_removeallcalloutsforplayer();

    if(istrue(_id_884A98392CE1109B)) {
      _id_C502004B162C0807++;

      if(_id_C502004B162C0807 % 10 == 0)
        waitframe();
    }
  }
}

calloutmarkerpingvo_playpredictivepingcleared(_id_394466C2DDB208CB, _id_DFB9F3C233E2B8F3) {
  player = self;
  player notify("calloutMarkerPingVO_playPredictivePingCleared");
  player endon("calloutMarkerPingVO_playPredictivePingCleared");
  player calloutmarkerping_playteamsoundfx("uin_ping_cancel", _id_394466C2DDB208CB);
  wait(getdvarfloat("dvar_7206CB95B7DFB4F0", 0.5));

  if(isDefined(player)) {
    if(isPlayer(_id_DFB9F3C233E2B8F3))
      player calloutmarkerpingvo_play("stat_6D43A076A8B18354", _id_394466C2DDB208CB, _id_DFB9F3C233E2B8F3);
    else
      player calloutmarkerpingvo_play("stat_6D43A076A8B18354", _id_394466C2DDB208CB);
  }
}

calloutmarkerpingvo_playpredictivepingacknowledgedcancel(_id_394466C2DDB208CB, _id_DFB9F3C233E2B8F3) {
  player = self;
  player calloutmarkerpingvo_playpredictivepingcleared(_id_394466C2DDB208CB, _id_DFB9F3C233E2B8F3);
}

calloutmarkerpingvo_playpredictivepingacknowledged(_id_394466C2DDB208CB, _id_DFB9F3C233E2B8F3) {
  _id_93A0836A10E99C34 = self;
  _id_93A0836A10E99C34 notify("calloutMarkerPingVO_playPredictivePingAcknowledged");
  _id_93A0836A10E99C34 endon("calloutMarkerPingVO_playPredictivePingAcknowledged");
  _id_A1823E6B1CB4B46D = _id_93A0836A10E99C34 calloutmarkerping_gettype(_id_394466C2DDB208CB);

  if(_id_C648F0FD527E089A(_id_A1823E6B1CB4B46D)) {
    _id_C1074AB6CAC2169F = _id_93A0836A10E99C34 calloutmarkerping_getEnt(_id_394466C2DDB208CB);
    _id_5AB0DC648937D4EA = _id_93A0836A10E99C34 calloutmarkerpingvo_getaffirmaliasstringloot(_id_394466C2DDB208CB, _id_C1074AB6CAC2169F, _id_DFB9F3C233E2B8F3);
  } else if(_id_D3789A9A4BE5DF2E(_id_A1823E6B1CB4B46D)) {
    ent = _id_93A0836A10E99C34 calloutmarkerping_getEnt(_id_394466C2DDB208CB);

    if(isDefined(ent) && isent(ent)) {
      if(isDefined(ent._id_1C9CB43BCF3EB16D) && ent._id_1C9CB43BCF3EB16D == "elimTarget")
        _id_5AB0DC648937D4EA = "stat_2CBD89D5C65961B3";
      else if(_calloutmarkerping_isenemy(ent, _id_93A0836A10E99C34))
        _id_5AB0DC648937D4EA = "stat_155094923A25C305";
      else if(issubstr(ent.model, "oxygen"))
        _id_5AB0DC648937D4EA = "stat_2DD233C754BAFFBC";
      else if(issubstr(ent.model, "gas_cutter"))
        _id_5AB0DC648937D4EA = "stat_3370E531D64FF8E2";
    }

    _id_5AB0DC648937D4EA = "stat_11FA7946DDF751CD";
  } else if(_id_74EC310D8F99B6E2(_id_A1823E6B1CB4B46D))
    _id_5AB0DC648937D4EA = "stat_BCA5E472447F8C73";
  else if(_id_87DF78670540E9B2(_id_A1823E6B1CB4B46D))
    _id_5AB0DC648937D4EA = "stat_11FA7946DDF751CD";
  else {
    switch (_id_A1823E6B1CB4B46D) {
      case 2:
        if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && isDefined(_id_93A0836A10E99C34.br_infil_type))
          _id_5AB0DC648937D4EA = "stat_F26B98445FBB71AE";
        else
          _id_5AB0DC648937D4EA = "stat_11FA7946DDF751CD";

        break;
      case 4:
        _id_5AB0DC648937D4EA = _id_93A0836A10E99C34 _id_BEFA2CBD9D478179(_id_394466C2DDB208CB);
        break;
      case 6:
        _id_5AB0DC648937D4EA = _id_93A0836A10E99C34 _id_9BB1120B45CFA775(_id_394466C2DDB208CB);
        break;
      case 5:
        _id_5AB0DC648937D4EA = "stat_DF30101EBCF2D491";
        break;
      default:
        _id_5AB0DC648937D4EA = "stat_11FA7946DDF751CD";
        break;
    }
  }

  wait(getdvarfloat("dvar_1D83539430A13314", 0.5));

  if(isPlayer(_id_DFB9F3C233E2B8F3))
    _id_93A0836A10E99C34 calloutmarkerpingvo_play(_id_5AB0DC648937D4EA, _id_394466C2DDB208CB, _id_DFB9F3C233E2B8F3);
  else if(isDefined(_id_93A0836A10E99C34))
    _id_93A0836A10E99C34 calloutmarkerpingvo_play(_id_5AB0DC648937D4EA, _id_394466C2DDB208CB);
}

calloutmarkerpingvo_playpredictivepingadded(_id_394466C2DDB208CB) {
  player = self;
  player notify("calloutMarkerPingVO_playPredictivePingAdded");
  player endon("calloutMarkerPingVO_playPredictivePingAdded");
  player endon("calloutMarkerPingVO_playPredictivePingCleared");
  player endon("predictiveCalloutClear_" + _id_394466C2DDB208CB);
  wait(getdvarfloat("dvar_490C0274864A18BE", 0.0));

  if(isDefined(player))
    player calloutmarkerpingvo_createcalloutbattlechatter(_id_394466C2DDB208CB);
}

calloutmarkerping_removevehiclecalloutonspecialconditions(_id_394466C2DDB208CB, _id_9849802214C4FA0A) {
  self endon("disconnect");
  self endon("predictiveCalloutClear_" + _id_394466C2DDB208CB);
  _id_7DAF7F78E6EF64B7 = _id_9849802214C4FA0A getentitynumber();
  _id_FF305CFC399BB107 = "forced_kill_callout_" + _id_7DAF7F78E6EF64B7;
  _id_451EBBF6C53EDC68 = 0.25;
  _id_4CED3A2A73D90EE6 = 0;
  _id_43835BB50B9D7F75 = self.team;

  for(;;) {
    _id_50DFDBDC6DA80233 = _calloutmarkerping_shouldremovecalloutifwholesquadinvehicle(_id_394466C2DDB208CB, _id_9849802214C4FA0A, _id_43835BB50B9D7F75);

    if(_id_50DFDBDC6DA80233) {
      calloutmarkerping_removecallout(_id_394466C2DDB208CB);
      return;
    }

    _id_012B40880A002E52 = _calloutmarkerping_isvehicleoccupiedbyenemy(_id_9849802214C4FA0A, _id_43835BB50B9D7F75);

    if(_id_012B40880A002E52) {
      _id_4CED3A2A73D90EE6 = _id_4CED3A2A73D90EE6 + _id_451EBBF6C53EDC68;

      if(_id_4CED3A2A73D90EE6 >= 3) {
        vehicleowner = _id_9849802214C4FA0A getvehicleowner();

        if(isDefined(vehicleowner))
          thread calloutmarkerping_enemytodangerdecaycreate(_id_394466C2DDB208CB, vehicleowner);
        else
          calloutmarkerping_removecallout(_id_394466C2DDB208CB);

        return;
      }
    }

    message = _id_3462378D38B69CC8(_id_451EBBF6C53EDC68, _id_FF305CFC399BB107);

    if(message == _id_FF305CFC399BB107) {
      calloutmarkerping_removecallout(_id_394466C2DDB208CB);
      return;
    }
  }
}

_id_3462378D38B69CC8(timeout, _id_0E7865AE7BE35347) {
  ent = spawnStruct();

  if(isDefined(_id_0E7865AE7BE35347))
    childthread scripts\engine\utility::waittill_string_no_endon_death(_id_0E7865AE7BE35347, ent);

  ent childthread scripts\engine\utility::_id_2C91B6C857AA73CC(timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

_calloutmarkerping_shouldremovecalloutifwholesquadinvehicle(_id_394466C2DDB208CB, _id_9849802214C4FA0A, _id_43835BB50B9D7F75) {
  _id_93A0836A10E99C34 = self;
  _id_D6EEDD657B73ECF1 = 0;
  _id_96674628376EABA6 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getSquadmates")]](_id_43835BB50B9D7F75, _id_93A0836A10E99C34._id_0FF97225579DE16A, 1);

  foreach(player in _id_96674628376EABA6) {
    if(player scripts\cp_mp\utility\player_utility::isinvehicle() && player.vehicle == _id_9849802214C4FA0A) {
      _id_93A0836A10E99C34 calloutmarkerping_hide(_id_394466C2DDB208CB, player);
      _id_D6EEDD657B73ECF1++;
    }
  }

  if(_id_D6EEDD657B73ECF1 == _id_96674628376EABA6.size)
    return 1;

  return 0;
}

_calloutmarkerping_isvehicleoccupiedbyenemy(_id_9849802214C4FA0A, _id_43835BB50B9D7F75) {
  _id_8A04EF044C068089 = isDefined(_id_9849802214C4FA0A.ownerteam) && _id_9849802214C4FA0A.ownerteam != _id_43835BB50B9D7F75;
  _id_0FA4121B60E749E3 = isDefined(_id_9849802214C4FA0A.isempty) && _id_9849802214C4FA0A.isempty == 0;

  if(_id_0FA4121B60E749E3 && _id_8A04EF044C068089)
    return 1;

  return 0;
}

_id_6A9D273F570C2D97(_id_394466C2DDB208CB, _id_3FBB10D80249BAAC, _id_C198F7CA473378FB, _id_F713679ECB32C725) {
  _id_93A0836A10E99C34 = self;

  if(!isDefined(_id_93A0836A10E99C34._id_7AB947F079ADF78A)) {
    return;
  }
  _id_8C75532DEAB80EF2 = _id_93A0836A10E99C34._id_7AB947F079ADF78A[_id_394466C2DDB208CB];

  if(!isDefined(_id_8C75532DEAB80EF2) || !isDefined(_id_8C75532DEAB80EF2._id_A1823E6B1CB4B46D)) {
    return;
  }
  _id_A1823E6B1CB4B46D = _id_8C75532DEAB80EF2._id_A1823E6B1CB4B46D;

  if(!isDefined(_id_93A0836A10E99C34._id_E42370A2EDA517E9) || !isDefined(_id_93A0836A10E99C34._id_E42370A2EDA517E9[_id_A1823E6B1CB4B46D])) {
    return;
  }
  _id_E42370A2EDA517E9 = _id_93A0836A10E99C34._id_E42370A2EDA517E9[_id_A1823E6B1CB4B46D];

  if(_id_F713679ECB32C725)
    _id_8C75532DEAB80EF2._id_F20158543E075304++;

  _id_EC6A81EAC0E4DC61 = [];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "ping_id";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_E42370A2EDA517E9;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "ping_type";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_A1823E6B1CB4B46D;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "tac_map_active";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = istrue(_id_93A0836A10E99C34 istacmapactive());
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "canceled";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_3FBB10D80249BAAC;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "cancel_reason";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_C198F7CA473378FB;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "player_x";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = float(_id_93A0836A10E99C34.origin[0]);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "player_y";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = float(_id_93A0836A10E99C34.origin[1]);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "player_z";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = float(_id_93A0836A10E99C34.origin[2]);
  _id_8512C523DCA1FD8F = _id_8C75532DEAB80EF2._id_8512C523DCA1FD8F;

  if(!isDefined(_id_8512C523DCA1FD8F))
    _id_8512C523DCA1FD8F = [0, 0, 0];

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "ping_x";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = float(_id_8512C523DCA1FD8F[0]);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "ping_y";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = float(_id_8512C523DCA1FD8F[1]);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "ping_z";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = float(_id_8512C523DCA1FD8F[2]);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "acknowledged";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_F713679ECB32C725;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "acknowledged_count";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_8C75532DEAB80EF2._id_F20158543E075304;
  _id_93A0836A10E99C34 dlog_recordplayerevent("dlog_event_br_ping_usage", _id_EC6A81EAC0E4DC61);
}

_id_A74E2D6A089BD337(_id_394466C2DDB208CB) {
  _id_93A0836A10E99C34 = self;

  if(!isDefined(_id_93A0836A10E99C34._id_7AB947F079ADF78A))
    _id_93A0836A10E99C34._id_7AB947F079ADF78A = [];

  _id_8C75532DEAB80EF2 = _id_93A0836A10E99C34._id_7AB947F079ADF78A[_id_394466C2DDB208CB];

  if(!isDefined(_id_8C75532DEAB80EF2)) {
    _id_93A0836A10E99C34._id_7AB947F079ADF78A[_id_394466C2DDB208CB] = spawnStruct();
    _id_8C75532DEAB80EF2 = _id_93A0836A10E99C34._id_7AB947F079ADF78A[_id_394466C2DDB208CB];
    _id_8C75532DEAB80EF2._id_F20158543E075304 = 0;
    _id_8C75532DEAB80EF2._id_A1823E6B1CB4B46D = _id_93A0836A10E99C34 calloutmarkerping_gettype(_id_394466C2DDB208CB);
    _id_8C75532DEAB80EF2._id_8512C523DCA1FD8F = _id_93A0836A10E99C34 calloutmarkerping_getorigin(_id_394466C2DDB208CB);
  }

  if(!isDefined(_id_93A0836A10E99C34._id_E42370A2EDA517E9))
    _id_93A0836A10E99C34._id_E42370A2EDA517E9 = [];

  _id_A1823E6B1CB4B46D = _id_8C75532DEAB80EF2._id_A1823E6B1CB4B46D;

  if(!isDefined(_id_93A0836A10E99C34._id_E42370A2EDA517E9[_id_A1823E6B1CB4B46D]))
    _id_93A0836A10E99C34._id_E42370A2EDA517E9[_id_A1823E6B1CB4B46D] = 1;
  else
    _id_93A0836A10E99C34._id_E42370A2EDA517E9[_id_A1823E6B1CB4B46D]++;

  _id_93A0836A10E99C34 _id_6A9D273F570C2D97(_id_394466C2DDB208CB, 0, "", 0);
}

_id_A366E9660606BFF8() {
  _id_93A0836A10E99C34 = self;

  if(isDefined(_id_93A0836A10E99C34)) {
    for(_id_394466C2DDB208CB = 0; _id_394466C2DDB208CB < 21; _id_394466C2DDB208CB++) {
      if(_id_93A0836A10E99C34 calloutmarkerping_getactive(_id_394466C2DDB208CB))
        _id_93A0836A10E99C34 _id_6A9D273F570C2D97(_id_394466C2DDB208CB, 1, "clear_all", 0);
    }
  }
}

_calloutmarkerping_handleluinotify_cleared(_id_394466C2DDB208CB) {
  _id_93A0836A10E99C34 = self;
  _id_93A0836A10E99C34 _id_6A9D273F570C2D97(_id_394466C2DDB208CB, 1, "clear_single", 0);
  _id_EC3FEDCB7195CFD7(_id_93A0836A10E99C34, _id_394466C2DDB208CB);
  _id_93A0836A10E99C34 notify("predictiveCalloutClear_" + _id_394466C2DDB208CB);
  _id_93A0836A10E99C34 thread calloutmarkerpingvo_playpredictivepingcleared(_id_394466C2DDB208CB);
}

_calloutmarkerping_handleluinotify_acknowledged(_id_394466C2DDB208CB, _id_60FDFB1CFD734D00) {
  _id_93A0836A10E99C34 = self;
  _id_93A0836A10E99C34 _id_6A9D273F570C2D97(_id_394466C2DDB208CB, 0, "", 1);
  _id_93A0836A10E99C34 thread _calloutmarkerping_predicted_timeout(_id_394466C2DDB208CB);
  _id_93A0836A10E99C34 thread calloutmarkerpingvo_playpredictivepingacknowledged(_id_394466C2DDB208CB, _id_60FDFB1CFD734D00);
}

_calloutmarkerping_handleluinotify_acknowledgedcancel(_id_394466C2DDB208CB, _id_60FDFB1CFD734D00) {
  _id_93A0836A10E99C34 = self;
  _id_93A0836A10E99C34 thread calloutmarkerpingvo_playpredictivepingacknowledgedcancel(_id_394466C2DDB208CB, _id_60FDFB1CFD734D00);
}

_id_86767E1FCCAD74F1() {
  if(!isDefined(level._id_15FAFD55BBED3780))
    level._id_15FAFD55BBED3780 = getdvarint("dvar_A06CE354E4B4F9D6", 0);

  return level._id_15FAFD55BBED3780;
}

_calloutmarkerping_handleluinotify_added(_id_394466C2DDB208CB) {
  _id_93A0836A10E99C34 = self;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("ping", "calloutMarkerPing_markerAdded"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("ping", "calloutMarkerPing_markerAdded")]](_id_93A0836A10E99C34, _id_394466C2DDB208CB);

  if(_id_F956B46F8E151D30(_id_93A0836A10E99C34, _id_394466C2DDB208CB)) {
    return;
  }
  if(_id_A5747EB82EE7BB73(_id_93A0836A10E99C34, _id_394466C2DDB208CB)) {
    return;
  }
  _id_93A0836A10E99C34 _id_A74E2D6A089BD337(_id_394466C2DDB208CB);
  _id_0CAADD21A226BF96(_id_93A0836A10E99C34, _id_394466C2DDB208CB);
  _id_93A0836A10E99C34 thread _calloutmarkerping_predicted_timeout(_id_394466C2DDB208CB);
  _id_93A0836A10E99C34 _calloutmarkerping_checkforbuybackrequest(_id_394466C2DDB208CB);
  _id_93A0836A10E99C34 thread calloutmarkerpingvo_playpredictivepingadded(_id_394466C2DDB208CB);
  _id_93A0836A10E99C34 _calloutmarkerping_onpingchallenge(_id_394466C2DDB208CB);

  if(_id_86767E1FCCAD74F1())
    iprintlnbold("Ping of type " + _id_93A0836A10E99C34 calloutmarkerping_gettype(_id_394466C2DDB208CB) + " has been added.");

  if(_id_394466C2DDB208CB == 4) {
    objindex = self calloutmarkerping_getgscobjectiveindex(_id_394466C2DDB208CB);

    if(objindex != -1)
      objective_setplayintro(objindex, 0);
  }

  _id_3663D672D6E752F8 = _id_93A0836A10E99C34 _meth_B93971ABB4221C6B(_id_394466C2DDB208CB);

  if(_id_3663D672D6E752F8 == 3)
    _id_93A0836A10E99C34 _id_C1A654559682AEA3(_id_394466C2DDB208CB);
}

_id_5991BC039B1244EC(player) {
  player calloutmarkerping_removeallcalloutsforplayer();
}

_id_F9A23942C0CD9461(_id_93A0836A10E99C34, _id_A1823E6B1CB4B46D) {
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("teamAssim", "isEnabled") || !scripts\cp_mp\utility\script_utility::issharedfuncdefined("teamAssim", "resolveAssimRequest") || !scripts\cp_mp\utility\script_utility::issharedfuncdefined("teamAssim", "requestNearbyTeamChange") || !scripts\cp_mp\utility\script_utility::issharedfuncdefined("teamAssim", "isWaitingForAssimResponse")) {
    return;
  }
  if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "isEnabled")]]()) {
    return;
  }
  if(_id_476D89B12DFE07A1(_id_A1823E6B1CB4B46D))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "requestNearbyTeamChange")]](_id_93A0836A10E99C34, _id_A1823E6B1CB4B46D == 13);
}

_calloutmarkerping_handleluinotify_enemyrepinged(_id_394466C2DDB208CB) {
  _id_93A0836A10E99C34 = self;
  _id_93A0836A10E99C34 thread _calloutmarkerping_predicted_timeout(_id_394466C2DDB208CB);
  _id_93A0836A10E99C34 calloutmarkerping_playteamsoundfx("uin_ping_enemy", _id_394466C2DDB208CB);
}

_calloutmarkerping_handleluinotify_mappingdeletemarker() {
  _id_93A0836A10E99C34 = self;
  _id_776CE2FAF67BEED7 = _calloutmarkerping_predicted_isanypingactive();

  if(_id_776CE2FAF67BEED7) {
    _id_93A0836A10E99C34 _id_A366E9660606BFF8();
    _id_93A0836A10E99C34 calloutmarkerping_playteamsoundfx("uin_ping_cancel");
    _id_8C4B1D9591DC12AB(_id_93A0836A10E99C34);
  }

  _id_93A0836A10E99C34 calloutmarkerping_removeallcalloutsforplayer();
}

_id_7A87E3B6A7645C79(_id_9B55B6A174C841EF) {
  _id_1560C7D5CACC7888 = 32;

  if(_id_1560C7D5CACC7888 > 32)
    return undefined;

  _id_C5C158F925FDBF45 = spawnStruct();
  _id_9EB6DF06F8B7B0EE = 67108863;
  _id_C5C158F925FDBF45.lootid = _id_9B55B6A174C841EF &_id_9EB6DF06F8B7B0EE;
  _id_9B55B6A174C841EF = _id_9B55B6A174C841EF >> 26;
  _id_80D584B74F2C0886 = 63;
  _id_C5C158F925FDBF45._id_41A4A181B6606B16 = _id_9B55B6A174C841EF &_id_80D584B74F2C0886;
  return _id_C5C158F925FDBF45;
}

_id_BDDCF3549133ED79(_id_9B55B6A174C841EF) {
  if(getdvarint("dvar_43A226EDE0C4E131", 0)) {
    return;
  }
  _id_93A0836A10E99C34 = self;
  _id_C5C158F925FDBF45 = _id_7A87E3B6A7645C79(_id_9B55B6A174C841EF);
  _id_394466C2DDB208CB = _id_93A0836A10E99C34 thread _id_1CED737A22161A49(_id_C5C158F925FDBF45._id_41A4A181B6606B16, _id_C5C158F925FDBF45.lootid);

  if(isDefined(_id_394466C2DDB208CB))
    _id_93A0836A10E99C34 _id_A74E2D6A089BD337(_id_394466C2DDB208CB);
}

_id_6B9641D0060C3A2C(target) {
  target._id_A49938597B3587F0 = [];
  target._id_08C7ACCE8A4D9C2C = [];
}

_id_FFD6EED18C767472(_id_3AA36F65B47719D3, newtarget, _id_7B11FC99302D2789, _id_7B24D2E62B387965, _id_C313310EF3C37A7E) {
  if(!isDefined(_id_C313310EF3C37A7E))
    _id_C313310EF3C37A7E = (0, 0, 0);

  index = undefined;

  if(_id_C648F0FD527E089A(_id_7B11FC99302D2789))
    index = newtarget.index;
  else if(_id_D3789A9A4BE5DF2E(_id_7B11FC99302D2789))
    index = newtarget getentitynumber();
  else if(_id_7B11FC99302D2789 == 4)
    index = newtarget;

  _id_3AA36F65B47719D3._id_AD4F035F68AD85AD = _id_C313310EF3C37A7E;
  _id_3AA36F65B47719D3._id_B71B168E8ED463CE = index;
  _id_3AA36F65B47719D3._id_A7AA780BF65803D2 = _id_7B24D2E62B387965;

  if(isDefined(_id_3AA36F65B47719D3._id_08C7ACCE8A4D9C2C)) {
    foreach(entnumber, _id_394466C2DDB208CB in _id_3AA36F65B47719D3._id_08C7ACCE8A4D9C2C) {
      _id_93A0836A10E99C34 = undefined;

      if(isDefined(_id_3AA36F65B47719D3._id_A49938597B3587F0))
        _id_93A0836A10E99C34 = _id_3AA36F65B47719D3._id_A49938597B3587F0[entnumber];

      if(!isDefined(_id_93A0836A10E99C34) || _id_93A0836A10E99C34 calloutmarkerping_gettype(_id_394466C2DDB208CB) == 1) {
        continue;
      }
      _id_49CDEA45F60452C8(_id_93A0836A10E99C34, _id_394466C2DDB208CB, _id_3AA36F65B47719D3);
    }
  }
}

_id_C068EFDF0ABD5258(target) {
  target._id_AD4F035F68AD85AD = undefined;
  target._id_B71B168E8ED463CE = undefined;
  target._id_A7AA780BF65803D2 = undefined;
}

_id_1062F2AF5C7D843E(scriptablename, weaponobj) {
  player = self;
  scriptablename = tolower(scriptablename);
  _id_3EF0FDCEE94CADFF = "";

  if(isDefined(weaponobj)) {
    if(issubstr(scriptablename, "_me_riotshield"))
      _id_3EF0FDCEE94CADFF = "stat_D3338CED812BF832";
    else if(issubstr(scriptablename, "weapon_me") || issubstr(scriptablename, "_me_"))
      _id_3EF0FDCEE94CADFF = "stat_30380A30CFDA0E97";
    else if(issubstr(scriptablename, "weapon_dm") || issubstr(scriptablename, "_dm_"))
      _id_3EF0FDCEE94CADFF = "stat_C206FBB38234743C";
    else {
      switch (weaponclass(weaponobj.basename)) {
        case "rifle":
          _id_3EF0FDCEE94CADFF = "stat_7172C1F52346DD5E";
          break;
        case "smg":
          _id_3EF0FDCEE94CADFF = "stat_1BFCFDB323BEE2A2";
          break;
        case "spread":
          _id_3EF0FDCEE94CADFF = "stat_7FD9900FC3E72621";
          break;
        case "mg":
          _id_3EF0FDCEE94CADFF = "stat_06AF60B3A8E944DB";
          break;
        case "sniper":
          _id_3EF0FDCEE94CADFF = "stat_F487031D7CFA8CE2";
          break;
        case "rocketlauncher":
          _id_3EF0FDCEE94CADFF = "stat_213374FA019312ED";
          break;
        case "pistol":
          _id_3EF0FDCEE94CADFF = "stat_FC919071E35CBAFA";
          break;
      }
    }
  }

  if(_id_3EF0FDCEE94CADFF == "") {
    switch (scriptablename) {
      case "br_ammo_919":
        _id_3EF0FDCEE94CADFF = "stat_D86D80A3A22139AE";
        break;
      case "brloot_ammo_762":
        _id_3EF0FDCEE94CADFF = "stat_AEA59979B1F54A59";
        break;
      case "brloot_ammo_50cal":
        _id_3EF0FDCEE94CADFF = "stat_67ED261687481469";
        break;
      case "br_ammo_12g":
        _id_3EF0FDCEE94CADFF = "stat_0675C54D7F1E7F6F";
        break;
      case "br_ammo_rocket":
        _id_3EF0FDCEE94CADFF = "stat_0FAA320E6A2C6F1B";
        break;
      case "brloot_equip_iodine_pills":
        _id_3EF0FDCEE94CADFF = "stat_B50CA3477E505B16";
        break;
      case "brloot_dogtag_damascus":
      case "brloot_dogtag_gold":
      case "brloot_dogtag_silver":
      case "brloot_dogtag_bronze":
        _id_3EF0FDCEE94CADFF = "stat_B3E0E90B24BB67D4";
        break;
      case "brloot_offhand_shuriken":
      case "brloot_offhand_c4":
      case "brloot_offhand_throwingknife_fire":
      case "brloot_offhand_throwingknife":
      case "brloot_offhand_atmine":
      case "brloot_offhand_thermite":
      case "brloot_offhand_semtex":
      case "brloot_offhand_molotov":
      case "brloot_offhand_claymore":
      case "brloot_offhand_frag":
        _id_3EF0FDCEE94CADFF = "stat_6F2DD4DE8F85FD61";
        break;
      case "brloot_offhand_decoy":
      case "brloot_offhand_concussion":
      case "brloot_offhand_flash":
      case "brloot_offhand_smoke":
      case "brloot_offhand_snapshot":
      case "brloot_offhand_binoculars":
      case "brloot_offhand_gas":
      case "brloot_health_adrenaline":
        _id_3EF0FDCEE94CADFF = "stat_F39D4797A0C44BAE";
        break;
    }
  }

  if(_id_3EF0FDCEE94CADFF == "") {
    if(issubstr(scriptablename, "plunder_cash"))
      _id_3EF0FDCEE94CADFF = "stat_B4BAB207AE9179CB";
    else if(issubstr(scriptablename, "taccover") || issubstr(scriptablename, "trophy") || issubstr(scriptablename, "recondrone") || issubstr(scriptablename, "super") || issubstr(scriptablename, "balloon") || issubstr(scriptablename, "deployed_decoy"))
      _id_3EF0FDCEE94CADFF = "stat_D497FE78E69E0532";
    else if(issubstr(scriptablename, "access_card"))
      _id_3EF0FDCEE94CADFF = "stat_2A1DB9F9B686EC99";
    else if(issubstr(scriptablename, "loot_key") || issubstr(scriptablename, "loot_multi_key"))
      _id_3EF0FDCEE94CADFF = "stat_97FB4E55806DF5BF";
    else if(issubstr(scriptablename, "killstreak"))
      _id_3EF0FDCEE94CADFF = "stat_E893EF3B6D7C58A8";
    else if(issubstr(scriptablename, "valuable"))
      _id_3EF0FDCEE94CADFF = "stat_D9107ED89E7C5302";
    else if(issubstr(scriptablename, "_me_riotshield"))
      _id_3EF0FDCEE94CADFF = "stat_D3338CED812BF832";
    else if(issubstr(scriptablename, "weapon_me"))
      _id_3EF0FDCEE94CADFF = "stat_30380A30CFDA0E97";
    else if(issubstr(scriptablename, "weapon_dm"))
      _id_3EF0FDCEE94CADFF = "stat_C206FBB38234743C";
  }

  if(_id_3EF0FDCEE94CADFF != "") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound"))
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](player, _id_3EF0FDCEE94CADFF);
  }
}

_id_F956B46F8E151D30(_id_93A0836A10E99C34, _id_394466C2DDB208CB) {
  target = _id_B6CB97B6F81F0FD2(_id_93A0836A10E99C34, _id_394466C2DDB208CB);

  if(isDefined(target) && _id_49CDEA45F60452C8(_id_93A0836A10E99C34, _id_394466C2DDB208CB, target))
    return 1;

  return 0;
}

_id_49CDEA45F60452C8(_id_93A0836A10E99C34, _id_394466C2DDB208CB, _id_3AA36F65B47719D3) {
  if(isDefined(_id_3AA36F65B47719D3) && isDefined(_id_3AA36F65B47719D3._id_AD4F035F68AD85AD) && isDefined(_id_3AA36F65B47719D3._id_B71B168E8ED463CE) && isDefined(_id_3AA36F65B47719D3._id_A7AA780BF65803D2)) {
    _id_93A0836A10E99C34 calloutmarkerping_delete(_id_394466C2DDB208CB);
    _id_93A0836A10E99C34 calloutmarkerping_create(_id_3AA36F65B47719D3._id_A7AA780BF65803D2, _id_3AA36F65B47719D3._id_AD4F035F68AD85AD, _id_3AA36F65B47719D3._id_B71B168E8ED463CE);
    return 1;
  }

  return 0;
}

_id_A5747EB82EE7BB73(_id_93A0836A10E99C34, _id_394466C2DDB208CB) {
  target = _id_B6CB97B6F81F0FD2(_id_93A0836A10E99C34, _id_394466C2DDB208CB);

  if(!isDefined(target) || !isDefined(target._id_7B5E5C2BBC8F9F79))
    return 0;

  if(_id_93A0836A10E99C34 _meth_368AF07F7897FD79(4)) {
    _id_A7F6D4BE6B657D86 = _id_93A0836A10E99C34 _id_76ECF74C7D722B52(4);

    if(_id_93A0836A10E99C34 calloutmarkerping_getgscobjectiveindex(_id_A7F6D4BE6B657D86) == target._id_7B5E5C2BBC8F9F79) {
      _id_93A0836A10E99C34 calloutmarkerping_delete(_id_394466C2DDB208CB);
      _id_93A0836A10E99C34 calloutmarkerping_delete(_id_A7F6D4BE6B657D86);
      return 1;
    }
  }

  scriptable = _id_93A0836A10E99C34 calloutmarkerping_getEnt(_id_394466C2DDB208CB);
  _id_3EF0FDCEE94CADFF = _id_93A0836A10E99C34 _id_F9AA0F44521459D7(_id_394466C2DDB208CB, scriptable);
  _id_93A0836A10E99C34 calloutmarkerpingvo_play(_id_3EF0FDCEE94CADFF, _id_394466C2DDB208CB, undefined, target);
  _id_93A0836A10E99C34 calloutmarkerping_delete(_id_394466C2DDB208CB);
  _id_BD1E08E0A832E094 = _id_93A0836A10E99C34 calloutmarkerping_create(11, target.origin, target._id_7B5E5C2BBC8F9F79);
  return 1;
}

_id_0CAADD21A226BF96(_id_93A0836A10E99C34, _id_394466C2DDB208CB) {
  target = _id_B6CB97B6F81F0FD2(_id_93A0836A10E99C34, _id_394466C2DDB208CB);

  if(isDefined(target) && isDefined(target._id_A49938597B3587F0) && isDefined(target._id_08C7ACCE8A4D9C2C)) {
    if(!isDefined(_id_93A0836A10E99C34._id_74C9B4D7A9D4EC62))
      _id_93A0836A10E99C34._id_74C9B4D7A9D4EC62 = [];

    _id_93A0836A10E99C34._id_74C9B4D7A9D4EC62[_id_394466C2DDB208CB] = target;
    target._id_A49938597B3587F0[_id_93A0836A10E99C34 getentitynumber()] = _id_93A0836A10E99C34;
    target._id_08C7ACCE8A4D9C2C[_id_93A0836A10E99C34 getentitynumber()] = _id_394466C2DDB208CB;
  }
}

_id_8C4B1D9591DC12AB(_id_93A0836A10E99C34) {
  for(_id_394466C2DDB208CB = 0; _id_394466C2DDB208CB < 21; _id_394466C2DDB208CB++) {
    if(_id_93A0836A10E99C34 calloutmarkerping_getactive(_id_394466C2DDB208CB))
      _id_EC3FEDCB7195CFD7(_id_93A0836A10E99C34, _id_394466C2DDB208CB);
  }
}

_id_EC3FEDCB7195CFD7(_id_93A0836A10E99C34, _id_394466C2DDB208CB) {
  target = undefined;

  if(isDefined(_id_93A0836A10E99C34._id_74C9B4D7A9D4EC62)) {
    target = _id_93A0836A10E99C34._id_74C9B4D7A9D4EC62[_id_394466C2DDB208CB];
    _id_93A0836A10E99C34._id_74C9B4D7A9D4EC62[_id_394466C2DDB208CB] = undefined;
  }

  if(isDefined(target) && isDefined(target._id_A49938597B3587F0) && isDefined(target._id_08C7ACCE8A4D9C2C)) {
    target._id_A49938597B3587F0[_id_93A0836A10E99C34 getentitynumber()] = undefined;
    target._id_08C7ACCE8A4D9C2C[_id_93A0836A10E99C34 getentitynumber()] = undefined;
  }
}

_id_B6CB97B6F81F0FD2(_id_93A0836A10E99C34, _id_394466C2DDB208CB) {
  _id_A1823E6B1CB4B46D = _id_93A0836A10E99C34 calloutmarkerping_gettype(_id_394466C2DDB208CB);
  target = undefined;

  if(_id_C648F0FD527E089A(_id_A1823E6B1CB4B46D) || _id_D3789A9A4BE5DF2E(_id_A1823E6B1CB4B46D))
    target = _id_93A0836A10E99C34 calloutmarkerping_getEnt(_id_394466C2DDB208CB);

  if(isDefined(target) && isDefined(target.entity))
    target = target.entity;

  return target;
}

_id_53EBC25DCFE48D00(player, objid) {
  if(!_id_A23877559A8E22E8())
    return 1;

  if(!isDefined(level.objectives))
    return 1;

  currentobjective = undefined;

  foreach(objective in level.objectives) {
    if(isDefined(objective.objidnum) && objective.objidnum == objid) {
      currentobjective = objective;
      break;
    }
  }

  if(!isDefined(currentobjective))
    return 1;

  return isDefined(currentobjective.touchlist) && isDefined(currentobjective.touchlist[player.team]) && currentobjective.touchlist[player.team].size > 0;
}

_id_A23877559A8E22E8() {
  if(!isDefined(level.gametype))
    return 0;

  gametype = level.gametype;
  return gametype == "dom" || gametype == "koth" || gametype == "grnd" || gametype == "gwai" || gametype == "hq";
}

_id_6641A5B759148E1B() {
  _id_52C2A04795D4AE72 = scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508();
  _id_FAF0D2FAC3F47583 = scripts\engine\utility::ter_op(_id_52C2A04795D4AE72, getDvar("dvar_7611A2790A0BF7FE", ""), "");
  return _id_FAF0D2FAC3F47583 == "dmz";
}
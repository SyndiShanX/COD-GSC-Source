/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\grnd.gsc
***********************************************/

main() {
  if(getDvar("g_mapname") == "mp_background") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  _id_9BBACB179DEA3237[0] = scripts\mp\utility\game::getgametype();
  _id_9BBACB179DEA3237[1] = "dz_flare";
  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 600);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 7500);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  updategametypedvars();
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.getspawnpoint = ::getspawnpoint;
  level.modeonspawnplayer = ::onspawnplayer;
  level.onplayerkilled = _id_734EA6311B19A424::onplayerkilled;
  level.onrespawndelay = _id_734EA6311B19A424::getrespawndelay;
  level.nosuspensemusic = 1;

  if(_id_2C3C990BA58FA6F5::_id_5A758C8D306F92ED())
    level._id_571986D5B745A9D7 = ::_id_C6FB408CE40374FA;

  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    game["dialog"]["gametype"] = "iw9_dpzn_mode_uktl_dzt1";
  else
    game["dialog"]["gametype"] = "iw9_dpzn_mode_uktl_dznm";

  game["dialog"]["offense_obj"] = "iw9_dpzn_mode_uktl_dzbo";
  game["dialog"]["defense_obj"] = "iw9_dpzn_mode_uktl_dzbo";
  game["dialog"]["hp_new_location"] = "iw9_dpzn_mode_uktl_dznl";
  game["dialog"]["hp_captured_enemy"] = "iw9_dpzn_mode_uktl_dzcb";
  game["dialog"]["hp_captured_friendly"] = "iw9_dpzn_mode_uktl_dzca";
  game["dialog"]["hp_contested"] = "iw9_dpzn_mode_uktl_dzcn";
  game["dialog"]["hp_move_soon"] = "iw9_dpzn_mode_uktl_dzms";
  game["dialog"]["hp_capturing_enemy"] = "iw9_dpzn_mode_uktl_dzcd";
  game["dialog"]["hp_capturing_friendly"] = "iw9_dpzn_mode_uktl_dzcc";
  setomnvar("ui_hq_status", -1);
  setomnvar("ui_hq_num_alive", 0);
  setomnvar("ui_hq_ownerteam", -1);
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_grnd_droptime", getmatchrulesdata("grndData", "dropTime"));
  setdynamicdvar("scr_grnd_enablevariantdz", getmatchrulesdata("grndData", "enableVariantDZ"));
  setdynamicdvar("scr_grnd_zonelifetime", getmatchrulesdata("kothData", "zoneLifetime"));
  setdynamicdvar("scr_grnd_zonecapturetime", getmatchrulesdata("kothData", "zoneCaptureTime"));
  setdynamicdvar("scr_grnd_firstzoneactivationdelay", getmatchrulesdata("kothData", "firstZoneActivationDelay"));
  setdynamicdvar("scr_grnd_zoneactivationdelay", getmatchrulesdata("kothData", "zoneActivationDelay"));
  setdynamicdvar("scr_grnd_randomlocationorder", getmatchrulesdata("kothData", "randomLocationOrder"));
  setdynamicdvar("scr_grnd_additivescoring", getmatchrulesdata("kothData", "additiveScoring"));
  setdynamicdvar("scr_grnd_pausetime", getmatchrulesdata("kothData", "pauseTime"));
  setdynamicdvar("scr_grnd_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("grnd", 0);
  setdynamicdvar("scr_grnd_promode", 0);
}

onstartgametype() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  foreach(_id_F90358454413407F in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(_id_F90358454413407F, &"OBJECTIVES/GRND");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/GRND");
    else
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/GRND_SCORE");

    scripts\mp\utility\game::setobjectivehinttext(_id_F90358454413407F, &"OBJECTIVES/DOM_HINT");
  }

  level thread setupzones();
  setmapsizespawnconsts();
  initspawns();
  level thread dzmainloop();

  if(level.droptime > 0)
    level thread randomdrops();
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
  level.droptime = scripts\mp\utility\dvars::dvarfloatvalue("dropTime", 15, 0, 60);
  level.zoneduration = scripts\mp\utility\dvars::dvarfloatvalue("zoneLifetime", 60, 0, 300);
  level.zonecapturetime = scripts\mp\utility\dvars::dvarfloatvalue("zoneCaptureTime", 0, 0, 30);
  level.firstzoneactivationdelay = scripts\mp\utility\dvars::dvarfloatvalue("firstZoneActivationDelay", 30, 0, 120);
  level.zoneactivationdelay = scripts\mp\utility\dvars::dvarfloatvalue("zoneActivationDelay", 30, 0, 120);
  level.zonerandomlocationorder = scripts\mp\utility\dvars::dvarintvalue("randomLocationOrder", 0, 0, 1);
  level.zoneadditivescoring = scripts\mp\utility\dvars::dvarintvalue("additiveScoring", 0, 0, 1);
  level.pausemodetimer = scripts\mp\utility\dvars::dvarintvalue("pauseTime", 1, 0, 1);
  level.enablevariantdrops = scripts\mp\utility\dvars::dvarintvalue("enableVariantDZ", 0, 0, 1);

  if(scripts\mp\utility\game::matchmakinggame() && !scripts\mp\utility\game::isanymlgmatch() && getdvarint("dvar_56937A1BD450393D", 15) != 0)
    level.zoneactivationdelay = adjustzoneactivationdelayforlargemaps();
}

adjustzoneactivationdelayforlargemaps() {
  mapname = scripts\cp_mp\utility\game_utility::getmapname();

  switch (mapname) {
    case "mp_euphrates":
    case "mp_deadzone":
    case "mp_raid":
      return getdvarint("dvar_56937A1BD450393D", 15);
    case "mp_aniyah":
      return getdvarint("dvar_56937A1BD450393D", 15) + 15;
    default:
      return level.zoneactivationdelay;
  }
}

setmapsizespawnconsts() {
  _id_2C738D41732AD7CB = getsubstr(level.mapname, 0, 7);

  switch (_id_2C738D41732AD7CB) {
    case "mp_aniyah":
      level.spawn_deadzone_dist = 1000;
      level.close_spawn_min_dist_sq = 10000;
      level.max_spawn_dist_sq = 225000000;
      level.max_relevant_spawn_dist = 7000;
      level.enemy_spawn_influence_dist_sq = 12250000;
      break;
    case "mp_shipment":
      level.spawn_deadzone_dist = 500;
      level.close_spawn_min_dist_sq = 10000;
      level.max_spawn_dist_sq = 25000000;
      level.max_relevant_spawn_dist = 6000;
      level.enemy_spawn_influence_dist_sq = 12250000;
      break;
    default:
      level.spawn_deadzone_dist = 1000;
      level.close_spawn_min_dist_sq = 10000;
      level.max_spawn_dist_sq = 25000000;
      level.max_relevant_spawn_dist = 6000;
      level.enemy_spawn_influence_dist_sq = 12250000;
      break;
  }
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default", 1);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_tdm_spawn_axis_start");
  attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_allies_start");
  _id_2FD93EA689E77097 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", attackers);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", _id_2FD93EA689E77097);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::registerspawnset("normal", "mp_tdm_spawn");
  scripts\mp\spawnlogic::registerspawnset("fallback", "mp_tdm_spawn_secondary");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  enablespawnpointsbyclassname("mp_tdm_spawn");
  level.spawnpoints = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");

  if(!level.spawnpoints.size) {
    return;
  }
  foreach(zone in level.objectives) {
    zone.furthestspawndistsq = 0;
    zone.spawnpoints = [];
    zone.fallbackspawnpoints = [];
  }

  foreach(spawnpoint in level.spawnpoints) {
    calculatespawndisttozones(spawnpoint);
    _id_F2D96DD81CF63446 = scripts\mp\spawnlogic::getoriginidentifierstring(spawnpoint);

    if(isDefined(level.grndextraprimaryspawnpoints) && isDefined(level.grndextraprimaryspawnpoints[_id_F2D96DD81CF63446])) {
      foreach(_id_FE02B20F9AC0BD11 in level.grndextraprimaryspawnpoints[_id_F2D96DD81CF63446]) {
        zone = level.objectives[_id_FE02B20F9AC0BD11];
        zone.spawnpoints[zone.spawnpoints.size] = spawnpoint;
      }
    }

    _id_BA992CB19CB03B0C = 0;
    _id_47D8F0FD833CA536 = spawnpoint.classname == "mp_tdm_spawn_allies_start" || spawnpoint.classname == "mp_tdm_spawn_axis_start";
    _id_9967FE9B58EEFAFD = spawnpoint.classname == "mp_tdm_spawn";
    _id_A46D96B282D563E7 = spawnpoint.classname == "mp_tdm_spawn_secondary";

    if(_id_47D8F0FD833CA536) {
      continue;
    }
    if(_id_9967FE9B58EEFAFD || _id_A46D96B282D563E7) {
      if(isDefined(spawnpoint.script_noteworthy) && spawnpoint.script_noteworthy != "") {
        _id_BA992CB19CB03B0C = 1;
        _id_AA5C00F4CC732317 = strtok(spawnpoint.script_noteworthy, " ");

        foreach(_id_FE02B20F9AC0BD11 in _id_AA5C00F4CC732317) {
          zone = level.objectives[_id_FE02B20F9AC0BD11];

          if(_id_9967FE9B58EEFAFD) {
            zone.spawnpoints[zone.spawnpoints.size] = spawnpoint;
            continue;
          }

          zone.fallbackspawnpoints[zone.fallbackspawnpoints.size] = spawnpoint;
        }
      }
    }

    calculatespawndisttozones(spawnpoint);

    if(!_id_BA992CB19CB03B0C) {
      foreach(zone in level.objectives) {
        if(spawnpoint.scriptdata.distsqtokothzones[zone.trigger getentitynumber()] < level.close_spawn_min_dist_sq || spawnpoint.scriptdata.distsqtokothzones[zone.trigger getentitynumber()] > level.max_spawn_dist_sq)
          spawnpoint.removespawn = 1;

        if(_id_9967FE9B58EEFAFD) {
          if(!isDefined(spawnpoint.removespawn))
            zone.spawnpoints[zone.spawnpoints.size] = spawnpoint;
        } else
          zone.fallbackspawnpoints[zone.fallbackspawnpoints.size] = spawnpoint;

        spawnpoint.removespawn = undefined;
      }
    }
  }

  foreach(objid, zone in level.objectives) {
    zone.spawnset = "dropzone_" + objid;
    scripts\mp\spawnlogic::registerspawnset(zone.spawnset, zone.spawnpoints);
    zone.fallbackspawnset = "dropzone_fallback_" + objid;
    scripts\mp\spawnlogic::registerspawnset(zone.fallbackspawnset, zone.fallbackspawnpoints);
  }
}

calculatespawndisttozones(spawnpoint, _id_AA5C00F4CC732317) {
  spawnpoint.scriptdata.distsqtokothzones = [];

  foreach(zone in level.objectives) {
    dist = getpathdist(spawnpoint.origin, zone.origin, level.max_relevant_spawn_dist);

    if(dist < 0)
      dist = scripts\engine\utility::distance_2d_squared(spawnpoint.origin, zone.origin);
    else
      dist = dist * dist;

    spawnpoint.scriptdata.distsqtokothzones[zone.trigger getentitynumber()] = dist;

    if(dist > zone.furthestspawndistsq)
      zone.furthestspawndistsq = dist;
  }
}

comparezoneindexes(_id_5DB62A28BB57C137, _id_5DB62B28BB57C36A) {
  _id_DED9A2A5BE6D47D9 = int(_id_5DB62A28BB57C137.objectivekey);
  _id_DED99FA5BE6D4140 = int(_id_5DB62B28BB57C36A.objectivekey);

  if(!isDefined(_id_DED9A2A5BE6D47D9) && !isDefined(_id_DED99FA5BE6D4140))
    return 0;

  if(!isDefined(_id_DED9A2A5BE6D47D9) && isDefined(_id_DED99FA5BE6D4140))
    return 1;

  if(isDefined(_id_DED9A2A5BE6D47D9) && !isDefined(_id_DED99FA5BE6D4140))
    return 0;

  if(_id_DED9A2A5BE6D47D9 > _id_DED99FA5BE6D4140)
    return 1;

  return 0;
}

getzonearray(targetname) {
  zones = getEntArray(targetname, "targetname");

  foreach(z in zones)
  z.objectivekey = z.script_label;

  if(!isDefined(zones) || zones.size == 0)
    return undefined;

  _id_FCB8575B464D3877 = 1;

  for(n = zones.size; _id_FCB8575B464D3877; n--) {
    _id_FCB8575B464D3877 = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < n - 1; _id_AC0E594AC96AA3A8++) {
      if(comparezoneindexes(zones[_id_AC0E594AC96AA3A8], zones[_id_AC0E594AC96AA3A8 + 1])) {
        temp = zones[_id_AC0E594AC96AA3A8];
        zones[_id_AC0E594AC96AA3A8] = zones[_id_AC0E594AC96AA3A8 + 1];
        zones[_id_AC0E594AC96AA3A8 + 1] = temp;
        _id_FCB8575B464D3877 = 1;
      }
    }
  }

  return zones;
}

setupzones() {
  _id_261D73DEE9F7F35C = getzonearray("grnd");

  if(level.mapname == "mp_piccadilly") {
    foreach(trig in _id_261D73DEE9F7F35C) {
      if(distance(trig.origin, (-1547, -1512, 165)) < 10)
        trig.origin = trig.origin - (0, 0, 10);
    }
  } else if(level.mapname == "mp_aniyah") {
    foreach(trig in _id_261D73DEE9F7F35C) {
      if(distance(trig.origin, (-1117, 2295, 398)) < 10) {
        trig.origin = trig.origin - (0, 0, 10);
        continue;
      }

      if(distance(trig.origin, (-4501, -2, 322)) < 10) {
        trig.script_label = "9";
        continue;
      }

      if(distance(trig.origin, (-4474, 1159, 388)) < 10)
        trig.origin = trig.origin - (0, 0, 20);
    }
  } else if(level.mapname == "mp_arn_zone1") {
    foreach(trig in _id_261D73DEE9F7F35C) {
      if(trig.script_label == "4")
        trig.origin = trig.origin + (-12, 668, -30);
    }
  }

  _id_46CE466CCA5FCAFE = [];
  flares = scripts\engine\utility::getStructArray("dz_flare", "targetname");

  if(level.mapname == "mp_shipment") {
    _id_49E04F87F5702F8C = [];

    foreach(trig in _id_261D73DEE9F7F35C) {
      if(trig.script_label == "1" && distance(trig.origin, (-333, 1999, 119)) < 5) {
        _id_49E04F87F5702F8C[_id_49E04F87F5702F8C.size] = trig;
        continue;
      }

      if(trig.script_label == "2" && distance(trig.origin, (189, 1564, 75)) < 5) {
        _id_49E04F87F5702F8C[_id_49E04F87F5702F8C.size] = trig;
        continue;
      }

      if(trig.script_label == "3" && distance(trig.origin, (-751, 2416, 81)) < 5) {
        _id_49E04F87F5702F8C[_id_49E04F87F5702F8C.size] = trig;
        continue;
      }

      if(trig.script_label == "4" && distance(trig.origin, (165, 2420, 79)) < 5) {
        _id_49E04F87F5702F8C[_id_49E04F87F5702F8C.size] = trig;
        continue;
      }

      if(trig.script_label == "5" && distance(trig.origin, (-823, 1536, 68)) < 5)
        _id_49E04F87F5702F8C[_id_49E04F87F5702F8C.size] = trig;
    }

    _id_261D73DEE9F7F35C = scripts\engine\utility::array_remove_array(_id_261D73DEE9F7F35C, _id_49E04F87F5702F8C);
    _id_E3FD9580BC3ADA40 = [];

    foreach(flare in flares) {
      if(distance(flare.origin, (192.944, 1583.51, 16.344)) < 5) {
        _id_E3FD9580BC3ADA40[_id_E3FD9580BC3ADA40.size] = flare;
        continue;
      }

      if(distance(flare.origin, (-743.056, 2447.51, 17.844)) < 5) {
        _id_E3FD9580BC3ADA40[_id_E3FD9580BC3ADA40.size] = flare;
        continue;
      }

      if(distance(flare.origin, (152.944, 2415.51, 16.344)) < 5) {
        _id_E3FD9580BC3ADA40[_id_E3FD9580BC3ADA40.size] = flare;
        continue;
      }

      if(distance(flare.origin, (-334.5, 1990.5, 17.25)) < 5) {
        _id_E3FD9580BC3ADA40[_id_E3FD9580BC3ADA40.size] = flare;
        continue;
      }

      if(distance(flare.origin, (-751.056, 1479.51, 16.844)) < 5)
        _id_E3FD9580BC3ADA40[_id_E3FD9580BC3ADA40.size] = flare;
    }

    flares = scripts\engine\utility::array_remove_array(flares, _id_E3FD9580BC3ADA40);
  } else if(issubstr(level.mapname, "mp_catedral")) {
    _id_50EFABB169380F2E = [];

    foreach(trig in _id_261D73DEE9F7F35C) {
      groundpos = scripts\engine\utility::drop_to_ground(trig.origin, 100);
      radius = 128;
      _id_8D213E19BB3A154A = undefined;

      switch (trig.script_label) {
        case "1":
          radius = 210;
          break;
        case "2":
          radius = 295;
          break;
        case "3":
          radius = 225;
          break;
        case "4":
          radius = 200;
          _id_8D213E19BB3A154A = 100;
          break;
        case "5":
          radius = 345;
          break;
      }

      _id_8DC27038D8FFE723 = spawn("trigger_radius", groundpos, 0, radius, 128);
      _id_8DC27038D8FFE723.script_label = trig.script_label;
      _id_8DC27038D8FFE723.script_gameobjectname = trig.script_gameobjectname;
      _id_8DC27038D8FFE723.targetname = trig.targetname;
      _id_8DC27038D8FFE723._id_8D213E19BB3A154A = scripts\engine\utility::ter_op(isDefined(_id_8D213E19BB3A154A), _id_8D213E19BB3A154A, radius);
      _id_50EFABB169380F2E[_id_50EFABB169380F2E.size] = _id_8DC27038D8FFE723;
    }

    _id_261D73DEE9F7F35C = _id_50EFABB169380F2E;
  } else if(level.mapname == "mp_crossing") {
    _id_50EFABB169380F2E = [];

    foreach(trig in _id_261D73DEE9F7F35C) {
      groundpos = scripts\engine\utility::drop_to_ground(trig.origin, 100);
      radius = 128;
      _id_8D213E19BB3A154A = undefined;

      switch (trig.script_label) {
        case "1":
          radius = 215;
          break;
        case "2":
          radius = 190;
          break;
        case "3":
          radius = 350;
          break;
        case "4":
          radius = 350;
          break;
        case "5":
          radius = 350;
          break;
      }

      _id_8DC27038D8FFE723 = spawn("trigger_radius", groundpos, 0, radius, 128);
      _id_8DC27038D8FFE723.script_label = trig.script_label;
      _id_8DC27038D8FFE723.script_gameobjectname = trig.script_gameobjectname;
      _id_8DC27038D8FFE723.targetname = trig.targetname;
      _id_8DC27038D8FFE723._id_8D213E19BB3A154A = scripts\engine\utility::ter_op(isDefined(_id_8D213E19BB3A154A), _id_8D213E19BB3A154A, radius);
      _id_50EFABB169380F2E[_id_50EFABB169380F2E.size] = _id_8DC27038D8FFE723;
    }

    _id_261D73DEE9F7F35C = _id_50EFABB169380F2E;
  } else if(level.mapname == "mp_arn_zone1") {
    foreach(flare in flares) {
      if(distancesquared(flare.origin, (1328, -968, 57.25)) < 25)
        flare.origin = flare.origin + (-12, 668, -30);
    }
  }

  foreach(flare in flares) {
    groundpos = scripts\engine\utility::drop_to_ground(flare.origin, 100) + (0, 0, 1.25);
    scriptable = spawn("script_model", groundpos);
    scriptable.angles = flare.angles;
    scriptable setModel("dz_flare_scriptable");
    flare.scriptable = scriptable;
  }

  visuals = [];
  level.objectives = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < flares.size; _id_AC0E594AC96AA3A8++) {
    _id_28DB8BB739011E7C = 0;
    flare = flares[_id_AC0E594AC96AA3A8];
    trig = undefined;

    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_261D73DEE9F7F35C.size; _id_AC0E5C4AC96AAA41++) {
      if(flare.scriptable istouching(_id_261D73DEE9F7F35C[_id_AC0E5C4AC96AAA41])) {
        if(isDefined(trig)) {
          _id_46CE466CCA5FCAFE[_id_46CE466CCA5FCAFE.size] = "flare at " + flare.origin + " is touching more than one \"flaretrigger\" trigger";
          _id_28DB8BB739011E7C = 1;
          break;
        }

        trig = _id_261D73DEE9F7F35C[_id_AC0E5C4AC96AAA41];
        break;
      }
    }

    if(!isDefined(trig)) {
      if(!_id_28DB8BB739011E7C) {
        _id_46CE466CCA5FCAFE[_id_46CE466CCA5FCAFE.size] = "flare at " + flare.origin + " is not inside any \"flaretrigger\" trigger";
        continue;
      }
    }

    visuals = [];
    visuals[0] = flare.scriptable;
    zone = _id_1B18A05A284D55C2::setupobjective(trig, visuals);
    zone.origin = trig.origin;
    zone.offset3d = (0, 0, 120);
    level.objectives[zone.objectivekey] = zone;
  }

  if(_id_46CE466CCA5FCAFE.size > 0) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_46CE466CCA5FCAFE.size; _id_AC0E594AC96AA3A8++) {}
  } else {}
}

dzmainloop() {
  level endon("game_ended");
  seticonnames();
  initwaypointicons();
  setomnvar("ui_objective_timer_stopped", 1);
  setomnvar("ui_hardpoint_timer", 0);
  level.zone = getfirstzone();
  _id_2AFAF68657598B47 = 1;
  level.kothhillrotation = 0;

  if(!scripts\mp\flags::gameflag("prematch_done"))
    level scripts\engine\utility::waittill_any_2("prematch_done", "start_mode_setup");

  level.zone _id_1B18A05A284D55C2::activatezone();
  level.favorclosespawnent = level.zone;
  level.zone.active = 1;
  level.zone scripts\mp\gameobjects::setvisibleteam("any");
  level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
  _id_7E2C53B0BCF117D9 = spawnStruct();
  _id_7E2C53B0BCF117D9.player = level.zone;
  _id_7E2C53B0BCF117D9.eventname = "hill_moved";
  _id_7E2C53B0BCF117D9.position = level.zone.trigger.origin;
  _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_game_event", _id_7E2C53B0BCF117D9);
  scripts\mp\flags::gameflagwait("prematch_done");
  setomnvar("ui_objective_timer_stopped", 0);
  _id_570BA02607C0425C = 0;

  if(level.firstzoneactivationdelay) {
    _id_570BA02607C0425C = 1;
    level.zoneendtime = int(gettime() + level.firstzoneactivationdelay * 1000);
    setomnvar("ui_hardpoint_timer", level.zoneendtime);
    setomnvar("ui_hq_status", 6);
    level.zoneislocked = 1;
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, "dz_control", "dz_control");
    level.zone thread scripts\mp\gameobjects::_id_D36DCACAC1708708(level.firstzoneactivationdelay);
    wait(level.firstzoneactivationdelay);
    level.zoneislocked = 0;
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, "dz_capture", "dz_capture");
  }

  scripts\mp\utility\sound::playsoundonplayers("mp_dropzone_obj_new");

  for(;;) {
    level.zone.visuals[0] setscriptablepartstate("smoke", "idle", 0);
    level.objectivesetorder = 1;
    waittillframeend;
    level.zone scripts\mp\gameobjects::enableobject();
    level.zone.capturecount = 0;

    if(level.codcasterenabled)
      level.zone thread _id_1B18A05A284D55C2::trackgametypevips();

    scripts\mp\spawnlogic::clearlastteamspawns();
    hqactivatenextzone(_id_570BA02607C0425C, _id_2AFAF68657598B47);
    _id_2AFAF68657598B47 = 0;
    _id_570BA02607C0425C = 0;
    setomnvar("ui_hq_status", 8);
    scripts\mp\spawnlogic::clearlastteamspawns();
    hpcaptureloop();
    ownerteam = level.zone scripts\mp\gameobjects::getownerteam();

    if(level.pausemodetimer)
      level scripts\mp\gamelogic::resumetimer();

    level.lastcaptureteam = undefined;
    level.zone.active = 0;

    if(istrue(level.usehpzonebrushes)) {
      foreach(player in level.players)
      level.zone _id_1B18A05A284D55C2::hideplayerspecificbrushes(player);
    }

    level.zone scripts\mp\gameobjects::disableobject();
    level.zone scripts\mp\gameobjects::allowuse("none");
    level.zone scripts\mp\gameobjects::setownerteam("neutral");
    updateservericons("zone_shift", 0);
    level notify("zone_reset");
    setomnvar("ui_hq_status", -1);
    spawn_next_zone();

    if(scripts\mp\utility\game::getgametype() == "grnd" && level.kothhillrotation == 4) {}

    setomnvar("ui_hq_status", -1);
    wait 1;
  }
}

getfirstzone() {
  if(level.mapname == "mp_hardhat") {
    zone = level.objectives["5"];
    level.prevzoneindex = 5;
  } else {
    zone = level.objectives["1"];
    level.prevzoneindex = 1;
  }

  return zone;
}

getnextzone() {
  if(level.zonerandomlocationorder) {
    _id_BCADDA10E825A297 = [];

    foreach(_id_F90358454413407F in level.teamnamelist)
    _id_BCADDA10E825A297[_id_F90358454413407F] = (0, 0, 0);

    _id_CFD9FB898B8A8FDE = scripts\mp\utility\game::getpotentiallivingplayers();

    foreach(player in _id_CFD9FB898B8A8FDE) {
      if(player.team == "spectator") {
        continue;
      }
      _id_BCADDA10E825A297[player.team] = _id_BCADDA10E825A297[player.team] + player.origin;
    }

    _id_F95FEB63C772E28F = [];

    foreach(_id_F90358454413407F in level.teamnamelist) {
      players = scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "players");
      _id_0774C9CA5D1D6221 = max(players.size, 1);
      _id_F95FEB63C772E28F[_id_F90358454413407F] = _id_BCADDA10E825A297[_id_F90358454413407F] / _id_0774C9CA5D1D6221;
    }

    if(!isDefined(level.prevzonelist) || isDefined(level.prevzonelist) && level.prevzonelist.size == level.objectives.size - 1)
      level.prevzonelist = [];

    level.prevzonelist[level.prevzonelist.size] = level.prevzoneindex;
    _id_C5746701A936226C = 0.7;
    _id_1062B157C642E6B7 = 0.3;
    _id_36710543FBAA2AAF = undefined;
    _id_094CCBA012B7736A = undefined;

    foreach(objective in level.objectives) {
      _id_887D42B1410C39FE = 0;

      foreach(_id_FE02B20F9AC0BD11 in level.prevzonelist) {
        if(objective.objectivekey == scripts\engine\utility::string(_id_FE02B20F9AC0BD11)) {
          _id_887D42B1410C39FE = 1;
          break;
        }
      }

      if(_id_887D42B1410C39FE) {
        continue;
      }
      zone = objective;
      _id_4E58252555A3ACA1 = 0;

      foreach(_id_F90358454413407F in level.teamnamelist)
      _id_4E58252555A3ACA1 = _id_4E58252555A3ACA1 + distance2dsquared(zone.curorigin, _id_F95FEB63C772E28F[_id_F90358454413407F]);

      _id_5A8B9D38B749DAE2 = distance2dsquared(zone.curorigin, level.zone.curorigin);
      _id_D552C16ABF741BF4 = _id_4E58252555A3ACA1 * _id_C5746701A936226C + _id_5A8B9D38B749DAE2 * _id_1062B157C642E6B7;

      if(!isDefined(_id_094CCBA012B7736A) || _id_D552C16ABF741BF4 > _id_094CCBA012B7736A) {
        _id_094CCBA012B7736A = _id_D552C16ABF741BF4;
        _id_36710543FBAA2AAF = objective.objectivekey;
      }
    }

    zone = level.objectives[_id_36710543FBAA2AAF];
    level.prevzoneindex = _id_36710543FBAA2AAF;
  } else {
    level.prevzoneindex++;

    if(level.prevzoneindex > level.objectives.size)
      level.prevzoneindex = 1;

    zone = level.objectives[scripts\engine\utility::string(level.prevzoneindex)];
  }

  return zone;
}

spawn_next_zone() {
  writecurrentrotationteamscore();
  level.zone.visuals[0] setscriptablepartstate("smoke", "off", 0);
  level.zone _id_1B18A05A284D55C2::deactivatezone();
  level.zone = getnextzone();
  level.kothhillrotation++;
  level.zone _id_1B18A05A284D55C2::activatezone();
  level.favorclosespawnent = level.zone;
  level.zone.active = 1;
  level.zone.lastactivatetime = gettime();

  if(level.zoneactivationdelay > 0)
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
  else
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);

  _id_7E2C53B0BCF117D9 = spawnStruct();
  _id_7E2C53B0BCF117D9.player = level.zone;
  _id_7E2C53B0BCF117D9.eventname = "hill_moved";
  _id_7E2C53B0BCF117D9.position = level.zone.trigger.origin;
  _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_game_event", _id_7E2C53B0BCF117D9);
}

hqactivatenextzone(_id_570BA02607C0425C, _id_2AFAF68657598B47) {
  if(_id_2AFAF68657598B47) {
    foreach(_id_F90358454413407F in level.teamnamelist)
    scripts\mp\utility\dialog::statusdialog("obj_generic_capture", _id_F90358454413407F);
  } else {
    foreach(_id_F90358454413407F in level.teamnamelist)
    scripts\mp\utility\dialog::statusdialog("hp_new_location", _id_F90358454413407F);
  }

  scripts\mp\utility\sound::playsoundonplayers("mp_dropzone_obj_new");
  level.zone thread _id_1B18A05A284D55C2::hardpoint_setneutral();
  level.zone scripts\mp\gameobjects::allowuse("none");

  if(istrue(_id_570BA02607C0425C)) {} else if(level.zoneactivationdelay) {
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
    updateservericons("zone_activation_delay", 0);
    level.zoneendtime = int(gettime() + 1000 * level.zoneactivationdelay);
    setomnvar("ui_hardpoint_timer", level.zoneendtime);
    setomnvar("ui_hq_status", 6);
    level.zoneislocked = 1;
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, "dz_control", "dz_control");
    level.zone thread scripts\mp\gameobjects::_id_D36DCACAC1708708(level.zoneactivationdelay);
    wait(level.zoneactivationdelay);
    level.zoneislocked = 0;
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, "dz_capture", "dz_capture");
  }

  level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
  updateservericons("neutral", 0);

  if(level.zoneduration) {
    updateservericons("neutral", 0);
    thread movezoneaftertime(level.zoneduration);
    level.zoneendtime = int(gettime() + 1000 * level.zoneduration);
    setomnvar("ui_hardpoint_timer", level.zoneendtime);
  } else
    level.zonedestroyedbytimer = 0;
}

locktimeruntilcap() {
  level endon("zone_captured");

  for(;;) {
    level.zoneendtime = int(gettime() + 1000 * level.zoneduration);
    setomnvar("ui_hardpoint_timer", level.zoneendtime);
    waitframe();
  }
}

hpcaptureloop() {
  level endon("game_ended");
  level endon("zone_moved");
  level.hpstarttime = gettime();

  for(;;) {
    level.zone scripts\mp\gameobjects::allowuse("enemy");
    level.zone scripts\mp\gameobjects::setvisibleteam("any");
    level.zone scripts\mp\gameobjects::setusetext(&"MP/SECURING_POSITION");
    level.zone thread _id_1B18A05A284D55C2::hardpoint_setneutral();
    level.zone scripts\mp\gameobjects::cancontestclaim(1);

    if(isDefined(level.matchrules_droptime) && level.matchrules_droptime)
      level thread randomdrops();

    msg = level scripts\engine\utility::waittill_any_return_2("zone_captured", "zone_destroyed");

    if(msg == "zone_destroyed") {
      continue;
    }
    ownerteam = level.zone scripts\mp\gameobjects::getownerteam();
    scripts\mp\utility\sound::playsoundonplayers("mp_dropzone_captured_positive", ownerteam);
    scripts\mp\utility\sound::playsoundonplayers("mp_dropzone_captured_negative", scripts\mp\utility\game::getotherteam(ownerteam)[0]);
    thread scripts\mp\music_and_dialog::headquarters_newhq_music();
    thread updaterespawntimer();
    level waittill("zone_destroyed", _id_35216C18F7998623);
    level.spawndelay = undefined;

    if(isDefined(_id_35216C18F7998623)) {
      level.zone scripts\mp\gameobjects::setownerteam(_id_35216C18F7998623);
      continue;
    }

    level.zone scripts\mp\gameobjects::setownerteam("none");
  }
}

awardcapturepoints() {
  level endon("game_ended");
  level endon("zone_reset");
  level endon("zone_moved");
  level notify("awardCapturePointsRunning");
  level endon("awardCapturePointsRunning");
  _id_CC748B6D457627FE = 1;
  score = 1;

  while(!level.gameended) {
    waittime = 0.0;

    while(waittime < _id_CC748B6D457627FE) {
      waitframe();
      scripts\mp\hostmigration::waittillhostmigrationdone();
      waittime = waittime + level.framedurationseconds;

      if(level.zone.stalemate)
        waittime = 0.0;
    }

    team = level.zone scripts\mp\gameobjects::getownerteam();

    if(team == "neutral") {
      continue;
    }
    if(!level.zone.stalemate && !level.gameended) {
      if(level.zoneadditivescoring)
        score = level.zone.touchlist[team].size;

      scripts\mp\gamescore::giveteamscoreforobjective(team, score, 0);

      foreach(object in level.zone.touchlist[team]) {
        object.player scripts\mp\utility\stats::incpersstat("objTime", 1);

        if(isDefined(object.player.timebyrotation[level.kothhillrotation]))
          object.player.timebyrotation[level.kothhillrotation]++;
        else
          object.player.timebyrotation[level.kothhillrotation] = 1;

        object.player scripts\mp\persistence::statsetchild("round", "objTime", object.player.pers["objTime"]);
        object.player scripts\mp\utility\stats::setextrascore0(object.player.pers["objTime"]);
        object.player scripts\mp\gamescore::giveplayerscore("stat_61E7451E5D97D089", 10);
      }
    }
  }
}

movezoneaftertime(time) {
  level notify("startMoveTimer");
  level endon("startMoveTimer");
  level endon("game_ended");
  level endon("zone_reset");
  level endon("dev_force_zone");
  level.zonemovetime = time;
  level.zonedestroyedbytimer = 0;
  _id_1B18A05A284D55C2::zonetimerwait();
  level.zonedestroyedbytimer = 1;
  level notify("zone_moved");
  level notify("zone_destroyed");
}

give_capture_credit(touchlist, capturetime, _id_8C4EC3E8ADAFD3FF, lastcaptureteam, _id_22282E7D48CA3400) {
  level endon("game_ended");
  level.lastcaptime = gettime();
  _id_0666D6B1872868D7 = _id_22282E7D48CA3400;

  if(isDefined(_id_0666D6B1872868D7.owner))
    _id_0666D6B1872868D7 = _id_0666D6B1872868D7.owner;

  if(isPlayer(_id_0666D6B1872868D7)) {
    if(!isscoreboosting(_id_0666D6B1872868D7)) {
      _id_7E2C53B0BCF117D9 = spawnStruct();
      _id_7E2C53B0BCF117D9.player = _id_0666D6B1872868D7;
      _id_7E2C53B0BCF117D9.eventname = "capture";
      _id_7E2C53B0BCF117D9.position = _id_0666D6B1872868D7.origin;
      _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_game_event", _id_7E2C53B0BCF117D9);
      _id_0666D6B1872868D7 thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_DBC8F7C367A274AE");

      if(isDefined(level.zone.lastactivatetime) && gettime() - level.zone.lastactivatetime <= 2100)
        _id_0666D6B1872868D7 thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_4D98AED9E6EBBF28");

      if(_id_0666D6B1872868D7.lastkilltime + 500 > gettime()) {} else
        _id_0666D6B1872868D7 _id_1B18A05A284D55C2::setcrankedtimerzonecap(_id_0666D6B1872868D7);
    }
  }

  players = getarraykeys(touchlist);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size; _id_AC0E594AC96AA3A8++) {
    player = touchlist[players[_id_AC0E594AC96AA3A8]].player;
    player updatecapsperminute(lastcaptureteam);

    if(!isscoreboosting(player)) {
      player scripts\mp\utility\stats::incpersstat("captures", 1);
      player scripts\mp\persistence::statsetchild("round", "captures", player.pers["captures"]);
    } else {}

    wait 0.05;
  }
}

randomdrops() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  level.grnd_previouscratetypes = [];

  for(;;) {
    ownerteam = level.zone scripts\mp\gameobjects::getownerteam();
    _id_4440147083ABAF0A = 1;

    if(isDefined(ownerteam) && ownerteam != "neutral" && scripts\mp\utility\killstreak::currentactivevehiclecount() < scripts\mp\utility\killstreak::maxvehiclesallowed() && level.fauxvehiclecount + _id_4440147083ABAF0A < scripts\mp\utility\killstreak::maxvehiclesallowed() && scripts\cp_mp\killstreaks\airdrop::getnumdroppedcrates() < 8) {
      cratetype = _id_0FD32F08E72B657F::getdropzonecratetype();
      nodes = [];

      if(isDefined(level.zone.trigger._id_8D213E19BB3A154A))
        nodes = getnodesinradius(level.zone.trigger.origin, level.zone.trigger._id_8D213E19BB3A154A, 0);
      else
        nodes = getnodesintrigger(level.zone.trigger);

      if(shoulddonodedrop(cratetype) && isDefined(nodes) && nodes.size > 0) {
        _id_CAAC702D63510A96 = randomintrange(0, nodes.size);
        position = nodes[_id_CAAC702D63510A96];
        droporigin = getclosestpointonnavmesh(position.origin);
        tracestart = position.origin;
        _id_8B39E5984DA1FFAF = droporigin;
        contentoverride = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 0);
        ignoreents = [];
        trace = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, ignoreents, contentoverride);
        position = trace["position"];
      } else
        position = getdropposition() + (randomintrange(-50, 50), randomintrange(-50, 50), 0);

      if(cratetype == "mega") {
        streakinfo = spawnStruct();
        streakinfo.streakname = "airdrop_multiple";
        streakinfo.cratetype = undefined;
        streakinfo.numcrates = undefined;
        streakinfo.usephysics = undefined;
        scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle();
        scripts\cp_mp\killstreaks\airdrop_multiple::airdrop_multiple_dropcrates(undefined, ownerteam, position, randomfloat(360), position, 1, streakinfo);
      } else {
        vehicleisreserved = scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle();
        scenenode = scripts\cp_mp\killstreaks\airdrop::dropkillstreakcratefromscriptedheli(undefined, ownerteam, cratetype, position, randomfloat(360), position, vehicleisreserved);

        foreach(crate in scenenode.crates)
        crate.skipminimapicon = 1;
      }

      waittime = level.droptime;
    } else
      waittime = 0.5;

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(waittime);
  }
}

shoulddonodedrop(cratetype) {
  if(cratetype == "mega")
    return 0;

  if(level.mapname == "mp_vacant") {
    if(isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "4")
      return 0;
  } else if(issubstr(level.mapname, "mp_aniyah")) {
    if(isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "1")
      return 0;
  } else if(level.mapname == "mp_raid") {
    if(isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "6")
      return 0;
  } else if(level.mapname == "mp_petrograd") {
    if(isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "1")
      return 0;
  } else if(issubstr(level.mapname, "mp_hackney")) {
    if(isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "4")
      return 0;
  } else if(issubstr(level.mapname, "mp_shipment")) {
    if(isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "1")
      return 0;
  } else if(issubstr(level.mapname, "mp_emporium"))
    return 0;
  else if(level.mapname == "mp_backlot2") {
    if(isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "5")
      return 0;
  }

  return 1;
}

getdropposition() {
  if(level.mapname == "mp_vacant" && isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "4")
    return (1760, 701, 122);
  else if(level.mapname == "mp_emporium" && isDefined(level.zone.trigger.script_label)) {
    switch (level.zone.trigger.script_label) {
      case "1":
        return (-732, -136, 608);
      case "2":
        return (672, -1336, 608);
      case "3":
        return (44, 968, 608);
      case "4":
        return (-680, -1552, 608);
      case "5":
        return (832, 4, 608);
    }
  } else if(level.mapname == "mp_backlot2" && isDefined(level.zone.trigger.script_label) && level.zone.trigger.script_label == "5")
    return (-346, -2368, 66);

  return level.zone.origin;
}

getbestplayer() {
  bestplayer = undefined;
  besttime = 0;
  ownerteam = level.zone scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral")
    return bestplayer;

  foreach(object in level.zone.touchlist[ownerteam]) {
    if(besttime == 0 || besttime > object.starttime) {
      besttime = object.starttime;
      bestplayer = object.player;
    }
  }

  return bestplayer;
}

getspawnpoint() {
  spawnteam = self.pers["team"];
  _id_2FA17BAEFE0FA286 = getobjzonedeadzonedist();
  _id_BA0A9FD614A3F6EE = [];
  _id_BA0A9FD614A3F6EE["activeKOTHZoneNumber"] = level.zone.visuals[0] getentitynumber();
  _id_BA0A9FD614A3F6EE["maxSquaredDistToObjective"] = level.zone.visuals[0].furthestspawndistsq;
  _id_BA0A9FD614A3F6EE["kothZoneDeadzoneDistSq"] = _id_2FA17BAEFE0FA286 * _id_2FA17BAEFE0FA286;
  _id_BA0A9FD614A3F6EE["closestEnemyInfluenceDistSq"] = level.enemy_spawn_influence_dist_sq;

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(spawnteam == game["attackers"]) {
      scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_attackers", undefined, _id_BA0A9FD614A3F6EE);
    } else {
      scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_defenders", undefined, _id_BA0A9FD614A3F6EE);
    }
  } else {
    if(!isDefined(level.switchedtohardpointspawnlogic)) {
      level.switchedtohardpointspawnlogic = 1;
      scripts\mp\spawnlogic::setactivespawnlogic("DZ", "Crit_Default");
    }

    spawnpoints = removespawnsinactivedz(level.zone.spawnpoints);
    fallbackspawnpoints = removespawnsinactivedz(level.zone.fallbackspawnpoints);
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, level.zone.spawnset, level.zone.fallbackspawnset, "bad", _id_BA0A9FD614A3F6EE);
  }

  return spawnpoint;
}

getobjzonedeadzonedist() {
  return level.spawn_deadzone_dist;
}

removespawnsinactivedz(spawnpoints) {
  _id_D294628716AB60F9 = [];

  if(isDefined(spawnpoints)) {
    foreach(spawnpoint in spawnpoints) {
      if(!ispointinvolume(spawnpoint.origin, level.zone.trigger))
        _id_D294628716AB60F9[_id_D294628716AB60F9.size] = spawnpoint;
    }
  }

  return _id_D294628716AB60F9;
}

onplayerconnect(player) {
  player.numcaps = 0;
  player.capsperminute = 0;
  player.timebyrotation = [];
  player scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(player.pers["objTime"]))
    player scripts\mp\utility\stats::setextrascore0(player.pers["objTime"]);

  player scripts\mp\utility\stats::setextrascore1(0);

  if(isDefined(player.pers["defends"]))
    player scripts\mp\utility\stats::setextrascore1(player.pers["defends"]);
}

onplayerspawned(player) {
  for(;;)
    player waittill("spawned");
}

onspawnplayer(_id_9156B53BCF7CE573) {
  scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
  thread updatematchstatushintonspawn();
  level.personalnukecostoverride = 30;
}

gethqownerteamvalue(ownerteam) {
  if(ownerteam == "allies")
    _id_CABC886D846DD979 = 2;
  else if(ownerteam == "axis")
    _id_CABC886D846DD979 = 1;
  else
    _id_CABC886D846DD979 = 0;

  return _id_CABC886D846DD979;
}

updateservericons(state, contested) {
  _id_CABC886D846DD979 = -1;

  if(contested)
    _id_CABC886D846DD979 = -2;
  else if(scripts\mp\utility\teams::isgameplayteam(state)) {
    player = thread getownerteamplayer(state);

    if(isDefined(player))
      _id_CABC886D846DD979 = player getentitynumber();
  } else {
    switch (state) {
      case "zone_activation_delay":
        _id_CABC886D846DD979 = -3;
        break;
      case "zone_shift":
      default:
        break;
    }
  }

  setomnvar("ui_hardpoint", _id_CABC886D846DD979);
}

getownerteamplayer(ownerteam) {
  _id_A3010F9814A40C8D = undefined;

  foreach(player in level.players) {
    if(player.team == ownerteam) {
      _id_A3010F9814A40C8D = player;
      break;
    }
  }

  return _id_A3010F9814A40C8D;
}

updaterespawntimer() {
  level endon("game_ended");
  level endon("zone_moved");
  level endon("zone_destroyed");
  starttime = gettime();

  if(level.zoneduration > 0)
    endtime = starttime + level.zoneduration * 1000;
  else
    endtime = starttime + scripts\mp\utility\game::gettimelimit() * 1000 - scripts\mp\utility\game::gettimepassed();

  currenttime = starttime;

  while(currenttime < endtime) {
    currenttime = gettime();
    level.spawndelay = (endtime - currenttime) / 1000 + 0.1;
    waitframe();
  }
}

seticonnames() {
  level.icontarget = "dz_target";
  level.iconneutral = "dz_neutral";
  level.iconcapture = "dz_enemy";
  level.icondefend = "dz_friendly";
  level.iconcontested = "dz_contested";
  level.icontaking = "dz_taking";
  level.iconlosing = "dz_losing";
  level.icondefending = "dz_defending";
}

initwaypointicons() {
  scripts\mp\gamelogic::setwaypointiconinfo("dz_enemy", 0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dz", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("dz_friendly", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dz", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("dz_defending", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dz", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("dz_neutral", 0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dz", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("dz_contested", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dz", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("dz_losing", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dz", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("dz_target", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("dz_taking", 0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dz", 1);
}

updatecapsperminute(_id_331B4141F14DF535) {
  if(!isDefined(self.capsperminute)) {
    self.numcaps = 0;
    self.capsperminute = 0;
  }

  if(!isDefined(_id_331B4141F14DF535) || _id_331B4141F14DF535 == "neutral") {
    return;
  }
  self.numcaps++;
  _id_F40250902CCEBE1A = scripts\mp\utility\game::gettimepassed() / 60000;

  if(isPlayer(self) && isDefined(self.timeplayed["total"]))
    _id_F40250902CCEBE1A = self.timeplayed["total"] / 60;

  self.capsperminute = self.numcaps / _id_F40250902CCEBE1A;

  if(self.capsperminute > self.numcaps)
    self.capsperminute = self.numcaps;
}

isscoreboosting(player) {
  return isDefined(player.capsperminute) && player.capsperminute > 3;
}

writecurrentrotationteamscore() {
  if(level.kothhillrotation < 24) {
    setmatchdata("alliesRoundScore", level.kothhillrotation, getteamscore("allies"));
    setmatchdata("axisRoundScore", level.kothhillrotation, getteamscore("axis"));
  }
}

updatematchstatushintonspawn() {
  level endon("game_ended");

  if(istrue(level.zoneislocked))
    scripts\mp\hud_message::_id_F004EF4606B9EFDC("dz_control");
  else
    scripts\mp\hud_message::_id_F004EF4606B9EFDC("dz_capture");
}

_id_C6FB408CE40374FA(player) {
  if(!_id_2C3C990BA58FA6F5::_id_5A758C8D306F92ED() || !scripts\engine\utility::flag("jump_scares_ready")) {
    return;
  }
  if(level._id_103A870683641C69._id_8336FB035950FE34._id_302E82DA1A1989AD == 0) {
    return;
  }
  if(!isDefined(level._id_DFF9BE5E61BADF11))
    level._id_DFF9BE5E61BADF11 = int(ceil(1.0 / level._id_103A870683641C69._id_8336FB035950FE34._id_302E82DA1A1989AD));

  if(!isDefined(player._id_D8A83E5239DE8EB8))
    player._id_D8A83E5239DE8EB8 = 0;

  if(!isDefined(player._id_CA695DCB71C7449A))
    player._id_CA695DCB71C7449A = 0;

  player._id_D8A83E5239DE8EB8++;

  if(player._id_D8A83E5239DE8EB8 - player._id_CA695DCB71C7449A >= level._id_DFF9BE5E61BADF11) {
    _id_44B8991C2B01716A::_id_0B67F0B02F25B1AF(player, 1);
    player._id_CA695DCB71C7449A = player._id_D8A83E5239DE8EB8;
  } else if(_id_44B8991C2B01716A::_id_0B67F0B02F25B1AF(player))
    player._id_CA695DCB71C7449A = player._id_D8A83E5239DE8EB8;
}
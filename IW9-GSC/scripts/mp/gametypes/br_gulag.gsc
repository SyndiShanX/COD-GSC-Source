/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gulag.gsc
***********************************************/

initgulag() {
  level.respawncircleinterppct = getdvarfloat("dvar_0BA0A30562F3B3D2", 0.75);

  if(!istrue(level.usegulag)) {
    return;
  }
  if(_id_362C58E8BB39BCDA::isfeaturedisabled("gulag")) {
    level.usegulag = 0;
    return;
  }

  setomnvar("ui_gulag_state", 1);
  setomnvar("ui_gulag_show_closing_state", 0);
  level.gulag = spawnStruct();
  level.gulag.arenaflag = getdvarint("dvar_5052FB481D0F9342", 1);
  level.gulag.maxplayers = getmaxplayers();
  level.gulag.maxuses = getdvarint("dvar_75651466DDF2A023", 1);
  level.gulag.endonshutdown = getdvarint("dvar_A208C2044D682252", 3);
  level.gulag.maxqueue = getdvarint("dvar_288E3F85A1389BEE", 3);
  level.gulag.onekillwin = getdvarint("dvar_87F668A2B16E5A88", 1);
  level.gulag.multiarena = getdvarint("dvar_29B4DD2FCB154CC9", 1);
  level.gulag.planerespawn = getdvarint("dvar_86CE8BB55042030D", 0);
  level.gulag.introcinematic = getdvarint("dvar_1ACEBAD8080CE298", 1);
  level.gulag._id_3FDEDDA393E951F9 = getdvarint("dvar_ADEA9F7A92CA117D", 0);
  level.gulag.usecellspawns = getdvarint("dvar_9FA493A57B8993FB", 1);
  level.gulag.usefloorrocks = getdvarint("dvar_B962F2B08F7DAFC7", 0);
  level.gulag.spawnloot = getdvarint("dvar_1DB2120552A886E9", 0);
  level.gulag.lethaldelay = getdvarint("dvar_133CBACE5A3C90BD", 4);
  level.gulag.streamtimeout = getdvarint("dvar_901C31AAA4EEE907", 9);
  level.gulag.numarmorhealth = getdvarint("dvar_ABE2E86213098021", 0);
  level.gulag._id_28F8483EA37164F3 = getdvarint("dvar_2EBFF4C1F3D778E0", 2);
  level.gulag._id_5EBD7968D809FBAC = getdvarint("dvar_00ED69EAADBD3C2A", 0);
  level.gulag._id_C489BD0446D6B041 = getdvarint("dvar_E7819166FFA65760", 0);
  level.gulag._id_652312821A44B886 = getdvarfloat("dvar_81B659C0585A8952", 7.0);
  level.gulag._id_7D2261A38E79508D = getdvarint("dvar_283378C11C27C32C", 1);
  level.gulag._id_3FC59BCE0C73B8CF = getdvarint("dvar_25F058368AF3BC5A", 400);
  level.gulag._id_A3F8D04220DEBA43 = getdvarint("dvar_EA64FFF27301195A", 200);
  level.gulag._id_218B40BCF0F79B1F = getdvarint("dvar_590AE68D2C03B69B", 5);
  level.gulag._id_EABA0D28010B979B = getdvarint("dvar_21D1FFCCFA1E0436", 0);

  if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("gulagGetMatchDuration"))
    level.gulag.timelimit = _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("gulagGetMatchDuration");
  else
    level.gulag.timelimit = getdvarfloat("dvar_8BE34599DFA102B8", 15.0);

  _setdomflagiconinfo("waypoint_captureneutral", "neutral", "MP_BR_INGAME/DOM_CAPTURE", 0);
  _setdomflagiconinfo("waypoint_capture", "enemy", "MP_BR_INGAME/DOM_CAPTURE", 0);
  _setdomflagiconinfo("waypoint_defend", "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", 0);
  _setdomflagiconinfo("waypoint_defending", "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", 0);
  _setdomflagiconinfo("waypoint_contested", "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", 1);
  _setdomflagiconinfo("waypoint_taking", "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", 1);
  _setdomflagiconinfo("waypoint_losing", "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", 1);
  level.gulag.laststandplayers = [];

  if(istrue(level.gulag.arenaflag))
    _id_25E2B333B4736A48::setupdom();

  level.gulag.arenas = gulaggetarenas();
  gulaggesturesinit();
  gulaginitloadouts();

  if(level.gulag.introcinematic)
    scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::playercinematiccompletecallback);

  if(level.gulag.usefloorrocks)
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("brloot_rock", ::rockused);

  level.gulag.betting = getdvarint("dvar_003FB4B54C096217", 0);

  if(level.gulag.betting) {
    if(!istrue(level.br_plunder_enabled))
      level.gulag.betting = 0;
  }

  foreach(arena in level.gulag.arenas)
  level thread monitorgulag(arena);

  thread spawnac130();
  initvo();
  level.gamemodemolotovfunc = ::recordmolotov;
}

_id_7959E2DF2CC7C5B4() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    if(isDefined(level.gulag.arenas) && level.gulag.arenas.size > 0) {
      _id_FDB9974A1CCCE54C = 2000;
      arena = undefined;

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.gulag.arenas.size; _id_AC0E594AC96AA3A8++) {
        dist = distance(self.origin, level.gulag.arenas[_id_AC0E594AC96AA3A8].origin);

        if(dist < _id_FDB9974A1CCCE54C) {
          arena = level.gulag.arenas[_id_AC0E594AC96AA3A8];
          _id_FDB9974A1CCCE54C = dist;
        }
      }

      _id_662AAF2F16ED4E1E(arena);
    }

    waitframe();
  }
}

_id_662AAF2F16ED4E1E(arena) {
  if(!isDefined(arena) || arena.jailedplayers.size == 0 && arena.arenaplayers.size == 0) {
    self setclientomnvar("ui_gulag", 0);
    return;
  } else {
    if(arena.arenaplayers.size == 0) {
      if(arena.jailedplayers.size == 1) {
        self setclientomnvar("ui_br_gulag_match_state", 0);
        self setclientomnvar("ui_br_gulag_match_end_time", arena.jailedplayers[0].jailtimeoutend);
      }
    } else {
      if(isDefined(arena.fightover) && !arena.fightover && isDefined(arena.time) && arena.time > 0) {
        time = arena.time;

        if(!istrue(arena.overtime)) {
          _id_55C0E7E44829E72E = getovertimelength();
          time = time - _id_55C0E7E44829E72E;
        }

        self setclientomnvar("ui_br_gulag_match_end_time", gettime() + int(time * 1000));
      } else
        self setclientomnvar("ui_br_gulag_match_end_time", 0);

      _id_B62F45EDE37A2E21 = arena.arenaplayers[0] getclientomnvar("ui_br_gulag_match_state");

      if(_id_B62F45EDE37A2E21)
        self setclientomnvar("ui_br_gulag_match_state", _id_B62F45EDE37A2E21);

      _id_C8A5261A0FCA66D4 = 0;
      _id_4C096C17E2C382E1 = 0;
      _id_77FA43FC5F58845D = 4;

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_77FA43FC5F58845D; _id_AC0E594AC96AA3A8++) {
        _id_AC0E424AC96A7113 = arena.arenaplayers[_id_AC0E594AC96AA3A8];

        if(!isDefined(_id_AC0E424AC96A7113) || !_id_AC0E424AC96A7113 _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag())
          _id_C53E78332A6C514F = 0;
        else
          _id_C53E78332A6C514F = _id_AC0E424AC96A7113 getentitynumber() + 1;

        _id_C99096116AFD1827 = 255;
        _id_C8A5261A0FCA66D4 = _id_C8A5261A0FCA66D4 + ((int(_id_C53E78332A6C514F) &_id_C99096116AFD1827) << _id_4C096C17E2C382E1);
        _id_4C096C17E2C382E1 = _id_4C096C17E2C382E1 + 8;
      }

      self setclientomnvar("ui_br_twotwo_gulag_players", _id_C8A5261A0FCA66D4);
    }

    self setclientomnvar("ui_gulag", 1);
    self setclientomnvar("ui_br_gulag_data", arena.omnvardata["ui_br_gulag_data"]);
    self setclientomnvar("ui_overtime_timer_show", istrue(arena.overtime));
  }
}

_setdomflagiconinfo(name, colors, string, _id_B50E35D9C370899B) {
  level.waypointcolors[name] = colors;
  level.waypointbgtype[name] = 1;
  level.waypointstring[name] = string;
  level.waypointshader[name] = "ui_mp_br_mapmenu_icon_gulag_overtime_objective";
  level.waypointpulses[name] = _id_B50E35D9C370899B;
}

initvo() {
  game["dialog"]["gulag_spawn"] = "gulg_wzan_spwn";
  game["dialog"]["gulag_spawn_rules"] = "gulg_wzan_spwr";
  game["dialog"]["gulag_objective"] = "objc_wzan_glag";
  game["dialog"]["gulag_jailer_match_start"] = "fght_jalr_gums";
  game["dialog"]["gulag_next"] = "gulg_wzan_next";
  game["dialog"]["gulag_win"] = "gulg_wzan_win1";
  game["dialog"]["gulag_lose"] = "lose_wzan_glag";
  game["dialog"]["gulag_teammate_gulag"] = "tmmg_wzan_glag";
  game["dialog"]["gulag_teammate_lose"] = "tmml_wzan_glag";
  game["dialog"]["gulag_teammate_win"] = "tmmw_wzan_glag";
  game["dialog"]["gulag_gulag_active"] = "glga_wzan_glag";
  game["dialog"]["gulag_gulag_close"] = "glgc_wzan_glag";
  game["dialog"]["gulag_noenemy"] = "nnmy_wzan_glag";
  game["dialog"]["gulag_timeout"] = "nnmy_wzan_glag";
  game["dialog"]["gulag_buyback"] = "pbvn_wzan_jbge";
  game["dialog"]["gulag_taunt"] = "gulag_taunt";
  game["dialog"]["gulag_obj_wait"] = "gulag_obj_wait";
}

gulaggetarenas() {
  if(level._id_43307855F189EB31.name == "")
    arenas = scripts\engine\utility::getStructArray("gulag", "targetname");
  else
    arenas = scripts\engine\utility::getStructArray(level._id_43307855F189EB31.name, "targetname");

  _id_9E37DAE514C87448 = strtok(level._id_43307855F189EB31._id_7679335BE79F4871, " ");
  _id_26509CABA5CC603A = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_9E37DAE514C87448.size; _id_AC0E594AC96AA3A8++) {
    gulagarena = arenas[int(_id_AC0E594AC96AA3A8)];

    if(isDefined(gulagarena))
      _id_26509CABA5CC603A[_id_26509CABA5CC603A.size] = gulagarena;
  }

  if(_id_26509CABA5CC603A.size > 0)
    arenas = scripts\engine\utility::array_remove_array(arenas, _id_26509CABA5CC603A);

  arenas = scripts\engine\utility::array_randomize(arenas);

  if(_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF())
    arenas = scripts\engine\utility::getStructArray("gulag_tutorial", "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < arenas.size; _id_AC0E594AC96AA3A8++) {
    arena = arenas[_id_AC0E594AC96AA3A8];
    arena.gulagindex = _id_AC0E594AC96AA3A8;
    setuparena(arena);
  }

  return arenas;
}

setuparena(arena) {
  arena.jailspawns = [];
  arena.fightspawns = [];
  arena._id_EF9A0B82CE1A505A = [];
  arena.cellspawns = [];
  arena.gates = [];
  arena.floor = [];
  arena.weapons = [];
  arena.molotovs = [];
  arena.jailedplayers = [];
  arena.arenaplayers = [];
  arena.matches = [];
  arena.loadingplayers = [];
  arena.fightover = 1;
  arena.omnvardata = [];
  arena.omnvardata["ui_br_gulag_players_1"] = 0;
  arena.omnvardata["ui_br_gulag_data"] = 0;
  _id_03C7899636CBA8AB = [];
  targets = scripts\engine\utility::getStructArray(arena.target, "targetname");

  foreach(target in targets) {
    if(target.script_noteworthy == "prison_spawn") {
      arena.jailspawns[arena.jailspawns.size] = target;
      continue;
    }

    if(target.script_noteworthy == "gulag_twotwo_spectator_spawn") {
      if(isDefined(level._id_48E6357833F85B3B) && scripts\engine\utility::array_contains(level._id_48E6357833F85B3B, target)) {
        continue;
      }
      arena.jailspawns[arena.jailspawns.size] = target;
      continue;
    }

    if(target.script_noteworthy == "fight_spawn") {
      arena.fightspawns[arena.fightspawns.size] = target;
      continue;
    }

    if(target.script_noteworthy == "gulag_twotwo_spawn_fight") {
      arena.fightspawns[arena.fightspawns.size] = target;
      continue;
    }

    if(target.script_noteworthy == "gulag_twotwo_spawn_fight_alt1") {
      arena._id_EF9A0B82CE1A505A[arena._id_EF9A0B82CE1A505A.size] = target;
      continue;
    }

    if(target.script_noteworthy == "gulag_dom_player_spawn") {
      arena.fightspawns[arena.fightspawns.size] = target;
      continue;
    }

    if(target.script_noteworthy == "cell_spawn") {
      arena.cellspawns[arena.cellspawns.size] = target;
      continue;
    }

    if(target.script_noteworthy == "gulag_center") {
      arena.center = target.origin;
      continue;
    }

    if(target.script_noteworthy == "spectator") {
      arena.spectatepoint = target;
      continue;
    }

    if(target.script_noteworthy == "gulag_twotwo_spectator") {
      arena.spectatepoint = target;
      continue;
    }

    if(target.script_noteworthy == "gulag_dom_prematch_spawn") {
      arena._id_C379148A901939AC = target;
      continue;
    }

    if(target.script_noteworthy == "gulag_twotwo_center") {
      arena._id_1DF1ACEE38DCCA72 = target.origin;
      continue;
    }

    if(isDefined(target.script_parameters) && target.script_parameters == "gulag_loot")
      _id_03C7899636CBA8AB[_id_03C7899636CBA8AB.size] = target;
  }

  if(!isDefined(arena.center))
    arena.center = getgulagcenter(arena);

  if(getdvarint("dvar_F76A1354FC64E33A", 1) > 0)
    arena.fightspawns = scripts\engine\utility::array_sort_with_func(arena.fightspawns, ::comparescriptindexobscuredspawns);
  else
    arena.fightspawns = scripts\engine\utility::array_sort_with_func(arena.fightspawns, ::comparescriptindexsmalltolarge);

  foreach(_id_4CD366EF5A786AE4 in arena.cellspawns)
  setupcellspawn(arena, _id_4CD366EF5A786AE4);

  arena.cellspawns = scripts\engine\utility::array_sort_with_func(arena.cellspawns, ::comparescriptindexsmalltolarge);

  if(istrue(level.gulag.spawnloot))
    arena.weapons = spawnlootweapons(_id_03C7899636CBA8AB);

  spawnrocks(arena);

  if(istrue(level.gulag.arenaflag))
    setupdomendflag(arena);
}

gulaggesturesinit() {
  level.gulag.gestures_enabled = getdvarint("dvar_0299AE8C08206178", 0);

  if(!istrue(level.gulag.gestures_enabled)) {
    return;
  }
  level.gulag.gestures = [];
  level.gulag.gestures["fc_gesture_neg"] = ["iw8_ges_plyr_gesture_crush", "iw8_ges_plyr_gesture_rally", "iw8_ges_plyr_gesture_revive"];
  level.gulag.gestures["fc_gesture_pos"] = ["iw8_ges_plyr_gesture_doubletime", "iw8_ges_plyr_gesture_hold", "iw8_ges_plyr_gesture_ok", "iw8_ges_plyr_gesture_thumbs_up"];
  level.gulag.gesturesounds["fc_gesture_neg"] = ["tmp_gulag_gesture_neg_crush", "tmp_gulag_gesture_neg_rally", "tmp_gulag_gesture_neg_revive"];
  level.gulag.gesturesounds["fc_gesture_pos"] = ["tmp_gulag_gesture_pos_doubletime", "tmp_gulag_gesture_pos_hold", "tmp_gulag_gesture_pos_ok", "tmp_gulag_gesture_pos_thumbs_up"];
}

getmaxplayers() {
  maxplayers = int(clamp(getdvarint("dvar_29BF69A5061EBFC3", 2), 2, 2));

  if(maxplayers % 2 != 0)
    maxplayers = maxplayers - 1;

  if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("gulagGetMaxPlayers"))
    maxplayers = _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("gulagGetMaxPlayers");

  return maxplayers;
}

comparescriptindexsmalltolarge(left, right) {
  return left.script_index < right.script_index;
}

comparescriptindexobscuredspawns(left, right) {
  if(left.script_index == 4)
    return 1;
  else if(left.script_index == 5)
    return 1;
  else if(right.script_index == 4)
    return 0;
  else if(right.script_index == 5)
    return 0;

  return comparescriptindexsmalltolarge(left, right);
}

copystructwithoffset(struct, offset, script_index) {
  next = spawnStruct();
  next.origin = struct.origin + offset;
  next.angles = struct.angles;
  next.script_index = script_index;
  return next;
}

getgulagcenter(arena) {
  _id_2F432D8C975DECC6 = (0, 0, 0);

  foreach(struct in arena.fightspawns)
  _id_2F432D8C975DECC6 = _id_2F432D8C975DECC6 + struct.origin;

  _id_2F432D8C975DECC6 = _id_2F432D8C975DECC6 / arena.fightspawns.size;
  return _id_2F432D8C975DECC6;
}

spawnweapon(loc, gun, _id_27C0612CFD76EE91) {
  weapon = _id_724736FCF0FB6604::createspawnweaponatpos(getgroundposition(loc.origin + (0, 0, 12), 12), loc.angles + (0, 0, 90), gun, []);
  weapon thread outlinewatchplayerprox(_id_27C0612CFD76EE91);
  return weapon;
}

spawnlootweapons(_id_03C7899636CBA8AB) {
  _id_68490A59162353A8 = [];
  _id_2E7C6EA3E6EA14CF = [];
  _id_2E7C6EA3E6EA14CF["none"] = ["none"];
  _id_2E7C6EA3E6EA14CF["tactical"] = _id_7E52B56769FA7774::getgulagpickupsforclass("tactical");
  _id_2E7C6EA3E6EA14CF["lethal"] = _id_7E52B56769FA7774::getgulagpickupsforclass("lethal");
  _id_31351647880100C7 = [];

  foreach(_id_659AFABDB2DE8ECE in _id_2E7C6EA3E6EA14CF) {
    foreach(scriptable in _id_659AFABDB2DE8ECE) {
      startammo = 1;

      if(isDefined(_id_31351647880100C7[scriptable])) {
        continue;
      }
      info = level.br_lootiteminfo[scriptable];

      if(isDefined(info)) {
        baseweapon = level.br_lootiteminfo[scriptable].baseweapon + "_mp";
        startammo = weaponclipsize(baseweapon) * 1;
      }

      _id_31351647880100C7[scriptable] = startammo;
    }
  }

  _id_A87E40016E3D9F3A = ["tactical", "tactical", "lethal", "lethal", "lethal"];
  _id_A87E40016E3D9F3A = scripts\engine\utility::array_randomize(_id_A87E40016E3D9F3A);
  _id_719E1CD141DBCF8C = [];
  _id_719E1CD141DBCF8C["floor_center_01"] = scripts\engine\utility::random(_id_2E7C6EA3E6EA14CF[_id_A87E40016E3D9F3A[0]]);
  _id_719E1CD141DBCF8C["floor_center_02"] = scripts\engine\utility::random(_id_2E7C6EA3E6EA14CF[_id_A87E40016E3D9F3A[1]]);
  _id_719E1CD141DBCF8C["floor_right_01"] = scripts\engine\utility::random(_id_2E7C6EA3E6EA14CF[_id_A87E40016E3D9F3A[2]]);
  _id_719E1CD141DBCF8C["floor_left_01"] = scripts\engine\utility::random(_id_2E7C6EA3E6EA14CF[_id_A87E40016E3D9F3A[3]]);
  _id_719E1CD141DBCF8C["floor_mid_01"] = scripts\engine\utility::random(_id_2E7C6EA3E6EA14CF[_id_A87E40016E3D9F3A[4]]);

  if(getdvarint("dvar_F76A1354FC64E33A", 1) > 0)
    _id_719E1CD141DBCF8C["floor_left_01"] = _id_719E1CD141DBCF8C["floor_right_01"];

  foreach(struct in _id_03C7899636CBA8AB) {
    if(!isDefined(struct.script_noteworthy)) {
      continue;
    }
    scriptablename = _id_719E1CD141DBCF8C[struct.script_noteworthy];

    if(!isDefined(scriptablename)) {
      continue;
    }
    if(scriptablename == "none") {
      continue;
    }
    origin = struct.origin;
    angles = struct.angles;

    if(!isDefined(angles))
      angles = (0, 0, 0);
    else
      angles = (0, angles[1], 0);

    scriptable = spawnscriptable(scriptablename, origin, angles);

    if(isDefined(scriptable)) {
      scriptable.part = scriptablename;
      _id_7E52B56769FA7774::loot_setitemcount(scriptable, _id_31351647880100C7[scriptablename]);
      scriptable.keepinmap = 1;
      _id_68490A59162353A8[_id_68490A59162353A8.size] = scriptable;
      continue;
    }
  }

  return _id_68490A59162353A8;
}

playerismatchedplayerready(arena) {
  if(playerismatchpending(arena)) {
    _id_607899D4420FE1A5 = arena.matches[0];

    foreach(player in _id_607899D4420FE1A5) {
      if(player == self)
        continue;
      else if(isplayerloading(player, arena))
        return 0;
    }

    return 1;
  }

  return 0;
}

playerismatchpending(arena) {
  if(ismatchpending(arena)) {
    _id_607899D4420FE1A5 = arena.matches[0];

    foreach(player in _id_607899D4420FE1A5) {
      if(player == self)
        return 1;
    }
  }

  return 0;
}

ismatchpending(arena) {
  if(arena.matches.size == 0)
    return 0;

  _id_607899D4420FE1A5 = arena.matches[0];

  if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("gulagIsMatchPending"))
    return _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("gulagIsMatchPending", _id_607899D4420FE1A5, arena);
  else if(_id_607899D4420FE1A5.size < 2)
    return 0;

  return 1;
}

isfightready(arena) {
  if(!ismatchpending(arena))
    return 0;

  _id_607899D4420FE1A5 = arena.matches[0];

  foreach(player in _id_607899D4420FE1A5) {
    if(level.gulag._id_C489BD0446D6B041)
      logstring("[GULAG DEBUG] : Player " + player.clientid + " is being checked for isFightReady step 1. Time : " + gettime() + ". Player enterGulagWait : " + istrue(player.entergulagwait) + " Player jailed : " + istrue(player.jailed) + " . Player waiting area timer : " + istrue(player._id_D95581FDFC29EC7A) + " . Number of players in the queue for gulag are : " + arena.matches.size + " .");

    if(istrue(player.entergulagwait) || !istrue(player.jailed))
      return 0;

    if(isDefined(player._id_D95581FDFC29EC7A))
      return 0;
  }

  return 1;
}

_id_8AF4800D9DD40258(arena) {
  if(!_id_5BC60484D17FA95C::_id_1980065CE4DC067B() || getdvarint("dvar_ABBFD88D4515A08C", 1) == 0) {
    return;
  }
  if(arena.fightover && arena.arenaplayers.size > 0) {
    arena.arenaplayers = scripts\engine\utility::array_removeundefined(arena.arenaplayers);

    foreach(player in arena.arenaplayers) {
      if(!istrue(player.gulag))
        arena.arenaplayers = scripts\engine\utility::array_remove(arena.arenaplayers, player);
    }
  }
}

gulagfixuparena(arena) {
  _id_C5192A759DE07642 = 5000;

  if(!isDefined(arena.nextfixupcheckms)) {
    arena.nextfixupcheckms = gettime() + _id_C5192A759DE07642;
    return;
  }

  if(gettime() > arena.nextfixupcheckms) {
    arena.jailedplayers = scripts\engine\utility::array_removeundefined(arena.jailedplayers);
    updatematchqueuepositions(arena);
    _id_8AF4800D9DD40258(arena);

    if(arena.gulagindex == 0) {
      level.gulag.laststandplayers = scripts\engine\utility::array_removeundefined(level.gulag.laststandplayers);

      foreach(player in level.gulag.laststandplayers) {
        if(!istrue(player.inlaststand))
          level.gulag.laststandplayers = scripts\engine\utility::array_remove(level.gulag.laststandplayers, player);
      }
    }

    arena.nextfixupcheckms = gettime() + _id_C5192A759DE07642;
  }
}

_id_127C772F981AEFC1(arena) {
  arena.jailedplayers = scripts\engine\utility::array_removeundefined(arena.jailedplayers);
  arena.arenaplayers = scripts\engine\utility::array_removeundefined(arena.arenaplayers);
}

monitorgulag(arena) {
  level endon("game_ended");

  for(;;) {
    gulagfixuparena(arena);

    if(istrue(level.br_prematchstarted)) {
      if(istrue(level.gulag.shutdown)) {
        if(arena.loadingplayers.size != 0)
          arena scripts\engine\utility::waittill_notify_or_timeout("loadingPlayersEmpty", 34000);

        if(level.gulag.endonshutdown == 1) {
          foreach(player in arena.jailedplayers) {
            player.gulagloser = 1;
            player kill();
          }

          arena.shutdown = 1;
        } else if(level.gulag.endonshutdown == 2)
          thread dojailbreak(arena);
        else if(level.gulag.endonshutdown == 3 && (istrue(arena.shutdown) || !ismatchpending(arena) && !anyplayersinlaststandhold())) {
          foreach(player in arena.jailedplayers) {
            if(isalive(player)) {
              player playergulagarenaready();
              thread gulagvictory(arena, player, 1, 0, "shutdown");
            }
          }

          arena.shutdown = 1;
        }
      }

      if(isgulagpaused()) {
        waitframe();
        continue;
      }

      if(isfightready(arena)) {
        if(_id_0B0385BB45379222::_id_9005AF34E01BF8FE())
          level thread _id_D84EE736A981AFDF(arena);
        else
          beginnewfight(arena);
      } else
        setjailtimeouthud(arena);
    }

    waitframe();
  }
}

pausegulag(bpaused) {
  if(!istrue(level.usegulag)) {
    return;
  }
  level.gulag.paused = bpaused;
}

isgulagpaused() {
  return istrue(level.usegulag) && istrue(level.gulag.paused);
}

areanygulagfightsactive() {
  if(!istrue(level.usegulag))
    return 0;

  foreach(arena in level.gulag.arenas) {
    if(_id_5BC60484D17FA95C::_id_1980065CE4DC067B()) {
      if(arena.arenaplayers.size > 0)
        return 1;
    } else if(!arena.fightover)
      return 1;
  }

  return 0;
}

jailbreakeventplayer() {
  if(isDefined(self) && isalive(self))
    gulagvictory(self.arena, self, 1, 1, "jailbreakEvent");
}

circletimer(circleindex) {
  if(istrue(level.usegulag) && !istrue(level.gulag.shutdown)) {
    _id_DB3353AE94ADEC9D = getgulagclosedcircleindex();

    if(circleindex >= _id_DB3353AE94ADEC9D) {
      shutdowngulag("circle_index", circleindex);

      if(_id_2C3C990BA58FA6F5::_id_364F4C40FF756CAC()) {
        if(isDefined(level._id_49D407295B31E357) && isDefined(level._id_49D407295B31E357._id_08CBC8B62D3634B5))
          thread[[level._id_49D407295B31E357._id_08CBC8B62D3634B5]](0);
      }
    }
  }
}

shutdowngulag(_id_401C3A2E68AAB0FD, _id_B4617E1677838AB5, _id_DEDCC523DB8309B1) {
  if(!istrue(level.usegulag) || istrue(level.gulag.shutdown)) {
    return;
  }
  setomnvar("ui_gulag_state", 0);
  setomnvar("ui_gulag_show_closing_state", 2);
  level.gulag.shutdown = 1;
  _id_715028F54BAD19A1::_id_AFD45555767F3079();

  if(isDefined(level._id_ED844DB90CB6D370) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("teamAssim", "permanentlyDisableAssim"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "permanentlyDisableAssim")]]();

  thread makeac130flyaway();

  if(!istrue(_id_DEDCC523DB8309B1)) {
    foreach(player in level.players) {
      player _id_5E9A06395FFA9C82();

      if(istrue(player.inlaststand)) {
        level.gulag.laststandplayers[level.gulag.laststandplayers.size] = player;
        continue;
      }

      if(!isDefined(player) || !isalive(player) || isDefined(player.gulag)) {
        continue;
      }
      player playergulagdonesplash();
      player _id_DD93503CF95B6277();
    }
  }

  _id_548072087C9FD504::_id_7D42D3F8DD68280C(1);
  level notify("gulag_closed");
  dlog_recordevent("dlog_event_br_gulag_shutdown", ["reason", _id_401C3A2E68AAB0FD, "reason_count", _id_B4617E1677838AB5]);
}

_id_5E9A06395FFA9C82() {
  _id_FC3C57822786291A = 0;
  _id_BE4684F53E4F5566 = 0;

  if(istrue(level.br_pickups.respawntokenclosewithgulag) && _id_2CEDCC356F1B9FC8::hasrespawntoken() && level.gulag._id_3FC59BCE0C73B8CF > 0) {
    _id_FC3C57822786291A = 1;
    _id_7E52B56769FA7774::removerespawntoken();
    _id_6AFF3948CF4CCA03::playerplunderpickup(level.gulag._id_3FC59BCE0C73B8CF);
  }

  if(istrue(level.br_pickups._id_5609DE5240E42E84) && _id_2CEDCC356F1B9FC8::_id_15DA77DC195BD80A() && level.gulag._id_A3F8D04220DEBA43 > 0) {
    _id_BE4684F53E4F5566 = 1;
    _id_7E52B56769FA7774::_id_17E127F2E3771058();
    _id_6AFF3948CF4CCA03::playerplunderpickup(level.gulag._id_A3F8D04220DEBA43);
  } else if(istrue(level.br_pickups._id_5609DE5240E42E84) && checkgulagusecount() && level.gulag._id_A3F8D04220DEBA43 > 0) {
    _id_BE4684F53E4F5566 = 1;
    _id_6AFF3948CF4CCA03::playerplunderpickup(level.gulag._id_A3F8D04220DEBA43);
  }

  if(_id_FC3C57822786291A && _id_BE4684F53E4F5566)
    scripts\mp\utility\lower_message::setlowermessageomnvar("br_redeployGulag_conversion", undefined, level.gulag._id_218B40BCF0F79B1F);
  else if(_id_FC3C57822786291A)
    scripts\mp\utility\lower_message::setlowermessageomnvar("br_redeploy_conversion", undefined, level.gulag._id_218B40BCF0F79B1F);
  else if(_id_BE4684F53E4F5566)
    scripts\mp\utility\lower_message::setlowermessageomnvar("br_gulag_conversion", undefined, level.gulag._id_218B40BCF0F79B1F);

  _id_6A39684E5BF90A2F();
}

_id_6A39684E5BF90A2F() {
  _id_2621D983F664E79A = getlootscriptablearray("brloot_redeploy_token", undefined);
  _id_FDBB7E6149E0FCF6 = getlootscriptablearray("brloot_gulag_token", undefined);

  foreach(_id_D8CD9C1941A88194 in _id_2621D983F664E79A)
  _id_7E52B56769FA7774::loothide(_id_D8CD9C1941A88194);

  foreach(_id_D8CD9C1941A88194 in _id_FDBB7E6149E0FCF6)
  _id_7E52B56769FA7774::loothide(_id_D8CD9C1941A88194);

  level.br_pickups._id_EC8ACC2CB92CEAF7 = 1;
}

anyplayersinlaststandhold() {
  return level.gulag.laststandplayers.size > 0;
}

playerinlaststandhold() {
  if(!istrue(level.usegulag) || !istrue(level.gulag.shutdown))
    return 0;

  return scripts\engine\utility::array_contains(level.gulag.laststandplayers, self);
}

gulaglaststandholdremove(player) {
  if(istrue(level.gulag.shutdown) && anyplayersinlaststandhold()) {
    if(isDefined(player) && player playerinlaststandhold()) {
      level.gulag.laststandplayers = scripts\engine\utility::array_remove(level.gulag.laststandplayers, player);
      return 1;
    } else
      level.gulag.laststandplayers = scripts\engine\utility::array_removeundefined(level.gulag.laststandplayers);
  }

  return 0;
}

onplayerdisconnect(player) {
  if(!istrue(level.usegulag)) {
    return;
  }
  gulaglaststandholdremove(player);

  if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("gulagOnPlayerDisconnect"))
    player _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("gulagOnPlayerDisconnect");
}

playerexitlaststand(_id_22F7E2F7E3607528) {
  if(!istrue(level.usegulag)) {
    return;
  }
  if(istrue(_id_22F7E2F7E3607528)) {
    if(gulaglaststandholdremove(self))
      playergulagdonesplash();
  }
}

getgulagclosedcircleindex() {
  if(!isDefined(level.br_level) || !isDefined(level.br_level.br_circledelaytimes))
    return 0;

  offset = level.br_level.br_movingcirclegulagcloseoffset;

  if(!isDefined(offset))
    offset = 0;

  if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("gulagGetClosedCircleIndex"))
    return _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("gulagGetClosedCircleIndex", offset);
  else
    return level.br_level.br_circledelaytimes.size - 1 - getdvarint("dvar_1141FEA0C6EF428F", 3) - offset;
}

setupgulagtimer() {
  _id_2948CA54731DE34F = gettimetogulagclosed();
  _id_754110404C0D574F = gettime() + _id_2948CA54731DE34F * 1000;
  setomnvar("ui_gulag_timer", _id_754110404C0D574F);
  thread showclosingmessage(_id_2948CA54731DE34F);
}

showclosingmessage(_id_2948CA54731DE34F) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  _id_FC133E1A9D8063A1 = getdvarint("dvar_BF9AAA13E23F04AE", 90);
  _id_6113FC02B7117903 = _id_2948CA54731DE34F - _id_FC133E1A9D8063A1;

  if(0 < _id_6113FC02B7117903) {
    wait(_id_6113FC02B7117903);
    setomnvar("ui_gulag_show_closing_state", 1);
  }
}

gettimetogulagclosed() {
  time = 0;

  if(isDefined(level.br_level) && isDefined(level.br_level.br_circlecenters)) {
    _id_DB3353AE94ADEC9D = getgulagclosedcircleindex();

    for(circleindex = 0; circleindex < _id_DB3353AE94ADEC9D; circleindex++) {
      _id_3702CBA57F844507 = level.br_level.br_circledelaytimes[circleindex];
      _id_3D8565E2775A243C = level.br_level.br_circleclosetimes[circleindex];
      time = time + _id_3702CBA57F844507 + _id_3D8565E2775A243C;
    }
  }

  return int(time);
}

playergulagdonesplash() {
  if(istrue(self.gulagdone)) {
    return;
  }
  self.gulagdone = 1;
  _id_1671F48D05259D22::dangernotifyplayer(self, "gulag_closed", 3);
  _id_2CEDCC356F1B9FC8::brleaderdialogplayer("gulag_gulag_close", self);
}

dojailbreak(arena) {
  if(arena.jailedplayers.size == 0) {
    arena.shutdown = 1;
    return;
  }

  arena.isjailbreak = 1;
  arena.arenaplayers = scripts\engine\utility::array_removeundefined(arena.jailedplayers);
  jailbreaktimerwait(arena);
  loadoutindex = getloadoutindex();

  foreach(player in arena.arenaplayers) {
    if(!isDefined(player)) {
      continue;
    }
    player thread gulagplayerwatchfordeath(arena);
    player initplayerarena(arena, 1, loadoutindex, "doJailBreak");

    if(istrue(level.gulag.gestures_enabled) && !isbot(player))
      player playergulaggesturesdisable();

    if(getdvarint("dvar_3CEAF2C0C66C3DC2", 1) > 0 && arena.arenaplayers.size > 0)
      player hudoutlinedisableforclients(arena.arenaplayers);
  }

  playsoundatpos(arena.center, "evt_br_gulag_round_start_buzzer");
  arena.fightover = 0;

  if(!isoneteamleft(arena)) {
    arena.time = level.gulag.timelimit;
    updatematchtimerhud(arena, arena.time);
    waittillgulagmatchend(arena, 0);
  } else {
    arena.time = 8;
    updatematchtimerhud(arena, arena.time);
    wait(arena.time);
  }

  foreach(player in arena.arenaplayers) {
    if(isDefined(player) && isDefined(player.gulagjailbreakhud))
      player.gulagjailbreakhud destroy();
  }

  handleendarena(arena);
  arena.shutdown = 1;
}

jailbreaktimerwait(arena) {
  foreach(player in arena.arenaplayers) {
    if(!isDefined(player)) {
      continue;
    }
    player thread scripts\mp\hud_message::showsplash("br_gulag_jail_break");

    if(getdvarint("dvar_3CEAF2C0C66C3DC2", 1) > 0)
      player hudoutlineenableforclients(arena.arenaplayers, "outline_nodepth_red");
  }

  wait 3;

  foreach(player in arena.arenaplayers) {
    if(!isDefined(player)) {
      continue;
    }
    player playeraddjailbreaktimer();
  }

  gulagcountdowntimer(arena, 0);

  foreach(player in arena.arenaplayers) {
    if(!isDefined(player)) {
      continue;
    }
    player setclientomnvar("ui_match_start_countdown", 0);
    player setclientomnvar("ui_match_in_progress", 1);

    if(isDefined(player) && isDefined(player.gulagjailbreakhud))
      player.gulagjailbreakhud.label = &"MP/BR_GULAG_JAILBREAK";
  }
}

playeraddjailbreaktimer() {
  self.gulagjailbreakhud = scripts\mp\hud_util::createfontstring("default", 2);
  self.gulagjailbreakhud scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -150);
  self.gulagjailbreakhud.label = &"MP/BR_GULAG_JAILBREAK_IN";
}

resetequipment(arena) {
  if(!istrue(level.gulag.spawnloot)) {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < arena.weapons.size; _id_AC0E594AC96AA3A8++) {
    weapon = arena.weapons[_id_AC0E594AC96AA3A8];
    weapon setscriptablepartstate(weapon.part, "visible");
  }
}

validateplayers(arena) {
  if(_id_46FDF7B12C5F5620::_id_D58396C1483BFBDB())
    return arena.arenaplayers.size >= 1;
  else
    return arena.arenaplayers.size >= 2;
}

_id_CECBD3AA752B9087(players) {
  level endon("game_ended");
  _id_0A3F956F52C85CBD = 0;

  while(!_id_0A3F956F52C85CBD) {
    waitframe();
    _id_0A3F956F52C85CBD = 1;

    foreach(player in players) {
      if(player isinexecutionvictim()) {
        _id_0A3F956F52C85CBD = 0;
        break;
      }
    }
  }
}

_id_D84EE736A981AFDF(arena) {
  level endon("game_ended");
  arena endon("fight_over_early");
  arena.fightover = 0;
  resetequipment(arena);
  resetarenaomnvardata(arena);
  _id_3C02E542FA952687 = popnextmatch(arena);
  arena.arenaplayers = scripts\engine\utility::array_combine_unique(arena.arenaplayers, _id_3C02E542FA952687);

  if(level.gulag._id_C489BD0446D6B041)
    logstring("[GULAG DEBUG] : Player " + _id_3C02E542FA952687[0].clientid + " is starting new individual fight step 1. Time : " + gettime() + ". Number of players in the queue for gulag are : " + arena.matches.size + " .");

  loadoutindex = getloadoutindex();
  _id_CECBD3AA752B9087(_id_3C02E542FA952687);

  foreach(_id_AC0E424AC96A7113 in _id_3C02E542FA952687) {
    arena.jailedplayers = scripts\engine\utility::array_remove(arena.jailedplayers, _id_AC0E424AC96A7113);
    _id_AC0E424AC96A7113 notify("beginNewFight");

    if(level.gulag._id_C489BD0446D6B041)
      logstring("[GULAG DEBUG] : Player " + _id_AC0E424AC96A7113.clientid + " is starting new individual fight step 2. Time : " + gettime() + ". Number of players in the queue for gulag are : " + arena.matches.size + " .");

    _id_AC0E424AC96A7113 thread gulagplayerwatchfordeath(arena);
    _id_AC0E424AC96A7113 thread initplayerarena(arena, 0, loadoutindex, "beginNewIndividualFight");
    _id_AC0E424AC96A7113 playergulagarenaready();
    _id_AC0E424AC96A7113 thread playershowarenastartobjectivetext();
    _id_AC0E424AC96A7113 thread _id_0B0385BB45379222::_id_C68DA8E2DDE4DFA3(arena);
    _id_AC0E424AC96A7113 thread _id_B0FDA2BBB0C12AC2(_id_59D019F0169C03BE());
    _id_AC0E424AC96A7113 thread _id_6C8F212282E139D6(arena, level.gulag.timelimit);

    if(level.gulag._id_C489BD0446D6B041)
      logstring("[GULAG DEBUG] : Player " + _id_AC0E424AC96A7113.clientid + " is starting new individual fight step 3. Time : " + gettime() + ". Number of players in the queue for gulag are : " + arena.matches.size + " .");
  }

  _id_2CEDCC356F1B9FC8::brleaderdialog("gulag_objective", 0, _id_3C02E542FA952687);
  _updatematchtimerhudinternal(_id_3C02E542FA952687, level.gulag.timelimit);

  foreach(_id_AC0E424AC96A7113 in arena.jailedplayers) {
    if(!isDefined(_id_AC0E424AC96A7113)) {
      continue;
    }
    _id_AC0E424AC96A7113.gulagposition--;

    if(level.gulag._id_C489BD0446D6B041)
      logstring("[GULAG DEBUG] : Player " + _id_AC0E424AC96A7113.clientid + " completed new individual fight step 4 and is being removed from jailedPlayers. Time : " + gettime() + ". Number of players in the queue for gulag are : " + arena.matches.size + " .");
  }
}

beginnewfight(arena) {
  level endon("game_ended");
  arena endon("fight_over_early");
  arena.fightover = 0;
  resetequipment(arena);
  resetarenaomnvardata(arena);
  _id_607899D4420FE1A5 = arena.matches[0];

  if(_id_C9861A6C6B4085D8(_id_607899D4420FE1A5, arena)) {
    arena.arenaplayers = _id_E604F37BC584077D(arena);
    arena._id_654C981854394718 = scripts\engine\utility::array_remove_array(arena._id_654C981854394718, arena.arenaplayers);

    if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("setGulagJailTimeoutVariation"))
      _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("setGulagJailTimeoutVariation", arena);

    foreach(_id_AC0E424AC96A7113 in arena.jailedplayers) {
      if(_id_AC0E424AC96A7113 getclientomnvar("ui_br_bink_overlay_state") == 5)
        _id_AC0E424AC96A7113 _id_5BAB271917698DC4::_id_E68E4BB4F65F5FE4();
    }
  } else {
    arena.arenaplayers = popnextmatch(arena);

    if(isDefined(arena._id_654C981854394718)) {
      foreach(_id_AC0E424AC96A7113 in arena.arenaplayers) {
        if(!isDefined(_id_AC0E424AC96A7113)) {
          continue;
        }
        index = scripts\engine\utility::array_find(arena._id_654C981854394718, _id_AC0E424AC96A7113);

        if(isDefined(index))
          arena._id_654C981854394718 = scripts\engine\utility::array_remove(arena._id_654C981854394718, _id_AC0E424AC96A7113);
      }
    }

    if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("unsetGulagJailTimeoutVariation"))
      _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("unsetGulagJailTimeoutVariation", arena);
  }

  _id_6AE446BBA4624713 = 0;

  foreach(_id_AC0E594AC96AA3A8, _id_AC0E424AC96A7113 in arena.arenaplayers) {
    if(isDefined(_id_AC0E424AC96A7113)) {
      _id_AC0E424AC96A7113.gulagposition = 0;
      arena.jailedplayers = scripts\engine\utility::array_remove(arena.jailedplayers, _id_AC0E424AC96A7113);
    }

    if(!isDefined(_id_AC0E424AC96A7113)) {
      _id_6AE446BBA4624713 = 1;
      continue;
    }

    if(_id_AC0E424AC96A7113.gulag == 0 || _id_AC0E424AC96A7113.jailed == 0 || _id_AC0E424AC96A7113.gulagarena == 1) {
      scripts\mp\utility\script::demoforcesre("Player: " + _id_AC0E424AC96A7113.name + " - invalid for gulag - p.gulag = " + _id_AC0E424AC96A7113.gulag + ", p.jailed = " + _id_AC0E424AC96A7113.jailed + ", p.gulagArena = " + _id_AC0E424AC96A7113.gulagarena);
      _id_6AE446BBA4624713 = 1;
      continue;
    }

    _id_AC0E424AC96A7113.fighterindex = _id_AC0E594AC96AA3A8;
    _id_AC0E424AC96A7113 notify("beginNewFight");

    if(istrue(_id_AC0E424AC96A7113._id_04BB14F07087A5DA)) {
      if(istrue(level._id_37E52C7FB7267EFC._id_2713A9CF5318D984)) {
        foreach(_id_C5F4970069850479 in _func_B4B9401715CF98EA("gulag"))
        _id_C5F4970069850479 hudoutlinedisableforclient(_id_AC0E424AC96A7113);
      }

      _id_AC0E424AC96A7113._id_04BB14F07087A5DA = undefined;
      _id_AC0E424AC96A7113 setclientomnvar("ui_rcd_controls", 0);
      _id_AC0E424AC96A7113 cameraunlink();
    }
  }

  if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("setGulagVariationTeams"))
    arena _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("setGulagVariationTeams");

  foreach(player in arena.jailedplayers) {
    if(!isDefined(player)) {
      continue;
    }
    player.gulagposition--;

    if(level.gulag._id_EABA0D28010B979B) {
      if(!_id_46FDF7B12C5F5620::_id_7EFFA8A355DDC886() || istrue(_id_46FDF7B12C5F5620::_id_79FDF5CD036FF575())) {
        if(_id_03AA8E63A56E3416::_id_6E3541FD8FAB45BC()) {
          player scripts\mp\equipment::giveequipment("equip_rock", "primary");
          continue;
        }

        player setweaponammoclip("rock_mp", 5);
      }
    }
  }

  if(_id_6AE446BBA4624713) {
    _id_127C772F981AEFC1(arena);

    if(!validateplayers(arena)) {
      handleendarena(arena, undefined, 1);
      return;
    }
  }

  _id_4B434533D3624BEC = startbetting(arena, arena.arenaplayers);

  if(getdvarint("dvar_30C3E9D4F1F094CF", 0))
    thread manageoutlines(arena, arena.arenaplayers, _id_4B434533D3624BEC);

  arena.arenaspawncounter = 0;
  loadoutindex = getloadoutindex();
  _id_CECBD3AA752B9087(arena.arenaplayers);

  foreach(player in arena.arenaplayers) {
    if(!isDefined(player)) {
      continue;
    }
    if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("gulagWatchPlayerDeath"))
      player thread _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("gulagWatchPlayerDeath", arena);
    else
      player thread gulagplayerwatchfordeath(arena, _id_4B434533D3624BEC);

    player thread initplayerarena(arena, 0, loadoutindex, "beginNewFight");
  }

  if(_id_5BC60484D17FA95C::_id_1980065CE4DC067B())
    arena thread _id_737F63F33471E8B5();

  thread watchlethaldelay(arena);

  if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("prepGulagArena"))
    level thread _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("prepGulagArena", arena);

  wait 2;

  if(!validateplayers(arena)) {
    handleendarena(arena, _id_4B434533D3624BEC, 1);
    return;
  }

  updatearenaomnvarplayers(arena);

  if(!_id_5BC60484D17FA95C::_id_1980065CE4DC067B())
    updatearenaomnvardata(arena);

  result = gulagcountdowntimer(arena, 1, _id_4B434533D3624BEC);

  if(!result) {
    return;
  }
  endbetting(arena, _id_4B434533D3624BEC);

  foreach(player in arena.arenaplayers) {
    if(!isDefined(player)) {
      continue;
    }
    player playergulagarenaready();
    player thread playershowarenastartobjectivetext();
  }

  if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("startGulagSequence"))
    level thread _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("startGulagSequence", arena);

  thread startfightvo(arena);
  wait(getdvarfloat("dvar_61F7016B7E176B11", 0.8));
  arena.time = level.gulag.timelimit;
  updatematchtimerhud(arena, arena.time);

  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("accelerateBotsGulagMatch"))
    _id_362C58E8BB39BCDA::runbrgametypefunc("accelerateBotsGulagMatch", arena);

  waittillgulagmatchend(arena, 1);
  handleendarena(arena, _id_4B434533D3624BEC);

  if(!isfightready(arena))
    updateplayeromnvarsallmatches(arena);
}

_id_E604F37BC584077D(arena) {
  foreach(player in arena._id_654C981854394718) {
    _id_F0EA4030349A33D5 = player;

    foreach(_id_AC0E424AC96A7113 in arena._id_654C981854394718) {
      if(player == _id_AC0E424AC96A7113) {
        continue;
      }
      if(player.team == _id_AC0E424AC96A7113.team) {
        continue;
      }
      _id_453624B0CAE6AD9E = [_id_F0EA4030349A33D5, _id_AC0E424AC96A7113];
      return _id_453624B0CAE6AD9E;
    }
  }
}

_id_C9861A6C6B4085D8(_id_607899D4420FE1A5, arena) {
  if(level._id_43307855F189EB31._id_10C30E8082648B35 && _id_607899D4420FE1A5.size < getmaxplayers() && isDefined(arena._id_654C981854394718) && arena._id_654C981854394718.size >= level._id_43307855F189EB31._id_0BD9294679812B88)
    return 1;
  else
    return 0;
}

watchlethaldelay(arena) {
  arena endon("fight_over");
  arena endon("matchEnded");
  level endon("game_ended");

  if(level.gulag.lethaldelay <= 0) {
    return;
  }
  arena.lethaldelaystarttime = gettime();
  arena.lethaldelayendtime = arena.lethaldelaystarttime + level.gulag.lethaldelay * 1000 + _id_59D019F0169C03BE() * 1000 + 2000;

  while(gettime() < arena.lethaldelayendtime)
    waitframe();

  arena notify("lethal_delay_end");
}

watchlethaldelayplayer(arena) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(level.gulag.lethaldelay == 0) {
    return;
  }
  if(!isai(self)) {
    self notifyonplayercommand("lethal_attempt_gulag", "+frag");
    self notifyonplayercommand("lethal_attempt_gulag", "+smoke");
  }

  _id_3B64EB40368C1450::set("watchLethalDelayPlayer", "equipment_primary", 0);
  _id_3B64EB40368C1450::set("watchLethalDelayPlayer", "equipment_secondary", 0);
  self setclientomnvar("ui_br_gulag_lethal_delay", 1);
  watchlethaldelayfeedbackplayer(arena, self);
  self setclientomnvar("ui_br_gulag_lethal_delay", 0);
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("watchLethalDelayPlayer");
  self playlocalsound("ui_restock_lethals");
  self setclientomnvar("ui_recharge_notify", 2);

  if(!isai(self)) {
    self notifyonplayercommandremove("lethal_attempt_gulag", "+frag");
    self notifyonplayercommandremove("lethal_attempt_gulag", "+smoke");
  }
}

watchlethaldelayfeedbackplayer(arena, player) {
  level endon("game_ended");
  arena endon("matchEnded");
  arena endon("lethal_delay_end");

  for(;;) {
    self waittill("lethal_attempt_gulag");

    if(isDefined(arena.lethaldelayendtime)) {
      n = (arena.lethaldelayendtime - gettime()) / 1000;
      n = int(max(0, ceil(n)));
      player scripts\mp\hud_message::showerrormessage("MP/LETHALS_UNAVAILABLE_FOR_N", n);
    }
  }
}

startfightvo(arena) {
  arena endon("matchEnded");
  playsoundatpos(arena.center, "evt_br_gulag_round_start_buzzer");
  wait 2;
  _id_2CEDCC356F1B9FC8::brleaderdialog("gulag_gulag_active", 0, arena.jailedplayers);

  foreach(player in arena.jailedplayers) {
    if(player.gulagposition <= 1) {
      _id_2CEDCC356F1B9FC8::brleaderdialogplayer("gulag_next", player, 0);
      continue;
    }

    if(player.gulagposition == 2)
      _id_2CEDCC356F1B9FC8::brleaderdialogplayer("gulag_taunt", player, 0);
  }

  wait 3;
}

playershowarenastartobjectivetext() {
  self endon("disconnect");
  self setclientomnvar("ui_objective_text", 0);
  wait 3;
  self setclientomnvar("ui_objective_text", -1);
}

handleonekillwin(arena, victim, attacker, _id_4B434533D3624BEC) {
  if(isDefined(attacker) && isPlayer(attacker) && victim != attacker && isalive(attacker) && scripts\engine\utility::array_contains(arena.arenaplayers, attacker)) {
    thread gulagvictory(arena, attacker, 0, 0, "winner");
    payoutbet(_id_4B434533D3624BEC, attacker, 1);
  }

  payoutbet(_id_4B434533D3624BEC, victim, 0);
}

manageoutlines(arena, fighters, _id_4B434533D3624BEC) {
  manageoutlineactive(arena, fighters, _id_4B434533D3624BEC);

  if(istrue(level.gulag.onekillwin)) {
    return;
  }
  manageoutlinecleanup(arena, fighters);
}

manageoutlineswatchplayersaddedtojail(arena) {
  arena endon("fight_over");

  for(;;) {
    arena waittill("player_added_to_jail");
    updateoutlines(arena);
  }
}

manageoutlineactive(arena, fighters, _id_4B434533D3624BEC) {
  arena endon("fight_over");
  thread manageoutlineswatchplayersaddedtojail(arena);

  for(;;) {
    if(arena.jailedplayers.size) {
      _id_BE4E32B47AD61C7D = scripts\engine\utility::array_removeundefined(arena.jailedplayers);

      foreach(_id_4570788876702376 in fighters) {
        if(!isDefined(_id_4570788876702376)) {
          continue;
        }
        _id_4570788876702376 hudoutlineenableforclients(_id_BE4E32B47AD61C7D, "outline_nodepth_white");
      }
    }

    if(isDefined(_id_4B434533D3624BEC)) {
      foreach(_id_B5FE9E03C0FD6170 in _id_4B434533D3624BEC.bets) {
        if(!isDefined(_id_B5FE9E03C0FD6170.owner)) {
          continue;
        }
        _id_A9A8CB34A49CAAAA = scripts\engine\utility::ter_op(_id_4B434533D3624BEC.bettingopen, _id_B5FE9E03C0FD6170.playerfocus, _id_B5FE9E03C0FD6170.playerbeton);

        if(_id_A9A8CB34A49CAAAA != -1) {
          _id_BA2CB2090F002D2C = _id_4B434533D3624BEC.fighters[_id_A9A8CB34A49CAAAA];

          if(isDefined(_id_BA2CB2090F002D2C))
            _id_BA2CB2090F002D2C hudoutlineenableforclient(_id_B5FE9E03C0FD6170.owner, "outline_nodepth_green");
        }
      }
    }

    arena waittill("update_outlines");
  }
}

manageoutlinecleanup(arena, fighters) {
  players = scripts\engine\utility::array_removeundefined(arena.jailedplayers);

  if(!players.size) {
    return;
  }
  foreach(_id_4570788876702376 in fighters) {
    if(!isDefined(_id_4570788876702376)) {
      continue;
    }
    _id_4570788876702376 hudoutlinedisableforclients(players);
  }
}

updateoutlines(arena) {
  arena notify("update_outlines");
}

playergulagarenaready() {
  playerstartarenasetcontrols(1, "playerGulagArenaReady");
  self setclientomnvar("ui_br_infil_started", 1);
  self setclientomnvar("ui_match_start_countdown", 0);
  self setclientomnvar("ui_match_in_progress", 1);

  if(istrue(level.gulag.gestures_enabled) && !isbot(self))
    playergulaggesturesdisable();
}

_id_B0FDA2BBB0C12AC2(_id_6958D396E4AD3B95) {
  player = self;
  player endon("disconnect");
  level endon("game_ended");

  while(_id_6958D396E4AD3B95 > 0) {
    player setclientomnvar("ui_match_in_progress", 0);
    player setclientomnvar("ui_match_start_countdown", _id_6958D396E4AD3B95);
    _id_6958D396E4AD3B95 = _id_6958D396E4AD3B95 - 1;
    wait 1;
  }

  player setclientomnvar("ui_match_in_progress", 1);
  player setclientomnvar("ui_match_start_countdown", _id_6958D396E4AD3B95);
  player setclientomnvar("ui_br_gulag_match_state", 2);
}

gulagcountdowntimer(arena, _id_57A9DF666229CEAB, _id_4B434533D3624BEC) {
  timer = _id_59D019F0169C03BE();

  while(timer > 0) {
    foreach(player in arena.arenaplayers) {
      player setclientomnvar("ui_match_in_progress", 0);
      player setclientomnvar("ui_match_start_countdown", timer);
      player setclientomnvar("ui_br_gulag_match_state", 1);
    }

    timer = timer - 1;
    wait 1;

    if(istrue(_id_57A9DF666229CEAB) && !validateplayers(arena)) {
      handleendarena(arena, _id_4B434533D3624BEC, 1);
      return 0;
    }
  }

  foreach(player in arena.arenaplayers)
  player setclientomnvar("ui_br_gulag_match_state", 2);

  return 1;
}

_id_FA7156B785ECF3EB(_id_8DD9F2EB8215A139) {
  player = self;
  level endon("game_ended");
  player endon("individualWaittillGulagMatchEnd");
  player endon("gulagLost");
  player endon("gulag_end");
  player endon("death_or_disconnect");
  wait(_id_8DD9F2EB8215A139);
  _id_8DD9F2EB8215A139 = 10;
  _id_14CCD6E81FCE3BD4 = scripts\mp\gamelogic::getclocksoundaliasfortimeleft(_id_8DD9F2EB8215A139);

  while(_id_8DD9F2EB8215A139 > 0) {
    if(!isDefined(player)) {
      return;
    }
    player playlocalsound(_id_14CCD6E81FCE3BD4);
    _id_8DD9F2EB8215A139 = _id_8DD9F2EB8215A139 - 1;
    wait 1;
  }
}

gulagmatchclocksounds(arena, _id_8DD9F2EB8215A139, _id_55C0E7E44829E72E) {
  arena endon("matchEnded");

  while(_id_8DD9F2EB8215A139 > 0) {
    if(level.gameended) {
      return;
    }
    _id_526074C408160449 = _id_8DD9F2EB8215A139;

    if(!istrue(arena.overtime))
      _id_526074C408160449 = _id_526074C408160449 - _id_55C0E7E44829E72E;

    if(_id_526074C408160449 <= 10) {
      _id_14CCD6E81FCE3BD4 = scripts\mp\gamelogic::getclocksoundaliasfortimeleft(_id_526074C408160449);
      doclocksound(arena, _id_14CCD6E81FCE3BD4);
    }

    if(_id_8DD9F2EB8215A139 > 1)
      _id_8DD9F2EB8215A139 = _id_8DD9F2EB8215A139 - 1;

    wait 1;
  }
}

doclocksound(arena, _id_14CCD6E81FCE3BD4) {
  foreach(player in arena.jailedplayers) {
    if(isDefined(player))
      player playlocalsound(_id_14CCD6E81FCE3BD4);
  }

  foreach(player in arena.arenaplayers) {
    if(isDefined(player))
      player playlocalsound(_id_14CCD6E81FCE3BD4);
  }
}

getovertimelength() {
  if(_id_5BC60484D17FA95C::_id_2C600E5E9A2CF916("gulagOvertime"))
    return 0;

  if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("gulagGetOvertimeLength"))
    return _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("gulagGetOvertimeLength");
  else
    return getdvarint("dvar_1FF83F4F24656C5B", 15.0);
}

_id_59D019F0169C03BE() {
  if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("gulagGetCountdownLength"))
    return _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("gulagGetCountdownLength");
  else
    return getdvarint("dvar_0FB05C5F6825931D", 3);
}

_id_6C8F212282E139D6(arena, waittime) {
  player = self;
  player endon("game_ended");
  player notify("individualWaittillGulagMatchEnd");
  player endon("individualWaittillGulagMatchEnd");
  player endon("gulagLost");
  player endon("gulag_end");
  player endon("death");

  if(_id_0B0385BB45379222::_id_9005AF34E01BF8FE())
    player scripts\engine\utility::waittill_notify_or_timeout("gulag_done_with_camera_sequence", 8);

  player thread _id_FA7156B785ECF3EB(waittime - 10);
  wait(waittime);
  player thread gulagplayerlost(arena);
}

waittillgulagmatchend(arena, _id_1A93CF0BA17E0DC0) {
  _id_55C0E7E44829E72E = getovertimelength();
  arena.time = arena.time + _id_55C0E7E44829E72E;
  thread gulagmatchclocksounds(arena, arena.time, _id_55C0E7E44829E72E);

  for(;;) {
    if(!isanyonealive(arena) || isoneteamleft(arena)) {
      break;
    }

    arena.time = arena.time - level.framedurationseconds;
    _id_E74CDBC9111D53C7 = !_id_5BC60484D17FA95C::_id_2C600E5E9A2CF916("gulagOvertime");
    _id_CFB635535EC1FF70 = _id_5BC60484D17FA95C::_id_1980065CE4DC067B();
    _id_727C25D029B3B5AF = _id_CFB635535EC1FF70 && _id_E74CDBC9111D53C7;

    if((_id_727C25D029B3B5AF || !_id_CFB635535EC1FF70) && (!istrue(arena.overtime) && arena.time <= _id_55C0E7E44829E72E)) {
      arena.overtime = 1;

      if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("gulagOvertimeStart"))
        arena thread _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("gulagOvertimeStart");

      if(istrue(level.gulag.arenaflag) && arena.arenaplayers.size <= 2) {
        arena.dom.arenaflag arenaflag_setenabled(1);
        arena.dom.arenaflag arenaflag_setvisible(arena, 1);
        arena.dom.arenaflag.flagmodel playsoundonmovingent("flag_spawned");
      }

      foreach(player in arena.arenaplayers) {
        if(!isDefined(player)) {
          continue;
        }
        player setclientomnvar("ui_br_gulag_match_state", 3);
        player setclientomnvar("ui_br_gulag_match_end_time", gettime() + int(arena.time * 1000));
      }
    }

    if(istrue(arena.overtime)) {
      progress = clamp(arena.time / _id_55C0E7E44829E72E, 0.0, 1.0);
      setovertimeomnvarprogress(arena, progress);
    }

    if(arena.time <= 0) {
      waittillarenaplayersnotcapturing(arena);

      if(istrue(_id_1A93CF0BA17E0DC0)) {
        foreach(player in arena.arenaplayers) {
          if(!isDefined(player)) {
            continue;
          }
          if(_id_5BC60484D17FA95C::_id_1980065CE4DC067B() && istrue(player._id_4AF73CE40A5D8572)) {
            continue;
          }
          player setclientomnvar("ui_br_gulag_match_state", 6);
          player thread gulagplayerlost(arena, undefined, 1);
          _id_1146C25A252F6B0E = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_gulag_lose");
          _id_AF0951BBDBF11435 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_gulag_lose_classic");

          if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1)
            player setplayermusicstate(_id_AF0951BBDBF11435);
          else
            player setplayermusicstate(_id_1146C25A252F6B0E);

          player clearclienttriggeraudiozone(2);

          if(isstring("") && 0 && soundexists(""))
            player playsoundtoplayer("", player);
        }
      }

      break;
    }

    if(_id_46FDF7B12C5F5620::_id_7EFFA8A355DDC886() && arena.arenaplayers.size <= 0) {
      break;
    }

    waitframe();
  }

  arena notify("matchEnded");
}

waittillarenaplayersnotcapturing(arena) {
  if(_id_5BC60484D17FA95C::_id_1980065CE4DC067B()) {
    return;
  }
  while(istrue(level.gulag.arenaflag) && isDefined(arena.dom.arenaflag.claimteam) && arena.dom.arenaflag.claimteam != "none" && !istrue(arena.dom.arenaflag.stalemate))
    waitframe();
}

isanyonealive(arena) {
  foreach(player in arena.arenaplayers) {
    if(isalive(player))
      return 1;
  }

  return 0;
}

isoneteamleft(arena) {
  if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("gulagIsOneTeamLeft"))
    return _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("gulagIsOneTeamLeft");

  _id_06F4191369A7F931 = undefined;

  foreach(player in arena.arenaplayers) {
    if(isalive(player)) {
      if(!isDefined(_id_06F4191369A7F931)) {
        _id_06F4191369A7F931 = player.team;
        continue;
      }

      if(_id_06F4191369A7F931 != player.team)
        return 0;
    }
  }

  return 1;
}

handleendarena(arena, _id_4B434533D3624BEC, _id_88EF856FAEFB28D6, _id_BF7470006675932E, _id_DF2FBB13C226BE75, _id_4AC881E2A39322A5) {
  arena notify("fight_over");
  arena.fightover = 1;

  if(!isDefined(_id_DF2FBB13C226BE75))
    _id_DF2FBB13C226BE75 = "winner";

  endbetting(arena, _id_4B434533D3624BEC);
  updatematchtimerhud(arena, 0);
  winner = undefined;

  foreach(player in arena.arenaplayers) {
    if(!isDefined(player)) {
      continue;
    }
    if(isalive(player)) {
      winner = player;

      if(istrue(_id_88EF856FAEFB28D6))
        winner playergulagarenaready();

      if(!_id_5BC60484D17FA95C::_id_1980065CE4DC067B()) {
        if(isDefined(_id_4AC881E2A39322A5) && player.team == _id_4AC881E2A39322A5.team) {
          thread gulagvictory(arena, player, 0, 0, _id_DF2FBB13C226BE75, 0, _id_4AC881E2A39322A5, _id_BF7470006675932E);
          continue;
        }

        thread gulagvictory(arena, player, 0, 0, "winner");
      }
    }
  }

  if(istrue(level.gulag.arenaflag))
    arena.dom.arenaflag arenaflag_setenabled(0);

  payoutremainingbets(winner, _id_4B434533D3624BEC);
  wait(_id_86EE3121D91C59C3());

  if(!_id_5BC60484D17FA95C::_id_2C600E5E9A2CF916("gulagOvertime"))
    arena.overtime = 0;

  if(istrue(level.gulag.arenaflag))
    arena.dom.arenaflag arenaflag_setvisible(arena, 0);

  cleanuparenamolotovs(arena);
  wait(_id_4BB92764539FFF5D());
}

playerpulloutofgulagwin(_id_4AC881E2A39322A5, _id_DF2FBB13C226BE75) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isDefined(self.arena)) {
    return;
  }
  arena = self.arena;

  if(istrue(self.wasingulag)) {
    self notify("pull_out_of_gulag");

    if(!isalive(self)) {
      thread playergulagautowin("playerPullOutOfGulagWin", _id_4AC881E2A39322A5);
      return;
    } else if(istrue(self.br_iseliminated)) {
      _id_0A34750D17473C49::unmarkplayeraseliminated(self, "playerPullOutOfGulagWin");
      level thread _id_1E4A61DB11011446::updateplayerandteamcountui();
    }
  } else if(istrue(self.gulagarena)) {
    if(!arena.fightover) {
      if(_id_5BC60484D17FA95C::_id_1980065CE4DC067B())
        _id_03AA8E63A56E3416::_id_9135ADA02E07BF10(arena, "br_twotwo_gulag_win", 0);

      arena notify("matchEnded");
      arena notify("fight_over_early");
      thread handleendarena(arena, undefined, 1, 1, _id_DF2FBB13C226BE75, _id_4AC881E2A39322A5);
    }

    return;
  } else {
    self endon("gulag_end");
    arena.jailedplayers = scripts\engine\utility::array_remove(arena.jailedplayers, self);
    updatematchqueuepositions(arena);

    if(istrue(self.gulag) && !istrue(self.jailed))
      self waittill("gulag_start");
  }

  thread gulagvictory(arena, self, 1, 0, _id_DF2FBB13C226BE75, 0, _id_4AC881E2A39322A5, 1);
}

getnextjailspawn(arena) {
  if(_id_0B0385BB45379222::_id_9005AF34E01BF8FE())
    return arena._id_C379148A901939AC;

  if(isDefined(arena.jailspawncounter)) {
    arena.jailspawncounter++;
    arena.jailspawncounter = arena.jailspawncounter % arena.jailspawns.size;
  } else
    arena.jailspawncounter = 0;

  _id_8F5D6F42D8464DE0 = arena.jailspawns[arena.jailspawncounter];
  return _id_8F5D6F42D8464DE0;
}

outlinewatchplayerprox(_id_27C0612CFD76EE91) {
  self endon("death");
  self endon("trigger");
  self.outlinedplayers = [];

  switch (_id_27C0612CFD76EE91) {
    case 0:
    default:
      _id_4430B08D5A2D47BF = "outline_depth_white";
      break;
    case 1:
      _id_4430B08D5A2D47BF = "outline_depth_green";
      break;
    case 2:
      _id_4430B08D5A2D47BF = "outline_depth_cyan";
      break;
    case 3:
      _id_4430B08D5A2D47BF = "outline_depth_red";
      break;
    case 4:
      _id_4430B08D5A2D47BF = "outline_depth_orange";
      break;
  }

  for(;;) {
    players = scripts\common\utility::playersinsphere(self.origin, 2000);
    _id_7FD6D4B3D9F7CAD3 = scripts\engine\utility::array_difference(level.players, players);

    foreach(player in players) {
      dist = distancesquared(self.origin, player.origin);
      entnum = player getentitynumber();

      if(!isDefined(self.outlinedplayers[entnum]))
        self.outlinedplayers[entnum] = scripts\mp\utility\outline::outlineenableforplayer(self, player, _id_4430B08D5A2D47BF, "level_script");
    }

    foreach(player in _id_7FD6D4B3D9F7CAD3) {
      entnum = player getentitynumber();

      if(isDefined(self.outlinedplayers[entnum])) {
        scripts\mp\utility\outline::outlinedisable(self.outlinedplayers[entnum], self);
        self.outlinedplayers[entnum] = undefined;
      }
    }

    waitframe();
  }
}

gulagstreamlocationstart(_id_11F3B4465C8B637B) {
  if((isbot(self) || self isplayerheadless()) && !istrue(self.longgulagstream))
    return 0;

  if(getdvarint("dvar_723A4B3AC39BC3E2", 0))
    return 0;

  self setallstreamloaddist(10000.0);
  self _meth_670863FC4008C3D8(_id_11F3B4465C8B637B);
  return 1;
}

gulagstreamlocationwait() {
  if(!istrue(self.longgulagstream)) {
    self endon("gulagStreamLocationComplete");
    thread gulagstreamlocationwaittimeout(level.gulag.streamtimeout);

    while(!self isadditionalstreamposready())
      waitframe();

    self notify("gulagStreamLocationComplete");
  } else
    wait(level.gulag.streamtimeout);
}

gulagstreamlocationwaittimeout(timelimit) {
  self endon("disconnect");
  self endon("gulagStreamLocationComplete");
  wait(timelimit);
  self notify("gulagStreamLocationComplete");
}

gulagstreamlocationend() {
  self clearadditionalstreampos();
  self notify("gulagStreamLocationComplete");
}

addloadingplayer(arena, player) {
  player.entergulagwait = 1;
  arena.loadingplayers[arena.loadingplayers.size] = player;
  thread addloadingplayerdisconnectwatch(arena, player);
}

addloadingplayerdisconnectwatch(arena, player) {
  player endon("removeLoadingPlayer");
  player waittill("disconnect");
  thread removeloadingplayer(arena, player);
}

removeloadingplayer(arena, player) {
  player notify("removeLoadingPlayer");

  if(isDefined(player))
    arena.loadingplayers = scripts\engine\utility::array_remove(arena.loadingplayers, player);
  else
    arena.loadingplayers = scripts\engine\utility::array_removeundefined(arena.loadingplayers);

  if(arena.loadingplayers.size == 0)
    arena notify("loadingPlayersEmpty");
}

isplayerloading(player, arena) {
  return scripts\engine\utility::array_contains(arena.loadingplayers, player);
}

entergulag(player) {
  player notify("enter_gulag");
  player.entergulagwait = 0;
  scripts\mp\deathicons::hidedeathicon(player);
}

entergulagwait(player) {
  if(player.entergulagwait)
    player waittill("enter_gulag");
}

playergetnextarena() {
  _id_94AFB7D602135955 = getdvarint("dvar_8BDEE07FA09E810A", -1);

  if(_id_94AFB7D602135955 > -1)
    return level.gulag.arenas[_id_94AFB7D602135955];

  if(!istrue(level.gulag.multiarena))
    return level.gulag.arenas[0];

  if(isDefined(self._id_94AFB7D602135955)) {
    arena = level.gulag.arenas[self._id_94AFB7D602135955];

    if(isDefined(arena)) {
      self._id_94AFB7D602135955 = undefined;
      return arena;
    }
  }

  _id_5DD209C141F918FA = undefined;
  besttime = undefined;

  foreach(arena in level.gulag.arenas) {
    foreach(_id_AA9F4C033D62BC8A in arena.matches) {
      if(_id_AA9F4C033D62BC8A.size == 1 && isDefined(_id_AA9F4C033D62BC8A[0]) && _id_AA9F4C033D62BC8A[0].team != self.team && (!isDefined(_id_5DD209C141F918FA) || _id_AA9F4C033D62BC8A[0].jailtime < besttime)) {
        _id_5DD209C141F918FA = arena;
        besttime = _id_AA9F4C033D62BC8A[0].jailtime;
      }
    }
  }

  if(isDefined(_id_5DD209C141F918FA))
    return _id_5DD209C141F918FA;

  _id_F46E3D7B18FB28A4 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.gulag.arenas.size; _id_AC0E594AC96AA3A8++) {
    arena = level.gulag.arenas[_id_AC0E594AC96AA3A8];

    if(arena.matches.size > 0 && arena.matches.size < level.gulag.maxqueue)
      _id_F46E3D7B18FB28A4[_id_F46E3D7B18FB28A4.size] = arena;
  }

  if(_id_F46E3D7B18FB28A4.size > 0) {
    foreach(arena in _id_F46E3D7B18FB28A4) {
      foreach(_id_AA9F4C033D62BC8A in arena.matches) {
        foreach(player in _id_AA9F4C033D62BC8A) {
          if(isDefined(player) && player.team == self.team)
            return arena;
        }
      }
    }

    arena = _id_F46E3D7B18FB28A4[randomint(_id_F46E3D7B18FB28A4.size)];
    return arena;
  }

  _id_5DD209C141F918FA = undefined;
  _id_93D79749948AE532 = undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.gulag.arenas.size; _id_AC0E594AC96AA3A8++) {
    arena = level.gulag.arenas[_id_AC0E594AC96AA3A8];

    if(arena.matches.size == 0)
      return arena;
    else if(!isDefined(_id_93D79749948AE532) || arena.matches.size < _id_93D79749948AE532) {
      _id_5DD209C141F918FA = arena;
      _id_93D79749948AE532 = arena.matches.size;
    }
  }

  return _id_5DD209C141F918FA;
}

_id_6A7526F387D26776(_id_AA9F4C033D62BC8A) {
  player = self;
  _id_B239B59420D81775 = 0;

  foreach(_id_D7836AB41DCA3E4A in _id_AA9F4C033D62BC8A) {
    if(_id_D7836AB41DCA3E4A.team == player.team)
      _id_B239B59420D81775++;
  }

  return _id_B239B59420D81775;
}

isplayermatched(arena, player) {
  if(isDefined(player.gulagposition) && player.gulagposition == 0)
    return 1;

  if(!ismatchpending(arena)) {
    if(level.gulag._id_C489BD0446D6B041)
      logstring("[GULAG DEBUG] : Player " + player.clientid + " did not have a match pending. Time : " + gettime() + ". Number of players in the queue for gulag are : " + arena.matches.size + " .");

    return 0;
  }

  _id_B94827C01CB82F1E = player.gulagposition - 1;
  _id_4462160DC5261E62 = 1;

  if(_id_5BC60484D17FA95C::_id_1980065CE4DC067B())
    _id_4462160DC5261E62 = 3;

  if(_id_B94827C01CB82F1E >= 0 && isDefined(arena.matches[_id_B94827C01CB82F1E]) && arena.matches[_id_B94827C01CB82F1E].size > _id_4462160DC5261E62)
    return 1;

  return 0;
}

setjailtimeouthud(arena) {
  foreach(player in arena.jailedplayers) {
    if(!isplayermatched(arena, player) && isDefined(player.jailtimeoutend) && !isDefined(player.jailtimeouthud)) {
      player setclientomnvar("ui_br_gulag_match_end_time", player.jailtimeoutend);
      player.jailtimeouthud = 1;
    }
  }
}

playerclearjailtimeouthud(arena) {
  self.jailtimeoutend = undefined;
  self.jailtimeouthud = undefined;
  self setclientomnvar("ui_br_gulag_match_end_time", 0);
}

playerjailtimeout(arena) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("initPlayerArena");
  self endon("gulag_end");

  if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
    self endon("jailbreak_respawn");

  if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("gulagJailTimeout"))
    _id_74B5B12BB6514385 = _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("gulagJailTimeout");
  else
    _id_74B5B12BB6514385 = getdvarint("dvar_E5F703A38F6E8043", 95);

  if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("gulagLeftoverJailTimeout"))
    _id_28A6AF230364B2B7 = _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("gulagLeftoverJailTimeout");
  else
    _id_28A6AF230364B2B7 = 0;

  if(_id_74B5B12BB6514385 <= 0) {
    return;
  }
  _id_677CEE91234C35A7 = _id_74B5B12BB6514385 + _id_28A6AF230364B2B7;
  self.jailtimeoutend = int(gettime() + _id_677CEE91234C35A7 * 1000);
  wait(_id_74B5B12BB6514385);

  if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("onGulagJailTimeout"))
    thread _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("onGulagJailTimeout", arena, self);

  wait(_id_28A6AF230364B2B7);

  if(isplayermatched(arena, self)) {
    _id_F0B41805AA72794B = self.gulagposition * (level.gulag.timelimit + getovertimelength() + _id_59D019F0169C03BE() + 2 + _id_86EE3121D91C59C3() + _id_4BB92764539FFF5D() + 1);
    timeout = gettime() + _id_F0B41805AA72794B * 1000;

    while(timeout > gettime() && isplayermatched(arena, self))
      waitframe();
  }

  while(isgulagpaused())
    waitframe();

  while(self isinexecutionvictim())
    waitframe();

  _id_DF2FBB13C226BE75 = "timeout";

  if(_id_5BC60484D17FA95C::_id_1980065CE4DC067B())
    _id_DF2FBB13C226BE75 = "br_twotwo_gulag_win_jail_timeout";

  thread gulagvictory(arena, self, 1, 0, _id_DF2FBB13C226BE75);
}

_id_DD93503CF95B6277() {
  player = self;

  if(!isDefined(player.gulaguses))
    self.gulaguses = 0;

  _id_5A1DC05DC32C2300 = player _id_4A25D64251FAB1B7();
  player _id_2CEDCC356F1B9FC8::_id_E58801ACF7ADCDC8(_id_5A1DC05DC32C2300);
}

initplayerjail(_id_5643932DE03D949D) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("gulag_end");
  self endon("jailbreak_respawn");
  self.jailtime = gettime();
  self.gulagloser = undefined;

  if(_id_46FDF7B12C5F5620::_id_7EFFA8A355DDC886())
    self._id_D95581FDFC29EC7A = gettime();

  _id_715028F54BAD19A1::branalytics_gulagstart(self, scripts\engine\utility::ter_op(istrue(_id_5643932DE03D949D), "default", "debug"));

  if(level.gulag._id_C489BD0446D6B041)
    logstring("[GULAG DEBUG] : Player " + self.clientid + " passes jail entrance step 01. Time : " + gettime() + " .");

  playerpreloadintrocinematic();

  if(_id_5BC60484D17FA95C::_id_1980065CE4DC067B())
    arena = _id_3583FF375AB3A91E::_id_D095C23873D8EFED();
  else
    arena = playergetnextarena();

  self.arena = arena;

  if(isDefined(arena.gulagindex)) {
    _id_FCC20B643699A386 = arena.gulagindex + 1;
    scripts\mp\codcasterclientmatchdata::_id_F8B808CD6473E6CC(23, _id_FCC20B643699A386);
  }

  if(!scripts\engine\utility::array_contains(arena.jailedplayers, self)) {
    arena notify("player_added_to_jail", self);
    arena.jailedplayers[arena.jailedplayers.size] = self;
  }

  if(_id_36F129F8CF15A219::_id_83FEEDA09E1A148E() && arena.arenaplayers.size > 0) {
    foreach(_id_AC0E424AC96A7113 in arena.arenaplayers)
    _id_3583FF375AB3A91E::_id_DA46DE174875958A(_id_AC0E424AC96A7113);
  }

  playergulaghud(arena);
  thread playerwatchdisconnect(arena);
  updatematchqueuepositions(arena);

  if(level.gulag._id_C489BD0446D6B041)
    logstring("[GULAG DEBUG] : Player " + self.clientid + " enters jail entrance step 02. Time : " + gettime() + ". Player in next gulag position : " + arena.matches[0][0].clientid + " . Number of players in the queue for gulag are : " + arena.matches.size + " .");

  addloadingplayer(arena, self);
  gulaglaststandholdremove(self);

  if(!isDefined(self.gulaguses))
    self.gulaguses = 0;

  self.gulaguses++;
  _id_DD93503CF95B6277();

  if(_id_03AA8E63A56E3416::_id_6E3541FD8FAB45BC()) {
    if(_id_3583FF375AB3A91E::_id_D8F18F1D691C0EF8(arena) && level._id_43307855F189EB31._id_CB1A9A6651A906DF < 4) {
      _id_5C7F3CEA21F3B966 = "gulagspectators" + arena.gulagindex;

      if(!threatbiasgroupexists(_id_5C7F3CEA21F3B966))
        createthreatbiasgroup(_id_5C7F3CEA21F3B966);

      self setthreatbiasgroup(_id_5C7F3CEA21F3B966);
    }

    _id_03AA8E63A56E3416::_id_6D217BA4DE4B166B(arena);
    _id_03AA8E63A56E3416::_id_FB51BDAA21D694E5(arena);
  }

  setplayervargulag(1);
  setplayervargulagarena(0);
  setplayeringulagjailextrainfo(1);
  setplayergulagindex(arena);

  if(isDefined(level.checkforlaststandwipe))
    [[level.checkforlaststandwipe]]();

  _id_8F5D6F42D8464DE0 = getnextjailspawn(arena);
  spawnorigin = getgroundposition(_id_8F5D6F42D8464DE0.origin, 12);
  spawnangles = (0, 0, 0);

  if(isDefined(_id_8F5D6F42D8464DE0.angles))
    spawnangles = _id_8F5D6F42D8464DE0.angles;

  _id_3F39A8B789073E7B = gulagstreamlocationstart(spawnorigin);
  self.gulagloading = 1;
  self.streampoint = spawnStruct();
  self.streampoint.origin = spawnorigin;
  self.streampoint.angles = spawnangles;

  if(istrue(_id_5643932DE03D949D))
    entergulagwait(self);
  else
    entergulag(self);

  if(level.gulag._id_C489BD0446D6B041)
    logstring("[GULAG DEBUG] : Player " + self.clientid + " enters jail entrance step 03. Time : " + gettime() + ". Player passed enterGulagWait. Number of players in the queue for gulag are : " + arena.matches.size + " .");

  scripts\mp\outofbounds::enableoobimmunity(self);
  _id_64ACB6CE534155B7::onplayerentergulag();
  _id_046CF752D93DC17B::_id_D545B198B75385F6();
  self.ignoreafkcheck = 1;
  starttime = gettime();

  if(_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF())
    self notify("play_gulag_vo");

  playerplayintrocinematic();
  _id_721982228624D657 = _id_6489FCDFE6FA2E36::_id_6D5206BDBA79E8C3(self);

  if(_id_721982228624D657.size > 0) {
    foreach(_id_2C6CA80E296FED3A in _id_721982228624D657)
    _id_2C6CA80E296FED3A thread _id_6489FCDFE6FA2E36::_id_4A8746C1AA6BB002(5.0, "gulagSceneFin");
  }

  if(_id_3F39A8B789073E7B) {
    _id_1E4A61DB11011446::spawnintermission(spawnorigin + (0, 0, 100), self.angles);
    scripts\mp\spectating::setdisabled();
    gulagstreamlocationstart(spawnorigin);
    gulagstreamlocationwait();
  }

  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("playerPreSpawnGulagJail"))
    _id_362C58E8BB39BCDA::runbrgametypefunc("playerPreSpawnGulagJail");

  if(level.gulag._id_C489BD0446D6B041)
    logstring("[GULAG DEBUG] : Player " + self.clientid + " enters jail entrance step 04. Time : " + gettime() + ". Player passed gulag stream location. Number of players in the queue for gulag are : " + arena.matches.size + " .");

  scripts\mp\class::loadout_emptycacheofloadout("gamemode");
  self.pers["gamemodeLoadout"] = level.gulag.jailloadout;
  self.class = "gamemode";
  self.forcespawnangles = spawnangles;
  self.forcespawnorigin = spawnorigin;
  self.reviver = undefined;
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  scripts\cp_mp\execution::_clearexecution();
  _id_2D9D24F7C63AC143::_id_5C5E6619F0B24F90();
  self setclientomnvar("ui_gulag", 1);
  self.streampoint = undefined;
  self.gulagloading = 0;
  _id_5BAB271917698DC4::resetplayermovespeedscale();

  if(_id_46FDF7B12C5F5620::_id_7EFFA8A355DDC886()) {
    self._id_22F8F8D138D3C02F = 0;
    _id_46FDF7B12C5F5620::_id_F071DB381E990D80();
  }

  if(_id_3F39A8B789073E7B)
    gulagstreamlocationend();

  if(_id_721982228624D657.size > 0) {
    foreach(_id_2C6CA80E296FED3A in _id_721982228624D657)
    _id_2C6CA80E296FED3A notify("gulagSceneFin");
  }

  playershowskippromptcinematic();
  playerwaittillcinematiccomplete(starttime);
  self setplayerangles((0, self.angles[1], 0));

  if(_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF())
    self clearsoundsubmix("iw8_br_gulag_tutorial", 2);
  else
    self clearsoundsubmix("solo_cin_igc_music", 2);

  self setclientomnvar("ui_br_infil_started", 1);
  _id_C497FB6AA47DDA29 = arena.fightover && playerismatchedplayerready(arena) && !isgulagpaused();

  if(!_id_C497FB6AA47DDA29)
    _id_5BAB271917698DC4::_id_E68E4BB4F65F5FE4();

  if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("gulag_startWaitingStartTime"))
    _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("gulag_startWaitingStartTime");

  gulagloadingtextclear();

  if(level.gulag.betting) {
    _id_D5F9260E2C6A3B63 = 3;

    if(isDefined(self.plundercountondeath))
      _id_D5F9260E2C6A3B63 = int(max(_id_D5F9260E2C6A3B63, int(self.plundercountondeath / 2)));

    _id_6AFF3948CF4CCA03::playersetplundercount(_id_D5F9260E2C6A3B63);
  }

  if(!_id_C497FB6AA47DDA29)
    _id_2CEDCC356F1B9FC8::brleaderdialogplayer("gulag_spawn", self, 0);

  foreach(_id_F0EA4030349A33D5 in level.teamdata[self.team]["players"]) {
    if(!isDefined(_id_F0EA4030349A33D5) || !isalive(_id_F0EA4030349A33D5)) {
      continue;
    }
    if(_id_F0EA4030349A33D5 != self) {
      _id_F0EA4030349A33D5 thread scripts\mp\hud_message::showsplash("br_gulag_teammate_in", undefined, self);
      _id_2CEDCC356F1B9FC8::brleaderdialogplayer("gulag_teammate_gulag", _id_F0EA4030349A33D5);
    }
  }

  if(!istrue(self.jailed)) {
    setplayervargulagjail(1);
    scripts\mp\utility\perk::blockperkfunction("specialty_scavenger");
  }

  _id_07C40FA80892A721::givestartingarmor(0, 0, 0);
  removeloadingplayer(arena, self);
  _id_7E52B56769FA7774::initplayer(1);

  if(istrue(level.gulag.gestures_enabled) && !isbot(self))
    thread playergulaggestures();

  playerstartjailsetcontrols(0);

  if(istrue(arena.overtime) && istrue(level.gulag.arenaflag))
    arena.dom.arenaflag thread arenaflag_setvisibleplayer(1, self);

  thread playerjailtimeout(arena);
  thread playerjailwaitvo(arena);
  _id_34CEBFCA4FDFB4F3();
  self notify("gulag_start", _id_C497FB6AA47DDA29);

  if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("gulagJailRockAmount"))
    _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("gulagJailRockAmount");

  if(level.gulag._id_C489BD0446D6B041)
    logstring("[GULAG DEBUG] : Player " + self.clientid + " enters jail entrance step 05. Time : " + gettime() + ". Player is fully in the gulag jail. Number of players in the queue for gulag are : " + arena.matches.size + " .");
}

playerjailwaitvo(arena) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("initPlayerArena");
  self endon("gulag_end");
  wait 5;

  if(ismatchpending(arena)) {
    return;
  }
  _id_2CEDCC356F1B9FC8::brleaderdialogplayer("gulag_obj_wait", self, 0);
}

playerstartjailsetcontrols(enable) {
  if(enable)
    self enableoffhandthrowback();
  else
    self disableoffhandthrowback();
}

playergulaggestures() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("gulag_gestures_stop");
  self enableoffhandweapons();
  self allowfire(0);
  self allowads(0);
  self notifyonplayercommand("fc_gesture_neg", "+attack");
  self notifyonplayercommand("fc_gesture_pos", "+speed_throw");
  _id_FEDCFC68053C9DDC = 0;

  for(;;) {
    _id_A8AB9599524F3865 = scripts\engine\utility::waittill_any_return_2("fc_gesture_neg", "fc_gesture_pos");

    if(self isgestureplaying() || self isswitchingweapon() || self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing()) {
      continue;
    }
    if(getdvarint("dvar_F66218D4C610A345", 0) > 0) {
      if(_id_FEDCFC68053C9DDC >= level.gulag.gestures[_id_A8AB9599524F3865].size)
        _id_FEDCFC68053C9DDC = 0;

      _id_7C64ADD76ADA24C9 = level.gulag.gesturesounds[_id_A8AB9599524F3865][_id_FEDCFC68053C9DDC];
      _id_E8562C6F1C5AA36F = level.gulag.gestures[_id_A8AB9599524F3865][_id_FEDCFC68053C9DDC];
      _id_FEDCFC68053C9DDC++;
    } else {
      _id_FEDCFC68053C9DDC = randomint(level.gulag.gestures[_id_A8AB9599524F3865].size);
      _id_7C64ADD76ADA24C9 = level.gulag.gesturesounds[_id_A8AB9599524F3865][_id_FEDCFC68053C9DDC];
      _id_E8562C6F1C5AA36F = level.gulag.gestures[_id_A8AB9599524F3865][_id_FEDCFC68053C9DDC];
    }

    if(isDefined(_id_7C64ADD76ADA24C9) && _id_7C64ADD76ADA24C9 != "")
      self playSound(_id_7C64ADD76ADA24C9);

    gestureweapon = makeweapon(_id_E8562C6F1C5AA36F);

    if(isDefined(gestureweapon) && !isnullweapon(gestureweapon))
      scripts\cp_mp\gestures::watchradialgesture(gestureweapon);
  }
}

playergulaggesturesdisable() {
  self notify("gulag_gestures_stop");
  self notifyonplayercommandremove("fc_gesture_neg", "+attack");
  self notifyonplayercommandremove("fc_gesture_pos", "+speed_throw");
  self allowfire(1);
  self allowads(1);
}

gulagloadingtext() {
  text = scripts\mp\hud_util::createfontstring("default", 1.5);
  text scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -100);
  text.label = &"MP/BR_GULAG_TRAVEL";
  self.gulagloadingtext = text;
}

gulagloadingtextclear() {
  if(isDefined(self.gulagloadingtext))
    self.gulagloadingtext destroy();
}

initplayerarena(arena, _id_C3E0E015DE4435FD, loadoutindex, _id_0228A5DE8E2CD330) {
  if(level.gulag._id_C489BD0446D6B041)
    logstring("[GULAG DEBUG] : Player " + self.clientid + " passed arena entrance step 00.5. Time : " + gettime() + ". Screen fade to black. Number of players in the queue for gulag are : " + arena.matches.size + " .");

  level endon("game_ended");
  self endon("disconnect");
  self notify("initPlayerArena");

  if(scripts\mp\utility\player::isinlaststand(self))
    self notify("last_stand_revived");

  _id_7E52B56769FA7774::initplayer();

  if(_id_46FDF7B12C5F5620::_id_7EFFA8A355DDC886()) {
    self._id_22F8F8D138D3C02F = 1;
    _id_46FDF7B12C5F5620::_id_F071DB381E990D80();
  }

  self allowprone(0);
  self allowcrouch(0);
  playerstartjailsetcontrols(1);
  playerstartarenasetcontrols(0, "initPlayerArena_" + scripts\engine\utility::_id_53C4C53197386572(_id_0228A5DE8E2CD330, ""));
  playertakeawayrock(arena);
  playerclearjailtimeouthud(arena);
  _id_3B64EB40368C1450::set("PlayerArena", "equipment_primary", 0);
  _id_3B64EB40368C1450::set("PlayerArena", "equipment_secondary", 0);

  if(!_id_5BC60484D17FA95C::_id_1980065CE4DC067B())
    thread playerhealthomnvarwatcher(arena);

  if(istrue(_id_C3E0E015DE4435FD)) {
    setplayervargulagjail(0);
    setplayervargulagarena(1);
    playergivearenaloadout(arena, loadoutindex);

    if(level.gulag.lethaldelay > 0)
      thread watchlethaldelayplayer(arena);

    return;
  }

  if(!_id_5BC60484D17FA95C::_id_1980065CE4DC067B())
    _id_2CEDCC356F1B9FC8::brleaderdialogplayer("gulag_spawn_rules", self, 0);

  _id_13E3FC231BB8D6B9 = _id_5BAB271917698DC4::playeriscinematiclayeron();

  if(!_id_13E3FC231BB8D6B9)
    thread _id_5BAB271917698DC4::fadeoutin();

  thread _id_5BAB271917698DC4::fadeoutinspectatorsofplayer();

  if(level.gulag._id_C489BD0446D6B041)
    logstring("[GULAG DEBUG] : Player " + self.clientid + " passed arena entrance step 01. Time : " + gettime() + ". Screen fade to black. Number of players in the queue for gulag are : " + arena.matches.size + " .");

  wait 1;

  if(level.gulag._id_C489BD0446D6B041)
    logstring("[GULAG DEBUG] : Player " + self.clientid + " passed arena entrance step 02. Time : " + gettime() + ". Passed wait 1 after screen fade to black. Number of players in the queue for gulag are : " + arena.matches.size + " .");

  playergivearenaloadout(arena, loadoutindex);

  if(_id_5BC60484D17FA95C::_id_1980065CE4DC067B())
    _id_1E4A61DB11011446::playerexecutionsdisable();

  thread playertimedinvunerable(3);

  if(getdvarint("dvar_4E5FFA31F07112CA", 0) == 1) {
    level.gulag.lethaldelay = 0;
    thread _id_AA0549E91DAD2FB9(arena);
  }

  if(level.gulag.lethaldelay > 0)
    thread watchlethaldelayplayer(arena);

  if(level.gulag._id_C489BD0446D6B041)
    logstring("[GULAG DEBUG] : Player " + self.clientid + " passed arena entrance step 03. Time : " + gettime() + ". Number of players in the queue for gulag are : " + arena.matches.size + " .");

  if(!_id_5BC60484D17FA95C::_id_1980065CE4DC067B() || _id_0B0385BB45379222::_id_9005AF34E01BF8FE()) {
    if(_id_0B0385BB45379222::_id_9005AF34E01BF8FE())
      _id_33F8E2F409D6F930 = _id_81A985371D489374(arena);
    else
      _id_33F8E2F409D6F930 = getnextarenaspawn(arena);

    spawnorigin = getgroundposition(_id_33F8E2F409D6F930.origin, 1);
    spawnangles = _id_33F8E2F409D6F930.angles;

    if(!isDefined(_id_33F8E2F409D6F930.angles))
      spawnangles = (0, 0, 0);

    _id_5BAB271917698DC4::_id_AB31CF673D70F72D(spawnorigin, spawnangles);
  }

  if(level.gulag._id_C489BD0446D6B041)
    logstring("[GULAG DEBUG] : Player " + self.clientid + " passed arena entrance step 04. Time : " + gettime() + ". Passed teleport to gulag. Number of players in the queue for gulag are : " + arena.matches.size + " .");

  setplayervargulagjail(0);
  setplayervargulagarena(1);
  self.health = self.maxhealth;
  _id_07C40FA80892A721::_id_AC7803D45979135C(level.gulag.numarmorhealth);

  if(getdvarint("dvar_3CEAF2C0C66C3DC2", 1) > 0)
    self hudoutlineenableforclients(arena.arenaplayers, "outline_nodepth_red");

  _id_13E3FC231BB8D6B9 = _id_5BAB271917698DC4::playeriscinematiclayeron();

  if(_id_13E3FC231BB8D6B9)
    _id_5BAB271917698DC4::_id_E68E4BB4F65F5FE4();

  if(_id_0B0385BB45379222::_id_9005AF34E01BF8FE())
    thread _id_0B0385BB45379222::_id_8B208C4CA074AAEB(arena);

  wait 1;

  if(level.gulag._id_C489BD0446D6B041)
    logstring("[GULAG DEBUG] : Player " + self.clientid + " passed arena entrance step 05. Time : " + gettime() + ". Start Camera sequence started 1 second ago. Number of players in the queue for gulag are : " + arena.matches.size + " . Player in gulag? : " + self.gulag + " .");

  if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("gulag_initPlayerArena"))
    _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("gulag_initPlayerArena");

  self allowprone(1);
  self allowcrouch(1);
  wait(_id_59D019F0169C03BE() - 1);
  self._id_38841D8E75A06AB3 = undefined;
  self notify("skydive_remove_spawn_protection");

  if(_id_5BC60484D17FA95C::_id_1980065CE4DC067B())
    _id_1E4A61DB11011446::playerexecutionsenable();

  if(_id_5BC60484D17FA95C::_id_1980065CE4DC067B() && istrue(level._id_43307855F189EB31._id_41BA817A6AA8EA0A))
    thread _id_3583FF375AB3A91E::_id_696F54DA8FCB6BBE("gulag_jailer_match_start", arena);

  if(level.gulag._id_C489BD0446D6B041)
    logstring("[GULAG DEBUG] : Player " + self.clientid + " passed arena entrance step 06. Time : " + gettime() + ". Right before countdown. Number of players in the queue for gulag are : " + arena.matches.size + " . Player in gulag? : " + self.gulag + " .");

  wait 1;

  if(level.gulag._id_C489BD0446D6B041)
    logstring("[GULAG DEBUG] : Player " + self.clientid + " passed arena entrance step 07. Time : " + gettime() + ". Player is fully in gulag. Number of players in the queue for gulag are : " + arena.matches.size + " . Player in gulag? : " + self.gulag + " .");

  if(getdvarint("dvar_3CEAF2C0C66C3DC2", 1) > 0 && arena.arenaplayers.size > 0)
    self hudoutlinedisableforclients(arena.arenaplayers);
}

_id_737F63F33471E8B5() {
  arena = self;
  arena waittill("gulag_about_to_start_camera_sequence");
  _id_FF6A5AF3136746AB = arena.fightspawns[0];
  _id_665773F35F5AD3A5 = arena.fightspawns[1];
  _id_F3FD198BF503976F = arena.fightspawns[2];
  _id_CDFBF5F85E67AAF9 = arena.fightspawns[3];

  if(distance2d(_id_FF6A5AF3136746AB.origin, _id_F3FD198BF503976F.origin) > 150) {
    logstring("[GULAG] Bad gulag spawns for spawns : 1 & 3");
    _id_F3FD198BF503976F = arena _id_837E317CC5CA039B(_id_FF6A5AF3136746AB);
  }

  if(distance2d(_id_665773F35F5AD3A5.origin, _id_CDFBF5F85E67AAF9.origin) > 150) {
    logstring("[GULAG] Bad gulag spawns for spawns : 2 & 4");
    _id_CDFBF5F85E67AAF9 = arena _id_837E317CC5CA039B(_id_665773F35F5AD3A5);
  }

  _id_FFFA32233DBCE940 = 0;
  _id_C9A7F236CDB526A2 = 0;

  foreach(_id_AC0E424AC96A7113 in arena.arenaplayers) {
    if(_id_AC0E424AC96A7113._id_6D34BF5491AD7588 == 1) {
      if(_id_FFFA32233DBCE940 == 0) {
        _id_AC0E424AC96A7113 _id_B6DED705410954F1(_id_FF6A5AF3136746AB);
        _id_FFFA32233DBCE940++;
      } else {
        _id_AC0E424AC96A7113 _id_B6DED705410954F1(_id_F3FD198BF503976F);
        _id_FFFA32233DBCE940++;
      }

      continue;
    }

    if(_id_C9A7F236CDB526A2 == 0) {
      _id_AC0E424AC96A7113 _id_B6DED705410954F1(_id_665773F35F5AD3A5);
      _id_C9A7F236CDB526A2++;
      continue;
    }

    _id_AC0E424AC96A7113 _id_B6DED705410954F1(_id_CDFBF5F85E67AAF9);
    _id_C9A7F236CDB526A2++;
  }

  arena notify("gulag_players_in_place_for_match_sequence");
}

_id_B6DED705410954F1(_id_6EC590DA2678D88D) {
  player = self;
  spawnorigin = getgroundposition(_id_6EC590DA2678D88D.origin, 1);
  spawnangles = _id_6EC590DA2678D88D.angles;

  if(!isDefined(_id_6EC590DA2678D88D.angles))
    spawnangles = (0, 0, 0);

  player _id_5BAB271917698DC4::_id_AB31CF673D70F72D(spawnorigin, spawnangles);
  player._id_600419D0DBB63AF7 = spawnorigin;
  player._id_35F055A703EC57D7 = spawnangles;
}

_id_837E317CC5CA039B(_id_C8D5BF0174223A73) {
  arena = self;
  _id_F551FCA9926C54C6 = undefined;

  foreach(spawnpoint in arena.fightspawns) {
    if(spawnpoint == _id_C8D5BF0174223A73) {
      continue;
    }
    if(distance2d(_id_C8D5BF0174223A73.origin, spawnpoint.origin) < 150)
      _id_F551FCA9926C54C6 = spawnpoint;
  }

  return _id_F551FCA9926C54C6;
}

playerstartarenasetcontrols(enable, _id_0228A5DE8E2CD330) {
  if(enable) {
    self notify("gulag_end_lock_movement");
    self allowmelee(1);
    self allowmovement(1);
    self enableusability();
    self enableoffhandweapons();
    self allowads(1);
    self allowfire(1);
  } else {
    thread _id_C194C7F63E64D501();
    self allowmelee(0);
    self allowmovement(0);
    self disableusability();
    self disableoffhandweapons();
    self allowads(0);
    self allowfire(0);
  }

  _id_2E096D17B6286E29(self, "playerStartArenaSetControls_" + scripts\engine\utility::_id_53C4C53197386572(_id_0228A5DE8E2CD330, ""), enable);
}

_id_C194C7F63E64D501() {
  player = self;
  player notify("gulag_end_lock_movement");
  player endon("gulag_end_lock_movement");
  player endon("disconnect");
  level endon("game_ended");

  if(!getdvarint("dvar_0D52A96B093650DA", 1)) {
    return;
  }
  while(isDefined(player)) {
    player allowmovement(0);
    waitframe();
  }
}

getnextarenaspawn(arena) {
  if(!isDefined(arena.arenaspawncounter))
    arena.arenaspawncounter = 0;

  _id_8F5D6F42D8464DE0 = undefined;
  _id_AAF901DC990498C5 = 0;

  if(usecellspawns(arena)) {
    _id_8F5D6F42D8464DE0 = arena.cellspawns[arena.arenaspawncounter];
    _id_AAF901DC990498C5 = arena.cellspawns.size;
  } else {
    _id_8F5D6F42D8464DE0 = arena.fightspawns[arena.arenaspawncounter];
    _id_AAF901DC990498C5 = arena.fightspawns.size;
  }

  arena.arenaspawncounter++;
  arena.arenaspawncounter = arena.arenaspawncounter % _id_AAF901DC990498C5;
  return _id_8F5D6F42D8464DE0;
}

_id_81A985371D489374(arena) {
  _id_8F5D6F42D8464DE0 = _id_7A41A8C3404BE54C(arena);
  arena thread _id_BE68BBA79D94E189(_id_8F5D6F42D8464DE0);
  return _id_8F5D6F42D8464DE0;
}

_id_7A41A8C3404BE54C(arena) {
  player = self;

  if(!isDefined(arena._id_BE68BBA79D94E189))
    arena._id_BE68BBA79D94E189 = [];

  player._id_B6E41A06D7038B6C = 9999;
  arena._id_7313402120B08AAD = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < arena.fightspawns.size; _id_AC0E594AC96AA3A8++) {
    arena._id_7313402120B08AAD[_id_AC0E594AC96AA3A8] = 0;

    if(isDefined(arena._id_707537A8904AA962)) {
      foreach(agent in arena._id_707537A8904AA962) {
        _id_4484621308628C7B = distance2d(arena.fightspawns[_id_AC0E594AC96AA3A8].origin, agent.origin);

        if(_id_4484621308628C7B < player._id_B6E41A06D7038B6C)
          player._id_B6E41A06D7038B6C = _id_4484621308628C7B;

        arena._id_7313402120B08AAD[_id_AC0E594AC96AA3A8] = arena._id_7313402120B08AAD[_id_AC0E594AC96AA3A8] + _id_4484621308628C7B * 1.1;
      }
    }

    if(isDefined(arena.arenaplayers)) {
      foreach(_id_AC0E424AC96A7113 in arena.arenaplayers) {
        _id_4484621308628C7B = distance2d(arena.fightspawns[_id_AC0E594AC96AA3A8].origin, _id_AC0E424AC96A7113.origin);

        if(_id_4484621308628C7B < player._id_B6E41A06D7038B6C)
          player._id_B6E41A06D7038B6C = _id_4484621308628C7B;

        arena._id_7313402120B08AAD[_id_AC0E594AC96AA3A8] = arena._id_7313402120B08AAD[_id_AC0E594AC96AA3A8] + _id_4484621308628C7B;
      }
    }
  }

  _id_9EB670ECC14B88CA = 0;
  _id_3C6F314368998C21 = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < arena.fightspawns.size; _id_AC0E594AC96AA3A8++) {
    if(arena._id_7313402120B08AAD[_id_AC0E594AC96AA3A8] >= arena._id_7313402120B08AAD[_id_9EB670ECC14B88CA]) {
      if(!scripts\engine\utility::array_contains(arena._id_BE68BBA79D94E189, arena.fightspawns[_id_AC0E594AC96AA3A8])) {
        _id_9EB670ECC14B88CA = _id_AC0E594AC96AA3A8;
        _id_3C6F314368998C21 = 1;
      }
    }
  }

  if(_id_3C6F314368998C21)
    _id_7E5CAF04B39F50C6 = arena.fightspawns[_id_9EB670ECC14B88CA];
  else {
    _id_610520BE555433B2 = randomint(arena.fightspawns.size);
    _id_7E5CAF04B39F50C6 = arena.fightspawns[_id_610520BE555433B2];
  }

  return _id_7E5CAF04B39F50C6;
}

_id_BE68BBA79D94E189(_id_9B90D8BA4DB5BE81) {
  arena = self;
  level endon("game_ended");
  arena._id_BE68BBA79D94E189 = scripts\engine\utility::array_add(arena._id_BE68BBA79D94E189, _id_9B90D8BA4DB5BE81);
  wait(level.gulag._id_652312821A44B886);

  if(!isDefined(_id_9B90D8BA4DB5BE81)) {
    return;
  }
  arena._id_BE68BBA79D94E189 = scripts\engine\utility::array_remove(arena._id_BE68BBA79D94E189, _id_9B90D8BA4DB5BE81);
}

playertimedinvunerable(timeout) {
  level endon("game_ended");
  self endon("disconnect");
  self.plotarmor = 1;
  scripts\engine\utility::waittill_any_timeout_no_endon_death_2(timeout, "death", "gulagRespawn");
  self.plotarmor = undefined;
}

_id_34CEBFCA4FDFB4F3() {
  level endon("game_ended");
  self endon("disconnect");
  _id_7676221CCA996819 = self _meth_D85AA3C6CFD398CF();

  if(isDefined(_id_7676221CCA996819) && isDefined(level._id_C5877DBE60FDDBF6)) {
    foreach(_id_D40DF2F2B26ADA41 in level._id_C5877DBE60FDDBF6) {
      if(_id_D40DF2F2B26ADA41 _meth_AFDEDF3C8BEB5EBC(_id_7676221CCA996819))
        _id_D40DF2F2B26ADA41 clearpredictedstreampos();
    }
  }
}

gulagvictory(arena, winner, _id_5B9A9B8346074883, _id_5A5A690371917543, _id_DF2FBB13C226BE75, _id_FB551788DA0FC531, _id_4AC881E2A39322A5, _id_BF7470006675932E, _id_7B73D3F227CBD0F1, _id_565C98BDCCD583FB) {
  level endon("game_ended");
  winner endon("death_or_disconnect");
  winner notify("gulag_end");

  if(!isDefined(_id_FB551788DA0FC531))
    _id_FB551788DA0FC531 = 0;

  if(!isDefined(_id_7B73D3F227CBD0F1))
    _id_7B73D3F227CBD0F1 = 0;

  if(istrue(_id_7B73D3F227CBD0F1) && istrue(level.gulag._id_5EBD7968D809FBAC)) {
    if(istrue(winner.insertingarmorplate)) {
      winner notify("try_armor_cancel");

      while(istrue(winner.insertingarmorplate))
        waitframe();
    }

    winner scripts\cp_mp\utility\player_utility::_freezecontrols(1, 0, "gulagVictory");
  }

  winner scripts\mp\codcasterclientmatchdata::_id_F8B808CD6473E6CC(23, 0);

  foreach(player in arena.arenaplayers) {
    player scripts\mp\codcasterclientmatchdata::_id_F8B808CD6473E6CC(23, 0);

    if(arena.arenaplayers[0] == winner) {
      player setclientomnvar("ui_br_gulag_match_state", 4);
      continue;
    }

    player setclientomnvar("ui_br_gulag_match_state", 5);
  }

  winner playerclearjailtimeouthud();
  winner thread playertimedinvunerable(5);

  if(arena.arenaplayers.size > 2) {
    winner disableexecutionattack();
    winner disableexecutionvictim();
  }

  if(_id_03AA8E63A56E3416::_id_6E3541FD8FAB45BC() && _id_5BC60484D17FA95C::_id_CFE304859F30E747("gulagWinSequence"))
    winner _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("gulagWinSequence", arena, _id_DF2FBB13C226BE75);

  winner.gulagloser = 0;
  winner setthreatbiasgroup();

  if(arena.jailedplayers.size > 0 && getdvarint("dvar_30C3E9D4F1F094CF", 0))
    winner hudoutlinedisableforclients(arena.jailedplayers);

  if(arena.arenaplayers.size > 0 && getdvarint("dvar_3CEAF2C0C66C3DC2", 1) > 0)
    winner hudoutlinedisableforclients(arena.arenaplayers);

  arena.arenaplayers = scripts\engine\utility::array_remove(arena.arenaplayers, winner);

  foreach(_id_F0EA4030349A33D5 in level.teamdata[winner.team]["players"]) {
    if(!isDefined(_id_F0EA4030349A33D5) || !isalive(_id_F0EA4030349A33D5)) {
      continue;
    }
    if(_id_F0EA4030349A33D5 != winner) {
      _id_F0EA4030349A33D5 thread scripts\mp\hud_message::showsplash("br_gulag_teammate_out", undefined, winner);
      _id_2CEDCC356F1B9FC8::brleaderdialogplayer("gulag_teammate_win", _id_F0EA4030349A33D5);
    }
  }

  _id_401C3A2E68AAB0FD = "";

  if(isDefined(_id_DF2FBB13C226BE75))
    _id_401C3A2E68AAB0FD = _id_DF2FBB13C226BE75;

  if(!istrue(_id_5A5A690371917543) && !istrue(_id_FB551788DA0FC531) && !istrue(_id_BF7470006675932E) && !istrue(_id_565C98BDCCD583FB))
    winner thread _id_5BAB271917698DC4::triggerrespawnoverlay(3, _id_DF2FBB13C226BE75);

  if(_id_5B9A9B8346074883) {
    if(!istrue(_id_5A5A690371917543) && !istrue(_id_565C98BDCCD583FB)) {
      if(isDefined(_id_DF2FBB13C226BE75) && _id_DF2FBB13C226BE75 == "timeout")
        _id_2CEDCC356F1B9FC8::brleaderdialogplayer("gulag_timeout", winner, 0);
      else
        _id_2CEDCC356F1B9FC8::brleaderdialogplayer("gulag_noenemy", winner, 0);
    }

    arena.jailedplayers = scripts\engine\utility::array_remove(arena.jailedplayers, winner);
    updatematchqueuepositions(arena);
  } else
    _id_2CEDCC356F1B9FC8::brleaderdialogplayer("gulag_win", winner, 0);

  if(isDefined(winner._id_ACFBB9CAED7125F9) && winner._id_ACFBB9CAED7125F9 == 1) {
    _id_4A043CC9593EA633 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_gulag_win_classic");
    winner setplayermusicstate(_id_4A043CC9593EA633);
  } else {
    _id_4A043CC9593EA633 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_gulag_win");
    winner setplayermusicstate(_id_4A043CC9593EA633);
  }

  if(isstring("veh_br_gulag_winner_escape") && 1 && soundexists("veh_br_gulag_winner_escape"))
    winner playsoundtoplayer("veh_br_gulag_winner_escape", winner);

  if(istrue(level.gulag.onekillwin) && (istrue(arena.isjailbreak) || level.gulag.maxplayers > 2)) {
    winner scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
    winner scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("br_gulag::gulagVictory()");
  }

  winner playerstartjailsetcontrols(1);
  winner playerstartarenasetcontrols(1, "gulagVictory");
  winner _id_5BAB271917698DC4::_id_D669022F6CD65402(0);
  winner _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("isRespawning", 1);
  winner scripts\mp\weapons::deleteplacedequipment();
  streamtimeout = _id_2CEDCC356F1B9FC8::getdefaultstreamhinttimeoutms() / 1000;

  if(isDefined(level.bot_funcs["bot_gulag_get_respawn_point"]) && isbot(winner))
    spawnpoint = winner[[level.bot_funcs["bot_gulag_get_respawn_point"]]](0, streamtimeout);
  else
    spawnpoint = winner _id_5BAB271917698DC4::_id_952548D8AED47102(0, streamtimeout);

  winner._id_F9792C4242DC4625 = spawnpoint.origin;
  _id_11F3B4465C8B637B = winner _id_5BAB271917698DC4::playerprestreamrespawnorigin(spawnpoint);

  if(_id_46FDF7B12C5F5620::_id_7EFFA8A355DDC886()) {
    winner._id_B807B84E723C5CEA = undefined;
    winner._id_D95581FDFC29EC7A = undefined;
  }

  wait(_id_86EE3121D91C59C3());

  if(istrue(level.gulag.arenaflag))
    arena.dom.arenaflag thread arenaflag_setvisibleplayer(0, winner);

  winner clearclienttriggeraudiozone(2);
  winner _id_5BAB271917698DC4::_id_334A8FE67E88BBE7(1);
  wait 1;

  if(_id_5B9A9B8346074883 && scripts\mp\utility\player::isinlaststand(winner))
    winner notify("last_stand_revived");

  winner _id_CA008CC22B07BA4E();

  if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("gulagGiveAIKillRewards"))
    winner thread _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("gulagGiveAIKillRewards");

  if(istrue(level.gulag._id_5EBD7968D809FBAC))
    winner scripts\cp_mp\utility\player_utility::_freezecontrols(0, 0, "gulagVictory");

  winner thread _id_8CD7D5A73921BD93(10);
  winner gulagwinnerrespawn(_id_FB551788DA0FC531, _id_DF2FBB13C226BE75, spawnpoint, 1, _id_11F3B4465C8B637B, undefined, _id_4AC881E2A39322A5, _id_5A5A690371917543, _id_BF7470006675932E, undefined, _id_565C98BDCCD583FB);
  winner._id_F9792C4242DC4625 = undefined;
  _id_6489FCDFE6FA2E36::_id_F83BF537661EC58C(winner);
}

_id_86EE3121D91C59C3() {
  if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("gulagGetVictoryWait"))
    waittime = _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("gulagGetVictoryWait");
  else
    waittime = 2.0;

  return waittime;
}

_id_4BB92764539FFF5D() {
  if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("gulagGetPostVictoryWait"))
    _id_684405E0DA1732FB = _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("gulagGetPostVictoryWait");
  else
    _id_684405E0DA1732FB = 1.0;

  return _id_684405E0DA1732FB;
}

gulagplayerwatchfordeath(arena, _id_4B434533D3624BEC) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("gulag_end");
  self endon("gulagLost");
  self endon("gulag_auto_win");
  self waittill("death", attacker);

  if(istrue(level.gulag.onekillwin))
    handleonekillwin(arena, self, attacker, _id_4B434533D3624BEC);

  thread gulagplayerlost(arena);
}

gulagplayerlost(arena, _id_40D8983FC5E5C7A5, _id_93592D4A5FD91ED1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("pull_out_of_gulag");

  if(_id_5BC60484D17FA95C::_id_1980065CE4DC067B()) {
    self disableexecutionattack();
    self disableexecutionvictim();
  }

  if(isalive(self)) {
    self.plotarmor = 1;
    self freezecontrols(1);
  }

  if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("gulagLostOverlay"))
    _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("gulagLostOverlay", self, _id_40D8983FC5E5C7A5);
  else
    thread _id_6489FCDFE6FA2E36::triggereliminatedoverlay();

  if(!isDefined(self)) {
    return;
  }
  if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("gulagHandleLossInfiniteEarly")) {
    thread _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("gulagHandleLossInfiniteEarly", arena);
    return;
  }

  self notify("gulagLost");

  if(istrue(self.gulagloser)) {
    return;
  }
  self.gulagloser = 1;
  self setthreatbiasgroup();

  if(!_id_5BC60484D17FA95C::_id_1980065CE4DC067B() || istrue(_id_93592D4A5FD91ED1)) {
    self.spectatepoint = arena.spectatepoint;
    thread playersetwasingulag(1);
  }

  if(_id_46FDF7B12C5F5620::_id_7EFFA8A355DDC886()) {
    self._id_22F8F8D138D3C02F = 3;
    _id_46FDF7B12C5F5620::_id_F071DB381E990D80();
  }

  arena.jailedplayers = scripts\engine\utility::array_removeundefined(arena.jailedplayers);

  if(arena.jailedplayers.size > 0 && getdvarint("dvar_30C3E9D4F1F094CF", 0))
    self hudoutlinedisableforclients(arena.jailedplayers);

  arena.arenaplayers = scripts\engine\utility::array_removeundefined(arena.arenaplayers);

  if(arena.arenaplayers.size > 0 && getdvarint("dvar_3CEAF2C0C66C3DC2", 1) > 0)
    self hudoutlinedisableforclients(arena.arenaplayers);

  arena.arenaplayers = scripts\engine\utility::array_remove(arena.arenaplayers, self);

  if(isDefined(self))
    _id_5DA640380AD84D71 = self.name;
  else
    _id_5DA640380AD84D71 = "<undefined>";

  _id_1146C25A252F6B0E = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_gulag_lose");
  _id_AF0951BBDBF11435 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_gulag_lose_classic");

  if(isDefined(self._id_ACFBB9CAED7125F9) && self._id_ACFBB9CAED7125F9 == 1)
    self setplayermusicstate(_id_AF0951BBDBF11435);
  else
    self setplayermusicstate(_id_1146C25A252F6B0E);

  if(isstring("") && 0 && soundexists(""))
    self playsoundtoplayer("", self);

  scripts\mp\weapons::deleteplacedequipment();
  _id_0A34750D17473C49::markplayeraseliminated(self, "gulagPlayerLost");
  level thread _id_1E4A61DB11011446::updateplayerandteamcountui();
  _id_2CEDCC356F1B9FC8::brleaderdialogplayer("gulag_lose", self, 0, 1);
  _id_2CEDCC356F1B9FC8::brleaderdialogteamexcludeplayer("gulag_teammate_lose", self.team, self, 0, 0);

  if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("gulagLoseSequence"))
    _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("gulagLoseSequence", arena, _id_40D8983FC5E5C7A5);

  wait(_id_86EE3121D91C59C3());
  self clearclienttriggeraudiozone(2);

  if(istrue(level.gulag.arenaflag))
    arena.dom.arenaflag thread arenaflag_setvisibleplayer(0, self);

  scripts\cp_mp\challenges::_id_B2306D0693BA65C1(0);
  _id_715028F54BAD19A1::branalytics_gulagend(self, "loser");
  scripts\cp_mp\calloutmarkerping::calloutmarkerping_removeallcalloutsforplayer();
  playerdestroyhud(arena);

  if(isalive(self)) {
    if(!_id_362C58E8BB39BCDA::isfeaturedisabled("teamSpectate"))
      _id_6489FCDFE6FA2E36::migratespectators(self, undefined, 1);

    _id_5BAB271917698DC4::_id_334A8FE67E88BBE7();
    wait 1;

    if(!_id_362C58E8BB39BCDA::isfeaturedisabled("teamSpectate"))
      _id_6489FCDFE6FA2E36::migratespectators(self, undefined, 1);

    if(isalive(self)) {
      _id_642470E1ABC1BBF9 = spawnStruct();
      _id_642470E1ABC1BBF9.origin = self.origin;
      _id_642470E1ABC1BBF9.angles = self.angles;
      _id_642470E1ABC1BBF9.attacker = self.lastattacker;
      self.health = 0;
      self notify("death");
      self notify("death_or_disconnect");
      scripts\mp\codcasterclientmatchdata::_id_F8B808CD6473E6CC(23, 0);

      if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587()) {
        _id_16C2D930984F2FEF = self isreloading();

        if(_id_16C2D930984F2FEF) {
          _id_5814D27874B48E54 = spawnStruct();
          _id_5814D27874B48E54.player = self;
          _id_5814D27874B48E54._id_C739BA1EB6635B73 = getsystemtimeinmicroseconds();
          _id_5814D27874B48E54._id_C198F7CA473378FB = "DISCONNECT";
          _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_reload_cancel", _id_5814D27874B48E54);
        }
      }

      _id_6489FCDFE6FA2E36::spawnspectator(_id_642470E1ABC1BBF9, 1, 1);
      scripts\mp\playerlogic::removefromalivecount(0, "gulagPlayerLost");
    }

    _id_5BAB271917698DC4::_id_E68E4BB4F65F5FE4();
  }

  self.plotarmor = undefined;
  setplayervargulag(0);
  setplayervargulagarena(0);
  setplayervargulagjail(0);

  if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("gulagHandleLossInfiniteLate"))
    thread _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("gulagHandleLossInfiniteLate", arena);

  if(_id_5BC60484D17FA95C::_id_1980065CE4DC067B())
    _id_1C9F130087CDF290();
}

_id_1C9F130087CDF290() {
  player = self;
  _id_A6AB8D0FDA441DC2 = level.teamdata[player.team]["players"];

  if(isDefined(_id_A6AB8D0FDA441DC2)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A6AB8D0FDA441DC2.size; _id_AC0E594AC96AA3A8++) {
      if(!isDefined(_id_A6AB8D0FDA441DC2[_id_AC0E594AC96AA3A8])) {
        continue;
      }
      if(isalive(_id_A6AB8D0FDA441DC2[_id_AC0E594AC96AA3A8]) || istrue(_id_A6AB8D0FDA441DC2[_id_AC0E594AC96AA3A8].gulag))
        return;
    }

    [[level.ondeadevent]](player.team);
  }
}

playersetwasingulag(value) {
  if(istrue(level.usegulag)) {
    if(value) {
      self.wasingulag = value;
      self setclientomnvar("ui_gulag", value);
    } else {
      self.wasingulag = undefined;
      self setclientomnvar("ui_gulag", 0);
    }

    setplayeringulagarenaextrainfo(value);
  }
}

playerspawningasspectator() {
  if(istrue(level.usegulag) && istrue(self.wasingulag) && level.teamdata[self.team]["aliveCount"] > 0 && !_id_5BC60484D17FA95C::_id_1980065CE4DC067B())
    _id_2CEDCC356F1B9FC8::brleaderdialogplayer("gulag_buyback", self, 0, 1);
}

recordmolotov(grenade, player) {
  if(istrue(player.gulagarena)) {
    arena = player.arena;
    arena.molotovs[arena.molotovs.size] = grenade;
  }
}

cleanuparenamolotovs(arena) {
  foreach(molotov in arena.molotovs) {
    if(isDefined(molotov))
      thread scripts\mp\equipment\molotov::molotov_cleanup_pool(molotov);
  }

  arena.molotovs = [];
}

gulagwinnerrespawn(_id_FB551788DA0FC531, _id_DF2FBB13C226BE75, spawnpoint, skipsplash, _id_11F3B4465C8B637B, _id_03BD8653773757C7, _id_4AC881E2A39322A5, _id_74AF5908127B6729, _id_BF7470006675932E, _id_491D9866301A91D1, _id_DF631FDD92A76BB1, _id_AE82E43C0D208739) {
  _id_104E34B87A973660 = undefined;

  if(!istrue(skipsplash))
    _id_104E34B87A973660 = 7;

  _id_30A91E1938CFD1B2 = _id_6F4FA9B79A3C7DCE(_id_FB551788DA0FC531, _id_DF2FBB13C226BE75, _id_03BD8653773757C7, _id_4AC881E2A39322A5, _id_74AF5908127B6729, _id_BF7470006675932E, _id_491D9866301A91D1, undefined, _id_104E34B87A973660, _id_DF631FDD92A76BB1, _id_AE82E43C0D208739);
  _id_5BAB271917698DC4::_id_7642A6BEE4CDAAA2(spawnpoint, _id_11F3B4465C8B637B, _id_30A91E1938CFD1B2);
}

_id_6F4FA9B79A3C7DCE(_id_FB551788DA0FC531, _id_DF2FBB13C226BE75, _id_03BD8653773757C7, _id_4AC881E2A39322A5, _id_74AF5908127B6729, _id_BF7470006675932E, _id_491D9866301A91D1, _id_46FF3A000308206A, _id_104E34B87A973660, _id_DF631FDD92A76BB1, _id_AE82E43C0D208739) {
  _id_CDD53A78F51F64FE = _id_5BAB271917698DC4::_id_ADE48AF7C782E202(::playerrespawngulagcleanup, "veh_br_gulag_redeploy_flyby", _id_03BD8653773757C7);
  _id_CDD53A78F51F64FE _id_5BAB271917698DC4::_id_9FD565BCD654ED48(::_id_F85939BEC8DDD156);
  _id_CDD53A78F51F64FE _id_5BAB271917698DC4::_id_B4C313DF5D7FB216(::_id_6414FDC0080486D8, _id_46FF3A000308206A);
  _id_CDD53A78F51F64FE _id_5BAB271917698DC4::_id_8CB232CDF47DA79C(undefined, _id_104E34B87A973660);
  _id_CDD53A78F51F64FE _id_5BAB271917698DC4::_id_02556973693D6315(::_id_C23C21AE53B22C77);
  _id_CDD53A78F51F64FE._id_9FDC1F9E4FC628E4._id_FB551788DA0FC531 = _id_FB551788DA0FC531;
  _id_CDD53A78F51F64FE._id_9FDC1F9E4FC628E4._id_DF2FBB13C226BE75 = _id_DF2FBB13C226BE75;
  _id_CDD53A78F51F64FE._id_9FDC1F9E4FC628E4._id_4AC881E2A39322A5 = _id_4AC881E2A39322A5;
  _id_CDD53A78F51F64FE._id_9FDC1F9E4FC628E4._id_74AF5908127B6729 = _id_74AF5908127B6729;
  _id_CDD53A78F51F64FE._id_9FDC1F9E4FC628E4._id_BF7470006675932E = _id_BF7470006675932E;
  _id_CDD53A78F51F64FE._id_9FDC1F9E4FC628E4._id_491D9866301A91D1 = _id_491D9866301A91D1;
  _id_CDD53A78F51F64FE._id_9FDC1F9E4FC628E4._id_DF631FDD92A76BB1 = _id_DF631FDD92A76BB1;
  _id_CDD53A78F51F64FE._id_9FDC1F9E4FC628E4._id_AE82E43C0D208739 = _id_AE82E43C0D208739;
  return _id_CDD53A78F51F64FE;
}

_id_6414FDC0080486D8(_id_9FDC1F9E4FC628E4) {
  _id_9FDC1F9E4FC628E4._id_550F09808FB6A6B5 = self._id_BED158A6DFAC230D;
  _id_768DCA2A6910F9C4 = !istrue(_id_9FDC1F9E4FC628E4._id_FB551788DA0FC531);

  if(!istrue(_id_9FDC1F9E4FC628E4._id_FB551788DA0FC531) && !istrue(_id_9FDC1F9E4FC628E4._id_BF7470006675932E)) {
    if(!istrue(_id_9FDC1F9E4FC628E4._id_74AF5908127B6729)) {
      scripts\cp_mp\challenges::_id_B2306D0693BA65C1(1);
      scripts\mp\utility\stats::incpersstat("gulagWins", 1);
    }
  }

  if(isDefined(_id_9FDC1F9E4FC628E4._id_DF2FBB13C226BE75))
    _id_715028F54BAD19A1::branalytics_gulagend(self, _id_9FDC1F9E4FC628E4._id_DF2FBB13C226BE75);

  scripts\cp_mp\calloutmarkerping::calloutmarkerping_removeallcalloutsforplayer();
  playersetwasingulag(0);
  setplayervargulag(0);
  setplayervargulagarena(0);

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    playerdestroyhud(self.arena);

  setplayervargulagjail(0);
  self.jailtime = undefined;

  if(isDefined(self.arena))
    self.arena.arenaplayers = scripts\engine\utility::array_remove(self.arena.arenaplayers, self);

  playertakeawayrock(self.arena);
  gulagwinnerloadout(_id_9FDC1F9E4FC628E4._id_FB551788DA0FC531);
  _id_0D4066589FEF0017 = 0;

  if(isDefined(level.gulag) && istrue(level.gulag.planerespawn)) {
    playerrespawngulagcleanup(_id_9FDC1F9E4FC628E4._id_FB551788DA0FC531);
    _id_5BAB271917698DC4::_id_961B4AFC4C695B94();
    playersetupac130();
    _id_0D4066589FEF0017 = 1;
  }

  return _id_0D4066589FEF0017;
}

_id_F85939BEC8DDD156(_id_9FDC1F9E4FC628E4) {
  if(istrue(self._id_36386F3F03C2AB4B)) {
    self._id_36386F3F03C2AB4B = undefined;
    self setclientdvar("dvar_B21F1157C582FF15", 1);
  }

  self.plotarmor = undefined;
  self.c130 = undefined;
  return 1;
}

_id_C23C21AE53B22C77(_id_9FDC1F9E4FC628E4) {
  if(istrue(getDvar("dvar_7611A2790A0BF7FE", "") == "truckwar") && !istrue(_id_9FDC1F9E4FC628E4._id_BF7470006675932E)) {
    _id_9D45F503AE900A7D = "br_gulag_winner_redeploy_mogulag";
    _id_1F0A356715870574 = undefined;
  }

  if(getDvar("dvar_7611A2790A0BF7FE", "") == "dmz" || getDvar("dvar_7611A2790A0BF7FE", "") == "exgm" || getDvar("dvar_7611A2790A0BF7FE", "") == "plunder" || getDvar("dvar_7611A2790A0BF7FE", "") == "kingslayer" || getDvar("dvar_7611A2790A0BF7FE", "") == "risk" || getDvar("dvar_7611A2790A0BF7FE", "") == "rumble_mgl" || getDvar("dvar_7611A2790A0BF7FE", "") == "sandbox") {
    _id_9D45F503AE900A7D = "br_gulag_winner_redeploy_mogulag";
    _id_1F0A356715870574 = undefined;
  } else if(istrue(_id_9FDC1F9E4FC628E4._id_74AF5908127B6729)) {
    _id_9D45F503AE900A7D = "br_gulag_jailbreak_redeploy";
    _id_1F0A356715870574 = undefined;
  } else if(istrue(_id_9FDC1F9E4FC628E4._id_DF631FDD92A76BB1)) {
    _id_9D45F503AE900A7D = "br_gulag_winner_redeploy";
    _id_1F0A356715870574 = undefined;
  } else if((istrue(_id_9FDC1F9E4FC628E4._id_FB551788DA0FC531) || istrue(_id_9FDC1F9E4FC628E4._id_BF7470006675932E)) && !istrue(_id_9FDC1F9E4FC628E4._id_AE82E43C0D208739)) {
    _id_9D45F503AE900A7D = "br_gulag_kiosk_redeploy";
    _id_1F0A356715870574 = _id_9FDC1F9E4FC628E4._id_4AC881E2A39322A5;
  } else {
    if(istrue(isDefined(level.gulag) && !istrue(level.gulag.shutdown)) && checkgulagusecount()) {
      if(_id_5BC60484D17FA95C::_id_1980065CE4DC067B())
        _id_9D45F503AE900A7D = "br_gulag_winner_redeploy";
      else
        _id_9D45F503AE900A7D = "br_gulag_winner_redeploy_mogulag";
    } else
      _id_9D45F503AE900A7D = "br_gulag_winner_redeploy";

    _id_1F0A356715870574 = undefined;
  }

  if(!istrue(_id_9FDC1F9E4FC628E4._id_491D9866301A91D1))
    thread scripts\mp\hud_message::showsplash(_id_9D45F503AE900A7D, undefined, _id_1F0A356715870574);

  if(isDefined(level.gulag) && istrue(level.gulag.shutdown) && !istrue(self.gulagdone)) {
    wait 2.0;

    if(!isDefined(self)) {
      return;
    }
    playergulagdonesplash();
  }

  if(istrue(_id_9FDC1F9E4FC628E4._id_AE82E43C0D208739)) {
    _id_0A34750D17473C49::unmarkplayeraseliminated(self, "gulagPostRespawn");
    level thread _id_1E4A61DB11011446::updateplayerandteamcountui();
  }
}

playerrespawngulagcleanup(_id_9FDC1F9E4FC628E4) {
  self notify("gulagRespawn");
  scripts\mp\equipment\molotov::molotov_clear_burning();

  if(getdvarint("dvar_3E7EE8BDF6CE5F54", 0) == 0)
    self.hasspawnweapons = 0;

  self.health = self.maxhealth;
  _id_6A5D3BF7A5B7064A::onexitdeathsdoor(1);

  if(!istrue(_id_9FDC1F9E4FC628E4._id_FB551788DA0FC531)) {
    _id_3B64EB40368C1450::set("isRespawning", "player_for_spawn_logic", 0);
    self setclientomnvar("ui_gulag", 0);
    _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("isRespawning", 0);

    if(isDefined(self.arena))
      removeloadingplayer(self.arena, self);

    self.arena = undefined;
  }
}

gulagwinnerloadout(_id_FB551788DA0FC531) {
  _id_AD99A0C87D805AEE = _id_5BC60484D17FA95C::_id_1980065CE4DC067B() || getdvarint("dvar_7AD0617CFA893A28", 0);
  _id_57DC028BEE0972CA = istrue(level.br_allowloadout) && !istrue(level._id_66113AA6FC12BE57);
  _id_6062D8E657ACA5F4 = !istrue(_id_FB551788DA0FC531);

  if(_id_AD99A0C87D805AEE && _id_6062D8E657ACA5F4 && !_id_57DC028BEE0972CA)
    return gulagwinnerremembergunandammo();

  _id_89469F016B14A064 = getdvarint("dvar_F97D261E2F377AD9", 1) != 0 && getdvarint("dvar_943F7C30BD8B86E8", -1) > -1;

  if(isDefined(level.br_standard_loadout) || _id_89469F016B14A064)
    self.gulagtableloadout = 1;
  else {
    self.gulagtableloadout = 0;

    if(_id_5BC60484D17FA95C::_id_1980065CE4DC067B() || getdvarint("dvar_7AD0617CFA893A28", 0) != 0 || istrue(self._id_AD99A0C87D805AEE)) {
      gulagwinnerremembergunandammo();
      return;
    }

    if(isDefined(level.br_standard_loadout) || getdvarint("dvar_F97D261E2F377AD9", 1) != 0 && getdvarint("dvar_943F7C30BD8B86E8", -1) > -1)
      self.gulagtableloadout = 1;
  }
}

gulagwinnerrestoreloadout() {
  if(!istrue(level.usegulag) && !_id_362C58E8BB39BCDA::isfeaturedisabled("gulagWinnerRestoreLoadoutUseGulag"))
    return 0;

  if(istrue(level._id_59E079836A49593E))
    return 0;

  _id_AD99A0C87D805AEE = _id_5BC60484D17FA95C::_id_1980065CE4DC067B() || getdvarint("dvar_7AD0617CFA893A28", 0);
  _id_5848E883F52E9AD6 = !istrue(self.gulagloser);

  if(_id_AD99A0C87D805AEE && _id_5848E883F52E9AD6)
    return gulagwinnerrestoregunandammo();

  _id_89469F016B14A064 = getdvarint("dvar_F97D261E2F377AD9", 1) && getdvarint("dvar_943F7C30BD8B86E8", -1) > -1;

  if(isDefined(level.br_standard_loadout) || _id_89469F016B14A064)
    return gulagwinnertableloadout();

  return 0;
}

gulagwinnerremembergunandammo() {
  self.br_gulagguncurrent = self getcurrentprimaryweapon();
  _id_34CA738E6F3870DE = self getweaponslistprimaries();
  _id_34CA738E6F3870DE = scripts\engine\utility::array_remove(_id_34CA738E6F3870DE, makeweapon("iw9_knifestab_mp"));
  _id_34CA738E6F3870DE = scripts\engine\utility::array_remove(_id_34CA738E6F3870DE, makeweapon("iw8_throwingknife_fire_melee_mp"));
  _id_34CA738E6F3870DE = scripts\engine\utility::array_remove(_id_34CA738E6F3870DE, makeweapon("iw8_throwingknife_electric_melee_mp"));
  _id_34CA738E6F3870DE = scripts\engine\utility::array_remove(_id_34CA738E6F3870DE, makeweapon("iw9_me_fists_mp"));
  _id_34CA738E6F3870DE = scripts\engine\utility::array_remove(_id_34CA738E6F3870DE, makeweapon("iw9_me_climbfists"));
  _id_34CA738E6F3870DE = scripts\engine\utility::array_remove(_id_34CA738E6F3870DE, makeweapon("iw9_swimfists_mp"));
  _id_34CA738E6F3870DE = scripts\engine\utility::array_remove(_id_34CA738E6F3870DE, makeweapon("iw9_gunless_mp"));
  _id_34CA738E6F3870DE = scripts\engine\utility::array_remove(_id_34CA738E6F3870DE, makeweapon("iw8_gunless"));

  if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
    _id_34CA738E6F3870DE = scripts\engine\utility::array_remove(_id_34CA738E6F3870DE, makeweapon("iw9_swimfists_mp"));

  self.br_gulagguns = [];
  self.br_gulagammo = [];

  foreach(weaponobj in _id_34CA738E6F3870DE) {
    weaponname = getcompleteweaponname(weaponobj);

    if(getsubstr(weaponname, 0, 4) == "alt_") {
      continue;
    }
    self.br_gulagguns[self.br_gulagguns.size] = weaponobj;
    self.br_gulagammo[weaponname] = weaponclipsize(weaponobj) * 3;
  }

  _id_A8B87696AB744141 = self getweaponslistoffhands();
  self.br_gulagoffhands = [];

  foreach(_id_32D16745C91DBE50 in _id_A8B87696AB744141) {
    _id_26D3CCFFC7BEBEC9 = self getweaponammoclip(_id_32D16745C91DBE50);

    if(_id_26D3CCFFC7BEBEC9 <= 0) {
      continue;
    }
    self.br_gulagoffhands[self.br_gulagoffhands.size] = _id_32D16745C91DBE50;
    _id_FE758E8B3E5F9EC0 = getcompleteweaponname(_id_32D16745C91DBE50);

    if(_id_5BC60484D17FA95C::_id_1980065CE4DC067B()) {
      self.br_gulagammo[_id_FE758E8B3E5F9EC0] = _id_26D3CCFFC7BEBEC9;
      continue;
    }

    self.br_gulagammo[_id_FE758E8B3E5F9EC0] = weaponstartammo(_id_32D16745C91DBE50);
  }
}

gulagwinnerrestoregunandammo() {
  if(isDefined(self.br_gulagguns) && isDefined(self.br_gulagoffhands) && isDefined(self.br_gulagammo)) {
    _id_7E8B31664D502E4A = _id_5BC60484D17FA95C::_id_1980065CE4DC067B() || getdvarint("dvar_8D1EFD0A32E32222", 0);

    if(_id_7E8B31664D502E4A && self.br_gulagguns.size < 1) {
      self.gulagtableloadout = 1;
      gulagwinnertableloadout();
      return 0;
    }

    self takeallweapons();
    _id_724736FCF0FB6604::br_ammo_player_clear();
    self.equipment["primary"] = undefined;
    self.equipment["secondary"] = undefined;
    self.equipment["health"] = undefined;
    self.equipment["super"] = undefined;
    _id_CF6837E74D470965 = 0;

    foreach(weaponobj in self.br_gulagguns) {
      weaponname = getcompleteweaponname(weaponobj);
      scripts\cp_mp\utility\inventory_utility::_giveweapon(weaponobj);
      self setweaponammostock(weaponobj, 0);

      if(!_id_CF6837E74D470965) {
        self assignweaponprimaryslot(weaponname);
        scripts\cp_mp\utility\inventory_utility::_switchtoweapon(weaponobj);
        _id_CF6837E74D470965 = 1;
      }

      scripts\mp\weapons::fixupplayerweapons(self, weaponname);
      thread _id_123A6F38785CDF2D::giveweaponpickup(weaponname);
      clipsize = weaponclipsize(weaponobj);
      ammo = int(min(clipsize, 25));

      if(isDefined(self.br_gulagammo[weaponname]))
        ammo = int(max(ammo, self.br_gulagammo[weaponname]));

      _id_031B36738FF4EACD = 0;

      if(ammo > clipsize) {
        _id_031B36738FF4EACD = ammo - clipsize;
        ammo = clipsize;
      }

      self setweaponammoclip(weaponobj, ammo);

      if(_id_031B36738FF4EACD > 0) {
        ammotype = _id_724736FCF0FB6604::br_ammo_type_for_weapon(weaponobj);

        if(isDefined(ammotype))
          _id_724736FCF0FB6604::br_ammo_give_type(self, ammotype, _id_031B36738FF4EACD);
      }
    }

    _id_724736FCF0FB6604::br_ammo_update_weapons(self);

    if(self.br_gulagguns.size < 2)
      self giveweapon(makeweapon("iw9_me_fists_mp"));

    self giveweapon(makeweapon("iw9_me_climbfists"));

    if(!scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
      self giveweapon(makeweapon("iw9_swimfists_mp"));

    foreach(_id_32D16745C91DBE50 in self.br_gulagoffhands) {
      _id_1189BD7FBE2861F8 = scripts\mp\equipment::getequipmentreffromweapon(_id_32D16745C91DBE50);

      if(isDefined(_id_1189BD7FBE2861F8) && isDefined(level.br_pickups.br_equipnametoscriptable[_id_1189BD7FBE2861F8])) {
        scriptablename = level.br_pickups.br_equipnametoscriptable[_id_1189BD7FBE2861F8];
        _id_7E52B56769FA7774::br_forcegivecustompickupitem(self, scriptablename, 1);
        weaponname = getcompleteweaponname(_id_32D16745C91DBE50);

        if(isDefined(self.br_gulagammo[weaponname])) {
          _id_26D3CCFFC7BEBEC9 = self.br_gulagammo[weaponname];
          self setweaponammoclip(_id_32D16745C91DBE50, _id_26D3CCFFC7BEBEC9);
        }
      }
    }

    if(isDefined(self.br_gulagguncurrent))
      self switchtoweaponimmediate(self.br_gulagguncurrent);

    if(isDefined(self.executionref))
      scripts\cp_mp\execution::_giveexecution(self.executionref);

    self.br_gulaggun = undefined;
    self.br_gulagammo = undefined;
    self.br_gulagoffhands = undefined;
    self.br_gulagguncurrent = undefined;
    return 1;
  }

  return 0;
}

gulagwinnertableloadout() {
  if(istrue(self.gulagtableloadout)) {
    if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
      loadoutindex = getloadoutindex();
    else
      loadoutindex = getdvarint("dvar_943F7C30BD8B86E8", -1);

    if(loadoutindex > -1)
      self.pers["gamemodeLoadout"] = level.gulagloadouts[loadoutindex];
    else
      self.pers["gamemodeLoadout"] = level.br_standard_loadout;

    self.class = "gamemode";
    self.prevweaponobj = undefined;
    struct = scripts\mp\class::loadout_getclassstruct();
    struct = scripts\mp\class::loadout_updateclass(struct, "gamemode");
    scripts\mp\class::preloadandqueueclassstruct(struct, 1, 1);
    scripts\mp\class::giveloadout(self.team, "gamemode", 0, 0, undefined, 1);
    self givestartammo(struct.loadoutprimaryobject);
    self givestartammo(struct.loadoutsecondaryobject);
    _id_1E4A61DB11011446::givelaststandifneeded(self);
    _id_724736FCF0FB6604::br_ammo_player_clear();
    _id_724736FCF0FB6604::br_give_starting_ammo();
    _id_724736FCF0FB6604::br_ammo_update_weapons(self);
    self notify("ammo_update");
    thread _id_1E4A61DB11011446::br_displayperkinfo();
    self.gulagtableloadout = undefined;
    return 1;
  }

  return 0;
}

popnextmatch(arena) {
  _id_607899D4420FE1A5 = arena.matches[0];
  arena.matches = scripts\engine\utility::array_remove_index(arena.matches, 0);

  if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("gulagOrderArenaPlayers"))
    _id_607899D4420FE1A5 = _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("gulagOrderArenaPlayers", _id_607899D4420FE1A5);

  return _id_607899D4420FE1A5;
}

checkgulagusecount() {
  if(level.gulag.maxuses >= 0) {
    _id_22FBE5D036EBB50E = self.gulaguses;

    if(!isDefined(_id_22FBE5D036EBB50E))
      _id_22FBE5D036EBB50E = 0;

    if(_id_22FBE5D036EBB50E >= level.gulag.maxuses)
      return 0;
  }

  return 1;
}

_id_C3014B9015A55715() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("gulag_end");
  self endon("jailbreak_respawn");
  _id_7676221CCA996819 = self _meth_D85AA3C6CFD398CF();

  if(isDefined(_id_7676221CCA996819) && isDefined(level._id_C5877DBE60FDDBF6)) {
    foreach(_id_D40DF2F2B26ADA41 in level._id_C5877DBE60FDDBF6) {
      if(_id_D40DF2F2B26ADA41 _meth_AFDEDF3C8BEB5EBC(_id_7676221CCA996819)) {
        if(_id_5BC60484D17FA95C::_id_1980065CE4DC067B())
          arena = _id_3583FF375AB3A91E::_id_D095C23873D8EFED();
        else
          arena = playergetnextarena();

        _id_8F5D6F42D8464DE0 = getnextjailspawn(arena);
        spawnorigin = getgroundposition(_id_8F5D6F42D8464DE0.origin, 12);
        spawnangles = (0, 0, 0);

        if(isDefined(_id_8F5D6F42D8464DE0.angles))
          spawnangles = _id_8F5D6F42D8464DE0.angles;

        _id_D40DF2F2B26ADA41 _meth_BC667001F9DD3808(spawnorigin);
      }
    }
  }
}

trygulagspawn() {
  if(!istrue(self.br_infilstarted) || !scripts\mp\flags::gameflag("prematch_done"))
    return 0;

  if(istrue(self.gulag))
    return 0;

  if(_id_2CEDCC356F1B9FC8::hasrespawntoken() && !_id_7E52B56769FA7774::respawntokendisabled()) {
    thread playergulagautowin("tryGulagSpawn", undefined, 1, 1);
    return 1;
  }

  if(!_id_4A25D64251FAB1B7())
    return 0;

  if(istrue(level.gulag.shutdown) && !playerinlaststandhold())
    return 0;

  if(getdvarint("dvar_4D250E4873E1753E", 0))
    return 0;

  if(istrue(self.gulagloser) && !_id_2CEDCC356F1B9FC8::_id_15DA77DC195BD80A())
    return 0;

  if(_id_2CEDCC356F1B9FC8::_id_15DA77DC195BD80A() && !_id_2CEDCC356F1B9FC8::_id_8B2396647673BE50())
    _id_7E52B56769FA7774::_id_17E127F2E3771058();

  thread _id_C3014B9015A55715();
  thread initplayerjail(1);
  return 1;
}

_id_4A25D64251FAB1B7() {
  if(!istrue(self.br_infilstarted) || !scripts\mp\flags::gameflag("prematch_done"))
    return 0;

  if(istrue(self.gulag))
    return 0;

  if(!istrue(level.usegulag))
    return 0;

  if(istrue(level.gulag.shutdown) && !playerinlaststandhold())
    return 0;

  if(getdvarint("dvar_4D250E4873E1753E", 0))
    return 0;

  if(!checkgulagusecount() && !_id_2CEDCC356F1B9FC8::_id_15DA77DC195BD80A())
    return 0;

  return 1;
}

playergulaghud(arena) {
  if(isDefined(arena.fightover) && !arena.fightover)
    playersetgulagdataomnvar(arena);

  if(isDefined(arena.fightover) && !arena.fightover && isDefined(arena.time) && arena.time > 0) {
    time = arena.time;

    if(!istrue(arena.overtime)) {
      _id_55C0E7E44829E72E = getovertimelength();
      time = time - _id_55C0E7E44829E72E;
    }

    self setclientomnvar("ui_br_gulag_match_end_time", gettime() + int(time * 1000));
  } else
    self setclientomnvar("ui_br_gulag_match_end_time", 0);
}

updatematchtimerhud(arena, time) {
  _updatematchtimerhudinternal(arena.arenaplayers, time);
  _updatematchtimerhudinternal(arena.jailedplayers, time);
}

_updatematchtimerhudinternal(players, time) {
  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    if(_id_0B0385BB45379222::_id_9005AF34E01BF8FE())
      player scripts\engine\utility::waittill_notify_or_timeout("gulag_done_with_camera_sequence", 8);

    if(time > 0) {
      player setclientomnvar("ui_br_gulag_match_end_time", gettime() + int(time * 1000));
      continue;
    }

    player setclientomnvar("ui_br_gulag_match_end_time", 0);
  }
}

updatematchqueuepositions(arena) {
  for(_id_28F8483EA37164F3 = level.gulag._id_28F8483EA37164F3; _id_28F8483EA37164F3 <= level.gulag.maxplayers; _id_28F8483EA37164F3 = _id_28F8483EA37164F3 + level.gulag._id_28F8483EA37164F3) {
    matches = [];

    foreach(player in arena.jailedplayers) {
      if(!isDefined(player)) {
        continue;
      }
      _id_B9D2D2843310014E = 0;

      foreach(_id_B94827C01CB82F1E, _id_AA9F4C033D62BC8A in matches) {
        if(_id_AA9F4C033D62BC8A.size >= _id_28F8483EA37164F3) {
          continue;
        }
        _id_7FE3B3676D522C19 = 0;

        if(_id_5BC60484D17FA95C::_id_1980065CE4DC067B()) {
          _id_DE841985A7F29953 = player _id_6A7526F387D26776(_id_AA9F4C033D62BC8A);

          if(_id_DE841985A7F29953 >= level._id_43307855F189EB31._id_5A6E1BCEE6E4A7F1)
            _id_7FE3B3676D522C19 = 1;
        } else {
          foreach(_id_4494CAC530E83F63 in _id_AA9F4C033D62BC8A) {
            if(_id_4494CAC530E83F63.team == player.team) {
              _id_7FE3B3676D522C19 = 1;
              break;
            }
          }
        }

        if(!_id_7FE3B3676D522C19) {
          _id_B9D2D2843310014E = 1;
          player.gulagposition = _id_B94827C01CB82F1E + 1;
          matches[_id_B94827C01CB82F1E][matches[_id_B94827C01CB82F1E].size] = player;
          break;
        }
      }

      if(!_id_B9D2D2843310014E) {
        player.gulagposition = matches.size + 1;
        matches[matches.size] = [player];
      }
    }

    arena.matches = matches;

    if(matches.size <= level.gulag.maxqueue) {
      break;
    }
  }

  if(arena.matches.size > 0 && scripts\cp_mp\utility\script_utility::issharedfuncdefined("teamAssim", "isEnabled") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "isEnabled")]]() && scripts\cp_mp\utility\script_utility::issharedfuncdefined("teamAssim", "disablePlayer")) {
    _id_607899D4420FE1A5 = arena.matches[0];

    foreach(player in _id_607899D4420FE1A5)[[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "disablePlayer")]](player, "br_gulag");
  }

  updatearenaomnvarplayers(arena);
}

playerwatchdisconnect(arena) {
  self endon("gulagLost");
  self endon("gulag_end");
  self waittill("death_or_disconnect");

  if(isDefined(self) && istrue(self.gulagarena)) {
    return;
  }
  if(isDefined(self)) {
    if(istrue(self.gulagarena))
      arena.arenaplayers = scripts\engine\utility::array_remove(arena.arenaplayers, self);
    else if(istrue(self.jailed))
      arena.jailedplayers = scripts\engine\utility::array_remove(arena.jailedplayers, self);

    if(isDefined(arena._id_654C981854394718)) {
      if(scripts\engine\utility::array_contains(arena._id_654C981854394718, self))
        arena._id_654C981854394718 = scripts\engine\utility::array_remove(arena._id_654C981854394718, self);
    }

    playerdestroyhud(arena);
  } else
    _id_127C772F981AEFC1(arena);

  updatematchqueuepositions(arena);

  if(_id_03AA8E63A56E3416::_id_6E3541FD8FAB45BC())
    _id_03AA8E63A56E3416::_id_CC5468BB6E866411(arena);
}

playerdestroyhud(arena) {
  self setclientomnvar("ui_br_gulag_match_end_time", 0);

  if(isDefined(arena))
    playercleargulagomnvars(arena);

  if(isDefined(self.gulagjailbreakhud))
    self.gulagjailbreakhud destroy();

  self.gulagloadoutindex = undefined;
}

setplayervargulag(value) {
  if(isDefined(self.gulag) && self.gulag == value) {
    return;
  }
  self.gulag = value;
  level notify("update_circle_hide");
}

setplayervargulagarena(value) {
  if(isDefined(self.gulagarena) && self.gulagarena == value) {
    return;
  }
  setplayeringulagarenaextrainfo(value);
  self.gulagarena = value;
  level notify("update_circle_hide");
}

setplayeringulagarenaextrainfo(value) {
  if(istrue(value))
    self.game_extrainfo = self.game_extrainfo | 1024;
  else
    self.game_extrainfo = self.game_extrainfo &~1024;
}

setplayervargulagjail(value) {
  if(isDefined(self.jailed) && self.jailed == value) {
    return;
  }
  setplayeringulagjailextrainfo(value);
  self.jailed = value;
  level notify("update_circle_hide");
}

setplayeringulagjailextrainfo(value) {
  if(value)
    self.game_extrainfo = self.game_extrainfo | 512;
  else
    self.game_extrainfo = self.game_extrainfo &~512;
}

setplayergulagindex(arena) {
  if(arena.gulagindex > 7) {
    return;
  }
  _id_8534515023AFC188 = 3;
  _id_64571E3AECCD1A07 = 3;
  mask = int(pow(2, _id_8534515023AFC188)) - 1;
  _id_A463992091F1D483 = (arena.gulagindex &mask) << _id_64571E3AECCD1A07;
  _id_F8F977081D3DA8B4 = ~(mask << _id_64571E3AECCD1A07);
  _id_EE27F3F198276535 = self.game_extrainfo;
  _id_ED711AEAF5E8CB76 = _id_EE27F3F198276535 &_id_F8F977081D3DA8B4;
  _id_82A90E56E416FA55 = _id_ED711AEAF5E8CB76 + _id_A463992091F1D483;
  self.game_extrainfo = _id_82A90E56E416FA55;
}

startbetting(arena, fighters) {
  if(!level.gulag.betting)
    return undefined;

  _id_4B434533D3624BEC = spawnStruct();
  _id_4B434533D3624BEC.fighters = fighters;
  _id_4B434533D3624BEC.bets = [];
  _id_4B434533D3624BEC.bettingopen = 1;
  _id_4B434533D3624BEC thread show_betting_to_players(arena);
  return _id_4B434533D3624BEC;
}

show_betting_to_players(arena) {
  self endon("end_betting");

  for(;;) {
    _id_2804A2011E172AB6 = getbettingplayers(arena, self);

    foreach(player in _id_2804A2011E172AB6) {
      if(isbot(player)) {
        continue;
      }
      if(isDefined(self.bets[player.guid])) {
        continue;
      }
      thread showbettinghud(arena, player);
    }

    arena waittill("player_added_to_jail");
  }
}

showbettinghud(arena, player) {
  self endon("end_betting");
  _id_B5FE9E03C0FD6170 = spawnStruct();
  _id_B5FE9E03C0FD6170.owner = player;
  self.bets[player.guid] = _id_B5FE9E03C0FD6170;
  _id_2F415ECBF5EC8BDA = 10;
  _id_3AE4F76CD196D765 = 0;
  _id_B5FE9E03C0FD6170.hudfocusname = player scripts\mp\hud_util::createfontstring("default", 1.2);
  _id_B5FE9E03C0FD6170.hudfocusname scripts\mp\hud_util::setpoint("LEFT", "CENTER", _id_2F415ECBF5EC8BDA, _id_3AE4F76CD196D765);
  _id_B5FE9E03C0FD6170.hudfocusname.label = &"";
  _id_B5FE9E03C0FD6170.hudfocusname.alpha = 0.0;
  _id_C218C54DFC19219C = 5;
  _id_58D5FEF2B1D991CF = -50;
  _id_B5FE9E03C0FD6170.hudavailable = player scripts\mp\hud_util::createfontstring("default", 1.2);
  _id_B5FE9E03C0FD6170.hudavailable scripts\mp\hud_util::setpoint("LEFT", "LEFT", _id_C218C54DFC19219C, _id_58D5FEF2B1D991CF);
  _id_B5FE9E03C0FD6170.hudavailable.label = &"MP/BR_GULAG_BET_AVAILABLE";
  _id_B5FE9E03C0FD6170.hudavailable scripts\mp\hud::fontpulseinit();
  _id_B5FE9E03C0FD6170.hudbetonplayer = player scripts\mp\hud_util::createfontstring("default", 1.5);
  _id_B5FE9E03C0FD6170.hudbetonplayer scripts\mp\hud_util::setpoint("LEFT", "LEFT", _id_C218C54DFC19219C, _id_58D5FEF2B1D991CF + 25);
  _id_B5FE9E03C0FD6170.hudbetonplayer.label = &"";
  _id_B5FE9E03C0FD6170.hudammount = player scripts\mp\hud_util::createfontstring("default", 1.5);
  _id_B5FE9E03C0FD6170.hudammount scripts\mp\hud_util::setpoint("LEFT", "LEFT", _id_C218C54DFC19219C, _id_58D5FEF2B1D991CF + 40);
  _id_B5FE9E03C0FD6170.hudammount.label = &"MP/BR_GULAG_BET_AMMOUNT";
  _id_B5FE9E03C0FD6170.playerbeton = -1;
  _id_B5FE9E03C0FD6170.playerfocus = -1;
  _id_B5FE9E03C0FD6170.ammount = 0;
  updatebethud(_id_B5FE9E03C0FD6170);
  thread updatebetplayerfocus(arena, _id_B5FE9E03C0FD6170);
  thread watchbetplaced(_id_B5FE9E03C0FD6170);
}

updatebetplayerfocus(arena, _id_B5FE9E03C0FD6170) {
  self endon("end_betting");
  _id_B5FE9E03C0FD6170.owner endon("disconnect");
  _id_ED9AE4EC33B989C6 = 0.9;

  for(;;) {
    playerfocus = -1;
    _id_445ACA8C2C95592E = -1.0;
    _id_CB1A928757E7D0AD = _id_B5FE9E03C0FD6170.owner getEye();
    _id_BE8E4C874F6DECCF = anglesToForward(_id_B5FE9E03C0FD6170.owner getplayerangles());

    foreach(_id_AC0E594AC96AA3A8, _id_4570788876702376 in self.fighters) {
      if(!isDefined(_id_4570788876702376)) {
        continue;
      }
      _id_499A4B568077F460 = _id_4570788876702376.origin + (0, 0, 30);
      _id_ECAF2C0500E55585 = vectorNormalize(_id_499A4B568077F460 - _id_CB1A928757E7D0AD);
      _id_A93753D72E9F269D = vectordot(_id_BE8E4C874F6DECCF, _id_ECAF2C0500E55585);

      if(_id_A93753D72E9F269D < _id_ED9AE4EC33B989C6 || _id_A93753D72E9F269D < _id_445ACA8C2C95592E) {
        continue;
      }
      playerfocus = _id_AC0E594AC96AA3A8;
      _id_445ACA8C2C95592E = _id_A93753D72E9F269D;
    }

    if(playerfocus != _id_B5FE9E03C0FD6170.playerfocus) {
      _id_B5FE9E03C0FD6170.playerfocus = playerfocus;
      updateoutlines(arena);
      updatebethud(_id_B5FE9E03C0FD6170);
    }

    wait 0.05;
  }
}

watchbetclear(_id_B5FE9E03C0FD6170) {
  self endon("end_betting");
  _id_B5FE9E03C0FD6170.owner endon("disconnect");
  notifystring = "betClear";
  thread notifyonplayercommandbetting(_id_B5FE9E03C0FD6170.owner, notifystring, "+weapnext");

  for(;;) {
    _id_B5FE9E03C0FD6170.owner waittill(notifystring);

    if(_id_B5FE9E03C0FD6170.playerbeton == -1) {
      continue;
    }
    _id_B5FE9E03C0FD6170.ammount = 0;
    _id_B5FE9E03C0FD6170.playerbeton = -1;
    updatebethud(_id_B5FE9E03C0FD6170);
  }
}

watchbetplaced(_id_B5FE9E03C0FD6170) {
  self endon("end_betting");
  _id_B5FE9E03C0FD6170.owner endon("disconnect");
  notifystring = "betPlaced";
  thread notifyonplayercommandbetting(_id_B5FE9E03C0FD6170.owner, notifystring, "+usereload");

  for(;;) {
    _id_B5FE9E03C0FD6170.owner waittill(notifystring);

    if(_id_B5FE9E03C0FD6170.playerfocus == -1) {
      if(_id_B5FE9E03C0FD6170.playerbeton == -1) {
        continue;
      }
      _id_B69761E52EEABA08 = 0;
    } else if(_id_B5FE9E03C0FD6170.playerbeton == -1)
      _id_B69761E52EEABA08 = 1;
    else if(_id_B5FE9E03C0FD6170.playerbeton == _id_B5FE9E03C0FD6170.playerfocus)
      _id_B69761E52EEABA08 = _id_B5FE9E03C0FD6170.ammount + 1;
    else
      _id_B69761E52EEABA08 = 1;

    if(_id_B69761E52EEABA08 > _id_B5FE9E03C0FD6170.owner.plundercount) {
      betchangefail(_id_B5FE9E03C0FD6170);
      continue;
    }

    _id_B5FE9E03C0FD6170.ammount = _id_B69761E52EEABA08;
    _id_B5FE9E03C0FD6170.playerbeton = _id_B5FE9E03C0FD6170.playerfocus;
    updatebethud(_id_B5FE9E03C0FD6170);
  }
}

notifyonplayercommandbetting(player, _id_DEE1E90C5A8243B7, _id_5CC861C93DE7E4A6) {
  player notifyonplayercommand(_id_DEE1E90C5A8243B7, _id_5CC861C93DE7E4A6);
  self waittill("end_betting");

  if(isDefined(player))
    player notifyonplayercommandremove(_id_DEE1E90C5A8243B7, _id_5CC861C93DE7E4A6);
}

betchangefail(_id_B5FE9E03C0FD6170) {
  _id_B5FE9E03C0FD6170.owner playlocalsound("br_pickup_deny");
  _id_B5FE9E03C0FD6170.hudavailable thread scripts\mp\hud::fontpulse(_id_B5FE9E03C0FD6170.owner);
}

updatebethud(_id_B5FE9E03C0FD6170) {
  _id_E40839434E2834AD = 1000;
  _id_B5FE9E03C0FD6170.hudavailable setvalue((_id_B5FE9E03C0FD6170.owner.plundercount - _id_B5FE9E03C0FD6170.ammount) * _id_E40839434E2834AD);

  if(_id_B5FE9E03C0FD6170.playerbeton != -1) {
    _id_B57068D736BDFAC3 = self.fighters[_id_B5FE9E03C0FD6170.playerbeton];

    if(isDefined(_id_B57068D736BDFAC3)) {
      _id_B5FE9E03C0FD6170.hudbetonplayer setplayernamestring(_id_B57068D736BDFAC3);
      _id_B5FE9E03C0FD6170.hudbetonplayer.alpha = 1.0;
    } else
      _id_B5FE9E03C0FD6170.hudbetonplayer.alpha = 0.0;
  } else
    _id_B5FE9E03C0FD6170.hudbetonplayer.alpha = 0.0;

  if(_id_B5FE9E03C0FD6170.ammount > 0) {
    _id_B5FE9E03C0FD6170.hudammount setvalue(_id_B5FE9E03C0FD6170.ammount * _id_E40839434E2834AD);
    _id_B5FE9E03C0FD6170.hudammount.alpha = 1.0;
  } else
    _id_B5FE9E03C0FD6170.hudammount.alpha = 0.0;

  if(_id_B5FE9E03C0FD6170.playerbeton != -1) {
    if(_id_B5FE9E03C0FD6170.playerfocus == _id_B5FE9E03C0FD6170.playerbeton) {
      _id_B5FE9E03C0FD6170.hudfocusname.alpha = 1.0;
      _id_B5FE9E03C0FD6170.hudfocusname.label = &"MP/BR_GULAG_FOCUS_BET_INCREASE";
      _id_B5FE9E03C0FD6170.hudfocusname settext(&"");
    } else if(_id_B5FE9E03C0FD6170.playerfocus != -1) {
      _id_B5FE9E03C0FD6170.hudfocusname.alpha = 1.0;
      _id_B5FE9E03C0FD6170.hudfocusname.label = &"MP/BR_GULAG_FOCUS_BET_CHANGE";
      _id_B57068D736BDFAC3 = self.fighters[_id_B5FE9E03C0FD6170.playerfocus];

      if(isDefined(_id_B57068D736BDFAC3)) {
        _id_B5FE9E03C0FD6170.hudfocusname setplayernamestring(_id_B57068D736BDFAC3);
        return;
      }
    } else {
      _id_B5FE9E03C0FD6170.hudfocusname.alpha = 1.0;
      _id_B5FE9E03C0FD6170.hudfocusname.label = &"MP/BR_GULAG_FOCUS_BET_CLEAR";
      _id_B5FE9E03C0FD6170.hudfocusname settext(&"");
    }
  } else if(_id_B5FE9E03C0FD6170.playerfocus != -1) {
    _id_B5FE9E03C0FD6170.hudfocusname.alpha = 1.0;
    _id_B5FE9E03C0FD6170.hudfocusname.label = &"MP/BR_GULAG_FOCUS_BET";
    _id_B57068D736BDFAC3 = self.fighters[_id_B5FE9E03C0FD6170.playerfocus];

    if(isDefined(_id_B57068D736BDFAC3)) {
      _id_B5FE9E03C0FD6170.hudfocusname setplayernamestring(_id_B57068D736BDFAC3);
      return;
    }
  } else {
    _id_B5FE9E03C0FD6170.hudfocusname.alpha = 0.0;
    _id_B5FE9E03C0FD6170.hudfocusname.label = &"";
  }
}

cleanupbethud(_id_B5FE9E03C0FD6170, _id_74B5B12BB6514385) {
  _id_B5FE9E03C0FD6170 notify("cleanUpBetHud");

  if(isDefined(_id_74B5B12BB6514385)) {
    _id_B5FE9E03C0FD6170 endon("cleanUpBetHud");
    wait(_id_74B5B12BB6514385);
  }

  huds = [_id_B5FE9E03C0FD6170.hudbetonplayer, _id_B5FE9E03C0FD6170.hudammount, _id_B5FE9E03C0FD6170.hudavailable, _id_B5FE9E03C0FD6170.hudfocusname];

  foreach(hud in huds) {
    if(isDefined(hud))
      hud destroy();
  }
}

watchbetbutton(_id_B5FE9E03C0FD6170, player, _id_DEE1E90C5A8243B7, index) {
  self endon("end_betting");

  for(;;) {
    player waittill(_id_DEE1E90C5A8243B7);
    _id_B5FE9E03C0FD6170 notify("betPlaced", index);
  }
}

endbetting(arena, _id_4B434533D3624BEC) {
  if(!isDefined(_id_4B434533D3624BEC) || !istrue(_id_4B434533D3624BEC.bettingopen)) {
    return;
  }
  _id_4B434533D3624BEC notify("end_betting");
  _id_4B434533D3624BEC.bettingopen = 0;

  foreach(_id_B5FE9E03C0FD6170 in _id_4B434533D3624BEC.bets) {
    huds = [_id_B5FE9E03C0FD6170.hudavailable, _id_B5FE9E03C0FD6170.hudfocusname];

    if(_id_B5FE9E03C0FD6170.playerbeton == -1) {
      huds[huds.size] = _id_B5FE9E03C0FD6170.hudbetonplayer;
      huds[huds.size] = _id_B5FE9E03C0FD6170.hudammount;
    }

    foreach(hud in huds) {
      if(isDefined(hud))
        hud destroy();
    }
  }

  updateoutlines(arena);
}

payoutremainingbets(winner, _id_4B434533D3624BEC) {
  if(!isDefined(_id_4B434533D3624BEC)) {
    return;
  }
  _id_1A76078D68FFCF56 = -1;

  if(isDefined(winner))
    _id_1A76078D68FFCF56 = winner.fighterindex;

  foreach(_id_B5FE9E03C0FD6170 in _id_4B434533D3624BEC.bets) {
    if(_id_B5FE9E03C0FD6170.playerbeton != -1 && isDefined(_id_B5FE9E03C0FD6170.owner) && !istrue(_id_B5FE9E03C0FD6170.paidout)) {
      _id_7C6311737CB7A0B2 = _id_B5FE9E03C0FD6170.playerbeton == _id_1A76078D68FFCF56;
      _completebet(_id_4B434533D3624BEC, _id_B5FE9E03C0FD6170, _id_7C6311737CB7A0B2);
    }

    thread cleanupbethud(_id_B5FE9E03C0FD6170, 2.5);
  }
}

_completebet(_id_4B434533D3624BEC, _id_B5FE9E03C0FD6170, _id_7C6311737CB7A0B2) {
  _id_40B237CD9EA72E30 = (0, 1, 0);
  _id_2B25DB2C6E526CC3 = (1, 0, 0);
  _id_B5FE9E03C0FD6170.paidout = 1;

  if(_id_7C6311737CB7A0B2) {
    _id_B5FE9E03C0FD6170.owner _id_6AFF3948CF4CCA03::playersetplundercount(_id_B5FE9E03C0FD6170.owner.plundercount + _id_B5FE9E03C0FD6170.ammount);
    _id_B5FE9E03C0FD6170.hudbetonplayer.color = _id_40B237CD9EA72E30;
    _id_B5FE9E03C0FD6170.hudbetonplayer.label = &"MP/BR_GULAG_BET_FIGHTER_NAME_WINNER";
    _id_B5FE9E03C0FD6170.hudammount.color = _id_40B237CD9EA72E30;
    _id_B5FE9E03C0FD6170.hudammount.label = &"MP/BR_GULAG_BET_AMMOUNT_WON";
  } else {
    _id_B5FE9E03C0FD6170.hudbetonplayer.color = _id_2B25DB2C6E526CC3;
    _id_B5FE9E03C0FD6170.hudbetonplayer.label = &"MP/BR_GULAG_BET_FIGHTER_NAME_LOSER";
    _id_B5FE9E03C0FD6170.hudammount.color = _id_2B25DB2C6E526CC3;
    _id_B5FE9E03C0FD6170.hudammount.label = &"MP/BR_GULAG_BET_AMMOUNT_LOST";

    if(isalive(_id_B5FE9E03C0FD6170.owner)) {
      _id_43E1B640EEC49671 = _id_B5FE9E03C0FD6170.owner.plundercount - _id_B5FE9E03C0FD6170.ammount;
      _id_43E1B640EEC49671 = int(max(0, _id_43E1B640EEC49671));
      _id_B5FE9E03C0FD6170.owner _id_6AFF3948CF4CCA03::playersetplundercount(_id_43E1B640EEC49671);
    }
  }

  _id_B57068D736BDFAC3 = _id_4B434533D3624BEC.fighters[_id_B5FE9E03C0FD6170.playerfocus];

  if(isDefined(_id_B57068D736BDFAC3))
    _id_B57068D736BDFAC3 hudoutlinedisableforclient(_id_B5FE9E03C0FD6170.owner);
}

getbettingplayers(arena, _id_4B434533D3624BEC) {
  _id_2804A2011E172AB6 = arena.jailedplayers;

  if(level.gulag.betting > 1) {
    foreach(_id_4570788876702376 in _id_4B434533D3624BEC.fighters)
    _id_2804A2011E172AB6[_id_2804A2011E172AB6.size] = _id_4570788876702376;
  }

  return _id_2804A2011E172AB6;
}

payoutbet(_id_4B434533D3624BEC, player, _id_7C6311737CB7A0B2) {
  if(!isDefined(_id_4B434533D3624BEC)) {
    return;
  }
  foreach(_id_B5FE9E03C0FD6170 in _id_4B434533D3624BEC.bets) {
    if(_id_B5FE9E03C0FD6170.playerbeton == player.fighterindex && isDefined(_id_B5FE9E03C0FD6170.owner) && !istrue(_id_B5FE9E03C0FD6170.paidout)) {
      _completebet(_id_4B434533D3624BEC, _id_B5FE9E03C0FD6170, _id_7C6311737CB7A0B2);
      thread cleanupbethud(_id_B5FE9E03C0FD6170, 2.5);
    }
  }
}

rock_used(grenade) {
  arena = self.arena;
  grenade scripts\engine\utility::waittill_notify_or_timeout("missile_stuck", 4);
  wait 2;

  if(isDefined(grenade))
    grenade delete();

  if(istrue(level.usegulag) && level.gulag.usefloorrocks)
    spawnrock(arena);
}

spawnrocks(arena) {
  arena.rocks = getentitylessscriptablearray(arena.target, "targetname");

  if(arena.rocks.size == 0 || !level.gulag.usefloorrocks) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < arena.rocks.size; _id_AC0E594AC96AA3A8++) {
      _id_E293C5C5923A7E88 = arena.rocks[_id_AC0E594AC96AA3A8];

      if(_id_E293C5C5923A7E88 getscriptableparthasstate("brloot_rock", "hidden"))
        _id_E293C5C5923A7E88 setscriptablepartstate("brloot_rock", "hidden");
    }

    return;
  }

  _id_630781C4F7E18225 = getdvarint("dvar_557A54E530663166", 20);

  if(arena.rocks.size < _id_630781C4F7E18225)
    _id_630781C4F7E18225 = arena.rocks.size;

  arena.rocks = scripts\engine\utility::array_randomize(arena.rocks);
  arena.rockcounter = _id_630781C4F7E18225;
  _id_9CF140DC95FE44D7 = getdvarint("dvar_983B34DF705745CE", 1) == 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < arena.rocks.size; _id_AC0E594AC96AA3A8++) {
    _id_E293C5C5923A7E88 = arena.rocks[_id_AC0E594AC96AA3A8];
    _id_E293C5C5923A7E88.arena = arena;

    if(_id_AC0E594AC96AA3A8 >= _id_630781C4F7E18225 || _id_9CF140DC95FE44D7)
      _id_E293C5C5923A7E88 setscriptablepartstate("brloot_rock", "hidden");
  }
}

rockused(_id_E293C5C5923A7E88, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isDefined(_id_E293C5C5923A7E88) || !isDefined(player)) {
    return;
  }
  _id_2A333167CFC47AB1 = makeweapon("rock_mp");

  if(player hasweapon(_id_2A333167CFC47AB1) && player getammocount(_id_2A333167CFC47AB1) > 0) {
    return;
  }
  _id_E293C5C5923A7E88 setscriptablepartstate("brloot_rock", "hidden");
  player thread _id_7E52B56769FA7774::playerplaypickupanim();
  player scripts\mp\equipment::giveequipment("equip_rock", "primary");
  player playlocalsound("br_rock_pickup");
}

spawnrock(arena) {
  if(istrue(arena.shutdown) || arena.rocks.size == 0) {
    return;
  }
  _id_E293C5C5923A7E88 = arena.rocks[arena.rockcounter];

  if(isDefined(_id_E293C5C5923A7E88)) {
    _id_E293C5C5923A7E88 setscriptablepartstate("brloot_rock", "visible");
    arena.rockcounter++;

    if(arena.rockcounter >= arena.rocks.size)
      arena.rockcounter = 0;
  }
}

playertakeawayrock(arena) {
  _id_2A333167CFC47AB1 = makeweapon("rock_mp");

  if(self hasweapon(_id_2A333167CFC47AB1)) {
    self takeweapon(_id_2A333167CFC47AB1);
    self clearaccessory();

    if(level.gulag.usefloorrocks)
      spawnrock(arena);
  }
}

gettangentoncirclefrompoint(circlecenter, circleradius, point) {
  xp = point[0] - circlecenter[0];
  _id_CDEB3778F5379198 = point[1] - circlecenter[1];
  r = circleradius;
  _id_251EC40356DDE849 = xp * xp;
  _id_13DCA903493558DE = _id_CDEB3778F5379198 * _id_CDEB3778F5379198;
  _id_CDD57B78F51FF3F1 = r * r;
  c = _id_251EC40356DDE849 + _id_13DCA903493558DE - _id_CDD57B78F51FF3F1;
  _id_1939553953102A08 = undefined;
  _id_5371D63EF1DA1802 = 1;

  if(c > 0) {
    x = (_id_CDD57B78F51FF3F1 * xp - r * _id_CDEB3778F5379198 * sqrt(_id_251EC40356DDE849 + _id_13DCA903493558DE - _id_CDD57B78F51FF3F1)) / (_id_251EC40356DDE849 + _id_13DCA903493558DE);
    y = (_id_CDD57B78F51FF3F1 * _id_CDEB3778F5379198 + r * xp * sqrt(_id_251EC40356DDE849 + _id_13DCA903493558DE - _id_CDD57B78F51FF3F1)) / (_id_251EC40356DDE849 + _id_13DCA903493558DE);
    _id_1939553953102A08 = (x, y, point[2]) + (circlecenter[0], circlecenter[1], 0);
  } else {
    _id_BF3B7724DEA266FE = vectorNormalize((xp, _id_CDEB3778F5379198, 0));
    _id_AC0E424AC96A7113 = circlecenter + _id_BF3B7724DEA266FE * circleradius;
    _id_1939553953102A08 = (_id_AC0E424AC96A7113[0], _id_AC0E424AC96A7113[1], point[2]);
    _id_5371D63EF1DA1802 = 0;
  }

  return [_id_1939553953102A08, _id_5371D63EF1DA1802];
}

spawnac130() {
  if(!istrue(level.gulag.planerespawn)) {
    return;
  }
  level waittill("prematch_started");

  if(!istrue(level.br_infils_disabled))
    wait 10;

  startpt = undefined;
  circleradius = undefined;

  if(isDefined(level.br_ac130))
    startpt = level.br_ac130.startpt;
  else {
    c130pathstruct = _id_45B2B4A889E633FA::createtestc130path();
    startpt = c130pathstruct.startpt;
  }

  if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent))
    circleradius = level.br_circle.safecircleent.origin[2];
  else
    circleradius = level.br_level.br_circleradii[0];

  circleradius = circleradius - 100;
  [endpt, _id_5371D63EF1DA1802] = gettangentoncirclefrompoint(level.br_level.br_mapcenter, circleradius, startpt);
  dist = 0;
  time = 0;

  if(_id_5371D63EF1DA1802) {
    dist = distance(startpt, endpt);
    time = dist / _id_45B2B4A889E633FA::getc130speed();
  }

  _id_91AD7677313C6B84 = (level.br_level.br_mapcenter[0], level.br_level.br_mapcenter[1], startpt[2]);
  level.gulag.ac130linker = spawn("script_model", _id_91AD7677313C6B84);
  level.gulag.ac130linker setModel("tag_origin");
  level.gulag.ac130linker.radius = circleradius;
  level.gulag.ac130 = _id_45B2B4A889E633FA::gunship_spawn(startpt, endpt, time, 0, ::ac130handlemovement);
  level.gulag.ac130 thread ac130setupanim();
  level.gulag.ac130.riders = [];

  if(time <= 0) {
    _id_E31D6FE7007E7EAB = endpt - level.br_level.br_mapcenter;
    _id_D146BEA510112C2E = vectorNormalize((_id_E31D6FE7007E7EAB[0], _id_E31D6FE7007E7EAB[1], 0));
    angles = vectortoangles(_id_D146BEA510112C2E);
    level.gulag.ac130 unlink();
    level.gulag.ac130.angles = (0, angles[1] + 90, 0);
    level.gulag.ac130.origin = endpt;
    level.gulag.ac130 thread ac130linkandspin();
  }
}

ac130setupanim() {
  animstruct = spawnStruct();
  self.animstruct = animstruct;
  animstruct.movingc130 = self;
  _id_7933519955F32C4E::spawnplayerpositionparentent(animstruct, self);
  _id_7933519955F32C4E::spawnplayerpositionent(animstruct, "j_prop_1");
  _id_7933519955F32C4E::playac130infilloopanims(animstruct);
}

ac130handlemovement(_id_C7F46EF27D351CD0, movetime) {
  level endon("game_ended");
  self endon("death");
  self playLoopSound("br_ac130_lp");

  if(movetime > 0) {
    self moveTo(_id_C7F46EF27D351CD0, movetime, 0, 0);
    wait(movetime);
  }

  thread ac130linkandspin();
}

ac130linkandspin() {
  self notify("ac130LinkAndSpin");
  self endon("ac130LinkAndSpin");
  level.gulag.ac130linker endon("death");
  _id_40F8C8EE714EF7CA = 6.28318;
  _id_29BA0FB266411D2F = _id_45B2B4A889E633FA::getc130speed();
  circleradius = level.gulag.ac130linker.radius;
  time = _id_40F8C8EE714EF7CA * circleradius / _id_29BA0FB266411D2F;
  self linkTo(level.gulag.ac130linker, "tag_origin");

  if(time <= 0) {
    return;
  }
  for(;;) {
    level.gulag.ac130linker rotateYaw(360, time);
    wait(time);
  }
}

waittillallarenasshutdown() {
  _id_2F1BA8552DC9A492 = level.gulag.arenas.size;

  if(!istrue(level.gulag.multiarena))
    _id_2F1BA8552DC9A492 = 1;

  for(;;) {
    running = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2F1BA8552DC9A492; _id_AC0E594AC96AA3A8++) {
      arena = level.gulag.arenas[_id_AC0E594AC96AA3A8];

      if(!istrue(arena.shutdown)) {
        running = 1;
        break;
      }
    }

    if(!running) {
      return;
    }
    waitframe();
  }
}

makeac130flyaway() {
  if(!istrue(level.gulag.planerespawn)) {
    return;
  }
  starttime = gettime();
  waittillallarenasshutdown();
  _id_C2F6414586A60B86 = gettime();
  wait(getdvarint("dvar_8780B8778180D47C", 15));
  waittillframeend;

  foreach(player in level.gulag.ac130.riders) {
    if(isDefined(player)) {
      player.jumptype = "solo";
      player notify("halo_kick_c130");
    }
  }

  while(level.gulag.ac130.riders.size > 0)
    waitframe();

  startpt = level.gulag.ac130.origin;
  pathdir = anglesToForward(level.gulag.ac130.angles);
  _id_5619B7BBC3745888 = level.br_level.br_circleradii[0] * 2;
  endpt = startpt + pathdir * _id_5619B7BBC3745888;
  endpt = endpt + pathdir * _id_45B2B4A889E633FA::getc130speed();
  dist = distance(startpt, endpt);
  time = dist / _id_45B2B4A889E633FA::getc130speed();
  level.gulag.ac130 notify("ac130LinkAndSpin");
  level.gulag.ac130 unlink();
  level.gulag.ac130 moveTo(endpt, time, 0, 0);
  wait(time);
  _id_2CEDCC356F1B9FC8::cleanac130struct(level.gulag.ac130.animstruct);

  if(isDefined(level.gulag.ac130))
    level.gulag.ac130 delete();

  if(isDefined(level.gulag.ac130linker))
    level.gulag.ac130linker delete();
}

transitioncircle(_id_A66785EDEC9E567B, waittime) {
  if(!istrue(level.gulag.planerespawn)) {
    return;
  }
  if(!isDefined(level.gulag.ac130) || !isDefined(level.gulag.ac130linker)) {
    return;
  }
  _id_A9706ADAF7C52E27 = (level.br_circle.safecircleent.origin[0], level.br_circle.safecircleent.origin[1], level.gulag.ac130linker.origin[2]);
  _id_A66785EDEC9E567B = _id_A66785EDEC9E567B - 100;

  if(level.gulag.ac130linker.radius != _id_A66785EDEC9E567B) {
    _id_6D85A82025F375E8 = vectorNormalize(level.gulag.ac130linker.origin - level.gulag.ac130.origin);
    _id_7C472EC4204B05DC = level.gulag.ac130.origin + _id_6D85A82025F375E8 * _id_A66785EDEC9E567B;
    level.gulag.ac130 unlink();
    level.gulag.ac130linker.origin = _id_7C472EC4204B05DC;
    level.gulag.ac130linker.radius = _id_A66785EDEC9E567B;
    level.gulag.ac130linker dontinterpolate();
    level.gulag.ac130 thread ac130linkandspin();
  }

  level.gulag.ac130linker moveTo(_id_A9706ADAF7C52E27, waittime);
  wait(waittime);
}

playersetupac130() {
  self.infilanimindex = 1;
  self.isjumpmaster = 0;
  _id_7933519955F32C4E::playerlinktopositionent(level.gulag.ac130.animstruct);
  thread _id_7933519955F32C4E::playerplayinfilloopanim(level.gulag.ac130.animstruct);
  thread playerputinc130(level.gulag.ac130);
  _id_7933519955F32C4E::playersetupcontrolsforinfil(1);
  thread playerac130cleanup();
  thread playerautodeployaftertime();
  thread playerspawnprotectionac130();
  level.gulag.ac130.riders[level.gulag.ac130.riders.size] = self;
}

playerputinc130(c130) {
  self.angles = c130.angles;
  thread listenjump(c130);
  thread _id_45B2B4A889E633FA::listenkick(c130, 0);
  self.c130 = level.gulag.ac130;
  self.br_infil_type = "c130";
  thread _id_45B2B4A889E633FA::orbitcam(c130);
}

listenjump(c130) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("cancel_c130");
  self endon("br_jump");
  self.redeployenabled = 0;
  scripts\engine\utility::waittill_either("halo_jump_c130", "halo_jump_solo_c130");
  self.jumptype = "solo";
  thread _id_45B2B4A889E633FA::leaveplane(c130, 0, self getplayerangles(), 0);
}

playerspawnprotectionac130() {
  self endon("death_or_disconnect");
  self.plotarmor = 1;
  _id_45B2B4A889E633FA::setplayervarinrespawnc130(1);
  waittillplayerdoneskydivingac130(self);
  self.plotarmor = undefined;
  _id_45B2B4A889E633FA::setplayervarinrespawnc130(0);
}

waittillplayerdoneskydivingac130(player) {
  player endon("timeout_gulag_ac130");
  thread _waittillplayerdoneskydivingac130timeout(player);
  player waittill("infil_jump_done");

  while(!player isparachuting() && !player isonground())
    waitframe();
}

_waittillplayerdoneskydivingac130timeout(player) {
  player endon("death_or_disconnect");
  player scripts\engine\utility::waittill_any_timeout_2(getdvarint("dvar_8780B8778180D47C", 15), "halo_kick_c130", "halo_jump_solo_c130");
  wait 15;
  player notify("timeout_gulag_ac130");
}

playerautodeployaftertime() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("cancel_c130");
  self endon("br_jump");
  wait(getdvarint("dvar_8780B8778180D47C", 15));
  self.jumptype = "solo";
  self notify("halo_kick_c130");
}

playerac130cleanup() {
  level endon("game_ended");
  scripts\engine\utility::waittill_any_4("disconnect", "death", "cancel_c130", "infil_jump_done");

  if(!isDefined(level.gulag.ac130.riders)) {
    return;
  }
  if(isDefined(self))
    level.gulag.ac130.riders = scripts\engine\utility::array_remove(level.gulag.ac130.riders, self);
  else
    level.gulag.ac130.riders = scripts\engine\utility::array_removeundefined(level.gulag.ac130.riders);
}

playergulagautowin(context, _id_4AC881E2A39322A5, _id_57D71760971F748F, _id_5806C4765695A2F4, _id_74AF5908127B6729, _id_36F3C4E4A602E257, _id_DF631FDD92A76BB1, _id_B6ACF0C07C4311E6) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player notify("gulag_auto_win");

  if(istrue(player.respawningfromtoken)) {
    return;
  }
  if(_id_03AA8E63A56E3416::_id_6E3541FD8FAB45BC() && _id_5BC60484D17FA95C::_id_CFE304859F30E747("gulagWinSequence")) {
    if(!isDefined(_id_B6ACF0C07C4311E6))
      _id_B6ACF0C07C4311E6 = "br_twotwo_gulag_win";

    player _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("gulagWinSequence", self.arena, _id_B6ACF0C07C4311E6);
  }

  [_id_84E2123AACA9A965, _id_DF2FBB13C226BE75] = player _id_5BAB271917698DC4::playerhandlesponsor(_id_4AC881E2A39322A5, _id_57D71760971F748F, _id_74AF5908127B6729, undefined, _id_36F3C4E4A602E257, context);
  player.respawningfromtoken = 1;
  _id_DBC5E63A72F2678A = _id_362C58E8BB39BCDA::runbrgametypefunc("playerGulagAutoWinWait", _id_4AC881E2A39322A5, _id_57D71760971F748F);
  _id_80365E25F6E3BEFD = undefined;

  if(!istrue(_id_DBC5E63A72F2678A))
    _id_80365E25F6E3BEFD = 1.0;

  _id_46FF3A000308206A = undefined;

  if(!isDefined(_id_4AC881E2A39322A5) && !istrue(_id_5806C4765695A2F4))
    _id_46FF3A000308206A = 4;

  _id_FB551788DA0FC531 = 1;
  _id_03BD8653773757C7 = 1;
  _id_30A91E1938CFD1B2 = _id_6F4FA9B79A3C7DCE(_id_FB551788DA0FC531, _id_DF2FBB13C226BE75, _id_03BD8653773757C7, _id_84E2123AACA9A965, _id_74AF5908127B6729, undefined, undefined, _id_46FF3A000308206A, undefined, _id_DF631FDD92A76BB1, _id_57D71760971F748F);
  _id_5BAB271917698DC4::_id_D5EE3D3FAD992D43(_id_80365E25F6E3BEFD, _id_30A91E1938CFD1B2);

  if(context == "jailbreak" || context == "phoenix") {
    if(isDefined(level.gulag)) {
      foreach(arena in level.gulag.arenas) {
        if(scripts\engine\utility::array_contains(arena.jailedplayers, self)) {
          arena.jailedplayers = scripts\engine\utility::array_remove(arena.jailedplayers, self);
          break;
        }
      }
    }

    player.placementstatsset = undefined;
    player.processlobbydataforclient = undefined;
    player.brbonusxpallowed = undefined;
    player.br_spectatorinitialized = undefined;
    player setclientomnvar("ui_br_player_position", 155);
    player setclientomnvar("ui_br_squad_eliminated_active", 0);
    player setclientomnvar("ui_round_end_title", 0);
    player setclientomnvar("ui_round_end_reason", 0);
  }
}

gulaginitloadouts() {
  level.gulag.jailloadout = creategulagjailloadout();
  _id_4BCEDFE145EE674E();
}

creategulagjailloadout() {
  loadout = [];
  loadout["loadoutArchetype"] = "archetype_assault";
  loadout["loadoutPrimary"] = "iw9_me_fists";
  loadout["loadoutPrimaryAttachment"] = "none";
  loadout["loadoutPrimaryAttachment2"] = "none";
  loadout["loadoutPrimaryCamo"] = "none";
  loadout["loadoutPrimaryReticle"] = "none";
  loadout["loadoutSecondary"] = "none";
  loadout["loadoutSecondaryAttachment"] = "none";
  loadout["loadoutSecondaryAttachment2"] = "none";
  loadout["loadoutSecondaryCamo"] = "none";
  loadout["loadoutSecondaryReticle"] = "none";
  loadout["loadoutMeleeSlot"] = "none";

  if(!_id_46FDF7B12C5F5620::_id_7EFFA8A355DDC886() || _id_46FDF7B12C5F5620::_id_79FDF5CD036FF575())
    loadout["loadoutEquipmentPrimary"] = "equip_rock";
  else
    loadout["loadoutEquipmentPrimary"] = "none";

  loadout["loadoutEquipmentSecondary"] = "none";
  loadout["loadoutStreakType"] = "assault";
  loadout["loadoutKillstreak1"] = "none";
  loadout["loadoutKillstreak2"] = "none";
  loadout["loadoutKillstreak3"] = "none";
  loadout["loadoutSuper"] = "super_br_extract";
  loadout["loadoutPerks"] = ["specialty_null"];
  loadout["loadoutGesture"] = "playerData";
  loadout["loadoutExecution"] = "none";
  return loadout;
}

_id_4BCEDFE145EE674E() {
  level.gulagloadouts = [];
  level.gulagloadouttable = choosegulagloadouttable();

  if(getDvar("dvar_6EF30F04F9851A88") != "") {
    _id_D61EA355B2C5B7D5 = strtok(getDvar("dvar_6EF30F04F9851A88"), " ");
    _id_4D4AA257C98F2157 = [];

    for(_id_2613246720524878 = 0; _id_2613246720524878 < _id_D61EA355B2C5B7D5.size; _id_2613246720524878++)
      _id_4D4AA257C98F2157[_id_4D4AA257C98F2157.size] = int(_id_D61EA355B2C5B7D5[_id_4D4AA257C98F2157.size]);

    _id_07D958726E11B327 = _id_4D4AA257C98F2157.size;

    for(_id_089688461C79EF11 = 0; _id_089688461C79EF11 < _id_07D958726E11B327; _id_089688461C79EF11++)
      level.gulagloadouts[level.gulagloadouts.size] = creategulagarenaloadout(_id_4D4AA257C98F2157[_id_089688461C79EF11]);
  } else {
    _id_07D958726E11B327 = scripts\mp\class::_id_DF2933F96D726D71(level.gulagloadouttable) - 1;

    for(_id_089688461C79EF11 = 0; _id_089688461C79EF11 < _id_07D958726E11B327; _id_089688461C79EF11++)
      level.gulagloadouts[level.gulagloadouts.size] = creategulagarenaloadout(_id_089688461C79EF11);
  }

  if(getdvarint("dvar_249A73868C9CD7D8", 0))
    _id_7E52B56769FA7774::_id_23A8498A6613DE14();
}

choosegulagloadouttable() {
  _id_E6AECBD7458C0F49 = 1;
  _id_499D31877DFBC29D = randomint(1337) + 1;

  if(_id_499D31877DFBC29D == 1337)
    _id_E6AECBD7458C0F49 = 99;
  else {
    _id_E6AECBD7458C0F49 = getdvarint("dvar_A828E8AC5187F4D4", 0);

    if(_id_E6AECBD7458C0F49 == 0) {
      _id_7DAD96E1E2E75B1D = randomint(100) + 1;

      if(_id_7DAD96E1E2E75B1D > 90)
        _id_E6AECBD7458C0F49 = 4;
      else if(_id_7DAD96E1E2E75B1D > 65)
        _id_E6AECBD7458C0F49 = 2;
      else if(_id_7DAD96E1E2E75B1D > 40)
        _id_E6AECBD7458C0F49 = 3;
      else
        _id_E6AECBD7458C0F49 = 1;
    }
  }

  _id_3624CC967D35DC5F = getDvar("dvar_49BBF2DA466DCC1B", "classtable:classtable_br_gulag");
  return _id_3624CC967D35DC5F + _id_E6AECBD7458C0F49;
}

creategulagarenaloadout(_id_089688461C79EF11) {
  loadout["loadoutArchetype"] = "archetype_assault";
  loadout["loadoutPrimary"] = scripts\mp\class::_id_0C7A0B640C398497(level.gulagloadouttable, _id_089688461C79EF11).primaryweapon.weapon;
  loadout["loadoutPrimaryAttachment"] = scripts\mp\class::_id_0C7A0B640C398497(level.gulagloadouttable, _id_089688461C79EF11).primaryweapon._id_59F68715C04CE28F;
  loadout["loadoutPrimaryAttachment2"] = scripts\mp\class::_id_0C7A0B640C398497(level.gulagloadouttable, _id_089688461C79EF11).primaryweapon._id_59F68815C04CE4C2;
  loadout["loadoutPrimaryAttachment3"] = scripts\mp\class::_id_0C7A0B640C398497(level.gulagloadouttable, _id_089688461C79EF11).primaryweapon._id_59F68915C04CE6F5;
  loadout["loadoutPrimaryAttachment4"] = scripts\mp\class::_id_0C7A0B640C398497(level.gulagloadouttable, _id_089688461C79EF11).primaryweapon._id_59F68215C04CD790;
  loadout["loadoutPrimaryAttachment5"] = scripts\mp\class::_id_0C7A0B640C398497(level.gulagloadouttable, _id_089688461C79EF11).primaryweapon._id_59F68315C04CD9C3;
  loadout["loadoutPrimaryCamo"] = scripts\mp\class::_id_0C7A0B640C398497(level.gulagloadouttable, _id_089688461C79EF11).primaryweapon.camo;
  loadout["loadoutPrimaryReticle"] = scripts\mp\class::_id_0C7A0B640C398497(level.gulagloadouttable, _id_089688461C79EF11).primaryweapon.reticle;
  loadout["loadoutSecondary"] = scripts\mp\class::_id_0C7A0B640C398497(level.gulagloadouttable, _id_089688461C79EF11).secondaryweapon.weapon;
  loadout["loadoutSecondaryAttachment"] = scripts\mp\class::_id_0C7A0B640C398497(level.gulagloadouttable, _id_089688461C79EF11).secondaryweapon._id_59F68715C04CE28F;
  loadout["loadoutSecondaryAttachment2"] = scripts\mp\class::_id_0C7A0B640C398497(level.gulagloadouttable, _id_089688461C79EF11).secondaryweapon._id_59F68815C04CE4C2;
  loadout["loadoutSecondaryAttachment3"] = scripts\mp\class::_id_0C7A0B640C398497(level.gulagloadouttable, _id_089688461C79EF11).secondaryweapon._id_59F68915C04CE6F5;
  loadout["loadoutSecondaryAttachment4"] = scripts\mp\class::_id_0C7A0B640C398497(level.gulagloadouttable, _id_089688461C79EF11).secondaryweapon._id_59F68215C04CD790;
  loadout["loadoutSecondaryAttachment5"] = scripts\mp\class::_id_0C7A0B640C398497(level.gulagloadouttable, _id_089688461C79EF11).secondaryweapon._id_59F68315C04CD9C3;
  loadout["loadoutSecondaryCamo"] = scripts\mp\class::_id_0C7A0B640C398497(level.gulagloadouttable, _id_089688461C79EF11).secondaryweapon.camo;
  loadout["loadoutSecondaryReticle"] = scripts\mp\class::_id_0C7A0B640C398497(level.gulagloadouttable, _id_089688461C79EF11).secondaryweapon.reticle;
  loadout["loadoutMeleeSlot"] = "none";
  loadout["loadoutEquipmentPrimary"] = scripts\mp\class::_id_0C7A0B640C398497(level.gulagloadouttable, _id_089688461C79EF11).equipment.primary;
  loadout["loadoutEquipmentSecondary"] = scripts\mp\class::_id_0C7A0B640C398497(level.gulagloadouttable, _id_089688461C79EF11).equipment._id_D7B9856A19F9B6B5;
  loadout["loadoutStreakType"] = "assault";
  loadout["loadoutKillstreak1"] = "none";
  loadout["loadoutKillstreak2"] = "none";
  loadout["loadoutKillstreak3"] = "none";
  loadout["loadoutSuper"] = "super_br_extract";
  loadout["loadoutPerks"] = [scripts\mp\class::_id_0C7A0B640C398497(level.gulagloadouttable, _id_089688461C79EF11).perks._id_16680ABD1742C050, scripts\mp\class::_id_0C7A0B640C398497(level.gulagloadouttable, _id_089688461C79EF11).perks._id_16680DBD1742C6E9, scripts\mp\class::_id_0C7A0B640C398497(level.gulagloadouttable, _id_089688461C79EF11).perks._id_16680CBD1742C4B6, scripts\mp\class::_id_0C7A0B640C398497(level.gulagloadouttable, _id_089688461C79EF11)._id_50D0559DCBA571E2._id_16680ABD1742C050, scripts\mp\class::_id_0C7A0B640C398497(level.gulagloadouttable, _id_089688461C79EF11)._id_50D0559DCBA571E2._id_16680DBD1742C6E9, scripts\mp\class::_id_0C7A0B640C398497(level.gulagloadouttable, _id_089688461C79EF11)._id_50D0559DCBA571E2._id_16680CBD1742C4B6];
  loadout["loadoutGesture"] = "playerData";
  loadout["tableColumn"] = _id_089688461C79EF11;
  return loadout;
}

playergivearenaloadout(arena, loadoutindex) {
  if(getdvarint("dvar_F97D261E2F377AD9", 1) == 0) {
    return;
  }
  if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("getArenaLoadout"))
    self.pers["gamemodeLoadout"] = _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("getArenaLoadout", arena);
  else {
    self.pers["gamemodeLoadout"] = level.gulagloadouts[loadoutindex];
    checkforarenaloadoutoverride(loadoutindex);
  }

  self.class = "gamemode";
  self.prevweaponobj = undefined;
  struct = scripts\mp\class::loadout_getclassstruct();
  struct = scripts\mp\class::loadout_updateclass(struct, "gamemode");
  scripts\mp\class::preloadandqueueclassstruct(struct, 1, 1);
  scripts\mp\class::giveloadout(self.team, "gamemode", 0, 0);
  self givestartammo(struct.loadoutprimaryobject);

  if(isDefined(struct.loadoutsecondaryobject))
    self givestartammo(struct.loadoutsecondaryobject);

  if(!_id_5BC60484D17FA95C::_id_CFE304859F30E747("getArenaLoadout")) {
    self.gulagloadoutindex = level.gulagloadouts[loadoutindex]["tableColumn"];
    playersetomnvargulag(arena, "loadoutRow", self.gulagloadoutindex);
  }
}

checkforarenaloadoutoverride(loadoutindex) {
  if(getdvarint("dvar_AD67CF67992FE5F2", 0)) {
    switch (loadoutindex) {
      case 0:
        primary = "iw8_pi_decho";
        break;
      case 1:
        primary = "iw8_pi_cpapa";
        break;
      case 2:
        primary = "iw8_pi_decho";
        break;
      case 3:
        primary = "iw8_pi_cpapa";
        break;
      case 4:
        primary = "iw8_pi_decho";
        break;
      case 5:
        primary = "iw8_pi_cpapa";
        break;
      case 6:
        primary = "iw8_pi_decho";
        break;
      case 7:
        primary = "iw8_pi_cpapa";
        break;
      case 8:
        primary = "iw8_pi_decho";
        break;
      case 9:
      default:
        primary = "iw8_pi_cpapa";
    }

    self.pers["gamemodeLoadout"]["loadoutPrimary"] = primary;
    self.pers["gamemodeLoadout"]["loadoutPrimaryAttachment"] = "none";
    self.pers["gamemodeLoadout"]["loadoutPrimaryAttachment2"] = "none";
    self.pers["gamemodeLoadout"]["loadoutPrimaryAttachment3"] = "none";
    self.pers["gamemodeLoadout"]["loadoutPrimaryAttachment4"] = "none";
    self.pers["gamemodeLoadout"]["loadoutPrimaryAttachment5"] = "none";
    self.pers["gamemodeLoadout"]["loadoutSecondary"] = "none";
    self.pers["gamemodeLoadout"]["loadoutSecondaryAttachment"] = "none";
    self.pers["gamemodeLoadout"]["loadoutSecondaryAttachment2"] = "none";
    self.pers["gamemodeLoadout"]["loadoutSecondaryAttachment3"] = "none";
    self.pers["gamemodeLoadout"]["loadoutSecondaryAttachment4"] = "none";
    self.pers["gamemodeLoadout"]["loadoutSecondaryAttachment5"] = "none";
    self.pers["gamemodeLoadout"]["loadoutPerks"] = ["specialty_null"];
  }
}

getloadoutindex() {
  if(getdvarint("dvar_F97D261E2F377AD9", 1) == 0) {
    return;
  }
  _id_7940DCDE72827AF7 = getdvarint("dvar_4F38B76441D4B900", -1);

  if(_id_7940DCDE72827AF7 > -1 && _id_7940DCDE72827AF7 < level.gulagloadouts.size)
    return _id_7940DCDE72827AF7;

  if(getDvar("dvar_6EF30F04F9851A88") != "") {
    if(!isDefined(level.gulagloadoutindex) || level.gulagloadoutindex >= level.gulagloadouts.size)
      level.gulagloadoutindex = 0;

    index = level.gulagloadoutindex;
    level.gulagloadoutindex = level.gulagloadoutindex + 1;
  } else
    index = randomint(level.gulagloadouts.size);

  return index;
}

_id_AA0549E91DAD2FB9(arena) {
  arena endon("fight_over");
  arena endon("matchEnded");
  level endon("game_ended");
  self endon("death_or_disconnect");
  _id_9587B4BB609D006E = level.gulag.timelimit;
  level.gulag.timelimit = 180;
  iprintln("Loadout verification starting in 3 seconds.");
  wait 3.0;
  iprintln("Verification start!");

  for(_id_465DF4A45CDB81BF = 0; _id_465DF4A45CDB81BF < level.gulagloadouts.size; _id_465DF4A45CDB81BF++) {
    iprintln("Loadout: " + _id_465DF4A45CDB81BF);
    playergivearenaloadout(arena, _id_465DF4A45CDB81BF);
    wait 5.0;
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self.secondaryweapon);
    wait 4.0;
  }

  playergivearenaloadout(arena, 0);
  level.gulag.timelimit = _id_9587B4BB609D006E;
  iprintln("Verification done!");
}

setupdomendflag(arena) {
  if(_id_46FDF7B12C5F5620::_id_7EFFA8A355DDC886()) {
    _id_37E3A1EAA43EA82C = getgroundposition(arena.center + (0, 530, 0), 1);

    if(isDefined(arena._id_1DF1ACEE38DCCA72))
      _id_37E3A1EAA43EA82C = getgroundposition(arena._id_1DF1ACEE38DCCA72, 1);

    _id_D0EAD7E588A015C5 = getdvarint("dvar_177D32D81BD6BC15", 450);
    _id_01230EA36A300368 = _id_37E3A1EAA43EA82C;
  } else if(_id_03AA8E63A56E3416::_id_6E3541FD8FAB45BC()) {
    _id_37E3A1EAA43EA82C = getgroundposition(arena.center, 1);

    if(isDefined(arena._id_1DF1ACEE38DCCA72))
      _id_37E3A1EAA43EA82C = getgroundposition(arena._id_1DF1ACEE38DCCA72, 1);

    _id_D0EAD7E588A015C5 = getdvarint("dvar_177D32D81BD6BC15", 100);
    _id_01230EA36A300368 = _id_37E3A1EAA43EA82C;
  } else {
    _id_D0EAD7E588A015C5 = getdvarint("dvar_177D32D81BD6BC15", 50);
    _id_01230EA36A300368 = getgroundposition(arena.center, 1);
  }

  arena.dom = spawnStruct();
  arena.dom.trigger = spawn("trigger_radius", _id_01230EA36A300368, 0, int(_id_D0EAD7E588A015C5), int(level.br_domheight));
  arena.dom.trigger.objectivekey = "_a";
  arenaflag = _id_6663215F917210AE::setupobjective(arena.dom.trigger, "neutral", undefined, 1);
  arenaflag.onuse = ::arenaflag_onuse;
  arenaflag.onbeginuse = ::arenaflag_onusebegin;
  arenaflag.onenduse = ::arenaflag_onuseend;
  arenaflag.onuseupdate = ::arenaflag_onuseupdate;
  arenaflag.oncontested = ::arenaflag_oncontested;
  arenaflag.isarena = 1;
  arenaflag scripts\mp\gameobjects::pinobjiconontriggertouch();
  arenaflag.id = "domFlag";

  if(_id_46FDF7B12C5F5620::_id_7EFFA8A355DDC886())
    arenaflag scripts\mp\gameobjects::setcapturebehavior("all_teams_dom_together");
  else
    arenaflag scripts\mp\gameobjects::setcapturebehavior("persistent");

  arenaflag.scriptable delete();
  arenaflag.ignorestomp = 1;
  arenaflag scripts\mp\gameobjects::requestid(0, 1, undefined, 0, 0);
  arenaflag.visibilitymanuallycontrolled = 1;
  arenaflag arenaflag_setenabled(0);
  arenaflag arenaflag_setvisible(arena, 0);
  arenaflag.arena = arena;
  arena.dom.arenaflag = arenaflag;
}

domgulagsounds(arena) {
  wait 1.0;

  if(isDefined(arena) && isDefined(arena.dom) && isDefined(arena.dom.arenaflag) && isDefined(arena.dom.arenaflag.flagmodel)) {
    if(isstring("") && 0 && soundexists(""))
      arena.dom.arenaflag.flagmodel playLoopSound("");
  }
}

arenaflag_setenabled(enable) {
  if(enable) {
    scripts\mp\gameobjects::allowuse("any");
    self.trigger scripts\engine\utility::trigger_on();
  } else {
    scripts\mp\gameobjects::allowuse("none");
    self.trigger scripts\engine\utility::trigger_off();
    scripts\mp\gameobjects::resetcaptureprogress();
  }
}

arenaflag_setvisible(arena, enable, _id_9CB4BDC2122D46EB, _id_DDF49B0F7BD17A0C) {
  self notify("arenaFlag_setVisible");

  if(enable) {
    icon = "waypoint_captureneutral";

    if(istrue(_id_9CB4BDC2122D46EB))
      icon = level.iconovertime;

    thread arenaflag_objectiveshow(arena);
    thread scripts\mp\gameobjects::setobjectivestatusicons(icon);
    thread scripts\mp\gameobjects::setownerteam("neutral");
    thread _id_6663215F917210AE::updateflagstate("idle", 0, "none");
    self.flagmodel show();
    thread arenaflag_showflagoutline(arena, 1);

    if(!istrue(_id_9CB4BDC2122D46EB)) {
      setovertimeomnvarenabled(arena, 1);
      return;
    }
  } else
    thread arenaflag_setvisibledisableinternal(arena, _id_9CB4BDC2122D46EB, _id_DDF49B0F7BD17A0C);
}

arenaflag_setvisibledisableinternal(arena, _id_9CB4BDC2122D46EB, _id_DDF49B0F7BD17A0C) {
  self endon("arenaFlag_setVisible");

  if(!istrue(_id_DDF49B0F7BD17A0C)) {
    objective_setpinned(self.objidnum, 0);
    wait 1;
  }

  _id_127C772F981AEFC1(arena);
  thread arenaflag_showflagoutline(arena, 0);
  thread arenaflag_objectivehide(_id_DDF49B0F7BD17A0C);
  thread _id_6663215F917210AE::updateflagstate("off", 0, "none");
  self.flagmodel hide(1);

  if(!istrue(_id_9CB4BDC2122D46EB)) {
    setovertimeomnvarenabled(arena, 0);
    setovertimeomnvarprogress(arena, 0);
  }
}

arenaflag_setvisibleplayer(enable, player) {
  player endon("death_or_disconnect");

  if(enable) {
    player setclientomnvar("ui_overtime_timer_show", 1);
    objective_addclienttomask(self.objidnum, player);
  } else {
    objective_unpinforclient(self.objidnum, player);
    wait 1;
    player setclientomnvar("ui_overtime_timer_show", 0);
    objective_removeclientfrommask(self.objidnum, player);
  }

  thread arenaflag_showflagoutlineplayer(enable, player);
}

arenaflag_previewflag(arena, time) {
  thread arenaflag_setvisible(arena, 1, 1);
  wait(time);
  thread arenaflag_setvisible(arena, 0, 1, 1);
}

arenaflag_objectiveshow(arena) {
  objective_removeallfrommask(self.objidnum);

  foreach(player in arena.jailedplayers)
  objective_addclienttomask(self.objidnum, player);

  foreach(player in arena.arenaplayers)
  objective_addclienttomask(self.objidnum, player);

  objective_showtoplayersinmask(self.objidnum);
}

arenaflag_objectivehide(_id_DDF49B0F7BD17A0C) {
  objective_setshowprogress(self.objidnum, 0);
  objective_removeallfrommask(self.objidnum);
  objective_showtoplayersinmask(self.objidnum);
}

arenaflag_showflagoutline(arena, enable) {
  if(enable) {
    if(arena.jailedplayers.size > 0)
      self.flagmodel hudoutlineenableforclients(arena.jailedplayers, "outline_nodepth_orange");

    if(arena.arenaplayers.size > 0) {
      self.flagmodel hudoutlineenableforclients(arena.arenaplayers, "outline_nodepth_orange");
      self.flagmodel _meth_5226227BCE83EBE9(1, "team_hundred_fifty_one");
    }
  } else {
    if(arena.jailedplayers.size > 0)
      self.flagmodel hudoutlinedisableforclients(arena.jailedplayers);

    if(arena.arenaplayers.size > 0)
      self.flagmodel hudoutlinedisableforclients(arena.arenaplayers);
  }
}

arenaflag_showflagoutlineplayer(enable, player) {
  if(enable)
    self.flagmodel hudoutlineenableforclient(player, "outline_nodepth_orange");
  else
    self.flagmodel hudoutlinedisableforclient(player);
}

arenaflag_onusebegin(player) {
  if(_id_46FDF7B12C5F5620::_id_7EFFA8A355DDC886())
    _id_EC49C5FCBD1DFB1A = getdvarint("dvar_0D74AAF9013C8609", 12.0);
  else if(_id_03AA8E63A56E3416::_id_6E3541FD8FAB45BC())
    _id_EC49C5FCBD1DFB1A = getdvarint("dvar_0D74AAF9013C8609", 4.0);
  else
    _id_EC49C5FCBD1DFB1A = getdvarint("dvar_0D74AAF9013C8609", 3.0);

  player.iscapturing = 1;
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral")
    player setclientomnvar("ui_objective_pinned_text_param", 1);

  self.neutralizing = istrue(level.flagneutralization) && ownerteam != "neutral";

  if(!istrue(self.neutralized))
    self.didstatusnotify = 0;

  usetime = _id_EC49C5FCBD1DFB1A;
  scripts\mp\gameobjects::setusetime(usetime);

  if(istrue(level.capturedecay))
    thread scripts\mp\gameobjects::useobjectdecay(player.team);

  if(usetime > 0) {
    foreach(_id_31210CE93279D451 in self.arena.arenaplayers) {
      if(_id_31210CE93279D451 != player && _id_31210CE93279D451.team != player.team) {
        self.prevownerteam = _id_31210CE93279D451.team;
        break;
      }
    }

    _id_6663215F917210AE::updateflagcapturestate(player.team);
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_taking", "waypoint_losing");
  }
}

arenaflag_onuseupdate(team, progress, _id_301D62DA1A0738F1, _id_4B22E50E504339FE) {
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(progress > 0.05 && _id_301D62DA1A0738F1 && !self.didstatusnotify)
    self.didstatusnotify = 1;
}

arenaflag_onuseend(team, player, success) {
  if(_id_46FDF7B12C5F5620::_id_7EFFA8A355DDC886() && isDefined(player) && success)
    player thread scripts\mp\hud_message::showsplash("br_ai_gulag_overtime_end");

  self.didstatusnotify = 0;

  if(success)
    scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);

  if(isPlayer(player)) {
    player.iscapturing = 0;
    player setclientomnvar("ui_objective_pinned_text_param", 0);
    player.ui_dom_securing = undefined;
  }

  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_captureneutral");
    thread _id_6663215F917210AE::updateflagstate("idle", 0);
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_capture");
    thread _id_6663215F917210AE::updateflagstate(ownerteam, 0);
  }

  if(!success)
    self.neutralized = 0;
}

arenaflag_setcaptured(team, _id_22282E7D48CA3400) {
  scripts\mp\gameobjects::setownerteam(team);
  self notify("capture", _id_22282E7D48CA3400);
  self notify("assault", _id_22282E7D48CA3400);
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defending", "waypoint_capture");
  self.neutralized = 0;
  thread _id_6663215F917210AE::updateflagstate(team, 0, team);

  if(self.touchlist[team].size == 0 && isDefined(self.oldtouchlist))
    self.touchlist = self.oldtouchlist;

  foreach(_id_31210CE93279D451 in self.arena.arenaplayers) {
    if(_id_31210CE93279D451 != _id_22282E7D48CA3400 && _id_31210CE93279D451.team != team && isDefined(self.assisttouchlist[_id_31210CE93279D451.team])) {
      self.assisttouchlist[_id_31210CE93279D451.team] = [];
      break;
    }
  }
}

arenaflag_onuse(_id_22282E7D48CA3400) {
  team = _id_22282E7D48CA3400.team;
  self.capturetime = gettime();
  self.neutralized = 0;
  arenaflag_setcaptured(team, _id_22282E7D48CA3400);

  if(!self.neutralized && !_id_46FDF7B12C5F5620::_id_7EFFA8A355DDC886()) {
    foreach(player in self.arena.arenaplayers) {
      if(isalive(player) && player.team != team) {
        if(_id_5BC60484D17FA95C::_id_1980065CE4DC067B()) {
          player thread gulagplayerlost(self.arena, "br_twotwo_gulag_lost_flag", 1);
          continue;
        }

        player thread gulagplayerlost(self.arena);
      }
    }

    thread handleendarena(self.arena);

    if(_id_5BC60484D17FA95C::_id_1980065CE4DC067B())
      _id_22282E7D48CA3400 _id_03AA8E63A56E3416::_id_0DC0A56E258889CB(self.arena, "br_twotwo_gulag_win_flag");

    self.firstcapture = 0;
  }
}

arenaflag_oncontested() {
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_contested");
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  thread _id_6663215F917210AE::updateflagstate("contested", 0);
}

getarenaomnvarbitpackinginfo(_id_AC85B79DFC4E45C6, value) {
  _id_64571E3AECCD1A07 = 0;
  _id_8534515023AFC188 = 0;
  _id_8E90FA6D5789AD63 = "";

  switch (_id_AC85B79DFC4E45C6) {
    case "playerArena0":
      [_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_8E90FA6D5789AD63] = [0, 8, "ui_br_gulag_players_1"];
      value = value + 1;
      break;
    case "playerArena1":
      [_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_8E90FA6D5789AD63] = [8, 8, "ui_br_gulag_players_1"];
      value = value + 1;
      break;
    case "playerJail0":
      [_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_8E90FA6D5789AD63] = [16, 8, "ui_br_gulag_players_1"];
      value = value + 1;
      break;
    case "playerJail1":
      [_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_8E90FA6D5789AD63] = [24, 8, "ui_br_gulag_players_1"];
      value = value + 1;
      break;
    case "loadoutRow":
      [_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_8E90FA6D5789AD63] = [0, 8, "ui_br_gulag_data"];
      value = value + 1;
      break;
    case "playerHealth0":
      [_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_8E90FA6D5789AD63] = [8, 8, "ui_br_gulag_data"];
      break;
    case "playerHealth1":
      [_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_8E90FA6D5789AD63] = [16, 8, "ui_br_gulag_data"];
      break;
    default:
      if(!_id_5BC60484D17FA95C::_id_1980065CE4DC067B()) {}

      break;
  }

  return [_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_8E90FA6D5789AD63, value];
}

packarenaomnvardata(arena, _id_8E90FA6D5789AD63, value, _id_64571E3AECCD1A07, _id_8534515023AFC188) {
  mask = int(pow(2, _id_8534515023AFC188)) - 1;
  _id_A463992091F1D483 = (value &mask) << _id_64571E3AECCD1A07;
  _id_F8F977081D3DA8B4 = ~(mask << _id_64571E3AECCD1A07);
  _id_EE27F3F198276535 = arena.omnvardata[_id_8E90FA6D5789AD63];
  _id_ED711AEAF5E8CB76 = _id_EE27F3F198276535 &_id_F8F977081D3DA8B4;
  _id_82A90E56E416FA55 = _id_ED711AEAF5E8CB76 + _id_A463992091F1D483;
  arena.omnvardata[_id_8E90FA6D5789AD63] = _id_82A90E56E416FA55;
}

setarenaomnvar(arena, _id_AC85B79DFC4E45C6, value) {
  [_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_8E90FA6D5789AD63, value] = getarenaomnvarbitpackinginfo(_id_AC85B79DFC4E45C6, value);

  if(_id_8E90FA6D5789AD63 == "") {
    return;
  }
  packarenaomnvardata(arena, _id_8E90FA6D5789AD63, value, _id_64571E3AECCD1A07, _id_8534515023AFC188);
}

setarenaomnvarplayertype(arena, _id_AC85B79DFC4E45C6, player) {
  entnum = -1;

  if(isDefined(player))
    entnum = player getentitynumber();

  setarenaomnvar(arena, _id_AC85B79DFC4E45C6, entnum);
}

setarenaomnvarhealthtype(arena, _id_AC85B79DFC4E45C6, player) {
  health = 0;

  if(isDefined(player))
    health = player.health;

  setarenaomnvar(arena, _id_AC85B79DFC4E45C6, health);
}

updatearenaomnvarplayers(arena) {
  arena.omnvardata["ui_br_gulag_players_1"] = 0;

  if(!_id_5BC60484D17FA95C::_id_1980065CE4DC067B()) {}

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.gulag.maxplayers; _id_AC0E594AC96AA3A8++) {
    player = arena.arenaplayers[_id_AC0E594AC96AA3A8];
    setarenaomnvarplayertype(arena, "playerArena" + _id_AC0E594AC96AA3A8, player);
  }

  _id_607899D4420FE1A5 = arena.matches[0];

  if(!isDefined(_id_607899D4420FE1A5))
    _id_607899D4420FE1A5 = [];

  setarenaomnvarplayertype(arena, "playerJail0", _id_607899D4420FE1A5[0]);
  setarenaomnvarplayertype(arena, "playerJail1", _id_607899D4420FE1A5[1]);
  _id_087B2BE9FEF844DE = scripts\engine\utility::array_combine(arena.jailedplayers, arena.arenaplayers);

  foreach(player in _id_087B2BE9FEF844DE) {
    if(!isDefined(player)) {
      continue;
    }
    player setclientomnvar("ui_br_gulag_players_1", arena.omnvardata["ui_br_gulag_players_1"]);
    _id_A55AB0DDAB9125FF = scripts\engine\utility::ter_op(isDefined(player.gulagposition), player.gulagposition, 0);
    _id_793C4E46C0425BD2 = !isplayermatched(arena, player) && _id_A55AB0DDAB9125FF != 0;

    if(_id_793C4E46C0425BD2)
      player setclientomnvar("ui_br_gulag_match_state", 0);

    _id_82A90E56E416FA55 = _id_793C4E46C0425BD2 | _id_A55AB0DDAB9125FF << 1;
    player setclientomnvar("ui_br_gulag_queue_position", _id_82A90E56E416FA55);
  }
}

playersetgulagdataomnvar(arena) {
  self setclientomnvar("ui_br_gulag_data", arena.omnvardata["ui_br_gulag_data"]);
}

updatearenaomnvardata(arena) {
  resetarenaomnvardata(arena);

  if(!_id_5BC60484D17FA95C::_id_1980065CE4DC067B()) {}

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.gulag.maxplayers; _id_AC0E594AC96AA3A8++) {
    player = arena.arenaplayers[_id_AC0E594AC96AA3A8];

    if(isDefined(player))
      setarenaomnvarhealthtype(arena, "playerHealth" + _id_AC0E594AC96AA3A8, player);
  }

  foreach(player in arena.jailedplayers) {
    if(!isDefined(player)) {
      continue;
    }
    player playersetgulagdataomnvar(arena);
  }

  foreach(player in arena.arenaplayers) {
    if(!isDefined(player)) {
      continue;
    }
    player playersetarenaomnvarwithloadout(arena);
  }
}

resetarenaomnvardata(arena) {
  arena.omnvardata["ui_br_gulag_data"] = 0;
}

playersetarenaomnvarwithloadout(arena) {
  if(!isDefined(self.gulagloadoutindex))
    self setclientomnvar("ui_br_gulag_data", arena.omnvardata["ui_br_gulag_data"]);
  else
    playersetomnvargulag(arena, "loadoutRow", self.gulagloadoutindex);
}

playersetomnvargulag(arena, _id_AC85B79DFC4E45C6, value) {
  [_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_8E90FA6D5789AD63, value] = getarenaomnvarbitpackinginfo(_id_AC85B79DFC4E45C6, value);

  if(_id_8E90FA6D5789AD63 == "") {
    return;
  }
  playerpackdataintogulagomnvar(arena, _id_8E90FA6D5789AD63, value, _id_64571E3AECCD1A07, _id_8534515023AFC188);
}

playerpackdataintogulagomnvar(arena, _id_8E90FA6D5789AD63, value, _id_64571E3AECCD1A07, _id_8534515023AFC188) {
  mask = int(pow(2, _id_8534515023AFC188)) - 1;
  _id_A463992091F1D483 = (value &mask) << _id_64571E3AECCD1A07;
  _id_F8F977081D3DA8B4 = ~(mask << _id_64571E3AECCD1A07);
  _id_EE27F3F198276535 = arena.omnvardata[_id_8E90FA6D5789AD63];
  _id_ED711AEAF5E8CB76 = _id_EE27F3F198276535 &_id_F8F977081D3DA8B4;
  _id_82A90E56E416FA55 = _id_ED711AEAF5E8CB76 + _id_A463992091F1D483;
  self setclientomnvar(_id_8E90FA6D5789AD63, _id_82A90E56E416FA55);
}

updateplayeromnvarsallmatches(arena) {
  updatearenaomnvarplayers(arena);
  updatearenaomnvardata(arena);
}

playercleargulagomnvars(arena) {
  _id_1283CE7783C79A30 = getarraykeys(arena.omnvardata);

  foreach(_id_8E90FA6D5789AD63 in _id_1283CE7783C79A30)
  self setclientomnvar(_id_8E90FA6D5789AD63, 0);

  self setclientomnvar("ui_overtime_timer", 0);
  self setclientomnvar("ui_overtime_timer_show", 0);
  self setclientomnvar("ui_match_start_countdown", 0);
  self setclientomnvar("ui_match_in_progress", 1);
}

setovertimeomnvarprogress(arena, progress) {
  foreach(player in arena.arenaplayers) {
    if(!isDefined(player)) {
      continue;
    }
    player setclientomnvar("ui_overtime_timer", progress);
  }

  foreach(player in arena.jailedplayers) {
    if(!isDefined(player)) {
      continue;
    }
    player setclientomnvar("ui_overtime_timer", progress);
  }
}

setovertimeomnvarenabled(arena, enabled) {
  if(isDefined(arena.arenaplayers)) {
    foreach(player in arena.arenaplayers) {
      if(!isDefined(player)) {
        continue;
      }
      player setclientomnvar("ui_overtime_timer_show", enabled);
    }
  }

  if(isDefined(arena.jailedplayers)) {
    foreach(player in arena.jailedplayers) {
      if(!isDefined(player)) {
        continue;
      }
      player setclientomnvar("ui_overtime_timer_show", enabled);
    }
  }
}

playerhealthomnvarwatcher(arena) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("gulag_end");

  if(!_id_5BC60484D17FA95C::_id_1980065CE4DC067B()) {}

  _id_AC85B79DFC4E45C6 = "playerHealth0";

  if(arena.arenaplayers[0] != self)
    _id_AC85B79DFC4E45C6 = "playerHealth1";

  for(;;) {
    updatearenaomnvardata(arena);

    if(self.health <= 0) {
      return;
    }
    scripts\engine\utility::waittill_any_7("damage", "force_regeneration", "removeAdrenaline", "healed", "naturalHealthRegen", "vampirism", "spawned_player");
  }
}

playerpreloadintrocinematic() {
  if(level.gulag.introcinematic && !isbot(self)) {
    if(level._id_43307855F189EB31.name == "gulag_twotwo") {
      if(scripts\cp_mp\utility\game_utility::_id_5E0E3A24DBB1FAE1())
        self preloadcinematicforplayer("gulag_enter_delta");
      else
        self preloadcinematicforplayer("gulag_enter");
    } else if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587() && level.mapname == "mp_mgl_escape4")
      self preloadcinematicforplayer("mp_rebirth_gulag_intro");
    else
      self preloadcinematicforplayer("mp_donetsk_gulag_intro");
  }
}

playerplayintrocinematic() {
  if(level.gulag.introcinematic && !isbot(self)) {
    self setclientomnvar("ui_br_bink_overlay_state", 1);
    _id_3437F7BDB4F9DE0F = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_gulag_intro");
    self setplayermusicstate(_id_3437F7BDB4F9DE0F);

    if(_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF())
      self setsoundsubmix("iw8_br_gulag_tutorial", 0.5);
    else
      self setsoundsubmix("solo_cin_igc_music", 0.5);

    self _meth_786FEE88B4749DFF(0);
    self.playinggulagbink = 1;
  } else
    gulagloadingtext();
}

_id_CA008CC22B07BA4E() {
  if(level.gulag._id_3FDEDDA393E951F9 && !isbot(self)) {
    if(level._id_43307855F189EB31.name == "gulag_twotwo") {
      self setclientomnvar("ui_br_bink_overlay_state", 10);
      _id_6D54591FB940E8DE = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_gulag_outro");
      self setplayermusicstate(_id_6D54591FB940E8DE);
      self setsoundsubmix("solo_cin_igc_music", 0.5);
      self playcinematicforplayer("gulag_exit");
      playerwaittillcinematiccomplete(gettime());
    }
  }
}

playershowskippromptcinematic() {
  self setclientomnvar("ui_br_bink_overlay_state", 2);
}

playerwaittillcinematiccomplete(starttime) {
  if(level.gulag.introcinematic && !isbot(self) && !self isplayerheadless()) {
    scripts\cp_mp\utility\player_utility::_freezecontrols(1, 0, "gulagCinematic");
    _id_FDEF1592FFDA3A4A = _playerwaittillcinematiccompleteinternal(starttime);

    if(!isDefined(_id_FDEF1592FFDA3A4A))
      _id_FDEF1592FFDA3A4A = 1;

    scripts\cp_mp\utility\player_utility::_freezecontrols(0, 0, "gulagCinematic");
    self setclientomnvar("ui_br_bink_overlay_state", 5);
    self stopcinematicforplayer(_id_FDEF1592FFDA3A4A);
    self.playinggulagbink = undefined;
    _id_5BAB271917698DC4::_id_E68E4BB4F65F5FE4();
  }
}

_playerwaittillcinematiccompleteinternal(starttime) {
  self endon("bink_complete");

  while(gettime() - starttime < 34000) {
    if(self crouchbuttonPressed() || self useButtonPressed() || self jumpbuttonPressed())
      return 1;

    waitframe();
  }

  return 0;
}

playercinematiccompletecallback(_id_7148C1A6F25491F8, val) {
  if(_id_7148C1A6F25491F8 == "bink_complete")
    self notify("bink_complete");
}

setupcellspawn(arena, _id_8FF292386A0993F5) {
  if(!level.gulag.usecellspawns) {
    return;
  }
  if(!isDefined(_id_8FF292386A0993F5.target))
    level.gulag.usecellspawns = 0;
  else {
    doors = getEntArray(_id_8FF292386A0993F5.target, "targetname");

    if(doors.size > 1) {
      level.gulag.usecellspawns = 0;
      return;
    }

    _id_8FF292386A0993F5.door = getEnt(_id_8FF292386A0993F5.target, "targetname");

    if(isDefined(_id_8FF292386A0993F5.door)) {
      _id_8FF292386A0993F5.door.closed = 1;
      clip = getEnt(_id_8FF292386A0993F5.door.target, "targetname");
      clip delete();
      _id_5DB7E7538D068035 = anglesToForward(_id_8FF292386A0993F5.door.angles);
      _id_8FF292386A0993F5.door.closepos = _id_8FF292386A0993F5.door.origin;
      _id_8FF292386A0993F5.door.openpos = _id_8FF292386A0993F5.door.origin + _id_5DB7E7538D068035 * 60;
    }
  }
}

_id_8CD7D5A73921BD93(waittime) {
  player = self;
  player endon("disconnect");
  level endon("game_ended");

  if(getdvarint("dvar_9AE23FA804CBFDD7", 0) == 0) {
    return;
  }
  if(!isDefined(waittime))
    waittime = 0;

  wait(waittime);

  if(isDefined(player)) {
    if(isDefined(player.name))
      _id_81A6DCF8641471F7 = player.name;
    else
      _id_81A6DCF8641471F7 = "";

    if(isDefined(player.gulagarena))
      _id_54B9737D53438793 = player.gulagarena;
    else
      _id_54B9737D53438793 = "";

    if(isDefined(player.gulag))
      _id_39B32CC7F5D22BCC = player.gulag;
    else
      _id_39B32CC7F5D22BCC = "";

    logstring("[gulag_getPlayerStateWait] Player " + _id_81A6DCF8641471F7 + " has .gulagArena : " + _id_54B9737D53438793 + " and .gulag : " + _id_39B32CC7F5D22BCC);
  }
}

usecellspawns(arena) {
  return level.gulag.usecellspawns && arena.cellspawns.size > 0;
}

_id_2E096D17B6286E29(player, _id_0228A5DE8E2CD330, _id_90E74E77D08D5AFC) {}
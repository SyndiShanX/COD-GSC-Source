/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\gestures.gsc
***********************************************/

init() {
  level.gestureinfo = [];
  level.gestureinfobyindex = [];
  _id_3B64EB40368C1450::_id_7372010B17478CDC("gesture", 1, 0, "$self", ::_id_9E06FA9C92578F0D, "$value");
  _id_CB89110314447B2F = 0;

  for(;;) {
    ref = tablelookupbyrow("mp/gesturetable.csv", _id_CB89110314447B2F, 0);

    if(!isDefined(ref) || ref == "") {
      break;
    }

    data = tablelookupbyrow("mp/gesturetable.csv", _id_CB89110314447B2F, 1);

    if(!isDefined(data) || data == "") {
      break;
    }

    index = int(tablelookupbyrow("mp/gesturetable.csv", _id_CB89110314447B2F, 8));

    if(isDefined(index))
      level.gestureinfobyindex[index] = data;

    level.gestureinfo[ref] = data;
    _id_CB89110314447B2F++;
  }

  level.rockpaperscissors = ["ges_plyr_gesture043", "ges_plyr_gesture114", "ges_plyr_gesture115"];
}

getgesturedata(ref) {
  if(isbot(self) && ref == "devilhorns_mp")
    ref = "gesture009";

  return level.gestureinfo[ref];
}

getgesturedatabyindex(index) {
  return level.gestureinfobyindex[index];
}

_id_9E06FA9C92578F0D(_id_77C892C2CEC7A0EB) {
  if(!isDefined(_id_77C892C2CEC7A0EB))
    _id_77C892C2CEC7A0EB = 0;

  if(_id_77C892C2CEC7A0EB) {
    if(scripts\engine\utility::is_player_gamepad_enabled())
      self setactionslot(1, "taunt");
    else
      self setactionslot(7, "taunt");
  } else if(scripts\engine\utility::is_player_gamepad_enabled())
    self setactionslot(1, "");
  else
    self setactionslot(7, "");
}

cleargesture() {
  self notify("clearGesture");

  if(isDefined(self.gestureweapon) && self.gestureweapon != "none") {
    if(scripts\engine\utility::is_player_gamepad_enabled())
      self setactionslot(1, "");
    else
      self setactionslot(7, "");

    if(self hasweapon(self.gestureweapon))
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self.gestureweapon);

    self.gestureweapon = "none";
  }
}

givegesture(gestureweapon) {
  if(scripts\engine\utility::is_player_gamepad_enabled())
    self setactionslot(1, "taunt");
  else
    self setactionslot(7, "taunt");

  scripts\cp_mp\utility\inventory_utility::_giveweapon(gestureweapon);
  self assignweaponoffhandtaunt(gestureweapon);
  self.gestureweapon = gestureweapon;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "lpcFeatureGated")) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "lpcFeatureGated")]]()) {
      switch (gestureweapon) {
        case "ges_plyr_gesture043":
          thread gesture_rockpaperscissorsthink();
          gestureweapon = gesture_pickrockpaperscissors();
          break;
        case "ges_plyr_gesture050":
          _id_8C3771F0B13AC9BC = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "ges_plyr_gesture050", "ges_plyr_gesture052");
          thread gesture_coinflipthink(_id_8C3771F0B13AC9BC);
          gestureweapon = _id_8C3771F0B13AC9BC;
          break;
      }

      if(!self isconsoleplayer())
        thread monitorgamepadswitch();

      thread gesture_manage3rdperson();
    }
  }
}

monitorgamepadswitch() {
  self endon("clearGesture");
  self endon("disconnect");
  _id_CCA5D182ECCA9E1A = scripts\engine\utility::is_player_gamepad_enabled();

  for(;;) {
    if(isDefined(self.disabledgesture) && self.disabledgesture > 0) {
      waitframe();
      continue;
    }

    _id_6CA54DE3E40AEC0C = scripts\engine\utility::is_player_gamepad_enabled();

    if(_id_6CA54DE3E40AEC0C != _id_CCA5D182ECCA9E1A) {
      if(_id_CCA5D182ECCA9E1A) {
        self setactionslot(1, "");
        self setactionslot(7, "taunt");
      } else {
        self setactionslot(1, "taunt");
        self setactionslot(7, "");
      }
    }

    _id_CCA5D182ECCA9E1A = _id_6CA54DE3E40AEC0C;
    waitframe();
  }
}

gesture_manage3rdperson() {
  self endon("disconnect");

  for(;;)
    self waittill("offhand_pullback", objweapon);
}

gesture_pickrockpaperscissors() {
  return level.rockpaperscissors[randomintrange(0, level.rockpaperscissors.size)];
}

gesture_rockpaperscissorsthink() {
  self endon("clearGesture");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self notify("gesture_rockPaperScissorsThink()");
  self endon("gesture_rockPaperScissorsThink()");

  for(;;) {
    self waittill("used_cosmetic_gesture");
    _id_BFF1E3C9BA212857 = undefined;

    if(scripts\mp\flags::gameflag("prematch_done") && getdvarint("scr_test_rps", 0) == 0) {
      self[[level.showerrormessagefunc]]("MP_INGAME_ONLY/RPS_TOO_LATE");
      _id_BFF1E3C9BA212857 = 0;
    } else {
      self[[level.showerrormessagefunc]]("MP_INGAME_ONLY/RPS_START");
      _id_BFF1E3C9BA212857 = 1;
    }

    self waittill("offhand_fired");

    if(_id_BFF1E3C9BA212857)
      thread gesture_playrockpaperscissors();

    self waittill("offhand_end");
    thread gesture_resetrockpaperscissorsgesture();
  }
}

gesture_resetrockpaperscissorsgesture() {
  cleargesture();
  givegesture("ges_plyr_gesture043");
}

gesture_playrockpaperscissors() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self endon("rockPaperScissorsFinished");
  self notify("gesture_playRockPaperScissors()");
  self endon("gesture_playRockPaperScissors()");
  _id_DBF97625D6F42720 = gesture_getrockpaperscissorsplayers();

  if(isDefined(_id_DBF97625D6F42720)) {
    winner = gesture_determinerockpaperscissorswinner(self, self.gestureweapon, _id_DBF97625D6F42720, _id_DBF97625D6F42720.rockpaperscissorschoice);

    if(isDefined(winner)) {
      winner[[level.showerrormessagefunc]]("MP_INGAME_ONLY/RPS_WIN");
      winner thread[[level._id_97E29F66F7229F48]]("rock_paper_scissors_win");
      _id_CB981323A7D441EA = scripts\engine\utility::ter_op(winner == self, _id_DBF97625D6F42720, self);
      _id_CB981323A7D441EA[[level.showerrormessagefunc]]("MP_INGAME_ONLY/RPS_LOSE");
    } else {
      self[[level.showerrormessagefunc]]("MP_INGAME_ONLY/RPS_DRAW");
      _id_DBF97625D6F42720[[level.showerrormessagefunc]]("MP_INGAME_ONLY/RPS_DRAW");
    }

    _id_DBF97625D6F42720 notify("rockPaperScissorsFinished");
    _id_DBF97625D6F42720.rockpaperscissorschoice = undefined;
    return;
  }

  self.rockpaperscissorschoice = self.gestureweapon;
  wait 3;
  self.rockpaperscissorschoice = undefined;
}

gesture_getrockpaperscissorsplayers() {
  forward = anglesToForward(self getplayerangles());
  _id_EF269077A28646EB = scripts\common\utility::playersinsphere(self.origin, 500);

  foreach(_id_6EE5484560EC747C in _id_EF269077A28646EB) {
    if(!isDefined(_id_6EE5484560EC747C) || _id_6EE5484560EC747C == self) {
      continue;
    }
    if(!isDefined(_id_6EE5484560EC747C.rockpaperscissorschoice)) {
      continue;
    }
    _id_7A25DDB41E7358DB = _id_6EE5484560EC747C.origin - self.origin;
    _id_7A25DDB41E7358DB = vectorNormalize(_id_7A25DDB41E7358DB);
    _id_4A0D170010397660 = vectordot(_id_7A25DDB41E7358DB, forward);

    if(_id_4A0D170010397660 < 0.707107) {
      continue;
    }
    _id_C1FF07BECB2AD921 = anglesToForward(_id_6EE5484560EC747C getplayerangles());
    _id_577D4BC399877AE4 = _id_7A25DDB41E7358DB * -1;
    _id_A16EFA238FAEB70F = vectordot(_id_577D4BC399877AE4, _id_C1FF07BECB2AD921);

    if(_id_A16EFA238FAEB70F < 0.707107) {
      continue;
    }
    return _id_6EE5484560EC747C;
  }
}

gesture_determinerockpaperscissorswinner(_id_52A462A16496CF97, _id_CE0996D6BD90C7D4, _id_52A463A16496D1CA, _id_5F15C93009BBDE89) {
  if(_id_CE0996D6BD90C7D4 == _id_5F15C93009BBDE89)
    return undefined;

  switch (_id_CE0996D6BD90C7D4) {
    case "ges_plyr_gesture043":
      return scripts\engine\utility::ter_op(_id_5F15C93009BBDE89 == "ges_plyr_gesture114", _id_52A463A16496D1CA, _id_52A462A16496CF97);
    case "ges_plyr_gesture114":
      return scripts\engine\utility::ter_op(_id_5F15C93009BBDE89 == "ges_plyr_gesture115", _id_52A463A16496D1CA, _id_52A462A16496CF97);
    case "ges_plyr_gesture115":
      return scripts\engine\utility::ter_op(_id_5F15C93009BBDE89 == "ges_plyr_gesture043", _id_52A463A16496D1CA, _id_52A462A16496CF97);
  }
}

gesture_coinflipthink(gesture) {
  self endon("clearGesture");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self notify("gesture_coinFlipThink()");
  self endon("gesture_coinFlipThink()");

  for(;;) {
    self waittill("used_cosmetic_gesture");

    for(;;) {
      if(!self isgestureplaying(gesture)) {
        break;
      }

      waitframe();
    }

    thread gesture_resetcoinflipgesture();
  }
}

gesture_resetcoinflipgesture() {
  cleargesture();
  givegesture("ges_plyr_gesture050");
}

getbodymodel() {
  if(!isPlayer(self) || isai(self))
    return undefined;

  index = self getplayerdata(level.loadoutsgroup, "squadMembers", "body");
  return tablelookupbyrow("mp/cac/bodies.csv", index, 1);
}

haschangedarchetype() {
  if(isDefined(self.changedarchetypeinfo)) {
    if(!isDefined(self.lastarchetypeinfo))
      return 1;

    if(self.changedarchetypeinfo != self.lastarchetypeinfo)
      return 1;
  }

  return 0;
}

monitorcontextualcallout() {
  if(isai(self)) {
    return;
  }
  self endon("death_or_disconnect");
  level endon("game_ended");
  self endon("unsetLocationMarking");
  self notify("contextualCallout");
  self endon("contextualCallout");

  if(scripts\engine\utility::is_player_gamepad_enabled())
    self notifyonplayercommand("activateGesture", "+actionslot 1");
  else
    self notifyonplayercommand("activateGesture", "+actionslot 7");

  waitframe();
  cleargesture();

  for(;;) {
    self waittill("activateGesture");
    processcontext();
  }
}

processcontext() {
  startpos = self getEye();
  _id_8C57EF0D95A6EE0C = self getplayerangles();
  fwd = anglesToForward(_id_8C57EF0D95A6EE0C);
  _id_ED9AE4EC33B989C6 = cos(10);
  _id_445ACA8C2C95592E = undefined;
  _id_37088D8C2341BC50 = undefined;
  _id_69035EFA489D7AA8 = [];

  if(isDefined(self.engstructks)) {
    foreach(ent in self.engstructks.outlinedents)
    _id_69035EFA489D7AA8[_id_69035EFA489D7AA8.size] = ent;
  }

  if(isDefined(self.locationmarking_structveh)) {
    foreach(ent in self.locationmarking_structveh.outlinedents)
    _id_69035EFA489D7AA8[_id_69035EFA489D7AA8.size] = ent;
  }

  if(isDefined(self.locationmarking_structeqp)) {
    foreach(ent in self.locationmarking_structeqp.outlinedents)
    _id_69035EFA489D7AA8[_id_69035EFA489D7AA8.size] = ent;
  }

  foreach(ent in _id_69035EFA489D7AA8) {
    dot = vectordot(fwd, vectorNormalize(ent.origin - startpos));

    if(!isDefined(_id_445ACA8C2C95592E) || _id_445ACA8C2C95592E < dot) {
      _id_445ACA8C2C95592E = dot;
      _id_37088D8C2341BC50 = ent;
    }
  }

  if(isDefined(_id_37088D8C2341BC50) && _id_445ACA8C2C95592E > _id_ED9AE4EC33B989C6) {
    if(isDefined(_id_37088D8C2341BC50.vehicle))
      _id_37088D8C2341BC50 = _id_37088D8C2341BC50.vehicle;

    thread applyoutlinecalloutsource(_id_37088D8C2341BC50);
  } else {
    if(isDefined(level.gamemodegesturecalloutassign) && self thread[[level.gamemodegesturecalloutassign]]()) {
      return;
    }
    _id_C56207BDA09B3A36 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip"];
    contentoverride = physics_createcontents(_id_C56207BDA09B3A36);
    endpos = startpos + fwd * 10000;
    trace = scripts\engine\trace::sphere_trace(startpos, endpos, 0.1, self, contentoverride, 0);

    if(trace["fraction"] < 0.99)
      thread markworldposition(trace["position"]);
    else {}
  }
}

markworldposition(org) {
  self.worldmarkerpos = org;

  if(!isDefined(self.worldmarkerid)) {
    self.worldmarkerid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

    if(self.worldmarkerid != -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(self.worldmarkerid, "invisible", org, "icon_waypoint_marker");
      scripts\mp\objidpoolmanager::objective_teammask_single(self.worldmarkerid, self.team);
      scripts\mp\objidpoolmanager::update_objective_setbackground(self.worldmarkerid, 1);
      scripts\mp\objidpoolmanager::objective_set_play_intro(self.worldmarkerid, 0);
      scripts\mp\objidpoolmanager::objective_set_play_outro(self.worldmarkerid, 0);
    } else {
      self.worldmarkerid = undefined;
      return;
    }
  } else
    scripts\mp\objidpoolmanager::update_objective_position(self.worldmarkerid, org);

  objid = self.worldmarkerid;
  self notify("markWorldPosition");
  self endon("markWorldPosition");
  scripts\mp\objidpoolmanager::objective_set_pulsate(objid, 1);
  wait 3.0;
  scripts\mp\objidpoolmanager::objective_set_pulsate(objid, 0);
  wait 5.0;
  scripts\mp\objidpoolmanager::returnobjectiveid(objid);
  self.worldmarkerid = undefined;
  self.worldmarkerpos = undefined;
}

applyoutlinecalloutsource(ent) {
  if(!isDefined(ent.outlinecalloutsource))
    ent.outlinecalloutsource = [];

  foreach(player in ent.outlinecalloutsource) {
    if(player == self)
      return;
  }

  event = "assist_ping";
  points = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "getScoreInfoValue"))
    points = [[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "getScoreInfoValue")]](event);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "giveRankXP"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "giveRankXP")]](event, points);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "giveSuperPoints"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "giveSuperPoints")]](points);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "scoreEventPopup"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "scoreEventPopup")]](event);

  outlines = [];
  id = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineEnableForTeam"))
    id = [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineEnableForTeam")]](ent, self.team, "outline_nodepth_red", "perk_superior");

  ent.outlinecalloutsource[ent.outlinecalloutsource.size] = self;
  outlines[id] = ent;
  _id_C09F31C1C604EAEF = 0;

  if(isDefined(ent.turret)) {
    id = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineEnableForTeam"))
      id = [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineEnableForTeam")]](ent.turret, self.team, "outline_nodepth_red", "perk_superior");

    outlines[id] = ent.turret;
    _id_C09F31C1C604EAEF = 1;
  }

  if(_id_C09F31C1C604EAEF)
    ent thread processtimeout(self, outlines);
}

processtimeout(attacker, outlines) {
  attacker endon("disconnect");
  self endon("death");
  timeout = 30.0;
  wait(timeout);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.outlinecalloutsource.size; _id_AC0E594AC96AA3A8++) {
    if(self.outlinecalloutsource[_id_AC0E594AC96AA3A8] == attacker)
      self.outlinecalloutsource[_id_AC0E594AC96AA3A8] = undefined;
  }

  foreach(id, ent in outlines) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineDisable"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineDisable")]](id, ent);
  }
}

processcalloutdeath(ent, attacker) {
  if(!isDefined(ent) || !isDefined(attacker)) {
    return;
  }
  if(!isDefined(ent.outlinecalloutsource)) {
    return;
  }
  foreach(player in ent.outlinecalloutsource) {
    if(!isDefined(player)) {
      continue;
    }
    if(player == attacker) {
      continue;
    }
    if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(player, attacker))) {
      continue;
    }
    _id_F0FA3B7B27926553 = "assist_marked";
    points = 0;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "getScoreInfoValue"))
      points = [[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "getScoreInfoValue")]](_id_F0FA3B7B27926553);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "giveRankXP"))
      player thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "giveRankXP")]](_id_F0FA3B7B27926553, points);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "giveSuperPoints"))
      player thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "giveSuperPoints")]](points);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "scoreEventPopup"))
      player thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "scoreEventPopup")]](_id_F0FA3B7B27926553);

    points = 25;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "giveRankXP"))
      attacker thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "giveRankXP")]](_id_F0FA3B7B27926553, points);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "giveSuperPoints"))
      attacker thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "giveSuperPoints")]](points);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "scoreEventPopup"))
      attacker thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "scoreEventPopup")]](_id_F0FA3B7B27926553);
  }
}

applygamemodecallout(ent, msg, event) {
  self endon("disconnect");

  if(isDefined(self.gamemodecalloutent)) {
    if(self.gamemodecalloutent == ent) {
      return;
    }
    self notify("gamemode_callout_replaced");
  } else {
    _id_F0FA3B7B27926553 = "assist_ping";
    points = 0;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "getScoreInfoValue"))
      points = [[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "getScoreInfoValue")]](_id_F0FA3B7B27926553);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "giveRankXP"))
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "giveRankXP")]](_id_F0FA3B7B27926553, points);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "giveSuperPoints"))
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "giveSuperPoints")]](points);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "scoreEventPopup"))
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "scoreEventPopup")]](_id_F0FA3B7B27926553);
  }

  self.gamemodecallouttime = gettime();
  self.gamemodecalloutent = ent;
  id = undefined;

  if(isDefined(ent.outlineent)) {
    id = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineEnableForTeam"))
      id = [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineEnableForTeam")]](ent.outlineent, self.team, "outline_nodepth_red", "perk_superior");
  }

  foreach(player in level.players) {
    if(player.team != self.team) {
      continue;
    }
    player iprintlnbold(msg);
  }

  thread waittillobjectiveevent(id, ent, event);
  thread waittillobjectivereplaced(id, ent, event);
  timeout = 30.0;
  scripts\engine\utility::waittill_notify_or_timeout("callout_processed_" + event, timeout);
  self notify("callout_timeout_" + event);

  if(isDefined(ent.outlineent)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineDisable"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineDisable")]](id, ent.outlineent);
  }

  self.gamemodecalloutent = undefined;
}

waittillobjectiveevent(id, ent, event) {
  self endon("callout_timeout_" + event);
  self endon("gamemode_callout_replaced");
  self endon("disconnect");
  team = self.team;

  for(;;) {
    ent waittill(event, player);
    _id_98DA853291A33610 = 0;

    if(isDefined(level.gamemodegesturecalloutverify))
      _id_98DA853291A33610 = self[[level.gamemodegesturecalloutverify]](event, player);

    if(_id_98DA853291A33610) {
      _id_F0FA3B7B27926553 = "assist_marked";
      points = 0;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "getScoreInfoValue"))
        points = [[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "getScoreInfoValue")]](_id_F0FA3B7B27926553);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "giveRankXP"))
        self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "giveRankXP")]](_id_F0FA3B7B27926553, points);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "giveSuperPoints"))
        self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "giveSuperPoints")]](points);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "scoreEventPopup"))
        self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "scoreEventPopup")]](_id_F0FA3B7B27926553);

      points = 25;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "giveRankXP"))
        player thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "giveRankXP")]](_id_F0FA3B7B27926553, points);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "giveSuperPoints"))
        player thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "giveSuperPoints")]](points);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "scoreEventPopup"))
        player thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "scoreEventPopup")]](_id_F0FA3B7B27926553);

      if(isDefined(ent.outlineent)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineDisable"))
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineDisable")]](id, ent.outlineent);
      }

      self notify("callout_processed_" + event);
      break;
    }
  }
}

waittillobjectivereplaced(id, ent, event) {
  self endon("callout_timeout_" + event);
  self endon("callout_processed_" + event);
  self endon("disconnect");
  self waittill("gamemode_callout_replaced");

  if(isDefined(ent.outlineent)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineDisable"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineDisable")]](id, ent.outlineent);
  }
}

startholowatchvfx() {
  if(level.mapname == "mp_hackney_yard" || level.mapname == "mp_spear_pm" || level.mapname == "mp_runner_pm" || level.mapname == "mp_cave") {
    self setscriptablepartstate("watchVFXPlayer", "holoWatchOnNight");
    self setclientomnvar("ui_pet_watch_state", 1);
  } else {
    self setscriptablepartstate("watchVFXPlayer", "holoWatchOn");
    self setclientomnvar("ui_pet_watch_state", 0);
  }
}

startbluntwatchvfx() {
  if(istrue(self._id_74E82E1456D96CAD)) {
    return;
  }
  self setscriptablepartstate("watchVFXPlayer", "bluntWatchOn");
  self setclientomnvar("ui_pet_watch_state", 0);
  self setwristwatchtime(4, 20, 1);
  self._id_74E82E1456D96CAD = 1;
  thread _id_A4F0DA4979F60824();
}

_id_A4F0DA4979F60824() {
  self endon("disconnect");
  self endon("game_ended");
  wait 4.2;
  self._id_74E82E1456D96CAD = undefined;
  self setscriptablepartstate("watchVFXPlayer", "off");

  if(isDefined(self.accessorylogic))
    self clearwristwatchtime();
}

tryreenablescriptablevfx() {
  self endon("death_or_disconnect");
  self setscriptablepartstate("watchVFXPlayer", "off");
  _id_C0B92B6128568C20 = isDefined(self.accessorylogic) && self.accessorylogic == "holo";

  if(_id_C0B92B6128568C20) {
    wait 0.2;
    _id_602111B3819425B2 = self hasweapon("iw8_acc_weapon_watch_2+iw8_acc_attach_face_digital_ag");

    if(_id_602111B3819425B2 && (!isDefined(self.smartwatchinteract) || istrue(self.smartwatchinteract))) {
      if(_id_602111B3819425B2)
        startholowatchvfx();
    }
  }
}

watchradialgestureactivation(_id_D608D01A055671C9, _id_FEDCFC68053C9DDC) {
  if((scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() || level.gametype == "dmz" || level.gametype == "exgm" || level.gametype == "plunder") && self hasweapon("iw9_armor_plate_deploy_mp")) {
    return;
  }
  if(_id_D608D01A055671C9 == "radial_menu_selection_gesture") {
    _id_3967A9DC0290FC08 = getgesturedatabyindex(_id_FEDCFC68053C9DDC);

    if(isDefined(_id_3967A9DC0290FC08)) {
      if(_id_3967A9DC0290FC08 == "iw8_ges_plyr_gesture024") {
        if(!isDefined(self.smartwatchinteract))
          self.smartwatchinteract = 0;

        self.smartwatchinteract = !self.smartwatchinteract;
        self setclientomnvar("ui_smart_watch_interact", self.smartwatchinteract);

        if(isDefined(self.accessorylogic)) {
          if(self.accessorylogic == "holo") {
            if(!self.smartwatchinteract)
              startholowatchvfx();
            else
              self setscriptablepartstate("watchVFXPlayer", "off");
          }
        }
      } else if(_id_3967A9DC0290FC08 == "iw8_ges_plyr_gesture023") {
        if(!isDefined(self.watchcheck))
          self.watchcheck = 0;

        self.watchcheck = !self.watchcheck;
        self setclientomnvar("ui_smart_watch_check", self.watchcheck);

        if(isDefined(self.accessorylogic)) {
          if(self.accessorylogic == "blunt")
            startbluntwatchvfx();
        }
      }

      objweapon = makeweapon(_id_3967A9DC0290FC08);

      if(isDefined(objweapon) && !isnullweapon(objweapon)) {
        watchradialgesture(objweapon);
        return;
      }

      return;
    }
  } else if(_id_D608D01A055671C9 == "radial_menu_selection_spray") {
    objweapon = makeweapon("iw8_ges_plyr_spray");

    if(isDefined(objweapon) && !isnullweapon(objweapon)) {
      thread watchspraygesturedosprayevent(_id_FEDCFC68053C9DDC);
      watchradialgesture(objweapon);
    } else {}
  }
}

watchspraygesturedosprayevent(_id_FB7362E3E2706612) {
  self endon("death");
  self endon("disconnect");
  self notify("watchSprayGestureDoSprayEvent");
  self endon("watchSprayGestureDoSprayEvent");
  endtime = gettime() + 200;

  while(gettime() < endtime) {
    waitframe();

    if(self isgestureplaying("iw8_ges_plyr_spray")) {
      self sprayevent(_id_FB7362E3E2706612);
      scripts\cp_mp\challenges::onspray();
      return;
    }
  }
}

watchradialgesture(objweapon) {
  self giveandfireoffhand(objweapon);
  endtime = gettime() + 5000;

  while(gettime() < endtime) {
    if(!self hasweapon(objweapon)) {
      break;
    }

    waitframe();
  }

  if(self hasweapon(objweapon))
    scripts\cp_mp\utility\inventory_utility::_takeweapon(objweapon);

  cleargesture();
  waitframe();
  self.gestureweapon = objweapon.basename;
}
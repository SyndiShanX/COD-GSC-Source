/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1939.gsc
*************************************************/

init() {
  level._id_62E8 = [];
  level._id_62E9 = [];
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("mp/gesturetable.csv", var_0, 0);

    if(!isDefined(var_1) || var_1 == "") {
      break;
    }

    var_2 = tablelookupbyrow("mp/gesturetable.csv", var_0, 1);

    if(!isDefined(var_2) || var_2 == "") {
      break;
    }

    var_3 = int(tablelookupbyrow("mp/gesturetable.csv", var_0, 8));

    if(isDefined(var_3)) {
      level._id_62E9[var_3] = var_2;
    }

    level._id_62E8[var_1] = var_2;
    var_0++;
  }

  level._id_C8BB = ["ges_plyr_gesture043", "ges_plyr_gesture114", "ges_plyr_gesture115"];
}

_id_6A6A(var_0) {
  if(isbot(self) && var_0 == "devilhorns_mp") {
    var_0 = "gesture009";
  }

  return level._id_62E8[var_0];
}

_id_6A6B(var_0) {
  return level._id_62E9[var_0];
}

_id_3941() {
  self notify("clearGesture");

  if(isDefined(self._id_62F1) && self._id_62F1 != "none") {
    if(scripts\engine\utility::is_player_gamepad_enabled()) {
      self setactionslot(1, "");
    } else {
      self setactionslot(7, "");
    }

    if(self hasweapon(self._id_62F1)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self._id_62F1);
    }

    self._id_62F1 = "none";
  }
}

_id_6F9C(var_0) {
  if(scripts\engine\utility::is_player_gamepad_enabled()) {
    self setactionslot(1, "taunt");
  } else {
    self setactionslot(7, "taunt");
  }

  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0);
  self _meth_8565(var_0);
  self._id_62F1 = var_0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "lpcFeatureGated")) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "lpcFeatureGated")]]()) {
      switch (var_0) {
        case "ges_plyr_gesture043":
          thread _id_62DA();
          var_0 = _id_62CD();
          break;
        case "ges_plyr_gesture050":
          var_1 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "ges_plyr_gesture050", "ges_plyr_gesture052");
          thread _id_62B0(var_1);
          var_0 = var_1;
          break;
      }

      if(!self _meth_8684()) {
        thread _id_A111();
      }

      thread _id_62C7();
    }
  }
}

_id_A111() {
  self endon("clearGesture");
  self endon("disconnect");
  var_0 = scripts\engine\utility::is_player_gamepad_enabled();

  for(;;) {
    if(isDefined(self._id_4A9C) && self._id_4A9C > 0) {
      waitframe();
      continue;
    }

    var_1 = scripts\engine\utility::is_player_gamepad_enabled();

    if(var_1 != var_0) {
      if(var_0) {
        self setactionslot(1, "");
        self setactionslot(7, "taunt");
      } else {
        self setactionslot(1, "taunt");
        self setactionslot(7, "");
      }
    }

    var_0 = var_1;
    waitframe();
  }
}

_id_62C7() {
  self endon("disconnect");

  for(;;) {
    self waittill("offhand_pullback", var_0);
  }
}

_id_62CD() {
  return level._id_C8BB[randomintrange(0, level._id_C8BB.size)];
}

_id_62DA() {
  self endon("clearGesture");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self notify("gesture_rockPaperScissorsThink()");
  self endon("gesture_rockPaperScissorsThink()");

  for(;;) {
    self waittill("used_cosmetic_gesture");
    var_0 = undefined;

    if(_id_07D1::_id_60BE("prematch_done") && getdvarint("#x3a26b2b40f36a25c5", 0) == 0) {
      self[[level._id_DCA3]]("MP_INGAME_ONLY/RPS_TOO_LATE");
      var_0 = 0;
    } else {
      self[[level._id_DCA3]]("MP_INGAME_ONLY/RPS_START");
      var_0 = 1;
    }

    self waittill("offhand_fired");

    if(var_0) {
      thread _id_62CE();
    }

    self waittill("offhand_end");
    thread _id_62D9();
  }
}

_id_62D9() {
  _id_3941();
  _id_6F9C("ges_plyr_gesture043");
}

_id_62CE() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self endon("rockPaperScissorsFinished");
  self notify("gesture_playRockPaperScissors()");
  self endon("gesture_playRockPaperScissors()");
  var_0 = _id_62C3();

  if(isDefined(var_0)) {
    var_1 = _id_62B4(self, self._id_62F1, var_0, var_0._id_C8BC);

    if(isDefined(var_1)) {
      var_1[[level._id_DCA3]]("MP_INGAME_ONLY/RPS_WIN");
      var_1 thread[[level._id_6FBA]]("rock_paper_scissors_win");
      var_2 = scripts\engine\utility::ter_op(var_1 == self, var_0, self);
      var_2[[level._id_DCA3]]("MP_INGAME_ONLY/RPS_LOSE");
    } else {
      self[[level._id_DCA3]]("MP_INGAME_ONLY/RPS_DRAW");
      var_0[[level._id_DCA3]]("MP_INGAME_ONLY/RPS_DRAW");
    }

    var_0 notify("rockPaperScissorsFinished");
    var_0._id_C8BC = undefined;
    return;
  }

  self._id_C8BC = self._id_62F1;
  wait 3;
  self._id_C8BC = undefined;
}

_id_62C3() {
  var_0 = anglesToForward(self getplayerangles());
  var_1 = scripts\common\utility::_id_B7BF(self.origin, 500);

  foreach(var_3 in var_1) {
    if(!isDefined(var_3) || var_3 == self) {
      continue;
    }
    if(!isDefined(var_3._id_C8BC)) {
      continue;
    }
    var_4 = var_3.origin - self.origin;
    var_4 = vectornormalize(var_4);
    var_5 = vectordot(var_4, var_0);

    if(var_5 < 0.707107) {
      continue;
    }
    var_6 = anglesToForward(var_3 getplayerangles());
    var_7 = var_4 * -1;
    var_8 = vectordot(var_7, var_6);

    if(var_8 < 0.707107) {
      continue;
    }
    return var_3;
  }
}

_id_62B4(var_0, var_1, var_2, var_3) {
  if(var_1 == var_3) {
    return undefined;
  }

  switch (var_1) {
    case "ges_plyr_gesture043":
      return scripts\engine\utility::ter_op(var_3 == "ges_plyr_gesture114", var_2, var_0);
    case "ges_plyr_gesture114":
      return scripts\engine\utility::ter_op(var_3 == "ges_plyr_gesture115", var_2, var_0);
    case "ges_plyr_gesture115":
      return scripts\engine\utility::ter_op(var_3 == "ges_plyr_gesture043", var_2, var_0);
  }
}

_id_62B0(var_0) {
  self endon("clearGesture");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self notify("gesture_coinFlipThink()");
  self endon("gesture_coinFlipThink()");

  for(;;) {
    self waittill("used_cosmetic_gesture");

    for(;;) {
      if(!self _meth_84B7(var_0)) {
        break;
      }

      waitframe();
    }

    thread _id_62D8();
  }
}

_id_62D8() {
  _id_3941();
  _id_6F9C("ges_plyr_gesture050");
}

_id_6923() {
  if(!isPlayer(self) || isai(self)) {
    return undefined;
  }

  var_0 = self getplayerdata(level.loadoutsgroup, "squadMembers", "body");
  return tablelookupbyrow("mp/cac/bodies.csv", var_0, 1);
}

_id_754B() {
  if(isDefined(self._id_33DA)) {
    if(!isDefined(self._id_8F8C)) {
      return 1;
    }

    if(self._id_33DA != self._id_8F8C) {
      return 1;
    }
  }

  return 0;
}

_id_A0FC() {
  if(isai(self)) {
    return;
  }
  self endon("death_or_disconnect");
  level endon("game_ended");
  self endon("unsetLocationMarking");
  self notify("contextualCallout");
  self endon("contextualCallout");

  if(scripts\engine\utility::is_player_gamepad_enabled()) {
    self notifyonplayercommand("activateGesture", "+actionslot 1");
  } else {
    self notifyonplayercommand("activateGesture", "+actionslot 7");
  }

  waitframe();
  _id_3941();

  for(;;) {
    self waittill("activateGesture");
    _id_BD64();
  }
}

_id_BD64() {
  var_0 = self getEye();
  var_1 = self getplayerangles();
  var_2 = anglesToForward(var_1);
  var_3 = cos(10);
  var_4 = undefined;
  var_5 = undefined;
  var_6 = [];

  if(isDefined(self._id_5464)) {
    foreach(var_8 in self._id_5464._id_ACC8) {
      var_6[var_6.size] = var_8;
    }
  }

  if(isDefined(self._id_96DC)) {
    foreach(var_8 in self._id_96DC._id_ACC8) {
      var_6[var_6.size] = var_8;
    }
  }

  if(isDefined(self._id_96DB)) {
    foreach(var_8 in self._id_96DB._id_ACC8) {
      var_6[var_6.size] = var_8;
    }
  }

  foreach(var_8 in var_6) {
    var_15 = vectordot(var_2, vectornormalize(var_8.origin - var_0));

    if(!isDefined(var_4) || var_4 < var_15) {
      var_4 = var_15;
      var_5 = var_8;
    }
  }

  if(isDefined(var_5) && var_4 > var_3) {
    if(isDefined(var_5.vehicle)) {
      var_5 = var_5.vehicle;
    }

    thread _id_19E1(var_5);
  } else {
    if(isDefined(level._id_60CD) && self thread[[level._id_60CD]]()) {
      return;
    }
    var_17 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip"];
    var_18 = physics_createcontents(var_17);
    var_19 = var_0 + var_2 * 10000;
    var_20 = scripts\engine\trace::_id_E409(var_0, var_19, 0.1, self, var_18, 0);

    if(var_20["fraction"] < 0.99) {
      thread _id_9B8E(var_20["position"]);
    } else {}
  }
}

_id_9B8E(var_0) {
  self._id_10F4A = var_0;

  if(!isDefined(self._id_10F49)) {
    self._id_10F49 = _id_07F9::_id_C57D(1);

    if(self._id_10F49 != -1) {
      _id_07F9::_id_A867(self._id_10F49, "invisible", var_0, "icon_waypoint_marker");
      _id_07F9::_id_A8CA(self._id_10F49, self.team);
      _id_07F9::_id_FB98(self._id_10F49, 1);
      _id_07F9::_id_A8B1(self._id_10F49, 0);
      _id_07F9::_id_A8B2(self._id_10F49, 0);
    } else {
      self._id_10F49 = undefined;
      return;
    }
  } else
    _id_07F9::_id_FB97(self._id_10F49, var_0);

  var_1 = self._id_10F49;
  self notify("markWorldPosition");
  self endon("markWorldPosition");
  _id_07F9::_id_A8B7(var_1, 1);
  wait 3.0;
  _id_07F9::_id_A8B7(var_1, 0);
  wait 5.0;
  _id_07F9::_id_C799(var_1);
  self._id_10F49 = undefined;
  self._id_10F4A = undefined;
}

_id_19E1(var_0) {
  if(!isDefined(var_0._id_ACC3)) {
    var_0._id_ACC3 = [];
  }

  foreach(var_2 in var_0._id_ACC3) {
    if(var_2 == self) {
      return;
    }
  }

  var_4 = "assist_ping";
  var_5 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "getScoreInfoValue")) {
    var_5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "getScoreInfoValue")]](var_4);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "giveRankXP")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "giveRankXP")]](var_4, var_5);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "giveSuperPoints")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "giveSuperPoints")]](var_5);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "scoreEventPopup")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "scoreEventPopup")]](var_4);
  }

  var_6 = [];
  var_7 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineEnableForTeam")) {
    var_7 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineEnableForTeam")]](var_0, self.team, "outline_nodepth_red", "perk_superior");
  }

  var_0._id_ACC3[var_0._id_ACC3.size] = self;
  var_6[var_7] = var_0;
  var_8 = 0;

  if(isDefined(var_0._id_F81F)) {
    var_7 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineEnableForTeam")) {
      var_7 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineEnableForTeam")]](var_0._id_F81F, self.team, "outline_nodepth_red", "perk_superior");
    }

    var_6[var_7] = var_0._id_F81F;
    var_8 = 1;
  }

  if(var_8) {
    var_0 thread _id_BD83(self, var_6);
  }
}

_id_BD83(var_0, var_1) {
  var_0 endon("disconnect");
  self endon("death");
  var_2 = 30.0;
  wait(var_2);

  for(var_3 = 0; var_3 < self._id_ACC3.size; var_3++) {
    if(self._id_ACC3[var_3] == var_0) {
      self._id_ACC3[var_3] = undefined;
    }
  }

  foreach(var_6, var_5 in var_1) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineDisable")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineDisable")]](var_6, var_5);
    }
  }
}

_id_BD60(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  if(!isDefined(var_0._id_ACC3)) {
    return;
  }
  foreach(var_3 in var_0._id_ACC3) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(var_3 == var_1) {
      continue;
    }
    if(istrue(scripts\cp_mp\utility\player_utility::_id_B78C(var_3, var_1))) {
      continue;
    }
    var_4 = "assist_marked";
    var_5 = 0;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "getScoreInfoValue")) {
      var_5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "getScoreInfoValue")]](var_4);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "giveRankXP")) {
      var_3 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "giveRankXP")]](var_4, var_5);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "giveSuperPoints")) {
      var_3 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "giveSuperPoints")]](var_5);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "scoreEventPopup")) {
      var_3 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "scoreEventPopup")]](var_4);
    }

    var_5 = 25;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "giveRankXP")) {
      var_1 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "giveRankXP")]](var_4, var_5);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "giveSuperPoints")) {
      var_1 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "giveSuperPoints")]](var_5);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "scoreEventPopup")) {
      var_1 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "scoreEventPopup")]](var_4);
    }
  }
}

_id_19D5(var_0, var_1, var_2) {
  self endon("disconnect");

  if(isDefined(self._id_60C9)) {
    if(self._id_60C9 == var_0) {
      return;
    }
    self notify("gamemode_callout_replaced");
  } else {
    var_3 = "assist_ping";
    var_4 = 0;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "getScoreInfoValue")) {
      var_4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "getScoreInfoValue")]](var_3);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "giveRankXP")) {
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "giveRankXP")]](var_3, var_4);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "giveSuperPoints")) {
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "giveSuperPoints")]](var_4);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "scoreEventPopup")) {
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "scoreEventPopup")]](var_3);
    }
  }

  self._id_60CA = gettime();
  self._id_60C9 = var_0;
  var_5 = undefined;

  if(isDefined(var_0._id_ACD6)) {
    var_5 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineEnableForTeam")) {
      var_5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineEnableForTeam")]](var_0._id_ACD6, self.team, "outline_nodepth_red", "perk_superior");
    }
  }

  foreach(var_7 in level.players) {
    if(var_7.team != self.team) {
      continue;
    }
    var_7 iprintlnbold(var_1);
  }

  thread _id_10962(var_5, var_0, var_2);
  thread _id_10963(var_5, var_0, var_2);
  var_9 = 30.0;
  scripts\engine\utility::_id_108F5("callout_processed_" + var_2, var_9);
  self notify("callout_timeout_" + var_2);

  if(isDefined(var_0._id_ACD6)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineDisable")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineDisable")]](var_5, var_0._id_ACD6);
    }
  }

  self._id_60C9 = undefined;
}

_id_10962(var_0, var_1, var_2) {
  self endon("callout_timeout_" + var_2);
  self endon("gamemode_callout_replaced");
  self endon("disconnect");
  var_3 = self.team;

  for(;;) {
    var_1 waittill(var_2, var_4);
    var_5 = 0;

    if(isDefined(level._id_60CE)) {
      var_5 = self[[level._id_60CE]](var_2, var_4);
    }

    if(var_5) {
      var_6 = "assist_marked";
      var_7 = 0;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "getScoreInfoValue")) {
        var_7 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "getScoreInfoValue")]](var_6);
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "giveRankXP")) {
        self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "giveRankXP")]](var_6, var_7);
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "giveSuperPoints")) {
        self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "giveSuperPoints")]](var_7);
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "scoreEventPopup")) {
        self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "scoreEventPopup")]](var_6);
      }

      var_7 = 25;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "giveRankXP")) {
        var_4 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "giveRankXP")]](var_6, var_7);
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "giveSuperPoints")) {
        var_4 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "giveSuperPoints")]](var_7);
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "scoreEventPopup")) {
        var_4 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "scoreEventPopup")]](var_6);
      }

      if(isDefined(var_1._id_ACD6)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineDisable")) {
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineDisable")]](var_0, var_1._id_ACD6);
        }
      }

      self notify("callout_processed_" + var_2);
      break;
    }
  }
}

_id_10963(var_0, var_1, var_2) {
  self endon("callout_timeout_" + var_2);
  self endon("callout_processed_" + var_2);
  self endon("disconnect");
  self waittill("gamemode_callout_replaced");

  if(isDefined(var_1._id_ACD6)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineDisable")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineDisable")]](var_0, var_1._id_ACD6);
    }
  }
}

_id_10BEE(var_0, var_1) {
  if((level.gametype == "br" || level.gametype == "dmz") && self hasweapon("armor_plate_deploy_mp")) {
    return;
  }
  if(level._id_3FD9) {
    return;
  }
  if(var_0 == "radial_menu_selection_gesture") {
    var_2 = _id_6A6B(var_1);

    if(isDefined(var_2)) {
      if(var_2 == "iw8_ges_plyr_gesture024") {
        if(!isDefined(self._id_DE2A)) {
          self._id_DE2A = 0;
        }

        self._id_DE2A = !self._id_DE2A;
        self setclientomnvar("ui_smart_watch_interact", self._id_DE2A);
      } else if(var_2 == "iw8_ges_plyr_gesture023") {
        if(!isDefined(self._id_10AB0)) {
          self._id_10AB0 = 0;
        }

        self._id_10AB0 = !self._id_10AB0;
        self setclientomnvar("ui_smart_watch_check", self._id_10AB0);
      }

      var_3 = makeweapon(var_2);

      if(isDefined(var_3) && !isnullweapon(var_3)) {
        _id_10BED(var_3);
        scripts\engine\utility::_id_CD61("createMiscEventChallengeEvent", "gestureUsed");
        return;
      }

      return;
    }
  } else if(var_0 == "radial_menu_selection_spray") {
    var_3 = makeweapon("iw8_ges_plyr_spray");

    if(isDefined(var_3) && !isnullweapon(var_3)) {
      thread _id_10BFF(var_1);
      _id_10BED(var_3);
    } else {}
  }
}

_id_10BFF(var_0) {
  self endon("death");
  self endon("disconnect");
  self notify("watchSprayGestureDoSprayEvent");
  self endon("watchSprayGestureDoSprayEvent");
  var_1 = gettime() + 200;

  while(gettime() < var_1) {
    waitframe();

    if(self _meth_84B7("iw8_ges_plyr_spray")) {
      self _meth_86ED(var_0);
      scripts\engine\utility::_id_CD61("createMiscEventChallengeEvent", "sprayUsed");
      return;
    }
  }
}

_id_10BED(var_0) {
  self _meth_852A(var_0);
  var_1 = gettime() + 5000;

  while(gettime() < var_1) {
    if(!self hasweapon(var_0)) {
      break;
    }

    waitframe();
  }

  if(self hasweapon(var_0)) {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
  }

  _id_3941();
  waitframe();
  self._id_62F1 = var_0.basename;
}
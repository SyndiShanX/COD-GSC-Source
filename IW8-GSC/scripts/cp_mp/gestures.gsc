/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\gestures.gsc
***********************************************/

function init() {
  level.gestureinfo = [];
  level.gestureinfobyindex = [];
  level.predictandclearintermissionstreaming = [];

  for(var_0 = 0;; var_0++) {
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
      level.gestureinfobyindex[var_3] = var_2;
    }

    var_4 = tablelookupbyrow("mp/gesturetable.csv", var_0, 15);

    if(isDefined(var_3) && isDefined(var_4) && var_4 != "") {
      level.predictandclearintermissionstreaming[var_3] = var_4;
    }

    level.gestureinfo[var_1] = var_2;
  }

  level.rockpaperscissors = ["ges_plyr_gesture043", "ges_plyr_gesture114", "ges_plyr_gesture115"];
}

function getgesturedata(var_0) {
  if(isbot(self) && var_0 == "devilhorns_mp") {
    var_0 = "gesture009";
  }

  return level.gestureinfo[var_0];
}

function getgesturedatabyindex(var_0) {
  return level.gestureinfobyindex[var_0];
}

function remapobjkeysandscriptlabels(var_0) {
  return level.predictandclearintermissionstreaming[var_0];
}

function cleargesture() {
  self notify("clearGesture");

  if(isDefined(self.gestureweapon) && self.gestureweapon != "none") {
    if(scripts\engine\utility::is_player_gamepad_enabled()) {
      self setactionslot(1, "");
    } else {
      self setactionslot(7, "");
    }

    if(self hasweapon(self.gestureweapon)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self.gestureweapon);
    }

    self.gestureweapon = "none";
    return;
  }
}

function givegesture(var_0) {
  if(scripts\engine\utility::is_player_gamepad_enabled()) {
    self setactionslot(1, "taunt");
  } else {
    self setactionslot(7, "taunt");
  }

  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0);
  self assignweaponoffhandtaunt(var_0);
  self.gestureweapon = var_0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "lpcFeatureGated")) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "lpcFeatureGated")]]()) {
      switch (var_0) {
        case "ges_plyr_gesture043":
          thread gesture_rockpaperscissorsthink();
          var_0 = gesture_pickrockpaperscissors();
          break;
        case "ges_plyr_gesture050":
          var_1 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "ges_plyr_gesture050", "ges_plyr_gesture052");
          thread gesture_coinflipthink(var_1);
          var_0 = var_1;
          break;
      }

      if(!self isconsoleplayer()) {
        thread monitorgamepadswitch();
      }

      thread gesture_manage3rdperson();
      return;
    }

    return;
  }
}

function monitorgamepadswitch() {
  self endon("clearGesture");
  self endon("disconnect");
  var_0 = scripts\engine\utility::is_player_gamepad_enabled();

  for(;;) {
    if(isDefined(self.disabledgesture) && self.disabledgesture > 0) {
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

function gesture_manage3rdperson() {
  self endon("disconnect");

  for(;;) {
    self waittill("offhand_pullback", var_0);
  }
}

function gesture_pickrockpaperscissors() {
  return level.rockpaperscissors[randomintrange(0, level.rockpaperscissors.size)];
}

function gesture_rockpaperscissorsthink() {
  self endon("clearGesture");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self notify("gesture_rockPaperScissorsThink()");
  self endon("gesture_rockPaperScissorsThink()");

  for(;;) {
    self waittill("used_cosmetic_gesture");
    var_0 = undefined;

    if(scripts\mp\flags::gameflag("prematch_done") && getdvarint("scr_test_rps", 0) == 0) {
      self[[level.showerrormessagefunc]]("MP_INGAME_ONLY/RPS_TOO_LATE");
      var_0 = 0;
    } else {
      self[[level.showerrormessagefunc]]("MP_INGAME_ONLY/RPS_START");
      var_0 = 1;
    }

    self waittill("offhand_fired");

    if(var_0) {
      thread gesture_playrockpaperscissors();
    }

    self waittill("offhand_end");
    thread gesture_resetrockpaperscissorsgesture();
  }
}

function gesture_resetrockpaperscissorsgesture() {
  cleargesture();
  givegesture("ges_plyr_gesture043");
}

function gesture_playrockpaperscissors() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self endon("rockPaperScissorsFinished");
  self notify("gesture_playRockPaperScissors()");
  self endon("gesture_playRockPaperScissors()");
  var_0 = gesture_getrockpaperscissorsplayers();

  if(isDefined(var_0)) {
    var_1 = gesture_determinerockpaperscissorswinner(self, self.gestureweapon, var_0, var_0.rockpaperscissorschoice);

    if(isDefined(var_1)) {
      var_1[[level.showerrormessagefunc]]("MP_INGAME_ONLY/RPS_WIN");
      var_1 thread[[level.givemidmatchawardfunc]]("rock_paper_scissors_win");
      var_2 = scripts\engine\utility::ter_op(var_1 == self, var_0, self);
      var_2[[level.showerrormessagefunc]]("MP_INGAME_ONLY/RPS_LOSE");
    } else {
      self[[level.showerrormessagefunc]]("MP_INGAME_ONLY/RPS_DRAW");
      var_0[[level.showerrormessagefunc]]("MP_INGAME_ONLY/RPS_DRAW");
    }

    var_0 notify("rockPaperScissorsFinished");
    var_0.rockpaperscissorschoice = undefined;
    return;
  }

  self.rockpaperscissorschoice = self.gestureweapon;
  wait 3;
  self.rockpaperscissorschoice = undefined;
}

function gesture_getrockpaperscissorsplayers() {
  var_0 = anglesToForward(self getplayerangles());
  var_1 = scripts\common\utility::playersinsphere(self.origin, 500);

  foreach(var_3 in var_1) {
    if(!isDefined(var_3) || var_3 == self) {
      continue;
    }

    if(!isDefined(var_3.rockpaperscissorschoice)) {
      continue;
    }

    var_4 = var_3.origin - self.origin;
    var_4 = vectorNormalize(var_4);
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

function gesture_determinerockpaperscissorswinner(var_0, var_1, var_2, var_3) {
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

function gesture_coinflipthink(var_0) {
  self endon("clearGesture");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self notify("gesture_coinFlipThink()");
  self endon("gesture_coinFlipThink()");

  for(;;) {
    self waittill("used_cosmetic_gesture");

    for(;;) {
      if(!self isgestureplaying(var_0)) {
        break;
      }

      waitframe();
    }

    thread gesture_resetcoinflipgesture();
  }
}

function gesture_resetcoinflipgesture() {
  cleargesture();
  givegesture("ges_plyr_gesture050");
}

function getbodymodel() {
  if(!isPlayer(self) || isai(self)) {
    return undefined;
  }

  var_0 = self getplayerdata(level.loadoutsgroup, "squadMembers", "body");
  return tablelookupbyrow("mp/cac/bodies.csv", var_0, 1);
}

function haschangedarchetype() {
  if(isDefined(self.changedarchetypeinfo)) {
    if(!isDefined(self.lastarchetypeinfo)) {
      return true;
    }

    if(self.changedarchetypeinfo != self.lastarchetypeinfo) {
      return true;
    }
  }

  return false;
}

function monitorcontextualcallout() {
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
  cleargesture();

  for(;;) {
    self waittill("activateGesture");
    processcontext();
  }
}

function processcontext() {
  var_0 = self getEye();
  var_1 = self getplayerangles();
  var_2 = anglesToForward(var_1);
  var_3 = cos(10);
  var_4 = undefined;
  var_5 = undefined;
  var_6 = [];

  if(isDefined(self.engstructks)) {
    foreach(var_8 in self.engstructks.outlinedents) {
      var_6 = var_8;
    }
  }

  if(isDefined(self.locationmarking_structveh)) {
    foreach(var_8 in self.locationmarking_structveh.outlinedents) {
      var_6 = var_8;
    }
  }

  if(isDefined(self.locationmarking_structeqp)) {
    foreach(var_8 in self.locationmarking_structeqp.outlinedents) {
      var_6 = var_8;
    }
  }

  foreach(var_8 in var_6) {
    var_15 = vectordot(var_2, vectorNormalize(var_8.origin - var_0));

    if(!isDefined(var_4) || var_4 < var_15) {
      var_4 = var_15;
      var_5 = var_8;
    }
  }

  if(isDefined(var_5) && var_4 > var_3) {
    if(isDefined(var_5.vehicle)) {
      var_5 = var_5.vehicle;
    }

    thread applyoutlinecalloutsource(var_5);
    return;
  }

  if(isDefined(level.gamemodegesturecalloutassign) && self thread[[level.gamemodegesturecalloutassign]]()) {
    return;
  }

  var_17 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle", "physicscontents_player", "physicscontents_actor", "physicscontents_glass", "physicscontents_itemclip"];
  var_18 = physics_createcontents(var_17);
  var_19 = var_0 + var_2 * 10000;
  var_20 = scripts\engine\trace::sphere_trace(var_0, var_19, 0.1, self, var_18, 0);

  if(var_20["fraction"] < 0.99) {
    thread markworldposition(var_20["position"]);
    return;
  }
}

function markworldposition(var_0) {
  self.worldmarkerpos = var_0;

  if(!isDefined(self.worldmarkerid)) {
    self.worldmarkerid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

    if(self.worldmarkerid != -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(self.worldmarkerid, "invisible", var_0, "icon_waypoint_marker");
      scripts\mp\objidpoolmanager::objective_teammask_single(self.worldmarkerid, self.team);
      scripts\mp\objidpoolmanager::update_objective_setbackground(self.worldmarkerid, 1);
      scripts\mp\objidpoolmanager::objective_set_play_intro(self.worldmarkerid, 0);
      scripts\mp\objidpoolmanager::objective_set_play_outro(self.worldmarkerid, 0);
    } else {
      self.worldmarkerid = undefined;
      return;
    }
  } else {
    scripts\mp\objidpoolmanager::update_objective_position(self.worldmarkerid, var_0);
  }

  var_1 = self.worldmarkerid;
  self notify("markWorldPosition");
  self endon("markWorldPosition");
  scripts\mp\objidpoolmanager::objective_set_pulsate(var_1, 1);
  wait 3;
  scripts\mp\objidpoolmanager::objective_set_pulsate(var_1, 0);
  wait 5;
  scripts\mp\objidpoolmanager::returnobjectiveid(var_1);
  self.worldmarkerid = undefined;
  self.worldmarkerpos = undefined;
}

function applyoutlinecalloutsource(var_0) {
  if(!isDefined(var_0.outlinecalloutsource)) {
    var_0.outlinecalloutsource = [];
  }

  foreach(var_2 in var_0.outlinecalloutsource) {
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

  var_0.outlinecalloutsource[var_0.outlinecalloutsource.size] = self;
  var_6 = var_0;
  var_8 = 0;

  if(isDefined(var_0.turret)) {
    var_7 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineEnableForTeam")) {
      var_7 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineEnableForTeam")]](var_0.turret, self.team, "outline_nodepth_red", "perk_superior");
    }

    var_6 = var_0.turret;
    var_8 = 1;
  }

  if(var_8) {
    thread processtimeout(var_0, self);
    return;
  }
}

function processtimeout(var_0, var_1) {
  var_0 endon("disconnect");
  self endon("death");
  var_2 = 30;
  wait var_2;

  for(var_3 = 0; var_3 < self.outlinecalloutsource.size; var_3++) {
    if(self.outlinecalloutsource[var_3] == var_0) {
      self.outlinecalloutsource[var_3] = undefined;
    }
  }

  foreach(var_5 in var_1) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineDisable")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineDisable")]](var_6, var_5);
    }
  }
}

function processcalloutdeath(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }

  if(!isDefined(var_0.outlinecalloutsource)) {
    return;
  }

  foreach(var_3 in var_0.outlinecalloutsource) {
    if(!isDefined(var_3)) {
      continue;
    }

    if(var_3 == var_1) {
      continue;
    }

    if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var_3, var_1))) {
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

function applygamemodecallout(var_0, var_1, var_2) {
  self endon("disconnect");

  if(isDefined(self.gamemodecalloutent)) {
    if(self.gamemodecalloutent == var_0) {
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

  self.gamemodecallouttime = gettime();
  self.gamemodecalloutent = var_0;
  var_5 = undefined;

  if(isDefined(var_0.outlineent)) {
    var_5 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineEnableForTeam")) {
      var_5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineEnableForTeam")]](var_0.outlineent, self.team, "outline_nodepth_red", "perk_superior");
    }
  }

  foreach(var_7 in level.players) {
    if(var_7.team != self.team) {
      continue;
    }

    var_7 iprintlnbold(var_1);
  }

  thread waittillobjectiveevent(var_5, var_0, var_2);
  thread waittillobjectivereplaced(var_5, var_0, var_2);
  var_9 = 30;
  scripts\engine\utility::waittill_notify_or_timeout("callout_processed_" + var_2, var_9);
  self notify("callout_timeout_" + var_2);

  if(isDefined(var_0.outlineent)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineDisable")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineDisable")]](var_5, var_0.outlineent);
    }
  }

  self.gamemodecalloutent = undefined;
}

function waittillobjectiveevent(var_0, var_1, var_2) {
  self endon("callout_timeout_" + var_2);
  self endon("gamemode_callout_replaced");
  self endon("disconnect");
  var_3 = self.team;

  for(;;) {
    var_1 waittill(var_2, var_4);
    var_5 = 0;

    if(isDefined(level.gamemodegesturecalloutverify)) {
      var_5 = self[[level.gamemodegesturecalloutverify]](var_2, var_4);
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

      if(isDefined(var_1.outlineent)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineDisable")) {
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineDisable")]](var_0, var_1.outlineent);
        }
      }

      self notify("callout_processed_" + var_2);
      break;
    }
  }
}

function waittillobjectivereplaced(var_0, var_1, var_2) {
  self endon("callout_timeout_" + var_2);
  self endon("callout_processed_" + var_2);
  self endon("disconnect");
  self waittill("gamemode_callout_replaced");

  if(isDefined(var_1.outlineent)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineDisable")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineDisable")]](var_0, var_1.outlineent);
      return;
    }

    return;
  }
}

function ref_13850() {
  if(level.mapname == "mp_hackney_yard" || level.mapname == "mp_spear_pm" || level.mapname == "mp_runner_pm" || level.mapname == "mp_cave") {
    self setscriptablepartstate("watchVFXPlayer", "holoWatchOnNight");
    self setclientomnvar("ui_pet_watch_state", 1);
  } else {
    self setscriptablepartstate("watchVFXPlayer", "holoWatchOn");
    self setclientomnvar("ui_pet_watch_state", 0);
  }

  thread ref_125d2();
}

function ref_13851() {
  if(level.mapname == "mp_hackney_yard" || level.mapname == "mp_spear_pm" || level.mapname == "mp_runner_pm" || level.mapname == "mp_cave") {
    self setscriptablepartstate("watchVFXPlayer", "holoWatchOnNight2");
    self setclientomnvar("ui_pet_watch_state", 1);
  } else {
    self setscriptablepartstate("watchVFXPlayer", "holoWatchOn2");
    self setclientomnvar("ui_pet_watch_state", 0);
  }

  thread ref_125d2();
}

function ref_13852() {
  if(level.mapname == "mp_hackney_yard" || level.mapname == "mp_spear_pm" || level.mapname == "mp_runner_pm" || level.mapname == "mp_cave") {
    self setscriptablepartstate("watchVFXPlayer", "holoWatchOnNight3");
    self setclientomnvar("ui_pet_watch_state", 1);
  } else {
    self setscriptablepartstate("watchVFXPlayer", "holoWatchOn3");
    self setclientomnvar("ui_pet_watch_state", 0);
  }

  thread ref_125d2();
}

function ref_125d2() {
  self notify("playerHoloWatchSkydive");
  self endon("playerHoloWatchSkydive");

  for(;;) {
    scripts\engine\utility::ref_143a6("skydive_deployparachute", "skydive_end", "skydive_beginfreefall");
    thread ref_13e1a();
  }
}

function ref_13838() {
  if(istrue(self.convoy4_mortar_guys)) {
    return;
  }

  self setscriptablepartstate("watchVFXPlayer", "bluntWatchOn");
  self setclientomnvar("ui_pet_watch_state", 0);
  self method_87a4(4, 20, 1);
  self.convoy4_mortar_guys = 1;
  thread convoy4_roof_jugg();
}

function convoy4_roof_jugg() {
  self endon("disconnect");
  self endon("game_ended");
  wait 4.2;
  self.convoy4_mortar_guys = undefined;
  self setscriptablepartstate("watchVFXPlayer", "off");

  if(isDefined(self.accessorylogic)) {
    self method_87a5();
    return;
  }
}

function ref_13e1a() {
  self notify("tryReenableScriptableVFX");
  self endon("tryReenableScriptableVFX");
  self endon("death_or_disconnect");
  self setscriptablepartstate("watchVFXPlayer", "off");
  var_0 = isDefined(self.accessorylogic) && self.accessorylogic == "holo";
  var_1 = isDefined(self.accessorylogic) && self.accessorylogic == "holo2";
  var_2 = isDefined(self.accessorylogic) && self.accessorylogic == "holo3";

  if(var_0) {
    wait 0.2;
    var_3 = self hasweapon("iw8_acc_weapon_watch_2+iw8_acc_attach_face_digital_ag") || self hasweapon("iw8_acc_weapon_watch_2+iw8_acc_attach_face_digital_ag_big") || self hasweapon("iw8_acc_weapon_watch_2+iw8_acc_attach_face_digital_ag_female") || self hasweapon("t9_acc_weapon_watch_3+t9_acc_attach_face_t9holographic_rank") || self hasweapon("t9_acc_weapon_watch_3+t9_acc_attach_face_t9holographic_rank_big") || self hasweapon("t9_acc_weapon_watch_3+t9_acc_attach_face_t9holographic_rank_female");

    if(var_3 && (!isDefined(self.ref_13416) || !istrue(self.ref_13416))) {
      if(var_3) {
        ref_13850();
        return;
      }

      return;
    }

    return;
  }

  if(var_1) {
    wait 0.2;
    var_4 = self hasweapon("iw8_acc_weapon_watch_2+iw8_acc_attach_face_digital_ag_b") || self hasweapon("iw8_acc_weapon_watch_2+iw8_acc_attach_face_digital_ag_b_big") || self hasweapon("iw8_acc_weapon_watch_2+iw8_acc_attach_face_digital_ag_b_female");

    if(var_4 && (!isDefined(self.ref_13416) || !istrue(self.ref_13416))) {
      if(var_4) {
        ref_13851();
        return;
      }

      return;
    }

    return;
  }

  if(var_2) {
    wait 0.2;
    var_5 = self hasweapon("t9_acc_weapon_watch_3+t9_acc_attach_face_t9digital_holographic") || self hasweapon("t9_acc_weapon_watch_3+t9_acc_attach_face_t9digital_holographic_big") || self hasweapon("t9_acc_weapon_watch_3+t9_acc_attach_face_t9digital_holographic_female") || self hasweapon("t9_acc_weapon_watch_3+t9_acc_attach_face_t9digital_egyptian_fire") || self hasweapon("t9_acc_weapon_watch_3+t9_acc_attach_face_t9digital_egyptian_fire_big") || self hasweapon("t9_acc_weapon_watch_3+t9_acc_attach_face_t9digital_egyptian_fire_female");

    if(var_5 && (!isDefined(self.ref_13416) || !istrue(self.ref_13416))) {
      if(var_5) {
        ref_13852();
        return;
      }

      return;
    }

    return;
  }
}

function watchradialgestureactivation(var_0, var_1) {
  if((level.gametype == "br" || level.gametype == "dmz" || level.gametype == "rat_race" || level.gametype == "gold_war") && self hasweapon("armor_plate_deploy_mp")) {
    return;
  }

  if(var_0 == "radial_menu_selection_gesture") {
    var_2 = getgesturedatabyindex(var_1);

    if(isDefined(var_2)) {
      if(var_2 == "iw8_ges_plyr_gesture024") {
        if(!isDefined(self.ref_13416)) {
          self.ref_13416 = 0;
        }

        self.ref_13416 = !self.ref_13416;
        self setclientomnvar("ui_smart_watch_interact", self.ref_13416);

        if(isDefined(self.accessorylogic)) {
          if(self.accessorylogic == "holo") {
            if(!self.ref_13416) {
              ref_13850();
            } else {
              self setscriptablepartstate("watchVFXPlayer", "off");
            }
          } else if(self.accessorylogic == "holo2") {
            if(!self.ref_13416) {
              ref_13851();
            } else {
              self setscriptablepartstate("watchVFXPlayer", "off");
            }
          } else if(self.accessorylogic == "holo3") {
            if(!self.ref_13416) {
              ref_13852();
            } else {
              self setscriptablepartstate("watchVFXPlayer", "off");
            }
          } else if(self.accessorylogic == "pet_go") {
            scripts\cp_mp\utility\callback_group::ref_144e1();
          }
        }
      } else if(var_2 == "iw8_ges_plyr_gesture023") {
        if(!isDefined(self.ref_14496)) {
          self.ref_14496 = 0;
        }

        self.ref_14496 = !self.ref_14496;
        self setclientomnvar("ui_smart_watch_check", self.ref_14496);

        if(isDefined(self.accessorylogic)) {
          if(self.accessorylogic == "blunt") {
            ref_13838();
          }
        }
      }

      var_3 = getcompleteweaponname(var_2);

      if(isDefined(var_3) && !nullweapon(var_3)) {
        var_4 = remapobjkeysandscriptlabels(var_1);

        if((self.operatorcustomization.voice == "jjr" || self.operatorcustomization.voice == "mcc") && isDefined(var_4) && issubstr(var_4, "mtx_gst_taunt")) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound")) {
            level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](self, "ges_mtx_t9_taunt_all");
          }
        } else if(isDefined(var_4) && var_4 != "") {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound")) {
            level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](self, var_4);
          }
        }

        scripts\cp\vehicles\vehicle_compass_cp::ongesture();
        watchradialgesture(var_3);
        return;
      }

      return;
    }

    return;
  }

  if(var_2 == "radial_menu_selection_spray") {
    var_3 = getcompleteweaponname("iw8_ges_plyr_spray");

    if(isDefined(var_3) && !nullweapon(var_3)) {
      thread ref_144f7(var_3);
      watchradialgesture(var_3);
      return;
    }

    return;
  }
}

function ref_144f7(var_0) {
  self endon("death");
  self endon("disconnect");
  self notify("watchSprayGestureDoSprayEvent");
  self endon("watchSprayGestureDoSprayEvent");
  var_1 = gettime() + 200;

  while(gettime() < var_1) {
    waitframe();

    if(self isgestureplaying("iw8_ges_plyr_spray")) {
      self sprayevent(var_0);
      scripts\cp\vehicles\vehicle_compass_cp::ref_1208f();
      return;
    }
  }
}

function watchradialgesture(var_0) {
  self giveandfireoffhand(var_0);
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

  cleargesture();
  waitframe();
  self.gestureweapon = var_0.basename;
}
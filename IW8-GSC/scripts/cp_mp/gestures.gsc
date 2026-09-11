/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\gestures.gsc
***********************************************/

function init() {
  level.gestureinfo = [];
  level.gestureinfobyindex = [];
  level.predictandclearintermissionstreaming = [];

  for(var0 = 0;; var0++) {
    var1 = tablelookupbyrow("mp/gesturetable.csv", var0, 0);

    if(!isDefined(var1) || var1 == "") {
      break;
    }

    var2 = tablelookupbyrow("mp/gesturetable.csv", var0, 1);

    if(!isDefined(var2) || var2 == "") {
      break;
    }

    var3 = int(tablelookupbyrow("mp/gesturetable.csv", var0, 8));

    if(isDefined(var3)) {
      level.gestureinfobyindex[var3] = var2;
    }

    var4 = tablelookupbyrow("mp/gesturetable.csv", var0, 15);

    if(isDefined(var3) && isDefined(var4) && var4 != "") {
      level.predictandclearintermissionstreaming[var3] = var4;
    }

    level.gestureinfo[var1] = var2;
  }

  level.rockpaperscissors = ["ges_plyr_gesture043", "ges_plyr_gesture114", "ges_plyr_gesture115"];
}

function getgesturedata(var0) {
  if(isbot(self) && var0 == "devilhorns_mp") {
    var0 = "gesture009";
  }

  return level.gestureinfo[var0];
}

function getgesturedatabyindex(var0) {
  return level.gestureinfobyindex[var0];
}

function remapobjkeysandscriptlabels(var0) {
  return level.predictandclearintermissionstreaming[var0];
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

function givegesture(var0) {
  if(scripts\engine\utility::is_player_gamepad_enabled()) {
    self setactionslot(1, "taunt");
  } else {
    self setactionslot(7, "taunt");
  }

  scripts\cp_mp\utility\inventory_utility::_giveweapon(var0);
  self assignweaponoffhandtaunt(var0);
  self.gestureweapon = var0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "lpcFeatureGated")) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "lpcFeatureGated")]]()) {
      switch (var0) {
        case "ges_plyr_gesture043":
          thread gesture_rockpaperscissorsthink();
          var0 = gesture_pickrockpaperscissors();
          break;
        case "ges_plyr_gesture050":
          var1 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "ges_plyr_gesture050", "ges_plyr_gesture052");
          thread gesture_coinflipthink(var1);
          var0 = var1;
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
  var0 = scripts\engine\utility::is_player_gamepad_enabled();

  for(;;) {
    if(isDefined(self.disabledgesture) && self.disabledgesture > 0) {
      waitframe();
      continue;
    }

    var1 = scripts\engine\utility::is_player_gamepad_enabled();

    if(var1 != var0) {
      if(var0) {
        self setactionslot(1, "");
        self setactionslot(7, "taunt");
      } else {
        self setactionslot(1, "taunt");
        self setactionslot(7, "");
      }
    }

    var0 = var1;
    waitframe();
  }
}

function gesture_manage3rdperson() {
  self endon("disconnect");

  for(;;) {
    self waittill("offhand_pullback", var0);
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
    var0 = undefined;

    if(scripts\mp\flags::gameflag("prematch_done") && getdvarint("scr_test_rps", 0) == 0) {
      self[[level.showerrormessagefunc]]("MP_INGAME_ONLY/RPS_TOO_LATE");
      var0 = 0;
    } else {
      self[[level.showerrormessagefunc]]("MP_INGAME_ONLY/RPS_START");
      var0 = 1;
    }

    self waittill("offhand_fired");

    if(var0) {
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
  var0 = gesture_getrockpaperscissorsplayers();

  if(isDefined(var0)) {
    var1 = gesture_determinerockpaperscissorswinner(self, self.gestureweapon, var0, var0.rockpaperscissorschoice);

    if(isDefined(var1)) {
      var1[[level.showerrormessagefunc]]("MP_INGAME_ONLY/RPS_WIN");
      var1 thread[[level.givemidmatchawardfunc]]("rock_paper_scissors_win");
      var2 = scripts\engine\utility::ter_op(var1 == self, var0, self);
      var2[[level.showerrormessagefunc]]("MP_INGAME_ONLY/RPS_LOSE");
    } else {
      self[[level.showerrormessagefunc]]("MP_INGAME_ONLY/RPS_DRAW");
      var0[[level.showerrormessagefunc]]("MP_INGAME_ONLY/RPS_DRAW");
    }

    var0 notify("rockPaperScissorsFinished");
    var0.rockpaperscissorschoice = undefined;
    return;
  }

  self.rockpaperscissorschoice = self.gestureweapon;
  wait 3;
  self.rockpaperscissorschoice = undefined;
}

function gesture_getrockpaperscissorsplayers() {
  var0 = anglesToForward(self getplayerangles());
  var1 = scripts\common\utility::playersinsphere(self.origin, 500);

  foreach(var3 in var1) {
    if(!isDefined(var3) || var3 == self) {
      continue;
    }

    if(!isDefined(var3.rockpaperscissorschoice)) {
      continue;
    }

    var4 = var3.origin - self.origin;
    var4 = vectorNormalize(var4);
    var5 = vectordot(var4, var0);

    if(var5 < 0.707107) {
      continue;
    }

    var6 = anglesToForward(var3 getplayerangles());
    var7 = var4 * -1;
    var8 = vectordot(var7, var6);

    if(var8 < 0.707107) {
      continue;
    }

    return var3;
  }
}

function gesture_determinerockpaperscissorswinner(var0, var1, var2, var3) {
  if(var1 == var3) {
    return undefined;
  }

  switch (var1) {
    case "ges_plyr_gesture043":
      return scripts\engine\utility::ter_op(var3 == "ges_plyr_gesture114", var2, var0);
    case "ges_plyr_gesture114":
      return scripts\engine\utility::ter_op(var3 == "ges_plyr_gesture115", var2, var0);
    case "ges_plyr_gesture115":
      return scripts\engine\utility::ter_op(var3 == "ges_plyr_gesture043", var2, var0);
  }
}

function gesture_coinflipthink(var0) {
  self endon("clearGesture");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self notify("gesture_coinFlipThink()");
  self endon("gesture_coinFlipThink()");

  for(;;) {
    self waittill("used_cosmetic_gesture");

    for(;;) {
      if(!self isgestureplaying(var0)) {
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

  var0 = self getplayerdata(level.loadoutsgroup, "squadMembers", "body");
  return tablelookupbyrow("mp/cac/bodies.csv", var0, 1);
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
  var0 = self getEye();
  var1 = self getplayerangles();
  var2 = anglesToForward(var1);
  var3 = cos(10);
  var4 = undefined;
  var5 = undefined;
  var6 = [];

  if(isDefined(self.engstructks)) {
    foreach(var8 in self.engstructks.outlinedents) {
      var6 = var8;
    }
  }

  if(isDefined(self.locationmarking_structveh)) {
    foreach(var8 in self.locationmarking_structveh.outlinedents) {
      var6 = var8;
    }
  }

  if(isDefined(self.locationmarking_structeqp)) {
    foreach(var8 in self.locationmarking_structeqp.outlinedents) {
      var6 = var8;
    }
  }

  foreach(var8 in var6) {
    var15 = vectordot(var2, vectorNormalize(var8.origin - var0));

    if(!isDefined(var4) || var4 < var15) {
      var4 = var15;
      var5 = var8;
    }
  }

  if(isDefined(var5) && var4 > var3) {
    if(isDefined(var5.vehicle)) {
      var5 = var5.vehicle;
    }

    thread applyoutlinecalloutsource(var5);
    return;
  }

  if(isDefined(level.gamemodegesturecalloutassign) && self thread[[level.gamemodegesturecalloutassign]]()) {
    return;
  }

  var17 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle", "physicscontents_player", "physicscontents_actor", "physicscontents_glass", "physicscontents_itemclip"];
  var18 = physics_createcontents(var17);
  var19 = var0 + var2 * 10000;
  var20 = scripts\engine\trace::sphere_trace(var0, var19, 0.1, self, var18, 0);

  if(var20["fraction"] < 0.99) {
    thread markworldposition(var20["position"]);
    return;
  }
}

function markworldposition(var0) {
  self.worldmarkerpos = var0;

  if(!isDefined(self.worldmarkerid)) {
    self.worldmarkerid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

    if(self.worldmarkerid != -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(self.worldmarkerid, "invisible", var0, "icon_waypoint_marker");
      scripts\mp\objidpoolmanager::objective_teammask_single(self.worldmarkerid, self.team);
      scripts\mp\objidpoolmanager::update_objective_setbackground(self.worldmarkerid, 1);
      scripts\mp\objidpoolmanager::objective_set_play_intro(self.worldmarkerid, 0);
      scripts\mp\objidpoolmanager::objective_set_play_outro(self.worldmarkerid, 0);
    } else {
      self.worldmarkerid = undefined;
      return;
    }
  } else {
    scripts\mp\objidpoolmanager::update_objective_position(self.worldmarkerid, var0);
  }

  var1 = self.worldmarkerid;
  self notify("markWorldPosition");
  self endon("markWorldPosition");
  scripts\mp\objidpoolmanager::objective_set_pulsate(var1, 1);
  wait 3;
  scripts\mp\objidpoolmanager::objective_set_pulsate(var1, 0);
  wait 5;
  scripts\mp\objidpoolmanager::returnobjectiveid(var1);
  self.worldmarkerid = undefined;
  self.worldmarkerpos = undefined;
}

function applyoutlinecalloutsource(var0) {
  if(!isDefined(var0.outlinecalloutsource)) {
    var0.outlinecalloutsource = [];
  }

  foreach(var2 in var0.outlinecalloutsource) {
    if(var2 == self) {
      return;
    }
  }

  var4 = "assist_ping";
  var5 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "getScoreInfoValue")) {
    var5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "getScoreInfoValue")]](var4);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "giveRankXP")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "giveRankXP")]](var4, var5);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "giveSuperPoints")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "giveSuperPoints")]](var5);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "scoreEventPopup")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "scoreEventPopup")]](var4);
  }

  var6 = [];
  var7 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineEnableForTeam")) {
    var7 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineEnableForTeam")]](var0, self.team, "outline_nodepth_red", "perk_superior");
  }

  var0.outlinecalloutsource[var0.outlinecalloutsource.size] = self;
  var6 = var0;
  var8 = 0;

  if(isDefined(var0.turret)) {
    var7 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineEnableForTeam")) {
      var7 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineEnableForTeam")]](var0.turret, self.team, "outline_nodepth_red", "perk_superior");
    }

    var6 = var0.turret;
    var8 = 1;
  }

  if(var8) {
    thread processtimeout(var0, self);
    return;
  }
}

function processtimeout(var0, var1) {
  var0 endon("disconnect");
  self endon("death");
  var2 = 30;
  wait var2;

  for(var3 = 0; var3 < self.outlinecalloutsource.size; var3++) {
    if(self.outlinecalloutsource[var3] == var0) {
      self.outlinecalloutsource[var3] = undefined;
    }
  }

  foreach(var5 in var1) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineDisable")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineDisable")]](var6, var5);
    }
  }
}

function processcalloutdeath(var0, var1) {
  if(!isDefined(var0) || !isDefined(var1)) {
    return;
  }

  if(!isDefined(var0.outlinecalloutsource)) {
    return;
  }

  foreach(var3 in var0.outlinecalloutsource) {
    if(!isDefined(var3)) {
      continue;
    }

    if(var3 == var1) {
      continue;
    }

    if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var3, var1))) {
      continue;
    }

    var4 = "assist_marked";
    var5 = 0;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "getScoreInfoValue")) {
      var5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "getScoreInfoValue")]](var4);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "giveRankXP")) {
      var3 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "giveRankXP")]](var4, var5);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "giveSuperPoints")) {
      var3 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "giveSuperPoints")]](var5);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "scoreEventPopup")) {
      var3 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "scoreEventPopup")]](var4);
    }

    var5 = 25;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "giveRankXP")) {
      var1 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "giveRankXP")]](var4, var5);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "giveSuperPoints")) {
      var1 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "giveSuperPoints")]](var5);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "scoreEventPopup")) {
      var1 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "scoreEventPopup")]](var4);
    }
  }
}

function applygamemodecallout(var0, var1, var2) {
  self endon("disconnect");

  if(isDefined(self.gamemodecalloutent)) {
    if(self.gamemodecalloutent == var0) {
      return;
    }

    self notify("gamemode_callout_replaced");
  } else {
    var3 = "assist_ping";
    var4 = 0;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "getScoreInfoValue")) {
      var4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "getScoreInfoValue")]](var3);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "giveRankXP")) {
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "giveRankXP")]](var3, var4);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "giveSuperPoints")) {
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "giveSuperPoints")]](var4);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "scoreEventPopup")) {
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "scoreEventPopup")]](var3);
    }
  }

  self.gamemodecallouttime = gettime();
  self.gamemodecalloutent = var0;
  var5 = undefined;

  if(isDefined(var0.outlineent)) {
    var5 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineEnableForTeam")) {
      var5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineEnableForTeam")]](var0.outlineent, self.team, "outline_nodepth_red", "perk_superior");
    }
  }

  foreach(var7 in level.players) {
    if(var7.team != self.team) {
      continue;
    }

    var7 iprintlnbold(var1);
  }

  thread waittillobjectiveevent(var5, var0, var2);
  thread waittillobjectivereplaced(var5, var0, var2);
  var9 = 30;
  scripts\engine\utility::waittill_notify_or_timeout("callout_processed_" + var2, var9);
  self notify("callout_timeout_" + var2);

  if(isDefined(var0.outlineent)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineDisable")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineDisable")]](var5, var0.outlineent);
    }
  }

  self.gamemodecalloutent = undefined;
}

function waittillobjectiveevent(var0, var1, var2) {
  self endon("callout_timeout_" + var2);
  self endon("gamemode_callout_replaced");
  self endon("disconnect");
  var3 = self.team;

  for(;;) {
    var1 waittill(var2, var4);
    var5 = 0;

    if(isDefined(level.gamemodegesturecalloutverify)) {
      var5 = self[[level.gamemodegesturecalloutverify]](var2, var4);
    }

    if(var5) {
      var6 = "assist_marked";
      var7 = 0;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "getScoreInfoValue")) {
        var7 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "getScoreInfoValue")]](var6);
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "giveRankXP")) {
        self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "giveRankXP")]](var6, var7);
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "giveSuperPoints")) {
        self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "giveSuperPoints")]](var7);
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "scoreEventPopup")) {
        self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "scoreEventPopup")]](var6);
      }

      var7 = 25;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "giveRankXP")) {
        var4 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "giveRankXP")]](var6, var7);
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "giveSuperPoints")) {
        var4 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "giveSuperPoints")]](var7);
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "scoreEventPopup")) {
        var4 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "scoreEventPopup")]](var6);
      }

      if(isDefined(var1.outlineent)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineDisable")) {
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineDisable")]](var0, var1.outlineent);
        }
      }

      self notify("callout_processed_" + var2);
      break;
    }
  }
}

function waittillobjectivereplaced(var0, var1, var2) {
  self endon("callout_timeout_" + var2);
  self endon("callout_processed_" + var2);
  self endon("disconnect");
  self waittill("gamemode_callout_replaced");

  if(isDefined(var1.outlineent)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineDisable")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineDisable")]](var0, var1.outlineent);
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
  var0 = isDefined(self.accessorylogic) && self.accessorylogic == "holo";
  var1 = isDefined(self.accessorylogic) && self.accessorylogic == "holo2";
  var2 = isDefined(self.accessorylogic) && self.accessorylogic == "holo3";

  if(var0) {
    wait 0.2;
    var3 = self hasweapon("iw8_acc_weapon_watch_2+iw8_acc_attach_face_digital_ag") || self hasweapon("iw8_acc_weapon_watch_2+iw8_acc_attach_face_digital_ag_big") || self hasweapon("iw8_acc_weapon_watch_2+iw8_acc_attach_face_digital_ag_female") || self hasweapon("t9_acc_weapon_watch_3+t9_acc_attach_face_t9holographic_rank") || self hasweapon("t9_acc_weapon_watch_3+t9_acc_attach_face_t9holographic_rank_big") || self hasweapon("t9_acc_weapon_watch_3+t9_acc_attach_face_t9holographic_rank_female");

    if(var3 && (!isDefined(self.ref_13416) || !istrue(self.ref_13416))) {
      if(var3) {
        ref_13850();
        return;
      }

      return;
    }

    return;
  }

  if(var1) {
    wait 0.2;
    var4 = self hasweapon("iw8_acc_weapon_watch_2+iw8_acc_attach_face_digital_ag_b") || self hasweapon("iw8_acc_weapon_watch_2+iw8_acc_attach_face_digital_ag_b_big") || self hasweapon("iw8_acc_weapon_watch_2+iw8_acc_attach_face_digital_ag_b_female");

    if(var4 && (!isDefined(self.ref_13416) || !istrue(self.ref_13416))) {
      if(var4) {
        ref_13851();
        return;
      }

      return;
    }

    return;
  }

  if(var2) {
    wait 0.2;
    var5 = self hasweapon("t9_acc_weapon_watch_3+t9_acc_attach_face_t9digital_holographic") || self hasweapon("t9_acc_weapon_watch_3+t9_acc_attach_face_t9digital_holographic_big") || self hasweapon("t9_acc_weapon_watch_3+t9_acc_attach_face_t9digital_holographic_female") || self hasweapon("t9_acc_weapon_watch_3+t9_acc_attach_face_t9digital_egyptian_fire") || self hasweapon("t9_acc_weapon_watch_3+t9_acc_attach_face_t9digital_egyptian_fire_big") || self hasweapon("t9_acc_weapon_watch_3+t9_acc_attach_face_t9digital_egyptian_fire_female");

    if(var5 && (!isDefined(self.ref_13416) || !istrue(self.ref_13416))) {
      if(var5) {
        ref_13852();
        return;
      }

      return;
    }

    return;
  }
}

function watchradialgestureactivation(var0, var1) {
  if((level.gametype == "br" || level.gametype == "dmz" || level.gametype == "rat_race" || level.gametype == "gold_war") && self hasweapon("armor_plate_deploy_mp")) {
    return;
  }

  if(var0 == "radial_menu_selection_gesture") {
    var2 = getgesturedatabyindex(var1);

    if(isDefined(var2)) {
      if(var2 == "iw8_ges_plyr_gesture024") {
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
      } else if(var2 == "iw8_ges_plyr_gesture023") {
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

      var3 = getcompleteweaponname(var2);

      if(isDefined(var3) && !nullweapon(var3)) {
        var4 = remapobjkeysandscriptlabels(var1);

        if((self.operatorcustomization.voice == "jjr" || self.operatorcustomization.voice == "mcc") && isDefined(var4) && issubstr(var4, "mtx_gst_taunt")) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound")) {
            level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](self, "ges_mtx_t9_taunt_all");
          }
        } else if(isDefined(var4) && var4 != "") {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound")) {
            level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](self, var4);
          }
        }

        scripts\cp\vehicles\vehicle_compass_cp::ongesture();
        watchradialgesture(var3);
        return;
      }

      return;
    }

    return;
  }

  if(var2 == "radial_menu_selection_spray") {
    var3 = getcompleteweaponname("iw8_ges_plyr_spray");

    if(isDefined(var3) && !nullweapon(var3)) {
      thread ref_144f7(var3);
      watchradialgesture(var3);
      return;
    }

    return;
  }
}

function ref_144f7(var0) {
  self endon("death");
  self endon("disconnect");
  self notify("watchSprayGestureDoSprayEvent");
  self endon("watchSprayGestureDoSprayEvent");
  var1 = gettime() + 200;

  while(gettime() < var1) {
    waitframe();

    if(self isgestureplaying("iw8_ges_plyr_spray")) {
      self sprayevent(var0);
      scripts\cp\vehicles\vehicle_compass_cp::ref_1208f();
      return;
    }
  }
}

function watchradialgesture(var0) {
  self giveandfireoffhand(var0);
  var1 = gettime() + 5000;

  while(gettime() < var1) {
    if(!self hasweapon(var0)) {
      break;
    }

    waitframe();
  }

  if(self hasweapon(var0)) {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var0);
  }

  cleargesture();
  waitframe();
  self.gestureweapon = var0.basename;
}
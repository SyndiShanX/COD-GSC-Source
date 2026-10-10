/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\gestures.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\objidpoolmanager;
#namespace gestures;

function init() {
  level.gestureinfo = [];
  level.gestureinfobyindex = [];
  val::register("gesture", 1, 0, "$self", &function_9e06fa9c92578f0d, "$value");

  for(row = 0; true; row++) {
    ref = tablelookupbyrow("mp/gesturetable.csv", row, 0);

    if(!isDefined(ref) || ref == "") {
      break;
    }

    data = tablelookupbyrow("mp/gesturetable.csv", row, 1);

    if(!isDefined(data) || data == "") {
      break;
    }

    index = int(tablelookupbyrow("mp/gesturetable.csv", row, 8));

    if(isDefined(index)) {
      level.gestureinfobyindex[index] = data;
    }

    level.gestureinfo[ref] = data;
  }

  level.rockpaperscissors = ["ges_plyr_gesture043", "ges_plyr_gesture114", "ges_plyr_gesture115"];
}

function getgesturedata(ref) {
  if(isbot(self) && ref == "devilhorns_mp") {
    ref = "gesture009";
  }

  return level.gestureinfo[ref];
}

function getgesturedatabyindex(index) {
  return level.gestureinfobyindex[index];
}

function private function_9e06fa9c92578f0d(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(b_value) {
    if(is_player_gamepad_enabled()) {
      self setactionslot(1, "taunt");
    } else {
      self setactionslot(7, "taunt");
    }

    return;
  }

  if(is_player_gamepad_enabled()) {
    self setactionslot(1, "");
    return;
  }

  self setactionslot(7, "");
}

function cleargesture() {
  self notify("clearGesture");

  if(isDefined(self.gestureweapon) && self.gestureweapon != "none") {
    if(is_player_gamepad_enabled()) {
      self setactionslot(1, "");
    } else {
      self setactionslot(7, "");
    }

    if(self hasweapon(self.gestureweapon)) {
      _takeweapon(self.gestureweapon);
    }

    self.gestureweapon = "none";
  }
}

function givegesture(gestureweapon) {
  assertex(gestureweapon != "<dev string:x1c>", "<dev string:x24>");
  assertex(!isDefined(self.gestureweapon) || self.gestureweapon == "<dev string:x1c>", "<dev string:x54>");

  if(is_player_gamepad_enabled()) {
    self setactionslot(1, "taunt");
  } else {
    self setactionslot(7, "taunt");
  }

  _giveweapon(gestureweapon);
  self assignweaponoffhandtaunt(gestureweapon);
  self.gestureweapon = gestureweapon;

  if(issharedfuncdefined("game", "lpcFeatureGated")) {
    if(![[getsharedfunc("game", "lpcFeatureGated")]]()) {
      switch (gestureweapon) {
        case #"hash_e3d706263fb4a279":
          thread gesture_rockpaperscissorsthink();
          gestureweapon = gesture_pickrockpaperscissors();
          break;
        case #"hash_e3da89263fb7af49":
          newgesture = ter_op(cointoss(), "ges_plyr_gesture050", "ges_plyr_gesture052");
          thread gesture_coinflipthink(newgesture);
          gestureweapon = newgesture;
          break;
      }

      if(!self isconsoleplayer()) {
        thread monitorgamepadswitch();
      }

      thread gesture_manage3rdperson();
    }
  }
}

function monitorgamepadswitch() {
  self endon("clearGesture");
  self endon("disconnect");
  var_cca5d182ecca9e1a = is_player_gamepad_enabled();

  while(true) {
    if(isDefined(self.disabledgesture) && self.disabledgesture > 0) {
      waitframe();
      continue;
    }

    var_6ca54de3e40aec0c = is_player_gamepad_enabled();

    if(var_6ca54de3e40aec0c != var_cca5d182ecca9e1a) {
      if(var_cca5d182ecca9e1a) {
        self setactionslot(1, "");
        self setactionslot(7, "taunt");
      } else {
        self setactionslot(1, "taunt");
        self setactionslot(7, "");
      }
    }

    var_cca5d182ecca9e1a = var_6ca54de3e40aec0c;
    waitframe();
  }
}

function gesture_manage3rdperson() {
  self endon("disconnect");

  while(true) {
    self waittill("offhand_pullback", objweapon);
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

  while(true) {
    self waittill("used_cosmetic_gesture");
    canplay = undefined;

    if(scripts\mp\flags::gameflag("prematch_done") && getdvarint(@ "hash_873992478b2f6deb", 0) == 0) {
      self[[level.showerrormessagefunc]]("MP_INGAME_ONLY/RPS_TOO_LATE");
      canplay = 0;
    } else {
      self[[level.showerrormessagefunc]]("MP_INGAME_ONLY/RPS_START");
      canplay = 1;
    }

    self waittill("offhand_fired");

    if(canplay) {
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
  opponent = gesture_getrockpaperscissorsplayers();

  if(isDefined(opponent)) {
    winner = gesture_determinerockpaperscissorswinner(self, self.gestureweapon, opponent, opponent.rockpaperscissorschoice);

    if(isDefined(winner)) {
      winner[[level.showerrormessagefunc]]("MP_INGAME_ONLY/RPS_WIN");
      winner thread[[level.var_97e29f66f7229f48]]("rock_paper_scissors_win");
      loser = ter_op(winner == self, opponent, self);
      loser[[level.showerrormessagefunc]]("MP_INGAME_ONLY/RPS_LOSE");
    } else {
      self[[level.showerrormessagefunc]]("MP_INGAME_ONLY/RPS_DRAW");
      opponent[[level.showerrormessagefunc]]("MP_INGAME_ONLY/RPS_DRAW");
    }

    opponent notify("rockPaperScissorsFinished");
    opponent.rockpaperscissorschoice = undefined;
    return;
  }

  self.rockpaperscissorschoice = self.gestureweapon;
  wait 3;
  self.rockpaperscissorschoice = undefined;
}

function gesture_getrockpaperscissorsplayers() {
  forward = anglesToForward(self getplayerangles());
  nearplayers = utility::playersinsphere(self.origin, 500);

  foreach(otherplayer in nearplayers) {
    if(!isDefined(otherplayer) || otherplayer == self) {
      continue;
    }

    if(!isDefined(otherplayer.rockpaperscissorschoice)) {
      continue;
    }

    tootherplayer = otherplayer.origin - self.origin;
    tootherplayer = vectorNormalize(tootherplayer);
    var_4a0d170010397660 = vectordot(tootherplayer, forward);

    if(var_4a0d170010397660 < 0.707107) {
      continue;
    }

    otherplayerforward = anglesToForward(otherplayer getplayerangles());
    fromotherplayer = tootherplayer * -1;
    var_a16efa238faeb70f = vectordot(fromotherplayer, otherplayerforward);

    if(var_a16efa238faeb70f < 0.707107) {
      continue;
    }

    return otherplayer;
  }
}

function gesture_determinerockpaperscissorswinner(player1, player1choice, player2, player2choice) {
  if(player1choice == player2choice) {
    return undefined;
  }

  switch (player1choice) {
    case #"hash_e3d706263fb4a279":
      return ter_op(player2choice == "ges_plyr_gesture114", player2, player1);
    case #"hash_eaeaf42643537972":
      return ter_op(player2choice == "ges_plyr_gesture115", player2, player1);
    case #"hash_eaeaf52643537b05":
      return ter_op(player2choice == "ges_plyr_gesture043", player2, player1);
  }
}

function gesture_coinflipthink(gesture) {
  self endon("clearGesture");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self notify("gesture_coinFlipThink()");
  self endon("gesture_coinFlipThink()");

  while(true) {
    self waittill("used_cosmetic_gesture");

    while(true) {
      if(!self isgestureplaying(gesture)) {
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

  if(is_player_gamepad_enabled()) {
    self notifyonplayercommand("activateGesture", "+actionslot 1");
  } else {
    self notifyonplayercommand("activateGesture", "+actionslot 7");
  }

  waitframe();
  cleargesture();

  while(true) {
    self waittill("activateGesture");
    processcontext();
  }
}

function processcontext() {
  startpos = self getEye();
  viewangles = self getplayerangles();
  fwd = anglesToForward(viewangles);
  mindot = cos(10);
  bestdot = undefined;
  bestent = undefined;
  var_69035efa489d7aa8 = [];

  if(isDefined(self.engstructks)) {
    foreach(ent in self.engstructks.outlinedents) {
      var_69035efa489d7aa8[var_69035efa489d7aa8.size] = ent;
    }
  }

  if(isDefined(self.locationmarking_structveh)) {
    foreach(ent in self.locationmarking_structveh.outlinedents) {
      var_69035efa489d7aa8[var_69035efa489d7aa8.size] = ent;
    }
  }

  if(isDefined(self.locationmarking_structeqp)) {
    foreach(ent in self.locationmarking_structeqp.outlinedents) {
      var_69035efa489d7aa8[var_69035efa489d7aa8.size] = ent;
    }
  }

  foreach(ent in var_69035efa489d7aa8) {
    dot = vectordot(fwd, vectorNormalize(ent.origin - startpos));

    if(!isDefined(bestdot) || bestdot < dot) {
      bestdot = dot;
      bestent = ent;
    }
  }

  if(isDefined(bestent) && bestdot > mindot) {
    if(isDefined(bestent.vehicle)) {
      bestent = bestent.vehicle;
    }

    thread applyoutlinecalloutsource(bestent);
    return;
  }

  if(isDefined(level.gamemodegesturecalloutassign) && self thread[[level.gamemodegesturecalloutassign]]()) {
    return;
  }

  content = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip"];
  contentoverride = physics_createcontents(content);
  endpos = startpos + fwd * 10000;
  trace = scripts\engine\trace::sphere_trace(startpos, endpos, 0.1, self, contentoverride, 0);

  if(trace["fraction"] < 0.99) {
    thread markworldposition(trace["position"]);
  }
}

function markworldposition(org) {
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
  } else {
    scripts\mp\objidpoolmanager::update_objective_position(self.worldmarkerid, org);
  }

  objid = self.worldmarkerid;
  self notify("markWorldPosition");
  self endon("markWorldPosition");
  scripts\mp\objidpoolmanager::objective_set_pulsate(objid, 1);
  wait 3;
  scripts\mp\objidpoolmanager::objective_set_pulsate(objid, 0);
  wait 5;
  scripts\mp\objidpoolmanager::returnobjectiveid(objid);
  self.worldmarkerid = undefined;
  self.worldmarkerpos = undefined;
}

function applyoutlinecalloutsource(ent) {
  if(!isDefined(ent.outlinecalloutsource)) {
    ent.outlinecalloutsource = [];
  }

  foreach(player in ent.outlinecalloutsource) {
    if(player == self) {
      return;
    }
  }

  event = "assist_ping";
  points = 0;

  if(issharedfuncdefined("rank", "getScoreInfoValue")) {
    points = [[getsharedfunc("rank", "getScoreInfoValue")]](event);
  }

  if(issharedfuncdefined("rank", "giveRankXP")) {
    self thread[[getsharedfunc("rank", "giveRankXP")]](event, points);
  }

  if(issharedfuncdefined("supers", "giveSuperPoints")) {
    self thread[[getsharedfunc("supers", "giveSuperPoints")]](points);
  }

  if(issharedfuncdefined("rank", "scoreEventPopup")) {
    self thread[[getsharedfunc("rank", "scoreEventPopup")]](event);
  }

  outlines = [];
  id = undefined;

  if(issharedfuncdefined("outline", "outlineEnableForTeam")) {
    id = [[getsharedfunc("outline", "outlineEnableForTeam")]](ent, self.team, "outline_nodepth_red", "perk_superior");
  }

  ent.outlinecalloutsource[ent.outlinecalloutsource.size] = self;
  outlines[id] = ent;
  tempoutline = 0;

  if(isDefined(ent.turret)) {
    id = undefined;

    if(issharedfuncdefined("outline", "outlineEnableForTeam")) {
      id = [[getsharedfunc("outline", "outlineEnableForTeam")]](ent.turret, self.team, "outline_nodepth_red", "perk_superior");
    }

    outlines[id] = ent.turret;
    tempoutline = 1;
  }

  if(tempoutline) {
    ent thread processtimeout(self, outlines);
  }
}

function processtimeout(attacker, outlines) {
  attacker endon("disconnect");
  self endon("death");
  timeout = 30;
  wait timeout;

  for(i = 0; i < self.outlinecalloutsource.size; i++) {
    if(self.outlinecalloutsource[i] == attacker) {
      self.outlinecalloutsource[i] = undefined;
    }
  }

  foreach(id, ent in outlines) {
    if(issharedfuncdefined("outline", "outlineDisable")) {
      [[getsharedfunc("outline", "outlineDisable")]](id, ent);
    }
  }
}

function processcalloutdeath(ent, attacker) {
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

    scoreevent = "assist_marked";
    points = 0;

    if(issharedfuncdefined("rank", "getScoreInfoValue")) {
      points = [[getsharedfunc("rank", "getScoreInfoValue")]](scoreevent);
    }

    if(issharedfuncdefined("rank", "giveRankXP")) {
      player thread[[getsharedfunc("rank", "giveRankXP")]](scoreevent, points);
    }

    if(issharedfuncdefined("supers", "giveSuperPoints")) {
      player thread[[getsharedfunc("supers", "giveSuperPoints")]](points);
    }

    if(issharedfuncdefined("rank", "scoreEventPopup")) {
      player thread[[getsharedfunc("rank", "scoreEventPopup")]](scoreevent);
    }

    points = 25;

    if(issharedfuncdefined("rank", "giveRankXP")) {
      attacker thread[[getsharedfunc("rank", "giveRankXP")]](scoreevent, points);
    }

    if(issharedfuncdefined("supers", "giveSuperPoints")) {
      attacker thread[[getsharedfunc("supers", "giveSuperPoints")]](points);
    }

    if(issharedfuncdefined("rank", "scoreEventPopup")) {
      attacker thread[[getsharedfunc("rank", "scoreEventPopup")]](scoreevent);
    }
  }
}

function applygamemodecallout(ent, msg, event) {
  self endon("disconnect");

  if(isDefined(self.gamemodecalloutent)) {
    if(self.gamemodecalloutent == ent) {
      return;
    }

    self notify("gamemode_callout_replaced");
  } else {
    scoreevent = "assist_ping";
    points = 0;

    if(issharedfuncdefined("rank", "getScoreInfoValue")) {
      points = [[getsharedfunc("rank", "getScoreInfoValue")]](scoreevent);
    }

    if(issharedfuncdefined("rank", "giveRankXP")) {
      self thread[[getsharedfunc("rank", "giveRankXP")]](scoreevent, points);
    }

    if(issharedfuncdefined("supers", "giveSuperPoints")) {
      self thread[[getsharedfunc("supers", "giveSuperPoints")]](points);
    }

    if(issharedfuncdefined("rank", "scoreEventPopup")) {
      self thread[[getsharedfunc("rank", "scoreEventPopup")]](scoreevent);
    }
  }

  self.gamemodecallouttime = gettime();
  self.gamemodecalloutent = ent;
  id = undefined;

  if(isDefined(ent.outlineent)) {
    id = undefined;

    if(issharedfuncdefined("outline", "outlineEnableForTeam")) {
      id = [[getsharedfunc("outline", "outlineEnableForTeam")]](ent.outlineent, self.team, "outline_nodepth_red", "perk_superior");
    }
  }

  foreach(player in level.players) {
    if(player.team != self.team) {
      continue;
    }

    player iprintlnbold(msg);
  }

  thread waittillobjectiveevent(id, ent, event);
  thread waittillobjectivereplaced(id, ent, event);
  timeout = 30;
  waittill_notify_or_timeout("callout_processed_" + event, timeout);
  self notify("callout_timeout_" + event);

  if(isDefined(ent.outlineent)) {
    if(issharedfuncdefined("outline", "outlineDisable")) {
      [[getsharedfunc("outline", "outlineDisable")]](id, ent.outlineent);
    }
  }

  self.gamemodecalloutent = undefined;
}

function waittillobjectiveevent(id, ent, event) {
  self endon("callout_timeout_" + event);
  self endon("gamemode_callout_replaced");
  self endon("disconnect");
  team = self.team;

  while(true) {
    ent waittill(event, player);
    giveconfirm = 0;

    if(isDefined(level.gamemodegesturecalloutverify)) {
      giveconfirm = self[[level.gamemodegesturecalloutverify]](event, player);
    }

    if(giveconfirm) {
      scoreevent = "assist_marked";
      points = 0;

      if(issharedfuncdefined("rank", "getScoreInfoValue")) {
        points = [[getsharedfunc("rank", "getScoreInfoValue")]](scoreevent);
      }

      if(issharedfuncdefined("rank", "giveRankXP")) {
        self thread[[getsharedfunc("rank", "giveRankXP")]](scoreevent, points);
      }

      if(issharedfuncdefined("supers", "giveSuperPoints")) {
        self thread[[getsharedfunc("supers", "giveSuperPoints")]](points);
      }

      if(issharedfuncdefined("rank", "scoreEventPopup")) {
        self thread[[getsharedfunc("rank", "scoreEventPopup")]](scoreevent);
      }

      points = 25;

      if(issharedfuncdefined("rank", "giveRankXP")) {
        player thread[[getsharedfunc("rank", "giveRankXP")]](scoreevent, points);
      }

      if(issharedfuncdefined("supers", "giveSuperPoints")) {
        player thread[[getsharedfunc("supers", "giveSuperPoints")]](points);
      }

      if(issharedfuncdefined("rank", "scoreEventPopup")) {
        player thread[[getsharedfunc("rank", "scoreEventPopup")]](scoreevent);
      }

      if(isDefined(ent.outlineent)) {
        if(issharedfuncdefined("outline", "outlineDisable")) {
          [[getsharedfunc("outline", "outlineDisable")]](id, ent.outlineent);
        }
      }

      self notify("callout_processed_" + event);
      break;
    }
  }
}

function waittillobjectivereplaced(id, ent, event) {
  self endon("callout_timeout_" + event);
  self endon("callout_processed_" + event);
  self endon("disconnect");
  self waittill("gamemode_callout_replaced");

  if(isDefined(ent.outlineent)) {
    if(issharedfuncdefined("outline", "outlineDisable")) {
      [[getsharedfunc("outline", "outlineDisable")]](id, ent.outlineent);
    }
  }
}

function startholowatchvfx() {
  if(level.mapname == "mp_hackney_yard" || level.mapname == "mp_spear_pm" || level.mapname == "mp_runner_pm" || level.mapname == "mp_cave") {
    self setscriptablepartstate("watchVFXPlayer", "holoWatchOnNight");
    self setclientomnvar("ui_pet_watch_state", 1);
    return;
  }

  self setscriptablepartstate("watchVFXPlayer", "holoWatchOn");
  self setclientomnvar("ui_pet_watch_state", 0);
}

function startbluntwatchvfx() {
  if(istrue(self.var_74e82e1456d96cad)) {
    return;
  }

  self setscriptablepartstate("watchVFXPlayer", "bluntWatchOn");
  self setclientomnvar("ui_pet_watch_state", 0);
  self setwristwatchtime(4, 20, 1);
  self.var_74e82e1456d96cad = 1;
  thread function_a4f0da4979f60824();
}

function function_a4f0da4979f60824() {
  self endon("disconnect");
  self endon("game_ended");
  wait 4.2;
  self.var_74e82e1456d96cad = undefined;
  self setscriptablepartstate("watchVFXPlayer", "off");

  if(isDefined(self.accessorylogic)) {
    self clearwristwatchtime();
  }
}

function tryreenablescriptablevfx() {
  self endon("death_or_disconnect");
  self setscriptablepartstate("watchVFXPlayer", "off");
  var_c0b92b6128568c20 = isDefined(self.accessorylogic) && self.accessorylogic == "holo";

  if(var_c0b92b6128568c20) {
    wait 0.2;
    var_602111b3819425b2 = self hasweapon("iw8_acc_weapon_watch_2+iw8_acc_attach_face_digital_ag");

    if(var_602111b3819425b2 && (!isDefined(self.smartwatchinteract) || istrue(self.smartwatchinteract))) {
      if(var_602111b3819425b2) {
        startholowatchvfx();
      }
    }
  }
}

function watchradialgestureactivation(gesturenotify, gestureindex) {
  if((scripts\cp_mp\utility\game_utility::isbrstylegametype() || level.gametype == "dmz" || level.gametype == "exgm" || level.gametype == "plunder") && self hasweapon("iw9_armor_plate_deploy_mp")) {
    return;
  }

  if(gesturenotify == "radial_menu_selection_gesture") {
    gesturedata = getgesturedatabyindex(gestureindex);

    if(isDefined(gesturedata)) {
      if(gesturedata == "iw8_ges_plyr_gesture024") {
        if(!isDefined(self.smartwatchinteract)) {
          self.smartwatchinteract = 0;
        }

        self.smartwatchinteract = !self.smartwatchinteract;
        self setclientomnvar("ui_smart_watch_interact", self.smartwatchinteract);

        if(isDefined(self.accessorylogic)) {
          if(self.accessorylogic == "holo") {
            if(!self.smartwatchinteract) {
              startholowatchvfx();
            } else {
              self setscriptablepartstate("watchVFXPlayer", "off");
            }
          }
        }
      } else if(gesturedata == "iw8_ges_plyr_gesture023") {
        if(!isDefined(self.watchcheck)) {
          self.watchcheck = 0;
        }

        self.watchcheck = !self.watchcheck;
        self setclientomnvar("ui_smart_watch_check", self.watchcheck);

        if(isDefined(self.accessorylogic)) {
          if(self.accessorylogic == "blunt") {
            startbluntwatchvfx();
          }
        }
      }

      objweapon = makeweapon(gesturedata);

      if(isDefined(objweapon) && !isnullweapon(objweapon)) {
        watchradialgesture(objweapon);
      }
    }

    return;
  }

  if(gesturenotify == "radial_menu_selection_spray") {
    objweapon = makeweapon("iw8_ges_plyr_spray");

    if(isDefined(objweapon) && !isnullweapon(objweapon)) {
      thread watchspraygesturedosprayevent(gestureindex);
      watchradialgesture(objweapon);
      return;
    }

    println("<dev string:x8f>" + "<dev string:xb0>" + "<dev string:xc6>");
  }
}

function watchspraygesturedosprayevent(sprayindex) {
  self endon("death");
  self endon("disconnect");
  self notify("watchSprayGestureDoSprayEvent");
  self endon("watchSprayGestureDoSprayEvent");
  endtime = gettime() + 200;

  while(gettime() < endtime) {
    waitframe();

    if(self isgestureplaying("iw8_ges_plyr_spray")) {
      self sprayevent(sprayindex);
      scripts\cp_mp\challenges::onspray();
      return;
    }
  }

  println("<dev string:xdc>");
}

function watchradialgesture(objweapon) {
  self giveandfireoffhand(objweapon);
  endtime = gettime() + 5000;

  while(gettime() < endtime) {
    if(!self hasweapon(objweapon)) {
      break;
    }

    waitframe();
  }

  if(self hasweapon(objweapon)) {
    _takeweapon(objweapon);
  }

  cleargesture();
  waitframe();
  self.gestureweapon = objweapon.basename;
}

function function_199e645a5bbf82a7() {
  wait 2;
  self iprintlnbold("<dev string:x10b>");
  self notify("<dev string:x121>", "<dev string:x134>", 3);
}

# /
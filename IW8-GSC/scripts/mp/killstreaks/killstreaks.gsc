/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\killstreaks.gsc
**************************************************/

function removeincoming() {
  var_0 = 3;

  if(scripts\mp\utility\game::getgametype() == "br") {
    var_0 = 1;
  }

  return var_0;
}

function initkillstreakdata() {
  var_0 = spawnStruct();
  level.killstreakglobals = var_0;
  var_0.costomnvars = [];
  var_0.costomnvars[1] = "ui_score_streak_cost";
  var_0.costomnvars[2] = "ui_score_streak_two_cost";
  var_0.costomnvars[3] = "ui_score_streak_three_cost";
  var_0.slotomnvars = [];
  var_0.slotomnvars[0] = "ui_score_streak_index_0";
  var_0.slotomnvars[1] = "ui_score_streak_index_1";
  var_0.slotomnvars[2] = "ui_score_streak_index_2";
  var_0.slotomnvars[3] = "ui_score_streak_index_3";
  var_0.availableomnvars = [];
  var_0.availableomnvars[0] = "ui_score_streak_available_0";
  var_0.availableomnvars[1] = "ui_score_streak_available_1";
  var_0.availableomnvars[2] = "ui_score_streak_available_2";
  var_0.availableomnvars[3] = "ui_score_streak_available_3";
  parsestreaktable();
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(&killstreakonteamchange);
}

function parsestreaktable() {
  var_0 = level.killstreakglobals;

  if(isDefined(game["killstreakTable"])) {
    var_0.streaktable = game["killstreakTable"];
    return;
  }

  var_1 = spawnStruct();
  game["killstreakTable"] = var_1;
  var_0.streaktable = var_1;
  var_1.tabledatabyref = [];

  for(var_2 = 1;; var_2++) {
    var_3 = tablelookupbyrow("mp/killstreakTable.csv", var_2, 1);

    if(var_3 == "") {
      break;
    }

    var_1.tabledatabyref[var_3] = [];
    var_1.tabledatabyref[var_3]["index"] = int(tablelookupbyrow("mp/killstreakTable.csv", var_2, 0));
    var_1.tabledatabyref[var_3]["brIndex"] = int(tablelookupbyrow("mp/killstreakTable.csv", var_2, 27));
    var_1.tabledatabyref[var_3]["hudIcon"] = tablelookupbyrow("mp/killstreakTable.csv", var_2, 12);
    var_1.tabledatabyref[var_3]["overheadIcon"] = tablelookupbyrow("mp/killstreakTable.csv", var_2, 13);
    var_1.tabledatabyref[var_3]["enemyUseDialog"] = int(tablelookupbyrow("mp/killstreakTable.csv", var_2, 10));
    var_1.tabledatabyref[var_3]["kills"] = int(tablelookupbyrow("mp/killstreakTable.csv", var_2, 4));
    var_1.tabledatabyref[var_3]["supportCost"] = int(tablelookupbyrow("mp/killstreakTable.csv", var_2, 5));
    var_1.tabledatabyref[var_3]["scoreCost"] = int(tablelookupbyrow("mp/killstreakTable.csv", var_2, 6));
    var_1.tabledatabyref[var_3]["name"] = tablelookupbyrow("mp/killstreakTable.csv", var_2, 2);
    var_1.tabledatabyref[var_3]["shownInMenu"] = tablelookupbyrow("mp/killstreakTable.csv", var_2, 16);

    if(var_3 != "none") {
      var_4 = tablelookupbyrow("mp/killstreakTable.csv", var_2, 7);
      game["dialog"][var_3] = var_4;
      var_5 = tablelookupbyrow("mp/killstreakTable.csv", var_2, 8);
      game["dialog"]["allies_friendly_" + var_3 + "_inbound"] = var_5 + "_friendly_use";
      game["dialog"]["allies_enemy_" + var_3 + "_inbound"] = var_5 + "_enemy_use";
      var_6 = tablelookupbyrow("mp/killstreakTable.csv", var_2, 9);
      game["dialog"]["axis_friendly_" + var_3 + "_inbound"] = var_6 + "_friendly_use";
      game["dialog"]["axis_enemy_" + var_3 + "_inbound"] = var_6 + "_enemy_use";
      game["dialog"]["use_" + var_3] = var_5 + "_use";
      game["dialog"]["destroyed_" + var_3] = var_5 + "_destroyed";
      game["dialog"]["timeout_" + var_3] = var_5 + "_timeout";
      var_7 = int(tablelookupbyrow("mp/killstreakTable.csv", var_2, 11));
      scripts\mp\rank::registerscoreinfo("killstreak_" + var_3, "value", var_7);
    }
  }
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(!isDefined(var_0.pers["startedMapSelect"])) {
      var_0.pers["startedMapSelect"] = 0;
    }

    if(!isDefined(var_0.pers["streakData"])) {
      var_0.pers["streakData"] = createplayerstreakdatastruct();
    }

    var_0.streakdata = var_0.pers["streakData"];
    var_0 scripts\mp\utility\stats::initpersstat("streakPoints");
    var_0.streakpoints = var_0 scripts\mp\utility\stats::getpersstat("streakPoints");
    var_0.previousstreakpoints = var_0.streakpoints;
    var_0.nukepoints = var_0 scripts\mp\utility\stats::getpersstat("cur_kill_streak");
    var_0 visionsetmissilecamforplayer(game["thermal_vision"]);

    if(!level.roundretainstreaks) {
      resetstreakavailability(var_0, 1);
    }
  }
}

function onplayerspawned() {
  if(isDefined(level.deathretainstreaks) && !level.deathretainstreaks) {
    resetstreakavailability(1);
  }

  selectfirstavailablekillstreak();

  if(!isDefined(self.earnedstreaklevel)) {
    self.earnedstreaklevel = 0;
  }

  self.triggeringstreak = undefined;
  setstreakcounttonext();
  updatekillstreakselectedui();
  updatekillstreakuislots();
  updatestreakmeterui();
  updatestreakcosts();
  ref_13DB8();
}

function createplayerstreakdatastruct() {
  var_0 = spawnStruct();
  var_0.streaks = [];
  return var_0;
}

function getplayerstreakdata() {
  return self.streakdata;
}

function resetforloadoutswitch() {
  updatespecialistui();
  updatestreakcosts();

  if(isDefined(self.oldperks) && isDefined(self.perks) && self.oldperks.size > 0) {
    if(scripts\engine\utility::array_contains_key(self.perks, "specialty_support_killstreaks") && scripts\engine\utility::array_contains_key(self.oldperks, "specialty_support_killstreaks")) {
      return;
    }

    if(!scripts\engine\utility::array_contains_key(self.oldperks, "specialty_support_killstreaks")) {
      return;
    }

    resetstreakpoints();
    resetstreakavailability();
    updatekillstreakuislots();
    updatekillstreakselectedui();
    return;
  }
}

function setupinputnotifications() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(isbot(self)) {
    return;
  }

  scripts\mp\flags::gameflagwait("prematch_done");
  self notifyonplayercommand("ks_select_up", "+actionslot 1");
  self notifyonplayercommand("ks_select_down", "+actionslot 2");
  self notifyonplayercommand("ks_action_5", "+actionslot 5");
  self notifyonplayercommand("ks_action_6", "+actionslot 6");
  self notifyonplayercommand("ks_action_3", "+actionslot 3");
  self notifyonplayercommand("ks_action_4", "+actionslot 4");
  self setactionslot(4, "");
}

function updatestreakcount() {
  if(self.streakpoints == self.previousstreakpoints) {
    return;
  }

  var_0 = self.streakpoints;
  self setkillstreakpoints(int(min(self.streakpoints, 16384)));

  if(!isDefined(self.nextstreakcost) || self.streakpoints >= self.nextstreakcost) {
    setstreakcounttonext();
    return;
  }
}

function resetstreakcount() {
  self setkillstreakpoints(0);
  self setclientomnvar("ui_score_streak_cost", 0);
  var_0 = scripts\mp\utility\game::getgametype() == "br";

  if(!var_0) {
    self setclientomnvar("ui_score_streak_two_cost", 0);
    self setclientomnvar("ui_score_streak_three_cost", 0);
  }

  setstreakcounttonext();
  self resetclientkillstreakavailability();
}

function setstreakcounttonext() {
  if(!isDefined(self.streaktype)) {
    self.nextstreakcost = 0;
    self setnextkillstreakcost(0);
    return;
  }

  if(findmaxstreakcost() == 0) {
    self.nextstreakcost = 0;
    self setnextkillstreakcost(0);
    return;
  }

  var_0 = self.nextstreakcost;
  var_1 = getnextstreakname();

  if(!isDefined(var_1)) {
    return;
  }

  var_2 = calcstreakcost(var_1);
  self.nextstreakcost = var_2;

  if(scripts\mp\utility\perk::_hasperk("specialty_support_killstreaks") && isDefined(getkillstreakinslot(1)) && !istrue(self.earnedmaxkillstreak)) {
    var_3 = 0;

    foreach(var_5 in self.streakdata.streaks) {
      if(istrue(var_5.earned)) {
        var_3 = 1;
        continue;
      }

      var_3 = 0;
    }

    if(var_3 && !isDefined(self.earnedmaxkillstreak)) {
      self.earnedmaxkillstreak = 1;
      self.nextstreakcost = 0;
      self setnextkillstreakcost(0);
      self setkillstreakpoints(0);
      self setclientomnvar("ui_score_streak_cost", 0);
      var_7 = scripts\mp\utility\game::getgametype() == "br";

      if(!var_7) {
        self setclientomnvar("ui_score_streak_two_cost", 0);
        self setclientomnvar("ui_score_streak_three_cost", 0);
      }

      return;
    }
  }

  self setnextkillstreakcost(var_3);
}

function getnextstreakname() {
  if(self.streakpoints == findmaxstreakcost() && self.streaktype != "specialist") {
    var_0 = 0;
  } else {
    var_0 = self.streakpoints;
  }

  for(var_1 = 1; var_1 <= 4; var_1++) {
    var_2 = getkillstreakinslot(var_1);

    if(var_2.currentcost > var_0) {
      return var_2.streakname;
    }
  }

  return undefined;
}

function updatestreakmeterui() {
  self setclientomnvar("ui_score_streak", self.streakpoints);
}

function updatestreakcosts() {
  updatestreakcost(1);
  updatestreakcost(2);
  updatestreakcost(3);
  updatestreakcost(4);
}

function updatestreakcost(var_0) {
  var_1 = level.killstreakglobals;
  var_2 = getkillstreakinslot(var_0);

  if(isDefined(var_2)) {
    var_3 = calcstreakcost(var_2.streakname);
    var_2.currentcost = var_3;

    if(var_0 <= removeincoming()) {
      var_4 = var_1.costomnvars[var_0];
      self setclientomnvar(var_4, var_3);
      return;
    }

    return;
  }
}

function findmaxstreakcost() {
  for(var_0 = 4; var_0 >= 1; var_0--) {
    var_1 = getkillstreakinslot(var_0);

    if(!isDefined(var_1)) {
      continue;
    }

    return var_1.currentcost;
  }

  return 0;
}

function updatekillstreakuislots() {
  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return;
  }

  var_0 = level.killstreakglobals;

  for(var_1 = 0; var_1 <= removeincoming(); var_1++) {
    updatekillstreakuislot(var_1);
  }
}

function updatekillstreakuislot(var_0) {
  if(var_0 > removeincoming()) {
    return;
  }

  if(isDefined(level.ref_11C8C) && ![[level.ref_11C8C]](var_0)) {
    return;
  }

  var_1 = level.killstreakglobals;
  var_2 = getkillstreakinslot(var_0);

  if(isDefined(var_2) && isDefined(var_2.streakname)) {
    var_3 = undefined;

    if(istrue(self.loadoutusingspecialist) && var_0 != 0) {
      var_4 = scripts\mp\perks\perks::getspecialistperkforstreak(var_2.streakname);
      var_3 = scripts\mp\perks\perks::getperkid(var_4);
    } else {
      var_3 = scripts\mp\utility\killstreak::getkillstreakindex(var_2.streakname);
    }

    self setclientomnvar(var_1.slotomnvars[var_0], var_3);
    self setclientomnvar(var_1.availableomnvars[var_0], var_2.available);
    ammobox_getbufferedattachment(var_0, var_3);
    ammobox_clearbufferedattachmentweapon(var_0, var_2.available);
    return;
  }

  self setclientomnvar(var_1.slotomnvars[var_0], 0);
  self setclientomnvar(var_1.availableomnvars[var_0], 0);
  ammobox_getbufferedattachment(var_0, 0);
  ammobox_clearbufferedattachmentweapon(var_0, 0);
}

function updatekillstreakselectedui() {
  var_0 = getselectedkillstreakindex();

  if(isDefined(var_0)) {
    self setclientomnvar("ui_score_streak_selected_slot", var_0);
    return;
  }

  self setclientomnvar("ui_score_streak_selected_slot", -1);
}

function updatespecialistui() {
  if(isDefined(self.loadoutusingspecialist)) {
    self setclientomnvar("ui_score_streak_is_specialist", self.loadoutusingspecialist);
    return;
  }
}

function killstreakonteamchange(var_0) {
  if(istrue(var_0.changedteams)) {
    clearkillstreaks(var_0);
    return;
  }
}

function listenkillstreakaction(var_0, var_1) {
  if(isDefined(var_0) && var_0 == "streak_select") {
    dokillstreakaction(undefined, var_1);
  }
}

function dokillstreakaction(var_0, var_1) {
  if(isDefined(self.triggeringstreak)) {
    return;
  }

  if(isDefined(var_0) && issubstr(var_0, "ks_")) {
    var_1 = gettriggeredslotfromnotify(var_0);
  }

  if(!isDefined(var_1)) {
    return;
  }

  var_2 = getkillstreakinslot(var_1);

  if(!isDefined(var_2) || var_2.available == 0 || var_2.available == -1) {
    return;
  }

  setselectedkillstreak(var_1);
  thread triggerkillstreak(var_2, var_1);
}

function trytriggerkillstreakfromsuper(var_0) {
  var_1 = createstreakitemstruct(var_0);
  var_1.available = 1;
  return triggerkillstreak(var_1);
}

function gettriggeredslotfromnotify(var_0) {
  var_1 = undefined;

  if(!isai(self)) {
    if(!self usinggamepad()) {
      if(var_0 == "ks_action_3" || var_0 == "ks_action_4" || var_0 == "ks_action_5" || var_0 == "ks_action_6") {
        var_1 = getselectedkillstreakindex();
      }
    }
  } else if(scripts\mp\utility\game::getgametype() == "grnd" && !scripts\engine\utility::is_player_gamepad_enabled()) {
    switch (var_0) {
      case "ks_action_3":
        var_1 = 0;
        break;
      case "ks_action_4":
        var_1 = 0;
        break;
      case "ks_action_5":
        var_1 = 0;
        break;
      case "ks_action_6":
        var_1 = 0;
        break;
    }
  } else {
    switch (var_0) {
      case "ks_action_3":
        var_1 = 1;
        break;
      case "ks_action_4":
        var_1 = 2;
        break;
      case "ks_action_5":
        var_1 = 3;
        break;
      case "ks_action_6":
        var_1 = 0;
        break;
    }
  }

  return var_1;
}

function iskillstreakvisibleforcodcaster(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0) {
    case "counter_uav":
    case "dronedrop":
    case "directional_uav":
    case "uav":
      return 0;
    default:
      return 1;
  }
}

function triggerkillstreak(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  var_2 = var_0.streaksetupinfo;

  if(!scripts\common\utility::is_killstreaks_allowed()) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS/CANNOT_BE_USED");
    return false;
  }

  if(scripts\mp\utility\game::getgametype() == "br" && isDefined(self.scrambledby)) {
    if(var_0.streakname != "explosive_bow") {
      scripts\mp\hud_message::showerrormessage("MP_BR_INGAME_TU_WZ335/JAMMED");
      return false;
    }
  }

  if(isDefined(level.ref_11C6C) && !self[[level.ref_11C6C]](var_0, var_1)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS/CANNOT_BE_USED");
    return false;
  }

  if(var_0.isspecialist || isDefined(self.triggeringstreak) && self.triggeringstreak == var_0) {
    return false;
  }

  self.triggeringstreak = var_0;
  scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_cancelalldeployments();
  var_3 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(var_0.streakname, self);
  var_3.mpstreaksysteminfo = var_0;
  var_4 = scripts\mp\utility\game::getgametype() == "br";

  if(var_4) {
    var_0.uniqueid = var_3.id;
  }

  scripts\mp\gamelogic::sethasdonecombat(self, 1);
  var_5 = self[[var_2.triggeredfunc]](var_3);
  self.triggeringstreak = undefined;

  if(!istrue(var_5)) {
    return false;
  }

  if(isDefined(var_1)) {
    onsuccessfulstreakactivation(var_0, var_1);
  }

  return true;
}

function onkillstreaktriggered(var_0) {
  return true;
}

function onkillstreakbeginuse(var_0) {
  var_1 = var_0.owner;

  if(!isDefined(var_1)) {
    return false;
  }

  if(!var_1 scripts\mp\utility\killstreak::validateusestreak(var_0.streakname)) {
    return false;
  }

  return true;
}

function onkillstreakfinishuse(var_0, var_1) {}

function forceactivatekillstreak(var_0, var_1) {
  var_2 = createstreakitemstruct(var_0);
  triggerkillstreak(var_2);
}

function forceactivategimmekillstreak() {
  var_0 = getkillstreakinslot(0);
  triggerkillstreak(var_0);
}

function onsuccessfulstreakactivation(var_0, var_1) {
  var_2 = var_0.streakname;

  if(istrue(level.ref_145EC) && self.streaktype != "specialist") {
    var_0.available = -1;
  } else {
    var_0.available = -1;
  }

  ammobox_clearbufferedattachmentweapon(var_1, var_0.available);
  var_3 = scripts\mp\utility\game::getgametype() == "br";

  if(isDefined(var_1)) {
    if(var_3 || var_1 == 0 || var_1 >= 5) {
      removekillstreak(var_1);
    }

    selectnextavailablekillstreak();
    updatekillstreakuislot(var_1);
  }

  thread scripts\cp\vehicles\vehicle_compass_cp::usedkillstreak(var_2);
  scripts\mp\utility\print::printgameaction("killstreak started - " + var_2, self);
  scripts\mp\utility\dialog::playkillstreakusedialog(var_2);
  var_6 = scripts\mp\matchdata::gettimefrommatchstart(gettime());
  var_0.attackerisinflictor = var_6;
  scripts\mp\analyticslog::logevent_killstreakactivated(self, var_0.ref_13913, var_0.streakname, var_0.isgimme, var_6, self.origin);

  switch (var_2) {
    case "care_package":
      scripts\mp\utility\stats::incpersstat("killstreakCarePackageUsed", 1);
      break;
    case "emergency_airdrop":
      scripts\mp\utility\stats::incpersstat("killstreakEmergencyAirdropUsed", 1);
      break;
  }

  combatrecordkillstreakuse(var_2);

  if(isDefined(self.petwatch)) {
    scripts\cp_mp\pet_watch::addkillstreakcharge();

    if(var_0.currentcost > 7) {
      scripts\cp_mp\pet_watch::addtopkillstreakcharge();
    }

    if(var_2 == "nuke") {
      scripts\cp_mp\pet_watch::addnukecharge();
      return;
    }

    if(var_2 == "juggernaut") {
      scripts\cp_mp\pet_watch::battle_tracks_standingonsamevehiclewithsametracksowner();
      return;
    }

    return;
  }
}

function createstreakitemstruct(var_0) {
  var_1 = spawnStruct();
  var_1.available = 0;
  var_1.streakname = var_0;
  var_1.isgimme = 0;
  var_1.streaksetupinfo = getkillstreaksetupinfo(var_0);
  var_1.madeavailabletime = -1;
  var_1.currentcost = calcstreakcost(var_0);
  var_1.isspecialist = scripts\mp\perks\perks::usescriptablemeleeblood(var_0);
  var_1.ref_136D2 = scripts\mp\perks\perks::getspecialistperkforstreak(var_0);
  return var_1;
}

function awardkillstreak(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = createstreakitemstruct(var_0);
  awardkillstreakfromstruct(var_6, var_1, var_2, var_3, var_4, var_5);
}

function awardkillstreakfromstruct(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0.isgimme = 1;
  var_6 = 0;

  if(isDefined(var_5)) {
    var_6 = var_5;
  }

  if(isDefined(var_0)) {
    if(!isDefined(var_2)) {
      var_2 = var_0.streaklifeid;
    }

    if(!isDefined(var_3)) {
      var_3 = var_0.ref_13913;
    }
  }

  slotkillstreak(var_0, var_6);
  setselectedkillstreak(var_6);
  makekillstreakavailable(var_6, var_1, var_2, var_3, var_4);
}

function equipkillstreak(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }

  var_2 = createstreakitemstruct(var_0);
  slotkillstreak(var_2, var_1);
}

function equipslotonekillstreak(var_0) {
  equipkillstreak(var_0, 1);
}

function equipslottwokillstreak(var_0) {
  equipkillstreak(var_0, 2);
}

function equipslotthreekillstreak(var_0) {
  equipkillstreak(var_0, 3);
}

function pushgimmeslotstreakontostack() {
  var_0 = getplayerstreakdata();

  if(isDefined(var_0.streaks[36])) {
    return false;
  }

  var_1 = var_0.streaks[0];

  if(!isDefined(var_1)) {
    return true;
  }

  for(var_2 = 5; var_2 < 37; var_2++) {
    if(!isDefined(var_0.streaks[var_2])) {
      var_0.streaks[var_2] = var_1;
      var_0.streaks[0] = undefined;
      break;
    }
  }

  return true;
}

function popstackedstreakintogimmeslot() {
  var_0 = getplayerstreakdata();
  var_1 = var_0.streaks[0];
  var_2 = undefined;
  var_3 = undefined;

  for(var_4 = 5; var_4 < 37; var_4++) {
    var_5 = var_0.streaks[var_4];

    if(isDefined(var_5)) {
      var_2 = var_5;
      var_3 = var_4;
      continue;
    }

    break;
  }

  var_0.streaks[0] = var_2;

  if(isDefined(var_3)) {
    var_0.streaks[var_3] = undefined;
    return;
  }
}

function deletestackedstreak(var_0) {
  var_1 = getplayerstreakdata();

  if(var_0 == 36) {
    var_1.streaks[var_0] = undefined;
    return;
  }

  for(var_2 = var_0; var_2 < 36; var_2++) {
    var_3 = var_1.streaks[var_2 + 1];

    if(!isDefined(var_3)) {
      break;
    }

    var_1.streaks[var_0] = var_3;
  }
}

function removekillstreak(var_0) {
  self.streakdata.streaks[var_0] = undefined;

  if(var_0 == 0) {
    popstackedstreakintogimmeslot();
    return;
  }

  if(var_0 >= 5) {
    deletestackedstreak(var_0);
    return;
  }
}

function clearkillstreaks() {
  self.streakdata.streaks = [];
  resetstreakpoints();
  resetstreakavailability();
  clearkillstreakselection();
  updatekillstreakuislots();
  updatekillstreakselectedui();
}

function slotkillstreak(var_0, var_1) {
  if(var_1 == 0) {
    if(!pushgimmeslotstreakontostack()) {
      return;
    }
  }

  self.streakdata.streaks[var_1] = var_0;
  updatekillstreakuislot(var_1);

  if(var_1 != 0) {
    updatestreakcost(var_1);
    return;
  }
}

function earnkillstreak(var_0, var_1) {
  var_2 = getkillstreakinslot(var_0);
  var_3 = var_2.streakname;
  scripts\mp\utility\script::bufferednotify("earned_killstreak_buffered", var_3);
  self.earnedstreaklevel = var_1;

  if(scripts\mp\utility\perk::_hasperk("specialty_support_killstreaks")) {
    self.streakdata.streaks[var_0].earned = 1;
  }

  self.streakdata.streaks[var_0].lifeid = scripts\cp_mp\utility\killstreak_utility::getcurrentplayerlifeidforkillstreak();

  if(!level.gameended) {
    thread scripts\mp\hud_message::showkillstreaksplash(var_3, var_1);
    combatrecordincrementkillstreakawardedstat(var_3);
  }

  setstreakcounttonext();
  makekillstreakavailable(var_0, "earned");
}

function makekillstreakavailable(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getkillstreakinslot(var_0);

  if(!isDefined(var_5)) {
    return;
  }

  var_6 = var_5.streakname;

  if(isDefined(var_5.ref_136D2)) {
    var_6 = var_5.ref_136D2;
  }

  loadassociatedkillstreakweapons(var_6);
  var_7 = var_5.streaksetupinfo;

  if(self.team == "spectator") {
    return;
  }

  var_5.available = 1;
  ammobox_clearbufferedattachmentweapon(var_0, var_5.available);
  setselectedkillstreak(var_0);
  updatekillstreakuislot(var_0);

  if(isDefined(var_7.availablefunc)) {
    self[[var_7.availablefunc]](var_5);
  }

  if(var_5.isgimme) {
    self notify("received_earned_killstreak");
  }

  var_5.madeavailabletime = scripts\mp\matchdata::gettimefrommatchstart(gettime());
  var_5.streaklifeid = self.lifeid;
  var_5.ref_13913 = self.matchdatalifeindex;
  var_5.owner = self;
  var_5.ref_121B0 = self getxuid();

  if(isDefined(var_2)) {
    var_5.streaklifeid = var_2;
  }

  if(isDefined(var_3)) {
    var_5.ref_13913 = var_3;
  }

  if(isDefined(var_4)) {
    var_5.owner = var_4;
    var_5.ref_121B0 = var_4 getxuid();
  }

  scripts\cp\vehicles\vehicle_compass_cp::ref_12047(var_5.streakname, var_1);
  scripts\mp\analyticslog::logevent_killstreakavailable(self, var_5.ref_13913, var_6, var_5.isgimme, var_5.madeavailabletime, self.origin);

  if(isDefined(self.petwatch) && var_0 == removeincoming()) {
    var_8 = 0;
    var_9 = 0;
    var_10 = getallavailablekillstreakstructs();

    foreach(var_12 in var_10) {
      var_13 = getvisiblekillstreakavailable(var_12.streakname);

      switch (var_13) {
        case 1:
          var_8 = var_12.streaklifeid == self.lifeid;
          break;
        case 2:
          var_9 = var_12.streaklifeid == self.lifeid;
          break;
        default:
          break;
      }
    }

    if(var_8 && var_9) {
      scripts\cp_mp\pet_watch::battle_tracks_getplayerdataenum();
    } else {
      scripts\cp_mp\pet_watch::battle_tracks_getnewtogglestate();
    }
  }
}

function ammobox_getbufferedattachment(var_0, var_1) {
  if(var_0 > removeincoming()) {
    return;
  }

  self setclientkillstreakavailability(var_0, var_1);
}

function ammobox_clearbufferedattachmentweapon(var_0, var_1) {
  if(var_0 > removeincoming()) {
    return;
  }

  self setpowerammo(var_0, var_1);
}

function givekillstreak(var_0, var_1, var_2) {
  awardkillstreak(var_0, "other");
}

function calcstreakcost(var_0) {
  var_1 = int(scripts\mp\utility\killstreak::getkillstreakkills(var_0));

  if(isDefined(self) && isPlayer(self)) {
    var_1 += getperkadjustedkillstreakcost(var_0, var_1);
  }

  var_1 = int(clamp(var_1, 0, 7000));
  return var_1;
}

function getperkadjustedkillstreakcost(var_0, var_1) {
  var_2 = 0;

  if(scripts\mp\utility\perk::_hasperk("specialty_support_killstreaks")) {
    var_3 = scripts\mp\utility\killstreak::getkillstreakindex(var_0);
    var_2 = 175 * var_3;
  }

  if(scripts\mp\utility\perk::_hasperk("specialty_hardline") && var_1 > 0 && var_0 != "nuke") {
    if(scripts\mp\utility\perk::_hasperk("specialty_killstreak_to_scorestreak")) {
      var_2 -= 125;
    } else {
      var_2--;
    }
  }

  return var_2;
}

function killstreakselectionwatcher() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    var_0 = scripts\engine\utility::ref_143AD("ks_select_up", "ks_select_down");

    if(!scripts\engine\utility::is_player_gamepad_enabled()) {
      continue;
    }

    if(!istrue(self.iscarrying)) {
      var_1 = getselectedkillstreakindex();

      if(!isDefined(var_1)) {
        continue;
      }

      var_2 = var_1;

      if(var_0 == "ks_select_up") {
        var_2 = getnextselectablekillstreakslot(var_1);
      } else if(var_0 == "ks_select_down") {
        var_2 = getpreviousselectablekillstreakslot(var_1);
      }

      setselectedkillstreak(var_2);
    }
  }
}

function selectfirstavailablekillstreak() {
  var_0 = getplayerstreakdata();

  if(isDefined(var_0.streaks[0])) {
    if(var_0.streaks[0].available == 1) {
      setselectedkillstreak(0);
      return;
    }
  } else {
    for(var_1 = removeincoming(); var_1 >= 0; var_1--) {
      var_2 = var_0.streaks[var_1];

      if(isDefined(var_2) && var_2.available == 1) {
        setselectedkillstreak(var_1);
        return;
      }
    }
  }

  clearkillstreakselection();
}

function getnextselectablekillstreakslot(var_0) {
  var_1 = var_0;
  var_2 = scripts\engine\utility::ter_op(var_0 >= removeincoming(), 0, var_0 + 1);
  var_3 = var_0;

  for(var_4 = var_2; var_4 != var_3; var_4 = 0) {
    var_5 = self.streakdata.streaks[var_4];

    if(isDefined(var_5) && var_5.available == 1) {
      var_1 = var_4;
      break;
    }

    var_4++;

    if(var_4 > removeincoming()) {}
  }

  return var_1;
}

function getpreviousselectablekillstreakslot(var_0) {
  var_1 = var_0;
  var_2 = scripts\engine\utility::ter_op(var_0 <= 0, removeincoming(), var_0 - 1);
  var_3 = var_0;

  for(var_4 = var_2; var_4 != var_3; var_4 = removeincoming()) {
    var_5 = self.streakdata.streaks[var_4];

    if(isDefined(var_5) && var_5.available == 1) {
      var_1 = var_4;
      break;
    }

    var_4--;

    if(var_4 < 0) {}
  }

  return var_1;
}

function selectmostexpensivekillstreak() {
  var_0 = undefined;
  var_1 = -1;

  for(var_2 = removeincoming(); var_2 >= 0; var_2--) {
    var_3 = self.streakdata.streaks[var_2];

    if(isDefined(var_3) && var_3.available == 1) {
      if(var_3.currentcost > var_1) {
        var_0 = var_2;
        var_1 = var_3.currentcost;
      }
    }
  }

  if(!isDefined(var_0)) {
    clearkillstreakselection();
    return;
  }

  setselectedkillstreak(var_0);
}

function selectnextavailablekillstreak() {
  var_0 = undefined;
  var_1 = -1;

  for(var_2 = 0; var_2 <= removeincoming(); var_2++) {
    var_3 = self.streakdata.streaks[var_2];

    if(isDefined(var_3) && var_3.available == 1) {
      if(istrue(var_3.isgimme)) {
        var_0 = var_2;
        break;
      }

      if(var_3.currentcost > var_1) {
        var_0 = var_2;
        var_1 = var_3.currentcost;
      }
    }
  }

  if(!isDefined(var_0)) {
    clearkillstreakselection();
    return;
  }

  setselectedkillstreak(var_0);
}

function setselectedkillstreak(var_0) {
  if(var_0 != 0 && istrue(self.loadoutusingspecialist)) {
    return;
  }

  var_1 = getkillstreakinslot(var_0);
  self.currentselectedkillstreakslot = var_0;
  updatekillstreakselectedui();

  if(scripts\mp\utility\game::unset_relic_grounded()) {
    var_2 = game["killstreakTable"].tabledatabyref[var_1.streakname]["brIndex"];
    scripts\mp\gametypes\br_public::updatebrextradata("selectedKillstreakId", var_2);
    return;
  }
}

function clearkillstreakselection() {
  self.currentselectedkillstreakslot = undefined;
  updatekillstreakselectedui();

  if(scripts\mp\utility\game::unset_relic_grounded()) {
    scripts\mp\gametypes\br_public::updatebrextradata("selectedKillstreakId", 0);
    return;
  }
}

function getselectedkillstreak() {
  var_0 = getselectedkillstreakindex();

  if(!isDefined(var_0)) {
    return undefined;
  }

  return self.streakdata.streaks[var_0];
}

function getselectedkillstreakindex() {
  return self.currentselectedkillstreakslot;
}

function getkillstreakinslot(var_0) {
  return self.streakdata.streaks[var_0];
}

function getequippedkillstreakbyname(var_0) {
  for(var_1 = 1; var_1 <= 3; var_1++) {
    var_2 = self.streakdata.streaks[var_1];

    if(isDefined(var_2) && var_2.streakname == var_0) {
      return var_2;
    }
  }

  return undefined;
}

function getequippedkillstreakslotbyname(var_0) {
  for(var_1 = 1; var_1 <= 3; var_1++) {
    var_2 = self.streakdata.streaks[var_1];

    if(isDefined(var_2) && var_2.streakname == var_0) {
      return var_1;
    }
  }

  return undefined;
}

function getvisiblekillstreakavailable(var_0) {
  for(var_1 = 0; var_1 <= removeincoming(); var_1++) {
    var_2 = self.streakdata.streaks[var_1];

    if(isDefined(var_2) && var_2.streakname == var_0 && var_2.available == 1) {
      return var_1;
    }
  }

  return undefined;
}

function getkillstreakvisibleslotbyname(var_0) {
  for(var_1 = 0; var_1 <= removeincoming(); var_1++) {
    var_2 = self.streakdata.streaks[var_1];

    if(isDefined(var_2) && var_2.streakname == var_0) {
      return var_1;
    }
  }

  return undefined;
}

function getgimmeslotkillstreakstructs() {
  var_0 = [];
  var_1 = getkillstreakinslot(0);

  if(isDefined(var_1)) {
    var_0 = var_1;

    for(var_2 = 5; var_2 < 37; var_2++) {
      var_3 = self.streakdata.streaks[var_2];

      if(isDefined(var_3)) {
        var_0 = var_3;
        continue;
      }

      break;
    }
  }

  return var_0;
}

function getavailableequippedkillstreakstructs() {
  var_0 = [];

  if(self.streakdata.streaks.size > 0) {
    for(var_1 = 1; var_1 < 4; var_1++) {
      var_2 = self.streakdata.streaks[var_1];

      if(isDefined(var_2) && isDefined(var_2.streakname) && var_2.available == 1) {
        var_0 = var_2;
      }
    }
  }

  return var_0;
}

function getallavailablekillstreakstructs() {
  var_0 = [];

  if(self.streakdata.streaks.size > 0) {
    for(var_1 = 0; var_1 < removeincoming(); var_1++) {
      var_2 = self.streakdata.streaks[var_1];

      if(isDefined(var_2) && isDefined(var_2.streakname) && var_2.available == 1) {
        var_0 = var_2;
      }
    }
  }

  return var_0;
}

function registerkillstreak(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.killstreaksetups)) {
    level.killstreaksetups = [];
  }

  var_4 = spawnStruct();
  level.killstreaksetups[var_0] = var_4;
  var_4.triggeredfunc = var_1;
  var_4.availablefunc = var_2;
  var_4.linkedtotag = var_3;
}

function getkillstreaksetupinfo(var_0) {
  var_1 = level.killstreaksetups[var_0];
  return var_1;
}

function checkstreakreward(var_0, var_1) {
  for(var_2 = 1; var_2 <= 4; var_2++) {
    var_3 = getkillstreakinslot(var_2);

    if(!isDefined(var_3)) {
      continue;
    }

    var_4 = var_3.currentcost;

    if(self.previousstreakpoints >= var_4 || var_0 < var_4) {
      continue;
    }

    if(scripts\mp\utility\perk::_hasperk("specialty_support_killstreaks") && istrue(var_3.earned)) {
      continue;
    }

    if(istrue(level.casualscorestreaks) && istrue(var_1)) {
      continue;
    }

    if(isDefined(var_3.lifeid) && var_3.lifeid == self.lifeid && (!istrue(level.ref_145EC) || istrue(level.ref_145EC) && self.streaktype == "specialist") || istrue(level.ref_145EC) && istrue(level.casualscorestreaks) && self.streaktype != "specialist" && var_3.available == -1) {
      continue;
    }

    earnkillstreak(var_2, var_4);
  }
}

function arekillstreaksequipped(var_0) {
  var_1 = getplayerstreakdata();

  if(!isDefined(var_1) || !isDefined(var_1.streaks)) {
    return false;
  }

  foreach(var_3 in var_0) {
    var_4 = 0;
    var_5 = 1;

    while(var_5 <= 4) {
      var_6 = var_1.streaks[var_5];

      if(isDefined(var_6)) {
        if(isDefined(var_6.streakname) && var_6.streakname == var_3) {
          if(var_6.isspecialist) {
            var_7 = scripts\mp\perks\perks::getspecialistperkforstreak(var_3);

            if(var_6.ref_136D2 == var_7) {
              var_4 = 1;
              break;
            }
          } else {
            var_4 = 1;
            break;
          }
        }
      } else if(var_2 == "none") {
        var_3 = 1;
        break;
      }

      var_4++;
    }

    if(!var_3) {
      return false;
    }
  }

  var_1 = undefined;
  var_6 = undefined;
  return true;
}

function findkillstreakslotnumber(var_0) {
  for(var_1 = 0; var_1 <= 37; var_1++) {
    var_2 = self.streakdata.streaks[var_1];

    if(!isDefined(var_2)) {
      if(var_1 >= 5) {
        break;
      }

      continue;
    }

    if(var_0 == var_2) {
      return var_1;
    }
  }

  return undefined;
}

function streakglobals_onkillstreaktriggered(var_0) {
  if(isDefined(var_0.mpstreaksysteminfo)) {
    var_1 = onkillstreaktriggered(var_0);

    if(!var_1) {
      return false;
    }
  }

  return true;
}

function streakglobals_onkillstreakbeginuse(var_0) {
  var_1 = var_0.owner;

  if(isDefined(var_0.mpstreaksysteminfo)) {
    var_2 = onkillstreakbeginuse(var_0);

    if(!var_2) {
      return false;
    }
  }

  if(isDefined(var_1)) {
    if(level.codcasterenabled) {
      if(iskillstreakvisibleforcodcaster(var_0.streakname)) {
        var_1 setnoteworthykillstreakactive(1);
      }
    }

    if(scripts\mp\utility\game::ismlgmatch()) {
      var_3 = int(tablelookup("mp/killstreaktable.csv", 1, var_0.streakname, 4));

      if(var_3 >= 1000) {
        var_4 = tablelookup("mp/killstreaktable.csv", 1, var_0.streakname, 0);

        if(var_4 != "") {
          var_5 = int(var_4);
        }
      }
    }
  }

  return true;
}

function streakglobals_onkillstreakfinishuse(var_0) {
  var_1 = var_0.owner;
  var_2 = 0;

  if(isDefined(var_1)) {
    var_2 = var_1 scripts\mp\utility\killstreak::hasplayerdiedwhileusingkillstreak(var_0);
  }

  if(isDefined(var_0.mpstreaksysteminfo)) {
    onkillstreakfinishuse(var_0, var_2);
  }

  if(isDefined(var_1)) {
    if(!var_2) {
      var_1 notify("killstreak_use_finished");
    }

    if(level.codcasterenabled) {
      var_1 setnoteworthykillstreakactive(0);
      return;
    }

    return;
  }
}

function givestreakpoints(var_0, var_1, var_2) {
  if(istrue(game["isLaunchChunk"])) {
    return;
  }

  var_3 = scripts\engine\utility::ter_op(scripts\mp\utility\perk::_hasperk("specialty_killstreak_to_scorestreak"), var_2, var_1);

  if(!isDefined(var_3)) {
    var_3 = scripts\mp\rank::getscoreinfovalue(var_0);
  }

  if(var_3 == 0) {
    return;
  }

  self.pers["killstreakToScorestreak"] = undefined;
  self.pers["killstreakToScorestreak_lifeId"] = undefined;
  var_4 = self.streakpoints + var_3;
  var_5 = findmaxstreakcost();

  if(var_4 > var_5) {
    var_4 = var_5;
  }

  var_6 = var_0 == "kill";

  if(var_6 && !istrue(level.loadout_updateclassdefault_weapons) && (istrue(level.allowkillstreaks) || isDefined(level.ref_12305))) {
    var_7 = self.nukepoints + var_1;
    var_8 = calcstreakcost("nuke");

    if(isDefined(level.ref_12305)) {
      var_8 = level.ref_12305;
    }

    if(var_7 >= var_8) {
      self.nukepoints = var_8;

      if(!istrue(self.molotov_delete_scriptable)) {
        thread scripts\mp\hud_message::showkillstreaksplash("nuke", var_8);
        awardkillstreak("nuke", "earned");
        self.molotov_delete_scriptable = 1;
      }
    } else {
      self.nukepoints = var_7;

      if(isDefined(self.petwatch)) {
        scripts\cp_mp\pet_watch::ref_13FFD(self.nukepoints / var_8);
      }
    }
  }

  setstreakpoints(var_4);
  checkstreakreward(var_4);
  updatestreakmeterui();

  if(istrue(level.ref_145EC && self.streaktype != "specialist")) {
    if(var_4 >= var_5) {
      var_4 -= var_5;
      setstreakpoints(var_4);
      self setkillstreakpoints(var_4);
      setstreakcounttonext();
      resetstreakavailability();
    }
  }

  scripts\mp\analyticslog::logevent_reportstreakscore(var_3, gettime(), scripts\mp\rank::getscoreinfocategory(var_0, "eventID"));
}

function isbountyevent(var_0) {
  return var_0 == "bounty";
}

function iskillstreakkillevent(var_0) {
  return issubstr(var_0, "ss_kill") || var_0 == "killstreak_full_score";
}

function resetstreakpoints() {
  self.earnedstreaklevel = 0;
  self.nukepoints = 0;
  setstreakpoints(0);
  resetstreakcount();
  updatestreakmeterui();
}

function resetstreakavailability(var_0) {
  if(!isDefined(self)) {
    return;
  }

  for(var_1 = 0; var_1 <= 4; var_1++) {
    var_2 = self.streakdata.streaks[var_1];

    if(isDefined(var_2) && isDefined(var_2.streakname)) {
      if(istrue(var_0)) {
        var_2.available = 0;
      } else if(istrue(var_2.isspecialist)) {
        var_2.available = 0;
      } else if(var_2.available == -1) {
        var_2.available = 0;
      }

      ammobox_clearbufferedattachmentweapon(var_1, var_2.available);
    }
  }
}

function ref_13DB8() {
  for(var_0 = 1; var_0 <= 4; var_0++) {
    var_1 = self.streakdata.streaks[var_0];

    if(isDefined(var_1) && istrue(var_1.available)) {
      var_2 = var_1.streaksetupinfo;

      if(isDefined(var_2.availablefunc)) {
        self[[var_2.availablefunc]](var_1);
      }
    }
  }
}

function setstreakpoints(var_0) {
  if(var_0 < 0) {
    var_0 = 0;
  }

  if(isDefined(self.streakpoints)) {
    self.previousstreakpoints = self.streakpoints;
  } else {
    self.previousstreakpoints = 0;
  }

  self.streakpoints = var_0;
  updatestreakcount();
}

function storescorestreakpointsongameend() {
  level waittill("game_ended");

  if(level.roundretainstreakprog) {
    foreach(var_1 in level.players) {
      if(!isDefined(var_1)) {
        continue;
      }

      var_2 = 0;

      if(isDefined(var_1.streakpoints)) {
        if(var_1 scripts\mp\utility\perk::_hasperk("specialty_killstreak_to_scorestreak")) {
          var_2 = scripts\mp\perks\perkfunctions::vote_player_set(var_1.streakpoints);
        } else {
          var_2 = var_1.streakpoints;
        }
      }

      var_1.pers["streakPoints"] = var_2;
    }

    return;
  }
}

function findunobstructedfiringpointaroundz(var_0, var_1, var_2, var_3) {
  var_4 = rotatevector((0, 0, 1), (-1 * var_3, 0, 0));
  var_5 = vectortoangles(var_1 - var_0.origin);
  var_6 = 0;

  while(var_6 < 360) {
    var_7 = var_2 * rotatevector(var_4, (0, var_6 + var_5[1], 0));
    var_8 = var_1 + var_7;

    if(_findunobstructedfiringpointhelper(var_0, var_8, var_1)) {
      return var_8;
    }

    var_6 += 30;
  }

  return undefined;
}

function findunobstructedfiringpointaroundy(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = vectortoangles(var_0.origin - var_1);
  var_7 = var_3;

  while(var_7 <= var_4) {
    var_8 = rotatevector((1, 0, 0), (var_7 - 90, 0, 0));
    var_9 = var_2 * rotatevector(var_8, (0, var_6[1], 0));
    var_10 = var_1 + var_9;

    if(_findunobstructedfiringpointhelper(var_0, var_10, var_1)) {
      return var_10;
    }

    var_7 += var_5;
  }

  return undefined;
}

function _findunobstructedfiringpointhelper(var_0, var_1, var_2) {
  var_3 = scripts\engine\trace::_bullet_trace(var_1, var_2, 0);

  if(var_3["fraction"] > 0.99) {
    return true;
  }

  return false;
}

function findunobstructedfiringpoint(var_0, var_1, var_2) {
  var_3 = findunobstructedfiringpointaroundz(var_0, var_1, var_2, 30);

  if(!isDefined(var_3)) {
    var_3 = findunobstructedfiringpointaroundy(var_0, var_1, var_2, 15, 75, 15);
  }

  return var_3;
}

function killstreakhit(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_1) && isPlayer(var_0) && isDefined(var_2.owner) && isDefined(var_2.owner.team)) {
    if(scripts\cp_mp\utility\player_utility::playersareenemies(var_0, var_2.owner)) {
      ref_14018(var_2, var_0, var_4);

      if(scripts\mp\utility\weapon::iskillstreakweapon(var_1.basename)) {
        return;
      }

      var_5 = createheadicon(var_1);

      if(!isDefined(var_0.lasthittime[var_5])) {
        var_0.lasthittime[var_5] = 0;
      }

      if(var_0.lasthittime[var_5] == gettime()) {
        return;
      }

      var_0.lasthittime[var_5] = gettime();
      var_0 thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var_5, 1, "hits");

      if(scripts\mp\utility\game::onlinestatsenabled()) {
        var_6 = var_0 scripts\mp\playerstats_interface::getplayerstat("combatStats", "totalShots");
        var_7 = var_0 scripts\mp\playerstats_interface::getplayerstat("combatStats", "hits") + 1;

        if(var_7 <= var_6) {
          var_0 scripts\mp\playerstats_interface::setplayerstatbuffered(var_7, "combatStats", "hits");
          var_0 scripts\mp\playerstats_interface::setplayerstatbuffered(int(var_6 - var_7), "combatStats", "misses");
        }
      }

      if(isDefined(var_3) && scripts\engine\utility::isbulletdamage(var_3) || scripts\mp\utility\damage::isprojectiledamage(var_3)) {
        var_0.lastdamagetime = gettime();
        var_8 = scripts\mp\utility\weapon::getweapongroup(var_1.basename);

        if(var_8 == "weapon_lmg") {
          if(!isDefined(var_0.shotslandedlmg)) {
            var_0.shotslandedlmg = 1;
            return;
          }

          var_0.shotslandedlmg++;
          return;
        }

        return;
      }

      return;
    }

    return;
  }
}

function ref_14019(var_0) {
  ref_14018(var_0, 150);
}

function ref_14018(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(self)) {
    return;
  }

  if(!isDefined(self.ref_12F3C)) {
    self.ref_12F3C = [];
  }

  var_2 = var_0 getxuid();
  var_0.shoulddeleteimmediately = 1;

  if(!isDefined(self.ref_12F3C[var_2])) {
    var_3 = spawnStruct();
    var_3.damage = 0;
    var_3.player = var_0;
    self.ref_12F3C[var_2] = var_3;
  }

  self.ref_12F3C[var_2].damage += var_1;
}

function rocket_internal(var_0) {
  if(!isDefined(self.ref_12F3C)) {
    return [];
  }

  var_1 = [];

  foreach(var_3 in self.ref_12F3C) {
    var_4 = var_3.damage;
    var_5 = var_3.player;

    if(var_4 < 150) {
      continue;
    }

    var_6 = !scripts\mp\utility\player::isfriendly(self.team, var_5);
    var_7 = istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var_5, self.owner));

    if(!var_6 && !var_7) {
      continue;
    }

    if(isDefined(var_0) && var_5 == var_0) {
      continue;
    }

    var_1 = var_5;
  }

  return var_1;
}

function givescoreforequipment(var_0, var_1) {
  if(isDefined(var_1) && weaponclass(var_1) != "rocketlauncher" && var_1.basename != "iw8_la_kgolf_mp") {
    var_1 = undefined;
  }

  thread scripts\mp\utility\points::giveunifiedpoints("destroyed_equipment", var_1);
  scripts\cp_mp\gestures::processcalloutdeath(var_0, self);
}

function givescorefordestroyedtacinsert() {
  thread scripts\mp\utility\points::giveunifiedpoints("destroyed_tac_insert");
}

function givescorefortrophyblocks() {
  thread scripts\mp\utility\points::giveunifiedpoints("trophy_defense");
}

function givescoreforblackhat() {
  thread scripts\mp\utility\points::giveunifiedpoints("blackhat_hack");
}

function givescoreforhack() {
  thread scripts\mp\utility\points::giveunifiedpoints("hack");
}

function givescoreforempedvehicle() {
  thread scripts\mp\utility\points::giveunifiedpoints("emped_vehicle");
}

function givescoreforempedkillstreak() {
  thread scripts\mp\utility\points::giveunifiedpoints("emped_killstreak");
}

function givescoreforempedplayer() {
  thread scripts\mp\utility\points::giveunifiedpoints("emped_player");
}

function givescoreformarktarget(var_0) {
  if(var_0) {
    thread scripts\mp\utility\points::giveunifiedpoints("perk_marked_target");
    return;
  }

  thread scripts\mp\utility\points::giveunifiedpoints("perk_marked_target", undefined, 0);
}

function givescorefordestorymarkedtarget() {
  thread scripts\mp\utility\points::giveunifiedpoints("perk_destroyed_target");
}

function givescoreforassistdestroymarkedtarget() {
  thread scripts\mp\utility\points::giveunifiedpoints("perk_destroyed_target");
}

function givescorefortriggeredalarmeddoor() {
  thread scripts\mp\utility\points::giveunifiedpoints("triggered_alarm");
}

function streaktyperesetsondeath(var_0) {
  switch (var_0) {
    case "assault":
    case "specialist":
      return 1;
    case "resource":
    case "support":
      return 0;
    default:
      return 1;
  }
}

function initridekillstreak(var_0) {
  scripts\common\utility::allow_usability(0);
  var_1 = initridekillstreak_internal(var_0);

  if(isDefined(self)) {
    scripts\common\utility::allow_usability(1);
  }

  return var_1;
}

function initridekillstreak_internal(var_0) {
  if(isDefined(var_0) && islaptoptimeoutkillstreak(var_0)) {
    var_1 = "timeout";
  } else {
    var_1 = scripts\engine\utility::ref_143BB(1, "death", "disconnect", "weapon_switch_started");
  }

  scripts\mp\hostmigration::waittillhostmigrationdone();

  if(var_1 == "weapon_switch_started") {
    return "fail";
  }

  if(!isalive(self)) {
    return "fail";
  }

  if(var_1 == "disconnect" || var_1 == "death") {
    if(var_1 == "disconnect") {
      return "disconnect";
    }

    if(self.team == "spectator") {
      return "fail";
    }

    return "success";
  }

  if(scripts\mp\utility\game::iskillstreakdenied()) {
    return "fail";
  }

  if(!isDefined(var_1) || !issubstr(var_1, "pointSelect")) {
    if(var_1 == "drone_hive") {
      self visionsetfadetoblackforplayer("black_bw", 0);
      thread scripts\mp\utility\player::set_visionset_for_watching_players("black_bw", 0, 1, undefined, 1);
      var_2 = scripts\engine\utility::ref_143B9(0, "death_or_disconnect");
    } else {
      self visionsetfadetoblackforplayer("black_bw", 0.75);
      thread scripts\mp\utility\player::set_visionset_for_watching_players("black_bw", 0.75, 1, undefined, 1);
      var_2 = scripts\engine\utility::ref_143B9(0.8, "death_or_disconnect");
    }
  } else {
    var_2 = scripts\engine\utility::ref_143B9(1, "death_or_disconnect");
  }

  self notify("black_out_done");
  scripts\mp\hostmigration::waittillhostmigrationdone();

  if(var_2 != "disconnect") {
    if(!isDefined(var_2) || !issubstr(var_2, "pointSelect")) {
      thread clearrideintro(1);
    } else {
      self notify("intro_cleared");
    }

    if(self.team == "spectator") {
      return "fail";
    }
  }

  if(self isonladder()) {
    return "fail";
  }

  if(!isalive(self)) {
    return "fail";
  }

  if(scripts\mp\utility\game::iskillstreakdenied()) {
    return "fail";
  }

  if(var_2 == "disconnect") {
    return "disconnect";
  }

  return "success";
}

function islaptoptimeoutkillstreak(var_0) {
  switch (var_0) {
    case "remote_tank":
    case "remote_uav":
    case "osprey_gunner":
    case "pointSelect":
    case "drone_hive":
    case "heli_pilot":
    case "gunship":
    case "precision_airstrike":
      return true;
  }

  return false;
}

function clearrideintro(var_0, var_1) {
  self endon("disconnect");

  if(isDefined(var_0)) {
    wait var_0;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  self visionsetfadetoblackforplayer("", var_1);
  scripts\mp\utility\player::set_visionset_for_watching_players("", var_1);
  self notify("intro_cleared");
}

function allowridekillstreakplayerexit(var_0, var_1) {
  if(isDefined(var_0)) {
    self endon(var_0);
  }

  if(!isDefined(self.owner)) {
    return;
  }

  var_2 = self.owner;
  level endon("game_ended");
  var_2 endon("disconnect");
  var_2 endon("end_remote");
  self endon("death");
  var_3 = 0.75;

  if(isDefined(var_1)) {
    var_3 = var_1;
  }

  var_4 = level.framedurationseconds;
  var_5 = 1;

  for(;;) {
    var_6 = 0;

    if(var_5 == 1) {
      var_2 setclientomnvar("ui_exit_progress", 0);
      var_5 = 0;
    }

    while(var_2 useButtonPressed()) {
      var_6 += var_4;
      var_5 = 1;
      var_2 setclientomnvar("ui_exit_progress", var_6 / var_3);

      if(var_6 > var_3) {
        self notify("killstreakExit");
        return;
      }

      wait var_4;
    }

    wait var_4;
  }
}

function combatrecordkillstreakuse(var_0) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }

  var_1 = scripts\mp\utility\stats::getstreakrecordtype(var_0);

  if(!isDefined(var_1)) {
    if(var_0 != "nuke" && var_0 != "explosive_bow") {}

    return;
  }

  var_2 = self getplayerdata("mp", "playerStats", var_1, var_0, "uses");
  self setplayerdata("mp", "playerStats", var_1, var_0, "uses", var_2 + 1);
}

function checkcasualstreaksreset() {
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.streaktype) && self.streaktype == "specialist" || isDefined(self.loadoutstreaktype) && self.loadoutstreaktype == "specialist" || !istrue(level.ref_145EC)) {
    var_0 = self.streakdata.streaks[self.streakdata.streaks.size];

    if(var_0.available == 1 || var_0.available == -1) {
      return 1;
    }
  }

  return 0;
}

function loadassociatedkillstreakweapons(var_0) {
  var_1 = [];
  var_2 = scripts\cp_mp\utility\killstreak_utility::getkillstreakdeployweapon(var_0);
  var_1 = var_2;
  var_3 = scripts\cp_mp\utility\killstreak_utility::getkillstreakgameweapons(var_0);
  var_1 = scripts\engine\utility::array_combine(var_1, var_3);
  self loadweaponsforplayer(var_1, 1);
}

function combatrecordincrementkillstreakawardedstat(var_0) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }

  var_1 = scripts\mp\utility\stats::getstreakrecordtype(var_0);

  if(!isDefined(var_1)) {
    return;
  }

  var_2 = self getplayerdata("mp", "playerStats", var_1, var_0, "awardedCount");
  self setplayerdata("mp", "playerStats", var_1, var_0, "awardedCount", var_2 + 1);
}

function hide_player_clip(var_0) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }

  var_1 = scripts\mp\utility\stats::getstreakrecordtype(var_0);

  if(!isDefined(var_1)) {
    return;
  }

  var_2 = self getplayerdata("mp", "playerStats", var_1, var_0, "extraStat1");
  self setplayerdata("mp", "playerStats", var_1, var_0, "extraStat1", var_2 + 1);
}
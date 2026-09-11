/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\killstreaks.gsc
**************************************************/

function removeincoming() {
  var0 = 3;

  if(scripts\mp\utility\game::getgametype() == "br") {
    var0 = 1;
  }

  return var0;
}

function initkillstreakdata() {
  var0 = spawnStruct();
  level.killstreakglobals = var0;
  var0.costomnvars = [];
  var0.costomnvars[1] = "ui_score_streak_cost";
  var0.costomnvars[2] = "ui_score_streak_two_cost";
  var0.costomnvars[3] = "ui_score_streak_three_cost";
  var0.slotomnvars = [];
  var0.slotomnvars[0] = "ui_score_streak_index_0";
  var0.slotomnvars[1] = "ui_score_streak_index_1";
  var0.slotomnvars[2] = "ui_score_streak_index_2";
  var0.slotomnvars[3] = "ui_score_streak_index_3";
  var0.availableomnvars = [];
  var0.availableomnvars[0] = "ui_score_streak_available_0";
  var0.availableomnvars[1] = "ui_score_streak_available_1";
  var0.availableomnvars[2] = "ui_score_streak_available_2";
  var0.availableomnvars[3] = "ui_score_streak_available_3";
  parsestreaktable();
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(&killstreakonteamchange);
}

function parsestreaktable() {
  var0 = level.killstreakglobals;

  if(isDefined(game["killstreakTable"])) {
    var0.streaktable = game["killstreakTable"];
    return;
  }

  var1 = spawnStruct();
  game["killstreakTable"] = var1;
  var0.streaktable = var1;
  var1.tabledatabyref = [];

  for(var2 = 1;; var2++) {
    var3 = tablelookupbyrow("mp/killstreakTable.csv", var2, 1);

    if(var3 == "") {
      break;
    }

    var1.tabledatabyref[var3] = [];
    var1.tabledatabyref[var3]["index"] = int(tablelookupbyrow("mp/killstreakTable.csv", var2, 0));
    var1.tabledatabyref[var3]["brIndex"] = int(tablelookupbyrow("mp/killstreakTable.csv", var2, 27));
    var1.tabledatabyref[var3]["hudIcon"] = tablelookupbyrow("mp/killstreakTable.csv", var2, 12);
    var1.tabledatabyref[var3]["overheadIcon"] = tablelookupbyrow("mp/killstreakTable.csv", var2, 13);
    var1.tabledatabyref[var3]["enemyUseDialog"] = int(tablelookupbyrow("mp/killstreakTable.csv", var2, 10));
    var1.tabledatabyref[var3]["kills"] = int(tablelookupbyrow("mp/killstreakTable.csv", var2, 4));
    var1.tabledatabyref[var3]["supportCost"] = int(tablelookupbyrow("mp/killstreakTable.csv", var2, 5));
    var1.tabledatabyref[var3]["scoreCost"] = int(tablelookupbyrow("mp/killstreakTable.csv", var2, 6));
    var1.tabledatabyref[var3]["name"] = tablelookupbyrow("mp/killstreakTable.csv", var2, 2);
    var1.tabledatabyref[var3]["shownInMenu"] = tablelookupbyrow("mp/killstreakTable.csv", var2, 16);

    if(var3 != "none") {
      var4 = tablelookupbyrow("mp/killstreakTable.csv", var2, 7);
      game["dialog"][var3] = var4;
      var5 = tablelookupbyrow("mp/killstreakTable.csv", var2, 8);
      game["dialog"]["allies_friendly_" + var3 + "_inbound"] = var5 + "_friendly_use";
      game["dialog"]["allies_enemy_" + var3 + "_inbound"] = var5 + "_enemy_use";
      var6 = tablelookupbyrow("mp/killstreakTable.csv", var2, 9);
      game["dialog"]["axis_friendly_" + var3 + "_inbound"] = var6 + "_friendly_use";
      game["dialog"]["axis_enemy_" + var3 + "_inbound"] = var6 + "_enemy_use";
      game["dialog"]["use_" + var3] = var5 + "_use";
      game["dialog"]["destroyed_" + var3] = var5 + "_destroyed";
      game["dialog"]["timeout_" + var3] = var5 + "_timeout";
      var7 = int(tablelookupbyrow("mp/killstreakTable.csv", var2, 11));
      scripts\mp\rank::registerscoreinfo("killstreak_" + var3, "value", var7);
    }
  }
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var0);

    if(!isDefined(var0.pers["startedMapSelect"])) {
      var0.pers["startedMapSelect"] = 0;
    }

    if(!isDefined(var0.pers["streakData"])) {
      var0.pers["streakData"] = createplayerstreakdatastruct();
    }

    var0.streakdata = var0.pers["streakData"];
    var0 scripts\mp\utility\stats::initpersstat("streakPoints");
    var0.streakpoints = var0 scripts\mp\utility\stats::getpersstat("streakPoints");
    var0.previousstreakpoints = var0.streakpoints;
    var0.nukepoints = var0 scripts\mp\utility\stats::getpersstat("cur_kill_streak");
    var0 visionsetmissilecamforplayer(game["thermal_vision"]);

    if(!level.roundretainstreaks) {
      resetstreakavailability(var0, 1);
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
  ref_13db8();
}

function createplayerstreakdatastruct() {
  var0 = spawnStruct();
  var0.streaks = [];
  return var0;
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

  var0 = self.streakpoints;
  self setkillstreakpoints(int(min(self.streakpoints, 16384)));

  if(!isDefined(self.nextstreakcost) || self.streakpoints >= self.nextstreakcost) {
    setstreakcounttonext();
    return;
  }
}

function resetstreakcount() {
  self setkillstreakpoints(0);
  self setclientomnvar("ui_score_streak_cost", 0);
  var0 = scripts\mp\utility\game::getgametype() == "br";

  if(!var0) {
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

  var0 = self.nextstreakcost;
  var1 = getnextstreakname();

  if(!isDefined(var1)) {
    return;
  }

  var2 = calcstreakcost(var1);
  self.nextstreakcost = var2;

  if(scripts\mp\utility\perk::_hasperk("specialty_support_killstreaks") && isDefined(getkillstreakinslot(1)) && !istrue(self.earnedmaxkillstreak)) {
    var3 = 0;

    foreach(var5 in self.streakdata.streaks) {
      if(istrue(var5.earned)) {
        var3 = 1;
        continue;
      }

      var3 = 0;
    }

    if(var3 && !isDefined(self.earnedmaxkillstreak)) {
      self.earnedmaxkillstreak = 1;
      self.nextstreakcost = 0;
      self setnextkillstreakcost(0);
      self setkillstreakpoints(0);
      self setclientomnvar("ui_score_streak_cost", 0);
      var7 = scripts\mp\utility\game::getgametype() == "br";

      if(!var7) {
        self setclientomnvar("ui_score_streak_two_cost", 0);
        self setclientomnvar("ui_score_streak_three_cost", 0);
      }

      return;
    }
  }

  self setnextkillstreakcost(var3);
}

function getnextstreakname() {
  if(self.streakpoints == findmaxstreakcost() && self.streaktype != "specialist") {
    var0 = 0;
  } else {
    var0 = self.streakpoints;
  }

  for(var1 = 1; var1 <= 4; var1++) {
    var2 = getkillstreakinslot(var1);

    if(var2.currentcost > var0) {
      return var2.streakname;
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

function updatestreakcost(var0) {
  var1 = level.killstreakglobals;
  var2 = getkillstreakinslot(var0);

  if(isDefined(var2)) {
    var3 = calcstreakcost(var2.streakname);
    var2.currentcost = var3;

    if(var0 <= removeincoming()) {
      var4 = var1.costomnvars[var0];
      self setclientomnvar(var4, var3);
      return;
    }

    return;
  }
}

function findmaxstreakcost() {
  for(var0 = 4; var0 >= 1; var0--) {
    var1 = getkillstreakinslot(var0);

    if(!isDefined(var1)) {
      continue;
    }

    return var1.currentcost;
  }

  return 0;
}

function updatekillstreakuislots() {
  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return;
  }

  var0 = level.killstreakglobals;

  for(var1 = 0; var1 <= removeincoming(); var1++) {
    updatekillstreakuislot(var1);
  }
}

function updatekillstreakuislot(var0) {
  if(var0 > removeincoming()) {
    return;
  }

  if(isDefined(level.ref_11c8c) && ![[level.ref_11c8c]](var0)) {
    return;
  }

  var1 = level.killstreakglobals;
  var2 = getkillstreakinslot(var0);

  if(isDefined(var2) && isDefined(var2.streakname)) {
    var3 = undefined;

    if(istrue(self.loadoutusingspecialist) && var0 != 0) {
      var4 = scripts\mp\perks\perks::getspecialistperkforstreak(var2.streakname);
      var3 = scripts\mp\perks\perks::getperkid(var4);
    } else {
      var3 = scripts\mp\utility\killstreak::getkillstreakindex(var2.streakname);
    }

    self setclientomnvar(var1.slotomnvars[var0], var3);
    self setclientomnvar(var1.availableomnvars[var0], var2.available);
    ammobox_getbufferedattachment(var0, var3);
    ammobox_clearbufferedattachmentweapon(var0, var2.available);
    return;
  }

  self setclientomnvar(var1.slotomnvars[var0], 0);
  self setclientomnvar(var1.availableomnvars[var0], 0);
  ammobox_getbufferedattachment(var0, 0);
  ammobox_clearbufferedattachmentweapon(var0, 0);
}

function updatekillstreakselectedui() {
  var0 = getselectedkillstreakindex();

  if(isDefined(var0)) {
    self setclientomnvar("ui_score_streak_selected_slot", var0);
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

function killstreakonteamchange(var0) {
  if(istrue(var0.changedteams)) {
    clearkillstreaks(var0);
    return;
  }
}

function listenkillstreakaction(var0, var1) {
  if(isDefined(var0) && var0 == "streak_select") {
    dokillstreakaction(undefined, var1);
  }
}

function dokillstreakaction(var0, var1) {
  if(isDefined(self.triggeringstreak)) {
    return;
  }

  if(isDefined(var0) && issubstr(var0, "ks_")) {
    var1 = gettriggeredslotfromnotify(var0);
  }

  if(!isDefined(var1)) {
    return;
  }

  var2 = getkillstreakinslot(var1);

  if(!isDefined(var2) || var2.available == 0 || var2.available == -1) {
    return;
  }

  setselectedkillstreak(var1);
  thread triggerkillstreak(var2, var1);
}

function trytriggerkillstreakfromsuper(var0) {
  var1 = createstreakitemstruct(var0);
  var1.available = 1;
  return triggerkillstreak(var1);
}

function gettriggeredslotfromnotify(var0) {
  var1 = undefined;

  if(!isai(self)) {
    if(!self usinggamepad()) {
      if(var0 == "ks_action_3" || var0 == "ks_action_4" || var0 == "ks_action_5" || var0 == "ks_action_6") {
        var1 = getselectedkillstreakindex();
      }
    }
  } else if(scripts\mp\utility\game::getgametype() == "grnd" && !scripts\engine\utility::is_player_gamepad_enabled()) {
    switch (var0) {
      case "ks_action_3":
        var1 = 0;
        break;
      case "ks_action_4":
        var1 = 0;
        break;
      case "ks_action_5":
        var1 = 0;
        break;
      case "ks_action_6":
        var1 = 0;
        break;
    }
  } else {
    switch (var0) {
      case "ks_action_3":
        var1 = 1;
        break;
      case "ks_action_4":
        var1 = 2;
        break;
      case "ks_action_5":
        var1 = 3;
        break;
      case "ks_action_6":
        var1 = 0;
        break;
    }
  }

  return var1;
}

function iskillstreakvisibleforcodcaster(var0) {
  if(!isDefined(var0)) {
    return 0;
  }

  switch (var0) {
    case "counter_uav":
    case "dronedrop":
    case "directional_uav":
    case "uav":
      return 0;
    default:
      return 1;
  }
}

function triggerkillstreak(var0, var1) {
  self endon("disconnect");
  level endon("game_ended");
  var2 = var0.streaksetupinfo;

  if(!scripts\common\utility::is_killstreaks_allowed()) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS/CANNOT_BE_USED");
    return false;
  }

  if(scripts\mp\utility\game::getgametype() == "br" && isDefined(self.scrambledby)) {
    if(var0.streakname != "explosive_bow") {
      scripts\mp\hud_message::showerrormessage("MP_BR_INGAME_TU_WZ335/JAMMED");
      return false;
    }
  }

  if(isDefined(level.ref_11c6c) && !self[[level.ref_11c6c]](var0, var1)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS/CANNOT_BE_USED");
    return false;
  }

  if(var0.isspecialist || isDefined(self.triggeringstreak) && self.triggeringstreak == var0) {
    return false;
  }

  self.triggeringstreak = var0;
  scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_cancelalldeployments();
  var3 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(var0.streakname, self);
  var3.mpstreaksysteminfo = var0;
  var4 = scripts\mp\utility\game::getgametype() == "br";

  if(var4) {
    var0.uniqueid = var3.id;
  }

  scripts\mp\gamelogic::sethasdonecombat(self, 1);
  var5 = self[[var2.triggeredfunc]](var3);
  self.triggeringstreak = undefined;

  if(!istrue(var5)) {
    return false;
  }

  if(isDefined(var1)) {
    onsuccessfulstreakactivation(var0, var1);
  }

  return true;
}

function onkillstreaktriggered(var0) {
  return true;
}

function onkillstreakbeginuse(var0) {
  var1 = var0.owner;

  if(!isDefined(var1)) {
    return false;
  }

  if(!var1 scripts\mp\utility\killstreak::validateusestreak(var0.streakname)) {
    return false;
  }

  return true;
}

function onkillstreakfinishuse(var0, var1) {}

function forceactivatekillstreak(var0, var1) {
  var2 = createstreakitemstruct(var0);
  triggerkillstreak(var2);
}

function forceactivategimmekillstreak() {
  var0 = getkillstreakinslot(0);
  triggerkillstreak(var0);
}

function onsuccessfulstreakactivation(var0, var1) {
  var2 = var0.streakname;

  if(istrue(level.ref_145ec) && self.streaktype != "specialist") {
    var0.available = -1;
  } else {
    var0.available = -1;
  }

  ammobox_clearbufferedattachmentweapon(var1, var0.available);
  var3 = scripts\mp\utility\game::getgametype() == "br";

  if(isDefined(var1)) {
    if(var3 || var1 == 0 || var1 >= 5) {
      removekillstreak(var1);
    }

    selectnextavailablekillstreak();
    updatekillstreakuislot(var1);
  }

  thread scripts\cp\vehicles\vehicle_compass_cp::usedkillstreak(var2);
  scripts\mp\utility\print::printgameaction("killstreak started - " + var2, self);
  scripts\mp\utility\dialog::playkillstreakusedialog(var2);
  var6 = scripts\mp\matchdata::gettimefrommatchstart(gettime());
  var0.attackerisinflictor = var6;
  scripts\mp\analyticslog::logevent_killstreakactivated(self, var0.ref_13913, var0.streakname, var0.isgimme, var6, self.origin);

  switch (var2) {
    case "care_package":
      scripts\mp\utility\stats::incpersstat("killstreakCarePackageUsed", 1);
      break;
    case "emergency_airdrop":
      scripts\mp\utility\stats::incpersstat("killstreakEmergencyAirdropUsed", 1);
      break;
  }

  combatrecordkillstreakuse(var2);

  if(isDefined(self.petwatch)) {
    scripts\cp_mp\pet_watch::addkillstreakcharge();

    if(var0.currentcost > 7) {
      scripts\cp_mp\pet_watch::addtopkillstreakcharge();
    }

    if(var2 == "nuke") {
      scripts\cp_mp\pet_watch::addnukecharge();
      return;
    }

    if(var2 == "juggernaut") {
      scripts\cp_mp\pet_watch::battle_tracks_standingonsamevehiclewithsametracksowner();
      return;
    }

    return;
  }
}

function createstreakitemstruct(var0) {
  var1 = spawnStruct();
  var1.available = 0;
  var1.streakname = var0;
  var1.isgimme = 0;
  var1.streaksetupinfo = getkillstreaksetupinfo(var0);
  var1.madeavailabletime = -1;
  var1.currentcost = calcstreakcost(var0);
  var1.isspecialist = scripts\mp\perks\perks::usescriptablemeleeblood(var0);
  var1.ref_136d2 = scripts\mp\perks\perks::getspecialistperkforstreak(var0);
  return var1;
}

function awardkillstreak(var0, var1, var2, var3, var4, var5) {
  var6 = createstreakitemstruct(var0);
  awardkillstreakfromstruct(var6, var1, var2, var3, var4, var5);
}

function awardkillstreakfromstruct(var0, var1, var2, var3, var4, var5) {
  var0.isgimme = 1;
  var6 = 0;

  if(isDefined(var5)) {
    var6 = var5;
  }

  if(isDefined(var0)) {
    if(!isDefined(var2)) {
      var2 = var0.streaklifeid;
    }

    if(!isDefined(var3)) {
      var3 = var0.ref_13913;
    }
  }

  slotkillstreak(var0, var6);
  setselectedkillstreak(var6);
  makekillstreakavailable(var6, var1, var2, var3, var4);
}

function equipkillstreak(var0, var1) {
  if(!isDefined(var0) || !isDefined(var1)) {
    return;
  }

  var2 = createstreakitemstruct(var0);
  slotkillstreak(var2, var1);
}

function equipslotonekillstreak(var0) {
  equipkillstreak(var0, 1);
}

function equipslottwokillstreak(var0) {
  equipkillstreak(var0, 2);
}

function equipslotthreekillstreak(var0) {
  equipkillstreak(var0, 3);
}

function pushgimmeslotstreakontostack() {
  var0 = getplayerstreakdata();

  if(isDefined(var0.streaks[36])) {
    return false;
  }

  var1 = var0.streaks[0];

  if(!isDefined(var1)) {
    return true;
  }

  for(var2 = 5; var2 < 37; var2++) {
    if(!isDefined(var0.streaks[var2])) {
      var0.streaks[var2] = var1;
      var0.streaks[0] = undefined;
      break;
    }
  }

  return true;
}

function popstackedstreakintogimmeslot() {
  var0 = getplayerstreakdata();
  var1 = var0.streaks[0];
  var2 = undefined;
  var3 = undefined;

  for(var4 = 5; var4 < 37; var4++) {
    var5 = var0.streaks[var4];

    if(isDefined(var5)) {
      var2 = var5;
      var3 = var4;
      continue;
    }

    break;
  }

  var0.streaks[0] = var2;

  if(isDefined(var3)) {
    var0.streaks[var3] = undefined;
    return;
  }
}

function deletestackedstreak(var0) {
  var1 = getplayerstreakdata();

  if(var0 == 36) {
    var1.streaks[var0] = undefined;
    return;
  }

  for(var2 = var0; var2 < 36; var2++) {
    var3 = var1.streaks[var2 + 1];

    if(!isDefined(var3)) {
      break;
    }

    var1.streaks[var0] = var3;
  }
}

function removekillstreak(var0) {
  self.streakdata.streaks[var0] = undefined;

  if(var0 == 0) {
    popstackedstreakintogimmeslot();
    return;
  }

  if(var0 >= 5) {
    deletestackedstreak(var0);
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

function slotkillstreak(var0, var1) {
  if(var1 == 0) {
    if(!pushgimmeslotstreakontostack()) {
      return;
    }
  }

  self.streakdata.streaks[var1] = var0;
  updatekillstreakuislot(var1);

  if(var1 != 0) {
    updatestreakcost(var1);
    return;
  }
}

function earnkillstreak(var0, var1) {
  var2 = getkillstreakinslot(var0);
  var3 = var2.streakname;
  scripts\mp\utility\script::bufferednotify("earned_killstreak_buffered", var3);
  self.earnedstreaklevel = var1;

  if(scripts\mp\utility\perk::_hasperk("specialty_support_killstreaks")) {
    self.streakdata.streaks[var0].earned = 1;
  }

  self.streakdata.streaks[var0].lifeid = scripts\cp_mp\utility\killstreak_utility::getcurrentplayerlifeidforkillstreak();

  if(!level.gameended) {
    thread scripts\mp\hud_message::showkillstreaksplash(var3, var1);
    combatrecordincrementkillstreakawardedstat(var3);
  }

  setstreakcounttonext();
  makekillstreakavailable(var0, "earned");
}

function makekillstreakavailable(var0, var1, var2, var3, var4) {
  var5 = getkillstreakinslot(var0);

  if(!isDefined(var5)) {
    return;
  }

  var6 = var5.streakname;

  if(isDefined(var5.ref_136d2)) {
    var6 = var5.ref_136d2;
  }

  loadassociatedkillstreakweapons(var6);
  var7 = var5.streaksetupinfo;

  if(self.team == "spectator") {
    return;
  }

  var5.available = 1;
  ammobox_clearbufferedattachmentweapon(var0, var5.available);
  setselectedkillstreak(var0);
  updatekillstreakuislot(var0);

  if(isDefined(var7.availablefunc)) {
    self[[var7.availablefunc]](var5);
  }

  if(var5.isgimme) {
    self notify("received_earned_killstreak");
  }

  var5.madeavailabletime = scripts\mp\matchdata::gettimefrommatchstart(gettime());
  var5.streaklifeid = self.lifeid;
  var5.ref_13913 = self.matchdatalifeindex;
  var5.owner = self;
  var5.ref_121b0 = self getxuid();

  if(isDefined(var2)) {
    var5.streaklifeid = var2;
  }

  if(isDefined(var3)) {
    var5.ref_13913 = var3;
  }

  if(isDefined(var4)) {
    var5.owner = var4;
    var5.ref_121b0 = var4 getxuid();
  }

  scripts\cp\vehicles\vehicle_compass_cp::ref_12047(var5.streakname, var1);
  scripts\mp\analyticslog::logevent_killstreakavailable(self, var5.ref_13913, var6, var5.isgimme, var5.madeavailabletime, self.origin);

  if(isDefined(self.petwatch) && var0 == removeincoming()) {
    var8 = 0;
    var9 = 0;
    var10 = getallavailablekillstreakstructs();

    foreach(var12 in var10) {
      var13 = getvisiblekillstreakavailable(var12.streakname);

      switch (var13) {
        case 1:
          var8 = var12.streaklifeid == self.lifeid;
          break;
        case 2:
          var9 = var12.streaklifeid == self.lifeid;
          break;
        default:
          break;
      }
    }

    if(var8 && var9) {
      scripts\cp_mp\pet_watch::battle_tracks_getplayerdataenum();
    } else {
      scripts\cp_mp\pet_watch::battle_tracks_getnewtogglestate();
    }
  }
}

function ammobox_getbufferedattachment(var0, var1) {
  if(var0 > removeincoming()) {
    return;
  }

  self setclientkillstreakavailability(var0, var1);
}

function ammobox_clearbufferedattachmentweapon(var0, var1) {
  if(var0 > removeincoming()) {
    return;
  }

  self setpowerammo(var0, var1);
}

function givekillstreak(var0, var1, var2) {
  awardkillstreak(var0, "other");
}

function calcstreakcost(var0) {
  var1 = int(scripts\mp\utility\killstreak::getkillstreakkills(var0));

  if(isDefined(self) && isPlayer(self)) {
    var1 += getperkadjustedkillstreakcost(var0, var1);
  }

  var1 = int(clamp(var1, 0, 7000));
  return var1;
}

function getperkadjustedkillstreakcost(var0, var1) {
  var2 = 0;

  if(scripts\mp\utility\perk::_hasperk("specialty_support_killstreaks")) {
    var3 = scripts\mp\utility\killstreak::getkillstreakindex(var0);
    var2 = 175 * var3;
  }

  if(scripts\mp\utility\perk::_hasperk("specialty_hardline") && var1 > 0 && var0 != "nuke") {
    if(scripts\mp\utility\perk::_hasperk("specialty_killstreak_to_scorestreak")) {
      var2 -= 125;
    } else {
      var2--;
    }
  }

  return var2;
}

function killstreakselectionwatcher() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    var0 = scripts\engine\utility::ref_143ad("ks_select_up", "ks_select_down");

    if(!scripts\engine\utility::is_player_gamepad_enabled()) {
      continue;
    }

    if(!istrue(self.iscarrying)) {
      var1 = getselectedkillstreakindex();

      if(!isDefined(var1)) {
        continue;
      }

      var2 = var1;

      if(var0 == "ks_select_up") {
        var2 = getnextselectablekillstreakslot(var1);
      } else if(var0 == "ks_select_down") {
        var2 = getpreviousselectablekillstreakslot(var1);
      }

      setselectedkillstreak(var2);
    }
  }
}

function selectfirstavailablekillstreak() {
  var0 = getplayerstreakdata();

  if(isDefined(var0.streaks[0])) {
    if(var0.streaks[0].available == 1) {
      setselectedkillstreak(0);
      return;
    }
  } else {
    for(var1 = removeincoming(); var1 >= 0; var1--) {
      var2 = var0.streaks[var1];

      if(isDefined(var2) && var2.available == 1) {
        setselectedkillstreak(var1);
        return;
      }
    }
  }

  clearkillstreakselection();
}

function getnextselectablekillstreakslot(var0) {
  var1 = var0;
  var2 = scripts\engine\utility::ter_op(var0 >= removeincoming(), 0, var0 + 1);
  var3 = var0;

  for(var4 = var2; var4 != var3; var4 = 0) {
    var5 = self.streakdata.streaks[var4];

    if(isDefined(var5) && var5.available == 1) {
      var1 = var4;
      break;
    }

    var4++;

    if(var4 > removeincoming()) {}
  }

  return var1;
}

function getpreviousselectablekillstreakslot(var0) {
  var1 = var0;
  var2 = scripts\engine\utility::ter_op(var0 <= 0, removeincoming(), var0 - 1);
  var3 = var0;

  for(var4 = var2; var4 != var3; var4 = removeincoming()) {
    var5 = self.streakdata.streaks[var4];

    if(isDefined(var5) && var5.available == 1) {
      var1 = var4;
      break;
    }

    var4--;

    if(var4 < 0) {}
  }

  return var1;
}

function selectmostexpensivekillstreak() {
  var0 = undefined;
  var1 = -1;

  for(var2 = removeincoming(); var2 >= 0; var2--) {
    var3 = self.streakdata.streaks[var2];

    if(isDefined(var3) && var3.available == 1) {
      if(var3.currentcost > var1) {
        var0 = var2;
        var1 = var3.currentcost;
      }
    }
  }

  if(!isDefined(var0)) {
    clearkillstreakselection();
    return;
  }

  setselectedkillstreak(var0);
}

function selectnextavailablekillstreak() {
  var0 = undefined;
  var1 = -1;

  for(var2 = 0; var2 <= removeincoming(); var2++) {
    var3 = self.streakdata.streaks[var2];

    if(isDefined(var3) && var3.available == 1) {
      if(istrue(var3.isgimme)) {
        var0 = var2;
        break;
      }

      if(var3.currentcost > var1) {
        var0 = var2;
        var1 = var3.currentcost;
      }
    }
  }

  if(!isDefined(var0)) {
    clearkillstreakselection();
    return;
  }

  setselectedkillstreak(var0);
}

function setselectedkillstreak(var0) {
  if(var0 != 0 && istrue(self.loadoutusingspecialist)) {
    return;
  }

  var1 = getkillstreakinslot(var0);
  self.currentselectedkillstreakslot = var0;
  updatekillstreakselectedui();

  if(scripts\mp\utility\game::unset_relic_grounded()) {
    var2 = game["killstreakTable"].tabledatabyref[var1.streakname]["brIndex"];
    scripts\mp\gametypes\br_public::updatebrextradata("selectedKillstreakId", var2);
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
  var0 = getselectedkillstreakindex();

  if(!isDefined(var0)) {
    return undefined;
  }

  return self.streakdata.streaks[var0];
}

function getselectedkillstreakindex() {
  return self.currentselectedkillstreakslot;
}

function getkillstreakinslot(var0) {
  return self.streakdata.streaks[var0];
}

function getequippedkillstreakbyname(var0) {
  for(var1 = 1; var1 <= 3; var1++) {
    var2 = self.streakdata.streaks[var1];

    if(isDefined(var2) && var2.streakname == var0) {
      return var2;
    }
  }

  return undefined;
}

function getequippedkillstreakslotbyname(var0) {
  for(var1 = 1; var1 <= 3; var1++) {
    var2 = self.streakdata.streaks[var1];

    if(isDefined(var2) && var2.streakname == var0) {
      return var1;
    }
  }

  return undefined;
}

function getvisiblekillstreakavailable(var0) {
  for(var1 = 0; var1 <= removeincoming(); var1++) {
    var2 = self.streakdata.streaks[var1];

    if(isDefined(var2) && var2.streakname == var0 && var2.available == 1) {
      return var1;
    }
  }

  return undefined;
}

function getkillstreakvisibleslotbyname(var0) {
  for(var1 = 0; var1 <= removeincoming(); var1++) {
    var2 = self.streakdata.streaks[var1];

    if(isDefined(var2) && var2.streakname == var0) {
      return var1;
    }
  }

  return undefined;
}

function getgimmeslotkillstreakstructs() {
  var0 = [];
  var1 = getkillstreakinslot(0);

  if(isDefined(var1)) {
    var0 = var1;

    for(var2 = 5; var2 < 37; var2++) {
      var3 = self.streakdata.streaks[var2];

      if(isDefined(var3)) {
        var0 = var3;
        continue;
      }

      break;
    }
  }

  return var0;
}

function getavailableequippedkillstreakstructs() {
  var0 = [];

  if(self.streakdata.streaks.size > 0) {
    for(var1 = 1; var1 < 4; var1++) {
      var2 = self.streakdata.streaks[var1];

      if(isDefined(var2) && isDefined(var2.streakname) && var2.available == 1) {
        var0 = var2;
      }
    }
  }

  return var0;
}

function getallavailablekillstreakstructs() {
  var0 = [];

  if(self.streakdata.streaks.size > 0) {
    for(var1 = 0; var1 < removeincoming(); var1++) {
      var2 = self.streakdata.streaks[var1];

      if(isDefined(var2) && isDefined(var2.streakname) && var2.available == 1) {
        var0 = var2;
      }
    }
  }

  return var0;
}

function registerkillstreak(var0, var1, var2, var3) {
  if(!isDefined(level.killstreaksetups)) {
    level.killstreaksetups = [];
  }

  var4 = spawnStruct();
  level.killstreaksetups[var0] = var4;
  var4.triggeredfunc = var1;
  var4.availablefunc = var2;
  var4.linkedtotag = var3;
}

function getkillstreaksetupinfo(var0) {
  var1 = level.killstreaksetups[var0];
  return var1;
}

function checkstreakreward(var0, var1) {
  for(var2 = 1; var2 <= 4; var2++) {
    var3 = getkillstreakinslot(var2);

    if(!isDefined(var3)) {
      continue;
    }

    var4 = var3.currentcost;

    if(self.previousstreakpoints >= var4 || var0 < var4) {
      continue;
    }

    if(scripts\mp\utility\perk::_hasperk("specialty_support_killstreaks") && istrue(var3.earned)) {
      continue;
    }

    if(istrue(level.casualscorestreaks) && istrue(var1)) {
      continue;
    }

    if(isDefined(var3.lifeid) && var3.lifeid == self.lifeid && (!istrue(level.ref_145ec) || istrue(level.ref_145ec) && self.streaktype == "specialist") || istrue(level.ref_145ec) && istrue(level.casualscorestreaks) && self.streaktype != "specialist" && var3.available == -1) {
      continue;
    }

    earnkillstreak(var2, var4);
  }
}

function arekillstreaksequipped(var0) {
  var1 = getplayerstreakdata();

  if(!isDefined(var1) || !isDefined(var1.streaks)) {
    return false;
  }

  foreach(var3 in var0) {
    var4 = 0;
    var5 = 1;

    while(var5 <= 4) {
      var6 = var1.streaks[var5];

      if(isDefined(var6)) {
        if(isDefined(var6.streakname) && var6.streakname == var3) {
          if(var6.isspecialist) {
            var7 = scripts\mp\perks\perks::getspecialistperkforstreak(var3);

            if(var6.ref_136d2 == var7) {
              var4 = 1;
              break;
            }
          } else {
            var4 = 1;
            break;
          }
        }
      } else if(var2 == "none") {
        var3 = 1;
        break;
      }

      var4++;
    }

    if(!var3) {
      return false;
    }
  }

  var1 = undefined;
  var6 = undefined;
  return true;
}

function findkillstreakslotnumber(var0) {
  for(var1 = 0; var1 <= 37; var1++) {
    var2 = self.streakdata.streaks[var1];

    if(!isDefined(var2)) {
      if(var1 >= 5) {
        break;
      }

      continue;
    }

    if(var0 == var2) {
      return var1;
    }
  }

  return undefined;
}

function streakglobals_onkillstreaktriggered(var0) {
  if(isDefined(var0.mpstreaksysteminfo)) {
    var1 = onkillstreaktriggered(var0);

    if(!var1) {
      return false;
    }
  }

  return true;
}

function streakglobals_onkillstreakbeginuse(var0) {
  var1 = var0.owner;

  if(isDefined(var0.mpstreaksysteminfo)) {
    var2 = onkillstreakbeginuse(var0);

    if(!var2) {
      return false;
    }
  }

  if(isDefined(var1)) {
    if(level.codcasterenabled) {
      if(iskillstreakvisibleforcodcaster(var0.streakname)) {
        var1 setnoteworthykillstreakactive(1);
      }
    }

    if(scripts\mp\utility\game::ismlgmatch()) {
      var3 = int(tablelookup("mp/killstreaktable.csv", 1, var0.streakname, 4));

      if(var3 >= 1000) {
        var4 = tablelookup("mp/killstreaktable.csv", 1, var0.streakname, 0);

        if(var4 != "") {
          var5 = int(var4);
        }
      }
    }
  }

  return true;
}

function streakglobals_onkillstreakfinishuse(var0) {
  var1 = var0.owner;
  var2 = 0;

  if(isDefined(var1)) {
    var2 = var1 scripts\mp\utility\killstreak::hasplayerdiedwhileusingkillstreak(var0);
  }

  if(isDefined(var0.mpstreaksysteminfo)) {
    onkillstreakfinishuse(var0, var2);
  }

  if(isDefined(var1)) {
    if(!var2) {
      var1 notify("killstreak_use_finished");
    }

    if(level.codcasterenabled) {
      var1 setnoteworthykillstreakactive(0);
      return;
    }

    return;
  }
}

function givestreakpoints(var0, var1, var2) {
  if(istrue(game["isLaunchChunk"])) {
    return;
  }

  var3 = scripts\engine\utility::ter_op(scripts\mp\utility\perk::_hasperk("specialty_killstreak_to_scorestreak"), var2, var1);

  if(!isDefined(var3)) {
    var3 = scripts\mp\rank::getscoreinfovalue(var0);
  }

  if(var3 == 0) {
    return;
  }

  self.pers["killstreakToScorestreak"] = undefined;
  self.pers["killstreakToScorestreak_lifeId"] = undefined;
  var4 = self.streakpoints + var3;
  var5 = findmaxstreakcost();

  if(var4 > var5) {
    var4 = var5;
  }

  var6 = var0 == "kill";

  if(var6 && !istrue(level.loadout_updateclassdefault_weapons) && (istrue(level.allowkillstreaks) || isDefined(level.ref_12305))) {
    var7 = self.nukepoints + var1;
    var8 = calcstreakcost("nuke");

    if(isDefined(level.ref_12305)) {
      var8 = level.ref_12305;
    }

    if(var7 >= var8) {
      self.nukepoints = var8;

      if(!istrue(self.molotov_delete_scriptable)) {
        thread scripts\mp\hud_message::showkillstreaksplash("nuke", var8);
        awardkillstreak("nuke", "earned");
        self.molotov_delete_scriptable = 1;
      }
    } else {
      self.nukepoints = var7;

      if(isDefined(self.petwatch)) {
        scripts\cp_mp\pet_watch::ref_13ffd(self.nukepoints / var8);
      }
    }
  }

  setstreakpoints(var4);
  checkstreakreward(var4);
  updatestreakmeterui();

  if(istrue(level.ref_145ec && self.streaktype != "specialist")) {
    if(var4 >= var5) {
      var4 -= var5;
      setstreakpoints(var4);
      self setkillstreakpoints(var4);
      setstreakcounttonext();
      resetstreakavailability();
    }
  }

  scripts\mp\analyticslog::logevent_reportstreakscore(var3, gettime(), scripts\mp\rank::getscoreinfocategory(var0, "eventID"));
}

function isbountyevent(var0) {
  return var0 == "bounty";
}

function iskillstreakkillevent(var0) {
  return issubstr(var0, "ss_kill") || var0 == "killstreak_full_score";
}

function resetstreakpoints() {
  self.earnedstreaklevel = 0;
  self.nukepoints = 0;
  setstreakpoints(0);
  resetstreakcount();
  updatestreakmeterui();
}

function resetstreakavailability(var0) {
  if(!isDefined(self)) {
    return;
  }

  for(var1 = 0; var1 <= 4; var1++) {
    var2 = self.streakdata.streaks[var1];

    if(isDefined(var2) && isDefined(var2.streakname)) {
      if(istrue(var0)) {
        var2.available = 0;
      } else if(istrue(var2.isspecialist)) {
        var2.available = 0;
      } else if(var2.available == -1) {
        var2.available = 0;
      }

      ammobox_clearbufferedattachmentweapon(var1, var2.available);
    }
  }
}

function ref_13db8() {
  for(var0 = 1; var0 <= 4; var0++) {
    var1 = self.streakdata.streaks[var0];

    if(isDefined(var1) && istrue(var1.available)) {
      var2 = var1.streaksetupinfo;

      if(isDefined(var2.availablefunc)) {
        self[[var2.availablefunc]](var1);
      }
    }
  }
}

function setstreakpoints(var0) {
  if(var0 < 0) {
    var0 = 0;
  }

  if(isDefined(self.streakpoints)) {
    self.previousstreakpoints = self.streakpoints;
  } else {
    self.previousstreakpoints = 0;
  }

  self.streakpoints = var0;
  updatestreakcount();
}

function storescorestreakpointsongameend() {
  level waittill("game_ended");

  if(level.roundretainstreakprog) {
    foreach(var1 in level.players) {
      if(!isDefined(var1)) {
        continue;
      }

      var2 = 0;

      if(isDefined(var1.streakpoints)) {
        if(var1 scripts\mp\utility\perk::_hasperk("specialty_killstreak_to_scorestreak")) {
          var2 = scripts\mp\perks\perkfunctions::vote_player_set(var1.streakpoints);
        } else {
          var2 = var1.streakpoints;
        }
      }

      var1.pers["streakPoints"] = var2;
    }

    return;
  }
}

function findunobstructedfiringpointaroundz(var0, var1, var2, var3) {
  var4 = rotatevector((0, 0, 1), (-1 * var3, 0, 0));
  var5 = vectortoangles(var1 - var0.origin);
  var6 = 0;

  while(var6 < 360) {
    var7 = var2 * rotatevector(var4, (0, var6 + var5[1], 0));
    var8 = var1 + var7;

    if(_findunobstructedfiringpointhelper(var0, var8, var1)) {
      return var8;
    }

    var6 += 30;
  }

  return undefined;
}

function findunobstructedfiringpointaroundy(var0, var1, var2, var3, var4, var5) {
  var6 = vectortoangles(var0.origin - var1);
  var7 = var3;

  while(var7 <= var4) {
    var8 = rotatevector((1, 0, 0), (var7 - 90, 0, 0));
    var9 = var2 * rotatevector(var8, (0, var6[1], 0));
    var10 = var1 + var9;

    if(_findunobstructedfiringpointhelper(var0, var10, var1)) {
      return var10;
    }

    var7 += var5;
  }

  return undefined;
}

function _findunobstructedfiringpointhelper(var0, var1, var2) {
  var3 = scripts\engine\trace::_bullet_trace(var1, var2, 0);

  if(var3["fraction"] > 0.99) {
    return true;
  }

  return false;
}

function findunobstructedfiringpoint(var0, var1, var2) {
  var3 = findunobstructedfiringpointaroundz(var0, var1, var2, 30);

  if(!isDefined(var3)) {
    var3 = findunobstructedfiringpointaroundy(var0, var1, var2, 15, 75, 15);
  }

  return var3;
}

function killstreakhit(var0, var1, var2, var3, var4) {
  if(isDefined(var1) && isPlayer(var0) && isDefined(var2.owner) && isDefined(var2.owner.team)) {
    if(scripts\cp_mp\utility\player_utility::playersareenemies(var0, var2.owner)) {
      ref_14018(var2, var0, var4);

      if(scripts\mp\utility\weapon::iskillstreakweapon(var1.basename)) {
        return;
      }

      var5 = createheadicon(var1);

      if(!isDefined(var0.lasthittime[var5])) {
        var0.lasthittime[var5] = 0;
      }

      if(var0.lasthittime[var5] == gettime()) {
        return;
      }

      var0.lasthittime[var5] = gettime();
      var0 thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var5, 1, "hits");

      if(scripts\mp\utility\game::onlinestatsenabled()) {
        var6 = var0 scripts\mp\playerstats_interface::getplayerstat("combatStats", "totalShots");
        var7 = var0 scripts\mp\playerstats_interface::getplayerstat("combatStats", "hits") + 1;

        if(var7 <= var6) {
          var0 scripts\mp\playerstats_interface::setplayerstatbuffered(var7, "combatStats", "hits");
          var0 scripts\mp\playerstats_interface::setplayerstatbuffered(int(var6 - var7), "combatStats", "misses");
        }
      }

      if(isDefined(var3) && scripts\engine\utility::isbulletdamage(var3) || scripts\mp\utility\damage::isprojectiledamage(var3)) {
        var0.lastdamagetime = gettime();
        var8 = scripts\mp\utility\weapon::getweapongroup(var1.basename);

        if(var8 == "weapon_lmg") {
          if(!isDefined(var0.shotslandedlmg)) {
            var0.shotslandedlmg = 1;
            return;
          }

          var0.shotslandedlmg++;
          return;
        }

        return;
      }

      return;
    }

    return;
  }
}

function ref_14019(var0) {
  ref_14018(var0, 150);
}

function ref_14018(var0, var1) {
  if(!isDefined(var0) || !isDefined(self)) {
    return;
  }

  if(!isDefined(self.ref_12f3c)) {
    self.ref_12f3c = [];
  }

  var2 = var0 getxuid();
  var0.shoulddeleteimmediately = 1;

  if(!isDefined(self.ref_12f3c[var2])) {
    var3 = spawnStruct();
    var3.damage = 0;
    var3.player = var0;
    self.ref_12f3c[var2] = var3;
  }

  self.ref_12f3c[var2].damage += var1;
}

function rocket_internal(var0) {
  if(!isDefined(self.ref_12f3c)) {
    return [];
  }

  var1 = [];

  foreach(var3 in self.ref_12f3c) {
    var4 = var3.damage;
    var5 = var3.player;

    if(var4 < 150) {
      continue;
    }

    var6 = !scripts\mp\utility\player::isfriendly(self.team, var5);
    var7 = istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var5, self.owner));

    if(!var6 && !var7) {
      continue;
    }

    if(isDefined(var0) && var5 == var0) {
      continue;
    }

    var1 = var5;
  }

  return var1;
}

function givescoreforequipment(var0, var1) {
  if(isDefined(var1) && weaponclass(var1) != "rocketlauncher" && var1.basename != "iw8_la_kgolf_mp") {
    var1 = undefined;
  }

  thread scripts\mp\utility\points::giveunifiedpoints("destroyed_equipment", var1);
  scripts\cp_mp\gestures::processcalloutdeath(var0, self);
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

function givescoreformarktarget(var0) {
  if(var0) {
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

function streaktyperesetsondeath(var0) {
  switch (var0) {
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

function initridekillstreak(var0) {
  scripts\common\utility::allow_usability(0);
  var1 = initridekillstreak_internal(var0);

  if(isDefined(self)) {
    scripts\common\utility::allow_usability(1);
  }

  return var1;
}

function initridekillstreak_internal(var0) {
  if(isDefined(var0) && islaptoptimeoutkillstreak(var0)) {
    var1 = "timeout";
  } else {
    var1 = scripts\engine\utility::ref_143bb(1, "death", "disconnect", "weapon_switch_started");
  }

  scripts\mp\hostmigration::waittillhostmigrationdone();

  if(var1 == "weapon_switch_started") {
    return "fail";
  }

  if(!isalive(self)) {
    return "fail";
  }

  if(var1 == "disconnect" || var1 == "death") {
    if(var1 == "disconnect") {
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

  if(!isDefined(var1) || !issubstr(var1, "pointSelect")) {
    if(var1 == "drone_hive") {
      self visionsetfadetoblackforplayer("black_bw", 0);
      thread scripts\mp\utility\player::set_visionset_for_watching_players("black_bw", 0, 1, undefined, 1);
      var2 = scripts\engine\utility::ref_143b9(0, "death_or_disconnect");
    } else {
      self visionsetfadetoblackforplayer("black_bw", 0.75);
      thread scripts\mp\utility\player::set_visionset_for_watching_players("black_bw", 0.75, 1, undefined, 1);
      var2 = scripts\engine\utility::ref_143b9(0.8, "death_or_disconnect");
    }
  } else {
    var2 = scripts\engine\utility::ref_143b9(1, "death_or_disconnect");
  }

  self notify("black_out_done");
  scripts\mp\hostmigration::waittillhostmigrationdone();

  if(var2 != "disconnect") {
    if(!isDefined(var2) || !issubstr(var2, "pointSelect")) {
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

  if(var2 == "disconnect") {
    return "disconnect";
  }

  return "success";
}

function islaptoptimeoutkillstreak(var0) {
  switch (var0) {
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

function clearrideintro(var0, var1) {
  self endon("disconnect");

  if(isDefined(var0)) {
    wait var0;
  }

  if(!isDefined(var1)) {
    var1 = 0;
  }

  self visionsetfadetoblackforplayer("", var1);
  scripts\mp\utility\player::set_visionset_for_watching_players("", var1);
  self notify("intro_cleared");
}

function allowridekillstreakplayerexit(var0, var1) {
  if(isDefined(var0)) {
    self endon(var0);
  }

  if(!isDefined(self.owner)) {
    return;
  }

  var2 = self.owner;
  level endon("game_ended");
  var2 endon("disconnect");
  var2 endon("end_remote");
  self endon("death");
  var3 = 0.75;

  if(isDefined(var1)) {
    var3 = var1;
  }

  var4 = level.framedurationseconds;
  var5 = 1;

  for(;;) {
    var6 = 0;

    if(var5 == 1) {
      var2 setclientomnvar("ui_exit_progress", 0);
      var5 = 0;
    }

    while(var2 useButtonPressed()) {
      var6 += var4;
      var5 = 1;
      var2 setclientomnvar("ui_exit_progress", var6 / var3);

      if(var6 > var3) {
        self notify("killstreakExit");
        return;
      }

      wait var4;
    }

    wait var4;
  }
}

function combatrecordkillstreakuse(var0) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }

  var1 = scripts\mp\utility\stats::getstreakrecordtype(var0);

  if(!isDefined(var1)) {
    if(var0 != "nuke" && var0 != "explosive_bow") {}

    return;
  }

  var2 = self getplayerdata("mp", "playerStats", var1, var0, "uses");
  self setplayerdata("mp", "playerStats", var1, var0, "uses", var2 + 1);
}

function checkcasualstreaksreset() {
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.streaktype) && self.streaktype == "specialist" || isDefined(self.loadoutstreaktype) && self.loadoutstreaktype == "specialist" || !istrue(level.ref_145ec)) {
    var0 = self.streakdata.streaks[self.streakdata.streaks.size];

    if(var0.available == 1 || var0.available == -1) {
      return 1;
    }
  }

  return 0;
}

function loadassociatedkillstreakweapons(var0) {
  var1 = [];
  var2 = scripts\cp_mp\utility\killstreak_utility::getkillstreakdeployweapon(var0);
  var1 = var2;
  var3 = scripts\cp_mp\utility\killstreak_utility::getkillstreakgameweapons(var0);
  var1 = scripts\engine\utility::array_combine(var1, var3);
  self loadweaponsforplayer(var1, 1);
}

function combatrecordincrementkillstreakawardedstat(var0) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }

  var1 = scripts\mp\utility\stats::getstreakrecordtype(var0);

  if(!isDefined(var1)) {
    return;
  }

  var2 = self getplayerdata("mp", "playerStats", var1, var0, "awardedCount");
  self setplayerdata("mp", "playerStats", var1, var0, "awardedCount", var2 + 1);
}

function hide_player_clip(var0) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }

  var1 = scripts\mp\utility\stats::getstreakrecordtype(var0);

  if(!isDefined(var1)) {
    return;
  }

  var2 = self getplayerdata("mp", "playerStats", var1, var0, "extraStat1");
  self setplayerdata("mp", "playerStats", var1, var0, "extraStat1", var2 + 1);
}
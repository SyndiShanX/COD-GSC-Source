/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\drone\emp_drone.gsc
***********************************************/

function init() {
  level.scoreinfo = [];
  var_0 = getdvarint("online_mp_xpscale");

  if(var_0 > 4 || var_0 < 0) {
    exitlevel(0);
  }

  addglobalrankxpmultiplier(var_0, "online_mp_xpscale");
  var_1 = getdvarint("online_battle_xpscale");

  if(var_1 > 4 || var_1 < 0) {
    exitlevel(0);
  }

  battle_tracks_playerinlisteningzoneinternal(var_1, "online_battle_xpscale_dvar");
  level.ranktable = [];
  level.weaponranktable = [];
  var_2 = function_0428();
  level.maxrank = int(tablelookup(var_2, 0, "maxrank", 1));
  level.ref_11b5c = int(tablelookup(var_2, 0, "maxelder", 1));

  for(var_3 = 0; var_3 <= level.maxrank; var_3++) {
    level.ranktable[var_3]["minXP"] = tablelookup(var_2, 0, var_3, 2);
    level.ranktable[var_3]["xpToNext"] = tablelookup(var_2, 0, var_3, 3);
    level.ranktable[var_3]["maxXP"] = tablelookup(var_2, 0, var_3, 7);
    level.ranktable[var_3]["splash"] = tablelookup(var_2, 0, var_3, 15);
  }

  scripts\cp\cp_weaponrank::init();
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
  level.prestigeextras = [];
  thread onplayerconnect();
}

function molotov_delete_trigger() {
  self notify("earnPeriodicXP");
  self endon("earnPeriodicXP");
  self endon("disconnect");
  level endon("game_ended");
  var_0 = "persistent_xp";

  while(!scripts\cp_mp\utility\player_utility::_isalive()) {
    waitframe();
  }

  if(!scripts\cp\utility::turn_off_sniper_laser() && !scripts\cp\utility::tryingtoleave()) {
    if(!scripts\engine\utility::ent_flag_exist("player_spawned_with_loadout")) {
      scripts\engine\utility::ent_flag_init("player_spawned_with_loadout");
    }

    scripts\engine\utility::ent_flag_wait("player_spawned_with_loadout");
  } else {
    wait 15;
  }

  self.pers["periodic_xp_participation"] = 0;
  var_1 = self.pers["periodic_xp_participation"];

  for(;;) {
    if(var_1 == self.pers["periodic_xp_participation"]) {
      waitframe();
      continue;
    }

    if(!scripts\cp_mp\utility\player_utility::_isalive()) {
      waitframe();
      continue;
    }

    var_2 = getscoreinfovalue(var_0);
    thread giverankxp(var_0, var_2, undefined, 1);
    var_1 = self.pers["periodic_xp_participation"];
    wait 60;
  }
}

function isregisteredevent(var_0) {
  if(isDefined(level.scoreinfo[var_0])) {
    return 1;
  }

  return 0;
}

function registerscoreinfo(var_0, var_1, var_2) {
  level.scoreinfo[var_0][var_1] = var_2;

  if(var_0 == "kill" && var_1 == "value") {
    setomnvar("ui_game_type_kill_value", int(var_2));
    return;
  }
}

function getscoreinfovalue(var_0) {
  var_1 = "scr_" + scripts\cp\utility::getgametype() + "_score_" + var_0;

  if(getDvar(var_1) != "") {
    return getdvarint(var_1);
  }

  return level.scoreinfo[var_0]["value"];
}

function getscoreinfocategory(var_0, var_1) {
  if(istrue(level.removekilleventsplash) && !isDefined(level.scoreinfo[var_0])) {
    return;
  }

  switch (var_1) {
    case "value":
      var_2 = "scr_" + scripts\cp\utility::getgametype() + "_score_" + var_0;

      if(getDvar(var_2) != "") {
        return getdvarint(var_2);
      } else {
        return level.scoreinfo[var_0]["value"];
      }
    default:
      return level.scoreinfo[var_0][var_1];
  }
}

function getrankinfominxp(var_0) {
  return int(level.ranktable[var_0]["minXP"]);
}

function getrankinfoxpamt(var_0) {
  return int(level.ranktable[var_0]["xpToNext"]);
}

function getrankinfomaxxp(var_0) {
  return int(level.ranktable[var_0]["maxXP"]);
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(!isai(var_0)) {
      if(level.playerxpenabled) {
        var_0.pers["rankxp"] = var_0 getplayerdata("rankedloadouts", "squadMembers", "player_xp");
        var_1 = var_0 getplayerdata("rankedloadouts", "squadMembers", "season_rank");

        if(!isDefined(var_0.pers["xpEarnedThisMatch"])) {
          var_0.pers["xpEarnedThisMatch"] = 0;
        }
      } else {
        var_1 = 0;
        var_0.pers["rankxp"] = 0;
      }
    } else {
      var_1 = 0;
      var_0.pers["rankxp"] = 0;
    }

    var_0.pers["prestige"] = var_1;

    if(var_0.pers["rankxp"] < 0) {
      var_0.pers["rankxp"] = 0;
    }

    var_2 = getrankforxp(var_0, getrankxp(var_0));
    var_0.pers["rank"] = var_2;
    var_0 setrank(var_2, var_1);
    var_0.pers["participation"] = 0;
    var_0.scoreupdatetotal = 0;
    var_0.scorepointsqueue = 0;
    var_0.scoreeventqueue = [];
    var_0.postgamepromotion = 0;
    var_0 setclientdvar("ui_promotion", 0);

    if(!isDefined(var_0.pers["summary"])) {
      var_0.pers["summary"] = [];
      var_0.pers["summary"]["xp"] = 0;
      var_0.pers["summary"]["score"] = 0;
      var_0.pers["summary"]["challenge"] = 0;
      var_0.pers["summary"]["match"] = 0;
      var_0.pers["summary"]["misc"] = 0;
      var_0.pers["summary"]["medal"] = 0;
      var_0.pers["summary"]["bonusXP"] = 0;
    }

    var_0 setclientdvar("ui_opensummary", 0);

    if(level.playerxpenabled) {
      var_3 = getdvarint("online_mp_party_xpscale");
      var_4 = var_0 getprivatepartysize() > 1;

      if(var_4) {
        addrankxpmultiplier(var_0, var_3, "online_mp_party_xpscale");
      }

      if(var_0 getplayerdata("mp", "prestigeDoubleWeaponXp")) {
        var_0.prestigedoubleweaponxp = 1;
      } else {
        var_0.prestigedoubleweaponxp = 0;
      }

      var_5 = getdvarint("scr_xp_limit", 40000);
      var_0.ref_11b7f = var_5;
      var_0.totalxpearned = 0;
    }

    var_0.scoreeventcount = 0;
    var_0.scoreeventlistindex = 0;
    var_0.ref_13bf3 = 0;
    var_0.ref_11b67 = 3000;

    if(!scripts\cp\utility::tryingtoleave() && !scripts\cp\utility::turn_off_sniper_laser()) {
      thread molotov_delete_trigger();
    }
  }
}

function onplayerspawned() {
  if(isai(self)) {} else if(!level.playerxpenabled) {
    self.pers["rankxp"] = 0;
  } else if(scripts\cp\utility::tryingtoleave()) {}

  playerupdaterank();
  ref_125e5();
}

function playerupdaterank() {
  if(self.pers["rankxp"] < 0) {
    self.pers["rankxp"] = 0;
  }

  var_0 = getrankforxp(getrankxp());
  self.pers["rank"] = var_0;

  if(isai(self) || !isDefined(self.pers["prestige"])) {
    if(level.playerxpenabled && isDefined(self.bufferedstats)) {
      var_1 = getprestigelevel();
    } else {
      var_1 = 0;
    }

    self setrank(var_1, var_1);
    self.pers["prestige"] = var_1;
    return;
  }
}

function ref_125e5() {
  scripts\cp\agents\agents::initpersstat("lastBulletKillTime");
  scripts\cp\agents\agents::initpersstat("bulletStreak");
  scripts\cp\agents\agents::initpersstat("assists");
}

function tryresetrankxp() {
  if(issubstr(self.class, "custom")) {
    if(!level.playerxpenabled) {
      self.pers["rankxp"] = 0;
      return;
    }

    if(isai(self)) {
      self.pers["rankxp"] = 0;
      return;
    }

    return;
  }
}

function giverankxp(var_0, var_1, var_2, var_3) {
  self endon("disconnect");

  if(isDefined(self.owner) && !isbot(self) && self.owner != self) {
    giverankxp(self.owner, var_0, var_1, var_2);
    return;
  }

  if(isai(self) || !isPlayer(self)) {
    return;
  }

  if(!isDefined(var_1)) {
    return;
  }

  var_4 = botnodeavailabletoteam(self);
  var_1 = int(var_1 * var_4);

  if(!level.playerxpenabled) {
    scripts\cp\agents\gametype_cp_wave_sv::displayscoreeventpoints(var_1, var_0);
    return;
  }

  if(!isDefined(var_1) || var_1 == 0) {
    return;
  }

  var_5 = getscoreinfocategory(var_0, "group");
  var_6 = getscoreinfocategory(var_0, "allowBonus");
  var_7 = 1;
  var_8 = var_1;
  var_9 = 0;

  if(istrue(var_6)) {
    var_7 = getrankxpmultipliertotal();
    var_8 = int(var_1 * var_7);
    var_9 = int(max(var_8 - var_1, 0));
  }

  if(!istrue(var_3)) {
    scripts\cp\agents\gametype_cp_wave_sv::displayscoreeventpoints(var_8, var_0);
  }

  thread waitandapplyxp(var_0, var_1, var_8, var_9, var_2);
}

function waitandapplyxp(var_0, var_1, var_2, var_3, var_4) {
  self endon("disconnect");
  waitframe();
  var_5 = getrankxp();

  if(updaterank(var_5)) {
    thread updaterankannouncehud();
  }

  syncxpstat();
  var_6 = 0;

  if(isDefined(var_4) && scripts\cp\cp_weaponrank::weaponshouldgetxp(var_4.basename)) {
    var_6 = var_1;
    var_6 *= scripts\cp\cp_weaponrank::getweaponrankxpmultipliertotal();
    var_6 = int(var_6);
  }

  incrankxp(var_2, var_4, var_6, var_0);

  if(level.playerxpenabled && !isai(self)) {
    if(isDefined(var_4) && (scripts\cp\cp_weapon::iscacprimaryweapon(var_4) || scripts\cp\cp_weapon::iscacsecondaryweapon(var_4)) && !scripts\cp\cp_weapon::ispickedupweapon(var_4)) {}
  }

  recordxpgains(var_0, var_1, var_3);
  var_7 = getprestigelevel();
  var_8 = getrank();
}

function recordxpgains(var_0, var_1, var_2) {
  var_3 = var_1 + var_2;
  var_4 = getscoreinfocategory(var_0, "group");

  if(!isDefined(var_4) || var_4 == "") {
    self.pers["summary"]["misc"] = self.pers["summary"]["misc"] + var_1;
    self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var_2;
    self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_3;
    return;
  }

  switch (var_4) {
    case "match_bonus":
      self.pers["summary"]["match"] = self.pers["summary"]["match"] + var_1;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var_2;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_3;
      break;
    case "challenge":
      self.pers["summary"]["challenge"] = self.pers["summary"]["challenge"] + var_1;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var_2;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_3;
      break;
    case "medal":
      self.pers["summary"]["medal"] = self.pers["summary"]["medal"] + var_1;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var_2;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_3;
      break;
    default:
      self.pers["summary"]["score"] = self.pers["summary"]["score"] + var_1;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var_2;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_3;
      break;
  }
}

function updaterank(var_0) {
  var_1 = getrank();
  var_2 = getprestigelevel();
  var_3 = self.pers["rank"] + self.pers["prestige"];
  var_4 = var_1 + var_2;
  self.pers["rank"] = var_1;
  self.pers["prestige"] = var_2;

  if(var_4 == var_3 || var_4 >= level.maxrank + level.ref_11b5c) {
    return false;
  }

  self setrank(var_1, var_2);
  return true;
}

function updaterankannouncehud() {
  self endon("disconnect");
  self notify("update_rank");
  self endon("update_rank");
  var_0 = self.pers["team"];

  if(!isDefined(var_0)) {
    return;
  }

  if(!scripts\mp\flags::levelflag("game_over")) {
    level scripts\engine\utility::waittill_notify_or_timeout("game_over", 0.25);
  }

  var_1 = self.pers["rank"] + self.pers["prestige"];

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    var_3 = level.players[var_2];
    var_4 = var_3.pers["team"];

    if(isDefined(var_4) && var_4 == var_0) {}
  }
}

function queuescorepointspopup(var_0) {
  self.scorepointsqueue += var_0;
}

function flushscorepointspopupqueue() {
  scorepointspopup(self.scorepointsqueue);
  self.scorepointsqueue = 0;
}

function flushscorepointspopupqueueonspawn() {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self notify("flushScorePointsPopupQueueOnspawn()");
  self endon("flushScorePointsPopupQueueOnspawn()");
  self waittill("spawned_player");
  wait 0.1;
  flushscorepointspopupqueue();
}

function scorepointspopup(var_0, var_1) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");

  if(var_0 == 0) {
    return;
  }

  if(!scripts\cp\utility\player::isreallyalive(self) && !self ismlgspectator() && !scripts\cp\utility\player::isusingremote()) {
    if(!istrue(var_1) || scripts\cp\utility\player::isinkillcam()) {
      queuescorepointspopup(var_0);
      thread flushscorepointspopupqueueonspawn();
      return;
    }
  }

  self notify("scorePointsPopup");
  self endon("scorePointsPopup");
  self.scoreupdatetotal += var_0;
  self setclientomnvar("ui_points_popup", self.scoreupdatetotal);
  self setclientomnvar("ui_points_popup_notify", gettime());
  wait 1;
  self.scoreupdatetotal = 0;
}

function notifyplayerscore() {
  waitframe();
  level notify("update_player_score", self, self.scoreupdatetotal);
}

function queuescoreeventpopup(var_0) {
  self.scoreeventqueue[self.scoreeventqueue.size] = var_0;
}

function flushscoreeventpopupqueue() {
  foreach(var_1 in self.scoreeventqueue) {
    scoreeventpopup(var_1);
  }

  self.scoreeventqueue = [];
}

function flushscoreeventpopupqueueonspawn() {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self notify("flushScoreEventPopupQueueOnspawn()");
  self endon("flushScoreEventPopupQueueOnspawn()");
  self waittill("spawned_player");
  wait 0.1;
  flushscoreeventpopupqueue();
}

function getscoreeventpriority(var_0) {
  if(getdvarint("scr_disableScoreSplash", 0) == 1) {
    return 0;
  }

  var_1 = getscoreinfocategory(var_0, "priority");

  if(!istrue(var_1)) {
    return 0;
  }

  return var_1;
}

function scoreeventalwaysshowassplash(var_0) {
  if(getdvarint("scr_disableScoreSplash", 0) == 1) {
    return false;
  }

  var_1 = getscoreinfocategory(var_0, "alwaysShowSplash");

  if(!istrue(var_1)) {
    return false;
  }

  return true;
}

function scoreeventhastext(var_0) {
  if(getdvarint("scr_disableScoreSplash", 0) == 1) {
    return false;
  }

  var_1 = getscoreinfocategory(var_0, "eventID");
  var_2 = getscoreinfocategory(var_0, "text");

  if(!isDefined(var_1) || var_1 < 0 || !isDefined(var_2) || var_2 == "") {
    return false;
  }

  return true;
}

function scoreeventpopup(var_0) {
  if(getdvarint("scr_disableScoreSplash", 0) == 1) {
    return;
  }

  if(isDefined(self.owner) && self.owner != self) {
    scoreeventpopup(self.owner, var_0);
  }

  if(!isPlayer(self)) {
    return;
  }

  var_1 = getscoreinfocategory(var_0, "eventID");
  var_2 = getscoreinfocategory(var_0, "text");

  if(!isDefined(var_1) || var_1 < 0 || !isDefined(var_2) || var_2 == "") {
    return;
  }

  if(!scripts\cp\utility\player::isreallyalive(self) && !self ismlgspectator() && !scripts\cp\utility\player::isusingremote()) {
    queuescoreeventpopup(var_0);
    thread flushscoreeventpopupqueueonspawn();
    return;
  }

  if(!isDefined(self.scoreeventlistsize)) {
    self.scoreeventlistsize = 1;
    thread clearscoreeventlistafterwait();
  } else {
    self.scoreeventlistsize++;

    if(self.scoreeventlistsize > 5) {
      self.scoreeventlistsize = 5;
      return;
    }
  }

  self setclientomnvar("ui_score_event_list_" + self.scoreeventlistindex, var_1);
  self setclientomnvar("ui_score_event_control", self.scoreeventcount % 10);
  self.scoreeventlistindex++;
  self.scoreeventlistindex %= 5;
  self.scoreeventcount++;
}

function clearscoreeventlistafterwait() {
  self endon("disconnect");
  self notify("clearScoreEventListAfterWait()");
  self endon("clearScoreEventListAfterWait()");
  scripts\engine\utility::waittill_notify_or_timeout("death", 0.5);
  self.scoreeventlistsize = undefined;
}

function getrank() {
  var_0 = self.pers["rankxp"];
  var_1 = self.pers["rank"];

  if(var_0 < getrankinfominxp(var_1) + getrankinfoxpamt(var_1)) {
    return var_1;
  }

  return getrankforxp(var_0);
}

function getrankforxp(var_0) {
  var_1 = level.maxrank;

  if(var_0 >= getrankinfominxp(var_1)) {
    return var_1;
  } else {
    var_1--;
  }

  while(var_1 > 0) {
    if(var_0 >= getrankinfominxp(var_1) && var_0 < getrankinfominxp(var_1) + getrankinfoxpamt(var_1)) {
      return var_1;
    }

    var_1--;
  }

  return var_1;
}

function getmatchbonusspm() {
  var_0 = getrank() + 1;
  return (3 + var_0 * 0.5) * 10;
}

function getprestigelevel() {
  if(isai(self) && isDefined(self.pers["prestige_fake"])) {
    return self.pers["prestige_fake"];
  }

  return self getplayerdata("rankedloadouts", "squadMembers", "season_rank");
}

function getrankxp() {
  return self.pers["rankxp"];
}

function incrankxp(var_0, var_1, var_2, var_3) {
  if(!level.playerxpenabled) {
    return;
  }

  if(isai(self)) {
    return;
  }

  if(!isDefined(level.ref_11b53)) {
    level.ref_11b53 = getdvarint("scr_beta_max_level", 0);
  }

  if(level.ref_11b53 > 0 && getrank() + 1 >= level.ref_11b53) {
    var_0 = 0;
  }

  if(isDefined(self.totalxpearned) && isDefined(self.ref_11b7f)) {
    if(self.totalxpearned > self.ref_11b7f) {
      var_0 = 0;
    } else {
      self.totalxpearned += var_0;
    }
  }

  var_4 = getrankxp();
  var_5 = int(min(var_4 + var_0, getrankinfomaxxp(level.maxrank) - 1));

  if(self.pers["rank"] == level.maxrank && var_5 >= getrankinfomaxxp(level.maxrank)) {
    var_5 = getrankinfomaxxp(level.maxrank);
  }

  self.pers["xpEarnedThisMatch"] = self.pers["xpEarnedThisMatch"] + var_0;
  self.pers["rankxp"] = var_5;
  var_6 = "";

  if(isDefined(var_1)) {
    var_6 = scripts\cp\utility::relic_nuketimer_globalthread(var_1.basename);
  }

  if(isDefined(var_6) && var_6 != "") {
    if(isDefined(self.ref_13bfc) && isDefined(self.ref_11b7e)) {
      if(self.ref_13bfc > self.ref_11b7e) {
        var_2 = 0;
      } else {
        self.ref_13bfc += var_2;
      }
    }
  }

  var_7 = registerpublicevent();
  var_8 = var_0 * var_7;
  var_9 = getrankxpmultipliertotal();
  var_10 = scripts\cp\cp_weaponrank::getweaponrankxpmultipliertotal();
  var_11 = int(scripts\cp_mp\utility\game_utility::gettimesincegamestart() / 1000);
  self reportchallengeuserevent("mp_addxp", var_0, scripts\cp\survival\survival_loadout::lookupcurrentoperator(self.team), var_6, var_2, var_8, int(var_9 * 100), int(var_10 * 100), int(var_7 * 100), var_11);
  scripts\cp\cp_analytics::ref_119bf(self, var_0, var_6, var_2, var_3);
}

function registerpublicevent() {
  var_0 = registerpreviousprop();
  var_1 = remindermessage();
  var_2 = radiusdamagestepped(self);
  var_3 = var_0 * var_1 * var_2;
  return var_3;
}

function syncxpstat() {
  var_0 = getrankxp();
  var_1 = self getplayerdata("common", "mpProgression", "playerLevel", "xp");

  if(var_1 > var_0) {
    return;
  }

  self setplayerdata("common", "mpProgression", "playerLevel", "xp", var_0);
}

function getgametypexpmultiplier() {
  if(!isDefined(level.gametypexpmodifier)) {
    level.gametypexpmodifier = float(tablelookup("mp/gametypesTable.csv", 0, scripts\cp\utility::getgametype(), 17));
  }

  return level.gametypexpmodifier;
}

function addglobalrankxpmultiplier(var_0, var_1) {
  addrankxpmultiplier(level, var_0, var_1);
}

function getglobalrankxpmultiplier() {
  var_0 = getrankxpmultiplier(level);

  if(var_0 > 4 || var_0 < 0) {
    exitlevel(0);
  }

  return var_0;
}

function respawntagsfreed() {
  if(self resetclientkillstreakindexes()) {
    return getbnetigrweaponxpmultiplier();
  }

  return 1;
}

function addrankxpmultiplier(var_0, var_1) {
  if(!isDefined(self.rankxpmultipliers)) {
    self.rankxpmultipliers = [];
  }

  if(isDefined(self.rankxpmultipliers[var_1])) {
    self.rankxpmultipliers[var_1] = max(self.rankxpmultipliers[var_1], var_0);
    return;
  }

  self.rankxpmultipliers[var_1] = var_0;
}

function getrankxpmultiplier() {
  if(!isDefined(self.rankxpmultipliers)) {
    return 1;
  }

  var_0 = 1;

  foreach(var_2 in self.rankxpmultipliers) {
    if(!isDefined(var_2)) {
      continue;
    }

    var_0 *= var_2;
  }

  return var_0;
}

function removeglobalrankxpmultiplier(var_0) {
  removerankxpmultiplier(level, var_0);
}

function removerankxpmultiplier(var_0) {
  if(!isDefined(self.rankxpmultipliers)) {
    return;
  }

  if(!isDefined(self.rankxpmultipliers[var_0])) {
    return;
  }

  self.rankxpmultipliers[var_0] = undefined;
}

function addteamrankxpmultiplier(var_0, var_1, var_2) {
  if(!level.teambased) {
    var_1 = "all";
  }

  if(!isDefined(self.teamrankxpmultipliers)) {
    level.teamrankxpmultipliers = [];
  }

  if(!isDefined(level.teamrankxpmultipliers[var_1])) {
    level.teamrankxpmultipliers[var_1] = [];
  }

  if(isDefined(level.teamrankxpmultipliers[var_1][var_2])) {
    level.teamrankxpmultipliers[var_1][var_2] = max(self.teamrankxpmultipliers[var_1][var_2], var_0);
    return;
  }

  level.teamrankxpmultipliers[var_1][var_2] = var_0;
}

function removeteamrankxpmultiplier(var_0, var_1) {
  if(!level.teambased) {
    var_0 = "all";
  }

  if(!isDefined(level.teamrankxpmultipliers)) {
    return;
  }

  if(!isDefined(level.teamrankxpmultipliers[var_0])) {
    return;
  }

  if(!isDefined(level.teamrankxpmultipliers[var_0][var_1])) {
    return;
  }

  level.teamrankxpmultipliers[var_0][var_1] = undefined;
}

function getteamrankxpmultiplier(var_0) {
  if(!level.teambased) {
    var_0 = "all";
  }

  if(!isDefined(level.teamrankxpmultipliers) || !isDefined(level.teamrankxpmultipliers[var_0])) {
    return 1;
  }

  var_1 = 1;

  foreach(var_3 in level.teamrankxpmultipliers[var_0]) {
    if(!isDefined(var_3)) {
      continue;
    }

    var_1 *= var_3;
  }

  return var_1;
}

function getrankxpmultipliertotal() {
  var_0 = getrankxpmultiplier();
  var_1 = getglobalrankxpmultiplier();
  var_2 = getteamrankxpmultiplier(self.team);
  var_3 = respawntagsfreed();
  return var_0 * var_1 * var_2 * var_3;
}

function battle_tracks_playerinlisteningzoneinternal(var_0, var_1) {
  battle_tracks_gettogglestate(level, var_0, var_1);
}

function remindermessage() {
  var_0 = registerpreviousprop(level);
  var_1 = getdvarint("scr_disable_xp_scale_quit", 0) == 0;

  if((var_0 > 4 || var_0 < 0) && var_1) {
    exitlevel(0);
  }

  return var_0;
}

function battle_tracks_gettogglestate(var_0, var_1) {
  var_2 = 4 / registerpreviousprop(level);

  if(var_0 > var_2) {
    return;
  }

  if(!isDefined(self.cleanupfunc)) {
    self.cleanupfunc = [];
  }

  if(isDefined(self.cleanupfunc[var_1])) {
    self.cleanupfunc[var_1] = max(self.cleanupfunc[var_1], var_0);
    return;
  }

  self.cleanupfunc[var_1] = var_0;
}

function registerpreviousprop() {
  if(!isDefined(self.cleanupfunc)) {
    return 1;
  }

  var_0 = 1;

  foreach(var_2 in self.cleanupfunc) {
    if(!isDefined(var_2)) {
      continue;
    }

    var_0 *= var_2;
  }

  return var_0;
}

function rankedmatchupdates(var_0) {
  setxenonranks(var_0);

  if(hostidledout()) {}

  scripts\cp\agents\gametype_cp_wave_sv::updatematchbonusscores(var_0);
}

function gethostplayer() {
  var_0 = getEntArray("player", "classname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_0[var_1] ishost()) {
      return var_0[var_1];
    }
  }
}

function hostidledout() {
  var_0 = gethostplayer();

  if(isDefined(var_0) && !var_0.hasspawned && !isDefined(var_0.selectedclass)) {
    return true;
  }

  return false;
}

function setxenonranks(var_0) {
  var_1 = level.players;

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(!isDefined(var_3.score) || !isDefined(var_3.pers["team"])) {}
  }

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(!isDefined(var_3.kills) || !isDefined(var_3.deaths)) {
      continue;
    }

    if(120 > var_3.timeplayed["total"]) {
      continue;
    }

    var_4 = (var_3.kills - var_3.deaths) / var_3.timeplayed["total"] / 60;
    setplayerteamrank(var_3, var_3.clientid, var_4);
  }
}
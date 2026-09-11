/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\drone\emp_drone.gsc
***********************************************/

function init() {
  level.scoreinfo = [];
  var0 = getdvarint("LKKNORQKTP");

  if(var0 > 4 || var0 < 0) {
    exitlevel(0);
  }

  addglobalrankxpmultiplier(var0, "online_mp_xpscale");
  var1 = getdvarint("LTKKKPSRSK");

  if(var1 > 4 || var1 < 0) {
    exitlevel(0);
  }

  battle_tracks_playerinlisteningzoneinternal(var1, "online_battle_xpscale_dvar");
  level.ranktable = [];
  level.weaponranktable = [];
  var2 = function_0428();
  level.maxrank = int(tablelookup(var2, 0, "maxrank", 1));
  level.ref_11b5c = int(tablelookup(var2, 0, "maxelder", 1));

  for(var3 = 0; var3 <= level.maxrank; var3++) {
    level.ranktable[var3]["minXP"] = tablelookup(var2, 0, var3, 2);
    level.ranktable[var3]["xpToNext"] = tablelookup(var2, 0, var3, 3);
    level.ranktable[var3]["maxXP"] = tablelookup(var2, 0, var3, 7);
    level.ranktable[var3]["splash"] = tablelookup(var2, 0, var3, 15);
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
  var0 = "persistent_xp";

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
  var1 = self.pers["periodic_xp_participation"];

  for(;;) {
    if(var1 == self.pers["periodic_xp_participation"]) {
      waitframe();
      continue;
    }

    if(!scripts\cp_mp\utility\player_utility::_isalive()) {
      waitframe();
      continue;
    }

    var2 = getscoreinfovalue(var0);
    thread giverankxp(var0, var2, undefined, 1);
    var1 = self.pers["periodic_xp_participation"];
    wait 60;
  }
}

function isregisteredevent(var0) {
  if(isDefined(level.scoreinfo[var0])) {
    return 1;
  }

  return 0;
}

function registerscoreinfo(var0, var1, var2) {
  level.scoreinfo[var0][var1] = var2;

  if(var0 == "kill" && var1 == "value") {
    setomnvar("ui_game_type_kill_value", int(var2));
    return;
  }
}

function getscoreinfovalue(var0) {
  var1 = "scr_" + scripts\cp\utility::getgametype() + "_score_" + var0;

  if(getDvar(var1) != "") {
    return getdvarint(var1);
  }

  return level.scoreinfo[var0]["value"];
}

function getscoreinfocategory(var0, var1) {
  if(istrue(level.removekilleventsplash) && !isDefined(level.scoreinfo[var0])) {
    return;
  }

  switch (var1) {
    case "value":
      var2 = "scr_" + scripts\cp\utility::getgametype() + "_score_" + var0;

      if(getDvar(var2) != "") {
        return getdvarint(var2);
      } else {
        return level.scoreinfo[var0]["value"];
      }
    default:
      return level.scoreinfo[var0][var1];
  }
}

function getrankinfominxp(var0) {
  return int(level.ranktable[var0]["minXP"]);
}

function getrankinfoxpamt(var0) {
  return int(level.ranktable[var0]["xpToNext"]);
}

function getrankinfomaxxp(var0) {
  return int(level.ranktable[var0]["maxXP"]);
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var0);

    if(!isai(var0)) {
      if(level.playerxpenabled) {
        var0.pers["rankxp"] = var0 getplayerdata("rankedloadouts", "squadMembers", "player_xp");
        var1 = var0 getplayerdata("rankedloadouts", "squadMembers", "season_rank");

        if(!isDefined(var0.pers["xpEarnedThisMatch"])) {
          var0.pers["xpEarnedThisMatch"] = 0;
        }
      } else {
        var1 = 0;
        var0.pers["rankxp"] = 0;
      }
    } else {
      var1 = 0;
      var0.pers["rankxp"] = 0;
    }

    var0.pers["prestige"] = var1;

    if(var0.pers["rankxp"] < 0) {
      var0.pers["rankxp"] = 0;
    }

    var2 = getrankforxp(var0, getrankxp(var0));
    var0.pers["rank"] = var2;
    var0 setrank(var2, var1);
    var0.pers["participation"] = 0;
    var0.scoreupdatetotal = 0;
    var0.scorepointsqueue = 0;
    var0.scoreeventqueue = [];
    var0.postgamepromotion = 0;
    var0 setclientdvar("ui_promotion", 0);

    if(!isDefined(var0.pers["summary"])) {
      var0.pers["summary"] = [];
      var0.pers["summary"]["xp"] = 0;
      var0.pers["summary"]["score"] = 0;
      var0.pers["summary"]["challenge"] = 0;
      var0.pers["summary"]["match"] = 0;
      var0.pers["summary"]["misc"] = 0;
      var0.pers["summary"]["medal"] = 0;
      var0.pers["summary"]["bonusXP"] = 0;
    }

    var0 setclientdvar("MQNNLTKNTS", 0);

    if(level.playerxpenabled) {
      var3 = getdvarint("NTLKOKLKRS");
      var4 = var0 getprivatepartysize() > 1;

      if(var4) {
        addrankxpmultiplier(var0, var3, "online_mp_party_xpscale");
      }

      if(var0 getplayerdata("mp", "prestigeDoubleWeaponXp")) {
        var0.prestigedoubleweaponxp = 1;
      } else {
        var0.prestigedoubleweaponxp = 0;
      }

      var5 = getdvarint("scr_xp_limit", 40000);
      var0.ref_11b7f = var5;
      var0.totalxpearned = 0;
    }

    var0.scoreeventcount = 0;
    var0.scoreeventlistindex = 0;
    var0.ref_13bf3 = 0;
    var0.ref_11b67 = 3000;

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

  var0 = getrankforxp(getrankxp());
  self.pers["rank"] = var0;

  if(isai(self) || !isDefined(self.pers["prestige"])) {
    if(level.playerxpenabled && isDefined(self.bufferedstats)) {
      var1 = getprestigelevel();
    } else {
      var1 = 0;
    }

    self setrank(var1, var1);
    self.pers["prestige"] = var1;
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

function giverankxp(var0, var1, var2, var3) {
  self endon("disconnect");

  if(isDefined(self.owner) && !isbot(self) && self.owner != self) {
    giverankxp(self.owner, var0, var1, var2);
    return;
  }

  if(isai(self) || !isPlayer(self)) {
    return;
  }

  if(!isDefined(var1)) {
    return;
  }

  var4 = botnodeavailabletoteam(self);
  var1 = int(var1 * var4);

  if(!level.playerxpenabled) {
    scripts\cp\agents\gametype_cp_wave_sv::displayscoreeventpoints(var1, var0);
    return;
  }

  if(!isDefined(var1) || var1 == 0) {
    return;
  }

  var5 = getscoreinfocategory(var0, "group");
  var6 = getscoreinfocategory(var0, "allowBonus");
  var7 = 1;
  var8 = var1;
  var9 = 0;

  if(istrue(var6)) {
    var7 = getrankxpmultipliertotal();
    var8 = int(var1 * var7);
    var9 = int(max(var8 - var1, 0));
  }

  if(!istrue(var3)) {
    scripts\cp\agents\gametype_cp_wave_sv::displayscoreeventpoints(var8, var0);
  }

  thread waitandapplyxp(var0, var1, var8, var9, var2);
}

function waitandapplyxp(var0, var1, var2, var3, var4) {
  self endon("disconnect");
  waitframe();
  var5 = getrankxp();

  if(updaterank(var5)) {
    thread updaterankannouncehud();
  }

  syncxpstat();
  var6 = 0;

  if(isDefined(var4) && scripts\cp\cp_weaponrank::weaponshouldgetxp(var4.basename)) {
    var6 = var1;
    var6 *= scripts\cp\cp_weaponrank::getweaponrankxpmultipliertotal();
    var6 = int(var6);
  }

  incrankxp(var2, var4, var6, var0);

  if(level.playerxpenabled && !isai(self)) {
    if(isDefined(var4) && (scripts\cp\cp_weapon::iscacprimaryweapon(var4) || scripts\cp\cp_weapon::iscacsecondaryweapon(var4)) && !scripts\cp\cp_weapon::ispickedupweapon(var4)) {}
  }

  recordxpgains(var0, var1, var3);
  var7 = getprestigelevel();
  var8 = getrank();
}

function recordxpgains(var0, var1, var2) {
  var3 = var1 + var2;
  var4 = getscoreinfocategory(var0, "group");

  if(!isDefined(var4) || var4 == "") {
    self.pers["summary"]["misc"] = self.pers["summary"]["misc"] + var1;
    self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var2;
    self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var3;
    return;
  }

  switch (var4) {
    case "match_bonus":
      self.pers["summary"]["match"] = self.pers["summary"]["match"] + var1;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var2;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var3;
      break;
    case "challenge":
      self.pers["summary"]["challenge"] = self.pers["summary"]["challenge"] + var1;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var2;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var3;
      break;
    case "medal":
      self.pers["summary"]["medal"] = self.pers["summary"]["medal"] + var1;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var2;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var3;
      break;
    default:
      self.pers["summary"]["score"] = self.pers["summary"]["score"] + var1;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var2;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var3;
      break;
  }
}

function updaterank(var0) {
  var1 = getrank();
  var2 = getprestigelevel();
  var3 = self.pers["rank"] + self.pers["prestige"];
  var4 = var1 + var2;
  self.pers["rank"] = var1;
  self.pers["prestige"] = var2;

  if(var4 == var3 || var4 >= level.maxrank + level.ref_11b5c) {
    return false;
  }

  self setrank(var1, var2);
  return true;
}

function updaterankannouncehud() {
  self endon("disconnect");
  self notify("update_rank");
  self endon("update_rank");
  var0 = self.pers["team"];

  if(!isDefined(var0)) {
    return;
  }

  if(!scripts\mp\flags::levelflag("game_over")) {
    level scripts\engine\utility::waittill_notify_or_timeout("game_over", 0.25);
  }

  var1 = self.pers["rank"] + self.pers["prestige"];

  for(var2 = 0; var2 < level.players.size; var2++) {
    var3 = level.players[var2];
    var4 = var3.pers["team"];

    if(isDefined(var4) && var4 == var0) {}
  }
}

function queuescorepointspopup(var0) {
  self.scorepointsqueue += var0;
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

function scorepointspopup(var0, var1) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");

  if(var0 == 0) {
    return;
  }

  if(!scripts\cp\utility\player::isreallyalive(self) && !self ismlgspectator() && !scripts\cp\utility\player::isusingremote()) {
    if(!istrue(var1) || scripts\cp\utility\player::isinkillcam()) {
      queuescorepointspopup(var0);
      thread flushscorepointspopupqueueonspawn();
      return;
    }
  }

  self notify("scorePointsPopup");
  self endon("scorePointsPopup");
  self.scoreupdatetotal += var0;
  self setclientomnvar("ui_points_popup", self.scoreupdatetotal);
  self setclientomnvar("ui_points_popup_notify", gettime());
  wait 1;
  self.scoreupdatetotal = 0;
}

function notifyplayerscore() {
  waitframe();
  level notify("update_player_score", self, self.scoreupdatetotal);
}

function queuescoreeventpopup(var0) {
  self.scoreeventqueue[self.scoreeventqueue.size] = var0;
}

function flushscoreeventpopupqueue() {
  foreach(var1 in self.scoreeventqueue) {
    scoreeventpopup(var1);
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

function getscoreeventpriority(var0) {
  if(getdvarint("scr_disableScoreSplash", 0) == 1) {
    return 0;
  }

  var1 = getscoreinfocategory(var0, "priority");

  if(!istrue(var1)) {
    return 0;
  }

  return var1;
}

function scoreeventalwaysshowassplash(var0) {
  if(getdvarint("scr_disableScoreSplash", 0) == 1) {
    return false;
  }

  var1 = getscoreinfocategory(var0, "alwaysShowSplash");

  if(!istrue(var1)) {
    return false;
  }

  return true;
}

function scoreeventhastext(var0) {
  if(getdvarint("scr_disableScoreSplash", 0) == 1) {
    return false;
  }

  var1 = getscoreinfocategory(var0, "eventID");
  var2 = getscoreinfocategory(var0, "text");

  if(!isDefined(var1) || var1 < 0 || !isDefined(var2) || var2 == "") {
    return false;
  }

  return true;
}

function scoreeventpopup(var0) {
  if(getdvarint("scr_disableScoreSplash", 0) == 1) {
    return;
  }

  if(isDefined(self.owner) && self.owner != self) {
    scoreeventpopup(self.owner, var0);
  }

  if(!isPlayer(self)) {
    return;
  }

  var1 = getscoreinfocategory(var0, "eventID");
  var2 = getscoreinfocategory(var0, "text");

  if(!isDefined(var1) || var1 < 0 || !isDefined(var2) || var2 == "") {
    return;
  }

  if(!scripts\cp\utility\player::isreallyalive(self) && !self ismlgspectator() && !scripts\cp\utility\player::isusingremote()) {
    queuescoreeventpopup(var0);
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

  self setclientomnvar("ui_score_event_list_" + self.scoreeventlistindex, var1);
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
  var0 = self.pers["rankxp"];
  var1 = self.pers["rank"];

  if(var0 < getrankinfominxp(var1) + getrankinfoxpamt(var1)) {
    return var1;
  }

  return getrankforxp(var0);
}

function getrankforxp(var0) {
  var1 = level.maxrank;

  if(var0 >= getrankinfominxp(var1)) {
    return var1;
  } else {
    var1--;
  }

  while(var1 > 0) {
    if(var0 >= getrankinfominxp(var1) && var0 < getrankinfominxp(var1) + getrankinfoxpamt(var1)) {
      return var1;
    }

    var1--;
  }

  return var1;
}

function getmatchbonusspm() {
  var0 = getrank() + 1;
  return (3 + var0 * 0.5) * 10;
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

function incrankxp(var0, var1, var2, var3) {
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
    var0 = 0;
  }

  if(isDefined(self.totalxpearned) && isDefined(self.ref_11b7f)) {
    if(self.totalxpearned > self.ref_11b7f) {
      var0 = 0;
    } else {
      self.totalxpearned += var0;
    }
  }

  var4 = getrankxp();
  var5 = int(min(var4 + var0, getrankinfomaxxp(level.maxrank) - 1));

  if(self.pers["rank"] == level.maxrank && var5 >= getrankinfomaxxp(level.maxrank)) {
    var5 = getrankinfomaxxp(level.maxrank);
  }

  self.pers["xpEarnedThisMatch"] = self.pers["xpEarnedThisMatch"] + var0;
  self.pers["rankxp"] = var5;
  var6 = "";

  if(isDefined(var1)) {
    var6 = scripts\cp\utility::relic_nuketimer_globalthread(var1.basename);
  }

  if(isDefined(var6) && var6 != "") {
    if(isDefined(self.ref_13bfc) && isDefined(self.ref_11b7e)) {
      if(self.ref_13bfc > self.ref_11b7e) {
        var2 = 0;
      } else {
        self.ref_13bfc += var2;
      }
    }
  }

  var7 = registerpublicevent();
  var8 = var0 * var7;
  var9 = getrankxpmultipliertotal();
  var10 = scripts\cp\cp_weaponrank::getweaponrankxpmultipliertotal();
  var11 = int(scripts\cp_mp\utility\game_utility::gettimesincegamestart() / 1000);
  self reportchallengeuserevent("mp_addxp", var0, scripts\cp\survival\survival_loadout::lookupcurrentoperator(self.team), var6, var2, var8, int(var9 * 100), int(var10 * 100), int(var7 * 100), var11);
  scripts\cp\cp_analytics::ref_119bf(self, var0, var6, var2, var3);
}

function registerpublicevent() {
  var0 = registerpreviousprop();
  var1 = remindermessage();
  var2 = radiusdamagestepped(self);
  var3 = var0 * var1 * var2;
  return var3;
}

function syncxpstat() {
  var0 = getrankxp();
  var1 = self getplayerdata("common", "mpProgression", "playerLevel", "xp");

  if(var1 > var0) {
    return;
  }

  self setplayerdata("common", "mpProgression", "playerLevel", "xp", var0);
}

function getgametypexpmultiplier() {
  if(!isDefined(level.gametypexpmodifier)) {
    level.gametypexpmodifier = float(tablelookup("mp/gametypesTable.csv", 0, scripts\cp\utility::getgametype(), 17));
  }

  return level.gametypexpmodifier;
}

function addglobalrankxpmultiplier(var0, var1) {
  addrankxpmultiplier(level, var0, var1);
}

function getglobalrankxpmultiplier() {
  var0 = getrankxpmultiplier(level);

  if(var0 > 4 || var0 < 0) {
    exitlevel(0);
  }

  return var0;
}

function respawntagsfreed() {
  if(self resetclientkillstreakindexes()) {
    return getbnetigrweaponxpmultiplier();
  }

  return 1;
}

function addrankxpmultiplier(var0, var1) {
  if(!isDefined(self.rankxpmultipliers)) {
    self.rankxpmultipliers = [];
  }

  if(isDefined(self.rankxpmultipliers[var1])) {
    self.rankxpmultipliers[var1] = max(self.rankxpmultipliers[var1], var0);
    return;
  }

  self.rankxpmultipliers[var1] = var0;
}

function getrankxpmultiplier() {
  if(!isDefined(self.rankxpmultipliers)) {
    return 1;
  }

  var0 = 1;

  foreach(var2 in self.rankxpmultipliers) {
    if(!isDefined(var2)) {
      continue;
    }

    var0 *= var2;
  }

  return var0;
}

function removeglobalrankxpmultiplier(var0) {
  removerankxpmultiplier(level, var0);
}

function removerankxpmultiplier(var0) {
  if(!isDefined(self.rankxpmultipliers)) {
    return;
  }

  if(!isDefined(self.rankxpmultipliers[var0])) {
    return;
  }

  self.rankxpmultipliers[var0] = undefined;
}

function addteamrankxpmultiplier(var0, var1, var2) {
  if(!level.teambased) {
    var1 = "all";
  }

  if(!isDefined(self.teamrankxpmultipliers)) {
    level.teamrankxpmultipliers = [];
  }

  if(!isDefined(level.teamrankxpmultipliers[var1])) {
    level.teamrankxpmultipliers[var1] = [];
  }

  if(isDefined(level.teamrankxpmultipliers[var1][var2])) {
    level.teamrankxpmultipliers[var1][var2] = max(self.teamrankxpmultipliers[var1][var2], var0);
    return;
  }

  level.teamrankxpmultipliers[var1][var2] = var0;
}

function removeteamrankxpmultiplier(var0, var1) {
  if(!level.teambased) {
    var0 = "all";
  }

  if(!isDefined(level.teamrankxpmultipliers)) {
    return;
  }

  if(!isDefined(level.teamrankxpmultipliers[var0])) {
    return;
  }

  if(!isDefined(level.teamrankxpmultipliers[var0][var1])) {
    return;
  }

  level.teamrankxpmultipliers[var0][var1] = undefined;
}

function getteamrankxpmultiplier(var0) {
  if(!level.teambased) {
    var0 = "all";
  }

  if(!isDefined(level.teamrankxpmultipliers) || !isDefined(level.teamrankxpmultipliers[var0])) {
    return 1;
  }

  var1 = 1;

  foreach(var3 in level.teamrankxpmultipliers[var0]) {
    if(!isDefined(var3)) {
      continue;
    }

    var1 *= var3;
  }

  return var1;
}

function getrankxpmultipliertotal() {
  var0 = getrankxpmultiplier();
  var1 = getglobalrankxpmultiplier();
  var2 = getteamrankxpmultiplier(self.team);
  var3 = respawntagsfreed();
  return var0 * var1 * var2 * var3;
}

function battle_tracks_playerinlisteningzoneinternal(var0, var1) {
  battle_tracks_gettogglestate(level, var0, var1);
}

function remindermessage() {
  var0 = registerpreviousprop(level);
  var1 = getdvarint("scr_disable_xp_scale_quit", 0) == 0;

  if((var0 > 4 || var0 < 0) && var1) {
    exitlevel(0);
  }

  return var0;
}

function battle_tracks_gettogglestate(var0, var1) {
  var2 = 4 / registerpreviousprop(level);

  if(var0 > var2) {
    return;
  }

  if(!isDefined(self.cleanupfunc)) {
    self.cleanupfunc = [];
  }

  if(isDefined(self.cleanupfunc[var1])) {
    self.cleanupfunc[var1] = max(self.cleanupfunc[var1], var0);
    return;
  }

  self.cleanupfunc[var1] = var0;
}

function registerpreviousprop() {
  if(!isDefined(self.cleanupfunc)) {
    return 1;
  }

  var0 = 1;

  foreach(var2 in self.cleanupfunc) {
    if(!isDefined(var2)) {
      continue;
    }

    var0 *= var2;
  }

  return var0;
}

function rankedmatchupdates(var0) {
  setxenonranks(var0);

  if(hostidledout()) {}

  scripts\cp\agents\gametype_cp_wave_sv::updatematchbonusscores(var0);
}

function gethostplayer() {
  var0 = getEntArray("player", "classname");

  for(var1 = 0; var1 < var0.size; var1++) {
    if(var0[var1] ishost()) {
      return var0[var1];
    }
  }
}

function hostidledout() {
  var0 = gethostplayer();

  if(isDefined(var0) && !var0.hasspawned && !isDefined(var0.selectedclass)) {
    return true;
  }

  return false;
}

function setxenonranks(var0) {
  var1 = level.players;

  for(var2 = 0; var2 < var1.size; var2++) {
    var3 = var1[var2];

    if(!isDefined(var3.score) || !isDefined(var3.pers["team"])) {}
  }

  for(var2 = 0; var2 < var1.size; var2++) {
    var3 = var1[var2];

    if(!isDefined(var3.kills) || !isDefined(var3.deaths)) {
      continue;
    }

    if(120 > var3.timeplayed["total"]) {
      continue;
    }

    var4 = (var3.kills - var3.deaths) / var3.timeplayed["total"] / 60;
    setplayerteamrank(var3, var3.clientid, var4);
  }
}
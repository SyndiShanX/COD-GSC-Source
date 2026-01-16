/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\_events.gsc
********************************/

init() {
  var_0 = getdvar("g_gametype");
  var_1 = 0;
  var_2 = [];
  var_2["dm"] = 4;
  var_2["war"] = 5;
  var_2["sd"] = 6;
  var_2["dom"] = 7;
  var_2["conf"] = 8;
  var_2["sr"] = 9;
  var_2["infect"] = 10;
  var_2["gun"] = 11;
  var_2["ctf"] = 12;
  var_2["horde"] = 13;
  var_2["twar"] = 14;
  var_2["hp"] = 15;
  var_2["ball"] = 16;
  var_2["dd"] = 17;
  var_2["koth"] = 18;
  var_2["sab"] = 19;
  var_2["mugger"] = 20;

  for (;;) {
    if(!isdefined(var_2[var_0]))
      var_0 = "war";

    var_3 = tablelookupbyrow("mp\xp_event_table.csv", var_1, 0);
    var_4 = tablelookupbyrow("mp\xp_event_table.csv", var_1, 1);
    var_5 = tablelookupbyrow("mp\xp_event_table.csv", var_1, 2);
    var_6 = tablelookupbyrow("mp\xp_event_table.csv", var_1, var_2[var_0]);

    if(!isdefined(var_3) || var_3 == "") {
      break;
    }

    if(var_3 == "win" || var_3 == "loss" || var_3 == "tie")
      var_6 = float(var_6);
    else
      var_6 = int(var_6);

    if(var_6 != -1) {
      var_5 = int(var_5);
      var_4 = int(var_4);
      maps\mp\gametypes\_rank::registerxpeventinfo(var_3, var_6, var_5, var_4);
    }

    var_1++;
  }

  level.numkills = 0;
  level thread onplayerconnect();
}

onplayerconnect() {
  for (;;) {
    level waittill("connected", var_0);
    var_0.killedplayerscurrent = [];
    var_0.damagedplayers = [];
    var_0.lastkilledby = undefined;
    var_0.recentkillcount = 0;
    var_0.lastkilltime = 0;
    var_0.bulletstreak = 0;
    var_0.lastcoopstreaktime = 0;
  }
}

addnemesisscoreforplayer(var_0, var_1) {
  if(!isdefined(self.pers["nemesis_tracking"][var_0]))
    self.pers["nemesis_tracking"][var_0] = 0.0;

  self.pers["nemesis_tracking"][var_0] = self.pers["nemesis_tracking"][var_0] + var_1;

  if(self.pers["nemesis_guid"] == "" || self.pers["nemesis_tracking"][var_0] > self.pers["nemesis_tracking"][self.pers["nemesis_guid"]])
    self.pers["nemesis_guid"] = var_0;
}

killedplayer(var_0, var_1, var_2, var_3, var_4) {
  level.numkills++;
  var_5 = var_1.guid;
  var_6 = var_1.pers["cur_kill_streak"];
  var_7 = self.guid;
  var_8 = gettime();

  if(maps\mp\_utility::isbulletdamage(var_3)) {
    if(self.lastkilltime == var_8)
      self.bulletstreak++;
    else
      self.bulletstreak = 1;
  } else
    self.bulletstreak = 0;

  self.lastkilltime = gettime();
  self.lastkilledplayer = var_1;
  self.modifiers = [];
  self.damagedplayers[var_5] = undefined;
  thread updaterecentkills(var_0, var_2);

  if(!maps\mp\_utility::iskillstreakweapon(var_2)) {
    if(var_2 == "none")
      return 0;

    if(isdefined(var_1.throwinggrenade)) {
      if(var_1.throwinggrenade == "h1_fraggrenade_mp")
        self.modifiers["cooking"] = 1;
    }

    if(weaponinventorytype(var_2) == "primary") {
      self.segments["killDistanceTotal"] = self.segments["killDistanceTotal"] + distance2d(self.origin, var_1.origin);
      self.segments["killDistanceCount"]++;
    }

    if(var_3 == "MOD_HEAD_SHOT")
      headshotevent(var_0, var_2, var_3);

    if(level.numkills == 1)
      firstbloodevent(var_0, var_2, var_3);

    if(level.teambased && var_8 - var_1.lastkilltime < 3000 && var_1.lastkilledplayer != self)
      avengedplayerevent(var_0, var_2, var_3);

    if(!isalive(self) && self != var_1 && isdefined(self.deathtime) && self.deathtime + 1200 < gettime())
      postdeathkillevent(var_0);

    if(self.pers["cur_death_streak"] > 3)
      comebackevent(var_0, var_2, var_3);

    if(isdefined(self.assistedsuicide) && self.assistedsuicide)
      assistedsuicideevent(var_0, var_2, var_3);

    if(islongshot(self, var_2, var_3, var_1))
      longshotevent(var_0, var_2, var_3);

    if(isresuce(var_1, var_8))
      defendedplayerevent(var_0, var_2, var_3);

    if(var_6 > 0 && isbuzzkillevent(var_1))
      buzzkillevent(var_0, var_1, var_2, var_3);

    if(isoneshotkill(var_1, var_2, var_3))
      oneshotkillevent(var_0, var_2, var_3);

    if(isdefined(self.lastkilledby) && self.lastkilledby == var_1)
      revengeevent(var_0);

    if(var_1.idflags & level.idflags_penetration)
      bulletpenetrationevent(var_0, var_2);

    if(ispointblank(var_1, var_3))
      pointblankevent(var_0, var_2, var_3);

    if(self.health < 20 && self.health > 0)
      neardeathkillevent(var_2, var_3);

    if(common_scripts\utility::isflashed())
      flashedkillevent(var_2, var_3);

    if(isthinkfast(var_2, var_3))
      thinkfastevent();

    if(self.bulletstreak == 2)
      multikillonebulletevent();

    if(isbackstabevent(var_1, var_2, var_3))
      backstabevent();

    if(isthrowbackevent(var_1, var_2, var_3))
      throwbackkillevent();

    if(isdefined(self.pickedupweaponfrom[var_2]) && self.pickedupweaponfrom[var_2] == var_1 && !maps\mp\_utility::ismeleemod(var_3))
      takeandkillevent();

    if(maps\mp\_utility::isbulletdamage(var_3) && !isdefined(self.assistedsuicide)) {
      if(maps\mp\_utility::_hasperk("specialty_bulletdamage"))
        stoppingpowerevent();

      if(maps\mp\_utility::_hasperk("specialty_fastreload"))
        sleightofhandevent(var_2);

      if(maps\mp\_utility::_hasperk("specialty_rof") && maps\mp\_utility::is_true(var_1.laststand))
        doubletapevent();

      if(maps\mp\_utility::_hasperk("specialty_twoprimaries") && var_2 == self.secondaryweapon)
        overkillevent();

      if(maps\mp\_utility::_hasperk("specialty_bulletaccuracy") && self playerads() < 0.5)
        steadyaimevent();

      if(maps\mp\_utility::_hasperk("specialty_pistoldeath") && maps\mp\_utility::is_true(self.laststand) && maps\mp\_utility::is_true(var_1.laststand))
        laststandevent();

      if(maps\mp\_utility::_hasperk("specialty_holdbreath") && weaponclass(var_2) == "sniper")
        ironlungsevent();

      if(maps\mp\_utility::_hasperk("specialty_parabolic"))
        eavesdropevent();
    }

    if(maps\mp\_utility::_hasperk("specialty_radarimmune") && var_1 maps\mp\gametypes\_hardpoints::playerhasuavactive())
      uavjammerevent();

    if(maps\mp\_utility::_hasperk("specialty_explosivedamage") && isexplosivedamagemod(var_3))
      sonicboomevent();

    checkhigherrankkillevents(var_1);
    checkweaponspecifickill(var_1, var_2, var_3);
  }

  checkstreakingevents(var_1);

  if(!isdefined(self.pers["killed_players"][var_5]))
    self.pers["killed_players"][var_5] = 0;

  if(!isdefined(self.killedplayerscurrent[var_5]))
    self.killedplayerscurrent[var_5] = 0;

  if(!isdefined(var_1.pers["killed_by"][var_7]))
    var_1.pers["killed_by"][var_7] = 0;

  self.pers["killed_players"][var_5]++;
  self.killedplayerscurrent[var_5]++;
  addnemesisscoreforplayer(var_5, 1.0);
  var_1.pers["killed_by"][var_7]++;
  var_1.lastkilledby = self;
  var_1 addnemesisscoreforplayer(var_7, 1.5);

  if(self.pers["prey_guid"] == "" || self.pers["killed_players"][var_5] > self.pers["killed_players"][self.pers["prey_guid"]])
    self.pers["prey_guid"] = var_5;
}

ispointblank(var_0, var_1) {
  if(maps\mp\_utility::isbulletdamage(var_1)) {
    var_2 = self.origin;
    var_3 = 9216;

    if(isdefined(var_0.attackerposition))
      var_2 = var_0.attackerposition;

    if(distancesquared(var_2, var_0.origin) < var_3)
      return 1;
  }

  return 0;
}

pointblankevent(var_0, var_1, var_2) {
  maps\mp\_utility::incplayerstat("pointblank", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("pointblank", self, var_1, undefined, var_2);

  if(maps\mp\_utility::_hasperk("specialty_quieter"))
    maps\mp\gametypes\_missions::processchallenge("ch_deadsilence");
}

killedplayerevent(var_0, var_1, var_2) {
  maps\mp\_utility::incplayerstat("kills", 1);
  maps\mp\_utility::incpersstat("kills", 1);
  self.kills = maps\mp\_utility::getpersstat("kills");
  maps\mp\gametypes\_persistence::statsetchild("round", "kills", self.kills);
  maps\mp\_utility::updatepersratio("kdRatio", "kills", "deaths");
  var_3 = "kill";

  switch (var_1) {
    case "artillery_mp":
      var_3 = "airstrike_mp_kill";
      break;
    case "cobra_20mm_mp":
    case "hind_ffar_mp":
    case "cobra_ffar_mp":
      var_3 = "helicopter_mp_kill";
      break;
  }

  if(var_3 != "kill") {
    maps\mp\_utility::incplayerstat(var_3, 1);
    maps\mp\gametypes\_missions::ch_streak_kill(var_3);
  }

  level thread maps\mp\gametypes\_rank::awardgameevent(var_3, self, var_1, var_0, var_2);
}

isthinkfast(var_0, var_1) {
  if(maps\mp\_utility::is_true(self.assistedsuicide))
    return 0;

  if(var_1 == "MOD_IMPACT" || var_1 == "MOD_HEAD_SHOT") {
    if(isthinkfastweapon(var_0))
      return 1;
  }

  return 0;
}

isthinkfastweapon(var_0) {
  switch (var_0) {
    case "h1_flashgrenade_mp":
    case "h1_concussiongrenade_mp":
    case "h1_smokegrenade_mp":
    case "h1_fraggrenade_mp":
      return 1;
    default:
      return 0;
  }
}

thinkfastevent() {
  maps\mp\_utility::incplayerstat("think_fast", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("think_fast", self);
}

earnedkillstreakevent(var_0, var_1, var_2, var_3) {
  maps\mp\_utility::incplayerstat(var_0 + "_earned", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent(var_0 + "_earned", self);
  thread maps\mp\gametypes\_hud_message::killstreaksplashnotify(var_0, var_1, undefined, var_2, var_3);
}

bulletpenetrationevent(var_0, var_1) {
  maps\mp\_utility::incplayerstat("bulletpenkills", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("bulletpen", self);
  maps\mp\gametypes\_missions::processchallenge("ch_xrayvision");

  if(maps\mp\_utility::_hasperk("specialty_bulletpenetration"))
    maps\mp\gametypes\_missions::processchallenge("ch_deepimpact");
}

multikillonebulletevent() {
  maps\mp\_utility::incplayerstat("multiKillOneBullet", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("multiKillOneBullet", self);
}

checkweaponspecifickill(var_0, var_1, var_2) {}

neardeathkillevent(var_0, var_1) {
  maps\mp\_utility::incplayerstat("near_death_kill", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("near_death_kill", self, var_0, undefined, var_1);

  if(maps\mp\_utility::_hasperk("specialty_armorvest"))
    maps\mp\gametypes\_missions::processchallenge("ch_juggernaut");
}

flashedkillevent(var_0, var_1) {
  maps\mp\_utility::incplayerstat("flash_kill", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("flash_kill", self, var_0, undefined, var_1);
}

isoneshotkill(var_0, var_1, var_2) {
  if(var_0.attackers.size != 1)
    return 0;

  if(!isdefined(var_0.attackers[self.guid]))
    return 0;

  if(maps\mp\_utility::ismeleemod(var_2))
    return 0;

  if(gettime() != var_0.attackerdata[self.guid].firsttimedamaged)
    return 0;

  var_3 = maps\mp\_utility::getweaponclass(var_1);

  if(var_3 == "weapon_sniper" || var_3 == "weapon_shotgun")
    return 1;

  return 0;
}

islongshot(var_0, var_1, var_2, var_3) {
  if(isdefined(var_3.agentbody))
    return 0;

  var_4 = self.origin;

  if(isdefined(var_3.attackerposition))
    var_4 = var_3.attackerposition;

  if(isalive(var_0) && !var_0 maps\mp\_utility::isusingremote() && (var_2 == "MOD_RIFLE_BULLET" || var_2 == "MOD_PISTOL_BULLET" || var_2 == "MOD_HEAD_SHOT" || issubstr(var_1, "exocrossbow") || issubstr(var_1, "m990")) && !maps\mp\_utility::iskillstreakweapon(var_1) && !isdefined(var_0.assistedsuicide)) {
    var_5 = maps\mp\_utility::getweaponclass(var_1);

    switch (var_5) {
      case "weapon_pistol":
        var_6 = 800;
        break;
      case "weapon_smg":
        var_6 = 1200;
        break;
      case "weapon_heavy":
      case "weapon_assault":
        var_6 = 1500;
        break;
      case "weapon_sniper":
        var_6 = 2000;
        break;
      case "weapon_shotgun":
        var_6 = 500;
        break;
      case "weapon_projectile":
      default:
        var_6 = 1536;
        break;
    }

    if(issubstr(var_1, "exocrossbow"))
      var_6 = 1200;

    var_7 = var_6 * var_6;

    if(distancesquared(var_4, var_3.origin) > var_7)
      return 1;
  }

  return 0;
}

isresuce(var_0, var_1) {
  if(!level.teambased)
    return 0;

  foreach(var_4, var_3 in var_0.damagedplayers) {
    if(var_4 != self.guid && var_1 - var_3 < 500)
      return 1;
  }

  return 0;
}

longshotevent(var_0, var_1, var_2) {
  self.modifiers["longshot"] = 1;
  maps\mp\_utility::incplayerstat("longshots", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("longshot", self, var_1, undefined, var_2);
  thread maps\mp\_matchdata::logkillevent(var_0, "longshot");
}

headshotevent(var_0, var_1, var_2) {
  self.modifiers["headshot"] = 1;
  maps\mp\_utility::incpersstat("headshots", 1);
  maps\mp\_utility::incplayerstat("headshots", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "headshots", maps\mp\_utility::clamptoshort(self.pers["headshots"]));
  self.headshots = maps\mp\_utility::getpersstat("headshots");
  level thread maps\mp\gametypes\_rank::awardgameevent("headshot", self, var_1, undefined, var_2);
  thread maps\mp\_matchdata::logkillevent(var_0, "headshot");

  if(!isdefined(self.headhuntercounter))
    self.headhuntercounter = 1;

  if(isdefined(self.headshots) && self.headshots >= self.headhuntercounter * 10) {
    maps\mp\gametypes\_missions::processchallenge("ch_headhunter");
    self.headhuntercounter++;
  }
}

isthrowbackevent(var_0, var_1, var_2) {
  if(!isexplosivedamagemod(var_2))
    return 0;

  if(!issubstr(var_1, "h1_frag"))
    return 0;

  if(isdefined(var_0) && isdefined(var_0.explosiveinfo) && isdefined(var_0.explosiveinfo["throwbackKill"]) && var_0.explosiveinfo["throwbackKill"])
    return 1;

  return 0;
}

throwbackkillevent() {
  maps\mp\_utility::incplayerstat("throwback_kill", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("throwback_kill", self);
}

avengedplayerevent(var_0, var_1, var_2) {
  self.modifiers["avenger"] = 1;
  maps\mp\_utility::incplayerstat("avengekills", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("avenger", self, var_1, undefined, var_2);
  thread maps\mp\_matchdata::logkillevent(var_0, "avenger");
  maps\mp\gametypes\_missions::processchallenge("ch_avenger");
}

assistedsuicideevent(var_0, var_1, var_2) {
  self.modifiers["assistedsuicide"] = 1;
  maps\mp\_utility::incplayerstat("assistedsuicide", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("assistedsuicide", self, var_1, undefined, var_2);
  thread maps\mp\_matchdata::logkillevent(var_0, "assistedsuicide");
}

defendedplayerevent(var_0, var_1, var_2) {
  self.modifiers["defender"] = 1;
  maps\mp\_utility::incplayerstat("rescues", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("defender", self, var_1, undefined, var_2);
  thread maps\mp\_matchdata::logkillevent(var_0, "defender");
  maps\mp\gametypes\_missions::processchallenge("ch_savior");
}

defendobjectiveevent(var_0, var_1) {
  maps\mp\_utility::incplayerstat("defends", 1);
  maps\mp\_utility::incpersstat("defends", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "defends", self.pers["defends"]);
  level thread maps\mp\gametypes\_rank::awardgameevent("defend", self);
  var_0 thread maps\mp\_matchdata::logkillevent(var_1, "assaulting");
}

assaultobjectiveevent(var_0, var_1) {
  maps\mp\_utility::incplayerstat("assault", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("assault", self);
  var_0 thread maps\mp\_matchdata::logkillevent(var_1, "defending");
}

postdeathkillevent(var_0) {
  self.modifiers["posthumous"] = 1;
  maps\mp\_utility::incplayerstat("posthumous", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("posthumous", self);
  thread maps\mp\_matchdata::logkillevent(var_0, "posthumous");
  maps\mp\gametypes\_missions::processchallenge("ch_afterlife");
}

isbackstabevent(var_0, var_1, var_2) {
  if(!maps\mp\_utility::ismeleemod(var_2))
    return 0;

  if(maps\mp\gametypes\_weapons::isriotshield(var_1))
    return 0;

  var_3 = var_0 getplayerangles();
  var_4 = self getplayerangles();
  var_5 = angleclamp180(var_3[1] - var_4[1]);

  if(abs(var_5) < 75)
    return 1;

  return 0;
}

backstabevent(var_0) {
  maps\mp\_utility::incplayerstat("backstab", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("backstab", self);
  maps\mp\gametypes\_missions::processchallenge("ch_backstab");
}

revengeevent(var_0) {
  self.modifiers["revenge"] = 1;
  self.lastkilledby = undefined;
  maps\mp\_utility::incplayerstat("revengekills", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("revenge", self);
  thread maps\mp\_matchdata::logkillevent(var_0, "revenge");
  maps\mp\gametypes\_missions::processchallenge("ch_revenge");
}

multikillevent(var_0, var_1, var_2, var_3) {
  if(!isdefined(var_3))
    var_3 = 0;

  var_4 = maps\mp\gametypes\_missions::get_challenge_weapon_class(var_2);
  var_5 = maps\mp\_utility::getbaseweaponname(var_2);

  if(maps\mp\_utility::islootweapon(var_5))
    var_5 = maps\mp\gametypes\_class::getbasefromlootversion(var_5);

  var_6 = "";

  if(common_scripts\utility::string_starts_with(var_5, "iw5_"))
    var_6 = getsubstr(var_5, 4);
  else if(common_scripts\utility::string_starts_with(var_5, "h1_"))
    var_6 = getsubstr(var_5, 3);

  switch (var_1) {
    case 2:
      level thread maps\mp\gametypes\_rank::awardgameevent("doublekill", self);
      maps\mp\_utility::incplayerstat("doublekill", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_double");
      break;
    case 3:
      level thread maps\mp\gametypes\_rank::awardgameevent("triplekill", self);
      level thread maps\mp\_utility::teamplayercardsplash("callout_3xkill", self);
      maps\mp\_utility::incplayerstat("triplekill", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_triple");

      if(maps\mp\gametypes\_missions::isatbrinkofdeath())
        maps\mp\gametypes\_missions::processchallenge("ch_triplehurt");

      break;
    case 4:
      level thread maps\mp\gametypes\_rank::awardgameevent("fourkill", self);
      level thread maps\mp\_utility::teamplayercardsplash("callout_4xkill", self);
      maps\mp\_utility::incplayerstat("fourkill", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_quadra");
      break;
    case 5:
      level thread maps\mp\gametypes\_rank::awardgameevent("fivekill", self);
      level thread maps\mp\_utility::teamplayercardsplash("callout_5xkill", self);
      maps\mp\_utility::incplayerstat("fivekill", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_penta");
      break;
    case 6:
      level thread maps\mp\gametypes\_rank::awardgameevent("sixkill", self);
      level thread maps\mp\_utility::teamplayercardsplash("callout_6xkill", self);
      maps\mp\_utility::incplayerstat("sixkill", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_hexa");
      break;
    case 7:
      level thread maps\mp\gametypes\_rank::awardgameevent("sevenkill", self);
      level thread maps\mp\_utility::teamplayercardsplash("callout_7xkill", self);
      maps\mp\_utility::incplayerstat("sevenkill", 1);
      break;
    case 8:
      level thread maps\mp\gametypes\_rank::awardgameevent("eightkill", self);
      level thread maps\mp\_utility::teamplayercardsplash("callout_8xkill", self);
      maps\mp\_utility::incplayerstat("eightkill", 1);
      break;
    default:
      level thread maps\mp\gametypes\_rank::awardgameevent("multikill", self);
      thread maps\mp\_utility::teamplayercardsplash("callout_9xpluskill", self);
      maps\mp\_utility::incplayerstat("multikill", 1);
      break;
  }

  thread maps\mp\_matchdata::logmultikill(var_0, var_1);
}

takeandkillevent() {
  maps\mp\_utility::incplayerstat("take_and_kill", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("take_and_kill", self);
  maps\mp\gametypes\_missions::processchallenge("ch_backfire");

  if(maps\mp\_utility::getmapname() == "mp_bog_summer")
    maps\mp\gametypes\_missions::processchallenge("ch_summer_backfire");
}

setuplinkstats() {
  var_0 = maps\mp\_utility::getplayerstat("fieldgoal") + maps\mp\_utility::getplayerstat("touchdown") * 2;
  maps\mp\gametypes\_persistence::statsetchild("round", "captures", var_0);
  maps\mp\_utility::setextrascore0(var_0);
}

flagpickupevent() {
  thread maps\mp\_utility::teamplayercardsplash("callout_flagpickup", self);
  maps\mp\_utility::incplayerstat("flagscarried", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("flag_pickup", self);
  thread maps\mp\_matchdata::loggameevent("pickup", self.origin);
}

flagcaptureevent() {
  thread maps\mp\_utility::teamplayercardsplash("callout_flagcapture", self);
  maps\mp\_utility::incplayerstat("flagscaptured", 1);
  maps\mp\_utility::incpersstat("captures", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "captures", self.pers["captures"]);
  maps\mp\_utility::setextrascore0(self.pers["captures"]);
  level thread maps\mp\gametypes\_rank::awardgameevent("flag_capture", self);
  thread maps\mp\_matchdata::loggameevent("capture", self.origin);
}

flagreturnevent() {
  thread maps\mp\_utility::teamplayercardsplash("callout_flagreturn", self);
  maps\mp\_utility::incplayerstat("flagsreturned", 1);
  maps\mp\_utility::incpersstat("returns", 1);
  self.assists = self.pers["returns"];
  maps\mp\gametypes\_persistence::statsetchild("round", "returns", self.pers["returns"]);
  level thread maps\mp\gametypes\_rank::awardgameevent("flag_return", self);
  thread maps\mp\_matchdata::loggameevent("return", self.origin);
}

killwithflagevent() {
  maps\mp\_utility::incplayerstat("killsasflagcarrier", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("kill_with_flag", self);
}

killflagcarrierevent(var_0) {
  thread maps\mp\_utility::teamplayercardsplash("callout_killflagcarrier", self);
  maps\mp\_utility::incplayerstat("flagcarrierkills", 1);
  maps\mp\_utility::incpersstat("defends", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "defends", self.pers["defends"]);
  level thread maps\mp\gametypes\_rank::awardgameevent("kill_flag_carrier", self);
  thread maps\mp\_matchdata::logkillevent(var_0, "carrying");
}

killdeniedevent(var_0) {
  maps\mp\_utility::incplayerstat("killsdenied", 1);
  maps\mp\_utility::incpersstat("denied", 1);
  maps\mp\_utility::setextrascore1(self.pers["denied"]);
  maps\mp\gametypes\_persistence::statsetchild("round", "denied", self.pers["denied"]);
  var_1 = "kill_denied";

  if(var_0) {
    var_1 = "kill_denied_retrieved";
    maps\mp\_utility::incplayerstat("kill_denied_retrieved", 1);
    maps\mp\gametypes\_missions::processchallenge("ch_save_yourself");
  }

  level thread maps\mp\gametypes\_rank::awardgameevent(var_1, self);
  maps\mp\gametypes\_missions::processchallenge("ch_denial");
}

killconfirmedevent() {
  maps\mp\_utility::incplayerstat("killsconfirmed", 1);
  maps\mp\_utility::incpersstat("confirmed", 1);
  maps\mp\_utility::setextrascore0(self.pers["confirmed"]);
  maps\mp\gametypes\_persistence::statsetchild("round", "confirmed", self.pers["confirmed"]);
  level thread maps\mp\gametypes\_rank::awardgameevent("kill_confirmed", self);
  maps\mp\gametypes\_missions::processchallenge("ch_collector");
}

tagcollectorevent() {
  maps\mp\_utility::incplayerstat("tag_collector", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("tag_collector", self);
}

monitortagcollector(var_0) {
  if(!isplayer(var_0)) {
    return;
  }
  var_0 notify("tagCollector");
  var_0 endon("tagCollector");

  if(!isdefined(var_0.tagcollectortotal))
    var_0.tagcollectortotal = 0;

  var_0.tagcollectortotal++;

  if(var_0.tagcollectortotal > 2) {
    var_0 tagcollectorevent();
    var_0.tagcollectortotal = 0;
  }

  wait 2.5;

  if(isdefined(var_0))
    var_0.tagcollectortotal = 0;
}

bombplantevent() {
  maps\mp\_utility::incplayerstat("bombsplanted", 1);
  maps\mp\_utility::incpersstat("plants", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "plants", self.pers["plants"]);
  maps\mp\_utility::setextrascore0(self.pers["plants"]);
  level thread maps\mp\_utility::teamplayercardsplash("callout_bombplanted", self);
  level thread maps\mp\gametypes\_rank::awardgameevent("plant", self);
  thread maps\mp\_matchdata::loggameevent("plant", self.origin);
}

bombdefuseevent(var_0) {
  maps\mp\_utility::incplayerstat("bombsdefused", 1);
  maps\mp\_utility::incpersstat("defuses", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "defuses", self.pers["defuses"]);
  maps\mp\_utility::setextrascore1(self.pers["defuses"]);
  level thread maps\mp\_utility::teamplayercardsplash("callout_bombdefused", self);

  if(var_0 == "ninja_defuse" || var_0 == "last_man_defuse") {
    maps\mp\_utility::incplayerstat(var_0, 1);

    if(var_0 == "ninja_defuse" && isdefined(level.bombowner) && level.bombowner.bombplantedtime + 6000 + level.defusetime * 1000 > gettime())
      maps\mp\gametypes\_missions::processchallenge("ch_ninja");
  }

  level thread maps\mp\gametypes\_rank::awardgameevent(var_0, self);
  thread maps\mp\_matchdata::loggameevent("defuse", self.origin);
}

eliminateplayerevent(var_0, var_1) {
  maps\mp\_utility::incplayerstat("elimination", 1);
  level thread maps\mp\_utility::teamplayercardsplash("callout_eliminated", var_1);

  if(var_0) {
    maps\mp\_utility::incplayerstat("last_man_standing", 1);
    level thread maps\mp\gametypes\_rank::awardgameevent("last_man_standing", self);
  } else
    level thread maps\mp\gametypes\_rank::awardgameevent("elimination", self);
}

bombdetonateevent() {
  maps\mp\_utility::incplayerstat("targetsdestroyed", 1);
  maps\mp\_utility::incpersstat("destructions", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "destructions", self.pers["destructions"]);
  level thread maps\mp\_utility::teamplayercardsplash("callout_destroyed_objective", self);
  level thread maps\mp\gametypes\_rank::awardgameevent("destroy", self);
  maps\mp\gametypes\_missions::processchallenge("ch_sd_destroyer");
}

increasegunlevelevent() {
  maps\mp\_utility::incplayerstat("levelup", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("gained_gun_score", self);
}

decreasegunlevelevent() {
  maps\mp\_utility::incplayerstat("dejavu", 1);
  maps\mp\_utility::incpersstat("setbacks", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "setbacks", self.pers["setbacks"]);
  level thread maps\mp\gametypes\_rank::awardgameevent("dropped_gun_score", self);
}

setbackenemygunlevelevent() {
  maps\mp\_utility::incplayerstat("humiliation", 1);
  maps\mp\_utility::incpersstat("humiliations", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "humiliations", self.pers["humiliations"]);
  level thread maps\mp\gametypes\_rank::awardgameevent("dropped_enemy_gun_rank", self);
}

quickgunlevelevent() {
  maps\mp\_utility::incplayerstat("gunslinger", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("quick_gun_rank", self);
}

setbackfirstplayergunlevelevent() {
  maps\mp\_utility::incplayerstat("regicide", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("dropped_first_player_gun_rank", self);
}

domcaptureevent(var_0) {
  maps\mp\_utility::incplayerstat("pointscaptured", 1);
  maps\mp\_utility::incpersstat("captures", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "captures", self.pers["captures"]);
  maps\mp\_utility::setextrascore0(self.pers["captures"]);
  var_1 = "capture";

  if(var_0) {
    var_1 = "opening_move";
    maps\mp\_utility::incplayerstat("opening_move", 1);
  }

  level thread maps\mp\gametypes\_rank::awardgameevent(var_1, self);
  thread maps\mp\_matchdata::loggameevent("capture", self.origin);
  maps\mp\gametypes\_missions::processchallenge("ch_dom_aggression");
}

domneutralizeevent() {
  level thread maps\mp\gametypes\_rank::awardgameevent("neutralize", self);
}

killwhilecapture(var_0, var_1) {
  maps\mp\_utility::incplayerstat("assault", 1);
  maps\mp\_utility::incplayerstat("kill_while_capture", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("kill_while_capture", self);
  var_0 thread maps\mp\_matchdata::logkillevent(var_1, "defending");
}

securehardpointevent() {
  maps\mp\_utility::incplayerstat("hp_secure", 1);
  maps\mp\_utility::incpersstat("captures", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "captures", self.pers["captures"]);
  level thread maps\mp\_utility::teamplayercardsplash("callout_hp_captured_by", self);
  level thread maps\mp\gametypes\_rank::awardgameevent("hp_secure", self);
  thread maps\mp\_matchdata::loggameevent("capture", self.origin);
}

holdhardpointevent() {
  maps\mp\_utility::incpersstat("captureTime", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "captureTime", self.pers["captureTime"]);
  maps\mp\_utility::setextrascore0(self.pers["captureTime"]);
}

hqcaptureevent() {
  maps\mp\_utility::incplayerstat("hqscaptured", 1);
  maps\mp\_utility::incpersstat("captures", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "captures", self.pers["captures"]);
  maps\mp\_utility::setextrascore0(self.pers["captures"]);
  level thread maps\mp\_utility::teamplayercardsplash("callout_capturedhq", self);
  level thread maps\mp\gametypes\_rank::awardgameevent("hq_secure", self);
  thread maps\mp\_matchdata::loggameevent("capture", self.origin);
  maps\mp\gametypes\_missions::processchallenge("ch_hq_aggression");
}

hqdestroyevent() {
  maps\mp\_utility::incplayerstat("hqsdestroyed", 1);
  maps\mp\_utility::incpersstat("destructions", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "destructions", self.pers["destructions"]);
  maps\mp\_utility::setextrascore1(self.pers["destructions"]);
  level thread maps\mp\_utility::teamplayercardsplash("callout_destroyedhq", self);
  level thread maps\mp\gametypes\_rank::awardgameevent("hq_destroy", self);
  thread maps\mp\_matchdata::loggameevent("destroy", self.origin);
  maps\mp\gametypes\_missions::processchallenge("ch_hq_destroyer");
}

firstbloodevent(var_0, var_1, var_2) {
  self.modifiers["firstblood"] = 1;
  maps\mp\_utility::incplayerstat("firstblood", 1);
  thread maps\mp\_utility::teamplayercardsplash("callout_firstblood", self);
  level thread maps\mp\gametypes\_rank::awardgameevent("firstblood", self, var_1, undefined, var_2);
  thread maps\mp\_matchdata::logkillevent(var_0, "firstblood");
}

isbuzzkillevent(var_0) {
  var_1 = var_0.pers["cur_kill_streak"];

  if(var_1 == 2 || var_1 == 4 || var_1 == 6)
    return 1;

  return 0;
}

buzzkillevent(var_0, var_1, var_2, var_3) {
  self.modifiers["buzzkill"] = var_1.pers["cur_kill_streak"];
  maps\mp\_utility::incplayerstat("buzzkill", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("buzzkill", self, var_2, undefined, var_3);
}

oneshotkillevent(var_0, var_1, var_2) {
  self.modifiers["oneshotkill"] = 1;
  maps\mp\_utility::incplayerstat("oneshotkill", 1);
  maps\mp\gametypes\_missions::processchallenge("ch_deadeye");
}

comebackevent(var_0, var_1, var_2) {
  self.modifiers["comeback"] = 1;
  maps\mp\_utility::incplayerstat("comebacks", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("comeback", self, var_1, undefined, var_2);
  thread maps\mp\_matchdata::logkillevent(var_0, "comeback");
}

choosenextbestnemesis() {
  var_0 = self.pers["nemesis_tracking"];
  var_1 = getarraykeys(var_0);
  var_2 = "";
  var_3 = 0;

  foreach(var_5 in var_1) {
    var_6 = self.pers["nemesis_tracking"][var_5];

    if(var_6 > var_3) {
      var_2 = var_5;
      var_3 = var_6;
    }
  }

  self.pers["nemesis_guid"] = var_2;
}

choosenextbestprey() {
  var_0 = self.pers["killed_players"];
  var_1 = getarraykeys(var_0);
  var_2 = "";
  var_3 = 0;

  foreach(var_5 in var_1) {
    var_6 = self.pers["killed_players"][var_5];

    if(var_6 > var_3) {
      var_2 = var_5;
      var_3 = var_6;
    }
  }

  self.pers["prey_guid"] = var_2;
}

disconnected() {
  var_0 = self.guid;

  for (var_1 = 0; var_1 < level.players.size; var_1++) {
    if(isdefined(level.players[var_1].pers["killed_players"][var_0]))
      level.players[var_1].pers["killed_players"][var_0] = undefined;

    if(isdefined(level.players[var_1].killedplayerscurrent[var_0]))
      level.players[var_1].killedplayerscurrent[var_0] = undefined;

    if(isdefined(level.players[var_1].pers["killed_by"][var_0]))
      level.players[var_1].pers["killed_by"][var_0] = undefined;

    if(isdefined(level.players[var_1].pers["nemesis_tracking"][var_0]))
      level.players[var_1].pers["nemesis_tracking"][var_0] = undefined;

    if(isdefined(level.players[var_1].pers["nemesis_guid"]) && level.players[var_1].pers["nemesis_guid"] == var_0)
      level.players[var_1] choosenextbestnemesis();

    if(isdefined(level.players[var_1].pers["prey_guid"]) && level.players[var_1].pers["prey_guid"] == var_0)
      level.players[var_1] choosenextbestprey();

    if(isdefined(level.players[var_1].attackers) && isdefined(level.players[var_1].attackers[var_0]))
      level.players[var_1].attackers[var_0] = undefined;

    if(isdefined(level.players[var_1].attackerdata) && isdefined(level.players[var_1].attackerdata[var_0]))
      level.players[var_1].attackerdata[var_0] = undefined;

    if(isdefined(level.players[var_1].enemyhitcounts) && isdefined(level.players[var_1].enemyhitcounts[var_0]))
      level.players[var_1].enemyhitcounts[var_0] = undefined;
  }
}

updaterecentkills(var_0, var_1) {
  if(!isdefined(var_1))
    var_1 = "";

  self endon("disconnect");
  level endon("game_ended");
  self notify("updateRecentKills");
  self endon("updateRecentKills");
  self.recentkillcount++;
  var_2 = 0;

  if(self playerads() >= 0.2)
    var_2 = 1;

  wait 2.0;

  if(self.recentkillcount > 1)
    multikillevent(var_0, self.recentkillcount, var_1, var_2);

  self.recentkillcount = 0;
}

checkvandalismmedal(var_0) {
  if(isdefined(level.ishorde)) {
    return;
  }
  if(!isdefined(self.attackerlist)) {
    return;
  }
  if(!isdefined(var_0))
    var_0 = self;

  var_1 = self.owner;

  if(!isdefined(var_1))
    var_1 = self;

  foreach(var_3 in self.attackerlist) {
    if(!isdefined(var_3)) {
      continue;
    }
    if(var_3 == var_1) {
      continue;
    }
    if(var_3 == var_0) {
      continue;
    }
    if(var_3.team == self.team) {
      continue;
    }
    var_3 maps\mp\_utility::incplayerstat("assist_killstreak_destroyed", 1);
    level thread maps\mp\gametypes\_rank::awardgameevent("assist_killstreak_destroyed", var_3);
  }
}

checkstreakingevents(var_0) {
  var_1 = self.killstreakcount + 1;

  if(var_1 % 5 && var_1 < 30) {
    return;
  }
  switch (var_1) {
    case 5:
      level thread maps\mp\gametypes\_rank::awardgameevent("killstreak5", self);
      maps\mp\_utility::incplayerstat("killstreak5", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_bloodthirsty");
      break;
    case 10:
      level thread maps\mp\gametypes\_rank::awardgameevent("killstreak10", self);
      maps\mp\_utility::incplayerstat("killstreak10", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_merciless");
      break;
    case 15:
      level thread maps\mp\gametypes\_rank::awardgameevent("killstreak15", self);
      maps\mp\_utility::incplayerstat("killstreak15", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_ruthless");
      break;
    case 20:
      level thread maps\mp\gametypes\_rank::awardgameevent("killstreak20", self);
      maps\mp\_utility::incplayerstat("killstreak20", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_relentless");
      break;
    case 25:
      level thread maps\mp\gametypes\_rank::awardgameevent("killstreak25", self);
      maps\mp\_utility::incplayerstat("killstreak25", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_brutal");
      break;
    case 30:
      level thread maps\mp\gametypes\_rank::awardgameevent("killstreak30", self);
      maps\mp\_utility::incplayerstat("killstreak30", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_vicious");
      break;
    default:
      level thread maps\mp\gametypes\_rank::awardgameevent("killstreak30plus", self);
      maps\mp\_utility::incplayerstat("killstreak30plus", 1);
      break;
  }

  thread maps\mp\_utility::teamplayercardsplash("callout_kill_streaking", self, undefined, var_1);
}

checkhigherrankkillevents(var_0) {
  if(maps\mp\_utility::gettimepassed() < 90000.0) {
    return;
  }
  var_1 = level.players;

  if(level.teambased)
    var_1 = level.teamlist[maps\mp\_utility::getotherteam(self.team)];

  if(var_1.size < 3) {
    return;
  }
  var_2 = common_scripts\utility::array_sort_with_func(var_1, ::is_score_a_greater_than_b);

  if(isdefined(var_2[0]) && var_0 == var_2[0]) {
    maps\mp\_utility::incplayerstat("firstplacekill", 1);
    level thread maps\mp\gametypes\_rank::awardgameevent("firstplacekill", self);
    maps\mp\gametypes\_missions::processchallenge("ch_kingslayer");
  }
}

is_score_a_greater_than_b(var_0, var_1) {
  return var_0.score > var_1.score;
}

processassistevent(var_0, var_1) {
  if(isdefined(level.assists_disabled) && level.assists_disabled) {
    return;
  }
  var_2 = "assist";

  if(isdefined(var_1))
    var_2 = var_1;

  self endon("disconnect");
  var_0 endon("disconnect");
  wait 0.05;

  if(self.team != "axis" && self.team != "allies") {
    return;
  }
  if(level.teambased && self.team == var_0.team) {
    return;
  }
  level thread maps\mp\gametypes\_rank::awardgameevent(var_2, self, undefined, var_0);
  var_0 maps\mp\_matchdata::logspecialassists(self, var_2);

  if(var_2 == "assist") {
    maps\mp\_utility::incplayerstat("assists", 1);
    maps\mp\_utility::incpersstat("assists", 1);

    if(!maps\mp\_utility::is_true(level.assists_count_disabled))
      self.assists = maps\mp\_utility::getpersstat("assists");

    maps\mp\gametypes\_persistence::statsetchild("round", "assists", self.assists);
    thread maps\mp\gametypes\_missions::playerassist();
  }
}

stoppingpowerevent() {
  maps\mp\gametypes\_missions::processchallenge("ch_stoppingpower");
}

sleightofhandeventwatcher() {
  self endon("death");
  self endon("disconnect");
  self endon("sleightOfHandEventEnd");
  level endon("game_ended");
  var_0 = common_scripts\utility::waittill_any_return("sleightOfHandEventEarned", "sleightOfHandEventFailed");

  if(var_0 == "sleightOfHandEventEarned")
    maps\mp\gametypes\_missions::processchallenge("ch_sleightofhand");

  self.sleightofhandeventweap = undefined;
}

sleightofhandtimer() {
  self endon("death");
  self endon("disconnect");
  self endon("sleightOfHandEventEnd");
  self endon("sleightOfHandEventEarned");
  level endon("game_ended");
  wait 3;

  if(isdefined(self))
    self notify("sleightOfHandEventFailed");
}

sleightofhandreloadwatch(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("sleightOfHandEventEnd");
  self endon("sleightOfHandEventFailed");
  level endon("game_ended");
  thread sleightofhandtimer();
  self waittill("reload");

  if(isdefined(self))
    self.sleightofhandeventweap = var_0;
}

sleightofhandevent(var_0, var_1) {
  if(!isdefined(self.sleightofhandeventweap)) {
    self notify("sleightOfHandEventEnd");
    thread sleightofhandeventwatcher();
    thread sleightofhandreloadwatch(var_0);
  } else if(var_0 == self.sleightofhandeventweap)
    self notify("sleightOfHandEventEarned");
}

doubletapevent() {
  maps\mp\gametypes\_missions::processchallenge("ch_doubletap");
}

overkillevent() {
  maps\mp\gametypes\_missions::processchallenge("ch_overkill");
}

uavjammerevent() {
  maps\mp\gametypes\_missions::processchallenge("ch_uavjammer");
}

sonicboomevent() {
  maps\mp\gametypes\_missions::processchallenge("ch_sonicboom");
}

steadyaimevent() {
  maps\mp\gametypes\_missions::processchallenge("ch_steadyaim");
}

laststandevent() {
  maps\mp\gametypes\_missions::processchallenge("ch_laststand");
}

ironlungsevent() {
  maps\mp\gametypes\_missions::processchallenge("ch_ironlungs");
}

eavesdropevent() {
  maps\mp\gametypes\_missions::processchallenge("ch_eavesdrop");
}
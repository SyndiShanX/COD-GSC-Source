#include scripts\utility;
#define DISABLE_BOT_KILLSTREAKS 1

h2_setCustomKillstreaks() {
  index_0 = self getPlayerData("rankedMatchData", "sosRating");
  index_1 = self getPlayerData("rankedMatchData", "gdfVariance");
  index_2 = self getPlayerData("rankedMatchData", "gdfRating");

  if(isBot(self)) {
    if(!DISABLE_BOT_KILLSTREAKS) {
      self.customKillstreaks = [];
      self scripts\mp\bot_patches::h2_set_bot_ks();
    }
  } else {
    self.customKillstreaks = [];
    self.customKillstreaks[0] = h2_getStreakNameFromIndex(index_0, 0);
    self.customKillstreaks[1] = h2_getStreakNameFromIndex(index_1, 1);
    self.customKillstreaks[2] = h2_getStreakNameFromIndex(index_2, 2);
  }

  for(i = 1; i < self.customKillstreaks.size; i++) //order the killstreaks by their cost
  {
    streakName = self.customKillstreaks[i];
    streakCost = level.hardpointitems[streakName];

    for(j = i - 1; j >= 0 && streakCost < level.hardpointitems[self.customKillstreaks[j]]; j--) {
      self.customKillstreaks[j + 1] = self.customKillstreaks[j];
    }

    self.customKillstreaks[j + 1] = streakName;
  }
}

h2_isKillstreakActivator(weapon) {
  return (isDefined(level.h2_isKillstreakActivator[weapon]));
}

h2_getStreakNameFromIndex(index, number) {
  index = int(index);
  switch (index) {
    case 1:
      return "radar_mp";
    case 2:
      return "airdrop_marker_mp";
    case 3:
      return "counter_radar_mp";
    case 4:
      return "sentry_mp";
    case 5:
      return "predator_mp";
    case 6:
      return "airstrike_mp";
    case 7:
      return "helicopter_mp";
    case 8:
      return "harrier_airstrike_mp";
    case 9:
      return "airdrop_mega_marker_mp";
    case 10:
      return "pavelow_mp";
    case 11:
      return "stealth_airstrike_mp";
    case 12:
      return "chopper_gunner_mp";
    case 13:
      return "ac130_mp";
    case 14:
      return "emp_mp";
    case 15:
      return "nuke_mp";

    default:
      if(number == 0) {
        return "radar_mp";
      } else if(number == 1) {
        return "airdrop_marker_mp";
      } else {
        return "predator_mp";
      }
  }
}

init() {
  game["thermal_vision"] = "thermal_mp";

  level.killstreaksenabled = 1;

  level.hardpointitems = [];
  level.hardpointitems["radar_mp"] = getdvarint("scr_killstreak_kills_uav", 3);
  level.hardpointitems["counter_radar_mp"] = getdvarint("scr_killstreak_kills_counter_uav", 4);
  level.hardpointitems["airdrop_marker_mp"] = getdvarint("scr_killstreak_kills_airdrop", 4);
  level.hardpointitems["sentry_mp"] = getdvarint("scr_killstreak_kills_sentry", 5);
  level.hardpointitems["predator_mp"] = getdvarint("scr_killstreak_kills_predator", 5);
  level.hardpointitems["airstrike_mp"] = getdvarint("scr_killstreak_kills_precision_airstrike", 6);
  level.hardpointitems["harrier_airstrike_mp"] = getdvarint("scr_killstreak_kills_harrier", 7);
  level.hardpointitems["helicopter_mp"] = getdvarint("scr_killstreak_kills_heli", 7);
  level.hardpointitems["airdrop_mega_marker_mp"] = getdvarint("scr_killstreak_kills_airdrop_mega", 8);
  level.hardpointitems["stealth_airstrike_mp"] = getdvarint("scr_killstreak_kills_stealth", 9);
  level.hardpointitems["pavelow_mp"] = getdvarint("scr_killstreak_kills_pavelow", 9);
  level.hardpointitems["chopper_gunner_mp"] = getdvarint("scr_killstreak_kills_chopper", 11);
  level.hardpointitems["ac130_mp"] = getdvarint("scr_killstreak_kills_ac130", 11);
  level.hardpointitems["emp_mp"] = getdvarint("scr_killstreak_kills_emp", 15);
  level.hardpointitems["nuke_mp"] = getdvarint("scr_killstreak_kills_nuke", 25);
  //level.hardpointitems["dogs_mp"] = 10;

  level.killstreakwieldweapons["artillery_mp"] = "airstrike_mp";
  level.killstreakwieldweapons["cobra_ffar_mp"] = "helicopter_mp";
  level.killstreakwieldweapons["hind_ffar_mp"] = "helicopter_mp";
  level.killstreakwieldweapons["cobra_20mm_mp"] = "helicopter_mp";
  level.killstreakwieldweapons["cobra_player_minigun_mp"] = "chopper_gunner_mp";
  level.killstreakwieldweapons["stealth_bomb_mp"] = "stealth_airstrike_mp";
  level.killstreakwieldweapons["pavelow_minigun_mp"] = "pavelow_mp";
  level.killstreakwieldweapons["harrier_20mm_mp"] = "harrier_airstrike_mp";
  level.killstreakwieldweapons["harrier_ffar_mp"] = "harrier_airstrike_mp";
  level.killstreakwieldweapons["ac130_105mm_mp"] = "ac130_mp";
  level.killstreakwieldweapons["ac130_40mm_mp"] = "ac130_mp";
  level.killstreakwieldweapons["ac130_25mm_mp"] = "ac130_mp";
  level.killstreakwieldweapons["remotemissile_projectile_mp"] = "predator_mp";
  level.killstreakwieldweapons["sentry_minigun_mp"] = "sentry_mp";
  level.killstreakwieldweapons["nuke_mp"] = "nuke_mp";
  level.killstreakwieldweapons["dogs_mp"] = "dogs_mp";

  level.maxkillstreakforaward = 0;

  foreach(streakName, streakCost in level.hardpointitems) {
    if(level.maxkillstreakforaward < streakCost) {
      level.maxkillstreakforaward = streakCost;
    }

    level.h2_isKillstreakActivator[streakName] = true;

    // lots of errors come from this, are we sure its needed? killstreaks work in game just fine for me still
    //precacheItem( streakName );

    precacheShader(getkillstreakcrateicon(streakName));

    maps\mp\gametypes\_rank::registerxpeventinfo(streakName + "_earned", 100);
  }

  precachestring(&"MP_KILLSTREAK_N");

  level.numhardpointreservedobjectives = 0;

  level.killstreakfuncs = [];

  level.killstreakrounddelay = maps\mp\_utility::getintproperty("scr_game_killstreakdelay", 0);
  level.killcountpersistsoverrounds = maps\mp\_utility::getintproperty("scr_killcount_persists", 1);

  level.killStreakSpecialCaseWeapons = [];
  level.killStreakSpecialCaseWeapons["cobra_player_minigun_mp"] = true;
  level.killStreakSpecialCaseWeapons["artillery_mp"] = true;
  level.killStreakSpecialCaseWeapons["stealth_bomb_mp"] = true;
  level.killStreakSpecialCaseWeapons["pavelow_minigun_mp"] = true;
  level.killStreakSpecialCaseWeapons["sentry_minigun_mp"] = true;
  level.killStreakSpecialCaseWeapons["harrier_20mm_mp"] = true;
  level.killStreakSpecialCaseWeapons["ac130_105mm_mp"] = true;
  level.killStreakSpecialCaseWeapons["ac130_40mm_mp"] = true;
  level.killStreakSpecialCaseWeapons["ac130_25mm_mp"] = true;
  level.killStreakSpecialCaseWeapons["remotemissile_projectile_mp"] = true;
  level.killStreakSpecialCaseWeapons["cobra_20mm_mp"] = true;
  level.killStreakSpecialCaseWeapons["cobra_ffar_mp"] = true;
  level.killStreakSpecialCaseWeapons["hind_ffar_mp"] = true;
  level.killStreakSpecialCaseWeapons["dogs_mp"] = true;

  registerDialog("ac130_mp", "ac130");
  registerDialog("airstrike_mp", "airstrike");
  registerDialog("stealth_airstrike_mp", "airstrike");
  registerDialog("airdrop_marker_mp", "carepackage");
  registerDialog("airdrop_mega_marker_mp", "emergairdrop");
  registerDialog("emp_mp", "emp");
  registerDialog("harrier_airstrike_mp", "harriers");
  registerDialog("chopper_gunner_mp", "heli");
  registerDialog("helicopter_mp", "cobra");
  registerDialog("counter_radar_mp", "jamuav");
  registerDialog("nuke_mp", "nuke");
  registerDialog("pavelow_mp", "pavelow");
  registerDialog("predator_mp", "predator");
  registerDialog("sentry_mp", "sentrygun");
  registerDialog("radar_mp", "uav");

  level thread onplayerconnect();

  thread maps\mp\_helicopter::init();
  thread maps\mp\h2_killstreaks\_autosentry::init();
  thread maps\mp\h2_killstreaks\_remotemissile::init();
  thread maps\mp\h2_killstreaks\_ac130::init();
  thread maps\mp\h2_killstreaks\_emp::init();
  thread maps\mp\h2_killstreaks\_nuke::init();
  thread maps\mp\h2_killstreaks\_airdrop::init();
  thread maps\mp\h2_killstreaks\_airstrike::init();
  thread maps\mp\h2_killstreaks\_uav::init();
  thread maps\mp\h2_killstreaks\_airstrike::init();

  if(getdvarint("sv_cheats")) {
    thread developer_dvars();
  }
}

registerDialog(streakName, string) {
  game["dialog"]["achieve_" + streakName] = "achieve_" + string;

  if(string == "nuke") {
    string = "tnuke";
  }

  game["dialog"]["use_" + streakName] = "use_" + string;
  game["dialog"]["enemy_" + streakName] = "enemy_" + string;
}

developer_dvars() {
  level endon("game_ended");
  level endon("shutdownGame_called");

  setDvar("gks", "");
  setDvar("gpk", "");
  setDvar("gbks", "");

  for(;;) {
    wait 0.05;

    if(getDvar("gks") != "") {
      level.players[0] thread giveHardpoint(getDvar("gks"));

      setDvar("gks", "");
    }

    if(getDvar("gbks") != "") {
      level.players[1] thread giveHardpoint(getDvar("gbks"));

      setDvar("gbks", "");
    }

    if(getDvar("gpk") != "") {
      level.players[0] maps\mp\_utility::_setPerk(getDvar("gpk"), 0);

      setDvar("gpk", "");
    }
  }
}

onplayerconnect() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", player);

    if(isBot(player) && DISABLE_BOT_KILLSTREAKS) {
      continue;
    }

    player h2_setCustomKillstreaks();

    if(!level.teambased) {
      level.activeuavs[player.guid] = 0;
    }

    if(!isDefined(player.pers["killstreaks"])) {
      player.pers["killstreaks"] = [];
    }

    if(!isDefined(player.pers["kID"])) {
      player.pers["kID"] = 10;
    }

    if(!isDefined(player.pers["kIDs_valid"])) {
      player.pers["kIDs_valid"] = [];
    }

    player.lifeId = 0;

    if(isDefined(player.pers["deaths"])) {
      player.lifeId = player.pers["deaths"];
    }
  }
}

waitForChangeTeam() {
  self endon("disconnect");

  self notify("waitForChangeTeam");
  self endon("waitForChangeTeam");

  level endon("game_ended");

  for(;;) {
    self waittill("joined_team");

    if(isDefined(self.pers["killstreaks"])) {
      foreach(index, streakStruct in self.pers["killstreaks"]) {
        self.pers["killstreaks"][index] = undefined;
      }
    }
  }
}

givehardpointitemforstreak() {
  if(isBot(self) && DISABLE_BOT_KILLSTREAKS) {
    return;
  }

  array = self.customKillstreaks;
  player_streak = self.pers["cur_kill_streak"];

  foreach(hardpoint in array) {
    if(getdvarint("scr_game_forceuav") && hardpoint == "radar_mp") {
      continue;
    }

    killstreak_cost = level.hardpointitems[hardpoint];

    if(self maps\mp\_utility::_hasPerk("specialty_hardline")) {
      killstreak_cost--;
    }

    if(player_streak == killstreak_cost) {
      thread givehardpoint(hardpoint, player_streak);
      break;
    }
  }
}

givehardpoint(streakName, streakCost) {
  self notify("giveHardpoint");
  self endon("giveHardpoint");
  self endon("disconnect");
  self endon("death");

  if(level.gameended && level.gameendtime != gettime()) {
    return;
  }

  if(!maps\mp\_utility::is_true(level.killstreaksenabled)) {
    return;
  }

  if(getdvar("scr_game_hardpoints") != "" && getdvarint("scr_game_hardpoints") == 0) {
    return;
  }

  if(!isDefined(level.hardpointitems[streakName]) || !level.hardpointitems[streakName]) {
    return;
  }

  // shuffle existing killstreaks up a notch
  for(i = self.pers["killstreaks"].size; i >= 0; i--) {
    self.pers["killstreaks"][i + 1] = self.pers["killstreaks"][i];
  }

  self.pers["killstreaks"][0] = spawnStruct();
  self.pers["killstreaks"][0].streakName = streakName;

  self.pers["killstreaks"][0].kID = self.pers["kID"];
  self.pers["kIDs_valid"][self.pers["kID"]] = true;

  self.pers["kID"]++;

  if(!isDefined(streakCost)) {
    self.pers["killstreaks"][0].lifeId = -1;
  } else {
    self.pers["killstreaks"][0].lifeId = self.pers["deaths"];
  }

  self giveHardpointWeapon(streakName);
  self thread hardpointnotify(streakName, streakCost);
}

giveHardpointWeapon(streakName) {
  weaponList = self getWeaponsListItems();

  foreach(item in weaponList) {
    if(!h2_isKillstreakActivator(item)) {
      continue;
    }

    if(self getCurrentWeapon() == item) {
      continue;
    }

    self takeWeapon(item);
  }

  self giveweapon(streakName);
  self givemaxammo(streakName);
  self setactionslot(4, "weapon", streakName);
}

giveownedhardpointitem(skipDialog) {
  if(!isDefined(self.pers["killstreaks"]) || self.pers["killstreaks"].size < 1) {
    return;
  }

  self giveHardpointWeapon(self.pers["killstreaks"][0].streakName);

  if(!isDefined(skipDialog) && !level.inGracePeriod) {
    self maps\mp\_utility::leaderDialogOnPlayer("achieve_" + self.pers["killstreaks"][0].streakName, "killstreak_earned", 1);
  }
}

hardpointitemwaiter() {
  if(isBot(self) && DISABLE_BOT_KILLSTREAKS) {
    return;
  }

  self endon("finish_death");
  self endon("disconnect");
  level endon("game_ended");

  if(maps\mp\_utility::is_true(level.gameended)) {
    return;
  }

  if(self maps\mp\_utility::isEMPed()) {
    self maps\mp\h2_killstreaks\_emp::_setEMPJammed(true);
  }

  if(isDefined(self.h2_radar_jam)) {
    self maps\mp\h2_killstreaks\_uav::h2_jamPlayerRadar(true);
  }

  self maps\mp\gametypes\_class::clearcopycatloadout();

  self thread finishDeathWaiter();

  if(!isBot(self) || !DISABLE_BOT_KILLSTREAKS) {
    self thread waitForChangeTeam();
  }

  if(isDefined(level.onBotSpawned)) {
    self thread[[level.onBotSpawned]]();
  }

  giveownedhardpointitem();

  for(;;) {
    self waittill("weapon_change", newWeapon);

    if(!isAlive(self)) {
      continue;
    }

    if(!isDefined(self.pers["killstreaks"]) || !isDefined(self.pers["killstreaks"][0])) {
      continue;
    }

    if(newWeapon != self.pers["killstreaks"][0].streakName) {
      continue;
    }

    waittillframeend;

    streakName = self.pers["killstreaks"][0].streakName;
    result = self triggerhardpoint();

    if(result) {
      logstring("hardpoint: " + streakName);
      thread maps\mp\gametypes\_missions::usehardpoint(streakName);
      self thread[[level.onxpevent]]("hardpoint");
      self thread shuffleKillStreaksFILO(streakName);
    }

    //no force switching weapon for ridable killstreaks
    if(!isRideKillstreak(streakName) || !result) {
      if(isAnimateKillstreak(streakName)) {
        common_scripts\utility::_disableweaponswitch();
        common_scripts\utility::waittill_notify_or_timeout_return("weapon_change", 0.75);
        common_scripts\utility::_enableweaponswitch();

        if(!result) {
          self giveWeapon(streakName);
        }
      }

      lastWeapon = self common_scripts\utility::getLastWeapon();
      firstPrimary = self maps\mp\h2_killstreaks\_common::getFirstPrimaryWeapon();

      if(self hasWeapon(lastWeapon)) {
        self switchToWeapon(lastWeapon);
      } else {
        self switchToWeapon(firstPrimary);
      }
    }

    // give time to switch to the near weapon; when the weapon is none (such as during a "disableWeapon()" period
    // re-enabling the weapon immediately does a "weapon_change" to the killstreak weapon we just used.In the case that
    // we have two of that killstreak, it immediately uses the second one
    if(self getCurrentWeapon() == "none") {
      while(self getCurrentWeapon() == "none") {
        wait(0.05);
      }

      waittillframeend;
    }
  }
}

finishDeathWaiter() {
  self endon("disconnect");

  self waittill("death");

  wait(0.05);
  self notify("finish_death");
}

isRideKillstreak(streakName) {
  switch (streakName) {
    case "chopper_gunner_mp":
    case "ac130_mp":
    case "predator_mp":
      return true;
    default:
      return false;
  }
}

isAnimateKillstreak(streakName) {
  switch (streakName) {
    case "radar_mp":
    case "counter_radar_mp":
    case "helicopter_mp":
    case "nuke_mp":
    case "emp_mp":
    case "pavelow_mp":
    case "dogs_mp":
      return true;
    default:
      return false;
  }
}

hardpointnotify(var_0, var_1) {
  thread maps\mp\_events::earnedkillstreakevent(var_0, var_1);
  maps\mp\_utility::leaderdialogonplayer("achieve_" + var_0, "killstreak_earned", 1);
}

killstreakearned(var_0) {
  if(var_0 == "radar_mp") {
    self.firstkillstreakearned = gettime();
  } else if(isDefined(self.firstkillstreakearned) && var_0 == "helicopter_mp") {
    if(gettime() - self.firstkillstreakearned < 20000) {
      thread maps\mp\gametypes\_missions::genericchallenge("wargasm");
    }
  }
}

//this overwrites killstreak at index 0 and decrements all other killstreaks (FCLS style)
shuffleKillStreaksFILO(streakName) {
  self setActionSlot(4, "");

  arraySize = self.pers["killstreaks"].size;

  streakIndex = -1;
  for(i = 0; i < arraySize; i++) {
    if(self.pers["killstreaks"][i].streakName != streakName) {
      continue;
    }

    streakIndex = i;
    break;
  }
  assert(streakIndex >= 0);

  self.pers["killstreaks"][streakIndex] = undefined;

  for(i = streakIndex + 1; i < arraySize; i++) {
    if(i == arraySize - 1) {
      self.pers["killstreaks"][i - 1] = self.pers["killstreaks"][i];
      self.pers["killstreaks"][i] = undefined;
    } else {
      self.pers["killstreaks"][i - 1] = self.pers["killstreaks"][i];
    }
  }

  giveownedhardpointitem();
}

triggerhardpoint() {
  if(!maps\mp\_utility::gameFlag("prematch_done")) {
    return (false);
  }

  if(self maps\mp\_utility::isEMPed()) {
    self iprintlnbold(&"LUA_KS_UNAVAILABLE_EMP_FOR_N", level.empTimeRemaining);
    return (false);
  }

  streakName = self.pers["killstreaks"][0].streakName;
  lifeId = self.pers["killstreaks"][0].lifeId;
  kID = self.pers["killstreaks"][0].kID;

  if(level.killstreakrounddelay) {
    var_1 = 0;

    if(isDefined(level.prematch_done_time)) {
      var_1 = (gettime() - level.prematch_done_time) / 1000;
    }

    if(var_1 < level.killstreakrounddelay) {
      var_2 = int(level.killstreakrounddelay - var_1 + 0.5);

      if(!var_2) {
        var_2 = 1;
      }

      self iprintlnbold(&"MP_UNAVAILABLE_FOR_N", var_2);
      return 0;
    }
  }

  if(!isDefined(level.killstreakfuncs[streakName])) {
    return (false);
  }

  if(!self isOnGround()) {
    return (false);
  }

  if(self maps\mp\_utility::isUsingRemote()) {
    return (false);
  }

  if(isDefined(self.selectingLocation)) {
    return (false);
  }

  if(self IsUsingTurret()) {
    self iprintlnbold(&"LUA_KS_UNAVAILABLE_TURRET");
    return (false);
  }

  if(isDefined(self.lastStand)) {
    self iprintlnbold(&"LUA_KS_UNAVAILABLE_LASTSTAND");
    return (false);
  }

  if(!self common_scripts\utility::isWeaponEnabled()) {
    return (false);
  }

  if(isSubStr(streakName, "airdrop")) {
    result = self[[level.killstreakfuncs[streakName]]](lifeId, kID);
  } else {
    result = self[[level.killstreakfuncs[streakName]]](lifeId);
  }

  if(result) {
    self killstreakLeaderDialog(streakName);
  }

  return result;
}

killstreakLeaderDialog(streakName) {
  friendlyDialog = "use_" + streakName;
  enemyDialog = "enemy_" + streakName;

  foreach(player in level.players) {
    if(player.team == "spectator") {
      continue;
    }

    if((level.teamBased && player.team == self.team) || (!level.teamBased && player == self)) {
      player maps\mp\_utility::leaderDialogOnPlayer(friendlyDialog);
    } else {
      player maps\mp\_utility::leaderDialogOnPlayer(enemyDialog);
    }
  }
}

killstreakhit(var_0, var_1, var_2) {
  if(isDefined(var_1) && isplayer(var_0) && isDefined(var_2.owner) && isDefined(var_2.owner.team)) {
    if((level.teambased && var_2.owner.team != var_0.team || !level.teambased) && var_0 != var_2.owner) {
      if(maps\mp\_utility::iskillstreakweapon(var_1)) {
        return;
      }

      if(!isDefined(var_0.lasthittime[var_1])) {
        var_0.lasthittime[var_1] = 0;
      }

      if(var_0.lasthittime[var_1] == gettime()) {
        return;
      }

      var_0.lasthittime[var_1] = gettime();
      var_0 thread maps\mp\gametypes\_gamelogic::threadedsetweaponstatbyname(var_1, 1, "hits");
      var_3 = var_0 maps\mp\gametypes\_persistence::statgetbuffered("totalShots");
      var_4 = var_0 maps\mp\gametypes\_persistence::statgetbuffered("hits") + 1;

      if(var_4 <= var_3) {
        var_0 maps\mp\gametypes\_persistence::statsetbuffered("hits", var_4);
        var_0 maps\mp\gametypes\_persistence::statsetbuffered("misses", int(var_3 - var_4));
        var_5 = clamp(float(var_4) / float(var_3), 0.0, 1.0) * 10000.0;
        var_0 maps\mp\gametypes\_persistence::statsetbuffered("accuracy", int(var_5));
      }
    }
  }
}

playerhasuavactive() {
  if(level.teambased) {
    if(level.activeuavs[self.team] > 0) {
      return 1;
    }
  } else if(level.activeuavs[self.guid] > 0)
    return 1;

  return 0;
}

useradaritem() {
  self maps\mp\h2_killstreaks\_uav::useUAV("uav");
}

getAirstrikeDanger(point) {
  return self maps\mp\h2_killstreaks\_airstrike::getAirstrikeDanger(point);
}
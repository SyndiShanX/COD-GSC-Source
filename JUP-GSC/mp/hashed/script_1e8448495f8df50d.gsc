/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1e8448495f8df50d.gsc
*************************************************/

#using scripts\cp_mp\armor;
#using scripts\cp_mp\killstreaks\juggernaut;
#using scripts\engine\utility;
#using scripts\mp\class;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_gulag;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\hud_message;
#using scripts\mp\utility\script;
#namespace namespace_d59138129b936866;

function autoexec main() {
  level endon("prematch_done");
  level waittill("initialized_gulag");
  level.gulag.eventsenabled = getdvarint(@ "hash_48a8e0694302fad1", 1);

  if(!level.gulag.eventsenabled) {
    return;
  }

  scripts\mp\gametypes\br_gulag::function_ed608478232fdeb2("beginNewFight", &function_d671283750fee8fb);
  scripts\mp\gametypes\br_gulag::function_ed608478232fdeb2("shouldGiveMaxAmmoPrimary", &shouldgivemaxammoprimary);
  scripts\mp\gametypes\br_gulag::function_ed608478232fdeb2("shouldGiveMaxAmmoSecondary", &shouldgivemaxammosecondary);
  scripts\mp\gametypes\br_gulag::function_ed608478232fdeb2("preLootSpawn", &prelootspawn);
  scripts\mp\gametypes\br_gulag::function_c797c1f0977d41d1("getArenaLoadout", &function_c28154179ba75e54);
  scripts\mp\gametypes\br_gulag::function_c797c1f0977d41d1("setArmorHealth", &function_62fed662c974c355);
  scripts\mp\gametypes\br_gulag::function_c797c1f0977d41d1("showStartSplash", &showstartsplash);
  scripts\mp\gametypes\br_gulag::function_c797c1f0977d41d1("playerLost", &gulagplayerlost);
  scripts\mp\gametypes\br_gulag::function_c797c1f0977d41d1("overrideRespawnArmor", &function_7ef30310d689330f);
  scripts\mp\gametypes\br_gulag::function_c797c1f0977d41d1("getEventSettings", &function_6ff97369fec9e915);
  eventbundlename = getmatchrulesdata("brData", "gulagEventList");

  if(eventbundlename == "") {
    return;
  }

  eventlistbundle = getscriptbundle("gulageventlist:" + eventbundlename);

  if(!isDefined(eventlistbundle)) {
    scripts\mp\utility\script::demoforcesre("Could not find scriptbundle gulageventlist:" + eventbundlename);
    return;
  }

  level.gulag.eventinfo = spawnStruct();
  level.gulag.eventinfo.chance = getdvarfloat(@ "hash_d693d42f4ff1ed81", eventlistbundle.chance);
  level.gulag.eventinfo.events = [];

  foreach(index, eventbundle in eventlistbundle.var_5e04763eeef0c6de) {
    if(isDefined(eventbundle.gulagevent)) {
      initevent(index, eventbundle);
    }
  }

  initvo();
}

function initevent(index, bundle) {
  eventsettings = getscriptbundle("gulagevent:" + bundle.gulagevent);
  prefix = hashcat(@ "hash_48a8bc694302aba5", eventsettings.ref, "_");
  info = spawnStruct();
  info.index = index;
  info.weight = getdvarfloat(hashcat(prefix, "weight"), bundle.weight);
  info.mincircleindex = getdvarfloat(hashcat(prefix, "min_circle_index"), bundle.mincircleindex);
  info.maxcircleindex = getdvarfloat(hashcat(prefix, "max_circle_index"), bundle.maxcircleindex);
  info.maxtimes = getdvarfloat(hashcat(prefix, "max_times"), bundle.maxtimes);
  info.timestriggered = 0;
  info.settings = eventsettings;
  level.gulag.eventinfo.events[level.gulag.eventinfo.events.size] = info;
}

function initvo() {
  assert(isDefined(game["<dev string:x1c>"]));
  game["dialog"]["gulag_event_locked_and_loaded"] = "gula_grav_evlo";
  game["dialog"]["gulag_go_again"] = "gula_grav_evag";
  game["dialog"]["gulag_event_juggernaut"] = "gula_grav_evwa";
  game["dialog"]["gulag_event_rocket_arena"] = "gula_grav_evro";
  game["dialog"]["gulag_event_cash_overflow"] = "gula_grav_evca";
  game["dialog"]["gulag_event_ladder_escape"] = "gula_grav_evla";
  game["dialog"]["gulag_ladder_escape_kill"] = "gula_grav_evlk";
}

function function_d671283750fee8fb(arena) {
  arena function_2a154368a1c88e2c(undefined);

  if(level.gulag.eventinfo.chance <= randomfloat(1)) {
    return;
  }

  currentcircle = undefined;

  if(isDefined(level.br_circle)) {
    currentcircle = level.br_circle.circleindex + 1;
  }

  validevents = [];
  var_d1a1505095d269d0 = 0;

  foreach(event in level.gulag.eventinfo.events) {
    if(event.weight <= 0) {
      continue;
    }

    if(isDefined(currentcircle)) {
      if(event.mincircleindex > currentcircle) {
        continue;
      }

      if(event.maxcircleindex < currentcircle) {
        continue;
      }
    }

    if(event.maxtimes != -1 && event.timestriggered >= event.maxtimes) {
      continue;
    }

    if(event.settings.ladderescape && (arena.ladders.size < 1 || !istrue(level.var_2c4cb267d8d1cd85))) {
      continue;
    }

    var_d1a1505095d269d0 += event.weight;
    validevents[validevents.size] = event;
  }

  if(!validevents.size) {
    return;
  }

  randchoice = randomfloat(var_d1a1505095d269d0);
  sum = 0;

  foreach(eventinfo in validevents) {
    sum += eventinfo.weight;

    if(randchoice < sum) {
      arena function_2a154368a1c88e2c(eventinfo.index);
      eventinfo.timestriggered++;
      break;
    }
  }
}

function function_2a154368a1c88e2c(eventindex) {
  arena = self;
  arena.var_5380d19f084b018f = eventindex;
  arena.var_d6721f44f0896029 = undefined;
  arena.goagain = undefined;
  arena.ladderescape = undefined;
  arena.var_ac6e6c05c9957900 = undefined;
  arena.var_9bceb84d333290f0 = 0;
  arena.var_7f23e38228bd111c = 0;

  foreach(player in arena.arenaplayers) {
    player function_f84e3f723cf1aa0c(eventindex);
  }

  settings = function_9edca95997ab5b26(eventindex);

  if(!isDefined(settings)) {
    return;
  }

  arena.goagain = settings.goagain;
  arena.ladderescape = settings.ladderescape;

  if(arena.ladderescape) {
    arena.var_9bceb84d333290f0 = 1;
    arena.var_7f23e38228bd111c = 1;
  }

  arena.var_d6721f44f0896029 = spawnStruct();

  if(istrue(settings.setloadout)) {
    tablename = "classtable:" + settings.loadouts;
    numloadouts = scripts\mp\class::function_df2933f96d726d71(tablename);

    if(numloadouts > 0) {
      arena.var_d6721f44f0896029.loadoutindex = randomint(numloadouts);
    }
  }

  arena.var_ac6e6c05c9957900 = isDefined(settings.winnerloadouts) && settings.winnerloadouts != "";

  if(istrue(arena.var_ac6e6c05c9957900)) {
    tablename = "classtable:" + settings.winnerloadouts;
    numloadouts = scripts\mp\class::function_df2933f96d726d71(tablename);

    if(numloadouts > 0) {
      arena.var_d6721f44f0896029.winnerloadoutindex = randomint(numloadouts);
      arena.var_d6721f44f0896029.winnerloadouts = settings.winnerloadouts;
    }
  }
}

function function_f84e3f723cf1aa0c(eventindex) {
  player = self;

  if(isDefined(eventindex)) {
    omnvarindex = eventindex + 1;
  } else {
    omnvarindex = 0;
  }

  player setclientomnvar("ui_br_gulag_event", omnvarindex);
}

function function_9edca95997ab5b26(var_5380d19f084b018f) {
  if(!isDefined(var_5380d19f084b018f)) {
    return undefined;
  }

  return level.gulag.eventinfo.events[var_5380d19f084b018f].settings;
}

function function_6ff97369fec9e915(arena) {
  return function_9edca95997ab5b26(arena.var_5380d19f084b018f);
}

function showstartsplash(arena) {
  settings = function_9edca95997ab5b26(arena.var_5380d19f084b018f);

  if(!isDefined(settings)) {
    return false;
  }

  if(!isDefined(settings.splashstart)) {
    return false;
  }

  splashbundle = getscriptbundle(hashcat(%"hash_39857ea6520cf871", settings.splashstart));

  if(!isDefined(splashbundle)) {
    return false;
  }

  foreach(player in arena.arenaplayers) {
    player thread scripts\mp\hud_message::showsplash(splashbundle.splashref);
    scripts\mp\gametypes\br_public::brleaderdialog("gulag_event_" + settings.ref, 0, [player], undefined, undefined, undefined, "dx_br_jpbm_");
  }

  return true;
}

function function_c28154179ba75e54(arena) {
  player = self;
  settings = function_9edca95997ab5b26(arena.var_5380d19f084b018f);

  if(!isDefined(settings)) {
    return false;
  }

  if(istrue(settings.juggernaut)) {
    player thread function_9c63aeac756ca994();
    return true;
  }

  if(!istrue(settings.setloadout) || !isDefined(arena.var_d6721f44f0896029.loadoutindex)) {
    return false;
  }

  tablename = "classtable:" + settings.loadouts;
  gamemodeloadout = scripts\mp\gametypes\br::initstandardloadout(tablename, arena.var_d6721f44f0896029.loadoutindex);
  self.pers["gamemodeLoadout"] = gamemodeloadout;
  return true;
}

function function_62fed662c974c355(arena) {
  settings = function_9edca95997ab5b26(arena.var_5380d19f084b018f);

  if(!isDefined(settings)) {
    return false;
  }

  if(!istrue(settings.setarmor)) {
    return false;
  }

  scripts\cp_mp\armor::setarmorhealth(settings.armorhealth);
  return true;
}

function function_7ef30310d689330f(arena) {
  settings = function_9edca95997ab5b26(arena.var_5380d19f084b018f);

  if(!isDefined(settings)) {
    return false;
  }

  if(!istrue(settings.setarmor)) {
    return false;
  }

  self.overriderespawnarmor = settings.armorhealth;
  return true;
}

function prelootspawn(arena) {
  settings = function_9edca95997ab5b26(arena.var_5380d19f084b018f);

  if(!isDefined(settings)) {
    return;
  }

  if(istrue(settings.var_36a1848a7c8925fc)) {
    level.var_1d446b9562cad6cb = settings.var_78ca864641673db7;
  }

  if(istrue(settings.var_950425cbbab50df8)) {
    level.var_42706f92b61ab857 = settings.var_1c21fbda9b29971b;
  }
}

function shouldgivemaxammoprimary(arena) {
  settings = function_9edca95997ab5b26(arena.var_5380d19f084b018f);

  if(!isDefined(settings)) {
    return false;
  }

  return istrue(settings.maxammoprimary);
}

function shouldgivemaxammosecondary(arena) {
  settings = function_9edca95997ab5b26(arena.var_5380d19f084b018f);

  if(!isDefined(settings)) {
    return false;
  }

  return istrue(settings.maxammosecondary);
}

function gulagplayerlost(arena) {
  if(istrue(arena.goagain)) {
    if(isalive(self)) {
      self.plotarmor = 1;
      scripts\mp\gametypes\br_gulag::function_13ad2ef144d94c4f();
    }

    self notify("gulagLost");
    arena.arenaplayers = array_remove(arena.arenaplayers, self);
    scripts\mp\gametypes\br_public::brleaderdialogplayer("gulag_go_again", self, 0, undefined, undefined, undefined, "dx_br_jpbm_");
    wait scripts\mp\gametypes\br_gulag::function_86ee3121d91c59c3() + 1;
    scripts\mp\gametypes\br_gulag::playerdestroyhud(arena);

    if(isalive(self)) {
      self.plotarmor = undefined;
      scripts\mp\gametypes\br_gulag::function_d1977a031be07de6();
    }

    if(isDefined(self)) {
      thread scripts\mp\gametypes\br_gulag::initplayerjail(0, 1);
    }

    return 1;
  }

  return 0;
}

function function_9c63aeac756ca994() {
  self endon("disconnect");
  waitframe();

  if(issharedfuncdefined("airdrop", "applyImmediateJuggernaut")) {
    self[[getsharedfunc("airdrop", "applyImmediateJuggernaut")]](1, undefined);
    return;
  }

  scripts\cp_mp\killstreaks\juggernaut::tryusejuggernaut(1);
}
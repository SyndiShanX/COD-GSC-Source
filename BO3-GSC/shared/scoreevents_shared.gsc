/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\scoreevents_shared.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\abilities\_ability_power;
#using scripts\shared\callbacks_shared;
#using scripts\shared\gameskill_shared;
#using scripts\shared\killstreaks_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace scoreevents;

function processscoreevent(event, player, victim, weapon) {
  pixbeginevent("processScoreEvent");
  scoregiven = 0;
  if(!isPlayer(player)) {
    assertmsg("" + event);
    return scoregiven;
  }
  if(getdvarint("teamOpsEnabled") == 1) {
    if(isDefined(level.teamopsonprocessplayerevent)) {
      level[[level.teamopsonprocessplayerevent]](event, player);
    }
  }
  if(isDefined(level.challengesoneventreceived)) {
    player thread[[level.challengesoneventreceived]](event);
  }
  if(isregisteredevent(event) && (!sessionmodeiszombiesgame() || level.onlinegame)) {
    allowplayerscore = 0;
    if(!isDefined(weapon) || !killstreaks::is_killstreak_weapon(weapon)) {
      allowplayerscore = 1;
    } else {
      allowplayerscore = killstreakweaponsallowedscore(event);
    }
    if(allowplayerscore) {
      if(isDefined(level.scoreongiveplayerscore)) {
        scoregiven = [[level.scoreongiveplayerscore]](event, player, victim, undefined, weapon);
        isscoreevent = scoregiven > 0;
        if(isscoreevent) {
          hero_restricted = is_hero_score_event_restricted(event);
          player ability_power::power_gain_event_score(victim, scoregiven, weapon, hero_restricted);
        }
      }
    }
  }
  if(shouldaddrankxp(player) && getdvarint("teamOpsEnabled") == 0) {
    pickedup = 0;
    if(isDefined(weapon) && isDefined(player.pickedupweapons) && isDefined(player.pickedupweapons[weapon])) {
      pickedup = 1;
    }
    if(sessionmodeiscampaigngame()) {
      xp_difficulty_multiplier = player gameskill::get_player_xp_difficulty_multiplier();
    } else {
      xp_difficulty_multiplier = 1;
    }
    player addrankxp(event, weapon, player.class_num, pickedup, isscoreevent, xp_difficulty_multiplier);
  }
  pixendevent();
  if(sessionmodeiscampaigngame() && isDefined(xp_difficulty_multiplier)) {
    if(isDefined(victim) && isDefined(victim.team)) {
      if(victim.team == "axis" || victim.team == "team3") {
        scoregiven = scoregiven * xp_difficulty_multiplier;
      }
    }
  }
  return scoregiven;
}

function shouldaddrankxp(player) {
  if(sessionmodeiscampaignzombiesgame()) {
    return false;
  }
  if(level.gametype == "fr") {
    return false;
  }
  if(!isDefined(level.rankcap) || level.rankcap == 0) {
    return true;
  }
  if(player.pers["plevel"] > 0 || player.pers["rank"] > level.rankcap) {
    return false;
  }
  return true;
}

function uninterruptedobitfeedkills(attacker, weapon) {
  self endon("disconnect");
  wait(0.1);
  util::waittillslowprocessallowed();
  wait(0.1);
  processscoreevent("uninterrupted_obit_feed_kills", attacker, self, weapon);
}

function isregisteredevent(type) {
  if(isDefined(level.scoreinfo[type])) {
    return true;
  }
  return false;
}

function decrementlastobituaryplayercountafterfade() {
  level endon("reset_obituary_count");
  wait(5);
  level.lastobituaryplayercount--;
  assert(level.lastobituaryplayercount >= 0);
}

function getscoreeventtablename() {
  if(sessionmodeiscampaigngame()) {
    return "gamedata/tables/cp/scoreInfo.csv";
  }
  if(sessionmodeiszombiesgame()) {
    return "gamedata/tables/zm/scoreInfo.csv";
  }
  return "gamedata/tables/mp/scoreInfo.csv";
}

function getscoreeventtableid() {
  scoreinfotableloaded = 0;
  scoreinfotableid = tablelookupfindcoreasset(getscoreeventtablename());
  if(isDefined(scoreinfotableid)) {
    scoreinfotableloaded = 1;
  }
  assert(scoreinfotableloaded, "" + getscoreeventtablename());
  return scoreinfotableid;
}

function getscoreeventcolumn(gametype) {
  columnoffset = getcolumnoffsetforgametype(gametype);
  assert(columnoffset >= 0);
  if(columnoffset >= 0) {
    columnoffset = columnoffset + 0;
  }
  return columnoffset;
}

function getxpeventcolumn(gametype) {
  columnoffset = getcolumnoffsetforgametype(gametype);
  assert(columnoffset >= 0);
  if(columnoffset >= 0) {
    columnoffset = columnoffset + 1;
  }
  return columnoffset;
}

function getcolumnoffsetforgametype(gametype) {
  foundgamemode = 0;
  if(!isDefined(level.scoreeventtableid)) {
    level.scoreeventtableid = getscoreeventtableid();
  }
  assert(isDefined(level.scoreeventtableid));
  if(!isDefined(level.scoreeventtableid)) {
    return -1;
  }
  gamemodecolumn = 14;
  for(;;) {
    column_header = tablelookupcolumnforrow(level.scoreeventtableid, 0, gamemodecolumn);
    if(column_header == "") {
      gamemodecolumn = 14;
      break;
    }
    if(column_header == (level.gametype + " score")) {
      foundgamemode = 1;
      break;
    }
    gamemodecolumn = gamemodecolumn + 2;
  }
  assert(foundgamemode, "" + gametype);
  return gamemodecolumn;
}

function killstreakweaponsallowedscore(type) {
  if(getdvarint("teamOpsEnabled") == 1) {
    return false;
  }
  if(isDefined(level.scoreinfo[type]["allowKillstreakWeapons"]) && level.scoreinfo[type]["allowKillstreakWeapons"] == 1) {
    return true;
  }
  return false;
}

function is_hero_score_event_restricted(event) {
  if(!isDefined(level.scoreinfo[event]["allow_hero"]) || level.scoreinfo[event]["allow_hero"] != 1) {
    return true;
  }
  return false;
}

function givecratecapturemedal(crate, capturer) {
  if(isDefined(crate) && isDefined(capturer) && isDefined(crate.owner) && isPlayer(crate.owner)) {
    if(level.teambased) {
      if(capturer.team != crate.owner.team) {
        crate.owner playlocalsound("mpl_crate_enemy_steals");
        if(!isDefined(crate.hacker)) {
          processscoreevent("capture_enemy_crate", capturer);
        }
      } else if(isDefined(crate.owner) && capturer != crate.owner) {
        crate.owner playlocalsound("mpl_crate_friendly_steals");
        if(!isDefined(crate.hacker)) {
          level.globalsharepackages++;
          processscoreevent("share_care_package", crate.owner);
        }
      }
    } else if(capturer != crate.owner) {
      crate.owner playlocalsound("mpl_crate_enemy_steals");
      if(!isDefined(crate.hacker)) {
        processscoreevent("capture_enemy_crate", capturer);
      }
    }
  }
}

function register_hero_ability_kill_event(event_func) {
  if(!isDefined(level.hero_ability_kill_events)) {
    level.hero_ability_kill_events = [];
  }
  level.hero_ability_kill_events[level.hero_ability_kill_events.size] = event_func;
}

function register_hero_ability_multikill_event(event_func) {
  if(!isDefined(level.hero_ability_multikill_events)) {
    level.hero_ability_multikill_events = [];
  }
  level.hero_ability_multikill_events[level.hero_ability_multikill_events.size] = event_func;
}

function register_hero_weapon_multikill_event(event_func) {
  if(!isDefined(level.hero_weapon_multikill_events)) {
    level.hero_weapon_multikill_events = [];
  }
  level.hero_weapon_multikill_events[level.hero_weapon_multikill_events.size] = event_func;
}

function register_thief_shutdown_enemy_event(event_func) {
  if(!isDefined(level.thief_shutdown_enemy_events)) {
    level.thief_shutdown_enemy_events = [];
  }
  level.thief_shutdown_enemy_events[level.thief_shutdown_enemy_events.size] = event_func;
}

function hero_ability_kill_event(ability, victim_ability) {
  if(!isDefined(level.hero_ability_kill_events)) {
    return;
  }
  foreach(event_func in level.hero_ability_kill_events) {
    if(isDefined(event_func)) {
      self[[event_func]](ability, victim_ability);
    }
  }
}

function hero_ability_multikill_event(killcount, ability) {
  if(!isDefined(level.hero_ability_multikill_events)) {
    return;
  }
  foreach(event_func in level.hero_ability_multikill_events) {
    if(isDefined(event_func)) {
      self[[event_func]](killcount, ability);
    }
  }
}

function hero_weapon_multikill_event(killcount, weapon) {
  if(!isDefined(level.hero_weapon_multikill_events)) {
    return;
  }
  foreach(event_func in level.hero_weapon_multikill_events) {
    if(isDefined(event_func)) {
      self[[event_func]](killcount, weapon);
    }
  }
}

function thief_shutdown_enemy_event() {
  if(!isDefined(level.thief_shutdown_enemy_event)) {
    return;
  }
  foreach(event_func in level.thief_shutdown_enemy_event) {
    if(isDefined(event_func)) {
      self[[event_func]]();
    }
  }
}
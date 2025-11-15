/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\scoreevents_shared.gsc
***********************************************/

#include scripts\abilities\ability_power;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\contracts_shared;
#include scripts\core_common\rank_shared;
#include scripts\core_common\util_shared;

#namespace scoreevents;

function_6f51d1e9(event, players, victim, weapon) {
  if(!isDefined(players)) {
    return;
  }

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    processscoreevent(event, player, victim, weapon);
  }
}

processscoreevent(event, player, victim, weapon, playersaffected) {
  scoregiven = 0;

  if(isDefined(level.scoreinfo[event]) && isDefined(level.scoreinfo[event][#"is_deprecated"]) && level.scoreinfo[event][#"is_deprecated"]) {
    return scoregiven;
  }

  if(isDefined(level.disablescoreevents) && level.disablescoreevents) {
    return scoregiven;
  }

  if(!isplayer(player)) {
    return scoregiven;
  }

  pixbeginevent(#"processscoreevent");
  isscoreevent = 0;

  if(getdvarint(#"logscoreevents", 0) > 0) {
    if(!isDefined(level.var_10cd7193)) {
      level.var_10cd7193 = [];
    }

    eventstr = ishash(event) ? function_9e72a96(event) : event;

    if(!isDefined(level.var_10cd7193)) {
      level.var_10cd7193 = [];
    } else if(!isarray(level.var_10cd7193)) {
      level.var_10cd7193 = array(level.var_10cd7193);
    }

    level.var_10cd7193[level.var_10cd7193.size] = eventstr;
  }

  if(isDefined(level.challengesoneventreceived)) {
    player thread[[level.challengesoneventreceived]](event);
  }

  if(isDefined(level.onscoreevent)) {
    profilestart();
    params = {};
    params.event = event;
    params.victim = victim;
    player[[level.onscoreevent]](params);
    profilestop();
  }

  if(isregisteredevent(event) && (!sessionmodeiszombiesgame() || level.onlinegame)) {
    if(isDefined(level.scoreongiveplayerscore)) {
      scoregiven = [
        [level.scoreongiveplayerscore]
      ](event, player, victim, undefined, weapon, playersaffected);

      if(scoregiven > 0) {
        player ability_power::power_gain_event_score(event, victim, scoregiven, weapon);
      }
    }
  }

  if(shouldaddrankxp(player) && (!isDefined(victim) || !(isDefined(victim.disable_score_events) && victim.disable_score_events))) {
    pickedup = 0;

    if(isDefined(weapon) && isDefined(player.pickedupweapons) && isDefined(player.pickedupweapons[weapon])) {
      pickedup = 1;
    }

    xp_difficulty_multiplier = 1;

    if(isDefined(level.var_3426461d)) {
      xp_difficulty_multiplier = [
        [level.var_3426461d]
      ]();
    }

    player addrankxp(event, weapon, player.class_num, pickedup, isscoreevent, xp_difficulty_multiplier);

    if(isDefined(event) && isDefined(weapon) && isDefined(level.scoreinfo[event])) {
      var_6d1793bb = level.scoreinfo[event][#"medalnamehash"];

      if(isDefined(var_6d1793bb)) {
        specialistindex = player getspecialistindex();
        medalname = function_dcad256c(specialistindex, currentsessionmode(), 0);

        if(medalname == var_6d1793bb) {
          player.ability_medal_count = (isDefined(player.ability_medal_count) ? player.ability_medal_count : 0) + 1;
          player.pers["ability_medal_count" + specialistindex] = player.ability_medal_count;
        }

        medalname = function_dcad256c(specialistindex, currentsessionmode(), 1);

        if(medalname == var_6d1793bb) {
          player.equipment_medal_count = (isDefined(player.equipment_medal_count) ? player.equipment_medal_count : 0) + 1;
          player.pers["equipment_medal_count" + specialistindex] = player.equipment_medal_count;
        }
      }
    }
  }

  pixendevent();

  if(sessionmodeiscampaigngame() && isDefined(xp_difficulty_multiplier)) {
    if(isDefined(victim) && isDefined(victim.team)) {
      if(victim.team == #"axis" || victim.team == #"team3") {
        scoregiven *= xp_difficulty_multiplier;
      }
    }
  }

  return scoregiven;
}

shouldaddrankxp(player) {
  if(level.gametype == "fr") {
    return false;
  }

  if(level.gametype == "zclassic" && isDefined(level.var_5164a0ca) && level.var_5164a0ca) {
    return false;
  }

  if(isDefined(level.var_4f654f3a) && level.var_4f654f3a) {
    playername = "<dev string:x38>";

    if(isDefined(player) && isDefined(player.name)) {
      playername = player.name;
    }

    println("<dev string:x42>" + playername);

    return false;
  }

  if(!isDefined(level.rankcap) || level.rankcap == 0) {
    return true;
  }

  if(player.pers[#"plevel"] > 0 || player.pers[#"rank"] > level.rankcap) {
    return false;
  }

  return true;
}

uninterruptedobitfeedkills(attacker, weapon) {
  self endon(#"disconnect");
  wait 0.1;
  util::waittillslowprocessallowed();
  wait 0.1;

  if(isDefined(attacker)) {
    processscoreevent(#"uninterrupted_obit_feed_kills", attacker, self, weapon);
    attacker contracts::increment_contract(#"contract_mp_quad_feed");
  }
}

function_c046c773(waitduration, event, player, victim, weapon) {
  self endon(#"disconnect");
  wait waitduration;
  processscoreevent(event, player, victim, weapon);
}

isregisteredevent(type) {
  if(isDefined(level.scoreinfo[type])) {
    return 1;
  }

  return 0;
}

decrementlastobituaryplayercountafterfade() {
  level endon(#"reset_obituary_count");
  wait 5;
  level.lastobituaryplayercount--;
  assert(level.lastobituaryplayercount >= 0);
}

function_2b96d7dc() {
  if(!isDefined(level.var_d1455682)) {
    return undefined;
  }

  table_name = function_6a9e36d6();

  if(!isDefined(table_name)) {
    return undefined;
  }

  args = strtok(table_name, "\" );

    if(args.size) {
      table_name = "";

      foreach(index, arg in args) {
        table_name += arg;

        if(index < args.size - 1) {
          table_name += "/";
        }
      }
    }

    return hash(table_name);
  }

  function getscoreeventtablename(gametype) {
    table_name = function_2b96d7dc();

    if(isDefined(table_name) && isDefined(isassetloaded("stringtable", table_name)) && isassetloaded("stringtable", table_name)) {
      return table_name;
    }

    if(!isDefined(gametype)) {
      gametype = "base";
    }

    prefix = #"gamedata/tables/mp/scoreinfo/mp_scoreinfo";

    if(sessionmodeiscampaigngame()) {
      prefix = #"gamedata/tables/cp/scoreinfo/cp_scoreinfo";
    } else if(sessionmodeiszombiesgame()) {
      prefix = #"gamedata/tables/zm/scoreinfo/zm_scoreinfo";
    } else if(sessionmodeiswarzonegame()) {
      prefix = #"gamedata/tables/wz/scoreinfo/wz_scoreinfo";
    }

    gametype = strreplace(gametype, "_hc", "");
    gametype = strreplace(gametype, "_cwl", "");
    gametype = strreplace(gametype, "_bb", "");
    tablename = prefix + "_" + gametype + ".csv";

    if(!(isDefined(isassetloaded("stringtable", tablename)) && isassetloaded("stringtable", tablename))) {
      tablename = prefix + "_base.csv";
    }

    if(isDefined(isassetloaded("stringtable", tablename)) && isassetloaded("stringtable", tablename)) {
      return tablename;
    }

    return tablename;
  }

  function getscoreeventtableid(gametype) {
    scoreinfotableloaded = 0;
    tablename = getscoreeventtablename(gametype);
    scoreinfotableid = tablelookupfindcoreasset(tablename);

    if(!isDefined(scoreinfotableid)) {
      tablelookupfindcoreasset(getscoreeventtablename("base"));
    }

    if(isDefined(scoreinfotableid)) {
      scoreinfotableloaded = 1;
    }

    assert(scoreinfotableloaded, "<dev string:x70>" + function_9e72a96(getscoreeventtablename()));
    return scoreinfotableid;
  }

  function givecratecapturemedal(crate, capturer) {
    if(isDefined(crate.owner) && isplayer(crate.owner)) {
      if(level.teambased) {
        if(capturer.team != crate.owner.team) {
          crate.owner playlocalsound(#"mpl_crate_enemy_steals");

          if(!isDefined(crate.hacker)) {
            processscoreevent(#"capture_enemy_crate", capturer, undefined, undefined);
          }
        } else if(isDefined(crate.owner) && capturer != crate.owner) {
          crate.owner playlocalsound(#"mpl_crate_friendly_steals");

          if(!isDefined(crate.hacker)) {
            level.globalsharepackages++;
            processscoreevent(#"share_care_package", crate.owner, undefined, undefined);
          }
        }

        return;
      }

      if(capturer != crate.owner) {
        crate.owner playlocalsound(#"mpl_crate_enemy_steals");

        if(!isDefined(crate.hacker)) {
          processscoreevent(#"capture_enemy_crate", capturer, undefined, undefined);
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

  function function_dcdf1105() {
    self callback::add_callback(#"fully_healed", &player_fully_healed);
  }

  function player_fully_healed() {
    self.var_ae639436 = undefined;
  }

  function player_spawned() {
    profilestart();
    self.var_ae639436 = undefined;
    profilestop();
  }

  function function_f40d64cc(attacker, vehicle, weapon) {
    if(!isDefined(weapon)) {
      return;
    }

    switch (weapon.statname) {
      case #"ultimate_turret":
        event = "automated_turret_vehicle_destruction";
        break;
      default:
        return;
    }

    victim = isDefined(vehicle) ? vehicle.owner : undefined;
    processscoreevent(event, attacker, victim, weapon);
  }
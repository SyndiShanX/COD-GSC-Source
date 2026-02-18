/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\scoreevents_shared.gsc
***********************************************/

#using script_7a8059ca02b7b09e;
#using scripts\abilities\ability_power;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\rank_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_util;
#namespace scoreevents;

function registerscoreeventcallback(callback, func) {
  if(!isDefined(level.scoreeventcallbacks)) {
    level.scoreeventcallbacks = [];
  }

  if(!isDefined(level.scoreeventcallbacks[callback])) {
    level.scoreeventcallbacks[callback] = [];
  }

  if(!isDefined(level.scoreeventcallbacks[callback])) {
    level.scoreeventcallbacks[callback] = [];
  } else if(!isarray(level.scoreeventcallbacks[callback])) {
    level.scoreeventcallbacks[callback] = array(level.scoreeventcallbacks[callback]);
  }

  level.scoreeventcallbacks[callback][level.scoreeventcallbacks[callback].size] = func;
}

function function_9677601b(callback, func) {
  if(!isDefined(level.var_8c00e05d)) {
    level.var_8c00e05d = [];
  }

  if(!isDefined(level.var_8c00e05d[callback])) {
    level.var_8c00e05d[callback] = [];
  }

  if(!isDefined(level.var_8c00e05d[callback])) {
    level.var_8c00e05d[callback] = [];
  } else if(!isarray(level.var_8c00e05d[callback])) {
    level.var_8c00e05d[callback] = array(level.var_8c00e05d[callback]);
  }

  level.var_8c00e05d[callback][level.var_8c00e05d[callback].size] = func;
}

function function_6f51d1e9(event, players, victim, weapon) {
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

function function_2a2e1723(event, player, victim, weapon) {
  scoregiven = processscoreevent(event, player, victim, weapon, undefined, undefined, undefined, 1);

  if(isDefined(victim.var_1318544a)) {
    victim.var_1318544a.var_7b4d33ac = 1;
  }

  return scoregiven;
}

function processscoreevent(event, player, victim, weapon, playersaffected, var_dbaa74e2, var_28e349dc, var_6d2812ce, inflictor) {
  scoregiven = 0;

  if(is_true(victim.var_12745932)) {
    return scoregiven;
  }

  if(isDefined(level.scoreinfo[event]) && is_true(level.scoreinfo[event][# "is_deprecated"])) {
    return scoregiven;
  }

  if(is_true(level.disablescoreevents)) {
    return scoregiven;
  }

  if(!isPlayer(player)) {
    return scoregiven;
  }

  if(isDefined(level.var_e4688422)) {
    foreach(var_91c18f6b in level.var_e4688422) {
      if(var_91c18f6b === event) {
        return scoregiven;
      }
    }
  }

  pixbeginevent(#"");
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

  if(isregisteredevent(event)) {
    if(isDefined(level.scoreongiveplayerscore) && !is_true(var_28e349dc)) {
      scoregiven = [[level.scoreongiveplayerscore]](event, player, victim, undefined, weapon, playersaffected, var_dbaa74e2);

      if(scoregiven > 0) {
        player ability_power::power_gain_event_score(event, victim, scoregiven, weapon);

        if(getdvarint(#"hash_628a73b6809e0598", 0) > 0) {
          println("<dev string:x38>" + player.playername + "<dev string:x55>" + function_9e72a96(event) + "<dev string:x60>" + scoregiven);
        }
      }
    }
  }

  if(shouldaddrankxp(player) && (!isDefined(victim) || !is_true(victim.disable_score_events))) {
    pickedup = isDefined(player.pickedupweapons[weapon]);
    xp_difficulty_multiplier = 1;
    var_50e404bf = 1;

    if(isDefined(level.var_3426461d)) {
      xp_difficulty_multiplier = player[[level.var_3426461d]](event);
    }

    if(isDefined(level.var_2f528eb0)) {
      var_50e404bf = player[[level.var_2f528eb0]](event);
    }

    var_6b09455c = undefined;

    if(var_6d2812ce === 1 && isDefined(level.var_e7152385)) {
      var_6b09455c = [[level.var_e7152385]]({
        #victim: victim
      });
    }

    if(isDefined(weapon) && !pickedup) {
      weaponitemindex = getbaseweaponitemindex(weapon);
      gunxp = isDefined(player function_5ab9855c(weaponitemindex)) ? player function_5ab9855c(weaponitemindex) : 0;
    }

    player addrankxp(event, 0, weapon, player.class_num, pickedup, xp_difficulty_multiplier, var_6b09455c, var_50e404bf);

    if(isDefined(weapon) && !pickedup) {
      newgunxp = isDefined(player function_5ab9855c(weaponitemindex)) ? player function_5ab9855c(weaponitemindex) : 0;
      var_de0c8b34 = newgunxp - gunxp;

      if(var_de0c8b34 > 0) {
        level thread telemetry::function_18135b72(#"hash_b88b6d2e0028e13", {
          #player: player, #weapon: weapon, #statname: # "xpearned", #value: var_de0c8b34, #weaponpickedup: pickedup
        });
      }
    }

    if(level.hardcoremode && isDefined(level.var_c26a3a23[event])) {
      player stats::function_dad108fa(level.var_c26a3a23[event], 1);
    }

    if(isDefined(weapon) && isDefined(level.scoreinfo[event])) {
      var_6d1793bb = level.scoreinfo[event][# "medalnamehash"];

      if(isDefined(var_6d1793bb)) {
        specialistindex = player getspecialistindex();
        medalname = function_dcad256c(specialistindex, currentsessionmode(), 0);

        if(medalname == var_6d1793bb) {
          player.pers["ability_medal_count" + specialistindex] = (isDefined(player.pers["ability_medal_count" + specialistindex]) ? player.pers["ability_medal_count" + specialistindex] : 0) + 1;
        }

        medalname = function_dcad256c(specialistindex, currentsessionmode(), 1);

        if(medalname == var_6d1793bb) {
          player.pers["equipment_medal_count" + specialistindex] = (isDefined(player.pers["equipment_medal_count" + specialistindex]) ? player.pers["equipment_medal_count" + specialistindex] : 0) + 1;
        }
      }
    }
  }

  pixendevent();

  if(sessionmodeiscampaigngame() && isDefined(xp_difficulty_multiplier)) {
    if(isDefined(victim) && isDefined(victim.team)) {
      if(victim.team == # "axis" || victim.team == # "team3") {
        scoregiven *= xp_difficulty_multiplier;
      }
    }
  }

  if(isDefined(victim.deathtime)) {
    time = victim.deathtime;
  }

  function_644d867a(player, time, event, weapon, inflictor);
  return scoregiven;
}

function doscoreeventcallback(callback, data) {
  function_e4171c51(callback, data);
  function_32358e67(callback, data);

  if(isDefined(data.victim.var_1318544a)) {
    data.victim.var_1318544a = undefined;
  }
}

function private function_e4171c51(callback, data) {
  if(!isDefined(level.scoreeventcallbacks[callback])) {
    return;
  }

  for(i = 0; i < level.scoreeventcallbacks[callback].size; i++) {
    thread[[level.scoreeventcallbacks[callback][i]]](data);
  }
}

function private function_32358e67(callback, data) {
  if(!isDefined(level.var_8c00e05d[callback])) {
    return;
  }

  for(i = 0; i < level.var_8c00e05d[callback].size; i++) {
    thread[[level.var_8c00e05d[callback][i]]](data);
  }
}

function shouldaddrankxp(player) {
  if(level.gametype == "fr") {
    return false;
  }

  if(level.gametype == "zclassic" && is_true(level.var_5164a0ca)) {
    return false;
  }

  if(is_true(level.var_4f654f3a)) {
    playername = "<dev string:x6b>";

    if(isDefined(player) && isDefined(player.name)) {
      playername = player.name;
    }

    println("<dev string:x76>" + playername);

    return false;
  }

  if(isDefined(level.var_77d7c40d)) {
    if([[level.var_77d7c40d]](player)) {
      return false;
    }
  }

  if(!isDefined(level.rankcap) || level.rankcap == 0) {
    return true;
  }

  if(player.pers[# "plevel"] > 0 || player.pers[# "rank"] >= level.rankcap) {
    return false;
  }

  return true;
}

function uninterruptedobitfeedkills(attacker, weapon) {
  self endon(#"disconnect");
  wait 0.1;
  util::waittillslowprocessallowed();
  wait 0.1;

  if(isDefined(attacker)) {
    processscoreevent(#"uninterrupted_obit_feed_kills", attacker, self, weapon);
    attacker contracts::increment_contract(#"contract_mp_quad_feed");
    attacker stats::function_dad108fa(#"hash_3b7d759c8864b5d8", 1);
  }
}

function function_c046c773(waitduration, event, player, victim, weapon) {
  self endon(#"disconnect");
  wait waitduration;
  processscoreevent(event, player, victim, weapon);
}

function isregisteredevent(type) {
  if(isDefined(level.scoreinfo[type])) {
    return 1;
  }

  return 0;
}

function decrementlastobituaryplayercountafterfade() {
  level endon(#"reset_obituary_count");
  wait 5;
  level.lastobituaryplayercount--;
  assert(level.lastobituaryplayercount >= 0);
}

function function_2b96d7dc() {
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

    if(isDefined(table_name) && is_true(isassetloaded("stringtable", table_name))) {
      return table_name;
    }

    if(!isDefined(gametype)) {
      gametype = "base";
    }

    prefix = # "gamedata/tables/mp/scoreinfo/mp_scoreinfo";

    if(sessionmodeiscampaigngame()) {
      prefix = # "gamedata/tables/cp/scoreinfo/cp_scoreinfo";
    } else if(sessionmodeiszombiesgame()) {
      prefix = # "gamedata/tables/zm/scoreinfo/zm_scoreinfo";
    } else if(sessionmodeiswarzonegame()) {
      prefix = # "gamedata/tables/wz/scoreinfo/wz_scoreinfo";
    }

    gametype = strreplace(gametype, "_hc", "");
    gametype = strreplace(gametype, "_cdl", "");
    gametype = strreplace(gametype, "_bb", "");
    tablename = prefix + "_" + gametype + ".csv";

    if(!is_true(isassetloaded("stringtable", tablename))) {
      tablename = prefix + "_base.csv";
    }

    if(is_true(isassetloaded("stringtable", tablename))) {
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

    assert(scoreinfotableloaded, "<dev string:xa5>" + function_9e72a96(getscoreeventtablename()));
    return scoreinfotableid;
  }

  function givecratecapturemedal(crate, capturer) {
    if(isDefined(crate.owner) && isPlayer(crate.owner)) {
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

  function function_dcdf1105() {
    self callback::add_callback(#"fully_healed", &player_fully_healed);
  }

  function player_fully_healed() {
    self.var_ae639436 = undefined;

    if(self.var_9cd2c51d.var_43797ec0 === level.var_507570e9) {
      var_b68a8a9f = self.health - (isDefined(self.var_9cd2c51d.var_6e219f3c) ? self.var_9cd2c51d.var_6e219f3c : 0);

      if(var_b68a8a9f > 0) {
        self stats::function_dad108fa(#"hash_1cd9a591d101dca", var_b68a8a9f);
        self stats::function_dad108fa(#"hash_4c84965d6d12a705", var_b68a8a9f);
        self stats::function_dad108fa(#"hash_4c84905d6d129cd3", var_b68a8a9f);
      }
    }
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
      case # "ultimate_turret":
        event = "automated_turret_vehicle_destruction";
        break;
      default:
        return;
    }

    victim = isDefined(vehicle) ? vehicle.owner : undefined;
    processscoreevent(event, attacker, victim, weapon);
  }

  function function_644d867a(attacker, time, statname, weapon, inflictor) {
    var_42648a02 = level.var_42648a02[statname];

    if(isDefined(var_42648a02) && attacker.var_d853c1af !== 1) {
      attackerentnum = attacker getentitynumber();

      if(!isDefined(time)) {
        time = gettime();
      }

      if(!isDefined(level.var_75aa0434[attackerentnum][statname]) || level.var_75aa0434[attackerentnum][statname] < time) {
        var_1215a07e = 1;

        if(isDefined(level.var_1acb0192)) {
          var_1215a07e = [[level.var_1acb0192]](var_42648a02);
        }

        if(sessionmodeiszombiesgame()) {
          n_chance = var_42648a02[1] * var_1215a07e * 100;
          var_bcbd6252 = math::cointoss(n_chance);
        } else {
          var_bcbd6252 = var_42648a02[1] * var_1215a07e > randomfloatrange(0, 1);
        }

        if(var_bcbd6252) {
          function_31eb1b07(attacker, statname, var_42648a02[0], var_42648a02[3], weapon, inflictor);
        }

        level.var_75aa0434[attackerentnum][statname] = time + 100;
      }
    }
  }

  function function_31eb1b07(player, statname, var_26568428, timetoplay, weapon, inflictor) {
    attackerentnum = player getentitynumber();
    var_46604f00 = level.var_648e79b7[attackerentnum];

    if(isDefined(var_46604f00)) {
      var_30ffb0d9 = isDefined(level.var_42648a02[var_46604f00.statname][0]) ? level.var_42648a02[var_46604f00.statname][0] : 0;

      if(var_26568428 >= var_30ffb0d9) {
        level.var_648e79b7[attackerentnum] = {
          #statname: statname, #timestamp: gettime() + timetoplay, #weapon: weapon, #einflictor: inflictor
        };
      }

      return;
    }

    level.var_648e79b7[attackerentnum] = {
      #statname: statname, #timestamp: gettime() + timetoplay, #weapon: weapon, #einflictor: inflictor
    };
  }
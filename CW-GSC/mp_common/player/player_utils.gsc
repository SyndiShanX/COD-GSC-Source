/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\player\player_utils.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\killstreaks\mp\killstreaks;
#using scripts\mp_common\util;
#namespace player;

function figure_out_friendly_fire(victim, attacker) {
  if(level.hardcoremode && level.friendlyfire > 0 && isDefined(victim) && victim.is_capturing_own_supply_drop === 1) {
    return 2;
  }

  if(killstreaks::is_ricochet_protected(victim)) {
    return 2;
  }

  if(level.friendlyfire == 4 && isPlayer(attacker)) {
    if(attacker.pers[# "teamkills_nostats"] < level.var_fe3ff9c1) {
      return 1;
    } else {
      return 2;
    }
  }

  if(isDefined(level.figure_out_gametype_friendly_fire)) {
    return [[level.figure_out_gametype_friendly_fire]](victim);
  }

  return level.friendlyfire;
}

function freeze_player_for_round_end() {
  self hud_message::clearlowermessage();

  if(!self function_8b1a219a()) {
    self closeingamemenu();
  }

  function_7be72477(0);
  currentweapon = self getcurrentweapon();

  if(killstreaks::is_killstreak_weapon(currentweapon) && !currentweapon.iscarriedkillstreak) {
    self takeweapon(currentweapon);
  }
}

function function_a074b96f(enabled) {
  if(enabled) {
    if(!is_true(level.var_3d1e480e)) {
      if(is_true(getgametypesetting(#"hash_1b85ace023e616a1"))) {
        self val::function_4671dfff(#"spawn_player", 1);
      } else {
        self val::set(#"spawn_player", "freezecontrols");
        self val::set(#"spawn_player", "disablegadgets");
      }
    }

    return;
  }

  if(is_true(getgametypesetting(#"hash_1b85ace023e616a1"))) {
    self val::function_4671dfff(#"spawn_player", 0);
    return;
  }

  self val::reset(#"spawn_player", "freezecontrols");
  self val::reset(#"spawn_player", "disablegadgets");
}

function function_7be72477(enabled) {
  if(enabled) {
    if(is_true(getgametypesetting(#"hash_16e0649caf2f76b5"))) {
      self val::function_5276aede(#"freeze_player_for_round_end", 1);
    } else {
      self val::set(#"freeze_player_for_round_end", "freezecontrols");
      self val::set(#"freeze_player_for_round_end", "disablegadgets");
    }

    return;
  }

  if(is_true(getgametypesetting(#"hash_16e0649caf2f76b5"))) {
    self val::function_5276aede(#"freeze_player_for_round_end", 0);
    return;
  }

  self val::reset(#"freeze_player_for_round_end", "freezecontrols");
  self val::reset(#"freeze_player_for_round_end", "disablegadgets");
}

function function_c49fc862(team) {
  if(level.teamcount <= 2 && is_true(level.takelivesondeath) && is_true(level.teambased) && !is_true(level.var_a5f54d9f)) {
    if(level.teamindex[team] > level.teamcount) {
      return;
    }

    teamid = "team" + level.teamindex[team];

    if(is_true(level.var_61952d8b[team])) {
      if(!isDefined(level.playerlives[team])) {
        return;
      }

      clientfield::set_world_uimodel("hudItems." + teamid + ".livesCount", level.playerlives[team]);
      return;
    }

    if(!isDefined(game.lives[team])) {
      return;
    }

    clientfield::set_world_uimodel("hudItems." + teamid + ".livesCount", game.lives[team]);
  }
}

function function_cf3aa03d(func, threaded = 1) {
  array::add(level.var_da2045d0, {
    #callback: func, #threaded: threaded
  });
}

function function_3c5cc656(func, threaded = 1) {
  array::add(level.var_fa66fada, {
    #callback: func, #threaded: threaded
  });
}
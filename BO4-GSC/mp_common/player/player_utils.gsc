/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\player\player_utils.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\hud_message_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\killstreaks\killstreaks_util;
#include scripts\killstreaks\mp\killstreaks;
#include scripts\mp_common\util;

#namespace player;

figure_out_friendly_fire(victim, attacker) {
  if(level.hardcoremode && level.friendlyfire > 0 && isDefined(victim) && victim.is_capturing_own_supply_drop === 1) {
    return 2;
  }

  if(killstreaks::is_ricochet_protected(victim)) {
    return 2;
  }

  if(level.friendlyfire == 4 && isplayer(attacker)) {
    if(attacker.pers[#"teamkills_nostats"] < level.var_fe3ff9c1) {
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

freeze_player_for_round_end() {
  self hud_message::clearlowermessage();

  if(!function_8b1a219a()) {
    self closeingamemenu();
  }

  self val::set(#"freeze_player_for_round_end", "freezecontrols");
  self val::set(#"freeze_player_for_round_end", "disablegadgets");
  currentweapon = self getcurrentweapon();

  if(killstreaks::is_killstreak_weapon(currentweapon) && !currentweapon.iscarriedkillstreak) {
    self takeweapon(currentweapon);
  }
}

function_c49fc862(team) {
  if(isDefined(level.takelivesondeath) && level.takelivesondeath && isDefined(level.teambased) && level.teambased && !(isDefined(level.var_a5f54d9f) && level.var_a5f54d9f)) {
    teamid = "team" + level.teamindex[team];

    if(isDefined(level.var_61952d8b[team]) && level.var_61952d8b[team]) {
      clientfield::set_world_uimodel("hudItems." + teamid + ".livesCount", level.playerlives[team]);
      return;
    }

    clientfield::set_world_uimodel("hudItems." + teamid + ".livesCount", game.lives[team]);
  }
}

function_14e61d05() {
  return self hasperk(#"specialty_stunprotection") || self hasperk(#"specialty_flashprotection") || self hasperk(#"specialty_proximityprotection");
}

function_cf3aa03d(func, threaded = 1) {
  array::add(level.var_da2045d0, {
    #callback: func, 
    #threaded: threaded
  });
}

function_3c5cc656(func, threaded = 1) {
  array::add(level.var_fa66fada, {
    #callback: func, 
    #threaded: threaded
  });
}
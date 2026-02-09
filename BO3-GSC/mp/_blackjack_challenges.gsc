/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_blackjack_challenges.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_challenges;
#using scripts\mp\_util;
#using scripts\mp\gametypes\_loadout;
#using scripts\shared\callbacks_shared;
#using scripts\shared\challenges_shared;
#using scripts\shared\drown;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_weapon_utils;
#namespace blackjack_challenges;

function autoexec __init__sytem__() {
  system::register("blackjack_challenges", &__init__, undefined, undefined);
}

function __init__() {
  callback::on_start_gametype(&start_gametype);
}

function start_gametype() {
  if(!isDefined(level.challengescallbacks)) {
    level.challengescallbacks = [];
  }
  waittillframeend();
  if(challenges::canprocesschallenges()) {
    challenges::registerchallengescallback("playerKilled", &challenge_kills);
    challenges::registerchallengescallback("roundEnd", &challenge_round_ended);
    challenges::registerchallengescallback("gameEnd", &challenge_game_ended);
    scoreevents::register_hero_ability_kill_event(&on_hero_ability_kill);
  }
  callback::on_connect(&on_player_connect);
}

function on_player_connect() {
  player = self;
  if(challenges::canprocesschallenges()) {
    specialistindex = player getspecialistindex();
    isblackjack = specialistindex == 9;
    if(isblackjack) {
      player thread track_blackjack_consumable();
      if(!isDefined(self.pers["blackjack_challenge_active"])) {
        remaining_time = player consumableget("blackjack", "awarded") - player consumableget("blackjack", "consumed");
        if(remaining_time > 0) {
          special_card_earned = player get_challenge_stat("special_card_earned");
          if(!special_card_earned) {
            player.pers["blackjack_challenge_active"] = 1;
            player.pers["blackjack_unique_specialist_kills"] = 0;
            player.pers["blackjack_specialist_kills"] = 0;
            player.pers["blackjack_unique_weapon_mask"] = 0;
            player.pers["blackjack_unique_ability_mask"] = 0;
          }
        }
      }
    }
  }
}

function is_challenge_active() {
  return self.pers["blackjack_challenge_active"] === 1;
}

function on_hero_ability_kill(ability, victimability) {
  player = self;
  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }
  if(!isDefined(player.isroulette) || !player.isroulette) {
    return;
  }
  if(player is_challenge_active()) {
    player.pers["blackjack_specialist_kills"]++;
    currentheroabilitymask = player.pers["blackjack_unique_ability_mask"];
    heroabilitymask = get_hero_ability_mask(ability);
    newheroabilitymask = heroabilitymask | currentheroabilitymask;
    if(newheroabilitymask != currentheroabilitymask) {
      player.pers["blackjack_unique_specialist_kills"]++;
      player.pers["blackjack_unique_ability_mask"] = newheroabilitymask;
    }
    player check_blackjack_challenge();
  }
}

function debug_print_already_earned() {
  if(getdvarint("", 0) == 0) {
    return;
  }
  iprintln("");
}

function debug_print_kill_info() {
  if(getdvarint("", 0) == 0) {
    return;
  }
  player = self;
  iprintln((("" + player.pers[""]) + "") + player.pers[""]);
}

function debug_print_earned() {
  if(getdvarint("", 0) == 0) {
    return;
  }
  iprintln("");
}

function check_blackjack_challenge() {
  player = self;
  debug_print_kill_info();
  special_card_earned = player get_challenge_stat("special_card_earned");
  if(special_card_earned) {
    debug_print_already_earned();
    return;
  }
  if(player.pers["blackjack_specialist_kills"] >= 4 && player.pers["blackjack_unique_specialist_kills"] >= 2) {
    player set_challenge_stat("special_card_earned", 1);
    player addplayerstat("blackjack_challenge", 1);
    debug_print_earned();
  }
}

function challenge_kills(data) {
  attackeristhief = data.attackeristhief;
  attackerisroulette = data.attackerisroulette;
  attackeristhieforroulette = attackeristhief || attackerisroulette;
  if(!attackeristhieforroulette) {
    return;
  }
  victim = data.victim;
  attacker = data.attacker;
  player = attacker;
  weapon = data.weapon;
  if(!isDefined(weapon) || weapon == level.weaponnone) {
    return;
  }
  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }
  if(attackeristhief) {
    if(weapon.isheroweapon === 1) {
      if(player is_challenge_active()) {
        player.pers["blackjack_specialist_kills"]++;
        currentheroweaponmask = player.pers["blackjack_unique_weapon_mask"];
        heroweaponmask = get_hero_weapon_mask(attacker, weapon);
        newheroweaponmask = heroweaponmask | currentheroweaponmask;
        if(newheroweaponmask != currentheroweaponmask) {
          player.pers["blackjack_unique_specialist_kills"] = player.pers["blackjack_unique_specialist_kills"] + 1;
          player.pers["blackjack_unique_weapon_mask"] = newheroweaponmask;
        }
        player check_blackjack_challenge();
      }
    }
  }
}

function get_challenge_stat(stat_name) {
  return self getdstat("tenthspecialistcontract", stat_name);
}

function set_challenge_stat(stat_name, stat_value) {
  return self setdstat("tenthspecialistcontract", stat_name, stat_value);
}

function get_hero_weapon_mask(attacker, weapon) {
  if(!isDefined(weapon)) {
    return 0;
  }
  if(isDefined(weapon.isheroweapon) && !weapon.isheroweapon) {
    return 0;
  }
  switch (weapon.name) {
    case "hero_minigun":
    case "hero_minigun_body3": {
      return 1;
      break;
    }
    case "hero_flamethrower": {
      return 2;
      break;
    }
    case "hero_lightninggun":
    case "hero_lightninggun_arc": {
      return 4;
      break;
    }
    case "hero_chemicalgelgun":
    case "hero_firefly_swarm": {
      return 8;
      break;
    }
    case "hero_pineapple_grenade":
    case "hero_pineapplegun": {
      return 16;
      break;
    }
    case "hero_armblade": {
      return 32;
      break;
    }
    case "hero_bowlauncher":
    case "hero_bowlauncher2":
    case "hero_bowlauncher3":
    case "hero_bowlauncher4": {
      return 64;
      break;
    }
    case "hero_gravityspikes": {
      return 128;
      break;
    }
    case "hero_annihilator": {
      return 256;
      break;
    }
    default: {
      return 0;
    }
  }
}

function get_hero_ability_mask(ability) {
  if(!isDefined(ability)) {
    return 0;
  }
  switch (ability.name) {
    case "gadget_clone": {
      return 1;
      break;
    }
    case "gadget_heat_wave": {
      return 2;
      break;
    }
    case "gadget_flashback": {
      return 4;
      break;
    }
    case "gadget_resurrect": {
      return 8;
      break;
    }
    case "gadget_armor": {
      return 16;
      break;
    }
    case "gadget_camo": {
      return 32;
      break;
    }
    case "gadget_vision_pulse": {
      return 64;
      break;
    }
    case "gadget_speed_burst": {
      return 128;
      break;
    }
    case "gadget_combat_efficiency": {
      return 256;
      break;
    }
    default: {
      return 0;
    }
  }
}

function challenge_game_ended(data) {
  if(!isDefined(data)) {
    return;
  }
  player = data.player;
  if(!isDefined(player)) {
    return;
  }
  if(!isPlayer(player)) {
    return;
  }
  if(player util::is_bot()) {
    return;
  }
  if(!player is_challenge_active()) {
    return;
  }
  player report_consumable();
}

function challenge_round_ended(data) {
  if(!isDefined(data)) {
    return;
  }
  player = data.player;
  if(!isDefined(player)) {
    return;
  }
  if(!isPlayer(player)) {
    return;
  }
  if(player util::is_bot()) {
    return;
  }
  if(!player is_challenge_active()) {
    return;
  }
  player report_consumable();
}

function track_blackjack_consumable() {
  level endon("game_ended");
  self notify("track_blackjack_consumable_singleton");
  self endon("track_blackjack_consumable_singleton");
  self endon("disconnect");
  player = self;
  if(!isDefined(player.last_blackjack_consumable_time)) {
    player.last_blackjack_consumable_time = 0;
  }
  while(isDefined(player)) {
    random_wait_time = getdvarfloat("mp_blackjack_consumable_wait", 20) + (randomfloatrange(-5, 5));
    wait(random_wait_time);
    player report_consumable();
  }
}

function report_consumable() {
  player = self;
  if(!isDefined(player)) {
    return;
  }
  if(!isDefined(player.timeplayed) || !isDefined(player.timeplayed["total"])) {
    return;
  }
  current_time_played = player.timeplayed["total"];
  time_to_report = current_time_played - player.last_blackjack_consumable_time;
  if(time_to_report > 0) {
    max_time_to_report = player consumableget("blackjack", "awarded") - player consumableget("blackjack", "consumed");
    consumable_increment = int(min(time_to_report, max_time_to_report));
    if(consumable_increment > 0) {
      player consumableincrement("blackjack", "consumed", consumable_increment);
    }
  }
  player.last_blackjack_consumable_time = current_time_played;
}
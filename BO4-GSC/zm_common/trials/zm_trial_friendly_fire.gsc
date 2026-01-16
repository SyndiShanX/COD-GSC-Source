/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_friendly_fire.gsc
*******************************************************/

#include scripts\core_common\aat_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\bots\bot;
#include scripts\core_common\bots\bot_action;
#include scripts\core_common\bots\bot_util;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_hero_weapon;
#include scripts\zm_common\zm_laststand;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_pack_a_punch_util;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_player;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace zm_trial_friendly_fire;

autoexec __init__system__() {
  system::register(#"zm_trial_friendly_fire", &__init__, &__main__, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"friendly_fire", &on_begin, &on_end);
}

__main__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  register_bot_weapons();
}

register_bot_weapons() {
  bot_action::register_bulletweapon(#"ar_accurate_t8_upgraded");
  bot_action::register_bulletweapon(#"ar_fastfire_t8_upgraded");
  bot_action::register_bulletweapon(#"ar_stealth_t8_upgraded");
  bot_action::register_bulletweapon(#"ar_modular_t8_upgraded");
  bot_action::register_bulletweapon(#"smg_capacity_t8_upgraded");
  bot_action::register_bulletweapon(#"tr_powersemi_t8_upgraded");
}

private on_begin(var_9e0a2a85 = 1) {
  level endon(#"hash_7646638df88a3656");

  if(ishash(var_9e0a2a85)) {
    var_9e0a2a85 = zm_trial::function_5769f26a(var_9e0a2a85);
  }

  level.var_3c2226ce = zm_custom::function_901b751c(#"zmfriendlyfiretype");
  zm_custom::function_928be07c(var_9e0a2a85);
  callback::on_player_damage(&on_player_damage);
  level.var_edae191d = 1;
  var_6a94fd5e = 4 - getplayers().size;
  var_be33ceec = #"allies";
  level notify(#"hash_d3e36871aa6829f");

  for(i = 0; i < var_6a94fd5e; i++) {
    do {
      bot = bot::add_bot(var_be33ceec);
    }
    while(!isDefined(bot));

    bot.var_247fdf5 = 1;
    wait 1;

    if(bot util::is_spectating()) {
      bot zm_player::spectator_respawn_player();
    }
  }

  foreach(player in getplayers()) {
    if(isbot(player)) {
      player thread function_e2c5e34c();
      player thread function_6aa8dd73();
    }
  }

  level.var_cd0fc105 = level.zm_bots_scale;
  level.zm_bots_scale = 0;
  zm::register_actor_damage_callback(&function_c4e6367a);
}

private on_end(round_reset) {
  zm_custom::function_928be07c(level.var_3c2226ce);
  level.var_3c2226ce = undefined;
  callback::remove_on_player_damage(&on_player_damage);
  level.var_edae191d = undefined;

  foreach(player in getplayers()) {
    if(isbot(player)) {
      player val::reset("zm_trial_friendly_fire", "ignoreall");
      player val::reset("zm_trial_friendly_fire", "ignoreme");
    }

    if(isDefined(player.var_247fdf5) && player.var_247fdf5) {
      bot::remove_bot(player);
    }
  }

  level thread bot::populate_bots();

  if(isinarray(level.actor_damage_callbacks, &function_c4e6367a)) {
    arrayremovevalue(level.actor_damage_callbacks, &function_c4e6367a, 0);
  }

  level.zm_bots_scale = level.var_cd0fc105;
  level.var_cd0fc105 = undefined;
}

private on_player_damage(params) {
  if(isplayer(params.eattacker) && !isbot(params.eattacker) && params.idamage >= self.health && params.eattacker != self) {
    zm_trial::fail(#"hash_6e2a00b7d2d6e510", array(params.eattacker));
    return;
  }

  if(isbot(self) && isDefined(params.einflictor) && isplayer(params.einflictor.activated_by_player) && !isbot(params.einflictor.activated_by_player) && params.idamage >= self.health) {
    zm_trial::fail(#"hash_6e2a00b7d2d6e510", array(params.einflictor.activated_by_player));
    return;
  }
}

private function_e2c5e34c() {
  self endon(#"disconnect");
  level endon(#"hash_7646638df88a3656");

  while(true) {
    self val::reset("zm_trial_friendly_fire", "ignoreme");
    wait randomintrange(3, 5);

    if(function_e1378d07()) {
      self val::set("zm_trial_friendly_fire", "ignoreme", 1);
    }

    wait randomintrange(5, 10);
  }
}

private function_e1378d07() {
  foreach(player in getplayers()) {
    if(isalive(player) && !isbot(player) && !player laststand::player_is_in_laststand()) {
      return true;
    }
  }

  return false;
}

private function_c4e6367a(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(isplayer(attacker) && isbot(attacker) && level.round_number <= 20) {
    damage = int(damage * 0.5);
  }

  return damage;
}

function_6aa8dd73() {
  self endon(#"disconnect");

  if(self laststand::player_is_in_laststand() || !isalive(self) || self util::is_spectating()) {
    self waittill(#"player_revived", #"spawned");
  }

  if(level.round_number >= 20) {
    self zm_hero_weapon::function_1bb7f7b1(3);
    var_98cb6e9 = array::randomize(array(#"ar_accurate_t8_upgraded", #"ar_fastfire_t8_upgraded", #"ar_stealth_t8_upgraded", #"ar_modular_t8_upgraded", #"smg_capacity_t8_upgraded", #"tr_powersemi_t8_upgraded"));
    n_repacks = 4;
    self zm_perks::function_cc24f525();
  } else if(level.round_number >= 10) {
    self zm_hero_weapon::function_1bb7f7b1(2);
    var_98cb6e9 = array::randomize(array(#"ar_accurate_t8_upgraded", #"ar_fastfire_t8_upgraded", #"ar_stealth_t8_upgraded", #"ar_modular_t8_upgraded", #"smg_capacity_t8_upgraded", #"tr_powersemi_t8_upgraded"));
    n_repacks = 2;
  } else {
    self zm_hero_weapon::function_1bb7f7b1(1);
    var_98cb6e9 = array::randomize(array(#"ar_accurate_t8", #"ar_fastfire_t8", #"ar_stealth_t8", #"ar_modular_t8", #"smg_capacity_t8", #"tr_powersemi_t8"));
  }

  foreach(w_primary in self getweaponslistprimaries()) {
    self takeweapon(w_primary);
  }

  for(i = 0; i < zm_utility::get_player_weapon_limit(self); i++) {
    weapon = getweapon(var_98cb6e9[i]);
    weapon = self zm_weapons::give_build_kit_weapon(weapon);

    if(isDefined(level.aat_in_use) && level.aat_in_use && zm_weapons::weapon_supports_aat(weapon) && isDefined(n_repacks)) {
      self thread aat::acquire(weapon);
      self zm_pap_util::repack_weapon(weapon, n_repacks);
    }
  }

  self switchtoweapon(weapon);
}
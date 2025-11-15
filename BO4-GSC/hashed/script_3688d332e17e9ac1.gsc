/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_3688d332e17e9ac1.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;

#namespace namespace_ae2d0839;

autoexec __init__system__() {
  system::register(#"hash_7c9607fd2f57a1c7", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"hash_4043192ca121b4d4", &on_begin, &on_end);
}

private on_begin(var_59803fa8) {
  callback::on_ai_damage(&on_ai_damage);
  level.var_3c453815 = zm_trial::function_5769f26a(var_59803fa8);

  foreach(player in getplayers()) {
    player zm_trial_util::function_8677ce00(1);
    player.b_hit = 0;
    player callback::on_weapon_fired(&on_weapon_fired);

    foreach(var_5a1e3e5b in level.hero_weapon) {
      foreach(w_hero in var_5a1e3e5b) {
        player lockweapon(w_hero, 1, 1);
      }
    }

    player zm_trial_util::function_9bf8e274();

    foreach(w_equip in level.zombie_weapons) {
      if(zm_loadout::is_melee_weapon(w_equip.weapon) || zm_loadout::is_lethal_grenade(w_equip.weapon)) {
        player lockweapon(w_equip.weapon, 1, 1);
      }
    }

    player zm_trial_util::function_dc9ab223(1, 1);
  }

  callback::function_33f0ddd3(&function_33f0ddd3);
  level zm_trial::function_44200d07(1);
  level zm_trial::function_cd75b690(1);
}

private on_end(round_reset) {
  callback::remove_on_ai_damage(&on_ai_damage);
  callback::function_824d206(&function_33f0ddd3);
  level.var_3c453815 = undefined;

  foreach(player in getplayers()) {
    player.var_9979ffd6 = undefined;
    player.b_hit = undefined;
    player callback::remove_on_weapon_fired(&on_weapon_fired);

    foreach(var_5a1e3e5b in level.hero_weapon) {
      foreach(w_hero in var_5a1e3e5b) {
        player unlockweapon(w_hero);
      }
    }

    player zm_trial_util::function_73ff0096();

    foreach(w_equip in level.zombie_weapons) {
      if(zm_loadout::is_melee_weapon(w_equip.weapon) || zm_loadout::is_lethal_grenade(w_equip.weapon)) {
        player unlockweapon(w_equip.weapon);
      }
    }

    player zm_trial_util::function_dc9ab223(0, 1);
    player zm_trial_util::function_8677ce00(0);
  }

  level zm_trial::function_44200d07(0);
  level zm_trial::function_cd75b690(0);
}

private on_ai_damage(params) {
  if(isplayer(params.eattacker) && params.weapon != level.weaponbasemelee && (isDefined(params.weapon.isbulletweapon) && params.weapon.isbulletweapon || isDefined(params.weapon.isprojectileweapon) && params.weapon.isprojectileweapon || isDefined(params.weapon.isburstfire) && params.weapon.isburstfire)) {
    params.eattacker.b_hit = 1;
  }
}

private on_weapon_fired(params) {
  if(!isDefined(params.weapon)) {
    return;
  }

  if(isDefined(params.weapon.isprojectileweapon) && params.weapon.isprojectileweapon) {
    return;
  }

  if(params.weapon.firetype === "Auto Burst" || params.weapon.firetype === "Burst" || params.weapon.firetype === "Full Auto") {
    self notify(#"hash_593afdd4317784a0");
  }

  self endon(#"disconnect", #"hash_593afdd4317784a0");
  level endon(#"hash_7646638df88a3656");

  if(!isDefined(self.var_9979ffd6)) {
    self.var_9979ffd6 = 0.2;
  }

  while(self isfiring() && self.var_9979ffd6 > 0) {
    waitframe(1);
    self.var_9979ffd6 -= float(function_60d95f53()) / 1000;
  }

  self function_b33ed7bd();
}

function_b33ed7bd() {
  if(isDefined(level.var_3c453815) && isDefined(self) && isDefined(self.b_hit) && !self.b_hit) {
    self dodamage(level.var_3c453815, self.origin);
  }

  self.b_hit = 0;
  self.var_9979ffd6 = 0.2;
}

is_active() {
  challenge = zm_trial::function_a36e8c38(#"hash_4043192ca121b4d4");
  return isDefined(challenge);
}

private function_33f0ddd3(s_event) {
  if(s_event.event === "give_weapon") {
    if(!self isweaponlocked(s_event.weapon)) {
      self lockweapon(s_event.weapon, 0, 1);
    }

    if(zm_loadout::is_melee_weapon(s_event.weapon) || zm_loadout::is_lethal_grenade(s_event.weapon)) {
      self lockweapon(s_event.weapon, 1, 1);
    }
  }
}

event_handler[missile_fire] function_f8ea644(eventstruct) {
  if(is_active() && isDefined(eventstruct.projectile)) {
    s_waitresult = eventstruct.projectile waittilltimeout(2, #"death", #"explode", #"projectile_impact_explode", #"stationary", #"grenade_stuck");
    self function_b33ed7bd();
  }
}
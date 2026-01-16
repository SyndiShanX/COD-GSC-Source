/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\decoy_grenade.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\globallogic\globallogic_score;
#include scripts\core_common\killcam_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\weapons_shared;
#include scripts\weapons\weaponobjects;

#namespace decoygrenade;

autoexec __init__system__() {
  system::register(#"decoygrenade", &init_shared, undefined, undefined);
}

init_shared() {
  weaponobjects::function_e6400478(#"eq_decoy_grenade", &function_41625261, 1);
  clientfield::register("missile", "decoy_grenade_footsteps", 1, 1, "int");
}

function_41625261(watcher) {
  watcher.onspawn = &on_spawn;
  watcher.ondamage = &on_damage;
}

on_spawn(watcher) {
  self endon(#"death");
  grenade = self;
  grenade thread play_footsteps();
  grenade.var_f64cb8d = function_a5871d04(grenade);
  grenade waittill(#"stationary");
  grenade setCanDamage(1);
  grenade.maxhealth = 10000;
  grenade.health = grenade.maxhealth;
  grenade setmaxhealth(grenade.maxhealth);
  grenade notify(#"hash_5a09ded231e405ad");
  grenade clientfield::set("decoy_grenade_footsteps", 0);
  grenade function_e9d18b65();
}

play_footsteps() {
  self endon(#"death", #"hash_5a09ded231e405ad");
  wait 0.25;

  while(true) {
    self playSound(#"fly_step_sprint_plr_default");
    wait 0.23;
  }
}

function_e9d18b65() {
  self endon(#"death");
  grenade = self;
  wait 0.2;
  weapon = getweapon(grenade.var_f64cb8d.weapon);
  var_fa7f044f = 0;

  while(true) {
    burst_time = randomfloatrange(grenade.var_f64cb8d.var_5cae5968, grenade.var_f64cb8d.var_bbed619f);
    burst_time *= 1000;
    var_f370a5d5 = gettime() + burst_time;

    while(gettime() <= var_f370a5d5) {
      grenade playSound(#"wpn_ar_standard_fire_plr");
      var_fa7f044f += 1;

      if(var_fa7f044f >= weapon.clipsize) {
        var_fa7f044f = 0;
        grenade function_7c24c60f(weapon.reloadtime);
        continue;
      }

      wait weapon.firetime;
    }

    if(var_fa7f044f >= weapon.clipsize) {
      var_fa7f044f = 0;
      grenade function_7c24c60f(weapon.reloadtime);
      continue;
    }

    burst_delay = randomfloatrange(grenade.var_f64cb8d.var_c8670194, grenade.var_f64cb8d.var_ebc63eca);
    wait burst_delay;
  }
}

function_7c24c60f(reloadtime) {
  self endon(#"death");
  time_ratio = reloadtime / 3;
  wait time_ratio;
  self playSound(#"hash_337f5ae3f1674ad3");
  wait time_ratio;
  self playSound(#"hash_7a315f233edf3cba");
  wait time_ratio;
}

function_a5871d04(grenade) {
  var_f64cb8d = spawnStruct();
  var_f64cb8d.weapon = #"ar_standard_t8";
  var_f64cb8d.var_5cae5968 = 0.25;
  var_f64cb8d.var_bbed619f = 1;
  var_f64cb8d.var_c8670194 = 0.25;
  var_f64cb8d.var_ebc63eca = 1;
  return var_f64cb8d;
}

on_damage(watcher) {
  self endon(#"death");
  damagemax = 50;
  self.damagetaken = 0;

  while(true) {
    waitresult = self waittill(#"damage");
    damage = waitresult.amount;
    type = waitresult.mod;
    weapon = waitresult.weapon;

    if(!isDefined(self.damagetaken)) {
      self.damagetaken = 0;
    }

    attacker = self[[level.figure_out_attacker]](waitresult.attacker);
    damage = weapons::function_74bbb3fa(damage, weapon, self.weapon);

    if(type == "MOD_MELEE" || type == "MOD_MELEE_WEAPON_BUTT" || weapon.isemp || weapon.destroysequipment) {
      self.damagetaken = damagemax;
    } else {
      self.damagetaken += damage;
    }

    if(self.damagetaken >= damagemax) {
      self detonate();
      return;
    }
  }
}
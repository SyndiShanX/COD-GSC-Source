/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\collapse_grenade.gsc
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

#namespace collapsegrenade;

autoexec __init__system__() {
  system::register(#"collapsegrenade", &init_shared, undefined, undefined);
}

init_shared() {
  weaponobjects::function_e6400478(#"eq_collapse_grenade", &function_41625261, 1);
  clientfield::register("scriptmover", "collapsesphereflag", 1, 1, "int");
  clientfield::register("toplayer", "playerincollapsegrenade", 1, 1, "int");
}

function_41625261(watcher) {
  watcher.onspawn = &function_5df80e43;
  watcher.ondamage = &on_damage;
}

function_5df80e43(watcher, player) {
  self endon(#"death");
  grenade = self;
  grenade waittill(#"stationary");
  grenade setCanDamage(1);
  grenade.maxhealth = 10000;
  grenade.health = grenade.maxhealth;
  grenade setmaxhealth(grenade.maxhealth);
  var_5ff47c38 = spawn("script_model", grenade.origin);
  var_5ff47c38 setModel(#"p8_big_sphere");
  var_5ff47c38 setscale(0.0225);
  var_5ff47c38 linkto(grenade);
  var_5ff47c38 clientfield::set("collapsesphereflag", 1);
  grenade thread function_adc9aab9(var_5ff47c38);
  var_80994c8c = 225 * 225;
  grenade_weapon = getweapon(#"eq_collapse_grenade");
  var_f4d9a132 = gettime() + 1000;

  while(true) {
    time = gettime();
    a_players = getplayers();

    foreach(player in a_players) {
      eye_pos = player gettagorigin("tag_eye");

      if(!(isDefined(player.outsidedeathcircle) && player.outsidedeathcircle) && distancesquared(eye_pos, grenade.origin) <= var_80994c8c) {
        if(!isDefined(player.var_fd6d6c7b) || player.var_fd6d6c7b != var_5ff47c38) {
          player clientfield::set_to_player("playerincollapsegrenade", 1);
        }

        player.var_fd6d6c7b = var_5ff47c38;

        if(time >= var_f4d9a132) {
          player dodamage(5, grenade.origin, grenade.owner, grenade, undefined, "MOD_DEATH_CIRCLE", 0, grenade_weapon);
        }

        continue;
      }

      if(isDefined(player.var_fd6d6c7b) && player.var_fd6d6c7b == var_5ff47c38) {
        player.var_fd6d6c7b = undefined;
        player clientfield::set_to_player("playerincollapsegrenade", 0);
      }
    }

    if(time >= var_f4d9a132) {
      var_f4d9a132 = gettime() + 1000;
    }

    waitframe(1);
  }
}

function_adc9aab9(var_5ff47c38) {
  self waittill(#"explode", #"death");
  a_players = getplayers();

  foreach(player in a_players) {
    if(isDefined(player.var_fd6d6c7b) && player.var_fd6d6c7b == var_5ff47c38) {
      player.var_fd6d6c7b = undefined;
      player clientfield::set_to_player("playerincollapsegrenade", 0);
    }
  }

  var_5ff47c38 delete();
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
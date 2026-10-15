/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\mp\explosive_bolt.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\weapons\weapons;

#namespace explosive_bolt;

autoexec __init__system__() {
  system::register(#"explosive_bolt", &__init__, undefined, undefined);
}

__init__() {
  callback::on_spawned(&on_player_spawned);
}

on_player_spawned() {
  self thread begin_other_grenade_tracking();
}

begin_other_grenade_tracking() {
  self endon(#"death");
  self endon(#"disconnect");
  self notify(#"bolttrackingstart");
  self endon(#"bolttrackingstart");
  weapon_bolt = getweapon(#"explosive_bolt");

  for(;;) {
    waitresult = self waittill(#"grenade_fire");
    grenade = waitresult.projectile;
    weapon = waitresult.weapon;

    if(grenade util::ishacked()) {
      continue;
    }

    if(weapon == weapon_bolt) {
      grenade.ownerweaponatlaunch = self.currentweapon;
      grenade.owneradsatlaunch = self playerads() == 1 ? 1 : 0;
      grenade thread weapons::check_stuck_to_player(1, 0, weapon);
    }
  }
}
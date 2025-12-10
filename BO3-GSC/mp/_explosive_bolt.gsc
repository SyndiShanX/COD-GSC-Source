/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_explosive_bolt.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_weapons;
#namespace explosive_bolt;

function autoexec __init__sytem__() {
  system::register("explosive_bolt", &__init__, undefined, undefined);
}

function __init__() {
  callback::on_spawned(&on_player_spawned);
}

function on_player_spawned() {
  self thread begin_other_grenade_tracking();
}

function begin_other_grenade_tracking() {
  self endon("death");
  self endon("disconnect");
  self notify("bolttrackingstart");
  self endon("bolttrackingstart");
  weapon_bolt = getweapon("explosive_bolt");
  for(;;) {
    self waittill("grenade_fire", grenade, weapon, cooktime);
    if(grenade util::ishacked()) {
      continue;
    }
    if(weapon == weapon_bolt) {
      grenade.ownerweaponatlaunch = self.currentweapon;
      grenade.owneradsatlaunch = (self playerads() == 1 ? 1 : 0);
      grenade thread watch_bolt_detonation(self);
      grenade thread weapons::check_stuck_to_player(1, 0, weapon);
    }
  }
}

function watch_bolt_detonation(owner) {}
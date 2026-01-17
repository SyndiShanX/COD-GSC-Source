/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_thundergun.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_weapons;
#namespace zm_weap_thundergun;

function autoexec __init__sytem__() {
  system::register("zm_weap_thundergun", &__init__, &__main__, undefined);
}

function __init__() {
  level.weaponzmthundergun = getweapon("thundergun");
  level.weaponzmthundergunupgraded = getweapon("thundergun_upgraded");
}

function __main__() {
  callback::on_localplayer_spawned(&localplayer_spawned);
}

function localplayer_spawned(localclientnum) {
  self thread watch_for_thunderguns(localclientnum);
}

function watch_for_thunderguns(localclientnum) {
  self endon("disconnect");
  self notify("watch_for_thunderguns");
  self endon("watch_for_thunderguns");
  while(isDefined(self)) {
    self waittill("weapon_change", w_new_weapon, w_old_weapon);
    if(w_new_weapon == level.weaponzmthundergun || w_new_weapon == level.weaponzmthundergunupgraded) {
      self thread thundergun_fx_power_cell(localclientnum, w_new_weapon);
    }
  }
}

function thundergun_fx_power_cell(localclientnum, w_weapon) {
  self endon("disconnect");
  self endon("weapon_change");
  self endon("entityshutdown");
  n_old_ammo = -1;
  n_shader_val = 0;
  while(true) {
    wait(0.1);
    if(!isDefined(self)) {
      return;
    }
    n_ammo = getweaponammoclip(localclientnum, w_weapon);
    if(n_old_ammo > 0 && n_old_ammo != n_ammo) {
      thundergun_fx_fire(localclientnum);
    }
    n_old_ammo = n_ammo;
    if(n_ammo == 0) {
      self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 0, 0, 0);
    } else {
      n_shader_val = 4 - n_ammo;
      self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 1, n_shader_val, 0);
    }
  }
}

function thundergun_fx_fire(localclientnum) {
  playSound(localclientnum, "wpn_thunder_breath", (0, 0, 0));
}
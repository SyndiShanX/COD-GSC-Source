/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_staff_common.csc
*************************************************/

#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace zm_weap_staff;

function autoexec __init__sytem__() {
  system::register("zm_weap_staff", &__init__, undefined, undefined);
}

function __init__() {
  level.var_27b5be99 = [];
  callback::on_localplayer_spawned(&function_d10163c2);
}

function function_4be5e665(w_weapon, fx) {
  level.var_27b5be99[w_weapon] = fx;
}

function function_d10163c2(localclientnum) {
  self notify("hash_d10163c2");
  self endon("hash_d10163c2");
  self endon("entityshutdown");
  while(isDefined(self)) {
    self waittill("weapon_change", w_weapon);
    self notify("hash_d4c51f0");
    self function_d4c51f0(localclientnum);
    if(isDefined(level.var_27b5be99[w_weapon])) {
      self thread function_2b18ce1b(localclientnum, level.var_27b5be99[w_weapon]);
    }
  }
}

function function_2b18ce1b(localclientnum, fx) {
  self endon("hash_d4c51f0");
  while(isDefined(self)) {
    charge = getweaponchargelevel(localclientnum);
    if(charge > 0) {
      if(!isDefined(self.var_2a76e26)) {
        self.var_2a76e26 = playviewmodelfx(localclientnum, fx, "tag_fx_upg_1");
      }
    } else {
      function_d4c51f0(localclientnum);
    }
    wait(0.15);
  }
}

function function_d4c51f0(localclientnum) {
  if(isDefined(self.var_2a76e26)) {
    stopfx(localclientnum, self.var_2a76e26);
    self.var_2a76e26 = undefined;
  }
}
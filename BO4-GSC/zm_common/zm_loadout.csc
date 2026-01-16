/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_loadout.csc
***********************************************/

#include scripts\core_common\aat_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\util;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_equipment;
#include scripts\zm_common\zm_magicbox;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace zm_loadout;

autoexec __init__system__() {
  system::register(#"zm_loadout", &__init__, undefined, undefined);
}

__init__() {

  if(!isdemoplaying()) {
    callback::on_localplayer_spawned(&on_localplayer_spawned);
  }

}

on_localplayer_spawned(localclientnum) {
  self.class_num = 0;

  if(isplayer(self)) {
    self.class_num = function_cc90c352(localclientnum);
  }

  self.loadout = [];
  var_cd6fae8c = self get_loadout_item(localclientnum, "primarygrenade");
  self.loadout[#"lethal"] = getunlockableiteminfofromindex(var_cd6fae8c, 1);
  var_9aeb4447 = self get_loadout_item(localclientnum, "primary");
  self.loadout[#"primary"] = getunlockableiteminfofromindex(var_9aeb4447, 1);
  self.loadout[#"perks"] = [];

  for(i = 1; i <= 4; i++) {
    var_96861ec8 = self get_loadout_item(localclientnum, "specialty" + i);
    self.loadout[#"perks"][i] = getunlockableiteminfofromindex(var_96861ec8, 3);
  }

  self.loadout[#"hero"] = self function_439b009a(localclientnum, "herogadget");
}

function_622d8349(localclientnum) {
  level endon(#"demo_jump");

  while(!self registerrabbitshouldreset(localclientnum)) {
    waitframe(1);
  }
}

get_loadout_item(localclientnum, slot) {
  if(!isplayer(self)) {
    return undefined;
  }

  if(!isDefined(self.class_num)) {
    self.class_num = function_cc90c352(localclientnum);
  }

  if(!isDefined(self.class_num)) {
    self.class_num = 0;
  }

  return self getloadoutitem(localclientnum, self.class_num, slot);
}

function_439b009a(localclientnum, slot) {
  if(!isplayer(self)) {
    return undefined;
  }

  if(!isDefined(self.class_num)) {
    self.class_num = function_cc90c352(localclientnum);
  }

  if(!isDefined(self.class_num)) {
    self.class_num = 0;
  }

  return self getloadoutweapon(localclientnum, self.class_num, slot);
}
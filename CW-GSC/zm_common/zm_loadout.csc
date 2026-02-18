/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_loadout.csc
***********************************************/

#using scripts\core_common\aat_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#namespace zm_loadout;

function private autoexec __init__system__() {
  system::register(#"zm_loadout", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!isdemoplaying()) {
    callback::on_localplayer_spawned(&on_localplayer_spawned);
  }
}

function on_localplayer_spawned(localclientnum) {
  self.class_num = 0;

  if(isPlayer(self)) {
    self.class_num = function_cc90c352(localclientnum);
  }

  self.loadout = [];
  var_cd6fae8c = self get_loadout_item(localclientnum, "primarygrenade");
  self.loadout[# "lethal"] = getunlockableiteminfofromindex(var_cd6fae8c, 1);
  var_9aeb4447 = self get_loadout_item(localclientnum, "primary");
  self.loadout[# "primary"] = getunlockableiteminfofromindex(var_9aeb4447, 1);
  self.loadout[# "perks"] = [];

  for(i = 1; i <= 4; i++) {
    var_96861ec8 = self get_loadout_item(localclientnum, "specialty" + i);
    self.loadout[# "perks"][i] = getunlockableiteminfofromindex(var_96861ec8, 3);
  }

  self.loadout[# "hero"] = self function_439b009a(localclientnum, "herogadget");
}

function function_622d8349(localclientnum) {
  level endon(#"demo_jump");

  while(!function_908617f2(localclientnum)) {
    waitframe(1);
  }
}

function get_loadout_item(localclientnum, slot) {
  if(!isPlayer(self)) {
    return undefined;
  }

  if(!isDefined(self.class_num)) {
    self.class_num = function_cc90c352(localclientnum);
  }

  if(!isDefined(self.class_num)) {
    self.class_num = 0;
  }

  return getloadoutitem(localclientnum, self.class_num, slot);
}

function function_439b009a(localclientnum, slot) {
  if(!isPlayer(self)) {
    return undefined;
  }

  if(!isDefined(self.class_num)) {
    self.class_num = function_cc90c352(localclientnum);
  }

  if(!isDefined(self.class_num)) {
    self.class_num = 0;
  }

  return getloadoutweapon(localclientnum, self.class_num, slot);
}
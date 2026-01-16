/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\trapd.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace trapd;

autoexec __init__system__() {
  system::register(#"trapd", &__init__, undefined, undefined);
}

__init__() {
  callback::add_weapon_type(#"mine_trapd", &function_9f6d38cf);
  callback::add_weapon_type(#"claymore_trapd", &function_9f6d38cf);
}

function_9f6d38cf(localclientnum) {
  self thread fx_think(localclientnum);
}

fx_think(localclientnum) {
  self notify(#"light_disable");
  self endon(#"light_disable");
  self endon(#"death");
  self util::waittill_dobj(localclientnum);

  for(;;) {
    self stop_light_fx(localclientnum);
    localplayer = function_5c10bd79(localclientnum);
    self start_light_fx(localclientnum);
    util::server_wait(localclientnum, 0.3, 0.01, "player_switch");
    self util::waittill_dobj(localclientnum);
  }
}

start_light_fx(localclientnum) {
  self.fx = util::playFXOnTag(localclientnum, level._effect[#"grenade_light"], self, "tag_fx");
}

stop_light_fx(localclientnum) {
  if(isDefined(self.fx) && self.fx != 0) {
    stopfx(localclientnum, self.fx);
    self.fx = undefined;
  }
}
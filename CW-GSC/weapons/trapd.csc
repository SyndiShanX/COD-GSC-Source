/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\trapd.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace trapd;

function private autoexec __init__system__() {
  system::register(#"trapd", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::add_weapon_type(#"mine_trapd", &function_9f6d38cf);
  callback::add_weapon_type(#"claymore_trapd", &function_9f6d38cf);
}

function function_9f6d38cf(localclientnum) {
  self thread fx_think(localclientnum);
}

function fx_think(localclientnum) {
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

function start_light_fx(localclientnum) {
  self.fx = util::playFXOnTag(localclientnum, "weapon/fx8_equip_light_os", self, "tag_fx");
}

function stop_light_fx(localclientnum) {
  if(isDefined(self.fx) && self.fx != 0) {
    stopfx(localclientnum, self.fx);
    self.fx = undefined;
  }
}
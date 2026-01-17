/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_equip_gasmask.csc
*************************************************/

#using scripts\shared\clientfield_shared;
#using scripts\shared\filter_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_zm_equipment;
#namespace zm_equip_gasmask;

function autoexec __init__sytem__() {
  system::register("zm_equip_gasmask", &__init__, undefined, undefined);
}

function __init__() {
  zm_equipment::include("equip_gasmask");
  clientfield::register("toplayer", "gasmaskoverlay", 21000, 1, "int", &gasmask_overlay_handler, 0, 0);
  clientfield::register("clientuimodel", "hudItems.showDpadDown_PES", 21000, 1, "int", undefined, 0, 0);
  visionset_mgr::register_overlay_info_style_postfx_bundle("zm_gasmask_postfx", 21000, 32, "pstfx_moon_helmet", 3);
}

function gasmask_overlay_handler(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(!self islocalplayer() || isspectating(localclientnum, 0) || (isDefined(level.localplayers[localclientnum]) && self getentitynumber() != level.localplayers[localclientnum] getentitynumber())) {
    return;
  }
  if(newval) {
    if(!isDefined(self.var_cf129735)) {
      self.var_cf129735 = self playLoopSound("evt_gasmask_loop", 0.5);
    }
  } else if(isDefined(self.var_cf129735)) {
    self stoploopsound(self.var_cf129735, 0.5);
    self.var_cf129735 = undefined;
  }
}
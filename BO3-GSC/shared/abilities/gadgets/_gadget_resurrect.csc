/**********************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\abilities\gadgets\_gadget_resurrect.csc
**********************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_power;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\postfx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\visionset_mgr_shared;
#namespace _gadget_resurrect;

function autoexec __init__sytem__() {
  system::register("gadget_resurrect", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("allplayers", "resurrecting", 1, 1, "int", & player_resurrect_changed, 0, 1);
  clientfield::register("toplayer", "resurrect_state", 1, 2, "int", & player_resurrect_state_changed, 0, 1);
  duplicate_render::set_dr_filter_offscreen("resurrecting", 99, "resurrecting", undefined, 2, "mc/hud_keyline_resurrect", 0);
  visionset_mgr::register_visionset_info("resurrect", 1, 16, undefined, "mp_ability_resurrection");
  visionset_mgr::register_visionset_info("resurrect_up", 1, 16, undefined, "mp_ability_wakeup");
}

function player_resurrect_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self duplicate_render::update_dr_flag(localclientnum, "resurrecting", newval);
}

function resurrect_down_fx(localclientnum) {
  self endon("entityshutdown");
  self endon("finish_rejack");
  self thread postfx::playpostfxbundle("pstfx_resurrection_close");
  wait(0.5);
  self thread postfx::playpostfxbundle("pstfx_resurrection_pus");
}

function resurrect_up_fx(localclientnum) {
  self endon("entityshutdown");
  self notify("finish_rejack");
  self thread postfx::playpostfxbundle("pstfx_resurrection_open");
}

function player_resurrect_state_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self thread resurrect_down_fx(localclientnum);
  } else {
    if(newval == 2) {
      self thread resurrect_up_fx(localclientnum);
    } else {
      self thread postfx::stoppostfxbundle();
    }
  }
}
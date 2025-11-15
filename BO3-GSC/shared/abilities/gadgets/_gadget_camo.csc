/*****************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\abilities\gadgets\_gadget_camo.csc
*****************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_power;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\abilities\gadgets\_gadget_camo_render;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\filter_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace _gadget_camo;

function autoexec __init__sytem__() {
  system::register("gadget_camo", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("allplayers", "camo_shader", 1, 3, "int", & ent_camo_material_callback, 0, 1);
}

function ent_camo_material_callback(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(oldval == newval && oldval == 0 && !bwastimejump) {
    return;
  }
  flags_changed = self duplicate_render::set_dr_flag_not_array("gadget_camo_friend", util::friend_not_foe(local_client_num, 1));
  flags_changed = flags_changed | self duplicate_render::set_dr_flag_not_array("gadget_camo_flicker", newval == 2);
  flags_changed = flags_changed | self duplicate_render::set_dr_flag_not_array("gadget_camo_break", newval == 3);
  flags_changed = flags_changed | self duplicate_render::set_dr_flag_not_array("gadget_camo_reveal", newval != oldval);
  flags_changed = flags_changed | self duplicate_render::set_dr_flag_not_array("gadget_camo_on", newval != 0);
  flags_changed = flags_changed | self duplicate_render::set_dr_flag_not_array("hide_model", newval == 0);
  flags_changed = flags_changed | bnewent;
  if(flags_changed) {
    self duplicate_render::update_dr_filters(local_client_num);
  }
  self notify("endtest");
  if(newval && (bwastimejump || bnewent)) {
    self thread gadget_camo_render::forceon(local_client_num);
  } else if(newval != oldval) {
    self thread gadget_camo_render::doreveal(local_client_num, newval != 0);
  }
  if(newval && !oldval || (newval && (bwastimejump || bnewent))) {
    self gadgetpulseresetreveal();
  }
}
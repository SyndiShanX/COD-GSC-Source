/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\zombies\_zm_ai_screecher.csc
*************************************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\zombies\_zm_utility;
#include clientscripts\mp\_visionset_mgr;

init() {
  clientscripts\mp\_visionset_mgr::vsmgr_register_overlay_info_style_blur("zm_ai_screecher_blur", 1, 1, 0.1, 0.25, 4);
  registerclientfield("actor", "render_third_person", 1, 1, "int", ::screecher_render_clientfield_cb, 0);
}

screecher_render_clientfield_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval)
    self setrenderinthirdpersonspectate(1);
  else
    self setrenderinthirdpersonspectate(0);
}
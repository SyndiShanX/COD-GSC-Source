/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\ct_nomad.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\mp_common\gametypes\ct_core;
#include scripts\mp_common\gametypes\ct_nomad_tutorial;

#namespace ct_nomad;

event_handler[gametype_init] main(eventstruct) {
  ct_core::function_46e95cc7();
  ct_core::function_fa03fc55();
  clientfield::register("actor", "warlord_radar_enable", 1, 1, "int", &function_81669a8b, 1, 0);
  ct_nomad_tutorial::init();
}

function_81669a8b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level endon(#"demo_jump");
  self endon(#"death");

  if(newval) {
    self enableonradar();
    return;
  }

  self disableonradar();
}
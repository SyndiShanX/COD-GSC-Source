/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_amerika.gsc
***********************************************/

#using scripts\core_common\compass;
#using scripts\core_common\load_shared;
#using scripts\core_common\scene_shared;
#namespace mp_amerika;

function event_handler[level_init] main(eventstruct) {
  load::main();
  compass::setupminimap("");
  scene::function_497689f6(#"t9_cin_mp_amerika_apc", "apc", "tag_probe_attach", "prb_tn_us_apc_arv_int", "Shot 020");
}
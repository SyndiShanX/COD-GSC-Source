/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_mall.gsc
***********************************************/

#using scripts\core_common\compass;
#using scripts\core_common\load_shared;
#using scripts\core_common\scene_shared;
#using scripts\killstreaks\killstreaks_shared;
#namespace mp_mall;

function event_handler[level_init] main(eventstruct) {
  killstreaks::function_257a5f13("straferun", 40);
  killstreaks::function_257a5f13("helicopter_comlink", 75);
  scene::function_497689f6(#"cin_mp_mall_apc_intro", "apc", "tag_probe_attach", "prb_tn_us_apc_arv_int");
  scene::function_497689f6(#"cin_mp_mall_heli_intro", "helicopter", "tag_probe_attach", "prb_tn_mil_rus_heli_trans");
  load::main();
  compass::setupminimap("");
}
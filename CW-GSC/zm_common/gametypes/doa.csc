/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\gametypes\doa.csc
***********************************************/

#using script_1b2f6ef7778cf920;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace doa;

function event_handler[gametype_init] main(eventstruct) {
  level.default_mapping = "zombietron";
  level thread namespace_4dae815d::init();
  level.var_f18a6bd6 = &function_f18a6bd6;
  waittillframeend();
  level.var_f18a6bd6 = &function_f18a6bd6;
  util::waitforclient(0);
}

function function_f18a6bd6() {
  system::function_c11b0642();
  level flag::set(#"load_main_complete");
}
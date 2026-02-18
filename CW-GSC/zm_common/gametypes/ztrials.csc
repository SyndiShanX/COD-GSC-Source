/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\gametypes\ztrials.csc
***********************************************/

#using script_1793e0dffb81a6c8;
#using script_45657e86e8f90414;
#using script_5afd8ff8f8304cc4;
#using script_70ab01a7690ea256;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\zm_common\trials\zm_trial_disable_buys;
#using scripts\zm_common\trials\zm_trial_disable_hud;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#namespace ztrials;

function event_handler[gametype_init] main(eventstruct) {
  level._zombie_gamemodeprecache = &onprecachegametype;
  level._zombie_gamemodemain = &onstartgametype;
  level flag::init(#"ztrial", 1);
  println("<dev string:x38>");
}

function onprecachegametype() {
  println("<dev string:x56>");
}

function onstartgametype() {
  println("<dev string:x78>");
}

function private event_handler[event_b72c1844] function_df05c5d(eventstruct) {
  if(namespace_fcd611c3::is_active() && self namespace_fcd611c3::function_26f124d8()) {
    return;
  }

  self thread zm_trial_util::function_97444b02(eventstruct.localclientnum);
}
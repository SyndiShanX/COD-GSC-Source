/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\gametypes\ztrials.csc
***********************************************/

#include scripts\zm_common\trials\zm_trial_pack_a_punch_sacrifice;
#include scripts\zm_common\trials\zm_trial_attack_during_movement;
#include scripts\zm_common\trials\zm_trial_kill_enemies_for_health;
#include script_70ab01a7690ea256;
#include scripts\core_common\flag_shared;
#include scripts\core_common\struct;
#include scripts\zm_common\trials\zm_trial_disable_buys;
#include scripts\zm_common\trials\zm_trial_disable_hud;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;
#namespace ztrials;

event_handler[gametype_init] main(eventstruct) {
  level._zombie_gamemodeprecache = &onprecachegametype;
  level._zombie_gamemodemain = &onstartgametype;
  level flag::init(#"ztrial", 1);
  println("<dev string:x38>");
}

onprecachegametype() {
  println("<dev string:x55>");
}

onstartgametype() {
  println("<dev string:x76>");
}

event_handler[event_b72c1844] function_df05c5d(eventstruct) {
  if(zm_trial_attack_during_movement::is_active() && self zm_trial_attack_during_movement::function_26f124d8()) {
    return;
  }

  self thread zm_trial_util::function_97444b02(eventstruct.localclientnum);
}
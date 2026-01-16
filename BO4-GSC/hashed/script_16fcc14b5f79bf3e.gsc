/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_16fcc14b5f79bf3e.gsc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\system_shared;
#include scripts\zm\zm_red_main_quest;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_ui_inventory;

#namespace namespace_efec71f7;

autoexec __init__system__() {
  system::register(#"hash_3db89e7dfe4633b0", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"hash_285312733a97eea3", &on_begin, &on_end);
}

private on_begin() {
  level zm_ui_inventory::function_7df6bb60(#"zm_red_objective_progress", 5);

  if(!(isDefined(level.var_4e4909a6) && level.var_4e4909a6)) {
    level thread function_57755268();
  }
}

private on_end(round_reset) {
  if(!round_reset) {
    if(!(isDefined(level.var_84199d1) && level.var_84199d1)) {
      zm_trial::fail(undefined, getplayers());
    }
  }

  level.var_84199d1 = undefined;
}

function_57755268() {
  level endon(#"end_game");
  level.var_4e4909a6 = 1;
  zm_red_main_quest::play_think();
  zm_red_main_quest::play_cleanup(0, 0);
  level.var_84199d1 = 1;
  level.var_4e4909a6 = undefined;
  level endon(#"hash_7646638df88a3656");
  wait 5;
  level notify(#"kill_round_wait");
}
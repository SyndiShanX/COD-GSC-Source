/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_4f1abd7be75f8a2f.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;
#include scripts\zm_common\zm_weapons;

#namespace namespace_aa42e727;

autoexec __init__system__() {
  system::register(#"kills_with_flinger", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"kills_with_flinger", &on_begin, &on_end);
}

private on_begin(var_8a72a00b, var_49d8a02c, var_325ff213, var_dd2fad64) {
  switch (getplayers().size) {
    case 1:
      level.var_b07feb9b = zm_trial::function_5769f26a(var_8a72a00b);
      break;
    case 2:
      level.var_b07feb9b = zm_trial::function_5769f26a(var_49d8a02c);
      break;
    case 3:
      level.var_b07feb9b = zm_trial::function_5769f26a(var_325ff213);
      break;
    case 4:
      level.var_b07feb9b = zm_trial::function_5769f26a(var_dd2fad64);
      break;
  }

  level.var_61541a89 = 0;
  level thread function_c80f40af();
  level zm_trial_util::function_2976fa44(level.var_b07feb9b);
  level zm_trial_util::function_dace284(level.var_61541a89);
}

private on_end(round_reset) {
  if(!round_reset) {
    if(level.var_61541a89 < level.var_b07feb9b) {
      zm_trial::fail(#"hash_73f632514ab7d15", getplayers());
    }
  }

  foreach(player in getplayers()) {
    player zm_trial_util::function_f3aacffb();
  }

  level.var_b07feb9b = undefined;
  level.var_61541a89 = undefined;
}

private function_c80f40af() {
  level endon(#"hash_7646638df88a3656");

  while(level.var_61541a89 < level.var_b07feb9b) {
    s_result = level waittill(#"hash_1ba786f1661e3817");
    level.var_61541a89 += s_result.var_2ef2374;

    if(level.var_61541a89 < level.var_b07feb9b) {
      level zm_trial_util::function_2976fa44(level.var_b07feb9b);
      level zm_trial_util::function_dace284(level.var_61541a89);
    }

    if(level.var_61541a89 >= level.var_b07feb9b) {
      level zm_trial_util::function_7d32b7d0(1);
    }
  }
}
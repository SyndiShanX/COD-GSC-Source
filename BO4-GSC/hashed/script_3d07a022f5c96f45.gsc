/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_3d07a022f5c96f45.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;
#include scripts\zm_common\zm_weapons;

#namespace namespace_94d4f09f;

autoexec __init__system__() {
  system::register(#"hash_671231fa368e1829", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"hash_671231fa368e1829", &on_begin, &on_end);
}

private on_begin(var_8a72a00b, var_49d8a02c, var_325ff213, var_dd2fad64) {
  switch (getplayers().size) {
    case 1:
      level.var_cad0c0ee = zm_trial::function_5769f26a(var_8a72a00b);
      break;
    case 2:
      level.var_cad0c0ee = zm_trial::function_5769f26a(var_49d8a02c);
      break;
    case 3:
      level.var_cad0c0ee = zm_trial::function_5769f26a(var_325ff213);
      break;
    case 4:
      level.var_cad0c0ee = zm_trial::function_5769f26a(var_dd2fad64);
      break;
  }

  level.var_fb4c4cca = 0;
  callback::on_ai_killed(&on_ai_killed);
  level zm_trial_util::function_2976fa44(level.var_cad0c0ee);
  level zm_trial_util::function_dace284(level.var_fb4c4cca);
}

private on_end(round_reset) {
  callback::remove_on_ai_killed(&on_ai_killed);

  if(!round_reset) {
    if(level.var_fb4c4cca < level.var_cad0c0ee) {
      zm_trial::fail(#"hash_73f632514ab7d15", getplayers());
    }
  }

  foreach(player in getplayers()) {
    player zm_trial_util::function_f3aacffb();
  }

  level.var_cad0c0ee = undefined;
  level.var_fb4c4cca = undefined;
}

private on_ai_killed(params) {
  if(self.var_bf8dfaf4 === 1) {
    level.var_fb4c4cca++;

    if(level.var_fb4c4cca < level.var_cad0c0ee) {
      level zm_trial_util::function_2976fa44(level.var_cad0c0ee);
      level zm_trial_util::function_dace284(level.var_fb4c4cca);
    }

    if(level.var_fb4c4cca == level.var_cad0c0ee) {
      level zm_trial_util::function_7d32b7d0(1);
    }
  }
}

is_active(var_a75461b4) {
  s_challenge = zm_trial::function_a36e8c38(#"hash_53a5a75770adb550");

  if(isDefined(var_a75461b4)) {
    if(isDefined(s_challenge) && isarray(level.var_692c062e) && isinarray(level.var_692c062e, var_a75461b4)) {
      return true;
    }

    return false;
  }

  return isDefined(s_challenge);
}
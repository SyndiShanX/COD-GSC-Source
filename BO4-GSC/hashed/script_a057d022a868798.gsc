/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_a057d022a868798.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;

#namespace namespace_d30b9d9b;

autoexec __init__system__() {
  system::register(#"hash_2dccaaff9ebe6851", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"hash_3a3072e83c70889c", &on_begin, &on_end);
}

private on_begin(var_ff22cb62) {
  self.var_ff22cb62 = zm_trial::function_5769f26a(var_ff22cb62);
  self.var_6a7521e3 = 0;
  self thread function_53627246();
}

private on_end(round_reset) {
  zm_trial_util::function_f3dbeda7();

  foreach(s_portal in level.a_s_portals) {
    s_portal.var_5b12474a = undefined;
  }

  if(isDefined(level.s_cage_portal)) {
    level.s_cage_portal.var_5b12474a = undefined;
  }

  if(!round_reset) {
    if(self.var_6a7521e3 < self.var_ff22cb62) {
      zm_trial::fail(#"hash_6a1df2dbfb66a948");
    }
  }
}

private function_53627246() {
  level endon(#"hash_7646638df88a3656", #"end_game");
  zm_trial_util::function_2976fa44(self.var_ff22cb62);
  zm_trial_util::function_dace284(self.var_6a7521e3);

  while(true) {
    s_waitresult = level waittill(#"portal_used");

    if(!(isDefined(s_waitresult.s_portal.var_5b12474a) && s_waitresult.s_portal.var_5b12474a)) {
      s_waitresult.s_portal.var_5b12474a = 1;
      self.var_6a7521e3++;
      zm_trial_util::function_dace284(self.var_6a7521e3);
    }

    if(self.var_6a7521e3 == self.var_ff22cb62) {
      zm_trial_util::function_7d32b7d0(1);
      break;
    }
  }
}
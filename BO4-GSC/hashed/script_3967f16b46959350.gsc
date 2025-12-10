/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_3967f16b46959350.gsc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#namespace namespace_54f635e5;

autoexec __init__system__() {
  system::register(#"hash_2dccaaff9ebe6851", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }
  zm_trial::register_challenge(#"hash_3a3072e83c70889c", &on_begin, &on_end);
}

private on_begin(var_bebb3c71) {
  var_3c2bd367 = [];
  var_3c2bd367 = getEntArray("portal_trigs", "targetname");
  assert(isDefined(var_3c2bd367));
  self.var_bebb3c71 = zm_trial::function_9b72fb1a(var_bebb3c71);
  self.var_c8c1d8a = 0;
  zm_trial_util::function_368f31a9(self.var_bebb3c71);
  zm_trial_util::function_ef967e48(self.var_c8c1d8a);
  foreach(trigger in var_3c2bd367) {
    trigger thread function_3d5a999(self);
  }
  level thread function_64ff75e1(self);
}

private on_end(round_reset) {
  zm_trial_util::function_59861180();
  if(!round_reset) {
    if(self.var_c8c1d8a < self.var_bebb3c71) {
      zm_trial::fail(#"hash_6a1df2dbfb66a948");
    }
  }
}

private function_3d5a999(challenge) {
  level endon(#"hash_7646638df88a3656");
  self endon(#"hash_16f606e42bb85f6e");
  while(true) {
    waitresult = self waittill(#"trigger");
    user = waitresult.activator;
    player_used = 0;
    if(isDefined(self.portal_used)) {
      for(i = 0; i < self.portal_used.size; i++) {
        if(self.portal_used[i] == user) {
          player_used = 1;
        }
      }
    }
    if(player_used == 1) {
      continue;
    }
    challenge.var_c8c1d8a++;
    challenge notify(#"hash_799d83064eef9bf0");
    self notify(#"hash_16f606e42bb85f6e");
  }
}

private function_64ff75e1(challenge) {
  level endon(#"hash_7646638df88a3656");
  while(challenge.var_c8c1d8a < challenge.var_bebb3c71) {
    challenge waittill(#"hash_799d83064eef9bf0");
    zm_trial_util::function_ef967e48(challenge.var_c8c1d8a);
  }
}
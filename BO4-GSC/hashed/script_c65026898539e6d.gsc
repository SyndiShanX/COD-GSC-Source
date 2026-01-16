/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_c65026898539e6d.gsc
***********************************************/

#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;

#namespace namespace_35baff41;

autoexec __init__system__() {
  system::register(#"hash_62ed3e0f56513ba7", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"hash_2c07cbb8e8fd2060", &on_begin, &on_end);
}

private on_begin(var_6ad4e7c6) {
  fasttravel_triggers = struct::get_array("fasttravel_trigger", "targetname");
  assert(isDefined(fasttravel_triggers));
  zm_trial_util::function_2976fa44(fasttravel_triggers.size);
  zm_trial_util::function_dace284(0);
  level thread function_25f146be();
}

private on_end(round_reset) {
  zm_trial_util::function_f3dbeda7();

  if(!round_reset) {
    fasttravel_triggers = struct::get_array("fasttravel_trigger", "targetname");
    assert(isDefined(fasttravel_triggers));

    if(function_c83a4a77() < fasttravel_triggers.size) {
      zm_trial::fail(#"hash_6d65e724625758f1");
    }
  }
}

private function_c83a4a77() {
  fasttravel_triggers = struct::get_array("fasttravel_trigger", "targetname");
  assert(isDefined(fasttravel_triggers));
  count = 0;

  foreach(trigger in fasttravel_triggers) {
    if(isDefined(trigger.unitrigger_stub.used) && trigger.unitrigger_stub.used) {
      count++;
    }
  }

  return count;
}

private function_25f146be() {
  self endon(#"disconnect");
  level endon(#"hash_7646638df88a3656");

  while(true) {
    zm_trial_util::function_dace284(function_c83a4a77());
    waitframe(1);
  }
}
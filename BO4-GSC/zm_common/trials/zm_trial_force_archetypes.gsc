/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_force_archetypes.gsc
**********************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_trial;

#namespace zm_trial_force_archetypes;

autoexec __init__system__() {
  system::register(#"zm_trial_force_archetypes", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"force_archetypes", &on_begin, &on_end);
}

private on_begin(var_34259a50, var_1d00ec07, var_10cad39b, var_f9ab255c) {
  archetypes = array::remove_undefined(array(var_34259a50, var_1d00ec07, var_10cad39b, var_f9ab255c), 0);
  self.var_c54c0d81 = [];

  foreach(archetype in archetypes) {
    self.var_c54c0d81[archetype] = 1;
  }
}

private on_end(round_reset) {
  self.var_c54c0d81 = undefined;
}

function_ff2a74e7(archetype) {
  challenge = zm_trial::function_a36e8c38(#"force_archetypes");

  if(!isDefined(challenge)) {
    return false;
  }

  return isDefined(challenge.var_c54c0d81[archetype]);
}
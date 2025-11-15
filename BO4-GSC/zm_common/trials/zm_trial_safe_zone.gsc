/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_safe_zone.gsc
***************************************************/

#include scripts\core_common\laststand_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_trial;

#namespace zm_trial_safe_zone;

autoexec __init__system__() {
  system::register(#"zm_trial_safe_zone", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"safe_zone", &on_begin, &on_end);
}

private on_begin(var_e84d35d1, var_16e6b8ea) {
  var_e9433d0 = struct::get_array(var_e84d35d1);
  assert(var_e9433d0.size, "<dev string:x38>");
  var_64e17761 = [];

  foreach(var_93154b10 in var_e9433d0) {
    assert(isDefined(var_93154b10.target), "<dev string:x67>");
    var_94d5ccbc = getEntArray(var_93154b10.target, "targetname");
    var_64e17761 = arraycombine(var_64e17761, var_94d5ccbc, 0, 0);
  }

  var_16e6b8ea = zm_trial::function_5769f26a(var_16e6b8ea);

  foreach(player in getplayers()) {
    player thread function_68b149a2(var_64e17761, var_16e6b8ea);
  }
}

private on_end(round_reset) {}

function_68b149a2(var_64e17761, var_16e6b8ea) {
  level endon(#"hash_7646638df88a3656");
  self endon(#"disconnect");
  wait 12;

  while(true) {
    var_4cda8676 = 0;

    foreach(var_c1f5749f in var_64e17761) {
      if(self istouching(var_c1f5749f)) {
        var_4cda8676 = 1;
        break;
      }
    }

    if(!var_4cda8676 && isalive(self) && !self laststand::player_is_in_laststand()) {
      self dodamage(var_16e6b8ea, self.origin);
      wait 1;
    }

    waitframe(1);
  }
}
/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_no_player_damage.gsc
**********************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_trial;

#namespace zm_trial_no_player_damage;

autoexec __init__system__() {
  system::register(#"zm_trial_no_player_damage", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"no_player_damage", &on_begin, &on_end);
}

private on_begin() {
  foreach(player in getplayers()) {
    player callback::on_player_damage(&on_player_damage);
  }
}

private on_end(round_reset) {
  foreach(player in getplayers()) {
    player callback::remove_on_player_damage(&on_player_damage);
  }
}

private on_player_damage(params) {
  if((isai(params.eattacker) || isai(params.einflictor)) && (params.idamage > 0 || isDefined(self.armor) && self.armor > 0)) {
    var_57807cdc = [];
    array::add(var_57807cdc, self, 0);
    zm_trial::fail(#"hash_41122a695bc6065d", var_57807cdc);
  }
}
/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_damage_drains_points.gsc
**************************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_trial;

#namespace zm_trial_damage_drains_points;

autoexec __init__system__() {
  system::register(#"zm_trial_damage_drains_points", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"damage_drains_points", &on_begin, &on_end);
}

private on_begin(var_66fe7443, var_ec90b685) {
  if(isDefined(var_ec90b685)) {
    self.var_ec90b685 = 1;
    callback::on_ai_killed(&function_8e0401ab);
    level.var_a58dc99e = zm_trial::function_5769f26a(var_66fe7443);
    return;
  }

  var_620e7dea = zm_trial::function_5769f26a(var_66fe7443) / 100;
  level.var_baf7ae7f = level.var_a2d8b7eb;
  level.var_a2d8b7eb = var_620e7dea;
}

private on_end(round_reset) {
  if(isDefined(self.var_ec90b685) && self.var_ec90b685) {
    callback::remove_on_ai_killed(&function_8e0401ab);
    level.var_a58dc99e = undefined;
    self.var_ec90b685 = undefined;
    return;
  }

  level.var_a2d8b7eb = level.var_baf7ae7f;
  level.var_baf7ae7f = undefined;
}

is_active(var_a32bbdd = 0) {
  s_challenge = zm_trial::function_a36e8c38(#"damage_drains_points");

  if(var_a32bbdd) {
    if(isDefined(s_challenge) && isDefined(s_challenge.var_ec90b685) && s_challenge.var_ec90b685) {
      return true;
    }

    return false;
  }

  return isDefined(s_challenge);
}

private function_8e0401ab(params) {
  if(isDefined(self.nuked) && self.nuked) {
    a_players = util::get_active_players();
    var_fc97ca4d = array::random(a_players);

    if(isplayer(var_fc97ca4d)) {
      var_fc97ca4d zm_score::minus_to_player_score(level.var_a58dc99e, 1);
    }

    return;
  }

  if(isplayer(params.eattacker)) {
    params.eattacker zm_score::minus_to_player_score(level.var_a58dc99e, 1);
  }
}
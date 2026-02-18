/*******************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_special_enemy.gsc
*******************************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_utility;
#namespace zm_trial_special_enemy;

function private autoexec __init__system__() {
  system::register(#"zm_trial_special_enemy", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"special_enemy", &on_begin, &on_end);
}

function private on_begin(enemy_type, var_6b96eb7b, var_46cce0c5, var_6ad4e7c6, var_44445188) {
  if(getplayers().size > 1) {
    self.enemy_count = zm_trial::function_5769f26a(var_46cce0c5);
  } else {
    self.enemy_count = zm_trial::function_5769f26a(var_6b96eb7b);
  }

  level.var_9a0fbcb9 = 0;
  self.enemy_type = enemy_type;
  self.enemies_killed = 0;
  level.zombie_total = self.enemy_count;
  level.var_efbb07e = level.var_ef1a71b3;
  level.var_ef1a71b3 = &get_zombie_count_for_round;
  level.var_dc22f98 = level.fn_custom_round_ai_spawn;
  level.fn_custom_round_ai_spawn = &spawn_enemy;
  level.var_692420f3 = level.var_ab84adee;
  level.var_ab84adee = 1;
  level.var_44445188 = var_44445188;
  callback::on_ai_killed(&on_ai_killed);

  if(isDefined(var_6ad4e7c6)) {
    level.var_d0be33a6 = 1;
    zm_trial_util::function_2976fa44(self.enemy_count);
    zm_trial_util::function_dace284(self.enemies_killed);
  }
}

function private on_end(round_reset) {
  level.var_9a0fbcb9 = undefined;
  level.var_44445188 = undefined;
  level.var_d0be33a6 = undefined;
  level.var_ef1a71b3 = level.var_efbb07e;
  level.fn_custom_round_ai_spawn = level.var_dc22f98;
  level.var_ab84adee = level.var_692420f3;
  zm_trial_util::function_f3dbeda7();
  callback::remove_on_ai_killed(&on_ai_killed);
}

function private on_ai_killed(params) {
  challenge = zm_trial::function_a36e8c38(#"special_enemy");
  assert(isDefined(challenge), "<dev string:x38>");

  if(challenge.enemy_type !== self.archetype) {
    return;
  }

  if(is_true(self.var_e700d5e2)) {
    return;
  }

  if(level.var_44445188 === # "no_headshots" && isPlayer(params.eattacker) && zm_utility::is_headshot(params.weapon, params.shitloc, params.smeansofdeath)) {
    zm_trial::fail(#"hash_11e532a4f9c3e482", array(params.eattacker));
    return;
  }

  challenge.enemies_killed++;

  if(is_true(level.var_d0be33a6)) {
    zm_trial_util::function_dace284(challenge.enemies_killed);
  }
}

function private get_zombie_count_for_round(round_number, player_count) {
  return level.zombie_total;
}

function private spawn_enemy() {
  var_f63f3454 = zm_trial::function_a36e8c38(#"defend_area");

  if(isDefined(var_f63f3454)) {
    var_47ab7d31 = function_a1ef346b().size;
    var_f55dd0ac = 0;

    foreach(player in function_a1ef346b()) {
      if(is_true(player.var_4cb0b91f)) {
        var_f55dd0ac++;
      }
    }

    if(var_f55dd0ac < var_47ab7d31) {
      return true;
    }
  }

  challenge = zm_trial::function_a36e8c38(#"special_enemy");
  assert(isDefined(challenge));

  assert(isDefined(level.var_1cc18005));
  assert(isDefined(level.var_1cc18005[challenge.enemy_type]), "<dev string:x5b>" + function_9e72a96(challenge.enemy_type));

  spawn_callback = level.var_1cc18005[challenge.enemy_type];
  spawn_success = [[spawn_callback]]();

  if(is_true(spawn_success)) {
    level.zombie_total--;
  }

  return true;
}

function function_95c1dd81(name, spawn_callback) {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  if(!isDefined(level.var_1cc18005)) {
    level.var_1cc18005 = [];
  }

  assert(!isDefined(level.var_1cc18005[name]), "<dev string:x90>" + name);
  level.var_1cc18005[name] = spawn_callback;
}

function is_active() {
  challenge = zm_trial::function_a36e8c38(#"special_enemy");
  return isDefined(challenge);
}
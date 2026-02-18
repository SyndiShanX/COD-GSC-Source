/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\match_record.gsc
***********************************************/

#using scripts\core_common\array_shared;
#namespace match_record;

function function_d92cb558(result, vararg) {
  pathstr = "<dev string:x38>";

  if(isDefined(vararg)) {}

  return pathstr;
}

function get_stat(...) {
  assert(vararg.size > 0);

  if(vararg.size == 0) {
    return undefined;
  }

  result = readmatchstat(vararg);

  function_d92cb558(result, vararg);

  return result;
}

function set_stat(...) {
  assert(vararg.size > 1);

  if(vararg.size <= 1) {
    return;
  }

  value = vararg[vararg.size - 1];
  arrayremoveindex(vararg, vararg.size - 1);
  result = writematchstat(vararg, value);

  function_d92cb558(result, vararg);

  return result;
}

function function_7a93acec(...) {
  vec = vararg[vararg.size - 1];
  arrayremoveindex(vararg, vararg.size - 1);
  vec_0 = set_stat(vararg, 0, int(vec[0]));
  vec_1 = set_stat(vararg, 1, int(vec[1]));
  vec_2 = set_stat(vararg, 2, int(vec[2]));
  return is_true(vec_0) && is_true(vec_1) && is_true(vec_2);
}

function inc_stat(...) {
  assert(vararg.size > 1);

  if(vararg.size <= 1) {
    return;
  }

  value = vararg[vararg.size - 1];
  arrayremoveindex(vararg, vararg.size - 1);
  result = incrementmatchstat(vararg, value);

  function_d92cb558(result, vararg);

  return result;
}

function get_player_index() {
  player = self;
  assert(isPlayer(player));

  if(isPlayer(player) && isDefined(player.clientid)) {
    return player.clientid;
  }
}

function get_player_stat(...) {
  player = self;
  assert(isPlayer(player));

  if(isPlayer(player)) {
    return get_stat(#"players", player.clientid, vararg);
  }
}

function set_player_stat(...) {
  player = self;
  assert(isPlayer(player));

  if(isPlayer(player)) {
    value = vararg[vararg.size - 1];
    arrayremoveindex(vararg, vararg.size - 1);
    return set_stat(#"players", player.clientid, vararg, value);
  }
}

function function_ded5f5b6(...) {
  player = self;
  assert(isPlayer(player));

  if(isPlayer(player)) {
    vec = vararg[vararg.size - 1];
    arrayremoveindex(vararg, vararg.size - 1);
    vec_0 = set_player_stat(vararg, 0, int(vec[0]));
    vec_1 = set_player_stat(vararg, 1, int(vec[1]));
    vec_2 = set_player_stat(vararg, 2, int(vec[2]));
    return (is_true(vec_0) && is_true(vec_1) && is_true(vec_2));
  }
}

function function_34800eec(...) {
  player = self;
  assert(isPlayer(player));

  if(isPlayer(player)) {
    value = vararg[vararg.size - 1];
    arrayremoveindex(vararg, vararg.size - 1);
    return inc_stat(#"players", player.clientid, vararg, value);
  }
}
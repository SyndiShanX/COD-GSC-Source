/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\match_record.gsc
***********************************************/

#include scripts\core_common\array_shared;

#namespace match_record;

function_d92cb558(result, vararg) {
  pathstr = "<dev string:x38>";

  if(isDefined(result)) {}

  return pathstr;
}

get_stat(...) {
  assert(vararg.size > 0);

  if(vararg.size == 0) {
    return undefined;
  }

  result = readmatchstat(vararg);

  function_d92cb558(result, vararg);

  return result;
}

set_stat(...) {
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

function_7a93acec(...) {
  vec = vararg[vararg.size - 1];
  arrayremoveindex(vararg, vararg.size - 1);
  vec_0 = set_stat(vararg, 0, int(vec[0]));
  vec_1 = set_stat(vararg, 1, int(vec[1]));
  vec_2 = set_stat(vararg, 2, int(vec[2]));
  return isDefined(vec_0) && vec_0 && isDefined(vec_1) && vec_1 && isDefined(vec_2) && vec_2;
}

inc_stat(...) {
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

get_player_index() {
  player = self;
  assert(isplayer(player));

  if(isplayer(player) && isDefined(player.clientid)) {
    return player.clientid;
  }
}

get_player_stat(...) {
  player = self;
  assert(isplayer(player));

  if(isplayer(player)) {
    return get_stat(#"players", player.clientid, vararg);
  }
}

set_player_stat(...) {
  player = self;
  assert(isplayer(player));

  if(isplayer(player)) {
    value = vararg[vararg.size - 1];
    arrayremoveindex(vararg, vararg.size - 1);
    return set_stat(#"players", player.clientid, vararg, value);
  }
}

function_ded5f5b6(...) {
  player = self;
  assert(isplayer(player));

  if(isplayer(player)) {
    vec = vararg[vararg.size - 1];
    arrayremoveindex(vararg, vararg.size - 1);
    vec_0 = set_player_stat(vararg, 0, int(vec[0]));
    vec_1 = set_player_stat(vararg, 1, int(vec[1]));
    vec_2 = set_player_stat(vararg, 2, int(vec[2]));
    return (isDefined(vec_0) && vec_0 && isDefined(vec_1) && vec_1 && isDefined(vec_2) && vec_2);
  }
}

function_34800eec(...) {
  player = self;
  assert(isplayer(player));

  if(isplayer(player)) {
    value = vararg[vararg.size - 1];
    arrayremoveindex(vararg, vararg.size - 1);
    return inc_stat(#"players", player.clientid, vararg, value);
  }
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\utility\game_utility_mp.gsc
***********************************************/

game_utility_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_88220D9C76FAE3CE55CB5868A78CC2", "_encstr_B4B3167656E88AA5DACAA65ACDC656E8166B95A6A32CC947", ::game_utility_mp_gettimesincegamestart);
}

game_utility_mp_gettimesincegamestart() {
  return scripts\mp\matchdata::gettimefrommatchstart(gettime());
}

_id_11C7F() {
  switch (scripts\mp\utility\game::getgametype()) {
    case "_encstr_AAE507E8423F63C163":
      return 0;
    case "_encstr_9707038CB6":
      if(istrue(level.aonrules))
        return 0;
      else
        return 1;
    default:
      return 1;
  }
}

_id_11C80() {
  switch (scripts\mp\utility\game::getgametype()) {
    case "_encstr_831904E79F07":
    case "_encstr_AAE507E8423F63C163":
      return 0;
    case "_encstr_9707038CB6":
      if(istrue(level.aonrules))
        return 0;
      else
        return 1;
    case "_encstr_A9B606B0C956B916":
      if(istrue(level.allowsupers))
        return 0;
      else
        return 1;
    default:
      return 1;
  }
}

_id_11C8A(var_0) {
  if(isDefined(var_0.script_team)) {
    if(scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B")
      return 1;
    else
      return 0;
  }

  return 1;
}

track_get_reward_time(var_0, var_1) {
  if(!isDefined(level.br_level))
    return 1;

  var_2 = removeselfrevivetoken(var_1);
  var_3 = min(var_2[0][0], var_2[1][0]);
  var_4 = min(var_2[0][1], var_2[1][1]);
  var_5 = max(var_2[0][0], var_2[1][0]);
  var_6 = max(var_2[0][1], var_2[1][1]);

  if(var_0[0] <= var_3)
    return 0;
  else if(var_0[0] >= var_5)
    return 0;

  if(var_0[1] <= var_4)
    return 0;
  else if(var_0[1] >= var_6)
    return 0;

  return 1;
}

removeselfrevivetoken(var_0) {
  var_1 = level.br_level.br_mapbounds;
  var_2 = isDefined(level.br_level.delay_set_bomber_traversals);
  var_3 = istrue(var_0);

  if(var_2 && var_3)
    var_1 = level.br_level.delay_set_bomber_traversals;

  return var_1;
}

removespawns(var_0) {
  var_1 = removeselfrevivetoken(var_0);
  var_2 = var_1[1][0];
  var_3 = var_1[0][0];
  return abs(var_2 - var_3);
}

removespawnprotectiononads(var_0) {
  var_1 = removeselfrevivetoken(var_0);
  var_2 = (var_1[0] + var_1[1]) * 0.5;
  return var_2;
}
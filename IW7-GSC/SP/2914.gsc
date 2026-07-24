/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2914.gsc
**************************************/

#using_animtree("player");

_id_96E9(var_0, var_1, var_2) {
  if(isDefined(var_0))
    precachemodel(var_0);

  if(isDefined(var_1))
    precachemodel(var_1);

  if(isDefined(var_0)) {
    level._id_EC87["player_rig"] = #animtree;
    level._id_EC8C["player_rig"] = var_0;
  }

  if(isDefined(var_1)) {
    level._id_EC87["player_legs"] = #animtree;
    level._id_EC8C["player_legs"] = var_1;
  }

  if(isDefined(var_2))
    _id_96DA(var_2);
}

_id_96EA(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    level._id_EC87["player_rig"] = #animtree;
    level._id_EC8C["player_rig"] = var_0;
  }

  if(isDefined(var_1)) {
    level._id_EC87["player_legs"] = #animtree;
    level._id_EC8C["player_legs"] = var_1;
  }

  if(isDefined(var_2))
    _id_96DA(var_2);
}

#using_animtree("generic_human");

_id_96DA(var_0) {
  level._id_EC8C["player_body"] = var_0;
  level._id_EC87["player_body"] = #animtree;
}

get_player_score(var_0) {
  if(!isDefined(level._id_D267)) {
    level._id_D267 = scripts\sp\utility::_id_10639("player_rig");
    var_0 = 1;
  }

  if(isDefined(var_0)) {
    level._id_D267.origin = level.player.origin;
    level._id_D267.angles = level.player.angles;
  }

  return level._id_D267;
}

_id_7BA2() {
  if(!isDefined(level._id_D1CE)) {
    level._id_D1CE = scripts\sp\utility::_id_10639("player_legs");
    level._id_D1CE.origin = level.player.origin;
    level._id_D1CE.angles = level.player.angles;
  }

  return level._id_D1CE;
}

_id_7B88() {
  if(!isDefined(level._id_CF98)) {
    level._id_CF98 = scripts\sp\utility::_id_10639("player_body");
    level._id_CF98.origin = level.player.origin;
    level._id_CF98.angles = level.player.angles;
  }

  return level._id_CF98;
}

_id_AD09(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0))
    var_0 = 30;

  if(!isDefined(var_1))
    var_1 = 30;

  if(!isDefined(var_2))
    var_2 = 30;

  if(!isDefined(var_3))
    var_3 = 30;

  var_4 = get_player_score();
  var_4 show();
  level.player _meth_823B(var_4, "tag_player");
  level.player playerlinktodelta(var_4, "tag_player", 1, var_0, var_1, var_2, var_3, 1);
}

_id_2B7C(var_0) {
  if(!isDefined(var_0))
    var_0 = 0.7;

  var_1 = get_player_score();
  var_1 show();
  level.player _meth_823C(var_1, "tag_player", var_0);
}
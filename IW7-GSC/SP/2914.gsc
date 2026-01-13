/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\2914.gsc
*********************************************/

func_96E9(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    precachemodel(var_0);
  }

  if(isDefined(var_1)) {
    precachemodel(var_1);
  }

  if(isDefined(var_0)) {
    level.var_EC87["player_rig"] = #animtree;
    level.var_EC8C["player_rig"] = var_0;
  }

  if(isDefined(var_1)) {
    level.var_EC87["player_legs"] = #animtree;
    level.var_EC8C["player_legs"] = var_1;
  }

  if(isDefined(var_2)) {
    func_96DA(var_2);
  }
}

func_96EA(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    level.var_EC87["player_rig"] = #animtree;
    level.var_EC8C["player_rig"] = var_0;
  }

  if(isDefined(var_1)) {
    level.var_EC87["player_legs"] = #animtree;
    level.var_EC8C["player_legs"] = var_1;
  }

  if(isDefined(var_2)) {
    func_96DA(var_2);
  }
}

func_96DA(var_0) {
  level.var_EC8C["player_body"] = var_0;
  level.var_EC87["player_body"] = #animtree;
}

get_player_score(var_0) {
  if(!isDefined(level.var_D267)) {
    level.var_D267 = scripts\sp\utility::func_10639("player_rig");
    var_0 = 1;
  }

  if(isDefined(var_0)) {
    level.var_D267.origin = level.player.origin;
    level.var_D267.angles = level.player.angles;
  }

  return level.var_D267;
}

func_7BA2() {
  if(!isDefined(level.var_D1CE)) {
    level.var_D1CE = scripts\sp\utility::func_10639("player_legs");
    level.var_D1CE.origin = level.player.origin;
    level.var_D1CE.angles = level.player.angles;
  }

  return level.var_D1CE;
}

func_7B88() {
  if(!isDefined(level.var_CF98)) {
    level.var_CF98 = scripts\sp\utility::func_10639("player_body");
    level.var_CF98.origin = level.player.origin;
    level.var_CF98.angles = level.player.angles;
  }

  return level.var_CF98;
}

func_AD09(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    var_0 = 30;
  }

  if(!isDefined(var_1)) {
    var_1 = 30;
  }

  if(!isDefined(var_2)) {
    var_2 = 30;
  }

  if(!isDefined(var_3)) {
    var_3 = 30;
  }

  var_4 = get_player_score();
  var_4 show();
  level.player playerlinktoabsolute(var_4, "tag_player");
  level.player playerlinktodelta(var_4, "tag_player", 1, var_0, var_1, var_2, var_3, 1);
}

func_2B7C(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0.7;
  }

  var_1 = get_player_score();
  var_1 show();
  level.player playerlinktoblend(var_1, "tag_player", var_0);
}
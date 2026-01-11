/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_player_rig.gsc
*****************************************************/

#using_animtree("player");

init_player_rig(var_0, var_1) {
  if(isDefined(var_0)) {
    precachemodel(var_0);
  }

  if(isDefined(var_1)) {
    precachemodel(var_1);
  }

  if(isDefined(var_0)) {
    level.scr_animtree["player_rig"] = #animtree;
    level.scr_model["player_rig"] = var_0;
  }

  if(isDefined(var_1)) {
    level.scr_animtree["player_legs"] = #animtree;
    level.scr_model["player_legs"] = var_1;
  }
}

get_player_rig() {
  if(!isDefined(level.player_rig)) {
    level.player_rig = maps\_utility::spawn_anim_model("player_rig");
    level.player_rig.origin = level.player.origin;
    level.player_rig.angles = level.player.angles;
  }

  return level.player_rig;
}

get_player_legs() {
  if(!isDefined(level.player_legs)) {
    level.player_legs = maps\_utility::spawn_anim_model("player_legs");
    level.player_legs.origin = level.player.origin;
    level.player_legs.angles = level.player.angles;
  }

  return level.player_legs;
}

link_player_to_arms(var_0, var_1, var_2, var_3) {
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

  var_4 = get_player_rig();
  var_4 show();
  level.player playerlinktoabsolute(var_4, "tag_player");
  level.player playerlinktodelta(var_4, "tag_player", 1, var_0, var_1, var_2, var_3, 1);
}

blend_player_to_arms(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0.7;
  }

  var_1 = get_player_rig();
  var_1 show();
  level.player playerlinktoblend(var_1, "tag_player", var_0);
}
/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\interactive_models\fish_bannerfish.gsc
*******************************************************/

#using_animtree("animals");

main() {
  var_0 = spawnStruct();
  var_0.animtree = #animtree;
  var_0.anims["idle"][0] = % bannerfish_idle1;
  var_0.anims["idle"][1] = % bannerfish_idle_fast;
  var_0.anims["idleweight"][0] = 4;
  var_0.anims["idleweight"][1] = 1;
  var_0.anims["flee_straight"][0] = % bannerfish_flee_straight;
  var_0.anims["flee_left"][0] = % bannerfish_flee_left;
  var_0.anims["flee_right"][0] = % bannerfish_flee_right;
  var_0.anims["flee_continue"][0] = % bannerfish_idle_fast;
  var_0.anims["turn_left"] = % bannerfish_turn_left;
  var_0.anims["turn_left_child"] = % bannerfish_turn_left_add;
  var_0.anims["turn_right"] = % bannerfish_turn_right;
  var_0.anims["turn_right_child"] = % bannerfish_turn_right_add;
  var_0.default_wander_radius = 20;
  var_0.wander_redirect_time = 2;
  var_0.people_react_distance = 36;
  var_0.gunfire_react_distance = 200;
  var_0.savetostructfn = maps\interactive_models\_fish::single_fish_savetostruct;
  var_0.loadfromstructfn = maps\interactive_models\_fish::single_fish_loadfromstruct;

  if(!isDefined(level._interactive))
    level._interactive = [];

  level._interactive["fish_bannerfish"] = var_0;
  thread maps\interactive_models\_fish::fish();
}
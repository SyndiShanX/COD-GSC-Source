/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\dog\_zombie_dog_traverse.gsc
*******************************************************/

main() {
  if(!isDefined(level.zombietraverseanims) || !isDefined(level.zombietraverseanims["dog"])) {
    initzombiedogtraverseanims();
  }

  maps\mp\agents\humanoid\_humanoid_traverse::dotraverse();
}

end_script() {
  maps\mp\agents\humanoid\_humanoid_traverse::end_script();
}

initzombiedogtraverseanims() {
  if(!isDefined(level.zombietraverseanims)) {
    level.zombietraverseanims = [];
  }

  if(!isDefined(level.zombietraverseanims["dog"])) {
    level.zombietraverseanims["dog"] = [];
  }

  level.zombietraverseanims["dog"]["jump_across_100"] = "traverse_jump_over_24";
  level.zombietraverseanims["dog"]["jump_across_196"] = "traverse_jump_over_24";
  level.zombietraverseanims["dog"]["boost_jump_across_100"] = level.zombietraverseanims["dog"]["jump_across_100"];
  level.zombietraverseanims["dog"]["boost_jump_across_196"] = level.zombietraverseanims["dog"]["jump_across_196"];
  level.zombietraverseanims["dog"]["jump_down_40"] = "traverse_jump_down_40";
  level.zombietraverseanims["dog"]["jump_down_slow"] = "traverse_jump_down_70";
  level.zombietraverseanims["dog"]["jump_down_fast"] = "traverse_jump_down_70";
  level.zombietraverseanims["dog"]["step_over_40"] = "traverse_jump_over_36";
  level.zombietraverseanims["dog"]["window_over_36"] = "traverse_jump_over_36";
  level.zombietraverseanims["dog"]["step_up_40"] = "traverse_jump_up_40";
  level.zombietraverseanims["dog"]["wall_over_40"] = "traverse_jump_over_36";
  level.zombietraverseanims["dog"]["boost_jump_up"] = "traverse_jump_up_70";
  level.zombietraverseanims["dog"]["climbup_shaft"] = "traverse_climbup_shaft";
  level.zombietraverseanims["dog"]["spawn_closet_door"] = "traverse_spawn_closet_door";
  level.zombietraverseanims["dog"]["spawn_closet_vault"] = "traverse_spawn_closet_vault";
  level.zombietraverseanims["dog"]["spawn_closet_window"] = "traverse_spawn_closet_window";
  level.zombietraverseanims["dog"]["spawn_closet_high_window"] = "traverse_jump_over_36";

  if(!isDefined(level.zombietraverseanimchance)) {
    level.zombietraverseanimchance = [];
  }

  if(!isDefined(level.zombietraverseanimchance["dog"])) {
    level.zombietraverseanimchance["dog"] = [];
  }

  level.zombietraverseanimchance["dog"]["traverse_jump_up_70"][0] = 0.7;
  level.zombietraverseanimchance["dog"]["traverse_jump_up_70"][1] = 0.3;

  foreach(var_1 in level.zombietraverseanimchance["dog"]) {
    var_2 = 0.0;

    foreach(var_4 in var_1) {
      var_2 = var_2 + var_4;
    }
  }
}
/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\stairs_util.gsc
************************************************/

#include common_scripts\utility;
#include animscripts\anims;
#include animscripts\utility;

build_traverse_data(traversedata, stair_anims, transition_stair_count_in, transition_stair_count_out, stair_aim) {
  stair_count = self get_stair_count() - transition_stair_count_in - transition_stair_count_out;

  if(stair_count < 0)
    traversedata["traverseAnimTransOut"] = undefined;
  else
    traversedata["traverseAnim"] = build_anim_array(stair_anims, stair_count);

  traversedata["traverseAnimType"] = "sequence";
  traversedata["traverseStance"] = "stand";
  traversedata["traverseAlertness"] = "casual";
  traversedata["traverseMovement"] = "run";

  if(animscripts\utility::aihasonlypistol())
    traversedata["traverseAllowAiming"] = 0;
  else
    traversedata["traverseAllowAiming"] = 1;

  traversedata["traverseAimUp"] = animarray(stair_aim + "_aim_up", "move");
  traversedata["traverseAimDown"] = animarray(stair_aim + "_aim_down", "move");
  traversedata["traverseAimLeft"] = animarray(stair_aim + "_aim_left", "move");
  traversedata["traverseAimRight"] = animarray(stair_aim + "_aim_right", "move");
  traversedata["traverseRagdollDeath"] = 1;
  return traversedata;
}

build_anim_array(stair_anims, stair_count) {
  ret_stair_anims = [];
  potential_sizes = getarraykeys(stair_anims);

  while(stair_count > 0) {
    sizes = [];

    for(i = 0; i < potential_sizes.size; i++) {
      if(potential_sizes[i] <= stair_count)
        sizes[sizes.size] = potential_sizes[i];
    }

    assert(sizes.size, "No potential animation for stair count.");
    random_size = random(sizes);

    if(random_size <= stair_count) {
      ret_stair_anims[ret_stair_anims.size] = stair_anims[random_size];
      stair_count = stair_count - random_size;
    }
  }

  return ret_stair_anims;
}

get_stair_count() {
  start_node = self getnegotiationstartnode();
  assert(isDefined(start_node.script_int), "Stair traversals must have a script_int with the number of stairs.");
  return start_node.script_int;
}
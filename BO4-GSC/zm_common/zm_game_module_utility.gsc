/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_game_module_utility.gsc
************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\struct;

#namespace zm_game_module_utility;

move_ring(ring) {
  positions = struct::get_array(ring.target, "targetname");
  positions = array::randomize(positions);
  level endon(#"end_game");

  while(true) {
    foreach(position in positions) {
      self moveto(position.origin, randomintrange(30, 45));
      self waittill(#"movedone");
    }
  }
}

rotate_ring(forward) {
  level endon(#"end_game");
  dir = -360;

  if(forward) {
    dir = 360;
  }

  while(true) {
    self rotateyaw(dir, 9);
    wait 9;
  }
}
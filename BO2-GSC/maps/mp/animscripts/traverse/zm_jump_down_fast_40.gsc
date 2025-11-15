/*****************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\animscripts\traverse\zm_jump_down_fast_40.gsc
*****************************************************************************/

#include maps\mp\animscripts\traverse\shared;
#include maps\mp\animscripts\traverse\zm_shared;

main() {
  if(self.zombie_move_speed == "sprint")
    dosimpletraverse("jump_down_fast_40");
  else
    dosimpletraverse("jump_down_40");
}
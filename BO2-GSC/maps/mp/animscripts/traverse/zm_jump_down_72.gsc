/*******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\animscripts\traverse\zm_jump_down_72.gsc
*******************************************************************/

#include maps\mp\animscripts\traverse\shared;
#include maps\mp\animscripts\traverse\zm_shared;

main() {
  if(isDefined(self.isdog) && self.isdog)
    dog_jump_down(72, 7);
  else
    dosimpletraverse("jump_down_72");
}
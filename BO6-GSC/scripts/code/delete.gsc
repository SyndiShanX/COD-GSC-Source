/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\code\delete.gsc
**************************************/

#namespace delete;

function event_handler[delete_entity] main() {
  assert(isDefined(self));
  wait 0;

  if(isent(self)) {
    self delete();
  }
}
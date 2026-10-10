/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\code\delete.gsc
***********************************************/

#namespace delete;

function main() {
  assert(isDefined(self));
  wait 0;

  if(isDefined(self)) {
    self delete();
  }
}
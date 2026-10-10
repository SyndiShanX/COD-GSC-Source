/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\code\delete.gsc
***********************************************/

#namespace delete;

function main() {
  assert(isDefined(self));
  wait 0;

  if(isDefined(self)) {
    self delete();
  }
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\code\delete.gsc
***********************************************/

function main() {
  wait 0;

  if(isDefined(self)) {
    self delete();
    return;
  }
}
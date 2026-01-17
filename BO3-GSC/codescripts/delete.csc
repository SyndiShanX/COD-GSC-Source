/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: codescripts\delete.csc
*************************************************/

#namespace delete;

function main() {
  assert(isDefined(self));
  wait(0);
  if(isDefined(self)) {
    if(isDefined(self.classname)) {
      if(self.classname == "" || self.classname == "" || self.classname == "") {
        println("");
        println((("" + self getentitynumber()) + "") + self.origin);
        println("");
      }
    }
    self delete();
  }
}
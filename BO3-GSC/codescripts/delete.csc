/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: codescripts\delete.csc
*************************************************/

#namespace delete;

function main() {
  assert(isdefined(self));
  wait(0);
  if(isdefined(self)) {
    if(isdefined(self.classname)) {
      if(self.classname == "" || self.classname == "" || self.classname == "") {
        println("");
        println((("" + self getentitynumber()) + "") + self.origin);
        println("");
      }
    }
    self delete();
  }
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\delete.csc
***********************************************/

#namespace delete;

event_handler[delete] main(eventstruct) {
  assert(isDefined(self));
  waitframe(1);

  if(isDefined(self)) {
    if(isDefined(self.classname)) {
      if(self.classname == "<dev string:x38>" || self.classname == "<dev string:x47>" || self.classname == "<dev string:x58>") {
        println("<dev string:x6b>");
        println("<dev string:x6e>" + self getentitynumber() + "<dev string:xae>" + self.origin);
        println("<dev string:x6b>");
      }
    }

    self delete();
  }
}
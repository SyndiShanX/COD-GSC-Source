/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\delete.csc
***********************************************/

#namespace delete;

function private event_handler[delete] function_55217f7b(eventstruct) {
  assert(isDefined(self));

  if(isDefined(self)) {
    if(isDefined(self.classname)) {
      if(self.classname == "<dev string:x38>" || self.classname == "<dev string:x48>" || self.classname == "<dev string:x5a>") {
        println("<dev string:x6e>");
        println("<dev string:x72>" + self getentitynumber() + "<dev string:xb3>" + self.origin);
        println("<dev string:x6e>");
      }
    }

    self delete();
  }
}

function private event_handler[event_9aed3d2d] function_f447a48e(eventstruct) {
  assert(isDefined(self));
  waitframe(1);

  if(isDefined(self)) {
    if(isDefined(self.classname)) {
      if(self.classname == "<dev string:x38>" || self.classname == "<dev string:x48>" || self.classname == "<dev string:x5a>") {
        println("<dev string:x6e>");
        println("<dev string:x72>" + self getentitynumber() + "<dev string:xb3>" + self.origin);
        println("<dev string:x6e>");
      }
    }

    self delete();
  }
}
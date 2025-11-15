/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\footsteps_shared.csc
***********************************************/

#namespace footsteps;

missing_ai_footstep_callback() {
  type = self.archetype;

  if(!isDefined(type)) {
    type = "<dev string:x38>";
  }

  println("<dev string:x42>" + type + "<dev string:x53>" + self._aitype + "<dev string:xd9>");
}

registeraitypefootstepcb(archetype, callback) {
  if(!isDefined(level._footstepcbfuncs)) {
    level._footstepcbfuncs = [];
  }

  assert(!isDefined(level._footstepcbfuncs[archetype]), "<dev string:x109>" + archetype + "<dev string:x116>");
  level._footstepcbfuncs[archetype] = callback;
}

playaifootstep(client_num, pos, surface, notetrack, bone) {
  if(!isDefined(self.archetype)) {
    println("<dev string:x145>");
    footstepdoeverything();
    return;
  }

  if(!isDefined(level._footstepcbfuncs) || !isDefined(level._footstepcbfuncs[self.archetype])) {
    self missing_ai_footstep_callback();
    footstepdoeverything();
    return;
  }

  [[level._footstepcbfuncs[self.archetype]]](client_num, pos, surface, notetrack, bone);
}
/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\footsteps_shared.csc
***********************************************/

#namespace footsteps;

function missing_ai_footstep_callback() {
  type = self.archetype;
  aitype = self._aitype;

  if(!isDefined(type)) {
    type = "<dev string:x38>";
  }

  if(!isDefined(self._aitype)) {
    aitype = "<dev string:x38>";
  }

  println("<dev string:x43>" + type + "<dev string:x55>" + aitype + "<dev string:xdc>");
}

function registeraitypefootstepcb(archetype, callback) {
  if(!isDefined(level._footstepcbfuncs)) {
    level._footstepcbfuncs = [];
  }

  assert(!isDefined(level._footstepcbfuncs[archetype]), "<dev string:x10d>" + archetype + "<dev string:x11b>");
  level._footstepcbfuncs[archetype] = callback;
}

function playaifootstep(client_num, pos, surface, notetrack, bone) {
  if(!isDefined(self.archetype)) {
    println("<dev string:x14b>");
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
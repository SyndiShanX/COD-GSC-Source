/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_59aa5051623a5341.gsc
*************************************************/

#using script_53651341190c5aab;
#using scripts\asm\asm;
#using scripts\common\cap;
#using scripts\common\string;
#namespace civ_group;

function getfunction(funcid) {
  switch (funcid) {
    case #"hash_fe0e9f8796a0acad":
      return &onuserinit;
    case #"hash_e93ace2ec1639636":
      return &onuserterminate;
    case #"hash_ec77c425122ce561":
      return &startcaprole;
    case #"hash_f803c2a7263b7274":
      return &assignrole;
    case #"hash_c97cf04d1c01da13":
      return &filterlastrole;
    case #"hash_331df3154e569c83":
      return &canleavegroup;
  }

  return namespace_f901a4f9d899be59::function_efcea5d26798e5b6(funcid);
}

function onuserinit(interactionid) {
  sid = scripts\common\string::to_string(interactionid);

  if(!isDefined(level.bseqinstancedata)) {
    level.bseqinstancedata = [];
  }

  if(!isDefined(level.bseqinstancedata[sid])) {
    level.bseqinstancedata[sid] = spawnStruct();
    level.bseqinstancedata[sid].nextrole = 0;
  }

  self.lastrole = 0;
  self.interactionrole = "undefined";
  self.var_85ecbbe4fae7c0ae = "cap_init";
  self notify("interaction_end");
}

function onuserterminate(interactionid) {
  function_25c933655d73066a(interactionid);
  self.lastrole = undefined;
  self.interactionrole = undefined;
  self.lastrole = 0;
  self._blackboard.bseqphase = undefined;
  sid = scripts\common\string::to_string(interactionid);
  level.bseqinstancedata[sid].nextrole--;
  ondeleteuser(interactionid);

  if(self.defaultasm != self.asmname) {
    scripts\common\cap::cap_exit();
  }
}

function assignrole(statename, params) {
  roles = ["Guy1", "Guy2", "Guy3", "Guy4", "Guy5", "Guy6"];
  interactionid = self getinteractionid();
  sid = scripts\common\string::to_string(interactionid);
  roleindex = level.bseqinstancedata[sid].nextrole;
  self.interactionrole = roles[roleindex];
  capinfo = undefined;

  if(isDefined(roles[roleindex + 1])) {
    capinfo = getcapinfoforrole(self, roles[roleindex + 1]);
  }

  if(!isDefined(capinfo)) {
    self.lastrole = 1;
  }

  level.bseqinstancedata[sid].nextrole++;
}

function startcaprole(statename, shouldteleport) {
  capinfo = undefined;

  if(isDefined(self.interactionrole)) {
    capinfo = getcapinfoforrole(self, self.interactionrole);
  }

  if(!isDefined(capinfo)) {
    scripts\asm\asm::asm_fireephemeralevent("exit", "end");
    self leaveinteraction();
    return;
  }

  role = [self.interactionrole];

  if(isDefined(shouldteleport[0]) || istrue(self.startinteractionimmediate)) {
    self.startinteractionimmediate = 1;
    self.customarrivalhandler = &customarrival;
  }

  startcap(statename, role);
}

function filterlastrole(param) {
  return istrue(self.lastrole);
}

function canleavegroup(asmname, statename, tostatename, params) {
  return istrue(self.canleavegroup);
}

function customarrival() {}
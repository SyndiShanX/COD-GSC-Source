/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_firing_range.csc
***********************************************/

#include scripts\core_common\struct;

#namespace wz_firing_range;

init_targets(targetname) {
  targets = getdynentarray(targetname);

  foreach(target in targets) {
    if(target init_target()) {
      target thread follow_path();
    }
  }
}

private init_target() {
  if(!isDefined(self.target)) {
    return false;
  }

  structs = [];
  totalms = 0;
  var_dc0e8c88 = struct::get(self.target, "targetname");
  struct = var_dc0e8c88;

  do {
    if(!isDefined(struct) || !isint(struct.script_int) || struct.script_int <= 0) {
      return false;
    }

    structs[structs.size] = struct;
    totalms += struct.script_int;
    struct = struct::get(struct.target, "targetname");
  }
  while(struct != var_dc0e8c88);

  assert(structs.size == 2);
  self.structs = structs;
  self.totalms = totalms;
  return true;
}

private function_5bab934a(struct, var_d1d733b4) {
  var_32c844bb = var_d1d733b4 - getservertime(0);

  if(var_32c844bb <= 0) {
    var_32c844bb = int(1 * 1000);
  }

  movetime = float(var_32c844bb) / 1000;
  return movetime;
}

private follow_path() {
  starttime = int(floor(getservertime(0) / self.totalms) * self.totalms + self.totalms);

  while(getservertime(0) < starttime) {
    waitframe(1);
  }

  endtime = starttime;

  while(true) {
    endtime += self.structs[0].script_int;
    movetime = function_5bab934a(self.structs[0], endtime);
    self function_49ed8678(self.structs[1].origin, movetime);
    wait movetime;
    playSound(0, #"amb_target_stop", self.origin);
    endtime += self.structs[1].script_int;
    movetime = function_5bab934a(self.structs[1], endtime);
    self function_49ed8678(self.structs[0].origin, movetime);
    wait movetime;
    playSound(0, #"amb_target_stop", self.origin);
  }
}
/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_433375b6cbabfc47.gsc
*************************************************/

#using script_4a8c20678bd6a83e;
#using scripts\asm\asm;
#using scripts\engine\utility;
#namespace zombie_liveragdoll;

function processliveragdoll(taskid, params) {
  if(!ent_flag("in_liveragdoll")) {
    return anim.failure;
  }

  return anim.running;
}

function liveragdoll_ai(source_pos, intensity) {
  if(!isDefined(source_pos)) {
    return;
  }

  if(is_liveragdoll()) {
    return;
  }

  if(!self asmhasstate(self.asmname, "liveragdoll_in")) {
    return;
  }

  if(getdvarint(@ "hash_dee78f8c41d19b65", 0) > 0) {
    var_4f3eec7aecbb41bf = vectorNormalize(self.origin - source_pos);
    self function_babd8af3054d8abe("head", var_4f3eec7aecbb41bf * intensity, 1, 0);
  } else {
    self startliveragdoll();
  }

  function_ac90fa5cc0a80298("liveragdoll_in");
  return 1;
}

function is_liveragdoll() {
  return ent_flag("in_liveragdoll");
}
/*************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\civilian.gsc
*************************************/

cover() {
  self endon("killanimscript");
  self clearanim( % root, 0.2);
  scripts\anim\utility::func_12EB9();
  if(scripts\anim\utility::func_9E40()) {
    var_0 = "idle_combat";
  } else {
    var_0 = "idle_noncombat";
  }

  var_1 = undefined;
  if(isDefined(self.var_1FBB) && isDefined(level.var_EC85[self.var_1FBB])) {
    var_1 = level.var_EC85[self.var_1FBB][var_0];
  }

  if(!isDefined(var_1)) {
    if(!isDefined(level.var_EC85["default_civilian"])) {
      return;
    }

    var_1 = level.var_EC85["default_civilian"][var_0];
  }

  thread func_BC1C();
  for(;;) {
    self _meth_82E3("idle", scripts\engine\utility::random(var_1), % root, 1, 0.2, 1);
    self waittillmatch("end", "idle");
  }
}

func_BC1C() {
  self endon("killanimscript");
  while(!isDefined(self.var_3C34)) {
    wait(1);
  }
}

func_02C8() {
  cover();
}

func_79BE() {
  return level.var_3FD8[randomint(level.var_3FD8.size)];
}
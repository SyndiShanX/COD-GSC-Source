/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\flashed.gsc
*********************************************/

func_9514() {}

func_7FE4() {
  var_0 = "soldier";
  if(isDefined(self.var_1F62) && isDefined(level.var_6EC0[self.var_1F62])) {
    var_0 = self.var_1F62;
  }

  level.var_6EC0[var_0]++;
  if(level.var_6EC0[var_0] >= level.archetypes[var_0]["flashed"]["flashed"].size) {
    level.var_6EC0[var_0] = 0;
    level.archetypes[var_0]["flashed"]["flashed"] = ::scripts\engine\utility::array_randomize(level.archetypes[var_0]["flashed"]["flashed"]);
  }

  return level.archetypes[var_0]["flashed"]["flashed"][level.var_6EC0[var_0]];
}

func_6EC1(var_0) {
  self endon("killanimscript");
  self _meth_82E3("flashed_anim", var_0, % body, 0.2, randomfloatrange(0.9, 1.1));
  scripts\anim\shared::donotetracks("flashed_anim");
}

main() {
  self endon("death");
  self endon("killanimscript");
  scripts\anim\utility::func_9832("flashed");
  var_0 = scripts\sp\utility::func_6EC3();
  if(var_0 <= 0) {
    return;
  }

  scripts\anim\face::saygenericdialogue("flashbang");
  if(isDefined(self.var_10959)) {
    self[[self.var_10959]]();
    return;
  }

  var_1 = func_7FE4();
  func_6EC2(var_1, var_0);
}

func_6EC2(var_0, var_1) {
  self endon("death");
  self endon("killanimscript");
  if(self.a.pose == "prone") {
    scripts\anim\utility::exitpronewrapper(1);
  }

  self.a.pose = "stand";
  self.opcode::OP_ClearLocalVariableFieldCached0 = 1;
  thread func_6EC1(var_0);
  wait(var_1);
  self notify("stop_flashbang_effect");
  self.var_6EC9 = 0;
}
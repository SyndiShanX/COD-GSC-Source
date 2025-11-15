/*****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\traverse\jump_across_100.gsc
*****************************************************/

main() {
  if(self.type == "dog") {
    scripts\anim\traverse\shared::func_5869("window_40", 20);
    return;
  }

  self.var_5270 = "stand";
  scripts\anim\utility::func_12E5F();
  self endon("killanimscript");
  self _meth_83C4("nogravity");
  self _meth_83C4("noclip");
  var_00 = self getspectatepoint();
  self orientmode("face angle", var_00.angles[1]);
  var_01 = func_7814();
  self _meth_82E4("jumpanim", var_01, % body, 1, 0.1, 1);
  scripts\anim\shared::donotetracks("jumpanim");
}

func_7814() {
  var_00 = [];
  var_00[0] = % jump_across_100_spring;
  var_00[1] = % jump_across_100_lunge;
  var_00[2] = % jump_across_100_stumble;
  return var_00[randomint(var_00.size)];
}
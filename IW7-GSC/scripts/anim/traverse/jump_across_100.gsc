/*****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
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
  self func_83C4("nogravity");
  self func_83C4("noclip");
  var_0 = self getspectatepoint();
  self orientmode("face angle", var_0.angles[1]);
  var_1 = func_7814();
  self func_82E4("jumpanim", var_1, % body, 1, 0.1, 1);
  scripts\anim\shared::donotetracks("jumpanim");
}

func_7814() {
  var_0 = [];
  var_0[0] = % jump_across_100_spring;
  var_0[1] = % jump_across_100_lunge;
  var_0[2] = % jump_across_100_stumble;
  return var_0[randomint(var_0.size)];
}
/***********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\traverse\ladder_up.gsc
***********************************************/

main() {
  if(isDefined(self.type) && self.type == "dog") {
    return;
  }

  self.var_5270 = "crouch";
  scripts\anim\utility::func_12E5F();
  self endon("killanimscript");
  self _meth_83C4("noclip");
  var_0 = % ladder_climbup;
  var_1 = % ladder_climboff;
  var_2 = self getspectatepoint();
  self orientmode("face angle", var_2.angles[1]);
  var_3 = 1;
  if(isDefined(self.moveplaybackrate)) {
    var_3 = self.moveplaybackrate;
  }

  self _meth_82E4("climbanim", var_0, % body, 1, 0.1, var_3);
  var_4 = getmovedelta(var_1, 0, 1);
  var_5 = self _meth_8145();
  var_6 = var_5.origin - var_4 + (0, 0, 1);
  var_7 = getmovedelta(var_0, 0, 1);
  var_8 = var_7[2] * var_3 / getanimlength(var_0);
  var_9 = var_6[2] - self.origin[2] / var_8;
  if(var_9 > 0) {
    self.allowpain = 1;
    scripts\anim\notetracks::donotetracksfortime(var_9, "climbanim");
    self _meth_82E4("climbanim", var_1, % body, 1, 0.1, var_3);
    scripts\anim\shared::donotetracks("climbanim");
  }

  self _meth_83C4("gravity");
  self.a.movement = "run";
  self.a.pose = "crouch";
}
/***********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
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
  var_00 = % ladder_climbup;
  var_01 = % ladder_climboff;
  var_02 = self getspectatepoint();
  self orientmode("face angle", var_02.angles[1]);
  var_03 = 1;
  if(isDefined(self.moveplaybackrate)) {
    var_03 = self.moveplaybackrate;
  }

  self _meth_82E4("climbanim", var_00, % body, 1, 0.1, var_03);
  var_04 = getmovedelta(var_01, 0, 1);
  var_05 = self _meth_8145();
  var_06 = var_05.origin - var_04 + (0, 0, 1);
  var_07 = getmovedelta(var_00, 0, 1);
  var_08 = var_07[2] * var_03 / getanimlength(var_00);
  var_09 = var_06[2] - self.origin[2] / var_08;
  if(var_09 > 0) {
    self.allowpain = 1;
    scripts\anim\notetracks::donotetracksfortime(var_09, "climbanim");
    self _meth_82E4("climbanim", var_01, % body, 1, 0.1, var_03);
    scripts\anim\shared::donotetracks("climbanim");
  }

  self _meth_83C4("gravity");
  self.a.movement = "run";
  self.a.pose = "crouch";
}
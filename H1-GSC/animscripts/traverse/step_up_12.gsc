/***********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\traverse\step_up_12.gsc
***********************************************/

main() {
  self endon("killanimscript");
  var_0 = self getnegotiationstartnode();
  self orientmode("face angle", var_0.angles[1]);
  var_1 = var_0.traverse_height - var_0.origin[2];
  var_2 = var_1;
  var_3 = 6;
  var_4 = (0, 0, var_2 / var_3);
  self traversemode("noclip");

  for (var_5 = 0; var_5 < var_3; var_5++) {
    self teleport(self.origin + var_4);
    wait 0.05;
  }

  self traversemode("gravity");
}
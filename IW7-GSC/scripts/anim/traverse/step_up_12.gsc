/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\traverse\step_up_12.gsc
************************************************/

main() {
  self endon("killanimscript");
  var_0 = self getspectatepoint();
  self orientmode("face angle", var_0.angles[1]);
  var_1 = var_0.var_126D4 - var_0.origin[2];
  var_2 = var_1;
  var_3 = 7;
  var_4 = (0, 0, var_2 / var_3);
  var_5 = getdvarint("ai_iw7", 0) != 0;
  if(var_5) {
    self animmode("noclip");
  } else {
    self func_83C4("noclip");
  }

  for(var_6 = 0; var_6 < var_3; var_6++) {
    self func_83B9(self.origin + var_4);
    wait(0.05);
  }

  if(var_5) {
    self animmode("gravity");
  } else {
    self func_83C4("gravity");
  }

  if(var_5) {
    self notify("external_traverse_complete");
  }
}
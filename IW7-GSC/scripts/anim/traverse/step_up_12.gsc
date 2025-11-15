/************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\traverse\step_up_12.gsc
************************************************/

main() {
  self endon("killanimscript");
  var_00 = self getspectatepoint();
  self orientmode("face angle", var_00.angles[1]);
  var_01 = var_00.var_126D4 - var_00.origin[2];
  var_02 = var_01;
  var_03 = 7;
  var_04 = (0, 0, var_02 / var_03);
  var_05 = getdvarint("ai_iw7", 0) != 0;
  if(var_05) {
    self animmode("noclip");
  } else {
    self _meth_83C4("noclip");
  }

  for(var_06 = 0; var_06 < var_03; var_06++) {
    self _meth_83B9(self.origin + var_04);
    wait(0.05);
  }

  if(var_05) {
    self animmode("gravity");
  } else {
    self _meth_83C4("gravity");
  }

  if(var_05) {
    self notify("external_traverse_complete");
  }
}
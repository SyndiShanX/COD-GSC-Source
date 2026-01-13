/******************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\traverse\double_jump_temp.gsc
******************************************************/

main() {
  if(isDefined(self.unittype) && self.unittype == "c12") {
    return;
  }

  if(getdvarint("ai_iw7", 0) == 1) {
    self endon("killanimscript");
    self endon("death");
    wait(0.05);
    return;
  }

  func_5AD2();
}

func_5AD2() {
  self endon("killanimscript");
  self endon("death");
  self.var_DC1A = 1;
  var_0 = self getspectatepoint();
  var_1 = self _meth_8145();
  var_0.var_126D4 = var_0.var_126D4 - 44;
  var_2 = [];
  if(var_0.var_126D4 > var_1.origin[2]) {
    var_3 = var_0.origin[0] + var_1.origin[0] * 0.5;
    var_4 = var_0.origin[1] + var_1.origin[1] * 0.5;
    var_2[var_2.size] = (var_3, var_4, var_0.var_126D4);
  }

  var_2[var_2.size] = var_1.origin;
  var_5 = spawn("script_model", var_0.origin);
  var_5 setModel("tag_origin");
  var_5.angles = var_0.angles;
  self orientmode("face angle", var_0.angles[1]);
  var_6 = 1.63;
  self clearanim( % body, 0.2);
  self _meth_82E7("traverseAnim", % traverse_doublejump, 1, 0.2, 1);
  childthread func_11629(var_5);
  thread scripts\anim\shared::donotetracks("traverseAnim", ::scripts\anim\traverse\shared::func_89F8);
  foreach(var_8 in var_2) {
    var_9 = var_6 / var_2.size;
    var_5 moveto(var_8, var_9);
    var_5 waittill("movedone");
  }

  self notify("double_jumped");
  self.var_DC1A = undefined;
  var_5 delete();
}

func_11629(var_0) {
  self endon("double_jumped");
  for(;;) {
    self _meth_80F1(var_0.origin, var_0.angles, 10000);
    wait(0.05);
  }
}
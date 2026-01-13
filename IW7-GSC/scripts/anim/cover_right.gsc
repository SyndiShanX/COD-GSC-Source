/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\cover_right.gsc
*********************************************/

func_950A() {}

main() {
  self.var_1F66 = [];
  self.var_1F66["hiding"]["stand"] = ::func_F2C0;
  self.var_1F66["hiding"]["crouch"] = ::func_F2B8;
  self endon("killanimscript");
  scripts\anim\utility::func_9832("cover_right");
  scripts\anim\corner::func_4661("right", -90);
}

end_script() {
  scripts\anim\corner::func_62F3();
  scripts\anim\cover_behavior::ismayhem("right");
}

func_F2C0() {
  self.var_8EDF = -90;
  self.a.var_2274 = scripts\anim\utility::func_B028("cover_right_stand");
  if(isDefined(level.var_DC5B)) {
    self.a.var_2274["rambo90"] = level.var_DC5B.var_4744;
    self.a.var_2274["rambo45"] = level.var_DC5B.var_4743;
    self.a.var_2274["grenade_rambo"] = level.var_DC5B.var_4745;
  }
}

func_F2B8() {
  self.var_8EDF = -90;
  self.a.var_2274 = scripts\anim\utility::func_B028("cover_right_crouch");
}
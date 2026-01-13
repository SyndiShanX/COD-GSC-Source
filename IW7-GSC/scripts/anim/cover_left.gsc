/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\cover_left.gsc
*********************************************/

func_9507() {}

main() {
  self.var_1F66 = [];
  self.var_1F66["hiding"]["stand"] = ::func_F2BF;
  self.var_1F66["hiding"]["crouch"] = ::func_F2B7;
  self endon("killanimscript");
  scripts\anim\utility::func_9832("cover_left");
  scripts\anim\corner::func_4661("left", 90);
}

end_script() {
  scripts\anim\corner::func_62F3();
  scripts\anim\cover_behavior::ismayhem("left");
}

func_F2BF() {
  self.var_8EDF = 90;
  self.a.var_2274 = scripts\anim\utility::func_B028("cover_left_stand");
  if(isDefined(level.var_DC5B)) {
    self.a.var_2274["rambo90"] = level.var_DC5B.var_4723;
    self.a.var_2274["rambo45"] = level.var_DC5B.var_4722;
    self.a.var_2274["grenade_rambo"] = level.var_DC5B.var_4724;
  }
}

func_F2B7() {
  self.var_8EDF = 90;
  self.a.var_2274 = scripts\anim\utility::func_B028("cover_left_crouch");
}
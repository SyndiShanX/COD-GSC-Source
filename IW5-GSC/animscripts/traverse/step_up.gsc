/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\step_up.gsc
********************************************/

main() {
  if(self.type == "dog") {
    animscripts\traverse\shared::_id_3FF9(40, 3);
  } else {
    _id_3FFB();
  }
}

#using_animtree("generic_human");

_id_3FFB() {
  self._id_247C = "crouch";
  animscripts\utility::_id_247B();
  self endon("killanimscript");
  self.a._id_0D2B = "walk";
  self traversemode("nogravity");
  var_0 = self getnegotiationstartnode();
  self orientmode("face angle", var_0.angles[1]);
  self setflaggedanimknoballrestart("stepanim", %step_up_low_wall, %body, 1, 0.1, 1);
  self waittillmatch("stepanim", "gravity on");
  self traversemode("gravity");
  animscripts\shared::_id_0C51("stepanim");
  self setanimknoballrestart(animscripts\run::_id_0FC4(), %body, 1, 0.1, 1);
}
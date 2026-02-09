/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\step_down.gsc
**********************************************/

main() {
  if(self.type == "dog") {
    animscripts\traverse\shared::_id_3FF8(40, 3);
  } else {
    _id_3FFA();
  }
}

#using_animtree("generic_human");

_id_3FFA() {
  self._id_247C = "crouch";
  animscripts\utility::_id_247B();
  self endon("killanimscript");
  self.a._id_0D2B = "walk";
  self traversemode("nogravity");
  var_0 = self getnegotiationstartnode();
  self orientmode("face angle", var_0.angles[1]);
  self setflaggedanimknoballrestart("stepanim", %step_down_low_wall, %body, 1, 0.1, 1);
  self waittillmatch("stepanim", "gravity on");
  self traversemode("gravity");
  animscripts\shared::_id_0C51("stepanim");
}
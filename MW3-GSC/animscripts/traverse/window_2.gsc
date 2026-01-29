/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\window_2.gsc
*********************************************/

#using_animtree("generic_human");

main() {
  if(self.type == "dog") {
    animscripts\traverse\shared::_id_3FF7("wallhop", 40);
  } else {
    _id_3FFD( % windowclimb, 35);
  }
}

_id_3FFD(var_0, var_1) {
  self._id_247C = "crouch";
  animscripts\utility::_id_247B();
  self endon("killanimscript");
  self traversemode("nogravity");
  self traversemode("noclip");
  var_2 = self getnegotiationstartnode();
  self orientmode("face angle", var_2.angles[1]);
  var_3 = var_2._id_1EFA - var_2.origin[2];
  self setflaggedanimknoballrestart("traverse", var_0, % body, 1, 0.15, 1);
  wait 0.7;
  thread animscripts\traverse\shared::_id_3FE7(var_3 - var_1);
  wait 0.9;
  self traversemode("gravity");
  animscripts\shared::_id_0C51("traverse");
}
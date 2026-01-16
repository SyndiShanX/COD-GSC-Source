/*******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\cover_swim_left.gsc
*******************************************/

main() {
  self.animarrayfuncs = [];
  self.animarrayfuncs["hiding"]["stand"] = ::setanims_coverleft_stand;
  self.animarrayfuncs["hiding"]["crouch"] = ::setanims_coverleft_stand;
  self endon("killanimscript");
  animscripts\utility::initialize("cover_swim_left");

  if(!isdefined(self.approachtype) || self.approachtype != "cover_corner_l")
    self.approachtype = "cover_corner_l";

  var_0 = anim.archetypes["soldier"]["swim"]["arrival_cover_corner_l_angleDelta"][4][4];
  animscripts\corner::corner_think("left", var_0[1]);
}

end_script() {
  animscripts\corner::end_script_corner();
  animscripts\cover_behavior::end_script("left");
}

setanims_coverleft_stand() {
  self.a.array = animscripts\swim::getswimanim("cover_corner_l");
  var_0 = anim.archetypes["soldier"]["swim"]["arrival_cover_corner_l_angleDelta"][4][4];
  self.hideyawoffset = var_0[1];
}
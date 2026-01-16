/********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\cover_swim_right.gsc
********************************************/

main() {
  self.animarrayfuncs = [];
  self.animarrayfuncs["hiding"]["stand"] = ::setanims_coverright_stand;
  self.animarrayfuncs["hiding"]["crouch"] = ::setanims_coverright_stand;
  self endon("killanimscript");
  animscripts\utility::initialize("cover_swim_right");

  if(!isdefined(self.approachtype) || self.approachtype != "cover_corner_r")
    self.approachtype = "cover_corner_r";

  var_0 = anim.archetypes["soldier"]["swim"]["arrival_cover_corner_r_angleDelta"][4][4];
  animscripts\corner::corner_think("right", var_0[1]);
}

end_script() {
  animscripts\corner::end_script_corner();
  animscripts\cover_behavior::end_script("right");
}

setanims_coverright_stand() {
  self.a.array = animscripts\swim::getswimanim("cover_corner_r");
  var_0 = anim.archetypes["soldier"]["swim"]["arrival_cover_corner_r_angleDelta"][4][4];
  self.hideyawoffset = var_0[1];
}
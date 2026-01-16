/*****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\cover_swim_up.gsc
*****************************************/

main() {
  self.animarrayfuncs = [];
  self.animarrayfuncs["hiding"]["stand"] = ::setanims_coverup_stand;
  self.animarrayfuncs["hiding"]["crouch"] = ::setanims_coverup_stand;
  self endon("killanimscript");
  animscripts\utility::initialize("cover_swim_up");

  if(!isdefined(self.approachtype) || self.approachtype != "cover_u")
    self.approachtype = "cover_u";

  animscripts\corner::corner_think("up", 0);
}

end_script() {
  animscripts\corner::end_script_corner();
  animscripts\cover_behavior::end_script("up");
}

setanims_coverup_stand() {
  self.a.array = animscripts\swim::getswimanim("cover_u");
  self.hideyawoffset = 0;
}
/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\render_utility.gsc
****************************************************/

_id_4F2C4138DACCA16A(_id_09F68DC7B5633652, radius, _id_0C0AB0189903C9D4, _id_EE2D3F6B47705676) {
  if(isDefined(_id_09F68DC7B5633652))
    self setclientomnvar("chromatic_aberration_override", _id_09F68DC7B5633652);

  if(isDefined(radius))
    self setclientomnvar("chromatic_aberration_radius_override", radius);

  if(isDefined(_id_0C0AB0189903C9D4))
    self setclientomnvar("chromatic_aberration_strength_override", _id_0C0AB0189903C9D4);

  if(isDefined(_id_EE2D3F6B47705676))
    self setclientomnvar("chromatic_aberration_distortion_override", _id_EE2D3F6B47705676);
}

_id_E2EAE50826E12247() {
  self setclientomnvar("chromatic_aberration_override", 0.0);
  self setclientomnvar("chromatic_aberration_radius_override", 0.0);
  self setclientomnvar("chromatic_aberration_strength_override", 0.0);
  self setclientomnvar("chromatic_aberration_distortion_override", 0.0);
}
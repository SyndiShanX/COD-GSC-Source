/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\cover_right.gsc
****************************************/

_id_950A() {}

main() {
  self._id_1F66 = [];
  self._id_1F66["hiding"]["stand"] = ::_id_F2C0;
  self._id_1F66["hiding"]["crouch"] = ::_id_F2B8;
  self endon("killanimscript");
  scripts\anim\utility::_id_9832("cover_right");
  scripts\anim\corner::_id_4661("right", -90);
}

end_script() {
  scripts\anim\corner::_id_62F3();
  scripts\anim\cover_behavior::end_script("right");
}

_id_F2C0() {
  self._id_8EDF = -90;
  self.a._id_2274 = scripts\anim\utility::_id_B028("cover_right_stand");

  if(isDefined(anim._id_DC5B)) {
    self.a._id_2274["rambo90"] = anim._id_DC5B._id_4744;
    self.a._id_2274["rambo45"] = anim._id_DC5B._id_4743;
    self.a._id_2274["grenade_rambo"] = anim._id_DC5B._id_4745;
  }
}

_id_F2B8() {
  self._id_8EDF = -90;
  self.a._id_2274 = scripts\anim\utility::_id_B028("cover_right_crouch");
}
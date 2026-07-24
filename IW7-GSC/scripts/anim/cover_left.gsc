/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\cover_left.gsc
***************************************/

_id_9507() {}

main() {
  self._id_1F66 = [];
  self._id_1F66["hiding"]["stand"] = ::_id_F2BF;
  self._id_1F66["hiding"]["crouch"] = ::_id_F2B7;
  self endon("killanimscript");
  scripts\anim\utility::_id_9832("cover_left");
  scripts\anim\corner::_id_4661("left", 90);
}

end_script() {
  scripts\anim\corner::_id_62F3();
  scripts\anim\cover_behavior::end_script("left");
}

_id_F2BF() {
  self._id_8EDF = 90;
  self.a._id_2274 = scripts\anim\utility::_id_B028("cover_left_stand");

  if(isDefined(anim._id_DC5B)) {
    self.a._id_2274["rambo90"] = anim._id_DC5B._id_4723;
    self.a._id_2274["rambo45"] = anim._id_DC5B._id_4722;
    self.a._id_2274["grenade_rambo"] = anim._id_DC5B._id_4724;
  }
}

_id_F2B7() {
  self._id_8EDF = 90;
  self.a._id_2274 = scripts\anim\utility::_id_B028("cover_left_crouch");
}
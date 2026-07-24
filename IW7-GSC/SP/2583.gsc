/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2583.gsc
**************************************/

_id_9308(var_0) {
  if(!isDefined(self._id_10E6D))
    return anim.failure;

  if(self.team == "allies")
    return anim.failure;

  if(_id_0F18::_id_10E8A("is_in_stealth"))
    return anim.success;

  return anim.failure;
}

_id_12F2D(var_0) {
  if(!isDefined(self._id_10E6D._id_C9A8))
    _id_0F18::_id_10E8A("set_patrol_style", "unaware");

  if(self._id_10E6D.state == 3 && isDefined(self.enemy)) {
    _id_0F18::_id_10E8A("set_patrol_style", "combat", 1, self.enemy.origin);
    self._id_10E6D.state = 4;
  }

  return anim.success;
}
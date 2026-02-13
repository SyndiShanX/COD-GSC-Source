/**************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\aitypes\zombie_common\push.gsc
**************************************************/

is_immune_to_knockdown() {
  var_0 = _id_06FE::is_zm_elite();
  var_1 = istrue(self.lc_stunned);
  return var_0 || var_1;
}

knockdown(var_0, var_1) {
  if(is_immune_to_knockdown()) {
    return 0;
  }

  return _knockdown(_get_direction_str(var_0), var_1);
}

damage_knockdown(var_0, var_1, var_2) {
  if(is_immune_to_knockdown()) {
    return;
  }
  if(_func_010F(var_1) && var_0 >= self.maxhealth * 0.1) {
    if(isDefined(var_2)) {
      knockdown(var_2);
    } else {
      _knockdown("front");
    }
  }
}

shouldknockdown(var_0) {
  _check_knockdown_request_expired();
  var_1 = isDefined(self._id_0B67.knockdownrequestedstarttimems) && self._id_0B67.knockdownrequestedstarttimems <= gettime();
  return scripts\engine\utility::ter_op(var_1, anim._id_EACB, anim._id_58E3);
}

knockdowninit(var_0) {
  scripts\asm\zombie_common\push::play_knockdown(self._id_0B67.knockdownrequesteddirection);
  self.isknockeddown = 1;
  _clear_knockdown_request();
}

knockdownprocess(var_0) {
  if(_id_0009::_id_1C4F("knockdown", "end")) {
    return anim._id_EACB;
  }

  self _meth_8474();
  return anim._id_CA5F;
}

knockdownterminate(var_0) {
  self.isknockeddown = 0;
  self._id_0B67.knockdowncooldownendtimems = gettime() + scripts\cp\utility::_id_CFF0(1.5);
}

_knockdown(var_0, var_1) {
  if(istrue(self.isknockeddown)) {
    return 0;
  }

  _check_knockdown_request_expired();
  var_2 = gettime() + scripts\cp\utility::_id_CFF0(scripts\cp\utility::_id_459B(var_1, 0));

  if(isDefined(self._id_0B67.knockdowncooldownendtimems) && var_2 < self._id_0B67.knockdowncooldownendtimems) {
    return 0;
  }

  if(isDefined(self._id_0B67.knockdownrequestedstarttimems) && self._id_0B67.knockdownrequestedstarttimems <= var_2) {
    return 0;
  }

  self._id_0B67.knockdownrequestedstarttimems = var_2;
  self._id_0B67.knockdownrequesteddirection = var_0;
  self._id_0B67.knockdownrequestexpiretimems = self._id_0B67.knockdownrequestedstarttimems + scripts\cp\utility::_id_CFF0(1);
  return 1;
}

_get_direction_str(var_0) {
  var_1 = vectordot(anglesToForward(self.angles), var_0);

  if(var_1 >= 0.7) {
    return "back";
  }

  if(var_1 <= -0.7) {
    return "front";
  }

  var_2 = vectordot(anglestoright(self.angles), var_0);

  if(var_2 >= 0.7) {
    return "left";
  }

  return "right";
}

_check_knockdown_request_expired() {
  if(!isDefined(self._id_0B67.knockdownrequestexpiretimems)) {
    return;
  }
  if(self._id_0B67.knockdownrequestexpiretimems <= gettime()) {
    _clear_knockdown_request();
  }
}

_clear_knockdown_request() {
  self._id_0B67.knockdownrequestedstarttimems = undefined;
  self._id_0B67.knockdownrequesteddirection = undefined;
  self._id_0B67.knockdownrequestexpiretimems = undefined;
}
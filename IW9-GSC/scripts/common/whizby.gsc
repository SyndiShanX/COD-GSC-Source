/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\whizby.gsc
***********************************************/

init(_id_8611E1D824BBDB4A) {
  setdvarifuninitialized("scr_whizby", 1);
}

initplayer() {
  self._id_177B07CC2ABAC2EC = spawnStruct();
  self._id_177B07CC2ABAC2EC._id_B4C04337A6A90C84 = -999999;
  _id_BCD1A794FB26EE5C();
}

_id_A6E6611EFB4164D5(attacker, distance, position, forward) {
  time = gettime();

  if(_id_43D3999D682DE782(attacker, distance, position, forward, time)) {
    weapon = undefined;

    if(isPlayer(attacker) || isbot(attacker))
      weapon = attacker getcurrentweapon();
    else if(isai(attacker))
      weapon = attacker.weapon;
    else {}

    _id_0DD6BF5F9DBA888C = weaponclass(weapon);
    self notify("whizbyBlur_reset");
    _id_85B3CF23250D4543 = _id_21676CFE493C7014(_id_0DD6BF5F9DBA888C, distance, time);
    _id_2FAD28813245304D(_id_85B3CF23250D4543);
    _id_0B04DC57D51B057C(_id_0DD6BF5F9DBA888C, weapon, _id_85B3CF23250D4543);
    _id_05E980DBCE5B2122(attacker, position, time, _id_85B3CF23250D4543, distance);
    self._id_177B07CC2ABAC2EC._id_B4C04337A6A90C84 = time;
    _id_BCD1A794FB26EE5C();
  }
}

_id_43D3999D682DE782(attacker, distance, position, forward, time) {
  if(getdvarint("scr_whizby", 1) != 1)
    return 0;

  if(!isDefined(attacker) || !isDefined(distance) || !isDefined(position) || !isDefined(forward))
    return 0;

  if(!isai(attacker) && !isPlayer(attacker))
    return 0;

  if(!isalive(attacker))
    return 0;

  if(time - self._id_177B07CC2ABAC2EC._id_B4C04337A6A90C84 < self._id_177B07CC2ABAC2EC.cooldown)
    return 0;

  if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("whizby"))
    return 0;

  if(istrue(self.nowhizby))
    return 0;

  if(!isenemyteam(self.team, attacker.team))
    return 0;

  if(istrue(self.deathsdoor))
    return 0;

  if(_id_CEE14923E29E38AB(time))
    return 0;

  return 1;
}

_id_CEE14923E29E38AB(time) {
  if(!isDefined(self.lastdamagedtime))
    return 0;

  _id_A45D63A143541740 = getdvarint("dvar_00902F31627206F3", 750);

  if(self.lastdamagedtime + _id_A45D63A143541740 > time)
    return 1;

  return 0;
}

_id_2FAD28813245304D(_id_85B3CF23250D4543) {
  _id_5383EEEE9C6E12D4 = self playergetzoomfov();
  _id_C7BD47F5E4B60C31 = scripts\engine\math::normalize_value(4, 65, _id_5383EEEE9C6E12D4);
  _id_15801234316E9C14 = scripts\engine\math::factor_value(0.3, 0.85, _id_C7BD47F5E4B60C31);
  _id_F8E72F77B5116A2F = scripts\engine\math::factor_value(1, _id_15801234316E9C14, self playerads());
  _id_7AE8EAF92080FFC9 = scripts\engine\math::factor_value(0.03, 0.28, _id_85B3CF23250D4543);
  _id_376B7286A8FF4B23 = scripts\engine\math::factor_value(0.35, 0.35, _id_85B3CF23250D4543);
  _id_7AE8EAF92080FFC9 = _id_7AE8EAF92080FFC9 * _id_F8E72F77B5116A2F;
  self earthquakeforplayer(_id_7AE8EAF92080FFC9, _id_376B7286A8FF4B23, self.origin, 1000);
}

_id_0B04DC57D51B057C(_id_0DD6BF5F9DBA888C, weapon, _id_85B3CF23250D4543) {
  eventtype = undefined;
  _id_B7F9BAEF31D9A9D9 = 2;

  switch (_id_0DD6BF5F9DBA888C) {
    case "mg":
      _id_B7F9BAEF31D9A9D9 = 3;
      break;
    case "sniper":
      if(scripts\engine\utility::string_starts_with("iw9_dm", weapon.basename))
        _id_B7F9BAEF31D9A9D9 = 2;
      else
        _id_B7F9BAEF31D9A9D9 = 3;

      break;
    case "rifle":
      _id_B7F9BAEF31D9A9D9 = 2;
      break;
    case "pistol":
    case "smg":
      _id_B7F9BAEF31D9A9D9 = 2;
      break;
  }

  _id_BEEA5B6FFEFAADE1 = _id_B7F9BAEF31D9A9D9;

  if(_id_85B3CF23250D4543 < 0.3)
    _id_BEEA5B6FFEFAADE1 = _id_BEEA5B6FFEFAADE1 - 2;
  else if(_id_85B3CF23250D4543 < 0.6)
    _id_BEEA5B6FFEFAADE1 = _id_BEEA5B6FFEFAADE1 - 1;

  switch (_id_BEEA5B6FFEFAADE1) {
    case 3:
      eventtype = "vsp_large";
      break;
    case 2:
      eventtype = "vsp_medium";
      break;
    case 1:
      eventtype = "vsp_small";
      break;
  }

  if(_id_BEEA5B6FFEFAADE1 > 0)
    self _meth_38E25FA379161404(eventtype);
}

_id_05E980DBCE5B2122(attacker, position, time, _id_85B3CF23250D4543, distance) {
  _id_10D38F4DC0D37164 = self getplayerangles();
  _id_52241BCC3A205EF4 = self getEye();
  _id_14D9D4FFFC09A76D = anglestoaxis(_id_10D38F4DC0D37164);

  if(isDefined(attacker.currentweapon) && attacker tagexists("tag_flash"))
    _id_86C1C8628B1D55F8 = attacker gettagorigin("tag_flash");
  else
    _id_86C1C8628B1D55F8 = attacker.origin + (0, 0, 50);

  _id_E7BF1C5B5DBC408F = vectorNormalize(_id_86C1C8628B1D55F8 - _id_52241BCC3A205EF4);
  _id_7CAF68458D047D37 = vectordot(_id_E7BF1C5B5DBC408F, _id_14D9D4FFFC09A76D["forward"]);
  _id_31659D73698C898A = vectordot(_id_E7BF1C5B5DBC408F, _id_14D9D4FFFC09A76D["right"]);
  _id_7F628B9BD51160D5 = vectordot(_id_E7BF1C5B5DBC408F, _id_14D9D4FFFC09A76D["up"]);
  _id_3CA1B715AC9AD24E = attacker getentitynumber();
  _id_DD9BB8522CC9E666 = clamp(_id_7CAF68458D047D37, 0, 1);
  _id_B4B4994E3604CE34 = 1.0 - abs(_id_7CAF68458D047D37);
  _id_F3DAE9EEECBC6A28 = clamp(-1 * _id_7CAF68458D047D37, 0, 1);
  _id_3783A488B009BC61 = _id_DBABF852A35102E4(_id_31659D73698C898A, _id_7F628B9BD51160D5);
  _id_4C321C57B0D42848 = position + -500 * _id_E7BF1C5B5DBC408F;
  _id_DD9BB8522CC9E666 = scripts\engine\math::normalized_float_smooth_out(_id_DD9BB8522CC9E666);
  _id_B4B4994E3604CE34 = scripts\engine\math::normalized_float_smooth_out(_id_B4B4994E3604CE34);
  self setclientomnvar("ui_whizby_alpha_front", _id_DD9BB8522CC9E666 * _id_85B3CF23250D4543 * 0.5);
  self setclientomnvar("ui_whizby_alpha_side", _id_B4B4994E3604CE34 * _id_85B3CF23250D4543 * 1.0);
  self setclientomnvar("ui_whizby_alpha_back", _id_F3DAE9EEECBC6A28 * _id_85B3CF23250D4543 * 1.0);
  self setclientomnvar("ui_whizby_side_angle", int(_id_3783A488B009BC61));
  self setclientomnvar("ui_whizby_ent", _id_3CA1B715AC9AD24E);
  self setclientomnvar("ui_whizby_back_x", int(_id_4C321C57B0D42848[0]));
  self setclientomnvar("ui_whizby_back_y", int(_id_4C321C57B0D42848[1]));
  self setclientomnvar("ui_whizby_back_z", int(_id_4C321C57B0D42848[2]));
  _id_81954D580B24281B = self getclientomnvar("ui_whizby_back_x");
  _id_E4F34F3A01C6FFF2 = self getclientomnvar("ui_whizby_back_y");
  _id_689A1188271A0BE5 = self getclientomnvar("ui_whizby_back_z");
  self setclientomnvar("ui_whizby_notify", time);
}

_id_DBABF852A35102E4(_id_31659D73698C898A, _id_7F628B9BD51160D5) {
  _id_45C4BEE623CE2BF8 = abs(_id_31659D73698C898A) + abs(_id_7F628B9BD51160D5);

  if(_id_45C4BEE623CE2BF8 > 0) {
    _id_2753E57904B85655 = _id_31659D73698C898A / _id_45C4BEE623CE2BF8;
    _id_B4B3AC63E415ECFC = _id_7F628B9BD51160D5 / _id_45C4BEE623CE2BF8;
  } else {
    _id_2753E57904B85655 = 1;
    _id_B4B3AC63E415ECFC = 1;
  }

  if(_id_B4B3AC63E415ECFC < 0)
    angle = 90 * _id_2753E57904B85655;
  else {
    angle = 90 + 90 * _id_B4B3AC63E415ECFC;

    if(_id_2753E57904B85655 < 0)
      angle = angle * -1;
  }

  return angle;
}

_id_21676CFE493C7014(_id_0DD6BF5F9DBA888C, distance, time) {
  _id_2A0DE1C48A667A53 = 0.8;

  switch (_id_0DD6BF5F9DBA888C) {
    case "mg":
      _id_2A0DE1C48A667A53 = 1;
      break;
    case "sniper":
      _id_2A0DE1C48A667A53 = 1;
      break;
    case "smg":
      _id_2A0DE1C48A667A53 = 0.6;
      break;
    case "pi":
      _id_2A0DE1C48A667A53 = 0.6;
      break;
  }

  _id_414A86ED853C7FA6 = scripts\engine\math::normalize_value(50, 120, distance);
  _id_414A86ED853C7FA6 = scripts\engine\math::factor_value(1.0, 0.5, _id_414A86ED853C7FA6);
  _id_34D803DBF2021E83 = randomfloatrange(0.08, 0.27);
  _id_C8A91E5582A5F256 = time - self._id_177B07CC2ABAC2EC._id_B4C04337A6A90C84;
  _id_B2A42028CD0D9167 = scripts\engine\math::normalize_value(2000, 6000, _id_C8A91E5582A5F256);
  _id_9416AC5E3A43D3BD = scripts\engine\math::factor_value(_id_34D803DBF2021E83, 1, _id_B2A42028CD0D9167);
  return _id_2A0DE1C48A667A53 * _id_414A86ED853C7FA6 * _id_9416AC5E3A43D3BD;
}

_id_BCD1A794FB26EE5C() {
  self._id_177B07CC2ABAC2EC.cooldown = randomfloatrange(100, 450);
}
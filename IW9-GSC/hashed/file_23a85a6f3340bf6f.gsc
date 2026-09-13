/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_23a85a6f3340bf6f.gsc
***********************************************/

_id_67D00E6B876C5EE2(position, angles) {
  if(self.sessionstate != "spectator")
    self setOrigin(position);

  if(isDefined(angles))
    self setplayerangles(angles);
}

_id_A074C3F0D66BA8E0() {
  self endon("game_ended");
  self endon("death_or_disconnect");
  self endon("clip_limited");

  for(;;) {
    _id_0EB7F4869595F550 = self getcurrentweapon();

    if(self getweaponammoclip(_id_0EB7F4869595F550) <= 10)
      self setweaponammoclip(_id_0EB7F4869595F550, 20);

    wait 0.3;
  }
}

_id_F83C33A014EE22FE() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  for(;;) {
    _id_0EB7F4869595F550 = self getcurrentweapon();

    if(self getweaponammostock(_id_0EB7F4869595F550) <= 30)
      self setweaponammostock(_id_0EB7F4869595F550, 60);

    wait 1;
  }
}

_id_BBD25202175D7F6F(player, ally) {
  return isDefined(player) && isDefined(ally) && isalliedsentient(player, ally) && (istrue(ally.jailed) || istrue(ally.gulagarena) || istrue(ally.gulag));
}

_id_78D176299D2E0714(player, _id_E8F714BAB38B613C) {
  ascenders = _id_866B54331A9BAEC7(player, _id_E8F714BAB38B613C);
  return ascenders.size > 0;
}

_id_AAA603D13BDA1521(player, _id_E8F714BAB38B613C, _id_000E423679CBC3DA) {
  ascenders = _id_E89C4A695A431598(player, _id_E8F714BAB38B613C, _id_000E423679CBC3DA);
  return ascenders.size > 0;
}

_id_C7B734F950B39543(params) {
  dist = params._id_71E5A20019EC7F70;
  _id_000E423679CBC3DA = params._id_521C017D925335D6;
  return _id_AAA603D13BDA1521(self, dist, _id_000E423679CBC3DA);
}

_id_866B54331A9BAEC7(player, detectionradius, _id_000E423679CBC3DA) {
  ascenders = getentitylessscriptablearray("scriptable_military_ascendertop_heavy", "classname", player.origin, detectionradius);
  _id_DCDEEF62FDB17171 = [];

  foreach(ascender in ascenders) {
    _id_EEA82522BACDD291 = distance2dsquared(ascender.origin, player.origin);

    if(_id_EEA82522BACDD291 <= _id_000E423679CBC3DA)
      _id_DCDEEF62FDB17171 = scripts\engine\utility::array_add_safe(_id_DCDEEF62FDB17171, ascender);
  }

  return _id_DCDEEF62FDB17171;
}

_id_E89C4A695A431598(player, _id_E8F714BAB38B613C, _id_000E423679CBC3DA) {
  _id_922971120B383607 = _id_866B54331A9BAEC7(player, _id_E8F714BAB38B613C, _id_000E423679CBC3DA);
  _id_BBA73B308EC6E2BF = [];

  foreach(ascender in _id_922971120B383607) {
    _id_73E1987DEB24358C = scripts\engine\trace::ray_trace(ascender.origin, ascender.origin + (0, 0, 500))["normal"];

    if(_id_73E1987DEB24358C == (0, 0, 0))
      _id_BBA73B308EC6E2BF = scripts\engine\utility::array_add_safe(_id_BBA73B308EC6E2BF, ascender);
  }

  return _id_BBA73B308EC6E2BF;
}

_id_E09FE43DABD5E4CF(player, ascenders) {
  if(ascenders.size > 0) {
    mindistance = distance2dsquared(ascenders[0].origin, player.origin);
    _id_48476CF9CF37777E = ascenders[0];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < ascenders.size; _id_AC0E594AC96AA3A8++) {
      _id_AE695132BEFABC19 = distance2dsquared(ascenders[_id_AC0E594AC96AA3A8].origin, player.origin);

      if(_id_AE695132BEFABC19 < mindistance) {
        mindistance = _id_AE695132BEFABC19;
        _id_48476CF9CF37777E = ascenders[_id_AC0E594AC96AA3A8];
      }
    }

    return _id_48476CF9CF37777E;
  }

  return undefined;
}

_id_BF0A1F8B03EA5C18(player) {
  return player _meth_9CC921A57FF4DEB5();
}

_id_D97F26CD24750946() {
  _id_31675498774C0DC5 = _id_BF0A1F8B03EA5C18(self);

  if(isDefined(_id_31675498774C0DC5))
    return _id_31675498774C0DC5;

  return 0;
}

_id_331E465C203522E0(_id_6E8B41E0A5648F49) {
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", message, value);

    if(isDefined(message) && message == "ftue_minimap_opened") {
      self[[_id_6E8B41E0A5648F49]]();
      break;
    }
  }
}

_id_152B922C52A79E9E(player) {
  player._id_6AB0FD4589F5AEA5 = 1;
  _id_52EED65F3AF6AF91::_id_7FD621B8BA80E652();
}

_id_506621F96F8313A5(_id_6E8B41E0A5648F49) {
  _id_C6C53EA9225F6FC2(_id_6E8B41E0A5648F49);
}

_id_C6C53EA9225F6FC2(_id_6E8B41E0A5648F49) {
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", message, value);

    if(isDefined(message) && message == "ftue_minimap_closed") {
      self[[_id_6E8B41E0A5648F49]]();
      break;
    }
  }
}

_id_F3FDF43101042F63(_id_4B2538E850DF3357) {
  if(isDefined(_id_4B2538E850DF3357) && _id_4B2538E850DF3357 == "gasMiniMapCloseTip")
    self._id_64A66C71D00E6F50 = 1;
}

_id_6FC17F2A58009875() {
  return isDefined(self.br_infil_type) && self.br_infil_type == "c130" && scripts\mp\flags::gameflag("br_ready_to_jump");
}

_id_D1518CE894DD64E7(params) {
  return _id_6FC17F2A58009875() == params._id_BE502A4377111804;
}

_id_18FCD72DFEA6CAC1() {
  if(!self._id_CA031FD3734A1C62)
    _id_52974897AD9887A8();
}

_id_52974897AD9887A8() {
  self endon("disconnect");

  while(!self._id_CA031FD3734A1C62)
    waitframe();

  return;
}

_id_5C6C946F52BE9A50(_id_4B2538E850DF3357) {
  self._id_CA031FD3734A1C62 = 1;
}

_id_914E9D5E71CC6EFB() {
  self endon("disconnect");
  self endon("currentContextualTipCompleted");
  self endon("currentContextualTipAborted");

  while(!self _meth_3C6BB30AE7106B7A())
    waitframe();

  return;
}

_id_8584A8A9B5FA0463() {
  return _id_58F20490049AF6AC::_id_A465E3C1371D7DAB(self.origin);
}

_id_671C7049215EBC9C() {
  _id_6CB069D7B1DFAAE0 = _id_8584A8A9B5FA0463();

  if(!isDefined(_id_6CB069D7B1DFAAE0))
    return 0;

  return _id_6CB069D7B1DFAAE0;
}

_id_4C16F440B2C0B804(_id_F3F4EB55AED6E784, maxheight) {
  return self.origin[2] < _id_F3F4EB55AED6E784 || self.origin[2] > maxheight;
}

_id_2FDE996B20D64205(params) {
  if(_id_4C16F440B2C0B804(params._id_F3F4EB55AED6E784, params.maxheight))
    return 0;

  _id_71DD2A61430C603F = _id_8EB62EFBAB104B05();

  if(isDefined(_id_71DD2A61430C603F))
    return _id_71DD2A61430C603F < params._id_71DD2A61430C603F;

  return 0;
}

_id_725B52F601C21A7A(maxdistance, mindistance) {
  _id_71DD2A61430C603F = _id_8EB62EFBAB104B05();

  if(isDefined(_id_71DD2A61430C603F))
    return _id_71DD2A61430C603F < maxdistance && _id_71DD2A61430C603F > mindistance;

  return 0;
}

_id_8EB62EFBAB104B05() {
  _id_819EDACDACB810E4 = (level.br_circle.dangercircleent.origin[0], level.br_circle.dangercircleent.origin[1], 0);
  _id_E86632D645C137D0 = level.br_circle.dangercircleent.origin[2];

  if(isDefined(_id_819EDACDACB810E4) && isDefined(_id_E86632D645C137D0)) {
    _id_E28B0FBABCE791F1 = distance2d(self.origin, _id_819EDACDACB810E4);
    return _id_E86632D645C137D0 - _id_E28B0FBABCE791F1;
  }

  return undefined;
}

_id_92A5F74F5ACC64D9(callback) {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("last_stand_start");
  self[[callback]]();
}

_id_AF7551BF62570371(callback) {
  level endon("game_ended");
  self endon("disconnect");
  _id_3C16F726F502E7D8 = undefined;

  while(_id_3C16F726F502E7D8 == undefined) {
    foreach(player in level.players) {
      if(isalliedsentient(self, player) && !scripts\mp\utility\player::isreallyalive(player)) {
        _id_3C16F726F502E7D8 = player;
        break;
      }
    }

    waitframe();
  }

  [[callback]](_id_3C16F726F502E7D8);
}

_id_BA481C5CD3C4F5B4(_id_8CDF4FF04B7775EC, _id_DAD9B8459425C9D8) {
  thread _id_C6CC9D3A7ADFDA0F(_id_8CDF4FF04B7775EC, _id_DAD9B8459425C9D8);
}

_id_C6CC9D3A7ADFDA0F(_id_8CDF4FF04B7775EC, _id_DAD9B8459425C9D8) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("currentContextualTipCompleted");
  self endon("currentContextualTipAborted");

  if(isDefined(_id_DAD9B8459425C9D8))
    self[[_id_DAD9B8459425C9D8]]();

  while(!self isskydiving())
    waitframe();

  self[[_id_8CDF4FF04B7775EC]]();
  return;
}

_id_8C217F41A2B69BFE(_id_A7BC06075641900E, _id_C4BCD19C674B2B94, _id_8CDF4FF04B7775EC, _id_DAD9B8459425C9D8) {
  thread _id_632855E1721D2685(_id_A7BC06075641900E, _id_C4BCD19C674B2B94, _id_8CDF4FF04B7775EC, _id_DAD9B8459425C9D8);
}

_id_632855E1721D2685(_id_A7BC06075641900E, _id_C4BCD19C674B2B94, _id_8CDF4FF04B7775EC, _id_DAD9B8459425C9D8) {
  self endon("disconnect");
  level endon("game_ended");
  _id_D49294F78A5BD8B0 = 0;
  init_pos = self.origin;
  _id_DB1111B1B4C72B10 = self getplayerangles();

  while(!self _meth_3C6BB30AE7106B7A())
    waitframe();

  if(isDefined(_id_DAD9B8459425C9D8))
    self[[_id_DAD9B8459425C9D8]]();

  while(self isparachuting()) {
    _id_E4BF20377D250593 = distance((self.origin[0], self.origin[1], 0), (init_pos[0], init_pos[1], 0));
    _id_98BF6D2E08A18443 = distance(self getplayerangles(), _id_DB1111B1B4C72B10);

    if(_id_98BF6D2E08A18443 >= _id_C4BCD19C674B2B94 && _id_E4BF20377D250593 * 10 > _id_A7BC06075641900E) {
      _id_D49294F78A5BD8B0 = 1;
      break;
    }

    waitframe();
  }

  self[[_id_8CDF4FF04B7775EC]](_id_D49294F78A5BD8B0);
  return;
}

_id_6C19FA9B1A676FE5() {
  _id_2AB50AE603BC51CC();
}

_id_2AB50AE603BC51CC() {
  self endon("disconnect");
  level endon("game_ended");

  while(self _meth_3C6BB30AE7106B7A())
    waitframe();

  return;
}

_id_FF62C3AABF4C0BA8(_id_7EA2637582571067, _id_DAD9B8459425C9D8) {
  self endon("entitydeleted");
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, weapon);

    if(attacker != self && isDefined(_id_7EA2637582571067)) {
      self[[_id_7EA2637582571067]]();
      return;
    }
  }
}

_id_217FAB64BECD170A() {
  xp = self getplayerdata("common", "mpProgression", "playerLevel", "xp");
  return scripts\mp\rank::getrankforxp(xp);
}

_id_1E7A02EF17D58A96() {
  if(self _meth_E69D7896FA6E5D23())
    return 1;

  return 0;
}

_id_C3FF6825172B7E02(_id_6E8B41E0A5648F49) {
  thread _id_DC30E2F1A162D751(_id_6E8B41E0A5648F49);
}

_id_DC30E2F1A162D751(_id_6E8B41E0A5648F49) {
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", message, value);

    if(isDefined(message) && message == "ftue_redeploy_button_clicked") {
      self[[_id_6E8B41E0A5648F49]]();
      break;
    }
  }
}

_id_F0027CE50E5EF437(callback) {
  _id_F47EDDA71B7A6492(callback);
}

_id_F47EDDA71B7A6492(callback) {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", _id_7148C1A6F25491F8, class);

    if(_id_7148C1A6F25491F8 == "ftue_show_revive_ally_button") {
      self[[callback]]();
      return;
    }
  }
}

_id_79FF3EA7E538A94A(_id_F0EA4030349A33D5, callback) {
  _id_952F091BADFCDD5D(_id_F0EA4030349A33D5, callback);
}

_id_952F091BADFCDD5D(_id_F0EA4030349A33D5, callback) {
  self endon("death");
  self endon("disconnect");

  while(!isDefined(_id_F0EA4030349A33D5.inlaststand))
    waitframe();

  _id_F0EA4030349A33D5._id_726850F5D99BCE9B = 0;
  childthread _id_6B3D4945C8C99D87(_id_F0EA4030349A33D5, callback);

  for(;;) {
    if(isDefined(_id_F0EA4030349A33D5.isselfreviving))
      _id_F0EA4030349A33D5._id_726850F5D99BCE9B = _id_F0EA4030349A33D5.isselfreviving;

    waitframe();
  }
}

_id_6B3D4945C8C99D87(_id_F0EA4030349A33D5, callback) {
  _id_F0EA4030349A33D5 waittill("last_stand_finished");

  if(isalive(_id_F0EA4030349A33D5)) {
    _id_EB794C7D91BF0FA8 = !_id_F0EA4030349A33D5._id_726850F5D99BCE9B;
    self[[callback]](_id_EB794C7D91BF0FA8);
  } else
    self[[callback]](0);
}

_id_9B8F4317C9BEE442(_id_6E8B41E0A5648F49) {
  thread _id_CBF5DF364D883F3D(_id_6E8B41E0A5648F49);
}

_id_CBF5DF364D883F3D(_id_6E8B41E0A5648F49) {
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", message, value);

    if(isDefined(message) && message == "calloutmarkerping_added") {
      self[[_id_6E8B41E0A5648F49]]();
      break;
    }
  }
}

_id_000EBAAAC95A9DD6() {
  return self.health > 0;
}

_id_C104680EDEA6CF97() {
  return !_id_000EBAAAC95A9DD6();
}

_id_A44B57CF475CF6C1(value) {
  if(istrue(value))
    level.modifyplayerdamage = ::_id_210DA883891ACD05;
  else
    level.modifyplayerdamage = undefined;
}

_id_FAFEEFCC0DA64EE2() {
  return self isonground();
}

_id_F07EDBF622EEB7D9() {
  return _id_2CEDCC356F1B9FC8::hasselfrevivetoken();
}

_id_210DA883891ACD05(einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, _id_BE4285B26ED99AB1) {
  if(!isbot(victim)) {
    idamage = idamage * (victim.health / 200);

    if(victim.health - idamage <= 0)
      idamage = 0;
  }

  if(isbot(victim)) {
    if(isbot(eattacker) && smeansofdeath != "MOD_EXECUTION" && smeansofdeath != "MOD_EXPLOSIVE")
      idamage = 0;

    if(isDefined(victim._id_56ACA941817E8E68) && victim._id_56ACA941817E8E68)
      idamage = 0;
  }

  return idamage;
}

_id_BB62BA82AFFDD5C7() {
  self endon("disconnect");

  while(!self ismantling())
    waitframe();
}
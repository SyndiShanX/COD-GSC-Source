/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1ce31d513cb66606.gsc
***********************************************/

_id_055292AFCF3C3024() {
  if(_id_97F034F0AEF48475())
    level thread _id_5574114685EBC8C2();
}

_id_519C1E14CE8C964B() {
  if(_id_97F034F0AEF48475())
    level thread _id_A974AB5FE443E40B();
}

_id_97F034F0AEF48475() {
  _id_C73C76F949DA72C9 = _id_2C3C990BA58FA6F5::_id_D3915632A8C61EB2();
  _id_2238838C514CC1D6 = getdvarint("dvar_516A4B6F01A9BCDB", 0) == 1;
  _id_2989EF283CE6AC76 = isDefined(_id_C73C76F949DA72C9) && _id_C73C76F949DA72C9 > 0 && _id_2238838C514CC1D6;

  if(_id_2989EF283CE6AC76)
    return 1;

  return 0;
}

_id_7F788F4B6412959C(instance) {
  return isDefined(instance) && isDefined(instance.type) && instance.type == "brloot_ghosthunter_ghost";
}

_id_08FF59B0F0FA5F33() {
  return self.origin + (0, 0, 55);
}

_id_1C0CCDC70F0ECC03(_id_7500B1682A838D82) {
  if(!_id_7F788F4B6412959C(_id_7500B1682A838D82) || _id_0BC5103D793CE38A(_id_7500B1682A838D82, "eventGhost_model", "active")) {
    return;
  }
  _id_7500B1682A838D82.health = 80;
  _id_7500B1682A838D82 setscriptablepartstate("eventGhost_model", "inactive");
  _id_7500B1682A838D82 setscriptablepartstate("eventGhost", "inactive");
  level._id_A1C85A2BED5FAE8F[level._id_A1C85A2BED5FAE8F.size] = _id_7500B1682A838D82;
}

_id_9EF419D2CD40619C(targetpos) {
  _id_D30ABFE3380A9491 = spawnscriptable("brloot_ghosthunter_ghost", targetpos);
  _id_BF3C96C90A07B14B(_id_D30ABFE3380A9491);
}

_id_0BC5103D793CE38A(instance, _id_9EA36FE311744C61, _id_9E50CEF01527FF79) {
  state = instance getscriptablepartstate(_id_9EA36FE311744C61, 1);
  return isDefined(state) && state == _id_9E50CEF01527FF79;
}

_id_AD43D1C0FE6B1352(_id_7500B1682A838D82) {
  return !isDefined(_id_7500B1682A838D82.health) || _id_7500B1682A838D82.health <= 0;
}

_id_5574114685EBC8C2() {
  _id_E4A50C006FBCA0D3 = _id_E822B5EE44A827A8("prematch_done") && !_id_3C9CACEFBB0BBF48("prematch_done");

  if(_id_E4A50C006FBCA0D3)
    level waittill("prematch_done");

  level._id_9AD2CE81DED9F681 = [];
  level._id_A1C85A2BED5FAE8F = [];
  scripts\engine\scriptable::scriptable_adddamagedcallback(::_id_16CE386B55ABE2E7);

  if(!scripts\engine\utility::flag("scriptables_ready"))
    scripts\engine\utility::flag_wait("scriptables_ready");

  initfx();
  _id_FA0CA2E13606345A();
}

initfx() {
  level._effect["s6ghost_imp"] = loadfx("vfx/iw9/level/mp_saba/season6/hween/ghost/vfx_hween_ghost_impact.vfx");
}

_id_FA0CA2E13606345A() {
  _id_8B5BB6C5296C0BAD = getentitylessscriptablearray(undefined, undefined, undefined, undefined, "eventGhost_model");
  _id_8B5BB6C5296C0BAD = scripts\engine\utility::array_randomize(_id_8B5BB6C5296C0BAD);
  _id_68B20922E9B56EC9 = getdvarint("dvar_ADE9E67E9FD63353", 300);
  _id_D49E02BFFEF7EA8F = (-20633, -37061, 900);

  if(isDefined(_id_8B5BB6C5296C0BAD)) {
    _id_A613C247A30AE7BF = _id_8B5BB6C5296C0BAD;

    foreach(_id_3CEF84D10F889AEC in _id_A613C247A30AE7BF) {
      if(distance2d(_id_3CEF84D10F889AEC.origin, _id_D49E02BFFEF7EA8F) < 5000) {
        _id_BF3C96C90A07B14B(_id_3CEF84D10F889AEC);
        _id_8B5BB6C5296C0BAD = scripts\engine\utility::array_remove(_id_8B5BB6C5296C0BAD, _id_3CEF84D10F889AEC);
      }
    }

    foreach(_id_3CEF84D10F889AEC in _id_8B5BB6C5296C0BAD) {
      if(level._id_9AD2CE81DED9F681.size < _id_68B20922E9B56EC9) {
        waitframe();
        _id_BF3C96C90A07B14B(_id_3CEF84D10F889AEC);
        continue;
      }

      _id_1C0CCDC70F0ECC03(_id_3CEF84D10F889AEC);
    }

    level thread _id_06AD543B683858D9();
  }
}

_id_06AD543B683858D9() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isBRStyleGameType") && ![[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isBRStyleGameType")]]()) {
    return;
  }
  level endon("game_ended");

  while(level._id_9AD2CE81DED9F681.size > 0) {
    while(_id_7FE3D9DF64373188()) {
      foreach(_id_3CEF84D10F889AEC in level._id_9AD2CE81DED9F681) {
        if(_id_4500F0B09DA44A8C(_id_3CEF84D10F889AEC))
          thread _id_4E4A90F2D49A7F08(_id_3CEF84D10F889AEC);

        waitframe();
      }

      wait 1;
    }

    wait 1;
  }
}

_id_7FE3D9DF64373188() {
  if(isDefined(level._id_33A2175A9A4306BC))
    return 1;
  else if(isDefined(level.br_circle) && isDefined(level.br_circle.dangercircleent))
    return 1;

  return 0;
}

_id_4500F0B09DA44A8C(_id_3CEF84D10F889AEC) {
  if(isDefined(level._id_33A2175A9A4306BC))
    return scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "dmz_isPointInCircle") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "dmz_isPointInCircle")]](_id_3CEF84D10F889AEC.origin);
  else if(isDefined(level.br_circle))
    return scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "br_isPointInCircle") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "br_isPointInCircle")]](_id_3CEF84D10F889AEC.origin);

  return 0;
}

_id_A974AB5FE443E40B() {
  if(!scripts\engine\utility::flag("scriptables_ready"))
    scripts\engine\utility::flag_wait("scriptables_ready");

  array = scripts\engine\utility::getStructArray("event_soulghost", "targetname");
  array = scripts\engine\utility::array_randomize(array);

  if(array.size < 1) {
    return;
  }
  _id_62E50AD3144802A8 = 0;

  for(_id_62E50AD3144802A8 = _id_62E50AD3144802A8; _id_62E50AD3144802A8 < array.size / 2; _id_62E50AD3144802A8 = (_id_62E50AD3144802A8 + 1) % array.size)
    _id_9EF419D2CD40619C(array[_id_62E50AD3144802A8].origin);
}

_id_BF3C96C90A07B14B(_id_7500B1682A838D82) {
  if(!_id_7F788F4B6412959C(_id_7500B1682A838D82) || _id_0BC5103D793CE38A(_id_7500B1682A838D82, "eventGhost_model", "active")) {
    return;
  }
  _id_7500B1682A838D82.health = 80;
  _id_7342D9B11A2C7E61::_id_8E805DA4AEF86965(_id_7500B1682A838D82);
  _id_7500B1682A838D82 setscriptablepartstate("eventGhost_model", "active");
  _id_7500B1682A838D82 setscriptablepartstate("eventGhost", "start");
  level._id_9AD2CE81DED9F681[level._id_9AD2CE81DED9F681.size] = _id_7500B1682A838D82;
}

_id_9D1D0D19DEE73CF6() {
  if(level._id_A1C85A2BED5FAE8F.size > 0) {
    while(level._id_9AD2CE81DED9F681.size < 300 && level._id_A1C85A2BED5FAE8F.size > 0) {
      if(isDefined(level._id_A1C85A2BED5FAE8F[0]) && _id_4500F0B09DA44A8C(level._id_A1C85A2BED5FAE8F[0])) {
        level._id_A1C85A2BED5FAE8F[0] setscriptablepartstate("eventGhost_model", "death");
        level._id_A1C85A2BED5FAE8F = scripts\engine\utility::array_remove(level._id_A1C85A2BED5FAE8F, level._id_A1C85A2BED5FAE8F[0]);
      } else {
        _id_7342D9B11A2C7E61::_id_8E805DA4AEF86965(level._id_A1C85A2BED5FAE8F[0]);
        level._id_A1C85A2BED5FAE8F[0] setscriptablepartstate("eventGhost_model", "active");
        level._id_A1C85A2BED5FAE8F[0] setscriptablepartstate("eventGhost", "start");
        level._id_9AD2CE81DED9F681[level._id_9AD2CE81DED9F681.size] = level._id_A1C85A2BED5FAE8F[0];
        level._id_A1C85A2BED5FAE8F = scripts\engine\utility::array_remove(level._id_A1C85A2BED5FAE8F, level._id_A1C85A2BED5FAE8F[0]);
      }

      waitframe();
    }
  }
}

_id_EDEE0C776B4C4A90(_id_7500B1682A838D82) {
  waitframe();

  if(!_id_7F788F4B6412959C(_id_7500B1682A838D82)) {
    return;
  }
  _id_7500B1682A838D82 setscriptablepartstate("eventGhost", "death");
  _id_7500B1682A838D82.health = 0;
  level._id_9AD2CE81DED9F681 = scripts\engine\utility::array_remove(level._id_9AD2CE81DED9F681, _id_7500B1682A838D82);
  wait 2;
  level._id_CF22157205C34916._id_2B6807C7DF9A2B2D scripts\engine\utility::_id_9CD3F5F067AFEA37(_id_7500B1682A838D82);
  _id_9D1D0D19DEE73CF6();
}

_id_4E4A90F2D49A7F08(_id_7500B1682A838D82) {
  self notify("ghostThreadRestart");
  self endon("ghostThreadRestart");

  if(!isDefined(_id_7500B1682A838D82._id_6EE8D6E35FF13858))
    _id_7500B1682A838D82._id_6EE8D6E35FF13858 = gettime();

  while(gettime() - _id_7500B1682A838D82._id_6EE8D6E35FF13858 < 4000)
    waitframe();

  thread _id_EDEE0C776B4C4A90(_id_7500B1682A838D82);
}

_id_16CE386B55ABE2E7(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, _id_8BF74071A142B64C, modelindex, partname) {
  if(!isDefined(instance.type) || !_id_7F788F4B6412959C(instance) || _id_AD43D1C0FE6B1352(instance)) {
    return;
  }
  _id_A6BB61971108293A = _id_0BC5103D793CE38A(instance, "eventGhost", "instantkill");
  _id_6A9C810A6F4B119C = 0;
  dist = distance(eattacker.origin, instance.origin);

  if(!isDefined(eattacker) || !isPlayer(eattacker) || isagent(eattacker) || isai(eattacker) || !isDefined(objweapon) || !isDefined(smeansofdeath))
    _id_6A9C810A6F4B119C = 1;
  else if(!scripts\engine\utility::isbulletdamage(smeansofdeath) && smeansofdeath != "MOD_EXPLOSIVE_BULLET")
    _id_6A9C810A6F4B119C = 1;
  else if(_id_F61CFF69DF2C246C(objweapon))
    _id_6A9C810A6F4B119C = 1;
  else if(scripts\cp_mp\crossbow::_id_B7F3D4ED89F15341(objweapon))
    idamage = 80;
  else if(eattacker playerads() <= 0.5 || !_func_9007AB23326221A2(objweapon)) {
    if(eattacker playerads() <= 0.5)
      maxdist = 760;
    else {
      _id_0F57AC895DB887C6 = eattacker playergetzoomfov();
      _id_CCBBA16287668F0A = scripts\engine\math::normalize_value(11, 65, _id_0F57AC895DB887C6);
      _id_CCBBA16287668F0A = scripts\engine\math::normalized_float_smooth_out(_id_CCBBA16287668F0A);
      maxdist = scripts\engine\math::factor_value(1400, 760, _id_CCBBA16287668F0A);
    }

    if(dist > maxdist)
      _id_6A9C810A6F4B119C = 1;
  }

  if(_id_6A9C810A6F4B119C) {
    if(_id_A6BB61971108293A)
      instance setscriptablepartstate("eventGhost", "beforeInstantKill");

    return;
  }

  if(!isDefined(instance.health))
    instance.health = 80;

  instance.health = instance.health - idamage;
  playvfx("s6ghost_imp", _id_8BF74071A142B64C, vdir, undefined);

  if(_id_AD43D1C0FE6B1352(instance) || _id_A6BB61971108293A) {
    thread _id_EDEE0C776B4C4A90(instance);
    position = instance.origin + (0, 0, 55);
    thread _id_B19BDDFA736B37C0(eattacker, smeansofdeath, objweapon, position, instance);
  }

  _id_C1112D9A43F9FF52(instance, eattacker);
}

_id_F61CFF69DF2C246C(objweapon) {
  if(objweapon.basename == "iw9_laser_large_ir_mp")
    return 1;

  return 0;
}

_id_B19BDDFA736B37C0(eattacker, smeansofdeath, objweapon, position, instance) {
  if(getdvarint("dvar_B7AA1FDC2FFB47E8", 0) == 1 && scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_loot_soul_trophy", "onGhostDeath")) {
    wait 0.4;
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_loot_soul_trophy", "onGhostDeath")]](eattacker, smeansofdeath, objweapon, position, instance);
  } else if(_id_0CBB0697DE4C5728::_id_4AE1058D4433F19D(eattacker))
    eattacker thread _id_7342D9B11A2C7E61::_id_909186CE6AB7BD3B(position, 0);
}

playvfx(fx, position, direction, playerent) {
  if(isDefined(playerent))
    playFX(level._effect[fx], position, direction, undefined, playerent);
  else
    playFX(level._effect[fx], position, direction);
}

_id_C1112D9A43F9FF52(_id_3CEF84D10F889AEC, attacker) {
  if(!isDefined(attacker) || !isDefined(_id_3CEF84D10F889AEC)) {
    return;
  }
  if(isDefined(attacker.owner) && isPlayer(attacker.owner))
    attacker = attacker.owner;

  if(!isPlayer(attacker)) {
    return;
  }
  attacker _id_5762AC2F22202BA2::updatedamagefeedback("default", _id_AD43D1C0FE6B1352(_id_3CEF84D10F889AEC), 0, "standard", 0, 1);
}

_id_E822B5EE44A827A8(flagname) {
  return isDefined(game["flags"]) && isDefined(game["flags"][flagname]);
}

_id_3C9CACEFBB0BBF48(flagname) {
  return game["flags"][flagname];
}
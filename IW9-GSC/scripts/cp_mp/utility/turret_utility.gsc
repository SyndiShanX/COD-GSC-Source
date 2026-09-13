/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\turret_utility.gsc
****************************************************/

_id_770A14E56B03B067(turret, _id_8826C6BC694729C5, _id_F537B27C366F06C9, _id_9C8DD41525B291D5, _id_693B7B6938CB597E, _id_9A5FFE4775714312, _id_DA50AB9753C3AE26, _id_4A44B8EF4D9CBA92, _id_1833609413F67DE7, _id_1C58DD8C5CA65897, _id_A4BF19053A661FC5) {
  if(!isDefined(turret))
    return undefined;

  _id_D6FBA8ED3D4C1219 = _id_E1424AC9314FD672(turret, _id_8826C6BC694729C5, _id_F537B27C366F06C9, _id_9C8DD41525B291D5, _id_693B7B6938CB597E, _id_DA50AB9753C3AE26, _id_4A44B8EF4D9CBA92, _id_1C58DD8C5CA65897, _id_A4BF19053A661FC5);
  _id_88C2B48BA3714B8E = undefined;
  _id_97E45AB250562D16 = undefined;

  foreach(targetdata in _id_D6FBA8ED3D4C1219) {
    targetplayer = _id_70B8756E9FC03C44(targetdata);

    if(!_id_10F997ED68F4FCEF(turret, targetplayer, _id_8826C6BC694729C5, _id_F537B27C366F06C9, _id_9C8DD41525B291D5, _id_693B7B6938CB597E, _id_DA50AB9753C3AE26, _id_4A44B8EF4D9CBA92, _id_1C58DD8C5CA65897, _id_A4BF19053A661FC5)) {
      continue;
    }
    targetvehicle = _id_0EFFEBB9076EFBDB(targetdata);
    _id_75D604BCB71DDDD1 = turret;
    _id_4BACD07AC9B43431 = turret getlinkedparent();

    if(isDefined(_id_4BACD07AC9B43431))
      _id_75D604BCB71DDDD1 = _id_4BACD07AC9B43431;

    angle = abs(vectortoangles(targetplayer.origin - _id_75D604BCB71DDDD1.origin)[1]);
    _id_5859F08FC82143F7 = abs(_id_75D604BCB71DDDD1 gettagangles("tag_origin")[1]);
    angle = abs(angle - _id_5859F08FC82143F7);

    if(!istrue(_id_1833609413F67DE7)) {
      _id_D6E9347C3618A5BB = targetplayer getweaponslistitems();

      foreach(weapon in _id_D6E9347C3618A5BB) {
        _id_C0B9C9A4FA4EEF84 = weaponclass(weapon);

        if(_id_C0B9C9A4FA4EEF84 == "rocketlauncher")
          angle = angle - 40;
      }
    }

    if(isDefined(targetvehicle)) {
      _id_9E6B52E2227B1D6B = 1;
      angle = angle + 20;
    }

    if(!isDefined(_id_88C2B48BA3714B8E) || _id_88C2B48BA3714B8E > angle) {
      _id_88C2B48BA3714B8E = angle;
      _id_97E45AB250562D16 = targetdata;
    }
  }

  if(isDefined(_id_97E45AB250562D16) && isDefined(_id_9A5FFE4775714312))
    turret thread _id_9598D2DCFC423F60(_id_97E45AB250562D16, _id_9A5FFE4775714312);

  return _id_97E45AB250562D16;
}

_id_E59541944F1A4FE5(turret, targetdata) {
  if(!isDefined(turret)) {
    return;
  }
  turret.currenttarget = _id_70B8756E9FC03C44(targetdata);
}

_id_DFAE8A6885A8537C(turret) {
  if(!isDefined(turret)) {
    return;
  }
  turret.currenttarget = undefined;
}

_id_46C1EA4A69AD33D6(turret, _id_9E50CEF01527FF79) {
  if(!isDefined(turret)) {
    return;
  }
  turret._id_9E50CEF01527FF79 = _id_9E50CEF01527FF79;
}

_id_7E4458965893599A(turret) {
  if(!isDefined(turret)) {
    return;
  }
  if(!isDefined(turret._id_9E50CEF01527FF79)) {}

  return turret._id_9E50CEF01527FF79;
}

_id_20E6F4D27C8040BD(turret) {
  return isDefined(turret) && isDefined(turret.currenttarget);
}

_id_BC2021C62B0D43CC(turret, target) {
  _id_9ACD3989A7189886 = 0;

  if(!isDefined(target))
    return 0;

  currenttarget = _id_2ADFF40B591B5758(turret);

  if(isDefined(currenttarget) && currenttarget == target)
    _id_9ACD3989A7189886 = 1;

  return _id_9ACD3989A7189886;
}

_id_2ADFF40B591B5758(turret) {
  return scripts\engine\utility::ter_op(_id_20E6F4D27C8040BD(turret), turret.currenttarget, undefined);
}

_id_70B8756E9FC03C44(targetdata) {
  if(!isDefined(targetdata)) {
    return;
  }
  return targetdata.targetplayer;
}

_id_0EFFEBB9076EFBDB(targetdata) {
  if(!isDefined(targetdata)) {
    return;
  }
  return targetdata.targetvehicle;
}

_id_F6F04FC4E42CF2C4(turret, _id_BD73C7ACC56CD20C, _id_935BA61E1C5C6320) {
  _id_C3FBB6661B91750F = _id_72017FC448D5C9A0();
  _id_B9D5783A4F34EFBC = [turret];
  _id_15C3C1D963654F89 = 0;

  if(istrue(_id_935BA61E1C5C6320)) {
    _id_15C3C1D963654F89 = _id_BD73C7ACC56CD20C scripts\cp_mp\utility\player_utility::isinvehicle();

    if(istrue(_id_15C3C1D963654F89)) {
      _id_281DEDD57C723E4F = _id_BD73C7ACC56CD20C scripts\cp_mp\utility\player_utility::getvehicle();
      _id_B9D5783A4F34EFBC[_id_B9D5783A4F34EFBC.size] = _id_281DEDD57C723E4F;
      _id_53023FDA76FA64FE = _id_281DEDD57C723E4F getlinkedchildren();

      if(isDefined(_id_53023FDA76FA64FE) && _id_53023FDA76FA64FE.size > 0)
        _id_B9D5783A4F34EFBC = scripts\engine\utility::array_combine(_id_B9D5783A4F34EFBC, _id_53023FDA76FA64FE);
    }
  }

  _id_8BC64C989AE0D63E = [];

  if(isPlayer(_id_BD73C7ACC56CD20C) || isagent(_id_BD73C7ACC56CD20C)) {
    _id_295719F06C03407F = _id_BD73C7ACC56CD20C gettagorigin("j_head");

    if(isDefined(_id_295719F06C03407F))
      _id_8BC64C989AE0D63E[_id_8BC64C989AE0D63E.size] = _id_295719F06C03407F;

    midpos = _id_BD73C7ACC56CD20C gettagorigin("j_mainroot");

    if(isDefined(midpos))
      _id_8BC64C989AE0D63E[_id_8BC64C989AE0D63E.size] = midpos;
  }

  _id_8BC64C989AE0D63E[_id_8BC64C989AE0D63E.size] = _id_BD73C7ACC56CD20C.origin;
  canseetarget = 0;
  _id_4224C4FE61A423F0 = turret gettagorigin("tag_barrel");

  foreach(_id_937C2383212D492F in _id_8BC64C989AE0D63E) {
    canseetarget = scripts\engine\trace::ray_trace_passed(_id_4224C4FE61A423F0, _id_937C2383212D492F, _id_B9D5783A4F34EFBC, _id_C3FBB6661B91750F);

    if(istrue(canseetarget)) {
      break;
    }

    wait 0.05;
  }

  return canseetarget;
}

_id_F6926785E402B9FE(targetdata) {
  return istrue(targetdata._id_9E6B52E2227B1D6B);
}

_id_D463678CCF4BEEDA(targetdata) {
  return istrue(targetdata._id_EF401B2016B3518B);
}

_id_BEBD2D48CA6C8A31(targetdata) {
  return istrue(targetdata._id_EBD7809CAF7CF3B0);
}

_id_BB61346FDA4278E5(turret, target, _id_A545C521308D6B1E, _id_918144AECEA97537) {
  if(!_id_20E6F4D27C8040BD(turret) && !isDefined(target))
    return 0;

  currenttarget = _id_2ADFF40B591B5758(turret);

  if(isDefined(target))
    currenttarget = target;

  _id_7B59B41B01684053 = currenttarget.origin;

  if(isDefined(_id_A545C521308D6B1E))
    _id_7B59B41B01684053 = currenttarget gettagorigin(_id_A545C521308D6B1E);

  if(!isDefined(_id_918144AECEA97537))
    _id_918144AECEA97537 = 10;

  _id_929AD65D451FFC68 = anglesToForward(turret gettagangles("tag_flash"));
  _id_EFA57ADC48838F9B = _id_7B59B41B01684053 - turret gettagorigin("tag_flash");
  _id_077B9E4B599269EB = scripts\engine\math::anglebetweenvectors(_id_929AD65D451FFC68, _id_EFA57ADC48838F9B);

  if(_id_077B9E4B599269EB <= _id_918144AECEA97537)
    return 1;

  return 0;
}

_id_E1424AC9314FD672(turret, _id_8826C6BC694729C5, _id_F537B27C366F06C9, _id_9C8DD41525B291D5, _id_693B7B6938CB597E, _id_DA50AB9753C3AE26, _id_4A44B8EF4D9CBA92, _id_1C58DD8C5CA65897, _id_A4BF19053A661FC5) {
  turret endon("death");
  level endon("game_ended");

  if(!isDefined(_id_8826C6BC694729C5))
    _id_8826C6BC694729C5 = 5000;

  _id_C28ABA0392B80C26 = _id_F28FD019A7657543(turret, _id_8826C6BC694729C5);
  _id_244E4FC365DBD24F = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C28ABA0392B80C26.size; _id_AC0E594AC96AA3A8++) {
    targetdata = _id_C836479731703B1B(turret, _id_C28ABA0392B80C26[_id_AC0E594AC96AA3A8], _id_8826C6BC694729C5, _id_F537B27C366F06C9, _id_9C8DD41525B291D5, _id_693B7B6938CB597E, _id_DA50AB9753C3AE26, _id_4A44B8EF4D9CBA92, _id_1C58DD8C5CA65897, _id_A4BF19053A661FC5);

    if(isDefined(targetdata))
      _id_244E4FC365DBD24F[_id_244E4FC365DBD24F.size] = targetdata;
    else
      continue;

    wait 0.05;
  }

  return _id_244E4FC365DBD24F;
}

_id_F28FD019A7657543(turret, _id_8826C6BC694729C5) {
  _id_F6EB2388BA101E7C = [];

  if(scripts\common\utility::iscp()) {
    _id_5C882C8F7BB9C72A = level.players;
    _id_CD207438E3E764E6 = [];

    if(isDefined(level.agentarray))
      _id_CD207438E3E764E6 = level.agentarray;

    _id_F6EB2388BA101E7C = scripts\engine\utility::array_combine(_id_CD207438E3E764E6, _id_5C882C8F7BB9C72A);
  } else
    _id_F6EB2388BA101E7C = scripts\common\utility::_id_2D7FD59D039FA69B(turret.origin, _id_8826C6BC694729C5);

  return _id_F6EB2388BA101E7C;
}

_id_72017FC448D5C9A0() {
  _id_7DC3241E7F3C6B24 = 0;
  world = 1;
  glass = 0;
  _id_97D66CB843A8EC8F = 1;
  item = 0;
  vehicle = 1;
  _id_41E4FE254D4402FA = 0;
  _id_8DD8E0F7C10BDCB9 = 1;
  _id_A1AD41E5813E2B9C = 1;
  return scripts\engine\trace::create_contents(_id_7DC3241E7F3C6B24, world, glass, _id_97D66CB843A8EC8F, item, vehicle, _id_41E4FE254D4402FA, _id_8DD8E0F7C10BDCB9, _id_A1AD41E5813E2B9C);
}

_id_C836479731703B1B(turret, _id_BD73C7ACC56CD20C, _id_8826C6BC694729C5, _id_F537B27C366F06C9, _id_9C8DD41525B291D5, _id_693B7B6938CB597E, _id_DA50AB9753C3AE26, _id_4A44B8EF4D9CBA92, _id_1C58DD8C5CA65897, _id_A4BF19053A661FC5) {
  turret endon("death");

  if(!_id_10F997ED68F4FCEF(turret, _id_BD73C7ACC56CD20C, _id_8826C6BC694729C5, _id_F537B27C366F06C9, _id_9C8DD41525B291D5, _id_693B7B6938CB597E, _id_DA50AB9753C3AE26, _id_4A44B8EF4D9CBA92, _id_1C58DD8C5CA65897, _id_A4BF19053A661FC5))
    return undefined;

  targetdata = _id_0371B6C83926FF36();
  canseetarget = _id_F6F04FC4E42CF2C4(turret, _id_BD73C7ACC56CD20C, _id_F537B27C366F06C9);
  _id_15C3C1D963654F89 = undefined;
  _id_281DEDD57C723E4F = undefined;

  if(istrue(_id_F537B27C366F06C9)) {
    _id_15C3C1D963654F89 = _id_BD73C7ACC56CD20C scripts\cp_mp\utility\player_utility::isinvehicle();

    if(istrue(_id_15C3C1D963654F89))
      _id_281DEDD57C723E4F = _id_BD73C7ACC56CD20C scripts\cp_mp\utility\player_utility::getvehicle();
  }

  if(istrue(canseetarget)) {
    targetdata.targetplayer = _id_BD73C7ACC56CD20C;
    targetdata.targetvehicle = scripts\engine\utility::ter_op(isDefined(_id_281DEDD57C723E4F), _id_281DEDD57C723E4F, undefined);
    targetdata._id_9E6B52E2227B1D6B = istrue(_id_F537B27C366F06C9) && istrue(_id_15C3C1D963654F89) && isDefined(_id_281DEDD57C723E4F);
    targetdata._id_EF401B2016B3518B = istrue(_id_9C8DD41525B291D5);
    targetdata._id_EBD7809CAF7CF3B0 = istrue(_id_693B7B6938CB597E);
  }

  return targetdata;
}

_id_10F997ED68F4FCEF(turret, _id_BD73C7ACC56CD20C, _id_8826C6BC694729C5, _id_F537B27C366F06C9, _id_9C8DD41525B291D5, _id_693B7B6938CB597E, _id_DA50AB9753C3AE26, _id_4A44B8EF4D9CBA92, _id_1C58DD8C5CA65897, _id_A4BF19053A661FC5) {
  if(!isDefined(_id_BD73C7ACC56CD20C))
    return 0;

  _id_39FEA08436A97E8A = turret.team;

  if(isDefined(_id_4A44B8EF4D9CBA92))
    _id_39FEA08436A97E8A = _id_4A44B8EF4D9CBA92;

  if(isPlayer(_id_BD73C7ACC56CD20C)) {
    if(!_id_52CDA0ABB7F78D63(_id_BD73C7ACC56CD20C))
      return 0;

    if(isDefined(self.owner) && _id_BD73C7ACC56CD20C == self.owner)
      return 0;

    _id_DA8CEC9BCE12F9CB = _id_BD73C7ACC56CD20C.pers["team"];

    if(_id_DA8CEC9BCE12F9CB == "spectator")
      return 0;

    if(isDefined(level.teambased)) {
      if(!isDefined(_id_DA8CEC9BCE12F9CB))
        return 0;

      if(isDefined(_id_39FEA08436A97E8A) && !istrue(_id_1C58DD8C5CA65897)) {
        if(level.teambased && _id_DA8CEC9BCE12F9CB == _id_39FEA08436A97E8A)
          return 0;
      }
    }
  }

  if(isagent(_id_BD73C7ACC56CD20C)) {
    if(!isalive(_id_BD73C7ACC56CD20C))
      return 0;

    if(isDefined(_id_BD73C7ACC56CD20C.agent_type) && issubstr(_id_BD73C7ACC56CD20C.agent_type, "civilian"))
      return 0;

    _id_DA8CEC9BCE12F9CB = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(_id_BD73C7ACC56CD20C, "team");

    if(isDefined(_id_39FEA08436A97E8A) && !istrue(_id_A4BF19053A661FC5)) {
      if(isDefined(_id_DA8CEC9BCE12F9CB) && _id_DA8CEC9BCE12F9CB == _id_39FEA08436A97E8A)
        return 0;
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
    if(_id_BD73C7ACC56CD20C[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_blindeye"))
      return 0;
  }

  if(isDefined(_id_8826C6BC694729C5)) {
    if(distancesquared(turret.origin, _id_BD73C7ACC56CD20C.origin) > _id_8826C6BC694729C5 * _id_8826C6BC694729C5)
      return 0;
  }

  if(istrue(_id_BD73C7ACC56CD20C scripts\cp_mp\utility\player_utility::isinvehicle()) && !istrue(_id_F537B27C366F06C9))
    return 0;

  if(istrue(_id_BD73C7ACC56CD20C.inlaststand) && !istrue(_id_9C8DD41525B291D5))
    return 0;

  if(scripts\cp_mp\parachute::isparachutegametype() && (_id_BD73C7ACC56CD20C isparachuting() || _id_BD73C7ACC56CD20C isskydiving()) && !istrue(_id_693B7B6938CB597E))
    return 0;

  return 1;
}

_id_52CDA0ABB7F78D63(player) {
  return isDefined(player) && player scripts\cp_mp\utility\player_utility::_isalive() && player.sessionstate == "playing";
}

_id_0371B6C83926FF36() {
  targetdata = spawnStruct();
  targetdata.targetplayer = undefined;
  targetdata.targetvehicle = undefined;
  targetdata._id_9E6B52E2227B1D6B = 0;
  targetdata._id_EF401B2016B3518B = 0;
  targetdata._id_EBD7809CAF7CF3B0 = 0;
  return targetdata;
}

_id_9598D2DCFC423F60(targetdata, _id_9A5FFE4775714312) {
  self endon("death");
  _id_E59541944F1A4FE5(self, targetdata);
  thread _id_7826E8E1BD494568(_id_70B8756E9FC03C44(targetdata), "death_or_disconnect");

  if(isDefined(_id_9A5FFE4775714312))
    thread _id_7826E8E1BD494568(self, _id_9A5FFE4775714312);

  self waittill("clear_turret_target");
  _id_DFAE8A6885A8537C(self);
}

_id_7826E8E1BD494568(ent, _id_70687E0CC558A009) {
  self endon("death");
  self endon("clear_turret_target");
  ent waittill(_id_70687E0CC558A009);
  self notify("clear_turret_target");
}
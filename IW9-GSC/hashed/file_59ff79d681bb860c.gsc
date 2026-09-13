/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_59ff79d681bb860c.gsc
***********************************************/

_id_21B2D65575E9C0CC(_id_A4273E17F90BFBE6) {
  self._id_89DAB0876DC8A170 = 1;
  _id_72AF5A878A9D3397::_id_03283FDAC29887DE();
  scripts\mp\bots\bots::_id_81C6C4218188E7D8();
  scripts\mp\bots\bots_util::bot_set_personality("run_and_gun");

  if(!isDefined(self._id_E2055BF088954E86))
    self._id_E2055BF088954E86 = _id_15782EAEB4AB0963();

  _id_142B713A2846F9AC("Spawned");
  _id_1E8FE34F5DFDEA49(_id_A4273E17F90BFBE6);
  self botsetflag("disable_random_goal", 1);
  self botsetflag("allow_slide_for_any_script_goal", 1);
  self botsetflag("ignore_script_weapon", 1);
  _id_0D74AE0B4AA21186::initialize();
}

_id_D55289CEEC7CF934() {
  _id_11BFC6B0E47D4408 = level._id_EEB46E40D3DFD8BE;

  if(!isDefined(_id_11BFC6B0E47D4408)) {
    _id_8C5D55B0EAD80ABF = getdvarfloat("dvar_60AE0D4490076046", 1);
    _id_35E09D79AE15A095 = getdvarfloat("dvar_55CCAB727E144F34", 0);
    _id_7AAC57EFD078C334 = getdvarfloat("dvar_B3F66372FB38FCCB", 0);
    _id_B5873813DD27A2F2 = getdvarfloat("dvar_FF9490C8B80CF74F", 0);
    _id_F8793C23A0EC47AB = _id_8C5D55B0EAD80ABF + _id_35E09D79AE15A095 + _id_7AAC57EFD078C334 + _id_B5873813DD27A2F2;
    _id_11BFC6B0E47D4408 = spawnStruct();
    _id_11BFC6B0E47D4408._id_85EC8C8FB7E29D44 = _id_8C5D55B0EAD80ABF / _id_F8793C23A0EC47AB;
    _id_11BFC6B0E47D4408._id_3191BFDECBF41AAE = _id_35E09D79AE15A095 / _id_F8793C23A0EC47AB + _id_11BFC6B0E47D4408._id_85EC8C8FB7E29D44;
    _id_11BFC6B0E47D4408._id_A206039EE7E144AD = _id_7AAC57EFD078C334 / _id_F8793C23A0EC47AB + _id_11BFC6B0E47D4408._id_3191BFDECBF41AAE;
    _id_11BFC6B0E47D4408._id_62F1BE7958898E07 = _id_B5873813DD27A2F2 / _id_F8793C23A0EC47AB + _id_11BFC6B0E47D4408._id_A206039EE7E144AD;
    level._id_EEB46E40D3DFD8BE = _id_11BFC6B0E47D4408;
  }

  _id_4084C1D43F28940F = randomfloat(1);

  if(_id_4084C1D43F28940F < _id_11BFC6B0E47D4408._id_85EC8C8FB7E29D44)
    return "recruit";
  else if(_id_4084C1D43F28940F < _id_11BFC6B0E47D4408._id_3191BFDECBF41AAE)
    return "regular";
  else if(_id_4084C1D43F28940F < _id_11BFC6B0E47D4408._id_A206039EE7E144AD)
    return "hardened";
  else if(_id_4084C1D43F28940F < _id_11BFC6B0E47D4408._id_62F1BE7958898E07)
    return "veteran";
  else
    return "regular";
}

_id_15782EAEB4AB0963() {
  _id_87ACBAB9A27B0757 = level._id_3C59090EE220AB3D._id_87ACBAB9A27B0757;
  _id_063A7BA4C102C8FD = randomfloat(1);
  _id_47B598F3FF58A345 = 0;

  foreach(name, personality in _id_87ACBAB9A27B0757) {
    _id_47B598F3FF58A345 = _id_47B598F3FF58A345 + personality._id_F7A0E9390034C85B;

    if(_id_063A7BA4C102C8FD < _id_47B598F3FF58A345)
      return name;
  }

  return undefined;
}

_id_76BA0B66F2A5EF09(bot) {
  _id_C6895F82ADEC6365 = 0.3;
  _id_CCBBA16287668F0A = 0;
  _id_672CD2A44615CD4D = _id_C6895F82ADEC6365;

  switch (bot botgetdifficulty()) {
    case "recruit":
      _id_CCBBA16287668F0A = getdvarfloat("dvar_27C78D2661500E49", _id_CCBBA16287668F0A);
      _id_672CD2A44615CD4D = getdvarfloat("dvar_C6DB8F289A513376", _id_672CD2A44615CD4D);
      break;
    case "regular":
      _id_CCBBA16287668F0A = getdvarfloat("dvar_1AB2939C54EFAB3F", _id_CCBBA16287668F0A);
      _id_672CD2A44615CD4D = getdvarfloat("dvar_71720D5FDA9ADA04", _id_672CD2A44615CD4D);
      break;
    case "hardened":
      _id_CCBBA16287668F0A = getdvarfloat("dvar_3FE6928216982556", _id_CCBBA16287668F0A);
      _id_672CD2A44615CD4D = getdvarfloat("dvar_D3F0C08B944E8C3B", _id_672CD2A44615CD4D);
      break;
    case "veteran":
      _id_CCBBA16287668F0A = getdvarfloat("dvar_9EE861DF3EE7281C", _id_CCBBA16287668F0A);
      _id_672CD2A44615CD4D = getdvarfloat("dvar_CC3A6AAB020970DF", _id_672CD2A44615CD4D);
      break;
    default:
      break;
  }

  return (_id_CCBBA16287668F0A, _id_672CD2A44615CD4D, 0);
}

_id_0D111733407F6518(meansofdeath, victim, attacker, damage, _id_498A2226E5AA47EE, _id_DFABE685A74F1B33) {
  meansofdeath = scripts\engine\utility::_id_53C4C53197386572(meansofdeath, "");

  if(meansofdeath == "MOD_TRIGGER_HURT" && isDefined(victim) && istrue(victim._id_76B390D02672ECEA))
    return 0;

  _id_DA6AC2EACBAD4A17 = isDefined(attacker) && isbot(attacker);

  if(!_id_DA6AC2EACBAD4A17)
    return damage;

  _id_5C83E2A7751CF1FE = isDefined(victim) && isPlayer(victim) && !isbot(victim);

  if(_id_5C83E2A7751CF1FE)
    _id_6C8D21B2E54B2478 = _id_4BE81427CC9844C4(attacker, victim, _id_498A2226E5AA47EE);
  else if(istrue(_id_DFABE685A74F1B33)) {
    _id_AFCEA1A9DDCD5ADC = 0.7;
    _id_6C8D21B2E54B2478 = getdvarfloat("dvar_72DCE163D860183A", _id_AFCEA1A9DDCD5ADC);
  } else {
    _id_9E653CD64BAD1CBC = 1.5;
    _id_6C8D21B2E54B2478 = getdvarfloat("dvar_19B1DEEE03B39DCE", _id_9E653CD64BAD1CBC);
  }

  return damage * _id_6C8D21B2E54B2478;
}

_id_4BE81427CC9844C4(_id_81C9E961CBE1A2AB, _id_BD4B60A1D502ED7E, _id_498A2226E5AA47EE) {
  health = _id_BD4B60A1D502ED7E.health;
  maxhealth = _id_BD4B60A1D502ED7E.maxhealth;

  if(istrue(_id_498A2226E5AA47EE)) {
    if(isDefined(_id_BD4B60A1D502ED7E._id_8790C077C95DB752)) {
      if(_id_BD4B60A1D502ED7E _id_07C40FA80892A721::hasarmor())
        health = health + _id_BD4B60A1D502ED7E _id_07C40FA80892A721::_id_AC266FC218266D08();

      maxhealth = maxhealth + _id_BD4B60A1D502ED7E._id_8790C077C95DB752;
    }
  }

  _id_47D36F3CB2120A2B = health / maxhealth;
  _id_CCBBA16287668F0A = 0;
  _id_672CD2A44615CD4D = 0;
  _id_2AE0FCCD506B8B92 = 1;

  if(istrue(_id_498A2226E5AA47EE)) {
    result = _id_40E63DD222434655::_id_A12DE8D6FA23A4D9();

    if(isDefined(result)) {
      _id_CCBBA16287668F0A = result[1];
      _id_672CD2A44615CD4D = result[2];
      _id_2AE0FCCD506B8B92 = 0;
    }
  }

  if(_id_2AE0FCCD506B8B92) {
    result = _id_76BA0B66F2A5EF09(_id_81C9E961CBE1A2AB);
    _id_CCBBA16287668F0A = result[0];
    _id_672CD2A44615CD4D = result[1];
  }

  return _id_47D36F3CB2120A2B * _id_CCBBA16287668F0A + _id_672CD2A44615CD4D;
}

_id_7D92B857142DBDC6(_id_50ADE409B1E5EFCB, team, _id_46C357E31A65AF85, _id_A018DF45312BA50F, _id_00DFC67EAAF62BC0) {
  _id_F1B03FFE289C1025 = gettime() + 15000;
  _id_0103A2009F383A1A = _id_50ADE409B1E5EFCB.size;
  _id_821516DC10EC00F0 = [];
  _id_B5C135EE4E1CDAA6 = _id_821516DC10EC00F0.size;

  while(level.players.size < scripts\mp\bots\bots_util::bot_get_client_limit() && _id_821516DC10EC00F0.size < _id_0103A2009F383A1A && gettime() < _id_F1B03FFE289C1025) {
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.05);
    bot = addbot(_id_50ADE409B1E5EFCB[_id_B5C135EE4E1CDAA6].name);

    if(!isDefined(bot)) {
      if(isDefined(_id_A018DF45312BA50F) && _id_A018DF45312BA50F) {
        if(isDefined(_id_00DFC67EAAF62BC0))
          self notify(_id_00DFC67EAAF62BC0);

        return [];
      }

      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
      continue;
    } else {
      _id_89A675C5BDE8848F = _id_50ADE409B1E5EFCB[_id_B5C135EE4E1CDAA6];

      if(istrue(_id_89A675C5BDE8848F._id_B4ADDE4C68BB0F24))
        _id_4C9BD9A3BF3F8CF7::_id_B9C4A50390B0B5EB(bot, _id_89A675C5BDE8848F);

      bot _id_72AF5A878A9D3397::_id_03283FDAC29887DE();
      bot.xuid = bot scripts\mp\bots\bots::_id_81C6C4218188E7D8();
      _id_F4842A7333F0853B = spawnStruct();
      _id_F4842A7333F0853B.bot = bot;
      _id_F4842A7333F0853B.ready = 0;
      _id_F4842A7333F0853B.abort = 0;
      _id_F4842A7333F0853B.index = _id_B5C135EE4E1CDAA6;
      _id_F4842A7333F0853B.difficulty = _id_89A675C5BDE8848F.difficulty;
      _id_F4842A7333F0853B._id_E2055BF088954E86 = _id_89A675C5BDE8848F._id_E2055BF088954E86;
      _id_F4842A7333F0853B._id_B5517A8D74ED63A3 = _id_89A675C5BDE8848F.squad;
      _id_821516DC10EC00F0[_id_821516DC10EC00F0.size] = _id_F4842A7333F0853B;
      _id_9FD2318F44F79283 = scripts\engine\utility::ter_op(isDefined(team), team, _id_89A675C5BDE8848F.team);
      _id_F4842A7333F0853B.bot thread scripts\mp\bots\bots::spawn_bot_latent(_id_9FD2318F44F79283, _id_46C357E31A65AF85, _id_F4842A7333F0853B);
      _id_B5C135EE4E1CDAA6++;
    }
  }

  _id_65C7BCBB8685EFC3 = 0;
  _id_F1B03FFE289C1025 = gettime() + 60000;

  while(_id_65C7BCBB8685EFC3 < _id_821516DC10EC00F0.size && gettime() < _id_F1B03FFE289C1025) {
    _id_65C7BCBB8685EFC3 = 0;

    foreach(_id_F4842A7333F0853B in _id_821516DC10EC00F0) {
      if(_id_F4842A7333F0853B.ready || _id_F4842A7333F0853B.abort)
        _id_65C7BCBB8685EFC3++;
    }

    wait 0.05;
  }

  _id_43EF75C950ADAB71 = [];

  foreach(_id_F4842A7333F0853B in _id_821516DC10EC00F0) {
    if(isDefined(_id_F4842A7333F0853B.bot))
      _id_43EF75C950ADAB71[_id_43EF75C950ADAB71.size] = _id_F4842A7333F0853B.bot;
  }

  if(isDefined(_id_00DFC67EAAF62BC0))
    self notify(_id_00DFC67EAAF62BC0);

  return _id_43EF75C950ADAB71;
}

_id_5E0E534F768708A3(radius, center) {
  center = scripts\engine\utility::_id_53C4C53197386572(center, self.origin);
  radius = scripts\engine\utility::_id_53C4C53197386572(radius, 2500);
  _id_FC8B7E5E0A42AE83 = 60;
  point = _id_FCC75AF6225B896B(center, radius, 0.85, 1, self.angles[1] - _id_FC8B7E5E0A42AE83, self.angles[1] + _id_FC8B7E5E0A42AE83);
  _id_03863887FED6F155 = _id_207BA502560FA1D2(point);
  return _id_03863887FED6F155;
}

_id_FCC75AF6225B896B(origin, radius, _id_8108B284F99B128A, _id_812BBC84F9C17040, _id_779315766223441A, _id_07F870143D9150C8) {
  pos = _id_2695A20D4011076D::getrandompointincircle(origin, radius, _id_8108B284F99B128A, _id_812BBC84F9C17040, 0, 0, _id_779315766223441A, _id_07F870143D9150C8);
  return getclosestpointonnavmesh((pos[0], pos[1], self.origin[2]));
}

_id_142B713A2846F9AC(status) {
  self.status = status;
}

_id_1E8FE34F5DFDEA49(status) {
  self._id_A4273E17F90BFBE6 = status;
}

_id_9230BCB84B43D245() {
  return self._id_A4273E17F90BFBE6;
}

_id_9E400058EF021B03(origin, radius) {
  self botclearscriptgoal();
  self botsetscriptgoal(origin, radius, "tactical", undefined, undefined, 1);
}

_id_207BA502560FA1D2(_id_332BFCF7ECA6F520, maxdistance) {
  _id_D0EB1456103AB1E3 = distance2d(self.origin, _id_332BFCF7ECA6F520);
  maxdistance = scripts\engine\utility::_id_53C4C53197386572(maxdistance, 2000.0);

  if(_id_D0EB1456103AB1E3 > maxdistance) {
    _id_536B3E9DAD0768FB = vectorlerp(self.origin, _id_332BFCF7ECA6F520, maxdistance / _id_D0EB1456103AB1E3);
    _id_332BFCF7ECA6F520 = getclosestpointonnavmesh((_id_536B3E9DAD0768FB[0], _id_536B3E9DAD0768FB[1], self.origin[2]));
  }

  return self getclosestreachablepointonnavmesh(_id_332BFCF7ECA6F520);
}

_id_2C2B5B435027F895(enemy) {
  if(isDefined(enemy) && isDefined(self._id_9B84CED9D9596292) && isDefined(self.enemy) && self._id_9B84CED9D9596292 == enemy && self.enemy == enemy) {
    return;
  }
  if(isDefined(enemy))
    self botsetscriptenemy(enemy);
  else
    self botclearscriptenemy();

  self._id_9B84CED9D9596292 = enemy;
}

_id_DED80385EA7471DB(player) {
  return isDefined(player) && istrue(player.connected) && scripts\mp\utility\player::isreallyalive(player);
}

isvalidplayer(player) {
  if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
    return _id_40E63DD222434655::_id_36FD4F80D95CD0C4(player);
  else
    return _id_27FDECE778E999D8::_id_36E75380D944A65D(player);
}

_id_42266A7FD7932C50(player) {
  if(!isvalidplayer(player))
    return 0;

  if(isDefined(player.vehicle) && istrue(player.vehicle.isheli)) {
    _id_CEA0B2E80126162E = 658;

    if(player.origin[2] - self.origin[2] > _id_CEA0B2E80126162E)
      return 0;
  }

  return 1;
}

_id_6DDD1F755A24720F(_id_6F7CE33FC2A39BCD) {
  if(_id_6F7CE33FC2A39BCD._id_1CD1B7DB5606880E == "main" && isDefined(self)) {
    _id_2C2B5B435027F895(undefined);
    self botclearscriptgoal();
  }
}

_id_CF1A9E98122E3931(target) {
  _id_BB7A7034F796AF47 = scripts\mp\equipment::getequipmentslotammo("primary");
  _id_79A42E6A2F51CF87 = scripts\mp\equipment::getequipmentslotammo("secondary");
  _id_A9FBDE0565FC4BE7 = isDefined(_id_BB7A7034F796AF47) && _id_BB7A7034F796AF47 > 0 || isDefined(_id_79A42E6A2F51CF87) && _id_79A42E6A2F51CF87 > 0;

  if(_id_A9FBDE0565FC4BE7) {
    _id_E1DFC5A054B93827 = distancesquared(self.origin, target.origin);
    _id_FFE68641C6DC7CD3 = 211600;

    if(_id_E1DFC5A054B93827 < _id_FFE68641C6DC7CD3) {
      return;
    }
    _id_0962E254E583D9E3 = self botcanseeentity(target);

    if(!_id_0962E254E583D9E3) {
      _id_13C4033676C21C00 = target gettagorigin("j_spinelower");
      _id_0962E254E583D9E3 = scripts\engine\trace::can_see_origin(_id_13C4033676C21C00);
    }

    if(!_id_0962E254E583D9E3) {
      _id_6C304568AF601DBE = vectorNormalize(target.origin - self.origin);
      _id_DCD388DDC7034FA8 = (_id_6C304568AF601DBE[1], _id_6C304568AF601DBE[0] * -1, 0);
      _id_95D7FACDCEAB8BB7 = (_id_6C304568AF601DBE[1] * -1, _id_6C304568AF601DBE[0], 0);
      _id_7A645C4A72DFD237 = [];
      _id_7E3C85E8F41644C4 = target gettagorigin("j_mainroot");
      _id_7A645C4A72DFD237[_id_7A645C4A72DFD237.size] = target gettagorigin("j_head") + (0, 0, 50);
      _id_7A645C4A72DFD237[_id_7A645C4A72DFD237.size] = _id_7E3C85E8F41644C4 + _id_DCD388DDC7034FA8 * 50;
      _id_7A645C4A72DFD237[_id_7A645C4A72DFD237.size] = _id_7E3C85E8F41644C4 + _id_95D7FACDCEAB8BB7 * 50;
      _id_7A645C4A72DFD237[_id_7A645C4A72DFD237.size] = _id_7E3C85E8F41644C4 + _id_DCD388DDC7034FA8 * 100;
      _id_7A645C4A72DFD237[_id_7A645C4A72DFD237.size] = _id_7E3C85E8F41644C4 + _id_95D7FACDCEAB8BB7 * 100;

      foreach(point in _id_7A645C4A72DFD237) {
        if(scripts\engine\trace::can_see_origin(point)) {
          self botthrowscriptedgrenade(point, "lethal", 1);
          break;
        }
      }
    }
  }
}

_id_EE72E3F03E5196B7(entity) {
  if(isPlayer(entity) && !isbot(entity))
    return "#" + entity _meth_7A32B0201993D7F7();

  return entity.name;
}

_id_C73FFCC4D5A2BC9C(_id_DEE1E90C5A8243B7) {
  waitframe();

  if(isDefined(self))
    self notify(_id_DEE1E90C5A8243B7);
}

_id_57195FC2E39F0E10(_id_4690EE88748BDF9B) {
  for(index = 0; index < _id_4690EE88748BDF9B.size - 1; index++) {
    current = _id_4690EE88748BDF9B[index];
    next = _id_4690EE88748BDF9B[index + 1];

    if(current > next)
      return 0;
  }

  return 1;
}

_id_9D1AB012058221BB(x, _id_14AB65671E2B6421, _id_AC1F4177A80907AE) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_14AB65671E2B6421.size; _id_AC0E594AC96AA3A8++) {
    _id_1A91606A95A6F428 = _id_14AB65671E2B6421[_id_AC0E594AC96AA3A8];

    if(x < _id_1A91606A95A6F428) {
      if(_id_AC0E594AC96AA3A8 == 0)
        return _id_AC1F4177A80907AE[0];
      else {
        rate = scripts\engine\math::lerp_fraction(_id_14AB65671E2B6421[_id_AC0E594AC96AA3A8 - 1], _id_1A91606A95A6F428, x);
        return scripts\engine\math::lerp(_id_AC1F4177A80907AE[_id_AC0E594AC96AA3A8 - 1], _id_AC1F4177A80907AE[_id_AC0E594AC96AA3A8], rate);
      }
    }
  }

  return _id_AC1F4177A80907AE[_id_AC1F4177A80907AE.size - 1];
}

_id_3569A4BEC8B9AF17(player) {
  if(isDefined(self.attackerdata) && self.attackerdata.size > 0) {
    foreach(attacker in self.attackerdata) {
      if(isDefined(attacker) && isDefined(attacker.attackerent) && attacker.attackerent == player && !istrue(player.inlaststand))
        return gettime() - attacker.lasttimedamaged < 5000;
    }
  }

  return 0;
}
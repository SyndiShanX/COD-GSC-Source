/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\cap.gsc
***********************************************/

_id_11BC1C4CEE238A68(asmname, statename, params) {
  _id_7E44A7A72AAB416A = 0;
  _id_B2DBB430E5511587 = "";

  if(isDefined(params)) {
    if(!isarray(params))
      _id_B2DBB430E5511587 = params;
    else {
      _id_B2DBB430E5511587 = params[0];
      _id_7E44A7A72AAB416A = params[1];
    }
  }

  _id_5E1F4C1FACE5C6A6 = self _meth_E430DF0F7376EC66();
  targetangles = self.angles;

  if(isDefined(_id_5E1F4C1FACE5C6A6)) {
    targetpos = _id_5E1F4C1FACE5C6A6.origin;
    _id_D5BE0521E83DF112 = vectorNormalize(targetpos - self.origin);
    targetangles = vectortoangles(_id_D5BE0521E83DF112);
  }

  _id_623F3095ECFA11FF = angleclamp180(targetangles[1] - self.angles[1]);
  angleindex = scripts\asm\asm::yawdiffto2468(_id_623F3095ECFA11FF);

  if(_id_7E44A7A72AAB416A && angleindex == "2") {
    if(_id_623F3095ECFA11FF < 0)
      angleindex = "2l";
    else
      angleindex = "2r";
  }

  aliasname = _id_B2DBB430E5511587 + angleindex;
  turnanim = _id_18E6C36C02A94DBD(statename, aliasname);
  return turnanim;
}

_id_64D568EC73EC23F9(asmname, statename, params) {
  self._id_9B3E65EEB1124E61 = gettime();
  self._id_7AFD86C1AF40885B = "curious";
  _id_147448F3F080C636::_id_FFF7117076AF2D16(self, level._id_9958731831312749._id_30F007AC9A8E642E, "curious", 0, 1);
  _id_59308D53CABCDFDB(asmname, statename, params);
}

_id_286C69ED2C750E6C(asmname, _id_CBBDF6BCF5AB31BE) {
  self endon("death");
  player = _id_147448F3F080C636::_id_47C84E03DCBC5AA7(_id_CBBDF6BCF5AB31BE.origin);

  if(!isDefined(player)) {
    return;
  }
  _id_D5BE0521E83DF112 = vectorNormalize(_id_CBBDF6BCF5AB31BE.origin - player.origin);
  _id_6342BB081F0D1FA8 = _id_CBBDF6BCF5AB31BE.origin;
  wait 0.5;

  foreach(_id_90CF8BDA0648D361 in level._id_F62B6E59C0E00D48.civs) {
    if(!isalive(_id_90CF8BDA0648D361) || _id_90CF8BDA0648D361 == _id_CBBDF6BCF5AB31BE) {
      continue;
    }
    if(isDefined(_id_90CF8BDA0648D361._id_34DF90223221B7A6) && isDefined(_id_CBBDF6BCF5AB31BE._id_A2C8B8008309AAE2)) {
      if(level._id_6961D0344027496F[_id_90CF8BDA0648D361._id_A2C8B8008309AAE2] == level._id_6961D0344027496F[_id_CBBDF6BCF5AB31BE._id_34DF90223221B7A6])
        continue;
    }

    _id_81D4D535A858F508 = _id_90CF8BDA0648D361.origin - _id_6342BB081F0D1FA8;
    _id_691F481A8BBA4062 = lengthsquared(_id_81D4D535A858F508);
    maxdistance = 80;

    if(_id_691F481A8BBA4062 > maxdistance * maxdistance) {
      continue;
    }
    _id_332EA4B12D924C65 = vectorNormalize(_id_81D4D535A858F508);
    dot = vectordot(_id_332EA4B12D924C65, _id_D5BE0521E83DF112);

    if(dot > 0.96)
      _id_90CF8BDA0648D361 scripts\asm\asm::asm_fireevent(asmname, "player_pushed");
  }
}

_id_C72398C24FE24B5B(asmname, statename, params) {
  thread _id_286C69ED2C750E6C(asmname, self);
  self._id_9B3E65EEB1124E61 = gettime();
  self._id_7AFD86C1AF40885B = "angered";
  _id_59308D53CABCDFDB(asmname, statename, params);
}

_id_F16999F33EF5381D(statename) {
  self notify("lerp_arrive_finished");
  self endon("death");
  self endon("lerp_arrive_finished");
  alpha = 0;
  startorigin = self.origin;
  startangles = self.angles;
  targetpos = getclosestpointonnavmesh(self.origin, self);
  xanim = animsetgetanimfromindex(self._id_AE3EA15396B65C1F, statename, self._id_44C80D2697DCE15B);
  _id_B2A409ABCEE9F3A1 = getoriginforanimtime(self.origin, self.angles, xanim, 1);
  animlength = getanimlength(xanim);
  starttime = gettime();

  if(ispointonnavmesh(_id_B2A409ABCEE9F3A1)) {
    self notify("lerp_arrive_finished");
    return;
  }

  while(alpha < animlength) {
    waitframe();
    alpha = (gettime() - starttime) / 1000;
    _id_6C53D859D582A421 = vectorlerp(self.origin, targetpos, alpha);
    self forceteleport(_id_6C53D859D582A421, startangles);
  }

  self notify("lerp_arrive_finished");
}

_id_59308D53CABCDFDB(asmname, statename, params) {
  self._id_44C80D2697DCE15B = scripts\asm\asm::asm_getanim(asmname, statename);
  _id_FB8AFEABD23A5EF5(asmname, statename, params, self._id_44C80D2697DCE15B);
}

_id_FB8AFEABD23A5EF5(asmname, statename, params, _id_2C8936D08F85C5C1) {
  self endon(statename + "_finished");
  xanim = scripts\asm\asm::asm_getxanim(statename, _id_2C8936D08F85C5C1);
  _id_38ADB9F7AE99DF6A(statename, xanim);

  if(isai(self))
    self aisetanim(statename, _id_2C8936D08F85C5C1);
  else {
    _id_34EE65B16925D791 = scripts\asm\asm::asm_lookupanimfromalias("knobs", "body");
    _id_A0917315F76AB3F2 = scripts\asm\asm::asm_getxanim("knobs", _id_34EE65B16925D791);
    self setflaggedanimknoballrestart(statename, xanim, _id_A0917315F76AB3F2, 1.0, 0.2, 1.0);
    self setanim(_id_A0917315F76AB3F2, 1.0, 0.2);

    if(statename == "relaxed" || statename == "single_loop" || statename == "group_loop")
      _id_46602711ED8E40D6();
    else if(isDefined(params) && isarray(params) && params.size == 2) {
      _id_D0EB396831A484AD = params[1];

      if(_id_D0EB396831A484AD)
        childthread _id_F498A27EB642642C();
    }
  }

  _id_7D6E619C3450BEF3(statename, xanim);
  _id_C779DC23CACCB19C(asmname, statename, params);
  scripts\asm\asm::asm_playfacialanim(asmname, statename, xanim);
  _id_49835F1C23C89361(asmname, statename);
}

_id_E7652690C4FBE131(asmname, statename, params) {
  _id_59308D53CABCDFDB(asmname, statename, params);

  if(isDefined(self.node))
    self.keepclaimednodeifvalid = 1;
}

_id_AE21268AEC38D315(asmname, statename, params) {
  self.keepclaimednodeifvalid = 0;
}

_id_38ADB9F7AE99DF6A(statename, xanim, _id_EB5B1F36E255152D) {
  if(isDefined(self._id_1836CD6BC75A5CE3) && scripts\engine\utility::array_contains(self._id_1836CD6BC75A5CE3, statename)) {
    return;
  }
  scriptednode = _id_76B0413F0E5D4DD2();

  if(!isDefined(scriptednode)) {
    return;
  }
  if(!isDefined(_id_EB5B1F36E255152D))
    _id_EB5B1F36E255152D = 0;

  origin = scriptednode.origin;
  angles = scripts\engine\utility::_id_53C4C53197386572(scriptednode.angles, (0, 0, 0));
  _id_D917428537562C1F = getoriginforanimtime(origin, angles, xanim, _id_EB5B1F36E255152D);
  startangles = getanglesforanimtime(origin, angles, xanim, _id_EB5B1F36E255152D);

  if(isai(self))
    self forceteleport(_id_D917428537562C1F, startangles, 9999);
  else {
    self.origin = _id_D917428537562C1F;
    self.angles = startangles;
  }
}

_id_76B0413F0E5D4DD2() {
  if(isDefined(self._id_E0676499119D450B))
    return undefined;

  if(isDefined(self.scriptednode))
    return self.scriptednode;

  if(isDefined(self.animnode))
    return self.animnode;

  if(isDefined(self.scripted_animnode))
    return self.scripted_animnode;

  if(isDefined(self._id_98B372C0F9B463BA))
    return self._id_98B372C0F9B463BA;

  return undefined;
}

_id_7D6E619C3450BEF3(statename, xanim) {
  if(!isDefined(self._id_F457C1616037EA52) || !scripts\engine\utility::array_contains_key(self._id_F457C1616037EA52, statename)) {
    return;
  }
  _id_DCF5E86549620338 = self;

  if(isDefined(self._id_DCF5E86549620338))
    _id_DCF5E86549620338 = self._id_DCF5E86549620338;

  _id_045402DBFEB5643F = _id_DCF5E86549620338._id_F457C1616037EA52[statename];
  _id_38ADB9F7AE99DF6A(statename, xanim, _id_045402DBFEB5643F);
  self setanimtime(xanim, _id_045402DBFEB5643F);
  thread _id_C886DAE06EBA7D4A(statename, xanim);
}

_id_C886DAE06EBA7D4A(statename, xanim) {
  self endon(statename + "_finished");

  for(;;) {
    self._id_F457C1616037EA52[statename] = self getanimtime(xanim);
    waitframe();
  }
}

_id_F498A27EB642642C() {
  for(;;) {
    player = _id_147448F3F080C636::_id_47C84E03DCBC5AA7(self.origin);

    if(!isDefined(player)) {
      waitframe();
      continue;
    }

    target = player;

    if(isalive(self._blackboard._id_610CB18ECC1AF719))
      enemy = self._blackboard._id_610CB18ECC1AF719;

    _id_7F96D62F3ABBF9B9 = target.origin - self.origin;
    _id_B047D1B68E9701C9 = lengthsquared(_id_7F96D62F3ABBF9B9);
    _id_077B9E4B599269EB = angleclamp180(vectortoyaw(_id_7F96D62F3ABBF9B9) - self.angles[1]);
    _id_706FE99CE1EFA2B7 = [[300, 180], [0, 10]];
    _id_3ADA4C6E49483364 = 0;

    foreach(_id_CBF22C9EDB76E72D in _id_706FE99CE1EFA2B7) {
      _id_50F1AC2AFF931B50 = _id_CBF22C9EDB76E72D[0] * _id_CBF22C9EDB76E72D[0];

      if(_id_B047D1B68E9701C9 > _id_50F1AC2AFF931B50) {
        _id_3ADA4C6E49483364 = _id_CBF22C9EDB76E72D[1];
        break;
      }
    }

    _id_8AF36CBE43B2D885 = abs(_id_077B9E4B599269EB) > _id_3ADA4C6E49483364;

    if(_id_8AF36CBE43B2D885) {
      _id_1EF5D9558A86BD8E = 25;
      duration = abs(_id_077B9E4B599269EB) / _id_1EF5D9558A86BD8E * 1000;
      _id_0C3DDCD0C37A60C5 = int(ceil(duration / level.frameduration));

      while(_id_0C3DDCD0C37A60C5 > 0) {
        _id_077B9E4B599269EB = angleclamp180(vectortoyaw(target.origin - self.origin) - self.angles[1]);
        _id_6BDB8335862F56EE = 1 / _id_0C3DDCD0C37A60C5;
        _id_B1CBDF386B2C0DEA = _id_077B9E4B599269EB;
        yaw = angleclamp(self.angles[1] + _id_B1CBDF386B2C0DEA * _id_6BDB8335862F56EE);
        self.angles = (0, yaw, 0);
        _id_0C3DDCD0C37A60C5--;
        waitframe();
      }
    }

    waitframe();
  }
}

_id_46602711ED8E40D6() {
  _id_1EF5D9558A86BD8E = 70;

  for(;;) {
    origin = self._id_8F0BD1E175F2CF51 + anglesToForward(self._id_394377B94EDABDDF) * 50;

    if(isalive(self._blackboard._id_610CB18ECC1AF719))
      enemy = self._blackboard._id_610CB18ECC1AF719;

    _id_7F96D62F3ABBF9B9 = origin - self.origin;
    _id_B047D1B68E9701C9 = lengthsquared(_id_7F96D62F3ABBF9B9);
    _id_077B9E4B599269EB = angleclamp180(vectortoyaw(_id_7F96D62F3ABBF9B9) - self.angles[1]);
    _id_706FE99CE1EFA2B7 = [[300, 180], [0, 10]];
    _id_3ADA4C6E49483364 = 0;

    foreach(_id_CBF22C9EDB76E72D in _id_706FE99CE1EFA2B7) {
      _id_50F1AC2AFF931B50 = _id_CBF22C9EDB76E72D[0] * _id_CBF22C9EDB76E72D[0];

      if(_id_B047D1B68E9701C9 > _id_50F1AC2AFF931B50) {
        _id_3ADA4C6E49483364 = _id_CBF22C9EDB76E72D[1];
        break;
      }
    }

    _id_8AF36CBE43B2D885 = abs(_id_077B9E4B599269EB) > _id_3ADA4C6E49483364;

    if(_id_8AF36CBE43B2D885) {
      duration = abs(_id_077B9E4B599269EB) / _id_1EF5D9558A86BD8E * 1000;
      _id_0C3DDCD0C37A60C5 = int(ceil(duration / level.frameduration));

      while(_id_0C3DDCD0C37A60C5 > 0) {
        _id_077B9E4B599269EB = angleclamp180(vectortoyaw(origin - self.origin) - self.angles[1]);
        _id_6BDB8335862F56EE = 1 / _id_0C3DDCD0C37A60C5;
        _id_B1CBDF386B2C0DEA = _id_077B9E4B599269EB;
        yaw = angleclamp(self.angles[1] + _id_B1CBDF386B2C0DEA * _id_6BDB8335862F56EE);
        self.angles = (0, yaw, 0);
        _id_0C3DDCD0C37A60C5--;
        waitframe();
      }
    }

    waitframe();
  }
}

_id_2944E6470A84B96D(xanim, _id_9622B10EA4ACBC01) {}

_id_F9D6133768491200(xanim, _id_9622B10EA4ACBC01) {}

_id_07495A975F79B957(player) {}

_id_C6F62DE5C6E04207(asmname, statename, params) {
  self endon(statename + "_finished");

  for(;;) {
    _id_2C8936D08F85C5C1 = scripts\asm\asm::asm_getanim(asmname, statename);
    xanim = scripts\asm\asm::asm_getxanim(statename, _id_2C8936D08F85C5C1);
    _id_38ADB9F7AE99DF6A(statename, xanim);

    if(isai(self)) {
      self aisetanim(statename, _id_2C8936D08F85C5C1);
      scripts\asm\asm::asm_playfacialanim(asmname, statename, xanim);
    } else {
      _id_34EE65B16925D791 = scripts\asm\asm::asm_lookupanimfromalias("knobs", "body");
      _id_A0917315F76AB3F2 = scripts\asm\asm::asm_getxanim("knobs", _id_34EE65B16925D791);
      self setflaggedanimknoballrestart(statename, xanim, _id_A0917315F76AB3F2, 1.0, 0.2, 1.0);
    }

    _id_C779DC23CACCB19C(asmname, statename, params);
    _id_49835F1C23C89361(asmname, statename);
  }
}

_id_49835F1C23C89361(asmname, statename) {
  _id_3931FF7E891D898F = scripts\asm\asm::asm_getnotehandler(asmname, statename);

  for(endnote = undefined; !isDefined(endnote) || !isstring(endnote) || endnote != "end"; endnote = scripts\asm\asm::asm_donotetracks(asmname, statename, _id_3931FF7E891D898F)) {}

  return endnote;
}

_id_6ACAC145244155A5(notetrack) {
  _id_357B9A54DFEDBD4A::notetrack_prefix_handler(notetrack);
  return undefined;
}

_id_A0DFEEA159AA7F64(asmname, statename, params) {
  if(!isDefined(params)) {
    _id_0B6648A33085E43A = _id_976D6CCB0A2807F3(statename);
    return _id_18E6C36C02A94DBD(statename, _id_0B6648A33085E43A);
  } else {
    result = undefined;
    _id_457FEB6671ADD6F0 = scripts\asm\asm_bb::bb_getprefixstring(params);

    if(isDefined(_id_457FEB6671ADD6F0)) {
      _id_0B6648A33085E43A = _id_976D6CCB0A2807F3(statename, _id_457FEB6671ADD6F0);
      result = _id_18E6C36C02A94DBD(statename, _id_0B6648A33085E43A);
    } else
      result = _id_18E6C36C02A94DBD(statename, params);

    return result;
  }
}

_id_F179EDE0989E6734(statename, alias) {
  _id_0EABF81B5BE8DDB5 = archetypegetrandomalias(self._id_AE3EA15396B65C1F, statename, alias, 0);
  return isDefined(_id_0EABF81B5BE8DDB5);
}

_id_B6050FD3B28E7AEF(asmname, statename, params) {
  _id_D586BEE14A644246 = 450;
  _id_CBA2D21A29A6D238 = _id_D586BEE14A644246 * _id_D586BEE14A644246;
  player = _id_147448F3F080C636::_id_47C84E03DCBC5AA7(self.origin);

  if(!isDefined(player)) {
    _id_2B2B7A463C0A7F7A = "far";

    if(_id_F179EDE0989E6734(statename, _id_2B2B7A463C0A7F7A)) {
      result = _id_18E6C36C02A94DBD(statename, _id_2B2B7A463C0A7F7A);
      return result;
    }

    _id_0B6648A33085E43A = _id_976D6CCB0A2807F3(statename);
    return _id_18E6C36C02A94DBD(statename, _id_0B6648A33085E43A);
  }

  _id_457471485336C961 = distancesquared(self.origin, player.origin);
  _id_2B2B7A463C0A7F7A = undefined;

  if(_id_457471485336C961 < _id_CBA2D21A29A6D238) {
    contents = scripts\engine\trace::create_contents(1, 0, 0, 0, 0, 0, 0);
    _id_21D6D994B0F4FAF1 = [player, self];
    origin = self.origin + (0, 0, 30);
    end = player.origin + (0, 0, 30);

    if(isai(self)) {
      _id_026FFDE339BC75EF = physics_charactercast(origin, end, self, 30, self.angles, contents, _id_21D6D994B0F4FAF1, "physicsquery_closest");

      if(_id_026FFDE339BC75EF.size)
        _id_2B2B7A463C0A7F7A = "far";
      else
        _id_2B2B7A463C0A7F7A = "near";
    } else
      _id_2B2B7A463C0A7F7A = "near";
  } else
    _id_2B2B7A463C0A7F7A = "far";

  if(_id_F179EDE0989E6734(statename, _id_2B2B7A463C0A7F7A)) {
    result = _id_18E6C36C02A94DBD(statename, _id_2B2B7A463C0A7F7A);
    return result;
  }

  _id_0B6648A33085E43A = _id_976D6CCB0A2807F3(statename);
  return _id_18E6C36C02A94DBD(statename, _id_0B6648A33085E43A);
}

_id_7C6B7C2CD3357729(asmname, statename, params) {
  if(!isDefined(params)) {
    _id_0B6648A33085E43A = _id_976D6CCB0A2807F3(statename);
    return _id_658DF657CA37F542(statename, _id_0B6648A33085E43A);
  } else {
    result = undefined;
    _id_457FEB6671ADD6F0 = scripts\asm\asm_bb::bb_getprefixstring(params);

    if(isDefined(_id_457FEB6671ADD6F0)) {
      _id_0B6648A33085E43A = _id_976D6CCB0A2807F3(statename, _id_457FEB6671ADD6F0);
      result = _id_658DF657CA37F542(statename, _id_0B6648A33085E43A);
    } else
      result = _id_658DF657CA37F542(statename, params);

    return result;
  }
}

_id_18E6C36C02A94DBD(statename, alias) {
  _id_38548703EA2BDADC = self._id_AE3EA15396B65C1F;
  _id_0EABF81B5BE8DDB5 = archetypegetrandomalias(_id_38548703EA2BDADC, statename, alias, scripts\asm\asm::asm_isfrantic());
  return _id_0EABF81B5BE8DDB5;
}

_id_658DF657CA37F542(statename, alias) {
  _id_38548703EA2BDADC = self._id_AE3EA15396B65C1F;

  if(!isDefined(self._id_30452AD282AFCD76))
    self._id_30452AD282AFCD76 = [];

  if(!isDefined(self._id_30452AD282AFCD76[statename]))
    self._id_30452AD282AFCD76[statename] = [];

  if(!isDefined(self._id_30452AD282AFCD76[statename][alias]))
    self._id_30452AD282AFCD76[statename][alias] = 0;

  _id_774B89735F430EC9 = animsetgetallanimindicesforalias(_id_38548703EA2BDADC, statename, alias);
  _id_0EABF81B5BE8DDB5 = _id_774B89735F430EC9[self._id_30452AD282AFCD76[statename][alias]];
  self._id_30452AD282AFCD76[statename][alias]++;

  if(self._id_30452AD282AFCD76[statename][alias] >= _id_774B89735F430EC9.size)
    self._id_30452AD282AFCD76[statename][alias] = 0;

  return _id_0EABF81B5BE8DDB5;
}

_id_976D6CCB0A2807F3(statename, _id_07B0F2A3348AB051, _id_D0D422E79C49095C) {
  archetype = self._id_AE3EA15396B65C1F;
  aliases = archetypegetaliases(archetype, statename);
  _id_9449EB175477A20E = 0.0;
  chosen = undefined;
  _id_89ADD265E84914CC = -1;

  if(isDefined(_id_07B0F2A3348AB051))
    _id_89ADD265E84914CC = _id_07B0F2A3348AB051.size;

  if(!isDefined(aliases))
    return undefined;

  foreach(aliasname in aliases) {
    if(_id_89ADD265E84914CC < 0 || getsubstr(aliasname, 0, _id_89ADD265E84914CC) == _id_07B0F2A3348AB051) {
      _id_9449EB175477A20E = _id_9449EB175477A20E + 1.0;
      _id_302E82DA1A1989AD = 1.0 / _id_9449EB175477A20E;

      if(randomfloat(1.0) <= _id_302E82DA1A1989AD)
        chosen = aliasname;
    }
  }

  return chosen;
}

_id_A649E31C11A0B2C8(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return 0;
}

_id_2D6B1385FFC3F5CA(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return 0;
}

_id_085ECA0A1310A70C(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(isai(self))
    return self codemoverequested();

  return 0;
}

_id_304541CF33D2193C(asmname, statename, params) {
  if(isDefined(params)) {
    if(self.unittype == "civilian")
      scripts\asm\asm_bb::bb_setcivilianstate(params);
    else {
      if(self.unittype == "soldier" && params == "panic")
        params = "combat";

      scripts\common\utility::demeanor_override(params);
    }
  }

  self._blackboard._id_9FBDCE5FA10F8964 = 1;
}

_id_C779DC23CACCB19C(asmname, statename, params) {
  if(!isDefined(self._id_32BEA72AAD5DA872)) {
    return;
  }
  foreach(prop in self._id_32BEA72AAD5DA872) {
    if(isDefined(params))
      aliasname = params;
    else {
      aliasname = undefined;
      _id_390FC8687AD84751 = archetypegetaliases(prop._id_AE3EA15396B65C1F, statename);

      if(isDefined(_id_390FC8687AD84751))
        aliasname = scripts\engine\utility::random(_id_390FC8687AD84751);
    }

    if(!isDefined(aliasname)) {
      continue;
    }
    alias = archetypegetalias(prop._id_AE3EA15396B65C1F, statename, aliasname, 0);

    if(!isDefined(alias)) {
      continue;
    }
    _id_10BFC25635723B51 = alias.anims;

    if(isarray(_id_10BFC25635723B51))
      _id_10BFC25635723B51 = scripts\engine\utility::random(_id_10BFC25635723B51);

    scriptednode = _id_76B0413F0E5D4DD2();
    origin = scriptednode.origin;
    angles = scripts\engine\utility::_id_53C4C53197386572(scriptednode.angles, (0, 0, 0));
    prop animScripted(aliasname, origin, angles, _id_10BFC25635723B51);
  }
}

_id_B6AF4ADE50626E90(asmname, statename, params) {
  if(!isalive(self)) {
    return;
  }
  _id_010B6724C15A95E8::_id_B6AF4ADE50626E90();
}

_id_0A646F2B30E1F417(asmname, statename, params) {
  _id_010B6724C15A95E8::_id_B6AF4ADE50626E90();
  scripts\asm\asm::asm_setstate("long_death_death");
}

_id_C348991DDD3C9CE5(asmname, statename, params) {
  _id_010B6724C15A95E8::_id_B6AF4ADE50626E90();
  scripts\asm\asm::asm_setstate("death_generic");
}

_id_DB8201BA3A4A894D(asmname, statename, params) {
  _id_010B6724C15A95E8::_id_B6AF4ADE50626E90();

  if(self.currentpose == "crouch")
    scripts\asm\asm::asm_setstate("pain_crouch");
  else
    scripts\asm\asm::asm_setstate("pain_stand");
}

_id_71FE3F0B4EA06FF1(asmname, statename, params) {
  _id_010B6724C15A95E8::_id_B6AF4ADE50626E90();
  _id_B038ED928EC17A81 = self.forcelongdeathskipintroanim;
  self.forcelongdeathskipintroanim = 1;
  scripts\asm\asm::asm_setstate("choose_long_death");
  self.forcelongdeathskipintroanim = _id_B038ED928EC17A81;
}

_id_14909159C05A576E(asmname, statename, params) {}

_id_8D10C93F4B4244A2(asmname, _id_8F4EF4FDB5E7800A, _id_93279C66A2E49A45, params) {
  self._id_7AFD86C1AF40885B = "relaxed";
}

_id_EBD0A826AC49DA1E(asmname, _id_8F4EF4FDB5E7800A, _id_93279C66A2E49A45, params) {
  return isDefined(self._id_7AFD86C1AF40885B) && self._id_7AFD86C1AF40885B == params;
}

_id_C0D2BFB8B27B8C96(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return self._id_7AFD86C1AF40885B != "relaxed";
}

_id_00E44A6892E1D2EC(asmname, statename, _id_F2B19B25D457C2A6, params) {
  switch (self._id_7AFD86C1AF40885B) {
    case "curious":
      return 1;
    default:
      return 0;
  }
}

_id_11DF7068A03BB818(asmname, statename, _id_F2B19B25D457C2A6, params) {
  switch (self._id_7AFD86C1AF40885B) {
    case "angered":
    case "scared":
      return 1;
    default:
      return 0;
  }
}

_id_9CFCF25E2674EA46(asmname, statename, _id_F2B19B25D457C2A6, params) {
  switch (self._id_7AFD86C1AF40885B) {
    case "cower":
    case "panicked":
      return 1;
    default:
      return 0;
  }
}

_id_FBAF3F50DF29A0CA(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!scripts\engine\utility::flag_exist(params))
    return 0;

  return scripts\engine\utility::flag(params);
}

_id_084E2D261814F426(asmname, statename, _id_F2B19B25D457C2A6, params) {
  foreach(player in level.players) {
    if(distancesquared(self.origin, player.origin) <= params * params)
      return 1;
  }

  return 0;
}

_id_D87741AC656CC282(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return _id_9F458B5F165CFD34(params, 1);
}

_id_CD7B18478F9925A2(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return _id_9F458B5F165CFD34(params, 0);
}

_id_9F458B5F165CFD34(params, _id_D5CF0E54165D319A) {
  if(isai(self))
    _id_B22687643226C3C1 = self getEye();
  else
    _id_B22687643226C3C1 = self.origin;

  if(isDefined(params)) {
    if(abs(params) > 1)
      fov = cos(params);
    else
      fov = params;
  } else
    fov = 0.77;

  foreach(player in level.players) {
    playerorigin = player getEye();
    _id_3C70A7175FBFA3FC = player getgunangles();

    if(scripts\engine\utility::within_fov(playerorigin, _id_3C70A7175FBFA3FC, _id_B22687643226C3C1, fov)) {
      if(!_id_D5CF0E54165D319A || sighttracepassed(playerorigin, _id_B22687643226C3C1, 0, self))
        return 1;
    }
  }

  return 0;
}

_id_0EEF8D65AD14BC7D(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!isDefined(self.stealth))
    return 0;

  return self[[self.fnisinstealthidle]]();
}

_id_2C8145ED8B6C8504(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!isDefined(self.stealth))
    return 0;

  return self[[self.fnisinstealthinvestigate]]();
}

_id_9BFDDB0E0134923B(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!isDefined(self.stealth))
    return 0;

  return self[[self.fnisinstealthhunt]]();
}

_id_DF51607EE78D1190(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!isDefined(self.stealth))
    return 1;

  return self[[self.fnisinstealthcombat]]();
}

_id_276B2832AE7C7CF7(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return self findoverridearchetype("default") == params;
}

_id_8439B78C94685919(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(istrue(self._id_36023FDCE648D2EA))
    return 0;

  if(istrue(self._id_BE96BC0CF51DE950))
    return 0;

  return 1;
}

_id_2BD39480AE487049(_id_A234A65C378F3289, params) {
  statename = self asmgetcurrentstate(self.asmname);

  if(isstartstr(_id_A234A65C378F3289, "cigarette")) {
    _id_A234A65C378F3289 = getsubstr(_id_A234A65C378F3289, 10);
    _id_8248DD35588EBA2A(_id_A234A65C378F3289, statename);
  } else if(isstartstr(_id_A234A65C378F3289, "pack")) {
    _id_A234A65C378F3289 = getsubstr(_id_A234A65C378F3289, 5);
    _id_78FC852578A2D6A9(_id_A234A65C378F3289, statename);
  } else if(isstartstr(_id_A234A65C378F3289, "phone")) {
    _id_A234A65C378F3289 = getsubstr(_id_A234A65C378F3289, 6);
    _id_C1CBF486F2593C18(_id_A234A65C378F3289, statename);
  } else if(isstartstr(_id_A234A65C378F3289, "bottle")) {
    _id_A234A65C378F3289 = getsubstr(_id_A234A65C378F3289, 7);
    _id_103F712F2029BDE6(_id_A234A65C378F3289, statename);
  } else if(isstartstr(_id_A234A65C378F3289, "bread")) {
    _id_A234A65C378F3289 = getsubstr(_id_A234A65C378F3289, 6);
    _id_FB2C788FBEB2ED0E(_id_A234A65C378F3289, statename);
  } else if(isstartstr(_id_A234A65C378F3289, "chips")) {
    _id_A234A65C378F3289 = getsubstr(_id_A234A65C378F3289, 6);
    _id_2059F541BB4EC92B(_id_A234A65C378F3289, statename);
  } else if(isstartstr(_id_A234A65C378F3289, "pistol")) {
    _id_A234A65C378F3289 = getsubstr(_id_A234A65C378F3289, 7);
    _id_9E1B3A33E6A8C117(_id_A234A65C378F3289, statename);
  } else if(isstartstr(_id_A234A65C378F3289, "laptop")) {
    _id_A234A65C378F3289 = getsubstr(_id_A234A65C378F3289, 7);
    _id_8B7E11DA82242584(_id_A234A65C378F3289, statename);
  } else
    _id_245F3C9CF9FB2ED4(_id_A234A65C378F3289, statename);
}

_id_245F3C9CF9FB2ED4(_id_A234A65C378F3289, statename) {
  switch (self._id_AE3EA15396B65C1F) {
    case "civilian_react_tourist_f":
    case "civilian_react_tourist":
    case "cap_civ_react_phone01":
    case "civilian_react_phone_f":
    case "civilian_react_phone_right_hand":
    case "caps/interactions/cap_civ_scene_selfie":
    case "caps/interactions/mtg_civ_selfie":
    case "caps/interactions/mtg_civ_photo_woman":
    case "caps/interactions/cap_civ_scn_prty_phone01_man01":
    case "caps/interactions/cap_idle_cellphone_guard":
    case "caps/interactions/mtg_civ_photo_man":
    case "caps/interactions/cap_idle_cellphone":
      _id_C1CBF486F2593C18(_id_A234A65C378F3289, statename);
      break;
    case "caps/interactions/cap_civ_scn_prty_smoke01_man01":
    case "caps/interactions/cap_idle_smoke_guard":
    case "caps/interactions/cap_idle_smoke":
      _id_8248DD35588EBA2A(_id_A234A65C378F3289, statename);
      break;
    case "caps/interactions/cap_idle_drinking_guard":
    case "caps/interactions/cap_idle_drinking":
      _id_103F712F2029BDE6(_id_A234A65C378F3289, statename);
      break;
    case "caps/interactions/cap_idle_sitting_pistolcleaning":
      _id_9E1B3A33E6A8C117(_id_A234A65C378F3289, statename);
      break;
    case "caps/interactions/cap_idle_sitting_laptop":
      _id_8B7E11DA82242584(_id_A234A65C378F3289, statename);
      break;
    case "caps/interactions/cap_idle_sitting_cellphone":
      _id_425680112C205848(_id_A234A65C378F3289, statename);
      break;
    case "caps/interactions/cap_idle_sitting_sleeping":
      _id_2E7F07F6090DDEB5(_id_A234A65C378F3289, statename);
      break;
    case "caps/interactions/cap_civ_icpt_fishfarm01_man02":
      _id_18F4224C27507C56(_id_A234A65C378F3289, statename);
      break;
  }
}

_id_C2C313A844D139B9() {
  self endon("death");
  ai = self getlinkedparent();

  while(isDefined(self) && self islinked() && !istrue(ai._id_A97AC004F00C5DF9) && !istrue(ai.in_melee_death) && isalive(ai))
    waitframe();

  if(isDefined(ai)) {
    if(isDefined(ai.idle_fx)) {
      stopFXOnTag(ai.idle_fx, ai, "tag_accessory_right");
      stopFXOnTag(ai.idle_fx, ai, "tag_accessory_left");
      ai.idle_fx = undefined;
    }

    ai _id_B56D50EC10F7DF53(self);
    thread _id_F47109A0A608624E();
  } else
    self delete();
}

_id_591BD29F12B13862(_id_A234A65C378F3289) {
  _id_B5F792378AD37E44 = "tag_accessory_right";
  _id_A9F996CAF54DD68C = getsubstr(_id_A234A65C378F3289, 7);

  if(isDefined(_id_A9F996CAF54DD68C) && (_id_A9F996CAF54DD68C == "left" || _id_A9F996CAF54DD68C == "l"))
    _id_B5F792378AD37E44 = "tag_accessory_left";

  return _id_B5F792378AD37E44;
}

_id_C1CBF486F2593C18(_id_A234A65C378F3289, statename) {
  self endon(statename + "_finished");
  _id_B5F792378AD37E44 = _id_591BD29F12B13862(_id_A234A65C378F3289);

  if(isstartstr(_id_A234A65C378F3289, "attach")) {
    if(isDefined(self.idle_prop)) {
      return;
    }
    self.idle_prop = scripts\common\anim::anim_link_tag_model(_id_640494DB1D9ED4A4(), _id_B5F792378AD37E44);
    self.idle_prop thread _id_C2C313A844D139B9();
  } else if(isstartstr(_id_A234A65C378F3289, "detach")) {
    if(isDefined(self.idle_prop)) {
      self.idle_prop delete();
      self.idle_prop = undefined;
    }
  }
}

_id_640494DB1D9ED4A4() {
  modelname = "offhand_wm_smartphone_on";

  if(isDefined(level.scr_model) && isDefined(level.scr_model["idle_cellphone"]))
    modelname = level.scr_model["idle_cellphone"];

  return modelname;
}

_id_FB2C788FBEB2ED0E(_id_A234A65C378F3289, statename) {
  self endon(statename + "_finished");
  _id_B5F792378AD37E44 = _id_591BD29F12B13862(_id_A234A65C378F3289);

  if(isstartstr(_id_A234A65C378F3289, "attach")) {
    self.idle_prop = scripts\common\anim::anim_link_tag_model("food_bread_slice", _id_B5F792378AD37E44);
    self.idle_prop thread _id_C2C313A844D139B9();
  } else if(isstartstr(_id_A234A65C378F3289, "detach")) {
    if(isDefined(self.idle_prop)) {
      self.idle_prop delete();
      self.idle_prop = undefined;
    }
  }
}

_id_2059F541BB4EC92B(_id_A234A65C378F3289, statename) {
  self endon(statename + "_finished");
  _id_B5F792378AD37E44 = _id_591BD29F12B13862(_id_A234A65C378F3289);

  if(isstartstr(_id_A234A65C378F3289, "attach")) {
    self.idle_prop = scripts\common\anim::anim_link_tag_model("food_trash_bag_chips_01", _id_B5F792378AD37E44);
    self.idle_prop thread _id_C2C313A844D139B9();
  } else if(isstartstr(_id_A234A65C378F3289, "detach")) {
    if(isDefined(self.idle_prop)) {
      self.idle_prop delete();
      self.idle_prop = undefined;
    }
  }
}

_id_8248DD35588EBA2A(_id_A234A65C378F3289, statename) {
  _id_B5F792378AD37E44 = _id_591BD29F12B13862(_id_A234A65C378F3289);

  if(isstartstr(_id_A234A65C378F3289, "attach")) {
    if(isDefined(self.idle_prop)) {
      return;
    }
    self.idle_prop = scripts\common\anim::anim_link_tag_model(_id_F7B213561A5C3B4C(), _id_B5F792378AD37E44);
    self.idle_prop thread _id_C2C313A844D139B9();
    self.idle_fx = level.g_effect["cigarette_unlit"];
    playFXOnTag(self.idle_fx, self, _id_B5F792378AD37E44);
    self.idle_prop._id_B5F792378AD37E44 = _id_B5F792378AD37E44;
  } else if(isstartstr(_id_A234A65C378F3289, "light")) {
    if(isDefined(self.idle_prop._id_B5F792378AD37E44))
      _id_B5F792378AD37E44 = self.idle_prop._id_B5F792378AD37E44;

    self.idle_fx = level.g_effect["cigarette_lit"];
    playFXOnTag(self.idle_fx, self, _id_B5F792378AD37E44);
    stopFXOnTag(level.g_effect["cigarette_unlit"], self, _id_B5F792378AD37E44);
    playFX(level.g_effect["lighter_glow"], self gettagorigin(_id_B5F792378AD37E44));
    thread _id_E5DDDF915CECD10F(statename);
  } else if(isstartstr(_id_A234A65C378F3289, "detach") || isstartstr(_id_A234A65C378F3289, "toss")) {
    if(isDefined(self.idle_prop)) {
      self.idle_prop delete();
      self.idle_prop = undefined;
    }

    stopFXOnTag(level.g_effect["cigarette_lit"], self, _id_B5F792378AD37E44);
    self.idle_fx = undefined;

    if(isstartstr(_id_A234A65C378F3289, "toss"))
      playFX(level.g_effect["cigarette_lit_toss"], self gettagorigin(_id_B5F792378AD37E44), anglesToForward(self gettagangles(_id_B5F792378AD37E44)));
  }
}

_id_F7B213561A5C3B4C() {
  modelname = "misc_cigarette_01_centered";

  if(isDefined(level.scr_model) && isDefined(level.scr_model["idle_cigarette"]))
    modelname = level.scr_model["idle_cigarette"];

  return modelname;
}

_id_E5DDDF915CECD10F(statename) {
  self endon("smoking_end");
  self endon("death");

  for(;;) {
    self.smoke_fx_ent = playFXOnTag(level.g_effect["cigarette_smoke"], self, "tag_eye");
    waittime = randomintrange(5, 8);
    wait(waittime);

    if(isDefined(self.smoke_fx_ent)) {
      self.smoke_fx_ent delete();
      self.smoke_fx_ent = undefined;
    }
  }
}

_id_6F19361F519D4A3E(asmname, statename, params) {
  self notify("smoking_end");

  if(isDefined(self.idle_fx)) {
    stopFXOnTag(self.idle_fx, self, "tag_accessory_right");
    stopFXOnTag(self.idle_fx, self, "tag_accessory_left");
    self.idle_fx = undefined;
  }

  if(isDefined(self.smoke_fx_ent)) {
    self.smoke_fx_ent delete();
    self.smoke_fx_ent = undefined;
  }

  _id_4A72E2A3E57C82D4(asmname, statename, params);
}

_id_78FC852578A2D6A9(_id_A234A65C378F3289, statename) {
  action = getsubstr(_id_A234A65C378F3289, 0, 6);
  _id_B5F792378AD37E44 = _id_591BD29F12B13862(_id_A234A65C378F3289);

  switch (action) {
    case "attach":
      if(isDefined(self._id_CDB39B13B6524B5B)) {
        return;
      }
      self._id_CDB39B13B6524B5B = scripts\common\anim::anim_link_tag_model(_id_034554AAF056D23D(), _id_B5F792378AD37E44);
      self._id_CDB39B13B6524B5B thread _id_C2C313A844D139B9();
      break;
    case "detach":
      if(isDefined(self._id_CDB39B13B6524B5B)) {
        self._id_CDB39B13B6524B5B delete();
        self._id_CDB39B13B6524B5B = undefined;
      }

      break;
  }
}

_id_034554AAF056D23D() {
  modelname = "misc_cigarette_pack_01";

  if(isDefined(level.scr_model) && isDefined(level.scr_model["idle_cigarettepack"]))
    modelname = level.scr_model["idle_cigarettepack"];

  return modelname;
}

_id_103F712F2029BDE6(_id_A234A65C378F3289, statename) {
  _id_B5F792378AD37E44 = _id_591BD29F12B13862(_id_A234A65C378F3289);

  if(isstartstr(_id_A234A65C378F3289, "attach")) {
    if(isDefined(self.idle_prop)) {
      return;
    }
    self.idle_prop = scripts\common\anim::anim_link_tag_model("p7_bottle_plastic_16oz_water", _id_B5F792378AD37E44);
    self.idle_prop thread _id_C2C313A844D139B9();
  } else if(isstartstr(_id_A234A65C378F3289, "detach")) {
    if(isDefined(self.idle_prop)) {
      self.idle_prop delete();
      self.idle_prop = undefined;
    }
  }
}

_id_2E7F07F6090DDEB5(_id_A234A65C378F3289, statename) {
  if(isDefined(self _meth_92435C7A6AE85C3C()))
    _id_1C3ECECCCAB5A9B1();
}

_id_9E1B3A33E6A8C117(_id_A234A65C378F3289, statename) {
  _id_B5F792378AD37E44 = "tag_accessory_right";
  gun = "weapon_wm_pi_mike1911_phys";

  if(isDefined(self _meth_92435C7A6AE85C3C())) {
    if(isDefined(self.idle_prop)) {
      return;
    }
    _id_1C3ECECCCAB5A9B1();

    if(!isDefined(self._id_3B6893BB0FCFA0CC)) {
      _id_EF123C9E92DF3668 = anglesToForward(self.angles) * 18 + (0, 0, -2);
      self._id_3B6893BB0FCFA0CC = scripts\common\utility::_id_22490AAEBAAC105E(_id_FE4813E6B6140728(), self.origin + _id_EF123C9E92DF3668, self.angles);
    }

    origin = self.origin + (0, 0, 34) + anglesToForward(self.angles) * 10 + anglestoright(self.angles) * -8;
    self.idle_prop = scripts\common\utility::_id_22490AAEBAAC105E(gun, origin, self.angles + (0, 90, 90));
  } else if(isDefined(self.idle_prop)) {
    self.idle_prop delete();
    self.idle_prop = undefined;
  }
}

_id_8B7E11DA82242584(_id_A234A65C378F3289, statename) {
  _id_B5F792378AD37E44 = "tag_accessory_right";

  if(isDefined(self _meth_92435C7A6AE85C3C())) {
    _id_1C3ECECCCAB5A9B1();

    if(!isDefined(self._id_3B6893BB0FCFA0CC)) {
      _id_EF123C9E92DF3668 = anglesToForward(self.angles) * 22 + (0, 0, -2);
      self._id_3B6893BB0FCFA0CC = scripts\common\utility::_id_22490AAEBAAC105E(_id_FE4813E6B6140728(), self.origin + _id_EF123C9E92DF3668, self.angles);
    }

    if(isDefined(self._id_7E97F11E33CB4FFC)) {
      return;
    }
    _id_A1862B426C15F10E = anglesToForward(self.angles) * 30 + (0, 0, 31);
    self._id_7E97F11E33CB4FFC = scripts\common\utility::_id_22490AAEBAAC105E(_id_1EE6622550F2A5D0(), self.origin + _id_A1862B426C15F10E, self.angles);
  }
}

_id_1EE6622550F2A5D0() {
  modelname = "misc_wm_blackbox_laptop";

  if(isDefined(level.scr_model) && isDefined(level.scr_model["idle_laptop"]))
    modelname = level.scr_model["idle_laptop"];

  return modelname;
}

_id_425680112C205848(_id_A234A65C378F3289, statename) {
  _id_B5F792378AD37E44 = "tag_accessory_right";

  if(isDefined(self _meth_92435C7A6AE85C3C())) {
    if(isDefined(self.idle_prop)) {
      return;
    }
    _id_1C3ECECCCAB5A9B1();
    self.idle_prop = scripts\common\anim::anim_link_tag_model(_id_640494DB1D9ED4A4(), _id_B5F792378AD37E44);
    self.idle_prop thread _id_C2C313A844D139B9();
  } else if(isDefined(self.idle_prop)) {
    self.idle_prop delete();
    self.idle_prop = undefined;
  }
}

_id_18F4224C27507C56(_id_A234A65C378F3289, statename) {
  modelname = "container_fertilizer_bag_01_open";
  offset = (0, 0, -13);

  if(isDefined(self _meth_92435C7A6AE85C3C())) {
    if(!isDefined(self._id_FE35BEB58C6E303E)) {
      _id_CCE0ECB52CC93601 = level.scr_anim["idle_bag"]["wait"];
      self._id_FE35BEB58C6E303E = scripts\common\utility::_id_22490AAEBAAC105E(modelname, self._blackboard._id_AD5EDA311C73F5D7, self._blackboard._id_66C82B7660F29059);
      self._id_FE35BEB58C6E303E useanimtree(level.scr_animtree["idle_bag"]);
      self._id_FE35BEB58C6E303E animrelative("wait", self._blackboard._id_AD5EDA311C73F5D7 + offset, self._blackboard._id_66C82B7660F29059, _id_CCE0ECB52CC93601);
      self._id_FE35BEB58C6E303E.key = "wait";
      thread _id_399C8AD9434488E8();
    }
  }

  if(!isDefined(self._id_FE35BEB58C6E303E)) {
    return;
  }
  if(statename == "group_loop" && !istrue(self._id_FE35BEB58C6E303E.isidle)) {
    self._id_FE35BEB58C6E303E.key = "idle";
    self._id_FE35BEB58C6E303E.isidle = 1;
    _id_CCE0ECB52CC93601 = level.scr_anim["idle_bag"]["idle"];
    self._id_FE35BEB58C6E303E animrelative("idle", self._blackboard._id_AD5EDA311C73F5D7 + offset, self._blackboard._id_66C82B7660F29059, _id_CCE0ECB52CC93601);
    self._id_FE35BEB58C6E303E thread _id_C1D113F8B7F9000B();
  }
}

_id_C1D113F8B7F9000B() {
  self endon("death");
  self notify("prop_singleton");
  self endon("prop_singleton");
  self waittill("idle");
  self.isidle = 0;
}

_id_399C8AD9434488E8() {
  self endon("death");
  self._id_FE35BEB58C6E303E endon("death");

  while(isDefined(self _meth_92435C7A6AE85C3C()))
    waitframe();

  self._id_FE35BEB58C6E303E delete();
  self._id_FE35BEB58C6E303E = undefined;
}

_id_1C3ECECCCAB5A9B1() {
  if(!isDefined(self._id_61159AF849344F95))
    self._id_61159AF849344F95 = scripts\common\utility::_id_22490AAEBAAC105E("cp_disco_folding_chair_lod0", self.origin + anglesToForward(self.angles) * -8, self.angles);
}

_id_FE4813E6B6140728() {
  modelname = "furniture_kitchen_end_table_01";

  if(isDefined(level.scr_model) && isDefined(level.scr_model["idle_table"]))
    modelname = level.scr_model["idle_table"];

  return modelname;
}

_id_DA3D5E34EB93790A(asmname, statename, params) {
  _id_6F19361F519D4A3E(asmname, statename, params);
  _id_BF3D5AE7E2EEDA40(asmname, statename, params);
}

_id_BF3D5AE7E2EEDA40(asmname, statename, params) {
  _id_104F87CC51A1138D = [];

  if(isDefined(self.idle_prop))
    _id_104F87CC51A1138D[_id_104F87CC51A1138D.size] = self.idle_prop;

  if(isDefined(self._id_CDB39B13B6524B5B))
    _id_104F87CC51A1138D[_id_104F87CC51A1138D.size] = self._id_CDB39B13B6524B5B;

  if(isDefined(self.idle_fx))
    _id_6F19361F519D4A3E();

  if(_id_104F87CC51A1138D.size == 0) {
    return;
  }
  foreach(prop in _id_104F87CC51A1138D) {
    _id_B56D50EC10F7DF53(prop);
    prop thread _id_F47109A0A608624E();
  }
}

_id_B56D50EC10F7DF53(prop) {
  if(!isDefined(prop) || !isent(prop) || !isDefined(prop.model) || prop.model == "") {
    return;
  }
  _id_363CD698CE6C69C1 = anglesToForward(self.angles);
  _id_363CD698CE6C69C1 = _id_363CD698CE6C69C1 * randomfloatrange(10, 20);
  _id_D43803BE5B18DDD8 = _id_363CD698CE6C69C1[0];
  _id_D43804BE5B18E00B = _id_363CD698CE6C69C1[1];
  _id_D43805BE5B18E23E = randomfloatrange(1, 10);
  prop unlink();
  prop physicslaunchserver(prop.origin, (_id_D43803BE5B18DDD8, _id_D43804BE5B18E00B, _id_D43805BE5B18E23E));
}

_id_F47109A0A608624E() {
  interval = 10000;
  starttime = gettime();
  endtime = starttime + interval;

  if(scripts\common\utility::issp()) {
    wait 1;

    while(isDefined(self) && isalive(level.player) && gettime() < endtime && distance2dsquared(level.player.origin, self.origin) < 16384)
      wait 1;
  }

  if(isDefined(self))
    self delete();
}

_id_4A72E2A3E57C82D4(asmname, statename, params) {
  self.newenemyreactiondistsq = 262144;
  self _meth_0F7CFF9F6DAFB297();

  if(isDefined(self.idle_prop)) {
    self.idle_prop delete();
    self.idle_prop = undefined;
  }

  self notify("patrol_idle_complete");
}

_id_EAF18F0250ABB7E7(asmname, statename, params) {
  statename = "death_custom";
  alias = "death_custom_anim";
  _id_0EABF81B5BE8DDB5 = archetypegetrandomalias(self._id_AE3EA15396B65C1F, statename, alias, 0);

  if(isDefined(_id_0EABF81B5BE8DDB5))
    return 1;

  return 0;
}

_id_97E1B8ADAEA35A52(asmname, statename, params) {
  return isDefined(self _meth_92435C7A6AE85C3C());
}

_id_33952EA1DBD64D62(asmname, statename, params) {
  return self.asmname != "civilian_react" || isDefined(self._id_33B4C07D1F388776);
}

_id_8C68332A9A43F4EA(asmname, statename, params) {
  if(!isDefined(self._blackboard._id_60B33CF695F1D6ED)) {
    _id_60B33CF695F1D6ED = scripts\asm\asm::asm_getrandomalias(statename);
    self._blackboard._id_60B33CF695F1D6ED = _id_18E6C36C02A94DBD(statename, _id_60B33CF695F1D6ED);
  }

  alias = self._blackboard._id_60B33CF695F1D6ED;

  if(statename == "cower_to_panicked")
    self._blackboard._id_60B33CF695F1D6ED = undefined;

  return alias;
}
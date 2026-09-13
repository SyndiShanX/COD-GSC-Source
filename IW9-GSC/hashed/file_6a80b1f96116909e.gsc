/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6a80b1f96116909e.gsc
***********************************************/

_id_86880DD17DC8BC39(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!isDefined(self._id_9B3E65EEB1124E61))
    return 0;

  _id_FBD43DA47D8CECDF = gettime() - self._id_9B3E65EEB1124E61;
  _id_BD2C8D841D116E33 = 10000;
  return scripts\asm\asm::asm_eventfired(asmname, "player_pushed") && _id_FBD43DA47D8CECDF < _id_BD2C8D841D116E33;
}

_id_D8CA3630D10C6E62(asmname, statename, params) {
  player = _id_147448F3F080C636::_id_47C84E03DCBC5AA7(self.origin);

  if(!isDefined(player)) {
    _id_0B6648A33085E43A = _id_4E1D4DD23699A8A4::_id_976D6CCB0A2807F3(statename);
    return _id_4E1D4DD23699A8A4::_id_18E6C36C02A94DBD(statename, _id_0B6648A33085E43A);
  }

  if(isDefined(self._id_B2C134A19497E578._id_39CBCDCE57275C53))
    self._id_B2C134A19497E578._id_39CBCDCE57275C53 = 0;

  _id_D5BE0521E83DF112 = vectorNormalize(self.origin - player.origin);
  targetangles = vectortoangles(_id_D5BE0521E83DF112);
  _id_623F3095ECFA11FF = angleclamp180(targetangles[1] - self.angles[1]);
  angleindex = scripts\asm\asm::yawdiffto2468(_id_623F3095ECFA11FF);
  aliasname = "pushed_" + angleindex;
  turnanim = _id_4E1D4DD23699A8A4::_id_18E6C36C02A94DBD(statename, aliasname);
  return turnanim;
}

#using_animtree("generic_human");

_id_3A53B7D4F8A6AB4F(asmname, statename, params) {
  self._id_1AF0972AD4121C5D = spawnStruct();
  self._blackboard._id_610CB18ECC1AF719 = undefined;
  self._id_B2C134A19497E578 = spawnStruct();
  self._id_B2C134A19497E578._id_9D92FEBDAC913986 = 0;
  self._id_B2C134A19497E578._id_A2F98561AFE346C6 = 0;
  self._id_B2C134A19497E578._id_1532B27E26D5DB21 = "relaxed";
  self._id_B2C134A19497E578._id_6A8B5CADE9B556CF = 0;
  self._id_B2C134A19497E578._id_AF1D1102EDE20FC2 = "relaxed";
  self._id_B2C134A19497E578._id_AC13962F5C74201C = 0;
  self._id_B2C134A19497E578._id_0E4F4900D6D00346 = 0;
  self._id_B2C134A19497E578._id_A576B24EF9AF6865 = 0;
  self._id_B2C134A19497E578._id_44A0CAE44B47F5EE = 1;
  self._id_B2C134A19497E578._id_2141F7CB7FF397A6 = 0;
  self._id_E909843B1034CCC2 = spawnStruct();
  self._id_E909843B1034CCC2._id_21965E18B854F978 = 0;
  self._id_E909843B1034CCC2._id_56D6F93840CB5F45 = 0;

  if(isai(self)) {
    self setanim(%lookat_procedural_node);
    self setanim(%lookat_eye_node);
    _id_7A140EE03CFC699E = self findoverridearchetype("animscript");

    if(isDefined(_id_7A140EE03CFC699E)) {
      _id_6ABAD61CA454F906 = archetypegetalias(_id_7A140EE03CFC699E, "knobs", "head", 0);

      if(isDefined(_id_6ABAD61CA454F906))
        self setanim(_id_6ABAD61CA454F906.anims, 1.0, 0.2);

      self._id_8EFFD09D2C6077D7 = _id_7A140EE03CFC699E;
      self._id_BE5B4C59C12DF3A8 = asmname;
    }
  } else {
    self.fakeactor_face_anim = 1;
    self.facialstate = "asm";
    self._id_5247D15DA29E8539 = 1;
  }

  self._id_D28E54645050DF58 = 0;

  if(!istrue(self._id_6B1E93F4670936DC))
    return;
}

_id_E2843EF7ECD19447() {
  self endon("death");
  self.script_pushable = 0;

  for(;;) {
    _id_66525F681B2D3175 = 0;
    player = _id_147448F3F080C636::_id_47C84E03DCBC5AA7(self.origin);

    if(!isDefined(player)) {
      waitframe();
      continue;
    }

    _id_F07FA3F6881A01E6 = self.origin - player.origin;
    _id_214D72ECAF4FE659 = length2dsquared(_id_F07FA3F6881A01E6);
    _id_988CE1F3DE29AB7B = 70;

    if(isDefined(self._id_B2C134A19497E578._id_988CE1F3DE29AB7B))
      _id_988CE1F3DE29AB7B = self._id_B2C134A19497E578._id_988CE1F3DE29AB7B;
    else if(isDefined(level._id_F62B6E59C0E00D48._id_988CE1F3DE29AB7B))
      _id_988CE1F3DE29AB7B = level._id_F62B6E59C0E00D48._id_988CE1F3DE29AB7B;

    if(_id_214D72ECAF4FE659 < _id_988CE1F3DE29AB7B * _id_988CE1F3DE29AB7B) {
      _id_1D0DFDFEE6CACB97 = player getvelocity();
      _id_A7417A94CD44DD6F = length2dsquared(_id_1D0DFDFEE6CACB97);

      if(_id_A7417A94CD44DD6F > 0) {
        _id_E591D8F811352F5F = vectorNormalize(_id_1D0DFDFEE6CACB97);
        _id_F07FA3F6881A01E6 = vectorNormalize(_id_F07FA3F6881A01E6);
        dot = vectordot(_id_E591D8F811352F5F, _id_F07FA3F6881A01E6);
        _id_66525F681B2D3175 = dot > 0.866;
      }
    }

    if(_id_66525F681B2D3175 && self._id_B2C134A19497E578._id_44A0CAE44B47F5EE) {
      scripts\asm\asm::asm_fireevent(self.asmname, "player_pushed");
      _id_1A28AD563A3F4806 = 0.25;
      wait(_id_1A28AD563A3F4806);
      continue;
    }

    waitframe();
  }
}

_id_8410016CF6AB1371() {
  for(;;) {
    if(getDvar("dvar_39375E00C2CAD343") != "" && isDefined(self._id_7AFD86C1AF40885B)) {
      level notify("civreact_terminate");

      if(getDvar("dvar_39375E00C2CAD343", "relaxed") != self._id_7AFD86C1AF40885B)
        self._id_7AFD86C1AF40885B = getDvar("dvar_39375E00C2CAD343");
    }

    wait 1;
  }
}

_id_5E218E270551F5BE(asmname) {
  thread _id_8410016CF6AB1371();
  thread _id_D338069F6A281787();
}

_id_1B1EA30E9847989B(_id_655FF8A25D65DF4B) {
  _id_C70400922BCCCE61 = distance(_id_655FF8A25D65DF4B.origin, self.origin);
  _id_8911F71726832879 = _id_C70400922BCCCE61 / level._id_F62B6E59C0E00D48._id_FFC29105FD388648 + randomfloat(0, 0.5) * 1000;
  _id_9D58E322FDC1E5E9 = _id_8911F71726832879 + gettime();

  if(isDefined(self._id_22C53A5480553773) < _id_9D58E322FDC1E5E9) {
    return;
  }
  self._id_1AF0972AD4121C5D._id_47854D572E97B41F = "bulletfired";
  self._id_1AF0972AD4121C5D._id_650D1900B21E2BD1 = _id_655FF8A25D65DF4B.origin;
  self._id_1AF0972AD4121C5D._id_27F5CD190B4A24C3 = gettime();
  self notify("CapCivReact_HandleBulletFired");
  self endon("CapCivReact_HandleBulletFired");
  wait(_id_8911F71726832879);
}

_id_D338069F6A281787() {
  for(;;) {
    self waittill("cap_event", eventname, _id_655FF8A25D65DF4B);

    switch (eventname) {
      case "bulletfired":
        _id_1B1EA30E9847989B(_id_655FF8A25D65DF4B);
    }
  }
}

_id_B92973CDB6DC3F38() {
  target = self._blackboard._id_610CB18ECC1AF719;
  return target;
}

_id_20EFA2E633463448(asmname, statename, params) {
  _id_1CE107DF41384E28 = self;

  if(isDefined(self._id_34DF90223221B7A6)) {
    _id_34DF90223221B7A6 = level._id_6961D0344027496F[self._id_34DF90223221B7A6];
    index = 0;

    for(_id_89D86711A7226025 = 0; _id_89D86711A7226025 < _id_34DF90223221B7A6.size; _id_89D86711A7226025++) {
      if(isalive(_id_34DF90223221B7A6[_id_89D86711A7226025])) {
        _id_1CE107DF41384E28 = _id_34DF90223221B7A6[_id_89D86711A7226025];
        break;
      }
    }
  }

  player_target = _id_B92973CDB6DC3F38();

  if(!isDefined(player_target))
    target = scripts\asm\shared\utility::_id_75996A8DAC6970F2(1024);
  else
    target = player_target.origin;

  _id_935CE979BB3EF270 = vectortoyaw(target - _id_1CE107DF41384E28.origin);
  _id_077B9E4B599269EB = angleclamp180(_id_935CE979BB3EF270 - _id_1CE107DF41384E28.angles[1]);
  turnanim = undefined;

  if(isDefined(params) && params == "cardinal") {
    _id_5263A610669EFA35 = abs(_id_077B9E4B599269EB);
    animindex = "2";

    if(_id_5263A610669EFA35 > 135)
      animindex = "8";
    else if(_id_077B9E4B599269EB > 45 && _id_077B9E4B599269EB <= 135)
      animindex = "6";
    else if(_id_077B9E4B599269EB >= -135 && _id_077B9E4B599269EB < -45)
      animindex = "4";

    turnanim = _id_4E1D4DD23699A8A4::_id_18E6C36C02A94DBD(statename, animindex);
  } else {
    _id_3FBFA3AB7B1FB0F2 = ["2", "3", "6", "9", "8", "7", "4", "1", "2"];
    animindex = getangleindex(_id_077B9E4B599269EB, 22.5);
    turnanim = _id_4E1D4DD23699A8A4::_id_18E6C36C02A94DBD(statename, _id_3FBFA3AB7B1FB0F2[animindex]);
  }

  return turnanim;
}

_id_14D651E2254BB00D(asmname, _id_8F4EF4FDB5E7800A, _id_93279C66A2E49A45, params) {
  if(isDefined(params) && params == "return") {
    angles = self._id_A70672E669CA7F00;
    _id_077B9E4B599269EB = angleclamp180(angles[1] - self.angles[1]);
    _id_3ADA4C6E49483364 = 22.5;
    return abs(_id_077B9E4B599269EB) > _id_3ADA4C6E49483364;
  }

  target = _id_B92973CDB6DC3F38();

  if(isDefined(target)) {
    _id_7F96D62F3ABBF9B9 = target.origin - self.origin;
    _id_935CE979BB3EF270 = vectortoyaw(_id_7F96D62F3ABBF9B9);
    _id_3ADA4C6E49483364 = 45;

    if(!isai(self)) {
      _id_B047D1B68E9701C9 = lengthsquared(_id_7F96D62F3ABBF9B9);
      _id_706FE99CE1EFA2B7 = [[300, 23], [0, 45]];

      foreach(_id_CBF22C9EDB76E72D in _id_706FE99CE1EFA2B7) {
        _id_50F1AC2AFF931B50 = _id_CBF22C9EDB76E72D[0] * _id_CBF22C9EDB76E72D[0];

        if(_id_B047D1B68E9701C9 > _id_50F1AC2AFF931B50) {
          _id_3ADA4C6E49483364 = _id_CBF22C9EDB76E72D[1];
          break;
        }
      }
    }

    _id_077B9E4B599269EB = angleclamp180(_id_935CE979BB3EF270 - self.angles[1]);

    if(abs(_id_077B9E4B599269EB) > _id_3ADA4C6E49483364)
      return 1;
  }

  return 0;
}

_id_6E1CBD20DCAECF31(asmname, statename, params) {
  if(isDefined(params) && isstring(params) && params == "return")
    self._blackboard._id_7460B96395361857 = self._blackboard._id_C71A487341C700F3;

  _id_4E1D4DD23699A8A4::_id_59308D53CABCDFDB(asmname, statename);
}

_id_99F3112F53606865(asmname, statename, params) {
  self endon(statename + "_finished");
  turnanim = scripts\asm\asm::asm_getanim(asmname, statename);
  _id_19B744B1CDEE4BCB = scripts\asm\asm::asm_getxanim(statename, turnanim);
  self.useanimgoalweight = 1;
  rate = 1;

  if(isai(self)) {
    if(isDefined(params)) {
      if(isDefined(params[0])) {
        _id_9622B10EA4ACBC01 = params[0];
        _id_4E1D4DD23699A8A4::_id_F9D6133768491200(_id_19B744B1CDEE4BCB, _id_9622B10EA4ACBC01);
      }
    } else
      self _meth_1C339DAABA3F71DB(0);

    self aisetanim(statename, turnanim, rate);
  } else {
    _id_34EE65B16925D791 = scripts\asm\asm::asm_lookupanimfromalias("knobs", "body");
    _id_A0917315F76AB3F2 = scripts\asm\asm::asm_getxanim("knobs", _id_34EE65B16925D791);
    self setflaggedanimknoballrestart(statename, _id_19B744B1CDEE4BCB, _id_A0917315F76AB3F2, 1, 0.2, 1.0);
  }

  if(!isDefined(params) || params[1])
    thread _id_737C17A2F5F59183(_id_19B744B1CDEE4BCB, statename);

  if(!isai(self))
    thread _id_5C8FF3350D31CCF2(_id_19B744B1CDEE4BCB, statename);

  _id_3931FF7E891D898F = scripts\asm\asm::asm_getnotehandler(asmname, statename);
  scripts\asm\asm::asm_donotetracks(asmname, statename, _id_3931FF7E891D898F);
}

_id_5C8FF3350D31CCF2(_id_19B744B1CDEE4BCB, statename) {
  self endon("death");
  animlength = getanimlength(_id_19B744B1CDEE4BCB);
  _id_81FD142C74A485F3 = animlength / 0.4;
  interval = animlength / _id_81FD142C74A485F3;
  contents = scripts\engine\trace::create_solid_ai_contents(1);

  for(trace = 0; trace < _id_81FD142C74A485F3; trace++) {
    wait(interval);
    self.origin = scripts\engine\utility::drop_to_ground(self.origin, 30, -30, undefined, contents);
  }
}

_id_737C17A2F5F59183(_id_19B744B1CDEE4BCB, statename) {
  self endon("death");
  self endon(statename + "_finished");
  enemy = _id_B92973CDB6DC3F38();

  if(!isDefined(enemy)) {
    return;
  }
  enemy endon("death");
  animlength = getanimlength(_id_19B744B1CDEE4BCB);

  if(animhasnotetrack(_id_19B744B1CDEE4BCB, "start_aim")) {
    _id_6AA303AAB36EA0EA = getnotetracktimes(_id_19B744B1CDEE4BCB, "start_aim");
    animlength = animlength * _id_6AA303AAB36EA0EA[0];
  } else if(animhasnotetrack(_id_19B744B1CDEE4BCB, "finish")) {
    _id_6AA303AAB36EA0EA = getnotetracktimes(_id_19B744B1CDEE4BCB, "finish");
    animlength = animlength * _id_6AA303AAB36EA0EA[0];
  }

  _id_7E3211AE44B15B55 = int(animlength * 20);
  _id_0C3DDCD0C37A60C5 = _id_7E3211AE44B15B55;

  if(isai(self)) {
    while(_id_0C3DDCD0C37A60C5 > 0) {
      _id_6BDB8335862F56EE = 1 / _id_0C3DDCD0C37A60C5;
      _id_A0F270EA6DC74BF3 = angleclamp180(vectortoyaw(enemy.origin - self.origin) - self.angles[1]);
      _id_03572E193DBCA166 = undefined;
      _id_03572E193DBCA166 = self aigetanimtime(_id_19B744B1CDEE4BCB);
      _id_993A8F9635E274CF = getangledelta(_id_19B744B1CDEE4BCB, _id_03572E193DBCA166, 1.0);
      _id_B1CBDF386B2C0DEA = angleclamp180(_id_A0F270EA6DC74BF3 - _id_993A8F9635E274CF);
      self orientmode("face angle", angleclamp(self.angles[1] + _id_B1CBDF386B2C0DEA * _id_6BDB8335862F56EE));
      _id_0C3DDCD0C37A60C5--;
      wait 0.05;
    }
  } else {
    while(_id_0C3DDCD0C37A60C5 > 0) {
      _id_6BDB8335862F56EE = 1 / _id_0C3DDCD0C37A60C5;
      _id_A0F270EA6DC74BF3 = angleclamp180(vectortoyaw(enemy.origin - self.origin) - self.angles[1]);
      _id_03572E193DBCA166 = undefined;
      _id_03572E193DBCA166 = self getanimtime(_id_19B744B1CDEE4BCB);
      _id_993A8F9635E274CF = getangledelta(_id_19B744B1CDEE4BCB, _id_03572E193DBCA166, 1.0);
      _id_B1CBDF386B2C0DEA = angleclamp180(_id_A0F270EA6DC74BF3 - _id_993A8F9635E274CF);
      yaw = angleclamp(self.angles[1] + _id_B1CBDF386B2C0DEA * _id_6BDB8335862F56EE);
      self.angles = (0, yaw, 0);
      _id_0C3DDCD0C37A60C5--;
      wait 0.05;
    }
  }
}

playturnanim_cleanup(asmname, statename, params) {
  self.useanimgoalweight = 0;
}

_id_25D4EBB35DB59893(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(istrue(self._blackboard._id_B9FE3860C557E5D6))
    return 0;

  if(self._id_7AFD86C1AF40885B == "cower")
    return 1;

  if(isDefined(self._blackboard._id_41830459EFDAF2AA) && gettime() >= self._blackboard._id_41830459EFDAF2AA)
    return 1;

  return 0;
}

_id_094EA0CA02F4D957(asmname, statename, params) {
  if(randomint(100) < 30)
    self._blackboard._id_41830459EFDAF2AA = gettime() + randomintrange(3000, 5000);

  _id_4E1D4DD23699A8A4::_id_59308D53CABCDFDB(asmname, statename, params);
}

_id_8C45FEC62914F2E3(asmname, statename, params) {
  self._blackboard._id_41830459EFDAF2AA = undefined;
}

_id_C8421BB477A45B8A(_id_A234A65C378F3289) {
  if(!isai(self)) {
    return;
  }
  if(_id_A234A65C378F3289 == "hp_on") {
    self _meth_1C339DAABA3F71DB(1);
    self _meth_5621E511B99964A7(level.player);
  }

  if(_id_A234A65C378F3289 == "hp_off")
    self _meth_1C339DAABA3F71DB(0);
}

_id_15330EE53A46289D(asmname, _id_A896DBD95A7BB191, _id_F2B19B25D457C2A6, params) {
  _id_E1054BD0481CBF85 = istrue(self._blackboard._id_AF9E2D62DD7DA3C3);
  self._blackboard._id_AF9E2D62DD7DA3C3 = undefined;
  return _id_E1054BD0481CBF85;
}

_id_FBBCD3A4D551644C(asmname, statename, params) {
  if(self._blackboard._id_40A41C70824FA4C4 == "b")
    return _id_4E1D4DD23699A8A4::_id_A0DFEEA159AA7F64(asmname, statename, "a_to_b");
  else
    return _id_4E1D4DD23699A8A4::_id_A0DFEEA159AA7F64(asmname, statename, "b_to_a");
}

_id_10E9A7601AEF9C43(asmname, statename, params) {
  if(_id_4E1D4DD23699A8A4::_id_F179EDE0989E6734(statename, "a")) {
    if(!isDefined(self._blackboard._id_40A41C70824FA4C4))
      self._blackboard._id_40A41C70824FA4C4 = "a";

    return _id_4E1D4DD23699A8A4::_id_A0DFEEA159AA7F64(asmname, statename, self._blackboard._id_40A41C70824FA4C4);
  }

  return _id_4E1D4DD23699A8A4::_id_A0DFEEA159AA7F64(asmname, statename, params);
}

_id_F914D9ABA63DED76(asmname, _id_A896DBD95A7BB191, _id_F2B19B25D457C2A6, params) {
  if(!_id_15330EE53A46289D(asmname, _id_A896DBD95A7BB191, _id_F2B19B25D457C2A6, params))
    return 0;

  _id_59848583905B2E3E = _id_4E1D4DD23699A8A4::_id_F179EDE0989E6734(_id_A896DBD95A7BB191, "a");

  if(_id_59848583905B2E3E) {
    if(self._blackboard._id_40A41C70824FA4C4 == "a")
      self._blackboard._id_40A41C70824FA4C4 = "b";
    else
      self._blackboard._id_40A41C70824FA4C4 = "a";
  }

  return _id_59848583905B2E3E;
}

_id_D609E4EA4F9848A4(asmname, _id_A896DBD95A7BB191, _id_F2B19B25D457C2A6, params) {
  return istrue(self._id_C492EECAD94293BE);
}

_id_826677291F544DA5(asmname, statename, _id_F2B19B25D457C2A6, param) {
  _id_29074E84B454250F = 320;

  if(isDefined(param))
    _id_29074E84B454250F = param;

  return self pathdisttogoal() < _id_29074E84B454250F;
}

_id_1BB354204EB3D271(asmname, statename, _id_F2B19B25D457C2A6, param) {
  if(!isDefined(self._id_6FCA5C68CC5F9550))
    return 0;

  if(!isDefined(param))
    return 0;

  return self._id_6FCA5C68CC5F9550 == param;
}
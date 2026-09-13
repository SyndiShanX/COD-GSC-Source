/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_15cba36f180ab171.gsc
***********************************************/

_id_7142C6E9236C9683() {
  level._id_BB0266F422D9AFA3["agentTacCam"] = spawnStruct();
  _id_55DDD213C3E34C53();
  _id_03D6A680D27D4B77();
}

_id_03D6A680D27D4B77() {
  _id_195D2E0ED33C2A87 = level.struct_class_names["script_noteworthy"]["trapper_taccam"];

  if(!isDefined(_id_195D2E0ED33C2A87)) {
    return;
  }
  foreach(node in _id_195D2E0ED33C2A87)
  _id_70E28195E1F4871E(node, node.origin, 1);
}

_id_55DDD213C3E34C53() {
  _id_962A30A9BB8C0F09 = _id_1311C5C284DD1537::_id_F0698AEE89C18210("agentTacCam");
  _id_962A30A9BB8C0F09._id_5237A188CCDA4D7B = "super_tac_camera";
  _id_962A30A9BB8C0F09.lifetime = getdvarint("dvar_13717E6E87CB530F", 120);
  _id_962A30A9BB8C0F09._id_4C663252DABD1483 = ::_id_F44B37D060D14EB5;
  _id_962A30A9BB8C0F09._id_D6FDC3B56B33F4E3 = _id_51F5154861435B1E::_id_7ACC5AA2B73FE93B;
  _id_962A30A9BB8C0F09._id_273F2A99F4833F00 = _id_51F5154861435B1E::_id_DAF83774B715C487;
  _id_962A30A9BB8C0F09._id_547E8B267C03D017 = _id_51F5154861435B1E::_id_1EE10C87668846D9;
  _id_962A30A9BB8C0F09._id_1EB35A5A7992E498 = _id_51F5154861435B1E::_id_7ACC5AA2B73FE93B;
  _id_962A30A9BB8C0F09._id_06E5F6320607EB69 = _id_51F5154861435B1E::_id_A60052D904A2D492;
  _id_962A30A9BB8C0F09._id_4FBADC7102D30912 = 250000;
  _id_962A30A9BB8C0F09._id_16187E4D354C3C97 = 250000;
  _id_962A30A9BB8C0F09._id_57B8F3BCFCA33A4B = 3.0;
  _id_962A30A9BB8C0F09._id_91389DD68A70BE33 = "equip_tactical_cam_marking";
  _id_962A30A9BB8C0F09.maxhealth = 100;
  _id_962A30A9BB8C0F09._id_604C545B594E97EC = ::_id_6A2036B8607B2FA6;
  _id_962A30A9BB8C0F09._id_4F1335FCE3765DA0 = ::_id_7B5CBF35F63BA5D2;
  _id_962A30A9BB8C0F09._id_58906CC2DED735DB = scripts\engine\trace::create_contents(1, 0, 0, 1, 0, 1, 0, 1, 1);
  _id_962A30A9BB8C0F09._id_0106BF36856A998F = getEntArray("tacCameraInvalid", "targetname");
}

_id_4F7FC48F506A21F3() {
  _id_C9E94F33FD62D9CF = self getvieworigin();
  _id_655F4170C63B668C = self getplayerangles();
  _id_738A7094C7BFDE17 = anglesToForward(_id_655F4170C63B668C);
  _id_3EB394D231FB9C74 = _id_C9E94F33FD62D9CF + _id_738A7094C7BFDE17 * 256;
  _id_2FC7B90001702E5C = self;
  _id_E76C084D206CFB7F = _id_1311C5C284DD1537::_id_F0698AEE89C18210("agentTacCam")._id_58906CC2DED735DB;
  _id_F17A61AFB63DFD27 = scripts\engine\trace::ray_trace(_id_C9E94F33FD62D9CF, _id_3EB394D231FB9C74, _id_2FC7B90001702E5C, _id_E76C084D206CFB7F, 0, 0, 1);

  if(_id_F17A61AFB63DFD27["hittype"] == "hittype_none") {
    return;
  }
  _id_A0377A1DAF3300D0 = _id_F17A61AFB63DFD27["position"];
  _id_A4387F1E6D5EABA7 = scripts\engine\math::vector_project_onto_plane(vectorNormalize(self.origin - _id_F17A61AFB63DFD27["position"]), _id_F17A61AFB63DFD27["normal"]);
  _id_D924F30F835C73B7 = _id_F17A61AFB63DFD27["normal"];
  _id_DF8625CE05B92B48 = vectorcross(_id_A4387F1E6D5EABA7, _id_D924F30F835C73B7);
  _id_3A43D29B943AAF0C = axistoangles(_id_A4387F1E6D5EABA7, _id_DF8625CE05B92B48, _id_D924F30F835C73B7);
  _id_282B1925C4AF6F1F = spawnStruct();
  _id_282B1925C4AF6F1F.origin = _id_A0377A1DAF3300D0;
  _id_282B1925C4AF6F1F.angles = _id_3A43D29B943AAF0C;
  _id_70E28195E1F4871E(_id_282B1925C4AF6F1F, _id_A0377A1DAF3300D0);
}

_id_70E28195E1F4871E(_id_282B1925C4AF6F1F, _id_A0377A1DAF3300D0, _id_27C432C46E32BE45) {
  camera = _id_1311C5C284DD1537::_id_EE24B83D39692536(_id_282B1925C4AF6F1F, undefined, _id_A0377A1DAF3300D0, "tactical_camera_turret_mp", "turret_tactical_camera_v0", "agentTacCam", 1);
  camera setmode("manual");
  camera._id_D20DFBBBCD940269 = 1;
  camera._id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(camera.origin);

  if(!istrue(_id_27C432C46E32BE45))
    camera thread _id_1311C5C284DD1537::_id_B3B59C099F93A503(1);

  camera thread _id_7CD9C9609B1D3FE2();
  camera thread _id_1311C5C284DD1537::_id_23CF186C8B512748();
}

_id_F44B37D060D14EB5() {
  self notify("death");
  self.isdestroyed = 1;
  self setscriptablepartstate("destroyed", "on", 0);
  scripts\mp\outline::outlinedisableinternalall(self);
  wait 0.1;
  self delete();
}

_id_7B5CBF35F63BA5D2(data) {
  if(!isDefined(self) || istrue(self.isdestroyed))
    return 0;

  if(data.meansofdeath == "MOD_IMPACT")
    return 0;

  _id_415AF0EA29077AD9 = data.damage;
  hits = undefined;

  if(isexplosivedamagemod(data.meansofdeath))
    hits = _id_35FE12B0D93B4BEE(data);
  else if(scripts\engine\utility::isbulletdamage(data.meansofdeath))
    hits = _id_A6BD73D933B524E3(data);

  if(isDefined(hits))
    _id_415AF0EA29077AD9 = int(ceil(min(1, hits / 5) * self.maxhealth));

  if(self.damagetaken + _id_415AF0EA29077AD9 / self.maxhealth > 0.5) {
    if(!istrue(self._id_325727B6C2E7F058)) {
      self._id_325727B6C2E7F058 = 1;
      self setscriptablepartstate("damaged", "on", 0);
    }
  }

  return _id_415AF0EA29077AD9;
}

_id_6A2036B8607B2FA6(data) {
  attacker = data.attacker;

  if(!isDefined(data.attacker)) {
    return;
  }
  if(scripts\mp\utility\teams::_id_44A6F98CC3C0F5F4(attacker.team)) {}

  if(isPlayer(attacker)) {
    attacker notify("destroyed_equipment");
    attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_1EE8D6BCAF4366BE");
    attacker thread scripts\mp\battlechatter_mp::_id_883240EB5234490E("stat_0511AC9E9A1A18D8");
  }

  _id_F44B37D060D14EB5();
}

_id_35FE12B0D93B4BEE(data, _id_10D243B75EC6D6AE) {
  if(data.damage > 200)
    return 20;

  if(data.damage > 70)
    return 10;
  else if(data.damage > 30)
    return 7;
  else
    return 2;
}

_id_A6BD73D933B524E3(data, _id_10D243B75EC6D6AE) {
  _id_2DDCAF824AC5D676 = scripts\engine\utility::ter_op(scripts\mp\utility\damage::isfmjdamage(data.objweapon, data.meansofdeath) && _id_10D243B75EC6D6AE, 2, 0);

  if(data.damage > 150)
    return _id_2DDCAF824AC5D676 + 10;

  if(data.damage >= 50)
    return _id_2DDCAF824AC5D676 + 5;
  else if(data.damage >= 30)
    return _id_2DDCAF824AC5D676 + 3;
  else if(data.damage >= 20)
    return _id_2DDCAF824AC5D676 + 2;
  else
    return _id_2DDCAF824AC5D676 + 1;
}

_id_7CD9C9609B1D3FE2() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    _id_1311C5C284DD1537::_id_C57955CDA07E6609();

    foreach(targetarray in level._id_E725F44030790232 scripts\engine\utility::_id_0DF633F460888A47(self.origin)) {
      foreach(ent in targetarray) {
        if(!isDefined(ent)) {
          continue;
        }
        if(isPlayer(ent) || isbot(ent)) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
            if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](ent))
              continue;
          }
        }

        if(isagent(ent)) {
          continue;
        }
        if(scripts\cp_mp\emp_debuff::is_empd()) {
          continue;
        }
        _id_368AE33CB19F91F8 = _id_1311C5C284DD1537::_id_9D2BEC87E0754872(ent);

        if(!_id_368AE33CB19F91F8._id_C37B1CC67943336D || !_id_368AE33CB19F91F8.isindetectrange) {
          continue;
        }
        if(istrue(self.markingtarget)) {
          continue;
        }
        _id_97D222273F4855E1(ent);
      }
    }

    wait 0.25;
  }
}

_id_97D222273F4855E1(_id_A154D4EEE7C22634) {
  self settargetentity(_id_A154D4EEE7C22634);
  _id_82F58D57625E59EE = 0;
  _id_CD79A3C4966F6169 = getdvarfloat("dvar_6CB0CF97F8AE3387", 3.0);

  while(_id_82F58D57625E59EE < _id_CD79A3C4966F6169) {
    _id_368AE33CB19F91F8 = _id_1311C5C284DD1537::_id_9D2BEC87E0754872(_id_A154D4EEE7C22634);

    if(!_id_368AE33CB19F91F8._id_C37B1CC67943336D || !_id_368AE33CB19F91F8.isindetectrange) {
      self cleartargetentity();
      return;
    }

    _id_82F58D57625E59EE = _id_82F58D57625E59EE + level.framedurationseconds;
    waitframe();
  }

  _id_6A8EC730B2BFA844::_id_800F75FE5E5C7462(_id_A154D4EEE7C22634, self);
  _id_312239156654C258(_id_A154D4EEE7C22634);

  if(isDefined(level._id_E7C5EB1E41445C13))
    self[[level._id_E7C5EB1E41445C13]](_id_A154D4EEE7C22634);

  _id_86F2D395B5545B01(_id_A154D4EEE7C22634);
}

_id_312239156654C258(_id_A154D4EEE7C22634) {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self._id_F489AABFE37A8AFA))
    self._id_F489AABFE37A8AFA = [];

  if(scripts\engine\utility::array_contains_key(self._id_F489AABFE37A8AFA, _id_A154D4EEE7C22634.team)) {
    return;
  }
  self._id_F489AABFE37A8AFA[_id_A154D4EEE7C22634.team] = [_id_A154D4EEE7C22634.team];
  id = scripts\mp\utility\outline::outlineenableforteam(self, _id_A154D4EEE7C22634.team, "spotter_notarget_equipment", "perk_superior");
}

_id_86F2D395B5545B01(_id_A154D4EEE7C22634) {
  timer = 0.0;

  for(;;) {
    _id_A154D4EEE7C22634 thread _id_1311C5C284DD1537::_id_7D61D7B52C318D47();
    _id_A154D4EEE7C22634 _id_1311C5C284DD1537::_id_748F3520A7E525A9();
    _id_A154D4EEE7C22634 playlocalsound("recon_drone_spotted_plr");
    _id_5756E405D4393132 = undefined;

    if(isDefined(self._id_B205D90302DA2F07) && getdvarint("dvar_E242C057ECB7EE6B", 1) == 1)
      _id_5756E405D4393132 = _func_7E3F22E620F3F71E(self._id_B205D90302DA2F07, "everybody");
    else
      _id_5756E405D4393132 = scripts\common\utility::_id_2D7FD59D039FA69B(_id_A154D4EEE7C22634.origin, 800, 0);

    foreach(agent in _id_5756E405D4393132) {
      if(!isDefined(agent) || isint(agent)) {
        continue;
      }
      if(!isagent(agent)) {
        continue;
      }
      if(!isDefined(agent.team)) {
        continue;
      }
      agent getenemyinfo(_id_A154D4EEE7C22634);
    }

    for(_id_74A27E60692B4559 = getdvarfloat("dvar_476BA3B2FD5D8FEA", 5.0); timer < _id_74A27E60692B4559; timer = timer + 0.25) {
      _id_368AE33CB19F91F8 = _id_1311C5C284DD1537::_id_9D2BEC87E0754872(_id_A154D4EEE7C22634);

      if(!_id_368AE33CB19F91F8._id_C37B1CC67943336D || !_id_368AE33CB19F91F8.isindetectrange || !_id_368AE33CB19F91F8._id_9AE205C4C40AF967) {
        self cleartargetentity();
        return;
      }

      wait 0.25;
    }

    timer = 0.0;
    waitframe();
  }
}
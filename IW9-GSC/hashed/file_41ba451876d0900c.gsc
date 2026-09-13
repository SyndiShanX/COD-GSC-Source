/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_41ba451876d0900c.gsc
***********************************************/

_id_9A7305EA8EE1E807() {
  if(getdvarint("scr_starsystem", 1) == 0) {
    return;
  }
  level._id_01A6233BC0D61FAF = spawnStruct();
  level._id_01A6233BC0D61FAF._id_764198B598038F7A = getdvarfloat("dvar_2C3EABF4A542FF3C", -0.5);
  level._id_01A6233BC0D61FAF._id_814B1CA190CEB025 = getdvarfloat("dvar_BFF507E30583AF77", 2);
  level._id_01A6233BC0D61FAF._id_3459E3D70AE933C3 = getdvarfloat("dvar_2230FC7A68495B75", 0.75);
  level._id_01A6233BC0D61FAF._id_07DE1D17B0EF9138 = getdvarfloat("dvar_5C438007433D1392", 10);
  level._id_01A6233BC0D61FAF._id_B286A53C1D03306D = [];
  level._id_01A6233BC0D61FAF._id_B286A53C1D03306D[0] = getdvarint("dvar_2E473219B28F0957", 0);
  level._id_01A6233BC0D61FAF._id_B286A53C1D03306D[1] = getdvarint("dvar_2E473119B28F0724", 10);
  level._id_01A6233BC0D61FAF._id_B286A53C1D03306D[2] = getdvarint("dvar_2E473419B28F0DBD", 10);
  level._id_01A6233BC0D61FAF._id_B286A53C1D03306D[3] = getdvarint("dvar_2E473319B28F0B8A", 15);
  level._id_01A6233BC0D61FAF._id_694F28D3324AC95D = getdvarint("dvar_3FD4229CD74FF0A9", 60);
  level._id_01A6233BC0D61FAF._id_69271D52A93B872C = [];
  level._id_01A6233BC0D61FAF._id_69271D52A93B872C[0] = "star_0";
  level._id_01A6233BC0D61FAF._id_69271D52A93B872C[1] = "star_1";
  level._id_01A6233BC0D61FAF._id_69271D52A93B872C[2] = "star_2";
  level._id_01A6233BC0D61FAF._id_69271D52A93B872C[3] = "star_3";
  level._id_01A6233BC0D61FAF._id_69271D52A93B872C[4] = "star_4";
  _id_88FAF0C0E9782E83();

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    level._id_2EB4C3A1BADAF4EB = [];

    foreach(_id_171F90B9C4C76D44, _id_B205D90302DA2F07 in level._id_B205D90302DA2F07) {
      level._id_2EB4C3A1BADAF4EB[_id_171F90B9C4C76D44] = _id_BA305299CFC33C17(_id_171F90B9C4C76D44);
      level thread _id_D1E1692B79B44BF7(level._id_2EB4C3A1BADAF4EB[_id_171F90B9C4C76D44]);
    }
  } else {
    level._id_2EB4C3A1BADAF4EB = _id_BA305299CFC33C17();
    level thread _id_D1E1692B79B44BF7(level._id_2EB4C3A1BADAF4EB);
  }
}

_id_88FAF0C0E9782E83() {}

_id_AB9D237321CB489B() {
  return isDefined(level._id_01A6233BC0D61FAF);
}

_id_BA305299CFC33C17(_id_171F90B9C4C76D44) {
  struct = spawnStruct();
  struct._id_ACA1544C91A292FD = 0;
  struct._id_7444B7C0C103EA62 = 0;
  struct._id_BF18E3CC575BC1C8 = 0;
  struct._id_924D5D49FDE54CDD = 0;
  struct._id_B205D90302DA2F07 = _id_171F90B9C4C76D44;
  struct._id_19D6896C9E881CC4 = 0;
  struct._id_A93671354B676C18 = 0;
  struct._id_38951249A8CF8968 = 0;
  struct._id_FE385543116077B5 = 0;
  struct._id_55CF9E4F74D2F4C2 = 0;
  struct._id_356BDE2B53EFA8CF = 0;
  struct._id_78C53731BD6BD662 = getdvarint("dvar_245660B9079D8B97", 20);
  struct._id_959A2C4EC95E74E4 = getdvarint("dvar_3AB6352457DA46BD", 10);
  struct._id_44D539868962A537 = [];
  struct._id_4C4721224D00C1A6 = [];
  struct._id_09358CAD01A18C8C = [];
  struct._id_44D539868962A537[0] = 0;
  struct._id_4C4721224D00C1A6[0] = getdvarint("dvar_0CFAEAC4942CBDBA", 800);
  struct._id_09358CAD01A18C8C[0] = struct._id_44D539868962A537[0] + struct._id_4C4721224D00C1A6[0] * struct._id_959A2C4EC95E74E4;
  struct._id_44D539868962A537[1] = struct._id_44D539868962A537[0] + struct._id_4C4721224D00C1A6[0];
  struct._id_4C4721224D00C1A6[1] = getdvarint("dvar_1ADEAB3DAEA4A349", 800);
  struct._id_09358CAD01A18C8C[1] = struct._id_44D539868962A537[1] + struct._id_4C4721224D00C1A6[1] * struct._id_959A2C4EC95E74E4;
  struct._id_44D539868962A537[2] = struct._id_44D539868962A537[1] + struct._id_4C4721224D00C1A6[1];
  struct._id_4C4721224D00C1A6[2] = getdvarint("dvar_6FC71B67A904A550", 800);
  struct._id_09358CAD01A18C8C[2] = struct._id_44D539868962A537[2] + struct._id_4C4721224D00C1A6[2] * struct._id_959A2C4EC95E74E4;
  struct._id_44D539868962A537[3] = struct._id_44D539868962A537[2] + struct._id_4C4721224D00C1A6[2];
  struct._id_4C4721224D00C1A6[3] = getdvarint("dvar_0A93F5B948731E5F", 800);
  struct._id_09358CAD01A18C8C[3] = struct._id_44D539868962A537[3] + struct._id_4C4721224D00C1A6[3] * struct._id_959A2C4EC95E74E4;
  struct._id_44D539868962A537[4] = struct._id_44D539868962A537[3] + struct._id_4C4721224D00C1A6[3];
  struct._id_4C4721224D00C1A6[4] = getdvarint("dvar_1EC9FD7AD7047996", 800);
  struct._id_09358CAD01A18C8C[4] = struct._id_44D539868962A537[4] + struct._id_4C4721224D00C1A6[4] * struct._id_959A2C4EC95E74E4;
  struct._id_EF957EB3F2DA7E78 = struct._id_44D539868962A537[4] + struct._id_4C4721224D00C1A6[4];
  struct._id_531D3952C9F853F8 = [];
  struct._id_531D3952C9F853F8[1] = ::_id_980EBD5792A2C6CC;
  struct._id_531D3952C9F853F8[2] = ::_id_99234BD34375A46E;
  struct._id_531D3952C9F853F8[3] = ::_id_3B1D1540B3373BF3;
  struct._id_531D3952C9F853F8[4] = ::_id_48477DCD49A3487C;

  while(!isDefined(level.struct_class_names))
    waitframe();

  struct._id_B3E0E8754C8036C1 = [];
  keys = getarraykeys(level.struct_class_names["script_noteworthy"]);

  foreach(key in keys) {
    if(issubstr(key, "star_alarm")) {
      foreach(node in level.struct_class_names["script_noteworthy"][key]) {
        if(!isDefined(_id_171F90B9C4C76D44) || isDefined(_id_171F90B9C4C76D44) && isDefined(node._id_B205D90302DA2F07) && _id_171F90B9C4C76D44 == node._id_B205D90302DA2F07)
          struct._id_B3E0E8754C8036C1[struct._id_B3E0E8754C8036C1.size] = node;
      }
    }
  }

  return struct;
}

_id_0EF4A786F0DF1C25(_id_171F90B9C4C76D44) {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    if(isalive(self)) {
      if(self[[self.fnisinstealthidle]]())
        _id_668252E0E3CBCB41(level._id_01A6233BC0D61FAF._id_764198B598038F7A, _id_171F90B9C4C76D44);
      else if(self[[self.fnisinstealthinvestigate]]())
        _id_668252E0E3CBCB41(level._id_01A6233BC0D61FAF._id_3459E3D70AE933C3, _id_171F90B9C4C76D44);
      else if(self[[self.fnisinstealthcombat]]())
        _id_668252E0E3CBCB41(level._id_01A6233BC0D61FAF._id_07DE1D17B0EF9138, _id_171F90B9C4C76D44);
      else if(self[[self.fnisinstealthhunt]]())
        _id_668252E0E3CBCB41(level._id_01A6233BC0D61FAF._id_814B1CA190CEB025, _id_171F90B9C4C76D44);
    }

    wait 1;
  }
}

_id_96B7B6431450DFC0(num, _id_171F90B9C4C76D44) {
  if(!isDefined(level._id_2EB4C3A1BADAF4EB)) {
    return;
  }
  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    if(isDefined(_id_171F90B9C4C76D44) && isDefined(level._id_2EB4C3A1BADAF4EB[_id_171F90B9C4C76D44]))
      level._id_2EB4C3A1BADAF4EB[_id_171F90B9C4C76D44]._id_A93671354B676C18 = level._id_2EB4C3A1BADAF4EB[_id_171F90B9C4C76D44]._id_A93671354B676C18 + num;
  } else
    level._id_2EB4C3A1BADAF4EB._id_A93671354B676C18 = level._id_2EB4C3A1BADAF4EB._id_A93671354B676C18 + num;
}

_id_D31C64471A8C8CDC(_id_2EB4C3A1BADAF4EB) {
  _id_2EB4C3A1BADAF4EB._id_A93671354B676C18 = 0;
}

_id_508B5FBDFB92174B(_id_2EB4C3A1BADAF4EB, _id_FF838F13C8CA3B6C) {
  _id_D20B756C31149D97 = _id_2EB4C3A1BADAF4EB._id_ACA1544C91A292FD + 1;

  if(!isDefined(_id_2EB4C3A1BADAF4EB._id_44D539868962A537[_id_D20B756C31149D97]))
    return 0;

  if(_id_FF838F13C8CA3B6C > _id_2EB4C3A1BADAF4EB._id_44D539868962A537[_id_D20B756C31149D97])
    return 1;

  return 0;
}

_id_2E2C47DFFA46541C(_id_2EB4C3A1BADAF4EB, _id_FF838F13C8CA3B6C) {
  _id_DF84DA956C680B60 = 0;
  _id_F427145F8D539385 = 0;

  if(_id_2EB4C3A1BADAF4EB._id_A93671354B676C18 >= level._id_01A6233BC0D61FAF._id_B286A53C1D03306D[_id_2EB4C3A1BADAF4EB._id_ACA1544C91A292FD])
    _id_DF84DA956C680B60 = 1;

  _id_D20B756C31149D97 = _id_2EB4C3A1BADAF4EB._id_ACA1544C91A292FD + 1;

  if(isDefined(_id_2EB4C3A1BADAF4EB._id_44D539868962A537[_id_D20B756C31149D97]) && _id_FF838F13C8CA3B6C >= _id_2EB4C3A1BADAF4EB._id_44D539868962A537[_id_D20B756C31149D97])
    _id_F427145F8D539385 = 1;

  _id_2EB4C3A1BADAF4EB._id_19D6896C9E881CC4 = _id_DF84DA956C680B60 && _id_F427145F8D539385;
  return _id_2EB4C3A1BADAF4EB._id_19D6896C9E881CC4;
}

_id_49CC3E444148F214(_id_2EB4C3A1BADAF4EB, _id_FF838F13C8CA3B6C) {
  _id_2EB4C3A1BADAF4EB._id_ACA1544C91A292FD++;
  _id_2EB4C3A1BADAF4EB._id_7444B7C0C103EA62 = _id_FF838F13C8CA3B6C;
  _id_D31C64471A8C8CDC(_id_2EB4C3A1BADAF4EB);
  _id_48814951E916AF89::_id_374ECACAD63BB411(level._id_01A6233BC0D61FAF._id_694F28D3324AC95D, _id_2EB4C3A1BADAF4EB._id_B205D90302DA2F07, "Star Level Up");
  playerlist = level._id_B205D90302DA2F07[_id_2EB4C3A1BADAF4EB._id_B205D90302DA2F07]["players"];
  _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("stars_rank_up", playerlist);

  if(isDefined(_id_2EB4C3A1BADAF4EB._id_531D3952C9F853F8[_id_2EB4C3A1BADAF4EB._id_ACA1544C91A292FD]))
    [[_id_2EB4C3A1BADAF4EB._id_531D3952C9F853F8[_id_2EB4C3A1BADAF4EB._id_ACA1544C91A292FD]]](_id_2EB4C3A1BADAF4EB);

  _id_805E6E206039FD0A = [];

  if(isDefined(_id_2EB4C3A1BADAF4EB._id_B205D90302DA2F07)) {
    foreach(_id_D1CF55B36FACF5A8 in level._id_B205D90302DA2F07[_id_2EB4C3A1BADAF4EB._id_B205D90302DA2F07]["subAreas"])
    _id_805E6E206039FD0A = scripts\engine\utility::array_combine(_id_805E6E206039FD0A, _id_D1CF55B36FACF5A8._id_3EBB6024E3F220CA);
  } else
    _id_805E6E206039FD0A = level.agentarray;

  foreach(agent in _id_805E6E206039FD0A) {
    if(isalive(agent))
      _id_E04DBE0BD8A25BE7(agent, _id_2EB4C3A1BADAF4EB._id_ACA1544C91A292FD);
  }
}

_id_BEA7986171A218FE(_id_2EB4C3A1BADAF4EB, _id_FF838F13C8CA3B6C) {
  _id_8E3F400CE6C5FED2 = _id_2EB4C3A1BADAF4EB._id_ACA1544C91A292FD - 1;

  if(!isDefined(_id_2EB4C3A1BADAF4EB._id_44D539868962A537[_id_8E3F400CE6C5FED2]))
    return 0;

  if(_id_FF838F13C8CA3B6C < _id_2EB4C3A1BADAF4EB._id_44D539868962A537[_id_2EB4C3A1BADAF4EB._id_ACA1544C91A292FD])
    return 1;

  return 0;
}

_id_F4B18D11B00160C7(_id_2EB4C3A1BADAF4EB, _id_FF838F13C8CA3B6C) {
  if(_id_FF838F13C8CA3B6C <= _id_2EB4C3A1BADAF4EB._id_44D539868962A537[_id_2EB4C3A1BADAF4EB._id_ACA1544C91A292FD]) {
    if(!isDefined(_id_2EB4C3A1BADAF4EB._id_BE5918EF95F233B6))
      _id_2EB4C3A1BADAF4EB._id_BE5918EF95F233B6 = _id_2EB4C3A1BADAF4EB._id_78C53731BD6BD662;
    else if(_id_2EB4C3A1BADAF4EB._id_BE5918EF95F233B6 <= 0)
      return 1;
  }

  return 0;
}

_id_88249D3440778901(_id_2EB4C3A1BADAF4EB, _id_FF838F13C8CA3B6C) {
  _id_2EB4C3A1BADAF4EB._id_ACA1544C91A292FD--;
  _id_2EB4C3A1BADAF4EB._id_7444B7C0C103EA62 = _id_FF838F13C8CA3B6C;
  _id_D31C64471A8C8CDC(_id_2EB4C3A1BADAF4EB);
  playerlist = level._id_B205D90302DA2F07[_id_2EB4C3A1BADAF4EB._id_B205D90302DA2F07]["players"];
  roll = randomint(100);

  if(roll < 50)
    _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("stars_rank_down", playerlist);
  else
    _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("stars_calming_down", playerlist);

  _id_805E6E206039FD0A = [];

  if(isDefined(_id_2EB4C3A1BADAF4EB._id_B205D90302DA2F07)) {
    foreach(_id_D1CF55B36FACF5A8 in level._id_B205D90302DA2F07[_id_2EB4C3A1BADAF4EB._id_B205D90302DA2F07]["subAreas"])
    _id_805E6E206039FD0A = scripts\engine\utility::array_combine(_id_805E6E206039FD0A, _id_D1CF55B36FACF5A8._id_3EBB6024E3F220CA);
  } else
    _id_805E6E206039FD0A = level.agentarray;

  foreach(agent in _id_805E6E206039FD0A) {
    if(isalive(agent))
      _id_E04DBE0BD8A25BE7(agent, _id_2EB4C3A1BADAF4EB._id_ACA1544C91A292FD);
  }
}

_id_668252E0E3CBCB41(amount, _id_171F90B9C4C76D44) {
  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    if(isDefined(_id_171F90B9C4C76D44) && isDefined(level._id_2EB4C3A1BADAF4EB[_id_171F90B9C4C76D44]))
      level._id_2EB4C3A1BADAF4EB[_id_171F90B9C4C76D44]._id_BF18E3CC575BC1C8 = level._id_2EB4C3A1BADAF4EB[_id_171F90B9C4C76D44]._id_BF18E3CC575BC1C8 + amount;
    else {}
  } else
    level._id_2EB4C3A1BADAF4EB._id_BF18E3CC575BC1C8 = level._id_2EB4C3A1BADAF4EB._id_BF18E3CC575BC1C8 + amount;
}

_id_0640EE18608181B8(_id_2EB4C3A1BADAF4EB) {
  _id_A9C9CB0A720C01F6 = 0;
  [idle, _id_297E24357423A680, combat, hunt] = _id_48814951E916AF89::_id_1D52040F64B0D854(_id_2EB4C3A1BADAF4EB._id_B205D90302DA2F07);
  _id_2EB4C3A1BADAF4EB._id_38951249A8CF8968 = idle;
  _id_2EB4C3A1BADAF4EB._id_FE385543116077B5 = _id_297E24357423A680;
  _id_2EB4C3A1BADAF4EB._id_55CF9E4F74D2F4C2 = combat;
  _id_2EB4C3A1BADAF4EB._id_356BDE2B53EFA8CF = hunt;
  _id_A9C9CB0A720C01F6 = _id_A9C9CB0A720C01F6 + idle * level._id_01A6233BC0D61FAF._id_764198B598038F7A;
  _id_A9C9CB0A720C01F6 = _id_A9C9CB0A720C01F6 + _id_297E24357423A680 * level._id_01A6233BC0D61FAF._id_3459E3D70AE933C3;
  _id_A9C9CB0A720C01F6 = _id_A9C9CB0A720C01F6 + combat * level._id_01A6233BC0D61FAF._id_07DE1D17B0EF9138;
  _id_A9C9CB0A720C01F6 = _id_A9C9CB0A720C01F6 + hunt * level._id_01A6233BC0D61FAF._id_814B1CA190CEB025;
  _id_2EB4C3A1BADAF4EB._id_BF18E3CC575BC1C8 = _id_A9C9CB0A720C01F6;
}

_id_D1E1692B79B44BF7(_id_2EB4C3A1BADAF4EB) {
  _id_A771008D267585F9 = getdvarint("dvar_7E30F05F2889DC4D", 15);

  for(;;) {
    wait 1;
    _id_0640EE18608181B8(_id_2EB4C3A1BADAF4EB);
    _id_2EB4C3A1BADAF4EB._id_924D5D49FDE54CDD = _id_2EB4C3A1BADAF4EB._id_BF18E3CC575BC1C8;

    if(_id_2EB4C3A1BADAF4EB._id_BF18E3CC575BC1C8 > _id_A771008D267585F9)
      _id_2EB4C3A1BADAF4EB._id_BF18E3CC575BC1C8 = _id_A771008D267585F9;
    else if(_id_2EB4C3A1BADAF4EB._id_BF18E3CC575BC1C8 < _id_A771008D267585F9 * -1)
      _id_2EB4C3A1BADAF4EB._id_BF18E3CC575BC1C8 = _id_A771008D267585F9 * -1;

    _id_FF838F13C8CA3B6C = _id_2EB4C3A1BADAF4EB._id_7444B7C0C103EA62 + _id_2EB4C3A1BADAF4EB._id_BF18E3CC575BC1C8;
    _id_2EB4C3A1BADAF4EB._id_BF18E3CC575BC1C8 = 0;

    if(_id_FF838F13C8CA3B6C < 0)
      _id_FF838F13C8CA3B6C = 0;
    else if(_id_FF838F13C8CA3B6C > _id_2EB4C3A1BADAF4EB._id_EF957EB3F2DA7E78)
      _id_FF838F13C8CA3B6C = _id_2EB4C3A1BADAF4EB._id_EF957EB3F2DA7E78;

    if(_id_508B5FBDFB92174B(_id_2EB4C3A1BADAF4EB, _id_FF838F13C8CA3B6C)) {
      _id_4D40608A5B45999A = _id_2EB4C3A1BADAF4EB._id_ACA1544C91A292FD + 1;

      if(!_id_2E2C47DFFA46541C(_id_2EB4C3A1BADAF4EB, _id_FF838F13C8CA3B6C)) {
        if(_id_FF838F13C8CA3B6C > _id_2EB4C3A1BADAF4EB._id_44D539868962A537[_id_4D40608A5B45999A])
          _id_2EB4C3A1BADAF4EB._id_7444B7C0C103EA62 = _id_2EB4C3A1BADAF4EB._id_44D539868962A537[_id_4D40608A5B45999A];
      } else
        _id_49CC3E444148F214(_id_2EB4C3A1BADAF4EB, _id_FF838F13C8CA3B6C);

      continue;
    }

    if(_id_BEA7986171A218FE(_id_2EB4C3A1BADAF4EB, _id_FF838F13C8CA3B6C)) {
      if(!_id_F4B18D11B00160C7(_id_2EB4C3A1BADAF4EB, _id_FF838F13C8CA3B6C)) {
        if(_id_FF838F13C8CA3B6C < _id_2EB4C3A1BADAF4EB._id_44D539868962A537[_id_2EB4C3A1BADAF4EB._id_ACA1544C91A292FD])
          _id_2EB4C3A1BADAF4EB._id_7444B7C0C103EA62 = _id_2EB4C3A1BADAF4EB._id_44D539868962A537[_id_2EB4C3A1BADAF4EB._id_ACA1544C91A292FD];
      } else
        _id_88249D3440778901(_id_2EB4C3A1BADAF4EB, _id_FF838F13C8CA3B6C);

      continue;
    }

    _id_2EB4C3A1BADAF4EB._id_7444B7C0C103EA62 = _id_FF838F13C8CA3B6C;
  }
}

_id_980EBD5792A2C6CC(_id_2EB4C3A1BADAF4EB) {}

_id_99234BD34375A46E(_id_2EB4C3A1BADAF4EB) {}

_id_3B1D1540B3373BF3(_id_2EB4C3A1BADAF4EB) {
  playerlist = level._id_B205D90302DA2F07[_id_2EB4C3A1BADAF4EB._id_B205D90302DA2F07]["players"];
  roll = randomint(100);

  if(roll < 50)
    _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("dx_br_dmzo_star_ovld_thrs", playerlist);
  else
    _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("dx_br_dmzo_wost_ovld_es01", playerlist);
}

_id_48477DCD49A3487C(_id_2EB4C3A1BADAF4EB) {
  players = level.players;

  if(isDefined(_id_2EB4C3A1BADAF4EB._id_B205D90302DA2F07))
    players = level._id_B205D90302DA2F07[_id_2EB4C3A1BADAF4EB._id_B205D90302DA2F07]["players"];

  playerlist = level._id_B205D90302DA2F07[_id_2EB4C3A1BADAF4EB._id_B205D90302DA2F07]["players"];
  roll = randomint(100);

  if(roll < 50)
    _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("dx_br_dmzo_star_ovld_frst", playerlist);
  else
    _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("dx_br_dmzo_wost_ovld_es12", playerlist);
}

_id_D1C66E3A420A3E98(_id_2EB4C3A1BADAF4EB) {
  if(getdvarint("dvar_0ED3AAB295415580", 1) == 1) {
    return;
  }
  foreach(loc in _id_2EB4C3A1BADAF4EB._id_B3E0E8754C8036C1) {
    loc.ent = spawn("script_origin", loc.origin);
    loc.ent playSound("mp_dmz_alrm_star");
  }

  wait 10;

  foreach(loc in _id_2EB4C3A1BADAF4EB._id_B3E0E8754C8036C1) {
    if(isDefined(loc.ent))
      loc.ent delete();
  }
}

_id_5CC0C507E92F7B47(_id_171F90B9C4C76D44) {
  if(!_id_AB9D237321CB489B())
    return 0;

  _id_2EB4C3A1BADAF4EB = level._id_2EB4C3A1BADAF4EB;

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    if(!isDefined(_id_171F90B9C4C76D44))
      return 0;

    _id_2EB4C3A1BADAF4EB = level._id_2EB4C3A1BADAF4EB[_id_171F90B9C4C76D44];
  }

  if(!isDefined(_id_2EB4C3A1BADAF4EB))
    return 0;

  if(!isDefined(_id_2EB4C3A1BADAF4EB._id_ACA1544C91A292FD))
    return 0;

  return _id_2EB4C3A1BADAF4EB._id_ACA1544C91A292FD;
}

_id_5B1718FC79719CEE() {
  level endon("game_ended");
  self endon("death");
  self endon("enter_combat");

  for(;;) {
    scripts\engine\utility::ent_flag_wait("stealth_enabled");
    self waittill("ai_events", events);

    if(!scripts\engine\utility::ent_flag("stealth_enabled")) {
      continue;
    }
    foreach(event in events) {
      switch (event.type) {
        case "projectile_impact":
        case "gunshot":
        case "silenced_shot":
        case "gunshot_teammate":
        case "bulletwhizby":
        case "explode":
          break;
        case "combat":
          level._id_2EB4C3A1BADAF4EB.combat++;
          thread _id_54CF9ED49D765153();
          break;
        default:
          break;
      }

      _id_BC6F0A38C4A175EC(event.type);
    }
  }
}

_id_54CF9ED49D765153() {}

_id_BC6F0A38C4A175EC(eventtype) {
  if(level._id_2EB4C3A1BADAF4EB._id_E043DAEB0EEA11A5 == 10)
    level._id_2EB4C3A1BADAF4EB._id_E043DAEB0EEA11A5 = 0;

  level._id_2EB4C3A1BADAF4EB._id_6BB7CDEA823D6703[level._id_2EB4C3A1BADAF4EB._id_E043DAEB0EEA11A5] = eventtype;
}

_id_E04DBE0BD8A25BE7(agent, _id_ACA1544C91A292FD) {
  if(!_id_AB9D237321CB489B()) {
    return;
  }
  _id_A938130624194F25 = undefined;
  _id_2D7F3CDC8B58D624 = undefined;
  _id_8217369571009C81 = 0;

  if(!isDefined(_id_ACA1544C91A292FD))
    _id_ACA1544C91A292FD = 0;

  if(isDefined(level._id_E429F4A597493802) && isDefined(level._id_E429F4A597493802[_id_ACA1544C91A292FD]))
    _id_0469C0474CA81122 = level._id_E429F4A597493802[_id_ACA1544C91A292FD];
  else
    _id_0469C0474CA81122 = level._id_01A6233BC0D61FAF._id_69271D52A93B872C[_id_ACA1544C91A292FD];

  switch (_id_ACA1544C91A292FD) {
    case 0:
      _id_A938130624194F25 = _id_0469C0474CA81122;
      _id_2D7F3CDC8B58D624 = 5;
      break;
    case 1:
      _id_A938130624194F25 = _id_0469C0474CA81122;
      _id_2D7F3CDC8B58D624 = 6;
      break;
    case 2:
      _id_A938130624194F25 = _id_0469C0474CA81122;
      _id_2D7F3CDC8B58D624 = 7;
      break;
    case 3:
      _id_A938130624194F25 = _id_0469C0474CA81122;
      _id_2D7F3CDC8B58D624 = 8;
      _id_8217369571009C81 = 1;
      break;
    case 4:
      _id_A938130624194F25 = _id_0469C0474CA81122;
      _id_2D7F3CDC8B58D624 = 10;
      _id_8217369571009C81 = 1;
      break;
    default:
      _id_A938130624194F25 = "star_0";
      _id_2D7F3CDC8B58D624 = 5;
  }

  _id_48814951E916AF89::_id_C9DAD3876B9D8755(agent, _id_A938130624194F25);
  _id_48814951E916AF89::_id_F55D225B544277E8(agent, _id_2D7F3CDC8B58D624);
  agent _meth_136ADFF8F817FAD6(_id_8217369571009C81);
}
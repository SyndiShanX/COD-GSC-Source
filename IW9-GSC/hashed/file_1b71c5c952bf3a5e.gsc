/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1b71c5c952bf3a5e.gsc
***********************************************/

_id_FFD4129F1032E796() {
  self._id_37AA0062320EBD1A.onplayerkilled = ::onplayerkilled;
  self._id_37AA0062320EBD1A._id_98E0D36C937991DE = 0;
  _id_29F5EBED550B09C9(0);
  _id_C9E915E56C1B6170 = _id_98A5C84AC64B2297();
  self._id_37AA0062320EBD1A._id_FBB77EDD342DE940 = self.origin;
  path = undefined;
  _id_CBEF341A3AEEF001 = 32;
  _id_43A44A790145CE26 = undefined;
  _id_99DC4BF78AE2B370 = 2;
  childthread _id_6885BDFE55F8F15D(_id_C9E915E56C1B6170);
  childthread _id_E6C8677B0FB79D74(_id_C9E915E56C1B6170);
  self botsetdifficultysetting("slideChance", 0);
  _id_59FF79D681BB860C::_id_9E400058EF021B03(_id_C9E915E56C1B6170, _id_CBEF341A3AEEF001);

  for(;;) {
    result = _id_0A661C5FAD6BEDD8::_id_B564050A363F08EC(self, _id_99DC4BF78AE2B370);
    _id_A0EEC69077D8135E = self _meth_B96CEA3BA44FC035();

    if(isDefined(_id_A0EEC69077D8135E))
      path = _id_A0EEC69077D8135E;

    if(result == "goal") {
      break;
    } else if(result != "timeout") {
      _id_43A44A790145CE26 = _id_183BC29D2DAB9FDF(result, self, self.origin, _id_C9E915E56C1B6170, path);

      if(result == "bad_path_no_tac_point" || result == "off_navmesh" && !self isskydiving())
        resetposition();
      else if(result == "bad_path_stuck")
        self waittill("custom_stuck_check_finished");

      break;
    }
  }

  self._id_37AA0062320EBD1A._id_98E0D36C937991DE = 1;
  return _id_43A44A790145CE26;
}

_id_60524DE5341E2666() {
  if(!istrue(self._id_37AA0062320EBD1A._id_98E0D36C937991DE) && _id_59FF79D681BB860C::_id_DED80385EA7471DB(self))
    return _id_183BC29D2DAB9FDF("unexpectly", self, self.origin);
}

onplayerkilled(_id_642470E1ABC1BBF9) {
  if(!isbot(self)) {
    return;
  }
  _id_46565AB40A4E0A85 = [];
  _id_F90358454413407F = spawnStruct();
  _id_F90358454413407F._id_A063232820588C29 = "deathPos";
  _id_F90358454413407F.origin = self.lastdeathpos;
  _id_46565AB40A4E0A85[_id_46565AB40A4E0A85.size] = _id_F90358454413407F;

  if(isDefined(self._id_37AA0062320EBD1A._id_9A0BBF45EE5BCF80)) {
    _id_F90358454413407F = spawnStruct();
    _id_F90358454413407F._id_A063232820588C29 = "startFall";
    _id_F90358454413407F.origin = self._id_37AA0062320EBD1A._id_9A0BBF45EE5BCF80;
    _id_46565AB40A4E0A85[_id_46565AB40A4E0A85.size] = _id_F90358454413407F;
  }

  _id_183BC29D2DAB9FDF("death", self, _id_46565AB40A4E0A85, undefined, undefined, _id_642470E1ABC1BBF9.meansofdeath);
  _id_29F5EBED550B09C9(1);
}

_id_6885BDFE55F8F15D(target) {
  _id_2530EB2DF770B9F9 = 0.5;
  _id_7B00B13D4490DEB3 = 100;
  _id_23C058E984C5A869 = self.origin;

  for(;;) {
    wait(_id_2530EB2DF770B9F9);
    _id_850A0F04F8EDABA5 = self.origin;
    _id_81380D005F20A0EF = (_id_23C058E984C5A869[2] - _id_850A0F04F8EDABA5[2]) / _id_2530EB2DF770B9F9;

    if(_id_81380D005F20A0EF > _id_7B00B13D4490DEB3) {
      if(!isDefined(self._id_37AA0062320EBD1A._id_9A0BBF45EE5BCF80))
        self._id_37AA0062320EBD1A._id_9A0BBF45EE5BCF80 = _id_850A0F04F8EDABA5;
    } else {
      if(isDefined(self._id_37AA0062320EBD1A._id_9A0BBF45EE5BCF80))
        _id_183BC29D2DAB9FDF("custom_fall", self, self._id_37AA0062320EBD1A._id_9A0BBF45EE5BCF80, target, undefined, "position->start falling");

      self._id_37AA0062320EBD1A._id_9A0BBF45EE5BCF80 = undefined;
    }

    _id_23C058E984C5A869 = _id_850A0F04F8EDABA5;
  }
}

_id_E6C8677B0FB79D74(target) {
  _id_45A16C7EDECCB500 = 10;
  _id_68C48F0A02281BE6 = 32;
  _id_B0F645BD38D985CC = 64;
  _id_23C058E984C5A869 = self.origin;
  path = undefined;
  _id_6D82C1563A4FF586 = 5000;

  for(;;) {
    wait(_id_45A16C7EDECCB500);
    _id_F122A392F555D0C8 = gettime();

    while(distance(_id_23C058E984C5A869, self.origin) < _id_68C48F0A02281BE6) {
      if(gettime() - _id_F122A392F555D0C8 < _id_6D82C1563A4FF586) {
        waitframe();
        continue;
      }

      _id_A0EEC69077D8135E = self _meth_B96CEA3BA44FC035();

      if(isDefined(_id_A0EEC69077D8135E))
        path = _id_A0EEC69077D8135E;

      _id_401C3A2E68AAB0FD = _id_C8BD37A8BFBC12AA(self, _id_B0F645BD38D985CC);

      if(!isDefined(_id_401C3A2E68AAB0FD))
        _id_401C3A2E68AAB0FD = _id_CEB2AC088A92A55E(self, _id_B0F645BD38D985CC);

      _id_183BC29D2DAB9FDF("custom_stuck", self, self.origin, target, path, _id_401C3A2E68AAB0FD);
      resetposition();
      self notify("custom_stuck_check_finished");
      break;
    }

    _id_23C058E984C5A869 = self.origin;
  }
}

_id_183BC29D2DAB9FDF(_id_0889F3D7E1C1EA6B, bot, position, target, path, _id_D478708F077A4A52) {
  _id_444A5451F436094A = _id_0889F3D7E1C1EA6B + "; " + "bot:" + bot getentitynumber() + "; ";
  _id_444A5451F436094A = _id_444A5451F436094A + "position:";

  if(isarray(position)) {
    foreach(pos in position)
    _id_444A5451F436094A = _id_444A5451F436094A + ("-" + pos._id_A063232820588C29 + ":" + pos.origin);
  } else
    _id_444A5451F436094A = _id_444A5451F436094A + position;

  _id_444A5451F436094A = _id_444A5451F436094A + ("; start:" + bot._id_37AA0062320EBD1A._id_FBB77EDD342DE940 + "; ");

  if(isDefined(target))
    _id_444A5451F436094A = _id_444A5451F436094A + ("target:" + target);

  _id_444A5451F436094A = _id_444A5451F436094A + "; ";

  if(isDefined(path)) {
    _id_1C8A80E41795621D = "path: ";

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < path.size; _id_AC0E594AC96AA3A8++)
      _id_1C8A80E41795621D = _id_1C8A80E41795621D + path[_id_AC0E594AC96AA3A8];

    _id_444A5451F436094A = _id_444A5451F436094A + _id_1C8A80E41795621D;
  }

  _id_444A5451F436094A = _id_444A5451F436094A + "; ";

  if(isDefined(_id_D478708F077A4A52))
    _id_444A5451F436094A = _id_444A5451F436094A + ("comment:" + _id_D478708F077A4A52);

  _id_ACC026B91A4D7E73(_id_0889F3D7E1C1EA6B, bot, position, target, path, _id_D478708F077A4A52);
  _id_0A661C5FAD6BEDD8::_id_9A0A24DE119B078A("Wander", _id_444A5451F436094A);
  return _id_0889F3D7E1C1EA6B;
}

_id_ACC026B91A4D7E73(_id_0889F3D7E1C1EA6B, bot, position, target, path, _id_D478708F077A4A52) {
  _id_444A5451F436094A = "";

  switch (_id_0889F3D7E1C1EA6B) {
    case "death":
      _id_ACC73B9BE635B8BE = isarray(position) && isDefined(position[1]) && position[1]._id_A063232820588C29 == "startFall" && position[0].origin[2] < level._id_37AA0062320EBD1A._id_513A313408516DC2;

      if(_id_ACC73B9BE635B8BE)
        _id_444A5451F436094A = _id_444A5451F436094A + ("death_bot_fell_in_hole, " + position[0]._id_A063232820588C29 + position[0].origin + ", " + position[1]._id_A063232820588C29 + position[1].origin);

      break;
    case "custom_stuck":
      if(isDefined(_id_D478708F077A4A52)) {
        _id_444A5451F436094A = _id_444A5451F436094A + ("custom_stuck_by_" + _id_D478708F077A4A52);
        _id_444A5451F436094A = _id_444A5451F436094A + (", " + position);
      }

      break;
  }

  if(_id_444A5451F436094A != "")
    _id_0A661C5FAD6BEDD8::_id_9A0A24DE119B078A("Wander_Bug", _id_444A5451F436094A);
}

_id_98A5C84AC64B2297() {
  if(getdvarint("dvar_D27108BAA24BD624", 0))
    return _id_73D328985C00C761();

  return _id_3EC57983D173D1E3();
}

_id_73D328985C00C761() {
  _id_4D2861D9375D49BC = 5;
  _id_92B1717B42BB9CD4 = [30, 60, 90, 145, 180];
  _id_D3C5B52B55E39C07 = [500, 1000, 1500, 2000, 2500];
  _id_9CCC7137EEA64BAF = 0.5;
  _id_9CA95F37EE7FDC61 = 1;
  _id_9178EEC664B1667F = 1600;
  _id_80055D9EEC7074A5 = 200;
  yaw = self.angles[1];
  _id_C4B448E975A0779B = 0;

  for(_id_73FABFD6BEF81ECB = undefined; _id_C4B448E975A0779B < _id_4D2861D9375D49BC; _id_C4B448E975A0779B++) {
    _id_53FF1D53D1EC1F07 = angleclamp180(yaw - _id_92B1717B42BB9CD4[_id_C4B448E975A0779B]);
    _id_FE136345430CF884 = angleclamp180(yaw + _id_92B1717B42BB9CD4[_id_C4B448E975A0779B]);
    _id_077B9E4B599269EB = anglesdelta((0, _id_53FF1D53D1EC1F07, 0), (0, _id_FE136345430CF884, 0));
    _id_F157E2C858DD6237 = _id_53FF1D53D1EC1F07 + randomfloat(_id_077B9E4B599269EB);
    radius = _id_D3C5B52B55E39C07[_id_C4B448E975A0779B] * randomfloatrange(_id_9CCC7137EEA64BAF, _id_9CA95F37EE7FDC61);
    offset = radius * (cos(_id_F157E2C858DD6237), sin(_id_F157E2C858DD6237), 0);
    _id_3F7AA286B2E359B5 = self.origin + offset;
    _id_8E438C1BACB25A0A = self getclosestreachablepointonnavmesh(_id_3F7AA286B2E359B5);
    _id_30B2A83D732D8589 = getrandomnavpoints(_id_8E438C1BACB25A0A, _id_80055D9EEC7074A5, 3, self);
    _id_6B51AE9BBAB80184 = -1;
    _id_B21EA137FC5C53D8 = undefined;

    foreach(point in _id_30B2A83D732D8589) {
      distsq = lengthsquared(point - _id_8E438C1BACB25A0A);

      if(distsq > _id_6B51AE9BBAB80184) {
        _id_B21EA137FC5C53D8 = point;
        _id_6B51AE9BBAB80184 = distsq;
      }
    }

    if(lengthsquared(_id_B21EA137FC5C53D8 - self.origin) > _id_9178EEC664B1667F) {
      _id_73FABFD6BEF81ECB = _id_B21EA137FC5C53D8;
      break;
    }
  }

  if(!isDefined(_id_73FABFD6BEF81ECB))
    _id_73FABFD6BEF81ECB = _id_3EC57983D173D1E3();

  return _id_73FABFD6BEF81ECB;
}

_id_3EC57983D173D1E3() {
  _id_3C590D0EE220B409 = min(level.br_level.br_mapbounds[0][0], level.br_level.br_mapbounds[1][0]);
  _id_C978C90E8E5AB1F7 = max(level.br_level.br_mapbounds[0][0], level.br_level.br_mapbounds[1][0]);
  _id_3C590C0EE220B1D6 = min(level.br_level.br_mapbounds[1][1], level.br_level.br_mapbounds[0][1]);
  _id_C978C80E8E5AAFC4 = max(level.br_level.br_mapbounds[1][1], level.br_level.br_mapbounds[0][1]);
  _id_3C590B0EE220AFA3 = level.br_level.c130_sealeveloverride;
  _id_C978CB0E8E5AB65D = level.br_level.c130_heightoverride;
  _id_332BFCF7ECA6F520 = (randomfloatrange(_id_3C590D0EE220B409, _id_C978C90E8E5AB1F7), randomfloatrange(_id_3C590C0EE220B1D6, _id_C978C80E8E5AAFC4), randomfloatrange(_id_3C590B0EE220AFA3, _id_C978CB0E8E5AB65D));
  return getclosestpointonnavmesh(_id_332BFCF7ECA6F520);
}

_id_29F5EBED550B09C9(enabled) {
  self skydive_setdeploymentstatus(enabled);
  self skydive_setbasejumpingstatus(enabled);

  if(enabled == 1)
    self skydive_cutautodeployon();
  else
    self skydive_cutautodeployoff();
}

resetposition() {
  if(getdvarint("dvar_6DCE7ACC7BC7F481", 0)) {
    return;
  }
  _id_F4DE64E7E1762529 = _id_3EC57983D173D1E3();
  _id_FC77E2B383D17EC9 = _id_0A661C5FAD6BEDD8::_id_721588AE374756B5(_id_F4DE64E7E1762529, 50, 100);

  if(isDefined(_id_FC77E2B383D17EC9)) {
    _id_183BC29D2DAB9FDF("failed_teleport", self, _id_F4DE64E7E1762529, undefined, undefined, _id_FC77E2B383D17EC9);
    self setOrigin(_id_F4DE64E7E1762529);
  }
}

_id_CEB2AC088A92A55E(bot, dist) {
  nodes = getnodesinradius(bot.origin, dist, 0);

  foreach(node in nodes) {
    if(isDefined(node.animscript) && issubstr(node.animscript, "ladder"))
      return "ladder";
  }

  return undefined;
}

_id_C8BD37A8BFBC12AA(bot, dist) {
  _id_1F0571D36D0DF95B = navtrace(bot.origin, anglesToForward(bot.angles) * dist + bot.origin);

  if(istrue(_id_1F0571D36D0DF95B)) {
    doors = getentitylessscriptablearray(undefined, undefined, bot.origin, dist, "door");

    foreach(door in doors) {
      _id_B2F6144C1595A8B8 = anglesdelta(door.angles, bot.angles);
      _id_C32162F8D2BF2D4D = _id_B2F6144C1595A8B8 < 100 && _id_B2F6144C1595A8B8 > 80;

      if(_id_C32162F8D2BF2D4D)
        return scripts\engine\utility::ter_op(door scriptabledoorisclosed(), "closed_door", "opened_door");
    }
  }

  return undefined;
}
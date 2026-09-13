/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_a662f25dbf78119.gsc
***********************************************/

_id_DC852E3D3327CAF8(startpos, endpos, _id_EF05B67E242818FA) {
  if(!isDefined(_id_EF05B67E242818FA))
    _id_EF05B67E242818FA = 6;

  _id_E53677BBC487B2B7 = (0, 0, 1) * _id_EF05B67E242818FA;
  _id_1381504F4F4A31AB = startpos + _id_E53677BBC487B2B7;
  _id_6CF5F2094D846DB8 = endpos + _id_E53677BBC487B2B7;
  return capsuletracepassed(_id_1381504F4F4A31AB, self.radius, self.height - _id_EF05B67E242818FA, self, 1, 0, 0, _id_6CF5F2094D846DB8);
}

_id_0B6FE5ECC5AA631E() {
  return 8;
}

_id_2E76CA63B9A152AA() {
  return 360.0 / _id_0B6FE5ECC5AA631E();
}

_id_6A71485BED30022F(point, _id_F50549FBC64F76F3, _id_C8818686F12F33B6) {
  angle = _id_F50549FBC64F76F3 * _id_2E76CA63B9A152AA() - 180.0;
  _id_91BE2B7482F940BA = point + anglesToForward((0, angle, 0)) * _id_C8818686F12F33B6;
  return _id_91BE2B7482F940BA;
}

_id_F483CB14CB6AF004(type) {
  return self._id_C5B2A90477EE623E[type];
}

_id_9B72E8AC7409E020(type) {
  if(!isDefined(self._id_C5B2A90477EE623E))
    self._id_C5B2A90477EE623E = [];

  if(!isDefined(self._id_C5B2A90477EE623E[type])) {
    self._id_C5B2A90477EE623E[type] = [];

    for(_id_F50549FBC64F76F3 = 0; _id_F50549FBC64F76F3 < _id_0B6FE5ECC5AA631E(); _id_F50549FBC64F76F3++) {
      self._id_C5B2A90477EE623E[type][_id_F50549FBC64F76F3] = spawnStruct();
      self._id_C5B2A90477EE623E[type][_id_F50549FBC64F76F3].timestamp = 0;
      self._id_C5B2A90477EE623E[type][_id_F50549FBC64F76F3].claimer = undefined;
      self._id_C5B2A90477EE623E[type][_id_F50549FBC64F76F3].origin = undefined;
      self._id_C5B2A90477EE623E[type][_id_F50549FBC64F76F3].num = _id_F50549FBC64F76F3;
    }
  }
}

_id_F814071E24378B97(ent) {
  origin = ent.origin;

  if(isDefined(ent.groundpos)) {
    origin = ent.groundpos;

    if(isDefined(self._id_39AEF39840F14B73) && ent == self._id_39AEF39840F14B73 && _id_22C34474CD797E5E()) {
      _id_6FC1B387B0AEF385 = _id_22E62801E2A9B406();

      if(isDefined(_id_6FC1B387B0AEF385))
        origin = _id_6FC1B387B0AEF385.origin;
    }
  } else if(isPlayer(ent) && (ent isjumping() || ent ishighjumping())) {
    if(!isDefined(ent._id_43A5F500C0AEB33E))
      ent._id_43A5F500C0AEB33E = 0;

    if(gettime() > ent._id_43A5F500C0AEB33E) {
      ent._id_5A52688310883ACF = getgroundposition(ent.origin, 15);
      ent._id_43A5F500C0AEB33E = gettime();
    }

    if(isDefined(ent._id_5A52688310883ACF))
      origin = ent._id_5A52688310883ACF;
  }

  return origin;
}

_id_47ED76E02C439723(ent, type) {
  for(_id_8DCDDC8059AC0D5A = 0; _id_8DCDDC8059AC0D5A < _id_0B6FE5ECC5AA631E(); _id_8DCDDC8059AC0D5A++) {
    _id_2A1834B520C19B80 = ent _id_F483CB14CB6AF004(type);
    _id_F50549FBC64F76F3 = _id_2A1834B520C19B80[_id_8DCDDC8059AC0D5A];

    if(isDefined(_id_F50549FBC64F76F3.origin))
      return 1;
  }

  return 0;
}

_id_0A7B261C20B3516E() {
  _id_8458C1DCC1C05517 = self getnearestnode();
}

_id_22C34474CD797E5E() {
  _id_8458C1DCC1C05517 = self getnearestnode();

  if(isDefined(_id_8458C1DCC1C05517) && isDefined(self._id_39AEF39840F14B73._id_CF8FFC784D548493)) {
    _id_809EDD778F6DD16F = self._id_39AEF39840F14B73._id_CF8FFC784D548493["0"];

    if(isDefined(_id_809EDD778F6DD16F))
      return 1;
  }

  return 0;
}

_id_22E62801E2A9B406() {
  _id_8458C1DCC1C05517 = self getnearestnode();
  _id_809EDD778F6DD16F = self._id_39AEF39840F14B73._id_CF8FFC784D548493["0"];

  if(!isnumber(_id_809EDD778F6DD16F))
    return _id_809EDD778F6DD16F;
  else
    return undefined;
}

_id_B62A600F1B081011() {
  if(_id_22C34474CD797E5E()) {
    _id_E6874E9B453D7005 = _id_22E62801E2A9B406();

    if(!isDefined(_id_E6874E9B453D7005))
      return 0;
  }

  return 1;
}

_id_E36BAF564ACA8EA2(ent) {
  if(isDefined(self._id_39AEF39840F14B73) && ent == self._id_39AEF39840F14B73) {
    if(self._id_658562CC2E37146C > 5)
      return 1;
  }

  return 0;
}

_id_BC40E686419D910E(enemy, _id_807FE94E8EC14536) {
  _id_F896EE073845FC13 = 0;

  if(_id_F896EE073845FC13)
    return enemy.origin;

  if(getdvarint("dvar_D869D635D71248A0", 0))
    return enemy.origin;

  enemy _id_9B72E8AC7409E020(self._id_5754D6C3DF1A2B31);
  _id_2A1834B520C19B80 = enemy _id_F483CB14CB6AF004(self._id_5754D6C3DF1A2B31);
  _id_8ADC06D9FDFE6452 = _id_807FE94E8EC14536;
  _id_3777ECE6A73EADA5 = self.origin - _id_8ADC06D9FDFE6452;
  _id_4FB8A4D984999612 = lengthsquared(_id_3777ECE6A73EADA5);

  if(_id_4FB8A4D984999612 < 256) {
    _id_B54F9ACF902FF598 = -1;

    for(_id_8DCDDC8059AC0D5A = 0; _id_8DCDDC8059AC0D5A < _id_0B6FE5ECC5AA631E(); _id_8DCDDC8059AC0D5A++) {
      _id_F50549FBC64F76F3 = _id_2A1834B520C19B80[_id_8DCDDC8059AC0D5A];

      if(isDefined(_id_F50549FBC64F76F3.claimer) && _id_F50549FBC64F76F3.claimer == self)
        _id_B54F9ACF902FF598 = _id_F50549FBC64F76F3.num;
    }

    if(_id_B54F9ACF902FF598 < 0)
      _id_B54F9ACF902FF598 = self getentitynumber() % _id_0B6FE5ECC5AA631E();

    _id_B44E7861A744EBA2 = _id_B54F9ACF902FF598;
  } else {
    angle = angleclamp180(vectortoyaw(_id_3777ECE6A73EADA5)) + 180.0;
    _id_B44E7861A744EBA2 = angle / _id_2E76CA63B9A152AA();
    _id_B54F9ACF902FF598 = int(_id_B44E7861A744EBA2 + 0.5);
  }

  result = undefined;
  _id_8F806C87F3CB591C = -1;
  _id_F9255D1B11C07B78 = 3;
  _id_F90B591B11A449A2 = 2;

  if(_id_B44E7861A744EBA2 > _id_B54F9ACF902FF598) {
    _id_8F806C87F3CB591C = _id_8F806C87F3CB591C * -1;
    _id_F9255D1B11C07B78 = _id_F9255D1B11C07B78 * -1;
    _id_F90B591B11A449A2 = _id_F90B591B11A449A2 * -1;
  }

  _id_C16422F50A5880A0 = _id_0B6FE5ECC5AA631E();

  for(_id_D0DE0DB1760B9C5B = 0; _id_D0DE0DB1760B9C5B < _id_C16422F50A5880A0 / 2 + 1; _id_D0DE0DB1760B9C5B++) {
    for(dir = _id_8F806C87F3CB591C; dir != _id_F9255D1B11C07B78; dir = dir + _id_F90B591B11A449A2) {
      _id_E7FC2D69B971EC3D = _id_B54F9ACF902FF598 + _id_D0DE0DB1760B9C5B * dir;

      if(_id_E7FC2D69B971EC3D >= _id_C16422F50A5880A0)
        _id_E7FC2D69B971EC3D = _id_E7FC2D69B971EC3D - _id_C16422F50A5880A0;
      else if(_id_E7FC2D69B971EC3D < 0)
        _id_E7FC2D69B971EC3D = _id_E7FC2D69B971EC3D + _id_C16422F50A5880A0;

      _id_F50549FBC64F76F3 = _id_2A1834B520C19B80[_id_E7FC2D69B971EC3D];

      if(!isDefined(result) && gettime() - _id_F50549FBC64F76F3.timestamp >= self._id_5CB3CC0C49EE04F1) {
        if(isDefined(level._id_3421A346C571FBAE) && isDefined(level._id_3421A346C571FBAE[self.agent_type]))
          [[level._id_3421A346C571FBAE[self.agent_type]]](_id_F50549FBC64F76F3, _id_8ADC06D9FDFE6452, self._id_C8818686F12F33B6, self.radius);
        else
          _id_3421A346C571FBAE(_id_F50549FBC64F76F3, _id_8ADC06D9FDFE6452, self._id_C8818686F12F33B6, self.radius);
      }

      if(!isDefined(result) && isDefined(_id_F50549FBC64F76F3.origin)) {
        _id_FAE2F8846758E0E9 = getclosestpointonnavmesh(enemy.origin, self);
        traceresults = navtrace(_id_F50549FBC64F76F3.origin, _id_FAE2F8846758E0E9, self, 1);

        if(traceresults["fraction"] < 0.95) {
          if(!ispointonnavmesh(enemy.origin))
            result = _id_FAE2F8846758E0E9;

          continue;
        }

        _id_C1BC7003E9E96206 = 0;

        if(isDefined(_id_F50549FBC64F76F3.claimer) && _id_F50549FBC64F76F3.claimer != self) {
          _id_0851359AC441EBB8 = vectorNormalize(_id_8ADC06D9FDFE6452 - _id_F50549FBC64F76F3.claimer.origin) * self.radius * 2;
          _id_C1BC7003E9E96206 = distancesquared(_id_F50549FBC64F76F3.claimer.origin + _id_0851359AC441EBB8, _id_8ADC06D9FDFE6452);
        }

        if(!isalive(_id_F50549FBC64F76F3.claimer) || !isDefined(_id_F50549FBC64F76F3.claimer._id_003B90191D39897A) || _id_F50549FBC64F76F3.claimer._id_003B90191D39897A != enemy || _id_F50549FBC64F76F3.claimer == self || _id_4FB8A4D984999612 < _id_C1BC7003E9E96206) {
          if(isalive(_id_F50549FBC64F76F3.claimer) && _id_F50549FBC64F76F3.claimer != self) {
            if(!isDefined(_id_F50549FBC64F76F3.claimer._id_3D886DDE9B70D929)) {
              _id_F3D02E5F407B79EB = _id_F50549FBC64F76F3.claimer getentitynumber();

              if(getdvarint("dvar_4D4B306B7001B4D3", 0) == 0) {}
            }

            if(getdvarint("dvar_4D4B306B7001B4D3", 0) == 0) {}

            _id_F50549FBC64F76F3.claimer._id_3D886DDE9B70D929 = undefined;
          }

          if(isDefined(self._id_3D886DDE9B70D929) && self._id_3D886DDE9B70D929 != _id_F50549FBC64F76F3)
            self._id_3D886DDE9B70D929.claimer = undefined;

          if(!isDefined(self._id_3D886DDE9B70D929) || self._id_3D886DDE9B70D929 != _id_F50549FBC64F76F3) {
            self._id_3D886DDE9B70D929 = _id_F50549FBC64F76F3;

            if(getdvarint("dvar_4D4B306B7001B4D3", 0) == 0) {}

            _id_F50549FBC64F76F3.claimer = self;
          }

          result = _id_F50549FBC64F76F3.origin;
        }
      }

      if(_id_D0DE0DB1760B9C5B == 0) {
        break;
      }
    }
  }

  return result;
}

_id_3421A346C571FBAE(_id_F50549FBC64F76F3, _id_65FCAD9446D3A2F9, _id_C8818686F12F33B6, radius) {
  if(gettime() - _id_F50549FBC64F76F3.timestamp >= 50) {
    _id_F50549FBC64F76F3.origin = _id_6A71485BED30022F(_id_65FCAD9446D3A2F9, _id_F50549FBC64F76F3.num, _id_C8818686F12F33B6);
    _id_F50549FBC64F76F3.origin = _id_BE302E4229F2239A(_id_F50549FBC64F76F3.origin, radius, 55);
    _id_F50549FBC64F76F3.timestamp = gettime();
  }
}

_id_BE302E4229F2239A(position, radius, height, _id_463494A5F1200722) {
  if(!isDefined(_id_463494A5F1200722))
    _id_463494A5F1200722 = 18;

  startpos = position + (0, 0, _id_463494A5F1200722);
  endpos = position + (0, 0, _id_463494A5F1200722 * -1);
  _id_3627F3C8C6351D4D = self aiphysicstrace(startpos, endpos, radius, height, 1);

  if(abs(_id_3627F3C8C6351D4D[2] - startpos[2]) < 0.1)
    return undefined;

  if(abs(_id_3627F3C8C6351D4D[2] - endpos[2]) < 0.1)
    return undefined;

  return _id_3627F3C8C6351D4D;
}

_id_83E45D9DD1B34CA4() {
  return isDefined(self.dismember_crawl) && self.dismember_crawl;
}

_id_FCB16F2EAF12DA83() {
  if(!isDefined(self._id_6B4B9114BC1E7B35) || self._id_6B4B9114BC1E7B35)
    return self._id_4BBA3A58F389E465;
  else
    return self._id_FA4CF34A0C3681B8;
}

_id_7712021F38C94913() {
  if(!isDefined(self._id_6B4B9114BC1E7B35) || self._id_6B4B9114BC1E7B35)
    return self._id_3835F6FBD6173DC9;
  else
    return self._id_F5BD7EEB8C658300;
}

_id_8766CA4A5E60C875(debounce, range, _id_5D186451F21D7020, fx, _id_C564BB737BB07432, _id_3AC2186D15DA099E) {
  self._id_6BF0F8E4D7FE1763 = debounce * 1000.0;
  self._id_0468592BA8000796 = fx;
  self._id_61BE94A8E9904DBF = isDefined(_id_C564BB737BB07432) && _id_C564BB737BB07432;
  self._id_3AC2186D15DA099E = _id_3AC2186D15DA099E;
  self._id_77EAAFCBED9FE6C9 = _id_5D186451F21D7020;
  self._id_7390E3CC5464684D = squared(self._id_77EAAFCBED9FE6C9);
  _id_A490D346D97D0167(range);
}

_id_D43AB284CFAE3493() {
  if(isDefined(self._id_F14DEF8710005D84) && self._id_F14DEF8710005D84 > 0) {
    self._id_F14DEF8710005D84--;

    if(self._id_F14DEF8710005D84 > 0)
      return;
  }

  self._id_6B4B9114BC1E7B35 = 1;
}

_id_0BD6AC32914ACA50() {
  if(!isDefined(self._id_F14DEF8710005D84))
    self._id_F14DEF8710005D84 = 0;

  self._id_F14DEF8710005D84++;
  self._id_6B4B9114BC1E7B35 = 0;
}

_id_81F47E4D789ED81D(debounce, _id_302E82DA1A1989AD, _id_E684FC6E068EE951, _id_02D0FB487C119B8B) {
  self._id_4A8F6E5778B80CEF = debounce * 1000.0;
  self._id_8BE0DAC43069F6F8 = _id_302E82DA1A1989AD;
  self._id_954102DB607AE2C2 = _id_E684FC6E068EE951;
  self._id_5F6281265191DD21 = ["back", "right", "left"];
  self._id_AF08A50AE2C2AF8F = [];

  foreach(index, dir in self._id_5F6281265191DD21)
  self._id_AF08A50AE2C2AF8F[index] = level._effect[_id_02D0FB487C119B8B + dir];
}

_id_448F55E17DAE271B() {
  if(isDefined(self._id_8794755DAF7AF4D8) && self._id_8794755DAF7AF4D8 > 0) {
    self._id_8794755DAF7AF4D8--;

    if(self._id_8794755DAF7AF4D8 > 0)
      return;
  }

  self._id_75615DE76600DC4D = 1;
}

_id_ADCCC6EB1BC4D0A8() {
  if(!isDefined(self._id_8794755DAF7AF4D8))
    self._id_8794755DAF7AF4D8 = 0;

  self._id_8794755DAF7AF4D8++;
  self._id_75615DE76600DC4D = 0;
}

_id_E4634BF05125D57E(debounce, _id_99D445D82714E48A, _id_302E82DA1A1989AD, range, _id_5D186451F21D7020, _id_E684FC6E068EE951, fx) {
  self._id_B84A5D43046E82B8 = debounce * 1000.0;
  self._id_67962D36A5971834 = _id_99D445D82714E48A * 1000.0;
  self._id_1B4A3DE85A80B59F = _id_302E82DA1A1989AD;
  self._id_12FE8248313A049C = range;
  self._id_067F849E76274204 = squared(self._id_12FE8248313A049C);
  self._id_CA8FE098D3DAF116 = _id_5D186451F21D7020;
  self._id_3AF095FEB96FC4EA = squared(self._id_CA8FE098D3DAF116);
  self._id_1EB254DD3AB941A9 = fx;
  self._id_E1ED2E6E0AE0540B = _id_E684FC6E068EE951;
  self._id_9A2F9425185D9AA1 = 0;
  self._id_759F0145378B05E8 = 0;
}

_id_C76198E7DFFF2558() {
  if(isDefined(self._id_9131E9E00C23908F) && self._id_9131E9E00C23908F > 0) {
    self._id_9131E9E00C23908F--;

    if(self._id_9131E9E00C23908F > 0)
      return;
  }

  self._id_7AC881F19E1EE2F4 = 1;
}

_id_F1E356AF7F46E1A1() {
  if(!isDefined(self._id_9131E9E00C23908F))
    self._id_9131E9E00C23908F = 0;

  self._id_9131E9E00C23908F++;
  self._id_7AC881F19E1EE2F4 = 0;
}

_id_E99764063B47DF86(_id_93E14809173F1E03, _id_CDDEE9B090651865) {
  animindex = 0;

  if(_id_CDDEE9B090651865 > 1) {
    _id_C89DCE05842206A0 = int(_id_CDDEE9B090651865 * 0.5);
    _id_97AD91666291CF6F = _id_C89DCE05842206A0 + _id_CDDEE9B090651865 % 2;

    if(_id_93E14809173F1E03 < 0)
      animindex = randomint(_id_97AD91666291CF6F);
    else
      animindex = _id_C89DCE05842206A0 + randomint(_id_97AD91666291CF6F);
  }

  return animindex;
}

_id_254992A907EE42E9(ent) {
  _id_F17759894781F5EB = self.origin[2] + self.height;

  if(ent.origin[2] < _id_F17759894781F5EB)
    return 0;

  _id_F1536F894759AB95 = self.origin[2] + self.height + 2 * self.radius;

  if(ent.origin[2] > _id_F1536F894759AB95)
    return 0;

  if(isPlayer(ent)) {
    _id_C19EF8886914A3A4 = ent getvelocity()[2];

    if(abs(_id_C19EF8886914A3A4) > 12)
      return 0;
  }

  _id_3CFA7C7436AF8F24 = 15.0;

  if(isDefined(ent.radius))
    _id_3CFA7C7436AF8F24 = ent.radius;

  radiussq = self.radius + _id_3CFA7C7436AF8F24;
  radiussq = radiussq * radiussq;

  if(distance2dsquared(self.origin, ent.origin) > radiussq)
    return 0;

  return 1;
}

_id_33555FFB3402A9B5(enemy) {
  self.favoriteenemy = enemy;
}

_id_15B80AE6984F4CCC(vpoint, vdir) {
  _id_65FACA4AE4AF2C9D = 0;

  if(isDefined(vpoint)) {
    _id_C563AD9A49196C2E = vpoint - self gettagorigin("J_SpineLower");
    _id_C563AD9A49196C2E = (_id_C563AD9A49196C2E[0], _id_C563AD9A49196C2E[1], 0);
    _id_349B3565E3B204CC = vectortoangles(vectorNormalize(_id_C563AD9A49196C2E));
    _id_65FACA4AE4AF2C9D = _id_349B3565E3B204CC[1];
  } else if(isDefined(vdir)) {
    _id_349B3565E3B204CC = vectortoangles(vdir);
    _id_65FACA4AE4AF2C9D = _id_349B3565E3B204CC[1] - 180;
  }

  return _id_65FACA4AE4AF2C9D;
}

lerp(_id_2BF3C98575BA0BE1, _id_A8DAEB9E4DE670F5, _id_18B7AC38B222E55F) {
  _id_828FD0AED5899CED = _id_18B7AC38B222E55F - _id_A8DAEB9E4DE670F5;
  _id_89178A03DBA15839 = _id_2BF3C98575BA0BE1 * _id_828FD0AED5899CED;
  _id_BF5F122E4372B0AD = _id_A8DAEB9E4DE670F5 + _id_89178A03DBA15839;
  return _id_BF5F122E4372B0AD;
}

player_in_laststand(player) {
  return player.inlaststand;
}

_id_1EA5D1AD97D72DA5(point, _id_91BE2B7482F940BA) {
  _id_63E2B577B3021861 = self._id_A9BBCE143412F034 * self._id_A9BBCE143412F034;
  return distancesquared(point, _id_91BE2B7482F940BA) <= _id_63E2B577B3021861;
}

_id_107E3C278CCF7264() {
  return _id_1EA5D1AD97D72DA5(self.origin, self._id_003B90191D39897A.origin);
}

_id_859CE1CAAF98DB64() {
  if(_id_FCB16F2EAF12DA83() == self._id_FA4CF34A0C3681B8)
    return _id_0E2C77EC2E423711();

  _id_C844E6DA361C186C = distancesquared(self.origin, self._id_003B90191D39897A.origin) <= _id_7712021F38C94913();
  return _id_C844E6DA361C186C;
}

_id_0E2C77EC2E423711() {
  _id_C844E6DA361C186C = distancesquared(self.origin, self._id_003B90191D39897A.origin) <= self._id_F5BD7EEB8C658300;

  if(!_id_C844E6DA361C186C && (isPlayer(self._id_003B90191D39897A) || isagent(self._id_003B90191D39897A))) {
    _id_AAB6E1D66266BED5 = undefined;
    _id_AAB6E1D66266BED5 = self._id_003B90191D39897A getgroundentity();

    if(isDefined(_id_AAB6E1D66266BED5) && isDefined(_id_AAB6E1D66266BED5.targetname) && _id_AAB6E1D66266BED5.targetname == "care_package")
      _id_C844E6DA361C186C = distancesquared(self.origin, self._id_003B90191D39897A.origin) <= self._id_F5BD7EEB8C658300 * 4;
  }

  if(!_id_C844E6DA361C186C && isPlayer(self._id_003B90191D39897A) && istrue(self._id_003B90191D39897A._id_A51F5EDF259ACC29)) {
    if(length(self getvelocity()) < 5)
      _id_C844E6DA361C186C = distancesquared(self.origin, self._id_003B90191D39897A.origin) <= self._id_F5BD7EEB8C658300 * 4;
  }

  return _id_C844E6DA361C186C;
}

_id_A490D346D97D0167(radius) {
  self._id_4BBA3A58F389E465 = radius;
  self._id_3835F6FBD6173DC9 = radius * radius;
}

_id_6F1F2CF8495FB8F2() {
  return 1;
}

_id_2D78D2CF5681691A() {
  if(isDefined(self._id_3071905D9EA1749C) && isDefined(self._id_C72136D828C5DBA2) && distance2dsquared(self._id_003B90191D39897A.origin, self._id_3071905D9EA1749C) < 4 && distancesquared(self.origin, self._id_C72136D828C5DBA2) < 2500)
    return 1;

  return 0;
}

_id_977823E93057BB7F() {
  if(isDefined(self._id_BCB2940285E35E21) && isDefined(self._id_50D02C9F9CA7F23B) && distance2dsquared(self._id_003B90191D39897A.origin, self._id_BCB2940285E35E21) < 4 && distancesquared(self.origin, self._id_50D02C9F9CA7F23B) < 2500)
    return 1;

  return 0;
}

_id_8C1EBABCC8737D7E(startpos, targetpos) {
  _id_7359C54D8C57E115 = 0;
  _id_121017411B87DACE = targetpos[2] - startpos[2];
  _id_7359C54D8C57E115 = _id_121017411B87DACE <= self._id_7A480DEB4960D81E && _id_121017411B87DACE >= self._id_A853A9004B90B766;

  if(!_id_7359C54D8C57E115 && isPlayer(self._id_003B90191D39897A) && istrue(self._id_003B90191D39897A._id_A51F5EDF259ACC29)) {
    if(length(self getvelocity()) < 5)
      _id_7359C54D8C57E115 = _id_121017411B87DACE <= self._id_7A480DEB4960D81E * 2 && _id_121017411B87DACE >= self._id_A853A9004B90B766;
  }

  return _id_7359C54D8C57E115;
}

_id_79BBA7D55BF175A9(targetpos) {
  return _id_8C1EBABCC8737D7E(self.origin, targetpos);
}

_id_B5C47115061C80C9(startpos, targetpos) {
  return distance2dsquared(startpos, targetpos) < _id_7712021F38C94913() * 0.75 * 0.75;
}

_id_533184B35ACABFE8(targetpos) {
  return _id_B5C47115061C80C9(self.origin, targetpos);
}

_id_3044FF47CEA632AC() {
  if(_id_254992A907EE42E9(self._id_003B90191D39897A))
    return 0;

  return !_id_79BBA7D55BF175A9(self._id_003B90191D39897A.origin) && _id_533184B35ACABFE8(self._id_003B90191D39897A.origin);
}

_id_048692817AB76279() {
  startpos = self.origin + (0, 0, self._id_7C0157EC8B265F6E);
  endpos = self._id_003B90191D39897A.origin + (0, 0, self._id_7C0157EC8B265F6E);

  if(!isPlayer(self._id_003B90191D39897A) && !isai(self._id_003B90191D39897A))
    return 0;

  contents = scripts\engine\trace::create_default_contents(1);

  if(scripts\engine\trace::ray_trace_passed(startpos, endpos, self._id_003B90191D39897A, contents))
    return 0;

  return 1;
}

isreallyalive(player) {
  if(isalive(player) && !isDefined(player.fauxdead))
    return 1;

  return 0;
}

_id_06F13D6BE163AD9A(_id_A7A462C25F695DB5, _id_AFE6D98F578D1615) {
  if(!isDefined(_id_AFE6D98F578D1615))
    _id_AFE6D98F578D1615 = 1;

  if(!isDefined(self._id_003B90191D39897A))
    return 0;

  if(!isreallyalive(self._id_003B90191D39897A))
    return 0;

  if(self.aistate == "traverse")
    return 0;

  if(!_id_254992A907EE42E9(self._id_003B90191D39897A)) {
    if(!_id_79BBA7D55BF175A9(self._id_003B90191D39897A.origin))
      return 0;

    if(_id_A7A462C25F695DB5 == "offmesh" && !_id_107E3C278CCF7264())
      return 0;

    if(_id_A7A462C25F695DB5 == "normal" && !_id_859CE1CAAF98DB64())
      return 0;
    else if(_id_A7A462C25F695DB5 == "base" && !_id_0E2C77EC2E423711())
      return 0;
  }

  self._id_16CF75FF2BB42685 = undefined;

  if(_id_AFE6D98F578D1615 && _id_048692817AB76279()) {
    self._id_16CF75FF2BB42685 = 1;
    return 0;
  }

  return 1;
}

_id_FD42BE10A26FFF59(enemy) {
  if(!isDefined(self._id_EB7921EAB3EA5477))
    self._id_EB7921EAB3EA5477 = spawnStruct();

  if(_id_E36BAF564ACA8EA2(enemy) && !_id_22C34474CD797E5E())
    _id_0A7B261C20B3516E();

  _id_1A9D3CFAC74BF193 = _id_F814071E24378B97(enemy);
  self._id_EB7921EAB3EA5477._id_1A9D3CFAC74BF193 = _id_1A9D3CFAC74BF193;
  _id_91BE2B7482F940BA = _id_BC40E686419D910E(enemy, _id_1A9D3CFAC74BF193);

  if(isDefined(_id_91BE2B7482F940BA)) {
    self._id_EB7921EAB3EA5477._id_05956C54E54EBF3D = 1;
    self._id_EB7921EAB3EA5477.origin = _id_91BE2B7482F940BA;
  } else {
    self._id_EB7921EAB3EA5477._id_05956C54E54EBF3D = 0;
    self._id_EB7921EAB3EA5477.origin = _id_1A9D3CFAC74BF193;

    if(isDefined(self._id_39AEF39840F14B73)) {
      if(!isDefined(_id_BE302E4229F2239A(self._id_EB7921EAB3EA5477.origin, 15, 55))) {
        if(!isDefined(self._id_1D17ADA606645D4E)) {
          self._id_1D17ADA606645D4E = [];

          for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_0B6FE5ECC5AA631E(); _id_AC0E594AC96AA3A8++)
            self._id_1D17ADA606645D4E[self._id_1D17ADA606645D4E.size] = _id_AC0E594AC96AA3A8;

          self._id_1D17ADA606645D4E = scripts\engine\utility::array_randomize(self._id_1D17ADA606645D4E);
        }

        foreach(_id_803FBDDBB8050A60 in self._id_1D17ADA606645D4E) {
          _id_2A1834B520C19B80 = enemy _id_F483CB14CB6AF004(self._id_5754D6C3DF1A2B31);
          _id_F50549FBC64F76F3 = _id_2A1834B520C19B80[_id_803FBDDBB8050A60];

          if(isDefined(_id_F50549FBC64F76F3.origin)) {
            self._id_EB7921EAB3EA5477.origin = _id_F50549FBC64F76F3.origin;
            break;
          }
        }
      }
    }
  }

  return self._id_EB7921EAB3EA5477;
}

_id_A0CC8513F431ED0D(_id_AF4CBAC5D9F8D2DD, _id_BA056D5B8EF945BE) {
  if(istrue(player_in_laststand(_id_AF4CBAC5D9F8D2DD)) || istrue(_id_AF4CBAC5D9F8D2DD._id_C4C8B91E0B16AA5E))
    return 1;

  if(isDefined(_id_AF4CBAC5D9F8D2DD.team) && isDefined(self.team) && self.team == _id_AF4CBAC5D9F8D2DD.team)
    return 1;

  if(_id_4E09DCE0BDB9E431(_id_AF4CBAC5D9F8D2DD))
    return 1;

  if(isDefined(_id_AF4CBAC5D9F8D2DD.killing_time))
    return 1;

  if(istrue(_id_AF4CBAC5D9F8D2DD.notarget))
    return 1;

  if(istrue(_id_AF4CBAC5D9F8D2DD.ignoreme))
    return 1;

  if(!isalive(_id_AF4CBAC5D9F8D2DD))
    return 1;

  if(!istrue(_id_BA056D5B8EF945BE) && !istrue(self._id_BA056D5B8EF945BE)) {
    if(isDefined(_id_AF4CBAC5D9F8D2DD._id_03567BC361203AE2) && !_id_AF4CBAC5D9F8D2DD._id_03567BC361203AE2)
      return 1;
  }

  if(isDefined(level._id_CD41441B70AF845E)) {
    if([[level._id_CD41441B70AF845E]](_id_AF4CBAC5D9F8D2DD))
      return 1;
  }

  return 0;
}

_id_4E09DCE0BDB9E431(player) {
  return isDefined(player._id_0DDA142A66B03FF5) && player._id_0DDA142A66B03FF5;
}

_id_CF169A8DE2A0D355(_id_59B3BC67D984B46F) {
  self.legacy.movemode = _id_59B3BC67D984B46F;
  scripts\asm\asm_bb::bb_requestmovetype(self.legacy.movemode);

  if(_id_59B3BC67D984B46F == "walk")
    self._id_0DA951E8204605E7 = 0.8;
  else if(_id_59B3BC67D984B46F == "run")
    self._id_0DA951E8204605E7 = 1.0;
  else if(_id_59B3BC67D984B46F == "sprint")
    self._id_0DA951E8204605E7 = 1.2;
}

_id_E8F9A124778CC606(_id_430D5C97AC6D7F48) {
  _id_2DE2D8565D288F81["walk"] = [0.65, 1.2];
  _id_2DE2D8565D288F81["run"] = [0.8, 1.1];
  _id_2DE2D8565D288F81["sprint"] = [0.9, 1.3];

  if(!isDefined(self._id_6DAF599C19E44691))
    self._id_6DAF599C19E44691 = randomfloatrange(-0.1, 0.1);

  _id_6ADFC5BEFBA25F92 = clamp(_id_430D5C97AC6D7F48 + self._id_6DAF599C19E44691, 0.0, 2.0);

  if(_id_430D5C97AC6D7F48 <= 1.0) {
    _id_4D4D4509D8BD3C47 = _id_2DE2D8565D288F81[self.legacy.movemode][0];
    _id_DC615CDE078D7B0D = 1;
    _id_4F439C539CF632A1 = _id_4D4D4509D8BD3C47 + _id_430D5C97AC6D7F48 * (_id_DC615CDE078D7B0D - _id_4D4D4509D8BD3C47);
  } else {
    _id_4D4D4509D8BD3C47 = 1;
    _id_DC615CDE078D7B0D = _id_2DE2D8565D288F81[self.legacy.movemode][1];
    _id_4F439C539CF632A1 = _id_4D4D4509D8BD3C47 + (_id_430D5C97AC6D7F48 - 1) * (_id_DC615CDE078D7B0D - _id_4D4D4509D8BD3C47);
  }

  self._id_8D31C7EACB516468 = _id_4F439C539CF632A1;
  self._id_D2D25942E3B908E9 = _id_4F439C539CF632A1;
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\ai_lookat.gsc
***********************************************/

_id_A5AA158578694A69(_id_48ACCC37953CFC3B, _id_477C1209E5432ABE) {
  _id_6FBEA72303085C6F(level.player, scripts\common\utility::_id_B88F4E5BAFF057A9(_id_48ACCC37953CFC3B), _id_477C1209E5432ABE);
}

_id_C0FACA532411608C() {
  _id_1E1767FDC6980106(level.player);
}

_id_6FBEA72303085C6F(ent, speed, _id_477C1209E5432ABE, offset) {
  if(!isDefined(self.lookatentities))
    self.lookatentities = [];

  if(!self.lookatentities.size)
    self _meth_1C339DAABA3F71DB(1);

  self.lookatentities[self.lookatentities.size] = ent;

  if(isDefined(speed))
    self _meth_106BCE0AEEE91D2C(speed);

  if(isDefined(_id_477C1209E5432ABE))
    self _meth_6DC7C9BE085F4137(_id_477C1209E5432ABE);

  if(isPlayer(ent))
    self _meth_5621E511B99964A7(ent);
  else {
    if(isDefined(offset))
      ent._id_64B4740234F03713 = offset;
    else
      offset = (0, 0, 0);

    self _meth_06EF849BEE4B12DD(ent, offset);
  }
}

_id_1E1767FDC6980106(ent) {
  if(!isDefined(self.lookatentities) || !scripts\engine\utility::array_contains(self.lookatentities, ent)) {
    return;
  }
  lookingatent = scripts\engine\utility::_id_350E192B13BEA45C(self.lookatentities) == ent;
  self.lookatentities = scripts\engine\utility::_id_57091B2D67654A14(self.lookatentities, ent);
  self.lookatentities = scripts\engine\utility::array_removeundefined(self.lookatentities);

  if(isDefined(ent._id_64B4740234F03713))
    ent._id_64B4740234F03713 = undefined;

  if(lookingatent) {
    if(isPlayer(ent))
      self _meth_504A5E2DF31069A4();

    if(self.lookatentities.size > 0) {
      _id_180BBBD4951D78AD = scripts\engine\utility::_id_350E192B13BEA45C(self.lookatentities);

      if(isPlayer(_id_180BBBD4951D78AD))
        self _meth_5621E511B99964A7(_id_180BBBD4951D78AD);
      else {
        offset = scripts\engine\utility::_id_53C4C53197386572(_id_180BBBD4951D78AD._id_64B4740234F03713, (0, 0, 0));
        self _meth_06EF849BEE4B12DD(_id_180BBBD4951D78AD, offset);
      }
    }
  }

  if(!self.lookatentities.size) {
    self _meth_1C339DAABA3F71DB(0);
    self stoplookat();
  }
}

_id_15DC13DCB9303962() {
  return _id_E98030C52E2F3EEC(level.player);
}

_id_E98030C52E2F3EEC(ent) {
  return scripts\engine\utility::is_equal(ent, _id_163FD34FC07D2B8A());
}

_id_163FD34FC07D2B8A() {
  if(!isDefined(self.lookatentities) || !self.lookatentities.size)
    return undefined;

  return scripts\engine\utility::_id_350E192B13BEA45C(self.lookatentities);
}

_id_11E84EAC72368D4E(_id_047A2D19079A1A2B, _id_F53E74A2C8FC7B96, _id_9324AFCBAA32C0B5, _id_4A3993C83B6C63E4, _id_E1BFDE0263743571, _id_C2906ADBD13483FE, _id_0D67AE0707347001, _id_412A2DB1704EFAE0, _id_352116002E9D5E8A, _id_C9C095852EF9437B, _id_E71B36661C60A1AB, _id_1FF7CB08338ACF70) {
  self endon("death");
  self endon("stop_idle_lookat");
  _id_1496542AEFB33638 = 1;
  _id_C0D0B7117D58EFE5 = 2;
  _id_B60538A3788D98B4 = 2000;
  _id_2530E9D4553C0B96 = 0;
  _id_D2CD83A1B45FE28B = 1;
  _id_C6A46E2201B2E656 = 2;
  _id_35A335748F48D56F = 3;
  _id_8C9657636D4EED14 = 4;
  _id_00A729F7C9DA5037 = 5;
  _id_54EE9BAADB24A574 = 6;
  _id_AFBD8C41B09C1C1D = 7;
  _id_E2C608D6182B190B = 8;
  _id_41FDD42A3580814E = 9;
  state = _id_2530E9D4553C0B96;
  _id_7DBFB7362717CE21 = _id_2530E9D4553C0B96;
  cooldown = 0;
  _id_047A2D19079A1A2B = int(_id_047A2D19079A1A2B) * 1000;
  _id_F53E74A2C8FC7B96 = int(_id_F53E74A2C8FC7B96) * 1000;
  _id_9324AFCBAA32C0B5 = int(_id_9324AFCBAA32C0B5) * 1000;
  _id_4A3993C83B6C63E4 = int(_id_4A3993C83B6C63E4) * 1000;

  for(;;) {
    _id_D2E4BDDEDDC9B4F9 = distance(level.player.origin, self.origin);
    _id_C496794DB8BDD976 = _id_C0D0B7117D58EFE5;

    if(_id_D2E4BDDEDDC9B4F9 > _id_E1BFDE0263743571)
      _id_C496794DB8BDD976 = _id_1496542AEFB33638;

    _id_DDD5FB570E804BF0 = anglesToForward(self.angles);
    _id_20AF753DED3657E1 = anglesToForward(level.player.angles);
    _id_24C6F607CFEED805 = vectorNormalize(level.player.origin - self.origin);
    _id_B9352A31FDB74279 = vectordot(_id_DDD5FB570E804BF0, _id_24C6F607CFEED805) > _id_E71B36661C60A1AB && _id_D2E4BDDEDDC9B4F9 < _id_C2906ADBD13483FE;
    _id_E5C3DCBA138F1F89 = vectordot(_id_20AF753DED3657E1, -1.0 * _id_24C6F607CFEED805) > _id_1FF7CB08338ACF70;

    if(state == _id_2530E9D4553C0B96) {
      if(!_id_B9352A31FDB74279)
        _id_7DBFB7362717CE21 = _id_D2CD83A1B45FE28B;
      else if(_id_B9352A31FDB74279)
        _id_7DBFB7362717CE21 = _id_C6A46E2201B2E656;
    } else if(state == _id_D2CD83A1B45FE28B) {
      if(_id_B9352A31FDB74279)
        _id_7DBFB7362717CE21 = _id_C6A46E2201B2E656;
    } else if(state == _id_C6A46E2201B2E656 && cooldown < gettime()) {
      if(!_id_B9352A31FDB74279)
        _id_7DBFB7362717CE21 = _id_D2CD83A1B45FE28B;
      else if(_id_C496794DB8BDD976 == _id_C0D0B7117D58EFE5 && _id_E5C3DCBA138F1F89)
        _id_7DBFB7362717CE21 = _id_35A335748F48D56F;
      else if(_id_C496794DB8BDD976 == _id_C0D0B7117D58EFE5 && !_id_E5C3DCBA138F1F89)
        _id_7DBFB7362717CE21 = _id_54EE9BAADB24A574;
      else if(_id_C496794DB8BDD976 == _id_1496542AEFB33638)
        _id_7DBFB7362717CE21 = _id_E2C608D6182B190B;
    } else if(state == _id_35A335748F48D56F) {
      if(_id_C496794DB8BDD976 != _id_C0D0B7117D58EFE5 || !_id_B9352A31FDB74279 || !_id_E5C3DCBA138F1F89)
        _id_7DBFB7362717CE21 = _id_8C9657636D4EED14;
    } else if(state == _id_8C9657636D4EED14 && cooldown < gettime()) {
      if(!_id_B9352A31FDB74279)
        _id_7DBFB7362717CE21 = _id_D2CD83A1B45FE28B;
      else if(_id_C496794DB8BDD976 == _id_C0D0B7117D58EFE5 && _id_E5C3DCBA138F1F89)
        _id_7DBFB7362717CE21 = _id_35A335748F48D56F;
      else if(_id_C496794DB8BDD976 == _id_C0D0B7117D58EFE5 && !_id_E5C3DCBA138F1F89)
        _id_7DBFB7362717CE21 = _id_AFBD8C41B09C1C1D;
      else if(_id_C496794DB8BDD976 == _id_1496542AEFB33638)
        _id_7DBFB7362717CE21 = _id_41FDD42A3580814E;
    } else if(state == _id_00A729F7C9DA5037 && cooldown < gettime()) {
      if(!_id_B9352A31FDB74279)
        _id_7DBFB7362717CE21 = _id_D2CD83A1B45FE28B;
      else if(_id_C496794DB8BDD976 == _id_C0D0B7117D58EFE5 && _id_E5C3DCBA138F1F89)
        _id_7DBFB7362717CE21 = _id_35A335748F48D56F;
      else if(_id_C496794DB8BDD976 == _id_C0D0B7117D58EFE5 && !_id_E5C3DCBA138F1F89)
        _id_7DBFB7362717CE21 = _id_AFBD8C41B09C1C1D;
      else if(_id_C496794DB8BDD976 == _id_1496542AEFB33638)
        _id_7DBFB7362717CE21 = _id_41FDD42A3580814E;
    } else if(state == _id_54EE9BAADB24A574 && cooldown < gettime()) {
      if(!_id_B9352A31FDB74279)
        _id_7DBFB7362717CE21 = _id_D2CD83A1B45FE28B;
      else if(_id_C496794DB8BDD976 == _id_C0D0B7117D58EFE5 && !_id_E5C3DCBA138F1F89)
        _id_7DBFB7362717CE21 = _id_AFBD8C41B09C1C1D;
      else if(_id_C496794DB8BDD976 == _id_C0D0B7117D58EFE5 && _id_E5C3DCBA138F1F89)
        _id_7DBFB7362717CE21 = _id_35A335748F48D56F;
      else if(_id_C496794DB8BDD976 == _id_1496542AEFB33638)
        _id_7DBFB7362717CE21 = _id_41FDD42A3580814E;
    } else if(state == _id_AFBD8C41B09C1C1D && cooldown < gettime()) {
      if(!_id_B9352A31FDB74279)
        _id_7DBFB7362717CE21 = _id_D2CD83A1B45FE28B;
      else if(_id_C496794DB8BDD976 == _id_C0D0B7117D58EFE5 && _id_E5C3DCBA138F1F89)
        _id_7DBFB7362717CE21 = _id_00A729F7C9DA5037;
      else if(_id_C496794DB8BDD976 == _id_C0D0B7117D58EFE5 && !_id_E5C3DCBA138F1F89)
        _id_7DBFB7362717CE21 = _id_54EE9BAADB24A574;
      else if(_id_C496794DB8BDD976 == _id_1496542AEFB33638)
        _id_7DBFB7362717CE21 = _id_41FDD42A3580814E;
    } else if(state == _id_E2C608D6182B190B && cooldown < gettime()) {
      if(!_id_B9352A31FDB74279)
        _id_7DBFB7362717CE21 = _id_D2CD83A1B45FE28B;
      else if(_id_C496794DB8BDD976 == _id_1496542AEFB33638)
        _id_7DBFB7362717CE21 = _id_41FDD42A3580814E;
      else if(_id_C496794DB8BDD976 == _id_C0D0B7117D58EFE5 && _id_E5C3DCBA138F1F89)
        _id_7DBFB7362717CE21 = _id_35A335748F48D56F;
      else if(_id_C496794DB8BDD976 == _id_C0D0B7117D58EFE5 && !_id_E5C3DCBA138F1F89)
        _id_7DBFB7362717CE21 = _id_AFBD8C41B09C1C1D;
    } else if(state == _id_41FDD42A3580814E && cooldown < gettime()) {
      if(!_id_B9352A31FDB74279)
        _id_7DBFB7362717CE21 = _id_D2CD83A1B45FE28B;
      else if(_id_C496794DB8BDD976 == _id_1496542AEFB33638)
        _id_7DBFB7362717CE21 = _id_E2C608D6182B190B;
      else if(_id_C496794DB8BDD976 == _id_C0D0B7117D58EFE5 && !_id_E5C3DCBA138F1F89)
        _id_7DBFB7362717CE21 = _id_AFBD8C41B09C1C1D;
      else if(_id_C496794DB8BDD976 == _id_C0D0B7117D58EFE5 && _id_E5C3DCBA138F1F89)
        _id_7DBFB7362717CE21 = _id_00A729F7C9DA5037;
    }

    if(state != _id_7DBFB7362717CE21) {
      if(state == _id_2530E9D4553C0B96) {
        if(_id_7DBFB7362717CE21 == _id_D2CD83A1B45FE28B)
          _id_C0FACA532411608C();
        else if(_id_7DBFB7362717CE21 == _id_C6A46E2201B2E656)
          cooldown = gettime() + _id_B60538A3788D98B4;
      } else if(state == _id_D2CD83A1B45FE28B) {
        if(_id_7DBFB7362717CE21 == _id_C6A46E2201B2E656)
          cooldown = gettime() + _id_B60538A3788D98B4;
      } else if(state == _id_C6A46E2201B2E656) {
        if(_id_7DBFB7362717CE21 == _id_D2CD83A1B45FE28B)
          _id_C0FACA532411608C();
        else if(_id_7DBFB7362717CE21 == _id_35A335748F48D56F)
          _id_A5AA158578694A69(_id_0D67AE0707347001, _id_352116002E9D5E8A);
        else if(_id_7DBFB7362717CE21 == _id_54EE9BAADB24A574) {
          _id_A5AA158578694A69(_id_0D67AE0707347001, _id_352116002E9D5E8A);
          cooldown = gettime() + _id_047A2D19079A1A2B;
        } else if(_id_7DBFB7362717CE21 == _id_E2C608D6182B190B) {
          _id_A5AA158578694A69(_id_412A2DB1704EFAE0, _id_C9C095852EF9437B);
          cooldown = gettime() + _id_F53E74A2C8FC7B96;
        }
      } else if(state == _id_35A335748F48D56F) {
        if(_id_7DBFB7362717CE21 == _id_8C9657636D4EED14)
          cooldown = gettime() + _id_B60538A3788D98B4;
      } else if(state == _id_8C9657636D4EED14) {
        if(_id_7DBFB7362717CE21 == _id_D2CD83A1B45FE28B)
          _id_C0FACA532411608C();
        else if(_id_7DBFB7362717CE21 == _id_AFBD8C41B09C1C1D) {
          _id_C0FACA532411608C();
          cooldown = gettime() + _id_047A2D19079A1A2B;
        } else if(_id_7DBFB7362717CE21 == _id_41FDD42A3580814E) {
          _id_C0FACA532411608C();
          cooldown = gettime() + _id_047A2D19079A1A2B;
        }
      } else if(state == _id_00A729F7C9DA5037) {
        if(_id_7DBFB7362717CE21 == _id_35A335748F48D56F)
          _id_A5AA158578694A69(_id_0D67AE0707347001, _id_352116002E9D5E8A);
        else if(_id_7DBFB7362717CE21 == _id_AFBD8C41B09C1C1D)
          cooldown = gettime() + _id_9324AFCBAA32C0B5;
        else if(_id_7DBFB7362717CE21 == _id_41FDD42A3580814E)
          cooldown = gettime() + _id_4A3993C83B6C63E4;
      } else if(state == _id_54EE9BAADB24A574) {
        if(_id_7DBFB7362717CE21 == _id_D2CD83A1B45FE28B)
          _id_C0FACA532411608C();
        else if(_id_7DBFB7362717CE21 == _id_AFBD8C41B09C1C1D) {
          _id_C0FACA532411608C();
          cooldown = gettime() + _id_9324AFCBAA32C0B5;
        } else if(_id_7DBFB7362717CE21 == _id_41FDD42A3580814E) {
          _id_C0FACA532411608C();
          cooldown = gettime() + _id_4A3993C83B6C63E4;
        }
      } else if(state == _id_AFBD8C41B09C1C1D) {
        if(_id_7DBFB7362717CE21 == _id_00A729F7C9DA5037)
          cooldown = gettime() + _id_B60538A3788D98B4;
        else if(_id_7DBFB7362717CE21 == _id_54EE9BAADB24A574) {
          _id_A5AA158578694A69(_id_0D67AE0707347001, _id_352116002E9D5E8A);
          cooldown = gettime() + _id_047A2D19079A1A2B;
        } else if(_id_7DBFB7362717CE21 == _id_41FDD42A3580814E)
          cooldown = gettime() + _id_4A3993C83B6C63E4;
      } else if(state == _id_E2C608D6182B190B) {
        if(_id_7DBFB7362717CE21 == _id_D2CD83A1B45FE28B)
          _id_C0FACA532411608C();
        else if(_id_7DBFB7362717CE21 == _id_41FDD42A3580814E) {
          _id_C0FACA532411608C();
          cooldown = gettime() + _id_4A3993C83B6C63E4;
        } else if(_id_7DBFB7362717CE21 == _id_35A335748F48D56F) {} else if(_id_7DBFB7362717CE21 == _id_AFBD8C41B09C1C1D) {
          _id_C0FACA532411608C();
          cooldown = gettime() + _id_9324AFCBAA32C0B5;
        }
      } else if(state == _id_41FDD42A3580814E) {
        if(_id_7DBFB7362717CE21 == _id_E2C608D6182B190B) {
          _id_A5AA158578694A69(_id_412A2DB1704EFAE0, _id_C9C095852EF9437B);
          cooldown = gettime() + _id_F53E74A2C8FC7B96;
        } else if(_id_7DBFB7362717CE21 == _id_AFBD8C41B09C1C1D)
          cooldown = gettime() + _id_9324AFCBAA32C0B5;
        else if(_id_7DBFB7362717CE21 == _id_00A729F7C9DA5037)
          cooldown = gettime() + _id_B60538A3788D98B4;
      }

      state = _id_7DBFB7362717CE21;
    }

    waitframe();
  }
}

_id_51C52CB24ACD5706(_id_9D6CB79F4E312DDD, _id_57052F010A23838F, radius, _id_48ACCC37953CFC3B, _id_477C1209E5432ABE, _id_E71B36661C60A1AB, _id_1FF7CB08338ACF70) {
  self endon("death");
  self endon("stop_idle_lookat");
  _id_D2CD83A1B45FE28B = 0;
  _id_C6A46E2201B2E656 = 1;
  _id_9C0421243EC5A516 = 2;
  _id_A56A8824D14B26DF = 3;
  _id_0738C989DE9B7AB4 = 2000;
  state = _id_D2CD83A1B45FE28B;
  _id_7DBFB7362717CE21 = _id_D2CD83A1B45FE28B;
  cooldown = 0;
  _id_9D6CB79F4E312DDD = int(_id_9D6CB79F4E312DDD) * 1000;
  _id_57052F010A23838F = int(_id_57052F010A23838F) * 1000;

  for(;;) {
    _id_D2E4BDDEDDC9B4F9 = distance(level.player.origin, self.origin);
    _id_DDD5FB570E804BF0 = anglesToForward(self.angles);
    _id_20AF753DED3657E1 = anglesToForward(level.player.angles);
    _id_24C6F607CFEED805 = vectorNormalize(level.player.origin - self.origin);
    _id_B9352A31FDB74279 = vectordot(_id_DDD5FB570E804BF0, _id_24C6F607CFEED805) > _id_E71B36661C60A1AB && _id_D2E4BDDEDDC9B4F9 < radius;
    _id_E5C3DCBA138F1F89 = vectordot(_id_20AF753DED3657E1, -1.0 * _id_24C6F607CFEED805) > _id_1FF7CB08338ACF70;
    _id_B9352A31FDB74279 = _id_B9352A31FDB74279 && _id_E5C3DCBA138F1F89;

    if(state == _id_D2CD83A1B45FE28B) {
      if(_id_B9352A31FDB74279)
        _id_7DBFB7362717CE21 = _id_C6A46E2201B2E656;
    } else if(state == _id_C6A46E2201B2E656 && cooldown < gettime()) {
      if(_id_B9352A31FDB74279)
        _id_7DBFB7362717CE21 = _id_9C0421243EC5A516;
      else
        _id_7DBFB7362717CE21 = _id_D2CD83A1B45FE28B;
    } else if(state == _id_9C0421243EC5A516 && cooldown < gettime()) {
      if(_id_B9352A31FDB74279)
        _id_7DBFB7362717CE21 = _id_A56A8824D14B26DF;
      else
        _id_7DBFB7362717CE21 = _id_D2CD83A1B45FE28B;
    } else if(state == _id_A56A8824D14B26DF && cooldown < gettime()) {
      if(_id_B9352A31FDB74279)
        _id_7DBFB7362717CE21 = _id_9C0421243EC5A516;
      else
        _id_7DBFB7362717CE21 = _id_D2CD83A1B45FE28B;
    }

    if(state != _id_7DBFB7362717CE21) {
      if(state == _id_D2CD83A1B45FE28B) {
        if(_id_7DBFB7362717CE21 == _id_C6A46E2201B2E656)
          cooldown = gettime() + _id_0738C989DE9B7AB4;
      } else if(state == _id_C6A46E2201B2E656) {
        if(_id_7DBFB7362717CE21 == _id_9C0421243EC5A516) {
          _id_A5AA158578694A69(_id_48ACCC37953CFC3B, _id_477C1209E5432ABE);
          cooldown = gettime() + _id_9D6CB79F4E312DDD;
        }
      } else if(state == _id_9C0421243EC5A516) {
        if(_id_7DBFB7362717CE21 == _id_A56A8824D14B26DF) {
          _id_C0FACA532411608C();
          cooldown = gettime() + _id_57052F010A23838F;
        } else if(_id_7DBFB7362717CE21 == _id_D2CD83A1B45FE28B)
          _id_C0FACA532411608C();
      } else if(state == _id_A56A8824D14B26DF) {
        if(_id_7DBFB7362717CE21 == _id_9C0421243EC5A516) {
          _id_A5AA158578694A69(_id_48ACCC37953CFC3B, _id_477C1209E5432ABE);
          cooldown = gettime() + _id_9D6CB79F4E312DDD;
        }
      }

      state = _id_7DBFB7362717CE21;
    }

    waitframe();
  }
}

_id_A72247099F0414E7(enable, _id_53DAABCC00A7D742, _id_DB0391BD4C2D3D19) {
  level._id_EE5DCC2CB0E28ECC = enable;

  if(enable)
    level thread _id_347C218F281719E4(_id_53DAABCC00A7D742, _id_DB0391BD4C2D3D19);
  else
    level notify("end_levellookatteam");
}

_id_347C218F281719E4(_id_53DAABCC00A7D742, _id_DB0391BD4C2D3D19) {
  level endon("end_levellookatteam");

  if(!isDefined(_id_53DAABCC00A7D742))
    _id_53DAABCC00A7D742 = 1024;

  if(!isDefined(_id_DB0391BD4C2D3D19))
    _id_DB0391BD4C2D3D19 = 512;

  while(level._id_EE5DCC2CB0E28ECC) {
    wait 5;
    ai = getaiarrayinradius(level.player.origin, _id_53DAABCC00A7D742);

    foreach(guy in ai) {
      if(isDefined(guy isinscriptedstate()) && guy isinscriptedstate()) {
        continue;
      }
      guy thread _id_51A6F1734F850AEC(ai, _id_DB0391BD4C2D3D19, 5);
    }
  }
}

_id_51A6F1734F850AEC(ai, maxdist, _id_DB0D5BF7EAFE4A31) {
  self endon("death");
  self endon("kill_lookatteam");
  _id_80A9352CF824E995(1);
  _id_2C49ADD797A42AAB(ai, maxdist);
  _id_FF0BB38CFB102C11(ai, maxdist, 5);
  _id_80A9352CF824E995(0);
}

_id_1961BA599803679A(guys, maxdist, _id_DB0D5BF7EAFE4A31) {
  if(!isDefined(self) || !isent(self)) {
    return;
  }
  self endon("death");
  self endon("kill_lookatteam");

  if(!isDefined(self) || self == level.player) {
    return;
  }
  _id_80A9352CF824E995(1);
  guys[guys.size] = level.player;

  for(;;) {
    _id_C38D71F632B89906();
    _id_2C49ADD797A42AAB(guys);
    _id_FF0BB38CFB102C11(guys, maxdist, _id_DB0D5BF7EAFE4A31);
  }
}

_id_80A9352CF824E995(enable) {
  self _meth_1C339DAABA3F71DB(enable);
  self._id_C15AC68FC63FC9A8 = enable;

  if(!enable)
    self notify("kill_lookatteam");
}

_id_2C49ADD797A42AAB(guys, maxdist) {
  if(!isDefined(self._id_C15AC68FC63FC9A8) || !self._id_C15AC68FC63FC9A8) {
    return;
  }
  guys = scripts\engine\utility::array_removedead(guys);
  guy = scripts\engine\utility::random(guys);

  if(guys.size < 2) {
    return;
  }
  if(!isDefined(guy) || vectordot(self.origin, guy.origin) < 0) {
    return;
  }
  if(guy == self) {
    _id_C38D71F632B89906();
    return;
  }

  if(isDefined(self._id_85F04BF47BF39FF6) && self._id_85F04BF47BF39FF6 == guy) {
    self._id_85F04BF47BF39FF6 = undefined;
    return;
  }

  if(isDefined(maxdist) && distancesquared(self.origin, guy.origin) > maxdist * maxdist) {
    return;
  }
  if(vectordot(self.origin, guy.origin) <= 0) {
    return;
  }
  self._id_85F04BF47BF39FF6 = guy;
  _id_9FADCB46C7EF90A0(guy);
}

_id_FF0BB38CFB102C11(guys, maxdist, _id_DB0D5BF7EAFE4A31) {
  guys = scripts\engine\utility::array_removedead(guys);
  guys = sortbydistance(guys, self.origin);

  if(guys.size < 2) {
    return;
  }
  for(_id_F005387B5006ADE6 = 0; _id_F005387B5006ADE6 < guys.size; _id_F005387B5006ADE6++) {
    guy = guys[_id_F005387B5006ADE6];

    if(!isDefined(self._id_C15AC68FC63FC9A8) || !self._id_C15AC68FC63FC9A8) {
      continue;
    }
    if(!isDefined(guy)) {
      continue;
    }
    if(self == guy) {
      continue;
    }
    if(!isalive(guy)) {
      continue;
    }
    if(isDefined(self._id_85F04BF47BF39FF6) && self._id_85F04BF47BF39FF6 == guy) {
      self._id_85F04BF47BF39FF6 = undefined;
      continue;
    }

    if(isDefined(_id_DB0D5BF7EAFE4A31) && _id_F005387B5006ADE6 >= _id_DB0D5BF7EAFE4A31) {
      return;
    }
    if(isDefined(maxdist) && distancesquared(self.origin, guy.origin) > maxdist * maxdist) {
      continue;
    }
    if(vectordot(self.origin, guy.origin) <= 0) {
      continue;
    }
    self._id_85F04BF47BF39FF6 = guy;
    _id_9FADCB46C7EF90A0(guy);
  }

  _id_C38D71F632B89906();
}

_id_C38D71F632B89906() {
  if(!isDefined(self) || !isent(self)) {
    return;
  }
  minidletime = 2;
  _id_E7FC8C00DAB4CA1A = 4;
  self _meth_1C339DAABA3F71DB(0);
  wait(randomfloatrange(minidletime, _id_E7FC8C00DAB4CA1A));
  self _meth_1C339DAABA3F71DB(1);
}

_id_9FADCB46C7EF90A0(other) {
  _id_477C1209E5432ABE = 0.8;
  speed = 1;
  _id_6FBEA72303085C6F(other, scripts\common\utility::_id_B88F4E5BAFF057A9(speed), _id_477C1209E5432ABE);
  _id_08660E4BE5019B5F = 0.5;
  _id_CF84BB92B95910ED = 1;

  if(isDefined(other)) {
    if(self.team == other.team) {
      _id_08660E4BE5019B5F = 1.5;
      _id_CF84BB92B95910ED = 2.5;
    } else {
      _id_08660E4BE5019B5F = 1;
      _id_CF84BB92B95910ED = 1.5;
    }
  }

  wait(randomfloatrange(_id_08660E4BE5019B5F, _id_CF84BB92B95910ED));
}
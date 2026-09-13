/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5e7a036feaf4f8b7.gsc
***********************************************/

init() {
  if(!_id_E60552DD6ABCC4AA()) {
    return;
  }
  level._id_ED20AE31A47F989F = spawnStruct();
  level._id_ED20AE31A47F989F._id_9BE11FF458712883 = [];
  level._id_ED20AE31A47F989F._id_84C8C837E7A7644D = [];
  level._id_ED20AE31A47F989F._id_1A5AA18908F2D6B1 = [];
  level._id_ED20AE31A47F989F._id_893573278FDD3634 = 0;
  level._id_ED20AE31A47F989F._id_C9BEEAF4E87BBF73 = getdvarint("dvar_541A5F0187A7C428", 0);
  level._id_ED20AE31A47F989F._id_5A8C5CA1DF0AE11D = getdvarint("dvar_0F245A26CC1FC582", 0);
  level._id_ED20AE31A47F989F._id_D312DE18B3BED3E7 = getdvarint("dvar_36E4B28F99C3D64C", 0);
  level._id_ED20AE31A47F989F._id_8071261D28324A16 = getdvarfloat("dvar_423367C04EE7DD39", 1.0);
  level._id_ED20AE31A47F989F._id_DD0B7F81BF42A5EA = getdvarint("dvar_779153D042FA9DE7", 360);
  level._id_ED20AE31A47F989F._id_70DA8BB6903D62DC = ::onprematchdone;
  scripts\engine\scriptable::scriptable_addusedcallback(::scriptable_used);
  scripts\engine\scriptable::scriptable_addautousecallback(::scriptable_used);
  _id_7E52B56769FA7774::_id_C3E1679F348A5E40(::_id_8E782CCFA7A41DA6);

  if(getdvarint("dvar_8823E2F4A428CFC1", 0) && getdvarint("scr_ssc_enabled", 0)) {
    _id_067FB1233E876ED8::_id_4F7660CFD85CD517("broken_atm", ::_id_E6C1C35181A2870F);
    _id_067FB1233E876ED8::_id_412F527EF0863F0E("broken_atm", ::_id_E0B56DFD8B5B7F97);
  }

  level._id_ED20AE31A47F989F.conf_fx["sparks"] = loadfx("vfx/iw8_br/gameplay/vfx_sparks_atm.vfx");
}

_id_E60552DD6ABCC4AA() {
  if(getdvarint("dvar_A6B7002B1A7FEF73", 0) == 0)
    return 0;

  if(!istrue(level.br_plunder_enabled))
    return 0;

  return 1;
}

_id_E0B56DFD8B5B7F97(_id_6AAA6A5DCFA4D64D) {
  _id_6AAA6A5DCFA4D64D._id_2954EF0BA3CA0371 = level._id_ED20AE31A47F989F._id_893573278FDD3634;
  level._id_ED20AE31A47F989F._id_893573278FDD3634++;
  level._id_ED20AE31A47F989F._id_9BE11FF458712883[_id_6AAA6A5DCFA4D64D._id_2954EF0BA3CA0371] = [];

  if(!isDefined(level._id_ED20AE31A47F989F._id_863FB512AF8A5A97))
    level._id_ED20AE31A47F989F._id_863FB512AF8A5A97 = [];

  level._id_ED20AE31A47F989F._id_863FB512AF8A5A97[_id_6AAA6A5DCFA4D64D._id_2954EF0BA3CA0371] = _id_6AAA6A5DCFA4D64D;
  return _id_6AAA6A5DCFA4D64D;
}

_id_72758B0B1DC1E468(interval, limit) {
  self setscriptablepartstate("broken_atm", "disabled");
  thread _id_443D890D24291FD5(interval, limit);
}

_id_3E992620BA9A364C(_id_B512F2C3531420FC, interval, limit) {
  _id_E0B56DFD8B5B7F97(_id_B512F2C3531420FC);
  _id_B512F2C3531420FC _id_72758B0B1DC1E468(interval, limit);
}

_id_E6C1C35181A2870F() {
  _id_27115CAE178779E0 = getentitylessscriptablearray("scriptable_broken_atm_scriptable", "classname");
  return _id_27115CAE178779E0;
}

onprematchdone() {
  if(!_id_E60552DD6ABCC4AA()) {
    return;
  }
  interval = getdvarfloat("dvar_28E4C03EC51AD158", 5);
  limit = getdvarint("dvar_76F1FD6CD7E4D0A7", 3);

  if(getdvarint("dvar_8823E2F4A428CFC1", 0) && getdvarint("scr_ssc_enabled", 0)) {
    foreach(_id_B512F2C3531420FC in level._id_ED20AE31A47F989F._id_863FB512AF8A5A97) {
      if(!isDefined(_id_B512F2C3531420FC)) {
        continue;
      }
      _id_B512F2C3531420FC _id_72758B0B1DC1E468(interval, limit);
    }
  } else {
    _id_5CE65BFD4643A040 = _id_E6C1C35181A2870F();
    _id_DE49DA8D08D362D4 = int(ceil(_id_5CE65BFD4643A040.size * level._id_ED20AE31A47F989F._id_8071261D28324A16));
    level._id_ED20AE31A47F989F._id_863FB512AF8A5A97 = _id_1F6BC044DD1738AB::_getrandomlocations(_id_5CE65BFD4643A040, _id_DE49DA8D08D362D4);

    foreach(_id_B512F2C3531420FC in level._id_ED20AE31A47F989F._id_863FB512AF8A5A97) {
      if(!isDefined(_id_B512F2C3531420FC)) {
        continue;
      }
      _id_3E992620BA9A364C(_id_B512F2C3531420FC, interval, limit);
    }
  }
}

_id_648885BAD3260249(pos, angles, interval, limit) {
  if(!_id_E60552DD6ABCC4AA()) {
    return;
  }
  _id_B512F2C3531420FC = spawnscriptable("broken_atm_scriptable", pos, angles);
  _id_3E992620BA9A364C(_id_B512F2C3531420FC, interval, limit);
  return _id_B512F2C3531420FC;
}

_id_443D890D24291FD5(interval, limit) {
  level endon("game_ended");
  level endon("force_end");
  _id_2006F940C17EA89B = getdvarfloat("dvar_0ACEA47F92CFDE4E", 0.0);

  if(_id_2006F940C17EA89B > 0)
    wait(_id_2006F940C17EA89B);

  self setscriptablepartstate("broken_atm", "visible");
  _id_33927D95D36D0798 = self.angles[1];
  _id_EF17285813D8AF9D = level._id_ED20AE31A47F989F._id_DD0B7F81BF42A5EA;
  _id_F638FFB0F773A822 = _id_EF17285813D8AF9D / limit;
  _id_33927D95D36D0798 = _id_33927D95D36D0798 - _id_EF17285813D8AF9D / 2;
  level._id_ED20AE31A47F989F._id_84C8C837E7A7644D[self._id_2954EF0BA3CA0371] = [];

  if(limit > 1) {
    _id_9DBBC8DD984310F1 = _id_33927D95D36D0798;
    _id_9DBBC8DD984310F1 = _id_9DBBC8DD984310F1 - _id_F638FFB0F773A822 / 2;

    if(_id_9DBBC8DD984310F1 < 0)
      _id_9DBBC8DD984310F1 = _id_9DBBC8DD984310F1 + 360;

    level._id_ED20AE31A47F989F._id_84C8C837E7A7644D[self._id_2954EF0BA3CA0371][0] = _id_9DBBC8DD984310F1;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < limit; _id_AC0E594AC96AA3A8++) {
      _id_EBF05B5978327EC0 = _id_9DBBC8DD984310F1 + _id_F638FFB0F773A822;
      _id_9DBBC8DD984310F1 = scripts\engine\utility::ter_op(_id_EBF05B5978327EC0 > 360, _id_EBF05B5978327EC0 - 360, _id_EBF05B5978327EC0);
      level._id_ED20AE31A47F989F._id_84C8C837E7A7644D[self._id_2954EF0BA3CA0371] = scripts\engine\utility::array_add(level._id_ED20AE31A47F989F._id_84C8C837E7A7644D[self._id_2954EF0BA3CA0371], _id_9DBBC8DD984310F1);
    }
  }

  if(_id_B55532D2305486B8() && istrue(level._id_16EF52214AC3A63F._id_A5B707E79D910EF6._id_2F1EE623E7FC5C8C)) {
    level._id_ED20AE31A47F989F._id_1A5AA18908F2D6B1[self._id_2954EF0BA3CA0371] = [];
    _id_9DBBC8DD984310F1 = _id_33927D95D36D0798;
    _id_9DBBC8DD984310F1 = _id_9DBBC8DD984310F1 - _id_F638FFB0F773A822;

    if(_id_9DBBC8DD984310F1 < 0)
      _id_9DBBC8DD984310F1 = _id_9DBBC8DD984310F1 + 360;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < limit; _id_AC0E594AC96AA3A8++) {
      _id_EBF05B5978327EC0 = _id_9DBBC8DD984310F1 + _id_F638FFB0F773A822;
      _id_9DBBC8DD984310F1 = scripts\engine\utility::ter_op(_id_EBF05B5978327EC0 > 360, _id_EBF05B5978327EC0 - 360, _id_EBF05B5978327EC0);
      level._id_ED20AE31A47F989F._id_1A5AA18908F2D6B1[self._id_2954EF0BA3CA0371] = scripts\engine\utility::array_add(level._id_ED20AE31A47F989F._id_1A5AA18908F2D6B1[self._id_2954EF0BA3CA0371], _id_9DBBC8DD984310F1);
    }
  }

  enabled = 1;
  _id_DDF23F6435864493 = 0;
  _id_9D71E5C92C6BC2C7 = 0;

  for(;;) {
    _id_BD34286DE6DC8EC6 = interval;
    _id_C36F5A77E92E0B92 = _id_946FFFE773A4B030();

    if(_id_C36F5A77E92E0B92 && level._id_16EF52214AC3A63F._id_A5B707E79D910EF6._id_BB1D98E538185DF4 != 0)
      _id_BD34286DE6DC8EC6 = level._id_16EF52214AC3A63F._id_A5B707E79D910EF6._id_BB1D98E538185DF4;

    wait(_id_BD34286DE6DC8EC6);
    _id_2403C90E287805E0 = _id_946FFFE773A4B030();
    _id_ED0DEAB380D4F7E9 = level._id_ED20AE31A47F989F._id_9BE11FF458712883[self._id_2954EF0BA3CA0371].size;

    if(_id_2403C90E287805E0 && !_id_C36F5A77E92E0B92) {
      if(!enabled)
        enabled = 1;

      self setscriptablepartstate("broken_atm", "visible_event");

      if(istrue(level._id_16EF52214AC3A63F._id_A5B707E79D910EF6._id_2F1EE623E7FC5C8C))
        level._id_ED20AE31A47F989F._id_84C8C837E7A7644D[self._id_2954EF0BA3CA0371] = scripts\engine\utility::array_combine(level._id_ED20AE31A47F989F._id_84C8C837E7A7644D[self._id_2954EF0BA3CA0371], level._id_ED20AE31A47F989F._id_1A5AA18908F2D6B1[self._id_2954EF0BA3CA0371]);
    }

    if(!_id_2403C90E287805E0 && _id_C36F5A77E92E0B92) {
      if(istrue(level._id_16EF52214AC3A63F._id_A5B707E79D910EF6._id_2F1EE623E7FC5C8C)) {
        foreach(_id_B5694355AE72ABBB in level._id_ED20AE31A47F989F._id_1A5AA18908F2D6B1[self._id_2954EF0BA3CA0371])
        level._id_ED20AE31A47F989F._id_84C8C837E7A7644D[self._id_2954EF0BA3CA0371] = scripts\engine\utility::array_remove(level._id_ED20AE31A47F989F._id_84C8C837E7A7644D[self._id_2954EF0BA3CA0371], _id_B5694355AE72ABBB);
      }

      enabled = 0;
      self setscriptablepartstate("broken_atm", "disabled");
      _id_9D71E5C92C6BC2C7 = gettime() + level._id_16EF52214AC3A63F._id_A5B707E79D910EF6._id_F9B722C9EDCE3106 * 1000;
      _id_DDF23F6435864493 = level._id_ED20AE31A47F989F._id_C9BEEAF4E87BBF73;
      continue;
    }

    if(_id_ED0DEAB380D4F7E9 >= scripts\engine\utility::ter_op(_id_2403C90E287805E0 && istrue(level._id_16EF52214AC3A63F._id_A5B707E79D910EF6._id_2F1EE623E7FC5C8C), limit * 2, limit)) {
      continue;
    }
    if(!_id_2403C90E287805E0 && level._id_ED20AE31A47F989F._id_C9BEEAF4E87BBF73 > 0 && _id_DDF23F6435864493 >= level._id_ED20AE31A47F989F._id_C9BEEAF4E87BBF73) {
      if(level._id_ED20AE31A47F989F._id_5A8C5CA1DF0AE11D > 0 || level._id_ED20AE31A47F989F._id_D312DE18B3BED3E7 > 0) {
        if(_id_9D71E5C92C6BC2C7 == 0) {
          _id_445B8E3C7F65E081 = randomintrange(level._id_ED20AE31A47F989F._id_5A8C5CA1DF0AE11D, level._id_ED20AE31A47F989F._id_D312DE18B3BED3E7);
          _id_9D71E5C92C6BC2C7 = gettime() + _id_445B8E3C7F65E081 * 1000;
          continue;
        } else if(_id_9D71E5C92C6BC2C7 < gettime()) {
          _id_9D71E5C92C6BC2C7 = 0;
          _id_DDF23F6435864493 = 0;
          enabled = 1;
          self setscriptablepartstate("broken_atm", "visible");
        } else
          continue;
      } else
        return;
    }

    _id_6A87E478C76FD4A5 = isDefined(level.br_plunder) && isDefined(level.br_plunder.quantity) && level.br_plunder.quantity.size > 0;

    if(!_id_6A87E478C76FD4A5) {
      continue;
    }
    _id_3949D58EF57F9F31 = level._id_ED20AE31A47F989F._id_84C8C837E7A7644D[self._id_2954EF0BA3CA0371][level._id_ED20AE31A47F989F._id_84C8C837E7A7644D[self._id_2954EF0BA3CA0371].size - 1];
    level._id_ED20AE31A47F989F._id_84C8C837E7A7644D[self._id_2954EF0BA3CA0371] = scripts\engine\utility::array_remove_index(level._id_ED20AE31A47F989F._id_84C8C837E7A7644D[self._id_2954EF0BA3CA0371], level._id_ED20AE31A47F989F._id_84C8C837E7A7644D[self._id_2954EF0BA3CA0371].size - 1);

    if(_id_B55532D2305486B8()) {
      _id_F90D0E006A1F717B = scripts\engine\utility::ter_op(_id_2403C90E287805E0, level._id_16EF52214AC3A63F._id_A5B707E79D910EF6._id_E8FB817A73E06ABA, getdvarint("dvar_4483C0761071FF04", 1));
      _id_F90D0E006A1F717B = int(clamp(_id_F90D0E006A1F717B, 0, level.br_plunder.quantity.size - 1));
      _id_9714DDDA6A6DF159 = scripts\engine\utility::ter_op(_id_2403C90E287805E0, level._id_16EF52214AC3A63F._id_A5B707E79D910EF6._id_9714DDDA6A6DF159, getdvarint("dvar_C27965972EAEB818", 50));
    } else {
      _id_F90D0E006A1F717B = int(clamp(getdvarint("dvar_4483C0761071FF04", 1), 0, level.br_plunder.quantity.size - 1));
      _id_9714DDDA6A6DF159 = getdvarint("dvar_C27965972EAEB818", 50);
    }

    if(istrue(level.bmoovertime) && isDefined(level.overtimecashmultiplier))
      _id_9714DDDA6A6DF159 = int(_id_9714DDDA6A6DF159 * level.overtimecashmultiplier);

    dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, self.origin, self.angles, undefined, _id_3949D58EF57F9F31, undefined, undefined, undefined, undefined, undefined, 1);
    pickupent = _id_7E52B56769FA7774::spawnpickup(level.br_plunder.names[_id_F90D0E006A1F717B], _id_CB4FAD49263E20C4, _id_9714DDDA6A6DF159, 1);
    _id_1CCEE23D5B4508E3 = "br_plunder_broken_atm_";
    _id_8D02A463027120AA = "cash";
    playsoundatpos(self.origin + (0, 0, 40), _id_1CCEE23D5B4508E3 + _id_8D02A463027120AA);

    if(isDefined(pickupent)) {
      pickupent._id_2954EF0BA3CA0371 = self._id_2954EF0BA3CA0371;
      pickupent._id_3949D58EF57F9F31 = _id_3949D58EF57F9F31;
      level._id_ED20AE31A47F989F._id_9BE11FF458712883[self._id_2954EF0BA3CA0371] = scripts\engine\utility::array_add(level._id_ED20AE31A47F989F._id_9BE11FF458712883[self._id_2954EF0BA3CA0371], pickupent);
      _id_DDF23F6435864493++;
    }

    if(!_id_2403C90E287805E0 && level._id_ED20AE31A47F989F._id_C9BEEAF4E87BBF73 > 0 && _id_DDF23F6435864493 >= level._id_ED20AE31A47F989F._id_C9BEEAF4E87BBF73 && enabled) {
      enabled = 0;
      self setscriptablepartstate("broken_atm", "disabled");
    }
  }
}

scriptable_used(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(isDefined(instance._id_2954EF0BA3CA0371)) {
    if(isDefined(level.br_plunder) && isDefined(level.br_plunder.plunderlimit) && isDefined(player) && isDefined(player.plundercount) && player.plundercount >= level.br_plunder.plunderlimit) {
      return;
    }
    instance _id_2CAC9989E2B5559A();
  }
}

_id_8E782CCFA7A41DA6() {
  if(isDefined(self._id_2954EF0BA3CA0371))
    _id_2CAC9989E2B5559A();
}

_id_2CAC9989E2B5559A() {
  if(isDefined(self._id_2954EF0BA3CA0371)) {
    if(isDefined(self._id_3949D58EF57F9F31)) {
      if(!scripts\engine\utility::array_contains(level._id_ED20AE31A47F989F._id_84C8C837E7A7644D[self._id_2954EF0BA3CA0371], self._id_3949D58EF57F9F31)) {
        if(!isDefined(level._id_ED20AE31A47F989F._id_1A5AA18908F2D6B1[self._id_2954EF0BA3CA0371]) || _id_946FFFE773A4B030() || !scripts\engine\utility::array_contains(level._id_ED20AE31A47F989F._id_1A5AA18908F2D6B1[self._id_2954EF0BA3CA0371], self._id_3949D58EF57F9F31))
          level._id_ED20AE31A47F989F._id_84C8C837E7A7644D[self._id_2954EF0BA3CA0371] = scripts\engine\utility::array_add_safe(level._id_ED20AE31A47F989F._id_84C8C837E7A7644D[self._id_2954EF0BA3CA0371], self._id_3949D58EF57F9F31);
      }
    } else {}

    level._id_ED20AE31A47F989F._id_9BE11FF458712883[self._id_2954EF0BA3CA0371] = scripts\engine\utility::array_remove(level._id_ED20AE31A47F989F._id_9BE11FF458712883[self._id_2954EF0BA3CA0371], self);
  } else {}
}

_id_946FFFE773A4B030() {
  return _id_B55532D2305486B8() && istrue(level._id_16EF52214AC3A63F._id_A5B707E79D910EF6.active);
}

_id_B55532D2305486B8() {
  return isDefined(level._id_16EF52214AC3A63F) && isDefined(level._id_16EF52214AC3A63F._id_A5B707E79D910EF6);
}
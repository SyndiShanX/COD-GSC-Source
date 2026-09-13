/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7feaed3f883fe324.gsc
***********************************************/

init() {
  level._id_56508BBE9D05BC14 = spawnStruct();
  level._id_56508BBE9D05BC14._id_E245624E112BC52F = [];
  level._id_56508BBE9D05BC14._id_37082BC3DA143E9A = [];
  scripts\engine\scriptable::scriptable_addusedcallback(::scriptable_used);
  scripts\engine\scriptable::scriptable_addautousecallback(::scriptable_used);
  level thread _id_AA3C8DC4F487B626();
}

_id_AA3C8DC4F487B626() {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", player);
    player thread _id_86DC7FCF1ACCBCBF(undefined, 0, 0);
  }
}

scriptable_used(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(isDefined(instance) && isDefined(instance.type)) {
    switch (instance.type) {
      case "brloot_rumble_powerup_killmonger":
        player _id_FF5BFED2BFBB47F5("killmonger", instance);
        break;
      case "brloot_rumble_powerup_speed_boost":
        player _id_FF5BFED2BFBB47F5("speed_boost", instance);
        break;
      case "brloot_rumble_powerup_double_points":
        player _id_FF5BFED2BFBB47F5("double_points", instance);
        break;
      case "brloot_rumble_powerup_field_resupply":
        player _id_FF5BFED2BFBB47F5("field_resupply", instance);
        break;
      case "brloot_plunder_cash_uncommon_1":
        if(!isDefined(player._id_D933C184544F70FC) || !player._id_D933C184544F70FC) {
          return;
        }
        _id_223C00A1B0EC6F12 = 5;
        player _id_6AFF3948CF4CCA03::playerplunderpickup(int(_id_223C00A1B0EC6F12));
        break;
    }
  }
}

_id_FF5BFED2BFBB47F5(_id_7F9AB5CBB4C8D107, instance) {
  thread _id_D8FBE43CA106C7CD(_id_7F9AB5CBB4C8D107);
  scripts\cp_mp\calloutmarkerping::_calloutmarkerping_handleluinotify_mappingdeletemarker();
  instance freescriptable();
  thread _id_5B3FA3DC9A41D705();
}

_id_591D2B2DB731B2D7(_id_02FA928445372D72) {
  level._id_56508BBE9D05BC14._id_E245624E112BC52F[_id_02FA928445372D72._id_04CDDC1583171DAE] = _id_02FA928445372D72;
  level._id_56508BBE9D05BC14._id_37082BC3DA143E9A[_id_02FA928445372D72._id_04CDDC1583171DAE] = [];
}

_id_519D44E54A9B8AE5(_id_FC3A2209AC3B57F7) {
  if(!_id_3E5F037AEE9F380D(_id_FC3A2209AC3B57F7)) {
    return;
  }
  return level._id_56508BBE9D05BC14._id_E245624E112BC52F[_id_FC3A2209AC3B57F7];
}

_id_D8FBE43CA106C7CD(_id_FC3A2209AC3B57F7) {
  if(!_id_3E5F037AEE9F380D(_id_FC3A2209AC3B57F7))
    return 0;

  _id_4184E13B4BDDAA85 = 0;
  _id_DF6D91A0D91308F1 = getdvarint("dvar_6A1AAE8562471DB0", 1);

  if(isDefined(self._id_274C3E8981B33B84) && self._id_274C3E8981B33B84.size > 0) {
    foreach(_id_0AE984386F500B3F, _id_E74300DFB04B35EB in self._id_274C3E8981B33B84) {
      if(_id_0AE984386F500B3F == _id_FC3A2209AC3B57F7) {
        _id_4184E13B4BDDAA85 = 1;

        if(isDefined(_id_E74300DFB04B35EB._id_02FA928445372D72._id_115CFFC870AD0973))
          _id_E74300DFB04B35EB[[_id_E74300DFB04B35EB._id_02FA928445372D72._id_115CFFC870AD0973]]();

        continue;
      }

      if(!_id_DF6D91A0D91308F1) {
        if(isDefined(_id_E74300DFB04B35EB._id_02FA928445372D72._id_E910A7513E3AE146))
          _id_E74300DFB04B35EB[[_id_E74300DFB04B35EB._id_02FA928445372D72._id_E910A7513E3AE146]]();
      }
    }
  }

  if(!_id_4184E13B4BDDAA85)
    _id_5C9BA91A7834E067(_id_FC3A2209AC3B57F7);
}

_id_5C9BA91A7834E067(_id_FC3A2209AC3B57F7) {
  instance = _id_C36AA0A6030B03F0(_id_FC3A2209AC3B57F7);
  level._id_56508BBE9D05BC14._id_37082BC3DA143E9A[_id_FC3A2209AC3B57F7] = scripts\engine\utility::array_add(level._id_56508BBE9D05BC14._id_37082BC3DA143E9A[_id_FC3A2209AC3B57F7], self);
  _id_E63BA000DAAFF522 = _id_56F3F159DE0513C0(_id_FC3A2209AC3B57F7);

  if(isDefined(instance._id_02FA928445372D72._id_19C0658A705F4A94))
    thread _id_86DC7FCF1ACCBCBF(int(instance._id_02FA928445372D72._id_19C0658A705F4A94), _id_E63BA000DAAFF522, 1);

  if(isDefined(instance._id_02FA928445372D72._id_2B65725ECD17D33A))
    instance thread[[instance._id_02FA928445372D72._id_2B65725ECD17D33A]]();

  if(isDefined(instance._id_02FA928445372D72._id_19C0658A705F4A94))
    instance thread _id_8DBB4DA338D85F0A();
  else {
    waitframe();
    instance thread _id_0CF2E5099B22F32C();
  }
}

_id_8DBB4DA338D85F0A() {
  level endon("game_ended");
  self endon("death");
  self endon("stop_powerup");
  self.player endon("disconnect");
  thread _id_0F0322D75CB1D584();

  if(isDefined(self._id_02FA928445372D72._id_40243F80136FAB27))
    self thread[[self._id_02FA928445372D72._id_40243F80136FAB27]]();

  while(gettime() < self._id_A7F29930A5DD5069)
    waitframe();

  thread _id_0CF2E5099B22F32C();
}

_id_0F0322D75CB1D584() {
  level endon("game_ended");
  self endon("death");
  self endon("stop_powerup");
  self.player endon("disconnect");
  self.player scripts\engine\utility::waittill_any_3("death", "joined_team", "joined_spectators");
  thread _id_0CF2E5099B22F32C();
}

_id_0CF2E5099B22F32C() {
  self.player endon("disconnect");
  _id_7F9AB5CBB4C8D107 = self._id_02FA928445372D72._id_04CDDC1583171DAE;
  _id_BFE2CFB9F657871E(_id_7F9AB5CBB4C8D107);
  _id_E63BA000DAAFF522 = _id_56F3F159DE0513C0(_id_7F9AB5CBB4C8D107);

  if(isDefined(self._id_02FA928445372D72._id_19C0658A705F4A94))
    self.player thread _id_86DC7FCF1ACCBCBF(undefined, _id_E63BA000DAAFF522, 0);

  if(isDefined(self._id_02FA928445372D72._id_97183CB1A6E6C08B))
    self thread[[self._id_02FA928445372D72._id_97183CB1A6E6C08B]]();

  self notify("stop_powerup");
}

_id_BFE2CFB9F657871E(_id_FC3A2209AC3B57F7) {
  if(!_id_3E5F037AEE9F380D(_id_FC3A2209AC3B57F7))
    return 0;

  _id_8944085B56DB1FB7(self.player);

  if(scripts\engine\utility::array_contains(level._id_56508BBE9D05BC14._id_37082BC3DA143E9A[_id_FC3A2209AC3B57F7], self.player))
    level._id_56508BBE9D05BC14._id_37082BC3DA143E9A[_id_FC3A2209AC3B57F7] = scripts\engine\utility::array_remove(level._id_56508BBE9D05BC14._id_37082BC3DA143E9A[_id_FC3A2209AC3B57F7], self.player);
}

_id_C36AA0A6030B03F0(_id_FC3A2209AC3B57F7) {
  instance = spawnStruct();
  instance._id_02FA928445372D72 = _id_519D44E54A9B8AE5(_id_FC3A2209AC3B57F7);
  instance.player = self;
  instance.team = self.team;
  instance.teamlist = scripts\mp\utility\teams::getteamdata(self.team, "players");
  instance.origin = self.origin;
  instance.angles = self.angles;
  instance._id_8952B3818B53DABD = [];
  instance._id_C0AB1E665D342394 = gettime();

  if(isDefined(instance._id_02FA928445372D72._id_19C0658A705F4A94))
    instance._id_A7F29930A5DD5069 = gettime() + instance._id_02FA928445372D72._id_19C0658A705F4A94 * 1000;

  instance _id_426763A4A146FA7E(instance.player);
  return instance;
}

_id_426763A4A146FA7E(player) {
  if(!isDefined(player._id_274C3E8981B33B84))
    player._id_274C3E8981B33B84 = [];

  player._id_274C3E8981B33B84[self._id_02FA928445372D72._id_04CDDC1583171DAE] = self;
}

_id_8944085B56DB1FB7(player) {
  if(!isDefined(player._id_274C3E8981B33B84) || !isDefined(player._id_274C3E8981B33B84[self._id_02FA928445372D72._id_04CDDC1583171DAE])) {
    return;
  }
  player._id_274C3E8981B33B84[self._id_02FA928445372D72._id_04CDDC1583171DAE] = undefined;
}

_id_0D7E74A5ECEF9957(_id_FC3A2209AC3B57F7) {
  if(scripts\engine\utility::array_contains(level._id_56508BBE9D05BC14._id_37082BC3DA143E9A[_id_FC3A2209AC3B57F7], self))
    return 1;

  return 0;
}

_id_9925A4BF8196071A(_id_FC3A2209AC3B57F7) {
  if(!_id_0D7E74A5ECEF9957(_id_FC3A2209AC3B57F7)) {
    return;
  }
  if(!isDefined(self._id_274C3E8981B33B84)) {
    return;
  }
  return self._id_274C3E8981B33B84[_id_FC3A2209AC3B57F7];
}

_id_3E5F037AEE9F380D(_id_FC3A2209AC3B57F7) {
  _id_74CF794F15A086FF = scripts\engine\utility::array_contains_key(level._id_56508BBE9D05BC14._id_E245624E112BC52F, _id_FC3A2209AC3B57F7);

  if(isDefined(level._id_56508BBE9D05BC14._id_E245624E112BC52F) && _id_74CF794F15A086FF)
    return 1;
  else
    return 0;
}

_id_970B26A88421C531(_id_E9AE765E2C4FE816, team, intvar) {
  _id_FF8BD721AF677C90 = scripts\engine\utility::ter_op(self.team == "axis", "allies", "axis");
  params = undefined;

  if(isDefined(intvar)) {
    params = spawnStruct();
    params.intvar = intvar;
  }

  _id_4002EC156F3B985A = self.team;
  _id_4002EC156F3B985A = scripts\engine\utility::array_remove(_id_4002EC156F3B985A, self);

  foreach(player in _id_4002EC156F3B985A)
  _id_3ACF1C0EBAF602F2::displayplayersplash(player, _id_E9AE765E2C4FE816, params);
}

_id_AD38C0594F257A1D(player, _id_E9AE765E2C4FE816, intvar) {
  params = undefined;

  if(isDefined(intvar)) {
    params = spawnStruct();
    params.intvar = intvar;
  }

  _id_3ACF1C0EBAF602F2::displayplayersplash(player, _id_E9AE765E2C4FE816, params);
}

_id_86DC7FCF1ACCBCBF(_id_583EEF6BF5682C3D, _id_32B519264627395C, _id_7A9538A3CBF0D6E6) {
  _id_EC07F58FB1B4656E = 0;

  if(isDefined(_id_583EEF6BF5682C3D)) {
    if(isfloat(_id_583EEF6BF5682C3D))
      _id_583EEF6BF5682C3D = int(_id_583EEF6BF5682C3D);

    _id_EC07F58FB1B4656E = _id_EC07F58FB1B4656E + _id_583EEF6BF5682C3D * 100;
  }

  if(isDefined(_id_32B519264627395C))
    _id_EC07F58FB1B4656E = _id_EC07F58FB1B4656E + _id_32B519264627395C * 10;

  if(isDefined(_id_7A9538A3CBF0D6E6))
    _id_EC07F58FB1B4656E = _id_EC07F58FB1B4656E + _id_7A9538A3CBF0D6E6;

  _id_A7917DB112D70FE4 = self getclientomnvar("ui_br_bodycount_reward_data");

  if(_id_A7917DB112D70FE4 == _id_EC07F58FB1B4656E && _id_7A9538A3CBF0D6E6 == 2)
    _id_EC07F58FB1B4656E = _id_EC07F58FB1B4656E + 1;

  self setclientomnvar("ui_br_bodycount_reward_data", _id_EC07F58FB1B4656E);
}

_id_92BA9D24DB6AE86D(dropstruct, _id_302E82DA1A1989AD) {
  if(!isDefined(_id_302E82DA1A1989AD))
    _id_302E82DA1A1989AD = 100;

  _id_7AD2FA4AB913AE0E = randomintrange(1, 101);

  if(_id_302E82DA1A1989AD < _id_7AD2FA4AB913AE0E) {
    return;
  }
  _id_7F9AB5CBB4C8D107 = _id_8BFE6434CFCD9099();
  _id_E89A9A6A3475BD0A = "brloot_rumble_powerup_" + _id_7F9AB5CBB4C8D107;

  if(!isent(self) || self isscriptable()) {
    _id_D0E9CE5529FD7B88 = 35;
    _id_CC0BEC21143E13D8 = 75;
    _id_CC0BEC21143E13D8 = _id_CC0BEC21143E13D8 + randomfloatrange(-10, 10);
    _id_0F289334BAA6FC79 = _id_D0E9CE5529FD7B88 + 55 + randomfloatrange(-5, 5);
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, self.origin, self.angles, undefined, _id_CC0BEC21143E13D8, _id_0F289334BAA6FC79);
  } else
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);

  _id_7E52B56769FA7774::spawnpickup(_id_E89A9A6A3475BD0A, _id_CB4FAD49263E20C4, 1, 1);
}

_id_737B794AEBE41175() {
  _id_7F9AB5CBB4C8D107 = _id_8BFE6434CFCD9099();
  _id_E89A9A6A3475BD0A = "brloot_rumble_powerup_" + _id_7F9AB5CBB4C8D107;
  thread _id_D8FBE43CA106C7CD(_id_7F9AB5CBB4C8D107);
}

_id_8BFE6434CFCD9099() {
  _id_999FFA502B2941D8 = [];

  foreach(_id_0AE984386F500B3F, _id_89B65B0BFE09DCB2 in level._id_56508BBE9D05BC14._id_E245624E112BC52F)
  _id_999FFA502B2941D8[_id_999FFA502B2941D8.size] = _id_0AE984386F500B3F;

  _id_999FFA502B2941D8 = scripts\engine\utility::array_randomize(_id_999FFA502B2941D8);
  return _id_999FFA502B2941D8[0];
}

_id_5B3FA3DC9A41D705() {
  if(level.brgametype.name == "rumble" || level.brgametype.name == "rumble_mgl")
    scripts\mp\supers::givesuperpoints(scripts\mp\supers::getsuperpointsneeded());

  if(scripts\mp\utility\killstreak::isjuggernaut()) {
    return;
  }
  if(level.brgametype.name == "rumble" || level.brgametype.name == "rumble_mgl") {
    self.health = self.maxhealth;
    _id_6A5D3BF7A5B7064A::onexitdeathsdoor(1);
    _id_07C40FA80892A721::_id_AC7803D45979135C(self._id_8790C077C95DB752);
    thread _id_B21A25DF2F6B1E43();
  }
}

_id_B21A25DF2F6B1E43() {
  self endon("death_or_disconnect");
  thread scripts\mp\equipment::givescavengerammo();
  thread scripts\mp\equipment::givescavengerammo();
  scripts\mp\weapons::scavengergiveammo(self);
  waitframe();
  scripts\mp\weapons::scavengergiveammo(self);
}

_id_56F3F159DE0513C0(_id_7F9AB5CBB4C8D107) {
  switch (_id_7F9AB5CBB4C8D107) {
    case "double_points":
      return 1;
    case "killmonger":
      return 3;
    case "speed_boost":
      return 4;
  }
}
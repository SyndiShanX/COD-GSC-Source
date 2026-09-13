/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4debcc95581d610d.gsc
***********************************************/

_id_B39A7A6C96A23D5C() {
  _id_D161863D6DA53CCA = [];
  _id_D161863D6DA53CCA["hunk_4561E2A8"] = ::_id_219945B4C8E06D4C;
  _id_D161863D6DA53CCA["hunk_36C02722"] = ::_id_82D2CF0F61370A2E;
  _id_D161863D6DA53CCA["hunk_1FDC6855"] = ::_id_54F8D9A267E5FAFB;
  _id_D161863D6DA53CCA["hunk_7F1669C1"] = ::_id_AE08C9AFDF84D058;
  _id_D161863D6DA53CCA["hunk_C099F700"] = ::_id_9358AEBF97231D0E;
  _id_D161863D6DA53CCA["hunk_44A4E2C8"] = ::_id_AE08C9AFDF84D058;
  _id_D161863D6DA53CCA["hunk_C19A1C84"] = ::_id_887680C3EDD70AB0;
  return _id_D161863D6DA53CCA;
}

_id_219945B4C8E06D4C(_id_B92F1CF567538EEE) {
  return 1;
}

_id_82D2CF0F61370A2E(_id_B92F1CF567538EEE) {
  while(!self _meth_3C6BB30AE7106B7A()) {
    if(self isonground())
      return 0;

    waitframe();
  }

  position = scripts\engine\utility::drop_to_ground(_id_B92F1CF567538EEE._id_B6AC580A2F02C7EB);
  _id_4CB22D8DDA2E06A9 = _id_695A872D7D692EFA::_id_E5524FB8509827BF(position, &"FTUE_MOBILE/GO_HERE", "icon_waypoint_objective_general", 15, self, 1);

  while(!self isonground())
    waitframe();

  _id_695A872D7D692EFA::_id_4D03B9EF456D0972(_id_4CB22D8DDA2E06A9);
  distance = distancesquared(position, self.origin);
  return distance < _id_B92F1CF567538EEE._id_562A413B88E3F653;
}

_id_AE08C9AFDF84D058(_id_B92F1CF567538EEE) {
  _id_E896674142573C95 = 0;

  while(!_id_E896674142573C95) {
    self waittill(_id_B92F1CF567538EEE._id_17CB81B625BD3D4B, damagedata);

    if(_id_376C76DF4DA58945::_id_F1D5801907F9F17D(damagedata.instance)) {
      if(!isDefined(_id_B92F1CF567538EEE._id_7C3011400034B78E) || _id_376C76DF4DA58945::_id_0AE464BCF89AC874(damagedata, _id_B92F1CF567538EEE._id_7C3011400034B78E))
        _id_E896674142573C95 = 1;
    }
  }

  return 1;
}

_id_54F8D9A267E5FAFB(_id_B92F1CF567538EEE) {
  _id_F0A609CF0EFF9B02 = 0;

  while(_id_F0A609CF0EFF9B02 < _id_B92F1CF567538EEE._id_1F7F5E3DB4B22AC8) {
    if(_id_AE08C9AFDF84D058(_id_B92F1CF567538EEE))
      _id_F0A609CF0EFF9B02++;
  }

  return 1;
}

_id_9358AEBF97231D0E(_id_B92F1CF567538EEE) {
  _id_52A1E9C5FDD3076E = 0;
  _id_DE1FCD09DDA392D3 = 0;

  while(!_id_DE1FCD09DDA392D3) {
    level waittill(_id_B92F1CF567538EEE._id_41075454B4246266, _id_1C2D55EC04D979E7);

    if(isDefined(_id_B92F1CF567538EEE._id_CBAFD5721CE50853))
      _id_1C2D55EC04D979E7.instance setscriptablepartstate(_id_1C2D55EC04D979E7.part, _id_B92F1CF567538EEE._id_CBAFD5721CE50853);

    if(isDefined(_id_B92F1CF567538EEE._id_EC174465928B5A3E))
      wait(_id_B92F1CF567538EEE._id_EC174465928B5A3E);

    if(_id_1C2D55EC04D979E7.instance.id == _id_B92F1CF567538EEE._id_94C9CF0D668973F0[_id_52A1E9C5FDD3076E]) {
      _id_52A1E9C5FDD3076E++;

      if(_id_52A1E9C5FDD3076E >= _id_B92F1CF567538EEE._id_94C9CF0D668973F0.size)
        _id_DE1FCD09DDA392D3 = 1;

      continue;
    }

    if(isDefined(_id_B92F1CF567538EEE._id_96A94E85167224F5)) {
      foreach(interactable in _id_B92F1CF567538EEE.interactables)
      interactable setscriptablepartstate(_id_1C2D55EC04D979E7.part, _id_B92F1CF567538EEE._id_96A94E85167224F5);
    }

    _id_52A1E9C5FDD3076E = 0;
  }

  return 1;
}

_id_887680C3EDD70AB0(_id_B92F1CF567538EEE) {
  _id_72388592690A2F9E = gettime();
  _id_3736E8F8A9FBAC1A = _id_B92F1CF567538EEE._id_0B2AA37A799B9FA7 + _id_72388592690A2F9E;

  for(currenttime = _id_72388592690A2F9E; _id_3736E8F8A9FBAC1A > currenttime; currenttime = gettime()) {
    triggerportableradarpingteam(_id_B92F1CF567538EEE._id_5C5B88CE7AE1228E.origin, self.team, _id_B92F1CF567538EEE.radius, _id_B92F1CF567538EEE._id_5888FE9DAC2D7D8E);
    wait(_id_B92F1CF567538EEE._id_047D36EE50AD4738);
  }
}
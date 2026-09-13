/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\code\ai_shooting.gsc
***********************************************/

choosenumshotsandbursts() {
  _id_B22C497B24D57ACA = distancesquared(self.origin, self._blackboard.shootparams_pos);

  if(_id_B22C497B24D57ACA > 160000)
    self._blackboard.shootparams_burstcount = randomintrange(1, 5);
  else
    self._blackboard.shootparams_burstcount = 10;

  switch (self._blackboard.shootparams_style) {
    case "single":
      self._blackboard.shootparams_shotsperburst = 1;
      break;
    case "burst":
      self._blackboard.shootparams_shotsperburst = decidenumshotsforburst(_id_B22C497B24D57ACA);
      break;
    case "semi":
      self._blackboard.shootparams_shotsperburst = decidenumshotsforburst(_id_B22C497B24D57ACA);
      break;
    case "full":
      self._blackboard.shootparams_shotsperburst = decidenumshotsforfull();
      break;
    case "mg":
      self._blackboard.shootparams_shotsperburst = decidenumshotsformg();
      break;
  }
}

decidenumshotsformg() {
  turret = undefined;

  if(isDefined(self.fngetusedturret))
    turret = [[self.fngetusedturret]]();

  usingturret = isDefined(turret);

  if(usingturret && isDefined(turret.script_burst_min))
    _id_1CA111FF86819C24 = turret.script_burst_min;
  else
    _id_1CA111FF86819C24 = 0.5;

  if(usingturret && isDefined(turret.script_burst_max))
    _id_BC2EF30947C2CBD2 = turret.script_burst_max - _id_1CA111FF86819C24;
  else
    _id_BC2EF30947C2CBD2 = 1.5;

  _id_0F9CF7A09079ABEA = _id_1CA111FF86819C24 + randomfloat(_id_BC2EF30947C2CBD2);
  return int(_id_0F9CF7A09079ABEA * 10.0);
}

decidenumshotsforfull() {
  _id_89F949A75D92E1A4 = self.bulletsinclip;
  _id_0DD6BF5F9DBA888C = weaponclass(self.weapon);

  if(weaponclass(self.weapon) == "mg") {
    _id_DC061F521C45D732 = randomfloat(10);

    if(_id_DC061F521C45D732 < 3)
      _id_89F949A75D92E1A4 = randomintrange(2, 6);
    else if(_id_DC061F521C45D732 < 8)
      _id_89F949A75D92E1A4 = randomintrange(6, 12);
    else
      _id_89F949A75D92E1A4 = randomintrange(12, 20);
  }

  return _id_89F949A75D92E1A4;
}

decidenumshotsforburst(_id_B22C497B24D57ACA) {
  _id_D2564E986C0EF171 = 5;
  _id_8BA699667E1A6D48 = weaponburstcount(self.weapon);

  if(_id_8BA699667E1A6D48)
    _id_89F949A75D92E1A4 = _id_8BA699667E1A6D48;
  else {
    _id_89F949A75D92E1A4 = reduceshotcountbydistance(_id_D2564E986C0EF171, _id_B22C497B24D57ACA);
    _id_89F949A75D92E1A4 = _id_89F949A75D92E1A4 + randomintrange(-2, 3);
    _id_89F949A75D92E1A4 = int(max(_id_89F949A75D92E1A4, 1));
  }

  if(_id_89F949A75D92E1A4 <= self.bulletsinclip)
    return _id_89F949A75D92E1A4;

  if(self.bulletsinclip <= 0)
    return 1;

  return self.bulletsinclip;
}

reduceshotcountbydistance(_id_ED80ADB830BC0010, _id_B22C497B24D57ACA) {
  _id_5E2B1CC3ABA6D0EC = 62500;
  _id_613A15ADBE0EFE37 = 810000;
  _id_0E9710B1CECB896F = 1562500;
  _id_5646233813D9B9E6 = 2560000;
  _id_7C6CA70421A9FF30 = [_id_5E2B1CC3ABA6D0EC, _id_613A15ADBE0EFE37, _id_0E9710B1CECB896F, _id_5646233813D9B9E6];

  foreach(_id_F87F8F6ABBFF47F5 in _id_7C6CA70421A9FF30) {
    if(_id_B22C497B24D57ACA > _id_F87F8F6ABBFF47F5)
      _id_ED80ADB830BC0010 = _id_ED80ADB830BC0010 - 1;
  }

  return _id_ED80ADB830BC0010;
}
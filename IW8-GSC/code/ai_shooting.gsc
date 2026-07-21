/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: code\ai_shooting.gsc
***********************************************/

choosenumshotsandbursts() {
  var_0 = distancesquared(self.origin, self._blackboard.shootparams_pos);

  if(var_0 > 160000)
    self._blackboard.shootparams_burstcount = randomintrange(1, 5);
  else
    self._blackboard.shootparams_burstcount = 10;

  switch (self._blackboard.shootparams_style) {
    case "single":
      self._blackboard.shootparams_shotsperburst = 1;
      break;
    case "burst":
      self._blackboard.shootparams_shotsperburst = decidenumshotsforburst(var_0);
      break;
    case "semi":
      self._blackboard.shootparams_shotsperburst = decidenumshotsforburst(var_0);
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
  var_0 = scripts\aitypes\combat::getusedturret();
  var_1 = isDefined(var_0);

  if(var_1 && isDefined(var_0.script_burst_min))
    var_2 = var_0.script_burst_min;
  else
    var_2 = 0.5;

  if(var_1 && isDefined(var_0.script_burst_max))
    var_3 = var_0.script_burst_max - var_2;
  else
    var_3 = 1.5;

  var_4 = var_2 + randomfloat(var_3);
  return int(var_4 * 10.0);
}

decidenumshotsforfull() {
  var_0 = self.bulletsinclip;
  var_1 = weaponclass(self.weapon);

  if(weaponclass(self.weapon) == "mg") {
    var_2 = randomfloat(10);

    if(var_2 < 3)
      var_0 = randomintrange(2, 6);
    else if(var_2 < 8)
      var_0 = randomintrange(6, 12);
    else
      var_0 = randomintrange(12, 20);
  }

  return var_0;
}

decidenumshotsforburst(var_0) {
  var_1 = 5;
  var_2 = weaponburstcount(self.weapon);

  if(var_2)
    var_3 = var_2;
  else {
    var_3 = reduceshotcountbydistance(var_1, var_0);
    var_3 = var_3 + randomintrange(-2, 3);
    var_3 = int(max(var_3, 1));
  }

  if(var_3 <= self.bulletsinclip)
    return var_3;

  if(self.bulletsinclip <= 0)
    return 1;

  return self.bulletsinclip;
}

reduceshotcountbydistance(var_0, var_1) {
  var_2 = 62500;
  var_3 = 810000;
  var_4 = 1562500;
  var_5 = 2560000;
  var_6 = [var_2, var_3, var_4, var_5];

  foreach(var_8 in var_6) {
    if(var_1 > var_8)
      var_0 = var_0 - 1;
  }

  return var_0;
}
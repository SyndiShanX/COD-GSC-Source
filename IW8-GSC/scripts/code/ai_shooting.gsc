/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\code\ai_shooting.gsc
***********************************************/

function choosenumshotsandbursts() {
  var0 = distancesquared(self.origin, self._blackboard.shootparams_pos);

  if(var0 > 160000) {
    self._blackboard.shootparams_burstcount = randomintrange(1, 5);
  } else {
    self._blackboard.shootparams_burstcount = 10;
  }

  switch (self._blackboard.shootparams_style) {
    case "single":
      self._blackboard.shootparams_shotsperburst = 1;
      break;
    case "burst":
      self._blackboard.shootparams_shotsperburst = decidenumshotsforburst(var0);
      break;
    case "semi":
      self._blackboard.shootparams_shotsperburst = decidenumshotsforburst(var0);
      break;
    case "full":
      self._blackboard.shootparams_shotsperburst = decidenumshotsforfull();
      break;
    case "mg":
      self._blackboard.shootparams_shotsperburst = decidenumshotsformg();
      break;
  }
}

function decidenumshotsformg() {
  var0 = scripts\aitypes\combat::getusedturret();
  var1 = isDefined(var0);

  if(var1 && isDefined(var0.script_burst_min)) {
    var2 = var0.script_burst_min;
  } else {
    var2 = 0.5;
  }

  if(var2 && isDefined(var1.script_burst_max)) {
    var3 = var1.script_burst_max - var2;
  } else {
    var3 = 1.5;
  }

  var4 = var3 + randomfloat(var3);
  return int(var4 * 10);
}

function decidenumshotsforfull() {
  var0 = self.bulletsinclip;
  var1 = weaponclass(self.weapon);

  if(weaponclass(self.weapon) == "mg") {
    var2 = randomfloat(10);

    if(var2 < 3) {
      var0 = randomintrange(2, 6);
    } else if(var2 < 8) {
      var0 = randomintrange(6, 12);
    } else {
      var0 = randomintrange(12, 20);
    }
  }

  return var0;
}

function decidenumshotsforburst(var0) {
  var1 = 5;
  var2 = weaponburstcount(self.weapon);

  if(var2) {
    var3 = var2;
  } else {
    var3 = reduceshotcountbydistance(var2, var1);
    var3 += randomintrange(-2, 3);
    var3 = int(max(var3, 1));
  }

  if(var3 <= self.bulletsinclip) {
    return var3;
  }

  if(self.bulletsinclip <= 0) {
    return 1;
  }

  return self.bulletsinclip;
}

function reduceshotcountbydistance(var0, var1) {
  var2 = 62500;
  var3 = 810000;
  var4 = 1562500;
  var5 = 2560000;
  var6 = [var2, var3, var4, var5];

  foreach(var8 in var6) {
    if(var1 > var8) {
      var0 -= 1;
    }
  }

  return var0;
}
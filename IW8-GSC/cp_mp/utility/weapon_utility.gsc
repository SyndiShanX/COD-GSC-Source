/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\utility\weapon_utility.gsc
***********************************************/

_magicbullet(var_0, var_1, var_2, var_3, var_4) {
  var_5 = magicbullet(var_0, var_1, var_2, var_3, var_4);

  if(isDefined(var_5) && isDefined(var_3))
    var_5 setotherent(var_3);

  return var_5;
}

islockonlauncher(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  if(isstring(var_0))
    var_2 = var_0;
  else
    var_2 = var_0.basename;

  switch (var_2) {
    case "_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920":
    case "_encstr_9B69114A571F8EBD17484FBA87220987C71A97":
    case "_encstr_8ABB134AEB113F41C8C180B2C79AB2FF83E7E7E51B":
    case "_encstr_8BD015B08BF0BF888F4F2D835BE311954F72E0A061FD59":
      var_1 = 1;
      break;
    default:
      var_1 = 0;
  }

  return var_1;
}

addlockedon(var_0, var_1) {
  if(!isDefined(var_0.islockedon)) {
    var_0.islockedon = 0;
    var_0.attackerslockedon = [];
  }

  if(var_0.islockedon == 0) {
    if(isDefined(var_0.lockedoncallback))
      var_0 thread[[var_0.lockedoncallback]]();
  }

  if(isDefined(var_1)) {
    var_1.entlockedonto = var_0;
    var_0.attackerslockedon[var_1 getentitynumber()] = var_1;
  }

  var_0.islockedon++;
}

removelockedon(var_0, var_1) {
  if(!isDefined(var_0.islockedon)) {
    return;
  }
  if(var_0.islockedon == 1) {
    if(isDefined(var_0.lockedonremovedcallback))
      var_0 thread[[var_0.lockedonremovedcallback]]();
  }

  if(isDefined(var_1)) {
    if(isDefined(var_1.entlockedonto) && var_1.entlockedonto == var_0)
      var_1.entlockedonto = undefined;

    var_0.attackerslockedon[var_1 getentitynumber()] = undefined;
  }

  var_0.islockedon--;
}

setlockedoncallback(var_0, var_1) {
  var_0.lockedoncallback = var_1;
}

setlockedonremovedcallback(var_0, var_1) {
  var_0.lockedonremovedcallback = var_1;
}

clearlockedon(var_0) {
  var_0 notify("_encstr_8C590E6C8D590BC9317B36DA598CF473");

  if(islockedonto(var_0)) {
    if(isDefined(var_0.lockedonremovedcallback))
      var_0 thread[[var_0.lockedonremovedcallback]]();

    foreach(var_3, var_2 in var_0.attackerslockedon) {
      if(isDefined(var_2)) {
        if(isDefined(var_2.entlockedonto) && var_2.entlockedonto == var_0)
          var_2.entlockedonto = undefined;
      }
    }
  }

  var_0.islockedon = undefined;
  var_0.attackerslockedon = undefined;
  var_0.lockedoncallback = undefined;
  var_0.lockedonremovedcallback = undefined;

  if(hasincoming(var_0)) {
    if(isDefined(var_0.start_firing_minigun))
      var_0 thread[[var_0.start_firing_minigun]]();
  }

  var_0.hasincoming = undefined;
  var_0.start_eye_barkov = undefined;
  var_0.start_firing_minigun = undefined;
}

clearlockedonondisconnect(var_0) {
  if(isDefined(self.entlockedonto))
    removelockedon(self.entlockedonto, self);

  self.entlockedonto = undefined;
}

islockedonto(var_0) {
  return isDefined(var_0.islockedon) && var_0.islockedon > 0;
}

battle_tracks_shouldplaybattletrackswhenstandingonvehicle(var_0) {
  if(!isDefined(var_0.hasincoming))
    var_0.hasincoming = 0;

  if(var_0.hasincoming == 0) {
    if(isDefined(var_0.start_eye_barkov))
      var_0 thread[[var_0.start_eye_barkov]]();
  }

  var_0.hasincoming++;
}

_id_12C07(var_0) {
  if(!isDefined(var_0.hasincoming)) {
    return;
  }
  if(var_0.hasincoming == 1) {
    if(isDefined(var_0.start_firing_minigun))
      var_0 thread[[var_0.start_firing_minigun]]();
  }

  var_0.hasincoming--;
}

_id_13162(var_0, var_1) {
  var_0.start_eye_barkov = var_1;
}

_id_13163(var_0, var_1) {
  var_0.start_firing_minigun = var_1;
}

hasincoming(var_0) {
  return isDefined(var_0.hasincoming) && var_0.hasincoming > 0;
}

watchtargetlockedontobyprojectile(var_0, var_1) {
  var_0 endon("_encstr_8C590E6C8D590BC9317B36DA598CF473");
  addlockedon(var_0);
  battle_tracks_shouldplaybattletrackswhenstandingonvehicle(var_0);
  var_1 scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_9A18221B8DB258E445B09CB3CAD1137B1BD6AC329ECD8E7B212F4193DE532B1BD14BB159");

  if(isDefined(var_0)) {
    removelockedon(var_0);
    _id_12C07(var_0);
  }
}

clearprojectilelockedon(var_0) {
  var_0 notify("_encstr_9A18221B8DB258E445B09CB3CAD1137B1BD6AC329ECD8E7B212F4193DE532B1BD14BB159");
}

dropweaponfordeathlaunch(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = self.angles;

  if(!isDefined(var_2))
    var_2 = 0;

  var_4 = scripts\engine\math::normalize_value(0, 200, var_2);

  if(var_1 == "_encstr_8D200E63B9A7DBC550975D5D99600FAA") {
    var_5 = randomfloatrange(25, 100);
    var_6 = randomfloatrange(75, 175);
    var_7 = scripts\engine\math::factor_value(450, 800, var_4);
    var_8 = scripts\engine\math::factor_value(-1.16667, -0.833333, var_4);
    var_9 = scripts\engine\math::factor_value(0.125, 0.183333, var_4);
  } else if(var_1 == "_encstr_ABC90E77AC5883F6DCBE38A5CD1D7B36") {
    var_5 = randomfloatrange(100, 200);
    var_6 = randomfloatrange(150, 250);
    var_7 = scripts\engine\math::factor_value(950, 1300, var_4);
    var_8 = scripts\engine\math::factor_value(-1.75, -1.25, var_4);
    var_9 = scripts\engine\math::factor_value(0.5625, 0.825, var_4);
  } else {
    var_5 = randomfloatrange(150, 350);
    var_6 = randomfloatrange(150, 250);
    var_7 = scripts\engine\math::factor_value(950, 1300, var_4);
    var_8 = scripts\engine\math::factor_value(-7.0, -5.0, var_4);
    var_9 = scripts\engine\math::factor_value(0.75, 1.1, var_4);
  }

  if(scripts\engine\utility::cointoss())
    var_6 = var_6 * -1;

  if(!isDefined(var_0)) {
    return;
  }
  var_10 = var_0 physics_getentitycenterofmass();

  if(isDefined(var_10))
    var_10 = var_10["_encstr_AC04092555EB696184F1D9"];
  else
    var_10 = var_0.origin;

  var_11 = (0, 0, 0);
  var_11 = var_11 + anglesToForward(var_3) * var_5;
  var_11 = var_11 + anglestoright(var_3) * var_6;
  var_11 = var_11 + anglestoup(var_3) * var_7;
  var_12 = var_0 gettagangles("_encstr_A14F0AE336178944BA076F41", 1);

  if(!isDefined(var_12))
    var_12 = var_0.angles;

  if(scripts\engine\utility::cointoss())
    var_9 = var_9 * -1;

  var_13 = var_10;
  var_13 = var_13 + anglesToForward(var_12) * var_8;
  var_13 = var_13 + anglestoright(var_12) * var_9;
  var_0 physicslaunchserveritem(var_13, var_11);
}

_id_12EB2() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_8A18169BA045FFF37024F7E4CD1FE785B168016318E9B717"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_8A18169BA045FFF37024F7E4CD1FE785B168016318E9B717")]]();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_939A0EC23B2BEB6BF863594958C4C51B"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_939A0EC23B2BEB6BF863594958C4C51B")]]();
}

_id_12CC7(var_0) {
  if(self isalternatemode(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_A58D144BD3C9E18380AE216BF7F91F41F85EF11FC368"))
      var_0 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_A58D144BD3C9E18380AE216BF7F91F41F85EF11FC368")]](var_0);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_A99A17DD18FB41992F39F8B0E28563DF4FBFE75D53C309D117"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_A99A17DD18FB41992F39F8B0E28563DF4FBFE75D53C309D117")]](var_0);

  return var_0;
}

vehicle_clearpreventplayercollisiondamagefortimeafterexit(var_0) {
  var_1 = self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_B4F9102B9FA9487832A70B35430AB6484537", var_0);
  return istrue(var_1);
}

tv_station_boss(var_0) {
  return var_0 == "_encstr_A9FA0E8BE3BF871942571010A378F033" || var_0 == "_encstr_B450138C3B128FDAFE7F6B56712872EF68C3C292B3" || var_0 == "_encstr_9B5414D2BB1CF5DC5B7DD1E4E0B777AC9C13BA4EDCE8" || var_0 == "_encstr_AAA50F2F308ACFA34330BBE0862BEBAB6B" || var_0 == "_encstr_91B913B4EE0EFA589CFA47E4332C6E474CEA9C9B8E";
}

vehicle_ai_script_models(var_0) {
  var_1 = strtok(var_0, "_encstr_BA4C02DF");
  var_2 = var_1.size > 1 && isstartstr(var_1[1], "_encstr_AF0703BB78") || var_1.size > 2 && isstartstr(var_1[2], "_encstr_AF0703BB78");
  var_3 = var_1.size > 0 && var_1[0] == "_encstr_BD0703AF7C";
  return !var_2 && !var_3;
}
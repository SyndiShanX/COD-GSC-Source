/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: anim\utility_common.gsc
***********************************************/

print3dtime(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_0 / 0.05;

  for(var_7 = 0; var_7 < var_6; var_7++)
    wait 0.05;
}

print3drise(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 100.0;
  var_6 = 0;
  var_0 = var_0 + scripts\engine\utility::randomvector(30);

  for(var_7 = 0; var_7 < var_5; var_7++) {
    var_6 = var_6 + 0.5;
    wait 0.05;
  }
}

crossproduct(var_0, var_1) {
  return var_0[0] * var_1[1] - var_0[1] * var_1[0] > 0;
}

safemod(var_0, var_1) {
  var_2 = int(var_0) % var_1;
  var_2 = var_2 + var_1;
  return var_2 % var_1;
}

quadrantanimweights(var_0) {
  var_1 = cos(var_0);
  var_2 = sin(var_0);
  var_3["_encstr_AA5606FD1AF05085"] = 0;
  var_3["_encstr_8253060E2B5FE330"] = 0;
  var_3["_encstr_B69B0589C236B6"] = 0;
  var_3["_encstr_A5AD056A019C63"] = 0;

  if(isDefined(self.alwaysrunforward)) {
    var_3["_encstr_AA5606FD1AF05085"] = 1;
    return var_3;
  }

  if(var_1 > 0) {
    if(var_2 > var_1)
      var_3["_encstr_A5AD056A019C63"] = 1;
    else if(var_2 < -1 * var_1)
      var_3["_encstr_8253060E2B5FE330"] = 1;
    else
      var_3["_encstr_AA5606FD1AF05085"] = 1;
  } else {
    var_4 = -1 * var_1;

    if(var_2 > var_4)
      var_3["_encstr_A5AD056A019C63"] = 1;
    else if(var_2 < var_1)
      var_3["_encstr_8253060E2B5FE330"] = 1;
    else
      var_3["_encstr_B69B0589C236B6"] = 1;
  }

  return var_3;
}

getquadrant(var_0) {
  var_0 = angleclamp(var_0);

  if(var_0 < 45 || var_0 > 315)
    var_1 = "_encstr_AA5606FD1AF05085";
  else if(var_0 < 135)
    var_1 = "_encstr_A5AD056A019C63";
  else if(var_0 < 225)
    var_1 = "_encstr_B69B0589C236B6";
  else
    var_1 = "_encstr_8253060E2B5FE330";

  return var_1;
}

isinset(var_0, var_1) {
  for(var_2 = var_1.size - 1; var_2 >= 0; var_2--) {
    if(var_0 == var_1[var_2])
      return 1;
  }

  return 0;
}

weapon_genade_launcher() {
  return !nullweapon(self.weapon) && weaponclass(self.weapon) == "_encstr_8C8D08671D451291C849";
}

weapon_pump_action_shotgun() {
  return !nullweapon(self.weapon) && weaponisboltaction(self.weapon) && weaponclass(self.weapon) == "_encstr_A1100738A33A638123";
}

isshotgun(var_0) {
  return weaponclass(var_0) == "_encstr_A1100738A33A638123";
}

issniperrifle(var_0) {
  return weaponclass(var_0) == "_encstr_850707F7E5833355B8";
}

isshotgunai() {
  return isshotgun(self.primaryweapon);
}

isasniper(var_0) {
  if(istrue(self.disablesniperbehaviors))
    return 0;

  if(!isDefined(var_0))
    var_0 = 1;

  if(!issniperrifle(self.primaryweapon))
    return 0;

  if(var_0) {
    if(self.primaryweapon != self.weapon)
      return issniperrifle(self.weapon);
  }

  return 1;
}

islongrangeai() {
  return isasniper() || usingrocketlauncher();
}

usingpistol() {
  return weaponclass(self.weapon) == "_encstr_8D940738966ED1DB8D";
}

usingrocketlauncher() {
  return weaponclass(self.weapon) == "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0";
}

usingmg() {
  return weaponclass(self.weapon) == "_encstr_BE0703A54C";
}

isusingshotgun() {
  return weaponclass(self.weapon) == "_encstr_A1100738A33A638123";
}

usingriflelikeweapon() {
  var_0 = weaponclass(self.weapon);

  switch (var_0) {
    case "_encstr_BE1904DCDA9D":
    case "_encstr_850707F7E5833355B8":
    case "_encstr_A1100738A33A638123":
    case "_encstr_BE0703A54C":
    case "_encstr_965306392D3336B2":
      return 1;
  }

  return 0;
}

repeater_headshot_ammo_passive(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !isDefined(var_1) || !isDefined(var_2)) {
    return;
  }
  if(!isPlayer(var_1)) {
    return;
  }
  var_3 = var_0.basename;

  if(!isDefined(var_3) || var_3 != "_encstr_AACF0DD2DD6EFA9C2B1CAC588E9593") {
    return;
  }
  if(!isDefined(var_2.damagelocation)) {
    return;
  }
  if(var_2.damagelocation != "_encstr_81CC0586952C91" && var_2.damagelocation != "_encstr_A6CC076A05751852B3") {
    return;
  }
  var_4 = weaponclipsize(var_0);
  var_5 = var_4 * 1.0;
  var_6 = var_1 getweaponammoclip(var_0);
  var_7 = min(var_6 + var_5, var_4);
  var_1 setweaponammoclip(var_0, int(var_7));
}

needtoreload(var_0) {
  if(nullweapon(self.weapon))
    return 0;

  if(istrue(self.disablereload)) {
    if(self.bulletsinclip < weaponclipsize(self.weapon) * 0.5)
      self.bulletsinclip = int(weaponclipsize(self.weapon) * 0.5);

    if(self.bulletsinclip <= 0)
      self.bulletsinclip = 0;

    return 0;
  }

  if(self.bulletsinclip <= weaponclipsize(self.weapon) * var_0) {
    if(var_0 == 0) {
      if(cheatammoifnecessary())
        return 0;
    }

    return 1;
  }

  return 0;
}

cheatammoifnecessary() {
  if(!isDefined(self.enemy))
    return 0;

  if(self.team != "_encstr_9A8507BA4040188D08") {
    if(!isPlayer(self.enemy))
      return 0;
  }

  if(isusingsidearm() || usingrocketlauncher())
    return 0;

  if(gettime() - self.ammocheattime < self.ammocheatinterval)
    return 0;

  if(!self cansee(self.enemy) && distancesquared(self.origin, self.enemy.origin) > 65536)
    return 0;

  self.bulletsinclip = int(weaponclipsize(self.weapon) / 2);

  if(self.bulletsinclip > weaponclipsize(self.weapon))
    self.bulletsinclip = weaponclipsize(self.weapon);

  self.ammocheattime = gettime();
  return 1;
}

isusingprimary() {
  return self.weapon == self.primaryweapon && !nullweapon(self.weapon);
}

isusingsecondary() {
  return self.weapon == self.secondaryweapon && !nullweapon(self.weapon);
}

isusingsidearm() {
  return self.weapon == self.sidearm && !nullweapon(self.weapon);
}

getclaimednode() {
  return self.node;
}

shootenemywrapper(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  [[anim.shootenemywrapper_func]](var_0);
}

getnodeyawtoorigin(var_0) {
  if(isDefined(self.node))
    var_1 = self.node.angles[1] - scripts\engine\utility::getyaw(var_0);
  else
    var_1 = self.angles[1] - scripts\engine\utility::getyaw(var_0);

  var_1 = angleclamp180(var_1);
  return var_1;
}

getnodeyawtoenemy() {
  var_0 = undefined;

  if(isDefined(self.enemy))
    var_0 = self.enemy.origin;
  else {
    if(isDefined(self.node))
      var_1 = anglesToForward(self.node.angles);
    else
      var_1 = anglesToForward(self.angles);

    var_1 = var_1 * 150;
    var_0 = self.origin + var_1;
  }

  if(isDefined(self.node))
    var_2 = self.node.angles[1] - scripts\engine\utility::getyaw(var_0);
  else
    var_2 = self.angles[1] - scripts\engine\utility::getyaw(var_0);

  var_2 = angleclamp180(var_2);
  return var_2;
}

getyawtoenemy() {
  var_0 = undefined;

  if(isDefined(self.enemy))
    var_0 = self.enemy.origin;
  else {
    var_1 = anglesToForward(self.angles);
    var_1 = var_1 * 150;
    var_0 = self.origin + var_1;
  }

  var_2 = self.angles[1] - scripts\engine\utility::getyaw(var_0);
  var_2 = angleclamp180(var_2);
  return var_2;
}

getyaw2d(var_0) {
  var_1 = vectortoangles((var_0[0], var_0[1], 0) - (self.origin[0], self.origin[1], 0));
  return var_1[1];
}

absyawtoenemy() {
  var_0 = self.angles[1] - scripts\engine\utility::getyaw(self.enemy.origin);
  var_0 = angleclamp180(var_0);

  if(var_0 < 0)
    var_0 = -1 * var_0;

  return var_0;
}

absyawtoenemy2d() {
  var_0 = self.angles[1] - getyaw2d(self.enemy.origin);
  var_0 = angleclamp180(var_0);

  if(var_0 < 0)
    var_0 = -1 * var_0;

  return var_0;
}

absyawtoorigin(var_0) {
  var_1 = self.angles[1] - scripts\engine\utility::getyaw(var_0);
  var_1 = angleclamp180(var_1);

  if(var_1 < 0)
    var_1 = -1 * var_1;

  return var_1;
}

absyawtoangles(var_0) {
  var_1 = self.angles[1] - var_0;
  var_1 = angleclamp180(var_1);

  if(var_1 < 0)
    var_1 = -1 * var_1;

  return var_1;
}

getyawfromorigin(var_0, var_1) {
  var_2 = vectortoangles(var_0 - var_1);
  return var_2[1];
}

getgrenademodel() {
  return getweaponmodel(self.grenadeweapon);
}

getenemyeyepos() {
  if(isDefined(self.enemy)) {
    self.a.lastenemypos = self.enemy getshootatpos();
    self.a.lastenemytime = gettime();
    return self.a.lastenemypos;
  } else if(isDefined(self.a.lastenemytime) && isDefined(self.a.lastenemypos) && self.a.lastenemytime + 3000 < gettime())
    return self.a.lastenemypos;
  else {
    var_0 = self getshootatpos();
    var_0 = var_0 + 196 * self.lookforward;
    return var_0;
  }
}

gettruenodeangles(var_0) {
  if(!isDefined(var_0))
    return (0, 0, 0);

  if(!isDefined(var_0.script_angles))
    return var_0.angles;

  var_1 = var_0.angles;
  var_2 = angleclamp180(var_1[0] + var_0.script_angles[0]);
  var_3 = var_1[1];
  var_4 = angleclamp180(var_1[2] + var_0.script_angles[2]);
  return (var_2, var_3, var_4);
}

getyawtoorigin(var_0) {
  if(isDefined(self.type) && scripts\engine\utility::isnode3d(self)) {
    var_1 = gettruenodeangles(self);
    var_2 = anglesToForward(var_1);
    var_3 = rotatepointaroundvector(var_2, var_0 - self.origin, var_1[2] * -1);
    var_3 = var_3 + self.origin;
    var_4 = scripts\engine\utility::getyaw(var_3) - var_1[1];
    var_4 = angleclamp180(var_4);
    return var_4;
  }

  var_4 = scripts\engine\utility::getyaw(var_0) - self.angles[1];
  var_4 = angleclamp180(var_4);
  return var_4;
}

canseepointfromexposedatcorner(var_0, var_1) {
  var_2 = var_1 getyawtoorigin(var_0);

  if(var_2 > 60 || var_2 < -60)
    return 0;

  if(scripts\engine\utility::isnodecoverleft(var_1) && var_2 < -14)
    return 0;

  if(scripts\engine\utility::isnodecoverright(var_1) && var_2 > 12)
    return 0;

  return 1;
}

getnodeoffset(var_0) {
  if(isDefined(var_0.offset))
    return var_0.offset;

  var_1 = (-26, 0.4, 36);
  var_2 = (-32, 7, 63);
  var_3 = (43.5, 11, 36);
  var_4 = (36, 8.3, 63);
  var_5 = (3.5, -12.5, 45);
  var_6 = (-3.7, -22, 63);
  var_7 = (0, 30, 13);
  var_8 = 0;
  var_9 = (0, 0, 0);
  var_10 = anglestoaxis(var_0.angles);
  var_11 = var_10["_encstr_8253060E2B5FE330"];
  var_12 = var_10["_encstr_B42E085325A82CB3F221"];
  var_13 = var_10["_encstr_87070365F7"];
  var_14 = var_0.type;

  switch (var_14) {
    case "_encstr_A7760B6710A315533959DF17AD":
      var_15 = var_0 gethighestnodestance();

      if(!isDefined(var_15) || var_15 == "_encstr_B13D076BED70539F23")
        var_9 = calculatenodeoffset(var_11, var_12, var_13, var_1);
      else
        var_9 = calculatenodeoffset(var_11, var_12, var_13, var_2);

      break;
    case "_encstr_86A30C90489C3F32B21DA9AF0178":
      var_15 = var_0 gethighestnodestance();

      if(!isDefined(var_15) || var_15 == "_encstr_B13D076BED70539F23")
        var_9 = calculatenodeoffset(var_11, var_12, var_13, var_3);
      else
        var_9 = calculatenodeoffset(var_11, var_12, var_13, var_4);

      break;
    case "_encstr_A7AF0791EF1B06683C":
    case "_encstr_8AD80E1ABD376CCAB0C6086A3A2CB9C8":
    case "_encstr_A9700F9D2D8ED0C60647F9DB9B6A27DA14":
    case "_encstr_AFFF0C6E8FE899DDE6174B068510":
      var_9 = calculatenodeoffset(var_11, var_12, var_13, var_6);
      break;
    case "_encstr_9A520FAD2525079A4E3292270DBF5B7A9C":
    case "_encstr_854714E37F10FF63BFDD9B32636643E641DB764CE7F0":
    case "_encstr_87AB0D4BD7B857DB077503DA9B8EEB":
      var_9 = calculatenodeoffset(var_11, var_12, var_13, var_5);
      break;
    case "_encstr_BEC809853586D8CEFECE81":
      var_9 = getcover3dnodeoffset(var_0);
      break;
    case "_encstr_AF7A0CE15F5EDDE38968D2FF2050":
      var_9 = calculatenodeoffset(var_11, var_12, var_13, var_7);
      break;
  }

  var_0.offset = var_9;
  return var_0.offset;
}

getcover3dnodeoffset(var_0, var_1) {
  var_2 = (2, -10, 35);
  var_3 = (-19, -10, 32);
  var_4 = (16, -10, 32);
  var_5 = anglestoright(var_0.angles);
  var_6 = anglesToForward(var_0.angles);
  var_7 = anglestoup(var_0.angles);
  var_8 = var_2;

  if(isDefined(var_1)) {
    if(var_1 == "_encstr_A5AD056A019C63")
      var_8 = var_3;
    else if(var_1 == "_encstr_8253060E2B5FE330")
      var_8 = var_4;
    else {}
  }

  return calculatenodeoffset(var_5, var_6, var_7, var_8);
}

calculatenodeoffset(var_0, var_1, var_2, var_3) {
  return var_0 * var_3[0] + var_1 * var_3[1] + var_2 * var_3[2];
}

canseepointfromexposedatnode(var_0, var_1) {
  if(scripts\engine\utility::isnodecoverleft(var_1) || scripts\engine\utility::isnodecoverright(var_1)) {
    if(!canseepointfromexposedatcorner(var_0, var_1))
      return 0;
  }

  var_2 = getnodeoffset(var_1);
  var_3 = var_1.origin + var_2;

  if(!checkpitchvisibility(var_3, var_0, var_1))
    return 0;

  if(!sighttracepassed(var_3, var_0, 0, self.enemy)) {
    if(scripts\engine\utility::isnodecovercrouch(var_1)) {
      var_3 = (0, 0, 64) + var_1.origin;
      return sighttracepassed(var_3, var_0, 0, self.enemy);
    }

    return 0;
  }

  return 1;
}

persistentdebugline(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  level notify("_encstr_A35A0DFB8B847A5D2083FF05387865");
  level endon("_encstr_A35A0DFB8B847A5D2083FF05387865");

  for(;;)
    wait 0.05;
}

canseeenemyfromexposed() {
  if(!isDefined(self.enemy))
    return 0;

  var_0 = getenemyeyepos();

  if(!isDefined(self.node))
    var_1 = self cansee(self.enemy);
  else if(scripts\engine\utility::actor_is3d() && scripts\engine\utility::isnode3d(self.node)) {
    var_1 = canseepointfromexposedatnode(var_0, self.node);

    if(!var_1) {
      var_0 = (self.enemy.origin + var_0) / 2;
      var_1 = canseepointfromexposedatnode(var_0, self.node);
    }
  } else
    var_1 = canseepointfromexposedatnode(var_0, self.node);

  if(var_1)
    dontgiveuponsuppressionyet();
  else {}

  return var_1;
}

checkpitchvisibility(var_0, var_1, var_2) {
  var_3 = self.upaimlimit - anim.aimpitchdifftolerance;
  var_4 = self.downaimlimit + anim.aimpitchdifftolerance;
  var_5 = var_1 - var_0;

  if(scripts\engine\utility::actor_is3d()) {
    if(isDefined(var_2) && scripts\engine\utility::isnode3d(var_2))
      var_6 = var_2.angles;
    else
      var_6 = self.angles;

    var_5 = rotatevectorinverted(var_5, var_6);
  }

  var_7 = angleclamp180(vectortopitch(var_5));

  if(var_7 < var_3)
    return 0;

  if(var_7 > var_4) {
    if(isDefined(var_2) && !scripts\engine\utility::isnodecovercrouch(var_2))
      return 0;

    if(var_7 > anim.covercrouchleanpitch + var_4)
      return 0;
  }

  return 1;
}

dontgiveuponsuppressionyet() {
  self.a.shouldresetgiveuponsuppressiontimer = 1;
}

cansuppressenemy() {
  if(!hassuppressableenemy() || self.doingambush) {
    self.goodshootpos = undefined;
    return 0;
  }

  if(!isPlayer(self.enemy))
    return aisuppressai();

  if(!checkpitchvisibility(self getEye(), self.lastenemysightpos))
    return 0;

  var_0 = self getapproxeyepos();
  return findgoodsuppressspot(var_0);
}

updategiveuponsuppressiontimer() {
  if(!isDefined(self.a.shouldresetgiveuponsuppressiontimer))
    self.a.shouldresetgiveuponsuppressiontimer = 1;

  if(self.a.shouldresetgiveuponsuppressiontimer) {
    self.a.giveuponsuppressiontime = gettime() + randomintrange(15000, 30000);
    self.a.shouldresetgiveuponsuppressiontimer = 0;
  }
}

hassuppressableenemy() {
  if(!isDefined(self.enemy))
    return 0;

  if(!isDefined(self.lastenemysightpos))
    return 0;

  if(!istrue(self.dontgiveuponsuppression)) {
    updategiveuponsuppressiontimer();

    if(gettime() > self.a.giveuponsuppressiontime)
      return 0;
  }

  if(!isDefined(self.goodshootpos) && !needrecalculatesuppressspot())
    return 0;

  return 1;
}

aisuppressai() {
  if(!self canattackenemynode() && !istrue(self.forcesuppressai))
    return 0;

  var_0 = undefined;

  if(isDefined(self.enemy.covernode)) {
    var_1 = getnodeoffset(self.enemy.covernode);
    var_0 = self.enemy.covernode.origin + var_1;
  } else
    var_0 = self.enemy getshootatpos();

  if(!self canshoot(var_0) && !istrue(self.forcesuppressai))
    return 0;

  self.goodshootpos = var_0;
  return 1;
}

canseeandshootpoint(var_0) {
  if(isDefined(self.a.weaponpos) && getqueuedspleveltransients(self.a.weaponpos["_encstr_8253060E2B5FE330"]))
    return 0;

  if(!sighttracepassed(self getshootatpos(), var_0, 0, undefined))
    return 0;

  var_1 = self getapproxeyepos();
  return sighttracepassed(var_1, var_0, 0, undefined);
}

needrecalculatesuppressspot() {
  if(isDefined(self.goodshootpos) && !canseeandshootpoint(self.goodshootpos))
    return 1;

  return !isDefined(self.lastenemysightposold) || distancesquared(self.lastenemysightposold, self.lastenemysightpos) > 256 || distancesquared(self.lastenemysightposselforigin, self.origin) > 1024;
}

findgoodsuppressspot(var_0) {
  var_1 = min(self.enemy.maxvisibledist, 1024);

  if(isDefined(self.enemy) && distancesquared(self.origin, self.enemy.origin) > squared(var_1 + 768.0)) {
    self.goodshootpos = undefined;
    return 0;
  }

  if(needrecalculatesuppressspot()) {
    self.lastenemysightposselforigin = self.origin;
    self.lastenemysightposold = self.lastenemysightpos;

    if(istrue(self.suppress_uselastenemysightpos)) {
      self.goodshootpos = self.lastenemysightpos;
      return 1;
    }

    var_2 = getenemyeyepos();
    self.goodshootpos = self scriptabledoorclose(var_0, var_2, self.suppress_numgoodtracesneeded);
    return isDefined(self.goodshootpos);
  } else if(isDefined(self.goodshootpos) && isDefined(self.pathgoalpos) && distancesquared(self.origin, self.goodshootpos) < 1024)
    self.goodshootpos = undefined;

  return isDefined(self.goodshootpos);
}

cansuppressenemyfromexposed() {
  if(self.doingambush)
    return 0;

  if(!hassuppressableenemy())
    return 0;

  if(!isPlayer(self.enemy))
    return aisuppressai();

  if(isDefined(self.node)) {
    if(scripts\engine\utility::isnodecoverleft(self.node) || scripts\engine\utility::isnodecoverright(self.node)) {
      if(!canseepointfromexposedatcorner(getenemyeyepos(), self.node))
        return 0;
    }

    var_0 = getnodeoffset(self.node);
    var_1 = self.node.origin + var_0;
  } else
    var_1 = self getapproxeyepos();

  if(!checkpitchvisibility(var_1, self.lastenemysightpos))
    return 0;

  return findgoodsuppressspot(var_1);
}

canseeenemy(var_0) {
  if(!isDefined(self.enemy))
    return 0;

  if(isDefined(var_0) && self cansee(self.enemy, var_0) || self cansee(self.enemy)) {
    if(!checkpitchvisibility(self getEye(), self.enemy getshootatpos()))
      return 0;

    dontgiveuponsuppressionyet();
    return 1;
  }

  return 0;
}

recentlysawenemy() {
  return isDefined(self.enemy) && self seerecently(self.enemy, 5);
}

issuppressedwrapper() {
  if(isDefined(self.forcesuppression))
    return self.forcesuppression;

  if(self.suppressionmeter <= self.suppressionthreshold)
    return 0;

  return self issuppressed();
}

enemyishiding() {
  if(!isDefined(self.enemy))
    return 0;

  if(self.enemy scripts\engine\utility::isflashed())
    return 1;

  if(isPlayer(self.enemy)) {
    if(isDefined(self.enemy.health) && self.enemy.health < self.enemy.maxhealth)
      return 1;
  } else if(isai(self.enemy) && self.enemy issuppressedwrapper())
    return 1;

  if(isDefined(self.enemy.isreloading) && self.enemy.isreloading)
    return 1;

  return 0;
}

shouldshootenemyent() {
  if(!canseeenemy())
    return 0;

  if(!self canshootenemy())
    return 0;

  return 1;
}

sortandcullanimstructarray(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3.weight <= 0) {
      continue;
    }
    for(var_4 = 0; var_4 < var_1.size; var_4++) {
      if(var_3.weight < var_1[var_4].weight) {
        for(var_5 = var_1.size; var_5 > var_4; var_5--)
          var_1[var_5] = var_1[var_5 - 1];

        break;
      }
    }

    var_1[var_4] = var_3;
  }

  return var_1;
}

player_can_see_ai(var_0, var_1, var_2) {
  var_3 = gettime();

  if(!isDefined(var_2))
    var_2 = 0;

  if(isDefined(var_1.playerseesmetime) && var_1.playerseesmetime + var_2 >= var_3)
    return var_1.playerseesme;

  var_1.playerseesmetime = var_3;

  if(!scripts\engine\utility::within_fov(var_0.origin, var_0.angles, var_1.origin, 0.766)) {
    var_1.playerseesme = 0;
    return 0;
  }

  var_4 = var_0 getEye();
  var_5 = var_1.origin;

  if(sighttracepassed(var_4, var_5, 1, var_0, var_1)) {
    var_1.playerseesme = 1;
    return 1;
  }

  var_6 = var_1 getapproxeyepos();

  if(sighttracepassed(var_4, var_6, 1, var_0, var_1)) {
    var_1.playerseesme = 1;
    return 1;
  }

  var_7 = (var_6 + var_5) * 0.5;

  if(sighttracepassed(var_4, var_7, 1, var_0, var_1)) {
    var_1.playerseesme = 1;
    return 1;
  }

  var_1.playerseesme = 0;
  return 0;
}
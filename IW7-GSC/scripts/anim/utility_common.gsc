/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\utility_common.gsc
*********************************************/

print3dtime(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_0 / 0.05;
  for(var_7 = 0; var_7 < var_6; var_7++) {
    wait(0.05);
  }
}

print3drise(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 100;
  var_6 = 0;
  var_0 = var_0 + scripts\engine\utility::randomvector(30);
  for(var_7 = 0; var_7 < var_5; var_7++) {
    var_6 = var_6 + 0.5;
    wait(0.05);
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
  var_3["front"] = 0;
  var_3["right"] = 0;
  var_3["back"] = 0;
  var_3["left"] = 0;
  if(isDefined(self.alwaysrunforward)) {
    var_3["front"] = 1;
    return var_3;
  }

  if(var_1 > 0) {
    if(var_2 > var_1) {
      var_3["left"] = 1;
    } else if(var_2 < -1 * var_1) {
      var_3["right"] = 1;
    } else {
      var_3["front"] = 1;
    }
  } else {
    var_4 = -1 * var_1;
    if(var_2 > var_4) {
      var_3["left"] = 1;
    } else if(var_2 < var_1) {
      var_3["right"] = 1;
    } else {
      var_3["back"] = 1;
    }
  }

  return var_3;
}

getquadrant(var_0) {
  var_0 = angleclamp(var_0);
  if(var_0 < 45 || var_0 > 315) {
    var_1 = "front";
  } else if(var_1 < 135) {
    var_1 = "left";
  } else if(var_1 < 225) {
    var_1 = "back";
  } else {
    var_1 = "right";
  }

  return var_1;
}

isinset(var_0, var_1) {
  for(var_2 = var_1.size - 1; var_2 >= 0; var_2--) {
    if(var_0 == var_1[var_2]) {
      return 1;
    }
  }

  return 0;
}

weapon_pump_action_shotgun() {
  return self.weapon != "none" && weaponisboltaction(self.weapon) && weaponclass(self.weapon) == "spread";
}

isshotgun(var_0) {
  return weaponclass(var_0) == "spread";
}

issniperrifle(var_0) {
  return weaponclass(var_0) == "sniper";
}

isshotgunai() {
  return isshotgun(self.primaryweapon);
}

isasniper(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(!issniperrifle(self.primaryweapon)) {
    return 0;
  }

  if(var_0) {
    if(self.primaryweapon != self.weapon) {
      return issniperrifle(self.weapon);
    }
  }

  return 1;
}

islongrangeai() {
  return isasniper() || usingrocketlauncher();
}

usingpistol() {
  return weaponclass(self.weapon) == "pistol";
}

usingrocketlauncher() {
  return weaponclass(self.weapon) == "rocketlauncher";
}

usingmg() {
  return weaponclass(self.weapon) == "mg";
}

isusingshotgun() {
  return weaponclass(self.weapon) == "spread";
}

usingriflelikeweapon() {
  var_0 = weaponclass(self.weapon);
  switch (var_0) {
    case "sniper":
    case "mg":
    case "smg":
    case "rifle":
    case "spread":
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

  var_3 = getweaponbasename(var_0);
  if(!isDefined(var_3) || var_3 != "iw7_repeater") {
    return;
  }

  if(!isDefined(var_2.var_DD)) {
    return;
  }

  if(var_2.var_DD != "head" && var_2.var_DD != "helmet") {
    return;
  }

  var_4 = weaponclipsize(var_0);
  var_5 = var_4 * 1;
  var_6 = var_1 getweaponammoclip(var_0);
  var_7 = min(var_6 + var_5, var_4);
  var_1 setweaponammoclip(var_0, int(var_7));
}

needtoreload(var_0) {
  if(self.weapon == "none") {
    return 0;
  }

  if(isDefined(self.var_C08B)) {
    if(self.bulletsinclip < weaponclipsize(self.weapon) * 0.5) {
      self.bulletsinclip = int(weaponclipsize(self.weapon) * 0.5);
    }

    if(self.bulletsinclip <= 0) {
      self.bulletsinclip = 0;
    }

    return 0;
  }

  if(self.bulletsinclip <= weaponclipsize(self.weapon) * var_0) {
    if(var_0 == 0) {
      if(cheatammoifnecessary()) {
        return 0;
      }
    }

    return 1;
  }

  return 0;
}

cheatammoifnecessary() {
  if(!isDefined(self.enemy)) {
    return 0;
  }

  if(self.team != "allies") {
    if(!isPlayer(self.enemy)) {
      return 0;
    }
  }

  if(isusingsidearm() || usingrocketlauncher()) {
    return 0;
  }

  if(gettime() - self.ammocheattime < self.ammocheatinterval) {
    return 0;
  }

  if(!self cansee(self.enemy) && distancesquared(self.origin, self.enemy.origin) > 65536) {
    return 0;
  }

  self.bulletsinclip = int(weaponclipsize(self.weapon) / 2);
  if(self.bulletsinclip > weaponclipsize(self.weapon)) {
    self.bulletsinclip = weaponclipsize(self.weapon);
  }

  self.ammocheattime = gettime();
  return 1;
}

isusingprimary() {
  return self.weapon == self.primaryweapon && self.weapon != "none";
}

isusingsecondary() {
  return self.weapon == self.secondaryweapon && self.weapon != "none";
}

isusingsidearm() {
  if(!isDefined(self.var_101B4)) {
    return 0;
  }

  return self.weapon == self.var_101B4 && self.weapon != "none";
}

func_7E28() {
  var_0 = self.node;
  if(isDefined(var_0) && self getweaponassetfromrootweapon(var_0) || isDefined(self.covernode) && var_0 == self.covernode) {
    return var_0;
  }

  return undefined;
}

func_7FFE() {
  var_0 = func_7E28();
  if(isDefined(var_0)) {
    return var_0.type;
  }

  return "none";
}

getnodedirection() {
  var_0 = func_7E28();
  if(isDefined(var_0)) {
    return var_0.angles[1];
  }

  return self.desiredangle;
}

getnodeforward() {
  var_0 = func_7E28();
  if(isDefined(var_0)) {
    return anglesToForward(var_0.angles);
  }

  return anglesToForward(self.angles);
}

func_7FFD() {
  var_0 = func_7E28();
  if(isDefined(var_0)) {
    return var_0.origin;
  }

  return self.origin;
}

shootenemywrapper(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  [[level.shootenemywrapper_func]](var_0);
}

getnodeyawtoorigin(var_0) {
  if(isDefined(self.node)) {
    var_1 = self.node.angles[1] - scripts\engine\utility::getyaw(var_0);
  } else {
    var_1 = self.angles[1] - scripts\engine\utility::getyaw(var_1);
  }

  var_1 = angleclamp180(var_1);
  return var_1;
}

getnodeyawtoenemy() {
  var_0 = undefined;
  if(isDefined(self.enemy)) {
    var_0 = self.enemy.origin;
  } else {
    if(isDefined(self.node)) {
      var_1 = anglesToForward(self.node.angles);
    } else {
      var_1 = anglesToForward(self.angles);
    }

    var_1 = var_1 * 150;
    var_0 = self.origin + var_1;
  }

  if(isDefined(self.node)) {
    var_2 = self.node.angles[1] - scripts\engine\utility::getyaw(var_0);
  } else {
    var_2 = self.angles[1] - scripts\engine\utility::getyaw(var_2);
  }

  var_2 = angleclamp180(var_2);
  return var_2;
}

getyawtoenemy() {
  var_0 = undefined;
  if(isDefined(self.enemy)) {
    var_0 = self.enemy.origin;
  } else {
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
  if(var_0 < 0) {
    var_0 = -1 * var_0;
  }

  return var_0;
}

absyawtoenemy2d() {
  var_0 = self.angles[1] - getyaw2d(self.enemy.origin);
  var_0 = angleclamp180(var_0);
  if(var_0 < 0) {
    var_0 = -1 * var_0;
  }

  return var_0;
}

absyawtoorigin(var_0) {
  var_1 = self.angles[1] - scripts\engine\utility::getyaw(var_0);
  var_1 = angleclamp180(var_1);
  if(var_1 < 0) {
    var_1 = -1 * var_1;
  }

  return var_1;
}

absyawtoangles(var_0) {
  var_1 = self.angles[1] - var_0;
  var_1 = angleclamp180(var_1);
  if(var_1 < 0) {
    var_1 = -1 * var_1;
  }

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
  }

  if(isDefined(self.a.lastenemytime) && isDefined(self.a.lastenemypos) && self.a.lastenemytime + 3000 < gettime()) {
    return self.a.lastenemypos;
  }

  var_0 = self getshootatpos();
  var_0 = var_0 + (196 * self.lookforward[0], 196 * self.lookforward[1], 196 * self.lookforward[2]);
  return var_0;
}

gettruenodeangles(var_0) {
  if(!isDefined(var_0)) {
    return (0, 0, 0);
  }

  if(!isDefined(var_0.script_angles)) {
    return var_0.angles;
  }

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

  var_4 = scripts\engine\utility::getyaw(var_4) - self.angles[1];
  var_4 = angleclamp180(var_4);
  return var_4;
}

canseepointfromexposedatcorner(var_0, var_1) {
  var_2 = var_1 getyawtoorigin(var_0);
  if(var_2 > 60 || var_2 < -60) {
    return 0;
  }

  if(scripts\engine\utility::isnodecoverleft(var_1) && var_2 < -14) {
    return 0;
  }

  if(scripts\engine\utility::isnodecoverright(var_1) && var_2 > 12) {
    return 0;
  }

  return 1;
}

getnodeoffset(var_0) {
  if(isDefined(var_0.offset)) {
    return var_0.offset;
  }

  var_1 = (-26, 0.4, 36);
  var_2 = (-32, 7, 63);
  var_3 = (43.5, 11, 36);
  var_4 = (36, 8.3, 63);
  var_5 = (3.5, -12.5, 45);
  var_6 = (-3.7, -22, 63);
  var_7 = 0;
  var_8 = (0, 0, 0);
  var_9 = anglestoright(var_0.angles);
  var_10 = anglesToForward(var_0.angles);
  var_11 = anglestoup(var_0.angles);
  var_12 = var_0.type;
  switch (var_12) {
    case "Cover Left":
      if(var_0 gethighestnodestance() == "crouch") {
        var_8 = calculatenodeoffset(var_9, var_10, var_11, var_1);
      } else {
        var_8 = calculatenodeoffset(var_9, var_10, var_11, var_2);
      }
      break;

    case "Cover Right":
      if(var_0 gethighestnodestance() == "crouch") {
        var_8 = calculatenodeoffset(var_9, var_10, var_11, var_3);
      } else {
        var_8 = calculatenodeoffset(var_9, var_10, var_11, var_4);
      }
      break;

    case "Cover Stand":
    case "Conceal Stand":
    case "Turret":
    case "Cover Stand 3D":
      var_8 = calculatenodeoffset(var_9, var_10, var_11, var_6);
      break;

    case "Conceal Crouch":
    case "Cover Crouch Window":
    case "Cover Crouch":
      var_8 = calculatenodeoffset(var_9, var_10, var_11, var_5);
      break;

    case "Cover 3D":
      var_8 = getcover3dnodeoffset(var_0);
      break;
  }

  var_0.offset = var_8;
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
    if(var_1 == "left") {
      var_8 = var_3;
    } else if(var_1 == "right") {
      var_8 = var_4;
    }
  }

  return calculatenodeoffset(var_5, var_6, var_7, var_8);
}

calculatenodeoffset(var_0, var_1, var_2, var_3) {
  return var_0 * var_3[0] + var_1 * var_3[1] + var_2 * var_3[2];
}

canseepointfromexposedatnode(var_0, var_1) {
  if(scripts\engine\utility::isnodecoverleft(var_1) || scripts\engine\utility::isnodecoverright(var_1)) {
    if(!canseepointfromexposedatcorner(var_0, var_1)) {
      return 0;
    }
  }

  var_2 = getnodeoffset(var_1);
  var_3 = var_1.origin + var_2;
  if(!checkpitchvisibility(var_3, var_0, var_1)) {
    return 0;
  }

  if(!sighttracepassed(var_3, var_0, 0, undefined)) {
    if(scripts\engine\utility::isnodecovercrouch(var_1)) {
      var_3 = (0, 0, 64) + var_1.origin;
      return sighttracepassed(var_3, var_0, 0, undefined);
    }

    return 0;
  }

  return 1;
}

persistentdebugline(var_0, var_1) {
  self endon("death");
  level notify("newdebugline");
  level endon("newdebugline");
  wait(0.05);
}

canseeenemyfromexposed() {
  if(!isDefined(self.enemy)) {
    self.goodshootpos = undefined;
    return 0;
  }

  var_0 = getenemyeyepos();
  if(!isDefined(self.node)) {
    var_1 = self cansee(self.enemy);
  } else if(scripts\engine\utility::actor_is3d() && scripts\engine\utility::isnode3d(self.node)) {
    var_1 = canseepointfromexposedatnode(var_1, self.node);
    if(!var_1) {
      var_0 = self.enemy.origin + var_0 / 2;
      var_1 = canseepointfromexposedatnode(var_0, self.node);
    }
  } else {
    var_1 = canseepointfromexposedatnode(var_1, self.node);
  }

  if(var_1) {
    self.goodshootpos = var_0;
    dontgiveuponsuppressionyet();
  }

  return var_1;
}

checkpitchvisibility(var_0, var_1, var_2) {
  var_3 = self.upaimlimit - level.var_1A44;
  var_4 = self.downaimlimit + level.var_1A44;
  var_5 = var_1 - var_0;
  if(scripts\engine\utility::actor_is3d()) {
    if(isDefined(var_2) && scripts\engine\utility::isnode3d(var_2)) {
      var_6 = var_2.angles;
    } else {
      var_6 = self.angles;
    }

    var_5 = rotatevectorinverted(var_5, var_6);
  }

  var_7 = angleclamp180(vectortoangles(var_5)[0]);
  if(var_7 < var_3) {
    return 0;
  }

  if(var_7 > var_4) {
    if(isDefined(var_2) && !scripts\engine\utility::isnodecovercrouch(var_2)) {
      return 0;
    }

    if(var_7 > level.covercrouchleanpitch + var_4) {
      return 0;
    }
  }

  return 1;
}

dontgiveuponsuppressionyet() {
  self.a.shouldresetgiveuponsuppressiontimer = 1;
}

cansuppressenemy() {
  if(!hassuppressableenemy()) {
    self.goodshootpos = undefined;
    return 0;
  }

  if(!isPlayer(self.enemy)) {
    return aisuppressai();
  }

  var_0 = self getmuzzlepos();
  if(!checkpitchvisibility(var_0, self.lastenemysightpos)) {
    return 0;
  }

  return findgoodsuppressspot(var_0);
}

updategiveuponsuppressiontimer() {
  if(!isDefined(self.a.shouldresetgiveuponsuppressiontimer)) {
    self.a.shouldresetgiveuponsuppressiontimer = 1;
  }

  if(self.a.shouldresetgiveuponsuppressiontimer) {
    self.a.giveuponsuppressiontime = gettime() + randomintrange(15000, 30000);
    self.a.shouldresetgiveuponsuppressiontimer = 0;
  }
}

hassuppressableenemy() {
  if(!isDefined(self.enemy)) {
    return 0;
  }

  if(!isDefined(self.lastenemysightpos)) {
    return 0;
  }

  updategiveuponsuppressiontimer();
  if(gettime() > self.a.giveuponsuppressiontime) {
    return 0;
  }

  if(!isDefined(self.goodshootpos) && !needrecalculatesuppressspot()) {
    return 0;
  }

  return 1;
}

aisuppressai() {
  if(!self canattackenemynode()) {
    return 0;
  }

  var_0 = undefined;
  if(isDefined(self.enemy.node)) {
    var_1 = getnodeoffset(self.enemy.node);
    var_0 = self.enemy.node.origin + var_1;
  } else {
    var_0 = self.enemy getshootatpos();
  }

  if(!self canshoot(var_0)) {
    return 0;
  }

  if(self.script == "combat") {
    if(!sighttracepassed(self getEye(), self getmuzzlepos(), 0, undefined)) {
      return 0;
    }
  }

  self.goodshootpos = var_0;
  return 1;
}

canseeandshootpoint(var_0) {
  if(!sighttracepassed(self getshootatpos(), var_0, 0, undefined)) {
    return 0;
  }

  if(self.a.weaponpos["right"] == "none") {
    return 0;
  }

  var_1 = self getmuzzlepos();
  return sighttracepassed(var_1, var_0, 0, undefined);
}

needrecalculatesuppressspot() {
  if(isDefined(self.goodshootpos) && !canseeandshootpoint(self.goodshootpos)) {
    return 1;
  }

  return !isDefined(self.lastenemysightposold) || self.lastenemysightposold != self.lastenemysightpos || distancesquared(self.lastenemysightposselforigin, self.origin) > 1024;
}

findgoodsuppressspot(var_0) {
  if(isDefined(self.enemy) && distancesquared(self.origin, self.enemy.origin) > squared(self.enemy.maxvisibledist)) {
    self.goodshootpos = undefined;
    return 0;
  }

  if(!sighttracepassed(self getshootatpos(), var_0, 0, undefined)) {
    self.goodshootpos = undefined;
    return 0;
  }

  if(needrecalculatesuppressspot()) {
    self.lastenemysightposselforigin = self.origin;
    self.lastenemysightposold = self.lastenemysightpos;
    var_1 = getenemyeyepos();
    var_2 = bulletTrace(self.lastenemysightpos, var_1, 0, undefined);
    var_3 = var_2["position"];
    var_4 = self.lastenemysightpos - var_3;
    var_5 = vectornormalize(self.lastenemysightpos - var_0);
    var_4 = var_4 - var_5 * vectordot(var_4, var_5);
    var_6 = 20;
    var_7 = int(length(var_4) / var_6 + 0.5);
    if(var_7 < 1) {
      var_7 = 1;
    }

    if(var_7 > 4) {
      var_7 = 4;
    }

    var_8 = self.lastenemysightpos - var_3;
    var_8 = (var_8[0] / var_7, var_8[1] / var_7, var_8[2] / var_7);
    var_7++;
    var_9 = var_3;
    self.goodshootpos = undefined;
    var_10 = 0;
    var_11 = 2;
    for(var_12 = 0; var_12 < var_7 + var_11; var_12++) {
      var_13 = sighttracepassed(var_0, var_9, 0, undefined);
      var_14 = var_9;
      if(var_12 == var_7 - 1) {
        var_8 = var_8 - var_5 * vectordot(var_8, var_5);
      }

      var_9 = var_9 + var_8;
      if(var_13) {
        var_10++;
        self.goodshootpos = var_14;
        if(var_12 > 0 && var_10 < var_11 && var_12 < var_7 + var_11 - 1) {
          continue;
        }

        return 1;
      } else {
        var_10 = 0;
      }
    }
  }

  return isDefined(self.goodshootpos);
}

cansuppressenemyfromexposed() {
  if(!hassuppressableenemy()) {
    self.goodshootpos = undefined;
    return 0;
  }

  if(!isPlayer(self.enemy)) {
    return aisuppressai();
  }

  if(isDefined(self.node)) {
    if(scripts\engine\utility::isnodecoverleft(self.node) || scripts\engine\utility::isnodecoverright(self.node)) {
      if(!canseepointfromexposedatcorner(getenemyeyepos(), self.node)) {
        return 0;
      }
    }

    var_0 = getnodeoffset(self.node);
    var_1 = self.node.origin + var_0;
  } else {
    var_1 = self getmuzzlepos();
  }

  if(!checkpitchvisibility(var_1, self.lastenemysightpos)) {
    return 0;
  }

  return findgoodsuppressspot(var_1);
}

canseeenemy(var_0) {
  if(!isDefined(self.enemy)) {
    return 0;
  }

  if((isDefined(var_0) && self cansee(self.enemy, var_0)) || self cansee(self.enemy)) {
    if(!checkpitchvisibility(self getEye(), self.enemy getshootatpos())) {
      return 0;
    }

    self.goodshootpos = getenemyeyepos();
    dontgiveuponsuppressionyet();
    return 1;
  }

  return 0;
}

recentlysawenemy() {
  return isDefined(self.enemy) && self seerecently(self.enemy, 5);
}

issuppressedwrapper() {
  if(isDefined(self.forcesuppression)) {
    return self.forcesuppression;
  }

  if(self.suppressionmeter <= self.suppressionthreshold) {
    return 0;
  }

  return self issuppressed();
}

enemyishiding() {
  if(!isDefined(self.enemy)) {
    return 0;
  }

  if(self.enemy scripts\engine\utility::isflashed()) {
    return 1;
  }

  if(isPlayer(self.enemy)) {
    if(isDefined(self.enemy.health) && self.enemy.health < self.enemy.maxhealth) {
      return 1;
    }
  } else if(isai(self.enemy) && self.enemy issuppressedwrapper()) {
    return 1;
  }

  if(isDefined(self.enemy.isreloading) && self.enemy.isreloading) {
    return 1;
  }

  return 0;
}

shouldshootenemyent() {
  if(!canseeenemy()) {
    return 0;
  }

  if(!isDefined(self.covernode) && !self canshootenemy()) {
    return 0;
  }

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
        for(var_5 = var_1.size; var_5 > var_4; var_5--) {
          var_1[var_5] = var_1[var_5 - 1];
        }

        break;
      }
    }

    var_1[var_4] = var_3;
  }

  return var_1;
}
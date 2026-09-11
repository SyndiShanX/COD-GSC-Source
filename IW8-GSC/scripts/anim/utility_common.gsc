/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\utility_common.gsc
***********************************************/

function print3dtime(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_0 / 0.05;

  for(var_7 = 0; var_7 < var_6; var_7++) {
    wait 0.05;
  }
}

function print3drise(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 100;
  var_6 = 0;
  var_0 += scripts\engine\utility::randomvector(30);

  for(var_7 = 0; var_7 < var_5; var_7++) {
    var_6 += 0.5;
    wait 0.05;
  }
}

function crossproduct(var_0, var_1) {
  return var_0[0] * var_1[1] - var_0[1] * var_1[0] > 0;
}

function safemod(var_0, var_1) {
  var_2 = int(var_0) % var_1;
  var_2 += var_1;
  return var_2 % var_1;
}

function quadrantanimweights(var_0) {
  var_1 = cos(var_0);
  var_2 = sin(var_0);
  GscBinSkip1(0x45, "front", 0);
}

function getquadrant(var_0) {
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

function isinset(var_0, var_1) {
  for(var_2 = var_1.size - 1; var_2 >= 0; var_2--) {
    if(var_0 == var_1[var_2]) {
      return true;
    }
  }

  return false;
}

function weapon_genade_launcher() {
  return !nullweapon(self.weapon) && weaponclass(self.weapon) == "grenade";
}

function weapon_pump_action_shotgun() {
  return !nullweapon(self.weapon) && weaponisboltaction(self.weapon) && weaponclass(self.weapon) == "spread";
}

function isshotgun(var_0) {
  return weaponclass(var_0) == "spread";
}

function issniperrifle(var_0) {
  return weaponclass(var_0) == "sniper";
}

function isshotgunai() {
  return isshotgun(self.primaryweapon);
}

function isasniper(var_0) {
  if(istrue(self.disablesniperbehaviors)) {
    return false;
  }

  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(!issniperrifle(self.primaryweapon)) {
    return false;
  }

  if(var_0) {
    if(self.primaryweapon != self.weapon) {
      return issniperrifle(self.weapon);
    }
  }

  return true;
}

function islongrangeai() {
  return isasniper() || usingrocketlauncher();
}

function usingpistol() {
  return weaponclass(self.weapon) == "pistol";
}

function usingrocketlauncher() {
  return weaponclass(self.weapon) == "rocketlauncher";
}

function usingmg() {
  return weaponclass(self.weapon) == "mg";
}

function isusingshotgun() {
  return weaponclass(self.weapon) == "spread";
}

function usingriflelikeweapon() {
  var_0 = weaponclass(self.weapon);

  switch (var_0) {
    case "smg":
    case "sniper":
    case "spread":
    case "mg":
    case "rifle":
      return true;
  }

  return false;
}

function repeater_headshot_ammo_passive(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !isDefined(var_1) || !isDefined(var_2)) {
    return;
  }

  if(!isPlayer(var_1)) {
    return;
  }

  var_3 = var_0.basename;

  if(!isDefined(var_3) || var_3 != "iw7_repeater") {
    return;
  }

  if(!isDefined(var_2.damagelocation)) {
    return;
  }

  if(var_2.damagelocation != "head" && var_2.damagelocation != "helmet") {
    return;
  }

  var_4 = weaponclipsize(var_0);
  var_5 = var_4 * 1;
  var_6 = var_1 getweaponammoclip(var_0);
  var_7 = min(var_6 + var_5, var_4);
  var_1 setweaponammoclip(var_0, int(var_7));
}

function needtoreload(var_0) {
  if(nullweapon(self.weapon)) {
    return false;
  }

  if(istrue(self.disablereload)) {
    if(self.bulletsinclip < weaponclipsize(self.weapon) * 0.5) {
      self.bulletsinclip = int(weaponclipsize(self.weapon) * 0.5);
    }

    if(self.bulletsinclip <= 0) {
      self.bulletsinclip = 0;
    }

    return false;
  }

  if(self.bulletsinclip <= weaponclipsize(self.weapon) * var_0) {
    if(var_0 == 0) {
      if(cheatammoifnecessary()) {
        return false;
      }
    }

    return true;
  }

  return false;
}

function cheatammoifnecessary() {
  if(!isDefined(self.enemy)) {
    return false;
  }

  if(self.team != "allies") {
    if(!isPlayer(self.enemy)) {
      return false;
    }
  }

  if(isusingsidearm() || usingrocketlauncher()) {
    return false;
  }

  if(gettime() - self.ammocheattime < self.ammocheatinterval) {
    return false;
  }

  if(!self cansee(self.enemy) && distancesquared(self.origin, self.enemy.origin) > 65536) {
    return false;
  }

  self.bulletsinclip = int(weaponclipsize(self.weapon) / 2);

  if(self.bulletsinclip > weaponclipsize(self.weapon)) {
    self.bulletsinclip = weaponclipsize(self.weapon);
  }

  self.ammocheattime = gettime();
  return true;
}

function isusingprimary() {
  return self.weapon == self.primaryweapon && !nullweapon(self.weapon);
}

function isusingsecondary() {
  return self.weapon == self.secondaryweapon && !nullweapon(self.weapon);
}

function isusingsidearm() {
  return self.weapon == self.sidearm && !nullweapon(self.weapon);
}

function getclaimednode() {
  return self.node;
}

function shootenemywrapper(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  [[anim.shootenemywrapper_func]](var_0);
}

function getnodeyawtoorigin(var_0) {
  if(isDefined(self.node)) {
    var_1 = self.node.angles[1] - scripts\engine\utility::getyaw(var_0);
  } else {
    var_1 = self.angles[1] - scripts\engine\utility::getyaw(var_1);
  }

  var_1 = angleclamp180(var_1);
  return var_1;
}

function getnodeyawtoenemy() {
  var_0 = undefined;

  if(isDefined(self.enemy)) {
    var_0 = self.enemy.origin;
  } else {
    if(isDefined(self.node)) {
      var_1 = anglesToForward(self.node.angles);
    } else {
      var_1 = anglesToForward(self.angles);
    }

    var_1 *= 150;
    var_1 = self.origin + var_1;
  }

  if(isDefined(self.node)) {
    var_2 = self.node.angles[1] - scripts\engine\utility::getyaw(var_1);
  } else {
    var_2 = self.angles[1] - scripts\engine\utility::getyaw(var_2);
  }

  var_2 = angleclamp180(var_2);
  return var_2;
}

function getyawtoenemy() {
  var_0 = undefined;

  if(isDefined(self.enemy)) {
    var_0 = self.enemy.origin;
  } else {
    var_1 = anglesToForward(self.angles);
    var_1 *= 150;
    var_0 = self.origin + var_1;
  }

  var_2 = self.angles[1] - scripts\engine\utility::getyaw(var_0);
  var_2 = angleclamp180(var_2);
  return var_2;
}

function getyaw2d(var_0) {
  var_1 = vectortoangles((var_0[0], var_0[1], 0) - (self.origin[0], self.origin[1], 0));
  return var_1[1];
}

function absyawtoenemy() {
  var_0 = self.angles[1] - scripts\engine\utility::getyaw(self.enemy.origin);
  var_0 = angleclamp180(var_0);

  if(var_0 < 0) {
    var_0 = -1 * var_0;
  }

  return var_0;
}

function absyawtoenemy2d() {
  var_0 = self.angles[1] - getyaw2d(self.enemy.origin);
  var_0 = angleclamp180(var_0);

  if(var_0 < 0) {
    var_0 = -1 * var_0;
  }

  return var_0;
}

function absyawtoorigin(var_0) {
  var_1 = self.angles[1] - scripts\engine\utility::getyaw(var_0);
  var_1 = angleclamp180(var_1);

  if(var_1 < 0) {
    var_1 = -1 * var_1;
  }

  return var_1;
}

function absyawtoangles(var_0) {
  var_1 = self.angles[1] - var_0;
  var_1 = angleclamp180(var_1);

  if(var_1 < 0) {
    var_1 = -1 * var_1;
  }

  return var_1;
}

function getyawfromorigin(var_0, var_1) {
  var_2 = vectortoangles(var_0 - var_1);
  return var_2[1];
}

function getgrenademodel() {
  return getweaponmodel(self.grenadeweapon);
}

function getenemyeyepos() {
  if(isDefined(self.enemy)) {
    self.a.lastenemypos = self.enemy getshootatpos();
    self.a.lastenemytime = gettime();
    return self.a.lastenemypos;
  }

  if(isDefined(self.a.lastenemytime) && isDefined(self.a.lastenemypos) && self.a.lastenemytime + 3000 < gettime()) {
    return self.a.lastenemypos;
  }

  var_0 = self getshootatpos();
  var_0 += 196 * self.lookforward;
  return var_0;
}

function gettruenodeangles(var_0) {
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

function getyawtoorigin(var_0) {
  if(isDefined(self.type) && scripts\engine\utility::isnode3d(self)) {
    var_1 = gettruenodeangles(self);
    var_2 = anglesToForward(var_1);
    var_3 = rotatepointaroundvector(var_2, var_0 - self.origin, var_1[2] * -1);
    var_3 += self.origin;
    var_4 = scripts\engine\utility::getyaw(var_3) - var_1[1];
    var_4 = angleclamp180(var_4);
    return var_4;
  }

  var_4 = scripts\engine\utility::getyaw(var_4) - self.angles[1];
  var_4 = angleclamp180(var_4);
  return var_4;
}

function canseepointfromexposedatcorner(var_0, var_1) {
  var_2 = getyawtoorigin(var_1, var_0);

  if(var_2 > 60 || var_2 < -60) {
    return false;
  }

  if(scripts\engine\utility::isnodecoverleft(var_1) && var_2 < -14) {
    return false;
  }

  if(scripts\engine\utility::isnodecoverright(var_1) && var_2 > 12) {
    return false;
  }

  return true;
}

function getnodeoffset(var_0) {
  if(isDefined(var_0.offset)) {
    return var_0.offset;
  }

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
  var_11 = var_10["right"];
  var_12 = var_10["forward"];
  var_13 = var_10["up"];
  var_14 = var_0.type;

  switch (var_14) {
    case "Cover Left":
      var_15 = var_0 gethighestnodestance();

      if(!isDefined(var_15) || var_15 == "crouch") {
        var_9 = calculatenodeoffset(var_11, var_12, var_13, var_1);
      } else {
        var_9 = calculatenodeoffset(var_11, var_12, var_13, var_2);
      }

      break;
    case "Cover Right":
      var_15 = var_0 gethighestnodestance();

      if(!isDefined(var_15) || var_15 == "crouch") {
        var_9 = calculatenodeoffset(var_11, var_12, var_13, var_3);
      } else {
        var_9 = calculatenodeoffset(var_11, var_12, var_13, var_4);
      }

      break;
    case "Turret":
    case "Conceal Stand":
    case "Cover Stand 3D":
    case "Cover Stand":
      var_9 = calculatenodeoffset(var_11, var_12, var_13, var_6);
      break;
    case "Conceal Crouch":
    case "Cover Crouch Window":
    case "Cover Crouch":
      var_9 = calculatenodeoffset(var_11, var_12, var_13, var_5);
      break;
    case "Cover 3D":
      var_9 = getcover3dnodeoffset(var_0);
      break;
    case "Cover Prone":
      var_9 = calculatenodeoffset(var_11, var_12, var_13, var_7);
      break;
  }

  var_0.offset = var_9;
  return var_0.offset;
}

function getcover3dnodeoffset(var_0, var_1) {
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

function calculatenodeoffset(var_0, var_1, var_2, var_3) {
  return var_0 * var_3[0] + var_1 * var_3[1] + var_2 * var_3[2];
}

function canseepointfromexposedatnode(var_0, var_1) {
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

  if(!sighttracepassed(var_3, var_0, 0, self.enemy)) {
    if(scripts\engine\utility::isnodecovercrouch(var_1)) {
      var_3 = (0, 0, 64) + var_1.origin;
      return sighttracepassed(var_3, var_0, 0, self.enemy);
    }

    return 0;
  }

  return 1;
}

function persistentdebugline(var_0, var_1) {
  self endon("death");
  level notify("newdebugline");
  level endon("newdebugline");

  for(;;) {
    wait 0.05;
  }
}

function canseeenemyfromexposed() {
  if(!isDefined(self.enemy)) {
    return 0;
  }

  var_0 = getenemyeyepos();

  if(!isDefined(self.node)) {
    var_1 = self cansee(self.enemy);
  } else if(scripts\engine\utility::actor_is3d() && scripts\engine\utility::isnode3d(self.node)) {
    var_1 = canseepointfromexposedatnode(var_1, self.node);

    if(!var_1) {
      var_1 = (self.enemy.origin + var_1) / 2;
      var_1 = canseepointfromexposedatnode(var_1, self.node);
    }
  } else {
    var_1 = canseepointfromexposedatnode(var_1, self.node);
  }

  if(var_1) {
    dontgiveuponsuppressionyet();
  }

  return var_1;
}

function checkpitchvisibility(var_0, var_1, var_2) {
  var_3 = self.upaimlimit - anim.aimpitchdifftolerance;
  var_4 = self.downaimlimit + anim.aimpitchdifftolerance;
  var_5 = var_1 - var_0;

  if(scripts\engine\utility::actor_is3d()) {
    if(isDefined(var_2) && scripts\engine\utility::isnode3d(var_2)) {
      var_6 = var_2.angles;
    } else {
      var_6 = self.angles;
    }

    var_6 = rotatevectorinverted(var_6, var_6);
  }

  var_7 = angleclamp180(vectortopitch(var_6));

  if(var_7 < var_4) {
    return false;
  }

  if(var_7 > var_5) {
    if(isDefined(var_3) && !scripts\engine\utility::isnodecovercrouch(var_3)) {
      return false;
    }

    if(var_7 > anim.covercrouchleanpitch + var_5) {
      return false;
    }
  }

  return true;
}

function dontgiveuponsuppressionyet() {
  self.a.shouldresetgiveuponsuppressiontimer = 1;
}

function cansuppressenemy() {
  if(!hassuppressableenemy() || self.doingambush) {
    self.goodshootpos = undefined;
    return 0;
  }

  if(!isPlayer(self.enemy)) {
    return aisuppressai();
  }

  if(!checkpitchvisibility(self getEye(), self.lastenemysightpos)) {
    return 0;
  }

  var_0 = self getapproxeyepos();
  return findgoodsuppressspot(var_0);
}

function updategiveuponsuppressiontimer() {
  if(!isDefined(self.a.shouldresetgiveuponsuppressiontimer)) {
    self.a.shouldresetgiveuponsuppressiontimer = 1;
  }

  if(self.a.shouldresetgiveuponsuppressiontimer) {
    self.a.giveuponsuppressiontime = gettime() + randomintrange(15000, 30000);
    self.a.shouldresetgiveuponsuppressiontimer = 0;
    return;
  }
}

function hassuppressableenemy() {
  if(!isDefined(self.enemy)) {
    return false;
  }

  if(!isDefined(self.lastenemysightpos)) {
    return false;
  }

  if(!istrue(self.dontgiveuponsuppression)) {
    updategiveuponsuppressiontimer();

    if(gettime() > self.a.giveuponsuppressiontime) {
      return false;
    }
  }

  if(!isDefined(self.goodshootpos) && !needrecalculatesuppressspot()) {
    return false;
  }

  return true;
}

function aisuppressai() {
  if(!self canattackenemynode() && !istrue(self.forcesuppressai)) {
    return false;
  }

  var_0 = undefined;

  if(isDefined(self.enemy.covernode)) {
    var_1 = getnodeoffset(self.enemy.covernode);
    var_0 = self.enemy.covernode.origin + var_1;
  } else {
    var_0 = self.enemy getshootatpos();
  }

  if(!self canshoot(var_0) && !istrue(self.forcesuppressai)) {
    return false;
  }

  self.goodshootpos = var_0;
  return true;
}

function canseeandshootpoint(var_0) {
  if(isDefined(self.a.weaponpos) && getqueuedspleveltransients(self.a.weaponpos["right"])) {
    return 0;
  }

  if(!sighttracepassed(self getshootatpos(), var_0, 0, undefined)) {
    return 0;
  }

  var_1 = self getapproxeyepos();
  return sighttracepassed(var_1, var_0, 0, undefined);
}

function needrecalculatesuppressspot() {
  if(isDefined(self.goodshootpos) && !canseeandshootpoint(self.goodshootpos)) {
    return true;
  }

  return !isDefined(self.lastenemysightposold) || distancesquared(self.lastenemysightposold, self.lastenemysightpos) > 256 || distancesquared(self.lastenemysightposselforigin, self.origin) > 1024;
}

function findgoodsuppressspot(var_0) {
  var_1 = min(self.enemy.maxvisibledist, 1024);

  if(isDefined(self.enemy) && distancesquared(self.origin, self.enemy.origin) > squared(var_1 + 768)) {
    self.goodshootpos = undefined;
    return false;
  }

  if(needrecalculatesuppressspot()) {
    self.lastenemysightposselforigin = self.origin;
    self.lastenemysightposold = self.lastenemysightpos;

    if(istrue(self.suppress_uselastenemysightpos)) {
      self.goodshootpos = self.lastenemysightpos;
      return true;
    }

    var_2 = getenemyeyepos();
    self.goodshootpos = self scriptabledoorclose(var_0, var_2, self.suppress_numgoodtracesneeded);
    return isDefined(self.goodshootpos);
  } else if(isDefined(self.goodshootpos) && isDefined(self.pathgoalpos) && distancesquared(self.origin, self.goodshootpos) < 1024) {
    self.goodshootpos = undefined;
  }

  return isDefined(self.goodshootpos);
}

function cansuppressenemyfromexposed() {
  if(self.doingambush) {
    return false;
  }

  if(!hassuppressableenemy()) {
    return false;
  }

  if(!isPlayer(self.enemy)) {
    return aisuppressai();
  }

  if(isDefined(self.node)) {
    jumpiffalse(scripts\engine\utility::isnodecoverleft(self.node) || scripts\engine\utility::isnodecoverright(self.node)) LOC_0000005b;
    jumpiftrue(canseepointfromexposedatcorner(getenemyeyepos(), self.node)) LOC_0000005b;
    return false;
  } else {
    var_1 = self getapproxeyepos();
  }

  if(!checkpitchvisibility(var_1, self.lastenemysightpos)) {
    return false;
  }

  return findgoodsuppressspot(var_1);
}

function canseeenemy(var_0) {
  if(!isDefined(self.enemy)) {
    return false;
  }

  if(isDefined(var_0) && self cansee(self.enemy, var_0) || self cansee(self.enemy)) {
    if(!checkpitchvisibility(self getEye(), self.enemy getshootatpos())) {
      return false;
    }

    dontgiveuponsuppressionyet();
    return true;
  }

  return false;
}

function recentlysawenemy() {
  return isDefined(self.enemy) && self seerecently(self.enemy, 5);
}

function issuppressedwrapper() {
  if(isDefined(self.forcesuppression)) {
    return self.forcesuppression;
  }

  if(self.suppressionmeter <= self.suppressionthreshold) {
    return 0;
  }

  return self issuppressed();
}

function enemyishiding() {
  if(!isDefined(self.enemy)) {
    return false;
  }

  if(self.enemy scripts\engine\utility::isflashed()) {
    return true;
  }

  if(isPlayer(self.enemy)) {
    if(isDefined(self.enemy.health) && self.enemy.health < self.enemy.maxhealth) {
      return true;
    }
  } else if(isai(self.enemy) && issuppressedwrapper(self.enemy)) {
    return true;
  }

  if(isDefined(self.enemy.isreloading) && self.enemy.isreloading) {
    return true;
  }

  return false;
}

function shouldshootenemyent() {
  if(!canseeenemy()) {
    return false;
  }

  if(!self canshootenemy()) {
    return false;
  }

  return true;
}

function sortandcullanimstructarray(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3.weight <= 0) {
      continue;
    }

    for(var_4 = 0; var_4 < var_1.size; var_4++) {
      if(var_3.weight < var_1[var_4].weight) {
        for(var_5 = var_1.size; var_5 > var_4; var_5--) {
          var_1 = var_1[var_5 - 1];
        }

        break;
      }
    }

    var_1 = var_3;
  }

  return var_1;
}

function player_can_see_ai(var_0, var_1, var_2) {
  var_3 = gettime();

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(isDefined(var_1.playerseesmetime) && var_1.playerseesmetime + var_2 >= var_3) {
    return var_1.playerseesme;
  }

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
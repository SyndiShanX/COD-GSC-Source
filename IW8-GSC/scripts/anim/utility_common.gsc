/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\utility_common.gsc
***********************************************/

function print3dtime(var0, var1, var2, var3, var4, var5) {
  var6 = var0 / 0.05;

  for(var7 = 0; var7 < var6; var7++) {
    wait 0.05;
  }
}

function print3drise(var0, var1, var2, var3, var4) {
  var5 = 100;
  var6 = 0;
  var0 += scripts\engine\utility::randomvector(30);

  for(var7 = 0; var7 < var5; var7++) {
    var6 += 0.5;
    wait 0.05;
  }
}

function crossproduct(var0, var1) {
  return var0[0] * var1[1] - var0[1] * var1[0] > 0;
}

function safemod(var0, var1) {
  var2 = int(var0) % var1;
  var2 += var1;
  return var2 % var1;
}

function quadrantanimweights(var0) {
  var1 = cos(var0);
  var2 = sin(var0);
  GscBinSkip1(0x45, "front", 0);
}

function getquadrant(var0) {
  var0 = angleclamp(var0);

  if(var0 < 45 || var0 > 315) {
    var1 = "front";
  } else if(var1 < 135) {
    var1 = "left";
  } else if(var1 < 225) {
    var1 = "back";
  } else {
    var1 = "right";
  }

  return var1;
}

function isinset(var0, var1) {
  for(var2 = var1.size - 1; var2 >= 0; var2--) {
    if(var0 == var1[var2]) {
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

function isshotgun(var0) {
  return weaponclass(var0) == "spread";
}

function issniperrifle(var0) {
  return weaponclass(var0) == "sniper";
}

function isshotgunai() {
  return isshotgun(self.primaryweapon);
}

function isasniper(var0) {
  if(istrue(self.disablesniperbehaviors)) {
    return false;
  }

  if(!isDefined(var0)) {
    var0 = 1;
  }

  if(!issniperrifle(self.primaryweapon)) {
    return false;
  }

  if(var0) {
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
  var0 = weaponclass(self.weapon);

  switch (var0) {
    case "smg":
    case "sniper":
    case "spread":
    case "mg":
    case "rifle":
      return true;
  }

  return false;
}

function repeater_headshot_ammo_passive(var0, var1, var2) {
  if(!isDefined(var0) || !isDefined(var1) || !isDefined(var2)) {
    return;
  }

  if(!isPlayer(var1)) {
    return;
  }

  var3 = var0.basename;

  if(!isDefined(var3) || var3 != "iw7_repeater") {
    return;
  }

  if(!isDefined(var2.damagelocation)) {
    return;
  }

  if(var2.damagelocation != "head" && var2.damagelocation != "helmet") {
    return;
  }

  var4 = weaponclipsize(var0);
  var5 = var4 * 1;
  var6 = var1 getweaponammoclip(var0);
  var7 = min(var6 + var5, var4);
  var1 setweaponammoclip(var0, int(var7));
}

function needtoreload(var0) {
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

  if(self.bulletsinclip <= weaponclipsize(self.weapon) * var0) {
    if(var0 == 0) {
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

function shootenemywrapper(var0) {
  if(!isDefined(var0)) {
    var0 = 1;
  }

  [[anim.shootenemywrapper_func]](var0);
}

function getnodeyawtoorigin(var0) {
  if(isDefined(self.node)) {
    var1 = self.node.angles[1] - scripts\engine\utility::getyaw(var0);
  } else {
    var1 = self.angles[1] - scripts\engine\utility::getyaw(var1);
  }

  var1 = angleclamp180(var1);
  return var1;
}

function getnodeyawtoenemy() {
  var0 = undefined;

  if(isDefined(self.enemy)) {
    var0 = self.enemy.origin;
  } else {
    if(isDefined(self.node)) {
      var1 = anglesToForward(self.node.angles);
    } else {
      var1 = anglesToForward(self.angles);
    }

    var1 *= 150;
    var1 = self.origin + var1;
  }

  if(isDefined(self.node)) {
    var2 = self.node.angles[1] - scripts\engine\utility::getyaw(var1);
  } else {
    var2 = self.angles[1] - scripts\engine\utility::getyaw(var2);
  }

  var2 = angleclamp180(var2);
  return var2;
}

function getyawtoenemy() {
  var0 = undefined;

  if(isDefined(self.enemy)) {
    var0 = self.enemy.origin;
  } else {
    var1 = anglesToForward(self.angles);
    var1 *= 150;
    var0 = self.origin + var1;
  }

  var2 = self.angles[1] - scripts\engine\utility::getyaw(var0);
  var2 = angleclamp180(var2);
  return var2;
}

function getyaw2d(var0) {
  var1 = vectortoangles((var0[0], var0[1], 0) - (self.origin[0], self.origin[1], 0));
  return var1[1];
}

function absyawtoenemy() {
  var0 = self.angles[1] - scripts\engine\utility::getyaw(self.enemy.origin);
  var0 = angleclamp180(var0);

  if(var0 < 0) {
    var0 = -1 * var0;
  }

  return var0;
}

function absyawtoenemy2d() {
  var0 = self.angles[1] - getyaw2d(self.enemy.origin);
  var0 = angleclamp180(var0);

  if(var0 < 0) {
    var0 = -1 * var0;
  }

  return var0;
}

function absyawtoorigin(var0) {
  var1 = self.angles[1] - scripts\engine\utility::getyaw(var0);
  var1 = angleclamp180(var1);

  if(var1 < 0) {
    var1 = -1 * var1;
  }

  return var1;
}

function absyawtoangles(var0) {
  var1 = self.angles[1] - var0;
  var1 = angleclamp180(var1);

  if(var1 < 0) {
    var1 = -1 * var1;
  }

  return var1;
}

function getyawfromorigin(var0, var1) {
  var2 = vectortoangles(var0 - var1);
  return var2[1];
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

  var0 = self getshootatpos();
  var0 += 196 * self.lookforward;
  return var0;
}

function gettruenodeangles(var0) {
  if(!isDefined(var0)) {
    return (0, 0, 0);
  }

  if(!isDefined(var0.script_angles)) {
    return var0.angles;
  }

  var1 = var0.angles;
  var2 = angleclamp180(var1[0] + var0.script_angles[0]);
  var3 = var1[1];
  var4 = angleclamp180(var1[2] + var0.script_angles[2]);
  return (var2, var3, var4);
}

function getyawtoorigin(var0) {
  if(isDefined(self.type) && scripts\engine\utility::isnode3d(self)) {
    var1 = gettruenodeangles(self);
    var2 = anglesToForward(var1);
    var3 = rotatepointaroundvector(var2, var0 - self.origin, var1[2] * -1);
    var3 += self.origin;
    var4 = scripts\engine\utility::getyaw(var3) - var1[1];
    var4 = angleclamp180(var4);
    return var4;
  }

  var4 = scripts\engine\utility::getyaw(var4) - self.angles[1];
  var4 = angleclamp180(var4);
  return var4;
}

function canseepointfromexposedatcorner(var0, var1) {
  var2 = getyawtoorigin(var1, var0);

  if(var2 > 60 || var2 < -60) {
    return false;
  }

  if(scripts\engine\utility::isnodecoverleft(var1) && var2 < -14) {
    return false;
  }

  if(scripts\engine\utility::isnodecoverright(var1) && var2 > 12) {
    return false;
  }

  return true;
}

function getnodeoffset(var0) {
  if(isDefined(var0.offset)) {
    return var0.offset;
  }

  var1 = (-26, 0.4, 36);
  var2 = (-32, 7, 63);
  var3 = (43.5, 11, 36);
  var4 = (36, 8.3, 63);
  var5 = (3.5, -12.5, 45);
  var6 = (-3.7, -22, 63);
  var7 = (0, 30, 13);
  var8 = 0;
  var9 = (0, 0, 0);
  var10 = anglestoaxis(var0.angles);
  var11 = var10["right"];
  var12 = var10["forward"];
  var13 = var10["up"];
  var14 = var0.type;

  switch (var14) {
    case "Cover Left":
      var15 = var0 gethighestnodestance();

      if(!isDefined(var15) || var15 == "crouch") {
        var9 = calculatenodeoffset(var11, var12, var13, var1);
      } else {
        var9 = calculatenodeoffset(var11, var12, var13, var2);
      }

      break;
    case "Cover Right":
      var15 = var0 gethighestnodestance();

      if(!isDefined(var15) || var15 == "crouch") {
        var9 = calculatenodeoffset(var11, var12, var13, var3);
      } else {
        var9 = calculatenodeoffset(var11, var12, var13, var4);
      }

      break;
    case "Turret":
    case "Conceal Stand":
    case "Cover Stand 3D":
    case "Cover Stand":
      var9 = calculatenodeoffset(var11, var12, var13, var6);
      break;
    case "Conceal Crouch":
    case "Cover Crouch Window":
    case "Cover Crouch":
      var9 = calculatenodeoffset(var11, var12, var13, var5);
      break;
    case "Cover 3D":
      var9 = getcover3dnodeoffset(var0);
      break;
    case "Cover Prone":
      var9 = calculatenodeoffset(var11, var12, var13, var7);
      break;
  }

  var0.offset = var9;
  return var0.offset;
}

function getcover3dnodeoffset(var0, var1) {
  var2 = (2, -10, 35);
  var3 = (-19, -10, 32);
  var4 = (16, -10, 32);
  var5 = anglestoright(var0.angles);
  var6 = anglesToForward(var0.angles);
  var7 = anglestoup(var0.angles);
  var8 = var2;

  if(isDefined(var1)) {
    if(var1 == "left") {
      var8 = var3;
    } else if(var1 == "right") {
      var8 = var4;
    }
  }

  return calculatenodeoffset(var5, var6, var7, var8);
}

function calculatenodeoffset(var0, var1, var2, var3) {
  return var0 * var3[0] + var1 * var3[1] + var2 * var3[2];
}

function canseepointfromexposedatnode(var0, var1) {
  if(scripts\engine\utility::isnodecoverleft(var1) || scripts\engine\utility::isnodecoverright(var1)) {
    if(!canseepointfromexposedatcorner(var0, var1)) {
      return 0;
    }
  }

  var2 = getnodeoffset(var1);
  var3 = var1.origin + var2;

  if(!checkpitchvisibility(var3, var0, var1)) {
    return 0;
  }

  if(!sighttracepassed(var3, var0, 0, self.enemy)) {
    if(scripts\engine\utility::isnodecovercrouch(var1)) {
      var3 = (0, 0, 64) + var1.origin;
      return sighttracepassed(var3, var0, 0, self.enemy);
    }

    return 0;
  }

  return 1;
}

function persistentdebugline(var0, var1) {
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

  var0 = getenemyeyepos();

  if(!isDefined(self.node)) {
    var1 = self cansee(self.enemy);
  } else if(scripts\engine\utility::actor_is3d() && scripts\engine\utility::isnode3d(self.node)) {
    var1 = canseepointfromexposedatnode(var1, self.node);

    if(!var1) {
      var1 = (self.enemy.origin + var1) / 2;
      var1 = canseepointfromexposedatnode(var1, self.node);
    }
  } else {
    var1 = canseepointfromexposedatnode(var1, self.node);
  }

  if(var1) {
    dontgiveuponsuppressionyet();
  }

  return var1;
}

function checkpitchvisibility(var0, var1, var2) {
  var3 = self.upaimlimit - anim.aimpitchdifftolerance;
  var4 = self.downaimlimit + anim.aimpitchdifftolerance;
  var5 = var1 - var0;

  if(scripts\engine\utility::actor_is3d()) {
    if(isDefined(var2) && scripts\engine\utility::isnode3d(var2)) {
      var6 = var2.angles;
    } else {
      var6 = self.angles;
    }

    var6 = rotatevectorinverted(var6, var6);
  }

  var7 = angleclamp180(vectortopitch(var6));

  if(var7 < var4) {
    return false;
  }

  if(var7 > var5) {
    if(isDefined(var3) && !scripts\engine\utility::isnodecovercrouch(var3)) {
      return false;
    }

    if(var7 > anim.covercrouchleanpitch + var5) {
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

  var0 = self getapproxeyepos();
  return findgoodsuppressspot(var0);
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

  var0 = undefined;

  if(isDefined(self.enemy.covernode)) {
    var1 = getnodeoffset(self.enemy.covernode);
    var0 = self.enemy.covernode.origin + var1;
  } else {
    var0 = self.enemy getshootatpos();
  }

  if(!self canshoot(var0) && !istrue(self.forcesuppressai)) {
    return false;
  }

  self.goodshootpos = var0;
  return true;
}

function canseeandshootpoint(var0) {
  if(isDefined(self.a.weaponpos) && getqueuedspleveltransients(self.a.weaponpos["right"])) {
    return 0;
  }

  if(!sighttracepassed(self getshootatpos(), var0, 0, undefined)) {
    return 0;
  }

  var1 = self getapproxeyepos();
  return sighttracepassed(var1, var0, 0, undefined);
}

function needrecalculatesuppressspot() {
  if(isDefined(self.goodshootpos) && !canseeandshootpoint(self.goodshootpos)) {
    return true;
  }

  return !isDefined(self.lastenemysightposold) || distancesquared(self.lastenemysightposold, self.lastenemysightpos) > 256 || distancesquared(self.lastenemysightposselforigin, self.origin) > 1024;
}

function findgoodsuppressspot(var0) {
  var1 = min(self.enemy.maxvisibledist, 1024);

  if(isDefined(self.enemy) && distancesquared(self.origin, self.enemy.origin) > squared(var1 + 768)) {
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

    var2 = getenemyeyepos();
    self.goodshootpos = self scriptabledoorclose(var0, var2, self.suppress_numgoodtracesneeded);
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
    var1 = self getapproxeyepos();
  }

  if(!checkpitchvisibility(var1, self.lastenemysightpos)) {
    return false;
  }

  return findgoodsuppressspot(var1);
}

function canseeenemy(var0) {
  if(!isDefined(self.enemy)) {
    return false;
  }

  if(isDefined(var0) && self cansee(self.enemy, var0) || self cansee(self.enemy)) {
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

function sortandcullanimstructarray(var0) {
  var1 = [];

  foreach(var3 in var0) {
    if(var3.weight <= 0) {
      continue;
    }

    for(var4 = 0; var4 < var1.size; var4++) {
      if(var3.weight < var1[var4].weight) {
        for(var5 = var1.size; var5 > var4; var5--) {
          var1 = var1[var5 - 1];
        }

        break;
      }
    }

    var1 = var3;
  }

  return var1;
}

function player_can_see_ai(var0, var1, var2) {
  var3 = gettime();

  if(!isDefined(var2)) {
    var2 = 0;
  }

  if(isDefined(var1.playerseesmetime) && var1.playerseesmetime + var2 >= var3) {
    return var1.playerseesme;
  }

  var1.playerseesmetime = var3;

  if(!scripts\engine\utility::within_fov(var0.origin, var0.angles, var1.origin, 0.766)) {
    var1.playerseesme = 0;
    return 0;
  }

  var4 = var0 getEye();
  var5 = var1.origin;

  if(sighttracepassed(var4, var5, 1, var0, var1)) {
    var1.playerseesme = 1;
    return 1;
  }

  var6 = var1 getapproxeyepos();

  if(sighttracepassed(var4, var6, 1, var0, var1)) {
    var1.playerseesme = 1;
    return 1;
  }

  var7 = (var6 + var5) * 0.5;

  if(sighttracepassed(var4, var7, 1, var0, var1)) {
    var1.playerseesme = 1;
    return 1;
  }

  var1.playerseesme = 0;
  return 0;
}
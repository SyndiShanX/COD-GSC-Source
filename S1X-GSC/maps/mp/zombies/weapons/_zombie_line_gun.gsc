/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\weapons\_zombie_line_gun.gsc
********************************************************/

init() {
  level.linegun = spawnStruct();
  level.linegun.name = "iw5_linegunzm_mp";
  level.linegun.damageweapon = "iw5_linegundamagezm_mp";
  level.linegun.maxdist = 5000;
  level.linegun.movespeed = 450;
  level.linegun.startoffset = (30, 0, 0);
  level.linegun.hipfireangles = (3, 3, 20);
  level.linegun.damage = 1200;
  level.linegun.debug = 0;
  level.linegun.debugduration = 1;
  level.linegun.startwidth = 200;
  level.linegun.widthrate = 0;
  level.linegun.widthratetime = 0;
  level.modifyweapondamage[level.linegun.name] = ::linegunmodifydamage;
  level.damageweapontoweapon[level.linegun.damageweapon] = level.linegun.name;
  level._effect["dlc_zombies_linegun_laser"] = loadfx("vfx/muzzleflash/dlc_zombies_linegun_laser");
  level._effect["dlc_zombie_line_gun_gib"] = loadfx("vfx/blood/dlc_zombie_line_gun_gib");
  level._effect["dlc_zombies_drone_death"] = loadfx("vfx/muzzleflash/dlc_zombies_drone_death");
}

linegunmodifydamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return int(level.linegun.damage);
}

onplayerspawn() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");
  self notify("onPlayerSpawnLineGUn");
  self endon("onPlayerSpawnLineGUn");

  for(;;) {
    self waittill("weapon_fired", var_0);
    var_1 = getweaponbasename(var_0);

    if(var_1 != level.linegun.name) {
      continue;
    }
    thread firelinegun();
  }
}

firelinegun() {
  var_0 = self playerads();
  var_1 = self getangles();
  var_2 = (var_1[0], var_1[1], 0);
  var_3 = randomfloatrange(-1.0, 1.0) * (1.0 - var_0);
  var_4 = randomfloatrange(-1.0, 1.0) * (1.0 - var_0);
  var_5 = var_2 + (level.linegun.hipfireangles[0] * var_3, level.linegun.hipfireangles[1] * var_4, 0);
  var_6 = anglesToForward(var_1);
  var_7 = anglesToForward(var_5);
  var_8 = self getvieworigin();
  var_9 = var_8 + self getvelocity() * 0.05 + rotatevector(level.linegun.startoffset, var_2);
  var_10 = var_8 + var_7 * level.linegun.maxdist;
  var_11 = var_8;
  var_12 = undefined;
  var_13 = self;
  var_14 = 1;
  var_15 = 0;

  while(var_15 < 3) {
    var_12 = bulletTrace(var_11, var_10, 0, var_13, 0, 0, 0, 0, var_14, 0, 0);

    if(isDefined(var_12["glass"])) {
      var_14 = 0;
      var_16 = distance(var_9, var_12["position"]);
      var_17 = var_16 / level.linegun.movespeed;
      thread lineguntouchglass(var_12["glass"], var_6, var_17);
      continue;
    }

    var_18 = var_12["entity"];
    var_19 = isDefined(var_18) && maps\mp\zombies\_util::is_true(var_18.linegunignore);

    if(!var_19) {
      break;
    }

    var_11 = var_12["position"];
    var_13 = var_18;
    var_15++;
  }

  if(var_12["fraction"] <= 0) {
    return;
  }
  var_10 = var_12["position"];
  var_20 = distance(var_8, var_10);
  var_21 = linegungetprojectileent(var_9, self.angles);
  var_22 = var_20 / level.linegun.movespeed;
  var_21 moveto(var_10, var_22);
  var_23 = -1 * var_4 * level.linegun.hipfireangles[2];

  if(var_23 != 0) {
    var_21 rotatevelocity((0, 0, var_23), var_22);
  }

  var_21 thread lineprojectiledamageupdate(self);
  var_21 waittill("movedone");
  level thread linegunreleaseprojectileent(var_21);
}

lineguntouchglass(var_0, var_1, var_2) {
  wait(var_2);

  if(!isglassdestroyed(var_0)) {
    destroyglass(var_0, var_1);
  }
}

lineprojectiledamageupdate(var_0) {
  self endon("death");
  self endon("released");
  self.enemyimpactcount = 0;
  var_1 = gettime();
  var_2 = level.linegun.startwidth;

  for(;;) {
    var_3 = anglestoright(self.angles);

    if(level.linegun.widthrate > 0) {
      var_2 = (gettime() - var_1) / 1000 * level.linegun.widthrate;
      var_2 = clamp(var_2, level.linegun.startwidth, level.linegun.widthratetime * level.linegun.widthrate);
    }

    linegundamage(self.origin, self.origin + var_3 * var_2, var_0);
    linegundamage(self.origin, self.origin - var_3 * var_2, var_0);
    waitframe();
  }
}

linegundamage(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  foreach(var_6 in level.characters) {
    if(var_6 maps\mp\agents\humanoid\_humanoid_util::iscrawling()) {
      var_6.linegunheight = 40;
    } else {
      var_6.linegunheight = 70;
    }

    var_6.linegungibfx = "dlc_zombie_line_gun_gib";
    var_4[var_4.size] = var_6;
  }

  var_8 = [level.ammodrone, level.ammodrone2];

  foreach(var_10 in var_8) {
    if(!isDefined(var_10)) {
      continue;
    }
    var_10.linegunheight = 40;
    var_4[var_4.size] = var_10;
  }

  foreach(var_13 in var_4) {
    if(isDefined(var_13.team) && var_13.team == var_2.team) {
      continue;
    }
    [var_15, var_16] = maps\mp\zombies\_util::projecttoline(var_13.origin, var_0, var_1);

    if(var_16 < 0.0 || var_16 > 1.0) {
      continue;
    }
    if(var_15[2] < var_13.origin[2]) {
      continue;
    }
    if(var_15[2] > var_13.origin[2] + var_13.linegunheight) {
      continue;
    }
    var_17 = (var_13.origin[0], var_13.origin[1], var_15[2]);

    if(distancesquared(var_15, var_17) > squared(level.linegun.movespeed / 20)) {
      continue;
    }
    if(isDefined(var_13.lastlinegundamagetime) && gettime() - var_13.lastlinegundamagetime < 100) {
      continue;
    }
    var_13.projecttolinepoint = var_15;
    var_13.projecttolinescale = var_16;
    var_3[var_3.size] = var_13;
  }

  if(!var_3.size) {
    return;
  }
  var_19 = bulletTrace(var_0, var_1, 0, var_2);

  if(var_19["fraction"] <= 0) {
    return;
  }
  var_1 = var_19["position"];

  foreach(var_13 in var_3) {
    if(!isalive(var_13)) {
      continue;
    }
    if(var_13.projecttolinescale > var_19["fraction"]) {
      continue;
    }
    var_17 = (var_13.origin[0], var_13.origin[1], var_13.projecttolinepoint[2]);

    if(level.linegun.debug) {
      var_21 = (1, 0, 0);
      var_22 = bulletTrace(var_0, var_1, 0, var_2);
      var_23 = var_22["entity"];

      if(isDefined(var_23) && var_23 == var_13) {
        var_21 = (0, 1, 0);
      }
    }

    thread linegungibfx(var_13, var_17);
    var_24 = linegundamagelocation(var_13, var_17);
    var_13 dodamage(level.linegun.damage, var_17, var_2, var_2, "MOD_RIFLE_BULLET", level.linegun.damageweapon, var_24);
    var_2 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("linegun", var_13);
    var_13.lastlinegundamagetime = gettime();
    self.enemyimpactcount++;

    if(self.enemyimpactcount == 18) {
      var_2 maps\mp\gametypes\zombies::givezombieachievement("DLC3_ZOMBIE_LIMBO");
    }
  }
}

linegungibfx(var_0, var_1) {
  var_2 = var_0.linegungibfx;

  if(!isDefined(var_2)) {
    return;
  }
  var_0 endon("detachLimb");
  waittillframeend;
  playFX(common_scripts\utility::getfx(var_2), var_1);
}

linegundamagelocation(var_0, var_1) {
  var_2 = var_1[2] - var_0.origin[2];

  if(var_2 < 32) {
    return common_scripts\utility::random(["right_leg_upper", "left_leg_upper"]);
  } else if(var_2 < 60) {
    return common_scripts\utility::random(["left_arm_upper", "right_arm_upper"]);
  } else {
    return common_scripts\utility::random(["head", "neck"]);
  }
}

linegungetprojectileent(var_0, var_1) {
  var_2 = undefined;
  var_3 = getEntArray("line_gun_projectile", "targetname");

  foreach(var_5 in var_3) {
    if(!isDefined(var_5.inuse) || !var_5.inuse) {
      var_2 = var_5;
      var_2 dontinterpolate();
      break;
    }
  }

  if(!isDefined(var_2)) {
    var_2 = spawn("script_model", var_0);
    var_2.targetname = "line_gun_projectile";
  }

  var_2 setModel("tag_origin");
  var_2.origin = var_0;
  var_2.angles = var_1;
  var_2.fxname = "dlc_zombies_linegun_laser";
  var_2.fxtag = "tag_origin";
  playFXOnTag(common_scripts\utility::getfx(var_2.fxname), var_2, var_2.fxtag);
  var_2 playLoopSound("wpn_linegun_beam_hi");
  var_2.inuse = 1;
  return var_2;
}

linegunreleaseprojectileent(var_0) {
  var_0 notify("released");
  killfxontag(common_scripts\utility::getfx(var_0.fxname), var_0, var_0.fxtag);
  playFXOnTag(common_scripts\utility::getfx("dlc_zombies_drone_death"), var_0, var_0.fxtag);
  var_0 stoploopsound("wpn_linegun_beam_hi");
  var_0 playSound("wpn_linegun_exp");
  wait 1.0;
  var_0.inuse = 0;
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\player\ballistics.gsc
***********************************************/

function init_ballistics() {
  precachemodel("ui_bullet_armor_piercing");
  level.g_effect["vfx_ballistics_bullet_trail"] = loadfx("vfx/iw8/level/highway/bullet_smktrail.vfx");
  level.g_effect["vfx_ballistics_bullet_impact"] = loadfx("vfx/iw8/level/highway/vfx_sniper_bullet_impact.vfx");
  setdvarifuninitialized("debug_ballistics", 0);
  setDvar("ballistics_muzzleSpeed", 38000);
  scripts\sp\gibbing::init_gibbing();
  level.ballistics = spawnStruct();
  level.ballistics.ignoreentities = [level.player];
  level.ballistics.wind = (0, 0, 0);
  thread ballistics_rotateflags();
  thread ballistics_bulletfiremonitor();
  thread ballistics_weaponswitchmonitor();
}

function ballistics_rotateflags() {
  var0 = getEntArray("flag", "targetname");
  var1 = level.ballistics.wind;

  for(;;) {
    if(level.ballistics.wind != var1) {
      foreach(var3 in var0) {
        var3.angles = vectortoangles(level.ballistics.wind);
      }
    }

    var1 = level.ballistics.wind;
    waitframe();
  }
}

function ballistics_weaponswitchmonitor() {
  var0 = 0;

  for(;;) {
    level.player waittill("weapon_change");

    if(ballistics_playerholdingballisticsweapon() && !var0) {
      var0 = 1;
      ballistsglobalsettings(var0);
      continue;
    }

    if(!ballistics_playerholdingballisticsweapon() && var0) {
      var0 = 0;
      ballistsglobalsettings(var0);
    }
  }
}

function ballistsglobalsettings(var0) {
  if(var0) {
    setsaveddvar("MPPNTMTPTS", 0);
    return;
  }

  setsaveddvar("MPPNTMTPTS", 1);
}

function ballistics_bulletfiremonitor() {
  level.player endon("death");

  for(;;) {
    level.player waittill("weapon_fired", var0, var1, var2);

    if(!ballistics_playerholdingballisticsweapon()) {
      continue;
    }

    firebullet(level.player, var1, var2);
  }
}

function firebullet(var0, var1) {
  var2 = (0, 0, 1);
  var3 = anglesToForward(var1) * getdvarint("ballistics_muzzleSpeed");
  var4 = (0, 0, -300) + level.ballistics.wind;
  var5 = 0.657895;
  var6 = 0;
  var7 = var0;
  var8 = ballistics_createbullet(var0, var1);
  var9 = [];
  var10 = 0;
  var11 = 0.1;
  var12 = anglesToForward(var1) * -5 + anglestoup(var1) * -2;
  var13 = undefined;

  while(var6 < var5) {
    var14 = var7;
    var7 = var0 + var3 * var6 + 0.5 * var4 * squared(var6);
    var15 = vectorNormalize(var7 - var14);
    var16 = distance(var7, var14);
    var8.origin = var7 + var12;
    var12 *= 0.2;

    if(var10) {
      var17 = scripts\engine\trace::create_contents(1);
    } else {
      var17 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1);
    }

    var18 = scripts\engine\sp\utility::array_merge(level.ballistics.ignoreentities, var9);
    var19 = scripts\engine\trace::ray_trace_detail(var14, var7, var18, var17, 1, 1);
    var20 = [var19];

    if(getdvarint("debug_ballistics")) {
      var21 = scripts\engine\utility::ter_op(var10, (1, 1, 0), (1, 0, 0));
    }

    var22 = var6 >= var11;

    if(var22) {
      var23 = vectorcross(var15, var2);
      var24 = vectorcross(var15, var23);
      var25 = var24 * -1;
      var26 = var23 * -1;
      var27 = [var23, var24, var25, var26];

      foreach(var29 in var27) {
        var30 = var14 + var29 * 3.5;
        var31 = var30 + var15 * var16;
        var32 = scripts\engine\trace::ray_trace_detail(var30, var31, var18, var17, 1, 1);
        var20 = scripts\engine\utility::array_add(var20, var32);

        if(getdvarint("debug_ballistics")) {
          var21 = scripts\engine\utility::ter_op(var10, (1, 1, 0), (1, 0, 0));

          if(isDefined(var13)) {}

          var13 = var8.origin;
        }
      }
    }

    var34 = undefined;
    var35 = undefined;
    var36 = undefined;
    var37 = undefined;

    foreach(var32 in var20) {
      if(var32["fraction"] < 1) {
        if(isDefined(var32["entity"])) {
          var18 = scripts\engine\utility::array_add(var18, var32["entity"]);
        }

        var34 = var32["position"];
        var35 = var32["normal"];
        var36 = var32["entity"];
        var37 = var32["surfacetype"];
        break;
      }
    }

    if(isDefined(var34)) {
      if(!var10) {
        level notify("ballistics_impact", var34);
        var7 = var14;
        var10 = 1;
      }

      glassradiusdamage(var34, 30, 99999, 9999);
      var40 = var34 + var15 * -15;
      var41 = var34 + var15 * 50;
      magicbullet("iw8_sn_hdromeo_ballistics_impact", var40, var41);

      if(getdvarint("debug_ballistics")) {}

      if(isDefined(var36)) {
        var36 notify("ballistics_bulletDamage", var34);

        if(isai(var36)) {
          if(!ballistics_shoulddamageai(var36)) {
            playFX(level.g_effect["vfx_gib_explode"], var34);
          } else if(ballistics_shouldkillai(var36)) {
            if(scripts\sp\gibbing::gibbing_shouldgibai(var36)) {
              level.player thread scripts\sp\gibbing::gibbing_gibai(var36, var34, "MOD_RIFLE_BULLET");
            } else {
              thread ballistics_killai(level.player, var36);
            }
          } else {
            var36 scripts\sp\utility::do_damage(450, var34, self, undefined, "MOD_RIFLE_BULLET");

            if(!scripts\engine\utility::is_equal(var36.unittype, "juggernaut")) {
              playFX(level.g_effect["vfx_gib_explode"], var34);
            }
          }
        } else {
          var42 = isDefined(level.phys_barrels) && scripts\engine\utility::array_contains(level.phys_barrels, var36);

          if(var42) {
            var36 notify("barrel_death", level.player);
          } else {
            if(var36 isscriptable()) {
              radiusdamage(var36.origin, 50, 200, 200, level.player, "MOD_RIFLE_BULLET");
            }

            thread ballistics_impactvfxentitylogic(var36, var34, var35);
          }
        }

        if(istrue(var36.ballisticdontpenetrate)) {
          break;
        }
      } else {
        playFX(level.g_effect["vfx_ballistics_bullet_impact"], var20 + var22 * 0.75, var22);
        physicsexplosionsphere(var20, 128, 128, 75);
      }
    }

    var4 += 0.05;
    waitframe();
  }

  scripts\engine\utility::delaythread(0.05, &ballistics_deletebullet, var6);
}

function ballistics_impactvfxentitylogic(var0, var1, var2) {
  physicsexplosionsphere(var1, 128, 128, 75);
  var3 = var2;
  var1 += var3 * 0.75;
  var4 = (0, 0, 1);
  var5 = vectorcross(var3, var4);
  var6 = vectorcross(var3, var5);
  var7 = var6 * -1;
  var8 = axistoangles(var3, var5, var7);
  var9 = scripts\engine\utility::spawn_tag_origin(var1, var8);
  playFXOnTag(level.g_effect["vfx_ballistics_bullet_impact"], var9, "tag_origin");
  thread ballistics_impactvfxentityparentlogic(var0, var9);
  var0 endon("death");
  var0 endon("entitydeleted");
  wait 5;
  killfxontag(level.g_effect["vfx_ballistics_bullet_impact"], var9, "tag_origin");
  var9 delete();
}

function ballistics_impactvfxentityparentlogic(var0, var1) {
  var1 endon("death");
  var1 endon("entitydeleted");

  if(issubstr(tolower(var0.code_classname), "script")) {
    var1 linkTo(var0);
  }

  var0 scripts\engine\utility::waittill_any("death", "entitydeleted");
  killfxontag(level.g_effect["vfx_ballistics_bullet_impact"], var1, "tag_origin");
  var1 delete();
}

function ballistics_createbullet(var0, var1) {
  var2 = spawn("script_model", var0);
  var2 setModel("ui_bullet_armor_piercing");
  var2.angles = var1;
  var2 hide();
  var2.vfxtag = scripts\engine\utility::spawn_tag_origin(var2.origin, var2.angles);
  var2.vfxtag linkTo(var2);
  thread ballistics_delaybulletvfx(var2);
  thread ballistics_delaybulletshow(var2);
  return var2;
}

function ballistics_delaybulletvfx(var0) {
  var0 endon("entitydeleted");
  var0.vfxtag endon("entitydeleted");

  if(istrue(0)) {
    wait 0;
  }

  playFXOnTag(level.g_effect["vfx_ballistics_bullet_trail"], var0.vfxtag, "tag_origin");
}

function ballistics_delaybulletshow(var0) {
  var0 endon("entitydeleted");

  if(istrue(0.075)) {
    wait 0.075;
  }

  var0 show();
}

function ballistics_deletebullet(var0) {
  var0.vfxtag delete();
  var0 delete();
}

function ballistics_killai(var0, var1) {
  var0 stopanimScripted();
  var0 notify("stop_loop");
  playFX(level.g_effect["vfx_gib_explode"], var1);
  var0 scripts\sp\utility::do_damage(var0.health + 9999, var1, self, undefined, "MOD_RIFLE_BULLET");

  if(isPlayer(self) && istrue(var0.magic_bullet_shield) && scripts\engine\utility::is_equal(self.team, var0.team)) {
    scripts\sp\friendlyfire::missionfail(0);
    return;
  }
}

function ballistics_shoulddamageai(var0) {
  return !scripts\engine\utility::is_equal(var0.script_parameters, "ballistics_doNotDamage");
}

function ballistics_shouldkillai(var0) {
  if(scripts\engine\utility::is_equal(var0.unittype, "juggernaut")) {
    return false;
  }

  return true;
}

function ballistics_doesbullettrajectoryhitentity(var0, var1, var2, var3) {
  var4 = anglesToForward(var1) * 38000;
  var5 = (0, 0, -300);

  if(istrue(var3)) {
    var5 += level.ballistics.wind;
  }

  var6 = 0.657895;
  var7 = 0;
  var8 = var0;
  var9 = [level.player];
  var7 = 0;

  while(var7 < var6) {
    var10 = var8;
    var8 = var0 + var4 * var7 + 0.5 * var5 * squared(var7);
    var11 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 0, 0, 0);
    var12 = scripts\engine\trace::ray_trace_detail(var10, var8, var9, var11, 0, 1);
    var13 = var12["fraction"];
    var14 = var12["entity"];

    if(var13 != 1 && scripts\engine\utility::is_equal(var14, var2)) {
      return true;
    }

    var7 += 0.05;
    var7 += 0.05;
  }

  return false;
}

function ballistics_playerholdingballisticsweapon() {
  var0 = level.player getcurrentprimaryweapon();
  return issubstr(var0.basename, "ballistics");
}

function ballistics_aiignoreballisticsweaponpain() {
  self.fnshouldplaypainanim = &ballistics_wasainotdamagedbyplayerballisticsweapon;
}

function ballistics_wasaidamagedbyplayerballisticsweapon() {
  var0 = scripts\engine\utility::is_equal(self.lastattacker, level.player) && ballistics_playerholdingballisticsweapon();
  return var0;
}

function ballistics_wasainotdamagedbyplayerballisticsweapon() {
  return !ballistics_wasaidamagedbyplayerballisticsweapon();
}
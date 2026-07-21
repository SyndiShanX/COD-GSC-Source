/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\player\ballistics.gsc
***********************************************/

init_ballistics() {
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

ballistics_rotateflags() {
  var_0 = getEntArray("flag", "targetname");
  var_1 = level.ballistics.wind;

  for(;;) {
    if(level.ballistics.wind != var_1) {
      foreach(var_3 in var_0)
      var_3.angles = vectortoangles(level.ballistics.wind);
    }

    var_1 = level.ballistics.wind;
    waitframe();
  }
}

ballistics_weaponswitchmonitor() {
  var_0 = 0;

  for(;;) {
    level.player waittill("weapon_change");

    if(ballistics_playerholdingballisticsweapon() && !var_0) {
      var_0 = 1;
      ballistsglobalsettings(var_0);
      continue;
    }

    if(!ballistics_playerholdingballisticsweapon() && var_0) {
      var_0 = 0;
      ballistsglobalsettings(var_0);
    }
  }
}

ballistsglobalsettings(var_0) {
  if(var_0)
    setsaveddvar("MPPNTMTPTS", 0);
  else
    setsaveddvar("MPPNTMTPTS", 1);
}

ballistics_bulletfiremonitor() {
  level.player endon("death");

  for(;;) {
    level.player waittill("weapon_fired", var_0, var_1, var_2);

    if(!ballistics_playerholdingballisticsweapon()) {
      continue;
    }
    level.player firebullet(var_1, var_2);
  }
}

firebullet(var_0, var_1) {
  var_2 = (0, 0, 1);
  var_3 = anglesToForward(var_1) * getdvarint("ballistics_muzzleSpeed");
  var_4 = (0, 0, -300) + level.ballistics.wind;
  var_5 = 0.657895;
  var_6 = 0.0;
  var_7 = var_0;
  var_8 = ballistics_createbullet(var_0, var_1);
  var_9 = [];
  var_10 = 0;
  var_11 = 0.1;
  var_12 = anglesToForward(var_1) * -5 + anglestoup(var_1) * -2;
  var_13 = undefined;

  while(var_6 < var_5) {
    var_14 = var_7;
    var_7 = var_0 + var_3 * var_6 + 0.5 * var_4 * squared(var_6);
    var_15 = vectorNormalize(var_7 - var_14);
    var_16 = distance(var_7, var_14);
    var_8.origin = var_7 + var_12;
    var_12 = var_12 * 0.2;

    if(var_10)
      var_17 = scripts\engine\trace::create_contents(1);
    else
      var_17 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1);

    var_18 = scripts\engine\sp\utility::array_merge(level.ballistics.ignoreentities, var_9);
    var_19 = scripts\engine\trace::ray_trace_detail(var_14, var_7, var_18, var_17, 1, 1);
    var_20 = [var_19];

    if(getdvarint("debug_ballistics"))
      var_21 = scripts\engine\utility::ter_op(var_10, (1, 1, 0), (1, 0, 0));

    var_22 = var_6 >= var_11;

    if(var_22) {
      var_23 = vectorcross(var_15, var_2);
      var_24 = vectorcross(var_15, var_23);
      var_25 = var_24 * -1;
      var_26 = var_23 * -1;
      var_27 = [var_23, var_24, var_25, var_26];

      foreach(var_29 in var_27) {
        var_30 = var_14 + var_29 * 3.5;
        var_31 = var_30 + var_15 * var_16;
        var_32 = scripts\engine\trace::ray_trace_detail(var_30, var_31, var_18, var_17, 1, 1);
        var_20 = scripts\engine\utility::array_add(var_20, var_32);

        if(getdvarint("debug_ballistics")) {
          var_21 = scripts\engine\utility::ter_op(var_10, (1, 1, 0), (1, 0, 0));

          if(isDefined(var_13)) {}

          var_13 = var_8.origin;
        }
      }
    }

    var_34 = undefined;
    var_35 = undefined;
    var_36 = undefined;
    var_37 = undefined;

    foreach(var_32 in var_20) {
      if(var_32["fraction"] < 1) {
        if(isDefined(var_32["entity"]))
          var_18 = scripts\engine\utility::array_add(var_18, var_32["entity"]);

        var_34 = var_32["position"];
        var_35 = var_32["normal"];
        var_36 = var_32["entity"];
        var_37 = var_32["surfacetype"];
        break;
      }
    }

    if(isDefined(var_34)) {
      if(!var_10) {
        level notify("ballistics_impact", var_34);
        var_7 = var_14;
        var_10 = 1;
      }

      glassradiusdamage(var_34, 30, 99999, 9999);
      var_40 = var_34 + var_15 * -15;
      var_41 = var_34 + var_15 * 50;
      magicbullet("iw8_sn_hdromeo_ballistics_impact", var_40, var_41);

      if(getdvarint("debug_ballistics")) {}

      if(isDefined(var_36)) {
        var_36 notify("ballistics_bulletDamage", var_34);

        if(isai(var_36)) {
          if(!ballistics_shoulddamageai(var_36))
            playFX(level.g_effect["vfx_gib_explode"], var_34);
          else if(ballistics_shouldkillai(var_36)) {
            if(scripts\sp\gibbing::gibbing_shouldgibai(var_36))
              level.player thread scripts\sp\gibbing::gibbing_gibai(var_36, var_34, "MOD_RIFLE_BULLET");
            else
              level.player thread ballistics_killai(var_36, var_34);
          } else {
            var_36 scripts\sp\utility::do_damage(450, var_34, self, undefined, "MOD_RIFLE_BULLET");

            if(!scripts\engine\utility::is_equal(var_36.unittype, "juggernaut"))
              playFX(level.g_effect["vfx_gib_explode"], var_34);
          }
        } else {
          var_42 = isDefined(level.phys_barrels) && scripts\engine\utility::array_contains(level.phys_barrels, var_36);

          if(var_42)
            var_36 notify("barrel_death", level.player);
          else {
            if(var_36 isscriptable())
              radiusdamage(var_36.origin, 50, 200, 200, level.player, "MOD_RIFLE_BULLET");

            thread ballistics_impactvfxentitylogic(var_36, var_34, var_35);
          }
        }

        if(istrue(var_36.ballisticdontpenetrate)) {
          break;
        }
      } else {
        playFX(level.g_effect["vfx_ballistics_bullet_impact"], var_34 + var_35 * 0.75, var_35);
        physicsexplosionsphere(var_34, 128, 128, 75);
      }
    }

    var_6 = var_6 + 0.05;
    waitframe();
  }

  scripts\engine\utility::delaythread(0.05, ::ballistics_deletebullet, var_8);
}

ballistics_impactvfxentitylogic(var_0, var_1, var_2) {
  physicsexplosionsphere(var_1, 128, 128, 75);
  var_3 = var_2;
  var_1 = var_1 + var_3 * 0.75;
  var_4 = (0, 0, 1);
  var_5 = vectorcross(var_3, var_4);
  var_6 = vectorcross(var_3, var_5);
  var_7 = var_6 * -1;
  var_8 = axistoangles(var_3, var_5, var_7);
  var_9 = scripts\engine\utility::spawn_tag_origin(var_1, var_8);
  playFXOnTag(level.g_effect["vfx_ballistics_bullet_impact"], var_9, "tag_origin");
  thread ballistics_impactvfxentityparentlogic(var_0, var_9);
  var_0 endon("death");
  var_0 endon("entitydeleted");
  wait 5.0;
  killfxontag(level.g_effect["vfx_ballistics_bullet_impact"], var_9, "tag_origin");
  var_9 delete();
}

ballistics_impactvfxentityparentlogic(var_0, var_1) {
  var_1 endon("death");
  var_1 endon("entitydeleted");

  if(issubstr(tolower(var_0.code_classname), "script"))
    var_1 linkTo(var_0);

  var_0 scripts\engine\utility::waittill_any("death", "entitydeleted");
  killfxontag(level.g_effect["vfx_ballistics_bullet_impact"], var_1, "tag_origin");
  var_1 delete();
}

ballistics_createbullet(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2 setModel("ui_bullet_armor_piercing");
  var_2.angles = var_1;
  var_2 hide();
  var_2.vfxtag = scripts\engine\utility::spawn_tag_origin(var_2.origin, var_2.angles);
  var_2.vfxtag linkTo(var_2);
  thread ballistics_delaybulletvfx(var_2);
  thread ballistics_delaybulletshow(var_2);
  return var_2;
}

ballistics_delaybulletvfx(var_0) {
  var_0 endon("entitydeleted");
  var_0.vfxtag endon("entitydeleted");

  if(istrue(0.0))
    wait 0.0;

  playFXOnTag(level.g_effect["vfx_ballistics_bullet_trail"], var_0.vfxtag, "tag_origin");
}

ballistics_delaybulletshow(var_0) {
  var_0 endon("entitydeleted");

  if(istrue(0.075))
    wait 0.075;

  var_0 show();
}

ballistics_deletebullet(var_0) {
  var_0.vfxtag delete();
  var_0 delete();
}

ballistics_killai(var_0, var_1) {
  var_0 stopanimScripted();
  var_0 notify("stop_loop");
  playFX(level.g_effect["vfx_gib_explode"], var_1);
  var_0 scripts\sp\utility::do_damage(var_0.health + 9999, var_1, self, undefined, "MOD_RIFLE_BULLET");

  if(isPlayer(self) && istrue(var_0.magic_bullet_shield) && scripts\engine\utility::is_equal(self.team, var_0.team)) {
    scripts\sp\friendlyfire::missionfail(0);
    return;
  }
}

ballistics_shoulddamageai(var_0) {
  return !scripts\engine\utility::is_equal(var_0.script_parameters, "ballistics_doNotDamage");
}

ballistics_shouldkillai(var_0) {
  if(scripts\engine\utility::is_equal(var_0.unittype, "juggernaut"))
    return 0;

  return 1;
}

ballistics_doesbullettrajectoryhitentity(var_0, var_1, var_2, var_3) {
  var_4 = anglesToForward(var_1) * 38000;
  var_5 = (0, 0, -300);

  if(istrue(var_3))
    var_5 = var_5 + level.ballistics.wind;

  var_6 = 0.657895;
  var_7 = 0;
  var_8 = var_0;
  var_9 = [level.player];

  for(var_7 = 0; var_7 < var_6; var_7 = var_7 + 0.05) {
    var_10 = var_8;
    var_8 = var_0 + var_4 * var_7 + 0.5 * var_5 * squared(var_7);
    var_11 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 0, 0, 0);
    var_12 = scripts\engine\trace::ray_trace_detail(var_10, var_8, var_9, var_11, 0, 1);
    var_13 = var_12["fraction"];
    var_14 = var_12["entity"];

    if(var_13 != 1.0 && scripts\engine\utility::is_equal(var_14, var_2))
      return 1;

    var_7 = var_7 + 0.05;
  }

  return 0;
}

ballistics_playerholdingballisticsweapon() {
  var_0 = level.player getcurrentprimaryweapon();
  return issubstr(var_0.basename, "ballistics");
}

ballistics_aiignoreballisticsweaponpain() {
  self.fnshouldplaypainanim = ::ballistics_wasainotdamagedbyplayerballisticsweapon;
}

ballistics_wasaidamagedbyplayerballisticsweapon() {
  var_0 = scripts\engine\utility::is_equal(self.lastattacker, level.player) && ballistics_playerholdingballisticsweapon();
  return var_0;
}

ballistics_wasainotdamagedbyplayerballisticsweapon() {
  return !ballistics_wasaidamagedbyplayerballisticsweapon();
}
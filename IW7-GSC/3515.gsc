/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3515.gsc
***************************************/

init() {
  level.reminder_vo_init["laserTarget"] = loadfx("vfx\misc\laser_glow");
  level.reminder_vo_init["missileExplode"] = loadfx("vfx\core\expl\bouncing_betty_explosion");
  level.reminder_vo_init["deathExplode"] = loadfx("vfx\core\expl\uav_advanced_death");
  scripts\mp\killstreaks\killstreaks::registerkillstreak("remote_mortar", ::func_128FD);
  level.reminder_reaction_pointat = undefined;
}

func_128FD(var_00, var_01) {
  if(isDefined(level.reminder_reaction_pointat)) {
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  scripts\mp\utility\game::setusingremote("remote_mortar");
  var_02 = scripts\mp\killstreaks\killstreaks::initridekillstreak("remote_mortar");

  if(var_02 != "success") {
    if(var_02 != "disconnect")
      scripts\mp\utility\game::clearusingremote();

    return 0;
  } else if(isDefined(level.reminder_reaction_pointat)) {
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    scripts\mp\utility\game::clearusingremote();
    return 0;
  }

  scripts\mp\matchdata::logkillstreakevent("remote_mortar", self.origin);
  return func_10DE9(var_00);
}

func_10DE9(var_00) {
  var_01 = func_10906(var_00, self);

  if(!isDefined(var_01))
    return 0;

  level.reminder_reaction_pointat = var_01;
  func_DF87(var_01);
  thread scripts\mp\utility\game::teamplayercardsplash("used_remote_mortar", self);
  return 1;
}

func_10906(var_00, var_01) {
  var_02 = spawnplane(var_01, "script_model", level.func_12AF5 gettagorigin("tag_origin"), "compass_objpoint_reaper_friendly", "compass_objpoint_reaper_enemy");

  if(!isDefined(var_02))
    return undefined;

  var_02 setModel("vehicle_predator_b");
  var_2.lifeid = var_00;
  var_2.team = var_1.team;
  var_2.owner = var_01;
  var_2.numflares = 1;
  var_02 setCanDamage(1);
  var_02 thread damagetracker();
  var_2.helitype = "remote_mortar";
  var_2.uavtype = "remote_mortar";
  var_02 scripts\mp\killstreaks\uav::func_1867();
  var_03 = 6300;
  var_04 = randomint(360);
  var_05 = 6100;
  var_06 = cos(var_04) * var_05;
  var_07 = sin(var_04) * var_05;
  var_08 = vectornormalize((var_06, var_07, var_03));
  var_08 = var_08 * 6100;
  var_02 linkto(level.func_12AF5, "tag_origin", var_08, (0, var_04 - 90, 10));
  var_01 setclientdvar("ui_reaper_targetDistance", -1);
  var_01 setclientdvar("ui_reaper_ammoCount", 14);
  var_02 thread handledeath(var_01);
  var_02 thread func_89F3(var_01);
  var_02 thread func_89CE(var_01);
  var_02 thread func_89CF(var_01);
  var_02 thread func_89B7();
  var_02 thread func_89B6();
  return var_02;
}

func_B011(var_00) {
  self endon("disconnect");
  level endon("game_ended");
  var_00 endon("death");
  wait 0.05;
  var_01 = vectortoangles(level.func_12AF5.origin - var_00 gettagorigin("tag_player"));
  self setplayerangles(var_01);
}

func_DF87(var_00) {
  scripts\mp\utility\game::_giveweapon("mortar_remote_mp");
  scripts\mp\utility\game::_switchtoweapon("mortar_remote_mp");
  thread waitsetthermal(1.0, var_00);
  thread scripts\mp\utility\game::reinitializethermal(var_00);

  if(getdvarint("camera_thirdPerson"))
    scripts\mp\utility\game::setthirdpersondof(0);

  self getwholescenedurationmax(var_00, "tag_player", 1.0, 40, 40, 25, 40);
  thread func_B011(var_00);
  scripts\engine\utility::allow_weapon_switch(0);
  thread func_DF88(var_00);
  thread remotedetonateonset(var_00);
  thread func_DFB3(var_00);
}

waitsetthermal(var_00, var_01) {
  self endon("disconnect");
  var_01 endon("death");
  wait(var_00);
  self visionsetthermalforplayer(level.ac130.enhanced_vision, 0);
  self.lastvisionsetthermal = level.ac130.enhanced_vision;
  self thermalvisionfofoverlayon();
}

func_DF88(var_00) {
  level endon("game_ended");
  self endon("disconnect");
  var_00 endon("remote_done");
  var_00 endon("death");
  var_0.func_1155F = spawnfx(level.reminder_vo_init["laserTarget"], (0, 0, 0));

  for(;;) {
    var_01 = self getEye();
    var_02 = anglesToForward(self getplayerangles());
    var_03 = var_01 + var_02 * 15000;
    var_04 = bulletTrace(var_01, var_03, 0, var_0.func_1155F);

    if(isDefined(var_4["position"])) {
      var_0.func_1155F.origin = var_4["position"];
      triggerfx(var_0.func_1155F);
    }

    wait 0.05;
  }
}

remotedetonateonset(var_00) {
  level endon("game_ended");
  self endon("disconnect");
  var_00 endon("remote_done");
  var_00 endon("death");
  var_01 = gettime();
  var_02 = var_01 - 2200;
  var_03 = 14;
  self.func_6DB6 = 0;

  for(;;) {
    var_01 = gettime();

    if(self attackbuttonpressed() && var_01 - var_02 > 3000) {
      var_3--;
      self setclientdvar("ui_reaper_ammoCount", var_03);
      var_02 = var_01;
      self.func_6DB6 = 1;
      self playlocalsound("reaper_fire");
      self playrumbleonentity("damage_heavy");
      var_04 = self getEye();
      var_05 = anglesToForward(self getplayerangles());
      var_06 = anglestoright(self getplayerangles());
      var_07 = var_04 + var_05 * 100 + var_06 * -100;
      var_08 = scripts\mp\utility\game::_magicbullet("remote_mortar_missile_mp", var_07, var_0.func_1155F.origin, self);
      var_8.type = "remote_mortar";
      earthquake(0.3, 0.5, var_04, 256);
      var_08 missile_settargetent(var_0.func_1155F);
      var_08 missile_setflightmodedirect();
      var_08 thread remotemissile_fx(var_00);
      var_08 thread func_DF81(var_00);
      var_08 waittill("death");
      self setclientdvar("ui_reaper_targetDistance", -1);
      self.func_6DB6 = 0;

      if(var_03 == 0) {
        break;
      }
    } else
      wait 0.05;
  }

  self notify("removed_reaper_ammo");
  remotedefusesetup(var_00);
  var_00 thread remoteinfo();
}

func_89F4(var_00) {
  level endon("game_ended");
  self endon("disconnect");
  var_00 endon("remote_done");
  var_00 endon("death");
  self notifyonplayercommand("remote_mortar_toggleZoom1", "+ads_akimbo_accessible");

  if(!level.console)
    self notifyonplayercommand("remote_mortar_toggleZoom1", "+toggleads_throw");

  for(;;) {
    var_01 = scripts\engine\utility::waittill_any_return("remote_mortar_toggleZoom1");

    if(!isDefined(self.remote_detonation_monitor))
      self.remote_detonation_monitor = 0;

    self.remote_detonation_monitor = 1 - self.remote_detonation_monitor;
  }
}

func_DFB3(var_00) {
  level endon("game_ended");
  self endon("disconnect");
  var_00 endon("remote_done");
  var_00 endon("death");
  self.remote_detonation_monitor = undefined;
  thread func_89F4(var_00);
  var_0.func_13FCA = 0;
  var_01 = 0;

  for(;;) {
    if(self adsbuttonpressed()) {
      wait 0.05;

      if(isDefined(self.remote_detonation_monitor))
        var_01 = 1;

      break;
    }

    wait 0.05;
  }

  for(;;) {
    if(!var_01 && self adsbuttonpressed() || var_01 && self.remote_detonation_monitor) {
      if(var_0.func_13FCA == 0) {
        scripts\mp\utility\game::_giveweapon("mortar_remote_zoom_mp");
        scripts\mp\utility\game::_switchtoweapon("mortar_remote_zoom_mp");
        var_0.func_13FCA = 1;
      }
    } else if(!var_01 && !self adsbuttonpressed() || var_01 && !self.remote_detonation_monitor) {
      if(var_0.func_13FCA == 1) {
        scripts\mp\utility\game::_giveweapon("mortar_remote_mp");
        scripts\mp\utility\game::_switchtoweapon("mortar_remote_mp");
        var_0.func_13FCA = 0;
      }
    }

    wait 0.05;
  }
}

remotemissile_fx(var_00) {
  level endon("game_ended");
  var_00 endon("death");
  var_00 endon("remote_done");
  self endon("death");

  for(;;) {
    var_01 = distance(self.origin, var_0.func_1155F.origin);
    var_0.owner setclientdvar("ui_reaper_targetDistance", int(var_01 / 12));
    wait 0.05;
  }
}

func_DF81(var_00) {
  self endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(6);
  playFX(level.reminder_vo_init["missileExplode"], self.origin);
  self delete();
}

remotedefusesetup(var_00) {
  if(!scripts\mp\utility\game::isusingremote()) {
    return;
  }
  if(isDefined(var_00))
    var_00 notify("helicopter_done");

  self thermalvisionoff();
  self thermalvisionfofoverlayoff();
  self visionsetthermalforplayer(game["thermal_vision"], 0);
  scripts\mp\utility\game::restorebasevisionset(0);
  self unlink();
  scripts\mp\utility\game::clearusingremote();

  if(getdvarint("camera_thirdPerson"))
    scripts\mp\utility\game::setthirdpersondof(1);

  scripts\mp\utility\game::_switchtoweapon(scripts\engine\utility::getlastweapon());
  var_01 = scripts\mp\utility\game::getkillstreakweapon("remote_mortar");
  scripts\mp\utility\game::_takeweapon(var_01);
  scripts\mp\utility\game::_takeweapon("mortar_remote_zoom_mp");
  scripts\mp\utility\game::_takeweapon("mortar_remote_mp");
  scripts\engine\utility::allow_weapon_switch(1);
}

func_89F3(var_00) {
  level endon("game_ended");
  var_00 endon("disconnect");
  var_00 endon("removed_reaper_ammo");
  self endon("death");
  var_01 = 40.0;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_01);

  while(var_0.func_6DB6)
    wait 0.05;

  if(isDefined(var_00))
    var_00 remotedefusesetup(self);

  thread remoteinfo();
}

handledeath(var_00) {
  level endon("game_ended");
  var_00 endon("disconnect");
  self endon("remote_removed");
  self endon("remote_done");
  self waittill("death");

  if(isDefined(var_00))
    var_00 remotedefusesetup(self);

  level thread func_E161(self, 1);
}

func_89CE(var_00) {
  level endon("game_ended");
  self endon("remote_done");
  self endon("death");
  var_00 endon("disconnect");
  var_00 endon("removed_reaper_ammo");
  var_00 scripts\engine\utility::waittill_any("joined_team", "joined_spectators");

  if(isDefined(var_00))
    var_00 remotedefusesetup(self);

  thread remoteinfo();
}

func_89CF(var_00) {
  level endon("game_ended");
  self endon("remote_done");
  self endon("death");
  var_00 endon("removed_reaper_ammo");
  var_00 waittill("disconnect");
  thread remoteinfo();
}

func_E161(var_00, var_01) {
  self notify("remote_removed");

  if(isDefined(var_0.func_1155F))
    var_0.func_1155F delete();

  if(isDefined(var_00)) {
    var_00 delete();
    var_00 scripts\mp\killstreaks\uav::func_E182();
  }

  if(!isDefined(var_01) || var_01 == 1)
    level.reminder_reaction_pointat = undefined;
}

remoteinfo() {
  level.reminder_reaction_pointat = undefined;
  level endon("game_ended");
  self endon("death");
  self notify("remote_done");
  self unlink();
  var_00 = self.origin + anglesToForward(self.angles) * 20000;
  self moveto(var_00, 30);
  playFXOnTag(level._effect["ac130_engineeffect"], self, "tag_origin");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(3);
  self moveto(var_00, 4, 4, 0.0);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(4);
  level thread func_E161(self, 0);
}

remotedetonatebeginuse() {
  self notify("death");
  self hide();
  var_00 = anglestoright(self.angles) * 200;
  playFX(level.reminder_vo_init["deathExplode"], self.origin, var_00);
}

damagetracker() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self.health = 999999;
  self.maxhealth = 1500;
  self.damagetaken = 0;

  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);

    if(!scripts\mp\weapons::friendlyfirecheck(self.owner, var_01)) {
      continue;
    }
    if(!isDefined(self)) {
      return;
    }
    if(isDefined(var_08) && var_08 &level.idflags_penetration)
      self.wasdamagedfrombulletpenetration = 1;

    if(isDefined(var_08) && var_08 &level.idflags_no_team_protection)
      self.wasdamagedfrombulletricochet = 1;

    self.wasdamaged = 1;
    var_10 = var_00;

    if(isplayer(var_01)) {
      var_01 scripts\mp\damagefeedback::updatedamagefeedback("");

      if(var_04 == "MOD_RIFLE_BULLET" || var_04 == "MOD_PISTOL_BULLET") {
        if(var_01 scripts\mp\utility\game::_hasperk("specialty_armorpiercing"))
          var_10 = var_10 + var_00 * level.armorpiercingmod;
      }
    }

    if(isDefined(var_09)) {
      switch (var_09) {
        case "javelin_mp":
        case "stinger_mp":
          self.largeprojectiledamage = 1;
          var_10 = self.maxhealth + 1;
          break;
        case "sam_projectile_mp":
          self.largeprojectiledamage = 1;
          break;
      }

      scripts\mp\killstreaks\killstreaks::killstreakhit(var_01, var_09, self);
    }

    self.damagetaken = self.damagetaken + var_10;

    if(isDefined(self.owner))
      self.owner playlocalsound("reaper_damaged");

    if(self.damagetaken >= self.maxhealth) {
      if(isplayer(var_01) && (!isDefined(self.owner) || var_01 != self.owner)) {
        var_01 notify("destroyed_killstreak", var_09);
        thread scripts\mp\utility\game::teamplayercardsplash("callout_destroyed_remote_mortar", var_01);
        var_01 thread scripts\mp\utility\game::giveunifiedpoints("kill", var_09, 50);
      }

      if(isDefined(self.owner))
        self.owner stopolcalsound("missile_incoming");

      thread remotedetonatebeginuse();
      level.reminder_reaction_pointat = undefined;
      return;
    }
  }
}

func_89B7() {
  level endon("game_ended");
  self endon("death");
  self endon("remote_done");

  for(;;) {
    level waittill("stinger_fired", var_00, var_01, var_02);

    if(!isDefined(var_02) || var_02 != self) {
      continue;
    }
    var_01 thread func_10FA8(var_02, var_00);
  }
}

func_10FA8(var_00, var_01) {
  self endon("death");
  var_00 endon("death");

  if(isDefined(var_0.owner))
    var_0.owner playlocalsound("missile_incoming");

  self missile_settargetent(var_00);
  var_02 = distance(self.origin, var_00 getpointinbounds(0, 0, 0));
  var_03 = var_00 getpointinbounds(0, 0, 0);

  for(;;) {
    if(!isDefined(var_00))
      var_04 = var_03;
    else
      var_04 = var_00 getpointinbounds(0, 0, 0);

    var_03 = var_04;
    var_05 = distance(self.origin, var_04);

    if(var_05 < 3000 && var_0.numflares > 0) {
      var_0.numflares--;
      var_00 thread scripts\mp\killstreaks\flares::func_6EAE();
      var_06 = var_00 scripts\mp\killstreaks\flares::func_6EA0();
      self missile_settargetent(var_06);
      var_00 = var_06;

      if(isDefined(var_0.owner))
        var_0.owner stopolcalsound("missile_incoming");

      return;
    }

    if(var_05 < var_02)
      var_02 = var_05;

    if(var_05 > var_02) {
      if(var_05 > 1536) {
        return;
      }
      if(isDefined(var_0.owner)) {
        var_0.owner stopolcalsound("missile_incoming");

        if(level.teambased) {
          if(var_0.team != var_1.team)
            radiusdamage(self.origin, 1000, 1000, 1000, var_01, "MOD_EXPLOSIVE", "stinger_mp");
        } else
          radiusdamage(self.origin, 1000, 1000, 1000, var_01, "MOD_EXPLOSIVE", "stinger_mp");
      }

      self hide();
      wait 0.05;
      self delete();
    }

    wait 0.05;
  }
}

func_89B6() {
  level endon("game_ended");
  self endon("death");
  self endon("remote_done");

  for(;;) {
    level waittill("sam_fired", var_00, var_01, var_02);

    if(!isDefined(var_02) || var_02 != self) {
      continue;
    }
    level thread func_EB18(var_02, var_00, var_01);
  }
}

func_EB18(var_00, var_01, var_02) {
  var_00 endon("death");

  if(isDefined(var_0.owner))
    var_0.owner playlocalsound("missile_incoming");

  var_03 = 150;
  var_04 = 1000;
  var_05 = [];

  for(var_06 = 0; var_06 < var_2.size; var_6++) {
    if(isDefined(var_2[var_06])) {
      var_5[var_06] = distance(var_2[var_06].origin, var_00 getpointinbounds(0, 0, 0));
      continue;
    }

    var_5[var_06] = undefined;
  }

  for(;;) {
    var_07 = var_00 getpointinbounds(0, 0, 0);
    var_08 = [];

    for(var_06 = 0; var_06 < var_2.size; var_6++) {
      if(isDefined(var_2[var_06]))
        var_8[var_06] = distance(var_2[var_06].origin, var_07);
    }

    for(var_06 = 0; var_06 < var_8.size; var_6++) {
      if(isDefined(var_8[var_06])) {
        if(var_8[var_06] < 3000 && var_0.numflares > 0) {
          var_0.numflares--;
          var_00 thread scripts\mp\killstreaks\flares::func_6EAE();
          var_09 = var_00 scripts\mp\killstreaks\flares::func_6EA0();

          for(var_10 = 0; var_10 < var_2.size; var_10++) {
            if(isDefined(var_2[var_10]))
              var_2[var_10] missile_settargetent(var_09);
          }

          if(isDefined(var_0.owner))
            var_0.owner stopolcalsound("missile_incoming");

          return;
        }

        if(var_8[var_06] < var_5[var_06])
          var_5[var_06] = var_8[var_06];

        if(var_8[var_06] > var_5[var_06]) {
          if(var_8[var_06] > 1536) {
            continue;
          }
          if(isDefined(var_0.owner)) {
            var_0.owner stopolcalsound("missile_incoming");

            if(level.teambased) {
              if(var_0.team != var_1.team)
                radiusdamage(var_2[var_06].origin, var_04, var_03, var_03, var_01, "MOD_EXPLOSIVE", "sam_projectile_mp");
            } else
              radiusdamage(var_2[var_06].origin, var_04, var_03, var_03, var_01, "MOD_EXPLOSIVE", "sam_projectile_mp");
          }

          var_2[var_06] hide();
          wait 0.05;
          var_2[var_06] delete();
        }
      }
    }

    wait 0.05;
  }
}
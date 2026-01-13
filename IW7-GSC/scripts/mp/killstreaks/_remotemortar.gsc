/****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_remotemortar.gsc
****************************************************/

init() {
  level.reminder_vo_init["laserTarget"] = loadfx("vfx\misc\laser_glow");
  level.reminder_vo_init["missileExplode"] = loadfx("vfx\core\expl\bouncing_betty_explosion");
  level.reminder_vo_init["deathExplode"] = loadfx("vfx\core\expl\uav_advanced_death");
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("remote_mortar", ::func_128FD);
  level.reminder_reaction_pointat = undefined;
}

func_128FD(var_0, var_1) {
  if(isDefined(level.reminder_reaction_pointat)) {
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  scripts\mp\utility::setusingremote("remote_mortar");
  var_2 = scripts\mp\killstreaks\_killstreaks::initridekillstreak("remote_mortar");
  if(var_2 != "success") {
    if(var_2 != "disconnect") {
      scripts\mp\utility::clearusingremote();
    }

    return 0;
  } else if(isDefined(level.reminder_reaction_pointat)) {
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    scripts\mp\utility::clearusingremote();
    return 0;
  }

  scripts\mp\matchdata::logkillstreakevent("remote_mortar", self.origin);
  return func_10DE9(var_0);
}

func_10DE9(var_0) {
  var_1 = func_10906(var_0, self);
  if(!isDefined(var_1)) {
    return 0;
  }

  level.reminder_reaction_pointat = var_1;
  func_DF87(var_1);
  thread scripts\mp\utility::teamplayercardsplash("used_remote_mortar", self);
  return 1;
}

func_10906(var_0, var_1) {
  var_2 = spawnplane(var_1, "script_model", level.var_12AF5 gettagorigin("tag_origin"), "compass_objpoint_reaper_friendly", "compass_objpoint_reaper_enemy");
  if(!isDefined(var_2)) {
    return undefined;
  }

  var_2 setModel("vehicle_predator_b");
  var_2.lifeid = var_0;
  var_2.team = var_1.team;
  var_2.triggerportableradarping = var_1;
  var_2.numflares = 1;
  var_2 setCanDamage(1);
  var_2 thread damagetracker();
  var_2.helitype = "remote_mortar";
  var_2.uavtype = "remote_mortar";
  var_2 scripts\mp\killstreaks\_uav::func_1867();
  var_3 = 6300;
  var_4 = randomint(360);
  var_5 = 6100;
  var_6 = cos(var_4) * var_5;
  var_7 = sin(var_4) * var_5;
  var_8 = vectornormalize((var_6, var_7, var_3));
  var_8 = var_8 * 6100;
  var_2 linkto(level.var_12AF5, "tag_origin", var_8, (0, var_4 - 90, 10));
  var_1 setclientdvar("ui_reaper_targetDistance", -1);
  var_1 setclientdvar("ui_reaper_ammoCount", 14);
  var_2 thread handledeath(var_1);
  var_2 thread func_89F3(var_1);
  var_2 thread func_89CE(var_1);
  var_2 thread func_89CF(var_1);
  var_2 thread func_89B7();
  var_2 thread func_89B6();
  return var_2;
}

func_B011(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  var_0 endon("death");
  wait(0.05);
  var_1 = vectortoangles(level.var_12AF5.origin - var_0 gettagorigin("tag_player"));
  self setplayerangles(var_1);
}

func_DF87(var_0) {
  scripts\mp\utility::_giveweapon("mortar_remote_mp");
  scripts\mp\utility::_switchtoweapon("mortar_remote_mp");
  thread waitsetthermal(1, var_0);
  thread scripts\mp\utility::reinitializethermal(var_0);
  if(getdvarint("camera_thirdPerson")) {
    scripts\mp\utility::setthirdpersondof(0);
  }

  self playerlinkweaponviewtodelta(var_0, "tag_player", 1, 40, 40, 25, 40);
  thread func_B011(var_0);
  scripts\engine\utility::allow_weapon_switch(0);
  thread func_DF88(var_0);
  thread remotedetonateonset(var_0);
  thread func_DFB3(var_0);
}

waitsetthermal(var_0, var_1) {
  self endon("disconnect");
  var_1 endon("death");
  wait(var_0);
  self visionsetthermalforplayer(level.ac130.enhanced_vision, 0);
  self.lastvisionsetthermal = level.ac130.enhanced_vision;
  self thermalvisionfofoverlayon();
}

func_DF88(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 endon("remote_done");
  var_0 endon("death");
  var_0.var_1155F = spawnfx(level.reminder_vo_init["laserTarget"], (0, 0, 0));
  for(;;) {
    var_1 = self getEye();
    var_2 = anglesToForward(self getplayerangles());
    var_3 = var_1 + var_2 * 15000;
    var_4 = bulletTrace(var_1, var_3, 0, var_0.var_1155F);
    if(isDefined(var_4["position"])) {
      var_0.var_1155F.origin = var_4["position"];
      triggerfx(var_0.var_1155F);
    }

    wait(0.05);
  }
}

remotedetonateonset(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 endon("remote_done");
  var_0 endon("death");
  var_1 = gettime();
  var_2 = var_1 - 2200;
  var_3 = 14;
  self.var_6DB6 = 0;
  for(;;) {
    var_1 = gettime();
    if(self attackbuttonpressed() && var_1 - var_2 > 3000) {
      var_3--;
      self setclientdvar("ui_reaper_ammoCount", var_3);
      var_2 = var_1;
      self.var_6DB6 = 1;
      self playlocalsound("reaper_fire");
      self playrumbleonentity("damage_heavy");
      var_4 = self getEye();
      var_5 = anglesToForward(self getplayerangles());
      var_6 = anglestoright(self getplayerangles());
      var_7 = var_4 + var_5 * 100 + var_6 * -100;
      var_8 = scripts\mp\utility::_magicbullet("remote_mortar_missile_mp", var_7, var_0.var_1155F.origin, self);
      var_8.type = "remote_mortar";
      earthquake(0.3, 0.5, var_4, 256);
      var_8 missile_settargetent(var_0.var_1155F);
      var_8 missile_setflightmodedirect();
      var_8 thread remotemissile_fx(var_0);
      var_8 thread func_DF81(var_0);
      var_8 waittill("death");
      self setclientdvar("ui_reaper_targetDistance", -1);
      self.var_6DB6 = 0;
      if(var_3 == 0) {
        break;
      }

      continue;
    }

    wait(0.05);
  }

  self notify("removed_reaper_ammo");
  remotedefusesetup(var_0);
  var_0 thread remoteinfo();
}

func_89F4(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 endon("remote_done");
  var_0 endon("death");
  self notifyonplayercommand("remote_mortar_toggleZoom1", "+ads_akimbo_accessible");
  if(!level.console) {
    self notifyonplayercommand("remote_mortar_toggleZoom1", "+toggleads_throw");
  }

  for(;;) {
    var_1 = scripts\engine\utility::waittill_any_return("remote_mortar_toggleZoom1");
    if(!isDefined(self.remote_detonation_monitor)) {
      self.remote_detonation_monitor = 0;
    }

    self.remote_detonation_monitor = 1 - self.remote_detonation_monitor;
  }
}

func_DFB3(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 endon("remote_done");
  var_0 endon("death");
  self.remote_detonation_monitor = undefined;
  thread func_89F4(var_0);
  var_0.var_13FCA = 0;
  var_1 = 0;
  for(;;) {
    if(self adsbuttonpressed()) {
      wait(0.05);
      if(isDefined(self.remote_detonation_monitor)) {
        var_1 = 1;
      }

      break;
    }

    wait(0.05);
  }

  for(;;) {
    if((!var_1 && self adsbuttonpressed()) || var_1 && self.remote_detonation_monitor) {
      if(var_0.var_13FCA == 0) {
        scripts\mp\utility::_giveweapon("mortar_remote_zoom_mp");
        scripts\mp\utility::_switchtoweapon("mortar_remote_zoom_mp");
        var_0.var_13FCA = 1;
      }
    } else if((!var_1 && !self adsbuttonpressed()) || var_1 && !self.remote_detonation_monitor) {
      if(var_0.var_13FCA == 1) {
        scripts\mp\utility::_giveweapon("mortar_remote_mp");
        scripts\mp\utility::_switchtoweapon("mortar_remote_mp");
        var_0.var_13FCA = 0;
      }
    }

    wait(0.05);
  }
}

remotemissile_fx(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("remote_done");
  self endon("death");
  for(;;) {
    var_1 = distance(self.origin, var_0.var_1155F.origin);
    var_0.triggerportableradarping setclientdvar("ui_reaper_targetDistance", int(var_1 / 12));
    wait(0.05);
  }
}

func_DF81(var_0) {
  self endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(6);
  playFX(level.reminder_vo_init["missileExplode"], self.origin);
  self delete();
}

remotedefusesetup(var_0) {
  if(!scripts\mp\utility::isusingremote()) {
    return;
  }

  if(isDefined(var_0)) {
    var_0 notify("helicopter_done");
  }

  self thermalvisionoff();
  self thermalvisionfofoverlayoff();
  self visionsetthermalforplayer(game["thermal_vision"], 0);
  scripts\mp\utility::restorebasevisionset(0);
  self unlink();
  scripts\mp\utility::clearusingremote();
  if(getdvarint("camera_thirdPerson")) {
    scripts\mp\utility::setthirdpersondof(1);
  }

  scripts\mp\utility::_switchtoweapon(scripts\engine\utility::getlastweapon());
  var_1 = scripts\mp\utility::getkillstreakweapon("remote_mortar");
  scripts\mp\utility::_takeweapon(var_1);
  scripts\mp\utility::_takeweapon("mortar_remote_zoom_mp");
  scripts\mp\utility::_takeweapon("mortar_remote_mp");
  scripts\engine\utility::allow_weapon_switch(1);
}

func_89F3(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("removed_reaper_ammo");
  self endon("death");
  var_1 = 40;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_1);
  while(var_0.var_6DB6) {
    wait(0.05);
  }

  if(isDefined(var_0)) {
    var_0 remotedefusesetup(self);
  }

  thread remoteinfo();
}

handledeath(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  self endon("remote_removed");
  self endon("remote_done");
  self waittill("death");
  if(isDefined(var_0)) {
    var_0 remotedefusesetup(self);
  }

  level thread func_E161(self, 1);
}

func_89CE(var_0) {
  level endon("game_ended");
  self endon("remote_done");
  self endon("death");
  var_0 endon("disconnect");
  var_0 endon("removed_reaper_ammo");
  var_0 scripts\engine\utility::waittill_any_3("joined_team", "joined_spectators");
  if(isDefined(var_0)) {
    var_0 remotedefusesetup(self);
  }

  thread remoteinfo();
}

func_89CF(var_0) {
  level endon("game_ended");
  self endon("remote_done");
  self endon("death");
  var_0 endon("removed_reaper_ammo");
  var_0 waittill("disconnect");
  thread remoteinfo();
}

func_E161(var_0, var_1) {
  self notify("remote_removed");
  if(isDefined(var_0.var_1155F)) {
    var_0.var_1155F delete();
  }

  if(isDefined(var_0)) {
    var_0 delete();
    var_0 scripts\mp\killstreaks\_uav::func_E182();
  }

  if(!isDefined(var_1) || var_1 == 1) {
    level.reminder_reaction_pointat = undefined;
  }
}

remoteinfo() {
  level.reminder_reaction_pointat = undefined;
  level endon("game_ended");
  self endon("death");
  self notify("remote_done");
  self unlink();
  var_0 = self.origin + anglesToForward(self.angles) * 20000;
  self moveto(var_0, 30);
  playFXOnTag(level._effect["ac130_engineeffect"], self, "tag_origin");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(3);
  self moveto(var_0, 4, 4, 0);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(4);
  level thread func_E161(self, 0);
}

remotedetonatebeginuse() {
  self notify("death");
  self hide();
  var_0 = anglestoright(self.angles) * 200;
  playFX(level.reminder_vo_init["deathExplode"], self.origin, var_0);
}

damagetracker() {
  level endon("game_ended");
  self.triggerportableradarping endon("disconnect");
  self.health = 999999;
  self.maxhealth = 1500;
  self.var_E1 = 0;
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    if(!scripts\mp\weapons::friendlyfirecheck(self.triggerportableradarping, var_1)) {
      continue;
    }

    if(!isDefined(self)) {
      return;
    }

    if(isDefined(var_8) && var_8 &level.idflags_penetration) {
      self.wasdamagedfrombulletpenetration = 1;
    }

    if(isDefined(var_8) && var_8 &level.idflags_ricochet) {
      self.wasdamagedfrombulletricochet = 1;
    }

    self.wasdamaged = 1;
    var_0A = var_0;
    if(isplayer(var_1)) {
      var_1 scripts\mp\damagefeedback::updatedamagefeedback("");
      if(var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_PISTOL_BULLET") {
        if(var_1 scripts\mp\utility::_hasperk("specialty_armorpiercing")) {
          var_0A = var_0A + var_0 * level.armorpiercingmod;
        }
      }
    }

    if(isDefined(var_9)) {
      switch (var_9) {
        case "javelin_mp":
        case "stinger_mp":
          self.largeprojectiledamage = 1;
          var_0A = self.maxhealth + 1;
          break;

        case "sam_projectile_mp":
          self.largeprojectiledamage = 1;
          break;
      }

      scripts\mp\killstreaks\_killstreaks::killstreakhit(var_1, var_9, self);
    }

    self.var_E1 = self.var_E1 + var_0A;
    if(isDefined(self.triggerportableradarping)) {
      self.triggerportableradarping playlocalsound("reaper_damaged");
    }

    if(self.var_E1 >= self.maxhealth) {
      if(isplayer(var_1) && !isDefined(self.triggerportableradarping) || var_1 != self.triggerportableradarping) {
        var_1 notify("destroyed_killstreak", var_9);
        thread scripts\mp\utility::teamplayercardsplash("callout_destroyed_remote_mortar", var_1);
        var_1 thread scripts\mp\utility::giveunifiedpoints("kill", var_9, 50);
      }

      if(isDefined(self.triggerportableradarping)) {
        self.triggerportableradarping stoplocalsound("missile_incoming");
      }

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
    level waittill("stinger_fired", var_0, var_1, var_2);
    if(!isDefined(var_2) || var_2 != self) {
      continue;
    }

    var_1 thread func_10FA8(var_2, var_0);
  }
}

func_10FA8(var_0, var_1) {
  self endon("death");
  var_0 endon("death");
  if(isDefined(var_0.triggerportableradarping)) {
    var_0.triggerportableradarping playlocalsound("missile_incoming");
  }

  self missile_settargetent(var_0);
  var_2 = distance(self.origin, var_0 getpointinbounds(0, 0, 0));
  var_3 = var_0 getpointinbounds(0, 0, 0);
  for(;;) {
    if(!isDefined(var_0)) {
      var_4 = var_3;
    } else {
      var_4 = var_0 getpointinbounds(0, 0, 0);
    }

    var_3 = var_4;
    var_5 = distance(self.origin, var_4);
    if(var_5 < 3000 && var_0.numflares > 0) {
      var_0.numflares--;
      var_0 thread scripts\mp\killstreaks\_flares::func_6EAE();
      var_6 = var_0 scripts\mp\killstreaks\_flares::func_6EA0();
      self missile_settargetent(var_6);
      var_0 = var_6;
      if(isDefined(var_0.triggerportableradarping)) {
        var_0.triggerportableradarping stoplocalsound("missile_incoming");
      }

      return;
    }

    if(var_6 < var_3) {
      var_3 = var_6;
    }

    if(var_6 > var_3) {
      if(var_6 > 1536) {
        return;
      }

      if(isDefined(var_1.triggerportableradarping)) {
        var_1.triggerportableradarping stoplocalsound("missile_incoming");
        if(level.teambased) {
          if(var_1.team != var_2.team) {
            radiusdamage(self.origin, 1000, 1000, 1000, var_2, "MOD_EXPLOSIVE", "stinger_mp");
          }
        } else {
          radiusdamage(self.origin, 1000, 1000, 1000, var_2, "MOD_EXPLOSIVE", "stinger_mp");
        }
      }

      self hide();
      wait(0.05);
      self delete();
    }

    wait(0.05);
  }
}

func_89B6() {
  level endon("game_ended");
  self endon("death");
  self endon("remote_done");
  for(;;) {
    level waittill("sam_fired", var_0, var_1, var_2);
    if(!isDefined(var_2) || var_2 != self) {
      continue;
    }

    level thread func_EB18(var_2, var_0, var_1);
  }
}

func_EB18(var_0, var_1, var_2) {
  var_0 endon("death");
  if(isDefined(var_0.triggerportableradarping)) {
    var_0.triggerportableradarping playlocalsound("missile_incoming");
  }

  var_3 = 150;
  var_4 = 1000;
  var_5 = [];
  for(var_6 = 0; var_6 < var_2.size; var_6++) {
    if(isDefined(var_2[var_6])) {
      var_5[var_6] = distance(var_2[var_6].origin, var_0 getpointinbounds(0, 0, 0));
      continue;
    }

    var_5[var_6] = undefined;
  }

  for(;;) {
    var_7 = var_0 getpointinbounds(0, 0, 0);
    var_8 = [];
    for(var_6 = 0; var_6 < var_2.size; var_6++) {
      if(isDefined(var_2[var_6])) {
        var_8[var_6] = distance(var_2[var_6].origin, var_7);
      }
    }

    var_6 = 0;
    while(var_6 < var_8.size) {
      if(isDefined(var_8[var_6])) {
        if(var_8[var_6] < 3000 && var_0.numflares > 0) {
          var_0.numflares--;
          var_0 thread scripts\mp\killstreaks\_flares::func_6EAE();
          var_9 = var_0 scripts\mp\killstreaks\_flares::func_6EA0();
          for(var_0A = 0; var_0A < var_2.size; var_0A++) {
            if(isDefined(var_2[var_0A])) {
              var_2[var_0A] missile_settargetent(var_9);
            }
          }

          if(isDefined(var_0.triggerportableradarping)) {
            var_0.triggerportableradarping stoplocalsound("missile_incoming");
          }

          return;
        }

        if(var_0A[var_8] < var_7[var_8]) {
          var_7[var_8] = var_0A[var_8];
        }

        if(var_0A[var_8] > var_7[var_8]) {
          if(var_0A[var_8] > 1536) {
            continue;
          }

          if(isDefined(var_2.triggerportableradarping)) {
            var_2.triggerportableradarping stoplocalsound("missile_incoming");
            if(level.teambased) {
              if(var_2.team != var_3.team) {
                radiusdamage(var_4[var_8].origin, var_6, var_5, var_5, var_3, "MOD_EXPLOSIVE", "sam_projectile_mp");
              }
            } else {
              radiusdamage(var_4[var_8].origin, var_6, var_5, var_5, var_3, "MOD_EXPLOSIVE", "sam_projectile_mp");
            }
          }

          var_4[var_8] hide();
          wait(0.05);
          var_4[var_8] delete();
        }
      }

      var_8++;
    }

    wait(0.05);
  }
}
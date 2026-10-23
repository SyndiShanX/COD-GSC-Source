/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_equipment.gsc
****************************************************/

watchtrophyusage(var_0) {
  self endon("spawned_player");
  self endon("disconnect");
  self.trophyarray = [];

  for(;;) {
    self waittill("grenade_fire", var_1, var_2);

    if(var_2 == "trophy" || var_2 == "trophy_mp") {
      if(!isalive(self)) {
        var_1 delete();
        return;
      }

      if(!isDefined(var_0) || var_0 == 0) {
        var_1 hide();
      }

      var_1 waittill("missile_stuck");

      if(!isDefined(var_0) || var_0 == 0) {
        var_3 = 40;

        if(var_3 * var_3 < distancesquared(var_1.origin, self.origin)) {
          var_4 = bulletTrace(self.origin, self.origin - (0, 0, var_3), 0, self);

          if(var_4["fraction"] == 1) {
            var_1 delete();
            self setweaponammostock("trophy_mp", self getweaponammostock("trophy_mp") + 1);
            continue;
          }

          var_1.origin = var_4["position"];
        }

        var_1 show();
      }

      self.trophyarray = common_scripts\utility::_id_0FA0(self.trophyarray);

      if(self.trophyarray.size >= level.maxperplayerexplosives) {
        self.trophyarray[0] thread trophybreak();
      }

      var_5 = spawn("script_model", var_1.origin);
      var_5 setModel("mp_trophy_system");
      var_5 thread _id_0513::createbombsquadmodel("mp_trophy_system_bombsquad", "tag_origin", self);
      var_5.angles = var_1.angles;
      self.trophyarray[self.trophyarray.size] = var_5;
      var_5._id_0117 = self;
      var_5.team = self.team;
      var_5.weaponname = var_2;
      var_5.stunned = 0;
      level.trophies[level.trophies.size] = var_5;

      if(isDefined(self.trophyremainingammo) && self.trophyremainingammo > 0) {
        var_5._id_0D95 = self.trophyremainingammo;
      } else {
        var_5._id_0D95 = 2;
      }

      var_5.trigger = spawn("script_origin", var_5.origin);
      var_5 thread trophydamage(self);
      var_5 thread trophyactive(self);
      var_5 thread trophydisconnectwaiter(self);
      var_5 thread trophyplayerspawnwaiter(self);
      var_5 thread trophyuselistener(self);
      var_5 thread _id_0513::c4empkillstreakwait();

      if(level.teambased) {
        var_5 _id_0479::setteamheadicon(var_5.team, (0, 0, 65));
      } else {
        var_5 _id_0479::setplayerheadicon(var_5._id_0117, (0, 0, 65));
      }

      waitframe();

      if(isDefined(var_1)) {
        var_1 delete();
      }
    }
  }
}

trophystunbegin() {
  if(self.stunned) {
    return;
  }
  self.stunned = 1;
  _playFXOnTag(common_scripts\utility::getfx("mine_stunned"), self, "tag_origin");
}

trophystunend() {
  self.stunned = 0;
  _stopFXOnTag(common_scripts\utility::getfx("mine_stunned"), self, "tag_origin");
}

trophychangeowner(var_0) {
  if(isDefined(self.entityheadicon)) {
    self.entityheadicon destroy();
  }

  self notify("change_owner");
  self._id_0117 = var_0;
  self.team = var_0.team;
  var_0.trophyarray[var_0.trophyarray.size] = self;

  if(level.teambased) {
    _id_0479::setteamheadicon(self.team, (0, 0, 65));
  } else {
    _id_0479::setplayerheadicon(self._id_0117, (0, 0, 65));
  }

  thread trophydamage(var_0);
  thread trophyactive(var_0);
  thread trophydisconnectwaiter(var_0);
  thread trophyplayerspawnwaiter(var_0);
}

trophyuselistener(var_0) {
  self endon("death");
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("death");
  self.trigger setCursorHint("HINT_NOICON");
  self.trigger setHintString(&"MP_PICKUP_TROPHY");
  self.trigger maps\mp\_utility::setselfusable(var_0);
  self.trigger thread maps\mp\_utility::notusableforjoiningplayers(var_0);

  for(;;) {
    self.trigger waittill("trigger", var_0);
    var_0 playlocalsound("scavenger_pack_pickup");
    var_1 = var_0 getweaponammoclip("trophy_mp");
    var_0 setweaponammoclip("trophy_mp", var_1 + 1);
    var_0.trophyremainingammo = self._id_0D95;
    self.trigger delete();
    self delete();
    self notify("death");
  }
}

trophyplayerspawnwaiter(var_0) {
  self endon("disconnect");
  self endon("death");
  self endon("change_owner");
  var_0 waittill("spawned");
  thread trophybreak();
}

trophydisconnectwaiter(var_0) {
  self endon("death");
  self endon("change_owner");
  var_0 waittill("disconnect");
  thread trophybreak();
}

trophyactive(var_0, var_1, var_2, var_3) {
  var_0 endon("disconnect");
  self endon("death");
  self endon("change_owner");
  self endon("trophyDisabled");

  if(!isDefined(var_1)) {
    var_1 = 384;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = "trophy_mp";
  }

  var_4 = var_1 * var_1;

  for(;;) {
    if(!isDefined(level.grenades) || level.grenades.size < 1 && level.missiles.size < 1 && level.trackingdrones.size < 1 || isDefined(self.disabled) || self.stunned == 1) {
      waitframe();
      continue;
    }

    var_5 = common_scripts\utility::_id_0F73(level.grenades, level.missiles);
    var_5 = common_scripts\utility::_id_0F73(var_5, level.trackingdrones);

    if(var_5.size < 1) {
      waitframe();
      continue;
    }

    foreach(var_7 in var_5) {
      waitframe();

      if(!isDefined(var_7)) {
        continue;
      }
      if(var_7 == self) {
        continue;
      }
      if(isDefined(var_7.weaponname)) {
        switch (var_7.weaponname) {
          case "carepackage_crate_mp":
          case "claymore_mp":
            continue;
        }
      }

      switch (var_7.model) {
        case "weapon_parabolic_knife":
        case "weapon_jammer":
        case "weapon_radar":
        case "mp_trophy_system":
          continue;
      }

      if(!isDefined(var_7._id_0117)) {
        var_7._id_0117 = _getmissileowner(var_7);
      }

      if(isDefined(var_7._id_0117) && level.teambased && var_7._id_0117.team == var_0.team) {
        continue;
      }
      if(isDefined(var_7._id_0117) && var_7._id_0117 == var_0) {
        continue;
      }
      if(!trophywithinmindot(var_7)) {
        continue;
      }
      var_8 = distancesquared(var_7.origin, self.origin);

      if(var_8 < var_4) {
        if(_bullettracepassed(var_7.origin, self.origin, 0, self)) {
          var_9 = self.origin + (0, 0, 32);

          if(isDefined(self.laserent)) {
            var_9 = self.laserent.origin;
          }

          playFX(common_scripts\utility::getfx("trophy_detonation"), var_9, var_7.origin - self.origin, anglestoup(self.angles));
          thread trophyhandlelaser(var_0, var_7);
          self playSound("trophy_detect_projectile");

          if(isDefined(var_7.classname) && var_7.classname == "rocket" && (isDefined(var_7.type) && var_7.type == "remote")) {
            if(isDefined(var_7.type) && var_7.type == "remote") {
              level thread maps\mp\gametypes\_missions::vehiclekilled(var_7._id_0117, var_0, undefined, var_0, undefined, "MOD_EXPLOSIVE", var_3);
              level thread maps\mp\_utility::teamplayercardsplash("callout_destroyed_predator_missile", var_0);
              level thread maps\mp\gametypes\_rank::awardgameevent("kill", var_0, var_3, undefined, "MOD_EXPLOSIVE");
              var_0 notify("destroyed_killstreak", var_3);
            }

            playFX(common_scripts\utility::getfx("trophy_detonation"), var_7.origin);

            if(isDefined(level.barrelexpsound)) {
              var_7 playSound(level.barrelexpsound);
            }
          }

          var_0 thread projectileexplode(var_7, self);
          var_0 maps\mp\gametypes\_missions::processchallenge("ch_noboomforyou");

          if(!var_2) {
            self._id_0D95--;
          }

          if(self._id_0D95 <= 0) {
            thread trophybreak();
          }
        }
      }
    }
  }
}

trophysetmindot(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  self.mindot = var_0;
  self.trophyangleoffset = var_1;
}

trophywithinmindot(var_0) {
  if(!isDefined(self.mindot)) {
    return 1;
  }

  var_1 = anglesToForward(self.angles + self.trophyangleoffset);
  var_2 = vectorNormalize(var_0.origin - self.origin);
  var_3 = vectordot(var_1, var_2);
  return var_3 > self.mindot;
}

trophyhandlelaser(var_0, var_1) {
  if(!isDefined(self.laserent)) {
    return;
  }
  var_0 endon("disconnect");
  self endon("death");
  self endon("change_owner");
  self endon("trophyDisabled");
  self.laserent endon("death");
  self notify("trophyDelayClearLaser");
  self endon("trophyDelayClearLaser");
  self.laserent.angles = vectortoangles(var_1.origin - self.laserent.origin);
  self.laserent laseron("tracking_drone_laser");
  wait 0.7;
  self.laserent laseroff();
}

trophyaddlaser(var_0, var_1) {
  self.laserent = spawn("script_model", self.origin);
  self.laserent setModel("tag_laser");
  self.laserent.angles = self.angles;
  self.laserent.laseroriginoffset = var_0;
  self.laserent.laserforwardangles = var_1;
  thread trophyupdatelaser();
}

trophyupdatelaser() {
  self endon("death");
  self endon("change_owner");
  self endon("trophyDisabled");
  self.laserent endon("death");

  for(;;) {
    var_0 = anglesToForward(self.angles + self.laserent.laserforwardangles);
    self.laserent.origin = self.origin + var_0 * self.laserent.laseroriginoffset;
    waitframe();
  }
}

projectileexplode(var_0, var_1) {
  self endon("death");
  var_2 = var_0.origin;
  var_3 = var_0.model;
  var_4 = var_0.angles;

  if(var_3 == "weapon_light_marker") {
    playFX(common_scripts\utility::getfx("trophy_detonation"), var_2, anglesToForward(var_4), anglestoup(var_4));
    var_1 thread trophybreak();
    var_0 delete();
    return;
  }

  var_0 delete();
  var_1 playSound("trophy_fire");
  playFX(level.mine_explode, var_2, anglesToForward(var_4), anglestoup(var_4));
  radiusdamage(var_2, 128, 105, 10, self, "MOD_EXPLOSIVE", "trophy_mp");
}

trophydamage(var_0) {
  self endon("death");
  var_0 endon("death");
  self endon("change_owner");
  self setCanDamage(1);
  self.health = 999999;
  self.maxhealth = 100;
  self._id_006A = 0;

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(!isPlayer(var_2)) {
      continue;
    }
    if(!_id_0513::friendlyfirecheck(self._id_0117, var_2)) {
      continue;
    }
    if(isDefined(var_10)) {
      switch (var_10) {
        case "signal_flare_expeditionary_mp":
        case "signal_flare_mp":
        case "smoke_grenade_axis_expeditionary_mp":
        case "smoke_grenade_expeditionary_mp":
        case "stun_grenade_mp":
        case "concussion_grenade_mp":
        case "flash_grenade_mp":
        case "smoke_grenade_axis_mp":
        case "smoke_grenade_mp":
          continue;
      }
    }

    if(!isDefined(self)) {
      return;
    }
    if(maps\mp\_utility::ismeleemod(var_5)) {
      self._id_006A = self._id_006A + self.maxhealth;
    }

    if(isDefined(var_9) && var_9 &level._id_5039) {
      self.wasdamagedfrombulletpenetration = 1;
    }

    self.wasdamaged = 1;

    if(isDefined(var_10) && (var_10 == "emp_grenade_mp" || var_10 == "emp_grenade_killstreak_mp")) {
      self._id_006A = self._id_006A + self.maxhealth;
    }

    self._id_006A = self._id_006A + var_1;

    if(isPlayer(var_2)) {
      var_2 _id_04C7::updatedamagefeedback("trophy");
    }

    if(self._id_006A >= self.maxhealth) {
      if(isDefined(var_0) && var_2 != var_0) {
        var_2 notify("destroyed_explosive");
      }

      thread trophybreak();
    }
  }
}

trophybreak() {
  _playFXOnTag(common_scripts\utility::getfx("sentry_explode_mp"), self, "tag_origin");
  _playFXOnTag(common_scripts\utility::getfx("sentry_smoke_mp"), self, "tag_origin");
  self playSound("sentry_explode");
  self notify("death");
  var_0 = self.origin;
  self.trigger makeunusable();

  if(isDefined(self.laserent)) {
    self.laserent delete();
  }

  wait 3;

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  if(isDefined(self)) {
    self delete();
  }
}
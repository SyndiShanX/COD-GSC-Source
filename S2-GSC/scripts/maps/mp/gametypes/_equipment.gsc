/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_equipment.gsc
****************************************************/

_id_A956(var_0) {
  self endon("spawned_player");
  self endon("disconnect");
  self._id_9DCF = [];

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

      self._id_9DCF = common_scripts\utility::_id_0FA0(self._id_9DCF);

      if(self._id_9DCF.size >= level._id_6092) {
        self._id_9DCF[0] thread _id_9DD0();
      }

      var_5 = spawn("script_model", var_1.origin);
      var_5 setModel("mp_trophy_system");
      var_5 thread _id_0513::_id_27D0("mp_trophy_system_bombsquad", "tag_origin", self);
      var_5.angles = var_1.angles;
      self._id_9DCF[self._id_9DCF.size] = var_5;
      var_5._id_0117 = self;
      var_5.team = self.team;
      var_5._id_A9E0 = var_2;
      var_5._id_94B9 = 0;
      level._id_9DCB[level._id_9DCB.size] = var_5;

      if(isDefined(self._id_9DD6) && self._id_9DD6 > 0) {
        var_5._id_0D95 = self._id_9DD6;
      } else {
        var_5._id_0D95 = 2;
      }

      var_5._id_9D65 = spawn("script_origin", var_5.origin);
      var_5 thread _id_9DD2(self);
      var_5 thread _id_9DCC(self);
      var_5 thread _id_9DD3(self);
      var_5 thread _id_9DD5(self);
      var_5 thread _id_9DDB(self);
      var_5 thread _id_0513::_id_1DF6();

      if(level.teambased) {
        var_5 _id_0479::_id_873C(var_5.team, (0, 0, 65));
      } else {
        var_5 _id_0479::_id_86FC(var_5._id_0117, (0, 0, 65));
      }

      waitframe();

      if(isDefined(var_1)) {
        var_1 delete();
      }
    }
  }
}

_id_9DD8() {
  if(self._id_94B9) {
    return;
  }
  self._id_94B9 = 1;
  _playFXOnTag(common_scripts\utility::_id_44F5("mine_stunned"), self, "tag_origin");
}

_id_9DD9() {
  self._id_94B9 = 0;
  _stopFXOnTag(common_scripts\utility::_id_44F5("mine_stunned"), self, "tag_origin");
}

_id_9DD1(var_0) {
  if(isDefined(self._id_37D3)) {
    self._id_37D3 destroy();
  }

  self notify("change_owner");
  self._id_0117 = var_0;
  self.team = var_0.team;
  var_0._id_9DCF[var_0._id_9DCF.size] = self;

  if(level.teambased) {
    _id_0479::_id_873C(self.team, (0, 0, 65));
  } else {
    _id_0479::_id_86FC(self._id_0117, (0, 0, 65));
  }

  thread _id_9DD2(var_0);
  thread _id_9DCC(var_0);
  thread _id_9DD3(var_0);
  thread _id_9DD5(var_0);
}

_id_9DDB(var_0) {
  self endon("death");
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("death");
  self._id_9D65 setCursorHint("HINT_NOICON");
  self._id_9D65 setHintString(&"MP_PICKUP_TROPHY");
  self._id_9D65 maps\mp\_utility::setselfusable(var_0);
  self._id_9D65 thread maps\mp\_utility::_id_6819(var_0);

  for(;;) {
    self._id_9D65 waittill("trigger", var_0);
    var_0 playlocalsound("scavenger_pack_pickup");
    var_1 = var_0 getweaponammoclip("trophy_mp");
    var_0 setweaponammoclip("trophy_mp", var_1 + 1);
    var_0._id_9DD6 = self._id_0D95;
    self._id_9D65 delete();
    self delete();
    self notify("death");
  }
}

_id_9DD5(var_0) {
  self endon("disconnect");
  self endon("death");
  self endon("change_owner");
  var_0 waittill("spawned");
  thread _id_9DD0();
}

_id_9DD3(var_0) {
  self endon("death");
  self endon("change_owner");
  var_0 waittill("disconnect");
  thread _id_9DD0();
}

_id_9DCC(var_0, var_1, var_2, var_3) {
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
    if(!isDefined(level._id_486C) || level._id_486C.size < 1 && level._id_6248.size < 1 && level._id_9BB5.size < 1 || isDefined(self._id_2F74) || self._id_94B9 == 1) {
      waitframe();
      continue;
    }

    var_5 = common_scripts\utility::_id_0F73(level._id_486C, level._id_6248);
    var_5 = common_scripts\utility::_id_0F73(var_5, level._id_9BB5);

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
      if(isDefined(var_7._id_A9E0)) {
        switch (var_7._id_A9E0) {
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
      if(!_id_9DDC(var_7)) {
        continue;
      }
      var_8 = distancesquared(var_7.origin, self.origin);

      if(var_8 < var_4) {
        if(_bullettracepassed(var_7.origin, self.origin, 0, self)) {
          var_9 = self.origin + (0, 0, 32);

          if(isDefined(self._id_5B09)) {
            var_9 = self._id_5B09.origin;
          }

          playFX(common_scripts\utility::_id_44F5("trophy_detonation"), var_9, var_7.origin - self.origin, anglestoup(self.angles));
          thread _id_9DD4(var_0, var_7);
          self playSound("trophy_detect_projectile");

          if(isDefined(var_7.classname) && var_7.classname == "rocket" && (isDefined(var_7.type) && var_7.type == "remote")) {
            if(isDefined(var_7.type) && var_7.type == "remote") {
              level thread maps\mp\gametypes\_missions::_id_A3F7(var_7._id_0117, var_0, undefined, var_0, undefined, "MOD_EXPLOSIVE", var_3);
              level thread maps\mp\_utility::teamplayercardsplash("callout_destroyed_predator_missile", var_0);
              level thread maps\mp\gametypes\_rank::_id_1457("kill", var_0, var_3, undefined, "MOD_EXPLOSIVE");
              var_0 notify("destroyed_killstreak", var_3);
            }

            playFX(common_scripts\utility::_id_44F5("trophy_detonation"), var_7.origin);

            if(isDefined(level._id_15CA)) {
              var_7 playSound(level._id_15CA);
            }
          }

          var_0 thread _id_776D(var_7, self);
          var_0 maps\mp\gametypes\_missions::processchallenge("ch_noboomforyou");

          if(!var_2) {
            self._id_0D95--;
          }

          if(self._id_0D95 <= 0) {
            thread _id_9DD0();
          }
        }
      }
    }
  }
}

_id_9DD7(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  self._id_61C0 = var_0;
  self._id_9DCE = var_1;
}

_id_9DDC(var_0) {
  if(!isDefined(self._id_61C0)) {
    return 1;
  }

  var_1 = anglesToForward(self.angles + self._id_9DCE);
  var_2 = vectorNormalize(var_0.origin - self.origin);
  var_3 = vectordot(var_1, var_2);
  return var_3 > self._id_61C0;
}

_id_9DD4(var_0, var_1) {
  if(!isDefined(self._id_5B09)) {
    return;
  }
  var_0 endon("disconnect");
  self endon("death");
  self endon("change_owner");
  self endon("trophyDisabled");
  self._id_5B09 endon("death");
  self notify("trophyDelayClearLaser");
  self endon("trophyDelayClearLaser");
  self._id_5B09.angles = vectortoangles(var_1.origin - self._id_5B09.origin);
  self._id_5B09 laseron("tracking_drone_laser");
  wait 0.7;
  self._id_5B09 laseroff();
}

_id_9DCD(var_0, var_1) {
  self._id_5B09 = spawn("script_model", self.origin);
  self._id_5B09 setModel("tag_laser");
  self._id_5B09.angles = self.angles;
  self._id_5B09._id_5B0F = var_0;
  self._id_5B09._id_5B0B = var_1;
  thread _id_9DDA();
}

_id_9DDA() {
  self endon("death");
  self endon("change_owner");
  self endon("trophyDisabled");
  self._id_5B09 endon("death");

  for(;;) {
    var_0 = anglesToForward(self.angles + self._id_5B09._id_5B0B);
    self._id_5B09.origin = self.origin + var_0 * self._id_5B09._id_5B0F;
    waitframe();
  }
}

_id_776D(var_0, var_1) {
  self endon("death");
  var_2 = var_0.origin;
  var_3 = var_0.model;
  var_4 = var_0.angles;

  if(var_3 == "weapon_light_marker") {
    playFX(common_scripts\utility::_id_44F5("trophy_detonation"), var_2, anglesToForward(var_4), anglestoup(var_4));
    var_1 thread _id_9DD0();
    var_0 delete();
    return;
  }

  var_0 delete();
  var_1 playSound("trophy_fire");
  playFX(level._id_61C8, var_2, anglesToForward(var_4), anglestoup(var_4));
  radiusdamage(var_2, 128, 105, 10, self, "MOD_EXPLOSIVE", "trophy_mp");
}

_id_9DD2(var_0) {
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
    if(!_id_0513::_id_3ECD(self._id_0117, var_2)) {
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
    if(maps\mp\_utility::_id_5755(var_5)) {
      self._id_006A = self._id_006A + self.maxhealth;
    }

    if(isDefined(var_9) && var_9 &level._id_5039) {
      self._id_A86F = 1;
    }

    self._id_A86E = 1;

    if(isDefined(var_10) && (var_10 == "emp_grenade_mp" || var_10 == "emp_grenade_killstreak_mp")) {
      self._id_006A = self._id_006A + self.maxhealth;
    }

    self._id_006A = self._id_006A + var_1;

    if(isPlayer(var_2)) {
      var_2 _id_04C7::_id_A102("trophy");
    }

    if(self._id_006A >= self.maxhealth) {
      if(isDefined(var_0) && var_2 != var_0) {
        var_2 notify("destroyed_explosive");
      }

      thread _id_9DD0();
    }
  }
}

_id_9DD0() {
  _playFXOnTag(common_scripts\utility::_id_44F5("sentry_explode_mp"), self, "tag_origin");
  _playFXOnTag(common_scripts\utility::_id_44F5("sentry_smoke_mp"), self, "tag_origin");
  self playSound("sentry_explode");
  self notify("death");
  var_0 = self.origin;
  self._id_9D65 makeunusable();

  if(isDefined(self._id_5B09)) {
    self._id_5B09 delete();
  }

  wait 3;

  if(isDefined(self._id_9D65)) {
    self._id_9D65 delete();
  }

  if(isDefined(self)) {
    self delete();
  }
}
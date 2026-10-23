/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_portable_radar.gsc
*********************************************************/

deleteportableradar(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_2 in level.players) {
    if(isDefined(var_2)) {
      var_2.inplayerportableradar = undefined;
    }
  }

  var_0 notify("death");
  var_0 delete();
}

monitorportableradaruse() {
  self endon("disconnect");
  level endon("game_ended");
  self.portableradararray = [];

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(var_1 == "portabl_radar" || var_1 == "portable_radar_mp") {
      if(!isalive(self)) {
        var_0 delete();
        continue;
      }

      self.portableradararray = common_scripts\utility::_id_0FA0(self.portableradararray);

      if(self.portableradararray.size >= level.maxperplayerexplosives) {
        deleteportableradar(self.portableradararray[0]);
      }

      var_0 waittill("missile_stuck");
      var_2 = var_0.origin;

      if(isDefined(var_0)) {
        var_0 delete();
      }

      var_3 = spawn("script_model", var_2);
      var_3.health = 100;
      var_3.team = self.team;
      var_3._id_0117 = self;
      var_3 setCanDamage(1);
      var_3 makeportableradar(self);
      var_3 portableradarsetup(self);
      var_3 thread _id_0513::createbombsquadmodel("weapon_radar_bombsquad", "tag_origin", self);
      var_3 thread portableradarproximitytracker();
      thread portableradarwatchowner(var_3);
      self.portableradararray[self.portableradararray.size] = var_3;
    }
  }
}

portableradarsetup(var_0) {
  self setModel("weapon_radar");

  if(level.teambased) {
    _id_0479::setteamheadicon(self.team, (0, 0, 20));
  } else {
    _id_0479::setplayerheadicon(var_0, (0, 0, 20));
  }

  thread portableradardamagelistener(var_0);
  thread portableradaruselistener(var_0);
  thread portableradarbeepsounds();
  thread maps\mp\_utility::notusableforjoiningplayers(var_0);
}

portableradarwatchowner(var_0) {
  var_0 endon("death");
  level endon("game_ended");
  common_scripts\utility::waittill_any("disconnect", "joined_team", "joined_spectators", "spawned_player");
  level thread deleteportableradar(var_0);
}

portableradarbeepsounds() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    wait 2.0;
    self playSound("sentry_gun_beep");
  }
}

portableradardamagelistener(var_0) {
  self endon("death");
  self.health = 999999;
  self.maxhealth = 100;
  self._id_006A = 0;

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(!_id_0513::friendlyfirecheck(self._id_0117, var_2)) {
      continue;
    }
    if(isDefined(var_10)) {
      switch (var_10) {
        case "stun_grenade_mp":
        case "concussion_grenade_mp":
        case "flash_grenade_mp":
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
    self._id_006A = self._id_006A + var_1;

    if(isDefined(var_10) && (var_10 == "emp_grenade_mp" || var_10 == "emp_grenade_killstreak_mp")) {
      self._id_006A = self.maxhealth + 1;
    }

    if(isPlayer(var_2)) {
      var_2 _id_04C7::updatedamagefeedback("portable_radar");
    }

    if(self._id_006A >= self.maxhealth) {
      if(isDefined(var_0) && var_2 != var_0) {
        var_2 notify("destroyed_explosive");
      }

      self playSound("sentry_explode");
      self.deatheffect = playFX(common_scripts\utility::getfx("equipment_explode"), self.origin);
      self freeentitysentient();
      var_2 thread deleteportableradar(self);
    }
  }
}

portableradaruselistener(var_0) {
  self endon("death");
  level endon("game_ended");
  var_0 endon("disconnect");
  self setCursorHint("HINT_NOICON");
  self setHintString(&"MP_PATCH_PICKUP_PORTABLE_RADAR");
  maps\mp\_utility::setselfusable(var_0);

  for(;;) {
    self waittill("trigger", var_0);
    var_1 = var_0 getweaponammostock("portable_radar_mp");

    if(var_1 < _weaponmaxammo("portable_radar_mp")) {
      var_0 playlocalsound("scavenger_pack_pickup");
      var_0 setweaponammostock("portable_radar_mp", var_1 + 1);
      var_0 thread deleteportableradar(self);
    }
  }
}

portableradarproximitytracker() {
  self endon("death");
  level endon("game_ended");
  var_0 = 512;

  for(;;) {
    foreach(var_2 in level.players) {
      if(!isDefined(var_2)) {
        continue;
      }
      if(level.teambased && var_2.team == self.team) {
        continue;
      }
      if(var_2 maps\mp\_utility::_hasperk("specialty_radarimmune") || var_2 maps\mp\_utility::_hasperk("specialty_uavhidden")) {
        continue;
      }
      var_3 = distancesquared(self.origin, var_2.origin);

      if(distancesquared(var_2.origin, self.origin) < var_0 * var_0) {
        var_2.inplayerportableradar = self._id_0117;
        continue;
      }

      var_2.inplayerportableradar = undefined;
    }

    waitframe();
  }
}
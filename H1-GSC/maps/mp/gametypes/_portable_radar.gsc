/*************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\_portable_radar.gsc
*************************************************/

deleteportableradar(var_0) {
  if(!isdefined(var_0)) {
    return;
  }
  foreach(var_2 in level.players) {
    if(isdefined(var_2))
      var_2.inplayerportableradar = undefined;
  }

  var_0 notify("death");
  var_0 delete();
}

monitorportableradaruse() {
  self endon("disconnect");
  level endon("game_ended");
  self.portableradararray = [];

  for (;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(var_1 == "portabl_radar" || var_1 == "portable_radar_mp") {
      if(!isalive(self)) {
        var_0 delete();
        continue;
      }

      self.portableradararray = common_scripts\utility::array_removeundefined(self.portableradararray);

      if(self.portableradararray.size >= level.maxperplayerexplosives)
        deleteportableradar(self.portableradararray[0]);

      var_0 waittill("missile_stuck");
      var_2 = var_0.origin;

      if(isdefined(var_0))
        var_0 delete();

      var_3 = spawn("script_model", var_2);
      var_3.health = 100;
      var_3.team = self.team;
      var_3.owner = self;
      var_3 setcandamage(1);
      var_3 makeportableradar(self);
      var_3 portableradarsetup(self);
      var_3 thread maps\mp\gametypes\_weapons::createbombsquadmodel("weapon_radar_bombsquad", "tag_origin", self);
      var_3 thread portableradarproximitytracker();
      thread portableradarwatchowner(var_3);
      self.portableradararray[self.portableradararray.size] = var_3;
    }
  }
}

portableradarsetup(var_0) {
  self setmodel("weapon_radar");

  if(level.teambased)
    maps\mp\_entityheadicons::setteamheadicon(self.team, (0, 0, 20));
  else
    maps\mp\_entityheadicons::setplayerheadicon(var_0, (0, 0, 20));

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

  for (;;) {
    wait 2.0;
    self playsound("sentry_gun_beep");
  }
}

portableradardamagelistener(var_0) {
  self endon("death");
  self.health = 999999;
  self.maxhealth = 100;
  self.damagetaken = 0;

  for (;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(!maps\mp\gametypes\_weapons::friendlyfirecheck(self.owner, var_2)) {
      continue;
    }
    if(isdefined(var_10))
      var_11 = maps\mp\_utility::strip_suffix(var_10, "_lefthand");
    else
      var_11 = undefined;

    if(isdefined(var_11)) {
      switch (var_11) {
        case "smoke_grenade_mp":
        case "flash_grenade_mp":
        case "concussion_grenade_mp":
          continue;
      }
    }

    if(!isdefined(self)) {
      return;
    }
    if(maps\mp\_utility::ismeleemod(var_5))
      self.damagetaken = self.damagetaken + self.maxhealth;

    if(isdefined(var_9) && var_9 & level.idflags_penetration)
      self.wasdamagedfrombulletpenetration = 1;

    self.wasdamaged = 1;
    self.damagetaken = self.damagetaken + var_1;

    if(isplayer(var_2))
      var_2 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("portable_radar");

    if(self.damagetaken >= self.maxhealth) {
      if(isdefined(var_0) && var_2 != var_0)
        var_2 notify("destroyed_explosive");

      self playsound("sentry_explode");
      self.deatheffect = playfx(common_scripts\utility::getfx("equipment_explode"), self.origin);
      self freeentitysentient();
      var_2 thread deleteportableradar(self);
    }
  }
}

portableradaruselistener(var_0) {
  self endon("death");
  level endon("game_ended");
  var_0 endon("disconnect");
  self setcursorhint("HINT_NOICON");
  self sethintstring(&"MP_PATCH_PICKUP_PORTABLE_RADAR");
  maps\mp\_utility::setselfusable(var_0);

  for (;;) {
    self waittill("trigger", var_0);
    var_1 = var_0 getweaponammostock("portable_radar_mp");

    if(var_1 < weaponmaxammo("portable_radar_mp")) {
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

  for (;;) {
    foreach(var_2 in level.players) {
      if(!isdefined(var_2)) {
        continue;
      }
      if(level.teambased && var_2.team == self.team) {
        continue;
      }
      if(var_2 maps\mp\_utility::_hasperk("specialty_class_lowprofile")) {
        continue;
      }
      var_3 = distancesquared(self.origin, var_2.origin);

      if(distancesquared(var_2.origin, self.origin) < var_0 * var_0) {
        var_2.inplayerportableradar = self.owner;
        continue;
      }

      var_2.inplayerportableradar = undefined;
    }

    wait 0.05;
  }
}
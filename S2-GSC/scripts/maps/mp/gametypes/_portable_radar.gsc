/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_portable_radar.gsc
*********************************************************/

_id_2D49(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_2 in level.players) {
    if(isDefined(var_2)) {
      var_2._id_5383 = undefined;
    }
  }

  var_0 notify("death");
  var_0 delete();
}

_id_63C9() {
  self endon("disconnect");
  level endon("game_ended");
  self._id_757A = [];

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(var_1 == "portabl_radar" || var_1 == "portable_radar_mp") {
      if(!isalive(self)) {
        var_0 delete();
        continue;
      }

      self._id_757A = common_scripts\utility::_id_0FA0(self._id_757A);

      if(self._id_757A.size >= level._id_6092) {
        _id_2D49(self._id_757A[0]);
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
      var_3 _id_757E(self);
      var_3 thread _id_0513::_id_27D0("weapon_radar_bombsquad", "tag_origin", self);
      var_3 thread _id_757D();
      thread _id_7580(var_3);
      self._id_757A[self._id_757A.size] = var_3;
    }
  }
}

_id_757E(var_0) {
  self setModel("weapon_radar");

  if(level.teambased) {
    _id_0479::_id_873C(self.team, (0, 0, 20));
  } else {
    _id_0479::_id_86FC(var_0, (0, 0, 20));
  }

  thread _id_757C(var_0);
  thread _id_757F(var_0);
  thread _id_757B();
  thread maps\mp\_utility::_id_6819(var_0);
}

_id_7580(var_0) {
  var_0 endon("death");
  level endon("game_ended");
  common_scripts\utility::_id_A70A("disconnect", "joined_team", "joined_spectators", "spawned_player");
  level thread _id_2D49(var_0);
}

_id_757B() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    wait 2.0;
    self playSound("sentry_gun_beep");
  }
}

_id_757C(var_0) {
  self endon("death");
  self.health = 999999;
  self.maxhealth = 100;
  self._id_006A = 0;

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(!_id_0513::_id_3ECD(self._id_0117, var_2)) {
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
    if(maps\mp\_utility::_id_5755(var_5)) {
      self._id_006A = self._id_006A + self.maxhealth;
    }

    if(isDefined(var_9) && var_9 &level._id_5039) {
      self._id_A86F = 1;
    }

    self._id_A86E = 1;
    self._id_006A = self._id_006A + var_1;

    if(isDefined(var_10) && (var_10 == "emp_grenade_mp" || var_10 == "emp_grenade_killstreak_mp")) {
      self._id_006A = self.maxhealth + 1;
    }

    if(isPlayer(var_2)) {
      var_2 _id_04C7::_id_A102("portable_radar");
    }

    if(self._id_006A >= self.maxhealth) {
      if(isDefined(var_0) && var_2 != var_0) {
        var_2 notify("destroyed_explosive");
      }

      self playSound("sentry_explode");
      self._id_2AA1 = playFX(common_scripts\utility::_id_44F5("equipment_explode"), self.origin);
      self freeentitysentient();
      var_2 thread _id_2D49(self);
    }
  }
}

_id_757F(var_0) {
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
      var_0 thread _id_2D49(self);
    }
  }
}

_id_757D() {
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
        var_2._id_5383 = self._id_0117;
        continue;
      }

      var_2._id_5383 = undefined;
    }

    waitframe();
  }
}
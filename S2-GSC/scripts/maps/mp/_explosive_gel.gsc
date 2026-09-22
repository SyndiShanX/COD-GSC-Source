/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_explosive_gel.gsc
**********************************************/

_id_A907() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(var_1 == "explosive_gel_mp") {
      if(!isalive(self)) {
        var_0 delete();
        return;
      }

      thread _id_9E28(var_0);
    }
  }
}

init() {
  precachemodel("weapon_c4");
  precachemodel("weapon_c4_bombsquad");
  level._id_3960 = spawnStruct();
  level._id_3960._id_9489 = "weapon_c4";
  level._id_3960._id_4010 = "weapon_c4_bombsquad";
  level._id_3960._id_4011 = loadfx("vfx/explosion/frag_grenade_default");
  level._id_3960._id_16F1["enemy"] = loadfx("vfx/lights/light_c4_blink");
  level._id_3960._id_16F1["friendly"] = loadfx("vfx/lights/light_mine_blink_friendly");
}

_id_9E28(var_0) {
  thread _id_5C29(var_0);
  return 1;
}

_id_5C29(var_0) {
  thread _id_A906(var_0);
  var_1 = _id_939D(var_0);
}

_id_A906(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("change_owner");
  var_0 endon("missile_stuck");
  var_0 endon("death");
  var_1 = 0;

  for(;;) {
    if(self useButtonPressed()) {
      var_1 = 0;

      while(self useButtonPressed()) {
        var_1 = var_1 + 0.05;
        waitframe();
      }

      if(var_1 >= 0.5) {
        continue;
      }
      var_1 = 0;

      while(!self useButtonPressed() && var_1 < 0.5) {
        var_1 = var_1 + 0.05;
        waitframe();
      }

      if(var_1 >= 0.5) {
        continue;
      }
      thread _id_3537(var_0);
    }

    waitframe();
  }
}

_id_939D(var_0) {
  self endon("earlyNotify");
  var_0 waittill("missile_stuck");
  var_1 = bulletTrace(var_0.origin, var_0.origin - (0, 0, 4), 0, var_0);
  var_2 = bulletTrace(var_0.origin, var_0.origin + (0, 0, 4), 0, var_0);
  var_3 = anglesToForward(var_0.angles);
  var_4 = bulletTrace(var_0.origin + (0, 0, 4), var_0.origin + var_3 * 4, 0, var_0);
  var_5 = undefined;
  var_6 = 0;
  var_7 = 0;

  if(var_4["surfacetype"] != "none") {
    var_5 = var_4;
    var_7 = 1;
  } else if(var_2["surfacetype"] != "none") {
    var_5 = var_2;
    var_6 = 1;
  } else if(var_1["surfacetype"] != "none")
    var_5 = var_1;
  else {
    var_5 = var_1;
  }

  var_8 = var_5["position"];

  if(var_8 == var_2["position"]) {
    var_8 = var_8 + (0, 0, -5);
  }

  var_9 = spawn("script_model", var_8);
  var_9._id_5817 = var_6;
  var_9._id_56F9 = var_7;
  var_10 = vectorNormalize(var_5["normal"]);
  var_11 = vectortoangles(var_10);
  var_11 = var_11 + (90, 0, 0);
  var_9.angles = var_11;
  var_9 setModel(level._id_3960._id_9489);
  var_9._id_0117 = self;
  var_9 setotherent(self);
  var_9._id_5A30 = (0, 0, 55);
  var_9._id_5A2C = spawn("script_model", var_9.origin + var_9._id_5A30);
  var_9._id_94B9 = 0;
  var_9._id_A9E0 = "explosive_gel_mp";
  var_0 delete();
  level._id_61ED[level._id_61ED.size] = var_9;
  var_9 thread _id_27D0(level._id_3960._id_4010, "tag_origin", self);
  var_9 thread _id_61D0();
  var_9 thread _id_8679(self.team);
  var_9 thread _id_61DD();
  var_9 thread _id_395F(self);
  return var_9;
}

_id_27D0(var_0, var_1, var_2) {
  var_3 = spawn("script_model", (0, 0, 0));
  var_3 hide();
  waitframe();
  var_3 thread _id_0513::_id_1908(var_2);
  var_3 setModel(var_0);
  var_3 linkTo(self, var_1, (0, 0, 0), (0, 0, 0));
  var_3 _meth_80B1();
  self waittill("death");

  if(isDefined(self._id_9D65)) {
    self._id_9D65 delete();
  }

  var_3 delete();
}

_id_61D0() {
  var_0["friendly"] = _spawnfx(level._id_3960._id_16F1["friendly"], self gettagorigin("tag_fx"));
  var_0["enemy"] = _spawnfx(level._id_3960._id_16F1["enemy"], self gettagorigin("tag_fx"));
  thread _id_61D1(var_0);
  self waittill("death");
  var_0["friendly"] delete();
  var_0["enemy"] delete();
}

_id_61D1(var_0, var_1) {
  self endon("death");
  var_2 = self._id_0117.team;
  waitframe();
  _triggerfx(var_0["friendly"]);
  _triggerfx(var_0["enemy"]);

  for(;;) {
    var_0["friendly"] hide();
    var_0["enemy"] hide();

    foreach(var_4 in level.players) {
      if(level.teambased) {
        if(var_4.team == var_2) {
          var_0["friendly"] showtoplayer(var_4);
        } else {
          var_0["enemy"] showtoplayer(var_4);
        }

        continue;
      }

      if(var_4 == self._id_0117) {
        var_0["friendly"] showtoplayer(var_4);
        continue;
      }

      var_0["enemy"] showtoplayer(var_4);
    }

    level common_scripts\utility::_id_A732("joined_team", "player_spawned");
  }
}

_id_8679(var_0) {
  self endon("death");
  waitframe();

  if(level.teambased) {
    if(self._id_5817 == 1 || self._id_56F9 == 1) {
      _id_0479::_id_873C(var_0, (0, 0, 28), undefined, 1);
    } else {
      _id_0479::_id_873C(var_0, (0, 0, 28));
    }
  } else if(isDefined(self._id_0117)) {
    if(self._id_5817 == 1) {
      _id_0479::_id_86FC(self._id_0117, (28, 0, 28));
    } else {
      _id_0479::_id_86FC(self._id_0117, (0, 0, 28));
    }
  }
}

_id_61DD() {
  self endon("mine_triggered");
  self endon("mine_selfdestruct");
  self endon("death");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  var_0 = undefined;

  for(;;) {
    self waittill("damage", var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(!isPlayer(var_0)) {
      continue;
    }
    if(!_id_0513::_id_3ECD(self._id_0117, var_0)) {
      continue;
    }
    if(isDefined(var_9)) {
      switch (var_9) {
        case "smoke_grenade_mp":
          continue;
      }
    }

    break;
  }

  self notify("mine_destroyed");

  if(isDefined(var_4) && (issubstr(var_4, "MOD_GRENADE") || issubstr(var_4, "MOD_EXPLOSIVE"))) {
    self._id_A86B = 1;
  }

  if(isDefined(var_8) && var_8 &level._id_5039) {
    self._id_A86F = 1;
  }

  self._id_A86E = 1;

  if(isPlayer(var_0)) {
    var_0 _id_04C7::_id_A102("bouncing_betty");
  }

  if(level.teambased) {
    if(isDefined(var_0) && isDefined(var_0.pers["team"]) && isDefined(self._id_0117) && isDefined(self._id_0117.pers["team"])) {
      if(var_0.pers["team"] != self._id_0117.pers["team"]) {
        var_0 notify("destroyed_explosive");
      }
    }
  } else if(isDefined(self._id_0117) && isDefined(var_0) && var_0 != self._id_0117)
    var_0 notify("destroyed_explosive");

  thread _id_61E3(var_0);
}

_id_61E3(var_0) {
  if(!isDefined(self) || !isDefined(self._id_0117)) {
    return;
  }
  if(!isDefined(var_0)) {
    var_0 = self._id_0117;
  }

  self playSound("null");
  var_1 = self gettagorigin("tag_fx");
  playFX(level._id_3960._id_4011, var_1);
  waitframe();

  if(!isDefined(self) || !isDefined(self._id_0117)) {
    return;
  }
  self hide();
  self radiusdamage(self.origin, 192, 100, 100, var_0, "MOD_EXPLOSIVE");

  if(isDefined(self._id_0117) && isDefined(level._id_5C44)) {
    self._id_0117 thread[[level._id_5C44]]("mine_destroyed", undefined, undefined, self.origin);
  }

  wait 0.2;

  if(!isDefined(self) || !isDefined(self._id_0117)) {
    return;
  }
  thread _id_0F1B();
  self notify("death");

  if(isDefined(self._id_6FD8)) {
    self._id_6FD8 delete();
  }

  self hide();
}

_id_3537(var_0) {
  self notify("earlyNotify");
  var_1 = var_0 gettagorigin("tag_fx");
  playFX(level._id_3960._id_4011, var_1);
  var_0 detonate();
}

_id_0F1B() {
  wait 3;
  self._id_5A2C delete();
  self delete();
  level._id_61ED = common_scripts\utility::_id_0FA0(level._id_61ED);
}

_id_395F(var_0) {
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  wait 3;
  self notify("mine_triggered");
  thread _id_61E3();
}
/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\229.gsc
**************************************/

_id_0A30() {
  self.stats["kills"] = 0;
  self.stats["kills_melee"] = 0;
  self.stats["kills_explosives"] = 0;
  self.stats["kills_juggernaut"] = 0;
  self.stats["kills_vehicle"] = 0;
  self.stats["kills_sentry"] = 0;
  self.stats["headshots"] = 0;
  self.stats["shots_fired"] = 0;
  self.stats["shots_hit"] = 0;
  self.stats["weapon"] = [];
  thread _id_0A3E();
}

_id_0A32() {
  if(isDefined(self._id_0A33) && self._id_0A33) {
    return 1;

  }
  if(!isDefined(self.damagelocation)) {
    return 0;

  }
  return self.damagelocation == "helmet" || self.damagelocation == "head" || self.damagelocation == "neck";
}

_id_0A34(var_0, var_1, var_2, var_3) {
  var_4 = self;

  if(isDefined(self.owner)) {
    var_4 = self.owner;

  }
  if(!isplayer(var_4)) {
    if(isDefined(level._id_0A35) && level._id_0A35) {
      var_4 = level.players[randomint(level.players.size)];
    }
  }

  if(!isplayer(var_4)) {
    return;
  }
  if(isDefined(level._id_01D9) && isDefined(var_0._id_0EEA) && var_0._id_0EEA) {
    return;
  }
  var_4.stats["kills"]++;
  var_4 _id_0A3A("kills", 1);

  if(maps\_utility::_id_0A36()) {
    level notify("specops_player_kill", var_4, var_0, var_2, var_3);

  }
  if(isDefined(var_0)) {
    if(var_0 _id_0A32()) {
      var_4.stats["headshots"]++;
      var_4 _id_0A3A("headshots", 1);
    }

    if(isDefined(var_0._id_0A37)) {
      var_4.stats["kills_juggernaut"]++;
      var_4 _id_0A3A("kills_juggernaut", 1);
    }

    if(isDefined(var_0._id_0A38)) {
      var_4.stats["kills_sentry"]++;

    }
    if(var_0.code_classname == "script_vehicle") {
      var_4.stats["kills_vehicle"]++;

      if(isDefined(var_0._id_0A39)) {
        foreach(var_6 in var_0._id_0A39) {
          if(isDefined(var_6)) {
            var_4 _id_0A34(var_6, var_1, var_2, var_3);
          }
        }
      }
    }
  }

  if(_id_0A42(var_1)) {
    var_4.stats["kills_explosives"]++;

  }
  if(!isDefined(var_2)) {
    var_2 = var_4 getcurrentweapon();

  }
  if(issubstr(tolower(var_1), "melee")) {
    var_4.stats["kills_melee"]++;

    if(weaponinventorytype(var_2) == "primary") {
      return;
    }
  }

  if(var_4 _id_0A41(var_2)) {
    var_4 _id_0A43(var_2);

  }
  var_4.stats["weapon"][var_2].kills++;
}

_id_0A3A(var_0, var_1) {
  if(!maps\_utility::_id_0A36()) {
    return;
  }
  var_2 = int(self getplayerdata("career", var_0)) + var_1;
  self setplayerdata("career", var_0, var_2);
}

_id_0A3B() {
  if(!isplayer(self)) {
    return;
  }
  if(isDefined(self._id_0A3C)) {
    return;
  }
  self._id_0A3C = 1;
  self.stats["shots_hit"]++;
  _id_0A3A("bullets_hit", 1);
  var_0 = self getcurrentweapon();

  if(_id_0A41(var_0)) {
    _id_0A43(var_0);

  }
  self.stats["weapon"][var_0]._id_0A3D++;
  waittillframeend;
  self._id_0A3C = undefined;
}

_id_0A3E() {
  self endon("death");

  for(;;) {
    self waittill("weapon_fired");
    var_0 = self getcurrentweapon();

    if(!isDefined(var_0) || !maps\_utility::isprimaryweapon(var_0)) {
      continue;
    }
    self.stats["shots_fired"]++;
    _id_0A3A("bullets_fired", 1);

    if(_id_0A41(var_0)) {
      _id_0A43(var_0);

    }
    self.stats["weapon"][var_0]._id_0A40++;
  }
}

_id_0A41(var_0) {
  if(isDefined(self.stats["weapon"][var_0])) {
    return 0;

  }
  return 1;
}

_id_0A42(var_0) {
  var_0 = tolower(var_0);

  switch (var_0) {
    case "splash":
    case "mod_explosive":
    case "mod_projectile_splash":
    case "mod_projectile":
    case "mod_grenade_splash":
    case "mod_grenade":
      return 1;
    default:
      return 0;
  }

  return 0;
}

_id_0A43(var_0) {
  self.stats["weapon"][var_0] = spawnStruct();
  self.stats["weapon"][var_0].name = var_0;
  self.stats["weapon"][var_0]._id_0A40 = 0;
  self.stats["weapon"][var_0]._id_0A3D = 0;
  self.stats["weapon"][var_0].kills = 0;
}

_id_0A44() {
  var_0 = 1;

  foreach(var_2 in level.players) {
    setdvar("stats_" + var_0 + "_kills_melee", var_2.stats["kills_melee"]);
    setdvar("stats_" + var_0 + "_kills_juggernaut", var_2.stats["kills_juggernaut"]);
    setdvar("stats_" + var_0 + "_kills_explosives", var_2.stats["kills_explosives"]);
    setdvar("stats_" + var_0 + "_kills_vehicle", var_2.stats["kills_vehicle"]);
    setdvar("stats_" + var_0 + "_kills_sentry", var_2.stats["kills_sentry"]);
    var_3 = var_2 _id_0A45(5);

    foreach(var_5 in var_3) {
      var_5.accuracy = 0;

      if(var_5._id_0A40 > 0) {
        var_5.accuracy = int(var_5._id_0A3D / var_5._id_0A40 * 100);
      }
    }

    for(var_7 = 1; var_7 < 6; var_7++) {
      setdvar("stats_" + var_0 + "_weapon" + var_7 + "_name", " ");
      setdvar("stats_" + var_0 + "_weapon" + var_7 + "_kills", " ");
      setdvar("stats_" + var_0 + "_weapon" + var_7 + "_shots", " ");
      setdvar("stats_" + var_0 + "_weapon" + var_7 + "_accuracy", " ");
    }

    for(var_7 = 0; var_7 < var_3.size; var_7++) {
      if(!isDefined(var_3[var_7])) {
        break;
      }

      setdvar("stats_" + var_0 + "_weapon" + (var_7 + 1) + "_name", var_3[var_7].name);
      setdvar("stats_" + var_0 + "_weapon" + (var_7 + 1) + "_kills", var_3[var_7].kills);
      setdvar("stats_" + var_0 + "_weapon" + (var_7 + 1) + "_shots", var_3[var_7]._id_0A40);
      setdvar("stats_" + var_0 + "_weapon" + (var_7 + 1) + "_accuracy", var_3[var_7].accuracy + "%");
    }

    var_0++;
  }
}

_id_0A45(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0; var_2++) {
    var_1[var_2] = _id_0A46(var_1);

  }
  return var_1;
}

_id_0A46(var_0) {
  if(!isDefined(var_0)) {
    var_0 = [];

  }
  var_1 = undefined;

  foreach(var_3 in self.stats["weapon"]) {
    var_4 = 0;

    foreach(var_6 in var_0) {
      if(var_3.name == var_6.name) {
        var_4 = 1;
        break;
      }
    }

    if(var_4) {
      continue;
    }
    if(!isDefined(var_1)) {
      var_1 = var_3;
      continue;
    }

    if(var_3.kills > var_1.kills) {
      var_1 = var_3;
    }
  }

  return var_1;
}
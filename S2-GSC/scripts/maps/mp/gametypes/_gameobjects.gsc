/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_gameobjects.gsc
******************************************************/

main(var_0) {
  var_0[var_0.size] = "airdrop_pallet";
  var_1 = getEntArray();

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(isDefined(var_1[var_2].dropweapon)) {
      var_3 = 1;
      var_4 = strtok(var_1[var_2].dropweapon, " ");

      for(var_5 = 0; var_5 < var_0.size; var_5++) {
        for(var_6 = 0; var_6 < var_4.size; var_6++) {
          if(var_4[var_6] == var_0[var_5]) {
            var_3 = 0;
            break;
          }
        }

        if(!var_3) {
          break;
        }
      }

      if(var_3) {
        if(isDefined(var_1[var_2].setdepthoffield))
          common_scripts\_createfx::removefxentwithentity(var_1[var_2]);

        var_1[var_2] delete();
      }
    }
  }
}

init() {
  level._id_688F = 0;
  level._id_6991 = 0;
  level thread onplayerconnect();
}

onplayerconnect() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawned();
    var_0 thread _id_6AEE();
  }
}

onplayerspawned() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("spawned_player");

    if(isDefined(self._id_3FCB)) {
      self._id_3FCB = undefined;
      continue;
    }

    _id_5240();
  }
}

_id_5240() {
  thread _id_6AE3();
  self._id_9AC5 = [];
  self._id_2016 = undefined;
  self._id_2310 = undefined;
  self._id_1F63 = 1;
  self._id_5A3E = undefined;
  self._id_52F8 = 1;
}

_id_6AE3() {
  level endon("game_ended");
  self waittill("death");

  if(isDefined(self._id_2016)) {
    if(_func_367() || isDefined(self._id_2016._id_2D3F) && self._id_2016._id_2D3F) {
      self._id_2016 _id_2D2F();
      return;
    }

    self._id_2016 thread _id_866E();

    if(level.gametype == "relic")
      level maps\mp\gametypes\relic::attemptdropteslagun(self.origin);
  }
}

_id_6AEE() {
  level endon("game_ended");
  self waittill("disconnect");

  if(isDefined(self._id_2016)) {
    if(_func_367()) {
      self._id_2016 _id_2D2F();
      return;
    }

    self._id_2016 thread _id_866E();
  }
}

_id_27D6(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7.type = "carryObject";
  var_7._id_28D4 = var_1.origin;
  var_7._id_6DB2 = var_0;
  var_7._id_37D8 = var_1 getentitynumber();

  if(issubstr(var_1.classname, "use"))
    var_7._id_9DC4 = "use";
  else
    var_7._id_9DC4 = "proximity";

  var_1._id_162D = var_1.origin;
  var_7._id_9D65 = var_1;
  var_7._id_A248 = undefined;

  if(!isDefined(var_3))
    var_3 = (0, 0, 0);

  var_7._id_6A1D = var_3;

  for(var_8 = 0; var_8 < var_2.size; var_8++) {
    var_2[var_8]._id_162D = var_2[var_8].origin;
    var_2[var_8]._id_15F4 = var_2[var_8].angles;
  }

  var_7._id_A582 = var_2;

  if(!isDefined(var_5))
    var_5 = 0;

  if(!var_5) {
    if(!isDefined(var_6))
      var_6 = 0;

    var_7._id_2562 = [];
    var_7._id_698A = _id_45A9();
    var_7._id_698B = _id_45A9();
    var_7._id_698C = _id_45A9();
    var_7._id_6990 = 0;
    var_7._id_698F = 0;
    var_7._id_6993 = 5.0;
    level._id_6991 = level._id_6991 + 2;
    _objective_add(var_7._id_698A, "invisible", var_7._id_28D4);
    _objective_add(var_7._id_698B, "invisible", var_7._id_28D4);
    _objective_add(var_7._id_698C, "invisible", var_7._id_28D4);
    _objective_team(var_7._id_698A, "allies");
    _objective_team(var_7._id_698B, "axis");
    _objective_mlgspectator(var_7._id_698C);

    if(var_6) {
      var_7._id_6996["allies"] = _id_04EC::_id_282F("objpoint_allies_" + var_7._id_37D8, var_7._id_28D4 + var_3, "allies", undefined);
      var_7._id_6996["axis"] = _id_04EC::_id_282F("objpoint_axis_" + var_7._id_37D8, var_7._id_28D4 + var_3, "axis", undefined);
      var_7._id_6996["broadcaster"] = _id_04EC::_id_282F("objpoint_broadcaster_" + var_7._id_37D8, var_7._id_28D4 + var_3, "broadcaster", undefined);
      var_7._id_6996["broadcaster"].archived = 0;
      var_7._id_6996["allies"].alpha = 0;
      var_7._id_6996["axis"].alpha = 0;
    }
  }

  var_7.carrier = undefined;
  var_7._id_57A6 = 0;
  var_7._id_5412 = "none";
  var_7._id_0C33 = 0;
  var_7._id_A965 = 0;
  var_7._id_59DD = 0;
  var_7._id_AA8A = [];
  var_7._id_AA89 = [];
  var_7._id_356E = undefined;
  var_7._id_200B = 0;
  var_7._id_A560 = "none";
  var_7.carryicon = undefined;
  var_7._id_6AEF = undefined;
  var_7._id_6B62 = undefined;
  var_7._id_6B93 = undefined;

  if(var_7._id_9DC4 == "use")
    var_7 thread _id_201A();
  else {
    var_7._id_28D5 = 0;
    var_7._id_A23F = 0;
    var_7._id_A22B = 0;
    var_7._id_65BF = 0;
    var_7._id_1F49 = 0;
    var_7._id_5107 = 0;
    var_7._id_986E = [];
    var_7._id_986D = [];
    var_7._id_689F["neutral"] = 0;
    var_7._id_689F["axis"] = 0;
    var_7._id_689F["allies"] = 0;
    var_7._id_689F["none"] = 0;
    var_7._id_9AC3["neutral"] = [];
    var_7._id_9AC3["axis"] = [];
    var_7._id_9AC3["allies"] = [];
    var_7._id_9AC3["none"] = [];
    var_7._id_230F = "none";
    var_7._id_230E = undefined;
    var_7._id_5B81 = undefined;
    var_7._id_5B82 = "none";
    var_7._id_5B83 = 0;

    if(level._id_6520) {
      foreach(var_10 in level._id_985B) {
        var_7._id_689F[var_10] = 0;
        var_7._id_9AC3[var_10] = [];
      }
    }

    var_7 thread _id_2018();
  }

  if(!var_5)
    var_7 thread _id_A0F2(var_4);

  return var_7;
}

_id_2D2F() {
  if(!isDefined(self.type) || self.type != "carryObject") {
    return;
  }
  var_0 = self;
  var_0.type = undefined;
  var_0._id_28D4 = undefined;
  var_0._id_6DB2 = undefined;
  var_0._id_37D8 = undefined;
  var_0._id_9DC4 = undefined;
  var_0._id_9D65 unlink();
  var_0._id_9D65 delete();
  var_0._id_9D65 = undefined;
  var_0._id_A248 = undefined;
  var_0._id_6A1D = undefined;

  foreach(var_2 in var_0._id_A582) {
    if(isDefined(var_2))
      var_2 delete();
  }

  var_0._id_A582 = undefined;

  if(!_func_367()) {
    if(isDefined(var_0._id_698A))
      maps\mp\_utility::_objective_delete(var_0._id_698A);

    if(isDefined(var_0._id_698B))
      maps\mp\_utility::_objective_delete(var_0._id_698B);

    if(isDefined(var_0._id_698C))
      maps\mp\_utility::_objective_delete(var_0._id_698C);
  }

  var_0._id_2562 = undefined;
  var_0._id_698A = undefined;
  var_0._id_698B = undefined;
  var_0._id_698C = undefined;
  var_0._id_6990 = undefined;
  var_0._id_698F = undefined;
  var_0._id_6993 = undefined;

  if(isDefined(var_0._id_6996)) {
    _id_04EC::_id_2D3E(var_0._id_6996["allies"]);
    _id_04EC::_id_2D3E(var_0._id_6996["axis"]);
    _id_04EC::_id_2D3E(var_0._id_6996["broadcaster"]);
  }

  var_0._id_6996 = undefined;
  var_0.carrier = undefined;
  var_0._id_57A6 = undefined;
  var_0._id_5412 = undefined;
  var_0._id_0C33 = undefined;
  var_0._id_A965 = undefined;
  var_0._id_59DD = undefined;
  var_0._id_AA8A = undefined;
  var_0._id_AA89 = undefined;
  var_0._id_356E = undefined;
  var_0._id_200B = undefined;
  var_0._id_A560 = undefined;
  var_0.carryicon = undefined;
  var_0._id_6AEF = undefined;
  var_0._id_6B62 = undefined;
  var_0._id_6B93 = undefined;
  var_0._id_28D5 = undefined;
  var_0._id_A23F = undefined;
  var_0._id_A22B = undefined;
  var_0._id_65BF = undefined;
  var_0._id_1F49 = undefined;
  var_0._id_5107 = undefined;
  var_0._id_986E = undefined;
  var_0._id_986D = undefined;
  var_0._id_689F = undefined;
  var_0._id_9AC3 = undefined;
  var_0._id_230F = undefined;
  var_0._id_230E = undefined;
  var_0._id_5B81 = undefined;
  var_0._id_5B82 = undefined;
  var_0._id_5B83 = undefined;
  var_0 notify("death");
  var_0 notify("deleted");
}

_id_201A() {
  level endon("game_ended");

  for(;;) {
    self._id_9D65 waittill("trigger", var_0);

    if(self._id_57A6) {
      continue;
    }
    if(!maps\mp\_utility::isreallyalive(var_0)) {
      continue;
    }
    if(!_id_1F53(var_0.pers["team"])) {
      continue;
    }
    if(!var_0._id_1F63) {
      continue;
    }
    if(!isDefined(var_0._id_52F8)) {
      continue;
    }
    if(isDefined(var_0.throwinggrenade)) {
      continue;
    }
    if(isDefined(self.carrier)) {
      continue;
    }
    if(var_0 maps\mp\_utility::isusingremote() || var_0 maps\mp\_utility::_id_572D()) {
      continue;
    }
    _id_86F9(var_0);
  }
}

_id_2018() {
  thread _id_2019();
}

_id_2019() {
  if(_func_367()) {
    self endon("death");
    self endon("deleted");
  }

  if(isDefined(level._id_5677) && level._id_5677 || isDefined(level._id_579A) && level._id_579A)
    self endon("death");

  level endon("game_ended");
  thread _id_779A();

  for(;;) {
    waittillframeend;

    if(self._id_A23F && self._id_28D5 >= self._id_A23F) {
      self._id_28D5 = 0;
      var_0 = _id_44AF();

      if(isDefined(self._id_6AFA))
        self[[self._id_6AFA]](_id_445B(), var_0, isDefined(var_0));

      if(isDefined(var_0))
        _id_86F9(var_0);

      _id_864E("none");
      self._id_230E = undefined;
    }

    if(self._id_230F != "none") {
      if(self._id_A23F) {
        if(!self._id_689F[self._id_230F] || _id_5108() || common_scripts\utility::_id_562E(self._id_A414) && isDefined(self._id_1F84) && ![[self._id_1F84]](self._id_230E)) {
          if(isDefined(self._id_6AFA))
            self[[self._id_6AFA]](_id_445B(), self._id_230E, 0);

          _id_864E("none");
          self._id_230E = undefined;
        } else {
          self._id_28D5 = self._id_28D5 + 50 * self._id_A22B;

          if(isDefined(self._id_6BCB))
            self[[self._id_6BCB]](_id_445B(), self._id_28D5 / self._id_A23F, 50 * self._id_A22B / self._id_A23F);
        }
      } else {
        if(maps\mp\_utility::isreallyalive(self._id_230E))
          _id_86F9(self._id_230E);

        _id_864E("none");
        self._id_230E = undefined;
      }
    }

    waitframe();
    maps\mp\gametypes\_hostmigration::_id_A782();
  }
}

_id_6FCF(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self._id_1F63 = 0;

  for(;;) {
    if(distancesquared(self.origin, var_0) > 4096) {
      break;
    }

    wait 0.2;
  }

  self._id_1F63 = 1;
}

_id_86F9(var_0) {
  if(_isai(var_0) && isDefined(var_0._id_0117)) {
    return;
  }
  if(isDefined(var_0._id_2016)) {
    if(isDefined(self._id_6B63))
      self[[self._id_6B63]](var_0);

    return;
  }

  var_0 _id_479E(self);
  _id_8643(var_0);

  for(var_1 = 0; var_1 < self._id_A582.size; var_1++)
    self._id_A582[var_1] hide();

  self._id_9D65.origin = self._id_9D65.origin + (0, 0, 10000);
  self notify("pickup_object");

  if(isDefined(self._id_6B62))
    self[[self._id_6B62]](var_0);

  _id_A0FE();
  _id_A19B();
}

_id_A0F2(var_0) {
  if(isDefined(level._id_5677) && level._id_5677 || isDefined(level._id_579A) && level._id_579A)
    self endon("death");

  level endon("game_ended");

  if(_func_367()) {
    self endon("death");
    self endon("deleted");
  }

  for(;;) {
    if(isDefined(self.carrier)) {
      self._id_28D4 = self.carrier.origin + (0, 0, 75);
      self._id_28CF = self.carrier.origin;
      self._id_6996["allies"] _id_04EC::_id_A145(self._id_28D4);
      self._id_6996["axis"] _id_04EC::_id_A145(self._id_28D4);
      var_1 = self._id_6993 + 1.0;

      if(common_scripts\utility::_id_562E(var_0))
        var_2 = var_1;
      else
        var_2 = 0;

      if((self._id_A560 == "friendly" || self._id_A560 == "any") && _id_56FB("allies") && self._id_6990) {
        if(self._id_6996["allies"]._id_57CB) {
          self._id_6996["allies"].alpha = self._id_6996["allies"]._id_15F3;
          self._id_6996["allies"] fadeovertime(var_1);
          self._id_6996["allies"].alpha = 0;
        }

        _objective_position(self._id_698A, self._id_28D4, var_2);
      } else if((self._id_A560 == "friendly" || self._id_A560 == "any") && _id_56FB("axis") && self._id_6990) {
        if(self._id_6996["axis"]._id_57CB) {
          self._id_6996["axis"].alpha = self._id_6996["axis"]._id_15F3;
          self._id_6996["axis"] fadeovertime(var_1);
          self._id_6996["axis"].alpha = 0;
        }

        _objective_position(self._id_698B, self._id_28D4, var_2);
      }

      if((self._id_A560 == "enemy" || self._id_A560 == "any") && !_id_56FB("allies") && self._id_698F) {
        if(self._id_6996["allies"]._id_57CB) {
          self._id_6996["allies"].alpha = self._id_6996["allies"]._id_15F3;
          self._id_6996["allies"] fadeovertime(var_1);
          self._id_6996["allies"].alpha = 0;
        }

        _objective_position(self._id_698A, self._id_28D4, var_2);
      } else if((self._id_A560 == "enemy" || self._id_A560 == "any") && !_id_56FB("axis") && self._id_698F) {
        if(self._id_6996["axis"]._id_57CB) {
          self._id_6996["axis"].alpha = self._id_6996["axis"]._id_15F3;
          self._id_6996["axis"] fadeovertime(var_1);
          self._id_6996["axis"].alpha = 0;
        }

        _objective_position(self._id_698B, self._id_28D4, var_2);
      }

      common_scripts\utility::_id_A63E(self._id_6993, "dropped", "reset");
      continue;
    }

    self._id_28CF = undefined;
    self._id_6996["allies"] _id_04EC::_id_A145(self._id_28D4 + self._id_6A1D);
    self._id_6996["axis"] _id_04EC::_id_A145(self._id_28D4 + self._id_6A1D);
    waitframe();
  }
}

_id_4D05() {
  self endon("disconnect");
  self endon("death");
  self endon("drop_object");
  level waittill("game_ended");

  if(isDefined(self.carryicon))
    self.carryicon.alpha = 0;
}

_id_479E(var_0) {
  self._id_2016 = var_0;
  thread _id_9BA1();

  if(common_scripts\utility::_id_562E(var_0.carrythinkbypass))
    self thread[[var_0._id_201D]]();

  if(isDefined(var_0.carryweapon)) {
    showonclient(var_0);
    var_0._id_2008 = self hasweapon(var_0.carryweapon);

    if(isDefined(var_0._id_201D))
      self thread[[var_0._id_201D]]();

    maps\mp\_utility::_giveweapon(var_0.carryweapon);
    self switchtoweapon(var_0.carryweapon);
    self disableweaponpickup();
    common_scripts\utility::_id_0603();
  } else if(!var_0._id_0C33) {
    common_scripts\utility::_id_0602();

    if(isDefined(var_0._id_5FD8))
      self thread[[var_0._id_5FD8]]();
    else
      thread _id_5FD8();
  }

  if(isDefined(var_0.carryicon) && isPlayer(self)) {
    if(level.splitscreen) {
      self.carryicon = maps\mp\gametypes\_hud_util::createicon(var_0.carryicon, 33, 33);
      self.carryicon maps\mp\gametypes\_hud_util::setpoint("BOTTOM RIGHT", "BOTTOM RIGHT", -50, -78);
    } else {
      self.carryicon = maps\mp\gametypes\_hud_util::createicon(var_0.carryicon, 50, 50);
      self.carryicon maps\mp\gametypes\_hud_util::setpoint("BOTTOM RIGHT", "BOTTOM RIGHT", -90, -110);
    }

    self.carryicon.hidewheninmenu = 1;
    thread _id_4D05();
  }
}

_id_7E30() {
  self._id_57A6 = 1;
  self notify("reset");

  for(var_0 = 0; var_0 < self._id_A582.size; var_0++) {
    self._id_A582[var_0].origin = self._id_A582[var_0]._id_162D;
    self._id_A582[var_0].angles = self._id_A582[var_0]._id_15F4;
    self._id_A582[var_0] show();
  }

  self._id_9D65.origin = self._id_9D65._id_162D;
  self._id_28D4 = self._id_9D65.origin;

  if(isDefined(self._id_6B93))
    self[[self._id_6B93]]();

  _id_23DA();
  _id_A19B();
  _id_A0FE();
  self._id_57A6 = 0;
}

_id_5715() {
  if(isDefined(self.carrier))
    return 0;

  if(self._id_28D4 != self._id_9D65._id_162D)
    return 0;

  return 1;
}

_id_870A(var_0, var_1) {
  self._id_57A6 = 1;

  for(var_2 = 0; var_2 < self._id_A582.size; var_2++) {
    self._id_A582[var_2].origin = var_0;
    self._id_A582[var_2].angles = var_1;
    self._id_A582[var_2] show();
  }

  self._id_9D65.origin = var_0;
  self._id_28D4 = self._id_9D65.origin;
  _id_23DA();
  _id_A19B();
  _id_A0FE();
  self._id_57A6 = 0;
}

_id_6B7D() {
  if(isDefined(self._id_2016))
    self._id_2016 thread _id_866E();
}

_id_2017(var_0) {
  for(var_1 = 0; var_1 < var_0._id_2016._id_A582.size; var_1++)
    var_0._id_2016._id_A582[var_1] unlink();

  var_0._id_2016._id_9D65 unlink();
  var_0._id_2016 notify("stop_pickup_timeout");
  var_0._id_2016 _id_7E30();
}

_id_866E(var_0) {
  if(level.gametype == "sd")
    waitframe();

  if(!isDefined(var_0))
    var_0 = 0;

  if(isDefined(self._id_866E)) {
    if([[self._id_866E]]())
      return;
  }

  self._id_57A6 = 1;
  self notify("dropped");

  if(isDefined(self.carrier) && self.carrier.team != "spectator") {
    if(isDefined(self.carrier._id_18A8)) {
      var_1 = _playerphysicstrace(self.carrier.origin + (0, 0, 20), self.carrier.origin - (0, 0, 2000), self.carrier._id_18A8);
      var_2 = bulletTrace(self.carrier.origin + (0, 0, 20), self.carrier.origin - (0, 0, 2000), 0, self.carrier._id_18A8);
    } else {
      var_1 = _playerphysicstrace(self.carrier.origin + (0, 0, 20), self.carrier.origin - (0, 0, 2000));
      var_2 = bulletTrace(self.carrier.origin + (0, 0, 20), self.carrier.origin - (0, 0, 2000), 0);
    }
  } else {
    var_1 = _playerphysicstrace(self.detachall + (0, 0, 20), self.detachall - (0, 0, 20));
    var_2 = bulletTrace(self.detachall + (0, 0, 20), self.detachall - (0, 0, 20), 0, undefined);
  }

  var_3 = self.carrier;

  if(isDefined(var_1)) {
    var_4 = _randomfloat(360);
    var_5 = var_1;

    if(isDefined(self.visualgroundoffset))
      var_5 = var_5 + self.visualgroundoffset;

    if(var_2["fraction"] < 1 && distance(var_2["position"], var_1) < 10.0) {
      var_6 = (_cos(var_4), _sin(var_4), 0);
      var_6 = vectorNormalize(var_6 - var_2["normal"] * vectordot(var_6, var_2["normal"]));
      var_7 = vectortoangles(var_6);
    } else
      var_7 = (0, var_4, 0);

    for(var_8 = 0; var_8 < self._id_A582.size; var_8++) {
      self._id_A582[var_8].origin = var_5;
      self._id_A582[var_8].angles = var_7;

      if(var_0 <= 0) {
        self._id_A582[var_8] show();
        continue;
      }

      self._id_A582[var_8] thread common_scripts\utility::_id_2CB7(var_0);
    }

    self._id_9D65.origin = var_5;
    self._id_28D4 = self._id_9D65.origin;
    var_9 = spawnStruct();
    var_9._id_2016 = self;
    var_9._id_2AA8 = ::_id_2017;
    self._id_9D65 thread _id_0488::_id_4A27(var_9);
    thread _id_6FD6();
  }

  if(!isDefined(var_1)) {
    for(var_8 = 0; var_8 < self._id_A582.size; var_8++) {
      self._id_A582[var_8].origin = self._id_A582[var_8]._id_162D;
      self._id_A582[var_8].angles = self._id_A582[var_8]._id_15F4;

      if(var_0 <= 0) {
        self._id_A582[var_8] show();
        continue;
      }

      self._id_A582[var_8] thread common_scripts\utility::_id_2CB7(var_0);
    }

    self._id_9D65.origin = self._id_9D65._id_162D;
    self._id_28D4 = self._id_9D65._id_162D;
  }

  if(isDefined(self._id_6AEF))
    self[[self._id_6AEF]](var_3);

  _id_23DA();
  _id_A0FE();
  _id_A19B();
  self._id_57A6 = 0;
}

_id_8643(var_0) {
  self.carrier = var_0;
  thread _id_A191();
}

_id_23DA() {
  if(!isDefined(self.carrier)) {
    return;
  }
  self.carrier _id_95ED(self);
  self.carrier = undefined;
  self._id_28CF = undefined;
  self notify("carrier_cleared");
}

_id_6FD6() {
  self endon("pickup_object");
  self endon("stop_pickup_timeout");
  waitframe();

  if(_id_5808()) {
    _id_7E30();
    return;
  }

  if(isDefined(self._id_138A)) {
    wait(self._id_138A);

    if(!isDefined(self.carrier))
      _id_7E30();
  }
}

_id_5808() {
  var_0 = getEntArray("out_of_bounds", "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(!self._id_A582[0] istouching(var_0[var_1])) {
      continue;
    }
    return 1;
  }

  if(!self._id_A582[0] physicsisactive()) {
    var_0 = getEntArray("out_of_bounds_at_rest", "targetname");

    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      if(!self._id_A582[0] istouching(var_0[var_1])) {
        continue;
      }
      return 1;
    }
  }

  var_2 = getEntArray("trigger_hurt", "classname");

  for(var_1 = 0; var_1 < var_2.size; var_1++) {
    if(!self._id_A582[0] istouching(var_2[var_1])) {
      continue;
    }
    return 1;
  }

  if(self._id_A965) {
    var_3 = getEntArray("trigger_underwater", "targetname");

    for(var_1 = 0; var_1 < var_3.size; var_1++) {
      if(!self._id_A582[0] istouching(var_3[var_1])) {
        continue;
      }
      return 1;
    }
  }

  return 0;
}

_id_466F(var_0) {
  var_1 = issubstr(var_0, "zk383");

  if(isDefined(self.pers["altModeActive"]) && isDefined(self._id_0079) && self.pers["altModeActive"] && self._id_0079 != 5 && maps\mp\_utility::getweaponclass(var_0) == "weapon_smg" && issubstr(var_0, "suppressor") && !var_1) {
    var_2 = _id_04CA::_id_461C(1);

    if(var_2 == "suppressor_level1" || var_2 == "suppressor_level2" || var_2 == "suppressor_level3")
      var_0 = "alt+" + var_0;
  } else if(var_1 && common_scripts\utility::_id_562E(self.pers["altModeActive"]))
    var_0 = "alt+" + var_0;
  else if(isDefined(self.pers["dragonBreathActive"]) && self.pers["dragonBreathActive"] && isDefined(self._id_0079) && self._id_0079 != 5 && maps\mp\_utility::getweaponclass(var_0) == "weapon_shotgun" && issubstr(var_0, "dragon_breath"))
    var_0 = "alt+" + var_0;
  else if(isDefined(self.pers["rifleGrenadeActive"]) && self.pers["rifleGrenadeActive"] && isDefined(self._id_0079) && self._id_0079 != 5 && maps\mp\_utility::getweaponclass(var_0) == "weapon_assault" && issubstr(var_0, "grenade_launcher"))
    var_0 = "alt+" + var_0;

  return var_0;
}

showonclient(var_0) {
  if(self _meth_803D() && isDefined(self.carryweapon) && self hasweapon(self.carryweapon))
    var_1 = self.carryweapon;
  else
    var_1 = _id_466F(self getcurrentprimaryweapon());

  var_0._id_200C = var_1;
}

_id_466D(var_0) {
  if(isDefined(var_0._id_200C) && self hasweapon(var_0._id_200C))
    return var_0._id_200C;

  var_1 = self getweaponlistprimaries();
  return var_1[0];
}

_id_95ED(var_0) {
  if(isDefined(self.carryicon))
    self.carryicon maps\mp\gametypes\_hud_util::destroyelem();

  if(isDefined(self))
    self._id_2016 = undefined;

  self notify("drop_object");

  if(var_0._id_9DC4 == "proximity")
    thread _id_6FCF(var_0._id_9D65.origin);

  if(maps\mp\_utility::isreallyalive(self)) {
    if(isDefined(var_0.carryweapon)) {
      var_1 = common_scripts\utility::_id_562E(var_0._id_59D8);

      if(!var_1 && isDefined(var_0._id_59D9))
        var_1 = var_0[[var_0._id_59D9]](self);

      if(!var_0._id_2008 && !var_1)
        self takeweapon(var_0.carryweapon);

      var_2 = !common_scripts\utility::_id_562E(var_0._id_0C2C) || !self isswitchingweapon();

      if(var_2) {
        var_3 = _id_466D(var_0);
        self switchtoweapon(var_3);
      }

      self enableweaponpickup();
      common_scripts\utility::_id_0617();
    } else if(!var_0._id_0C33)
      common_scripts\utility::_id_0616();
  }
}

_id_9BA1() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("drop_object");

  while(isDefined(self._id_2016) && maps\mp\_utility::isreallyalive(self)) {
    if(self isonground()) {
      var_0 = bulletTrace(self.origin + (0, 0, 20), self.origin - (0, 0, 20), 0, undefined);

      if(var_0["fraction"] < 1)
        self._id_2016.detachall = var_0["position"];
    }

    waitframe();
  }
}

_id_5FD8() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("drop_object");

  for(;;) {
    while(self attackbuttonpressed() || self fragbuttonpressed() || self secondaryoffhandbuttonpressed() || self meleebuttonpressed())
      waitframe();

    while(!self attackbuttonpressed() && !self fragbuttonpressed() && !self secondaryoffhandbuttonpressed() && !self meleebuttonpressed())
      waitframe();

    if(isDefined(self._id_2016) && !self usebuttonpressed())
      self._id_2016 thread _id_866E();
  }
}

deleteuseobjectobjectives() {
  if(isDefined(self._id_698A)) {
    maps\mp\_utility::_objective_delete(self._id_698A);
    self._id_698A = undefined;
  }

  if(isDefined(self._id_698B)) {
    maps\mp\_utility::_objective_delete(self._id_698B);
    self._id_698B = undefined;
  }

  if(isDefined(self._id_698C)) {
    maps\mp\_utility::_objective_delete(self._id_698C);
    self._id_698C = undefined;
  }
}

_id_2D58() {
  deleteuseobjectobjectives();

  if(isDefined(self._id_6996)) {
    _id_04EC::_id_2D3E(self._id_6996["allies"]);
    _id_04EC::_id_2D3E(self._id_6996["axis"]);
    _id_04EC::_id_2D3E(self._id_6996["broadcaster"]);
  }

  self._id_9D65 = undefined;
  self notify("deleted");
}

_id_2837(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6.type = "useObject";
  var_6._id_28D4 = var_1.origin;
  var_6._id_6DB2 = var_0;
  var_6._id_37D8 = var_1 getentitynumber();
  var_6._id_59E8 = undefined;

  if(issubstr(var_1.classname, "use"))
    var_6._id_9DC4 = "use";
  else
    var_6._id_9DC4 = "proximity";

  var_6._id_9D65 = var_1;

  for(var_7 = 0; var_7 < var_2.size; var_7++) {
    var_2[var_7]._id_162D = var_2[var_7].origin;
    var_2[var_7]._id_15F4 = var_2[var_7].angles;
  }

  var_6._id_A582 = var_2;

  if(!isDefined(var_3))
    var_3 = (0, 0, 0);

  var_6._id_6A1D = var_3;

  if(!isDefined(var_4) || !var_4) {
    var_6._id_2562 = [];
    var_6._id_698A = _id_45A9();
    var_6._id_698B = _id_45A9();
    var_6._id_698C = _id_45A9();
    _objective_add(var_6._id_698A, "invisible", var_6._id_28D4);
    _objective_add(var_6._id_698B, "invisible", var_6._id_28D4);
    _objective_add(var_6._id_698C, "invisible", var_6._id_28D4);
    _objective_team(var_6._id_698A, "allies");
    _objective_team(var_6._id_698B, "axis");
    _objective_mlgspectator(var_6._id_698C);

    if(!isDefined(var_5) || !var_5) {
      var_6._id_6996["allies"] = _id_04EC::_id_282F("objpoint_allies_" + var_6._id_37D8, var_6._id_28D4 + var_3, "allies", undefined);
      var_6._id_6996["axis"] = _id_04EC::_id_282F("objpoint_axis_" + var_6._id_37D8, var_6._id_28D4 + var_3, "axis", undefined);
      var_6._id_6996["broadcaster"] = _id_04EC::_id_282F("objpoint_broadcaster_" + var_6._id_37D8, var_6._id_28D4 + var_3, "broadcaster", undefined);
      var_6._id_6996["broadcaster"].archived = 0;
      var_6._id_6996["allies"].alpha = 0;
      var_6._id_6996["axis"].alpha = 0;
      var_6._id_6996["broadcaster"].alpha = 0;
    }
  }

  var_6._id_5412 = "none";
  var_6._id_59DD = 0;
  var_6._id_AA8A = [];
  var_6._id_AA89 = [];
  var_6._id_356E = undefined;
  var_6._id_A560 = "none";
  var_6._id_6BBF = undefined;
  var_6._id_6AC9 = undefined;
  var_6._id_A23D = "default";
  var_6._id_A23F = 10000;
  var_6._id_28D5 = 0;

  if(var_6._id_9DC4 == "proximity") {
    var_6._id_986E = [];
    var_6._id_986D = [];
    var_6._id_689F["neutral"] = 0;
    var_6._id_689F["axis"] = 0;
    var_6._id_689F["allies"] = 0;
    var_6._id_689F["none"] = 0;
    var_6._id_9AC3["neutral"] = [];
    var_6._id_9AC3["axis"] = [];
    var_6._id_9AC3["allies"] = [];
    var_6._id_9AC3["none"] = [];
    var_6._id_A22B = 0;
    var_6._id_230F = "none";
    var_6._id_230E = undefined;
    var_6._id_5B81 = undefined;
    var_6._id_5B82 = "none";
    var_6._id_5B83 = 0;
    var_6._id_65BF = 0;
    var_6._id_1F49 = 0;
    var_6._id_5107 = 0;
    var_6._id_A414 = 0;

    if(level._id_6520) {
      foreach(var_9 in level._id_985B) {
        var_6._id_689F[var_9] = 0;
        var_6._id_9AC3[var_9] = [];
      }
    }

    var_6 thread _id_A225();
  } else {
    var_6._id_5F95 = 0;
    var_6._id_A22B = 1;
    var_6._id_A23C = 1;
    var_6 thread _id_A227();
  }

  return var_6;
}

_id_6497(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  if(isDefined(self._id_9D65)) {
    self._id_9D65 dontinterpolate();
    self._id_9D65.origin = var_0;
  }

  if(isDefined(self._id_9D65._id_162D))
    self._id_9D65._id_162D = var_0;

  if(isDefined(self.levelflag)) {
    self.levelflag dontinterpolate();
    self.levelflag.origin = var_0;
  }

  if(isDefined(self._id_A582)) {
    foreach(var_3 in self._id_A582) {
      var_3 dontinterpolate();
      var_3.origin = var_0;
      var_3._id_162D = var_0;
    }
  }

  if(isDefined(self.origin))
    self.origin = var_0;

  if(isDefined(self._id_28D4))
    self._id_28D4 = var_0;

  if(isDefined(self._id_4800)) {
    if(isDefined(self._id_4800.laseron)) {
      foreach(var_6 in self._id_4800.laseron)
      var_6.origin = var_0;
    }

    if(isDefined(self._id_4800.origin))
      self._id_4800.origin = var_0;
  }

  if(isDefined(self._id_6996)) {
    foreach(var_9 in self._id_6996)
    var_9 _id_04EC::_id_A145(var_0 + var_1);
  }

  if(isDefined(self._id_698A))
    _objective_position(self._id_698A, var_0);

  if(isDefined(self._id_698B))
    _objective_position(self._id_698B, var_0);

  if(isDefined(self._id_698C))
    _objective_position(self._id_698C, var_0);

  if(isDefined(self._id_15F8)) {
    self._id_15F8 delete();
    var_11 = self._id_A582[0].origin + (0, 0, 32);
    var_12 = self._id_A582[0].origin + (0, 0, -32);
    var_13 = bulletTrace(var_11, var_12, 0, undefined);
    var_14 = vectortoangles(var_13["normal"]);
    self._id_15F9 = anglesToForward(var_14);
    self._id_15FB = anglestoright(var_14);
    self._id_15FA = var_13["position"];

    if(level.gametype == "dom")
      maps\mp\gametypes\dom::_id_A192();
  }
}

_id_86B5(var_0) {
  self._id_59E8 = var_0;
}

_id_2956() {
  var_0 = self getcurrentprimaryweapon();

  if(maps\mp\_utility::iskillstreakweapon(var_0) && !issubstr(var_0, "turrethead") && var_0 != "flamethrower_mp" && var_0 != "flamethrower_german_mp" && var_0 != "flamethrower_grenadier_mp" && var_0 != "flamethrower_german_grenadier_mp" && var_0 != "killstreak_molotov_cocktail_mp" && var_0 != "killstreak_molotov_cocktail_grenadier_mp" && var_0 != "teslagun_war_moon_mp")
    return 1;

  return 0;
}

_id_A227() {
  level endon("game_ended");
  self endon("deleted");

  for(;;) {
    self._id_9D65 waittill("trigger", var_0);

    if(!maps\mp\_utility::isreallyalive(var_0)) {
      continue;
    }
    if(!_id_1F53(var_0.pers["team"])) {
      continue;
    }
    if(!var_0 isonground()) {
      continue;
    }
    if(var_0 isdodging()) {
      continue;
    }
    if(var_0 _id_2956()) {
      continue;
    }
    if(!_id_21CA(var_0)) {
      if(isDefined(self._id_6AC9))
        self[[self._id_6AC9]](var_0);

      continue;
    }

    if(isDefined(self._id_1F84) && ![[self._id_1F84]](var_0)) {
      continue;
    }
    if(!var_0 common_scripts\utility::_id_5851()) {
      continue;
    }
    var_1 = 1;
    var_2 = self._id_A23F;

    if(isDefined(self._id_6E79))
      var_2 = self._id_6E79._id_A23F;

    if(var_2 > 0) {
      if(isDefined(self._id_6ABC))
        self[[self._id_6ABC]](var_0);

      if(isDefined(self._id_6E79) && isDefined(self._id_6E79._id_6ABC))
        self._id_6E79[[self._id_6E79._id_6ABC]](var_0);

      if(!isDefined(self._id_59E8))
        thread _id_1F78();

      var_3 = var_0.pers["team"];
      var_1 = _id_A213(var_0);
      self notify("finished_use");

      if(isDefined(self._id_6AFA))
        self[[self._id_6AFA]](var_3, var_0, var_1);

      if(isDefined(self._id_6E79) && isDefined(self._id_6E79._id_6AFA))
        self._id_6E79[[self._id_6E79._id_6AFA]](var_3, var_0, var_1);
    }

    if(!var_1) {
      continue;
    }
    if(isDefined(self._id_6BBF))
      self[[self._id_6BBF]](var_0);

    if(isDefined(self._id_6E79) && isDefined(self._id_6E79._id_6BBF))
      self._id_6E79[[self._id_6E79._id_6BBF]](var_0);
  }
}

_id_21CA(var_0) {
  if(!isDefined(self._id_59E8))
    return 1;

  if(!isDefined(var_0._id_2016))
    return 0;

  var_1 = self._id_59E8;

  if(!_isarray(var_1))
    var_1 = [var_1];

  foreach(var_3 in var_1) {
    if(var_3 == var_0._id_2016)
      return 1;
  }

  return 0;
}

_id_1F78() {
  level endon("game_ended");
  self endon("deleted");
  self endon("finished_use");

  for(;;) {
    self._id_9D65 waittill("trigger", var_0);

    if(!maps\mp\_utility::isreallyalive(var_0)) {
      continue;
    }
    if(!_id_1F53(var_0.pers["team"])) {
      continue;
    }
    if(isDefined(self._id_6AC9))
      self[[self._id_6AC9]](var_0);
  }
}

_id_44AF() {
  var_0 = self._id_230F;

  if(maps\mp\_utility::isreallyalive(self._id_230E))
    var_1 = self._id_230E;
  else
    var_1 = undefined;

  if(self._id_9AC3[var_0].size > 0) {
    var_2 = undefined;
    var_3 = getarraykeys(self._id_9AC3[var_0]);

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      var_5 = self._id_9AC3[var_0][var_3[var_4]];

      if(maps\mp\_utility::isreallyalive(var_5.player) && (!isDefined(var_2) || var_5.starttime < var_2)) {
        var_1 = var_5.player;
        var_2 = var_5.starttime;
      }
    }
  }

  return var_1;
}

_id_A225() {
  level endon("game_ended");
  self endon("deleted");
  thread _id_779A();

  for(;;) {
    if(self._id_A23F && self._id_28D5 >= self._id_A23F) {
      if(!self._id_59DD)
        self._id_28D5 = 0;

      if(self._id_5107 || common_scripts\utility::_id_562E(self.cancapwithoutclaim))
        var_0 = self._id_230E;
      else
        var_0 = _id_44AF();

      if(isDefined(self._id_6AFA))
        self[[self._id_6AFA]](_id_445B(), var_0, isDefined(var_0));

      if(isDefined(var_0) && isDefined(self._id_6BBF))
        self[[self._id_6BBF]](var_0);

      if(!self._id_65BF) {
        _id_864E("none");
        self._id_230E = undefined;
      }
    }

    if(self._id_230F != "none") {
      if(self._id_A23F && (!self._id_65BF || _id_45F7() != _id_445B())) {
        if(!self._id_689F[self._id_230F] || _id_5108() || common_scripts\utility::_id_562E(self._id_A414) && isDefined(self._id_1F84) && ![[self._id_1F84]](self._id_230E)) {
          if(isDefined(self._id_6AFA))
            self[[self._id_6AFA]](_id_445B(), self._id_230E, 0);

          _id_864E("none");

          if(!common_scripts\utility::_id_562E(self.cancapwithoutclaim))
            self._id_230E = undefined;
        } else {
          self._id_28D5 = self._id_28D5 + 50 * self._id_A22B;

          if(self._id_28D5 <= 0) {
            self._id_28D5 = self._id_28D5 * -1;
            self._id_5B82 = self._id_230F;
            _id_A18F();
          }

          if(isDefined(self._id_6BCB))
            self[[self._id_6BCB]](_id_445B(), self._id_28D5 / self._id_A23F, 50 * self._id_A22B / self._id_A23F);
        }
      } else if(!self._id_65BF) {
        if(isDefined(self._id_6BBF))
          self[[self._id_6BBF]](self._id_230E);

        if(!self._id_65BF) {
          _id_864E("none");

          if(!common_scripts\utility::_id_562E(self.cancapwithoutclaim))
            self._id_230E = undefined;
        }
      } else if(!self._id_689F[self._id_230F]) {
        if(isDefined(self._id_6BBD))
          self[[self._id_6BBD]]();

        _id_864E("none");

        if(!common_scripts\utility::_id_562E(self.cancapwithoutclaim))
          self._id_230E = undefined;
      } else if(self._id_1F49) {
        var_1 = _id_45CB(self._id_230F);

        if(var_1 > 0) {
          if(isDefined(self._id_6AD0))
            self[[self._id_6AD0]]();

          _id_864E("none");

          if(!common_scripts\utility::_id_562E(self.cancapwithoutclaim))
            self._id_230E = undefined;
        }
      }
    } else if(self._id_65BF && _id_45F7() != "none") {
      if(!self._id_689F[_id_45F7()]) {
        if(isDefined(self._id_6BBD))
          self[[self._id_6BBD]]();
      } else if(self._id_1F49 && self._id_5B82 != "none" && self._id_689F[self._id_5B82]) {
        var_1 = _id_45CB(self._id_5B82);

        if(var_1 == 0) {
          if(isDefined(self._id_6BBB))
            self[[self._id_6BBB]](self._id_5B82);
        }
      }
    }

    waitframe();
    maps\mp\gametypes\_hostmigration::_id_A782();
  }
}

_id_1F47(var_0) {
  if(isDefined(self.carrier))
    return 0;

  if(self._id_5107 && !_id_5108())
    return 0;

  if(self._id_1F49) {
    var_1 = _id_45CB(var_0.pers["team"]);

    if(var_1 != 0)
      return 0;
  }

  if(_id_21CA(var_0))
    return 1;

  return 0;
}

_id_779A() {
  level endon("game_ended");
  self endon("deleted");
  var_0 = self._id_37D8;

  for(;;) {
    if(!isDefined(self) | !isDefined(self._id_9D65)) {
      return;
    }
    self._id_9D65 waittill("trigger", var_1);

    if(!maps\mp\_utility::isreallyalive(var_1)) {
      continue;
    }
    if(!maps\mp\_utility::_id_56FF(var_1)) {
      continue;
    }
    if(!self._id_9D65 _meth_8691(var_1)) {
      continue;
    }
    if(isDefined(self.carrier)) {
      continue;
    }
    if(var_1 maps\mp\_utility::isusingremote() || isDefined(var_1._id_9071) || var_1 maps\mp\_utility::_id_572D()) {
      continue;
    }
    if(isDefined(var_1.classname) && var_1.classname == "script_vehicle") {
      continue;
    }
    if(!isDefined(var_1._id_52F8)) {
      continue;
    }
    if(isDefined(self._id_66D5) && self._id_66D5 > gettime()) {
      continue;
    }
    if(isDefined(self._id_1F84) && ![[self._id_1F84]](var_1)) {
      continue;
    }
    if(_id_1F53(var_1.pers["team"], var_1) && self._id_230F == "none") {
      if(_id_1F47(var_1)) {
        if(common_scripts\utility::_id_562E(self.requireslos)) {
          if(isDefined(self._id_1F6A))
            var_2 = self[[self._id_1F6A]](var_1, self._id_A582);
          else
            var_2 = _id_7799(var_1, self._id_A582);

          if(!var_2)
            continue;
        }

        if(common_scripts\utility::_id_562E(self.requirescontinuouslos) && isDefined(self._id_1F6A) && !self[[self._id_1F6A]](var_1, self._id_A582)) {
          continue;
        }
        if(self._id_5107 && (!isDefined(self._id_5B81) || var_1 != self._id_5B81))
          self._id_28D5 = 0;

        _id_864E(var_1.pers["team"]);
        self._id_230E = var_1;

        if(self._id_5107)
          self._id_5B81 = var_1;

        var_3 = _id_4663(var_1.pers["team"]);

        if(isDefined(self._id_986E[var_3]))
          self._id_A23F = self._id_986E[var_3];

        if(self._id_A23F && isDefined(self._id_6ABC))
          self[[self._id_6ABC]](self._id_230E);
      } else if(isDefined(self._id_6AC9))
        self[[self._id_6AC9]](var_1);
    }

    if(maps\mp\_utility::isreallyalive(var_1) && !isDefined(var_1._id_9AC5[var_0]))
      var_1 thread _id_9DC3(self);
  }
}

_id_7799(var_0, var_1) {
  var_2 = [32, 16, 0];
  var_3 = undefined;

  if(isDefined(var_1) && var_1.size) {
    if(var_1.size > 1 && !issubstr(level.gametype, "ctf")) {}

    var_3 = var_1[0];
  }

  var_4 = var_0.origin - self._id_9D65.origin;
  var_4 = (var_4[0], var_4[1], 0);
  var_4 = vectorNormalize(var_4);
  var_4 = var_4 * 5;

  foreach(var_6 in var_2) {
    var_7 = var_0 getEye();
    var_8 = self._id_9D65.origin + var_4 + (0, 0, var_6);
    var_9 = bulletTrace(var_7, var_8, 0, var_3, 0, 0, 0, 0, 1, 0, 0);

    if(var_9["fraction"] == 1)
      return 1;
  }

  return 0;
}

_id_864E(var_0) {
  if(!common_scripts\utility::_id_562E(self.cancapwithoutclaim)) {}

  if(self._id_59DD) {
    if(self._id_5B82 == "none")
      self._id_5B82 = var_0;

    self._id_230F = var_0;
  } else {
    if(self._id_230F == "none" && gettime() - self._id_5B83 > 1000)
      self._id_28D5 = 0;
    else if(var_0 != "none" && var_0 != self._id_5B82)
      self._id_28D5 = 0;

    self._id_5B82 = self._id_230F;
  }

  self._id_5B83 = gettime();
  self._id_230F = var_0;
  _id_A18F();
}

_id_445B() {
  return self._id_230F;
}

_id_9DC3(var_0) {
  var_0 endon("death");
  var_1 = self.pers["team"];
  var_0._id_689F[var_1]++;
  var_2 = self.guid;
  var_3 = spawnStruct();
  var_3.player = self;
  var_3.starttime = gettime();
  var_0._id_9AC3[var_1][var_2] = var_3;

  if(isDefined(var_0._id_6BB8))
    var_0[[var_0._id_6BB8]](self);

  if(!isDefined(var_0._id_681A))
    var_0._id_681A = 0;

  self._id_9AC5[var_0._id_37D8] = var_0._id_9D65;

  if(isDefined(level._id_3FCF))
    self[[level._id_3FCF]](var_0);

  var_0 _id_A18F();

  while(maps\mp\_utility::isreallyalive(self) && isDefined(var_0._id_9D65) && self istouching(var_0._id_9D65) && !level.gameended) {
    if(common_scripts\utility::_id_562E(var_0.requirescontinuouslos) && isDefined(var_0._id_1F6A) && !var_0[[var_0._id_1F6A]](self, var_0._id_A582)) {
      break;
    }

    if(isPlayer(self) && var_0._id_A23F) {
      _id_A18A(var_0, 1);

      if(isDefined(level._id_3FCE))
        self[[level._id_3FCE]](var_0, 0);
      else
        _id_A156(var_0, 0);
    }

    waitframe();
  }

  if(isDefined(self) && isDefined(self._id_9AC5)) {
    if(isPlayer(self) && var_0._id_A23F) {
      _id_A18A(var_0, 0);

      if(isDefined(level._id_3FCE))
        self[[level._id_3FCE]](var_0, 1);
      else
        _id_A156(var_0, 1);
    }

    self._id_9AC5[var_0._id_37D8] = undefined;

    if(isDefined(var_0._id_6BB9))
      var_0[[var_0._id_6BB9]](self);
  }

  if(level.gameended) {
    return;
  }
  var_0._id_9AC3[var_1][var_2] = undefined;
  var_0._id_689F[var_1]--;
  var_0 _id_A18F();

  if(isDefined(level._id_3FD0))
    self[[level._id_3FD0]](var_0);
}

_id_A156(var_0, var_1) {
  var_2 = self.pers["team"];

  if(var_1 || !var_0 _id_1F53(var_2) || var_2 != var_0._id_230F || var_0._id_681A) {
    if(isDefined(self._id_7794))
      self._id_7794 maps\mp\gametypes\_hud_util::_id_4D06();

    if(isDefined(self._id_7795))
      self._id_7795 maps\mp\gametypes\_hud_util::_id_4D06();

    return;
  }

  if(!isDefined(self._id_7794)) {
    self._id_7794 = maps\mp\gametypes\_hud_util::_id_2821();
    self._id_7794._id_5C0C = undefined;
    self._id_7794._id_5BAA = 0;
  }

  if(self._id_7794._id_4CC7) {
    self._id_7794 maps\mp\gametypes\_hud_util::_id_8BF6();
    self._id_7794._id_5C0C = undefined;
    self._id_7794._id_5BAA = 0;
  }

  if(!isDefined(self._id_7795)) {
    self._id_7795 = maps\mp\gametypes\_hud_util::_id_2822();
    var_3 = var_0 _id_4663(var_2);

    if(isDefined(var_0._id_986D[var_3]))
      self._id_7795 settext(var_0._id_986D[var_3]);
    else
      self._id_7795 settext(var_0._id_A23D);
  }

  if(self._id_7795._id_4CC7) {
    self._id_7795 maps\mp\gametypes\_hud_util::_id_8BF6();
    var_3 = var_0 _id_4663(var_2);

    if(isDefined(var_0._id_986D[var_3]))
      self._id_7795 settext(var_0._id_986D[var_3]);
    else
      self._id_7795 settext(var_0._id_A23D);
  }

  if(!isDefined(self._id_7794._id_5C0C) || self._id_7794._id_5C0C != var_0._id_A22B || self._id_7794._id_5BAA != isDefined(level.hostmigrationtimer)) {
    if(var_0._id_28D5 > var_0._id_A23F)
      var_0._id_28D5 = var_0._id_A23F;

    var_4 = var_0._id_28D5 / var_0._id_A23F;
    var_5 = 1000 / var_0._id_A23F * var_0._id_A22B;

    if(isDefined(level.hostmigrationtimer))
      var_5 = 0;

    if(var_0._id_59DD && !var_4 && var_5 < 0)
      var_5 = 0;

    self._id_7794 maps\mp\gametypes\_hud_util::_id_A0E3(var_4, var_5);
    self._id_7794._id_5C0C = var_0._id_A22B;
    self._id_7794._id_5BAA = isDefined(level.hostmigrationtimer);
  }
}

_id_45CB(var_0) {
  return self._id_689F[maps\mp\_utility::getotherteam(var_0)];
}

_id_A18A(var_0, var_1) {
  var_2 = level.gametype;
  var_3 = var_0._id_502A;

  if(!isDefined(level.hostmigrationtimer)) {
    if(var_0._id_28D5 > var_0._id_A23F)
      var_0._id_28D5 = var_0._id_A23F;

    var_4 = var_0._id_28D5 / var_0._id_A23F;

    if((var_2 == "dom" || var_2 == "assault" || var_2 == "control") && isDefined(var_3) && var_3 == "domFlag") {
      if(!var_1 || var_0._id_6DB2 == self.team || var_0._id_230F != self.team)
        var_4 = 0.01;

      if(var_4 != 0)
        self setclientomnvar("ui_capture_progress", var_4);
    }

    var_5 = var_2 == "sd";

    if((var_5 || var_2 == "assault" || var_2 == "control" || var_2 == "sr" || var_2 == "demo") && isDefined(var_3) && (var_3 == "bombZone" || var_3 == "defuseObject")) {
      if(!var_1)
        var_4 = 0;

      var_4 = max(0.01, var_4);

      if(var_4 != 0)
        self setclientomnvar("ui_capture_progress", var_4);

      if(var_5)
        self setclientomnvar("ui_capture_progress_global", var_4);
    }

    if(isDefined(var_3) && (var_2 == "twar" && var_3 == "twarZone")) {
      if(!var_1)
        var_4 = 0;

      var_4 = max(0.01, var_4);

      if(var_4 != 0)
        self setclientomnvar("ui_capture_progress", var_4);
    }

    if(isDefined(var_3) && var_2 == "raid") {
      if(var_3 == "raidZoneCaptureHP" || var_3 == "raidZoneCaptureDom" || var_3 == "raidZoneCaptureTwar" || var_3 == "raidConstruct" || var_3 == "raidRepair" || var_3 == "raidPlantExplosive" || var_3 == "raidDefuseExplosive") {
        if(!var_1)
          var_4 = 0;

        var_4 = max(0.01, var_4);

        if(var_4 != 0)
          self setclientomnvar("ui_capture_progress", var_4);
      }
    }

    if(var_2 == "zombies" && isDefined(var_3) && var_3 == "defuseObject") {
      if(!var_1)
        var_4 = 0;

      var_4 = max(0.01, var_4);

      if(var_4 != 0)
        self setclientomnvar("ui_capture_progress", var_4);
    }
  }

  if((var_2 == "dom" || var_2 == "assault" || var_2 == "control") && isDefined(var_3) && var_3 == "domFlag") {
    if(var_1 && isDefined(var_0._id_915C) && var_0._id_915C) {
      if(var_0.label == "_a")
        self setclientomnvar("ui_capture_icon", 4);
      else if(var_0.label == "_b")
        self setclientomnvar("ui_capture_icon", 5);
      else if(var_0.label == "_c")
        self setclientomnvar("ui_capture_icon", 6);

      self setclientomnvar("ui_capture_status_index", 2);
    } else if(var_1 && var_0._id_6DB2 == "neutral") {
      if(var_0.label == "_a")
        self setclientomnvar("ui_capture_icon", 7);
      else if(var_0.label == "_b")
        self setclientomnvar("ui_capture_icon", 8);
      else if(var_0.label == "_c")
        self setclientomnvar("ui_capture_icon", 9);

      self setclientomnvar("ui_capture_status_index", 1);
    } else if(var_1 && var_0._id_6DB2 != self.team) {
      if(var_0.label == "_a")
        self setclientomnvar("ui_capture_icon", 1);
      else if(var_0.label == "_b")
        self setclientomnvar("ui_capture_icon", 2);
      else if(var_0.label == "_c")
        self setclientomnvar("ui_capture_icon", 3);

      self setclientomnvar("ui_capture_status_index", 1);
    } else {
      self setclientomnvar("ui_capture_icon", 0);
      self setclientomnvar("ui_capture_status_index", 0);
    }
  }

  if((var_2 == "sd" || var_2 == "sr" || var_2 == "demo") && isDefined(var_3) && (var_3 == "bombZone" || var_3 == "defuseObject")) {
    if(!var_1)
      self setclientomnvar("ui_capture_icon", 0);
    else if(var_0 _id_56FB(self.pers["team"]))
      self setclientomnvar("ui_capture_icon", 2);
    else
      self setclientomnvar("ui_capture_icon", 1);
  }

  if(isDefined(var_3) && (var_2 == "twar" && var_3 == "twarZone")) {
    if(!var_1 || isDefined(var_0._id_915C) && var_0._id_915C)
      self setclientomnvar("ui_capture_icon", 0);
    else
      self setclientomnvar("ui_capture_icon", 1);
  }

  if(var_2 == "raid" && isDefined(var_3)) {
    if(var_1) {
      if(var_3 == "raidZoneCaptureHP") {
        if(common_scripts\utility::_id_562E(var_0._id_4D04)) {
          self setclientomnvar("ui_capture_icon", 0);
          self setclientomnvar("ui_capture_status_index", 0);
        } else if(common_scripts\utility::_id_562E(var_0._id_915C)) {
          self setclientomnvar("ui_capture_status_index", 2);
          self setclientomnvar("ui_capture_icon", 2);
        } else if(var_0 _id_1F53(self.pers["team"]) && self.pers["team"] == var_0._id_230F) {
          self setclientomnvar("ui_capture_status_index", 1);
          self setclientomnvar("ui_capture_icon", 1);
        } else {
          self setclientomnvar("ui_capture_icon", 0);
          self setclientomnvar("ui_capture_status_index", 0);
        }
      } else if(var_3 == "raidZoneCaptureDom") {
        if(common_scripts\utility::_id_562E(var_0._id_915C)) {
          self setclientomnvar("ui_capture_status_index", 2);
          self setclientomnvar("ui_capture_icon", 2);
        } else if(var_0._id_6DB2 == "neutral" || var_0._id_6DB2 != self.team) {
          self setclientomnvar("ui_capture_status_index", 1);
          self setclientomnvar("ui_capture_icon", 1);
        } else {
          self setclientomnvar("ui_capture_icon", 0);
          self setclientomnvar("ui_capture_status_index", 0);
        }
      } else if(var_3 == "raidZoneCaptureTwar") {
        if(var_0._id_28D5 < var_0._id_A23F || var_0._id_230F != "none") {
          if(!common_scripts\utility::_id_562E(var_0._id_915C)) {
            if(var_0._id_5B82 == "neutral" || var_0._id_5B82 == self.team) {
              self setclientomnvar("ui_capture_status_index", 1);
              self setclientomnvar("ui_capture_icon", 1);
            } else {
              self setclientomnvar("ui_capture_status_index", 3);
              self setclientomnvar("ui_capture_icon", 3);
            }
          } else {
            self setclientomnvar("ui_capture_status_index", 2);
            self setclientomnvar("ui_capture_icon", 2);
          }
        } else {
          self setclientomnvar("ui_capture_icon", 0);
          self setclientomnvar("ui_capture_status_index", 0);
        }
      } else if(var_3 == "raidConstruct") {
        self setclientomnvar("ui_capture_status_index", 4);
        self setclientomnvar("ui_capture_icon", 1);
      } else if(var_3 == "raidRepair") {
        self setclientomnvar("ui_capture_status_index", 5);
        self setclientomnvar("ui_capture_icon", 1);
      } else if(var_3 == "raidPlantExplosive") {
        self setclientomnvar("ui_capture_status_index", 6);
        self setclientomnvar("ui_capture_icon", 1);
      } else if(var_3 == "raidDefuseExplosive") {
        self setclientomnvar("ui_capture_status_index", 7);
        self setclientomnvar("ui_capture_icon", 1);
      }
    } else {
      self setclientomnvar("ui_capture_icon", 0);
      self setclientomnvar("ui_capture_status_index", 0);
    }
  }

  if(var_2 == "zombies" && isDefined(var_3) && var_3 == "defuseObject") {
    if(!var_1)
      self setclientomnvar("ui_capture_icon", 0);
    else
      self setclientomnvar("ui_capture_icon", 1);
  }
}

_id_A18F() {
  if(isDefined(self._id_6BBE))
    self[[self._id_6BBE]]();
  else
    _id_A190();
}

_id_A190() {
  var_0 = self._id_689F[self._id_230F];
  var_1 = 0;
  var_2 = 0;

  if(level._id_6520) {
    foreach(var_4 in level._id_985B) {
      if(self._id_230F != var_4)
        var_1 = var_1 + self._id_689F[var_4];
    }
  } else {
    if(self._id_230F != "axis")
      var_1 = var_1 + self._id_689F["axis"];

    if(self._id_230F != "allies")
      var_1 = var_1 + self._id_689F["allies"];
  }

  foreach(var_7 in self._id_9AC3[self._id_230F]) {
    if(!isDefined(var_7.player)) {
      continue;
    }
    if(var_7.player.pers["team"] != self._id_230F) {
      continue;
    }
    if(var_7.player._id_696D == 1) {
      continue;
    }
    if(level.gametype == "hp") {
      continue;
    }
    if(isDefined(self._id_502A) && self._id_502A == "raidEscortTrigger") {
      continue;
    }
    var_0 = var_0 * var_7.player._id_696D;
    var_2 = var_7.player._id_696D;
  }

  self._id_A22B = 0;
  self._id_915C = var_0 && var_1;

  if(var_0 && !var_1)
    self._id_A22B = _min(var_0, 4);

  if(isDefined(self._id_5676) && self._id_5676 && var_2 != 0)
    self._id_A22B = 1 * var_2;
  else if(isDefined(self._id_5676) && self._id_5676)
    self._id_A22B = 1;

  if(self._id_59DD && self._id_5B82 != self._id_230F)
    self._id_A22B = self._id_A22B * -1;
}

_id_115B() {
  self endon("death");
  self endon("disconnect");
  self endon("done_using");
  wait 0.7;
  self attach("npc_gen_s_and_d_bomb", "tag_inhand", 1);
  self._id_1147 = "npc_gen_s_and_d_bomb";
}

_id_9BA8() {
  thread _id_2383();
  level endon("game_ended");
  level endon("zone_moved");

  for(;;) {
    foreach(var_1 in level.players) {
      if(var_1 istouching(self._id_9D65)) {
        var_1 _meth_8608(1);
        continue;
      }

      var_1 _meth_8608(0);
    }

    wait 0.5;
  }
}

_id_2383() {
  level common_scripts\utility::_id_A70A("game_ended", "zone_moved");

  foreach(var_1 in level.players)
  var_1 _meth_8608(0);
}

_id_A213(var_0) {
  var_0 notify("use_hold");

  if(common_scripts\utility::_id_562E(self._id_2F90)) {
    var_0 _meth_8546(0);
    var_0 disableoffhandweapons();
  } else if(isPlayer(var_0))
    var_0 playerlinkto(self._id_9D65);
  else
    var_0 linkto(self._id_9D65);

  var_0 clientclaimtrigger(self._id_9D65);
  var_0._id_2310 = self._id_9D65;
  var_1 = self._id_A248;
  var_2 = var_0 getcurrentweapon();

  if(isDefined(var_0.carryweapon) && _id_04CB::_id_574C(var_2))
    var_2 = var_0.carryweapon;

  if(_id_051E::doeskillstreakweaponstowammo(var_2)) {
    var_3 = var_0 getweaponammoclip(var_2);
    var_4 = var_0 getweaponammostock(var_2);

    if(var_3 + var_4 <= 0)
      var_2 = var_0.disconnectnode;
  }

  if(isDefined(var_1)) {
    if(maps\mp\_utility::isuseweapon(var_2))
      var_2 = var_0._id_5BC5;

    var_0._id_5BC5 = var_2;
    var_0 maps\mp\_utility::_giveweapon(var_1);
    var_0 disableoffhandweapons();
    var_0 setweaponammostock(var_1, 0);
    var_0 setweaponammoclip(var_1, 0);
    var_0 switchtoweapon(var_1);
    var_0.hasuseweapon = 1;

    if(!isDefined(self._id_113F) || self._id_113F == 1)
      var_0 thread _id_115B();
  } else
    var_0 common_scripts\utility::_id_0602();

  var_5 = var_0 getentitynumber();

  if(isDefined(self._id_6E79)) {
    if(!self._id_6E79._id_5F95 && self._id_6E79._id_54F6.size == 0)
      self._id_6E79._id_28D5 = 0;

    self._id_54F5 = 1;
    self._id_6E79._id_54F6[var_5] = 1;
    self._id_6E79._id_A22B[var_5] = 0;

    if(isPlayer(var_0)) {
      if(isDefined(level._id_3FD1))
        var_0 thread[[level._id_3FD1]](self._id_6E79);
      else
        var_0 thread _id_6F82(self._id_6E79);
    }
  } else {
    if(!self._id_5F95)
      self._id_28D5 = 0;

    self._id_54F5 = 1;
    self._id_A22B = 0;

    if(isPlayer(var_0)) {
      if(isDefined(level._id_3FD1))
        var_0 thread[[level._id_3FD1]](self);
      else
        var_0 thread _id_6F82(self);
    }
  }

  var_6 = _id_A214(var_0, var_2);

  if(isDefined(var_0)) {
    var_0 _id_2E46();
    var_0 notify("done_using");
  }

  if(isDefined(var_1) && isDefined(var_0))
    var_0 thread _id_95F5(var_1);

  if(isDefined(var_6) && var_6)
    return 1;

  if(isDefined(var_0)) {
    var_0._id_2310 = undefined;

    if(isDefined(var_1)) {
      var_0.hasuseweapon = undefined;

      if(var_2 != "none") {
        if(common_scripts\utility::_id_562E(self._id_7894))
          var_0 maps\mp\_utility::_id_955D(var_2);
        else
          var_0 maps\mp\_utility::_id_955C(var_2);
      } else
        var_0 takeweapon(var_1);
    } else
      var_0 common_scripts\utility::_id_0616();

    if(common_scripts\utility::_id_562E(self._id_2F90))
      var_0 _meth_8546(1);
    else
      var_0 unlink();

    if(!maps\mp\_utility::isreallyalive(var_0))
      var_0._id_5A3E = 1;
  }

  self._id_54F5 = 0;

  if(isDefined(self._id_6E79)) {
    self._id_6E79._id_54F6[var_5] = undefined;
    self._id_6E79._id_A22B[var_5] = 0;
  }

  self._id_9D65 releaseclaimedtrigger();
  return 0;
}

_id_2E46() {
  if(isDefined(self._id_1147)) {
    self detach(self._id_1147, "tag_inhand");
    self._id_1147 = undefined;
  }
}

_id_95F5(var_0) {
  self endon("use_hold");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(self getcurrentweapon() == var_0 && !isDefined(self.throwinggrenade))
    waitframe();

  self enableoffhandweapons();
  self takeweapon(var_0);
}

_id_A23B(var_0, var_1, var_2, var_3) {
  if(!maps\mp\_utility::isreallyalive(var_0))
    return 0;

  if(!var_0 istouching(self._id_9D65))
    return 0;

  if(!var_0 usebuttonpressed())
    return 0;

  if(isDefined(var_0.throwinggrenade))
    return 0;

  if(isDefined(self._id_6E79)) {
    if(self._id_6E79._id_A23C && var_0 meleebuttonpressed())
      return 0;

    if(self._id_6E79._id_28D5 >= self._id_6E79._id_A23F)
      return 0;

    if(!_id_45D4(self._id_6E79) && !var_1)
      return 0;
  } else {
    if(self._id_A23C && var_0 meleebuttonpressed())
      return 0;

    if(self._id_28D5 >= self._id_A23F)
      return 0;

    if(!self._id_A22B && !var_1)
      return 0;
  }

  if(var_1 && var_2 > var_3)
    return 0;

  return 1;
}

_id_A214(var_0, var_1) {
  level endon("game_ended");
  self endon("disabled");
  var_0 endon("stop_useHoldThinkLoop");
  var_2 = self._id_A248;
  var_3 = 1;
  var_4 = 0;
  var_5 = 1.5;
  var_6 = var_0 getentitynumber();
  var_7 = var_0._id_696D;

  while(_id_A23B(var_0, var_3, var_4, var_5)) {
    var_4 = var_4 + 0.05;

    if(!isDefined(var_2) || var_0 getcurrentweapon() == var_2) {
      if(isDefined(self._id_6E79)) {
        if(isDefined(self._id_6E79._id_695A) && issubstr(self._id_6E79._id_695A, "bridge_"))
          var_7 = 1;

        self._id_6E79._id_28D5 = self._id_6E79._id_28D5 + 50 * self._id_6E79._id_A22B[var_6];
        self._id_6E79._id_A22B[var_6] = 1 * var_7;

        if(isDefined(self._id_6E79._id_A22C))
          self._id_6E79._id_A22B[var_6] = self._id_6E79._id_A22B[var_6] * self[[self._id_6E79._id_A22C]](var_0);

        if(var_3 && isDefined(self._id_6E79._id_A212))
          self._id_6E79[[self._id_6E79._id_A212]](var_0);
      } else {
        if(isDefined(self._id_502A)) {
          if(issubstr(self._id_502A, "raidZoneCaptureTwar"))
            var_7 = 1;

          if(isDefined(self._id_695A) && (issubstr(self._id_695A, "gun_") || issubstr(self._id_695A, "bomb_") || issubstr(self._id_695A, "town_bombplant")) && (issubstr(self._id_502A, "raidDefuseExplosive") || issubstr(self._id_502A, "raidPlantExplosive")))
            var_7 = 1;
        }

        if(isDefined(self._id_A248)) {
          if(self._id_A248 == "war_generic_open_mp")
            var_7 = 1;
        }

        if(isDefined(self._id_695A)) {
          if(issubstr(self._id_695A, "hostage_"))
            var_7 = 1;
        }

        self._id_28D5 = self._id_28D5 + 50 * self._id_A22B;
        self._id_A22B = 1 * var_7;

        if(var_3 && isDefined(self._id_A212))
          self[[self._id_A212]](var_0);
      }

      var_3 = 0;
    } else if(isDefined(self._id_6E79))
      self._id_6E79._id_A22B[var_6] = 0;
    else
      self._id_A22B = 0;

    if(isDefined(self._id_6E79))
      var_8 = self._id_6E79._id_28D5 >= self._id_6E79._id_A23F;
    else
      var_8 = self._id_28D5 >= self._id_A23F;

    if(var_8) {
      if(isDefined(self._id_6E79))
        self._id_6E79._id_54F6 = [];

      self._id_54F5 = 0;
      var_0 clientreleasetrigger(self._id_9D65);
      var_0._id_2310 = undefined;

      if(isDefined(var_2)) {
        var_0 setweaponammostock(var_2, 1);
        var_0 setweaponammoclip(var_2, 1);
        var_0.hasuseweapon = undefined;

        if(var_1 != "none")
          var_0 maps\mp\_utility::_id_955C(var_1);
        else
          var_0 takeweapon(var_2);
      } else
        var_0 common_scripts\utility::_id_0616();

      if(common_scripts\utility::_id_562E(self._id_2F90))
        var_0 _meth_8546(1);
      else
        var_0 unlink();

      return maps\mp\_utility::isreallyalive(var_0);
    }

    waitframe();
    maps\mp\gametypes\_hostmigration::_id_A782();
  }

  return 0;
}

_id_A226(var_0) {
  var_1 = spawnStruct();

  foreach(var_3 in var_0) {
    var_3._id_6E79 = var_1;
    var_3._id_28D5 = undefined;
    var_3._id_A23F = undefined;
    var_3._id_A22B = undefined;
    var_3._id_5F95 = undefined;
  }

  var_1._id_576E = 1;
  var_1._id_28D5 = 0;
  var_1._id_A22B = [];
  var_1._id_5F95 = 0;
  var_1._id_21F7 = var_0;
  var_1._id_54F6 = [];
  var_1._id_A23C = 1;
  return var_1;
}

_id_6F82(var_0) {
  self endon("disconnect");
  var_1 = undefined;

  if(!isDefined(var_0._id_681A) || !var_0._id_681A)
    var_1 = maps\mp\gametypes\_hud_util::_id_2821();

  var_2 = undefined;

  if(isDefined(var_1) && isDefined(var_0._id_A23D)) {
    var_2 = maps\mp\gametypes\_hud_util::_id_2822();
    var_2 settext(var_0._id_A23D);
  }

  var_3 = -1;
  var_4 = isDefined(level.hostmigrationtimer);

  while(maps\mp\_utility::isreallyalive(self) && _id_A224(var_0) && !level.gameended) {
    if(var_3 != _id_45D4(var_0) || var_4 != isDefined(level.hostmigrationtimer)) {
      if(var_0._id_28D5 > var_0._id_A23F)
        var_0._id_28D5 = var_0._id_A23F;

      var_5 = var_0._id_28D5 / var_0._id_A23F;
      var_6 = 1000 / var_0._id_A23F * _id_45D4(var_0);

      if(isDefined(level.hostmigrationtimer))
        var_6 = 0;

      if(isDefined(var_1)) {
        var_1 maps\mp\gametypes\_hud_util::_id_A0E3(var_5, var_6);

        if(!_id_45D4(var_0)) {
          var_1 maps\mp\gametypes\_hud_util::_id_4D06();

          if(isDefined(var_2))
            var_2 maps\mp\gametypes\_hud_util::_id_4D06();
        } else {
          var_1 maps\mp\gametypes\_hud_util::_id_8BF6();

          if(isDefined(var_2))
            var_2 maps\mp\gametypes\_hud_util::_id_8BF6();
        }
      }
    }

    var_3 = _id_45D4(var_0);
    var_4 = isDefined(level.hostmigrationtimer);
    _id_A18A(var_0, 1);
    waitframe();
  }

  _id_A18A(var_0, 0);

  if(isDefined(var_1))
    var_1 maps\mp\gametypes\_hud_util::destroyelem();

  if(isDefined(var_2))
    var_2 maps\mp\gametypes\_hud_util::destroyelem();
}

_id_45D4(var_0) {
  if(common_scripts\utility::_id_562E(var_0._id_576E)) {
    var_1 = 0;

    foreach(var_3 in var_0._id_A22B)
    var_1 = var_1 + var_3;

    return var_1;
  } else
    return var_0._id_A22B;
}

_id_A224(var_0) {
  if(common_scripts\utility::_id_562E(var_0._id_576E))
    return isDefined(var_0._id_54F6[self getentitynumber()]);
  else
    return var_0._id_54F5;
}

_id_A182() {
  if(self._id_9DC4 != "use") {
    return;
  }
  if(self._id_5412 == "none")
    self._id_9D65.origin = self._id_9D65.origin - (0, 0, 50000);
  else if(self._id_5412 == "any") {
    self._id_9D65.origin = self._id_28D4;
    self._id_9D65 setteamfortrigger("none");
  } else if(self._id_5412 == "friendly") {
    self._id_9D65.origin = self._id_28D4;

    if(self._id_6DB2 == "allies")
      self._id_9D65 setteamfortrigger("allies");
    else if(self._id_6DB2 == "axis")
      self._id_9D65 setteamfortrigger("axis");
    else
      self._id_9D65.origin = self._id_9D65.origin - (0, 0, 50000);
  } else if(self._id_5412 == "enemy") {
    self._id_9D65.origin = self._id_28D4;

    if(self._id_6DB2 == "allies")
      self._id_9D65 setteamfortrigger("axis");
    else if(self._id_6DB2 == "axis")
      self._id_9D65 setteamfortrigger("allies");
    else
      self._id_9D65 setteamfortrigger("none");
  }
}

_id_86DF(var_0, var_1, var_2) {
  var_0.color = game["dvar_color_names"]["plaintext"];
  var_0._id_002A = game["dvar_color_names"][self._id_AA8B[var_2]];
  var_3 = _id_471F(self._id_2562[var_2]);

  if(var_3 != "")
    var_0._id_0175 = game["dvar_color_names"][var_3];
}

_id_A19B() {
  if(self._id_A560 == "any") {
    _id_A19A("friendly", 1);
    _id_A19A("enemy", 1);
  } else if(self._id_A560 == "friendly") {
    _id_A19A("friendly", 1);
    _id_A19A("enemy", 0);
  } else if(self._id_A560 == "enemy") {
    _id_A19A("friendly", 0);
    _id_A19A("enemy", 1);
  } else {
    _id_A19A("friendly", 0);
    _id_A19A("enemy", 0);
  }

  _id_A19A("broadcaster", 1);
}

_id_A19A(var_0, var_1) {
  if(!isDefined(self._id_AA8A[var_0]))
    var_1 = 0;

  var_2 = _id_4708(var_0);
  var_3 = _id_8BB2();

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_5 = "objpoint_" + var_2[var_4] + "_" + self._id_37D8;
    var_6 = _id_04EC::_id_45D6(var_5);

    if(!isDefined(var_6)) {
      continue;
    }
    var_6 notify("stop_flashing_thread");
    var_6 thread _id_04EC::_id_9401();

    if(var_1) {
      if(var_3)
        var_6 setshader(_id_471E(self._id_AA8A[var_0]), level._id_6998, level._id_6998);
      else
        var_6 setshader(self._id_AA8A[var_0], level._id_6998, level._id_6998, self._id_AA89[var_0]);

      var_6 fadeovertime(0.05);
      var_6.alpha = var_6._id_15F3;
      var_6._id_57CB = 1;

      if(isDefined(self._id_2562[var_0]))
        var_6 setwaypoint(1, 1, 0, 0, 0, 0, 0, 0, 0, 0, isDefined(self._id_356E) && self._id_356E);
      else
        var_6 setwaypoint(1, 0);

      if(var_3) {
        _id_86DF(var_6, var_2[var_4], var_0);
        var_6 _meth_864E(_id_471D(self._id_AA8A[var_0]), _id_4720(self._id_AA8A[var_0]));
      }

      if(self.type == "carryObject") {
        if(isDefined(self.carrier) && !_id_8B9A(var_0))
          var_6 settargetent(self.carrier);
        else if(!isDefined(self.carrier) && isDefined(self._id_695F) && self._id_695F)
          var_6 settargetent(self._id_A582[0]);
        else
          var_6 cleartargetent();
      }
    } else {
      var_6 fadeovertime(0.05);
      var_6.alpha = 0;
      var_6._id_57CB = 0;
      var_6 cleartargetent();
    }

    var_6 thread _id_4D1C();
  }
}

_id_4D1C() {
  self notify("hideWorldIconOnGameEnd");
  self endon("hideWorldIconOnGameEnd");
  self endon("death");
  level waittill("game_ended");

  if(isDefined(self))
    self.alpha = 0;
}

_id_A17A(var_0, var_1) {}

_id_A0FE() {
  if(self._id_A560 == "any") {
    _id_A0FD("friendly", 1);
    _id_A0FD("enemy", 1);
  } else if(self._id_A560 == "friendly") {
    _id_A0FD("friendly", 1);
    _id_A0FD("enemy", 0);
  } else if(self._id_A560 == "enemy") {
    _id_A0FD("friendly", 0);
    _id_A0FD("enemy", 1);
  } else {
    _id_A0FD("friendly", 0);
    _id_A0FD("enemy", 0);
  }

  _id_A0FD("broadcaster", 1);
}

_id_446B(var_0) {
  var_1 = 0;

  if(isDefined(var_0)) {
    if(var_0 == "friendly")
      var_1 = 1;
    else if(var_0 == "enemy")
      var_1 = 2;
    else if(var_0 == "contest")
      var_1 = 3;
  }

  return var_1;
}

_id_A142(var_0, var_1) {
  var_2 = self._id_AA8B[var_1];
  var_3 = _id_446B(var_2);
  var_4 = _id_471F(self._id_2562[var_1]);
  var_5 = _id_446B(var_4);
  _func_370(var_0, var_3, var_5);
}

_id_A0FD(var_0, var_1) {
  if(!isDefined(self._id_2562)) {
    return;
  }
  var_2 = _id_4708(var_0);
  var_3 = _id_8BB2();

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_5 = var_1;

    if(!var_5 && _id_8BA7(var_2[var_4]))
      var_5 = 1;

    var_6 = self._id_698A;

    if(var_2[var_4] == "axis")
      var_6 = self._id_698B;

    if(var_2[var_4] == "broadcaster")
      var_6 = self._id_698C;

    if(!isDefined(self._id_2562[var_0]) || !var_5) {
      _objective_state(var_6, "invisible");
      continue;
    }

    if(var_3) {
      var_7 = self._id_2562[var_0];
      _objective_icon(var_6, _id_471E(var_7));
      _func_36F(var_6, _id_471D(var_7), _id_4720(var_7));
      _id_A142(var_6, var_0);
    } else if(common_scripts\utility::_id_562E(self._id_A200))
      _objective_icon(var_6, self._id_2562[var_0], var_0);
    else
      _objective_icon(var_6, self._id_2562[var_0]);

    _objective_state(var_6, "active");

    if(self.type == "carryObject") {
      if(maps\mp\_utility::isreallyalive(self.carrier) && !_id_8B9A(var_0)) {
        _objective_onentity(var_6, self.carrier);
        continue;
      }

      if(isDefined(self._id_695F) && self._id_695F) {
        _objective_onentity(var_6, self._id_A582[0]);
        continue;
      }

      _objective_position(var_6, self._id_28D4);
    }
  }
}

_id_8B9A(var_0) {
  if(var_0 == "friendly" && self._id_6990)
    return 1;
  else if(var_0 == "enemy" && self._id_698F)
    return 1;

  return 0;
}

_id_4708(var_0) {
  var_1 = [];

  if(var_0 == "friendly") {
    if(_id_56FB("allies"))
      var_1[var_1.size] = "allies";

    if(_id_56FB("axis"))
      var_1[var_1.size] = "axis";
  } else if(var_0 == "enemy") {
    if(!_id_56FB("allies"))
      var_1[var_1.size] = "allies";

    if(!_id_56FB("axis"))
      var_1[var_1.size] = "axis";
  } else if(var_0 == "broadcaster")
    var_1[var_1.size] = "broadcaster";

  return var_1;
}

_id_8BA7(var_0) {
  if(var_0 == "broadcaster")
    return 0;

  if(!isDefined(self.carrier))
    return 0;

  if(self.carrier maps\mp\_utility::_hasperk("specialty_radarimmune") || self.carrier maps\mp\_utility::_hasperk("specialty_uavhidden"))
    return 0;

  return _getteamradar(var_0);
}

_id_A191() {
  self endon("death");
  self endon("carrier_cleared");

  for(;;) {
    level waittill("radar_status_change");
    _id_A0FE();
  }
}

_id_86EC(var_0) {
  self._id_6DB2 = var_0;
  _id_A182();
  _id_A0FE();
  _id_A19B();
}

_id_45F7() {
  return self._id_6DB2;
}

_id_8A5A(var_0) {
  self._id_A23F = int(var_0 * 1000);
}

_id_8A59(var_0) {
  self._id_A23D = var_0;
}

_id_8740(var_0, var_1) {
  self._id_986E[var_0] = int(var_1 * 1000);
}

_id_873F(var_0, var_1) {
  self._id_986D[var_0] = var_1;
}

_id_8A57(var_0) {
  self._id_9D65 sethintstring(var_0);
}

_id_0C1D(var_0) {
  self._id_5412 = var_0;
}

_id_0C30(var_0) {
  self._id_5412 = var_0;
  _id_A182();
}

_id_8A60(var_0) {
  self._id_A560 = var_0;
  _id_A0FE();
  _id_A19B();
}

_id_86CD(var_0) {
  if(var_0) {
    for(var_1 = 0; var_1 < self._id_A582.size; var_1++) {
      self._id_A582[var_1] show();

      if(self._id_A582[var_1].classname == "script_brushmodel" || self._id_A582[var_1].classname == "script_model") {
        foreach(var_3 in level.players) {
          if(var_3 istouching(self._id_A582[var_1]))
            var_3 maps\mp\_utility::_suicide();
        }

        self._id_A582[var_1] thread _id_5FBB();
      }
    }
  } else {
    for(var_1 = 0; var_1 < self._id_A582.size; var_1++) {
      self._id_A582[var_1] hide();

      if(self._id_A582[var_1].classname == "script_brushmodel" || self._id_A582[var_1].classname == "script_model") {
        self._id_A582[var_1] notify("changing_solidness");
        self._id_A582[var_1] notsolid();
      }
    }
  }
}

_id_5FBB() {
  self endon("death");
  self notify("changing_solidness");
  self endon("changing_solidness");

  for(;;) {
    for(var_0 = 0; var_0 < level.players.size; var_0++) {
      if(level.players[var_0] istouching(self)) {
        break;
      }
    }

    if(var_0 == level.players.size) {
      self solid();
      break;
    }

    waitframe();
  }
}

_id_8644(var_0) {
  self._id_200B = var_0;
}

_id_8640(var_0) {
  self._id_A23A = var_0;
}

_id_446C(var_0) {
  if(var_0 == 1)
    return "enemy";
  else if(var_0 == 2)
    return "friendly";
  else if(var_0 == 3)
    return "contest";
  else
    return "neutral";
}

set2dicon(var_0, var_1, var_2, var_3) {
  self._id_2562[var_0] = var_1;
  self._id_A200 = var_2;

  if(_id_8BB2()) {
    if(isDefined(var_3))
      self._id_AA8B[var_0] = _id_446C(var_3);
    else if(!isDefined(var_1))
      self._id_AA8B[var_0] = "neutral";
    else
      self._id_AA8B[var_0] = _id_471C(var_1);
  }

  _id_A0FE();
}

playsoundtoteam(var_0, var_1, var_2, var_3) {
  self._id_AA8A[var_0] = var_1;
  self._id_356E = var_3;

  if(!_id_8BB2()) {
    if(isDefined(var_2))
      self._id_AA89[var_0] = var_2;
    else
      self._id_AA89[var_0] = 0;
  } else if(isDefined(var_2))
    self._id_AA8B[var_0] = _id_446C(var_2);
  else if(!isDefined(var_1))
    self._id_AA8B[var_0] = "neutral";
  else
    self._id_AA8B[var_0] = _id_471C(var_1);

  _id_A19B();
}

scalepitch(var_0, var_1) {
  self._id_AA8D[var_0] = var_1;
}

_id_8645(var_0) {
  self.carryicon = var_0;
}

_id_471D(var_0) {
  if(!isDefined(level._id_A98F))
    maps\mp\gametypes\_gamelogic::_id_5367();

  var_1 = level._id_A98F[var_0];

  if(!isDefined(var_1))
    return 0;

  return var_1;
}

_id_4720(var_0) {
  if(!isDefined(level._id_A994))
    maps\mp\gametypes\_gamelogic::_id_5367();

  var_1 = level._id_A994[var_0];

  if(!isDefined(var_1))
    return "";

  return var_1;
}

_id_471E(var_0) {
  if(!isDefined(level._id_A98F))
    maps\mp\gametypes\_gamelogic::_id_5367();

  var_1 = level._id_A992[var_0];

  if(!isDefined(var_1))
    return 0;

  return var_1;
}

_id_471C(var_0) {
  if(!isDefined(level._id_A990))
    maps\mp\gametypes\_gamelogic::_id_5367();

  var_1 = level._id_A990[var_0];

  if(!isDefined(var_1))
    return "neutral";

  return var_1;
}

_id_471F(var_0) {
  if(!isDefined(level._id_A993))
    maps\mp\gametypes\_gamelogic::_id_5367();

  var_1 = level._id_A993[var_0];

  if(!isDefined(var_1))
    return "";

  return var_1;
}

_id_2F93() {
  self notify("disabled");

  if(self.type == "carryObject") {
    if(isDefined(self.carrier))
      self.carrier _id_95ED(self);

    for(var_0 = 0; var_0 < self._id_A582.size; var_0++)
      self._id_A582[var_0] hide();
  }

  self._id_9D65 common_scripts\utility::_id_9D9F();
  _id_8A60("none");
}

_id_365D() {
  if(self.type == "carryObject") {
    for(var_0 = 0; var_0 < self._id_A582.size; var_0++)
      self._id_A582[var_0] show();
  }

  self._id_9D65 common_scripts\utility::_id_9DA3();
  _id_8A60("any");
}

_id_4663(var_0) {
  if(var_0 == self._id_6DB2)
    return "friendly";
  else
    return "enemy";
}

_id_56FB(var_0) {
  var_1 = _id_445B();

  if(self._id_6DB2 == "neutral" && var_1 != "none" && var_1 != var_0)
    return 1;

  if(self._id_6DB2 == "any")
    return 1;

  if(self._id_6DB2 == var_0)
    return 1;

  return 0;
}

_id_1F53(var_0, var_1) {
  switch (self._id_5412) {
    case "none":
      return 0;
    case "any":
      return 1;
    case "friendly":
      if(var_0 == self._id_6DB2)
        return 1;
      else
        return 0;
    case "enemy":
      if(var_0 != self._id_6DB2)
        return 1;
      else
        return 0;
    default:
      return 0;
  }
}

_id_57FE(var_0) {
  if(var_0 == "neutral")
    return 1;

  if(var_0 == "allies")
    return 1;

  if(var_0 == "axis")
    return 1;

  if(var_0 == "any")
    return 1;

  if(var_0 == "none")
    return 1;

  foreach(var_2 in level._id_985B) {
    if(var_0 == var_2)
      return 1;
  }

  return 0;
}

_id_57A2(var_0) {
  if(var_0 == "friendly")
    return 1;

  if(var_0 == "enemy")
    return 1;

  if(var_0 == "any")
    return 1;

  if(var_0 == "none")
    return 1;

  return 0;
}

_id_44B9(var_0) {
  if(level._id_6520) {}

  if(var_0 == "neutral" || var_0 == "none")
    return "none";
  else if(var_0 == "allies")
    return "axis";
  else
    return "allies";
}

_id_45A9() {
  if(!isDefined(level.reclaimedreservedobjectives) || level.reclaimedreservedobjectives.size < 1) {
    var_0 = level._id_688F;
    level._id_688F++;
  } else {
    var_0 = level.reclaimedreservedobjectives[level.reclaimedreservedobjectives.size - 1];
    level.reclaimedreservedobjectives[level.reclaimedreservedobjectives.size - 1] = undefined;
  }

  if(var_0 > 31) {
    if(maps\mp\_utility::_id_579B()) {}

    var_0 = 31;
  }

  return var_0;
}

_id_454C() {
  var_0 = self._id_9D65.shootblank;

  if(!isDefined(var_0)) {
    var_0 = "";
    return var_0;
  }

  if(var_0[0] != "_")
    return "_" + var_0;

  return var_0;
}

_id_5307() {
  self._id_6638 = undefined;
  self._id_1E4D = 0;
  self._id_6AA9 = undefined;
}

_id_65BF(var_0) {
  self._id_65BF = var_0;
}

_id_1F49(var_0) {
  self._id_1F49 = var_0;
}

_id_6B52(var_0) {
  self._id_5107 = var_0;
}

_id_8BB2() {
  return !maps\mp\_utility::_id_579B();
}

_id_39F4() {
  self endon("disconnect");
  level endon("game_ended");
  var_0 = 120;
  var_1 = _randomintrange(30, 90);
  var_0 = var_0 + var_1;
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  self waittill("show_loot_notification");
}

_id_5108() {
  if(!self._id_5107)
    return 0;

  if(!isDefined(self._id_230E) || !isDefined(self._id_230E._id_9AC5))
    return 1;

  var_0 = self._id_230E._id_9AC5[self._id_37D8];

  if(!isDefined(var_0) || var_0 != self._id_9D65)
    return 1;

  return 0;
}

cancapwithoutclaim(var_0) {
  self.cancapwithoutclaim = var_0;
}
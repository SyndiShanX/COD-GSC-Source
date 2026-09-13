/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\dmz_ai_chopper.gsc
***************************************************/

_id_4C4DF9AEB773709A(pos, vehicle, model, patrolradius, name) {
  patrollocation = pos;

  if(!isDefined(patrolradius))
    patrolradius = 4000;

  _id_A5639D6F3F95033A = scripts\cp_mp\killstreaks\chopper_support::getpathstart(patrollocation);
  startingangles = vectortoangles(patrollocation - _id_A5639D6F3F95033A);
  _id_A5639D6F3F95033A = scripts\engine\utility::drop_to_ground(_id_A5639D6F3F95033A);
  _id_A5639D6F3F95033A = _id_A5639D6F3F95033A + (0, 0, level._id_103B912267715093);
  chopper = spawnVehicle(model, "dmz_ai_chopper", vehicle, _id_A5639D6F3F95033A, startingangles);

  if(!isDefined(chopper)) {
    return;
  }
  chopper._id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(pos);
  chopper.speed = 60;
  chopper._id_494FE868127E6381 = chopper.speed;
  chopper.accel = 50;
  chopper._id_5424DF833AC6A6F2 = chopper.accel;
  chopper.lifetime = 9999;
  chopper.team = "team_hundred_ninety_five";
  _id_2884ADC8D320F897 = _id_48814951E916AF89::_id_AF3034A7C69D7EDB("team_hundred_ninety_five");
  chopper.owner = _id_2884ADC8D320F897;
  chopper.angles = startingangles;
  chopper.flaresreservecount = 2;
  chopper.pathstart = _id_A5639D6F3F95033A;
  chopper.pathgoal = patrollocation;
  chopper.currentaction = "patrol";
  chopper.currenttarget = undefined;
  chopper.heightoffset = (0, 0, 1500);
  chopper._id_BF8FEA4EC55967BC = getdvarint("dvar_DB1F71003929B40E", 1) == 1;
  chopper._id_DCAE6D029A10C90B = 1;
  chopper.handleeventcallback = ::_id_9910A6CD29958A7F;
  chopper._id_451E9C8586B874B0 = getdvarint("dvar_26753E8056E1652E", 256);
  chopper setmaxpitchroll(15, 15);
  chopper vehicle_setspeed(chopper.speed, chopper.accel);
  chopper sethoverparams(50, 5, 2.5);
  chopper setturningability(0.5);
  chopper setyawspeed(100, 25, 25, 0.1);
  chopper setCanDamage(1);
  chopper setneargoalnotifydist(768);
  chopper setvehicleteam(chopper.team);
  chopper.ignorelist = [chopper];
  chopper.stage3accradius = 35;
  chopper.crashoffset = chopper.heightoffset[2] - 250;
  chopper.currenthealth = level._id_426503BD899FE79D;
  chopper.health = level._id_426503BD899FE79D;
  chopper.maxhealth = level._id_426503BD899FE79D;
  chopper.damagestate = 0;
  chopper scripts\mp\sentientpoolmanager::registersentient("Level_Vehicle", chopper.team);
  chopper._id_023CB38899CBA861 = [];
  chopper._id_F4EF1DF1E627AD5F = 0;
  chopper._id_31A7627753153DAE = 6;
  chopper.currentstate = "patrol";
  chopper.patrollocation = patrollocation;
  chopper.patrolradius = patrolradius;
  chopper._id_445449FE0511CAD6 = 0;
  chopper.funcs["patrol"] = ::_id_B74D3DA9A50AEF87;
  chopper.funcs["idle"] = ::_id_185CA586F9B7F14F;
  chopper.funcs["attack"] = ::_id_A5298692F21A8421;
  chopper thread _id_677B91B5A72DB277();
  chopper thread _id_5159BD9771A61868();
  chopper thread _id_A4F67639DA6C8A7D();
  chopper vehicleshowonminimap(0);
  chopper.vehiclename = name;
  scripts\mp\vehicles\damage::set_post_mod_damage_callback(chopper.vehiclename, ::_id_C23BF5E680C0B0FC);
  scripts\mp\vehicles\damage::set_death_callback(chopper.vehiclename, ::_id_31529A6224103B1A);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "handleIncomingStinger"))
    chopper thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "handleIncomingStinger")]](scripts\cp_mp\killstreaks\chopper_support::choppersupport_handlemissiledetection);

  return chopper;
}

_id_9910A6CD29958A7F(vehicle) {
  driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(vehicle);

  if(isDefined(driver)) {
    _id_03BE784D69CC30A0(driver, 500, 1);

    if(self.currentstate != "attack")
      _id_7743AEFF79A08975("idle");
  }
}

_id_C23BF5E680C0B0FC(data) {
  scripts\cp_mp\killstreaks\chopper_support::_id_400022DABDB64055(data);

  if(isDefined(self._id_C6C4017B9F56BFF4))
    self thread[[self._id_C6C4017B9F56BFF4]](data);

  if(isDefined(data.attacker) && isPlayer(data.attacker)) {
    _id_03BE784D69CC30A0(data.attacker, data.damage, 1);

    if(self.currentstate != "attack")
      _id_7743AEFF79A08975("idle");
  }

  return 1;
}

_id_677B91B5A72DB277() {
  self endon("death");
  self endon("explode");

  for(;;) {
    [[self.funcs[self.currentstate]]]();
    waitframe();
  }
}

_id_31529A6224103B1A(data) {
  scripts\cp_mp\killstreaks\chopper_support::choppersupport_handledeathdamage(data);
  self notify("death");
  return 1;
}

_id_5159BD9771A61868() {
  self endon("death");

  for(;;) {
    if(isDefined(self._id_B205D90302DA2F07)) {
      foreach(player in level._id_B205D90302DA2F07[self._id_B205D90302DA2F07]["players"])
      _id_03BE784D69CC30A0(player, 10);
    }

    wait 10;
  }
}

_id_B74D3DA9A50AEF87() {
  self endon("death");
  self endon("state_change");
  self clearlookatent();
  self setneargoalnotifydist(300);

  if(!istrue(self._id_DCAE6D029A10C90B))
    self vehicle_setspeed(20, 20);

  self._id_DCAE6D029A10C90B = 0;
  _id_6E281DBD69FC980E = self.patrollocation + anglesToForward((0, self._id_445449FE0511CAD6, 0)) * int(self.patrolradius / 1.2);
  self._id_445449FE0511CAD6 = self._id_445449FE0511CAD6 + 360 / self._id_31A7627753153DAE;

  if(self._id_445449FE0511CAD6 >= 360)
    self._id_445449FE0511CAD6 = self._id_445449FE0511CAD6 - 360;

  _id_276C4659222D7C6A(_id_6E281DBD69FC980E, self._id_F4EF1DF1E627AD5F > 0);
  wait(self._id_F4EF1DF1E627AD5F);
  self vehicle_setspeed(self._id_494FE868127E6381, self._id_5424DF833AC6A6F2);
  self.currentstate = "idle";
}

_id_7743AEFF79A08975(state) {
  self.currentstate = state;
  self vehicle_setspeed(self._id_494FE868127E6381, self._id_5424DF833AC6A6F2);
  self notify("state_change");
}

_id_185CA586F9B7F14F() {
  self endon("death");
  self endon("state_change");
  target = _id_EF8A0089F2C25099();

  if(isDefined(target)) {
    self.currenttarget = target;
    self.currentstate = "attack";
  } else
    self.currentstate = "patrol";
}

_id_A5298692F21A8421() {
  self endon("death");
  self endon("state_change");
  self._id_DCAE6D029A10C90B = 1;

  if(!isDefined(self.currenttarget))
    self.currentstate = "patrol";
  else {
    if(isDefined(self._id_59BCC0EE54CDB593)) {
      self[[self._id_59BCC0EE54CDB593]](self._id_023CB38899CBA861[self.currenttarget].player);
      return;
    }

    self.currentstate = "patrol";
  }
}

_id_03BE784D69CC30A0(player, value, _id_DA6145188809DCDF) {
  if(!isDefined(player) || !isDefined(player.guid)) {
    return;
  }
  if(!isDefined(self._id_023CB38899CBA861[player.guid])) {
    self._id_023CB38899CBA861[player.guid] = spawnStruct();
    self._id_023CB38899CBA861[player.guid].player = player;
    self._id_023CB38899CBA861[player.guid].threat = 0;
    self._id_023CB38899CBA861[player.guid]._id_DA6145188809DCDF = 0;
  }

  if(istrue(self._id_CE5E3646C55AB5AB)) {
    self._id_023CB38899CBA861[player.guid].threat = self._id_023CB38899CBA861[player.guid].threat + value;

    if(self._id_023CB38899CBA861[player.guid].threat <= 0)
      self._id_023CB38899CBA861[player.guid] = undefined;
  } else {
    if(istrue(_id_DA6145188809DCDF))
      self._id_023CB38899CBA861[player.guid]._id_DA6145188809DCDF = _id_DA6145188809DCDF;

    if(!isDefined(self._id_2EDB1BBB4AD168EF) || !isDefined(self._id_38076EA016478F2F)) {
      self._id_2EDB1BBB4AD168EF = player.guid;
      self._id_38076EA016478F2F = player.guid;
    } else if(!isDefined(self._id_023CB38899CBA861[player.guid].up) && !isDefined(self._id_023CB38899CBA861[player.guid].down) && self._id_38076EA016478F2F != player.guid) {
      self._id_023CB38899CBA861[self._id_2EDB1BBB4AD168EF].down = player.guid;
      self._id_023CB38899CBA861[player.guid].up = self._id_2EDB1BBB4AD168EF;
      self._id_2EDB1BBB4AD168EF = player.guid;
    }

    self._id_023CB38899CBA861[player.guid].threat = self._id_023CB38899CBA861[player.guid].threat + value;

    if(value > 0) {
      if(self._id_38076EA016478F2F == player.guid) {
        return;
      }
      _id_0A4AFCF8A424399E = self._id_023CB38899CBA861[player.guid].up;

      for(_id_36413DC99878ED04 = []; isDefined(_id_0A4AFCF8A424399E) && self._id_023CB38899CBA861[_id_0A4AFCF8A424399E].threat < self._id_023CB38899CBA861[player.guid].threat; _id_0A4AFCF8A424399E = self._id_023CB38899CBA861[_id_0A4AFCF8A424399E].up) {
        if(scripts\engine\utility::array_contains(_id_36413DC99878ED04, _id_0A4AFCF8A424399E)) {
          self._id_023CB38899CBA861 = [];
          self._id_38076EA016478F2F = undefined;
          self._id_2EDB1BBB4AD168EF = undefined;
          return;
        }

        _id_36413DC99878ED04[_id_36413DC99878ED04.size] = _id_0A4AFCF8A424399E;
      }

      if(!isDefined(_id_0A4AFCF8A424399E) || _id_0A4AFCF8A424399E != self._id_023CB38899CBA861[player.guid].up) {
        _id_83388ED388DDBDDC(player.guid);
        _id_09E2E41A3F8F5DED(player.guid, _id_0A4AFCF8A424399E);
        return;
      }

      return;
    }

    if(self._id_023CB38899CBA861[player.guid].threat <= 0) {
      _id_83388ED388DDBDDC(player.guid);
      return;
    }

    if(self._id_2EDB1BBB4AD168EF == player.guid) {
      return;
    }
    _id_0A4AFCF8A424399E = self._id_023CB38899CBA861[player.guid].down;

    for(_id_36413DC99878ED04 = []; isDefined(_id_0A4AFCF8A424399E) && self._id_023CB38899CBA861[_id_0A4AFCF8A424399E].threat > self._id_023CB38899CBA861[player.guid].threat; _id_0A4AFCF8A424399E = self._id_023CB38899CBA861[_id_0A4AFCF8A424399E].down) {
      if(scripts\engine\utility::array_contains(_id_36413DC99878ED04, _id_0A4AFCF8A424399E)) {
        self._id_023CB38899CBA861 = [];
        self._id_38076EA016478F2F = undefined;
        self._id_2EDB1BBB4AD168EF = undefined;
        return;
      }

      _id_36413DC99878ED04[_id_36413DC99878ED04.size] = _id_0A4AFCF8A424399E;
    }

    if(!isDefined(_id_0A4AFCF8A424399E) || _id_0A4AFCF8A424399E != self._id_023CB38899CBA861[player.guid].down) {
      _id_83388ED388DDBDDC(player.guid);
      _id_09E2E41A3F8F5DED(player.guid, self._id_023CB38899CBA861[_id_0A4AFCF8A424399E].up);
    }
  }
}

_id_83388ED388DDBDDC(guid) {
  if(istrue(self._id_CE5E3646C55AB5AB)) {
    self._id_023CB38899CBA861[guid] = undefined;
    return;
  }

  if(self._id_38076EA016478F2F == guid && self._id_2EDB1BBB4AD168EF == guid) {
    self._id_38076EA016478F2F = undefined;
    self._id_2EDB1BBB4AD168EF = undefined;
    return;
  }

  if(isDefined(self._id_023CB38899CBA861[guid].down)) {
    if(!isDefined(self._id_023CB38899CBA861[guid].up))
      self._id_38076EA016478F2F = self._id_023CB38899CBA861[guid].down;

    self._id_023CB38899CBA861[self._id_023CB38899CBA861[guid].down].up = self._id_023CB38899CBA861[guid].up;
  }

  if(isDefined(self._id_023CB38899CBA861[guid].up)) {
    if(!isDefined(self._id_023CB38899CBA861[guid].down))
      self._id_2EDB1BBB4AD168EF = self._id_023CB38899CBA861[guid].up;

    self._id_023CB38899CBA861[self._id_023CB38899CBA861[guid].up].down = self._id_023CB38899CBA861[guid].down;
  }
}

_id_09E2E41A3F8F5DED(guid, _id_29917471D8F3F42B) {
  if(!isDefined(_id_29917471D8F3F42B)) {
    self._id_023CB38899CBA861[self._id_38076EA016478F2F].up = guid;
    self._id_023CB38899CBA861[guid].down = self._id_38076EA016478F2F;
    self._id_023CB38899CBA861[guid].up = undefined;
    self._id_38076EA016478F2F = guid;
  } else {
    if(isDefined(self._id_023CB38899CBA861[_id_29917471D8F3F42B].down))
      self._id_023CB38899CBA861[self._id_023CB38899CBA861[_id_29917471D8F3F42B].down].up = guid;

    self._id_023CB38899CBA861[guid].down = self._id_023CB38899CBA861[_id_29917471D8F3F42B].down;
    self._id_023CB38899CBA861[_id_29917471D8F3F42B].down = guid;
    self._id_023CB38899CBA861[guid].up = _id_29917471D8F3F42B;

    if(!isDefined(self._id_023CB38899CBA861[guid].down))
      self._id_2EDB1BBB4AD168EF = guid;
  }
}

_id_EF8A0089F2C25099() {
  _id_36413DC99878ED04 = [];

  for(_id_935D39B44C51F3CB = self._id_38076EA016478F2F; isDefined(_id_935D39B44C51F3CB) && isDefined(self._id_023CB38899CBA861[_id_935D39B44C51F3CB]); _id_935D39B44C51F3CB = self._id_023CB38899CBA861[_id_935D39B44C51F3CB].down) {
    if(scripts\engine\utility::array_contains(_id_36413DC99878ED04, _id_935D39B44C51F3CB)) {
      self._id_023CB38899CBA861 = [];
      self._id_38076EA016478F2F = undefined;
      self._id_2EDB1BBB4AD168EF = undefined;
      return undefined;
    }

    _id_36413DC99878ED04[_id_36413DC99878ED04.size] = _id_935D39B44C51F3CB;
    _id_DD9FC1CCBC50FD25 = self._id_023CB38899CBA861[_id_935D39B44C51F3CB];

    if(_id_9EDA5834C2FA3898(_id_DD9FC1CCBC50FD25)) {
      canseetarget = _id_1098BD14CAE74365(_id_DD9FC1CCBC50FD25.player);

      if(canseetarget)
        return _id_935D39B44C51F3CB;
    }
  }

  return undefined;
}

_id_1098BD14CAE74365(targetplayer, _id_E02FBFFD43632E35) {
  if(targetplayer.notarget)
    return 0;

  _id_C3FBB6661B91750F = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 0, 0, 1, 1, 0);
  ignorelist = self.ignorelist;

  if(isDefined(targetplayer._id_ABD157413AC4E022)) {
    ignorelist[ignorelist.size] = targetplayer._id_ABD157413AC4E022;

    if(isDefined(targetplayer._id_ABD157413AC4E022.turrets))
      ignorelist = scripts\engine\utility::array_combine(ignorelist, targetplayer._id_ABD157413AC4E022.turrets);
  }

  _id_E478AC91AF0E92CB = self getlinkedchildren();

  if(isDefined(_id_E478AC91AF0E92CB)) {
    foreach(child in _id_E478AC91AF0E92CB)
    ignorelist[ignorelist.size] = child;
  }

  if(isDefined(targetplayer.vehicle))
    ignorelist[ignorelist.size] = targetplayer.vehicle;

  _id_9B7F602C247C3953 = targetplayer.origin;

  if(isPlayer(targetplayer))
    _id_9B7F602C247C3953 = targetplayer gettagorigin("j_head");

  return scripts\engine\trace::ray_trace_passed(scripts\engine\utility::ter_op(isDefined(_id_E02FBFFD43632E35), _id_E02FBFFD43632E35, self.origin), _id_9B7F602C247C3953, ignorelist, _id_C3FBB6661B91750F);
}

tracegroundpoint(x, y) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  z = -99999;
  _id_E531AFBE1391F499 = self.origin[2] + 2000;
  _id_3C590B0EE220AFA3 = level.averagealliesz;
  ignorelist = [self];

  if(isDefined(self.dropcrates)) {
    foreach(crate in self.dropcrates)
    ignorelist[ignorelist.size] = crate;
  }

  radius = 256;

  if(isDefined(self._id_451E9C8586B874B0))
    radius = self._id_451E9C8586B874B0;

  _id_E96577032A7740FC = scripts\engine\trace::sphere_trace((x, y, _id_E531AFBE1391F499), (x, y, z), radius, ignorelist, undefined, 1);

  if(_id_E96577032A7740FC["position"][2] < _id_3C590B0EE220AFA3)
    _id_0FA83E3A4C4E6902 = _id_3C590B0EE220AFA3;
  else
    _id_0FA83E3A4C4E6902 = _id_E96577032A7740FC["position"][2];

  return _id_0FA83E3A4C4E6902;
}

getcorrectheight(x, y, _id_00AE14C5A8B1B582) {
  _id_DC8BB6300463CF1E = self.heightoffset[2];
  _id_E7A7D619F927D791 = tracegroundpoint(x, y);
  _id_1DC672CFE0F0128E = _id_E7A7D619F927D791 + _id_DC8BB6300463CF1E;
  _id_1DC672CFE0F0128E = _id_1DC672CFE0F0128E + randomint(_id_00AE14C5A8B1B582);
  return _id_1DC672CFE0F0128E;
}

_id_E9CB677B6BA63162(target, dist, _id_E7AF203C7683B460, _id_217C1C856C59A550) {
  self endon("death");
  self endon("crashing");
  self endon("state_change");

  if(!isDefined(_id_217C1C856C59A550))
    _id_217C1C856C59A550 = 0;

  _id_02D2CD3507681938 = self.origin - target.origin;
  _id_02D2CD3507681938 = vectorNormalize((_id_02D2CD3507681938[0], _id_02D2CD3507681938[1], 0)) * dist;

  for(_id_CB89120314447D62 = _id_217C1C856C59A550; _id_CB89120314447D62 < _id_217C1C856C59A550 + 360; _id_CB89120314447D62 = _id_CB89120314447D62 + 360 / _id_E7AF203C7683B460) {
    _id_90128D0639A1315D = rotatevector(_id_02D2CD3507681938, (0, _id_CB89120314447D62, 0));
    _id_90128D0639A1315D = _id_90128D0639A1315D + (target.origin + self.heightoffset);

    if(scripts\mp\outofbounds::ispointinoutofbounds(_id_90128D0639A1315D)) {
      continue;
    }
    _id_C3FBB6661B91750F = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 0, 0, 1, 1);
    canseetarget = _id_1098BD14CAE74365(target, _id_90128D0639A1315D);

    if(canseetarget) {
      self setlookatent(target);
      _id_276C4659222D7C6A(_id_90128D0639A1315D, 1);
      return 1;
    }
  }

  return 0;
}

_id_9F656E924A854C1B(target, dist, _id_E7AF203C7683B460, _id_217C1C856C59A550, _id_F9A785628F97EEC6, _id_4F4C3A288DF043C0, _id_5F1F469D27D6AF1A) {
  self endon("death");
  self endon("crashing");
  self endon("state_change");

  if(!isDefined(target) || isPlayer(target) && !scripts\cp_mp\utility\player_utility::isreallyalive(target))
    return 0;

  _id_02D2CD3507681938 = self.origin - target.origin;
  _id_02D2CD3507681938 = vectorNormalize((_id_02D2CD3507681938[0], _id_02D2CD3507681938[1], 0)) * dist;

  if(!isDefined(_id_4F4C3A288DF043C0))
    _id_4F4C3A288DF043C0 = 2;

  if(!isDefined(_id_217C1C856C59A550))
    _id_217C1C856C59A550 = 0;

  for(_id_CB89120314447D62 = _id_217C1C856C59A550; _id_CB89120314447D62 < _id_217C1C856C59A550 + 360; _id_CB89120314447D62 = _id_CB89120314447D62 + 360 / _id_E7AF203C7683B460) {
    if(!isDefined(target) || isPlayer(target) && !scripts\cp_mp\utility\player_utility::isreallyalive(target))
      return 0;

    _id_E1189805B90AF398 = rotatevector(_id_02D2CD3507681938, (0, _id_CB89120314447D62, 0));
    _id_90128D0639A1315D = _id_E1189805B90AF398 + target.origin + scripts\engine\utility::ter_op(isDefined(_id_F9A785628F97EEC6), (0, 0, _id_F9A785628F97EEC6), self.heightoffset);
    _id_C3FBB6661B91750F = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 0, 0, 1, 1);
    canseetarget = _id_1098BD14CAE74365(target);
    _id_F8FB21E45F9F9A37 = scripts\engine\trace::ray_trace_passed(_id_90128D0639A1315D, _id_90128D0639A1315D - _id_E1189805B90AF398 * _id_4F4C3A288DF043C0, self.ignorelist, _id_C3FBB6661B91750F);

    if(canseetarget && _id_F8FB21E45F9F9A37) {
      self._id_652BF3292E2A7755 = 1;
      _id_276C4659222D7C6A(_id_90128D0639A1315D, 1, (0, 0, 0), 1);
      self vehicle_setspeed(self._id_494FE868127E6381 * 2, self.accel);
      wait 1.5;
      self clearlookatent();

      if(!isDefined(target) || !scripts\cp_mp\utility\player_utility::isreallyalive(target))
        return 0;

      self notify("strafe_start");

      if(isDefined(self.funcs["strafe"]))
        self thread[[self.funcs["strafe"]]](target);

      _id_276C4659222D7C6A(_id_90128D0639A1315D - _id_E1189805B90AF398 * _id_4F4C3A288DF043C0, !isDefined(_id_5F1F469D27D6AF1A), undefined, 1);
      self notify("strafe_end");
      self vehicle_setspeed(self._id_494FE868127E6381, self.accel);

      if(!isDefined(target) || !scripts\cp_mp\utility\player_utility::isreallyalive(target))
        return 0;

      self setlookatent(target);
      self._id_652BF3292E2A7755 = 0;
      return 1;
    }
  }

  return 0;
}

_id_276C4659222D7C6A(target, _id_6C814CEE8D2BD65E, _id_7403E5E436347D6B, _id_D37D6F45A6BAE8F9) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self endon("state_change");
  _id_6C53D859D582A421 = undefined;
  _id_4E6DF96D95BF50BC = target;

  if(!isvector(target))
    _id_4E6DF96D95BF50BC = target.origin;

  ignorelist = self.ignorelist;
  _id_E478AC91AF0E92CB = self getlinkedchildren();

  if(isDefined(_id_E478AC91AF0E92CB)) {
    foreach(child in _id_E478AC91AF0E92CB)
    ignorelist[ignorelist.size] = child;
  }

  for(;;) {
    _id_0454EBDDE3D9DCF4 = self.origin;
    _id_2ECA7B12D2EE27BA = _id_4E6DF96D95BF50BC * (1, 1, 0) + (0, 0, self.origin[2]);
    _id_158F8E4D0E511638 = 0;
    _id_81954D580B24281B = _id_4E6DF96D95BF50BC[0];
    _id_E4F34F3A01C6FFF2 = _id_4E6DF96D95BF50BC[1];

    if(istrue(_id_D37D6F45A6BAE8F9)) {
      _id_691AA1D5DA533612 = scripts\engine\trace::sphere_trace(_id_0454EBDDE3D9DCF4, _id_2ECA7B12D2EE27BA, 512, ignorelist);

      if(isDefined(_id_691AA1D5DA533612)) {
        if(_id_691AA1D5DA533612["hittype"] != "hittype_none") {
          _id_81954D580B24281B = _id_691AA1D5DA533612["position"][0];
          _id_E4F34F3A01C6FFF2 = _id_691AA1D5DA533612["position"][1];
          _id_158F8E4D0E511638 = 1;
        }
      }
    }

    if(isDefined(_id_7403E5E436347D6B))
      _id_6C53D859D582A421 = _id_4E6DF96D95BF50BC + _id_7403E5E436347D6B;
    else if(istrue(self.evasivemaneuvers)) {
      _id_F7CD955C75C5D1BF = _id_81954D580B24281B + randomintrange(-500, 500);
      _id_F7CD945C75C5CF8C = _id_E4F34F3A01C6FFF2 + randomintrange(-500, 500);
      _id_7504C8791E34DC73 = getcorrectheight(_id_F7CD955C75C5D1BF, _id_F7CD945C75C5CF8C, 350);
      _id_6C53D859D582A421 = (_id_F7CD955C75C5D1BF, _id_F7CD945C75C5CF8C, _id_7504C8791E34DC73);
    } else {
      _id_7504C8791E34DC73 = getcorrectheight(_id_81954D580B24281B, _id_E4F34F3A01C6FFF2, 20);
      _id_6C53D859D582A421 = (_id_81954D580B24281B, _id_E4F34F3A01C6FFF2, _id_7504C8791E34DC73);
    }

    _id_E1F26216DAE25CB7 = 0;

    if(istrue(_id_6C814CEE8D2BD65E) && !istrue(_id_158F8E4D0E511638))
      _id_E1F26216DAE25CB7 = _id_6C814CEE8D2BD65E;

    self setvehgoalpos(_id_6C53D859D582A421, _id_E1F26216DAE25CB7);
    scripts\engine\utility::waittill_any_2("near_goal", "begin_evasive_maneuvers");

    if(!istrue(_id_158F8E4D0E511638)) {
      break;
    }
  }
}

_id_9EDA5834C2FA3898(_id_368AE33CB19F91F8) {
  _id_02D3E5B97DD28A8F = !isDefined(self._id_F09811D8BB92DF96) || self[[self._id_F09811D8BB92DF96]](_id_368AE33CB19F91F8.player);
  _id_02D3E5B97DD28A8F = _id_02D3E5B97DD28A8F &(_id_368AE33CB19F91F8._id_DA6145188809DCDF || scripts\cp_mp\utility\player_utility::isreallyalive(_id_368AE33CB19F91F8.player) && distance2dsquared(self.origin, _id_368AE33CB19F91F8.player.origin) < 36000000);
  _id_368AE33CB19F91F8._id_DA6145188809DCDF = 0;
  return isDefined(_id_368AE33CB19F91F8.player) && !_id_368AE33CB19F91F8.player.notarget && scripts\cp_mp\utility\player_utility::isreallyalive(_id_368AE33CB19F91F8.player) && _id_02D3E5B97DD28A8F;
}

_id_A4F67639DA6C8A7D() {
  level endon("game_ended");
  self endon("chopperSupport_gone");
  owner = self.owner;
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "isKillstreakWeapon")) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "isKillstreakWeapon")]](self.killedbyweapon))
      choppersupport_crash(100);
  }

  _id_87F0993E8F0FBE6A();
}

_id_87F0993E8F0FBE6A() {
  self notify("explode");
  self notify("state_change");
  self radiusdamage(self.origin, 1000, 200, 200, undefined, "MOD_EXPLOSIVE", "chopper_support_turret_mp");
  self setscriptablepartstate("explode", "on", 0);

  if(isDefined(self.lootfunc))
    self[[self.lootfunc]]();

  wait 0.35;
  _id_0FA93C6002DA144F(1);
}

choppersupport_crash(speed, _id_1F1FBCEF1D9B080A) {
  self endon("explode");
  self setscriptablepartstate("crash", "on", 0);

  if(isDefined(self.killcament)) {
    self.killcament unlink();
    self.killcament.origin = self.origin + (0, 0, 100);
  }

  self clearlookatent();
  self notify("crashing");
  self.iscrashing = 1;
  self vehicle_setspeed(speed, 20, 20);
  self setneargoalnotifydist(100);
  _id_6847739E80FB4E81 = _id_E2C4E07CE9823056(3500, 500, 1000);

  if(isDefined(_id_1F1FBCEF1D9B080A))
    _id_6847739E80FB4E81 = _id_1F1FBCEF1D9B080A;

  if(!isDefined(_id_6847739E80FB4E81)) {
    return;
  }
  self setvehgoalpos(_id_6847739E80FB4E81, 0);
  thread _id_9C97CE445DFDE3AF(speed);
  self vehicle_turnengineoff();
  scripts\engine\utility::waittill_any_timeout_2(5, "collision", "near_goal");
}

_id_E2C4E07CE9823056(_id_6F8D59F68BD2B46C, _id_6C56FF5ECC704C48, _id_6C7AF55ECC98B102) {
  _id_B2B5F5510C5D94E0 = self.origin;
  crashoffset = self.crashoffset;
  _id_543F2191DDE2B7F6 = undefined;
  _id_6C5CEED9B00EB7D5 = anglesToForward(self.angles);
  _id_5CC1D6DD55C49E3A = anglestoright(self.angles);
  _id_428A3D9115F72081 = _id_B2B5F5510C5D94E0 + _id_6C5CEED9B00EB7D5 * _id_6F8D59F68BD2B46C - (0, 0, crashoffset);

  if(scripts\engine\trace::ray_trace_passed(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self) && !scripts\mp\outofbounds::ispointinoutofbounds(_id_428A3D9115F72081)) {
    _id_543F2191DDE2B7F6 = _id_428A3D9115F72081;
    return _id_543F2191DDE2B7F6;
  }

  _id_428A3D9115F72081 = _id_B2B5F5510C5D94E0 - _id_6C5CEED9B00EB7D5 * _id_6F8D59F68BD2B46C - (0, 0, crashoffset);

  if(scripts\engine\trace::ray_trace_passed(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self) && !scripts\mp\outofbounds::ispointinoutofbounds(_id_428A3D9115F72081)) {
    _id_543F2191DDE2B7F6 = _id_428A3D9115F72081;
    return _id_543F2191DDE2B7F6;
  }

  _id_428A3D9115F72081 = _id_B2B5F5510C5D94E0 + _id_5CC1D6DD55C49E3A * _id_6F8D59F68BD2B46C - (0, 0, crashoffset);

  if(scripts\engine\trace::ray_trace_passed(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self) && !scripts\mp\outofbounds::ispointinoutofbounds(_id_428A3D9115F72081)) {
    _id_543F2191DDE2B7F6 = _id_428A3D9115F72081;
    return _id_543F2191DDE2B7F6;
  }

  _id_428A3D9115F72081 = _id_B2B5F5510C5D94E0 - _id_5CC1D6DD55C49E3A * _id_6F8D59F68BD2B46C - (0, 0, crashoffset);

  if(scripts\engine\trace::ray_trace_passed(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self) && !scripts\mp\outofbounds::ispointinoutofbounds(_id_428A3D9115F72081)) {
    _id_543F2191DDE2B7F6 = _id_428A3D9115F72081;
    return _id_543F2191DDE2B7F6;
  }

  _id_428A3D9115F72081 = _id_B2B5F5510C5D94E0 + 0.707 * _id_6F8D59F68BD2B46C * (_id_6C5CEED9B00EB7D5 + _id_5CC1D6DD55C49E3A) - (0, 0, crashoffset);

  if(scripts\engine\trace::ray_trace_passed(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self) && !scripts\mp\outofbounds::ispointinoutofbounds(_id_428A3D9115F72081)) {
    _id_543F2191DDE2B7F6 = _id_428A3D9115F72081;
    return _id_543F2191DDE2B7F6;
  }

  _id_428A3D9115F72081 = _id_B2B5F5510C5D94E0 + 0.707 * _id_6F8D59F68BD2B46C * (_id_6C5CEED9B00EB7D5 - _id_5CC1D6DD55C49E3A) - (0, 0, crashoffset);

  if(scripts\engine\trace::ray_trace_passed(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self) && !scripts\mp\outofbounds::ispointinoutofbounds(_id_428A3D9115F72081)) {
    _id_543F2191DDE2B7F6 = _id_428A3D9115F72081;
    return _id_543F2191DDE2B7F6;
  }

  _id_428A3D9115F72081 = _id_B2B5F5510C5D94E0 + 0.707 * _id_6F8D59F68BD2B46C * (_id_5CC1D6DD55C49E3A - _id_6C5CEED9B00EB7D5) - (0, 0, crashoffset);
  _id_4720F54E3EFF6E8D = scripts\engine\trace::ray_trace(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self);

  if(scripts\engine\trace::ray_trace_passed(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self) && !scripts\mp\outofbounds::ispointinoutofbounds(_id_428A3D9115F72081)) {
    _id_543F2191DDE2B7F6 = _id_428A3D9115F72081;
    return _id_543F2191DDE2B7F6;
  }

  _id_428A3D9115F72081 = _id_B2B5F5510C5D94E0 + 0.707 * _id_6F8D59F68BD2B46C * (-1 * _id_6C5CEED9B00EB7D5 - _id_5CC1D6DD55C49E3A) - (0, 0, crashoffset);

  if(scripts\engine\trace::ray_trace_passed(_id_B2B5F5510C5D94E0, _id_428A3D9115F72081, self) && !scripts\mp\outofbounds::ispointinoutofbounds(_id_428A3D9115F72081)) {
    _id_543F2191DDE2B7F6 = _id_428A3D9115F72081;
    return _id_543F2191DDE2B7F6;
  }

  return _id_543F2191DDE2B7F6;
}

_id_9C97CE445DFDE3AF(speed) {
  self endon("death");
  self setyawspeed(speed, 50, 50, 0.5);

  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + speed * 0.4);
    wait 0.5;
  }
}

_id_67FE145BDE788912(_id_EB4D81FD840007E2, _id_171F90B9C4C76D44) {
  if(level._id_EDA461803CDADC2C < 0) {
    return;
  }
  if(level._id_EDA461803CDADC2C > 0) {
    playerlist = [];

    foreach(player in level.players) {
      if(distance2dsquared(player.origin, _id_EB4D81FD840007E2) < level._id_EDA461803CDADC2C)
        playerlist[playerlist.size] = player;
    }
  } else
    playerlist = level.players;

  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_boss_chopper_inbound", playerlist, _id_171F90B9C4C76D44);
  _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("boss_near", playerlist);
}

_id_4AD380A5E1B9C51A() {
  _id_76A22C18960F72AF = _id_3F0075ED8069575C(self.origin + (0, 0, 500));

  if(isDefined(_id_76A22C18960F72AF)) {
    _id_0E38F5EC33ED2CB0 = scripts\cp_mp\killstreaks\airdrop::dropbrlootchoppercrate(self.origin, _id_76A22C18960F72AF);
    _id_EF5D5141FDB51174 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(_id_0E38F5EC33ED2CB0);
    _id_EF5D5141FDB51174.usetimeoverride = 10;
  }
}

_id_3F0075ED8069575C(_id_22C4300CE1D248E8) {
  _id_76A22C18960F72AF = undefined;
  _id_98C6610C2907BA2B = _id_22C4300CE1D248E8 - (0, 0, 20000);
  ignorelist = [self, self.frontturret];
  trace = scripts\engine\trace::ray_trace(_id_22C4300CE1D248E8, _id_98C6610C2907BA2B, ignorelist);

  if(isDefined(trace) && trace["hittype"] != "hittype_none")
    _id_76A22C18960F72AF = trace["position"];

  return _id_76A22C18960F72AF;
}

_id_2C83D3D61191E88E(player) {
  self.itemsdropped = 0;
  _id_1361F1A11BA15C7E = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++) {
    pos = scripts\engine\utility::drop_to_ground(self.origin + rotatepointaroundvector((0, 0, 1), (20, 0, 0), 120 * _id_AC0E594AC96AA3A8));
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(pos);
    _id_153FDEE861E0F06F = scripts\engine\utility::ter_op(scripts\engine\utility::_id_51D76700600CEBE3(50), "brloot_killstreak_clusterstrike", "brloot_killstreak_precision_airstrike");
    pickup = _id_7E52B56769FA7774::spawnpickup(_id_153FDEE861E0F06F, _id_CB4FAD49263E20C4, 1);
    self.itemsdropped++;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 8; _id_AC0E594AC96AA3A8++) {
    pos = scripts\engine\utility::drop_to_ground(self.origin + rotatepointaroundvector((0, 0, 1), (40, 0, 0), 45 * _id_AC0E594AC96AA3A8));
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(pos);
    _id_08A3A7194E96EA2C = scripts\engine\utility::ter_op(_id_AC0E594AC96AA3A8 % 2 == 0, "brloot_valuable_goldbar", "brloot_plunder_cash_rare_1");
    pickup = _id_7E52B56769FA7774::spawnpickup(_id_08A3A7194E96EA2C, _id_CB4FAD49263E20C4, 1);
    self.itemsdropped++;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 6; _id_AC0E594AC96AA3A8++) {
    _id_1E251FFD71396D15 = scripts\engine\utility::random(["brloot_weapon_sm_papa90_rare", "brloot_weapon_sh_romeo870_rare", "brloot_weapon_sn_sbeta_lege"]);
    itemname = scripts\engine\utility::ter_op(_id_AC0E594AC96AA3A8 % 3 == 0, "brloot_armor_plate", _id_1E251FFD71396D15);
    _id_144769F518D71226 = scripts\engine\utility::ter_op(_id_AC0E594AC96AA3A8 % 3 == 0, 8, 1);
    pos = scripts\engine\utility::drop_to_ground(self.origin + rotatepointaroundvector((0, 0, 1), (30, 0, 0), 60 * _id_AC0E594AC96AA3A8));
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(pos);
    pickup = _id_7E52B56769FA7774::spawnpickup(itemname, _id_CB4FAD49263E20C4, _id_144769F518D71226);
    _id_1361F1A11BA15C7E[_id_1361F1A11BA15C7E.size] = pickup;
    self.itemsdropped++;
  }

  foreach(ent in _id_1361F1A11BA15C7E)
  ent.lootsource = "loot_chopper";
}

_id_0FA93C6002DA144F(_id_4FAC8B8CE36E09F1) {
  if(isDefined(self.frontturret)) {
    self.frontturret setentityowner(undefined);
    self.frontturret.groundtargetent delete();
    self.frontturret delete();
  }

  if(isDefined(self.rearturret)) {
    self.rearturret setentityowner(undefined);
    self.rearturret.groundtargetent delete();
    self.rearturret delete();
  }

  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(self);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}
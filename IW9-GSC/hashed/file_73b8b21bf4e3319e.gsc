/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_73b8b21bf4e3319e.gsc
***********************************************/

_id_FFDF58E4D2F91BBF() {
  while(!scripts\engine\utility::flag_exist("scriptables_ready"))
    waitframe();

  scripts\engine\utility::flag_wait("scriptables_ready");
  _id_07BE4DAEEADA81DF = getscriptablearray("guard_tower", "script_noteworthy");

  foreach(_id_C6CD9D2C6AD18DD6 in _id_07BE4DAEEADA81DF) {
    struct = _id_C6CD9D2C6AD18DD6 _id_ED7A2CE782168198();
    _id_C6CD9D2C6AD18DD6.nodes = getnodearray(struct.target, "targetname");
    _id_C6CD9D2C6AD18DD6.glass = _func_24642E648A544FF2(struct.target);
    _id_C6CD9D2C6AD18DD6.lights = getentarrayinradius("cp_guard_tower_on", "targetname", _id_C6CD9D2C6AD18DD6.origin, 1024);
    _id_C6CD9D2C6AD18DD6._id_603E519F7F88664D = getentarrayinradius("tower_light_fixtures", "targetname", _id_C6CD9D2C6AD18DD6.origin, 1024);
    ents = getEntArray(struct.target, "targetname");

    foreach(ent in ents) {
      switch (ent.classname) {
        case "script_brushmodel":
          _id_C6CD9D2C6AD18DD6.brushmodel = ent;
          break;
        case "trigger_multiple":
          _id_C6CD9D2C6AD18DD6.trigger = ent;
          break;
        default:
          break;
      }
    }

    _id_C6CD9D2C6AD18DD6 thread _id_408FD527D9578005();
  }
}

_id_BE8D07886E844B7E(meansofdeath, objweapon) {
  if(isDefined(objweapon) && objweapon.basename == "chopper_gunner_turret_cp")
    return 1;

  if(meansofdeath == "MOD_CRUSH" || isexplosivedamagemod(meansofdeath))
    return 1;

  return 0;
}

_id_408FD527D9578005() {
  for(;;) {
    self waittill("damage", amount, attacker, direction_vec, damagelocation, meansofdeath, modelname, tagname, partname, _id_44E290FB31B85206, objweapon);
    self.health = self.health + amount;

    if(isDefined(attacker) && (isscriptedagent(attacker) || attacker.classname == "script_model")) {
      continue;
    }
    if(isDefined(attacker.owner) && (!isPlayer(attacker.owner) || isscriptedagent(attacker.owner))) {
      continue;
    }
    if(!isDefined(meansofdeath)) {
      continue;
    }
    if(!_id_BE8D07886E844B7E(meansofdeath, objweapon)) {
      continue;
    }
    if(amount > 100) {
      _id_18639177DE723D3A = self getscriptablepartstate("base");

      if(meansofdeath == "MOD_CRUSH") {
        if(_id_18639177DE723D3A == "exploded" || _id_18639177DE723D3A == "collapsed") {
          earthquake(0.3, 1, self.origin, 512);
          self setscriptablepartstate("base", "destroyed", 1);
          level notify("tower_destroyed", attacker);
          return;
        } else {
          self.brushmodel delete();

          foreach(light in self.lights)
          light setlightintensity(0);

          foreach(fixture in self._id_603E519F7F88664D)
          fixture delete();

          foreach(ai in scripts\mp\mp_agent::getaliveagentsofteam("axis")) {
            if(ai istouching(self.trigger)) {
              ai.do_immediate_ragdoll = 1;
              ai dodamage(ai.health + 100, ai.origin, undefined, undefined, "MOD_EXPLOSIVE");
            }
          }

          earthquake(0.3, 1, self.origin, 512);
          self setscriptablepartstate("base", "destroyed_full", 1);
          level notify("tower_collapse");
          self.trigger delete();

          foreach(node in self.nodes) {
            node _meth_547AAB3C2787AC87();
            destroynavlink(node);
          }

          level notify("tower_destroyed", attacker);
          return;
        }
      }

      if(_id_18639177DE723D3A != "exploded" && _id_18639177DE723D3A != "collapsed") {
        self.brushmodel delete();

        foreach(light in self.lights)
        light setlightintensity(0);

        foreach(fixture in self._id_603E519F7F88664D)
        fixture delete();

        foreach(ai in scripts\mp\mp_agent::getaliveagentsofteam("axis")) {
          if(ai istouching(self.trigger)) {
            ai.do_immediate_ragdoll = 1;
            ai dodamage(ai.health + 100, attacker.origin, undefined, undefined, "MOD_EXPLOSIVE");
          }
        }

        self setscriptablepartstate("base", "collapsed", 1);
        earthquake(0.3, 1, self.origin, 512);
        level notify("tower_collapse");
        self.trigger delete();

        foreach(node in self.nodes) {
          node _meth_547AAB3C2787AC87();
          destroynavlink(node);
        }

        level notify("tower_destroyed", attacker);
      }
    }
  }
}

_id_ED7A2CE782168198() {
  array = scripts\engine\utility::get_linked_structs();

  if(!array.size)
    return undefined;

  return array[0];
}

_id_51139E209C5666F9() {
  self endon("death");
  self endon("playerTooClose");
  self.dontevershoot = 1;
  self.disablepistol = 1;
  self.combatmode = "no_cover";
  self.noloot = 1;
  _id_07BE4DAEEADA81DF = getscriptablearray("guard_tower", "script_noteworthy");
  _id_C6CD9D2C6AD18DD6 = scripts\engine\utility::getclosest(self.origin, _id_07BE4DAEEADA81DF);
  _id_18639177DE723D3A = _id_C6CD9D2C6AD18DD6 getscriptablepartstate("base");

  if(_id_18639177DE723D3A == "exploded" || _id_18639177DE723D3A == "collapsed" || _id_18639177DE723D3A == "destroyed") {
    self.nocorpse = 1;
    self suicide();
    return;
  }

  if(isDefined(self.spawnpoint.target)) {
    while(distance(self.origin, scripts\engine\utility::getStruct(self.spawnpoint.target, "targetname").origin) > 64)
      wait 0.1;
  }

  nodes = getnodesinradius(self.origin, 512, 0, 64);
  thread _id_F7217D985276BD76();
  thread _id_AF4CCD9FBD81ECBE();

  for(;;) {
    players = scripts\cp\utility::get_array_of_valid_players();
    _id_94388E6B3645AF0C = 0;

    foreach(player in players) {
      if(distance2dsquared(player.origin, self.origin) > squared(10000)) {
        continue;
      }
      if(istrue(player.ignoreme) || istrue(player.notarget)) {
        continue;
      }
      _id_94388E6B3645AF0C = 1;
    }

    if(!_id_94388E6B3645AF0C) {
      wait 0.1;
      continue;
    }

    _id_1963A43B43E1C34D = [];

    foreach(_id_0C3EA9B1A20FF199 in nodes) {
      _id_B13A9085444751C4 = 0;
      _id_0C3EA9B1A20FF199._id_E031661B7146A294 = [];

      foreach(player in players) {
        if(isDefined(player)) {
          ent = player;

          if(isDefined(player.vehicle)) {
            ent = player.vehicle;

            if(distance2dsquared(ent.origin, _id_0C3EA9B1A20FF199.origin) > squared(10000))
              continue;
          } else if(distance2dsquared(ent.origin, _id_0C3EA9B1A20FF199.origin) > squared(6000)) {
            continue;
          }
          trace = scripts\engine\trace::ray_trace(_id_0C3EA9B1A20FF199.origin + (0, 0, 40), ent.origin + (0, 0, 40), [self, ent, _id_C6CD9D2C6AD18DD6], undefined, undefined, 0, 1);

          if(trace["fraction"] < 1) {
            continue;
          }
          _id_0C3EA9B1A20FF199._id_E031661B7146A294[_id_0C3EA9B1A20FF199._id_E031661B7146A294.size] = player;
          _id_B13A9085444751C4 = 1;
        }
      }

      if(_id_B13A9085444751C4)
        _id_1963A43B43E1C34D[_id_1963A43B43E1C34D.size] = _id_0C3EA9B1A20FF199;

      waitframe();
    }

    if(!_id_1963A43B43E1C34D.size) {
      wait 0.2;
      continue;
    }

    self notify("moving");
    self._id_C7AF91AAF618C93E = 1;
    _id_3EA77484BC9670AF = scripts\engine\utility::getclosest(_id_1963A43B43E1C34D[0]._id_E031661B7146A294[0].origin, _id_1963A43B43E1C34D);
    self.goalradius = 8;
    self setgoalpos(getclosestpointonnavmesh(_id_3EA77484BC9670AF.origin));
    scripts\engine\utility::waittill_any_timeout_1(5, "goal");
    self._id_C7AF91AAF618C93E = undefined;
    _id_3C891A0EE2552CDD = 0;

    if(_id_03D3FC90CD1CCDE5()) {
      if(isDefined(_id_3EA77484BC9670AF._id_E031661B7146A294) && _id_3EA77484BC9670AF._id_E031661B7146A294.size) {
        target = undefined;
        _id_C7FA1DED90140057 = scripts\engine\utility::random(_id_3EA77484BC9670AF._id_E031661B7146A294);
        target = _id_C7FA1DED90140057;
        self getenemyinfo(target);

        if(isDefined(_id_C7FA1DED90140057.vehicle))
          target = _id_C7FA1DED90140057.vehicle;

        thread _id_16FE52C37C8197BE(_id_3C891A0EE2552CDD, 1, target);
        msg = scripts\engine\utility::waittill_any_return_2("blocked", "fired_rpg");

        if(isDefined(msg) && msg == "blocked") {
          waitframe();
          continue;
        } else {
          _id_750C94BA41F40A47 = 4 + randomfloatrange(0.6, 2);
          _id_750C94BA41F40A47 = _id_750C94BA41F40A47 * 1000;
          next = gettime() + _id_750C94BA41F40A47;

          while(gettime() < next)
            waitframe();
        }
      }
    }

    waitframe();
  }
}

_id_AF4CCD9FBD81ECBE() {
  self endon("death");

  while(!self isnearanyplayer(700))
    wait 0.05;

  self.dontevershoot = 0;
  self.disablepistol = 0;
  self.combatmode = "cover";
  self notify("playerTooClose");
}

_id_F7217D985276BD76() {
  self endon("death");
  wait 1;
  self.dropweapon = 0;
  self._id_AD799295A6692B29 = 1;
}

_id_16FE52C37C8197BE(_id_3C891A0EE2552CDD, _id_F57F94B47C3BA77E, target, _id_6201FB806AD1B5D7) {
  self endon("death");
  waitframe();
  weapon = makeweapon("iw8_la_rpapa7_fakefire");
  _id_CF3EB8C682DF677C = makeweapon("iw9_la_rpapa7_mp");
  _id_E3718999D42A1C40 = 0;

  if(self.weapon.classname != weapon.classname) {
    self notify("blocked");
    return;
  }

  _id_07BE4DAEEADA81DF = getscriptablearray("guard_tower", "script_noteworthy");
  _id_C6CD9D2C6AD18DD6 = scripts\engine\utility::getclosest(self.origin, _id_07BE4DAEEADA81DF);
  _id_DAFD1CFDC4DA09B6 = int(1500);

  if(isDefined(_id_6201FB806AD1B5D7))
    _id_DAFD1CFDC4DA09B6 = int(_id_6201FB806AD1B5D7);

  ent = target;

  if(!isDefined(ent)) {
    ent = _id_89D0BAE419C876E8();

    if(!isDefined(ent)) {
      players = scripts\cp\utility::get_array_of_valid_players(1, self.origin);
      ent = scripts\engine\utility::getclosest(self.origin, players);
    }

    if(!isDefined(ent))
      return;
  }

  if(istrue(ent.ignoreme) || istrue(ent.notarget)) {
    return;
  }
  self._id_117BA4B7682780F4 = ent;
  _id_0DE36F0E76C0D98E = ent.origin - self.origin;
  _id_DDD5FB570E804BF0 = anglesToForward(self.angles);

  if(vectordot(_id_0DE36F0E76C0D98E, _id_DDD5FB570E804BF0) < 0) {
    self notify("blocked");
    return;
  }

  _id_A5BB1FA786D5B61E = distance(self.origin, ent.origin);
  _id_45353FC34D0B4031 = _id_A5BB1FA786D5B61E / _id_DAFD1CFDC4DA09B6;
  maxspeed = 0;

  if(!isPlayer(ent)) {
    _id_A474C9C03DF90F98 = length(ent vehicle_getvelocity());
    angles = ent.angles;
  } else {
    _id_A474C9C03DF90F98 = length(ent getvelocity());
    angles = vectortoangles(ent getvelocity());
  }

  fwd = vectortoangles(ent.origin - self.origin);
  start = _id_C6CD9D2C6AD18DD6.origin + (0, 0, 348);

  if(_id_F57F94B47C3BA77E) {
    start = self.origin + (0, 0, 40);

    if(self tagexists("tag_flash"))
      start = self gettagorigin("tag_flash");
  }

  if(istrue(_id_3C891A0EE2552CDD)) {
    if(isPlayer(ent))
      _id_A474C9C03DF90F98 = _id_A474C9C03DF90F98 * 2;
    else
      _id_A474C9C03DF90F98 = _id_A474C9C03DF90F98 * 1.5;
  }

  _id_48BD8D850D8A3BE6 = int(_id_A474C9C03DF90F98 * _id_45353FC34D0B4031);
  _id_DBDB6416D2651728 = getgroundposition(ent.origin + anglesToForward(angles) * _id_48BD8D850D8A3BE6, 8, 1000, 1000) + (0, 0, 2);
  _id_8C1D7E7AE38471BD = distance(start, _id_DBDB6416D2651728);
  _id_5561E4F23C58767D = _id_8C1D7E7AE38471BD / _id_DAFD1CFDC4DA09B6;
  _id_06B54F8132C372EA = distance2dsquared(self.origin, _id_DBDB6416D2651728);

  if(isDefined(self.maxrange) && _id_06B54F8132C372EA > self.maxrange) {
    self notify("blocked");
    return;
  }

  ignoreents = [_id_C6CD9D2C6AD18DD6, ent, _id_C6CD9D2C6AD18DD6.brushmodel, self];
  _id_7FE710B31B2B752D = self gettagorigin("tag_flash");
  _id_7FE710B31B2B752D = _id_7FE710B31B2B752D + anglesToForward(self gettagangles("tag_flash")) * 50;
  trace = scripts\engine\trace::ray_trace(_id_7FE710B31B2B752D, _id_DBDB6416D2651728, ignoreents, undefined, undefined, 1, 0);

  if(_id_06B54F8132C372EA > squared(3000))
    trace["fraction"] = 1;

  if(trace["fraction"] < 1) {
    self notify("blocked");
    return;
  }

  if(_id_06B54F8132C372EA < squared(900)) {
    _id_7FE710B31B2B752D = self gettagorigin("tag_flash");
    _id_7FE710B31B2B752D = _id_7FE710B31B2B752D + anglesToForward(self gettagangles("tag_flash")) * 50;
    trace = scripts\engine\trace::ray_trace(_id_7FE710B31B2B752D, _id_DBDB6416D2651728, undefined, undefined, undefined, 1, 1);

    if(trace["fraction"] < 1) {
      self notify("blocked");
      return;
    }
  }

  if(_id_06B54F8132C372EA > 2250000 && _id_06B54F8132C372EA < 49000000)
    _id_DBDB6416D2651728 = _id_DBDB6416D2651728 + (randomintrange(-300, 300), randomintrange(-300, 300), 0);
  else if(_id_06B54F8132C372EA > 49000000)
    _id_E3718999D42A1C40 = 1;

  if(getdvarint("dvar_AB2D6CCD79E6E5EE", 0) > 0) {
    _id_1AAD8F38CB38F703 = int(_id_5561E4F23C58767D * 20);
    thread scripts\engine\utility::draw_angles(angles, _id_DBDB6416D2651728, (1, 1, 0), _id_1AAD8F38CB38F703 + 40, 120);
  }

  if(istrue(_id_E3718999D42A1C40))
    magicbullet(_id_CF3EB8C682DF677C, start, _id_DBDB6416D2651728);
  else
    level thread _id_7C119025F7514006(self, weapon, start, _id_DBDB6416D2651728, _id_5561E4F23C58767D, _id_8C1D7E7AE38471BD, ignoreents);

  targetent = target;

  if(!isPlayer(target) && isDefined(target) && isDefined(target.owner))
    targetent = target.owner;

  self notify("fired_rpg");
  level notify("rpgincoming", targetent);
}

_id_7C119025F7514006(_id_7176B6A64D4D823B, weapon, start, end, _id_5561E4F23C58767D, _id_8C1D7E7AE38471BD, ignoreents) {
  magicbullet(weapon, start, end, _id_7176B6A64D4D823B);
  missile = spawn("script_model", start);
  missile setModel("weapon_wm_missile_rpapa7_fake");
  missile.angles = vectortoangles(end - missile.origin);
  missile moveTo(end, _id_5561E4F23C58767D);
  missile thread _id_7BE4481F42AB1DEB(_id_7176B6A64D4D823B, weapon);
  missile.team = "axis";
  _id_7CC95179A35321F2 = 0;

  while(_id_8C1D7E7AE38471BD > 120) {
    if(_id_7CC95179A35321F2 < 10) {
      _id_7CC95179A35321F2++;
      waitframe();
      continue;
    }

    trace = scripts\engine\trace::ray_trace(missile.origin, end, ignoreents, undefined, undefined, 1, 1);
    _id_8C1D7E7AE38471BD = distance(missile.origin, trace["position"]);
    waitframe();
  }

  missile notify("detonate");
}

_id_7BE4481F42AB1DEB(_id_7176B6A64D4D823B, weapon) {
  self waittill("detonate");

  if(!isDefined(level._id_883776A8FC2451F0))
    level._id_883776A8FC2451F0 = gettime() + 15000;
  else if(gettime() >= level._id_883776A8FC2451F0) {
    self._id_CEFCAFDECC575902 = 1;
    level._id_883776A8FC2451F0 = gettime() + 15000;
  }

  self setscriptablepartstate("default", "explode");

  if(isalive(_id_7176B6A64D4D823B))
    _id_7176B6A64D4D823B notify("rpg_detonated");

  wait 3;
  self delete();
}

_id_89D0BAE419C876E8() {
  players = scripts\cp\utility::get_array_of_valid_players(1, self.origin);

  if(!players.size)
    return undefined;

  player = players[0];

  if(isDefined(player)) {
    if(isDefined(player.vehicle))
      return player.vehicle;

    return player;
  }

  return undefined;
}

_id_03D3FC90CD1CCDE5() {
  if(!isDefined(level._id_859D194454903AB6))
    level._id_859D194454903AB6 = gettime();

  if(gettime() >= level._id_859D194454903AB6) {
    level._id_859D194454903AB6 = gettime() + 5000;
    return 1;
  }

  return 0;
}
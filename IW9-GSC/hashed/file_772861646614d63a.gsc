/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_772861646614d63a.gsc
***********************************************/

_id_E09936350B8D90FE() {
  data = spawnStruct();
  data.spawnheli = ::_id_C8189FD441946D86;
  data._id_E0FD93CDDC4B8912 = ::_id_595D4EBD73E6B933;
  data._id_25D090D8443B08A4 = ::_id_05EB66C5C1382FED;
  return data;
}

_id_C8189FD441946D86(_id_7E5A592E28788406) {
  heli = _id_B232793FE47C01B9();
  heli thread _id_282FFB050875ADE6(_id_7E5A592E28788406);
  scripts\mp\weapons::_id_E00B77A9CB4D8322(heli);
  heli._id_F6A794B2D3DC63E7 = ::_id_90AC39C3F9E0BC50;
  heli.flaresreservecount = 1;
  heli.flareslive = [];

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "handleIncomingStinger"))
    heli thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "handleIncomingStinger")]](::_id_8FE1775245B13B6F);

  return heli;
}

_id_B232793FE47C01B9() {
  node = scripts\engine\utility::getclosest((self.vehicle.origin + self.end.origin) * 0.5, level._id_77AA416377054823);
  _id_C229D93C0BB4F8E8 = spawnStruct();
  _id_C229D93C0BB4F8E8.origin = node.origin;
  _id_C229D93C0BB4F8E8.angles = node.angles;
  _id_C229D93C0BB4F8E8.classname_mp = "script_vehicle_heli_medium";
  _id_C229D93C0BB4F8E8.vehicletype = "lbravo_infil_cp";
  heli = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("little_bird", _id_C229D93C0BB4F8E8);
  heli._id_A1A5D39C25C6D70B = 1;
  heli.gunners = [];
  heli.gunners[heli.gunners.size] = _id_7512E3D88C4083FA(heli, 3);
  heli.gunners[heli.gunners.size] = _id_7512E3D88C4083FA(heli, 4);
  heli._id_0DE315B064BB20D9 = node;
  return heli;
}

_id_E1A0BA4BBCAB4D69(heli) {
  heli waittill("death");

  if(isDefined(self) && isalive(self)) {
    self.nocorpse = 1;
    _id_48814951E916AF89::_id_28B90EB2B591003F();
  }
}

_id_7512E3D88C4083FA(heli, _id_CDBB4A9588ABEF59) {
  origin = scripts\engine\utility::ter_op(isDefined(level._id_F0872E42DAF6D4D5), level._id_F0872E42DAF6D4D5, heli.origin);
  aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693("ar");
  agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, origin, heli.angles, "absolute", "mission", "vehicleDriveHeliDriver", undefined, undefined, undefined, self.node._id_B205D90302DA2F07, 1, undefined, 0);

  if(!isDefined(agent))
    return undefined;

  _id_B87E69DF003B39F5 = heli scripts\common\vehicle_aianim::get_availablepositions();
  agent.script_startingposition = _id_CDBB4A9588ABEF59;
  pos = heli scripts\common\vehicle_aianim::choose_vehicle_position(agent, _id_B87E69DF003B39F5, 0);
  agent scripts\vehicle\vehicle_common::entervehicle(heli, 1, pos, scripts\common\vehicle_aianim::anim_pos(heli, pos.vehicle_position));
  agent.vehicle_position = pos.vehicle_position;
  agent.goalradius = 10000;
  agent.maxsightdistsqrd = squared(10000);
  agent _meth_9215CE6FC83759B9(10000);
  agent.ignoreall = 1;
  return agent;
}

_id_282FFB050875ADE6(vehicle) {
  self endon("death");
  self endon("flyaway");
  self setmaxpitchroll(20, 20);
  self setneargoalnotifydist(150);
  _id_08E95E5B8FD976F6 = 0;
  _id_038FC7BD1495C4B2 = 0.1;
  self._id_83BE9A2713B0D741 = 0;

  for(;;) {
    wait(_id_038FC7BD1495C4B2);

    if(!isDefined(vehicle)) {
      thread _id_05EB66C5C1382FED();
      return;
    }

    if(istrue(self._id_E99777B08FE2D86B)) {
      continue;
    }
    veh_speed = vehicle vehicle_getspeed();
    _id_08E95E5B8FD976F6 = 0;
    _id_8C1D7E7AE38471BD = distance2dsquared(self.origin, vehicle._id_52A27C0888F8EAB7);
    self vehicle_setspeed(150, 30, 30);

    if(_id_8C1D7E7AE38471BD > 16777216)
      thread _id_0A051D3CDA138645(vehicle._id_52A27C0888F8EAB7, 1, vehicle);
    else if(_id_8C1D7E7AE38471BD > 1048576)
      thread _id_0A051D3CDA138645(vehicle._id_52A27C0888F8EAB7, 1, vehicle);

    if(_id_93B8918609703560()) {
      thread _id_05EB66C5C1382FED();
      return;
    }
  }
}

_id_692565A9023D24D7(vehicle, heli) {
  heli endon("stop_throwing");
  heli endon("death");
  heli endon("flyaway");
  heli._id_E99777B08FE2D86B = 0;
  _id_275CCD4650EAE652 = (0, 0, 0);
  _id_2427DB20DEDD2237 = (0, 0, 0);
  _id_6CADDEC344E5F991 = 0;
  _id_8250186C6D2D1E2C = 0;
  _id_4D31B9022A51B776 = heli.origin;

  for(;;) {
    if(!isDefined(vehicle)) {
      return;
    }
    if(heli _id_93B8918609703560()) {
      heli thread _id_05EB66C5C1382FED();
      return;
    }

    _id_4573A8725DD3748E = heli.origin - _id_4D31B9022A51B776;
    _id_4D31B9022A51B776 = heli.origin;
    _id_8C1D7E7AE38471BD = distance2dsquared(heli.origin, vehicle._id_52A27C0888F8EAB7);

    if(!istrue(heli._id_E99777B08FE2D86B)) {
      if(_id_8C1D7E7AE38471BD < 1048576) {
        heli vehicle_setspeed(125, 20, 20);
        speed = vehicle vehicle_getspeed();
        _id_275CCD4650EAE652 = vehicle._id_52A27C0888F8EAB7 - 1000 * vectorNormalize(vehicle._id_52A27C0888F8EAB7 - heli.origin);
        _id_2427DB20DEDD2237 = vehicle._id_52A27C0888F8EAB7 + 1000 * vectorNormalize(vehicle._id_52A27C0888F8EAB7 - heli.origin);
        _id_275CCD4650EAE652 = (_id_275CCD4650EAE652[0], _id_275CCD4650EAE652[1], heli.origin[2]);
        _id_2427DB20DEDD2237 = (_id_2427DB20DEDD2237[0], _id_2427DB20DEDD2237[1], heli.origin[2]);
        _id_694B3083479CD273 = distance2dsquared(heli.origin, _id_275CCD4650EAE652);

        if(_id_694B3083479CD273 < 122500) {
          heli._id_E99777B08FE2D86B = 1;
          _id_6CADDEC344E5F991 = 0;
          _id_8250186C6D2D1E2C = 0;
        } else
          heli thread _id_0A051D3CDA138645(_id_275CCD4650EAE652, 0, vehicle);
      }
    }

    if(istrue(heli._id_E99777B08FE2D86B)) {
      heli vehicle_setspeed(120, 20, 20);
      heli thread _id_0A051D3CDA138645(_id_2427DB20DEDD2237, 0, vehicle);

      if(_id_8C1D7E7AE38471BD < squared(2500)) {
        _id_6CADDEC344E5F991 = _id_6CADDEC344E5F991 + length(_id_4573A8725DD3748E);

        if(_id_6CADDEC344E5F991 > 500) {
          _id_6CADDEC344E5F991 = _id_6CADDEC344E5F991 - 500;
          _id_8250186C6D2D1E2C++;
          thread _id_88B12C91F836C975(heli, vehicle);
        }
      } else
        heli._id_E99777B08FE2D86B = 0;

      if(_id_8250186C6D2D1E2C > 8)
        heli._id_E99777B08FE2D86B = 0;
    }

    wait 0.1;
  }
}

_id_595D4EBD73E6B933() {
  self.vehicle endon("death");
  self endon("task_ended");
  _id_96CFF7319BC0421A = [self.vehicle.origin, self.vehicle.origin, self.vehicle.origin, self.vehicle.origin];
  _id_B3720D45E34D6FBB = 3;
  _id_448456F634611AAF = 0;

  for(;;) {
    speed = self.vehicle vehicle_getspeed();
    _id_B413A5DE3AA90B12 = 17.6;
    forward = vectorNormalize(self.vehicle.origin - _id_96CFF7319BC0421A[_id_448456F634611AAF]);
    _id_96CFF7319BC0421A[_id_448456F634611AAF] = self.vehicle.origin;
    _id_448456F634611AAF = scripts\engine\utility::ter_op(_id_448456F634611AAF < _id_B3720D45E34D6FBB - 1, _id_448456F634611AAF + 1, 0);
    self.vehicle._id_52A27C0888F8EAB7 = self.vehicle.origin + forward * speed * _id_B413A5DE3AA90B12 * 6;
    wait 0.5;
  }
}

_id_88B12C91F836C975(heli, vehicle) {
  if(!istrue(heli._id_DAC7EBF81DA6BA53)) {
    _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(vehicle._id_A21A9516D1DEDE9E, "players");
    _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("vehicledrive_helibomb", _id_E2B2BBD9E6539F11);
    heli._id_DAC7EBF81DA6BA53 = 1;
  }

  if(heli _id_93B8918609703560()) {
    heli thread _id_05EB66C5C1382FED();
    return;
  }

  gunner = scripts\engine\utility::getclosest(vehicle.origin, heli.gunners);
  start = gunner.origin + (0, 0, 40) + anglesToForward(gunner.angles) * 10;
  thread _id_61AA56CC8BF30B2F(start, heli);
}

_id_61AA56CC8BF30B2F(origin, heli) {
  level notify("dropping_bombs");
  c4 = magicgrenademanual("c4_dmz_heli", origin, (0, 0, -100));
  c4 setotherent(heli);
  c4.angles = (0, randomfloat(360), 0) + (-90, 180, 0);
  c4 setscriptablepartstate("effects", "neutral");
  c4 thread _id_8A112FFDC7706922();
  c4 scripts\engine\utility::waittill_any_timeout_1(8, "detonate");
  c4 setscriptablepartstate("effects", "explode");
  wait 3;
  c4 delete();
}

_id_8A112FFDC7706922(vehicle) {
  self endon("entitydeleted");
  _id_972D1889BBE8CC7C = squared(200);
  _id_E4F2397E1DD763A3 = squared(275);

  for(;;) {
    _id_0E6CCD23FED826D6 = 0;

    foreach(player in level.players) {
      if(!player scripts\cp_mp\utility\player_utility::isinvehicle()) {
        if(distancesquared(self.origin, player.origin) < _id_972D1889BBE8CC7C)
          _id_0E6CCD23FED826D6 = 1;

        continue;
      }

      if(distancesquared(self.origin, player.vehicle.origin) < _id_E4F2397E1DD763A3)
        _id_0E6CCD23FED826D6 = 1;
    }

    if(_id_0E6CCD23FED826D6) {
      break;
    }

    waitframe();
  }

  self notify("detonate");
}

_id_90AC39C3F9E0BC50(damage_data) {
  if(isDefined(damage_data.meansofdeath)) {
    if(isexplosivedamagemod(damage_data.meansofdeath))
      scripts\common\vehicle::_id_538EF15C254E4D34(damage_data.attacker);
    else if(scripts\engine\utility::isbulletdamage(damage_data.meansofdeath))
      return 5;
  }

  return damage_data.damage;
}

_id_8FE1775245B13B6F(player, _id_82FD3EE8FBACE30E, _id_6D87867F43E1D612, _id_5991F0E5DA9F9BD5) {
  self endon("death");

  for(;;) {
    if(!isDefined(_id_6D87867F43E1D612)) {
      break;
    }

    center = _id_6D87867F43E1D612 getpointinbounds(0, 0, 0);
    _id_6B40B4C28ABE0A05 = distance(self.origin, center);

    if(_id_6B40B4C28ABE0A05 < 4000 && _id_6D87867F43E1D612.flaresreservecount > 0) {
      _id_6D87867F43E1D612.flaresreservecount--;
      _id_6D87867F43E1D612 thread _id_C0AFE8BB86F32D06(_id_5991F0E5DA9F9BD5);
      newtarget = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "deploy"))
        newtarget = _id_6D87867F43E1D612[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "deploy")]]();

      self._id_AFCD53CFA79ABCCF = 1;
      self missile_settargetEnt(newtarget);
      self notify("missile_pairedWithFlare");
      level notify("flares", player);
      return;
    }

    waitframe();
  }
}

_id_C0AFE8BB86F32D06(_id_5991F0E5DA9F9BD5) {
  _id_0023E275144756D0 = "tag_origin";

  if(isDefined(_id_5991F0E5DA9F9BD5))
    _id_0023E275144756D0 = _id_5991F0E5DA9F9BD5;

  playsoundatpos(self gettagorigin(_id_0023E275144756D0), "ks_ac130_flares");
  playFXOnTag(scripts\engine\utility::getfx("gunship_flares"), self, _id_0023E275144756D0);
}

_id_05EB66C5C1382FED() {
  self endon("death");

  if(istrue(self._id_C1E02D477104ABD0)) {
    return;
  }
  self notify("flyaway");
  self._id_C1E02D477104ABD0 = 1;
  self setvehgoalpos(self._id_0DE315B064BB20D9.origin, 1);
  self vehicle_setspeed(80, 25, 25);
  self waittill("near_goal");
  scripts\common\vehicle_code::vehicle_deathcleanup();

  foreach(gunner in self.gunners) {
    gunner.nocorpse = 1;
    gunner _id_48814951E916AF89::_id_28B90EB2B591003F();
  }

  thread scripts\cp_mp\vehicles\vehicle::vehicle_death(self);
}

_id_93B8918609703560() {
  alive = 0;

  foreach(gunner in self.gunners) {
    if(!isDefined(gunner) || !isalive(gunner)) {
      continue;
    }
    alive++;
  }

  return alive == 0;
}

_id_03AB365A3526E539(point, _id_054B9F7146B7F95D, _id_5619B7BBC3745888) {
  _id_A1AE74A22938014D = 360 / _id_054B9F7146B7F95D;
  _id_E4B7E99A96C8829F = [];
  fwd = (1, 0, 0);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 360; _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + _id_A1AE74A22938014D) {
    _id_EACD072FEDC3FFAD = fwd * _id_5619B7BBC3745888;
    _id_124D5F9C30B15673 = (cos(_id_AC0E594AC96AA3A8) * _id_EACD072FEDC3FFAD[0] - sin(_id_AC0E594AC96AA3A8) * _id_EACD072FEDC3FFAD[1], sin(_id_AC0E594AC96AA3A8) * _id_EACD072FEDC3FFAD[0] + cos(_id_AC0E594AC96AA3A8) * _id_EACD072FEDC3FFAD[1], _id_EACD072FEDC3FFAD[2]);
    pos = point + _id_124D5F9C30B15673;
    position = spawnStruct();
    position.origin = pos;
    z = position _id_8C04A86613702B7D();
    position.origin = (position.origin[0], position.origin[1], z);
    _id_E4B7E99A96C8829F[_id_E4B7E99A96C8829F.size] = position;
  }

  return _id_E4B7E99A96C8829F;
}

_id_8C04A86613702B7D() {
  heliheight = getgroundposition(self.origin, 128, 10000, 2000) + (0, 0, 800);
  return heliheight[2];
}

_id_0A051D3CDA138645(_id_F33F587E225DE2AF, _id_E1F26216DAE25CB7, vehicle) {
  self endon("death");
  self endon("flyaway");
  self endon("circle");
  self notify("gotopos");
  self endon("gotopos");
  path = _id_30401425C3D8874F(_id_F33F587E225DE2AF, vehicle);

  foreach(index, node in path) {
    if(index == path.size - 1)
      self setvehgoalpos(node, _id_E1F26216DAE25CB7);
    else
      self setvehgoalpos(node);

    self waittill("near_goal");
  }
}

_id_30401425C3D8874F(_id_F33F587E225DE2AF, vehicle) {
  path = [];
  dir = vectortoangles(_id_F33F587E225DE2AF - self.origin);
  fwd = anglesToForward(dir);
  dist = length(self.origin - _id_F33F587E225DE2AF);

  if(dist > 250) {
    _id_63F445469B886BF8 = dist / 250;

    for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < _id_63F445469B886BF8; _id_AC0E594AC96AA3A8++) {
      if(_id_AC0E594AC96AA3A8 > 5) {
        break;
      }

      _id_6CB568FEC1CF255A = _id_AC0E594AC96AA3A8 * 250;
      _id_6C53D859D582A421 = self.origin + fwd * _id_6CB568FEC1CF255A;
      _id_57F9B1A7F5F34A7D = _id_57DD2A79F8AD4FEE(_id_6C53D859D582A421);

      if(isDefined(_id_57F9B1A7F5F34A7D)) {
        path[path.size] = _id_57F9B1A7F5F34A7D.origin;
        continue;
      }

      _id_B7059DCBBB56102C = self.gunners;
      _id_B7059DCBBB56102C[_id_B7059DCBBB56102C.size] = self;
      trace = scripts\engine\trace::ray_trace(_id_6C53D859D582A421 + (0, 0, 1000), _id_6C53D859D582A421 + (0, 0, -10000), _id_B7059DCBBB56102C, undefined, undefined, 1, 1);
      pos = getgroundposition(trace["position"] + (0, 0, 800), 32, 2000, 100);
      path[path.size] = pos + (0, 0, 800);

      if(isDefined(vehicle) && isalive(vehicle)) {
        if(path[path.size - 1][2] < vehicle.origin[2])
          path[path.size - 1] = (path[path.size - 1][0], path[path.size - 1][1], vehicle.origin[2]) + (0, 0, 800);
      }
    }
  }

  if(isDefined(vehicle) && isalive(vehicle)) {
    if(_id_F33F587E225DE2AF[2] < vehicle.origin[2])
      path[path.size] = (_id_F33F587E225DE2AF[0], _id_F33F587E225DE2AF[1], vehicle.origin[2]) + (0, 0, 800);
  } else
    path[path.size] = _id_F33F587E225DE2AF;

  path = _id_521E6D5A9479E771(path);
  return path;
}

_id_521E6D5A9479E771(path) {
  _id_DAD689C3E036D1B3 = 100;

  foreach(index, node in path) {
    if(index == path.size - 1) {
      break;
    }

    _id_4573A8725DD3748E = path[index + 1][2] - node[2];

    if(_id_4573A8725DD3748E > _id_DAD689C3E036D1B3)
      node = node + (0, 0, node[2] + _id_4573A8725DD3748E / 2);
  }

  return path;
}

_id_57DD2A79F8AD4FEE(pos) {
  if(!isDefined(level._id_6B278DCE447D6034))
    return undefined;

  _id_114AB88507847C50 = scripts\engine\utility::getclosest(pos, level._id_6B278DCE447D6034);

  if(isDefined(_id_114AB88507847C50) && distancesquared(_id_114AB88507847C50.origin, pos) <= squared(_id_114AB88507847C50.radius))
    return _id_114AB88507847C50;

  return undefined;
}
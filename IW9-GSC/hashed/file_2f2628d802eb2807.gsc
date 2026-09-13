/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2f2628d802eb2807.gsc
***********************************************/

_id_E09936350B8D90FE() {
  data = spawnStruct();
  data.spawnheli = ::_id_2D905B603E7888C9;
  data._id_E0FD93CDDC4B8912 = ::_id_595D4EBD73E6B933;
  data._id_25D090D8443B08A4 = ::_id_05EB66C5C1382FED;
  return data;
}

_id_2D905B603E7888C9(_id_7E5A592E28788406) {
  heli = _id_B232793FE47C01B9();
  heli._id_7E5A592E28788406 = _id_7E5A592E28788406;
  heli._id_B8EBE3F71A08AB40 = self;
  heli thread _id_282FFB050875ADE6(_id_7E5A592E28788406);
  heli thread _id_F21D965808C268BB();
  scripts\mp\weapons::_id_E00B77A9CB4D8322(heli);
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
  _id_C229D93C0BB4F8E8.vehicletype = "veh_apache_mp_phys";
  _id_C229D93C0BB4F8E8.modelname = "veh9_mil_air_heli_ahotel64_mp";
  _id_C229D93C0BB4F8E8.targetname = "boatdrive_apache";
  _id_EE8DA5624236DC89 = spawnStruct();
  heli = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(_id_C229D93C0BB4F8E8, _id_EE8DA5624236DC89);
  heli.vehiclename = "veh_apache_mp_phys";
  heli.maxhealth = getdvarint("dvar_3E5661644A24771E", 10000);
  heli.health = heli.maxhealth;
  heli.team = "team_hundred_ninety_five";
  heli setvehicleteam("team_hundred_ninety_five");
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(heli, undefined, heli.team);
  heli scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(1);
  heli._id_09882CD795C6BFAA = 1;
  heli scripts\mp\vehicles\damage::set_pre_mod_damage_callback("veh_apache_mp_phys", ::_id_57314B27F4592824);
  heli scripts\mp\vehicles\damage::set_post_mod_damage_callback("veh_apache_mp_phys", ::_id_499E02474DFC9171);
  heli scripts\mp\vehicles\damage::set_death_callback("veh_apache_mp_phys", ::_id_E6CBC6847A8FB80B);
  heli _meth_247AD6A91F6A4FFE(1);
  heli._id_0DE315B064BB20D9 = node;

  if(getdvarint("dvar_03061DC07ABA9108", 1))
    heli thread _id_79D4B1C751A51F03::_id_0FF7B51833A73E61();

  return heli;
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

_id_C6366A8FC111F210(heli) {
  heli waittill("death");

  if(isDefined(self))
    self delete();
}

_id_1659089CE673C063() {
  turret = spawnturret("misc_turret", self gettagorigin("tag_turret"), "chopper_gunner_turret_ballistics_dmz");
  turret setModel("veh9_mil_air_heli_ahotel64_turret");
  turret show();
  turret.angles = self.angles;
  turret.disabled = 0;
  turret._id_9E50CEF01527FF79 = undefined;
  turret linkTo(self, "tag_turret");
  turret setturretmodechangewait(0);
  turret setmode("manual");
  turret setdefaultdroppitch(45);
  turret.team = self.team;
  turret.owner = self;
  turret setturretteam(self.team);
  turret setentityowner(self);
  turret.targetent = spawn("script_origin", turret.origin);
  turret settargetentity(turret.targetent);
  self.turret = turret;
  turret.heli = self;
  turret thread _id_C6366A8FC111F210(self);
  turret.targetent thread _id_C6366A8FC111F210(self);
  return turret;
}

_id_61650F275EF0266F(tag) {
  _id_B8EE7DDD93755F86 = spawn("script_model", self gettagorigin(tag));
  _id_B8EE7DDD93755F86 setModel("ks_chopper_gunner_turret_mp");
  _id_B8EE7DDD93755F86 show();
  _id_B8EE7DDD93755F86.angles = self.angles;
  _id_B8EE7DDD93755F86 linkTo(self, tag);
  _id_B8EE7DDD93755F86 setotherent(self);
  _id_B8EE7DDD93755F86.heli = self;
  _id_B8EE7DDD93755F86 thread _id_C6366A8FC111F210(self);
  return _id_B8EE7DDD93755F86;
}

_id_4E9FCE9D930CB20B(origin) {
  _id_68E32EDB50F84A85 = vectordot(vectorNormalize(origin - self.origin), anglesToForward(self.angles));
  _id_36A24FACDE9CD6EC = vectordot(vectorNormalize(origin - self.origin), -1 * anglestoup(self.angles));
  return _id_68E32EDB50F84A85 > 0.258819 && _id_36A24FACDE9CD6EC > 0 || _id_36A24FACDE9CD6EC > 0.95;
}

_id_126E0A76E7532527(origin) {
  _id_68E32EDB50F84A85 = vectordot(vectorNormalize(origin - self.origin), anglesToForward(self.angles));
  _id_36A24FACDE9CD6EC = vectordot(vectorNormalize(origin - self.origin), -1 * anglestoup(self.angles));
  return _id_68E32EDB50F84A85 > 0.4;
}

_id_6034CFEDC8242FD6() {
  dist = distance(self._id_7E5A592E28788406.origin, self.origin);
  return dist < 10000;
}

_id_F21D965808C268BB() {
  self endon("death");
  self endon("flyaway");
  _id_1659089CE673C063();
  self._id_BDEC9A74B3B2A503 = _id_61650F275EF0266F("tag_gun_l");
  self._id_2D5A32B6A40FDA8C = _id_61650F275EF0266F("tag_gun_r");
  _id_BFD6E66686CF58D7 = 0.125;
  accumulatedtime = 0;
  totaltime = 0;
  _id_3180E2519441F60A = 40;
  _id_9456898CEF04F9F8 = _id_3180E2519441F60A * _id_BFD6E66686CF58D7;
  _id_6FAFF8A055F809E8 = _id_9456898CEF04F9F8 / 3.0;
  _id_F1963AD9C17C070F = _id_9456898CEF04F9F8 - _id_6FAFF8A055F809E8;
  _id_07272F3C81CAD93A = self._id_BDEC9A74B3B2A503;
  _id_159FEA52C5FFDD4B = getdvarfloat("dvar_7301B4FB9B20523D", 375.0);
  _id_4B795B1673603831 = getdvarfloat("dvar_1E5806E5FC11F967", 1.33);

  while(self.health > 0) {
    if(!isDefined(self._id_7E5A592E28788406)) {
      return;
    }
    results = scripts\engine\trace::ray_trace(self.origin, self._id_7E5A592E28788406.origin, [self, self.turret, self._id_BDEC9A74B3B2A503, self._id_2D5A32B6A40FDA8C, self._id_7E5A592E28788406]);

    if(distance(results["position"], self._id_7E5A592E28788406.origin) < 500) {
      self setlookatent(self._id_7E5A592E28788406);
      _id_B46DA0E82ED99618 = _id_4E9FCE9D930CB20B(self._id_7E5A592E28788406.origin);
      _id_7F424C65B880F8EE = _id_126E0A76E7532527(self._id_7E5A592E28788406.origin);

      if(!_id_B46DA0E82ED99618 && !_id_7F424C65B880F8EE) {
        waitframe();
        continue;
      }

      shootturret = undefined;

      if(_id_B46DA0E82ED99618 && !_id_7F424C65B880F8EE)
        shootturret = 1;
      else if(!_id_B46DA0E82ED99618 && _id_7F424C65B880F8EE)
        shootturret = 0;
      else
        shootturret = randomfloat(1.0) > 0.25;

      if(shootturret) {
        _id_58E50AEE46852766 = 0;
        accumulatedtime = 0;
        totaltime = 0;
        self.turret.targetent.origin = self._id_7E5A592E28788406.origin;
        velocity = self._id_7E5A592E28788406 vehicle_getvelocity();
        _id_E0570CD5D887CC29 = self._id_7E5A592E28788406.origin + velocity * 1.75;

        while(_id_58E50AEE46852766 < _id_3180E2519441F60A) {
          if(!isDefined(self._id_7E5A592E28788406)) {
            return;
          }
          if(totaltime > 5.0) {
            break;
          }

          if(_id_4E9FCE9D930CB20B(self._id_7E5A592E28788406.origin)) {
            results = scripts\engine\trace::ray_trace(self.origin, self._id_7E5A592E28788406.origin, [self, self.turret, self._id_BDEC9A74B3B2A503, self._id_2D5A32B6A40FDA8C, self._id_7E5A592E28788406]);

            if(distance(results["position"], self._id_7E5A592E28788406.origin) < 800) {
              if(totaltime < _id_4B795B1673603831)
                self.turret.targetent.origin = _id_E0570CD5D887CC29;
              else {
                _id_46F432042B3473D8 = min(distance(self.turret.targetent.origin, self._id_7E5A592E28788406.origin), _id_159FEA52C5FFDD4B * level.framedurationseconds);
                _id_4573A8725DD3748E = vectorNormalize(self._id_7E5A592E28788406.origin - self.turret.targetent.origin) * _id_46F432042B3473D8;
                self.turret.targetent.origin = self.turret.targetent.origin + _id_4573A8725DD3748E;
              }

              if(self.turret turretcantarget(self.turret.targetent.origin))
                self.turret snaptotargetentity(self.turret.targetent);

              for(accumulatedtime = accumulatedtime + level.framedurationseconds; accumulatedtime > 0; _id_58E50AEE46852766++) {
                accumulatedtime = accumulatedtime - _id_BFD6E66686CF58D7;
                self.turret shootturret();
              }
            }
          }

          totaltime = totaltime + level.framedurationseconds;
          waitframe();
        }

        wait 3.0;
      } else {
        _id_B8EE7DDD93755F86 = self._id_BDEC9A74B3B2A503;

        if(_id_07272F3C81CAD93A == self._id_BDEC9A74B3B2A503) {
          self.missilefireside = "left";
          self._id_BDEC9A74B3B2A503 thread scripts\cp_mp\killstreaks\chopper_gunner::choppergunner_firemissilefx(1);
          _id_B8EE7DDD93755F86 = self._id_BDEC9A74B3B2A503;
          _id_07272F3C81CAD93A = self._id_2D5A32B6A40FDA8C;
        } else {
          self.missilefireside = "right";
          self._id_2D5A32B6A40FDA8C thread scripts\cp_mp\killstreaks\chopper_gunner::choppergunner_firemissilefx(2);
          _id_B8EE7DDD93755F86 = self._id_2D5A32B6A40FDA8C;
          _id_07272F3C81CAD93A = self._id_BDEC9A74B3B2A503;
        }

        _id_48C7944AD56A77EC = self.turret gettagorigin("tag_pivot");
        targetpos = self._id_7E5A592E28788406.origin - self._id_7E5A592E28788406 vehicle_getvelocity() * 0.45;
        _id_A437F2B6D33146EB = vectorNormalize(targetpos - _id_48C7944AD56A77EC);
        _id_B979F793DCCB4061 = _id_B8EE7DDD93755F86.origin * (1, 1, 0) + (0, 0, _id_48C7944AD56A77EC[2]);
        _id_0429AAE2E6E20F85 = _id_B979F793DCCB4061 + _id_A437F2B6D33146EB * 100;
        _id_85FA3CDCB19D2A9C = _id_B979F793DCCB4061 + _id_A437F2B6D33146EB * 1000;
        _id_AB7356FD109D3E8D = "chopper_gunner_proj_dmz";
        missile = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon(_id_AB7356FD109D3E8D), _id_0429AAE2E6E20F85, _id_85FA3CDCB19D2A9C);
        missile.owner = self;
        wait 0.25;

        if(isDefined(missile))
          missile missile_settargetpos(targetpos);

        wait 3.0;
      }

      continue;
    }

    _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(self._id_B8EBE3F71A08AB40.teams[0], "players");

    foreach(player in _id_6D5ED003AF1F9612) {
      if(scripts\mp\utility\player::_id_AD443BBCDCF37B85(player)) {
        results = scripts\engine\trace::ray_trace(self.origin, player.origin, [self, self.turret, self._id_BDEC9A74B3B2A503, self._id_2D5A32B6A40FDA8C, self._id_7E5A592E28788406]);

        if(distance(results["position"], player.origin) < 100) {
          if(_id_4E9FCE9D930CB20B(player.origin)) {
            _id_58E50AEE46852766 = 0;
            accumulatedtime = 0;
            totaltime = 0;
            self.turret.targetent.origin = player.origin;

            while(_id_58E50AEE46852766 < _id_3180E2519441F60A && scripts\mp\utility\player::_id_AD443BBCDCF37B85(player)) {
              if(totaltime > 5.0) {
                break;
              }

              if(self.health <= 0) {
                return;
              }
              self setlookatent(player);

              if(_id_4E9FCE9D930CB20B(player.origin)) {
                results = scripts\engine\trace::ray_trace(self.origin, player.origin, [self, self.turret, self._id_BDEC9A74B3B2A503, self._id_2D5A32B6A40FDA8C, self._id_7E5A592E28788406]);

                if(distance(results["position"], player.origin) < 100) {
                  self.turret.targetent.origin = player.origin;

                  if(self.turret turretcantarget(self.turret.targetent.origin))
                    self.turret snaptotargetentity(self.turret.targetent);

                  for(accumulatedtime = accumulatedtime + level.framedurationseconds; accumulatedtime > 0; _id_58E50AEE46852766++) {
                    accumulatedtime = accumulatedtime - _id_BFD6E66686CF58D7;
                    self.turret shootturret();
                  }
                }
              }

              totaltime = totaltime + level.framedurationseconds;
              waitframe();
            }

            wait 3.0;
          }
        }

        break;
      }
    }

    waitframe();
  }
}

_id_282FFB050875ADE6(vehicle) {
  self endon("death");
  self endon("flyaway");
  self setmaxpitchroll(20, 20);
  self setneargoalnotifydist(150);
  _id_08E95E5B8FD976F6 = 0;
  _id_038FC7BD1495C4B2 = 0.5;

  for(;;) {
    wait(_id_038FC7BD1495C4B2);

    if(!isDefined(vehicle)) {
      thread _id_05EB66C5C1382FED();
      return;
    }

    veh_speed = vehicle vehicle_getspeed();
    _id_08E95E5B8FD976F6 = 0;
    _id_8C1D7E7AE38471BD = distance2dsquared(self.origin, vehicle._id_52A27C0888F8EAB7);
    self vehicle_setspeed(120, 30, 60);
    thread _id_0A051D3CDA138645(vehicle._id_AE92AA6973004447 + (0, 0, 1000), 1, vehicle);

    if(_id_93B8918609703560()) {
      thread _id_05EB66C5C1382FED();
      return;
    }
  }
}

_id_595D4EBD73E6B933() {
  self.vehicle endon("death");
  self endon("task_ended");
  self.vehicle._id_96CFF7319BC0421A = [self.vehicle.origin, self.vehicle.origin, self.vehicle.origin, self.vehicle.origin];
  _id_B3720D45E34D6FBB = 3;
  _id_B413A5DE3AA90B12 = 17.6;
  self.vehicle._id_448456F634611AAF = 0;

  for(;;) {
    speed = self.vehicle vehicle_getspeed();
    forward = vectorNormalize(self.vehicle.origin - self.vehicle._id_96CFF7319BC0421A[self.vehicle._id_448456F634611AAF]);
    self.vehicle._id_AE92AA6973004447 = self.vehicle._id_96CFF7319BC0421A[self.vehicle._id_448456F634611AAF];
    self.vehicle._id_52A27C0888F8EAB7 = self.vehicle.origin + forward * speed * _id_B413A5DE3AA90B12 * 6;
    self.vehicle._id_96CFF7319BC0421A[self.vehicle._id_448456F634611AAF] = self.vehicle.origin;
    self.vehicle._id_448456F634611AAF = scripts\engine\utility::ter_op(self.vehicle._id_448456F634611AAF < _id_B3720D45E34D6FBB, self.vehicle._id_448456F634611AAF + 1, 0);
    wait 1.0;
  }
}

_id_57314B27F4592824(data) {
  attacker = data.attacker;

  if(isDefined(attacker) && isDefined(self.turret)) {
    if(isDefined(attacker.owner)) {
      if(attacker.owner == self)
        return 0;
    }

    return attacker != self.turret;
  }

  return 1;
}

_id_499E02474DFC9171(data) {
  _id_D98D121DB25032B6(self.health - data.damage);
  return 1;
}

_id_E6CBC6847A8FB80B(data) {
  thread _id_9F77F0A198FCE7A3(data);
  return 1;
}

_id_9F77F0A198FCE7A3(data) {
  _id_6B85C01273C49F4D(150, data.objweapon);
  thread _id_CE394773C84E2427();
}

_id_D98D121DB25032B6(health) {
  if(health < self.maxhealth) {
    if(health < 300)
      _id_53A0F26F479E5869();
    else if(health > 600)
      _id_779EEFB705B4F3D9();
    else
      _id_8D8081E3B0352B3C();
  }
}

_id_8D8081E3B0352B3C() {
  self setscriptablepartstate("body_damage_light", "on");
}

_id_779EEFB705B4F3D9() {
  self setscriptablepartstate("body_damage_medium", "on");
}

_id_53A0F26F479E5869() {
  self setscriptablepartstate("body_damage_heavy", "on");
}

_id_6B85C01273C49F4D(speed, _id_11B83E21F9C87FF5) {
  self endon("explode");
  self clearlookatent();
  self notify("crashing");
  self setscriptablepartstate("engine_explosion", "on", 0);
  self setmaxpitchroll(10, 50);
  self vehicle_setspeed(speed, 20, 20);
  self setneargoalnotifydist(100);
  _id_D3197EAE18C8CC43 = "missile_damage";

  if(isDefined(_id_11B83E21F9C87FF5) && scripts\cp_mp\utility\weapon_utility::isbulletweapon(_id_11B83E21F9C87FF5))
    _id_D3197EAE18C8CC43 = "bullet_damage";

  self setscriptablepartstate("glass", _id_D3197EAE18C8CC43, 0);
  _id_6847739E80FB4E81 = scripts\cp_mp\killstreaks\chopper_gunner::choppergunner_findcrashposition(1250);

  if(!isDefined(_id_6847739E80FB4E81)) {
    return;
  }
  self setvehgoalpos(_id_6847739E80FB4E81, 0);
  thread scripts\cp_mp\killstreaks\chopper_gunner::choppergunner_spinout(speed);
}

_id_CE394773C84E2427() {
  self notify("explode");

  if(isDefined(self.owner))
    self radiusdamage(self.origin, 1000, 200, 200, self.owner, "MOD_EXPLOSIVE", "chopper_gunner_turret_mp");

  self setscriptablepartstate("explode", "on", 0);
  self setscriptablepartstate("explode_smoke", "on", 0);
  wait 0.35;
  _id_AC6C07614C22B935();
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
  self vehicle_setspeed(80, 25, 25);
  self setvehgoalpos(self._id_0DE315B064BB20D9.origin, 1);
  self waittill("near_goal");
  _id_AC6C07614C22B935();
}

_id_AC6C07614C22B935() {
  scripts\common\vehicle_code::vehicle_deathcleanup();

  if(isDefined(self.turret)) {
    self.turret setentityowner(undefined);
    self.turret delete();

    if(isDefined(self.turret.firetarget))
      self.turret.firetarget delete();
  }

  if(isDefined(self._id_BDEC9A74B3B2A503)) {
    self._id_BDEC9A74B3B2A503 setentityowner(undefined);
    self._id_BDEC9A74B3B2A503 delete();
  }

  if(isDefined(self._id_2D5A32B6A40FDA8C)) {
    self._id_2D5A32B6A40FDA8C setentityowner(undefined);
    self._id_2D5A32B6A40FDA8C delete();
  }

  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(self);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

_id_93B8918609703560() {
  return 0;
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
  heliheight = getgroundposition(self.origin, 128, 10000, 2000) + (0, 0, 1000);
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
    if(!isDefined(node) || !isDefined(vehicle)) {
      return;
    }
    if(index == path.size - 1)
      self setvehgoalpos(node, _id_E1F26216DAE25CB7);
    else
      self setvehgoalpos(node);

    angle = (self.angles[0], vectortoangles(vehicle.origin - node)[1], self.angles[2]);
    self _meth_6D14D24A1888C646(angle, 0, 2, 0.5, 0.2, 2, 1);
    self waittill("near_goal");
  }
}

_id_30401425C3D8874F(_id_F33F587E225DE2AF, vehicle) {
  path = [];
  dir = vectortoangles(_id_F33F587E225DE2AF - self.origin);
  fwd = anglesToForward(dir);
  dist = length(self.origin - _id_F33F587E225DE2AF);
  _id_4D12D9153651CB6D = self.origin;
  _id_63F445469B886BF8 = max(dist / 250, 1);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_63F445469B886BF8; _id_AC0E594AC96AA3A8++) {
    if(_id_AC0E594AC96AA3A8 > 3) {
      break;
    }

    _id_6CB568FEC1CF255A = 250;
    _id_6C53D859D582A421 = _id_4D12D9153651CB6D + fwd * _id_6CB568FEC1CF255A;
    ignore = [self, self.turret, self._id_BDEC9A74B3B2A503, self._id_2D5A32B6A40FDA8C];

    for(_id_30BEE8ACCDB898E4 = 0; _id_30BEE8ACCDB898E4 < 5; _id_30BEE8ACCDB898E4++) {
      trace = scripts\engine\trace::sphere_get_closest_point(_id_6C53D859D582A421, 400, 0, ignore);

      if(isDefined(trace["hittype"]) && trace["hittype"] != "hittype_none") {
        _id_6C53D859D582A421 = _id_6C53D859D582A421 + (0, 0, 125);
        continue;
      }

      break;
    }

    _id_800E2481BCB35003 = _id_4D12D9153651CB6D;

    for(_id_30BEE8ACCDB898E4 = 0; _id_30BEE8ACCDB898E4 < 5; _id_30BEE8ACCDB898E4++) {
      trace = scripts\engine\trace::sphere_get_closest_point(_id_800E2481BCB35003, 400, 0, ignore);

      if(isDefined(trace["hittype"]) && trace["hittype"] != "hittype_none") {
        _id_800E2481BCB35003 = _id_800E2481BCB35003 + ((0, 0, 125) + fwd * -50);
        continue;
      }

      break;
    }

    trace = scripts\engine\trace::ray_trace(_id_800E2481BCB35003, _id_6C53D859D582A421, ignore, undefined, undefined, 1, 1);

    if(isDefined(trace["hittype"]) && trace["hittype"] != "hittype_none")
      path[path.size] = _id_800E2481BCB35003;
    else {
      path[path.size] = _id_800E2481BCB35003;
      path[path.size] = _id_6C53D859D582A421;
    }

    _id_4D12D9153651CB6D = path[path.size - 1];
  }

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
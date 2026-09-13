/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_46307eda1984556f.gsc
***********************************************/

main() {
  scripts\cp_mp\vehicles\vehicle::_id_C0B3DDC9A6BDCC46("veh9_cougar", ::_id_7290F6D8C7A2A47B);
}

_id_7290F6D8C7A2A47B() {
  if(!scripts\cp_mp\vehicles\vehicle::_id_9697379150687859("veh9_cougar")) {
    return;
  }
  callbacks = [];
  callbacks["spawn"] = ::_id_64C7DC3D3B1947EC;
  callbacks["update"] = ::_id_56130F17FE28820C;
  callbacks["explode"] = ::_id_46B7E9D64AD215DE;
  callbacks["delete"] = ::_id_DEE32FF329398652;
  callbacks["initSpawnData"] = ::_id_B430AB7B23D5E0B6;
  callbacks["tankSpawn"] = ::_id_35CC6FE841001EF0;
  callbacks["updateHeadIconForPlayerOnJoinTeam"] = ::_id_91259BAB198736F7;
  callbacks["capture"] = ::_id_99525EE4D0BA15C9;
  callbacks["copySpawnData"] = ::_id_91BCE5758740BE7B;
  callbacks["tankActivate"] = ::_id_B1487F821290FCF8;
  callbacks["autoDestruct"] = ::_id_4EE463ADA98BDC74;
  callbacks["updateTeam"] = ::_id_F83B26FE3DB71B9D;
  callbacks["updateOwner"] = ::_id_623C9E05C6D3CD5B;
  callbacks["enterEnd"] = ::_id_2B551BB5FD2A71EA;
  callbacks["exitEnd"] = ::_id_0E4F419F5EB18E42;
  callbacks["reenter"] = ::_id_CF6F72B7FF33FE2E;
  callbacks["spawnPostAirdrop"] = ::_id_708960EA0D6B71B5;
  scripts\cp_mp\vehicles\vehicle::_id_08497E7E46B5E397("veh9_cougar", callbacks);
  level.vehicle._id_8BAEA35B5DCA79B0 = spawnStruct();
  level.vehicle._id_8BAEA35B5DCA79B0.canautodestruct = 1;
  level.vehicle._id_8BAEA35B5DCA79B0.autodestructdamagepercent = 11;
  level.vehicle._id_8BAEA35B5DCA79B0.cantimeout = 1;
  level.vehicle._id_8BAEA35B5DCA79B0.timeoutduration = 165;
  level.vehicle._id_8BAEA35B5DCA79B0.cantakedamageduringcapture = 1;
  level.vehicle._id_8BAEA35B5DCA79B0.showheadicon = 1;
  level.vehicle._id_8BAEA35B5DCA79B0.showheadicontoenemy = 0;
  _id_E2818AD39A3341B4 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("veh9_cougar");
  _id_DD7BB3875A51FB8D();
  _id_39C281B1C7C9C09A();
  _id_C0CB64247EB0750D();
}

_id_DD7BB3875A51FB8D() {
  _id_E2818AD39A3341B4 = scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_getleveldataforvehicle("veh9_cougar", 1);
  _id_E2818AD39A3341B4.ammoids["turret"] = 0;
  _id_E2818AD39A3341B4.ammoids["missile"] = 1;
  _id_E2818AD39A3341B4.ammoids["smoke"] = 2;
  _id_E2818AD39A3341B4.rotationids[0] = 0;
  _id_E2818AD39A3341B4.rotationids[1] = 1;
  _id_E2818AD39A3341B4.rotationrefsbyseatandweapon["driver"]["cougar_mp"] = 0;
  _id_E2818AD39A3341B4.rotationrefsbyseatandweapon["driver"]["iw9_mg_cougar_mp"] = 1;
  _id_E2818AD39A3341B4.rotationrefsbyseatandweapon["gunner"]["iw9_tur_cougar_mp"] = 0;
  _id_E2818AD39A3341B4.rotationrefsbyseatandweapon["gunner"]["iw9_mg_cougar_mp"] = 1;
}

_id_39C281B1C7C9C09A() {
  _id_E2818AD39A3341B4 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("veh9_cougar");
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setpremoddamagecallback("veh9_cougar", ::_id_BCB6803EB16B9A68);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setpostmoddamagecallback("veh9_cougar", ::_id_3BD38A556FC817B3);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setweaponhitdamagedata("iw9_tur_cougar_mp", 5);
}

_id_C0CB64247EB0750D() {
  level._effect["cougar_cannon_dust"] = loadfx("vfx/iw8_mp/weap_kickup/vfx_wk_tank_cannon_dust_w.vfx");
}

_id_64C7DC3D3B1947EC(spawndata, _id_EE8DA5624236DC89) {
  _id_B430AB7B23D5E0B6(spawndata);

  if(!isDefined(spawndata.showheadicon))
    spawndata.showheadicon = 0;

  vehicle = _id_35CC6FE841001EF0(spawndata, _id_EE8DA5624236DC89);
  return vehicle;
}

_id_708960EA0D6B71B5(spawndata, _id_EE8DA5624236DC89) {
  spawndata = scripts\cp_mp\vehicles\vehicle_spawn::_id_37480E9C9C701CF2("veh9_cougar", spawndata);
  spawndata.cannotbesuspended = 1;
  spawndata.startsuspended = 0;
  vehicle = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(spawndata, _id_EE8DA5624236DC89);

  if(!isDefined(vehicle))
    return undefined;

  turret = _id_B13AC97633C63624(vehicle, spawndata);
  scripts\cp_mp\vehicles\vehicle::vehicle_registerturret(vehicle, turret, makeweapon("iw9_mg_cougar_mp"));
  scripts\cp_mp\vehicles\vehicle::vehicle_create(vehicle, "veh9_cougar", spawndata);
  vehicle.objweapon = makeweapon("cougar_mp");
  vehicle _id_3A9262C4901EA98B();
  _id_B101137988B007D7 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getinstancedataforvehicle(vehicle, 1);
  _id_B101137988B007D7.destroyscoreevent = "none";
  scripts\cp_mp\vehicles\vehicle::vehicle_createlate(vehicle, spawndata);
  vehicle thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped();
  vehicle thread scripts\cp_mp\vehicles\vehicle::_id_1B69321FF9937FC5();
  vehicle thread _id_278B0AB7DB34D0D1();
  vehicle thread _id_2A5239B33EFABFB6();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("veh9_cougar", "create"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("veh9_cougar", "create")]](vehicle);

  return vehicle;
}

_id_B13AC97633C63624(vehicle, spawndata) {
  weaponname = "iw9_mg_cougar_mp";
  turret = spawnturret("misc_turret", vehicle gettagorigin("turret_gun_animate_jnt"), weaponname, 0);
  turret linkTo(vehicle, "turret_gun_animate_jnt", (0, 0, 0), (0, 0, 0));
  model = "veh9_mil_lnd_tank_cougar_turret_gun";

  if(isDefined(spawndata._id_14CDE247AC3313A4))
    model = spawndata._id_14CDE247AC3313A4 + "::" + model;

  turret setModel(model);
  turret setmode("sentry_offline");
  turret setsentryowner(undefined);
  turret makeunusable();
  turret setdefaultdroppitch(0);
  turret setturretmodechangewait(1);
  turret.angles = vehicle.angles;
  turret.vehicle = vehicle;
  return turret;
}

_id_B1487F821290FCF8() {
  if(istrue(self.isactivated)) {
    return;
  }
  self.isactivated = 1;
  _id_962A30A9BB8C0F09 = _id_8AE7C9135DB427E7();
  showheadicon = undefined;

  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    showheadicon = 0;
  else if(isDefined(self.spawndata.showheadicon))
    showheadicon = self.spawndata.showheadicon;
  else
    showheadicon = _id_962A30A9BB8C0F09.showheadicon;

  if(showheadicon) {
    _id_65A5074409E37DD2();
    _id_3A9262C4901EA98B();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("veh9_cougar", "activate"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("veh9_cougar", "activate")]](self);
}

_id_46B7E9D64AD215DE(data, immediate, _id_EAD0561C114B3BE8) {
  if(isDefined(data)) {
    inflictor = data.inflictor;
    meansofdeath = data.meansofdeath;
    streakname = "bradley";
    attacker = data.attacker;
    objweapon = data.objweapon;
    _id_D95DA0355CF4CCB4 = undefined;
    damage = data.damage;
    _id_92D090CE35588AD2 = "destroyed_" + streakname;
    leaderdialog = streakname + "_destroyed";
    _id_6342E2DA1DC12454 = "callout_destroyed_" + streakname;
    _id_DC695757F69ED065 = 1;
  } else {
    data = spawnStruct();
    data.inflictor = self;
    data.objweapon = "cougar_mp";
    data.meansofdeath = "MOD_EXPLOSIVE";
  }

  if(scripts\cp_mp\vehicles\vehicle::_id_B7148A3BFC4DEFB2())
    scripts\cp_mp\vehicles\vehicle::_id_E3FF0A92AD2BF58D(data, immediate);
  else
    scripts\cp_mp\vehicles\vehicle::_id_9672DA471530B44A(data, immediate);
}

_id_DEE32FF329398652(vehicle) {
  thread _id_681E3EBECA216D70(self);
  _id_28C9234E277F3DCA();

  if(isDefined(self.objent)) {
    _id_AEF8F5562150E840(self.objent);
    self.objent = undefined;
  }
}

_id_B430AB7B23D5E0B6(spawndata) {
  if(!isDefined(spawndata))
    spawndata = spawnStruct();

  if(!isDefined(spawndata.spawnmethod))
    spawndata.spawnmethod = "airdrop_at_position_unsafe";

  if(!isDefined(spawndata.cancapture))
    spawndata.cancapture = 0;

  if(!isDefined(spawndata.cancaptureimmediately))
    spawndata.cancaptureimmediately = 0;

  if(!isDefined(spawndata.activateimmediately))
    spawndata.activateimmediately = 1;

  if(!isDefined(spawndata.faceawayfromowner))
    spawndata.faceawayfromowner = 0;

  return spawndata;
}

_id_91BCE5758740BE7B(from, to) {
  to.spawnmethod = from.spawnmethod;
  to.cancapture = from.cancapture;
  to.cancaptureimmediately = from.cancaptureimmediately;
  to.activateimmediately = from.activateimmediately;
  to.faceawayfromowner = from.faceawayfromowner;
  to.cantimeout = from.cantimeout;
  to.showheadicon = from.showheadicon;
}

_id_35CC6FE841001EF0(spawndata, _id_EE8DA5624236DC89, streakinfo) {
  spawnposition = undefined;
  spawnangles = undefined;
  _id_A50521AED4831F1C = undefined;
  _id_3EE18B54B626DBA8 = undefined;
  spawndata = _id_B430AB7B23D5E0B6(spawndata);
  isairdrop = issubstr(spawndata.spawnmethod, "airdrop_");
  spawnposition = spawndata.origin;
  spawnangles = spawndata.angles;

  if(isDefined(spawndata.owner) && istrue(spawndata.faceawayfromowner)) {
    _id_8423818ECF85A883 = spawnposition - spawndata.owner.origin;

    if(length2dsquared(_id_8423818ECF85A883) > 0)
      spawnangles = vectortoangles(spawnposition - spawndata.owner.origin);
    else
      spawnangles = spawndata.owner getplayerangles(1);
  }

  if(!isDefined(spawnangles))
    spawnangles = (0, randomint(360), 0);
  else
    spawnangles = spawnangles * (0, 1, 0);

  vehicle = undefined;

  if(isairdrop)
    vehicle = _id_A03F22774B3A88D6(spawnposition, spawnangles, _id_A50521AED4831F1C, _id_3EE18B54B626DBA8, spawndata, _id_EE8DA5624236DC89);
  else
    vehicle = _id_4E3F410FCA5E2494(spawnposition, spawnangles, spawndata, _id_EE8DA5624236DC89);

  return vehicle;
}

_id_4E3F410FCA5E2494(spawnposition, spawnangles, spawndata, _id_EE8DA5624236DC89) {
  _id_E5D77BF46A926594 = spawndata.origin;
  _id_C36E41058FF56216 = spawndata.angles;
  spawndata.origin = spawnposition;
  spawndata.angles = spawnangles;
  vehicle = _id_708960EA0D6B71B5(spawndata, _id_EE8DA5624236DC89);
  spawndata.origin = _id_E5D77BF46A926594;
  spawndata.angles = _id_C36E41058FF56216;

  if(!isDefined(vehicle))
    return undefined;

  if(spawndata.cancapture) {
    if(spawndata.cancaptureimmediately)
      thread _id_9B5F4B582F7B7EAF(vehicle, spawndata.owner, spawndata.team);
  } else if(spawndata.activateimmediately)
    vehicle thread _id_B1487F821290FCF8();

  return vehicle;
}

_id_A03F22774B3A88D6(position, angles, _id_246648A337842D7D, _id_4F8BAD3CFC982AF1, spawndata, _id_EE8DA5624236DC89) {
  spawndata.origin = position;
  spawndata.angles = angles;
  objent = undefined;

  if(isDefined(_id_246648A337842D7D)) {
    if(!scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
      objent = _id_CCD0F0F299CF09A8(_id_246648A337842D7D, _id_4F8BAD3CFC982AF1, spawndata);
  }

  vehicle = _id_721EE99D7A8F9168::_id_66C684FEA143FBFD("veh9_cougar", spawndata, _id_EE8DA5624236DC89);
  vehicle.objent = objent;
  vehicle thread _id_9E0C2CD85FA8C581();
  return vehicle;
}

_id_9E0C2CD85FA8C581(objent) {
  self waittill("landed");

  while(lengthsquared(self vehicle_getvelocity()) > 400)
    waitframe();

  spawndata = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);

  if(spawndata.cancapture) {
    if(spawndata.cancaptureimmediately)
      thread _id_9B5F4B582F7B7EAF(self, self.owner, self.team);
  } else if(spawndata.activateimmediately)
    thread _id_B1487F821290FCF8();
}

_id_CCD0F0F299CF09A8(_id_246648A337842D7D, _id_4F8BAD3CFC982AF1, spawndata) {
  objid = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "requestObjectiveID")]](99);
  objent = spawn("script_model", _id_246648A337842D7D);
  objent setModel("ks_airstrike_marker_mp");
  forward = (1, 0, 0);
  right = vectorcross(forward, _id_4F8BAD3CFC982AF1);
  forward = vectorcross(_id_4F8BAD3CFC982AF1, right);
  angles = axistoangles(forward, right, _id_4F8BAD3CFC982AF1);
  objent.angles = angles;

  if(objid != -1) {
    objent.objid = objid;
    objective_onentity(objid, objent);
    objective_icon(objid, "icon_waypoint_tank");
    objective_setzoffset(objid, 55);
    objective_setplayintro(objid, 0);
    objective_setplayoutro(objid, 0);
    objective_setbackground(objid, 1);
    objective_showtoplayersinmask(objid);
    objective_state(objid, "current");

    if(level.teambased) {
      _id_9A6FCCC729B4650A = spawndata.team;

      if(!isDefined(_id_9A6FCCC729B4650A) || _id_9A6FCCC729B4650A == "neutral") {
        if(isDefined(spawndata.owner))
          _id_9A6FCCC729B4650A = spawndata.owner.team;
      }

      if(!isDefined(_id_9A6FCCC729B4650A) || _id_9A6FCCC729B4650A == "neutral") {
        objective_addalltomask(objid);
        objent setscriptablepartstate("marker_placed", "onEveryone", 0);
      } else {
        objective_addteamtomask(objid, _id_9A6FCCC729B4650A);
        _id_C67D20A79507C0F5(objent, _id_9A6FCCC729B4650A);
        objent setscriptablepartstate("marker_placed", "onTeam", 0);
      }
    } else if(!isDefined(spawndata.owner)) {
      objective_addalltomask(objid);
      objent setscriptablepartstate("marker_placed", "onEveryone", 0);
    } else {
      objective_setownerclient(objid, spawndata.owner);
      objective_addclienttomask(objid, spawndata.owner);
      objent setotherent(spawndata.owner);
      objent setscriptablepartstate("marker_placed", "on", 0);
    }
  }

  return objent;
}

_id_AEF8F5562150E840(objent) {
  if(isDefined(objent.objid))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](objent.objid);

  objent delete();
}

_id_C67D20A79507C0F5(objent, team) {
  objent notify("cougar_setTeamOtherEnt");
  objent endon("cougar_setTeamOtherEnt");
  _id_AE9ACDDA1C693FA6 = undefined;

  foreach(player in level.players) {
    if(player.team == team) {
      _id_AE9ACDDA1C693FA6 = player;
      break;
    }
  }

  if(isDefined(_id_AE9ACDDA1C693FA6)) {
    objent setotherent(_id_AE9ACDDA1C693FA6);
    childthread _id_B2CD90D16B47A903(objent, _id_AE9ACDDA1C693FA6);
    childthread _id_6ABAB9583049FFE8(objent, _id_AE9ACDDA1C693FA6);
  }
}

_id_B2CD90D16B47A903(objent, _id_AE9ACDDA1C693FA6) {
  objent endon("death");
  _id_8A04AA0E0755E7E3 = _id_AE9ACDDA1C693FA6.team;
  _id_AE9ACDDA1C693FA6 scripts\engine\utility::waittill_any_2("joined_team", "joined_spectators");
  thread _id_C67D20A79507C0F5(objent, _id_8A04AA0E0755E7E3);
}

_id_6ABAB9583049FFE8(objent, _id_AE9ACDDA1C693FA6) {
  _id_8A04AA0E0755E7E3 = _id_AE9ACDDA1C693FA6.team;
  _id_AE9ACDDA1C693FA6 waittill("disconnect");
  thread _id_C67D20A79507C0F5(objent, _id_8A04AA0E0755E7E3);
}

_id_9B5F4B582F7B7EAF(vehicle, owner, team) {
  _id_962A30A9BB8C0F09 = _id_8AE7C9135DB427E7();
  showheadicon = undefined;

  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    showheadicon = 0;
  else if(isDefined(vehicle.spawndata.showheadicon))
    showheadicon = vehicle.spawndata.showheadicon;
  else
    showheadicon = _id_962A30A9BB8C0F09.showheadicon;

  if(showheadicon) {
    vehicle _id_65A5074409E37DD2(1);
    vehicle _id_3A9262C4901EA98B(owner, team);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("veh9_cougar", "startCapture"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("veh9_cougar", "startCapture")]](vehicle, owner, team);
}

_id_681E3EBECA216D70(vehicle) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("veh9_cougar", "endCapture"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("veh9_cougar", "endCapture")]](vehicle);
}

_id_99525EE4D0BA15C9(vehicle, player) {
  thread _id_681E3EBECA216D70(vehicle);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(vehicle, player.team);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setowner(vehicle, player);
  thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(vehicle, "driver", player);
  vehicle thread _id_B1487F821290FCF8();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("veh9_cougar", "capture"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("veh9_cougar", "capture")]](player, vehicle);
}

_id_56130F17FE28820C(data) {
  if(scripts\cp_mp\vehicles\vehicle::isvehicledestroyed()) {
    return;
  }
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_updatemovefeedback("driver");
}

_id_278B0AB7DB34D0D1() {
  self endon("death");
  _id_326A22D7FEAE6244();

  for(;;) {
    message = scripts\engine\utility::waittill_any_return_2("vehicle_turret_fire", "vehicle_turret_reload_end");

    if(message == "vehicle_turret_fire")
      _id_714C103C008D6EFC();

    _id_326A22D7FEAE6244();
  }
}

_id_2A5239B33EFABFB6() {
  self endon("death");

  for(;;) {
    self waittill("vehicle_turret_fire", param1, param2, projectile);
    driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "driver");
    projectile thread _id_BF495CC5499542BE(driver);
  }
}

_id_BF495CC5499542BE(driver) {
  level endon("game_ended");
  self waittill("explode", position);

  if(!isDefined(driver)) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](position, 175, 175, driver.team, 1, driver, 1);
}

_id_E0C40131C7B05AB4(driver) {
  self endon("death");

  if(isDefined(driver)) {
    driver endon("vehicle_change_seat");
    driver endon("vehicle_seat_exit");
    driver endon("death_or_disconnect");

    while(driver reloadbuttonPressed())
      waitframe();

    _id_33193F537B85B6D4 = getdvarint("bg_useholdtimeshort", 250) / 1000;

    for(;;) {
      holdtime = 0.0;
      _id_930201649EAF32AF = driver getcurrentusereloadconfig();
      _id_72E25A59FCEF57B5 = 0;

      while(driver reloadbuttonPressed()) {
        if(!driver usinggamepad() && self _meth_AB2BDDB6CD03A29D() < weaponclipsize("iw9_tur_cougar_mp")) {
          self _meth_4012509DBD1CEE6F();
          _id_72E25A59FCEF57B5 = 1;
          _id_326A22D7FEAE6244();
          break;
        } else {
          if(self _meth_AB2BDDB6CD03A29D() < weaponclipsize("iw9_tur_cougar_mp") && _id_930201649EAF32AF > 0 && holdtime >= _id_33193F537B85B6D4) {
            self _meth_4012509DBD1CEE6F();
            _id_72E25A59FCEF57B5 = 1;
            _id_326A22D7FEAE6244();
          }

          holdtime = holdtime + level.framedurationseconds;
          waitframe();
        }
      }

      if(!_id_72E25A59FCEF57B5 && driver usinggamepad() && self _meth_AB2BDDB6CD03A29D() < weaponclipsize("iw9_tur_cougar_mp") && (_id_930201649EAF32AF == 0 && holdtime > 0.0 && holdtime < 0.2 || _id_930201649EAF32AF > 0 && holdtime >= _id_33193F537B85B6D4)) {
        self _meth_4012509DBD1CEE6F();
        _id_326A22D7FEAE6244();
      }

      waitframe();
    }
  }
}

_id_326A22D7FEAE6244() {
  driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "driver");

  if(isDefined(driver))
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("veh9_cougar", "turret", self _meth_AB2BDDB6CD03A29D(), driver);
}

_id_9AF3933C15DEE53F(player) {
  _id_962A30A9BB8C0F09 = _id_8AE7C9135DB427E7();

  if(_id_962A30A9BB8C0F09.canautodestruct) {
    if(istrue(self.autodestructactivated))
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("burningDown", player, "veh9_cougar");
    else
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("burningDown", player, "veh9_cougar");
  } else
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("burningDown", player, "veh9_cougar");
}

_id_2B551BB5FD2A71EA(vehicle, seatid, _id_FC7C7A874B43A31A, player, data) {
  if(istrue(data.success))
    thread _id_96C9A47C791FAAD7(vehicle, seatid, _id_FC7C7A874B43A31A, player, data);
}

_id_96C9A47C791FAAD7(vehicle, seatid, _id_FC7C7A874B43A31A, player, data) {
  if(seatid == "driver") {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(player, 250);
    player scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
    thread _id_64261A02A23BC333(player);
  } else if(seatid == "gunner") {
    level thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(player, 100);
    player thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(player, vehicle, "iw9_mg_cougar_mp");
    player playerlinkTo(vehicle);
    _id_23C5B222ED1973F2(player);
    player visionsetkillstreakforplayer("aviCougarGunner", 0.0);
    thread _id_9D6846994ACAA116(player);
  }

  if(!isDefined(_id_FC7C7A874B43A31A))
    vehicle _id_B1240A7393CE6237(player);

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(vehicle, _id_FC7C7A874B43A31A, seatid, player);
  _id_F0A2EE74A6062970(vehicle, _id_FC7C7A874B43A31A, seatid, player);

  if(seatid == "driver")
    vehicle thread _id_E0C40131C7B05AB4(player);
}

_id_0E4F419F5EB18E42(vehicle, seatid, _id_7558F98F3236963D, player, data) {
  if(istrue(data.success))
    thread _id_0DD16EDE536092CF(vehicle, seatid, _id_7558F98F3236963D, player, data);
}

_id_0DD16EDE536092CF(vehicle, seatid, _id_7558F98F3236963D, player, data) {
  if(seatid == "driver") {
    vehicle notify("cougar_driver_exit");

    if(!istrue(data.playerdisconnect))
      player scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
  } else if(seatid == "gunner") {
    turret = scripts\cp_mp\vehicles\vehicle::vehicle_getturretbyweapon(vehicle, "iw9_mg_cougar_mp");

    if(!istrue(data.playerdisconnect)) {
      thread _id_64261A02A23BC333(player);
      thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(player, vehicle, "iw9_mg_cougar_mp", spawnStruct());
      player enableturretdismount();

      if(player islinked())
        player unlink();

      player visionsetkillstreakforplayer("");
      thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_cleardisablefirefortime(player, data.playerdeath);
    }

    turret.owner = undefined;
    turret setotherent(undefined);
    turret setentityowner(undefined);
    turret setsentryowner(undefined);
    _id_7284FA444E21F375(player);
  }

  if(!istrue(data.playerdisconnect)) {
    if(!isDefined(_id_7558F98F3236963D))
      vehicle _id_B1240A7393CE6237(player);

    success = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit(vehicle, seatid, _id_7558F98F3236963D, player, data);

    if(!success) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "handleSuicideFromVehicles"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "handleSuicideFromVehicles")]](player);
      else
        player suicide();
    }
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(vehicle, seatid, _id_7558F98F3236963D, player);
}

_id_9D6846994ACAA116(player) {
  player setclienttriggeraudiozone("veh_tank_cougar_turret", 0.2);
}

_id_64261A02A23BC333(player) {
  player clearclienttriggeraudiozone(0.2);
}

_id_CF6F72B7FF33FE2E(vehicle, _id_9DE41F2EE77C33BA, _id_3F68C37BAFD38606, player, data) {
  if(isDefined(_id_3F68C37BAFD38606) && _id_3F68C37BAFD38606 == "gunner")
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(player, vehicle, "iw9_mg_cougar_mp", data, 1);
}

_id_23C5B222ED1973F2(player) {
  if(isDefined(player.gunnerdamagemodifier)) {
    return;
  }
  player scripts\cp_mp\utility\damage_utility::adddamagemodifier("ltGunnerMissileRedux", 0.4, 0, ::_id_B3A628C74B243041);
}

_id_7284FA444E21F375(player) {
  if(!isDefined(player.gunnerdamagemodifier)) {
    return;
  }
  player.gunnerdamagemodifier = undefined;
  player scripts\cp_mp\utility\damage_utility::removedamagemodifier("ltGunnerMissileRedux", 0);
}

_id_B3A628C74B243041(inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc) {
  if(meansofdeath != "MOD_PROJECTILE_SPLASH" && meansofdeath != "MOD_GRENADE_SPLASH")
    return 1;

  if(!isDefined(objweapon))
    return 1;

  switch (objweapon.basename) {
    case "iw8_la_kgolf_mp":
    case "iw8_la_mike32_mp":
    case "iw8_la_rpapa7_mp":
    case "iw9_tur_apc_russian_mp":
    case "iw9_tur_cougar_mp":
    case "iw8_la_juliet_mp":
    case "iw9_la_juliet_mp":
    case "iw9_la_gromeo_mp":
    case "iw8_la_gromeo_mp":
    case "iw8_la_gromeoks_mp":
      return 0;
    default:
      return 1;
  }
}

_id_BCB6803EB16B9A68(data) {
  if(scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_isselfdamage(self, data))
    return 0;

  _id_6B11D3047F506FB6 = self.origin - data.point;
  normal = anglestoup(self.angles);
  dist = vectordot(_id_6B11D3047F506FB6, normal);
  _id_D74074AD5396E58A = data.point + normal * dist;
  _id_C47F1816352556DD = vectorNormalize(_id_D74074AD5396E58A - self.origin);
  forward = anglesToForward(self.angles);
  right = anglestoright(self.angles);

  if(vectordot(_id_C47F1816352556DD, forward) < -0.83)
    data.isrearcriticaldamage = scripts\cp_mp\vehicles\vehicle_damage::_id_1989BD346C21B68A(data);

  return 1;
}

_id_3BD38A556FC817B3(data) {
  if(istrue(data.isrearcriticaldamage))
    data.damage = int(data.damage * 1.25);

  return 1;
}

_id_4EE463ADA98BDC74(attacker) {
  self endon("death");
  self notify("flipped_end");

  if(!istrue(self.autodestructactivated)) {
    self.autodestructactivated = 1;

    if(!scripts\common\utility::iscp()) {
      maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getheavystatemaxhealth(self);
      self.health = int(min(self.health, maxhealth));
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsondamage(self);
      scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_updatestate();
    } else {
      occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

      foreach(_id_F85572CD5F6117C6 in occupants)
      _id_9AF3933C15DEE53F(_id_F85572CD5F6117C6);

      wait 5.5;
      thread _id_46B7E9D64AD215DE(undefined, undefined, 1);
    }
  }
}

_id_714C103C008D6EFC() {
  contents = physics_createcontents(["physicscontents_itemclip", "physicscontents_water", "physicscontents_glass", "physicscontents_item"]);
  ignorelist = self getlinkedchildren();

  if(!isDefined(ignorelist))
    ignorelist = [];

  ignorelist[ignorelist.size] = self;
  caststart = self gettagorigin("tag_flash");
  castend = caststart + (-0, -0, -200);
  _id_E021C2744CC7ED68 = physics_raycast(caststart, castend, contents, ignorelist, 0, "physicsquery_closest", 1);

  if(!isDefined(_id_E021C2744CC7ED68) || !_id_E021C2744CC7ED68.size) {
    return;
  }
  forward = anglesToForward(self gettagangles("tag_flash") * (0, 1, 0));
  up = _id_E021C2744CC7ED68[0]["normal"];
  right = vectorcross(forward, up);
  up = vectorcross(right, forward);
  angles = axistoangles(forward, right, up);
  playFX(scripts\engine\utility::getfx("cougar_cannon_dust"), _id_E021C2744CC7ED68[0]["position"], anglesToForward(angles), anglestoup(angles));
}

_id_65A5074409E37DD2(_id_45C9B66826527876) {
  icon = self.headicon;

  if(!isDefined(icon)) {
    icon = scripts\cp_mp\entityheadicons::setheadicon_createnewicon();

    if(!isDefined(icon))
      return 0;

    self.headicon = icon;
    setheadiconzoffset(icon, 110);
  }

  self.headiconforcapture = istrue(_id_45C9B66826527876);
  _id_30516B4AFD1763DE = scripts\engine\utility::ter_op(istrue(_id_45C9B66826527876), 0, 0);
  maxdist = scripts\engine\utility::ter_op(istrue(_id_45C9B66826527876), 2250, 2250);
  _id_94DC5DEAB609FDC9 = scripts\engine\utility::ter_op(istrue(_id_45C9B66826527876), 1, 0);
  _id_C18F8868BD35FEE2 = scripts\engine\utility::ter_op(istrue(_id_45C9B66826527876), 1, 0);
  setheadiconnaturaldistance(icon, _id_30516B4AFD1763DE);
  setheadiconmaxdistance(icon, maxdist);
  setheadicondrawthroughgeo(icon, _id_94DC5DEAB609FDC9);
  setheadiconsnaptoedges(icon, _id_C18F8868BD35FEE2);

  if(istrue(level._id_32FE21B3C5052471) && level.teambased)
    _func_CE9D0299637C2C24(icon, 1);
}

_id_28C9234E277F3DCA() {
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headicon);
  self.headicon = undefined;
  self.headiconowneroverride = undefined;
  self.headiconteamoverride = undefined;
}

_id_3A9262C4901EA98B(_id_26EBC4AB45D7E908, _id_C8251387149387A0) {
  if(!isDefined(self.headicon)) {
    return;
  }
  if(isDefined(_id_26EBC4AB45D7E908)) {
    if(isstring(_id_26EBC4AB45D7E908) && _id_26EBC4AB45D7E908 == "none")
      self.headiconowneroverride = undefined;
    else
      self.headiconowneroverride = _id_26EBC4AB45D7E908;
  }

  if(isDefined(_id_C8251387149387A0)) {
    if(_id_C8251387149387A0 == "none")
      self.headiconteamoverride = undefined;
    else
      self.headiconteamoverride = _id_C8251387149387A0;
  }

  _id_6E196DF1B93BB28E();
  _id_EE13A7408E86EDE2();
  _id_4FF4B1B1672C82F0();

  foreach(player in level.players)
  _id_B1240A7393CE6237(player);
}

_id_B1240A7393CE6237(player) {
  if(!isDefined(self.headicon)) {
    return;
  }
  vehicle = player scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(vehicle) && vehicle == self)
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headicon, player);
  else {
    owner = undefined;

    if(isDefined(self.headiconowneroverride))
      owner = self.headiconowneroverride;
    else
      owner = self.owner;

    team = undefined;

    if(isDefined(self.headiconteamoverride))
      team = self.headiconteamoverride;
    else
      team = self.team;

    _id_962A30A9BB8C0F09 = _id_8AE7C9135DB427E7();

    if(level.teambased) {
      if(team == "neutral") {
        if(!isDefined(owner)) {
          if(1)
            scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headicon, player);
          else
            scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headicon, player);

          return;
        } else
          team = owner.team;
      }

      if(isenemyteam(team, player.team)) {
        if(istrue(_id_962A30A9BB8C0F09.showheadicontoenemy))
          scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headicon, player);
        else
          scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headicon, player);
      } else
        scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headicon, player);
    } else {
      if(!isDefined(owner)) {
        if(1)
          scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headicon, player);
        else
          scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headicon, player);

        return;
      }

      if(player != owner) {
        if(_id_962A30A9BB8C0F09.showheadicontoenemy) {
          scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headicon, player);
          return;
        }

        scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headicon, player);
        return;
        return;
      }

      scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headicon, player);
    }
  }
}

_id_91259BAB198736F7(player) {
  lighttanks = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("veh9_cougar");

  foreach(lighttank in lighttanks)
  lighttank _id_B1240A7393CE6237(player);
}

_id_6E196DF1B93BB28E() {
  if(level.teambased)
    return 0;

  owner = undefined;

  if(isDefined(self.headiconowneroverride))
    owner = self.headiconowneroverride;
  else
    owner = self.owner;

  if(isDefined(owner))
    setheadiconowner(self.headicon, owner);
  else
    setheadiconowner(self.headicon, undefined);

  return 1;
}

_id_EE13A7408E86EDE2() {
  if(!level.teambased) {
    return;
  }
  team = _id_36DA96B7C7CC22C9();

  if(isDefined(team) && team != "neutral")
    setheadiconteam(self.headicon, team);
  else
    setheadiconteam(self.headicon, undefined);
}

_id_4FF4B1B1672C82F0() {
  _id_962A30A9BB8C0F09 = _id_8AE7C9135DB427E7();
  _id_9318D957CB71A518 = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), 1, 1);

  if(_id_9318D957CB71A518) {
    setheadiconfriendlyimage(self.headicon, level.factionfriendlyheadicon);

    if(1)
      setheadiconneutralimage(self.headicon, level.factionenemyheadicon);

    if(_id_962A30A9BB8C0F09.showheadicontoenemy)
      setheadiconenemyimage(self.headicon, level.factionenemyheadicon);
  } else {
    _id_C3E202ACF77E4DD4 = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), 1, 1);
    _id_F1A0DCC04676E92F = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), 0, _id_962A30A9BB8C0F09.showheadicontoenemy);
    _id_74CE33B771C6CA07 = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), "hud_icon_killstreak_bradley_friendly", "hud_icon_killstreak_bradley_friendly");
    _id_9830D857024187A1 = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), "hud_icon_killstreak_bradley", "hud_icon_killstreak_bradley");
    _id_36A93664071874B4 = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), "hud_icon_killstreak_bradley_enemy", "hud_icon_killstreak_bradley_enemy");
    setheadiconfriendlyimage(self.headicon, _id_74CE33B771C6CA07);

    if(_id_C3E202ACF77E4DD4)
      setheadiconneutralimage(self.headicon, _id_9830D857024187A1);

    if(_id_F1A0DCC04676E92F)
      setheadiconenemyimage(self.headicon, _id_36A93664071874B4);
  }
}

_id_36DA96B7C7CC22C9() {
  owner = undefined;

  if(isDefined(self.headiconowneroverride))
    owner = self.headiconowneroverride;
  else
    owner = self.owner;

  team = undefined;

  if(isDefined(self.headiconteamoverride))
    team = self.headiconteamoverride;
  else
    team = self.team;

  _id_9A6FCCC729B4650A = team;

  if(!isDefined(_id_9A6FCCC729B4650A) || team == "neutral") {
    if(isDefined(owner))
      _id_9A6FCCC729B4650A = owner.team;
  }

  return _id_9A6FCCC729B4650A;
}

_id_8AE7C9135DB427E7() {
  return level.vehicle._id_8BAEA35B5DCA79B0;
}

_id_F83B26FE3DB71B9D(vehicle, team, _id_4BCF5A0C6C1E3A44) {
  turrets = scripts\cp_mp\vehicles\vehicle::vehicle_getturrets(vehicle);

  foreach(turret in turrets)
  turret.team = team;

  if(isDefined(vehicle.headicon)) {
    if(_id_4BCF5A0C6C1E3A44) {
      vehicle _id_EE13A7408E86EDE2();
      vehicle _id_4FF4B1B1672C82F0();

      foreach(player in level.players)
      vehicle _id_B1240A7393CE6237(player);
    }
  }
}

_id_623C9E05C6D3CD5B(vehicle, owner, _id_443185A3B7BBA89C, _id_1FBDA3BED6B9855F) {
  if(isDefined(vehicle.headicon)) {
    if(_id_443185A3B7BBA89C)
      vehicle _id_6E196DF1B93BB28E();

    if(_id_1FBDA3BED6B9855F) {
      vehicle _id_EE13A7408E86EDE2();
      vehicle _id_4FF4B1B1672C82F0();
    }

    if(_id_443185A3B7BBA89C || _id_1FBDA3BED6B9855F) {
      foreach(player in level.players)
      vehicle _id_B1240A7393CE6237(player);
    }
  }
}

_id_F0A2EE74A6062970(vehicle, _id_FC7C7A874B43A31A, _id_7558F98F3236963D, player) {
  if(_id_7558F98F3236963D == "driver")
    vehicle _id_326A22D7FEAE6244();

  vehicle _id_9AF3933C15DEE53F(player);
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_63002651c12f57e3.gsc
***********************************************/

_id_CE9D634E565EF6DE(vehicles) {
  if(!isDefined(vehicles)) {
    return;
  }
  foreach(vehicle in vehicles)
  _id_791C40715C757BD9(vehicle);
}

_id_791C40715C757BD9(vehicle) {
  if(!isDefined(vehicle)) {
    return;
  }
  if(isDefined(vehicle._id_BED6AB8862CF09D4) && isDefined(vehicle.spawnposition) && isDefined(vehicle._id_6E4BEAAC52CE2B4A))
    vehicle._id_F86FAA8C5CA8BA0C = [[vehicle._id_BED6AB8862CF09D4]](vehicle.spawnposition, vehicle._id_6E4BEAAC52CE2B4A);

  if(isDefined(vehicle._id_F86FAA8C5CA8BA0C)) {
    if(isDefined(vehicle._id_2F5F426A3FF12A8F))
      vehicle._id_F86FAA8C5CA8BA0C _id_B9A4D29F4BC73806();

    if(isDefined(vehicle._id_02AF88AD24B92688))
      vehicle._id_F86FAA8C5CA8BA0C vehicle_turnengineon();

    if(isDefined(vehicle._id_31878741D5F2CDCE))
      vehicle._id_F86FAA8C5CA8BA0C dodamage(vehicle._id_F86FAA8C5CA8BA0C.health * vehicle._id_31878741D5F2CDCE, vehicle.spawnposition);

    if(isDefined(vehicle._id_F30F8C24E29E01FB))
      vehicle.vfx = spawnscriptable(vehicle._id_F30F8C24E29E01FB[0], vehicle._id_F30F8C24E29E01FB[1], vehicle._id_F30F8C24E29E01FB[2]);

    vehicle thread _id_71A45813BE39078E();
  }
}

_id_71A45813BE39078E() {
  while(isDefined(self._id_F86FAA8C5CA8BA0C))
    wait 1;

  if(isDefined(self.vfx))
    self.vfx.origin = (0, 0, 0);
}

_id_1BC8A302D36B9AB8(position, rotation) {
  if(!scripts\cp_mp\vehicles\vehicle::_id_FA537F1AB52A76D1("atv")) {
    return;
  }
  spawndata = spawnStruct();
  _id_EE8DA5624236DC89 = spawnStruct();
  spawndata.origin = position;
  spawndata.angles = rotation;
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("atv", spawndata, _id_EE8DA5624236DC89);
  return vehicle;
}

_id_7FAF4FC46A309CE4(position, rotation) {
  if(!scripts\cp_mp\vehicles\vehicle::_id_FA537F1AB52A76D1("little_bird")) {
    return;
  }
  spawndata = spawnStruct();
  _id_EE8DA5624236DC89 = spawnStruct();
  spawndata.origin = position;
  spawndata.angles = rotation;
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("little_bird", spawndata, _id_EE8DA5624236DC89);
  return vehicle;
}

_id_441B0847B091C73F(position, rotation) {
  if(!scripts\cp_mp\vehicles\vehicle::_id_FA537F1AB52A76D1("tac_rover")) {
    return;
  }
  spawndata = spawnStruct();
  _id_EE8DA5624236DC89 = spawnStruct();
  spawndata.origin = position;
  spawndata.angles = rotation;
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("tac_rover", spawndata, _id_EE8DA5624236DC89);
  return vehicle;
}

_id_C446FAECE0456AFC(position, rotation) {
  if(!scripts\cp_mp\vehicles\vehicle::_id_FA537F1AB52A76D1("veh9_mil_cargo_truck")) {
    return;
  }
  spawndata = spawnStruct();
  _id_EE8DA5624236DC89 = spawnStruct();
  spawndata.origin = position;
  spawndata.angles = rotation;
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_mil_cargo_truck", spawndata, _id_EE8DA5624236DC89);
  return vehicle;
}

_id_9758ACFF14AE878E(position, rotation) {
  if(!scripts\cp_mp\vehicles\vehicle::_id_FA537F1AB52A76D1("veh9_suv_1996")) {
    return;
  }
  spawndata = spawnStruct();
  _id_EE8DA5624236DC89 = spawnStruct();
  spawndata.origin = position;
  spawndata.angles = rotation;
  spawndata.vehicletype = "suv_1996_spawn";
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_suv_1996", spawndata, _id_EE8DA5624236DC89);
  return vehicle;
}

_id_0944743524ECAEA3(position, speed, _id_D99757891D1ED279, yaw, hovering) {
  if(!isDefined(self) || !isDefined(position) || !isDefined(speed) || !isDefined(_id_D99757891D1ED279)) {
    return;
  }
  self vehicle_turnengineon();
  self vehicle_setspeed(speed, _id_D99757891D1ED279);

  if(isDefined(hovering))
    self sethoverparams(hovering[0], hovering[1], hovering[2]);

  self setvehgoalpos(position, 1);

  if(isDefined(yaw))
    self setgoalyaw(yaw);
}

_id_721F3E8A51E2D485(_id_DB585B8134EED64C) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_DB585B8134EED64C.size; _id_AC0E594AC96AA3A8++) {
    _id_0944743524ECAEA3(_id_DB585B8134EED64C[_id_AC0E594AC96AA3A8].position, _id_DB585B8134EED64C[_id_AC0E594AC96AA3A8].speed, _id_DB585B8134EED64C[_id_AC0E594AC96AA3A8]._id_D99757891D1ED279, _id_DB585B8134EED64C[_id_AC0E594AC96AA3A8].yaw, _id_DB585B8134EED64C[_id_AC0E594AC96AA3A8].hovering);
    self waittill("goal");
  }
}

_id_B9A4D29F4BC73806(callback) {
  if(!isDefined(self)) {
    return;
  }
  self dodamage(self.health, self.origin);

  if(isDefined(callback))
    thread[[callback]](self);
}

_id_4D84A1C381ECE6C0(callback) {
  if(!isDefined(self)) {
    return;
  }
  thread _id_00063A435765CC08(callback);
}

_id_00063A435765CC08(callback) {
  _id_78A83FBADAB6E339 = self.health;

  while(self.health >= _id_78A83FBADAB6E339)
    waitframe();

  _id_B9A4D29F4BC73806(callback);
}

_id_11CC5DBD12CB9F9E(position, speed) {
  if(!isDefined(self)) {
    return;
  }
  thread _id_446ED0697B1B25A2(position, speed);
}

_id_446ED0697B1B25A2(position, speed) {
  if(!isDefined(speed))
    speed = 40;

  if(self vehicle_isphysveh())
    self vehphys_crash();

  self vehicle_setspeed(speed, 15, 10);
  self setvehgoalpos(position, 0);

  if(soundexists("hind_helicopter_dying_loop"))
    self playLoopSound("hind_helicopter_dying_loop");

  thread _id_35DA48C2E41C32F7();
  wait 3;
  level notify("vehicle_crashDone");
}

_id_35DA48C2E41C32F7() {
  level endon("vehicle_crashDone");
  self clearlookatent();
  self setmaxpitchroll(60, 90);
  self setyawspeed(700, 200, 200);

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    _id_3F403475C9BCA3F7 = randomintrange(140, 170);
    self settargetyaw(self.angles[1] + _id_3F403475C9BCA3F7);
    wait 0.5;
  }
}

_id_EE15CB02C86EDC6E(vehicle) {
  return scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(vehicle);
}

_id_CB90A442BF4D8100(modifier) {
  if(!isDefined(self) || !scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    return;
  }
  switch (modifier) {
    case "immuneToPlayer":
      scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setpremoddamagecallback(self.vehiclename, ::_id_1E94E45FCB25F69A);
      break;
    case "none":
      scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setpremoddamagecallback(self.vehiclename, ::_id_7F608C6951FD341D);
      break;
    default:
      scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setpremoddamagecallback(self.vehiclename, ::_id_7F608C6951FD341D);
      break;
  }
}

_id_1E94E45FCB25F69A(data) {
  if(data.inflictor == level.player)
    data.damage = 0;

  return 1;
}

_id_7F608C6951FD341D(data) {
  return 0;
}
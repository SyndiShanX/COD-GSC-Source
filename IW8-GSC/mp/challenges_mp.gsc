/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\challenges_mp.gsc
***********************************************/

spawn_enemy_tank(var_0) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_1 = spawnStruct();
  var_2 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1.spawntype = "_encstr_AFBE0AD105A651FA9A3D8854";
  var_1.owner = undefined;
  var_1.team = "_encstr_8E8405EA382B2A";
  var_1.faceawayfromowner = 0;
  var_1.cancapture = 0;
  var_1.cancaptureimmediately = 0;
  var_1.spawnmethod = "_encstr_8A9A1B47D79A98B327BBE769254F29652A63A3D730A2C78D5DFFBFEC55";
  var_1.activateimmediately = 1;
  var_1.cantimeout = 0;
  var_1.usealtmodel = 1;
  scripts\cp_mp\vehicles\light_tank::light_tank_initializespawndata(var_1);
  var_3 = scripts\cp_mp\vehicles\light_tank::light_tank_spawn(var_1, var_2);

  if(!isDefined(var_3)) {
    return;
  }
  wait 10;
  level.enemy_tanks[level.enemy_tanks.size] = var_3;
  var_3 thread _id_13A3E();
  var_3 thread tank_waittill_death();
  var_3 thread _id_14350();
  var_3 endon("_encstr_AD75063D571AE108");
  var_3 scripts\cp_mp\vehicles\light_tank::light_tank_activate();
  var_4 = scripts\engine\utility::getStructArray("_encstr_874D103A18A33D87B66D31268ADEEB46F940", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = sortbydistance(var_4, var_3.origin)[0];
  var_6 = build_tank_path(var_5);
  var_7 = build_tank_duration(var_5);
  var_3 startpathnodes(var_6, var_7);
  setheadiconsnaptoedges(var_3.headicon, 8088);
  var_8 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_3, "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8");
  var_8 scripts\cp_mp\emp_debuff::set_start_emp_callback(::tank_empstarted);
  var_8 scripts\cp_mp\emp_debuff::set_clear_emp_callback(::tank_empcleared);
  var_9 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_3, "_encstr_977F153AAEE4AF3BEAE67D63963B1A3AD1859BDAEB5B83");
  var_9 scripts\cp_mp\emp_debuff::set_start_emp_callback(::tank_empstarted);
  var_9 scripts\cp_mp\emp_debuff::set_clear_emp_callback(::tank_empcleared);

  if(!isDefined(level.vo_paratroopers))
    level.vo_paratroopers = [];

  level.vo_paratroopers = scripts\engine\utility::array_add(level.vo_paratroopers, var_3);

  for(;;) {
    var_10 = var_3 initdragonsbreathusage();
    var_11 = var_3 scripts\cp\utility::get_closest_living_player(undefined, var_10);

    if(!isDefined(var_11)) {
      var_8 cleartargetentity();
      var_9 cleartargetentity();
      wait 1;
      continue;
    }

    _id_13A4F(var_8, var_11);
    _id_13A4F(var_9, var_11);

    if(scripts\engine\utility::flag_exist("_encstr_B4910DD36ABF0F48B55B9FD5625FD0") && !scripts\engine\utility::flag("_encstr_B4910DD36ABF0F48B55B9FD5625FD0"))
      scripts\engine\utility::flag_set("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");

    level notify("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
    wait(randomfloatrange(3, 5));
  }
}

initdragonsbreathusage() {
  var_0 = level.players;
  var_1 = [];

  foreach(var_3 in var_0) {
    if(istrue(var_3.ignoreme)) {
      continue;
    }
    if(istrue(self.ignoreall)) {
      continue;
    }
    if(_id_124F8(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_124F8(var_0) {
  var_1 = 2000;

  if(istrue(self.alerted))
    var_1 = 6000;

  if(scripts\engine\utility::flag_exist("_encstr_B4910DD36ABF0F48B55B9FD5625FD0") && !scripts\engine\utility::flag("_encstr_B4910DD36ABF0F48B55B9FD5625FD0")) {
    if(isDefined(var_0.perk_data["_encstr_995214C2933079D235D97F6B235E9B8F58D9FE8DA9E0"]))
      var_1 = var_1 * var_0.perk_data["_encstr_995214C2933079D235D97F6B235E9B8F58D9FE8DA9E0"];
  }

  var_2 = var_1 * var_1;

  if(distancesquared(self.origin, var_0.origin) > var_2)
    return 1;

  return 0;
}

_id_14350() {
  self endon("_encstr_AD75063D571AE108");
  wait 5;

  for(;;) {
    wait 1;

    if(self vehicle_getspeed() < 1) {
      self stoppath(1);
      return;
    }
  }
}

_id_13A4F(var_0, var_1) {
  var_2 = 0;

  if(var_0 scripts\cp_mp\emp_debuff::is_empd())
    var_0 cleartargetentity();
  else if(istrue(var_1.binvehicle) && isDefined(var_1.vehicle)) {
    if(var_0 turretcantarget(var_1.vehicle.origin + (0, 0, 50))) {
      var_0 settargetentity(var_1.vehicle, (0, 0, 50));
      var_2 = 1;
    }
  } else {
    var_0 settargetentity(var_1);
    var_2 = 1;
  }

  if(var_2)
    thread tank_shoot_at_target(var_0);
}

tank_empstarted(var_0) {
  _id_13A49();
}

tank_empcleared(var_0) {
  if(var_0) {
    return;
  }
  _id_13A49();
}

_id_13A49() {
  if(scripts\cp_mp\emp_debuff::is_empd()) {
    self turretfiredisable();
    self laseroff();
  } else
    self turretfireenable();
}

tank_shoot_at_target(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");
  var_2 = 1;
  var_3 = getcompleteweaponname("_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8");

  if(istrue(var_1)) {
    var_2 = randomintrange(15, 25);
    var_3 = getcompleteweaponname("_encstr_977F153AAEE4AF3BEAE67D63963B1A3AD1859BDAEB5B83");
  }

  var_4 = weaponfiretime(var_3);

  for(var_5 = 0; var_5 < var_2; var_5++) {
    var_0 shootturret();
    wait(var_4);
  }
}

build_tank_path(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = [];
  var_2 = var_0;

  for(var_1[var_1.size] = var_2.origin; isDefined(var_2) && isDefined(var_2.target); var_1[var_1.size] = var_2.origin)
    var_2 = scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  return var_1;
}

build_tank_duration(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = [];
  var_2 = var_0;

  for(var_1[var_1.size] = 10; isDefined(var_2) && isDefined(var_2.target); var_1[var_1.size] = 10)
    var_2 = scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  return var_1;
}

_id_13A3E() {
  var_0 = 0;

  while(!var_0) {
    self waittill("_encstr_BA22087EA808525BA5D9", var_1);

    if(isDefined(var_1.attacker.team)) {
      if(var_1.attacker.team != self.team)
        var_0 = 1;
    }
  }

  self.alerted = 1;
}

tank_waittill_death() {
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(self.headicon)) {
    setheadiconimage(self.headicon);
    self.headicon = undefined;
  }

  level.enemy_tanks = scripts\engine\utility::array_remove(level.enemy_tanks, self);
  level.vo_paratroopers = scripts\engine\utility::array_remove(level.vo_paratroopers, self);
}
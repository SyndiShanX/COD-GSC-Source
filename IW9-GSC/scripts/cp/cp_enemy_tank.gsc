/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_enemy_tank.gsc
***********************************************/

spawn_enemy_tank(struct) {
  if(!isDefined(struct.angles))
    struct.angles = (0, 0, 0);

  spawndata = spawnStruct();
  _id_EE8DA5624236DC89 = spawnStruct();
  spawndata.origin = struct.origin;
  spawndata.angles = struct.angles;
  spawndata.spawntype = "GAME_MODE";
  spawndata.owner = undefined;
  spawndata.team = "axis";
  spawndata.faceawayfromowner = 0;
  spawndata.cancapture = 0;
  spawndata.cancaptureimmediately = 0;
  spawndata.activateimmediately = 1;
  spawndata.cantimeout = 0;
  spawndata.usealtmodel = 1;
  spawndata._id_297E28A8CE9F0F97 = struct._id_297E28A8CE9F0F97;

  if(isDefined(struct.spawnmethod))
    spawndata.spawnmethod = struct.spawnmethod;
  else
    spawndata.spawnmethod = "airdrop_at_position_unsafe";

  if(isDefined(struct._id_1AEA8EAACA8ADC25))
    spawndata._id_1AEA8EAACA8ADC25 = struct._id_1AEA8EAACA8ADC25;

  [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "initSpawnData")]](spawndata);
  tank = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("light_tank", spawndata, _id_EE8DA5624236DC89);

  if(!isDefined(tank))
    return undefined;

  tank thread _id_653C90DD98F5F3A3(tank, struct, spawndata);
  return tank;
}

_id_653C90DD98F5F3A3(tank, struct, spawndata) {
  tank endon("death");

  while(!istrue(tank.isactivated))
    wait 0.1;

  level.enemy_tanks[level.enemy_tanks.size] = tank;

  if(isDefined(struct._id_90DC04DAC96D07ED))
    tank thread[[struct._id_90DC04DAC96D07ED]]();

  if(isDefined(struct._id_2CE864BD06FB0385))
    tank._id_2CE864BD06FB0385 = struct._id_2CE864BD06FB0385;

  if(istrue(struct._id_F97A3D3FD021563B))
    tank._id_F97A3D3FD021563B = 1;

  tank thread tank_check_for_damage();
  tank thread tank_waittill_death(spawndata._id_297E28A8CE9F0F97);

  if(!istrue(struct._id_DD838ED8E5DC7123))
    tank thread wait_to_stop_path_vehicle();

  tank endon("death");
  tank[[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "tankActivate")]]();
  tank thread _id_BB9D1D5D92F2601B(tank, struct);

  if(isDefined(tank.headicon))
    setheadiconmaxdistance(tank.headicon, 8088);

  if(!isDefined(level.killstreak_additional_targets))
    level.killstreak_additional_targets = [];

  level.killstreak_additional_targets = scripts\engine\utility::array_add(level.killstreak_additional_targets, tank);
  tank _id_2CD0BA66A3D96194(tank, struct);
  tank thread _id_12D90C9EF9003F51(tank, struct);
}

_id_BB9D1D5D92F2601B(tank, struct) {
  tank endon("death");
  paths = scripts\engine\utility::getStructArray("enemy_tank_path", "targetname");

  if(paths.size > 1) {
    path = sortbydistance(paths, tank.origin)[0];
    tank_path = build_tank_path(path);
    duration = build_tank_duration(path, struct._id_379C00DC6E8F2235);

    if(istrue(struct._id_DD838ED8E5DC7123))
      tank startpathnodes(tank_path, duration, 1, 0.5, 0.5, 0, 1);
    else
      tank startpathnodes(tank_path, duration);
  }
}

_id_2CD0BA66A3D96194(tank, struct) {
  _id_C934CFE2BC70A47D = "iw9_tur_light_tank_mp";

  if(isDefined(struct._id_1AEA8EAACA8ADC25))
    _id_C934CFE2BC70A47D = struct._id_1AEA8EAACA8ADC25;

  _id_1F7846011C111ECD = scripts\cp_mp\vehicles\vehicle::vehicle_getturretbyweapon(tank, _id_C934CFE2BC70A47D);
  _id_1F7846011C111ECD scripts\cp_mp\emp_debuff::set_start_emp_callback(::tank_empstarted);
  _id_1F7846011C111ECD scripts\cp_mp\emp_debuff::set_clear_emp_callback(::tank_empcleared);
  gunnerturret = scripts\cp_mp\vehicles\vehicle::vehicle_getturretbyweapon(tank, "iw9_mg_light_tank_mp");
  gunnerturret scripts\cp_mp\emp_debuff::set_start_emp_callback(::tank_empstarted);
  gunnerturret scripts\cp_mp\emp_debuff::set_clear_emp_callback(::tank_empcleared);
  tank._id_1F7846011C111ECD = _id_1F7846011C111ECD;
  tank.gunnerturret = gunnerturret;
}

_id_12D90C9EF9003F51(tank, struct) {
  if(isDefined(struct._id_C38ADC61B2A4738E))
    tank thread[[struct._id_C38ADC61B2A4738E]]();
  else
    tank thread _id_65EA04CAE567A568(tank);
}

_id_65EA04CAE567A568(tank) {
  tank endon("death");

  for(;;) {
    _id_2A29B237DCC66FE5 = tank cull_list_of_players();
    player = tank scripts\cp\utility::get_closest_living_player(undefined, _id_2A29B237DCC66FE5);

    if(!isDefined(player)) {
      tank._id_1F7846011C111ECD cleartargetentity();
      tank.gunnerturret cleartargetentity();
      wait 1;
      continue;
    }

    tank_turret_get_target_and_fire(tank._id_1F7846011C111ECD, player);
    tank_turret_get_target_and_fire(tank.gunnerturret, player, 1);

    if(scripts\engine\utility::flag_exist("weapons_free") && !scripts\engine\utility::flag("weapons_free"))
      scripts\engine\utility::flag_set("weapons_free");

    level notify("weapons_free");
    wait(randomfloatrange(3, 5));
  }
}

cull_list_of_players() {
  _id_2A29B237DCC66FE5 = level.players;
  _id_5F8B983A9CC28FB2 = [];

  foreach(player in _id_2A29B237DCC66FE5) {
    if(istrue(player.ignoreme)) {
      continue;
    }
    if(istrue(self.ignoreall)) {
      continue;
    }
    if(player.team == self.team) {
      continue;
    }
    if(player_too_far(player)) {
      continue;
    }
    _id_5F8B983A9CC28FB2[_id_5F8B983A9CC28FB2.size] = player;
  }

  return _id_5F8B983A9CC28FB2;
}

player_too_far(player, _id_7C5448D7E2EAA25C, _id_87A6A6ED4A1FC719) {
  dist = 2000;

  if(isDefined(_id_7C5448D7E2EAA25C))
    dist = _id_7C5448D7E2EAA25C;

  if(istrue(self.alerted)) {
    dist = 6000;

    if(isDefined(_id_87A6A6ED4A1FC719))
      dist = _id_87A6A6ED4A1FC719;
  }

  if(scripts\engine\utility::flag_exist("weapons_free") && !scripts\engine\utility::flag("weapons_free")) {
    if(isDefined(player.perk_data["stealth_dist_scalar"]))
      dist = dist * player.perk_data["stealth_dist_scalar"];
  }

  _id_ABD9EE4725B96FC2 = dist * dist;

  if(distancesquared(self.origin, player.origin) > _id_ABD9EE4725B96FC2)
    return 1;

  return 0;
}

wait_to_stop_path_vehicle() {
  self endon("death");
  wait 5;

  for(;;) {
    wait 1;

    if(self vehicle_getspeed() < 1) {
      self stoppath(1);
      return;
    }
  }
}

tank_turret_get_target_and_fire(turret, player, _id_E02DB7B70D9B56D9) {
  turret_has_target = 0;

  if(turret scripts\cp_mp\emp_debuff::is_empd())
    turret cleartargetentity();
  else if(istrue(player.binvehicle) && isDefined(player.vehicle)) {
    if(turret turretcantarget(player.vehicle.origin + (0, 0, 50))) {
      turret settargetentity(player.vehicle, (0, 0, 50));
      turret_has_target = 1;
    }
  } else {
    turret settargetentity(player);
    turret_has_target = 1;
  }

  if(turret_has_target)
    thread tank_shoot_at_target(turret, _id_E02DB7B70D9B56D9);
}

tank_empstarted(data) {
  tank_empupdate();
}

tank_empcleared(_id_B3990D56E2779F79) {
  if(_id_B3990D56E2779F79) {
    return;
  }
  tank_empupdate();
}

tank_empupdate() {
  if(scripts\cp_mp\emp_debuff::is_empd()) {
    self turretfiredisable();
    self laseroff();
  } else
    self turretfireenable();
}

tank_shoot_at_target(turret, _id_E02DB7B70D9B56D9) {
  self endon("death");
  turret endon("death");
  _id_89F949A75D92E1A4 = 1;
  _id_5C3F9357F11D2223 = "iw9_tur_light_tank_mp";

  if(isDefined(turret.objweapon) && isDefined(turret.objweapon.basename))
    _id_5C3F9357F11D2223 = turret.objweapon.basename;

  _id_FA2483033790AF38 = makeweapon(_id_5C3F9357F11D2223);

  if(istrue(_id_E02DB7B70D9B56D9)) {
    _id_89F949A75D92E1A4 = randomintrange(15, 25);
    _id_FA2483033790AF38 = makeweapon("iw9_mg_light_tank_mp");
  }

  _id_2C90EA28723E0BF7 = weaponfiretime(_id_FA2483033790AF38);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_89F949A75D92E1A4; _id_AC0E594AC96AA3A8++) {
    turret shootturret();
    wait(_id_2C90EA28723E0BF7);
  }
}

build_tank_path(start_struct, _id_00DB850EDF9F8136) {
  self endon("death");
  path = [];

  if(isDefined(_id_00DB850EDF9F8136))
    path = _id_00DB850EDF9F8136;

  cur_node = start_struct;

  for(path[path.size] = cur_node.origin; isDefined(cur_node) && isDefined(cur_node.target); path[path.size] = cur_node.origin)
    cur_node = scripts\engine\utility::getStruct(cur_node.target, "targetname");

  return path;
}

build_tank_duration(start_struct, _id_48C97666633C1856) {
  self endon("death");
  _id_266B95080267692B = scripts\engine\utility::ter_op(isDefined(_id_48C97666633C1856), _id_48C97666633C1856, 10);
  path = [];
  cur_node = start_struct;

  for(path[path.size] = _id_266B95080267692B; isDefined(cur_node) && isDefined(cur_node.target); path[path.size] = _id_266B95080267692B)
    cur_node = scripts\engine\utility::getStruct(cur_node.target, "targetname");

  return path;
}

tank_check_for_damage() {
  damaged = 0;

  while(!damaged) {
    self waittill("alerted", data);

    if(isDefined(data.attacker.team)) {
      if(data.attacker.team != self.team)
        damaged = 1;
    }
  }

  self.alerted = 1;
}

tank_waittill_death(_id_297E28A8CE9F0F97) {
  self waittill("death");

  if(isDefined(self.headicon)) {
    deleteheadicon(self.headicon);
    self.headicon = undefined;
  }

  level.enemy_tanks = scripts\engine\utility::array_remove(level.enemy_tanks, self);
  level.killstreak_additional_targets = scripts\engine\utility::array_remove(level.killstreak_additional_targets, self);

  if(isDefined(_id_297E28A8CE9F0F97))
    level thread[[_id_297E28A8CE9F0F97]](self);
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles.gsc
***********************************************/

vehicles_init() {
  if(getdvarint("r_reflectionprobegenerate", 0) == 1) {
    return;
  }
  if(getDvar("dvar_742CAA13B3C2E685") == "1") {
    return;
  }
  level endon("game_ended");
  level thread scripts\cp_mp\vehicles\vehicle::vehicle_init();

  if(isDefined(level.vehicles_init))
    [[level.vehicles_init]]();

  if(!isDefined(level.unloading_func))
    level.unloading_func = [];

  if(!isDefined(level.unloaded_func))
    level.unloaded_func = [];

  if(!isDefined(level.vehicle_builds))
    level.vehicle_builds = [];

  setDvar("dvar_B77D72F69452A294", 1);
  level thread init_vehicle_spawning();
  _id_6FBA7DF440C493C4::init_vehicles();
  scripts\engine\utility::create_func_ref("vehicle_damage_modifier", ::cp_vehicle_damage_monitor);
  level._effect["helidown_rpghit"] = loadfx("vfx/iw8_cp/chopper/vfx_chopper_air_explosion.vfx");
  level._effect["helidown_tailfire"] = loadfx("vfx/iw8_cp/chopper/vfx_cp_fire_fire_trail.vfx");
  level._effect["helidown_groundexp"] = loadfx("vfx/iw8_cp/chopper/vfx_cp_chopper_ground_exp.vfx");
}

unset_bullet_shields() {
  if(isDefined(level.vehicle)) {
    if(isDefined(level.vehicle.templates)) {
      if(isDefined(level.vehicle.templates.bullet_shield)) {
        keys = getarraykeys(level.vehicle.templates.bullet_shield);

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < keys.size; _id_AC0E594AC96AA3A8++)
          level.vehicle.templates.bullet_shield[keys[_id_AC0E594AC96AA3A8]] = 0;
      }
    }
  }
}

create_passengers_unload_groups() {
  if(isDefined(level.vehicle)) {
    if(isDefined(level.vehicle.templates)) {
      if(isDefined(level.vehicle.templates.unloadgroups)) {
        keys = getarraykeys(level.vehicle.templates.unloadgroups);

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < keys.size; _id_AC0E594AC96AA3A8++) {
          key = keys[_id_AC0E594AC96AA3A8];
          _id_377C1A79D26E9469 = level.vehicle.templates.aianims[keys[_id_AC0E594AC96AA3A8]].size;

          if(!isDefined(level.vehicle.templates.unloadgroups[key]))
            level.vehicle.templates.unloadgroups[key] = [];

          if(isDefined(level.vehicle.templates.unloadgroups[key]["passengers"])) {
            continue;
          }
          if(_id_377C1A79D26E9469 > 1) {
            for(_id_AC0E5C4AC96AAA41 = 1; _id_AC0E5C4AC96AAA41 < _id_377C1A79D26E9469; _id_AC0E5C4AC96AAA41++) {
              if(isDefined(level.vehicle.templates.aianims[key][_id_AC0E5C4AC96AAA41])) {
                seat = level.vehicle.templates.aianims[key][_id_AC0E5C4AC96AAA41];

                if(isDefined(seat.getout)) {
                  if(!isDefined(level.vehicle.templates.unloadgroups[key]["passengers"]))
                    level.vehicle.templates.unloadgroups[key]["passengers"] = [];

                  level.vehicle.templates.unloadgroups[key]["passengers"][level.vehicle.templates.unloadgroups[key]["passengers"].size] = _id_AC0E5C4AC96AAA41;
                }
              }
            }
          }
        }
      }
    }
  }
}

set_vehicle_templates_script_team() {
  if(isDefined(level.vehicle)) {
    if(isDefined(level.vehicle.templates)) {
      if(isDefined(level.vehicle.templates.team)) {
        keys = getarraykeys(level.vehicle.templates.team);

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < keys.size; _id_AC0E594AC96AA3A8++)
          level.vehicle.templates.team[keys[_id_AC0E594AC96AA3A8]] = "axis";
      }
    }
  }
}

vehiclefollowstructpathsplines(_id_A9C45240836FE2A5, pathing_array, _id_6F3F0D19B9577E15) {
  self endon("death");
  self endon("stop_follow_path");
  self endon("reset_path");
  level endon("game_ended");

  if(pathing_array.size == 0) {
    return;
  }
  if(!isDefined(_id_A9C45240836FE2A5)) {
    return;
  }
  while(pathing_array.size < 4) {
    _id_F17000B1738727B3 = create_extra_structpath(1, pathing_array[pathing_array.size - 1].origin, pathing_array[pathing_array.size - 2].origin);
    pathing_array[pathing_array.size] = _id_F17000B1738727B3;
  }

  _id_865DE0E45FD72EDA = [];
  _id_473D8BDF00AA1996 = [];
  amount = pathing_array.size;
  currentpoint = undefined;
  _id_A414823CB904BF00 = self.origin;
  vel = 15;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < amount; _id_AC0E594AC96AA3A8++) {
    if(isDefined(pathing_array[_id_AC0E594AC96AA3A8 + 1]))
      currentpoint = pathing_array[_id_AC0E594AC96AA3A8 + 1].origin;

    if(_id_AC0E594AC96AA3A8 == 0)
      _id_865DE0E45FD72EDA[_id_865DE0E45FD72EDA.size] = self.origin;
    else
      _id_865DE0E45FD72EDA[_id_865DE0E45FD72EDA.size] = pathing_array[_id_AC0E594AC96AA3A8].origin;

    _id_5FB584989AC3658A = 300;

    if((!isDefined(self.convoy) || istrue(self.convoy.settings.use_path_speeds)) && isDefined(pathing_array[_id_AC0E594AC96AA3A8].speed))
      _id_5FB584989AC3658A = 300 * (pathing_array[_id_AC0E594AC96AA3A8].speed / 15);

    _id_D530F6290FEC0A8C = get_duration_between_points(_id_A414823CB904BF00, currentpoint, scripts\engine\utility::ter_op(isDefined(self.cp_speed), self.cp_speed, _id_5FB584989AC3658A));
    _id_473D8BDF00AA1996[_id_473D8BDF00AA1996.size] = _id_D530F6290FEC0A8C;
    _id_A414823CB904BF00 = currentpoint;
  }

  if(vehicle_on_last_pathing_array(self))
    self startpathnodes(_id_865DE0E45FD72EDA, _id_473D8BDF00AA1996);
  else
    self startpathnodes(_id_865DE0E45FD72EDA, _id_473D8BDF00AA1996, 0, 0.5, 0.5, 0, 0, 0);

  thread vehicle_process_node_when_at_goal(_id_6F3F0D19B9577E15);
  self notify("startpathnodes");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_473D8BDF00AA1996.size; _id_AC0E594AC96AA3A8++) {
    while(_id_CB612F9367051EA2(_id_AC0E594AC96AA3A8 > 0 && _id_473D8BDF00AA1996[_id_AC0E594AC96AA3A8] > 1))
      wait 0.25;

    wait(_id_473D8BDF00AA1996[_id_AC0E594AC96AA3A8]);
  }

  if(vehicle_on_last_pathing_array(self)) {
    self.on_last_pathing_array = undefined;

    if(isDefined(self.convoy) && !istrue(self.convoy.settings.roaming) || !isDefined(self.convoy))
      thread finish_spline_path();
  }

  if(istrue(self.looping_path))
    vehiclefollowstructpathsplines(self.pathing_array[0], self.pathing_array, 1);
}

vehicle_process_node_when_at_goal(_id_6F3F0D19B9577E15) {
  level endon("game_ended");
  self endon("death");
  self notify("vehicle_process_node_when_at_goal");
  self endon("vehicle_process_node_when_at_goal");
  _id_ABD9EE4725B96FC2 = 62500;
  _id_88B8D987C09FC6C6 = 1;
  nextpoint = self.pathing_array[_id_88B8D987C09FC6C6];
  _id_B7AB7579B3C791B1 = self.pathing_array[_id_88B8D987C09FC6C6];
  level.vehicle_tracker = self;

  if(istrue(_id_6F3F0D19B9577E15))
    thread process_nextpoint_after_struct_wait(nextpoint, _id_ABD9EE4725B96FC2);

  for(;;) {
    self waittill("trigger", _id_57BAF91195BE52B6, param1, param2, param3);

    if(isint(_id_57BAF91195BE52B6)) {
      if(_id_88B8D987C09FC6C6 < _id_57BAF91195BE52B6 + 1) {
        if(isDefined(self.path_gobbler))
          scripts\engine\utility::deletestruct_ref(nextpoint);

        _id_88B8D987C09FC6C6 = _id_57BAF91195BE52B6 + 1;
        nextpoint = get_next_node_on_spline(_id_88B8D987C09FC6C6);

        if(isDefined(nextpoint)) {
          _id_B7AB7579B3C791B1 = nextpoint;
          self notify("new_next_point");

          if(istrue(_id_6F3F0D19B9577E15))
            thread process_nextpoint_after_struct_wait(nextpoint, _id_ABD9EE4725B96FC2);

          continue;
        }

        break;
      }
    }
  }
}

process_nextpoint_after_struct_wait(nextpoint, _id_ABD9EE4725B96FC2) {
  self notify("process_nextPoint_after_struct_wait");
  self endon("process_nextPoint_after_struct_wait");
  self endon("death");

  while(distancesquared(self.origin, nextpoint.origin) > _id_ABD9EE4725B96FC2)
    wait 0.1;

  process_vehicle_struct_node(nextpoint);
}

process_vehicle_struct_node(nextpoint) {
  self endon("newpath");
  self endon("death");
  _id_6A4AD94DB7F006E2 = scripts\common\vehicle_paths::get_path_getfunc(nextpoint);
  _id_B7AB7579B3C791B1 = undefined;
  self.currentnode = nextpoint;
  scripts\common\vehicle_paths::trigger_process_node(nextpoint);

  if(scripts\common\vehicle_paths::vehicle_should_unload(scripts\common\vehicle_paths::node_wait, nextpoint)) {
    self vehicle_setspeedimmediate(0, 1, 1);
    struct_path_unload_node(nextpoint);
    wait 0.25;

    if(isDefined(level.vehicle._id_9442D439C225C3FE)) {
      if([[level.vehicle._id_9442D439C225C3FE]](self))
        return;
    }

    if(!isDefined(self.riders) || self.riders.size < 1) {
      self notify("vehicle_process_node_when_at_goal");
      self notify("stop_follow_path");
      return;
    }

    self resumespeed(20);
  }
}

struct_path_unload_node(node) {
  self endon("death");

  if(isDefined(self.ent_flag) && isDefined(self.ent_flag["prep_unload"]) && scripts\engine\utility::ent_flag("prep_unload")) {
    return;
  }
  if(!isDefined(node.script_flag_wait) && !isDefined(node.script_delay)) {}

  _id_29376CACC64CC4E6 = getnode(node.targetname, "target");

  if(isDefined(_id_29376CACC64CC4E6) && self.riders.size) {
    foreach(rider in self.riders) {
      if(isai(rider))
        rider thread scripts\engine\utility::script_func("go_to_node", _id_29376CACC64CC4E6);
    }
  } else if(self.riders.size) {
    foreach(rider in self.riders) {
      if(!isDefined(rider.spawnpoint)) {
        continue;
      }
      if(isDefined(rider.spawnpoint.target) || isDefined(rider.spawnpoint.script_linkto))
        rider thread _id_18A73A64992DD07D::go_to_node(rider.spawnpoint _id_18A73A64992DD07D::get_next_node_array());
    }
  }

  if(scripts\common\vehicle::ishelicopter()) {
    self sethoverparams(0, 0, 0);
    scripts\common\vehicle_code::waittill_stable(node);
  }

  if(isDefined(node.script_noteworthy)) {
    if(node.script_noteworthy == "wait_for_flag")
      scripts\engine\utility::flag_wait(node.script_flag);
  }

  if(isDefined(node.script_unload)) {
    if(node.script_unload == "1")
      node.script_unload = "default";
  }

  scripts\common\vehicle_code::_vehicle_unload(node.script_unload);

  if(scripts\common\vehicle_aianim::riders_unloadable(node.script_unload))
    self waittill("unloaded");

  if(isDefined(node.script_flag_wait) || isDefined(node.script_delay))
    return;
}

get_next_node_on_spline(_id_88B8D987C09FC6C6) {
  if(!isDefined(_id_88B8D987C09FC6C6))
    return undefined;
  else if(!isDefined(self.pathing_array))
    return undefined;
  else if(isDefined(self.pathing_array[_id_88B8D987C09FC6C6]))
    return self.pathing_array[_id_88B8D987C09FC6C6];
  else
    return undefined;
}

_id_CB612F9367051EA2(_id_D5A516E7FA6744D0) {
  return self issuspendedvehicle() || _id_D5A516E7FA6744D0 && self vehicle_getspeed() < 1;
}

vehicle_on_last_pathing_array(vehicle) {
  if(istrue(vehicle.looping_path))
    return 0;

  if(isDefined(vehicle.pathing_arrays)) {
    if(istrue(vehicle.on_last_pathing_array))
      return 1;
    else
      return 0;
  }

  return 1;
}

create_extra_structpath(_id_3EBDD87863997706, _id_1714BC755A5D3E09, _id_6FC8C07BF9FB910D) {
  if(!isDefined(_id_6FC8C07BF9FB910D))
    _id_6FC8C07BF9FB910D = (_id_1714BC755A5D3E09 - self.origin) / 2;

  _id_E8576D498B34741B = _id_1714BC755A5D3E09;
  _id_E0A5FD5C9513B506 = _id_6FC8C07BF9FB910D;
  _id_8B573603A20A768F = (_id_E0A5FD5C9513B506 + _id_E8576D498B34741B) / 2;
  _id_0A20AA2636CCBFA4 = _id_8B573603A20A768F - _id_E0A5FD5C9513B506;
  _id_F17000B1738727B3 = spawnStruct();
  _id_F17000B1738727B3.origin = _id_E8576D498B34741B + _id_0A20AA2636CCBFA4;
  return _id_F17000B1738727B3;
}

vehiclefollowstructpath(_id_A9C45240836FE2A5, _id_6F3F0D19B9577E15) {
  self endon("death");
  self endon("stop_follow_path");
  self endon("reset_path");
  level endon("game_ended");
  self.on_last_pathing_array = undefined;
  _id_E32861B33E4343FD = undefined;

  if(isDefined(self.pathing_arrays) && self.pathing_arrays.size > 0) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.pathing_arrays.size; _id_AC0E594AC96AA3A8++) {
      if(!isDefined(self.pathing_arrays) || self.pathing_arrays.size == 0) {
        return;
      }
      if(_id_AC0E594AC96AA3A8 == self.pathing_arrays.size - 1)
        self.on_last_pathing_array = 1;

      vehiclefollowstructpathsplines(_id_A9C45240836FE2A5, self.pathing_arrays[_id_AC0E594AC96AA3A8], _id_6F3F0D19B9577E15);
    }
  } else if(isDefined(self.pathing_array) && self.pathing_array.size > 0) {
    self.on_last_pathing_array = 1;
    vehiclefollowstructpathsplines(_id_A9C45240836FE2A5, self.pathing_array, _id_6F3F0D19B9577E15);
  }
}

finish_spline_path() {
  self endon("death");

  if(isDefined(self.convoy)) {
    if(!isDefined(self.convoy.settings) || istrue(self.convoy.settings.unload_at_target)) {
      if(isDefined(level.vehicle_all_stop_func))
        self[[level.vehicle_all_stop_func]](0);

      self notify("unload_guys");
    }

    if(isDefined(self.convoy.settings) && isDefined(self.convoy.settings.target))
      self notify("unload_guys");
  }

  self stoppath(1);
  self notify("stop_follow_path");
  _id_2E495148B31B2470 = self.pathing_array[self.pathing_array.size - 1];

  if(isDefined(_id_2E495148B31B2470)) {
    struct_path_unload_node(_id_2E495148B31B2470);
    wait 0.25;

    if(isDefined(level.vehicle._id_9442D439C225C3FE)) {
      if([[level.vehicle._id_9442D439C225C3FE]](self))
        return;
    }
  }
}

cp_vehicle_damage_monitor(damage_data) {
  idamage = undefined;

  if(isDefined(damage_data)) {
    if(isDefined(damage_data.damage))
      idamage = damage_data.damage;

    if(isDefined(damage_data.attacker) && isPlayer(damage_data.attacker) && isDefined(idamage)) {
      if(isDefined(damage_data.attacker.team) && isDefined(self.team) && damage_data.attacker.team != self.team) {
        if(isDefined(damage_data.objweapon) && isDefined(damage_data.objweapon.basename)) {
          if(damage_data.objweapon.basename == "emp_drone_player_mp")
            idamage = 10000;
        }
      }

      if(isDefined(damage_data.objweapon) && isDefined(damage_data.objweapon.basename)) {
        switch (damage_data.objweapon.basename) {
          case "toma_proj_mp":
          case "cruise_proj_mp":
            if(isDefined(self.healthbuffer))
              self.health = self.healthbuffer - 100;
            else
              self.health = 0;

            break;
        }

        if(isDefined(damage_data.meansofdeath))
          idamage = _id_25845ACA699D038D::handleapdamage(damage_data.objweapon, damage_data.meansofdeath, idamage, damage_data.attacker);
      }

      if(isDefined(self._id_F6A794B2D3DC63E7))
        idamage = self[[self._id_F6A794B2D3DC63E7]](damage_data);

      if(isDefined(self.damage_multiplier))
        idamage = idamage * self.damage_multiplier;

      if(istrue(damage_data.attacker.damage_from_above)) {
        _id_EDF11EA9C8ACA047 = damage_data.attacker.origin[2];
        _id_49A5CF44A8A698E8 = self.origin[2];

        if(_id_EDF11EA9C8ACA047 >= _id_49A5CF44A8A698E8) {
          _id_2A83DF6C49112D96 = int(abs(_id_EDF11EA9C8ACA047 - _id_49A5CF44A8A698E8));
          _id_E88CE06AEE61DE95 = int(_id_2A83DF6C49112D96 / 64);

          if(_id_E88CE06AEE61DE95 > 0)
            idamage = idamage * (1 + 0.4 * _id_E88CE06AEE61DE95);
        }
      }

      if(damage_data.meansofdeath == "MOD_GRENADE_SPLASH" || damage_data.meansofdeath == "MOD_PROJECTILE_SPLASH" || damage_data.meansofdeath == "MOD_PROJECTILE" || damage_data.meansofdeath == "MOD_GRENADE")
        idamage = _id_869E06B0541DEF6D(idamage);

      damage_data.attacker _id_354C862768CFE202::updatehitmarker("standard", 1, idamage, 0, 0);
      _id_916912DFCF4BCBB4 = self.health - idamage;
      self.health = int(max(_id_916912DFCF4BCBB4, self.healthbuffer - 1));
    }
  }

  return idamage;
}

_id_869E06B0541DEF6D(amount) {
  return int(amount * 5);
}

init_vehicle_spawning() {
  level.ai_spawn_vehicle_func = [];
  level.next_index = 0;
  level.all_ai_vehicle_infils = [];
  level.available_ai_vehicle_air_infils = [];
  level.available_ai_vehicle_ground_infils = [];
  level.path_points = [];
  level.invalid_path_points = [];
  level.heli_triggers = [];
  level.vehicle_ai_script_models = [];
  create_vehicle_builds();
  vehicle_registrations();
  level thread init_vehicles_after_flags();
  add_ai_ground_infil("pindia");
  add_ai_ground_infil("technical_ai_plr");
  add_ai_air_infil("attack_heli");
  register_vehicle_spawn("attack_heli", undefined, undefined, undefined, "heli_spawner", undefined, "heli_infil_path", undefined, ::spawn_enemy_chopper, "apache");
  register_vehicle_spawn("techo_non_phys", 10, 10, 10, "ai_ground_veh_spawner", "ground_veh_exit", "ground_veh_infil_path", undefined, ::veh_ground_veh_spawn, "techo_non_phys");
  register_vehicle_spawn("techo", 10, 10, 10, "ai_ground_veh_spawner", "ground_veh_exit", "ground_veh_infil_path", undefined, ::veh_ground_veh_spawn, "techo");
  register_vehicle_spawn("technical_ai_plr", 10, 10, 10, "ai_ground_veh_spawner", "ground_veh_exit", "ground_veh_infil_path", undefined, ::veh_ground_veh_spawn, "technical_ai_plr");
  register_vehicle_spawn("veh8_mil_lnd_mkilo23", 1, 2, 30, "ai_ground_veh_spawner", "ground_veh_exit", "ground_veh_infil_path", undefined, ::veh_ground_veh_spawn, "veh8_mil_lnd_mkilo23");
  register_vehicle_spawn("veh8_mil_lnd_mkilo23_rus", 1, 2, 30, "ai_ground_veh_spawner", "ground_veh_exit", "ground_veh_infil_path", undefined, ::veh_ground_veh_spawn, "veh8_mil_lnd_mkilo23_rus");
  register_vehicle_spawn("mkilo23_physics", 4, 10, 10, "ai_ground_veh_spawner", "ground_veh_exit", "ground_veh_infil_path", undefined, ::veh_ground_veh_spawn, "mkilo23_physics");
  register_vehicle_spawn_drivers("blima_ground", 2, scripts\engine\utility::random(["aq_pilot_fullbody_1", "aq_pilot_fullbody_2"]));
  register_vehicle_spawn_drivers("techo", 2, scripts\engine\utility::random(["aq_pilot_fullbody_1", "aq_pilot_fullbody_2"]));
  register_vehicle_spawn_drivers("veh8_mil_lnd_mkilo23", 2, scripts\engine\utility::random(["aq_pilot_fullbody_1", "aq_pilot_fullbody_2"]));
  register_vehicle_spawn_drivers("veh8_mil_lnd_mkilo23_rus", 2, scripts\engine\utility::random(["aq_pilot_fullbody_1", "aq_pilot_fullbody_2"]));
  register_vehicle_spawn_drivers("mkilo23_physics", 2, scripts\engine\utility::random(["aq_pilot_fullbody_1", "aq_pilot_fullbody_2"]));
}

init_vehicles_after_flags() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  unset_bullet_shields();
  create_passengers_unload_groups();
  set_vehicle_templates_script_team();
  level.ground_vehicle_structs = scripts\engine\utility::getStructArray("ground_veh_infil_path", "targetname");

  if(isDefined(level.vehicle.helicopter_crash_locations)) {
    level.vehicle.helicopter_crash_locations = scripts\engine\utility::array_combine(level.vehicle.helicopter_crash_locations, scripts\engine\utility::getstructarray_delete("helicopter_crash_location", "targetname"));
    level.vehicle.helicopter_crash_locations = scripts\engine\utility::array_combine(level.vehicle.helicopter_crash_locations, scripts\engine\utility::getStructArray("heli_exit", "targetname"));
  } else
    level.vehicle.helicopter_crash_locations = scripts\engine\utility::getStructArray("heli_exit", "targetname");
}

vehicle_ai_spawn_funcs() {
  register_spawner_script_function("pindia", ::ai_ground_veh_spawn, undefined);
  register_spawner_script_function("techo_non_phys", ::ai_ground_veh_spawn, undefined);
  register_spawner_script_function("technical_ai_plr", ::ai_ground_veh_spawn, undefined);
  register_spawner_script_function("techo", ::ai_ground_veh_spawn, undefined);
  register_spawner_script_function("veh8_mil_lnd_umike", ::ai_ground_veh_spawn, undefined);
  register_spawner_script_function("veh8_mil_lnd_mkilo23", ::ai_ground_veh_spawn, undefined);
  register_spawner_script_function("veh8_mil_lnd_mkilo23_rus", ::ai_ground_veh_spawn, undefined);
  register_spawner_script_function("mkilo23_physics", ::ai_ground_veh_spawn, undefined);
}

register_spawner_script_function(_id_4E90A313EA35F4B7, func, specs, _id_064D1449EC4E9520) {
  if(istrue(_id_064D1449EC4E9520))
    level waittill(_id_4E90A313EA35F4B7);

  if(isDefined(level.spawner_script_funcs[_id_4E90A313EA35F4B7]))
    struct = level.spawner_script_funcs[_id_4E90A313EA35F4B7];
  else
    struct = spawnStruct();

  struct.script_function = func;
  struct.specs = specs;
  level.spawner_script_funcs[_id_4E90A313EA35F4B7] = struct;
}

create_ai_plr_vehicle(veh_spawn_point, _id_3D22F278EFD315CC) {
  copy_vehicle_build_to_spawnpoint(_id_3D22F278EFD315CC, veh_spawn_point);
  vehicle = scripts\common\vehicle::vehicle_spawn(veh_spawn_point);
  vehicle.cannotbesuspended = 1;

  if(isDefined(veh_spawn_point.vehiclename)) {
    vehicle.vehiclename = veh_spawn_point.vehiclename;
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(vehicle, "axis");
    vehicle makeunusable();
    vehicle setCanDamage(1);
    vehicle.maxhealth = 999999;
    vehicle.health = vehicle.maxhealth;
    vehicle scripts\cp_mp\emp_debuff::set_start_emp_callback(scripts\cp_mp\vehicles\vehicle::vehicle_empstartcallback);
    vehicle scripts\cp_mp\emp_debuff::set_clear_emp_callback(scripts\cp_mp\vehicles\vehicle::vehicle_empclearcallback);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_registerinstance(vehicle);
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_registerinstance(vehicle);
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(vehicle);
    scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(vehicle, undefined, undefined);
    scripts\cp_mp\vehicles\vehicle_dlog::vehicle_dlog_spawnevent(vehicle, undefined);
    _id_E9AD534890B3B83E = scripts\cp_mp\utility\weapon_utility::setlockedoncallback;
    [[_id_E9AD534890B3B83E]](vehicle, scripts\cp_mp\vehicles\vehicle::vehicle_lockedoncallback);
    _id_0CFDE26882EFC85E = scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback;
    [[_id_0CFDE26882EFC85E]](vehicle, scripts\cp_mp\vehicles\vehicle::vehicle_lockedonremovedcallback);
    vehicle thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped();
  }

  return vehicle;
}

register_vehicle_build(_id_3D22F278EFD315CC, model, type, classname, _id_35C134FE54C9A072) {
  struct = spawnStruct();
  struct.model = model;
  struct.vehicletype = type;
  struct.classname_mp = classname;
  level.vehicle_builds[_id_3D22F278EFD315CC] = struct;
}

register_vehicle_as_ambient(_id_3D22F278EFD315CC, _id_064D1449EC4E9520) {
  if(istrue(_id_064D1449EC4E9520))
    level waittill(_id_3D22F278EFD315CC);

  struct = level.vehicle_builds[_id_3D22F278EFD315CC];

  if(isDefined(struct)) {
    struct.is_ambient = 1;
    struct.allow_deleteme_path = 1;
  }
}

vehicle_is_ambient(_id_3D22F278EFD315CC) {
  return istrue(level.vehicle_builds[_id_3D22F278EFD315CC].is_ambient);
}

create_ambient_vehicle(_id_3D22F278EFD315CC, model, type, classname) {
  level thread register_vehicle_max_ai(_id_3D22F278EFD315CC, model, type, classname, undefined, 1, 1);
  level thread register_vehicle_as_ambient(_id_3D22F278EFD315CC, 1);
  level thread register_vehicle_spawn_drivers(_id_3D22F278EFD315CC, 1, scripts\engine\utility::random(["aq_pilot_fullbody_1", "aq_pilot_fullbody_2"]));
  level thread register_vehicle_spawn_override(_id_3D22F278EFD315CC, undefined, undefined, undefined, undefined, undefined, undefined, 1, undefined, undefined);
}

register_vehicle_max_ai(_id_3D22F278EFD315CC, model, type, classname, _id_35C134FE54C9A072, override, _id_064D1449EC4E9520) {
  if(istrue(_id_064D1449EC4E9520))
    level waittill(_id_3D22F278EFD315CC);

  if(isDefined(level.vehicle)) {
    if(isDefined(level.vehicle.templates)) {
      if(isDefined(level.vehicle.templates.aianims)) {
        if(isDefined(level.vehicle.templates.aianims[classname])) {
          if(isDefined(level.ai_spawn_vehicle_func[_id_3D22F278EFD315CC]) && isDefined(level.ai_spawn_vehicle_func[_id_3D22F278EFD315CC].max_ai)) {
            if(isDefined(override))
              level.vehicle_builds[_id_3D22F278EFD315CC].max_ai = override;
            else
              level.vehicle_builds[_id_3D22F278EFD315CC].max_ai = level.ai_spawn_vehicle_func[_id_3D22F278EFD315CC].max_ai;
          } else if(isDefined(override))
            level.vehicle_builds[_id_3D22F278EFD315CC].max_ai = override;
          else {
            _id_339E16780E986B27 = level.vehicle.templates.aianims[classname];
            level.vehicle_builds[_id_3D22F278EFD315CC].max_ai = _id_339E16780E986B27.size;
          }
        }
      }
    }
  }
}

get_max_ai_from_infil_name(_id_F8E5E3AA5762A8E7, _id_3D22F278EFD315CC) {
  if(isDefined(level.vehicle_builds) && isDefined(level.vehicle_builds[_id_3D22F278EFD315CC]) && isDefined(level.vehicle_builds[_id_3D22F278EFD315CC].max_ai)) {
    _id_21D08B20AE007765 = get_invalid_seats_from_module_struct(_id_F8E5E3AA5762A8E7, _id_3D22F278EFD315CC);

    if(isDefined(_id_21D08B20AE007765)) {
      count = 0;

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.usedpositions.size; _id_AC0E594AC96AA3A8++) {
        _id_DFCE408C92A4BBDD = 1;

        for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_21D08B20AE007765.size; _id_AC0E5C4AC96AAA41++) {
          if(_id_21D08B20AE007765[_id_AC0E5C4AC96AAA41] == _id_AC0E594AC96AA3A8) {
            _id_DFCE408C92A4BBDD = 0;
            break;
          }
        }

        if(_id_DFCE408C92A4BBDD)
          count++;
      }

      return int(min(count, level.vehicle_builds[_id_3D22F278EFD315CC].max_ai));
      return;
    }

    return level.vehicle_builds[_id_3D22F278EFD315CC].max_ai;
    return;
  } else
    return undefined;
}

get_random_available_air_ai_infil() {
  return scripts\engine\utility::random(level.available_ai_vehicle_air_infils);
}

get_random_available_ground_ai_infil() {
  return scripts\engine\utility::random(level.available_ai_vehicle_ground_infils);
}

attempt_ai_ground_infil_cooldown(infil_name) {
  if(level.ai_spawn_vehicle_func[infil_name].max_num <= level.ai_spawn_vehicle_func[infil_name].count)
    level thread remove_ai_ground_infil_for_time(infil_name);
}

attempt_ai_air_infil_cooldown(infil_name) {
  if(level.ai_spawn_vehicle_func[infil_name].max_num <= level.ai_spawn_vehicle_func[infil_name].count)
    level thread remove_ai_air_infil_for_time(infil_name);
}

remove_ai_ground_infil_for_time(infil_name) {
  level.available_ai_vehicle_ground_infils = scripts\engine\utility::array_remove(level.available_ai_vehicle_ground_infils, infil_name);

  if(isDefined(level.ai_spawn_vehicle_func[infil_name].cooldown))
    scripts\engine\utility::delaythread(level.ai_spawn_vehicle_func[infil_name].cooldown, ::add_ai_ground_infil, infil_name);
}

remove_ai_air_infil_for_time(infil_name) {
  level.available_ai_vehicle_air_infils = scripts\engine\utility::array_remove(level.available_ai_vehicle_air_infils, infil_name);

  if(isDefined(level.ai_spawn_vehicle_func[infil_name].cooldown))
    scripts\engine\utility::delaythread(level.ai_spawn_vehicle_func[infil_name].cooldown, ::add_ai_air_infil, infil_name);
}

add_ai_air_infil(infil_name) {
  level.available_ai_vehicle_air_infils[infil_name] = infil_name;
}

add_ai_ground_infil(infil_name) {
  level.available_ai_vehicle_ground_infils[infil_name] = infil_name;
}

register_vehicle_spawn_override(spawn_type, max_num, cooldown, max_wait_for_infil, spawn_points, exit_points, path_start_points, max_ai, vehicle_spawn_func, vehicle_build) {
  level waittill(spawn_type);

  if(isDefined(level.ai_spawn_vehicle_func[spawn_type])) {
    scripts\engine\utility::flag_wait("level_ready_for_script");
    struct = level.ai_spawn_vehicle_func[spawn_type];

    if(isDefined(spawn_type))
      struct.spawn_type = spawn_type;

    if(isDefined(max_num))
      struct.max_num = max_num;

    if(isDefined(cooldown))
      struct.cooldown = cooldown;

    if(isDefined(max_wait_for_infil))
      struct.max_wait_for_infil = max_wait_for_infil;

    if(isDefined(spawn_points))
      struct.spawn_points = spawn_points;

    if(isDefined(exit_points))
      struct.exit_points = exit_points;

    if(isDefined(path_start_points))
      struct.path_start_points = path_start_points;

    if(isDefined(vehicle_spawn_func))
      struct.vehicle_spawn_func = vehicle_spawn_func;

    if(isDefined(vehicle_build))
      struct.vehicle_build = vehicle_build;

    level.ai_spawn_vehicle_func[spawn_type] = struct;

    if(isDefined(path_start_points))
      level thread get_path_points(spawn_type, path_start_points);
  }

  if(isDefined(max_ai)) {
    if(isDefined(level.vehicle_builds[spawn_type]) && isDefined(level.vehicle_builds[spawn_type].max_ai))
      level.vehicle_builds[spawn_type].max_ai = max_ai;
  }
}

register_vehicle_spawn(spawn_type, max_num, cooldown, max_wait_for_infil, spawn_points, exit_points, path_start_points, max_ai, vehicle_spawn_func, vehicle_build) {
  level.all_ai_vehicle_infils[level.all_ai_vehicle_infils.size] = spawn_type;
  struct = spawnStruct();
  struct.spawn_type = spawn_type;
  struct.max_num = max_num;
  struct.cooldown = cooldown;
  struct.max_wait_for_infil = max_wait_for_infil;
  struct.spawn_points = spawn_points;
  struct.exit_points = exit_points;
  struct.path_start_points = path_start_points;
  struct.vehicle_spawn_func = vehicle_spawn_func;
  struct.count = 0;
  struct.max_ai = max_ai;
  struct.vehicle_build = vehicle_build;
  struct.cpvehiclename = spawn_type;
  level.ai_spawn_vehicle_func[spawn_type] = struct;

  if(isDefined(path_start_points))
    level thread get_path_points(spawn_type, path_start_points);
}

get_path_points(spawn_type, path_start_points) {
  level endon("game_ended");
  level.path_points[spawn_type] = scripts\engine\utility::getStructArray(path_start_points, "targetname");
}

register_vehicle_spawn_drivers(spawn_type, num_script_models, driver_models, _id_064D1449EC4E9520) {
  if(istrue(_id_064D1449EC4E9520))
    level waittill(spawn_type);

  if(isDefined(level.ai_spawn_vehicle_func[spawn_type])) {
    struct = level.ai_spawn_vehicle_func[spawn_type];
    struct.num_script_models = num_script_models;
    struct.driver_models = driver_models;
    level.ai_spawn_vehicle_func[spawn_type] = struct;
  }
}

choose_random_ground_vehicle_spawn(group, spawn_point, param3) {
  if(isDefined(spawn_point.ai_infil_type))
    _id_6CF71AA4DE010F27 = spawn_point.ai_infil_type;
  else
    _id_6CF71AA4DE010F27 = get_random_available_ground_ai_infil();

  if(isDefined(_id_6CF71AA4DE010F27)) {
    spawn_point.og_script_function = spawn_point.script_function;
    spawn_point.script_function = _id_6CF71AA4DE010F27;

    if(!isDefined(spawn_point.vehicle) && isDefined(level.ai_spawn_vehicle_func[_id_6CF71AA4DE010F27].vehicle_spawn_func)) {
      if([[level.ai_spawn_vehicle_func[_id_6CF71AA4DE010F27].vehicle_spawn_func]](group, spawn_point, _id_6CF71AA4DE010F27))
        return 1;
      else
        return 0;
    } else if(isDefined(spawn_point.vehicle))
      return 1;
    else
      return 0;

    self thread[[level.spawner_script_funcs[_id_6CF71AA4DE010F27].script_function]](group, spawn_point, _id_6CF71AA4DE010F27);
    thread attempt_ai_ground_infil_cooldown(_id_6CF71AA4DE010F27);
  } else
    return 0;
}

decrement_wave_veh_count(_id_6CF71AA4DE010F27) {
  if(isDefined(self.valid_vehicles) && isDefined(self.valid_vehicles[_id_6CF71AA4DE010F27])) {
    self.valid_vehicles[_id_6CF71AA4DE010F27]--;

    if(self.valid_vehicles[_id_6CF71AA4DE010F27] < 1)
      self.valid_vehicles[_id_6CF71AA4DE010F27] = undefined;
  }
}

choose_escalation_air_vehicle_spawn(group, spawn_point, param3) {
  _id_6CF71AA4DE010F27 = undefined;
  _id_A980F9185C6C9DF8 = group scripts\cp\cp_wave_spawning::get_current_wave_ref();

  if(isDefined(_id_A980F9185C6C9DF8)) {
    _id_F7A6739C47BA2EE1 = group _id_18A73A64992DD07D::get_allowed_vehicle_types_from_wave();

    if(istrue(group.use_only_veh_spawners) && (!isDefined(_id_F7A6739C47BA2EE1) || _id_F7A6739C47BA2EE1.size < 1))
      return 0;

    _id_F7A6739C47BA2EE1 = spawn_point _id_18A73A64992DD07D::get_allowed_vehicle_types_from_spawnpoint(_id_F7A6739C47BA2EE1);

    if(isDefined(_id_F7A6739C47BA2EE1) && _id_F7A6739C47BA2EE1.size > 0) {
      _id_6CF71AA4DE010F27 = scripts\engine\utility::random(_id_F7A6739C47BA2EE1);

      if(_id_18A73A64992DD07D::has_vehicle_type_exceeded_module_cap(group, _id_6CF71AA4DE010F27))
        return 0;
    }
  } else if(isDefined(group.valid_vehicles) && scripts\engine\utility::array_sum(group.valid_vehicles) > 0) {
    _id_F7A6739C47BA2EE1 = group _id_18A73A64992DD07D::get_allowed_vehicle_types_from_wave();
    _id_F7A6739C47BA2EE1 = spawn_point _id_18A73A64992DD07D::get_allowed_vehicle_types_from_spawnpoint(_id_F7A6739C47BA2EE1);

    if(isDefined(_id_F7A6739C47BA2EE1) && _id_F7A6739C47BA2EE1.size > 0) {
      _id_6CF71AA4DE010F27 = scripts\engine\utility::random(_id_F7A6739C47BA2EE1);

      if(_id_18A73A64992DD07D::has_vehicle_type_exceeded_module_cap(group, _id_6CF71AA4DE010F27))
        return 0;
    }
  } else
    _id_6CF71AA4DE010F27 = get_random_available_air_ai_infil();

  if(isDefined(_id_6CF71AA4DE010F27)) {
    if(_id_18A73A64992DD07D::has_vehicle_type_exceeded_module_cap(group, _id_6CF71AA4DE010F27))
      return 0;

    spawn_point.og_script_function = spawn_point.script_function;
    spawn_point.script_function = _id_6CF71AA4DE010F27;

    if(!isDefined(spawn_point.vehicle) && isDefined(level.ai_spawn_vehicle_func[_id_6CF71AA4DE010F27].vehicle_spawn_func)) {
      if([[level.ai_spawn_vehicle_func[_id_6CF71AA4DE010F27].vehicle_spawn_func]](group, spawn_point, _id_6CF71AA4DE010F27))
        return 1;
      else
        return 0;
    } else if(isDefined(spawn_point.vehicle))
      return 1;
    else
      return 0;

    self thread[[level.spawner_script_funcs[_id_6CF71AA4DE010F27].script_function]](group, spawn_point, _id_6CF71AA4DE010F27);
  } else
    return 0;
}

choose_random_air_vehicle_spawn(group, spawn_point, param3) {
  if(isDefined(spawn_point.ai_infil_type))
    _id_6CF71AA4DE010F27 = spawn_point.ai_infil_type;
  else
    _id_6CF71AA4DE010F27 = get_random_available_air_ai_infil();

  if(isDefined(_id_6CF71AA4DE010F27)) {
    spawn_point.og_script_function = spawn_point.script_function;
    spawn_point.script_function = _id_6CF71AA4DE010F27;

    if(!isDefined(spawn_point.vehicle) && isDefined(level.ai_spawn_vehicle_func[_id_6CF71AA4DE010F27].vehicle_spawn_func)) {
      if([[level.ai_spawn_vehicle_func[_id_6CF71AA4DE010F27].vehicle_spawn_func]](group, spawn_point, _id_6CF71AA4DE010F27))
        return 1;
      else
        return 0;
    } else if(isDefined(spawn_point.vehicle))
      return 1;
    else
      return 0;

    self thread[[level.spawner_script_funcs[_id_6CF71AA4DE010F27].script_function]](group, spawn_point, _id_6CF71AA4DE010F27);
    thread attempt_ai_air_infil_cooldown(_id_6CF71AA4DE010F27);
  } else
    return 0;
}

ai_ground_veh_spawn(_id_F8E5E3AA5762A8E7, spawn_point, infil_name) {
  if(isDefined(spawn_point.vehicle)) {
    self.vehicle = spawn_point.vehicle;
    self.vehicle thread scripts\engine\utility::thread_on_notify("unloaded", ::clear_kill_off_flags, self, undefined, self, self, "death");
    thread delay_enter_vehicle(_id_F8E5E3AA5762A8E7, spawn_point, spawn_point.vehicle, infil_name);
    spawn_point.vehicle thread allow_infil_after_full_or_timeout(_id_F8E5E3AA5762A8E7, infil_name);
  }
}

_id_64F6B6424352BC68(group, spawn_point, infil_name) {
  if(!isDefined(spawn_point.vehicle) && isDefined(level.ai_spawn_vehicle_func[infil_name].vehicle_spawn_func)) {
    if([[level.ai_spawn_vehicle_func[infil_name].vehicle_spawn_func]](group, spawn_point, infil_name))
      thread ai_enter_vehicle(group, spawn_point, infil_name);
  } else
    thread ai_enter_vehicle(group, spawn_point, infil_name);
}

ai_enter_vehicle(_id_F8E5E3AA5762A8E7, spawn_point, infil_name) {
  if(isDefined(spawn_point.vehicle)) {
    thread clear_kill_off_flags_after_unload(spawn_point.vehicle);
    thread delay_enter_vehicle(_id_F8E5E3AA5762A8E7, spawn_point, spawn_point.vehicle, infil_name);
    spawn_point.vehicle thread allow_infil_after_full_or_timeout(_id_F8E5E3AA5762A8E7, infil_name);

    if(isDefined(spawn_point.script_demeanor))
      _id_18A73A64992DD07D::set_demeanor_from_unittype(spawn_point.script_demeanor);
  }
}

clear_kill_off_flags_after_unload(vehicle) {
  self endon("death");
  clear_kill_off_flags_after_unload_wait(vehicle);
  thread clear_kill_off_flags(self);
}

clear_kill_off_flags_after_unload_wait(vehicle) {
  self endon("unload");
  self endon("death");
  vehicle endon("death");
  self waittill("forever");
}

delay_enter_vehicle(_id_F8E5E3AA5762A8E7, spawn_point, vehicle, infil_name) {
  if(isDefined(self.spawnpoint.pos_override_struct) && self.spawnpoint.pos_override_struct != vehicle)
    vehicle thread add_to_vehicle_queue(self);
  else {
    scripts\engine\utility::thread_on_notify("loaded", ::disable_canshootinvehicle);
    self hide();

    if(isDefined(spawn_point.script_demeanor))
      _id_18A73A64992DD07D::set_demeanor_from_unittype(spawn_point.script_demeanor);

    _id_09C2EA6E4AA0DCDC = vehicle get_valid_seats(_id_F8E5E3AA5762A8E7, infil_name);

    if(!isDefined(self.forced_startingposition) && isDefined(_id_09C2EA6E4AA0DCDC) && int(_id_09C2EA6E4AA0DCDC) >= 0)
      self.forced_startingposition = _id_09C2EA6E4AA0DCDC;

    self dontinterpolate();
    vehicle thread scripts\common\vehicle_aianim::guy_enter(self);
  }
}

disable_canshootinvehicle() {
  self show();

  if(istrue(level.vehicle_ai_can_shoot_after_reload)) {
    return;
  }
  self.canshootinvehicle = 0;
}

add_to_vehicle_queue(ai) {
  self notify("add_to_vehicle_queue");
  self.load_queue[self.load_queue.size] = ai;
  ai scripts\engine\utility::thread_on_notify_no_endon_death("death", ::remove_from_vehicle_queue, self);
}

remove_from_vehicle_queue(vehicle) {
  if(isDefined(vehicle) && isDefined(vehicle.load_queue) && vehicle.load_queue.size > 0) {
    if(scripts\engine\utility::array_contains(vehicle.load_queue, self))
      vehicle.load_queue = scripts\engine\utility::array_remove(vehicle.load_queue, self);
  }
}

veh_ground_veh_spawn(group, spawn_point, infil_name) {
  _id_A0B5803DA717965F = level.ai_spawn_vehicle_func[infil_name];
  _id_1317C822798F0C26 = _id_A0B5803DA717965F get_vehicle_spawn_points(spawn_point);

  if(_id_1317C822798F0C26.size > 0) {
    foreach(veh_spawn_point in _id_1317C822798F0C26) {
      if(istrue(veh_spawn_point.in_use)) {
        continue;
      }
      vehicle = create_ai_plr_vehicle(veh_spawn_point, infil_name);

      if(isDefined(vehicle)) {
        vehicle init_cp_vehicle(spawn_point, group, veh_spawn_point, infil_name);
        vehicle thread veh_ping_vehicle_location_to_players();
        vehicle thread waittill_full_or_timeout(infil_name, group);
        vehicle post_spawn_vehicle_init(group, spawn_point, infil_name, veh_spawn_point);
        vehicle thread init_ground_vehicle(group, infil_name);

        if(vehicle_is_ambient(infil_name) || getdvarint("dvar_9BA0D5F78C98373E", 0))
          vehicle thread spawn_script_model_driver_and_passengers(vehicle, infil_name);

        clear_vehicle_build_to_spawnpoint(veh_spawn_point);
        return 1;
      } else {
        clear_vehicle_build_to_spawnpoint(veh_spawn_point);
        return 0;
      }
    }

    return 0;
  } else
    return 0;
}

veh_ping_vehicle_location_to_players() {
  self endon("death");
  self endon("unloading");

  for(;;) {
    pinglocationenemyteams(self.origin, "axis");
    wait 2;
  }
}

post_spawn_vehicle_init(group, spawn_point, infil_name, veh_spawn_point) {
  level.ai_spawn_vehicle_func[infil_name].count++;
  self.load_queue = [];
  self.group = group;
  self.vehicle_skipdeathmodel = 1;
  self.veh_spawn_point = veh_spawn_point;
  spawn_point.ai_infil_type = infil_name;
  veh_spawn_point.in_use = 1;
  spawn_point.specs = level.spawner_script_funcs[infil_name].specs;
  spawn_point.vehicle = self;
  self.spawn_point = spawn_point;
}

spawn_script_model_driver_and_passengers(vehicle, infil_name) {
  _id_01D276CC8B7A4655 = level.ai_spawn_vehicle_func[infil_name];

  if(isDefined(_id_01D276CC8B7A4655) && isDefined(_id_01D276CC8B7A4655.num_script_models)) {
    _id_166C0F7056EDB681 = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_01D276CC8B7A4655.num_script_models; _id_AC0E594AC96AA3A8++) {
      struct = level.vehicle.templates.aianims[vehicle.classname_mp][_id_AC0E594AC96AA3A8];
      tag = struct.sittag;
      _id_514D9E806D48B808 = vehicle scripts\cp\vehicles\vehicle_cp::spawn_script_model_at_pos(_id_AC0E594AC96AA3A8, tag, struct.idle_anim, struct.idle, _id_01D276CC8B7A4655.driver_models);
      _id_166C0F7056EDB681[_id_166C0F7056EDB681.size] = _id_514D9E806D48B808;
      level.vehicle_ai_script_models[level.vehicle_ai_script_models.size] = _id_514D9E806D48B808;
      vehicle thread cleanup_fake_ai_on_death(_id_166C0F7056EDB681);

      if(_id_AC0E594AC96AA3A8 <= 1 && scripts\cp\utility::is_wave_gametype())
        vehicle thread script_model_pilot_kill_watch(_id_514D9E806D48B808);
    }
  }

  if(isDefined(level.vehicle_builds[infil_name]) && isDefined(level.vehicle_builds[infil_name].max_ai))
    _id_FC3670006DAE0C6E = int(min(level.vehicle_builds[infil_name].max_ai, vehicle.usedpositions.size));
  else
    _id_FC3670006DAE0C6E = vehicle.usedpositions.size;

  if(vehicle.attachedguys.size >= _id_FC3670006DAE0C6E) {
    vehicle notify("spawning_done");
    return;
  }
}

script_model_pilot_kill_watch(_id_C2F1CA305EE16808) {
  self endon("death");
  _id_C2F1CA305EE16808 endon("death");

  if(!isDefined(self) || !isDefined(_id_C2F1CA305EE16808)) {
    return;
  }
  _id_4116E8FD5DA7B698 = 250;

  for(;;) {
    self waittill("damage", amount, attacker, _id_97282C14346A7FCF, point);

    if(isDefined(attacker) && isPlayer(attacker) && isDefined(amount) && amount > 0 && isDefined(point)) {
      if(_id_C2F1CA305EE16808 tagexists("j_head"))
        _id_07461C788CFBE49A = _id_C2F1CA305EE16808 gettagorigin("j_head");
      else
        _id_07461C788CFBE49A = _id_C2F1CA305EE16808.origin + (0, 0, 50);

      _id_07461C788CFBE49A = _id_07461C788CFBE49A + (0, 0, -20);
      start_point = attacker getEye();
      _id_0DE2DC247CDCB29A = vectorNormalize(point - start_point);
      _id_16577D6CD42AB23C = vectorNormalize(_id_07461C788CFBE49A - start_point);
      _id_F22FD5F94653CCB6 = vectordot(_id_0DE2DC247CDCB29A, _id_16577D6CD42AB23C);
      _id_7B3AA6FEBD7B23A0 = vectordot(vectorNormalize(anglesToForward(self.angles)), vectorNormalize(point - self.origin));
      _id_C4B0CACB2BBAB0E5 = _id_C2F1CA305EE16808.origin + (0, 0, 18);

      if(_id_F22FD5F94653CCB6 > 0.99975 && _id_7B3AA6FEBD7B23A0 > 0.73 && point[2] > _id_C4B0CACB2BBAB0E5[2]) {
        _id_4116E8FD5DA7B698 = _id_4116E8FD5DA7B698 - amount;

        if(_id_4116E8FD5DA7B698 <= 0)
          self notify("death", attacker);
      }
    }
  }
}

cleanup_fake_ai_on_death(_id_166C0F7056EDB681) {
  self waittill("death");

  if(isDefined(_id_166C0F7056EDB681)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_166C0F7056EDB681.size; _id_AC0E594AC96AA3A8++)
      _id_166C0F7056EDB681[_id_AC0E594AC96AA3A8] remove_fake_guy_from_list();
  }
}

remove_fake_guy_from_list() {
  if(scripts\engine\utility::array_contains(level.vehicle_ai_script_models, self)) {
    level.vehicle_ai_script_models = scripts\engine\utility::array_remove(level.vehicle_ai_script_models, self);

    if(isDefined(self))
      self delete();
  }
}

get_vehicle_spawn_points(spawn_point) {
  if(istrue(spawn_point.veh_model_spawner))
    return [spawn_point];
  else {
    _id_1F6308549434002C = scripts\engine\utility::getStructArray(self.spawn_points, "targetname");
    _id_7BBDA18A855C7111 = [];

    if(isDefined(spawn_point.script_linkname)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1F6308549434002C.size; _id_AC0E594AC96AA3A8++) {
        if(is_linked_struct(_id_1F6308549434002C[_id_AC0E594AC96AA3A8], spawn_point))
          _id_7BBDA18A855C7111[_id_7BBDA18A855C7111.size] = _id_1F6308549434002C[_id_AC0E594AC96AA3A8];
      }

      if(_id_7BBDA18A855C7111.size < 1) {
        return scripts\engine\utility::array_randomize(_id_1F6308549434002C);
        return;
      }

      _id_FD373F834DB9228E = scripts\engine\utility::random(_id_7BBDA18A855C7111);
      return [_id_FD373F834DB9228E];
      return;
    } else
      return scripts\engine\utility::array_randomize(_id_1F6308549434002C);
  }
}

veh_heli_spawn(group, spawn_point, infil_name) {
  _id_A0B5803DA717965F = level.ai_spawn_vehicle_func[infil_name];
  _id_1317C822798F0C26 = _id_A0B5803DA717965F get_vehicle_spawn_points(spawn_point);

  if(_id_1317C822798F0C26.size > 0) {
    foreach(veh_spawn_point in _id_1317C822798F0C26) {
      if(istrue(veh_spawn_point.in_use)) {
        continue;
      }
      if(getdvarint("dvar_610414ECDFE9549F", 0))
        thread scripts\engine\utility::draw_capsule(veh_spawn_point.origin, 64, 64, (0, 0, 0), (0, 1, 0), 0, 1000);

      copy_vehicle_build_to_spawnpoint(infil_name, veh_spawn_point);
      angle_ref = vectortoangles(spawn_point.origin - veh_spawn_point.origin);
      veh_spawn_point.angles = (0, angle_ref[1], 0);
      vehicle = scripts\common\vehicle::vehicle_spawn(veh_spawn_point);

      if(isDefined(vehicle)) {
        vehicle init_cp_vehicle(spawn_point, group, veh_spawn_point, infil_name);
        veh_spawn_point toggle_in_use(1);

        if(veh_spawn_point scripts\common\vehicle::ishelicopter())
          vehicle init_helicopter(group, infil_name);
        else {}

        if(isDefined(group))
          group.vehicle = vehicle;

        vehicle.veh_spawn_point = veh_spawn_point;
        vehicle.path_gobbler = 1;
        spawn_point.specs = level.spawner_script_funcs[infil_name].specs;
        spawn_point.ai_infil_type = infil_name;
        vehicle thread veh_ping_vehicle_location_to_players();
        vehicle thread heli_waittill_full_or_timeout(infil_name, group);

        if(vehicle_is_ambient(infil_name) || getdvarint("dvar_9BA0D5F78C98373E", 0) || scripts\cp\utility::is_wave_gametype())
          vehicle thread spawn_script_model_driver_and_passengers(vehicle, infil_name);

        clear_vehicle_build_to_spawnpoint(veh_spawn_point);
        return 1;
      } else {
        clear_vehicle_build_to_spawnpoint(veh_spawn_point);
        return 0;
      }
    }

    return 0;
  } else
    return 0;
}

init_cp_vehicle(spawn_point, group, veh_spawn_point, infil_name) {
  self.load_queue = [];
  self.spawn_point = spawn_point;
  self.infil_name = infil_name;

  if(isDefined(group)) {
    self.group = group;
    group.vehicle = self;
    group.recently_spawned_vehicle = 1;
    group thread decrement_wave_veh_count(infil_name);
  }

  spawn_point.vehicle = self;
  spawn_point.veh_spawn_point = veh_spawn_point;
  self.veh_spawn_point = veh_spawn_point;
  self.dontdisconnectpaths = 1;
  self setCanDamage(1);
  scripts\cp_mp\emp_debuff::set_start_emp_callback(scripts\cp_mp\vehicles\vehicle::vehicle_empstartcallback);
  scripts\cp_mp\emp_debuff::set_clear_emp_callback(scripts\cp_mp\vehicles\vehicle::vehicle_empclearcallback);
  thread destroy_vehicle_if_driver_dies();
  self vehicle_turnengineon();
}

destroy_vehicle_if_driver_dies() {
  self endon("death");
  guy = watch_for_driver_spawned();

  if(isDefined(guy) && isai(guy)) {
    guy.health = 500;
    guy.maxhealth = 500;

    if(scripts\common\vehicle::ishelicopter())
      thread destroy_vehicle_on_pilot_death(guy);
    else
      thread stop_vehicle_on_pilot_death(guy);
  }
}

destroy_vehicle_on_pilot_death(guy) {
  level endon("game_ended");
  self endon("death_finished");
  self endon("death");
  guy endon("unload");
  guy waittill("death", attacker, test, _id_976E241753308581, _id_976E23175330834E);
  self notify("death", attacker);
}

stop_vehicle_on_pilot_death(guy) {
  level endon("game_ended");
  self endon("death");
  guy endon("unload");
  guy waittill("death", attacker, test, _id_976E241753308581, _id_976E23175330834E);
  self notify("watch_for_all_passengers_dead");
  self stoppath(1);
  self notify("stop_follow_path");
  self vehicle_setspeedimmediate(0, 1, 1);
  scripts\common\vehicle::vehicle_unload();
  wait 0.25;

  if(isDefined(level.vehicle._id_9442D439C225C3FE)) {
    if([[level.vehicle._id_9442D439C225C3FE]](self))
      return;
  }
}

watch_for_driver_spawned() {
  level endon("game_ended");
  self endon("death");
  self endon("unloading");

  for(;;) {
    self waittill("guy_entered", guy, pos);

    if(isDefined(guy)) {
      if(scripts\engine\utility::is_equal(self.driver, guy))
        return guy;
    }
  }

  return undefined;
}

toggle_in_use(_id_E3108E412AFB3811) {
  if(istrue(_id_E3108E412AFB3811))
    self.in_use = _id_E3108E412AFB3811;
  else
    self.in_use = undefined;
}

clear_vehicle_build_to_spawnpoint(veh_spawn_point) {
  veh_spawn_point.classname_mp = undefined;
  veh_spawn_point.vehicletype = undefined;
  veh_spawn_point.vehiclename = undefined;
}

copy_vehicle_build_to_spawnpoint(infil_name, veh_spawn_point) {
  if(isDefined(level.vehicle_builds) && isDefined(level.vehicle_builds[infil_name])) {
    _id_A0B5803DA717965F = level.vehicle_builds[infil_name];

    if(isDefined(_id_A0B5803DA717965F.classname_mp))
      veh_spawn_point.classname_mp = _id_A0B5803DA717965F.classname_mp;

    if(isDefined(_id_A0B5803DA717965F.vehicletype))
      veh_spawn_point.vehicletype = _id_A0B5803DA717965F.vehicletype;

    if(isDefined(_id_A0B5803DA717965F.vehiclename))
      veh_spawn_point.vehiclename = _id_A0B5803DA717965F.vehiclename;
  }
}

waittill_full_or_timeout(infil_name, group) {
  self notify("waittill_full_or_timeout");
  self endon("waittill_full_or_timeout");
  self endon("death");
  level endon("game_ended");
  thread decrement_vehicles_active(infil_name, group);
  thread watch_for_all_passengers_dead(infil_name, group);

  if(self vehicle_isphysveh()) {
    if(getdvarint("dvar_B77D72F69452A294", 0))
      self vehicle_cleardrivingstate();

    self.veh_brake = 1;
  }

  self waittill("spawning_done");
  self.spawn_point _id_18A73A64992DD07D::disable_spawner();
  scripts\engine\utility::thread_on_notify_no_endon_death("unloading", ::check_for_unloading_func, infil_name, undefined, undefined);

  if(!isDefined(self.group.successful_vehicle_spawns))
    self.group.successful_vehicle_spawns = 1;
  else
    self.group.successful_vehicle_spawns++;

  self.group.vehicle = undefined;
  self.spawn_point.pos_override_struct = undefined;

  if(self.load_queue.size > 0) {
    thread scripts\common\vehicle::vehicle_load_ai(self.load_queue);
    scripts\engine\utility::ent_flag_wait("loaded");
  } else
    wait 1;

  _id_CBD3F7020EC784E3 = create_vehicle_path(infil_name);

  if(self vehicle_isphysveh())
    self.veh_brake = 0;

  self notify("ai_vehicle_pathing_started");

  if(!self vehicle_isphysveh()) {
    if(isDefined(self.target)) {
      start_node = getvehiclenode(self.target, "targetname");
      self attachpath(start_node);
      self startpath();
    } else
      self notify("stop_vehicle_watchers");
  } else {
    self notify("newpath");

    if(isDefined(self.target)) {
      start_node = getvehiclenode(self.target, "targetname");

      if(isDefined(start_node)) {
        self attachpath(start_node);
        self startpath();
        return;
      }
    }

    if(getdvarint("dvar_B77D72F69452A294", 0) && self.pathing_array.size >= 1) {
      self.spawn_point.vehicle = undefined;
      vehiclefollowstructpath(self.pathing_array[0], 1);
    } else {
      self.spawn_point.vehicle = undefined;
      thread scripts\common\vehicle_paths::getonpath();
    }
  }
}

get_duration_between_points(startpos, endpos, speed, _id_AC43678ED65C8B44) {
  dist = distance(startpos, endpos);

  if(istrue(_id_AC43678ED65C8B44))
    dist = dist * 0.0568182;

  _id_58824A41B5315792 = dist / speed;

  if(_id_58824A41B5315792 < 0.05)
    _id_58824A41B5315792 = 0.05;

  return _id_58824A41B5315792;
}

heli_waittill_full_or_timeout(infil_name, group) {
  self notify("waittill_full_or_timeout");
  self endon("waittill_full_or_timeout");
  self endon("death");
  level endon("game_ended");
  thread decrement_vehicles_active(infil_name, group);
  thread heli_watch_for_fly_away(infil_name);
  self waittill("spawning_done");
  self.spawn_point _id_18A73A64992DD07D::disable_spawner();

  if(isDefined(group))
    self.group.vehicle = undefined;

  scripts\engine\utility::thread_on_notify_no_endon_death("unloading", ::check_for_unloading_func, infil_name, undefined, undefined);
  scripts\engine\utility::thread_on_notify_no_endon_death("unloaded", ::delete_nav_obstacle, undefined, undefined, undefined);

  if(isDefined(self.spawn_point.heli_path_func))
    _id_CBD3F7020EC784E3 = self[[self.spawn_point.heli_path_func]](infil_name);
  else
    _id_CBD3F7020EC784E3 = create_direct_heli_path(infil_name);

  self.spawn_point.vehicle = undefined;
}

check_for_unloading_func(infil_name) {
  if(isDefined(level.unloading_func[infil_name]))
    self thread[[level.unloading_func[infil_name]]]();
}

watch_for_all_passengers_dead(infil_name, group) {
  self notify("watch_for_all_passengers_dead");
  self endon("watch_for_all_passengers_dead");
  self endon("death");
  self endon("unloading");
  self waittill("guy_entered");
  self waittill("spawning_done");

  for(;;) {
    _id_67B4A6E5752B260F = get_vehicle_riders(1);

    if(_id_67B4A6E5752B260F <= 0) {
      delete_nav_obstacle();
      self notify("all_passengers_dead");
      self notify("newpath");
      self vehicle_setspeedimmediate(0, 30, 30);
      thread convert_remaining_to_ai(group);
      break;
    }

    wait 0.2;
  }
}

convert_remaining_to_ai(group, _id_C02E57DF860F2D41) {
  _id_6D906809844C7CB1 = self.riders;

  if(isDefined(_id_C02E57DF860F2D41))
    _id_6D906809844C7CB1 = _id_C02E57DF860F2D41;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_6D906809844C7CB1.size; _id_AC0E594AC96AA3A8++) {
    rider = _id_6D906809844C7CB1[_id_AC0E594AC96AA3A8];

    if(!isent(rider) || isagent(rider)) {
      continue;
    }
    _id_78543F1A37928429 = spawnStruct();
    _id_78543F1A37928429.origin = rider.origin;
    _id_78543F1A37928429.angles = rider.angles;
    _id_78543F1A37928429.vehicle_position = rider.vehicle_position;
    _id_78543F1A37928429.specs = rider.specs;

    if(isDefined(self.convoy))
      level deposit_from_compromised_convoy_delayed(self);

    rider remove_fake_guy_from_list();
    _id_3DD82B36B07A721B = _id_78543F1A37928429.vehicle_position;
    _id_78543F1A37928429.vehicle_position = undefined;
    _id_78543F1A37928429.specs = "vehicle_ai";
    soldier = _id_18A73A64992DD07D::_id_4441D2C30537EC6B(group, _id_78543F1A37928429, 0, "vehicle_ai", undefined, 1);

    if(isDefined(soldier)) {
      soldier.forced_startingposition = _id_3DD82B36B07A721B;

      if(istrue(self.stealth_enabled)) {
        soldier.ignoreall = 0;
        soldier.sightmaxdistance = 2200;
        soldier thread scripts\cp\coop_stealth::run_common_functions(soldier, 1, 1, 60, 160000);
      }

      thread scripts\common\vehicle_aianim::guy_enter(soldier);
    }

    if(isent(rider))
      rider delete();
  }

  scripts\common\vehicle::vehicle_unload();
}

deposit_from_compromised_convoy_delayed(vehicle) {
  level endon("game_ended");

  if(!isDefined(vehicle.convoy)) {
    return;
  }
  vehicle.convoy endon("event_convoy_delete");
  vehicle.convoy endon("death");
  vehicle endon("death");
  convoy = vehicle.convoy;

  if(istrue(convoy.delayed_depositing)) {
    vehicle thread deposit_from_compromised_convoy_delayed_failsafe();

    while(istrue(convoy.delayed_depositing))
      wait 0.5;

    return;
  }

  _id_1AA0D8C830908356 = 28;

  if(getaiarray("axis").size > _id_1AA0D8C830908356) {
    convoy.delayed_depositing = 1;
    _id_18A73A64992DD07D::pause_group_by_group_name("wave_spawning");

    while(getaiarray("axis").size > _id_1AA0D8C830908356)
      wait 0.5;

    convoy.delayed_depositing = undefined;
    convoy notify("delayed_depositing_undefined");
    _id_18A73A64992DD07D::unpause_group_by_group_name("wave_spawning");
  }
}

deposit_from_compromised_convoy_delayed_failsafe() {
  level endon("game_ended");
  self.convoy endon("delayed_depositing_undefined");
  self waittill("death");

  if(isDefined(self.convoy))
    self.convoy.delayed_depositing = undefined;
}

heli_watch_for_fly_away(infil_name) {
  self notify("heli_watch_for_fly_away");
  self endon("heli_watch_for_fly_away");
  self endon("death");
  self waittill("guy_entered");
  self waittill("spawning_done");
  thread waittill_all_valid_ai_are_gone(infil_name);
  thread waittill_unload_complete(infil_name);
}

waittill_unload_complete(infil_name) {
  self notify("waittill_unload_complete");
  self endon("waittill_unload_complete");
  self endon("death");
  self endon("all_valid_passengers_are_gone");
  self waittill("unloaded");

  if(isDefined(self.spawn_point) && isDefined(self.spawn_point.leaveforplayer)) {
    if(isDefined(level.heli_convertforplayerfunc))
      [[level.heli_convertforplayerfunc]](self);

    return;
  }

  self notify("newpath");
  delete_nav_obstacle();
  thread get_to_z_and_fly_off(infil_name);
  self notify("all_valid_passengers_are_gone");
}

waittill_all_valid_ai_are_gone(infil_name) {
  self notify("waittill_all_valid_ai_are_gone");
  self endon("waittill_all_valid_ai_are_gone");
  self endon("death");
  self endon("unloaded");

  for(;;) {
    _id_C0001A6C73106EE1 = get_vehicle_riders();
    _id_67B4A6E5752B260F = get_vehicle_riders(1);
    _id_F268752392AC42D1 = get_vehicle_unloadable_riders(1);

    if(_id_67B4A6E5752B260F <= 0 || _id_F268752392AC42D1 <= 0) {
      if(isDefined(self.spawn_point) && isDefined(self.spawn_point.leaveforplayer)) {
        if(isDefined(level.heli_convertforplayerfunc))
          [[level.heli_convertforplayerfunc]](self);

        return;
      }

      thread get_to_z_and_fly_off(infil_name);
      self notify("newpath");
      delete_nav_obstacle();
      self notify("all_valid_passengers_are_gone");
      break;
    }

    wait 0.2;
  }
}

get_to_z_and_fly_off(infil_name, _id_61BEC49FD0BA66B6) {
  self endon("death");
  thread mark_remaining_as_died_poorly();
  ground_pos = getgroundposition(self.origin, 1);

  if(distancesquared(self.origin, ground_pos) <= 2250000) {
    _id_07B02A0C55EEDDF9 = spawnStruct();
    _id_07B02A0C55EEDDF9.origin = ground_pos + (0, 0, 1500);
    _id_07B02A0C55EEDDF9.angles = self.angles;
    _id_07B02A0C55EEDDF9.script_goalyaw = 1;
    thread scripts\common\vehicle_paths::vehicle_paths_helicopter(_id_07B02A0C55EEDDF9);
    self setneargoalnotifydist(512);
    scripts\engine\utility::waittill_any_2("near_goal", "goal");
  }

  if(!isDefined(_id_61BEC49FD0BA66B6))
    _id_61BEC49FD0BA66B6 = get_best_end_point(infil_name, self.spawn_point, self.angles);

  if(!isDefined(_id_61BEC49FD0BA66B6))
    _id_61BEC49FD0BA66B6 = scripts\engine\utility::random(scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[infil_name].exit_points, "targetname"));

  end_point = duplicate_struct(_id_61BEC49FD0BA66B6);
  forward = anglesToForward(vectortoangles(end_point.origin - self.origin)) * 10000;
  end_point.origin = end_point.origin + (forward[0], forward[1], end_point.origin[2]);
  end_point.targetname = create_unique_kvp_string();
  self.end_point = end_point;
  _id_A9C45240836FE2A5 = end_point;

  if(getdvarint("dvar_610414ECDFE9549F", 0))
    thread scripts\engine\utility::draw_capsule(end_point.origin, 32, 32, (0, 0, 0), (1, 0, 0), 0, 250);

  thread scripts\common\vehicle_paths::vehicle_paths_helicopter(end_point);
}

mark_remaining_as_died_poorly() {
  level endon("game_ended");
  self endon("death");
  wait 2;

  if(isDefined(self.riders) && self.riders.size > 0) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.riders.size; _id_AC0E594AC96AA3A8++)
      self.riders[_id_AC0E594AC96AA3A8].never_unloaded_from_vehicle = 1;
  }
}

get_vehicle_riders(_id_522C6B77AC421E1D) {
  count = 0;

  foreach(guy in self.riders) {
    if(istrue(_id_522C6B77AC421E1D)) {
      if(isalive(guy))
        count++;

      continue;
    }

    count++;
  }

  return count;
}

get_vehicle_unloadable_riders(_id_522C6B77AC421E1D, infil_name) {
  count = 0;

  if(isDefined(self.classname_mp)) {
    if(isDefined(level.vehicle) && isDefined(level.vehicle.templates) && isDefined(level.vehicle.templates.aianims) && isDefined(level.vehicle.templates.aianims[self.classname_mp])) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.riders.size; _id_AC0E594AC96AA3A8++) {
        ai = self.riders[_id_AC0E594AC96AA3A8];

        if(!isalive(ai)) {
          continue;
        }
        if(!isai(ai)) {
          continue;
        }
        if(!isDefined(ai.vehicle_position)) {
          continue;
        }
        if(scripts\common\vehicle_aianim::check_unloadgroup(ai.vehicle_position)) {
          seat = level.vehicle.templates.aianims[self.classname_mp][ai.vehicle_position];

          if(isDefined(seat.getout))
            count++;
        }
      }
    }
  }

  return count;
}

create_vehicle_path(infil_name) {
  level notify("create_vehicle_path");
  counter = level.next_index;
  level.next_index++;

  if(isDefined(self.spawn_point.veh_model_spawner)) {
    self.allow_unload_on_path = 1;
    start_point = create_path_to_delete_node(infil_name, counter);
    _id_7DCE14FB8EAE79C2 = undefined;
    return start_point;
  } else {
    start_point = duplicate_struct(self.veh_spawn_point);
    add_targetname_kvps(start_point, undefined, infil_name + counter + "_start");
    self.currentnode = start_point;
    _id_D1160844762A0829 = create_simple_path(self.currentnode, self.angles, counter, infil_name, "_end_node_pathing_", (1, 1, 0));

    if(_id_D1160844762A0829)
      return start_point;
  }

  _id_7DCE14FB8EAE79C2 = duplicate_struct(self.spawn_point);
  _id_04769A2CAD76E31F = undefined;

  if(isDefined(_id_7DCE14FB8EAE79C2) && isDefined(self.veh_spawn_point) && isDefined(self.veh_spawn_point.script_linkto)) {
    _id_3D938A1343D65FED = self.veh_spawn_point get_veh_linked_structs();
    _id_B1CF71F85043AEA6 = -5;

    foreach(struct in _id_3D938A1343D65FED) {
      _id_2C4FAF696B6CFDCA = scripts\engine\math::get_dot(self.origin, self.angles, struct.origin);
      _id_0D305C3C2DE1B97A = scripts\engine\math::get_dot(self.origin, vectortoangles(_id_7DCE14FB8EAE79C2.origin - self.origin), struct.origin);
      _id_D8F6616D2843D321 = _id_2C4FAF696B6CFDCA + _id_0D305C3C2DE1B97A;

      if(_id_D8F6616D2843D321 > _id_B1CF71F85043AEA6) {
        _id_B1CF71F85043AEA6 = _id_D8F6616D2843D321;
        _id_04769A2CAD76E31F = struct;
      }
    }
  }

  if(!isDefined(_id_04769A2CAD76E31F)) {
    _id_54ACC546493F0109 = scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[infil_name].path_start_points, "targetname");

    if(!isDefined(_id_54ACC546493F0109) || _id_54ACC546493F0109.size < 1)
      _id_54ACC546493F0109 = scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[infil_name].path_start_points, "script_linkName");

    if(!isDefined(_id_54ACC546493F0109) || _id_54ACC546493F0109.size < 1) {
      return;
    }
    _id_04769A2CAD76E31F = scripts\engine\utility::getclosest(self.origin, _id_54ACC546493F0109);
  }

  if(!isDefined(_id_04769A2CAD76E31F)) {
    return;
  }
  _id_CBD3F7020EC784E3 = duplicate_struct(_id_04769A2CAD76E31F);
  _id_CBD3F7020EC784E3.angles = vectortoangles(_id_CBD3F7020EC784E3.origin - self.origin);

  if(0) {
    level thread scripts\cp\utility::draw_line_until_endons(self.spawn_point.origin, 1, 1, 1, "create_vehicle_path");
    level thread scripts\cp\utility::draw_line_until_endons(_id_CBD3F7020EC784E3.origin, 0, 1, 0, "create_vehicle_path");
    level thread scripts\cp\utility::draw_line_until_endons(_id_7DCE14FB8EAE79C2.origin, 1, 1, 0, "create_vehicle_path");
  }

  add_targetname_kvps(_id_CBD3F7020EC784E3, undefined, infil_name + counter + "_start");
  create_path_from_struct_to_struct(_id_CBD3F7020EC784E3, _id_7DCE14FB8EAE79C2, counter, infil_name, "_unload_pathing_", (1, 1, 1));
  scripts\engine\utility::thread_on_notify("unloaded", ::create_path_to_delete_node, infil_name, counter, self);
  scripts\engine\utility::thread_on_notify_no_endon_death("death", ::reset_spawn_point_targetname, self.spawn_point, undefined, self);
  self.disabled_nodes = undefined;
  return _id_CBD3F7020EC784E3;
}

create_path_to_delete_node(infil_name, counter) {
  start_point = self.spawn_point;
  self.currentnode = start_point;
  _id_D1160844762A0829 = create_simple_path(self.currentnode, self.angles, counter, infil_name, "_end_node_pathing_", (1, 1, 0));

  if(!_id_D1160844762A0829) {
    _id_05BDA6F0ECAF2F49 = get_best_end_point(infil_name, self.currentnode);
    end_point = duplicate_struct(_id_05BDA6F0ECAF2F49);
    self.path_gobbler = 1;
    self.end_point = end_point;

    if(0)
      level thread scripts\cp\utility::draw_line_until_endons(end_point.origin, 1, 0, 0, "create_vehicle_path");

    create_path_from_struct_to_struct(self.currentnode, end_point, counter, infil_name, "_end_node_pathing_", (1, 1, 0));
  }

  if(scripts\engine\math::is_point_in_front(self.currentnode.origin) || self.spawn_point.origin == self.currentnode.origin)
    self.target = self.pathing_array[1].targetname;
  else if(!_id_D1160844762A0829)
    self.target = self.pathing_array[1].targetname;
  else
    self.pathing_array = scripts\engine\utility::array_remove_index(self.pathing_array, 0);

  self.disabled_nodes = undefined;
  return self.currentnode;
}

create_simple_path(start_struct, _id_DB617C385EE191CB, counter, infil_name, _id_B530AB3549782A68, color) {
  level endon("game_ended");
  self endon("death");
  _id_4A9E97799777F3FD = 1;
  current_struct = start_struct;
  _id_4D423FE4A21114AD = -0.3;
  self.pathing_array = [start_struct];

  if(0) {
    level.players[0] notifyonplayercommand("use", "+usereload");
    level.players[0] notifyonplayercommand("use", "+activate");
  }

  if(isDefined(current_struct.script_linkto)) {
    start_point = duplicate_struct(current_struct);
    add_targetname_kvps(start_point, undefined, infil_name + counter + "_start");
    self.currentnode = start_point;
    current_struct = self.currentnode;
  }

  for(;;) {
    if(0)
      level.players[0] waittill("use");

    if(isDefined(current_struct.script_linkto)) {
      _id_3D938A1343D65FED = current_struct get_veh_linked_structs();
      _id_1F6308549434002C = [];
      _id_E627E357CF133EAB = -1;
      _id_150CD8ABC305712D = undefined;

      if(_id_3D938A1343D65FED.size == 1)
        _id_1F6308549434002C[_id_1F6308549434002C.size] = _id_3D938A1343D65FED[0];
      else {
        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3D938A1343D65FED.size; _id_AC0E594AC96AA3A8++) {
          _id_E7F629E8D81B352C = _id_3D938A1343D65FED[_id_AC0E594AC96AA3A8];

          if(!isDefined(_id_150CD8ABC305712D))
            _id_150CD8ABC305712D = _id_E7F629E8D81B352C;

          _id_2C4FAF696B6CFDCA = scripts\engine\math::get_dot(current_struct.origin, _id_DB617C385EE191CB, _id_E7F629E8D81B352C.origin);

          if(_id_2C4FAF696B6CFDCA >= _id_4D423FE4A21114AD)
            _id_1F6308549434002C[_id_1F6308549434002C.size] = _id_E7F629E8D81B352C;
        }
      }

      if(_id_1F6308549434002C.size < 1 && isDefined(_id_150CD8ABC305712D))
        _id_1F6308549434002C[_id_1F6308549434002C.size] = _id_150CD8ABC305712D;

      if(_id_1F6308549434002C.size > 0) {
        _id_B9E5326D8602D248 = scripts\engine\utility::random(_id_1F6308549434002C);
        _id_B9E5326D8602D248 = duplicate_struct(_id_B9E5326D8602D248);
        self.path_gobbler = 1;
        self.pathing_array[self.pathing_array.size] = _id_B9E5326D8602D248;
        add_targetname_kvps(_id_B9E5326D8602D248, current_struct, infil_name + "_" + counter + "_simple_path_" + self.pathing_array.size);

        if(0)
          level thread scripts\cp\utility::draw_line_until_endons(current_struct.origin, 1, 1, 1, "create_vehicle_path", _id_B9E5326D8602D248.origin);

        current_struct = _id_B9E5326D8602D248;
      } else
        break;
    } else if(isDefined(current_struct.target)) {
      _id_3D938A1343D65FED = current_struct scripts\engine\utility::get_target_array();
      _id_1F6308549434002C = [];
      _id_E627E357CF133EAB = -1;
      _id_150CD8ABC305712D = undefined;

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3D938A1343D65FED.size; _id_AC0E594AC96AA3A8++) {
        _id_E7F629E8D81B352C = _id_3D938A1343D65FED[_id_AC0E594AC96AA3A8];
        _id_2C4FAF696B6CFDCA = scripts\engine\math::get_dot(current_struct.origin, _id_DB617C385EE191CB, _id_E7F629E8D81B352C.origin);

        if(_id_2C4FAF696B6CFDCA >= _id_4D423FE4A21114AD) {
          _id_1F6308549434002C[_id_1F6308549434002C.size] = _id_E7F629E8D81B352C;
          continue;
        }

        if(_id_2C4FAF696B6CFDCA >= _id_E627E357CF133EAB)
          _id_150CD8ABC305712D = _id_3D938A1343D65FED[_id_AC0E594AC96AA3A8];
      }

      if(_id_1F6308549434002C.size < 1 && isDefined(_id_150CD8ABC305712D))
        _id_1F6308549434002C[_id_1F6308549434002C.size] = _id_150CD8ABC305712D;

      if(_id_1F6308549434002C.size > 0) {
        _id_B9E5326D8602D248 = scripts\engine\utility::random(_id_1F6308549434002C);

        if(scripts\engine\utility::array_contains(self.pathing_array, _id_B9E5326D8602D248)) {
          self.pathing_array[self.pathing_array.size] = _id_B9E5326D8602D248;
          self.looping_path = 1;
          break;
        }

        self.pathing_array[self.pathing_array.size] = _id_B9E5326D8602D248;

        if(0)
          level thread scripts\cp\utility::draw_line_until_endons(current_struct.origin, 1, 1, 1, "create_vehicle_path", _id_B9E5326D8602D248.origin);

        current_struct = _id_B9E5326D8602D248;
      } else
        break;
    } else
      break;
  }

  if(self.pathing_array.size > 27)
    split_large_pathing_array();

  if(self.pathing_array.size < 1)
    return 0;
  else
    return 1;
}

split_large_pathing_array() {
  self.pathing_arrays = [];
  _id_2C437D6B6EBD8178 = [];
  _id_51B313A230B35BCE = undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.pathing_array.size; _id_AC0E594AC96AA3A8++) {
    _id_2C437D6B6EBD8178[_id_2C437D6B6EBD8178.size] = self.pathing_array[_id_AC0E594AC96AA3A8];
    _id_51B313A230B35BCE = self.pathing_array[_id_AC0E594AC96AA3A8];

    if(_id_AC0E594AC96AA3A8 > 0 && _id_AC0E594AC96AA3A8 % 27 == 0) {
      self.pathing_arrays[self.pathing_arrays.size] = _id_2C437D6B6EBD8178;
      _id_2C437D6B6EBD8178 = [];
      _id_2C437D6B6EBD8178[0] = _id_51B313A230B35BCE;
    }
  }

  if(_id_2C437D6B6EBD8178.size == 1) {
    _id_A7B23DAE3BCFE5F8 = spawnStruct();
    _id_A7B23DAE3BCFE5F8.origin = (_id_2C437D6B6EBD8178[0].origin + _id_51B313A230B35BCE.origin) / 2;
    _id_2C437D6B6EBD8178[_id_2C437D6B6EBD8178.size] = _id_2C437D6B6EBD8178[0];
    _id_2C437D6B6EBD8178[0] = _id_A7B23DAE3BCFE5F8;
  }

  if(_id_2C437D6B6EBD8178.size > 0)
    self.pathing_arrays[self.pathing_arrays.size] = _id_2C437D6B6EBD8178;
}

create_path_from_struct_to_struct(start_struct, _id_9284CBA34E9BF9AE, counter, infil_name, _id_B530AB3549782A68, color) {
  level endon("game_ended");
  self endon("death");
  _id_11423199B914525B = start_struct;
  _id_11423199B914525B.angles = self.angles;
  _id_66FBACFA7822D8B8 = undefined;
  _id_4D6FC4F475716D13 = 1;
  index = 0;
  start_struct.pathing_index = 0;

  if(isDefined(self.disabled_nodes))
    self.disabled_nodes = undefined;

  if(isDefined(self.pathing_array)) {
    foreach(struct in self.pathing_array) {
      if(isDefined(struct)) {
        struct.previous_struct = undefined;
        struct.antepenultimate_struct = undefined;
      }
    }
  }

  self.pathing_array = [start_struct];

  if(0) {
    announcement("Waiting for player use");
    level.players[0] notifyonplayercommand("use", "+usereload");
    level.players[0] notifyonplayercommand("use", "+activate");
  }

  for(;;) {
    if(0)
      level.players[0] waittill("use");

    _id_11423199B914525B = find_closest_path_struct(_id_11423199B914525B, _id_9284CBA34E9BF9AE, infil_name + counter + _id_B530AB3549782A68 + index, color, infil_name);

    if(isDefined(_id_11423199B914525B)) {
      if(!isDefined(_id_11423199B914525B.pathing_index)) {
        _id_11423199B914525B.pathing_index = self.pathing_array.size;
        self.pathing_array[self.pathing_array.size] = _id_11423199B914525B;

        if(0) {
          if(isDefined(_id_11423199B914525B.previous_struct))
            level thread scripts\cp\utility::draw_line_until_endons(_id_11423199B914525B.previous_struct.origin, color[0], color[1], color[2], ["create_vehicle_path", "kill_debug_" + _id_11423199B914525B.pathing_index], _id_11423199B914525B.origin);
        }
      }

      if(_id_11423199B914525B.origin == _id_9284CBA34E9BF9AE.origin) {
        break;
      }
    } else
      break;

    if(index > 1000) {
      self notify("no_good_path_found");
      break;
    }

    index++;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.pathing_array.size - 1; _id_AC0E594AC96AA3A8++)
    self.pathing_array[_id_AC0E594AC96AA3A8].target = self.pathing_array[_id_AC0E594AC96AA3A8 + 1].targetname;

  if(self.pathing_array.size > 27)
    split_large_pathing_array();
}

find_closest_path_struct(_id_11423199B914525B, _id_9284CBA34E9BF9AE, _id_B530AB3549782A68, color, infil_name) {
  self notify("find_closest_path_struct");

  if(0)
    level thread scripts\cp\utility::drawsphere(_id_11423199B914525B.origin, 24, 1, (1, 1, 1));

  _id_66FBACFA7822D8B8 = undefined;
  _id_2A4E8A0618AAA740 = sortbydistance(_id_11423199B914525B get_veh_linked_structs(), _id_9284CBA34E9BF9AE.origin);

  if(_id_2A4E8A0618AAA740.size < 1) {
    _id_B077FDCA28691BB5 = scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[infil_name].path_start_points, "targetname");

    if(!isDefined(_id_B077FDCA28691BB5) || _id_B077FDCA28691BB5.size < 1)
      _id_B077FDCA28691BB5 = scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[infil_name].path_start_points, "script_linkName");

    if(!isDefined(_id_B077FDCA28691BB5) || _id_B077FDCA28691BB5.size < 1) {
      return;
    }
    _id_D089782220D4E340 = scripts\engine\utility::get_array_of_closest(_id_11423199B914525B.origin, _id_B077FDCA28691BB5, [_id_11423199B914525B], 3);

    foreach(_id_4A97BF4DD0C4CFB3 in _id_D089782220D4E340) {
      _id_2A4E8A0618AAA740[_id_2A4E8A0618AAA740.size] = _id_4A97BF4DD0C4CFB3;
      _id_2A4E8A0618AAA740 = scripts\engine\utility::array_combine(_id_2A4E8A0618AAA740, sortbydistance(_id_4A97BF4DD0C4CFB3 get_veh_linked_structs(), _id_4A97BF4DD0C4CFB3.origin));
    }
  }

  _id_7D2C11DD3BB5B02B = [];
  _id_E627E357CF133EAB = -5;
  _id_D28E1722BFE56FAF = 20000;
  _id_797A9FED467EC56B = -5;
  _id_641AC8D8ABE488F5 = undefined;
  _id_E79809BD510FBD33 = 0;

  foreach(_id_4A97BF4DD0C4CFB3 in _id_2A4E8A0618AAA740) {
    add_struct = _id_4A97BF4DD0C4CFB3;

    foreach(_id_14E4FCA1867A6A88 in self.pathing_array) {
      if(istrue(_id_14E4FCA1867A6A88.disabled) || _id_4A97BF4DD0C4CFB3.origin == _id_14E4FCA1867A6A88.origin) {
        add_struct = undefined;
        break;
      }
    }

    if(isDefined(add_struct))
      _id_7D2C11DD3BB5B02B[_id_7D2C11DD3BB5B02B.size] = add_struct;
  }

  _id_11423199B914525B.rewinding_path = undefined;

  if(_id_7D2C11DD3BB5B02B.size > 1) {
    if(istrue(0)) {}

    self.pathing_array[self.pathing_array.size - 1].was_branch = 1;
  }

  if(is_linked_struct(_id_11423199B914525B, _id_9284CBA34E9BF9AE))
    _id_66FBACFA7822D8B8 = _id_9284CBA34E9BF9AE;
  else if(_id_7D2C11DD3BB5B02B.size > 0) {
    if(istrue(0)) {
      foreach(_id_5D94B582BE0ED7B3 in _id_7D2C11DD3BB5B02B) {}
    }

    _id_66FBACFA7822D8B8 = calc_best_closest_struct(_id_11423199B914525B, _id_9284CBA34E9BF9AE, _id_7D2C11DD3BB5B02B);
  }

  if(!isDefined(_id_66FBACFA7822D8B8) && isDefined(_id_641AC8D8ABE488F5))
    _id_66FBACFA7822D8B8 = _id_641AC8D8ABE488F5;

  if(isDefined(_id_66FBACFA7822D8B8)) {
    _id_66FBACFA7822D8B8.angles = vectortoangles(_id_66FBACFA7822D8B8.origin - _id_11423199B914525B.origin);

    if(_id_66FBACFA7822D8B8.origin != _id_9284CBA34E9BF9AE.origin)
      _id_66FBACFA7822D8B8 = duplicate_struct(_id_66FBACFA7822D8B8);

    _id_66FBACFA7822D8B8.previous_struct = _id_11423199B914525B;

    if(isDefined(_id_11423199B914525B.previous_struct))
      _id_66FBACFA7822D8B8.antepenultimate_struct = _id_11423199B914525B.previous_struct;

    add_targetname_kvps(_id_66FBACFA7822D8B8, _id_11423199B914525B, _id_B530AB3549782A68);
    return _id_66FBACFA7822D8B8;
  }

  if(!isDefined(_id_66FBACFA7822D8B8)) {
    _id_66FBACFA7822D8B8 = step_back_to_last_good_branch(_id_11423199B914525B, _id_9284CBA34E9BF9AE);

    if(isDefined(_id_66FBACFA7822D8B8))
      add_targetname_kvps(_id_66FBACFA7822D8B8, _id_11423199B914525B, _id_B530AB3549782A68);
  }

  return _id_66FBACFA7822D8B8;
}

is_linked_struct(_id_B446FD2BE1399238, _id_7AF2B9581B2AED2D) {
  if(isDefined(_id_B446FD2BE1399238.script_linkto) && isDefined(_id_7AF2B9581B2AED2D.script_linkname)) {
    _id_B11F91C17FEEAB8F = _id_B446FD2BE1399238 scripts\engine\utility::get_links();

    foreach(_id_F2E2FCFB5787ED46 in _id_B11F91C17FEEAB8F) {
      if(_id_7AF2B9581B2AED2D.script_linkname == _id_F2E2FCFB5787ED46)
        return 1;
    }
  }

  return 0;
}

print_debug_info(struct, _id_0D305C3C2DE1B97A, _id_2C4FAF696B6CFDCA, _id_45F9A855D9BAAA6B, _id_4AE450CE67662CE0, _id_FB67CBAC762C0719) {
  self endon(_id_FB67CBAC762C0719);
  self endon("death");
  _id_8D01E03C5C561B39 = istrue(self.pathing_array[self.pathing_array.size - 1].was_branch);

  for(;;)
    waitframe();
}

get_veh_linked_structs() {
  array = [];

  if(isDefined(self.script_linkto)) {
    _id_B11F91C17FEEAB8F = scripts\engine\utility::get_links();

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B11F91C17FEEAB8F.size; _id_AC0E594AC96AA3A8++) {
      _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray(_id_B11F91C17FEEAB8F[_id_AC0E594AC96AA3A8], "script_linkname");

      if(_id_9E4E1482CB40C9C5.size > 0)
        array = scripts\engine\utility::array_combine(array, _id_9E4E1482CB40C9C5);
    }
  }

  return array;
}

calc_best_closest_struct(_id_11423199B914525B, _id_9284CBA34E9BF9AE, _id_9D96E50603F4C631) {
  _id_C409751F6400ECC2 = 1000000;
  _id_A743D2BF021F5457 = 360;
  _id_11FB9B6C76B5E4AE = -50;
  _id_66FBACFA7822D8B8 = undefined;
  _id_4BEC12517DD4B7E0 = 0.5;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_9D96E50603F4C631.size; _id_AC0E594AC96AA3A8++) {
    if(_id_9D96E50603F4C631[_id_AC0E594AC96AA3A8].origin == _id_11423199B914525B.origin)
      _id_11423199B914525B = _id_11423199B914525B.previous_struct;
  }

  _id_D31A2EE982E4801C = -5;
  _id_D2D5F9260F458419 = distance(_id_9284CBA34E9BF9AE.origin, _id_11423199B914525B.origin);

  foreach(_id_A34FF509B2F68B57 in _id_9D96E50603F4C631) {
    _id_0095A0D262B22644 = 5;
    _id_26BF31AC98D0A5D4 = 5;
    _id_E79809BD510FBD33 = 0;
    dot = undefined;
    score = -5;

    if(_id_A34FF509B2F68B57 == _id_11423199B914525B) {
      continue;
    }
    if(_id_A34FF509B2F68B57.origin == _id_11423199B914525B.origin) {
      continue;
    }
    if(isDefined(_id_11423199B914525B.previous_struct) && _id_11423199B914525B.previous_struct.origin == _id_A34FF509B2F68B57.origin) {
      continue;
    }
    if(isDefined(_id_11423199B914525B.antepenultimate_struct) && _id_11423199B914525B.antepenultimate_struct.origin == _id_A34FF509B2F68B57.origin) {
      continue;
    }
    if(isDefined(_id_A34FF509B2F68B57.script_noteworthy) && _id_A34FF509B2F68B57.script_noteworthy == "deleteme" && _id_A34FF509B2F68B57.origin != _id_9284CBA34E9BF9AE.origin) {
      continue;
    }
    if(!istrue(self.allow_unload_on_path) && isDefined(_id_A34FF509B2F68B57.script_unload) && _id_A34FF509B2F68B57.origin != _id_9284CBA34E9BF9AE.origin) {
      continue;
    }
    if(istrue(_id_A34FF509B2F68B57.disabled)) {
      continue;
    }
    if(check_all_previous_in_pathing(_id_A34FF509B2F68B57, 30)) {
      continue;
    }
    if(istrue(struct_is_personally_disabled(_id_A34FF509B2F68B57))) {
      continue;
    }
    _id_C8F2F4C482B5CA84 = distance(_id_11423199B914525B.origin, _id_A34FF509B2F68B57.origin);

    if(_id_A34FF509B2F68B57.origin == _id_9284CBA34E9BF9AE.origin && _id_C8F2F4C482B5CA84 > 1250) {
      continue;
    }
    _id_C8F2F4C482B5CA84 = distance(_id_9284CBA34E9BF9AE.origin, _id_A34FF509B2F68B57.origin);
    _id_FB156017C7455904 = vectortoangles(_id_9284CBA34E9BF9AE.origin - _id_11423199B914525B.origin);

    if(!isDefined(_id_11423199B914525B.angles))
      _id_11423199B914525B.angles = (0, 0, 0);

    _id_2C4FAF696B6CFDCA = scripts\engine\math::get_dot(_id_11423199B914525B.origin, _id_11423199B914525B.angles, _id_A34FF509B2F68B57.origin);
    _id_2C4FAF696B6CFDCA = scripts\engine\math::normalize_value(-0.5, 0.8, _id_2C4FAF696B6CFDCA);
    _id_0D305C3C2DE1B97A = scripts\engine\math::get_dot(_id_11423199B914525B.origin, _id_FB156017C7455904, _id_A34FF509B2F68B57.origin);
    _id_0D305C3C2DE1B97A = scripts\engine\math::normalize_value(-0.8, 0.8, _id_0D305C3C2DE1B97A);
    _id_AE9ECE2D695C9009 = scripts\engine\math::normalize_value(0, 2000, _id_C8F2F4C482B5CA84);
    _id_AE9ECE2D695C9009 = 1 - _id_AE9ECE2D695C9009;
    score = _id_2C4FAF696B6CFDCA + _id_0D305C3C2DE1B97A + _id_AE9ECE2D695C9009;

    if(_id_2C4FAF696B6CFDCA < 0.25)
      score = score - 10;

    if(0)
      thread print_debug_info(_id_A34FF509B2F68B57, _id_0D305C3C2DE1B97A, _id_2C4FAF696B6CFDCA, _id_C8F2F4C482B5CA84, score, "find_closest_path_struct");

    if(score > _id_11FB9B6C76B5E4AE) {
      _id_66FBACFA7822D8B8 = _id_A34FF509B2F68B57;
      _id_11FB9B6C76B5E4AE = score;
    }
  }

  if(!isDefined(_id_66FBACFA7822D8B8)) {}

  return _id_66FBACFA7822D8B8;
}

get_best_end_point(infil_name, _id_7DCE14FB8EAE79C2, _id_D5641E1E944F4C45) {
  if(isDefined(_id_7DCE14FB8EAE79C2.script_linkto)) {
    _id_72D387304F911195 = _id_7DCE14FB8EAE79C2 get_veh_linked_structs();

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_72D387304F911195.size; _id_AC0E594AC96AA3A8++) {
      if(scripts\engine\utility::is_equal(level.ai_spawn_vehicle_func[infil_name].exit_points, _id_72D387304F911195[_id_AC0E594AC96AA3A8].targetname))
        return _id_72D387304F911195[_id_AC0E594AC96AA3A8];
    }
  }

  _id_2B008B868CC6C2F7 = scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[infil_name].exit_points, "targetname");
  _id_E627E357CF133EAB = -5;
  _id_14BB0BB2B7D418D7 = undefined;
  _id_8631092C00D598F5 = scripts\engine\utility::get_array_of_closest(_id_7DCE14FB8EAE79C2.origin, _id_2B008B868CC6C2F7, [_id_7DCE14FB8EAE79C2]);

  if(isDefined(_id_7DCE14FB8EAE79C2.angles))
    _id_D5641E1E944F4C45 = _id_7DCE14FB8EAE79C2.angles;

  foreach(struct in _id_8631092C00D598F5) {
    dot = scripts\engine\math::get_dot(_id_7DCE14FB8EAE79C2.origin, _id_D5641E1E944F4C45, struct.origin);

    if(dot > _id_E627E357CF133EAB) {
      if(getdvarint("dvar_610414ECDFE9549F", 0))
        thread scripts\engine\utility::draw_capsule(struct.origin, 32, 32, (0, 0, 0), (1, 0, 0), 0, 250);

      _id_E627E357CF133EAB = dot;
      _id_14BB0BB2B7D418D7 = struct;
    }
  }

  return _id_14BB0BB2B7D418D7;
}

check_all_previous_in_pathing(_id_A34FF509B2F68B57, limit) {
  if(!isDefined(self.pathing_array))
    return 0;

  if(!isDefined(limit))
    limit = self.pathing_array.size;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < limit; _id_AC0E594AC96AA3A8++) {
    if(isDefined(self.pathing_array[_id_AC0E594AC96AA3A8]) && self.pathing_array[_id_AC0E594AC96AA3A8].origin == _id_A34FF509B2F68B57.origin)
      return 1;
  }

  return 0;
}

struct_is_personally_disabled(_id_A34FF509B2F68B57) {
  if(!isDefined(self.disabled_nodes))
    return 0;

  for(_id_AC0E5B4AC96AA80E = self.disabled_nodes.size - 1; _id_AC0E5B4AC96AA80E >= 0; _id_AC0E5B4AC96AA80E--) {
    if(self.disabled_nodes[_id_AC0E5B4AC96AA80E].origin == _id_A34FF509B2F68B57.origin)
      return 1;
  }

  return 0;
}

step_back_to_last_good_branch(_id_11423199B914525B, _id_9284CBA34E9BF9AE) {
  _id_66FBACFA7822D8B8 = undefined;
  _id_BF3B8C90FDEEB414 = undefined;
  _id_DF17D2E0402832DA = [];
  _id_0F5641ED3C3B1543 = 0;

  for(_id_AC0E594AC96AA3A8 = self.pathing_array.size - 1; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
    if(_id_0F5641ED3C3B1543 > 0) {
      break;
    }

    if(istrue(self.pathing_array[_id_AC0E594AC96AA3A8].was_branch)) {
      linkedto = self.pathing_array[_id_AC0E594AC96AA3A8] get_veh_linked_structs();

      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < linkedto.size; _id_AC0E5C4AC96AAA41++) {
        if(is_this_a_valid_node(linkedto[_id_AC0E5C4AC96AAA41]))
          _id_DF17D2E0402832DA[_id_DF17D2E0402832DA.size] = linkedto[_id_AC0E5C4AC96AAA41];
      }

      if(_id_DF17D2E0402832DA.size > 0) {
        if(_id_DF17D2E0402832DA.size == 1)
          _id_20B60C4020309035 = _id_DF17D2E0402832DA[0];
        else
          _id_20B60C4020309035 = calc_best_closest_struct(_id_11423199B914525B, _id_9284CBA34E9BF9AE, _id_DF17D2E0402832DA);

        _id_0F5641ED3C3B1543 = _id_AC0E594AC96AA3A8;
        _id_BF3B8C90FDEEB414 = _id_20B60C4020309035;

        if(istrue(0)) {}

        break;
      } else
        disable_this_node_for_us(self.pathing_array[_id_AC0E594AC96AA3A8]);

      continue;
    }

    disable_this_node_for_us(self.pathing_array[_id_AC0E594AC96AA3A8]);
  }

  if(isDefined(_id_11423199B914525B.previous_struct)) {
    if(isDefined(_id_BF3B8C90FDEEB414)) {
      _id_66FBACFA7822D8B8 = _id_BF3B8C90FDEEB414;

      if(isDefined(self.pathing_array[_id_0F5641ED3C3B1543 - 1]))
        _id_66FBACFA7822D8B8.previous_struct = self.pathing_array[_id_0F5641ED3C3B1543 - 1];

      if(isDefined(self.pathing_array[_id_0F5641ED3C3B1543 - 2]))
        _id_66FBACFA7822D8B8.antepenultimate_struct = self.pathing_array[_id_0F5641ED3C3B1543 - 2];
    } else
      _id_66FBACFA7822D8B8 = self.pathing_array[0];

    if(isDefined(_id_66FBACFA7822D8B8))
      _id_66FBACFA7822D8B8.rewinding_path = 1;
  }

  if(!isDefined(_id_66FBACFA7822D8B8)) {}

  return _id_66FBACFA7822D8B8;
}

is_this_a_valid_node(node) {
  if(istrue(node.disabled))
    return 0;

  for(_id_AC0E5B4AC96AA80E = self.pathing_array.size - 1; _id_AC0E5B4AC96AA80E >= 0; _id_AC0E5B4AC96AA80E--) {
    if(self.pathing_array[_id_AC0E5B4AC96AA80E].origin == node.origin)
      return 0;
  }

  for(_id_AC0E5B4AC96AA80E = self.disabled_nodes.size - 1; _id_AC0E5B4AC96AA80E >= 0; _id_AC0E5B4AC96AA80E--) {
    if(self.disabled_nodes[_id_AC0E5B4AC96AA80E].origin == node.origin)
      return 0;
  }

  return 1;
}

disable_this_node_for_us(node) {
  if(!isDefined(node)) {
    return;
  }
  if(!isDefined(self.disabled_nodes))
    self.disabled_nodes = [];

  if(scripts\engine\utility::array_contains(self.disabled_nodes, node)) {
    return;
  }
  self.disabled_nodes[self.disabled_nodes.size] = node;

  if(istrue(0)) {}

  level notify("kill_debug_" + node.pathing_index);
  self.pathing_array = scripts\engine\utility::array_remove(self.pathing_array, node);
}

create_direct_heli_path(infil_name) {
  self endon("death");
  _id_A9C45240836FE2A5 = create_direct_path_from_landing_point(infil_name);
  thread scripts\common\vehicle_paths::vehicle_paths_helicopter(_id_A9C45240836FE2A5);
}

adjust_angles_for_heli_path(_id_E4BFC6C39103117A, _id_C138766838237D11) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_E4BFC6C39103117A.size; _id_AC0E594AC96AA3A8++) {
    _id_AC0E5C4AC96AAA41 = _id_AC0E594AC96AA3A8 + 1;

    if(isDefined(_id_E4BFC6C39103117A[_id_AC0E5C4AC96AAA41])) {
      angles = vectortoangles(_id_E4BFC6C39103117A[_id_AC0E5C4AC96AAA41].origin - _id_E4BFC6C39103117A[_id_AC0E594AC96AA3A8].origin);
      _id_E4BFC6C39103117A[_id_AC0E594AC96AA3A8].angles = (0, angles[1], 0);
      continue;
    }

    angles = vectortoangles(_id_C138766838237D11.origin - _id_E4BFC6C39103117A[_id_AC0E594AC96AA3A8].origin);
    _id_E4BFC6C39103117A[_id_AC0E594AC96AA3A8].angles = (0, angles[1], 0);

    if(!isDefined(_id_C138766838237D11.angles) || _id_C138766838237D11.angles == (0, 0, 0))
      _id_C138766838237D11.angles = (0, angles[1], 0);

    break;
  }
}

create_direct_path_from_landing_point(infil_name) {
  _id_D15EA8815C13B619 = create_unique_kvp_string();
  _id_C4C70597EBB70938 = _id_D15EA8815C13B619;
  _id_C138766838237D11 = duplicate_struct(self.spawn_point);
  _id_C138766838237D11.targetname = _id_D15EA8815C13B619;
  scripts\cp\utility::addtostructarray("targetname", _id_C138766838237D11.targetname, _id_C138766838237D11);
  _id_E4BFC6C39103117A = [];

  if(isDefined(_id_C138766838237D11.script_linkto))
    _id_E4BFC6C39103117A = _id_C138766838237D11 build_path_from_script_linkTo(infil_name);

  if(_id_E4BFC6C39103117A.size > 0) {
    adjust_angles_for_heli_path(_id_E4BFC6C39103117A, _id_C138766838237D11);
    _id_66667D05B3903668 = self.spawn_point.origin;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.riders.size; _id_AC0E594AC96AA3A8++) {
      if(isalive(self.riders[_id_AC0E594AC96AA3A8]) && isai(self.riders[_id_AC0E594AC96AA3A8]))
        self.riders[_id_AC0E594AC96AA3A8] _id_18A73A64992DD07D::set_goal_pos(_id_66667D05B3903668);
    }

    if(getdvarint("dvar_610414ECDFE9549F", 0))
      thread scripts\engine\utility::draw_line_for_time(self.veh_spawn_point.origin, _id_E4BFC6C39103117A[0].origin, 1, 1, 1, 60);

    return _id_E4BFC6C39103117A[0];
  }

  if(isDefined(_id_C138766838237D11.script_linkname)) {
    _id_764BDB6FE546DACC = [];
    _id_FD605680DF0F71C6 = scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[infil_name].path_start_points, "script_linkname");

    if(!isDefined(_id_FD605680DF0F71C6) || _id_FD605680DF0F71C6.size < 1)
      _id_FD605680DF0F71C6 = scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[infil_name].path_start_points, "targetname");

    if(!isDefined(_id_FD605680DF0F71C6) || _id_FD605680DF0F71C6.size < 1) {
      return;
    }
    _id_F2E2FCFB5787ED46 = _id_C138766838237D11.script_linkname;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FD605680DF0F71C6.size; _id_AC0E594AC96AA3A8++) {
      if(scripts\engine\utility::is_equal(_id_FD605680DF0F71C6[_id_AC0E594AC96AA3A8].script_linkto, _id_F2E2FCFB5787ED46)) {
        _id_6D906809844C7CB1 = [];
        _id_4A97BF4DD0C4CFB3 = duplicate_struct(_id_FD605680DF0F71C6[_id_AC0E594AC96AA3A8]);
        _id_4A97BF4DD0C4CFB3.target = _id_C4C70597EBB70938;
        scripts\cp\utility::addtostructarray("target", _id_C4C70597EBB70938, _id_4A97BF4DD0C4CFB3);
        _id_4A97BF4DD0C4CFB3.targetname = create_unique_kvp_string();
        scripts\cp\utility::addtostructarray("targetname", _id_4A97BF4DD0C4CFB3.targetname, _id_4A97BF4DD0C4CFB3);
        _id_6D906809844C7CB1 = _id_4A97BF4DD0C4CFB3 get_linkto_structs_return_to_array(_id_6D906809844C7CB1, _id_FD605680DF0F71C6);

        if(_id_6D906809844C7CB1.size > 0)
          _id_764BDB6FE546DACC[_id_764BDB6FE546DACC.size] = _id_6D906809844C7CB1;
      }
    }

    if(_id_764BDB6FE546DACC.size > 0) {
      _id_7BBDA18A855C7111 = [];

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_764BDB6FE546DACC.size; _id_AC0E594AC96AA3A8++) {
        thread cleanup_unused_paths(_id_764BDB6FE546DACC[_id_AC0E594AC96AA3A8], _id_764BDB6FE546DACC[_id_AC0E594AC96AA3A8][_id_764BDB6FE546DACC[_id_AC0E594AC96AA3A8].size - 1]);
        _id_7BBDA18A855C7111[_id_7BBDA18A855C7111.size] = _id_764BDB6FE546DACC[_id_AC0E594AC96AA3A8][_id_764BDB6FE546DACC[_id_AC0E594AC96AA3A8].size - 1];

        if(getdvarint("dvar_610414ECDFE9549F", 0))
          thread scripts\engine\utility::draw_capsule(_id_764BDB6FE546DACC[_id_AC0E594AC96AA3A8][_id_764BDB6FE546DACC[_id_AC0E594AC96AA3A8].size - 1].origin, 32, 32, (0, 0, 0), (1, 0, 0), 0, 250);
      }

      _id_5160014CE4EC2684 = scripts\engine\math::get_mid_point(_id_C138766838237D11.origin, self.origin);

      if(getdvarint("dvar_610414ECDFE9549F", 0)) {
        thread scripts\engine\utility::draw_capsule(self.origin, 32, 32, (0, 0, 0), (0, 1, 0), 0, 250);
        thread scripts\engine\utility::draw_capsule(self.spawn_point.origin, 32, 32, (0, 0, 0), (0, 1, 0), 0, 250);
        thread scripts\engine\utility::draw_capsule(_id_5160014CE4EC2684, 32, 32, (0, 0, 0), (1, 1, 0), 0, 250);
      }

      _id_04769A2CAD76E31F = scripts\engine\utility::getclosest(_id_5160014CE4EC2684, _id_7BBDA18A855C7111);

      if(getdvarint("dvar_610414ECDFE9549F", 0))
        thread scripts\engine\utility::draw_line_for_time(_id_04769A2CAD76E31F.origin, self.origin, 1, 0, 0, 10);

      if(isDefined(_id_04769A2CAD76E31F.target)) {
        _id_24F98AF94D03218A = _id_04769A2CAD76E31F scripts\engine\utility::get_target_array();

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_24F98AF94D03218A.size; _id_AC0E594AC96AA3A8++) {
          if(getdvarint("dvar_610414ECDFE9549F", 0)) {
            thread scripts\engine\utility::draw_line_for_time(_id_04769A2CAD76E31F.origin, _id_24F98AF94D03218A[_id_AC0E594AC96AA3A8].origin, 1, 0, 0, 12.5);
            thread scripts\engine\utility::draw_capsule(_id_24F98AF94D03218A[_id_AC0E594AC96AA3A8].origin, 32, 32, (0, 0, 0), (0, 1, 1), 0, 250);
          }

          if(_id_AC0E594AC96AA3A8 >= _id_24F98AF94D03218A.size - 1) {
            if(getdvarint("dvar_610414ECDFE9549F", 0))
              thread scripts\engine\utility::draw_line_for_time(_id_C138766838237D11.origin, _id_24F98AF94D03218A[_id_AC0E594AC96AA3A8].origin, 1, 0, 0, 12.5);
          }
        }
      }

      if(getdvarint("dvar_610414ECDFE9549F", 0))
        thread scripts\engine\utility::draw_capsule(_id_04769A2CAD76E31F.origin, 32, 32, (0, 0, 0), (0, 1, 1), 0, 250);

      _id_04769A2CAD76E31F notify("path_chosen");
      self notify("path_chosen");
      return _id_04769A2CAD76E31F;
      return;
    }

    _id_764BDB6FE546DACC = [];
    _id_04769A2CAD76E31F = create_entrance_points(_id_C138766838237D11);

    if(isDefined(_id_04769A2CAD76E31F)) {
      _id_04769A2CAD76E31F.target = _id_C4C70597EBB70938;
      scripts\cp\utility::addtostructarray("target", _id_C4C70597EBB70938, _id_04769A2CAD76E31F);
      _id_04769A2CAD76E31F.targetname = create_unique_kvp_string();
      scripts\cp\utility::addtostructarray("targetname", _id_04769A2CAD76E31F.targetname, _id_04769A2CAD76E31F);

      if(getdvarint("dvar_610414ECDFE9549F", 0)) {
        thread scripts\engine\utility::draw_capsule(_id_04769A2CAD76E31F.origin, 32, 32, (0, 0, 0), (0, 1, 1), 0, 250);
        thread scripts\engine\utility::draw_capsule(_id_C138766838237D11.origin, 32, 32, (0, 0, 0), (0, 1, 0), 0, 250);
      }

      return _id_04769A2CAD76E31F;
      return;
    }

    return _id_C138766838237D11;
    return;
    return;
  } else
    return _id_C138766838237D11;
}

allow_deleteme_on_path(infil_name) {
  if(isDefined(level.vehicle_builds[infil_name]))
    return istrue(level.vehicle_builds[infil_name].allow_deleteme_path);
  else
    return 0;
}

build_path_from_script_linkTo(infil_name) {
  _id_E4BFC6C39103117A = [];
  _id_B69AA7B59AA1F9E2 = scripts\engine\utility::get_links();
  _id_11423199B914525B = undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B69AA7B59AA1F9E2.size; _id_AC0E594AC96AA3A8++) {
    _id_BFEFD376CFE6EA7C = _id_B69AA7B59AA1F9E2[_id_AC0E594AC96AA3A8];
    _id_72D387304F911195 = scripts\engine\utility::getStructArray(_id_BFEFD376CFE6EA7C, "script_linkname");

    if(isDefined(_id_72D387304F911195) && _id_72D387304F911195.size > 0) {
      _id_72D387304F911195 = scripts\engine\utility::array_randomize(_id_72D387304F911195);

      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_72D387304F911195.size; _id_AC0E5C4AC96AAA41++) {
        _id_10E8E4764F42A564 = _id_72D387304F911195[_id_AC0E5C4AC96AAA41];

        if(scripts\engine\utility::is_equal(_id_10E8E4764F42A564.targetname, "heli_spawner")) {
          continue;
        }
        if(!allow_deleteme_on_path(infil_name)) {
          if(scripts\engine\utility::is_equal(_id_10E8E4764F42A564.script_noteworthy, "deleteme"))
            continue;
        }

        _id_10E8E4764F42A564 = duplicate_struct(_id_10E8E4764F42A564);
        _id_E4BFC6C39103117A[_id_E4BFC6C39103117A.size] = _id_10E8E4764F42A564;
        _id_10E8E4764F42A564.targetname = create_unique_kvp_string();
        scripts\cp\utility::addtostructarray("targetname", _id_10E8E4764F42A564.targetname, _id_10E8E4764F42A564);

        if(isDefined(_id_11423199B914525B)) {
          if(getdvarint("dvar_610414ECDFE9549F", 0))
            thread scripts\engine\utility::draw_line_for_time(_id_11423199B914525B.origin, _id_10E8E4764F42A564.origin, 1, 1, 1, 60);

          _id_11423199B914525B.target = _id_10E8E4764F42A564.targetname;
          scripts\cp\utility::addtostructarray("target", _id_11423199B914525B.target, _id_11423199B914525B);
        }

        _id_11423199B914525B = _id_10E8E4764F42A564;
        break;
      }
    }
  }

  if(_id_E4BFC6C39103117A.size > 0) {
    _id_E4BFC6C39103117A[_id_E4BFC6C39103117A.size - 1].target = self.targetname;
    scripts\cp\utility::addtostructarray("target", _id_E4BFC6C39103117A[_id_E4BFC6C39103117A.size - 1].target, _id_E4BFC6C39103117A[_id_E4BFC6C39103117A.size - 1]);

    if(getdvarint("dvar_610414ECDFE9549F", 0))
      thread scripts\engine\utility::draw_line_for_time(_id_E4BFC6C39103117A[_id_E4BFC6C39103117A.size - 1].origin, self.origin, 1, 1, 1, 60);
  }

  return _id_E4BFC6C39103117A;
}

create_entrance_points(_id_C138766838237D11) {
  _id_E2C3188FEBED52F5 = [];
  _id_D5685B7BAEE6505E = _id_C138766838237D11.origin;

  if(scripts\engine\trace::capsule_trace_passed(_id_D5685B7BAEE6505E + (1500, 0, 1500), _id_D5685B7BAEE6505E, 256, 512, (0, 0, 0), level.characters)) {
    struct = spawnStruct();
    struct.origin = _id_D5685B7BAEE6505E + (1500, 0, 1500);
    _id_E2C3188FEBED52F5[_id_E2C3188FEBED52F5.size] = struct;
  }

  if(scripts\engine\trace::capsule_trace_passed(_id_D5685B7BAEE6505E + (-1500, 0, 1500), _id_D5685B7BAEE6505E, 256, 512, (0, 0, 0), level.characters)) {
    struct = spawnStruct();
    struct.origin = _id_D5685B7BAEE6505E + (-1500, 0, 1500);
    _id_E2C3188FEBED52F5[_id_E2C3188FEBED52F5.size] = struct;
  }

  if(scripts\engine\trace::capsule_trace_passed(_id_D5685B7BAEE6505E + (0, -1500, 1500), _id_D5685B7BAEE6505E, 256, 512, (0, 0, 0), level.characters)) {
    struct = spawnStruct();
    struct.origin = _id_D5685B7BAEE6505E + (0, -1500, 1500);
    _id_E2C3188FEBED52F5[_id_E2C3188FEBED52F5.size] = struct;
  }

  if(scripts\engine\trace::capsule_trace_passed(_id_D5685B7BAEE6505E + (0, 1500, 1500), _id_D5685B7BAEE6505E, 256, 512, (0, 0, 0), level.characters)) {
    struct = spawnStruct();
    struct.origin = _id_D5685B7BAEE6505E + (0, 1500, 1500);
    _id_E2C3188FEBED52F5[_id_E2C3188FEBED52F5.size] = struct;
  }

  if(scripts\engine\trace::capsule_trace_passed(_id_D5685B7BAEE6505E + (-1500, 1500, 1500), _id_D5685B7BAEE6505E, 256, 512, (0, 0, 0), level.characters)) {
    struct = spawnStruct();
    struct.origin = _id_D5685B7BAEE6505E + (-1500, 1500, 1500);
    _id_E2C3188FEBED52F5[_id_E2C3188FEBED52F5.size] = struct;
  }

  if(scripts\engine\trace::capsule_trace_passed(_id_D5685B7BAEE6505E + (-1500, -1500, 1500), _id_D5685B7BAEE6505E, 256, 512, (0, 0, 0), level.characters)) {
    struct = spawnStruct();
    struct.origin = _id_D5685B7BAEE6505E + (-1500, -1500, 1500);
    _id_E2C3188FEBED52F5[_id_E2C3188FEBED52F5.size] = struct;
  }

  if(scripts\engine\trace::capsule_trace_passed(_id_D5685B7BAEE6505E + (1500, -1500, 1500), _id_D5685B7BAEE6505E, 256, 512, (0, 0, 0), level.characters)) {
    struct = spawnStruct();
    struct.origin = _id_D5685B7BAEE6505E + (1500, -1500, 1500);
    _id_E2C3188FEBED52F5[_id_E2C3188FEBED52F5.size] = struct;
  }

  if(scripts\engine\trace::capsule_trace_passed(_id_D5685B7BAEE6505E + (1500, 1500, 1500), _id_D5685B7BAEE6505E, 256, 512, (0, 0, 0), level.characters)) {
    struct = spawnStruct();
    struct.origin = _id_D5685B7BAEE6505E + (1500, 1500, 1500);
    _id_E2C3188FEBED52F5[_id_E2C3188FEBED52F5.size] = struct;
  }

  _id_5160014CE4EC2684 = scripts\engine\math::get_mid_point(_id_C138766838237D11.origin, self.origin);

  if(getdvarint("dvar_610414ECDFE9549F", 0))
    thread scripts\engine\utility::draw_capsule(_id_5160014CE4EC2684, 32, 32, (0, 0, 0), (1, 1, 0), 0, 250);

  _id_04769A2CAD76E31F = scripts\engine\utility::getclosest(_id_5160014CE4EC2684, _id_E2C3188FEBED52F5);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_E2C3188FEBED52F5.size; _id_AC0E594AC96AA3A8++) {
    if(_id_E2C3188FEBED52F5[_id_AC0E594AC96AA3A8] != _id_04769A2CAD76E31F) {
      if(getdvarint("dvar_610414ECDFE9549F", 0))
        thread scripts\engine\utility::draw_capsule(_id_E2C3188FEBED52F5[_id_AC0E594AC96AA3A8].origin, 32, 32, (0, 0, 0), (1, 0, 0), 0, 250);
    }
  }

  return _id_04769A2CAD76E31F;
}

get_linkto_structs_return_to_array(_id_57D82443E81DBD5A, _id_5D99A225CB875DDA) {
  _id_57D82443E81DBD5A[_id_57D82443E81DBD5A.size] = self;

  if(isDefined(self.script_linkname)) {
    _id_F2E2FCFB5787ED46 = self.script_linkname;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_5D99A225CB875DDA.size; _id_AC0E594AC96AA3A8++) {
      if(_id_5D99A225CB875DDA[_id_AC0E594AC96AA3A8].origin == self.origin) {
        continue;
      }
      if(scripts\engine\utility::is_equal(_id_5D99A225CB875DDA[_id_AC0E594AC96AA3A8].script_linkto, _id_F2E2FCFB5787ED46)) {
        _id_104668542102DC3C = duplicate_struct(_id_5D99A225CB875DDA[_id_AC0E594AC96AA3A8]);
        _id_104668542102DC3C.target = self.targetname;
        scripts\cp\utility::addtostructarray("target", _id_104668542102DC3C.target, _id_104668542102DC3C);
        _id_104668542102DC3C.targetname = create_unique_kvp_string();
        scripts\cp\utility::addtostructarray("targetname", _id_104668542102DC3C.targetname, _id_104668542102DC3C);
        _id_57D82443E81DBD5A[_id_57D82443E81DBD5A.size] = _id_104668542102DC3C;
        _id_57D82443E81DBD5A = _id_104668542102DC3C get_linkto_structs_return_to_array(_id_57D82443E81DBD5A, _id_5D99A225CB875DDA);
      }
    }
  }

  return _id_57D82443E81DBD5A;
}

cleanup_unused_paths(_id_764BDB6FE546DACC, _id_04769A2CAD76E31F) {
  _id_04769A2CAD76E31F endon("path_chosen");
  self waittill("path_chosen");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_764BDB6FE546DACC.size; _id_AC0E594AC96AA3A8++)
    scripts\engine\utility::deletestruct_ref(_id_764BDB6FE546DACC[_id_AC0E594AC96AA3A8]);
}

create_heli_path(infil_name) {
  self.veh_path = [];
  counter = level.next_index;
  level.next_index++;
  _id_05BDA6F0ECAF2F49 = scripts\engine\utility::random(scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[infil_name].exit_points, "targetname"));
  end_point = duplicate_struct(_id_05BDA6F0ECAF2F49);
  self.end_point = end_point;
  thread begin_searching_for_landing_loc(undefined, infil_name, counter);
  scripts\engine\utility::thread_on_notify_no_endon_death("death", ::reset_spawn_point_targetname, self.spawn_point, undefined, self);
}

begin_searching_for_landing_loc(_id_CBD3F7020EC784E3, infil_name, counter) {
  level endon("game_ended");
  self endon("death");
  self notify("begin_searching_for_landing_loc");
  self endon("begin_searching_for_landing_loc");
  self endon("all_passengers_dead");
  _id_B1B8B417F4009BFD = undefined;
  _id_C138766838237D11 = undefined;
  _id_07B02A0C55EEDDF9 = undefined;
  _id_A414823CB904BF00 = undefined;

  for(;;) {
    _id_E031661B7146A294 = scripts\cp\utility::get_array_of_valid_players();

    if(!_id_E031661B7146A294.size) {
      wait 1;
      continue;
    }

    point = scripts\cp\utility::get_center_point_of_array(_id_E031661B7146A294);

    if(!isDefined(point))
      point = self.origin;

    if(isDefined(self.spawn_point)) {
      if(isDefined(self.spawn_point)) {}

      _id_8A69B1CCDC99BF9A = [self.spawn_point];
    } else
      _id_8A69B1CCDC99BF9A = sortbydistance(level.valid_air_vehicle_spawn_points, point);

    _id_B1B8B417F4009BFD = undefined;
    _id_EE9D695BAE6090D4 = 2048;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_8A69B1CCDC99BF9A.size; _id_AC0E594AC96AA3A8++) {
      landing_spot = _id_8A69B1CCDC99BF9A[_id_AC0E594AC96AA3A8];

      if(isDefined(landing_spot.radius) && landing_spot.radius > _id_EE9D695BAE6090D4)
        _id_EE9D695BAE6090D4 = int(landing_spot.radius);

      if(distance2dsquared(landing_spot.origin, point) <= _id_EE9D695BAE6090D4 * _id_EE9D695BAE6090D4) {
        _id_B1B8B417F4009BFD = landing_spot;
        break;
      }
    }

    if(isDefined(_id_B1B8B417F4009BFD)) {
      _id_EE9D695BAE6090D4 = 2048;

      if(isDefined(_id_B1B8B417F4009BFD.radius) && _id_B1B8B417F4009BFD.radius > _id_EE9D695BAE6090D4)
        _id_EE9D695BAE6090D4 = int(_id_B1B8B417F4009BFD.radius);

      if(distance2dsquared(_id_B1B8B417F4009BFD.origin, self.origin) <= _id_EE9D695BAE6090D4 * _id_EE9D695BAE6090D4) {
        level.valid_air_vehicle_spawn_points = scripts\engine\utility::array_remove(level.valid_air_vehicle_spawn_points, _id_B1B8B417F4009BFD);
        _id_C138766838237D11 = duplicate_struct(_id_B1B8B417F4009BFD);

        if(!isDefined(_id_B1B8B417F4009BFD.script_noteworthy))
          _id_C138766838237D11.targetname = "arrived_at_node_" + counter;
        else
          _id_C138766838237D11.targetname = _id_B1B8B417F4009BFD.script_noteworthy;

        thread scripts\common\vehicle_paths::vehicle_paths_helicopter(_id_C138766838237D11);
        self.landing_spot = _id_C138766838237D11;
        _id_16164552C155A2BC = (150, 150, 150);

        if(infil_name == "lbravo_ai_infil")
          _id_16164552C155A2BC = (90, 90, 90);

        self.nav_obstacle = createnavobstaclebybounds(_id_C138766838237D11.origin, _id_16164552C155A2BC, (0, 0, 0), "axis");
        thread delete_nav_obstacle_on_death();
        break;
      } else {
        _id_5C3EDFD13B3C67F0 = scripts\engine\utility::array_remove_array(level.path_points[infil_name], level.invalid_path_points);

        if(isDefined(_id_A414823CB904BF00))
          _id_5C3EDFD13B3C67F0 = scripts\engine\utility::array_remove(level.path_points[infil_name], _id_A414823CB904BF00);

        _id_CD529F062F8821F0 = get_best_hover_point(point, _id_5C3EDFD13B3C67F0);

        if(isDefined(_id_CD529F062F8821F0)) {
          _id_62D76F425463EED4 = duplicate_struct(_id_CD529F062F8821F0);

          if(!isDefined(_id_CD529F062F8821F0.script_noteworthy))
            _id_62D76F425463EED4.script_noteworthy = "arrived_at_node_" + counter;
          else
            _id_62D76F425463EED4.script_noteworthy = _id_CD529F062F8821F0.script_noteworthy;

          _id_62D76F425463EED4.radius = 512;

          if(!isDefined(_id_A414823CB904BF00) || _id_CD529F062F8821F0 != _id_A414823CB904BF00)
            thread scripts\common\vehicle_paths::vehicle_paths_helicopter(_id_62D76F425463EED4);

          _id_A414823CB904BF00 = _id_CD529F062F8821F0;
          level.invalid_path_points[level.invalid_path_points.size] = _id_CD529F062F8821F0;
          result = scripts\engine\utility::waittill_any_timeout_1(2.5, _id_62D76F425463EED4.script_noteworthy);

          if(result == "timeout")
            _id_A414823CB904BF00 = undefined;

          scripts\engine\utility::deletestruct_ref(_id_62D76F425463EED4);
          level.invalid_path_points = scripts\engine\utility::array_remove(level.invalid_path_points, _id_CD529F062F8821F0);
        } else
          wait 1;
      }

      continue;
    }

    _id_5C3EDFD13B3C67F0 = scripts\engine\utility::array_remove_array(level.path_points[infil_name], level.invalid_path_points);

    if(isDefined(_id_A414823CB904BF00))
      _id_5C3EDFD13B3C67F0 = scripts\engine\utility::array_remove(level.path_points[infil_name], _id_A414823CB904BF00);

    _id_CD529F062F8821F0 = get_best_hover_point(point, _id_5C3EDFD13B3C67F0);

    if(isDefined(_id_CD529F062F8821F0)) {
      _id_62D76F425463EED4 = duplicate_struct(_id_CD529F062F8821F0);

      if(!isDefined(_id_CD529F062F8821F0.script_noteworthy))
        _id_62D76F425463EED4.script_noteworthy = "arrived_at_node_" + counter;
      else
        _id_62D76F425463EED4.script_noteworthy = _id_CD529F062F8821F0.script_noteworthy;

      _id_62D76F425463EED4.radius = 512;

      if(!isDefined(_id_A414823CB904BF00) || _id_CD529F062F8821F0 != _id_A414823CB904BF00)
        thread scripts\common\vehicle_paths::vehicle_paths_helicopter(_id_62D76F425463EED4);

      _id_A414823CB904BF00 = _id_CD529F062F8821F0;
      level.invalid_path_points[level.invalid_path_points.size] = _id_CD529F062F8821F0;
      result = scripts\engine\utility::waittill_any_timeout_1(2.5, _id_62D76F425463EED4.script_noteworthy);

      if(result == "timeout")
        _id_A414823CB904BF00 = undefined;

      scripts\engine\utility::deletestruct_ref(_id_62D76F425463EED4);
      level.invalid_path_points = scripts\engine\utility::array_remove(level.invalid_path_points, _id_CD529F062F8821F0);
      continue;
    }

    wait 1;
  }

  self waittill("unloaded");

  if(!scripts\engine\utility::array_contains(level.valid_air_vehicle_spawn_points, _id_B1B8B417F4009BFD))
    level.valid_air_vehicle_spawn_points[level.valid_air_vehicle_spawn_points.size] = _id_B1B8B417F4009BFD;

  if(isDefined(_id_C138766838237D11))
    _id_07B02A0C55EEDDF9 = get_exit_route(_id_C138766838237D11, infil_name + counter + "_start");

  _id_05BDA6F0ECAF2F49 = scripts\engine\utility::random(scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[infil_name].exit_points, "targetname"));
  end_point = duplicate_struct(_id_05BDA6F0ECAF2F49);

  if(isDefined(_id_C138766838237D11) && isDefined(_id_07B02A0C55EEDDF9) && _id_07B02A0C55EEDDF9 != _id_C138766838237D11) {
    add_targetname_kvps(_id_07B02A0C55EEDDF9, _id_C138766838237D11, infil_name + counter + "_exit_path");
    add_targetname_kvps(end_point, _id_07B02A0C55EEDDF9, infil_name + counter + "_end");
    thread scripts\common\vehicle_paths::vehicle_paths_helicopter(_id_07B02A0C55EEDDF9);
  } else {
    add_targetname_kvps(end_point, _id_C138766838237D11, infil_name + counter + "_end");
    thread scripts\common\vehicle_paths::vehicle_paths_helicopter(end_point);
  }

  delete_nav_obstacle();
}

create_unique_kvp_string() {
  _id_9578950475CF30FC = get_next_free_num();
  return "unique_KVP_" + _id_9578950475CF30FC;
}

get_next_free_num() {
  counter = level.next_index;
  level.next_index++;
  return counter;
}

get_best_hover_point(point, _id_5C3EDFD13B3C67F0) {
  _id_5C3EDFD13B3C67F0 = sortbydistance(_id_5C3EDFD13B3C67F0, point);
  _id_E627E357CF133EAB = -5;
  _id_1FF54C0A7B87E99A = undefined;

  foreach(_id_A810DA8FF1A1DE67 in _id_5C3EDFD13B3C67F0) {
    dot = scripts\engine\math::get_dot(self.origin, self.angles, _id_A810DA8FF1A1DE67.origin);

    if(dot > 0)
      return _id_A810DA8FF1A1DE67;
  }

  return _id_1FF54C0A7B87E99A;
}

get_exit_route(starting_struct, _id_B530AB3549782A68) {
  current_struct = starting_struct;

  if(isDefined(current_struct.script_linkto)) {
    for(counter = 0; isDefined(current_struct.script_linkto); counter++) {
      _id_07B02A0C55EEDDF9 = scripts\engine\utility::random(current_struct get_veh_linked_structs());
      _id_07B02A0C55EEDDF9 = duplicate_struct(_id_07B02A0C55EEDDF9);
      add_targetname_kvps(_id_07B02A0C55EEDDF9, starting_struct, _id_B530AB3549782A68 + "_exit_route_" + counter);
      current_struct = _id_07B02A0C55EEDDF9;
    }
  }

  return current_struct;
}

add_targetname_kvps(_id_CED0426E7E729ED5, _id_8862E77985BBE111, _id_05C46335C60A76F0) {
  if(isDefined(_id_CED0426E7E729ED5)) {
    _id_CED0426E7E729ED5.targetname = _id_05C46335C60A76F0;
    scripts\cp\utility::addtostructarray("targetname", _id_05C46335C60A76F0, _id_CED0426E7E729ED5);

    if(isDefined(self.veh_path))
      self.veh_path[self.veh_path.size] = _id_CED0426E7E729ED5;
  }

  if(isDefined(_id_8862E77985BBE111)) {
    _id_8862E77985BBE111.target = _id_05C46335C60A76F0;
    scripts\cp\utility::addtostructarray("target", _id_05C46335C60A76F0, _id_8862E77985BBE111);

    if(isDefined(self.veh_path))
      self.veh_path[self.veh_path.size] = _id_8862E77985BBE111;
  }
}

duplicate_struct(_id_46B23510AA75285A) {
  struct = spawnStruct();
  struct.path_gobbler = 1;
  struct.origin = _id_46B23510AA75285A.origin;

  if(isDefined(_id_46B23510AA75285A.angles))
    struct.angles = _id_46B23510AA75285A.angles;
  else
    struct.angles = (0, 0, 0);

  if(isDefined(_id_46B23510AA75285A.script_unload))
    struct.script_unload = _id_46B23510AA75285A.script_unload;

  if(isDefined(_id_46B23510AA75285A.lookahead))
    struct.lookahead = _id_46B23510AA75285A.lookahead;

  if(isDefined(_id_46B23510AA75285A.speed))
    struct.speed = _id_46B23510AA75285A.speed;
  else
    struct.speed = 2000;

  if(isDefined(_id_46B23510AA75285A.start_node))
    struct.start_node = _id_46B23510AA75285A.start_node;

  if(isDefined(_id_46B23510AA75285A.script_noteworthy))
    struct.script_noteworthy = _id_46B23510AA75285A.script_noteworthy;

  if(isDefined(_id_46B23510AA75285A.script_linkname))
    struct.script_linkname = _id_46B23510AA75285A.script_linkname;

  if(isDefined(_id_46B23510AA75285A.script_linkto))
    struct.script_linkto = _id_46B23510AA75285A.script_linkto;

  if(isDefined(_id_46B23510AA75285A.script_brake))
    struct.script_brake = _id_46B23510AA75285A.script_brake;

  if(isDefined(_id_46B23510AA75285A.script_pathtype))
    struct.script_pathtype = _id_46B23510AA75285A.script_pathtype;

  if(isDefined(_id_46B23510AA75285A.script_goalyaw))
    struct.script_goalyaw = _id_46B23510AA75285A.script_goalyaw;

  if(isDefined(_id_46B23510AA75285A.script_anglevehicle))
    struct.script_anglevehicle = _id_46B23510AA75285A.script_anglevehicle;

  if(isDefined(_id_46B23510AA75285A.radius))
    struct.radius = _id_46B23510AA75285A.radius;
  else
    struct.radius = 512;

  return struct;
}

delete_nav_obstacle() {
  if(isDefined(self.nav_obstacle))
    destroynavobstacle(self.nav_obstacle);

  if(isDefined(self.spawn_point))
    self.spawn_point _id_18A73A64992DD07D::_id_EC648F2C89EA1C91();
}

activate_vehicle_spawner(veh_spawn_point, spawn_point, vehicle, group) {
  if(isDefined(group))
    group.recently_spawned_vehicle = undefined;

  _id_D5D036F9232893BA = 1;

  if(isDefined(vehicle)) {
    if(vehicle get_vehicle_riders() < 1)
      _id_D5D036F9232893BA = 0;
  }

  if(isDefined(veh_spawn_point))
    veh_spawn_point toggle_in_use(0);

  if(isDefined(spawn_point)) {
    if(_id_D5D036F9232893BA)
      spawn_point _id_18A73A64992DD07D::enable_spawner();
    else if(isDefined(vehicle))
      vehicle enable_spawner_after_vehicle_death(spawn_point);
  }

  reset_spawn_point_targetname(spawn_point);

  if(isDefined(vehicle)) {
    if(isDefined(vehicle.veh_spawn_point))
      vehicle.veh_spawn_point = undefined;
  }
}

enable_spawner_after_vehicle_death(spawn_point) {
  self waittill("death");
  spawn_point _id_18A73A64992DD07D::enable_spawner();
}

delete_nav_obstacle_on_death() {
  self waittill("death");
  delete_nav_obstacle();
}

decrement_vehicles_active(infil_name, group) {
  self notify("decrement_vehicles_active");
  self endon("decrement_vehicles_active");
  level endon("game_ended");
  veh_spawn_point = self.veh_spawn_point;
  spawn_point = self.spawn_point;
  result = scripts\engine\utility::waittill_any_return_2("death", "unloaded");
  level scripts\engine\utility::delaythread(5, ::activate_vehicle_spawner, veh_spawn_point, spawn_point, self, group);
  level.all_spawned_vehicles = scripts\engine\utility::array_remove(level.all_spawned_vehicles, self);
  level.ai_spawn_vehicle_func[infil_name].count--;

  if(isDefined(self.veh_spawn_point) && isDefined(self.veh_spawn_point.script_vehiclegroup)) {
    _id_24F98AF94D03218A = scripts\engine\utility::getStructArray(self.veh_spawn_point.script_vehiclegroup, "targetname");

    foreach(_id_E93ABDCF64B7D8EF in _id_24F98AF94D03218A)
    _id_E93ABDCF64B7D8EF.disabled = undefined;
  }

  if(isDefined(self.veh_spawn_point))
    self.veh_spawn_point.in_use = undefined;

  self.veh_spawn_point = undefined;
}

reset_spawn_point_targetname(spawn_point) {
  if(!isDefined(spawn_point) && isDefined(self.spawn_point))
    spawn_point = self.spawn_point;

  if(isDefined(spawn_point)) {
    spawn_point.ai_infil_type = undefined;

    if(isDefined(spawn_point.og_script_function))
      spawn_point.script_function = spawn_point.og_script_function;

    spawn_point = undefined;
  }

  if(isDefined(self) && isDefined(self.veh_path))
    scripts\engine\utility::deletestructarray_ref(self.veh_path);

  if(isDefined(self) && isDefined(self.pathing_array))
    scripts\engine\utility::deletestructarray_ref(self.pathing_array);
}

clear_kill_off_flags(guy) {
  if(istrue(guy.skip_clear_kill_off_flag)) {
    return;
  }
  guy.killofftime = gettime() + 20000;
  guy.dontkilloff = undefined;
  guy.canshootinvehicle = 1;
  guy.ignoreall = 0;

  if(isDefined(guy.vehicle) && isDefined(guy.vehicle.landing_spot))
    guy _id_18A73A64992DD07D::node_fields_pre_goal(guy.vehicle.landing_spot);

  if(isDefined(guy.demeanoroverride) && guy.demeanoroverride == "casual") {
    guy _id_18A73A64992DD07D::set_demeanor_from_unittype("patrol");
    guy _id_18A73A64992DD07D::set_goal_pos(guy.origin);
    guy thread _id_18A73A64992DD07D::start_patrol();
  } else {
    guy _id_18A73A64992DD07D::set_goal_pos(guy.origin);
    _id_C729D49D406ACED8 = guy scripts\cp\utility::get_closest_living_player();

    if(isDefined(_id_C729D49D406ACED8))
      guy _id_18A73A64992DD07D::set_goal_pos(_id_C729D49D406ACED8.origin);

    guy _id_18A73A64992DD07D::enter_combat();
  }
}

get_invalid_seats_from_module_struct(_id_F8E5E3AA5762A8E7, infil_name) {
  if(isDefined(_id_F8E5E3AA5762A8E7) && isDefined(infil_name)) {
    if(!isDefined(_id_F8E5E3AA5762A8E7.vehicle_invalid_seats)) {
      return;
    }
    if(!isDefined(_id_F8E5E3AA5762A8E7.vehicle_invalid_seats[infil_name])) {
      return;
    }
    return _id_F8E5E3AA5762A8E7.vehicle_invalid_seats[infil_name];
  } else
    return undefined;
}

get_valid_seats(_id_F8E5E3AA5762A8E7, infil_name) {
  if(isDefined(_id_F8E5E3AA5762A8E7) && isDefined(infil_name)) {
    _id_21D08B20AE007765 = get_invalid_seats_from_module_struct(_id_F8E5E3AA5762A8E7, infil_name);

    if(!isDefined(_id_21D08B20AE007765))
      _id_21D08B20AE007765 = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.usedpositions.size; _id_AC0E594AC96AA3A8++) {
      if(self.usedpositions[_id_AC0E594AC96AA3A8]) {
        continue;
      }
      _id_DFCE408C92A4BBDD = 1;

      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_21D08B20AE007765.size; _id_AC0E5C4AC96AAA41++) {
        if(_id_21D08B20AE007765[_id_AC0E5C4AC96AAA41] == _id_AC0E594AC96AA3A8) {
          _id_DFCE408C92A4BBDD = 0;
          break;
        }
      }

      if(_id_DFCE408C92A4BBDD)
        return _id_AC0E594AC96AA3A8;
    }
  }

  return -1;
}

send_notify_after_player_tac_vis(_id_FF5CCEDE2521CB13) {
  if(isDefined(_id_FF5CCEDE2521CB13)) {
    return;
  }
  for(;;) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      if(hastacvis(level.players[_id_AC0E594AC96AA3A8] getEye(), self.origin + (0, 0, 56))) {
        break;
      }
    }

    wait 0.1;
  }

  self notify(_id_FF5CCEDE2521CB13);
}

allow_infil_after_full_or_timeout(_id_F8E5E3AA5762A8E7, infil_name) {
  self notify("allow_infil_after_full_or_timeout");
  self endon("allow_infil_after_full_or_timeout");
  self endon("death");
  self endon("spawning_done");
  level endon("game_ended");
  max_ai = get_max_ai_from_infil_name(_id_F8E5E3AA5762A8E7, infil_name);

  if(isDefined(level.ai_spawn_vehicle_func[infil_name].max_wait_for_infil))
    scripts\engine\utility::waittill_any_timeout_1(level.ai_spawn_vehicle_func[infil_name].max_wait_for_infil, "stop_waiting_for_spawns");

  if(isDefined(max_ai)) {
    if(self.attachedguys.size == max_ai || isDefined(self.load_queue) && self.load_queue.size == max_ai) {
      self notify("spawning_done");
      return;
    } else {
      childthread send_notify_after_player_tac_vis("spawning_done");

      if(isDefined(self.group))
        self.group scripts\engine\utility::waittill_any_timeout_1(3, "death");
      else
        wait 3;

      self notify("spawning_done");
    }
  }

  if(isDefined(self.load_queue) && self.load_queue.size > 0)
    self notify("spawning_done");
  else if(self.attachedguys.size < 1) {
    scripts\common\vehicle_code::vehicle_deathcleanup();
    scripts\common\vehicle_paths::delete_riders();
    self notify("delete");
    self delete();
  } else
    self notify("spawning_done");
}

register_combined_vehicles(_id_C7813BD63C9BA2E4, model, type, classname, _id_12628BD52433B570, alias, _id_AD42C731F2AFF73C) {
  [[_id_C7813BD63C9BA2E4]](model, type, classname);
  level thread register_combined_vehicles_threaded(_id_C7813BD63C9BA2E4, model, type, classname, _id_12628BD52433B570, alias, _id_AD42C731F2AFF73C);
}

register_combined_vehicles_threaded(_id_C7813BD63C9BA2E4, model, type, classname, _id_12628BD52433B570, alias, _id_AD42C731F2AFF73C, _id_ABB7BDD43400A0C7) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  register_vehicle_build(_id_AD42C731F2AFF73C, model, type, classname, _id_AD42C731F2AFF73C);
  struct = spawnStruct();
  copy_vehicle_build_to_spawnpoint(alias, struct);

  if(struct scripts\common\vehicle::ishelicopter()) {
    add_ai_air_infil(alias);
    register_vehicle_spawn(alias, 10, 10, undefined, "heli_spawner", "heli_exit", "heli_infil_path", undefined, ::veh_heli_spawn, _id_AD42C731F2AFF73C);
    register_spawner_script_function(alias, ::_id_64F6B6424352BC68);
  } else {
    add_ai_ground_infil(alias);
    register_vehicle_spawn(alias, 10, 10, undefined, "ai_ground_veh_spawner", "ground_veh_exit", "ground_veh_infil_path", undefined, ::veh_ground_veh_spawn, _id_AD42C731F2AFF73C);
    register_spawner_script_function(alias, ::ai_ground_veh_spawn);
  }

  register_vehicle_max_ai(_id_AD42C731F2AFF73C, model, type, classname, _id_12628BD52433B570);
  vehicle_build = level.vehicle.templates.aianims[classname];
  _id_3C435505038F3D9C = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < vehicle_build.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(vehicle_build[_id_AC0E594AC96AA3A8].idle_anim))
      _id_3C435505038F3D9C++;
  }

  if(_id_3C435505038F3D9C > 0)
    register_vehicle_spawn_drivers(alias, _id_3C435505038F3D9C, scripts\engine\utility::random(["aq_pilot_fullbody_1", "aq_pilot_fullbody_2"]));

  if(isDefined(_id_12628BD52433B570) && getdvarint("dvar_CA67D9F39E1DD86F", 0))
    create_mp_version_of_vehicle(_id_12628BD52433B570, classname, _id_AD42C731F2AFF73C);

  level notify(alias);
}

create_mp_version_of_vehicle(_id_12628BD52433B570, classname, _id_AD42C731F2AFF73C) {
  if(!isDefined(_id_12628BD52433B570)) {
    return;
  }
  if(!isDefined(level.vehicle)) {
    return;
  }
  struct = level.vehicle_builds[_id_AD42C731F2AFF73C];
  struct.vehiclename = _id_AD42C731F2AFF73C;
  create_vehicle_vehicledata(_id_12628BD52433B570, classname, _id_AD42C731F2AFF73C);
  create_vehicle_occupancy_data(_id_12628BD52433B570, classname, _id_AD42C731F2AFF73C);
  create_vehicle_interact(_id_12628BD52433B570, classname, _id_AD42C731F2AFF73C);
  create_vehicle_omnvars_data(_id_12628BD52433B570, classname, _id_AD42C731F2AFF73C);
}

create_vehicle_interact(_id_12628BD52433B570, classname, _id_AD42C731F2AFF73C) {
  if(!isDefined(level.vehicle.interact)) {
    return;
  }
  if(!isDefined(level.vehicle.interact.vehicledata)) {
    return;
  }
  if(isDefined(level.vehicle.interact.vehicledata[_id_12628BD52433B570]) && !isDefined(level.vehicle.interact.vehicledata[_id_AD42C731F2AFF73C])) {
    if(isDefined(level.vehicle.templates.aianims[classname])) {
      _id_E2818AD39A3341B4 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle(_id_AD42C731F2AFF73C, 1);

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.vehicle.templates.aianims[classname].size; _id_AC0E594AC96AA3A8++) {
        struct = level.vehicle.templates.aianims[classname][_id_AC0E594AC96AA3A8];
        sittag = tolower(struct.sittag);
        _id_E2818AD39A3341B4.seatenterarrays[sittag] = [];
        _id_E2818AD39A3341B4.seatenterarrays[sittag][_id_E2818AD39A3341B4.seatenterarrays[sittag].size] = sittag;
        _id_0C50B485A43752FD = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(_id_AD42C731F2AFF73C, sittag, 1);

        if(_id_AC0E594AC96AA3A8 == 0) {
          _id_7432B7FB4C69781F = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle(_id_AD42C731F2AFF73C, 1);
          _id_7432B7FB4C69781F.driverseatid = sittag;
        }
      }

      level.vehicle.interact.vehicledata[_id_AD42C731F2AFF73C] = _id_E2818AD39A3341B4;
    }
  }
}

create_vehicle_vehicledata(_id_12628BD52433B570, classname, _id_AD42C731F2AFF73C) {
  if(!isDefined(level.vehicle.vehicledata)) {
    return;
  }
  if(isDefined(level.vehicle.vehicledata[_id_12628BD52433B570]) && !isDefined(level.vehicle.vehicledata[_id_AD42C731F2AFF73C])) {
    _id_E2818AD39A3341B4 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle(_id_AD42C731F2AFF73C);
    _id_E2818AD39A3341B4.destroycallback = level.vehicle.vehicledata[_id_12628BD52433B570].destroycallback;
    level.vehicle.vehicledata[_id_AD42C731F2AFF73C] = _id_E2818AD39A3341B4;
  }
}

create_vehicle_omnvars_data(_id_12628BD52433B570, classname, _id_AD42C731F2AFF73C) {
  if(!isDefined(level.vehicle.omnvars.vehicledata)) {
    return;
  }
  if(isDefined(level.vehicle.omnvars.vehicledata[_id_12628BD52433B570]) && !isDefined(level.vehicle.omnvars.vehicledata[_id_AD42C731F2AFF73C])) {
    _id_E2818AD39A3341B4 = scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_getleveldataforvehicle(_id_AD42C731F2AFF73C, 1);
    _id_EE8A4198EC7E827C = scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_getleveldataforvehicle(_id_12628BD52433B570);
    _id_E2818AD39A3341B4.ammoids = _id_EE8A4198EC7E827C.ammoids;
    _id_E2818AD39A3341B4.id = _id_EE8A4198EC7E827C.id;
    _id_E2818AD39A3341B4.rotationids = _id_EE8A4198EC7E827C.rotationids;
    _id_E2818AD39A3341B4.seatids = _id_EE8A4198EC7E827C.seatids;
    _id_E2818AD39A3341B4.warningbits = _id_EE8A4198EC7E827C.warningbits;
    _id_E2818AD39A3341B4.warningclearcallbacks = _id_EE8A4198EC7E827C.warningclearcallbacks;
    _id_E2818AD39A3341B4.warningendcallbacks = _id_EE8A4198EC7E827C.warningendcallbacks;
    _id_E2818AD39A3341B4.warningstartcallbacks = _id_EE8A4198EC7E827C.warningstartcallbacks;
    level.vehicle.omnvars.vehicledata[_id_AD42C731F2AFF73C] = _id_E2818AD39A3341B4;
  }
}

create_seatids_override(_id_AD42C731F2AFF73C, seatids) {
  if(!isDefined(level.vehicle.omnvars.vehicledata)) {
    return;
  }
  if(isDefined(level.vehicle.omnvars.vehicledata[_id_AD42C731F2AFF73C])) {
    _id_E2818AD39A3341B4 = scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_getleveldataforvehicle(_id_AD42C731F2AFF73C, 1);
    _id_7432B7FB4C69781F = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle(_id_AD42C731F2AFF73C);
    _id_E2818AD39A3341B4.seatids = [];
    keys = getarraykeys(_id_7432B7FB4C69781F.seatdata);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < keys.size; _id_AC0E594AC96AA3A8++)
      _id_E2818AD39A3341B4.seatids[keys[_id_AC0E594AC96AA3A8]] = seatids[_id_AC0E594AC96AA3A8];

    level.vehicle.omnvars.vehicledata[_id_AD42C731F2AFF73C] = _id_E2818AD39A3341B4;
  }
}

create_vehicle_occupancy_data(_id_12628BD52433B570, classname, _id_AD42C731F2AFF73C) {
  if(!isDefined(level.vehicle.occupancy.vehicledata)) {
    return;
  }
  if(isDefined(level.vehicle.occupancy.vehicledata[_id_12628BD52433B570]) && !isDefined(level.vehicle.occupancy.vehicledata[_id_AD42C731F2AFF73C])) {
    _id_E2818AD39A3341B4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle(_id_AD42C731F2AFF73C, 1);
    _id_E2818AD39A3341B4.camera = level.vehicle.occupancy.vehicledata[_id_12628BD52433B570].camera;
    _id_E2818AD39A3341B4.damagefeedbackgroupheavy = level.vehicle.occupancy.vehicledata[_id_12628BD52433B570].damagefeedbackgroupheavy;
    _id_E2818AD39A3341B4.damagefeedbackgrouplight = level.vehicle.occupancy.vehicledata[_id_12628BD52433B570].damagefeedbackgrouplight;
    _id_E2818AD39A3341B4.damagemodifier = level.vehicle.occupancy.vehicledata[_id_12628BD52433B570].damagemodifier;
    _id_E2818AD39A3341B4.enterendcallback = level.vehicle.occupancy.vehicledata[_id_12628BD52433B570].enterendcallback;
    _id_E2818AD39A3341B4.enterstartcallback = level.vehicle.occupancy.vehicledata[_id_12628BD52433B570].enterstartcallback;
    _id_E2818AD39A3341B4.exitdirections = level.vehicle.occupancy.vehicledata[_id_12628BD52433B570].exitdirections;
    _id_E2818AD39A3341B4.exitendcallback = level.vehicle.occupancy.vehicledata[_id_12628BD52433B570].exitendcallback;
    _id_E2818AD39A3341B4.exitextents = level.vehicle.occupancy.vehicledata[_id_12628BD52433B570].exitextents;
    _id_E2818AD39A3341B4.exitoffsets = level.vehicle.occupancy.vehicledata[_id_12628BD52433B570].exitoffsets;
    _id_E2818AD39A3341B4.exitstartcallback = level.vehicle.occupancy.vehicledata[_id_12628BD52433B570].exitstartcallback;
    _id_E2818AD39A3341B4.restrictions = level.vehicle.occupancy.vehicledata[_id_12628BD52433B570].restrictions;
    _id_E2818AD39A3341B4.threatbiasgroup = level.vehicle.occupancy.vehicledata[_id_12628BD52433B570].threatbiasgroup;
    level.vehicle.occupancy.vehicledata[_id_AD42C731F2AFF73C] = _id_E2818AD39A3341B4;
  }
}

register_seat_data_for_vehicle(_id_AD42C731F2AFF73C, seatid, seatswitcharray, animtag, exitids, exitoffsets, exitdirections, spawnpriority) {
  if(!isDefined(level.vehicle)) {
    return;
  }
  if(!isDefined(level.vehicle.occupancy.vehicledata)) {
    return;
  }
  if(!isDefined(!isDefined(level.vehicle.occupancy.vehicledata[_id_AD42C731F2AFF73C]))) {
    return;
  }
  register_seat_data(_id_AD42C731F2AFF73C, seatid, seatswitcharray, animtag, exitids, exitoffsets, exitdirections, spawnpriority);
}

register_seat_data(_id_AD42C731F2AFF73C, seatid, seatswitcharray, animtag, exitids, exitoffsets, exitdirections, spawnpriority) {
  _id_E2818AD39A3341B4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle(_id_AD42C731F2AFF73C, 1);
  _id_0C50B485A43752FD = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(_id_AD42C731F2AFF73C, seatid, 1);
  _id_0C50B485A43752FD.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(seatid, seatswitcharray);
  _id_0C50B485A43752FD.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  _id_0C50B485A43752FD.damagemodifier = 0.5;
  _id_0C50B485A43752FD.animtag = animtag;
  _id_0C50B485A43752FD.exitids = exitids;
  _id_E2818AD39A3341B4.exitoffsets[seatid] = exitoffsets;
  _id_E2818AD39A3341B4.exitdirections[seatid] = exitdirections;
  _id_0C50B485A43752FD.spawnpriority = 10;
}

register_techo_seat_data(_id_AD42C731F2AFF73C) {
  seatswitcharray = ["tag_driver", "tag_passenger", "tag_bed1", "tag_bed2", "tag_bed_center"];
  _id_F079DDD1216D5051 = ["tag_seat_0", "tag_seat_2", "tag_seat_4", "tag_seat_4", "tag_seat_4", "tag_seat_3", "tag_seat_5"];
  _id_F29D65B6397BA222 = seatswitcharray;
  exitids = [];
  exitoffsets = (5, 14, 55);
  exitdirections = "left";
  spawnpriority = 10;

  if(isDefined(level.vehicle.interact.vehicledata[_id_AD42C731F2AFF73C]) && isDefined(isDefined(level.vehicle.interact.vehicledata[_id_AD42C731F2AFF73C].seatenterarrays))) {
    keys = getarraykeys(level.vehicle.interact.vehicledata[_id_AD42C731F2AFF73C].seatenterarrays);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.vehicle.interact.vehicledata[_id_AD42C731F2AFF73C].seatenterarrays.size; _id_AC0E594AC96AA3A8++) {
      seatid = keys[_id_AC0E594AC96AA3A8];
      exitids = scripts\engine\utility::array_add(_id_F29D65B6397BA222, seatid);
      register_seat_data_for_vehicle(_id_AD42C731F2AFF73C, seatid, seatswitcharray, _id_F079DDD1216D5051[_id_AC0E594AC96AA3A8], exitids, exitoffsets, exitdirections, spawnpriority);
    }
  }
}

_id_B7229E2DCB171037(_id_E4B7E99A96C8829F) {
  return _id_7E79F1B51303070F(_id_E4B7E99A96C8829F);
}

#using_animtree("mp_vehicles_always_loaded");

_id_7E79F1B51303070F(_id_E4B7E99A96C8829F) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_E4B7E99A96C8829F.size; _id_AC0E594AC96AA3A8++)
    _id_E4B7E99A96C8829F[_id_AC0E594AC96AA3A8].vehicle_getoutanim = % vh_blima_rappel_heli_drop;

  return _id_E4B7E99A96C8829F;
}

vehicle_registrations(_id_BEA6BC73152D0EA9, blima, _id_63AA4575D7EB8D8D) {
  level._id_B7229E2DCB171037 = [];
  level._id_B7229E2DCB171037["mindia8"] = ::_id_B7229E2DCB171037;
  level._id_B7229E2DCB171037["blima"] = ::_id_B7229E2DCB171037;
  scripts\vehicle\mindia8::main("veh8_mil_air_ahotel64_ks", "veh_apache_cp", "script_vehicle_apache");
  scripts\vehicle\mindia8::main("veh8_mil_air_ahotel64_ks_east_mp", "veh_apache_cp", "script_vehicle_apache_east");
  register_vehicle_build("attack_heli_west", "veh8_mil_air_ahotel64_ks", "veh_apache_cp", "script_vehicle_apache");
  register_vehicle_build("attack_heli", "veh8_mil_air_ahotel64_ks_east_mp", "veh_apache_cp", "script_vehicle_apache_east");
  create_rocket_death_fx("script_vehicle_apache");
  create_rocket_death_fx("script_vehicle_apache_east");
  level thread create_ambient_vehicle("lbravo_ambient", "veh8_mil_air_lbravo_personnel_cp", "lbravo_infil_cp", "script_vehicle_iw8_lbravo_ambient");
  register_combined_vehicles(scripts\vehicle\lbravo::main, "veh8_mil_air_lbravo_personnel_cp", "lbravo_infil_cp", "script_vehicle_iw8_lbravo_ambient", undefined, "lbravo_ambient", "lbravo_ambient");
  register_combined_vehicles(scripts\vehicle\lbravo::main, "veh8_mil_air_lbravo", "lbravo_infil_cp", "script_vehicle_iw8_lbravo_guns", undefined, "lbravo_guns", "lbravo_guns");
  register_combined_vehicles(scripts\vehicle\lbravo::main, "veh8_mil_air_lbravo_east", "lbravo_infil_cp", "script_vehicle_iw8_lbravo_guns_east", undefined, "lbravo_guns_east", "lbravo_guns_east");
  register_combined_vehicles(scripts\vehicle\lbravo::main, "veh8_mil_air_lbravo", "lbravo_infil_cp", "script_vehicle_iw8_lbravo", undefined, "lbravo", "lbravo");
  register_combined_vehicles(scripts\vehicle\lbravo::main, "veh8_mil_air_lbravo_personnel_cp", "lbravo_infil_cp", "script_vehicle_iw8_lbravo_carrier", undefined, "lbravo_carrier", "lbravo_carrier");
  register_combined_vehicles(scripts\vehicle\lbravo::main, "veh8_mil_air_lbravo_east", "lbravo_infil_cp", "script_vehicle_iw8_lbravo_carrier_east", undefined, "lbravo_carrier_east", "lbravo_carrier_east");
  register_combined_vehicles(scripts\vehicle\lbravo::main, "veh8_mil_air_lbravo", "lbravo_infil_cp", "script_vehicle_iw8_lbravo_ai_infil", undefined, "lbravo_ai_infil", "lbravo_ai_infil");
  register_combined_vehicles(scripts\vehicle\blima::main, "veh9_mil_air_heli_blima_cp", "blima_cp", "script_vehicle_blima", undefined, "blima_exfil", "blima_exfil");
  register_combined_vehicles(scripts\vehicle\blima::main, "veh9_mil_air_heli_blima_cp", "blima_cp", "script_vehicle_iw8_blima", undefined, "blima_exfil", "blima_exfil");
  register_combined_vehicles(scripts\vehicle\blima::main, "veh9_mil_air_heli_blima_cp", "blima_cp", "script_vehicle_iw8_blima_cp", undefined, "blima", "blima");
  register_combined_vehicles(_id_41BDAAC71BFAC699::main, "veh8_mil_sea_zoscar_cine_physics", "zoscar_physics", "script_vehicle_iw8_zoscar_physics_mp", undefined, "zoscar", "zoscar");

  if(getDvar("ui_mapname") == "cp_hydro") {
    register_combined_vehicles(scripts\vehicle\mindia8::main, "veh8_mil_air_mindia8", "mindia8_cp", "script_vehicle_iw8_mindia8_closed", undefined, "mindia8_closed", "mindia8_closed");
    register_combined_vehicles(scripts\vehicle\mindia8::main, "veh9_mil_air_heli_palfa_doors_open_vehphys_mp", "mindia8_cp", "script_vehicle_iw8_mindia8", undefined, "mindia8", "mindia8");
  } else {
    register_combined_vehicles(scripts\vehicle\mindia8::main, "veh8_mil_air_mindia8", "mindia8_cp", "script_vehicle_iw8_mindia8_closed", undefined, "mindia8_closed", "mindia8_closed");
    register_combined_vehicles(scripts\vehicle\mindia8::main, "veh8_mil_air_mindia8_open_back_vm_x_cp", "mindia8_cp", "script_vehicle_iw8_mindia8", undefined, "mindia8", "mindia8");
  }

  register_combined_vehicles(scripts\vehicle\mindia8::main, "veh9_mil_air_heli_palfa_doors_open_vehphys_mp", "mindia8", "script_vehicle_iw8_mindia8_playerride", undefined, "mindia8_playerride", "mindia8_playerride");
  register_combined_vehicles(scripts\vehicle\mindia8::main, "veh8_mil_air_mindia8_open_back_playerride", "mindia8", "script_vehicle_iw8_mindia8_playerride", undefined, "mindia8_playerride", "mindia8_playerride");
  register_combined_vehicles(scripts\vehicle\techo::main, "veh8_civ_lnd_techo_physics_cp", "techo_physics_cp", "script_vehicle_iw8_truck_techo_white_physics", undefined, "techo_white", "techo_white");
  register_combined_vehicles(scripts\vehicle\techo::main, "veh8_civ_lnd_techo_dirty_physics", "techo_physics_cp", "script_vehicle_iw8_truck_techo_whitedirty_physics", undefined, "techo_whitedirty", "techo_whitedirty");
  register_combined_vehicles(scripts\vehicle\techo::main, "veh8_civ_lnd_techo_physics_cp", "techo_physics_cp", "script_vehicle_iw8_truck_techo_physics_mp", "technical", "techo_phys", "techo_phys");
  register_combined_vehicles(scripts\vehicle\techo::main, "veh8_civ_lnd_hindia_physics_mp", "hindia_physics_mp", "script_vehicle_iw8_technical_ai_plr", undefined, "technical_ai_plr", "technical_ai_plr");
  register_combined_vehicles(scripts\vehicle\techo::main, "veh8_civ_lnd_techo_rebel_physics", "techo_physics_cp", "script_vehicle_iw8_truck_techo_rebel", undefined, "techo_rebel", "techo_rebel");
  register_combined_vehicles(_id_3AF63BEEAAB2E0A7::main, "veh9_civ_lnd_techo_vehphys_sp_dirty_tan", "veh9_techo_physics_sp", "script_vehicle_iw9_techo_dirty_tan_physics", undefined, "veh9_techo_tan", "veh9_techo_tan");
  create_seatids_override("techo_phys", []);
  register_techo_seat_data("techo_phys");
  register_techo_seat_data("techo_white");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_dirty_physics", "techo_physics_cp", "script_vehicle_iw8_truck_techo_whitedirty_physics");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_red_physics", "techo_physics_cp", "script_vehicle_iw8_truck_techo_red_physics");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_dirty_red_physics", "techo_physics_cp", "script_vehicle_iw8_truck_techo_reddirty_physics");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_black_physics", "techo_physics_cp", "script_vehicle_iw8_truck_techo_black_physics");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_dirty_black_physics", "techo_physics_cp", "script_vehicle_iw8_truck_techo_blackdirty_physics");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_tan_physics", "techo_physics_cp", "script_vehicle_iw8_truck_techo_tan_physics");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_dirty_tan_physics", "techo_physics_cp", "script_vehicle_iw8_truck_techo_tandirty_physics");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_rusty_physics", "techo_physics_cp", "script_vehicle_iw8_truck_techo_whiterusty_physics");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_rusty_blue_physics", "techo_physics_cp", "script_vehicle_iw8_truck_techo_bluerusty_physics");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_rusty_black_physics", "techo_physics_cp", "script_vehicle_iw8_truck_techo_blackrusty_physics");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_rusty_orange_physics", "techo_physics_cp", "script_vehicle_iw8_truck_techo_orangerusty_physics");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_rusty_green_physics", "techo_physics_cp", "script_vehicle_iw8_truck_techo_greenrusty_physics");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_rebel_physics", "techo_physics_cp", "script_vehicle_iw8_truck_techo_rebel_physics");
  scripts\cp\cp_remote_tank::main("veh8_mil_lnd_whotel", "veh_pac_sentry_ground_mp", "script_vehicle_mp_collmap_wheelson_west");
  scripts\cp\cp_remote_tank::main("veh8_mil_lnd_whotel_east", "veh_pac_sentry_ground_mp", "script_vehicle_mp_collmap_wheelson_east");

  if(isDefined(level.vehicle_registration_func))
    [[level.vehicle_registration_func]]();
}

create_vehicle_builds() {
  if(isDefined(level.script) && (level.script == "cp_chase" || level.script == "cp_blockade" || level.script == "cp_raid_phase1" || level.script == "cp_donetsk")) {
    if(getdvarint("dvar_002B9A6D3D0BF83A", 0))
      register_vehicle_build("pindia", "veh8_mil_lnd_pindia_physics", "techo_phys_convoy_cp", "script_vehicle_iw8_truck_pindia_black");
    else
      register_vehicle_build("pindia", "veh8_mil_lnd_pindia", "truck", "script_vehicle_iw8_truck_pindia_white");
  } else {
    register_vehicle_build("pindia_node", "veh8_mil_lnd_pindia", "truck", "script_vehicle_iw8_truck_pindia_white");
    register_vehicle_build("pindia", "veh8_mil_lnd_pindia_physics", "techo_phys_convoy_cp", "script_vehicle_iw8_truck_pindia_black");
  }

  register_vehicle_build("pindia_ai_plr", "veh8_mil_lnd_pindia_1seat_red_physics_mp", "hindia_physics_mp", "script_vehicle_iw8_truck_pindia_1seat_red_physics", "hoopty");
  register_vehicle_build("technical_ai_plr", "veh8_civ_lnd_hindia_physics_mp", "hindia_physics_mp", "script_vehicle_iw8_technical_ai_plr", "technical");
  register_vehicle_build("mkilo23_physics", "veh8_mil_lnd_mkilo23_physics", "mkilo23_physics", "script_vehicle_iw8_truck_mkilo23_physics");
}

setup_player_vehicles(player, _id_81A6DCF8641471F7, _id_FEC43803F66B395B) {
  _id_B8A6E872B1F411C9 = "-";
  _id_7ACB3A146E91C0F8 = "&";
  _id_9187EE7DF4D544F9 = "_";
  keys = getarraykeys(level._id_A0B2C978CA57FFC5);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < keys.size; _id_AC0E594AC96AA3A8++) {
    key = keys[_id_AC0E594AC96AA3A8];
    name = key;

    if(scripts\engine\utility::string_starts_with(key, "veh9"))
      name = getsubstr(name, 5, key.size);

    _id_A5516703B3F7D1FF = "devgui_cmd \"CP Players:2 / " + _id_81A6DCF8641471F7 + " / Spawn Vehicle / " + name + "\" \"set scr_vehicle_debug Spawn" + _id_9187EE7DF4D544F9 + _id_B8A6E872B1F411C9 + _id_FEC43803F66B395B + _id_B8A6E872B1F411C9 + _id_7ACB3A146E91C0F8 + key + "\" \n";
    scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  }
}

cp_vehicle_debug(_id_CB325DDB4A764623) {
  items = strtok(_id_CB325DDB4A764623, "_");
  _id_ED553C0E628507CB = strtok(_id_CB325DDB4A764623, "-");
  params = strtok(_id_CB325DDB4A764623, "&");
  player = undefined;

  if(_id_ED553C0E628507CB.size > 0) {
    _id_992D4A4D67CE8BA5 = int(_id_ED553C0E628507CB[0]);
    player = level.players[_id_992D4A4D67CE8BA5];
  }

  switch (items[0]) {
    case "Spawn":
    case "spawn":
      if(isDefined(params) && params.size > 1)
        scripts\engine\utility::script_func(params[1], player);

      break;
    default:
      break;
  }
}

spawn_enemy_chopper(group, spawn_point, infil_name) {
  _id_A0B5803DA717965F = level.ai_spawn_vehicle_func[infil_name];
  _id_1317C822798F0C26 = _id_A0B5803DA717965F get_vehicle_spawn_points(spawn_point);

  if(isDefined(level.attack_heli))
    return 0;

  if(_id_1317C822798F0C26.size > 0) {
    foreach(veh_spawn_point in _id_1317C822798F0C26) {
      if(istrue(veh_spawn_point.in_use)) {
        continue;
      }
      copy_vehicle_build_to_spawnpoint(infil_name, veh_spawn_point);
      angle_ref = vectortoangles(spawn_point.origin - veh_spawn_point.origin);
      veh_spawn_point.angles = (0, angle_ref[1], 0);
      _id_DB2893EE5A058AD4 = scripts\common\vehicle::vehicle_spawn(veh_spawn_point);

      if(isDefined(_id_DB2893EE5A058AD4)) {
        veh_spawn_point.in_use = 1;
        level.attack_heli = _id_DB2893EE5A058AD4;
        _id_DB2893EE5A058AD4 init_cp_vehicle(spawn_point, group, veh_spawn_point, infil_name);
        group.vehicle = undefined;
        spawn_point.vehicle = undefined;
        spawn_point.veh_spawn_point = undefined;
        group.recently_spawned_vehicle = undefined;
        _id_DB2893EE5A058AD4 init_helicopter(group, infil_name);
        _id_DB2893EE5A058AD4.vehicle_forcerocketdeath = undefined;
        _id_DB2893EE5A058AD4.death_fx_on_self = 1;
        _id_DB2893EE5A058AD4.circle_radius = 2500;
        _id_DB2893EE5A058AD4 scripts\cp\helicopter\cp_helicopter::heli_mg_create("veh8_mil_air_ahotel64_turret_wm", "chopper_gunner_turret_cp", "tag_turret");
        _id_DB2893EE5A058AD4 thread scripts\cp\helicopter\cp_helicopter::setup_pilot(1, undefined, undefined, undefined);
        _id_DB2893EE5A058AD4 setmaxpitchroll(15, 15);
        _id_DB2893EE5A058AD4.health_remaining = 2250;
        level thread scripts\cp\helicopter\cp_helicopter::heli_think_default(_id_DB2893EE5A058AD4);
        _id_DB2893EE5A058AD4 sethoverparams(25, 15, 10);
        _id_DB2893EE5A058AD4.headicon = createheadicon(_id_DB2893EE5A058AD4);
        setheadiconimage(_id_DB2893EE5A058AD4.headicon, "hud_icon_head_equipment_enemy");
        setheadiconmaxdistance(_id_DB2893EE5A058AD4.headicon, 12000);
        setheadiconnaturaldistance(_id_DB2893EE5A058AD4.headicon, 1500);
        setheadiconzoffset(_id_DB2893EE5A058AD4.headicon, 10);
        setheadiconsnaptoedges(_id_DB2893EE5A058AD4.headicon, 1);
        _id_DB2893EE5A058AD4.bullets_can_damage = 1;
        _id_DB2893EE5A058AD4.needs_to_evade = 0;
        level thread vo_boss_heli();
      }
    }
  }

  return 0;
}

vo_boss_heli() {
  _id_3FE46CB10BD07785 = ["dx_cps_kama_callout_helicopter_attacking_10", "dx_cps_kama_callout_helicopter_attacking_20", "dx_cps_lass_callout_helicopter_attacking_10", "dx_cps_lass_callout_helicopter_attacking_20"];
  level _id_166B4F052DA169A7::try_to_play_vo_on_team(scripts\engine\utility::random(_id_3FE46CB10BD07785), "allies");
}

set_cp_vehicle_health_values(health) {
  if(isDefined(self.healthbuffer)) {
    self.health = self.healthbuffer + health;
    self.maxhealth = self.health;
  } else {
    self.health = health;
    self.maxhealth = self.health;
  }
}

init_helicopter(group, infil_name) {
  self.isheli = 1;
  self.borntime = gettime();

  switch (infil_name) {
    case "mindia8_closed":
    case "blima_exfil":
    case "mindia8":
    case "blima":
      set_cp_vehicle_health_values(5000);
      break;
    case "attack_heli":
      set_cp_vehicle_health_values(50000);
      break;
    default:
      set_cp_vehicle_health_values(1250);
      break;
  }

  thread damage_players_on_top();
  self.team = "axis";

  if(isDefined(self.script_team))
    self.team = self.script_team;

  self setvehicleteam(self.team);

  if(isDefined(infil_name) && infil_name == "lbravo_carrier")
    thread landing_damage_watcher();

  if(self.team == "axis") {
    level thread _id_74502A9E0EF1F19C::add_to_special_lockon_target_list(self);
    thread helicopter_death_lockon_clear();
  }

  self.dontdisconnectpaths = 1;
  self.vehicle_forcerocketdeath = 1;
  self.death_fx_on_self = 1;
  scripts\common\ai::_id_82A45E8AEF44CE3F(::_id_30A6CAEAAA14C934);

  if(isDefined(infil_name)) {
    level.ai_spawn_vehicle_func[infil_name].count++;

    if(isDefined(group))
      _id_18A73A64992DD07D::add_to_module_vehicles_list(group, infil_name);
  }

  level.all_spawned_vehicles[level.all_spawned_vehicles.size] = self;
}

_id_30A6CAEAAA14C934(attacker, meansofdeath, _id_06B62DB6EEC868E2) {
  if(istrue(self.nocrash))
    thread scripts\cp\helicopter\cp_helicopter::mid_air_explode(attacker);
  else
    thread scripts\cp\helicopter\cp_helicopter::do_heli_crash(attacker);

  return 1;
}

helicopter_death_lockon_clear() {
  level endon("game_ended");
  scripts\engine\utility::waittill_any_2("death", "deleting_vehicle");
  level thread _id_74502A9E0EF1F19C::remove_from_special_lockon_target_list(self);
}

damage_players_on_top() {
  self endon("death");

  for(;;) {
    _id_E3D2AD13835AA960 = scripts\common\utility::playersnear(self.origin, 256);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_E3D2AD13835AA960.size; _id_AC0E594AC96AA3A8++) {
      if(_id_E3D2AD13835AA960[_id_AC0E594AC96AA3A8].origin[2] > self.origin[2]) {
        if(_id_E3D2AD13835AA960[_id_AC0E594AC96AA3A8].origin[2] - self.origin[2] <= 32 && _id_E3D2AD13835AA960[_id_AC0E594AC96AA3A8] isonground())
          _id_E3D2AD13835AA960[_id_AC0E594AC96AA3A8] dodamage(_id_E3D2AD13835AA960[_id_AC0E594AC96AA3A8].health + 1000, self.origin, self, self, "MOD_CRUSH");
      }
    }

    wait 0.25;
  }
}

landing_damage_watcher() {
  self endon("death");
  self endon("unloaded");
  self notify("landing_damage_watcher");
  self endon("landing_damage_watcher");
  _id_C03A5E83336294F5 = 256;
  _id_5BEF124E5F705D27 = 80;
  _id_953D4A8F21434378 = 36;

  while(isDefined(self)) {
    if(isDefined(self.borntime) && gettime() - self.borntime < 5000) {
      wait 0.05;
      continue;
    }

    _id_060C02C698578EDB = self.origin + (0, 0, -140) + anglesToForward(self.angles) * 24;

    if(self.team == "axis") {
      foreach(player in level.players) {
        if(isDefined(player) && isalive(player) && is_point_in_cylinder(player.origin, _id_060C02C698578EDB, _id_5BEF124E5F705D27, _id_953D4A8F21434378))
          player dodamage(player.health + 1000, self.origin, self, self, "MOD_CRUSH");
      }
    }

    vehicles = vehicle_getarrayinradius(_id_060C02C698578EDB - (0, 0, 200), 400, 400);

    if(!isDefined(vehicles) || vehicles.size == 0) {
      wait 0.25;
      continue;
    }

    vehicles = sortbydistance(vehicles, self.origin);
    _id_494E292FC76002C5 = undefined;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < vehicles.size; _id_AC0E594AC96AA3A8++) {
      vehicle = vehicles[_id_AC0E594AC96AA3A8];

      if(!isDefined(vehicle) || vehicle == self) {
        continue;
      }
      if(vehicle vehicle_getspeed() > 1) {
        continue;
      }
      if(isent(vehicle) && is_point_in_cylinder(vehicle.origin, _id_060C02C698578EDB, _id_C03A5E83336294F5 * 1.5, _id_953D4A8F21434378)) {
        _id_494E292FC76002C5 = vehicle;
        break;
      }
    }

    if(!isDefined(_id_494E292FC76002C5)) {
      wait 0.05;
      continue;
    }

    ent = _id_494E292FC76002C5;
    _id_CB874DF7C9E9EDFC = 0;

    if(isDefined(ent.vehiclename) && ent.vehiclename == "little_bird")
      _id_CB874DF7C9E9EDFC = 1;

    if(isDefined(ent.vehiclename) && ent.vehiclename == "little_bird_mg")
      _id_CB874DF7C9E9EDFC = 1;

    if(isDefined(ent.infil_name) && ent.infil_name == "lbravo_carrier")
      _id_CB874DF7C9E9EDFC = 1;

    if(isDefined(self.owner) && isPlayer(self.owner) && isDefined(ent.owner) && isPlayer(ent.owner))
      _id_CB874DF7C9E9EDFC = 0;

    if(is_helicopter_player_occupied() && ent is_helicopter_player_occupied())
      _id_CB874DF7C9E9EDFC = 0;

    if(_id_CB874DF7C9E9EDFC) {
      dmg = ent.health + 1000;
      ent notify("landing_collision_damage", dmg, self);
      ent.disableheavystatedamagefloor = 1;
      ent dodamage(dmg, self.origin, undefined, undefined, "MOD_CRUSH");
    }

    wait 0.05;
  }
}

is_point_in_cylinder(point, _id_886B00EC9FF57F52, _id_0B2D54DCCA83C942, _id_F920810D1461251F) {
  if(scripts\engine\utility::distance_2d_squared(point, _id_886B00EC9FF57F52) > squared(_id_0B2D54DCCA83C942))
    return 0;

  if(point[2] < _id_886B00EC9FF57F52[2])
    return 0;

  if(point[2] > _id_886B00EC9FF57F52[2] + _id_F920810D1461251F)
    return 0;

  return 1;
}

is_helicopter_player_occupied() {
  if(isDefined(self.owner) && isPlayer(self.owner))
    return 1;

  if(isDefined(self.occupants)) {
    foreach(_id_F85572CD5F6117C6 in self.occupants) {
      if(isDefined(_id_F85572CD5F6117C6) && isPlayer(_id_F85572CD5F6117C6) && isalive(_id_F85572CD5F6117C6))
        return 1;
    }
  }

  return 0;
}

init_ground_vehicle(group, infil_name) {
  switch (infil_name) {
    case "techo_rebel":
      self.looping_path = 1;
      set_cp_vehicle_health_values(2500);
      break;
    case "techo_phys":
    case "techo_whitedirty":
    case "techo_white":
    case "technical_ai_plr":
      set_cp_vehicle_health_values(2500);
      break;
    default:
      set_cp_vehicle_health_values(1250);
      break;
  }

  self.vehicle_skipdeathcrash = 1;
  self.team = "axis";
  self setvehicleteam(self.team);

  if(isDefined(infil_name)) {
    level.ai_spawn_vehicle_func[infil_name].count++;

    if(isDefined(group))
      _id_18A73A64992DD07D::add_to_module_vehicles_list(group, infil_name);
  }

  level.all_spawned_vehicles[level.all_spawned_vehicles.size] = self;
}

heli_think_default() {
  thread heli_damagemonitor();
  thread heli_check_players();
  thread heli_move();
  thread engage_target_think();
  thread rumble_nearby_players();
}

heli_damagemonitor(_id_227A4202BBFA2F79, starting_health) {
  self endon("death");
  _id_8DFD4474EF371775 = 0;
  self.health = 1000000;

  if(!isDefined(starting_health))
    starting_health = 2500;

  for(;;) {
    self waittill("damage", amount, attacker, direction_vec, dmgpoint, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
    self.health = 1000000;

    if(isDefined(attacker) && attacker == self) {
      continue;
    }
    if(isDefined(inflictor) && isDefined(inflictor.owner) && inflictor.owner == self) {
      continue;
    }
    if(isDefined(attacker) && isDefined(self.minigun) && attacker == self.minigun) {
      continue;
    }
    if(scripts\cp\helicopter\cp_helicopter::is_snipe_kill(attacker, dmgpoint, objweapon)) {
      _id_8DFD4474EF371775++;

      if(_id_8DFD4474EF371775 == 1) {
        if(isDefined(self.headicon))
          deleteheadicon(self.headicon);

        self.headicon = undefined;
        attacker thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_F88A0D21A577AA90");
        attacker _id_3BCAA2CBAF54ABDD::give_player_currency(500, "large");
        playFX(level._effect["vfx_blima_explosion"], self.origin);
        attacker _id_354C862768CFE202::updatedamagefeedback("hitcritical", 1);
        level.all_spawned_vehicles = scripts\engine\utility::array_remove(level.all_spawned_vehicles, self);
        self.minigun delete();

        if(isDefined(self.pilot))
          self.pilot delete();

        self notify("deleting_vehicle");
        self delete();
        return;
      }

      attacker.lasthitmarkertime = undefined;
      attacker _id_354C862768CFE202::updatedamagefeedback("hitcritical", 1);
      self.needs_to_evade = 1;
      self vehicle_setspeed(100, 100, 100);
      self setvehgoalpos(self.origin + (randomintrange(-50, 50), randomintrange(-50, 50), 0), 0);
      self notify("needs_to_evade");
      continue;
    }

    if(!isexplosivedamagemod(meansofdeath)) {
      attacker.lasthitmarkertime = undefined;
      attacker _id_354C862768CFE202::updatedamagefeedback("hitarmorheavy");
    } else {
      attacker.lasthitmarkertime = undefined;
      attacker _id_354C862768CFE202::updatedamagefeedback("hitcritical");

      if(isDefined(objweapon) && isDefined(objweapon.basename)) {
        switch (objweapon.basename) {
          case "iw8_thermite_mp":
            break;
          case "emp_drone_player_mp":
            amount = 1400;
            break;
          default:
            break;
        }
      } else if(amount < 700)
        amount = 700;

      if(isDefined(_id_227A4202BBFA2F79) && scripts\engine\utility::flag_exist(_id_227A4202BBFA2F79) && !scripts\engine\utility::flag(_id_227A4202BBFA2F79))
        scripts\engine\utility::flag_set(_id_227A4202BBFA2F79);
      else {
        if(!istrue(self.needs_to_evade))
          self.needs_to_evade = 1;

        self notify("needs_to_evade");
        self vehicle_setspeed(100, 100, 100);
        self setvehgoalpos(self.origin + (randomintrange(-850, 850), randomintrange(-850, 850), 0), 0);
      }
    }

    self.health_remaining = self.health_remaining - amount;

    if(self.health_remaining <= starting_health * 0.25 && !isDefined(self.deathfx)) {
      playFX(level._effect["aerial_explosion"], self.origin);
      self setscriptablepartstate("body_damage_heavy", "on");
      self.deathfx = 1;
    } else if(self.health_remaining <= starting_health * 0.5 && !isDefined(self.deathfx1)) {
      self setscriptablepartstate("body_damage_medium", "on");
      playFX(level._effect["aerial_explosion"], self.origin);
      self.deathfx1 = 1;
    } else if(self.health_remaining <= starting_health * 0.75 && !isDefined(self.deathfx2)) {
      self setscriptablepartstate("body_damage_light", "on");
      self.deathfx2 = 1;
    }

    if(self.health_remaining <= 0) {
      if(isDefined(self.headicon))
        deleteheadicon(self.headicon);

      self.headicon = undefined;

      if(isDefined(attacker) && isPlayer(attacker)) {
        attacker thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_F88A0D21A577AA90");
        attacker _id_3BCAA2CBAF54ABDD::give_player_currency(500, "large");
      }

      playFX(level._effect["vfx_blima_explosion"], self.origin);
      attacker _id_354C862768CFE202::updatedamagefeedback("hitcritical", 1);
      level.all_spawned_vehicles = scripts\engine\utility::array_remove(level.all_spawned_vehicles, self);
      self.minigun delete();

      if(isDefined(self.pilot))
        self.pilot delete();

      self notify("deleting_vehicle");
      self delete();
      continue;
    }

    if(isDefined(attacker) && isPlayer(attacker))
      attacker _id_3BCAA2CBAF54ABDD::give_player_currency(10, "large");
  }
}

create_rocket_death_fx(classname) {
  level.vtclassname = classname;
}

get_helicopter_path_positions(target_player) {
  self.path_positions = [];
  _id_152C303131C72FE2 = 12;
  dist = 2048;
  _id_9C59AFEFC22F0C25 = 360 / _id_152C303131C72FE2;
  pos = self.origin;
  self.flight_pos = undefined;
  self.flight_pos_dot = undefined;

  if(isDefined(target_player)) {
    if(isvector(target_player))
      targetpos = target_player;
    else
      targetpos = target_player.origin;
  } else
    targetpos = scripts\cp\utility::get_center_point_of_array(level.players);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_152C303131C72FE2; _id_AC0E594AC96AA3A8++) {
    angle = _id_9C59AFEFC22F0C25 * _id_AC0E594AC96AA3A8;
    _id_8A9F895755FD607E = cos(angle) * dist;
    _id_D867033AB311670B = sin(angle) * dist;
    x = pos[0] + _id_8A9F895755FD607E;
    y = pos[1] + _id_D867033AB311670B;
    z = pos[2];

    if(validate_pos((x, y, z), targetpos)) {
      self.path_positions[self.path_positions.size] = (x, y, z);
      continue;
    }
  }
}

validate_pos(targetpos, _id_EC80496532425417) {
  if(isDefined(_id_EC80496532425417))
    targetpos = (targetpos[0], targetpos[1], _id_EC80496532425417[2] + 1500);

  if(isDefined(level.heli_triggers) && level.heli_triggers.size > 0) {
    _id_6D906809844C7CB1 = level.heli_triggers;

    for(t = 0; t < _id_6D906809844C7CB1.size; t++) {
      if(!isDefined(_id_6D906809844C7CB1[t])) {
        level.heli_triggers = scripts\engine\utility::array_remove(level.heli_triggers, _id_6D906809844C7CB1[t]);
        continue;
      }

      if(isDefined(self.move_trigger) && self.move_trigger == _id_6D906809844C7CB1[t]) {
        continue;
      }
      if(ispointinvolume(targetpos, _id_6D906809844C7CB1[t]))
        return 0;
    }
  }

  if(scripts\engine\trace::capsule_trace_passed(self.origin, targetpos, 256, 512, self.angles, self)) {
    if(isDefined(_id_EC80496532425417)) {
      _id_485B74CB677A51A9 = targetpos - self.origin;

      if(isvector(_id_EC80496532425417))
        _id_04FE25EAEBA81EC3 = vectortoangles(_id_EC80496532425417 - self.origin);
      else if(isDefined(_id_EC80496532425417.velo_forward))
        _id_04FE25EAEBA81EC3 = vectortoangles(_id_EC80496532425417.velo_forward - self.origin);
      else
        _id_04FE25EAEBA81EC3 = vectortoangles(_id_EC80496532425417.origin - self.origin);

      forward = anglesToForward(_id_04FE25EAEBA81EC3);
      dot = vectordot(_id_485B74CB677A51A9, forward);

      if(isDefined(self.flight_pos)) {
        if(dot > self.flight_pos_dot) {
          self.flight_pos_dot = dot;
          self.flight_pos = targetpos;
        }
      } else {
        self.flight_pos_dot = dot;
        self.flight_pos = targetpos;
      }

      if(dot > 0.3) {
        return 1;
        return;
      }

      return 0;
      return;
    } else if(scripts\engine\math::is_point_in_front(targetpos))
      return 1;
    else
      return 0;
  } else
    return 0;
}

heli_move() {
  level endon("game_ended");
  self endon("death");
  chopper_height = self.origin[2];
  self.chopper_height = chopper_height;
  _id_ECBF90442E065A5F = 0;
  timeout = 5;
  self vehicle_setspeed(75, 30);

  for(;;) {
    if(istrue(self.needs_to_evade)) {
      heli_evade((self.origin[0], self.origin[1], self.chopper_height));
      continue;
    }

    if(!isDefined(self.best_target)) {
      heli_go_search();
      continue;
    }

    if(should_move_to_target(self.minigun, self.best_target)) {
      heli_move_to_target(self.best_target);
      continue;
    }

    wait 1;
  }
}

should_move_to_target(_id_A59EE877388B07FB, target) {
  _id_47C3D9295106D6D0 = 6250000;

  if(isDefined(self.should_move_to_target_dist))
    _id_47C3D9295106D6D0 = self.should_move_to_target_dist * self.should_move_to_target_dist;

  if(istrue(self.landed)) {
    self.landed = undefined;
    return 1;
  }

  if(distance2dsquared(_id_A59EE877388B07FB.origin, target.origin) > _id_47C3D9295106D6D0 || isDefined(self.gotopos) && distance2dsquared(_id_A59EE877388B07FB.origin, self.gotopos) > _id_47C3D9295106D6D0)
    return 1;

  return 0;
}

heli_move_to_target(target) {
  self endon("death");
  self cleartargetyaw();
  self cleargoalyaw();
  self setlookatent(target);

  if(isDefined(self.best_target))
    get_helicopter_path_positions(self.best_target);
  else
    get_helicopter_path_positions();

  origin = undefined;

  if(isDefined(self.flight_pos))
    origin = self.flight_pos;
  else if(isDefined(self.path_positions) && self.path_positions.size > 0)
    origin = scripts\engine\utility::random(self.path_positions);

  if(isDefined(origin)) {
    self setneargoalnotifydist(750);

    if(distance2dsquared(self.origin, origin) > 1440000) {
      self vehicle_setspeed(50, 30, 30);
      self setvehgoalpos(origin, 1);
    } else {
      self vehicle_setspeed(15, 12, 12);
      self setvehgoalpos(origin, 0);
    }

    scripts\engine\utility::waittill_any_timeout_1(15, "near_goal");
  }

  wait 5;
}

heli_evade(target) {
  self notify("taking_evasive_actions");
  self endon("taking_evasive_actions");
  self endon("death");
  _id_CB920E03144E9344 = 5000;
  get_helicopter_path_positions();
  points = self.path_positions;

  if(isDefined(points) && points.size > 0) {
    _id_2F05FDC372F83530 = 0;
    start_point = points[0];
    self cleargoalyaw();
    self cleartargetyaw();
    self clearlookatent();

    foreach(index, point in points) {
      if(isvector(point))
        end_pos = point;
      else
        end_pos = point.origin;

      if(scripts\engine\utility::within_fov(self.origin, self.angles, end_pos, cos(25))) {
        start_point = point;
        _id_2F05FDC372F83530 = index;
        break;
      }
    }

    if(isvector(points[_id_2F05FDC372F83530]))
      self setvehgoalpos(points[_id_2F05FDC372F83530], 0);
    else
      self setvehgoalpos(points[_id_2F05FDC372F83530].origin, 0);

    _id_31B102D6A07A30A9 = 1500;
    _id_31B102D6A07A30A9 = _id_31B102D6A07A30A9 * (_id_CB920E03144E9344 / 5000);
    _id_E4CF8DCD09CD238D = 100;
    _id_E4CF8DCD09CD238D = _id_E4CF8DCD09CD238D * (_id_CB920E03144E9344 / 5000);
    self setneargoalnotifydist(1500);
    self vehicle_setspeed(100, 50, 50);
    _id_0DB715BCDE296BEC = 0;
    index = _id_2F05FDC372F83530 + 1;
    _id_392FFC940F74DEB1 = randomint(4);

    while(_id_0DB715BCDE296BEC < points.size - 1) {
      if(index >= points.size)
        index = 0;

      if(isvector(points[index]))
        self setvehgoalpos(points[index], 0);
      else
        self setvehgoalpos(points[index].origin, 0);

      self waittill("near_goal");
      _id_0DB715BCDE296BEC++;
      index++;

      if(_id_0DB715BCDE296BEC == _id_392FFC940F74DEB1) {
        break;
      }
    }
  }

  self.needs_to_evade = 0;
}

rumble_nearby_players() {
  self endon("death");

  for(;;) {
    playrumbleonposition("cp_chopper_rumble", self.origin);
    wait 0.1;
  }
}

heli_check_players() {
  self endon("death");
  self.best_target = undefined;
  _id_A24A55403EABFA0A = 5;
  _id_35BCD149DD29F68B = 0;

  for(;;) {
    _id_EC80496532425417 = heli_get_target();

    if(isDefined(_id_EC80496532425417)) {
      _id_35BCD149DD29F68B = 0;
      self notify("target_found");
      self.best_target = _id_EC80496532425417;
    } else {
      self notify("target_lost");
      _id_35BCD149DD29F68B = _id_35BCD149DD29F68B + 0.25;

      if(_id_35BCD149DD29F68B >= _id_A24A55403EABFA0A) {
        _id_35BCD149DD29F68B = 0;
        self.best_target = undefined;
      }
    }

    wait 0.25;
  }
}

engage_target_think() {
  level endon("game_ended");
  self notify("engage_target_think");
  self endon("engage_target_think");
  self endon("death");
  self.minigun setmode("manual");
  self.nextfiretime = gettime() + 2000;

  for(;;) {
    while(isDefined(self.best_target)) {
      self sethoverparams(150, 35, 35);

      if(istrue(self.has_rockets)) {
        wait 2;

        if(istrue(self.rockets_ready))
          scripts\cp\helicopter\cp_helicopter::hover_and_shoot_rockets(self.best_target);
      } else {
        self.minigun settargetentity(self.best_target, (0, 0, 40));
        result = scripts\engine\utility::waittill_any_ents_or_timeout_return(3, self.minigun, "turret_on_target");
        scripts\cp\helicopter\cp_helicopter::shoot_at_target();
      }

      self notify("target_engaged");
      self sethoverparams(0, 0, 0);
    }

    wait 1;
  }
}

heli_get_target() {
  _id_AA440CDD07894C27 = self.origin;
  _id_114AB88507847C50 = undefined;
  _id_45D25409ACB2D4F9 = scripts\engine\utility::get_array_of_closest(_id_AA440CDD07894C27, level.players);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_45D25409ACB2D4F9.size; _id_AC0E594AC96AA3A8++) {
    player = _id_45D25409ACB2D4F9[_id_AC0E594AC96AA3A8];

    if(!player scripts\cp\utility::is_valid_player(undefined, 0) || istrue(player isinfreefall()) || istrue(player isskydiving()) || istrue(player isparachuting())) {
      continue;
    }
    _id_AA440CDD07894C27 = (player.origin[0], player.origin[1], self.chopper_height);

    if(!istrue(self.has_rockets)) {
      if(scripts\engine\trace::ray_trace_passed(_id_AA440CDD07894C27, player.origin + (0, 0, 10), [self, player])) {
        _id_114AB88507847C50 = player;
        self.gotopos = _id_AA440CDD07894C27;
      }
    }

    if(!isDefined(_id_114AB88507847C50)) {
      r = anglestoright(player.angles);
      _id_AC0E5E4AC96AAEA7 = anglestoleft(player.angles);
      f = anglesToForward(player.angles);
      b = f * -1;
      _id_D895C679F6A927E5 = [r, _id_AC0E5E4AC96AAEA7, f, b];

      foreach(point in _id_D895C679F6A927E5) {
        if(isDefined(player.vehicle))
          _id_072BD42692055CDD = [self, player, player.vehicle];
        else
          _id_072BD42692055CDD = [self, player];

        _id_AA440CDD07894C27 = (player.origin[0], player.origin[1], 0) + (point[0], point[1], 0) * 1800 + (0, 0, self.chopper_height);

        if(scripts\engine\trace::ray_trace_passed(_id_AA440CDD07894C27, player.origin + (0, 0, 10), _id_072BD42692055CDD)) {
          _id_114AB88507847C50 = player;
          self.gotopos = _id_AA440CDD07894C27;
          self.nocircle = 1;
          return _id_114AB88507847C50;
        }
      }
    }

    if(isDefined(_id_114AB88507847C50)) {
      break;
    }
  }

  return _id_114AB88507847C50;
}

heli_go_search() {
  level endon("game_ended");
  self endon("target_found");
  self endon("needs_to_evade");
  self endon("death");
  self clearlookatent();
  self cleartargetyaw();
  self cleargoalyaw();

  if(isDefined(self.minigun))
    self.minigun cleartargetentity();

  self vehicle_setspeed(90, 15);
  self setneargoalnotifydist(1000);

  while(!isDefined(self.best_target)) {
    get_helicopter_path_positions();

    if(isDefined(self.flight_pos)) {
      origin = self.flight_pos;
      self setvehgoalpos(origin, 0);
    } else if(isDefined(self.path_positions) && self.path_positions.size > 0) {
      origin = scripts\engine\utility::random(self.path_positions);
      self setvehgoalpos(origin, 0);
    }

    self waittill("near_goal");
  }
}

is_vehicle_spawnpoint() {
  return _id_54F6CD90DD31BBF0::get_spawn_scoring_type() == "vehicle_spawner";
}

_id_3458E37BBAC2FF9A() {}

_id_F83786291B8EFE6E() {
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("vehicle_enter");
    wait 1;
    self sethudtutorialmessage(&"COOP_GAME_PLAY/LEANOUT_TUTORIAL", 1);
    time = gettime() + 5000;

    while(gettime() < time) {
      if(self meleeButtonPressed()) {
        break;
      }

      if(!isDefined(self.vehicle)) {
        break;
      }

      wait 0.05;
    }

    self clearhudtutorialmessage();
  }
}
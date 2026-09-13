/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\vehicle.gsc
***********************************************/

init_vehicles() {
  if(getdvarint("dvar_742CAA13B3C2E685", 0)) {
    return;
  }
  if(isDefined(level.disablevehiclescripts) && level.disablevehiclescripts) {
    return;
  }
  if(!scripts\engine\utility::add_init_script("vehicles", ::init_vehicles)) {
    return;
  }
  thread init_vehicles_thread();
  cleanup_vt();
}

cleanup_vt() {
  level.vtclassname = undefined;
  level.vtmodel = undefined;
  level.vttype = undefined;
}

init_vehicles_thread() {
  scripts\engine\utility::create_lock("aircraft_wash_math");
  scripts\common\vehicle_code::vehicle_setuplevelvariables();
  level.vehicle.helicopter_crash_locations = scripts\engine\utility::array_combine(level.vehicle.helicopter_crash_locations, scripts\engine\utility::getstructarray_delete("helicopter_crash_location", "targetname"));
  scripts\common\vehicle_code::vehicle_setupspawners();
  _id_69C1E608887EF109 = scripts\common\vehicle_code::vehicle_precachescripts();
  scripts\common\vehicle_code::setup_vehicles(_id_69C1E608887EF109);
  level.vehicle.has_vehicles = getEntArray("script_vehicle", "code_classname").size > 0;
  scripts\engine\utility::script_func("add_hint_string", "invulerable_frags", &"SCRIPT/INVULERABLE_FRAGS");
  scripts\engine\utility::script_func("add_hint_string", "invulerable_bullets", &"SCRIPT/INVULERABLE_BULLETS");
  scripts\engine\utility::script_func("add_hint_string", "enter_vehicle", &"SCRIPT/ENTER_VEHICLE");
  scripts\engine\utility::script_func("add_hint_string", "exit_vehicle", &"SCRIPT/EXIT_VEHICLE", ::_id_3E3D0013D3B2B92A);
}

vehicle_paths(node, _id_269FB0EC10B51524, _id_CFA3AAFB71B08D36) {
  return scripts\common\vehicle_paths::_vehicle_paths(node, _id_269FB0EC10B51524, _id_CFA3AAFB71B08D36);
}

vehicle_spawn(vspawner) {
  return scripts\common\vehicle_code::vehicle_spawn_internal(vspawner);
}

godon() {
  self.godmode = 1;
}

godoff() {
  self.godmode = 0;
}

_id_7461E330C56D791E(parts) {
  if(!isarray(parts))
    parts = [parts];

  self._id_9868A2F0E52A82BD = parts;
}

_id_20FC7AF6688EA282(parts) {
  if(!isDefined(self._id_845B5BEB82AA6BDA)) {
    return;
  }
  if(!isarray(parts))
    parts = [parts];

  self._id_9868A2F0E52A82BD = scripts\engine\utility::array_remove(parts, self._id_845B5BEB82AA6BDA);
}

_id_9CE59AA48970A667() {
  self._id_6E56D5270A6151D5 = 1;
}

_id_7D7628DA4296EFAB() {
  self._id_6E56D5270A6151D5 = 0;
}

mainturretoff() {
  return scripts\common\vehicle_code::_mainturretoff();
}

mainturreton() {
  return scripts\common\vehicle_code::_mainturreton();
}

mgoff() {
  return scripts\common\vehicle_code::_mgoff();
}

mgon() {
  return scripts\common\vehicle_code::_mgon();
}

isvehicle() {
  return isDefined(self.vehicletype);
}

vehicle_is_crashing() {
  return scripts\common\vehicle_code::vehicle_iscrashing();
}

vehicle_kill_rumble_forever() {
  self notify("kill_rumble_forever");
}

spawn_vehicles_from_targetname(targetname) {
  vehicles = [];
  spawners = getEntArray(targetname, "targetname");

  foreach(spawner in spawners) {
    if(!isDefined(spawner.code_classname) || spawner.code_classname != "script_vehicle") {
      continue;
    }
    if(isspawner(spawner)) {
      vehicle = scripts\common\vehicle_code::vehicle_spawn_internal(spawner);
      vehicles = scripts\engine\utility::array_add(vehicles, vehicle);
    }
  }

  return vehicles;
}

spawn_vehicle_from_targetname(name) {
  _id_2D71D4D55573B1C8 = spawn_vehicles_from_targetname(name);
  return _id_2D71D4D55573B1C8[0];
}

spawn_vehicle_from_targetname_and_drive(name) {
  _id_2D71D4D55573B1C8 = spawn_vehicles_from_targetname(name);
  thread scripts\common\vehicle_paths::gopath(_id_2D71D4D55573B1C8[0]);
  return _id_2D71D4D55573B1C8[0];
}

spawn_vehicles_from_targetname_and_drive(name) {
  _id_2D71D4D55573B1C8 = spawn_vehicles_from_targetname(name);

  foreach(vehicle in _id_2D71D4D55573B1C8)
  thread scripts\common\vehicle_paths::gopath(vehicle);

  return _id_2D71D4D55573B1C8;
}

aircraft_wash(model) {
  thread scripts\common\vehicle_code::aircraft_wash_thread(model);
}

vehicle_wheels_forward() {
  scripts\common\vehicle_code::vehicle_setwheeldirection(1);
}

vehicle_wheels_backward() {
  scripts\common\vehicle_code::vehicle_setwheeldirection(0);
}

vehicle_load_ai(ai, _id_547FC6221A4480CB, group) {
  if(!isarray(ai))
    ai = [ai];

  scripts\common\vehicle_aianim::load_ai(ai, _id_547FC6221A4480CB, group);

  if(getdvarint("dvar_9403D7D31FC1D981")) {
    if(!self.usedpositions[0] && !istrue(self._id_98AB42B91397D294)) {
      riders = self.riders;
      vehicle_unload();
      scripts\engine\utility::ent_flag_wait("unloaded");
      riders = scripts\engine\utility::array_removedead(riders);
      riders = scripts\engine\utility::array_remove_array(riders, self.riders);

      if(riders.size > 0) {
        vehicle_load_ai(riders);
        return;
      }
    } else {
      _id_DE99D908F027883A = level.vehicle.templates.aianims[scripts\common\vehicle_code::get_vehicle_classname()];

      if(isDefined(_id_DE99D908F027883A[0].death)) {
        foreach(rider in self.riders) {
          if(istrue(rider.drivingvehicle))
            thread scripts\common\vehicle_aianim::driverdead(rider);
        }
      }
    }
  }
}

spawn_vehicle_and_gopath() {
  vehicle = scripts\common\utility::spawn_vehicle();

  if(isDefined(self.script_speed)) {
    if(!ishelicopter())
      vehicle vehicle_setspeed(self.script_speed);
  }

  thread scripts\common\vehicle_paths::gopath(vehicle);
  return vehicle;
}

attach_vehicle(node) {
  self vehicle_teleport(node.origin, node.angles);

  if(!ishelicopter()) {
    waitframe();
    self attachpath(node);
  }

  thread vehicle_paths(node, 1);
}

attach_vehicle_and_gopath(node) {
  self vehicle_teleport(node.origin, node.angles);
  waitframe();

  if(!ishelicopter())
    self attachpath(node);

  thread vehicle_paths(node);
  scripts\common\vehicle_paths::gopath(self);
}

vehicle_get_riders_by_group(groupname) {
  group = [];
  classname = scripts\common\vehicle_code::get_vehicle_classname();

  if(!isDefined(level.vehicle.templates.unloadgroups[classname]))
    return group;

  _id_2620F53C620AABA5 = level.vehicle.templates.unloadgroups[classname];

  if(!isDefined(groupname))
    return group;

  foreach(guy in self.riders) {
    foreach(_id_5CA5EA9D620388F5 in _id_2620F53C620AABA5[groupname]) {
      if(guy.vehicle_position == _id_5CA5EA9D620388F5)
        group[group.size] = guy;
    }
  }

  return group;
}

vehicle_unload(_id_FA8D840338038893) {
  return scripts\common\vehicle_code::_vehicle_unload(_id_FA8D840338038893);
}

vehicle_turret_scan_off() {
  self notify("stop_scanning_turret");
}

vehicle_get_path_array() {
  self endon("death");
  _id_67FF9A266BAE88EC = [];
  _id_AB0DAE99D989777C = self.attachedpath;

  if(!isDefined(self.attachedpath))
    return _id_67FF9A266BAE88EC;

  nextnode = _id_AB0DAE99D989777C;
  nextnode.counted = 0;

  while(isDefined(nextnode)) {
    if(isDefined(nextnode.counted) && nextnode.counted == 1) {
      break;
    }

    _id_67FF9A266BAE88EC = scripts\engine\utility::array_add(_id_67FF9A266BAE88EC, nextnode);
    nextnode.counted = 1;

    if(!isDefined(nextnode.target)) {
      break;
    }

    if(!ishelicopter()) {
      nextnode = getvehiclenode(nextnode.target, "targetname");
      continue;
    }

    nextnode = scripts\engine\utility::getent_or_struct(nextnode.target, "targetname");
  }

  return _id_67FF9A266BAE88EC;
}

vehicle_lights_on(group, classname) {
  if(!isDefined(group))
    group = "all";

  scripts\common\vehicle_lights::lights_on(group, classname);
}

vehicle_lights_off(group, classname) {
  if(!isDefined(group))
    group = "all";

  scripts\common\vehicle_lights::lights_off(group, classname);
}

vehicle_switch_paths(next_node, _id_D43E0F90CEF74289) {
  self setswitchnode(next_node, _id_D43E0F90CEF74289);
  self.attachedpath = _id_D43E0F90CEF74289;
  thread vehicle_paths();
}

vehicle_stop_named(_id_B671C11AC96BA771, _id_D99757891D1ED279, _id_ACDFCBF564707132) {
  return scripts\common\vehicle_paths::_vehicle_stop_named(_id_B671C11AC96BA771, _id_D99757891D1ED279, _id_ACDFCBF564707132);
}

vehicle_resume_named(_id_B671C11AC96BA771) {
  return scripts\common\vehicle_paths::_vehicle_resume_named(_id_B671C11AC96BA771);
}

ishelicopter() {
  if(isDefined(self.isheli))
    return 1;

  if(!isDefined(self.vehicletype))
    return 0;

  return isDefined(level.vehicle.templates.helicopter_list[_func_40FD49171FAD19D3(self.vehicletype)]);
}

_id_941D95491D4D4817() {
  if(!isDefined(self.vehicletype))
    return 0;

  return isDefined(level.vehicle.templates._id_91F3271E71001190[_func_40FD49171FAD19D3(self.vehicletype)]);
}

isairplane() {
  return isDefined(level.vehicle.templates.airplane_list[_func_40FD49171FAD19D3(self.vehicletype)]);
}

_id_E751A1EB999DD1A5() {
  if(!isDefined(self.vehicletype))
    return 0;

  return isDefined(level.vehicle.templates._id_27719D9C0BC9708A[_func_40FD49171FAD19D3(self.vehicletype)]);
}

enable_global_vehicle_spawn_functions() {
  scripts\common\vehicle_code::vehicle_setuplevelvariables();
  level.vehicle.spawn_functions_enable = 1;
}

_id_DD693A5D8A7F7511(veh) {
  if(isDefined(veh) && isDefined(veh.driver) && isPlayer(veh.driver))
    return 1;

  if(!isDefined(veh) && isDefined(level.player.veh))
    return 1;

  return 0;
}

_id_3E3D0013D3B2B92A(veh) {
  return !_id_DD693A5D8A7F7511(veh);
}

_id_4F182AD6B6D594DB(dist, _id_2D2D28B1528166D2, _id_6166EC335950C5F2) {
  self endon("death");
  self endon("stop_driveable");
  level.player endon("death");
  self._id_98AB42B91397D294 = 1;

  for(;;) {
    waitframe();

    if(self.code_classname == "script_vehicle") {
      if(!isDefined(level.player.veh)) {
        if(distance2dsquared(level.player.origin, self.origin) < squared(dist)) {
          scripts\engine\utility::script_func("display_hint", "enter_vehicle", 0.05);

          if(level.player useButtonPressed()) {
            self vehicle_turnengineon();
            level.player[[_id_2D2D28B1528166D2]](self);
            self.driver = level.player;
            level.player.veh = self;

            while(level.player useButtonPressed())
              waitframe();
          }
        }

        continue;
      }

      if(isDefined(level.player.veh) && level.player.veh == self) {
        if(level.player useButtonPressed()) {
          level.player[[_id_6166EC335950C5F2]](self);
          self.driver = undefined;
          level.player.veh = undefined;

          while(level.player useButtonPressed())
            waitframe();
        }
      }
    }
  }
}

_id_032F7DE64BE76262() {
  if(isDefined(self.damagestate))
    return self.damagestate;

  return undefined;
}

_id_A59F81DB0DDB38C2() {
  if(isDefined(self.damagestate) && self.damagestate == "damageHeavy")
    return 1;

  return 0;
}

_id_538EF15C254E4D34(inflictor) {
  if(istrue(self.godmode) || istrue(self._id_6E56D5270A6151D5)) {
    return;
  }
  damage = self._id_FA70E73BAE432D6F * 2;
  self dodamage(damage, self.origin, inflictor, undefined, "MOD_EXECUTION");

  if(isDefined(level.player.veh) && self == level.player.veh)
    setomnvar("ui_veh_health_percent", 0);
}

_id_28C5281474FFC395(amount, inflictor, mod) {
  if(istrue(self.godmode) || istrue(self._id_6E56D5270A6151D5)) {
    return;
  }
  mod = scripts\engine\utility::_id_53C4C53197386572(mod, undefined);
  self dodamage(amount, self.origin, inflictor, undefined, mod);
  _id_89CEC1224AE724D5();
}

_id_AF11CC0C8DC23332(inflictor) {
  if(istrue(self.godmode) || istrue(self._id_6E56D5270A6151D5)) {
    return;
  }
  _id_04C78918E17E67A6 = self._id_FA70E73BAE432D6F * 0.3 - 1 + self.healthbuffer;
  _id_A1649ADEBBB57951 = self.health - _id_04C78918E17E67A6;

  if(_id_A1649ADEBBB57951 > 1)
    self dodamage(_id_A1649ADEBBB57951, self.origin, inflictor, undefined, "MOD_EXECUTION");
}

_id_B7148A3BFC4DEFB2() {
  return istrue(self._id_B7148A3BFC4DEFB2);
}

_id_9308A42C596B3BF4() {
  if(isvehicle() || isDefined(self.code_classname) && self.code_classname == "script_vehicle")
    return 1;

  return 0;
}

_id_0F6F26F5B1C244D5(scale) {
  self._id_1DE5ACBB26E97918 = scale;
}

_id_2C8C048D81431D8B(scale) {
  self._id_BD79128B30A2DFB2 = scale;
}

_id_2D15999DC8BB344A(amount, _id_E3164B1AD1C44C38) {
  if(!isDefined(self.healthbuffer))
    self.healthbuffer = 0;

  amount = int(amount + self.healthbuffer);
  self.health = amount;
  self._id_80D0F593608378C1 = amount;

  if(istrue(_id_E3164B1AD1C44C38))
    self._id_FA70E73BAE432D6F = amount - self.healthbuffer;
}

_id_CACD62DB1BBE8CB9(amount, _id_E3164B1AD1C44C38) {
  amount = int(amount);

  if(!isDefined(self.healthbuffer))
    self.healthbuffer = 0;

  self.health = self.health + amount;
  self._id_80D0F593608378C1 = self.health;

  if(istrue(_id_E3164B1AD1C44C38))
    self._id_FA70E73BAE432D6F = self.health - self.healthbuffer;
}

_id_C8A94ACEF0BEB362(amount, _id_E3164B1AD1C44C38) {
  amount = int(amount);

  if(!isDefined(self.healthbuffer))
    self.healthbuffer = 0;

  if(amount >= self.health) {
    _id_538EF15C254E4D34(level);
    return;
  }

  self.health = self.health - amount;
  self._id_80D0F593608378C1 = self.health;

  if(istrue(_id_E3164B1AD1C44C38))
    self._id_FA70E73BAE432D6F = self.health - self.healthbuffer;
}

_id_79A6E6E740893346() {
  return self._id_80D0F593608378C1 - self.healthbuffer;
}

_id_6CBB869150E32086() {
  return (self._id_80D0F593608378C1 - self.healthbuffer) / self._id_FA70E73BAE432D6F;
}

_id_9E9DFC6F77569F4D() {
  return istrue(self._id_6E56D5270A6151D5);
}

_id_D7FE44FFB08B499A() {
  return istrue(self.godmode);
}

_id_7B7412DDBEED1F41(_id_E3108E412AFB3811) {
  self._id_653C58271B7DA4C9 = _id_E3108E412AFB3811;
}

_id_34A2EB36FBCA6E89() {
  return istrue(self._id_653C58271B7DA4C9);
}

_id_27F6984D596866BF() {
  classname = scripts\common\vehicle_code::get_vehicle_classname();
  return level.vehicle.templates._id_445AD4FF08E86D9E[classname];
}

_id_65976A53A9CBD110() {
  if(isDefined(_id_27F6984D596866BF()))
    setomnvar("ui_veh_vehicle", _id_27F6984D596866BF());
  else
    setomnvar("ui_veh_vehicle", 2);
}

_id_37F33BFE6B63CB0A() {
  level.player setclientomnvar("ui_veh_vehicle", -1);
}

_id_89CEC1224AE724D5() {
  if(isDefined(level.player.veh) && self == level.player.veh || scripts\engine\utility::is_equal(self, level.player._id_EEF5674C427C35A4)) {
    _id_47D36F3CB2120A2B = _id_6CBB869150E32086();

    if(_id_47D36F3CB2120A2B < 0)
      setomnvar("ui_veh_health_percent", int(0));
    else
      setomnvar("ui_veh_health_percent", int(_id_47D36F3CB2120A2B * 100));

    if(isDefined(self._id_0488F0FC49178C96))
      level.player setclientomnvar("ui_veh_flat_tire_mask", self._id_0488F0FC49178C96);
    else
      level.player setclientomnvar("ui_veh_flat_tire_mask", 0);

    if(isDefined(self._id_FB29967BDC4900EC))
      level.player setclientomnvarbit("ui_veh_warning", 1, self._id_FB29967BDC4900EC);
    else
      level.player setclientomnvarbit("ui_veh_warning", 1, 0);
  }
}

_id_002F026409116444() {
  level.player setclientomnvarbit("ui_veh_warning", 1, 1);
}

_id_9FB6B2244163F2A1() {
  if(!isDefined(self._id_0C3DB265FEFDB8D4))
    return [];
  else
    return self._id_0C3DB265FEFDB8D4;
}

_id_9B915D163F6D1D5A(part) {
  if(isDefined(self._id_AAB9695C92B0ED96) && isDefined(self._id_AAB9695C92B0ED96[part]) && self._id_AAB9695C92B0ED96[part] > 0)
    return 1;

  return 0;
}

#using_animtree("vehicles");

_id_97CBEE6BE1660A84(animation, _id_FB41D1CA75009BF0) {
  vehicle = self;
  self._id_3DADD352FE1D0B39 = 1;

  if(!isDefined(_id_FB41D1CA75009BF0))
    _id_FB41D1CA75009BF0 = 1;

  if(istrue(_id_FB41D1CA75009BF0) && !scripts\common\utility::ismp() && !scripts\common\utility::iscp()) {
    vehicle = scripts\common\vehicle_code::_id_18657584B6BD786A(0);
    vehicle useanimtree(#animtree);
  }

  if(!vehicle _meth_01E8542A707A8002("animator")) {
    vehicle _meth_D2E41C7603BA7697("animator");
    vehicle _meth_77320E794D35465A("animator", "keyframed", 0);
  }

  vehicle animScripted("crash_anim_finished", vehicle.origin, vehicle.angles, animation, undefined, undefined, 0.2, 1);
  vehicle vehphys_crash();

  if(vehicle _meth_01E8542A707A8002("p2p"))
    vehicle _meth_77320E794D35465A("p2p", "pause", 1);

  if(vehicle _meth_01E8542A707A8002("path"))
    vehicle _meth_77320E794D35465A("path", "pause", 1);

  vehicle waittillmatch("crash_anim_finished", "end");
}

_id_A0F7306FC3C08ECF(vehicle, _id_D5A3F788EF786063) {
  _id_5134A5777F340D56 = 0;

  if(isDefined(vehicle.oob))
    _id_5134A5777F340D56 = 1;

  if(!istrue(_id_5134A5777F340D56) && istrue(_id_D5A3F788EF786063)) {
    oobtriggers = level.outofboundstriggers;

    foreach(trigger in oobtriggers) {
      if(vehicle istouching(trigger)) {
        _id_5134A5777F340D56 = 1;
        break;
      }
    }
  }

  return _id_5134A5777F340D56;
}

_id_9039B650FFB212C8(str) {
  if(!isDefined(str)) {
    return;
  }
  if(!isDefined(level._id_D43E78E513933216))
    level._id_D43E78E513933216 = [];

  if(!isDefined(level._id_D43E78E513933216[_func_3DB00F01CDBA4538("tag_origin")]))
    level._id_D43E78E513933216[_func_3DB00F01CDBA4538("tag_origin")] = "tag_origin";

  level._id_D43E78E513933216[_func_3DB00F01CDBA4538(str)] = str;
}

_id_8ED0FFA3F8BE7C75(_id_9427D76BD72BC70B) {
  if(!isDefined(level._id_D43E78E513933216))
    return "";

  return scripts\engine\utility::_id_53C4C53197386572(level._id_D43E78E513933216[_id_9427D76BD72BC70B], "");
}

_id_9D4A70FB4D7EB5B2() {
  if(isDefined(level.vehicle) && isDefined(level.vehicle._id_2F4397218F74E45A))
    self[[level.vehicle._id_2F4397218F74E45A]]();
}
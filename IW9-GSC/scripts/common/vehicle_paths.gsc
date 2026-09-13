/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\vehicle_paths.gsc
***********************************************/

gopath(vehicle) {
  if(!isDefined(vehicle))
    vehicle = self;

  vehicle endon("death");

  if(isDefined(vehicle.hasstarted))
    return;
  else
    vehicle.hasstarted = 1;

  vehicle scripts\engine\utility::script_delay();
  vehicle notify("start_vehiclepath");

  if(vehicle scripts\common\vehicle::ishelicopter())
    vehicle notify("start_dynamicpath");
  else
    vehicle startpath();
}

_vehicle_paths(node, _id_269FB0EC10B51524, _id_CFA3AAFB71B08D36) {
  if(scripts\common\vehicle::ishelicopter())
    vehicle_paths_helicopter(node, _id_269FB0EC10B51524, _id_CFA3AAFB71B08D36);
  else
    vehicle_paths_non_heli(node);
}

trigger_process_node(node) {
  if(isDefined(node.script_flag_set))
    scripts\engine\utility::flag_set(node.script_flag_set);

  if(isDefined(node.script_flag_clear))
    scripts\engine\utility::flag_clear(node.script_flag_clear);

  if(isDefined(node.script_prefab_exploder)) {
    node.script_exploder = node.script_prefab_exploder;
    node.script_prefab_exploder = undefined;
  }

  if(isDefined(node.script_exploder)) {
    delay = node.script_exploder_delay;

    if(isDefined(delay))
      level scripts\engine\utility::delaythread(delay, scripts\engine\utility::exploder, node.script_exploder);
    else
      level scripts\engine\utility::exploder(node.script_exploder);
  }

  if(isDefined(node.script_flag_set))
    scripts\engine\utility::flag_set(node.script_flag_set);

  if(isDefined(node.script_ent_flag_set))
    scripts\engine\utility::ent_flag_set(node.script_ent_flag_set);

  if(isDefined(node.script_ent_flag_clear))
    scripts\engine\utility::ent_flag_clear(node.script_ent_flag_clear);

  if(isDefined(node.script_flag_clear))
    scripts\engine\utility::flag_clear(node.script_flag_clear);

  if(isDefined(node.script_noteworthy)) {
    if(node.script_noteworthy == "deleteme") {
      if(isDefined(self.deathfunc)) {
        delete_riders();
        level thread[[self.deathfunc]](self);
        return;
      } else {
        scripts\common\vehicle_code::vehicle_deathcleanup();
        delete_riders();
        self delete();
        return;
      }
    } else if(node.script_noteworthy == "engineoff")
      self vehicle_turnengineoff();
    else {
      self notify(node.script_noteworthy);
      self notify("noteworthy", node.script_noteworthy);
    }
  }

  if(isDefined(node.script_badplace))
    self.script_badplace = node.script_badplace;

  if(isDefined(node.script_turretmg)) {
    if(node.script_turretmg)
      scripts\common\vehicle_code::_mgon();
    else
      scripts\common\vehicle_code::_mgoff();
  }

  if(isDefined(node.script_turretmain)) {
    if(node.script_turretmain)
      scripts\common\vehicle_code::_mainturreton();
    else
      scripts\common\vehicle_code::_mainturretoff();
  }
}

delete_riders() {
  if(isDefined(self.riders)) {
    foreach(g in self.riders) {
      if(isDefined(g.magic_bullet_shield))
        g scripts\common\ai::stop_magic_bullet_shield();

      if(!scripts\common\utility::issp() && isai(g)) {
        g.nocorpse = 1;
        g kill();
        continue;
      }

      g delete();
    }
  }
}

islastnode(node) {
  if(!isDefined(node.target))
    return 1;

  if(!isDefined(getvehiclenode(node.target, "targetname")) && !isDefined(scripts\common\vehicle_code::get_vehiclenode_any_dynamic(node.target)))
    return 1;

  return 0;
}

vehicle_should_unload(wait_func, nextpoint) {
  if(isDefined(nextpoint.script_unload))
    return 1;

  if(wait_func != ::node_wait)
    return 0;

  if(!islastnode(nextpoint))
    return 0;

  if(istrue(self.dontunloadonend))
    return 0;

  if(self.vehicletype == "empty" || self.vehicletype == "empty_heli")
    return 0;

  return !(isDefined(self.script_vehicle_selfremove) && self.script_vehicle_selfremove);
}

overshoot_next_node(_id_E6A426FC595FE0CD) {}

vehicle_resumepathvehicle() {
  if(!scripts\common\vehicle::ishelicopter()) {
    self resumespeed(35);
    return;
  }

  node = undefined;

  if(isDefined(self.currentnode.target) && !isDefined(self.currentnode.exit_node))
    node = scripts\common\vehicle_code::get_vehiclenode_any_dynamic(self.currentnode.target);

  if(!isDefined(node)) {
    return;
  }
  _vehicle_paths(node);
}

get_path_getfunc(_id_4989043D54BCFB7C) {
  _id_6A4AD94DB7F006E2 = scripts\common\vehicle_code::get_from_vehicle_node;

  if(isDefined(_id_4989043D54BCFB7C.target) && isstruct(_id_4989043D54BCFB7C.target))
    _id_6A4AD94DB7F006E2 = scripts\common\vehicle_code::_id_098C0327A3D5CE1C;
  else if(scripts\common\vehicle::ishelicopter() && isDefined(_id_4989043D54BCFB7C.target)) {
    if(isDefined(scripts\common\vehicle_code::get_from_entity(_id_4989043D54BCFB7C.target)))
      _id_6A4AD94DB7F006E2 = scripts\common\vehicle_code::get_from_entity;

    if(isDefined(scripts\common\vehicle_code::get_from_spawnStruct(_id_4989043D54BCFB7C.target)))
      _id_6A4AD94DB7F006E2 = scripts\common\vehicle_code::get_from_spawnstruct;
  } else if(!scripts\common\utility::issp() && isDefined(_id_4989043D54BCFB7C.target)) {
    if(isDefined(scripts\common\vehicle_code::get_from_spawnStruct(_id_4989043D54BCFB7C.target)))
      _id_6A4AD94DB7F006E2 = scripts\common\vehicle_code::get_from_spawnstruct;
  }

  return _id_6A4AD94DB7F006E2;
}

struct_wait(nextpoint, _id_B7AB7579B3C791B1, _id_ABD9EE4725B96FC2) {
  if(!isDefined(_id_B7AB7579B3C791B1))
    _id_B7AB7579B3C791B1 = nextpoint;

  wait 0.05;

  if(isDefined(_id_B7AB7579B3C791B1.speed) && _id_B7AB7579B3C791B1.speed >= 0) {
    self vehicledriveto(nextpoint.origin, int(_id_B7AB7579B3C791B1.speed));

    while(distancesquared(self.origin, nextpoint.origin) > _id_ABD9EE4725B96FC2) {
      wait 0.1;

      if(scripts\common\utility::iscp())
        self vehicle_setspeedimmediate(_id_B7AB7579B3C791B1.speed, 15, 15);
    }
  } else if(isDefined(_id_B7AB7579B3C791B1.speed) && _id_B7AB7579B3C791B1.speed < 0)
    self vehicle_setspeedimmediate(0, 15, 15);
}

node_wait(nextpoint, _id_B7AB7579B3C791B1, _id_6A4AD94DB7F006E2) {
  if(isDefined(self.unique_id))
    _id_2391481366F103C3 = "node_flag_triggered" + self.unique_id;
  else
    _id_2391481366F103C3 = "node_flag_triggered";

  nodes_flag_triggered(_id_2391481366F103C3, nextpoint, _id_6A4AD94DB7F006E2);

  if(self.attachedpath == nextpoint) {
    self notify("node_wait_terminated");
    waittillframeend;
    return;
  }

  nextpoint scripts\engine\utility::ent_flag_wait_vehicle_node(_id_2391481366F103C3);
  nextpoint scripts\engine\utility::ent_flag_clear(_id_2391481366F103C3, 1);
  nextpoint notify("processed_node" + _id_2391481366F103C3);
}

nodes_flag_triggered(_id_2391481366F103C3, nextpoint, _id_6A4AD94DB7F006E2) {
  for(count = 0; isDefined(nextpoint) && count < 3; nextpoint = [[_id_6A4AD94DB7F006E2]](nextpoint.target)) {
    count++;
    thread node_flag_triggered(_id_2391481366F103C3, nextpoint);

    if(!isDefined(nextpoint.target))
      return;
  }
}

node_flag_triggered(_id_2391481366F103C3, node) {
  if(node scripts\engine\utility::ent_flag_exist(_id_2391481366F103C3)) {
    return;
  }
  node scripts\engine\utility::ent_flag_init(_id_2391481366F103C3);
  thread node_flag_triggered_cleanup(node, _id_2391481366F103C3);
  node endon("processed_node" + _id_2391481366F103C3);
  self endon("death");
  self endon("newpath");
  self endon("node_wait_terminated");
  node waittillmatch("trigger", self);
  node scripts\engine\utility::ent_flag_set(_id_2391481366F103C3);
}

node_flag_triggered_cleanup(node, _id_2391481366F103C3) {
  node endon("processed_node" + _id_2391481366F103C3);
  scripts\engine\utility::waittill_any_3("death", "newpath", "node_wait_terminated");
  node scripts\engine\utility::ent_flag_clear(_id_2391481366F103C3, 1);
}

vehicle_paths_non_heli(node) {
  self notify("newpath");

  if(isDefined(node))
    self.attachedpath = node;

  pathstart = self.attachedpath;
  self.currentnode = self.attachedpath;

  if(!isDefined(pathstart)) {
    return;
  }
  self endon("newpath");
  self endon("death");
  _id_4989043D54BCFB7C = pathstart;
  _id_B7AB7579B3C791B1 = undefined;
  nextpoint = pathstart;
  _id_6A4AD94DB7F006E2 = get_path_getfunc(pathstart);
  _id_ABD9EE4725B96FC2 = 40000;

  while(isDefined(nextpoint)) {
    if(!isstruct(nextpoint))
      node_wait(nextpoint, _id_B7AB7579B3C791B1, _id_6A4AD94DB7F006E2);
    else
      struct_wait(nextpoint, _id_B7AB7579B3C791B1, _id_ABD9EE4725B96FC2);

    if(!isDefined(self)) {
      return;
    }
    trigger_process_node(nextpoint);
    self.currentnode = nextpoint;

    if(!isDefined(self)) {
      return;
    }
    if(isDefined(nextpoint.script_team))
      self.script_team = nextpoint.script_team;

    if(isDefined(nextpoint.script_turningdir))
      self notify("turning", nextpoint.script_turningdir);

    if(isDefined(nextpoint.script_deathroll)) {
      if(nextpoint.script_deathroll == 0)
        thread scripts\common\vehicle_code::deathrolloff();
      else
        thread scripts\common\vehicle_code::deathrollon();
    }

    if(isDefined(nextpoint.script_wheeldirection))
      scripts\common\vehicle_code::vehicle_setwheeldirection(nextpoint.script_wheeldirection);

    if(vehicle_should_unload(::node_wait, nextpoint))
      thread unload_node(nextpoint);

    if(isDefined(nextpoint.script_transmission)) {
      self.veh_transmission = nextpoint.script_transmission;

      if(self.veh_transmission == "forward")
        scripts\common\vehicle_code::vehicle_setwheeldirection(1);
      else
        scripts\common\vehicle_code::vehicle_setwheeldirection(0);
    }

    if(isDefined(nextpoint.script_brake)) {
      self.veh_brake = nextpoint.script_brake;

      if(self vehicle_isphysveh())
        self _meth_65AA053C077C003A(1);
    }

    if(isDefined(nextpoint.script_pathtype))
      self.veh_pathtype = nextpoint.script_pathtype;

    if(isDefined(nextpoint.script_speed)) {
      accel = undefined;

      if(isDefined(nextpoint.script_accel))
        accel = nextpoint.script_accel;

      decel = undefined;

      if(isDefined(nextpoint.script_decel))
        decel = nextpoint.script_decel;

      self vehicle_setspeed(nextpoint.script_speed, accel, decel);
    }

    if(isDefined(nextpoint.script_ent_flag_wait) && !scripts\engine\utility::ent_flag(nextpoint.script_ent_flag_wait)) {
      if(isDefined(nextpoint.script_decel))
        decel = nextpoint.script_decel;
      else if(isDefined(nextpoint.target)) {
        _id_ADFE237A51DC188D = [[_id_6A4AD94DB7F006E2]](nextpoint.target);
        distance = distance(nextpoint.origin, _id_ADFE237A51DC188D.origin) * 0.0568182;
        speed = self vehicle_getspeed();
        decel = squared(speed) / (2 * distance);
      } else
        decel = 20;

      self vehicle_setspeed(0, decel, decel);
      childthread vehicle_notifyonstop();
      scripts\engine\utility::ent_flag_wait(nextpoint.script_ent_flag_wait);

      if(!isDefined(self)) {
        return;
      }
      accel = 60;

      if(isDefined(nextpoint.script_accel))
        accel = nextpoint.script_accel;

      self notify("resumed_path");
      self resumespeed(accel);
    }

    if(isDefined(nextpoint.script_delay)) {
      decel = 20;

      if(isDefined(nextpoint.script_decel))
        decel = nextpoint.script_decel;

      self vehicle_setspeed(0, decel);
      childthread vehicle_notifyonstop();

      if(isDefined(nextpoint.target))
        childthread overshoot_next_node([[_id_6A4AD94DB7F006E2]](nextpoint.target));

      nextpoint scripts\engine\utility::script_delay();
      self notify("delay_passed");
      accel = 60;

      if(isDefined(nextpoint.script_accel))
        accel = nextpoint.script_accel;

      self notify("resumed_path");
      self resumespeed(accel);
    }

    if(isDefined(nextpoint.script_flag_wait) || isDefined(nextpoint._id_7FD486C78ED742F7)) {
      _id_8C8822DE78C6F138 = 0;
      _id_5B62E4FC3021A9A7 = isDefined(nextpoint.script_flag_wait) && !scripts\engine\utility::flag(nextpoint.script_flag_wait);
      _id_D54EEC4CDD1D8FAB = isDefined(nextpoint._id_7FD486C78ED742F7) && scripts\engine\utility::flag(nextpoint._id_7FD486C78ED742F7);
      _id_81FA260174262A60 = undefined;

      if(_id_5B62E4FC3021A9A7 || _id_D54EEC4CDD1D8FAB || isDefined(nextpoint.script_delay_post)) {
        _id_8C8822DE78C6F138 = 1;
        accel = 5;
        decel = 20;

        if(isDefined(nextpoint.script_accel))
          accel = nextpoint.script_accel;

        if(isDefined(nextpoint.script_decel))
          decel = nextpoint.script_decel;

        if(_id_5B62E4FC3021A9A7)
          _id_81FA260174262A60 = "script_flag_wait_" + nextpoint.script_flag_wait;
        else if(_id_D54EEC4CDD1D8FAB)
          _id_81FA260174262A60 = "script_flag_waitopen_" + nextpoint._id_7FD486C78ED742F7;
        else if(isDefined(nextpoint.script_flag_wait))
          _id_81FA260174262A60 = "script_delay_post_" + nextpoint.script_flag_wait;
        else
          _id_81FA260174262A60 = "script_delay_post_" + nextpoint._id_7FD486C78ED742F7;

        _vehicle_stop_named(_id_81FA260174262A60, accel, decel);
        childthread vehicle_notifyonstop();

        if(isDefined(nextpoint.target))
          childthread overshoot_next_node([[_id_6A4AD94DB7F006E2]](nextpoint.target));
      }

      if(_id_5B62E4FC3021A9A7)
        scripts\engine\utility::flag_wait(nextpoint.script_flag_wait);

      if(_id_D54EEC4CDD1D8FAB)
        scripts\engine\utility::flag_waitopen(nextpoint._id_7FD486C78ED742F7);

      if(!isDefined(self)) {
        return;
      }
      if(isDefined(nextpoint.script_delay_post)) {
        wait(nextpoint.script_delay_post);

        if(!isDefined(self))
          return;
      }

      accel = 10;

      if(isDefined(nextpoint.script_accel))
        accel = nextpoint.script_accel;

      if(_id_8C8822DE78C6F138) {
        self notify("resumed_path");
        _vehicle_resume_named(_id_81FA260174262A60);
      }

      self notify("delay_passed");
    }

    if(isDefined(self.set_lookat_point)) {
      self.set_lookat_point = undefined;
      self clearlookatent();
    }

    if(isDefined(nextpoint.script_vehicle_lights_off))
      thread scripts\common\vehicle_lights::lights_off(nextpoint.script_vehicle_lights_off);

    if(isDefined(nextpoint.script_vehicle_lights_on))
      thread scripts\common\vehicle_lights::lights_on(nextpoint.script_vehicle_lights_on);

    if(isDefined(nextpoint.script_forcecolor))
      thread scripts\engine\utility::script_func("forcecolor_riders", nextpoint.script_forcecolor);

    _id_B7AB7579B3C791B1 = nextpoint;

    if(!isDefined(nextpoint.target)) {
      break;
    }

    nextpoint = [[_id_6A4AD94DB7F006E2]](nextpoint.target);

    if(!isDefined(nextpoint)) {
      nextpoint = _id_B7AB7579B3C791B1;
      break;
    }
  }

  self notify("reached_dynamic_path_end");

  if(isDefined(self.script_vehicle_selfremove)) {
    if(isDefined(self.deathfunc)) {
      delete_riders();
      level thread[[self.deathfunc]](self);
    } else {
      scripts\common\vehicle_code::vehicle_deathcleanup();
      delete_riders();
      self notify("delete");
      self delete();
    }
  }
}

vehicle_notifyonstop() {
  self endon("resumed_path");

  while(scripts\common\vehicle_code::vehicle_is_stopped())
    waitframe();

  self setwaitspeed(0);
  self waittill("reached_wait_speed");
  self notify("stopped_path");
}

vehicle_waittill_stopped() {
  while(!scripts\common\vehicle_code::vehicle_is_stopped())
    waitframe();
}

add_z(_id_06A3A1033FFC2699, _id_541DA76E22452661) {
  return (_id_06A3A1033FFC2699[0], _id_06A3A1033FFC2699[1], _id_06A3A1033FFC2699[2] + _id_541DA76E22452661);
}

vehicle_paths_helicopter(node, _id_269FB0EC10B51524, _id_CFA3AAFB71B08D36) {
  if(self vehicle_isphysveh()) {
    if(self _meth_01E8542A707A8002("p2p")) {
      _id_FABC06BB049F87EE(node);
      return;
    } else if(getdvarint("vehlegacyhelipathingforphysicshelicopters") == 0)
      return;
  }

  self notify("newpath");
  self endon("newpath");
  self endon("death");

  if(!isDefined(_id_269FB0EC10B51524))
    _id_269FB0EC10B51524 = 0;

  if(isDefined(node))
    self.attachedpath = node;

  pathstart = self.attachedpath;
  self.currentnode = self.attachedpath;

  if(!isDefined(pathstart)) {
    return;
  }
  if(_id_269FB0EC10B51524)
    self waittill("start_dynamicpath");

  if(isDefined(_id_CFA3AAFB71B08D36)) {
    _id_4EA3A41043B7ADBC = spawnStruct();
    _id_4EA3A41043B7ADBC.origin = add_z(self.origin, _id_CFA3AAFB71B08D36);
    heli_wait_node(_id_4EA3A41043B7ADBC, undefined);
  }

  _id_B7AB7579B3C791B1 = undefined;
  nextpoint = pathstart;
  _id_6A4AD94DB7F006E2 = get_path_getfunc(pathstart);

  while(isDefined(nextpoint)) {
    if(isDefined(nextpoint.script_linkto))
      scripts\common\vehicle_code::set_lookat_from_dest(nextpoint);

    if(isDefined(nextpoint.script_land)) {
      _id_38627A101F024918 = 0;

      if(isDefined(nextpoint.target))
        _id_38627A101F024918 = isDefined([[_id_6A4AD94DB7F006E2]](nextpoint.target));

      thread scripts\common\vehicle_code::vehicle_landanims(nextpoint.script_unload, _id_38627A101F024918);
    }

    if(!isDefined(_id_B7AB7579B3C791B1)) {
      if(isDefined(self._id_918C5A31037E00EE))
        _id_B7AB7579B3C791B1 = self._id_918C5A31037E00EE;
    }

    heli_wait_node(nextpoint, _id_B7AB7579B3C791B1, _id_CFA3AAFB71B08D36);

    if(!isDefined(self)) {
      return;
    }
    self.currentnode = nextpoint;
    nextpoint notify("trigger", self);

    if(isDefined(nextpoint.script_helimove)) {
      self setyawspeedbyname(nextpoint.script_helimove);

      if(nextpoint.script_helimove == "faster")
        self setmaxpitchroll(25, 50);
    }

    trigger_process_node(nextpoint);

    if(!isDefined(self)) {
      return;
    }
    if(isDefined(nextpoint.script_team))
      self.script_team = nextpoint.script_team;

    if(vehicle_should_unload(::heli_wait_node, nextpoint))
      unload_node(nextpoint);

    if(self vehicle_isphysveh()) {
      if(isDefined(nextpoint.script_pathtype))
        self.veh_pathtype = nextpoint.script_pathtype;
    }

    _id_3C7DF338D0AC0D9E = 0;

    if(isDefined(nextpoint.script_flag_wait)) {
      _id_3C7DF338D0AC0D9E = 1;
      scripts\engine\utility::flag_wait(nextpoint.script_flag_wait);
    }

    if(isDefined(nextpoint._id_7FD486C78ED742F7)) {
      _id_3C7DF338D0AC0D9E = 1;
      scripts\engine\utility::flag_waitopen(nextpoint._id_7FD486C78ED742F7);
    }

    if(_id_3C7DF338D0AC0D9E) {
      if(isDefined(nextpoint.script_delay_post))
        wait(nextpoint.script_delay_post);

      self notify("delay_passed");
    }

    if(isDefined(self.set_lookat_point)) {
      self.set_lookat_point = undefined;
      self clearlookatent();
    }

    if(isDefined(nextpoint.script_vehicle_lights_off))
      thread scripts\common\vehicle_lights::lights_off(nextpoint.script_vehicle_lights_off);

    if(isDefined(nextpoint.script_vehicle_lights_on))
      thread scripts\common\vehicle_lights::lights_on(nextpoint.script_vehicle_lights_on);

    if(isDefined(nextpoint.script_forcecolor))
      thread scripts\engine\utility::script_func("forcecolor_riders", nextpoint.script_forcecolor);

    _id_B7AB7579B3C791B1 = nextpoint;

    if(!isDefined(nextpoint.target)) {
      break;
    }

    nextpoint = [[_id_6A4AD94DB7F006E2]](nextpoint.target);

    if(!isDefined(nextpoint)) {
      nextpoint = _id_B7AB7579B3C791B1;
      break;
    }
  }

  self notify("reached_dynamic_path_end");

  if(isDefined(self.script_vehicle_selfremove)) {
    delete_riders();

    if(isDefined(self.deathfunc))
      level thread[[self.deathfunc]](self);
    else
      self delete();
  }
}

heli_wait_node(nextpoint, _id_B7AB7579B3C791B1, _id_CFA3AAFB71B08D36) {
  self endon("newpath");

  if(isDefined(nextpoint.script_unload) || isDefined(nextpoint.script_land)) {
    _id_8DBF20B18391BDA1 = 0;

    if(isDefined(nextpoint.script_land)) {
      scripts\engine\utility::ent_flag_set("landed");

      if(isDefined(self.unload_land_offset))
        _id_8DBF20B18391BDA1 = self.unload_land_offset;
    } else if(isDefined(nextpoint.script_unload) && isDefined(self.unload_hover_offset))
      _id_8DBF20B18391BDA1 = self.unload_hover_offset;
    else if(isDefined(nextpoint.script_unload) && isDefined(self.unload_hover_offset_max)) {
      _id_01230EA36A300368 = scripts\common\utility::groundpos(nextpoint.origin);
      _id_8DBF20B18391BDA1 = nextpoint.origin[2] - _id_01230EA36A300368[2];

      if(_id_8DBF20B18391BDA1 >= self.unload_hover_offset_max)
        _id_8DBF20B18391BDA1 = self.unload_hover_offset_max;
      else if(isDefined(self.unload_hover_land_height) && _id_8DBF20B18391BDA1 < self.unload_hover_land_height)
        _id_8DBF20B18391BDA1 = self.unload_hover_land_height;
    }

    nextpoint.radius = 2;

    if(isDefined(nextpoint.ground_pos))
      nextpoint.origin = nextpoint.ground_pos + (0, 0, _id_8DBF20B18391BDA1);
    else {
      _id_B48C995A0A557FF1 = scripts\common\utility::groundpos(nextpoint.origin) + (0, 0, _id_8DBF20B18391BDA1);

      if(_id_B48C995A0A557FF1[2] > nextpoint.origin[2] - 2000)
        nextpoint.origin = scripts\common\utility::groundpos(nextpoint.origin) + (0, 0, _id_8DBF20B18391BDA1);
    }

    self sethoverparams(0, 0, 0);
  }

  if(isDefined(_id_B7AB7579B3C791B1)) {
    _id_B1DA74CE505DD34A = _id_B7AB7579B3C791B1.script_airresistance;

    if(isDefined(_id_B1DA74CE505DD34A))
      _id_B1DA74CE505DD34A = float(_id_B1DA74CE505DD34A);

    speed = _id_B7AB7579B3C791B1.speed;
    accel = _id_B7AB7579B3C791B1.script_accel;
    decel = _id_B7AB7579B3C791B1.script_decel;
  } else {
    _id_B1DA74CE505DD34A = undefined;
    speed = undefined;
    accel = undefined;
    decel = undefined;
  }

  _id_3E6E337291CA2A19 = isDefined(nextpoint.script_stopnode) && nextpoint.script_stopnode;
  _id_58EAF93DC5DB5926 = isDefined(nextpoint.script_unload);
  flag_wait = isDefined(nextpoint.script_flag_wait) && !scripts\engine\utility::flag(nextpoint.script_flag_wait);
  flag_wait = flag_wait || isDefined(nextpoint._id_7FD486C78ED742F7) && scripts\engine\utility::flag(nextpoint._id_7FD486C78ED742F7);
  _id_CCF44CFF39A902F0 = !isDefined(nextpoint.target);
  _id_038D31613EE1A416 = isDefined(nextpoint.script_delay);

  if(isDefined(nextpoint.angles))
    yaw = nextpoint.angles[1];
  else
    yaw = 0;

  if(self.health <= 0) {
    return;
  }
  origin = nextpoint.origin;

  if(isDefined(_id_CFA3AAFB71B08D36))
    origin = add_z(origin, _id_CFA3AAFB71B08D36);

  if(isDefined(self.heliheightoverride))
    origin = (origin[0], origin[1], self.heliheightoverride);

  self vehicle_helisetai(origin, speed, accel, decel, nextpoint.script_goalyaw, nextpoint.script_anglevehicle, yaw, _id_B1DA74CE505DD34A, _id_038D31613EE1A416, _id_3E6E337291CA2A19, _id_58EAF93DC5DB5926, flag_wait, _id_CCF44CFF39A902F0);

  if(isDefined(nextpoint.radius)) {
    self setneargoalnotifydist(nextpoint.radius);
    scripts\engine\utility::waittill_any_2("near_goal", "goal");
  } else
    self waittill("goal");

  if(!isDefined(self)) {
    return;
  }
  trigger_process_node(nextpoint);

  if(isDefined(nextpoint.script_firelink)) {
    if(!isDefined(level.helicopter_firelinkfunk)) {}

    thread[[level.helicopter_firelinkfunk]](nextpoint);
  }

  nextpoint scripts\engine\utility::script_delay();

  if(isDefined(self.path_gobbler))
    scripts\engine\utility::deletestruct_ref(nextpoint);

  self notify("continuepath");
}

_id_FABC06BB049F87EE(node, _id_B1F8B992BF79F2D3) {
  self notify("newpath");
  self endon("newpath");
  self endon("death");

  if(isDefined(node))
    self.attachedpath = node;

  pathstart = self.attachedpath;
  self.currentnode = self.attachedpath;

  if(!isDefined(pathstart)) {
    return;
  }
  _id_B7AB7579B3C791B1 = undefined;
  nextpoint = pathstart;
  _id_6A4AD94DB7F006E2 = get_path_getfunc(pathstart);

  while(isDefined(nextpoint)) {
    if(!isDefined(_id_B7AB7579B3C791B1)) {
      if(isDefined(self._id_918C5A31037E00EE))
        _id_B7AB7579B3C791B1 = self._id_918C5A31037E00EE;
    }

    _id_2936413EAC5D78B1(nextpoint, _id_B7AB7579B3C791B1, _id_B1F8B992BF79F2D3);

    if(!isDefined(self)) {
      return;
    }
    self.currentnode = nextpoint;
    nextpoint notify("trigger", self);

    if(isDefined(nextpoint.script_helimove)) {
      self setyawspeedbyname(nextpoint.script_helimove);

      if(nextpoint.script_helimove == "faster")
        self setmaxpitchroll(25, 50);
    }

    trigger_process_node(nextpoint);

    if(!isDefined(self)) {
      return;
    }
    if(isDefined(nextpoint.script_team))
      self.script_team = nextpoint.script_team;

    if(self vehicle_isphysveh()) {
      if(isDefined(nextpoint.script_pathtype))
        self.veh_pathtype = nextpoint.script_pathtype;
    }

    _id_3C7DF338D0AC0D9E = 0;

    if(isDefined(nextpoint.script_flag_wait)) {
      _id_3C7DF338D0AC0D9E = 1;
      scripts\engine\utility::flag_wait(nextpoint.script_flag_wait);
    }

    if(isDefined(nextpoint._id_7FD486C78ED742F7)) {
      _id_3C7DF338D0AC0D9E = 1;
      scripts\engine\utility::flag_waitopen(nextpoint._id_7FD486C78ED742F7);
    }

    if(_id_3C7DF338D0AC0D9E) {
      if(isDefined(nextpoint.script_delay_post))
        wait(nextpoint.script_delay_post);

      self notify("delay_passed");
    }

    if(isDefined(self.set_lookat_point)) {
      self.set_lookat_point = undefined;
      self clearlookatent();
    }

    if(isDefined(nextpoint.script_vehicle_lights_off))
      thread scripts\common\vehicle_lights::lights_off(nextpoint.script_vehicle_lights_off);

    if(isDefined(nextpoint.script_vehicle_lights_on))
      thread scripts\common\vehicle_lights::lights_on(nextpoint.script_vehicle_lights_on);

    if(isDefined(nextpoint.script_forcecolor))
      thread scripts\engine\utility::script_func("forcecolor_riders", nextpoint.script_forcecolor);

    _id_B7AB7579B3C791B1 = nextpoint;

    if(!isDefined(nextpoint.target)) {
      break;
    }

    nextpoint = [[_id_6A4AD94DB7F006E2]](nextpoint.target);

    if(!isDefined(nextpoint)) {
      nextpoint = _id_B7AB7579B3C791B1;
      break;
    }
  }

  self notify("reached_dynamic_path_end");

  if(isDefined(self.script_vehicle_selfremove)) {
    delete_riders();

    if(isDefined(self.deathfunc))
      level thread[[self.deathfunc]](self);
    else
      self delete();
  }
}

_id_2936413EAC5D78B1(nextpoint, _id_B7AB7579B3C791B1, _id_B1F8B992BF79F2D3) {
  self endon("newpath");

  if(isDefined(nextpoint.script_unload) || isDefined(nextpoint.script_land)) {}

  if(isDefined(_id_B7AB7579B3C791B1)) {
    _id_B1DA74CE505DD34A = _id_B7AB7579B3C791B1.script_airresistance;
    speed = _id_B7AB7579B3C791B1.speed;
    accel = _id_B7AB7579B3C791B1.script_accel;
    decel = _id_B7AB7579B3C791B1.script_decel;
  } else {
    _id_B1DA74CE505DD34A = undefined;
    speed = undefined;
    accel = undefined;
    decel = undefined;
  }

  _id_3E6E337291CA2A19 = isDefined(nextpoint.script_stopnode) && nextpoint.script_stopnode;
  _id_58EAF93DC5DB5926 = isDefined(nextpoint.script_unload);
  flag_wait = isDefined(nextpoint.script_flag_wait) && !scripts\engine\utility::flag(nextpoint.script_flag_wait);
  flag_wait = flag_wait || isDefined(nextpoint._id_7FD486C78ED742F7) && scripts\engine\utility::flag(nextpoint._id_7FD486C78ED742F7);
  _id_CCF44CFF39A902F0 = !isDefined(nextpoint.target);
  _id_038D31613EE1A416 = isDefined(nextpoint.script_delay);
  yaw = 0;

  if(isDefined(nextpoint.angles))
    yaw = nextpoint.angles[1];

  if(self.health <= 0) {
    return;
  }
  origin = nextpoint.origin;

  if(isDefined(nextpoint.radius))
    self _meth_77320E794D35465A("p2p", "goalThreshold", nextpoint.radius);

  if(isDefined(_id_B1F8B992BF79F2D3))
    origin = add_z(origin, _id_B1F8B992BF79F2D3);

  self _meth_77320E794D35465A("p2p", "goalPoint", origin);
  self _meth_77320E794D35465A("p2p", "goalAngles", (0, yaw, 0));
  self waittill("near_goal");

  if(!isDefined(self)) {
    return;
  }
  trigger_process_node(nextpoint);

  if(isDefined(nextpoint.script_firelink)) {
    if(!isDefined(level.helicopter_firelinkfunk)) {}

    thread[[level.helicopter_firelinkfunk]](nextpoint);
  }

  nextpoint scripts\engine\utility::script_delay();

  if(isDefined(self.path_gobbler))
    scripts\engine\utility::deletestruct_ref(nextpoint);

  self notify("continuepath");
}

get_pathstruct() {
  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray(self.target, "targetname");

  if(_id_9E4E1482CB40C9C5.size == 1)
    return _id_9E4E1482CB40C9C5[0];

  _id_7CB19F95DBC68942 = [];

  foreach(struct in _id_9E4E1482CB40C9C5) {
    if(!isDefined(struct.script_demeanor))
      _id_7CB19F95DBC68942[_id_7CB19F95DBC68942.size] = struct;
  }

  return _id_7CB19F95DBC68942[0];
}

getonpath(_id_A1FB151DFA4983FE) {
  _id_A9C45240836FE2A5 = undefined;
  type = self.vehicletype;

  if(isDefined(self.vehicle_spawner)) {
    if(istrue(self.vehicle_spawner.dontgetonpath))
      return;
  }

  if(isDefined(self.target)) {
    _id_A9C45240836FE2A5 = getvehiclenode(self.target, "targetname");

    if(!isDefined(_id_A9C45240836FE2A5)) {
      if(scripts\common\utility::iscp())
        _id_A9C45240836FE2A5 = get_pathstruct();
      else
        _id_A9C45240836FE2A5 = scripts\engine\utility::getStruct(self.target, "targetname");
    }
  }

  if(!isDefined(_id_A9C45240836FE2A5)) {
    if(scripts\common\vehicle::ishelicopter())
      self vehicle_setspeed(60, 20, 10);

    return;
  }

  self.attachedpath = _id_A9C45240836FE2A5;

  if(!scripts\common\vehicle::ishelicopter() && !isstruct(_id_A9C45240836FE2A5)) {
    self.origin = _id_A9C45240836FE2A5.origin;

    if(!isDefined(_id_A1FB151DFA4983FE))
      self attachpath(_id_A9C45240836FE2A5);
  } else if(isDefined(self.speed))
    self vehicle_setspeedimmediate(self.speed, 20);
  else if(isDefined(_id_A9C45240836FE2A5.speed)) {
    accel = 20;
    decel = 10;

    if(isDefined(_id_A9C45240836FE2A5.script_accel))
      accel = _id_A9C45240836FE2A5.script_accel;

    if(isDefined(_id_A9C45240836FE2A5.script_decel))
      accel = _id_A9C45240836FE2A5.script_decel;

    _id_9ADAC64844F32F6E = float(_id_A9C45240836FE2A5.speed);
    self vehicle_setspeedimmediate(_id_9ADAC64844F32F6E, accel, decel);
  } else
    self vehicle_setspeed(60, 20, 10);

  thread _vehicle_paths(undefined, scripts\common\vehicle::ishelicopter());
}

_vehicle_resume_named(_id_B671C11AC96BA771) {
  _id_3F3BB68BA716FFA6 = self.vehicle_stop_named[_id_B671C11AC96BA771];
  self.vehicle_stop_named[_id_B671C11AC96BA771] = undefined;

  if(self.vehicle_stop_named.size) {
    return;
  }
  if(self _meth_01E8542A707A8002("p2p"))
    self _meth_77320E794D35465A("p2p", "manualSpeed", _id_3F3BB68BA716FFA6 * 17.6);
  else
    self resumespeed(_id_3F3BB68BA716FFA6);
}

_vehicle_stop_named(_id_B671C11AC96BA771, _id_D99757891D1ED279, _id_ACDFCBF564707132) {
  if(!isDefined(self.vehicle_stop_named))
    self.vehicle_stop_named = [];

  if(self _meth_01E8542A707A8002("p2p")) {
    self.vehicle_stop_named[_id_B671C11AC96BA771] = self vehicle_getspeed();
    self _meth_77320E794D35465A("p2p", "manualSpeed", 0);
  } else {
    self vehicle_setspeed(0, _id_D99757891D1ED279, _id_ACDFCBF564707132);
    self.vehicle_stop_named[_id_B671C11AC96BA771] = _id_D99757891D1ED279;
  }
}

unload_node(node) {
  self endon("death");

  if(isDefined(self.ent_flag["prep_unload"]) && scripts\engine\utility::ent_flag("prep_unload")) {
    return;
  }
  if(isDefined(node.targetname)) {
    _id_29376CACC64CC4E6 = getnode(node.targetname, "target");

    if(isDefined(_id_29376CACC64CC4E6) && self.riders.size) {
      foreach(rider in self.riders) {
        if(isai(rider))
          rider thread scripts\engine\utility::script_func("go_to_node", _id_29376CACC64CC4E6);
      }
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

  if(isDefined(node.script_flag_wait) || isDefined(node._id_7FD486C78ED742F7) || isDefined(node.script_delay)) {
    return;
  }
  if(isDefined(self))
    thread vehicle_resumepathvehicle();
}
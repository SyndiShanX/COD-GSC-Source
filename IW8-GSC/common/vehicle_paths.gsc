/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: common\vehicle_paths.gsc
***********************************************/

gopath(var_0) {
  if(!isDefined(var_0))
    var_0 = self;

  var_0 endon("_encstr_AD75063D571AE108");

  if(isDefined(var_0.hasstarted))
    return;
  else
    var_0.hasstarted = 1;

  var_0 scripts\engine\utility::script_delay();
  var_0 notify("_encstr_BDB712B06B76D5BB4736F57B31EFE0B39A82A3F0");

  if(var_0 scripts\common\vehicle_code::ishelicopter_internal())
    var_0 notify("_encstr_9B2A125B1D09EB03A7309BE2F02BBC57C30FC4C8");
  else
    var_0 startpath();
}

_vehicle_paths(var_0, var_1, var_2) {
  if(scripts\common\vehicle_code::ishelicopter_internal())
    vehicle_paths_helicopter(var_0, var_1, var_2);
  else
    vehicle_paths_non_heli(var_0);
}

trigger_process_node(var_0) {
  if(isDefined(var_0.script_flag_set))
    scripts\engine\utility::flag_set(var_0.script_flag_set);

  if(isDefined(var_0.script_flag_clear))
    scripts\engine\utility::flag_clear(var_0.script_flag_clear);

  if(isDefined(var_0.script_prefab_exploder)) {
    var_0.script_exploder = var_0.script_prefab_exploder;
    var_0.script_prefab_exploder = undefined;
  }

  if(isDefined(var_0.script_exploder)) {
    var_1 = var_0.script_exploder_delay;

    if(isDefined(var_1))
      level scripts\engine\utility::delaythread(var_1, scripts\engine\utility::exploder, var_0.script_exploder);
    else
      level scripts\engine\utility::exploder(var_0.script_exploder);
  }

  if(isDefined(var_0.script_flag_set))
    scripts\engine\utility::flag_set(var_0.script_flag_set);

  if(isDefined(var_0.script_ent_flag_set))
    scripts\engine\utility::ent_flag_set(var_0.script_ent_flag_set);

  if(isDefined(var_0.script_ent_flag_clear))
    scripts\engine\utility::ent_flag_clear(var_0.script_ent_flag_clear);

  if(isDefined(var_0.script_flag_clear))
    scripts\engine\utility::flag_clear(var_0.script_flag_clear);

  if(isDefined(var_0.script_noteworthy)) {
    if(var_0.script_noteworthy == "_encstr_970D094917423528F5CD31") {
      scripts\common\vehicle_code::vehicle_deathcleanup();
      delete_riders();
      self delete();
      return;
    } else if(var_0.script_noteworthy == "_encstr_BDF20A2AB0CC271DA04FFEC6")
      self vehicle_turnengineoff();
    else {
      self notify(var_0.script_noteworthy);
      self notify("_encstr_BD5F0BFB38CB2D3B8F6E437CD3", var_0.script_noteworthy);
    }
  }

  if(isDefined(var_0.script_badplace))
    self.script_badplace = var_0.script_badplace;

  if(isDefined(var_0.script_turretmg)) {
    if(var_0.script_turretmg)
      scripts\common\vehicle_code::_mgon();
    else
      scripts\common\vehicle_code::_mgoff();
  }

  if(isDefined(var_0.script_turretmain)) {
    if(var_0.script_turretmain)
      scripts\common\vehicle_code::_mainturreton();
    else
      scripts\common\vehicle_code::_mainturretoff();
  }
}

delete_riders() {
  if(isDefined(self.riders)) {
    foreach(var_1 in self.riders) {
      if(isDefined(var_1.magic_bullet_shield))
        var_1 scripts\common\ai::stop_magic_bullet_shield();

      if(!scripts\common\utility::issp() && isai(var_1)) {
        var_1 kill();
        continue;
      }

      var_1 delete();
    }
  }
}

islastnode(var_0) {
  if(!isDefined(var_0.target))
    return 1;

  if(!isDefined(getvehiclenode(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF")) && !isDefined(scripts\common\vehicle_code::get_vehiclenode_any_dynamic(var_0.target)))
    return 1;

  return 0;
}

vehicle_should_unload(var_0, var_1) {
  if(isDefined(var_1.script_unload))
    return 1;

  if(var_0 != ::node_wait)
    return 0;

  if(!islastnode(var_1))
    return 0;

  if(istrue(self.dontunloadonend))
    return 0;

  if(self.vehicletype == "_encstr_83B306C13570D0CB" || self.vehicletype == "_encstr_BEDC0B7F91C96B49DE78D7FB18")
    return 0;

  return !(isDefined(self.script_vehicle_selfremove) && self.script_vehicle_selfremove);
}

overshoot_next_node(var_0) {}

vehicle_resumepathvehicle() {
  if(!scripts\common\vehicle_code::ishelicopter_internal()) {
    self resumespeed(35);
    return;
  }

  var_0 = undefined;

  if(isDefined(self.currentnode.target))
    var_0 = scripts\common\vehicle_code::get_vehiclenode_any_dynamic(self.currentnode.target);

  if(!isDefined(var_0)) {
    return;
  }
  _vehicle_paths(var_0);
}

get_path_getfunc(var_0) {
  var_1 = scripts\common\vehicle_code::get_from_vehicle_node;

  if(scripts\common\vehicle_code::ishelicopter_internal() && isDefined(var_0.target)) {
    if(isDefined(scripts\common\vehicle_code::get_from_entity(var_0.target)))
      var_1 = scripts\common\vehicle_code::get_from_entity;

    if(isDefined(scripts\common\vehicle_code::get_from_spawnStruct(var_0.target)))
      var_1 = scripts\common\vehicle_code::get_from_spawnstruct;
  } else if(!scripts\common\utility::issp() && isDefined(var_0.target)) {
    if(isDefined(scripts\common\vehicle_code::get_from_spawnStruct(var_0.target)))
      var_1 = scripts\common\vehicle_code::get_from_spawnstruct;
  }

  return var_1;
}

struct_wait(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = var_0;

  wait 0.05;

  if(isDefined(var_1.speed) && var_1.speed >= 0) {
    self vehicledriveto(var_0.origin, int(var_1.speed));

    while(distancesquared(self.origin, var_0.origin) > var_2) {
      wait 0.1;

      if(scripts\common\utility::iscp())
        self vehicle_setspeedimmediate(var_1.speed, 15, 15);
    }
  } else if(isDefined(var_1.speed) && var_1.speed < 0)
    self vehicle_setspeedimmediate(0, 15, 15);
}

node_wait(var_0, var_1, var_2) {
  if(isDefined(self.unique_id))
    var_3 = "_encstr_B276149E60076787515259EFD143BDF342EA801B371D" + self.unique_id;
  else
    var_3 = "_encstr_B276149E60076787515259EFD143BDF342EA801B371D";

  nodes_flag_triggered(var_3, var_0, var_2);

  if(self.attachedpath == var_0) {
    self notify("_encstr_A90F15DCED32B2D777B0A5A37DD1CA27B52D73C28EB232");
    waittillframeend;
    return;
  }

  var_0 scripts\engine\utility::ent_flag_wait_vehicle_node(var_3);
  var_0 scripts\engine\utility::ent_flag_clear(var_3, 1);
  var_0 notify("_encstr_A35C0F83A5880A5DA8437F07FE786FB255" + var_3);
}

nodes_flag_triggered(var_0, var_1, var_2) {
  for(var_3 = 0; isDefined(var_1) && var_3 < 3; var_1 = [[var_2]](var_1.target)) {
    var_3++;
    thread node_flag_triggered(var_0, var_1);

    if(!isDefined(var_1.target))
      return;
  }
}

node_flag_triggered(var_0, var_1) {
  if(var_1 scripts\engine\utility::ent_flag_exist(var_0)) {
    return;
  }
  var_1 scripts\engine\utility::ent_flag_init(var_0);
  thread node_flag_triggered_cleanup(var_1, var_0);
  var_1 endon("_encstr_A35C0F83A5880A5DA8437F07FE786FB255" + var_0);
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_87DE08E656DDC158E81A");
  self endon("_encstr_A90F15DCED32B2D777B0A5A37DD1CA27B52D73C28EB232");
  var_1 waittillmatch("_encstr_8F5C086405E70FBA4B4A", self);
  var_1 scripts\engine\utility::ent_flag_set(var_0);
}

node_flag_triggered_cleanup(var_0, var_1) {
  var_0 endon("_encstr_A35C0F83A5880A5DA8437F07FE786FB255" + var_1);
  scripts\engine\utility::_id_143A6("_encstr_AD75063D571AE108", "_encstr_87DE08E656DDC158E81A", "_encstr_A90F15DCED32B2D777B0A5A37DD1CA27B52D73C28EB232");
  var_0 scripts\engine\utility::ent_flag_clear(var_1, 1);
}

vehicle_paths_non_heli(var_0) {
  self notify("_encstr_87DE08E656DDC158E81A");

  if(isDefined(var_0))
    self.attachedpath = var_0;

  var_1 = self.attachedpath;
  self.currentnode = self.attachedpath;

  if(!isDefined(var_1)) {
    return;
  }
  self endon("_encstr_87DE08E656DDC158E81A");
  self endon("_encstr_AD75063D571AE108");
  var_2 = var_1;
  var_3 = undefined;
  var_4 = var_1;
  var_5 = get_path_getfunc(var_1);
  var_6 = 40000;

  while(isDefined(var_4)) {
    if(!isstruct(var_4))
      node_wait(var_4, var_3, var_5);
    else
      struct_wait(var_4, var_3, var_6);

    if(!isDefined(self)) {
      return;
    }
    trigger_process_node(var_4);
    self.currentnode = var_4;

    if(!isDefined(self)) {
      return;
    }
    if(isDefined(var_4.script_team))
      self.script_team = var_4.script_team;

    if(isDefined(var_4.script_turningdir))
      self notify("_encstr_BEF508DBA83B1D49C8B7", var_4.script_turningdir);

    if(isDefined(var_4.script_deathroll)) {
      if(var_4.script_deathroll == 0)
        thread scripts\common\vehicle_code::deathrolloff();
      else
        thread scripts\common\vehicle_code::deathrollon();
    }

    if(isDefined(var_4.script_wheeldirection))
      scripts\common\vehicle_code::vehicle_setwheeldirection(var_4.script_wheeldirection);

    if(vehicle_should_unload(::node_wait, var_4))
      thread unload_node(var_4);

    if(isDefined(var_4.script_transmission)) {
      self.veh_transmission = var_4.script_transmission;

      if(self.veh_transmission == "_encstr_B42E085325A82CB3F221")
        scripts\common\vehicle_code::vehicle_setwheeldirection(1);
      else
        scripts\common\vehicle_code::vehicle_setwheeldirection(0);
    }

    if(isDefined(var_4.script_brake))
      self.veh_brake = var_4.script_brake;

    if(isDefined(var_4.script_pathtype))
      self.veh_pathtype = var_4.script_pathtype;

    if(isDefined(var_4.script_speed)) {
      var_7 = undefined;

      if(isDefined(var_4.script_accel))
        var_7 = var_4.script_accel;

      var_8 = undefined;

      if(isDefined(var_4.script_decel))
        var_8 = var_4.script_decel;

      self vehicle_setspeed(var_4.script_speed, var_7, var_8);
    }

    if(isDefined(var_4.script_ent_flag_wait) && !scripts\engine\utility::ent_flag(var_4.script_ent_flag_wait)) {
      if(isDefined(var_4.script_decel))
        var_8 = var_4.script_decel;
      else if(isDefined(var_4.target)) {
        var_9 = [[var_5]](var_4.target);
        var_10 = distance(var_4.origin, var_9.origin) * 0.0568182;
        var_11 = self vehicle_getspeed();
        var_8 = squared(var_11) / (2 * var_10);
      } else
        var_8 = 20;

      self vehicle_setspeed(0, var_8, var_8);
      childthread vehicle_notifyonstop();
      scripts\engine\utility::ent_flag_wait(var_4.script_ent_flag_wait);

      if(!isDefined(self)) {
        return;
      }
      var_7 = 60;

      if(isDefined(var_4.script_accel))
        var_7 = var_4.script_accel;

      self notify("_encstr_8CA50D93303BC34D1D7D291131A388");
      self resumespeed(var_7);
    }

    if(isDefined(var_4.script_delay)) {
      var_8 = 20;

      if(isDefined(var_4.script_decel))
        var_8 = var_4.script_decel;

      self vehicle_setspeed(0, var_8);
      childthread vehicle_notifyonstop();

      if(isDefined(var_4.target))
        childthread overshoot_next_node([[var_5]](var_4.target));

      var_4 scripts\engine\utility::script_delay();
      self notify("_encstr_8D910D32568D855EEB1C16E6E62B91");
      var_7 = 60;

      if(isDefined(var_4.script_accel))
        var_7 = var_4.script_accel;

      self notify("_encstr_8CA50D93303BC34D1D7D291131A388");
      self resumespeed(var_7);
    }

    if(isDefined(var_4.script_flag_wait)) {
      var_12 = 0;

      if(!scripts\engine\utility::flag(var_4.script_flag_wait) || isDefined(var_4.script_delay_post)) {
        var_12 = 1;
        var_7 = 5;
        var_8 = 20;

        if(isDefined(var_4.script_accel))
          var_7 = var_4.script_accel;

        if(isDefined(var_4.script_decel))
          var_8 = var_4.script_decel;

        _vehicle_stop_named("_encstr_B84D12676F9E32D0387E179D5148372BFF93E35F" + var_4.script_flag_wait, var_7, var_8);
        childthread vehicle_notifyonstop();

        if(isDefined(var_4.target))
          childthread overshoot_next_node([[var_5]](var_4.target));
      }

      scripts\engine\utility::flag_wait(var_4.script_flag_wait);

      if(!isDefined(self)) {
        return;
      }
      if(isDefined(var_4.script_delay_post)) {
        wait(var_4.script_delay_post);

        if(!isDefined(self))
          return;
      }

      var_7 = 10;

      if(isDefined(var_4.script_accel))
        var_7 = var_4.script_accel;

      if(var_12) {
        self notify("_encstr_8CA50D93303BC34D1D7D291131A388");
        _vehicle_resume_named("_encstr_B84D12676F9E32D0387E179D5148372BFF93E35F" + var_4.script_flag_wait);
      }

      self notify("_encstr_8D910D32568D855EEB1C16E6E62B91");
    }

    if(isDefined(self.set_lookat_point)) {
      self.set_lookat_point = undefined;
      self clearlookatent();
    }

    if(isDefined(var_4.script_vehicle_lights_off))
      thread scripts\common\vehicle_lights::lights_off(var_4.script_vehicle_lights_off);

    if(isDefined(var_4.script_vehicle_lights_on))
      thread scripts\common\vehicle_lights::lights_on(var_4.script_vehicle_lights_on);

    if(isDefined(var_4.script_forcecolor))
      thread scripts\engine\utility::script_func("_encstr_88E8122132AB01BF2FA8A5F8BB59B35F99C0D0EE", var_4.script_forcecolor);

    var_3 = var_4;

    if(!isDefined(var_4.target)) {
      break;
    }

    var_4 = [[var_5]](var_4.target);

    if(!isDefined(var_4)) {
      var_4 = var_3;
      break;
    }
  }

  self notify("_encstr_AC26197DFDCE88BB1FC296F9FBDBE72064539FF161F39868277A09");

  if(isDefined(self.script_vehicle_selfremove)) {
    scripts\common\vehicle_code::vehicle_deathcleanup();
    delete_riders();
    self notify("_encstr_A25F0710622DF3B3D7");
    self delete();
  }
}

vehicle_notifyonstop() {
  self endon("_encstr_8CA50D93303BC34D1D7D291131A388");

  while(scripts\common\vehicle_code::vehicle_is_stopped())
    waitframe();

  self setwaitspeed(0);
  self waittill("_encstr_83F31382ADE312408110479F407814999FBFCFFF85");
  self notify("_encstr_AC290D7FEC4D10B71FC2967B7AB363");
}

vehicle_waittill_stopped() {
  while(!scripts\common\vehicle_code::vehicle_is_stopped())
    waitframe();
}

add_z(var_0, var_1) {
  return (var_0[0], var_0[1], var_0[2] + var_1);
}

vehicle_paths_helicopter(var_0, var_1, var_2) {
  self notify("_encstr_87DE08E656DDC158E81A");
  self endon("_encstr_87DE08E656DDC158E81A");
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(var_1))
    var_1 = 0;

  if(isDefined(var_0))
    self.attachedpath = var_0;

  var_3 = self.attachedpath;
  self.currentnode = self.attachedpath;

  if(!isDefined(var_3)) {
    return;
  }
  var_4 = var_3;

  if(var_1)
    self waittill("_encstr_9B2A125B1D09EB03A7309BE2F02BBC57C30FC4C8");

  if(isDefined(var_2)) {
    var_5 = spawnStruct();
    var_5.origin = add_z(self.origin, var_2);
    heli_wait_node(var_5, undefined);
  }

  var_6 = undefined;
  var_7 = var_3;
  var_8 = get_path_getfunc(var_3);

  while(isDefined(var_7)) {
    if(isDefined(var_7.script_linkto))
      scripts\common\vehicle_code::set_lookat_from_dest(var_7);

    if(isDefined(var_7.script_land)) {
      var_9 = 0;

      if(isDefined(var_7.target))
        var_9 = isDefined([[var_8]](var_7.target));

      thread scripts\common\vehicle_code::vehicle_landanims(var_7.script_unload, var_9);
    }

    heli_wait_node(var_7, var_6, var_2);

    if(!isDefined(self)) {
      return;
    }
    self.currentnode = var_7;
    var_7 notify("_encstr_8F5C086405E70FBA4B4A", self);

    if(isDefined(var_7.script_helimove)) {
      self setyawspeedbyname(var_7.script_helimove);

      if(var_7.script_helimove == "_encstr_BA2207BF09B8544A2E")
        self setmaxpitchroll(25, 50);
    }

    trigger_process_node(var_7);

    if(!isDefined(self)) {
      return;
    }
    if(isDefined(var_7.script_team))
      self.script_team = var_7.script_team;

    if(vehicle_should_unload(::heli_wait_node, var_7))
      thread unload_node(var_7);

    if(self vehicle_isphysveh()) {
      if(isDefined(var_7.script_pathtype))
        self.veh_pathtype = var_7.script_pathtype;
    }

    if(isDefined(var_7.script_flag_wait)) {
      scripts\engine\utility::flag_wait(var_7.script_flag_wait);

      if(isDefined(var_7.script_delay_post))
        wait(var_7.script_delay_post);

      self notify("_encstr_8D910D32568D855EEB1C16E6E62B91");
    }

    if(isDefined(self.set_lookat_point)) {
      self.set_lookat_point = undefined;
      self clearlookatent();
    }

    if(isDefined(var_7.script_vehicle_lights_off))
      thread scripts\common\vehicle_lights::lights_off(var_7.script_vehicle_lights_off);

    if(isDefined(var_7.script_vehicle_lights_on))
      thread scripts\common\vehicle_lights::lights_on(var_7.script_vehicle_lights_on);

    if(isDefined(var_7.script_forcecolor))
      thread scripts\engine\utility::script_func("_encstr_88E8122132AB01BF2FA8A5F8BB59B35F99C0D0EE", var_7.script_forcecolor);

    var_6 = var_7;

    if(!isDefined(var_7.target)) {
      break;
    }

    var_7 = [[var_8]](var_7.target);

    if(!isDefined(var_7)) {
      var_7 = var_6;
      break;
    }
  }

  self notify("_encstr_AC26197DFDCE88BB1FC296F9FBDBE72064539FF161F39868277A09");

  if(isDefined(self.script_vehicle_selfremove)) {
    delete_riders();
    self delete();
  }
}

heli_wait_node(var_0, var_1, var_2) {
  self endon("_encstr_87DE08E656DDC158E81A");

  if(isDefined(var_0.script_unload) || isDefined(var_0.script_land)) {
    var_3 = 0;

    if(isDefined(var_0.script_land)) {
      scripts\engine\utility::ent_flag_set("_encstr_9A93071D297064AAC5");

      if(isDefined(self.unload_land_offset))
        var_3 = self.unload_land_offset;
    } else if(isDefined(var_0.script_unload) && isDefined(self.unload_hover_offset))
      var_3 = self.unload_hover_offset;
    else if(isDefined(var_0.script_unload) && isDefined(self.unload_hover_offset_max)) {
      var_4 = scripts\common\utility::groundpos(var_0.origin);
      var_3 = var_0.origin[2] - var_4[2];

      if(var_3 >= self.unload_hover_offset_max)
        var_3 = self.unload_hover_offset_max;
      else if(isDefined(self.unload_hover_land_height) && var_3 < self.unload_hover_land_height)
        var_3 = self.unload_hover_land_height;
    }

    var_0.radius = 2;

    if(isDefined(var_0.ground_pos))
      var_0.origin = var_0.ground_pos + (0, 0, var_3);
    else {
      var_5 = scripts\common\utility::groundpos(var_0.origin) + (0, 0, var_3);

      if(var_5[2] > var_0.origin[2] - 2000)
        var_0.origin = scripts\common\utility::groundpos(var_0.origin) + (0, 0, var_3);
    }

    self sethoverparams(0, 0, 0);
  }

  if(isDefined(var_1)) {
    var_6 = var_1.script_airresistance;
    var_7 = var_1.speed;
    var_8 = var_1.script_accel;
    var_9 = var_1.script_decel;
  } else {
    var_6 = undefined;
    var_7 = undefined;
    var_8 = undefined;
    var_9 = undefined;
  }

  var_10 = isDefined(var_0.script_stopnode) && var_0.script_stopnode;
  var_11 = isDefined(var_0.script_unload);
  var_12 = isDefined(var_0.script_flag_wait) && !scripts\engine\utility::flag(var_0.script_flag_wait);
  var_13 = !isDefined(var_0.target);
  var_14 = isDefined(var_0.script_delay);

  if(isDefined(var_0.angles))
    var_15 = var_0.angles[1];
  else
    var_15 = 0;

  if(self.health <= 0) {
    return;
  }
  var_16 = var_0.origin;

  if(isDefined(var_2))
    var_16 = add_z(var_16, var_2);

  if(isDefined(self.heliheightoverride))
    var_16 = (var_16[0], var_16[1], self.heliheightoverride);

  self vehicle_helisetai(var_16, var_7, var_8, var_9, var_0.script_goalyaw, var_0.script_anglevehicle, var_15, var_6, var_14, var_10, var_11, var_12, var_13);

  if(isDefined(var_0.radius)) {
    self setneargoalnotifydist(var_0.radius);
    scripts\engine\utility::_id_143A5("_encstr_B4D10ADC950BE4EB76DE8536", "_encstr_8B7205D9ED5958");
  } else
    self waittill("_encstr_8B7205D9ED5958");

  trigger_process_node(var_0);

  if(isDefined(var_0.script_firelink)) {
    if(!isDefined(level.helicopter_firelinkfunk)) {}

    thread[[level.helicopter_firelinkfunk]](var_0);
  }

  var_0 scripts\engine\utility::script_delay();

  if(isDefined(self.path_gobbler))
    scripts\engine\utility::deletestruct_ref(var_0);

  self notify("_encstr_B4EC0D2F7FA8DBF1E023DF6259C808");
}

quickdropall() {
  var_0 = scripts\engine\utility::getStructArray(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size == 1)
    return var_0[0];

  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isDefined(var_3.script_demeanor))
      var_1[var_1.size] = var_3;
  }

  return var_1[0];
}

getonpath(var_0) {
  var_1 = undefined;
  var_2 = self.vehicletype;

  if(isDefined(self.vehicle_spawner)) {
    if(istrue(self.vehicle_spawner.dontgetonpath))
      return;
  }

  if(isDefined(self.target)) {
    var_1 = getvehiclenode(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(!isDefined(var_1)) {
      var_3 = getEntArray(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

      foreach(var_5 in var_3) {
        if(var_5.code_classname == "_encstr_AD050EE61B93A50E8ED7DB39D29D96B9") {
          var_1 = var_5;
          break;
        }
      }
    }

    if(!isDefined(var_1)) {
      if(scripts\common\utility::iscp())
        var_1 = quickdropall();
      else
        var_1 = scripts\engine\utility::getStruct(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    }
  }

  if(!isDefined(var_1)) {
    if(scripts\common\vehicle_code::ishelicopter_internal())
      self vehicle_setspeed(60, 20, 10);

    return;
  }

  self.attachedpath = var_1;

  if(!scripts\common\vehicle_code::ishelicopter_internal() && !isstruct(var_1)) {
    self.origin = var_1.origin;

    if(!isDefined(var_0))
      self attachpath(var_1);
  } else if(isDefined(self.speed))
    self vehicle_setspeedimmediate(self.speed, 20);
  else if(isDefined(var_1.speed)) {
    var_7 = 20;
    var_8 = 10;

    if(isDefined(var_1.script_accel))
      var_7 = var_1.script_accel;

    if(isDefined(var_1.script_decel))
      var_7 = var_1.script_decel;

    var_9 = float(var_1.speed);
    self vehicle_setspeedimmediate(var_9, var_7, var_8);
  } else
    self vehicle_setspeed(60, 20, 10);

  thread _vehicle_paths(undefined, scripts\common\vehicle_code::ishelicopter_internal());
}

_vehicle_resume_named(var_0) {
  var_1 = self.vehicle_stop_named[var_0];
  self.vehicle_stop_named[var_0] = undefined;

  if(self.vehicle_stop_named.size) {
    return;
  }
  self resumespeed(var_1);
}

_vehicle_stop_named(var_0, var_1, var_2) {
  if(!isDefined(self.vehicle_stop_named))
    self.vehicle_stop_named = [];

  self vehicle_setspeed(0, var_1, var_2);
  self.vehicle_stop_named[var_0] = var_1;
}

unload_node(var_0) {
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(self.ent_flag["_encstr_A3390CC953678907D5E091908E03"]) && scripts\engine\utility::ent_flag("_encstr_A3390CC953678907D5E091908E03")) {
    return;
  }
  if(!isDefined(var_0.script_flag_wait) && !isDefined(var_0.script_delay))
    self notify("_encstr_87DE08E656DDC158E81A");

  var_1 = getnode(var_0.targetname, "_encstr_A16007A921A23B85E3");

  if(isDefined(var_1) && self.riders.size) {
    foreach(var_3 in self.riders) {
      if(isai(var_3))
        var_3 thread scripts\engine\utility::script_func("_encstr_858C0B87DD37999FE988907487", var_1);
    }
  }

  if(scripts\common\vehicle_code::ishelicopter_internal()) {
    self sethoverparams(0, 0, 0);
    scripts\common\vehicle_code::waittill_stable(var_0);
  }

  if(isDefined(var_0.script_noteworthy)) {
    if(var_0.script_noteworthy == "_encstr_92480EEB904B8BEF4130F2275CE8DF97")
      scripts\engine\utility::flag_wait(var_0.script_flag);
  }

  if(isDefined(var_0.script_unload)) {
    if(var_0.script_unload == "_encstr_A34C02BB")
      var_0.script_unload = "_encstr_8B1608EC43B8D647A113";
  }

  scripts\common\vehicle_code::_vehicle_unload(var_0.script_unload);

  if(scripts\common\vehicle_aianim::riders_unloadable(var_0.script_unload))
    self waittill("_encstr_BD82096B5DA4B07F924F29");

  if(isDefined(var_0.script_flag_wait) || isDefined(var_0.script_delay)) {
    return;
  }
  if(isDefined(self))
    thread vehicle_resumepathvehicle();
}
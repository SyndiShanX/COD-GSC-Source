/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\vehicles\vehicle_interact.gsc
***********************************************/

vehicle_interact_getleveldataforvehicle(var_0, var_1, var_2) {
  var_3 = vehicle_interact_getleveldata();
  var_4 = var_3.vehicledata[var_0];

  if(!isDefined(var_4)) {
    if(istrue(var_1)) {
      var_4 = spawnStruct();
      var_4.trial_lap_time = [];
      var_3.vehicledata[var_0] = var_4;
    } else {}
  }

  return var_4;
}

vehicle_interact_getinstancedataforvehicle(var_0, var_1, var_2) {
  var_3 = vehicle_interact_getleveldataforvehicle(var_0.vehiclename, var_1, var_2);

  if(!isDefined(var_3))
    return undefined;

  if(!isDefined(var_0 getlinkedscriptableinstance()))
    return undefined;

  var_4 = var_0.interactdata;

  if(!isDefined(var_4)) {
    if(istrue(var_1)) {
      var_4 = spawnStruct();
      var_0.interactdata = var_4;
      var_4.disabledbyallow = 0;
      var_4.pointdata = [];

      foreach(var_6 in var_3.trial_lap_time)
      var_4.pointdata[var_6] = vehicle_interact_getinstancedataforpoint(var_0, var_6, var_1, var_2);

      var_4.dirty = 1;
      var_4.disabled = undefined;
      var_4.availableteam = undefined;
    } else {}
  }

  return var_4;
}

_id_1419D(var_0, var_1, var_2) {
  var_3 = vehicle_interact_getleveldataforvehicle(var_0, undefined, 1);

  if(!isDefined(var_3)) {
    return;
  }
  var_4 = _id_141A3(var_1);
  var_3.trial_lap_time = scripts\engine\utility::array_add(var_3.trial_lap_time, var_1);
  _id_141AA("_encstr_85AD0950914BBF136ACB7F", var_1, var_2, var_3);
}

vehicle_interact_registerinstance(var_0) {
  vehicle_interact_getinstancedataforvehicle(var_0, 1);
  vehicle_interact_makeusable(var_0);
  var_1 = vehicle_interact_getleveldata();
  var_1.vehicles[var_0 getentitynumber()] = var_0;
}

vehicle_interact_deregisterinstance(var_0) {
  var_1 = vehicle_interact_getleveldata();

  if(isDefined(var_1.vehicles[var_0 getentitynumber()]))
    vehicle_interact_makeunusable(var_0);

  var_1.vehicles[var_0 getentitynumber()] = undefined;
  var_0.interactdata = undefined;
}

vehicle_interact_instanceisregistered(var_0) {
  return isDefined(var_0.interactdata);
}

vehicle_interact_allowvehicleuseglobal(var_0) {
  var_1 = vehicle_interact_getleveldata();

  if(!isDefined(var_1.vehicles)) {
    return;
  }
  if(!var_0) {
    var_1.disabledbyallow++;

    if(var_1.disabledbyallow == 1) {
      foreach(var_3 in var_1.vehicles) {
        vehicle_interact_setvehicledirty(var_3);
        vehicle_interact_updateusability(var_3);
      }
    }
  } else {
    var_1.disabledbyallow--;

    if(var_1.disabledbyallow == 0) {
      foreach(var_3 in var_1.vehicles) {
        vehicle_interact_setvehicledirty(var_3);
        vehicle_interact_updateusability(var_3);
      }
    }
  }
}

vehicle_interact_allowvehicleuse(var_0, var_1) {
  var_2 = vehicle_interact_getinstancedataforvehicle(var_0, undefined, 1);

  if(!isDefined(var_2)) {
    return;
  }
  if(!var_1) {
    var_2.disabledbyallow++;

    if(var_2.disabledbyallow == 1) {
      vehicle_interact_setvehicledirty(var_0);
      vehicle_interact_updateusability(var_0);
    }
  } else {
    var_2.disabledbyallow--;

    if(var_2.disabledbyallow == 0) {
      vehicle_interact_setvehicledirty(var_0);
      vehicle_interact_updateusability(var_0);
    }
  }
}

vehicle_interact_init() {
  var_0 = spawnStruct();
  level.vehicle.interact = var_0;
  var_0.vehicledata = [];
  var_0.trial_lap_time = [];
  var_0.disabledbyallow = 0;
  _id_141A7("_encstr_BDDC07EBCCB5CA4BED", ::_id_141A2, ::_id_141A0, ::_id_1419F, ::_id_141A1);
  _id_141A7("_encstr_A7D708BA0E769358C859", ::_id_141B2, ::_id_141AE, ::_id_141AD, ::_id_141AF);
  _id_141A7("_encstr_966C0E37C0B3B9320575CA07DE33BA6D", ::_id_141B2, ::_id_141AE, ::_id_141AD, ::_id_141AF);
  scripts\engine\scriptable::scriptable_addusedcallback(::vehicle_interact_scriptableused);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B6D611B3F8019447480DE7D99013071ABB701B", "_encstr_88C5055208731B", 1))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B6D611B3F8019447480DE7D99013071ABB701B", "_encstr_88C5055208731B")]]();
}

_id_141A7(var_0, var_1, var_2, var_3, var_4) {
  var_5 = vehicle_interact_getleveldata();
  var_6 = spawnStruct();
  var_7 = [];
  var_7["_encstr_B2080CF5C6D15FED97C872BA4883"] = var_1;
  var_7["_encstr_AC610E903BEDA95DE8EDD65D06B28F91"] = var_2;
  var_7["_encstr_85AD0950914BBF136ACB7F"] = var_3;
  var_7["_encstr_95AD0FD89C95C28E2B94DCCD8E0BCDB12B"] = var_4;
  var_6.callbacks = var_7;
  var_5.trial_lap_time[var_0] = var_6;
}

vehicle_interact_scriptableused(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 == "_encstr_962F0CB3560DD236D8CAD7576E59" || var_2 == "_encstr_AD4513AE081843B6CBEDC71BFB1566FBC099C9974D") {
    var_5 = var_0 getscriptablelinkedentity();
    var_6 = var_1;

    if(vehicle_interact_playercanusevehicles(var_3)) {
      if(istrue(vehicle_interact_vehiclecanbeused(var_5))) {
        if(vehicle_interact_playercanusevehicle(var_3, var_5)) {
          if(vehicle_interact_pointcanbeused(var_5, var_6)) {
            var_7 = vehicle_interact_getinstancedataforpoint(var_5, var_6);
            _id_141AA("_encstr_B2080CF5C6D15FED97C872BA4883", var_6, var_7, var_5, var_3);
          }
        }
      }
    }
  }
}

vehicle_interact_updateplayerusability(var_0, var_1) {
  var_2 = vehicle_interact_getleveldata();

  if(!vehicle_interact_playercanusevehicles(var_0)) {
    foreach(var_4 in var_1)
    var_4 disablescriptableplayeruse(var_0);

    return;
  }

  foreach(var_4 in var_1) {
    if(istrue(vehicle_interact_vehiclecanbeused(var_4)) && vehicle_interact_playercanusevehicle(var_0, var_4)) {
      var_4 enablescriptableplayeruse(var_0);
      continue;
    }

    var_4 disablescriptableplayeruse(var_0);
  }
}

vehicle_interact_monitorplayerusability(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    var_0 waittill("_encstr_95AC195D1C91C28E2BF5EC950D4B6C362BFAD5B958269663A5D1E5", var_1);
    vehicle_interact_updateplayerusability(var_0, var_1);
  }
}

vehicle_interact_getleveldata() {
  return level.vehicle.interact;
}

_id_141A3(var_0) {
  return level.vehicle.interact.trial_lap_time[var_0];
}

_id_141AA(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_141A3(var_1);
  var_6 = var_5.callbacks[var_0];

  if(isDefined(var_6))
    level thread[[var_6]](var_1, var_2, var_3, var_4);
}

vehicle_interact_playercanusevehicles(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  if(!var_0 scripts\common\utility::is_vehicle_use_allowed())
    return 0;

  if(var_0 isparachuting() || var_0 isskydiving())
    return 0;

  if(var_0 isinexecutionattack() || var_0 isinexecutionvictim())
    return 0;

  if(istrue(level.stop_visited_once))
    return 0;

  return 1;
}

vehicle_interact_vehiclecanbeused(var_0) {
  var_1 = vehicle_interact_getinstancedataforvehicle(var_0, undefined, 1);

  if(!isDefined(var_1))
    return undefined;

  if(var_1.dirty)
    vehicle_interact_cleanvehicle(var_0);

  return !var_1.disabled;
}

vehicle_interact_pointcanbeused(var_0, var_1) {
  var_2 = vehicle_interact_getinstancedataforpoint(var_0, var_1, undefined, 1);

  if(!isDefined(var_2))
    return undefined;

  if(var_2.dirty)
    vehicle_interact_cleanpoint(var_0, var_1);

  return !var_2.disabled;
}

vehicle_interact_playercanusevehicle(var_0, var_1) {
  if(level.teambased) {
    var_2 = vehicle_interact_getvehicleavailableteam(var_1);

    if(isDefined(var_2) && var_2 != var_0.team)
      return 0;
  } else {
    var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_141D5(var_1);

    if(isDefined(var_3) && var_3 != var_0)
      return 0;
  }

  return 1;
}

vehicle_interact_getvehicleavailableteam(var_0) {
  var_1 = vehicle_interact_getinstancedataforvehicle(var_0, undefined, 1);

  if(!isDefined(var_1))
    return undefined;

  if(var_1.dirty)
    vehicle_interact_cleanvehicle(var_0);

  return var_1.availableteam;
}

vehicle_interact_setvehicledirty(var_0) {
  var_1 = vehicle_interact_getinstancedataforvehicle(var_0, undefined, 1);

  if(!isDefined(var_1)) {
    return;
  }
  var_1.dirty = 1;
}

vehicle_interact_cleanvehicle(var_0) {
  var_1 = vehicle_interact_getleveldata();
  var_2 = vehicle_interact_getinstancedataforvehicle(var_0, undefined, 1);

  if(!isDefined(var_2)) {
    return;
  }
  if(level.teambased) {
    var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_141D7(var_0);

    if(isDefined(var_3))
      var_2.availableteam = var_3;
    else {
      var_4 = undefined;
      var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_141D6(var_0);

      foreach(var_7 in var_5) {
        if(isDefined(var_7)) {
          var_4 = var_7.team;
          break;
        }
      }

      var_2.availableteam = var_4;
    }
  }

  if(var_1.disabledbyallow > 0)
    var_2.disabled = 1;
  else if(var_2.disabledbyallow > 0)
    var_2.disabled = 1;
  else
    var_2.disabled = 0;

  var_2.dirty = 0;
}

vehicle_interact_getinstancedataforpoint(var_0, var_1, var_2, var_3) {
  var_4 = vehicle_interact_getinstancedataforvehicle(var_0, var_2, var_3);

  if(!isDefined(var_4))
    return undefined;

  var_5 = var_4.pointdata[var_1];

  if(!isDefined(var_5) && isDefined(var_2)) {
    if(istrue(var_2)) {
      var_5 = spawnStruct();
      var_4.pointdata[var_1] = var_5;
      var_5.dirty = 1;
      var_5.disabled = undefined;
      _id_141AA("_encstr_95AD0FD89C95C28E2B94DCCD8E0BCDB12B", var_1, var_5, var_0);
    } else {}
  }

  return var_5;
}

vehicle_interact_pointisdisabled(var_0, var_1) {
  var_2 = vehicle_interact_getinstancedataforpoint(var_0, var_1, undefined, 1);

  if(!isDefined(var_2))
    return undefined;

  if(var_2.dirty)
    vehicle_interact_cleanpoint(var_0, var_1);

  return var_2.disabled;
}

vehicle_interact_pointavailableseat(var_0, var_1) {
  var_2 = vehicle_interact_getinstancedataforpoint(var_0, var_1, undefined, 1);

  if(!isDefined(var_2))
    return undefined;

  if(var_2.dirty)
    vehicle_interact_cleanpoint(var_0, var_1);

  return var_2.availableseatid;
}

vehicle_interact_setpointdirty(var_0, var_1) {
  var_2 = vehicle_interact_getinstancedataforpoint(var_0, var_1, undefined, 1);

  if(!isDefined(var_2)) {
    return;
  }
  var_2.dirty = 1;
}

vehicle_interact_setpointsdirty(var_0) {
  var_1 = vehicle_interact_getinstancedataforvehicle(var_0, undefined, 1);

  if(!isDefined(var_1)) {
    return;
  }
  foreach(var_3 in var_1.pointdata)
  var_3.dirty = 1;

  var_1.dirty = 1;
}

vehicle_interact_cleanpoint(var_0, var_1) {
  var_2 = vehicle_interact_getinstancedataforpoint(var_0, var_1, undefined, 1);

  if(!isDefined(var_2)) {
    return;
  }
  _id_141AA("_encstr_AC610E903BEDA95DE8EDD65D06B28F91", var_1, var_2, var_0);
  var_2.dirty = 0;
}

vehicle_interact_makeusable(var_0) {
  vehicle_interact_updateusability(var_0);
}

vehicle_interact_makeunusable(var_0) {
  var_1 = vehicle_interact_getinstancedataforvehicle(var_0, undefined, 1);

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = getarraykeys(var_1.pointdata);

  foreach(var_4 in var_2)
  var_0 setscriptablepartstate(var_4, "_encstr_A5F311F6DF7812C7A85BB70540A3E74B0A1315");
}

vehicle_interact_updateusability(var_0) {
  var_1 = vehicle_interact_getinstancedataforvehicle(var_0, undefined, 1);

  if(!isDefined(var_1)) {
    return;
  }
  if(var_1.dirty)
    vehicle_interact_cleanvehicle(var_0);

  if(var_1.disabled) {
    vehicle_interact_makeunusable(var_0);
    return;
  }

  foreach(var_4, var_3 in var_1.pointdata) {
    if(var_3.dirty)
      vehicle_interact_cleanpoint(var_0, var_4);

    if(var_3.disabled) {
      var_0 setscriptablepartstate(var_4, "_encstr_A5F311F6DF7812C7A85BB70540A3E74B0A1315");
      continue;
    }

    if(istrue(var_0.shouldmodeplayfinalmoments)) {
      var_0 setscriptablepartstate(var_4, "_encstr_AD4513AE081843B6CBEDC71BFB1566FBC099C9974D");
      continue;
    }

    var_0 setscriptablepartstate(var_4, "_encstr_962F0CB3560DD236D8CAD7576E59");
  }
}

_id_141A2(var_0, var_1, var_2, var_3) {
  var_4 = var_1.availableseatid;
  thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_2, var_4, var_3);
}

_id_141A0(var_0, var_1, var_2, var_3) {
  var_4 = var_1._id_12FA8;
  var_5 = undefined;

  foreach(var_7 in var_4) {
    if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_seatisavailable(var_2, var_7)) {
      var_5 = var_7;
      break;
    }
  }

  var_1.disabled = !isDefined(var_5);
  var_1.availableseatid = var_5;
}

_id_1419F(var_0, var_1, var_2, var_3) {
  var_2._id_12FA8 = var_1;
}

_id_141A1(var_0, var_1, var_2, var_3) {
  var_4 = vehicle_interact_getleveldataforvehicle(var_2.vehiclename, undefined, 1);
  var_1.availableseatid = undefined;
  var_1._id_12FA8 = var_4._id_12FA8;
}

_id_1419E(var_0, var_1) {
  if(isDefined(var_0)) {
    if(!isDefined(var_0._id_12664))
      var_0._id_12664 = [];

    var_0._id_12664 = scripts\engine\utility::array_add(var_0._id_12664, var_1);
  }
}

_id_141A8(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_0._id_12664))
    var_0._id_12664 = scripts\engine\utility::array_remove(var_0._id_12664, var_1);
}

_id_141B2(var_0, var_1, var_2, var_3) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_AF40102C3DF078AE8463F9B8814F5B99E112", "_encstr_88C5055208731B")) {
    if(!isDefined(level.delayedeventtypes)) {
      var_3 iprintlnbold("_encstr_86B034F9C9E667D84773B21F6BF301D11CA21072124AE9706F9CEFA7539B486DC6FBF0D81E64BD817BB843A668EFB113AF2638F8F2BF");
      return;
    }

    [[var_1.emp_nearby_targets]](var_2, var_3);
    var_3 setclientomnvar("_encstr_BE511D0BC42EAD82DFC0FD5DF788D28B2D16ED88A0A58677C3C2FB8AAA2F2B", var_1.emp_effect_duration);
    var_3.delete_silo_lights = 1;
    var_3._id_1424D = var_2;
    _id_1419E(var_2, var_3);
    var_4 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_AF40102C3DF078AE8463F9B8814F5B99E112", "_encstr_88C5055208731B");
    var_5 = _id_141B1(var_2, var_0);
    var_3 thread[[var_4]](var_5);
  }
}

_id_141AE(var_0, var_1, var_2, var_3) {
  var_1.disabled = 0;
}

_id_141AD(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2.wait_for_lmg_dead))
    var_2.wait_for_lmg_dead = [];

  if(!isDefined(var_2.emp_drone_success_use))
    var_2.emp_drone_success_use = [];

  if(!isDefined(var_2.emp_nearby_targets))
    var_2.emp_nearby_targets = [];

  var_2.wait_for_lmg_dead[var_0] = var_1[0];
  var_2.emp_drone_success_use[var_0] = var_1[1];
  var_2.emp_nearby_targets[var_0] = var_1[2];
}

_id_141AF(var_0, var_1, var_2, var_3) {
  var_4 = vehicle_interact_getleveldataforvehicle(var_2.vehiclename, undefined, 1);
  var_1.emp_effect_duration = var_4.emp_drone_success_use[var_0];
  var_1.emp_nearby_targets = var_4.emp_nearby_targets[var_0];
  var_5 = var_4.wait_for_lmg_dead[var_0];
  _id_141B0(var_2, var_0, var_5);
}

_id_141B1(var_0, var_1) {
  return var_0.wait_for_kills[var_1];
}

_id_141B0(var_0, var_1, var_2) {
  if(!isDefined(var_0.wait_for_kills))
    var_0.wait_for_kills = [];

  var_3 = spawnStruct();
  var_3 thread _id_141AB(var_0, var_2);
  var_0.wait_for_kills[var_1] = var_3;
}

_id_141AB(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    self.origin = var_0 gettagorigin(var_1);
    wait 0.5;
  }
}

_id_141AC(var_0, var_1) {
  _id_141A6(var_0);
  return isDefined(var_0._id_14034) && istrue(var_0._id_14034[var_1]);
}

_id_141A6(var_0) {
  if(!isDefined(var_0._id_14034))
    var_0._id_14034 = [];
}

_id_141A4(var_0, var_1, var_2) {
  _id_141A9(var_0, var_1);
  var_0 notify("_encstr_AC5B0D1F53442A27D863BFC2796825", var_1, var_2);
}

_id_141A9(var_0, var_1) {
  _id_141A6(var_0);
  var_0._id_14034[var_1] = 1;
}

_id_141A5() {
  var_0 = setdvarifuninitialized("_encstr_BABC1DE68D9CFAACE6A359C92B2BD0D2C663AC6A59853A3DEC2B93272D322B", 0);
}
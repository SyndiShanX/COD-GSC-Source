/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\vehicles\vehicle.gsc
***********************************************/

vehicle_init() {
  if(!isDefined(level.vehicle))
    level.vehicle = spawnStruct();

  level.vehicle.vehicledata = [];
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_88C5055208731B")]]();
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_init();
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_init();
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_init();
  scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_init();
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_init();
  scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_init();
  scripts\cp_mp\vehicles\vehicle_dlog::vehicle_dlog_init();
  _calloutmarkerping_predicted_timeout::_id_14125();
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_init();
  _calloutmarkerping_predicted_log::_id_14114();
  scripts\cp_mp\vehicles\apc_rus::apc_rus_init();
  scripts\cp_mp\vehicles\atv::atv_init();
  scripts\cp_mp\vehicles\cargo_truck::cargo_truck_init();
  _calloutmarkerping_isdropcrate::get_intel_location_vo();
  scripts\cp_mp\vehicles\cop_car::cop_car_init();
  scripts\cp_mp\vehicles\hoopty::hoopty_init();
  scripts\cp_mp\vehicles\hoopty_truck::hoopty_truck_init();
  scripts\cp_mp\vehicles\technical::technical_init();
  scripts\cp_mp\vehicles\light_tank::light_tank_init();
  scripts\cp_mp\vehicles\little_bird::little_bird_init();
  _calloutmarkerping_poolidisdanger::x1stash_removequestinstance();
  scripts\cp_mp\vehicles\tac_rover::tac_rover_init();
  scripts\cp_mp\vehicles\large_transport::large_transport_init();
  scripts\cp_mp\vehicles\pickup_truck::pickup_truck_init();
  scripts\cp_mp\vehicles\jeep::jeep_init();
  scripts\cp_mp\vehicles\med_transport::med_transport_init();
  scripts\cp_mp\vehicles\van::van_init();
  _calloutmarkerping_poolidisentity::_id_11D60();
  _calloutmarkerping_isvehicleoccupiedbyenemy::bot_gulag_think();
  _calloutmarkerping_handleluinotify_mappingdeletemarker::bomber_init();
  _calloutmarkerping_isenemy::get_priority_player();
  _calloutmarkerping_iskiosk::get_num_of_wire_to_cut();
  _calloutmarkerping_poolidisloot::_id_12102();
  _calloutmarkerping_predicted_isanypingactive::_id_120D2();
  _calloutmarkerping_isplunderextract::hvi_vehicle_rider_special_setup();
  _calloutmarkerping_onpingchallenge::startarmsracedef2obj();
}

isvehicle() {
  return isDefined(self.vehiclename);
}

isvehicledestroyed() {
  return istrue(self.isdestroyed);
}

vehiclecanfly() {
  var_0 = vehicle_getleveldataforvehicle(self.vehiclename);

  if(isDefined(var_0))
    return istrue(var_0.canfly);

  return undefined;
}

vehicle_getleveldataforvehicle(var_0, var_1) {
  var_2 = level.vehicle.vehicledata[var_0];

  if(!isDefined(var_2)) {
    if(istrue(var_1)) {
      var_2 = spawnStruct();
      level.vehicle.vehicledata[var_0] = var_2;
      var_2._id_13FCA = undefined;
      var_2.destroycallback = undefined;
      var_2.canfly = undefined;
    }
  }

  return var_2;
}

_id_14138(var_0, var_1, var_2) {
  var_0.maxhealth = 2147483647;
  var_0.health = var_0.maxhealth;
  var_0.vehiclename = var_1;
  var_0 setnodeploy(1);
  var_0 makeunusable();

  if(isDefined(var_2.owner))
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setoriginalowner(var_0, var_2.owner);

  if(isDefined(var_2.team))
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(var_0, var_2.team);
  else
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(var_0, "_encstr_A7A408B9CA5D1D4E2C63");

  var_0 scripts\cp_mp\emp_debuff::set_start_emp_callback(::vehicle_empstartcallback);
  var_0 scripts\cp_mp\emp_debuff::set_clear_emp_callback(::vehicle_empclearcallback);
  scripts\cp_mp\utility\weapon_utility::setlockedoncallback(var_0, ::vehicle_lockedoncallback);
  scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback(var_0, ::vehicle_lockedonremovedcallback);
  scripts\cp_mp\utility\weapon_utility::_id_13162(var_0, ::_id_1419A);
  scripts\cp_mp\utility\weapon_utility::_id_13163(var_0, ::_id_1419B);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_registerinstance(var_0);

  if(!scripts\common\utility::iscp() || !istrue(var_2.disableusabilityatspawn))
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_registerinstance(var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_8AEA073693CA16D12B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_8AEA073693CA16D12B")]](var_0, var_2);

  thread _id_14226(var_0);
}

_id_14139(var_0, var_1) {
  var_0 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(1);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(var_0, var_1.owner, var_1.team);
  scripts\cp_mp\vehicles\vehicle_dlog::vehicle_dlog_spawnevent(var_0, var_1.spawntype);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_888E0BC69CCA85A32B318547B2"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_888E0BC69CCA85A32B318547B2")]](var_0, var_1);
}

_id_14185(var_0) {
  if(isDefined(var_0) && istrue(var_0.isdestroyed)) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(level._id_1425A) && isDefined(var_0._id_12970))
    thread[[level._id_1425A]](var_0, var_0._id_12970);

  var_0 notify("_encstr_AD75063D571AE108");
  var_0.isdestroyed = 1;

  if(isDefined(var_0.ondeathrespawn))
    var_0 thread[[var_0.ondeathrespawn]]();

  var_0 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  var_0 setnonstick(1);
  scripts\cp_mp\utility\weapon_utility::clearlockedon(var_0);
  var_0 scripts\cp_mp\emp_debuff::clear_emp(1);
  _calloutmarkerping_predicted_timeout::_id_14123(var_0);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14141(var_0);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_deregisterinstance(var_0);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_8E761050226DB3F317C63DABD4B3FB03958A"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_8E761050226DB3F317C63DABD4B3FB03958A")]](var_0);
}

_id_14186(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_deregisterinstance(var_0);
  scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_deregisterinstance(var_0.vehiclename, var_0 getentitynumber());

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_8F471472BFB1A1B955F655C833C49B09537A903B940D"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_8F471472BFB1A1B955F655C833C49B09537A903B940D")]](var_0);

  var_1 = _id_14193(var_0);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1)
    var_3 delete();
  }

  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(var_0);
}

_id_14197(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_BECC055CF3811A"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_BECC055CF3811A")]](var_0);

  var_1 = _id_14193(var_0);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1)
    var_3 hide();
  }

  var_0 hide();
}

_id_14226(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = vehicle_getleveldataforvehicle(var_0.vehiclename);
  thread _calloutmarkerping_predicted_log::_id_1411B(var_0);

  while(isDefined(var_0)) {
    var_2 = spawnStruct();
    scripts\cp_mp\utility\vehicle_omnvar_utility::_id_14282(var_0);
    _id_14103(var_0);

    if(isDefined(var_1._id_13FCA))
      var_0[[var_1._id_13FCA]](var_2);

    var_0 scripts\cp\vehicles\vehicle_compass_cp::_id_1424B();
    waitframe();
  }
}

_id_14105(var_0) {
  if(isDefined(var_0._id_1426C)) {
    if(var_0._id_1426C != "_encstr_B40101") {
      var_1 = var_0 vehicle_getvelocity();
      var_2 = anglesToForward(var_0.angles);

      if(vectordot(var_1, var_2) >= 0) {
        if(var_0 getscriptableparthasstate("_encstr_8AA6067362614831", var_0._id_1426C))
          var_0 setscriptablepartstate("_encstr_8AA6067362614831", var_0._id_1426C);
      } else if(var_0 getscriptableparthasstate("_encstr_8AA6067362614831", var_0._id_1426C + "_encstr_83AE0686341410C5"))
        var_0 setscriptablepartstate("_encstr_8AA6067362614831", var_0._id_1426C + "_encstr_83AE0686341410C5");
    }
  }
}

_id_14103(var_0) {
  if(!var_0 scripts\cp_mp\vehicles\vehicle_tracking::_issuspendedvehicle() && !istrue(var_0 vehiclecanfly()) && !var_0 vehicle_isonground()) {
    var_1 = var_0 vehicle_getvelocity();

    if(var_1[2] >= 75 && length2dsquared(var_1) <= 100) {
      if(!isDefined(var_0._id_12289))
        var_0._id_12289 = gettime();

      if(gettime() - var_0._id_12289 >= 650) {
        var_2 = (128, 128, 128);
        var_3 = var_0.origin - var_2;
        var_4 = var_0.origin + var_2;
        var_5 = physics_aabbbroadphasequery(var_3, var_4, physics_createcontents(["_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA"]), var_0);

        foreach(var_7 in var_5) {
          if(isDefined(var_7) && var_7 scripts\cp_mp\killstreaks\helper_drone::unset_relic_noks() && !istrue(var_7.isdestroyed)) {
            var_7 thread scripts\cp_mp\killstreaks\helper_drone::helperdroneexplode(0);
            var_0._id_12289 = undefined;
          }
        }

        return;
      }

      return;
    }

    var_0._id_12289 = undefined;
    return;
  } else
    var_0._id_12289 = undefined;
}

_id_14207(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1.objweapon))
    var_1.objweapon = var_2;

  if(!isDefined(var_0.turrets))
    var_0.turrets = [];

  var_5 = undefined;

  if(isDefined(var_4))
    var_5 = var_4;
  else if(isstring(var_2))
    var_5 = var_2;
  else
    var_5 = var_2.basename;

  var_0.turrets[var_5] = var_1;
  var_6 = var_0.childoutlineents;

  if(!isDefined(var_6))
    var_6 = [var_0];

  if(!scripts\engine\utility::array_contains(var_6, var_1))
    var_6 = scripts\engine\utility::array_add(var_6, var_1);

  var_0.childoutlineents = var_6;

  if(istrue(var_3))
    thread _id_14221(var_0, var_1);
}

_id_14188(var_0, var_1) {
  if(!isDefined(var_0.turrets)) {
    return;
  }
  var_2 = undefined;

  if(isstring(var_1))
    var_2 = var_1;
  else
    var_2 = var_1.basename;

  var_3 = var_0.turrets[var_2];
  var_0.turrets[var_2] = undefined;

  if(isDefined(var_3)) {
    var_4 = var_0.childoutlineents;

    if(isDefined(var_4)) {
      var_4 = scripts\engine\utility::array_remove(var_4, var_3);
      var_0.childoutlineents = var_4;
    }

    var_3 notify("_encstr_A6601E863BB0AC77C9A9F9535397BFE4E9B31A0A4338BA0B60A0522ABBFBDBDF");
  }
}

_id_14192(var_0, var_1) {
  if(!isDefined(var_0.turrets))
    return undefined;

  var_2 = undefined;

  if(isstring(var_1))
    var_2 = var_1;
  else
    var_2 = var_1.basename;

  return var_0.turrets[var_2];
}

_id_14191(var_0, var_1) {
  if(!isDefined(var_0.turrets))
    return undefined;

  return var_0.turrets[var_1];
}

_id_14193(var_0) {
  var_1 = [];

  if(isDefined(var_0.turrets))
    var_1 = var_0.turrets;

  return var_1;
}

_id_14221(var_0, var_1) {
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 notify("_encstr_A6601E863BB0AC77C9A9F9535397BFE4E9B31A0A4338BA0B60A0522ABBFBDBDF");
  var_1 endon("_encstr_A6601E863BB0AC77C9A9F9535397BFE4E9B31A0A4338BA0B60A0522ABBFBDBDF");

  for(;;) {
    var_1 waittill("_encstr_ACA30D383847FB93AAFF7705139D4B", var_2);

    if(isDefined(var_2))
      var_2.vehicle = var_0;
  }
}

_id_141B9(var_0, var_1) {
  if(scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DE(var_0))
    return scripts\cp_mp\vehicles\vehicle_occupancy::_id_141E2(var_0, var_1);
  else if(level.teambased) {
    var_2 = var_0.team;

    if(!isDefined(var_2) || var_2 == "_encstr_A7A408B9CA5D1D4E2C63") {
      if(isDefined(var_0.owner))
        var_0.team = var_0.owner.team;
    }

    if(!isDefined(var_2))
      return 0;

    return var_0.team == var_1.team;
  } else
    return isDefined(var_0.owner) && var_0.owner == var_1;
}

_id_141B7(var_0, var_1) {
  if(scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DE(var_0))
    return scripts\cp_mp\vehicles\vehicle_occupancy::_id_141E0(var_0, var_1);
  else if(level.teambased) {
    var_2 = var_0.team;

    if(!isDefined(var_2) || var_2 == "_encstr_A7A408B9CA5D1D4E2C63") {
      if(isDefined(var_0.owner))
        var_0.team = var_0.owner.team;
    }

    if(!isDefined(var_2))
      return 0;

    return var_0.team == var_1.team;
  } else
    return isDefined(var_0.owner) && var_0.owner != var_1;
}

_id_141BB(var_0, var_1) {
  if(scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DE(var_0))
    return scripts\cp_mp\vehicles\vehicle_occupancy::_id_141E4(var_0, var_1);
  else if(level.teambased)
    return (!isDefined(var_0.team) || var_0.team == "_encstr_A7A408B9CA5D1D4E2C63") && !isDefined(var_0.owner);
  else
    return !isDefined(var_0.owner);
}

_id_141BA(var_0, var_1) {
  if(scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DE(var_0))
    return scripts\cp_mp\vehicles\vehicle_occupancy::_id_141E3(var_0, var_1);
  else {
    if(level.teambased)
      return isDefined(var_0.team) && var_0.team == var_1;

    return undefined;
  }
}

_id_141B8(var_0, var_1) {
  if(scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DE(var_0))
    return scripts\cp_mp\vehicles\vehicle_occupancy::_id_141E1(var_0, var_1);
  else {
    if(level.teambased)
      return isDefined(var_0.team) && var_0.team != var_1;

    return undefined;
  }
}

_id_141BC(var_0, var_1) {
  if(scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DE(var_0))
    return scripts\cp_mp\vehicles\vehicle_occupancy::_id_141E5(var_0, var_1);
  else {
    if(level.teambased)
      return !isDefined(var_0.team) || var_0.team == "_encstr_A7A408B9CA5D1D4E2C63";

    return undefined;
  }
}

_id_14190(var_0) {
  if(scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DE(var_0))
    return scripts\cp_mp\vehicles\vehicle_occupancy::_id_141D7(var_0);
  else {
    if(isDefined(var_0.team) && var_0.team != "_encstr_A7A408B9CA5D1D4E2C63")
      return var_0.team;

    return undefined;
  }
}

_id_1418B(var_0, var_1) {
  if(_id_1420D(var_0, var_1)) {
    var_2 = istrue(var_1.inlaststand);
    var_3 = var_1.health;

    if(isDefined(var_0.objweapon))
      level._id_12185 = "_encstr_B45C0E2DFF41B17F437FB870E733FBFF";

    var_1 dodamage(1000, var_0.origin, var_0.owner, var_0, "_encstr_8D4E0A501FCB898912CB3FA3", var_0.objweapon);
    level._id_12185 = undefined;

    if(!isalive(var_1))
      return 1;

    if(!var_2 && istrue(var_1.inlaststand))
      return 1;

    if(var_3 > var_1.health)
      return 1;
  }

  return 0;
}

_id_1420D(var_0, var_1) {
  if(level.teambased) {
    if(level.friendlyfire == 0) {
      if(isDefined(var_0.owner)) {
        if(var_0.owner != var_1) {
          if(var_0.owner.team == var_1.team)
            return 0;
        }
      } else if(isDefined(var_0.team) && var_0.team != "_encstr_A7A408B9CA5D1D4E2C63") {
        if(var_0.team == var_1.team)
          return 0;
      }
    }
  }

  return 1;
}

_id_14203(var_0, var_1) {
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 notify("_encstr_9A9F355E492CEB9F69356950B37A7B1128535FCBF70FFF53AE8D90514B3AE0D875B4763877AFCFECE8A8891BBD8FDEF713AFB693B98B93");
  var_1 endon("_encstr_9A9F355E492CEB9F69356950B37A7B1128535FCBF70FFF53AE8D90514B3AE0D875B4763877AFCFECE8A8891BBD8FDEF713AFB693B98B93");
  var_1.vehiclecollisionignorearray = [];
  var_1.vehiclecollisionignorearray["_encstr_9ADC0A96DCCC36D2B147F64E"] = var_0;
  var_1.vehiclecollisionignorearray["_encstr_975E0ABAE55D37631F972848"] = var_0.objweapon;
  var_1.vehiclecollisionignorearray["_encstr_AC820D90AAA6DD6B377635AD49E330"] = "_encstr_8D4E0A501FCB898912CB3FA3";
  _id_14204(var_1);
  thread _id_14106(var_1);
}

_id_14204(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  wait 2;
}

_id_14106(var_0) {
  var_0 notify("_encstr_9A9F355E492CEB9F69356950B37A7B1128535FCBF70FFF53AE8D90514B3AE0D875B4763877AFCFECE8A8891BBD8FDEF713AFB693B98B93");
  var_0.vehiclecollisionignorearray = undefined;
}

_id_14201(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1.vehiclecollisionignorearray))
    return 0;

  if(!isDefined(var_0))
    return 0;

  if(var_0 != var_1.vehiclecollisionignorearray["_encstr_9ADC0A96DCCC36D2B147F64E"])
    return 0;

  if(!isDefined(var_3))
    return 0;

  if(!scripts\common\utility::iscp()) {
    if(var_3 != var_1.vehiclecollisionignorearray["_encstr_975E0ABAE55D37631F972848"])
      return 0;
  }

  if(var_2 != var_1.vehiclecollisionignorearray["_encstr_AC820D90AAA6DD6B377635AD49E330"])
    return 0;

  return 1;
}

_id_14104(var_0) {
  if(!isDefined(var_0.meansofdeath) || var_0.meansofdeath != "_encstr_8D4E0A501FCB898912CB3FA3")
    return 0;

  if(!isDefined(var_0.inflictor) || !var_0.inflictor isvehicle())
    return 0;

  return 1;
}

vehicle_playerkilledbycollision(var_0) {
  if(!_id_14104(var_0)) {
    return;
  }
  if(var_0.inflictor.vehiclename == "_encstr_9A8F0CB1A5E8471BB2EB894B39C8" || var_0.inflictor.vehiclename == "_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F" || var_0.inflictor.vehiclename == "_encstr_A7B30DE187CA05B92B54B8537A15E8" || var_0.inflictor.vehiclename == "_encstr_9BEF16359B67FDA671371305E0BDB293E166C898324FA18B")
    thread _id_14200(var_0.victim);
  else
    playsoundatpos(var_0.victim.origin, "_encstr_A1F1119D2BA1968DC6ACD731B791CBF534961D");
}

_id_14200(var_0) {
  var_1 = 35;
  var_0.nocorpse = 1;
  playsoundatpos(var_0.origin, "_encstr_A1F1119D2BA1968DC6ACD731B791CBF534961D");
  var_2 = scripts\cp_mp\utility\player_utility::relic_nuketimer_timer();

  if(var_2.size < var_1) {
    var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0 gettagorigin("_encstr_8FE10B52092BB64F28E6B7BFFD"));
    var_3.angles = var_0.angles;
    var_3 setModel("_encstr_A63B10E036C25E2B4EFA46CA0B8E1ABE33F0");
    var_3 setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_88180476B431", 0);

    foreach(var_5 in var_2)
    var_3 hidefromplayer(var_5);

    wait 0.5;
    var_3 delete();
  }
}

vehicle_watchflipped(var_0, var_1, var_2, var_3) {
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_3))
    var_0 endon(var_3);

  var_4 = 0;
  var_5 = undefined;
  var_6 = undefined;

  for(;;) {
    var_7 = 0;
    var_8 = anglestoup(var_0.angles)[2];

    if(var_8 <= 0.0872) {
      var_7 = 1;
      var_5 = undefined;
    } else if(var_8 <= 0.5736) {
      if(!isDefined(var_5))
        var_5 = gettime() + 3000;

      if(gettime() > var_5) {
        var_7 = 1;
        var_5 = undefined;
      }
    } else {
      if(var_4) {
        scripts\cp_mp\vehicles\vehicle_occupancy::_id_141C6(var_0, 1);
        scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse(var_0, 1);
        var_4 = 0;
      }

      var_7 = 0;
      var_5 = undefined;
    }

    if(var_7) {
      if(isDefined(var_1))
        thread[[var_1]](var_0);

      if(!var_4) {
        scripts\cp_mp\vehicles\vehicle_occupancy::_id_141C6(var_0, 0);
        scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse(var_0, 0);
        var_4 = 1;
      }

      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants(var_0);
      var_9 = 0;
      var_6 = gettime() + 3000;

      for(;;) {
        if(vectordot(anglestoup(var_0.angles), (0, 0, 1)) > 0.0872) {
          break;
        }

        if(gettime() >= var_6) {
          var_9 = 1;
          break;
        }

        waitframe();
      }

      var_6 = undefined;

      if(isDefined(var_2))
        thread[[var_2]](var_0, var_9);
    }

    waitframe();
  }
}

vehicle_flippedendcallback(var_0, var_1) {
  if(var_1) {
    var_2 = vehicle_getleveldataforvehicle(var_0.vehiclename);

    if(isDefined(var_2.destroycallback))
      var_0[[var_2.destroycallback]]();
  }
}

vehicle_deletecollmapvehicles() {
  level notify("_encstr_8C3F1EB0521CDB61A37DB015558BE9B907587BE85AF503DBB365239B2BD3D17F");
  level endon("_encstr_8C3F1EB0521CDB61A37DB015558BE9B907587BE85AF503DBB365239B2BD3D17F");
  wait 1;
  var_0 = getEntArray("_encstr_81EF0A9156B12BD159D7B556", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_0) && var_0.size > 0) {
    for(var_1 = var_0.size - 1; var_1 >= 0; var_1--)
      var_0[var_1] delete();
  }
}

vehicle_lockedoncallback() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self, 0);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("_encstr_A3FA0FA331A28318788F91DA3F678A5067", var_0, self.vehiclename);
}

vehicle_lockedonremovedcallback() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self, 0);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("_encstr_A3FA0FA331A28318788F91DA3F678A5067", var_0, self.vehiclename);
}

_id_1419A() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self, 0);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("_encstr_BABE10DAA5DC9B2DC62B52B9B17BDAD2DC3B", var_0, self.vehiclename);
}

_id_1419B() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self, 0);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("_encstr_BABE10DAA5DC9B2DC62B52B9B17BDAD2DC3B", var_0, self.vehiclename);
}

vehicle_empstartcallback(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8B1804DF2043", "_encstr_A1900FD7807F27B47BB85AC2A11B62FFD1"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8B1804DF2043", "_encstr_A1900FD7807F27B47BB85AC2A11B62FFD1")]](var_0);

  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement(self, 0);
}

vehicle_empclearcallback(var_0) {
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement(self, 1);
}

_id_1418F(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "_encstr_86510C82737817CD40B38B720A15":
      var_1 = scripts\cp_mp\vehicles\apc_rus::apc_rus_explode;
      break;
    case "_encstr_8C190467402B":
      var_1 = scripts\cp_mp\vehicles\atv::atv_explode;
      break;
    case "_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6":
      var_1 = scripts\cp_mp\vehicles\cargo_truck::cargo_truck_explode;
      break;
    case "_encstr_BAC20FBEE6F88945F163A37BD68409923B":
      var_1 = _calloutmarkerping_isdropcrate::get_gunshot_alias;
      break;
    case "_encstr_8FE608B268BFF756987D":
      var_1 = scripts\cp_mp\vehicles\cop_car::cop_car_explode;
      break;
    case "_encstr_91CD07D045CF0B0BB8":
      var_1 = scripts\cp_mp\vehicles\hoopty::hoopty_explode;
      break;
    case "_encstr_8BAA0D68183D43A35319057A93B767":
      var_1 = scripts\cp_mp\vehicles\hoopty_truck::hoopty_truck_explode;
      break;
    case "_encstr_85DE05A6B2AC0E":
      var_1 = scripts\cp_mp\vehicles\jeep::jeep_explode;
      break;
    case "_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E":
      var_1 = scripts\cp_mp\vehicles\large_transport::large_transport_explode;
      break;
    case "_encstr_AF390B295782C3585F1B21D8C4":
      var_1 = scripts\cp_mp\vehicles\light_tank::light_tank_explode;
      break;
    case "_encstr_9A8F0CB1A5E8471BB2EB894B39C8":
      var_1 = scripts\cp_mp\vehicles\little_bird::little_bird_explode;
      break;
    case "_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F":
      var_1 = _calloutmarkerping_poolidisdanger::x1spyplane;
      break;
    case "_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301":
      var_1 = scripts\cp_mp\vehicles\med_transport::med_transport_explode;
      break;
    case "_encstr_8FD60D6AA0EAB34083F7C423A0213B":
      var_1 = scripts\cp_mp\vehicles\pickup_truck::pickup_truck_explode;
      break;
    case "_encstr_9A120A1D8536F5E4ED3BB293":
      var_1 = scripts\cp_mp\vehicles\tac_rover::tac_rover_explode;
      break;
    case "_encstr_84D70A6B2BEF3C9B30A67164":
      var_1 = scripts\cp_mp\vehicles\technical::technical_explode;
      break;
    case "_encstr_911904464232":
      var_1 = scripts\cp_mp\vehicles\van::van_explode;
      break;
    case "_encstr_99C20BA548E9F27A61D897932B":
      var_1 = _calloutmarkerping_poolidisentity::_id_11D5D;
      break;
    case "_encstr_BDC80A5437EAD749519A6068":
      var_1 = _calloutmarkerping_isvehicleoccupiedbyenemy::bot_get_stored_custom_classes;
      break;
    case "_encstr_83F40783ADF1D14AA3":
      var_1 = _calloutmarkerping_handleluinotify_mappingdeletemarker::create_script_wait_for_flags;
      break;
    case "_encstr_BE820B53A080CF0245ADFC77B7":
      var_1 = _calloutmarkerping_onpingchallenge::start_trap_room_combat;
      break;
    case "_encstr_97AE0AF6E0959BEB4D2B95C1":
      var_1 = _calloutmarkerping_poolidisloot::_id_12100;
      break;
    case "_encstr_91F511673FA9BB292DD8BAE321179E73A328F3":
      var_1 = _calloutmarkerping_predicted_isanypingactive::_id_120CB;
      break;
    case "_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB":
      var_1 = _calloutmarkerping_isenemy::get_power_ref_from_weapon;
      break;
    case "_encstr_8D860D49508DBBF831085BF0335F07":
      var_1 = _calloutmarkerping_isplunderextract::hvi_patrol_exit;
      break;
  }

  return var_1;
}
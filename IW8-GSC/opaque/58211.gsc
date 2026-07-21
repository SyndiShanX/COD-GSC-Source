/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58211.gsc
***********************************************/

get_most_recent_ping() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", "_encstr_BAF609D2739647C4853A2B", ::get_moves_till_stop);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", "_encstr_8AEA073693CA16D12B", ::get_most_recent_danger_ping);
  scripts\engine\utility::create_func_ref("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", ::_id_134F8);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::get_nearest_point_near_objective);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", _calloutmarkerping_iskiosk::get_num_dogtag_in_kill_zone_or_under_bridge_zone);
}

get_moves_till_stop() {
  if(1) {
    return;
  }
  level.get_reinforcement_icon_image = [];
  var_0 = scripts\engine\utility::getStructArray("_encstr_AFED17935FA3773D094883FA985FF36F9B371937EE4BB7C3D5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread get_most_recent_location_ping(var_0, 3);
}

get_most_recent_location_ping(var_0, var_1) {
  wait(var_1);
  var_2 = getdvarint("_encstr_8F7A0BD1E5E15304B8CF7989FF", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0) {
      var_5 = spawnStruct();
      var_5.origin = var_4.origin;
      var_5.angles = var_4.angles;
      var_6 = _calloutmarkerping_iskiosk::get_next_available_wire_for_bomb(var_5);

      if(isDefined(var_6))
        level.get_reinforcement_icon_image = scripts\engine\utility::array_add(level.get_reinforcement_icon_image, var_6);
    }
  }
}

get_most_recent_danger_ping(var_0) {
  var_0.maxhealth = 2300;
  var_0.health = var_0.maxhealth;
}

_id_134F8(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 100);
  var_1.angles = var_0.angles * (0, 1, 0);
  var_1.owner = var_0;
  var_2 = _calloutmarkerping_iskiosk::get_next_available_wire_for_bomb(var_1);

  if(isDefined(var_2))
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_2, "_encstr_9AE307B956E345D0AB", var_0, undefined, 1);
}

convert_aitruck_to_playertruck(var_0) {
  var_0 notify("_encstr_AD75063D571AE108");
  var_0.vehiclename = "_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843";
  var_0.maxhealth = 999999;
  var_0.health = var_0.maxhealth;
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(var_0, "_encstr_A7A408B9CA5D1D4E2C63");
  var_0.objweapon = getcompleteweaponname("_encstr_8FC20FAB0B58176F7853C3BB994A774DA0");
  var_0 makeunusable();
  var_0 setCanDamage(1);
  var_0 scripts\cp_mp\emp_debuff::set_start_emp_callback(scripts\cp_mp\vehicles\vehicle::vehicle_empstartcallback);
  var_0 scripts\cp_mp\emp_debuff::set_clear_emp_callback(scripts\cp_mp\vehicles\vehicle::vehicle_empclearcallback);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_registerinstance(var_0);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_registerinstance(var_0);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(var_0);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(var_0, undefined, undefined);
  scripts\cp_mp\vehicles\vehicle_dlog::vehicle_dlog_spawnevent(var_0, undefined);
  var_1 = scripts\cp_mp\utility\weapon_utility::setlockedoncallback;
  [[var_1]](var_0, scripts\cp_mp\vehicles\vehicle::vehicle_lockedoncallback);
  var_2 = scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback;
  [[var_2]](var_0, scripts\cp_mp\vehicles\vehicle::vehicle_lockedonremovedcallback);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_0, undefined, scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", "_encstr_8AEA073693CA16D12B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", "_encstr_8AEA073693CA16D12B")]](var_0);

  return var_0;
}

get_nearest_point_near_objective(var_0, var_1) {
  if(1) {
    return;
  }
  var_2 = _calloutmarkerping_iskiosk::get_next_available_wire_for_bomb(var_0, var_1);

  if(isDefined(var_2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::get_nearby_enemy_in_tvstation;

  return var_2;
}

get_nearby_enemy_in_tvstation() {
  thread get_new_wire_look_at_marker_currently_looking_at();
}

get_new_wire_look_at_marker_currently_looking_at() {
  var_0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var_0);
  var_1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843")) {
      var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", var_0, var_1);

      if(!isDefined(var_2)) {
        continue;
      }
      break;
    }
  }
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58213.gsc
***********************************************/

function bot_gametype_human_player_always_considered_attacker() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh_a10fd", "initLate", &bot_gametype_human_player_always_considered_defender);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh_a10fd", "create", &bot_gametype_get_players_by_role);
  scripts\engine\utility::create_func_ref("veh_a10fd", &ref_134f4);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh_a10fd", "spawnCallback", &bot_gametype_initialize_attacker_defender_role);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("veh_a10fd", &_calloutmarkerping_isvehicleoccupiedbyenemy::bot_get_stored_custom_classes);
}

function bot_gametype_human_player_always_considered_defender() {
  if(true) {
    return;
  }

  level.br_allowdropspawnafterprematch = [];
  var_0 = scripts\engine\utility::getStructArray("veh_a10fd", "targetname");
  thread bot_gametype_human_player_always_attacker(var_0, 3);
}

function bot_gametype_human_player_always_attacker(var_0, var_1) {
  wait var_1;
  var_2 = getdvarint("LLQQOPKTKM", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0) {
      var_5 = spawnStruct();
      var_5.origin = var_4.origin;
      var_5.angles = var_4.angles;
      var_6 = _calloutmarkerping_isvehicleoccupiedbyenemy::bot_gametype_set_role(var_5);

      if(isDefined(var_6)) {
        level.br_allowdropspawnafterprematch = scripts\engine\utility::array_add(level.br_allowdropspawnafterprematch, var_6);
      }
    }

    return;
  }
}

function bot_gametype_get_players_by_role(var_0) {
  var_0.maxhealth = 3500;
  var_0.health = var_0.maxhealth;
}

function ref_134f4(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 100);
  var_1.angles = var_0.angles * (0, 1, 0);
  var_1.owner = var_0;
  var_2 = _calloutmarkerping_isvehicleoccupiedbyenemy::bot_gametype_set_role(var_1);

  if(isDefined(var_2)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_2, "pilot", var_0, undefined, 1);
    return;
  }
}

function bot_gametype_initialize_attacker_defender_role(var_0, var_1) {
  if(true) {
    return;
  }

  var_2 = _calloutmarkerping_isvehicleoccupiedbyenemy::bot_gametype_set_role(var_0, var_1);

  if(isDefined(var_2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn()) {
    var_2.ondeathrespawn = &bot_gametype_human_player_always_defender;
  }

  return var_2;
}

function bot_gametype_human_player_always_defender() {
  thread bot_gametype_radios_precached();
}

function bot_gametype_radios_precached() {
  var_0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var_0);
  var_1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("veh_a10fd")) {
      var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("veh_a10fd", var_0, var_1);

      if(!isDefined(var_2)) {
        continue;
      }

      break;
    }
  }
}
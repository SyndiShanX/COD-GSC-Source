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
  var0 = scripts\engine\utility::getStructArray("veh_a10fd", "targetname");
  thread bot_gametype_human_player_always_attacker(var0, 3);
}

function bot_gametype_human_player_always_attacker(var0, var1) {
  wait var1;
  var2 = getdvarint("LLQQOPKTKM", 0) == 0;

  if(var2) {
    foreach(var4 in var0) {
      var5 = spawnStruct();
      var5.origin = var4.origin;
      var5.angles = var4.angles;
      var6 = _calloutmarkerping_isvehicleoccupiedbyenemy::bot_gametype_set_role(var5);

      if(isDefined(var6)) {
        level.br_allowdropspawnafterprematch = scripts\engine\utility::array_add(level.br_allowdropspawnafterprematch, var6);
      }
    }

    return;
  }
}

function bot_gametype_get_players_by_role(var0) {
  var0.maxhealth = 3500;
  var0.health = var0.maxhealth;
}

function ref_134f4(var0) {
  var1 = spawnStruct();
  var1.origin = var0.origin + (0, 0, 100);
  var1.angles = var0.angles * (0, 1, 0);
  var1.owner = var0;
  var2 = _calloutmarkerping_isvehicleoccupiedbyenemy::bot_gametype_set_role(var1);

  if(isDefined(var2)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var2, "pilot", var0, undefined, 1);
    return;
  }
}

function bot_gametype_initialize_attacker_defender_role(var0, var1) {
  if(true) {
    return;
  }

  var2 = _calloutmarkerping_isvehicleoccupiedbyenemy::bot_gametype_set_role(var0, var1);

  if(isDefined(var2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &bot_gametype_human_player_always_defender;
  }

  return var2;
}

function bot_gametype_human_player_always_defender() {
  thread bot_gametype_radios_precached();
}

function bot_gametype_radios_precached() {
  var0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var0);
  var1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("veh_a10fd")) {
      var2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("veh_a10fd", var0, var1);

      if(!isDefined(var2)) {
        continue;
      }

      break;
    }
  }
}
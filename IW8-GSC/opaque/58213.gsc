/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58213.gsc
***********************************************/

bot_gametype_human_player_always_considered_attacker() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BDC80A5437EAD749519A6068", "_encstr_BAF609D2739647C4853A2B", ::bot_gametype_human_player_always_considered_defender);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BDC80A5437EAD749519A6068", "_encstr_8AEA073693CA16D12B", ::bot_gametype_get_players_by_role);
  scripts\engine\utility::create_func_ref("_encstr_BDC80A5437EAD749519A6068", ::_id_134F4);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BDC80A5437EAD749519A6068", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::bot_gametype_initialize_attacker_defender_role);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("_encstr_BDC80A5437EAD749519A6068", _calloutmarkerping_isvehicleoccupiedbyenemy::bot_get_stored_custom_classes);
}

bot_gametype_human_player_always_considered_defender() {
  if(1) {
    return;
  }
  level.br_allowdropspawnafterprematch = [];
  var_0 = scripts\engine\utility::getStructArray("_encstr_BDC80A5437EAD749519A6068", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread bot_gametype_human_player_always_attacker(var_0, 3);
}

bot_gametype_human_player_always_attacker(var_0, var_1) {
  wait(var_1);
  var_2 = getdvarint("_encstr_8F7A0BD1E5E15304B8CF7989FF", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0) {
      var_5 = spawnStruct();
      var_5.origin = var_4.origin;
      var_5.angles = var_4.angles;
      var_6 = _calloutmarkerping_isvehicleoccupiedbyenemy::bot_gametype_set_role(var_5);

      if(isDefined(var_6))
        level.br_allowdropspawnafterprematch = scripts\engine\utility::array_add(level.br_allowdropspawnafterprematch, var_6);
    }
  }
}

bot_gametype_get_players_by_role(var_0) {
  var_0.maxhealth = 3500;
  var_0.health = var_0.maxhealth;
}

_id_134F4(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 100);
  var_1.angles = var_0.angles * (0, 1, 0);
  var_1.owner = var_0;
  var_2 = _calloutmarkerping_isvehicleoccupiedbyenemy::bot_gametype_set_role(var_1);

  if(isDefined(var_2))
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_2, "_encstr_A266062032BD7723", var_0, undefined, 1);
}

bot_gametype_initialize_attacker_defender_role(var_0, var_1) {
  if(1) {
    return;
  }
  var_2 = _calloutmarkerping_isvehicleoccupiedbyenemy::bot_gametype_set_role(var_0, var_1);

  if(isDefined(var_2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::bot_gametype_human_player_always_defender;

  return var_2;
}

bot_gametype_human_player_always_defender() {
  thread bot_gametype_radios_precached();
}

bot_gametype_radios_precached() {
  var_0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var_0);
  var_1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("_encstr_BDC80A5437EAD749519A6068")) {
      var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_BDC80A5437EAD749519A6068", var_0, var_1);

      if(!isDefined(var_2)) {
        continue;
      }
      break;
    }
  }
}
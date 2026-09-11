/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\whizby.gsc
***********************************************/

function calloutmarkerping_init() {
  scripts\cp\vehicles\little_bird_mg_cp::fulton_actors_players();
  level.maxteamsize = 4;
  fulton();
  scripts\cp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_onplayerdisconnect);
  level.brloottablename = "cp/cp_loot_item_defs.csv";
  scripts\cp_mp\utility\script_utility::registersharedfunc("ping", "ping_cp_getCPVehicleCallout", &fullweaponobj);
}

function fulton() {
  setDvar("scr_calloutmarkerping_death_timeout_navigation", 40);
  setDvar("scr_calloutmarkerping_death_timeout_danger", 5);
  setDvar("scr_calloutmarkerping_death_timeout_entity", 20);
  setDvar("scr_calloutmarkerping_death_timeout_world", 40);
  setDvar("scr_calloutmarkerping_death_timeout_vehicle", 20);
  setDvar("scr_calloutmarkerping_death_timeout_loot", 10);
  setDvar("scr_calloutmarkerping_death_timeout_quest_loot", 40);
  setDvar("scr_calloutmarkerping_death_timeout_request", 10);
}

function fullweaponobj(var_0) {
  var_1 = spawnStruct();
  var_1.ref_142f4 = "";
  var_1.fail_on_transmission_timeout = 0;

  if(isDefined(var_0.infected_music)) {
    switch (var_0.infected_music) {
      case "techo_physics_cp":
      case "techo":
      case "techo_non_phys":
      case "decho":
      case "technical_ai_plr":
      case "pindia":
        var_1.ref_142f4 = "ping_enemy_vehicle_light";
        var_1.fail_on_transmission_timeout = 1;
        return var_1;
      case "armoredtruck":
      case "umike_covered_physics":
      case "umike_physics":
      case "vindia_a2":
      case "mkilo23_physics":
      case "veh8_mil_lnd_mkilo23_rus":
      case "veh8_mil_lnd_mkilo23":
        var_1.ref_142f4 = "ping_enemy_vehicle_heavy";
        var_1.fail_on_transmission_timeout = 1;
        return var_1;
      case "attack_heli":
        var_1.ref_142f4 = "ping_killstreaks_helo";
        var_1.fail_on_transmission_timeout = 1;
        return var_1;
      default:
        break;
    }

    return;
  }

  if(isDefined(var_0.stop_all_ascend_anims)) {
    switch (var_0.stop_all_ascend_anims) {
      case "techo_phys_convoy_cp":
      case "decho_green":
      case "decho_physics_sp":
      case "techo_whitedirty":
      case "techo_white":
      case "techo_physics_cp":
      case "techo":
      case "techo_non_phys":
      case "decho":
      case "technical_ai_plr":
      case "pindia":
      case "techo_phys":
      case "hindia_physics_mp":
        var_1.ref_142f4 = "ping_enemy_vehicle_light";
        var_1.fail_on_transmission_timeout = 1;
        return var_1;
      case "umike_physics_sp":
      case "armoredtruck":
      case "umike_covered_physics":
      case "umike_physics":
      case "vindia_physics_sp":
      case "mkilo23_ai_infil":
      case "mkilo_physics_cp":
      case "vindia_a2":
      case "mkilo23_physics":
      case "veh8_mil_lnd_mkilo23_rus":
      case "veh8_mil_lnd_mkilo23":
      case "truck":
        var_1.ref_142f4 = "ping_enemy_vehicle_heavy";
        var_1.fail_on_transmission_timeout = 1;
        return var_1;
      case "mindia8_jugg":
      case "mindia8":
      case "lbravo_carrier":
      case "mindia8_closed":
      case "mindia8_cp":
      case "blima_exfil":
      case "lbravo_carrier_east":
      case "lbravo_guns_east":
      case "lbravo_guns":
      case "lbravo_infil_cp":
      case "lbravo_ambient":
      case "blima":
      case "lbravo":
      case "lbravo_ai_infil":
      case "attack_heli":
        var_1.ref_142f4 = "ping_killstreaks_helo";
        var_1.fail_on_transmission_timeout = 1;
        return var_1;
      default:
        break;
    }

    return;
  }
}

function ref_131a7(var_0) {
  var_1 = self;
  var_1.br_squadindex = var_0;
  var_2 = var_1.game_extrainfo & 65528;
  var_2 |= var_0;
  var_1.game_extrainfo = var_2;
}

function ref_13263(var_0) {
  if(isDefined(var_0.br_squadindex)) {
    return;
  }

  if(level.teambased) {
    var_1 = [];

    for(var_2 = 1; var_2 < level.maxteamsize + 1; var_2++) {
      var_1 = var_2;
    }

    var_3 = level.players;

    foreach(var_5 in var_3) {
      if(isDefined(var_5.br_squadindex)) {
        var_1 = scripts\engine\utility::array_remove(var_1, var_5.br_squadindex);
      }
    }

    if(var_1.size == 0) {
      return;
    }

    var_7 = var_1[0];
    ref_131a7(var_0, var_7);
    return;
  }
}
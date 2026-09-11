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

function fullweaponobj(var0) {
  var1 = spawnStruct();
  var1.ref_142f4 = "";
  var1.fail_on_transmission_timeout = 0;

  if(isDefined(var0.infected_music)) {
    switch (var0.infected_music) {
      case "techo_physics_cp":
      case "techo":
      case "techo_non_phys":
      case "decho":
      case "technical_ai_plr":
      case "pindia":
        var1.ref_142f4 = "ping_enemy_vehicle_light";
        var1.fail_on_transmission_timeout = 1;
        return var1;
      case "armoredtruck":
      case "umike_covered_physics":
      case "umike_physics":
      case "vindia_a2":
      case "mkilo23_physics":
      case "veh8_mil_lnd_mkilo23_rus":
      case "veh8_mil_lnd_mkilo23":
        var1.ref_142f4 = "ping_enemy_vehicle_heavy";
        var1.fail_on_transmission_timeout = 1;
        return var1;
      case "attack_heli":
        var1.ref_142f4 = "ping_killstreaks_helo";
        var1.fail_on_transmission_timeout = 1;
        return var1;
      default:
        break;
    }

    return;
  }

  if(isDefined(var0.stop_all_ascend_anims)) {
    switch (var0.stop_all_ascend_anims) {
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
        var1.ref_142f4 = "ping_enemy_vehicle_light";
        var1.fail_on_transmission_timeout = 1;
        return var1;
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
        var1.ref_142f4 = "ping_enemy_vehicle_heavy";
        var1.fail_on_transmission_timeout = 1;
        return var1;
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
        var1.ref_142f4 = "ping_killstreaks_helo";
        var1.fail_on_transmission_timeout = 1;
        return var1;
      default:
        break;
    }

    return;
  }
}

function ref_131a7(var0) {
  var1 = self;
  var1.br_squadindex = var0;
  var2 = var1.game_extrainfo & 65528;
  var2 |= var0;
  var1.game_extrainfo = var2;
}

function ref_13263(var0) {
  if(isDefined(var0.br_squadindex)) {
    return;
  }

  if(level.teambased) {
    var1 = [];

    for(var2 = 1; var2 < level.maxteamsize + 1; var2++) {
      var1 = var2;
    }

    var3 = level.players;

    foreach(var5 in var3) {
      if(isDefined(var5.br_squadindex)) {
        var1 = scripts\engine\utility::array_remove(var1, var5.br_squadindex);
      }
    }

    if(var1.size == 0) {
      return;
    }

    var7 = var1[0];
    ref_131a7(var0, var7);
    return;
  }
}
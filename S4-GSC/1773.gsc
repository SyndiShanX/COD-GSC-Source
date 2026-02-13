/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1773.gsc
*************************************************/

_id_2F97() {
  _id_078A::_id_2F98();
  _id_0958::_id_C285(_id_078A::_id_2FA0);
  level._id_2BEB = "cp/cp_loot_item_defs.csv";
  scripts\cp_mp\utility\script_utility::registersharedfunc("ping", "ping_cp_getCPVehicleCallout", ::_id_2F7F);
}

_id_2F7F(var_0) {
  var_1 = spawnStruct();
  var_1._id_1068E = "";
  var_1._id_2C52 = 0;

  if(isDefined(var_0._id_3E2D)) {
    switch (var_0._id_3E2D) {
      case "techo_physics_cp":
      case "technical_ai_plr":
      case "pindia":
      case "decho":
      case "techo_non_phys":
      case "techo":
        var_1._id_1068E = "ping_enemy_vehicle_light";
        var_1._id_2C52 = 1;
        return var_1;
      case "mkilo23_physics":
      case "veh8_mil_lnd_mkilo23_rus":
      case "veh8_mil_lnd_mkilo23":
      case "umike_covered_physics":
      case "umike_physics":
      case "vindia_a2":
      case "armoredtruck":
        var_1._id_1068E = "ping_enemy_vehicle_heavy";
        var_1._id_2C52 = 1;
        return var_1;
      case "attack_heli":
        var_1._id_1068E = "ping_killstreaks_helo";
        var_1._id_2C52 = 1;
        return var_1;
      default:
    }
  } else if(isDefined(var_0._id_7E4C)) {
    switch (var_0._id_7E4C) {
      case "decho_green":
      case "techo_whitedirty":
      case "techo_white":
      case "decho_physics_sp":
      case "techo_phys_convoy_cp":
      case "techo_physics_cp":
      case "technical_ai_plr":
      case "pindia":
      case "decho":
      case "techo_non_phys":
      case "techo":
      case "techo_phys":
      case "hindia_physics_mp":
        var_1._id_1068E = "ping_enemy_vehicle_light";
        var_1._id_2C52 = 1;
        return var_1;
      case "mkilo23_ai_infil":
      case "vindia_physics_sp":
      case "umike_physics_sp":
      case "mkilo_physics_cp":
      case "mkilo23_physics":
      case "veh8_mil_lnd_mkilo23_rus":
      case "veh8_mil_lnd_mkilo23":
      case "umike_covered_physics":
      case "umike_physics":
      case "vindia_a2":
      case "armoredtruck":
      case "truck":
        var_1._id_1068E = "ping_enemy_vehicle_heavy";
        var_1._id_2C52 = 1;
        return var_1;
      case "mindia8_closed":
      case "blima_exfil":
      case "lbravo_ai_infil":
      case "lbravo_carrier_east":
      case "lbravo_guns_east":
      case "lbravo_guns":
      case "lbravo_ambient":
      case "blima":
      case "mindia8_cp":
      case "lbravo":
      case "lbravo_infil_cp":
      case "attack_heli":
      case "mindia8_jugg":
      case "mindia8":
      case "lbravo_carrier":
        var_1._id_1068E = "ping_killstreaks_helo";
        var_1._id_2C52 = 1;
        return var_1;
      default:
    }
  }
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\calloutmarkerping_cp.gsc
***********************************************/

calloutmarkerping_init() {
  scripts\cp_mp\calloutmarkerping::calloutmarkerping_initcommon();
  level.maxteamsize = 4;
  calloutmarkerping_cp_setupcptimeouts();
  scripts\cp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(scripts\cp_mp\calloutmarkerping::calloutmarkerping_onplayerdisconnect);

  if(!isDefined(level.brloottablename))
    level.brloottablename = "cp/loot/default/loot_item_defs.csv";

  scripts\cp_mp\utility\script_utility::registersharedfunc("ping", "ping_cp_getCPVehicleCallout", ::calloutmarkerping_cp_getcpvehiclevocallout);
}

calloutmarkerping_cp_setupcptimeouts() {
  setDvar("dvar_7C74D4814E0665D5", 40.0);
  setDvar("dvar_ABE00A149EB51FC0", 20.0);
  setDvar("dvar_F1ED16D72234A0CC", 20.0);
  setDvar("dvar_F2B483D963525879", 40.0);
  setDvar("dvar_D25A3E0BE5E90C21", 20.0);
  setDvar("dvar_4710528047B1660D", 20.0);
  setDvar("dvar_817BED798637D38E", 40.0);
  setDvar("dvar_4DA39A287B93388C", 20.0);
  setDvar("dvar_DCAB804F9C532B7F", 7.0);
}

calloutmarkerping_cp_getcpvehiclevocallout(_id_F5013BAE6266622F) {
  result = spawnStruct();
  result.vocalloutstring = "";
  result.bshouldreturnvalue = 0;

  if(isDefined(_id_F5013BAE6266622F.cpvehiclename)) {
    switch (_id_F5013BAE6266622F.cpvehiclename) {
      case "techo_physics_cp":
      case "technical_ai_plr":
      case "pindia":
      case "techo_non_phys":
      case "techo":
      case "decho":
        result.vocalloutstring = "ping_enemy_vehicle_light";
        result.bshouldreturnvalue = 1;
        return result;
      case "mkilo23_physics":
      case "veh8_mil_lnd_mkilo23_rus":
      case "veh8_mil_lnd_mkilo23":
      case "armoredtruck":
      case "umike_covered_physics":
      case "umike_physics":
      case "vindia_a2":
        result.vocalloutstring = "ping_enemy_vehicle_heavy";
        result.bshouldreturnvalue = 1;
        return result;
      case "exfil_heli":
      case "attack_heli":
        result.vocalloutstring = "ping_killstreaks_helo";
        result.bshouldreturnvalue = 1;
        return result;
      default:
    }
  } else if(isDefined(_id_F5013BAE6266622F.infil_name)) {
    switch (_id_F5013BAE6266622F.infil_name) {
      case "decho_green":
      case "techo_phys":
      case "techo_whitedirty":
      case "techo_white":
      case "decho_physics_sp":
      case "techo_phys_convoy_cp":
      case "hindia_physics_mp":
      case "techo_rebel":
      case "techo_physics_cp":
      case "technical_ai_plr":
      case "pindia":
      case "techo_non_phys":
      case "techo":
      case "decho":
        result.vocalloutstring = "ping_enemy_vehicle_light";
        result.bshouldreturnvalue = 1;
        return result;
      case "mkilo23_ai_infil":
      case "vindia_physics_sp":
      case "umike_physics_sp":
      case "mkilo_physics_cp":
      case "mkilo23_physics":
      case "veh8_mil_lnd_mkilo23_rus":
      case "veh8_mil_lnd_mkilo23":
      case "armoredtruck":
      case "umike_covered_physics":
      case "umike_physics":
      case "vindia_a2":
      case "truck":
        result.vocalloutstring = "ping_enemy_vehicle_heavy";
        result.bshouldreturnvalue = 1;
        return result;
      case "mindia8_closed":
      case "blima_exfil":
      case "lbravo_ai_infil":
      case "lbravo_carrier_east":
      case "lbravo_carrier":
      case "lbravo_guns_east":
      case "lbravo_guns":
      case "lbravo_ambient":
      case "mindia8":
      case "lbravo_infil_cp":
      case "mindia8_cp":
      case "attack_heli":
      case "lbravo":
      case "blima":
        result.vocalloutstring = "ping_killstreaks_helo";
        result.bshouldreturnvalue = 1;
        return result;
      default:
    }
  } else {}
}

setplayersquadindex(squadindex) {
  player = self;
  player.br_squadindex = squadindex;
  _id_573AA6BE0B25ACD9 = player.game_extrainfo & 65528;
  _id_573AA6BE0B25ACD9 = _id_573AA6BE0B25ACD9 | squadindex;
  player.game_extrainfo = _id_573AA6BE0B25ACD9;
}

setuppingspecificvars(player) {
  if(isDefined(player.br_squadindex)) {
    return;
  }
  if(level.teambased) {
    _id_0A900EBD15FE91F5 = [];

    for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < level.maxteamsize + 1; _id_AC0E594AC96AA3A8++)
      _id_0A900EBD15FE91F5[_id_0A900EBD15FE91F5.size] = _id_AC0E594AC96AA3A8;

    _id_A6AB8D0FDA441DC2 = level.players;

    foreach(_id_F90358454413407F in _id_A6AB8D0FDA441DC2) {
      if(isDefined(_id_F90358454413407F.br_squadindex))
        _id_0A900EBD15FE91F5 = scripts\engine\utility::array_remove(_id_0A900EBD15FE91F5, _id_F90358454413407F.br_squadindex);
    }

    if(_id_0A900EBD15FE91F5.size == 0) {
      return;
    }
    _id_55667D1B713C209D = _id_0A900EBD15FE91F5[0];
    player setplayersquadindex(_id_55667D1B713C209D);
    return;
  }
}
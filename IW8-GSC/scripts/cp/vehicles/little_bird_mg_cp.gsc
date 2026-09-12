/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\little_bird_mg_cp.gsc
*****************************************************/

function fulton_actors_players() {
  thread fulton_used();
}

function fulton_ac130_model(var_0, var_1) {
  var_2 = self;
  calloutmarkerping_removecallout(var_2, var_0);
  var_3 = getdvarint("scr_calloutmarkerping_zoffset_entity_enemy", 82);
  var_4 = var_1.origin + (0, 0, var_3);
  var_5 = 1;
  var_6 = var_2 sethasspecialistbonus(1);
  var_7 = getdvarint("MRPQRTKTLQ", 3);
  var_8 = var_2 sethasspecialistbonus(2);

  if(var_8 < var_6 && var_7 > 1) {
    var_6 = var_8;
    var_5 = 2;
  }

  var_9 = var_2 sethasspecialistbonus(3);

  if(var_9 < var_6 && var_7 > 2) {
    var_6 = var_9;
    var_5 = 3;
  }

  var_2 calloutmarkerping_create(var_5, var_4, 0);
  thread addquestrewardtierframeend(var_2);
  addquestrewardtier("Enemy switched to danger");
}

function addquestrewardtier(var_0) {}

function addpostlaunchspawns(var_0) {
  return var_0 == 9 || var_0 == 10 || var_0 == 11;
}

function addplundercarrycredit(var_0) {
  return var_0 == 4 || var_0 == 5 || var_0 == 6;
}

function addplayeraslootleader(var_0) {
  return var_0 == 1 || var_0 == 2 || var_0 == 3;
}

function addquestrewardtierframeend(var_0, var_1, var_2) {
  var_3 = self;
  level endon("game_ended");
  var_3 endon("disconnect");
  var_4 = 2;
  var_5 = undefined;

  if(addplundercarrycredit(var_0)) {
    var_6 = var_3 calloutmarkerping_getsavedzoffset(var_0);

    if(isDefined(var_6)) {
      var_7 = getdvarint("scr_calloutmarkerping_track_player_switch_to_danger", 1);

      if(var_7 && additionalrecondronetargets(var_6, var_3)) {
        if(isDefined(level.ref_11A32) && getDvar("scr_br_gametype", "") == "kingslayer" && scripts\engine\utility::array_contains(level.ref_11A32, var_6)) {
          var_4 = getdvarfloat("scr_calloutmarkerping_track_king_time", 0);
        } else {
          var_4 = getdvarfloat("scr_calloutmarkerping_track_player_time", 3);
        }

        var_5 = var_6;
        addquestrewardtier("Enemy tracked!");

        if(!istrue(var_2)) {
          var_6.update_bomb_vest_lua = 1;
        }
      }

      thread fulton_interactions_disabled(var_3, var_0);

      if(isDefined(var_5) && istrue(var_2)) {
        return;
      }
    }
  }

  var_3 notify("predictiveCalloutClear_" + var_0);
  var_3 endon("predictiveCalloutClear_" + var_0);

  if(addpostlaunchspawns(var_0)) {
    var_8 = var_3 calloutmarkerping_getsavedzoffset(var_0);
    thread calloutmarkerping_watchscriptabledeath(var_3, var_0);
  } else if(var_0 == 0) {
    if(getdvarint("scr_calloutmarkerping_navigation_proximity_cancel", 0)) {
      thread fulton_create();
    }
  } else if(var_0 == 8) {
    var_8 = var_3 calloutmarkerping_getsavedzoffset(var_0);
    thread fulton_interactions_disabled(var_3, var_0);
    thread fulton_handledamage(var_3, var_0);
  } else if(var_0 == 7) {
    var_9 = self getnodeoffset_code(7);

    if(var_9 == -1) {
      calloutmarkerping_removecallout(var_0);
    } else {
      thread fulton_refundsuper(var_3, var_0);
      thread fulton_planted(var_3, var_0);
    }
  } else if(var_0 == 12) {
    thread fulton_open(var_3, 12);
  }

  if(!isDefined(var_5)) {
    var_4 = fulton_actors(var_3, var_0);
  }

  addquestrewardtier("Timeout value before wait: " + var_4 + " | poolID: " + var_0);
  wait var_4;

  if(isDefined(var_5) && isDefined(var_3)) {
    if(isDefined(var_5.update_bomb_vest_lua)) {
      var_5.update_bomb_vest_lua = undefined;
    }

    thread fulton_ac130_model(var_3, var_0);
    return;
  }

  addquestrewardtier("Pool timed out: " + var_0);
  calloutmarkerping_removecallout(var_3, var_0);
}

function addpowerbutton() {
  var_0 = self;

  for(var_1 = 0; var_1 < 13; var_1++) {
    if(var_0 calloutmarkerping_getfeedback(var_1)) {
      return var_1;
    }
  }

  return -1;
}

function addproptolist() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("disconnect");

  for(;;) {
    var_0 waittill("luinotifyserver", var_1, var_2, var_3);

    if(!isDefined(var_1) || !isDefined(var_2)) {
      continue;
    }

    addquestrewardtier("Notification " + var_1 + " on pool " + var_2);

    switch (var_1) {
      case "calloutmarkerping_added":
        addallkillstreaksunlocked(var_0, var_2);
        break;
      case "calloutmarkerping_cleared":
        addbattlepassxpmultiplier(var_0, var_2);
        break;
      case "calloutmarkerping_acknowledged":
        addaccesscard(var_0, var_2, var_3);
        break;
      case "calloutmarkerping_acknowledged_cancel":
        addaliasarraytoqueue(var_0, var_2);
        break;
      case "calloutmarkerping_enemy_repinged":
        adddroponplayerdeath(var_0, var_2);
        break;
      case "map_ping_delete_marker":
        addedcollision(var_0);
        break;
      case "br_inventory_slot_request":
        addallkillstreaksunlockedinonelife(var_0, var_2);
        break;
      default:
        break;
    }
  }
}

function calloutmarkerping_initplayer() {
  var_0 = self;

  if(!isDefined(var_0.fxrings)) {
    var_0.fxrings = [];
  }

  if(!isDefined(var_0.fulton_repositoryatcapacitycallback)) {
    var_0.fulton_repositoryatcapacitycallback = [];
  }

  thread addproptolist();
}

function addscriptedspawnpoints(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  var_1 = var_0 getscriptablepartnameatindex(0);

  if(!isDefined(var_1)) {
    return false;
  }

  var_2 = var_0 getscriptablepartstate(var_1, 1);

  if(!isDefined(var_2)) {
    return false;
  }

  var_3 = var_0 getscriptablepartstatefield(var_1, var_2, "type");

  if(!isDefined(var_3)) {
    return false;
  }

  if(var_3 != "useable") {
    return false;
  }

  return true;
}

function additionalrecondronetargets(var_0, var_1) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(!isPlayer(var_0) && !isagent(var_0)) {
    return false;
  }

  if(!isDefined(var_0.team)) {
    return false;
  }

  if(var_0.team == "neutral") {
    return false;
  }

  return var_0.team != var_1.team;
}

function addjuggsettings(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(!isent(var_0)) {
    return (issubstr(var_0.type, "brloot_plunder_extraction") || issubstr(var_0.type, "equip_fulton_mp"));
  }

  if(!isDefined(var_0.model)) {
    return false;
  }

  return var_0.model == "military_skyhook_far_ch3";
}

function addlaststandoverheadiconcallback(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(!isent(var_0)) {
    return false;
  }

  if(!isDefined(var_0.model)) {
    return false;
  }

  return var_0.model == "br_skyhook_extraction_base_01_ch3" || var_0.model == "lm_military_skyhook_extraction_01_ch3" || istrue(var_0.isslingermodel);
}

function addincoming(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isent(var_0)) {
    return 0;
  }

  if(!isDefined(var_0.cratetype)) {
    return 0;
  }

  switch (var_0.cratetype) {
    case "medical_crate":
    case "bonus_points_crate":
    case "heavy_weapon_crate":
    case "extra_life_crate":
    case "battle_royale_decon":
    case "battle_royale_tactical_device":
    case "battle_royale_chopper_loot":
    case "battle_royale_loadout":
    case "battle_royale_c130_loot":
    case "battle_royale_juggernaut":
    case "manual_turret":
    case "killstreak":
    case "juggernaut":
      return 1;
    default:
      return 0;
  }
}

function addexecutionquip(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.vehiclename)) {
    return false;
  }

  return var_0.vehiclename == "cargo_truck_mg";
}

function fulton_crate_model_playclosedidle(var_0) {
  return isDefined(var_0.equipmentref) && var_0.equipmentref == "equip_supportBox";
}

function addjuggernautcharge(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(!var_0 getscriptableisloot()) {
    return false;
  }

  if(var_0.type != "br_plunder_box") {
    return false;
  }

  return true;
}

function fulton_cancreate(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(!isent(var_0)) {
    return false;
  }

  if(!isDefined(var_0.classname)) {
    return false;
  }

  return issubstr(var_0.classname, "grenade") || issubstr(var_0.classname, "c4_") || issubstr(var_0.classname, "proximity_explosive_") || issubstr(var_0.classname, "claymore_");
}

function fullweaponname(var_0, var_1) {
  if(var_0 ismlgspectator() || var_0 isspectatingplayer()) {
    return false;
  }

  if(!isalive(var_0)) {
    return false;
  }

  if(istrue(var_0.mapmarkermodeenabled) && !isDefined(var_1)) {
    return false;
  }

  if(istrue(var_0.gulag)) {
    return false;
  }

  if(var_0 scripts\cp_mp\utility\player_utility::isusingremote()) {
    return false;
  }

  return true;
}

function remove_punchcard(var_0) {
  switch (var_0) {
    case 0:
      return undefined;
    case 1:
      return undefined;
    case 2:
      return undefined;
    case 3:
      return undefined;
    case 10:
      return "ping_need_gun";
    case 4:
      return "ping_need_armor";
    case 5:
      return "ping_need_midcal";
    case 6:
      return "ping_need_shells";
    case 7:
      return "ping_need_smallcal";
    case 8:
      return "ping_need_launcher";
    case 9:
      return "ping_need_highcal";
    default:
      break;
  }

  return undefined;
}

function remove_prohibited_weapons(var_0) {
  if(!isDefined(var_0)) {
    return "";
  }

  switch (var_0) {
    case 0:
      return "plunder";
    case 10:
      return "weapon";
    case 4:
      return "brloot_armor_plate";
    case 3:
      return "brloot_equip_gasmask";
    case 5:
      return "brloot_ammo_762";
    case 6:
      return "brloot_ammo_12g";
    case 7:
      return "brloot_ammo_919";
    case 8:
      return "brloot_ammo_rocket";
    case 9:
      return "brloot_ammo_50cal";
    case 2:
    case 1:
      return "unsupported";
    default:
      return "";
  }
}

function fulton_handlefataldamage(var_0) {
  var_1 = self;

  if(!fullweaponname(var_1)) {
    return;
  }

  var_2 = var_1 calloutmarkerping_getfeedback(12);

  if(var_2) {
    var_3 = var_1 isdismembermentenabledforplayer(12);
    calloutmarkerping_removecallout(var_1, 12);

    if(var_3 == var_0) {
      fulton_deletenextframe(var_1, "br_ping_cancel", 12);
      return;
    }
  }

  var_4 = getdvarint("scr_calloutmarkerping_zoffset_danger", 82);
  var_5 = (0, 0, var_4);
  var_1 calloutmarkerping_create(12, var_5, var_0);
  thread addquestrewardtierframeend(var_1, 12);
  thread fxred(var_1);
}

function fxred(var_0) {
  var_1 = self;
  wait getdvarfloat("scr_calloutmarkerping_delay_between_vo_and_sfx_secs_inventory", 0.5);
  var_2 = remove_punchcard(var_0);

  if(isDefined(var_2) && isDefined(var_1)) {
    fxent2(var_1, var_2, 12);
    return;
  }
}

function add_track_points(var_0) {
  var_1 = self;

  if(isalive(var_1)) {
    return;
  }

  if(!addpostlaunchspawns(var_0)) {
    return;
  }

  var_2 = var_1 calloutmarkerping_getsavedzoffset(var_0);

  if(!addjuggernautcharge(var_2)) {
    return;
  }

  var_1 notify("buybackRequested");
}

function fulton_hostage_vo() {}

function fulton_repositoryusecallback(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  var_1 = self;
  var_2 = var_1 calloutmarkerping_getsavedzoffset(var_0);
  var_3 = undefined;

  if(addpostlaunchspawns(var_0)) {
    var_4 = undefined;
    var_5 = 0;
    var_6 = 0;
    var_7 = 0;
    var_8 = 0;

    if(isDefined(var_2)) {
      var_4 = var_2;
    } else {
      return;
    }

    if(isDefined(var_4)) {
      var_5 = var_4 scriptableisdoor();

      if(var_5) {
        var_6 = var_4 scriptabledoorisclosed();
      } else {
        var_7 = var_4 isplayerheadless();
      }

      var_8 = addscriptedspawnpoints(var_4);
    }

    if(var_7 && !var_8 || var_5 && !var_6) {
      var_3 = "ping_location_looted";
    } else if(var_5) {
      return;
    } else if(isDefined(var_4) && isDefined(var_4.entity)) {
      if(addincoming(var_4.entity)) {
        var_3 = "ping_killstreaks_carepkg";
      } else if(istrue(var_4.entity.isportablekiosk) || istrue(var_4.entity.isblackmarketkiosk)) {
        var_3 = "ping_plunder_vendor";
      } else if(istrue(var_4.entity.isjuggernaut)) {
        var_3 = "ping_killstreaks_juggernaut";
      } else if(addjuggsettings(var_2)) {
        var_3 = "ping_plunder_bank";
      } else if(addexecutionquip(var_4.entity)) {
        var_3 = "ping_vehicle_heavy";
      } else if(istrue(var_4.entity.use_vehicle_turret)) {
        var_3 = "ping_pickup_generic";
      } else if(istrue(var_4.entity.unset_relic_noregen)) {
        var_3 = "ping_location_generic";
      } else if(addlaststandoverheadiconcallback(var_4.entity)) {
        var_3 = "ping_location_generic";
      }
    } else {
      var_3 = fusesound(var_1, var_0, var_2);
    }
  } else if(addplundercarrycredit(var_0)) {
    var_3 = fuselit(var_1, var_0, var_2);
  } else if(addplayeraslootleader(var_0)) {
    var_3 = "ping_enemy_general";
  } else {
    switch (var_0) {
      case 0:
        if(level.gametype == "br" && isDefined(var_1.br_infil_type)) {
          if(istrue(var_1.tutorial_usingparachute)) {
            var_3 = "ping_location_landing";
          } else {
            var_3 = "ping_location_landing_suggestion";
          }
        } else {
          var_3 = "ping_location_generic";
        }

        break;
      case 8:
        var_3 = fx_ent_index(var_1, var_0, var_2);
        break;
      case 7:
        var_3 = fx_ents(var_1, var_0);
        break;
      default:
        break;
    }
  }

  fxent2(var_1, var_3, var_0);
}

function addplayerasexpiredlootleader(var_0) {
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "onPing")) {
    return;
  }

  if(addpostlaunchspawns(var_0)) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onPing")]]("object");
    return;
  }

  if(addplundercarrycredit(var_0)) {
    var_1 = self calloutmarkerping_getsavedzoffset(var_0);

    if(isDefined(var_1)) {
      if(additionalrecondronetargets(var_1, self)) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onPing")]]("enemy");
        return;
      }

      if(!isPlayer(var_1)) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onPing")]]("object");
        return;
      }

      return;
    }

    return;
  }

  if(addplayeraslootleader(var_0)) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onPing")]]("danger");
    return;
  }

  switch (var_0) {
    case 12:
    case 8:
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onPing")]]("object");
      break;
    case 7:
    case 0:
      break;
  }
}

function fuselit(var_0, var_1) {
  var_2 = self;

  if(isDefined(var_1) && isent(var_1)) {
    var_3 = var_1;
  } else {
    return "";
  }

  if(isPlayer(var_3) && var_3.team == self.team) {
    return "ping_response_helpme";
  } else if(isDefined(var_3.juggcontext) || istrue(var_3.isjuggernaut)) {
    return "ping_killstreaks_juggernaut";
  } else if(fulton_crate_model_playclosedidle(var_3)) {
    return "ping_pickup_generic";
  } else if(isDefined(var_3.equipmentref) && var_3.equipmentref == "equip_armorBox") {
    return "ping_pickup_armor";
  } else if(fulton_cancreate(var_3)) {
    return "ping_enemy_traps";
  } else if(addjuggsettings(var_3)) {
    return "ping_plunder_bank";
  } else if(isPlayer(var_3) && istrue(var_3.inlaststand) && var_3.team != self.team) {
    var_4 = fx_model(var_2, "flavor_player_execution");
    var_5 = fx_obj(var_2, "flavor_player_execution");

    if(isDefined(var_4) && isDefined(var_5)) {
      var_6 = soundexists(var_4);
      var_7 = soundexists(var_5);

      if(istrue(var_6) && istrue(var_7)) {
        return "flavor_player_execution";
      }
    }
  } else if(var_3.model == "military_ammo_restock_location") {
    return "ping_pickup_generic";
  } else if(var_3.model == "ammo_restock_location_ch3") {
    return "ping_pickup_generic";
  } else if(issubstr(var_3.model, "offhand_wm_container_gas_tank") || var_3.model == "offhand_wm_jerrycan_thrown") {
    return "ping_ammo_grenadelethal";
  } else if(scripts\mp\utility\entity::isturret(var_3)) {
    if(isDefined(var_3.owner) && var_3.owner.team != self.team) {
      return "ping_killstreaks_shieldturret_enemy";
    }

    return "ping_killstreaks_shieldturret_open";
  } else if(issubstr(var_3.model, "train_")) {
    return "ping_location_generic";
  } else if(issubstr(var_3.model, "cuniform")) {
    return "ping_killstreaks_scrambler";
  }

  return "ping_enemy_infantry";
}

function fx_ent_index(var_0, var_1) {
  var_2 = self;

  if(isDefined(var_1) && isent(var_1)) {
    var_3 = var_1;
  } else {
    return "";
  }

  if(isDefined(var_3.streakname)) {
    switch (var_3.streakname) {
      case "gunship":
        return "ping_killstreaks_gunship";
      case "chopper_gunner":
        return "ping_killstreaks_helo";
      case "radar_drone_recon":
        return "ping_killstreaks_recon";
      case "pac_sentry":
        return "ping_killstreaks_recon";
      case "assault_drone":
        return "equipment_incoming_generic";
      default:
        break;
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("ping", "ping_cp_getCPVehicleCallout")) {
    var_4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("ping", "ping_cp_getCPVehicleCallout")]](var_3);

    if(isDefined(var_4) && istrue(var_4.fail_on_transmission_timeout)) {
      return var_4.ref_142F4;
    }
  }

  if(!isDefined(var_3.vehiclename)) {
    return "ping_vehicle_concat_no_driver";
  }

  var_5 = addplatepouch(var_3, var_2.team);
  var_6 = isDefined(var_3.ownerteam) && var_3.ownerteam == var_2.team;

  if(istrue(var_5)) {
    switch (var_3.vehiclename) {
      case "veh_indigo":
      case "open_jeep":
      case "cargo_truck_susp":
      case "veh_a10fd":
      case "motorcycle":
      case "open_jeep_carpoc":
      case "van":
      case "technical":
      case "tac_rover":
      case "pickup_truck":
      case "jeep":
      case "cargo_truck":
      case "atv":
        return "ping_enemy_vehicle_light";
      case "cargo_truck_susp_aa":
      case "veh_bt":
      case "cargo_truck_mg":
      case "apc_russian":
        return "ping_enemy_vehicle_heavy";
      case "little_bird_mg":
      case "little_bird":
        return "ping_killstreaks_helo";
      case "light_tank":
        return "ping_killstreaks_cobalt";
      case "hover_jet":
        return "ping_killstreaks_ravager";
      case "pac_sentry":
        return "ping_killstreaks_wheelson";
      case "magma_plunder_chopper":
        return "ping_vehicle_helo";
      default:
        break;
    }

    return;
  }

  if(istrue(var_6)) {
    switch (var_3.vehiclename) {
      case "veh_indigo":
      case "open_jeep":
      case "cargo_truck_susp":
      case "veh_bt":
      case "veh_a10fd":
      case "motorcycle":
      case "open_jeep_carpoc":
      case "van":
      case "technical":
      case "tac_rover":
      case "pickup_truck":
      case "large_transport":
      case "jeep":
      case "cargo_truck":
      case "atv":
        return "ping_vehicle_light";
      case "cargo_truck_susp_aa":
      case "light_tank":
      case "cargo_truck_mg":
      case "apc_russian":
        return "ping_vehicle_heavy";
      case "magma_plunder_chopper":
      case "little_bird_mg":
      case "little_bird":
        return "ping_vehicle_helo";
      default:
        break;
    }

    return;
  }

  switch (var_3.vehiclename) {
    case "veh_indigo":
    case "open_jeep":
    case "cargo_truck_susp":
    case "veh_a10fd":
    case "motorcycle":
    case "open_jeep_carpoc":
    case "van":
    case "technical":
    case "tac_rover":
    case "pickup_truck":
    case "large_transport":
    case "jeep":
    case "cargo_truck":
    case "atv":
      return "ping_vehicle_light";
    case "convoy_truck":
    case "cargo_truck_susp_aa":
    case "veh_bt":
    case "light_tank":
    case "cargo_truck_mg":
    case "apc_russian":
      return "ping_vehicle_heavy";
    case "magma_plunder_chopper":
    case "loot_chopper":
    case "little_bird_mg":
    case "little_bird":
      return "ping_vehicle_helo";
    case "escort_truck":
      return "ping_vehicle_light";
    default:
      break;
  }
}

function fx_ents(var_0) {
  var_1 = self;

  if(level.gametype != "br") {
    return "ping_location_generic";
  }

  var_2 = var_1 getnodeoffset_code(7);

  if(isDefined(level.questinfo) && isDefined(level.questinfo.quests) && isDefined(level.questinfo.quests["vip"]) && isDefined(level.questinfo.quests["vip"].instances)) {
    foreach(var_4 in level.questinfo.quests["vip"].instances) {
      var_5 = var_4.objectiveiconid;

      if(!isDefined(var_5)) {
        continue;
      }

      if(var_5 == var_2) {
        return "ping_enemy_infantry";
      }
    }
  }

  var_7 = var_1 calloutmarkerping_entityzoffset("ui_br_objective_index");

  if(!isDefined(var_7) || var_7 == 0) {
    return "ping_location_generic";
  }

  var_8 = tablelookup("mp/brmissions.csv", 0, var_7, 1);

  switch (var_8) {
    case "sabotage":
    case "x2_amb_signal":
    case "x2_stash":
    case "x2_map":
    case "x2_signal":
    case "x2_amb1":
    case "x2_bomb":
    case "x1fin":
    case "history":
    case "x1stash":
    case "assassination":
    case "smokinggun":
    case "blueprintextract":
      if(func_load_difficulty_table(var_1, "ping_objective_contract")) {
        return "ping_objective_contract";
      }

      return "ping_location_generic";
    case "lep":
    case "scavenger_adler":
    case "scavenger":
      if(func_load_difficulty_table(var_1, "ping_objective_contract")) {
        return "ping_objective_contract";
      }

      return "ping_objective_device";
    case "timedrun":
      if(func_load_difficulty_table(var_1, "ping_objective_contract")) {
        return "ping_objective_contract";
      }

      return "ping_plunder_vendor";
    default:
      break;
  }

  return "ping_location_generic";
}

function fusesound(var_0, var_1) {
  var_2 = self;

  if(isDefined(var_1) && isDefined(var_1.type)) {
    var_3 = var_1.type;
  } else {
    return "";
  }

  var_4 = 0;
  var_5 = tablelookupgetnumrows(level.brloottablename);
  var_6 = undefined;

  for(var_7 = var_4; var_7 < var_5; var_7++) {
    var_8 = tablelookupbyrow(level.brloottablename, var_7, 1);

    if(var_8 == var_3) {
      var_6 = tablelookupbyrow(level.brloottablename, var_7, 12);

      if(var_6 == "") {}

      break;
    }
  }

  if(!isDefined(var_6)) {
    if(var_3 == "brloot_plunder_extraction_site_01" || var_3 == "brloot_plunder_extraction_site_02" || var_3 == "equip_fulton_mp") {
      if(func_load_difficulty_table(var_2, "ping_vehicle_cash_deposit_helo")) {
        return "ping_vehicle_cash_deposit_helo";
      }

      return "ping_plunder_bank";
    } else if(var_3 == "ks_airdrop_crate_br") {
      return "ping_plunder_cache";
    } else if(var_3 == "br_carriable_propane" || var_3 == "br_carriable_neurotoxin" || var_3 == "br_carriable_gasoline") {
      return "ping_ammo_grenadelethal";
    } else if(var_3 == "scriptable_skyhook_placed" || var_3 == "broken_atm_scriptable" || var_3 == "br_loot_cursed_chest" || var_3 == "br_doomstation") {
      return "ping_location_generic";
    } else if(isDefined(var_1) && isDefined(var_1.classname) && var_1.classname == "scriptable_br_military_ammo_restock_noent") {
      return "ping_pickup_generic";
    }

    return "";
  }

  var_9 = "";

  if(issubstr(var_6, "_PLUNDER_CASH")) {
    var_9 = "ping_plunder_loot";
  } else if(issubstr(var_6, "MENDOTA/INTEL") || issubstr(var_6, "MENDOTA/KILLSTREAK")) {
    var_9 = "ping_pickup_generic";
  } else if(issubstr(var_6, "ARMORY_KIOSK")) {
    if(!isalive(var_2)) {
      var_9 = "ping_aidstation";
    } else {
      var_9 = "ping_plunder_vendor";
    }
  } else if(issubstr(var_6, "WINE_BOTTLE") || issubstr(var_6, "SHOVEL")) {
    var_9 = "ping_pickup_generic";
  } else if(issubstr(var_6, "HATCH_SHORT")) {
    var_9 = "ping_location_generic";
  } else if(issubstr(var_6, "PORTABLE_KIOSK")) {
    var_9 = "ping_plunder_vendor";
  } else if(issubstr(var_6, "ARMORY_TRADER")) {
    var_9 = "ping_location_generic";
  } else if(issubstr(var_6, "_SHOTGUN")) {
    var_9 = "ping_ammo_shotgun";
  } else if(issubstr(var_6, "_AMMO_LAUNCHER")) {
    var_9 = "ping_ammo_launcher";
  } else if(issubstr(var_6, "_SNIPER")) {
    var_9 = "ping_ammo_highcal";
  } else if(issubstr(var_6, "_AR_LMG")) {
    var_9 = "ping_ammo_midcaliber";
  } else if(issubstr(var_6, "_PISTOL_SMG")) {
    var_9 = "ping_ammo_smallcal";
  } else if(issubstr(var_6, "ARMOR") || var_6 == "EQUIPMENT/BR_PLATE_POUCH") {
    var_9 = "ping_pickup_armor";
  } else if(issubstr(var_6, "_AR")) {
    var_9 = "ping_weapon_assaultrifle";
  } else if(issubstr(var_6, "_SM")) {
    var_9 = "ping_weapon_smg";
  } else if(issubstr(var_6, "_SH")) {
    var_9 = "ping_weapon_shotgun";
  } else if(issubstr(var_6, "_PI")) {
    var_9 = "ping_weapon_pistol";
  } else if(issubstr(var_6, "_SN")) {
    var_9 = "ping_weapon_sniper";
  } else if(issubstr(var_6, "_LM")) {
    var_9 = "ping_weapon_lmg";
  } else if(issubstr(var_6, "_LA")) {
    var_9 = "ping_weapon_launcher";
  } else if(var_6 == "MP/BR_TYPE_ME_RIOTSHIELD" || var_6 == "MP/BR_TYPE_ME_COMBATSHIELD") {
    var_9 = "ping_pickup_riotshield";
  } else if((issubstr(var_6, "_ME") || var_6 == "MP/BR_TYPE_GENERIC_KN") && !issubstr(var_6, "_METAL")) {
    var_9 = "ping_weapon_melee";
  } else if(issubstr(var_6, "CONCUSSION") || issubstr(var_6, "DECOY") || issubstr(var_6, "FLASH") || issubstr(var_6, "GAS_BR") || issubstr(var_6, "SMOKE") || issubstr(var_6, "SNAPSHOT") || issubstr(var_6, "EMP_GADGET_BR") || issubstr(var_6, "NUMBERS_GRENADE")) {
    var_9 = "ping_ammo_grenadetactical";
  } else if(issubstr(var_6, "HEARTBEAT") || issubstr(var_6, "BINOCULARS")) {
    var_9 = "ping_pickup_generic";
  } else if(issubstr(var_6, "ATMINE") || issubstr(var_6, "CLAYMORE") || issubstr(var_6, "C4") || issubstr(var_6, "FRAG") || issubstr(var_6, "SEMTEX") || issubstr(var_6, "THERMITE") || issubstr(var_6, "THROWING") || issubstr(var_6, "MOLOTOV")) {
    var_9 = "ping_ammo_grenadelethal";
  } else if(issubstr(var_6, "TACTICAL_COVER") || issubstr(var_6, "TROPHY") || issubstr(var_6, "RECONDRONE") || issubstr(var_6, "EMPDRONE") || issubstr(var_6, "DEADSILENCE") || issubstr(var_6, "AMMO_DROP") || issubstr(var_6, "ARMOR_DROP") || issubstr(var_6, "SUPPORT_BOX") || issubstr(var_6, "TAC_INSERT") || issubstr(var_6, "ADVANCED_SUPPLY_DROP") || issubstr(var_6, "NOVA_BOX") || issubstr(var_6, "DECON_STATION") || issubstr(var_6, "KIOSK_DROP") || issubstr(var_6, "JAMMER") || issubstr(var_6, "SERUM_GADGET_BR") || issubstr(var_6, "MP_BR_INGAME_TU_WZ345/SLINGER")) {
    if(func_load_difficulty_table(var_2, "ping_pickup_fieldupgrade")) {
      var_9 = "ping_pickup_fieldupgrade";
    } else {
      var_9 = "ping_pickup_generic";
    }
  } else if(issubstr(var_6, "CONTRACT")) {
    if(issubstr(var_6, "ASSASSIN")) {
      var_9 = "ping_initial_contract_bounty";
    } else if(issubstr(var_6, "DOMINATION")) {
      var_9 = "ping_initial_contract_recon";
    } else if(issubstr(var_6, "SCAVENGER")) {
      var_9 = "ping_initial_contract_scavenger";
    } else if(issubstr(var_6, "VIP")) {
      var_9 = "ping_initial_contract_mostwanted";
    } else if(issubstr(var_6, "EXTRACT")) {
      var_9 = "ping_initial_contract_ctrabandextract";
    } else if(issubstr(var_6, "TIMEDRUN")) {
      var_9 = "ping_initial_contract_supplyrun";
    }

    if(var_9 != "" && !func_load_difficulty_table(var_2, var_9)) {
      var_9 = "";
    }

    if(var_9 == "") {
      var_9 = "ping_pickup_generic";
    }

    if(var_9 != "" && !func_load_difficulty_table(var_2, var_9)) {
      var_9 = "";
    }

    if(var_9 == "") {
      var_9 = "ping_pickup_generic";
    }
  } else if(issubstr(var_6, "GASMASK")) {
    if(func_load_difficulty_table(var_2, "ping_gasmask")) {
      var_9 = "ping_gasmask";
    } else {
      var_9 = "ping_pickup_generic";
    }
  } else if(issubstr(var_6, "RESPAWN_TOKEN") || issubstr(var_6, "LOOT_CACHE")) {
    var_9 = "ping_pickup_generic";
  } else if(var_6 == "EQUIPMENT/ADRENALINE_BR" || var_6 == "MP_BR_INGAME/KIOSK_ITEM_SELF_REVIVE") {
    var_9 = "ping_pickup_health";
  } else if(var_6 == "KILLSTREAKS/MANUAL_TURRET") {
    var_9 = "ping_killstreaks_shieldturret_open";
  } else if(issubstr(var_6, "ACCESS_CARD")) {
    if(func_load_difficulty_table(var_2, "ping_loot_accesscard")) {
      var_9 = "ping_loot_accesscard";
    } else {
      var_9 = "ping_pickup_generic";
    }
  } else if(issubstr(var_6, "KILLSTREAK") || var_6 == "SATELLITE_HUNT/HARP") {
    var_9 = "ping_pickup_generic";
  } else if(issubstr(var_6, "_PLUNDER_EXTRACT")) {
    if(func_load_difficulty_table(var_2, "ping_cash_deposit_balloon")) {
      var_9 = "ping_cash_deposit_balloon";
    } else {
      var_9 = "ping_plunder_bank";
    }
  } else if(issubstr(var_6, "COOP_CRAFTING")) {
    var_9 = "ping_pickup_generic";
  } else if(issubstr(var_6, "SPECIALISTBONUS")) {
    var_9 = "ping_pickup_generic";
  } else if(issubstr(var_6, "CARGOTRAIN")) {
    var_9 = "ping_location_generic";
  } else if(issubstr(var_6, "TRAMWAY")) {
    var_9 = "ping_location_generic";
  } else if(issubstr(var_6, "GONDOLA")) {
    var_9 = "ping_location_generic";
  } else if(issubstr(var_6, "LOOT_CARD_X1_CYPHER_TITLE")) {
    var_9 = "ping_pickup_generic";
  } else if(issubstr(var_6, "ESCAPE_RADIO")) {
    var_9 = "ping_pickup_generic";
  } else if(issubstr(var_6, "LOOT_CARD_X2_TNT_TITLE")) {
    var_9 = "ping_pickup_generic";
  } else if(issubstr(var_6, "X2_LEGEND_TRAIN")) {
    var_9 = "ping_pickup_generic";
  } else if(issubstr(var_6, "R2_TACTICAL_DEVICE")) {
    var_9 = "ping_pickup_generic";
  } else if(issubstr(var_6, "ADVANCED_VEHICLE_DROP")) {
    var_9 = "ping_pickup_generic";
  } else if(issubstr(var_6, "DOGTAG_TITLE")) {
    var_9 = "ping_pickup_generic";
  } else if(issubstr(var_6, "VAULT_KEYCARD")) {
    var_9 = "ping_pickup_generic";
  } else if(issubstr(var_6, "RBRTH_LOCKER_KEYCARD")) {
    var_9 = "ping_pickup_generic";
  } else if(issubstr(var_6, "REWARD_EXTRA_LIFE")) {
    var_9 = "ping_pickup_generic";
  } else if(issubstr(var_6, "GASOLINE_CAN_MP")) {
    var_9 = "ping_ammo_grenadelethal";
  } else if(issubstr(var_6, "SPEED_BOOST")) {
    var_9 = "ping_pickup_generic";
  } else if(issubstr(var_6, "KILLMONGER")) {
    var_9 = "ping_pickup_generic";
  } else if(issubstr(var_6, "DOUBLE_POINTS")) {
    var_9 = "ping_pickup_generic";
  } else if(issubstr(var_6, "PERKS")) {
    var_9 = "ping_pickup_generic";
  } else if(issubstr(var_6, "PERKPOINT")) {
    var_9 = "ping_pickup_generic";
  } else if(issubstr(var_6, "TOKEN")) {
    var_9 = "ping_pickup_generic";
  } else if(issubstr(var_6, "ZXP")) {
    var_9 = "ping_pickup_generic";
  } else if(issubstr(var_6, "MP_BR_INGAME_TU_WZ350/BR_BOMBSITE")) {
    var_9 = "ping_location_generic";
  } else if(issubstr(var_6, "MP_BR_INGAME_TU_WZ350/BR_BOMB")) {
    var_9 = "ping_pickup_generic";
  } else if(issubstr(var_6, "MP_BR_INGAME_TU_WZ350/BR_DEFUSEKIT")) {
    var_9 = "ping_pickup_generic";
  } else if(issubstr(var_6, "MP_BR_INGAME_TU_WZ350/BR_DOOMSTATION")) {
    var_9 = "ping_pickup_generic";
  }

  return var_9;
}

function fusefx(var_0, var_1, var_2) {
  var_3 = self;

  if(isDefined(var_1) && isDefined(var_1.type)) {
    var_4 = var_1.type;
  } else {
    return "";
  }

  var_5 = 0;
  var_6 = tablelookupgetnumrows(level.brloottablename);
  var_7 = undefined;

  for(var_8 = var_5; var_8 < var_6; var_8++) {
    var_9 = tablelookupbyrow(level.brloottablename, var_8, 1);

    if(var_9 == var_4) {
      var_7 = tablelookupbyrow(level.brloottablename, var_8, 12);

      if(var_7 == "") {}

      break;
    }
  }

  if(!isDefined(var_7)) {
    if(var_4 == "brloot_plunder_extraction_site_01" || var_4 == "brloot_plunder_extraction_site_02" || var_4 == "equip_fulton_mp") {
      if(func_load_difficulty_table(var_2, "ping_plunder_bank_confirm")) {
        return "ping_plunder_bank_confirm";
      }
    }

    return "ping_dibs";
  }

  var_10 = "";

  if(issubstr(var_7, "CONTRACT")) {
    if(issubstr(var_7, "ASSASSIN")) {
      var_10 = "ping_affirm_contract_bounty";
    } else if(issubstr(var_7, "DOMINATION")) {
      var_10 = "ping_affirm_contract_recon";
    } else if(issubstr(var_7, "SCAVENGER")) {
      var_10 = "ping_affirm_contract_scavenger";
    } else if(issubstr(var_7, "VIP")) {
      var_10 = "ping_affirm_contract_mostwanted";
    } else if(issubstr(var_7, "EXTRACT")) {
      var_10 = "ping_affirm_contract_ctrabandextract";
    } else if(issubstr(var_7, "TIMEDRUN")) {
      var_10 = "ping_affirm_contract_supplyrun";
    }

    if(var_10 != "" && !func_load_difficulty_table(var_2, var_10)) {
      var_10 = "";
    }

    if(var_10 == "") {
      var_10 = "ping_affirm_contract_generic";
    }

    if(var_10 != "" && !func_load_difficulty_table(var_2, var_10)) {
      var_10 = "";
    }
  } else if(issubstr(var_7, "GASMASK")) {
    if(func_load_difficulty_table(var_2, "ping_gasmask_confirm")) {
      var_10 = "ping_gasmask_confirm";
    }
  } else if(issubstr(var_7, "ARMORY_KIOSK")) {
    if(func_load_difficulty_table(var_2, "ping_plunder_vendor_confirm")) {
      var_10 = "ping_plunder_vendor_confirm";
    }
  } else if(issubstr(var_7, "_PLUNDER_EXTRACT")) {
    if(func_load_difficulty_table(var_2, "ping_cash_deposit_confirm")) {
      var_10 = "ping_cash_deposit_confirm";
    }
  }

  if(var_10 == "") {
    var_10 = "ping_dibs";
  }

  return var_10;
}

function calloutmarkerping_removecallout(var_0) {
  var_1 = self;

  if(!isDefined(var_1)) {
    return;
  }

  addquestrewardtier("Remove Callout ID Start: " + var_0);

  if(isDefined(var_0)) {
    if(var_0 == 0) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("ping", "calloutMarkerPing_squadLeaderBeaconKillForPlayer")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("ping", "calloutMarkerPing_squadLeaderBeaconKillForPlayer")]](var_1);
      }
    }

    var_1 calloutmarkerping_delete(var_0);
    addquestrewardtier("Remove Callout ID Notify: " + var_0);
    var_1 notify("predictiveCalloutClear_" + var_0);
    return;
  }
}

function fulton_refundsuper(var_0, var_1) {
  self endon("disconnect");
  self endon("predictiveCalloutClear_" + var_0);

  for(;;) {
    level waittill("Objective_SetShowProgress", var_2);

    if(isDefined(var_2) && var_2 == var_1) {
      addquestrewardtier("gscObjectiveStartedProgress: " + var_0 + " | gscObjID: " + var_1);
      break;
    }
  }

  calloutmarkerping_removecallout(var_0);
}

function fulton_planted(var_0, var_1) {
  self endon("disconnect");
  self endon("predictiveCalloutClear_" + var_0);

  for(;;) {
    level waittill("Objective_Delete", var_2);

    if(isDefined(var_2) && var_2 == var_1) {
      addquestrewardtier("gscObjectiveDeleted: " + var_0 + " | gscObjID: " + var_1);
      break;
    }
  }

  calloutmarkerping_removecallout(var_0);
}

function fulton_interactions_disabled(var_0, var_1) {
  self endon("disconnect");
  self endon("predictiveCalloutClear_" + var_0);
  addquestrewardtier("Watch Entity Death or Enemy Disconnect: " + var_0);

  if(!isDefined(var_1)) {} else if(isPlayer(var_1)) {
    var_1 waittill("disconnect");
  } else {
    var_1 scripts\engine\utility::ref_143A6("death", "pickup", "explode");
  }

  if(isDefined(var_1.update_bomb_vest_lua)) {
    var_1.update_bomb_vest_lua = undefined;
  }

  calloutmarkerping_removecallout(var_0);
}

function fulton_open(var_0, var_1) {
  self endon("predictiveCalloutClear_" + var_0);
  addquestrewardtier("watchPlayerDeathOrDisconnect: " + var_0);
  var_2 = remove_prohibited_weapons(var_1);

  if(var_2 != "unsupported") {
    scripts\engine\utility::ref_143A5("death_or_disconnect", "self_pickedupitem_" + var_2);
  }

  calloutmarkerping_removecallout(var_0);
}

function calloutmarkerping_watchscriptabledeath(var_0, var_1) {
  self endon("disconnect");
  self endon("predictiveCalloutClear_" + var_0);
  addquestrewardtier("Watch scriptable death ID: " + var_0);

  if(!isDefined(var_1)) {} else if(var_1.type == "equip_fulton_mp") {
    var_2 = var_1.entity;

    if(!isDefined(var_2)) {
      return;
    }

    var_2 scripts\engine\utility::ref_143A5("death", "fulton_takeoff");
  } else if(var_1.type == "br_plunder_box") {
    var_1 waittill("kiosk_disabled");
  } else {
    level scripts\engine\utility::ref_143A8("pickedupweapon_kill_callout_" + var_1.type + var_1.origin, "lootcache_opened_kill_callout" + var_1.origin, "dropbag_kill_callout_" + var_1.origin, "tablethide_kill_callout_" + var_1.origin, "carriable_kill_callout_" + var_1.origin);
  }

  addquestrewardtier("Watch scriptable death Remove ID: " + var_0);
  calloutmarkerping_removecallout(var_0);
}

function fulton_actors(var_0) {
  var_1 = self;

  if(addleadobjective(var_0)) {
    var_2 = getdvarfloat("scr_calloutmarkerping_death_timeout_navigation", 120);
  } else if(addpostlaunchspawns(var_1)) {
    if(addjuggfunctionality(var_1)) {
      var_2 = getdvarfloat("scr_calloutmarkerping_death_timeout_navigation", 120);
    } else if(fulton_check_for_moving_platform(var_2)) {
      var_2 = getdvarfloat("scr_calloutmarkerping_death_timeout_quest_loot", 120);
    } else {
      var_2 = getdvarfloat("scr_calloutmarkerping_death_timeout_loot", 30);
    }
  } else if(addplundercarrycredit(var_2)) {
    if(addjuggfunctionality(var_2)) {
      var_2 = getdvarfloat("scr_calloutmarkerping_death_timeout_navigation", 120);
    } else {
      var_2 = getdvarfloat("scr_calloutmarkerping_death_timeout_entity", 60);
    }
  } else if(addplayeraslootleader(var_2)) {
    var_2 = getdvarfloat("scr_calloutmarkerping_death_timeout_danger", 15);
  } else {
    switch (var_2) {
      case 0:
        var_2 = getdvarfloat("scr_calloutmarkerping_death_timeout_navigation", 120);
        break;
      case 7:
        var_2 = getdvarfloat("scr_calloutmarkerping_death_timeout_world", 120);
        break;
      case 8:
        var_2 = getdvarfloat("scr_calloutmarkerping_death_timeout_vehicle", 60);
        break;
      case 12:
        var_2 = getdvarfloat("scr_calloutmarkerping_death_timeout_request", 30);
        break;
      default:
        var_2 = 2;
        break;
    }
  }

  return var_2;
}

function calloutmarkerping_onplayerdisconnect(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  fulton_exfil_model(var_0);
}

function fulton_repositorycountdownendcallback(var_0, var_1) {
  var_2 = self;

  if(addpostlaunchspawns(var_0)) {
    return (var_1 + 500);
  }

  if(addplundercarrycredit(var_0)) {
    return (var_1 + 500);
  }

  if(addplayeraslootleader(var_0)) {
    return (var_1 + 500);
  }

  switch (var_0) {
    case 0:
      return (var_1 + 500);
    case 8:
      return (var_1 + 500);
    case 7:
      return (var_1 + 500);
    case 12:
      return (var_1 + 500);
    default:
      break;
  }
}

function fxangles(var_0) {
  var_1 = self;

  if(!isDefined(var_1.fxrings[var_0])) {
    return false;
  }

  return true;
}

function fx_thermal_end(var_0, var_1, var_2, var_3) {
  var_4 = self;
  var_5 = var_4.fxrings.size;

  if(var_5 > 10) {
    return false;
  }

  var_6 = fulton_repositorycountdownendcallback(var_4, var_0, var_3);
  var_7 = var_6 + var_1;
  var_8 = spawnStruct();
  var_8.ref_134E0 = var_7;
  var_8.poolid = var_0;
  var_8.generatenumbercode_array = 0;
  var_4.fxrings[var_2] = var_8;
  return true;
}

function fulton_repositoryextractcallback(var_0, var_1, var_2) {
  var_3 = self;

  if(!isDefined(var_3) || !isPlayer(var_3)) {
    return 0;
  }

  if(istrue(var_3.loadout_updateglobalclassstruct)) {
    return 0;
  }

  var_4 = gettime();
  var_5 = "pool" + var_0;
  var_6 = fxangles(var_3, var_5);

  if(var_6) {
    var_7 = var_3.fxrings[var_5].ref_134E0;

    if(var_4 >= var_7) {
      var_8 = fx_thermal_end(var_3, var_0, var_4, var_5, var_2);
      return istrue(var_8);
    }

    if(var_2 == "ping_response_cancel" && var_4.fxrings[var_6].generatenumbercode_array == 0) {
      var_4.fxrings[var_6].generatenumbercode_array = 1;
      return 1;
    }

    return 0;
  }

  if(var_3 == "ping_response_cancel") {
    return 0;
  }

  var_8 = fx_thermal_end(var_5, var_2, var_6, var_7, var_4);
  return istrue(var_8);
}

function fulton_used() {
  level endon("game_ended");

  for(;;) {
    wait 10;
    var_0 = gettime();

    for(var_1 = 0; var_1 < level.players.size; var_1++) {
      var_2 = level.players[var_1];

      if(!isDefined(var_2) || !isDefined(var_2.fxrings)) {
        continue;
      }

      foreach(var_4 in var_2.fxrings) {
        if(var_0 > var_4.ref_134E0) {
          var_2.fxrings[var_5] = undefined;
        }
      }
    }
  }
}

function fx_thermal(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  if(var_0) {
    var_5 = lookupsoundlength(var_1, 1);

    if(var_5 > var_4) {
      var_4 = var_5;
    }
  }

  if(var_2) {
    var_5 = lookupsoundlength(var_3, 1);

    if(var_5 > var_4) {
      var_4 = var_5;
    }
  }

  return var_4;
}

function calloutmarkerping_getpoolidnavigation() {
  return false;
}

function fulton_deletenextframe(var_0, var_1) {
  var_2 = self;

  if(!isDefined(var_2) || !isPlayer(var_2) || !isDefined(var_0)) {
    return;
  }

  if(soundexists(var_0)) {}

  var_3 = var_2 calloutmarkerping_getsavedzoffset(var_1);
  var_4 = var_2 setallstreamloaddist(var_1);
  var_5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](var_2.team, 1);

  foreach(var_7 in var_5) {
    if(istrue(var_7.gulag)) {
      continue;
    }

    if(var_2 isspectatingplayer()) {
      var_8 = var_7;
    } else if(isDefined(var_3)) {
      var_8 = spawn("script_origin", var_3.origin);
      var_8.validatedamagerelicswat = 1;
    } else if(isDefined(var_4)) {
      var_8 = spawn("script_origin", var_4);
      var_8.validatedamagerelicswat = 1;
    } else {
      var_8 = var_2;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "playSoundToSquad")) {
      var_8[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "playSoundToSquad")]](var_0, var_2.team, var_2);
    } else {
      var_8 playsoundtoteam(var_0, var_2.team);
    }

    if(isDefined(var_8.validatedamagerelicswat)) {
      var_8 delete();
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "squadAsTeamEnabled") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "squadAsTeamEnabled")]]()) {
      break;
    }
  }
}

function func_load_difficulty_table(var_0) {
  var_1 = self;
  var_2 = fx_model(var_1, var_0);
  var_3 = fx_obj(var_1, var_0);
  var_4 = soundexists(var_2);
  var_5 = soundexists(var_3);
  return var_4 || var_5;
}

function fx_model(var_0) {
  var_1 = self;

  if(!isDefined(var_1.operatorcustomization) || !isDefined(var_1.operatorcustomization.voice)) {
    return;
  }

  var_2 = "dx_mpp_" + var_1.operatorcustomization.voice + "_" + var_0;

  if(var_2 == "dx_mpp_gar_ping_pickup_fieldupgrade") {
    var_2 = "dx_mpp_gar_ping_pickup_fieldupgrade_hash";
  }

  if(var_2 == "dx_mpp_asad_ping_affirm_contract_recon") {
    var_2 = "dx_mpp_asad_ping_affirm_contract_recon_hash";
  }

  return var_2;
}

function fx_obj(var_0) {
  var_1 = self;

  if(!isDefined(var_1.operatorcustomization) || !isDefined(var_1.operatorcustomization.voice)) {
    return;
  }

  var_2 = "dx_mpb_" + var_1.operatorcustomization.voice + "_" + var_0;
  return var_2;
}

function fxent2(var_0, var_1, var_2) {
  var_3 = self;

  if(!isDefined(var_3) || !isPlayer(var_3)) {
    return;
  }

  if(!isDefined(var_1)) {
    return;
  }

  if(!isDefined(var_0) || var_0 == "") {
    return;
  }

  if(isPlayer(var_2)) {
    var_4 = var_2;
  } else {
    var_4 = var_4;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "skipPlayerVO") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "skipPlayerVO")]](var_4)) {
    return;
  }

  var_5 = fx_model(var_4, var_1);
  var_6 = fx_obj(var_4, var_1);
  var_7 = soundexists(var_5);
  var_8 = soundexists(var_6);
  var_9 = fx_thermal(var_7, var_5, var_8, var_6);
  var_10 = fulton_repositoryextractcallback(var_4, var_2, var_1, var_9);

  if(istrue(var_10)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "squadAsTeamEnabled") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "squadAsTeamEnabled")]]()) {
      var_11 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getSquadPlayers")]](var_4.team, var_4.squadindex);
    } else {
      var_11 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](var_4.team, 1);
    }

    foreach(var_13 in var_11) {
      if(istrue(var_13.gulag)) {
        continue;
      }

      if(var_5 == var_13 || var_5 isspectatingplayer()) {
        if(var_8) {
          var_5 playsoundtoplayer(var_6, var_13, var_13);
        }

        continue;
      }

      if(var_9) {
        var_5 playsoundtoplayer(var_7, var_13);
      }
    }
  }

  if(!var_9) {
    return;
  }
}

function fulton_create() {
  self endon("disconnect");
  self endon("predictiveCalloutClear_0");
  self notify("calloutMarkerPing_navigationCancelProximity");
  self endon("calloutMarkerPing_navigationCancelProximity");
  var_0 = getdvarfloat("scr_calloutmarkerping_death_timeout_navigation", 120);
  var_1 = getdvarint("scr_calloutmarkerping_navigation_cancel_minimum_time_secs", 10);
  wait var_1;

  if(!self calloutmarkerping_getfeedback(0)) {
    return;
  }

  var_2 = self setallstreamloaddist(0);
  var_3 = getdvarint("scr_calloutmarkerping_navigation_proximity_cancel_dist_sq", 47089);
  var_4 = getdvarint("scr_calloutmarkerping_navigation_proximity_cancel_type", 1);
  var_5 = getdvarint("scr_calloutmarkerping_navigation_proximity_cancel_tick_secs", 1);

  for(;;) {
    if(var_4 == 1) {
      var_6 = distancesquared(self.origin, var_2);
    } else {
      var_6 = var_3;
      var_7 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](self.team, 1);

      foreach(var_9 in var_7) {
        var_10 = distancesquared(var_9.origin, var_2);

        if(var_10 < var_6) {
          var_6 = var_10;
        }
      }
    }

    if(var_6 < var_3) {
      fulton_deletenextframe("br_ping_cancel", 0);
      calloutmarkerping_removecallout(0);
      return;
    }

    wait var_5;
  }
}

function fulton_exfil_model() {
  var_0 = self;

  if(isDefined(var_0)) {
    for(var_1 = 0; var_1 < 13; var_1++) {
      calloutmarkerping_removecallout(var_0, var_1);
    }

    return;
  }
}

function fulton_destroy(var_0) {
  var_1 = 0;

  foreach(var_3 in level.players) {
    fulton_exfil_model(var_3);

    if(istrue(var_0)) {
      var_1++;

      if(var_1 % 10 == 0) {
        waitframe();
      }
    }
  }
}

function fxorigintagb(var_0) {
  var_1 = self;
  var_1 notify("calloutMarkerPingVO_playPredictivePingCleared");
  var_1 endon("calloutMarkerPingVO_playPredictivePingCleared");
  fulton_deletenextframe(var_1, "br_ping_cancel", var_0);
  wait getdvarfloat("scr_calloutmarkerping_delay_between_vo_and_sfx_secs_cleared", 0.5);

  if(isDefined(var_1)) {
    fxent2(var_1, "ping_response_cancel", var_0);
    return;
  }
}

function fxorigin(var_0) {
  var_1 = self;
  fxorigintagb(var_1, var_0);
}

function fxgreen(var_0, var_1) {
  var_2 = self;
  var_2 notify("calloutMarkerPingVO_playPredictivePingAcknowledged");
  var_2 endon("calloutMarkerPingVO_playPredictivePingAcknowledged");

  if(addpostlaunchspawns(var_0)) {
    var_3 = var_2 calloutmarkerping_getsavedzoffset(var_0);
    var_4 = fusefx(var_2, var_0, var_3, var_1);
  } else if(addplundercarrycredit(var_1)) {
    var_4 = "ping_response_affirm";
  } else if(addplayeraslootleader(var_2)) {
    var_4 = "ping_response_copy";
  } else {
    switch (var_4) {
      case 0:
        if(func_load_difficulty_table(var_4, "ping_generic_ping_response")) {
          var_4 = "ping_generic_ping_response";
        } else {
          var_4 = "ping_response_affirm";
        }

        break;
      case 7:
        var_4 = "ping_response_copy";
        break;
      case 8:
        if(func_load_difficulty_table(var_4, "ping_vehicle_confirm")) {
          var_4 = "ping_vehicle_confirm";
        } else {
          var_4 = "ping_response_affirm";
        }

        break;
      case 12:
        var_4 = "ping_dibs";
        break;
      default:
        var_4 = "ping_response_affirm";
        break;
    }
  }

  wait getdvarfloat("scr_calloutmarkerping_delay_between_vo_and_sfx_secs_acked", 0.5);

  if(isPlayer(var_4)) {
    fxent2(var_4, var_4, var_4, var_4);
    return;
  }

  if(isDefined(var_4)) {
    fxent2(var_4, var_4, var_4);
    return;
  }
}

function fxorigintag(var_0) {
  var_1 = self;
  var_1 notify("calloutMarkerPingVO_playPredictivePingAdded");
  var_1 endon("calloutMarkerPingVO_playPredictivePingAdded");
  var_1 endon("calloutMarkerPingVO_playPredictivePingCleared");
  var_1 endon("predictiveCalloutClear_" + var_0);
  wait getdvarfloat("scr_calloutmarkerping_delay_between_vo_and_sfx_secs_added", 0.5);

  if(isDefined(var_1)) {
    fulton_repositoryusecallback(var_1, var_0);
    return;
  }
}

function fulton_check_for_moving_platform(var_0) {
  var_1 = self;
  var_2 = var_1 calloutmarkerping_getsavedzoffset(var_0);

  if(isDefined(var_2) && isDefined(var_2.ref_139EB)) {
    return true;
  }

  return false;
}

function addjuggfunctionality(var_0) {
  var_1 = self;
  var_2 = var_1 calloutmarkerping_getsavedzoffset(var_0);

  if(isDefined(var_2) && isDefined(var_2.classname) && issubstr(var_2.classname, "scriptable") && !isDefined(var_2.entity) && var_2 getscriptableisreserved()) {
    if(var_2 method_87b9()) {
      var_3 = var_2 method_87b7();
      return _calloutmarkerping_handleluinotify_enemyrepinged::trophy_tryreflectsnapshot(var_3);
    }
  }

  return 0;
}

function addleadobjective(var_0) {
  var_1 = self;
  var_2 = var_1 calloutmarkerping_getsavedzoffset(var_0);

  if(isDefined(var_2) && isDefined(var_2.vehiclename) && issubstr(var_2.vehiclename, "train")) {
    return true;
  }

  return false;
}

function fulton_handledamage(var_0, var_1) {
  self endon("disconnect");
  self endon("predictiveCalloutClear_" + var_0);
  var_2 = 0.25;
  var_3 = 0;
  var_4 = self.team;

  for(;;) {
    var_5 = addselfrevivetoken(var_0, var_1, var_4);

    if(var_5) {
      calloutmarkerping_removecallout(var_0);
      return;
    }

    var_6 = addplatepouch(var_1, var_4);

    if(var_6) {
      var_3 += var_2;

      if(var_3 >= 3) {
        var_7 = var_1 getvehicleowner();

        if(isDefined(var_7)) {
          thread fulton_ac130_model(var_0, var_7);
          return;
        }

        calloutmarkerping_removecallout(var_0);
        return;
      }
    }

    wait var_3;
  }
}

function addselfrevivetoken(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = 0;
  var_5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](var_2, 1);

  foreach(var_7 in var_5) {
    if(var_7 scripts\cp_mp\utility\player_utility::isinvehicle() && var_7.vehicle == var_1) {
      var_3 calloutmarkerping_hide(var_0, var_7);
      var_4++;
    }
  }

  if(var_4 == var_5.size) {
    return true;
  }

  return false;
}

function addplatepouch(var_0, var_1) {
  var_2 = isDefined(var_0.ownerteam) && var_0.ownerteam != var_1;
  var_3 = isDefined(var_0.isempty) && var_0.isempty == 0;

  if(var_3 && var_2) {
    return true;
  }

  return false;
}

function add_trigger_to_oob_system(var_0) {
  var_1 = self;

  if(!isDefined(var_1.fulton_repositoryatcapacitycallback)) {
    var_1.fulton_repositoryatcapacitycallback = [];
  }

  if(!isDefined(var_1.fulton_repositoryatcapacitycallback[var_0])) {
    var_1.fulton_repositoryatcapacitycallback[var_0] = 0;
  } else {
    var_1.fulton_repositoryatcapacitycallback[var_0]++;
  }

  var_2 = [];
  GscBinSkip0(0x2e, var_2.size, "ping_id");
}

function add_wave_overrides_to_module() {
  var_0 = self;

  if(isDefined(var_0)) {
    for(var_1 = 0; var_1 < 13; var_1++) {
      if(var_0 calloutmarkerping_getfeedback(var_1)) {
        add_veh_spawners_to_passive_wave_spawning(var_0, var_1, "clear_all");
      }
    }

    return;
  }
}

function add_veh_spawners_to_passive_wave_spawning(var_0, var_1) {
  var_2 = self;

  if(!isDefined(var_2.fulton_repositoryatcapacitycallback)) {
    return;
  }

  if(!isDefined(var_2.fulton_repositoryatcapacitycallback[var_0])) {
    return;
  }

  var_3 = [];
  GscBinSkip0(0x2e, var_3.size, "ping_id");
}

function addbattlepassxpmultiplier(var_0) {
  var_1 = self;
  add_veh_spawners_to_passive_wave_spawning(var_1, var_0, "clear_single");
  var_1 notify("predictiveCalloutClear_" + var_0);
  thread fxorigintagb(var_1);
}

function addaccesscard(var_0, var_1) {
  var_2 = self;
  thread addquestrewardtierframeend(var_2, var_0, 0);
  thread fxgreen(var_2, var_0);

  if(getdvarint("OMSQPMNQLS", 0) && istrue(level.onlinestatsenabled) && isDefined(var_2.usingonlinedataoffline) && !var_2.usingonlinedataoffline) {
    var_2 setplayerdata("mp", "use_ping_ack_history", 0, 1);
    return;
  }
}

function addaliasarraytoqueue(var_0) {
  var_1 = self;
  thread fxorigin(var_1);
}

function addallkillstreaksunlocked(var_0) {
  var_1 = self;

  if(istrue(level.stop_end_breach_fx) && !istrue(var_1 setadditionalstreamloaddist())) {
    calloutmarkerping_removecallout(var_0);
    return;
  }

  add_trigger_to_oob_system(var_1, var_0);
  thread addquestrewardtierframeend(var_1);
  add_track_points(var_1, var_0);
  thread fxorigintag(var_1);
  addplayerasexpiredlootleader(var_1, var_0);

  if(var_0 == 7) {
    var_2 = self getnodeoffset_code(var_0);
    var_3 = 1;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "shouldPingDisableObjectiveIntro")) {
      var_3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "shouldPingDisableObjectiveIntro")]](var_2);
    }

    if(var_2 != -1 && var_3) {
      objective_setplayintro(var_2, 0);
    }
  }

  if(getdvarint("OMSQPMNQLS", 0) && istrue(level.onlinestatsenabled) && isDefined(var_1.usingonlinedataoffline) && !var_1.usingonlinedataoffline) {
    var_1 setplayerdata("mp", "use_ping_history", 0, 1);

    if(addplundercarrycredit(var_0)) {
      var_4 = var_1 calloutmarkerping_getsavedzoffset(var_0);

      if(isDefined(var_4)) {
        var_1 setplayerdata("mp", "use_ping_enemy_history", 0, 1);
      }
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "onPing")) {
    var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "onPing")]](var_0);
    return;
  }
}

function adddroponplayerdeath(var_0) {
  var_1 = self;
  thread addquestrewardtierframeend(var_1, var_0, 0);
  fulton_deletenextframe(var_1, "br_ping_enemy", var_0);
}

function addedcollision() {
  var_0 = self;
  var_1 = addpowerbutton();

  if(var_1 != -1) {
    add_wave_overrides_to_module(var_0);
    fulton_deletenextframe(var_0, "br_ping_cancel", var_1);
    fxent2(var_0, "ping_response_cancel", var_1);
  }

  fulton_exfil_model(var_0);
}

function addallkillstreaksunlockedinonelife(var_0) {
  var_1 = self;
  thread fulton_handlefataldamage(var_1);
}
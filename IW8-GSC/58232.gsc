/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58232.gsc
***********************************************/

function get_num_of_wire_to_cut() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("cargo_truck_susp_aa", 1);
  var_0.destroycallback = &get_num_dogtag_in_kill_zone_or_under_bridge_zone;
  get_pathstruct();
  get_other_active_zone();
  get_pavelow_boss_info();
  get_offset_from_stance();
  get_objective_label();
  get_omnvar_value_based_on_bomb_label();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cargo_truck_susp_aa", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck_susp_aa", "init")]]();
  }

  get_pipe_room_spawnpoint();
  get_paired_bombvest_chair();
}

function get_paired_bombvest_chair() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cargo_truck_susp_aa", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck_susp_aa", "initLate")]]();
    return;
  }
}

function get_pathstruct() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("cargo_truck_susp_aa", 1);
  var_0.enterstartcallback = &get_next_station_on_track_after_index;
  var_0.enterendcallback = &get_next_spawn_index;
  var_0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = &get_next_track_index;
  var_0.reentercallback = &get_player_enemy;
  var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_0.exitextents["front"] = 110;
  var_0.exitextents["back"] = 135;
  var_0.exitextents["left"] = 48;
  var_0.exitextents["right"] = 48;
  var_0.exitextents["top"] = 100;
  var_0.exitextents["bottom"] = 0;
  var_1 = "front";
  var_0.exitoffsets[var_1] = (140, 0, 115);
  var_0.exitdirections[var_1] = "front";
  var_1 = "front_right";
  var_0.exitoffsets[var_1] = (65, 23, 115);
  var_0.exitdirections[var_1] = "right";
  var_1 = "front_left";
  var_0.exitoffsets[var_1] = (65, 23, 115);
  var_0.exitdirections[var_1] = "left";
  var_1 = "back_left";
  var_0.exitoffsets[var_1] = (-152, 36, 115);
  var_0.exitdirections[var_1] = "back";
  var_1 = "side_left";
  var_0.exitoffsets[var_1] = (-109, 36, 115);
  var_0.exitdirections[var_1] = "left";
  var_2 = ["driver", "gunner", "passenger"];
  var_3 = "driver";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("cargo_truck_susp_aa", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["front_left", "side_left", "back_left", "front_right", "front"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_4.animtag = "tag_seat_0";
  var_4.ref_12023 = "ping_vehicle_driver";
  var_3 = "passenger";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("cargo_truck_susp_aa", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["front_right", "front", "front_left", "side_left", "back_left"];
  var_4.viewclamps["top"] = 24;
  var_4.viewclamps["bottom"] = 42;
  var_4.viewclamps["left"] = 101;
  var_4.viewclamps["right"] = 122;
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var_4.animtag = "tag_seat_1";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.ref_12023 = "ping_vehicle_rider";
  var_3 = "gunner";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("cargo_truck_susp_aa", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["back_left", "side_left", "front_left", "front_right", "front"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getturretpassengerrestrictions();
  var_4.ref_13E8A = getcompleteweaponname("manual_turret_flak_vehicle");
  var_4.ref_13E92 = "manual_turret_flak_vehicle";
  var_4.ref_12023 = "ping_vehicle_gunner";
}

function get_other_active_zone() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("cargo_truck_susp_aa", 1);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419D("cargo_truck_susp_aa", "single", ["driver", "gunner", "passenger"]);
}

function get_pavelow_boss_info() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427E("cargo_truck_susp_aa", 1);
  var_0.id = 23;
  var_0.seatids["driver"] = 0;
  var_0.seatids["gunner"] = 1;
  var_0.seatids["passenger"] = 2;
  var_0.ref_12DA2[0] = 0;
  var_0.ref_12DA3["driver"]["manual_turret_flak_vehicle"] = 0;
  var_0.ref_12DA3["gunner"]["manual_turret_flak_vehicle"] = 0;
}

function get_offset_from_stance() {
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416C("cargo_truck_susp_aa", 2300);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("cargo_truck_susp_aa");
  var_0.class = "heavy";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413D("cargo_truck_susp_aa");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("cargo_truck_susp_aa", 12);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("cargo_truck_susp_aa", &get_next_open_stop);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417B("cargo_truck_mp", 5);
}

function get_objective_label() {
  var_0 = _calloutmarkerping_predicted_log::ref_1410F("cargo_truck_susp_aa", 1);
  var_0.challengeevaluator = 2;
  var_0.keycardlocs_chosen = 0.75;
  var_0.is_using_stealth_debug = 350;
  var_0.is_valid_station_name = 525;
  var_0.is_two_hit_melee_weapon = 875;
  var_0.isakimbomeleeweapon = 5;
  var_0.isallowedweapon = 20;
  var_0.isakimbo = 40;
  var_0.isattachmentgrenadelauncher = 0;
  var_0.isattachmentselectfire = 0;
  var_0.isassaulting = 0;
}

function get_omnvar_value_based_on_bomb_label() {
  level._effect["cargo_truck_explode"] = loadfx("vfx/iw8_mp/vehicle/vfx_cargotr_mp_death_exp.vfx");
}

function get_next_cypher_id_from_pool(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnturret("misc_turret", var_0 gettagorigin(var_3), var_1, 0);
  var_5 linkTo(var_0, var_3, var_4, (0, 0, 0));
  var_5 setModel(var_2);
  var_5 setmode("sentry_offline");
  var_5 setsentryowner(undefined);
  var_5 makeunusable();
  var_5 setdefaultdroppitch(0);
  var_5 setturretmodechangewait(1);
  var_5.angles = var_0.angles;
  var_5.vehicle = var_0;
  var_5.maxhealth = 999999;
  var_5.health = var_5.maxhealth;
  return var_5;
}

function get_next_available_wire_for_bomb(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_0.modelname = "veh_s4_mil_lnd_truck_opapa40_flatbed_wz";
  var_0.targetname = "cargo_truck_susp_aa";
  var_0.vehicletype = "cargo_truck_susp_aa";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  var_3 = get_next_cypher_id_from_pool(var_2, "manual_turret_flak_vehicle", "veh_s4_mil_lnd_turret_quad_aa_wz", "tag_turret", (0, 0, 0));
  scripts\cp_mp\vehicles\vehicle::ref_14207(var_2, var_3, getcompleteweaponname("manual_turret_flak_vehicle"));
  scripts\cp_mp\vehicles\vehicle::ref_14138(var_2, "cargo_truck_susp_aa", var_0);
  var_2.objweapon = getcompleteweaponname("cargo_truck_mp");
  var_2.ref_13E92 = "manual_turret_flak_vehicle";
  _calloutmarkerping_predicted_timeout::ref_1412B(var_2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var_2, var_0);
  thread get_player_munition_currency(var_2, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cargo_truck_susp_aa", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck_susp_aa", "create")]](var_2);
  }

  return var_2;
}

function get_player_munition_currency(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  level endon("game_ended");

  if(isDefined(var_3)) {
    var_0 endon(var_3);
  }

  var_4 = 0;
  var_5 = undefined;
  var_6 = undefined;

  for(;;) {
    var_7 = 0;
    var_8 = anglestoup(var_0.angles)[2];

    if(var_8 <= 0.0872) {
      if(!isDefined(var_5)) {
        var_5 = gettime() + 3000;
      }

      if(gettime() > var_5) {
        var_7 = 1;
        var_5 = undefined;
      }
    } else {
      if(var_4) {
        scripts\cp_mp\vehicles\vehicle_occupancy::ref_141C6(var_0, 1);
        scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse(var_0, 1);
        var_4 = 0;
      }

      var_7 = 0;
      var_5 = undefined;
    }

    if(var_7) {
      if(isDefined(var_1)) {
        GscBinSkip1(0x74, var_1, var_0);
      }

      if(!var_4) {
        scripts\cp_mp\vehicles\vehicle_occupancy::ref_141C6(var_0, 0);
        scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse(var_0, 0);
        var_4 = 1;
      }

      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants(var_0);
      var_9 = 0;
      var_6 = gettime() + 3000;

      for(;;) {
        if(gettime() >= var_6) {
          var_9 = 1;
          break;
        }

        waitframe();
      }

      var_6 = undefined;

      if(isDefined(var_2)) {
        GscBinSkip1(0x74, var_2, var_0, var_9);
      }
    }

    waitframe();
  }
}

function get_num_dogtag_in_kill_zone_or_under_bridge_zone(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "cargo_truck_mp";
    var_0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread get_next_rein_group();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("tag_origin");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "cargo_truck_mp");
    playFX(scripts\engine\utility::getfx("cargo_truck_explode"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "car_explode");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
    return;
  }
}

function get_next_rein_group() {
  scripts\cp_mp\vehicles\vehicle::ref_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cargo_truck_susp_aa", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck_susp_aa", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::ref_14186(self);
}

function get_next_open_stop(var_0) {
  thread get_num_dogtag_in_kill_zone_or_under_bridge_zone(var_0);
  return true;
}

function get_next_station_on_track_after_index(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "gunner") {
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(var_3, var_0.ref_13E92, var_4, 1);
    return;
  }
}

function get_next_spawn_index(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    get_next_station_on_track(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function get_next_station_on_track(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;
  var_6 = undefined;

  if(isDefined(var_2) && var_2 == "gunner") {
    var_5 = "cargo_truck_susp_aa";
    var_6 = 6;
  }

  if(var_1 == "driver") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);
  } else if(var_1 == "gunner") {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(var_3, 0);
    var_7 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_0, var_0.ref_13E92);
    var_7.owner = var_3;
    var_7 setotherent(var_3);
    var_7 setentityowner(var_3);
    var_7 setsentryowner(var_3);
    var_3 disableturretdismount();
    var_3 controlturreton(var_7);
  }

  if(var_1 != "gunner") {
    var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2, undefined, var_5, var_6);
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
}

function get_next_track_index(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    get_node_closest_to_target_loc(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function get_node_closest_to_target_loc(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(undefined);
    var_0 setentityowner(undefined);
  }

  var_5 = !isDefined(var_2);

  if(var_1 == "gunner" || var_5 && var_3 hasweapon(var_0.ref_13E92)) {
    var_6 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_0, var_0.ref_13E92);

    if(!istrue(var_4.playerdisconnect)) {
      var_3 enableturretdismount();
      var_3 controlturretoff(var_6);

      if(!istrue(var_4.playerdeath)) {
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var_3, var_0, var_0.ref_13E92, var_4, 1);
      }

      thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_cleardisablefirefortime(var_3, var_4.playerdeath);
    }

    var_6.owner = undefined;
    var_6 setotherent(undefined);
    var_6 setentityowner(undefined);
    var_6 setsentryowner(undefined);
  }

  if(!istrue(var_4.playerdisconnect)) {
    var_3 controlsunlink();

    if(istrue(var_4.playerdeath)) {
      var_3 scripts\cp_mp\vehicles\vehicle_occupancy::allowleaderboardstatsupdates();
    }

    var_3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_stopanimatingplayer();
    var_7 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit(var_3, var_2, var_4);

    if(!var_7) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "handleSuicideFromVehicles")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "handleSuicideFromVehicles")]](var_3);
      } else {
        var_3 suicide();
      }
    }
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(var_0, var_1, var_2, var_3);
}

function get_player_enemy(var_0, var_1, var_2, var_3, var_4) {
  scripts\cp_mp\vehicles\vehicle_occupancy::ref_141F6(var_4);
  thread get_player_info_proc(var_0, var_1, var_2, var_3, var_4);
}

function get_player_info_proc(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_2) && var_2 == "gunner") {
    var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141DC(var_3, var_4);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var_3, var_0, var_0.ref_13E92, var_4, 1);
    scripts\cp_mp\vehicles\vehicle_occupancy::ref_141F7(var_5);
    return;
  }
}

function get_pipe_room_spawnpoint() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("cargo_truck_susp_aa", 1);
  var_0.maxinstancecount = 2;
  var_0.priority = 75;
  var_0.getspawnstructscallback = &get_num_of_valid_players;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck_susp_aa", "spawnCallback");
  var_0.clearancecheckradius = 185;
  var_0.clearancecheckheight = 138;
  var_0.clearancecheckminradius = 185;
}

function get_num_of_valid_players() {
  var_0 = scripts\engine\utility::getStructArray("cargotrucksuspaa_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}
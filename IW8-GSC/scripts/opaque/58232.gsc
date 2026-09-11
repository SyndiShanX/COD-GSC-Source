/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58232.gsc
***********************************************/

function get_num_of_wire_to_cut() {
  var0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("cargo_truck_susp_aa", 1);
  var0.destroycallback = &get_num_dogtag_in_kill_zone_or_under_bridge_zone;
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
  var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("cargo_truck_susp_aa", 1);
  var0.enterstartcallback = &get_next_station_on_track_after_index;
  var0.enterendcallback = &get_next_spawn_index;
  var0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var0.exitendcallback = &get_next_track_index;
  var0.reentercallback = &get_player_enemy;
  var0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var0.exitextents["front"] = 110;
  var0.exitextents["back"] = 135;
  var0.exitextents["left"] = 48;
  var0.exitextents["right"] = 48;
  var0.exitextents["top"] = 100;
  var0.exitextents["bottom"] = 0;
  var1 = "front";
  var0.exitoffsets[var1] = (140, 0, 115);
  var0.exitdirections[var1] = "front";
  var1 = "front_right";
  var0.exitoffsets[var1] = (65, 23, 115);
  var0.exitdirections[var1] = "right";
  var1 = "front_left";
  var0.exitoffsets[var1] = (65, 23, 115);
  var0.exitdirections[var1] = "left";
  var1 = "back_left";
  var0.exitoffsets[var1] = (-152, 36, 115);
  var0.exitdirections[var1] = "back";
  var1 = "side_left";
  var0.exitoffsets[var1] = (-109, 36, 115);
  var0.exitdirections[var1] = "left";
  var2 = ["driver", "gunner", "passenger"];
  var3 = "driver";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("cargo_truck_susp_aa", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = ["front_left", "side_left", "back_left", "front_right", "front"];
  var4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var4.animtag = "tag_seat_0";
  var4.ref_12023 = "ping_vehicle_driver";
  var3 = "passenger";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("cargo_truck_susp_aa", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = ["front_right", "front", "front_left", "side_left", "back_left"];
  var4.viewclamps["top"] = 24;
  var4.viewclamps["bottom"] = 42;
  var4.viewclamps["left"] = 101;
  var4.viewclamps["right"] = 122;
  var4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var4.animtag = "tag_seat_1";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.ref_12023 = "ping_vehicle_rider";
  var3 = "gunner";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("cargo_truck_susp_aa", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = ["back_left", "side_left", "front_left", "front_right", "front"];
  var4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getturretpassengerrestrictions();
  var4.ref_13e8a = getcompleteweaponname("manual_turret_flak_vehicle");
  var4.ref_13e92 = "manual_turret_flak_vehicle";
  var4.ref_12023 = "ping_vehicle_gunner";
}

function get_other_active_zone() {
  var0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("cargo_truck_susp_aa", 1);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419d("cargo_truck_susp_aa", "single", ["driver", "gunner", "passenger"]);
}

function get_pavelow_boss_info() {
  var0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e("cargo_truck_susp_aa", 1);
  var0.id = 23;
  var0.seatids["driver"] = 0;
  var0.seatids["gunner"] = 1;
  var0.seatids["passenger"] = 2;
  var0.ref_12da2[0] = 0;
  var0.ref_12da3["driver"]["manual_turret_flak_vehicle"] = 0;
  var0.ref_12da3["gunner"]["manual_turret_flak_vehicle"] = 0;
}

function get_offset_from_stance() {
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416c("cargo_truck_susp_aa", 2300);
  var0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("cargo_truck_susp_aa");
  var0.class = "heavy";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413d("cargo_truck_susp_aa");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("cargo_truck_susp_aa", 12);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("cargo_truck_susp_aa", &get_next_open_stop);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417b("cargo_truck_mp", 5);
}

function get_objective_label() {
  var0 = _calloutmarkerping_predicted_log::ref_1410f("cargo_truck_susp_aa", 1);
  var0.challengeevaluator = 2;
  var0.keycardlocs_chosen = 0.75;
  var0.is_using_stealth_debug = 350;
  var0.is_valid_station_name = 525;
  var0.is_two_hit_melee_weapon = 875;
  var0.isakimbomeleeweapon = 5;
  var0.isallowedweapon = 20;
  var0.isakimbo = 40;
  var0.isattachmentgrenadelauncher = 0;
  var0.isattachmentselectfire = 0;
  var0.isassaulting = 0;
}

function get_omnvar_value_based_on_bomb_label() {
  level._effect["cargo_truck_explode"] = loadfx("vfx/iw8_mp/vehicle/vfx_cargotr_mp_death_exp.vfx");
}

function get_next_cypher_id_from_pool(var0, var1, var2, var3, var4) {
  var5 = spawnturret("misc_turret", var0 gettagorigin(var3), var1, 0);
  var5 linkTo(var0, var3, var4, (0, 0, 0));
  var5 setModel(var2);
  var5 setmode("sentry_offline");
  var5 setsentryowner(undefined);
  var5 makeunusable();
  var5 setdefaultdroppitch(0);
  var5 setturretmodechangewait(1);
  var5.angles = var0.angles;
  var5.vehicle = var0;
  var5.maxhealth = 999999;
  var5.health = var5.maxhealth;
  return var5;
}

function get_next_available_wire_for_bomb(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var0.modelname = "veh_s4_mil_lnd_truck_opapa40_flatbed_wz";
  var0.targetname = "cargo_truck_susp_aa";
  var0.vehicletype = "cargo_truck_susp_aa";
  var2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var0, var1);

  if(!isDefined(var2)) {
    return undefined;
  }

  var3 = get_next_cypher_id_from_pool(var2, "manual_turret_flak_vehicle", "veh_s4_mil_lnd_turret_quad_aa_wz", "tag_turret", (0, 0, 0));
  scripts\cp_mp\vehicles\vehicle::ref_14207(var2, var3, getcompleteweaponname("manual_turret_flak_vehicle"));
  scripts\cp_mp\vehicles\vehicle::ref_14138(var2, "cargo_truck_susp_aa", var0);
  var2.objweapon = getcompleteweaponname("cargo_truck_mp");
  var2.ref_13e92 = "manual_turret_flak_vehicle";
  _calloutmarkerping_predicted_timeout::ref_1412b(var2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var2, var0);
  thread get_player_munition_currency(var2, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cargo_truck_susp_aa", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck_susp_aa", "create")]](var2);
  }

  return var2;
}

function get_player_munition_currency(var0, var1, var2, var3) {
  var0 endon("death");
  level endon("game_ended");

  if(isDefined(var3)) {
    var0 endon(var3);
  }

  var4 = 0;
  var5 = undefined;
  var6 = undefined;

  for(;;) {
    var7 = 0;
    var8 = anglestoup(var0.angles)[2];

    if(var8 <= 0.0872) {
      if(!isDefined(var5)) {
        var5 = gettime() + 3000;
      }

      if(gettime() > var5) {
        var7 = 1;
        var5 = undefined;
      }
    } else {
      if(var4) {
        scripts\cp_mp\vehicles\vehicle_occupancy::ref_141c6(var0, 1);
        scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse(var0, 1);
        var4 = 0;
      }

      var7 = 0;
      var5 = undefined;
    }

    if(var7) {
      if(isDefined(var1)) {
        GscBinSkip1(0x74, var1, var0);
      }

      if(!var4) {
        scripts\cp_mp\vehicles\vehicle_occupancy::ref_141c6(var0, 0);
        scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse(var0, 0);
        var4 = 1;
      }

      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants(var0);
      var9 = 0;
      var6 = gettime() + 3000;

      for(;;) {
        if(gettime() >= var6) {
          var9 = 1;
          break;
        }

        waitframe();
      }

      var6 = undefined;

      if(isDefined(var2)) {
        GscBinSkip1(0x74, var2, var0, var9);
      }
    }

    waitframe();
  }
}

function get_num_dogtag_in_kill_zone_or_under_bridge_zone(var0, var1) {
  if(!isDefined(var0)) {
    var0 = spawnStruct();
    var0.inflictor = self;
    var0.objweapon = "cargo_truck_mp";
    var0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread get_next_rein_group();

  if(!istrue(level.suppressvehicleexplosion)) {
    var2 = self gettagorigin("tag_origin");
    var3 = scripts\engine\utility::ter_op(isDefined(var0.attacker), var0.attacker, self);
    self radiusdamage(var2, 256, 140, 70, var3, "MOD_EXPLOSIVE", "cargo_truck_mp");
    playFX(scripts\engine\utility::getfx("cargo_truck_explode"), var2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var2, "car_explode");
    earthquake(0.4, 800, var2, 0.7);
    playrumbleonposition("grenade_rumble", var2);
    physicsexplosionsphere(var2, 500, 200, 1);
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

function get_next_open_stop(var0) {
  thread get_num_dogtag_in_kill_zone_or_under_bridge_zone(var0);
  return true;
}

function get_next_station_on_track_after_index(var0, var1, var2, var3, var4) {
  if(var1 == "gunner") {
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(var3, var0.ref_13e92, var4, 1);
    return;
  }
}

function get_next_spawn_index(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    get_next_station_on_track(var0, var1, var2, var3, var4);
    return;
  }
}

function get_next_station_on_track(var0, var1, var2, var3, var4) {
  var5 = undefined;
  var6 = undefined;

  if(isDefined(var2) && var2 == "gunner") {
    var5 = "cargo_truck_susp_aa";
    var6 = 6;
  }

  if(var1 == "driver") {
    var0 setotherent(var3);
    var0 setentityowner(var3);
    var3 controlslinkTo(var0);
  } else if(var1 == "gunner") {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(var3, 0);
    var7 = scripts\cp_mp\vehicles\vehicle::ref_14192(var0, var0.ref_13e92);
    var7.owner = var3;
    var7 setotherent(var3);
    var7 setentityowner(var3);
    var7 setsentryowner(var3);
    var3 disableturretdismount();
    var3 controlturreton(var7);
  }

  if(var1 != "gunner") {
    var3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var0, var1, var2, undefined, var5, var6);
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var0, var2, var1, var3);
}

function get_next_track_index(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    get_node_closest_to_target_loc(var0, var1, var2, var3, var4);
    return;
  }
}

function get_node_closest_to_target_loc(var0, var1, var2, var3, var4) {
  if(var1 == "driver") {
    var0 setotherent(undefined);
    var0 setentityowner(undefined);
  }

  var5 = !isDefined(var2);

  if(var1 == "gunner" || var5 && var3 hasweapon(var0.ref_13e92)) {
    var6 = scripts\cp_mp\vehicles\vehicle::ref_14192(var0, var0.ref_13e92);

    if(!istrue(var4.playerdisconnect)) {
      var3 enableturretdismount();
      var3 controlturretoff(var6);

      if(!istrue(var4.playerdeath)) {
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var3, var0, var0.ref_13e92, var4, 1);
      }

      thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_cleardisablefirefortime(var3, var4.playerdeath);
    }

    var6.owner = undefined;
    var6 setotherent(undefined);
    var6 setentityowner(undefined);
    var6 setsentryowner(undefined);
  }

  if(!istrue(var4.playerdisconnect)) {
    var3 controlsunlink();

    if(istrue(var4.playerdeath)) {
      var3 scripts\cp_mp\vehicles\vehicle_occupancy::allowleaderboardstatsupdates();
    }

    var3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_stopanimatingplayer();
    var7 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit(var3, var2, var4);

    if(!var7) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "handleSuicideFromVehicles")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "handleSuicideFromVehicles")]](var3);
      } else {
        var3 suicide();
      }
    }
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(var0, var1, var2, var3);
}

function get_player_enemy(var0, var1, var2, var3, var4) {
  scripts\cp_mp\vehicles\vehicle_occupancy::ref_141f6(var4);
  thread get_player_info_proc(var0, var1, var2, var3, var4);
}

function get_player_info_proc(var0, var1, var2, var3, var4) {
  if(isDefined(var2) && var2 == "gunner") {
    var5 = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141dc(var3, var4);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var3, var0, var0.ref_13e92, var4, 1);
    scripts\cp_mp\vehicles\vehicle_occupancy::ref_141f7(var5);
    return;
  }
}

function get_pipe_room_spawnpoint() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("cargo_truck_susp_aa", 1);
  var0.maxinstancecount = 2;
  var0.priority = 75;
  var0.getspawnstructscallback = &get_num_of_valid_players;
  var0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck_susp_aa", "spawnCallback");
  var0.clearancecheckradius = 185;
  var0.clearancecheckheight = 138;
  var0.clearancecheckminradius = 185;
}

function get_num_of_valid_players() {
  var0 = scripts\engine\utility::getStructArray("cargotrucksuspaa_spawn", "targetname");

  if(var0.size > 0) {
    var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var0, 1);

    if(var0.size > 1) {
      var0 = scripts\engine\utility::array_randomize(var0);
    }
  }

  return var0;
}
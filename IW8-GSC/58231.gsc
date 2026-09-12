/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58231.gsc
***********************************************/

function get_priority_player() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("cargo_truck_susp", 1);
  var_0.destroycallback = &get_power_ref_from_weapon;
  get_random_impact_point_on_line();
  get_random_circle_direction();
  get_random_leftover_letter();
  get_proximity_alias();
  get_prohibited_weapons_back();
  get_push_force_direction();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cargo_truck_susp", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck_susp", "init")]]();
  }

  get_random_notnegative();
  get_random_impact_point();
}

function get_random_impact_point() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cargo_truck_susp", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck_susp", "initLate")]]();
    return;
  }
}

function get_random_impact_point_on_line() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("cargo_truck_susp", 1);
  var_0.enterendcallback = &get_positions_around_vector;
  var_0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = &get_power_max_charge_in_slot;
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
  var_2 = ["driver", "passenger"];
  var_3 = "driver";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("cargo_truck_susp", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["front_left", "side_left", "back_left", "front_right", "front"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_4.animtag = "tag_seat_0";
  var_4.ref_12023 = "ping_vehicle_driver";
  var_3 = "passenger";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("cargo_truck_susp", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["front_right", "front", "front_left", "side_left", "back_left"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var_4.animtag = "tag_seat_1";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.ref_12023 = "ping_vehicle_rider";
}

function get_random_circle_direction() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("cargo_truck_susp", 1);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419d("cargo_truck_susp", "single", ["driver", "passenger"]);
}

function get_random_leftover_letter() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e("cargo_truck_susp", 1);
  var_0.id = 21;
  var_0.seatids["driver"] = 0;
  var_0.seatids["passenger"] = 1;
}

function get_proximity_alias() {
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416c("cargo_truck_susp", 2300);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("cargo_truck_susp");
  var_0.class = "heavy";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413d("cargo_truck_susp");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("cargo_truck_susp", 12);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("cargo_truck_susp", &get_players_inside_the_plane);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417b("cargo_truck_mp", 5);
}

function get_prohibited_weapons_back() {
  var_0 = _calloutmarkerping_predicted_log::ref_1410f("cargo_truck_susp", 1);
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

function get_push_force_direction() {
  level._effect["cargo_truck_susp_explode"] = loadfx("vfx/iw8_br/island/veh/vfx_br3_ct_death_exp.vfx");
}

function get_players_in_mortar_range(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_0.modelname = "veh_s4_mil_lnd_truck_opapa40_wz";
  var_0.targetname = "cargo_truck_susp";
  var_0.vehicletype = "cargo_truck_susp";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var_2, "cargo_truck_susp", var_0);
  var_2.objweapon = getcompleteweaponname("cargo_truck_mp");
  _calloutmarkerping_predicted_timeout::ref_1412b(var_2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var_2, var_0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_2, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cargo_truck_susp", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck_susp", "create")]](var_2);
  }

  return var_2;
}

function get_power_ref_from_weapon(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "cargo_truck_mp";
    var_0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread get_players_not_targeted_by_other_battle_station();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("tag_origin");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "cargo_truck_mp");
    playFX(scripts\engine\utility::getfx("cargo_truck_susp_explode"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "car_explode");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
    return;
  }
}

function get_players_not_targeted_by_other_battle_station() {
  scripts\cp_mp\vehicles\vehicle::ref_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cargo_truck_susp", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck_susp", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::ref_14186(self);
}

function get_players_inside_the_plane(var_0) {
  thread get_power_ref_from_weapon(var_0);
  return true;
}

function get_positions_around_vector(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    get_power_charges_in_slot(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function get_power_charges_in_slot(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
}

function get_power_max_charge_in_slot(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    get_power_name_in_slot(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function get_power_name_in_slot(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(undefined);
    var_0 setentityowner(undefined);

    if(!istrue(var_4.playerdisconnect)) {
      var_3 controlsunlink();
    }
  }

  if(!istrue(var_4.playerdisconnect)) {
    var_3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_stopanimatingplayer();
    var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit(var_3, var_2, var_4);

    if(!var_5) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "handleSuicideFromVehicles")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "handleSuicideFromVehicles")]](var_3);
      } else {
        var_3 suicide();
      }
    }
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(var_0, var_1, var_2, var_3);
}

function get_random_notnegative() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("cargo_truck_susp", 1);
  var_0.maxinstancecount = 2;
  var_0.priority = 75;
  var_0.getspawnstructscallback = &get_precision_use_parameters;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck_susp", "spawnCallback");
  var_0.clearancecheckradius = 185;
  var_0.clearancecheckheight = 138;
  var_0.clearancecheckminradius = 185;
}

function get_precision_use_parameters() {
  var_0 = scripts\engine\utility::getStructArray("cargotrucksusp_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}
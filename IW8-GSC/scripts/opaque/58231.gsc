/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58231.gsc
***********************************************/

function get_priority_player() {
  var0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("cargo_truck_susp", 1);
  var0.destroycallback = &get_power_ref_from_weapon;
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
  var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("cargo_truck_susp", 1);
  var0.enterendcallback = &get_positions_around_vector;
  var0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var0.exitendcallback = &get_power_max_charge_in_slot;
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
  var2 = ["driver", "passenger"];
  var3 = "driver";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("cargo_truck_susp", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = ["front_left", "side_left", "back_left", "front_right", "front"];
  var4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var4.animtag = "tag_seat_0";
  var4.ref_12023 = "ping_vehicle_driver";
  var3 = "passenger";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("cargo_truck_susp", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = ["front_right", "front", "front_left", "side_left", "back_left"];
  var4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var4.animtag = "tag_seat_1";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.ref_12023 = "ping_vehicle_rider";
}

function get_random_circle_direction() {
  var0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("cargo_truck_susp", 1);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419d("cargo_truck_susp", "single", ["driver", "passenger"]);
}

function get_random_leftover_letter() {
  var0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e("cargo_truck_susp", 1);
  var0.id = 21;
  var0.seatids["driver"] = 0;
  var0.seatids["passenger"] = 1;
}

function get_proximity_alias() {
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416c("cargo_truck_susp", 2300);
  var0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("cargo_truck_susp");
  var0.class = "heavy";
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413d("cargo_truck_susp");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("cargo_truck_susp", 12);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("cargo_truck_susp", &get_players_inside_the_plane);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417b("cargo_truck_mp", 5);
}

function get_prohibited_weapons_back() {
  var0 = _calloutmarkerping_predicted_log::ref_1410f("cargo_truck_susp", 1);
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

function get_push_force_direction() {
  level._effect["cargo_truck_susp_explode"] = loadfx("vfx/iw8_br/island/veh/vfx_br3_ct_death_exp.vfx");
}

function get_players_in_mortar_range(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var0.modelname = "veh_s4_mil_lnd_truck_opapa40_wz";
  var0.targetname = "cargo_truck_susp";
  var0.vehicletype = "cargo_truck_susp";
  var2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var0, var1);

  if(!isDefined(var2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var2, "cargo_truck_susp", var0);
  var2.objweapon = getcompleteweaponname("cargo_truck_mp");
  _calloutmarkerping_predicted_timeout::ref_1412b(var2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var2, var0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var2, undefined, &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cargo_truck_susp", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck_susp", "create")]](var2);
  }

  return var2;
}

function get_power_ref_from_weapon(var0, var1) {
  if(!isDefined(var0)) {
    var0 = spawnStruct();
    var0.inflictor = self;
    var0.objweapon = "cargo_truck_mp";
    var0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread get_players_not_targeted_by_other_battle_station();

  if(!istrue(level.suppressvehicleexplosion)) {
    var2 = self gettagorigin("tag_origin");
    var3 = scripts\engine\utility::ter_op(isDefined(var0.attacker), var0.attacker, self);
    self radiusdamage(var2, 256, 140, 70, var3, "MOD_EXPLOSIVE", "cargo_truck_mp");
    playFX(scripts\engine\utility::getfx("cargo_truck_susp_explode"), var2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var2, "car_explode");
    earthquake(0.4, 800, var2, 0.7);
    playrumbleonposition("grenade_rumble", var2);
    physicsexplosionsphere(var2, 500, 200, 1);
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

function get_players_inside_the_plane(var0) {
  thread get_power_ref_from_weapon(var0);
  return true;
}

function get_positions_around_vector(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    get_power_charges_in_slot(var0, var1, var2, var3, var4);
    return;
  }
}

function get_power_charges_in_slot(var0, var1, var2, var3, var4) {
  if(var1 == "driver") {
    var0 setotherent(var3);
    var0 setentityowner(var3);
    var3 controlslinkTo(var0);
  }

  var3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var0, var1, var2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var0, var2, var1, var3);
}

function get_power_max_charge_in_slot(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    get_power_name_in_slot(var0, var1, var2, var3, var4);
    return;
  }
}

function get_power_name_in_slot(var0, var1, var2, var3, var4) {
  if(var1 == "driver") {
    var0 setotherent(undefined);
    var0 setentityowner(undefined);

    if(!istrue(var4.playerdisconnect)) {
      var3 controlsunlink();
    }
  }

  if(!istrue(var4.playerdisconnect)) {
    var3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_stopanimatingplayer();
    var5 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit(var3, var2, var4);

    if(!var5) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "handleSuicideFromVehicles")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "handleSuicideFromVehicles")]](var3);
      } else {
        var3 suicide();
      }
    }
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(var0, var1, var2, var3);
}

function get_random_notnegative() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("cargo_truck_susp", 1);
  var0.maxinstancecount = 2;
  var0.priority = 75;
  var0.getspawnstructscallback = &get_precision_use_parameters;
  var0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck_susp", "spawnCallback");
  var0.clearancecheckradius = 185;
  var0.clearancecheckheight = 138;
  var0.clearancecheckminradius = 185;
}

function get_precision_use_parameters() {
  var0 = scripts\engine\utility::getStructArray("cargotrucksusp_spawn", "targetname");

  if(var0.size > 0) {
    var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var0, 1);

    if(var0.size > 1) {
      var0 = scripts\engine\utility::array_randomize(var0);
    }
  }

  return var0;
}
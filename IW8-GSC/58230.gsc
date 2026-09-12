/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58230.gsc
***********************************************/

function get_intel_location_vo() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("cargo_truck_mg", 1);
  var_0.destroycallback = &get_gunshot_alias;
  var_0.ref_13e92 = "tur_gun_cargo_truck_mp";
  get_landing_spots_in_current_circle();
  get_invalid_seats_from_module_struct();
  get_laser_combat_logic();
  get_intel_ref();
  get_intel_pickup_vo();
  get_intermission_time();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cargo_truck_mg", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck_mg", "init")]]();
  }

  get_last_callout_time();
  get_investigate_alias();
}

function get_investigate_alias() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cargo_truck_mg", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck_mg", "initLate")]]();
    return;
  }
}

function get_landing_spots_in_current_circle() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("cargo_truck_mg", 1);
  var_0.enterstartcallback = &get_grenadedanger_alias;
  var_0.enterendcallback = &get_grenade_fuse_time;
  var_0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = &get_ground_normal;
  var_0.reentercallback = &get_max_ai_from_infil_name;
  var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_0.exitextents["front"] = 175;
  var_0.exitextents["back"] = 180;
  var_0.exitextents["left"] = 68;
  var_0.exitextents["right"] = 68;
  var_0.exitextents["top"] = 138;
  var_0.exitextents["bottom"] = 0;
  var_1 = "front";
  var_0.exitoffsets[var_1] = (140, 0, 115);
  var_0.exitdirections[var_1] = "front";
  var_1 = "front_right";
  var_0.exitoffsets[var_1] = (65, 23, 115);
  var_0.exitdirections[var_1] = "right";
  var_1 = "back_right";
  var_0.exitoffsets[var_1] = (-152, 36, 115);
  var_0.exitdirections[var_1] = "back";
  var_1 = "side_right";
  var_0.exitoffsets[var_1] = (-109, 36, 115);
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
  var_1 = "back";
  var_0.exitoffsets[var_1] = (-152, 36, 115);
  var_0.exitdirections[var_1] = "back";
  var_2 = ["driver", "gunner"];
  var_3 = "driver";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("cargo_truck_mg", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["front_left", "side_left", "back_left", "front_right", "front"];
  var_4.animtag = "tag_seat_0";
  var_4.ref_12023 = "ping_vehicle_driver";
  var_3 = "gunner";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("cargo_truck_mg", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["front_right", "side_right", "back_right", "front_left", "front"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getturretpassengerrestrictions();
  var_4.ref_13e8a = getcompleteweaponname("tur_gun_cargo_truck_mp");
  var_4.ref_13e92 = "tur_gun_cargo_truck_mp";
  var_4.ref_12023 = "ping_vehicle_gunner";
}

function get_invalid_seats_from_module_struct() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("cargo_truck_mg", 1);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419d("cargo_truck_mg", "single", ["driver", "gunner"]);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419d("cargo_truck_mg", "upgrade", ["tag_screen_left", 1, &get_module_call_count]);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419d("cargo_truck_mg", "copyofupgrade", ["tag_screen_right", 1, &get_module_call_count]);
}

function get_laser_combat_logic() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e("cargo_truck_mg", 1);
  var_0.id = 16;
  var_0.seatids["driver"] = 0;
  var_0.seatids["gunner"] = 1;
  var_0.ref_12da2[0] = 0;
  var_0.ref_12da2[1] = 1;
  var_0.ref_12da3["driver"]["cargo_truck_mg_mp"] = 0;
  var_0.ref_12da3["driver"]["tur_gun_cargo_truck_mp"] = 1;
  var_0.ref_12da3["gunner"]["cargo_truck_mg_mp"] = 0;
  var_0.ref_12da3["gunner"]["tur_gun_cargo_truck_mp"] = 1;
}

function get_intel_ref() {
  var_0 = getdvarfloat("scr_armored_truck_health_override", 8750);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416c("cargo_truck_mg", var_0, undefined, undefined, undefined, 30);
  var_1 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("cargo_truck_mg");
  var_1.class = "heavy";
  var_2 = scripts\cp_mp\vehicles\vehicle_damage::ref_1414d("cargo_truck_mg", "heavy");
  var_2.ref_12024 = &get_linked_structs_with_script_noteworthy;
  var_2.ref_1202d = &get_living_agent_count;
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413d("cargo_truck_mg");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("cargo_truck_mg", getdvarint("scr_armor_truck_hits_to_kill", 40));
  scripts\cp_mp\vehicles\vehicle_damage::ref_14175("cargo_truck_mg", &get_living_agents);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("cargo_truck_mg", &get_goal_radius);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14173("cargo_truck_mg", "driver", getdvarfloat("armor_truck_damage_scale", 0.7));
  scripts\cp_mp\vehicles\vehicle_damage::ref_14172("cargo_truck_mg", "driver", getdvarfloat("armor_truck_damage_clamp", 15));
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417b("cargo_truck_mg_mp", 5);
}

function get_intel_pickup_vo() {
  var_0 = _calloutmarkerping_predicted_log::ref_1410f("cargo_truck_mg", 1);
  var_0.challengeevaluator = 2.16666;
  var_0.keycardlocs_chosen = 0.70833;
  var_0.is_using_stealth_debug = 350;
  var_0.is_valid_station_name = 525;
  var_0.is_two_hit_melee_weapon = 875;
  var_0.isakimbomeleeweapon = 3.75;
  var_0.isallowedweapon = 7.5;
  var_0.isakimbo = 15;
  var_0.isattachmentgrenadelauncher = 0;
  var_0.isattachmentselectfire = 0;
  var_0.isassaulting = 0;
}

function get_intermission_time() {
  level._effect["cargo_truck_mg_explode"] = loadfx("vfx/iw8_mp/vehicle/vfx_cargotr_mp_death_exp.vfx");
}

function get_heli_intro_vo() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("cargo_truck_mg");
  return var_0.ref_13e92;
}

function get_friendly_convoy_vehicle(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  if(!isDefined(var_0.modelname)) {
    var_0.modelname = "veh8_mil_lnd_mkilo23_gunner";
  }

  var_0.targetname = "cargo_truck_mg";

  if(!isDefined(var_0.vehicletype)) {
    var_0.vehicletype = "mkilo_physics_mg";
  }

  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  var_3 = get_heli_intro_vo();
  var_4 = "veh8_mil_lnd_mkilo23_gunner_turret";

  if(isDefined(var_0.turretmodel)) {
    var_4 = var_0.turretmodel;
  }

  var_5 = get_health_stage();
  var_6 = get_gas_martyr_grenade_types(var_2, var_3, var_4, var_5.tag, var_5.tagoffset);
  scripts\cp_mp\vehicles\vehicle::ref_14207(var_2, var_6, getcompleteweaponname(var_3));
  scripts\cp_mp\vehicles\vehicle::ref_14138(var_2, "cargo_truck_mg", var_0);
  var_2.objweapon = getcompleteweaponname("cargo_truck_mg_mp");
  var_2.ref_13e92 = var_3;
  var_2.ref_11b7b = 3;
  _calloutmarkerping_predicted_timeout::ref_1412b(var_2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var_2, var_0);
  var_7 = &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback;

  if(isDefined(var_0.player_rig_create)) {
    var_7 = var_0.player_rig_create;
  }

  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_2, undefined, var_7);
  thread get_module_struct_from_level(var_2);
  thread get_model_for_color_wire_cut(var_2);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cargo_truck_mg", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck_mg", "create")]](var_2);
  }

  return var_2;
}

function get_health_stage() {
  var_0 = spawnStruct();

  if(getdvarint("cargo_truck_turret_tag_animate", 0) == 1) {
    iprintlnbold("=== tag_body_animate ===");
    var_0.tag = "tag_body_animate";
    var_0.tagoffset = (58.87, 0, 60.052);
  } else {
    var_0.tag = "tag_turret";
    var_0.tagoffset = (0, 0, 0);
  }

  return var_0;
}

function get_gas_martyr_grenade_types(var_0, var_1, var_2, var_3, var_4) {
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

function get_gunshot_alias(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "cargo_truck_mg_mp";
    var_0.meansofdeath = "MOD_EXPLOSIVE";
  }

  if(!istrue(level.suppressvehicleexplosion)) {
    self notify("predeath");
    wait 0.2;
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var_0);

  if(!istrue(level.suppressvehicleexplosion)) {
    waitframe();
  }

  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread get_grenade_force();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("tag_origin");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker) && isent(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "cargo_truck_mg_mp");
    playFX(scripts\engine\utility::getfx("cargo_truck_mg_explode"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "veh_mkilo_mg_explode");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
    return;
  }
}

function get_grenade_force() {
  scripts\cp_mp\vehicles\vehicle::ref_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cargo_truck_mg", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck_mg", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::ref_14186(self);
}

function get_living_agents(var_0) {
  if(scripts\cp_mp\vehicles\vehicle_interact::ref_141ac(self, "armor")) {
    var_0.damage *= get_has_combined_counters_alias();
  }

  if(isDefined(var_0.damage) && var_0.damage > 0) {
    self notify("damage_taken", var_0);
  }

  return true;
}

function get_has_combined_counters_alias() {
  return 0.8333;
}

function get_goal_radius(var_0) {
  thread get_gunshot_alias(var_0);
  return true;
}

function get_linked_structs_with_script_noteworthy(var_0, var_1) {
  self setscriptablepartstate("alarm", "engineFailure", 0);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14163(var_0, var_1);
}

function get_living_agent_count(var_0, var_1) {
  self setscriptablepartstate("alarm", "off", 0);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14169(var_0, var_1);
}

function get_grenadedanger_alias(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "gunner") {
    scripts\cp_mp\vehicles\vehicle_occupancy::ref_141dc(var_3, var_4);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(var_3, var_0.ref_13e92, var_4, 1);
    return;
  }

  if(isDefined(var_2) && var_2 == "gunner") {
    scripts\cp_mp\vehicles\vehicle_occupancy::ref_141dc(var_3, var_4);
    return;
  }
}

function get_grenade_fuse_time(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    thread get_grenade_settings_from_group(var_0, var_1, var_2, var_3, var_4);
    return;
  }

  if(!istrue(var_4.playerdisconnect) && !istrue(var_4.playerdeath)) {
    if(var_1 == "gunner") {
      get_max_charges(var_3);
      return;
    }

    return;
  }
}

function get_grenade_settings_from_group(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;
  var_6 = undefined;

  if(isDefined(var_2) && var_2 == "gunner") {
    var_5 = "mkilo_physics_mg";
    var_6 = 6;
  }

  if(var_1 == "driver") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);
    var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2, undefined, var_5, var_6);
  } else if(var_1 == "gunner") {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(var_3, 0);
    var_7 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_0, var_0.ref_13e92);
    var_7.owner = var_3;
    var_7 setotherent(var_3);
    var_7 setentityowner(var_3);
    var_7 setsentryowner(var_3);
    var_3 disableturretdismount();
    var_3 controlturreton(var_7);
    get_focus_fire_multipler(var_3);
  }

  thread scripts\cp_mp\vehicles\vehicle_occupancy::ref_141f6(var_4, 1);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
  get_minigun_path(var_0, undefined);
}

function get_ground_normal(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    get_guilty_player_name(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function get_guilty_player_name(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(undefined);
    var_0 setentityowner(undefined);
  }

  var_5 = !isDefined(var_2);

  if(var_1 == "gunner" || var_5 && var_3 hasweapon(var_0.ref_13e92)) {
    var_6 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_0, var_0.ref_13e92);

    if(!istrue(var_4.playerdisconnect)) {
      var_3 enableturretdismount();
      var_3 controlturretoff(var_6);

      if(!istrue(var_4.playerdeath)) {
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var_3, var_0, var_0.ref_13e92, var_4, 1);
      }

      thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_cleardisablefirefortime(var_3, var_4.playerdeath);
    }

    var_6.owner = undefined;
    var_6 setotherent(undefined);
    var_6 setentityowner(undefined);
    var_6 setsentryowner(undefined);

    if(!istrue(var_4.playerdisconnect)) {
      get_max_charges(var_3);
    }
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
  get_minigun_path(var_0, undefined);
}

function get_focus_fire_multipler(var_0) {
  if(isDefined(var_0.set_thirdperson)) {
    return;
  }

  var_0.set_thirdperson = 1;
  var_1 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("cargo_truck_mg");

  if(istrue(var_1.ref_133d3)) {
    return;
  }

  var_0 scripts\cp_mp\utility\damage_utility::adddamagemodifier("ctmgGunnerMissileRedux", 0.4, 0, &get_id_based_on_task);
}

function get_max_charges(var_0) {
  if(!isDefined(var_0.set_thirdperson)) {
    return;
  }

  var_0.set_thirdperson = undefined;
  var_1 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("cargo_truck_mg");

  if(istrue(var_1.ref_133d3)) {
    return;
  }

  var_0 scripts\cp_mp\utility\damage_utility::removedamagemodifier("ctmgGunnerMissileRedux", 0);
}

function get_id_based_on_task(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_4 != "MOD_PROJECTILE_SPLASH" && var_4 != "MOD_GRENADE_SPLASH") {
    return 1;
  }

  if(!isDefined(var_5)) {
    return 1;
  }

  switch (var_5.basename) {
    case "iw8_la_t9launcher_mp":
    case "iw8_la_t9freefire_mp":
    case "lighttank_tur_mp":
    case "iw8_la_rpapa7_mp":
    case "iw8_la_kgolf_mp":
    case "iw8_la_juliet_mp":
    case "iw8_la_gromeo_mp":
    case "iw8_la_gromeoks_mp":
    case "iw8_la_mike32_mp":
    case "tur_gun_cargo_truck_mp":
    case "iw8_la_t9standard_mp":
      return 0;
    default:
      return 1;
  }
}

function get_max_ai_from_infil_name(var_0, var_1, var_2, var_3, var_4) {
  scripts\cp_mp\vehicles\vehicle_occupancy::ref_141f6(var_4);
  thread get_mortar_targets(var_0, var_1, var_2, var_3, var_4);
}

function get_mortar_targets(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_2) && var_2 == "gunner") {
    var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141dc(var_3, var_4);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var_3, var_0, var_0.ref_13e92, var_4, 1);
    scripts\cp_mp\vehicles\vehicle_occupancy::ref_141f7(var_5);
    return;
  }
}

function get_module_struct_from_level(var_0) {
  var_0 endon("death");

  for(;;) {
    var_0 waittill("give_upgrade", var_1, var_2);

    switch (var_1) {
      case "armor":
        get_heli_structs(var_0);
        break;
      case "trophy":
        get_hover_attack_direction(var_0);
        break;
      case "uav":
        get_huntfirstlost_alias(var_0, var_2);
        break;
      case "barrel":
        get_highest_priority_goal_position(var_0);
        break;
    }

    get_minigun_path(var_0, var_2);
  }
}

function get_heli_structs(var_0) {
  var_0 setscriptablepartstate("armor", "show");
  var_0.ref_11e06 = 1.0769;
  var_0.ref_11e07 = 0.9411;
  var_1 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_0, var_0.ref_13e92);
  var_1 setscriptablepartstate("armor", "show");
  var_0 notify("upgrade_message", "armor_upgraded");
}

function get_hover_attack_direction(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_trophy", "init")) {
    if(isDefined(var_0.ref_13ddf)) {
      var_0.ref_13ddf = 3;
      var_0 notify("trophy_ammo_refill");
      var_0 notify("upgrade_message", "trophy_ammo_refill");
      return;
    }

    var_0.ref_13ddf = 3;
    var_0 setscriptablepartstate("trophy", "show");
    var_1 = scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_trophy", "init");
    var_0 thread[[var_1]](72, 280900, &ref_13dda, &trophy_protectionsuccessful);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_trophyCreateExplosion", "init")) {
      var_0.explosion = [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_trophyCreateExplosion", "init")]](var_0);
    }

    var_0 notify("upgrade_message", "trophy_activated");
    return;
  }
}

function ref_13dda() {
  return true;
}

function trophy_protectionsuccessful(var_0) {
  self.ref_13ddf--;
  var_1 = var_0.origin;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_trophyDestroyTarget", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_trophyDestroyTarget", "init")]](var_0);
  }

  var_2 = trophy_getbesttag(var_1);
  self setscriptablepartstate("trophy_detonate", var_2);
  var_3 = vectortoangles(self gettagorigin(var_2) - var_1);
  var_4 = combineangles(var_3, (-90, 0, 0));

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_trophyExplode", "init")) {
    self.explosion thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_trophyExplode", "init")]](var_1, var_4);
  }

  if(self.ref_13ddf == 0) {
    self notify("upgrade_message", "trophy_no_ammo");
    self waittill("trophy_ammo_refill");
    return;
  }

  self notify("upgrade_message", "trophy_ammo_used");
}

function trophy_getbesttag(var_0) {
  var_1 = ["tag_trophy_1", "tag_trophy_2", "tag_trophy_3", "tag_trophy_4"];
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in var_1) {
    var_6 = self gettagorigin(var_5);
    var_7 = distancesquared(var_6, var_0);

    if(var_8 == 0 || var_7 < var_2) {
      var_2 = var_7;
      var_3 = var_5;
    }
  }

  return var_3;
}

function get_huntfirstlost_alias(var_0, var_1) {
  get_max_from_call_count(var_0, var_1);
  var_0.ref_129c5 = 1;
  var_0 setscriptablepartstate("radar", "show");
  thread ref_12bf9();
  var_0 notify("upgrade_message", "uav_activated");
}

function get_max_from_call_count(var_0, var_1) {
  var_2 = getdvarint("scr_truck_mg_uav_type", 0);

  if(var_2 == 0) {
    var_0 method_87ab();
    return;
  }

  if(isDefined(var_1)) {
    var_3 = spawn("script_model", var_0.origin);
    var_3 setModel("tag_origin");
    var_3 linkTo(var_0);
    var_3 makeportableradar(var_1);
    var_0.radar = var_3;
    thread get_max_ai_per_site(level, var_0);
    return;
  }
}

function get_martyrdom_grenade_types(var_0, var_1) {
  if(isDefined(var_0.radar)) {
    var_0.radar delete();
  } else if(istrue(var_0.ref_129c5)) {
    var_0 method_87ac();
  }

  if(istrue(var_0.ref_129c5)) {
    get_max_from_call_count(var_0, var_1);
    return;
  }
}

function get_max_ai_per_site(var_0, var_1) {
  var_0 endon("death");
  var_0.radar endon("death");
  var_2 = var_1.team;
  var_1 waittill("disconnect");
  var_3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](var_2, 0);
  var_4 = undefined;

  if(isDefined(var_3) && var_3.size > 0) {
    var_4 = var_3[0];
  }

  thread get_martyrdom_grenade_types(level, var_0);
}

function ref_12bf9() {
  level endon("game_ended");
  self waittill("death");

  if(isDefined(self.radar)) {
    self.radar delete();
    return;
  }
}

function get_highest_priority_goal_position(var_0) {
  var_1 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_0, var_0.ref_13e92);
  var_1 setscriptablepartstate("barrel", "show");
  var_2 = getdvarfloat("truck_turret_upgrade_heat_acc", 0.033);
  var_3 = getdvarfloat("truck_turret_upgrade_heat_dsipt", 0.155);
  var_1 method_87ad(var_2);
  var_1 method_87af(var_3);
  var_0 notify("upgrade_message", "barrel_activated");
}

function get_model_for_color_wire_cut(var_0) {
  var_0 endon("death");
  var_0.ref_12664 = [];

  for(;;) {
    foreach(var_2 in var_0.ref_12664) {
      get_module_call_count(var_0, var_2);
    }

    wait 0.1;
  }
}

function get_module_call_count(var_0, var_1) {
  var_2 = 0;

  if(scripts\cp_mp\vehicles\vehicle_interact::ref_141ac(var_0, "uav")) {
    var_2 += 1;
  }

  if(scripts\cp_mp\vehicles\vehicle_interact::ref_141ac(var_0, "armor")) {
    var_2 += 2;
  }

  if(scripts\cp_mp\vehicles\vehicle_interact::ref_141ac(var_0, "trophy")) {
    var_2 += 4;
  }

  if(scripts\cp_mp\vehicles\vehicle_interact::ref_141ac(var_0, "barrel")) {
    var_2 += 8;
  }

  if(isDefined(var_0.ref_13ddf) && var_0.ref_13ddf == 3) {
    var_2 += 16;
  }

  if(var_0.health == var_0.maxhealth) {
    var_2 += 32;
  }

  var_1 _calloutmarkerping_handleluinotify_added::ref_13133("ui_armored_truck_status", var_2);
}

function get_minigun_path(var_0, var_1) {
  if(!getdvarint("scr_cargo_truck_mg_update_upgrade_team", 0)) {
    return;
  }

  var_2 = get_linked_struct_with_script_noteworthy(var_0);
  var_3 = get_gunshotteammate_alias(var_0, var_2, var_1);

  if(var_3 == "neutral") {
    return;
  }

  if(!isDefined(var_0.ref_13df6)) {
    var_0.ref_13df6 = var_3;
  }

  if(var_0.ref_13df6 == var_3) {
    return;
  }

  var_0.ref_13df6 = var_3;
  var_4 = get_lostsight_alias(var_0, var_1);
  get_martyrdom_grenade_types(var_0, var_0, var_4);
}

function get_linked_struct_with_script_noteworthy(var_0) {
  var_1 = var_0.occupants["driver"];

  if(isDefined(var_1)) {
    return var_1.team;
  }

  var_2 = var_0.occupants["gunner"];

  if(isDefined(var_2)) {
    return var_2.team;
  }

  return "neutral";
}

function get_gunshotteammate_alias(var_0, var_1, var_2) {
  if(var_1 != "neutral") {
    return var_1;
  }

  if(isDefined(var_2)) {
    return var_2.team;
  }

  return var_0.team;
}

function get_lostsight_alias(var_0, var_1) {
  if(isDefined(var_1)) {
    return var_1;
  }

  var_2 = var_0.occupants["driver"];

  if(isDefined(var_2)) {
    return var_2;
  }

  var_3 = var_0.occupants["gunner"];

  if(isDefined(var_3)) {
    return var_3;
  }

  return undefined;
}

function get_last_callout_time() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("cargo_truck_mg", 1);
  var_0.maxinstancecount = 2;
  var_0.priority = 75;
  var_0.getspawnstructscallback = &get_health_multiplier_relic_mythic;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck_mg", "spawnCallback");
  var_0.clearancecheckradius = 185;
  var_0.clearancecheckheight = 138;
  var_0.clearancecheckminradius = 185;
}

function get_health_multiplier_relic_mythic() {
  var_0 = scripts\engine\utility::getStructArray("cargotruckmg_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}
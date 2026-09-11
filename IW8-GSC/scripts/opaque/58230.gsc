/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58230.gsc
***********************************************/

function get_intel_location_vo() {
  var0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("cargo_truck_mg", 1);
  var0.destroycallback = &get_gunshot_alias;
  var0.ref_13e92 = "tur_gun_cargo_truck_mp";
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
  var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("cargo_truck_mg", 1);
  var0.enterstartcallback = &get_grenadedanger_alias;
  var0.enterendcallback = &get_grenade_fuse_time;
  var0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var0.exitendcallback = &get_ground_normal;
  var0.reentercallback = &get_max_ai_from_infil_name;
  var0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var0.exitextents["front"] = 175;
  var0.exitextents["back"] = 180;
  var0.exitextents["left"] = 68;
  var0.exitextents["right"] = 68;
  var0.exitextents["top"] = 138;
  var0.exitextents["bottom"] = 0;
  var1 = "front";
  var0.exitoffsets[var1] = (140, 0, 115);
  var0.exitdirections[var1] = "front";
  var1 = "front_right";
  var0.exitoffsets[var1] = (65, 23, 115);
  var0.exitdirections[var1] = "right";
  var1 = "back_right";
  var0.exitoffsets[var1] = (-152, 36, 115);
  var0.exitdirections[var1] = "back";
  var1 = "side_right";
  var0.exitoffsets[var1] = (-109, 36, 115);
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
  var1 = "back";
  var0.exitoffsets[var1] = (-152, 36, 115);
  var0.exitdirections[var1] = "back";
  var2 = ["driver", "gunner"];
  var3 = "driver";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("cargo_truck_mg", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = ["front_left", "side_left", "back_left", "front_right", "front"];
  var4.animtag = "tag_seat_0";
  var4.ref_12023 = "ping_vehicle_driver";
  var3 = "gunner";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("cargo_truck_mg", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = ["front_right", "side_right", "back_right", "front_left", "front"];
  var4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getturretpassengerrestrictions();
  var4.ref_13e8a = getcompleteweaponname("tur_gun_cargo_truck_mp");
  var4.ref_13e92 = "tur_gun_cargo_truck_mp";
  var4.ref_12023 = "ping_vehicle_gunner";
}

function get_invalid_seats_from_module_struct() {
  var0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("cargo_truck_mg", 1);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419d("cargo_truck_mg", "single", ["driver", "gunner"]);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419d("cargo_truck_mg", "upgrade", ["tag_screen_left", 1, &get_module_call_count]);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419d("cargo_truck_mg", "copyofupgrade", ["tag_screen_right", 1, &get_module_call_count]);
}

function get_laser_combat_logic() {
  var0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e("cargo_truck_mg", 1);
  var0.id = 16;
  var0.seatids["driver"] = 0;
  var0.seatids["gunner"] = 1;
  var0.ref_12da2[0] = 0;
  var0.ref_12da2[1] = 1;
  var0.ref_12da3["driver"]["cargo_truck_mg_mp"] = 0;
  var0.ref_12da3["driver"]["tur_gun_cargo_truck_mp"] = 1;
  var0.ref_12da3["gunner"]["cargo_truck_mg_mp"] = 0;
  var0.ref_12da3["gunner"]["tur_gun_cargo_truck_mp"] = 1;
}

function get_intel_ref() {
  var0 = getdvarfloat("scr_armored_truck_health_override", 8750);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416c("cargo_truck_mg", var0, undefined, undefined, undefined, 30);
  var1 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("cargo_truck_mg");
  var1.class = "heavy";
  var2 = scripts\cp_mp\vehicles\vehicle_damage::ref_1414d("cargo_truck_mg", "heavy");
  var2.ref_12024 = &get_linked_structs_with_script_noteworthy;
  var2.ref_1202d = &get_living_agent_count;
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413d("cargo_truck_mg");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("cargo_truck_mg", getdvarint("scr_armor_truck_hits_to_kill", 40));
  scripts\cp_mp\vehicles\vehicle_damage::ref_14175("cargo_truck_mg", &get_living_agents);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("cargo_truck_mg", &get_goal_radius);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14173("cargo_truck_mg", "driver", getdvarfloat("armor_truck_damage_scale", 0.7));
  scripts\cp_mp\vehicles\vehicle_damage::ref_14172("cargo_truck_mg", "driver", getdvarfloat("armor_truck_damage_clamp", 15));
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417b("cargo_truck_mg_mp", 5);
}

function get_intel_pickup_vo() {
  var0 = _calloutmarkerping_predicted_log::ref_1410f("cargo_truck_mg", 1);
  var0.challengeevaluator = 2.16666;
  var0.keycardlocs_chosen = 0.70833;
  var0.is_using_stealth_debug = 350;
  var0.is_valid_station_name = 525;
  var0.is_two_hit_melee_weapon = 875;
  var0.isakimbomeleeweapon = 3.75;
  var0.isallowedweapon = 7.5;
  var0.isakimbo = 15;
  var0.isattachmentgrenadelauncher = 0;
  var0.isattachmentselectfire = 0;
  var0.isassaulting = 0;
}

function get_intermission_time() {
  level._effect["cargo_truck_mg_explode"] = loadfx("vfx/iw8_mp/vehicle/vfx_cargotr_mp_death_exp.vfx");
}

function get_heli_intro_vo() {
  var0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("cargo_truck_mg");
  return var0.ref_13e92;
}

function get_friendly_convoy_vehicle(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  if(!isDefined(var0.modelname)) {
    var0.modelname = "veh8_mil_lnd_mkilo23_gunner";
  }

  var0.targetname = "cargo_truck_mg";

  if(!isDefined(var0.vehicletype)) {
    var0.vehicletype = "mkilo_physics_mg";
  }

  var2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var0, var1);

  if(!isDefined(var2)) {
    return undefined;
  }

  var3 = get_heli_intro_vo();
  var4 = "veh8_mil_lnd_mkilo23_gunner_turret";

  if(isDefined(var0.turretmodel)) {
    var4 = var0.turretmodel;
  }

  var5 = get_health_stage();
  var6 = get_gas_martyr_grenade_types(var2, var3, var4, var5.tag, var5.tagoffset);
  scripts\cp_mp\vehicles\vehicle::ref_14207(var2, var6, getcompleteweaponname(var3));
  scripts\cp_mp\vehicles\vehicle::ref_14138(var2, "cargo_truck_mg", var0);
  var2.objweapon = getcompleteweaponname("cargo_truck_mg_mp");
  var2.ref_13e92 = var3;
  var2.ref_11b7b = 3;
  _calloutmarkerping_predicted_timeout::ref_1412b(var2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var2, var0);
  var7 = &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback;

  if(isDefined(var0.player_rig_create)) {
    var7 = var0.player_rig_create;
  }

  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var2, undefined, var7);
  thread get_module_struct_from_level(var2);
  thread get_model_for_color_wire_cut(var2);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cargo_truck_mg", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck_mg", "create")]](var2);
  }

  return var2;
}

function get_health_stage() {
  var0 = spawnStruct();

  if(getdvarint("cargo_truck_turret_tag_animate", 0) == 1) {
    iprintlnbold("=== tag_body_animate ===");
    var0.tag = "tag_body_animate";
    var0.tagoffset = (58.87, 0, 60.052);
  } else {
    var0.tag = "tag_turret";
    var0.tagoffset = (0, 0, 0);
  }

  return var0;
}

function get_gas_martyr_grenade_types(var0, var1, var2, var3, var4) {
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

function get_gunshot_alias(var0, var1) {
  if(!isDefined(var0)) {
    var0 = spawnStruct();
    var0.inflictor = self;
    var0.objweapon = "cargo_truck_mg_mp";
    var0.meansofdeath = "MOD_EXPLOSIVE";
  }

  if(!istrue(level.suppressvehicleexplosion)) {
    self notify("predeath");
    wait 0.2;
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var0);

  if(!istrue(level.suppressvehicleexplosion)) {
    waitframe();
  }

  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread get_grenade_force();

  if(!istrue(level.suppressvehicleexplosion)) {
    var2 = self gettagorigin("tag_origin");
    var3 = scripts\engine\utility::ter_op(isDefined(var0.attacker) && isent(var0.attacker), var0.attacker, self);
    self radiusdamage(var2, 256, 140, 70, var3, "MOD_EXPLOSIVE", "cargo_truck_mg_mp");
    playFX(scripts\engine\utility::getfx("cargo_truck_mg_explode"), var2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var2, "veh_mkilo_mg_explode");
    earthquake(0.4, 800, var2, 0.7);
    playrumbleonposition("grenade_rumble", var2);
    physicsexplosionsphere(var2, 500, 200, 1);
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

function get_living_agents(var0) {
  if(scripts\cp_mp\vehicles\vehicle_interact::ref_141ac(self, "armor")) {
    var0.damage *= get_has_combined_counters_alias();
  }

  if(isDefined(var0.damage) && var0.damage > 0) {
    self notify("damage_taken", var0);
  }

  return true;
}

function get_has_combined_counters_alias() {
  return 0.8333;
}

function get_goal_radius(var0) {
  thread get_gunshot_alias(var0);
  return true;
}

function get_linked_structs_with_script_noteworthy(var0, var1) {
  self setscriptablepartstate("alarm", "engineFailure", 0);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14163(var0, var1);
}

function get_living_agent_count(var0, var1) {
  self setscriptablepartstate("alarm", "off", 0);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14169(var0, var1);
}

function get_grenadedanger_alias(var0, var1, var2, var3, var4) {
  if(var1 == "gunner") {
    scripts\cp_mp\vehicles\vehicle_occupancy::ref_141dc(var3, var4);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(var3, var0.ref_13e92, var4, 1);
    return;
  }

  if(isDefined(var2) && var2 == "gunner") {
    scripts\cp_mp\vehicles\vehicle_occupancy::ref_141dc(var3, var4);
    return;
  }
}

function get_grenade_fuse_time(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    thread get_grenade_settings_from_group(var0, var1, var2, var3, var4);
    return;
  }

  if(!istrue(var4.playerdisconnect) && !istrue(var4.playerdeath)) {
    if(var1 == "gunner") {
      get_max_charges(var3);
      return;
    }

    return;
  }
}

function get_grenade_settings_from_group(var0, var1, var2, var3, var4) {
  var5 = undefined;
  var6 = undefined;

  if(isDefined(var2) && var2 == "gunner") {
    var5 = "mkilo_physics_mg";
    var6 = 6;
  }

  if(var1 == "driver") {
    var0 setotherent(var3);
    var0 setentityowner(var3);
    var3 controlslinkTo(var0);
    var3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var0, var1, var2, undefined, var5, var6);
  } else if(var1 == "gunner") {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(var3, 0);
    var7 = scripts\cp_mp\vehicles\vehicle::ref_14192(var0, var0.ref_13e92);
    var7.owner = var3;
    var7 setotherent(var3);
    var7 setentityowner(var3);
    var7 setsentryowner(var3);
    var3 disableturretdismount();
    var3 controlturreton(var7);
    get_focus_fire_multipler(var3);
  }

  thread scripts\cp_mp\vehicles\vehicle_occupancy::ref_141f6(var4, 1);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var0, var2, var1, var3);
  get_minigun_path(var0, undefined);
}

function get_ground_normal(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    get_guilty_player_name(var0, var1, var2, var3, var4);
    return;
  }
}

function get_guilty_player_name(var0, var1, var2, var3, var4) {
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

    if(!istrue(var4.playerdisconnect)) {
      get_max_charges(var3);
    }
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
  get_minigun_path(var0, undefined);
}

function get_focus_fire_multipler(var0) {
  if(isDefined(var0.set_thirdperson)) {
    return;
  }

  var0.set_thirdperson = 1;
  var1 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("cargo_truck_mg");

  if(istrue(var1.ref_133d3)) {
    return;
  }

  var0 scripts\cp_mp\utility\damage_utility::adddamagemodifier("ctmgGunnerMissileRedux", 0.4, 0, &get_id_based_on_task);
}

function get_max_charges(var0) {
  if(!isDefined(var0.set_thirdperson)) {
    return;
  }

  var0.set_thirdperson = undefined;
  var1 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("cargo_truck_mg");

  if(istrue(var1.ref_133d3)) {
    return;
  }

  var0 scripts\cp_mp\utility\damage_utility::removedamagemodifier("ctmgGunnerMissileRedux", 0);
}

function get_id_based_on_task(var0, var1, var2, var3, var4, var5, var6) {
  if(var4 != "MOD_PROJECTILE_SPLASH" && var4 != "MOD_GRENADE_SPLASH") {
    return 1;
  }

  if(!isDefined(var5)) {
    return 1;
  }

  switch (var5.basename) {
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

function get_max_ai_from_infil_name(var0, var1, var2, var3, var4) {
  scripts\cp_mp\vehicles\vehicle_occupancy::ref_141f6(var4);
  thread get_mortar_targets(var0, var1, var2, var3, var4);
}

function get_mortar_targets(var0, var1, var2, var3, var4) {
  if(isDefined(var2) && var2 == "gunner") {
    var5 = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141dc(var3, var4);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var3, var0, var0.ref_13e92, var4, 1);
    scripts\cp_mp\vehicles\vehicle_occupancy::ref_141f7(var5);
    return;
  }
}

function get_module_struct_from_level(var0) {
  var0 endon("death");

  for(;;) {
    var0 waittill("give_upgrade", var1, var2);

    switch (var1) {
      case "armor":
        get_heli_structs(var0);
        break;
      case "trophy":
        get_hover_attack_direction(var0);
        break;
      case "uav":
        get_huntfirstlost_alias(var0, var2);
        break;
      case "barrel":
        get_highest_priority_goal_position(var0);
        break;
    }

    get_minigun_path(var0, var2);
  }
}

function get_heli_structs(var0) {
  var0 setscriptablepartstate("armor", "show");
  var0.ref_11e06 = 1.0769;
  var0.ref_11e07 = 0.9411;
  var1 = scripts\cp_mp\vehicles\vehicle::ref_14192(var0, var0.ref_13e92);
  var1 setscriptablepartstate("armor", "show");
  var0 notify("upgrade_message", "armor_upgraded");
}

function get_hover_attack_direction(var0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_trophy", "init")) {
    if(isDefined(var0.ref_13ddf)) {
      var0.ref_13ddf = 3;
      var0 notify("trophy_ammo_refill");
      var0 notify("upgrade_message", "trophy_ammo_refill");
      return;
    }

    var0.ref_13ddf = 3;
    var0 setscriptablepartstate("trophy", "show");
    var1 = scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_trophy", "init");
    var0 thread[[var1]](72, 280900, &ref_13dda, &trophy_protectionsuccessful);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_trophyCreateExplosion", "init")) {
      var0.explosion = [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_trophyCreateExplosion", "init")]](var0);
    }

    var0 notify("upgrade_message", "trophy_activated");
    return;
  }
}

function ref_13dda() {
  return true;
}

function trophy_protectionsuccessful(var0) {
  self.ref_13ddf--;
  var1 = var0.origin;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_trophyDestroyTarget", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_trophyDestroyTarget", "init")]](var0);
  }

  var2 = trophy_getbesttag(var1);
  self setscriptablepartstate("trophy_detonate", var2);
  var3 = vectortoangles(self gettagorigin(var2) - var1);
  var4 = combineangles(var3, (-90, 0, 0));

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_trophyExplode", "init")) {
    self.explosion thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_trophyExplode", "init")]](var1, var4);
  }

  if(self.ref_13ddf == 0) {
    self notify("upgrade_message", "trophy_no_ammo");
    self waittill("trophy_ammo_refill");
    return;
  }

  self notify("upgrade_message", "trophy_ammo_used");
}

function trophy_getbesttag(var0) {
  var1 = ["tag_trophy_1", "tag_trophy_2", "tag_trophy_3", "tag_trophy_4"];
  var2 = undefined;
  var3 = undefined;

  foreach(var5 in var1) {
    var6 = self gettagorigin(var5);
    var7 = distancesquared(var6, var0);

    if(var8 == 0 || var7 < var2) {
      var2 = var7;
      var3 = var5;
    }
  }

  return var3;
}

function get_huntfirstlost_alias(var0, var1) {
  get_max_from_call_count(var0, var1);
  var0.ref_129c5 = 1;
  var0 setscriptablepartstate("radar", "show");
  thread ref_12bf9();
  var0 notify("upgrade_message", "uav_activated");
}

function get_max_from_call_count(var0, var1) {
  var2 = getdvarint("scr_truck_mg_uav_type", 0);

  if(var2 == 0) {
    var0 method_87ab();
    return;
  }

  if(isDefined(var1)) {
    var3 = spawn("script_model", var0.origin);
    var3 setModel("tag_origin");
    var3 linkTo(var0);
    var3 makeportableradar(var1);
    var0.radar = var3;
    thread get_max_ai_per_site(level, var0);
    return;
  }
}

function get_martyrdom_grenade_types(var0, var1) {
  if(isDefined(var0.radar)) {
    var0.radar delete();
  } else if(istrue(var0.ref_129c5)) {
    var0 method_87ac();
  }

  if(istrue(var0.ref_129c5)) {
    get_max_from_call_count(var0, var1);
    return;
  }
}

function get_max_ai_per_site(var0, var1) {
  var0 endon("death");
  var0.radar endon("death");
  var2 = var1.team;
  var1 waittill("disconnect");
  var3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](var2, 0);
  var4 = undefined;

  if(isDefined(var3) && var3.size > 0) {
    var4 = var3[0];
  }

  thread get_martyrdom_grenade_types(level, var0);
}

function ref_12bf9() {
  level endon("game_ended");
  self waittill("death");

  if(isDefined(self.radar)) {
    self.radar delete();
    return;
  }
}

function get_highest_priority_goal_position(var0) {
  var1 = scripts\cp_mp\vehicles\vehicle::ref_14192(var0, var0.ref_13e92);
  var1 setscriptablepartstate("barrel", "show");
  var2 = getdvarfloat("truck_turret_upgrade_heat_acc", 0.033);
  var3 = getdvarfloat("truck_turret_upgrade_heat_dsipt", 0.155);
  var1 method_87ad(var2);
  var1 method_87af(var3);
  var0 notify("upgrade_message", "barrel_activated");
}

function get_model_for_color_wire_cut(var0) {
  var0 endon("death");
  var0.ref_12664 = [];

  for(;;) {
    foreach(var2 in var0.ref_12664) {
      get_module_call_count(var0, var2);
    }

    wait 0.1;
  }
}

function get_module_call_count(var0, var1) {
  var2 = 0;

  if(scripts\cp_mp\vehicles\vehicle_interact::ref_141ac(var0, "uav")) {
    var2 += 1;
  }

  if(scripts\cp_mp\vehicles\vehicle_interact::ref_141ac(var0, "armor")) {
    var2 += 2;
  }

  if(scripts\cp_mp\vehicles\vehicle_interact::ref_141ac(var0, "trophy")) {
    var2 += 4;
  }

  if(scripts\cp_mp\vehicles\vehicle_interact::ref_141ac(var0, "barrel")) {
    var2 += 8;
  }

  if(isDefined(var0.ref_13ddf) && var0.ref_13ddf == 3) {
    var2 += 16;
  }

  if(var0.health == var0.maxhealth) {
    var2 += 32;
  }

  var1 _calloutmarkerping_handleluinotify_added::ref_13133("ui_armored_truck_status", var2);
}

function get_minigun_path(var0, var1) {
  if(!getdvarint("scr_cargo_truck_mg_update_upgrade_team", 0)) {
    return;
  }

  var2 = get_linked_struct_with_script_noteworthy(var0);
  var3 = get_gunshotteammate_alias(var0, var2, var1);

  if(var3 == "neutral") {
    return;
  }

  if(!isDefined(var0.ref_13df6)) {
    var0.ref_13df6 = var3;
  }

  if(var0.ref_13df6 == var3) {
    return;
  }

  var0.ref_13df6 = var3;
  var4 = get_lostsight_alias(var0, var1);
  get_martyrdom_grenade_types(var0, var0, var4);
}

function get_linked_struct_with_script_noteworthy(var0) {
  var1 = var0.occupants["driver"];

  if(isDefined(var1)) {
    return var1.team;
  }

  var2 = var0.occupants["gunner"];

  if(isDefined(var2)) {
    return var2.team;
  }

  return "neutral";
}

function get_gunshotteammate_alias(var0, var1, var2) {
  if(var1 != "neutral") {
    return var1;
  }

  if(isDefined(var2)) {
    return var2.team;
  }

  return var0.team;
}

function get_lostsight_alias(var0, var1) {
  if(isDefined(var1)) {
    return var1;
  }

  var2 = var0.occupants["driver"];

  if(isDefined(var2)) {
    return var2;
  }

  var3 = var0.occupants["gunner"];

  if(isDefined(var3)) {
    return var3;
  }

  return undefined;
}

function get_last_callout_time() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("cargo_truck_mg", 1);
  var0.maxinstancecount = 2;
  var0.priority = 75;
  var0.getspawnstructscallback = &get_health_multiplier_relic_mythic;
  var0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("cargo_truck_mg", "spawnCallback");
  var0.clearancecheckradius = 185;
  var0.clearancecheckheight = 138;
  var0.clearancecheckminradius = 185;
}

function get_health_multiplier_relic_mythic() {
  var0 = scripts\engine\utility::getStructArray("cargotruckmg_spawn", "targetname");

  if(var0.size > 0) {
    var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var0, 1);

    if(var0.size > 1) {
      var0 = scripts\engine\utility::array_randomize(var0);
    }
  }

  return var0;
}
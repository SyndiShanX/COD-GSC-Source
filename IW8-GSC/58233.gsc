/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58233.gsc
***********************************************/

function hvi_vehicle_rider_special_setup() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("convoy_truck", "spawnCallback", &hvtlist);
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("convoy_truck", 1);
  var_0.destroycallback = &hvi_patrol_exit;
  hvt_drop_from_truck_to_ground();
  hvt_can_lose_health();
  hvt_anim_and_close_doors();
  hvt_death_player_vo();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("convoy_truck", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("convoy_truck", "init")]]();
  }

  hvt_key_dropped();
  hvt_delayed_cig();
}

function hvt_drop_from_truck_to_ground() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427E("convoy_truck", 1);
  var_0.id = 26;
  var_0.ref_12DA2[0] = 0;
}

function hvt_delayed_cig() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("convoy_truck", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("convoy_truck", "initLate")]]();
    return;
  }
}

function hvt_can_lose_health() {
  var_0 = getdvarfloat("scr_armored_truck_health_override", 8750);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416C("convoy_truck", var_0, undefined, undefined, undefined, 30);
  var_1 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("convoy_truck");
  var_1.class = "heavy";
  var_2 = scripts\cp_mp\vehicles\vehicle_damage::ref_1414D("convoy_truck", "heavy");
  var_2.ref_12024 = &hvt_visual_leaving_callout;
  var_2.ref_1202D = &hvt_waittill_pickup_players_gobackup;
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413D("convoy_truck");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("convoy_truck", 40);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14175("convoy_truck", &hvtboardingside);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("convoy_truck", &hvi_escort_exit);
}

function hvt_anim_and_close_doors() {
  var_0 = _calloutmarkerping_predicted_log::ref_1410F("convoy_truck", 1);
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

function hvt_death_player_vo() {
  level._effect["convoy_truck_explode"] = loadfx("vfx/iw8_mp/vehicle/vfx_cargotr_mp_death_exp.vfx");
}

function hurtplayersinbunker(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  if(!isDefined(var_0.modelname)) {
    var_0.modelname = "veh_s4_mil_lnd_truck_opapa40_armored_wz";
  }

  var_0.targetname = "convoy_truck";

  if(!isDefined(var_0.vehicletype)) {
    var_0.vehicletype = "mkilo_physics_mg_convoy";
  }

  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var_2, "convoy_truck", var_0);
  _calloutmarkerping_predicted_timeout::ref_1412B(var_2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var_2, var_0);
  var_3 = &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback;

  if(isDefined(var_0.player_rig_create)) {
    var_3 = var_0.player_rig_create;
  }

  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_2, undefined, var_3);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("convoy_truck", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("convoy_truck", "create")]](var_2);
  }

  return var_2;
}

function hvi_patrol_exit(var_0, var_1) {
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

  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread hvi_escort_intro();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("tag_origin");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker) && isent(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE");
    playFX(scripts\engine\utility::getfx("convoy_truck_explode"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "car_explode");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
    return;
  }
}

function hvi_escort_intro() {
  scripts\cp_mp\vehicles\vehicle::ref_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("convoy_truck", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("convoy_truck", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::ref_14186(self);
}

function hvtboardingside(var_0) {
  if(isDefined(var_0.damage) && var_0.damage > 0) {
    self notify("damage_taken", var_0);
  }

  return true;
}

function hvi_escort_exit(var_0) {
  thread hvi_patrol_exit(var_0);
  return true;
}

function hvt_visual_leaving_callout(var_0, var_1) {
  self setscriptablepartstate("alarm", "engineFailure", 0);

  if(getdvarint("scr_armored_convoy_stop_truck_on_disabled", 0) == 1) {
    self notify("kill_mines");
    self vehicle_setspeed(0, 5, 5);
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14163(var_0, var_1);
}

function hvt_waittill_pickup_players_gobackup(var_0, var_1) {
  self setscriptablepartstate("alarm", "off", 0);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14169(var_0, var_1);
}

function hvt_key_dropped() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("convoy_truck", 1);
  var_0.maxinstancecount = 2;
  var_0.priority = 75;
  var_0.getspawnstructscallback = &hvi_patrol_intro;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("convoy_truck", "spawnCallback");
  var_0.clearancecheckradius = 185;
  var_0.clearancecheckheight = 138;
  var_0.clearancecheckminradius = 185;
}

function hvi_patrol_intro() {
  var_0 = scripts\engine\utility::getStructArray("convoytruck_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}

function hvtlist(var_0, var_1) {
  var_2 = hurtplayersinbunker(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var_2.ondeathrespawn = &hvt_visual_callout;
  }

  return var_2;
}

function hvt_visual_callout() {
  thread i_am_seeing_this_player();
}

function i_am_seeing_this_player() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421C("convoy_truck", var_1, var_2);
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58233.gsc
***********************************************/

function hvi_vehicle_rider_special_setup() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("convoy_truck", "spawnCallback", &hvtlist);
  var0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("convoy_truck", 1);
  var0.destroycallback = &hvi_patrol_exit;
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
  var0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e("convoy_truck", 1);
  var0.id = 26;
  var0.ref_12da2[0] = 0;
}

function hvt_delayed_cig() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("convoy_truck", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("convoy_truck", "initLate")]]();
    return;
  }
}

function hvt_can_lose_health() {
  var0 = getdvarfloat("scr_armored_truck_health_override", 8750);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416c("convoy_truck", var0, undefined, undefined, undefined, 30);
  var1 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("convoy_truck");
  var1.class = "heavy";
  var2 = scripts\cp_mp\vehicles\vehicle_damage::ref_1414d("convoy_truck", "heavy");
  var2.ref_12024 = &hvt_visual_leaving_callout;
  var2.ref_1202d = &hvt_waittill_pickup_players_gobackup;
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413d("convoy_truck");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("convoy_truck", 40);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14175("convoy_truck", &hvtboardingside);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("convoy_truck", &hvi_escort_exit);
}

function hvt_anim_and_close_doors() {
  var0 = _calloutmarkerping_predicted_log::ref_1410f("convoy_truck", 1);
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

function hvt_death_player_vo() {
  level._effect["convoy_truck_explode"] = loadfx("vfx/iw8_mp/vehicle/vfx_cargotr_mp_death_exp.vfx");
}

function hurtplayersinbunker(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  if(!isDefined(var0.modelname)) {
    var0.modelname = "veh_s4_mil_lnd_truck_opapa40_armored_wz";
  }

  var0.targetname = "convoy_truck";

  if(!isDefined(var0.vehicletype)) {
    var0.vehicletype = "mkilo_physics_mg_convoy";
  }

  var2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var0, var1);

  if(!isDefined(var2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var2, "convoy_truck", var0);
  _calloutmarkerping_predicted_timeout::ref_1412b(var2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var2, var0);
  var3 = &scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback;

  if(isDefined(var0.player_rig_create)) {
    var3 = var0.player_rig_create;
  }

  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var2, undefined, var3);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("convoy_truck", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("convoy_truck", "create")]](var2);
  }

  return var2;
}

function hvi_patrol_exit(var0, var1) {
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

  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread hvi_escort_intro();

  if(!istrue(level.suppressvehicleexplosion)) {
    var2 = self gettagorigin("tag_origin");
    var3 = scripts\engine\utility::ter_op(isDefined(var0.attacker) && isent(var0.attacker), var0.attacker, self);
    self radiusdamage(var2, 256, 140, 70, var3, "MOD_EXPLOSIVE");
    playFX(scripts\engine\utility::getfx("convoy_truck_explode"), var2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var2, "car_explode");
    earthquake(0.4, 800, var2, 0.7);
    playrumbleonposition("grenade_rumble", var2);
    physicsexplosionsphere(var2, 500, 200, 1);
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

function hvtboardingside(var0) {
  if(isDefined(var0.damage) && var0.damage > 0) {
    self notify("damage_taken", var0);
  }

  return true;
}

function hvi_escort_exit(var0) {
  thread hvi_patrol_exit(var0);
  return true;
}

function hvt_visual_leaving_callout(var0, var1) {
  self setscriptablepartstate("alarm", "engineFailure", 0);

  if(getdvarint("scr_armored_convoy_stop_truck_on_disabled", 0) == 1) {
    self notify("kill_mines");
    self vehicle_setspeed(0, 5, 5);
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14163(var0, var1);
}

function hvt_waittill_pickup_players_gobackup(var0, var1) {
  self setscriptablepartstate("alarm", "off", 0);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14169(var0, var1);
}

function hvt_key_dropped() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("convoy_truck", 1);
  var0.maxinstancecount = 2;
  var0.priority = 75;
  var0.getspawnstructscallback = &hvi_patrol_intro;
  var0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("convoy_truck", "spawnCallback");
  var0.clearancecheckradius = 185;
  var0.clearancecheckheight = 138;
  var0.clearancecheckminradius = 185;
}

function hvi_patrol_intro() {
  var0 = scripts\engine\utility::getStructArray("convoytruck_spawn", "targetname");

  if(var0.size > 0) {
    var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var0, 1);

    if(var0.size > 1) {
      var0 = scripts\engine\utility::array_randomize(var0);
    }
  }

  return var0;
}

function hvtlist(var0, var1) {
  var2 = hurtplayersinbunker(var0, var1);

  if(isDefined(var2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &hvt_visual_callout;
  }

  return var2;
}

function hvt_visual_callout() {
  thread i_am_seeing_this_player();
}

function i_am_seeing_this_player() {
  var0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var0, var1);
  var2 = spawnStruct();
  var3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421c("convoy_truck", var1, var2);
}
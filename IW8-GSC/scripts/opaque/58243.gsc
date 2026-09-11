/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58243.gsc
***********************************************/

function init() {
  thread suppressedlaser();
  thread table_getaddblueprintattachments();
}

function suppressedlaser() {
  _handlevehiclerepair::init();

  if(getDvar("scr_br_verse") == "ww2") {
    var_0 = [];
    GscBinSkip0(0x2e, "brloot_plunder_cash_rare_1", 1);
  }

  var_0 = [];
  GscBinSkip0(0x2e, "brloot_plunder_cash_rare_1", 1);
}

function table_getaddblueprintattachments() {
  waitframe();
  level.hurt_trigger_active = getdvarfloat("scr_armored_convoy_map_spawn_delay", 1);

  if(getdvarint("scr_city_killers_convoy_event_active", 0) == 1) {
    self waittill("br_vehiclesReset");
    wait level.hurt_trigger_active;
    hudplunderstart();
    hvt_key_picked_up();
    var_0 = spawnStruct();
    var_0.streakname = "convoy_truck";
    level.idflags_source_left_hand = var_0;
    level.hudextractnum = &hudextractnum;
    level thread scripts\mp\gametypes\br_heavy_weapon_drop::init();
    thread object_is_valid(level);
    return;
  }
}

function hvt_key_picked_up() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("convoy_truck", 1);
  var_0.frontextents = 165;
  var_0.backextents = 168;
  var_0.leftextents = 57;
  var_0.rightextents = 57;
  var_0.bottomextents = 35;
  var_0.distancetobottom = 50;
  var_0.loscheckoffset = (0, 0, 70);
}

function accessorylogicbyindex() {}

function object_is_valid(var_0) {
  level endon("game_ended");
  wait 1;
  level.hudglobalkillcountmax = spawnStruct();
  level.hudglobalkillcountmax.hudzombie = [];
  level.hudglobalkillcountmax.brvalidatekillcam = 0;
  level.hudglobalkillcountmax.i_see_player_drone_watcher = [];
  stoppingpower_onkill();
  forcefail();

  if(getdvarint("scr_armored_convoy_spawn_all_locations", 0) == 1) {
    obj_room_fire_09(var_0, "mines");
    obj_room_fire_09(var_0, "docks");
    obj_room_fire_09(var_0, "capital");
    obj_room_fire_09(var_0, "agcenter");
    obj_room_fire_09(var_0, "lagoon");
    obj_room_fire_09(var_0, "beachhead");
  } else if(getdvarint("scr_armored_convoy_spawn_week_2", 0) == 1) {
    obj_room_fire_09(var_0, "docks");
  } else {
    ref_13527(var_0);
  }

  foreach(var_2 in level.hudglobalkillcountmax.i_see_player_drone_watcher) {
    var_2.ref_13415 = 5;
    var_2.personnel_platform = 15;
    var_2.ref_136eb = var_2.ref_13415;
    var_3 = scripts\common\utility::playersincylinder(var_2.origin, 20000);

    foreach(var_5 in var_3) {
      var_5 thread scripts\mp\hud_message::showsplash("convoy_truck_spawn");
      var_5.shoulddonodedrop = 1;
    }
  }

  level.hudglobalkillcountmax.locindex = 20;
  level.hudglobalkillcountmax.getoldestdogtags = 0;
  level.hudglobalkillcountmax.ref_119e9 = 500;
}

function ref_13527(var_0) {
  var_1 = [];

  if(getdvarint("scr_armored_convoy_mines_route_active", 1) == 1) {
    GscBinSkip0(0x2e, var_1.size, "mines");
  }

  if(getdvarint("scr_armored_convoy_docks_route_active", 1) == 1) {
    GscBinSkip0(0x2e, var_1.size, "docks");
  }

  if(getdvarint("scr_armored_convoy_capital_route_active", 1) == 1) {
    GscBinSkip0(0x2e, var_1.size, "capital");
  }

  if(getdvarint("scr_armored_convoy_agcenter_route_active", 1) == 1) {
    GscBinSkip0(0x2e, var_1.size, "agcenter");
  }

  if(getdvarint("scr_armored_convoy_lagoon_route_active", 1) == 1) {
    GscBinSkip0(0x2e, var_1.size, "lagoon");
  }

  if(getdvarint("scr_armored_convoy_beachhead_route_active", 1) == 1) {
    GscBinSkip0(0x2e, var_1.size, "beachhead");
  }

  var_1 = scripts\engine\utility::array_randomize(var_1);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_2 > getdvarint("scr_armored_convoy_number_of_convoys_to_spawn", 3) - 1) {
      break;
    }

    obj_room_fire_09(var_0, var_1[var_2]);
  }
}

function obj_room_fire_09(var_0, var_1, var_2) {
  if(getdvarint("scr_armored_convoy_" + var_1 + "_route_active", 1) == 0) {
    return;
  }

  var_3 = 0;

  if(getdvarint("scr_test_convoy_randomize", 0)) {
    var_3 = randomint(level.hudglobalkillcountmax.paths[var_1].size);
  }

  var_4 = level.hudglobalkillcountmax.paths[var_1][var_3];
  var_5 = spawn_convoy_truck(var_4, var_2);
  var_5.vehiclename = "convoy_truck";
  var_5.name = "convoy_truck";
  var_5.ownerdamageenabled = 1;
  var_5.ref_13dd4 = 1;
  var_5 setCanDamage(1);
  var_5.godmode = 0;
  var_5.team = "neutral";
  var_5 setvehicleteam("neutral");
  var_6 = getdvarint("RRNTNNKNP", 1);
  var_5.health = 5000;
  var_5.maxhealth = 5000;

  if(var_6 > 2) {
    var_5.health *= 2;
    var_5.maxhealth *= 2;
  }

  hurt_enabled(var_5);
  var_5.initplunderpads = "unengaged";
  var_5.locale = var_1;
  var_5.inside_bush = var_3;
  var_5.is_enemy_of_type = 1;
  var_5.ref_12b1d = [];
  var_5.ref_13a89 = [];
  var_5 vehphys_enablecollisioncallback(1);
  var_5.ref_119fb = 3;
  var_5.little_bird_mg_onexitheavydamagestate = 1;
  var_5.clipsize = getdvarint("scr_armored_convoy_turret_clip_size", 80);
  var_7 = anglesToForward(var_5.angles) * 150 * -1;
  level.hudglobalkillcountmax.ref_13e81 = getdvarint("scr_armored_convoy_turret_accuracy", 65);
  var_8 = var_5 gettagorigin("TAG_TURRET_L");
  var_9 = var_5 gettagorigin("TAG_TURRET_R");
  var_10 = var_5 gettagorigin("TAG_TURRET_B");
  var_11 = var_5 gettagorigin("TAG_DROP_BACK_LEFT");
  var_12 = var_5 gettagorigin("TAG_DROP_BACK_RIGHT");
  var_13 = cos(37.5);
  var_14 = cos(60);
  var_5.waypoint_endzone_vfx = spawnturret("misc_turret", var_8, "convoy_truck_turret_mp");
  var_5.waypoint_endzone_vfx setModel("veh_s4_mil_lnd_truck_opapa40_armored_wz_turret");
  var_5.waypoint_endzone_vfx.owner = var_0.owner;
  var_5.waypoint_endzone_vfx setturretowner(var_0.owner);
  var_5.waypoint_endzone_vfx.team = var_5.team;
  var_5.waypoint_endzone_vfx maketurretinoperable();
  var_5.waypoint_endzone_vfx.streakinfo = var_0;
  var_5.waypoint_endzone_vfx.turreton = 1;
  var_5.waypoint_endzone_vfx.name = "left_turret";
  var_5.waypoint_endzone_vfx.attackingtarget = undefined;
  var_5.waypoint_endzone_vfx linkTo(var_5, "TAG_TURRET_L", (0, 0, 0), (0, 0, 0));
  var_5.waypoint_endzone_vfx.ref_11e1d = var_5;
  var_5.waypoint_endzone_vfx.ref_11a52 = [];
  var_5.waypoint_endzone_vfx setturretteam(var_5.team);
  var_5.waypoint_endzone_vfx setturretmodechangewait(0);
  var_5.waypoint_endzone_vfx setmode("manual");
  var_5.waypoint_endzone_vfx setotherent(var_0.owner);
  var_5.waypoint_endzone_vfx setdefaultdroppitch(30);
  var_5.waypoint_endzone_vfx.ref_11b52 = var_13;
  var_5.waypoint_endzone_vfx.ref_13a71 = 0;
  var_5.ref_12d3f = spawnturret("misc_turret", var_9, "convoy_truck_turret_mp");
  var_5.ref_12d3f setModel("veh_s4_mil_lnd_truck_opapa40_armored_wz_turret");
  var_5.ref_12d3f.owner = var_0.owner;
  var_5.ref_12d3f setturretowner(var_0.owner);
  var_5.ref_12d3f.team = var_5.team;
  var_5.ref_12d3f maketurretinoperable();
  var_5.ref_12d3f.streakinfo = var_0;
  var_5.ref_12d3f.turreton = 1;
  var_5.ref_12d3f.name = "right_turret";
  var_5.ref_12d3f.attackingtarget = undefined;
  var_5.ref_12d3f linkTo(var_5, "TAG_TURRET_R", (0, 0, 0), (0, 0, 0));
  var_5.ref_12d3f.ref_11e1d = var_5;
  var_5.ref_12d3f.ref_11a52 = [];
  var_5.ref_12d3f setturretteam(var_5.team);
  var_5.ref_12d3f setturretmodechangewait(0);
  var_5.ref_12d3f setmode("manual");
  var_5.ref_12d3f setotherent(var_0.owner);
  var_5.ref_12d3f setdefaultdroppitch(30);
  var_5.ref_12d3f.ref_11b52 = var_13;
  var_5.ref_12d3f.ref_13a71 = 0;
  var_15 = var_5.origin + var_7;
  var_16 = (var_15[0], var_15[1], var_5.origin[2] + 150);
  var_17 = vectorNormalize(var_16 - var_5.origin) * 150;
  var_18 = var_5.origin + var_17;
  var_5.rearturret = spawnturret("misc_turret", var_10, "convoy_truck_turret_mp");
  var_5.rearturret setModel("veh_s4_mil_lnd_truck_opapa40_armored_wz_back_turret");
  var_5.rearturret setturretowner(var_0.owner);
  var_5.rearturret.owner = var_0.owner;
  var_5.rearturret.team = var_5.team;
  var_5.rearturret maketurretinoperable();
  var_5.rearturret.streakinfo = var_0;
  var_5.rearturret.turreton = 1;
  var_5.rearturret.name = "rear_turret";
  var_5.rearturret.attackingtarget = undefined;
  var_5.rearturret linkTo(var_5, "TAG_TURRET_B", (0, 0, 0), (0, 0, 0));
  var_5.rearturret.ref_11e1d = var_5;
  var_5.rearturret.ref_11a52 = [];
  var_5.rearturret setturretteam(var_5.team);
  var_5.rearturret setturretmodechangewait(0);
  var_5.rearturret setmode("manual");
  var_5.rearturret setotherent(var_0.owner);
  var_5.rearturret setdefaultdroppitch(30);
  var_5.rearturret.ref_11b52 = var_14;
  var_5.rearturret.ref_13a71 = 0;
  var_5.intel_pieces = 5;
  var_5.waypoint_completed_vfx = var_11;
  var_5.ref_12d3e = var_12;
  var_5 vehicle_setspeed(50, 5, 5);
  var_5.killcament = spawn("script_model", var_5 gettagorigin("tag_origin"));
  var_5.killcament.origin += (0, 0, 300);
  var_5.killcament linkTo(var_5, "tag_origin", (-600, 0, 1000), (0, 0, 0));
  var_5.waypoint_endzone_vfx.killcament = var_5.killcament;
  var_5.ref_12d3f.killcament = var_5.killcament;
  var_5.rearturret.killcament = var_5.killcament;

  if(getdvarint("scr_armored_convoy_respawn_after_death", 0)) {
    thread ref_144b2(level);
  }

  thread ref_14237();
  thread ref_14483(var_5);
  thread is_stealth_sequence_activated();
  thread vehicle_damage_onenterstateheavy();
  thread ref_11c18();
  thread setup_backup_respawn_points_in_verdansk();
  thread ref_14479();
  return var_5;
}

function ref_135ee() {
  self.ref_12d3f.groundtargetent = spawn("script_origin", level.players[0].origin);
  self.ref_12d3f.groundtargetent dontinterpolate();
  self.waypoint_endzone_vfx.groundtargetent = spawn("script_origin", level.players[0].origin);
  self.waypoint_endzone_vfx.groundtargetent dontinterpolate();
  self.rearturret.groundtargetent = spawn("script_origin", level.players[0].origin);
  self.rearturret.groundtargetent dontinterpolate();
}

function ref_11c18() {
  self endon("death");
  jumpiftrue(isDefined(level.mines)) LOC_00000017;
  level.mines = [];

  for(;;) {
    foreach(var_1 in level.mines) {
      if(!isDefined(var_1)) {
        continue;
      }

      if(istrue(var_1.ref_11b0d)) {
        continue;
      }

      if(isDefined(var_1.weapon_name) && var_1.weapon_name == "claymore_mp") {
        if(distancesquared(self.origin, var_1.origin) < squared(192)) {
          if(vectordot(self.origin - var_1.origin, anglesToForward(var_1.angles)) > 0.86602) {
            var_1 thread scripts\mp\equipment\claymore::claymore_trigger(self);
          }
        }
      }
    }

    waitframe();
  }
}

function ref_144b2(var_0) {
  level endon("game_ended");
  var_1 = var_0.locale;
  var_0 waittill("death");

  if(isDefined(var_0.waypoint_endzone_vfx)) {
    var_0.waypoint_endzone_vfx delete();
  }

  if(isDefined(var_0.ref_12d3f)) {
    var_0.ref_12d3f delete();
  }

  if(isDefined(var_0.cannon)) {
    var_0.cannon delete();
  }

  if(isDefined(var_0.rearturret)) {
    var_0.rearturret delete();
  }

  if(isDefined(var_0.ref_1253b)) {
    var_0.ref_1253b delete();
  }

  if(isDefined(var_0.computerrebootused)) {
    var_0.computerrebootused delete();
  }

  scripts\engine\utility::array_removeundefined(level.hudglobalkillcountmax.i_see_player_drone_watcher);
  wait 10;
  var_2 = getdvarint("scr_armored_convoy_respawn_after_death", 0) == 2;
  var_3 = obj_room_fire_09(level.idflags_source_left_hand, var_1, var_2);
  var_3.ref_13415 = 5;
  var_3.personnel_platform = 15;
  var_3.ref_136eb = var_3.ref_13415;
  level.hudglobalkillcountmax.locindex = 20;
  level.hudglobalkillcountmax.getoldestdogtags = 0;
  level.hudglobalkillcountmax.ref_119e9 = 500;

  if(istrue(var_2) && isDefined(var_3.path) && isDefined(var_3.path.nodes) && var_3.path.nodes.size > 1) {
    thread br_armor_plate_amount_equipped_set();
    return;
  }
}

function br_armor_plate_amount_equipped_set() {
  level endon("game_ended");
  self endon("vehicleBeginPath");
  self endon("death");
  scripts\mp\gametypes\br_gametype_truckwar::stoppingpower_givehcrdata();
  scripts\mp\gametypes\br_gametype_truckwar::stoppingpower_loadoutchangeremovehcr();
  level thread scripts\mp\gametypes\br_gametype_truckwar::ref_13df8();
  level thread scripts\mp\gametypes\br_gametype_truckwar::ref_13de4(self, self.origin, self.angles, 1);

  if(isDefined(self.path)) {
    self.stop_pressure_sensor = 1;

    while(self.stop_pressure_sensor) {
      wait 0.1;
    }

    wait 3;
    thread ref_1422f(self.path);
    return;
  }
}

function hudextractnum(var_0, var_1) {
  if(level.hudglobalkillcountmax.i_see_player_drone_watcher.size <= 0) {
    return;
  }

  foreach(var_3 in level.hudglobalkillcountmax.i_see_player_drone_watcher) {
    if(!isDefined(var_3)) {
      continue;
    }

    var_4 = distance2d(var_3.origin, var_0);

    if(var_4 > var_1 && var_4 - var_1 > 4000) {
      var_3.ref_133da = 1;
      var_5 = play_ac130_approach_scene();
      var_6 = spawnStruct();
      var_6.attacker = var_5;
      var_6.ref_11e93 = 1;
      hudnumtoconsume(var_3, var_6);
    }
  }
}

function ref_144b1() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    if(validtousecosmetic()) {
      wait 10;

      if(validtousecosmetic()) {
        break;
      }
    }

    wait 5;
  }

  self.ref_133da = 1;
}

function validtousecosmetic() {
  var_0 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  var_1 = scripts\mp\gametypes\br_circle::getdangercircleradius();
  var_2 = self.origin - var_0;
  var_3 = distance2d(self.origin, var_0);
  return var_3 > var_1 && var_3 - var_1 > 4000;
}

function stoppingpower_onkill() {
  if(level.mapname == "mp_br_mechanics") {
    scripts\mp\gametypes\br_payload_path_mp_br_mechanics_2::toggle_farah_lights(2, "standard", 2);
  }

  if(level.mapname == "mp_wz_island") {
    _codephonescriptableused::toggle_farah_lights(0, "standard", 0);
    _closepurchasemenuwithresponse::toggle_farah_lights(0, "standard", 0);
    _cleanuptabletallows::toggle_farah_lights(0, "standard", 0);
    _calloutmarkerping_shouldremovecalloutifwholesquadinvehicle::toggle_farah_lights(0, "standard", 0);
    _codecomputerscriptableused::toggle_farah_lights(0, "standard", 0);
    _cancelputawayonuseend::toggle_farah_lights(0, "standard", 0);
  }

  syringe_finish_crouch();
}

function syringe_finish_crouch() {
  foreach(var_1 in level.hudglobalkillcountmax.paths) {
    foreach(var_3 in var_1) {
      var_3.points = [];

      foreach(var_5 in var_3.nodes) {
        var_3.points[var_3.points.size] = var_5.origin;
      }
    }
  }
}

function forcefail() {
  forced_kill_off("mines");
  forced_kill_off("docks");
  forced_kill_off("capital");
  forced_kill_off("agcenter");
  forced_kill_off("lagoon");
  forced_kill_off("beachhead");
}

function forced_kill_off(var_0) {
  if(!isDefined(level.hudglobalkillcountmax.paths[var_0])) {
    return;
  }

  foreach(var_2 in level.hudglobalkillcountmax.paths[var_0]) {
    for(var_3 = 0; var_3 < var_2.nodes.size; var_3++) {
      if(var_3 < var_2.nodes.size - 1) {
        var_2.times[var_3] = freight_lift_build(var_2.nodes[var_3].origin, var_2.nodes[var_3 + 1].origin);
        continue;
      }

      var_2.times[var_3] = freight_lift_build(var_2.nodes[var_3].origin, var_2.nodes[0].origin);
    }
  }
}

function spawn_convoy_truck(var_0, var_1) {
  var_2 = (0, 0, 0);
  var_3 = var_0;
  var_4 = undefined;
  var_5 = 0;

  if(isDefined(var_0.nodes) && isDefined(var_0.nodes[var_5]) && isDefined(var_0.nodes[var_5 + 1])) {
    var_3 = var_0.nodes[var_5];
    var_4 = var_0.nodes[var_5 + 1];

    if(var_3.origin == var_4.origin) {
      var_4 = var_0.nodes[var_5 + 2];
    }

    var_2 = vectortoangles(var_4.origin - var_3.origin);
  } else if(isDefined(var_0.target)) {
    var_4 = scripts\engine\utility::getStruct(var_0.target, "targetname");

    if(isDefined(var_4)) {
      var_2 = vectortoangles(var_4.origin - var_0.origin);
    } else if(isDefined(var_0.angles)) {
      var_2 = vectortoangles(var_4.origin - var_0.origin);
    } else {
      var_2 = (0, randomint(0, 360), 0);
    }
  }

  var_6 = spawnStruct();
  var_6.origin = var_3.origin;
  var_6.angles = var_2;
  var_6.spawntype = "GAME_MODE";
  var_6.spawnmethod = "place_at_position_unsafe";
  var_6.team = "neutral";
  var_6.player_rig_create = &ref_1423f;
  var_6.vehicletype = "mkilo_physics_mg_convoy";
  var_6.modelname = "veh_s4_mil_lnd_truck_opapa40_armored_wz";
  var_6.showheadicon = 1;
  var_7 = spawnStruct();
  var_8 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("convoy_truck", var_6, var_7);
  var_8 unmarkkeyframedmover(1);
  var_8 method_87c2(1);
  level.hudglobalkillcountmax.i_see_player_drone_watcher[level.hudglobalkillcountmax.i_see_player_drone_watcher.size] = var_8;
  var_8.intel_pieces = 5;

  if(isDefined(var_4)) {
    var_0.vehicle = var_8;
    var_8.path = var_0;

    if(!isDefined(var_0.trigger)) {
      var_0.trigger = spawn("trigger_radius", var_8.origin, 0, 250, 200);
    }

    if(!istrue(var_0.trigger.x1loadout)) {
      var_0.trigger enablelinkTo();
      var_0.trigger.x1loadout = 1;
    }

    var_0.trigger linkTo(var_8, "tag_origin", (0, 0, 0), (0, 0, 0));
    var_0.trigger.brkillstreakbeginusefunc = 1;

    if(isDefined(var_4) && !istrue(var_1)) {
      thread ref_1422f(var_8);
    }
  }

  var_8.ref_1253b = spawn("trigger_radius", var_8.origin, 0, 1000, 1000);
  var_8.ref_1253b enablelinkTo();
  var_8.ref_1253b.x1loadout = 1;
  var_8.ref_1253b linkTo(var_8, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_8.ref_1253b.ref_11e1d = var_8;
  scripts\mp\utility\trigger::makeenterexittrigger(var_8.ref_1253b, &nuke_vault_alarm, &onplayerconnectstream, undefined, undefined, &hudkothbesttime);
  var_8.computerrebootused = spawn("trigger_radius", var_8.origin, 0, 150, 150);
  var_8.computerrebootused enablelinkTo();
  var_8.computerrebootused.x1loadout = 1;
  var_8.computerrebootused linkTo(var_8, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_8.computerrebootused.ref_11e1d = var_8;
  scripts\mp\utility\trigger::makeenterexittrigger(var_8.computerrebootused, &confirmed_pilot, &connect_circlar_path, undefined, undefined, &connect_init);
  thread ref_144ca();
  return var_8;
}

function nuke_vault_alarm(var_0, var_1) {
  if(isPlayer(var_0)) {
    if(!isDefined(var_0.aq_playerremoved)) {
      var_0.aq_playerremoved = [];
    }

    if(!scripts\engine\utility::array_contains(var_0.aq_playerremoved, var_1.ref_11e1d)) {
      var_0.aq_playerremoved[var_0.aq_playerremoved.size] = var_1.ref_11e1d;
      var_0 thread scripts\mp\hud_message::showsplash("convoy_truck_spawn");
    }

    ref_12aff(var_1.ref_11e1d, var_0.team);
    return;
  }

  if(isvalidmissile(var_0)) {
    var_0.exploding = 1;
    return;
  }
}

function onplayerconnectstream(var_0, var_1) {}

function hudkothbesttime(var_0, var_1) {
  if(!isDefined(var_0)) {
    return true;
  }

  return false;
}

function confirmed_pilot(var_0, var_1) {
  var_0 dodamage(10000, self.origin);
}

function connect_circlar_path(var_0, var_1) {}

function connect_init(var_0, var_1) {
  if(var_0 == self) {
    return true;
  }

  if(isDefined(var_0.vehiclename) || isDefined(var_0.equipmentref) && var_0.equipmentref == "equip_tac_cover") {
    return false;
  }

  return true;
}

function ref_14479() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    var_0 = scripts\engine\trace::create_default_contents(1);
    var_1 = scripts\mp\utility\entity::getentitiesinradius(self.origin, 175, undefined, self, var_0);

    if(isDefined(var_1) && var_1.size > 0) {
      foreach(var_3 in var_1) {
        var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_3, 0);

        if(isDefined(var_3.vehiclename)) {
          if(isDefined(var_4) && var_4.size > 0) {
            var_3 dodamage(10000, self.origin, self, self);
          } else {
            var_5 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle(var_3.vehiclename);
            var_6 = var_5.destroycallback;
            var_3 thread[[var_6]](undefined, 1);
          }
        }

        if(isDefined(var_3.animname) && var_3.animname == "fulton") {
          var_3 thread _debug_rooftopobjstart::playerswithoutdismemberment(undefined);
        }
      }
    }

    wait 1;
  }
}

function setup_backup_respawn_points_in_verdansk() {
  level endon("game_ended");
  self endon("death");
  var_0 = self getentitynumber();
  var_1 = 150;
  var_2 = physics_createcontents(["physicscontents_item"]);
  var_3 = (var_1, var_1, 200);
  var_4 = [self, self.ref_12d3f, self.waypoint_endzone_vfx, self.rearturret];

  for(;;) {
    var_5 = self.origin;
    var_6 = var_5 - var_3;
    var_7 = var_5 + var_3;
    var_8 = physics_aabbbroadphasequery(var_6, var_7, var_2, var_4);

    for(var_9 = 0; var_9 < var_8.size; var_9++) {
      var_10 = var_8[var_9];

      if(istrue(var_10.ref_11b0d)) {
        continue;
      }

      if(isDefined(var_10.idflags_br_armor_hit) && isDefined(var_10.idflags_br_armor_hit.size)) {
        if(var_10.idflags_br_armor_hit.size > 0) {
          if(isDefined(var_10.idflags_br_armor_hit[var_0])) {
            continue;
          }
        }
      }

      if(isDefined(var_10.equipmentref)) {
        if(var_10.equipmentref == "equip_tac_cover") {
          if(!var_10.collision istouching(self)) {
            continue;
          }

          var_10 scripts\mp\equipment\tactical_cover::tac_cover_destroy(undefined, 0);
          var_10.ref_11b0d = 1;
          continue;
        }
      }

      if(isDefined(var_10.get_teaminquiry_alias)) {
        var_10 thread scripts\mp\equipment\binoculars::get_smoke_grenade_start_pos();
      }

      if(!var_10 istouching(self)) {
        continue;
      }

      if(isDefined(var_10.cratetype) && var_10.cratetype == "battle_royale_loadout") {
        hudkothtimer(var_10, self, var_5);
        continue;
      }

      if(scripts\mp\utility\entity::isturret(var_10)) {
        if(istrue(var_10.usedropspawn)) {
          continue;
        }

        var_10 notify("kill_turret", 1);
        var_10.ref_11b0d = 1;
        continue;
      }

      if(hudextractmax(var_10)) {
        if(isDefined(var_10.health) && var_10.health > 0) {
          var_10 dodamage(var_10.health + 100, self.origin);
          var_10.ref_11b0d = 1;
        }
      }
    }

    waitframe();
  }
}

function hudextractmax(var_0) {
  if(!isDefined(var_0.weapon_name)) {
    return false;
  }

  var_1 = 0;

  switch (var_0.weapon_name) {
    case "armor_box_mp":
    case "support_box_mp":
      var_1 = 1;
      break;
  }

  if(var_1) {
    return true;
  }

  return false;
}

function vehicle_collision_loadtablecell(var_0, var_1, var_2) {
  if(!isDefined(var_0.idflags_br_armor_hit)) {
    var_0.idflags_br_armor_hit = [];
  }

  var_3 = self getentitynumber();
  var_0.idflags_br_armor_hit[var_3] = var_1;
  wait var_2;

  if(isDefined(var_0) && isDefined(var_0.idflags_br_armor_hit)) {
    var_0.idflags_br_armor_hit[var_3] = undefined;
  }

  if(isDefined(var_0) && isDefined(var_0.idflags_br_armor_hit) && var_0.idflags_br_armor_hit.size == 0) {
    var_0.idflags_br_armor_hit = undefined;
    return;
  }
}

function hudkothtimer(var_0, var_1, var_2) {
  if(!istrue(var_0.spawn_juggernauts_fob)) {
    var_3 = var_1.velocity * 150;
    var_0 playSound("mp_care_package_high_impact");
    var_0 physicslaunchserver(var_2, var_3);
    var_0.spawn_juggernauts_fob = 1;
    thread vehicle_collision_loadtablecell(level, var_0, var_1);
    return;
  }

  var_0 scripts\cp_mp\killstreaks\airdrop::destroycrate();
  var_0.ref_11b0d = 1;
}

function ref_144ca() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("trigger", var_0);

    if(isDefined(var_0) && isPlayer(var_0)) {
      ref_13f03(self.ref_11e1d, var_0);
      break;
    }
  }
}

function ref_1423f(var_0, var_1) {}

function ref_1422f(var_0, var_1) {
  self notify("vehicleBeginPath");
  self endon("vehicleBeginPath");
  self endon("death");
  var_2 = 0;
  self.carriable_explode = 1;
  self.tutonplayerkilled = undefined;

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_0.initial_enemy_spawner = 0;
  var_0.ref_136fb = var_1;
  thread ref_1423a();
  var_3 = 1;
  self startpathnodes(var_0.points, var_0.times, 0, 0.5, 0.5, 0, 0, var_2, 0, 0, 1, 1);
}

function ref_14483(var_0) {
  self notify("kill_path_swap_watcher");
  level endon("game_ended");
  self endon("death");
  self endon("kill_path_swap_watcher");

  for(;;) {
    self waittill("swap_to_next_path");

    if(self.inside_bush >= level.hudglobalkillcountmax.paths[var_0].size - 1) {
      self.inside_bush = 0;
    } else {
      self.inside_bush += 1;
    }

    self startpathnodes(level.hudglobalkillcountmax.paths[var_0][self.inside_bush].points, level.hudglobalkillcountmax.paths[var_0][self.inside_bush].times, 0, 0.5, 0.5, 0, 0, 0, 0, 0, 1, 1);
  }
}

function freight_lift_build(var_0, var_1) {
  var_2 = 1.57828e-05;
  var_3 = 3600;
  var_4 = 1;
  var_5 = distance(var_0, var_1);
  var_6 = var_5 * var_2;
  var_7 = max(var_6 / 10 * var_3, var_4);
  return var_7;
}

function ref_1423a() {
  level endon("game_ended");
  self notify("vehicleDamageVehicles");
  self endon("vehicleDamageVehicles");
  self endon("death");
  self vehphys_enablecollisioncallback(1);

  for(;;) {
    self waittill("collision", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

    if(!isDefined(var_7)) {
      continue;
    }

    if(var_7 scripts\mp\gametypes\br_public::nuke_vault_suicidebombers()) {
      ref_1423e(var_7, self);
      continue;
    }

    if(isDefined(var_7.equipmentref) && var_7.equipmentref == "equip_tac_cover") {
      var_7 scripts\mp\equipment\tactical_cover::tac_cover_destroy(undefined, 1);
    }
  }
}

function ref_14237() {
  self notify("kill_path_end_watcher");
  level endon("game_ended");
  self endon("death");
  self endon("kill_path_end_watcher");

  for(;;) {
    self waittill("reached_end_node");
    self notify("swap_to_next_path");
  }
}

function ref_1423e(var_0) {
  self.ref_12282 = 1;
  self dodamage(self.health, var_0.origin, var_0, var_0);

  if(isDefined(self)) {
    self.ref_12282 = undefined;
    return;
  }
}

function ref_11f86(var_0) {
  self endon("death");

  for(;;) {
    scripts\mp\objidpoolmanager::update_objective_onentity(var_0, self);
    wait 0.1;
  }
}

function accessoryfem() {}

function preventleave(var_0) {
  var_1 = var_0;
  var_2 = [];
  GscBinSkip0(0x2e, var_2.size, var_0);
}

function accessreaderscriptableused() {}

function is_stealth_sequence_activated() {
  self endon("death");
  self waittill("enter_slowdown");
  ref_13077(1, 5, 5);
  wait 3;
  ref_13077(10, 5, 5);
  thread is_stealth_sequence_activated();
}

function ref_13077(var_0, var_1, var_2) {
  foreach(var_4 in level.hudglobalkillcountmax.i_see_player_drone_watcher) {
    if(isDefined(var_4)) {
      level.hudglobalkillcountmax.i_see_player_drone_watcher[0].intel_pieces = var_0;
      var_4 vehicle_setspeed(var_0, var_1, var_2);
    }
  }
}

function ref_13f03(var_0) {
  if(isDefined(var_0)) {
    ref_12aff(var_0.team);
  }

  if(!isDefined(self.waypoint_endzone_vfx.groundtargetent)) {
    ref_135ee();
  }

  if(isDefined(self.initplunderpads) && self.initplunderpads != "engaged") {
    thread disengage_watcher();
    self.initplunderpads = "engaged";
    self notify("engaged");
    self.intel_pieces = 15;
    thread ref_13c3f();
    thread ref_13c3f();
    thread ref_13c3f();
    var_0.intel_collect_vo_func = 0;
    var_0.armsrace_c4_planter_backlot = 0;
    thread ref_13a6a();
    thread ref_12c4e();
    thread playapache_dialogue(self.waypoint_endzone_vfx);
    thread playapache_dialogue(self.ref_12d3f);
    thread playapache_dialogue(self.rearturret);
    return;
  }
}

function disengage_watcher() {
  self endon("death");

  for(;;) {
    level.hudglobalkillcountmax.locindex -= 1;

    if(level.hudglobalkillcountmax.locindex <= 0) {
      var_0 = scripts\common\utility::playersincylinder(self.origin, 1000);

      if(isDefined(var_0) && isDefined(var_0[0])) {
        level.hudglobalkillcountmax.locindex = 20;
      } else {
        break;
      }
    }

    wait 1;
  }

  if(isDefined(self)) {
    self.initplunderpads = "unengaged";

    if(isDefined(self.waypoint_endzone_vfx)) {
      self.waypoint_endzone_vfx cleartargetentity();
      self.waypoint_endzone_vfx notify("kill_turret");
      self.waypoint_endzone_vfx.groundtargetent delete();
    }

    if(isDefined(self.ref_12d3f)) {
      self.ref_12d3f cleartargetentity();
      self.ref_12d3f notify("kill_turret");
      self.ref_12d3f.groundtargetent delete();
    }

    if(isDefined(self.rearturret)) {
      self.rearturret cleartargetentity();
      self.rearturret notify("kill_turret");
      self.rearturret.groundtargetent delete();
    }

    if(isDefined(self.cannon)) {
      self.cannon cleartargetentity();
      self.cannon notify("kill_turret");
    }

    thread ref_144ca();
  }

  self notify("kill_mines");
  self.ref_12b1d = [];
  self notify("engaged");
  ref_13077(5, 5, 5);
}

function ref_13a6a() {
  self endon("death");
  self endon("kill_turret");
  level endon("game_ended");

  for(;;) {
    foreach(var_1 in self.ref_12b1d) {
      if(isDefined(var_1) && isDefined(var_1.origin)) {
        var_1.intel_collect_vo_func = ref_12efc(var_1) + ref_12f0c(var_1);

        if(var_1.intel_collect_vo_func < 0) {
          var_1.intel_collect_vo_func = 0;
        }
      }
    }

    wait 0.1;
  }
}

function ref_12efc(var_0) {
  return (1 - distance2d(self.origin, var_0.origin) / 5000) * 1;
}

function ref_12f0c(var_0) {
  var_1 = var_0.armsrace_c4_planter_backlot;

  if(!isDefined(var_0.armsrace_c4_planter_backlot)) {
    return 0;
  }

  if(var_0.armsrace_c4_planter_backlot > 1000) {
    var_1 = 1000;
  }

  return var_1 / 1000 * 2;
}

function ref_12c4e() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    wait 5;

    foreach(var_1 in self.ref_12b1d) {
      if(isDefined(var_1) && isDefined(var_1.armsrace_c4_planter_backlot)) {
        var_1.armsrace_c4_planter_backlot -= 250;

        if(var_1.armsrace_c4_planter_backlot < 0) {
          var_1.armsrace_c4_planter_backlot = 0;
        }
      }
    }
  }
}

function playapache_dialogue(var_0) {
  self.ref_11e1d endon("death");
  self endon("kill_turret");
  waitframe();
  var_1 = 0;
  var_2 = 1;
  var_3 = var_0;
  self.attackingtarget = var_0;
  self.canseetarget = ref_140d7(self, self.groundtargetent, self.attackingtarget);

  for(;;) {
    if(isDefined(var_3) && self.canseetarget && !scripts\mp\utility\player::unset_relic_trex(var_3) && scripts\mp\utility\player::isreallyalive(var_3) && var_1 < self.ref_11e1d.clipsize && scripts\engine\utility::distance_2d_squared(self.origin, var_3.origin) < 25000000) {
      if(!isDefined(self.groundtargetent)) {
        return;
      }

      self.groundtargetent.origin = var_3.origin;
      var_4 = vectordot(anglestoright(self.ref_11e1d.angles), vectorNormalize(self.groundtargetent.origin - self.origin));
      var_5 = vectordot(-1 * anglesToForward(self.ref_11e1d.angles), vectorNormalize(self.groundtargetent.origin - self.origin));

      if(self.name == "right_turret") {
        if(var_4 >= self.ref_11b52) {
          fire_turret(var_3);
        }
      } else if(self.name == "left_turret") {
        if(var_4 <= -1 * self.ref_11b52) {
          fire_turret(var_3);
        }
      } else if(self.name == "rear_turret" && var_5 > self.ref_11b52) {
        fire_turret(var_3);
      }

      var_1++;
    } else if(var_1 < self.ref_11e1d.clipsize) {
      var_3 = selfrevivemonitorrevivebuttonPressed();
    } else {
      wait 4;
      var_3 = selfrevivemonitorrevivebuttonPressed();
      var_1 = 0;
    }

    wait 0.1;
  }
}

function fire_turret(var_0) {
  self settargetentity(self.groundtargetent);
  ref_13129(self, var_0.origin, level.hudglobalkillcountmax.ref_13e81);
  self shootturret("tag_flash");
}

function ref_14448(var_0) {
  self.ref_11e1d endon("death");
  self endon("kill_turret");
  self endon("lost_target");
  level endon("game_ended");

  if(!isDefined(var_0)) {
    return;
  }

  for(;;) {
    if(!ref_140d7(self, self.groundtargetent, var_0)) {
      wait 0.5;
      self.canseetarget = 0;
      self notify("lost_target");
    } else {
      self.canseetarget = 1;
    }

    wait 0.5;
  }
}

function ref_14475() {
  self endon("death");
  level endon("game_ended");
  var_0 = self.maxhealth * 0.6;

  for(;;) {
    if(self.health < var_0) {
      get_all_players_enemy_info_new();
      var_0 /= 2;
    }

    wait 0.1;
  }
}

function get_all_players_enemy_info_new() {
  level endon("game_ended");
  self endon("kill_turret");
  self endon("death");
  var_0 = 7;
  var_1 = semtex_killstuckplayer();

  for(;;) {
    if(isDefined(var_1)) {
      level thread scripts\mp\gametypes\br_quest_util::ref_140b1(self.origin + (0, 0, 75), "attack", 2);

      foreach(var_3 in self.ref_12b1d) {
        scripts\mp\gametypes\br_killstreaks::isbrsquadleader(var_1, "precision_airstrike");
      }

      wait 1;
      thread pavelow_boss_explodes(var_1);
      wait 60;
      break;
    }
  }
}

function accuracy_bonus_factor() {}

function selfrevivemonitorrevivebuttonPressed() {
  var_0 = 0;
  var_1 = undefined;

  if(self.ref_11a52.size > 0) {
    foreach(var_3 in self.ref_11a52) {
      if(isDefined(var_3)) {
        if(isDefined(var_3.intel_collect_vo_func) && var_3.intel_collect_vo_func > var_0) {
          var_1 = var_3;
        }
      }
    }

    thread ref_14448(var_1);
  }

  return var_1;
}

function semtex_killstuckplayer() {
  if(!isDefined(self) || self.ref_12b1d.size == 0) {
    return;
  }

  if(self.ref_12b1d.size == 1) {
    return self.ref_12b1d[0];
  }

  return self.ref_12b1d[randomintrange(0, self.ref_12b1d.size - 1)];
}

function selfrevivebuttonPressed() {
  if(!isDefined(self)) {
    return;
  }

  var_0 = self.ref_12b1d[0];

  for(var_1 = 1; var_1 < self.ref_12b1d.size; var_1++) {
    if(!isDefined(self.ref_12b1d[var_1])) {
      self.ref_12b1d = scripts\engine\utility::can_path_to_target(self.ref_12b1d, var_1);
      continue;
    }

    if(scripts\engine\utility::distance_2d_squared(self, self.ref_12b1d[var_1]) < scripts\engine\utility::distance_2d_squared(self.origin, var_0.origin)) {
      var_0 = self.ref_12b1d[var_1];
    }
  }

  return var_0;
}

function ref_12aff(var_0) {
  var_1 = scripts\mp\utility\teams::getteamdata(var_0, "players");

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(isDefined(var_3) && scripts\mp\utility\player::isreallyalive(var_3) && !scripts\engine\utility::array_contains(self.ref_12b1d, var_3)) {
        self.ref_12b1d[self.ref_12b1d.size] = var_3;
      }
    }

    return;
  }
}

function ref_13c3f() {
  level endon("game_ended");
  self.ref_11e1d endon("death");
  self endon("kill_turret");
  var_0 = 0;

  for(var_1 = 0; var_1 < self.ref_11e1d.ref_12b1d.size + 1; var_1++) {
    scripts\engine\utility::array_removeundefined(self.ref_11e1d.ref_12b1d);
    scripts\engine\utility::array_removeundefined(self.ref_11a52);

    if(var_1 >= self.ref_11e1d.ref_12b1d.size) {
      var_1 = 0;
    }

    if(self.ref_11e1d.ref_12b1d.size == 0) {
      break;
    }

    if(scripts\mp\utility\player::unset_relic_trex(self.ref_11e1d.ref_12b1d[var_1])) {
      ref_12bea(self.ref_11e1d, self.ref_11e1d.ref_12b1d[var_1]);
    } else if(ref_140d7(self, self.groundtargetent, self.ref_11e1d.ref_12b1d[var_1])) {
      if(!scripts\engine\utility::array_contains(self.ref_11a52, self.ref_11e1d.ref_12b1d[var_1])) {
        self.ref_11a52[self.ref_11a52.size] = self.ref_11e1d.ref_12b1d[var_1];
      }
    } else if(scripts\engine\utility::array_contains(self.ref_11a52, self.ref_11e1d.ref_12b1d[var_1])) {
      self.ref_11a52 = scripts\engine\utility::array_remove(self.ref_11a52, self.ref_11e1d.ref_12b1d[var_1]);

      if(self.ref_11a52.size <= 0) {
        self cleartargetentity();
      }
    }

    if(var_1 % 3 == 0) {
      wait 0.1;
    }
  }
}

function ref_12bea(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  var_1 = scripts\engine\utility::array_contains(self.ref_12d3f.ref_11a52, var_0);
  var_2 = scripts\engine\utility::array_contains(self.waypoint_endzone_vfx.ref_11a52, var_0);
  var_3 = scripts\engine\utility::array_contains(self.rearturret.ref_11a52, var_0);

  if(var_1) {
    self.ref_12d3f.ref_11a52 = scripts\engine\utility::array_remove(self.ref_12d3f.ref_11a52, var_0);
    return;
  }

  if(var_2) {
    self.waypoint_endzone_vfx.ref_11a52 = scripts\engine\utility::array_remove(self.waypoint_endzone_vfx.ref_11a52, var_0);
    return;
  }

  if(var_3) {
    self.rearturret.ref_11a52 = scripts\engine\utility::array_remove(self.rearturret.ref_11a52, var_0);
    return;
  }
}

function ref_13129(var_0, var_1, var_2) {
  var_3 = var_1;

  if(isDefined(var_2)) {
    var_4 = randomint(var_2);
    var_5 = randomint(360);
    var_6 = randomintrange(32, 48);
    var_7 = var_1[0] + var_4 * cos(var_5);
    var_8 = var_1[1] + var_4 * sin(var_5);
    var_9 = var_1[2] + var_6;
    var_3 = (var_7, var_8, var_9);
    var_0.groundtargetent.origin = var_3;
    return;
  }
}

function accessoryfemband() {}

function hurt_enabled() {
  scripts\mp\vehicles\damage::set_vehicle_hit_damage_data(self.vehiclename, 20);
  hudsbredeploy("iw8_la_gromeo_mp", 4, 20);
  hudsbredeploy("iw8_la_kgolf_mp", 4, 20);
  hudsbredeploy("iw8_la_t9standard_mp", 4, 20);
  hudsbredeploy("iw8_la_rpapa7_mp", 4, 20);
  hudsbredeploy("iw8_la_t9freefire_mp", 4, 20);
  hudsbredeploy("iw8_la_juliet_mp", 5, 20);
  hudsbredeploy("iw8_la_gromeoks_mp", 4, 20);
  hudsbredeploy("iw8_la_mike32_mp", 2.85714, 20);
  hudsbredeploy("iw8_la_t9launcher_mp", 2.85714, 20);
  hudsbredeploy("iw8_ar_mike4_mp", 2.85714, 20);
  hudsbredeploy("iw8_ar_akilo47_mp", 2.85714, 20);
  hudsbredeploy("s4_la_palpha_mp", 4, 20);
  hudsbredeploy("s4_la_m1bravo_mp", 4, 20);
  hudsbredeploy("s4_la_palpha42_mp", 4, 20);
  hudsbredeploy("c4_mp_p", 4, 20);
  hudsbredeploy("semtex_mp", 2.85714, 20);
  hudsbredeploy("frag_grenade_mp", 2.85714, 20);
  hudsbredeploy("pop_rocket_mp", 2.85714, 20);
  hudsbredeploy("molotov_mp", 1.81818, 20);
  hudsbredeploy("at_mine_ap_mp", 1.81818, 20);
  hudsbredeploy("at_mine_mp", 2.85714, 20);
  hudsbredeploy("thermite_mp", 1, 36);
  hudsbredeploy("thermite_av_mp", 1, 36);
  hudsbredeploy("thermite_bolt_mp", 1, 30);
  hudsbredeploy("thermite_xmike109_mp", 1, 52);
  hudsbredeploy("emp_grenade_mp", 2.85714, 20);
  hudsbredeploy("claymore_mp", 2.85714, 20);
  hudsbredeploy("semtex_bolt_mp", 2, 20);
  hudsbredeploy("semtex_xmike109_mp", 1.42857, 20);
  hudsbredeploy("semtex_aalpha12_mp", 1, 20);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_enableownerdamage(self);
  scripts\mp\vehicles\damage::get_vehicle_mod_damage_data(self.vehiclename, 1);
  scripts\mp\vehicles\damage::set_pre_mod_damage_callback(self.vehiclename, &hunters_killed_by_targets);
  scripts\mp\vehicles\damage::set_post_mod_damage_callback(self.vehiclename, &humanspawninair);
  scripts\mp\vehicles\damage::set_death_callback(self.vehiclename, &hudnumtoconsume);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(self);
}

function hudsbredeploy(var_0, var_1, var_2) {
  scripts\mp\vehicles\damage::set_weapon_hit_damage_data_for_vehicle(var_0, var_1, self.vehiclename);
  scripts\mp\vehicles\damage::set_vehicle_hit_damage_data_for_weapon(self.vehiclename, var_2, var_0);
}

function hunters_killed_by_targets(var_0) {
  var_1 = var_0.damage;
  var_2 = var_0.attacker;

  if(!isDefined(var_2) || !isPlayer(var_2)) {
    return false;
  }

  level.hudglobalkillcountmax.locindex = 20;

  if(isDefined(self.initplunderpads) && self.initplunderpads != "engaged" && !level.hudglobalkillcountmax.getoldestdogtags) {
    ref_13f03(var_2);
  }

  return true;
}

function humanspawninair(var_0) {
  if(!isDefined(self.attackers)) {
    self.attackers = [];
  }

  var_1 = hudkothbesttimelabel(var_0.attacker);

  if(!isDefined(var_1)) {
    var_2 = spawnStruct();
    var_2.player = var_0.attacker;
    var_2.objweapon = var_0.objweapon;
    var_2.ref_13bee = var_0.damage;
    self.attackers[self.attackers.size] = var_2;
  } else {
    var_1.ref_13bee += var_0.damage;
    var_1.objweapon = var_0.objweapon;
  }

  if(!isDefined(var_0.attacker.armsrace_c4_planter_backlot)) {
    var_0.attacker.armsrace_c4_planter_backlot = 0;
  }

  var_0.attacker.armsrace_c4_planter_backlot += var_0.damage;

  if(var_0.attacker.armsrace_c4_planter_backlot > 1000) {
    var_0.attacker.armsrace_c4_planter_backlot = 1000;
  }

  level.hudglobalkillcountmax.ref_119e9 -= var_0.damage;

  if(is_enemy_dangerous(var_0.objweapon.basename)) {
    self notify("enter_slowdown");
  }

  if(level.hudglobalkillcountmax.ref_119e9 <= 0) {
    self notify("loot_splat");
  }

  if(self.health < self.maxhealth * 0.8 && self.is_enemy_of_type == 1) {
    self.is_enemy_of_type = 2;
    thread watchcrategastimeout(6);
  }

  return true;
}

function hasseenendgamesplash() {
  self endon("death");
  self endon("game_ended");

  for(;;) {
    wait 1;
  }
}

function hudplunderstart() {
  var_0 = getDvar("scr_br_verse");
  level.ref_12815 = spawnStruct();
  level.ref_12815.ammo = ["brloot_ammo_919", "brloot_ammo_12g", "brloot_ammo_762", "brloot_ammo_50cal", "brloot_ammo_rocket"];
  level.ref_12815.armor = ["brloot_armor_plate"];
  level.ref_12815.weapon_xp_iw8_sh_mike26 = ["brloot_offhand_c4", "brloot_offhand_molotov"];

  if(isDefined(var_0) && var_0 != "ww2") {
    level.ref_12815.weapon_xp_iw8_sh_mike26[level.ref_12815.weapon_xp_iw8_sh_mike26.size] = "brloot_offhand_thermite";
    level.ref_12815.weapon_xp_iw8_sh_mike26[level.ref_12815.weapon_xp_iw8_sh_mike26.size] = "brloot_offhand_claymore";
    level.ref_12815.weapon_xp_iw8_sh_mike26[level.ref_12815.weapon_xp_iw8_sh_mike26.size] = "brloot_offhand_semtex";
  }

  level.ref_12815.ref_11cd2 = ["brloot_plunder_cash_uncommon_1"];
}

function hudglobalkillcount(var_0) {
  if(scripts\mp\gametypes\br_lootcache::get_bonus_targets(var_0)) {
    var_1 = level.br_pickups.delay_hide_player_clip[var_0];
    var_2 = scripts\mp\gametypes\br_pickups::test_ai_anim();
    var_3 = anglesToForward(self.angles) * 155 * -1;
    var_4 = self.origin + var_3;
    var_5 = (var_4[0], var_4[1], self.origin[2] + 100);
    var_6 = vectorNormalize(var_5 - self.origin + (0, 0, 100)) * 155;
    var_7 = self.origin + var_6;

    if(issubstr(var_0, "ammo")) {
      var_8 = scripts\mp\gametypes\br_lootcache::ref_11a41(var_0, var_2, var_7, self.angles, 0, 0);
      var_8.count = level.br_pickups.maxcounts[var_0];
      return;
    }

    var_9 = scripts\mp\gametypes\br_lootcache::ref_11a41(var_0, var_2, var_7, self.angles, 0, 0);

    if(isDefined(var_9)) {
      var_9.count = 1;
      return;
    }

    return;
  }
}

function hunterswonending() {
  var_0 = randomint(4);

  switch (var_0) {
    case 0:
      var_1 = level.ref_12815.ammo[randomint(level.ref_12815.ammo.size - 1)];
      hudglobalkillcount(var_1);
      break;
    case 1:
      var_1 = level.ref_12815.armor[0];
      hudglobalkillcount(var_1);
      break;
    case 2:
      var_1 = level.ref_12815.weapon_xp_iw8_sh_mike26[randomint(level.ref_12815.weapon_xp_iw8_sh_mike26.size - 1)];
      hudglobalkillcount(var_1);
      break;
    case 3:
      var_1 = level.ref_12815.ref_11cd2[0];
      hudglobalkillcount(var_1);
      break;
    default:
      break;
  }
}

function vehicle_damage_onenterstateheavy() {
  self endon("death");
  self waittill("loot_splat");
  hunterswonending();
  wait 0.1;
  hunterswonending();
  wait 0.1;
  hunterswonending();
  wait 0.1;
  hunterswonending();
  level.hudglobalkillcountmax.ref_119e9 = 500;
  thread vehicle_damage_onenterstateheavy();
}

function is_enemy_dangerous(var_0) {
  if(var_0 == "c4_mp_p" || var_0 == "at_mine_ap_mp" || var_0 == "at_mine_mp" || var_0 == "claymore_mp") {
    return true;
  }

  return false;
}

function hudnumtoconsume(var_0) {
  if(isDefined(self.waypoint_endzone_vfx)) {
    self.waypoint_endzone_vfx delete();
  }

  if(isDefined(self.ref_12d3f)) {
    self.ref_12d3f delete();
  }

  if(isDefined(self.cannon)) {
    self.cannon delete();
  }

  if(isDefined(self.rearturret)) {
    self.rearturret delete();
  }

  self.ref_1253b delete();
  self.computerrebootused delete();
  var_1 = undefined;
  var_2 = undefined;
  var_3 = var_0.attacker;
  var_4 = istrue(self.ref_133da);
  level.hudglobalkillcountmax.i_see_player_drone_watcher = scripts\engine\utility::array_remove(level.hudglobalkillcountmax.i_see_player_drone_watcher, self);
  self notify("death", var_0.attacker, var_0.meansofdeath, var_0.ref_14596, var_0.damagelocation);

  if(!var_4) {
    foreach(var_6 in self.attackers) {
      if(isDefined(var_6.player)) {
        if(isDefined(var_3) && var_3 == var_6.player) {
          var_1 = "convoy_killed";
        } else {
          var_1 = "convoy_assist";
        }

        var_2 = scripts\mp\rank::getscoreinfovalue(var_1);
        var_6.player thread scripts\mp\rank::giverankxp(var_1, var_2, var_6.objweapon);
        var_6.player thread scripts\mp\events::killeventtextpopup(var_1, 0);
        thread scripts\cp\vehicles\vehicle_compass_cp::vehiclekilled(self, var_0.inflictor, var_6.player, 0, var_6.objweapon);
      }
    }

    foreach(var_9 in self.ref_12b1d) {
      if(isDefined(var_9)) {
        var_9 thread scripts\mp\hud_message::showsplash("convoy_truck_finish");
      }
    }

    if(getdvarint("scr_armored_convoy_explicit_cash_drops", 0) == 1) {
      convoy_spawn_specific_cash_type("brloot_plunder_cash_uncommon_1", getdvarint("scr_armored_convoy_cash_uncommon_1_count", 0), self.origin);
      convoy_spawn_specific_cash_type("brloot_plunder_cash_uncommon_2", getdvarint("scr_armored_convoy_cash_uncommon_2_count", 0), self.origin);
      convoy_spawn_specific_cash_type("brloot_plunder_cash_uncommon_3", getdvarint("scr_armored_convoy_cash_uncommon_3_count", 0), self.origin);
      convoy_spawn_specific_cash_type("brloot_plunder_cash_rare_1", getdvarint("scr_armored_convoy_cash_rare_1_count", 0), self.origin);
      convoy_spawn_specific_cash_type("brloot_plunder_cash_rare_2", getdvarint("scr_armored_convoy_cash_rare_2_count", 0), self.origin);
      convoy_spawn_specific_cash_type("brloot_plunder_cash_epic_1", getdvarint("scr_armored_convoy_cash_epic_1_count", 0), self.origin);
      convoy_spawn_specific_cash_type("brloot_plunder_cash_epic_2", getdvarint("scr_armored_convoy_cash_epic_1_count", 0), self.origin);
    } else {
      level thread _handlevehiclerepair::ref_13673("ai_convoy_cash", self.origin, 10, 1);
    }

    level thread _handlevehiclerepair::ref_13673("ai_convoy_weapon", self.origin, 1, 0);
    level thread _handlevehiclerepair::ref_13673("ai_convoy_gear", self.origin, 2, 0);
    level thread _handlevehiclerepair::ref_13673("ai_convoy_supers", self.origin, 3, 0);
    level thread _handlevehiclerepair::ref_13673("ai_convoy_killstreaks", self.origin, 1, 0);
  }

  var_11 = getdvarint("scr_convoy_team_points", 0);

  if(isDefined(var_3) && var_11 > 0 && !isDefined(var_0.ref_11e93)) {
    level scripts\mp\gamescore::giveteamscoreforobjective(var_3.team, var_11, 0);
  }

  level.hudglobalkillcountmax.brvalidatekillcam++;
  var_12 = self gettagorigin("tag_origin");
  playFX(scripts\engine\utility::getfx("convoy_truck_explode"), var_12, anglesToForward(self.angles), anglestoup(self.angles));
  playsoundatpos(var_12, "car_explode");
  earthquake(0.4, 800, var_12, 0.7);
  playrumbleonposition("grenade_rumble", var_12);
  physicsexplosionsphere(var_12, 500, 200, 1);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
  scripts\engine\utility::array_removeundefined(level.hudglobalkillcountmax.i_see_player_drone_watcher);
  return false;
}

function convoy_spawn_specific_cash_type(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.item = var_0;
  var_3.ml_p3_to_safehouse_transition = var_1;
  var_3.heightoffset = 0;
  var_3.origin = var_2;

  for(var_4 = 0; var_4 < var_1; var_4++) {
    thread _handlevehiclerepair::ref_13672(var_3);
  }
}

function hudkothbesttimelabel(var_0) {
  var_1 = undefined;

  if(!isDefined(var_0)) {
    return var_1;
  }

  foreach(var_3 in self.attackers) {
    if(isDefined(var_3.player) && var_0 == var_3.player) {
      var_1 = var_3;
      break;
    }
  }

  return var_1;
}

function minigamelosersettings() {
  var_0 = self.origin;

  if(isDefined(var_0)) {
    var_1 = scripts\cp_mp\killstreaks\airdrop::dropcrate(undefined, undefined, "heavy_weapon_crate", self.origin, (0, randomfloat(360), 0), var_0);
    var_1.ref_13428 = spawn("script_model", var_0);
    var_1.ref_13428 setModel("ks_airdrop_crate_br");
    var_1.ref_13428 setscriptablepartstate("smoke_signal", "on", 0);

    if(isDefined(var_1)) {
      var_1 setscriptablepartstate("objective", "heavy_weapon_public");
    }

    var_2 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(var_1);
    var_2.ref_140a0 = 10;
    return;
  }
}

function ref_140d7(var_0, var_1, var_2) {
  self endon("explode");
  self endon("death");

  if(!isDefined(var_2) || scripts\mp\utility\player::unset_relic_trex(var_2)) {
    return 0;
  }

  var_3 = 1;
  var_4 = 1;
  var_5 = 0;
  var_6 = 1;
  var_7 = 0;
  var_8 = 1;
  var_9 = 0;
  var_10 = 1;
  var_11 = 0;
  var_12 = scripts\engine\trace::create_contents(var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  var_12 += init_cp_execution("physicscontents_solid");
  var_12 += init_cp_execution("physicscontents_water");
  var_13 = [var_0];

  if(isDefined(var_1)) {
    GscBinSkip0(0x2e, var_13.size, var_1);
  }

  var_15 = scripts\engine\trace::ray_trace_passed(var_0 gettagorigin("tag_barrel"), var_2.origin, var_13, var_12);
  return var_15;
}

function init_cp_execution(var_0) {
  var_1 = [var_0];
  return physics_createcontents(var_1);
}

function accessorybig() {}

function watchcheck() {}

function buttonmashcount(var_0) {
  var_0 scripts\mp\hud_message::showsplash("br_reveal_bombardment_launch_enemy");
}

function crates_delete_early() {
  var_0 = getmaxobjectivecount(self.origin[0], self.origin[1], 2000);
  level waittill("launch_bombardment");
  var_0 delete();
}

function create_animpack(var_0, var_1) {
  var_2 = magicgrenademanual("toma_proj_mp", var_1.sourcepos, var_1.initvelocity, 5);
  var_3 = var_2 scripts\mp\objidpoolmanager::createobjective("icon_minimap_cruisemissile", "axis", undefined, 1, 1);
  var_2 setentityowner(self);
  var_2 setotherent(self);
  var_2.owner = self;
  var_2 setscriptablepartstate("launch", "active", 0);
  var_2 setscriptablepartstate("trail", "active", 0);
  var_2.explodeent = spawn("script_model", var_2.origin);
  var_2.explodeent setModel("ks_toma_strike_missile_mp_x2");
  var_2.explodeent linkTo(var_2);
  var_2.explodeent dontinterpolate();
  var_2.explodeent setentityowner(self);
  var_4 = spawn("script_model", var_1.sourcepos);
  var_4 linkTo(var_2, "tag_origin", (10, 0, 10), (0, 0, 0));
  var_2.killcament = var_4;
  var_2.streakinfo = var_0;
  var_5 = randomint(360);
  var_2.angles = (90, var_5, 0);
  thread create_badplace_extraction(var_2, var_1.preexplpos);
  var_2 thread scripts\cp_mp\killstreaks\toma_strike::toma_strike_watch_stuck(vectortoangles(var_1.initvelocity), gettime(), var_1.initvelocity);
  var_2 waittill("death");
  objective_delete(var_3);
}

function cratephysicsoncallback(var_0, var_1) {
  var_2 = spawnStruct();
  var_3 = var_0 + (0, 0, 5000);
  var_4 = vectorNormalize(var_0 - (var_3[0], var_3[1], 0));
  var_5 = scripts\cp_mp\killstreaks\toma_strike::ref_13bd6(var_0, var_1, var_4);
  var_6 = (0, 0, -1 * getdvarint("NPOQPMP", 800));
  var_7 = (var_5.point - 0.5 * var_6 * squared(1) - var_3) / 1;
  var_8 = 1 * randomfloatrange(0.95, 1);
  var_9 = var_3 + var_7 * var_8 + 0.5 * var_6 * squared(var_8);
  var_2.sourcepos = var_3;
  var_2.num_of_frame_frozen = var_5.num_of_frame_frozen;
  var_2.num_of_subway_cars = var_5.num_of_subway_cars;
  var_2.goalpos = var_5.point;
  var_2.preexplpos = var_9;
  var_2.initvelocity = var_7;
  var_2.parachutecleanup = var_8;
  return var_2;
}

function create_badplace_extraction(var_0, var_1) {
  self endon("death");
  self endon("missile_dest_failed");
  self.killcament thread scripts\cp_mp\killstreaks\toma_strike::toma_strike_move_killcam(0.75, var_0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);
  self setmissileminimapvisible(0);
  thread scripts\cp_mp\killstreaks\toma_strike::toma_strike_missile_explode(var_0);
}

function accessoryface() {}

function entityhit() {
  var_0 = spawnStruct();
  var_0.streakname = "toma_strike";
  var_0.owner = self;
  var_0.score = 0;
  var_0.shots_fired = 0;
  var_0.hits = 0;
  var_0.damage = 0;
  var_0.kills = 0;
  var_0.ref_121a9 = "ks_toma_strike_missile_mp_x2";
  var_0.ref_121a8 = "ks_toma_strike_cluster_mp_x2";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "createCustomStreakData")) {
    var_0 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "createCustomStreakData")]](var_0, "toma_strike");
  }

  return var_0;
}

function ref_11d2c(var_0, var_1, var_2) {
  var_3 = play_ac130_approach_scene();
  ref_132b3(var_3, var_0, var_1, var_2);
}

function pavelow_boss_explodes(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");
  var_1 = spawnStruct();
  var_1.streakname = "precision_airstrike";
  var_1.owner = self;
  var_1.score = 0;
  var_1.shots_fired = 0;
  var_1.hits = 0;
  var_1.damage = 0;
  var_1.ref_133de = 1;
  var_1.kills = 0;
  var_1.ref_133ce = 1;
  var_1.setuptimelimit = 0;
  var_1.brmini_ontimelimit = 1;
  var_1.lifeid = 0;
  self.pers["team"] = "neutral";
  var_2 = spawnStruct();
  var_2.origin = var_0.origin;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "createCustomStreakData")) {
    var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "createCustomStreakData")]](var_1, "precision_airstrike");
  }

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_1)) {
      return 0;
    }
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_1)) {
      return 0;
    }
  }

  var_3 = level.scr_anim[var_1.streakname]["airstrike_flyby"];
  var_4 = getanimlength(var_3);
  var_5 = scripts\engine\utility::get_notetrack_time(var_3, "attack");
  var_6 = scripts\cp_mp\killstreaks\airstrike::branalytics_respawn(var_0.origin + anglesToForward(var_0.angles) * 1000, self);
  var_7 = self.angles[1];
  scripts\cp_mp\killstreaks\airstrike::finishairstrikeusage(var_0.origin, var_7, var_2, var_1, var_3, var_6);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_4);

  if(isDefined(level.killstreakfinishusefunc)) {
    level thread[[level.killstreakfinishusefunc]](var_1);
  }

  scripts\cp_mp\killstreaks\airstrike::branalytics_seteventdelayedstate(self, var_6);
}

function play_ac130_approach_scene() {
  var_0 = undefined;

  if(isDefined(level.idflags_br_armor_break)) {
    var_0 = level.idflags_br_armor_break;
  } else {
    var_1 = scripts\engine\utility::array_reverse(level.agentarray);

    foreach(var_3 in var_1) {
      if(!isDefined(var_3)) {
        continue;
      }

      if(isDefined(var_3.team) && var_3.team != "axis") {
        continue;
      }

      if(!isDefined(var_3.team) && isDefined(var_3.agentteam)) {
        continue;
      }

      var_0 = var_3;
      var_0.ref_1407d = 1;

      if(!isDefined(var_0.pers["nextKillstreakID"])) {
        var_0.pers["nextKillstreakID"] = 0;
      }

      break;
    }

    level.idflags_br_armor_break = var_0;
  }

  return var_0;
}

function ref_132b3(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = var_0 scripts\cp_mp\utility\killstreak_utility::createstreakinfo("toma_strike", var_0);
  }

  var_3.ref_11eae = 0;
  var_3.ref_11f47 = 1;
  var_3.vehicle_process_node_when_at_goal = 1;
  var_3.ref_121a9 = "ks_toma_strike_missile_mp_x2";
  var_3.ref_121a8 = "ks_toma_strike_cluster_mp_x2";
  var_0.origin = var_1;
  var_0.angles = vectortoangles(var_2 - var_1);
  var_3.ref_13a81 = var_2;
  var_0 thread scripts\cp_mp\killstreaks\toma_strike::starttomastrike(5, undefined, undefined, var_3);
}

function ref_13afb(var_0, var_1) {
  var_2 = scripts\mp\mp_agent::spawnnewagent("actor_enemy_lw_br", "team_two_hundred", var_0, var_1);
  var_2 setgoalvolume(level.hudglobalkillcountmax.getoriginidentifierstringnoz);
  bomber(var_2);
}

function ref_13068(var_0) {
  switch (var_0) {
    case "assault":
      bomb_hostage_play_anim("iw8_ar_akilo47");
      self.goalradius = randomintrange(100, 200);
      break;
    case "smg":
      bomb_hostage_play_anim("iw8_sm_mpapa5");
      self.goalradius = randomintrange(50, 100);
      break;
    case "lmg":
      break;
    case "shotgun":
      break;
    default:
      break;
  }
}

function ref_13521(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0; var_3++) {
    var_4 = var_1 + 300 * anglesToForward((0, (var_3 + 1) * 72, 0));
    var_5 = ref_13afb(var_4, (0, 0, 0));
    var_2 = var_5;
  }

  return var_2;
}

function bomb_hostage_play_anim(var_0, var_1) {
  self.weapon = scripts\mp\class::buildweapon(var_0, ["laserrange", "none", "none", "none", "none", "none"], "none", "none", var_1);
  self giveweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
}

function bomber() {
  self.recentkillcount = 0;
  self.recentdefendcount = 0;
  self.kills = 0;
  self.deaths = 0;
  self.pers["cur_kill_streak"] = 0;
  self.pers["cur_death_streak"] = 0;
  self.pers["cur_kill_streak_for_nuke"] = 0;
  self.tookweaponfrom = [];
  self.killedplayers = [];
  self.ref_1407d = 0;
}

function bonuskillscharge() {
  level.ai_event endon("soa_tower_stop_ai_event");
  level endon("game_ended");
  self endon("terminate_ai_threads");
  self endon("death");
  var_0 = gettime() / 1000;

  for(;;) {
    var_1 = self getgoalvolume();
    var_2 = distance2d(self.origin, var_1.origin);
    var_3 = var_2 < 600;
    self.ref_145d4 = var_3;

    if(var_3) {
      var_4 = gettime() / 1000;
      var_5 = var_4 - var_0;
      self.ref_13b6b = var_5;
      var_6 = level.ai_event.binoculars_targetisvalid;
      self.ref_13b6c = var_6 - var_5;

      if(var_4 - var_0 >= var_6) {
        var_7 = [];

        foreach(var_9 in level.ai_event.select_hostage_room_three_spawners) {
          if(var_9.players.size > 0 && var_9 != var_1) {
            var_7 = var_9;
          }
        }

        if(var_7.size > 0) {
          var_11 = scripts\engine\utility::random(var_7);
          self setgoalvolumeauto(var_11);
        }

        var_0 = gettime() / 1000;
      }
    } else {
      var_0 = gettime() / 1000;
    }

    wait 1;
  }
}

function ref_134e9() {}

function ref_134ea() {}

function activate_scavenger_bag() {}

function watchcrategastimeout(var_0) {
  self endon("death");
  self endon("checkpoint_encounter_started");
  self endon("kill_mines");
  var_1 = randomintrange(6, 10);
  wait var_1;
  var_2 = 1;

  for(var_3 = 0; var_3 < var_0; var_3++) {
    self.waypoint_completed_vfx = self gettagorigin("TAG_DROP_BACK_LEFT");
    self.ref_12d3e = self gettagorigin("TAG_DROP_BACK_RIGHT");
    var_4 = randomintrange(4, 6);

    if(var_2) {
      var_5 = magicgrenademanual("semtex_mp", self.waypoint_completed_vfx, (0, 0, -2), var_4, self);
    } else {
      var_5 = magicgrenademanual("semtex_mp", self.ref_12d3e, (0, 0, -2), var_4, self);
    }

    var_2 = !var_2;
    wait 0.5;
  }

  thread watchcrategastimeout(var_0);
}
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
    var0 = [];
    GscBinSkip0(0x2e, "brloot_plunder_cash_rare_1", 1);
  }

  var0 = [];
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
    var0 = spawnStruct();
    var0.streakname = "convoy_truck";
    level.idflags_source_left_hand = var0;
    level.hudextractnum = &hudextractnum;
    level thread scripts\mp\gametypes\br_heavy_weapon_drop::init();
    thread object_is_valid(level);
    return;
  }
}

function hvt_key_picked_up() {
  var0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("convoy_truck", 1);
  var0.frontextents = 165;
  var0.backextents = 168;
  var0.leftextents = 57;
  var0.rightextents = 57;
  var0.bottomextents = 35;
  var0.distancetobottom = 50;
  var0.loscheckoffset = (0, 0, 70);
}

function accessorylogicbyindex() {}

function object_is_valid(var0) {
  level endon("game_ended");
  wait 1;
  level.hudglobalkillcountmax = spawnStruct();
  level.hudglobalkillcountmax.hudzombie = [];
  level.hudglobalkillcountmax.brvalidatekillcam = 0;
  level.hudglobalkillcountmax.i_see_player_drone_watcher = [];
  stoppingpower_onkill();
  forcefail();

  if(getdvarint("scr_armored_convoy_spawn_all_locations", 0) == 1) {
    obj_room_fire_09(var0, "mines");
    obj_room_fire_09(var0, "docks");
    obj_room_fire_09(var0, "capital");
    obj_room_fire_09(var0, "agcenter");
    obj_room_fire_09(var0, "lagoon");
    obj_room_fire_09(var0, "beachhead");
  } else if(getdvarint("scr_armored_convoy_spawn_week_2", 0) == 1) {
    obj_room_fire_09(var0, "docks");
  } else {
    ref_13527(var0);
  }

  foreach(var2 in level.hudglobalkillcountmax.i_see_player_drone_watcher) {
    var2.ref_13415 = 5;
    var2.personnel_platform = 15;
    var2.ref_136eb = var2.ref_13415;
    var3 = scripts\common\utility::playersincylinder(var2.origin, 20000);

    foreach(var5 in var3) {
      var5 thread scripts\mp\hud_message::showsplash("convoy_truck_spawn");
      var5.shoulddonodedrop = 1;
    }
  }

  level.hudglobalkillcountmax.locindex = 20;
  level.hudglobalkillcountmax.getoldestdogtags = 0;
  level.hudglobalkillcountmax.ref_119e9 = 500;
}

function ref_13527(var0) {
  var1 = [];

  if(getdvarint("scr_armored_convoy_mines_route_active", 1) == 1) {
    GscBinSkip0(0x2e, var1.size, "mines");
  }

  if(getdvarint("scr_armored_convoy_docks_route_active", 1) == 1) {
    GscBinSkip0(0x2e, var1.size, "docks");
  }

  if(getdvarint("scr_armored_convoy_capital_route_active", 1) == 1) {
    GscBinSkip0(0x2e, var1.size, "capital");
  }

  if(getdvarint("scr_armored_convoy_agcenter_route_active", 1) == 1) {
    GscBinSkip0(0x2e, var1.size, "agcenter");
  }

  if(getdvarint("scr_armored_convoy_lagoon_route_active", 1) == 1) {
    GscBinSkip0(0x2e, var1.size, "lagoon");
  }

  if(getdvarint("scr_armored_convoy_beachhead_route_active", 1) == 1) {
    GscBinSkip0(0x2e, var1.size, "beachhead");
  }

  var1 = scripts\engine\utility::array_randomize(var1);

  for(var2 = 0; var2 < var1.size; var2++) {
    if(var2 > getdvarint("scr_armored_convoy_number_of_convoys_to_spawn", 3) - 1) {
      break;
    }

    obj_room_fire_09(var0, var1[var2]);
  }
}

function obj_room_fire_09(var0, var1, var2) {
  if(getdvarint("scr_armored_convoy_" + var1 + "_route_active", 1) == 0) {
    return;
  }

  var3 = 0;

  if(getdvarint("scr_test_convoy_randomize", 0)) {
    var3 = randomint(level.hudglobalkillcountmax.paths[var1].size);
  }

  var4 = level.hudglobalkillcountmax.paths[var1][var3];
  var5 = spawn_convoy_truck(var4, var2);
  var5.vehiclename = "convoy_truck";
  var5.name = "convoy_truck";
  var5.ownerdamageenabled = 1;
  var5.ref_13dd4 = 1;
  var5 setCanDamage(1);
  var5.godmode = 0;
  var5.team = "neutral";
  var5 setvehicleteam("neutral");
  var6 = getdvarint("RRNTNNKNP", 1);
  var5.health = 5000;
  var5.maxhealth = 5000;

  if(var6 > 2) {
    var5.health *= 2;
    var5.maxhealth *= 2;
  }

  hurt_enabled(var5);
  var5.initplunderpads = "unengaged";
  var5.locale = var1;
  var5.inside_bush = var3;
  var5.is_enemy_of_type = 1;
  var5.ref_12b1d = [];
  var5.ref_13a89 = [];
  var5 vehphys_enablecollisioncallback(1);
  var5.ref_119fb = 3;
  var5.little_bird_mg_onexitheavydamagestate = 1;
  var5.clipsize = getdvarint("scr_armored_convoy_turret_clip_size", 80);
  var7 = anglesToForward(var5.angles) * 150 * -1;
  level.hudglobalkillcountmax.ref_13e81 = getdvarint("scr_armored_convoy_turret_accuracy", 65);
  var8 = var5 gettagorigin("TAG_TURRET_L");
  var9 = var5 gettagorigin("TAG_TURRET_R");
  var10 = var5 gettagorigin("TAG_TURRET_B");
  var11 = var5 gettagorigin("TAG_DROP_BACK_LEFT");
  var12 = var5 gettagorigin("TAG_DROP_BACK_RIGHT");
  var13 = cos(37.5);
  var14 = cos(60);
  var5.waypoint_endzone_vfx = spawnturret("misc_turret", var8, "convoy_truck_turret_mp");
  var5.waypoint_endzone_vfx setModel("veh_s4_mil_lnd_truck_opapa40_armored_wz_turret");
  var5.waypoint_endzone_vfx.owner = var0.owner;
  var5.waypoint_endzone_vfx setturretowner(var0.owner);
  var5.waypoint_endzone_vfx.team = var5.team;
  var5.waypoint_endzone_vfx maketurretinoperable();
  var5.waypoint_endzone_vfx.streakinfo = var0;
  var5.waypoint_endzone_vfx.turreton = 1;
  var5.waypoint_endzone_vfx.name = "left_turret";
  var5.waypoint_endzone_vfx.attackingtarget = undefined;
  var5.waypoint_endzone_vfx linkTo(var5, "TAG_TURRET_L", (0, 0, 0), (0, 0, 0));
  var5.waypoint_endzone_vfx.ref_11e1d = var5;
  var5.waypoint_endzone_vfx.ref_11a52 = [];
  var5.waypoint_endzone_vfx setturretteam(var5.team);
  var5.waypoint_endzone_vfx setturretmodechangewait(0);
  var5.waypoint_endzone_vfx setmode("manual");
  var5.waypoint_endzone_vfx setotherent(var0.owner);
  var5.waypoint_endzone_vfx setdefaultdroppitch(30);
  var5.waypoint_endzone_vfx.ref_11b52 = var13;
  var5.waypoint_endzone_vfx.ref_13a71 = 0;
  var5.ref_12d3f = spawnturret("misc_turret", var9, "convoy_truck_turret_mp");
  var5.ref_12d3f setModel("veh_s4_mil_lnd_truck_opapa40_armored_wz_turret");
  var5.ref_12d3f.owner = var0.owner;
  var5.ref_12d3f setturretowner(var0.owner);
  var5.ref_12d3f.team = var5.team;
  var5.ref_12d3f maketurretinoperable();
  var5.ref_12d3f.streakinfo = var0;
  var5.ref_12d3f.turreton = 1;
  var5.ref_12d3f.name = "right_turret";
  var5.ref_12d3f.attackingtarget = undefined;
  var5.ref_12d3f linkTo(var5, "TAG_TURRET_R", (0, 0, 0), (0, 0, 0));
  var5.ref_12d3f.ref_11e1d = var5;
  var5.ref_12d3f.ref_11a52 = [];
  var5.ref_12d3f setturretteam(var5.team);
  var5.ref_12d3f setturretmodechangewait(0);
  var5.ref_12d3f setmode("manual");
  var5.ref_12d3f setotherent(var0.owner);
  var5.ref_12d3f setdefaultdroppitch(30);
  var5.ref_12d3f.ref_11b52 = var13;
  var5.ref_12d3f.ref_13a71 = 0;
  var15 = var5.origin + var7;
  var16 = (var15[0], var15[1], var5.origin[2] + 150);
  var17 = vectorNormalize(var16 - var5.origin) * 150;
  var18 = var5.origin + var17;
  var5.rearturret = spawnturret("misc_turret", var10, "convoy_truck_turret_mp");
  var5.rearturret setModel("veh_s4_mil_lnd_truck_opapa40_armored_wz_back_turret");
  var5.rearturret setturretowner(var0.owner);
  var5.rearturret.owner = var0.owner;
  var5.rearturret.team = var5.team;
  var5.rearturret maketurretinoperable();
  var5.rearturret.streakinfo = var0;
  var5.rearturret.turreton = 1;
  var5.rearturret.name = "rear_turret";
  var5.rearturret.attackingtarget = undefined;
  var5.rearturret linkTo(var5, "TAG_TURRET_B", (0, 0, 0), (0, 0, 0));
  var5.rearturret.ref_11e1d = var5;
  var5.rearturret.ref_11a52 = [];
  var5.rearturret setturretteam(var5.team);
  var5.rearturret setturretmodechangewait(0);
  var5.rearturret setmode("manual");
  var5.rearturret setotherent(var0.owner);
  var5.rearturret setdefaultdroppitch(30);
  var5.rearturret.ref_11b52 = var14;
  var5.rearturret.ref_13a71 = 0;
  var5.intel_pieces = 5;
  var5.waypoint_completed_vfx = var11;
  var5.ref_12d3e = var12;
  var5 vehicle_setspeed(50, 5, 5);
  var5.killcament = spawn("script_model", var5 gettagorigin("tag_origin"));
  var5.killcament.origin += (0, 0, 300);
  var5.killcament linkTo(var5, "tag_origin", (-600, 0, 1000), (0, 0, 0));
  var5.waypoint_endzone_vfx.killcament = var5.killcament;
  var5.ref_12d3f.killcament = var5.killcament;
  var5.rearturret.killcament = var5.killcament;

  if(getdvarint("scr_armored_convoy_respawn_after_death", 0)) {
    thread ref_144b2(level);
  }

  thread ref_14237();
  thread ref_14483(var5);
  thread is_stealth_sequence_activated();
  thread vehicle_damage_onenterstateheavy();
  thread ref_11c18();
  thread setup_backup_respawn_points_in_verdansk();
  thread ref_14479();
  return var5;
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
    foreach(var1 in level.mines) {
      if(!isDefined(var1)) {
        continue;
      }

      if(istrue(var1.ref_11b0d)) {
        continue;
      }

      if(isDefined(var1.weapon_name) && var1.weapon_name == "claymore_mp") {
        if(distancesquared(self.origin, var1.origin) < squared(192)) {
          if(vectordot(self.origin - var1.origin, anglesToForward(var1.angles)) > 0.86602) {
            var1 thread scripts\mp\equipment\claymore::claymore_trigger(self);
          }
        }
      }
    }

    waitframe();
  }
}

function ref_144b2(var0) {
  level endon("game_ended");
  var1 = var0.locale;
  var0 waittill("death");

  if(isDefined(var0.waypoint_endzone_vfx)) {
    var0.waypoint_endzone_vfx delete();
  }

  if(isDefined(var0.ref_12d3f)) {
    var0.ref_12d3f delete();
  }

  if(isDefined(var0.cannon)) {
    var0.cannon delete();
  }

  if(isDefined(var0.rearturret)) {
    var0.rearturret delete();
  }

  if(isDefined(var0.ref_1253b)) {
    var0.ref_1253b delete();
  }

  if(isDefined(var0.computerrebootused)) {
    var0.computerrebootused delete();
  }

  scripts\engine\utility::array_removeundefined(level.hudglobalkillcountmax.i_see_player_drone_watcher);
  wait 10;
  var2 = getdvarint("scr_armored_convoy_respawn_after_death", 0) == 2;
  var3 = obj_room_fire_09(level.idflags_source_left_hand, var1, var2);
  var3.ref_13415 = 5;
  var3.personnel_platform = 15;
  var3.ref_136eb = var3.ref_13415;
  level.hudglobalkillcountmax.locindex = 20;
  level.hudglobalkillcountmax.getoldestdogtags = 0;
  level.hudglobalkillcountmax.ref_119e9 = 500;

  if(istrue(var2) && isDefined(var3.path) && isDefined(var3.path.nodes) && var3.path.nodes.size > 1) {
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

function hudextractnum(var0, var1) {
  if(level.hudglobalkillcountmax.i_see_player_drone_watcher.size <= 0) {
    return;
  }

  foreach(var3 in level.hudglobalkillcountmax.i_see_player_drone_watcher) {
    if(!isDefined(var3)) {
      continue;
    }

    var4 = distance2d(var3.origin, var0);

    if(var4 > var1 && var4 - var1 > 4000) {
      var3.ref_133da = 1;
      var5 = play_ac130_approach_scene();
      var6 = spawnStruct();
      var6.attacker = var5;
      var6.ref_11e93 = 1;
      hudnumtoconsume(var3, var6);
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
  var0 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  var1 = scripts\mp\gametypes\br_circle::getdangercircleradius();
  var2 = self.origin - var0;
  var3 = distance2d(self.origin, var0);
  return var3 > var1 && var3 - var1 > 4000;
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
  foreach(var1 in level.hudglobalkillcountmax.paths) {
    foreach(var3 in var1) {
      var3.points = [];

      foreach(var5 in var3.nodes) {
        var3.points[var3.points.size] = var5.origin;
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

function forced_kill_off(var0) {
  if(!isDefined(level.hudglobalkillcountmax.paths[var0])) {
    return;
  }

  foreach(var2 in level.hudglobalkillcountmax.paths[var0]) {
    for(var3 = 0; var3 < var2.nodes.size; var3++) {
      if(var3 < var2.nodes.size - 1) {
        var2.times[var3] = freight_lift_build(var2.nodes[var3].origin, var2.nodes[var3 + 1].origin);
        continue;
      }

      var2.times[var3] = freight_lift_build(var2.nodes[var3].origin, var2.nodes[0].origin);
    }
  }
}

function spawn_convoy_truck(var0, var1) {
  var2 = (0, 0, 0);
  var3 = var0;
  var4 = undefined;
  var5 = 0;

  if(isDefined(var0.nodes) && isDefined(var0.nodes[var5]) && isDefined(var0.nodes[var5 + 1])) {
    var3 = var0.nodes[var5];
    var4 = var0.nodes[var5 + 1];

    if(var3.origin == var4.origin) {
      var4 = var0.nodes[var5 + 2];
    }

    var2 = vectortoangles(var4.origin - var3.origin);
  } else if(isDefined(var0.target)) {
    var4 = scripts\engine\utility::getStruct(var0.target, "targetname");

    if(isDefined(var4)) {
      var2 = vectortoangles(var4.origin - var0.origin);
    } else if(isDefined(var0.angles)) {
      var2 = vectortoangles(var4.origin - var0.origin);
    } else {
      var2 = (0, randomint(0, 360), 0);
    }
  }

  var6 = spawnStruct();
  var6.origin = var3.origin;
  var6.angles = var2;
  var6.spawntype = "GAME_MODE";
  var6.spawnmethod = "place_at_position_unsafe";
  var6.team = "neutral";
  var6.player_rig_create = &ref_1423f;
  var6.vehicletype = "mkilo_physics_mg_convoy";
  var6.modelname = "veh_s4_mil_lnd_truck_opapa40_armored_wz";
  var6.showheadicon = 1;
  var7 = spawnStruct();
  var8 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("convoy_truck", var6, var7);
  var8 unmarkkeyframedmover(1);
  var8 method_87c2(1);
  level.hudglobalkillcountmax.i_see_player_drone_watcher[level.hudglobalkillcountmax.i_see_player_drone_watcher.size] = var8;
  var8.intel_pieces = 5;

  if(isDefined(var4)) {
    var0.vehicle = var8;
    var8.path = var0;

    if(!isDefined(var0.trigger)) {
      var0.trigger = spawn("trigger_radius", var8.origin, 0, 250, 200);
    }

    if(!istrue(var0.trigger.x1loadout)) {
      var0.trigger enablelinkTo();
      var0.trigger.x1loadout = 1;
    }

    var0.trigger linkTo(var8, "tag_origin", (0, 0, 0), (0, 0, 0));
    var0.trigger.brkillstreakbeginusefunc = 1;

    if(isDefined(var4) && !istrue(var1)) {
      thread ref_1422f(var8);
    }
  }

  var8.ref_1253b = spawn("trigger_radius", var8.origin, 0, 1000, 1000);
  var8.ref_1253b enablelinkTo();
  var8.ref_1253b.x1loadout = 1;
  var8.ref_1253b linkTo(var8, "tag_origin", (0, 0, 0), (0, 0, 0));
  var8.ref_1253b.ref_11e1d = var8;
  scripts\mp\utility\trigger::makeenterexittrigger(var8.ref_1253b, &nuke_vault_alarm, &onplayerconnectstream, undefined, undefined, &hudkothbesttime);
  var8.computerrebootused = spawn("trigger_radius", var8.origin, 0, 150, 150);
  var8.computerrebootused enablelinkTo();
  var8.computerrebootused.x1loadout = 1;
  var8.computerrebootused linkTo(var8, "tag_origin", (0, 0, 0), (0, 0, 0));
  var8.computerrebootused.ref_11e1d = var8;
  scripts\mp\utility\trigger::makeenterexittrigger(var8.computerrebootused, &confirmed_pilot, &connect_circlar_path, undefined, undefined, &connect_init);
  thread ref_144ca();
  return var8;
}

function nuke_vault_alarm(var0, var1) {
  if(isPlayer(var0)) {
    if(!isDefined(var0.aq_playerremoved)) {
      var0.aq_playerremoved = [];
    }

    if(!scripts\engine\utility::array_contains(var0.aq_playerremoved, var1.ref_11e1d)) {
      var0.aq_playerremoved[var0.aq_playerremoved.size] = var1.ref_11e1d;
      var0 thread scripts\mp\hud_message::showsplash("convoy_truck_spawn");
    }

    ref_12aff(var1.ref_11e1d, var0.team);
    return;
  }

  if(isvalidmissile(var0)) {
    var0.exploding = 1;
    return;
  }
}

function onplayerconnectstream(var0, var1) {}

function hudkothbesttime(var0, var1) {
  if(!isDefined(var0)) {
    return true;
  }

  return false;
}

function confirmed_pilot(var0, var1) {
  var0 dodamage(10000, self.origin);
}

function connect_circlar_path(var0, var1) {}

function connect_init(var0, var1) {
  if(var0 == self) {
    return true;
  }

  if(isDefined(var0.vehiclename) || isDefined(var0.equipmentref) && var0.equipmentref == "equip_tac_cover") {
    return false;
  }

  return true;
}

function ref_14479() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    var0 = scripts\engine\trace::create_default_contents(1);
    var1 = scripts\mp\utility\entity::getentitiesinradius(self.origin, 175, undefined, self, var0);

    if(isDefined(var1) && var1.size > 0) {
      foreach(var3 in var1) {
        var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var3, 0);

        if(isDefined(var3.vehiclename)) {
          if(isDefined(var4) && var4.size > 0) {
            var3 dodamage(10000, self.origin, self, self);
          } else {
            var5 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle(var3.vehiclename);
            var6 = var5.destroycallback;
            var3 thread[[var6]](undefined, 1);
          }
        }

        if(isDefined(var3.animname) && var3.animname == "fulton") {
          var3 thread _debug_rooftopobjstart::playerswithoutdismemberment(undefined);
        }
      }
    }

    wait 1;
  }
}

function setup_backup_respawn_points_in_verdansk() {
  level endon("game_ended");
  self endon("death");
  var0 = self getentitynumber();
  var1 = 150;
  var2 = physics_createcontents(["physicscontents_item"]);
  var3 = (var1, var1, 200);
  var4 = [self, self.ref_12d3f, self.waypoint_endzone_vfx, self.rearturret];

  for(;;) {
    var5 = self.origin;
    var6 = var5 - var3;
    var7 = var5 + var3;
    var8 = physics_aabbbroadphasequery(var6, var7, var2, var4);

    for(var9 = 0; var9 < var8.size; var9++) {
      var10 = var8[var9];

      if(istrue(var10.ref_11b0d)) {
        continue;
      }

      if(isDefined(var10.idflags_br_armor_hit) && isDefined(var10.idflags_br_armor_hit.size)) {
        if(var10.idflags_br_armor_hit.size > 0) {
          if(isDefined(var10.idflags_br_armor_hit[var0])) {
            continue;
          }
        }
      }

      if(isDefined(var10.equipmentref)) {
        if(var10.equipmentref == "equip_tac_cover") {
          if(!var10.collision istouching(self)) {
            continue;
          }

          var10 scripts\mp\equipment\tactical_cover::tac_cover_destroy(undefined, 0);
          var10.ref_11b0d = 1;
          continue;
        }
      }

      if(isDefined(var10.get_teaminquiry_alias)) {
        var10 thread scripts\mp\equipment\binoculars::get_smoke_grenade_start_pos();
      }

      if(!var10 istouching(self)) {
        continue;
      }

      if(isDefined(var10.cratetype) && var10.cratetype == "battle_royale_loadout") {
        hudkothtimer(var10, self, var5);
        continue;
      }

      if(scripts\mp\utility\entity::isturret(var10)) {
        if(istrue(var10.usedropspawn)) {
          continue;
        }

        var10 notify("kill_turret", 1);
        var10.ref_11b0d = 1;
        continue;
      }

      if(hudextractmax(var10)) {
        if(isDefined(var10.health) && var10.health > 0) {
          var10 dodamage(var10.health + 100, self.origin);
          var10.ref_11b0d = 1;
        }
      }
    }

    waitframe();
  }
}

function hudextractmax(var0) {
  if(!isDefined(var0.weapon_name)) {
    return false;
  }

  var1 = 0;

  switch (var0.weapon_name) {
    case "armor_box_mp":
    case "support_box_mp":
      var1 = 1;
      break;
  }

  if(var1) {
    return true;
  }

  return false;
}

function vehicle_collision_loadtablecell(var0, var1, var2) {
  if(!isDefined(var0.idflags_br_armor_hit)) {
    var0.idflags_br_armor_hit = [];
  }

  var3 = self getentitynumber();
  var0.idflags_br_armor_hit[var3] = var1;
  wait var2;

  if(isDefined(var0) && isDefined(var0.idflags_br_armor_hit)) {
    var0.idflags_br_armor_hit[var3] = undefined;
  }

  if(isDefined(var0) && isDefined(var0.idflags_br_armor_hit) && var0.idflags_br_armor_hit.size == 0) {
    var0.idflags_br_armor_hit = undefined;
    return;
  }
}

function hudkothtimer(var0, var1, var2) {
  if(!istrue(var0.spawn_juggernauts_fob)) {
    var3 = var1.velocity * 150;
    var0 playSound("mp_care_package_high_impact");
    var0 physicslaunchserver(var2, var3);
    var0.spawn_juggernauts_fob = 1;
    thread vehicle_collision_loadtablecell(level, var0, var1);
    return;
  }

  var0 scripts\cp_mp\killstreaks\airdrop::destroycrate();
  var0.ref_11b0d = 1;
}

function ref_144ca() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("trigger", var0);

    if(isDefined(var0) && isPlayer(var0)) {
      ref_13f03(self.ref_11e1d, var0);
      break;
    }
  }
}

function ref_1423f(var0, var1) {}

function ref_1422f(var0, var1) {
  self notify("vehicleBeginPath");
  self endon("vehicleBeginPath");
  self endon("death");
  var2 = 0;
  self.carriable_explode = 1;
  self.tutonplayerkilled = undefined;

  if(!isDefined(var1)) {
    var1 = 0;
  }

  var0.initial_enemy_spawner = 0;
  var0.ref_136fb = var1;
  thread ref_1423a();
  var3 = 1;
  self startpathnodes(var0.points, var0.times, 0, 0.5, 0.5, 0, 0, var2, 0, 0, 1, 1);
}

function ref_14483(var0) {
  self notify("kill_path_swap_watcher");
  level endon("game_ended");
  self endon("death");
  self endon("kill_path_swap_watcher");

  for(;;) {
    self waittill("swap_to_next_path");

    if(self.inside_bush >= level.hudglobalkillcountmax.paths[var0].size - 1) {
      self.inside_bush = 0;
    } else {
      self.inside_bush += 1;
    }

    self startpathnodes(level.hudglobalkillcountmax.paths[var0][self.inside_bush].points, level.hudglobalkillcountmax.paths[var0][self.inside_bush].times, 0, 0.5, 0.5, 0, 0, 0, 0, 0, 1, 1);
  }
}

function freight_lift_build(var0, var1) {
  var2 = 1.57828e-05;
  var3 = 3600;
  var4 = 1;
  var5 = distance(var0, var1);
  var6 = var5 * var2;
  var7 = max(var6 / 10 * var3, var4);
  return var7;
}

function ref_1423a() {
  level endon("game_ended");
  self notify("vehicleDamageVehicles");
  self endon("vehicleDamageVehicles");
  self endon("death");
  self vehphys_enablecollisioncallback(1);

  for(;;) {
    self waittill("collision", var0, var1, var2, var3, var4, var5, var6, var7, var8);

    if(!isDefined(var7)) {
      continue;
    }

    if(var7 scripts\mp\gametypes\br_public::nuke_vault_suicidebombers()) {
      ref_1423e(var7, self);
      continue;
    }

    if(isDefined(var7.equipmentref) && var7.equipmentref == "equip_tac_cover") {
      var7 scripts\mp\equipment\tactical_cover::tac_cover_destroy(undefined, 1);
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

function ref_1423e(var0) {
  self.ref_12282 = 1;
  self dodamage(self.health, var0.origin, var0, var0);

  if(isDefined(self)) {
    self.ref_12282 = undefined;
    return;
  }
}

function ref_11f86(var0) {
  self endon("death");

  for(;;) {
    scripts\mp\objidpoolmanager::update_objective_onentity(var0, self);
    wait 0.1;
  }
}

function accessoryfem() {}

function preventleave(var0) {
  var1 = var0;
  var2 = [];
  GscBinSkip0(0x2e, var2.size, var0);
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

function ref_13077(var0, var1, var2) {
  foreach(var4 in level.hudglobalkillcountmax.i_see_player_drone_watcher) {
    if(isDefined(var4)) {
      level.hudglobalkillcountmax.i_see_player_drone_watcher[0].intel_pieces = var0;
      var4 vehicle_setspeed(var0, var1, var2);
    }
  }
}

function ref_13f03(var0) {
  if(isDefined(var0)) {
    ref_12aff(var0.team);
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
    var0.intel_collect_vo_func = 0;
    var0.armsrace_c4_planter_backlot = 0;
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
      var0 = scripts\common\utility::playersincylinder(self.origin, 1000);

      if(isDefined(var0) && isDefined(var0[0])) {
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
    foreach(var1 in self.ref_12b1d) {
      if(isDefined(var1) && isDefined(var1.origin)) {
        var1.intel_collect_vo_func = ref_12efc(var1) + ref_12f0c(var1);

        if(var1.intel_collect_vo_func < 0) {
          var1.intel_collect_vo_func = 0;
        }
      }
    }

    wait 0.1;
  }
}

function ref_12efc(var0) {
  return (1 - distance2d(self.origin, var0.origin) / 5000) * 1;
}

function ref_12f0c(var0) {
  var1 = var0.armsrace_c4_planter_backlot;

  if(!isDefined(var0.armsrace_c4_planter_backlot)) {
    return 0;
  }

  if(var0.armsrace_c4_planter_backlot > 1000) {
    var1 = 1000;
  }

  return var1 / 1000 * 2;
}

function ref_12c4e() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    wait 5;

    foreach(var1 in self.ref_12b1d) {
      if(isDefined(var1) && isDefined(var1.armsrace_c4_planter_backlot)) {
        var1.armsrace_c4_planter_backlot -= 250;

        if(var1.armsrace_c4_planter_backlot < 0) {
          var1.armsrace_c4_planter_backlot = 0;
        }
      }
    }
  }
}

function playapache_dialogue(var0) {
  self.ref_11e1d endon("death");
  self endon("kill_turret");
  waitframe();
  var1 = 0;
  var2 = 1;
  var3 = var0;
  self.attackingtarget = var0;
  self.canseetarget = ref_140d7(self, self.groundtargetent, self.attackingtarget);

  for(;;) {
    if(isDefined(var3) && self.canseetarget && !scripts\mp\utility\player::unset_relic_trex(var3) && scripts\mp\utility\player::isreallyalive(var3) && var1 < self.ref_11e1d.clipsize && scripts\engine\utility::distance_2d_squared(self.origin, var3.origin) < 25000000) {
      if(!isDefined(self.groundtargetent)) {
        return;
      }

      self.groundtargetent.origin = var3.origin;
      var4 = vectordot(anglestoright(self.ref_11e1d.angles), vectorNormalize(self.groundtargetent.origin - self.origin));
      var5 = vectordot(-1 * anglesToForward(self.ref_11e1d.angles), vectorNormalize(self.groundtargetent.origin - self.origin));

      if(self.name == "right_turret") {
        if(var4 >= self.ref_11b52) {
          fire_turret(var3);
        }
      } else if(self.name == "left_turret") {
        if(var4 <= -1 * self.ref_11b52) {
          fire_turret(var3);
        }
      } else if(self.name == "rear_turret" && var5 > self.ref_11b52) {
        fire_turret(var3);
      }

      var1++;
    } else if(var1 < self.ref_11e1d.clipsize) {
      var3 = selfrevivemonitorrevivebuttonPressed();
    } else {
      wait 4;
      var3 = selfrevivemonitorrevivebuttonPressed();
      var1 = 0;
    }

    wait 0.1;
  }
}

function fire_turret(var0) {
  self settargetentity(self.groundtargetent);
  ref_13129(self, var0.origin, level.hudglobalkillcountmax.ref_13e81);
  self shootturret("tag_flash");
}

function ref_14448(var0) {
  self.ref_11e1d endon("death");
  self endon("kill_turret");
  self endon("lost_target");
  level endon("game_ended");

  if(!isDefined(var0)) {
    return;
  }

  for(;;) {
    if(!ref_140d7(self, self.groundtargetent, var0)) {
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
  var0 = self.maxhealth * 0.6;

  for(;;) {
    if(self.health < var0) {
      get_all_players_enemy_info_new();
      var0 /= 2;
    }

    wait 0.1;
  }
}

function get_all_players_enemy_info_new() {
  level endon("game_ended");
  self endon("kill_turret");
  self endon("death");
  var0 = 7;
  var1 = semtex_killstuckplayer();

  for(;;) {
    if(isDefined(var1)) {
      level thread scripts\mp\gametypes\br_quest_util::ref_140b1(self.origin + (0, 0, 75), "attack", 2);

      foreach(var3 in self.ref_12b1d) {
        scripts\mp\gametypes\br_killstreaks::isbrsquadleader(var1, "precision_airstrike");
      }

      wait 1;
      thread pavelow_boss_explodes(var1);
      wait 60;
      break;
    }
  }
}

function accuracy_bonus_factor() {}

function selfrevivemonitorrevivebuttonPressed() {
  var0 = 0;
  var1 = undefined;

  if(self.ref_11a52.size > 0) {
    foreach(var3 in self.ref_11a52) {
      if(isDefined(var3)) {
        if(isDefined(var3.intel_collect_vo_func) && var3.intel_collect_vo_func > var0) {
          var1 = var3;
        }
      }
    }

    thread ref_14448(var1);
  }

  return var1;
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

  var0 = self.ref_12b1d[0];

  for(var1 = 1; var1 < self.ref_12b1d.size; var1++) {
    if(!isDefined(self.ref_12b1d[var1])) {
      self.ref_12b1d = scripts\engine\utility::can_path_to_target(self.ref_12b1d, var1);
      continue;
    }

    if(scripts\engine\utility::distance_2d_squared(self, self.ref_12b1d[var1]) < scripts\engine\utility::distance_2d_squared(self.origin, var0.origin)) {
      var0 = self.ref_12b1d[var1];
    }
  }

  return var0;
}

function ref_12aff(var0) {
  var1 = scripts\mp\utility\teams::getteamdata(var0, "players");

  if(isDefined(var1)) {
    foreach(var3 in var1) {
      if(isDefined(var3) && scripts\mp\utility\player::isreallyalive(var3) && !scripts\engine\utility::array_contains(self.ref_12b1d, var3)) {
        self.ref_12b1d[self.ref_12b1d.size] = var3;
      }
    }

    return;
  }
}

function ref_13c3f() {
  level endon("game_ended");
  self.ref_11e1d endon("death");
  self endon("kill_turret");
  var0 = 0;

  for(var1 = 0; var1 < self.ref_11e1d.ref_12b1d.size + 1; var1++) {
    scripts\engine\utility::array_removeundefined(self.ref_11e1d.ref_12b1d);
    scripts\engine\utility::array_removeundefined(self.ref_11a52);

    if(var1 >= self.ref_11e1d.ref_12b1d.size) {
      var1 = 0;
    }

    if(self.ref_11e1d.ref_12b1d.size == 0) {
      break;
    }

    if(scripts\mp\utility\player::unset_relic_trex(self.ref_11e1d.ref_12b1d[var1])) {
      ref_12bea(self.ref_11e1d, self.ref_11e1d.ref_12b1d[var1]);
    } else if(ref_140d7(self, self.groundtargetent, self.ref_11e1d.ref_12b1d[var1])) {
      if(!scripts\engine\utility::array_contains(self.ref_11a52, self.ref_11e1d.ref_12b1d[var1])) {
        self.ref_11a52[self.ref_11a52.size] = self.ref_11e1d.ref_12b1d[var1];
      }
    } else if(scripts\engine\utility::array_contains(self.ref_11a52, self.ref_11e1d.ref_12b1d[var1])) {
      self.ref_11a52 = scripts\engine\utility::array_remove(self.ref_11a52, self.ref_11e1d.ref_12b1d[var1]);

      if(self.ref_11a52.size <= 0) {
        self cleartargetentity();
      }
    }

    if(var1 % 3 == 0) {
      wait 0.1;
    }
  }
}

function ref_12bea(var0) {
  if(!isDefined(var0)) {
    return;
  }

  var1 = scripts\engine\utility::array_contains(self.ref_12d3f.ref_11a52, var0);
  var2 = scripts\engine\utility::array_contains(self.waypoint_endzone_vfx.ref_11a52, var0);
  var3 = scripts\engine\utility::array_contains(self.rearturret.ref_11a52, var0);

  if(var1) {
    self.ref_12d3f.ref_11a52 = scripts\engine\utility::array_remove(self.ref_12d3f.ref_11a52, var0);
    return;
  }

  if(var2) {
    self.waypoint_endzone_vfx.ref_11a52 = scripts\engine\utility::array_remove(self.waypoint_endzone_vfx.ref_11a52, var0);
    return;
  }

  if(var3) {
    self.rearturret.ref_11a52 = scripts\engine\utility::array_remove(self.rearturret.ref_11a52, var0);
    return;
  }
}

function ref_13129(var0, var1, var2) {
  var3 = var1;

  if(isDefined(var2)) {
    var4 = randomint(var2);
    var5 = randomint(360);
    var6 = randomintrange(32, 48);
    var7 = var1[0] + var4 * cos(var5);
    var8 = var1[1] + var4 * sin(var5);
    var9 = var1[2] + var6;
    var3 = (var7, var8, var9);
    var0.groundtargetent.origin = var3;
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

function hudsbredeploy(var0, var1, var2) {
  scripts\mp\vehicles\damage::set_weapon_hit_damage_data_for_vehicle(var0, var1, self.vehiclename);
  scripts\mp\vehicles\damage::set_vehicle_hit_damage_data_for_weapon(self.vehiclename, var2, var0);
}

function hunters_killed_by_targets(var0) {
  var1 = var0.damage;
  var2 = var0.attacker;

  if(!isDefined(var2) || !isPlayer(var2)) {
    return false;
  }

  level.hudglobalkillcountmax.locindex = 20;

  if(isDefined(self.initplunderpads) && self.initplunderpads != "engaged" && !level.hudglobalkillcountmax.getoldestdogtags) {
    ref_13f03(var2);
  }

  return true;
}

function humanspawninair(var0) {
  if(!isDefined(self.attackers)) {
    self.attackers = [];
  }

  var1 = hudkothbesttimelabel(var0.attacker);

  if(!isDefined(var1)) {
    var2 = spawnStruct();
    var2.player = var0.attacker;
    var2.objweapon = var0.objweapon;
    var2.ref_13bee = var0.damage;
    self.attackers[self.attackers.size] = var2;
  } else {
    var1.ref_13bee += var0.damage;
    var1.objweapon = var0.objweapon;
  }

  if(!isDefined(var0.attacker.armsrace_c4_planter_backlot)) {
    var0.attacker.armsrace_c4_planter_backlot = 0;
  }

  var0.attacker.armsrace_c4_planter_backlot += var0.damage;

  if(var0.attacker.armsrace_c4_planter_backlot > 1000) {
    var0.attacker.armsrace_c4_planter_backlot = 1000;
  }

  level.hudglobalkillcountmax.ref_119e9 -= var0.damage;

  if(is_enemy_dangerous(var0.objweapon.basename)) {
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
  var0 = getDvar("scr_br_verse");
  level.ref_12815 = spawnStruct();
  level.ref_12815.ammo = ["brloot_ammo_919", "brloot_ammo_12g", "brloot_ammo_762", "brloot_ammo_50cal", "brloot_ammo_rocket"];
  level.ref_12815.armor = ["brloot_armor_plate"];
  level.ref_12815.weapon_xp_iw8_sh_mike26 = ["brloot_offhand_c4", "brloot_offhand_molotov"];

  if(isDefined(var0) && var0 != "ww2") {
    level.ref_12815.weapon_xp_iw8_sh_mike26[level.ref_12815.weapon_xp_iw8_sh_mike26.size] = "brloot_offhand_thermite";
    level.ref_12815.weapon_xp_iw8_sh_mike26[level.ref_12815.weapon_xp_iw8_sh_mike26.size] = "brloot_offhand_claymore";
    level.ref_12815.weapon_xp_iw8_sh_mike26[level.ref_12815.weapon_xp_iw8_sh_mike26.size] = "brloot_offhand_semtex";
  }

  level.ref_12815.ref_11cd2 = ["brloot_plunder_cash_uncommon_1"];
}

function hudglobalkillcount(var0) {
  if(scripts\mp\gametypes\br_lootcache::get_bonus_targets(var0)) {
    var1 = level.br_pickups.delay_hide_player_clip[var0];
    var2 = scripts\mp\gametypes\br_pickups::test_ai_anim();
    var3 = anglesToForward(self.angles) * 155 * -1;
    var4 = self.origin + var3;
    var5 = (var4[0], var4[1], self.origin[2] + 100);
    var6 = vectorNormalize(var5 - self.origin + (0, 0, 100)) * 155;
    var7 = self.origin + var6;

    if(issubstr(var0, "ammo")) {
      var8 = scripts\mp\gametypes\br_lootcache::ref_11a41(var0, var2, var7, self.angles, 0, 0);
      var8.count = level.br_pickups.maxcounts[var0];
      return;
    }

    var9 = scripts\mp\gametypes\br_lootcache::ref_11a41(var0, var2, var7, self.angles, 0, 0);

    if(isDefined(var9)) {
      var9.count = 1;
      return;
    }

    return;
  }
}

function hunterswonending() {
  var0 = randomint(4);

  switch (var0) {
    case 0:
      var1 = level.ref_12815.ammo[randomint(level.ref_12815.ammo.size - 1)];
      hudglobalkillcount(var1);
      break;
    case 1:
      var1 = level.ref_12815.armor[0];
      hudglobalkillcount(var1);
      break;
    case 2:
      var1 = level.ref_12815.weapon_xp_iw8_sh_mike26[randomint(level.ref_12815.weapon_xp_iw8_sh_mike26.size - 1)];
      hudglobalkillcount(var1);
      break;
    case 3:
      var1 = level.ref_12815.ref_11cd2[0];
      hudglobalkillcount(var1);
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

function is_enemy_dangerous(var0) {
  if(var0 == "c4_mp_p" || var0 == "at_mine_ap_mp" || var0 == "at_mine_mp" || var0 == "claymore_mp") {
    return true;
  }

  return false;
}

function hudnumtoconsume(var0) {
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
  var1 = undefined;
  var2 = undefined;
  var3 = var0.attacker;
  var4 = istrue(self.ref_133da);
  level.hudglobalkillcountmax.i_see_player_drone_watcher = scripts\engine\utility::array_remove(level.hudglobalkillcountmax.i_see_player_drone_watcher, self);
  self notify("death", var0.attacker, var0.meansofdeath, var0.ref_14596, var0.damagelocation);

  if(!var4) {
    foreach(var6 in self.attackers) {
      if(isDefined(var6.player)) {
        if(isDefined(var3) && var3 == var6.player) {
          var1 = "convoy_killed";
        } else {
          var1 = "convoy_assist";
        }

        var2 = scripts\mp\rank::getscoreinfovalue(var1);
        var6.player thread scripts\mp\rank::giverankxp(var1, var2, var6.objweapon);
        var6.player thread scripts\mp\events::killeventtextpopup(var1, 0);
        thread scripts\cp\vehicles\vehicle_compass_cp::vehiclekilled(self, var0.inflictor, var6.player, 0, var6.objweapon);
      }
    }

    foreach(var9 in self.ref_12b1d) {
      if(isDefined(var9)) {
        var9 thread scripts\mp\hud_message::showsplash("convoy_truck_finish");
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

  var11 = getdvarint("scr_convoy_team_points", 0);

  if(isDefined(var3) && var11 > 0 && !isDefined(var0.ref_11e93)) {
    level scripts\mp\gamescore::giveteamscoreforobjective(var3.team, var11, 0);
  }

  level.hudglobalkillcountmax.brvalidatekillcam++;
  var12 = self gettagorigin("tag_origin");
  playFX(scripts\engine\utility::getfx("convoy_truck_explode"), var12, anglesToForward(self.angles), anglestoup(self.angles));
  playsoundatpos(var12, "car_explode");
  earthquake(0.4, 800, var12, 0.7);
  playrumbleonposition("grenade_rumble", var12);
  physicsexplosionsphere(var12, 500, 200, 1);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
  scripts\engine\utility::array_removeundefined(level.hudglobalkillcountmax.i_see_player_drone_watcher);
  return false;
}

function convoy_spawn_specific_cash_type(var0, var1, var2) {
  var3 = spawnStruct();
  var3.item = var0;
  var3.ml_p3_to_safehouse_transition = var1;
  var3.heightoffset = 0;
  var3.origin = var2;

  for(var4 = 0; var4 < var1; var4++) {
    thread _handlevehiclerepair::ref_13672(var3);
  }
}

function hudkothbesttimelabel(var0) {
  var1 = undefined;

  if(!isDefined(var0)) {
    return var1;
  }

  foreach(var3 in self.attackers) {
    if(isDefined(var3.player) && var0 == var3.player) {
      var1 = var3;
      break;
    }
  }

  return var1;
}

function minigamelosersettings() {
  var0 = self.origin;

  if(isDefined(var0)) {
    var1 = scripts\cp_mp\killstreaks\airdrop::dropcrate(undefined, undefined, "heavy_weapon_crate", self.origin, (0, randomfloat(360), 0), var0);
    var1.ref_13428 = spawn("script_model", var0);
    var1.ref_13428 setModel("ks_airdrop_crate_br");
    var1.ref_13428 setscriptablepartstate("smoke_signal", "on", 0);

    if(isDefined(var1)) {
      var1 setscriptablepartstate("objective", "heavy_weapon_public");
    }

    var2 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(var1);
    var2.ref_140a0 = 10;
    return;
  }
}

function ref_140d7(var0, var1, var2) {
  self endon("explode");
  self endon("death");

  if(!isDefined(var2) || scripts\mp\utility\player::unset_relic_trex(var2)) {
    return 0;
  }

  var3 = 1;
  var4 = 1;
  var5 = 0;
  var6 = 1;
  var7 = 0;
  var8 = 1;
  var9 = 0;
  var10 = 1;
  var11 = 0;
  var12 = scripts\engine\trace::create_contents(var3, var4, var5, var6, var7, var8, var9, var10, var11);
  var12 += init_cp_execution("physicscontents_solid");
  var12 += init_cp_execution("physicscontents_water");
  var13 = [var0];

  if(isDefined(var1)) {
    GscBinSkip0(0x2e, var13.size, var1);
  }

  var15 = scripts\engine\trace::ray_trace_passed(var0 gettagorigin("tag_barrel"), var2.origin, var13, var12);
  return var15;
}

function init_cp_execution(var0) {
  var1 = [var0];
  return physics_createcontents(var1);
}

function accessorybig() {}

function watchcheck() {}

function buttonmashcount(var0) {
  var0 scripts\mp\hud_message::showsplash("br_reveal_bombardment_launch_enemy");
}

function crates_delete_early() {
  var0 = getmaxobjectivecount(self.origin[0], self.origin[1], 2000);
  level waittill("launch_bombardment");
  var0 delete();
}

function create_animpack(var0, var1) {
  var2 = magicgrenademanual("toma_proj_mp", var1.sourcepos, var1.initvelocity, 5);
  var3 = var2 scripts\mp\objidpoolmanager::createobjective("icon_minimap_cruisemissile", "axis", undefined, 1, 1);
  var2 setentityowner(self);
  var2 setotherent(self);
  var2.owner = self;
  var2 setscriptablepartstate("launch", "active", 0);
  var2 setscriptablepartstate("trail", "active", 0);
  var2.explodeent = spawn("script_model", var2.origin);
  var2.explodeent setModel("ks_toma_strike_missile_mp_x2");
  var2.explodeent linkTo(var2);
  var2.explodeent dontinterpolate();
  var2.explodeent setentityowner(self);
  var4 = spawn("script_model", var1.sourcepos);
  var4 linkTo(var2, "tag_origin", (10, 0, 10), (0, 0, 0));
  var2.killcament = var4;
  var2.streakinfo = var0;
  var5 = randomint(360);
  var2.angles = (90, var5, 0);
  thread create_badplace_extraction(var2, var1.preexplpos);
  var2 thread scripts\cp_mp\killstreaks\toma_strike::toma_strike_watch_stuck(vectortoangles(var1.initvelocity), gettime(), var1.initvelocity);
  var2 waittill("death");
  objective_delete(var3);
}

function cratephysicsoncallback(var0, var1) {
  var2 = spawnStruct();
  var3 = var0 + (0, 0, 5000);
  var4 = vectorNormalize(var0 - (var3[0], var3[1], 0));
  var5 = scripts\cp_mp\killstreaks\toma_strike::ref_13bd6(var0, var1, var4);
  var6 = (0, 0, -1 * getdvarint("NPOQPMP", 800));
  var7 = (var5.point - 0.5 * var6 * squared(1) - var3) / 1;
  var8 = 1 * randomfloatrange(0.95, 1);
  var9 = var3 + var7 * var8 + 0.5 * var6 * squared(var8);
  var2.sourcepos = var3;
  var2.num_of_frame_frozen = var5.num_of_frame_frozen;
  var2.num_of_subway_cars = var5.num_of_subway_cars;
  var2.goalpos = var5.point;
  var2.preexplpos = var9;
  var2.initvelocity = var7;
  var2.parachutecleanup = var8;
  return var2;
}

function create_badplace_extraction(var0, var1) {
  self endon("death");
  self endon("missile_dest_failed");
  self.killcament thread scripts\cp_mp\killstreaks\toma_strike::toma_strike_move_killcam(0.75, var0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var1);
  self setmissileminimapvisible(0);
  thread scripts\cp_mp\killstreaks\toma_strike::toma_strike_missile_explode(var0);
}

function accessoryface() {}

function entityhit() {
  var0 = spawnStruct();
  var0.streakname = "toma_strike";
  var0.owner = self;
  var0.score = 0;
  var0.shots_fired = 0;
  var0.hits = 0;
  var0.damage = 0;
  var0.kills = 0;
  var0.ref_121a9 = "ks_toma_strike_missile_mp_x2";
  var0.ref_121a8 = "ks_toma_strike_cluster_mp_x2";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "createCustomStreakData")) {
    var0 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "createCustomStreakData")]](var0, "toma_strike");
  }

  return var0;
}

function ref_11d2c(var0, var1, var2) {
  var3 = play_ac130_approach_scene();
  ref_132b3(var3, var0, var1, var2);
}

function pavelow_boss_explodes(var0) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");
  var1 = spawnStruct();
  var1.streakname = "precision_airstrike";
  var1.owner = self;
  var1.score = 0;
  var1.shots_fired = 0;
  var1.hits = 0;
  var1.damage = 0;
  var1.ref_133de = 1;
  var1.kills = 0;
  var1.ref_133ce = 1;
  var1.setuptimelimit = 0;
  var1.brmini_ontimelimit = 1;
  var1.lifeid = 0;
  self.pers["team"] = "neutral";
  var2 = spawnStruct();
  var2.origin = var0.origin;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "createCustomStreakData")) {
    var1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "createCustomStreakData")]](var1, "precision_airstrike");
  }

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var1)) {
      return 0;
    }
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var1)) {
      return 0;
    }
  }

  var3 = level.scr_anim[var1.streakname]["airstrike_flyby"];
  var4 = getanimlength(var3);
  var5 = scripts\engine\utility::get_notetrack_time(var3, "attack");
  var6 = scripts\cp_mp\killstreaks\airstrike::branalytics_respawn(var0.origin + anglesToForward(var0.angles) * 1000, self);
  var7 = self.angles[1];
  scripts\cp_mp\killstreaks\airstrike::finishairstrikeusage(var0.origin, var7, var2, var1, var3, var6);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var4);

  if(isDefined(level.killstreakfinishusefunc)) {
    level thread[[level.killstreakfinishusefunc]](var1);
  }

  scripts\cp_mp\killstreaks\airstrike::branalytics_seteventdelayedstate(self, var6);
}

function play_ac130_approach_scene() {
  var0 = undefined;

  if(isDefined(level.idflags_br_armor_break)) {
    var0 = level.idflags_br_armor_break;
  } else {
    var1 = scripts\engine\utility::array_reverse(level.agentarray);

    foreach(var3 in var1) {
      if(!isDefined(var3)) {
        continue;
      }

      if(isDefined(var3.team) && var3.team != "axis") {
        continue;
      }

      if(!isDefined(var3.team) && isDefined(var3.agentteam)) {
        continue;
      }

      var0 = var3;
      var0.ref_1407d = 1;

      if(!isDefined(var0.pers["nextKillstreakID"])) {
        var0.pers["nextKillstreakID"] = 0;
      }

      break;
    }

    level.idflags_br_armor_break = var0;
  }

  return var0;
}

function ref_132b3(var0, var1, var2, var3) {
  if(!isDefined(var3)) {
    var3 = var0 scripts\cp_mp\utility\killstreak_utility::createstreakinfo("toma_strike", var0);
  }

  var3.ref_11eae = 0;
  var3.ref_11f47 = 1;
  var3.vehicle_process_node_when_at_goal = 1;
  var3.ref_121a9 = "ks_toma_strike_missile_mp_x2";
  var3.ref_121a8 = "ks_toma_strike_cluster_mp_x2";
  var0.origin = var1;
  var0.angles = vectortoangles(var2 - var1);
  var3.ref_13a81 = var2;
  var0 thread scripts\cp_mp\killstreaks\toma_strike::starttomastrike(5, undefined, undefined, var3);
}

function ref_13afb(var0, var1) {
  var2 = scripts\mp\mp_agent::spawnnewagent("actor_enemy_lw_br", "team_two_hundred", var0, var1);
  var2 setgoalvolume(level.hudglobalkillcountmax.getoriginidentifierstringnoz);
  bomber(var2);
}

function ref_13068(var0) {
  switch (var0) {
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

function ref_13521(var0, var1) {
  var2 = [];

  for(var3 = 0; var3 < var0; var3++) {
    var4 = var1 + 300 * anglesToForward((0, (var3 + 1) * 72, 0));
    var5 = ref_13afb(var4, (0, 0, 0));
    var2 = var5;
  }

  return var2;
}

function bomb_hostage_play_anim(var0, var1) {
  self.weapon = scripts\mp\class::buildweapon(var0, ["laserrange", "none", "none", "none", "none", "none"], "none", "none", var1);
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
  var0 = gettime() / 1000;

  for(;;) {
    var1 = self getgoalvolume();
    var2 = distance2d(self.origin, var1.origin);
    var3 = var2 < 600;
    self.ref_145d4 = var3;

    if(var3) {
      var4 = gettime() / 1000;
      var5 = var4 - var0;
      self.ref_13b6b = var5;
      var6 = level.ai_event.binoculars_targetisvalid;
      self.ref_13b6c = var6 - var5;

      if(var4 - var0 >= var6) {
        var7 = [];

        foreach(var9 in level.ai_event.select_hostage_room_three_spawners) {
          if(var9.players.size > 0 && var9 != var1) {
            var7 = var9;
          }
        }

        if(var7.size > 0) {
          var11 = scripts\engine\utility::random(var7);
          self setgoalvolumeauto(var11);
        }

        var0 = gettime() / 1000;
      }
    } else {
      var0 = gettime() / 1000;
    }

    wait 1;
  }
}

function ref_134e9() {}

function ref_134ea() {}

function activate_scavenger_bag() {}

function watchcrategastimeout(var0) {
  self endon("death");
  self endon("checkpoint_encounter_started");
  self endon("kill_mines");
  var1 = randomintrange(6, 10);
  wait var1;
  var2 = 1;

  for(var3 = 0; var3 < var0; var3++) {
    self.waypoint_completed_vfx = self gettagorigin("TAG_DROP_BACK_LEFT");
    self.ref_12d3e = self gettagorigin("TAG_DROP_BACK_RIGHT");
    var4 = randomintrange(4, 6);

    if(var2) {
      var5 = magicgrenademanual("semtex_mp", self.waypoint_completed_vfx, (0, 0, -2), var4, self);
    } else {
      var5 = magicgrenademanual("semtex_mp", self.ref_12d3e, (0, 0, -2), var4, self);
    }

    var2 = !var2;
    wait 0.5;
  }

  thread watchcrategastimeout(var0);
}
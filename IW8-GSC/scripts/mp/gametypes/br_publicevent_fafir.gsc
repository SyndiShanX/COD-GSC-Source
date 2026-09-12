/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_fafir.gsc
*********************************************************/

function init() {
  var_0 = spawnStruct();
  var_0.weight = getdvarfloat("scr_br_pe_fafir_weight", 0);
  var_0.ref_140CF = &ref_140CF;
  var_0.attackerswaittime = &attackerswaittime;
  var_0.ref_14382 = &ref_14382;
  var_0.postinitfunc = &postinitfunc;
  var_0.ref_11B78 = getdvarint("scr_br_pe_fafir_max_times", 0);
  var_0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx("fafir", "02020200 0 0 0");
  var_0.pemetereventweights = scripts\mp\gametypes\br_publicevents_meter::getdvarpemetereventweights("fafir");
  scripts\mp\gametypes\br_publicevents::ref_12B35(18, var_0);
}

function test_bag_pickup() {
  level.br_pe_fafir_data = spawnStruct();
  level.br_pe_fafir_data.instances = [];
  level.br_pe_fafir_data.volbomb_toxicamount = getdvarint("scr_br_pe_fafir_strike_volbomb_normal_amount", 3);
  level.br_pe_fafir_data.volbomb_cosmeticamount = getdvarint("scr_br_pe_fafir_strike_volbomb_cosmetic_amount", 7);
  level.br_pe_fafir_data.strike_explosionradius = getdvarint("scr_br_pe_fafir_strike_explosion_radius", 1000);
  level.br_pe_fafir_data.strike_targetingradius = getdvarint("scr_br_pe_fafir_strike_targeting_radius", 1500);
  level.br_pe_fafir_data.strike_lowrange = getdvarint("scr_br_pe_fafir_strike_low_range", 10000);
  level.br_pe_fafir_data.strike_medrange = getdvarint("scr_br_pe_fafir_strike_med_range", 30000);
  level.br_pe_fafir_data.strike_highrange = getdvarint("scr_br_pe_fafir_strike_high_range", 50000);
  level.br_pe_fafir_data.strike_gravitylowrange = getdvarint("scr_br_pe_fafir_strike_gravity_low_range", 20000);
  level.br_pe_fafir_data.strike_gravitymedrange = getdvarint("scr_br_pe_fafir_strike_gravity_med_range", 12000);
  level.br_pe_fafir_data.strike_gravityhighrange = getdvarint("scr_br_pe_fafir_strike_gravity_high_range", 7500);
  level.br_pe_fafir_data.strike_speedlowrange = getdvarint("scr_br_pe_fafir_strike_speed_low_range", 8000);
  level.br_pe_fafir_data.strike_speedmedrange = getdvarint("scr_br_pe_fafir_strike_speed_med_range", 10000);
  level.br_pe_fafir_data.strike_speedhighrange = getdvarint("scr_br_pe_fafir_strike_speed_high_range", 12000);
  level.br_pe_fafir_data.toxic_scalarvalue = getdvarfloat("scr_br_pe_fafir_toxic_scalar", 1);
  level.br_pe_fafir_data.toxic_radiusspreadtime = getdvarfloat("scr_br_pe_fafir_toxic_radius_spread_time", 20) * level.br_pe_fafir_data.toxic_scalarvalue;
  level.br_pe_fafir_data.toxic_lifetime = getdvarint("scr_br_pe_fafir_toxic_lifetime", 10) + level.br_pe_fafir_data.toxic_radiusspreadtime;
  level.br_pe_fafir_data.toxic_radiusmax = getdvarint("scriptable_cityKillerMaxRadius", 3000) * level.br_pe_fafir_data.toxic_scalarvalue;
  level.br_pe_fafir_data.toxic_radiusmin = getdvarint("scriptable_cityKillerMinRadius", 1000) * level.br_pe_fafir_data.toxic_scalarvalue;
  level.br_pe_fafir_data.toxic_damagepertick = getdvarint("scr_br_pe_fafir_toxic_initial_damage_per_tick", 12);
  level.br_pe_fafir_data.toxic_vfx_height_threshold = getdvarint("scr_br_pe_fafir_toxic_vfx_height_threshold", 2250);
  level.br_pe_fafir_data.toxic_vfx_grid_division_count = getdvarint("scr_br_pe_fafir_toxic_vfx_grid_division_count", 5);
  level.br_pe_fafir_data.toxic_vfx_inner_clouds_spacing = getdvarint("scr_br_pe_fafir_toxic_vfx_inner_clouds_spacing", 200);
  level.br_pe_fafir_data.toxic_vfx_allow_high_net_lod = getdvarint("scr_br_pe_fafir_toxic_vfx_allow_high_net_lod", 0);
  level.br_volcano_data = spawnStruct();
  level.br_volcano_data.shakeintensity = getdvarfloat("scr_br_pe_fafir_shake_intensity", 0.4);
  level.br_volcano_data.shakeduration = getdvarfloat("scr_br_pe_fafir_shake_duration", 2);
  level.br_volcano_data.shakeradius = getdvarint("scr_br_pe_fafir_shake_radius", 100000);

  if(!isDefined(level.hvv_data)) {
    level.hvv_data = spawnStruct();
  }

  level.br_pe_fafir_data.brushmodel = getEnt("lava_bomb_collision", "targetname");
}

function initlocations() {
  if(!isDefined(level.br_pe_fafir_data)) {
    level.br_pe_fafir_data = spawnStruct();
  }

  level.br_pe_fafir_data.locations = [];
  level.br_pe_fafir_data.oob_locations = [];
  level.br_pe_fafir_data.previous_locations = [];

  switch (getDvar("mapname")) {
    case "mp_wz_island":
      level.br_pe_fafir_data.locations = [(3082.75, 531, 3426.75), (-14610.3, -12734.8, 881.5), (-30700.5, -30311.5, 858), (18984.8, 55917.8, 177.5), (11026, 58585.5, 369.25), (46963, 38986.5, 260), (38221.3, 43254.5, 790.75), (30958.5, 45074.3, 1291), (21384.8, 40108.5, 1602.25), (12078.5, 47861.3, 907.25), (2654.75, 42867.3, 1085.75), (-3461, 49297.3, 1250), (-5693.5, 41866.8, 1256.5), (-15242.5, 46205, 719.75), (-20261.8, 45778.8, 337.25), (-32990.3, 26086.5, 787.75), (-17402, 36106.3, 1182.75), (-14247.8, 28359.5, 3020.25), (-5332, 34753, 1072.75), (-1080.5, 29989.8, 1039.25), (7745, 28819, 4245.5), (9750.75, 39446, 684), (24995.5, 35181.3, 2466.25), (21065, 29575.3, 3971), (34786.5, 27204, 1852.5), (38203.5, 36513.5, 1552), (41069.5, 30401.8, 1173.75), (46662.3, 30476.5, 846.75), (46819.8, 24629.5, 455.25), (42717, 17092, 592), (35921.5, 18815.8, 1496.5), (26347.8, 22039.3, 2620), (9477.75, 26347.3, 4764.5), (-6003.75, 22718.8, 1144.25), (-9154.25, 13834.8, 1952.25), (-21083.5, 20147.5, 2969.5), (-15159.5, 15410.5, 3658), (-32427.5, 16901.8, 965.75), (-44351.3, 20528, 1350.75), (-43726.3, 13898.5, 1498), (-46765.5, 5591.5, 1037), (-39000.8, 10171.5, 1018.75), (-26540.5, 9793.25, 2641), (-18704, 6078.25, 3231), (-13530, 1944.25, 501), (-2328.25, 12017, 3782.5), (16580.8, 2717.5, 4509.5), (24099.8, 7489.63, 2703.65), (33171.6, 11259.9, 764.4), (34758.8, 1038.88, 1176.9), (44042.3, 8120.63, 319.15), (41879.8, -9966.37, 581.15), (33530.6, -5854.87, 1941.9), (31117.8, -11487.4, 4010.65), (24049.3, 394.384, 2771.4), (20321.8, -7697.87, 3877.4), (2836, -4967.25, 2143.75), (8858, -9607.5, 1846.5), (-5219, -10765.8, 1613.25), (-3979, -1912.75, 1836), (-16345, -3826, 490.75), (-24598.8, -10701.5, 413), (-34330.5, -2566.5, 2456.25), (-39473, -9290.75, 504), (-45097, -915, 374), (-45472.8, -17987.5, 352.25), (-30157.8, -22111.5, 880.75), (-28950.3, -14795.5, 1002), (-22409, -23093.3, 885.5), (-4722, -21771.5, 1522.25), (-18.25, -17327, 2117.75), (9180.75, -16978, 2204.75), (1223.5, -25339.3, 2078.25), (23497.5, -19198, 3800), (14550.5, -18653.3, 3252.75), (29858.5, -17783.3, 5292), (37167, -24164, 1819), (44628.8, -21343.3, 247.5), (41856, -34492.8, 345.5), (35045, -31877, 561.5), (27212, -39539.3, 639), (18059, -29311.8, 5492.25), (13484.3, -38331, 3908.75), (3570.5, -32594.3, 3602.5), (11620.8, -38958.8, 3607.25), (-4822.75, -37830.8, 2399), (-7818.75, -29843.5, 1771.75), (-21943.3, -31186.3, 984.5), (-15532.3, -38377, 2156), (-16523.3, -40508.8, 2140.5), (-11912, -51806.3, 1303.5), (-5092.25, -46423.3, 2244), (724, -43629.8, 3482.5), (11386.8, -47546.8, 1521.25), (20423.5, -50600.5, 413), (19471.8, -46557.3, 752.25), (29467.8, -45889.8, 494.5), (37662, -48701, 256.25), (46085.3, -40378.5, 214.5), (33670, -55129.5, 353.5), (23173.3, -56253.8, 243), (3455.25, -54708.8, 1094.25)];
      break;
    case "mp_br_mechanics":
      level.br_pe_fafir_data.locations = [(-2219, -2155, 58), (5000, -4426, 58), (4000, -4426, 58), (3000, -4426, 58), (2000, -4426, 58)];
      break;
  }

  level.br_pe_fafir_data.oob_locations = [(-55000, 63000, 0), (-25000, 63000, 0), (0, 63000, 0), (25000, 63000, 0), (55000, 63000, 0), (-55000, -63000, 0), (-25000, -63000, 0), (0, -63000, 0), (25000, -63000, 0), (55000, -63000, 0), (55000, 63000, 0), (55000, 33000, 0), (55000, 0, 0), (55000, -33000, 0), (55000, -63000, 0), (-55000, 63000, 0), (-55000, 33000, 0), (-55000, 0, 0), (-55000, -33000, 0), (-55000, -63000, 0)];
}

function postinitfunc() {
  level._effect["vfx_lava_bomb_gas_explosion"] = loadfx("vfx/iw8_br/island/gameplay/vfx_br3_lava_bomb_gas_explosion");
  level._effect["vfx_lava_bomb_gas_cloud"] = loadfx("vfx/iw8_br/island/gameplay/vfx_br3_lava_bomb_gas_cloud");
  level._effect["vfx_lava_bomb_gas_cloud_player"] = loadfx("vfx/iw8_br/island/gameplay/vfx_br3_lava_bomb_gas_cloud_player");
  level._effect["vfx_lava_bomb_gas_cloud_distant"] = loadfx("vfx/iw8_br/island/gameplay/vfx_br3_lava_bomb_gas_cloud_distant");
  scripts\mp\utility\sound::besttime("br_event_fafir");
  test_bag_pickup();
  initlocations();
  thread circlewatcher();
}

function ref_140CF() {
  return scripts\mp\utility\game::round_vehicle_logic() == "olaride";
}

function ref_14382() {
  level endon("game_ended");
  level endon("cancel_public_event");
  var_0 = forest_combat();
  wait var_0;
}

function attackerswaittime() {
  level endon("game_ended");
  thread volcanoexplode(level, level.br_pe_fafir_data.volbomb_toxicamount);
}

function forest_combat() {
  var_0 = getdvarfloat("scr_br_pe_fafir_starttime_min", 90);
  var_1 = getdvarfloat("scr_br_pe_fafir_starttime_max", 395);

  if(var_1 > var_0) {
    return randomfloatrange(var_0, var_1);
  }

  return var_0;
}

function checkpositionavailability(var_0) {
  for(var_1 = 0; var_1 < level.br_pe_fafir_data.previous_locations.size; var_1++) {
    if(var_0 == level.br_pe_fafir_data.previous_locations[var_1]) {
      return false;
    }
  }

  return true;
}

function players_in_radius(var_0, var_1) {
  var_2 = level.br_pe_fafir_data.toxic_radiusmax + level.br_pe_fafir_data.strike_targetingradius;
  var_3 = scripts\mp\utility\player::getplayersinradius(var_0, var_2).size;
  var_4 = scripts\mp\utility\player::getplayersinradius(var_1, var_2).size;
  return var_3 >= var_4;
}

function volcanoexplode(var_0, var_1) {
  var_3 = [];

  if(getdvarint("scr_br_fafir_focus_players", 1) == 1) {
    level.br_pe_fafir_data.locations = scripts\engine\utility::array_sort_with_func(level.br_pe_fafir_data.locations, &players_in_radius);
  } else {
    level.br_pe_fafir_data.locations = scripts\engine\utility::array_randomize(level.br_pe_fafir_data.locations);
  }

  for(var_2 = 0; var_2 < var_0; var_2++) {
    if(var_2 >= level.br_pe_fafir_data.locations.size) {
      break;
    }

    if(checkpositionavailability(level.br_pe_fafir_data.locations[var_2])) {
      thread ref_1368B(level, level.br_pe_fafir_data.locations[var_2]);
      var_3 = level.br_pe_fafir_data.locations[var_2];
      continue;
    }

    var_0++;
  }

  wait 0.05;
  level.br_pe_fafir_data.oob_locations = scripts\engine\utility::array_randomize(level.br_pe_fafir_data.oob_locations);

  for(var_2 = 0; var_2 < var_1; var_2++) {
    waitframe();
    thread ref_1368B(level, level.br_pe_fafir_data.oob_locations[var_2]);
  }

  LOC_0000011f:
    level.br_pe_fafir_data.previous_locations = var_3;
  wait 6 - level.br_volcano_data.shakeduration - 0.05;
  scripts\mp\gametypes\br_gametype_olaride::startshake(level.br_volcano_data.shakeintensity, level.br_volcano_data.shakeduration, 0, (8387, 15066, 8191), level.br_volcano_data.shakeradius);
  scripts\engine\utility::exploder("lava_bomb_volcano_explosion");
}

function ref_1368B(var_0, var_1) {
  var_2 = (8387, 15066, 8191);
  var_3 = spawn("script_model", var_2);

  if(var_1) {
    var_4 = ref_11A9F(var_0, 1000, 12, 2);
    var_3.circleent = var_4;
    var_5 = scripts\common\utility::playersincylinder(var_0, 2000);

    foreach(var_7 in var_5) {
      if(!isDefined(var_7) || !scripts\mp\utility\player::isreallyalive(var_7)) {
        continue;
      }

      scripts\mp\gametypes\br_killstreaks::isbrsquadleader(var_7, "fafir_strike", 0);
      var_7 playsoundtoplayer("lava_rock_incoming_warning", var_7);
    }
  }

  wait 6;
  var_3 setModel("ks_fafir_br");
  var_3 dontinterpolate();
  var_3 unmarkkeyframedmover(1);
  var_9 = distance2d(var_2, var_0);
  var_10 = calculaterockthrowvalues(var_9);
  var_11 = var_10[0];
  var_12 = var_10[1];
  var_10 = undefined;
  var_13 = var_9 / var_11;
  var_14 = -1 * var_12;
  var_15 = trajectorycalculateinitialvelocity(var_3.origin, var_0, (0, 0, var_14), var_13);
  var_3 movegravity(var_15, var_13, var_12);
  var_3 setscriptablepartstate("trail", "active", 0);
  wait var_13;
  var_3 setscriptablepartstate("trail", "neutral", 0);
  var_3.origin = var_0;
  waitframe();
  thread projectileimpact(var_3, var_13, var_1);
}

function projectileimpact(var_0, var_1, var_2) {
  self setscriptablepartstate("explode", "active", 0);
  doinstantdamagezone(level.br_pe_fafir_data.strike_explosionradius, var_2);

  if(var_1) {
    thread rocksetupfumes(var_2);

    if(isDefined(level.br_pe_fafir_data.brushmodel)) {
      self.collisionmodel = spawn("script_model", var_2 + (0, 0, 75));
      self.collisionmodel.angles = (90, 0, 0);
      self.collisionmodel clonebrushmodeltoscriptmodel(level.br_pe_fafir_data.brushmodel);
      return;
    }

    return;
  }

  wait var_0;
  self delete();
}

function ref_11A9F(var_0, var_1, var_2, var_3) {
  var_4 = getmaxobjectivecount(var_0[0], var_0[1], var_1);
  var_4 setmapcirclecolorindex(var_2);
  var_4 setmapcircleiconindex(21);
  var_4 setmapcirclestyleindex(var_3);
  return var_4;
}

function calculaterockthrowvalues(var_0) {
  var_1 = level.br_pe_fafir_data.strike_speedmedrange;
  var_2 = level.br_pe_fafir_data.strike_gravitymedrange;

  if(var_0 > level.br_pe_fafir_data.strike_highrange) {
    var_1 = level.br_pe_fafir_data.strike_speedhighrange;
    var_2 = level.br_pe_fafir_data.strike_gravityhighrange;
  } else if(var_0 > level.br_pe_fafir_data.strike_medrange) {
    var_1 = level.br_pe_fafir_data.strike_speedmedrange;
    var_2 = level.br_pe_fafir_data.strike_gravitymedrange;
  } else if(var_0 > level.br_pe_fafir_data.strike_lowrange) {
    var_1 = level.br_pe_fafir_data.strike_speedlowrange;
    var_2 = level.br_pe_fafir_data.strike_gravitylowrange;
  }

  return [var_1, var_2];
}

function destroycrate() {
  if(isDefined(self.molotov_delete_oldest_trigger)) {
    self.molotov_delete_oldest_trigger delete();
  }

  scripts\cp_mp\killstreaks\airdrop::lastactivateinstruct();
}

function rocksetupfumes(var_0) {
  var_1 = spawn("script_model", var_0);
  var_1 setModel("ks_fafir_br");
  waitframe();
  var_1.origin = var_0;
  var_1.height = scripts\cp_mp\parachute::getc130height() * 2;
  var_1.initialwinningteam = 0;
  var_1.ref_129E0 = int(level.br_pe_fafir_data.toxic_radiusmax);
  var_1.ref_129E1 = int(level.br_pe_fafir_data.toxic_radiusmin);
  var_1.ref_129DF = var_1.ref_129E1;
  var_1.circleent = self.circleent;
  var_1.rock = self;
  var_1.sfx_infil_hackney_heli2_rope = 0;
  thread begincountdown();

  if(getdvarint("scr_fafir_use_hotspots_for_lava_bombs", 0)) {
    var_2 = getdvarfloat("scr_fafir_outer_visionset_outer_radius_factor", 4);
    var_3 = getdvarfloat("scr_fafir_outer_visionset_inner_radius_factor", 3);
    var_4 = getdvarfloat("scr_fafir_inner_visionset_outer_radius_factor", 0.5);
    var_5 = getdvarfloat("scr_fafir_inner_visionset_inner_radius_factor", 0.5);
    function_0448(var_0, "lava_bomb_near_gas", var_1.ref_129E0 * var_2, var_1.ref_129E1 * var_3, level.br_pe_fafir_data.toxic_lifetime);
    waitframe();
    function_0448(var_0, "lava_bomb_in_gas", var_1.ref_129E0 * var_4, var_1.ref_129E0 * var_4 - 1, level.br_pe_fafir_data.toxic_lifetime);
  }

  return var_1;
}

function begincountdown() {
  level endon("game_ended");
  self endon("fumes_dissipate");
  self.rock.circleent setmapcirclestyleindex(0);
  scripts\mp\gametypes\br_quest_util::init_tactical_boxes(12, 0, 1, self.origin);
  scripts\mp\gametypes\br_quest_util::ref_13369();
  scripts\mp\gametypes\br_quest_util::ref_1316F(self.ref_129E0);
  var_0 = (0, 0, self.height / 2);
  var_1 = self.origin - var_0;
  self.trigger = spawn("trigger_radius", var_1, 0, self.ref_129E0, self.height);
  scripts\mp\utility\trigger::makeenterexittrigger(self.trigger, &ref_12027, &ref_12030, undefined, undefined, &ref_13DA5);
  self.trigger.lavabomb = self;
  wait 5;
  thread spreadfumes();
}

function spreadfumes() {
  level endon("game_ended");
  self endon("fumes_dissipate");
  self.sfx_infil_hackney_heli2_rope = 1;
  var_0 = playFX(scripts\engine\utility::getfx("vfx_lava_bomb_gas_explosion"), self.origin);
  thread track_target_group_complete();
  self.onscavengerbagpickup = gettime();
  thread dissipate();
  var_1 = 0;

  for(;;) {
    var_2 = gettime();
    var_3 = (var_2 - self.onscavengerbagpickup) / 1000;
    var_1 = var_3 / level.br_pe_fafir_data.toxic_radiusspreadtime;
    var_1 = clamp(var_1, 0, 1);
    self.ref_129DF = self.ref_129E1 * (1 - var_1) + self.ref_129E0 * var_1;
    self.angles = (0, var_1 * 179, 0);
    var_4 = 1;
    var_5 = self.height;
    var_6 = 0.4;
    var_7 = var_1 * self.height * var_6;
    self.initialwinningteam = clamp(var_7, var_4, var_5);
    self.circleent.origin = (self.circleent.origin[0], self.circleent.origin[1], self.ref_129DF);
    waitframe();
  }
}

function doinstantdamagezone(var_0, var_1) {
  wait 0.15;
  radiusdamage(var_1, var_0, 200, 200, self, "MOD_EXPLOSIVE", "lava_bomb_mp", 0, 1, 1);

  if(getdvarint("scr_br_fafir_damage_vehicles", 1)) {
    var_2 = tablesort(self.origin + (0, 0, -100), var_0, 400);

    foreach(var_4 in var_2) {
      if(isalive(var_4) && var_4.health > 1) {
        var_4 dodamage(var_4.health, self.origin, self, self, "MOD_CRUSH");
      }
    }
  }

  var_6 = float(var_0 * var_0);

  if(isDefined(level.cratedata) && isDefined(level.cratedata.crates)) {
    foreach(var_8 in level.cratedata.crates) {
      if(isDefined(var_8)) {
        var_9 = distance2dsquared(var_8.origin, self.origin);

        if(var_9 < var_6) {
          thread destroycrate();
        }
      }
    }

    return;
  }
}

function dissipate() {
  level endon("game_ended");
  wait level.br_pe_fafir_data.toxic_lifetime;
  level.br_pe_fafir_data.instances = scripts\engine\utility::array_remove(level.br_pe_fafir_data.instances, self);

  foreach(var_1 in level.players) {
    if(isDefined(var_1) && updatelocationbesttimehud(var_1, self) && isalive(var_1)) {
      deregisterallclientvfx(var_1);
      var_1 notify("lava_bomb_exit");
      exitdamagetick(var_1, self.trigger.lavabomb);
      setplayergasvfxactive(var_1, 0);
    }
  }

  self.trigger delete();
  wait 0.5;
  self.rock.collisionmodel delete();
  self.rockdelete();
  self.mapcircle delete();
  self.circleent delete();
  track_settings();
  self notify("fumes_dissipate");
  self delete();
}

function setplayergasvfxactive(var_0) {
  if(!isPlayer(self)) {
    return;
  }

  if(isDefined(self.lava_bomb_eye_vfx)) {
    stopfxontagforclients(scripts\engine\utility::getfx("vfx_lava_bomb_gas_cloud_player"), self, "j_head", self);
    self.lava_bomb_eye_vfx = undefined;
  }

  if(var_0) {
    self.lava_bomb_eye_vfx = scripts\engine\utility::getfx("vfx_lava_bomb_gas_cloud_player");
    playfxontagforclients(self.lava_bomb_eye_vfx, self, "j_head", self);
    return;
  }
}

function deregisterallclientvfx(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  var_1 = var_0 getentitynumber();
  var_2 = 4;
  var_3 = 0;

  if(!isDefined(self.ref_124FF)) {
    return;
  }

  if(!isDefined(self.ref_124FF[var_1])) {
    return;
  }

  foreach(var_5 in self.ref_124FF[var_1]) {
    var_6 = var_5[0];
    var_7 = var_5[1];
    var_8 = var_5[2];
    var_9 = stopfxontagforclients(var_6, var_7, var_8, var_0);
    var_10 = isPlayer(var_7) || isbot(var_7) || isagent(var_7);

    if(!var_10) {
      var_7 delete();
    }

    var_3++;

    if(var_3 >= 4) {
      var_3 = 0;
      waitframe();
    }
  }
}

function track_target_group_complete() {
  level endon("game_ended");
  self endon("fumes_dissipate");
  self.ref_142A3 = [];
  self.ref_142A4 = [];
  waitframe();
  self.track_get_teleport_velocity = gettime();
  self.track_get_teleport_target = self.track_get_teleport_velocity + level.br_pe_fafir_data.toxic_lifetime * 1000;
  thread track_timer_think();

  for(;;) {
    var_0 = gettime();
    var_1 = (var_0 - self.track_get_teleport_velocity) / 1000;
    var_2 = var_1 / level.br_pe_fafir_data.toxic_radiusspreadtime;
    var_2 = clamp(var_2, 0, 1);
    self.ref_129DF = self.ref_129E1 * (1 - var_2) + self.ref_129E0 * var_2;
    waitframe();
  }
}

function track_timer_think() {
  var_0 = spawnStruct();
  var_1 = self.ref_129E0;
  var_0.ref_11A58 = self.origin + (var_1 * -1, var_1 * -1, 0);
  var_0.ref_11A59 = self.origin + (var_1, var_1 * -1, 0);
  var_0.ref_14039 = self.origin + (var_1 * -1, var_1, 0);
  var_0.ref_1403A = self.origin + (var_1, var_1, 0);
  var_2 = level.br_pe_fafir_data.toxic_vfx_grid_division_count;
  var_3 = self.ref_129E0 * 2;
  var_4 = var_3 / var_2;
  var_5 = (self.origin[0] - self.ref_129E0, self.origin[1] - self.ref_129E0, 0);
  trackcarpunches(self.origin);

  for(var_6 = 0; var_6 < var_2; var_6++) {
    for(var_7 = 0; var_7 < var_2; var_7++) {
      var_8 = var_4 * var_6;
      var_9 = (var_8, 0, 0);
      var_10 = var_4 * var_7;
      var_11 = (0, var_10, 0);
      var_12 = var_5 + var_9 + var_11;

      if(distance2d(var_12, self.origin) < self.ref_129E0) {
        trackcarpunches(var_12);
      }
    }
  }

  track_last_good_position();
}

function trackcarpunches(var_0) {
  var_1 = spawnStruct();
  var_1.index = self.ref_142A3.size;
  var_1.origin = var_0;
  var_1.angles = (0, 0, 0);
  var_1.state = "valid";
  var_1.parent = undefined;
  var_1.ref_14293 = undefined;
  var_2 = distance(var_1.origin, self.origin);
  var_1.loot_getitemcountlefthand = self.ref_129E0 - var_2;
  self.ref_142A3[self.ref_142A3.size] = var_1;
}

function track_last_good_position() {
  trackcashevent(self.ref_142A3[0]);

  foreach(var_1 in self.ref_142A3) {
    if(var_1.state != "valid") {
      continue;
    }

    var_2 = 150;

    if(var_1.loot_getitemcountlefthand <= var_2) {
      continue;
    }

    trackcashevent(var_1);
  }
}

function trackcashevent(var_0) {
  if(var_0.state != "valid") {
    return;
  }

  var_0.state = "selected";
  var_1 = physics_createcontents(["physicscontents_solid", "physicscontents_water"]);
  var_2 = (0, 0, 100000);
  var_3 = var_0.origin + var_2;
  var_4 = var_0.origin - var_2;
  var_5 = [];
  var_6 = physics_raycast(var_3, var_4, var_1, var_5, 0, "physicsquery_closest", 1);
  var_7 = var_0.origin;

  if(isDefined(var_6) && var_6.size > 0) {
    var_7 = var_6[0]["position"];
  }

  var_8 = scripts\engine\utility::ter_op(var_0.loot_getitemcountlefthand < 3000, 200, 1500);
  var_0.ref_14293 = spawnfx(scripts\engine\utility::getfx("vfx_lava_bomb_gas_cloud_distant"), var_7 + (0, 0, randomfloatrange(0, var_8)));

  if(level.br_pe_fafir_data.toxic_vfx_allow_high_net_lod) {
    var_0.ref_14293 unmarkkeyframedmover(1);
  }

  self.ref_142A4[self.ref_142A4.size] = var_0;
  var_9 = risk_flagspawncount();

  foreach(var_11 in self.ref_142A3) {
    if(var_11.state != "valid") {
      continue;
    }

    var_12 = distance2d(var_0.origin, var_11.origin);

    if(var_12 <= level.br_pe_fafir_data.toxic_vfx_inner_clouds_spacing) {
      var_11.parent = var_0;
      var_11.state = "occupied";
      var_11.color = var_9;
    }
  }

  thread track_is_operational(var_0);
}

function track_is_operational(var_0) {
  level endon("game_ended");
  var_0 endon("fumes_dissipate");

  for(;;) {
    if(scripts\engine\utility::updatescrapassistdata(self.origin, var_0.origin, var_0.ref_129DF + 1500)) {
      if(isDefined(self.ref_14293)) {
        triggerfx(self.ref_14293);
      }

      break;
    }

    wait 1;
  }
}

function track_settings() {
  foreach(var_1 in self.ref_142A4) {
    if(isDefined(var_1.ref_14293)) {
      var_1.ref_14293 delete();
    }
  }

  self.ref_142A3 = [];
  self.ref_142A4 = [];
  self notify("fumes_dissipate");
}

function risk_flagspawncount() {
  var_0 = randomfloatrange(0.4, 1);
  var_1 = randomfloatrange(0.3, 0.6);
  var_2 = randomfloatrange(0.3, 1);
  return (var_0, var_1, var_2);
}

function ref_12027(var_0, var_1) {
  var_2 = var_0;
  thread damagetickwatcher(var_2);
}

function ref_12030(var_0, var_1) {
  var_2 = var_0;
  exitdamagetick(var_2, var_1.lavabomb);
  setplayergasvfxactive(var_2, 0);
}

function damagetickwatcher(var_0) {
  while(!var_0.sfx_infil_hackney_heli2_rope) {
    waitframe();
  }

  level endon("game_ended");
  self endon("disconnect");
  self notify("lava_bomb_enter");
  self endon("lava_bomb_enter");
  self endon("lava_bomb_exit");
  var_0 endon("fumes_dissipate");
  wait 0.1;

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(updatelocationbesttimehud(var_0) && candamageplayer()) {
      if(!istrue(self.in_lava_bomb_damage_zone)) {
        var_1 = getdvarfloat("scr_fafir_lava_bomb_visionset_in_transition_time", 1);
        self visionsetnakedforplayer("lava_bomb_in_gas", var_1);
        self.in_lava_bomb_damage_zone = 1;
        setplayergasvfxactive(1);
      }

      var_2 = level.br_pe_fafir_data.toxic_damagepertick;

      if(scripts\cp_mp\gasmask::hasgasmask(self)) {
        if(!scripts\mp\gametypes\br_pickups::ks_circlecount(self)) {
          scripts\mp\gametypes\br_pickups::plunderrepositoryref("lava_bomb_fumes");
        }

        scripts\cp_mp\gasmask::processdamage(var_2);
      } else {
        if(scripts\mp\utility\killstreak::isjuggernaut()) {
          var_2 = scripts\mp\gametypes\br_jugg_common::ref_11C95(var_2);
        }

        var_3 = self;

        if(scripts\mp\gametypes\br_public::hasarmor()) {
          scripts\mp\gametypes\br_public::damagearmor(var_2);
        } else {
          self dodamage(var_2, self.origin, var_3, undefined, undefined, "city_killer_mp", "j_body");
        }

        if(isPlayer(self)) {
          scripts\mp\gametypes\br_circle::ref_13E18();
        }
      }
    } else {
      exitdamagetick(var_0);
    }

    wait 1;
  }
}

function exitdamagetick(var_0) {
  if(!isplayeroutsidealldamagezones()) {
    return;
  }

  var_1 = getdvarfloat("scr_fafir_lava_bomb_visionset_out_transition_time", 4);
  self visionsetnakedforplayer("", var_1);
  setplayergasvfxactive(0);
  self.in_lava_bomb_damage_zone = 0;

  if(scripts\cp_mp\gasmask::hasgasmask(self)) {
    scripts\mp\gametypes\br_pickups::plunderrankupdate("lava_bomb_fumes");
  }

  if(!isalive(self)) {
    self notify("lava_bomb_exit");
    return;
  }
}

function candamageplayer() {
  if(!isalive(self)) {
    return false;
  }

  if(istrue(self.start_death_from_above_sequence)) {
    return false;
  }

  if(istrue(self.gulag) && istrue(self.inrespawnc130)) {
    return false;
  }

  if(scripts\mp\gametypes\br_public::ref_125F3() && scripts\mp\gametypes\br_public::ref_125EC()) {
    return false;
  }

  if(istrue(self.ref_14439)) {
    return false;
  }

  if(istrue(self.unset_relic_thirdperson)) {
    return false;
  }

  if(istrue(self.gulag)) {
    if(istrue(self.gulagarena) || istrue(self.jailed)) {
      return false;
    }
  }

  return true;
}

function playerisingasvfxzheightcheck() {
  var_0 = physics_createcontents(["physicscontents_solid", "physicscontents_water"]);
  var_1 = (0, 0, 50);
  var_2 = 1;
  var_3 = level.br_pe_fafir_data.toxic_vfx_height_threshold + var_2;
  var_4 = self.origin + var_1;
  var_5 = self.origin - var_3;
  var_6 = [self];
  var_7 = physics_raycast(var_4, var_5, var_0, var_6, 0, "physicsquery_closest", 1);

  if(isDefined(var_7[0])) {
    var_8 = var_7[0]["position"];

    if(self.origin[2] - var_8[2] < level.br_pe_fafir_data.toxic_vfx_height_threshold) {
      return true;
    }
  }

  return false;
}

function updatelocationbesttimehud(var_0) {
  var_1 = playerisingasvfxzheightcheck();

  if(distance(self.origin, var_0.origin) < var_0.ref_129DF && var_1) {
    return true;
  }

  var_2 = distance2d(self.origin, var_0.origin) <= var_0.ref_129DF;
  var_3 = var_0.initialwinningteam / 2;
  var_4 = abs(var_0.origin[2] - self.origin[2]) <= var_0.initialwinningteam / 2;

  if(var_2 && var_1) {
    return true;
  }

  return false;
}

function isplayeroutsidealldamagezones() {
  var_0 = 0;

  foreach(var_2 in level.br_pe_fafir_data.instances) {
    if(!isDefined(var_2.trigger)) {
      continue;
    }

    if(scripts\engine\utility::array_contains(var_2.trigger.triggerenterents, self)) {
      var_3 = updatelocationbesttimehud(var_2);

      if(!var_3) {
        var_0++;
      }
    }
  }

  return level.br_pe_fafir_data.instances.size == var_0 || level.br_pe_fafir_data.instances.size == 0;
}

function ref_13DA5(var_0, var_1) {
  if(isPlayer(var_0) || isbot(var_0) || isagent(var_0)) {
    return false;
  }

  return true;
}

function circlewatcher() {
  level endon("game_ended");
  jumpiffalse(!isDefined(level.br_circle) || istrue(level.br_circle_disabled)) LOC_0000001d;
  return;
}

function ispointinsafelocation(var_0, var_1) {
  var_2 = level.br_level.default_class_chosen[level.br_circle.circleindex + 1];
  var_3 = float(level.br_level.br_circleradii[level.br_circle.circleindex + 1]);

  if(!isDefined(var_2) || !isDefined(var_3)) {
    return false;
  }

  var_4 = distance2dsquared(var_0, var_2);
  var_5 = var_3 - var_1;

  if(var_4 < var_5 * var_5) {
    return true;
  }

  return false;
}
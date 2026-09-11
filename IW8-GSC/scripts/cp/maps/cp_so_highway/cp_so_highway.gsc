/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_so_highway\cp_so_highway.gsc
***********************************************************/

function main() {
  syringe_finish_stand();
  level.ref_11b51 = 35;
  level.nightmap = 1;
  setdvarifuninitialized("scr_use_squads", 1);
  setdvarifuninitialized("scr_squad_max", 4);
  setdvarifuninitialized("scr_squad_leader_max", 2);
  setdvarifuninitialized("scr_ai_squad_move_type", "1");
  setdvarifuninitialized("scr_smoketest", "0");
  setdvarifuninitialized("scr_highway_skip_intro", 0);
  setdvarifuninitialized("scr_forceround", 0);
  scripts\cp\utility::coop_mode_enable();
  registerscriptedagents();
  scripts\engine\utility::flag_init("scriptables_ready");
  scripts\cp\maps\cp_so_highway\cp_so_highway_precache::main();
  scripts\cp\maps\cp_so_highway\gen\cp_so_highway_art::main();
  scripts\cp\maps\cp_so_highway\cp_so_highway_fx::main();
  scripts\vehicle\pindia::main("veh8_mil_lnd_pindia", "truck_minimap", "script_vehicle_iw8_truck_pindia_white");
  scripts\vehicle\pindia::main("veh8_mil_lnd_pindia_black", "truck_minimap", "script_vehicle_iw8_truck_pindia_black");
  scripts\vehicle\pindia::main("veh8_mil_lnd_pindia_cream", "truck_minimap", "script_vehicle_iw8_truck_pindia_cream");
  scripts\vehicle\pindia::main("veh8_mil_lnd_pindia_red", "truck_minimap", "script_vehicle_iw8_truck_pindia_red");
  scripts\vehicle\pindia::main("veh8_mil_lnd_pindia_tan", "truck_minimap", "script_vehicle_iw8_truck_pindia_tan");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_rebel", "truck_minimap", "script_vehicle_iw8_truck_techo_rebel");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_black", "truck_minimap", "script_vehicle_iw8_truck_techo_black");
  scripts\vehicle\mindia8::main("veh8_mil_air_mindia8_open_back_playerride", "mindia8_minimap", "script_vehicle_iw8_mindia8_playerride");
  setDvar("NPONLLLSPL", 1.25);
  setDvar("PKKMTTRQO", 4);
  setDvar("NKLMONNPNN", 2048);
  setDvar("MROOOROPKL", 8);
  setDvar("LTQMSPKRKO", 8);

  if(level.createfx_enabled) {
    return;
  }

  scripts\cp\vehicle::init_vehicles();
  level thread scripts\cp\cp_objectives::objectives_init();
  scripts\cp_mp\utility\script_utility::registersharedfunc("cruise_predator", "directionOverride", &initarmsraceanims);
  level.disable_hotjoin_via_ac130 = 1;
  level.loadoutsecondaryaddblueprintattachments = 1;
  level.hostdamagefactorlow = 0;
  level.map_interaction_func = &scripts\cp\maps\cp_so_highway\cp_so_highway_interactions::register_interactions;
  level.custom_onspawnplayer_func = &onplayerspawn;
  level.weapon_rank_event_table = "scripts/cp/maps/cp_so_highway/cp_so_highway_weaponrank_event.csv";
  level.player_interaction_monitor = &scripts\cp\maps\cp_so_highway\cp_so_highway_interactions::level_specific_player_interaction_monitor;
  level.wait_for_interaction_func = &scripts\cp\maps\cp_so_highway\cp_so_highway_interactions::level_specific_wait_for_interaction_triggered;
  level.interaction_trigger_properties_func = &interaction_trigger_properties;
  level.mud_sfx = &mud_sfx;

  if(!isDefined(level.agent_funcs)) {
    level.agent_funcs = [];
  }

  if(!scripts\engine\utility::flag_exist("introscreen_over")) {
    scripts\engine\utility::flag_init("introscreen_over");
  }

  if(!scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_init("strike_init_done");
  }

  level thread scripts\cp\cp_movers::main();
  level thread scripts\cp\classes\cp_class_progression::class_progression_init();
  level thread scripts\cp\factions\faction_progression::faction_progression_init();
  level thread scripts\cp\cp_deployablebox::init();
  level.additional_laststand_weapon_exclusion = [];

  if(level.scripted_spawner_func.size < 1) {
    scripts\engine\utility::flag_set("strike_init_done");
  }

  if(!scripts\engine\utility::flag_exist("infil_complete")) {
    scripts\engine\utility::flag_init("infil_complete");
  }

  level.eogscoreboard = ["currency", "kills", "headShots", "downs", "revives"];
  scripts\cp\cp_compass::setupminimap("compass_map_cp_so_highway");
  scripts\engine\utility::flag_set("infil_complete");
  scripts\engine\utility::flag_init("intro_heli_can_crash");
  scripts\engine\utility::flag_init("intro_heli_crashing");
  scripts\engine\utility::flag_init("leave_lz");
  support_box_delay_max_ammo_hint();
  thread syringe_inject();
  init_spawners();

  if(getdvarint("scr_highway_skip_intro")) {
    ref_1437b();
  } else {
    intro_main();
  }

  jumped();
  ref_1216d();
}

function syringe_finish_stand() {
  var0 = getEntArray("trigger_hurt", "classname");

  foreach(var2 in var0) {
    if(!scripts\engine\utility::is_equal(var2.target, "auto1")) {
      continue;
    }

    var2.origin -= (0, 0, 160);
  }

  var4 = getEntArray("minimap_corner", "targetname");
  var5 = [(-4484, -4047, 1768), (2485, 6151, 1768)];

  foreach(var8, var7 in var4) {
    var7.origin = var5[var8];
  }

  var9 = getEntArray("OutOfBounds", "targetname");

  foreach(var11 in var9) {
    var11.origin -= (0, 0, 256);

    if(var11.origin == (-3344, -2720, 1232)) {
      var11.origin -= (0, 256, 0);
    }
  }

  var13 = getEntArray();

  foreach(var15 in var13) {
    if(var15.origin == (-1507.75, -1416.5, 1171.5)) {
      var15.origin = (-1505.25, -1416.5, 1171.5);
      continue;
    }

    if(var15.origin == (-1513.72, -1431.54, 1171.5)) {
      var15.origin = (-1509.72, -1431.54, 1171.5);
      var16 = ref_1249f(1);
      var17 = createheadicon(var16);
      var18 = spawn("weapon_" + var17, var15.origin, 1);
      var18.angles = var15.angles;
      var18 itemweaponsetammo(weaponclipsize(var18), weaponmaxammo(var18));
      var15 delete();
      continue;
    }

    if(var15.origin == (-529.988, -1715.24, 1210.5)) {
      var15.origin = (-529.988, -1716.24, 1210.5);
      var16 = ref_1249f(1);
      var17 = createheadicon(var16);
      var18 = spawn("weapon_" + var17, var15.origin, 1);
      var18.angles = var15.angles;
      var18 itemweaponsetammo(weaponclipsize(var18), weaponmaxammo(var18));
      var15 delete();
      continue;
    }

    if(var15.origin == (-1468.21, -2578.1, 1071.24)) {
      var16 = ref_1249d();
      var17 = createheadicon(var16);
      var18 = spawn("weapon_" + var17, var15.origin, 1);
      var18.angles = var15.angles;
      var18 itemweaponsetammo(weaponclipsize(var18), weaponmaxammo(var18));
      var15 delete();
      continue;
    }

    if(var15.origin == (-1326.1, -2557.79, 1076.24)) {
      var16 = ref_1249d();
      var17 = createheadicon(var16);
      var18 = spawn("weapon_" + var17, var15.origin, 1);
      var18.angles = var15.angles;
      var18 itemweaponsetammo(weaponclipsize(var18), weaponmaxammo(var18));
      var15 delete();
      continue;
    }

    if(var15.origin == (-1193.79, -2573.9, 1077.24)) {
      var16 = ref_1249d();
      var17 = createheadicon(var16);
      var18 = spawn("weapon_" + var17, var15.origin, 1);
      var18.angles = var15.angles;
      var18 itemweaponsetammo(weaponclipsize(var18), weaponmaxammo(var18));
      var15 delete();
      continue;
    }

    if(var15.origin == (-1185.9, -2472.21, 1081.24)) {
      var16 = ref_1249d();
      var17 = createheadicon(var16);
      var18 = spawn("weapon_" + var17, var15.origin, 1);
      var18.angles = var15.angles;
      var18 itemweaponsetammo(weaponclipsize(var18), weaponmaxammo(var18));
      var15 delete();
      continue;
    }

    if(var15.origin == (-1318.54, -1412.28, 1171.5)) {
      var16 = ref_1249f(2);
      var17 = createheadicon(var16);
      var18 = spawn("weapon_" + var17, var15.origin, 1);
      var18.angles = var15.angles;
      var18 itemweaponsetammo(weaponclipsize(var18), weaponmaxammo(var18));
      var15 delete();
      continue;
    }

    if(var15.origin == (-625.5, -1745.5, 1210.5)) {
      var16 = ref_1249f(2);
      var17 = createheadicon(var16);
      var18 = spawn("weapon_" + var17, var15.origin, 1);
      var18.angles = var15.angles;
      var18 itemweaponsetammo(weaponclipsize(var18), weaponmaxammo(var18));
      var15 delete();
      continue;
    }

    if(var15.origin == (-1507.75, -1416.5, 1171.5)) {
      var16 = ref_1249f(1);
      var17 = createheadicon(var16);
      var18 = spawn("weapon_" + var17, var15.origin, 1);
      var18.angles = var15.angles;
      var18 itemweaponsetammo(weaponclipsize(var18), weaponmaxammo(var18));
      var15 delete();
      continue;
    }

    if(var15.origin == (-1303.5, -1417.25, 1171.5)) {
      var16 = ref_1249f(1);
      var17 = createheadicon(var16);
      var18 = spawn("weapon_" + var17, var15.origin, 1);
      var18.angles = var15.angles;
      var18 itemweaponsetammo(weaponclipsize(var18), weaponmaxammo(var18));
      var15 delete();
    }
  }

  var20 = spawn("script_model", (-2442, -2077, 1050));
  var20 dontinterpolate();
  var20.angles = (2, 0, 0);
  var21 = getEnt("clip8x8x256", "targetname");
  var20 clonebrushmodeltoscriptmodel(var21);
  var22 = spawn("script_model", (-1258, -2398, 1060));
  var22 dontinterpolate();
  var22.angles = (0, 73, 0);
  var23 = getEnt("clip32x32x32", "targetname");
  var22 clonebrushmodeltoscriptmodel(var23);
  var22 = spawn("script_model", (-1276, -2416, 1056));
  var22 dontinterpolate();
  var22.angles = (0, 73, 0);
  var22 clonebrushmodeltoscriptmodel(var23);
  var22 = spawn("script_model", (-1558, -1854, 1062));
  var22 dontinterpolate();
  var22.angles = (322, 0, 0);
  var22 clonebrushmodeltoscriptmodel(var23);
  var22 = spawn("script_model", (-1560, -1576, 1140));
  var22 dontinterpolate();
  var22.angles = (0, 340, 0);
  var22 clonebrushmodeltoscriptmodel(var23);
  var22 = spawn("script_model", (-1398, -754, 790));
  var22 dontinterpolate();
  var22.angles = (0, 20, 0);
  var22 clonebrushmodeltoscriptmodel(var23);
  var24 = spawn("script_model", (-2416, -1832, 992));
  var24 dontinterpolate();
  var24.angles = (0, 0, 0);
  var25 = getEnt("clip32x32x256", "targetname");
  var24 clonebrushmodeltoscriptmodel(var25);
  var24 = spawn("script_model", (-860, -2234, 1106));
  var24 dontinterpolate();
  var24.angles = (0, 0, -122);
  var24 clonebrushmodeltoscriptmodel(var25);
  var24 = spawn("script_model", (-872, -2234, 1106));
  var24 dontinterpolate();
  var24.angles = (0, 0, -122);
  var24 clonebrushmodeltoscriptmodel(var25);
  var20 = spawn("script_model", (-844, -2230, 1200));
  var20 dontinterpolate();
  var20.angles = (5.295, 2.825, -151.869);
  var20 clonebrushmodeltoscriptmodel(var21);
  var24 = spawn("script_model", (-584, -2656, 1010));
  var24 dontinterpolate();
  var24.angles = (0, 0, 0);
  var24 clonebrushmodeltoscriptmodel(var25);
  var26 = spawn("script_model", (-458, -1262, 856));
  var26 dontinterpolate();
  var26.angles = (0, 358, 0);
  var27 = getEnt("clip64x64x64", "targetname");
  var26 clonebrushmodeltoscriptmodel(var27);
  var26 = spawn("script_model", (-522, -1264, 858));
  var26 dontinterpolate();
  var26.angles = (0, 358, 0);
  var26 clonebrushmodeltoscriptmodel(var27);
  var26 = spawn("script_model", (-586, -1264, 858));
  var26 dontinterpolate();
  var26.angles = (0, 358, 0);
  var26 clonebrushmodeltoscriptmodel(var27);
  var28 = spawn("script_model", (-770, -2490, 936));
  var28 dontinterpolate();
  var28.angles = (0, 316, 0);
  var29 = getEnt("clip64x64x256", "targetname");
  var28 clonebrushmodeltoscriptmodel(var29);
  var30 = spawn("script_model", (-2428.32, -1977.25, 1154.54));
  var30 dontinterpolate();
  var30.angles = (90, 0, 0);
  var31 = getEnt("player256x256x8", "targetname");
  var30 clonebrushmodeltoscriptmodel(var31);
  var30 = spawn("script_model", (-2392.32, -2225.25, 1186.54));
  var30 dontinterpolate();
  var30.angles = (90, 16, 0);
  var30 clonebrushmodeltoscriptmodel(var31);
  var30 = spawn("script_model", (-2484.87, -2310.06, 1206.56));
  var30 dontinterpolate();
  var30.angles = (0, 40, -90);
  var30 clonebrushmodeltoscriptmodel(var31);
  var30 = spawn("script_model", (-2664.87, -2490.06, 1206.56));
  var30 dontinterpolate();
  var30.angles = (0, 50, -90);
  var30 clonebrushmodeltoscriptmodel(var31);
  var32 = spawn("script_model", (-774.51, -2733.74, 1228));
  var32 dontinterpolate();
  var32.angles = (0, 0, 0);
  var33 = getEnt("clip128x128x128", "targetname");
  var32 clonebrushmodeltoscriptmodel(var33);
  var32 = spawn("script_model", (-598.51, -2733.74, 1260));
  var32 dontinterpolate();
  var32.angles = (0, 0, 0);
  var32 clonebrushmodeltoscriptmodel(var33);
  var32 = spawn("script_model", (-771.37, -2736.12, 1292));
  var32 dontinterpolate();
  var32.angles = (0, 0, 0);
  var32 clonebrushmodeltoscriptmodel(var33);
  var32 = spawn("script_model", (-556.011, -2725.13, 1236));
  var32 dontinterpolate();
  var32.angles = (0, 0, 0);
  var32 clonebrushmodeltoscriptmodel(var33);
  var34 = getEnt("clip256x256x256", "targetname");
  var35 = spawn("script_model", (-3483.93, -718.783, 806.96));
  var35 dontinterpolate();
  var35.angles = (0, 35, 0);
  var35 clonebrushmodeltoscriptmodel(var34);
  var35 disconnectPaths();
  var35 = spawn("script_model", (-2771.93, -1110.78, 894.96));
  var35 dontinterpolate();
  var35.angles = (0, 35, 0);
  var35 clonebrushmodeltoscriptmodel(var34);
  var35 disconnectPaths();
  var35 = spawn("script_model", (-2444.24, -2349.37, 1094.7));
  var35 dontinterpolate();
  var35.angles = (0, 0, 0);
  var35 clonebrushmodeltoscriptmodel(var34);
  var35 disconnectPaths();
  var35 = spawn("script_model", (-2818.05, -2866.49, 1124.31));
  var35 dontinterpolate();
  var35.angles = (0, 0, 0);
  var35 clonebrushmodeltoscriptmodel(var34);
  var35 disconnectPaths();
  var35 = spawn("script_model", (-2690.05, -2866.49, 1124.31));
  var35 dontinterpolate();
  var35.angles = (0, 0, 0);
  var35 clonebrushmodeltoscriptmodel(var34);
  var35 disconnectPaths();
  var36 = spawn("script_model", (-2384.71, -2441.04, 1112.77));
  var36.angles = (7.43938, 99.1471, 18.1777);
  var36 setModel("veh8_mil_air_blima_static_dst");
  var36 = spawn("script_model", (-2750.08, -2884.09, 1140.8));
  var36.angles = (352.628, 9.14556, 15.7999);
  var36 setModel("veh8_mil_air_blima_static_dst");
  var36 = spawn("script_model", (-2789.97, -1137.88, 986.641));
  var36.angles = (11.3127, 352.884, -15.6063);
  var36 setModel("veh8_mil_air_blima_static_dst");
  var36 = spawn("script_model", (-3460.21, -682.763, 883.417));
  var36.angles = (359.425, 175.707, -12.8315);
  var36 setModel("veh8_mil_air_blima_static_dst");
  var37 = spawn("script_model", (-805.316, -2706.05, 1226));
  var37.angles = (0, 180, -8);
  var37 setModel("un_industrial_wooden_pallet_stack_01");
  var37 = spawn("script_model", (-805.316, -2704.05, 1258));
  var37.angles = (350, 90, 0);
  var37 setModel("un_industrial_wooden_pallet_stack_01");
  var38 = spawn("script_model", (-599, -2671, 1306));
  var38.angles = (0, 0, 0);
  var38 setModel("uk_windows_exterior_metal_bar_01");
  var39 = spawn("script_model", (-1185.97, -1429.64, 1053.96));
  var39 setModel("highway_flag0_hero");
  var39.angles = (0, 135.999, 15.2997);
  var40 = getEntArray("mortars_start_model", "targetname");

  foreach(var42 in var40) {
    if(var42.origin == (-1313.04, 12624.6, -1027.39)) {
      var42 delete();
    }
  }

  var44 = [(-4262.21, -2103.35, 1029.15), (-4262.21, -2151.35, 1027.82), (-4270.21, -2199.35, 1024.57), (-4270.21, -2239.35, 1030.85)];
  var45 = [(-4088.65, -2766.21, 1109.15), (-4040.65, -2766.21, 1107.82), (-3992.65, -2774.21, 1104.57), (-3952.65, -2782.21, 1110.85)];
  var46 = [(0, 180, 0), (0, 180, 0), (0, 180, 0), (0, 180, 0)];
  var47 = scripts\engine\utility::getStructArray("enemy_spawner", "targetname");
  var48 = scripts\engine\utility::getStructArray("smoke_enemy_spawner", "targetname");
  var47 = scripts\engine\utility::array_combine(var47, var48);

  for(var8 = 0; var8 < var44.size; var8++) {
    var49 = var44[var8];
    var50 = var45[var8];
    var51 = var46[var8];

    foreach(var53 in var47) {
      if(var53.origin != var49) {
        continue;
      }

      var53.origin = var50;
      var53.angles = var51;
      break;
    }
  }

  var44 = [(-3942.21, -847.355, 916.54), (-3942.21, -895.355, 930.206), (-3950.21, -943.355, 947.497), (-3950.21, -983.355, 963.497)];
  var45 = [(-3824, -704, 896), (-3776, -704, 896), (-3728, -712, 896), (-3688, -712, 888)];
  var51 = [(0, 180, 0), (0, 180, 0), (0, 180, 0), (0, 180, 0)];

  for(var8 = 0; var8 < var44.size; var8++) {
    var49 = var44[var8];
    var50 = var45[var8];
    var51 = var46[var8];

    foreach(var53 in var47) {
      if(var53.origin != var49) {
        continue;
      }

      var53.origin = var50;
      var53.angles = var51;
      break;
    }
  }

  var44 = [(-3374.21, -1183.35, 990.46), (-3374.21, -1231.35, 994.262), (-3382.21, -1279.35, 998.008), (-3382.21, -1319.35, 1005.29)];
  var45 = [(-3048, -1096, 1002.7), (-3000, -1104, 1001.98), (-2952, -1112, 996.719), (-2912, -1120, 998.522)];
  var51 = [(0, 180, 0), (0, 180, 0), (0, 180, 0), (0, 180, 0)];

  for(var8 = 0; var8 < var44.size; var8++) {
    var49 = var44[var8];
    var50 = var45[var8];
    var51 = var46[var8];

    foreach(var53 in var47) {
      if(var53.origin != var49) {
        continue;
      }

      var53.origin = var50;
      var53.angles = var51;
      break;
    }
  }

  var44 = [(-3270.21, -2279.35, 1068.57), (-3270.21, -2319.35, 1069.8), (-3942.21, -1319.35, 1034.04)];
  var45 = [(-3127.35, -3017.79, 1170.2), (-3167.35, -3017.79, 1167.58), (-3112, -64, 712)];
  var51 = [(0, 360, 0), (0, 360, 0), (0, 0, 0)];

  for(var8 = 0; var8 < var44.size; var8++) {
    var49 = var44[var8];
    var50 = var45[var8];
    var51 = var46[var8];

    foreach(var53 in var47) {
      if(var53.origin != var49) {
        continue;
      }

      var53.origin = var50;
      var53.angles = var51;
      break;
    }
  }
}

function syringe_inject() {
  wait 2.5;
  playFX(level._effect["vfx_hway_car_fire_1"], (-3124.65, -2680.78, 1100.46));
  waitframe();
  playFX(level._effect["vfx_hway_car_fire_1"], (-4658.99, -2590.47, 1068.88));
  waitframe();
  playFX(level._effect["vfx_hway_car_fire_1"], (-4477.19, -2970.69, 1109.02));
  waitframe();
  playFX(level._effect["vfx_hway_car_fire_1"], (-2649.79, -2934.28, 1167.31));
}

function onplayerspawn() {
  scripts\cp\gametypes\cp_specops::givedefaultloadout();
  var0 = ref_1249d();
  self giveweapon(var0);
  self setweaponammoclip(var0, weaponclipsize(var0));
  self setweaponammostock(var0, weaponmaxammo(var0));
  self switchtoweapon(var0);
  var1 = ref_1249e();
  self giveweapon(var1);
  self setweaponammoclip(var1, weaponclipsize(var1));
  self setweaponammostock(var1, weaponmaxammo(var1));
  level.hostdamagefactorlow++;

  if(!getdvarint("scr_highway_skip_intro")) {
    trial_shooters_quota();
    return;
  }
}

function ref_1249d() {
  var0 = scripts\cp\cp_weapon::buildweapon_variant("iw8_ar_mike4", "none", "none", 1);
  var0 = var0 withattachment("cos_001");
  var0 = var0 withoutattachment("holo_west01");
  var0 = var0 withattachment("hybrid_west03_irons");
  return var0;
}

function ref_1249e() {
  return scripts\cp\cp_weapon::buildweapon("iw8_pi_mike1911_mp", ["brake_mike1911", "slide_tritium_mike1911", "barlong_mike1911"], "none", "none", 1);
}

function ref_1249f(var0) {
  var1 = scripts\cp\cp_weapon::buildweapon_variant("iw8_sn_hdromeo", "none", "none", var0);
  var1 = var1 withattachment("cos_001");
  var1 = var1 withattachment("vzscope_hdromeo");
  var1 = var1 withattachment("xmagslrg_hdromeo");
  var1 = var1 withattachment("barmid_hdromeo");
  return var1;
}

function trial_shooters_quota() {
  if(scripts\engine\utility::flag("intro_heli_crashing")) {
    return;
  }

  var0 = ["tag_guy5", "tag_guy6", "tag_guy7", "tag_guy8"];
  var1 = [(3, -10, -25), (3, 10, -25), (3, 10, -25), (3, -10, -25)];
  var2 = [40, 50, 50, 40];
  var3 = [50, 40, 40, 50];

  if(!isDefined(level.trial_shooters.ref_13a26)) {
    level.trial_shooters.ref_13a26 = [];
  }

  var4 = undefined;
  var5 = undefined;

  foreach(var7 in var0) {
    if(isDefined(level.trial_shooters.ref_13a26[var7])) {
      continue;
    }

    level.trial_shooters.ref_13a26[var7] = 1;
    var4 = var7;
    var5 = var8;
    break;
  }

  var9 = var1[var5];
  var10 = var2[var5];
  var11 = var3[var5];
  var12 = scripts\cp\laser_traps\cp_laser_traps::ref_124e9(self, "player");
  var12 linkTo(level.trial_shooters, var4, var9, (0, 0, 0));
  self playerlinktodelta(var12, "tag_player", 1, 0, 0, 0, 0, 1, 1, 1);
  self lerpviewangleclamp(1, 0.25, 0.25, var10, var11, 80, 80);
  waitframe();
  thread trial_small_fire(self, var12);
  level.trial_shooters waittill("stop_heli_spin");
  self unlink();
  var12 delete();
}

function trial_small_fire(var0, var1) {
  var0 endon("death_or_disconnect");
  var1 endon("entitydeleted");

  for(;;) {
    var1 scripts\cp\cp_anim::anim_player_solo(var0, var1, "intro_idle");
  }
}

function registerscriptedagents() {
  scripts\mp\mp_agent::init_agent("mp/iw8_default_agent_definition.csv");
  scripts\mp\agents\soldier\soldier_agent::registerscriptedagent();
  scripts\mp\agents\juggernaut\juggernaut_agent::registerscriptedagent();
}

function interaction_trigger_properties(var0, var1, var2) {
  switch (var1.script_noteworthy) {
    default:
      self.interaction_trigger setusefov(360);
      self.interaction_trigger sethintrequiresholding(0);

      if(isDefined(var1.useduration)) {
        self.interaction_trigger setuseholdduration(var1.useduration);
      }

      break;
  }
}

function intro_main() {
  skipburndownlow();
  var0 = getaiarray("axis");
  scripts\engine\utility::array_thread(var0, &scripts\cp\laser_traps\cp_laser_traps::ks_pointstowin);
  var1 = scripts\cp\utility::create_client_overlay("black", 1);
  var2 = scripts\engine\utility::getStructArray("default_player_start", "targetname");

  foreach(var4 in level.players) {
    var4 unlink();
    var4 freezecontrols(1);
    var4 setOrigin(var2[var5].origin);
    var4 setplayerangles(var2[var5].angles);
    var4 allowstand(1);
    var4 allowmovement(0);
    var4 setclientomnvar("ui_hide_hud", 1);
  }

  scripts\engine\utility::delaythread(4, &ref_12758, "dx_cps_lass_callout_enemy_squad_spawning_30");
  var6 = 5;
  wait var6;

  foreach(var4 in level.players) {
    var4 freezecontrols(0);
    var4 allowmovement(1);
    var4 shellshock("default_nosound", 3);
    var4 playRumbleOnEntity("damage_heavy");
    var4 clearaccessory();
    var4 takeallweapons();
    var8 = "iw8_pi_mike1911_mp";
    var9 = scripts\cp\cp_weapon::buildweapon(var8, undefined, "none", "none", 1);
    var4 giveweapon(var9);
    var4 switchtoweapon(var9);
    var4.loadoutaccessoryweapon = var4 scripts\cp\cp_loadout::cac_getaccessoryweapon();
    var4.loadoutaccessorydata = var4 scripts\cp\cp_loadout::cac_getaccessorydata();
    var4.loadoutaccessorylogic = var4 scripts\cp\cp_loadout::force_interrupt_all_current_combat_actions();

    if(isDefined(var4.loadoutaccessorydata) && isDefined(var4.loadoutaccessoryweapon) && var4.loadoutaccessoryweapon != "none") {
      var4 scripts\cp\cp_accessories::giveplayeraccessory(var4.loadoutaccessorydata, var4.loadoutaccessoryweapon, var4.loadoutaccessorylogic);
    }

    var4 setclientomnvar("ui_hide_hud", 0);
  }

  set_objective("survive");
  var11 = 5;
  var1 fadeovertime(var11);
  var1.alpha = 0;
  var1 scripts\engine\utility::delaycall(var11, &destroy);
  var12 = [3, 6, 8, 10];
  var13 = scripts\engine\utility::getStructArray("intro_enemy_spawner", "targetname");
  var13 = scripts\engine\utility::array_randomize(var13);
  var0 = [];
  var14 = var12[level.players.size - 1];

  foreach(var16 in var13) {
    if(var20 >= var14) {
      break;
    }

    var17 = var16 scripts\cp\laser_traps\cp_laser_traps::spawn_ai();
    var18 = scripts\engine\utility::random(level.players);
    var17 setgoalentity(var18);
    var17.goalradius = 300;
    var19 = var17 scripts\cp\laser_traps\cp_laser_traps::print_spawner_score_for_factor();
    var17 scripts\cp\laser_traps\cp_laser_traps::set_baseaccuracy(0);
    var17 scripts\engine\utility::delaythread(5, &scripts\cp\laser_traps\cp_laser_traps::set_baseaccuracy, var19);
    var0 = scripts\engine\utility::array_add(var0, var17);
  }

  scripts\cp\laser_traps\cp_laser_traps::ref_13067();
  scripts\engine\utility::array_wait(var0, "death");
}

function jumpscenenode() {
  var0 = [(-1406.52, -1537.56, 1154.25), (-520.306, -1863.58, 1193.75)];
  var1 = [(0, 162.743, 0), (0, 182.744, 0)];

  for(var2 = 0; var2 < var0.size; var2++) {
    scripts\cp\laser_traps\cp_laser_traps::brplayerhudoutlineforteammatesupdate(var0[var2], var1[var2]);
  }

  var3 = (-1354.86, -1406.15, 1017.5);
  var4 = (0, 160.849, 0);
  scripts\cp\laser_traps\cp_laser_traps::handle_leads_collected_hideiconbuilding(var3, var4);
  var5 = (-521.718, -1719.51, 1041.5);
  var6 = (0, 179.765, 0);
  scripts\cp\laser_traps\cp_laser_traps::ref_11cb8(var5, var6);
  var7 = scripts\cp\laser_traps\cp_laser_traps::binoculars_getpendingtime((-721.301, -1094.8, 834.118), (354.711, 3.04249, -28.3572));
  setheadiconsnaptoedges(var7.headiconid, 800);
}

function jumped() {
  level.ref_12db9 = 1;
  jumpscenenode();
  scripts\engine\utility::delaythread(4, &ref_12758, "dx_cps_lass_bank_enemy_reinforcements_10");
  scripts\engine\utility::delaythread(8, &weapon_xp_iw8_sm_augolf);
  israndompistolloadouts();
  var0 = 45;
  wait var0;
  var1 = 25;
  var2 = 20;
  var3 = 10;
  var4 = 2;
  var5 = 6;
  var6 = 7;
  var8 = ["dx_cps_lass_callout_mortar_attacking_10", "dx_cps_lass_callout_mortar_attacking_20"];
  var9 = ["dx_cps_lass_bank_enemies_vehicle_10", "dx_cps_lass_bank_enemy_reinforcements_10"];
  var10 = ["dx_mpa_ustl_hint_killall", "dx_mpa_ustl_kh_sniper_hurryup"];
  var11 = ["dx_mpa_ustl_exfillosing_start_winningteam", "dx_mpa_ustl_exfillosing_end_winningteam"];

  for(;;) {
    var12 = int(tablelookupbyrow("scripts/cp/maps/cp_so_highway/cp_so_highway_round_mortars.csv", level.ref_12db9, level.players.size));

    if(var12 > 0) {
      var13 = var8[0];

      if(isDefined(var13)) {
        scripts\engine\utility::delaythread(6, &ref_12758, var13);
        var8 = scripts\engine\utility::array_remove(var8, var13);
      }

      thread ref_12dab(var12);
      var14 = var3 * var12;
      var14 *= 1 / level.players.size;
      wait var14;
    }

    var15 = var9[0];

    if(isDefined(var15)) {
      thread ref_12758(var15);
      var9 = scripts\engine\utility::array_remove(var9, var15);
    }

    var16 = var10[0];

    if(isDefined(var16)) {
      scripts\engine\utility::delaythread(7, &ref_12758, var16);
      var10 = scripts\engine\utility::array_remove(var10, var16);
    }

    thread ref_12db2();
    wait var2;
    thread ref_12db0();
    ref_12db1();
    thread ref_12da7();
    ref_12db6();

    if(!ref_12da5()) {
      if(level.ref_12db9 == var4) {
        ref_12dad();
      } else {
        ref_12da6();
      }

      var17 = var11[0];

      if(isDefined(var17)) {
        scripts\engine\utility::delaythread(2, &ref_12758, var17);
        var11 = scripts\engine\utility::array_remove(var11, var17);
      }

      var18 = randomfloatrange(var5, var6);
      wait var18;
    }

    level notify("level_round_over");
    var19 = ref_12da9();

    foreach(var21 in var19) {
      if(!isDefined(var21)) {
        continue;
      }

      var21 delete();
    }

    level.ref_12db9++;

    if(level.ref_12db9 > 3) {
      break;
    }

    var23 = ["dx_mpa_ustl_airdrop_achieve", "dx_mpa_ustl_airdrop_friendly_use"];
    var24 = scripts\engine\utility::random(var23);
    scripts\engine\utility::delaythread(3, &ref_12758, var24);
    scripts\engine\utility::delaythread(6, &weapon_xp_iw8_sm_augolf);
    wait var1;
  }
}

function ref_12da5() {
  return level.ref_12db9 == 3;
}

function ref_12dad() {
  var0 = 6;
  var1 = 0.5;
  var2 = 1;
  var3 = scripts\engine\utility::getStructArray("smoke_end_struct", "targetname");

  foreach(var5 in var3) {
    magicgrenademanual("smoke_grenade_mp", var5.origin, (0, 0, 4), 0.05);
    var6 = randomfloatrange(var1, var2);
    wait var6;
  }

  foreach(var9 in level.players) {
    magicgrenademanual("smoke_grenade_mp", var9.origin, (0, 0, -4), 0.05);
    var9 visionsetnakedforplayer("cp_so_highway_smoke", var0);
  }

  wait var0;
  var11 = ref_11d38();

  foreach(var13 in var11) {
    var13 scripts\cp\laser_traps\cp_laser_traps::ks_pointstowin();
  }

  thread ref_12daf();
  thread ref_12dae();
  var15 = [0, 40, 60, 70, 80];
  var16 = var15[level.players.size];
  var17 = scripts\engine\utility::getStructArray("smoke_enemy_spawner", "targetname");

  while(var16 > 0) {
    var18 = var17[randomint(var17.size)];
    var19 = var18 scripts\cp\laser_traps\cp_laser_traps::spawn_ai();

    if(isDefined(var19)) {
      var16--;
    }

    wait 1;
  }

  ref_12db6();
  ref_12da6();

  foreach(var9 in level.players) {
    var9 visionsetnakedforplayer("", 60);
  }
}

function ref_12daf() {
  level endon("level_enemies_fallback");
  level endon("level_round_over");
  var0 = 5;
  wait var0;
  var1 = level.players;
  var2 = 12;
  var3 = 30;
  var4 = max(var2, var3 / var1.size);
  var5 = 7;
  var6 = 1;
  var7 = 3;

  for(;;) {
    var8 = getaiarray("axis");

    if(var8.size < var5) {
      waitframe();
      continue;
    }

    var9 = scripts\engine\utility::random(var1);
    var10 = randomintrange(var6, var7);

    for(var11 = 0; var11 < var10; var11++) {
      var12 = var9.origin + (0, 0, 300) + scripts\engine\utility::randomvectorrange(15, 30);
      var8[0].grenadeweapon = getcompleteweaponname("semtex_mp");
      var8[0] magicgrenademanual(var12, (0, 0, -5), 2);
    }

    var1 = scripts\engine\utility::array_remove(var1, var9);

    if(!var1.size) {
      var1 = level.players;
    }

    wait var4;
  }
}

function ref_12dae() {
  level endon("level_enemies_fallback");
  level endon("level_round_over");
  var0 = 8;
  wait var0;
  var1 = level.players;
  var2 = 14;
  var3 = 33;
  var4 = max(var2, var3 / var1.size);
  var5 = [(-648.919, -1298.07, 1746.41), (-538.559, -1801.64, 2024), (-1434.56, -1993.64, 2056), (-1402.56, -1497.64, 2024)];
  var6 = [(19.625, 267.558, 0), (90, 0, 90), (90, 0, 90), (90, 0, 90)];
  var7 = [5000, 1, 1, 1];
  var8 = 7;

  for(;;) {
    var9 = getaiarray("axis");

    if(var9.size < var8) {
      waitframe();
      continue;
    }

    for(var10 = 0; var10 < var5.size; var10++) {
      var11 = var5[var10];
      var12 = anglesToForward(var6[var10]) * var7[var10];
      var9[0].grenadeweapon = getcompleteweaponname("molotov_mp");
      var13 = var9[0] magicgrenademanual(var11, var12);
      var9[0] scripts\cp\powers\coop_molotov::molotov_used(var13);
    }

    wait var4;
  }
}

function ref_12db2() {
  level endon("level_round_over");
  var0 = getEntArray("vehicle_spawn", "targetname");
  var0 = scripts\engine\utility::array_randomize(var0);
  var1 = int(tablelookupbyrow("scripts/cp/maps/cp_so_highway/cp_so_highway_round_vehicles.csv", level.ref_12db9, level.players.size));
  var2 = 2;
  var3 = 1;

  while(var1 > 0) {
    if(!var0.size) {
      return;
    }

    var4 = var0[0];
    var5 = var4 scripts\common\utility::spawn_vehicle();

    if(!isDefined(var5.riders)) {
      var5 waittill("spawnedRiders");
    }

    var6 = 0;

    foreach(var8 in var5.riders) {
      if(var8.vehicle_position != 0) {
        continue;
      }

      var6 = 1;
      break;
    }

    if(!istrue(var6)) {
      var5 delete();
      wait var3;
      continue;
    }

    var1--;
    thread ref_12db4(var5);
    var0 = scripts\engine\utility::array_remove(var0, var4);
    var0 = sortbydistance(var0, var4.origin);
    wait var2;
  }
}

function ref_1420c() {
  self endon("death");
  self waittill("jumpedout");
  thread nodetype();
}

function ref_12db0() {
  level endon("level_enemies_fallback");
  level endon("level_round_over");
  var0 = int(tablelookupbyrow("scripts/cp/maps/cp_so_highway/cp_so_highway_round_bombers.csv", level.ref_12db9, level.players.size));

  if(var0 <= 0) {
    return;
  }

  var1 = 14;
  wait var1;
  var2 = 4;
  var3 = 8;
  ref_12758("dx_cps_lass_callout_suicide_bomber_spawning_20");
  var4 = [(-3158.13, -1064.1, 994.668), (-3167.07, -3017.07, 1171.24)];

  while(var0 > 0) {
    var5 = scripts\engine\utility::random(var4);
    var6 = scripts\cp\laser_traps\cp_laser_traps::ref_134f1("enemy_cp_alq_desert_bomber", var5, (0, 0, 0), 1);

    if(isDefined(var6)) {
      var0--;
    }

    var7 = randomfloatrange(var2, var3);
    wait var7;
  }
}

function ref_12da6() {
  level notify("level_enemies_fallback");
  var0 = getaiarray("axis");
  var1 = scripts\engine\utility::getStructArray("enemy_retreat_struct", "targetname");

  foreach(var3 in var0) {
    if(istrue(var3.stadium_two_death_func)) {
      continue;
    }

    var1 = sortbydistance(var1, var3.origin);
    thread nextdest(var3);
  }
}

function ref_12da7() {
  level endon("level_enemies_fallback");
  var0 = randomfloatrange(10, 15);
  wait var0;
  var1 = 0.2;
  var2 = 0.5;
  var3 = 2.25;
  var4 = 3.55;
  var5 = 2;
  var6 = 4;

  for(;;) {
    var7 = randomintrange(var5, var6);
    var8 = getaiarray("axis");

    foreach(var10 in var8) {
      if(!isDefined(var10)) {
        continue;
      }

      if(!isalive(var10)) {
        continue;
      }

      if(var10 islinked()) {
        continue;
      }

      if(istrue(var10.stadium_two_death_func)) {
        continue;
      }

      GscBinSkip4(0x6e, var10);
    }

    var13 = randomfloatrange(var3, var4);
    wait var13;
  }
}

function ref_12db4(var0) {
  var0 endon("death");
  var0 endon("entitydeleted");
  var0.targetname = "level_vehicle";
  var0 vehicleshowonminimap(1);
  var0 aiupdatecoverexposetype(1);
  scripts\cp\cp_weapon::add_to_special_lockon_target_list(var0);
  GscBinSkip4(0x35, var0);
}

function ref_12db5(var0) {
  var1 = "vehicle_resume_speed";
  var0 scripts\engine\utility::ent_flag_init(var1);
  thread scripts\common\vehicle_paths::gopath(var0);
  var0 scripts\engine\utility::ent_flag_wait(var1);
  var0 resumespeed(7);
}

function ref_12da9() {
  return getEntArray("level_vehicle", "targetname");
}

function weapon_xp_iw8_sm_augolf() {
  var0 = int(tablelookupbyrow("scripts/cp/maps/cp_so_highway/cp_so_highway_killstreaks.csv", level.ref_12db9, level.players.size));

  if(var0 == 1) {
    thread ref_12758("dx_mpo_usop_airdrop_use");
  } else if(var0 > 1) {
    thread ref_12758("dx_mpo_usop_airdrop_multiple_use");
  }

  var1 = 2;
  wait var1;
  var2 = scripts\engine\utility::getStructArray("level_carepackage_heli_drop_struct", "targetname");
  var3 = spawnStruct();
  var3.origin = (-1229.57, -1160.71, 2000);
  var3.angles = (0, 180, 0);
  var3.script_radius = 20000;
  var3.script_index = 3;
  var2 = scripts\engine\utility::array_add(var2, var3);
  var2 = scripts\cp\laser_traps\cp_laser_traps::can_play_ending(var2);
  var4 = scripts\cp\laser_traps\cp_laser_traps::get_drone_target_loc();
  var5 = squared(70);

  for(var6 = 0; var6 < var0; var6++) {
    var7 = var2[var6].script_radius;
    var8 = var2[var6].script_radius;
    var9 = var2[var6].angles;
    var10 = var2[var6].origin;

    for(;;) {
      var11 = 1;

      foreach(var13 in var4) {
        if(distance2dsquared(var13.origin, var10) > var5) {
          continue;
        }

        var11 = 0;
        break;
      }

      if(var11) {
        break;
      }

      var10 += (60, 0, 0);
    }

    thread scripts\cp\laser_traps\cp_laser_traps::get_driver_interaction_hint_string(var7, var8, var9, var10, undefined, &weapon_xp_iw8_sm_charlie9);
    wait 3;
  }
}

function weapon_xp_iw8_sm_charlie9(var0, var1, var2) {
  if(!isDefined(var2)) {
    if(!isDefined(level.ref_12a94)) {
      level.ref_12a94 = [];
    }

    if(!isDefined(var0.ref_12881)) {
      var0.ref_12881 = [];
    }

    var3 = tablelookupbyrow("scripts/cp/maps/cp_so_highway/cp_so_highway_killstreaks.csv", level.ref_12db9, 6);
    var3 = strtok(var3, " ");
    var4 = tablelookupbyrow("scripts/cp/maps/cp_so_highway/cp_so_highway_killstreaks.csv", level.ref_12db9, 5);
    var4 = strtok(var4, " ");

    if(var3.size) {
      foreach(var6 in var3) {
        if(!scripts\engine\utility::array_contains(level.ref_12a94, var6)) {
          continue;
        }

        var3 = scripts\engine\utility::array_remove(var3, var6);
      }
    }

    if(var3.size) {
      var8 = var3;
    } else {
      var8 = var8;
    }

    var8 = scripts\engine\utility::array_remove_array(var8, var1.ref_12881);

    if(!var8.size) {
      var8 = var8;
    }

    var3 = scripts\engine\utility::random(var8);
  }

  if(!scripts\engine\utility::array_contains(level.ref_12a94, var3)) {
    level.ref_12a94 = scripts\engine\utility::array_add(level.ref_12a94, var3);
  }

  var1.ref_12881 = scripts\engine\utility::array_add(var1.ref_12881, var3);
  var9 = "weapon_";

  if(getsubstr(var3, 0, var9.size) == var9) {
    var10 = spawn(var3, var2 + (0, 0, 25));
    var10 itemweaponsetammo(weaponclipsize(var10), weaponmaxammo(var10));
    var10 physicslaunchserveritem(var10.origin, (0, 0, 2000));
    return;
  }

  scripts\cp\laser_traps\cp_laser_traps::ref_124a5(var1, var3);
}

function initarmsraceanims(var0) {
  return (0, 1, 0);
}

function ref_12758(var0) {
  if(!isDefined(level.ref_121a7)) {
    level.ref_121a7 = spawn("script_origin", (0, 0, 0));
  }

  level.ref_121a7 stopsounds();
  var1 = lookupsoundlength(var0) * 0.001;
  level.ref_121a7 playSound(var0);
  wait var1;
}

function ref_1437b() {
  scripts\cp\laser_traps\cp_laser_traps::ref_1437a();
}

function mud_sfx(var0) {
  if(var0 == "axis") {
    return 0;
  }

  var1 = 60000;

  if(level.time_survived < 10 * var1) {
    return 3;
  } else if(level.time_survived < 15 * var1) {
    return 2;
  }

  return 1;
}

function skipburndownlow() {
  var0 = getEnt("intro_heli", "targetname");
  var1 = var0 scripts\common\utility::spawn_vehicle();
  var1 setmaxpitchroll(10, 25);
  level.trial_shooters = var1;
  thread skip_overheat();
  var1 scripts\common\vehicle::godon();
  var1.script_team = "allies";
  thread skipprematch();
  thread trial_special_vfx();
  var2 = missile_createrepulsorent(var1, 5000, 1000);
  var3 = getEntArray("intro_heli_destroyed", "targetname");

  foreach(var5 in var3) {
    var5 hide();
  }

  ref_1437b();

  foreach(var8 in level.players) {
    scripts\cp\laser_traps\cp_laser_traps::ref_12486(var8);
    var8 setsoundsubmix("cp_infil_duck_vehicles", 0.5);
  }

  scripts\engine\utility::delaythread(1, &ref_12758, "dx_mpa_ustl_order_attack");
  var10 = level.vehicle.templates.aianims[var1 scripts\common\vehicle_code::get_vehicle_classname()];
  var11 = var10[0].vehicle_getoutanim;
  thread scripts\cp\vehicle::matchdata_logweaponstat(var1, var11);
  var12 = 11;
  wait var12;
  scripts\engine\utility::delaythread(4, &ref_12758, "dx_mpa_ustl_under_attack_friendly_heli");
  scripts\engine\utility::flag_set("intro_heli_can_crash");
  missile_deleteattractor(var2);
  waitframe();
  var13 = missile_createattractorent(var1, 999999, 2000);

  for(;;) {
    var1 waittill("damage", var14, var14, var14, var14, var14, var14, var14, var14, var14, var15);
  }

  LOC_00000184:
    scripts\engine\utility::delaythread(1.5, &ref_12758, "dx_mpa_ustl_destroyed_friendly_heli");
  missile_deleteattractor(var13);
  var1 notify("stop_flyloop");
  scripts\engine\utility::flag_set("intro_heli_crashing");
  heli_crash(var1, var3);
  scripts\cp\laser_traps\cp_laser_traps::little_bird_mg_cp_ondeathrespawncallback();
}

function skipprematch(var0) {
  self notify("stop_heli_screenshake");
  self endon("stop_heli_screenshake");
  self endon("death");

  if(istrue(var0)) {
    var1 = 0.45;
    goto LOC_00000031;
  }

  var1 = 0.14;

  for(;;) {
    if(istrue(var1)) {
      earthquake(0.3, var1, level.trial_shooters.origin, 5000);

      foreach(var3 in level.players) {
        var3 playRumbleOnEntity("damage_heavy");
      }

      wait var1 * 0.5;
      continue;
    }

    earthquake(0.12, var1, level.trial_shooters.origin, 5000);

    foreach(var3 in level.players) {
      var3 playRumbleOnEntity("damage_light");
    }

    wait var1 * 0.5;
  }
}

function skip_overheat() {
  self endon("stop_flyloop");
  var0 = scripts\engine\utility::getStruct("intro_heli_path1", "targetname");
  var1 = var0;
  self vehicle_setspeed(40, 20);

  for(;;) {
    self setneargoalnotifydist(200);
    self setvehgoalpos(var1.origin);
    scripts\engine\utility::ref_143a5("near_goal", "goal");

    if(isDefined(var1.target)) {
      var1 = scripts\engine\utility::getStruct(var1.target, "targetname");
      continue;
    }

    var1 = var0;
  }
}

function heli_crash(var0) {
  thread skipprematch(1);
  self setmaxpitchroll(25, 25);
  var1 = scripts\engine\utility::getStructArray("intro_heli_deathpath", "script_noteworthy");
  var1 = sortbydistance(var1, self.origin);
  var2 = var1[0];
  thread ref_12758("dx_cps_ushp_rescue_pilot_start_20");
  self playLoopSound("cp_br_syrk_chopper_dying_loop");
  var3 = var2;
  thread heli_spin();
  self vehicle_setspeed(80, 50, 50);
  self setyawspeed(150, 50, 50, 0);
  var4 = "heli_crash_early";
  thread sixthsense_inotherplayertargetcone(self, var4);

  foreach(var6 in level.players) {
    mountain_one_death_func(var6);
  }

  for(;;) {
    self setneargoalnotifydist(200);
    self setvehgoalpos(var3.origin);
    var8 = scripts\engine\utility::ref_143ae("near_goal", "goal", var4);

    if(!isDefined(var3.target) || var8 == var4) {
      break;
    }

    var3 = scripts\engine\utility::getStruct(var3.target, "targetname");
  }

  self notify("stop_heli_spin");
  thread scripts\engine\utility::play_sound_in_space("hind_helicopter_crash_infil", self.origin);

  foreach(var6 in level.players) {
    var6 clearsoundsubmix("cp_infil_duck_vehicles", 2);
  }

  foreach(var12 in var0) {
    var12 show();
  }

  foreach(var6 in level.players) {
    scripts\cp\laser_traps\cp_laser_traps::ref_12484(var6);
    ref_12c5a(var6);
  }

  playFX(level._effect["vfx_hway_car_fire_1"], (-1434.42, -2929.26, 1105.3));
  scripts\engine\utility::delaycall(0.2, &delete);
}

function mountain_one_death_func() {}

function ref_12c5a() {}

function sixthsense_inotherplayertargetcone(var0, var1) {
  var0 endon("stop_heli_spin");
  var2 = scripts\engine\utility::getStructArray("default_player_start", "targetname");
  var3 = scripts\cp\utility\entity::getaverageorigin(var2)[2];

  for(;;) {
    var4 = 0;

    foreach(var6 in level.players) {
      if(var6.origin[2] <= var3) {
        var4 = 1;
        break;
      }
    }

    if(var4) {
      break;
    }

    waitframe();
  }

  var0 notify(var1);
}

function heli_spin() {
  self endon("stop_heli_spin");

  for(;;) {
    self settargetyaw(self.angles[1] - 90);
    wait 1;
  }
}

function trial_special_vfx() {
  while(!isDefined(level.agentarray) || level.agentarray.size < 10) {
    waitframe();
  }

  wait 1;
  var0 = scripts\engine\utility::getStructArray("intro_enemy_initial", "targetname");
  scripts\engine\utility::array_thread(var0, &thermiteradiusdamage);
  var1 = scripts\engine\utility::getStructArray("intro_enemy", "targetname");
  scripts\engine\utility::array_thread(var1, &trial_rpg_settings);
}

function thermiteradiusdamage() {
  var0 = scripts\cp\laser_traps\cp_laser_traps::spawn_ai();

  if(isDefined(var0)) {
    var0 endon("death");
    var0 setentitytarget(level.trial_shooters, 1);
    scripts\engine\utility::flag_wait("intro_heli_crashing");
    var1 = scripts\engine\utility::getStructArray("intro_enemy_spawner", "targetname");
    var1 = sortbydistance(var1, var0.origin);
    var0.ignoreall = 1;
    var0.goalradius = 32;
    var0 setgoalpos(var1[0].origin);
    var0 waittill("goal");
    var0 scripts\cp\laser_traps\cp_laser_traps::ks_pointstowin();
    return;
  }
}

function trial_rpg_settings() {
  level.trial_shooters endon("stop_heli_spin");

  for(;;) {
    var0 = scripts\cp\laser_traps\cp_laser_traps::spawn_ai();

    if(isDefined(var0)) {
      var0.script_forcegoal = 1;
      var0.dontevershoot = 1;
      var0.solospawn = 1;
      var0.goalradius = 20;
      self.rocketammo = 200;
      skipplaybodycountsound(var0);

      if(scripts\engine\utility::flag("intro_heli_crashing")) {
        if(isalive(var0)) {
          thread skipleaderupdate(var0);
        }

        return;
      }
    }

    wait randomfloatrange(1, 3);
  }
}

function skipleaderupdate(var0) {
  self endon("death");
  self.ignoreall = 1;
  self.goalradius = 32;
  self.dontevershoot = 1;
  self setgoalpos(var0.origin);
  self waittill("goal");
  scripts\cp\laser_traps\cp_laser_traps::ks_pointstowin();
}

function skipplaybodycountsound() {
  level endon("intro_heli_crashing");
  self endon("death");
  self waittill("goal");
  self.dontevershoot = 0;
  self setentitytarget(level.trial_shooters, 1);
  self waittill("death");
}

function ref_1216d() {
  thread ref_1216b();
  thread ref_1216c();
  skipignoredamage();
}

function ref_1216b() {
  wait 1.5;
  ref_12758("dx_cps_lass_rescue_hvi_defend_60sec_20");
  wait 3;
  ref_12758("dx_cps_lass_rescue_hvi_defend_30sec_20");
  wait 5;
  ref_12758("dx_cps_lass_plane_exfil_land_nag_10");
}

function ref_1216c() {
  level endon("leave_lz");
  var0 = scripts\engine\utility::getStructArray("enemy_spawner", "targetname");
  var1 = [0, 20, 30, 40, 50];
  var2 = var1[level.players.size];
  var3 = 0.25;

  while(var2 > 0) {
    var4 = var0[randomint(var0.size)];
    var5 = var4 scripts\cp\laser_traps\cp_laser_traps::spawn_ai();

    if(isDefined(var5)) {
      var2--;
    }

    wait var3;
  }

  var6 = [0, 15, 20, 25, 30];
  var7 = var6[level.players.size];
  var8 = 2;

  for(;;) {
    if(getaiarray("axis").size < var7) {
      var4 = var0[randomint(var0.size)];
      var5 = var4 scripts\cp\laser_traps\cp_laser_traps::spawn_ai();
    }

    wait var8;
  }
}

function skipignoredamage() {
  set_objective("exfil");
  var0 = getEnt("exfil_heli_spawner", "targetname");
  var0.vehicletype = "mindia8_minimap";
  var1 = var0 scripts\common\vehicle::spawn_vehicle_and_gopath();
  var1 sethoverparams(0, 0, 0);
  var1 setvehicleteam("allies");
  var2 = scripts\cp\cp_objectives::requestworldid("objective_exfil", 3);
  objective_setdescription(var2, &"CP_SO_HIGHWAY/OBJECTIVE_GET_TO_EXFIL_CHOPPER");
  objective_setplayintro(var2, 1);
  objective_setplayoutro(var2, 0);
  objective_onentity(var2, var1);
  objective_state(var2, "current");
  objective_icon(var2, "icon_waypoint_objective_general");
  var3 = spawn("script_model", var1.origin);
  var3 dontinterpolate();
  var4 = getEnt("care_package_col", "targetname");
  var3 clonebrushmodeltoscriptmodel(var4);
  var3 linkTo(var1, "tag_origin", (-144, 16, -192), (0, 0, 0));
  var3 = spawn("script_model", var1.origin);
  var3 dontinterpolate();
  var4 = getEnt("care_package_col", "targetname");
  var3 clonebrushmodeltoscriptmodel(var4);
  var3 linkTo(var1, "tag_origin", (-144, -16, -192), (0, 0, 0));
  var5 = getEnt("leave_player_trigger", "targetname");
  var5 enablelinkTo();
  var5 linkTo(var1, "tag_origin", (0, 0, 0), (0, 0, 0));
  var1 scripts\common\vehicle::godon();
  var6 = 1500;
  var7 = 0;

  for(;;) {
    var8 = 1;

    foreach(var10 in level.players) {
      if(!isalive(var10)) {
        continue;
      }

      if(!var10 istouching(var5)) {
        var8 = 0;
        break;
      }
    }

    if(var8) {
      if(!var7) {
        var7 = gettime();
      }

      if(gettime() >= var7 + var6) {
        break;
      }
    } else {
      var7 = 0;
    }

    waitframe();
  }

  objective_state(var2, "done");

  foreach(var13 in level.outofboundstriggers) {
    var13.origin -= (0, 0, 10000);
  }

  scripts\engine\utility::flag_set("leave_lz");

  foreach(var10 in level.players) {
    if(!isalive(var10)) {
      continue;
    }

    var16 = var10 scripts\engine\utility::spawn_tag_origin();
    var16 linkTo(var1);
    var10 playerlinkTo(var16, "tag_origin", 0, 180, 180, 180, 180, 0);
  }

  scripts\engine\utility::delaythread(2, &ref_12758, "dx_mpa_ustl_gamestate_lost_health");
  var18 = 4;
  wait var18;
  level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
}

function streampoint() {
  level.hacking_player_nearby = spawnStruct();
  level.hacking_player_nearby.civs = [];
  level.hacking_player_nearby.leader = undefined;
  level.hacking_player_nearby.light_tank_update = [];
  level.hacking_player_nearby.light_tank_stopwatchingmissileinputchange = [];
  level.hacking_player_nearby.light_tank_update["stayhere"] = ["dx_sohwy_civ_stayhere1", "dx_sohwy_civ_stayhere2"];
  level.hacking_player_nearby.light_tank_stopwatchingmissileinputchange["stayhere"] = 0;
  level.hacking_player_nearby.light_tank_update["followme"] = ["dx_sohwy_civ_follow1", "dx_sohwy_civ_follow2", "dx_sohwy_civ_follow3", "dx_sohwy_civ_follow4"];
  level.hacking_player_nearby.light_tank_stopwatchingmissileinputchange["followme"] = 0;
}

function spawn_civ(var0, var1) {
  var2 = var0 scripts\cp\laser_traps\cp_laser_traps::ref_134f1("civilian_cp_desert", var0.origin, var0.angles);

  if(isDefined(var2)) {
    level.hacking_player_nearby.civs[level.hacking_player_nearby.civs.size] = var2;

    if(isDefined(var1.radius)) {
      var2.goalradius = var1.radius;
    } else {
      var2.goalradius = 200;
    }

    var2 setgoalpos(var1.origin);
    thread hacking_lua_notify_func();
    thread hackclientomnvarclamp();
    return;
  }
}

function hacking_lua_notify_func() {
  level endon("civ_exit");
  self endon("death");
  self endon("stop_civ_thread");
}

function hackclientomnvarclamp() {
  self waittill("death");
  level.hacking_player_nearby.civs = scripts\engine\utility::array_remove(level.hacking_player_nearby.civs, self);
}

function nextdest(var0) {
  self endon("death");
  self endon("entitydeleted");
  self.ignoreall = 1;
  self.script_pushable = 1;
  self.goalradius = 80;
  self setgoalpos(var0.origin);
  scripts\engine\utility::waittill_notify_or_timeout("goal", 20);
  scripts\cp\laser_traps\cp_laser_traps::ks_pointstowin();
}

function no_previous_interaction_point() {
  var0 = scripts\cp\utility::getplayersinteam("allies");
  var0 = sortbydistance(var0, self.origin);
  self.goalradius = 300;
  self setgoalpos(var0[0].origin);
}

function ref_12db1() {
  var0 = int(tablelookupbyrow("scripts/cp/maps/cp_so_highway/cp_so_highway_round_enemies.csv", level.ref_12db9, level.players.size));
  var1 = scripts\engine\utility::getStructArray("enemy_spawner", "targetname");
  var2 = 1;

  while(var0 > 0) {
    var3 = var1[randomint(var1.size)];
    var4 = var3 scripts\cp\laser_traps\cp_laser_traps::spawn_ai();

    if(isDefined(var4)) {
      var0--;
      thread ref_12da8(var4);
    }

    wait var2;
  }
}

function ref_12da8(var0) {
  var1 = var0.origin;
  wait 8;
  var2 = squared(200);

  if(distance2dsquared(var1, var0.origin) > var2) {
    return;
  }

  var0 scripts\cp\laser_traps\cp_laser_traps::ks_pointstowin();
}

function ref_12db6() {
  var0 = int(tablelookupbyrow("scripts/cp/maps/cp_so_highway/cp_so_highway_round_fallback.csv", level.ref_12db9, level.players.size));

  while(getaiarray("axis").size > var0) {
    waitframe();
  }
}

function init_spawners() {
  scripts\cp\laser_traps\cp_laser_traps::array_spawn_function_targetname("enemy_spawner", &nodetype);
  scripts\cp\laser_traps\cp_laser_traps::array_spawn_function_targetname("smoke_enemy_spawner", &ref_13420);
  var0 = getEntArray("vehicle_spawn", "targetname");

  foreach(var2 in var0) {
    var3 = scripts\engine\utility::getStructArray(var2.target, "targetname");

    foreach(var5 in var3) {
      var5 scripts\cp\laser_traps\cp_laser_traps::add_spawn_function(&ref_1420c);
    }
  }
}

function nodetype() {
  level endon("level_enemies_fallback");
  self endon("death");
  waitframe();

  if(scripts\engine\utility::cointoss()) {
    self.grenadeweapon = getcompleteweaponname("molotov_mp");
    self.grenadeammo = 255;
    self.grenadesafedist = 400;
    self.grenadeweapon.ammo = 255;
  }

  var0 = scripts\engine\utility::getStructArray("enemy_entry_struct", "targetname");
  var1 = [];
  jumpiffalse(self.origin[0] < -1100) LOC_000000a1;

  foreach(var3 in var0) {
    if(var3.origin[0] < -1100) {
      var1 = var3;
    }
  }

  goto LOC_000000da;
}

function ref_13420() {
  level endon("level_enemies_fallback");
  self endon("death");
  waitframe();
  self.grenadeweapon = getcompleteweaponname("molotov_mp");
  self.grenadeammo = 255;
  self.grenadesafedist = 400;
  self.grenadeweapon.ammo = 255;
  var0 = scripts\engine\utility::getStructArray("hardpoint", "targetname");
  var1 = scripts\cp\laser_traps\cp_laser_traps::get_least_used_from_array(var0);
  self.maxsightdistsqrd = 160000;
  self.goalradius = 400;
  scripts\cp\laser_traps\cp_laser_traps::go_to_node(var1);
  wait randomfloatrange(5, 10);
  var2 = scripts\engine\utility::random(level.players);
  var3 = distance(var2.origin, self.origin);
  self.goalradius = var3;
  self setgoalpos(var2.origin);

  for(;;) {
    var3 -= randomintrange(50, 300);
    var3 = max(var3, 400);
    self.goalradius = var3;
    wait randomfloatrange(3, 10);
  }
}

function ref_12dab(var0) {
  var1 = getEntArray("mortars_start_model", "targetname");
  var2 = 1;
  var3 = 2;
  var4 = ref_11d37();
  var5 = scripts\engine\utility::random(var4);

  for(var6 = 0; var6 < var0; var6++) {
    var7 = randomfloatrange(var2, var3);
    wait var7;
    var8 = scripts\engine\utility::random(var1);
    var9 = scripts\engine\utility::getStruct(var8.target, "targetname");
    var10 = scripts\cp\laser_traps\cp_laser_traps::ref_134f1(var9.script_type, var9.origin, var9.angles);

    if(!isDefined(var10)) {
      continue;
    }

    var10.ignoreall = 1;
    var10.ignoreme = 1;
    var10.stadium_two_death_func = 1;
    var10 allowedstances("crouch");
    var10.goalradius = 20;
    var10 setgoalpos(var10.origin);
    var10.health = 1;
    var10 scripts\cp\laser_traps\cp_laser_traps::disable_long_death();
    var10.targetname = "mortars_enemy";
    thread ref_11d35(var10, var8, var5);
    var1 = scripts\engine\utility::array_remove(var1, var8);

    if(isDefined(var5)) {
      var4 = scripts\engine\utility::array_remove(var4, var5);
    }
  }
}

function ref_11d37() {
  var0 = [];

  foreach(var2 in level.players) {
    if(istrue(ref_11d39(var2))) {
      continue;
    }

    if(var2 islinked()) {
      continue;
    }

    if(var2 scripts\cp_mp\killstreaks\gunship::isusinggunship()) {
      continue;
    }

    if(var2 scripts\cp_mp\killstreaks\chopper_gunner::isusingchoppergunner()) {
      continue;
    }

    var0 = scripts\engine\utility::array_add(var0, var2);
  }

  return var0;
}

function ref_11d3a(var0, var1) {
  var0.update_hint_logic_juggernaut = var1;
}

function ref_11d39(var0, var1) {
  return var0.update_hint_logic_juggernaut;
}

function ref_11d35(var0, var1, var2) {
  var0 endon("death");
  var3 = scripts\engine\utility::getStructArray("mortars_impact_miss_struct", "targetname");
  var4 = var1.origin;
  var5 = "mortar_impact";
  var6 = 2;
  var7 = 1;
  var8 = 3;
  var9 = 5;
  var10 = squared(500);

  if(isDefined(var2)) {
    var11 = var2.origin;
  } else {
    var11 = undefined;
  }

  var12 = 0.5;
  var13 = 2;
  var14 = randomfloatrange(var12, var13);
  wait var14;

  for(;;) {
    var15 = isDefined(var3) && (var8 == 1 || var8 >= var9 || var8 >= var10);

    if(var15) {
      var16 = var3.origin;
    } else {
      var17 = scripts\engine\utility::random(var4);
      var16 = var17.origin;
    }

    thread ref_11d36(var2, var5, var16, var6);
    level waittill(var6, var18);

    if(!isDefined(var3) || !isalive(var3)) {
      var19 = ref_11d37();
      var3 = scripts\engine\utility::random(var19);

      if(isDefined(var3)) {
        var11 = var3.origin;
      }
    }

    if(isDefined(var3)) {
      var20 = distance2dsquared(var11, var3.origin) >= var11;

      if(var20) {
        var8 = 1;
        var11 = var3.origin;
      }

      if(var8 == 1) {
        var3 shellshock("default_nosound", 2);
        var3 dodamage(3, var18, undefined, undefined, "MOD_EXPLOSIVE");
      } else if(var8 >= var9) {
        var3 shellshock("default_nosound", 2);
        var3 dodamage(20, var18, undefined, undefined, "MOD_EXPLOSIVE");
      }

      if(var8 >= var10) {
        var3 dodamage(99999, var18, undefined, undefined, "MOD_EXPLOSIVE");
      }

      var8++;
    }

    var21 = max(1, ref_11d38().size);
    var22 = var21 * var7;
    wait var22;
  }
}

function ref_11d38() {
  return getEntArray("mortars_enemy", "targetname");
}

function ref_11d36(var0, var1, var2, var3) {
  thread scripts\engine\utility::play_sound_in_space("mortar_fire_dist", var1);
  physicsexplosionsphere(var1, 350, 350, 200);
  var4 = spawn("script_model", var1);
  var4 setModel("equipment_mortar_shell_improvised_01");
  var5 = 0.15;
  wait var5;
  playFX(level._effect["vfx_mortar_fire"], var1, anglesToForward(var0.angles));
  playFXOnTag(level._effect["vfx_mortar_trail"], var4, "tag_origin");
  var6 = lookupsoundlength("mortar_trail") * 0.001 * 0.8;
  var7 = max(0.05, 7 - var6 - 0.5);
  var4 scripts\engine\utility::delaycall(var7, &playsound, "mortar_incoming");
  var8 = 0.00714286;
  var9 = 0;

  while(var9 < 1) {
    var10 = var4.origin;
    var4.origin = scripts\engine\math::get_point_on_parabola(var1, var2, 2500, var9);
    var4.angles = vectortoangles(var4.origin - var10);
    var9 += var8;
    waitframe();
  }

  var4 stoploopsound("weap_mortar_fly_lp");
  level notify(var3, var4.origin);
  mortars_explodemortarprojectile(var4, var0);
}

function mortars_explodemortarprojectile(var0, var1) {
  var2 = var0.origin;
  var0 delete();
  physicsexplosionsphere(var2, 2000, 1000, 150);
  var3 = 0.24;
  var4 = max(1, ref_11d38().size);
  var5 = var3 / var4;
  earthquake(var5, 1, var2, 3000);
  playrumbleonposition("damage_heavy", var2);
  thread scripts\engine\utility::play_sound_in_space("weap_mortar_expl_trans", var2);
  playFX(level._effect["vfx_mortar_impact"], var2);
}

function israndompistolloadouts() {}

function set_objective(var0) {
  if(!isDefined(level.weapondrop_createdropondeath)) {
    level.weapondrop_createdropondeath = [];
    level.weapondrop_createdropondeath["survive"] = 2;
    level.weapondrop_createdropondeath["exfil"] = 3;
    setomnvar("cp_objective_index", 1);
  }

  setomnvar("cp_objective_sub_1_index", level.weapondrop_createdropondeath[var0]);
}

#using_animtree("");

function support_box_delay_max_ammo_hint() {
  level.scr_animtree["player"] = #animtree;
  level.scr_anim["player"]["intro_idle"] = $sdr_cp_veh_lbravo_seat_2_idle;
  level.scr_animname["player"]["intro_idle"] = "sdr_cp_veh_lbravo_seat_2_idle";
  level.scr_eventanim["player"]["intro_idle"] = "cp_blima_idle";
}
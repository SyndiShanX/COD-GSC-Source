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
  var_0 = getEntArray("trigger_hurt", "classname");

  foreach(var_2 in var_0) {
    if(!scripts\engine\utility::is_equal(var_2.target, "auto1")) {
      continue;
    }

    var_2.origin -= (0, 0, 160);
  }

  var_4 = getEntArray("minimap_corner", "targetname");
  var_5 = [(-4484, -4047, 1768), (2485, 6151, 1768)];

  foreach(var_8, var_7 in var_4) {
    var_7.origin = var_5[var_8];
  }

  var_9 = getEntArray("OutOfBounds", "targetname");

  foreach(var_11 in var_9) {
    var_11.origin -= (0, 0, 256);

    if(var_11.origin == (-3344, -2720, 1232)) {
      var_11.origin -= (0, 256, 0);
    }
  }

  var_13 = getEntArray();

  foreach(var_15 in var_13) {
    if(var_15.origin == (-1507.75, -1416.5, 1171.5)) {
      var_15.origin = (-1505.25, -1416.5, 1171.5);
      continue;
    }

    if(var_15.origin == (-1513.72, -1431.54, 1171.5)) {
      var_15.origin = (-1509.72, -1431.54, 1171.5);
      var_16 = ref_1249f(1);
      var_17 = createheadicon(var_16);
      var_18 = spawn("weapon_" + var_17, var_15.origin, 1);
      var_18.angles = var_15.angles;
      var_18 itemweaponsetammo(weaponclipsize(var_18), weaponmaxammo(var_18));
      var_15 delete();
      continue;
    }

    if(var_15.origin == (-529.988, -1715.24, 1210.5)) {
      var_15.origin = (-529.988, -1716.24, 1210.5);
      var_16 = ref_1249f(1);
      var_17 = createheadicon(var_16);
      var_18 = spawn("weapon_" + var_17, var_15.origin, 1);
      var_18.angles = var_15.angles;
      var_18 itemweaponsetammo(weaponclipsize(var_18), weaponmaxammo(var_18));
      var_15 delete();
      continue;
    }

    if(var_15.origin == (-1468.21, -2578.1, 1071.24)) {
      var_16 = ref_1249d();
      var_17 = createheadicon(var_16);
      var_18 = spawn("weapon_" + var_17, var_15.origin, 1);
      var_18.angles = var_15.angles;
      var_18 itemweaponsetammo(weaponclipsize(var_18), weaponmaxammo(var_18));
      var_15 delete();
      continue;
    }

    if(var_15.origin == (-1326.1, -2557.79, 1076.24)) {
      var_16 = ref_1249d();
      var_17 = createheadicon(var_16);
      var_18 = spawn("weapon_" + var_17, var_15.origin, 1);
      var_18.angles = var_15.angles;
      var_18 itemweaponsetammo(weaponclipsize(var_18), weaponmaxammo(var_18));
      var_15 delete();
      continue;
    }

    if(var_15.origin == (-1193.79, -2573.9, 1077.24)) {
      var_16 = ref_1249d();
      var_17 = createheadicon(var_16);
      var_18 = spawn("weapon_" + var_17, var_15.origin, 1);
      var_18.angles = var_15.angles;
      var_18 itemweaponsetammo(weaponclipsize(var_18), weaponmaxammo(var_18));
      var_15 delete();
      continue;
    }

    if(var_15.origin == (-1185.9, -2472.21, 1081.24)) {
      var_16 = ref_1249d();
      var_17 = createheadicon(var_16);
      var_18 = spawn("weapon_" + var_17, var_15.origin, 1);
      var_18.angles = var_15.angles;
      var_18 itemweaponsetammo(weaponclipsize(var_18), weaponmaxammo(var_18));
      var_15 delete();
      continue;
    }

    if(var_15.origin == (-1318.54, -1412.28, 1171.5)) {
      var_16 = ref_1249f(2);
      var_17 = createheadicon(var_16);
      var_18 = spawn("weapon_" + var_17, var_15.origin, 1);
      var_18.angles = var_15.angles;
      var_18 itemweaponsetammo(weaponclipsize(var_18), weaponmaxammo(var_18));
      var_15 delete();
      continue;
    }

    if(var_15.origin == (-625.5, -1745.5, 1210.5)) {
      var_16 = ref_1249f(2);
      var_17 = createheadicon(var_16);
      var_18 = spawn("weapon_" + var_17, var_15.origin, 1);
      var_18.angles = var_15.angles;
      var_18 itemweaponsetammo(weaponclipsize(var_18), weaponmaxammo(var_18));
      var_15 delete();
      continue;
    }

    if(var_15.origin == (-1507.75, -1416.5, 1171.5)) {
      var_16 = ref_1249f(1);
      var_17 = createheadicon(var_16);
      var_18 = spawn("weapon_" + var_17, var_15.origin, 1);
      var_18.angles = var_15.angles;
      var_18 itemweaponsetammo(weaponclipsize(var_18), weaponmaxammo(var_18));
      var_15 delete();
      continue;
    }

    if(var_15.origin == (-1303.5, -1417.25, 1171.5)) {
      var_16 = ref_1249f(1);
      var_17 = createheadicon(var_16);
      var_18 = spawn("weapon_" + var_17, var_15.origin, 1);
      var_18.angles = var_15.angles;
      var_18 itemweaponsetammo(weaponclipsize(var_18), weaponmaxammo(var_18));
      var_15 delete();
    }
  }

  var_20 = spawn("script_model", (-2442, -2077, 1050));
  var_20 dontinterpolate();
  var_20.angles = (2, 0, 0);
  var_21 = getEnt("clip8x8x256", "targetname");
  var_20 clonebrushmodeltoscriptmodel(var_21);
  var_22 = spawn("script_model", (-1258, -2398, 1060));
  var_22 dontinterpolate();
  var_22.angles = (0, 73, 0);
  var_23 = getEnt("clip32x32x32", "targetname");
  var_22 clonebrushmodeltoscriptmodel(var_23);
  var_22 = spawn("script_model", (-1276, -2416, 1056));
  var_22 dontinterpolate();
  var_22.angles = (0, 73, 0);
  var_22 clonebrushmodeltoscriptmodel(var_23);
  var_22 = spawn("script_model", (-1558, -1854, 1062));
  var_22 dontinterpolate();
  var_22.angles = (322, 0, 0);
  var_22 clonebrushmodeltoscriptmodel(var_23);
  var_22 = spawn("script_model", (-1560, -1576, 1140));
  var_22 dontinterpolate();
  var_22.angles = (0, 340, 0);
  var_22 clonebrushmodeltoscriptmodel(var_23);
  var_22 = spawn("script_model", (-1398, -754, 790));
  var_22 dontinterpolate();
  var_22.angles = (0, 20, 0);
  var_22 clonebrushmodeltoscriptmodel(var_23);
  var_24 = spawn("script_model", (-2416, -1832, 992));
  var_24 dontinterpolate();
  var_24.angles = (0, 0, 0);
  var_25 = getEnt("clip32x32x256", "targetname");
  var_24 clonebrushmodeltoscriptmodel(var_25);
  var_24 = spawn("script_model", (-860, -2234, 1106));
  var_24 dontinterpolate();
  var_24.angles = (0, 0, -122);
  var_24 clonebrushmodeltoscriptmodel(var_25);
  var_24 = spawn("script_model", (-872, -2234, 1106));
  var_24 dontinterpolate();
  var_24.angles = (0, 0, -122);
  var_24 clonebrushmodeltoscriptmodel(var_25);
  var_20 = spawn("script_model", (-844, -2230, 1200));
  var_20 dontinterpolate();
  var_20.angles = (5.295, 2.825, -151.869);
  var_20 clonebrushmodeltoscriptmodel(var_21);
  var_24 = spawn("script_model", (-584, -2656, 1010));
  var_24 dontinterpolate();
  var_24.angles = (0, 0, 0);
  var_24 clonebrushmodeltoscriptmodel(var_25);
  var_26 = spawn("script_model", (-458, -1262, 856));
  var_26 dontinterpolate();
  var_26.angles = (0, 358, 0);
  var_27 = getEnt("clip64x64x64", "targetname");
  var_26 clonebrushmodeltoscriptmodel(var_27);
  var_26 = spawn("script_model", (-522, -1264, 858));
  var_26 dontinterpolate();
  var_26.angles = (0, 358, 0);
  var_26 clonebrushmodeltoscriptmodel(var_27);
  var_26 = spawn("script_model", (-586, -1264, 858));
  var_26 dontinterpolate();
  var_26.angles = (0, 358, 0);
  var_26 clonebrushmodeltoscriptmodel(var_27);
  var_28 = spawn("script_model", (-770, -2490, 936));
  var_28 dontinterpolate();
  var_28.angles = (0, 316, 0);
  var_29 = getEnt("clip64x64x256", "targetname");
  var_28 clonebrushmodeltoscriptmodel(var_29);
  var_30 = spawn("script_model", (-2428.32, -1977.25, 1154.54));
  var_30 dontinterpolate();
  var_30.angles = (90, 0, 0);
  var_31 = getEnt("player256x256x8", "targetname");
  var_30 clonebrushmodeltoscriptmodel(var_31);
  var_30 = spawn("script_model", (-2392.32, -2225.25, 1186.54));
  var_30 dontinterpolate();
  var_30.angles = (90, 16, 0);
  var_30 clonebrushmodeltoscriptmodel(var_31);
  var_30 = spawn("script_model", (-2484.87, -2310.06, 1206.56));
  var_30 dontinterpolate();
  var_30.angles = (0, 40, -90);
  var_30 clonebrushmodeltoscriptmodel(var_31);
  var_30 = spawn("script_model", (-2664.87, -2490.06, 1206.56));
  var_30 dontinterpolate();
  var_30.angles = (0, 50, -90);
  var_30 clonebrushmodeltoscriptmodel(var_31);
  var_32 = spawn("script_model", (-774.51, -2733.74, 1228));
  var_32 dontinterpolate();
  var_32.angles = (0, 0, 0);
  var_33 = getEnt("clip128x128x128", "targetname");
  var_32 clonebrushmodeltoscriptmodel(var_33);
  var_32 = spawn("script_model", (-598.51, -2733.74, 1260));
  var_32 dontinterpolate();
  var_32.angles = (0, 0, 0);
  var_32 clonebrushmodeltoscriptmodel(var_33);
  var_32 = spawn("script_model", (-771.37, -2736.12, 1292));
  var_32 dontinterpolate();
  var_32.angles = (0, 0, 0);
  var_32 clonebrushmodeltoscriptmodel(var_33);
  var_32 = spawn("script_model", (-556.011, -2725.13, 1236));
  var_32 dontinterpolate();
  var_32.angles = (0, 0, 0);
  var_32 clonebrushmodeltoscriptmodel(var_33);
  var_34 = getEnt("clip256x256x256", "targetname");
  var_35 = spawn("script_model", (-3483.93, -718.783, 806.96));
  var_35 dontinterpolate();
  var_35.angles = (0, 35, 0);
  var_35 clonebrushmodeltoscriptmodel(var_34);
  var_35 disconnectPaths();
  var_35 = spawn("script_model", (-2771.93, -1110.78, 894.96));
  var_35 dontinterpolate();
  var_35.angles = (0, 35, 0);
  var_35 clonebrushmodeltoscriptmodel(var_34);
  var_35 disconnectPaths();
  var_35 = spawn("script_model", (-2444.24, -2349.37, 1094.7));
  var_35 dontinterpolate();
  var_35.angles = (0, 0, 0);
  var_35 clonebrushmodeltoscriptmodel(var_34);
  var_35 disconnectPaths();
  var_35 = spawn("script_model", (-2818.05, -2866.49, 1124.31));
  var_35 dontinterpolate();
  var_35.angles = (0, 0, 0);
  var_35 clonebrushmodeltoscriptmodel(var_34);
  var_35 disconnectPaths();
  var_35 = spawn("script_model", (-2690.05, -2866.49, 1124.31));
  var_35 dontinterpolate();
  var_35.angles = (0, 0, 0);
  var_35 clonebrushmodeltoscriptmodel(var_34);
  var_35 disconnectPaths();
  var_36 = spawn("script_model", (-2384.71, -2441.04, 1112.77));
  var_36.angles = (7.43938, 99.1471, 18.1777);
  var_36 setModel("veh8_mil_air_blima_static_dst");
  var_36 = spawn("script_model", (-2750.08, -2884.09, 1140.8));
  var_36.angles = (352.628, 9.14556, 15.7999);
  var_36 setModel("veh8_mil_air_blima_static_dst");
  var_36 = spawn("script_model", (-2789.97, -1137.88, 986.641));
  var_36.angles = (11.3127, 352.884, -15.6063);
  var_36 setModel("veh8_mil_air_blima_static_dst");
  var_36 = spawn("script_model", (-3460.21, -682.763, 883.417));
  var_36.angles = (359.425, 175.707, -12.8315);
  var_36 setModel("veh8_mil_air_blima_static_dst");
  var_37 = spawn("script_model", (-805.316, -2706.05, 1226));
  var_37.angles = (0, 180, -8);
  var_37 setModel("un_industrial_wooden_pallet_stack_01");
  var_37 = spawn("script_model", (-805.316, -2704.05, 1258));
  var_37.angles = (350, 90, 0);
  var_37 setModel("un_industrial_wooden_pallet_stack_01");
  var_38 = spawn("script_model", (-599, -2671, 1306));
  var_38.angles = (0, 0, 0);
  var_38 setModel("uk_windows_exterior_metal_bar_01");
  var_39 = spawn("script_model", (-1185.97, -1429.64, 1053.96));
  var_39 setModel("highway_flag0_hero");
  var_39.angles = (0, 135.999, 15.2997);
  var_40 = getEntArray("mortars_start_model", "targetname");

  foreach(var_42 in var_40) {
    if(var_42.origin == (-1313.04, 12624.6, -1027.39)) {
      var_42 delete();
    }
  }

  var_44 = [(-4262.21, -2103.35, 1029.15), (-4262.21, -2151.35, 1027.82), (-4270.21, -2199.35, 1024.57), (-4270.21, -2239.35, 1030.85)];
  var_45 = [(-4088.65, -2766.21, 1109.15), (-4040.65, -2766.21, 1107.82), (-3992.65, -2774.21, 1104.57), (-3952.65, -2782.21, 1110.85)];
  var_46 = [(0, 180, 0), (0, 180, 0), (0, 180, 0), (0, 180, 0)];
  var_47 = scripts\engine\utility::getStructArray("enemy_spawner", "targetname");
  var_48 = scripts\engine\utility::getStructArray("smoke_enemy_spawner", "targetname");
  var_47 = scripts\engine\utility::array_combine(var_47, var_48);

  for(var_8 = 0; var_8 < var_44.size; var_8++) {
    var_49 = var_44[var_8];
    var_50 = var_45[var_8];
    var_51 = var_46[var_8];

    foreach(var_53 in var_47) {
      if(var_53.origin != var_49) {
        continue;
      }

      var_53.origin = var_50;
      var_53.angles = var_51;
      break;
    }
  }

  var_44 = [(-3942.21, -847.355, 916.54), (-3942.21, -895.355, 930.206), (-3950.21, -943.355, 947.497), (-3950.21, -983.355, 963.497)];
  var_45 = [(-3824, -704, 896), (-3776, -704, 896), (-3728, -712, 896), (-3688, -712, 888)];
  var_51 = [(0, 180, 0), (0, 180, 0), (0, 180, 0), (0, 180, 0)];

  for(var_8 = 0; var_8 < var_44.size; var_8++) {
    var_49 = var_44[var_8];
    var_50 = var_45[var_8];
    var_51 = var_46[var_8];

    foreach(var_53 in var_47) {
      if(var_53.origin != var_49) {
        continue;
      }

      var_53.origin = var_50;
      var_53.angles = var_51;
      break;
    }
  }

  var_44 = [(-3374.21, -1183.35, 990.46), (-3374.21, -1231.35, 994.262), (-3382.21, -1279.35, 998.008), (-3382.21, -1319.35, 1005.29)];
  var_45 = [(-3048, -1096, 1002.7), (-3000, -1104, 1001.98), (-2952, -1112, 996.719), (-2912, -1120, 998.522)];
  var_51 = [(0, 180, 0), (0, 180, 0), (0, 180, 0), (0, 180, 0)];

  for(var_8 = 0; var_8 < var_44.size; var_8++) {
    var_49 = var_44[var_8];
    var_50 = var_45[var_8];
    var_51 = var_46[var_8];

    foreach(var_53 in var_47) {
      if(var_53.origin != var_49) {
        continue;
      }

      var_53.origin = var_50;
      var_53.angles = var_51;
      break;
    }
  }

  var_44 = [(-3270.21, -2279.35, 1068.57), (-3270.21, -2319.35, 1069.8), (-3942.21, -1319.35, 1034.04)];
  var_45 = [(-3127.35, -3017.79, 1170.2), (-3167.35, -3017.79, 1167.58), (-3112, -64, 712)];
  var_51 = [(0, 360, 0), (0, 360, 0), (0, 0, 0)];

  for(var_8 = 0; var_8 < var_44.size; var_8++) {
    var_49 = var_44[var_8];
    var_50 = var_45[var_8];
    var_51 = var_46[var_8];

    foreach(var_53 in var_47) {
      if(var_53.origin != var_49) {
        continue;
      }

      var_53.origin = var_50;
      var_53.angles = var_51;
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
  var_0 = ref_1249d();
  self giveweapon(var_0);
  self setweaponammoclip(var_0, weaponclipsize(var_0));
  self setweaponammostock(var_0, weaponmaxammo(var_0));
  self switchtoweapon(var_0);
  var_1 = ref_1249e();
  self giveweapon(var_1);
  self setweaponammoclip(var_1, weaponclipsize(var_1));
  self setweaponammostock(var_1, weaponmaxammo(var_1));
  level.hostdamagefactorlow++;

  if(!getdvarint("scr_highway_skip_intro")) {
    trial_shooters_quota();
    return;
  }
}

function ref_1249d() {
  var_0 = scripts\cp\cp_weapon::buildweapon_variant("iw8_ar_mike4", "none", "none", 1);
  var_0 = var_0 withattachment("cos_001");
  var_0 = var_0 withoutattachment("holo_west01");
  var_0 = var_0 withattachment("hybrid_west03_irons");
  return var_0;
}

function ref_1249e() {
  return scripts\cp\cp_weapon::buildweapon("iw8_pi_mike1911_mp", ["brake_mike1911", "slide_tritium_mike1911", "barlong_mike1911"], "none", "none", 1);
}

function ref_1249f(var_0) {
  var_1 = scripts\cp\cp_weapon::buildweapon_variant("iw8_sn_hdromeo", "none", "none", var_0);
  var_1 = var_1 withattachment("cos_001");
  var_1 = var_1 withattachment("vzscope_hdromeo");
  var_1 = var_1 withattachment("xmagslrg_hdromeo");
  var_1 = var_1 withattachment("barmid_hdromeo");
  return var_1;
}

function trial_shooters_quota() {
  if(scripts\engine\utility::flag("intro_heli_crashing")) {
    return;
  }

  var_0 = ["tag_guy5", "tag_guy6", "tag_guy7", "tag_guy8"];
  var_1 = [(3, -10, -25), (3, 10, -25), (3, 10, -25), (3, -10, -25)];
  var_2 = [40, 50, 50, 40];
  var_3 = [50, 40, 40, 50];

  if(!isDefined(level.trial_shooters.ref_13a26)) {
    level.trial_shooters.ref_13a26 = [];
  }

  var_4 = undefined;
  var_5 = undefined;

  foreach(var_7 in var_0) {
    if(isDefined(level.trial_shooters.ref_13a26[var_7])) {
      continue;
    }

    level.trial_shooters.ref_13a26[var_7] = 1;
    var_4 = var_7;
    var_5 = var_8;
    break;
  }

  var_9 = var_1[var_5];
  var_10 = var_2[var_5];
  var_11 = var_3[var_5];
  var_12 = scripts\cp\laser_traps\cp_laser_traps::ref_124e9(self, "player");
  var_12 linkTo(level.trial_shooters, var_4, var_9, (0, 0, 0));
  self playerlinktodelta(var_12, "tag_player", 1, 0, 0, 0, 0, 1, 1, 1);
  self lerpviewangleclamp(1, 0.25, 0.25, var_10, var_11, 80, 80);
  waitframe();
  thread trial_small_fire(self, var_12);
  level.trial_shooters waittill("stop_heli_spin");
  self unlink();
  var_12 delete();
}

function trial_small_fire(var_0, var_1) {
  var_0 endon("death_or_disconnect");
  var_1 endon("entitydeleted");

  for(;;) {
    var_1 scripts\cp\cp_anim::anim_player_solo(var_0, var_1, "intro_idle");
  }
}

function registerscriptedagents() {
  scripts\mp\mp_agent::init_agent("mp/iw8_default_agent_definition.csv");
  scripts\mp\agents\soldier\soldier_agent::registerscriptedagent();
  scripts\mp\agents\juggernaut\juggernaut_agent::registerscriptedagent();
}

function interaction_trigger_properties(var_0, var_1, var_2) {
  switch (var_1.script_noteworthy) {
    default:
      self.interaction_trigger setusefov(360);
      self.interaction_trigger sethintrequiresholding(0);

      if(isDefined(var_1.useduration)) {
        self.interaction_trigger setuseholdduration(var_1.useduration);
      }

      break;
  }
}

function intro_main() {
  skipburndownlow();
  var_0 = getaiarray("axis");
  scripts\engine\utility::array_thread(var_0, &scripts\cp\laser_traps\cp_laser_traps::ks_pointstowin);
  var_1 = scripts\cp\utility::create_client_overlay("black", 1);
  var_2 = scripts\engine\utility::getStructArray("default_player_start", "targetname");

  foreach(var_4 in level.players) {
    var_4 unlink();
    var_4 freezecontrols(1);
    var_4 setOrigin(var_2[var_5].origin);
    var_4 setplayerangles(var_2[var_5].angles);
    var_4 allowstand(1);
    var_4 allowmovement(0);
    var_4 setclientomnvar("ui_hide_hud", 1);
  }

  scripts\engine\utility::delaythread(4, &ref_12758, "dx_cps_lass_callout_enemy_squad_spawning_30");
  var_6 = 5;
  wait var_6;

  foreach(var_4 in level.players) {
    var_4 freezecontrols(0);
    var_4 allowmovement(1);
    var_4 shellshock("default_nosound", 3);
    var_4 playRumbleOnEntity("damage_heavy");
    var_4 clearaccessory();
    var_4 takeallweapons();
    var_8 = "iw8_pi_mike1911_mp";
    var_9 = scripts\cp\cp_weapon::buildweapon(var_8, undefined, "none", "none", 1);
    var_4 giveweapon(var_9);
    var_4 switchtoweapon(var_9);
    var_4.loadoutaccessoryweapon = var_4 scripts\cp\cp_loadout::cac_getaccessoryweapon();
    var_4.loadoutaccessorydata = var_4 scripts\cp\cp_loadout::cac_getaccessorydata();
    var_4.loadoutaccessorylogic = var_4 scripts\cp\cp_loadout::force_interrupt_all_current_combat_actions();

    if(isDefined(var_4.loadoutaccessorydata) && isDefined(var_4.loadoutaccessoryweapon) && var_4.loadoutaccessoryweapon != "none") {
      var_4 scripts\cp\cp_accessories::giveplayeraccessory(var_4.loadoutaccessorydata, var_4.loadoutaccessoryweapon, var_4.loadoutaccessorylogic);
    }

    var_4 setclientomnvar("ui_hide_hud", 0);
  }

  set_objective("survive");
  var_11 = 5;
  var_1 fadeovertime(var_11);
  var_1.alpha = 0;
  var_1 scripts\engine\utility::delaycall(var_11, &destroy);
  var_12 = [3, 6, 8, 10];
  var_13 = scripts\engine\utility::getStructArray("intro_enemy_spawner", "targetname");
  var_13 = scripts\engine\utility::array_randomize(var_13);
  var_0 = [];
  var_14 = var_12[level.players.size - 1];

  foreach(var_16 in var_13) {
    if(var_20 >= var_14) {
      break;
    }

    var_17 = var_16 scripts\cp\laser_traps\cp_laser_traps::spawn_ai();
    var_18 = scripts\engine\utility::random(level.players);
    var_17 setgoalentity(var_18);
    var_17.goalradius = 300;
    var_19 = var_17 scripts\cp\laser_traps\cp_laser_traps::print_spawner_score_for_factor();
    var_17 scripts\cp\laser_traps\cp_laser_traps::set_baseaccuracy(0);
    var_17 scripts\engine\utility::delaythread(5, &scripts\cp\laser_traps\cp_laser_traps::set_baseaccuracy, var_19);
    var_0 = scripts\engine\utility::array_add(var_0, var_17);
  }

  scripts\cp\laser_traps\cp_laser_traps::ref_13067();
  scripts\engine\utility::array_wait(var_0, "death");
}

function jumpscenenode() {
  var_0 = [(-1406.52, -1537.56, 1154.25), (-520.306, -1863.58, 1193.75)];
  var_1 = [(0, 162.743, 0), (0, 182.744, 0)];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    scripts\cp\laser_traps\cp_laser_traps::brplayerhudoutlineforteammatesupdate(var_0[var_2], var_1[var_2]);
  }

  var_3 = (-1354.86, -1406.15, 1017.5);
  var_4 = (0, 160.849, 0);
  scripts\cp\laser_traps\cp_laser_traps::handle_leads_collected_hideiconbuilding(var_3, var_4);
  var_5 = (-521.718, -1719.51, 1041.5);
  var_6 = (0, 179.765, 0);
  scripts\cp\laser_traps\cp_laser_traps::ref_11cb8(var_5, var_6);
  var_7 = scripts\cp\laser_traps\cp_laser_traps::binoculars_getpendingtime((-721.301, -1094.8, 834.118), (354.711, 3.04249, -28.3572));
  setheadiconsnaptoedges(var_7.headiconid, 800);
}

function jumped() {
  level.ref_12db9 = 1;
  jumpscenenode();
  scripts\engine\utility::delaythread(4, &ref_12758, "dx_cps_lass_bank_enemy_reinforcements_10");
  scripts\engine\utility::delaythread(8, &weapon_xp_iw8_sm_augolf);
  israndompistolloadouts();
  var_0 = 45;
  wait var_0;
  var_1 = 25;
  var_2 = 20;
  var_3 = 10;
  var_4 = 2;
  var_5 = 6;
  var_6 = 7;
  var_8 = ["dx_cps_lass_callout_mortar_attacking_10", "dx_cps_lass_callout_mortar_attacking_20"];
  var_9 = ["dx_cps_lass_bank_enemies_vehicle_10", "dx_cps_lass_bank_enemy_reinforcements_10"];
  var_10 = ["dx_mpa_ustl_hint_killall", "dx_mpa_ustl_kh_sniper_hurryup"];
  var_11 = ["dx_mpa_ustl_exfillosing_start_winningteam", "dx_mpa_ustl_exfillosing_end_winningteam"];

  for(;;) {
    var_12 = int(tablelookupbyrow("scripts/cp/maps/cp_so_highway/cp_so_highway_round_mortars.csv", level.ref_12db9, level.players.size));

    if(var_12 > 0) {
      var_13 = var_8[0];

      if(isDefined(var_13)) {
        scripts\engine\utility::delaythread(6, &ref_12758, var_13);
        var_8 = scripts\engine\utility::array_remove(var_8, var_13);
      }

      thread ref_12dab(var_12);
      var_14 = var_3 * var_12;
      var_14 *= 1 / level.players.size;
      wait var_14;
    }

    var_15 = var_9[0];

    if(isDefined(var_15)) {
      thread ref_12758(var_15);
      var_9 = scripts\engine\utility::array_remove(var_9, var_15);
    }

    var_16 = var_10[0];

    if(isDefined(var_16)) {
      scripts\engine\utility::delaythread(7, &ref_12758, var_16);
      var_10 = scripts\engine\utility::array_remove(var_10, var_16);
    }

    thread ref_12db2();
    wait var_2;
    thread ref_12db0();
    ref_12db1();
    thread ref_12da7();
    ref_12db6();

    if(!ref_12da5()) {
      if(level.ref_12db9 == var_4) {
        ref_12dad();
      } else {
        ref_12da6();
      }

      var_17 = var_11[0];

      if(isDefined(var_17)) {
        scripts\engine\utility::delaythread(2, &ref_12758, var_17);
        var_11 = scripts\engine\utility::array_remove(var_11, var_17);
      }

      var_18 = randomfloatrange(var_5, var_6);
      wait var_18;
    }

    level notify("level_round_over");
    var_19 = ref_12da9();

    foreach(var_21 in var_19) {
      if(!isDefined(var_21)) {
        continue;
      }

      var_21 delete();
    }

    level.ref_12db9++;

    if(level.ref_12db9 > 3) {
      break;
    }

    var_23 = ["dx_mpa_ustl_airdrop_achieve", "dx_mpa_ustl_airdrop_friendly_use"];
    var_24 = scripts\engine\utility::random(var_23);
    scripts\engine\utility::delaythread(3, &ref_12758, var_24);
    scripts\engine\utility::delaythread(6, &weapon_xp_iw8_sm_augolf);
    wait var_1;
  }
}

function ref_12da5() {
  return level.ref_12db9 == 3;
}

function ref_12dad() {
  var_0 = 6;
  var_1 = 0.5;
  var_2 = 1;
  var_3 = scripts\engine\utility::getStructArray("smoke_end_struct", "targetname");

  foreach(var_5 in var_3) {
    magicgrenademanual("smoke_grenade_mp", var_5.origin, (0, 0, 4), 0.05);
    var_6 = randomfloatrange(var_1, var_2);
    wait var_6;
  }

  foreach(var_9 in level.players) {
    magicgrenademanual("smoke_grenade_mp", var_9.origin, (0, 0, -4), 0.05);
    var_9 visionsetnakedforplayer("cp_so_highway_smoke", var_0);
  }

  wait var_0;
  var_11 = ref_11d38();

  foreach(var_13 in var_11) {
    var_13 scripts\cp\laser_traps\cp_laser_traps::ks_pointstowin();
  }

  thread ref_12daf();
  thread ref_12dae();
  var_15 = [0, 40, 60, 70, 80];
  var_16 = var_15[level.players.size];
  var_17 = scripts\engine\utility::getStructArray("smoke_enemy_spawner", "targetname");

  while(var_16 > 0) {
    var_18 = var_17[randomint(var_17.size)];
    var_19 = var_18 scripts\cp\laser_traps\cp_laser_traps::spawn_ai();

    if(isDefined(var_19)) {
      var_16--;
    }

    wait 1;
  }

  ref_12db6();
  ref_12da6();

  foreach(var_9 in level.players) {
    var_9 visionsetnakedforplayer("", 60);
  }
}

function ref_12daf() {
  level endon("level_enemies_fallback");
  level endon("level_round_over");
  var_0 = 5;
  wait var_0;
  var_1 = level.players;
  var_2 = 12;
  var_3 = 30;
  var_4 = max(var_2, var_3 / var_1.size);
  var_5 = 7;
  var_6 = 1;
  var_7 = 3;

  for(;;) {
    var_8 = getaiarray("axis");

    if(var_8.size < var_5) {
      waitframe();
      continue;
    }

    var_9 = scripts\engine\utility::random(var_1);
    var_10 = randomintrange(var_6, var_7);

    for(var_11 = 0; var_11 < var_10; var_11++) {
      var_12 = var_9.origin + (0, 0, 300) + scripts\engine\utility::randomvectorrange(15, 30);
      var_8[0].grenadeweapon = getcompleteweaponname("semtex_mp");
      var_8[0] magicgrenademanual(var_12, (0, 0, -5), 2);
    }

    var_1 = scripts\engine\utility::array_remove(var_1, var_9);

    if(!var_1.size) {
      var_1 = level.players;
    }

    wait var_4;
  }
}

function ref_12dae() {
  level endon("level_enemies_fallback");
  level endon("level_round_over");
  var_0 = 8;
  wait var_0;
  var_1 = level.players;
  var_2 = 14;
  var_3 = 33;
  var_4 = max(var_2, var_3 / var_1.size);
  var_5 = [(-648.919, -1298.07, 1746.41), (-538.559, -1801.64, 2024), (-1434.56, -1993.64, 2056), (-1402.56, -1497.64, 2024)];
  var_6 = [(19.625, 267.558, 0), (90, 0, 90), (90, 0, 90), (90, 0, 90)];
  var_7 = [5000, 1, 1, 1];
  var_8 = 7;

  for(;;) {
    var_9 = getaiarray("axis");

    if(var_9.size < var_8) {
      waitframe();
      continue;
    }

    for(var_10 = 0; var_10 < var_5.size; var_10++) {
      var_11 = var_5[var_10];
      var_12 = anglesToForward(var_6[var_10]) * var_7[var_10];
      var_9[0].grenadeweapon = getcompleteweaponname("molotov_mp");
      var_13 = var_9[0] magicgrenademanual(var_11, var_12);
      var_9[0] scripts\cp\powers\coop_molotov::molotov_used(var_13);
    }

    wait var_4;
  }
}

function ref_12db2() {
  level endon("level_round_over");
  var_0 = getEntArray("vehicle_spawn", "targetname");
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = int(tablelookupbyrow("scripts/cp/maps/cp_so_highway/cp_so_highway_round_vehicles.csv", level.ref_12db9, level.players.size));
  var_2 = 2;
  var_3 = 1;

  while(var_1 > 0) {
    if(!var_0.size) {
      return;
    }

    var_4 = var_0[0];
    var_5 = var_4 scripts\common\utility::spawn_vehicle();

    if(!isDefined(var_5.riders)) {
      var_5 waittill("spawnedRiders");
    }

    var_6 = 0;

    foreach(var_8 in var_5.riders) {
      if(var_8.vehicle_position != 0) {
        continue;
      }

      var_6 = 1;
      break;
    }

    if(!istrue(var_6)) {
      var_5 delete();
      wait var_3;
      continue;
    }

    var_1--;
    thread ref_12db4(var_5);
    var_0 = scripts\engine\utility::array_remove(var_0, var_4);
    var_0 = sortbydistance(var_0, var_4.origin);
    wait var_2;
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
  var_0 = int(tablelookupbyrow("scripts/cp/maps/cp_so_highway/cp_so_highway_round_bombers.csv", level.ref_12db9, level.players.size));

  if(var_0 <= 0) {
    return;
  }

  var_1 = 14;
  wait var_1;
  var_2 = 4;
  var_3 = 8;
  ref_12758("dx_cps_lass_callout_suicide_bomber_spawning_20");
  var_4 = [(-3158.13, -1064.1, 994.668), (-3167.07, -3017.07, 1171.24)];

  while(var_0 > 0) {
    var_5 = scripts\engine\utility::random(var_4);
    var_6 = scripts\cp\laser_traps\cp_laser_traps::ref_134f1("enemy_cp_alq_desert_bomber", var_5, (0, 0, 0), 1);

    if(isDefined(var_6)) {
      var_0--;
    }

    var_7 = randomfloatrange(var_2, var_3);
    wait var_7;
  }
}

function ref_12da6() {
  level notify("level_enemies_fallback");
  var_0 = getaiarray("axis");
  var_1 = scripts\engine\utility::getStructArray("enemy_retreat_struct", "targetname");

  foreach(var_3 in var_0) {
    if(istrue(var_3.stadium_two_death_func)) {
      continue;
    }

    var_1 = sortbydistance(var_1, var_3.origin);
    thread nextdest(var_3);
  }
}

function ref_12da7() {
  level endon("level_enemies_fallback");
  var_0 = randomfloatrange(10, 15);
  wait var_0;
  var_1 = 0.2;
  var_2 = 0.5;
  var_3 = 2.25;
  var_4 = 3.55;
  var_5 = 2;
  var_6 = 4;

  for(;;) {
    var_7 = randomintrange(var_5, var_6);
    var_8 = getaiarray("axis");

    foreach(var_10 in var_8) {
      if(!isDefined(var_10)) {
        continue;
      }

      if(!isalive(var_10)) {
        continue;
      }

      if(var_10 islinked()) {
        continue;
      }

      if(istrue(var_10.stadium_two_death_func)) {
        continue;
      }

      GscBinSkip4(0x6e, var_10);
    }

    var_13 = randomfloatrange(var_3, var_4);
    wait var_13;
  }
}

function ref_12db4(var_0) {
  var_0 endon("death");
  var_0 endon("entitydeleted");
  var_0.targetname = "level_vehicle";
  var_0 vehicleshowonminimap(1);
  var_0 aiupdatecoverexposetype(1);
  scripts\cp\cp_weapon::add_to_special_lockon_target_list(var_0);
  GscBinSkip4(0x35, var_0);
}

function ref_12db5(var_0) {
  var_1 = "vehicle_resume_speed";
  var_0 scripts\engine\utility::ent_flag_init(var_1);
  thread scripts\common\vehicle_paths::gopath(var_0);
  var_0 scripts\engine\utility::ent_flag_wait(var_1);
  var_0 resumespeed(7);
}

function ref_12da9() {
  return getEntArray("level_vehicle", "targetname");
}

function weapon_xp_iw8_sm_augolf() {
  var_0 = int(tablelookupbyrow("scripts/cp/maps/cp_so_highway/cp_so_highway_killstreaks.csv", level.ref_12db9, level.players.size));

  if(var_0 == 1) {
    thread ref_12758("dx_mpo_usop_airdrop_use");
  } else if(var_0 > 1) {
    thread ref_12758("dx_mpo_usop_airdrop_multiple_use");
  }

  var_1 = 2;
  wait var_1;
  var_2 = scripts\engine\utility::getStructArray("level_carepackage_heli_drop_struct", "targetname");
  var_3 = spawnStruct();
  var_3.origin = (-1229.57, -1160.71, 2000);
  var_3.angles = (0, 180, 0);
  var_3.script_radius = 20000;
  var_3.script_index = 3;
  var_2 = scripts\engine\utility::array_add(var_2, var_3);
  var_2 = scripts\cp\laser_traps\cp_laser_traps::can_play_ending(var_2);
  var_4 = scripts\cp\laser_traps\cp_laser_traps::get_drone_target_loc();
  var_5 = squared(70);

  for(var_6 = 0; var_6 < var_0; var_6++) {
    var_7 = var_2[var_6].script_radius;
    var_8 = var_2[var_6].script_radius;
    var_9 = var_2[var_6].angles;
    var_10 = var_2[var_6].origin;

    for(;;) {
      var_11 = 1;

      foreach(var_13 in var_4) {
        if(distance2dsquared(var_13.origin, var_10) > var_5) {
          continue;
        }

        var_11 = 0;
        break;
      }

      if(var_11) {
        break;
      }

      var_10 += (60, 0, 0);
    }

    thread scripts\cp\laser_traps\cp_laser_traps::get_driver_interaction_hint_string(var_7, var_8, var_9, var_10, undefined, &weapon_xp_iw8_sm_charlie9);
    wait 3;
  }
}

function weapon_xp_iw8_sm_charlie9(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    if(!isDefined(level.ref_12a94)) {
      level.ref_12a94 = [];
    }

    if(!isDefined(var_0.ref_12881)) {
      var_0.ref_12881 = [];
    }

    var_3 = tablelookupbyrow("scripts/cp/maps/cp_so_highway/cp_so_highway_killstreaks.csv", level.ref_12db9, 6);
    var_3 = strtok(var_3, " ");
    var_4 = tablelookupbyrow("scripts/cp/maps/cp_so_highway/cp_so_highway_killstreaks.csv", level.ref_12db9, 5);
    var_4 = strtok(var_4, " ");

    if(var_3.size) {
      foreach(var_6 in var_3) {
        if(!scripts\engine\utility::array_contains(level.ref_12a94, var_6)) {
          continue;
        }

        var_3 = scripts\engine\utility::array_remove(var_3, var_6);
      }
    }

    if(var_3.size) {
      var_8 = var_3;
    } else {
      var_8 = var_8;
    }

    var_8 = scripts\engine\utility::array_remove_array(var_8, var_1.ref_12881);

    if(!var_8.size) {
      var_8 = var_8;
    }

    var_3 = scripts\engine\utility::random(var_8);
  }

  if(!scripts\engine\utility::array_contains(level.ref_12a94, var_3)) {
    level.ref_12a94 = scripts\engine\utility::array_add(level.ref_12a94, var_3);
  }

  var_1.ref_12881 = scripts\engine\utility::array_add(var_1.ref_12881, var_3);
  var_9 = "weapon_";

  if(getsubstr(var_3, 0, var_9.size) == var_9) {
    var_10 = spawn(var_3, var_2 + (0, 0, 25));
    var_10 itemweaponsetammo(weaponclipsize(var_10), weaponmaxammo(var_10));
    var_10 physicslaunchserveritem(var_10.origin, (0, 0, 2000));
    return;
  }

  scripts\cp\laser_traps\cp_laser_traps::ref_124a5(var_1, var_3);
}

function initarmsraceanims(var_0) {
  return (0, 1, 0);
}

function ref_12758(var_0) {
  if(!isDefined(level.ref_121a7)) {
    level.ref_121a7 = spawn("script_origin", (0, 0, 0));
  }

  level.ref_121a7 stopsounds();
  var_1 = lookupsoundlength(var_0) * 0.001;
  level.ref_121a7 playSound(var_0);
  wait var_1;
}

function ref_1437b() {
  scripts\cp\laser_traps\cp_laser_traps::ref_1437a();
}

function mud_sfx(var_0) {
  if(var_0 == "axis") {
    return 0;
  }

  var_1 = 60000;

  if(level.time_survived < 10 * var_1) {
    return 3;
  } else if(level.time_survived < 15 * var_1) {
    return 2;
  }

  return 1;
}

function skipburndownlow() {
  var_0 = getEnt("intro_heli", "targetname");
  var_1 = var_0 scripts\common\utility::spawn_vehicle();
  var_1 setmaxpitchroll(10, 25);
  level.trial_shooters = var_1;
  thread skip_overheat();
  var_1 scripts\common\vehicle::godon();
  var_1.script_team = "allies";
  thread skipprematch();
  thread trial_special_vfx();
  var_2 = missile_createrepulsorent(var_1, 5000, 1000);
  var_3 = getEntArray("intro_heli_destroyed", "targetname");

  foreach(var_5 in var_3) {
    var_5 hide();
  }

  ref_1437b();

  foreach(var_8 in level.players) {
    scripts\cp\laser_traps\cp_laser_traps::ref_12486(var_8);
    var_8 setsoundsubmix("cp_infil_duck_vehicles", 0.5);
  }

  scripts\engine\utility::delaythread(1, &ref_12758, "dx_mpa_ustl_order_attack");
  var_10 = level.vehicle.templates.aianims[var_1 scripts\common\vehicle_code::get_vehicle_classname()];
  var_11 = var_10[0].vehicle_getoutanim;
  thread scripts\cp\vehicle::matchdata_logweaponstat(var_1, var_11);
  var_12 = 11;
  wait var_12;
  scripts\engine\utility::delaythread(4, &ref_12758, "dx_mpa_ustl_under_attack_friendly_heli");
  scripts\engine\utility::flag_set("intro_heli_can_crash");
  missile_deleteattractor(var_2);
  waitframe();
  var_13 = missile_createattractorent(var_1, 999999, 2000);

  for(;;) {
    var_1 waittill("damage", var_14, var_14, var_14, var_14, var_14, var_14, var_14, var_14, var_14, var_15);
  }

  LOC_00000184:
    scripts\engine\utility::delaythread(1.5, &ref_12758, "dx_mpa_ustl_destroyed_friendly_heli");
  missile_deleteattractor(var_13);
  var_1 notify("stop_flyloop");
  scripts\engine\utility::flag_set("intro_heli_crashing");
  heli_crash(var_1, var_3);
  scripts\cp\laser_traps\cp_laser_traps::little_bird_mg_cp_ondeathrespawncallback();
}

function skipprematch(var_0) {
  self notify("stop_heli_screenshake");
  self endon("stop_heli_screenshake");
  self endon("death");

  if(istrue(var_0)) {
    var_1 = 0.45;
    goto LOC_00000031;
  }

  var_1 = 0.14;

  for(;;) {
    if(istrue(var_1)) {
      earthquake(0.3, var_1, level.trial_shooters.origin, 5000);

      foreach(var_3 in level.players) {
        var_3 playRumbleOnEntity("damage_heavy");
      }

      wait var_1 * 0.5;
      continue;
    }

    earthquake(0.12, var_1, level.trial_shooters.origin, 5000);

    foreach(var_3 in level.players) {
      var_3 playRumbleOnEntity("damage_light");
    }

    wait var_1 * 0.5;
  }
}

function skip_overheat() {
  self endon("stop_flyloop");
  var_0 = scripts\engine\utility::getStruct("intro_heli_path1", "targetname");
  var_1 = var_0;
  self vehicle_setspeed(40, 20);

  for(;;) {
    self setneargoalnotifydist(200);
    self setvehgoalpos(var_1.origin);
    scripts\engine\utility::ref_143a5("near_goal", "goal");

    if(isDefined(var_1.target)) {
      var_1 = scripts\engine\utility::getStruct(var_1.target, "targetname");
      continue;
    }

    var_1 = var_0;
  }
}

function heli_crash(var_0) {
  thread skipprematch(1);
  self setmaxpitchroll(25, 25);
  var_1 = scripts\engine\utility::getStructArray("intro_heli_deathpath", "script_noteworthy");
  var_1 = sortbydistance(var_1, self.origin);
  var_2 = var_1[0];
  thread ref_12758("dx_cps_ushp_rescue_pilot_start_20");
  self playLoopSound("cp_br_syrk_chopper_dying_loop");
  var_3 = var_2;
  thread heli_spin();
  self vehicle_setspeed(80, 50, 50);
  self setyawspeed(150, 50, 50, 0);
  var_4 = "heli_crash_early";
  thread sixthsense_inotherplayertargetcone(self, var_4);

  foreach(var_6 in level.players) {
    mountain_one_death_func(var_6);
  }

  for(;;) {
    self setneargoalnotifydist(200);
    self setvehgoalpos(var_3.origin);
    var_8 = scripts\engine\utility::ref_143ae("near_goal", "goal", var_4);

    if(!isDefined(var_3.target) || var_8 == var_4) {
      break;
    }

    var_3 = scripts\engine\utility::getStruct(var_3.target, "targetname");
  }

  self notify("stop_heli_spin");
  thread scripts\engine\utility::play_sound_in_space("hind_helicopter_crash_infil", self.origin);

  foreach(var_6 in level.players) {
    var_6 clearsoundsubmix("cp_infil_duck_vehicles", 2);
  }

  foreach(var_12 in var_0) {
    var_12 show();
  }

  foreach(var_6 in level.players) {
    scripts\cp\laser_traps\cp_laser_traps::ref_12484(var_6);
    ref_12c5a(var_6);
  }

  playFX(level._effect["vfx_hway_car_fire_1"], (-1434.42, -2929.26, 1105.3));
  scripts\engine\utility::delaycall(0.2, &delete);
}

function mountain_one_death_func() {}

function ref_12c5a() {}

function sixthsense_inotherplayertargetcone(var_0, var_1) {
  var_0 endon("stop_heli_spin");
  var_2 = scripts\engine\utility::getStructArray("default_player_start", "targetname");
  var_3 = scripts\cp\utility\entity::getaverageorigin(var_2)[2];

  for(;;) {
    var_4 = 0;

    foreach(var_6 in level.players) {
      if(var_6.origin[2] <= var_3) {
        var_4 = 1;
        break;
      }
    }

    if(var_4) {
      break;
    }

    waitframe();
  }

  var_0 notify(var_1);
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
  var_0 = scripts\engine\utility::getStructArray("intro_enemy_initial", "targetname");
  scripts\engine\utility::array_thread(var_0, &thermiteradiusdamage);
  var_1 = scripts\engine\utility::getStructArray("intro_enemy", "targetname");
  scripts\engine\utility::array_thread(var_1, &trial_rpg_settings);
}

function thermiteradiusdamage() {
  var_0 = scripts\cp\laser_traps\cp_laser_traps::spawn_ai();

  if(isDefined(var_0)) {
    var_0 endon("death");
    var_0 setentitytarget(level.trial_shooters, 1);
    scripts\engine\utility::flag_wait("intro_heli_crashing");
    var_1 = scripts\engine\utility::getStructArray("intro_enemy_spawner", "targetname");
    var_1 = sortbydistance(var_1, var_0.origin);
    var_0.ignoreall = 1;
    var_0.goalradius = 32;
    var_0 setgoalpos(var_1[0].origin);
    var_0 waittill("goal");
    var_0 scripts\cp\laser_traps\cp_laser_traps::ks_pointstowin();
    return;
  }
}

function trial_rpg_settings() {
  level.trial_shooters endon("stop_heli_spin");

  for(;;) {
    var_0 = scripts\cp\laser_traps\cp_laser_traps::spawn_ai();

    if(isDefined(var_0)) {
      var_0.script_forcegoal = 1;
      var_0.dontevershoot = 1;
      var_0.solospawn = 1;
      var_0.goalradius = 20;
      self.rocketammo = 200;
      skipplaybodycountsound(var_0);

      if(scripts\engine\utility::flag("intro_heli_crashing")) {
        if(isalive(var_0)) {
          thread skipleaderupdate(var_0);
        }

        return;
      }
    }

    wait randomfloatrange(1, 3);
  }
}

function skipleaderupdate(var_0) {
  self endon("death");
  self.ignoreall = 1;
  self.goalradius = 32;
  self.dontevershoot = 1;
  self setgoalpos(var_0.origin);
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
  var_0 = scripts\engine\utility::getStructArray("enemy_spawner", "targetname");
  var_1 = [0, 20, 30, 40, 50];
  var_2 = var_1[level.players.size];
  var_3 = 0.25;

  while(var_2 > 0) {
    var_4 = var_0[randomint(var_0.size)];
    var_5 = var_4 scripts\cp\laser_traps\cp_laser_traps::spawn_ai();

    if(isDefined(var_5)) {
      var_2--;
    }

    wait var_3;
  }

  var_6 = [0, 15, 20, 25, 30];
  var_7 = var_6[level.players.size];
  var_8 = 2;

  for(;;) {
    if(getaiarray("axis").size < var_7) {
      var_4 = var_0[randomint(var_0.size)];
      var_5 = var_4 scripts\cp\laser_traps\cp_laser_traps::spawn_ai();
    }

    wait var_8;
  }
}

function skipignoredamage() {
  set_objective("exfil");
  var_0 = getEnt("exfil_heli_spawner", "targetname");
  var_0.vehicletype = "mindia8_minimap";
  var_1 = var_0 scripts\common\vehicle::spawn_vehicle_and_gopath();
  var_1 sethoverparams(0, 0, 0);
  var_1 setvehicleteam("allies");
  var_2 = scripts\cp\cp_objectives::requestworldid("objective_exfil", 3);
  objective_setdescription(var_2, &"CP_SO_HIGHWAY/OBJECTIVE_GET_TO_EXFIL_CHOPPER");
  objective_setplayintro(var_2, 1);
  objective_setplayoutro(var_2, 0);
  objective_onentity(var_2, var_1);
  objective_state(var_2, "current");
  objective_icon(var_2, "icon_waypoint_objective_general");
  var_3 = spawn("script_model", var_1.origin);
  var_3 dontinterpolate();
  var_4 = getEnt("care_package_col", "targetname");
  var_3 clonebrushmodeltoscriptmodel(var_4);
  var_3 linkTo(var_1, "tag_origin", (-144, 16, -192), (0, 0, 0));
  var_3 = spawn("script_model", var_1.origin);
  var_3 dontinterpolate();
  var_4 = getEnt("care_package_col", "targetname");
  var_3 clonebrushmodeltoscriptmodel(var_4);
  var_3 linkTo(var_1, "tag_origin", (-144, -16, -192), (0, 0, 0));
  var_5 = getEnt("leave_player_trigger", "targetname");
  var_5 enablelinkTo();
  var_5 linkTo(var_1, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_1 scripts\common\vehicle::godon();
  var_6 = 1500;
  var_7 = 0;

  for(;;) {
    var_8 = 1;

    foreach(var_10 in level.players) {
      if(!isalive(var_10)) {
        continue;
      }

      if(!var_10 istouching(var_5)) {
        var_8 = 0;
        break;
      }
    }

    if(var_8) {
      if(!var_7) {
        var_7 = gettime();
      }

      if(gettime() >= var_7 + var_6) {
        break;
      }
    } else {
      var_7 = 0;
    }

    waitframe();
  }

  objective_state(var_2, "done");

  foreach(var_13 in level.outofboundstriggers) {
    var_13.origin -= (0, 0, 10000);
  }

  scripts\engine\utility::flag_set("leave_lz");

  foreach(var_10 in level.players) {
    if(!isalive(var_10)) {
      continue;
    }

    var_16 = var_10 scripts\engine\utility::spawn_tag_origin();
    var_16 linkTo(var_1);
    var_10 playerlinkTo(var_16, "tag_origin", 0, 180, 180, 180, 180, 0);
  }

  scripts\engine\utility::delaythread(2, &ref_12758, "dx_mpa_ustl_gamestate_lost_health");
  var_18 = 4;
  wait var_18;
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

function spawn_civ(var_0, var_1) {
  var_2 = var_0 scripts\cp\laser_traps\cp_laser_traps::ref_134f1("civilian_cp_desert", var_0.origin, var_0.angles);

  if(isDefined(var_2)) {
    level.hacking_player_nearby.civs[level.hacking_player_nearby.civs.size] = var_2;

    if(isDefined(var_1.radius)) {
      var_2.goalradius = var_1.radius;
    } else {
      var_2.goalradius = 200;
    }

    var_2 setgoalpos(var_1.origin);
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

function nextdest(var_0) {
  self endon("death");
  self endon("entitydeleted");
  self.ignoreall = 1;
  self.script_pushable = 1;
  self.goalradius = 80;
  self setgoalpos(var_0.origin);
  scripts\engine\utility::waittill_notify_or_timeout("goal", 20);
  scripts\cp\laser_traps\cp_laser_traps::ks_pointstowin();
}

function no_previous_interaction_point() {
  var_0 = scripts\cp\utility::getplayersinteam("allies");
  var_0 = sortbydistance(var_0, self.origin);
  self.goalradius = 300;
  self setgoalpos(var_0[0].origin);
}

function ref_12db1() {
  var_0 = int(tablelookupbyrow("scripts/cp/maps/cp_so_highway/cp_so_highway_round_enemies.csv", level.ref_12db9, level.players.size));
  var_1 = scripts\engine\utility::getStructArray("enemy_spawner", "targetname");
  var_2 = 1;

  while(var_0 > 0) {
    var_3 = var_1[randomint(var_1.size)];
    var_4 = var_3 scripts\cp\laser_traps\cp_laser_traps::spawn_ai();

    if(isDefined(var_4)) {
      var_0--;
      thread ref_12da8(var_4);
    }

    wait var_2;
  }
}

function ref_12da8(var_0) {
  var_1 = var_0.origin;
  wait 8;
  var_2 = squared(200);

  if(distance2dsquared(var_1, var_0.origin) > var_2) {
    return;
  }

  var_0 scripts\cp\laser_traps\cp_laser_traps::ks_pointstowin();
}

function ref_12db6() {
  var_0 = int(tablelookupbyrow("scripts/cp/maps/cp_so_highway/cp_so_highway_round_fallback.csv", level.ref_12db9, level.players.size));

  while(getaiarray("axis").size > var_0) {
    waitframe();
  }
}

function init_spawners() {
  scripts\cp\laser_traps\cp_laser_traps::array_spawn_function_targetname("enemy_spawner", &nodetype);
  scripts\cp\laser_traps\cp_laser_traps::array_spawn_function_targetname("smoke_enemy_spawner", &ref_13420);
  var_0 = getEntArray("vehicle_spawn", "targetname");

  foreach(var_2 in var_0) {
    var_3 = scripts\engine\utility::getStructArray(var_2.target, "targetname");

    foreach(var_5 in var_3) {
      var_5 scripts\cp\laser_traps\cp_laser_traps::add_spawn_function(&ref_1420c);
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

  var_0 = scripts\engine\utility::getStructArray("enemy_entry_struct", "targetname");
  var_1 = [];
  jumpiffalse(self.origin[0] < -1100) LOC_000000a1;

  foreach(var_3 in var_0) {
    if(var_3.origin[0] < -1100) {
      var_1 = var_3;
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
  var_0 = scripts\engine\utility::getStructArray("hardpoint", "targetname");
  var_1 = scripts\cp\laser_traps\cp_laser_traps::get_least_used_from_array(var_0);
  self.maxsightdistsqrd = 160000;
  self.goalradius = 400;
  scripts\cp\laser_traps\cp_laser_traps::go_to_node(var_1);
  wait randomfloatrange(5, 10);
  var_2 = scripts\engine\utility::random(level.players);
  var_3 = distance(var_2.origin, self.origin);
  self.goalradius = var_3;
  self setgoalpos(var_2.origin);

  for(;;) {
    var_3 -= randomintrange(50, 300);
    var_3 = max(var_3, 400);
    self.goalradius = var_3;
    wait randomfloatrange(3, 10);
  }
}

function ref_12dab(var_0) {
  var_1 = getEntArray("mortars_start_model", "targetname");
  var_2 = 1;
  var_3 = 2;
  var_4 = ref_11d37();
  var_5 = scripts\engine\utility::random(var_4);

  for(var_6 = 0; var_6 < var_0; var_6++) {
    var_7 = randomfloatrange(var_2, var_3);
    wait var_7;
    var_8 = scripts\engine\utility::random(var_1);
    var_9 = scripts\engine\utility::getStruct(var_8.target, "targetname");
    var_10 = scripts\cp\laser_traps\cp_laser_traps::ref_134f1(var_9.script_type, var_9.origin, var_9.angles);

    if(!isDefined(var_10)) {
      continue;
    }

    var_10.ignoreall = 1;
    var_10.ignoreme = 1;
    var_10.stadium_two_death_func = 1;
    var_10 allowedstances("crouch");
    var_10.goalradius = 20;
    var_10 setgoalpos(var_10.origin);
    var_10.health = 1;
    var_10 scripts\cp\laser_traps\cp_laser_traps::disable_long_death();
    var_10.targetname = "mortars_enemy";
    thread ref_11d35(var_10, var_8, var_5);
    var_1 = scripts\engine\utility::array_remove(var_1, var_8);

    if(isDefined(var_5)) {
      var_4 = scripts\engine\utility::array_remove(var_4, var_5);
    }
  }
}

function ref_11d37() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(istrue(ref_11d39(var_2))) {
      continue;
    }

    if(var_2 islinked()) {
      continue;
    }

    if(var_2 scripts\cp_mp\killstreaks\gunship::isusinggunship()) {
      continue;
    }

    if(var_2 scripts\cp_mp\killstreaks\chopper_gunner::isusingchoppergunner()) {
      continue;
    }

    var_0 = scripts\engine\utility::array_add(var_0, var_2);
  }

  return var_0;
}

function ref_11d3a(var_0, var_1) {
  var_0.update_hint_logic_juggernaut = var_1;
}

function ref_11d39(var_0, var_1) {
  return var_0.update_hint_logic_juggernaut;
}

function ref_11d35(var_0, var_1, var_2) {
  var_0 endon("death");
  var_3 = scripts\engine\utility::getStructArray("mortars_impact_miss_struct", "targetname");
  var_4 = var_1.origin;
  var_5 = "mortar_impact";
  var_6 = 2;
  var_7 = 1;
  var_8 = 3;
  var_9 = 5;
  var_10 = squared(500);

  if(isDefined(var_2)) {
    var_11 = var_2.origin;
  } else {
    var_11 = undefined;
  }

  var_12 = 0.5;
  var_13 = 2;
  var_14 = randomfloatrange(var_12, var_13);
  wait var_14;

  for(;;) {
    var_15 = isDefined(var_3) && (var_8 == 1 || var_8 >= var_9 || var_8 >= var_10);

    if(var_15) {
      var_16 = var_3.origin;
    } else {
      var_17 = scripts\engine\utility::random(var_4);
      var_16 = var_17.origin;
    }

    thread ref_11d36(var_2, var_5, var_16, var_6);
    level waittill(var_6, var_18);

    if(!isDefined(var_3) || !isalive(var_3)) {
      var_19 = ref_11d37();
      var_3 = scripts\engine\utility::random(var_19);

      if(isDefined(var_3)) {
        var_11 = var_3.origin;
      }
    }

    if(isDefined(var_3)) {
      var_20 = distance2dsquared(var_11, var_3.origin) >= var_11;

      if(var_20) {
        var_8 = 1;
        var_11 = var_3.origin;
      }

      if(var_8 == 1) {
        var_3 shellshock("default_nosound", 2);
        var_3 dodamage(3, var_18, undefined, undefined, "MOD_EXPLOSIVE");
      } else if(var_8 >= var_9) {
        var_3 shellshock("default_nosound", 2);
        var_3 dodamage(20, var_18, undefined, undefined, "MOD_EXPLOSIVE");
      }

      if(var_8 >= var_10) {
        var_3 dodamage(99999, var_18, undefined, undefined, "MOD_EXPLOSIVE");
      }

      var_8++;
    }

    var_21 = max(1, ref_11d38().size);
    var_22 = var_21 * var_7;
    wait var_22;
  }
}

function ref_11d38() {
  return getEntArray("mortars_enemy", "targetname");
}

function ref_11d36(var_0, var_1, var_2, var_3) {
  thread scripts\engine\utility::play_sound_in_space("mortar_fire_dist", var_1);
  physicsexplosionsphere(var_1, 350, 350, 200);
  var_4 = spawn("script_model", var_1);
  var_4 setModel("equipment_mortar_shell_improvised_01");
  var_5 = 0.15;
  wait var_5;
  playFX(level._effect["vfx_mortar_fire"], var_1, anglesToForward(var_0.angles));
  playFXOnTag(level._effect["vfx_mortar_trail"], var_4, "tag_origin");
  var_6 = lookupsoundlength("mortar_trail") * 0.001 * 0.8;
  var_7 = max(0.05, 7 - var_6 - 0.5);
  var_4 scripts\engine\utility::delaycall(var_7, &playsound, "mortar_incoming");
  var_8 = 0.00714286;
  var_9 = 0;

  while(var_9 < 1) {
    var_10 = var_4.origin;
    var_4.origin = scripts\engine\math::get_point_on_parabola(var_1, var_2, 2500, var_9);
    var_4.angles = vectortoangles(var_4.origin - var_10);
    var_9 += var_8;
    waitframe();
  }

  var_4 stoploopsound("weap_mortar_fly_lp");
  level notify(var_3, var_4.origin);
  mortars_explodemortarprojectile(var_4, var_0);
}

function mortars_explodemortarprojectile(var_0, var_1) {
  var_2 = var_0.origin;
  var_0 delete();
  physicsexplosionsphere(var_2, 2000, 1000, 150);
  var_3 = 0.24;
  var_4 = max(1, ref_11d38().size);
  var_5 = var_3 / var_4;
  earthquake(var_5, 1, var_2, 3000);
  playrumbleonposition("damage_heavy", var_2);
  thread scripts\engine\utility::play_sound_in_space("weap_mortar_expl_trans", var_2);
  playFX(level._effect["vfx_mortar_impact"], var_2);
}

function israndompistolloadouts() {}

function set_objective(var_0) {
  if(!isDefined(level.weapondrop_createdropondeath)) {
    level.weapondrop_createdropondeath = [];
    level.weapondrop_createdropondeath["survive"] = 2;
    level.weapondrop_createdropondeath["exfil"] = 3;
    setomnvar("cp_objective_index", 1);
  }

  setomnvar("cp_objective_sub_1_index", level.weapondrop_createdropondeath[var_0]);
}

#using_animtree("");

function support_box_delay_max_ammo_hint() {
  level.scr_animtree["player"] = #animtree;
  level.scr_anim["player"]["intro_idle"] = $sdr_cp_veh_lbravo_seat_2_idle;
  level.scr_animname["player"]["intro_idle"] = "sdr_cp_veh_lbravo_seat_2_idle";
  level.scr_eventanim["player"]["intro_idle"] = "cp_blima_idle";
}
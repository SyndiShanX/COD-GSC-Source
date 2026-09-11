/***************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_sv_bigstore\cp_sv_bigstore_create_script.gsc
***************************************************************************/

function main(var0, var1) {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("cp_sv_bigstore_create_script")) {
    return;
  }

  scripts\engine\utility::flag_init("cp_sv_bigstore_create_script");
  var2 = spawnStruct();
  thread cs_return_and_wait_for_flag(level, var0, var1, var2);

  if(!scripts\cp\so_trigger::cs_is_starttime()) {
    scripts\cp\so_trigger::endcreatescript(var2);
    return;
  }
}

function cs_return_and_wait_for_flag(var0, var1, var2, var3) {
  scripts\cp\so_trigger::wait_for_cs_flag(var3);

  if(!isDefined(var1)) {
    var1 = "stk";
  }

  var2 scripts\cp\so_trigger::strike_setup_arrays(var1, "cp_sv_bigstore_create_script");
  scripts\cp\so_trigger::cs_init_flags(var2);
  thread createstructs(level, var2, var1);
  thread createtriggers(level, var2, var1);

  if(istrue(var0)) {
    level thread scripts\cp\so_trigger::wait_for_flags(var2, "cp_sv_bigstore_create_script");
    return;
  }

  scripts\cp\so_trigger::wait_for_flags(var2, "cp_sv_bigstore_create_script");
}

function createstructs(var0, var1, var2) {
  var3 = &scripts\cp\so_trigger::strike_additem;
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1198.67, -3144.2, 3076), (0, 314, 0), "auto1", "auto2", "heli_search", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (193.39, -12980, 1229), (0, 198, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-1176.65, -3442.71, 3076), (0, 314, 0), "auto4", "auto1", "heli_search", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1650.47, 1752, 3076), (0, 314, 0), "auto2", "auto3", "heli_search", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-632.5, 2004, 3076), (0, 314, 0), "auto3", "auto4", "heli_search", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (865.69, 3142.73, 1707.1), (0.68, 90.64, 0.27), undefined, undefined, undefined, undefined, "82", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\so_trigger::s();
  var4.script_demeanor = "default";
  var4.script_function = "escalation_heli_spawn";
  var4.script_goalyaw = "1";
  var4.script_team = "axis";
  var4.script_unload = "default";
  var0[[var3]](var4, var1, var2, (-530.16, 2897.52, 694), (2.29, 180.47, 1.3), "wave_veh_spawners", undefined, "default", "72 74 75 76 77 78 79 80 81 82 83 84", "73", undefined, undefined, 450, undefined, 40);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (5614.33, 8320.51, 644.9), (0.28, 0.97, -0.68), "heli_spawner", undefined, undefined, "73", "72", undefined, undefined, 512, 50, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1324.34, 3337.42, 1932.7), (0.68, 90.64, 0.27), undefined, undefined, undefined, undefined, "81", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (2806.03, 4609.97, 2492.7), (0.68, 90.64, 0.27), undefined, undefined, undefined, undefined, "77", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1741.66, 3582.87, 2123.9), (0.68, 90.64, 0.27), undefined, undefined, undefined, undefined, "80", undefined, undefined, 512, 40, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (2144.24, 3882.71, 2314.4), (0.68, 90.64, 0.27), undefined, undefined, undefined, undefined, "79", undefined, undefined, 512, 40, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (2501.78, 4240.41, 2496.5), (0.68, 90.64, 0.27), undefined, undefined, undefined, undefined, "78", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (424.96, 2997.08, 1558.9), (0.68, 90.64, 0.27), undefined, undefined, undefined, undefined, "83", undefined, undefined, 512, 30, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-31.69, 2907.61, 1426.1), (0.68, 90.64, 0.27), undefined, undefined, undefined, undefined, "84", undefined, undefined, 512, 30, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-266.66, 4551.8, 853.8), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-3458.42, -6076.06, 791.9), (0, 165, 0), "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-951.82, -4655.04, 1707.1), (0.68, 358.64, 0.27), undefined, undefined, undefined, undefined, "69", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\so_trigger::s();
  var4.script_demeanor = "default";
  var4.script_function = "escalation_heli_spawn";
  var4.script_goalyaw = "1";
  var4.script_team = "axis";
  var4.script_unload = "default";
  var0[[var3]](var4, var1, var2, (-1148.16, -3251.48, 694), (2.29, 88.46, 1.3), "wave_veh_spawners", undefined, "default", "59 61 62 63 64 65 66 67 68 69 70 71", "60", undefined, undefined, 450, undefined, 40);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (4057.1, -9581.48, 644.9), (0.28, 268.97, -0.68), "heli_spawner", undefined, undefined, "60", "59", undefined, undefined, 512, 50, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-773.24, -5120.2, 1932.7), (0.68, 358.64, 0.27), undefined, undefined, undefined, undefined, "68", undefined, undefined, 512, 35, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (446.83, -6645.4, 2492.7), (0.68, 358.64, 0.27), undefined, undefined, undefined, undefined, "64", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-542.5, -5545.84, 2123.9), (0.68, 358.64, 0.27), undefined, undefined, undefined, undefined, "67", undefined, undefined, 512, 40, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-256.9, -5958.64, 2314.4), (0.68, 358.64, 0.27), undefined, undefined, undefined, undefined, "66", undefined, undefined, 512, 40, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (88.11, -6328.44, 2496.5), (0.68, 358.64, 0.27), undefined, undefined, undefined, undefined, "65", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (3115.68, -610.9, 973), undefined, "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-2979.11, -1039.3, 865.8), (0, 75, 0), "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (154.28, -843.01, 1349), (0, 75, 0), "helicopter_crash_location", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (7249.39, -12156, 1229), (0, 198, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (13361.4, -5780, 1229), (0, 198, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (14865.4, 3036, 1229), (0, 198, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (12601.4, 9908, 1229), (0, 198, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (6721.4, 12844, 1229), (0, 198, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1065.4, 12892, 1229), (0, 198, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-6086.6, 12052, 1229), (0, 198, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-11462.6, 7324, 1229), (0, 198, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-13118.6, 876, 1229), (0, 198, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-12998.6, -3740, 1229), (0, 198, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-11046.6, -8468, 1229), (0, 198, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-7486.6, -13692, 1229), (0, 198, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-3478.6, -14252, 1229), (0, 198, 0), "heli_exit", undefined, "deleteme", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-1081.99, -4209.49, 1558.9), (0.68, 358.64, 0.27), undefined, undefined, undefined, undefined, "70", undefined, undefined, 512, 30, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (-1155.47, -3750, 1426.1), (0.68, 358.64, 0.27), undefined, undefined, undefined, undefined, "71", undefined, undefined, 512, 30, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1036.37, -7178.47, 2483.1), (0.68, 358.64, 0.27), undefined, undefined, undefined, undefined, "63", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (1940.06, -7882.67, 2468.9), (0.68, 358.64, 0.27), undefined, undefined, undefined, undefined, "62", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (2971.67, -8591.39, 2453.2), (0.68, 358.64, 0.27), undefined, undefined, undefined, undefined, "61", undefined, undefined, 512, 50, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (3318.2, 5217.76, 2483.1), (0.68, 90.64, 0.27), undefined, undefined, undefined, undefined, "76", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (3990.44, 6145.48, 2468.9), (0.68, 90.64, 0.27), undefined, undefined, undefined, undefined, "75", undefined, undefined, 512, 45, undefined);
  var4 = scripts\cp\so_trigger::s();
  var0[[var3]](var4, var1, var2, (4662.72, 7201.19, 2453.2), (0.68, 90.64, 0.27), undefined, undefined, undefined, undefined, "74", undefined, undefined, 512, 50, undefined);
  var0 scripts\engine\utility::ent_flag_set("cs_structs_complete");
}

function createtriggers(var0, var1, var2) {
  var0 scripts\engine\utility::ent_flag_set("cs_triggers_complete");
}
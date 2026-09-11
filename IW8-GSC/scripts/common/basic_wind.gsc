/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\basic_wind.gsc
***********************************************/

function load_wind(var_0, var_1) {
  var_2 = ["n", "ne", "e", "se", "s", "sw", "w", "nw"];
  var_3 = ["weak", "medium", "strong"];
  var_4 = "vfx/iw8/wind/basic_directions/vfx_basic_wind_";
  var_5 = var_2[get_wind_index(var_0)] + "_" + var_3[var_1][0];
  var_6 = var_4 + var_0 + "_" + var_3[var_1] + ".vfx";
  level.g_effect[var_5] = loadfx(var_6);
}

function load_debug_particles() {
  level.g_effect["wind_debug"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_debug.vfx");
}

function load_all_wind() {
  level.g_effect["wind_debug"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_debug.vfx");
  level.g_effect["n_w"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_north_weak.vfx");
  level.g_effect["n_m"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_north_medium.vfx");
  level.g_effect["n_s"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_north_strong.vfx");
  level.g_effect["ne_w"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_northeast_weak.vfx");
  level.g_effect["ne_m"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_northeast_medium.vfx");
  level.g_effect["ne_s"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_northeast_strong.vfx");
  level.g_effect["e_w"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_east_weak.vfx");
  level.g_effect["e_m"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_east_medium.vfx");
  level.g_effect["e_s"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_east_strong.vfx");
  level.g_effect["se_w"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_southeast_weak.vfx");
  level.g_effect["se_m"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_southeast_medium.vfx");
  level.g_effect["se_s"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_southeast_strong.vfx");
  level.g_effect["s_w"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_south_weak.vfx");
  level.g_effect["s_m"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_south_medium.vfx");
  level.g_effect["s_s"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_south_strong.vfx");
  level.g_effect["sw_w"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_southwest_weak.vfx");
  level.g_effect["sw_m"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_southwest_medium.vfx");
  level.g_effect["sw_s"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_southwest_strong.vfx");
  level.g_effect["w_w"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_west_weak.vfx");
  level.g_effect["w_m"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_west_medium.vfx");
  level.g_effect["w_s"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_west_strong.vfx");
  level.g_effect["nw_w"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_northwest_weak.vfx");
  level.g_effect["nw_m"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_northwest_medium.vfx");
  level.g_effect["nw_s"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_northwest_strong.vfx");
}

function init_wind(var_0, var_1, var_2) {
  var_3 = get_wind_index(var_0);
  var_4 = wind_index(var_3, var_1);
  var_5 = level.g_effect[var_4];

  if(var_2 == 1) {
    var_6 = spawnfx(var_5, (0, 0, 0));
    triggerfx(var_6);
    return undefined;
  }

  var_7 = scripts\engine\utility::spawn_tag_origin();
  playFXOnTag(var_6, var_7, "tag_origin");
  var_8 = spawnStruct();
  var_8.id = var_6;
  var_8.fxtag = var_7;
  var_8.tagorigin = "tag_origin";
  return var_8;
}

function init_wind_at_point(var_0, var_1, var_2, var_3) {
  var_4 = get_wind_index(var_0);
  var_5 = wind_index(var_4, var_1);
  var_6 = level.g_effect[var_5];

  if(var_3 == 1) {
    var_7 = spawnfx(var_6, var_2);
    triggerfx(var_7);
    return undefined;
  }

  var_8 = scripts\engine\utility::spawn_tag_origin();
  var_8.point = var_3;
  playFXOnTag(var_7, var_8, "tag_origin");
  var_9 = spawnStruct();
  var_9.id = var_7;
  var_9.fxtag = var_8;
  var_9.tagorigin = "tag_origin";
  return var_9;
}

function stop_wind(var_0) {
  if(isDefined(var_0)) {
    stopFXOnTag(var_0.id, var_0.fxtag, var_0.tagorigin);
    return;
  }
}

function set_wind_amplitude(var_0) {
  setsaveddvar("MQPQKNPQOK", var_0);
}

function set_wind_frequency(var_0) {
  setsaveddvar("MRNRKKOPLN", var_0);
}

function set_wind_area_scale(var_0) {
  setsaveddvar("LQLSPQOPKM", var_0);
}

function spawn_debug_particles(var_0) {
  var_1 = level.g_effect["wind_debug"];
  var_2 = scripts\engine\utility::spawn_tag_origin();
  playFXOnTag(var_1, var_2, "tag_origin");
}

function get_wind_index(var_0) {
  switch (var_0) {
    case "north":
      return 0;
    case "northeast":
      return 1;
    case "east":
      return 2;
    case "southeast":
      return 3;
    case "south":
      return 4;
    case "southwest":
      return 5;
    case "west":
      return 6;
    case "northwest":
      return 7;
    default:
      iprintlnbold("ERROR: Improper wind string!No index for " + var_0);
      return -1;
  }
}

function get_wind_string(var_0) {
  var_1 = ["north", "northeast", "east", "southeast", "south", "southwest", "west", "northwest"];
  return var_1[var_0];
}

function wind_index(var_0, var_1) {
  var_2 = [];
  GscBinSkip0(0x2e, 0, ["n_w", "n_m", "n_s"]);
}
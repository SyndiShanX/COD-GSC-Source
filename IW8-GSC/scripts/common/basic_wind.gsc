/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\basic_wind.gsc
***********************************************/

function load_wind(var0, var1) {
  var2 = ["n", "ne", "e", "se", "s", "sw", "w", "nw"];
  var3 = ["weak", "medium", "strong"];
  var4 = "vfx/iw8/wind/basic_directions/vfx_basic_wind_";
  var5 = var2[get_wind_index(var0)] + "_" + var3[var1][0];
  var6 = var4 + var0 + "_" + var3[var1] + ".vfx";
  level.g_effect[var5] = loadfx(var6);
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

function init_wind(var0, var1, var2) {
  var3 = get_wind_index(var0);
  var4 = wind_index(var3, var1);
  var5 = level.g_effect[var4];

  if(var2 == 1) {
    var6 = spawnfx(var5, (0, 0, 0));
    triggerfx(var6);
    return undefined;
  }

  var7 = scripts\engine\utility::spawn_tag_origin();
  playFXOnTag(var6, var7, "tag_origin");
  var8 = spawnStruct();
  var8.id = var6;
  var8.fxtag = var7;
  var8.tagorigin = "tag_origin";
  return var8;
}

function init_wind_at_point(var0, var1, var2, var3) {
  var4 = get_wind_index(var0);
  var5 = wind_index(var4, var1);
  var6 = level.g_effect[var5];

  if(var3 == 1) {
    var7 = spawnfx(var6, var2);
    triggerfx(var7);
    return undefined;
  }

  var8 = scripts\engine\utility::spawn_tag_origin();
  var8.point = var3;
  playFXOnTag(var7, var8, "tag_origin");
  var9 = spawnStruct();
  var9.id = var7;
  var9.fxtag = var8;
  var9.tagorigin = "tag_origin";
  return var9;
}

function stop_wind(var0) {
  if(isDefined(var0)) {
    stopFXOnTag(var0.id, var0.fxtag, var0.tagorigin);
    return;
  }
}

function set_wind_amplitude(var0) {
  setsaveddvar("MQPQKNPQOK", var0);
}

function set_wind_frequency(var0) {
  setsaveddvar("MRNRKKOPLN", var0);
}

function set_wind_area_scale(var0) {
  setsaveddvar("LQLSPQOPKM", var0);
}

function spawn_debug_particles(var0) {
  var1 = level.g_effect["wind_debug"];
  var2 = scripts\engine\utility::spawn_tag_origin();
  playFXOnTag(var1, var2, "tag_origin");
}

function get_wind_index(var0) {
  switch (var0) {
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
      iprintlnbold("ERROR: Improper wind string!No index for " + var0);
      return -1;
  }
}

function get_wind_string(var0) {
  var1 = ["north", "northeast", "east", "southeast", "south", "southwest", "west", "northwest"];
  return var1[var0];
}

function wind_index(var0, var1) {
  var2 = [];
  GscBinSkip0(0x2e, 0, ["n_w", "n_m", "n_s"]);
}
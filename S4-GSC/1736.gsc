/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1736.gsc
*************************************************/

_id_9611(var_0, var_1) {
  var_2 = ["n", "ne", "e", "se", "s", "sw", "w", "nw"];
  var_3 = ["weak", "medium", "strong"];
  var_4 = "vfx/iw8/wind/basic_directions/vfx_basic_wind_";
  var_5 = var_2[_id_6862(var_0)] + "_" + var_3[var_1][0];
  var_6 = var_4 + var_0 + "_" + var_3[var_1] + ".vfx";
  level._id_60A1[var_5] = loadfx(var_6);
}

_id_95BA() {
  level._id_60A1["wind_debug"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_debug.vfx");
}

_id_95AB() {
  level._id_60A1["wind_debug"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_debug.vfx");
  level._id_60A1["n_w"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_north_weak.vfx");
  level._id_60A1["n_m"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_north_medium.vfx");
  level._id_60A1["n_s"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_north_strong.vfx");
  level._id_60A1["ne_w"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_northeast_weak.vfx");
  level._id_60A1["ne_m"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_northeast_medium.vfx");
  level._id_60A1["ne_s"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_northeast_strong.vfx");
  level._id_60A1["e_w"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_east_weak.vfx");
  level._id_60A1["e_m"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_east_medium.vfx");
  level._id_60A1["e_s"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_east_strong.vfx");
  level._id_60A1["se_w"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_southeast_weak.vfx");
  level._id_60A1["se_m"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_southeast_medium.vfx");
  level._id_60A1["se_s"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_southeast_strong.vfx");
  level._id_60A1["s_w"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_south_weak.vfx");
  level._id_60A1["s_m"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_south_medium.vfx");
  level._id_60A1["s_s"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_south_strong.vfx");
  level._id_60A1["sw_w"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_southwest_weak.vfx");
  level._id_60A1["sw_m"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_southwest_medium.vfx");
  level._id_60A1["sw_s"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_southwest_strong.vfx");
  level._id_60A1["w_w"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_west_weak.vfx");
  level._id_60A1["w_m"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_west_medium.vfx");
  level._id_60A1["w_s"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_west_strong.vfx");
  level._id_60A1["nw_w"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_northwest_weak.vfx");
  level._id_60A1["nw_m"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_northwest_medium.vfx");
  level._id_60A1["nw_s"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_northwest_strong.vfx");
}

_id_8117(var_0, var_1, var_2) {
  var_3 = _id_6862(var_0);
  var_4 = _id_10E27(var_3, var_1);
  var_5 = level._id_60A1[var_4];

  if(var_2 == 1) {
    var_6 = spawnfx(var_5, (0, 0, 0));
    triggerfx(var_6);
    return undefined;
  } else {
    var_7 = scripts\engine\utility::spawn_tag_origin();
    playFXOnTag(var_5, var_7, "tag_origin");
    var_8 = spawnStruct();
    var_8._id_7C8C = var_5;
    var_8._id_609C = var_7;
    var_8._id_ED6E = "tag_origin";
    return var_8;
  }
}

_id_8118(var_0, var_1, var_2, var_3) {
  var_4 = _id_6862(var_0);
  var_5 = _id_10E27(var_4, var_1);
  var_6 = level._id_60A1[var_5];

  if(var_3 == 1) {
    var_7 = spawnfx(var_6, var_2);
    triggerfx(var_7);
    return undefined;
  } else {
    var_8 = scripts\engine\utility::spawn_tag_origin();
    var_8.point = var_2;
    playFXOnTag(var_6, var_8, "tag_origin");
    var_9 = spawnStruct();
    var_9._id_7C8C = var_6;
    var_9._id_609C = var_8;
    var_9._id_ED6E = "tag_origin";
    return var_9;
  }
}

_id_E8FA(var_0) {
  if(isDefined(var_0)) {
    stopFXOnTag(var_0._id_7C8C, var_0._id_609C, var_0._id_ED6E);
  } else {}
}

_id_D44F(var_0) {
  setsaveddvar("#x33daa745c39326583", var_0);
}

_id_D451(var_0) {
  setsaveddvar("#x3eeef8b5b6242bc4e", var_0);
}

_id_D450(var_0) {
  setsaveddvar("#x3d6f082c7b7955947", var_0);
}

_id_E111(var_0) {
  var_1 = level._id_60A1["wind_debug"];
  var_2 = scripts\engine\utility::spawn_tag_origin();
  playFXOnTag(var_1, var_2, "tag_origin");
}

_id_6862(var_0) {
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

_id_6863(var_0) {
  var_1 = ["north", "northeast", "east", "southeast", "south", "southwest", "west", "northwest"];
  return var_1[var_0];
}

_id_10E27(var_0, var_1) {
  var_2 = [];
  var_2[0] = ["n_w", "n_m", "n_s"];
  var_2[1] = ["ne_w", "ne_m", "ne_s"];
  var_2[2] = ["e_w", "e_m", "e_s"];
  var_2[3] = ["se_w", "se_m", "se_s"];
  var_2[4] = ["s_w", "s_m", "s_s"];
  var_2[5] = ["sw_w", "sw_m", "sw_s"];
  var_2[6] = ["w_w", "w_m", "w_s"];
  var_2[7] = ["nw_w", "nw_m", "nw_s"];
  return var_2[var_0][var_1];
}
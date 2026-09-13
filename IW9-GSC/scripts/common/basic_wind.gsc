/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\basic_wind.gsc
***********************************************/

load_wind(direction, intensity) {
  _id_3C853A3642AA7B74 = ["n", "ne", "e", "se", "s", "sw", "w", "nw"];
  _id_3B9BAEA9B07ECCEF = ["weak", "medium", "strong"];
  _id_477014F752D37302 = "vfx/iw8/wind/basic_directions/vfx_basic_wind_";
  _id_8C44BF99399EDF9A = _id_3C853A3642AA7B74[get_wind_index(direction)] + "_" + _id_3B9BAEA9B07ECCEF[intensity][0];
  _id_D360F438582BC88F = _id_477014F752D37302 + direction + "_" + _id_3B9BAEA9B07ECCEF[intensity] + ".vfx";
  level.g_effect[_id_8C44BF99399EDF9A] = loadfx(_id_D360F438582BC88F);
}

load_debug_particles() {
  level.g_effect["wind_debug"] = loadfx("vfx/iw8/wind/basic_directions/vfx_basic_wind_debug.vfx");
}

load_all_wind() {
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

init_wind(direction, _id_0C0AB0189903C9D4, permanent) {
  _id_3FC0004A989A8351 = get_wind_index(direction);
  _id_3F1906EE22DF833E = wind_index(_id_3FC0004A989A8351, _id_0C0AB0189903C9D4);
  _id_8C44BF99399EDF9A = level.g_effect[_id_3F1906EE22DF833E];

  if(permanent == 1) {
    fxobj = spawnfx(_id_8C44BF99399EDF9A, (0, 0, 0));
    triggerfx(fxobj);
    return undefined;
  } else {
    fxtag = scripts\engine\utility::spawn_tag_origin();
    playFXOnTag(_id_8C44BF99399EDF9A, fxtag, "tag_origin");
    _id_776C17B6FB9755D0 = spawnStruct();
    _id_776C17B6FB9755D0.id = _id_8C44BF99399EDF9A;
    _id_776C17B6FB9755D0.fxtag = fxtag;
    _id_776C17B6FB9755D0.tagorigin = "tag_origin";
    return _id_776C17B6FB9755D0;
  }
}

init_wind_at_point(direction, _id_0C0AB0189903C9D4, location, permanent) {
  _id_3FC0004A989A8351 = get_wind_index(direction);
  _id_3F1906EE22DF833E = wind_index(_id_3FC0004A989A8351, _id_0C0AB0189903C9D4);
  _id_8C44BF99399EDF9A = level.g_effect[_id_3F1906EE22DF833E];

  if(permanent == 1) {
    fxobj = spawnfx(_id_8C44BF99399EDF9A, location);
    triggerfx(fxobj);
    return undefined;
  } else {
    fxtag = scripts\engine\utility::spawn_tag_origin();
    fxtag.point = location;
    playFXOnTag(_id_8C44BF99399EDF9A, fxtag, "tag_origin");
    _id_776C17B6FB9755D0 = spawnStruct();
    _id_776C17B6FB9755D0.id = _id_8C44BF99399EDF9A;
    _id_776C17B6FB9755D0.fxtag = fxtag;
    _id_776C17B6FB9755D0.tagorigin = "tag_origin";
    return _id_776C17B6FB9755D0;
  }
}

_id_7C798F6CB0754110(_id_A8DAEB9E4DE670F5, _id_18B7AC38B222E55F, pause_time, _id_5D90785217BAAEFF, _id_A7ECB3B97542154E) {
  if(!scripts\engine\utility::flag_exist("pause_ambient_wind_change"))
    scripts\engine\utility::flag_init("pause_ambient_wind_change");

  if(istrue(_id_A7ECB3B97542154E))
    scripts\engine\utility::flag_set("pause_ambient_wind_change");

  _id_A8DAEB9E4DE670F5 = scripts\engine\utility::_id_53C4C53197386572(_id_A8DAEB9E4DE670F5, 0.5);
  _id_18B7AC38B222E55F = scripts\engine\utility::_id_53C4C53197386572(_id_18B7AC38B222E55F, 7);
  _id_66C2115B7D407541 = scripts\engine\utility::_id_53C4C53197386572(pause_time, 10);
  _id_5D90785217BAAEFF = scripts\engine\utility::_id_53C4C53197386572(_id_5D90785217BAAEFF, 25);
  thread _id_3BF9ED80166E5B45("cg_defaultWindAmplitudeScale", _id_A8DAEB9E4DE670F5, _id_18B7AC38B222E55F, _id_66C2115B7D407541, _id_5D90785217BAAEFF);
}

_id_3BF9ED80166E5B45(dvar, _id_A8DAEB9E4DE670F5, _id_18B7AC38B222E55F, pause_time, _id_5D90785217BAAEFF) {
  level notify("stop_ambient_wind_change");
  level endon("stop_ambient_wind_change");

  for(;;) {
    scripts\engine\utility::flag_waitopen("pause_ambient_wind_change");
    _id_6302CA9978061647 = _id_18B7AC38B222E55F;
    _id_7E4B36D37A43C592 = 1;

    if(getdvarfloat(dvar) > _id_A8DAEB9E4DE670F5) {
      _id_6302CA9978061647 = _id_A8DAEB9E4DE670F5;
      _id_7E4B36D37A43C592 = 0;
    }

    _id_A334760F5ED07966(dvar, _id_6302CA9978061647, _id_5D90785217BAAEFF);

    if(_id_7E4B36D37A43C592)
      wait(pause_time);
  }
}

_id_A334760F5ED07966(name, value, time) {
  curr = getdvarfloat(name);
  level notify(_func_A1A5654DB94DBB07(name) + "_lerp_savedDvar");
  level endon(_func_A1A5654DB94DBB07(name) + "_lerp_savedDvar");
  range = value - curr;
  interval = 0.05;
  count = int(time / interval);

  if(count > 0) {
    for(_id_3777ECE6A73EADA5 = range / count; count; count--) {
      curr = curr + _id_3777ECE6A73EADA5;
      setsaveddvar(name, curr);
      wait(interval);
    }
  }

  setsaveddvar(name, value);
}

stop_wind(_id_776C17B6FB9755D0) {
  if(isDefined(_id_776C17B6FB9755D0))
    stopFXOnTag(_id_776C17B6FB9755D0.id, _id_776C17B6FB9755D0.fxtag, _id_776C17B6FB9755D0.tagorigin);
  else {}
}

set_wind_amplitude(_id_D1C2F2174BAAE4D6) {
  setsaveddvar("cg_defaultWindAmplitudeScale", _id_D1C2F2174BAAE4D6);
}

set_wind_frequency(frequency) {
  setsaveddvar("cg_defaultWindFrequencyScale", frequency);
}

set_wind_area_scale(_id_4353AF4A5FBBA84A) {
  setsaveddvar("cg_defaultWindAreaScale", _id_4353AF4A5FBBA84A);
}

spawn_debug_particles(location) {
  _id_8C44BF99399EDF9A = level.g_effect["wind_debug"];
  fxent = scripts\engine\utility::spawn_tag_origin(location);
  playFXOnTag(_id_8C44BF99399EDF9A, fxent, "tag_origin");
  return fxent;
}

get_wind_index(_id_3F1906EE22DF833E) {
  switch (_id_3F1906EE22DF833E) {
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
      return -1;
  }
}

get_wind_string(_id_E9461A3FD79A8F91) {
  _id_2B3B2A05D27B9ED0 = ["north", "northeast", "east", "southeast", "south", "southwest", "west", "northwest"];
  return _id_2B3B2A05D27B9ED0[_id_E9461A3FD79A8F91];
}

wind_index(direction, _id_0C0AB0189903C9D4) {
  _id_838D5CAF05198F43 = [];
  _id_838D5CAF05198F43[0] = ["n_w", "n_m", "n_s"];
  _id_838D5CAF05198F43[1] = ["ne_w", "ne_m", "ne_s"];
  _id_838D5CAF05198F43[2] = ["e_w", "e_m", "e_s"];
  _id_838D5CAF05198F43[3] = ["se_w", "se_m", "se_s"];
  _id_838D5CAF05198F43[4] = ["s_w", "s_m", "s_s"];
  _id_838D5CAF05198F43[5] = ["sw_w", "sw_m", "sw_s"];
  _id_838D5CAF05198F43[6] = ["w_w", "w_m", "w_s"];
  _id_838D5CAF05198F43[7] = ["nw_w", "nw_m", "nw_s"];
  return _id_838D5CAF05198F43[direction][_id_0C0AB0189903C9D4];
}
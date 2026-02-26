/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\item_world_debug.gsc
***********************************************/

#using script_340a2e805e35f7a2;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_world;
#using scripts\core_common\item_world_util;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace item_world_debug;

function private autoexec __init__system__() {
  system::register(#"item_world_debug", &preinit, &postinit, undefined, #"item_world");
}

function private preinit() {
  if(!item_world_util::use_item_spawns()) {
    return;
  }

  gametype = util::get_game_type();

  if(gametype == # "zsurvival") {
    return;
  }

  level thread function_13c803de();

  level thread _setup_devgui();

  level thread function_cdd9b388();

  level thread function_91ef342();
}

function private postinit() {
  gametype = util::get_game_type();

  if(gametype == # "zsurvival") {
    return;
  }

  level thread function_9cc59537();
}

function private function_13d7bba(xoffset, yoffset) {
  elem = newdebughudelem();
  elem.alignx = "<dev string:x38>";
  elem.horzalign = "<dev string:x38>";
  elem.x = xoffset + 0;
  elem.y = yoffset;
  elem.fontscale = 1;
  elem.color = (1, 1, 1);
  elem.fontstyle3d = "<dev string:x40>";
  return elem;
}

function private function_11421106(typestring, type) {
  tab = "<dev string:x50>";
  return typestring + "<dev string:x64>" + (isDefined(level.var_efeab371[type]) ? level.var_efeab371[type] : 0) + "<dev string:x71>" + int((isDefined(level.var_efeab371[type]) ? level.var_efeab371[type] : 0) / int(max(level.var_66e56764, 1)) * 100) + "<dev string:x77>" + tab + "<dev string:x81>" + (isDefined(level.var_d80c35aa[type]) ? level.var_d80c35aa[type] : 0) + "<dev string:x71>" + int((isDefined(level.var_d80c35aa[type]) ? level.var_d80c35aa[type] : 0) / int(max(level.var_136445c0, 1)) * 100) + "<dev string:x77>" + tab + "<dev string:x93>" + (isDefined(level.var_8d9ad8e8[type]) ? level.var_8d9ad8e8[type] : 0) + "<dev string:x71>" + int((isDefined(level.var_8d9ad8e8[type]) ? level.var_8d9ad8e8[type] : 0) / int(max(level.var_5720c09a, 1)) * 100) + "<dev string:x77>" + tab + "<dev string:xa6>" + (isDefined(level.var_ecf16fd3[type]) ? level.var_ecf16fd3[type] : 0) + "<dev string:x71>" + int((isDefined(level.var_ecf16fd3[type]) ? level.var_ecf16fd3[type] : 0) / int(max(level.var_2850ef5, 1)) * 100) + "<dev string:x77>";
}

function private function_bebe535() {
  n_total = 0;
  var_9243cc66 = 0;

  foreach(i, list in level.var_2e96a450) {
    str_set = function_9e72a96(i);
    println(str_set + "<dev string:xba>" + list);
    n_total += list;
    a_tokens = strtok(str_set, "<dev string:xcb>");

    foreach(token in a_tokens) {
      if(token === "<dev string:xd0>" || token === "<dev string:xd9>") {
        var_9243cc66 += list;
        break;
      }
    }
  }

  if(isDefined(level.var_2e96a450[#"paint_can_items"])) {
    var_9243cc66 -= level.var_2e96a450[#"paint_can_items"];
  }

  println("<dev string:xe4>" + n_total);
  println("<dev string:xf6>" + var_9243cc66);
}

function private function_2248268e() {
  vehicles = getvehiclearray();

  foreach(vehicle in vehicles) {
    if(isDefined(vehicle.scriptvehicletype)) {
      println(vehicle.scriptvehicletype);
    }
  }
}

function private function_99216e10(mapname) {
  if(mapname === "<dev string:x117>") {
    world_items = ["<dev string:x124>", "<dev string:x135>", "<dev string:x147>", "<dev string:x155>", "<dev string:x166>", "<dev string:x176>", "<dev string:x18a>", "<dev string:x198>", "<dev string:x1ac>", "<dev string:x1bd>", "<dev string:x1ce>", "<dev string:x1df>", "<dev string:x1f0>"];
    return world_items;
  }
}

function private function_10b50848() {
  self notify("<dev string:x207>");
  self endon("<dev string:x207>");
  file = openfile("<dev string:x21b>", "<dev string:x237>");

  if(file == -1) {
    iprintlnbold("<dev string:x240>");
    return;
  }

  println("<dev string:x298>");
  mapname = util::get_map_name();
  world_items = function_99216e10(mapname);
  count = 0;
  item_count = 0;

  while(count < world_items.size) {
    itemlist = function_91b29d2a(world_items[count]);

    foreach(item in itemlist) {
      the_item = item_world::function_2e3efdda(item.origin, undefined, 1, 1, -1, 1);

      if(the_item.size > 0) {
        type = "<dev string:x2cd>";

        if(isDefined(the_item[0].itementry) && isDefined(the_item[0].itementry.itemtype)) {
          switch (the_item[0].itementry.itemtype) {
            case # "survival_essence":
              type = "<dev string:x2d5>";
              break;
            case # "survival_scrap":
              type = "<dev string:x2e0>";
              break;
            case # "survival_armor_shard":
              type = "<dev string:x2e9>";
              break;
            case # "survival_scorestreak":
              type = "<dev string:x2f8>";
              break;
            case # "survival_perk":
              type = "<dev string:x307>";
              break;
            case # "survival_ammo":
              type = "<dev string:x30f>";
              break;
            case # "armor":
              type = "<dev string:x317>";
              break;
            case # "equipment":
              type = "<dev string:x320>";
              break;
            case # "field_upgrade":
              type = "<dev string:x32d>";
              break;
            case # "tactical":
              type = "<dev string:x33e>";
              break;
            case # "attachment":
              type = "<dev string:x34a>";
              break;
            case # "resource":
              type = "<dev string:x358>";
              break;
            default:
              type = "<dev string:x2cd>";
              break;
          }
        }

        if(isDefined(the_item[0].itementry)) {
          debug_string = the_item[0].itementry.name + "<dev string:x364>" + function_9e72a96(the_item[0].targetname) + "<dev string:x364>" + the_item[0].origin + "<dev string:x364>" + type + "<dev string:x364>" + the_item[0].itementry.rarity;
          fprintln(file, debug_string);
          item_count++;
        }
      }
    }

    count++;
  }

  println("<dev string:x369>" + item_count + "<dev string:x383>");
  println("<dev string:x393>");
  closefile(file);
}

function private function_b6ea080() {
  self notify("<dev string:x3c4>");
  self endon("<dev string:x3c4>");
  file = openfile("<dev string:x3d8>", "<dev string:x237>");

  if(file == -1) {
    iprintlnbold("<dev string:x3ee>");
    return;
  }

  println("<dev string:x298>");
  mapname = util::get_map_name();
  world_items = function_99216e10(mapname);
  count = 0;
  item_count = 0;

  while(count < world_items.size) {
    itemlist = function_91b29d2a(world_items[count]);

    foreach(item in itemlist) {
      the_item = item_world::function_2e3efdda(item.origin, undefined, 1, 1, -1, 1);

      if(the_item.size > 0) {
        type = "<dev string:x2cd>";

        if(isDefined(the_item[0].itementry) && isDefined(the_item[0].itementry.itemtype)) {
          switch (the_item[0].itementry.itemtype) {
            case # "ammo":
              type = "<dev string:x30f>";
              break;
            case # "weapon":
              type = "<dev string:x440>";
              break;
            case # "health":
              type = "<dev string:x44a>";
              break;
            case # "armor":
              type = "<dev string:x317>";
              break;
            case # "equipment":
              type = "<dev string:x320>";
              break;
            case # "field_upgrade":
              type = "<dev string:x32d>";
              break;
            case # "tactical":
              type = "<dev string:x33e>";
              break;
            case # "backpack":
              type = "<dev string:x454>";
              break;
            case # "generic":
              type = "<dev string:x460>";
              break;
            case # "cash":
              type = "<dev string:x46b>";
              break;
            case # "killstreak":
              type = "<dev string:x473>";
              break;
            case # "attachment":
              type = "<dev string:x34a>";
              break;
            case # "resource":
              type = "<dev string:x358>";
              break;
            default:
              type = "<dev string:x2cd>";
              break;
          }
        }

        if(isDefined(the_item[0].itementry)) {
          debug_string = the_item[0].itementry.name + "<dev string:x364>" + function_9e72a96(the_item[0].targetname) + "<dev string:x364>" + the_item[0].origin + "<dev string:x364>" + type;
          fprintln(file, debug_string);
          item_count++;
        }
      }
    }

    count++;
  }

  println("<dev string:x369>" + item_count + "<dev string:x383>");
  println("<dev string:x393>");
  closefile(file);
}

function private function_938d798a() {
  str_filename = util::get_map_name() + "<dev string:x481>";
  file = openfile(str_filename, "<dev string:x492>");

  if(file == -1) {
    iprintlnbold("<dev string:x49a>" + str_filename);
    return;
  }

  freadln(file);
  freadln(file);
  freadln(file);
  freadln(file);
  var_7099d03 = [];

  while(freadln(file) > 0) {
    var_6f08946b = fgetarg(file, 0);
    var_dd52f0fe = fgetarg(file, 1);
    var_5e4d7301 = fgetarg(file, 2);
    var_6f08946b = strreplace(var_6f08946b, "<dev string:x4b1>", "<dev string:x4ca>");
    var_5e4d7301 = strreplace(var_5e4d7301, "<dev string:x4ce>", "<dev string:x4ca>");
    var_5e4d7301 = strreplace(var_5e4d7301, "<dev string:x4e0>", "<dev string:x4ca>");
    var_5e4d7301 = strreplace(var_5e4d7301, "<dev string:x506>", "<dev string:x4ca>");
    a_vec = [];
    a_vec[0] = float(var_6f08946b);
    a_vec[1] = float(var_dd52f0fe);
    a_vec[2] = float(var_5e4d7301);

    if(!isDefined(var_7099d03)) {
      var_7099d03 = [];
    } else if(!isarray(var_7099d03)) {
      var_7099d03 = array(var_7099d03);
    }

    var_7099d03[var_7099d03.size] = a_vec;
  }

  closefile(file);
  player = getplayers()[0];

  while(level.var_938d798a) {
    foreach(vec in var_7099d03) {
      var_31e25ea2 = (vec[0], vec[1], vec[2]);

      if(distance2d(player.origin, var_31e25ea2) < 8000) {
        radius = 128;
        var_84dd2a8b = 4096;

        if(distancesquared(player.origin, var_31e25ea2) < sqr(var_84dd2a8b)) {
          radius = max(distance(player.origin, var_31e25ea2) / var_84dd2a8b * radius, 1);
        }

        sphere(var_31e25ea2, radius, (1, 0, 0), 1, 0, 10, 20);
        var_f4b807cb = item_world::function_2e3efdda(var_31e25ea2, undefined, 128, 1);
        item = var_f4b807cb[0];

        if(isDefined(item.targetname)) {
          print3d(item.origin + (0, 0, 32), function_9e72a96(item.targetname), (1, 0, 0), 1, 0.3, 20);
        }
      }
    }

    waitframe(1);
  }

  iprintlnbold("<dev string:x51e>");
}

function private function_f9efe895() {
  var_7f0b4b6b = [];
  buoy_stash = [];
  var_7f0b4b6b = arraycombine(function_91b29d2a("<dev string:x53e>"), function_91b29d2a("<dev string:x54d>"), 1, 0);
  var_7f0b4b6b = arraycombine(var_7f0b4b6b, function_91b29d2a("<dev string:x560>"), 1, 0);
  var_7f0b4b6b = arraycombine(var_7f0b4b6b, function_91b29d2a("<dev string:x576>"), 1, 0);
  buoy_stash = function_91b29d2a("<dev string:x58a>");
  var_7f0b4b6b = arraycombine(var_7f0b4b6b, buoy_stash, 1, 0);
  player = util::gethostplayer();
  n_index = 0;
  prev_index = 0;
  wait 1;
  iprintlnbold("<dev string:x59f>");

  while(level.var_f9efe895) {
    if(player adsButtonPressed() && player function_78931318("<dev string:x5f4>")) {
      if(n_index < var_7f0b4b6b.size - 1) {
        n_index++;
      } else {
        n_index = 0;
      }
    } else if(player adsButtonPressed() && player function_78931318("<dev string:x5fa>")) {
      if(n_index == 0) {
        n_index = var_7f0b4b6b.size - 1;
      } else {
        n_index--;
      }
    }

    if(n_index != prev_index) {
      v_player_pos = var_7f0b4b6b[n_index].origin + anglesToForward(var_7f0b4b6b[n_index].angles) * 96;
      var_543a44a5 = vectortoangles(var_7f0b4b6b[n_index].origin - v_player_pos + (0, 0, 36));
      player setorigin(v_player_pos);
      player setplayerangles(var_543a44a5);
      prev_index = n_index;
      iprintlnbold("<dev string:x602>" + n_index);
      wait 0.1;
    }

    waitframe(1);
  }

  iprintlnbold("<dev string:x612>");
}

function private function_f0d72128() {
  var_df1e5fef = [];
  var_df1e5fef = function_91b29d2a("<dev string:x630>");
  player = util::gethostplayer();

  if(!isDefined(level.var_99026891)) {
    level.var_99026891 = var_df1e5fef.size - 1;
  }

  prev_index = 0;
  v_offset = (0, 0, 50);
  wait 1;
  iprintlnbold("<dev string:x645>");
  adddebugcommand("<dev string:x69d>");

  while(level.var_f0d72128) {
    if(player jumpbuttonPressed() && player function_78931318("<dev string:x6a7>")) {
      if(level.var_99026891 < var_df1e5fef.size - 1) {
        level.var_99026891++;
      } else {
        level.var_99026891 = 0;
      }
    } else if(player jumpbuttonPressed() && player function_78931318("<dev string:x38>")) {
      if(level.var_99026891 == 0) {
        level.var_99026891 = var_df1e5fef.size - 1;
      } else {
        level.var_99026891--;
      }
    }

    if(level.var_99026891 != prev_index) {
      debugstar(var_df1e5fef[level.var_99026891].origin, 190, (1, 1, 1));
      v_player_pos = var_df1e5fef[level.var_99026891].origin - anglestoright(var_df1e5fef[level.var_99026891].angles) * 128;
      var_543a44a5 = vectortoangles(var_df1e5fef[level.var_99026891].origin - v_player_pos);
      v_player_pos -= v_offset;
      player setorigin(v_player_pos);
      player setplayerangles(var_543a44a5);
      prev_index = level.var_99026891;
      iprintlnbold("<dev string:x6b0>" + level.var_99026891);
      wait 0.1;
    }

    waitframe(1);
  }

  iprintlnbold("<dev string:x6c2>");
}

function function_78931318(str_button) {
  switch (str_button) {
    case # "down":
      str_btn = "<dev string:x6e3>";
      var_7a00db94 = "<dev string:x6f0>";
      break;
    case # "left":
      str_btn = "<dev string:x6fd>";
      var_7a00db94 = "<dev string:x70a>";
      break;
    case # "right":
      str_btn = "<dev string:x717>";
      var_7a00db94 = "<dev string:x725>";
      break;
    case # "up":
      str_btn = "<dev string:x733>";
      var_7a00db94 = "<dev string:x73e>";
      break;
  }

  if(isDefined(str_btn)) {
    if(self buttonPressed(str_btn) || self buttonPressed(var_7a00db94)) {
      while(self buttonPressed(str_btn) || self buttonPressed(var_7a00db94)) {
        waitframe(1);
      }

      return 1;
    }
  }

  return 0;
}

function private function_66b45a31(origin) {
  atv_spawn = function_91b29d2a(#"atv_spawn");
  cargo_truck_spawn = function_91b29d2a(#"cargo_truck_spawn");
  cargo_truck_clearing_spawn = function_91b29d2a(#"cargo_truck_clearing_spawn");
  heli_spawn = function_91b29d2a(#"heli_spawn");
  heli_clearing_spawn = function_91b29d2a(#"heli_clearing_spawn");
  zodiac_spawn = function_91b29d2a(#"zodiac_spawn");
  var_e8750c36 = function_91b29d2a(#"zodiac_spawn_docks");
  var_1901b1fa = function_91b29d2a(#"zodiac_spawn_hydro");
  var_453c640c = function_91b29d2a(#"zodiac_spawn_nuketown");
  var_b351e4a0 = function_91b29d2a(#"zodiac_spawn_skyscraper");
  var_e4dc1e88 = function_91b29d2a(#"zodiac_spawn_hijacked");
  muscle_car_spawn = function_91b29d2a(#"muscle_car_spawn");
  arav_spawn = function_91b29d2a(#"arav_spawn");
  suv_spawn = function_91b29d2a(#"suv_spawn");
  pbr_spawn = function_91b29d2a(#"pbr_spawn");

  foreach(vehicle in atv_spawn) {
    radius = 128;
    var_84dd2a8b = 4096;

    if(distancesquared(origin, vehicle.origin) < sqr(var_84dd2a8b)) {
      radius = max(distance(origin, vehicle.origin) / var_84dd2a8b * radius, 1);
    }

    sphere(vehicle.origin, radius, (1, 0, 0), 1, 0, 10, 20);
  }

  foreach(vehicle in cargo_truck_spawn) {
    radius = 128;
    var_84dd2a8b = 4096;

    if(distancesquared(origin, vehicle.origin) < sqr(var_84dd2a8b)) {
      radius = max(distance(origin, vehicle.origin) / var_84dd2a8b * radius, 1);
    }

    sphere(vehicle.origin, radius, (1, 1, 0), 1, 0, 10, 20);
  }

  foreach(vehicle in cargo_truck_clearing_spawn) {
    radius = 128;
    var_84dd2a8b = 4096;

    if(distancesquared(origin, vehicle.origin) < sqr(var_84dd2a8b)) {
      radius = max(distance(origin, vehicle.origin) / var_84dd2a8b * radius, 1);
    }

    sphere(vehicle.origin, radius, (1, 1, 0), 1, 0, 10, 20);
  }

  foreach(vehicle in heli_spawn) {
    radius = 128;
    var_84dd2a8b = 4096;

    if(distancesquared(origin, vehicle.origin) < sqr(var_84dd2a8b)) {
      radius = max(distance(origin, vehicle.origin) / var_84dd2a8b * radius, 1);
    }

    sphere(vehicle.origin, radius, (1, 0, 1), 1, 0, 10, 20);
  }

  foreach(vehicle in heli_clearing_spawn) {
    radius = 128;
    var_84dd2a8b = 4096;

    if(distancesquared(origin, vehicle.origin) < sqr(var_84dd2a8b)) {
      radius = max(distance(origin, vehicle.origin) / var_84dd2a8b * radius, 1);
    }

    sphere(vehicle.origin, radius, (1, 0, 1), 1, 0, 10, 20);
  }

  foreach(vehicle in zodiac_spawn) {
    radius = 128;
    var_84dd2a8b = 4096;

    if(distancesquared(origin, vehicle.origin) < sqr(var_84dd2a8b)) {
      radius = max(distance(origin, vehicle.origin) / var_84dd2a8b * radius, 1);
    }

    sphere(vehicle.origin, radius, (1, 0.5, 0), 1, 0, 10, 20);
  }

  foreach(vehicle in var_e8750c36) {
    radius = 128;
    var_84dd2a8b = 4096;

    if(distancesquared(origin, vehicle.origin) < sqr(var_84dd2a8b)) {
      radius = max(distance(origin, vehicle.origin) / var_84dd2a8b * radius, 1);
    }

    sphere(vehicle.origin, radius, (1, 0.5, 0), 1, 0, 10, 20);
  }

  foreach(vehicle in var_1901b1fa) {
    radius = 128;
    var_84dd2a8b = 4096;

    if(distancesquared(origin, vehicle.origin) < sqr(var_84dd2a8b)) {
      radius = max(distance(origin, vehicle.origin) / var_84dd2a8b * radius, 1);
    }

    sphere(vehicle.origin, radius, (1, 0.5, 0), 1, 0, 10, 20);
  }

  foreach(vehicle in var_453c640c) {
    radius = 128;
    var_84dd2a8b = 4096;

    if(distancesquared(origin, vehicle.origin) < sqr(var_84dd2a8b)) {
      radius = max(distance(origin, vehicle.origin) / var_84dd2a8b * radius, 1);
    }

    sphere(vehicle.origin, radius, (1, 0.5, 0), 1, 0, 10, 20);
  }

  foreach(vehicle in var_b351e4a0) {
    radius = 128;
    var_84dd2a8b = 4096;

    if(distancesquared(origin, vehicle.origin) < sqr(var_84dd2a8b)) {
      radius = max(distance(origin, vehicle.origin) / var_84dd2a8b * radius, 1);
    }

    sphere(vehicle.origin, radius, (1, 0.5, 0), 1, 0, 10, 20);
  }

  foreach(vehicle in var_e4dc1e88) {
    radius = 128;
    var_84dd2a8b = 4096;

    if(distancesquared(origin, vehicle.origin) < sqr(var_84dd2a8b)) {
      radius = max(distance(origin, vehicle.origin) / var_84dd2a8b * radius, 1);
    }

    sphere(vehicle.origin, radius, (1, 0.5, 0), 1, 0, 10, 20);
  }

  foreach(vehicle in muscle_car_spawn) {
    radius = 128;
    var_84dd2a8b = 4096;

    if(distancesquared(origin, vehicle.origin) < sqr(var_84dd2a8b)) {
      radius = max(distance(origin, vehicle.origin) / var_84dd2a8b * radius, 1);
    }

    sphere(vehicle.origin, radius, (0, 1, 1), 1, 0, 10, 20);
  }

  foreach(vehicle in suv_spawn) {
    radius = 128;
    var_84dd2a8b = 4096;

    if(distancesquared(origin, vehicle.origin) < sqr(var_84dd2a8b)) {
      radius = max(distance(origin, vehicle.origin) / var_84dd2a8b * radius, 1);
    }

    sphere(vehicle.origin, radius, (0, 1, 1), 1, 0, 10, 20);
  }

  foreach(vehicle in arav_spawn) {
    radius = 128;
    var_84dd2a8b = 4096;

    if(distancesquared(origin, vehicle.origin) < sqr(var_84dd2a8b)) {
      radius = max(distance(origin, vehicle.origin) / var_84dd2a8b * radius, 1);
    }

    sphere(vehicle.origin, radius, (0.501961, 0.501961, 0), 1, 0, 10, 20);
  }

  foreach(vehicle in pbr_spawn) {
    radius = 128;
    var_84dd2a8b = 4096;

    if(distancesquared(origin, vehicle.origin) < sqr(var_84dd2a8b)) {
      radius = max(distance(origin, vehicle.origin) / var_84dd2a8b * radius, 1);
    }

    sphere(vehicle.origin, radius, (0, 1, 0), 1, 0, 10, 20);
  }
}

function private function_f4c71526(origin) {
  vehicles = getvehiclearray();

  foreach(vehicle in vehicles) {
    color = (0.75, 0.75, 0.75);
    radius = 128;
    var_84dd2a8b = 4096;

    if(distancesquared(origin, vehicle.origin) < sqr(var_84dd2a8b)) {
      radius = max(distance(origin, vehicle.origin) / var_84dd2a8b * radius, 1);
    }

    if(isDefined(vehicle.scriptvehicletype)) {
      color = (1, 1, 1);

      switch (vehicle.scriptvehicletype) {
        case # "player_atv":
          color = (0, 1, 1);
          break;
        case # "cargo_truck_wz":
          color = (1, 1, 0);
          break;
        case # "tactical_raft_wz":
          color = (1, 0.5, 0);
          break;
        case # "helicopter_light":
          color = (1, 0, 1);
          break;
      }

      sphere(vehicle.origin, radius, color, 1, 0, 10, 20);
    }
  }
}

function private function_cdd9b388() {
  while(true) {
    if(getdvarint(#"hash_594f4fa67a3b1977", 0)) {
      wait 1;
    } else {
      waitframe(1);
    }

    if(!isDefined(level flag::get(#"item_world_initialized"))) {
      continue;
    }

    if(getdvarint(#"hash_4341150bd02e99a1", 0) > 0) {
      xoffset = 20;
      yoffset = 160;
      var_27afd540 = 15;
      var_9e681fbf = 10;

      if(!isDefined(level.var_f0d0335b)) {
        level.var_f0d0335b = function_13d7bba(xoffset, yoffset);
        yoffset += var_27afd540 + var_9e681fbf;
      }

      if(!isDefined(level.var_7f7d26cc)) {
        level.var_7f7d26cc = function_13d7bba(xoffset, yoffset);
        yoffset += var_27afd540;
      }

      if(!isDefined(level.var_6deb23ed)) {
        level.var_6deb23ed = function_13d7bba(xoffset, yoffset);
        yoffset += var_27afd540 + var_9e681fbf;
      }

      if(!isDefined(level.var_5c6c77b3)) {
        level.var_5c6c77b3 = function_13d7bba(xoffset, yoffset);
        yoffset += var_27afd540;
      }

      if(!isDefined(level.var_5471e557)) {
        level.var_5471e557 = function_13d7bba(xoffset, yoffset);
        yoffset += var_27afd540;
      }

      if(!isDefined(level.var_544a823a)) {
        level.var_544a823a = function_13d7bba(xoffset, yoffset);
        yoffset += var_27afd540;
      }

      if(!isDefined(level.var_eaa15f28)) {
        level.var_eaa15f28 = function_13d7bba(xoffset, yoffset);
        yoffset += var_27afd540;
      }

      if(!isDefined(level.var_6fc93583)) {
        level.var_6fc93583 = function_13d7bba(xoffset, yoffset);
        yoffset += var_27afd540;
      }

      if(!isDefined(level.var_f2a04fda)) {
        level.var_f2a04fda = function_13d7bba(xoffset, yoffset);
        yoffset += var_27afd540;
      }

      if(!isDefined(level.var_721a3621)) {
        level.var_721a3621 = function_13d7bba(xoffset, yoffset);
        yoffset += var_27afd540;
      }

      if(!isDefined(level.var_67220c03)) {
        level.var_67220c03 = function_13d7bba(xoffset, yoffset);
        yoffset += var_27afd540 + var_9e681fbf;
      }

      if(!isDefined(level.var_58faba13)) {
        level.var_58faba13 = function_13d7bba(xoffset, yoffset);
        yoffset += var_27afd540;
      }

      if(!isDefined(level.var_c36fe7fe)) {
        level.var_c36fe7fe = function_13d7bba(xoffset, yoffset);
        yoffset += var_27afd540;
      }

      if(!isDefined(level.var_d302f942)) {
        level.var_d302f942 = function_13d7bba(xoffset, yoffset);
        yoffset += var_27afd540;
      }

      if(!isDefined(level.var_1e11d9ad)) {
        level.var_1e11d9ad = function_13d7bba(xoffset, yoffset);
        yoffset += var_27afd540;
      }

      if(!isDefined(level.var_598c0b05)) {
        level.var_598c0b05 = function_13d7bba(xoffset, yoffset);
        yoffset += var_27afd540;
      }

      if(!isDefined(level.var_68135970)) {
        level.var_68135970 = function_13d7bba(xoffset, yoffset);
        yoffset += var_27afd540;
      }

      tab = "<dev string:x50>";
      level.var_f0d0335b settext("<dev string:x749>" + (isDefined(level.var_d80c35aa[#"blank"]) ? level.var_d80c35aa[#"blank"] : 0) + "<dev string:x71>" + int((isDefined(level.var_d80c35aa[#"blank"]) ? level.var_d80c35aa[#"blank"] : 0) / int(max(level.var_136445c0, 1) + (isDefined(level.var_d80c35aa[#"blank"]) ? level.var_d80c35aa[#"blank"] : 0)) * 100) + "<dev string:x77>");
      level.var_7f7d26cc settext("<dev string:x75b>" + level.var_136445c0 + (isDefined(level.var_d80c35aa[#"blank"]) ? level.var_d80c35aa[#"blank"] : 0));
      level.var_6deb23ed settext("<dev string:x770>" + level.var_66e56764 + tab + tab + "<dev string:x81>" + level.var_136445c0 + tab + tab + "<dev string:x93>" + level.var_5720c09a + tab + tab + "<dev string:x782>" + level.var_2850ef5);
      level.var_5c6c77b3 settext(function_11421106("<dev string:x79b>", "<dev string:x440>"));
      level.var_5471e557 settext(function_11421106("<dev string:x7a5>", "<dev string:x317>"));
      level.var_544a823a settext(function_11421106("<dev string:x7ae>", "<dev string:x454>"));
      level.var_eaa15f28 settext(function_11421106("<dev string:x7ba>", "<dev string:x320>"));
      level.var_6fc93583 settext(function_11421106("<dev string:x7c7>", "<dev string:x44a>"));
      level.var_f2a04fda settext(function_11421106("<dev string:x7d1>", "<dev string:x473>"));
      level.var_721a3621 settext(function_11421106("<dev string:x7df>", "<dev string:x34a>"));
      level.var_67220c03 settext(function_11421106("<dev string:x7ed>", "<dev string:x30f>"));
      level.var_c36fe7fe settext(function_11421106("<dev string:x7f5>", "<dev string:x806>"));
      level.var_d302f942 settext(function_11421106("<dev string:x81a>", "<dev string:x82a>"));
      level.var_1e11d9ad settext(function_11421106("<dev string:x83b>", "<dev string:x84c>"));
      level.var_598c0b05 settext(function_11421106("<dev string:x85d>", "<dev string:x874>"));
      level.var_68135970 settext(function_11421106("<dev string:x88c>", "<dev string:x8a4>"));
      level.var_58faba13 settext("<dev string:x8bc>" + (isDefined(level.var_f2db6a7f) ? level.var_f2db6a7f : 0));
    } else {
      if(isDefined(level.var_f0d0335b)) {
        level.var_f0d0335b destroy();
      }

      if(isDefined(level.var_7f7d26cc)) {
        level.var_7f7d26cc destroy();
      }

      if(isDefined(level.var_6deb23ed)) {
        level.var_6deb23ed destroy();
      }

      if(isDefined(level.var_5c6c77b3)) {
        level.var_5c6c77b3 destroy();
      }

      if(isDefined(level.var_5471e557)) {
        level.var_5471e557 destroy();
      }

      if(isDefined(level.var_544a823a)) {
        level.var_544a823a destroy();
      }

      if(isDefined(level.var_eaa15f28)) {
        level.var_eaa15f28 destroy();
      }

      if(isDefined(level.var_6fc93583)) {
        level.var_6fc93583 destroy();
      }

      if(isDefined(level.var_f2a04fda)) {
        level.var_f2a04fda destroy();
      }

      if(isDefined(level.var_721a3621)) {
        level.var_721a3621 destroy();
      }

      if(isDefined(level.var_67220c03)) {
        level.var_67220c03 destroy();
      }

      if(isDefined(level.var_58faba13)) {
        level.var_58faba13 destroy();
      }

      if(isDefined(level.var_c36fe7fe)) {
        level.var_c36fe7fe destroy();
      }

      if(isDefined(level.var_d302f942)) {
        level.var_d302f942 destroy();
      }

      if(isDefined(level.var_1e11d9ad)) {
        level.var_1e11d9ad destroy();
      }

      if(isDefined(level.var_598c0b05)) {
        level.var_598c0b05 destroy();
      }

      if(isDefined(level.var_68135970)) {
        level.var_68135970 destroy();
      }
    }

    if(getdvarint(#"hash_66ec171c69a26bfe", 0) > 0) {
      level clientfield::set("<dev string:x8d0>", 0);
    }

    if(getdvarint(#"hash_cc335a24301e7a1", 0) > 0) {
      if(!level.var_1d8e6dd8) {
        level.var_1d8e6dd8 = 1;
        level thread function_b6ea080();
      }
    }

    if(getdvarint(#"hash_7504a27146161805", 0) > 0) {
      if(!level.var_1d8e6dd8) {
        level.var_1d8e6dd8 = 1;
        level thread function_10b50848();
      }
    }

    if(getdvarint(#"hash_7701b1eb7e173692", 0)) {
      if(!level.var_938d798a) {
        wait 0.5;
        level.var_938d798a = 1;
        level thread function_938d798a();
      }
    }

    if(getdvarint(#"hash_7701b1eb7e173692", 0) == 0) {
      level.var_938d798a = 0;
    }

    if(getdvarint(#"hash_cb3296a761d4f6c", 0)) {
      if(!level.var_f9efe895) {
        wait 0.5;
        level.var_f9efe895 = 1;
        level thread function_f9efe895();
      }
    }

    if(getdvarint(#"hash_cb3296a761d4f6c", 0) == 0) {
      level.var_f9efe895 = 0;
    }

    if(getdvarint(#"hash_4f4c47d52d6ad262", 0)) {
      if(!level.var_f0d72128) {
        wait 0.5;
        level.var_f0d72128 = 1;
        level thread function_f0d72128();
      }
    }

    if(getdvarint(#"hash_4f4c47d52d6ad262", 0) == 0) {
      level.var_f0d72128 = 0;
    }

    if(getdvarint(#"hash_170b29b9b506feed", 0)) {
      setDvar(#"hash_170b29b9b506feed", 0);
      level thread function_bebe535();
    }

    if(getdvarint(#"hash_38ea7228f76d733f", 0)) {
      setDvar(#"hash_38ea7228f76d733f", 0);
      level thread function_2248268e();
    }

    if(getdvarint(#"hash_cc335a24301e7a1", 0) == 0) {
      level.var_1d8e6dd8 = 0;
    } else {
      setDvar(#"hash_cc335a24301e7a1", 0);
    }

    if(getdvarint(#"hash_7504a27146161805", 0) == 0) {
      level.var_1d8e6dd8 = 0;
    } else {
      setDvar(#"hash_7504a27146161805", 0);
    }

    if(getdvarint(#"hash_3fdd3b60f349d462", 0) > 0) {
      players = getplayers();

      if(players.size <= 0) {
        continue;
      }

      origin = players[0].origin;
      var_f4b807cb = item_world::function_2e3efdda(origin, undefined, 128, 2000);

      foreach(item in var_f4b807cb) {
        hidden = item.hidetime < 0 ? "<dev string:x4ca>" : "<dev string:x8e6>";
        print3d(item.origin + (0, 0, 10), "<dev string:x8ed>" + item.networkid + hidden + "<dev string:x8f3>" + item.itementry.name, (1, 0.5, 0), 1, 0.4);
      }
    }

    if(getdvarint(#"hash_52c63fdd1c1d96ac", 0)) {
      itemtype = getdvarint(#"hash_52c63fdd1c1d96ac", 1);
      players = getplayers();

      if(players.size <= 0) {
        continue;
      }

      origin = players[0].origin;

      if(itemtype == 18) {
        function_66b45a31(origin);
      } else if(itemtype == 19) {
        function_f4c71526(origin);
      } else {
        var_f4b807cb = item_world::function_2e3efdda(origin, undefined, 4000, 30000, -1, 0);

        foreach(item in var_f4b807cb) {
          if(isDefined(item.itementry) && isDefined(item.itementry.rarity)) {
            switch (item.itementry.rarity) {
              case # "common":
                color = (0, 1, 0);
                break;
              case # "rare":
                color = (0, 0, 1);
                break;
              case # "legendary":
                color = (1, 0.5, 0);
                break;
              case # "epic":
                color = (1, 0, 1);
                break;
              default:
                color = (0.75, 0.75, 0.75);
                break;
            }
          } else {
            color = (0.75, 0.75, 0.75);
          }

          radius = 64;
          var_84dd2a8b = 2048;

          if(distancesquared(origin, item.origin) < sqr(var_84dd2a8b)) {
            radius = max(distance(origin, item.origin) / var_84dd2a8b * radius, 1);
          }

          switch (itemtype) {
            case 1:
              color = (1, 0, 1);
              sphere(item.origin, radius, color, 1, 0, 10, 20);

              if(isDefined(item.targetname)) {
                print3d(item.origin + (0, 0, 32), function_9e72a96(item.targetname), color, 1, 0.3, 20);
              }

              break;
            case 2:
              if(isDefined(item.itementry)) {
                sphere(item.origin, radius, color, 1, 0, 10, 20);

                if(isDefined(item.targetname)) {
                  print3d(item.origin + (0, 0, 32), function_9e72a96(item.targetname), color, 1, 0.3, 20);
                }
              }
            case 3:
              if(isDefined(item.itementry) && item.itementry.itemtype === # "survival_ammo") {
                sphere(item.origin, radius, color, 1, 0, 10, 20);

                if(isDefined(item.targetname)) {
                  print3d(item.origin + (0, 0, 32), function_9e72a96(item.targetname), color, 1, 0.3, 20);
                }
              }

              break;
            case 4:
              if(isDefined(item.itementry) && item.itementry.itemtype === # "weapon") {
                sphere(item.origin, radius, color, 1, 0, 10, 20);
              }

              break;
            case 5:
              if(isDefined(item.itementry) && item.itementry.itemtype === # "armor") {
                if(item.itementry.name == "<dev string:x8f8>") {
                  sphere(item.origin, radius, (0, 1, 0), 1, 0, 10, 20);
                } else if(item.itementry.name == "<dev string:x90c>") {
                  sphere(item.origin, radius, (0, 0, 1), 1, 0, 10, 20);
                } else if(item.itementry.name == "<dev string:x921>") {
                  sphere(item.origin, radius, (1, 1, 0), 1, 0, 10, 20);
                } else {
                  sphere(item.origin, radius, color, 1, 0, 10, 20);
                }

                if(isDefined(item.itementry) && item.itementry.itemtype === # "weapon") {
                  sphere(item.origin, radius, color, 1, 0, 10, 20);
                }
              }

              break;
            case 6:
              if(isDefined(item.itementry) && item.itementry.itemtype === # "equipment") {
                sphere(item.origin, radius, color, 1, 0, 10, 20);
              }

              break;
            case 7:
              if(isDefined(item.itementry) && item.itementry.itemtype === # "attachment") {
                sphere(item.origin, radius, color, 1, 0, 10, 20);
              }

              break;
            case 8:
              if(isDefined(item.itementry) && item.itementry.itemtype === # "survival_armor_shard") {
                sphere(item.origin, radius, color, 1, 0, 10, 20);
              }

              break;
            case 9:
              if(isDefined(item.itementry) && item.itementry.itemtype === # "survival_essence") {
                if(item.itementry.amount === 1) {
                  color = (0.75, 0.75, 0.75);
                } else {
                  radius *= 2;
                }

                sphere(item.origin, radius, color, 1, 0, 10, 20);
              }

              break;
            case 10:
              if(isDefined(item.itementry) && item.itementry.itemtype === # "survival_scrap") {
                if(item.itementry.amount === 1) {
                  color = (0.75, 0.75, 0.75);
                } else {
                  radius *= 2;
                }

                sphere(item.origin, radius, color, 1, 0, 10, 20);
              }

              break;
            case 11:
              if(isDefined(item.itementry) && item.itementry.itemtype === # "survival_perk") {
                sphere(item.origin, radius, color, 1, 0, 10, 20);
              }

              break;
            case 12:
              if(isDefined(item.itementry) && item.itementry.itemtype === # "survival_scorestreak") {
                sphere(item.origin, radius, color, 1, 0, 10, 20);
              }

              break;
            case 13:
              if(isDefined(item.itementry) && item.itementry.itemtype === # "generic") {
                sphere(item.origin, radius, color, 1, 0, 10, 20);
              }

              break;
            case 14:
              if(isDefined(item.itementry) && item.itementry.itemtype === # "resource") {
                sphere(item.origin, radius, color, 1, 0, 10, 20);
              }

              break;
            case 16:
              if(isDefined(item.itementry) && item.itementry.itemtype === # "field_upgrade") {
                sphere(item.origin, radius, color, 1, 0, 10, 20);
              }

              break;
            case 17:
              if(isDefined(item.itementry) && item.itementry.itemtype === # "tactical") {
                sphere(item.origin, radius, color, 1, 0, 10, 20);
              }

              break;
          }
        }
      }
    }

    if(getdvarint(#"hash_594f4fa67a3b1977", 0)) {
      itemtype = getdvarint(#"hash_594f4fa67a3b1977", 1);
      players = getplayers();

      if(players.size <= 0) {
        continue;
      }

      origin = players[0].origin;

      if(itemtype == 17) {
        function_66b45a31(origin);
      } else if(itemtype == 18) {
        function_f4c71526(origin);
      } else if(itemtype == 19) {
        var_83f919af = arraycombine(function_91b29d2a(#"world_stash"), function_91b29d2a(#"hash_7ce3442d00bdfee4"), 1, 0);
        var_83f919af = arraycombine(var_83f919af, function_91b29d2a(#"hash_1aa42430861b65d5"), 1, 0);
        var_83f919af = arraycombine(var_83f919af, function_91b29d2a(#"hash_553eee9af583811e"), 1, 0);

        foreach(point in var_83f919af) {
          player = level.players[0];

          if(vectordot(player.origin, point.origin) > 0) {
            color = (0, 0, 1);
            radius = 128;
            var_84dd2a8b = 4096;

            if(distancesquared(origin, point.origin) < sqr(var_84dd2a8b)) {
              radius = max(distance(origin, point.origin) / var_84dd2a8b * radius, 1);
            }

            stash_items = item_world::function_2e3efdda(point.origin, undefined, 100, 1);

            if(stash_items.size > 0) {
              switch (stash_items[0].targetname) {
                case # "world_dynent_stash_health":
                  color = (1, 0, 0);
                  break;
                case # "world_dynent_stash_supply":
                  color = (0, 1, 0);
                  break;
                case # "hash_ea6664e89a0bff6":
                  color = (0.501961, 0.501961, 0);
                  break;
              }

              sphere(point.origin, radius, color, 1, 0, 10, 20);
              continue;
            }

            color = (0.75, 0.75, 0.75);
            sphere(point.origin, radius, color, 1, 0, 10, 20);
          }
        }
      } else {
        var_f4b807cb = item_world::function_2e3efdda(origin, undefined, 4000, 30000, -1, 0);

        foreach(item in var_f4b807cb) {
          if(isDefined(item.itementry) && isDefined(item.itementry.rarity)) {
            switch (item.itementry.rarity) {
              case # "common":
                color = (0, 1, 0);
                break;
              case # "rare":
                color = (0, 0, 1);
                break;
              case # "legendary":
                color = (1, 0.5, 0);
                break;
              case # "epic":
                color = (1, 0, 1);
                break;
              default:
                color = (0.75, 0.75, 0.75);
                break;
            }
          } else {
            color = (0.75, 0.75, 0.75);
          }

          radius = 64;
          var_84dd2a8b = 2048;

          if(distancesquared(origin, item.origin) < sqr(var_84dd2a8b)) {
            radius = max(distance(origin, item.origin) / var_84dd2a8b * radius, 1);
          }

          switch (itemtype) {
            case 1:
              color = (1, 0, 1);
              sphere(item.origin, radius, color, 1, 0, 10, 20);

              if(isDefined(item.targetname)) {
                print3d(item.origin + (0, 0, 32), function_9e72a96(item.targetname), color, 1, 0.3, 20);
              }

              break;
            case 2:
              if(isDefined(item.itementry)) {
                sphere(item.origin, radius, color, 1, 0, 10, 20);
              }
            case 3:
              if(isDefined(item.itementry) && item.itementry.itemtype === # "ammo") {
                sphere(item.origin, radius, color, 1, 0, 10, 20);
              }

              break;
            case 4:
              if(isDefined(item.itementry) && item.itementry.itemtype === # "weapon") {
                sphere(item.origin, radius, color, 1, 0, 10, 20);
              }

              break;
            case 5:
              if(isDefined(item.itementry) && item.itementry.itemtype === # "health") {
                if(item.itementry.name == "<dev string:x935>") {
                  sphere(item.origin, radius, (0, 1, 0), 1, 0, 10, 20);
                } else if(item.itementry.name == "<dev string:x94a>") {
                  sphere(item.origin, radius, (0, 0, 1), 1, 0, 10, 20);
                } else if(item.itementry.name == "<dev string:x960>") {
                  sphere(item.origin, radius, (1, 0.5, 0), 1, 0, 10, 20);
                } else {
                  sphere(item.origin, radius, color, 1, 0, 10, 20);
                }
              }

              break;
            case 6:
              if(isDefined(item.itementry) && item.itementry.itemtype === # "armor") {
                if(item.itementry.name == "<dev string:x8f8>") {
                  sphere(item.origin, radius, (0, 1, 0), 1, 0, 10, 20);
                } else if(item.itementry.name == "<dev string:x90c>") {
                  sphere(item.origin, radius, (0, 0, 1), 1, 0, 10, 20);
                } else if(item.itementry.name == "<dev string:x921>") {
                  sphere(item.origin, radius, (1, 1, 0), 1, 0, 10, 20);
                } else {
                  sphere(item.origin, radius, color, 1, 0, 10, 20);
                }
              }

              break;
            case 7:
              if(isDefined(item.itementry) && item.itementry.itemtype === # "equipment") {
                sphere(item.origin, radius, color, 1, 0, 10, 20);
              }

              break;
            case 8:
              if(isDefined(item.itementry) && item.itementry.itemtype === # "backpack") {
                sphere(item.origin, radius, color, 1, 0, 10, 20);
              }

              break;
            case 9:
              if(isDefined(item.itementry) && item.itementry.itemtype === # "attachment") {
                sphere(item.origin, radius, color, 1, 0, 10, 20);
              }

              break;
            case 10:
              if(isDefined(item.itementry) && item.itementry.itemtype === # "generic") {
                sphere(item.origin, radius, color, 1, 0, 10, 20);
              }

              break;
            case 11:
              if(isDefined(item.itementry) && item.itementry.itemtype === # "killstreak") {
                sphere(item.origin, radius, color, 1, 0, 10, 20);
              }

              break;
            case 12:
              if(isDefined(item.itementry) && item.itementry.itemtype === # "quest") {
                sphere(item.origin, radius, (1, 0.5, 0), 1, 0, 10, 20);
              }

              break;
            case 13:
              if(isDefined(item.itementry) && item.itementry.itemtype === # "cash") {
                sphere(item.origin, radius, color, 1, 0, 10, 20);
              }

              break;
            case 14:
              if(isDefined(item.itementry) && item.itementry.itemtype === # "resource") {
                sphere(item.origin, radius, color, 1, 0, 10, 20);
              }

              break;
            case 15:
              if(isDefined(item.itementry) && item.itementry.itemtype === # "field_upgrade") {
                sphere(item.origin, radius, color, 1, 0, 10, 20);
              }

              break;
            case 16:
              if(isDefined(item.itementry) && item.itementry.itemtype === # "tactical") {
                sphere(item.origin, radius, color, 1, 0, 10, 20);
              }

              break;
          }
        }
      }
    }

    if(getdvarint(#"hash_5d7b010a8d4f8666", 0)) {
      if(isDefined(level.var_8819644a)) {
        foreach(info in level.var_8819644a) {
          vehicle = info.vehicle;
          spawnpoint = info.origin;
          players = getplayers();

          if(players.size <= 0) {
            continue;
          }

          origin = players[0].origin;

          if(isDefined(vehicle)) {
            radius = 64;
            var_84dd2a8b = 2048;

            if(distancesquared(origin, spawnpoint) < sqr(var_84dd2a8b)) {
              radius = max(distance(origin, spawnpoint) / var_84dd2a8b * radius, 10);
            }

            sphere(spawnpoint, radius, (1, 1, 0), 1, 0, 10, 20);
            line(spawnpoint, vehicle.origin, (0, 1, 0));
            sphere(vehicle.origin, radius, (1, 0, 0), 1, 0, 10, 20);
          }
        }
      }
    }
  }
}

function private function_13c803de() {
  level endon(#"end_game");
  self notify("<dev string:x975>");
  self endon("<dev string:x975>");

  while(true) {
    level waittill(#"host_migration_begin");
    level thread _setup_devgui();
  }
}

function private _setup_devgui() {
  while(!canadddebugcommand()) {
    waitframe(1);
  }

  mapname = util::get_map_name();
  adddebugcommand("<dev string:x989>");
  adddebugcommand("<dev string:xa87>");
  adddebugcommand("<dev string:xb7f>" + mapname + "<dev string:xb91>");
  adddebugcommand("<dev string:xb7f>" + mapname + "<dev string:xbc3>");
  adddebugcommand("<dev string:xc01>");
  adddebugcommand("<dev string:xb7f>" + mapname + "<dev string:xc46>");
  adddebugcommand("<dev string:xc89>" + mapname + "<dev string:xc9a>");
  adddebugcommand("<dev string:xc89>" + mapname + "<dev string:xcec>");
  adddebugcommand("<dev string:xc89>" + mapname + "<dev string:xd38>");
  adddebugcommand("<dev string:xc89>" + mapname + "<dev string:xd85>");
  adddebugcommand("<dev string:xc89>" + mapname + "<dev string:xddb>");
  adddebugcommand("<dev string:xc89>" + mapname + "<dev string:xe40>");
  adddebugcommand("<dev string:xc89>" + mapname + "<dev string:xe9f>");
  adddebugcommand("<dev string:xc89>" + mapname + "<dev string:xef8>");
  adddebugcommand("<dev string:xc89>" + mapname + "<dev string:xf4d>");
  adddebugcommand("<dev string:xc89>" + mapname + "<dev string:xf9c>");
  adddebugcommand("<dev string:xc89>" + mapname + "<dev string:xff1>");
  adddebugcommand("<dev string:xc89>" + mapname + "<dev string:x102a>");
}

function function_91ef342() {
  level endon(#"game_ended");

  while(true) {
    r = level waittill(#"devgui_bot");

    switch (r.args[0]) {
      case # "hash_29f59f6b62fdbf94":
        function_c07eae4e();
        break;
    }
  }
}

function function_c07eae4e() {
  var_6e5bbee1 = [];
  itemcount = function_8322cf16();

  for(i = 0; i < itemcount; i++) {
    item = function_b1702735(i);

    if(isDefined(item.itementry) && item.itementry.itemtype == "<dev string:x440>" && item.itementry.weapon.isprimary) {
      array::add(var_6e5bbee1, item_world_util::function_35e06774(item.itementry), 0);
    }
  }

  var_6e5bbee1 = array::randomize(var_6e5bbee1);

  if(var_6e5bbee1.size == 0) {
    return;
  }

  players = getplayers();
  var_9db8ea1b = 0;

  foreach(player in players) {
    if(isbot(player)) {
      weapon = var_6e5bbee1[var_9db8ea1b];
      player giveweapon(weapon);
      player givemaxammo(weapon);
      player switchtoweaponimmediate(weapon);
      var_9db8ea1b++;

      if(var_9db8ea1b >= var_6e5bbee1.size) {
        var_9db8ea1b = 0;
      }
    }
  }
}

function function_9cc59537() {
  level endon(#"game_ended");
  var_55a05f87 = 0;
  var_cbc7aaf6 = 0;
  var_ebd66b56 = [];
  level flag::wait_till("<dev string:x1080>");

  while(!isDefined(level.players) || !isPlayer(level.players[0])) {
    wait 1;
  }

  level.players[0] endon(#"disconnect");
  gametype = util::get_game_type();
  var_796ab805 = [];

  while(true) {
    wait 1;

    if(!getdvarint(#"hash_68dcd0d52e11b957", 0)) {
      continue;
    }

    do {
      waitframe(8);
      item_spawn_drops = level.item_spawn_drops;

      if(isarray(item_spawn_drops)) {
        foreach(drop in item_spawn_drops) {
          if(isDefined(drop) && !is_true(drop.var_49d5e215)) {
            if(isDefined(drop.itementry.killstreak)) {
              if(!isDefined(var_796ab805[drop.itementry.name])) {
                var_796ab805[drop.itementry.name] = [];
              } else if(!isarray(var_796ab805[drop.itementry.name])) {
                var_796ab805[drop.itementry.name] = array(var_796ab805[drop.itementry.name]);
              }

              var_796ab805[drop.itementry.name][var_796ab805[drop.itementry.name].size] = drop.itementry.killstreak;
            } else if(isDefined(drop.itementry.name) && drop.itementry.name != "<dev string:x1098>") {
              if(!isDefined(var_796ab805[drop.itementry.name])) {
                var_796ab805[drop.itementry.name] = [];
              } else if(!isarray(var_796ab805[drop.itementry.name])) {
                var_796ab805[drop.itementry.name] = array(var_796ab805[drop.itementry.name]);
              }

              var_796ab805[drop.itementry.name][var_796ab805[drop.itementry.name].size] = drop.itementry.name;
            }

            drop.var_49d5e215 = 1;
          }
        }

        var_bd9acc19 = 150;

        foreach(i, item_drop in var_796ab805) {
          var_bd9acc19 += 24;
          var_6abd8aff = function_9e72a96(i) + "<dev string:x8f3>" + item_drop.size;
          debug2dtext((810, var_bd9acc19, 0), var_6abd8aff, (1, 1, 1), undefined, undefined, undefined, undefined, 8);

          if(getdvarint(#"hash_156f2cf900b33f9f", 0)) {
            print(var_6abd8aff + "<dev string:x10ac>");
          }
        }

        if(getdvarint(#"hash_156f2cf900b33f9f", 0)) {
          setDvar(#"hash_156f2cf900b33f9f", 0);
        }
      }

      item_spawn_groups = struct::get_array("<dev string:x10b1>", "<dev string:x10cf>");

      foreach(group in item_spawn_groups) {
        group.debug_spawnpoints = [];
        var_f0179f4a = getdvarstring(#"hash_230734aeaaf8671", "<dev string:x10dc>");

        if(isstring(group.target) && (var_f0179f4a == "<dev string:x10dc>" || function_d72aa67e(var_f0179f4a, group.target))) {
          group.debug_spawnpoints = function_91b29d2a(group.target);
        }
      }

      var_7cb887a8 = [];

      foreach(group in item_spawn_groups) {
        itemlistbundle = getscriptbundle(group.scriptbundlename);

        if(!isDefined(itemlistbundle) || is_true(itemlistbundle.vehiclespawner) || group.debug_spawnpoints.size == 0 || !isDefined(group.targetname) || itemlistbundle.name === "<dev string:x10e3>" || itemlistbundle.name === "<dev string:x1101>" || itemlistbundle.name === "<dev string:x1125>" || !is_true(itemlistbundle.var_4f220d03) && gametype === "<dev string:x1146>") {
          continue;
        } else if(itemlistbundle.name === "<dev string:x115d>") {
          var_df1e5fef = arraysortclosest(group.debug_spawnpoints, level.players[0].origin, 85, 1, getdvarint(#"hash_6ac8a75bc45c3633", 10000));

          foreach(point in var_df1e5fef) {
            sphere(point.origin, 16, (1, 1, 1), 1, 0, 16, 8);
          }

          continue;
        }

        spawn_points = arraysortclosest(group.debug_spawnpoints, level.players[0].origin, 85, 1, getdvarint(#"hash_6ac8a75bc45c3633", 10000));

        foreach(point in spawn_points) {
          if(getdvarint(#"hash_7ae201bf5aee2017", 0)) {
            var_4b82457c = distance2d(point.origin, level.players[0].origin);
            n_radius = getdvarfloat(#"hash_69e2c57538bbcb9b", 0.015) * var_4b82457c;

            if(n_radius > 128) {
              n_radius = 128;
            }

            switch (itemlistbundle.name) {
              case # "hash_102716229ce6474b":
                color = (1, 1, 0);
                break;
              case # "hash_102715229ce64598":
                color = (1, 0, 1);
                break;
              default:
                color = (0, 1, 0);
                break;
            }

            sphere(point.origin, n_radius, color, 1, 0, 16, 8);
            continue;
          }

          if(level.players[0] util::is_player_looking_at(point.origin, 0.6, 0)) {
            b_failed = 0;
            var_47748885 = 28;
            var_c5330f11 = 32;
            v_color = (1, 0, 1);

            if(isDefined(itemlistbundle.itemlist[0])) {
              if(itemlistbundle.itemlist[0].itementry === "<dev string:x117c>" || itemlistbundle.itemlist[0].itementry === "<dev string:x1193>" || itemlistbundle.itemlist[0].itementry === "<dev string:x11a0>" || itemlistbundle.itemlist[0].itementry === "<dev string:x11ad>" || itemlistbundle.itemlist[0].itementry === "<dev string:x11ba>" || itemlistbundle.itemlist[0].itementry === "<dev string:x11c7>") {
                v_color = (1, 1, 0);
                var_47748885 = 4;
                var_c5330f11 = 4;
              }
            } else {
              continue;
            }

            dynents = [];

            if(isDefined(group.targetname)) {
              dynents = function_c79d31c4(group.targetname, 1);

              if(getdvarint(#"hash_f6b57eebb5965e6", 0) && dynents.size >= getdvarint(#"hash_6a4b2cc3aa3a5d21", 50)) {
                foreach(i, stash in dynents) {
                  if(i >= getdvarint(#"hash_6a4b2cc3aa3a5d21", 50)) {
                    continue;
                  }

                  waitframe(2);
                  stash thread namespace_65181344::function_fd87c780(stash.itemlistbundle.name, stash.available, 3);
                }

                setDvar(#"hash_f6b57eebb5965e6", 0);
              }
            }

            items = item_world::function_2e3efdda(point.origin, undefined, 1, var_47748885, -1, 1);

            if(items.size > 0) {
              v_color = (0, 1, 0);
              dynent = undefined;

              foreach(dynent in dynents) {
                if(dynent.origin == point.origin) {
                  var_a835512 = function_ffdbe8c2(dynent);

                  if(var_a835512 === 3) {
                    v_color = (1, 1, 0);
                  } else if(var_a835512 === 2) {
                    v_color = (1, 0.5, 0);
                  }

                  break;
                }
              }
            }

            n_radius = 4;
            var_7cb887a8 = [];
            var_3e832e74 = 360 / 8;
            v_angles = point.angles;
            var_c24ea284 = undefined;
            var_4b82457c = distance2d(point.origin, level.players[0].origin);
            var_24b0b1ea = itemlistbundle.var_7fb0967b;

            if(isDefined(var_24b0b1ea)) {
              if(items.size > 0) {
                var_abc7e003 = item_world::function_2e3efdda(point.origin, undefined, 20, var_24b0b1ea, -1, 1);
                var_abc7e003 = arraysortclosest(var_abc7e003, point.origin, 10, var_47748885);

                foreach(item_type in itemlistbundle.itemlist) {
                  foreach(var_d76a7255 in var_abc7e003) {
                    if(item_type.itementry === var_d76a7255.itementry.name && var_d76a7255.itementry.name === items[0].itementry.name) {
                      print3d(point.origin + (0, 0, 18), item_type.itementry + "<dev string:x11d4>" + var_24b0b1ea, (1, 0.5, 0), 1, 0.3, 8);
                      line(var_d76a7255.origin, point.origin, (1, 0.5, 0), 1, 0, 8);
                    }
                  }
                }
              }
            }

            up = vectorscale(anglestoup(v_angles), 16);

            if(is_true(itemlistbundle.supplystash)) {
              n_depth = 9;
              n_width = 14;

              if(itemlistbundle.name === "<dev string:x10e3>" || itemlistbundle.name === "<dev string:x1101>" || itemlistbundle.name === "<dev string:x1125>") {
                n_depth = 12;
                n_width = 48;
              }

              var_7cb887a8[0] = up + vectorscale(anglesToForward(v_angles), n_depth);
              var_7cb887a8[1] = up + vectorscale(anglesToForward(v_angles) * -1, n_depth + 4);
              var_7cb887a8[2] = up + vectorscale(anglestoright(v_angles), n_width);
              var_7cb887a8[3] = up + vectorscale(anglestoright(v_angles) * -1, n_width);
            } else {
              for(i = 0; i < 8; i++) {
                var_7cb887a8[i] = up + vectorscale(anglesToForward(v_angles), var_47748885);
                v_angles += (0, var_3e832e74, 0);
              }
            }

            var_2e0e7774 = arraysortclosest(spawn_points, point.origin, 20, 1, var_c5330f11);

            foreach(close in var_2e0e7774) {
              if(bullettracepassed(up, close.origin, 0, level.players[0])) {
                v_color = (0, 0, 1);
                b_failed = 1;
                line(close.origin, point.origin, v_color, 1, 0, 8);
                circle(point.origin, var_c5330f11 / 2, v_color, 0, 1, 8);
                print3d(point.origin + (0, 0, 24), sqrt(distancesquared(point.origin, close.origin)), v_color, 1, 0.3, 8);
              }
            }

            if(is_true(itemlistbundle.supplystash)) {
              var_47748885 = n_depth;

              foreach(i, v_test in var_7cb887a8) {
                if(i > 2) {
                  var_47748885 = n_width;
                }

                a_trace = bulletTrace(point.origin + (0, 0, 12), v_test, 0, level.players[0]);

                if(distancesquared(a_trace[#"position"], point.origin + (0, 0, 24)) < var_47748885 * var_47748885 - 20 && !isDefined(a_trace[#"dynent"]) || point.angles[0] > 30 || point.angles[0] < -30 || point.angles[2] < -30 || point.angles[2] > 30) {
                  v_color = (1, 0, 0);
                  b_failed = 1;

                  if(var_4b82457c < 256) {
                    debugstar(a_trace[#"position"], 8, v_color);
                  }
                }
              }

              var_47748885 = 9;
            } else {
              foreach(v_test in var_7cb887a8) {
                a_trace = bulletTrace(up, v_test, 0, level.players[0]);

                if(distancesquared(a_trace[#"position"], up) < var_47748885 * var_47748885 - 6 && !isDefined(a_trace[#"dynent"])) {
                  v_color = (1, 0, 0);
                  b_failed = 1;

                  if(var_4b82457c < 256) {
                    debugstar(a_trace[#"position"], 8, v_color);
                  }
                }
              }
            }

            n_radius = getdvarfloat(#"hash_69e2c57538bbcb9b", 0.015) * var_4b82457c;

            if(isDefined(dynent) && (v_color == (0, 1, 0) || v_color == (1, 1, 0) || v_color == (1, 0.5, 0) || v_color == (1, 0, 0))) {
              point = dynent;
            }

            if(n_radius > 32) {
              n_radius = 32;
            }

            if(var_4b82457c <= 1024) {
              if(is_true(itemlistbundle.supplystash) && v_angles !== (0, 0, 0)) {
                function_47351fa3(point.origin, v_angles, v_color, 8);
                box(point.origin + vectorscale(anglestoup(v_angles), 16), (n_depth + 4, n_width, 16) * -1, (n_depth, n_width, 16), v_angles, v_color, 1, 0, 8);
              } else {
                circle(point.origin, var_47748885, v_color, 0, 1, 8);
              }

              if(var_4b82457c < 512) {
                print3d(point.origin + (0, 0, 48), function_9e72a96(group.targetname), v_color, 1, 0.3, 8);
                print3d(point.origin + (0, 0, 42), function_9e72a96(point.targetname), v_color, 1, 0.3, 8);

                if(var_4b82457c < 256 && level.players[0] util::is_player_looking_at(point.origin, 0.87, 0)) {
                  print3d(point.origin + (0, 0, 36), itemlistbundle.name, v_color, 1, 0.3, 8);
                  print3d(point.origin + (0, 0, 30), point.origin, v_color, 1, 0.3, 8);

                  if(dynents.size > 0) {
                    var_a1bd87ef = getdynentarray(point.targetname);
                    print3d(point.origin + (0, 0, 24), "<dev string:x11f6>" + var_a1bd87ef.size, (1, 1, 0), 1, 0.3, 8);
                    print3d(point.origin + (0, 0, 24), "<dev string:x1206>" + var_a1bd87ef.size, (0, 1, 0), 1, 0.3, 8);
                    print3d(point.origin + (0, 0, 24), "<dev string:x1216>" + dynents.size, (1, 1, 0), 1, 0.3, 8);
                    print3d(point.origin + (0, 0, 18), "<dev string:x1229>" + group.debug_spawnpoints.size, (1, 1, 0), 1, 0.3, 8);
                  }
                }
              }

              continue;
            }

            sphere(point.origin, n_radius, v_color, 1, 0, 8, 8);
          }
        }
      }
    }
    while(getdvarint(#"hash_68dcd0d52e11b957", 0));
  }
}

function function_d72aa67e(str_list, str_name) {
  a_str_tok = strtok(str_list, "<dev string:x8f3>");

  foreach(tok in a_str_tok) {
    if(tok == str_name) {
      return 1;
    }
  }

  return 0;
}

function function_47351fa3(org, ang, opcolor, frames) {
  if(!isDefined(frames)) {
    frames = 1;
  }

  forward = anglesToForward(ang);
  forwardfar = vectorscale(forward, 50);
  forwardclose = vectorscale(forward, 50 * 0.8);
  right = anglestoright(ang);
  left = anglestoright(ang) * -1;
  leftdraw = vectorscale(right, 50 * -0.2);
  rightdraw = vectorscale(right, 50 * 0.2);
  up = anglestoup(ang);
  right = vectorscale(right, 50);
  left = vectorscale(left, 50);
  up = vectorscale(up, 50);
  red = (0.9, 0.2, 0.2);
  green = (0.2, 0.9, 0.2);
  blue = (0.2, 0.2, 0.9);

  if(isDefined(opcolor)) {
    red = opcolor;
    green = opcolor;
    blue = opcolor;
  }

  line(org, org + forwardfar, red, 0.9, 0, frames);
  line(org + forwardfar, org + forwardclose + rightdraw, red, 0.9, 0, frames);
  line(org + forwardfar, org + forwardclose + leftdraw, red, 0.9, 0, frames);
}
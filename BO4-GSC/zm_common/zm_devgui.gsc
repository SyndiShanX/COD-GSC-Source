/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_devgui.gsc
***********************************************/

#include scripts\core_common\aat_shared;
#include scripts\core_common\ai\systems\blackboard;
#include scripts\core_common\ai\zombie_death;
#include scripts\core_common\ai\zombie_shared;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\bots\bot;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\dev_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\gestures;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\popups_shared;
#include scripts\core_common\rank_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm_common\rat;
#include scripts\zm_common\util;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_blockers;
#include scripts\zm_common\zm_characters;
#include scripts\zm_common\zm_equipment;
#include scripts\zm_common\zm_hero_weapon;
#include scripts\zm_common\zm_laststand;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_melee_weapon;
#include scripts\zm_common\zm_pack_a_punch_util;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_placeable_mine;
#include scripts\zm_common\zm_player;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_round_logic;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_turned;
#include scripts\zm_common\zm_ui_inventory;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace zm_devgui;

autoexec __init__system__() {
  system::register(#"zm_devqui", &__init__, &__main__, undefined);
}

__init__() {
  setdvar(#"zombie_devgui", "<dev string:x38>");
  setdvar(#"scr_force_weapon", "<dev string:x38>");
  setdvar(#"scr_zombie_round", 1);
  setdvar(#"scr_zombie_dogs", 1);
  setdvar(#"scr_spawn_tesla", "<dev string:x38>");
  setdvar(#"scr_zombie_variant_type", -1);
  level.devgui_add_weapon = &devgui_add_weapon;
  level.devgui_add_ability = &devgui_add_ability;
  level thread zombie_devgui_think();
  thread zombie_weapon_devgui_think();
  thread function_3b534f9c();
  thread function_1e285ac2();
  thread devgui_zombie_healthbar();
  thread dev::devgui_test_chart_think();

  if(!isDefined(getdvar(#"scr_testscriptruntimeerror"))) {
    setdvar(#"scr_testscriptruntimeerror", "<dev string:x3b>");
  }

  level thread dev::body_customization_devgui(0);
  thread testscriptruntimeerror();
  callback::on_connect(&player_on_connect);
  add_custom_devgui_callback(&function_2f5772bf);
  thread init_debug_center_screen();
}

__main__() {
  level thread zombie_devgui_player_commands();
  level thread zombie_devgui_validation_commands();
  level thread function_358c899d();
  level thread function_5ac8947e();
  level thread zombie_draw_traversals();
  level thread function_8817dd98();
  level thread function_e9b89aac();
  level thread function_38184bf8();
  level thread function_b5d522f8();
}

zombie_devgui_player_commands() {}

function_358c899d() {
  test_scores = array(1, 10, 50, 100, 3500, 9999);
  i = 0;

  foreach(score in test_scores) {
    adddebugcommand("<dev string:x42>" + score + "<dev string:x65>" + i + "<dev string:x69>" + score + "<dev string:x8f>");
    i++;
  }
}

function_5ac8947e() {
  setdvar(#"zombie_devgui_hud", "<dev string:x38>");

  while(true) {
    cmd = getdvar(#"zombie_devgui_hud", "<dev string:x38>");

    if(cmd == "<dev string:x38>") {
      wait 0.1;
      continue;
    }

    if(strstartswith(cmd, "<dev string:x95>")) {
      str = strreplace(cmd, "<dev string:x95>", "<dev string:x38>");
      score = int(str);
      players = getplayers();

      foreach(player in players) {
        if(isplayer(player)) {
          player luinotifyevent(#"score_event", 2, #"hash_60899927812586a1", score);
          break;
        }
      }
    }

    setdvar(#"zombie_devgui_hud", "<dev string:x38>");
  }
}

player_on_connect() {
  level flag::wait_till("<dev string:xa6>");
  wait 1;

  if(isDefined(self)) {
    zombie_devgui_player_menu(self);
  }
}

zombie_devgui_player_menu_clear(playername) {
  rootclear = "<dev string:xc1>" + playername + "<dev string:xe0>";
  adddebugcommand(rootclear);
}

function_c7dd7a17(archetype, subarchetype) {
  if(!isDefined(subarchetype)) {
    subarchetype = "<dev string:x38>";
  }

  displayname = archetype;

  if(isDefined(subarchetype) && subarchetype != "<dev string:x38>") {
    displayname = displayname + "<dev string:xe6>" + subarchetype;
  }

  adddebugcommand("<dev string:xea>" + displayname + "<dev string:x112>" + archetype + "<dev string:xe6>" + subarchetype + "<dev string:x13c>");
}

private function_2f5772bf(cmd) {
  if(strstartswith(cmd, "<dev string:x141>")) {
    player = level.players[0];
    direction = player getplayerangles();
    direction_vec = anglesToForward(direction);
    eye = player getEye();
    direction_vec = (direction_vec[0] * 8000, direction_vec[1] * 8000, direction_vec[2] * 8000);
    trace = bulletTrace(eye, eye + direction_vec, 0, undefined);
    ai = undefined;
    ai_info = strreplace(cmd, "<dev string:x157>", "<dev string:x38>");
    ai_info = strtok(ai_info, "<dev string:xe6>");
    aitype = ai_info[0];

    if(ai_info.size > 1) {
      subarchetype = ai_info[1];
    }

    spawners = getspawnerarray();

    foreach(spawner in spawners) {
      if(isDefined(spawner.archetype) && spawner.archetype == aitype && (!isDefined(subarchetype) || isDefined(spawner.subarchetype) && spawner.subarchetype == subarchetype)) {
        ai_spawner = spawner;
        break;
      }
    }

    if(!isDefined(ai_spawner)) {
      iprintln("<dev string:x16e>" + aitype);
      return;
    }

    ai_spawner.script_forcespawn = 1;
    ai = zombie_utility::spawn_zombie(ai_spawner, undefined, ai_spawner);

    if(isDefined(ai)) {
      if(ai.team != ai_spawner.team) {
        ai.team = ai_spawner.team;
      }

      wait 0.5;

      if(isvehicle(ai)) {
        ai.origin = trace[#"position"];
        ai function_a57c34b7(trace[#"position"]);
        return;
      }

      ai forceteleport(trace[#"position"], player.angles + (0, 180, 0));
    }
  }
}

zombie_devgui_player_menu(player) {
  zombie_devgui_player_menu_clear(player.name);
  ip1 = player getentitynumber() + 1;
  adddebugcommand("<dev string:x18c>" + player.name + "<dev string:x1a8>" + ip1 + "<dev string:x1ae>" + ip1 + "<dev string:x1d9>");
  adddebugcommand("<dev string:x18c>" + player.name + "<dev string:x1a8>" + ip1 + "<dev string:x1e5>" + ip1 + "<dev string:x212>");
  adddebugcommand("<dev string:x18c>" + player.name + "<dev string:x1a8>" + ip1 + "<dev string:x221>" + ip1 + "<dev string:x24c>");
  adddebugcommand("<dev string:x18c>" + player.name + "<dev string:x1a8>" + ip1 + "<dev string:x25c>" + ip1 + "<dev string:x28b>");
  adddebugcommand("<dev string:x18c>" + player.name + "<dev string:x1a8>" + ip1 + "<dev string:x298>" + ip1 + "<dev string:x2c4>");
  adddebugcommand("<dev string:x18c>" + player.name + "<dev string:x1a8>" + ip1 + "<dev string:x2d1>" + ip1 + "<dev string:x2fd>");
  adddebugcommand("<dev string:x18c>" + player.name + "<dev string:x1a8>" + ip1 + "<dev string:x30d>" + ip1 + "<dev string:x332>");
  adddebugcommand("<dev string:x18c>" + player.name + "<dev string:x1a8>" + ip1 + "<dev string:x33d>" + ip1 + "<dev string:x364>");
  adddebugcommand("<dev string:x18c>" + player.name + "<dev string:x1a8>" + ip1 + "<dev string:x371>" + ip1 + "<dev string:x39c>");
  adddebugcommand("<dev string:x18c>" + player.name + "<dev string:x1a8>" + ip1 + "<dev string:x3ad>" + ip1 + "<dev string:x3dc>");
  adddebugcommand("<dev string:x18c>" + player.name + "<dev string:x1a8>" + ip1 + "<dev string:x3f0>" + ip1 + "<dev string:x422>");
  adddebugcommand("<dev string:x18c>" + player.name + "<dev string:x1a8>" + ip1 + "<dev string:x439>" + ip1 + "<dev string:x464>");
  adddebugcommand("<dev string:x18c>" + player.name + "<dev string:x1a8>" + ip1 + "<dev string:x473>" + ip1 + "<dev string:x4a0>");
  adddebugcommand("<dev string:x18c>" + player.name + "<dev string:x1a8>" + ip1 + "<dev string:x4b0>" + ip1 + "<dev string:x4de>");
  adddebugcommand("<dev string:x18c>" + player.name + "<dev string:x1a8>" + ip1 + "<dev string:x4ec>" + ip1 + "<dev string:x51b>");

  if(isDefined(level.validcharacters)) {
    for(i = 0; i < level.validcharacters.size; i++) {
      ci = level.validcharacters[i];
      var_b82273f = getcharacterfields(ci, currentsessionmode());
      adddebugcommand("<dev string:x18c>" + player.name + "<dev string:x1a8>" + ip1 + "<dev string:x52a>" + ci + "<dev string:x547>" + var_b82273f.chrname + "<dev string:x65>" + ci + 1 + "<dev string:x54b>" + ip1 + "<dev string:x569>" + ci + "<dev string:xe0>");
    }
  }

  if(isDefined(level.var_e2c54606)) {
    level thread[[level.var_e2c54606]](player, ip1);
  }

  self thread zombie_devgui_player_menu_clear_on_disconnect(player);
}

zombie_devgui_player_menu_clear_on_disconnect(player) {
  playername = player.name;
  player waittill(#"disconnect");
  zombie_devgui_player_menu_clear(playername);
}

function_38184bf8() {
  while(true) {
    var_c635168c = getdvarint(#"hash_67d19b13a4ab8b94", 0);

    if(var_c635168c >= 0 && isDefined(level.zone_paths[var_c635168c])) {
      zone_paths = level.zone_paths[var_c635168c];

      foreach(var_375627f0, zone_path in zone_paths) {
        zone = level.zones[var_375627f0];
        print_origin = undefined;

        if(isDefined(zone.nodes[0])) {
          print_origin = zone.nodes[0].origin;
        }

        if(!isDefined(print_origin)) {
          print_origin = zone.volumes[0].origin;
        }

        color = (1, 0, 0);

        if(zone_path.cost < 4) {
          color = (0, 1, 0);
        } else if(zone_path.cost < 8) {
          color = (1, 0.5, 0);
        }

        circle(print_origin, 30, color);
        print3d(print_origin, function_9e72a96(var_375627f0), color, 1, 0.5);
        print3d(print_origin + (0, 0, -10), "<dev string:x578>" + zone_path.cost, color, 1, 0.5);

        if(isDefined(zone_path.to_zone)) {
          to_zone = level.zones[zone_path.to_zone];

          if(isDefined(to_zone.nodes[0])) {
            var_fbe06d06 = to_zone.nodes[0].origin;
          }

          if(!isDefined(var_fbe06d06)) {
            var_fbe06d06 = to_zone.volumes[0].origin;
          }

          line(print_origin, var_fbe06d06, color, 0, 0);
        }
      }

      foreach(zone_name, zone in level.zones) {
        if(!isDefined(zone_paths[zone_name])) {
          print_origin = undefined;

          if(isDefined(zone.nodes[0])) {
            print_origin = zone.nodes[0].origin;
          }

          if(!isDefined(print_origin)) {
            print_origin = zone.volumes[0].origin;
          }

          print3d(print_origin, function_9e72a96(zone_name), (1, 0, 0), 1, 0.5);
          circle(print_origin, 30, (1, 0, 0));
          circle(print_origin, 35, (1, 0, 0));
          circle(print_origin, 40, (1, 0, 0));
        }
      }
    }

    waitframe(1);
  }
}

zombie_devgui_validation_commands() {
  setdvar(#"validation_devgui_command", "<dev string:x38>");
  adddebugcommand("<dev string:x580>");
  adddebugcommand("<dev string:x5ca>");
  adddebugcommand("<dev string:x619>");
  adddebugcommand("<dev string:x66a>");

  while(true) {
    cmd = getdvarstring(#"validation_devgui_command");

    if(cmd != "<dev string:x38>") {
      switch (cmd) {
        case #"structs":
          thread bunker_entrance_zoned();
          break;
        case #"spawner":
          zombie_spawner_validation();
          break;
        case #"zone_adj":
          if(!isDefined(level.toggle_zone_adjacencies_validation)) {
            level.toggle_zone_adjacencies_validation = 1;
          } else {
            level.toggle_zone_adjacencies_validation = !level.toggle_zone_adjacencies_validation;
          }

          thread zone_adjacencies_validation();
          break;
        case #"zone_paths":
          break;
        case #"pathing":
          thread zombie_pathing_validation();
        default:
          break;
      }

      setdvar(#"validation_devgui_command", "<dev string:x38>");
    }

    util::wait_network_frame();
  }
}

function_edce7be0() {
  spawners = getspawnerarray();
  var_26193d02 = [];

  foreach(spawner in spawners) {
    have_spawner = 0;

    foreach(unique_spawner in var_26193d02) {
      if(spawner.classname === unique_spawner.classname) {
        have_spawner = 1;
        break;
      }
    }

    if(have_spawner) {
      continue;
    }

    if(!isDefined(var_26193d02)) {
      var_26193d02 = [];
    } else if(!isarray(var_26193d02)) {
      var_26193d02 = array(var_26193d02);
    }

    if(!isinarray(var_26193d02, spawner)) {
      var_26193d02[var_26193d02.size] = spawner;
    }
  }

  return var_26193d02;
}

function_6758ede4(zone) {
  if(isDefined(zone.nodes)) {
    foreach(node in zone.nodes) {
      node_region = getnoderegion(node);

      if(!isDefined(node_region)) {
        thread drawvalidation(node.origin, undefined, undefined, undefined, node);
      }
    }
  }
}

function_995340b7(zone, var_87f65b00) {
  if(!isDefined(zone.a_loc_types[#"wait_location"]) || zone.a_loc_types[#"wait_location"].size <= 0) {
    if(isDefined(var_87f65b00) && var_87f65b00) {
      level.validation_errors_count++;

      if(isDefined(zone.nodes) && zone.nodes.size > 0) {
        origin = zone.nodes[0].origin + (0, 0, 32);
      } else {
        origin = zone.volumes[0].origin;
      }

      thread drawvalidation(origin, zone.name);
      println("<dev string:x6c1>" + zone.name);
      iprintlnbold("<dev string:x6c1>" + zone.name);
    }

    return 0;
  }

  return 1;
}

function_1f0bc660(zone, enemy, spawner, spawn_location) {
  if(!isDefined(zone.a_loc_types[spawn_location])) {
    return enemy;
  }

  foreach(spawn_point in zone.a_loc_types[spawn_location]) {
    if(!isDefined(enemy)) {
      enemy = zombie_utility::spawn_zombie(spawner, spawner.targetname, spawn_point);
    }

    spawn_point_origin = spawn_point.origin;

    if(isDefined(spawn_point.script_string) && spawn_point.script_string != "<dev string:x6e8>") {
      spawn_point_origin = enemy validate_to_board(spawn_point, spawn_point_origin);
    }

    if(!ispointonnavmesh(spawn_point_origin, enemy getpathfindingradius() + 1)) {
      new_spawn_point_origin = getclosestpointonnavmesh(spawn_point_origin, 64, enemy getpathfindingradius() + 1);
    } else {
      new_spawn_point_origin = spawn_point_origin;
    }

    var_d37fcf94 = isDefined(spawn_point.script_noteworthy) && !issubstr(spawn_point.script_noteworthy, "<dev string:x6f5>");

    if(isDefined(var_d37fcf94) && var_d37fcf94 && !isDefined(new_spawn_point_origin) && !(isDefined(spawn_point.var_f0596bbb) && spawn_point.var_f0596bbb)) {
      level.validation_errors_count++;
      thread drawvalidation(spawn_point_origin);
      println("<dev string:x70c>" + spawn_point_origin);
      iprintlnbold("<dev string:x747>" + spawn_point_origin);
      spawn_point.var_f0596bbb = 1;
    }

    if(!isDefined(new_spawn_point_origin)) {
      continue;
    }

    ispath = enemy validate_to_wait_point(zone, new_spawn_point_origin, spawn_point);
  }

  return enemy;
}

zombie_spawner_validation() {
  level.validation_errors_count = 0;

  if(!isDefined(level.toggle_spawner_validation)) {
    level.toggle_spawner_validation = 1;
    zombie_devgui_open_sesame();
    spawners = function_edce7be0();

    foreach(zone in level.zones) {
      function_6758ede4(zone);
      function_995340b7(zone, 1);
    }

    foreach(spawner in spawners) {
      if(!isDefined(spawner.aitype)) {
        continue;
      }

      archetype = getarchetypefromclassname(spawner.aitype);

      if(!isDefined(archetype)) {
        continue;
      }

      var_f41ab3f2 = spawner ai::function_9139c839().spawnlocations;

      if(!isDefined(var_f41ab3f2)) {
        continue;
      }

      var_4d7c27e3 = 0;
      enemy = undefined;

      foreach(zone in level.zones) {
        if(!function_995340b7(zone)) {
          continue;
        }

        foreach(var_37121713 in var_f41ab3f2) {
          enemy = function_1f0bc660(zone, enemy, spawner, var_37121713.spawnlocation);

          if(isDefined(enemy)) {
            var_4d7c27e3 = 1;
          }
        }
      }

      if(!var_4d7c27e3) {
        iprintlnbold("<dev string:x783>" + spawner.aitype);
      }
    }

    println("<dev string:x7b0>" + level.validation_errors_count);
    iprintlnbold("<dev string:x7b0>" + level.validation_errors_count);
    level.validation_errors_count = undefined;
    return;
  }

  level.toggle_spawner_validation = !level.toggle_spawner_validation;
}

validate_to_board(spawn_point, spawn_point_origin_backup) {
  for(j = 0; j < level.exterior_goals.size; j++) {
    if(isDefined(level.exterior_goals[j].script_string) && level.exterior_goals[j].script_string == spawn_point.script_string) {
      node = level.exterior_goals[j];
      break;
    }
  }

  if(isDefined(node)) {
    ispath = self canpath(spawn_point.origin, node.origin);

    if(!ispath) {
      level.validation_errors_count++;
      thread drawvalidation(spawn_point_origin_backup, undefined, undefined, node.origin, undefined, self.archetype);

      if(isDefined(self.archetype)) {
        println("<dev string:x7db>" + function_9e72a96(self.archetype) + "<dev string:x7eb>" + spawn_point_origin_backup + "<dev string:x80c>" + spawn_point.targetname);
        iprintlnbold("<dev string:x7db>" + function_9e72a96(self.archetype) + "<dev string:x7eb>" + spawn_point_origin_backup + "<dev string:x80c>" + spawn_point.targetname);
      } else {
        println("<dev string:x827>" + spawn_point_origin_backup + "<dev string:x80c>" + spawn_point.targetname);
        iprintlnbold("<dev string:x827>" + spawn_point_origin_backup + "<dev string:x80c>" + spawn_point.targetname);
      }
    }

    nodeforward = anglesToForward(node.angles);
    nodeforward = vectornormalize(nodeforward);
    spawn_point_origin = node.origin + nodeforward * 100;
    return spawn_point_origin;
  }

  return spawn_point_origin_backup;
}

validate_to_wait_point(zone, new_spawn_point_origin, spawn_point) {
  foreach(loc in zone.a_loc_types[#"wait_location"]) {
    if(isDefined(loc)) {
      wait_point = loc.origin;

      if(isDefined(wait_point)) {
        new_wait_point = getclosestpointonnavmesh(wait_point, self getpathfindingradius(), 30);

        if(isDefined(new_spawn_point_origin) && isDefined(new_wait_point)) {
          ispath = self findpath(new_spawn_point_origin, new_wait_point);

          if(ispath) {
            return 1;
          }

          level.validation_errors_count++;
          thread drawvalidation(new_spawn_point_origin, undefined, new_wait_point, undefined, undefined, self.archetype);

          if(isDefined(self.archetype)) {
            println("<dev string:x85b>" + function_9e72a96(self.archetype) + "<dev string:x7eb>" + new_spawn_point_origin + "<dev string:x86a>" + spawn_point.targetname);
            iprintlnbold("<dev string:x7db>" + function_9e72a96(self.archetype) + "<dev string:x7eb>" + new_spawn_point_origin + "<dev string:x86a>" + spawn_point.targetname);
          } else {
            println("<dev string:x827>" + new_spawn_point_origin + "<dev string:x86a>" + spawn_point.targetname);
            iprintlnbold("<dev string:x827>" + new_spawn_point_origin + "<dev string:x86a>" + spawn_point.targetname);
          }

          return 0;
        }
      }
    }
  }

  return 0;
}

drawvalidation(origin, zone_name, nav_mesh_wait_point, boards_point, zone_node, archetype) {
  if(!isDefined(zone_name)) {
    zone_name = undefined;
  }

  if(!isDefined(nav_mesh_wait_point)) {
    nav_mesh_wait_point = undefined;
  }

  if(!isDefined(boards_point)) {
    boards_point = undefined;
  }

  if(!isDefined(zone_node)) {
    zone_node = undefined;
  }

  if(!isDefined(archetype)) {
    archetype = undefined;
  }

  if(isDefined(archetype)) {
    archetype = function_9e72a96(archetype);
  }

  while(true) {
    if(isDefined(level.toggle_spawner_validation) && level.toggle_spawner_validation) {
      if(!isDefined(origin)) {
        break;
      }

      if(isDefined(zone_name)) {
        circle(origin, 32, (1, 0, 0));
        print3d(origin, "<dev string:x88c>" + zone_name, (1, 1, 1), 1, 0.5);
      } else if(isDefined(nav_mesh_wait_point)) {
        circle(origin, 32, (0, 0, 1));

        if(isDefined(archetype)) {
          print3d(origin, archetype + "<dev string:x8a9>" + origin, (1, 1, 1), 1, 0.5);
        } else {
          print3d(origin, "<dev string:x8cc>" + origin, (1, 1, 1), 1, 0.5);
        }

        line(origin, nav_mesh_wait_point, (1, 0, 0));
        circle(nav_mesh_wait_point, 32, (1, 0, 0));
        print3d(nav_mesh_wait_point, "<dev string:x8f5>" + nav_mesh_wait_point, (1, 1, 1), 1, 0.5);
      } else if(isDefined(boards_point)) {
        circle(origin, 32, (0, 0, 1));

        if(isDefined(archetype)) {
          print3d(origin, archetype + "<dev string:x8a9>" + origin, (1, 1, 1), 1, 0.5);
        } else {
          print3d(origin, "<dev string:x8cc>" + origin, (1, 1, 1), 1, 0.5);
        }

        line(origin, boards_point, (1, 0, 0));
        circle(boards_point, 32, (1, 0, 0));
        print3d(boards_point, "<dev string:x907>" + boards_point, (1, 1, 1), 1, 0.5);
      } else if(isDefined(zone_node)) {
        circle(origin, 32, (1, 0, 0));
        print3d(origin, "<dev string:x918>" + (isDefined(zone_node.targetname) ? zone_node.targetname : "<dev string:x38>") + "<dev string:x925>" + origin + "<dev string:x92c>", (1, 1, 1), 1, 0.5);
      } else {
        circle(origin, 32, (0, 0, 1));
        print3d(origin, "<dev string:x946>" + origin, (1, 1, 1), 1, 0.5);
      }
    }

    waitframe(1);
  }
}

zone_adjacencies_validation() {
  zombie_devgui_open_sesame();

  while(true) {
    if(isDefined(level.toggle_zone_adjacencies_validation) && level.toggle_zone_adjacencies_validation) {
      if(!isDefined(getplayers()[0].zone_name)) {
        waitframe(1);
        continue;
      }

      str_zone = getplayers()[0].zone_name;
      keys = getarraykeys(level.zones);
      offset = 0;

      foreach(key in keys) {
        if(key === str_zone) {
          draw_zone_adjacencies_validation(level.zones[key], 2, key);
          continue;
        }

        if(isDefined(level.zones[str_zone].adjacent_zones[key])) {
          if(level.zones[str_zone].adjacent_zones[key].is_connected) {
            offset += 10;
            draw_zone_adjacencies_validation(level.zones[key], 1, key, level.zones[str_zone], offset);
          } else {
            draw_zone_adjacencies_validation(level.zones[key], 0, key);
          }

          continue;
        }

        draw_zone_adjacencies_validation(level.zones[key], 0, key);
      }

      foreach(zone in level.zones) {
        function_f4669d7b(level.zones, zone);
      }
    }

    waitframe(1);
  }
}

draw_zone_adjacencies_validation(zone, status, name, current_zone, offset) {
  if(!isDefined(current_zone)) {
    current_zone = undefined;
  }

  if(!isDefined(offset)) {
    offset = 0;
  }

  if(!isDefined(zone.volumes[0]) && !isDefined(zone.nodes[0])) {
    return;
  }

  if(isDefined(zone.nodes[0])) {
    print_origin = zone.nodes[0].origin;
  }

  if(!isDefined(print_origin)) {
    print_origin = zone.volumes[0].origin;
  }

  if(status == 2) {
    circle(print_origin, 30, (0, 1, 0));
    print3d(print_origin, function_9e72a96(name), (0, 1, 0), 1, 0.5);
    return;
  }

  if(status == 1) {
    circle(print_origin, 30, (0, 0, 1));
    print3d(print_origin, function_9e72a96(name), (0, 0, 1), 1, 0.5);

    if(isDefined(current_zone.nodes[0])) {
      print_origin = current_zone.nodes[0].origin;
    }

    if(!isDefined(print_origin)) {
      print_origin = current_zone.volumes[0].origin;
    }

    print3d(print_origin + (0, 20, offset * -1), function_9e72a96(name), (0, 0, 1), 1, 0.5);
    return;
  }

  circle(print_origin, 30, (1, 0, 0));
  print3d(print_origin, function_9e72a96(name), (1, 0, 0), 1, 0.5);
}

function_f4669d7b(zones, zone) {
  if(!isDefined(zone.volumes[0]) && !isDefined(zone.nodes[0])) {
    return;
  }

  if(isDefined(zone.nodes[0])) {
    origin = zone.nodes[0].origin;
  }

  if(!isDefined(origin)) {
    origin = zone.volumes[0].origin;
  }

  foreach(var_4c973d00, adjacent in zone.adjacent_zones) {
    adjacent_zone = zones[var_4c973d00];

    if(adjacent_zone.nodes.size && isDefined(adjacent_zone.nodes[0].origin)) {
      var_16c82636 = adjacent_zone.nodes[0].origin;
    }

    if(!isDefined(var_16c82636)) {
      var_16c82636 = adjacent_zone.volumes[0].origin;
    }

    if(adjacent.is_connected) {
      line(origin, var_16c82636, (0, 1, 0), 0, 0);
      continue;
    }

    line(origin, var_16c82636, (1, 0, 0), 0, 0);
  }
}

zombie_pathing_validation() {
  if(!isDefined(level.zombie_spawners[0])) {
    return;
  }

  if(!isDefined(level.zombie_pathing_validation)) {
    level.zombie_pathing_validation = 1;
  }

  zombie_devgui_open_sesame();
  setdvar(#"zombie_default_max", 0);
  zombie_devgui_goto_round(20);
  wait 2;
  spawner = level.zombie_spawners[0];
  slums_station = (808, -1856, 544);
  enemy = zombie_utility::spawn_zombie(spawner, spawner.targetname);
  wait 1;

  while(isDefined(enemy) && enemy.completed_emerging_into_playable_area !== 1) {
    waitframe(1);
  }

  if(isDefined(enemy)) {
    enemy forceteleport(slums_station);
    enemy.b_ignore_cleanup = 1;
  }
}

function_bcc8843e(weapon_name, up, root) {
  util::waittill_can_add_debug_command();
  rootslash = "<dev string:x38>";

  if(isDefined(root) && root.size) {
    rootslash = root + "<dev string:x95f>";
  }

  uppath = "<dev string:x95f>" + up;

  if(up.size < 1) {
    uppath = "<dev string:x38>";
  }

  cmd = "<dev string:x963>" + rootslash + weapon_name + uppath + "<dev string:x987>" + weapon_name + "<dev string:xe0>";
  adddebugcommand(cmd);
}

devgui_add_weapon_entry(weapon, root, n_order) {
  weapon_name = getweaponname(weapon);

  if(isDefined(root) && root.size) {
    adddebugcommand("<dev string:x9b3>" + root + "<dev string:x65>" + n_order + "<dev string:x95f>" + weapon_name + "<dev string:x9cd>" + weapon_name + "<dev string:xe0>");
    return;
  }

  if(getdvarint(#"zm_debug_attachments", 0)) {
    var_876795bf = weapon.supportedattachments;
    weapon_root = "<dev string:x9b3>" + weapon_name + "<dev string:x95f>";
    adddebugcommand(weapon_root + weapon_name + "<dev string:x9cd>" + weapon_name + "<dev string:xe0>");

    foreach(var_96bc131f in var_876795bf) {
      if(var_96bc131f != "<dev string:x3b>" && var_96bc131f != "<dev string:x9e9>") {
        util::waittill_can_add_debug_command();
        var_29c3a74d = weapon_name + "<dev string:x9f0>" + var_96bc131f;
        adddebugcommand(weapon_root + var_29c3a74d + "<dev string:x9cd>" + var_29c3a74d + "<dev string:xe0>");
      }
    }

    return;
  }

  adddebugcommand("<dev string:x9b3>" + weapon_name + "<dev string:x9cd>" + weapon_name + "<dev string:xe0>");
}

devgui_add_weapon(weapon, upgrade, in_box, cost, weaponvo, weaponvoresp, ammo_cost) {
  level endon(#"game_ended");

  if(in_box) {
    level thread function_bcc8843e(getweaponname(weapon), "<dev string:x38>", "<dev string:x38>");
  }

  util::waittill_can_add_debug_command();

  if(zm_loadout::is_offhand_weapon(weapon) && !zm_loadout::is_melee_weapon(weapon)) {
    devgui_add_weapon_entry(weapon, "<dev string:x9f6>", 2);
    return;
  }

  if(zm_loadout::is_melee_weapon(weapon)) {
    devgui_add_weapon_entry(weapon, "<dev string:xa00>", 3);
    return;
  }

  if(zm_weapons::is_wonder_weapon(weapon)) {
    devgui_add_weapon_entry(weapon, "<dev string:xa08>", 5);
    return;
  }

  devgui_add_weapon_entry(weapon);
}

function_3b534f9c() {
  level.zombie_devgui_gun = getdvarstring(#"hash_1c9225f4f6e82068");

  for(;;) {
    wait 0.1;
    cmd = getdvarstring(#"hash_1c9225f4f6e82068");

    if(isDefined(cmd) && cmd.size > 0) {
      level.zombie_devgui_gun = cmd;
      players = getplayers();

      if(players.size >= 1) {
        players[0] thread zombie_devgui_weapon_give(level.zombie_devgui_gun);
      }

      setdvar(#"hash_1c9225f4f6e82068", "<dev string:x38>");
    }

    wait 0.1;
    cmd = getdvarstring(#"hash_1c9228f4f6e82581");

    if(isDefined(cmd) && cmd.size > 0) {
      level.zombie_devgui_gun = cmd;
      players = getplayers();

      if(players.size >= 2) {
        players[1] thread zombie_devgui_weapon_give(level.zombie_devgui_gun);
      }

      setdvar(#"hash_1c9228f4f6e82581", "<dev string:x38>");
    }

    wait 0.1;
    cmd = getdvarstring(#"hash_1c9227f4f6e823ce");

    if(isDefined(cmd) && cmd.size > 0) {
      level.zombie_devgui_gun = cmd;
      players = getplayers();

      if(players.size >= 3) {
        players[2] thread zombie_devgui_weapon_give(level.zombie_devgui_gun);
      }

      setdvar(#"hash_1c9227f4f6e823ce", "<dev string:x38>");
    }

    wait 0.1;
    cmd = getdvarstring(#"hash_1c922af4f6e828e7");

    if(isDefined(cmd) && cmd.size > 0) {
      level.zombie_devgui_gun = cmd;
      players = getplayers();

      if(players.size >= 4) {
        players[3] thread zombie_devgui_weapon_give(level.zombie_devgui_gun);
      }

      setdvar(#"hash_1c922af4f6e828e7", "<dev string:x38>");
    }
  }
}

zombie_weapon_devgui_think() {
  level.zombie_devgui_gun = getdvarstring(#"zombie_devgui_gun");

  for(;;) {
    wait 0.25;
    cmd = getdvarstring(#"zombie_devgui_gun");

    if(isDefined(cmd) && cmd.size > 0) {
      level.zombie_devgui_gun = cmd;
      array::thread_all(getplayers(), &zombie_devgui_weapon_give, level.zombie_devgui_gun);
      setdvar(#"zombie_devgui_gun", "<dev string:x38>");
    }
  }
}

zombie_devgui_weapon_give(weapon_name) {
  split = strtok(function_9e72a96(weapon_name), "<dev string:x9f0>");

  switch (split.size) {
    case 1:
    default:
      weapon = getweapon(split[0]);
      break;
    case 2:
      weapon = getweapon(split[0], split[1]);
      break;
    case 3:
      weapon = getweapon(split[0], split[1], split[2]);
      break;
    case 4:
      weapon = getweapon(split[0], split[1], split[2], split[3]);
      break;
    case 5:
      weapon = getweapon(split[0], split[1], split[2], split[3], split[4]);
      break;
  }

  if(zm_loadout::is_melee_weapon(weapon) && isDefined(zm_melee_weapon::find_melee_weapon(weapon))) {
    self zm_melee_weapon::award_melee_weapon(weapon_name);
    return;
  }

  self function_2d4d7fd9(weapon);
}

function_2d4d7fd9(weapon) {
  if(self hasweapon(weapon, 1)) {
    self takeweapon(weapon, 1);
  }

  self thread function_bb54e671(weapon);
  self zm_weapons::weapon_give(weapon);
}

function_bb54e671(weapon) {
  self notify(#"hash_7c6363440c125d8b");
  self endon(#"disconnect", #"hash_7c6363440c125d8b");

  if(!isDefined(self.var_8d5839f4)) {
    self.var_8d5839f4 = [];
  } else if(!isarray(self.var_8d5839f4)) {
    self.var_8d5839f4 = array(self.var_8d5839f4);
  }

  self.var_8d5839f4[self.var_8d5839f4.size] = weapon;

  while(true) {
    self waittill(#"weapon_change_complete");

    foreach(weapon in arraycopy(self.var_8d5839f4)) {
      if(!self hasweapon(weapon)) {
        arrayremovevalue(self.var_8d5839f4, weapon);
      }
    }
  }
}

devgui_add_ability(name, upgrade_active_func, stat_name, stat_desired_value, game_end_reset_if_not_achieved) {
  online_game = sessionmodeisonlinegame();

  if(!online_game) {
    return;
  }

  if(!(isDefined(level.devgui_watch_abilities) && level.devgui_watch_abilities)) {
    cmd = "<dev string:xa18>";
    adddebugcommand(cmd);
    cmd = "<dev string:xa74>";
    adddebugcommand(cmd);
    level thread zombie_ability_devgui_think();
    level.devgui_watch_abilities = 1;
  }

  cmd = "<dev string:xace>" + name + "<dev string:xaf2>" + name + "<dev string:xe0>";
  adddebugcommand(cmd);
  cmd = "<dev string:xb17>" + name + "<dev string:xb40>" + name + "<dev string:xe0>";
  adddebugcommand(cmd);
}

zombie_devgui_ability_give(name) {}

zombie_devgui_ability_take(name) {}

zombie_ability_devgui_think() {
  level.zombie_devgui_give_ability = getdvarstring(#"zombie_devgui_give_ability");
  level.zombie_devgui_take_ability = getdvarstring(#"zombie_devgui_take_ability");

  for(;;) {
    wait 0.25;
    cmd = getdvarstring(#"zombie_devgui_give_ability");

    if(!isDefined(level.zombie_devgui_give_ability) || level.zombie_devgui_give_ability != cmd) {
      if(cmd == "<dev string:xb65>") {
        level flag::set("<dev string:xb70>");
      } else if(cmd == "<dev string:xb85>") {
        level flag::clear("<dev string:xb70>");
      } else {
        level.zombie_devgui_give_ability = cmd;
        array::thread_all(getplayers(), &zombie_devgui_ability_give, level.zombie_devgui_give_ability);
      }
    }

    wait 0.25;
    cmd = getdvarstring(#"zombie_devgui_take_ability");

    if(!isDefined(level.zombie_devgui_take_ability) || level.zombie_devgui_take_ability != cmd) {
      level.zombie_devgui_take_ability = cmd;
      array::thread_all(getplayers(), &zombie_devgui_ability_take, level.zombie_devgui_take_ability);
    }
  }
}

zombie_healthbar(pos, dsquared) {
  if(distancesquared(pos, self.origin) > dsquared) {
    return;
  }

  rate = 1;

  if(isDefined(self.maxhealth)) {
    rate = self.health / self.maxhealth;
  }

  color = (1 - rate, rate, 0);
  text = "<dev string:x38>" + int(self.health);
  print3d(self.origin + (0, 0, 0), text, color, 1, 0.5, 1);
}

devgui_zombie_healthbar() {
  while(true) {
    if(getdvarint(#"scr_zombie_healthbars", 0) == 1) {
      e_player = getplayers()[0];

      if(isalive(e_player)) {
        a_ai_zombies = getaispeciesarray("<dev string:xb8f>", "<dev string:xb8f>");

        foreach(ai_zombie in a_ai_zombies) {
          ai_zombie zombie_healthbar(e_player.origin, 360000);
        }
      }
    }

    waitframe(1);
  }
}

zombie_devgui_watch_input() {
  level flag::wait_till("<dev string:xa6>");
  wait 1;
  players = getplayers();

  for(i = 0; i < players.size; i++) {
    players[i] thread watch_debug_input();
  }
}

damage_player() {
  self val::set(#"damage_player", "<dev string:xb95>", 1);
  self dodamage(self.health / 2, self.origin);
}

kill_player() {
  self val::set(#"kill_player", "<dev string:xb95>", 1);
  death_from = (randomfloatrange(-20, 20), randomfloatrange(-20, 20), randomfloatrange(-20, 20));
  self dodamage(self.health + 666, self.origin + death_from);
}

force_drink() {
  wait 0.01;
  build_weapon = getweapon(#"zombie_builder");
  self thread gestures::function_f3e2696f(self, build_weapon, undefined, 2.5, undefined, undefined, undefined);
}

zombie_devgui_dpad_none() {
  self thread watch_debug_input();
}

zombie_devgui_dpad_death() {
  self thread watch_debug_input(&kill_player);
}

zombie_devgui_dpad_damage() {
  self thread watch_debug_input(&damage_player);
}

zombie_devgui_dpad_changeweapon() {
  self thread watch_debug_input(&force_drink);
}

watch_debug_input(callback) {
  self endon(#"disconnect");
  self notify(#"watch_debug_input");
  self endon(#"watch_debug_input");
  level.devgui_dpad_watch = 0;

  if(isDefined(callback)) {
    level.devgui_dpad_watch = 1;

    for(;;) {
      if(self actionslottwobuttonpressed()) {
        self thread[[callback]]();

        while(self actionslottwobuttonpressed()) {
          waitframe(1);
        }
      }

      waitframe(1);
    }
  }
}

zombie_devgui_think() {
  level notify(#"zombie_devgui_think");
  level endon(#"zombie_devgui_think");

  for(;;) {
    cmd = getdvarstring(#"zombie_devgui");

    switch (cmd) {
      case #"money":
        players = getplayers();
        array::thread_all(players, &zombie_devgui_give_money);
        break;
      case #"player1_money":
        players = getplayers();

        if(players.size >= 1) {
          players[0] thread zombie_devgui_give_money();
        }

        break;
      case #"player2_money":
        players = getplayers();

        if(players.size >= 2) {
          players[1] thread zombie_devgui_give_money();
        }

        break;
      case #"player3_money":
        players = getplayers();

        if(players.size >= 3) {
          players[2] thread zombie_devgui_give_money();
        }

        break;
      case #"player4_money":
        players = getplayers();

        if(players.size >= 4) {
          players[3] thread zombie_devgui_give_money();
        }

        break;
      case #"moneydown":
        players = getplayers();
        array::thread_all(players, &zombie_devgui_take_money);
        break;
      case #"player1_moneydown":
        players = getplayers();

        if(players.size >= 1) {
          players[0] thread zombie_devgui_take_money();
        }

        break;
      case #"player2_moneydown":
        players = getplayers();

        if(players.size >= 2) {
          players[1] thread zombie_devgui_take_money();
        }

        break;
      case #"player3_moneydown":
        players = getplayers();

        if(players.size >= 3) {
          players[2] thread zombie_devgui_take_money();
        }

        break;
      case #"player4_moneydown":
        players = getplayers();

        if(players.size >= 4) {
          players[3] thread zombie_devgui_take_money();
        }

        break;
      case #"ammodown":
        players = getplayers();
        array::thread_all(players, &function_dc7312be);
        break;
      case #"hash_428dbd0a89fc5d32":
        players = getplayers();

        if(players.size >= 1) {
          players[0] thread function_dc7312be();
        }

        break;
      case #"hash_119220b211e16ba9":
        players = getplayers();

        if(players.size >= 2) {
          players[1] thread function_dc7312be();
        }

        break;
      case #"hash_6cdf097974c7bcd0":
        players = getplayers();

        if(players.size >= 3) {
          players[2] thread function_dc7312be();
        }

        break;
      case #"hash_5e281497ef267e37":
        players = getplayers();

        if(players.size >= 4) {
          players[3] thread function_dc7312be();
        }

        break;
      case #"hash_59a96f9816430398":
        players = getplayers();

        if(players.size >= 1) {
          players[0] thread zombie_devgui_give_xp(1000);
        }

        break;
      case #"hash_423b4f1fbe6391dd":
        players = getplayers();

        if(players.size >= 2) {
          players[1] thread zombie_devgui_give_xp(1000);
        }

        break;
      case #"hash_50580bf75ed9e65e":
        players = getplayers();

        if(players.size >= 3) {
          players[2] thread zombie_devgui_give_xp(1000);
        }

        break;
      case #"hash_4e18caaf131ec443":
        players = getplayers();

        if(players.size >= 4) {
          players[3] thread zombie_devgui_give_xp(1000);
        }

        break;
      case #"hash_1dec476dd3df3678":
        players = getplayers();

        if(players.size >= 1) {
          players[0] thread zombie_devgui_give_xp(10000);
        }

        break;
      case #"hash_6e595ff08330f5b7":
        players = getplayers();

        if(players.size >= 2) {
          players[1] thread zombie_devgui_give_xp(10000);
        }

        break;
      case #"hash_5f82c3562c428cea":
        players = getplayers();

        if(players.size >= 3) {
          players[2] thread zombie_devgui_give_xp(10000);
        }

        break;
      case #"hash_52e4da7d7d47cf69":
        players = getplayers();

        if(players.size >= 4) {
          players[3] thread zombie_devgui_give_xp(10000);
        }

        break;
      case #"health":
        array::thread_all(getplayers(), &zombie_devgui_give_health);
        break;
      case #"player1_health":
        players = getplayers();

        if(players.size >= 1) {
          players[0] thread zombie_devgui_give_health();
        }

        break;
      case #"player2_health":
        players = getplayers();

        if(players.size >= 2) {
          players[1] thread zombie_devgui_give_health();
        }

        break;
      case #"player3_health":
        players = getplayers();

        if(players.size >= 3) {
          players[2] thread zombie_devgui_give_health();
        }

        break;
      case #"player4_health":
        players = getplayers();

        if(players.size >= 4) {
          players[3] thread zombie_devgui_give_health();
        }

        break;
      case #"minhealth":
        array::thread_all(getplayers(), &zombie_devgui_low_health);
        break;
      case #"player1_minhealth":
        players = getplayers();

        if(players.size >= 1) {
          players[0] thread zombie_devgui_low_health();
        }

        break;
      case #"player2_minhealth":
        players = getplayers();

        if(players.size >= 2) {
          players[1] thread zombie_devgui_low_health();
        }

        break;
      case #"player3_minhealth":
        players = getplayers();

        if(players.size >= 3) {
          players[2] thread zombie_devgui_low_health();
        }

        break;
      case #"player4_minhealth":
        players = getplayers();

        if(players.size >= 4) {
          players[3] thread zombie_devgui_low_health();
        }

        break;
      case #"ammo":
        array::thread_all(getplayers(), &zombie_devgui_toggle_ammo);
        break;
      case #"ignore":
        array::thread_all(getplayers(), &zombie_devgui_toggle_ignore);
        break;
      case #"player1_ignore":
        players = getplayers();

        if(players.size >= 1) {
          players[0] thread zombie_devgui_toggle_ignore();
        }

        break;
      case #"player2_ignore":
        players = getplayers();

        if(players.size >= 2) {
          players[1] thread zombie_devgui_toggle_ignore();
        }

        break;
      case #"player3_ignore":
        players = getplayers();

        if(players.size >= 3) {
          players[2] thread zombie_devgui_toggle_ignore();
        }

        break;
      case #"player4_ignore":
        players = getplayers();

        if(players.size >= 4) {
          players[3] thread zombie_devgui_toggle_ignore();
        }

        break;
      case #"invul_on":
        zombie_devgui_invulnerable(undefined, 1);
        break;
      case #"invul_off":
        zombie_devgui_invulnerable(undefined, 0);
        break;
      case #"player1_invul_on":
        zombie_devgui_invulnerable(0, 1);
        break;
      case #"player1_invul_off":
        zombie_devgui_invulnerable(0, 0);
        break;
      case #"player2_invul_on":
        zombie_devgui_invulnerable(1, 1);
        break;
      case #"player2_invul_off":
        zombie_devgui_invulnerable(1, 0);
        break;
      case #"player3_invul_on":
        zombie_devgui_invulnerable(2, 1);
        break;
      case #"player3_invul_off":
        zombie_devgui_invulnerable(2, 0);
        break;
      case #"player4_invul_on":
        zombie_devgui_invulnerable(3, 1);
        break;
      case #"player4_invul_off":
        zombie_devgui_invulnerable(3, 0);
        break;
      case #"revive_all":
        array::thread_all(getplayers(), &zombie_devgui_revive);
        break;
      case #"player1_revive":
        players = getplayers();

        if(players.size >= 1) {
          players[0] thread zombie_devgui_revive();
        }

        break;
      case #"player2_revive":
        players = getplayers();

        if(players.size >= 2) {
          players[1] thread zombie_devgui_revive();
        }

        break;
      case #"player3_revive":
        players = getplayers();

        if(players.size >= 3) {
          players[2] thread zombie_devgui_revive();
        }

        break;
      case #"player4_revive":
        players = getplayers();

        if(players.size >= 4) {
          players[3] thread zombie_devgui_revive();
        }

        break;
      case #"player1_kill":
        players = getplayers();

        if(players.size >= 1) {
          players[0] thread zombie_devgui_kill();
        }

        break;
      case #"player2_kill":
        players = getplayers();

        if(players.size >= 2) {
          players[1] thread zombie_devgui_kill();
        }

        break;
      case #"player3_kill":
        players = getplayers();

        if(players.size >= 3) {
          players[2] thread zombie_devgui_kill();
        }

        break;
      case #"player4_kill":
        players = getplayers();

        if(players.size >= 4) {
          players[3] thread zombie_devgui_kill();
        }

        break;
      case #"hash_7f4d70c7ded8e94a":
        if(zm_utility::get_story() === 2) {
          array::random(getplayers()) giveweapon(getweapon(#"homunculus"));
        }

        array::thread_all(getplayers(), &function_8d799ebd);
        break;
      case #"hash_505efa1825e2cb99":
        players = getplayers();

        if(players.size >= 1) {
          players[0] thread function_8d799ebd();
        }

        break;
      case #"hash_15233852e3dc3500":
        players = getplayers();

        if(players.size >= 2) {
          players[1] thread function_8d799ebd();
        }

        break;
      case #"hash_5cb5edc4858d92f7":
        players = getplayers();

        if(players.size >= 3) {
          players[2] thread function_8d799ebd();
        }

        break;
      case #"hash_6d57ff86c541a5fe":
        players = getplayers();

        if(players.size >= 4) {
          players[3] thread function_8d799ebd();
        }

        break;
      case #"hash_2c320318aed843b2":
        array::thread_all(getplayers(), &zm_laststand::function_3d685b5f, 100);
        break;
      case #"hash_72783b08840a3ab7":
        players = getplayers();

        if(players.size >= 1) {
          players[0] thread zm_laststand::function_3d685b5f(100);
        }

        break;
      case #"hash_447712ef48d6ea0":
        players = getplayers();

        if(players.size >= 2) {
          players[1] thread zm_laststand::function_3d685b5f(100);
        }

        break;
      case #"hash_2a15f60adbba0cf5":
        players = getplayers();

        if(players.size >= 3) {
          players[2] thread zm_laststand::function_3d685b5f(100);
        }

        break;
      case #"hash_430eb4715f49a5fe":
        players = getplayers();

        if(players.size >= 4) {
          players[3] thread zm_laststand::function_3d685b5f(100);
        }

        break;
      case #"specialty_quickrevive":
        level.solo_lives_given = 0;
      case #"specialty_vultureaid":
      case #"specialty_showonradar":
      case #"specialty_fastmeleerecovery":
      case #"specialty_electriccherry":
      case #"specialty_deadshot":
      case #"specialty_widowswine":
      case #"specialty_doubletap2":
      case #"specialty_staminup":
      case #"specialty_additionalprimaryweapon":
      case #"specialty_phdflopper":
        zombie_devgui_give_perk(cmd);
        break;
      case #"remove_perks":
        zombie_devgui_take_perks(cmd);
        break;
      case #"lose_points_team":
      case #"insta_kill":
      case #"hero_weapon_power":
      case #"nuke":
      case #"pack_a_punch":
      case #"carpenter":
      case #"double_points":
      case #"tesla":
      case #"minigun":
      case #"extra_lives":
      case #"zmarcade_key":
      case #"bonfire_sale":
      case #"lose_perk":
      case #"bonus_points_player":
      case #"meat_stink":
      case #"empty_clip":
      case #"bonus_points_team":
      case #"full_ammo":
      case #"free_perk":
      case #"random_weapon":
      case #"fire_sale":
        zombie_devgui_give_powerup(cmd, 1);
        break;
      case #"next_bonfire_sale":
      case #"next_extra_lives":
      case #"next_bonus_points_player":
      case #"next_minigun":
      case #"next_lose_points_team":
      case #"next_empty_clip":
      case #"next_full_ammo":
      case #"next_random_weapon":
      case #"next_fire_sale":
      case #"next_pack_a_punch":
      case #"next_bonus_points_team":
      case #"next_lose_perk":
      case #"next_free_perk":
      case #"next_carpenter":
      case #"next_zmarcade_key":
      case #"next_tesla":
      case #"next_hero_weapon_power":
      case #"next_nuke":
      case #"next_meat_stink":
      case #"next_insta_kill":
      case #"next_double_points":
        zombie_devgui_give_powerup(getsubstr(cmd, 5), 0);
        break;
      case #"round":
        zombie_devgui_goto_round(getdvarint(#"scr_zombie_round", 0));
        break;
      case #"round_next":
        zombie_devgui_goto_round(level.round_number + 1);
        break;
      case #"round_prev":
        zombie_devgui_goto_round(level.round_number - 1);
        break;
      case #"chest_warp":
        array::thread_all(getplayers(), &function_4bb7eb36);
        break;
      case #"pap_warp":
        array::thread_all(getplayers(), &function_84f0a909);
        break;
      case #"chest_move":
        if(isDefined(level.chest_accessed)) {
          level notify(#"devgui_chest_end_monitor");
          level.var_401aaa92 = 1;
        }

        break;
      case #"chest_never_move":
        if(isDefined(level.chest_accessed)) {
          level.var_401aaa92 = 0;
          level thread zombie_devgui_chest_never_move();
        }

        break;
      case #"chest":
        if(isDefined(level.zombie_weapons[getweapon(getdvarstring(#"scr_force_weapon"))])) {}

        break;
      case #"give_claymores":
        array::thread_all(getplayers(), &zombie_devgui_give_placeable_mine, getweapon(#"claymore"));
        break;
      case #"give_bouncingbetties":
        array::thread_all(getplayers(), &zombie_devgui_give_placeable_mine, getweapon(#"bouncingbetty"));
        break;
      case #"give_frags":
        array::thread_all(getplayers(), &zombie_devgui_give_frags);
        break;
      case #"give_sticky":
        array::thread_all(getplayers(), &zombie_devgui_give_sticky);
        break;
      case #"give_monkey":
        array::thread_all(getplayers(), &zombie_devgui_give_monkey);
        break;
      case #"give_bhb":
        array::thread_all(getplayers(), &zombie_devgui_give_bhb);
        break;
      case #"give_quantum":
        array::thread_all(getplayers(), &zombie_devgui_give_qed);
        break;
      case #"give_dolls":
        array::thread_all(getplayers(), &zombie_devgui_give_dolls);
        break;
      case #"give_emp_bomb":
        array::thread_all(getplayers(), &zombie_devgui_give_emp_bomb);
        break;
      case #"dog_round":
        zombie_devgui_dog_round(getdvarint(#"scr_zombie_dogs", 0));
        break;
      case #"dog_round_skip":
        zombie_devgui_dog_round_skip();
        break;
      case #"print_variables":
        zombie_devgui_dump_zombie_vars();
        break;
      case #"pack_current_weapon":
        zombie_devgui_pack_current_weapon();
        break;
      case #"hash_f9c9f7dd75a4047":
        function_8c9f2dea();
        break;
      case #"hash_5605531ad17b5408":
        function_b7ef4b8();
        break;
      case #"hash_2dde14d5c2960aea":
        function_9b4d61fa();
        break;
      case #"hash_465e01a5b9f4f28e":
        function_cdc3d061();
        break;
      case #"repack_current_weapon":
        zombie_devgui_repack_current_weapon();
        break;
      case #"unpack_current_weapon":
        zombie_devgui_unpack_current_weapon();
        break;
      case #"hash_3c2b067b1510118c":
        function_c8949116();
        break;
      case #"hash_769c6d03952dd107":
        function_9d21f44b();
        break;
      case #"hash_68e9afed4aa9c0dd":
        function_e2a97bab();
        break;
      case #"hash_3f4888627ed06269":
        function_1a560cfc();
        break;
      case #"hash_73ecd8731ecdf6b0":
        function_c8ee84ba();
        break;
      case #"hash_49563ad3930e97e4":
        function_c83c6fa();
        break;
      case #"reopt_current_weapon":
        zombie_devgui_reopt_current_weapon();
        break;
      case #"weapon_take_all_fallback":
        zombie_devgui_take_weapons(1);
        break;
      case #"weapon_take_all":
        zombie_devgui_take_weapons(0);
        break;
      case #"weapon_take_current":
        zombie_devgui_take_weapon();
        break;
      case #"power_on":
        level flag::set("<dev string:xba2>");
        level clientfield::set("<dev string:xbad>", 1);
        power_trigs = getEntArray("<dev string:xbbf>", "<dev string:xbd1>");

        foreach(trig in power_trigs) {
          if(isDefined(trig.script_int)) {
            level flag::set("<dev string:xba2>" + trig.script_int);
            level clientfield::set("<dev string:xbad>", trig.script_int + 1);
          }
        }

        break;
      case #"power_off":
        level flag::clear("<dev string:xba2>");
        level clientfield::set("<dev string:xbde>", 0);
        power_trigs = getEntArray("<dev string:xbbf>", "<dev string:xbd1>");

        foreach(trig in power_trigs) {
          if(isDefined(trig.script_int)) {
            level flag::clear("<dev string:xba2>" + trig.script_int);
            level clientfield::set("<dev string:xbde>", trig.script_int);
          }
        }

        break;
      case #"zombie_dpad_none":
        array::thread_all(getplayers(), &zombie_devgui_dpad_none);
        break;
      case #"zombie_dpad_damage":
        array::thread_all(getplayers(), &zombie_devgui_dpad_damage);
        break;
      case #"zombie_dpad_kill":
        array::thread_all(getplayers(), &zombie_devgui_dpad_death);
        break;
      case #"zombie_dpad_drink":
        array::thread_all(getplayers(), &zombie_devgui_dpad_changeweapon);
        break;
      case #"director_easy":
        zombie_devgui_director_easy();
        break;
      case #"open_sesame":
        zombie_devgui_open_sesame();
        break;
      case #"allow_fog":
        zombie_devgui_allow_fog();
        break;
      case #"disable_kill_thread_toggle":
        zombie_devgui_disable_kill_thread_toggle();
        break;
      case #"check_kill_thread_every_frame_toggle":
        zombie_devgui_check_kill_thread_every_frame_toggle();
        break;
      case #"kill_thread_test_mode_toggle":
        zombie_devgui_kill_thread_test_mode_toggle();
        break;
      case #"zombie_failsafe_debug_flush":
        level notify(#"zombie_failsafe_debug_flush");
        break;
      case #"rat_navmesh":
        level thread rat::derriesezombiespawnnavmeshtest(0, 0);
        break;
      case #"spawn":
        devgui_zombie_spawn();
        break;
      case #"spawn_dummy":
        function_6f066ef();
        break;
      case #"spawn_near":
        function_7c17d00f();
        break;
      case #"spawn_all":
        devgui_all_spawn();
        break;
      case #"crawler":
        devgui_make_crawler();
        break;
      case #"toggle_show_spawn_locations":
        devgui_toggle_show_spawn_locations();
        break;
      case #"toggle_show_exterior_goals":
        devgui_toggle_show_exterior_goals();
        break;
      case #"draw_traversals":
        zombie_devgui_draw_traversals();
        break;
      case #"dump_traversals":
        function_bbeaa2da();
        break;
      case #"debug_hud":
        array::thread_all(getplayers(), &devgui_debug_hud);
        break;
      case #"reverse_carpenter":
        function_f12b8a34();
        break;
      case #"keyline_always":
        zombie_devgui_keyline_always();
        break;
      case #"hash_1e51dfcdbebdf936":
        robotsupportsovercover_manager_();
        break;
      case #"debug_counts":
        function_92523b12();
        break;
      case #"hash_604a84ea1690f781":
        thread function_3a5618f8();
        break;
      case #"hash_72a10718318ec7ff":
        function_21f1fbf1();
        break;
      case #"debug_navmesh_zone":
        function_e395a714();
        break;
      case #"hash_7fafc507d5398c0b":
        function_567ee21f();
        break;
      case #"hash_3ede275f03a4aa2b":
        function_1762ff96();
        break;
      case #"hash_74f6277a8a40911e":
        function_e5713258();
        break;
      case #"hash_3d647b897ae5dca6":
        function_f298dd5c();
        break;
      case #"hash_3f826ccc785705ba":
        function_26417ea7();
        break;
      case #"hash_683b625d2ace3726":
        function_fb88b423();
        break;
      case #"hash_3f9e70ff9f34194a":
        function_1b531660();
        break;
      case #"hash_4369eeba583c6d2d":
        function_61a7bb28();
        break;
      case #"hash_757311298fe0366e":
        function_184b9c6a();
        break;
      case #"hash_27a8af524430a8e1":
        function_986a2585();
        break;
      case #"hash_5995af694f312813":
        function_faf7abce();
        break;
      case 0:
        break;
      default:
        if(isDefined(level.custom_devgui)) {
          if(isarray(level.custom_devgui)) {
            foreach(devgui in level.custom_devgui) {
              b_result = [
                [devgui]
              ](cmd);

              if(isDefined(b_result) && b_result) {
                break;
              }
            }
          } else {
            [
              [level.custom_devgui]
            ](cmd);
          }
        }

        break;
    }

    setdvar(#"zombie_devgui", "<dev string:x38>");
    wait 0.5;
  }
}

add_custom_devgui_callback(callback) {
  if(isDefined(level.custom_devgui)) {
    if(!isarray(level.custom_devgui)) {
      cdgui = level.custom_devgui;
      level.custom_devgui = [];

      if(!isDefined(level.custom_devgui)) {
        level.custom_devgui = [];
      } else if(!isarray(level.custom_devgui)) {
        level.custom_devgui = array(level.custom_devgui);
      }

      level.custom_devgui[level.custom_devgui.size] = cdgui;
    }
  } else {
    level.custom_devgui = [];
  }

  if(!isDefined(level.custom_devgui)) {
    level.custom_devgui = [];
  } else if(!isarray(level.custom_devgui)) {
    level.custom_devgui = array(level.custom_devgui);
  }

  level.custom_devgui[level.custom_devgui.size] = callback;
}

devgui_all_spawn() {
  player = util::gethostplayer();
  bot::add_bots(3, player.team);
  wait 0.1;
  zombie_devgui_goto_round(8);
}

devgui_toggle_show_spawn_locations() {
  if(!isDefined(level.toggle_show_spawn_locations)) {
    level.toggle_show_spawn_locations = 1;
    return;
  }

  level.toggle_show_spawn_locations = !level.toggle_show_spawn_locations;
}

devgui_toggle_show_exterior_goals() {
  if(!isDefined(level.toggle_show_exterior_goals)) {
    level.toggle_show_exterior_goals = 1;
    return;
  }

  level.toggle_show_exterior_goals = !level.toggle_show_exterior_goals;
}

function_567ee21f() {
  level.var_377c39e4 = !(isDefined(level.var_377c39e4) && level.var_377c39e4);

  if(level.var_377c39e4) {
    foreach(player in level.players) {
      player setclientplayerpushamount(1);
    }

    foreach(ai in getaiteamarray(#"axis")) {
      ai pushplayer(1);
    }

    return;
  }

  foreach(player in level.players) {
    player setclientplayerpushamount(0);
  }

  foreach(ai in getaiteamarray(#"axis")) {
    ai pushplayer(0);
  }
}

devgui_zombie_spawn() {
  player = getplayers()[0];
  spawnername = undefined;
  spawnername = "<dev string:xbf1>";
  direction = player getplayerangles();
  direction_vec = anglesToForward(direction);
  eye = player getEye();
  scale = 8000;
  direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
  trace = bulletTrace(eye, eye + direction_vec, 0, undefined);
  guy = undefined;
  spawners = getEntArray(spawnername, "<dev string:xc02>");
  spawner = array::random(spawners);
  guy = zombie_utility::spawn_zombie(spawner);

  if(isDefined(guy)) {
    guy.script_string = "<dev string:x6e8>";
    wait 0.5;
    guy forceteleport(trace[#"position"], player.angles + (0, 180, 0));
  }

  return guy;
}

function_6f066ef() {
  player = getplayers()[0];
  forward = anglesToForward(player.angles);
  spawn = player.origin + forward * 25;
  guy = devgui_zombie_spawn();

  if(isDefined(guy)) {
    guy pathmode("<dev string:xc16>");
    guy forceteleport(spawn, player.angles);
  }
}

function_7c17d00f() {
  player = getplayers()[0];
  forward = anglesToForward(player.angles);
  spawn = player.origin + forward * 100;
  guy = devgui_zombie_spawn();

  if(isDefined(guy)) {
    guy forceteleport(spawn, player.angles + (0, 180, 0));
  }
}

devgui_make_crawler() {
  zombies = zombie_utility::get_round_enemy_array();

  foreach(zombie in zombies) {
    gib_style = [];
    gib_style[gib_style.size] = "<dev string:xc22>";
    gib_style[gib_style.size] = "<dev string:xc2c>";
    gib_style[gib_style.size] = "<dev string:xc38>";
    gib_style = zombie_death::randomize_array(gib_style);
    zombie.a.gib_ref = gib_style[0];
    zombie zombie_utility::function_df5afb5e(1);
    zombie allowedstances("<dev string:xc43>");
    zombie setphysparams(15, 0, 24);
    zombie allowpitchangle(1);
    zombie setpitchorient();
    health = zombie.health;
    health *= 0.1;
    zombie thread zombie_death::do_gib();
  }
}

zombie_devgui_open_sesame() {
  setdvar(#"zombie_unlock_all", 1);
  level flag::set("<dev string:xba2>");
  level clientfield::set("<dev string:xbad>", 1);
  power_trigs = getEntArray("<dev string:xbbf>", "<dev string:xbd1>");

  foreach(trig in power_trigs) {
    if(isDefined(trig.script_int)) {
      level flag::set("<dev string:xba2>" + trig.script_int);
      level clientfield::set("<dev string:xbad>", trig.script_int + 1);
    }
  }

  players = getplayers();
  array::thread_all(players, &zombie_devgui_give_money);
  zombie_doors = getEntArray("<dev string:xc4c>", "<dev string:xbd1>");

  for(i = 0; i < zombie_doors.size; i++) {
    if(!(isDefined(zombie_doors[i].has_been_opened) && zombie_doors[i].has_been_opened)) {
      zombie_doors[i] notify(#"trigger", {
        #activator: players[0]
      });
    }

    if(isDefined(zombie_doors[i].power_door_ignore_flag_wait) && zombie_doors[i].power_door_ignore_flag_wait) {
      zombie_doors[i] notify(#"power_on");
    }

    waitframe(1);
  }

  zombie_airlock_doors = getEntArray("<dev string:xc5a>", "<dev string:xbd1>");

  for(i = 0; i < zombie_airlock_doors.size; i++) {
    zombie_airlock_doors[i] notify(#"trigger", {
      #activator: players[0]
    });
    waitframe(1);
  }

  zombie_debris = getEntArray("<dev string:xc6f>", "<dev string:xbd1>");

  for(i = 0; i < zombie_debris.size; i++) {
    if(isDefined(zombie_debris[i])) {
      zombie_debris[i] notify(#"trigger", {
        #activator: players[0]
      });
    }

    waitframe(1);
  }

  level notify(#"open_sesame");
  wait 1;
  setdvar(#"zombie_unlock_all", 0);
}

any_player_in_noclip() {
  foreach(player in getplayers()) {
    if(player isinmovemode("<dev string:xc7f>", "<dev string:xc85>")) {
      return 1;
    }
  }

  return 0;
}

diable_fog_in_noclip() {
  level.fog_disabled_in_noclip = 1;
  level endon(#"allowfoginnoclip");
  level flag::wait_till("<dev string:xa6>");

  while(true) {
    while(!any_player_in_noclip()) {
      wait 1;
    }

    setdvar(#"scr_fog_disable", 1);
    setdvar(#"r_fog_disable", 1);

    if(isDefined(level.culldist)) {
      setculldist(0);
    }

    while(any_player_in_noclip()) {
      wait 1;
    }

    setdvar(#"scr_fog_disable", 0);
    setdvar(#"r_fog_disable", 0);

    if(isDefined(level.culldist)) {
      setculldist(level.culldist);
    }
  }
}

zombie_devgui_allow_fog() {
  if(isDefined(level.fog_disabled_in_noclip) && level.fog_disabled_in_noclip) {
    level notify(#"allowfoginnoclip");
    level.fog_disabled_in_noclip = 0;
    setdvar(#"scr_fog_disable", 0);
    setdvar(#"r_fog_disable", 0);
    return;
  }

  thread diable_fog_in_noclip();
}

zombie_devgui_give_money() {
  level.devcheater = 1;
  self zm_score::add_to_player_score(100000);
}

zombie_devgui_take_money() {
  assert(isDefined(self));
  assert(isplayer(self));
  assert(isalive(self));

  if(self.score > 100) {
    self zm_score::player_reduce_points("<dev string:xc8e>");
    return;
  }

  self zm_score::player_reduce_points("<dev string:xc9a>");
}

function_dc7312be() {
  assert(isDefined(self));
  assert(isplayer(self));
  assert(isalive(self));

  if(!self zm_utility::is_drinking()) {
    weapon = self getcurrentweapon();

    if(weapon != level.weaponnone && weapon != level.weaponzmfists && !(isDefined(weapon.isflourishweapon) && weapon.isflourishweapon)) {
      ammo = self getweaponammostock(weapon);
      max = weapon.maxammo;

      if(isDefined(max) && isDefined(ammo)) {
        if(ammo > max / 10) {
          self setweaponammostock(weapon, int(ammo / 2));
          return;
        }

        self setweaponammostock(weapon, 0);
      }
    }
  }
}

zombie_devgui_give_xp(amount) {
  assert(isDefined(self));
  assert(isplayer(self));
  assert(isalive(self));
  self addrankxp("<dev string:xca5>", self.currentweapon, undefined, undefined, 1, amount / 50);
}

zombie_devgui_turn_player(index) {
  players = getplayers();

  if(!isDefined(index) || index >= players.size) {
    player = players[0];
  } else {
    player = players[index];
  }

  assert(isDefined(player));
  assert(isplayer(player));
  assert(isalive(player));
  level.devcheater = 1;

  if(player hasperk(#"specialty_playeriszombie")) {
    println("<dev string:xcac>");
    player zm_turned::turn_to_human();
    return;
  }

  println("<dev string:xcc2>");
  player zm_turned::turn_to_zombie();
}

function_4bb7eb36() {
  entnum = self getentitynumber();
  chest = level.chests[level.chest_index];
  origin = chest.zbarrier.origin;
  forward = anglesToForward(chest.zbarrier.angles);
  right = anglestoright(chest.zbarrier.angles);
  var_21f5823e = vectortoangles(right);
  plorigin = origin - 48 * right;

  switch (entnum) {
    case 0:
      plorigin += 16 * right;
      break;
    case 1:
      plorigin += 16 * forward;
      break;
    case 2:
      plorigin -= 16 * right;
      break;
    case 3:
      plorigin -= 16 * forward;
      break;
  }

  self setorigin(plorigin);
  self setplayerangles(var_21f5823e);
}

function_84f0a909() {
  entnum = self getentitynumber();
  paps = getEntArray("<dev string:xcd9>", "<dev string:xbd1>");
  pap = paps[0];

  if(!isDefined(pap)) {
    return;
  }

  origin = pap.origin;
  forward = anglesToForward(pap.angles);
  right = anglestoright(pap.angles);
  var_21f5823e = vectortoangles(right * -1);
  plorigin = origin + 72 * right;

  switch (entnum) {
    case 0:
      plorigin -= 16 * right;
      break;
    case 1:
      plorigin += 16 * forward;
      break;
    case 2:
      plorigin += 16 * right;
      break;
    case 3:
      plorigin -= 16 * forward;
      break;
  }

  self setorigin(plorigin);
  self setplayerangles(var_21f5823e);
}

zombie_devgui_cool_jetgun() {
  if(isDefined(level.zm_devgui_jetgun_never_overheat)) {
    self thread[[level.zm_devgui_jetgun_never_overheat]]();
  }
}

zombie_devgui_preserve_turbines() {
  self endon(#"disconnect");
  self notify(#"preserve_turbines");
  self endon(#"preserve_turbines");

  if(!(isDefined(self.preserving_turbines) && self.preserving_turbines)) {
    self.preserving_turbines = 1;

    while(true) {
      self.turbine_health = 1200;
      wait 1;
    }
  }

  self.preserving_turbines = 0;
}

zombie_devgui_equipment_stays_healthy() {
  self endon(#"disconnect");
  self notify(#"preserve_equipment");
  self endon(#"preserve_equipment");

  if(!(isDefined(self.preserving_equipment) && self.preserving_equipment)) {
    self.preserving_equipment = 1;

    while(true) {
      self.equipment_damage = [];
      self.shielddamagetaken = 0;

      if(isDefined(level.destructible_equipment)) {
        foreach(equip in level.destructible_equipment) {
          if(isDefined(equip)) {
            equip.shielddamagetaken = 0;
            equip.damage = 0;
            equip.headchopper_kills = 0;
            equip.springpad_kills = 0;
            equip.subwoofer_kills = 0;
          }
        }
      }

      wait 0.1;
    }
  }

  self.preserving_equipment = 0;
}

zombie_devgui_disown_equipment() {
  self.deployed_equipment = [];
}

zombie_devgui_equipment_give(equipment) {
  assert(isDefined(self));
  assert(isplayer(self));
  assert(isalive(self));
  level.devcheater = 1;

  if(zm_equipment::is_included(equipment)) {
    self zm_equipment::buy(equipment);
  }
}

zombie_devgui_give_placeable_mine(weapon) {
  self endon(#"disconnect");
  self notify(#"give_planted_grenade_thread");
  self endon(#"give_planted_grenade_thread");
  assert(isDefined(self));
  assert(isplayer(self));
  assert(isalive(self));
  level.devcheater = 1;

  if(!zm_loadout::is_placeable_mine(weapon)) {
    return;
  }

  if(isDefined(self zm_loadout::get_player_placeable_mine())) {
    self takeweapon(self zm_loadout::get_player_placeable_mine());
  }

  self thread zm_placeable_mine::setup_for_player(weapon);

  while(true) {
    self givemaxammo(weapon);
    wait 1;
  }
}

zombie_devgui_give_claymores() {
  self endon(#"disconnect");
  self notify(#"give_planted_grenade_thread");
  self endon(#"give_planted_grenade_thread");
  assert(isDefined(self));
  assert(isplayer(self));
  assert(isalive(self));
  level.devcheater = 1;

  if(isDefined(self zm_loadout::get_player_placeable_mine())) {
    self takeweapon(self zm_loadout::get_player_placeable_mine());
  }

  wpn_type = zm_placeable_mine::get_first_available();

  if(wpn_type != level.weaponnone) {
    self thread zm_placeable_mine::setup_for_player(wpn_type);
  }

  while(true) {
    self givemaxammo(wpn_type);
    wait 1;
  }
}

zombie_devgui_give_lethal(weapon) {
  self endon(#"disconnect");
  self notify(#"give_lethal_grenade_thread");
  self endon(#"give_lethal_grenade_thread");
  assert(isDefined(self));
  assert(isplayer(self));
  assert(isalive(self));
  level.devcheater = 1;

  if(isDefined(self zm_loadout::get_player_lethal_grenade())) {
    self takeweapon(self zm_loadout::get_player_lethal_grenade());
  }

  self giveweapon(weapon);
  self zm_loadout::set_player_lethal_grenade(weapon);

  while(true) {
    self givemaxammo(weapon);
    wait 1;
  }
}

zombie_devgui_give_frags() {
  zombie_devgui_give_lethal(getweapon(#"eq_frag_grenade"));
}

zombie_devgui_give_sticky() {
  zombie_devgui_give_lethal(getweapon(#"sticky_grenade"));
}

zombie_devgui_give_monkey() {
  self endon(#"disconnect");
  self notify(#"give_tactical_grenade_thread");
  self endon(#"give_tactical_grenade_thread");
  assert(isDefined(self));
  assert(isplayer(self));
  assert(isalive(self));
  level.devcheater = 1;

  if(isDefined(self zm_loadout::get_player_tactical_grenade())) {
    self takeweapon(self zm_loadout::get_player_tactical_grenade());
  }

  if(isDefined(level.zombiemode_devgui_cymbal_monkey_give)) {
    self[[level.zombiemode_devgui_cymbal_monkey_give]]();

    while(true) {
      self givemaxammo(getweapon(#"cymbal_monkey"));
      wait 1;
    }
  }
}

zombie_devgui_give_bhb() {
  self endon(#"disconnect");
  self notify(#"give_tactical_grenade_thread");
  self endon(#"give_tactical_grenade_thread");
  assert(isDefined(self));
  assert(isplayer(self));
  assert(isalive(self));
  level.devcheater = 1;

  if(isDefined(self zm_loadout::get_player_tactical_grenade())) {
    self takeweapon(self zm_loadout::get_player_tactical_grenade());
  }

  if(isDefined(level.var_5076c574)) {
    self[[level.var_5076c574]]();

    while(true) {
      self givemaxammo(level.w_black_hole_bomb);
      wait 1;
    }
  }
}

zombie_devgui_give_qed() {
  self endon(#"disconnect");
  self notify(#"give_tactical_grenade_thread");
  self endon(#"give_tactical_grenade_thread");
  assert(isDefined(self));
  assert(isplayer(self));
  assert(isalive(self));
  level.devcheater = 1;

  if(isDefined(self zm_loadout::get_player_tactical_grenade())) {
    self takeweapon(self zm_loadout::get_player_tactical_grenade());
  }

  if(isDefined(level.var_3079bbd7)) {
    self[[level.var_3079bbd7]]();

    while(true) {
      self givemaxammo(level.w_quantum_bomb);
      wait 1;
    }
  }
}

zombie_devgui_give_dolls() {
  self endon(#"disconnect");
  self notify(#"give_tactical_grenade_thread");
  self endon(#"give_tactical_grenade_thread");
  assert(isDefined(self));
  assert(isplayer(self));
  assert(isalive(self));
  level.devcheater = 1;

  if(isDefined(self zm_loadout::get_player_tactical_grenade())) {
    self takeweapon(self zm_loadout::get_player_tactical_grenade());
  }

  if(isDefined(level.var_42cebfa6)) {
    self[[level.var_42cebfa6]]();

    while(true) {
      self givemaxammo(level.w_nesting_dolls);
      wait 1;
    }
  }
}

zombie_devgui_give_emp_bomb() {
  self endon(#"disconnect");
  self notify(#"give_tactical_grenade_thread");
  self endon(#"give_tactical_grenade_thread");
  assert(isDefined(self));
  assert(isplayer(self));
  assert(isalive(self));
  level.devcheater = 1;

  if(isDefined(self zm_loadout::get_player_tactical_grenade())) {
    self takeweapon(self zm_loadout::get_player_tactical_grenade());
  }

  if(isDefined(level.var_153af402)) {
    self[[level.var_153af402]]();

    while(true) {
      self givemaxammo(getweapon(#"emp_grenade"));
      wait 1;
    }
  }
}

zombie_devgui_invulnerable(playerindex, onoff) {
  players = getplayers();

  if(!isDefined(playerindex)) {
    for(i = 0; i < players.size; i++) {
      zombie_devgui_invulnerable(i, onoff);
    }

    return;
  }

  if(players.size > playerindex) {
    if(onoff) {
      players[playerindex] val::set(#"zombie_devgui", "<dev string:xb95>", 0);
      return;
    }

    players[playerindex] val::reset(#"zombie_devgui", "<dev string:xb95>");
  }
}

zombie_devgui_kill() {
  assert(isDefined(self));
  assert(isplayer(self));
  assert(isalive(self));
  self val::set(#"devgui_kill", "<dev string:xb95>", 1);
  death_from = (randomfloatrange(-20, 20), randomfloatrange(-20, 20), randomfloatrange(-20, 20));
  self dodamage(self.health + 666, self.origin + death_from);
}

zombie_devgui_toggle_ammo() {
  assert(isDefined(self));
  assert(isplayer(self));
  assert(isalive(self));
  self notify(#"devgui_toggle_ammo");
  self endon(#"devgui_toggle_ammo");
  self.ammo4evah = !(isDefined(self.ammo4evah) && self.ammo4evah);

  while(isDefined(self) && self.ammo4evah) {
    if(!self zm_utility::is_drinking()) {
      weapon = self getcurrentweapon();

      if(weapon != level.weaponnone && weapon != level.weaponzmfists && !(isDefined(weapon.isflourishweapon) && weapon.isflourishweapon)) {
        self setweaponoverheating(0, 0);
        max = weapon.maxammo;

        if(isDefined(max)) {
          self setweaponammostock(weapon, max);
        }

        if(isDefined(self zm_loadout::get_player_tactical_grenade())) {
          self givemaxammo(self zm_loadout::get_player_tactical_grenade());
        }

        if(isDefined(self zm_loadout::get_player_lethal_grenade())) {
          self givemaxammo(self zm_loadout::get_player_lethal_grenade());
        }
      }

      for(i = 0; i < 3; i++) {
        if(isDefined(self._gadgets_player[i]) && self hasweapon(self._gadgets_player[i])) {
          if(!self util::gadget_is_in_use(i) && self gadgetcharging(i)) {
            self gadgetpowerset(i, self._gadgets_player[i].gadget_powermax);
          }
        }
      }
    }

    wait 1;
  }
}

zombie_devgui_toggle_ignore() {
  assert(isDefined(self));
  assert(isplayer(self));
  assert(isalive(self));

  if(!isDefined(self.devgui_ignoreme)) {
    self.devgui_ignoreme = 0;
  }

  self.devgui_ignoreme = !self.devgui_ignoreme;

  if(self.devgui_ignoreme) {
    self val::set(#"devgui", "<dev string:xceb>");
  } else {
    self val::reset(#"devgui", "<dev string:xceb>");
  }

  if(self.ignoreme) {
    setdvar(#"ai_showfailedpaths", 0);
  }
}

zombie_devgui_revive() {
  assert(isDefined(self));
  assert(isplayer(self));

  if(laststand::player_is_in_laststand()) {
    self notify(#"auto_revive");
  }
}

zombie_devgui_give_health() {
  assert(isDefined(self));
  assert(isplayer(self));
  assert(isalive(self));
  self notify(#"devgui_health");
  self endon(#"devgui_health", #"disconnect", #"death");
  level.devcheater = 1;

  while(true) {
    self.maxhealth = 100000;
    self.health = 100000;
    self waittill(#"player_revived", #"perk_used", #"spawned_player");
    wait 2;
  }
}

zombie_devgui_low_health() {
  assert(isDefined(self));
  assert(isplayer(self));
  assert(isalive(self));
  self notify(#"devgui_health");
  self endon(#"devgui_health", #"disconnect", #"death");
  level.devcheater = 1;

  while(true) {
    self.maxhealth = 10;
    self.health = 10;
    self waittill(#"player_revived", #"perk_used", #"spawned_player");
    wait 2;
  }
}

zombie_devgui_give_perk(perk) {
  vending_machines = zm_perks::get_perk_machines();
  level.devcheater = 1;

  if(vending_machines.size < 1) {
    return;
  }

  foreach(player in getplayers()) {
    for(i = 0; i < vending_machines.size; i++) {
      if(vending_machines[i].script_noteworthy == perk) {
        vending_machines[i] notify(#"trigger", {
          #activator: player
        });
        break;
      }
    }

    wait 1;
  }
}

zombie_devgui_take_perks(cmd) {
  vending_machines = zm_perks::get_perk_machines();
  perks = [];

  for(i = 0; i < vending_machines.size; i++) {
    perk = vending_machines[i].script_noteworthy;

    if(isDefined(self.perk_purchased) && self.perk_purchased == perk) {
      continue;
    }

    perks[perks.size] = perk;
  }

  foreach(player in getplayers()) {
    foreach(perk in perks) {
      perk_str = perk + "<dev string:xcf6>";
      player notify(perk_str);
    }
  }
}

function_fd6c1b3c(cmd) {
  if(isDefined(level.perk_random_devgui_callback)) {
    self[[level.perk_random_devgui_callback]](cmd);
  }
}

function_82f7d6a1(cmd) {
  if(isDefined(level.perk_random_devgui_callback)) {
    self[[level.perk_random_devgui_callback]](cmd);
  }
}

function_68bd1e17(cmd) {
  if(isDefined(level.perk_random_devgui_callback)) {
    self[[level.perk_random_devgui_callback]](cmd);
  }
}

function_7565dd74(cmd) {
  if(isDefined(level.perk_random_devgui_callback)) {
    self[[level.perk_random_devgui_callback]](cmd);
  }
}

function_87979c2c(cmd) {
  if(isDefined(level.perk_random_devgui_callback)) {
    self[[level.perk_random_devgui_callback]](cmd);
  }
}

function_2cbcab61(cmd) {
  if(isDefined(level.perk_random_devgui_callback)) {
    self[[level.perk_random_devgui_callback]](cmd);
  }
}

function_18fc6a29(cmd) {
  if(isDefined(level.perk_random_devgui_callback)) {
    self[[level.perk_random_devgui_callback]](cmd);
  }
}

zombie_devgui_give_powerup(powerup_name, now, origin) {
  player = getplayers()[0];
  found = 0;
  level.devcheater = 1;

  if(isDefined(now) && !now) {
    for(i = 0; i < level.zombie_powerup_array.size; i++) {
      if(level.zombie_powerup_array[i] == powerup_name) {
        level.zombie_powerup_index = i;
        found = 1;
        break;
      }
    }

    if(!found) {
      return;
    }

    level.zombie_devgui_power = 1;
    zombie_utility::set_zombie_var(#"zombie_drop_item", 1);
    level.powerup_drop_count = 0;
    return;
  }

  direction = player getplayerangles();
  direction_vec = anglesToForward(direction);
  eye = player getEye();
  scale = 8000;
  direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
  trace = bulletTrace(eye, eye + direction_vec, 0, undefined);

  if(!isDefined(level.zombie_powerups) || !isDefined(level.zombie_powerups[powerup_name])) {
    return;
  }

  if(isDefined(origin)) {
    level thread zm_powerups::specific_powerup_drop(powerup_name, origin, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
    return;
  }

  level thread zm_powerups::specific_powerup_drop(powerup_name, trace[#"position"], undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
}

zombie_devgui_give_powerup_player(powerup_name, now) {
  player = self;
  found = 0;
  level.devcheater = 1;

  if(isDefined(now) && !now) {
    for(i = 0; i < level.zombie_powerup_array.size; i++) {
      if(level.zombie_powerup_array[i] == powerup_name) {
        level.zombie_powerup_index = i;
        found = 1;
        break;
      }
    }

    if(!found) {
      return;
    }

    level.zombie_devgui_power = 1;
    zombie_utility::set_zombie_var(#"zombie_drop_item", 1);
    level.powerup_drop_count = 0;
    return;
  }

  direction = player getplayerangles();
  direction_vec = anglesToForward(direction);
  eye = player getEye();
  scale = 8000;
  direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
  trace = bulletTrace(eye, eye + direction_vec, 0, undefined);
  level thread zm_powerups::specific_powerup_drop(powerup_name, trace[#"position"], undefined, undefined, player);
}

zombie_devgui_goto_round(target_round) {
  player = getplayers()[0];

  if(target_round < 1) {
    target_round = 1;
  }

  level.devcheater = 1;
  level.zombie_total = 0;
  level.zombie_health = zombie_utility::ai_calculate_health(zombie_utility::get_zombie_var(#"zombie_health_start"), target_round);
  zm_round_logic::set_round_number(target_round - 1);
  level notify(#"kill_round");
  wait 1;
  zombies = getaiteamarray(level.zombie_team);

  if(isDefined(zombies)) {
    for(i = 0; i < zombies.size; i++) {
      if(isDefined(zombies[i].ignore_devgui_death) && zombies[i].ignore_devgui_death) {
        continue;
      }

      zombies[i] dodamage(zombies[i].health + 666, zombies[i].origin);
    }
  }
}

zombie_devgui_monkey_round() {
  if(isDefined(level.var_141b0a3a)) {
    zombie_devgui_goto_round(level.var_141b0a3a);
  }
}

zombie_devgui_thief_round() {
  if(isDefined(level.var_3a35aed4)) {
    zombie_devgui_goto_round(level.var_3a35aed4);
  }
}

zombie_devgui_dog_round(num_dogs) {
  if(!isDefined(level.var_57c1626e) || !level.var_57c1626e) {
    return;
  }

  if(!isDefined(level.var_a3f67fc2) || !level.var_a3f67fc2) {
    return;
  }

  if(!isDefined(level.enemy_dog_spawns) || level.enemy_dog_spawns.size < 1) {
    return;
  }

  if(!level flag::get("<dev string:xcfe>")) {
    setdvar(#"force_dogs", num_dogs);
  }

  zombie_devgui_goto_round(level.round_number + 1);
}

zombie_devgui_dog_round_skip() {
  if(isDefined(level.next_dog_round)) {
    zombie_devgui_goto_round(level.next_dog_round);
  }
}

zombie_devgui_dump_zombie_vars() {
  if(!isDefined(level.zombie_vars)) {
    return;
  }

  if(level.zombie_vars.size > 0) {
    println("<dev string:xd0a>");
  } else {
    return;
  }

  var_names = getarraykeys(level.zombie_vars);

  for(i = 0; i < level.zombie_vars.size; i++) {
    key = var_names[i];
    println(key + "<dev string:xd27>" + zombie_utility::get_zombie_var(key));
  }

  println("<dev string:xd30>");
}

zombie_devgui_pack_current_weapon() {
  players = getplayers();
  reviver = players[0];
  level.devcheater = 1;

  for(i = 0; i < players.size; i++) {
    if(!players[i] laststand::player_is_in_laststand() && players[i].sessionstate !== "<dev string:xd53>") {
      weap = players[i] getcurrentweapon();
      weapon = players[i] get_upgrade(weap);

      if(isDefined(weapon)) {
        players[i] takeweapon(weap);
        weapon = players[i] zm_weapons::give_build_kit_weapon(weapon);
        players[i] thread aat::remove(weapon);
        players[i] zm_weapons::function_7c5dd4bd(weapon);
        players[i] switchtoweapon(weapon);
      }
    }
  }
}

zombie_devgui_repack_current_weapon() {
  players = getplayers();
  reviver = players[0];
  level.devcheater = 1;

  for(i = 0; i < players.size; i++) {
    if(!players[i] laststand::player_is_in_laststand() && players[i].sessionstate !== "<dev string:xd53>") {
      weap = players[i] getcurrentweapon();

      if(isDefined(level.aat_in_use) && level.aat_in_use && zm_weapons::weapon_supports_aat(weap)) {
        players[i] thread aat::acquire(weap);
        players[i] zm_pap_util::repack_weapon(weap, 4);
      }
    }
  }
}

zombie_devgui_unpack_current_weapon() {
  players = getplayers();
  reviver = players[0];
  level.devcheater = 1;

  for(i = 0; i < players.size; i++) {
    if(!players[i] laststand::player_is_in_laststand() && players[i].sessionstate !== "<dev string:xd53>") {
      weap = players[i] getcurrentweapon();
      weapon = zm_weapons::get_base_weapon(weap);
      players[i] takeweapon(weap);
      weapon = players[i] zm_weapons::give_build_kit_weapon(weapon);
      players[i] zm_weapons::function_7c5dd4bd(weapon);
      players[i] switchtoweapon(weapon);
    }
  }
}

function_55c6dedd(str_weapon, xp) {
  if(!isDefined(str_weapon) || !level.onlinegame) {
    return;
  }

  if(0 > xp) {
    xp = 0;
  }

  self stats::set_stat(#"ranked_item_stats", str_weapon, #"xp", xp);
}

function_335cdac(weapon) {
  gunlevels = [];
  table = popups::devgui_notif_getgunleveltablename();
  weapon_name = weapon.rootweapon.name;

  for(i = 0; i < 15; i++) {
    var_4a3def14 = tablelookup(table, 2, weapon_name, 0, i, 1);

    if("<dev string:x38>" == var_4a3def14) {
      break;
    }

    gunlevels[i] = int(var_4a3def14);
  }

  return gunlevels;
}

function_72e79f3b(weapon, var_56c1b8d) {
  xp = 0;
  gunlevels = function_335cdac(weapon);

  if(gunlevels.size) {
    xp = gunlevels[gunlevels.size - 1];

    if(var_56c1b8d < gunlevels.size) {
      xp = gunlevels[var_56c1b8d];
    }
  }

  return xp;
}

function_af7d932(weapon) {
  xp = 0;
  gunlevels = function_335cdac(weapon);

  if(gunlevels.size) {
    xp = gunlevels[gunlevels.size - 1];
  }

  return xp;
}

function_c8949116() {
  players = getplayers();
  level.devcheater = 1;

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(!player laststand::player_is_in_laststand()) {
      weapon = player getcurrentweapon();
      itemindex = getbaseweaponitemindex(weapon);
      var_56c1b8d = player getcurrentgunrank(itemindex);
      xp = function_72e79f3b(weapon, var_56c1b8d);
      player function_55c6dedd(weapon.name, xp);
    }
  }
}

function_9d21f44b() {
  players = getplayers();
  level.devcheater = 1;

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(!player laststand::player_is_in_laststand()) {
      weapon = player getcurrentweapon();
      itemindex = getbaseweaponitemindex(weapon);
      var_56c1b8d = player getcurrentgunrank(itemindex);
      xp = function_72e79f3b(weapon, var_56c1b8d);
      player function_55c6dedd(weapon.name, xp - 50);
    }
  }
}

function_e2a97bab() {
  players = getplayers();
  level.devcheater = 1;

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(!player laststand::player_is_in_laststand()) {
      weapon = player getcurrentweapon();
      itemindex = getbaseweaponitemindex(weapon);
      xp = function_af7d932(weapon);
      player function_55c6dedd(weapon.name, xp);
    }
  }
}

function_1a560cfc() {
  players = getplayers();
  level.devcheater = 1;

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(!player laststand::player_is_in_laststand()) {
      weapon = player getcurrentweapon();
      itemindex = getbaseweaponitemindex(weapon);
      player function_55c6dedd(weapon.name, 0);
    }
  }
}

function_c8ee84ba() {
  players = getplayers();
  level.devcheater = 1;
  a_weapons = enumerateweapons("<dev string:xd5f>");

  for(weapon_index = 0; weapon_index < a_weapons.size; weapon_index++) {
    weapon = a_weapons[weapon_index];
    itemindex = getbaseweaponitemindex(weapon);

    if(!itemindex) {
      continue;
    }

    xp = function_af7d932(weapon);

    for(i = 0; i < players.size; i++) {
      player = players[i];

      if(!player laststand::player_is_in_laststand()) {
        player function_55c6dedd(weapon.name, xp);
      }
    }
  }
}

function_c83c6fa() {
  players = getplayers();
  level.devcheater = 1;
  a_weapons = enumerateweapons("<dev string:xd5f>");

  for(weapon_index = 0; weapon_index < a_weapons.size; weapon_index++) {
    weapon = a_weapons[weapon_index];
    itemindex = getbaseweaponitemindex(weapon);

    if(!itemindex) {
      continue;
    }

    for(i = 0; i < players.size; i++) {
      player = players[i];

      if(!player laststand::player_is_in_laststand()) {
        player function_55c6dedd(weapon.name, 0);
      }
    }
  }
}

function_cbdab30d(xp) {
  if(self.pers[#"rankxp"] > xp) {
    self.pers[#"rank"] = 0;
    self setrank(0);
    self stats::set_stat(#"playerstatslist", #"rank", #"statvalue", 0);
  }

  self.pers[#"rankxp"] = xp;
  self rank::updaterank();
  self stats::set_stat(#"playerstatslist", #"rank", #"statvalue", self.pers[#"rank"]);
}

function_5c26ad27(var_56c1b8d) {
  return int(rank::getrankinfominxp(var_56c1b8d));
}

function_5da832fa() {
  xp = 0;
  xp = function_5c26ad27(level.ranktable.size - 1);
  return xp;
}

function_8c9f2dea() {
  players = getplayers();
  level.devcheater = 1;

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(!player laststand::player_is_in_laststand()) {
      var_56c1b8d = player rank::getrank();
      xp = function_5c26ad27(var_56c1b8d);
      player function_cbdab30d(xp);
    }
  }
}

function_b7ef4b8() {
  players = getplayers();
  level.devcheater = 1;

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(!player laststand::player_is_in_laststand()) {
      var_56c1b8d = player rank::getrank();
      xp = function_5c26ad27(var_56c1b8d);
      player function_cbdab30d(xp - 50);
    }
  }
}

function_9b4d61fa() {
  players = getplayers();
  level.devcheater = 1;

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(!player laststand::player_is_in_laststand()) {
      xp = function_5da832fa();
      player function_cbdab30d(xp);
    }
  }
}

function_cdc3d061() {
  players = getplayers();
  level.devcheater = 1;

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(!player laststand::player_is_in_laststand()) {
      player function_cbdab30d(0);
    }
  }
}

zombie_devgui_reopt_current_weapon() {
  players = getplayers();
  reviver = players[0];
  level.devcheater = 1;

  for(i = 0; i < players.size; i++) {
    if(!players[i] laststand::player_is_in_laststand()) {
      weapon = players[i] getcurrentweapon();

      if(isDefined(players[i].pack_a_punch_weapon_options)) {
        players[i].pack_a_punch_weapon_options[weapon] = undefined;
      }

      players[i] takeweapon(weapon);
      weapon = players[i] zm_weapons::give_build_kit_weapon(weapon);
      players[i] zm_weapons::function_7c5dd4bd(weapon);
      players[i] switchtoweapon(weapon);
    }
  }
}

zombie_devgui_take_weapon() {
  players = getplayers();
  reviver = players[0];
  level.devcheater = 1;

  for(i = 0; i < players.size; i++) {
    if(!players[i] laststand::player_is_in_laststand()) {
      players[i] takeweapon(players[i] getcurrentweapon());
      players[i] zm_weapons::switch_back_primary_weapon(undefined);
    }
  }
}

zombie_devgui_take_weapons(give_fallback) {
  players = getplayers();
  reviver = players[0];
  level.devcheater = 1;

  for(i = 0; i < players.size; i++) {
    if(!players[i] laststand::player_is_in_laststand()) {
      players[i] takeallweapons();

      if(give_fallback) {
        players[i] zm_weapons::give_fallback_weapon();
      }
    }
  }
}

get_upgrade(weapon) {
  if(isDefined(level.zombie_weapons[weapon]) && isDefined(level.zombie_weapons[weapon].upgrade_name)) {
    return zm_weapons::get_upgrade_weapon(weapon, 0);
  }

  return zm_weapons::get_upgrade_weapon(weapon, 1);
}

zombie_devgui_director_easy() {
  if(isDefined(level.var_e5cb87fe)) {
    [[level.var_e5cb87fe]]();
  }
}

zombie_devgui_chest_never_move() {
  level notify(#"devgui_chest_end_monitor");
  level endon(#"devgui_chest_end_monitor");

  for(;;) {
    level.chest_accessed = 0;
    wait 5;
  }
}

zombie_devgui_disable_kill_thread_toggle() {
  if(!(isDefined(level.disable_kill_thread) && level.disable_kill_thread)) {
    level.disable_kill_thread = 1;
    return;
  }

  level.disable_kill_thread = 0;
}

zombie_devgui_check_kill_thread_every_frame_toggle() {
  if(!(isDefined(level.check_kill_thread_every_frame) && level.check_kill_thread_every_frame)) {
    level.check_kill_thread_every_frame = 1;
    return;
  }

  level.check_kill_thread_every_frame = 0;
}

zombie_devgui_kill_thread_test_mode_toggle() {
  if(!(isDefined(level.kill_thread_test_mode) && level.kill_thread_test_mode)) {
    level.kill_thread_test_mode = 1;
    return;
  }

  level.kill_thread_test_mode = 0;
}

showonespawnpoint(spawn_point, color, notification, height, print) {
  if(!isDefined(height) || height <= 0) {
    height = util::get_player_height();
  }

  if(!isDefined(print)) {
    print = spawn_point.classname;
  }

  center = spawn_point.origin;
  forward = anglesToForward(spawn_point.angles);
  right = anglestoright(spawn_point.angles);
  forward = vectorscale(forward, 16);
  right = vectorscale(right, 16);
  a = center + forward - right;
  b = center + forward + right;
  c = center - forward + right;
  d = center - forward - right;
  thread lineuntilnotified(a, b, color, 0, notification);
  thread lineuntilnotified(b, c, color, 0, notification);
  thread lineuntilnotified(c, d, color, 0, notification);
  thread lineuntilnotified(d, a, color, 0, notification);
  thread lineuntilnotified(a, a + (0, 0, height), color, 0, notification);
  thread lineuntilnotified(b, b + (0, 0, height), color, 0, notification);
  thread lineuntilnotified(c, c + (0, 0, height), color, 0, notification);
  thread lineuntilnotified(d, d + (0, 0, height), color, 0, notification);
  a += (0, 0, height);
  b += (0, 0, height);
  c += (0, 0, height);
  d += (0, 0, height);
  thread lineuntilnotified(a, b, color, 0, notification);
  thread lineuntilnotified(b, c, color, 0, notification);
  thread lineuntilnotified(c, d, color, 0, notification);
  thread lineuntilnotified(d, a, color, 0, notification);
  center += (0, 0, height / 2);
  arrow_forward = anglesToForward(spawn_point.angles);
  arrowhead_forward = anglesToForward(spawn_point.angles);
  arrowhead_right = anglestoright(spawn_point.angles);
  arrow_forward = vectorscale(arrow_forward, 32);
  arrowhead_forward = vectorscale(arrowhead_forward, 24);
  arrowhead_right = vectorscale(arrowhead_right, 8);
  a = center + arrow_forward;
  b = center + arrowhead_forward - arrowhead_right;
  c = center + arrowhead_forward + arrowhead_right;
  thread lineuntilnotified(center, a, color, 0, notification);
  thread lineuntilnotified(a, b, color, 0, notification);
  thread lineuntilnotified(a, c, color, 0, notification);
  thread print3duntilnotified(spawn_point.origin + (0, 0, height), print, color, 1, 1, notification);
  return;
}

print3duntilnotified(origin, text, color, alpha, scale, notification) {
  level endon(notification);

  for(;;) {
    print3d(origin, text, color, alpha, scale);
    waitframe(1);
  }
}

lineuntilnotified(start, end, color, depthtest, notification) {
  level endon(notification);

  for(;;) {
    line(start, end, color, depthtest);
    waitframe(1);
  }
}

devgui_debug_hud() {
  if(isDefined(self zm_loadout::get_player_lethal_grenade())) {
    self givemaxammo(self zm_loadout::get_player_lethal_grenade());
  }

  wpn_type = zm_placeable_mine::get_first_available();

  if(wpn_type != level.weaponnone) {
    self thread zm_placeable_mine::setup_for_player(wpn_type);
  }

  if(isDefined(level.zombiemode_devgui_cymbal_monkey_give)) {
    if(isDefined(self zm_loadout::get_player_tactical_grenade())) {
      self takeweapon(self zm_loadout::get_player_tactical_grenade());
    }

    self[[level.zombiemode_devgui_cymbal_monkey_give]]();
  } else if(isDefined(self zm_loadout::get_player_tactical_grenade())) {
    self givemaxammo(self zm_loadout::get_player_tactical_grenade());
  }

  if(isDefined(level.zombie_include_equipment) && !isDefined(self zm_equipment::get_player_equipment())) {
    equipment = getarraykeys(level.zombie_include_equipment);

    if(isDefined(equipment[0])) {
      self zombie_devgui_equipment_give(equipment[0]);
    }
  }

  for(i = 0; i < 10; i++) {
    zombie_devgui_give_powerup("<dev string:xd68>", 1, self.origin);
    wait 0.25;
  }

  zombie_devgui_give_powerup("<dev string:xd74>", 1, self.origin);
  wait 0.25;
  zombie_devgui_give_powerup("<dev string:xd81>", 1, self.origin);
  wait 0.25;
  zombie_devgui_give_powerup("<dev string:xd91>", 1, self.origin);
  wait 0.25;
  zombie_devgui_give_powerup("<dev string:xd9d>", 1, self.origin);
  wait 0.25;
  zombie_devgui_give_powerup("<dev string:xda7>", 1, self.origin);
  wait 0.25;
}

zombie_devgui_draw_traversals() {
  if(!isDefined(level.toggle_draw_traversals)) {
    level.toggle_draw_traversals = 1;
    return;
  }

  level.toggle_draw_traversals = !level.toggle_draw_traversals;
}

zombie_devgui_keyline_always() {
  if(!isDefined(level.toggle_keyline_always)) {
    level.toggle_keyline_always = 1;
    return;
  }

  level.toggle_keyline_always = !level.toggle_keyline_always;
}

robotsupportsovercover_manager_() {
  if(level flag::get("<dev string:xdb6>")) {
    level flag::clear("<dev string:xdb6>");
    iprintln("<dev string:xdcc>");
    return;
  }

  level flag::set("<dev string:xdb6>");
  iprintln("<dev string:xde5>");
}

function_92523b12() {
  if(!isDefined(level.var_5171ee4a)) {
    level.var_5171ee4a = 1;
    return;
  }

  level.var_5171ee4a = !level.var_5171ee4a;
}

wait_for_zombie(crawler) {
  nodes = getallnodes();

  while(true) {
    ai = getactorarray();
    zombie = ai[0];

    if(isDefined(zombie)) {
      foreach(node in nodes) {
        if(node.type == #"begin" || node.type == #"end" || node.type == #"bad node") {
          if(isDefined(node.animscript)) {
            zombie setblackboardattribute("<dev string:xdfc>", "<dev string:xe06>");
            zombie setblackboardattribute("<dev string:xe0e>", node.animscript);
            table = "<dev string:xe20>";

            if(isDefined(crawler) && crawler) {
              table = "<dev string:xe32>";
            }

            if(isDefined(zombie.debug_traversal_ast)) {
              table = zombie.debug_traversal_ast;
            }

            anim_results = zombie astsearch(table);

            if(!isDefined(anim_results[#"animation"])) {
              if(isDefined(crawler) && crawler) {
                node.bad_crawler_traverse = 1;
              } else {
                node.bad_traverse = 1;
              }

              continue;
            }

            if(anim_results[#"animation"] == "<dev string:xe4c>") {
              teleport = 1;
            }
          }
        }
      }

      break;
    }

    wait 0.25;
  }
}

zombie_draw_traversals() {
  level thread wait_for_zombie();
  level thread wait_for_zombie(1);
  nodes = getallnodes();

  while(true) {
    if(isDefined(level.toggle_draw_traversals) && level.toggle_draw_traversals) {
      foreach(node in nodes) {
        if(isDefined(node.animscript)) {
          txt_color = (0, 0.8, 0.6);
          circle_color = (1, 1, 1);

          if(isDefined(node.bad_traverse) && node.bad_traverse) {
            txt_color = (1, 0, 0);
            circle_color = (1, 0, 0);
          }

          circle(node.origin, 16, circle_color);
          print3d(node.origin, node.animscript, txt_color, 1, 0.5);

          if(isDefined(node.bad_crawler_traverse) && node.bad_crawler_traverse) {
            print3d(node.origin + (0, 0, -12), "<dev string:xe67>", (1, 0, 0), 1, 0.5);
          }
        }
      }
    }

    waitframe(1);
  }
}

function_bbeaa2da() {
  nodes = getallnodes();
  var_43e9aabd = [];

  foreach(node in nodes) {
    if(isDefined(node.animscript) && node.animscript != "<dev string:x38>") {
      var_43e9aabd[node.animscript] = 1;
    }
  }

  var_cb16f0db = getarraykeys(var_43e9aabd);
  sortednames = array::sort_by_value(var_cb16f0db, 1);
  println("<dev string:xe81>");

  foreach(name in sortednames) {
    println("<dev string:xe9e>" + name);
  }

  println("<dev string:xead>");
}

function_e9b89aac() {
  while(true) {
    if(isDefined(level.zones) && (getdvarint(#"zombiemode_debug_zones", 0) || getdvarint(#"hash_756b3f2accaa1678", 0))) {
      foreach(zone in level.zones) {
        foreach(node in zone.nodes) {
          node_region = getnoderegion(node);
          var_747013f8 = node.targetname;

          if(isDefined(node_region)) {
            var_747013f8 = node_region + "<dev string:x65>" + node.targetname;
          }

          print3d(node.origin + (0, 0, 12), var_747013f8, (0, 1, 0), 1, 1);
        }
      }
    }

    waitframe(1);
  }
}

function_e395a714() {
  if(!isDefined(level.var_9a11ee76)) {
    level.var_9a11ee76 = 0;
  }

  foreach(player in level.players) {
    if(level.var_9a11ee76) {
      player notify(#"hash_d592b5d81b7b3a7");
      continue;
    }

    player thread function_fb482cad();
  }

  level.var_9a11ee76 = !level.var_9a11ee76;
}

function_2fcf8a4a(notifyhash) {
  if(isDefined(self.var_d35d1d3d)) {
    self.var_d35d1d3d destroy();
    self.var_d35d1d3d = undefined;
  }
}

function_fb482cad() {
  self notify(#"hash_d592b5d81b7b3a7");
  self endoncallback(&function_2fcf8a4a, #"hash_d592b5d81b7b3a7", #"disconnect");

  while(true) {
    if(!isDefined(self.var_d35d1d3d)) {
      self.var_d35d1d3d = newdebughudelem(self);
      self.var_d35d1d3d.alignx = "<dev string:xec8>";
      self.var_d35d1d3d.horzalign = "<dev string:xec8>";
      self.var_d35d1d3d.aligny = "<dev string:xecf>";
      self.var_d35d1d3d.vertalign = "<dev string:xed8>";
      self.var_d35d1d3d.color = (1, 1, 1);
      self.var_d35d1d3d.alpha = 1;
    }

    debug_text = "<dev string:x38>";

    if(isDefined(self.cached_zone_volume)) {
      debug_text = "<dev string:xede>";
    } else if(isDefined(self.var_3b65cdd7)) {
      debug_text = "<dev string:xf0e>";
    }

    self.var_d35d1d3d settext(debug_text);
    self waittill(#"zone_change");
  }
}

function_8817dd98() {
  while(true) {
    if(isDefined(level.var_5171ee4a) && level.var_5171ee4a) {
      if(!isDefined(level.var_fcfab54a)) {
        level.var_fcfab54a = newdebughudelem();
        level.var_fcfab54a.alignx = "<dev string:xec8>";
        level.var_fcfab54a.x = 2;
        level.var_fcfab54a.y = 160;
        level.var_fcfab54a.fontscale = 1.5;
        level.var_fcfab54a.color = (1, 1, 1);
      }

      zombie_count = zombie_utility::get_current_zombie_count();
      zombie_left = level.zombie_total;
      zombie_runners = 0;
      var_536fd32b = zombie_utility::get_zombie_array();

      foreach(ai_zombie in var_536fd32b) {
        if(ai_zombie.zombie_move_speed == "<dev string:xf3a>") {
          zombie_runners++;
        }
      }

      level.var_fcfab54a settext("<dev string:xf40>" + zombie_count + "<dev string:xf4a>" + zombie_left + "<dev string:xf58>" + zombie_runners);
    } else if(isDefined(level.var_fcfab54a)) {
      level.var_fcfab54a destroy();
    }

    waitframe(1);
  }
}

testscriptruntimeerrorassert() {
  wait 1;
  assert(0);
}

testscriptruntimeerror2() {
  myundefined = "<dev string:xf66>";

  if(myundefined == 1) {
    println("<dev string:xf6d>");
  }
}

testscriptruntimeerror1() {
  testscriptruntimeerror2();
}

testscriptruntimeerror() {
  wait 5;

  for(;;) {
    if(getdvarstring(#"scr_testscriptruntimeerror") != "<dev string:x3b>") {
      break;
    }

    wait 1;
  }

  myerror = getdvarstring(#"scr_testscriptruntimeerror");
  setdvar(#"scr_testscriptruntimeerror", "<dev string:x3b>");

  if(myerror == "<dev string:xf95>") {
    testscriptruntimeerrorassert();
  } else {
    testscriptruntimeerror1();
  }

  thread testscriptruntimeerror();
}

function_f12b8a34() {
  barriers = struct::get_array("<dev string:xf9e>", "<dev string:xbd1>");

  if(isDefined(level._additional_carpenter_nodes)) {
    barriers = arraycombine(barriers, level._additional_carpenter_nodes, 0, 0);
  }

  foreach(barrier in barriers) {
    if(isDefined(barrier.zbarrier)) {
      a_pieces = barrier.zbarrier getzbarrierpieceindicesinstate("<dev string:xfae>");

      if(isDefined(a_pieces)) {
        for(xx = 0; xx < a_pieces.size; xx++) {
          chunk = a_pieces[xx];
          barrier.zbarrier zbarrierpieceusedefaultmodel(chunk);
          barrier.zbarrier.chunk_health[chunk] = 0;
        }
      }

      for(x = 0; x < barrier.zbarrier getnumzbarrierpieces(); x++) {
        barrier.zbarrier setzbarrierpiecestate(x, "<dev string:xfae>");
        barrier.zbarrier showzbarrierpiece(x);
      }
    }

    if(isDefined(barrier.clip)) {
      barrier.clip triggerenable(1);
      barrier.clip disconnectpaths();
    } else {
      zm_blockers::blocker_connect_paths(barrier.neg_start, barrier.neg_end);
    }

    waitframe(1);
  }
}

function_29dcbd58() {
  var_a6f3b62c = getdvarint(#"hash_1e8ebf0a767981dd", 0);
  return array(array(var_a6f3b62c / 2, 30), array(var_a6f3b62c - 1, 20));
}

function_3a5618f8() {
  self endon(#"hash_63ae1cb168b8e0d7");
  setdvar(#"cg_drawscriptusage", 1);
  var_a6f3b62c = getdvarint(#"hash_1e8ebf0a767981dd", 0);
  timescale = getdvarint(#"hash_7438b7c847f3c0", 0);
  var_59ed21fc = function_29dcbd58();
  setdvar(#"runtime_time_scale", timescale);

  while(level.round_number < var_a6f3b62c) {
    foreach(round_info in var_59ed21fc) {
      if(level.round_number < round_info[0]) {
        wait round_info[1];
        break;
      }
    }

    ai_enemies = getaiteamarray(#"axis");

    foreach(ai in ai_enemies) {
      ai kill();
    }

    adddebugcommand("<dev string:xfb5>");
    wait 0.2;
  }

  setdvar(#"runtime_time_scale", 1);
}

function_21f1fbf1() {
  self notify(#"hash_63ae1cb168b8e0d7");
  setdvar(#"runtime_time_scale", 1);
}

function_1762ff96() {
  level.var_afb69372 = !(isDefined(self.var_afb69372) && self.var_afb69372);

  if(isDefined(level.var_afb69372) && level.var_afb69372) {
    level thread function_b7e34647();
    return;
  }

  level notify(#"hash_2876f101dd7375df");
}

function_b7e34647() {
  level endon(#"hash_2876f101dd7375df");

  while(true) {
    zombies = [];

    foreach(archetype in level.var_58903b1f) {
      ai = getaiarchetypearray(archetype, level.zombie_team);

      if(ai.size) {
        zombies = arraycombine(zombies, ai, 0, 0);
      }
    }

    foreach(zombie in zombies) {
      if(isDefined(zombie.need_closest_player) && zombie.need_closest_player) {
        record3dtext("<dev string:xfd0>", zombie.origin + (0, 0, 72), (1, 0, 0));
        continue;
      }

      record3dtext("<dev string:xfe6>", zombie.origin + (0, 0, 72), (0, 1, 0));

      if(isDefined(zombie.var_26f25576)) {
        record3dtext(gettime() - zombie.var_26f25576, zombie.origin + (0, 0, 54), (1, 1, 1));
      }
    }

    waitframe(1);
  }
}

function_1e285ac2() {
  adddebugcommand("<dev string:xffc>");
  adddebugcommand("<dev string:x104d>");
  adddebugcommand("<dev string:x1095>");
  adddebugcommand("<dev string:x10e1>");
  level thread function_c774d870();
}

function_c774d870() {
  for(;;) {
    wait 0.25;
    cmd = getdvarint(#"hash_5b8785c3d6383b3a", 0);

    if(isDefined(cmd) && cmd == 1) {
      iprintlnbold("<dev string:x1129>");
      zm::function_1442d44f();
      setdvar(#"hash_5b8785c3d6383b3a", 0);
    }

    cmd = getdvarstring(#"hash_2d9d21912cbffb75");

    if(isDefined(cmd) && cmd == 1) {
      iprintlnbold("<dev string:x1143>");
      level.gamedifficulty = 0;
      setdvar(#"hash_2d9d21912cbffb75", 0);
      setdvar(#"hash_5b8785c3d6383b3a", 1);
    }

    cmd = getdvarstring(#"hash_2b205a3ab882058c");

    if(isDefined(cmd) && cmd == 1) {
      iprintlnbold("<dev string:x114a>");
      level.gamedifficulty = 1;
      setdvar(#"hash_2b205a3ab882058c", 0);
      setdvar(#"hash_5b8785c3d6383b3a", 1);
    }

    cmd = getdvarstring(#"hash_393960bacf784966");

    if(isDefined(cmd) && cmd == 1) {
      iprintlnbold("<dev string:x1153>");
      level.gamedifficulty = 2;
      setdvar(#"hash_393960bacf784966", 0);
      setdvar(#"hash_5b8785c3d6383b3a", 1);
    }
  }
}

private function_255c7194() {
  player = getplayers()[0];
  queryresult = positionquery_source_navigation(player.origin, 256, 512, 128, 20);

  if(isDefined(queryresult) && queryresult.data.size > 0) {
    return queryresult.data[0];
  }

  return {
    #origin: player.origin
  };
}

private function_b4dcb9ce() {
  player = getplayers()[0];
  direction = player getplayerangles();
  direction_vec = anglesToForward(direction);
  eye = player getEye();
  scale = 8000;
  direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
  trace = bulletTrace(eye, eye + direction_vec, 0, player);
  return {
    #origin: trace[#"position"]
  };
}

spawn_archetype(spawner_name) {
  spawners = getspawnerarray(spawner_name, "<dev string:xc02>");
  spawn_point = function_b4dcb9ce();

  if(spawners.size == 0) {
    iprintln("<dev string:x115a>" + spawner_name + "<dev string:x1160>");
    return;
  }

  entity = spawners[0] spawnfromspawner(0, 1);

  if(isDefined(entity)) {
    entity forceteleport(spawn_point.origin);
  }
}

kill_archetype(archetype) {
  enemies = getaiarchetypearray(archetype);

  foreach(enemy in enemies) {
    if(isalive(enemy)) {
      enemy kill();
    }
  }
}

function_8d799ebd() {
  level.devcheater = 1;

  if(!self laststand::player_is_in_laststand()) {
    self zm_hero_weapon::function_1bb7f7b1(3);
    self zm_perks::function_869a50c0(4);
    var_5d62d3c8 = array::randomize(array(#"ar_accurate_t8", #"ar_fastfire_t8", #"ar_stealth_t8", #"ar_modular_t8", #"smg_capacity_t8", #"tr_powersemi_t8"));

    foreach(w_primary in self getweaponslistprimaries()) {
      self takeweapon(w_primary);
    }

    for(i = 0; i < zm_utility::get_player_weapon_limit(self); i++) {
      weapon = getweapon(var_5d62d3c8[i]);
      weapon = get_upgrade(weapon.rootweapon);
      weapon = self zm_weapons::give_build_kit_weapon(weapon);

      if(isDefined(level.aat_in_use) && level.aat_in_use && zm_weapons::weapon_supports_aat(weapon)) {
        self thread aat::acquire(weapon);
        self zm_pap_util::repack_weapon(weapon, 4);
      }
    }

    self switchtoweapon(weapon);
  }
}

function_f298dd5c() {

  if(!isDefined(level.var_9db63456)) {
    level.var_9db63456 = 0;
  }

    if(!isDefined(level.var_9db63456)) {
      level.var_9db63456 = 1;
    }

  level.var_9db63456 = !level.var_9db63456;
}

function_e5713258() {
  if(isDefined(level.var_33571ef1) && level.var_33571ef1) {
    level notify(#"hash_147174071dbfe31e");
  } else {
    level thread function_15ee6847();
  }

  level.var_33571ef1 = !(isDefined(level.var_33571ef1) && level.var_33571ef1);
}

function_15ee6847() {
  self notify("<dev string:x1169>");
  self endon("<dev string:x1169>");
  level endon(#"hash_147174071dbfe31e");

  while(true) {
    teststring = "<dev string:x38>";

    foreach(player in level.players) {
      teststring += "<dev string:x117b>" + player getentitynumber() + "<dev string:x1187>";

      if(player.sessionstate == "<dev string:xd53>") {
        teststring += "<dev string:x118c>";
        continue;
      }

      if(isDefined(self.hostmigrationcontrolsfrozen) && self.hostmigrationcontrolsfrozen) {
        teststring += "<dev string:x11a1>";
        continue;
      }

      if(player zm_player::in_life_brush()) {
        teststring += "<dev string:x11bf>";
        continue;
      }

      if(player zm_player::in_kill_brush()) {
        teststring += "<dev string:x11d3>";
        continue;
      }

      if(!player zm_player::in_enabled_playable_area()) {
        teststring += "<dev string:x11e7>";
        continue;
      }

      if(isDefined(level.player_out_of_playable_area_override) && !(isDefined(player[[level.player_out_of_playable_area_override]]()) && player[[level.player_out_of_playable_area_override]]())) {
        teststring += "<dev string:x121a>";
        continue;
      }

      teststring += "<dev string:x1252>";
    }

    debug2dtext((400, 100, 0), teststring, (1, 1, 0), undefined, (0, 0, 0), 0.75, 1, 1);
    waitframe(1);
  }
}

function_26417ea7() {
  level.var_565d6ce0 = !(isDefined(level.var_565d6ce0) && level.var_565d6ce0);
}

function_fb88b423() {
  zombies = getaiarray();

  foreach(zombie in zombies) {
    zombie zombie_utility::setup_zombie_knockdown(level.players[0]);
  }
}

init_debug_center_screen() {
  waitframe(1);
  setdvar(#"debug_center_screen", 0);
  level flag::wait_till("<dev string:xa6>");
  zero_idle_movement = 0;
  devgui_base = "<dev string:x126f>";
  adddebugcommand(devgui_base + "<dev string:x1285>" + "<dev string:x12b4>" + "<dev string:x12ca>");

  for(;;) {
    if(getdvarint(#"debug_center_screen", 0)) {
      if(!isDefined(level.center_screen_debug_hudelem_active) || level.center_screen_debug_hudelem_active == 0) {
        thread debug_center_screen();
        zero_idle_movement = getdvarint(#"zero_idle_movement", 0);

        if(zero_idle_movement == 0) {
          setdvar(#"zero_idle_movement", 1);
          zero_idle_movement = 1;
        }
      }
    } else {
      level notify(#"stop center screen debug");

      if(zero_idle_movement == 1) {
        setdvar(#"zero_idle_movement", 0);
        zero_idle_movement = 0;
      }
    }

    wait 0.5;
  }
}

debug_center_screen() {
  level.center_screen_debug_hudelem_active = 1;
  wait 0.1;
  level.center_screen_debug_hudelem1 = newdebughudelem(level.players[0]);
  level.center_screen_debug_hudelem1.alignx = "<dev string:x12d4>";
  level.center_screen_debug_hudelem1.aligny = "<dev string:xecf>";
  level.center_screen_debug_hudelem1.fontscale = 1;
  level.center_screen_debug_hudelem1.alpha = 0.5;
  level.center_screen_debug_hudelem1.x = 320 - 1;
  level.center_screen_debug_hudelem1.y = 240;
  level.center_screen_debug_hudelem1 setshader("<dev string:x12dd>", 1000, 1);
  level.center_screen_debug_hudelem2 = newdebughudelem(level.players[0]);
  level.center_screen_debug_hudelem2.alignx = "<dev string:x12d4>";
  level.center_screen_debug_hudelem2.aligny = "<dev string:xecf>";
  level.center_screen_debug_hudelem2.fontscale = 1;
  level.center_screen_debug_hudelem2.alpha = 0.5;
  level.center_screen_debug_hudelem2.x = 320 - 1;
  level.center_screen_debug_hudelem2.y = 240;
  level.center_screen_debug_hudelem2 setshader("<dev string:x12dd>", 1, 480);
  level waittill(#"stop center screen debug");
  level.center_screen_debug_hudelem1 destroy();
  level.center_screen_debug_hudelem2 destroy();
  level.center_screen_debug_hudelem_active = 0;
}

function_b5d522f8() {
  self notify("<dev string:x12e5>");
  self endon("<dev string:x12e5>");
  function_7c9dd642();
  setdvar(#"hash_46eec505e691414c", "<dev string:x38>");
  setdvar(#"hash_74f1952a0f93d08e", -1);

  while(true) {
    wait 0.1;
    var_9261da43 = getdvar(#"hash_46eec505e691414c", "<dev string:x38>");
    var_10acd4fa = getdvar(#"hash_74f1952a0f93d08e", -1);

    if(var_9261da43 == "<dev string:x38>" && var_10acd4fa == -1) {
      continue;
    }

    player = level.players[0];

    if(isplayer(player)) {
      if(var_9261da43 != "<dev string:x38>") {
        args = strtok(var_9261da43, "<dev string:x547>");
        level zm_ui_inventory::function_7df6bb60(args[0], int(args[1]), player);
      }

      if(var_10acd4fa != -1) {
        if(var_10acd4fa > 0) {
          player zm_ui_inventory::function_d8f1d200(#"hash_336cbe1bb6ff213");
        } else {
          player zm_ui_inventory::function_d8f1d200(#"");
        }
      }
    }

    setdvar(#"hash_46eec505e691414c", "<dev string:x38>");
    setdvar(#"hash_74f1952a0f93d08e", -1);
  }
}

function_7c9dd642() {
  while(!isDefined(level.var_a16c38d9)) {
    wait 0.1;
  }

  path = "<dev string:x12f8>";
  cmd = "<dev string:x1308>";
  keys = getarraykeys(level.var_a16c38d9);

  foreach(key in keys) {
    mapping = level.var_a16c38d9[key];
    num = pow(2, mapping.numbits);

    for(i = 0; i < num; i++) {
      cmdarg = function_9e72a96(key) + "<dev string:x547>" + i;
      util::add_devgui(path + function_9e72a96(key) + "<dev string:x132c>" + i, cmd + cmdarg);
    }
  }

  var_30a96cf9 = "<dev string:x1337>";
  cmd = "<dev string:x135b>";
  util::add_devgui(var_30a96cf9 + "<dev string:x137f>", cmd + 1);
  util::add_devgui(var_30a96cf9 + "<dev string:x1395>", cmd + 0);
}

bunker_entrance_zoned() {
  self notify("<dev string:x13ac>");
  self endon("<dev string:x13ac>");

  if(getdvarint(#"hash_4cebb1d3b0ee545a", 0) == 0) {
    setdvar(#"hash_4cebb1d3b0ee545a", 1);
  } else {
    setdvar(#"hash_4cebb1d3b0ee545a", 0);
    return;
  }

  a_s_key = struct::get_array(1, "<dev string:x13bf>");
  a_e_all = getentitiesinradius((0, 0, 0), 640000);
  a_e_key = [];

  foreach(ent in a_e_all) {
    if(isDefined(ent.var_61330f48) && ent.var_61330f48) {
      array::add(a_e_key, ent);
    }
  }

  a_key = arraycombine(a_s_key, a_e_key, 0, 0);

  while(getdvarint(#"hash_4cebb1d3b0ee545a", 0)) {
    foreach(key in a_key) {
      var_91d1913b = distance2d(level.players[0].origin, key.origin);
      n_radius = 0.015 * var_91d1913b;

      if(n_radius > 768) {
        n_radius = 768;
      }

      if(var_91d1913b > 64 && var_91d1913b < 2000) {
        v_color = (0, 0, 1);

        if(isDefined(key.targetname)) {
          str_type = function_9e72a96(key.targetname);
        } else if(isDefined(key.model)) {
          str_type = function_9e72a96(key.model);
        } else {
          str_type = key.origin;
        }

        sphere(key.origin, n_radius, v_color);
        print3d(key.origin + (0, 0, 24), str_type, v_color);
      }
    }

    waitframe(1);
  }
}

function_1b531660() {
  if(!isDefined(level.var_77e1430c)) {
    level.var_77e1430c = 0;
  }

  level.var_77e1430c = !level.var_77e1430c;

  if(level.var_77e1430c) {
    callback::on_ai_damage(&function_e7321799);
    return;
  }

  callback::remove_on_ai_damage(&function_e7321799);
}

function_e7321799(params) {
  damage = params.idamage;
  location = params.vpoint;
  target = self;
  smeansofdeath = params.smeansofdeath;

  if(smeansofdeath == "<dev string:x13cc>" || smeansofdeath == "<dev string:x13da>") {
    location = self.origin + (0, 0, 60);
  }

  if(damage) {
    thread function_2cde0af9("<dev string:x547>" + damage, (1, 1, 1), location, (randomfloatrange(-1, 1), randomfloatrange(-1, 1), 2), 30);
  }
}

function_2cde0af9(text, color, start, velocity, frames) {
  location = start;
  alpha = 1;

  for(i = 0; i < frames; i++) {
    print3d(location, text, color, alpha, 0.6, 1);
    location += velocity;
    alpha -= 1 / frames * 2;
    waitframe(1);
  }
}

function_61a7bb28() {
  foreach(e_player in getplayers()) {
    if(!e_player laststand::player_is_in_laststand() && e_player.sessionstate !== "<dev string:xd53>") {
      weapon = e_player getcurrentweapon();

      if(weaponhasattachment(weapon, "<dev string:x13ef>")) {
        continue;
      }

      weapon = getweapon(weapon.name, arraycombine(weapon.attachments, array("<dev string:x13ef>"), 0, 0));
      e_player function_2d4d7fd9(weapon);
      e_player function_f45a88df(weapon);
    }
  }
}

function_986a2585() {
  foreach(e_player in getplayers()) {
    if(!e_player laststand::player_is_in_laststand() && e_player.sessionstate !== "<dev string:xd53>") {
      weapon = e_player getcurrentweapon();

      if(!weaponhasattachment(weapon, "<dev string:x13ef>")) {
        continue;
      }

      e_player function_3fb8b14(weapon, 1);
    }
  }
}

function_184b9c6a() {
  foreach(e_player in getplayers()) {
    if(!e_player laststand::player_is_in_laststand() && e_player.sessionstate !== "<dev string:xd53>") {
      weapon = e_player getcurrentweapon();

      if(!weaponhasattachment(weapon, "<dev string:x13ef>")) {
        continue;
      }

      e_player function_f45a88df(weapon);
    }
  }
}

function_f45a88df(weapon) {
  var_fd8cbdfd = self function_ddd45573(weapon);

  if(!isDefined(var_fd8cbdfd) || var_fd8cbdfd == 0) {
    var_fd8cbdfd = 1;
  } else {
    var_fd8cbdfd++;
  }

  self function_3fb8b14(weapon, var_fd8cbdfd);
}

function_faf7abce() {
  foreach(e_player in getplayers()) {
    if(!e_player laststand::player_is_in_laststand() && e_player.sessionstate !== "<dev string:xd53>") {
      weapon = e_player getcurrentweapon();
      var_1c3b8b11 = e_player function_b1298bfb(weapon);

      if(!isDefined(var_1c3b8b11) || var_1c3b8b11 == 0) {
        var_1c3b8b11 = 1;
      } else {
        var_1c3b8b11++;
      }

      e_player function_a85d2581(weapon, var_1c3b8b11);
    }
  }
}


/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_devgui.gsc
***********************************************/

#using script_18077945bb84ede7;
#using script_36f4be19da8eb6d0;
#using script_3751b21462a54a7d;
#using script_4ccfb58a9443a60b;
#using script_62caa307a394c18c;
#using script_6fc2be37feeb317b;
#using script_7a5293d92c61c788;
#using script_7f6cd71c43c45c57;
#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_shared;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\dev_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\item_inventory;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\popups_shared;
#using scripts\core_common\rank_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\rat;
#using scripts\zm_common\util;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_behavior;
#using scripts\zm_common\zm_blockers;
#using scripts\zm_common\zm_characters;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_melee_weapon;
#using scripts\zm_common\zm_pack_a_punch_util;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_placeable_mine;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_turned;
#using scripts\zm_common\zm_ui_inventory;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#namespace zm_devgui;

function private autoexec __init__system__() {
  system::register(#"zm_devqui", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  setDvar(#"zombie_devgui", "<dev string:x38>");
  setDvar(#"scr_force_weapon", "<dev string:x38>");
  util::init_dvar(#"scr_zombie_spawn_in_view", 0, &function_f1be4492);
  level.devgui_add_weapon = &devgui_add_weapon;
  level.devgui_add_ability = &devgui_add_ability;

  if(!zm_utility::is_survival()) {
    level.var_37778628 = &zombie_devgui_goto_round;
  }

  level thread zombie_devgui_think();
  thread zombie_weapon_devgui_think();
  thread function_3b534f9c();
  thread function_1e285ac2();
  thread devgui_zombie_healthbar();
  thread dev::devgui_test_chart_think();

  if(!isDefined(getDvar(#"scr_testscriptruntimeerror"))) {
    setDvar(#"scr_testscriptruntimeerror", "<dev string:x3c>");
  }

  level thread dev::body_customization_devgui(0);
  thread testscriptruntimeerror();
  callback::on_connect(&player_on_connect);
  add_custom_devgui_callback(&function_2f5772bf);
  spawner::add_ai_spawn_function(&function_a4eebdf3);
  thread init_debug_center_screen();
}

function private postinit() {
  level thread zombie_devgui_player_commands();
  level thread zombie_devgui_validation_commands();
  level thread function_8817dd98();
  level thread function_e9b89aac();
  level thread function_38184bf8();
  level thread function_b5d522f8();
  level thread function_300dfb68();
  level thread function_4eaed09d();
  level thread namespace_42457a0::function_5dbd7c2a();
}

function function_a4eebdf3() {
  if(self.targetname !== "<dev string:x44>") {
    return;
  }

  if(self.archetype === # "zombie") {
    self.custom_location = &function_9960be00;
    self.start_inert = 1;
    var_c5de9c31 = 0;

    if(isDefined(self.spawn_funcs)) {
      foreach(pair in self.spawn_funcs) {
        if(pair[# "function"] === &zm_behavior::function_d63f6426) {
          var_c5de9c31 = 1;
          break;
        }
      }
    }

    self endon(#"death");

    if(!var_c5de9c31) {
      waittillframeend();
      self zm_behavior::function_d63f6426();
    }
  }

  if(is_true(level.var_2b46c827)) {
    waittillframeend();
    self setentitypaused(1);
    level waittill(#"hash_39e4c9a17bf97f7d");
    self setentitypaused(0);
  }
}

function zombie_devgui_player_commands() {}

function function_358c899d() {
  test_scores = array(1, 10, 50, 100, 3500, 9999);
  i = 0;

  foreach(score in test_scores) {
    adddebugcommand("<dev string:x54>" + score + "<dev string:x78>" + i + "<dev string:x7d>" + score + "<dev string:xa4>");
    i++;
  }
}

function function_5ac8947e() {
  setDvar(#"zombie_devgui_hud", "<dev string:x38>");

  while(true) {
    cmd = getDvar(#"zombie_devgui_hud", "<dev string:x38>");

    if(cmd == "<dev string:x38>") {
      wait 0.1;
      continue;
    }

    if(strstartswith(cmd, "<dev string:xab>")) {
      str = strreplace(cmd, "<dev string:xab>", "<dev string:x38>");
      score = int(str);
      players = getplayers();

      foreach(player in players) {
        if(isPlayer(player)) {
          player luinotifyevent(#"score_event", 2, #"hash_60899927812586a1", score);
          break;
        }
      }
    }

    setDvar(#"zombie_devgui_hud", "<dev string:x38>");
  }
}

function player_on_connect() {
  level flag::wait_till("<dev string:xbd>");
  wait 1;

  if(isDefined(self)) {
    zombie_devgui_player_menu(self);
  }
}

function zombie_devgui_player_menu_clear(playername) {
  rootclear = "<dev string:xd9>" + playername + "<dev string:xf9>";
  adddebugcommand(rootclear);
}

function function_c7dd7a17(archetype, subarchetype) {
  if(!isDefined(subarchetype)) {
    subarchetype = "<dev string:x38>";
  }

  displayname = archetype;

  if(isDefined(subarchetype) && subarchetype != "<dev string:x38>") {
    displayname = displayname + "<dev string:x100>" + subarchetype;
  }

  adddebugcommand("<dev string:x105>" + displayname + "<dev string:x12e>" + archetype + "<dev string:x100>" + subarchetype + "<dev string:x159>");
}

function private function_2f5772bf(cmd) {
  if(strstartswith(cmd, "<dev string:x15f>")) {
    player = level.players[0];
    direction = player getplayerangles();
    direction_vec = anglesToForward(direction);
    eye = player getEye();
    direction_vec = (direction_vec[0] * 8000, direction_vec[1] * 8000, direction_vec[2] * 8000);
    trace = bulletTrace(eye, eye + direction_vec, 0, undefined);
    ai = undefined;
    ai_info = strreplace(cmd, "<dev string:x176>", "<dev string:x38>");
    ai_info = strtok(ai_info, "<dev string:x100>");
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
      iprintln("<dev string:x18e>" + aitype);
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
        ai.origin = trace[# "position"];
        ai function_a57c34b7(trace[# "position"]);
        return;
      }

      ai forceteleport(trace[# "position"], player.angles + (0, 180, 0));
    }
  }
}

function zombie_devgui_player_menu(player) {
  zombie_devgui_player_menu_clear(player.name);
  ip1 = player getentitynumber() + 1;
  adddebugcommand("<dev string:x1ad>" + player.name + "<dev string:x1ca>" + ip1 + "<dev string:x1d1>" + ip1 + "<dev string:x1fd>");
  adddebugcommand("<dev string:x1ad>" + player.name + "<dev string:x1ca>" + ip1 + "<dev string:x20a>" + ip1 + "<dev string:x238>");
  adddebugcommand("<dev string:x1ad>" + player.name + "<dev string:x1ca>" + ip1 + "<dev string:x248>" + ip1 + "<dev string:x274>");
  adddebugcommand("<dev string:x1ad>" + player.name + "<dev string:x1ca>" + ip1 + "<dev string:x285>" + ip1 + "<dev string:x2b5>");
  adddebugcommand("<dev string:x1ad>" + player.name + "<dev string:x1ca>" + ip1 + "<dev string:x2c3>" + ip1 + "<dev string:x2f0>");
  adddebugcommand("<dev string:x1ad>" + player.name + "<dev string:x1ca>" + ip1 + "<dev string:x2fe>" + ip1 + "<dev string:x32b>");
  adddebugcommand("<dev string:x1ad>" + player.name + "<dev string:x1ca>" + ip1 + "<dev string:x33c>" + ip1 + "<dev string:x362>");
  adddebugcommand("<dev string:x1ad>" + player.name + "<dev string:x1ca>" + ip1 + "<dev string:x36e>" + ip1 + "<dev string:x396>");
  adddebugcommand("<dev string:x1ad>" + player.name + "<dev string:x1ca>" + ip1 + "<dev string:x3a4>" + ip1 + "<dev string:x3d0>");
  adddebugcommand("<dev string:x1ad>" + player.name + "<dev string:x1ca>" + ip1 + "<dev string:x3e2>" + ip1 + "<dev string:x412>");
  adddebugcommand("<dev string:x1ad>" + player.name + "<dev string:x1ca>" + ip1 + "<dev string:x427>" + ip1 + "<dev string:x45a>");
  adddebugcommand("<dev string:x1ad>" + player.name + "<dev string:x1ca>" + ip1 + "<dev string:x472>" + ip1 + "<dev string:x49e>");
  adddebugcommand("<dev string:x1ad>" + player.name + "<dev string:x1ca>" + ip1 + "<dev string:x4ae>" + ip1 + "<dev string:x4dc>");
  adddebugcommand("<dev string:x1ad>" + player.name + "<dev string:x1ca>" + ip1 + "<dev string:x4ed>" + ip1 + "<dev string:x51c>");
  adddebugcommand("<dev string:x1ad>" + player.name + "<dev string:x1ca>" + ip1 + "<dev string:x52b>" + ip1 + "<dev string:x55b>");

  if(isDefined(level.var_e2c54606)) {
    level thread[[level.var_e2c54606]](player, ip1);
  }

  self thread zombie_devgui_player_menu_clear_on_disconnect(player);
}

function zombie_devgui_player_menu_clear_on_disconnect(player) {
  playername = player.name;
  player waittill(#"disconnect");
  zombie_devgui_player_menu_clear(playername);
}

function function_38184bf8() {
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
        print3d(print_origin + (0, 0, -10), "<dev string:x56b>" + zone_path.cost, color, 1, 0.5);

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

function function_300dfb68() {
  setDvar(#"hash_45632f9301da0179", "<dev string:x38>");
  adddebugcommand("<dev string:x574>");

  while(true) {
    cmd = getdvarstring(#"hash_45632f9301da0179");

    if(cmd != "<dev string:x38>") {
      switch (cmd) {
        case # "teleport":
          function_1ecbcf72();
          break;
      }

      setDvar(#"hash_45632f9301da0179", "<dev string:x38>");
    }

    util::wait_network_frame();
  }
}

function function_4eaed09d() {
  setDvar(#"hash_6850d2ee27e63e98", "<dev string:x38>");
  setDvar(#"hash_72c3f824ab058229", 50);
  adddebugcommand("<dev string:x5ba>");

  while(true) {
    cmd = getdvarstring(#"hash_6850d2ee27e63e98");

    if(cmd != "<dev string:x38>") {
      switch (cmd) {
        case # "test_float":
          test_float();
          break;
      }

      setDvar(#"hash_6850d2ee27e63e98", "<dev string:x38>");
    }

    util::wait_network_frame();
  }
}

function test_float() {
  a_ai_zombies = getaispeciesarray("<dev string:x60a>", "<dev string:x60a>");

  foreach(ai in a_ai_zombies) {
    ai.var_2e38a54d = getdvarint(#"hash_72c3f824ab058229", 50);
  }
}

function function_1ecbcf72() {
  params = {
    #is_dummy: 1
  };
  rat::function_303319e9(params);
}

function zombie_devgui_validation_commands() {
  setDvar(#"validation_devgui_command", "<dev string:x38>");
  adddebugcommand("<dev string:x611>");
  adddebugcommand("<dev string:x65c>");
  adddebugcommand("<dev string:x6ac>");
  adddebugcommand("<dev string:x6fe>");

  while(true) {
    cmd = getdvarstring(#"validation_devgui_command");

    if(cmd != "<dev string:x38>") {
      switch (cmd) {
        case # "structs":
          thread bunker_entrance_zoned();
          break;
        case # "spawner":
          zombie_spawner_validation();
          break;
        case # "zone_adj":
          if(!isDefined(level.toggle_zone_adjacencies_validation)) {
            level.toggle_zone_adjacencies_validation = 1;
          } else {
            level.toggle_zone_adjacencies_validation = !level.toggle_zone_adjacencies_validation;
          }

          thread zone_adjacencies_validation();
          break;
        case # "zone_paths":
          break;
        case # "pathing":
          thread zombie_pathing_validation();
        default:
          break;
      }

      setDvar(#"validation_devgui_command", "<dev string:x38>");
    }

    util::wait_network_frame();
  }
}

function function_edce7be0() {
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

function function_6758ede4(zone) {
  if(isDefined(zone.nodes)) {
    foreach(node in zone.nodes) {
      node_region = getnoderegion(node);

      if(!isDefined(node_region)) {
        thread drawvalidation(node.origin, undefined, undefined, undefined, node);
      }
    }
  }
}

function function_995340b7(zone, var_87f65b00) {
  if(!isDefined(zone.a_loc_types[# "wait_location"]) || zone.a_loc_types[# "wait_location"].size <= 0) {
    if(is_true(var_87f65b00)) {
      level.validation_errors_count++;

      if(isDefined(zone.nodes) && zone.nodes.size > 0) {
        origin = zone.nodes[0].origin + (0, 0, 32);
      } else {
        origin = zone.volumes[0].origin;
      }

      thread drawvalidation(origin, zone.name);
      println("<dev string:x756>" + zone.name);
      iprintlnbold("<dev string:x756>" + zone.name);
    }

    return 0;
  }

  return 1;
}

function function_1f0bc660(zone, enemy, spawner, spawn_location) {
  if(!isDefined(zone.a_loc_types[spawn_location])) {
    return enemy;
  }

  foreach(spawn_point in zone.a_loc_types[spawn_location]) {
    if(!isDefined(enemy)) {
      enemy = zombie_utility::spawn_zombie(spawner, spawner.targetname, spawn_point);
    }

    spawn_point_origin = spawn_point.origin;

    if(isDefined(spawn_point.script_string) && spawn_point.script_string != "<dev string:x77e>") {
      spawn_point_origin = enemy validate_to_board(spawn_point, spawn_point_origin);
    }

    if(!ispointonnavmesh(spawn_point_origin, enemy getpathfindingradius() + 1)) {
      new_spawn_point_origin = getclosestpointonnavmesh(spawn_point_origin, 64, enemy getpathfindingradius() + 1);
    } else {
      new_spawn_point_origin = spawn_point_origin;
    }

    var_d37fcf94 = isDefined(spawn_point.script_noteworthy) && !issubstr(spawn_point.script_noteworthy, "<dev string:x78c>");

    if(is_true(var_d37fcf94) && !isDefined(new_spawn_point_origin) && !is_true(spawn_point.var_f0596bbb)) {
      level.validation_errors_count++;
      thread drawvalidation(spawn_point_origin);
      println("<dev string:x7a4>" + spawn_point_origin);
      iprintlnbold("<dev string:x7e0>" + spawn_point_origin);
      spawn_point.var_f0596bbb = 1;
    }

    if(!isDefined(new_spawn_point_origin)) {
      continue;
    }

    ispath = enemy validate_to_wait_point(zone, new_spawn_point_origin, spawn_point);
  }

  return enemy;
}

function zombie_spawner_validation() {
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
        iprintlnbold("<dev string:x81d>" + spawner.aitype);
      }
    }

    println("<dev string:x84b>" + level.validation_errors_count);
    iprintlnbold("<dev string:x84b>" + level.validation_errors_count);
    level.validation_errors_count = undefined;
    return;
  }

  level.toggle_spawner_validation = !level.toggle_spawner_validation;
}

function validate_to_board(spawn_point, spawn_point_origin_backup) {
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
        println("<dev string:x877>" + function_9e72a96(self.archetype) + "<dev string:x888>" + spawn_point_origin_backup + "<dev string:x8aa>" + spawn_point.targetname);
        iprintlnbold("<dev string:x877>" + function_9e72a96(self.archetype) + "<dev string:x888>" + spawn_point_origin_backup + "<dev string:x8aa>" + spawn_point.targetname);
      } else {
        println("<dev string:x8c6>" + spawn_point_origin_backup + "<dev string:x8aa>" + spawn_point.targetname);
        iprintlnbold("<dev string:x8c6>" + spawn_point_origin_backup + "<dev string:x8aa>" + spawn_point.targetname);
      }
    }

    nodeforward = anglesToForward(node.angles);
    nodeforward = vectornormalize(nodeforward);
    spawn_point_origin = node.origin + nodeforward * 100;
    return spawn_point_origin;
  }

  return spawn_point_origin_backup;
}

function validate_to_wait_point(zone, new_spawn_point_origin, spawn_point) {
  foreach(loc in zone.a_loc_types[# "wait_location"]) {
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
            println("<dev string:x8fb>" + function_9e72a96(self.archetype) + "<dev string:x888>" + new_spawn_point_origin + "<dev string:x90b>" + spawn_point.targetname);
            iprintlnbold("<dev string:x877>" + function_9e72a96(self.archetype) + "<dev string:x888>" + new_spawn_point_origin + "<dev string:x90b>" + spawn_point.targetname);
          } else {
            println("<dev string:x8c6>" + new_spawn_point_origin + "<dev string:x90b>" + spawn_point.targetname);
            iprintlnbold("<dev string:x8c6>" + new_spawn_point_origin + "<dev string:x90b>" + spawn_point.targetname);
          }

          return 0;
        }
      }
    }
  }

  return 0;
}

function drawvalidation(origin, zone_name, nav_mesh_wait_point, boards_point, zone_node, archetype) {
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
    if(is_true(level.toggle_spawner_validation)) {
      if(!isDefined(origin)) {
        break;
      }

      if(isDefined(zone_name)) {
        circle(origin, 32, (1, 0, 0));
        print3d(origin, "<dev string:x92e>" + zone_name, (1, 1, 1), 1, 0.5);
      } else if(isDefined(nav_mesh_wait_point)) {
        circle(origin, 32, (0, 0, 1));

        if(isDefined(archetype)) {
          print3d(origin, archetype + "<dev string:x94c>" + origin, (1, 1, 1), 1, 0.5);
        } else {
          print3d(origin, "<dev string:x970>" + origin, (1, 1, 1), 1, 0.5);
        }

        line(origin, nav_mesh_wait_point, (1, 0, 0));
        circle(nav_mesh_wait_point, 32, (1, 0, 0));
        print3d(nav_mesh_wait_point, "<dev string:x99a>" + nav_mesh_wait_point, (1, 1, 1), 1, 0.5);
      } else if(isDefined(boards_point)) {
        circle(origin, 32, (0, 0, 1));

        if(isDefined(archetype)) {
          print3d(origin, archetype + "<dev string:x94c>" + origin, (1, 1, 1), 1, 0.5);
        } else {
          print3d(origin, "<dev string:x970>" + origin, (1, 1, 1), 1, 0.5);
        }

        line(origin, boards_point, (1, 0, 0));
        circle(boards_point, 32, (1, 0, 0));
        print3d(boards_point, "<dev string:x9ad>" + boards_point, (1, 1, 1), 1, 0.5);
      } else if(isDefined(zone_node)) {
        circle(origin, 32, (1, 0, 0));
        print3d(origin, "<dev string:x9bf>" + (isDefined(zone_node.targetname) ? zone_node.targetname : "<dev string:x38>") + "<dev string:x9cd>" + origin + "<dev string:x9d5>", (1, 1, 1), 1, 0.5);
      } else {
        circle(origin, 32, (0, 0, 1));
        print3d(origin, "<dev string:x9f0>" + origin, (1, 1, 1), 1, 0.5);
      }
    }

    waitframe(1);
  }
}

function zone_adjacencies_validation() {
  zombie_devgui_open_sesame();

  while(true) {
    if(is_true(level.toggle_zone_adjacencies_validation)) {
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

function draw_zone_adjacencies_validation(zone, status, name, current_zone, offset) {
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

function function_f4669d7b(zones, zone) {
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

function zombie_pathing_validation() {
  if(!isDefined(level.zombie_spawners[0])) {
    return;
  }

  if(!isDefined(level.zombie_pathing_validation)) {
    level.zombie_pathing_validation = 1;
  }

  zombie_devgui_open_sesame();
  setDvar(#"zombie_default_max", 0);
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

function function_bcc8843e(weapon_name, up, root) {
  util::waittill_can_add_debug_command();
  rootslash = "<dev string:x38>";

  if(isDefined(root) && root.size) {
    rootslash = root + "<dev string:xa0a>";
  }

  uppath = "<dev string:xa0a>" + up;

  if(up.size < 1) {
    uppath = "<dev string:x38>";
  }

  cmd = "<dev string:xa0f>" + rootslash + weapon_name + uppath + "<dev string:xa34>" + weapon_name + "<dev string:xf9>";
  adddebugcommand(cmd);
}

function devgui_add_weapon_entry(weapon, root, n_order) {
  weapon_name = getweaponname(weapon);

  if(isDefined(root) && root.size) {
    adddebugcommand("<dev string:xa61>" + root + "<dev string:x78>" + n_order + "<dev string:xa0a>" + weapon_name + "<dev string:xa7c>" + weapon_name + "<dev string:xf9>");
    return;
  }

  if(getdvarint(#"zm_debug_attachments", 0)) {
    var_876795bf = weapon.supportedattachments;
    weapon_root = "<dev string:xa61>" + weapon_name + "<dev string:xa0a>";
    adddebugcommand(weapon_root + weapon_name + "<dev string:xa7c>" + weapon_name + "<dev string:xf9>");

    foreach(var_96bc131f in var_876795bf) {
      if(var_96bc131f != "<dev string:x3c>" && var_96bc131f != "<dev string:xa99>") {
        util::waittill_can_add_debug_command();
        var_29c3a74d = weapon_name + "<dev string:xaa1>" + var_96bc131f;
        adddebugcommand(weapon_root + var_29c3a74d + "<dev string:xa7c>" + var_29c3a74d + "<dev string:xf9>");
      }
    }

    return;
  }

  adddebugcommand("<dev string:xa61>" + weapon_name + "<dev string:xa7c>" + weapon_name + "<dev string:xf9>");
}

function devgui_add_weapon(weapon, upgrade, in_box, cost, weaponvo, weaponvoresp, ammo_cost) {
  level endon(#"game_ended");

  if(ammo_cost) {
    level thread function_bcc8843e(getweaponname(weaponvoresp), "<dev string:x38>", "<dev string:x38>");
  }

  util::waittill_can_add_debug_command();

  if(zm_loadout::is_offhand_weapon(weaponvoresp) && !zm_loadout::is_melee_weapon(weaponvoresp)) {
    devgui_add_weapon_entry(weaponvoresp, "<dev string:xaa8>", 2);
    return;
  }

  if(zm_loadout::is_melee_weapon(weaponvoresp)) {
    devgui_add_weapon_entry(weaponvoresp, "<dev string:xab3>", 3);
    return;
  }

  if(zm_weapons::is_wonder_weapon(weaponvoresp)) {
    devgui_add_weapon_entry(weaponvoresp, "<dev string:xabc>", 5);
    return;
  }

  devgui_add_weapon_entry(weaponvoresp, "<dev string:xacd>", 6);
}

function function_3b534f9c() {
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

      setDvar(#"hash_1c9225f4f6e82068", "<dev string:x38>");
    }

    wait 0.1;
    cmd = getdvarstring(#"hash_1c9228f4f6e82581");

    if(isDefined(cmd) && cmd.size > 0) {
      level.zombie_devgui_gun = cmd;
      players = getplayers();

      if(players.size >= 2) {
        players[1] thread zombie_devgui_weapon_give(level.zombie_devgui_gun);
      }

      setDvar(#"hash_1c9228f4f6e82581", "<dev string:x38>");
    }

    wait 0.1;
    cmd = getdvarstring(#"hash_1c9227f4f6e823ce");

    if(isDefined(cmd) && cmd.size > 0) {
      level.zombie_devgui_gun = cmd;
      players = getplayers();

      if(players.size >= 3) {
        players[2] thread zombie_devgui_weapon_give(level.zombie_devgui_gun);
      }

      setDvar(#"hash_1c9227f4f6e823ce", "<dev string:x38>");
    }

    wait 0.1;
    cmd = getdvarstring(#"hash_1c922af4f6e828e7");

    if(isDefined(cmd) && cmd.size > 0) {
      level.zombie_devgui_gun = cmd;
      players = getplayers();

      if(players.size >= 4) {
        players[3] thread zombie_devgui_weapon_give(level.zombie_devgui_gun);
      }

      setDvar(#"hash_1c922af4f6e828e7", "<dev string:x38>");
    }
  }
}

function zombie_weapon_devgui_think() {
  level.zombie_devgui_gun = getdvarstring(#"zombie_devgui_gun");

  for(;;) {
    wait 0.25;
    cmd = getdvarstring(#"zombie_devgui_gun");

    if(isDefined(cmd) && cmd.size > 0) {
      level.zombie_devgui_gun = cmd;
      array::thread_all(getplayers(), &zombie_devgui_weapon_give, level.zombie_devgui_gun);
      setDvar(#"zombie_devgui_gun", "<dev string:x38>");
    }
  }
}

function zombie_devgui_weapon_give(weapon_name) {
  split = strtok(function_9e72a96(weapon_name), "<dev string:xaa1>");

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

function function_2d4d7fd9(weapon) {
  if(self hasweapon(weapon, 1)) {
    self zm_weapons::weapon_take(weapon);
  }

  self thread function_bb54e671(weapon);
  self zm_weapons::weapon_give(weapon);
}

function function_bb54e671(weapon) {
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

function devgui_add_ability(name, upgrade_active_func, stat_name, stat_desired_value, game_end_reset_if_not_achieved) {
  online_game = sessionmodeisonlinegame();

  if(!online_game) {
    return;
  }

  if(!is_true(level.devgui_watch_abilities)) {
    cmd = "<dev string:xad5>";
    adddebugcommand(cmd);
    cmd = "<dev string:xb32>";
    adddebugcommand(cmd);
    level thread zombie_ability_devgui_think();
    level.devgui_watch_abilities = 1;
  }

  cmd = "<dev string:xb8d>" + game_end_reset_if_not_achieved + "<dev string:xbb2>" + game_end_reset_if_not_achieved + "<dev string:xf9>";
  adddebugcommand(cmd);
  cmd = "<dev string:xbd8>" + game_end_reset_if_not_achieved + "<dev string:xc02>" + game_end_reset_if_not_achieved + "<dev string:xf9>";
  adddebugcommand(cmd);
}

function zombie_devgui_ability_give(name) {}

function zombie_devgui_ability_take(name) {}

function zombie_ability_devgui_think() {
  level.zombie_devgui_give_ability = getdvarstring(#"zombie_devgui_give_ability");
  level.zombie_devgui_take_ability = getdvarstring(#"zombie_devgui_take_ability");

  for(;;) {
    wait 0.25;
    cmd = getdvarstring(#"zombie_devgui_give_ability");

    if(!isDefined(level.zombie_devgui_give_ability) || level.zombie_devgui_give_ability != cmd) {
      if(cmd == "<dev string:xc28>") {
        level flag::set("<dev string:xc34>");
      } else if(cmd == "<dev string:xc4a>") {
        level flag::clear("<dev string:xc34>");
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

function zombie_healthbar(pos, dsquared) {
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

function devgui_zombie_healthbar() {
  while(true) {
    if(getdvarint(#"scr_zombie_healthbars", 0) == 1) {
      e_player = getplayers()[0];

      if(isalive(e_player)) {
        a_ai_zombies = getaispeciesarray("<dev string:x60a>", "<dev string:x60a>");

        foreach(ai_zombie in a_ai_zombies) {
          ai_zombie zombie_healthbar(e_player.origin, 360000);
        }
      }
    }

    waitframe(1);
  }
}

function zombie_devgui_watch_input() {
  level flag::wait_till("<dev string:xbd>");
  wait 1;
  players = getplayers();

  for(i = 0; i < players.size; i++) {
    players[i] thread watch_debug_input();
  }
}

function damage_player() {
  self val::set(#"damage_player", "<dev string:xc55>", 1);
  self dodamage(self.health / 2, self.origin);
}

function kill_player() {
  self val::set(#"kill_player", "<dev string:xc55>", 1);
  death_from = (randomfloatrange(-20, 20), randomfloatrange(-20, 20), randomfloatrange(-20, 20));
  self dodamage(self.health + 666, self.origin + death_from);
}

function force_drink() {
  wait 0.01;
  build_weapon = getweapon(#"zombie_builder");
  self thread gestures::function_f3e2696f(self, build_weapon, undefined, 2.5, undefined, undefined, undefined);
}

function zombie_devgui_dpad_none() {
  self thread watch_debug_input();
}

function zombie_devgui_dpad_death() {
  self thread watch_debug_input(&kill_player);
}

function zombie_devgui_dpad_damage() {
  self thread watch_debug_input(&damage_player);
}

function zombie_devgui_dpad_changeweapon() {
  self thread watch_debug_input(&force_drink);
}

function watch_debug_input(callback) {
  self endon(#"disconnect");
  self notify(#"watch_debug_input");
  self endon(#"watch_debug_input");
  level.devgui_dpad_watch = 0;

  if(isDefined(callback)) {
    level.devgui_dpad_watch = 1;

    for(;;) {
      if(self actionslottwobuttonPressed()) {
        self thread[[callback]]();

        while(self actionslottwobuttonPressed()) {
          waitframe(1);
        }
      }

      waitframe(1);
    }
  }
}

function zombie_devgui_think() {
  level notify(#"zombie_devgui_think");
  level endon(#"zombie_devgui_think");

  for(;;) {
    cmd = getdvarstring(#"zombie_devgui");

    switch (cmd) {
      case # "money":
        players = getplayers();
        array::thread_all(players, &zombie_devgui_give_money);
        break;
      case # "scrap":
        players = getplayers();
        array::thread_all(players, &function_6de15bb7);
        break;
      case # "player1_money":
        players = getplayers();

        if(players.size >= 1) {
          players[0] thread zombie_devgui_give_money();
        }

        break;
      case # "player2_money":
        players = getplayers();

        if(players.size >= 2) {
          players[1] thread zombie_devgui_give_money();
        }

        break;
      case # "player3_money":
        players = getplayers();

        if(players.size >= 3) {
          players[2] thread zombie_devgui_give_money();
        }

        break;
      case # "player4_money":
        players = getplayers();

        if(players.size >= 4) {
          players[3] thread zombie_devgui_give_money();
        }

        break;
      case # "moneydown":
        players = getplayers();
        array::thread_all(players, &zombie_devgui_take_money);
        break;
      case # "player1_moneydown":
        players = getplayers();

        if(players.size >= 1) {
          players[0] thread zombie_devgui_take_money();
        }

        break;
      case # "player2_moneydown":
        players = getplayers();

        if(players.size >= 2) {
          players[1] thread zombie_devgui_take_money();
        }

        break;
      case # "player3_moneydown":
        players = getplayers();

        if(players.size >= 3) {
          players[2] thread zombie_devgui_take_money();
        }

        break;
      case # "player4_moneydown":
        players = getplayers();

        if(players.size >= 4) {
          players[3] thread zombie_devgui_take_money();
        }

        break;
      case # "ammodown":
        players = getplayers();
        array::thread_all(players, &function_dc7312be);
        break;
      case # "hash_428dbd0a89fc5d32":
        players = getplayers();

        if(players.size >= 1) {
          players[0] thread function_dc7312be();
        }

        break;
      case # "hash_119220b211e16ba9":
        players = getplayers();

        if(players.size >= 2) {
          players[1] thread function_dc7312be();
        }

        break;
      case # "hash_6cdf097974c7bcd0":
        players = getplayers();

        if(players.size >= 3) {
          players[2] thread function_dc7312be();
        }

        break;
      case # "hash_5e281497ef267e37":
        players = getplayers();

        if(players.size >= 4) {
          players[3] thread function_dc7312be();
        }

        break;
      case # "hash_59a96f9816430398":
        players = getplayers();

        if(players.size >= 1) {
          players[0] thread zombie_devgui_give_xp(1000);
        }

        break;
      case # "hash_423b4f1fbe6391dd":
        players = getplayers();

        if(players.size >= 2) {
          players[1] thread zombie_devgui_give_xp(1000);
        }

        break;
      case # "hash_50580bf75ed9e65e":
        players = getplayers();

        if(players.size >= 3) {
          players[2] thread zombie_devgui_give_xp(1000);
        }

        break;
      case # "hash_4e18caaf131ec443":
        players = getplayers();

        if(players.size >= 4) {
          players[3] thread zombie_devgui_give_xp(1000);
        }

        break;
      case # "hash_1dec476dd3df3678":
        players = getplayers();

        if(players.size >= 1) {
          players[0] thread zombie_devgui_give_xp(10000);
        }

        break;
      case # "hash_6e595ff08330f5b7":
        players = getplayers();

        if(players.size >= 2) {
          players[1] thread zombie_devgui_give_xp(10000);
        }

        break;
      case # "hash_5f82c3562c428cea":
        players = getplayers();

        if(players.size >= 3) {
          players[2] thread zombie_devgui_give_xp(10000);
        }

        break;
      case # "hash_52e4da7d7d47cf69":
        players = getplayers();

        if(players.size >= 4) {
          players[3] thread zombie_devgui_give_xp(10000);
        }

        break;
      case # "health":
        array::thread_all(getplayers(), &zombie_devgui_give_health);
        break;
      case # "player1_health":
        players = getplayers();

        if(players.size >= 1) {
          players[0] thread zombie_devgui_give_health();
        }

        break;
      case # "player2_health":
        players = getplayers();

        if(players.size >= 2) {
          players[1] thread zombie_devgui_give_health();
        }

        break;
      case # "player3_health":
        players = getplayers();

        if(players.size >= 3) {
          players[2] thread zombie_devgui_give_health();
        }

        break;
      case # "player4_health":
        players = getplayers();

        if(players.size >= 4) {
          players[3] thread zombie_devgui_give_health();
        }

        break;
      case # "minhealth":
        array::thread_all(getplayers(), &zombie_devgui_low_health);
        break;
      case # "player1_minhealth":
        players = getplayers();

        if(players.size >= 1) {
          players[0] thread zombie_devgui_low_health();
        }

        break;
      case # "player2_minhealth":
        players = getplayers();

        if(players.size >= 2) {
          players[1] thread zombie_devgui_low_health();
        }

        break;
      case # "player3_minhealth":
        players = getplayers();

        if(players.size >= 3) {
          players[2] thread zombie_devgui_low_health();
        }

        break;
      case # "player4_minhealth":
        players = getplayers();

        if(players.size >= 4) {
          players[3] thread zombie_devgui_low_health();
        }

        break;
      case # "ammo":
        array::thread_all(getplayers(), &zombie_devgui_toggle_ammo);
        break;
      case # "ignore":
        array::thread_all(getplayers(), &zombie_devgui_toggle_ignore);
        break;
      case # "player1_ignore":
        players = getplayers();

        if(players.size >= 1) {
          players[0] thread zombie_devgui_toggle_ignore();
        }

        break;
      case # "player2_ignore":
        players = getplayers();

        if(players.size >= 2) {
          players[1] thread zombie_devgui_toggle_ignore();
        }

        break;
      case # "player3_ignore":
        players = getplayers();

        if(players.size >= 3) {
          players[2] thread zombie_devgui_toggle_ignore();
        }

        break;
      case # "player4_ignore":
        players = getplayers();

        if(players.size >= 4) {
          players[3] thread zombie_devgui_toggle_ignore();
        }

        break;
      case # "invul_on":
        zombie_devgui_invulnerable(undefined, 1);
        break;
      case # "invul_off":
        zombie_devgui_invulnerable(undefined, 0);
        break;
      case # "player1_invul_on":
        zombie_devgui_invulnerable(0, 1);
        break;
      case # "player1_invul_off":
        zombie_devgui_invulnerable(0, 0);
        break;
      case # "player2_invul_on":
        zombie_devgui_invulnerable(1, 1);
        break;
      case # "player2_invul_off":
        zombie_devgui_invulnerable(1, 0);
        break;
      case # "player3_invul_on":
        zombie_devgui_invulnerable(2, 1);
        break;
      case # "player3_invul_off":
        zombie_devgui_invulnerable(2, 0);
        break;
      case # "player4_invul_on":
        zombie_devgui_invulnerable(3, 1);
        break;
      case # "player4_invul_off":
        zombie_devgui_invulnerable(3, 0);
        break;
      case # "revive_all":
        array::thread_all(getplayers(), &zombie_devgui_revive);
        break;
      case # "player1_revive":
        players = getplayers();

        if(players.size >= 1) {
          players[0] thread zombie_devgui_revive();
        }

        break;
      case # "player2_revive":
        players = getplayers();

        if(players.size >= 2) {
          players[1] thread zombie_devgui_revive();
        }

        break;
      case # "player3_revive":
        players = getplayers();

        if(players.size >= 3) {
          players[2] thread zombie_devgui_revive();
        }

        break;
      case # "player4_revive":
        players = getplayers();

        if(players.size >= 4) {
          players[3] thread zombie_devgui_revive();
        }

        break;
      case # "player1_kill":
        players = getplayers();

        if(players.size >= 1) {
          players[0] thread zombie_devgui_kill();
        }

        break;
      case # "player2_kill":
        players = getplayers();

        if(players.size >= 2) {
          players[1] thread zombie_devgui_kill();
        }

        break;
      case # "player3_kill":
        players = getplayers();

        if(players.size >= 3) {
          players[2] thread zombie_devgui_kill();
        }

        break;
      case # "player4_kill":
        players = getplayers();

        if(players.size >= 4) {
          players[3] thread zombie_devgui_kill();
        }

        break;
      case # "hash_7f4d70c7ded8e94a":
        if(zm_utility::get_story() === 2) {
          array::random(getplayers()) giveweapon(getweapon(#"homunculus"));
        }

        array::thread_all(getplayers(), &function_8d799ebd);
        break;
      case # "hash_505efa1825e2cb99":
        players = getplayers();

        if(players.size >= 1) {
          players[0] thread function_8d799ebd();
        }

        break;
      case # "hash_15233852e3dc3500":
        players = getplayers();

        if(players.size >= 2) {
          players[1] thread function_8d799ebd();
        }

        break;
      case # "hash_5cb5edc4858d92f7":
        players = getplayers();

        if(players.size >= 3) {
          players[2] thread function_8d799ebd();
        }

        break;
      case # "hash_6d57ff86c541a5fe":
        players = getplayers();

        if(players.size >= 4) {
          players[3] thread function_8d799ebd();
        }

        break;
      case # "hash_2c320318aed843b2":
        array::thread_all(getplayers(), &zm_laststand::function_3d685b5f, 100);
        break;
      case # "hash_72783b08840a3ab7":
        players = getplayers();

        if(players.size >= 1) {
          players[0] thread zm_laststand::function_3d685b5f(100);
        }

        break;
      case # "hash_447712ef48d6ea0":
        players = getplayers();

        if(players.size >= 2) {
          players[1] thread zm_laststand::function_3d685b5f(100);
        }

        break;
      case # "hash_2a15f60adbba0cf5":
        players = getplayers();

        if(players.size >= 3) {
          players[2] thread zm_laststand::function_3d685b5f(100);
        }

        break;
      case # "hash_430eb4715f49a5fe":
        players = getplayers();

        if(players.size >= 4) {
          players[3] thread zm_laststand::function_3d685b5f(100);
        }

        break;
      case # "talent_quickrevive":
        level.solo_lives_given = 0;
      case # "specialty_electriccherry":
      case # "talent_doubletap":
      case # "talent_staminup":
      case # "talent_deadshot":
      case # "specialty_phdflopper":
      case # "specialty_fastmeleerecovery":
      case # "specialty_widowswine":
      case # "specialty_vultureaid":
      case # "specialty_showonradar":
      case # "hash_38c08136902fd553":
      case # "specialty_additionalprimaryweapon":
        zombie_devgui_give_perk(cmd);
        break;
      case # "remove_perks":
        zombie_devgui_take_perks(cmd);
        break;
      case # "insta_kill":
      case # "lose_points_team":
      case # "hash_6e53cf6d1c583d31":
      case # "naughty_or_nice":
      case # "hash_75498ace109f55e9":
      case # "hero_weapon_power":
      case # "double_points":
      case # "minigun":
      case # "carpenter":
      case # "zmarcade_key":
      case # "free_perk":
      case # "extra_lives":
      case # "tesla":
      case # "cranked_pause":
      case # "pack_a_punch":
      case # "bonus_points_player":
      case # "lose_perk":
      case # "hash_3a780f4f7b791f2c":
      case # "meat_stink":
      case # "hash_55b98b6e24a3e48e":
      case # "full_ammo":
      case # "empty_clip":
      case # "bonus_points_team":
      case # "random_weapon":
      case # "nuke":
      case # "fire_sale":
      case # "bonfire_sale":
        zombie_devgui_give_powerup(cmd, 1);
        break;
      case # "next_extra_lives":
      case # "next_random_weapon":
      case # "next_full_ammo":
      case # "next_lose_perk":
      case # "hash_6b6c14b0d315d68f":
      case # "next_zmarcade_key":
      case # "hash_49f2171f2a5b4c28":
      case # "next_nuke":
      case # "next_fire_sale":
      case # "next_bonus_points_team":
      case # "next_lose_points_team":
      case # "next_free_perk":
      case # "next_bonus_points_player":
      case # "next_bonfire_sale":
      case # "next_minigun":
      case # "next_empty_clip":
      case # "next_double_points":
      case # "next_pack_a_punch":
      case # "next_insta_kill":
      case # "next_tesla":
      case # "next_carpenter":
      case # "next_hero_weapon_power":
      case # "next_meat_stink":
        zombie_devgui_give_powerup(getsubstr(cmd, 5), 0);
        break;
      case # "round":
        zombie_devgui_goto_round(getdvarint(#"scr_zombie_round", 0));
        break;
      case # "round_next":
        zombie_devgui_goto_round(level.round_number + 1);
        break;
      case # "round_prev":
        zombie_devgui_goto_round(level.round_number - 1);
        break;
      case # "chest_warp":
        array::thread_all(getplayers(), &function_4bb7eb36);
        break;
      case # "pap_warp":
        array::thread_all(getplayers(), &function_84f0a909);
        break;
      case # "chest_move":
        if(isDefined(level.chest_accessed)) {
          level notify(#"devgui_chest_end_monitor");
          level.var_401aaa92 = 1;
        }

        break;
      case # "chest_never_move":
        if(isDefined(level.chest_accessed)) {
          level.var_401aaa92 = 0;
          level thread zombie_devgui_chest_never_move();
        }

        break;
      case # "chest":
        if(isDefined(level.zombie_weapons[getweapon(getdvarstring(#"scr_force_weapon"))])) {
          if(isDefined(level.zombie_weapons[getweapon(getdvarstring(#"scr_force_weapon"))].item_entry)) {
            level.var_f83c8dc2 = level.zombie_weapons[getweapon(getdvarstring(#"scr_force_weapon"))].item_entry;
          }
        }

        break;
      case # "give_claymores":
        array::thread_all(getplayers(), &zombie_devgui_give_placeable_mine, getweapon(#"claymore"));
        break;
      case # "give_bouncingbetties":
        array::thread_all(getplayers(), &zombie_devgui_give_placeable_mine, getweapon(#"bouncingbetty"));
        break;
      case # "give_frags":
        array::thread_all(getplayers(), &zombie_devgui_give_frags);
        break;
      case # "give_sticky":
        array::thread_all(getplayers(), &zombie_devgui_give_sticky);
        break;
      case # "give_monkey":
        array::thread_all(getplayers(), &zombie_devgui_give_monkey);
        break;
      case # "give_bhb":
        array::thread_all(getplayers(), &zombie_devgui_give_bhb);
        break;
      case # "give_quantum":
        array::thread_all(getplayers(), &zombie_devgui_give_qed);
        break;
      case # "give_dolls":
        array::thread_all(getplayers(), &zombie_devgui_give_dolls);
        break;
      case # "give_emp_bomb":
        array::thread_all(getplayers(), &zombie_devgui_give_emp_bomb);
        break;
      case # "dog_round":
        zombie_devgui_dog_round(1);
        break;
      case # "dog_round_skip":
        zombie_devgui_dog_round_skip();
        break;
      case # "print_variables":
        zombie_devgui_dump_zombie_vars();
        break;
      case # "pack_current_weapon":
        zombie_devgui_pack_current_weapon();
        break;
      case # "hash_f9c9f7dd75a4047":
        function_8c9f2dea();
        break;
      case # "hash_5605531ad17b5408":
        function_b7ef4b8();
        break;
      case # "hash_2dde14d5c2960aea":
        function_9b4d61fa();
        break;
      case # "hash_465e01a5b9f4f28e":
        function_cdc3d061();
        break;
      case # "repack_current_weapon":
        zombie_devgui_repack_current_weapon();
        break;
      case # "unpack_current_weapon":
        zombie_devgui_unpack_current_weapon();
        break;
      case # "hash_72edcaf35bf3346d":
        function_2a5ce9b1(#"white");
        break;
      case # "hash_62c70a71f6331428":
        function_2a5ce9b1(#"green");
        break;
      case # "hash_7067e48773d50cbe":
        function_2a5ce9b1(#"blue");
        break;
      case # "hash_309cf17674ed6d45":
        function_2a5ce9b1(#"purple");
        break;
      case # "hash_166a522b8358b72b":
        function_2a5ce9b1(#"orange");
        break;
      case # "hash_3c2b067b1510118c":
        function_c8949116();
        break;
      case # "hash_769c6d03952dd107":
        function_9d21f44b();
        break;
      case # "hash_68e9afed4aa9c0dd":
        function_e2a97bab();
        break;
      case # "hash_3f4888627ed06269":
        function_1a560cfc();
        break;
      case # "hash_73ecd8731ecdf6b0":
        function_c8ee84ba();
        break;
      case # "hash_49563ad3930e97e4":
        function_c83c6fa();
        break;
      case # "reopt_current_weapon":
        zombie_devgui_reopt_current_weapon();
        break;
      case # "weapon_take_all_fallback":
        zombie_devgui_take_weapons(1);
        break;
      case # "weapon_take_all":
        zombie_devgui_take_weapons(0);
        break;
      case # "weapon_take_current":
        zombie_devgui_take_weapon();
        break;
      case # "power_on":
        level flag::set("<dev string:xc63>");
        level clientfield::set("<dev string:xc6f>", 1);
        power_trigs = getEntArray("<dev string:xc82>", "<dev string:xc95>");

        foreach(trig in power_trigs) {
          if(isDefined(trig.script_int)) {
            level flag::set("<dev string:xc63>" + trig.script_int);
            level clientfield::set("<dev string:xc6f>", trig.script_int + 1);
          }
        }

        break;
      case # "power_off":
        level flag::clear("<dev string:xc63>");
        level clientfield::set("<dev string:xca3>", 0);
        power_trigs = getEntArray("<dev string:xc82>", "<dev string:xc95>");

        foreach(trig in power_trigs) {
          if(isDefined(trig.script_int)) {
            level flag::clear("<dev string:xc63>" + trig.script_int);
            level clientfield::set("<dev string:xca3>", trig.script_int);
          }
        }

        break;
      case # "zombie_dpad_none":
        array::thread_all(getplayers(), &zombie_devgui_dpad_none);
        break;
      case # "zombie_dpad_damage":
        array::thread_all(getplayers(), &zombie_devgui_dpad_damage);
        break;
      case # "zombie_dpad_kill":
        array::thread_all(getplayers(), &zombie_devgui_dpad_death);
        break;
      case # "zombie_dpad_drink":
        array::thread_all(getplayers(), &zombie_devgui_dpad_changeweapon);
        break;
      case # "director_easy":
        zombie_devgui_director_easy();
        break;
      case # "open_sesame":
        zombie_devgui_open_sesame();
        break;
      case # "allow_fog":
        zombie_devgui_allow_fog();
        break;
      case # "disable_kill_thread_toggle":
        zombie_devgui_disable_kill_thread_toggle();
        break;
      case # "check_kill_thread_every_frame_toggle":
        zombie_devgui_check_kill_thread_every_frame_toggle();
        break;
      case # "kill_thread_test_mode_toggle":
        zombie_devgui_kill_thread_test_mode_toggle();
        break;
      case # "zombie_failsafe_debug_flush":
        level notify(#"zombie_failsafe_debug_flush");
        break;
      case # "rat_navmesh":
        level thread rat::derriesezombiespawnnavmeshtest(0, 0);
        break;
      case # "spawn":
        devgui_zombie_spawn();
        break;
      case # "spawn_dummy":
        function_6f066ef();
        break;
      case # "spawn_near":
        function_7c17d00f();
        break;
      case # "spawn_all":
        devgui_all_spawn();
        break;
      case # "crawler":
        devgui_make_crawler();
        break;
      case # "toggle_show_spawn_locations":
        devgui_toggle_show_spawn_locations();
        break;
      case # "toggle_show_exterior_goals":
        devgui_toggle_show_exterior_goals();
        break;
      case # "draw_traversals":
        zombie_devgui_draw_traversals();
        break;
      case # "dump_traversals":
        function_bbeaa2da();
        break;
      case # "debug_hud":
        array::thread_all(getplayers(), &devgui_debug_hud);
        break;
      case # "reverse_carpenter":
        function_f12b8a34();
        break;
      case # "keyline_always":
        zombie_devgui_keyline_always();
        break;
      case # "hash_1e51dfcdbebdf936":
        robotsupportsovercover_manager_();
        break;
      case # "debug_counts":
        function_92523b12();
        break;
      case # "hash_604a84ea1690f781":
        thread function_3a5618f8();
        break;
      case # "hash_72a10718318ec7ff":
        function_21f1fbf1();
        break;
      case # "debug_navmesh_zone":
        function_e395a714();
        break;
      case # "hash_28fd3c9a92f22718":
        function_5349e112();
        break;
      case # "hash_7fafc507d5398c0b":
        function_567ee21f();
        break;
      case # "hash_3ede275f03a4aa2b":
        function_1762ff96();
        break;
      case # "hash_74f6277a8a40911e":
        function_e5713258();
        break;
      case # "hash_3d647b897ae5dca6":
        function_f298dd5c();
        break;
      case # "hash_3f826ccc785705ba":
        function_26417ea7();
        break;
      case # "hash_683b625d2ace3726":
        function_fb88b423();
        break;
      case # "hash_3f9e70ff9f34194a":
        function_1b531660();
        break;
      case # "hash_7883eb109c3e6a94":
        array::thread_all(function_a1ef346b(), &function_1bb72156);
        break;
      case # "draw_wallbuy":
        function_2f0c6f91();
        break;
      case # "hash_320b004253fe00b8":
        function_1a4752d0();
        break;
      case 0:
        break;
      default:
        if(isDefined(level.custom_devgui)) {
          if(isarray(level.custom_devgui)) {
            foreach(devgui in level.custom_devgui) {
              b_result = [[devgui]](cmd);

              if(is_true(b_result)) {
                break;
              }
            }
          } else {
            [[level.custom_devgui]](cmd);
          }
        }

        break;
    }

    setDvar(#"zombie_devgui", "<dev string:x38>");
    wait 0.5;
  }
}

function add_custom_devgui_callback(callback) {
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

function devgui_all_spawn() {
  player = util::gethostplayer();

  for(i = 0; i < 3; i++) {
    bot::add_bot(player.team);
    wait 0.1;
  }

  zombie_devgui_goto_round(8);
}

function devgui_toggle_show_spawn_locations() {
  if(!isDefined(level.toggle_show_spawn_locations)) {
    level.toggle_show_spawn_locations = 1;
    return;
  }

  level.toggle_show_spawn_locations = !level.toggle_show_spawn_locations;
}

function devgui_toggle_show_exterior_goals() {
  if(!isDefined(level.toggle_show_exterior_goals)) {
    level.toggle_show_exterior_goals = 1;
    return;
  }

  level.toggle_show_exterior_goals = !level.toggle_show_exterior_goals;
}

function function_567ee21f() {
  level.var_377c39e4 = !is_true(level.var_377c39e4);

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

function function_9960be00() {
  return;
}

function function_33825850(spawner, target_name, spot, round_number) {
  guy = spot spawnfromspawner(round_number, 1);
  return guy;
}

function devgui_zombie_spawn() {
  player = getplayers()[0];
  spawnername = undefined;
  spawnername = "<dev string:xcb7>";
  direction = player getplayerangles();
  direction_vec = anglesToForward(direction);
  eye = player getEye();
  scale = 8000;
  direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
  trace = bulletTrace(eye, eye + direction_vec, 0, undefined);
  guy = undefined;

  if(isDefined(level.fn_custom_zombie_spawner_selection)) {
    spawner = [[level.fn_custom_zombie_spawner_selection]]();
  } else {
    spawners = getEntArray(spawnername, "<dev string:xcc9>");
    spawner = array::random(spawners);
  }

  var_f4dd97fd = spawner.script_forcespawn;
  spawner.script_forcespawn = 1;
  var_9e1082b2 = level.overridezombiespawn;
  level.overridezombiespawn = &function_33825850;
  guy = zombie_utility::spawn_zombie(spawner, "<dev string:x44>");
  level.overridezombiespawn = var_9e1082b2;
  spawner.script_forcespawn = var_f4dd97fd;

  if(isDefined(guy)) {
    guy.script_string = "<dev string:x77e>";
    guy dontinterpolate();
    guy forceteleport(trace[# "position"], player.angles + (0, 180, 0));
  }

  return guy;
}

function function_6f066ef() {
  player = getplayers()[0];
  forward = anglesToForward(player.angles);
  spawn = player.origin + forward * 25;
  guy = devgui_zombie_spawn();

  if(isDefined(guy)) {
    waitframe(1);
    guy pathmode("<dev string:xcde>");
    guy forceteleport(spawn, player.angles);
  }
}

function function_7c17d00f() {
  player = getplayers()[0];
  forward = anglesToForward(player.angles);
  spawn = player.origin + forward * 100;
  guy = devgui_zombie_spawn();

  if(isDefined(guy)) {
    guy forceteleport(spawn, player.angles + (0, 180, 0));
  }
}

function devgui_make_crawler() {
  zombies = zombie_utility::get_round_enemy_array();

  foreach(zombie in zombies) {
    gib_style = [];
    gib_style[gib_style.size] = "<dev string:xceb>";
    gib_style[gib_style.size] = "<dev string:xcf6>";
    gib_style[gib_style.size] = "<dev string:xd03>";
    gib_style = array::randomize(gib_style);
    zombie.a.gib_ref = gib_style[0];
    zombie zombie_utility::function_df5afb5e(1);
    zombie allowedstances("<dev string:xd0f>");
    zombie setphysparams(15, 0, 24);
    zombie allowpitchangle(1);
    zombie setpitchorient();
    health = zombie.health;
    health *= 0.1;
    zombie thread zombie_death::do_gib();
  }
}

function zombie_devgui_open_sesame() {
  setDvar(#"zombie_unlock_all", 1);
  level flag::set("<dev string:xc63>");
  level clientfield::set("<dev string:xc6f>", 1);
  power_trigs = getEntArray("<dev string:xc82>", "<dev string:xc95>");

  foreach(trig in power_trigs) {
    if(isDefined(trig.script_int)) {
      level flag::set("<dev string:xc63>" + trig.script_int);
      level clientfield::set("<dev string:xc6f>", trig.script_int + 1);
    }
  }

  players = getplayers();
  array::thread_all(players, &zombie_devgui_give_money);
  zombie_doors = getEntArray("<dev string:xd19>", "<dev string:xc95>");

  for(i = 0; i < zombie_doors.size; i++) {
    if(!is_true(zombie_doors[i].has_been_opened)) {
      zombie_doors[i] notify(#"trigger", {
        #activator: players[0]
      });
    }

    if(is_true(zombie_doors[i].power_door_ignore_flag_wait)) {
      zombie_doors[i] notify(#"power_on");
    }

    waitframe(1);
  }

  zombie_airlock_doors = getEntArray("<dev string:xd28>", "<dev string:xc95>");

  for(i = 0; i < zombie_airlock_doors.size; i++) {
    zombie_airlock_doors[i] notify(#"trigger", {
      #activator: players[0]
    });
    waitframe(1);
  }

  zombie_debris = getEntArray("<dev string:xd3e>", "<dev string:xc95>");

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
  setDvar(#"zombie_unlock_all", 0);
}

function any_player_in_noclip() {
  foreach(player in getplayers()) {
    if(player isinmovemode("<dev string:xd4f>", "<dev string:xd56>")) {
      return 1;
    }
  }

  return 0;
}

function diable_fog_in_noclip() {
  level.fog_disabled_in_noclip = 1;
  level endon(#"allowfoginnoclip");
  level flag::wait_till("<dev string:xbd>");

  while(true) {
    while(!any_player_in_noclip()) {
      wait 1;
    }

    setDvar(#"scr_fog_disable", 1);
    setDvar(#"r_fog_disable", 1);

    if(isDefined(level.culldist)) {
      setculldist(0);
    }

    while(any_player_in_noclip()) {
      wait 1;
    }

    setDvar(#"scr_fog_disable", 0);
    setDvar(#"r_fog_disable", 0);

    if(isDefined(level.culldist)) {
      setculldist(level.culldist);
    }
  }
}

function zombie_devgui_allow_fog() {
  if(is_true(level.fog_disabled_in_noclip)) {
    level notify(#"allowfoginnoclip");
    level.fog_disabled_in_noclip = 0;
    setDvar(#"scr_fog_disable", 0);
    setDvar(#"r_fog_disable", 0);
    return;
  }

  thread diable_fog_in_noclip();
}

function zombie_devgui_give_money(var_90c2e203) {
  if(!isDefined(var_90c2e203)) {
    var_90c2e203 = 100000;
  }

  level.devcheater = 1;
  self zm_score::add_to_player_score(var_90c2e203);
}

function function_6de15bb7(var_90c2e203) {
  if(!isDefined(var_90c2e203)) {
    var_90c2e203 = 10000;
  }

  self namespace_2a9f256a::function_afab250a(var_90c2e203);
  self namespace_2a9f256a::function_a6d4221f(var_90c2e203);
}

function zombie_devgui_take_money() {
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(isalive(self));

  if(self.score > 100) {
    self zm_score::player_reduce_points("<dev string:xd60>");
    return;
  }

  self zm_score::player_reduce_points("<dev string:xd6d>");
}

function function_dc7312be() {
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(isalive(self));

  if(!self zm_utility::is_drinking()) {
    weapon = self getcurrentweapon();

    if(weapon != level.weaponnone && weapon != level.weaponzmfists && !is_true(weapon.isflourishweapon)) {
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

function zombie_devgui_give_xp(amount) {
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(isalive(self));
  self addrankxp("<dev string:xd79>", 0, self.currentweapon, undefined, undefined, amount / 50);
}

function zombie_devgui_turn_player(index) {
  players = getplayers();

  if(!isDefined(index) || index >= players.size) {
    player = players[0];
  } else {
    player = players[index];
  }

  assert(isDefined(player));
  assert(isPlayer(player));
  assert(isalive(player));
  level.devcheater = 1;

  if(player hasperk(#"specialty_playeriszombie")) {
    println("<dev string:xd81>");
    player zm_turned::turn_to_human();
    return;
  }

  println("<dev string:xd98>");
  player zm_turned::turn_to_zombie();
}

function function_4bb7eb36() {
  if(!isDefined(level.chests) || !isDefined(level.chest_index)) {
    iprintlnbold("<dev string:xdb0>");
    return;
  }

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

function function_84f0a909() {
  entnum = self getentitynumber();
  paps = getEntArray("<dev string:xdd2>", "<dev string:xc95>");
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

function zombie_devgui_cool_jetgun() {
  if(isDefined(level.zm_devgui_jetgun_never_overheat)) {
    self thread[[level.zm_devgui_jetgun_never_overheat]]();
  }
}

function zombie_devgui_preserve_turbines() {
  self endon(#"disconnect");
  self notify(#"preserve_turbines");
  self endon(#"preserve_turbines");

  if(!is_true(self.preserving_turbines)) {
    self.preserving_turbines = 1;

    while(true) {
      self.turbine_health = 1200;
      wait 1;
    }
  }

  self.preserving_turbines = 0;
}

function zombie_devgui_equipment_stays_healthy() {
  self endon(#"disconnect");
  self notify(#"preserve_equipment");
  self endon(#"preserve_equipment");

  if(!is_true(self.preserving_equipment)) {
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

function zombie_devgui_disown_equipment() {
  self.deployed_equipment = [];
}

function zombie_devgui_equipment_give(equipment) {
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(isalive(self));
  level.devcheater = 1;

  if(zm_equipment::is_included(equipment)) {
    self zm_equipment::buy(equipment);
  }
}

function zombie_devgui_give_placeable_mine(weapon) {
  self endon(#"disconnect");
  self notify(#"give_planted_grenade_thread");
  self endon(#"give_planted_grenade_thread");
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(isalive(self));
  level.devcheater = 1;

  if(!zm_loadout::is_placeable_mine(weapon)) {
    return;
  }

  if(isDefined(self zm_loadout::get_player_placeable_mine())) {
    self zm_weapons::weapon_take(self zm_loadout::get_player_placeable_mine());
  }

  self thread zm_placeable_mine::setup_for_player(weapon);

  while(true) {
    self givemaxammo(weapon);
    wait 1;
  }
}

function zombie_devgui_give_claymores() {
  self endon(#"disconnect");
  self notify(#"give_planted_grenade_thread");
  self endon(#"give_planted_grenade_thread");
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(isalive(self));
  level.devcheater = 1;

  if(isDefined(self zm_loadout::get_player_placeable_mine())) {
    self zm_weapons::weapon_take(self zm_loadout::get_player_placeable_mine());
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

function zombie_devgui_give_lethal(weapon) {
  self endon(#"disconnect");
  self notify(#"give_lethal_grenade_thread");
  self endon(#"give_lethal_grenade_thread");
  assert(isDefined(self));
  assert(isPlayer(self));
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

function zombie_devgui_give_frags() {
  zombie_devgui_give_lethal(getweapon(#"eq_frag_grenade"));
}

function zombie_devgui_give_sticky() {
  zombie_devgui_give_lethal(getweapon(#"sticky_grenade"));
}

function zombie_devgui_give_monkey() {
  self endon(#"disconnect");
  self notify(#"give_tactical_grenade_thread");
  self endon(#"give_tactical_grenade_thread");
  assert(isDefined(self));
  assert(isPlayer(self));
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

function zombie_devgui_give_bhb() {
  self endon(#"disconnect");
  self notify(#"give_tactical_grenade_thread");
  self endon(#"give_tactical_grenade_thread");
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(isalive(self));
  level.devcheater = 1;

  if(isDefined(self zm_loadout::get_player_tactical_grenade())) {
    self zm_weapons::weapon_take(self zm_loadout::get_player_tactical_grenade());
  }

  if(isDefined(level.var_5076c574)) {
    self[[level.var_5076c574]]();

    while(true) {
      self givemaxammo(level.w_black_hole_bomb);
      wait 1;
    }
  }
}

function zombie_devgui_give_qed() {
  self endon(#"disconnect");
  self notify(#"give_tactical_grenade_thread");
  self endon(#"give_tactical_grenade_thread");
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(isalive(self));
  level.devcheater = 1;

  if(isDefined(self zm_loadout::get_player_tactical_grenade())) {
    self zm_weapons::weapon_take(self zm_loadout::get_player_tactical_grenade());
  }

  if(isDefined(level.var_3079bbd7)) {
    self[[level.var_3079bbd7]]();

    while(true) {
      self givemaxammo(level.w_quantum_bomb);
      wait 1;
    }
  }
}

function zombie_devgui_give_dolls() {
  self endon(#"disconnect");
  self notify(#"give_tactical_grenade_thread");
  self endon(#"give_tactical_grenade_thread");
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(isalive(self));
  level.devcheater = 1;

  if(isDefined(self zm_loadout::get_player_tactical_grenade())) {
    self zm_weapons::weapon_take(self zm_loadout::get_player_tactical_grenade());
  }

  if(isDefined(level.var_42cebfa6)) {
    self[[level.var_42cebfa6]]();

    while(true) {
      self givemaxammo(level.w_nesting_dolls);
      wait 1;
    }
  }
}

function zombie_devgui_give_emp_bomb() {
  self endon(#"disconnect");
  self notify(#"give_tactical_grenade_thread");
  self endon(#"give_tactical_grenade_thread");
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(isalive(self));
  level.devcheater = 1;

  if(isDefined(self zm_loadout::get_player_tactical_grenade())) {
    self zm_weapons::weapon_take(self zm_loadout::get_player_tactical_grenade());
  }

  if(isDefined(level.var_153af402)) {
    self[[level.var_153af402]]();

    while(true) {
      self givemaxammo(getweapon(#"emp_grenade"));
      wait 1;
    }
  }
}

function zombie_devgui_invulnerable(playerindex, onoff) {
  players = getplayers();

  if(!isDefined(playerindex)) {
    for(i = 0; i < players.size; i++) {
      zombie_devgui_invulnerable(i, onoff);
    }

    return;
  }

  if(players.size > playerindex) {
    if(onoff) {
      players[playerindex] val::set(#"zombie_devgui", "<dev string:xc55>", 0);
      return;
    }

    players[playerindex] val::reset(#"zombie_devgui", "<dev string:xc55>");
  }
}

function zombie_devgui_kill() {
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(isalive(self));
  self val::set(#"devgui_kill", "<dev string:xc55>", 1);
  death_from = (randomfloatrange(-20, 20), randomfloatrange(-20, 20), randomfloatrange(-20, 20));
  self dodamage(self.health + 666, self.origin + death_from);
}

function zombie_devgui_toggle_ammo() {
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(isalive(self));
  self notify(#"devgui_toggle_ammo");
  self endon(#"devgui_toggle_ammo");
  self.ammo4evah = !is_true(self.ammo4evah);

  while(isDefined(self) && self.ammo4evah) {
    if(!self zm_utility::is_drinking()) {
      weapon = self getcurrentweapon();

      if(weapon != level.weaponnone && weapon != level.weaponzmfists && !is_true(weapon.isflourishweapon)) {
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

function zombie_devgui_toggle_ignore() {
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(isalive(self));

  if(!isDefined(self.devgui_ignoreme)) {
    self.devgui_ignoreme = 0;
  }

  self.devgui_ignoreme = !self.devgui_ignoreme;

  if(self.devgui_ignoreme) {
    self val::set(#"devgui", "<dev string:xde5>");
  } else {
    self val::reset(#"devgui", "<dev string:xde5>");
  }

  if(self.ignoreme) {
    setDvar(#"ai_showfailedpaths", 0);
  }
}

function zombie_devgui_revive() {
  assert(isDefined(self));
  assert(isPlayer(self));

  if(laststand::player_is_in_laststand()) {
    self notify(#"auto_revive");
  }
}

function zombie_devgui_give_health() {
  assert(isDefined(self));
  assert(isPlayer(self));
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

function zombie_devgui_low_health() {
  assert(isDefined(self));
  assert(isPlayer(self));
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

function zombie_devgui_give_perk(perk) {
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

function zombie_devgui_take_perks(cmd) {
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
      perk_str = perk + "<dev string:xdf1>";
      player notify(perk_str);
    }
  }
}

function function_fd6c1b3c(cmd) {
  if(isDefined(level.perk_random_devgui_callback)) {
    self[[level.perk_random_devgui_callback]](cmd);
  }
}

function function_82f7d6a1(cmd) {
  if(isDefined(level.perk_random_devgui_callback)) {
    self[[level.perk_random_devgui_callback]](cmd);
  }
}

function function_68bd1e17(cmd) {
  if(isDefined(level.perk_random_devgui_callback)) {
    self[[level.perk_random_devgui_callback]](cmd);
  }
}

function function_7565dd74(cmd) {
  if(isDefined(level.perk_random_devgui_callback)) {
    self[[level.perk_random_devgui_callback]](cmd);
  }
}

function function_87979c2c(cmd) {
  if(isDefined(level.perk_random_devgui_callback)) {
    self[[level.perk_random_devgui_callback]](cmd);
  }
}

function function_2cbcab61(cmd) {
  if(isDefined(level.perk_random_devgui_callback)) {
    self[[level.perk_random_devgui_callback]](cmd);
  }
}

function function_18fc6a29(cmd) {
  if(isDefined(level.perk_random_devgui_callback)) {
    self[[level.perk_random_devgui_callback]](cmd);
  }
}

function zombie_devgui_give_powerup(powerup_name, now, origin) {
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

  level thread zm_powerups::specific_powerup_drop(powerup_name, trace[# "position"], undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
}

function zombie_devgui_give_powerup_player(powerup_name, now) {
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
  level thread zm_powerups::specific_powerup_drop(powerup_name, trace[# "position"], undefined, undefined, player);
}

function zombie_devgui_goto_round(target_round) {
  player = getplayers()[0];

  if(target_round < 1) {
    target_round = 1;
  }

  level.devcheater = 1;
  level.zombie_total = 0;
  level.zombie_health = isDefined(level.var_41dd92fd[# "zombie"].health) ? level.var_41dd92fd[# "zombie"].health : 100;
  zm_round_logic::set_round_number(target_round - 1);

  if(isDefined(level.var_e63636af)) {
    [[level.var_e63636af]](target_round - 1);
  }

  level notify(#"kill_round");
  wait 1;
  zombies = getaiteamarray(level.zombie_team);

  if(isDefined(zombies)) {
    for(i = 0; i < zombies.size; i++) {
      if(is_true(zombies[i].ignore_devgui_death)) {
        continue;
      }

      zombies[i] dodamage(zombies[i].health + 666, zombies[i].origin);
    }
  }
}

function zombie_devgui_monkey_round() {
  if(isDefined(level.var_141b0a3a)) {
    zombie_devgui_goto_round(level.var_141b0a3a);
  }
}

function zombie_devgui_thief_round() {
  if(isDefined(level.var_3a35aed4)) {
    zombie_devgui_goto_round(level.var_3a35aed4);
  }
}

function zombie_devgui_dog_round(num_dogs) {
  if(!isDefined(level.var_57c1626e) || !level.var_57c1626e) {
    return;
  }

  if(!isDefined(level.var_a3f67fc2) || !level.var_a3f67fc2) {
    return;
  }

  if(!isDefined(level.enemy_dog_spawns) || level.enemy_dog_spawns.size < 1) {
    return;
  }

  if(!level flag::get("<dev string:xdfa>")) {
    setDvar(#"force_dogs", num_dogs);
  }

  zombie_devgui_goto_round(level.round_number + 1);
}

function zombie_devgui_dog_round_skip() {
  if(isDefined(level.next_dog_round)) {
    zombie_devgui_goto_round(level.next_dog_round);
  }
}

function zombie_devgui_dump_zombie_vars() {
  if(!isDefined(level.zombie_vars)) {
    return;
  }

  if(level.zombie_vars.size > 0) {
    println("<dev string:xe07>");
  } else {
    return;
  }

  var_names = getarraykeys(level.zombie_vars);

  for(i = 0; i < level.zombie_vars.size; i++) {
    key = var_names[i];
    println(key + "<dev string:xe25>" + zombie_utility::get_zombie_var(key));
  }

  println("<dev string:xe2f>");
}

function zombie_devgui_pack_current_weapon() {
  players = getplayers();
  level.devcheater = 1;

  for(i = 0; i < players.size; i++) {
    if(!players[i] laststand::player_is_in_laststand() && players[i].sessionstate !== "<dev string:xe53>") {
      weap = players[i] getcurrentweapon();
      item = players[i] item_inventory::function_230ceec4(weap);
      var_27751b99 = namespace_4b9fccd8::get_pap_level(item);

      if(isDefined(item) && var_27751b99 == 0 && item.networkid != 32767) {
        players[i] item_inventory::function_73ae3380(item, 1);
        continue;
      }

      if(isDefined(item.paplv) && item.paplv < 4) {
        paplevel = item.paplv + 1;
        players[i] item_inventory::function_73ae3380(item, paplevel);
      }
    }
  }
}

function zombie_devgui_repack_current_weapon() {
  players = getplayers();
  level.devcheater = 1;

  for(i = 0; i < players.size; i++) {
    if(!players[i] laststand::player_is_in_laststand() && players[i].sessionstate !== "<dev string:xe53>") {
      weap = players[i] getcurrentweapon();
      item = players[i] item_inventory::function_230ceec4(weap);

      if(isDefined(item.paplv) && item.paplv < 4) {
        paplevel = item.paplv + 1;
        players[i] item_inventory::function_73ae3380(item, paplevel);
      }
    }
  }
}

function zombie_devgui_unpack_current_weapon() {
  players = getplayers();
  level.devcheater = 1;

  for(i = 0; i < players.size; i++) {
    if(!players[i] laststand::player_is_in_laststand() && players[i].sessionstate !== "<dev string:xe53>") {
      weap = players[i] getcurrentweapon();
      item = players[i] item_inventory::function_230ceec4(weap);

      if(isDefined(item.paplv) && item.paplv > 1) {
        paplevel = item.paplv - 1;
        players[i] item_inventory::function_73ae3380(item, paplevel);
        continue;
      }

      if(isDefined(item.itementry) && isDefined(item.itementry.rarity)) {
        rarity = item.itementry.rarity;
      }

      weapon = self weapons::function_251ec78c(weap, 1);
      players[i] zm_weapons::weapon_take(weap);
      weapon = players[i] zm_weapons::give_build_kit_weapon(weapon);
      players[i] zm_weapons::function_7c5dd4bd(weapon);
      players[i] switchtoweapon(weapon);
      players[i] thread function_3594cd6d(rarity);
    }
  }
}

function function_3594cd6d(rarity) {
  if(!isDefined(rarity)) {
    rarity = # "white";
  }

  self endon(#"death");
  self waittill(#"weapon_change_complete");
  wait 1;
  self zm_weapons::function_17e9ed37(rarity);
}

function function_2a5ce9b1(rarity) {
  iprintlnbold("<dev string:xe60>");
}

function function_55c6dedd(str_weapon, xp) {
  if(!str_weapon || !level.onlinegame) {
    return;
  }

  if(0 > xp) {
    xp = 0;
  }

  self stats::set_stat(#"ranked_item_stats", str_weapon, #"xp", xp);
}

function function_335cdac(weapon) {
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

function function_72e79f3b(weapon, var_56c1b8d) {
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

function function_af7d932(weapon) {
  xp = 0;
  gunlevels = function_335cdac(weapon);

  if(gunlevels.size) {
    xp = gunlevels[gunlevels.size - 1];
  }

  return xp;
}

function function_c8949116() {}

function function_9d21f44b() {}

function function_e2a97bab() {}

function function_1a560cfc() {}

function function_c8ee84ba() {}

function function_c83c6fa() {}

function function_cbdab30d(xp) {
  if(self.pers[# "rankxp"] > xp) {
    self.pers[# "rank"] = 0;
    self setrank(0);
    self stats::set_stat(#"playerstatslist", #"rank", #"statvalue", 0);
  }

  self.pers[# "rankxp"] = xp;
  self rank::updaterank();
  self stats::set_stat(#"playerstatslist", #"rank", #"statvalue", self.pers[# "rank"]);
}

function function_5c26ad27(var_56c1b8d) {
  return 0;
}

function function_5da832fa() {
  xp = 0;

  if(isDefined(level.ranktable)) {
    xp = function_5c26ad27(level.ranktable.size - 1);
  }

  return xp;
}

function function_8c9f2dea() {
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

function function_b7ef4b8() {
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

function function_9b4d61fa() {
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

function function_cdc3d061() {
  players = getplayers();
  level.devcheater = 1;

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(!player laststand::player_is_in_laststand()) {
      player function_cbdab30d(0);
    }
  }
}

function zombie_devgui_reopt_current_weapon() {
  players = getplayers();
  reviver = players[0];
  level.devcheater = 1;

  for(i = 0; i < players.size; i++) {
    if(!players[i] laststand::player_is_in_laststand()) {
      weapon = players[i] getcurrentweapon();

      if(isDefined(players[i].pack_a_punch_weapon_options)) {
        players[i].pack_a_punch_weapon_options[weapon] = undefined;
      }

      players[i] zm_weapons::weapon_take(weapon);
      weapon = players[i] zm_weapons::give_build_kit_weapon(weapon);
      players[i] zm_weapons::function_7c5dd4bd(weapon);
      players[i] switchtoweapon(weapon);
    }
  }
}

function zombie_devgui_take_weapon() {
  players = getplayers();
  reviver = players[0];
  level.devcheater = 1;

  for(i = 0; i < players.size; i++) {
    if(!players[i] laststand::player_is_in_laststand()) {
      players[i] zm_weapons::weapon_take(players[i] getcurrentweapon());
      players[i] zm_weapons::switch_back_primary_weapon(undefined);
    }
  }
}

function zombie_devgui_take_weapons(give_fallback) {
  players = getplayers();
  reviver = players[0];
  level.devcheater = 1;

  for(i = 0; i < players.size; i++) {
    if(!players[i] laststand::player_is_in_laststand()) {
      a_weapons = players[i] getweaponslist();

      foreach(weapon in a_weapons) {
        players[i] zm_weapons::weapon_take(weapon);
      }
    }
  }
}

function get_upgrade(weapon) {
  if(isDefined(level.zombie_weapons[weapon]) && isDefined(level.zombie_weapons[weapon].upgrade_name)) {
    return zm_weapons::get_upgrade_weapon(weapon, 0);
  }

  return zm_weapons::get_upgrade_weapon(weapon, 1);
}

function zombie_devgui_director_easy() {
  if(isDefined(level.var_e5cb87fe)) {
    [[level.var_e5cb87fe]]();
  }
}

function zombie_devgui_chest_never_move() {
  level notify(#"devgui_chest_end_monitor");
  level endon(#"devgui_chest_end_monitor");

  for(;;) {
    level.chest_accessed = 0;
    wait 5;
  }
}

function zombie_devgui_disable_kill_thread_toggle() {
  if(!is_true(level.disable_kill_thread)) {
    level.disable_kill_thread = 1;
    return;
  }

  level.disable_kill_thread = 0;
}

function zombie_devgui_check_kill_thread_every_frame_toggle() {
  if(!is_true(level.check_kill_thread_every_frame)) {
    level.check_kill_thread_every_frame = 1;
    return;
  }

  level.check_kill_thread_every_frame = 0;
}

function zombie_devgui_kill_thread_test_mode_toggle() {
  if(!is_true(level.kill_thread_test_mode)) {
    level.kill_thread_test_mode = 1;
    return;
  }

  level.kill_thread_test_mode = 0;
}

function showonespawnpoint(spawn_point, color, notification, height, print) {
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

function print3duntilnotified(origin, text, color, alpha, scale, notification) {
  level endon(notification);

  for(;;) {
    print3d(origin, text, color, alpha, scale);
    waitframe(1);
  }
}

function lineuntilnotified(start, end, color, depthtest, notification) {
  level endon(notification);

  for(;;) {
    line(start, end, color, depthtest);
    waitframe(1);
  }
}

function devgui_debug_hud() {
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
    zombie_devgui_give_powerup("<dev string:xead>", 1, self.origin);
    wait 0.25;
  }

  zombie_devgui_give_powerup("<dev string:xeba>", 1, self.origin);
  wait 0.25;
  zombie_devgui_give_powerup("<dev string:xec8>", 1, self.origin);
  wait 0.25;
  zombie_devgui_give_powerup("<dev string:xed9>", 1, self.origin);
  wait 0.25;
  zombie_devgui_give_powerup("<dev string:xee6>", 1, self.origin);
  wait 0.25;
  zombie_devgui_give_powerup("<dev string:xef1>", 1, self.origin);
  wait 0.25;
}

function zombie_devgui_draw_traversals() {
  if(!isDefined(level.toggle_draw_traversals)) {
    level.toggle_draw_traversals = 1;
    return;
  }

  level.toggle_draw_traversals = !level.toggle_draw_traversals;
}

function zombie_devgui_keyline_always() {
  if(!isDefined(level.toggle_keyline_always)) {
    level.toggle_keyline_always = 1;
    return;
  }

  level.toggle_keyline_always = !level.toggle_keyline_always;
}

function robotsupportsovercover_manager_() {
  if(level flag::get("<dev string:xf01>")) {
    level flag::clear("<dev string:xf01>");
    iprintln("<dev string:xf18>");
    return;
  }

  level flag::set("<dev string:xf01>");
  iprintln("<dev string:xf32>");
}

function function_92523b12() {
  if(!isDefined(level.var_5171ee4a)) {
    level.var_5171ee4a = 1;
    return;
  }

  level.var_5171ee4a = !level.var_5171ee4a;
}

function wait_for_zombie(crawler) {
  nodes = getallnodes();

  while(true) {
    ai = getactorarray();
    zombie = ai[0];

    if(isDefined(zombie)) {
      foreach(node in nodes) {
        if(node.type == # "begin" || node.type == # "end" || node.type == # "bad node") {
          if(isDefined(node.animscript)) {
            zombie setblackboardattribute("<dev string:xf4a>", "<dev string:xf55>");
            zombie setblackboardattribute("<dev string:xf5e>", node.animscript);
            table = "<dev string:xf71>";

            if(is_true(crawler)) {
              table = "<dev string:xf84>";
            }

            if(isDefined(zombie.debug_traversal_ast)) {
              table = zombie.debug_traversal_ast;
            }

            anim_results = zombie astsearch(table);

            if(!isDefined(anim_results[# "animation"])) {
              if(is_true(crawler)) {
                node.bad_crawler_traverse = 1;
              } else {
                node.bad_traverse = 1;
              }

              continue;
            }

            if(anim_results[# "animation"] == "<dev string:xf9f>") {
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

function zombie_draw_traversals() {
  level thread wait_for_zombie();
  level thread wait_for_zombie(1);
  nodes = getallnodes();

  while(true) {
    if(is_true(level.toggle_draw_traversals)) {
      foreach(node in nodes) {
        if(isDefined(node.animscript)) {
          txt_color = (0, 0.8, 0.6);
          circle_color = (1, 1, 1);

          if(is_true(node.bad_traverse)) {
            txt_color = (1, 0, 0);
            circle_color = (1, 0, 0);
          }

          circle(node.origin, 16, circle_color);
          print3d(node.origin, node.animscript, txt_color, 1, 0.5);

          if(is_true(node.bad_crawler_traverse)) {
            print3d(node.origin + (0, 0, -12), "<dev string:xfbb>", (1, 0, 0), 1, 0.5);
          }
        }
      }
    }

    waitframe(1);
  }
}

function function_bbeaa2da() {
  nodes = getallnodes();
  var_43e9aabd = [];

  foreach(node in nodes) {
    if(isDefined(node.animscript) && node.animscript != "<dev string:x38>") {
      var_43e9aabd[node.animscript] = 1;
    }
  }

  var_cb16f0db = getarraykeys(var_43e9aabd);
  sortednames = array::sort_by_value(var_cb16f0db, 1);
  println("<dev string:xfd6>");

  foreach(name in sortednames) {
    println("<dev string:xff4>" + name);
  }

  println("<dev string:x1004>");
}

function function_e9b89aac() {
  while(true) {
    if(isDefined(level.zones) && (getdvarint(#"zombiemode_debug_zones", 0) || getdvarint(#"hash_756b3f2accaa1678", 0))) {
      foreach(zone in level.zones) {
        foreach(node in zone.nodes) {
          node_region = getnoderegion(node);
          var_747013f8 = node.targetname;

          if(isDefined(node_region)) {
            var_747013f8 = node_region + "<dev string:x78>" + node.targetname;
          }

          print3d(node.origin + (0, 0, 12), var_747013f8, (0, 1, 0), 1, 1);
        }
      }
    }

    waitframe(1);
  }
}

function function_e395a714() {
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

function function_2fcf8a4a(notifyhash) {
  if(isDefined(self.var_d35d1d3d)) {
    self.var_d35d1d3d destroy();
    self.var_d35d1d3d = undefined;
  }
}

function function_fb482cad() {
  self notify(#"hash_d592b5d81b7b3a7");
  self endoncallback(&function_2fcf8a4a, #"hash_d592b5d81b7b3a7", #"disconnect");

  while(true) {
    if(!isDefined(self.var_d35d1d3d)) {
      self.var_d35d1d3d = newdebughudelem(self);
      self.var_d35d1d3d.alignx = "<dev string:x1020>";
      self.var_d35d1d3d.horzalign = "<dev string:x1020>";
      self.var_d35d1d3d.aligny = "<dev string:x1028>";
      self.var_d35d1d3d.vertalign = "<dev string:x1032>";
      self.var_d35d1d3d.color = (1, 1, 1);
      self.var_d35d1d3d.alpha = 1;
    }

    debug_text = "<dev string:x38>";

    if(isDefined(self.cached_zone_volume)) {
      debug_text = "<dev string:x1039>";
    } else if(isDefined(self.var_3b65cdd7)) {
      debug_text = "<dev string:x106a>";
    }

    self.var_d35d1d3d settext(debug_text);
    self waittill(#"zone_change");
  }
}

function function_5349e112() {
  if(!isDefined(level.var_1d432d3)) {
    level.var_b086a41a = getEntArray("<dev string:x1097>", "<dev string:x10bc>");
    infovolumedebuginit();
  }

  level.var_1d432d3 = !is_true(level.var_1d432d3);

  if(is_true(level.var_1d432d3)) {
    setDvar(#"g_drawdebuginfovolumes", 1);

    foreach(area in level.var_b086a41a) {
      showinfovolume(area getentitynumber(), (1, 1, 0), 0.5);
    }

    return;
  }

  setDvar(#"g_drawdebuginfovolumes", 0);

  foreach(area in level.var_b086a41a) {
    hideinfovolume(area getentitynumber());
  }
}

function function_8817dd98() {
  while(true) {
    if(is_true(level.var_5171ee4a)) {
      if(!isDefined(level.var_fcfab54a)) {
        level.var_fcfab54a = newdebughudelem();
        level.var_fcfab54a.alignx = "<dev string:x1020>";
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
        if(ai_zombie.zombie_move_speed == "<dev string:x10cb>") {
          zombie_runners++;
        }
      }

      level.var_fcfab54a settext("<dev string:x10d2>" + zombie_count + "<dev string:x10dd>" + zombie_left + "<dev string:x10ec>" + zombie_runners);
    } else if(isDefined(level.var_fcfab54a)) {
      level.var_fcfab54a destroy();
    }

    waitframe(1);
  }
}

function testscriptruntimeerrorassert() {
  wait 1;
  assert(0);
}

function testscriptruntimeerror2() {
  myundefined = "<dev string:x10fb>";

  if(myundefined == 1) {
    println("<dev string:x1103>");
  }
}

function testscriptruntimeerror1() {
  testscriptruntimeerror2();
}

function testscriptruntimeerror() {
  wait 5;

  for(;;) {
    if(getdvarstring(#"scr_testscriptruntimeerror") != "<dev string:x3c>") {
      break;
    }

    wait 1;
  }

  myerror = getdvarstring(#"scr_testscriptruntimeerror");
  setDvar(#"scr_testscriptruntimeerror", "<dev string:x3c>");

  if(myerror == "<dev string:x112c>") {
    testscriptruntimeerrorassert();
  } else {
    testscriptruntimeerror1();
  }

  thread testscriptruntimeerror();
}

function function_f12b8a34() {
  barriers = struct::get_array("<dev string:x1136>", "<dev string:xc95>");

  if(isDefined(level._additional_carpenter_nodes)) {
    barriers = arraycombine(barriers, level._additional_carpenter_nodes, 0, 0);
  }

  foreach(barrier in barriers) {
    if(isDefined(barrier.zbarrier)) {
      a_pieces = barrier.zbarrier getzbarrierpieceindicesinstate("<dev string:x1147>");

      if(isDefined(a_pieces)) {
        for(xx = 0; xx < a_pieces.size; xx++) {
          chunk = a_pieces[xx];
          barrier.zbarrier zbarrierpieceusedefaultmodel(chunk);
          barrier.zbarrier.chunk_health[chunk] = 0;
        }
      }

      for(x = 0; x < barrier.zbarrier getnumzbarrierpieces(); x++) {
        barrier.zbarrier setzbarrierpiecestate(x, "<dev string:x1147>");
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

function function_29dcbd58() {
  var_a6f3b62c = getdvarint(#"hash_1e8ebf0a767981dd", 0);
  return array(array(var_a6f3b62c / 2, 30), array(var_a6f3b62c - 1, 20));
}

function function_3a5618f8() {
  self endon(#"hash_63ae1cb168b8e0d7");
  var_a6f3b62c = getdvarint(#"hash_1e8ebf0a767981dd", 0);
  timescale = getdvarint(#"hash_7438b7c847f3c0", 0);
  var_59ed21fc = function_29dcbd58();
  setDvar(#"runtime_time_scale", timescale);

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

    adddebugcommand("<dev string:x114f>");
    wait 0.2;
  }

  setDvar(#"runtime_time_scale", 1);
}

function function_21f1fbf1() {
  self notify(#"hash_63ae1cb168b8e0d7");
  setDvar(#"runtime_time_scale", 1);
}

function function_1762ff96() {
  level.var_afb69372 = !is_true(self.var_afb69372);

  if(is_true(level.var_afb69372)) {
    level thread function_b7e34647();
    return;
  }

  level notify(#"hash_2876f101dd7375df");
}

function function_b7e34647() {
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
      if(is_true(zombie.need_closest_player)) {
        record3dtext("<dev string:x116b>", zombie.origin + (0, 0, 72), (1, 0, 0));
        continue;
      }

      record3dtext("<dev string:x1182>", zombie.origin + (0, 0, 72), (0, 1, 0));

      if(isDefined(zombie.var_26f25576)) {
        record3dtext(gettime() - zombie.var_26f25576, zombie.origin + (0, 0, 54), (1, 1, 1));
      }
    }

    waitframe(1);
  }
}

function function_1e285ac2() {
  adddebugcommand("<dev string:x1199>");
  adddebugcommand("<dev string:x11eb>");
  adddebugcommand("<dev string:x1234>");
  adddebugcommand("<dev string:x1281>");
  level thread function_c774d870();
}

function function_c774d870() {
  for(;;) {
    wait 0.25;
    cmd = getdvarint(#"hash_5b8785c3d6383b3a", 0);

    if(isDefined(cmd) && cmd == 1) {
      iprintlnbold("<dev string:x12ca>");
      zm::function_1442d44f();
      setDvar(#"hash_5b8785c3d6383b3a", 0);
    }

    cmd = getdvarstring(#"hash_2d9d21912cbffb75");

    if(isDefined(cmd) && cmd == 1) {
      iprintlnbold("<dev string:x12e5>");
      level.gamedifficulty = 0;
      setDvar(#"hash_2d9d21912cbffb75", 0);
      setDvar(#"hash_5b8785c3d6383b3a", 1);
    }

    cmd = getdvarstring(#"hash_2b205a3ab882058c");

    if(isDefined(cmd) && cmd == 1) {
      iprintlnbold("<dev string:x12ed>");
      level.gamedifficulty = 1;
      setDvar(#"hash_2b205a3ab882058c", 0);
      setDvar(#"hash_5b8785c3d6383b3a", 1);
    }

    cmd = getdvarstring(#"hash_393960bacf784966");

    if(isDefined(cmd) && cmd == 1) {
      iprintlnbold("<dev string:x12f7>");
      level.gamedifficulty = 2;
      setDvar(#"hash_393960bacf784966", 0);
      setDvar(#"hash_5b8785c3d6383b3a", 1);
    }
  }
}

function private function_255c7194() {
  player = getplayers()[0];
  queryresult = positionquery_source_navigation(player.origin, 256, 512, 128, 20);

  if(isDefined(queryresult) && queryresult.data.size > 0) {
    return queryresult.data[0];
  }

  return {
    #origin: player.origin
  };
}

function private function_b4dcb9ce() {
  player = getplayers()[0];
  direction = player getplayerangles();
  direction_vec = anglesToForward(direction);
  eye = player getEye();
  scale = 8000;
  direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
  trace = bulletTrace(eye, eye + direction_vec, 0, player);
  return {
    #origin: trace[# "position"]
  };
}

function spawn_archetype(spawner_name) {
  spawners = getspawnerarray(spawner_name, "<dev string:xcc9>");
  spawn_point = function_b4dcb9ce();

  if(spawners.size == 0) {
    iprintln("<dev string:x12ff>" + spawner_name + "<dev string:x1306>");
    return;
  }

  entity = spawners[0] spawnfromspawner(0, 1);

  if(isDefined(entity)) {
    entity forceteleport(spawn_point.origin);
  }
}

function kill_archetype(archetype) {
  enemies = getaiarchetypearray(archetype);

  foreach(enemy in enemies) {
    if(isalive(enemy)) {
      enemy kill();
    }
  }
}

function function_8d799ebd() {
  self notify("<dev string:x1310>");
  self endon("<dev string:x1310>");
  level.devcheater = 1;

  if(!self laststand::player_is_in_laststand()) {
    var_d4073f30 = array::randomize(array(#"shotgun_fullauto_t9", #"tr_fastburst_t9", #"sniper_powersemi_t9", #"lmg_fastfire_t9", #"ar_accurate_t9"));

    foreach(w_primary in self getweaponslistprimaries()) {
      self zm_weapons::weapon_take(w_primary);
    }

    self val::set("<dev string:x1324>", "<dev string:x1334>", 1);

    for(i = 0; i < zm_utility::get_player_weapon_limit(self); i++) {
      str_weapon_name = array::random(var_d4073f30);
      arrayremovevalue(var_d4073f30, str_weapon_name);
      weapon = getweapon(str_weapon_name);
      self zm_weapons::weapon_give(weapon, 1, 0, undefined, undefined, array::random(array(#"orange", #"gold")));

      do {
        s_waitresult = self waittill(#"weapon_change_complete");
      }
      while(self item_inventory::function_a33744de(s_waitresult.weapon) == 32767);

      item = self item_inventory::function_230ceec4(s_waitresult.weapon);

      if(isDefined(item) && item.networkid != 32767) {
        var_2a2c98f2 = self item_inventory::function_73ae3380(item, 1);

        if(isstruct(var_2a2c98f2) && isDefined(var_2a2c98f2.networkid) && var_2a2c98f2.networkid != 32767) {
          self item_inventory::function_73ae3380(var_2a2c98f2, 2);

          if(is_true(level.aat_in_use) && !aat::is_exempt_weapon(var_2a2c98f2.var_627c698b)) {
            str_aat = array::random(array("<dev string:x134e>", "<dev string:x1364>"));
            self zm_weapons::function_37e9e0cb(var_2a2c98f2, weapon, str_aat);
          }
        }
      }
    }

    self val::reset("<dev string:x1324>", "<dev string:x1334>");
    self namespace_dd7e54e3::give_armor(#"armor_item_lv3_t9_sr");
    self namespace_791d0451::function_3fecad82(#"talent_quickrevive");
    self namespace_791d0451::function_3fecad82(#"talent_speedcola");
    self namespace_791d0451::function_3fecad82(#"talent_doubletap");
    self namespace_791d0451::function_3fecad82(#"hash_47d7a8105237c88");
    self namespace_1cc7b406::give_equipment("<dev string:x1378>", 2);
    self namespace_1cc7b406::give_equipment("<dev string:x1396>", 2);
    self namespace_1cc7b406::give_equipment("<dev string:x13b2>", 2);
    self namespace_1cc7b406::give_equipment("<dev string:x13c8>", 2);
  }
}

function function_f298dd5c() {
  if(!isDefined(level.var_9db63456)) {
    level.var_9db63456 = 0;
  }

  if(!isDefined(level.var_9db63456)) {
    level.var_9db63456 = 1;
  }

  level.var_9db63456 = !level.var_9db63456;
}

function function_e5713258() {
  if(is_true(level.var_33571ef1)) {
    level notify(#"hash_147174071dbfe31e");
  } else {
    level thread function_15ee6847();
  }

  level.var_33571ef1 = !is_true(level.var_33571ef1);
}

function function_15ee6847() {
  self notify("<dev string:x13e6>");
  self endon("<dev string:x13e6>");
  level endon(#"hash_147174071dbfe31e");

  while(true) {
    teststring = "<dev string:x38>";

    foreach(player in level.players) {
      teststring += "<dev string:x13fa>" + player getentitynumber() + "<dev string:x1407>";

      if(player.sessionstate == "<dev string:xe53>") {
        teststring += "<dev string:x140d>";
        continue;
      }

      if(is_true(self.hostmigrationcontrolsfrozen)) {
        teststring += "<dev string:x1423>";
        continue;
      }

      if(player zm_player::in_life_brush()) {
        teststring += "<dev string:x1442>";
        continue;
      }

      if(player zm_player::in_kill_brush()) {
        teststring += "<dev string:x1457>";
        continue;
      }

      if(!player zm_player::in_enabled_playable_area()) {
        teststring += "<dev string:x146c>";
        continue;
      }

      if(isDefined(level.player_out_of_playable_area_override) && !is_true(player[[level.player_out_of_playable_area_override]]())) {
        teststring += "<dev string:x14a0>";
        continue;
      }

      teststring += "<dev string:x14d9>";
    }

    debug2dtext((400, 100, 0), teststring, (1, 1, 0), undefined, (0, 0, 0), 0.75, 1, 1);
    waitframe(1);
  }
}

function function_2f0c6f91() {
  if(!isDefined(level.var_df7f30f4)) {
    level.var_df7f30f4 = 0;
  }

  level.var_df7f30f4 = level.var_df7f30f4 == 0 ? 1 : 0;

  if(!level.var_df7f30f4) {
    level notify(#"hash_21adc62fc2f5bc32");
    return;
  }

  level thread function_5ec967f7();
}

function function_1a4752d0() {
  if(!isDefined(level.var_d13a2c74)) {
    level.var_d13a2c74 = 0;
  }

  foreach(location in level.contentmanager.locations) {
    if(isDefined(location.instances[# "wallbuy"])) {
      if(isarray(location.instances[# "wallbuy"].contentgroups[# "wallbuy_chalk"])) {
        var_d82a99e8 = location.instances[# "wallbuy"].contentgroups[# "wallbuy_chalk"][level.var_d13a2c74];
        player = getplayers()[0];
        forward = anglestoright(var_d82a99e8.angles);
        forward = vectornormalize(forward);
        forward = (forward[0] * 64, forward[1] * 64, forward[2] * 64);
        var_92f819ac = var_d82a99e8.origin + forward;
        player setorigin(var_92f819ac);
        level.var_d13a2c74++;

        if(level.var_d13a2c74 >= location.instances[# "wallbuy"].contentgroups[# "wallbuy_chalk"].size) {
          level.var_d13a2c74 = level.var_d13a2c74 >= location.instances[# "wallbuy"].contentgroups[# "wallbuy_chalk"].size - 1;
        }
      }
    }
  }
}

function function_5ec967f7() {
  level endon(#"hash_21adc62fc2f5bc32");

  while(true) {
    foreach(location in level.contentmanager.locations) {
      if(isDefined(location.instances[# "wallbuy"])) {
        if(isarray(location.instances[# "wallbuy"].contentgroups[# "wallbuy_chalk"])) {
          foreach(wallbuy in location.instances[# "wallbuy"].contentgroups[# "wallbuy_chalk"]) {
            player = getplayers()[0];

            if(player util::is_looking_at(wallbuy.origin)) {
              sphere(wallbuy.origin, 32, (1, 0, 0), 1, 0, 10, 10);
            }
          }
        }
      }
    }

    waitframe(1);
  }
}

function function_26417ea7() {
  level.var_565d6ce0 = !is_true(level.var_565d6ce0);
}

function function_fb88b423() {
  zombies = getaiarray();

  foreach(zombie in zombies) {
    zombie zombie_utility::setup_zombie_knockdown(level.players[0]);
  }
}

function init_debug_center_screen() {
  waitframe(1);
  setDvar(#"debug_center_screen", 0);
  level flag::wait_till("<dev string:xbd>");
  zero_idle_movement = 0;
  devgui_base = "<dev string:x14f7>";
  adddebugcommand(devgui_base + "<dev string:x150e>" + "<dev string:x153e>" + "<dev string:x1555>");

  for(;;) {
    if(getdvarint(#"debug_center_screen", 0)) {
      if(!isDefined(level.center_screen_debug_hudelem_active) || level.center_screen_debug_hudelem_active == 0) {
        thread debug_center_screen();
        zero_idle_movement = getdvarint(#"zero_idle_movement", 0);

        if(zero_idle_movement == 0) {
          setDvar(#"zero_idle_movement", 1);
          zero_idle_movement = 1;
        }
      }
    } else {
      level notify(#"stop center screen debug");

      if(zero_idle_movement == 1) {
        setDvar(#"zero_idle_movement", 0);
        zero_idle_movement = 0;
      }
    }

    wait 0.5;
  }
}

function debug_center_screen() {
  level.center_screen_debug_hudelem_active = 1;
  wait 0.1;
  level.center_screen_debug_hudelem1 = newdebughudelem(level.players[0]);
  level.center_screen_debug_hudelem1.alignx = "<dev string:x1560>";
  level.center_screen_debug_hudelem1.aligny = "<dev string:x1028>";
  level.center_screen_debug_hudelem1.fontscale = 1;
  level.center_screen_debug_hudelem1.alpha = 0.5;
  level.center_screen_debug_hudelem1.x = 320 - 1;
  level.center_screen_debug_hudelem1.y = 240;
  level.center_screen_debug_hudelem1 setshader("<dev string:x156a>", 1000, 1);
  level.center_screen_debug_hudelem2 = newdebughudelem(level.players[0]);
  level.center_screen_debug_hudelem2.alignx = "<dev string:x1560>";
  level.center_screen_debug_hudelem2.aligny = "<dev string:x1028>";
  level.center_screen_debug_hudelem2.fontscale = 1;
  level.center_screen_debug_hudelem2.alpha = 0.5;
  level.center_screen_debug_hudelem2.x = 320 - 1;
  level.center_screen_debug_hudelem2.y = 240;
  level.center_screen_debug_hudelem2 setshader("<dev string:x156a>", 1, 480);
  level waittill(#"stop center screen debug");
  level.center_screen_debug_hudelem1 destroy();
  level.center_screen_debug_hudelem2 destroy();
  level.center_screen_debug_hudelem_active = 0;
}

function function_b5d522f8() {
  self notify("<dev string:x1573>");
  self endon("<dev string:x1573>");
  function_7c9dd642();
  setDvar(#"hash_46eec505e691414c", "<dev string:x38>");
  setDvar(#"hash_74f1952a0f93d08e", -1);

  while(true) {
    wait 0.1;
    var_9261da43 = getDvar(#"hash_46eec505e691414c", "<dev string:x38>");
    var_10acd4fa = getDvar(#"hash_74f1952a0f93d08e", -1);

    if(var_9261da43 == "<dev string:x38>" && var_10acd4fa == -1) {
      continue;
    }

    player = level.players[0];

    if(isPlayer(player)) {
      if(var_9261da43 != "<dev string:x38>") {
        args = strtok(var_9261da43, "<dev string:x1587>");
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

    setDvar(#"hash_46eec505e691414c", "<dev string:x38>");
    setDvar(#"hash_74f1952a0f93d08e", -1);
  }
}

function function_7c9dd642() {
  while(!isDefined(level.var_a16c38d9)) {
    wait 0.1;
  }

  path = "<dev string:x158c>";
  cmd = "<dev string:x159d>";
  keys = getarraykeys(level.var_a16c38d9);

  foreach(key in keys) {
    mapping = level.var_a16c38d9[key];
    num = pow(2, mapping.numbits);

    for(i = 0; i < num; i++) {
      cmdarg = function_9e72a96(key) + "<dev string:x1587>" + i;
      util::add_devgui(path + function_9e72a96(key) + "<dev string:x15c2>" + i, cmd + cmdarg);
    }
  }

  var_30a96cf9 = "<dev string:x15ce>";
  cmd = "<dev string:x15f3>";
  util::add_devgui(var_30a96cf9 + "<dev string:x1618>", cmd + 1);
  util::add_devgui(var_30a96cf9 + "<dev string:x162f>", cmd + 0);
}

function bunker_entrance_zoned() {
  self notify("<dev string:x1647>");
  self endon("<dev string:x1647>");

  if(getdvarint(#"hash_4cebb1d3b0ee545a", 0) == 0) {
    setDvar(#"hash_4cebb1d3b0ee545a", 1);
  } else {
    setDvar(#"hash_4cebb1d3b0ee545a", 0);
    return;
  }

  a_s_key = struct::get_array(1, "<dev string:x165b>");
  a_e_all = getentitiesinradius((0, 0, 0), 640000);
  a_e_key = [];

  foreach(ent in a_e_all) {
    if(is_true(ent.var_61330f48)) {
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

function function_1b531660() {
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

function function_e7321799(params) {
  damage = params.idamage;
  location = params.vpoint;
  target = self;
  smeansofdeath = params.smeansofdeath;

  if(smeansofdeath == "<dev string:x1669>" || smeansofdeath == "<dev string:x1678>") {
    location = self.origin + (0, 0, 60);
  }

  if(damage) {
    thread function_2cde0af9("<dev string:x1587>" + damage, (1, 1, 1), location, (randomfloatrange(-1, 1), randomfloatrange(-1, 1), 2), 30);
  }
}

function function_2cde0af9(text, color, start, velocity, frames) {
  location = start;
  alpha = 1;

  for(i = 0; i < frames; i++) {
    print3d(location, text, color, alpha, 0.6, 1);
    location += velocity;
    alpha -= 1 / frames * 2;
    waitframe(1);
  }
}

function function_1bb72156() {
  level_name = util::get_map_name();

  if(level_name == "<dev string:x168e>") {
    return;
  }

  weapon = self getcurrentweapon();
  namespace_b376a999::function_96db9f3(weapon, 10000);
}

function function_f1be4492(dvar) {
  if(dvar.value) {
    level thread function_62e3e0a();
    return;
  }

  level notify(#"hash_49dd681f2dd51383");
}

function private function_62e3e0a() {
  self notify("<dev string:x1699>");
  self endon("<dev string:x1699>");
  level endon(#"hash_49dd681f2dd51383");

  while(!isDefined(level.zm_loc_types)) {
    waitframe(1);
  }

  while(true) {
    waitframe(1);
    player = getplayers()[0];
    player_vec = vectornormalize(anglesToForward(player getplayerangles()));
    player_vec_2d = (player_vec[0], player_vec[1], 0);

    foreach(key, array in level.zm_loc_types) {
      color = (1, 1, 1);
      var_10623ec8 = function_9e72a96(key);

      if(key == # "zombie_location") {
        color = (1, 0, 0);
      }

      foreach(spot in array) {
        player_spawn = vectornormalize(spot.origin - player.origin);
        player_spawn_2d = (player_spawn[0], player_spawn[1], 0);
        dot = vectordot(player_vec_2d, player_spawn_2d);
        dist = distance(spot.origin, player.origin);

        if(dot > 0.707 && dist <= getdvarint(#"scr_zombie_spawn_in_view_dist", 0)) {
          color = (0, 1, 0);
        }

        debugstar(spot.origin, 1, color, var_10623ec8, 0.75);
      }
    }
  }
}
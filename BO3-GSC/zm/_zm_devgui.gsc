/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_devgui.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\aat_shared;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\zombie_death;
#using scripts\shared\ai\zombie_shared;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\demo_shared;
#using scripts\shared\dev_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\popups_shared;
#using scripts\shared\rank_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_rat;
#using scripts\zm\_util;
#using scripts\zm\_zm;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_placeable_mine;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_turned;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace zm_devgui;

function autoexec __init__sytem__() {
  system::register("", &__init__, &__main__, undefined);
}

function __init__() {
  setDvar("", "");
  setDvar("", "");
  setDvar("", "");
  setDvar("", "");
  setDvar("", "");
  setDvar("", "");
  level.devgui_add_weapon = &devgui_add_weapon;
  level.devgui_add_ability = &devgui_add_ability;
  level thread zombie_devgui_think();
  thread zombie_weapon_devgui_think();
  thread function_315fab2d();
  thread devgui_zombie_healthbar();
  thread devgui_test_chart_think();
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  level thread dev::body_customization_devgui(0);
  thread testscriptruntimeerror();
  callback::on_connect(&player_on_connect);
}

function __main__() {
  level thread zombie_devgui_player_commands();
  level thread zombie_devgui_validation_commands();
  level thread zombie_draw_traversals();
  level thread function_1d21f4f();
}

function zombie_devgui_player_commands() {}

function player_on_connect() {
  level flag::wait_till("");
  wait(1);
  if(isDefined(self)) {
    zombie_devgui_player_menu(self);
  }
}

function zombie_devgui_player_menu_clear(playername) {
  rootclear = ("" + playername) + "";
  adddebugcommand(rootclear);
}

function zombie_devgui_player_menu(player) {
  zombie_devgui_player_menu_clear(player.name);
  ip1 = player getentitynumber() + 1;
  adddebugcommand(((((("" + player.name) + "") + ip1) + "") + ip1) + "");
  adddebugcommand(((((("" + player.name) + "") + ip1) + "") + ip1) + "");
  adddebugcommand(((((("" + player.name) + "") + ip1) + "") + ip1) + "");
  adddebugcommand(((((("" + player.name) + "") + ip1) + "") + ip1) + "");
  adddebugcommand(((((("" + player.name) + "") + ip1) + "") + ip1) + "");
  adddebugcommand(((((("" + player.name) + "") + ip1) + "") + ip1) + "");
  adddebugcommand(((((("" + player.name) + "") + ip1) + "") + ip1) + "");
  adddebugcommand(((((("" + player.name) + "") + ip1) + "") + ip1) + "");
  adddebugcommand(((((("" + player.name) + "") + ip1) + "") + ip1) + "");
  adddebugcommand(((((("" + player.name) + "") + ip1) + "") + ip1) + "");
  adddebugcommand(((((("" + player.name) + "") + ip1) + "") + ip1) + "");
  adddebugcommand(((((("" + player.name) + "") + ip1) + "") + ip1) + "");
  if(isDefined(level.var_e26adf8d)) {
    level thread[[level.var_e26adf8d]](player, ip1);
  }
  self thread zombie_devgui_player_menu_clear_on_disconnect(player);
}

function zombie_devgui_player_menu_clear_on_disconnect(player) {
  playername = player.name;
  player waittill("disconnect");
  zombie_devgui_player_menu_clear(playername);
}

function zombie_devgui_validation_commands() {
  setDvar("", "");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  while(true) {
    cmd = getdvarstring("");
    if(cmd != "") {
      switch (cmd) {
        case "": {
          zombie_spawner_validation();
          break;
        }
        case "": {
          if(!isDefined(level.toggle_zone_adjacencies_validation)) {
            level.toggle_zone_adjacencies_validation = 1;
          } else {
            level.toggle_zone_adjacencies_validation = !level.toggle_zone_adjacencies_validation;
          }
          thread zone_adjacencies_validation();
          break;
        }
        case "": {
          thread zombie_pathing_validation();
        }
        default: {
          break;
        }
      }
      setDvar("", "");
    }
    util::wait_network_frame();
  }
}

function zombie_spawner_validation() {
  level.validation_errors_count = 0;
  if(!isDefined(level.var_3d3b24de)) {
    level.var_3d3b24de = 1;
    zombie_devgui_open_sesame();
    spawner = level.zombie_spawners[0];
    enemy = undefined;
    foreach(zone in level.zones) {
      foreach(spawn_point in zone.a_loc_types[""]) {
        if(!isDefined(zone.a_loc_types[""]) || zone.a_loc_types[""].size <= 0) {
          level.validation_errors_count++;
          thread drawvalidation(spawn_point.origin, spawn_point.zone_name);
          println("" + spawn_point.zone_name);
          iprintlnbold("" + spawn_point.zone_name);
          break;
        }
        if(!isDefined(enemy)) {
          enemy = zombie_utility::spawn_zombie(spawner, spawner.targetname, spawn_point);
        }
        node = undefined;
        spawn_point_origin = spawn_point.origin;
        if(isDefined(spawn_point.script_string) && spawn_point.script_string != "") {
          spawn_point_origin = enemy validate_to_board(spawn_point, spawn_point_origin);
        }
        new_spawn_point_origin = getclosestpointonnavmesh(spawn_point_origin, 40, 30);
        if(!isDefined(new_spawn_point_origin)) {
          new_spawn_point_origin = getclosestpointonnavmesh(spawn_point_origin, 100, 30);
          if(!isDefined(new_spawn_point_origin)) {
            level.validation_errors_count++;
            thread drawvalidation(spawn_point_origin);
          }
        }
        ispath = enemy validate_to_wait_point(zone, new_spawn_point_origin, spawn_point);
      }
    }
    println("" + level.validation_errors_count);
    iprintlnbold("" + level.validation_errors_count);
    level.validation_errors_count = undefined;
  } else {
    level.var_3d3b24de = !level.var_3d3b24de;
  }
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
      thread drawvalidation(spawn_point_origin_backup, undefined, undefined, node.origin);
      println((("" + spawn_point_origin_backup) + "") + spawn_point.targetname);
      iprintlnbold((("" + spawn_point_origin_backup) + "") + spawn_point.targetname);
    }
    nodeforward = anglesToForward(node.angles);
    nodeforward = vectornormalize(nodeforward);
    spawn_point_origin = node.origin + (nodeforward * 100);
    return spawn_point_origin;
  }
  return spawn_point_origin_backup;
}

function validate_to_wait_point(zone, new_spawn_point_origin, spawn_point) {
  foreach(loc in zone.a_loc_types[""]) {
    if(isDefined(loc)) {
      wait_point = loc.origin;
      if(isDefined(wait_point)) {
        new_wait_point = getclosestpointonnavmesh(wait_point, 40, 30);
        if(!isDefined(new_wait_point)) {
          new_wait_point = getclosestpointonnavmesh(wait_point, 100, 30);
        }
        if(isDefined(new_spawn_point_origin) && isDefined(new_wait_point)) {
          ispath = self canpath(new_spawn_point_origin, new_wait_point);
          if(ispath) {
            return true;
          }
          level.validation_errors_count++;
          thread drawvalidation(new_spawn_point_origin, undefined, new_wait_point);
          println((("" + new_spawn_point_origin) + "") + spawn_point.targetname);
          iprintlnbold((("" + new_spawn_point_origin) + "") + spawn_point.targetname);
          return false;
        }
      }
    }
  }
  return false;
}

function drawvalidation(origin, zone_name, nav_mesh_wait_point, boards_point) {
  if(!isDefined(zone_name)) {
    zone_name = undefined;
  }
  if(!isDefined(nav_mesh_wait_point)) {
    nav_mesh_wait_point = undefined;
  }
  if(!isDefined(boards_point)) {
    boards_point = undefined;
  }
  while(true) {
    if(isDefined(level.var_3d3b24de) && level.var_3d3b24de) {
      if(!isDefined(origin)) {
        break;
      }
      if(isDefined(zone_name)) {
        circle(origin, 32, (1, 0, 0));
        print3d(origin, "" + zone_name, (1, 1, 1), 1, 0.5);
      } else {
        if(isDefined(nav_mesh_wait_point)) {
          circle(origin, 32, (0, 0, 1));
          print3d(origin, "" + origin, (1, 1, 1), 1, 0.5);
          line(origin, nav_mesh_wait_point, (1, 0, 0));
          circle(nav_mesh_wait_point, 32, (1, 0, 0));
          print3d(nav_mesh_wait_point, "" + nav_mesh_wait_point, (1, 1, 1), 1, 0.5);
        } else {
          if(isDefined(boards_point)) {
            circle(origin, 32, (0, 0, 1));
            print3d(origin, "" + origin, (1, 1, 1), 1, 0.5);
            line(origin, boards_point, (1, 0, 0));
            circle(boards_point, 32, (1, 0, 0));
            print3d(boards_point, "" + boards_point, (1, 1, 1), 1, 0.5);
          } else {
            circle(origin, 32, (0, 0, 1));
            print3d(origin, "" + origin, (1, 1, 1), 1, 0.5);
          }
        }
      }
    }
    wait(0.05);
  }
}

function zone_adjacencies_validation() {
  zombie_devgui_open_sesame();
  while(true) {
    if(isDefined(level.toggle_zone_adjacencies_validation) && level.toggle_zone_adjacencies_validation) {
      if(!isDefined(getplayers()[0].zone_name)) {
        wait(0.05);
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
            offset = offset + 10;
            draw_zone_adjacencies_validation(level.zones[key], 1, key, level.zones[str_zone], offset);
          } else {
            draw_zone_adjacencies_validation(level.zones[key], 0, key);
          }
          continue;
        }
        draw_zone_adjacencies_validation(level.zones[key], 0, key);
      }
    }
    wait(0.05);
  }
}

function draw_zone_adjacencies_validation(zone, status, name, current_zone, offset) {
  if(!isDefined(current_zone)) {
    current_zone = undefined;
  }
  if(!isDefined(offset)) {
    offset = 0;
  }
  if(!isDefined(zone.volumes[0])) {
    return;
  }
  if(status == 2) {
    circle(zone.volumes[0].origin, 30, (0, 1, 0));
    print3d(zone.volumes[0].origin, name, (0, 1, 0), 1, 0.5);
  } else {
    if(status == 1) {
      circle(zone.volumes[0].origin, 30, (0, 0, 1));
      print3d(zone.volumes[0].origin, name, (0, 0, 1), 1, 0.5);
      print3d(current_zone.volumes[0].origin + (0, 20, offset * -1), name, (0, 0, 1), 1, 0.5);
    } else {
      circle(zone.volumes[0].origin, 30, (1, 0, 0));
      print3d(zone.volumes[0].origin, name, (1, 0, 0), 1, 0.5);
    }
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
  setDvar("", 0);
  zombie_devgui_goto_round(20);
  wait(2);
  spawner = level.zombie_spawners[0];
  slums_station = (808, -1856, 544);
  enemy = zombie_utility::spawn_zombie(spawner, spawner.targetname);
  wait(1);
  while(isDefined(enemy) && enemy.completed_emerging_into_playable_area !== 1) {
    wait(0.05);
  }
  if(isDefined(enemy)) {
    enemy forceteleport(slums_station);
    enemy.b_ignore_cleanup = 1;
  }
}

function function_300fe60f(weapon_name, up, root) {
  rootslash = "";
  if(isDefined(root) && root.size) {
    rootslash = root + "";
  }
  uppath = "" + up;
  if(up.size < 1) {
    uppath = "";
  }
  cmd = ((((("" + rootslash) + weapon_name) + uppath) + "") + weapon_name) + "";
  adddebugcommand(cmd);
}

function devgui_add_weapon_entry(weapon_name, up, root) {
  rootslash = "";
  if(isDefined(root) && root.size) {
    rootslash = root + "";
  }
  uppath = "" + up;
  if(up.size < 1) {
    uppath = "";
  }
  cmd = ((((("" + rootslash) + weapon_name) + uppath) + "") + weapon_name) + "";
  adddebugcommand(cmd);
}

function devgui_add_weapon_and_attachments(weapon_name, up, root) {
  devgui_add_weapon_entry(weapon_name, up, root);
}

function devgui_add_weapon(weapon, upgrade, hint, cost, weaponvo, weaponvoresp, ammo_cost) {
  function_300fe60f(weapon.name, "", "");
  if(zm_utility::is_offhand_weapon(weapon) && !zm_utility::is_melee_weapon(weapon)) {
    return;
  }
  if(!isDefined(level.devgui_weapons_added)) {
    level.devgui_weapons_added = 0;
  }
  level.devgui_weapons_added++;
  if(zm_utility::is_melee_weapon(weapon)) {
    devgui_add_weapon_and_attachments(weapon.name, "", "");
  } else {
    devgui_add_weapon_and_attachments(weapon.name, "", "");
  }
}

function function_315fab2d() {
  level.zombie_devgui_gun = getdvarstring("");
  for(;;) {
    wait(0.1);
    cmd = getdvarstring("");
    if(isDefined(cmd) && cmd.size > 0) {
      level.zombie_devgui_gun = cmd;
      players = getplayers();
      if(players.size >= 1) {
        players[0] thread zombie_devgui_weapon_give(level.zombie_devgui_gun);
      }
      setDvar("", "");
    }
    wait(0.1);
    cmd = getdvarstring("");
    if(isDefined(cmd) && cmd.size > 0) {
      level.zombie_devgui_gun = cmd;
      players = getplayers();
      if(players.size >= 2) {
        players[1] thread zombie_devgui_weapon_give(level.zombie_devgui_gun);
      }
      setDvar("", "");
    }
    wait(0.1);
    cmd = getdvarstring("");
    if(isDefined(cmd) && cmd.size > 0) {
      level.zombie_devgui_gun = cmd;
      players = getplayers();
      if(players.size >= 3) {
        players[2] thread zombie_devgui_weapon_give(level.zombie_devgui_gun);
      }
      setDvar("", "");
    }
    wait(0.1);
    cmd = getdvarstring("");
    if(isDefined(cmd) && cmd.size > 0) {
      level.zombie_devgui_gun = cmd;
      players = getplayers();
      if(players.size >= 4) {
        players[3] thread zombie_devgui_weapon_give(level.zombie_devgui_gun);
      }
      setDvar("", "");
    }
  }
}

function zombie_weapon_devgui_think() {
  level.zombie_devgui_gun = getdvarstring("");
  level.zombie_devgui_att = getdvarstring("");
  for(;;) {
    wait(0.25);
    cmd = getdvarstring("");
    if(isDefined(cmd) && cmd.size > 0) {
      level.zombie_devgui_gun = cmd;
      array::thread_all(getplayers(), &zombie_devgui_weapon_give, level.zombie_devgui_gun);
      setDvar("", "");
    }
    wait(0.25);
    att = getdvarstring("");
    if(isDefined(att) && att.size > 0) {
      level.zombie_devgui_att = att;
      array::thread_all(getplayers(), &zombie_devgui_attachment_give, level.zombie_devgui_att);
      setDvar("", "");
    }
  }
}

function zombie_devgui_weapon_give(weapon_name) {
  weapon = getweapon(weapon_name);
  self zm_weapons::weapon_give(weapon, zm_weapons::is_weapon_upgraded(weapon), 0);
}

function zombie_devgui_attachment_give(attachment) {
  weapon = self getcurrentweapon();
  weapon = getweapon(weapon.rootweapon.name, attachment);
  self zm_weapons::weapon_give(weapon, zm_weapons::is_weapon_upgraded(weapon), 0);
}

function devgui_add_ability(name, upgrade_active_func, stat_name, stat_desired_value, game_end_reset_if_not_achieved) {
  online_game = sessionmodeisonlinegame();
  if(!online_game) {
    return;
  }
  if(!(isDefined(level.devgui_watch_abilities) && level.devgui_watch_abilities)) {
    cmd = "";
    adddebugcommand(cmd);
    cmd = "";
    adddebugcommand(cmd);
    level thread zombie_ability_devgui_think();
    level.devgui_watch_abilities = 1;
  }
  cmd = ((("" + name) + "") + name) + "";
  adddebugcommand(cmd);
  cmd = ((("" + name) + "") + name) + "";
  adddebugcommand(cmd);
}

function zombie_devgui_ability_give(name) {
  pers_upgrade = level.pers_upgrades[name];
  if(isDefined(pers_upgrade)) {
    for(i = 0; i < pers_upgrade.stat_names.size; i++) {
      stat_name = pers_upgrade.stat_names[i];
      stat_value = pers_upgrade.stat_desired_values[i];
      self zm_stats::set_global_stat(stat_name, stat_value);
      self.pers_upgrade_force_test = 1;
    }
  }
}

function zombie_devgui_ability_take(name) {
  pers_upgrade = level.pers_upgrades[name];
  if(isDefined(pers_upgrade)) {
    for(i = 0; i < pers_upgrade.stat_names.size; i++) {
      stat_name = pers_upgrade.stat_names[i];
      stat_value = 0;
      self zm_stats::set_global_stat(stat_name, stat_value);
      self.pers_upgrade_force_test = 1;
    }
  }
}

function zombie_ability_devgui_think() {
  level.zombie_devgui_give_ability = getdvarstring("");
  level.zombie_devgui_take_ability = getdvarstring("");
  for(;;) {
    wait(0.25);
    cmd = getdvarstring("");
    if(!isDefined(level.zombie_devgui_give_ability) || level.zombie_devgui_give_ability != cmd) {
      if(cmd == "") {
        level flag::set("");
      } else {
        if(cmd == "") {
          level flag::clear("");
        } else {
          level.zombie_devgui_give_ability = cmd;
          array::thread_all(getplayers(), &zombie_devgui_ability_give, level.zombie_devgui_give_ability);
        }
      }
    }
    wait(0.25);
    cmd = getdvarstring("");
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
  text = "" + int(self.health);
  print3d(self.origin + (0, 0, 0), text, color, 1, 0.5, 1);
}

function devgui_zombie_healthbar() {
  while(true) {
    if(getdvarint("") == 1) {
      lp = getplayers()[0];
      zombies = getaispeciesarray("", "");
      if(isDefined(zombies)) {
        foreach(zombie in zombies) {
          zombie zombie_healthbar(lp.origin, 360000);
        }
      }
    }
    wait(0.05);
  }
}

function zombie_devgui_watch_input() {
  level flag::wait_till("");
  wait(1);
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    players[i] thread watch_debug_input();
  }
}

function damage_player() {
  self disableinvulnerability();
  self dodamage(self.health / 2, self.origin);
}

function kill_player() {
  self disableinvulnerability();
  death_from = (randomfloatrange(-20, 20), randomfloatrange(-20, 20), randomfloatrange(-20, 20));
  self dodamage(self.health + 666, self.origin + death_from);
}

function force_drink() {
  wait(0.01);
  lean = self allowlean(0);
  ads = self allowads(0);
  sprint = self allowsprint(0);
  crouch = self allowcrouch(1);
  prone = self allowprone(0);
  melee = self allowmelee(0);
  self zm_utility::increment_is_drinking();
  orgweapon = self getcurrentweapon();
  build_weapon = getweapon("");
  self giveweapon(build_weapon);
  self switchtoweapon(build_weapon);
  self.build_time = self.usetime;
  self.build_start_time = gettime();
  wait(2);
  self zm_weapons::switch_back_primary_weapon(orgweapon);
  self takeweapon(build_weapon);
  if(isDefined(self.is_drinking) && self.is_drinking) {
    self zm_utility::decrement_is_drinking();
  }
  self allowlean(lean);
  self allowads(ads);
  self allowsprint(sprint);
  self allowprone(prone);
  self allowcrouch(crouch);
  self allowmelee(melee);
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
  self endon("disconnect");
  self notify("watch_debug_input");
  self endon("watch_debug_input");
  level.devgui_dpad_watch = 0;
  if(isDefined(callback)) {
    level.devgui_dpad_watch = 1;
    for(;;) {
      if(self actionslottwobuttonpressed()) {
        self thread[[callback]]();
        while(self actionslottwobuttonpressed()) {
          wait(0.05);
        }
      }
      wait(0.05);
    }
  }
}

function zombie_devgui_think() {
  level notify("zombie_devgui_think");
  level endon("zombie_devgui_think");
  for(;;) {
    cmd = getdvarstring("");
    switch (cmd) {
      case "": {
        players = getplayers();
        array::thread_all(players, &zombie_devgui_give_money);
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 1) {
          players[0] thread zombie_devgui_give_money();
        }
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 2) {
          players[1] thread zombie_devgui_give_money();
        }
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 3) {
          players[2] thread zombie_devgui_give_money();
        }
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 4) {
          players[3] thread zombie_devgui_give_money();
        }
        break;
      }
      case "": {
        players = getplayers();
        array::thread_all(players, &zombie_devgui_take_money);
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 1) {
          players[0] thread zombie_devgui_take_money();
        }
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 2) {
          players[1] thread zombie_devgui_take_money();
        }
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 3) {
          players[2] thread zombie_devgui_take_money();
        }
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 4) {
          players[3] thread zombie_devgui_take_money();
        }
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 1) {
          players[0] thread zombie_devgui_give_xp(1000);
        }
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 2) {
          players[1] thread zombie_devgui_give_xp(1000);
        }
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 3) {
          players[2] thread zombie_devgui_give_xp(1000);
        }
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 4) {
          players[3] thread zombie_devgui_give_xp(1000);
        }
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 1) {
          players[0] thread zombie_devgui_give_xp(10000);
        }
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 2) {
          players[1] thread zombie_devgui_give_xp(10000);
        }
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 3) {
          players[2] thread zombie_devgui_give_xp(10000);
        }
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 4) {
          players[3] thread zombie_devgui_give_xp(10000);
        }
        break;
      }
      case "": {
        array::thread_all(getplayers(), &zombie_devgui_give_health);
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 1) {
          players[0] thread zombie_devgui_give_health();
        }
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 2) {
          players[1] thread zombie_devgui_give_health();
        }
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 3) {
          players[2] thread zombie_devgui_give_health();
        }
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 4) {
          players[3] thread zombie_devgui_give_health();
        }
        break;
      }
      case "": {
        array::thread_all(getplayers(), &zombie_devgui_low_health);
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 1) {
          players[0] thread zombie_devgui_low_health();
        }
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 2) {
          players[1] thread zombie_devgui_low_health();
        }
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 3) {
          players[2] thread zombie_devgui_low_health();
        }
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 4) {
          players[3] thread zombie_devgui_low_health();
        }
        break;
      }
      case "": {
        array::thread_all(getplayers(), &zombie_devgui_toggle_ammo);
        break;
      }
      case "": {
        array::thread_all(getplayers(), &zombie_devgui_toggle_ignore);
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 1) {
          players[0] thread zombie_devgui_toggle_ignore();
        }
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 2) {
          players[1] thread zombie_devgui_toggle_ignore();
        }
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 3) {
          players[2] thread zombie_devgui_toggle_ignore();
        }
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 4) {
          players[3] thread zombie_devgui_toggle_ignore();
        }
        break;
      }
      case "": {
        zombie_devgui_invulnerable(undefined, 1);
        break;
      }
      case "": {
        zombie_devgui_invulnerable(undefined, 0);
        break;
      }
      case "": {
        zombie_devgui_invulnerable(0, 1);
        break;
      }
      case "": {
        zombie_devgui_invulnerable(0, 0);
        break;
      }
      case "": {
        zombie_devgui_invulnerable(1, 1);
        break;
      }
      case "": {
        zombie_devgui_invulnerable(1, 0);
        break;
      }
      case "": {
        zombie_devgui_invulnerable(2, 1);
        break;
      }
      case "": {
        zombie_devgui_invulnerable(2, 0);
        break;
      }
      case "": {
        zombie_devgui_invulnerable(3, 1);
        break;
      }
      case "": {
        zombie_devgui_invulnerable(3, 0);
        break;
      }
      case "": {
        array::thread_all(getplayers(), &zombie_devgui_revive);
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 1) {
          players[0] thread zombie_devgui_revive();
        }
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 2) {
          players[1] thread zombie_devgui_revive();
        }
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 3) {
          players[2] thread zombie_devgui_revive();
        }
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 4) {
          players[3] thread zombie_devgui_revive();
        }
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 1) {
          players[0] thread zombie_devgui_kill();
        }
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 2) {
          players[1] thread zombie_devgui_kill();
        }
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 3) {
          players[2] thread zombie_devgui_kill();
        }
        break;
      }
      case "": {
        players = getplayers();
        if(players.size >= 4) {
          players[3] thread zombie_devgui_kill();
        }
        break;
      }
      case "": {
        player = util::gethostplayer();
        team = player.team;
        devgui_bot_spawn(team);
        break;
      }
      case "": {
        level.solo_lives_given = 0;
      }
      case "":
      case "":
      case "":
      case "":
      case "":
      case "":
      case "":
      case "":
      case "":
      case "":
      case "":
      case "":
      case "":
      case "": {
        zombie_devgui_give_perk(cmd);
        break;
      }
      case "": {
        function_af69dfbe(cmd);
        break;
      }
      case "": {
        function_3df1388a(cmd);
        break;
      }
      case "": {
        function_f976401d(cmd);
        break;
      }
      case "": {
        function_a888b17c(cmd);
        break;
      }
      case "": {
        function_7743668b(cmd);
        break;
      }
      case "": {
        function_7d8af9ea(cmd);
        break;
      }
      case "": {
        function_7d8af9ea(cmd);
        break;
      }
      case "": {
        zombie_devgui_take_perks(cmd);
        break;
      }
      case "": {
        zombie_devgui_turn_player();
        break;
      }
      case "": {
        zombie_devgui_turn_player(0);
        break;
      }
      case "": {
        zombie_devgui_turn_player(1);
        break;
      }
      case "": {
        zombie_devgui_turn_player(2);
        break;
      }
      case "": {
        zombie_devgui_turn_player(3);
        break;
      }
      case "": {
        zombie_devgui_debug_pers(0);
        break;
      }
      case "": {
        zombie_devgui_debug_pers(1);
        break;
      }
      case "": {
        zombie_devgui_debug_pers(2);
        break;
      }
      case "": {
        zombie_devgui_debug_pers(3);
        break;
      }
      case "":
      case "":
      case "":
      case "":
      case "":
      case "":
      case "":
      case "":
      case "":
      case "":
      case "":
      case "":
      case "":
      case "":
      case "":
      case "":
      case "": {
        zombie_devgui_give_powerup(cmd, 1);
        break;
      }
      case "":
      case "":
      case "":
      case "":
      case "":
      case "":
      case "":
      case "":
      case "":
      case "":
      case "":
      case "":
      case "":
      case "":
      case "":
      case "":
      case "": {
        zombie_devgui_give_powerup(getsubstr(cmd, 5), 0);
        break;
      }
      case "": {
        zombie_devgui_goto_round(getdvarint(""));
        break;
      }
      case "": {
        zombie_devgui_goto_round(level.round_number + 1);
        break;
      }
      case "": {
        zombie_devgui_goto_round(level.round_number - 1);
        break;
      }
      case "": {
        array::thread_all(getplayers(), &function_4619dfa7);
        break;
      }
      case "": {
        if(isDefined(level.chest_accessed)) {
          level notify("devgui_chest_end_monitor");
          level.chest_accessed = 100;
        }
        break;
      }
      case "": {
        if(isDefined(level.chest_accessed)) {
          level thread zombie_devgui_chest_never_move();
        }
        break;
      }
      case "": {
        break;
      }
      case "": {
        array::thread_all(getplayers(), &zombie_devgui_preserve_turbines);
        break;
      }
      case "": {
        array::thread_all(getplayers(), &zombie_devgui_equipment_stays_healthy);
        break;
      }
      case "": {
        array::thread_all(getplayers(), &zombie_devgui_disown_equipment);
        break;
      }
      case "": {
        array::thread_all(getplayers(), &zombie_devgui_give_placeable_mine, getweapon(""));
        break;
      }
      case "": {
        array::thread_all(getplayers(), &zombie_devgui_give_placeable_mine, getweapon(""));
        break;
      }
      case "": {
        array::thread_all(getplayers(), &zombie_devgui_give_frags);
        break;
      }
      case "": {
        array::thread_all(getplayers(), &zombie_devgui_give_sticky);
        break;
      }
      case "": {
        array::thread_all(getplayers(), &zombie_devgui_give_monkey);
        break;
      }
      case "": {
        array::thread_all(getplayers(), &zombie_devgui_give_bhb);
        break;
      }
      case "": {
        array::thread_all(getplayers(), &zombie_devgui_give_qed);
        break;
      }
      case "": {
        array::thread_all(getplayers(), &zombie_devgui_give_dolls);
        break;
      }
      case "": {
        array::thread_all(getplayers(), &zombie_devgui_give_emp_bomb);
        break;
      }
      case "": {
        zombie_devgui_dog_round(getdvarint(""));
        break;
      }
      case "": {
        zombie_devgui_dog_round_skip();
        break;
      }
      case "": {
        zombie_devgui_dump_zombie_vars();
        break;
      }
      case "": {
        zombie_devgui_pack_current_weapon();
        break;
      }
      case "": {
        function_9e5bfd9d();
        break;
      }
      case "": {
        function_435ea700();
        break;
      }
      case "": {
        function_525facc6();
        break;
      }
      case "": {
        function_935f6cc2();
        break;
      }
      case "": {
        zombie_devgui_repack_current_weapon();
        break;
      }
      case "": {
        zombie_devgui_unpack_current_weapon();
        break;
      }
      case "": {
        function_2306f73c();
        break;
      }
      case "": {
        function_5da1c3cd();
        break;
      }
      case "": {
        function_6afc4c2f();
        break;
      }
      case "": {
        function_9b4ea903();
        break;
      }
      case "": {
        function_4d2e8278();
        break;
      }
      case "": {
        function_ce561484();
        break;
      }
      case "": {
        zombie_devgui_reopt_current_weapon();
        break;
      }
      case "": {
        zombie_devgui_take_weapons(1);
        break;
      }
      case "": {
        zombie_devgui_take_weapons(0);
        break;
      }
      case "": {
        zombie_devgui_take_weapon();
        break;
      }
      case "": {
        level flag::set("");
        level clientfield::set("", 0);
        power_trigs = getEntArray("", "");
        foreach(trig in power_trigs) {
          if(isDefined(trig.script_int)) {
            level flag::set("" + trig.script_int);
            level clientfield::set("", trig.script_int);
          }
        }
        break;
      }
      case "": {
        level flag::clear("");
        level clientfield::set("", 0);
        power_trigs = getEntArray("", "");
        foreach(trig in power_trigs) {
          if(isDefined(trig.script_int)) {
            level flag::clear("" + trig.script_int);
            level clientfield::set("", trig.script_int);
          }
        }
        break;
      }
      case "": {
        array::thread_all(getplayers(), &zombie_devgui_dpad_none);
        break;
      }
      case "": {
        array::thread_all(getplayers(), &zombie_devgui_dpad_damage);
        break;
      }
      case "": {
        array::thread_all(getplayers(), &zombie_devgui_dpad_death);
        break;
      }
      case "": {
        array::thread_all(getplayers(), &zombie_devgui_dpad_changeweapon);
        break;
      }
      case "": {
        zombie_devgui_director_easy();
        break;
      }
      case "": {
        zombie_devgui_open_sesame();
        break;
      }
      case "": {
        zombie_devgui_allow_fog();
        break;
      }
      case "": {
        zombie_devgui_disable_kill_thread_toggle();
        break;
      }
      case "": {
        zombie_devgui_check_kill_thread_every_frame_toggle();
        break;
      }
      case "": {
        zombie_devgui_kill_thread_test_mode_toggle();
        break;
      }
      case "": {
        level notify("zombie_failsafe_debug_flush", isDefined(level.zombie_weapons[getweapon(getdvarstring(""))]));
        break;
      }
      case "": {
        level thread rat::derriesezombiespawnnavmeshtest(0, 0);
        break;
      }
      case "": {
        devgui_zombie_spawn();
        break;
      }
      case "": {
        devgui_all_spawn();
        break;
      }
      case "": {
        devgui_make_crawler();
        break;
      }
      case "": {
        devgui_toggle_show_spawn_locations();
        break;
      }
      case "": {
        devgui_toggle_show_exterior_goals();
        break;
      }
      case "": {
        zombie_devgui_draw_traversals();
        break;
      }
      case "": {
        function_364ed1b9();
        break;
      }
      case "": {
        array::thread_all(getplayers(), &devgui_debug_hud);
        break;
      }
      case "": {
        zombie_devgui_keyline_always();
        break;
      }
      case "": {
        function_13d8ea87();
        break;
      }
      case "": {
        thread function_1acc8e35();
        break;
      }
      case "": {
        function_eec2d58b();
        break;
      }
      case "": {
        break;
      }
      default: {
        if(isDefined(level.custom_devgui)) {
          if(isarray(level.custom_devgui)) {
            foreach(devgui in level.custom_devgui) {
              b_result = [[devgui]](cmd);
              if(isDefined(b_result) && b_result) {
                break;
              }
            }
          } else {
            [[level.custom_devgui]](cmd);
          }
        }
        break;
      }
    }
    setDvar("", "");
    wait(0.5);
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
  devgui_bot_spawn(player.team);
  wait(0.1);
  devgui_bot_spawn(player.team);
  wait(0.1);
  devgui_bot_spawn(player.team);
  wait(0.1);
  zombie_devgui_goto_round(8);
}

function devgui_toggle_show_spawn_locations() {
  if(!isDefined(level.toggle_show_spawn_locations)) {
    level.toggle_show_spawn_locations = 1;
  } else {
    level.toggle_show_spawn_locations = !level.toggle_show_spawn_locations;
  }
}

function devgui_toggle_show_exterior_goals() {
  if(!isDefined(level.toggle_show_exterior_goals)) {
    level.toggle_show_exterior_goals = 1;
  } else {
    level.toggle_show_exterior_goals = !level.toggle_show_exterior_goals;
  }
}

function devgui_zombie_spawn() {
  player = getplayers()[0];
  spawnername = undefined;
  spawnername = "";
  direction = player getplayerangles();
  direction_vec = anglesToForward(direction);
  eye = player getEye();
  scale = 8000;
  direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
  trace = bulletTrace(eye, eye + direction_vec, 0, undefined);
  guy = undefined;
  spawners = getEntArray(spawnername, "");
  spawner = spawners[0];
  guy = zombie_utility::spawn_zombie(spawner);
  if(isDefined(guy)) {
    guy.script_string = "";
    wait(0.5);
    guy forceteleport(trace[""], player.angles + vectorscale((0, 1, 0), 180));
  }
  return guy;
}

function devgui_make_crawler() {
  zombies = zombie_utility::get_round_enemy_array();
  foreach(zombie in zombies) {
    gib_style = [];
    gib_style[gib_style.size] = "";
    gib_style[gib_style.size] = "";
    gib_style[gib_style.size] = "";
    gib_style = zombie_death::randomize_array(gib_style);
    zombie.a.gib_ref = gib_style[0];
    zombie.missinglegs = 1;
    zombie allowedstances("");
    zombie setphysparams(15, 0, 24);
    zombie allowpitchangle(1);
    zombie setpitchorient();
    health = zombie.health;
    health = health * 0.1;
    zombie thread zombie_death::do_gib();
  }
}

function devgui_bot_spawn(team) {
  player = util::gethostplayer();
  direction = player getplayerangles();
  direction_vec = anglesToForward(direction);
  eye = player getEye();
  scale = 8000;
  direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
  trace = bulletTrace(eye, eye + direction_vec, 0, undefined);
  direction_vec = player.origin - trace[""];
  direction = vectortoangles(direction_vec);
  bot = addtestclient();
  if(!isDefined(bot)) {
    println("");
    return;
  }
  bot.pers[""] = 1;
  bot.equipment_enabled = 0;
  bot demo::reset_actor_bookmark_kill_times();
  bot.team = "";
  bot._player_entnum = bot getentitynumber();
  yaw = direction[1];
  bot thread devgui_bot_spawn_think(trace[""], yaw);
}

function devgui_bot_spawn_think(origin, yaw) {
  self endon("disconnect");
  for(;;) {
    self waittill("spawned_player");
    self setorigin(origin);
    angles = (0, yaw, 0);
    self setplayerangles(angles);
  }
}

function zombie_devgui_open_sesame() {
  setDvar("", 1);
  level flag::set("");
  level clientfield::set("", 0);
  power_trigs = getEntArray("", "");
  foreach(trig in power_trigs) {
    if(isDefined(trig.script_int)) {
      level flag::set("" + trig.script_int);
      level clientfield::set("", trig.script_int);
    }
  }
  players = getplayers();
  array::thread_all(players, &zombie_devgui_give_money);
  zombie_doors = getEntArray("", "");
  for(i = 0; i < zombie_doors.size; i++) {
    zombie_doors[i] notify("trigger", players[0]);
    if(isDefined(zombie_doors[i].power_door_ignore_flag_wait) && zombie_doors[i].power_door_ignore_flag_wait) {
      zombie_doors[i] notify("power_on");
    }
    wait(0.05);
  }
  zombie_airlock_doors = getEntArray("", "");
  for(i = 0; i < zombie_airlock_doors.size; i++) {
    zombie_airlock_doors[i] notify("trigger", players[0]);
    wait(0.05);
  }
  zombie_debris = getEntArray("", "");
  for(i = 0; i < zombie_debris.size; i++) {
    if(isDefined(zombie_debris[i])) {
      zombie_debris[i] notify("trigger", players[0]);
    }
    wait(0.05);
  }
  level notify("open_sesame");
  wait(1);
  setDvar("", 0);
}

function any_player_in_noclip() {
  foreach(player in getplayers()) {
    if(player isinmovemode("", "")) {
      return true;
    }
  }
  return false;
}

function diable_fog_in_noclip() {
  level.fog_disabled_in_noclip = 1;
  level endon("allowfoginnoclip");
  level flag::wait_till("");
  while(true) {
    while(!any_player_in_noclip()) {
      wait(1);
    }
    setDvar("", "");
    setDvar("", "");
    if(isDefined(level.culldist)) {
      setculldist(0);
    }
    while(any_player_in_noclip()) {
      wait(1);
    }
    setDvar("", "");
    setDvar("", "");
    if(isDefined(level.culldist)) {
      setculldist(level.culldist);
    }
  }
}

function zombie_devgui_allow_fog() {
  if(isDefined(level.fog_disabled_in_noclip) && level.fog_disabled_in_noclip) {
    level notify("allowfoginnoclip");
    level.fog_disabled_in_noclip = 0;
    setDvar("", "");
    setDvar("", "");
  } else {
    thread diable_fog_in_noclip();
  }
}

function zombie_devgui_give_money() {
  /
  #
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(isalive(self));
  level.devcheater = 1;
  self zm_score::add_to_player_score(100000);
}

function zombie_devgui_take_money() {
  /
  #
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(isalive(self));
  if(self.score > 100) {
    self zm_score::player_reduce_points("");
  } else {
    self zm_score::player_reduce_points("");
  }
}

function zombie_devgui_give_xp(amount) {
  /
  #
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(isalive(self));
  self addrankxp("", self.currentweapon, undefined, undefined, 1, amount / 50);
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
  if(player hasperk("")) {
    println("");
    player zm_turned::turn_to_human();
  } else {
    println("");
    player zm_turned::turn_to_zombie();
  }
}

function zombie_devgui_debug_pers(index) {
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
  println("");
  println(("" + level.pers_upgrades_keys.size) + "");
  for(pers_upgrade_index = 0; pers_upgrade_index < level.pers_upgrades_keys.size; pers_upgrade_index++) {
    name = level.pers_upgrades_keys[pers_upgrade_index];
    println((pers_upgrade_index + "") + name);
    pers_upgrade = level.pers_upgrades[name];
    for(i = 0; i < pers_upgrade.stat_names.size; i++) {
      stat_name = pers_upgrade.stat_names[i];
      stat_desired_value = pers_upgrade.stat_desired_values[i];
      player_current_stat_value = player zm_stats::get_global_stat(stat_name);
      println((("" + i) + "") + stat_name);
      println((("" + i) + "") + stat_desired_value);
      println((("" + i) + "") + player_current_stat_value);
    }
    if(isDefined(player.pers_upgrades_awarded[name]) && player.pers_upgrades_awarded[name]) {
      println("" + name);
      continue;
    }
    println("" + name);
  }
  println("");
}

function function_4619dfa7() {
  entnum = self getentitynumber();
  chest = level.chests[level.chest_index];
  origin = chest.zbarrier.origin;
  forward = anglesToForward(chest.zbarrier.angles);
  right = anglestoright(chest.zbarrier.angles);
  var_d9191ee9 = vectortoangles(right);
  var_f2857d87 = origin - (48 * right);
  switch (entnum) {
    case 0: {
      var_f2857d87 = var_f2857d87 + (16 * right);
      break;
    }
    case 1: {
      var_f2857d87 = var_f2857d87 + (16 * forward);
      break;
    }
    case 2: {
      var_f2857d87 = var_f2857d87 - (16 * right);
      break;
    }
    case 3: {
      var_f2857d87 = var_f2857d87 - (16 * forward);
      break;
    }
  }
  self setorigin(var_f2857d87);
  self setplayerangles(var_d9191ee9);
}

function zombie_devgui_cool_jetgun() {
  if(isDefined(level.zm_devgui_jetgun_never_overheat)) {
    self thread[[level.zm_devgui_jetgun_never_overheat]]();
  }
}

function zombie_devgui_preserve_turbines() {
  self endon("disconnect");
  self notify("preserve_turbines");
  self endon("preserve_turbines");
  if(!(isDefined(self.preserving_turbines) && self.preserving_turbines)) {
    self.preserving_turbines = 1;
    while(true) {
      self.turbine_health = 1200;
      wait(1);
    }
  }
  self.preserving_turbines = 0;
}

function zombie_devgui_equipment_stays_healthy() {
  self endon("disconnect");
  self notify("preserve_equipment");
  self endon("preserve_equipment");
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
      wait(0.1);
    }
  }
  self.preserving_equipment = 0;
}

function zombie_devgui_disown_equipment() {
  self.deployed_equipment = [];
}

function zombie_devgui_equipment_give(equipment) {
  /
  #
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(isalive(self));
  level.devcheater = 1;
  if(zm_equipment::is_included(equipment)) {
    self zm_equipment::buy(equipment);
  }
}

function zombie_devgui_give_placeable_mine(weapon) {
  self endon("disconnect");
  self notify("give_planted_grenade_thread");
  self endon("give_planted_grenade_thread");
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(isalive(self));
  level.devcheater = 1;
  if(!zm_utility::is_placeable_mine(weapon)) {
    return;
  }
  if(isDefined(self zm_utility::get_player_placeable_mine())) {
    self takeweapon(self zm_utility::get_player_placeable_mine());
  }
  self thread zm_placeable_mine::setup_for_player(weapon);
  while(true) {
    self givemaxammo(weapon);
    wait(1);
  }
}

function zombie_devgui_give_claymores() {
  self endon("disconnect");
  self notify("give_planted_grenade_thread");
  self endon("give_planted_grenade_thread");
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(isalive(self));
  level.devcheater = 1;
  if(isDefined(self zm_utility::get_player_placeable_mine())) {
    self takeweapon(self zm_utility::get_player_placeable_mine());
  }
  wpn_type = zm_placeable_mine::get_first_available();
  if(wpn_type != level.weaponnone) {
    self thread zm_placeable_mine::setup_for_player(wpn_type);
  }
  while(true) {
    self givemaxammo(wpn_type);
    wait(1);
  }
}

function zombie_devgui_give_lethal(weapon) {
  self endon("disconnect");
  self notify("give_lethal_grenade_thread");
  self endon("give_lethal_grenade_thread");
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(isalive(self));
  level.devcheater = 1;
  if(isDefined(self zm_utility::get_player_lethal_grenade())) {
    self takeweapon(self zm_utility::get_player_lethal_grenade());
  }
  self giveweapon(weapon);
  self zm_utility::set_player_lethal_grenade(weapon);
  while(true) {
    self givemaxammo(weapon);
    wait(1);
  }
}

function zombie_devgui_give_frags() {
  zombie_devgui_give_lethal(getweapon(""));
}

function zombie_devgui_give_sticky() {
  zombie_devgui_give_lethal(getweapon(""));
}

function zombie_devgui_give_monkey() {
  self endon("disconnect");
  self notify("give_tactical_grenade_thread");
  self endon("give_tactical_grenade_thread");
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(isalive(self));
  level.devcheater = 1;
  if(isDefined(self zm_utility::get_player_tactical_grenade())) {
    self takeweapon(self zm_utility::get_player_tactical_grenade());
  }
  if(isDefined(level.zombiemode_devgui_cymbal_monkey_give)) {
    self[[level.zombiemode_devgui_cymbal_monkey_give]]();
    while(true) {
      self givemaxammo(getweapon(""));
      wait(1);
    }
  }
}

function zombie_devgui_give_bhb() {
  self endon("disconnect");
  self notify("give_tactical_grenade_thread");
  self endon("give_tactical_grenade_thread");
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(isalive(self));
  level.devcheater = 1;
  if(isDefined(self zm_utility::get_player_tactical_grenade())) {
    self takeweapon(self zm_utility::get_player_tactical_grenade());
  }
  if(isDefined(level.zombiemode_devgui_black_hole_bomb_give)) {
    self[[level.zombiemode_devgui_black_hole_bomb_give]]();
    while(true) {
      self givemaxammo(level.w_black_hole_bomb);
      wait(1);
    }
  }
}

function zombie_devgui_give_qed() {
  self endon("disconnect");
  self notify("give_tactical_grenade_thread");
  self endon("give_tactical_grenade_thread");
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(isalive(self));
  level.devcheater = 1;
  if(isDefined(self zm_utility::get_player_tactical_grenade())) {
    self takeweapon(self zm_utility::get_player_tactical_grenade());
  }
  if(isDefined(level.zombiemode_devgui_quantum_bomb_give)) {
    self[[level.zombiemode_devgui_quantum_bomb_give]]();
    while(true) {
      self givemaxammo(level.w_quantum_bomb);
      wait(1);
    }
  }
}

function zombie_devgui_give_dolls() {
  self endon("disconnect");
  self notify("give_tactical_grenade_thread");
  self endon("give_tactical_grenade_thread");
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(isalive(self));
  level.devcheater = 1;
  if(isDefined(self zm_utility::get_player_tactical_grenade())) {
    self takeweapon(self zm_utility::get_player_tactical_grenade());
  }
  if(isDefined(level.zombiemode_devgui_nesting_dolls_give)) {
    self[[level.zombiemode_devgui_nesting_dolls_give]]();
    while(true) {
      self givemaxammo(level.w_nesting_dolls);
      wait(1);
    }
  }
}

function zombie_devgui_give_emp_bomb() {
  self endon("disconnect");
  self notify("give_tactical_grenade_thread");
  self endon("give_tactical_grenade_thread");
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(isalive(self));
  level.devcheater = 1;
  if(isDefined(self zm_utility::get_player_tactical_grenade())) {
    self takeweapon(self zm_utility::get_player_tactical_grenade());
  }
  if(isDefined(level.zombiemode_devgui_emp_bomb_give)) {
    self[[level.zombiemode_devgui_emp_bomb_give]]();
    while(true) {
      self givemaxammo(getweapon(""));
      wait(1);
    }
  }
}

function zombie_devgui_invulnerable(playerindex, onoff) {
  players = getplayers();
  if(!isDefined(playerindex)) {
    for(i = 0; i < players.size; i++) {
      zombie_devgui_invulnerable(i, onoff);
    }
  } else if(players.size > playerindex) {
    if(onoff) {
      players[playerindex] enableinvulnerability();
    } else {
      players[playerindex] disableinvulnerability();
    }
  }
}

function zombie_devgui_kill() {
  /
  #
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(isalive(self));
  self disableinvulnerability();
  death_from = (randomfloatrange(-20, 20), randomfloatrange(-20, 20), randomfloatrange(-20, 20));
  self dodamage(self.health + 666, self.origin + death_from);
}

function zombie_devgui_toggle_ammo() {
  /
  #
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(isalive(self));
  self notify("devgui_toggle_ammo");
  self endon("devgui_toggle_ammo");
  self.ammo4evah = !(isDefined(self.ammo4evah) && self.ammo4evah);
  while(isDefined(self) && self.ammo4evah) {
    if(!(isDefined(self.is_drinking) && self.is_drinking)) {
      weapon = self getcurrentweapon();
      if(weapon != level.weaponnone) {
        self setweaponoverheating(0, 0);
        max = weapon.maxammo;
        if(isDefined(max)) {
          self setweaponammostock(weapon, max);
        }
        if(isDefined(self zm_utility::get_player_tactical_grenade())) {
          self givemaxammo(self zm_utility::get_player_tactical_grenade());
        }
        if(isDefined(self zm_utility::get_player_lethal_grenade())) {
          self givemaxammo(self zm_utility::get_player_lethal_grenade());
        }
      }
    }
    wait(1);
  }
}

function zombie_devgui_toggle_ignore() {
  /
  #
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(isalive(self));
  if(!isDefined(self.var_b67d35de)) {
    self.var_b67d35de = 0;
  }
  self.var_b67d35de = !self.var_b67d35de;
  if(self.var_b67d35de) {
    self zm_utility::increment_ignoreme();
  } else {
    self zm_utility::decrement_ignoreme();
  }
  if(self.ignoreme) {
    setDvar("", 0);
  }
}

function zombie_devgui_revive() {
  /
  #
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(isalive(self));
  self reviveplayer();
  self notify("stop_revive_trigger");
  if(isDefined(self.revivetrigger)) {
    self.revivetrigger delete();
    self.revivetrigger = undefined;
  }
  self allowjump(1);
  self zm_laststand::set_ignoreme(0);
  self.laststand = undefined;
  self notify("player_revived", self);
}

function zombie_devgui_give_health() {
  /
  #
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(isalive(self));
  self notify("devgui_health");
  self endon("devgui_health");
  self endon("disconnect");
  self endon("death");
  level.devcheater = 1;
  while(true) {
    self.maxhealth = 100000;
    self.health = 100000;
    self util::waittill_any("", "", "");
    wait(2);
  }
}

function zombie_devgui_low_health() {
  /
  #
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(isalive(self));
  self notify("devgui_health");
  self endon("devgui_health");
  self endon("disconnect");
  self endon("death");
  level.devcheater = 1;
  while(true) {
    self.maxhealth = 10;
    self.health = 10;
    self util::waittill_any("", "", "");
    wait(2);
  }
}

function zombie_devgui_give_perk(perk) {
  vending_triggers = getEntArray("", "");
  level.devcheater = 1;
  if(vending_triggers.size < 1) {
    return;
  }
  foreach(player in getplayers()) {
    for(i = 0; i < vending_triggers.size; i++) {
      if(vending_triggers[i].script_noteworthy == perk) {
        vending_triggers[i] notify("trigger", player);
        break;
      }
    }
    wait(1);
  }
}

function zombie_devgui_take_perks(cmd) {
  vending_triggers = getEntArray("", "");
  perks = [];
  for(i = 0; i < vending_triggers.size; i++) {
    perk = vending_triggers[i].script_noteworthy;
    if(isDefined(self.perk_purchased) && self.perk_purchased == perk) {
      continue;
    }
    perks[perks.size] = perk;
  }
  foreach(player in getplayers()) {
    foreach(perk in perks) {
      perk_str = perk + "";
      player notify(perk_str);
    }
  }
}

function function_af69dfbe(cmd) {
  if(isDefined(level.perk_random_devgui_callback)) {
    self[[level.perk_random_devgui_callback]](cmd);
  }
}

function function_3df1388a(cmd) {
  if(isDefined(level.perk_random_devgui_callback)) {
    self[[level.perk_random_devgui_callback]](cmd);
  }
}

function function_f976401d(cmd) {
  if(isDefined(level.perk_random_devgui_callback)) {
    self[[level.perk_random_devgui_callback]](cmd);
  }
}

function function_a888b17c(cmd) {
  if(isDefined(level.perk_random_devgui_callback)) {
    self[[level.perk_random_devgui_callback]](cmd);
  }
}

function function_7743668b(cmd) {
  if(isDefined(level.perk_random_devgui_callback)) {
    self[[level.perk_random_devgui_callback]](cmd);
  }
}

function function_7d8af9ea(cmd) {
  if(isDefined(level.perk_random_devgui_callback)) {
    self[[level.perk_random_devgui_callback]](cmd);
  }
}

function function_c2cda548(cmd) {
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
    level.zombie_vars[""] = 1;
    level.powerup_drop_count = 0;
    return;
  }
  direction = player getplayerangles();
  direction_vec = anglesToForward(direction);
  eye = player getEye();
  scale = 8000;
  direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
  trace = bulletTrace(eye, eye + direction_vec, 0, undefined);
  if(isDefined(origin)) {
    level thread zm_powerups::specific_powerup_drop(powerup_name, origin);
  } else {
    level thread zm_powerups::specific_powerup_drop(powerup_name, trace[""]);
  }
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
    level.zombie_vars[""] = 1;
    level.powerup_drop_count = 0;
    return;
  }
  direction = player getplayerangles();
  direction_vec = anglesToForward(direction);
  eye = player getEye();
  scale = 8000;
  direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
  trace = bulletTrace(eye, eye + direction_vec, 0, undefined);
  level thread zm_powerups::specific_powerup_drop(powerup_name, trace[""], undefined, undefined, undefined, player);
}

function zombie_devgui_goto_round(target_round) {
  player = getplayers()[0];
  if(target_round < 1) {
    target_round = 1;
  }
  level.devcheater = 1;
  level.zombie_total = 0;
  zombie_utility::ai_calculate_health(target_round);
  zm::set_round_number(target_round - 1);
  level notify("kill_round");
  wait(1);
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

function zombie_devgui_monkey_round() {
  if(isDefined(level.next_monkey_round)) {
    zombie_devgui_goto_round(level.next_monkey_round);
  }
}

function zombie_devgui_thief_round() {
  if(isDefined(level.next_thief_round)) {
    zombie_devgui_goto_round(level.next_thief_round);
  }
}

function zombie_devgui_dog_round(num_dogs) {
  if(!isDefined(level.dogs_enabled) || !level.dogs_enabled) {
    return;
  }
  if(!isDefined(level.dog_rounds_enabled) || !level.dog_rounds_enabled) {
    return;
  }
  if(!isDefined(level.enemy_dog_spawns) || level.enemy_dog_spawns.size < 1) {
    return;
  }
  if(!level flag::get("")) {
    setDvar("", num_dogs);
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
    println("");
  } else {
    return;
  }
  var_66026a81 = getarraykeys(level.zombie_vars);
  for(i = 0; i < level.zombie_vars.size; i++) {
    key = var_66026a81[i];
    println((key + "") + level.zombie_vars[key]);
  }
  println("");
}

function zombie_devgui_pack_current_weapon() {
  players = getplayers();
  reviver = players[0];
  level.devcheater = 1;
  for(i = 0; i < players.size; i++) {
    if(!players[i] laststand::player_is_in_laststand()) {
      weap = players[i] getcurrentweapon();
      weapon = get_upgrade(weap.rootweapon);
      players[i] takeweapon(weap);
      weapon = players[i] zm_weapons::give_build_kit_weapon(weapon);
      players[i] thread aat::remove(weapon);
      players[i] givestartammo(weapon);
      players[i] switchtoweapon(weapon);
    }
  }
}

function zombie_devgui_repack_current_weapon() {
  players = getplayers();
  reviver = players[0];
  level.devcheater = 1;
  for(i = 0; i < players.size; i++) {
    if(!players[i] laststand::player_is_in_laststand()) {
      weap = players[i] getcurrentweapon();
      if(isDefined(level.aat_in_use) && level.aat_in_use && zm_weapons::weapon_supports_aat(weap)) {
        players[i] thread aat::acquire(weap);
      }
    }
  }
}

function zombie_devgui_unpack_current_weapon() {
  players = getplayers();
  reviver = players[0];
  level.devcheater = 1;
  for(i = 0; i < players.size; i++) {
    if(!players[i] laststand::player_is_in_laststand()) {
      weap = players[i] getcurrentweapon();
      weapon = zm_weapons::get_base_weapon(weap);
      players[i] takeweapon(weap);
      weapon = players[i] zm_weapons::give_build_kit_weapon(weapon);
      players[i] givestartammo(weapon);
      players[i] switchtoweapon(weapon);
    }
  }
}

function function_3ec0de8d(itemindex, xp) {
  if(!itemindex || !level.onlinegame) {
    return;
  }
  if(0 > xp) {
    xp = 0;
  }
  self setdstat("", itemindex, "", xp);
}

function function_949d6013(weapon) {
  var_1121268 = [];
  table = popups::devgui_notif_getgunleveltablename();
  weapon_name = weapon.rootweapon.name;
  for(i = 0; i < 15; i++) {
    var_d4b6b0ab = tablelookup(table, 2, weapon_name, 0, i, 1);
    if("" == var_d4b6b0ab) {
      break;
    }
    var_1121268[i] = int(var_d4b6b0ab);
  }
  return var_1121268;
}

function function_718c64af(weapon, var_2e8a2b5e) {
  xp = 0;
  var_1121268 = function_949d6013(weapon);
  if(var_1121268.size) {
    xp = var_1121268[var_1121268.size - 1];
    if(var_2e8a2b5e < var_1121268.size) {
      xp = var_1121268[var_2e8a2b5e];
    }
  }
  return xp;
}

function function_e9906f08(weapon) {
  xp = 0;
  var_1121268 = function_949d6013(weapon);
  if(var_1121268.size) {
    xp = var_1121268[var_1121268.size - 1];
  }
  return xp;
}

function function_2306f73c() {
  players = getplayers();
  level.devcheater = 1;
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(!player laststand::player_is_in_laststand()) {
      weapon = player getcurrentweapon();
      itemindex = getbaseweaponitemindex(weapon);
      var_2e8a2b5e = player getcurrentgunrank(itemindex);
      xp = function_718c64af(weapon, var_2e8a2b5e);
      player function_3ec0de8d(itemindex, xp);
    }
  }
}

function function_5da1c3cd() {
  players = getplayers();
  level.devcheater = 1;
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(!player laststand::player_is_in_laststand()) {
      weapon = player getcurrentweapon();
      itemindex = getbaseweaponitemindex(weapon);
      var_2e8a2b5e = player getcurrentgunrank(itemindex);
      xp = function_718c64af(weapon, var_2e8a2b5e);
      player function_3ec0de8d(itemindex, xp - 50);
    }
  }
}

function function_6afc4c2f() {
  players = getplayers();
  level.devcheater = 1;
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(!player laststand::player_is_in_laststand()) {
      weapon = player getcurrentweapon();
      itemindex = getbaseweaponitemindex(weapon);
      xp = function_e9906f08(weapon);
      player function_3ec0de8d(itemindex, xp);
    }
  }
}

function function_9b4ea903() {
  players = getplayers();
  level.devcheater = 1;
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(!player laststand::player_is_in_laststand()) {
      weapon = player getcurrentweapon();
      itemindex = getbaseweaponitemindex(weapon);
      player function_3ec0de8d(itemindex, 0);
    }
  }
}

function function_4d2e8278() {
  players = getplayers();
  level.devcheater = 1;
  a_weapons = enumerateweapons("");
  for(weapon_index = 0; weapon_index < a_weapons.size; weapon_index++) {
    weapon = a_weapons[weapon_index];
    itemindex = getbaseweaponitemindex(weapon);
    if(!itemindex) {
      continue;
    }
    xp = function_e9906f08(weapon);
    for(i = 0; i < players.size; i++) {
      player = players[i];
      if(!player laststand::player_is_in_laststand()) {
        player function_3ec0de8d(itemindex, xp);
      }
    }
  }
}

function function_ce561484() {
  players = getplayers();
  level.devcheater = 1;
  a_weapons = enumerateweapons("");
  for(weapon_index = 0; weapon_index < a_weapons.size; weapon_index++) {
    weapon = a_weapons[weapon_index];
    itemindex = getbaseweaponitemindex(weapon);
    if(!itemindex) {
      continue;
    }
    for(i = 0; i < players.size; i++) {
      player = players[i];
      if(!player laststand::player_is_in_laststand()) {
        player function_3ec0de8d(itemindex, 0);
      }
    }
  }
}

function function_be6b95c4(xp) {
  if(self.pers[""] > xp) {
    self.pers[""] = 0;
    self setrank(0);
    self setdstat("", "", "", 0);
  }
  self.pers[""] = xp;
  self rank::syncxpstat();
  self rank::updaterank();
  self setdstat("", "", "", self.pers[""]);
}

function function_1a6e88f7(var_2e8a2b5e) {
  return int(level.ranktable[var_2e8a2b5e][7]);
}

function function_b207ef2e() {
  xp = 0;
  xp = function_1a6e88f7(level.ranktable.size - 1);
  return xp;
}

function function_9e5bfd9d() {
  players = getplayers();
  level.devcheater = 1;
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(!player laststand::player_is_in_laststand()) {
      var_2e8a2b5e = player rank::getrank();
      xp = function_1a6e88f7(var_2e8a2b5e);
      player function_be6b95c4(xp);
    }
  }
}

function function_435ea700() {
  players = getplayers();
  level.devcheater = 1;
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(!player laststand::player_is_in_laststand()) {
      var_2e8a2b5e = player rank::getrank();
      xp = function_1a6e88f7(var_2e8a2b5e);
      player function_be6b95c4(xp - 50);
    }
  }
}

function function_525facc6() {
  players = getplayers();
  level.devcheater = 1;
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(!player laststand::player_is_in_laststand()) {
      xp = function_b207ef2e();
      player function_be6b95c4(xp);
    }
  }
}

function function_935f6cc2() {
  players = getplayers();
  level.devcheater = 1;
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(!player laststand::player_is_in_laststand()) {
      player function_be6b95c4(0);
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
      players[i] takeweapon(weapon);
      weapon = players[i] zm_weapons::give_build_kit_weapon(weapon);
      players[i] givestartammo(weapon);
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
      players[i] takeweapon(players[i] getcurrentweapon());
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
      players[i] takeallweapons();
      if(give_fallback) {
        players[i] zm_weapons::give_fallback_weapon();
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
  if(isDefined(level.director_devgui_health)) {
    [[level.director_devgui_health]]();
  }
}

function zombie_devgui_chest_never_move() {
  level notify("devgui_chest_end_monitor");
  level endon("devgui_chest_end_monitor");
  for(;;) {
    level.chest_accessed = 0;
    wait(5);
  }
}

function zombie_devgui_disable_kill_thread_toggle() {
  if(!(isDefined(level.disable_kill_thread) && level.disable_kill_thread)) {
    level.disable_kill_thread = 1;
  } else {
    level.disable_kill_thread = 0;
  }
}

function zombie_devgui_check_kill_thread_every_frame_toggle() {
  if(!(isDefined(level.check_kill_thread_every_frame) && level.check_kill_thread_every_frame)) {
    level.check_kill_thread_every_frame = 1;
  } else {
    level.check_kill_thread_every_frame = 0;
  }
}

function zombie_devgui_kill_thread_test_mode_toggle() {
  if(!(isDefined(level.kill_thread_test_mode) && level.kill_thread_test_mode)) {
    level.kill_thread_test_mode = 1;
  } else {
    level.kill_thread_test_mode = 0;
  }
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
  a = (center + forward) - right;
  b = (center + forward) + right;
  c = (center - forward) + right;
  d = (center - forward) - right;
  thread lineuntilnotified(a, b, color, 0, notification);
  thread lineuntilnotified(b, c, color, 0, notification);
  thread lineuntilnotified(c, d, color, 0, notification);
  thread lineuntilnotified(d, a, color, 0, notification);
  thread lineuntilnotified(a, a + (0, 0, height), color, 0, notification);
  thread lineuntilnotified(b, b + (0, 0, height), color, 0, notification);
  thread lineuntilnotified(c, c + (0, 0, height), color, 0, notification);
  thread lineuntilnotified(d, d + (0, 0, height), color, 0, notification);
  a = a + (0, 0, height);
  b = b + (0, 0, height);
  c = c + (0, 0, height);
  d = d + (0, 0, height);
  thread lineuntilnotified(a, b, color, 0, notification);
  thread lineuntilnotified(b, c, color, 0, notification);
  thread lineuntilnotified(c, d, color, 0, notification);
  thread lineuntilnotified(d, a, color, 0, notification);
  center = center + (0, 0, height / 2);
  arrow_forward = anglesToForward(spawn_point.angles);
  arrowhead_forward = anglesToForward(spawn_point.angles);
  arrowhead_right = anglestoright(spawn_point.angles);
  arrow_forward = vectorscale(arrow_forward, 32);
  arrowhead_forward = vectorscale(arrowhead_forward, 24);
  arrowhead_right = vectorscale(arrowhead_right, 8);
  a = center + arrow_forward;
  b = (center + arrowhead_forward) - arrowhead_right;
  c = (center + arrowhead_forward) + arrowhead_right;
  thread lineuntilnotified(center, a, color, 0, notification);
  thread lineuntilnotified(a, b, color, 0, notification);
  thread lineuntilnotified(a, c, color, 0, notification);
  thread print3duntilnotified(spawn_point.origin + (0, 0, height), print, color, 1, 1, notification);
}

function print3duntilnotified(origin, text, color, alpha, scale, notification) {
  level endon(notification);
  for(;;) {
    print3d(origin, text, color, alpha, scale);
    wait(0.05);
  }
}

function lineuntilnotified(start, end, color, depthtest, notification) {
  level endon(notification);
  for(;;) {
    line(start, end, color, depthtest);
    wait(0.05);
  }
}

function devgui_debug_hud() {
  if(isDefined(self zm_utility::get_player_lethal_grenade())) {
    self givemaxammo(self zm_utility::get_player_lethal_grenade());
  }
  wpn_type = zm_placeable_mine::get_first_available();
  if(wpn_type != level.weaponnone) {
    self thread zm_placeable_mine::setup_for_player(wpn_type);
  }
  if(isDefined(level.zombiemode_devgui_cymbal_monkey_give)) {
    if(isDefined(self zm_utility::get_player_tactical_grenade())) {
      self takeweapon(self zm_utility::get_player_tactical_grenade());
    }
    self[[level.zombiemode_devgui_cymbal_monkey_give]]();
  } else if(isDefined(self zm_utility::get_player_tactical_grenade())) {
    self givemaxammo(self zm_utility::get_player_tactical_grenade());
  }
  if(isDefined(level.zombie_include_equipment) && !isDefined(self zm_equipment::get_player_equipment())) {
    equipment = getarraykeys(level.zombie_include_equipment);
    if(isDefined(equipment[0])) {
      self zombie_devgui_equipment_give(equipment[0]);
    }
  }
  for(i = 0; i < 10; i++) {
    zombie_devgui_give_powerup("", 1, self.origin);
    wait(0.25);
  }
  zombie_devgui_give_powerup("", 1, self.origin);
  wait(0.25);
  zombie_devgui_give_powerup("", 1, self.origin);
  wait(0.25);
  zombie_devgui_give_powerup("", 1, self.origin);
  wait(0.25);
  zombie_devgui_give_powerup("", 1, self.origin);
  wait(0.25);
  zombie_devgui_give_powerup("", 1, self.origin);
  wait(0.25);
}

function devgui_test_chart_think() {
  wait(0.05);
  old_val = getdvarint("");
  for(;;) {
    val = getdvarint("");
    if(old_val != val) {
      if(isDefined(level.test_chart_model)) {
        level.test_chart_model delete();
        level.test_chart_model = undefined;
      }
      if(val) {
        player = getplayers()[0];
        direction = player getplayerangles();
        direction_vec = anglesToForward((0, direction[1], 0));
        scale = 120;
        direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
        level.test_chart_model = spawn("", player getEye() + direction_vec);
        level.test_chart_model setModel("");
        level.test_chart_model.angles = (0, direction[1], 0) + vectorscale((0, 1, 0), 90);
      }
    }
    old_val = val;
    wait(0.05);
  }
}

function zombie_devgui_draw_traversals() {
  if(!isDefined(level.toggle_draw_traversals)) {
    level.toggle_draw_traversals = 1;
  } else {
    level.toggle_draw_traversals = !level.toggle_draw_traversals;
  }
}

function zombie_devgui_keyline_always() {
  if(!isDefined(level.toggle_keyline_always)) {
    level.toggle_keyline_always = 1;
  } else {
    level.toggle_keyline_always = !level.toggle_keyline_always;
  }
}

function function_13d8ea87() {
  if(!isDefined(level.var_c2a01768)) {
    level.var_c2a01768 = 1;
  } else {
    level.var_c2a01768 = !level.var_c2a01768;
  }
}

function wait_for_zombie(crawler) {
  nodes = getallnodes();
  while(true) {
    ai = getactorarray();
    zombie = ai[0];
    if(isDefined(zombie)) {
      foreach(node in nodes) {
        if(node.type == "" || node.type == "" || node.type == "") {
          if(isDefined(node.animscript)) {
            blackboard::setblackboardattribute(zombie, "", "");
            blackboard::setblackboardattribute(zombie, "", node.animscript);
            table = istring("");
            if(isDefined(crawler) && crawler) {
              table = istring("");
            }
            if(isDefined(zombie.debug_traversal_ast)) {
              table = istring(zombie.debug_traversal_ast);
            }
            anim_results = zombie astsearch(table);
            if(!isDefined(anim_results[""])) {
              if(isDefined(crawler) && crawler) {
                node.bad_crawler_traverse = 1;
              } else {
                node.bad_traverse = 1;
              }
              continue;
            }
            if(anim_results[""] == "") {
              teleport = 1;
            }
          }
        }
      }
      break;
    }
    wait(0.25);
  }
}

function zombie_draw_traversals() {
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
            print3d(node.origin + (vectorscale((0, 0, -1), 12)), "", (1, 0, 0), 1, 0.5);
          }
        }
      }
    }
    wait(0.05);
  }
}

function function_364ed1b9() {
  nodes = getallnodes();
  var_242e809d = [];
  foreach(node in nodes) {
    if(isDefined(node.animscript) && node.animscript != "") {
      var_242e809d[node.animscript] = 1;
    }
  }
  var_d1e1ebcf = getarraykeys(var_242e809d);
  var_bbd3b866 = array::sort_by_value(var_d1e1ebcf, 1);
  println("");
  foreach(name in var_bbd3b866) {
    println("" + name);
  }
  println("");
}

function function_1d21f4f() {
  while(true) {
    if(isDefined(level.var_c2a01768) && level.var_c2a01768) {
      if(!isDefined(level.var_ff15f442)) {
        level.var_ff15f442 = newhudelem();
        level.var_ff15f442.alignx = "";
        level.var_ff15f442.x = 2;
        level.var_ff15f442.y = 160;
        level.var_ff15f442.fontscale = 1.5;
        level.var_ff15f442.color = (1, 1, 1);
      }
      zombie_count = zombie_utility::get_current_zombie_count();
      zombie_left = level.zombie_total;
      zombie_runners = 0;
      var_8cbe658b = zombie_utility::get_zombie_array();
      foreach(ai_zombie in var_8cbe658b) {
        if(ai_zombie.zombie_move_speed == "") {
          zombie_runners++;
        }
      }
      level.var_ff15f442 settext((((("" + zombie_count) + "") + zombie_left) + "") + zombie_runners);
    } else if(isDefined(level.var_ff15f442)) {
      level.var_ff15f442 destroy();
    }
    wait(0.05);
  }
}

function testscriptruntimeerrorassert() {
  wait(1);
  assert(0);
}

function testscriptruntimeerror2() {
  myundefined = "";
  if(myundefined == 1) {
    println("");
  }
}

function testscriptruntimeerror1() {
  testscriptruntimeerror2();
}

function testscriptruntimeerror() {
  wait(5);
  for(;;) {
    if(getdvarstring("") != "") {
      break;
    }
    wait(1);
  }
  myerror = getdvarstring("");
  setDvar("", "");
  if(myerror == "") {
    testscriptruntimeerrorassert();
  } else {
    testscriptruntimeerror1();
  }
  thread testscriptruntimeerror();
}

function function_2fcc56bd() {
  var_9857308b = getdvarint("");
  return array(array(var_9857308b / 2, 30), array(var_9857308b - 1, 20));
}

function function_1acc8e35() {
  self endon("hash_eec2d58b");
  setDvar("", 1);
  var_9857308b = getdvarint("");
  timescale = getdvarint("");
  var_da0f3f6 = function_2fcc56bd();
  setDvar("", timescale);
  while(level.round_number < var_9857308b) {
    foreach(var_b16efbf2 in var_da0f3f6) {
      if(level.round_number < var_b16efbf2[0]) {
        wait(var_b16efbf2[1]);
        break;
      }
    }
    ai_enemies = getaiteamarray("");
    foreach(ai in ai_enemies) {
      ai kill();
    }
    adddebugcommand("");
    wait(0.2);
  }
  setDvar("", 1);
}

function function_eec2d58b() {
  self notify("hash_eec2d58b");
  setDvar("", 1);
}
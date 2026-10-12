/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\drone\utility.gsc
***********************************************/



#using scripts\common\values;
#using scripts\cp\damagefeedback;
#using scripts\cp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace utility;

function deploy_drone(player, drone_config) {
  if(istrue(player.using_drone)) {
    return 0;
  }

  player.using_drone = 1;
  player.disable_map_tablet = 1;
  player.pre_drone_weapon = player getcurrentweapon();

  if(istrue(drone_config.play_intro)) {
    player giveweapon("ks_remote_drone_mp");
    player switchtoweapon("ks_remote_drone_mp");
    player notifyonplayercommand("cancel_deploy_helper_drone", "+weapnext");
    result = player scripts\engine\utility::waittill_any_timeout_2(0.6, "last_stand", "cancel_deploy_helper_drone");

    if(!isDefined(result) || result != "timeout") {
      player takeweapon("ks_remote_drone_mp");
      player switchtoweapon(player.pre_drone_weapon);
      player.using_drone = undefined;
      return 0;
    }

    result = player scripts\engine\utility::waittill_any_timeout_1(1.4, "last_stand");

    if(!isDefined(result) || result != "timeout") {
      player takeweapon("ks_remote_drone_mp");
      player switchtoweapon(player.pre_drone_weapon);
      player.using_drone = undefined;
      return 0;
    }
  }

  if(!istrue(drone_config.no_control)) {
    player val::set("deploy_drone", "weapon_switch", 0);
    return deploy_helper_drone_actual(player, drone_config);
  }

  player takeweapon("ks_remote_drone_mp");
  player switchtoweapon(player.pre_drone_weapon);
  player.using_drone = undefined;
  return 1;
}

function deploy_helper_drone_actual(player, drone_config) {
  start_pos = player.origin + (0, 0, 150);

  if(!istrue(drone_config.detonate_mines)) {
    start_pos = find_safe_spawn(player);
  }

  drone = create_drone(player, start_pos, drone_config);

  if(isDefined(drone)) {
    if(player isjumping()) {
      player setOrigin(scripts\engine\utility::drop_to_ground(player.origin));
    }

    if(istrue(player.dont_move_from_drone)) {
      player notify("drone_linked");
      waitframe();
    }

    player cameralinkTo(drone, "tag_origin");
    player remotecontrolvehicle(drone);
    player notify("drone_exists");
    player.drone = drone;
    player val::set("drone", "usability", 0);

    if(istrue(drone_config.send_down)) {
      drone thread send_drone_down(drone, player, drone_config);
    }

    turn_on_drone_hud(player);

    if(!istrue(player.dont_move_from_drone)) {
      player thread keep_player_on_ground();
      player thread move_away_from_vehicles();
    }

    player.pre_drone_angles = player getplayerangles();
    return true;
  }

  return false;
}

function send_drone_down(drone, player, drone_config) {
  wait 0.05;
  loc = drop_to_ground(drone.origin, -1500, -30000);
  loc += (0, 0, 2500);
}

function keep_player_on_ground() {
  while(istrue(self.using_drone)) {
    loc = drop_to_ground(self.origin);
    self setOrigin(loc);
    wait 0.05;
  }
}

function move_away_from_vehicles() {
  self endon("death");
  level endon("game_ended");
  var_340c9ed716c44138 = 600;
  var_3b266f496ea9e0e9 = var_340c9ed716c44138 * var_340c9ed716c44138;
  curtime = 0;
  var_abab6bc73fccef65 = -3;
  oldpos = self.origin;

  while(istrue(self.using_drone)) {
    if(curtime >= var_abab6bc73fccef65 + 3) {
      mapvehicles = vehicle_getarray();

      foreach(vehicle in mapvehicles) {
        if(distancesquared(self.origin, vehicle.origin) < var_3b266f496ea9e0e9) {
          var_b9e9097150d1298c = length2d(self.origin - oldpos);

          if(var_b9e9097150d1298c > 500 && var_b9e9097150d1298c < 5000) {
            moveplayerperpendicularly(1200);
            var_abab6bc73fccef65 = curtime;
          }
        }
      }
    }

    curtime += 2;
    wait 2;
  }
}

function exit_drone(player, drone) {
  if(isent(drone)) {
    drone playSound("recondrone_destroyed");
  }

  if(!isent(drone)) {
    return;
  }

  player cameraunlink(drone);
  player remotecontrolvehicleoff();

  if(player hasweapon("ks_remote_drone_mp")) {
    player takeweapon("ks_remote_drone_mp");
  }

  player val::set("drone", "weapon_switch", 1);
  player.last_weapon = player.pre_drone_weapon;
  weapontoswitch = player scripts\cp\utility::getweapontoswitchbackto();
  player switchtoweapon(weapontoswitch);
  player takeweapon("ks_remote_map_cp");
  player val::reset_all("drone");
  turn_off_drone_hud(player);
  player setplayerangles(player.pre_drone_angles);
  player.using_drone = undefined;
  player.disable_map_tablet = undefined;
  player notify("exiting_drone");
  player notify("exit_mine_drone");
}

function create_drone(player, start_pos, drone_config) {
  drone = spawnhelicopter(player, start_pos, player getplayerangles(), drone_config.vehicle_info, drone_config.model);

  if(!isDefined(drone)) {
    return;
  }

  drone enableaimassist();
  drone setnodeploy(1);
  drone.speed = drone_config.speed;
  drone.accel = drone_config.accel;
  drone.angles = player.angles;
  drone.owner = player;
  drone.team = player.team;

  if(isDefined(drone_config.self_destruct)) {
    drone.self_destruct = drone_config.self_destruct;
  }

  if(isDefined(drone_config.detonate_mines)) {
    drone.detonate_mines = drone_config.detonate_mines;
  }

  if(isDefined(drone_config.mark_ai)) {
    drone.mark_ai = drone_config.mark_ai;
  }

  if(isDefined(drone_config.mark_vehicles)) {
    drone.mark_vehicles = drone_config.mark_vehicles;
  }

  drone vehicle_setspeed(drone.speed, drone.accel);
  drone setotherent(player);
  drone vehicle_invoketriggers(1);
  drone vehicle_breakglass(1);
  drone.useobj = spawn("script_model", drone.origin);
  drone.useobj setModel("tag_origin");
  drone.useobj linkTo(drone, "tag_origin");
  drone.useobj hide();
  drone thread timeout_monitor(player, drone, drone_config);
  drone thread damage_monitor(player, drone, drone_config);
  drone thread player_exit_monitor(player, drone);

  if(istrue(drone_config.detonate_mines)) {
    drone thread remote_detonation_monitor(player, drone);
  }

  if(isDefined(drone_config.use_func)) {
    drone thread[[drone_config.use_func]](player, drone);
  }

  return drone;
}

function player_exit_monitor(player, drone) {
  drone endon("death");
  player notifyonplayercommand("exit_drone", "+stance");
  result = player scripts\engine\utility::waittill_any_3("last_stand", "disconnect", "exit_drone");
  exit_drone(player, drone);
  drone_explode(drone);
}

function timeout_monitor(player, drone, drone_config) {
  drone endon("death");
  player setclientomnvar("ui_killstreak_countdown", gettime() + int(drone_config.timeout * 1000));
  wait drone_config.timeout;
  exit_drone(player, drone);
  drone_explode(drone);
}

function damage_monitor(player, drone, drone_config) {
  drone endon("death");
  drone setCanDamage(1);
  drone.health = 999999;
  drone.maxhealth = 999999;
  drone.fake_health = drone_config.health;
  original_health = drone_config.health;
  player setclientomnvar("ui_killstreak_health", 1);

  while(true) {
    drone waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, weapon);
    drone.health = 999999;
    drone.maxhealth = 999999;
    drone.fake_health -= damage;
    player setclientomnvar("ui_killstreak_health", drone.fake_health / original_health);

    if(isDefined(attacker) && isPlayer(attacker)) {
      attacker thread scripts\cp\damagefeedback::updatedamagefeedback("standard");
    }

    if(drone.fake_health < 0) {
      exit_drone(player, drone);
      drone_explode(drone);
    }
  }
}

function remote_detonation_monitor(player, drone) {
  drone endon("death");
  player notifyonplayercommand("remote_detonate", "+attack");
  dist = 1000;
  dist_sq = dist * dist;
  player.targets_for_remote_detonation = [];
  player thread show_ied_nearby_message_think(player, drone);
  player thread mark_detonate_targets(player, drone);
  player thread remove_outline_on_exit_think(player, drone);

  while(true) {
    if(soundexists("drone_mine_reload")) {
      drone playsoundtoplayer("drone_mine_reload", player);
    }

    player waittill("remote_detonate");

    foreach(target in player.targets_for_remote_detonation) {
      if(isai(target)) {
        target dodamage(5000, target.origin, player);
        continue;
      }

      target notify("damage", 5000, player);
    }

    if(soundexists("drone_mine_use")) {
      drone playsoundonmovingent("drone_mine_use");
    }

    waitframe();
  }
}

function show_ied_nearby_message_think(player, drone) {
  drone endon("death");
  player endon("death");
  player.showing_ied_nearby_message = 0;
  wait 0.15;

  while(true) {
    player.targets_for_remote_detonation = scripts\engine\utility::array_removeundefined(player.targets_for_remote_detonation);

    if(player.targets_for_remote_detonation.size > 0) {
      if(player.showing_ied_nearby_message == 0) {
        player setclientomnvar("cp_ied_nearby", 1);
        player.showing_ied_nearby_message = 1;
      }
    } else if(player.showing_ied_nearby_message == 1) {
      player setclientomnvar("cp_ied_nearby", 0);
      player.showing_ied_nearby_message = 0;
    }

    waitframe();
  }
}

function remove_outline_on_exit_think(player, drone) {
  player endon("disconnect");
  drone waittill("death");
  player setclientomnvar("cp_ied_nearby", 0);

  foreach(bomb in player.targets_for_remote_detonation) {
    bomb hudoutlinedisableforclient(player);
  }
}

function mark_detonate_targets(player, drone) {
  drone endon("death");
  player endon("death");
  dist = 1000;
  dist_sq = dist * dist;

  while(true) {
    if(isDefined(level.identified_ieds)) {
      foreach(bomb in level.identified_ieds) {
        if(distancesquared(bomb.origin, drone.origin) < dist_sq && player worldpointinreticle_circle(bomb.origin, 25, 115)) {
          show_bomb_to_drone(bomb, player);
          continue;
        }

        hide_bomb_from_drone(bomb, player);
      }
    }

    if(isDefined(level.spawned_enemies)) {
      foreach(guy in level.spawned_enemies) {
        if(isDefined(guy.unittype) && guy.unittype == "suicidebomber") {
          if(distancesquared(guy.origin, drone.origin) < dist_sq && player worldpointinreticle_circle(guy.origin, 25, 115)) {
            show_bomb_to_drone(guy, player);
            continue;
          }

          hide_bomb_from_drone(guy, player);
        }
      }
    }

    waitframe();
  }
}

function show_bomb_to_drone(identified_ied, player) {
  if(scripts\engine\utility::array_contains(player.targets_for_remote_detonation, identified_ied)) {
    return;
  }

  if(isDefined(identified_ied) && isDefined(identified_ied.origin)) {
    player.targets_for_remote_detonation = scripts\engine\utility::array_add(player.targets_for_remote_detonation, identified_ied);
    identified_ied hudoutlineenableforclient(player, 1, 0, 1);
  }
}

function hide_bomb_from_drone(identified_ied, player) {
  if(isDefined(identified_ied) && isDefined(identified_ied.origin)) {
    player.targets_for_remote_detonation = scripts\engine\utility::array_remove(player.targets_for_remote_detonation, identified_ied);
    identified_ied hudoutlinedisableforclient(player);
  }
}

function remove_ied_marker_vfx(ied) {
  if(isDefined(ied.mine_drone_marker_vfx)) {
    ied.mine_drone_marker_vfx delete();
  }
}

function drone_explode(drone) {
  playFX(level._effect["vfx_drone_explo"], drone.origin);
  drone delete();
}

function turn_on_drone_hud(player) {
  player setclientomnvar("cp_scout_drone_controls", 1);
  player visionsetnakedforplayer("cp_infected", 0);
}

function turn_off_drone_hud(player) {
  player setclientomnvar("cp_scout_drone_controls", 0);
  player visionsetnakedforplayer("", 0);
}

function find_safe_spawn(player) {
  startang = player.angles;
  zoffset = (0, 0, 35);
  spawndist = 30;
  heightoffset = zoffset[2];
  halfsize = 15;
  forward = anglesToForward(player.angles);
  right = anglestoright(player.angles);
  eyepos = player getEye();
  playerstance = player getstance();

  if(playerstance == "prone") {
    eyepos += (0, 0, 10);
  }

  startpos = eyepos + (0, 0, heightoffset);
  curpos = startpos + spawndist * forward;

  if(check_spawn_point(player, eyepos, curpos, halfsize)) {
    player.recondronesafespawn = curpos;
    return curpos;
  }

  curpos = startpos - spawndist * forward;

  if(check_spawn_point(player, eyepos, curpos, halfsize)) {
    player.recondronesafespawn = curpos;
    return curpos;
  }

  curpos += spawndist * right;

  if(check_spawn_point(player, eyepos, curpos, halfsize)) {
    player.recondronesafespawn = curpos;
    return curpos;
  }

  curpos = startpos - spawndist * right;

  if(check_spawn_point(player, eyepos, curpos, halfsize)) {
    player.recondronesafespawn = curpos;
    return curpos;
  }

  curpos = startpos;

  if(check_spawn_point(player, eyepos, curpos, halfsize)) {
    player.recondronesafespawn = curpos;
    return curpos;
  }

  waitframe();
  curpos = startpos + 0.707 * spawndist * (forward + right);

  if(check_spawn_point(player, eyepos, curpos, halfsize)) {
    player.recondronesafespawn = curpos;
    return curpos;
  }

  curpos = startpos + 0.707 * spawndist * (forward - right);

  if(check_spawn_point(player, eyepos, curpos, halfsize)) {
    player.recondronesafespawn = curpos;
    return curpos;
  }

  curpos = startpos + 0.707 * spawndist * (right - forward);

  if(check_spawn_point(player, eyepos, curpos, halfsize)) {
    player.recondronesafespawn = curpos;
    return curpos;
  }

  curpos = startpos + 0.707 * spawndist * (-1 * forward - right);

  if(check_spawn_point(player, eyepos, curpos, halfsize)) {
    player.recondronesafespawn = curpos;
    return curpos;
  }

  return startpos;
}

function check_spawn_point(player, start_point, spawn_point, halfsize) {
  result = 0;
  collisioncontents = physics_createcontents(["physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);

  if(scripts\engine\trace::sphere_trace_passed(start_point, start_point, halfsize, player, collisioncontents)) {
    result = 1;
  }

  return result;
}

function load_fx() {
  level._effect["vfx_drone_explo"] = loadfx("vfx/iw8_mp/killstreak/vfx_drone_sm_dest_exp.vfx");
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\drone\utility.gsc
***********************************************/

deploy_drone(player, _id_D121285BBE12FC18) {
  if(istrue(player.using_drone))
    return 0;

  player.using_drone = 1;
  player.disable_map_tablet = 1;
  player.pre_drone_weapon = player getcurrentweapon();

  if(istrue(_id_D121285BBE12FC18.play_intro)) {
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

  if(!istrue(_id_D121285BBE12FC18.no_control)) {
    player _id_3B64EB40368C1450::set("deploy_drone", "weapon_switch", 0);
    return deploy_helper_drone_actual(player, _id_D121285BBE12FC18);
  } else {
    player takeweapon("ks_remote_drone_mp");
    player switchtoweapon(player.pre_drone_weapon);
    player.using_drone = undefined;
    return 1;
  }
}

deploy_helper_drone_actual(player, _id_D121285BBE12FC18) {
  _id_D5685B7BAEE6505E = player.origin + (0, 0, 150);

  if(!istrue(_id_D121285BBE12FC18.detonate_mines))
    _id_D5685B7BAEE6505E = find_safe_spawn(player);

  drone = create_drone(player, _id_D5685B7BAEE6505E, _id_D121285BBE12FC18);

  if(isDefined(drone)) {
    if(player isjumping())
      player setOrigin(scripts\engine\utility::drop_to_ground(player.origin));

    if(istrue(player.dont_move_from_drone)) {
      player notify("drone_linked");
      waitframe();
    }

    player cameralinkTo(drone, "tag_origin");
    player remotecontrolvehicle(drone);
    player notify("drone_exists");
    player.drone = drone;
    player _id_3B64EB40368C1450::set("drone", "usability", 0);

    if(istrue(_id_D121285BBE12FC18.send_down))
      drone thread send_drone_down(drone, player, _id_D121285BBE12FC18);

    turn_on_drone_hud(player);

    if(!istrue(player.dont_move_from_drone)) {
      player thread keep_player_on_ground();
      player thread move_away_from_vehicles();
    }

    player.pre_drone_angles = player getplayerangles();
    return 1;
  }

  return 0;
}

send_drone_down(drone, player, _id_D121285BBE12FC18) {
  wait 0.05;
  loc = scripts\engine\utility::drop_to_ground(drone.origin, -1500, -30000);
  loc = loc + (0, 0, 2500);
}

keep_player_on_ground() {
  while(istrue(self.using_drone)) {
    loc = scripts\engine\utility::drop_to_ground(self.origin);
    self setOrigin(loc);
    wait 0.05;
  }
}

move_away_from_vehicles() {
  self endon("death");
  level endon("game_ended");
  _id_340C9ED716C44138 = 600;
  _id_3B266F496EA9E0E9 = _id_340C9ED716C44138 * _id_340C9ED716C44138;
  _id_6B7BEE46F2C6DA28 = 0;
  _id_ABAB6BC73FCCEF65 = -3;
  _id_8425EFBC1DDF4A48 = self.origin;

  while(istrue(self.using_drone)) {
    if(_id_6B7BEE46F2C6DA28 >= _id_ABAB6BC73FCCEF65 + 3) {
      _id_FA0334FEC6BA2BAC = vehicle_getarray();

      foreach(vehicle in _id_FA0334FEC6BA2BAC) {
        if(distancesquared(self.origin, vehicle.origin) < _id_3B266F496EA9E0E9) {
          _id_B9E9097150D1298C = length2d(self.origin - _id_8425EFBC1DDF4A48);

          if(_id_B9E9097150D1298C > 500 && _id_B9E9097150D1298C < 5000) {
            scripts\cp\utility::moveplayerperpendicularly(1200);
            _id_ABAB6BC73FCCEF65 = _id_6B7BEE46F2C6DA28;
          }
        }
      }
    }

    _id_6B7BEE46F2C6DA28 = _id_6B7BEE46F2C6DA28 + 2;
    wait 2;
  }
}

exit_drone(player, drone) {
  if(isent(drone))
    drone playSound("recondrone_destroyed");

  if(!isent(drone)) {
    return;
  }
  player cameraunlink(drone);
  player remotecontrolvehicleoff();

  if(player hasweapon("ks_remote_drone_mp"))
    player takeweapon("ks_remote_drone_mp");

  player _id_3B64EB40368C1450::set("drone", "weapon_switch", 1);
  player.last_weapon = player.pre_drone_weapon;
  _id_929E81472980EC28 = player scripts\cp\utility::getweapontoswitchbackto();
  player switchtoweapon(_id_929E81472980EC28);
  player takeweapon("ks_remote_map_cp");
  player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("drone");
  turn_off_drone_hud(player);
  player setplayerangles(player.pre_drone_angles);
  player.using_drone = undefined;
  player.disable_map_tablet = undefined;
  player notify("exiting_drone");
  player notify("exit_mine_drone");
}

create_drone(player, _id_D5685B7BAEE6505E, _id_D121285BBE12FC18) {
  drone = spawnhelicopter(player, _id_D5685B7BAEE6505E, player getplayerangles(), _id_D121285BBE12FC18.vehicle_info, _id_D121285BBE12FC18.model);

  if(!isDefined(drone)) {
    return;
  }
  drone enableaimassist();
  drone setnodeploy(1);
  drone.speed = _id_D121285BBE12FC18.speed;
  drone.accel = _id_D121285BBE12FC18.accel;
  drone.angles = player.angles;
  drone.owner = player;
  drone.team = player.team;

  if(isDefined(_id_D121285BBE12FC18.self_destruct))
    drone.self_destruct = _id_D121285BBE12FC18.self_destruct;

  if(isDefined(_id_D121285BBE12FC18.detonate_mines))
    drone.detonate_mines = _id_D121285BBE12FC18.detonate_mines;

  if(isDefined(_id_D121285BBE12FC18.mark_ai))
    drone.mark_ai = _id_D121285BBE12FC18.mark_ai;

  if(isDefined(_id_D121285BBE12FC18.mark_vehicles))
    drone.mark_vehicles = _id_D121285BBE12FC18.mark_vehicles;

  drone vehicle_setspeed(drone.speed, drone.accel);
  drone setotherent(player);
  drone vehicle_invoketriggers(1);
  drone vehicle_breakglass(1);
  drone.useobj = spawn("script_model", drone.origin);
  drone.useobj setModel("tag_origin");
  drone.useobj linkTo(drone, "tag_origin");
  drone.useobj hide();
  drone thread timeout_monitor(player, drone, _id_D121285BBE12FC18);
  drone thread damage_monitor(player, drone, _id_D121285BBE12FC18);
  drone thread player_exit_monitor(player, drone);

  if(istrue(_id_D121285BBE12FC18.detonate_mines))
    drone thread remote_detonation_monitor(player, drone);

  if(isDefined(_id_D121285BBE12FC18.use_func))
    drone thread[[_id_D121285BBE12FC18.use_func]](player, drone);

  return drone;
}

player_exit_monitor(player, drone) {
  drone endon("death");
  player notifyonplayercommand("exit_drone", "+stance");
  result = player scripts\engine\utility::waittill_any_3("last_stand", "disconnect", "exit_drone");
  exit_drone(player, drone);
  drone_explode(drone);
}

timeout_monitor(player, drone, _id_D121285BBE12FC18) {
  drone endon("death");
  player setclientomnvar("ui_killstreak_countdown", gettime() + int(_id_D121285BBE12FC18.timeout * 1000));
  wait(_id_D121285BBE12FC18.timeout);
  exit_drone(player, drone);
  drone_explode(drone);
}

damage_monitor(player, drone, _id_D121285BBE12FC18) {
  drone endon("death");
  drone setCanDamage(1);
  drone.health = 999999;
  drone.maxhealth = 999999;
  drone.fake_health = _id_D121285BBE12FC18.health;
  original_health = _id_D121285BBE12FC18.health;
  player setclientomnvar("ui_killstreak_health", 1);

  for(;;) {
    drone waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, weapon);
    drone.health = 999999;
    drone.maxhealth = 999999;
    drone.fake_health = drone.fake_health - damage;
    player setclientomnvar("ui_killstreak_health", drone.fake_health / original_health);

    if(isDefined(attacker) && isPlayer(attacker))
      attacker thread _id_354C862768CFE202::updatedamagefeedback("standard");

    if(drone.fake_health < 0) {
      exit_drone(player, drone);
      drone_explode(drone);
    }
  }
}

remote_detonation_monitor(player, drone) {
  drone endon("death");
  player notifyonplayercommand("remote_detonate", "+attack");
  dist = 1000;
  _id_ABD9EE4725B96FC2 = dist * dist;
  player.targets_for_remote_detonation = [];
  player thread show_ied_nearby_message_think(player, drone);
  player thread mark_detonate_targets(player, drone);
  player thread remove_outline_on_exit_think(player, drone);

  for(;;) {
    if(soundexists("drone_mine_reload"))
      drone playsoundtoplayer("drone_mine_reload", player);

    player waittill("remote_detonate");

    foreach(target in player.targets_for_remote_detonation) {
      if(isai(target)) {
        target dodamage(5000, target.origin, player);
        continue;
      }

      target notify("damage", 5000, player);
    }

    if(soundexists("drone_mine_use"))
      drone playsoundonmovingent("drone_mine_use");

    waitframe();
  }
}

show_ied_nearby_message_think(player, drone) {
  drone endon("death");
  player endon("death");
  player.showing_ied_nearby_message = 0;
  wait 0.15;

  for(;;) {
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

remove_outline_on_exit_think(player, drone) {
  player endon("disconnect");
  drone waittill("death");
  player setclientomnvar("cp_ied_nearby", 0);

  foreach(bomb in player.targets_for_remote_detonation)
  bomb hudoutlinedisableforclient(player);
}

mark_detonate_targets(player, drone) {
  drone endon("death");
  player endon("death");
  dist = 1000;
  _id_ABD9EE4725B96FC2 = dist * dist;

  for(;;) {
    if(isDefined(level.identified_ieds)) {
      foreach(bomb in level.identified_ieds) {
        if(distancesquared(bomb.origin, drone.origin) < _id_ABD9EE4725B96FC2 && player worldpointinreticle_circle(bomb.origin, 25, 115)) {
          show_bomb_to_drone(bomb, player);
          continue;
        }

        hide_bomb_from_drone(bomb, player);
      }
    }

    if(isDefined(level.spawned_enemies)) {
      foreach(guy in level.spawned_enemies) {
        if(isDefined(guy.unittype) && guy.unittype == "suicidebomber") {
          if(distancesquared(guy.origin, drone.origin) < _id_ABD9EE4725B96FC2 && player worldpointinreticle_circle(guy.origin, 25, 115)) {
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

show_bomb_to_drone(_id_CC9B13F67AE12715, player) {
  if(scripts\engine\utility::array_contains(player.targets_for_remote_detonation, _id_CC9B13F67AE12715)) {
    return;
  }
  if(isDefined(_id_CC9B13F67AE12715) && isDefined(_id_CC9B13F67AE12715.origin)) {
    player.targets_for_remote_detonation = scripts\engine\utility::array_add(player.targets_for_remote_detonation, _id_CC9B13F67AE12715);
    _id_CC9B13F67AE12715 hudoutlineenableforclient(player, 1, 0, 1);
  }
}

hide_bomb_from_drone(_id_CC9B13F67AE12715, player) {
  if(isDefined(_id_CC9B13F67AE12715) && isDefined(_id_CC9B13F67AE12715.origin)) {
    player.targets_for_remote_detonation = scripts\engine\utility::array_remove(player.targets_for_remote_detonation, _id_CC9B13F67AE12715);
    _id_CC9B13F67AE12715 hudoutlinedisableforclient(player);
  }
}

remove_ied_marker_vfx(_id_FE938103F6354AA9) {
  if(isDefined(_id_FE938103F6354AA9.mine_drone_marker_vfx))
    _id_FE938103F6354AA9.mine_drone_marker_vfx delete();
}

drone_explode(drone) {
  playFX(level._effect["vfx_drone_explo"], drone.origin);
  drone delete();
}

turn_on_drone_hud(player) {
  player setclientomnvar("cp_scout_drone_controls", 1);
  player visionsetnakedforplayer("cp_infected", 0);
}

turn_off_drone_hud(player) {
  player setclientomnvar("cp_scout_drone_controls", 0);
  player visionsetnakedforplayer("", 0);
}

find_safe_spawn(player) {
  startang = player.angles;
  zoffset = (0, 0, 35);
  spawndist = 30;
  heightoffset = zoffset[2];
  halfsize = 15;
  forward = anglesToForward(player.angles);
  right = anglestoright(player.angles);
  _id_52241BCC3A205EF4 = player getEye();
  _id_D33961AFF90DFA24 = player getstance();

  if(_id_D33961AFF90DFA24 == "prone")
    _id_52241BCC3A205EF4 = _id_52241BCC3A205EF4 + (0, 0, 10);

  startpos = _id_52241BCC3A205EF4 + (0, 0, heightoffset);
  _id_850A0F04F8EDABA5 = startpos + spawndist * forward;

  if(check_spawn_point(player, _id_52241BCC3A205EF4, _id_850A0F04F8EDABA5, halfsize)) {
    player.recondronesafespawn = _id_850A0F04F8EDABA5;
    return _id_850A0F04F8EDABA5;
  }

  _id_850A0F04F8EDABA5 = startpos - spawndist * forward;

  if(check_spawn_point(player, _id_52241BCC3A205EF4, _id_850A0F04F8EDABA5, halfsize)) {
    player.recondronesafespawn = _id_850A0F04F8EDABA5;
    return _id_850A0F04F8EDABA5;
  }

  _id_850A0F04F8EDABA5 = _id_850A0F04F8EDABA5 + spawndist * right;

  if(check_spawn_point(player, _id_52241BCC3A205EF4, _id_850A0F04F8EDABA5, halfsize)) {
    player.recondronesafespawn = _id_850A0F04F8EDABA5;
    return _id_850A0F04F8EDABA5;
  }

  _id_850A0F04F8EDABA5 = startpos - spawndist * right;

  if(check_spawn_point(player, _id_52241BCC3A205EF4, _id_850A0F04F8EDABA5, halfsize)) {
    player.recondronesafespawn = _id_850A0F04F8EDABA5;
    return _id_850A0F04F8EDABA5;
  }

  _id_850A0F04F8EDABA5 = startpos;

  if(check_spawn_point(player, _id_52241BCC3A205EF4, _id_850A0F04F8EDABA5, halfsize)) {
    player.recondronesafespawn = _id_850A0F04F8EDABA5;
    return _id_850A0F04F8EDABA5;
  }

  waitframe();
  _id_850A0F04F8EDABA5 = startpos + 0.707 * spawndist * (forward + right);

  if(check_spawn_point(player, _id_52241BCC3A205EF4, _id_850A0F04F8EDABA5, halfsize)) {
    player.recondronesafespawn = _id_850A0F04F8EDABA5;
    return _id_850A0F04F8EDABA5;
  }

  _id_850A0F04F8EDABA5 = startpos + 0.707 * spawndist * (forward - right);

  if(check_spawn_point(player, _id_52241BCC3A205EF4, _id_850A0F04F8EDABA5, halfsize)) {
    player.recondronesafespawn = _id_850A0F04F8EDABA5;
    return _id_850A0F04F8EDABA5;
  }

  _id_850A0F04F8EDABA5 = startpos + 0.707 * spawndist * (right - forward);

  if(check_spawn_point(player, _id_52241BCC3A205EF4, _id_850A0F04F8EDABA5, halfsize)) {
    player.recondronesafespawn = _id_850A0F04F8EDABA5;
    return _id_850A0F04F8EDABA5;
  }

  _id_850A0F04F8EDABA5 = startpos + 0.707 * spawndist * (-1 * forward - right);

  if(check_spawn_point(player, _id_52241BCC3A205EF4, _id_850A0F04F8EDABA5, halfsize)) {
    player.recondronesafespawn = _id_850A0F04F8EDABA5;
    return _id_850A0F04F8EDABA5;
  }

  return startpos;
}

check_spawn_point(player, start_point, spawn_point, halfsize) {
  result = 0;
  _id_1BFA180C6FDD09DD = physics_createcontents(["physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);

  if(scripts\engine\trace::sphere_trace_passed(start_point, start_point, halfsize, player, _id_1BFA180C6FDD09DD))
    result = 1;

  return result;
}

load_fx() {
  level._effect["vfx_drone_explo"] = loadfx("vfx/iw8_mp/killstreak/vfx_drone_sm_dest_exp.vfx");
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\drone\utility.gsc
***********************************************/

function deploy_drone(var_0, var_1) {
  if(istrue(var_0.using_drone)) {
    return 0;
  }

  var_0.using_drone = 1;
  var_0.disable_map_tablet = 1;
  var_0.pre_drone_weapon = var_0 getcurrentweapon();

  if(istrue(var_1.play_intro)) {
    var_0 giveweapon("ks_remote_drone_mp");
    var_0 switchtoweapon("ks_remote_drone_mp");
    var_0 notifyonplayercommand("cancel_deploy_helper_drone", "+weapnext");
    var_2 = var_0 scripts\engine\utility::ref_143BA(0.6, "last_stand", "cancel_deploy_helper_drone");

    if(!isDefined(var_2) || var_2 != "timeout") {
      var_0 takeweapon("ks_remote_drone_mp");
      var_0 switchtoweapon(var_0.pre_drone_weapon);
      var_0.using_drone = undefined;
      return 0;
    }

    var_2 = var_0 scripts\engine\utility::ref_143B9(1.4, "last_stand");

    if(!isDefined(var_2) || var_2 != "timeout") {
      var_0 takeweapon("ks_remote_drone_mp");
      var_0 switchtoweapon(var_0.pre_drone_weapon);
      var_0.using_drone = undefined;
      return 0;
    }
  }

  if(!istrue(var_1.no_control)) {
    var_0 scripts\common\utility::allow_weapon_switch(0);
    return deploy_helper_drone_actual(var_0, var_1);
  }

  var_0 takeweapon("ks_remote_drone_mp");
  var_0 switchtoweapon(var_0.pre_drone_weapon);
  var_0.using_drone = undefined;
  return 1;
}

function deploy_helper_drone_actual(var_0, var_1) {
  var_2 = var_0.origin + (0, 0, 150);

  if(!istrue(var_1.detonate_mines)) {
    var_2 = find_safe_spawn(var_0);
  }

  var_3 = create_drone(var_0, var_2, var_1);

  if(isDefined(var_3)) {
    if(var_0 isjumping()) {
      var_0 setOrigin(scripts\engine\utility::drop_to_ground(var_0.origin));
    }

    if(istrue(var_0.dont_move_from_drone)) {
      var_0 notify("drone_linked");
      waitframe();
    }

    var_0 cameralinkTo(var_3, "tag_origin");
    var_0 remotecontrolvehicle(var_3);
    var_0 notify("drone_exists");
    var_0.drone = var_3;
    var_0 scripts\common\utility::allow_usability(0);

    if(istrue(var_1.send_down)) {
      thread send_drone_down(var_3, var_3, var_0);
    }

    turn_on_drone_hud(var_0);

    if(!istrue(var_0.dont_move_from_drone)) {
      thread keep_player_on_ground();
      thread move_away_from_vehicles();
    }

    var_0.pre_drone_angles = var_0 getplayerangles();
    return true;
  }

  return false;
}

function send_drone_down(var_0, var_1, var_2) {
  wait 0.05;
  var_3 = scripts\engine\utility::drop_to_ground(var_0.origin, -1500, -30000);
  var_3 += (0, 0, 2500);
}

function keep_player_on_ground() {
  while(istrue(self.using_drone)) {
    var_0 = scripts\engine\utility::drop_to_ground(self.origin);
    self setOrigin(var_0);
    wait 0.05;
  }
}

function move_away_from_vehicles() {
  self endon("death");
  level endon("game_ended");
  var_0 = 600;
  var_1 = var_0 * var_0;
  var_2 = 0;
  var_3 = -3;
  var_4 = self.origin;

  while(istrue(self.using_drone)) {
    if(var_2 >= var_3 + 3) {
      var_5 = vehicle_getarray();

      foreach(var_7 in var_5) {
        if(distancesquared(self.origin, var_7.origin) < var_1) {
          var_8 = length2d(self.origin - var_4);

          if(var_8 > 500 && var_8 < 5000) {
            scripts\cp\utility::moveplayerperpendicularly(1200);
            var_3 = var_2;
          }
        }
      }
    }

    var_2 += 2;
    wait 2;
  }
}

function exit_drone(var_0, var_1) {
  if(isent(var_1)) {
    var_1 playSound("recondrone_destroyed");
  }

  if(!isent(var_1)) {
    return;
  }

  var_0 cameraunlink(var_1);
  var_0 remotecontrolvehicleoff();

  if(var_0 hasweapon("ks_remote_drone_mp")) {
    var_0 takeweapon("ks_remote_drone_mp");
  }

  var_0 scripts\common\utility::allow_weapon_switch(1);
  var_0.last_weapon = var_0.pre_drone_weapon;
  var_2 = var_0 scripts\cp\utility::getweapontoswitchbackto();
  var_0 switchtoweapon(var_2);
  var_0 takeweapon("ks_remote_map_cp");
  var_0 scripts\common\utility::allow_usability(1);
  turn_off_drone_hud(var_0);
  var_0 setplayerangles(var_0.pre_drone_angles);
  var_0.using_drone = undefined;
  var_0.disable_map_tablet = undefined;
  var_0 notify("exiting_drone");
  var_0 notify("exit_mine_drone");
}

function create_drone(var_0, var_1, var_2) {
  var_3 = spawnhelicopter(var_0, var_1, var_0 getplayerangles(), var_2.vehicle_info, var_2.model);

  if(!isDefined(var_3)) {
    return;
  }

  var_3 enableaimassist();
  var_3 setnodeploy(1);
  var_3.speed = var_2.speed;
  var_3.accel = var_2.accel;
  var_3.angles = var_0.angles;
  var_3.owner = var_0;
  var_3.team = var_0.team;

  if(isDefined(var_2.self_destruct)) {
    var_3.self_destruct = var_2.self_destruct;
  }

  if(isDefined(var_2.detonate_mines)) {
    var_3.detonate_mines = var_2.detonate_mines;
  }

  if(isDefined(var_2.mark_ai)) {
    var_3.mark_ai = var_2.mark_ai;
  }

  if(isDefined(var_2.mark_vehicles)) {
    var_3.mark_vehicles = var_2.mark_vehicles;
  }

  var_3 vehicle_setspeed(var_3.speed, var_3.accel);
  var_3 setotherent(var_0);
  var_3 vehicle_invoketriggers(1);
  var_3 vehicle_breakglass(1);
  var_3.useobj = spawn("script_model", var_3.origin);
  var_3.useobj setModel("tag_origin");
  var_3.useobj linkTo(var_3, "tag_origin");
  var_3.useobj hide();
  thread timeout_monitor(var_3, var_0, var_3);
  thread damage_monitor(var_3, var_0, var_3);
  thread player_exit_monitor(var_3, var_0);

  if(istrue(var_2.detonate_mines)) {
    thread remote_detonation_monitor(var_3, var_0);
  }

  if(isDefined(var_2.use_func)) {
    var_3 thread[[var_2.use_func]](var_0, var_3);
  }

  return var_3;
}

function player_exit_monitor(var_0, var_1) {
  var_1 endon("death");
  var_0 notifyonplayercommand("exit_drone", "+stance");
  var_2 = var_0 scripts\engine\utility::ref_143A6("last_stand", "disconnect", "exit_drone");
  exit_drone(var_0, var_1);
  drone_explode(var_1);
}

function timeout_monitor(var_0, var_1, var_2) {
  var_1 endon("death");
  var_0 setclientomnvar("ui_killstreak_countdown", gettime() + int(var_2.timeout * 1000));
  wait var_2.timeout;
  exit_drone(var_0, var_1);
  drone_explode(var_1);
}

function damage_monitor(var_0, var_1, var_2) {
  var_1 endon("death");
  var_1 setCanDamage(1);
  var_1.health = 999999;
  var_1.maxhealth = 999999;
  var_1.fake_health = var_2.health;
  var_3 = var_2.health;
  var_0 setclientomnvar("ui_killstreak_health", 1);

  for(;;) {
    var_1 waittill("damage", var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    var_1.health = 999999;
    var_1.maxhealth = 999999;
    var_1.fake_health -= var_4;
    var_0 setclientomnvar("ui_killstreak_health", var_1.fake_health / var_3);

    if(isDefined(var_5) && isPlayer(var_5)) {
      var_5 thread scripts\cp\cp_damagefeedback::updatedamagefeedback("standard");
    }

    if(var_1.fake_health < 0) {
      exit_drone(var_0, var_1);
      drone_explode(var_1);
    }
  }
}

function remote_detonation_monitor(var_0, var_1) {
  var_1 endon("death");
  var_0 notifyonplayercommand("remote_detonate", "+attack");
  var_2 = 1000;
  var_3 = var_2 * var_2;
  var_0.targets_for_remote_detonation = [];
  thread show_ied_nearby_message_think(var_0, var_0);
  thread mark_detonate_targets(var_0, var_0);
  thread remove_outline_on_exit_think(var_0, var_0);

  for(;;) {
    if(soundexists("drone_mine_reload")) {
      var_1 playsoundtoplayer("drone_mine_reload", var_0);
    }

    var_0 waittill("remote_detonate");

    foreach(var_5 in var_0.targets_for_remote_detonation) {
      if(isai(var_5)) {
        var_5 dodamage(5000, var_5.origin, var_0);
        continue;
      }

      var_5 notify("damage", 5000, var_0);
    }

    if(soundexists("drone_mine_use")) {
      var_1 playsoundonmovingent("drone_mine_use");
    }

    waitframe();
  }
}

function show_ied_nearby_message_think(var_0, var_1) {
  var_1 endon("death");
  var_0 endon("death");
  var_0.showing_ied_nearby_message = 0;
  wait 0.15;

  for(;;) {
    var_0.targets_for_remote_detonation = scripts\engine\utility::array_removeundefined(var_0.targets_for_remote_detonation);

    if(var_0.targets_for_remote_detonation.size > 0) {
      if(var_0.showing_ied_nearby_message == 0) {
        var_0 setclientomnvar("cp_ied_nearby", 1);
        var_0.showing_ied_nearby_message = 1;
      }
    } else if(var_0.showing_ied_nearby_message == 1) {
      var_0 setclientomnvar("cp_ied_nearby", 0);
      var_0.showing_ied_nearby_message = 0;
    }

    waitframe();
  }
}

function remove_outline_on_exit_think(var_0, var_1) {
  var_0 endon("disconnect");
  var_1 waittill("death");
  var_0 setclientomnvar("cp_ied_nearby", 0);

  foreach(var_3 in var_0.targets_for_remote_detonation) {
    var_3 hudoutlinedisableforclient(var_0);
  }
}

function mark_detonate_targets(var_0, var_1) {
  var_1 endon("death");
  var_0 endon("death");
  var_2 = 1000;
  var_3 = var_2 * var_2;

  for(;;) {
    if(isDefined(level.identified_ieds)) {
      foreach(var_5 in level.identified_ieds) {
        if(distancesquared(var_5.origin, var_1.origin) < var_3 && var_0 worldpointinreticle_circle(var_5.origin, 25, 115)) {
          show_bomb_to_drone(var_5, var_0);
          continue;
        }

        hide_bomb_from_drone(var_5, var_0);
      }
    }

    if(isDefined(level.spawned_enemies)) {
      foreach(var_8 in level.spawned_enemies) {
        if(isDefined(var_8.unittype) && var_8.unittype == "suicidebomber") {
          if(distancesquared(var_8.origin, var_1.origin) < var_3 && var_0 worldpointinreticle_circle(var_8.origin, 25, 115)) {
            show_bomb_to_drone(var_8, var_0);
            continue;
          }

          hide_bomb_from_drone(var_8, var_0);
        }
      }
    }

    waitframe();
  }
}

function show_bomb_to_drone(var_0, var_1) {
  if(scripts\engine\utility::array_contains(var_1.targets_for_remote_detonation, var_0)) {
    return;
  }

  if(isDefined(var_0) && isDefined(var_0.origin)) {
    var_1.targets_for_remote_detonation = scripts\engine\utility::array_add(var_1.targets_for_remote_detonation, var_0);
    var_0 hudoutlineenableforclient(var_1, 1, 0, 1);
    return;
  }
}

function hide_bomb_from_drone(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_0.origin)) {
    var_1.targets_for_remote_detonation = scripts\engine\utility::array_remove(var_1.targets_for_remote_detonation, var_0);
    var_0 hudoutlinedisableforclient(var_1);
    return;
  }
}

function remove_ied_marker_vfx(var_0) {
  if(isDefined(var_0.mine_drone_marker_vfx)) {
    var_0.mine_drone_marker_vfx delete();
    return;
  }
}

function drone_explode(var_0) {
  playFX(level._effect["vfx_drone_explo"], var_0.origin);
  var_0 delete();
}

function turn_on_drone_hud(var_0) {
  var_0 setclientomnvar("cp_scout_drone_controls", 1);
  var_0 visionsetnakedforplayer("cp_infected", 0);
}

function turn_off_drone_hud(var_0) {
  var_0 setclientomnvar("cp_scout_drone_controls", 0);
  var_0 visionsetnakedforplayer("", 0);
}

function find_safe_spawn(var_0) {
  var_1 = var_0.angles;
  var_2 = (0, 0, 35);
  var_3 = 30;
  var_4 = var_2[2];
  var_5 = 15;
  var_6 = anglesToForward(var_0.angles);
  var_7 = anglestoright(var_0.angles);
  var_8 = var_0 getEye();
  var_9 = var_0 getstance();

  if(var_9 == "prone") {
    var_8 += (0, 0, 10);
  }

  var_10 = var_8 + (0, 0, var_4);
  var_11 = var_10 + var_3 * var_6;

  if(check_spawn_point(var_0, var_8, var_11, var_5)) {
    var_0.recondronesafespawn = var_11;
    return var_11;
  }

  var_11 = var_10 - var_3 * var_6;

  if(check_spawn_point(var_0, var_8, var_11, var_5)) {
    var_0.recondronesafespawn = var_11;
    return var_11;
  }

  var_11 += var_3 * var_7;

  if(check_spawn_point(var_0, var_8, var_11, var_5)) {
    var_0.recondronesafespawn = var_11;
    return var_11;
  }

  var_11 = var_10 - var_3 * var_7;

  if(check_spawn_point(var_0, var_8, var_11, var_5)) {
    var_0.recondronesafespawn = var_11;
    return var_11;
  }

  var_11 = var_10;

  if(check_spawn_point(var_0, var_8, var_11, var_5)) {
    var_0.recondronesafespawn = var_11;
    return var_11;
  }

  waitframe();
  var_11 = var_10 + 0.707 * var_3 * (var_6 + var_7);

  if(check_spawn_point(var_0, var_8, var_11, var_5)) {
    var_0.recondronesafespawn = var_11;
    return var_11;
  }

  var_11 = var_10 + 0.707 * var_3 * (var_6 - var_7);

  if(check_spawn_point(var_0, var_8, var_11, var_5)) {
    var_0.recondronesafespawn = var_11;
    return var_11;
  }

  var_11 = var_10 + 0.707 * var_3 * (var_7 - var_6);

  if(check_spawn_point(var_0, var_8, var_11, var_5)) {
    var_0.recondronesafespawn = var_11;
    return var_11;
  }

  var_11 = var_10 + 0.707 * var_3 * (-1 * var_6 - var_7);

  if(check_spawn_point(var_0, var_8, var_11, var_5)) {
    var_0.recondronesafespawn = var_11;
    return var_11;
  }

  return var_10;
}

function check_spawn_point(var_0, var_1, var_2, var_3) {
  var_4 = 0;
  var_5 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);

  if(scripts\engine\trace::sphere_trace_passed(var_1, var_1, var_3, var_0, var_5)) {
    var_4 = 1;
  }

  return var_4;
}

function load_fx() {
  level._effect["vfx_drone_explo"] = loadfx("vfx/iw8_mp/killstreak/vfx_drone_sm_dest_exp.vfx");
}
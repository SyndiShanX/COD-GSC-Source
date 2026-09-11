/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\drone\utility.gsc
***********************************************/

function deploy_drone(var0, var1) {
  if(istrue(var0.using_drone)) {
    return 0;
  }

  var0.using_drone = 1;
  var0.disable_map_tablet = 1;
  var0.pre_drone_weapon = var0 getcurrentweapon();

  if(istrue(var1.play_intro)) {
    var0 giveweapon("ks_remote_drone_mp");
    var0 switchtoweapon("ks_remote_drone_mp");
    var0 notifyonplayercommand("cancel_deploy_helper_drone", "+weapnext");
    var2 = var0 scripts\engine\utility::ref_143ba(0.6, "last_stand", "cancel_deploy_helper_drone");

    if(!isDefined(var2) || var2 != "timeout") {
      var0 takeweapon("ks_remote_drone_mp");
      var0 switchtoweapon(var0.pre_drone_weapon);
      var0.using_drone = undefined;
      return 0;
    }

    var2 = var0 scripts\engine\utility::ref_143b9(1.4, "last_stand");

    if(!isDefined(var2) || var2 != "timeout") {
      var0 takeweapon("ks_remote_drone_mp");
      var0 switchtoweapon(var0.pre_drone_weapon);
      var0.using_drone = undefined;
      return 0;
    }
  }

  if(!istrue(var1.no_control)) {
    var0 scripts\common\utility::allow_weapon_switch(0);
    return deploy_helper_drone_actual(var0, var1);
  }

  var0 takeweapon("ks_remote_drone_mp");
  var0 switchtoweapon(var0.pre_drone_weapon);
  var0.using_drone = undefined;
  return 1;
}

function deploy_helper_drone_actual(var0, var1) {
  var2 = var0.origin + (0, 0, 150);

  if(!istrue(var1.detonate_mines)) {
    var2 = find_safe_spawn(var0);
  }

  var3 = create_drone(var0, var2, var1);

  if(isDefined(var3)) {
    if(var0 isjumping()) {
      var0 setOrigin(scripts\engine\utility::drop_to_ground(var0.origin));
    }

    if(istrue(var0.dont_move_from_drone)) {
      var0 notify("drone_linked");
      waitframe();
    }

    var0 cameralinkTo(var3, "tag_origin");
    var0 remotecontrolvehicle(var3);
    var0 notify("drone_exists");
    var0.drone = var3;
    var0 scripts\common\utility::allow_usability(0);

    if(istrue(var1.send_down)) {
      thread send_drone_down(var3, var3, var0);
    }

    turn_on_drone_hud(var0);

    if(!istrue(var0.dont_move_from_drone)) {
      thread keep_player_on_ground();
      thread move_away_from_vehicles();
    }

    var0.pre_drone_angles = var0 getplayerangles();
    return true;
  }

  return false;
}

function send_drone_down(var0, var1, var2) {
  wait 0.05;
  var3 = scripts\engine\utility::drop_to_ground(var0.origin, -1500, -30000);
  var3 += (0, 0, 2500);
}

function keep_player_on_ground() {
  while(istrue(self.using_drone)) {
    var0 = scripts\engine\utility::drop_to_ground(self.origin);
    self setOrigin(var0);
    wait 0.05;
  }
}

function move_away_from_vehicles() {
  self endon("death");
  level endon("game_ended");
  var0 = 600;
  var1 = var0 * var0;
  var2 = 0;
  var3 = -3;
  var4 = self.origin;

  while(istrue(self.using_drone)) {
    if(var2 >= var3 + 3) {
      var5 = vehicle_getarray();

      foreach(var7 in var5) {
        if(distancesquared(self.origin, var7.origin) < var1) {
          var8 = length2d(self.origin - var4);

          if(var8 > 500 && var8 < 5000) {
            scripts\cp\utility::moveplayerperpendicularly(1200);
            var3 = var2;
          }
        }
      }
    }

    var2 += 2;
    wait 2;
  }
}

function exit_drone(var0, var1) {
  if(isent(var1)) {
    var1 playSound("recondrone_destroyed");
  }

  if(!isent(var1)) {
    return;
  }

  var0 cameraunlink(var1);
  var0 remotecontrolvehicleoff();

  if(var0 hasweapon("ks_remote_drone_mp")) {
    var0 takeweapon("ks_remote_drone_mp");
  }

  var0 scripts\common\utility::allow_weapon_switch(1);
  var0.last_weapon = var0.pre_drone_weapon;
  var2 = var0 scripts\cp\utility::getweapontoswitchbackto();
  var0 switchtoweapon(var2);
  var0 takeweapon("ks_remote_map_cp");
  var0 scripts\common\utility::allow_usability(1);
  turn_off_drone_hud(var0);
  var0 setplayerangles(var0.pre_drone_angles);
  var0.using_drone = undefined;
  var0.disable_map_tablet = undefined;
  var0 notify("exiting_drone");
  var0 notify("exit_mine_drone");
}

function create_drone(var0, var1, var2) {
  var3 = spawnhelicopter(var0, var1, var0 getplayerangles(), var2.vehicle_info, var2.model);

  if(!isDefined(var3)) {
    return;
  }

  var3 enableaimassist();
  var3 setnodeploy(1);
  var3.speed = var2.speed;
  var3.accel = var2.accel;
  var3.angles = var0.angles;
  var3.owner = var0;
  var3.team = var0.team;

  if(isDefined(var2.self_destruct)) {
    var3.self_destruct = var2.self_destruct;
  }

  if(isDefined(var2.detonate_mines)) {
    var3.detonate_mines = var2.detonate_mines;
  }

  if(isDefined(var2.mark_ai)) {
    var3.mark_ai = var2.mark_ai;
  }

  if(isDefined(var2.mark_vehicles)) {
    var3.mark_vehicles = var2.mark_vehicles;
  }

  var3 vehicle_setspeed(var3.speed, var3.accel);
  var3 setotherent(var0);
  var3 vehicle_invoketriggers(1);
  var3 vehicle_breakglass(1);
  var3.useobj = spawn("script_model", var3.origin);
  var3.useobj setModel("tag_origin");
  var3.useobj linkTo(var3, "tag_origin");
  var3.useobj hide();
  thread timeout_monitor(var3, var0, var3);
  thread damage_monitor(var3, var0, var3);
  thread player_exit_monitor(var3, var0);

  if(istrue(var2.detonate_mines)) {
    thread remote_detonation_monitor(var3, var0);
  }

  if(isDefined(var2.use_func)) {
    var3 thread[[var2.use_func]](var0, var3);
  }

  return var3;
}

function player_exit_monitor(var0, var1) {
  var1 endon("death");
  var0 notifyonplayercommand("exit_drone", "+stance");
  var2 = var0 scripts\engine\utility::ref_143a6("last_stand", "disconnect", "exit_drone");
  exit_drone(var0, var1);
  drone_explode(var1);
}

function timeout_monitor(var0, var1, var2) {
  var1 endon("death");
  var0 setclientomnvar("ui_killstreak_countdown", gettime() + int(var2.timeout * 1000));
  wait var2.timeout;
  exit_drone(var0, var1);
  drone_explode(var1);
}

function damage_monitor(var0, var1, var2) {
  var1 endon("death");
  var1 setCanDamage(1);
  var1.health = 999999;
  var1.maxhealth = 999999;
  var1.fake_health = var2.health;
  var3 = var2.health;
  var0 setclientomnvar("ui_killstreak_health", 1);

  for(;;) {
    var1 waittill("damage", var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);
    var1.health = 999999;
    var1.maxhealth = 999999;
    var1.fake_health -= var4;
    var0 setclientomnvar("ui_killstreak_health", var1.fake_health / var3);

    if(isDefined(var5) && isPlayer(var5)) {
      var5 thread scripts\cp\cp_damagefeedback::updatedamagefeedback("standard");
    }

    if(var1.fake_health < 0) {
      exit_drone(var0, var1);
      drone_explode(var1);
    }
  }
}

function remote_detonation_monitor(var0, var1) {
  var1 endon("death");
  var0 notifyonplayercommand("remote_detonate", "+attack");
  var2 = 1000;
  var3 = var2 * var2;
  var0.targets_for_remote_detonation = [];
  thread show_ied_nearby_message_think(var0, var0);
  thread mark_detonate_targets(var0, var0);
  thread remove_outline_on_exit_think(var0, var0);

  for(;;) {
    if(soundexists("drone_mine_reload")) {
      var1 playsoundtoplayer("drone_mine_reload", var0);
    }

    var0 waittill("remote_detonate");

    foreach(var5 in var0.targets_for_remote_detonation) {
      if(isai(var5)) {
        var5 dodamage(5000, var5.origin, var0);
        continue;
      }

      var5 notify("damage", 5000, var0);
    }

    if(soundexists("drone_mine_use")) {
      var1 playsoundonmovingent("drone_mine_use");
    }

    waitframe();
  }
}

function show_ied_nearby_message_think(var0, var1) {
  var1 endon("death");
  var0 endon("death");
  var0.showing_ied_nearby_message = 0;
  wait 0.15;

  for(;;) {
    var0.targets_for_remote_detonation = scripts\engine\utility::array_removeundefined(var0.targets_for_remote_detonation);

    if(var0.targets_for_remote_detonation.size > 0) {
      if(var0.showing_ied_nearby_message == 0) {
        var0 setclientomnvar("cp_ied_nearby", 1);
        var0.showing_ied_nearby_message = 1;
      }
    } else if(var0.showing_ied_nearby_message == 1) {
      var0 setclientomnvar("cp_ied_nearby", 0);
      var0.showing_ied_nearby_message = 0;
    }

    waitframe();
  }
}

function remove_outline_on_exit_think(var0, var1) {
  var0 endon("disconnect");
  var1 waittill("death");
  var0 setclientomnvar("cp_ied_nearby", 0);

  foreach(var3 in var0.targets_for_remote_detonation) {
    var3 hudoutlinedisableforclient(var0);
  }
}

function mark_detonate_targets(var0, var1) {
  var1 endon("death");
  var0 endon("death");
  var2 = 1000;
  var3 = var2 * var2;

  for(;;) {
    if(isDefined(level.identified_ieds)) {
      foreach(var5 in level.identified_ieds) {
        if(distancesquared(var5.origin, var1.origin) < var3 && var0 worldpointinreticle_circle(var5.origin, 25, 115)) {
          show_bomb_to_drone(var5, var0);
          continue;
        }

        hide_bomb_from_drone(var5, var0);
      }
    }

    if(isDefined(level.spawned_enemies)) {
      foreach(var8 in level.spawned_enemies) {
        if(isDefined(var8.unittype) && var8.unittype == "suicidebomber") {
          if(distancesquared(var8.origin, var1.origin) < var3 && var0 worldpointinreticle_circle(var8.origin, 25, 115)) {
            show_bomb_to_drone(var8, var0);
            continue;
          }

          hide_bomb_from_drone(var8, var0);
        }
      }
    }

    waitframe();
  }
}

function show_bomb_to_drone(var0, var1) {
  if(scripts\engine\utility::array_contains(var1.targets_for_remote_detonation, var0)) {
    return;
  }

  if(isDefined(var0) && isDefined(var0.origin)) {
    var1.targets_for_remote_detonation = scripts\engine\utility::array_add(var1.targets_for_remote_detonation, var0);
    var0 hudoutlineenableforclient(var1, 1, 0, 1);
    return;
  }
}

function hide_bomb_from_drone(var0, var1) {
  if(isDefined(var0) && isDefined(var0.origin)) {
    var1.targets_for_remote_detonation = scripts\engine\utility::array_remove(var1.targets_for_remote_detonation, var0);
    var0 hudoutlinedisableforclient(var1);
    return;
  }
}

function remove_ied_marker_vfx(var0) {
  if(isDefined(var0.mine_drone_marker_vfx)) {
    var0.mine_drone_marker_vfx delete();
    return;
  }
}

function drone_explode(var0) {
  playFX(level._effect["vfx_drone_explo"], var0.origin);
  var0 delete();
}

function turn_on_drone_hud(var0) {
  var0 setclientomnvar("cp_scout_drone_controls", 1);
  var0 visionsetnakedforplayer("cp_infected", 0);
}

function turn_off_drone_hud(var0) {
  var0 setclientomnvar("cp_scout_drone_controls", 0);
  var0 visionsetnakedforplayer("", 0);
}

function find_safe_spawn(var0) {
  var1 = var0.angles;
  var2 = (0, 0, 35);
  var3 = 30;
  var4 = var2[2];
  var5 = 15;
  var6 = anglesToForward(var0.angles);
  var7 = anglestoright(var0.angles);
  var8 = var0 getEye();
  var9 = var0 getstance();

  if(var9 == "prone") {
    var8 += (0, 0, 10);
  }

  var10 = var8 + (0, 0, var4);
  var11 = var10 + var3 * var6;

  if(check_spawn_point(var0, var8, var11, var5)) {
    var0.recondronesafespawn = var11;
    return var11;
  }

  var11 = var10 - var3 * var6;

  if(check_spawn_point(var0, var8, var11, var5)) {
    var0.recondronesafespawn = var11;
    return var11;
  }

  var11 += var3 * var7;

  if(check_spawn_point(var0, var8, var11, var5)) {
    var0.recondronesafespawn = var11;
    return var11;
  }

  var11 = var10 - var3 * var7;

  if(check_spawn_point(var0, var8, var11, var5)) {
    var0.recondronesafespawn = var11;
    return var11;
  }

  var11 = var10;

  if(check_spawn_point(var0, var8, var11, var5)) {
    var0.recondronesafespawn = var11;
    return var11;
  }

  waitframe();
  var11 = var10 + 0.707 * var3 * (var6 + var7);

  if(check_spawn_point(var0, var8, var11, var5)) {
    var0.recondronesafespawn = var11;
    return var11;
  }

  var11 = var10 + 0.707 * var3 * (var6 - var7);

  if(check_spawn_point(var0, var8, var11, var5)) {
    var0.recondronesafespawn = var11;
    return var11;
  }

  var11 = var10 + 0.707 * var3 * (var7 - var6);

  if(check_spawn_point(var0, var8, var11, var5)) {
    var0.recondronesafespawn = var11;
    return var11;
  }

  var11 = var10 + 0.707 * var3 * (-1 * var6 - var7);

  if(check_spawn_point(var0, var8, var11, var5)) {
    var0.recondronesafespawn = var11;
    return var11;
  }

  return var10;
}

function check_spawn_point(var0, var1, var2, var3) {
  var4 = 0;
  var5 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);

  if(scripts\engine\trace::sphere_trace_passed(var1, var1, var3, var0, var5)) {
    var4 = 1;
  }

  return var4;
}

function load_fx() {
  level._effect["vfx_drone_explo"] = loadfx("vfx/iw8_mp/killstreak/vfx_drone_sm_dest_exp.vfx");
}
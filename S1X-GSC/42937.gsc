/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42937.gsc
**************************************/

assault_vehicle_ai_init() {
  thread maps\mp\_aerial_pathnodes::calculate_aerial_pathnodes();
}

aistartusingassaultvehicle(var_0) {
  thread assault_vehicle_ai_end_on_owner_disconnect(var_0);
  wait 2.0;
  maps\mp\_aerial_pathnodes::waittill_aerial_pathnodes_calculated();

  if(isDefined(var_0)) {
    var_0.enemy_target_last_vis_time = 0;
    var_0.enemy_target_visible = 0;
    var_0 thread assault_vehicle_ai_aerial_movement();
    var_0 thread assault_vehicle_ai_threat();
    var_0 thread assault_vehicle_ai_weapons(!var_0.hasturret);

    if(isDefined(level.ishorde) && level.ishorde) {
      self.aerialassaultdrone = var_0;
      var_0.isaerialassaultdrone = 1;
      var_0 thread assault_vehicle_horde_monitor_death(self);
    }
  }
}

assault_vehicle_horde_monitor_death(var_0) {
  self waittill("death");
  self.aerialassaultdrone = undefined;
}

assault_vehicle_ai_end_on_owner_disconnect(var_0) {
  var_0 endon("death");
  self waittill("disconnect");
  var_0 notify("death");
}

assault_vehicle_ai_aerial_movement() {
  self notify("assault_vehicle_ai_aerial_movement");
  self endon("assault_vehicle_ai_aerial_movement");
  self endon("death");
  var_0 = self vehicle_gettopspeed();
  self vehicle_setspeed(var_0, 8, 60);
  self sethoverparams(0, 0, 0);
  var_1 = undefined;
  var_2 = assault_vehicle_ai_get_nearest_node();

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = var_2;

  if(!maps\mp\_aerial_pathnodes::node_is_aerial(var_3)) {
    var_4 = maps\mp\_aerial_pathnodes::get_ent_closest_aerial_node(64, 0);

    if(isDefined(var_4)) {
      var_3 = var_4;
    }
  }

  if(maps\mp\_aerial_pathnodes::node_is_aerial(var_3)) {
    var_1 = getnodesonpath(self.origin, var_3.origin, 1, var_2);
  }

  if(!isDefined(var_1)) {
    var_5 = 1500;
    var_6 = 0;

    while(!isDefined(var_1) && var_6 < var_5) {
      var_7 = maps\mp\_aerial_pathnodes::get_ent_closest_aerial_node(var_5, var_6);

      if(isDefined(var_7)) {
        var_1 = getnodesonpath(self.origin, var_7.origin, 1, var_2);

        if(!isDefined(var_1)) {
          var_6 = distance(self.origin, var_7.origin) + 1;
        }

        continue;
      }

      var_6 = var_5 + 1;
    }

    if(var_6 > var_5) {
      return;
    }
  }

  var_8 = assault_vehicle_ai_aerial_follow_path_outside(var_1);
  assault_vehicle_ai_move_to_aerial_node(var_8);
  wait 0.85;
  var_9 = 1;

  if(var_9) {
    self notify("in_air");
    assault_vehicle_ai_aerial_pathing_turret(var_8);
  }
}

assault_vehicle_ai_aerial_follow_path_outside(var_0) {
  var_1 = (0, 0, 40);
  var_2 = undefined;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];

    if(isDefined(var_2) && isDefined(var_2.targetname) && var_2.targetname == "traverse") {
      assault_vehicle_ai_air_traverse(var_2, var_4, var_1);
    }

    assault_vehicle_ai_air_movement_func(var_4.origin + var_1);
    var_5 = 0;

    while(distance2dsquared(var_4.origin, self.origin) > squared(24.0)) {
      var_5 = var_5 + 0.05;

      if(var_5 > assault_vehicle_ai_path_timeout_time()) {
        return;
      }
      wait 0.05;
    }

    if(maps\mp\_aerial_pathnodes::node_is_aerial(var_4)) {
      return var_4;
    }

    var_2 = var_4;
  }

  return var_0[var_0.size - 1];
}

assault_vehicle_ai_move_to_aerial_node(var_0) {
  var_1 = var_0.origin + maps\mp\_aerial_pathnodes::get_aerial_offset();
  assault_vehicle_ai_air_movement_func(var_1);

  while(distancesquared(self.origin, var_1) > 576.0) {
    wait 0.05;
  }
}

assault_vehicle_ai_aerial_pathing_turret(var_0) {
  var_1 = var_0;
  var_2 = [];
  var_2[var_1 getnodenumber()] = 1;

  for(;;) {
    var_1 = assault_vehicle_ai_pick_aerial_node(var_1, var_2);
    assault_vehicle_ai_move_to_aerial_node(var_1);
    var_3 = var_1 getnodenumber();

    if(!isDefined(var_2[var_3])) {
      var_2[var_3] = 0;
    }

    var_2[var_3]++;
    wait(randomfloatrange(0.05, 2.0));
  }
}

assault_vehicle_ai_aerial_pathing_c4() {
  for(;;) {
    var_0 = undefined;

    if(assault_vehicle_ai_enemy_exists_and_is_alive()) {
      var_0 = self.enemy_target maps\mp\_aerial_pathnodes::get_ent_closest_aerial_node();
    }

    if(!isDefined(var_0)) {
      var_0 = common_scripts\utility::random(level.aerial_pathnodes);
    }

    var_1 = maps\mp\_aerial_pathnodes::get_ent_closest_aerial_node();
    var_2 = maps\mp\_aerial_pathnodes::find_path_between_aerial_nodes(var_1, var_0);

    if(isDefined(var_2)) {
      assault_vehicle_ai_follow_path(var_2, ::assault_vehicle_ai_air_movement_func, ::assault_vehicle_ai_enemy_moved_air, maps\mp\_aerial_pathnodes::get_aerial_offset()[2]);
    }

    if(assault_vehicle_ai_enemy_exists_and_is_alive()) {
      if(!assault_vehicle_ai_enemy_moved_air(var_0) || distance2dsquared(self.origin, self.enemy_target.origin) < squared(200)) {
        var_3 = self.enemy_target.origin + (0, 0, 40);
        self setvehgoalpos(var_3, 1);

        while(assault_vehicle_ai_enemy_exists_and_is_alive() && distancesquared(var_3, self.origin) > squared(24.0)) {
          wait 0.05;
        }

        wait 0.8;
        assault_vehicle_ai_ground_movement(::assault_vehicle_ai_air_movement_func, ::assault_vehicle_ai_enemy_moved_ground);
      }
    }

    wait 0.05;
  }
}

assault_vehicle_ai_pick_aerial_node(var_0, var_1) {
  var_2 = undefined;
  var_3 = 9999;
  var_4 = common_scripts\utility::array_randomize(var_0.aerial_neighbors);

  foreach(var_6 in var_4) {
    var_7 = var_6 getnodenumber();
    var_8 = var_1[var_7];

    if(!isDefined(var_8)) {
      return var_6;
    }

    if(var_8 < var_3) {
      var_2 = var_6;
      var_3 = var_8;
    }
  }

  return var_2;
}

assault_vehicle_ai_get_nearest_node() {
  var_0 = getclosestnodeinsight(self.origin, 1);

  if(!isDefined(var_0)) {
    var_1 = getnodesinradiussorted(self.origin, 1000, 0);

    if(var_1.size > 0) {
      var_0 = var_1[0];
    }
  }

  return var_0;
}

assault_vehicle_ai_ground_movement(var_0, var_1) {
  self endon("death");
  var_2 = assault_vehicle_ai_get_nearest_node();

  if(!isDefined(var_2)) {
    return;
  }
  for(;;) {
    childthread assault_vehicle_ai_ground_movement_loop(var_0, var_1);
    common_scripts\utility::waittill_any("enemy");
  }
}

assault_vehicle_ai_ground_movement_loop(var_0, var_1) {
  self notify("assault_vehicle_ai_ground_movement_loop");
  self endon("assault_vehicle_ai_ground_movement_loop");
  var_2 = [];

  for(;;) {
    var_3 = undefined;
    var_4 = undefined;

    if(assault_vehicle_ai_enemy_exists_and_is_alive()) {
      var_4 = self.enemy_target.origin;
    } else {
      var_5 = 0;

      while(!isDefined(var_3) && var_5 < 20) {
        var_3 = getrandomnodedestination(self.origin, self.angles);

        if(isDefined(var_3)) {
          if(common_scripts\utility::array_contains(var_2, var_3)) {
            var_3 = undefined;
          } else {
            var_4 = var_3.origin;
          }
        }

        var_5++;
        wait 0.05;
      }
    }

    if(isDefined(var_4)) {
      var_6 = assault_vehicle_ai_get_nearest_node();

      if(!isDefined(var_6)) {
        return;
      }
      var_7 = getnodesonpath(self.origin, var_4, 0, var_6);

      if(isDefined(var_7)) {
        assault_vehicle_ai_follow_path(var_7, var_0, var_1);
      } else {
        var_2[var_2.size] = var_3;
      }
    }

    wait 0.05;
  }
}

assault_vehicle_ai_get_camera_position() {
  var_0 = self vehicleget3pcameraoffset();
  var_1 = self.origin + rotatevector(var_0, self.angles);
  return var_1;
}

assault_vehicle_ai_threat() {
  self endon("death");

  for(;;) {
    var_0 = [];
    var_1 = 0;

    if(isDefined(self.enemy_target) && !isalive(self.enemy_target)) {
      var_2 = self.enemy_target.lastinflictor;

      if(isDefined(var_2)) {
        if(var_2 == self || isDefined(var_2.tank) && var_2.tank == self) {
          self.fire_at_dead_time = gettime() + 1000;
          wait 1.0;
        }
      }
    }

    foreach(var_4 in level.characters) {
      if(isalive(var_4) && !isalliedsentient(self, var_4) && self.owner != var_4) {
        if(var_4 maps\mp\_utility::_hasperk("specialty_blindeye")) {
          continue;
        }
        var_5 = 0;
        var_6 = assault_vehicle_ai_get_camera_position();
        var_7 = var_4.origin + (0, 0, 40);

        if(self.hasarhud) {
          var_5 = 1;
        }

        if(isDefined(var_4.lastshotfiredtime) && gettime() - var_4.lastshotfiredtime < 3.0) {
          var_5 = 1;
        } else if(getteamradarstrength(self.team) > getuavstrengthlevelneutral()) {
          var_5 = 1;
        } else if(sighttracepassed(var_6, var_7, 0, self, var_4)) {
          var_5 = 1;
        }

        if(var_5 && self.hasturret) {
          var_8 = self vehicleget3ppitchclamp();
          var_9 = var_7 - var_6;
          var_10 = vectortoangles(var_9);
          var_11 = angleclamp180(var_10[0]);

          if(var_11 > var_8 || var_11 < -1 * var_8) {
            var_5 = 0;
          }
        }

        if(var_5) {
          var_0[var_0.size] = var_4;
        }

        if(var_1) {
          wait 0.05;
        }

        var_1 = !var_1;
      }
    }

    if(isDefined(level.ishorde) && level.ishorde) {
      var_13 = [];

      foreach(var_15 in level.spawnedwarbirds) {
        if(isDefined(var_15.team) && var_15.team == "axis") {
          var_13[var_13.size] = var_15;
        }
      }

      var_17 = common_scripts\utility::array_combine(level.flying_attack_drones, var_13);

      foreach(var_19 in var_17) {
        var_5 = 0;
        var_6 = assault_vehicle_ai_get_camera_position();
        var_7 = (0, 0, 0);

        if(isDefined(var_19.origin)) {
          var_7 = var_19.origin;

          if(sighttracepassed(var_6, var_7, 0, self, var_19)) {
            var_5 = 1;
          }
        }

        if(var_5) {
          var_8 = self vehicleget3ppitchclamp();
          var_9 = var_7 - var_6;
          var_10 = vectortoangles(var_9);
          var_11 = angleclamp180(var_10[0]);

          if(var_11 > var_8 || var_11 < -1 * var_8) {
            var_5 = 0;
          }
        }

        if(var_5) {
          var_0[var_0.size] = var_19;
        }

        if(var_1) {
          waitframe();
        }

        var_1 = !var_1;
      }

      foreach(var_22 in level.hordesentryarray) {
        var_5 = 0;
        var_6 = assault_vehicle_ai_get_camera_position();
        var_7 = (0, 0, 0);

        if(isDefined(var_22.origin)) {
          var_7 = var_22.origin + (0, 0, 40);

          if(sighttracepassed(var_6, var_7, 0, self, var_22)) {
            var_5 = 1;
          }
        }

        if(var_5) {
          var_8 = self vehicleget3ppitchclamp();
          var_9 = var_7 - var_6;
          var_10 = vectortoangles(var_9);
          var_11 = angleclamp180(var_10[0]);

          if(var_11 > var_8 || var_11 < -1 * var_8) {
            var_5 = 0;
          }
        }

        if(var_5) {
          var_0[var_0.size] = var_22;
        }

        if(var_1) {
          waitframe();
        }

        var_1 = !var_1;
      }

      var_24 = [];

      foreach(var_26 in var_0) {
        if(!isDefined(var_26)) {
          var_24[var_24.size] = var_26;
          continue;
        }

        if(isDefined(var_26.ishordedrone) && var_26.ishordedrone) {
          if(!isDefined(var_26.damagetaken) || !isDefined(var_26.maxhealth) || var_26.damagetaken > var_26.maxhealth) {
            var_24[var_24.size] = var_26;
          }

          continue;
        }

        if(isDefined(var_26.ishordeenemysentry) && var_26.ishordeenemysentry) {
          if(!var_26.isalive) {
            var_24[var_24.size] = var_26;
          }
        }
      }

      foreach(var_26 in var_24) {
        var_0 = common_scripts\utility::array_remove(var_0, var_26);
      }
    }

    if(var_0.size > 0) {
      var_30 = common_scripts\utility::get_array_of_closest(self.origin, var_0);
      var_31 = self.enemy_target;
      self.enemy_target = var_30[0];

      if(!isDefined(var_31) || var_31 != self.enemy_target) {
        self notify("enemy");
      }
    } else if(isDefined(self.enemy_target)) {
      self.enemy_target = undefined;
    }

    wait 0.05;
  }
}

assault_vehicle_ai_weapons(var_0) {
  self endon("death");

  if(var_0) {
    self waittill("in_air");
  }

  self.last_rocket_time = 0;
  self.initial_enemy_target = 1;
  var_1 = squared(maps\mp\killstreaks\_drone_assault::getassaultvehiclec4radius() * 0.75);

  for(;;) {
    if(isDefined(self.targetent)) {
      if(assault_vehicle_ai_enemy_exists_and_is_alive()) {
        if(assault_vehicle_ai_can_see_living_enemy()) {
          if(isDefined(level.ishorde) && level.ishorde) {
            if(isDefined(self.enemy_target.ishordedrone) && self.enemy_target.ishordedrone) {
              self.targetent.origin = self.enemy_target.origin;
            } else {
              self.targetent.origin = self.enemy_target.origin + (0, 0, 40);
            }
          } else if(self.hasturret) {
            self.targetent.origin = self.enemy_target.origin + (0, 0, 40);
          } else {
            self.targetent.origin = self.enemy_target.origin + anglesToForward(self.enemy_target.angles) * 100;
          }

          var_2 = vectortoangles(self.targetent.origin - self.origin);

          for(var_3 = var_2[1] - self.angles[1]; var_3 > 180; var_3 = var_3 - 360) {}

          while(var_3 < -180) {
            var_3 = var_3 + 360;
          }

          var_4 = 10;

          if(abs(var_3) < var_4) {
            var_5 = var_2[1];
          } else {
            var_5 = self.angles[1] + var_4 * (var_3 / abs(var_3));
          }

          self vehicle_teleport(self.origin, (var_2[0], var_5, self.angles[2]), 0, 1);

          if(self.initial_enemy_target) {
            wait 0.1;
            self.initial_enemy_target = 0;

            if(!assault_vehicle_ai_can_see_living_enemy()) {
              continue;
            }
          }

          var_6 = self.hasrockets && self.rocketammo > 0;

          if(self.hasturret) {
            var_7 = self.mgturret gettagorigin("tag_flash");
          } else {
            var_7 = self.origin;
          }

          if(var_6) {
            var_6 = distancesquared(var_7, self.enemy_target.origin) > 17424;
          }

          var_8 = self.targetent.origin - var_7;
          var_9 = vectortoangles(var_8);
          var_10 = self vehicleget3ppitchclamp();
          var_11 = angleclamp180(var_9[0]);
          var_12 = var_11 < var_10 && var_11 > -1 * var_10;
          var_13 = vectornormalize(anglesToForward(self.angles) * (1, 1, 0));
          var_14 = vectornormalize(var_8 * (1, 1, 0));
          var_15 = vectordot(var_13, var_14) > 0.9;

          if(var_12 && var_15) {
            if(self.hasrockets && var_6) {
              if(gettime() > self.last_rocket_time + 1000) {
                if(self.hasmg) {
                  self notify("FireSecondaryWeapon");
                } else {
                  self notify("FirePrimaryWeapon");
                }

                self.last_rocket_time = gettime();
              }
            } else if(self.hasmg) {
              self.mgturret shootturret();
            } else if(!self.hasturret) {
              if(sighttracepassed(var_7, self.targetent.origin, 0, self, self.enemy_target)) {
                self notify("FirePrimaryWeapon");
              }
            }
          }
        } else {
          self.initial_enemy_target = 1;
        }
      } else if(isDefined(self.enemy_target) && !isalive(self.enemy_target)) {
        if(self.hasmg) {
          if(isDefined(self.fire_at_dead_time) && gettime() < self.fire_at_dead_time) {
            self.mgturret shootturret();
          }
        }
      }
    }

    if(self.hascloak && !maps\mp\killstreaks\_drone_common::droneiscloaked(self)) {
      if(!isDefined(self.cloakcooldown) || self.cloakcooldown == 0) {
        self notify("Cloak");
      }
    }

    wait 0.05;
  }
}

assault_vehicle_ai_enemy_exists_and_is_alive() {
  if(isDefined(level.ishorde) && level.ishorde) {
    if(isDefined(self.enemy_target) && isDefined(self.enemy_target.ishordeenemysentry) && self.enemy_target.ishordeenemysentry) {
      return self.enemy_target.isalive;
    } else {
      return isDefined(self.enemy_target) && isalive(self.enemy_target);
    }
  } else {
    return isDefined(self.enemy_target) && isalive(self.enemy_target);
  }
}

assault_vehicle_ai_can_see_living_enemy() {
  if(!assault_vehicle_ai_enemy_exists_and_is_alive()) {
    return 0;
  }

  if(gettime() > self.enemy_target_last_vis_time) {
    self.enemy_target_last_vis_time = gettime();

    if(isDefined(level.ishorde) && level.ishorde) {
      if(isDefined(self.enemy_target.ishordedrone) && self.enemy_target.ishordedrone) {
        self.enemy_target_visible = sighttracepassed(assault_vehicle_ai_get_camera_position(), self.enemy_target.origin, 0, self, self.enemy_target);
      } else {
        self.enemy_target_visible = sighttracepassed(assault_vehicle_ai_get_camera_position(), self.enemy_target.origin + (0, 0, 40), 0, self, self.enemy_target);
      }
    } else {
      self.enemy_target_visible = sighttracepassed(assault_vehicle_ai_get_camera_position(), self.enemy_target.origin + (0, 0, 40), 0, self, self.enemy_target);
    }
  }

  return self.enemy_target_visible;
}

assault_vehicle_ai_follow_path(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_4 = (0, 0, var_3);

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_6 = var_0[var_5];
    self[[var_1]](var_6.origin + var_4);
    var_7 = 0;

    while(distance2dsquared(var_6.origin, self.origin) > squared(24.0)) {
      var_7 = var_7 + 0.05;
      var_8 = var_7 > assault_vehicle_ai_path_timeout_time();

      if(!var_8 && assault_vehicle_ai_enemy_exists_and_is_alive()) {
        var_8 = self[[var_2]](var_0[var_0.size - 1]);
      }

      if(var_8) {
        return;
      }
      if(self.hasturret && assault_vehicle_ai_can_see_living_enemy()) {
        self[[var_1]](self.origin);

        while(assault_vehicle_ai_can_see_living_enemy()) {
          wait 0.05;
        }

        self[[var_1]](var_6.origin);
      }

      wait 0.05;
    }
  }
}

assault_vehicle_ai_enemy_moved_air(var_0) {
  var_1 = self.enemy_target maps\mp\_aerial_pathnodes::get_ent_closest_aerial_node();
  return var_1 != var_0;
}

assault_vehicle_ai_enemy_moved_ground(var_0) {
  return distancesquared(var_0.origin, self.enemy_target.origin) > squared(128.0);
}

assault_vehicle_ai_path_timeout_time() {
  return 7.5;
}

assault_vehicle_ai_air_traverse(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  if(!isDefined(var_0.targetname) || var_0.targetname != "traverse") {
    return;
  }
  if(!isDefined(var_0.type) || !isDefined(var_1.type) || var_0.type != "Begin" || var_1.type != "End") {
    return;
  }
  if(!isDefined(var_0.target) || !isDefined(var_1.targetname) || var_0.target != var_1.targetname) {
    return;
  }
  if(isDefined(var_0.animscript)) {
    if(var_0.animscript == "boost_jump_up") {
      var_3 = 0.25 * (var_1.origin - var_0.origin) + var_0.origin;
      var_3 = (var_3[0], var_3[1], var_1.origin[2] + 10);
      assault_vehicle_ai_air_movement_func(var_3 + var_2);
      var_4 = 0;

      while(distance2dsquared(var_3, self.origin) > squared(24.0) || self.origin[2] < var_3[2]) {
        var_4 = var_4 + 0.05;

        if(var_4 > assault_vehicle_ai_path_timeout_time()) {
          return;
        }
        wait 0.05;
      }
    }
  }
}

assault_vehicle_ai_air_movement_func(var_0) {
  self setvehgoalpos(var_0, 1);
}
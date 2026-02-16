/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_ai_quadrotor.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_ai_shared;
#using scripts\shared\vehicle_shared;
#using scripts\zm\_zm_devgui;
#using_animtree("generic");
#namespace zm_ai_quadrotor;

function autoexec __init__sytem__() {
  system::register("zm_ai_quadrotor", &__init__, undefined, undefined);
}

function __init__() {
  vehicle::add_main_callback("zm_quadrotor", &quadrotor_think);
  execdevgui("");
  level thread function_a05da9fb();
}

function quadrotor_think() {
  self useanimtree($generic);
  target_set(self, (0, 0, 0));
  self.health = self.healthdefault;
  self vehicle::friendly_fire_shield();
  self enableaimassist();
  self setneargoalnotifydist(64);
  self.flyheight = 128;
  self setvehicleavoidance(1);
  self.vehfovcosine = 0;
  self.vehfovcosinebusy = 0.574;
  self.vehaircraftcollisionenabled = 1;
  self.goalradius = 128;
  self setgoal(self.origin, 0, self.goalradius, self.flyheight);
  self thread quadrotor_death();
  self thread quadrotor_damage();
  quadrotor_start_ai();
  self thread quadrotor_set_team("allies");
}

function follow_ent(e_followee) {
  level endon("end_game");
  self endon("death");
  while(isDefined(e_followee)) {
    if(!self.returning_home) {
      v_facing = e_followee getplayerangles();
      v_forward = anglesToForward((0, v_facing[1], 0));
      candidate_goalpos = e_followee.origin + (v_forward * 128);
      trace_goalpos = physicstrace(self.origin, candidate_goalpos);
      if(trace_goalpos["position"] == candidate_goalpos) {
        self.current_pathto_pos = e_followee.origin + (v_forward * 128);
      } else {
        self.current_pathto_pos = e_followee.origin + vectorscale((0, 0, 1), 60);
      }
      self.current_pathto_pos = self getclosestpointonnavvolume(self.current_pathto_pos, 100);
      if(!isDefined(self.current_pathto_pos)) {
        self.current_pathto_pos = self.origin;
      }
    }
    wait(randomfloatrange(1, 2));
  }
}

function quadrotor_start_ai() {
  self.current_pathto_pos = self.origin;
  self.returning_home = 0;
  quadrotor_main();
}

function quadrotor_main() {
  self thread quadrotor_blink_lights();
  self thread quadrotor_fireupdate();
  self thread quadrotor_movementupdate();
  self thread quadrotor_collision();
  self thread quadrotor_watch_for_game_end();
}

function quadrotor_fireupdate() {
  level endon("end_game");
  self endon("death");
  while(true) {
    if(isDefined(self.enemy) && self vehcansee(self.enemy)) {
      self setlookatent(self.enemy);
      self setturrettargetent(self.enemy);
      startaim = gettime();
      while(!self.turretontarget && vehicle_ai::timesince(startaim) < 3) {
        wait(0.2);
      }
      self quadrotor_fire_for_time(randomfloatrange(1.5, 3));
      if(isDefined(self.enemy) && isai(self.enemy)) {
        wait(randomfloatrange(0.5, 1));
      } else {
        wait(randomfloatrange(0.5, 1.5));
      }
    } else {
      self clearlookatent();
      wait(0.4);
    }
  }
}

function quadrotor_watch_for_game_end() {
  self endon("death");
  level waittill("end_game");
  if(isDefined(self)) {
    playFX(level._effect["tesla_elec_kill"], self.origin);
    self playSound("zmb_qrdrone_leave");
    self delete();
    iprintln("");
  }
}

function quadrotor_check_move(position) {
  results = physicstrace(self.origin, position, (-15, -15, -5), (15, 15, 5));
  if(results["fraction"] == 1) {
    return true;
  }
  return false;
}

function quadrotor_adjust_goal_for_enemy_height(goalpos) {
  if(isDefined(self.enemy)) {
    if(isai(self.enemy)) {
      offset = 45;
    } else {
      offset = -100;
    }
    if((self.enemy.origin[2] + offset) > goalpos[2]) {
      goal_z = self.enemy.origin[2] + offset;
      if(goal_z > (goalpos[2] + 400)) {
        goal_z = goalpos[2] + 400;
      }
      results = physicstrace(goalpos, (goalpos[0], goalpos[1], goal_z), (-15, -15, -5), (15, 15, 5));
      if(results["fraction"] == 1) {
        goalpos = (goalpos[0], goalpos[1], goal_z);
      }
    }
  }
  return goalpos;
}

function make_sure_goal_is_well_above_ground(pos) {
  start = pos + (0, 0, self.flyheight);
  end = pos + (0, 0, self.flyheight * -1);
  trace = bulletTrace(start, end, 0, self, 0, 0);
  end = trace["position"];
  pos = end + (0, 0, self.flyheight);
  z = self getheliheightlockheight(pos);
  pos = (pos[0], pos[1], z);
  pos = self getclosestpointonnavvolume(pos, 100);
  if(!isDefined(pos)) {
    pos = self.origin;
  }
  return pos;
}

function waittill_pathing_done() {
  level endon("end_game");
  self endon("death");
  self endon("change_state");
  if(self.vehonpath) {
    self util::waittill_any("near_goal", "reached_end_node", "force_goal");
  }
}

function quadrotor_movementupdate() {
  level endon("end_game");
  self endon("death");
  self endon("change_state");
  assert(isalive(self));
  a_powerups = [];
  old_goalpos = self.current_pathto_pos;
  self.current_pathto_pos = self make_sure_goal_is_well_above_ground(self.current_pathto_pos);
  if(!self.vehonpath) {
    if(isDefined(self.attachedpath)) {
      self util::script_delay();
    } else {
      if(distancesquared(self.origin, self.current_pathto_pos) < 10000 && (self.current_pathto_pos[2] > (old_goalpos[2] + 10) || (self.origin[2] + 10) < self.current_pathto_pos[2])) {
        self setvehgoalpos(self.current_pathto_pos, 1, 1);
        self pathvariableoffset(vectorscale((0, 0, 1), 20), 2);
        self util::waittill_any_timeout(4, "near_goal", "force_goal", "death", "change_state");
      } else {
        goalpos = self quadrotor_get_closest_node();
        self setvehgoalpos(goalpos, 1, 1);
        self util::waittill_any_timeout(2, "near_goal", "force_goal", "death", "change_state");
      }
    }
  }
  assert(isalive(self));
  self setvehicleavoidance(1);
  while(true) {
    self waittill_pathing_done();
    self thread quadrotor_blink_lights();
    if(self.returning_home) {
      self setneargoalnotifydist(64);
      self setheliheightlock(0);
      is_valid_exit_path_found = 0;
      quadrotor_table = level.quadrotor_status.pickup_trig.model;
      var_946c2ab7 = self getclosestpointonnavvolume(quadrotor_table.origin, 100);
      if(isDefined(var_946c2ab7)) {
        is_valid_exit_path_found = self setvehgoalpos(var_946c2ab7, 1, 1);
      }
      if(is_valid_exit_path_found) {
        self notify("attempting_return");
        self util::waittill_any("near_goal", "force_goal", "reached_end_node", "return_timeout");
        continue;
      } else {
        self thread quadrotor_escape_into_air();
      }
      self util::waittill_any("near_goal", "force_goal", "reached_end_node", "return_timeout");
    }
    if(!isDefined(self.revive_target)) {
      player = self player_in_last_stand_within_range(500);
      if(isDefined(player)) {
        self.revive_target = player;
        player.quadrotor_revive = 1;
      }
    }
    if(isDefined(self.revive_target)) {
      origin = self.revive_target.origin;
      origin = (origin[0], origin[1], origin[2] + 100);
      origin = self getclosestpointonnavvolume(origin, 100);
      assert(isDefined(origin));
      if(self setvehgoalpos(origin, 1, 1)) {
        self util::waittill_any("near_goal", "force_goal", "reached_end_node");
        level thread watch_for_fail_revive(self);
        wait(1);
        if(isDefined(self.revive_target) && self.revive_target laststand::player_is_in_laststand()) {
          self.revive_target notify("remote_revive", self.player_owner);
          self.player_owner notify("revived_player_with_quadrotor");
        }
        self.revive_target = undefined;
        self setvehgoalpos(origin, 1, 1);
        wait(1);
        continue;
      } else {
        player.quadrotor_revive = undefined;
      }
      wait(0.1);
    }
    a_powerups = [];
    if(level.active_powerups.size > 0 && isDefined(self.player_owner)) {
      a_powerups = util::get_array_of_closest(self.player_owner.origin, level.active_powerups, undefined, undefined, 500);
    }
    if(a_powerups.size > 0) {
      b_got_powerup = 0;
      foreach(powerup in a_powerups) {
        var_2b346da7 = self getclosestpointonnavvolume(powerup.origin, 100);
        if(!isDefined(var_2b346da7)) {
          continue;
        }
        if(self setvehgoalpos(var_2b346da7, 1, 1)) {
          self util::waittill_any("near_goal", "force_goal", "reached_end_node");
          if(isDefined(powerup)) {
            self.player_owner.ignore_range_powerup = powerup;
            b_got_powerup = 1;
          }
          wait(1);
          break;
        }
      }
      if(b_got_powerup) {
        continue;
      }
      wait(0.1);
    }
    a_special_items = getEntArray("quad_special_item", "script_noteworthy");
    if(isDefined(level.n_ee_medallions) && level.n_ee_medallions > 0 && isDefined(self.player_owner)) {
      e_special_item = arraygetclosest(self.player_owner.origin, a_special_items, 500);
      if(isDefined(e_special_item)) {
        var_146a0124 = self getclosestpointonnavvolume(e_special_item.origin, 100);
        self setvehgoalpos(var_146a0124, 1, 1);
        self util::waittill_any("near_goal", "force_goal", "reached_end_node");
        wait(1);
        playFX(level._effect["staff_charge"], e_special_item.origin);
        e_special_item hide();
        level.n_ee_medallions--;
        level notify("quadrotor_medallion_found", self);
        if(level.n_ee_medallions == 0) {
          s_mg_spawn = struct::get("mgspawn", "targetname");
          var_50cc6658 = self getclosestpointonnavvolume(s_mg_spawn.origin, 100);
          self setvehgoalpos(var_50cc6658 + vectorscale((0, 0, 1), 30), 1, 1);
          self util::waittill_any("near_goal", "force_goal", "reached_end_node");
          wait(1);
          playFX(level._effect["staff_charge"], var_50cc6658);
          e_special_item playSound("zmb_perks_packa_ready");
          level flag::set("ee_medallions_collected");
        }
        e_special_item delete();
        self setneargoalnotifydist(30);
        self setvehgoalpos(self.origin, 1, 1);
      }
    }
    if(isDefined(level.quadrotor_custom_behavior)) {
      self[[level.quadrotor_custom_behavior]]();
    }
    goalpos = quadrotor_find_new_position();
    if(self setvehgoalpos(goalpos, 1, 1)) {
      if(isDefined(self.goal_node)) {
        self.goal_node.quadrotor_claimed = 1;
      }
      self util::waittill_any_timeout(12, "near_goal", "force_goal", "reached_end_node", "change_state", "death");
      if(isDefined(self.enemy) && self vehcansee(self.enemy)) {
        wait(randomfloatrange(1, 4));
      } else {
        wait(randomfloatrange(1, 3));
      }
      if(isDefined(self.goal_node)) {
        self.goal_node.quadrotor_claimed = undefined;
      }
    } else {
      if(isDefined(self.goal_node)) {
        self.goal_node.quadrotor_fails = 1;
      }
      self.current_pathto_pos = self.origin;
      self setvehgoalpos(self.origin, 1, 1);
      wait(0.5);
      continue;
    }
  }
}

function quadrotor_escape_into_air() {
  iprintln("");
  self.current_pathto_pos = self.origin + vectorscale((0, 0, 1), 2048);
  can_path_straight_up = self setvehgoalpos(self.current_pathto_pos, 1, 0);
  trace_goalpos = physicstrace(self.origin, self.current_pathto_pos);
  if(can_path_straight_up && trace_goalpos["position"] == self.current_pathto_pos) {
    iprintln("");
    self notify("attempting_return");
  } else {
    iprintln("");
    self notify("attempting_return");
    playFX(level._effect["tesla_elec_kill"], self.origin);
    self playSound("zmb_qrdrone_leave");
    self delete();
    level notify("drone_available");
  }
}

function quadrotor_get_closest_node() {
  nodes = getnodesinradiussorted(self.origin, 200, 0, 500, "Path");
  if(nodes.size == 0) {
    nodes = getnodesinradiussorted(self.current_pathto_pos, 3000, 0, 2000, "Path");
  }
  foreach(node in nodes) {
    if(node.type == "BAD NODE") {
      continue;
    }
    return make_sure_goal_is_well_above_ground(node.origin);
  }
  return self.origin;
}

function quadrotor_find_new_position() {
  if(!isDefined(self.current_pathto_pos)) {
    self.current_pathto_pos = self.origin;
  }
  origin = self.current_pathto_pos;
  nodes = getnodesinradius(self.current_pathto_pos, self.goalradius, 0, self.flyheight + 300, "Path");
  if(nodes.size == 0) {
    nodes = getnodesinradius(self.current_pathto_pos, self.goalradius + 1000, 0, self.flyheight + 1000, "Path");
  }
  if(nodes.size == 0) {
    nodes = getnodesinradius(self.current_pathto_pos, self.goalradius + 5000, 0, self.flyheight + 4000, "Path");
  }
  best_node = undefined;
  best_score = 0;
  foreach(node in nodes) {
    if(node.type == "BAD NODE") {
      continue;
    }
    if(isDefined(node.quadrotor_fails) || isDefined(node.quadrotor_claimed)) {
      score = randomfloat(30);
    } else {
      score = randomfloat(100);
    }
    if(score > best_score) {
      best_score = score;
      best_node = node;
    }
  }
  if(isDefined(best_node)) {
    node_origin = best_node.origin + (0, 0, self.flyheight + (randomfloatrange(-30, 40)));
    z = self getheliheightlockheight(node_origin);
    node_origin = (node_origin[0], node_origin[1], z);
    node_origin = self getclosestpointonnavvolume(node_origin, 100);
    if(isDefined(node_origin)) {
      origin = node_origin;
      self.goal_node = best_node;
    }
  }
  return origin;
}

function quadrotor_teleport_to_nearest_node() {
  self.origin = self quadrotor_get_closest_node();
}

function quadrotor_damage() {
  self endon("crash_done");
  while(isDefined(self)) {
    self waittill("damage", damage, $_, dir, point, type);
    if(isDefined(self.off)) {
      continue;
    }
    if(type == "MOD_EXPLOSIVE" || type == "MOD_GRENADE_SPLASH" || type == "MOD_PROJECTILE_SPLASH") {
      self setvehvelocity(self.velocity + (vectornormalize(dir) * 300));
      ang_vel = self getangularvelocity();
      ang_vel = ang_vel + (randomfloatrange(-300, 300), randomfloatrange(-300, 300), randomfloatrange(-300, 300));
      self setangularvelocity(ang_vel);
    } else {
      ang_vel = self getangularvelocity();
      yaw_vel = randomfloatrange(-320, 320);
      if(yaw_vel < 0) {
        yaw_vel = yaw_vel - 150;
      } else {
        yaw_vel = yaw_vel + 150;
      }
      ang_vel = ang_vel + (randomfloatrange(-150, 150), yaw_vel, randomfloatrange(-150, 150));
      self setangularvelocity(ang_vel);
    }
    wait(0.3);
  }
}

function quadrotor_cleanup_fx() {
  if(isDefined(self.stun_fx)) {
    self.stun_fx delete();
  }
}

function quadrotor_death() {
  wait(0.1);
  self notify("nodeath_thread");
  self waittill("death", attacker, damagefromunderneath, weaponname, point, dir);
  self notify("nodeath_thread");
  if(isDefined(self.goal_node) && isDefined(self.goal_node.quadrotor_claimed)) {
    self.goal_node.quadrotor_claimed = undefined;
  }
  if(isDefined(self.delete_on_death)) {
    if(isDefined(self)) {
      self quadrotor_cleanup_fx();
      self delete();
      level.maxis_quadrotor = undefined;
    }
    return;
  }
  if(!isDefined(self)) {
    return;
  }
  self endon("death");
  self disableaimassist();
  self death_fx();
  self thread death_radius_damage();
  self thread set_death_model(self.deathmodel, self.modelswapdelay);
  self thread quadrotor_crash_movement(attacker, dir);
  self quadrotor_cleanup_fx();
  self waittill("crash_done");
  self delete();
  level.maxis_quadrotor = undefined;
}

function death_fx() {
  if(isDefined(self.deathfx)) {
    playFXOnTag(self.deathfx, self, self.deathfxtag);
  }
  self playSound("veh_qrdrone_sparks");
}

function quadrotor_crash_movement(attacker, hitdir) {
  level endon("end_game");
  self endon("crash_done");
  self endon("death");
  self cancelaimove();
  self clearvehgoalpos();
  self clearlookatent();
  self setphysacceleration(vectorscale((0, 0, -1), 800));
  self.vehcheckforpredictedcrash = 1;
  if(!isDefined(hitdir)) {
    hitdir = (1, 0, 0);
  }
  side_dir = vectorcross(hitdir, (0, 0, 1));
  side_dir_mag = randomfloatrange(-100, 100);
  side_dir_mag = side_dir_mag + (math::sign(side_dir_mag) * 80);
  side_dir = side_dir * side_dir_mag;
  self setvehvelocity((self.velocity + vectorscale((0, 0, 1), 100)) + vectornormalize(side_dir));
  ang_vel = self getangularvelocity();
  ang_vel = (ang_vel[0] * 0.3, ang_vel[1], ang_vel[2] * 0.3);
  yaw_vel = randomfloatrange(0, 210) * math::sign(ang_vel[1]);
  yaw_vel = yaw_vel + (math::sign(yaw_vel) * 180);
  ang_vel = ang_vel + (randomfloatrange(-1, 1), yaw_vel, randomfloatrange(-1, 1));
  self setangularvelocity(ang_vel);
  self.crash_accel = randomfloatrange(75, 110);
  if(!isDefined(self.off)) {
    self thread quadrotor_crash_accel();
  }
  self thread quadrotor_collision();
  self playSound("veh_qrdrone_dmg_hit");
  if(!isDefined(self.off)) {
    self thread qrotor_dmg_snd();
  }
  wait(0.1);
  if(randomint(100) < 40 && !isDefined(self.off)) {
    self thread quadrotor_fire_for_time(randomfloatrange(0.7, 2));
  }
  wait(15);
  self notify("crash_done");
}

function qrotor_dmg_snd() {
  dmg_ent = spawn("script_origin", self.origin);
  dmg_ent linkto(self);
  dmg_ent playLoopSound("veh_qrdrone_dmg_loop");
  self util::waittill_any("crash_done", "death");
  dmg_ent stoploopsound(1);
  wait(2);
  dmg_ent delete();
}

function quadrotor_fire_for_time(totalfiretime) {
  level endon("end_game");
  self endon("crash_done");
  self endon("change_state");
  self endon("death");
  if(isDefined(self.emped)) {
    return;
  }
  weapon = self seatgetweapon(0);
  firetime = weapon.firetime;
  time = 0;
  firecount = 1;
  while(time < totalfiretime && !isDefined(self.emped)) {
    if(isDefined(self.enemy) && isDefined(self.enemy.attackeraccuracy) && self.enemy.attackeraccuracy == 0) {
      self fireweapon(undefined, undefined, 1);
    } else {
      self fireweapon();
    }
    firecount++;
    wait(firetime);
    time = time + firetime;
  }
}

function quadrotor_crash_accel() {
  level endon("end_game");
  self endon("crash_done");
  self endon("death");
  count = 0;
  while(true) {
    self setvehvelocity(self.velocity + (anglestoup(self.angles) * self.crash_accel));
    self.crash_accel = self.crash_accel * 0.98;
    wait(0.1);
    count++;
    if((count % 8) == 0) {
      if(randomint(100) > 40) {
        if(self.velocity[2] > 150) {
          self.crash_accel = self.crash_accel * 0.75;
        } else if(self.velocity[2] < 40 && count < 60) {
          if(abs(self.angles[0]) > 30 || abs(self.angles[2]) > 30) {
            self.crash_accel = randomfloatrange(160, 200);
          } else {
            self.crash_accel = randomfloatrange(85, 120);
          }
        }
      }
    }
  }
}

function quadrotor_predicted_collision() {
  level endon("end_game");
  self endon("crash_done");
  self endon("death");
  while(true) {
    self waittill("veh_predictedcollision", velocity, normal);
    if(normal[2] >= 0.6) {
      self notify("veh_collision", velocity, normal);
    }
  }
}

function quadrotor_collision_player() {
  level endon("end_game");
  self endon("change_state");
  self endon("crash_done");
  self endon("death");
  while(true) {
    self waittill("veh_collision", velocity, normal);
    driver = self getseatoccupant(0);
    if(isDefined(driver) && lengthsquared(velocity) > 4900) {
      earthquake(0.25, 0.25, driver.origin, 50);
      driver playrumbleonentity("damage_heavy");
    }
  }
}

function quadrotor_collision() {
  level endon("end_game");
  self endon("change_state");
  self endon("crash_done");
  self endon("death");
  if(!isalive(self)) {
    self thread quadrotor_predicted_collision();
  }
  self.bounce_count = 0;
  time_of_last_bounce = 0;
  while(true) {
    self waittill("veh_collision", velocity, normal);
    ang_vel = self getangularvelocity() * 0.5;
    self setangularvelocity(ang_vel);
    if(normal[2] < 0.6 || (isalive(self) && !isDefined(self.emped))) {
      self setvehvelocity(self.velocity + (normal * 90));
      self playSound("veh_qrdrone_wall");
      if(normal[2] < 0.6) {
        fx_origin = self.origin - (normal * 28);
      } else {
        fx_origin = self.origin - (normal * 10);
      }
      current_time = gettime();
      if((current_time - time_of_last_bounce) < 1000) {
        self.bounce_count = self.bounce_count + 1;
        if(self.bounce_count > 2) {
          self notify("force_goal");
          self.bounce_count = 0;
        }
      } else {
        self.bounce_count = 0;
      }
      time_of_last_bounce = gettime();
    } else {
      if(isDefined(self.emped)) {
        if(isDefined(self.bounced)) {
          self playSound("veh_qrdrone_wall");
          self setvehvelocity((0, 0, 0));
          self setangularvelocity((0, 0, 0));
          if(self.angles[0] < 0) {
            if(self.angles[0] < -15) {
              self.angles = (-15, self.angles[1], self.angles[2]);
            } else if(self.angles[0] > -10) {
              self.angles = (-10, self.angles[1], self.angles[2]);
            }
          } else {
            if(self.angles[0] > 15) {
              self.angles = (15, self.angles[1], self.angles[2]);
            } else if(self.angles[0] < 10) {
              self.angles = (10, self.angles[1], self.angles[2]);
            }
          }
          self.bounced = undefined;
          self notify("landed");
          return;
        }
        self.bounced = 1;
        self setvehvelocity(self.velocity + (normal * 120));
        self playSound("veh_qrdrone_wall");
        if(normal[2] < 0.6) {
          fx_origin = self.origin - (normal * 28);
        } else {
          fx_origin = self.origin - (normal * 10);
        }
        playFX(level._effect["quadrotor_nudge"], fx_origin, normal);
      } else {
        createdynentandlaunch(self.deathmodel, self.origin, self.angles, self.origin, self.velocity * 0.01);
        self playSound("veh_qrdrone_explo");
        self thread death_fire_loop_audio();
        self notify("crash_done");
      }
    }
  }
}

function death_fire_loop_audio() {
  sound_ent = spawn("script_origin", self.origin);
  sound_ent playLoopSound("veh_qrdrone_death_fire_loop", 0.1);
  wait(11);
  sound_ent stoploopsound(1);
  sound_ent delete();
}

function quadrotor_set_team(team) {
  self.team = team;
  self.vteam = team;
  self setteam(team);
  if(!isDefined(self.off)) {
    quadrotor_blink_lights();
  }
}

function quadrotor_blink_lights() {
  level endon("end_game");
  self endon("death");
  self vehicle::lights_off();
  wait(0.1);
  self vehicle::lights_on();
}

function quadrotor_self_destruct() {
  level endon("end_game");
  self endon("death");
  self endon("exit_vehicle");
  self_destruct = 0;
  self_destruct_time = 0;
  while(true) {
    if(!self_destruct) {
      if(level.player meleeButtonPressed()) {
        self_destruct = 1;
        self_destruct_time = 5;
      }
      wait(0.05);
      continue;
    } else {
      iprintlnbold(self_destruct_time);
      wait(1);
      self_destruct_time = self_destruct_time - 1;
      if(self_destruct_time == 0) {
        driver = self getseatoccupant(0);
        if(isDefined(driver)) {
          driver disableinvulnerability();
        }
        earthquake(3, 1, self.origin, 256);
        radiusdamage(self.origin, 1000, 15000, 15000, level.player, "MOD_EXPLOSIVE");
        self dodamage(self.health + 1000, self.origin);
      }
      continue;
    }
  }
}

function quadrotor_level_out_for_landing() {
  level endon("end_game");
  self endon("death");
  self endon("emped");
  self endon("landed");
  while(isDefined(self.emped)) {
    velocity = self.velocity;
    self.angles = (self.angles[0] * 0.85, self.angles[1], self.angles[2] * 0.85);
    ang_vel = self getangularvelocity() * 0.85;
    self setangularvelocity(ang_vel);
    self setvehvelocity(velocity);
    wait(0.05);
  }
}

function quadrotor_temp_bullet_shield(invulnerable_time) {
  self notify("bullet_shield");
  self endon("bullet_shield");
  self.bullet_shield = 1;
  wait(invulnerable_time);
  if(isDefined(self)) {
    self.bullet_shield = undefined;
    wait(3);
    if(isDefined(self) && self.health < 40) {
      self.health = 40;
    }
  }
}

function death_radius_damage() {
  if(!isDefined(self) || self.radiusdamageradius <= 0) {
    return;
  }
  wait(0.05);
  if(isDefined(self)) {
    self radiusdamage(self.origin + vectorscale((0, 0, 1), 15), self.radiusdamageradius, self.radiusdamagemax, self.radiusdamagemin, self, "MOD_EXPLOSIVE");
  }
}

function set_death_model(smodel, fdelay) {
  assert(isDefined(smodel));
  if(isDefined(fdelay) && fdelay > 0) {
    wait(fdelay);
  }
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.deathmodel_attached)) {
    return;
  }
  self setModel(smodel);
}

function player_in_last_stand_within_range(range) {
  players = getplayers();
  if(players.size == 1) {
    return;
  }
  foreach(player in players) {
    if(player laststand::player_is_in_laststand() && distancesquared(self.origin, player.origin) < (range * range) && !isDefined(player.quadrotor_revive)) {
      var_d46f516e = self getclosestpointonnavvolume(player.origin + vectorscale((0, 0, 1), 100), 100);
      if(!isDefined(var_d46f516e)) {
        continue;
      }
      return player;
    }
  }
}

function watch_for_fail_revive(quad_rotor) {
  quadrotor = quad_rotor;
  owner = quad_rotor.player_owner;
  revive_target = quad_rotor.revive_target;
  revive_target endon("bled_out");
  revive_target endon("disconnect");
  level thread kill_fx_if_target_revive(quadrotor, revive_target);
  revive_target.revive_hud settext(&"GAME_PLAYER_IS_REVIVING_YOU", owner);
  revive_target laststand::revive_hud_show_n_fade(1);
  wait(1);
  if(isDefined(revive_target)) {
    revive_target.quadrotor_revive = undefined;
  }
}

function kill_fx_if_target_revive(quadrotor, revive_target) {
  e_fx = spawn("script_model", quadrotor gettagorigin("tag_origin"));
  e_fx setModel("tag_origin");
  e_fx playSound("zmb_drone_revive_fire");
  e_fx playLoopSound("zmb_drone_revive_loop", 0.2);
  e_fx moveto(revive_target.origin, 1);
  timer = 0;
  while(true) {
    if(isDefined(revive_target) && revive_target laststand::player_is_in_laststand() && isDefined(quadrotor)) {
      wait(0.1);
      timer = timer + 0.1;
      if(timer >= 1) {
        e_fx stoploopsound(0.1);
        e_fx playSound("zmb_drone_revive_revive_3d");
        revive_target playsoundtoplayer("zmb_drone_revive_revive_plr", revive_target);
        break;
      }
    } else {
      break;
    }
  }
  e_fx delete();
}

function private function_a05da9fb() {
  level flagsys::wait_till("");
  zm_devgui::add_custom_devgui_callback(&function_d3a31a35);
}

function private function_d3a31a35(cmd) {
  if(cmd == "") {
    player = level.players[0];
    quadrotor = spawnvehicle("", player.origin + vectorscale((0, 0, 1), 32), (0, 0, 0));
    if(isalive(quadrotor)) {
      quadrotor thread follow_ent(player);
      quadrotor.player_owner = player;
    }
  }
}
/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_quadrotor.gsc
**************************************/

#include animscripts\utility;
#include common_scripts\utility;
#include maps\_utility;
#include maps\_vehicle;
#include maps\_vehicle_death;
#include maps\_statemachine;
#include maps\_gameskill;

init() {
  precacherumble("quadrotor_fly");
  precacheitem("quadrotor_turret");
  precacheitem("quadrotor_turret_enemy");
  vehicle_add_main_callback("heli_quadrotor", ::quadrotor_think);
  vehicle_add_main_callback("heli_quadrotor_rts", ::quadrotor_think);
  setsaveddvar("vehHelicopterLookaheadTime", 0.07);
  level._effect["quadrotor_damage01"] = loadfx("destructibles/fx_quadrotor_damagestate01");
  level._effect["quadrotor_damage02"] = loadfx("destructibles/fx_quadrotor_damagestate02");
  level._effect["quadrotor_damage03"] = loadfx("destructibles/fx_quadrotor_damagestate03");
  level._effect["quadrotor_damage04"] = loadfx("destructibles/fx_quadrotor_damagestate04");
  level._effect["quadrotor_crash"] = loadfx("destructibles/fx_quadrotor_crash01");
  level._effect["quadrotor_nudge"] = loadfx("destructibles/fx_quadrotor_nudge01");
  level._effect["quadrotor_stun"] = loadfx("electrical/fx_elec_sp_emp_stun_quadrotor");
  level.difficultysettings["quadrotor_burst_scale"]["easy"] = 1.15;
  level.difficultysettings["quadrotor_burst_scale"]["normal"] = 1;
  level.difficultysettings["quadrotor_burst_scale"]["hardened"] = 0.85;
  level.difficultysettings["quadrotor_burst_scale"]["veteran"] = 0.7;
  level.difficultysettings["quadrotor_axis_damage_scale"]["easy"] = 1.25;
  level.difficultysettings["quadrotor_axis_damage_scale"]["normal"] = 1;
  level.difficultysettings["quadrotor_axis_damage_scale"]["hardened"] = 0.75;
  level.difficultysettings["quadrotor_axis_damage_scale"]["veteran"] = 0.5;
  level.difficultysettings["quadrotor_allies_damage_scale"]["easy"] = 0.75;
  level.difficultysettings["quadrotor_allies_damage_scale"]["normal"] = 1;
  level.difficultysettings["quadrotor_allies_damage_scale"]["hardened"] = 1.35;
  level.difficultysettings["quadrotor_allies_damage_scale"]["veteran"] = 1.7;
}

quadrotor_think() {
  self enableaimassist();
  self sethoverparams(25.0, 120.0, 80);
  self setneargoalnotifydist(30);
  self.flyheight = getdvarfloat(#"g_quadrotorFlyHeight");
  self setvehicleavoidance(1);
  self.vehfovcosine = 0;
  self.vehfovcosinebusy = 0.574;
  self.vehaircraftcollisionenabled = 1;

  if(!isDefined(self.goalradius))
    self.goalradius = 600;

  if(!isDefined(self.goalpos))
    self.goalpos = self.origin;

  self.original_vehicle_type = self.vehicletype;
  self.state_machine = create_state_machine("quadrotorbrain", self);
  main = self.state_machine add_state("main", undefined, undefined, ::quadrotor_main, ::can_enter_main, undefined);
  scripted = self.state_machine add_state("scripted", undefined, undefined, ::quadrotor_scripted, undefined, undefined);
  main add_connection_by_type("scripted", 999, 4, undefined, "enter_vehicle");
  main add_connection_by_type("scripted", 999, 4, undefined, "scripted");
  scripted add_connection_by_type("scripted", 999, 4, undefined, "enter_vehicle");
  scripted add_connection_by_type("main", 1, 4, undefined, "exit_vehicle");
  scripted add_connection_by_type("main", 2, 4, undefined, "main");
  scripted add_connection_by_type("main", 1, 4, undefined, "scripted_done");
  self thread quadrotor_death();
  self thread quadrotor_damage();
  self hidepart("tag_viewmodel");
  self.overridevehicledamage = ::quadrotorcallback_vehicledamage;

  if(isDefined(self.script_startstate)) {
    if(self.script_startstate == "off")
      self quadrotor_off();
    else
      self.state_machine set_state(self.script_startstate);
  } else
    quadrotor_start_ai();

  self thread quadrotor_set_team(self.vteam);
}

can_enter_main() {
  if(!isalive(self))
    return false;

  driver = self getseatoccupant(0);

  if(isDefined(driver))
    return false;

  return true;
}

quadrotor_start_scripted() {
  self.state_machine set_state("scripted");
}

quadrotor_off() {
  self.state_machine set_state("scripted");
  self lights_off();
  self veh_toggle_tread_fx(0);
  self vehicle_toggle_sounds(0);
  self hidepart("tag_rotor_fl");
  self hidepart("tag_rotor_fr");
  self hidepart("tag_rotor_rl");
  self hidepart("tag_rotor_rr");

  if(!isDefined(self.emped))
    self disableaimassist();

  self.off = 1;
}

quadrotor_on() {
  self lights_on();
  self veh_toggle_tread_fx(1);
  self vehicle_toggle_sounds(1);
  self showpart("tag_rotor_fl");
  self showpart("tag_rotor_fr");
  self showpart("tag_rotor_rl");
  self showpart("tag_rotor_rr");
  self enableaimassist();
  self.off = undefined;
  quadrotor_start_ai();
}

quadrotor_start_ai() {
  self.goalpos = self.origin;
  self.state_machine set_state("main");
}

quadrotor_main() {
  self thread quadrotor_blink_lights();
  self thread quadrotor_fireupdate();
  self thread quadrotor_movementupdate();
  self thread quadrotor_collision();
}

quadrotor_fireupdate() {
  self endon("death");
  self endon("change_state");

  while(true) {
    if(isDefined(self.enemy) && self vehcansee(self.enemy)) {
      enemy_is_hind = 0;

      if(isDefined(self.enemy) && isDefined(self.enemy.vehicletype))
        enemy_is_hind = self.enemy.vehicletype == "heli_hind_afghan_rts";

      if(distancesquared(self.enemy.origin, self.origin) < 1638400 || enemy_is_hind) {
        self setturrettargetent(self.enemy);
        self quadrotor_fire_for_time(randomfloatrange(0.3, 0.6));
      }

      if(isDefined(self.enemy) && isai(self.enemy))
        wait(randomfloatrange(2, 2.5));
      else
        wait(randomfloatrange(0.5, 1.5) * maps\_gameskill::getcurrentdifficultysetting("quadrotor_burst_scale"));
    } else
      wait 0.4;
  }
}

quadrotor_check_move(position) {
  results = physicstraceex(self.origin, position, (-15, -15, -5), (15, 15, 5), self);

  if(results["fraction"] == 1)
    return true;

  return false;
}

quadrotor_adjust_goal_for_enemy_height(goalpos) {
  if(isDefined(self.enemy)) {
    if(isai(self.enemy))
      offset = 45;
    else
      offset = -100;

    if(self.enemy.origin[2] + offset > goalpos[2]) {
      goal_z = self.enemy.origin[2] + offset;

      if(goal_z > goalpos[2] + 400)
        goal_z = goalpos[2] + 400;

      results = physicstraceex(goalpos, (goalpos[0], goalpos[1], goal_z), (-15, -15, -5), (15, 15, 5), self);

      if(results["fraction"] == 1)
        goalpos = (goalpos[0], goalpos[1], goal_z);
    }
  }

  return goalpos;
}

make_sure_goal_is_well_above_ground(pos) {
  start = pos + (0, 0, self.flyheight);
  end = pos + (0, 0, self.flyheight * -1);
  trace = bullettrace(start, end, 0, self, 0, 0);
  end = trace["position"];
  pos = end + (0, 0, self.flyheight);
  z = self getheliheightlockheight(pos);
  pos = (pos[0], pos[1], z);
  return pos;
}

waittill_pathing_done() {
  self endon("death");
  self endon("change_state");

  if(self.vehonpath)
    self waittill_any("near_goal", "reached_end_node", "force_goal");
}

quadrotor_movementupdate() {
  self endon("death");
  self endon("change_state");
  assert(isalive(self));
  old_goalpos = self.goalpos;
  self.goalpos = self make_sure_goal_is_well_above_ground(self.goalpos);

  if(!self.vehonpath) {
    if(isDefined(self.attachedpath))
      self script_delay();
    else if(distancesquared(self.origin, self.goalpos) < 10000 && (self.goalpos[2] > old_goalpos[2] + 10 || self.origin[2] + 10 < self.goalpos[2])) {
      self setvehgoalpos(self.goalpos, 1);
      self pathvariableoffset(vectorscale((0, 0, 1), 20.0), 2);
      self waittill_any_or_timeout(4, "near_goal", "force_goal");
    } else {
      goalpos = self quadrotor_get_closest_node();
      self setvehgoalpos(goalpos, 1);
      self waittill_any_or_timeout(2, "near_goal", "force_goal");
    }
  }

  assert(isalive(self));
  self setvehicleavoidance(1);
  goalfailures = 0;

  while(true) {
    self waittill_pathing_done();
    goalpos = quadrotor_find_new_position();
    goalpos = quadrotor_adjust_goal_for_enemy_height(goalpos);
    self thread quadrotor_blink_lights();

    if(self setvehgoalpos(goalpos, 1, 2, 1)) {
      goalfailures = 0;

      if(isDefined(self.goal_node))
        self.goal_node.quadrotor_claimed = 1;

      if(isDefined(self.enemy) && self vehcansee(self.enemy)) {
        if(randomint(100) > 50)
          self setlookatent(self.enemy);
      }

      self waittill_any_timeout(12, "near_goal", "force_goal", "reached_end_node");

      if(isDefined(self.enemy) && self vehcansee(self.enemy)) {
        self setlookatent(self.enemy);
        wait(randomfloatrange(1, 4) * maps\_gameskill::getcurrentdifficultysetting("quadrotor_burst_scale"));
        self clearlookatent();
      }

      if(isDefined(self.goal_node))
        self.goal_node.quadrotor_claimed = undefined;
    } else {
      goalfailures++;

      if(isDefined(self.goal_node))
        self.goal_node.quadrotor_fails = 1;

      if(goalfailures == 1) {
        wait 0.5;
        continue;
      } else if(goalfailures == 2)
        goalpos = self.origin;
      else if(goalfailures == 3) {
        goalpos = self quadrotor_get_closest_node();
        self setvehgoalpos(goalpos, 1);
        self waittill("near_goal");
      } else if(goalfailures > 3) {
        println("WARNING: Quadrotor can't find path to goal over 4 times." + self.origin + " " + goalpos);
        line(self.origin, goalpos, (1, 1, 1), 1, 100);

        self.goalpos = make_sure_goal_is_well_above_ground(goalpos);
      }

      old_goalpos = goalpos;
      offset = (randomfloatrange(-50, 50), randomfloatrange(-50, 50), randomfloatrange(50, 150));
      goalpos = goalpos + offset;
      goalpos = quadrotor_adjust_goal_for_enemy_height(goalpos);

      if(self quadrotor_check_move(goalpos)) {
        self setvehgoalpos(goalpos, 1);
        self waittill_any("near_goal", "force_goal", "start_vehiclepath");
        wait(randomfloatrange(1, 3));

        if(!self.vehonpath) {
          self setvehgoalpos(old_goalpos, 1);
          self waittill_any("near_goal", "force_goal", "start_vehiclepath");
        }
      }

      wait 0.5;
    }
  }
}

quadrotor_get_closest_node() {
  nodes = getnodesinradiussorted(self.origin, 200, 0, 500, "Path");

  if(nodes.size == 0)
    nodes = getnodesinradiussorted(self.goalpos, 3000, 0, 2000, "Path");

  foreach(node in nodes) {
    if(node.type == "BAD NODE" || !node has_spawnflag(2097152)) {
      continue;
    }
    return make_sure_goal_is_well_above_ground(node.origin);
  }

  return self.origin;
}

quadrotor_find_new_position() {
  if(!isDefined(self.goalpos))
    self.goalpos = self.origin;

  origin = self.goalpos;
  nodes = getnodesinradius(self.goalpos, self.goalradius, 0, self.flyheight + 300, "Path");

  if(nodes.size == 0)
    nodes = getnodesinradius(self.goalpos, self.goalradius + 1000, 0, self.flyheight + 1000, "Path");

  if(nodes.size == 0)
    nodes = getnodesinradius(self.goalpos, self.goalradius + 5000, 0, self.flyheight + 4000, "Path");

  best_node = undefined;
  best_score = 0;

  foreach(node in nodes) {
    if(node.type == "BAD NODE" || !node has_spawnflag(2097152)) {
      continue;
    }
    if(isDefined(node.quadrotor_fails) || isDefined(node.quadrotor_claimed))
      score = randomfloat(30);
    else
      score = randomfloat(100);

    if(score > best_score) {
      best_score = score;
      best_node = node;
    }
  }

  if(isDefined(best_node)) {
    origin = best_node.origin + (0, 0, self.flyheight + randomfloatrange(-30, 40));
    z = self getheliheightlockheight(origin);
    origin = (origin[0], origin[1], z);
    self.goal_node = best_node;
  }

  return origin;
}

quadrotor_teleport_to_nearest_node() {
  self.origin = self quadrotor_get_closest_node();
}

quadrotor_exit_vehicle() {
  self waittill("exit_vehicle", player);
  player.ignoreme = 0;
  player disableinvulnerability();
  player resetfov();
  self showpart("tag_turret");
  self showpart("body_animate_jnt");
  self showpart("tag_flaps");
  self showpart("tag_ammo_case");
  self hidepart("tag_viewmodel");
  self setheliheightlock(0);
  self enableaimassist();
  self setvehicletype(self.original_vehicle_type);
  self setviewmodelrenderflag(0);
  self.attachedpath = undefined;
  self quadrotor_teleport_to_nearest_node();
  self.goalpos = self.origin;
}

quadrotor_scripted() {
  driver = self getseatoccupant(0);

  if(isDefined(driver)) {
    self disableaimassist();
    self hidepart("tag_turret");
    self hidepart("body_animate_jnt");
    self hidepart("tag_flaps");
    self hidepart("tag_ammo_case");
    self showpart("tag_viewmodel");
    self setheliheightlock(1);
    self thread vehicle_damage_filter("firestorm_turret");
    self thread quadrotor_set_team(driver.team);
    driver.ignoreme = 1;
    driver enableinvulnerability();
    driver setclientdvar("cg_fov", 90);
    self setvehicletype("heli_quadrotor_rts_player");

    if(isDefined(self.vehicle_weapon_override))
      self setvehweapon(self.vehicle_weapon_override);

    self setviewmodelrenderflag(1);
    self thread quadrotor_exit_vehicle();
    self thread quadrotor_collision_player();
  }

  if(isDefined(self.goal_node) && isDefined(self.goal_node.quadrotor_claimed))
    self.goal_node.quadrotor_claimed = undefined;

  self cleartargetentity();
  self cancelaimove();
  self clearvehgoalpos();
  self pathvariableoffsetclear();
  self pathfixedoffsetclear();
  self clearlookatent();
}

quadrotor_get_damage_effect(health_pct) {
  if(health_pct < 0.25)
    return level._effect["quadrotor_damage04"];
  else if(health_pct < 0.5)
    return level._effect["quadrotor_damage03"];
  else if(health_pct < 0.75)
    return level._effect["quadrotor_damage02"];
  else if(health_pct < 0.9)
    return level._effect["quadrotor_damage01"];

  return undefined;
}

quadrotor_play_single_fx_on_tag(effect, tag) {
  if(isDefined(self.damage_fx_ent)) {
    if(self.damage_fx_ent.effect == effect) {
      return;
    }
    self.damage_fx_ent delete();
  }

  ent = spawn("script_model", (0, 0, 0));
  ent setmodel("tag_origin");
  ent.origin = self gettagorigin(tag);
  ent.angles = self gettagangles(tag);
  ent notsolid();
  ent hide();
  ent linkto(self, tag);
  ent.effect = effect;
  playfxontag(effect, ent, "tag_origin");
  ent playsound("veh_qrdrone_sparks");
  self.damage_fx_ent = ent;
}

quadrotor_update_damage_fx() {
  max_health = self.healthdefault;

  if(isDefined(self.health_max))
    max_health = self.health_max;

  effect = quadrotor_get_damage_effect(self.health / max_health);

  if(isDefined(effect))
    quadrotor_play_single_fx_on_tag(effect, "tag_origin");
  else if(isDefined(self.damage_fx_ent))
    self.damage_fx_ent delete();
}

quadrotor_damage() {
  self endon("crash_done");

  while(isDefined(self)) {
    self waittill("damage", damage, undefined, dir, point, type);

    if(self.health > 0 && damage > 1)
      quadrotor_update_damage_fx();

    if(isDefined(self.off)) {
      continue;
    }
    if(type == "MOD_EXPLOSIVE" || type == "MOD_GRENADE_SPLASH" || type == "MOD_PROJECTILE_SPLASH") {
      self setvehvelocity(self.velocity + vectornormalize(dir) * 300);
      ang_vel = self getangularvelocity();
      ang_vel = ang_vel + (randomfloatrange(-300, 300), randomfloatrange(-300, 300), randomfloatrange(-300, 300));
      self setangularvelocity(ang_vel);
    } else {
      ang_vel = self getangularvelocity();
      yaw_vel = randomfloatrange(-320, 320);

      if(yaw_vel < 0)
        yaw_vel = yaw_vel - 150;
      else
        yaw_vel = yaw_vel + 150;

      ang_vel = ang_vel + (randomfloatrange(-150, 150), yaw_vel, randomfloatrange(-150, 150));
      self setangularvelocity(ang_vel);
    }

    wait 0.3;
  }
}

quadrotor_cleanup_fx() {
  if(isDefined(self.damage_fx_ent))
    self.damage_fx_ent delete();

  if(isDefined(self.stun_fx))
    self.stun_fx delete();
}

quadrotor_death() {
  wait 0.1;
  self notify("nodeath_thread");
  self waittill("death", attacker, damagefromunderneath, weaponname, point, dir);
  self notify("nodeath_thread");

  if(isDefined(self.goal_node) && isDefined(self.goal_node.quadrotor_claimed))
    self.goal_node.quadrotor_claimed = undefined;

  if(isDefined(self.delete_on_death)) {
    if(isDefined(self)) {
      self quadrotor_cleanup_fx();
      self delete();
    }

    return;
  }

  if(!isDefined(self)) {
    return;
  }
  self endon("death");
  self maps\_vehicle_death::death_cleanup_level_variables();
  self disableaimassist();
  self death_fx();
  self thread maps\_vehicle_death::death_radius_damage();
  self thread maps\_vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
  self veh_toggle_tread_fx(0);
  self veh_toggle_exhaust_fx(0);
  self vehicle_toggle_sounds(0);
  self lights_off();
  self thread quadrotor_crash_movement(attacker, dir);
  self quadrotor_cleanup_fx();
  self waittill("crash_done");
  self delete();
}

death_fx() {
  if(isDefined(self.deathfx))
    playfxontag(self.deathfx, self, self.deathfxtag);

  self playsound("veh_qrdrone_sparks");
}

quadrotor_crash_movement(attacker, hitdir) {
  self endon("crash_done");
  self endon("death");
  self cancelaimove();
  self clearvehgoalpos();
  self clearlookatent();
  self setphysacceleration(vectorscale((0, 0, -1), 800.0));
  self.vehcheckforpredictedcrash = 1;

  if(!isDefined(hitdir))
    hitdir = (1, 0, 0);

  side_dir = vectorcross(hitdir, (0, 0, 1));
  side_dir_mag = randomfloatrange(-100, 100);
  side_dir_mag = side_dir_mag + sign(side_dir_mag) * 80;
  side_dir = side_dir * side_dir_mag;
  self setvehvelocity(self.velocity + vectorscale((0, 0, 1), 100.0) + vectornormalize(side_dir));
  ang_vel = self getangularvelocity();
  ang_vel = (ang_vel[0] * 0.3, ang_vel[1], ang_vel[2] * 0.3);
  yaw_vel = randomfloatrange(0, 210) * sign(ang_vel[1]);
  yaw_vel = yaw_vel + sign(yaw_vel) * 180;
  ang_vel = ang_vel + (randomfloatrange(-1, 1), yaw_vel, randomfloatrange(-1, 1));
  self setangularvelocity(ang_vel);
  self.crash_accel = randomfloatrange(75, 110);

  if(!isDefined(self.off))
    self thread quadrotor_crash_accel();

  self thread quadrotor_collision();
  self playsound("veh_qrdrone_dmg_hit");
  self vehicle_toggle_sounds(0);

  if(!isDefined(self.off))
    self thread qrotor_dmg_snd();

  wait 0.1;

  if(randomint(100) < 40 && !isDefined(self.off))
    self thread quadrotor_fire_for_time(randomfloatrange(0.7, 2.0));

  wait 15;
  self notify("crash_done");
}

qrotor_dmg_snd() {
  dmg_ent = spawn("script_origin", self.origin);
  dmg_ent linkto(self);
  dmg_ent playloopsound("veh_qrdrone_dmg_loop");
  self waittill_any("crash_done", "death");
  dmg_ent stoploopsound(1);
  wait 2;
  dmg_ent delete();
}

quadrotor_fire_for_time(totalfiretime) {
  self endon("crash_done");
  self endon("change_state");
  self endon("death");

  if(isDefined(self.emped)) {
    return;
  }
  weaponname = self seatgetweapon(0);
  firetime = weaponfiretime(weaponname);
  time = 0;
  aifirechance = 1;

  if(weaponname == "quadrotor_turret_explosive") {
    if(totalfiretime < firetime * 2)
      totalfiretime = firetime * 2;

    aifirechance = 1;
  } else if(isDefined(self.enemy) && !isplayer(self.enemy) && !(isDefined(self.enemy.isbigdog) && self.enemy.isbigdog) || isDefined(self.fire_half_blanks))
    aifirechance = 2;

  firecount = 1;

  while(time < totalfiretime && !isDefined(self.emped)) {
    if(isDefined(self.enemy) && isDefined(self.enemy.attackeraccuracy) && self.enemy.attackeraccuracy == 0)
      self fireweapon(undefined, undefined, 1);
    else if(aifirechance > 1)
      self fireweapon(undefined, undefined, firecount % aifirechance);
    else
      self fireweapon();

    firecount++;
    wait(firetime);
    time = time + firetime;
  }
}

quadrotor_crash_accel() {
  self endon("crash_done");
  self endon("death");
  count = 0;

  while(true) {
    self setvehvelocity(self.velocity + anglestoup(self.angles) * self.crash_accel);
    self.crash_accel = self.crash_accel * 0.98;
    wait 0.1;
    count++;

    if(count % 8 == 0) {
      if(randomint(100) > 40) {
        if(self.velocity[2] > 150.0)
          self.crash_accel = self.crash_accel * 0.75;
        else if(self.velocity[2] < 40.0 && count < 60) {
          if(abs(self.angles[0]) > 30 || abs(self.angles[2]) > 30)
            self.crash_accel = randomfloatrange(160, 200);
          else
            self.crash_accel = randomfloatrange(85, 120);
        }
      }
    }
  }
}

quadrotor_predicted_collision() {
  self endon("crash_done");
  self endon("death");

  while(true) {
    self waittill("veh_predictedcollision", velocity, normal);

    if(normal[2] >= 0.6)
      self notify("veh_collision", velocity, normal);
  }
}

quadrotor_collision_player() {
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

quadrotor_collision() {
  self endon("change_state");
  self endon("crash_done");
  self endon("death");

  if(!isalive(self))
    self thread quadrotor_predicted_collision();

  while(true) {
    self waittill("veh_collision", velocity, normal);
    ang_vel = self getangularvelocity() * 0.5;
    self setangularvelocity(ang_vel);

    if(normal[2] < 0.6 || isalive(self) && !isDefined(self.emped)) {
      self setvehvelocity(self.velocity + normal * 90);
      self playsound("veh_qrdrone_wall");

      if(normal[2] < 0.6)
        fx_origin = self.origin - normal * 28;
      else
        fx_origin = self.origin - normal * 10;

      playfx(level._effect["quadrotor_nudge"], fx_origin, normal);
    } else if(isDefined(self.emped)) {
      if(isDefined(self.bounced)) {
        self playsound("veh_qrdrone_wall");
        self setvehvelocity((0, 0, 0));
        self setangularvelocity((0, 0, 0));

        if(self.angles[0] < 0) {
          if(self.angles[0] < -15)
            self.angles = (-15, self.angles[1], self.angles[2]);
          else if(self.angles[0] > -10)
            self.angles = (-10, self.angles[1], self.angles[2]);
        } else if(self.angles[0] > 15)
          self.angles = (15, self.angles[1], self.angles[2]);
        else if(self.angles[0] < 10)
          self.angles = (10, self.angles[1], self.angles[2]);

        self.bounced = undefined;
        self notify("landed");
        return;
      } else {
        self.bounced = 1;
        self setvehvelocity(self.velocity + normal * 120);
        self playsound("veh_qrdrone_wall");

        if(normal[2] < 0.6)
          fx_origin = self.origin - normal * 28;
        else
          fx_origin = self.origin - normal * 10;

        playfx(level._effect["quadrotor_nudge"], fx_origin, normal);
      }
    } else {
      createdynentandlaunch(self.deathmodel, self.origin, self.angles, self.origin, self.velocity * 0.01, level._effect["quadrotor_crash"], 1);
      self playsound("veh_qrdrone_explo");
      self thread death_fire_loop_audio();
      self notify("crash_done");
    }
  }
}

death_fire_loop_audio() {
  sound_ent = spawn("script_origin", self.origin);
  sound_ent playloopsound("veh_qrdrone_death_fire_loop", 0.1);
  wait 11;
  sound_ent stoploopsound(1);
  sound_ent delete();
}

quadrotor_set_team(team) {
  self.vteam = team;

  if(isDefined(self.vehmodelenemy)) {
    if(issubstr(level.script, "so_rts_")) {
    } else if(team == "axis") {
      self setmodel(self.vehmodelenemy);
      self setvehweapon("quadrotor_turret_enemy");
    } else {
      self setmodel(self.vehmodel);
      self setvehweapon("quadrotor_turret");
    }
  }

  if(!isDefined(self.off))
    quadrotor_blink_lights();
}

quadrotor_blink_lights() {
  self endon("death");
  self lights_off();
  wait 0.1;
  self lights_on();
}

quadrotor_update_rumble() {
  self endon("death");
  self endon("exit_vehicle");

  while(true) {
    vr = abs(self getspeed() / self getmaxspeed());

    if(vr < 0.1) {
      level.player playrumbleonentity("quadrotor_fly");
      wait 0.35;
    } else {
      time = randomfloatrange(0.1, 0.2);
      earthquake(randomfloatrange(0.1, 0.15), time, self.origin, 200);
      level.player playrumbleonentity("quadrotor_fly");
      wait(time);
    }
  }
}

quadrotor_self_destruct() {
  self endon("death");
  self endon("exit_vehicle");
  self_destruct = 0;
  self_destruct_time = 0;

  while(true) {
    if(!self_destruct) {
      if(level.player meleebuttonpressed()) {
        self_destruct = 1;
        self_destruct_time = 5;
      }

      wait 0.05;
      continue;
    } else {
      iprintlnbold(self_destruct_time);
      wait 1;
      self_destruct_time = self_destruct_time - 1;

      if(self_destruct_time == 0) {
        driver = self getseatoccupant(0);

        if(isDefined(driver))
          driver disableinvulnerability();

        earthquake(3, 1, self.origin, 256);
        radiusdamage(self.origin, 1000, 15000, 15000, level.player, "MOD_EXPLOSIVE");
        self dodamage(self.health + 1000, self.origin);
      }

      continue;
    }
  }
}

quadrotor_level_out_for_landing() {
  self endon("death");
  self endon("emped");
  self endon("landed");

  while(isDefined(self.emped)) {
    velocity = self.velocity;
    self.angles = (self.angles[0] * 0.85, self.angles[1], self.angles[2] * 0.85);
    ang_vel = self getangularvelocity() * 0.85;
    self setangularvelocity(ang_vel);
    self setvehvelocity(velocity);
    wait 0.05;
  }
}

quadrotor_emped() {
  self endon("death");
  self notify("emped");
  self endon("emped");
  self.emped = 1;
  playsoundatposition("veh_qrdrone_emp_down", self.origin);
  self quadrotor_off();
  self setphysacceleration(vectorscale((0, 0, -1), 600.0));
  self thread quadrotor_level_out_for_landing();
  self thread quadrotor_collision();

  if(!isDefined(self.stun_fx)) {
    self.stun_fx = spawn("script_model", self.origin);
    self.stun_fx setmodel("tag_origin");
    self.stun_fx linkto(self, "tag_origin", (0, 0, 0), (0, 0, 0));
    playfxontag(level._effect["quadrotor_stun"], self.stun_fx, "tag_origin");
  }

  wait(randomfloatrange(4, 7));
  self.stun_fx delete();
  self.emped = undefined;
  self setphysacceleration((0, 0, 0));
  self quadrotor_on();
  self playsound("veh_qrdrone_boot_qr");
}

quadrotor_temp_bullet_shield(invulnerable_time) {
  self notify("bullet_shield");
  self endon("bullet_shield");
  self.bullet_shield = 1;
  wait(invulnerable_time);

  if(isDefined(self)) {
    self.bullet_shield = undefined;
    wait 3;

    if(isDefined(self) && self.health < 40)
      self.health = 40;
  }
}

quadrotorcallback_vehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  driver = self getseatoccupant(0);

  if(sweapon == "emp_grenade_sp" && smeansofdeath != "MOD_IMPACT") {
    if(!isDefined(driver)) {
      if(!isDefined(self.off))
        self thread quadrotor_emped();
    }
  }

  if(self.vteam == "axis") {
    idamage = idamage * maps\_gameskill::getcurrentdifficultysetting("quadrotor_axis_damage_scale");
    idamage = int(idamage);
  } else {
    idamage = idamage * maps\_gameskill::getcurrentdifficultysetting("quadrotor_allies_damage_scale");
    idamage = int(idamage);
  }

  if(isDefined(driver)) {
    if(smeansofdeath == "MOD_BULLET") {
      if(isDefined(self.bullet_shield))
        idamage = 3;
    }

    if(!isDefined(self.bullet_shield))
      self thread quadrotor_temp_bullet_shield(0.35);

    driver finishplayerdamage(einflictor, eattacker, 1, idflags, smeansofdeath, sweapon, vpoint, vdir, "none", 0, psoffsettime);
  }

  return idamage;
}
/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_metal_storm.gsc
**************************************/

#include animscripts\utility;
#include common_scripts\utility;
#include maps\_utility;
#include maps\_vehicle;
#include maps\_vehicle_death;
#include maps\_statemachine;
#include maps\_gameskill;

init(variant) {
  vehicle_add_main_callback("drone_metalstorm", ::main);
  vehicle_add_main_callback("drone_metalstorm_rts", ::main);
  vehicle_add_main_callback("drone_metalstorm_afghan_rts", ::main);
  vehicle_add_main_callback("drone_metalstorm_karma", ::main);
  vehicle_add_main_callback("drone_metalstorm_monsoon", ::main);
  vehicle_add_loadfx_callback("drone_metalstorm", ::precache_damage_fx);
  vehicle_add_loadfx_callback("drone_metalstorm_rts", ::precache_damage_fx);
  vehicle_add_loadfx_callback("drone_metalstorm_afghan_rts", ::precache_damage_fx);
  vehicle_add_loadfx_callback("drone_metalstorm_karma", ::precache_damage_fx);
  vehicle_add_loadfx_callback("drone_metalstorm_monsoon", ::precache_damage_fx);

  if(isDefined(variant)) {
    vehicle_add_main_callback(variant, ::main);
    vehicle_add_loadfx_callback(variant, ::precache_damage_fx);
  }

  level.difficultysettings["asd_burst_scale"]["easy"] = 1.15;
  level.difficultysettings["asd_burst_scale"]["normal"] = 1;
  level.difficultysettings["asd_burst_scale"]["hardened"] = 0.85;
  level.difficultysettings["asd_burst_scale"]["veteran"] = 0.7;
  level.difficultysettings["asd_health_boost"]["easy"] = -70;
  level.difficultysettings["asd_health_boost"]["normal"] = 0;
  level.difficultysettings["asd_health_boost"]["hardened"] = 70;
  level.difficultysettings["asd_health_boost"]["veteran"] = 140;

  if(tolower(getdvar(#"mapname")) == "so_rts_mp_drone")
    level.asd_use_double_wide = 0;
  else if(tolower(getdvar(#"mapname")) == "so_tut_mp_drone")
    level.asd_use_double_wide = 0;
  else
    level.asd_use_double_wide = 1;
}

precache_damage_fx() {
  precachemodel("veh_t6_drone_tank_alt_dead");

  if(!isDefined(level.fx_damage_effects))
    level.fx_damage_effects = [];

  if(!isDefined(level.fx_damage_effects[self.vehicletype]))
    level.fx_damage_effects[self.vehicletype] = [];

  for(i = 0; i < 4; i++)
    level.fx_damage_effects[self.vehicletype][i] = loadfx("destructibles/fx_metalstorm_damagestate0" + (i + 1));

  level._effect["metalstorm_busted"] = loadfx("destructibles/fx_metalstorm_damagestate_back01");
  level._effect["metalstorm_explo"] = loadfx("destructibles/fx_metalstorm_death01a");
  level._effect["metalstorm_hit"] = loadfx("impacts/fx_metalstorm_hit01");
  level._effect["metalstorm_hit_back"] = loadfx("impacts/fx_metalstorm_hit02");
  level._effect["eye_light_friendly"] = loadfx("light/fx_vlight_metalstorm_eye_grn");
  level._effect["eye_light_enemy"] = loadfx("light/fx_vlight_metalstorm_eye_red");
  level._effect["metalstorm_stun"] = loadfx("electrical/fx_elec_sp_emp_stun_metalstorm");
}

main() {
  self thread metalstorm_think2();
  self thread update_damage_states();
  self thread metalstorm_rocket_recoil();
  self thread metalstorm_death();

  self thread metalstorm_debug();

  self.overridevehicledamage = ::metalstormcallback_vehicledamage;
}

metalstorm_think2() {
  self enableaimassist();
  self setneargoalnotifydist(35);
  self setvehicleavoidance(1, 30);
  self setspeed(5, 5, 5);
  self.turret_state = 0;
  self.turret_on_target = 0;
  self.vehhighlyawareradius = 80;

  if(!isDefined(self.goalradius))
    self.goalradius = 600;

  if(!isDefined(self.goalpos))
    self.goalpos = self.origin;

  self setvehgoalpos(self.goalpos, 1);
  self.state_machine = create_state_machine("metalstormbrain", self);
  main = self.state_machine add_state("main", undefined, undefined, ::metalstorm_main, ::can_enter_main, undefined);
  scripted = self.state_machine add_state("scripted", undefined, undefined, ::metalstorm_scripted, undefined, undefined);
  main add_connection_by_type("scripted", 999, 4, undefined, "enter_vehicle");
  main add_connection_by_type("scripted", 999, 4, undefined, "scripted");
  scripted add_connection_by_type("main", 1, 4, undefined, "exit_vehicle");
  scripted add_connection_by_type("main", 2, 4, undefined, "main");
  scripted add_connection_by_type("scripted", 999, 4, undefined, "enter_vehicle");

  if(isDefined(self.script_startstate)) {
    if(self.script_startstate == "off")
      self metalstorm_off();
    else
      self.state_machine set_state(self.script_startstate);
  } else
    metalstorm_start_ai();

  self thread metalstorm_set_team(self.vteam);
  waittillframeend;

  if(self.vteam == "axis")
    self.health = self.health + maps\_gameskill::getcurrentdifficultysetting("asd_health_boost");
}

can_enter_main() {
  if(!isalive(self))
    return false;

  driver = self getseatoccupant(0);

  if(isDefined(driver))
    return false;

  return true;
}

metalstorm_off() {
  self.state_machine set_state("scripted");
  self lights_off();
  self laseroff();
  self veh_toggle_tread_fx(0);
  self vehicle_toggle_sounds(0);
  self veh_toggle_exhaust_fx(0);
  angles = self gettagangles("tag_flash");
  target_vec = self.origin + anglestoforward((0, angles[1], 0)) * 1000;
  target_vec = target_vec + vectorscale((0, 0, -1), 700.0);
  self settargetorigin(target_vec);
  self.off = 1;

  if(!isDefined(self.emped))
    self disableaimassist();
}

metalstorm_on() {
  self lights_on();
  self veh_toggle_tread_fx(1);
  self enableaimassist();
  self vehicle_toggle_sounds(1);
  self bootup();
  self playsound("veh_metalstorm_boot_up");
  self veh_toggle_exhaust_fx(1);
  self.off = undefined;
  metalstorm_start_ai();
}

bootup() {
  for(i = 0; i < 6; i++) {
    wait 0.1;
    lights_off();
    wait 0.1;
    lights_on();
  }

  angles = self gettagangles("tag_flash");
  target_vec = self.origin + anglestoforward((0, angles[1], 0)) * 1000;
  self.turretrotscale = 0.3;
  driver = self getseatoccupant(0);

  if(!isDefined(driver))
    self settargetorigin(target_vec);

  wait 1;
  self.turretrotscale = 1;
}

metalstorm_turret_on_vis_target_thread() {
  self endon("death");
  self endon("change_state");
  self.turret_on_target = 0;

  while(true) {
    self waittill("turret_on_vistarget");
    self.turret_on_target = 1;
    wait 0.05;
  }
}

metalstorm_turret_on_target_thread() {
  self endon("death");
  self endon("change_state");
  self notify("turret_on_target_thread");
  self endon("turret_on_target_thread");
  self.turret_on_target = 0;

  while(true) {
    self waittill("turret_on_target");
    self.turret_on_target = 1;
    wait 0.5;
  }
}

metalstorm_turret_scan(scan_forever) {
  self endon("death");
  self endon("change_state");
  self thread metalstorm_turret_on_target_thread();
  self.turretrotscale = 0.35;

  while(scan_forever || (!isDefined(self.enemy) || !self vehcansee(self.enemy))) {
    if(self.turret_on_target) {
      self.turret_on_target = 0;
      self.turret_state++;

      if(self.turret_state >= 5)
        self.turret_state = 0;
    }

    switch (self.turret_state) {
      case 0:
        if(isDefined(self.enemy)) {
          target_vec = (self.enemy.origin[0], self.enemy.origin[1], self.origin[2]);
          break;
        }
      case 1:
        target_vec = self.origin + anglestoforward((0, self.angles[1], 0)) * 1000;
        break;
      case 2:
        target_vec = self.origin + anglestoforward((0, self.angles[1] + 90, 0)) * 1000;
        break;
      case 3:
        target_vec = self.origin + anglestoforward((0, self.angles[1], 0)) * 1000;
        break;
      case 4:
        target_vec = self.origin + anglestoforward((0, self.angles[1] - 90, 0)) * 1000;
        break;
    }

    target_vec = target_vec + vectorscale((0, 0, 1), 40.0);
    self settargetorigin(target_vec);
    wait 0.2;
  }
}

metalstorm_grenade_watcher() {
  self endon("death");
  self endon("change_state");
  wait 1;

  while(true) {
    level.player waittill("grenade_fire", grenade);
    vel_towards_me = vectordot(grenade getvelocity(), vectornormalize(self.origin - grenade.origin));

    if(vel_towards_me < 100 || !self vehcansee(grenade)) {
      continue;
    }
    wait 0.15;
    distsq = 0;

    if(isDefined(grenade)) {
      distsq = distancesquared(self.origin, grenade.origin);

      while(isDefined(grenade) && (distsq > 422500 || distsq < 22500)) {
        distsq = distancesquared(self.origin, grenade.origin);
        wait 0.05;
      }
    }

    if(!isDefined(grenade)) {
      continue;
    }
    vel_towards_me = vectordot(grenade getvelocity(), vectornormalize(self.origin - grenade.origin));

    if(vel_towards_me < 100) {
      continue;
    }
    self setspeed(0);
    self.turretrotscale = 2;
    self setturrettargetent(grenade);
    self thread metalstorm_turret_on_vis_target_thread();
    wait 0.05;

    for(i = 0; i < 6; i++) {
      self fireweapon();

      if(randomint(100) > 40 && self.turret_on_target) {
        if(isDefined(grenade))
          grenade resetmissiledetonationtime(0);

        break;
      }

      wait 0.15;
    }

    self setspeed(5, 5, 5);
    self clearturrettarget();
  }
}

metalstorm_weapon_think() {
  self endon("death");
  self endon("change_state");
  cant_see_enemy_count = 0;
  self thread metalstorm_grenade_watcher();

  while(true) {
    enemy_is_tank = 0;
    enemy_is_hind = 0;

    if(isDefined(self.enemy) && isDefined(self.enemy.vehicletype)) {
      enemy_is_tank = self.enemy.vehicletype == "tank_t72_rts" || self.enemy.vehicletype == "drone_claw_rts";
      enemy_is_hind = self.enemy.vehicletype == "heli_hind_afghan_rts";
    }

    if(isDefined(self.enemy) && self vehcansee(self.enemy)) {
      self.turretrotscale = 1;
      self setturrettargetent(self.enemy);

      if(cant_see_enemy_count >= 2) {
        self clearvehgoalpos();
        self notify("near_goal");
      }

      cant_see_enemy_count = 0;

      if(isplayer(self.enemy))
        self playsound("wpn_metalstorm_lock_on");

      self thread metalstorm_blink_lights();
      self laseron();
      wait 1.0;

      if(isDefined(self.enemy) && self vehcansee(self.enemy)) {
        if(isDefined(self.enemy) && distancesquared(self.origin, self.enemy.origin) > 640000 || enemy_is_tank) {
          if(enemy_is_hind)
            self setgunnertargetent(self.enemy, vectorscale((0, 0, -1), 40.0), 0);

          self firegunnerweapon(0);
          self cleargunnertarget(0);
        } else
          self metalstorm_fire_for_time(randomfloatrange(1.5, 2.5));
      }

      self laseroff();
      wait(randomfloatrange(1.2, 2) * maps\_gameskill::getcurrentdifficultysetting("asd_burst_scale"));
    } else {
      cant_see_enemy_count++;
      wait 0.5;

      if(cant_see_enemy_count > 2)
        self metalstorm_turret_scan(0);
      else if(cant_see_enemy_count > 1)
        self cleartargetentity();
    }
  }
}

metalstorm_fire_for_time(totalfiretime) {
  self endon("crash_done");
  self endon("death");
  weaponname = self seatgetweapon(0);
  firetime = weaponfiretime(weaponname);

  for(time = 0; time < totalfiretime; time = time + firetime) {
    if(isDefined(self.enemy) && isDefined(self.enemy.attackeraccuracy) && self.enemy.attackeraccuracy == 0)
      self fireweapon(undefined, undefined, 1);
    else
      self fireweapon();

    wait(firetime);
  }
}

metalstorm_start_ai(state) {
  self.goalpos = self.origin;

  if(!isDefined(state))
    state = "main";

  self.state_machine set_state(state);
}

metalstorm_stop_ai() {
  self.state_machine set_state("scripted");
}

metalstorm_main() {
  while(isDefined(self.emped))
    wait 1;

  if(isDefined(self.vmaxaispeedoverridge))
    self setspeed(self.vmaxaispeedoverridge, 5, 5);
  else {
    self setspeed(5, 5, 5);
    self setvehmaxspeed(0);
  }

  self thread metalstorm_movementupdate();
  self thread metalstorm_weapon_think();
}

metalstorm_debug() {
  self endon("death");

  while(true) {
    if(getdvarint(#"_id_0E889A73") == 0) {
      wait 0.5;
      continue;
    }

    if(isDefined(self.goalpos)) {
      debugstar(self.goalpos, 10, (1, 0, 0));
      circle(self.goalpos, self.goalradius, (1, 0, 0), 0, 10);
    }

    if(isDefined(self.enemy))
      line(self.origin + vectorscale((0, 0, 1), 30.0), self.enemy.origin + vectorscale((0, 0, 1), 30.0), (1, 0, 0), 1, 1);

    wait 0.05;
  }

}

metalstorm_check_move(position) {
  results = physicstraceex(self.origin, position, (-15, -15, -5), (15, 15, 5), self);

  if(results["fraction"] == 1)
    return true;

  return false;
}

path_update_interrupt() {
  self endon("death");
  self endon("change_state");
  self endon("near_goal");
  self endon("reached_end_node");
  wait 1;

  while(true) {
    if(isDefined(self.enemy) && isDefined(self.goal_node)) {
      if(distance2dsquared(self.enemy.origin, self.origin) < 22500) {
        self.move_now = 1;
        self notify("near_goal");
      }

      if(distance2dsquared(self.enemy.origin, self.goal_node.origin) < 22500) {
        self.move_now = 1;
        self notify("near_goal");
      }
    }

    if(isDefined(self.goal_node)) {
      if(distance2dsquared(self.goal_node.origin, self.goalpos) > self.goalradius * self.goalradius) {
        wait 1;
        self.move_now = 1;
        self notify("near_goal");
      }
    }

    wait 0.2;
  }
}

waittill_enemy_too_close_or_timeout(time) {
  self endon("death");
  self endon("change_state");

  while(time > 0) {
    time = time - 0.2;
    wait 0.2;

    if(isDefined(self.enemy)) {
      if(distance2dsquared(self.enemy.origin, self.origin) < 22500) {
        return;
      }
      if(!isDefined(self.goal_node)) {
        return;
      }
      if(distance2dsquared(self.enemy.origin, self.goal_node.origin) < 22500)
        return;
    }
  }
}

metalstorm_movementupdate() {
  self endon("death");
  self endon("change_state");

  if(distance2dsquared(self.origin, self.goalpos) > 400)
    self setvehgoalpos(self.goalpos, 1, 2, level.asd_use_double_wide);

  wait 0.5;
  goalfailures = 0;

  while(true) {
    goalpos = metalstorm_find_new_position();

    if(self setvehgoalpos(goalpos, 0, 2, level.asd_use_double_wide)) {
      self thread path_update_interrupt();
      goalfailures = 0;
      self waittill_any("near_goal", "reached_end_node");

      if(isDefined(self.move_now)) {
        self.move_now = undefined;
        wait 0.1;
      } else if(isDefined(self.enemy) && self vehcansee(self.enemy)) {
        if(abs(angleclamp180(self.angles[0])) > 6 || abs(angleclamp180(self.angles[2])) > 6)
          self setbrake(1);

        waittill_enemy_too_close_or_timeout(randomfloatrange(3, 4));
      } else {
        if(abs(angleclamp180(self.angles[0])) > 6 || abs(angleclamp180(self.angles[2])) > 6)
          self setbrake(1);

        wait 0.5;
      }

      self setbrake(0);
    } else {
      goalfailures++;
      offset = (randomfloatrange(-70, 70), randomfloatrange(-70, 70), 15);
      goalpos = self.origin + offset;

      if(self metalstorm_check_move(goalpos)) {
        self setvehgoalpos(goalpos, 0);
        self waittill("near_goal");
        wait 2;
      }

      wait 0.5;
    }
  }
}

metalstorm_find_new_position() {
  origin = self.goalpos;
  nodes = getnodesinradius(self.goalpos, self.goalradius, 0, 128, "Path");

  if(nodes.size == 0) {
    self.goalpos = (self.goalpos[0], self.goalpos[1], self.origin[2]);
    nodes = getnodesinradius(self.goalpos, self.goalradius + 500, 0, 500, "Path");
  }

  best_node = undefined;
  best_score = -999999;

  if(isDefined(self.enemy)) {
    vec_enemy_to_self = vectornormalize((self.origin[0], self.origin[1], 0) - (self.enemy.origin[0], self.enemy.origin[1], 0));

    foreach(node in nodes) {
      if(!node has_spawnflag(1048576)) {
        continue;
      }
      vec_enemy_to_node = (node.origin[0], node.origin[1], 0) - (self.enemy.origin[0], self.enemy.origin[1], 0);
      dist_in_front_of_enemy = vectordot(vec_enemy_to_node, vec_enemy_to_self);
      dist_away_from_sweet_line = abs(dist_in_front_of_enemy - 350);
      score = 1 + randomfloat(0.15);

      if(dist_away_from_sweet_line > 100)
        score = score - clamp(dist_away_from_sweet_line / 800, 0, 0.5);

      if(distance2dsquared(node.origin, self.enemy.origin) > 302500)
        score = score - 0.2;

      if(distance2dsquared(self.origin, node.origin) < 14400)
        score = score - 0.2;

      if(isDefined(node.metal_storm_previous_goal)) {
        score = score - 0.2;
        node.metal_storm_previous_goal--;

        if(node.metal_storm_previous_goal == 0)
          node.metal_storm_previous_goal = undefined;
      }

      if(score > best_score) {
        best_score = score;
        best_node = node;
      }
    }
  } else {
    foreach(node in nodes) {
      if(!node has_spawnflag(1048576)) {
        continue;
      }
      score = randomfloat(1);

      if(distance2dsquared(self.origin, node.origin) < 100)
        score = score - 0.5;

      if(isDefined(node.metal_storm_previous_goal)) {
        score = score - 0.2;
        node.metal_storm_previous_goal--;

        if(node.metal_storm_previous_goal == 0)
          node.metal_storm_previous_goal = undefined;
      }

      if(score > best_score) {
        best_score = score;
        best_node = node;
      }
    }
  }

  if(isDefined(best_node)) {
    best_node.metal_storm_previous_goal = 3;
    origin = best_node.origin;
    self.goal_node = best_node;
  }

  return origin;
}

metalstorm_exit_vehicle() {
  self waittill("exit_vehicle", player);
  player.ignoreme = 0;
  player disableinvulnerability();
  self thread metalstorm_rocket_recoil();
  self showpart("tag_pov_hide");
  self.goalpos = self.origin;
}

metalstorm_scripted() {
  self endon("change_state");
  driver = self getseatoccupant(0);

  if(isDefined(driver)) {
    self.turretrotscale = 1;
    self disableaimassist();
    self hidepart("tag_pov_hide");
    self thread vehicle_damage_filter("firestorm_turret");
    self thread metalstorm_set_team(driver.team);
    self setvehmaxspeed(isDefined(self.vmaxspeedoverridge) ? self.vmaxspeedoverridge : 7);
    driver enableinvulnerability();
    driver.ignoreme = 1;
    self thread metalstorm_player_rocket_recoil(driver);
    self thread metalstorm_player_bullet_shake(driver);
    self thread metalstorm_player_hit_dudes_sound();
    self thread metalstorm_exit_vehicle();
    self setbrake(0);
  }

  self laseroff();
  self cleartargetentity();
  self cancelaimove();
  self clearvehgoalpos();
}

metalstorm_update_damage_fx() {
  next_damage_state = 0;
  max_health = self.healthdefault;

  if(isDefined(self.health_max))
    max_health = self.health_max;

  health_pct = self.health / max_health;

  if(health_pct <= 0.75 && health_pct > 0.5)
    next_damage_state = 1;
  else if(health_pct <= 0.5 && health_pct > 0.25)
    next_damage_state = 2;
  else if(health_pct <= 0.25 && health_pct > 0.1)
    next_damage_state = 3;
  else if(health_pct <= 0.1)
    next_damage_state = 4;

  if(next_damage_state != self.current_damage_state) {
    if(isDefined(level.fx_damage_effects[self.vehicletype][next_damage_state - 1])) {
      fx_ent = self get_damage_fx_ent();
      playfxontag(level.fx_damage_effects[self.vehicletype][next_damage_state - 1], fx_ent, "tag_origin");
    } else
      get_damage_fx_ent();

    self.current_damage_state = next_damage_state;
  }
}

update_damage_states() {
  self endon("death");
  self.current_damage_state = 0;

  if(!isDefined(level.fx_damage_effects[self.vehicletype])) {
    return;
  }
  while(true) {
    self waittill("damage", damage, attacker, dir, point, mod, model, modelattachtag, part);

    if(!isDefined(self)) {
      return;
    }
    if(mod == "MOD_RIFLE_BULLET" || mod == "MOD_PISTOL_BULLET" || mod == "MOD_MELEE") {
      if(part == "tag_control_panel" || part == "tag_body_panel")
        playfx(level._effect["metalstorm_hit_back"], point, dir);
      else
        playfx(level._effect["metalstorm_hit"], point, dir);
    }

    self.turret_state = 0;
    self.turretrotscale = 1.0;
    self.turret_on_target = 1;
    metalstorm_update_damage_fx();
  }
}

get_damage_fx_ent() {
  if(isDefined(self.damage_fx_ent))
    self.damage_fx_ent delete();

  self.damage_fx_ent = spawn("script_model", (0, 0, 0));
  self.damage_fx_ent setmodel("tag_origin");
  self.damage_fx_ent.origin = self.origin;
  self.damage_fx_ent.angles = self.angles;
  self.damage_fx_ent linkto(self, "tag_turret", (0, 0, 0), (0, 0, 0));
  return self.damage_fx_ent;
}

cleanup_fx_ents() {
  if(isDefined(self.damage_fx_ent))
    self.damage_fx_ent delete();

  if(isDefined(self.stun_fx))
    self.stun_fx delete();
}

metalstorm_freeze_blink_lights() {
  self endon("death");
  self lights_off();
  wait 0.4;
  self lights_on();
  wait 0.3;
  self lights_off();
  wait 0.4;
  self lights_on();
  wait 0.3;
  self lights_off();
  wait 0.4;
  self lights_on();
  wait 0.3;
  self lights_off();
}

metalstorm_freeze_death(attacker, mod) {
  self endon("death");
  level notify("asd_freezed");
  level.player inc_general_stat("mechanicalkills");
  goaldist = randomfloatrange(350, 450);
  deathgoal = self.origin + anglestoforward(self.angles) * goaldist;
  playfxontag(level._effect["freeze_short_circuit"], self, "tag_origin");
  self setmodel("veh_t6_drone_tank_freeze");
  self setvehgoalpos(deathgoal, 0);
  self thread metalstorm_freeze_blink_lights();
  self setclientflag(12);
  self.turretrotscale = 0.3;
  self setspeed(1);

  if(!isDefined(self.stun_fx)) {
    self.stun_fx = spawn("script_model", self.origin);
    self.stun_fx setmodel("tag_origin");
    self.stun_fx linkto(self, "tag_turret", (0, 0, 0), (0, 0, 0));
    playfxontag(level._effect["metalstorm_stun"], self.stun_fx, "tag_origin");
  }

  wait 1;
  self.turretrotscale = 0.1;
  self setspeed(0.5);
  self laseroff();
  wait 1;
  self.turretrotscale = 0.01;
  self setspeed(0.0);
  wait 1;
  self cancelaimove();
  self clearvehgoalpos();
  self clearturrettarget();
  wait 2;

  if(isDefined(self.stun_fx))
    self.stun_fx delete();
}

metalstorm_death() {
  wait 0.1;
  self notify("nodeath_thread");
  self waittill("death", attacker, damagefromunderneath, weapon, point, dir, mod);

  if(isDefined(self.eye_fx_ent))
    self.eye_fx_ent delete();

  if(isDefined(self.delete_on_death)) {
    self cleanup_fx_ents();
    self delete();
    return;
  }

  if(!isDefined(self)) {
    return;
  }
  self maps\_vehicle_death::death_cleanup_level_variables();
  self disableaimassist();
  self vehicle_toggle_sounds(0);
  self lights_off();
  self laseroff();
  self cleanup_fx_ents();
  self veh_toggle_tread_fx(0);
  self veh_toggle_exhaust_fx(0);

  if(isDefined(mod) && mod == "MOD_GAS" && isDefined(level.metalstorm_freeze_death))
    self metalstorm_freeze_death(attacker, mod);
  else {
    fx_ent = self get_damage_fx_ent();
    playfxontag(level._effect["metalstorm_explo"], fx_ent, "tag_origin");
    self playsound("veh_metalstorm_dying");
    self metalstorm_crash_movement(attacker);
  }

  wait 5;

  if(isDefined(self)) {
    radius = 18;
    height = 50;
    badplace_cylinder("", 40, self.origin, radius, height, "all");
    self freevehicle();
  }

  wait 40;

  if(isDefined(self))
    self delete();
}

death_fx() {
  playfxontag(self.deathfx, self, self.deathfxtag);
  self playsound("veh_metalstorm_sparks");
}

metalstorm_crash_movement(attacker) {
  self endon("crash_done");
  self endon("death");
  self cancelaimove();
  self clearvehgoalpos();
  self.takedamage = 0;

  if(!isDefined(self.off)) {
    self thread death_turret_rotate();
    self.turretrotscale = 1.0;
    self playsound("wpn_turret_alert");
    self thread metalstorm_fire_for_time(randomfloatrange(1.5, 4.0));
    self setspeed(7);
    deathmove = randomint(8);

    if(deathmove == 0) {
      goaldist = randomfloatrange(350, 450);
      deathgoal = self.origin + anglestoforward(self.angles) * goaldist;
    } else if(deathmove == 1) {
      goaldist = randomfloatrange(350, 450);
      deathgoal = self.origin + anglestoforward(self.angles) * (goaldist * -1);
    } else if(deathmove <= 4)
      self thread spin_crash();
    else if(isDefined(attacker))
      deathgoal = attacker.origin;
    else
      self thread spin_crash();

    if(isDefined(deathgoal))
      self setvehgoalpos(deathgoal, 0);

    wait 0.5;
    self waittill_any_timeout(2.5, "near_goal", "veh_collision");
  }

  if(!isDefined(self)) {
    return;
  }
  self cancelaimove();
  self clearvehgoalpos();
  self clearturrettarget();
  self setbrake(1);
  self thread maps\_vehicle_death::death_radius_damage();

  if(self.team == "allies" || issubstr(self.vehicletype, "karma"))
    self thread maps\_vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
  else
    self thread maps\_vehicle_death::set_death_model("veh_t6_drone_tank_alt_dead", self.modelswapdelay);

  self death_fx();
  self launchvehicle((randomfloatrange(-20, 20), randomfloatrange(-20, 20), 32), (randomfloatrange(-5, 5), randomfloatrange(-5, 5), 0), 1, 0);
  self playsound("exp_metalstorm_vehicle");
  self notify("crash_done");
}

spin_crash() {
  self endon("crash_done");
  turn_rate = 5 + randomfloatrange(0, 20);

  if(randomint(100) > 50)
    turn_rate = turn_rate * -1;

  count = 0;

  while(isDefined(self)) {
    deathgoal = self.origin + anglestoforward((0, self.angles[1] + turn_rate, 0)) * 300;
    self setvehgoalpos(deathgoal, 0);
    wait 0.05;
    count++;

    if(count % 10 == 0)
      turn_rate = turn_rate + randomfloatrange(-10, 10);
  }
}

death_turret_rotate() {
  self endon("crash_done");
  self endon("death");
  self.turretrotscale = 1.3;

  while(true) {
    pitch = randomfloatrange(-60, 20);
    target_vec = self.origin + anglestoforward((pitch, randomfloat(360), 0)) * 1000;
    driver = self getseatoccupant(0);

    if(!isDefined(driver))
      self settargetorigin(target_vec);

    wait(randomfloatrange(0.3, 0.6));

    if(pitch < 0 && randomint(100) > 50)
      self firegunnerweapon(0);
  }
}

metalstorm_emped() {
  self endon("death");
  self notify("emped");
  self endon("emped");
  self.emped = 1;
  playsoundatposition("veh_asd_emp_down", self.origin);
  self.turretrotscale = 0.2;
  self metalstorm_off();

  if(!isDefined(self.stun_fx)) {
    self.stun_fx = spawn("script_model", self.origin);
    self.stun_fx setmodel("tag_origin");
    self.stun_fx linkto(self, "tag_turret", (0, 0, 0), (0, 0, 0));
    playfxontag(level._effect["metalstorm_stun"], self.stun_fx, "tag_origin");
  }

  wait(randomfloatrange(4, 8));
  self.stun_fx delete();
  self.emped = undefined;
  self metalstorm_on();
  self playsound("veh_qrdrone_boot_asd");
}

metalstormcallback_vehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  is_damaged_by_grenade = isDefined(sweapon) && weaponclass(sweapon) == "grenade";
  is_damaged_by_god_rod = isDefined(sweapon) && sweapon == "god_rod_sp";

  if(is_damaged_by_grenade || is_damaged_by_god_rod) {
    if(sweapon == "titus_explosive_dart_sp" && idamage > 50 && self.vteam == "axis")
      idamage = int(idamage * 10);
    else
      idamage = int(idamage * 3);
  }

  if(smeansofdeath == "MOD_GAS")
    idamage = self.health + 100;

  driver = self getseatoccupant(0);

  if(sweapon == "emp_grenade_sp" && smeansofdeath != "MOD_IMPACT") {
    if(!isDefined(driver))
      self thread metalstorm_emped();
  }

  if(isDefined(driver))
    driver finishplayerdamage(einflictor, eattacker, 1, idflags, smeansofdeath, sweapon, vpoint, vdir, "none", 0, psoffsettime);

  return idamage;
}

metalstorm_set_team(team) {
  self.vteam = team;

  if(isDefined(self.vehmodelenemy)) {
    if(team == "allies")
      self setmodel(self.vehmodel);
    else
      self setmodel(self.vehmodelenemy);
  }

  if(!isDefined(self.off))
    metalstorm_blink_lights();
}

metalstorm_blink_lights() {
  self endon("death");
  self lights_off();
  wait 0.1;
  self lights_on();
  wait 0.1;
  self lights_off();
  wait 0.1;
  self lights_on();
}

metalstorm_player_bullet_shake(player) {
  self endon("death");
  self endon("recoil_thread");

  while(true) {
    self waittill("turret_fire");
    angles = self gettagangles("tag_barrel");
    dir = anglestoforward(angles);
    self launchvehicle(dir * -5, self.origin + vectorscale((0, 0, 1), 30.0), 0);
    earthquake(0.2, 0.2, player.origin, 200);
  }
}

#using_animtree("vehicles");

metalstorm_player_rocket_recoil(player) {
  self notify("recoil_thread");
  self endon("recoil_thread");
  self endon("death");

  while(true) {
    player waittill("missile_fire");
    angles = self gettagangles("tag_barrel");
    dir = anglestoforward(angles);
    self launchvehicle(dir * -30, self.origin + vectorscale((0, 0, 1), 70.0), 0);
    earthquake(0.4, 0.3, player.origin, 200);
    self setanimrestart( % o_drone_tank_missile_fire_sp, 1, 0, 0.4);
  }
}

metalstorm_rocket_recoil() {
  self notify("recoil_thread");
  self endon("recoil_thread");
  self endon("death");

  while(true) {
    self waittill("missile_fire");
    angles = self gettagangles("tag_barrel");
    dir = anglestoforward(angles);
    self launchvehicle(dir * -30, self.origin + vectorscale((0, 0, 1), 70.0), 0);
    self setanimrestart( % o_drone_tank_missile_fire_sp, 1, 0, 0.4);
  }
}

metalstorm_player_hit_dudes_sound() {
  self endon("exit_vehicle");
  self endon("death");

  while(true) {
    self waittill("touch", enemy);

    if(isDefined(enemy) && isai(enemy)) {
      self playsound("veh_rts_hit_npc");
      wait 0.3;
    }
  }
}
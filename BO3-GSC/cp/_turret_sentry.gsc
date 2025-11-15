/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_turret_sentry.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\math_shared;
#using scripts\shared\statemachine_shared;
#using scripts\shared\system_shared;
#using scripts\shared\turret_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_ai_shared;
#using scripts\shared\vehicle_death_shared;
#using scripts\shared\vehicle_shared;
#namespace sentry_turret;

function autoexec __init__sytem__() {
  system::register("sentry_turret", & __init__, undefined, undefined);
}

function __init__() {
  vehicle::add_main_callback("veh_turret_sentry_machinegun", & function_b2e9d990);
  vehicle::add_main_callback("veh_turret_sentry_sniper", & function_8f042083);
  vehicle::add_main_callback("veh_turret_sentry_grenade", & function_8f042083);
  vehicle::add_main_callback("veh_turret_sentry_guardian", & function_8f042083);
  vehicle::add_main_callback("veh_turret_sentry_emp", & function_c2d2b587);
  level._effect["sentry_turret_damage01"] = "destruct/fx_dest_turret_1";
  level._effect["sentry_turret_damage02"] = "destruct/fx_dest_turret_2";
  level._effect["sentry_turret_damage01"] = "destruct/fx_dest_turret_1";
  level._effect["sentry_turret_damage02"] = "destruct/fx_dest_turret_2";
  level._effect["sentry_turret_death"] = "_t6/destructibles/fx_sentry_turret_death";
  level._effect["sentry_turret_stun"] = "_t6/electrical/fx_elec_sp_emp_stun_sentry_turret";
  level._effect["sentry_turret_stun"] = "_t6/electrical/fx_elec_sp_emp_stun_sentry_turret";
}

function turret_debug_line(start, end, color) {
  if(getdvarint("") != 0) {
    line(start, end, color, 1, 0, 50);
  }
}

function function_ba2c6c94(origin, sector) {
  forward = anglesToForward((0, sector, 0));
  end = origin + (forward * 50);
  passed = bullettracepassed(origin, end, 0, self);
  if(passed) {
    turret_debug_line(origin, end, (0, 1, 0));
  } else {
    turret_debug_line(origin, end, (1, 0, 0));
  }
  return passed;
}

function function_e606dad7() {
  angles = self.angles;
  origin = self.origin;
  eye = self gettagorigin("tag_barrel");
  if(function_ba2c6c94(eye, angles[1])) {
    iprintln("");
  }
  yaw = angleclamp180(angles[1]);
  max_angle = yaw;
  for(sector = 0;
    (sector * 10) <= 360; sector++) {
    if(function_ba2c6c94(eye, yaw + (sector * 10))) {
      max_angle = yaw + (sector * 10);
      continue;
    }
    break;
  }
  min_angle = yaw;
  for(sector = 0;
    (sector * 10) <= 360; sector++) {
    if(function_ba2c6c94(eye, yaw - (sector * 10))) {
      min_angle = yaw - (sector * 10);
      continue;
    }
    break;
  }
  if((max_angle - min_angle) >= 360) {
    var_2421690d = yaw;
    self.scanning_arc = 180;
  } else {
    var_2421690d = angleclamp180((max_angle + min_angle) * 0.5);
    self.scanning_arc = max_angle - ((max_angle + min_angle) * 0.5);
  }
  self.angles = (angles[0], var_2421690d, angles[2]);
}

function function_5f695de4(point, yaw) {
  targetpoint = spawnStruct();
  targetpoint.yaw = yaw;
  targetpoint.origin = point;
  return targetpoint;
}

function get_target_point(origin, angles, yaw_offset) {
  point = origin + ((anglesToForward(angles + (self.default_pitch, yaw_offset, 0))) * 1000);
  return function_5f695de4(point, yaw_offset);
}

function function_1b820c4d() {
  self.targetpoints = [];
  self.var_23b6e300 = 0;
  self.var_b431c4af = 1;
  self.var_5e51c171 = 0;
  self.eyeorigin = self gettagorigin("tag_barrel");
  if(self.scanning_arc < 180) {
    self.targetpoints[self.targetpoints.size] = get_target_point(self.eyeorigin, self.angles, self.scanning_arc);
    self.var_23b6e300 = self.targetpoints.size;
    self.targetpoints[self.targetpoints.size] = get_target_point(self.eyeorigin, self.angles, 0);
    self.targetpoints[self.targetpoints.size] = get_target_point(self.eyeorigin, self.angles, self.scanning_arc * -1);
  } else {
    self.var_23b6e300 = self.targetpoints.size;
    self.targetpoints[self.targetpoints.size] = get_target_point(self.eyeorigin, self.angles, 0);
    self.targetpoints[self.targetpoints.size] = get_target_point(self.eyeorigin, self.angles, 90);
    self.targetpoints[self.targetpoints.size] = get_target_point(self.eyeorigin, self.angles, 180);
    self.targetpoints[self.targetpoints.size] = get_target_point(self.eyeorigin, self.angles, 270);
    self.var_b431c4af = (math::cointoss() ? 1 : -1);
    self.var_5e51c171 = 1;
  }
}

function function_4ac3c3a1(e1, e2, b_lowest_first) {
  if(b_lowest_first) {
    return e1.yaw < e2.yaw;
  }
  return e1.yaw > e2.yaw;
}

function function_c8f2c95d(point) {
  direction = point - self.eyeorigin;
  angles = vectortoangles(direction);
  yaw_delta = angleclamp180(angles[1] - self.angles[1]);
  foreach(targetpoint in self.targetpoints) {
    if(yaw_delta < targetpoint.yaw) {
      if((targetpoint.yaw - yaw_delta) < 5) {
        return;
      }
      continue;
    }
    if((yaw_delta - targetpoint.yaw) < 5) {
      return;
    }
  }
  if(self.var_5e51c171) {
    yaw_delta = absangleclamp360(yaw_delta);
  }
  self.targetpoints[self.targetpoints.size] = function_5f695de4(point, yaw_delta);
  array::merge_sort(self.targetpoints, & function_4ac3c3a1, 1);
}

function function_b2e9d990() {
  self thread function_8f042083();
}

function function_c2d2b587() {
  self thread function_8f042083();
}

function function_e7857e05(e_enemy) {
  var_b9baf316 = 1;
  if(isDefined(e_enemy.archetype) && isDefined(self.var_c35cf4ed)) {
    var_b9baf316 = !isinarray(self.var_c35cf4ed, e_enemy.archetype);
  }
  return var_b9baf316;
}

function function_8f042083() {
  if(!isDefined(self.var_c35cf4ed)) {
    self.var_c35cf4ed = [];
  }
  self thread turret_idle_sound();
  self enableaimassist();
  self.onkill = & function_aa320a88;
  self.scanning_arc = 90;
  self.default_pitch = 0;
  function_e606dad7();
  function_1b820c4d();
  self.state_machine = statemachine::create("brain", self);
  self.state_machine statemachine::add_state("main", undefined, & function_e59668cf, undefined);
  self.state_machine statemachine::add_state("scripted", undefined, & function_4642c69e, undefined);
  self.state_machine statemachine::add_interrupt_connection("main", "scripted", "enter_vehicle");
  self.state_machine statemachine::add_interrupt_connection("scripted", "main", "exit_vehicle");
  self disconnectpaths();
  self thread function_78a2820e();
  self thread sentry_turret_damage();
  self thread turret::track_lens_flare();
  self.overridevehicledamage = & cicturretcallback_vehicledamage;
  if(isDefined(self.script_startstate)) {
    if(self.script_startstate == "off") {
      self function_e6f10cc7(self.angles);
    } else {
      self.state_machine statemachine::set_state(self.script_startstate);
    }
  } else {
    function_62182551();
  }
  self laseron();
  self playSound("mpl_turret_startup");
}

function function_d19a819d() {
  self.state_machine statemachine::set_state("scripted");
}

function function_62182551() {
  self.state_machine statemachine::set_state("main");
}

function function_e59668cf(params) {
  if(isalive(self)) {
    self enableaimassist();
    self thread function_2e229297();
  }
}

function function_e6f10cc7(angles) {
  self.state_machine statemachine::set_state("scripted");
  self vehicle::lights_off();
  self laseroff();
  self vehicle::toggle_sounds(0);
  self vehicle::toggle_exhaust_fx(0);
  if(!isDefined(angles)) {
    angles = self gettagangles("tag_flash");
  }
  target_vec = self.origin + (anglesToForward((0, angles[1], 0)) * 1000);
  target_vec = target_vec + (vectorscale((0, 0, -1), 1700));
  self settargetorigin(target_vec);
  self.off = 1;
  if(!isDefined(self.emped)) {
    self disableaimassist();
  }
}

function function_21af94b3() {
  self playSound("mpl_turret_startup");
  self vehicle::lights_on();
  self enableaimassist();
  self vehicle::toggle_sounds(1);
  self bootup();
  self vehicle::toggle_exhaust_fx(1);
  self.off = undefined;
  self laseron();
  function_62182551();
}

function bootup() {
  for(i = 0; i < 6; i++) {
    wait(0.1);
    vehicle::lights_off();
    wait(0.1);
    vehicle::lights_on();
  }
  if(!isDefined(self.player)) {
    angles = self gettagangles("tag_flash");
    target_vec = self.origin + (anglesToForward((self.default_pitch, angles[1], 0)) * 1000);
    self.turretrotscale = 0.3;
    self settargetorigin(target_vec);
    wait(1);
    self.turretrotscale = 1;
  }
}

function function_2e229297() {
  self endon("death");
  self endon("change_state");
  cant_see_enemy_count = 0;
  wait(0.2);
  origin = self gettagorigin("tag_barrel");
  while(true) {
    if(isDefined(self.enemy) && self vehcansee(self.enemy) && self function_e7857e05(self.enemy)) {
      self.turretrotscale = 1;
      if(cant_see_enemy_count > 0 && isplayer(self.enemy)) {
        sentry_turret_alert_sound();
        wait(0.5);
      }
      cant_see_enemy_count = 0;
      for(i = 0; i < 3; i++) {
        if(isDefined(self.enemy) && isalive(self.enemy) && self vehcansee(self.enemy)) {
          self setturrettargetent(self.enemy);
          wait(0.1);
          self sentry_turret_fire_for_time(randomfloatrange(0.4, 1.5), self.enemy);
        } else {
          self cleartargetentity();
        }
        if(isDefined(self.enemy) && isplayer(self.enemy)) {
          wait(randomfloatrange(0.3, 0.6));
          continue;
        }
        wait(randomfloatrange(0.3, 0.6) * 2);
      }
      if(isDefined(self.enemy) && isalive(self.enemy) && self vehcansee(self.enemy)) {
        if(isplayer(self.enemy)) {
          wait(randomfloatrange(0.5, 1.3));
        } else {
          wait(randomfloatrange(0.5, 1.3) * 2);
        }
      }
    } else {
      self.turretrotscale = 0.5;
      cant_see_enemy_count++;
      wait(1);
      if(cant_see_enemy_count > 1) {
        while(!isDefined(self.enemy) || !self vehcansee(self.enemy)) {
          if(self.turretontarget) {
            self.var_23b6e300 = self.var_23b6e300 + self.var_b431c4af;
            if(self.targetpoints.size <= 1) {
              self.var_23b6e300 = 0;
            } else if(self.var_23b6e300 >= self.targetpoints.size || self.var_23b6e300 < 0) {
              if(!self.var_5e51c171) {
                self.var_23b6e300 = self.var_23b6e300 - self.var_b431c4af;
                self.var_b431c4af = self.var_b431c4af * -1;
                self.var_23b6e300 = self.var_23b6e300 + self.var_b431c4af;
              } else {
                if(self.var_23b6e300 >= self.targetpoints.size) {
                  self.var_23b6e300 = 0;
                } else {
                  self.var_23b6e300 = self.targetpoints.size - 1;
                }
              }
            }
          }
          turret_debug_line(origin, self.targetpoints[self.var_23b6e300].origin, (0, 1, 0));
          self setturrettargetvec(self.targetpoints[self.var_23b6e300].origin);
          wait(0.5);
        }
      } else {
        self cleartargetentity();
      }
    }
    wait(0.5);
  }
}

function function_4642c69e(params) {
  driver = self getseatoccupant(0);
  if(isDefined(driver)) {
    self.turretrotscale = 1;
    self disableaimassist();
    if(driver == level.players[0]) {
      self thread vehicle_death::vehicle_damage_filter("firestorm_turret");
      level.players[0] thread cic_overheat_hud(self);
    }
  }
  self cleartargetentity();
}

function function_e823c700(health_pct) {
  if(issubstr(self.vehicletype, "turret_sentry")) {
    if(health_pct < 0.6) {
      return level._effect["sentry_turret_damage02"];
    }
    return level._effect["sentry_turret_damage01"];
  }
  if(health_pct < 0.6) {
    return level._effect["sentry_turret_damage02"];
  }
  return level._effect["sentry_turret_damage01"];
}

function function_b212223b(effect, tag) {
  if(isDefined(self.damage_fx_ent)) {
    if(self.damage_fx_ent.effect == effect) {
      return;
    }
    self.damage_fx_ent delete();
  }
  if(!isDefined(self gettagangles(tag))) {
    return;
  }
  ent = spawn("script_model", (0, 0, 0));
  ent setModel("tag_origin");
  ent.origin = self gettagorigin(tag);
  ent.angles = self gettagangles(tag);
  ent notsolid();
  ent hide();
  ent linkto(self, tag);
  ent.effect = effect;
  playFXOnTag(effect, ent, "tag_origin");
  self.damage_fx_ent = ent;
}

function sentry_turret_damage() {
  self endon("crash_done");
  while(isDefined(self)) {
    self waittill("damage");
    if(self.health > 0) {
      effect = self function_e823c700(self.health / self.healthdefault);
      tag = "tag_fx";
      function_b212223b(effect, tag);
    }
    wait(0.3);
  }
}

function function_78a2820e() {
  wait(0.1);
  if(!isDefined(self)) {
    return;
  }
  self notify("nodeath_thread");
  self waittill("death", attacker, damagefromunderneath, weapon, point, dir);
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.delete_on_death)) {
    if(isDefined(self.damage_fx_ent)) {
      self.damage_fx_ent delete();
    }
    self delete();
    return;
  }
  self vehicle_death::death_cleanup_level_variables();
  self disableaimassist();
  self cleartargetentity();
  self vehicle::lights_off();
  self laseroff();
  self setturretspinning(0);
  self turret::toggle_lensflare(0);
  self death_fx();
  self thread vehicle_death::death_radius_damage();
  self thread vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
  self vehicle::toggle_sounds(0);
  self thread function_e99c1c2(attacker, dir);
  if(isDefined(self.damage_fx_ent)) {
    self.damage_fx_ent delete();
  }
  self.ignoreme = 1;
  self waittill("crash_done");
  self freevehicle();
}

function death_fx() {
  self vehicle::do_death_fx();
}

function function_e99c1c2(attacker, hitdir) {
  self endon("crash_done");
  self endon("death");
  self playSound("veh_sentry_turret_dmg_hit");
  wait(0.1);
  self.turretrotscale = 0.5;
  tag_angles = self gettagangles("tag_flash");
  target_pos = (self.origin + (anglesToForward((0, tag_angles[1], 0)) * 1000)) + (vectorscale((0, 0, -1), 1800));
  self setturrettargetvec(target_pos);
  wait(4);
  self notify("crash_done");
}

function sentry_turret_fire_for_time(totalfiretime, enemy) {
  self endon("crash_done");
  self endon("death");
  sentry_turret_alert_sound();
  wait(0.1);
  weapon = self seatgetweapon(0);
  firetime = weapon.firetime;
  time = 0;
  is_minigun = 0;
  if(issubstr(weapon.name, "minigun")) {
    is_minigun = 1;
    self setturretspinning(1);
    wait(0.5);
  }
  while(time < totalfiretime) {
    if(isDefined(level.var_a753e7a8)) {
      self[[level.var_a753e7a8]](0, enemy);
    } else {
      self fireweapon(0, enemy);
    }
    wait(firetime);
    time = time + firetime;
  }
  if(is_minigun) {
    self setturretspinning(0);
  }
}

function sentry_turret_alert_sound() {
  self playSound("veh_turret_alert");
}

function function_ebdfd4e4(team) {
  self.team = team;
  if(!isDefined(self.off)) {
    function_f08ad3e6();
  }
}

function function_f08ad3e6() {
  self endon("death");
  self vehicle::lights_off();
  wait(0.1);
  self vehicle::lights_on();
}

function function_791c1a61() {
  self endon("death");
  self notify("emped");
  self endon("emped");
  self.emped = 1;
  playsoundatposition("veh_sentry_turret_emp_down", self.origin);
  self.turretrotscale = 0.2;
  self function_e6f10cc7();
  if(!isDefined(self.stun_fx)) {
    self.stun_fx = spawn("script_model", self.origin);
    self.stun_fx setModel("tag_origin");
    self.stun_fx linkto(self, "tag_fx", (0, 0, 0), (0, 0, 0));
    if(issubstr(self.vehicletype, "turret_sentry")) {
      playFXOnTag(level._effect["sentry_turret_stun"], self.stun_fx, "tag_origin");
    } else {
      playFXOnTag(level._effect["sentry_turret_stun"], self.stun_fx, "tag_origin");
    }
  }
  wait(randomfloatrange(6, 10));
  self.stun_fx delete();
  self.emped = undefined;
  self function_21af94b3();
}

function cicturretcallback_vehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(weapon.isemp && smeansofdeath != "MOD_IMPACT") {
    driver = self getseatoccupant(0);
    if(!isDefined(driver)) {
      self thread function_791c1a61();
    }
  }
  return idamage;
}

function cic_overheat_hud(turret) {
  self endon("exit_vehicle");
  turret endon("turret_exited");
  level endon("player_using_turret");
  heat = 0;
  overheat = 0;
  while(true) {
    if(isDefined(self.viewlockedentity)) {
      old_heat = heat;
      heat = self.viewlockedentity getturretheatvalue(0);
      old_overheat = overheat;
      overheat = self.viewlockedentity isvehicleturretoverheating(0);
      if(old_heat != heat || old_overheat != overheat) {
        luinotifyevent(&"hud_cic_weapon_heat", 2, int(heat), overheat);
      }
    }
    wait(0.05);
  }
}

function function_aa320a88(victim) {
  function_c8f2c95d(victim.origin);
}

function turret_idle_sound() {
  sndloop_ent = spawn("script_origin", self.origin);
  sndloop_ent linkto(self);
  sndloop_ent playLoopSound("veh_turret_idle");
  self thread turret_idle_sound_stop(sndloop_ent);
}

function turret_idle_sound_stop(sndloop_ent) {
  self waittill("death");
  sndloop_ent stoploopsound(0.5);
  wait(2);
  sndloop_ent delete();
}
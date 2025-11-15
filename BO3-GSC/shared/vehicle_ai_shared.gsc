/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\vehicle_ai_shared.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\ai_interface;
#using scripts\shared\array_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\math_shared;
#using scripts\shared\sound_shared;
#using scripts\shared\statemachine_shared;
#using scripts\shared\system_shared;
#using scripts\shared\turret_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_death_shared;
#using scripts\shared\vehicle_shared;
#using_animtree("generic");
#namespace vehicle_ai;

function autoexec __init__sytem__() {
  system::register("vehicle_ai", & __init__, undefined, undefined);
}

function __init__() {}

function registersharedinterfaceattributes(archetype) {
  ai::registermatchedinterface(archetype, "force_high_speed", 0, array(1, 0));
}

function initthreatbias() {
  aiarray = getaiarray();
  foreach(ai in aiarray) {
    if(ai === self) {
      continue;
    }
    if(self.ignorefirefly === 1 && ai.firefly === 1) {
      self setpersonalignore(ai);
    }
    if(self.ignoredecoy === 1 && ai.var_e42818a3 === 1) {
      self setpersonalignore(ai);
    }
  }
}

function entityisarchetype(entity, archetype) {
  if(!isDefined(entity)) {
    return false;
  }
  if(isplayer(entity) && entity.usingvehicle && isDefined(entity.viewlockedentity) && entity.viewlockedentity.archetype === archetype) {
    return true;
  }
  if(isvehicle(entity) && entity.archetype === archetype) {
    return true;
  }
  return false;
}

function getenemytarget() {
  if(isDefined(self.enemy) && self vehcansee(self.enemy)) {
    return self.enemy;
  }
  if(isDefined(self.enemylastseenpos)) {
    return self.enemylastseenpos;
  }
  return undefined;
}

function gettargetpos(target, geteye) {
  pos = undefined;
  if(isDefined(target)) {
    if(isvec(target)) {
      pos = target;
    } else {
      if(isDefined(geteye) && geteye && issentient(target)) {
        pos = target getEye();
      } else {
        if(isentity(target)) {
          pos = target.origin;
        } else if(isDefined(target.origin) && isvec(target.origin)) {
          pos = target.origin;
        }
      }
    }
  }
  return pos;
}

function gettargeteyeoffset(target) {
  offset = (0, 0, 0);
  if(isDefined(target) && issentient(target)) {
    offset = target getEye() - target.origin;
  }
  return offset;
}

function fire_for_time(totalfiretime, turretidx = 0, target, intervalscale = 1) {
  self endon("death");
  self endon("change_state");
  self notify("fire_stop");
  self endon("fire_stop");
  weapon = self seatgetweapon(turretidx);
  assert(isDefined(weapon) && weapon.name != "" && weapon.firetime > 0);
  firetime = weapon.firetime * intervalscale;
  firecount = (int(floor(totalfiretime / firetime))) + 1;
  __fire_for_rounds_internal(firecount, firetime, turretidx, target);
}

function fire_for_rounds(firecount, turretidx, target) {
  self endon("death");
  self endon("fire_stop");
  self endon("change_state");
  if(!isDefined(turretidx)) {
    turretidx = 0;
  }
  weapon = self seatgetweapon(turretidx);
  assert(isDefined(weapon) && weapon.name != "" && weapon.firetime > 0);
  __fire_for_rounds_internal(firecount, weapon.firetime, turretidx, target);
}

function __fire_for_rounds_internal(firecount, fireinterval, turretidx, target) {
  self endon("death");
  self endon("fire_stop");
  self endon("change_state");
  if(isDefined(target) && issentient(target)) {
    target endon("death");
  }
  assert(isDefined(turretidx));
  aifirechance = 1;
  if(isDefined(target) && !isplayer(target) && isai(target) || isDefined(self.fire_half_blanks)) {
    aifirechance = 2;
  }
  counter = 0;
  while(counter < firecount) {
    if(self.avoid_shooting_owner === 1 && self owner_in_line_of_fire()) {
      wait(fireinterval);
      continue;
    }
    if(isDefined(target) && !isvec(target) && isDefined(target.attackeraccuracy) && target.attackeraccuracy == 0) {
      self fireturret(turretidx, 1);
    } else {
      if(aifirechance > 1) {
        self fireturret(turretidx, counter % aifirechance);
      } else {
        self fireturret(turretidx);
      }
    }
    counter++;
    wait(fireinterval);
  }
}

function owner_in_line_of_fire() {
  if(!isDefined(self.owner)) {
    return 0;
  }
  dist_squared_to_owner = distancesquared(self.owner.origin, self.origin);
  line_of_fire_dot = (dist_squared_to_owner < 9216 ? 0.866 : 0.9848);
  gun_angles = self gettagangles((isDefined(self.avoid_shooting_owner_ref_tag) ? self.avoid_shooting_owner_ref_tag : "tag_flash"));
  gun_forward = anglesToForward(gun_angles);
  dot = vectordot(gun_forward, vectornormalize(self.owner.origin - self.origin));
  return dot > line_of_fire_dot;
}

function setturrettarget(target, turretidx = 0, offset = (0, 0, 0)) {
  if(isentity(target)) {
    if(turretidx == 0) {
      self setturrettargetent(target, offset);
    } else {
      self setgunnertargetent(target, offset, turretidx - 1);
    }
  } else {
    if(isvec(target)) {
      origin = target + offset;
      if(turretidx == 0) {
        self setturrettargetvec(target);
      } else {
        self setgunnertargetvec(target, turretidx - 1);
      }
    } else {
      assertmsg("");
    }
  }
}

function fireturret(turretidx, isfake) {
  self fireweapon(turretidx, undefined, undefined, self);
}

function javelin_losetargetatrighttime(target) {
  self endon("death");
  self waittill("weapon_fired", proj);
  if(!isDefined(proj)) {
    return;
  }
  proj endon("death");
  wait(2);
  while(isDefined(target)) {
    if(proj getvelocity()[2] < -150 && distancesquared(proj.origin, target.origin) < (1200 * 1200)) {
      proj missile_settarget(undefined);
      break;
    }
    wait(0.1);
  }
}

function waittill_pathing_done(maxtime = 15) {
  self endon("change_state");
  self util::waittill_any_ex(maxtime, "near_goal", "force_goal", "reached_end_node", "goal", "pathfind_failed", "change_state");
}

function waittill_pathresult(maxtime = 0.5) {
  self endon("change_state");
  result = self util::waittill_any_timeout(maxtime, "pathfind_failed", "pathfind_succeeded", "change_state");
  succeeded = result === "pathfind_succeeded";
  return succeeded;
}

function waittill_asm_terminated() {
  self endon("death");
  self notify("end_asm_terminated_thread");
  self endon("end_asm_terminated_thread");
  self waittill("asm_terminated");
  self notify("asm_complete", "__terminated__");
}

function waittill_asm_timeout(timeout) {
  self endon("death");
  self notify("end_asm_timeout_thread");
  self endon("end_asm_timeout_thread");
  wait(timeout);
  self notify("asm_complete", "__timeout__");
}

function waittill_asm_complete(substate_to_wait, timeout = 10) {
  self endon("death");
  self thread waittill_asm_terminated();
  self thread waittill_asm_timeout(timeout);
  substate = undefined;
  while(!isDefined(substate) || (substate != substate_to_wait && substate != "__terminated__" && substate != "__timeout__")) {
    self waittill("asm_complete", substate);
  }
  self notify("end_asm_terminated_thread");
  self notify("end_asm_timeout_thread");
}

function throw_off_balance(damagetype, hitpoint, hitdirection, hitlocationinfo) {
  if(damagetype == "MOD_EXPLOSIVE" || damagetype == "MOD_GRENADE_SPLASH" || damagetype == "MOD_PROJECTILE_SPLASH") {
    self setvehvelocity(self.velocity + (vectornormalize(hitdirection) * 300));
    ang_vel = self getangularvelocity();
    ang_vel = ang_vel + (randomfloatrange(-300, 300), randomfloatrange(-300, 300), randomfloatrange(-300, 300));
    self setangularvelocity(ang_vel);
  } else {
    ang_vel = self getangularvelocity();
    yaw_vel = randomfloatrange(-320, 320);
    yaw_vel = yaw_vel + (math::sign(yaw_vel) * 150);
    ang_vel = ang_vel + (randomfloatrange(-150, 150), yaw_vel, randomfloatrange(-150, 150));
    self setangularvelocity(ang_vel);
  }
}

function predicted_collision() {
  self endon("crash_done");
  self endon("death");
  while(true) {
    self waittill("veh_predictedcollision", velocity, normal);
    if(normal[2] >= 0.6) {
      self notify("veh_collision", velocity, normal);
    }
  }
}

function collision_fx(normal) {
  tilted = normal[2] < 0.6;
  fx_origin = self.origin - (normal * (tilted ? 28 : 10));
  self playSound("veh_wasp_wall_imp");
}

function nudge_collision() {
  self endon("crash_done");
  self endon("power_off_done");
  self endon("death");
  self notify("end_nudge_collision");
  self endon("end_nudge_collision");
  if(self.notsolid === 1) {
    return;
  }
  while(true) {
    self waittill("veh_collision", velocity, normal);
    ang_vel = self getangularvelocity() * 0.5;
    self setangularvelocity(ang_vel);
    empedoroff = self get_current_state() === "emped" || self get_current_state() === "off";
    if(isalive(self) && (normal[2] < 0.6 || !empedoroff)) {
      self setvehvelocity(self.velocity + (normal * 90));
      self collision_fx(normal);
    } else {
      if(empedoroff) {
        if(isDefined(self.bounced)) {
          self playSound("veh_wasp_wall_imp");
          self setvehvelocity((0, 0, 0));
          self setangularvelocity((0, 0, 0));
          pitch = self.angles[0];
          pitch = math::sign(pitch) * math::clamp(abs(pitch), 10, 15);
          self.angles = (pitch, self.angles[1], self.angles[2]);
          self.bounced = undefined;
          self notify("landed");
          return;
        }
        self.bounced = 1;
        self setvehvelocity(self.velocity + (normal * 30));
        self collision_fx(normal);
      } else {
        impact_vel = abs(vectordot(velocity, normal));
        if(normal[2] < 0.6 && impact_vel < 100) {
          self setvehvelocity(self.velocity + (normal * 90));
          self collision_fx(normal);
        } else {
          self playSound("veh_wasp_ground_death");
          self thread vehicle_death::death_fire_loop_audio();
          self notify("crash_done");
        }
      }
    }
  }
}

function level_out_for_landing() {
  self endon("death");
  self endon("change_state");
  self endon("landed");
  while(true) {
    velocity = self.velocity;
    self.angles = (self.angles[0] * 0.85, self.angles[1], self.angles[2] * 0.85);
    ang_vel = self getangularvelocity() * 0.85;
    self setangularvelocity(ang_vel);
    self setvehvelocity(velocity + (vectorscale((0, 0, -1), 60)));
    wait(0.05);
  }
}

function immolate(attacker) {
  self endon("death");
  self thread burning_thread(attacker, attacker);
}

function burning_thread(attacker, inflictor) {
  self endon("death");
  self notify("end_immolating_thread");
  self endon("end_immolating_thread");
  damagepersecond = self.settings.burn_damagepersecond;
  if(!isDefined(damagepersecond) || damagepersecond <= 0) {
    return;
  }
  secondsperonedamage = 1 / float(damagepersecond);
  if(!isDefined(self.abnormal_status)) {
    self.abnormal_status = spawnStruct();
  }
  if(self.abnormal_status.burning !== 1) {
    self vehicle::toggle_burn_fx(1);
  }
  self.abnormal_status.burning = 1;
  self.abnormal_status.attacker = attacker;
  self.abnormal_status.inflictor = inflictor;
  lastingtime = self.settings.burn_lastingtime;
  if(!isDefined(lastingtime)) {
    lastingtime = 999999;
  }
  starttime = gettime();
  interval = max(secondsperonedamage, 0.5);
  damage = 0;
  while(timesince(starttime) < lastingtime) {
    previoustime = gettime();
    wait(interval);
    damage = damage + (timesince(previoustime) * damagepersecond);
    damageint = int(damage);
    self dodamage(damageint, self.origin, attacker, self, "none", "MOD_BURNED");
    damage = damage - damageint;
  }
  self.abnormal_status.burning = 0;
  self vehicle::toggle_burn_fx(0);
}

function iff_notifymeinnsec(time, note) {
  self endon("death");
  wait(time);
  self notify(note);
}

function iff_override(owner, time = 60) {
  self endon("death");
  self._iffoverride_oldteam = self.team;
  self iff_override_team_switch_behavior(owner.team);
  if(isDefined(self.iff_override_cb)) {
    self[[self.iff_override_cb]](1);
  }
  if(isDefined(self.settings) && (!(isDefined(self.settings.iffshouldrevertteam) && self.settings.iffshouldrevertteam))) {
    return;
  }
  timeout = (isDefined(self.settings) ? self.settings.ifftimetillrevert : time);
  assert(timeout > 10);
  self thread iff_notifymeinnsec(timeout - 10, "iff_override_revert_warn");
  msg = self util::waittill_any_timeout(timeout, "iff_override_reverted", "death");
  if(msg == "timeout") {
    self notify("iff_override_reverted");
  }
  self playSound("gdt_iff_deactivate");
  self iff_override_team_switch_behavior(self._iffoverride_oldteam);
  if(isDefined(self.iff_override_cb)) {
    self[[self.iff_override_cb]](0);
  }
}

function iff_override_team_switch_behavior(team) {
  self endon("death");
  old_ignoreme = self.ignoreme;
  self.ignoreme = 1;
  self start_scripted();
  self vehicle::lights_off();
  wait(0.1);
  wait(1);
  self setteam(team);
  self blink_lights_for_time(1);
  self stop_scripted();
  wait(1);
  self.ignoreme = old_ignoreme;
}

function blink_lights_for_time(time) {
  self endon("death");
  starttime = gettime();
  self vehicle::lights_off();
  wait(0.1);
  while(gettime() < (starttime + (time * 1000))) {
    self vehicle::lights_off();
    wait(0.2);
    self vehicle::lights_on();
    wait(0.2);
  }
  self vehicle::lights_on();
}

function turnoff() {
  self notify("shut_off");
}

function turnon() {
  self notify("start_up");
}

function turnoffalllightsandlaser() {
  self laseroff();
  self vehicle::lights_off();
  self vehicle::toggle_lights_group(1, 0);
  self vehicle::toggle_lights_group(2, 0);
  self vehicle::toggle_lights_group(3, 0);
  self vehicle::toggle_lights_group(4, 0);
  self vehicle::toggle_burn_fx(0);
  self vehicle::toggle_emp_fx(0);
}

function turnoffallambientanims() {
  self vehicle::toggle_ambient_anim_group(1, 0);
  self vehicle::toggle_ambient_anim_group(2, 0);
  self vehicle::toggle_ambient_anim_group(3, 0);
}

function clearalllookingandtargeting() {
  self cleartargetentity();
  self cleargunnertarget(0);
  self cleargunnertarget(1);
  self cleargunnertarget(2);
  self cleargunnertarget(3);
  self clearlookatent();
}

function clearallmovement(zerooutspeed = 0) {
  if(!isairborne(self)) {
    self cancelaimove();
  }
  self clearvehgoalpos();
  self pathvariableoffsetclear();
  self pathfixedoffsetclear();
  if(zerooutspeed === 1) {
    self notify("landed");
    self setvehvelocity((0, 0, 0));
    self setphysacceleration((0, 0, 0));
    self setangularvelocity((0, 0, 0));
  }
}

function shared_callback_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(should_emp(self, weapon, smeansofdeath, einflictor, eattacker)) {
    minempdowntime = 0.8 * self.settings.empdowntime;
    maxempdowntime = 1.2 * self.settings.empdowntime;
    self notify("emped", randomfloatrange(minempdowntime, maxempdowntime), eattacker, einflictor);
  }
  if(should_burn(self, weapon, smeansofdeath, einflictor, eattacker)) {
    self thread burning_thread(eattacker, einflictor);
  }
  if(!isDefined(self.damagelevel)) {
    self.damagelevel = 0;
    self.newdamagelevel = self.damagelevel;
  }
  newdamagelevel = vehicle::should_update_damage_fx_level(self.health, idamage, self.healthdefault);
  if(newdamagelevel > self.damagelevel) {
    self.newdamagelevel = newdamagelevel;
  }
  if(self.newdamagelevel > self.damagelevel) {
    self.damagelevel = self.newdamagelevel;
    if(self.pain_when_damagelevel_change === 1) {
      self notify("pain");
    }
    vehicle::set_damage_fx_level(self.damagelevel);
  }
  return idamage;
}

function should_emp(vehicle, weapon, meansofdeath, einflictor, eattacker) {
  if(!isDefined(vehicle) || meansofdeath === "MOD_IMPACT" || vehicle.disableelectrodamage === 1) {
    return 0;
  }
  if(!(isDefined(weapon) && weapon.isemp || meansofdeath === "MOD_ELECTROCUTED")) {
    return 0;
  }
  causer = (isDefined(eattacker) ? eattacker : einflictor);
  if(!isDefined(causer)) {
    return 1;
  }
  if(isai(causer) && isvehicle(causer)) {
    return 0;
  }
  if(level.teambased) {
    return vehicle.team != causer.team;
  }
  if(isDefined(vehicle.owner)) {
    return vehicle.owner != causer;
  }
  return vehicle != causer;
}

function should_burn(vehicle, weapon, meansofdeath, einflictor, eattacker) {
  if(level.disablevehicleburndamage === 1 || vehicle.disableburndamage === 1) {
    return 0;
  }
  if(!isDefined(vehicle)) {
    return 0;
  }
  if(meansofdeath !== "MOD_BURNED") {
    return 0;
  }
  if(vehicle === einflictor) {
    return 0;
  }
  causer = (isDefined(eattacker) ? eattacker : einflictor);
  if(!isDefined(causer)) {
    return 1;
  }
  if(isai(causer) && isvehicle(causer)) {
    return 0;
  }
  if(level.teambased) {
    return vehicle.team != causer.team;
  }
  if(isDefined(vehicle.owner)) {
    return vehicle.owner != causer;
  }
  return vehicle != causer;
}

function startinitialstate(defaultstate = "combat") {
  params = spawnStruct();
  params.isinitialstate = 1;
  if(isDefined(self.script_startstate)) {
    self set_state(self.script_startstate, params);
  } else {
    self set_state(defaultstate, params);
  }
}

function start_scripted(disable_death_state, no_clear_movement) {
  params = spawnStruct();
  params.no_clear_movement = no_clear_movement;
  self set_state("scripted", params);
  self._no_death_state = disable_death_state;
}

function stop_scripted(statename) {
  if(isalive(self) && is_instate("scripted")) {
    if(isDefined(statename)) {
      self set_state(statename);
    } else {
      self set_state("combat");
    }
  }
}

function set_role(rolename) {
  self.current_role = rolename;
}

function set_state(name, params) {
  self.state_machines[self.current_role] thread statemachine::set_state(name, params);
}

function evaluate_connections(eval_func, params) {
  self.state_machines[self.current_role] statemachine::evaluate_connections(eval_func, params);
}

function get_state_callbacks(statename) {
  rolename = "default";
  if(isDefined(self.current_role)) {
    rolename = self.current_role;
  }
  if(isDefined(self.state_machines[rolename])) {
    return self.state_machines[rolename].states[statename];
  }
  return undefined;
}

function get_state_callbacks_for_role(rolename = "default", statename) {
  if(isDefined(self.state_machines[rolename])) {
    return self.state_machines[rolename].states[statename];
  }
  return undefined;
}

function get_current_state() {
  if(isDefined(self.current_role) && isDefined(self.state_machines[self.current_role].current_state)) {
    return self.state_machines[self.current_role].current_state.name;
  }
  return undefined;
}

function get_previous_state() {
  if(isDefined(self.current_role) && isDefined(self.state_machines[self.current_role].previous_state)) {
    return self.state_machines[self.current_role].previous_state.name;
  }
  return undefined;
}

function get_next_state() {
  if(isDefined(self.current_role) && isDefined(self.state_machines[self.current_role].next_state)) {
    return self.state_machines[self.current_role].next_state.name;
  }
  return undefined;
}

function is_instate(statename) {
  if(isDefined(self.current_role) && isDefined(self.state_machines[self.current_role].current_state)) {
    return self.state_machines[self.current_role].current_state.name === statename;
  }
  return 0;
}

function add_state(name, enter_func, update_func, exit_func) {
  if(isDefined(self.current_role)) {
    statemachine = self.state_machines[self.current_role];
    if(isDefined(statemachine)) {
      state = statemachine statemachine::add_state(name, enter_func, update_func, exit_func);
      return state;
    }
  }
  return undefined;
}

function add_interrupt_connection(from_state_name, to_state_name, on_notify, checkfunc) {
  self.state_machines[self.current_role] statemachine::add_interrupt_connection(from_state_name, to_state_name, on_notify, checkfunc);
}

function add_utility_connection(from_state_name, to_state_name, checkfunc, defaultscore) {
  self.state_machines[self.current_role] statemachine::add_utility_connection(from_state_name, to_state_name, checkfunc, defaultscore);
}

function init_state_machine_for_role(rolename = "default") {
  statemachine = statemachine::create(rolename, self);
  statemachine.isrole = 1;
  if(!isDefined(self.current_role)) {
    set_role(rolename);
  }
  statemachine statemachine::add_state("suspend", undefined, undefined, undefined);
  statemachine statemachine::add_state("death", & defaultstate_death_enter, & defaultstate_death_update, undefined);
  statemachine statemachine::add_state("scripted", & defaultstate_scripted_enter, undefined, & defaultstate_scripted_exit);
  statemachine statemachine::add_state("combat", & defaultstate_combat_enter, undefined, & defaultstate_combat_exit);
  statemachine statemachine::add_state("emped", & defaultstate_emped_enter, & defaultstate_emped_update, & defaultstate_emped_exit, & defaultstate_emped_reenter);
  statemachine statemachine::add_state("surge", & defaultstate_surge_enter, & defaultstate_surge_update, & defaultstate_surge_exit);
  statemachine statemachine::add_state("off", & defaultstate_off_enter, undefined, & defaultstate_off_exit);
  statemachine statemachine::add_state("driving", & defaultstate_driving_enter, undefined, & defaultstate_driving_exit);
  statemachine statemachine::add_state("pain", & defaultstate_pain_enter, undefined, & defaultstate_pain_exit);
  statemachine statemachine::add_interrupt_connection("off", "combat", "start_up");
  statemachine statemachine::add_interrupt_connection("driving", "combat", "exit_vehicle");
  statemachine statemachine::add_utility_connection("emped", "combat");
  statemachine statemachine::add_utility_connection("pain", "combat");
  statemachine statemachine::add_interrupt_connection("combat", "emped", "emped");
  statemachine statemachine::add_interrupt_connection("pain", "emped", "emped");
  statemachine statemachine::add_interrupt_connection("emped", "emped", "emped");
  statemachine statemachine::add_interrupt_connection("combat", "surge", "surge");
  statemachine statemachine::add_interrupt_connection("off", "surge", "surge");
  statemachine statemachine::add_interrupt_connection("pain", "surge", "surge");
  statemachine statemachine::add_interrupt_connection("emped", "surge", "surge");
  statemachine statemachine::add_interrupt_connection("combat", "off", "shut_off");
  statemachine statemachine::add_interrupt_connection("emped", "off", "shut_off");
  statemachine statemachine::add_interrupt_connection("pain", "off", "shut_off");
  statemachine statemachine::add_interrupt_connection("combat", "driving", "enter_vehicle");
  statemachine statemachine::add_interrupt_connection("emped", "driving", "enter_vehicle");
  statemachine statemachine::add_interrupt_connection("off", "driving", "enter_vehicle");
  statemachine statemachine::add_interrupt_connection("pain", "driving", "enter_vehicle");
  statemachine statemachine::add_interrupt_connection("combat", "pain", "pain");
  statemachine statemachine::add_interrupt_connection("emped", "pain", "pain");
  statemachine statemachine::add_interrupt_connection("off", "pain", "pain");
  statemachine statemachine::add_interrupt_connection("driving", "pain", "pain");
  self.overridevehiclekilled = & callback_vehiclekilled;
  self.overridevehicledeathpostgame = & callback_vehiclekilled;
  statemachine thread statemachine::set_state("suspend");
  self thread on_death_cleanup();
  return statemachine;
}

function register_custom_add_state_callback(func) {
  if(!isDefined(level.level_specific_add_state_callbacks)) {
    level.level_specific_add_state_callbacks = [];
  }
  level.level_specific_add_state_callbacks[level.level_specific_add_state_callbacks.size] = func;
}

function call_custom_add_state_callbacks() {
  if(isDefined(level.level_specific_add_state_callbacks)) {
    for(i = 0; i < level.level_specific_add_state_callbacks.size; i++) {
      self[[level.level_specific_add_state_callbacks[i]]]();
    }
  }
}

function callback_vehiclekilled(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  if(isDefined(self._no_death_state) && self._no_death_state) {
    return;
  }
  death_info = spawnStruct();
  death_info.inflictor = einflictor;
  death_info.attacker = eattacker;
  death_info.damage = idamage;
  death_info.meansofdeath = smeansofdeath;
  death_info.weapon = weapon;
  death_info.dir = vdir;
  death_info.hitloc = shitloc;
  death_info.timeoffset = psoffsettime;
  self set_state("death", death_info);
}

function on_death_cleanup() {
  state_machines = self.state_machines;
  self waittill("free_vehicle");
  foreach(statemachine in state_machines) {
    statemachine statemachine::clear();
  }
}

function defaultstate_death_enter(params) {
  self vehicle::toggle_tread_fx(0);
  self vehicle::toggle_exhaust_fx(0);
  self vehicle::toggle_sounds(0);
  self disableaimassist();
  turnoffalllightsandlaser();
  turnoffallambientanims();
  clearalllookingandtargeting();
  clearallmovement();
  self cancelaimove();
  self.takedamage = 0;
  self vehicle_death::death_cleanup_level_variables();
}

function burning_death_fx() {
  if(isDefined(self.settings.burn_death_fx_1) && isDefined(self.settings.burn_death_tag_1)) {
    playFXOnTag(self.settings.burn_death_fx_1, self, self.settings.burn_death_tag_1);
  }
  if(isDefined(self.settings.burn_death_sound_1)) {
    self playSound(self.settings.burn_death_sound_1);
  }
}

function emp_death_fx() {
  if(isDefined(self.settings.emp_death_fx_1) && isDefined(self.settings.emp_death_tag_1)) {
    playFXOnTag(self.settings.emp_death_fx_1, self, self.settings.emp_death_tag_1);
  }
  if(isDefined(self.settings.emp_death_sound_1)) {
    self playSound(self.settings.emp_death_sound_1);
  }
}

function death_radius_damage_special(radiusscale, meansofdamage) {
  self endon("death");
  if(!isDefined(self) || self.abandoned === 1 || self.damage_on_death === 0 || self.radiusdamageradius <= 0) {
    return;
  }
  position = self.origin + vectorscale((0, 0, 1), 15);
  radius = self.radiusdamageradius * radiusscale;
  damagemax = self.radiusdamagemax;
  damagemin = self.radiusdamagemin;
  wait(0.05);
  if(isDefined(self)) {
    self radiusdamage(position, radius, damagemax, damagemin, undefined, meansofdamage);
  }
}

function burning_death(params) {
  self endon("death");
  self burning_death_fx();
  self.skipfriendlyfirecheck = 1;
  self thread death_radius_damage_special(2, "MOD_BURNED");
  self vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
  self vehicle::do_death_dynents(3);
  self vehicle_death::deletewhensafe(10);
}

function emped_death(params) {
  self endon("death");
  self emp_death_fx();
  self.skipfriendlyfirecheck = 1;
  self thread death_radius_damage_special(2, "MOD_ELECTROCUTED");
  self vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
  self vehicle::do_death_dynents(2);
  self vehicle_death::deletewhensafe();
}

function gibbed_death(params) {
  self endon("death");
  self vehicle_death::death_fx();
  self thread vehicle_death::death_radius_damage();
  self vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
  self vehicle::do_death_dynents();
  self vehicle_death::deletewhensafe();
}

function default_death(params) {
  self endon("death");
  self vehicle_death::death_fx();
  self thread vehicle_death::death_radius_damage();
  self vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
  if(isDefined(level.disable_thermal)) {
    [[level.disable_thermal]]();
  }
  waittime = (isDefined(self.waittime_before_delete) ? self.waittime_before_delete : 0);
  owner = self getvehicleowner();
  if(isDefined(owner) && self isremotecontrol()) {
    waittime = max(waittime, 4);
  }
  util::waitfortime(waittime);
  vehicle_death::freewhensafe();
}

function get_death_type(params) {
  if(self.delete_on_death === 1) {
    death_type = "default";
  } else {
    death_type = self.death_type;
  }
  if(!isDefined(death_type)) {
    death_type = params.death_type;
  }
  if(!isDefined(death_type) && isDefined(self.abnormal_status) && self.abnormal_status.burning === 1) {
    death_type = "burning";
  }
  if(!isDefined(death_type) && (isDefined(self.abnormal_status) && self.abnormal_status.emped === 1) || (isDefined(params.weapon) && params.weapon.isemp)) {
    death_type = "emped";
  }
  return death_type;
}

function defaultstate_death_update(params) {
  self endon("death");
  if(isDefined(level.vehicle_destructer_cb)) {
    [[level.vehicle_destructer_cb]](self);
  }
  if(self.delete_on_death === 1) {
    default_death(params);
    vehicle_death::deletewhensafe(0.25);
  } else {
    death_type = (isDefined(get_death_type(params)) ? get_death_type(params) : "default");
    switch (death_type) {
      case "burning": {
        burning_death(params);
        break;
      }
      case "emped": {
        emped_death(params);
        break;
      }
      case "gibbed": {
        gibbed_death(params);
        break;
      }
      default: {
        default_death(params);
        break;
      }
    }
  }
}

function defaultstate_scripted_enter(params) {
  if(params.no_clear_movement !== 1) {
    clearalllookingandtargeting();
    clearallmovement();
    if(hasasm(self)) {
      self asmrequestsubstate("locomotion@movement");
    }
    self resumespeed();
  }
}

function defaultstate_scripted_exit(params) {
  if(params.no_clear_movement !== 1) {
    clearalllookingandtargeting();
    clearallmovement();
  }
}

function defaultstate_combat_enter(params) {}

function defaultstate_combat_exit(params) {}

function defaultstate_emped_enter(params) {
  self vehicle::toggle_tread_fx(0);
  self vehicle::toggle_exhaust_fx(0);
  self vehicle::toggle_sounds(0);
  params.laseron = islaseron(self);
  self laseroff();
  self vehicle::lights_off();
  clearalllookingandtargeting();
  clearallmovement();
  if(isairborne(self)) {
    self setrotorspeed(0);
  }
  if(!isDefined(self.abnormal_status)) {
    self.abnormal_status = spawnStruct();
  }
  self.abnormal_status.emped = 1;
  self.abnormal_status.attacker = params.notify_param[1];
  self.abnormal_status.inflictor = params.notify_param[2];
  self vehicle::toggle_emp_fx(1);
}

function emp_startup_fx() {
  if(isDefined(self.settings.emp_startup_fx_1) && isDefined(self.settings.emp_startup_tag_1)) {
    playFXOnTag(self.settings.emp_startup_fx_1, self, self.settings.emp_startup_tag_1);
  }
}

function defaultstate_emped_update(params) {
  self endon("death");
  self endon("change_state");
  time = params.notify_param[0];
  assert(isDefined(time));
  cooldown("emped_timer", time);
  while(!iscooldownready("emped_timer")) {
    timeleft = max(getcooldownleft("emped_timer"), 0.5);
    wait(timeleft);
  }
  self.abnormal_status.emped = 0;
  self vehicle::toggle_emp_fx(0);
  self emp_startup_fx();
  wait(1);
  self evaluate_connections();
}

function defaultstate_emped_exit(params) {
  self vehicle::toggle_tread_fx(1);
  self vehicle::toggle_exhaust_fx(1);
  self vehicle::toggle_sounds(1);
  if(params.laseron === 1) {
    self laseron();
  }
  self vehicle::lights_on();
  if(isairborne(self)) {
    self setphysacceleration((0, 0, 0));
    self thread nudge_collision();
    self setrotorspeed(1);
  }
}

function defaultstate_emped_reenter(params) {
  return true;
}

function defaultstate_surge_enter(params) {}

function defaultstate_surge_exit(params) {}

function defaultstate_surge_update(params) {
  self endon("change_state");
  self endon("death");
  if(!isDefined(self.abnormal_status)) {
    self.abnormal_status = spawnStruct();
  }
  self.abnormal_status.emped = 1;
  pathfailcount = 0;
  self thread flash_team_switching_lights();
  targets = getaiteamarray("axis", "team3");
  arrayremovevalue(targets, self);
  closest = arraygetclosest(self.origin, targets);
  self setspeed(self.settings.surgespeedmultiplier * self.settings.defaultmovespeed);
  starttime = gettime();
  self thread swap_team_after_time(params.notify_param[0]);
  while((gettime() - starttime) < (self.settings.surgetimetolive * 1000)) {
    if(!isDefined(closest)) {
      self detonate(params.notify_param[0]);
    } else {
      foundpath = 0;
      targetpos = closest.origin + vectorscale((0, 0, 1), 32);
      if(isDefined(targetpos)) {
        queryresult = positionquery_source_navigation(targetpos, 0, 64, 35, 5, self);
        foreach(point in queryresult.data) {
          self.current_pathto_pos = point.origin;
          foundpath = self setvehgoalpos(self.current_pathto_pos, 0, 1);
          if(foundpath) {
            self thread path_update_interrupt(closest, params.notify_param[0]);
            pathfailcount = 0;
            self waittill_pathing_done(self.settings.surgetimetolive);
            try_detonate(closest, params.notify_param[0]);
            break;
          }
          waittillframeend();
        }
      }
      if(!foundpath) {
        pathfailcount++;
        if(pathfailcount > 10) {
          self detonate(params.notify_param[0]);
        }
      }
      wait(0.2);
    }
  }
  if(isalive(self)) {
    self detonate(params.notify_param[0]);
  }
}

function path_update_interrupt(closest, attacker) {
  self endon("death");
  self endon("change_state");
  self endon("near_goal");
  self endon("reached_end_node");
  wait(0.1);
  while(!self try_detonate(closest, attacker)) {
    if(isDefined(self.current_pathto_pos)) {
      if(distance2dsquared(self.current_pathto_pos, self.goalpos) > (self.goalradius * self.goalradius)) {
        wait(0.5);
        self notify("near_goal");
      }
    }
    wait(0.1);
  }
}

function swap_team_after_time(attacker) {
  self endon("death");
  self endon("change_state");
  wait(0.25 * self.settings.surgetimetolive);
  self setteam(attacker.team);
}

function try_detonate(closest, attacker) {
  if(isDefined(closest) && isalive(closest)) {
    if(distancesquared(closest.origin, self.origin) < (80 * 80)) {
      self detonate(attacker);
      return true;
    }
  }
  return false;
}

function detonate(attacker) {
  self setteam(attacker.team);
  self radiusdamage(self.origin + vectorscale((0, 0, 1), 5), self.settings.surgedamageradius, 1500, 1000, attacker, "MOD_EXPLOSIVE");
  if(isalive(self)) {
    self kill();
  }
}

function flash_team_switching_lights() {
  self endon("death");
  self endon("change_state");
  while(true) {
    self vehicle::lights_off();
    wait(0.1);
    self vehicle::lights_on("allies");
    wait(0.1);
    self vehicle::lights_off();
    wait(0.1);
    self vehicle::lights_on("axis");
    wait(0.1);
  }
}

function defaultstate_off_enter(params) {
  self vehicle::toggle_tread_fx(0);
  self vehicle::toggle_exhaust_fx(0);
  self vehicle::toggle_sounds(0);
  self disableaimassist();
  params.laseron = islaseron(self);
  turnoffalllightsandlaser();
  turnoffallambientanims();
  clearalllookingandtargeting();
  clearallmovement();
  if(isDefined(level.disable_thermal)) {
    [[level.disable_thermal]]();
  }
  if(isairborne(self)) {
    if(params.isinitialstate !== 1 && params.no_falling !== 1) {
      self setphysacceleration(vectorscale((0, 0, -1), 300));
      self thread level_out_for_landing();
    }
    self setrotorspeed(0);
  }
}

function defaultstate_off_exit(params) {
  self vehicle::toggle_tread_fx(1);
  self vehicle::toggle_exhaust_fx(1);
  self vehicle::toggle_sounds(1);
  self enableaimassist();
  if(isairborne(self)) {
    self setphysacceleration((0, 0, 0));
    self thread nudge_collision();
    self setrotorspeed(1);
  }
  if(params.laseron === 1) {
    self laseron();
  }
  if(isDefined(level.enable_thermal)) {
    if(self get_next_state() !== "death") {
      [
        [level.enable_thermal]
      ]();
    }
  }
  self vehicle::lights_on();
}

function defaultstate_driving_enter(params) {
  params.driver = self getseatoccupant(0);
  assert(isDefined(params.driver));
  self disableaimassist();
  if(level.playersdrivingvehiclesbecomeinvulnerable) {
    params.driver enableinvulnerability();
    params.driver.ignoreme = 1;
  }
  self.turretrotscale = 1;
  self.team = params.driver.team;
  if(hasasm(self)) {
    self asmrequestsubstate("locomotion@movement");
  }
  self setheliheightcap(1);
  clearalllookingandtargeting();
  clearallmovement();
  self cancelaimove();
  if(isDefined(params.driver) && !isDefined(self.customdamagemonitor)) {
    self thread vehicle::monitor_damage_as_occupant(params.driver);
  }
}

function defaultstate_driving_exit(params) {
  self enableaimassist();
  if(isDefined(params.driver)) {
    params.driver disableinvulnerability();
    params.driver.ignoreme = 0;
  }
  self.turretrotscale = 1;
  self setheliheightcap(0);
  clearalllookingandtargeting();
  clearallmovement();
  if(isDefined(params.driver)) {
    params.driver vehicle::stop_monitor_damage_as_occupant();
  }
}

function defaultstate_pain_enter(params) {
  clearalllookingandtargeting();
  clearallmovement();
}

function defaultstate_pain_exit(params) {
  clearalllookingandtargeting();
  clearallmovement();
}

function canseeenemyfromposition(position, enemy, sight_check_height) {
  sightcheckorigin = position + (0, 0, sight_check_height);
  return sighttracepassed(sightcheckorigin, enemy.origin + vectorscale((0, 0, 1), 30), 0, self);
}

function findnewposition(sight_check_height) {
  if(self.goalforced) {
    goalpos = getclosestpointonnavmesh(self.goalpos, self.radius * 2, self.radius);
    return goalpos;
  }
  point_spacing = 90;
  pixbeginevent("vehicle_ai_shared::FindNewPosition");
  queryresult = positionquery_source_navigation(self.origin, 0, 2000, 300, point_spacing, self, point_spacing * 2);
  pixendevent();
  positionquery_filter_random(queryresult, 0, 50);
  positionquery_filter_distancetogoal(queryresult, self);
  positionquery_filter_outofgoalanchor(queryresult, 50);
  origin = self.goalpos;
  best_point = undefined;
  best_score = -999999;
  if(isDefined(self.enemy)) {
    positionquery_filter_sight(queryresult, self.enemy.origin, self getEye() - self.origin, self, 0, self.enemy);
    self positionquery_filter_engagementdist(queryresult, self.enemy, self.settings.engagementdistmin, self.settings.engagementdistmax);
    if(turret::has_turret(1)) {
      side_turret_enemy = turret::get_target(1);
      if(isDefined(side_turret_enemy) && side_turret_enemy != self.enemy) {
        positionquery_filter_sight(queryresult, side_turret_enemy.origin, (0, 0, sight_check_height), self, 20, self, "sight2");
      }
    }
    if(turret::has_turret(2)) {
      side_turret_enemy = turret::get_target(2);
      if(isDefined(side_turret_enemy) && side_turret_enemy != self.enemy) {
        positionquery_filter_sight(queryresult, side_turret_enemy.origin, (0, 0, sight_check_height), self, 20, self, "sight3");
      }
    }
    foreach(point in queryresult.data) {
      if(!isDefined(point._scoredebug)) {
        point._scoredebug = [];
      }
      point._scoredebug[""] = point.distawayfromengagementarea * -1;
      point.score = point.score + (point.distawayfromengagementarea * -1);
      if(distance2dsquared(self.origin, point.origin) < 28900) {
        if(!isDefined(point._scoredebug)) {
          point._scoredebug = [];
        }
        point._scoredebug[""] = -170;
        point.score = point.score + -170;
      }
      if(isDefined(point.sight) && point.sight) {
        if(!isDefined(point._scoredebug)) {
          point._scoredebug = [];
        }
        point._scoredebug[""] = 250;
        point.score = point.score + 250;
      }
      if(isDefined(point.sight2) && point.sight2) {
        if(!isDefined(point._scoredebug)) {
          point._scoredebug = [];
        }
        point._scoredebug[""] = 150;
        point.score = point.score + 150;
      }
      if(isDefined(point.sight3) && point.sight3) {
        if(!isDefined(point._scoredebug)) {
          point._scoredebug = [];
        }
        point._scoredebug[""] = 150;
        point.score = point.score + 150;
      }
      if(point.score > best_score) {
        best_score = point.score;
        best_point = point;
      }
    }
  } else {
    foreach(point in queryresult.data) {
      if(distance2dsquared(self.origin, point.origin) < 28900) {
        if(!isDefined(point._scoredebug)) {
          point._scoredebug = [];
        }
        point._scoredebug[""] = -100;
        point.score = point.score + -100;
      }
      if(point.score > best_score) {
        best_score = point.score;
        best_point = point;
      }
    }
  }
  self positionquery_debugscores(queryresult);
  if(isDefined(best_point)) {
    origin = best_point.origin;
  }
  return origin + vectorscale((0, 0, 1), 10);
}

function timesince(starttimeinmilliseconds) {
  return (gettime() - starttimeinmilliseconds) * 0.001;
}

function cooldowninit() {
  if(!isDefined(self._cooldown)) {
    self._cooldown = [];
  }
}

function cooldown(name, time_seconds) {
  cooldowninit();
  self._cooldown[name] = gettime() + (time_seconds * 1000);
}

function getcooldowntimeraw(name) {
  cooldowninit();
  if(!isDefined(self._cooldown[name])) {
    self._cooldown[name] = gettime() - 1;
  }
  return self._cooldown[name];
}

function getcooldownleft(name) {
  cooldowninit();
  return (getcooldowntimeraw(name) - gettime()) * 0.001;
}

function iscooldownready(name, timeforward_seconds) {
  cooldowninit();
  if(!isDefined(timeforward_seconds)) {
    timeforward_seconds = 0;
  }
  cooldownreadytime = self._cooldown[name];
  return !isDefined(cooldownreadytime) || (gettime() + (timeforward_seconds * 1000)) > cooldownreadytime;
}

function clearcooldown(name) {
  cooldowninit();
  self._cooldown[name] = gettime() - 1;
}

function addcooldowntime(name, time_seconds) {
  cooldowninit();
  self._cooldown[name] = getcooldowntimeraw(name) + (time_seconds * 1000);
}

function clearallcooldowns() {
  if(isDefined(self._cooldown)) {
    foreach(str_name, cooldown in self._cooldown) {
      self._cooldown[str_name] = gettime() - 1;
    }
  }
}

function positionquery_debugscores(queryresult) {
  if(!(isDefined(getdvarint("hkai_debugPositionQuery")) && getdvarint("hkai_debugPositionQuery"))) {
    return;
  }
  foreach(point in queryresult.data) {
    point debugscore(self);
  }
}

function debugscore(entity) {
  if(!isDefined(self._scoredebug)) {
    return;
  }
  if(!(isDefined(getdvarint("")) && getdvarint(""))) {
    return;
  }
  step = 10;
  count = 1;
  color = (1, 0, 0);
  if(self.score >= 0) {
    color = (0, 1, 0);
  }
  recordstar(self.origin, color);
  record3dtext(("" + self.score) + "", self.origin - (0, 0, step * count), color);
  foreach(name, score in self._scoredebug) {
    count++;
    record3dtext((name + "") + score, self.origin - (0, 0, step * count), color);
  }
}

function _less_than_val(left, right) {
  if(!isDefined(left)) {
    return 0;
  }
  if(!isDefined(right)) {
    return 1;
  }
  return left < right;
}

function _cmp_val(left, right, descending) {
  if(descending) {
    return _less_than_val(right, left);
  }
  return _less_than_val(left, right);
}

function _sort_by_score(left, right, descending) {
  return _cmp_val(left.score, right.score, descending);
}

function positionquery_filter_random(queryresult, min, max) {
  foreach(point in queryresult.data) {
    score = randomfloatrange(min, max);
    if(!isDefined(point._scoredebug)) {
      point._scoredebug = [];
    }
    point._scoredebug[""] = score;
    point.score = point.score + score;
  }
}

function positionquery_postprocess_sortscore(queryresult, descending = 1) {
  sorted = array::merge_sort(queryresult.data, & _sort_by_score, descending);
  queryresult.data = sorted;
}

function positionquery_filter_outofgoalanchor(queryresult, tolerance = 1) {
  foreach(point in queryresult.data) {
    if(point.disttogoal > tolerance) {
      score = -10000 - (point.disttogoal * 10);
      if(!isDefined(point._scoredebug)) {
        point._scoredebug = [];
      }
      point._scoredebug[""] = score;
      point.score = point.score + score;
    }
  }
}

function positionquery_filter_engagementdist(queryresult, enemy, engagementdistancemin, engagementdistancemax) {
  if(!isDefined(enemy)) {
    return;
  }
  engagementdistance = (engagementdistancemin + engagementdistancemax) * 0.5;
  half_engagement_width = abs(engagementdistancemax - engagementdistance);
  enemy_origin = (enemy.origin[0], enemy.origin[1], 0);
  vec_enemy_to_self = vectornormalize((self.origin[0], self.origin[1], 0) - enemy_origin);
  foreach(point in queryresult.data) {
    point.distawayfromengagementarea = 0;
    vec_enemy_to_point = (point.origin[0], point.origin[1], 0) - enemy_origin;
    dist_in_front_of_enemy = vectordot(vec_enemy_to_point, vec_enemy_to_self);
    if(abs(dist_in_front_of_enemy) < engagementdistancemin) {
      dist_in_front_of_enemy = engagementdistancemin * -1;
    }
    dist_away_from_sweet_line = abs(dist_in_front_of_enemy - engagementdistance);
    if(dist_away_from_sweet_line > half_engagement_width) {
      point.distawayfromengagementarea = dist_away_from_sweet_line - half_engagement_width;
    }
    too_far_dist = engagementdistancemax * 1.1;
    too_far_dist_sq = too_far_dist * too_far_dist;
    dist_from_enemy_sq = distance2dsquared(point.origin, enemy_origin);
    if(dist_from_enemy_sq > too_far_dist_sq) {
      ratiosq = dist_from_enemy_sq / too_far_dist_sq;
      dist = ratiosq * too_far_dist;
      dist_outside = dist - too_far_dist;
      if(dist_outside > point.distawayfromengagementarea) {
        point.distawayfromengagementarea = dist_outside;
      }
    }
  }
}

function positionquery_filter_distawayfromtarget(queryresult, targetarray, distance, tooclosepenalty) {
  if(!isDefined(targetarray) || !isarray(targetarray)) {
    return;
  }
  foreach(point in queryresult.data) {
    tooclose = 0;
    foreach(target in targetarray) {
      origin = undefined;
      if(isvec(target)) {
        origin = target;
      } else {
        if(issentient(target) && isalive(target)) {
          origin = target.origin;
        } else if(isentity(target)) {
          origin = target.origin;
        }
      }
      if(isDefined(origin) && distance2dsquared(point.origin, origin) < (distance * distance)) {
        tooclose = 1;
        break;
      }
    }
    if(tooclose) {
      if(!isDefined(point._scoredebug)) {
        point._scoredebug = [];
      }
      point._scoredebug[""] = tooclosepenalty;
      point.score = point.score + tooclosepenalty;
    }
  }
}

function distancepointtoengagementheight(origin, enemy, engagementheightmin, engagementheightmax) {
  if(!isDefined(enemy)) {
    return undefined;
  }
  result = 0;
  engagementheight = 0.5 * (self.settings.engagementheightmin + self.settings.engagementheightmax);
  half_height = abs(engagementheightmax - engagementheight);
  targetheight = enemy.origin[2] + engagementheight;
  distfromengagementheight = abs(origin[2] - targetheight);
  if(distfromengagementheight > half_height) {
    result = distfromengagementheight - half_height;
  }
  return result;
}

function positionquery_filter_engagementheight(queryresult, enemy, engagementheightmin, engagementheightmax) {
  if(!isDefined(enemy)) {
    return;
  }
  engagementheight = 0.5 * (engagementheightmin + engagementheightmax);
  half_height = abs(engagementheightmax - engagementheight);
  foreach(point in queryresult.data) {
    point.distengagementheight = 0;
    targetheight = enemy.origin[2] + engagementheight;
    distfromengagementheight = abs(point.origin[2] - targetheight);
    if(distfromengagementheight > half_height) {
      point.distengagementheight = distfromengagementheight - half_height;
    }
  }
}

function positionquery_postprocess_removeoutofgoalradius(queryresult, tolerance = 1) {
  for(i = 0; i < queryresult.data.size; i++) {
    point = queryresult.data[i];
    if(point.disttogoal > tolerance) {
      arrayremoveindex(queryresult.data, i);
      i--;
    }
  }
}

function updatepersonalthreatbias_attackerlockedontome(var_9f84050f, var_1e08b2fd, var_9c5ca2c, var_cee3c9e9) {
  function_c8b0c8c2(self.locked_on, var_9f84050f, var_1e08b2fd, var_9c5ca2c, var_cee3c9e9);
}

function updatepersonalthreatbias_attackerlockingontome(var_9f84050f, var_1e08b2fd, var_9c5ca2c, var_cee3c9e9) {
  function_c8b0c8c2(self.locking_on, var_9f84050f, var_1e08b2fd, var_9c5ca2c, var_cee3c9e9);
}

function function_c8b0c8c2(client_flags, var_9f84050f, var_1e08b2fd, var_9c5ca2c = 1, var_cee3c9e9 = 1) {
  assert(isDefined(client_flags));
  remaining_flags_to_process = client_flags;
  for(i = 0; remaining_flags_to_process && i < level.players.size; i++) {
    attacker = level.players[i];
    if(isDefined(attacker)) {
      client_flag = 1 << attacker getentitynumber();
      if(client_flag & remaining_flags_to_process) {
        self setpersonalthreatbias(attacker, int(var_9f84050f), var_1e08b2fd);
        if(var_9c5ca2c) {
          self getperfectinfo(attacker, var_cee3c9e9);
        }
        remaining_flags_to_process = remaining_flags_to_process & (~client_flag);
      }
    }
  }
}

function updatepersonalthreatbias_bots(var_9f84050f, var_1e08b2fd) {
  foreach(player in level.players) {
    if(player util::is_bot()) {
      self setpersonalthreatbias(player, int(var_9f84050f), var_1e08b2fd);
    }
  }
}

function target_hijackers() {
  self endon("death");
  while(true) {
    self waittill("ccom_lock_being_targeted", hijackingplayer);
    self getperfectinfo(hijackingplayer, 1);
    if(isplayer(hijackingplayer)) {
      self setpersonalthreatbias(hijackingplayer, 1500, 4);
    }
  }
}
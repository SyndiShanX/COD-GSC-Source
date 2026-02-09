/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_siegebot_nikolai.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\aat_shared;
#using scripts\shared\ai\blackboard_vehicle;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\gameskill_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\statemachine_shared;
#using scripts\shared\system_shared;
#using scripts\shared\turret_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_ai_shared;
#using scripts\shared\vehicle_death_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\vehicles\_siegebot;
#using scripts\shared\weapons\_spike_charge_siegebot;
#using scripts\zm\_util;
#using scripts\zm\_zm_ai_raps;
#using scripts\zm\_zm_elemental_zombies;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\zm_stalingrad_util;
#using_animtree("generic");
#namespace siegebot_nikolai;

function autoexec __init__sytem__() {
  system::register("zm_siegebot_nikolai", &__init__, undefined, undefined);
}

function __init__() {
  vehicle::add_main_callback("siegebot_nikolai", &siegebot_initialize);
  clientfield::register("vehicle", "nikolai_destroyed_r_arm", 12000, 1, "int");
  clientfield::register("vehicle", "nikolai_destroyed_l_arm", 12000, 1, "int");
  clientfield::register("vehicle", "nikolai_destroyed_r_chest", 12000, 1, "int");
  clientfield::register("vehicle", "nikolai_destroyed_l_chest", 12000, 1, "int");
  clientfield::register("vehicle", "nikolai_weakpoint_l_fx", 12000, 1, "int");
  clientfield::register("vehicle", "nikolai_weakpoint_r_fx", 12000, 1, "int");
  clientfield::register("vehicle", "nikolai_gatling_tell", 12000, 1, "int");
  clientfield::register("missile", "harpoon_impact", 12000, 1, "int");
  clientfield::register("vehicle", "play_raps_trail_fx", 12000, 1, "int");
  clientfield::register("vehicle", "raps_landing", 12000, 1, "int");
  level thread aat::register_immunity("zm_aat_blast_furnace", "siegebot", 1, 1, 1);
  level thread aat::register_immunity("zm_aat_dead_wire", "siegebot", 1, 1, 1);
  level thread aat::register_immunity("zm_aat_fire_works", "siegebot", 1, 1, 1);
  level thread aat::register_immunity("zm_aat_thunder_wall", "siegebot", 1, 1, 1);
  level thread aat::register_immunity("zm_aat_turned", "siegebot", 1, 1, 1);
  level thread aat::register_immunity("zm_aat_blast_furnace", "raps", 1, 1, 1);
  level thread aat::register_immunity("zm_aat_dead_wire", "raps", 1, 1, 1);
  level thread aat::register_immunity("zm_aat_fire_works", "raps", 1, 1, 1);
  level thread aat::register_immunity("zm_aat_thunder_wall", "raps", 1, 1, 1);
  level thread aat::register_immunity("zm_aat_turned", "raps", 1, 1, 1);
}

function siegebot_initialize() {
  self flag::init("halt_thread_gun");
  level.raps_spawners = getEntArray("zombie_raps_spawner", "targetname");
  self useanimtree($generic);
  blackboard::createblackboardforentity(self);
  self blackboard::registervehicleblackboardattributes();
  self.health = self.healthdefault;
  self.var_65850094 = [];
  self.var_65850094[1] = 7500;
  self.var_65850094[2] = 7500;
  self.var_65850094[3] = 8000;
  self.var_65850094[4] = 8000;
  self.var_65850094[5] = 11000;
  foreach(player in level.activeplayers) {
    player.var_b3a9099 = 0;
  }
  self.b_override_explosive_damage_cap = 1;
  self.var_a0e2dfff = 1;
  self vehicle::friendly_fire_shield();
  self setneargoalnotifydist(self.radius * 1.2);
  target_set(self, vectorscale((0, 0, 1), 150));
  self.fovcosine = 0;
  self.fovcosinebusy = 0;
  self.maxsightdistsqrd = 10000 * 10000;
  assert(isDefined(self.scriptbundlesettings));
  self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
  self.goalradius = 9999999;
  self.goalheight = 5000;
  self setgoal(self.origin, 0, self.goalradius, self.goalheight);
  self.overridevehicledamage = &function_b9b039e0;
  self pain_toggle(1);
  self initjumpstruct();
  self setgunnerturretontargetrange(0, self.settings.gunner_turret_on_target_range);
  self locomotion_start();
  self.damagelevel = 0;
  self.newdamagelevel = self.damagelevel;
  if(!isDefined(self.height)) {
    self.height = self.radius;
  }
  self.bgbignorefearinheadlights = 1;
  self.nocybercom = 1;
  self.ignorefirefly = 1;
  self.ignoredecoy = 1;
  self.ignoreme = 1;
  self vehicle_ai::initthreatbias();
  defaultrole();
}

function init_clientfields() {
  self vehicle::lights_on();
  self vehicle::toggle_lights_group(1, 1);
  self vehicle::toggle_lights_group(2, 1);
  self vehicle::toggle_lights_group(3, 1);
}

function defaultrole() {
  self vehicle_ai::init_state_machine_for_role();
  self vehicle_ai::get_state_callbacks("combat").update_func = &state_groundcombat_update;
  self vehicle_ai::get_state_callbacks("combat").exit_func = &state_groundcombat_exit;
  self vehicle_ai::get_state_callbacks("pain").enter_func = &pain_enter;
  self vehicle_ai::get_state_callbacks("pain").update_func = &pain_update;
  self vehicle_ai::get_state_callbacks("pain").exit_func = &pain_exit;
  self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
  self vehicle_ai::add_state("special_attack", undefined, undefined, undefined);
  self vehicle_ai::add_state("jump", &state_jump_enter, &state_jump_update, &state_jump_exit);
  vehicle_ai::add_utility_connection("jump", "combat");
  vehicle_ai::startinitialstate("combat");
}

function function_f7035c2f(nikolai_driver) {
  self endon("death");
  nikolai_driver endon("death");
  self.nikolai_driver = nikolai_driver;
  self enablelinkto();
  nikolai_driver.origin = self gettagorigin("tag_driver");
  nikolai_driver.angles = self gettagangles("tag_driver");
  nikolai_driver.targetname = "nikolai_driver";
  nikolai_driver linkto(self, "tag_driver");
  while(true) {
    nikolai_driver scene::play("cin_zm_stalingrad_nikolai_cockpit_drink");
    nikolai_driver thread scene::play("cin_zm_stalingrad_nikolai_cockpit_idle");
    wait(10 + randomfloat(10));
  }
}

function state_death_update(params) {
  self endon("death");
  self endon("nodeath_thread");
  streamermodelhint(self.deathmodel, 6);
  self setturretspinning(0);
  self clean_up_spawned();
  self stopmovementandsetbrake();
  self vehicle::set_damage_fx_level(0);
  self.turretrotscale = 3;
  self setturrettargetrelativeangles((0, 0, 0), 0);
  self setturrettargetrelativeangles((0, 0, 0), 1);
  self setturrettargetrelativeangles((0, 0, 0), 2);
  level flag::set("nikolai_complete");
  self asmrequestsubstate("death@stationary");
  self.nikolai_driver thread scene::play("cin_zm_stalingrad_nikolai_cockpit_death");
  self waittill("model_swap");
  self vehicle_death::death_fx();
  wait(10);
  self vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
  self playSound("veh_quadtank_sparks");
  self vehicle_death::freewhensafe(150);
}

function clean_up_spawned() {
  if(isDefined(self.jump)) {
    self.jump.linkent delete();
  }
}

function pain_toggle(enabled) {
  self._enablepain = enabled;
}

function pain_canenter() {
  state = vehicle_ai::get_current_state();
  return isDefined(state) && state != "pain" && self._enablepain;
}

function pain_enter(params) {
  self stopmovementandsetbrake();
}

function pain_exit(params) {
  self setbrake(0);
}

function pain_update(params) {
  self endon("death");
  if(1 <= self.damagelevel && self.damagelevel <= 4) {
    asmstate = ("damage_" + self.damagelevel) + "@pain";
  } else {
    asmstate = "normal@pain";
  }
  self asmrequestsubstate(asmstate);
  self vehicle_ai::waittill_asm_complete(asmstate, 5);
  previous_state = vehicle_ai::get_previous_state();
  self vehicle_ai::set_state(previous_state);
  self vehicle_ai::evaluate_connections();
}

function jump_to(target) {
  if(self vehicle_ai::get_current_state() === "jump") {
    return false;
  }
  if(!vehicle_ai::iscooldownready("jump_cooldown")) {
    return false;
  }
  if(isvec(target)) {
    self.jump.var_e8ce546f = target;
  } else if(isDefined(target.origin) && isvec(target.origin)) {
    self.jump.var_e8ce546f = target.origin;
  }
  distsqr = distance2dsquared(self.origin, self.jump.var_e8ce546f);
  if(isDefined(self.jump.var_e8ce546f) && (600 * 600) < distsqr && distsqr < (1800 * 1800)) {
    self vehicle_ai::set_state("jump");
    return true;
  }
  return false;
}

function initjumpstruct() {
  if(isDefined(self.jump)) {
    self unlink();
    self.jump.linkent delete();
    self.jump delete();
  }
  self.jump = spawnStruct();
  self.jump.linkent = spawn("script_origin", self.origin);
  self.jump.in_air = 0;
  self.arena_center = struct::get("boss_arena_center").origin;
  assert(isDefined(self.arena_center));
}

function state_jump_enter(params) {
  goal = self.jump.var_e8ce546f;
  trace = physicstrace(goal + vectorscale((0, 0, 1), 500), goal - vectorscale((0, 0, 1), 10000), vectorscale((-1, -1, -1), 10), vectorscale((1, 1, 1), 10), self, 2);
  if(trace["fraction"] < 1) {
    goal = trace["position"];
  }
  self.jump.lowground_history = goal;
  self.jump.goal = goal;
  params.scaleforward = 70;
  params.gravityforce = vectorscale((0, 0, -1), 5);
  params.upbyheight = -5;
  self pain_toggle(0);
  self stopmovementandsetbrake();
}

function state_jump_exit(params) {
  self pain_toggle(1);
}

function state_jump_update(params) {
  self endon("change_state");
  self endon("death");
  goal = self.jump.goal;
  self face_target(goal);
  self.jump.linkent.origin = self.origin;
  self.jump.linkent.angles = self.angles;
  wait(0.05);
  self linkto(self.jump.linkent);
  self.jump.in_air = 1;
  totaldistance = distance2d(goal, self.jump.linkent.origin);
  forward = ((goal - self.jump.linkent.origin) / totaldistance[0], (goal - self.jump.linkent.origin) / totaldistance[1], 0);
  upbydistance = mapfloat(500, 2000, 46, 52, totaldistance);
  antigravitybydistance = mapfloat(500, 2000, 0, 0.5, totaldistance);
  initvelocityup = (0, 0, 1) * (upbydistance + params.upbyheight);
  initvelocityforward = (forward * params.scaleforward) * mapfloat(500, 2000, 0.8, 1, totaldistance);
  velocity = initvelocityup + initvelocityforward;
  self asmrequestsubstate("inair@jump");
  self.jump.debug_state = "engine_startup";
  self util::waittill_notify_or_timeout("start_engine", 0.5);
  self vehicle::impact_fx(self.settings.startupfx1);
  self.jump.debug_state = "leave_ground";
  self util::waittill_notify_or_timeout("start_engine", 1);
  self vehicle::impact_fx(self.settings.takeofffx1);
  params.coptermodel = "land@jump";
  jumpstart = gettime();
  while(true) {
    distancetogoal = distance2d(self.jump.linkent.origin, goal);
    antigravityscaleup = mapfloat(0, 0.5, 0.6, 0, abs(0.5 - (distancetogoal / totaldistance)));
    antigravityscale = mapfloat(self.radius * 1, self.radius * 3, 0, 1, distancetogoal);
    antigravity = (antigravityscale * antigravityscaleup) * (params.gravityforce * -1) + (0, 0, antigravitybydistance);
    velocityforwardscale = mapfloat(self.radius * 1, self.radius * 4, 0.2, 1, distancetogoal);
    velocityforward = initvelocityforward * velocityforwardscale;
    oldverticlespeed = velocity[2];
    velocity = (0, 0, velocity[2]);
    velocity = velocity + ((velocityforward + params.gravityforce) + antigravity);
    if(oldverticlespeed > 0 && velocity[2] <= 0) {
      self asmrequestsubstate("fall@jump");
    }
    if(velocity[2] <= 0 && (self.jump.linkent.origin[2] + velocity[2]) <= goal[2] || vehicle_ai::timesince(jumpstart) > 10) {
      break;
    }
    heightthreshold = goal[2] + 110;
    oldheight = self.jump.linkent.origin[2];
    self.jump.linkent.origin = self.jump.linkent.origin + velocity;
    if(self.jump.linkent.origin[2] < heightthreshold && (oldheight > heightthreshold || (oldverticlespeed > 0 && velocity[2] < 0))) {
      self notify("start_landing");
      if(isDefined(self.enemy)) {
        forward = anglesToForward(self.angles);
        dir = vectornormalize(self.enemy.origin - self.origin);
        dot = vectordot(dir, forward);
        if(dot < -0.7) {
          params.coptermodel = "land_turn@jump";
        }
      }
      self asmrequestsubstate(params.coptermodel);
    }
    wait(0.05);
  }
  self.jump.linkent.origin = (self.jump.linkent.origin[0], self.jump.linkent.origin[1], 0) + (0, 0, goal[2]);
  self notify("land_crush");
  foreach(player in level.players) {
    if(distance2dsquared(self.origin, player.origin) < (200 * 200)) {
      direction = (player.origin - self.origin[0], player.origin - self.origin[1], 0);
      if(abs(direction[0]) < 0.01 && abs(direction[1]) < 0.01) {
        direction = (randomfloatrange(1, 2), randomfloatrange(1, 2), 0);
      }
      direction = vectornormalize(direction);
      strength = 700;
      player setvelocity(player getvelocity() + (direction * strength));
      player dodamage(50, self.origin, self);
    }
  }
  self vehicle::impact_fx(self.settings.landingfx1);
  self stopmovementandsetbrake();
  playrumbleonposition("nikolai_siegebot_land", self.origin);
  wait(0.3);
  self unlink();
  wait(0.05);
  self.jump.in_air = 0;
  self setgoal(self.origin, 0, self.goalradius, self.goalheight);
  self vehicle_ai::waittill_asm_complete(params.coptermodel, 3);
  self vehicle_ai::cooldown("jump_cooldown", 3);
  self notify("jump_finished");
  self locomotion_start();
  self vehicle_ai::evaluate_connections();
}

function function_f9508f9e() {
  self vehicle_ai::clearalllookingandtargeting();
  self setturrettargetrelativeangles((0, 0, 0), 0);
  self setturrettargetrelativeangles((0, 0, 0), 1);
  self setturrettargetrelativeangles((0, 0, 0), 2);
  self setturrettargetrelativeangles((0, 0, 0), 3);
  self setturrettargetrelativeangles((0, 0, 0), 4);
}

function side_step() {
  step_size = 180;
  right_dir = anglestoright(self.angles);
  start = self.origin + vectorscale((0, 0, 1), 10);
  tracedir = right_dir;
  jukestate = "juke_r@movement";
  oppositejukestate = "juke_l@movement";
  if(math::cointoss()) {
    tracedir = tracedir * -1;
    jukestate = "juke_l@movement";
    oppositejukestate = "juke_r@movement";
  }
  trace = physicstrace(start, start + (tracedir * step_size), 0.8 * (self.radius * -1, self.radius * -1, 0), 0.8 * (self.radius, self.radius, self.height), self, 2);
  if(trace["fraction"] < 1) {
    tracedir = tracedir * -1;
    trace = physicstrace(start, start + (tracedir * step_size), 0.8 * (self.radius * -1, self.radius * -1, 0), 0.8 * (self.radius, self.radius, self.height), self, 2);
    jukestate = oppositejukestate;
  }
  if(trace["fraction"] >= 1) {
    self asmrequestsubstate(jukestate);
    self vehicle_ai::waittill_asm_complete(jukestate, 3);
    self locomotion_start();
    return true;
  }
  return false;
}

function state_groundcombat_update(params) {
  self endon("death");
  self endon("change_state");
  self thread attack_thread_gun();
  self thread movement_thread();
  self thread footstep_left_monitor();
  self thread footstep_right_monitor();
  while(true) {
    self vehicle_ai::evaluate_connections();
    wait(1);
  }
}

function footstep_damage(tag_name) {
  origin = self gettagorigin(tag_name);
  self function_75775e52(origin, 80);
}

function footstep_left_monitor() {
  self endon("death");
  self endon("change_state");
  self notify("stop_left_footstep_damage");
  self endon("stop_left_footstep_damage");
  while(true) {
    self waittill("footstep_left_large_theia");
    footstep_damage("tag_leg_left_foot_animate");
  }
}

function footstep_right_monitor() {
  self endon("death");
  self endon("change_state");
  self notify("stop_right_footstep_damage");
  self endon("stop_right_footstep_damage");
  while(true) {
    self waittill("footstep_right_large_theia");
    footstep_damage("tag_leg_right_foot_animate");
  }
}

function movement_thread() {
  self endon("death");
  self endon("change_state");
  self notify("end_movement_thread");
  self endon("end_movement_thread");
  self.current_pathto_pos = self.origin;
  while(true) {
    self setspeed(self.settings.defaultmovespeed);
    e_enemy = self.enemy;
    if(isDefined(self.goalpos) && distancesquared(self.current_pathto_pos, self.goalpos) > (self.radius * 0.8) * (self.radius * 0.8)) {
      self.current_pathto_pos = self.goalpos;
      self setvehgoalpos(self.current_pathto_pos, 0, 1);
      foundpath = self vehicle_ai::waittill_pathresult();
      if(foundpath) {
        if(isDefined(e_enemy)) {
          self setlookatent(e_enemy);
        }
        self setbrake(0);
        locomotion_start();
        self vehicle_ai::waittill_pathing_done();
        self cancelaimove();
        self clearvehgoalpos();
        self setbrake(1);
      }
    }
    wait(0.05);
  }
}

function state_groundcombat_exit(params) {
  self notify("end_attack_thread");
  self notify("end_movement_thread");
  self clearturrettarget();
}

function attack_thread_gun() {
  self endon("death");
  self endon("change_state");
  self endon("end_attack_thread");
  self notify("end_attack_thread_gun");
  self endon("end_attack_thread_gun");
  while(true) {
    e_enemy = self.enemy;
    if(!isDefined(e_enemy) || self.var_a7cd606 === 1) {
      self setturrettargetrelativeangles((0, 0, 0));
      wait(0.4);
      continue;
    }
    self vehicle_ai::setturrettarget(e_enemy, 0);
    self vehicle_ai::setturrettarget(e_enemy, 1);
    var_eb3cc6f2 = gettime();
    while(isDefined(e_enemy) && !self.gunner1ontarget && vehicle_ai::timesince(var_eb3cc6f2) < 2) {
      wait(0.4);
    }
    if(!isDefined(e_enemy)) {
      continue;
    }
    var_9e93cc65 = gettime();
    while(isDefined(e_enemy) && e_enemy === self.enemy && self vehseenrecently(e_enemy, 1) && vehicle_ai::timesince(var_9e93cc65) < 5) {
      if(self flag::get("halt_thread_gun")) {
        break;
      }
      self vehicle_ai::fire_for_time(1 + randomfloat(0.4), 1);
      if(isDefined(e_enemy) && isPlayer(e_enemy)) {
        wait(0.6 + randomfloat(0.2));
      }
      wait(0.1);
    }
    wait(0.1);
  }
}

function locomotion_start() {
  locomotion = "locomotion@movement";
  self asmrequestsubstate(locomotion);
}

function function_7fcc2a80() {
  self notify("near_goal");
}

function _sort_by_distance2d(left, right, point) {
  distancesqrtoleft = distance2dsquared(left.origin, point);
  distancesqrtoright = distance2dsquared(right.origin, point);
  return distancesqrtoleft > distancesqrtoright;
}

function stopmovementandsetbrake() {
  self notify("end_movement_thread");
  self notify("near_goal");
  self cancelaimove();
  self clearvehgoalpos();
  self clearturrettarget();
  self clearlookatent();
  self setbrake(1);
}

function face_target(position, targetanglediff = 30, var_a39fa3d8 = 1) {
  v_to_enemy = (position - self.origin[0], position - self.origin[1], 0);
  v_to_enemy = vectornormalize(v_to_enemy);
  goalangles = vectortoangles(v_to_enemy);
  anglediff = absangleclamp180(self.angles[1] - goalangles[1]);
  if(anglediff <= targetanglediff) {
    return;
  }
  self setlookatorigin(position);
  if(var_a39fa3d8) {
    self setturrettargetvec(position);
  }
  self locomotion_start();
  angleadjustingstart = gettime();
  while(anglediff > targetanglediff && vehicle_ai::timesince(angleadjustingstart) < 4) {
    anglediff = absangleclamp180(self.angles[1] - goalangles[1]);
    wait(0.05);
  }
  self clearvehgoalpos();
  self clearlookatent();
  if(var_a39fa3d8) {
    self clearturrettarget();
  }
  self cancelaimove();
}

function function_75775e52(point, range) {
  a_zombies = getaiarchetypearray("zombie");
  foreach(zombie in a_zombies) {
    if(isalive(zombie) && zombie.knockdown !== 1 && distance2dsquared(point, zombie.origin) < (range * range) && (point[2] - zombie.origin[2]) * (point[2] - zombie.origin[2]) < (100 * 100)) {
      zombie zombie_utility::setup_zombie_knockdown(self);
    }
  }
}

function function_86cc3c11() {
  count = 0;
  for(i = 1; i < 5; i++) {
    if(self.var_65850094[i] <= 0) {
      count++;
    }
  }
  return count;
}

function function_b9b039e0(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(!isPlayer(eattacker)) {
    return false;
  }
  if(level flag::get("world_is_paused")) {
    return false;
  }
  if(smeansofdeath === "MOD_MELEE") {
    return false;
  }
  if(isDefined(weapon)) {
    var_cf9744cb = strtok(weapon.name, "_");
    if(var_cf9744cb[0] === "shotgun") {
      idamage = int(float(idamage) / float(weapon.shotcount));
    }
  }
  idamage = int(float(idamage) / float(level.players.size));
  if(idamage < 1) {
    idamage = 1;
  }
  var_7e43f478 = strtok(partname, "_");
  if(var_7e43f478[1] == "heat" && var_7e43f478[2] == "vent") {
    n_index = int(var_7e43f478[3]);
    if(self.var_65850094[n_index] <= 0) {
      return false;
    }
  } else {
    return false;
  }
  str_partname = partname;
  switch (n_index) {
    case 1: {
      str_partname = "tag_heat_vent_01_d0";
      break;
    }
    case 2: {
      str_partname = "tag_heat_vent_02_d0";
      break;
    }
    case 4: {
      break;
    }
    case 3: {
      break;
    }
    case 5: {
      str_partname = "tag_heat_vent_05_d1";
      break;
    }
    default: {
      return false;
    }
  }
  if(n_index == 5 && function_86cc3c11() < 4) {
    return false;
  }
  var_cf402baf = self.var_65850094[n_index] > 0 && (self.var_65850094[n_index] - idamage) <= 0;
  self.var_65850094[n_index] = self.var_65850094[n_index] - idamage;
  eattacker.var_b3a9099 = eattacker.var_b3a9099 + idamage;
  eattacker show_hit_marker();
  if(var_cf402baf) {
    self notify("nikolai_weakpoint_destroyed");
    if(n_index == 1) {
      self hidepart("tag_heat_vent_01_d0_col");
      self notify("hash_5eb926b6");
    } else if(n_index == 2) {
      self hidepart("tag_heat_vent_02_d0_col");
      self notify("hash_ae5c218");
    }
    mod = "MOD_MELEE";
    if(n_index == 5) {
      self.allowdeath = 1;
      mod = "MOD_IMPACT";
    }
    self finishvehicledamage(einflictor, eattacker, 10000 * 10000, idflags, mod, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, str_partname, 1);
    if(n_index != 5) {
      self function_37a64cff(n_index);
    }
    if(function_86cc3c11() >= 4) {
      self finishvehicledamage(einflictor, eattacker, 4000, idflags, "MOD_IMPACT", weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, "tag_heat_vent_05_d0", 1);
      level notify("nikolai_final_weakpoint_revealed");
    }
  }
  return false;
}

function show_hit_marker() {
  if(isDefined(self) && isDefined(self.hud_damagefeedback)) {
    self.hud_damagefeedback setshader("damage_feedback", 24, 48);
    self.hud_damagefeedback.alpha = 1;
    self.hud_damagefeedback fadeovertime(1);
    self.hud_damagefeedback.alpha = 0;
  }
}

function function_efdfbbf7(var_9d838914, var_e7f2a029) {
  if(var_e7f2a029 == 2) {
    var_e6a3fdd7 = "tag_heat_vent_02_d0_col";
    str_partname = "ai_zm_dlc3_russian_mech_heat_vent_l";
    str_anim_group = 1;
    str_clientfield = "nikolai_weakpoint_l_fx";
  } else {
    var_e6a3fdd7 = "tag_heat_vent_01_d0_col";
    str_partname = "ai_zm_dlc3_russian_mech_heat_vent_r";
    str_anim_group = 2;
    str_clientfield = "nikolai_weakpoint_r_fx";
  }
  if(var_9d838914) {
    self showpart(var_e6a3fdd7);
    self setanim(str_partname);
    self vehicle::toggle_ambient_anim_group(str_anim_group, 1);
    self clientfield::set(str_clientfield, 1);
  } else {
    self hidepart(var_e6a3fdd7);
    self clearanim(str_partname, 0.1);
    self vehicle::toggle_ambient_anim_group(str_anim_group, 0);
    self clientfield::set(str_clientfield, 0);
  }
}

function function_37a64cff(var_ce1b5a05) {
  switch (var_ce1b5a05) {
    case 1: {
      str_clientfield = "nikolai_destroyed_r_arm";
      break;
    }
    case 2: {
      str_clientfield = "nikolai_destroyed_l_arm";
      break;
    }
    case 3: {
      str_clientfield = "nikolai_destroyed_r_chest";
      break;
    }
    case 4: {
      str_clientfield = "nikolai_destroyed_l_chest";
      break;
    }
  }
  self clientfield::set(str_clientfield, 1);
}

function function_a3258c2a(var_f8b7c9a1) {
  if(!isalive(self)) {
    return false;
  }
  self endon("death");
  self vehicle_ai::set_state("special_attack");
  self endon("change_state");
  foreach(player in level.activeplayers) {
    self getperfectinfo(player, 0);
  }
  self locomotion_start();
  self clientfield::set("nikolai_gatling_tell", 1);
  if(isDefined(self.enemy)) {
    self vehicle_ai::setturrettarget(self.enemy, 0);
    self vehicle_ai::setturrettarget(self.enemy, 1);
  }
  if(self.var_65850094[2] > 0) {
    self function_efdfbbf7(1, 2);
  }
  var_a3f49a09 = 137.5;
  weapon = self seatgetweapon(1);
  fireinterval = weapon.firetime * 0.5;
  var_9e93cc65 = gettime();
  while(isDefined(self.enemy) && vehicle_ai::timesince(var_9e93cc65) < var_f8b7c9a1) {
    self setlookatent(self.enemy);
    self vehicle_ai::setturrettarget(self.enemy, 0);
    angleoffset = (anglesToForward((0, randomint(100) * var_a3f49a09, 0))) * 100;
    var_8a7bdf21 = self.enemy getvelocity() * -0.3;
    targetposition = (self.enemy.origin + angleoffset) + var_8a7bdf21;
    self vehicle_ai::setturrettarget(targetposition, 1);
    wait(fireinterval);
    self fireweapon(1, undefined, angleoffset + var_8a7bdf21, self);
  }
  self notify("fire_stop");
  self clientfield::set("nikolai_gatling_tell", 0);
  if(self.var_65850094[2] > 0) {
    self function_efdfbbf7(0, 2);
  } else {
    self clientfield::set("nikolai_weakpoint_l_fx", 0);
  }
  self vehicle_ai::set_state("combat");
}

function function_59fe8c9c(targetposition) {
  if(!isalive(self)) {
    return false;
  }
  self endon("death");
  self vehicle_ai::set_state("special_attack");
  self endon("change_state");
  self setturrettargetrelativeangles((0, 0, 0), 0);
  self setturrettargetrelativeangles((0, 0, 0), 1);
  self setturrettargetrelativeangles((0, 0, 0), 2);
  self face_target(targetposition, 30);
  self notify("hash_c72aec1e");
  if(self.var_65850094[1] > 0) {
    self function_efdfbbf7(1, 1);
  }
  if(self.var_65850094[2] > 0) {
    self function_efdfbbf7(1, 2);
  }
  self asmrequestsubstate("javelin@stationary");
  var_a3f49a09 = 137.5;
  for(i = 0; i < 6; i++) {
    if((i % 2) == 0) {
      self util::waittill_notify_or_timeout("fire_raps", 0.5);
    }
    ai_raps = undefined;
    while(!isDefined(ai_raps)) {
      if(level flag::get("world_is_paused")) {
        level flag::wait_till_clear("world_is_paused");
      }
      spawntag = self gettagorigin("tag_flash");
      tagangles = self gettagangles("tag_flash");
      var_5d7a8c53 = anglestoup(tagangles);
      ai_raps = spawnvehicle("spawner_zm_dlc3_vehicle_raps_nikolai", spawntag, self.angles);
      if(!isDefined(ai_raps)) {
        wait(0.1);
      }
    }
    ai_raps.exclude_cleanup_adding_to_total = 1;
    ai_raps.b_ignore_cleanup = 1;
    ai_raps.no_eye_glow = 1;
    playFXOnTag("dlc3/stalingrad/fx_mech_wpn_raps_launcher_muz", self, "tag_flash");
    ai_raps hide();
    ai_raps.takedamage = 0;
    wait(0.05);
    ai_raps.origin = spawntag + (var_5d7a8c53 * 40);
    wait(0.05);
    ai_raps show();
    wait(0.05);
    if(!isDefined(level.var_c3c3ffc5)) {
      level.var_c3c3ffc5 = [];
    } else if(!isarray(level.var_c3c3ffc5)) {
      level.var_c3c3ffc5 = array(level.var_c3c3ffc5);
    }
    level.var_c3c3ffc5[level.var_c3c3ffc5.size] = ai_raps;
    level.var_6d27427c++;
    ai_raps zm_stalingrad_util::function_d48ad6b4();
    ai_raps thread function_6deb3e8d();
    ai_raps.takedamage = 1;
    ai_raps thread function_3b145bbb();
    offset = anglesToForward((0, i * var_a3f49a09, 0));
    launchforce = (var_5d7a8c53 * 300) + (offset * 40);
    ai_raps thread function_853d3b2b(targetposition + (offset * 60), launchforce);
    wait(0.1);
  }
  if(self.var_65850094[1] > 0) {
    self function_efdfbbf7(0, 1);
  } else {
    self clientfield::set("nikolai_weakpoint_r_fx", 0);
  }
  if(self.var_65850094[2] > 0) {
    self function_efdfbbf7(0, 2);
  } else {
    self clientfield::set("nikolai_weakpoint_l_fx", 0);
  }
  self vehicle_ai::waittill_asm_complete("javelin@stationary", 4);
  self vehicle_ai::set_state("combat");
}

function function_853d3b2b(var_ff72f147, launchforce) {
  self endon("death");
  self clientfield::set("play_raps_trail_fx", 1);
  self vehicle_ai::set_state("scripted");
  self vehicle::toggle_sounds(0);
  var_87f1eda4 = gettime();
  self launchvehicle(launchforce);
  wait(0.5);
  self applyballistictarget(var_ff72f147);
  self show();
  while(!isDefined(getclosestpointonnavmesh(self.origin, 200)) && vehicle_ai::timesince(var_87f1eda4) < 4) {
    wait(0.1);
  }
  self clientfield::set("play_raps_trail_fx", 0);
  self vehicle_ai::set_state("combat");
  self util::waittill_notify_or_timeout("veh_collision", 1);
  self vehicle::toggle_sounds(1);
  self clientfield::set("raps_landing", 1);
  self.test_failed_path = 1;
  self thread function_902a2c47();
}

function function_902a2c47() {
  wait(10);
  while(level flag::get("world_is_paused")) {
    wait(1);
  }
  if(isDefined(self) && (!(isDefined(self zm_zonemgr::entity_in_zone("boss_arena_zone", 0)) && self zm_zonemgr::entity_in_zone("boss_arena_zone", 0)))) {
    self kill();
  }
}

function function_6deb3e8d() {
  self endon("death");
  while(isalive(self)) {
    self waittill("veh_predictedcollision", otherent);
    if(isalive(otherent) && otherent.archetype === "zombie" && otherent.knockdown !== 1) {
      otherent zombie_utility::setup_zombie_knockdown(self);
    }
  }
}

function function_3b145bbb() {
  self waittill("death");
  level.var_6d27427c--;
  if(level.var_6d27427c < 1) {
    level.var_5fe02c5a = undefined;
  }
}

function pin_spike_to_ground(spike, targetorigin) {
  spike endon("death");
  targetdist = distance2d(spike.origin, targetorigin) - (400 + randomfloat(60));
  startorigin = spike.origin;
  while(distance2dsquared(spike.origin, startorigin) < (targetdist * 0.4) * (targetdist * 0.4)) {
    wait(0.05);
  }
  var_5f13f183 = 1;
  maxpitch = 10;
  while(distance2dsquared(spike.origin, startorigin) < (max(targetdist * targetdist, 150 * 150))) {
    pitch = angleclamp180(spike.angles[0]);
    if(pitch < maxpitch) {
      pitch = pitch + (min(var_5f13f183, maxpitch - pitch));
      spike.angles = (pitch, spike.angles[1], spike.angles[2]);
    }
    wait(0.05);
  }
  var_5f13f183 = 16;
  maxpitch = 76;
  while(spike.angles[0] < maxpitch) {
    pitch = angleclamp180(spike.angles[0]);
    pitch = pitch + var_5f13f183;
    if(pitch > maxpitch) {
      pitch = randomfloatrange(maxpitch, min(pitch, 90));
    }
    spike.angles = (pitch, spike.angles[1], spike.angles[2]);
    wait(0.05);
  }
}

function function_db9ecada() {
  self notify("hash_f7204730");
  self endon("hash_f7204730");
  self endon("change_state");
  while(true) {
    self waittill("grenade_stuck", var_8e857deb, origin, normal);
    var_8e857deb thread function_d7ef4d80();
    self function_75775e52(var_8e857deb.origin, 120);
    var_8e857deb clientfield::set("harpoon_impact", 1);
  }
}

function function_d7ef4d80() {
  self endon("death");
  while(true) {
    a_ai_zombies = getaiarchetypearray("zombie");
    a_ai_zombies = arraysortclosest(a_ai_zombies, self.origin, undefined, undefined, 200);
    foreach(ai_zombie in a_ai_zombies) {
      if(!isDefined(ai_zombie.is_elemental_zombie)) {
        ai_zombie.var_bb98125f = 1;
        ai_zombie thread zm_elemental_zombie::function_1b1bb1b();
      }
    }
    wait(0.25);
  }
}

function function_dfc5ede1(targetent) {
  if(!isalive(self)) {
    return false;
  }
  self endon("death");
  assert(isalive(targetent));
  target = targetent.origin;
  vectotarget = (target - self.origin[0], target - self.origin[1], 0);
  if(lengthsquared(vectotarget) < (0.01 * 0.01)) {
    return false;
  }
  self vehicle_ai::set_state("special_attack");
  self endon("change_state");
  spikecoverradius = 600;
  randomscale = 40;
  self setturrettargetrelativeangles((0, 0, 0), 0);
  self setturrettargetrelativeangles((0, 0, 0), 1);
  self setturrettargetrelativeangles((0, 0, 0), 2);
  self vehicle_ai::setturrettarget(targetent, 0);
  self face_target(target, 30, 0);
  self notify("hash_2eb273f0", target);
  if(self.var_65850094[1] > 0) {
    self function_efdfbbf7(1, 1);
  }
  self asmrequestsubstate("arm_rocket@stationary");
  self thread function_db9ecada();
  for(i = 0; i < 3; i++) {
    self waittill("fire_harpoon");
    spike = self fireweapon(2);
    self clearturrettarget();
    if(isDefined(spike)) {
      self thread pin_spike_to_ground(spike, target);
    }
  }
  self cleargunnertarget(1);
  self clearturrettarget();
  if(self.var_65850094[1] > 0) {
    self function_efdfbbf7(0, 1);
  } else {
    self clientfield::set("nikolai_weakpoint_r_fx", 0);
  }
  self vehicle_ai::waittill_asm_complete("arm_rocket@stationary", 2);
  self vehicle_ai::set_state("combat");
}

function is_valid_target(target) {
  if(isDefined(target.ignoreme) && target.ignoreme || target.health <= 0) {
    return false;
  }
  if(isPlayer(target) && target laststand::player_is_in_laststand()) {
    return false;
  }
  if(issentient(target) && (target isnotarget() || !isalive(target))) {
    return false;
  }
  return true;
}
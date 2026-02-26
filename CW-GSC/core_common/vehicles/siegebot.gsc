/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\vehicles\siegebot.gsc
***********************************************/

#using scripts\core_common\ai\blackboard_vehicle;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_death_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\weapons\heatseekingmissile;
#namespace siegebot;

function private autoexec __init__system__() {
  system::register(#"siegebot", &function_5de06a3f, undefined, undefined, undefined);
}

function function_5de06a3f() {
  level.var_7fcdba66 = 1;
  vehicle::add_main_callback("siegebot", &siegebot_initialize);
  vehicle::add_main_callback("xbot", &siegebot_initialize);

  if(!isDefined(level.var_3d1b6323)) {
    level.var_3d1b6323 = new throttle();
    [[level.var_3d1b6323]] - > initialize(1, float(function_60d95f53()) / 1000);
  }
}

function siegebot_initialize() {
  self useanimtree("generic");
  blackboard::createblackboardforentity(self);
  self blackboard::registervehicleblackboardattributes();
  self.health = self.healthdefault;
  self vehicle::friendly_fire_shield();
  vehicle::make_targetable(self, (0, 0, 0));
  self enableaimassist();
  self setneargoalnotifydist(40);
  self.fovcosine = 0.5;
  self.fovcosinebusy = 0.5;
  self.maxsightdistsqrd = sqr(10000);
  assert(isDefined(self.scriptbundlesettings));
  self.settings = getscriptbundle(self.scriptbundlesettings);
  self.goalradius = 9999999;
  self.goalheight = 5000;
  vehicle::function_ea56e00e(self);
  self.overridevehicledamage = &siegebot_callback_damage;
  self turretsetontargettolerance(0, 5);

  if(self.scriptvehicletype == # "xbot") {
    self.destructible_event_handler = &xbot_destructible_event_handler;
    self.isxbot = 1;
  }

  self siegebot_update_difficulty();
  self turretsetontargettolerance(0, self.settings.gunner_turret_on_target_range);
  self asmrequestsubstate(#"locomotion@movement");

  if(self.vehicletype === "spawner_enemy_boss_siegebot_zombietron") {
    self asmsetanimationrate(0.5);
    self hidepart("tag_turret_canopy_animate");
    self hidepart("tag_turret_panel_01_d0");
    self hidepart("tag_turret_panel_02_d0");
    self hidepart("tag_turret_panel_03_d0");
    self hidepart("tag_turret_panel_04_d0");
    self hidepart("tag_turret_panel_05_d0");
  } else if(self.vehicletype == # "hash_962ecc6fc2eca01") {
    self asmsetanimationrate(2);
  }

  self initjumpstruct();

  if(isDefined(level.vehicle_initializer_cb)) {
    [[level.vehicle_initializer_cb]](self);
  }

  self.airfollowconfig = spawnStruct();
  self.airfollowconfig.distance = 130;
  self.airfollowconfig.numberofpoints = 8;
  self.airfollowconfig.pitchrange = 90;
  self.airfollowconfig.tag = "tag_turret_null";
  self.disableburndamage = 1;
  self thread vehicle_ai::target_hijackers();
  self thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile(undefined, "crashing", "death");
  defaultrole();
}

function xbot_destructible_event_handler(event, param1, param2, param3, param4) {
  if(param3 == "broken") {
    message = param4;

    if(message == "left_arm_broken") {
      self.left_arm_disabled = 1;
      return;
    }

    if(message == "right_arm_broken") {
      self.right_arm_disabled = 1;
      return;
    }

    if(message == "javelin_broken") {
      self.javelin_disabled = 1;
    }
  }
}

function siegebot_update_difficulty() {
  value = 1;

  if(isDefined(level.var_4b2a137e)) {
    value = [[level.var_4b2a137e]]();
  }

  scale_up = mapfloat(0, 9, 0.8, 2, value);
  scale_down = mapfloat(0, 9, 1, 0.5, value);
  self.difficulty_scale_up = scale_up;
  self.difficulty_scale_down = scale_down;
}

function defaultrole() {
  self vehicle_ai::init_state_machine_for_role("default");
  self vehicle_ai::get_state_callbacks("combat").update_func = &state_combat_update;
  self vehicle_ai::get_state_callbacks("combat").exit_func = &state_combat_exit;
  self vehicle_ai::get_state_callbacks("driving").update_func = &siegebot_driving;
  self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
  self vehicle_ai::get_state_callbacks("pain").update_func = &pain_update;
  self vehicle_ai::get_state_callbacks("emped").enter_func = &emped_enter;
  self vehicle_ai::get_state_callbacks("emped").update_func = &emped_update;
  self vehicle_ai::get_state_callbacks("emped").exit_func = &emped_exit;
  self vehicle_ai::get_state_callbacks("emped").reenter_func = &emped_reenter;
  self vehicle_ai::add_state("jump", &state_jump_enter, &state_jump_update, &state_jump_exit);
  vehicle_ai::add_utility_connection("combat", "jump", &state_jump_can_enter);
  vehicle_ai::add_utility_connection("jump", "combat");
  vehicle_ai::startinitialstate("combat");
}

function state_death_update(params) {
  self endon(#"death", #"nodeath_thread");
  streamermodelhint(self.deathmodel, 6);
  death_type = vehicle_ai::get_death_type(params);

  if(!isDefined(death_type)) {
    params.death_type = "gibbed";
    death_type = params.death_type;
  }

  self clean_up_spawned();
  self setturretspinning(0);
  self stopmovementandsetbrake();
  badplace_box("", 0, self.origin, 50, "all");
  self vehicle::set_damage_fx_level(0);
  self playSound(#"hash_69ea4c3143042b15");

  if(self.vehicletype === "spawner_enemy_boss_siegebot_zombietron") {
    self asmsetanimationrate(1);
  }

  self.turretrotscale = 3;
  self turretsettargetangles(0, (0, 0, 0));
  self turretsettargetangles(1, (0, 0, 0));
  self turretsettargetangles(2, (0, 0, 0));
  self asmrequestsubstate(#"death@stationary");
  self waittill(#"model_swap");
  self vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
  self vehicle::do_death_dynents();
  self vehicle_death::death_radius_damage();
  self waittilltimeout(3, #"bodyfall large");
  self radiusdamage(self.origin + (0, 0, 10), self.radius * 0.8, 150, 60, self, "MOD_CRUSH");
  vehicle_ai::waittill_asm_complete("death@stationary", 3);
  self disconnectpaths(1);
  self thread vehicle_death::cleanup();
  self vehicle_death::freewhensafe();
}

function siegebot_driving(params) {
  self thread siegebot_player_fireupdate();
  self thread siegebot_kill_on_tilting();
  self turretcleartarget(0);
  self cancelaimove();
  self function_d4c687c9();
}

function siegebot_kill_on_tilting() {
  self endon(#"death", #"exit_vehicle");
  tilecount = 0;

  while(true) {
    selfup = anglestoup(self.angles);
    worldup = (0, 0, 1);

    if(vectordot(selfup, worldup) < 0.64) {
      tilecount += 1;
    } else {
      tilecount = 0;
    }

    if(tilecount > 20) {
      driver = self getseatoccupant(0);

      if(isDefined(driver)) {
        self usevehicle(driver, 0);
        self notify(#"flipped");
        util::wait_network_frame();
      }

      self kill(self.origin);
    }

    waitframe(1);
  }
}

function siegebot_player_fireupdate() {
  self endon(#"death", #"exit_vehicle");
  weapon = self seatgetweapon(2);
  firetime = weapon.firetime;
  driver = self getseatoccupant(0);
  self thread siegebot_player_aimupdate();

  while(true) {
    if(driver vehicleattackButtonPressed()) {
      if(isDefined(self.var_8c05c51a)) {
        [[self.var_8c05c51a]]();
      } else {
        self fireweapon(2);
        wait firetime;
      }

      continue;
    }

    waitframe(1);
  }
}

function siegebot_player_aimupdate() {
  self endon(#"death", #"exit_vehicle");

  while(true) {
    target = self turretgettarget(1);

    if(isDefined(target)) {
      self turretsettarget(2, target);
    }

    waitframe(1);
  }
}

function emped_enter(params) {
  if(!isDefined(self.abnormal_status)) {
    self.abnormal_status = spawnStruct();
  }

  self.abnormal_status.emped = 1;
  self.abnormal_status.attacker = params.param1;
  self.abnormal_status.inflictor = params.param2;
  self vehicle::toggle_emp_fx(1);
}

function emped_update(params) {
  self endon(#"death", #"change_state");
  self stopmovementandsetbrake();

  if(self.vehicletype === "spawner_enemy_boss_siegebot_zombietron") {
    self asmsetanimationrate(1);
  }

  asmstate = "damage_2@pain";
  self asmrequestsubstate(asmstate);
  self vehicle_ai::waittill_asm_complete(asmstate, 3);
  self setbrake(0);
  self vehicle_ai::evaluate_connections();
}

function emped_exit(params) {}

function emped_reenter(params) {
  return false;
}

function pain_toggle(enabled) {
  self._enablepain = enabled;
}

function pain_update(params) {
  self endon(#"death", #"change_state");
  self stopmovementandsetbrake();

  if(self.vehicletype === "spawner_enemy_boss_siegebot_zombietron") {
    self asmsetanimationrate(1);
  }

  if(self.newdamagelevel == 3) {
    asmstate = "damage_2@pain";
  } else {
    asmstate = "damage_1@pain";
  }

  self asmrequestsubstate(asmstate);
  self vehicle_ai::waittill_asm_complete(asmstate, 1.5);
  self setbrake(0);
  self vehicle_ai::evaluate_connections();
}

function clean_up_spawned() {
  if(isDefined(self.jump) && isDefined(self.jump.linkent)) {
    self.jump.linkent delete();
  }
}

function clean_up_spawnedondeath(enttowatch) {
  self endon(#"death");
  enttowatch waittill(#"death");
  self delete();
}

function initjumpstruct() {
  if(isDefined(self.jump)) {
    self unlink();
    self.jump.linkent delete();
    self.jump delete();
  }

  self.jump = spawnStruct();
  self.jump.linkent = spawn("script_origin", self.origin);
  self.jump.linkent thread clean_up_spawnedondeath(self);
  self.jump.in_air = 0;
  self.jump.highgrounds = struct::get_array("balcony_point");
  self.jump.groundpoints = struct::get_array("ground_point");
}

function state_jump_can_enter(from_state, to_state, connection) {
  if(is_true(self.nojumping)) {
    return false;
  }

  return self.vehicletype === "spawner_enemy_boss_siegebot_zombietron";
}

function state_jump_enter(params) {
  goal = params.jumpgoal;
  trace = physicstrace(goal + (0, 0, 500), goal - (0, 0, 10000), (-10, -10, -10), (10, 10, 10), self, 2);

  if(false) {
    debugstar(goal, 60000, (0, 1, 0));

    debugstar(trace[#"position"], 60000, (0, 1, 0));

    line(goal, trace[#"position"], (0, 1, 0), 1, 0, 60000);
  }

  if(trace[#"fraction"] < 1) {
    goal = trace[#"position"];
  }

  self.jump.goal = goal;
  params.scaleforward = 40;
  params.gravityforce = (0, 0, -6);
  params.upbyheight = 50;
  params.landingstate = "land@jump";
  self pain_toggle(0);
  self stopmovementandsetbrake();
}

function state_jump_update(params) {
  self endon(#"change_state", #"death");
  goal = self.jump.goal;
  self face_target(goal);
  self.jump.linkent.origin = self.origin;
  self.jump.linkent.angles = self.angles;
  waitframe(1);
  self linkto(self.jump.linkent);
  self.jump.in_air = 1;

  if(false) {
    debugstar(goal, 60000, (0, 1, 0));

    debugstar(goal + (0, 0, 100), 60000, (0, 1, 0));

    line(goal, goal + (0, 0, 100), (0, 1, 0), 1, 0, 60000);
  }

  totaldistance = distance2d(goal, self.jump.linkent.origin);
  forward = (((goal - self.jump.linkent.origin) / totaldistance)[0], ((goal - self.jump.linkent.origin) / totaldistance)[1], 0);
  upbydistance = mapfloat(500, 2000, 46, 52, totaldistance);
  antigravitybydistance = 0;
  initvelocityup = (0, 0, 1) * (upbydistance + params.upbyheight);
  initvelocityforward = forward * params.scaleforward * mapfloat(500, 2000, 0.8, 1, totaldistance);
  velocity = initvelocityup + initvelocityforward;

  if(self.vehicletype === "spawner_enemy_boss_siegebot_zombietron") {
    self asmsetanimationrate(1);
  }

  self asmrequestsubstate(#"hash_513a4bf9337d7336");
  self waittill(#"engine_startup");
  self vehicle::impact_fx(self.settings.startupfx1);
  self waittill(#"leave_ground");
  self vehicle::impact_fx(self.settings.takeofffx1);

  while(true) {
    distancetogoal = distance2d(self.jump.linkent.origin, goal);
    antigravityscaleup = 1;
    antigravityscale = 1;
    antigravity = (0, 0, 0);

    if(false) {
      line(self.jump.linkent.origin, self.jump.linkent.origin + antigravity, (0, 1, 0), 1, 0, 60000);
    }

    velocityforwardscale = mapfloat(self.radius * 1, self.radius * 4, 0.2, 1, distancetogoal);
    velocityforward = initvelocityforward * velocityforwardscale;

    if(false) {
      line(self.jump.linkent.origin, self.jump.linkent.origin + velocityforward, (0, 1, 0), 1, 0, 60000);
    }

    oldverticlespeed = velocity[2];
    velocity = (0, 0, velocity[2]);
    velocity += velocityforward + params.gravityforce + antigravity;

    if(oldverticlespeed > 0 && velocity[2] < 0) {
      self asmrequestsubstate(#"hash_7ed8f3dbe3df1eec");
    }

    if(velocity[2] < 0 && self.jump.linkent.origin[2] + velocity[2] < goal[2]) {
      break;
    }

    heightthreshold = goal[2] + 110;
    oldheight = self.jump.linkent.origin[2];
    self.jump.linkent.origin += velocity;

    if(self.jump.linkent.origin[2] < heightthreshold && (oldheight > heightthreshold || oldverticlespeed > 0 && velocity[2] < 0)) {
      self notify(#"start_landing");
      self asmrequestsubstate(params.landingstate);
    }

    if(false) {
      debugstar(self.jump.linkent.origin, 60000, (1, 0, 0));
    }

    waitframe(1);
  }

  self.jump.linkent.origin = (self.jump.linkent.origin[0], self.jump.linkent.origin[1], 0) + (0, 0, goal[2]);
  self notify(#"land_crush");

  foreach(player in level.players) {
    player val::set(#"hash_1199035500d4ef6a", "takedamage", 0);
  }

  self radiusdamage(self.origin + (0, 0, 15), self.radiusdamageradius, self.radiusdamagemax, self.radiusdamagemin, self, "MOD_EXPLOSIVE");

  foreach(player in level.players) {
    player val::reset(#"hash_1199035500d4ef6a", "takedamage");

    if(distance2dsquared(self.origin, player.origin) < sqr(200)) {
      direction = ((player.origin - self.origin)[0], (player.origin - self.origin)[1], 0);

      if(abs(direction[0]) < 0.01 && abs(direction[1]) < 0.01) {
        direction = (randomfloatrange(1, 2), randomfloatrange(1, 2), 0);
      }

      direction = vectornormalize(direction);
      strength = 700;
      player setvelocity(player getvelocity() + direction * strength);

      if(player.health > 80) {
        player dodamage(player.health - 70, self.origin, self);
      }
    }
  }

  self vehicle::impact_fx(self.settings.landingfx1);
  self stopmovementandsetbrake();
  wait 0.3;
  self unlink();
  waitframe(1);
  self.jump.in_air = 0;
  self notify(#"jump_finished");
  util::cooldown("jump", 7);
  self vehicle_ai::waittill_asm_complete(params.landingstate, 3);
  self vehicle_ai::evaluate_connections();
}

function state_jump_exit(params) {}

function state_combat_update(params) {
  self endon(#"death", #"change_state");
  self thread movement_thread();
  self thread attack_thread_machinegun();
  self thread attack_thread_rocket();

  if(is_true(self.isxbot)) {
    self thread attack_thread_main();
    self thread attack_thread_javelin();
  }
}

function state_combat_exit(params) {
  self turretcleartarget(0);
  self setturretspinning(0);
}

function locomotion_start() {
  if(self.vehicletype === "spawner_enemy_boss_siegebot_zombietron") {
    self asmsetanimationrate(0.5);
  }

  self asmrequestsubstate(#"locomotion@movement");
}

function weapon_doors_state(isopen, waittime = 0) {
  self endon(#"death");
  self notify(#"weapon_doors_state");
  self endon(#"weapon_doors_state");

  if(isDefined(waittime) && waittime > 0) {
    wait waittime;
  }

  self vehicle::toggle_ambient_anim_group(1, isopen);
}

function waittill_pathing_done(maxtime = 15) {
  self endon(#"change_state");
  self notify("6c6e5a29d1dadca5");
  self endon("6c6e5a29d1dadca5");
  result = self waittilltimeout(maxtime, #"enemy", #"near_goal", #"force_goal", #"reached_end_node", #"pathfind_failed");
}

function movement_thread() {
  self endon(#"death", #"change_state");
  self notify(#"end_movement_thread");
  self endon(#"end_movement_thread");
  assert(isDefined(level.var_3d1b6323));

  while(true) {
    if(isDefined(self.owner)) {
      wait 1;
      continue;
    }

    [[level.var_3d1b6323]] - > waitinqueue(self);
    self.current_pathto_pos = self vehicle_ai::function_1d436633(self, self.enemy);

    if(!isDefined(self.current_pathto_pos)) {
      wait 1;
      continue;
    }

    foundpath = self function_a57c34b7(self.current_pathto_pos, 0, 1);

    if(foundpath) {
      if(isDefined(self.enemy) && self seerecently(self.enemy, 1)) {
        self vehlookat(self.enemy);
        self turretsettarget(0, self.enemy);
      }

      locomotion_start();
      self waittill_pathing_done();
      self cancelaimove();
      self function_d4c687c9();

      if(isDefined(self.enemy) && self seerecently(self.enemy, 2)) {
        if(isDefined(self.isxbot)) {
          self vehlookat(self.enemy);
          self turretsettarget(0, self.enemy);
        } else {
          self face_target(self.enemy.origin);
        }
      }
    }

    wait 1;
    startadditionalwaiting = gettime();

    while(isDefined(self.enemy) && self cansee(self.enemy) && util::timesince(startadditionalwaiting) < 1.5) {
      wait 0.4;
    }
  }
}

function stopmovementandsetbrake() {
  self notify(#"end_movement_thread");
  self notify(#"near_goal");
  self cancelaimove();
  self function_d4c687c9();
  self turretcleartarget(0);
  self vehclearlookat();
  self setbrake(1);
}

function face_target(position, targetanglediff = 30) {
  v_to_enemy = ((position - self.origin)[0], (position - self.origin)[1], 0);
  v_to_enemy = vectornormalize(v_to_enemy);
  goalangles = vectortoangles(v_to_enemy);
  anglediff = absangleclamp180(self.angles[1] - goalangles[1]);

  if(anglediff <= targetanglediff) {
    return;
  }

  self vehlookat(position);
  self turretsettarget(0, position);
  self locomotion_start();
  angleadjustingstart = gettime();

  while(anglediff > targetanglediff && util::timesince(angleadjustingstart) < 4) {
    anglediff = absangleclamp180(self.angles[1] - goalangles[1]);
    waitframe(1);
  }

  self function_d4c687c9();
  self vehclearlookat();
  self turretcleartarget(0);
  self cancelaimove();
}

function scan() {
  angles = self gettagangles("tag_barrel");
  angles = (0, angles[1], 0);
  rotate = 360;

  while(rotate > 0) {
    angles += (0, 30, 0);
    rotate -= 30;
    forward = anglesToForward(angles);
    aimpos = self.origin + forward * 1000;
    self turretsettarget(0, aimpos);
    self waittilltimeout(0.5, #"turret_on_target");
    wait 0.1;

    if(isDefined(self.enemy) && self cansee(self.enemy)) {
      self turretsettarget(0, self.enemy);
      self vehlookat(self.enemy);
      self face_target(self.enemy);
      return;
    }
  }

  forward = anglesToForward(self.angles);
  aimpos = self.origin + forward * 1000;
  self turretsettarget(0, aimpos);
  self waittilltimeout(3, #"turret_on_target");
  self turretcleartarget(0);
}

function attack_thread_machinegun() {
  self endon(#"death", #"change_state", #"end_attack_thread");
  self notify(#"end_machinegun_attack_thread");
  self endon(#"end_machinegun_attack_thread");
  self.turretrotscale = 1 * self.difficulty_scale_up;
  spinning = 0;

  while(!is_true(self.left_arm_disabled)) {
    enemy = self.enemy;

    if(is_true(self.isxbot)) {
      enemy = self.gunner1enemy;
    }

    if(isDefined(enemy) && self cansee(enemy)) {
      self vehlookat(enemy);
      self turretsettarget(0, enemy);

      if(!spinning) {
        spinning = 1;
        self setturretspinning(1);
        wait 0.5;
        continue;
      }

      self turretsettarget(1, enemy, (0, 0, 0));
      self turretsettarget(2, enemy, (0, 0, 0));
      self vehicle_ai::fire_for_time(randomfloatrange(0.75, 1.5) * self.difficulty_scale_up, 1, enemy);

      if(isDefined(enemy) && isai(enemy)) {
        wait randomfloatrange(0.1, 0.2);
      } else {
        wait randomfloatrange(0.2, 0.3) * self.difficulty_scale_down;
      }

      continue;
    }

    spinning = 0;
    self setturretspinning(0);
    self turretcleartarget(1);
    self turretcleartarget(2);
    wait 0.4;
  }
}

function attack_rocket(target) {
  if(isDefined(target)) {
    self turretsettarget(0, target);
    self turretsettarget(3, target, (0, 0, -10));
    self waittilltimeout(1, #"turret_on_target");
    self fireweapon(2, target, (0, 0, -10));
    self turretcleartarget(2);
  }
}

function function_e177d7af(target) {
  if(isDefined(target)) {
    self turretsettarget(0, target);
    self turretsettarget(3, target, (0, 0, -10));
    self waittilltimeout(1, #"turret_on_target");
    var_628cb978 = getweapon(#"hash_2a42cf9b8d71ff7e");
    var_7f98edcc = target.origin;
    v_origin = self gettagorigin("tag_gunner_flash2");
    v_dir = vectornormalize(var_7f98edcc - v_origin);
    var_a64609fe = v_dir * 1000;
    self magicmissile(var_628cb978, v_origin, var_a64609fe, target);
    self turretcleartarget(2);
  }
}

function attack_thread_rocket() {
  self endon(#"death", #"change_state", #"end_attack_thread");
  self notify(#"end_rocket_attack_thread");
  self endon(#"end_rocket_attack_thread");
  util::cooldown("rocket", 3);

  while(!is_true(self.right_arm_disabled)) {
    if(isDefined(self.gunner2enemy) && self seerecently(self.gunner2enemy, 3) && util::iscooldownready("rocket", 1.5) && !is_true(self.var_a8c60b0e)) {
      self turretsettarget(1, self.gunner2enemy, (0, 0, 0));
      self turretsettarget(3, self.gunner2enemy, (0, 0, -10));
      self thread weapon_doors_state(1);
      wait 1.5;

      if(isDefined(self.gunner2enemy) && self seerecently(self.gunner2enemy, 1)) {
        util::cooldown("rocket", 5);

        if(isDefined(self.gunner2enemy) && !is_true(self ai::function_63734291(self.gunner2enemy))) {
          attack_rocket(self.gunner2enemy);
        } else if(isDefined(self.gunner2enemy) && is_true(self ai::function_63734291(self.gunner2enemy))) {
          function_e177d7af(self.gunner2enemy);
        }

        wait 1;

        if(isDefined(self.gunner2enemy) && !is_true(self ai::function_63734291(self.gunner2enemy))) {
          attack_rocket(self.gunner2enemy);
        } else if(isDefined(self.gunner2enemy) && is_true(self ai::function_63734291(self.gunner2enemy))) {
          function_e177d7af(self.gunner2enemy);
        }

        self thread weapon_doors_state(0, 1);
      } else {
        self thread weapon_doors_state(0);
      }

      continue;
    }

    self turretcleartarget(1);
    self turretcleartarget(2);
    wait 0.4;
  }
}

function attack_thread_main() {
  self endon(#"death", #"change_state", #"end_attack_thread");

  while(true) {
    if(isDefined(self.enemy) && self cansee(self.enemy) && self.turretontarget) {
      self vehicle_ai::fire_for_time(randomfloatrange(0.75, 1.5), 0, self.enemy);
    }

    wait randomfloatrange(0.5, 1.5);
  }
}

function attack_thread_javelin() {
  self endon(#"death", #"change_state", #"end_attack_thread");

  while(!is_true(self.javelin_disabled)) {
    if(isDefined(self.enemy) && util::iscooldownready("javelin_rocket_launcher")) {
      fired = 0;

      for(i = 0; i < 3 && isDefined(self.enemy); i++) {
        enemy = self.enemy;

        if(i == 1 && isDefined(self.gunner3enemy)) {
          enemy = self.gunner3enemy;

          if(enemy == self.enemy) {
            continue;
          }
        }

        if(i == 2 && isDefined(self.gunner2enemy)) {
          enemy = self.gunner2enemy;

          if(enemy == self.enemy) {
            continue;
          }
        }

        if(distance2dsquared(self.origin, enemy.origin) < sqr(300)) {
          continue;
        }

        self thread vehicle_ai::javelin_losetargetatrighttime(enemy, 2);
        self fireweapon(3, enemy);
        fired = 1;
        wait 0.8;
      }

      if(fired) {
        cooldown = 15;

        if(self.scriptvehicletype == # "xbot") {
          if(is_true(self.left_arm_disabled)) {
            cooldown -= 5;
          }

          if(is_true(self.right_arm_disabled)) {
            cooldown -= 5;
          }
        }

        util::cooldown("javelin_rocket_launcher", cooldown);
      }
    }

    wait 0.3;
  }
}

function siegebot_callback_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(vehicle_ai::should_emp(self, vsurfacenormal, partname, psoffsettime, damagefromunderneath)) {
    minempdowntime = 0.8 * self.settings.empdowntime;
    maxempdowntime = 1.2 * self.settings.empdowntime;
    self notify(#"emped", {
      #param0: randomfloatrange(minempdowntime, maxempdowntime), #param1: damagefromunderneath, #param2: psoffsettime
    });
  }

  if(!isDefined(self.damagelevel)) {
    self.damagelevel = 0;
    self.newdamagelevel = self.damagelevel;
  }

  newdamagelevel = vehicle::should_update_damage_fx_level(self.health, modelindex, self.healthdefault);

  if(newdamagelevel > self.damagelevel) {
    self.newdamagelevel = newdamagelevel;
  }

  if(self.newdamagelevel > self.damagelevel) {
    self.damagelevel = self.newdamagelevel;
    driver = self getseatoccupant(0);

    if(!isDefined(driver)) {
      self notify(#"pain");
    }

    vehicle::set_damage_fx_level(self.damagelevel);
  }

  if(self.health - modelindex <= 0 && target_istarget(self)) {
    target_remove(self);
  }

  return modelindex;
}
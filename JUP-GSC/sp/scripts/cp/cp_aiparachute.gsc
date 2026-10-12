/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_aiparachute.gsc
***********************************************/



#using scripts\common\utility;
#using scripts\cp\cp_outline;
#using scripts\cp\spawning;
#using scripts\cp\utility;
#using scripts\engine\utility;
#namespace cp_aiparachute;

function init_cp_aiparachute() {
  level.spawnfunc_registered = [];
  level.ac130_paratrooper_veh = [];
}

function request_paratroopers(groupname, dropheight, spawnpos, spawnpoints) {
  if(!isDefined(level.spawnfunc_registered)) {
    level.spawnfunc_registered = [];
  }

  dropheight = isDefined(dropheight) ? dropheight : 12000;

  if(!isDefined(level.spawnfunc_registered[groupname])) {
    scripts\cp\spawning::register_module_ai_spawn_func(groupname, &paratrooper_spawnfunc);
    level.spawnfunc_registered[groupname] = 1;
  }

  spawners = getStructArray(groupname, "targetname");

  if(isDefined(spawnpoints)) {
    spawners = spawnpoints;
  }

  foreach(spawner in spawners) {
    spawner scripts\cp\spawning::enable_spawner();

    if(!isDefined(spawner.parachute_land_origin)) {
      spawner.parachute_land_origin = spawner.origin;
    }
  }

  spawner = spawners[0];
  var_1e4bce6c927436e0 = spawner.parachute_land_origin + (0, 0, dropheight);
  ac130 = spawn("script_model", spawnpos);
  ac130 setModel("veh9_mil_air_cargo_plane_wm");
  ac130.angles = vectortoangles(var_1e4bce6c927436e0 - ac130.origin);
  ac130 playLoopSound("cp_reinforcement_drop_c130");
  ac130 setscriptablepartstate("lights2", "on", 0);
  ac130 setscriptablepartstate("contrails", "on", 0);

  if(!isDefined(level.ac130_paratrooper_veh)) {
    level.ac130_paratrooper_veh = [];
  }

  level.ac130_paratrooper_veh[level.ac130_paratrooper_veh.size] = ac130;
  ac130.spawngroup = groupname;
  var_273771ff28315234 = 10;

  if(isDefined(level.var_7e0688b1c67f2b22)) {
    var_273771ff28315234 = level.var_7e0688b1c67f2b22;
  }

  if(var_273771ff28315234 < 1) {
    var_273771ff28315234 = 1;
  }

  ac130 moveTo(var_1e4bce6c927436e0 + anglesToForward(ac130.angles) * 4500, var_273771ff28315234, 0.1, var_273771ff28315234 * 0.25);
  wait var_273771ff28315234;
  spawners = getStructArray(groupname, "targetname");

  foreach(spawner in spawners) {
    spawner.origin = ac130.origin;
  }

  var_c78f7d61791cd00a = scripts\cp\spawning::run_spawn_module(groupname);
  ac130 moveTo(ac130.origin + anglesToForward(ac130.angles) * 24500, 10);
  wait 10;
  level.ac130_paratrooper_veh = array_remove(level.ac130_paratrooper_veh, ac130);
  ac130 stoploopsound();
  ac130 setscriptablepartstate("lights2", "off", 0);
  ac130 setscriptablepartstate("contrails", "off", 0);
  ac130 delete();
  return var_c78f7d61791cd00a;
}

function ac130_flight_path(var_1e4bce6c927436e0) {
  level endon("game_ended");
  self endon("death");
  self moveTo(var_1e4bce6c927436e0 + anglesToForward(self.angles) * 4500, 10);
  wait 10;
  thread fly_to_end_point();
}

function fly_to_end_point() {
  self moveTo(self.origin + anglesToForward(self.angles) * 24500, 10);
  wait 10;

  if(array_contains(level.ac130_paratrooper_veh, self)) {
    level.ac130_paratrooper_veh = array_remove(level.ac130_paratrooper_veh, self);
  }

  self delete();
}

function spawn_paratrooper_ac130(groupname, spawnpos, var_1e4bce6c927436e0) {
  ac130 = spawn("script_model", spawnpos);
  ac130 setModel("veh9_mil_air_cargo_plane_wm");
  ac130.angles = vectortoangles(var_1e4bce6c927436e0 - ac130.origin);
  ac130.health = 50000;
  ac130.maxhealth = 50000;
  ac130.team = "axis";

  if(getdvarint(@ "hash_188f3d56a3849a78", 0)) {
    scripts\cp\cp_outline::enable_outline_for_players(ac130, level.players, "<dev string:x1c>", "<dev string:x32>");
  }

  if(!isDefined(level.ac130_paratrooper_veh)) {
    level.ac130_paratrooper_veh = [];
  }

  level.ac130_paratrooper_veh[level.ac130_paratrooper_veh.size] = ac130;
  ac130.spawngroup = groupname;
  return ac130;
}

function paratrooper_spawnfunc(spawngroup) {
  thread create_paratrooper();
}

function create_paratrooper() {
  self endon("death");
  thread watch_for_death();
  parachute_set_spawn_values();
  parachute_get_path();
  parachute_skydive();
  parachute_idle();
}

function parachute_set_spawn_values() {
  self allowedstances("stand");
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.scripted_mode = 1;
  self.playing_skit = 1;
  self.do_immediate_ragdoll = 1;
  scripts\cp\spawning::set_kill_off_time(1000);
  ac130 = undefined;

  foreach(veh in level.ac130_paratrooper_veh) {
    if(veh.spawngroup != self.enemy_group) {
      continue;
    }

    ac130 = veh;
  }

  if(isDefined(ac130)) {
    self.ac130 = ac130;
    self asmsetstate(self.asmname, "parachute_freefall");
    self._blackboard.parachutestate = "freefall";
    self setOrigin(ac130.origin + (0, 0, 50), 0);
  }
}

function parachute_get_path(var_4f200828059689db) {
  self endon("death");

  if(!isDefined(var_4f200828059689db)) {
    var_4f200828059689db = 5;
  }

  if(isDefined(self.spawnpoint.var_e1dc57d80a5bd29e)) {
    var_4f200828059689db = self.spawnpoint.var_e1dc57d80a5bd29e;
  }

  if(!isDefined(self.spawnpoint.parachute_land_origin)) {
    self.spawnpoint.parachute_land_origin = self.spawnpoint.origin;
  }

  parachute_height = default_to(self.spawnpoint.var_bdaef5a9b7c28e6, 1500);
  startorigin = self.spawnpoint.parachute_land_origin + (randomfloatrange(var_4f200828059689db * -1, var_4f200828059689db), randomfloatrange(var_4f200828059689db * -1, var_4f200828059689db), 0);
  self.landing_spot = undefined;
  var_c1fb2d429477b8d8 = getgroundposition(startorigin, 64, 15000, 15000);

  if(isDefined(var_c1fb2d429477b8d8)) {
    self.landing_spot = getclosestpointonnavmesh(var_c1fb2d429477b8d8 + (0, 0, 32));
  }

  if(!isDefined(self.landing_spot)) {
    self.landing_spot = getclosestpointonnavmesh(self.spawnpoint.origin);
  }

  offset = (0, 0, 0);
  var_c01f3501868a8135 = self.landing_spot + (0, 0, parachute_height);

  if(istrue(self.spawnpoint.allow_momentum)) {
    if(function_240f7f4e57340e8f()) {
      fwd = vectorNormalize(self.origin - var_c01f3501868a8135);
      dist = distance(self.origin, var_c01f3501868a8135);
      offset = fwd * dist * 0.3;
    } else {
      fwd = vectortoangles(self.origin - self.landing_spot);
      offset = anglesToForward(fwd) * 3500;
    }
  }

  self.skydive_dest = var_c01f3501868a8135 + (offset[0], offset[1], 0);
}

function parachute_skydive() {
  self endon("death");

  if(isDefined(self.ac130)) {
    self.anchor = spawn("script_origin", self.origin);
    self.anchor.angles = (0, self.angles[1], 0);
    self linkTo(self.anchor);

    if(function_240f7f4e57340e8f()) {
      var_3b7b669401bb9e30 = distance(self.skydive_dest, self.origin);

      if(var_3b7b669401bb9e30 < 40230.2) {
        var_340b0316991f7183 = sqrt(var_3b7b669401bb9e30 * 2 / 385.82);
        var_668f2bffda468a7a = var_340b0316991f7183;
      } else {
        var_37418e7099ca8253 = var_3b7b669401bb9e30 - 40230.2;
        time_remaining = var_37418e7099ca8253 / 2288;
        var_340b0316991f7183 = time_remaining + 5.93;
        var_668f2bffda468a7a = 5.93;
      }

      self.anchor moveTo(self.skydive_dest, var_340b0316991f7183, var_668f2bffda468a7a, 0);
      self.anchor rotateTo((0, self.ac130.angles[1], 0), 2);
      wait max(var_340b0316991f7183 - 2, 0.1);
    } else {
      var_340b0316991f7183 = 12;

      if(isDefined(self.spawnpoint.skydive_time)) {
        var_340b0316991f7183 = self.spawnpoint.skydive_time;
      } else if(isDefined(level.var_752d2f716afe7fcf)) {
        var_340b0316991f7183 = level.var_752d2f716afe7fcf;
      }

      if(var_340b0316991f7183 < 2.1) {
        var_340b0316991f7183 = 2.1;
      }

      self.anchor rotateTo((0, self.ac130.angles[1], 0) + (0, 180, 0), 2);
      self.anchor moveTo(self.skydive_dest, var_340b0316991f7183);
      wait var_340b0316991f7183 - 3;
    }

    parachute_spawn();
    parachute_deploy();

    if(!function_240f7f4e57340e8f()) {
      wait 2;
    } else {
      wait 1;
    }

    return;
  }

  self.nocorpse = 1;
  self dodamage(self.health + 100, self.origin);
}

function parachute_spawn() {
  chute = spawn("script_model", self gettagorigin("j_spine4"));
  chute.angles = self gettagangles("j_spine4");
  chute setModel("misc_wm_br_parachute");
  chute linkTo(self, "j_spine4", (0, 0, 0), (0, 0, 0));
  self.chute = chute;
  chute thread unlink_on_ai_death(self);
}

function parachute_deploy() {
  self.chute scriptmodelplayanim("sdr_com_parachute_pullcord");
  self._blackboard.parachutestate = "parachuting";
  self asmsetstate(self.asmname, "parachute_deploy");
  thread delayeventfired();
}

function delayeventfired() {
  self endon("death");
  wait 3.5;
  self asmfireevent(self.asmname, "finish");
}

function parachute_idle() {
  thread parachute_move();
  thread parachute_idle_internal();
}

function parachute_idle_internal() {
  self endon("death");
  wait 1.5;
  self.chute scriptmodelplayanim("sdr_com_parachute_idle");
  self setscriptablepartstate("skydiveVfx", "enabled", 0);
}

function parachute_move() {
  self endon("death");
  move_time = 6;

  if(istrue(self.spawnpoint.allow_momentum)) {
    move_time = 9;
  }

  if(isDefined(self.spawnpoint.chute_time)) {
    var_69c13c485eca0c7c = self.spawnpoint.chute_time;
  }

  decel_time = 1.5;
  self.anchor moveTo(self.landing_spot, move_time, 0.1, 1.5);
  point1 = (self.origin[0], self.origin[1], 0);

  if(function_240f7f4e57340e8f()) {
    point2 = (self.landing_spot[0], self.landing_spot[1], 0);
  } else {
    waitframe();
    point2 = (self.origin[0], self.origin[1], 0);
  }

  self.anchor rotateTo(vectortoangles(point2 - point1), 3, 1, 1);
  wait move_time - 1.5;
  self._blackboard.parachutestate = "landing";
  self.chute scriptmodelplayanim("sdr_com_parachute_prepare_for_landing");
  self setscriptablepartstate("skydiveVfx", "default", 0);
  wait 3.4;
  self.chute delete();
  self.chute notify("parachute_detached");
  thread do_landing();
}

function do_landing() {
  self endon("death");
  self.anchor.origin = self.landing_spot;
  self setplayerangles((0, self.anchor.angles[1], 0));
  self motionwarpcancel();
  self unlink();
  self setplayerangles((0, self.anchor.angles[1], 0));

  if(isDefined(self.anchor)) {
    self.anchor delete();
  }

  self allowedstances("prone", "stand", "crouch");
  self.playing_skit = undefined;
  self.ignoreall = 0;
  self.ignoreme = 0;
  self.scripted_mode = 0;
  self.ac130 = undefined;
  self.landing_spot = undefined;

  if(!ispointonnavmesh(self.origin, self, 1)) {
    scripts\cp\spawning::teleport_to_nearby_spawner("Landed off NavMesh", self.origin);
  } else {
    scripts\cp\spawning::set_kill_off_time(20);
    thread scripts\cp\spawning::enter_combat();
  }

  self notify("delete_chute");

  if(isDefined(self.spawnpoint) && isDefined(self.spawnpoint.var_cba615c821ed60f6)) {
    self thread[[self.spawnpoint.var_cba615c821ed60f6]]();
  }

  wait 1;
  self.do_immediate_ragdoll = undefined;
}

function watch_for_death() {
  self endon("parachute_detached");
  self waittill("death");

  if(isDefined(self.anchor)) {
    self.anchor delete();
  }
}

function unlink_on_ai_death(ai) {
  self endon("death");
  ai endon("parachute_detached");
  ai waittill("death");
  self unlink();
  self movez(100, 2);
  wait 2;
  self delete();
}

function function_512ce2eff75c0873(var_8299a70a0562ea4c, groupname, ai_spawnpoints) {
  flag_wait("level_ready_for_script");

  if(!isDefined(var_8299a70a0562ea4c) || !isDefined(groupname) && !isDefined(var_8299a70a0562ea4c.groupname)) {
    return;
  }

  if(!isDefined(level.ac130_paratrooper_veh)) {
    level.ac130_paratrooper_veh = [];
  }

  if(isDefined(groupname) && isDefined(var_8299a70a0562ea4c.groupname)) {
    var_8299a70a0562ea4c.groupname = groupname;
  }

  if(isDefined(ai_spawnpoints)) {
    var_8299a70a0562ea4c.ai_spawnpoints = ai_spawnpoints;
  } else {
    var_8299a70a0562ea4c.ai_spawnpoints = getStructArray(var_8299a70a0562ea4c.groupname, "targetname");
  }

  if(var_8299a70a0562ea4c.ai_spawnpoints.size == 0) {
    assertmsg("cp_aiparachute - No AI Spawners provided or found!");
    return;
  }

  if(!(isDefined(level.ambientgroups) && isDefined(level.ambientgroups[var_8299a70a0562ea4c.groupname]))) {
    scripts\cp\spawning::registerambientgroup(var_8299a70a0562ea4c.groupname, var_8299a70a0562ea4c.ai_spawnpoints.size, var_8299a70a0562ea4c.ai_spawnpoints.size, var_8299a70a0562ea4c.ai_spawnpoints.size, undefined, undefined, var_8299a70a0562ea4c.ai_spawnpoints);
  }

  scripts\cp\spawning::set_spawn_scoring_params_for_group(var_8299a70a0562ea4c.groupname, 0, 999999);
  var_8299a70a0562ea4c.allow_momentum = int(isDefined(var_8299a70a0562ea4c.allow_momentum) ? var_8299a70a0562ea4c.allow_momentum : 1);
  var_8299a70a0562ea4c.var_bdaef5a9b7c28e6 = float(isDefined(var_8299a70a0562ea4c.var_bdaef5a9b7c28e6) ? var_8299a70a0562ea4c.var_bdaef5a9b7c28e6 : 1000);

  if(!isDefined(var_8299a70a0562ea4c.chute_time)) {
    var_8299a70a0562ea4c.chute_time = istrue(var_8299a70a0562ea4c.allow_momentum) ? 8 : 6;
  }

  var_8299a70a0562ea4c.chute_time = float(var_8299a70a0562ea4c.chute_time);
  var_8299a70a0562ea4c.var_e1dc57d80a5bd29e = float(isDefined(var_8299a70a0562ea4c.var_e1dc57d80a5bd29e) ? var_8299a70a0562ea4c.var_e1dc57d80a5bd29e : 5);

  if(!isDefined(level.spawnfunc_registered)) {
    level.spawnfunc_registered = [];
  }

  if(!istrue(level.spawnfunc_registered[var_8299a70a0562ea4c.groupname])) {
    scripts\cp\spawning::register_module_ai_spawn_func(var_8299a70a0562ea4c.groupname, &paratrooper_spawnfunc);
    level.spawnfunc_registered[var_8299a70a0562ea4c.groupname] = 1;
  }

  foreach(spawner in var_8299a70a0562ea4c.ai_spawnpoints) {
    spawner scripts\cp\spawning::enable_spawner();

    if(!isDefined(spawner.parachute_land_origin)) {
      spawner.parachute_land_origin = spawner.origin;
    }

    spawner.allow_momentum = var_8299a70a0562ea4c.allow_momentum;
    spawner.skydive_time = 0;
    spawner.chute_time = var_8299a70a0562ea4c.chute_time;
    spawner.var_bdaef5a9b7c28e6 = var_8299a70a0562ea4c.var_bdaef5a9b7c28e6;
    spawner.var_e1dc57d80a5bd29e = var_8299a70a0562ea4c.var_e1dc57d80a5bd29e;

    if(isDefined(var_8299a70a0562ea4c.var_cba615c821ed60f6)) {
      spawner.var_cba615c821ed60f6 = var_8299a70a0562ea4c.var_cba615c821ed60f6;
    }
  }

  var_695710be9aa10b90 = isDefined(var_8299a70a0562ea4c.var_ea9cb5e9fa0958a5) ? var_8299a70a0562ea4c.var_ea9cb5e9fa0958a5 : var_8299a70a0562ea4c.ai_spawnpoints[0];

  if(!isDefined(var_8299a70a0562ea4c.dropoff_height)) {
    var_8299a70a0562ea4c.dropoff_height = 12000;
  } else if(var_8299a70a0562ea4c.dropoff_height < 0) {
    dropoff_height = var_8299a70a0562ea4c.origin[2] - var_695710be9aa10b90.origin[2];
    var_8299a70a0562ea4c.dropoff_height = dropoff_height;
  }

  var_8299a70a0562ea4c.dropoff_height = float(var_8299a70a0562ea4c.dropoff_height);
  var_8299a70a0562ea4c.exit_dist = float(isDefined(var_8299a70a0562ea4c.exit_dist) ? var_8299a70a0562ea4c.exit_dist : 20000);
  var_8299a70a0562ea4c.var_d1d978d765de25b9 = -1 * float(isDefined(var_8299a70a0562ea4c.var_d1d978d765de25b9) ? var_8299a70a0562ea4c.var_d1d978d765de25b9 : 3500);

  if(isDefined(var_8299a70a0562ea4c.target)) {
    var_8299a70a0562ea4c.deploy_point = getStruct(var_8299a70a0562ea4c.target, "targetname").origin;
  } else {
    var_8299a70a0562ea4c.deploy_point = var_695710be9aa10b90.parachute_land_origin + (0, 0, var_8299a70a0562ea4c.dropoff_height);
  }

  flight_direction = vectortoangles(var_8299a70a0562ea4c.deploy_point - var_8299a70a0562ea4c.origin);

  if(isDefined(var_8299a70a0562ea4c.target)) {
    var_8299a70a0562ea4c.var_df6f4ed45de77141 = var_8299a70a0562ea4c.deploy_point;
  } else {
    var_8299a70a0562ea4c.var_df6f4ed45de77141 = var_8299a70a0562ea4c.deploy_point + anglesToForward(flight_direction) * var_8299a70a0562ea4c.var_d1d978d765de25b9;
  }

  var_8299a70a0562ea4c.exit_point = var_8299a70a0562ea4c.var_df6f4ed45de77141 + anglesToForward(flight_direction) * var_8299a70a0562ea4c.exit_dist;
  var_c8b1d95ac26d2547 = distance2d(var_8299a70a0562ea4c.origin, var_8299a70a0562ea4c.var_df6f4ed45de77141);
  var_df0b3d261760c9c5 = distance2d(var_8299a70a0562ea4c.origin, var_8299a70a0562ea4c.exit_point);
  plane_speed = 161;

  if(isDefined(var_8299a70a0562ea4c.plane_speed)) {
    plane_speed = var_8299a70a0562ea4c.plane_speed;
  }

  var_8299a70a0562ea4c.var_40d08fccd5b3a342 = mph_travel_time(plane_speed, var_df0b3d261760c9c5);
  var_8299a70a0562ea4c.var_9697b6eddcb3a889 = var_c8b1d95ac26d2547 / var_df0b3d261760c9c5 * var_8299a70a0562ea4c.var_40d08fccd5b3a342;
  return var_8299a70a0562ea4c;
}

#using_animtree("mp_vehicles_always_loaded_cp");

function function_fd00e772c1cf3d49(var_8299a70a0562ea4c) {
  var_1e4bce6c927436e0 = var_8299a70a0562ea4c.deploy_point;
  ac130 = spawn("script_model", var_8299a70a0562ea4c.origin);
  ac130 setModel("veh9_mil_air_cargo_plane_wm");
  ac130.angles = vectortoangles(var_1e4bce6c927436e0 - ac130.origin);
  ac130 playLoopSound("cp_reinforcement_drop_c130");
  ac130 useanimtree(#animtree);
  ac130 setscriptablepartstate("lights2", "on", 0);
  ac130 setscriptablepartstate("contrails", "on", 0);
  level.ac130_paratrooper_veh[level.ac130_paratrooper_veh.size] = ac130;
  ac130.spawngroup = var_8299a70a0562ea4c.groupname;
  ac130 moveTo(var_8299a70a0562ea4c.exit_point, var_8299a70a0562ea4c.var_40d08fccd5b3a342, 0.05, 0.05);
  wait var_8299a70a0562ea4c.var_9697b6eddcb3a889;
  spawners = var_8299a70a0562ea4c.ai_spawnpoints;

  foreach(spawner in spawners) {
    spawner.origin = ac130.origin;
  }

  level thread function_9817b4bb61e13698(ac130, var_8299a70a0562ea4c);
  var_c78f7d61791cd00a = scripts\cp\spawning::run_spawn_module(var_8299a70a0562ea4c.groupname);
  return var_c78f7d61791cd00a;
}

function function_9817b4bb61e13698(plane, var_8299a70a0562ea4c) {
  wait var_8299a70a0562ea4c.var_40d08fccd5b3a342 - var_8299a70a0562ea4c.var_9697b6eddcb3a889;
  level.ac130_paratrooper_veh = array_remove(level.ac130_paratrooper_veh, plane);
  plane stoploopsound();
  plane setscriptablepartstate("lights2", "off", 0);
  plane setscriptablepartstate("contrails", "off", 0);
  plane delete();
}
/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_25899a6e5c5f4ba9.gsc
*************************************************/

#using script_39a07ba83a01c235;
#using scripts\common\utility;
#using scripts\cp\astar;
#using scripts\cp\cp_gameskill;
#using scripts\cp\damagefeedback;
#using scripts\cp\laststand;
#using scripts\cp\utility;
#using scripts\cp\utility\entity;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace namespace_4549c407bf07be14;

function function_fe662b4f5891e15e() {
  if(flag("drones_initialized")) {
    return;
  }

  flag_set("drones_initialized");
  println("<dev string:x1c>");
  level endon("game_ended");
  level endon("end_drone_encounter");
  level.activekillstreaks = default_to(level.activekillstreaks, []);
  level.astar_node_radius_override = 16;
  level.var_9def439b33eac09d = 0;
  level.var_ac33444df3b5f6b = 4;
  level.var_e769257ba0ea53f7 = -4;
  level.var_2c85db303881a3c8 = 2;
  level.var_903f92904b8791e0 = 32;
  level init();
  function_9b2d64f0caf923f0();
  level.var_8834997c5cb408a1 = getStructArray("drone_spawn_point", "targetname");
  thread function_a1ddd2941612a7e3();
  thread function_14315a0224474c97();
  thread function_c494284a52d7031c();
  thread function_d5f32ac462c151e4();
  flag_wait("Player_detected");
  var_ded89867771e61cb = getStruct("drone_priority_area", "script_noteworthy");
  thread function_1ef2364d60a8af83(var_ded89867771e61cb, 1000);
  thread function_1a97917c43d295f9("window_drone_3");
  thread function_1a97917c43d295f9("window_drone_4");
  function_1a97917c43d295f9("window_drone_1");
  wait getdvarfloat(@ "hash_12fe04dee117741b", 1);
  flag_set("window_drone_2");
  thread function_1a97917c43d295f9("window_drone_2");
}

function function_d5f32ac462c151e4() {
  level endon("game_ended");
  level endon("end_drone_encounter");
  flag_set("mansion_drones_released");

  for(i = 0; i < level.var_15943bbbbb0376cd; i++) {
    function_8215737de6aa5723("drone_swarm_" + string(i));
  }

  var_3dc2b77e9b2c2883 = 0;
  var_b487f5450c210214 = 0;
  var_451c2b4aceae0507 = getdvarint(@ "hash_3836b880b76d32c2", 20);

  while(var_b487f5450c210214 < var_451c2b4aceae0507) {
    while(level.var_ef94125f71754b2f.size >= level.var_15943bbbbb0376cd) {
      wait 1;
    }

    wait_time = level.var_c0848cac8ee8b948 * pow(1 + level.var_7a8e3b57968f3f05, var_3dc2b77e9b2c2883);
    println("<dev string:x2f>" + string(wait_time) + "<dev string:x38>");
    wait wait_time;

    for(i = 0; level.var_ef94125f71754b2f.size < level.var_15943bbbbb0376cd; i++) {
      function_8215737de6aa5723("drone_reinforcement_" + string(var_3dc2b77e9b2c2883) + "_" + string(i));
      var_b487f5450c210214 += level.var_3630e5bc94440173.var_ed12f04bc4db520b;
    }

    var_3dc2b77e9b2c2883++;
    flag_set("drone_reinforcements_" + string(var_3dc2b77e9b2c2883));
    println("<dev string:x5e>" + string(var_3dc2b77e9b2c2883) + "<dev string:x75>" + string(var_b487f5450c210214));
  }

  flag_set("drone_reinforcements_exhausted");
}

function function_8215737de6aa5723(id_name) {
  var_118898e10b8b23c5 = structcopy(level.var_3630e5bc94440173, 0);
  var_118898e10b8b23c5.swarm_id = id_name;
  spawn_point = array_random(level.var_8834997c5cb408a1);
  var_118898e10b8b23c5.spawnpoint = spawn_point;
  var_118898e10b8b23c5.var_8dd45af7dacfe1f8 = isstring(spawn_point.var_228354b5beed0d34) ? spawn_point.var_228354b5beed0d34 : level.var_3630e5bc94440173.var_8dd45af7dacfe1f8;
  function_82027d890fe922b2(var_118898e10b8b23c5, level.var_78892c936fefb140);
  wait level.var_24ef5707bf7dc844;
}

function function_1a97917c43d295f9(var_21c68d5193a506cf) {
  level endon("game_ended");
  level endon("end_drone_encounter");

  while(true) {
    flag_wait(var_21c68d5193a506cf);

    if(function_eac0cd99c9c6d8ee() != "hidden") {
      break;
    }

    wait 1;
  }

  var_118898e10b8b23c5 = structcopy(level.var_3630e5bc94440173, 0);
  var_118898e10b8b23c5.swarm_id = var_21c68d5193a506cf;
  spawn_point = getStruct(var_21c68d5193a506cf + "_spawner", "targetname");
  var_118898e10b8b23c5.spawnpoint = spawn_point;
  var_118898e10b8b23c5.var_8dd45af7dacfe1f8 = var_21c68d5193a506cf;
  var_118898e10b8b23c5.base_speed = level.var_3630e5bc94440173.base_speed * 1.5;
  var_118898e10b8b23c5.var_aea7973ab15d030f = 1;
  var_118898e10b8b23c5.var_ed12f04bc4db520b = 1;
  function_82027d890fe922b2(var_118898e10b8b23c5, 0.75);
}

function function_a1ddd2941612a7e3() {
  self endon("death");
  level endon("game_ended");
  level endon("end_drone_encounter");

  while(true) {
    flag_wait("mansion_side_trig");
    flag_set("drone_season");
    flag_waitopen("mansion_side_trig");
    wait 7.5;

    if(!flag("mansion_side_trig")) {
      flag_clear("drone_season");
    }
  }
}

function function_14315a0224474c97() {
  self endon("death");
  level endon("game_ended");
  level endon("end_drone_encounter");
  level.drone_roles = [];
  level.drone_roles["defense"] = [];
  level.drone_roles["offense"] = [];
  level.drone_roles["unassigned"] = [];

  while(true) {
    wait 1;

    if(!isDefined(level.var_ef94125f71754b2f)) {
      continue;
    }

    var_6b9e3906077f6a2c = level.drone_roles["defense"].size;
    var_a3b202060214ed7a = level.drone_roles["offense"].size;

    foreach(swarm in level.drone_roles["unassigned"]) {
      swarm.role = var_6b9e3906077f6a2c < level.var_4845bbda3de719e0 ? "defense" : "offense";
      level.drone_roles[swarm.role] = array_add(level.drone_roles[swarm.role], swarm);
    }

    level.drone_roles["unassigned"] = [];
    player_origin = level.player.origin;

    foreach(swarm in level.var_ef94125f71754b2f) {
      var_14bd7833ea0549bc = swarm.role;

      if(!isDefined(var_14bd7833ea0549bc)) {
        continue;
      }

      var_5c057803a6aa154a = flag("Player_detected") && function_eac0cd99c9c6d8ee() != "hidden";

      if(flag("Player_detected") && !var_5c057803a6aa154a) {
        foreach(drone in level.drone_turrets) {
          if(isDefined(drone)) {
            can_see = drone drone_turret_canseetarget(level.player, (0, 0, 0), drone, undefined, isDefined(drone.var_3589a53ab80793c7));

            if(istrue(can_see)) {
              var_5c057803a6aa154a = 1;
              break;
            }
          }
        }
      }

      if(var_5c057803a6aa154a && flag("drone_season")) {
        attack_dist = getdvarfloat(@ "hash_f41cc4628930c3dd", 1050);
        falloff_dist = getdvarfloat(@ "hash_7dad27bcfc04a079", 1600);
        dist = distance(swarm.drones function_46ad4cb259b30031().origin, player_origin);
        var_521507de4aa212d7 = level.drone_roles["offense"].size < 1;
        var_9f3eb8671b9ebcc7 = dist <= attack_dist && level.drone_roles["offense"].size < level.var_9e3c471c5ad10ee8 + getdvarint(@ "hash_1d9130d44003635c", 1);

        if(var_521507de4aa212d7 || var_9f3eb8671b9ebcc7) {
          swarm.role = "offense";
        } else if(dist >= falloff_dist && level.drone_roles["offense"].size > level.var_9e3c471c5ad10ee8) {
          swarm.role = "defense";
        }
      } else {
        swarm.role = "defense";
      }

      if(!is_equal(var_14bd7833ea0549bc, swarm.role)) {
        level.drone_roles[var_14bd7833ea0549bc] = array_remove(level.drone_roles[var_14bd7833ea0549bc], swarm);
        level.drone_roles[swarm.role] = array_add(level.drone_roles[swarm.role], swarm);
        swarm notify("assigned_" + swarm.role);
        println(swarm.id + "<dev string:x95>" + swarm.role);
      }
    }
  }
}

function function_c494284a52d7031c() {
  self endon("death");
  level endon("game_ended");
  level endon("end_drone_encounter");
  level.var_b4441c2fe5b89d61 = spawnStruct();

  while(true) {
    level.var_b4441c2fe5b89d61 waittill("update", var_887cd0972f1d781, var_d0d134bb8a0bf520);

    if(isDefined(var_d0d134bb8a0bf520)) {
      level.drone_roles[var_d0d134bb8a0bf520.role] = array_remove(level.drone_roles[var_d0d134bb8a0bf520.role], var_d0d134bb8a0bf520);
    }

    if(isDefined(var_887cd0972f1d781)) {
      var_887cd0972f1d781.role = "unassigned";
      level.drone_roles["unassigned"] = array_add(level.drone_roles["unassigned"], var_887cd0972f1d781);
    }
  }
}

function function_82027d890fe922b2(drone_struct, var_78892c936fefb140) {
  var_2cd783dd7f7d5943 = drone_struct.var_ed12f04bc4db520b;

  for(i = 0; i < var_2cd783dd7f7d5943; i++) {
    drone = function_305ec846c77281f6(drone_struct);
    wait var_78892c936fefb140;
  }
}

function function_222050924758bc30() {
  level.var_44a584edfeb159a2 = default_to(level.var_44a584edfeb159a2, []);
  var_8dd45af7dacfe1f8 = default_to(self.var_d5257e0c17926bd4, "drones_path_stealth");
  self.var_d5257e0c17926bd4 = var_8dd45af7dacfe1f8;

  if(!isDefined(level.var_44a584edfeb159a2[var_8dd45af7dacfe1f8])) {
    var_9c6f15fa4f485d2f = getStruct(var_8dd45af7dacfe1f8, "targetname");

    if(!isDefined(var_9c6f15fa4f485d2f)) {
      return;
    }

    var_43da2fa305539fa5 = [];
    var_43da2fa305539fa5[0] = var_9c6f15fa4f485d2f;

    while(isDefined(var_9c6f15fa4f485d2f.target)) {
      var_9c6f15fa4f485d2f = getStruct(var_9c6f15fa4f485d2f.target, "targetname");
      var_43da2fa305539fa5[var_43da2fa305539fa5.size] = var_9c6f15fa4f485d2f;
    }

    level.var_44a584edfeb159a2[var_8dd45af7dacfe1f8] = var_43da2fa305539fa5;
  }
}

function function_4bf74be11fa5d086() {
  self endon("death");
  level endon("game_ended");
  level endon("end_drone_encounter");
  function_222050924758bc30();

  if(level.var_44a584edfeb159a2.size == 0 || level.var_44a584edfeb159a2[self.var_d5257e0c17926bd4].size == 0) {
    return;
  }

  function_c8910d1b7ea1c801(self.base_speed * 0.6, 0.4, 0.95, 1);

  if(istrue(self.var_aea7973ab15d030f)) {
    thread function_721cc43274bb86af("danger");
  }

  var_70e60ffaa5a0a19e = level.var_44a584edfeb159a2[self.var_d5257e0c17926bd4];
  self.var_27ed911e8764d33a = default_to(self.var_27ed911e8764d33a, 0);
  target_struct = var_70e60ffaa5a0a19e[self.var_27ed911e8764d33a];

  if(isDefined(target_struct)) {
    thread update_goal_pos(target_struct.origin, (0, 0, 0));
  }

  while(self.var_27ed911e8764d33a < var_70e60ffaa5a0a19e.size) {
    self waittill("near_goal");
    self.var_27ed911e8764d33a++;
    target_struct = var_70e60ffaa5a0a19e[self.var_27ed911e8764d33a];
    self.current_node = target_struct;

    if(isDefined(target_struct)) {
      offset = randomvectorrange(-5, 5);
      thread update_goal_pos(target_struct.origin, offset);
      self.var_3aec9a4ec140655a = target_struct.origin;
      self.var_87babc8a58bc3639 = gettime();
    }
  }

  if(istrue(self.var_aea7973ab15d030f)) {
    thread bomb_explode();
  }
}

function function_9b2d64f0caf923f0() {
  level.var_a1aa250f8ab16d0a = getdvarint(@ "hash_f16d4713ee03c1d4", 2);
  level.var_78892c936fefb140 = getdvarfloat(@ "hash_d595f4784f759c89", 0.5);
  level.var_24ef5707bf7dc844 = getdvarfloat(@ "hash_ac5aa06ae841f5a4", 1.25);
  level.var_c0848cac8ee8b948 = getdvarfloat(@ "hash_f2a35e9181ecee77", 3);
  level.var_7a8e3b57968f3f05 = getdvarfloat(@ "hash_7668b9d3e13b4c68", 0.2);
  level.var_4845bbda3de719e0 = getdvarint(@ "hash_dfc79ca7fcc7959e", 3);
  level.var_9e3c471c5ad10ee8 = getdvarint(@ "hash_d194b731be7795de", 1);
  level.var_15943bbbbb0376cd = level.var_4845bbda3de719e0 + level.var_9e3c471c5ad10ee8;
  var_3630e5bc94440173 = spawnStruct();
  var_3630e5bc94440173.var_8dd45af7dacfe1f8 = "drone_stealth_path_mid";
  var_3630e5bc94440173.intro_func = &function_4bf74be11fa5d086;
  var_3630e5bc94440173.drone_team = "axis";
  var_3630e5bc94440173.spawnpoint = undefined;
  var_3630e5bc94440173.var_f716273270785091 = undefined;
  var_3630e5bc94440173.swarm_id = "default";
  var_3630e5bc94440173.starting_health = getdvarfloat(@ "hash_3a8ae577c40d252d", 50);
  var_3630e5bc94440173.base_speed = getdvarfloat(@ "hash_4b93e835d34e4056", 48.5);
  var_3630e5bc94440173.var_4a5d0bd902aae7cc = getdvarfloat(@ "hash_fd9a39fcad4879b4", 650);
  var_3630e5bc94440173.var_f5bb9b66dbcd5e1f = getdvarfloat(@ "hash_2fa331815a219fa9", 60);
  var_3630e5bc94440173.var_e61fb1ba553fe9af = getdvarfloat(@ "hash_3b205d414631afa1", 12);
  var_3630e5bc94440173.var_3b56aef2a97b59a = getdvarfloat(@ "hash_faa1da6f088efed8", 0.3);
  var_3630e5bc94440173.var_22bae4a863898ca6 = getdvarfloat(@ "hash_1ae8704bf304c38c", 100);
  var_3630e5bc94440173.var_ed12f04bc4db520b = level.var_a1aa250f8ab16d0a;
  level.var_3630e5bc94440173 = var_3630e5bc94440173;
}

function function_33d280db4e3062aa() {
  self endon("death");
  level endon("game_ended");
  level endon("end_drone_encounter");

  while(true) {
    wait 1;

    if(!isDefined(level.var_ef94125f71754b2f) || !isnumber(level.var_ef94125f71754b2f.size)) {
      continue;
    }

    println("<dev string:xa2>" + string(level.var_ef94125f71754b2f.size));

    foreach(swarm in level.var_ef94125f71754b2f) {
      if(!isDefined(swarm.leader)) {
        continue;
      }

      role = default_to(swarm.role, "<dev string:xb1>");
      println("<dev string:xc3>" + swarm_id + "<dev string:xce>" + role + "<dev string:xdb>" + string(istrue(swarm.leader.var_8d8144287647fbc5)));
    }
  }

}

function init() {
  level._effect["drone_turret_explode"] = loadfx("vfx/iw8_mp/killstreak/vfx_drone_lrg_dest_exp.vfx");
  level._effect["drone_swarm_light_danger"] = loadfx("vfx/jup/level/cp_jup_resort/vfx_resort_drone_light_danger.vfx");
  level._effect["drone_swarm_light_alert"] = loadfx("vfx/jup/level/cp_jup_resort/vfx_resort_drone_light_alert.vfx");
  level.drone_turrets = default_to(level.drone_turrets, []);
  level.var_ef94125f71754b2f = [];
  level.var_f753d22ae87b557b = 1;
  level thread function_f0eac5e558857c84();
}

function function_305ec846c77281f6(drone_struct) {
  if(level.drone_turrets.size >= 32) {
    announcement("<dev string:xeb>");

    return;
  }

  spawnpoint = drone_struct.spawnpoint;
  drone_team = drone_struct.drone_team;
  var_f716273270785091 = drone_struct.var_f716273270785091;
  swarm_id = drone_struct.swarm_id;
  var_8dd45af7dacfe1f8 = drone_struct.var_8dd45af7dacfe1f8;
  intro_func = drone_struct.intro_func;
  startpos = spawnpoint.origin;
  startang = spawnpoint.angles;
  vehicleinfo = "veh_radar_drone_recon_mp";
  dronemodel = "veh8_mil_air_tuniform_c4_ai";
  drone = spawnVehicle(dronemodel, "drone_turret", vehicleinfo, startpos, startang);
  drone.team = drone_team;
  drone.spawnpoint = spawnpoint;
  drone.spawntime = gettime();
  drone.swarm_id = swarm_id;
  drone.var_d5257e0c17926bd4 = var_8dd45af7dacfe1f8;
  drone.var_aea7973ab15d030f = drone_struct.var_aea7973ab15d030f;
  drone function_98fbc01ff1e11fd8();
  drone.var_f5bb9b66dbcd5e1f = drone_struct.var_f5bb9b66dbcd5e1f;
  drone.starting_health = drone_struct.starting_health;
  drone.var_ed12f04bc4db520b = drone_struct.var_ed12f04bc4db520b;
  drone.var_e61fb1ba553fe9af = drone_struct.var_e61fb1ba553fe9af;
  drone.var_3b56aef2a97b59a = drone_struct.var_3b56aef2a97b59a;
  drone.var_22bae4a863898ca6 = drone_struct.var_22bae4a863898ca6;
  drone.base_speed = drone_struct.base_speed;
  drone.var_ce611145f76805cd = drone_struct.var_4a5d0bd902aae7cc * drone_struct.var_4a5d0bd902aae7cc;
  drone.streakname = "switchblade_drone";
  drone.maxhealth = drone.starting_health;
  level.activekillstreaks = array_add(level.activekillstreaks, drone);
  malfa_clip = getEnt("malfa_clip", "targetname");
  drone.clip = spawn("script_model", malfa_clip.origin);
  drone.clip.angles = malfa_clip.angles;
  drone.clip clonebrushmodeltoscriptmodel(malfa_clip);
  drone.clip.origin = drone.origin;
  drone.clip.angles = drone.angles;
  drone.clip linkTo(drone, "j_body", (0, 0, 0), (0, 0, 0));
  drone.clip enableaimassist();
  drone.clip setCanDamage(1);
  drone.clip makeentitysentient(drone_team, 1, 1);
  drone.clip.var_d1f953c063dff1eb = 1;

  if(isfunction(intro_func)) {
    drone.intro_func = intro_func;
  }

  drone thread damage_feedback_watch();
  drone thread function_5e52ae7fc7833e15();
  drone thread patrol_think(spawnpoint, var_f716273270785091);
  drone thread watch_for_death();
  drone thread function_53747f8ce3d99087();
  drone thread function_d222480796864019();
  drone setscriptablepartstate("lights", "on", 0);
  drone setscriptablepartstate("glint", "on", 0);
  drone setturningability(0.6);
  drone setmaxpitchroll(10, 10);
  drone setairresistance(20);

  if(!isDefined(level.vehicle_ai_script_models)) {
    level.vehicle_ai_script_models = [];
  }

  level.vehicle_ai_script_models[level.vehicle_ai_script_models.size] = drone;
  level.drone_turrets[level.drone_turrets.size] = drone;
  return drone;
}

function function_98fbc01ff1e11fd8() {
  if(!isDefined(level.var_ef94125f71754b2f[self.swarm_id])) {
    level.var_ef94125f71754b2f[self.swarm_id] = spawnStruct();
    level.var_b4441c2fe5b89d61 notify("update", level.var_ef94125f71754b2f[self.swarm_id], undefined);
  }

  var_db46c7d01ee9223f = level.var_ef94125f71754b2f[self.swarm_id];
  var_db46c7d01ee9223f.drones = default_to(var_db46c7d01ee9223f.drones, []);
  var_db46c7d01ee9223f.headicons = default_to(var_db46c7d01ee9223f.headicons, []);
  var_db46c7d01ee9223f.drones[var_db46c7d01ee9223f.drones.size] = self;
  var_db46c7d01ee9223f.id = default_to(var_db46c7d01ee9223f.id, self.swarm_id);
  self.var_db46c7d01ee9223f = var_db46c7d01ee9223f;
  thread function_7fef88fa109a4a01();
}

function function_7fef88fa109a4a01() {
  level endon("game_ended");
  var_db46c7d01ee9223f = self.var_db46c7d01ee9223f;
  self waittill("death");
  var_db46c7d01ee9223f.drones = array_remove(var_db46c7d01ee9223f.drones, self);

  if(isDefined(self.headicon)) {
    var_db46c7d01ee9223f.headicons = array_remove(var_db46c7d01ee9223f.headicons, self.headicon);
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headicon);
  }

  if(var_db46c7d01ee9223f.drones.size <= 0) {
    level.var_ef94125f71754b2f = array_remove(level.var_ef94125f71754b2f, var_db46c7d01ee9223f);
    level.var_b4441c2fe5b89d61 notify("update", undefined, var_db46c7d01ee9223f);
  }
}

function function_34a36f44dd3b1ea9(refs) {
  wait 3;

  foreach(ref in refs) {
    if(isDefined(ref) && isent(ref)) {
      ref notify("death");
      ref delete();
    }
  }
}

function function_f0eac5e558857c84() {
  self endon("death");
  level endon("game_ended");
  level endon("end_drone_encounter");

  while(true) {
    wait 0.25;

    if(!isDefined(level.drone_turrets) || level.drone_turrets.size == 0) {
      wait 1;
      continue;
    }

    foreach(var_d9d444d1b3160ba1 in level.var_ef94125f71754b2f) {
      if(!isDefined(var_d9d444d1b3160ba1.leader)) {
        if(var_d9d444d1b3160ba1.drones.size > 0) {
          bestdrone = undefined;
          var_72b9c1ca84591923 = function_ba16debf946dba5a();
          var_631d8b7b8cdb163 = function_3693638f97674c98();
          var_7f004b9bafbafa4a = var_d9d444d1b3160ba1.drones function_46ad4cb259b30031();
          closestplayer = var_7f004b9bafbafa4a get_closest_living_player();

          foreach(drone in var_d9d444d1b3160ba1.drones) {
            if(!drone function_4149e78c6beb0d0e(var_72b9c1ca84591923, var_631d8b7b8cdb163)) {
              wait 0.05;
              continue;
            }

            if(!isDefined(bestdrone)) {
              bestdrone = drone;
              continue;
            }

            if(isDefined(closestplayer)) {
              var_d32e4c561742e237 = distancesquared(drone.origin, closestplayer.origin);
              var_c7e71d59c1c42de7 = distancesquared(drone.origin, closestplayer.origin);

              if(var_d32e4c561742e237 < var_c7e71d59c1c42de7) {
                bestdrone = drone;
              }
            }
          }

          if(isDefined(bestdrone)) {
            bestdrone thread function_21045a0d241029a();
          }

          continue;
        }
      }

      if(!isent(var_d9d444d1b3160ba1.leader) || !isalive(var_d9d444d1b3160ba1.leader)) {
        var_d9d444d1b3160ba1.leader = undefined;
      }

      wait 0.05;
    }
  }
}

function function_21045a0d241029a() {
  if(istrue(self.var_aea7973ab15d030f)) {
    return;
  }

  self.var_db46c7d01ee9223f.leader = self;
  self.var_db46c7d01ee9223f notify("group_new_leader", self);
  thread function_721cc43274bb86af("alert");
  thread function_8e8fd2eb99ba5b39();

  if(istrue(level.var_77d9637a0fc5a67e)) {
    announcement("<dev string:xf9>" + self getentitynumber());
  }

  foreach(drone in self.var_db46c7d01ee9223f.drones) {
    if(drone == self) {
      continue;
    }

    drone.var_3aec9a4ec140655a = undefined;
    drone.re_path = undefined;
    drone thread function_721cc43274bb86af("off");
  }
}

function function_ba16debf946dba5a() {
  ignore = undefined;

  if(level.drone_turrets.size > 0) {
    ignore = [];

    for(i = 0; i < level.drone_turrets.size; i++) {
      ignore[ignore.size] = level.drone_turrets[i];
      ignore[ignore.size] = level.drone_turrets[i].clip;
    }
  }

  return ignore;
}

function function_3693638f97674c98() {
  contents = scripts\engine\trace::create_contents(0, 0, 0, 1, 1, 1, 0, 1);
  return contents;
}

function function_4149e78c6beb0d0e(ignore, contents) {
  radius = 16;

  if(!isDefined(self) || !isDefined(self.origin)) {
    return 0;
  }

  if(istrue(self.var_aea7973ab15d030f)) {
    return 0;
  }

  endpoint = self.origin;

  if(isDefined(self.var_2b16fd690b342c8e) && self.var_f1c32ac23baf6a5 > gettime() - 3000) {
    endpoint = self.var_2b16fd690b342c8e;
  }

  spheretrace = scripts\engine\trace::sphere_trace_passed(self.origin, endpoint, radius, ignore, contents);
  return spheretrace;
}

function function_46ad4cb259b30031() {
  struct = spawnStruct();
  struct.origin = default_to(scripts\cp\utility\entity::getaverageorigin(self), (0, 0, 0));
  return struct;
}

function function_8e8fd2eb99ba5b39() {
  self waittill("death");
  self.var_db46c7d01ee9223f notify("group_leader_death");

  if(isDefined(self.headicon)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headicon);
  }
}

function patrol_think(spawnpoint, var_f716273270785091) {
  self endon("death");
  level endon("game_ended");
  level endon("end_drone_encounter");

  if(isDefined(spawnpoint.script_parameters)) {
    self waittill(spawnpoint.script_parameters);
  }

  thread play_loop_sound_on_entity("emt_drone_proximity_lp");

  if(isDefined(self.intro_func)) {
    self[[self.intro_func]]();
  }

  while(true) {
    if(self.var_db46c7d01ee9223f.role == "defense") {
      function_d93df04780a0f7fe();
    }

    if(!isDefined(self.var_db46c7d01ee9223f.leader) || !isalive(self.var_db46c7d01ee9223f.leader)) {
      function_c7a29d92e0ee715b(spawnpoint, var_f716273270785091);
    }

    if(is_equal(self.var_db46c7d01ee9223f.leader, self)) {
      function_8cf7f8b74219ac94(spawnpoint, var_f716273270785091);
      continue;
    }

    if(isDefined(self.var_db46c7d01ee9223f.leader) && self.var_db46c7d01ee9223f.leader != self) {
      if(istrue(self.var_8d8144287647fbc5)) {
        wait 1;
        continue;
      }

      function_327ce98e7384e9ff(spawnpoint, var_f716273270785091);
    }
  }
}

function function_d93df04780a0f7fe() {
  self endon("death");
  self.var_db46c7d01ee9223f endon("assigned_offense");
  level endon("game_ended");
  function_9fda1f9dca69810c();
  self clearlookatent();
  node_grid = function_2664d3558f31fa39("defense");
  function_c8910d1b7ea1c801(self.base_speed * 0.2, 0.4, 0.95, 1);
  target_struct = array_random(node_grid);

  if(isDefined(target_struct)) {
    thread update_goal_pos(target_struct.origin, (0, 0, 0));
  }

  while(true) {
    self waittill("near_goal");
    target_struct = array_random(node_grid);
    self.current_node = target_struct;

    if(isDefined(target_struct)) {
      offset = randomvectorrange(-5, 5);
      thread update_goal_pos(target_struct.origin, offset);
      self.var_3aec9a4ec140655a = target_struct.origin;
      self.var_87babc8a58bc3639 = gettime();
    }
  }
}

function function_2664d3558f31fa39(role) {
  if(!isstring(role)) {
    assertmsg("DRONE SWARM ROLE IS NOT A STRING, PLEASE FIX");
    return undefined;
  }

  if(!isDefined(level.var_b1dc8fce37a7441f)) {
    level.var_b1dc8fce37a7441f = [];
  }

  if(!isDefined(level.var_b1dc8fce37a7441f[role])) {
    level.var_b1dc8fce37a7441f[role] = getStructArray("drone_grid_" + role, "script_noteworthy");
  }

  return level.var_b1dc8fce37a7441f[role];
}

function function_8cf7f8b74219ac94(spawnpoint, var_f716273270785091) {
  self endon("death");
  self.var_db46c7d01ee9223f endon("assigned_defense");
  level endon("game_ended");
  self.turningability = 0.8;
  self setturningability(self.turningability);
  offset = undefined;
  speed = 10;

  if(isDefined(self.base_speed)) {
    speed = self.base_speed;
  }

  speed *= 0.75;
  grid_size = 500;
  self.repath_dist = squared(250);
  self.var_9896fa8b6e050049 = squared(900);

  if(!isDefined(self.node_grid)) {
    self.node_grid = function_2664d3558f31fa39(self.var_db46c7d01ee9223f.role);
  }

  end_pos = self.origin;
  node_index = 0;
  self.cur_state = "spawn";
  self.attack_dist = 800;
  self.var_950028441ba5facb = self.attack_dist * self.attack_dist;
  node = spawnpoint;

  while(true) {
    enemy_target = get_enemy();

    if(!isDefined(enemy_target)) {
      if(!isDefined(self.var_3aec9a4ec140655a)) {
        function_da0dcc28ec1cd67f();
      } else {
        end_pos = self.var_3aec9a4ec140655a;
      }

      if(self.cur_state != "no_target") {
        if(getdvarint(@ "astar_debug", 0)) {
          level thread drawsphere(end_pos, 5, 1, (1, 1, 1));
        }

        start_pos = self.origin;
        exclude = self;
        dyn_node = spawnStruct();
        dyn_node.origin = self.origin;
        self.path_data = scripts\cp\astar::function_845fd743c0fadc39(self.node_grid, start_pos, end_pos, exclude, dyn_node, grid_size);

        if(!isDefined(self.path_data)) {
          wait 0.5;
          function_9ab4de075453475b();
          continue;
        }

        if(getdvarint(@ "astar_debug", 0)) {
          for(i = 0; i < self.path_data.path.size; i++) {
            if(isDefined(self.path_data.path[i]) && isDefined(self.path_data.path[i + 1])) {
              line(self.path_data.path[i].origin, self.path_data.path[i + 1].origin, (0, 1, 0), 1, 0, 20);
            }
          }
        }

        node_index = 0;
        next_node = self.path_data.start_node;
        self.cur_state = "no_target";
      }
    } else if(function_9ada223f5f41e90(enemy_target)) {
      if(getdvarint(@ "hash_7c68c7438db6dbb0", 1) && self.var_db46c7d01ee9223f.drones.size > 1) {
        drone = array_exclude(self.var_db46c7d01ee9223f.drones, [self])[0];
        drone notify("sent_for_death");
        self setlookatent(enemy_target);
        drone.var_565ae80d9fecf7ca = enemy_target;
        drone.var_8d8144287647fbc5 = 1;
        drone function_eb38987b1c34b60f(enemy_target);

        if(!isDefined(drone)) {
          continue;
        }

        drone notify("stop_dive_bomb");
        drone.re_path = 1;
        drone.var_8d8144287647fbc5 = undefined;
      } else {
        self.var_565ae80d9fecf7ca = enemy_target;
        self.var_8d8144287647fbc5 = 1;
        function_eb38987b1c34b60f(enemy_target);
        self notify("stop_dive_bomb");
        self.re_path = 1;
        self.var_8d8144287647fbc5 = undefined;
      }
    } else if(istrue(self.re_path)) {
      node_grid = self.node_grid;
      self.re_path = undefined;

      foreach(drone in level.drone_turrets) {
        if(drone == self) {
          continue;
        }

        if(isDefined(drone.next_node)) {
          node_grid = array_remove(node_grid, drone.next_node);
        }
      }

      start_pos = self.origin;
      end_pos = enemy_target.origin;
      var_e14ac44f6f147496 = enemy_target.origin;
      node_array = sortbydistancecullbyradius(node_grid, end_pos, 800);
      var_8709e35b9b50357f = node_array.size < 1;

      if(var_8709e35b9b50357f) {
        node_array = sortbydistancecullbyradius(node_grid, start_pos, 800);
      }

      if(node_array.size > 0) {
        var_e8e4ed22f3d730b4 = [];

        foreach(node in node_array) {
          if(node drone_turret_canseetarget(enemy_target, (0, 0, 0), self)) {
            var_e8e4ed22f3d730b4[var_e8e4ed22f3d730b4.size] = node;
          }
        }

        if(var_e8e4ed22f3d730b4.size > 0) {
          var_e14ac44f6f147496 = var_e8e4ed22f3d730b4[randomintrange(0, int(min(3, var_e8e4ed22f3d730b4.size)))];
          var_e14ac44f6f147496 = var_e14ac44f6f147496.origin;
        } else {
          if(istrue(level.var_77d9637a0fc5a67e)) {
            announcement("<dev string:x106>");
          }

          function_9ab4de075453475b();
          var_e14ac44f6f147496 = self.var_3aec9a4ec140655a;
        }
      }

      exclude = [self, self.clip];

      if(level.drone_turrets.size > 0) {
        exclude = [];

        for(i = 0; i < level.drone_turrets.size; i++) {
          exclude[exclude.size] = level.drone_turrets[i];
          exclude[exclude.size] = level.drone_turrets[i].clip;
        }
      }

      dyn_node = spawnStruct();
      dyn_node.origin = self.origin;
      self.path_data = scripts\cp\astar::function_845fd743c0fadc39(node_grid, start_pos, var_e14ac44f6f147496, exclude, dyn_node, grid_size);

      if(!isDefined(self.path_data)) {
        wait 0.1;
        continue;
      }

      if(getdvarint(@ "astar_debug", 0)) {
        for(i = 0; i < self.path_data.path.size; i++) {
          if(isDefined(self.path_data.path[i]) && isDefined(self.path_data.path[i + 1])) {
            line(self.path_data.path[i].origin, self.path_data.path[i + 1].origin, (0, 1, 0), 1, 0, 20);
          }
        }
      }

      next_node = self.path_data.start_node;
      node_index = 0;

      if(self.cur_state != "re_path") {
        self.cur_state = "re_path";
      }
    } else if(function_9c77fa5e9c0c9a98(enemy_target, end_pos)) {
      node_grid = self.node_grid;
      start_pos = self.origin;
      end_pos = enemy_target.origin;
      var_e14ac44f6f147496 = enemy_target.origin;
      node_array = sortbydistancecullbyradius(node_grid, end_pos, 800);

      if(node_array.size > 0) {
        var_e8e4ed22f3d730b4 = [];

        foreach(node in node_array) {
          if(node drone_turret_canseetarget(enemy_target, (0, 0, 0), self)) {
            var_e8e4ed22f3d730b4[var_e8e4ed22f3d730b4.size] = node;
          }
        }

        if(var_e8e4ed22f3d730b4.size > 0) {
          var_e14ac44f6f147496 = var_e8e4ed22f3d730b4[randomintrange(0, int(min(3, var_e8e4ed22f3d730b4.size)))];
          var_e14ac44f6f147496 = var_e14ac44f6f147496.origin;
        }
      }

      exclude = self;
      dyn_node = spawnStruct();
      dyn_node.origin = self.origin;
      self.path_data = scripts\cp\astar::function_845fd743c0fadc39(node_grid, start_pos, var_e14ac44f6f147496, exclude, dyn_node, grid_size);

      if(!isDefined(self.path_data)) {
        wait 0.1;
        continue;
      }

      if(getdvarint(@ "astar_debug", 0)) {
        for(i = 0; i < self.path_data.path.size; i++) {
          if(isDefined(self.path_data.path[i]) && isDefined(self.path_data.path[i + 1])) {
            line(self.path_data.path[i].origin, self.path_data.path[i + 1].origin, (0, 1, 0), 1, 0, 20);
          }
        }

        clr = (0, 1, 1);
        level thread drawsphere(var_e14ac44f6f147496, 5, 1, clr);
      }

      next_node = self.path_data.start_node;

      if(self.cur_state != "new_target_loc") {
        node_index = 0;
        self.cur_state = "new_target_loc";
      }
    } else if(self.cur_state != "hunt_target") {
      self.cur_state = "hunt_target";
    }

    if(!isDefined(self.path_data)) {
      wait 0.1;
      stop_at_node();
      continue;
    }

    if(!isDefined(self.path_data.path[node_index])) {
      if(node_index >= self.path_data.path.size) {
        self.cur_state = "path_done";
        stop_at_node();
      }

      wait 0.1;
      continue;
    }

    if(istrue(self.re_path)) {
      if(function_baad9bb95a202b57()) {
        function_4b94d0301d662c36();
        continue;
      }
    }

    next_node = self.path_data.path[node_index];

    if(function_baad9bb95a202b57()) {
      self.re_path = 1;
      function_4b94d0301d662c36();
      continue;
    }

    self playsoundonmovingent("cp_bomb_drone_pause");

    if(!drone_turret_canseetarget(next_node, (0, 0, 0), self)) {
      self.health = -1;

      if(isDefined(level.var_77d9637a0fc5a67e)) {
        announcement("drone tried to path through a wall?");
      }

      if(gettime() - self.spawntime > 10000) {
        self.re_path = 1;
        wait 0.1;
        continue;
      }
    }

    move_to_new_node(next_node, node_index, offset, speed);
    node_index++;
    wait 0.1;
  }
}

function function_327ce98e7384e9ff(spawnpoint, var_f716273270785091) {
  self.var_db46c7d01ee9223f endon("group_leader_death");
  self.var_db46c7d01ee9223f endon("group_new_leader");
  self.var_db46c7d01ee9223f endon("assigned_defense");
  self endon("sent_for_death");
  self endon("death");
  level endon("game_ended");
  var_ae447f3203e2aadb = randomfloatrange(0.05, 0.2);
  var_67168602b0241e34 = randomintrange(14, 40);
  var_daa711e95f6ebfee = var_67168602b0241e34 * -1;
  speed = 10;

  if(isDefined(self.base_speed)) {
    speed = self.base_speed;
  }

  self vehicle_setspeed(speed, speed * 0.4, speed * 0.95);
  self.speed = speed;
  self.turningability = 1;
  self setturningability(self.turningability);

  if(!isDefined(self.node_grid)) {
    self.node_grid = function_2664d3558f31fa39(self.var_db46c7d01ee9223f.role);
  }

  while(true) {
    leader = self.var_db46c7d01ee9223f.leader;

    if(!isDefined(leader) || is_dead_or_dying(leader)) {
      return;
    }

    offset = (randomfloatrange(var_daa711e95f6ebfee, var_67168602b0241e34), randomfloatrange(var_daa711e95f6ebfee, var_67168602b0241e34), randomfloatrange(var_daa711e95f6ebfee, var_67168602b0241e34));
    thread update_goal_pos(leader.origin, offset);
    self.var_2b16fd690b342c8e = leader.origin;
    self.var_f1c32ac23baf6a5 = gettime();
    self.current_node = undefined;
    wait var_ae447f3203e2aadb;
  }
}

function function_c7a29d92e0ee715b(spawnpoint, var_f716273270785091) {
  self.var_db46c7d01ee9223f endon("group_leader_death");
  self.var_db46c7d01ee9223f endon("group_new_leader");
  self endon("death");
  level endon("game_ended");
  speed = default_to(self.base_speed, 10);
  self vehicle_setspeed(speed, speed * 0.4, speed * 0.95);
  self.speed = speed;
  self.turningability = 1;
  self setturningability(self.turningability);
  availablenodes = [];

  if(!isDefined(self.node_grid)) {
    self.node_grid = function_2664d3558f31fa39(self.var_db46c7d01ee9223f.role);
  }

  availablenodes = self.node_grid;

  while(true) {
    closestnode = getclosest(self.origin, availablenodes);
    disttonode = distance(self.origin, closestnode.origin);

    if(disttonode < 16) {
      availablenodes = array_remove(availablenodes, closestnode);
      closestnode = undefined;
    }

    if(isDefined(closestnode)) {
      thread update_goal_pos(closestnode.origin, (0, 0, 0));
    }

    wait 0.25;
  }
}

function function_c8910d1b7ea1c801(speed, var_a0ffba01816d1d92, var_3911ef3e3f5a996d, turningability) {
  speed = default_to(speed, self.base_speed);
  var_a0ffba01816d1d92 = default_to(var_a0ffba01816d1d92, 0.4);
  var_3911ef3e3f5a996d = default_to(var_3911ef3e3f5a996d, 0.95);
  turningability = default_to(turningability, 1);
  self.speed = speed;
  self.turningability = turningability;
  self vehicle_setspeed(speed, speed * var_a0ffba01816d1d92, speed * var_3911ef3e3f5a996d);
  self setturningability(self.turningability);
}

function function_6374f2634771c899() {
  if(isDefined(self.var_db46c7d01ee9223f.leader)) {
    if(isent(self.var_db46c7d01ee9223f.leader) && isalive(self.var_db46c7d01ee9223f.leader)) {
      end_pos = self.var_db46c7d01ee9223f.leader.origin;
      self.var_3aec9a4ec140655a = end_pos;
      self.var_87babc8a58bc3639 = gettime();
    }
  }
}

function function_9ab4de075453475b() {
  closestnode = getclosest(self.origin, self.node_grid);
  self.var_3aec9a4ec140655a = closestnode.origin;
  self.var_87babc8a58bc3639 = gettime();
  speed = 10;

  if(isDefined(self.base_speed)) {
    speed = self.base_speed;
  }

  self vehicle_setspeed(speed, speed * 0.4, speed * 0.95);
  self.speed = speed;
  self.turningability = 1;
  self setturningability(self.turningability);
  self.current_node = closestnode;
  thread update_goal_pos(closestnode.origin, (0, 0, 0));
  wait 2;
}

function function_da0dcc28ec1cd67f() {
  random_node = array_random(self.node_grid);
  self.var_3aec9a4ec140655a = random_node.origin;
  self.var_87babc8a58bc3639 = gettime();
  speed = default_to(self.base_speed, 10);
  self vehicle_setspeed(speed * 0.2, speed * 0.4, speed * 0.95);
  self.speed = speed;
  self.turningability = 1;
  self setturningability(self.turningability);
  self.current_node = random_node;
  thread update_goal_pos(random_node.origin, (0, 0, 0));
  wait 5;
}

function function_baad9bb95a202b57() {
  delay_movement = 0;

  if(isDefined(self.var_db46c7d01ee9223f.leader) && self.var_db46c7d01ee9223f.leader != self) {
    if(distance(self.var_db46c7d01ee9223f.leader.origin, self.origin) < 64) {
      foreach(other_drone in self.var_db46c7d01ee9223f.drones) {
        if(other_drone == self) {
          continue;
        }

        if(distance(other_drone.origin, self.origin) < 48) {
          delay_movement = 1;
        }
      }
    }
  }

  return delay_movement;
}

function function_4b94d0301d662c36() {
  wait 0.05;
}

function function_9ada223f5f41e90(enemy_target) {
  if(getdvarint(@ "hash_23e2329857dd5e4f", 1) && isDefined(level.drone_attacking_player)) {
    return false;
  }

  if(isstruct(enemy_target)) {
    return false;
  }

  if(gettime() - self.spawntime < 3000) {
    return false;
  }

  if(distancesquared(self.origin, enemy_target.origin) > self.var_950028441ba5facb && !isDefined(self.var_3589a53ab80793c7)) {
    return false;
  }

  if(istrue(self.re_path)) {
    return false;
  }

  var_445cecbefd8dc42d = enemy_target isswimunderwater() && function_3ff5fa5cffdd0aa8(enemy_target);

  if(var_445cecbefd8dc42d) {
    return true;
  }

  canseetarget = drone_turret_canseetarget(enemy_target, (0, 0, 0), self, undefined, isDefined(self.var_3589a53ab80793c7));

  if(canseetarget) {
    return true;
  }

  if(distancesquared(self.origin, enemy_target.origin) < self.repath_dist) {
    canseetarget = drone_turret_canseetarget(enemy_target, (0, 0, 0), self, 2, 1);

    if(canseetarget) {
      return true;
    }
  }

  return false;
}

function function_eb38987b1c34b60f(enemy_target) {
  if(isstruct(enemy_target)) {
    move_to_new_node(enemy_target, 0, (0, 0, 50), self.var_f5bb9b66dbcd5e1f, self.var_3b56aef2a97b59a);
    return;
  }

  level notify("drone_attacking_player", self);
  level.drone_attacking_player = self;
  thread function_40c75443a87ef6c5();
  self setturningability(0.95);
  self setlookatent(enemy_target);
  lookangle = vectortoangles(enemy_target.origin - self.origin);
  self setgoalyaw(lookangle[1]);
  self setyawspeed(500, 300, 270, 0.3);
  thread function_eb8bbc754779b523();
  thread function_721cc43274bb86af("danger");
  thread function_94d8111112ffc480();
  move_to_new_node(enemy_target, 0, (0, 0, 50), self.var_f5bb9b66dbcd5e1f, self.var_3b56aef2a97b59a);

  if(is_equal(level.drone_attacking_player, self)) {
    level.drone_attacking_player = undefined;
  }
}

function function_390147c3b3fff1cb(target_list) {
  var_1ee5d92113c13508 = &scripts\cp_mp\entityheadicons::setheadicon_singleimage;
  dist = self.attack_dist * 1.1;
  self.headicon = self thread[[var_1ee5d92113c13508]](target_list, "icon_ping_warning", 32, 1, dist, 256, undefined, 0, 1);
  self.var_db46c7d01ee9223f.headicons[self.var_db46c7d01ee9223f.headicons.size] = self.headicon;
}

function function_40c75443a87ef6c5() {
  self endon("death");
  self endon("stop_dive_bomb");

  while(true) {
    playrumbleonposition("cp_wheelson_rumble", self.origin);
    wait 0.25;
  }
}

function function_eb8bbc754779b523() {
  self endon("death");
  self endon("stop_dive_bomb");

  while(true) {
    self playsoundonmovingent("cp_bomb_drone_warning");
    wait 0.5;
  }
}

function function_9c77fa5e9c0c9a98(enemy_target, end_pos) {
  if(!isDefined(self.path_data) || self.cur_state == "path_done") {
    return true;
  }

  if(distancesquared(enemy_target.origin, end_pos) > self.repath_dist) {
    if(distancesquared(self.origin, enemy_target.origin) > self.var_9896fa8b6e050049 && distancesquared(self.origin, end_pos) > self.var_9896fa8b6e050049) {
      return false;
    }

    return true;
  }

  return false;
}

function drone_turret_canseetarget(target, offset, drone, radius_override, var_726b4bf92cac7d7b) {
  if(istrue(target.ignoreme) || istrue(target.notarget)) {
    return 0;
  }

  offset = default_to(offset, (0, 0, 0));
  icansee = 0;
  contents = scripts\engine\trace::create_contents(0, 0, 0, 1, 1, 1, 0, 1);

  if(!isstruct(target)) {
    tracepoints = [target gettagorigin("j_head"), target gettagorigin("j_mainroot")];
  } else {
    tracepoints = [target.origin];
  }

  radius = 16;

  if(isDefined(level.astar_node_radius_override)) {
    radius = level.astar_node_radius_override;
  }

  if(isDefined(radius_override)) {
    radius = radius_override;
  }

  ignore = undefined;
  start = self;
  fov = cos(100);

  if(level.drone_turrets.size > 0) {
    ignore = [];

    for(i = 0; i < level.drone_turrets.size; i++) {
      ignore[ignore.size] = level.drone_turrets[i];
      ignore[ignore.size] = level.drone_turrets[i].clip;
    }
  }

  for(i = 0; i < tracepoints.size; i++) {
    checktrace = scripts\engine\trace::sphere_trace(start.origin + offset, tracepoints[i], radius, ignore, contents);

    if(checktrace["fraction"] < 1) {
      continue;
    }

    if(isDefined(drone)) {
      if(!isstruct(target)) {
        if(target isswimunderwater() && !drone function_3ff5fa5cffdd0aa8(target)) {
          continue;
        }

        if(!istrue(var_726b4bf92cac7d7b)) {
          if(!within_fov(start.origin + offset, drone.angles, tracepoints[i], fov)) {
            continue;
          }
        }
      }
    }

    icansee = 1;
    break;
  }

  if(istrue(level.var_77d9637a0fc5a67e)) {
    if(icansee == 0 && !isstruct(target)) {
      announcement("<dev string:x129>");
    }

    foreach(trace in tracepoints) {
      lookvec = trace - self.origin;
      line(self.origin, trace, (1, 1, 0.5), 1, 0, 60);
      print3d(trace, "<dev string:x12b>", (1, 1, 0.1), 1, 1, 60, 1);
    }
  }

  if(isDefined(target.vehicle)) {
    icansee = 1;
  }

  return icansee;
}

function function_3ff5fa5cffdd0aa8(target) {
  if(!isPlayer(target)) {
    return true;
  }

  for(i = 0; i < self.var_db46c7d01ee9223f.drones.size; i++) {
    var_a38bcb54e21b2f5f = self.var_db46c7d01ee9223f.drones[i];

    if(isDefined(var_a38bcb54e21b2f5f.last_damaged_by) && var_a38bcb54e21b2f5f.last_damaged_by == target) {
      return true;
    }
  }

  return false;
}

function function_de436db710384fe2() {
  numdrones = self.var_db46c7d01ee9223f.drones.size;
  return numdrones < self.var_ed12f04bc4db520b * 0.6;
}

function get_enemy() {
  enemy_target = undefined;

  if(isDefined(self.var_3aec9a4ec140655a)) {
    if(self.var_87babc8a58bc3639 + 2000 < gettime()) {
      self.var_3aec9a4ec140655a = undefined;
    }
  }

  if(isDefined(self.var_db46c7d01ee9223f.leader) && self.var_db46c7d01ee9223f.leader != self) {
    return enemy_target;
  }

  if(isDefined(enemy_target)) {
    target_offset = (0, 0, 50);

    if(drone_turret_canseetarget(enemy_target, target_offset, self)) {
      self.var_3aec9a4ec140655a = enemy_target.origin;
      self.var_87babc8a58bc3639 = gettime();
      return enemy_target;
    }
  }

  var_5bf33998853d38ae = function_eac4117ecb82b75e();

  if(var_5bf33998853d38ae.size < 1) {
    return enemy_target;
  }

  if(isDefined(self.origin)) {
    var_5bf33998853d38ae = sortbydistance(var_5bf33998853d38ae, self.origin);
  }

  var_f76842485babee15 = self.var_ce611145f76805cd;

  if(function_de436db710384fe2()) {
    var_f76842485babee15 = 1440000;
  }

  foreach(enemy_target in var_5bf33998853d38ae) {
    if(distancesquared(enemy_target.origin, self.origin) > var_f76842485babee15) {
      continue;
    }

    target_offset = (0, 0, 50);

    if(drone_turret_canseetarget(enemy_target, target_offset, self)) {
      self.var_3aec9a4ec140655a = enemy_target.origin;
      self.var_87babc8a58bc3639 = gettime();
      function_76b97d7b11066363();
      return enemy_target;
    }
  }

  if(isDefined(level.var_8d1cb2f62ce55c8a)) {
    foreach(enemy in var_5bf33998853d38ae) {
      if(enemy == level.var_8d1cb2f62ce55c8a) {
        if(isDefined(self.var_db46c7d01ee9223f.leader) && self.var_db46c7d01ee9223f.leader == self) {
          self.var_3aec9a4ec140655a = enemy.origin;
          self.var_87babc8a58bc3639 = gettime();
          return enemy;
        }
      }
    }
  }

  foreach(enemy_target in var_5bf33998853d38ae) {
    if(istrue(enemy_target.ignoreme) || istrue(enemy_target.notarget) || !flag("Player_detected")) {
      return undefined;
    }
  }

  foreach(enemy_target in var_5bf33998853d38ae) {
    target_offset = (0, 0, 50);

    if(drone_turret_canseetarget(enemy_target, target_offset, self)) {
      self.var_3aec9a4ec140655a = enemy_target.origin;
      self.var_87babc8a58bc3639 = gettime();
      return enemy_target;
    }
  }

  for(i = 0; i < var_5bf33998853d38ae.size; i++) {
    enemy_target = var_5bf33998853d38ae[i];

    if(isalive(enemy_target) && !istrue(enemy_target.inlaststand)) {
      return enemy_target;
    }
  }

  return enemy_target;
}

function move_to_new_node(node, path_index, offset, speed_override, update_time) {
  self endon("death");
  level endon("game_ended");
  level endon("end_drone_encounter");
  self notify("move_to_new_node");
  self endon("move_to_new_node");
  offset = default_to(offset, (0, 0, 0));
  dist = distance(self.origin, node.origin);
  node.angles = default_to(node.angles, (0, 0, 0));

  if(getdvarint(@ "astar_debug", 0)) {
    clr = (1, 0, 1);

    if(self.cur_state == "<dev string:x12d>") {
      clr = (0, 1, 0);
    } else if(self.cur_state == "<dev string:x137>") {
      clr = (1, 0, 0);
    } else if(self.cur_state == "<dev string:x146>") {
      clr = (0, 0, 1);
    }

    level thread drawsphere(node.origin, 5, 1, clr);
  }

  if(dist > 1) {
    self.next_node = node;
    speed = default_to(speed_override, 10);

    if(isDefined(self.base_speed)) {
      if(isDefined(level.var_95fd31d093a7b7aa) && level.var_95fd31d093a7b7aa != self) {
        speed = self.base_speed;
      } else if(self.var_db46c7d01ee9223f.drones.size > 1) {
        speed = self.base_speed * 0.8;
      } else {
        speed = self.base_speed;
      }
    }

    self.move_speed = speed;
    self vehicle_setspeed(speed, speed * 0.2, speed * 0.95);
    lookangle = vectortoangles(node.origin - self.origin);
    self setgoalyaw(lookangle[1]);
    self setyawspeed(400, 300, 270, 0.3);
    thread update_goal_pos(node, offset, update_time);
    waittill_any_timeout_2(15, "near_goal", "stop_tracking");
    self notify("stop_tracking");
    self.next_node = undefined;
    self.current_node = node;
    self.move_speed = 0;
    self vehicle_setspeedimmediate(1, 12, 12);
    return;
  }

  wait 0.1;
}

function update_goal_pos(node, offset, update_time) {
  self endon("death");
  level endon("game_ended");
  level endon("end_drone_encounter");
  self endon("stop_tracking");
  self notify("update_goal_pos");
  self endon("update_goal_pos");
  pos = undefined;

  if(isvector(node)) {
    pos = node;
  } else if(isDefined(node.origin)) {
    pos = node.origin;
  }

  if(!isDefined(pos)) {
    announcement("<dev string:x14e>");

    return;
  }

  if(istrue(level.var_77d9637a0fc5a67e)) {
    var_af4a7323e71b404 = 0;
    vec = pos - self.origin;
    var_96020f25b789accf = length(vec);

    if(var_96020f25b789accf > 2) {
      ignore = [self, self.clip];
      collisioncontents = physics_createcontents(["physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
      start = var_96020f25b789accf * 0.25;
      i = start;

      while(i < var_96020f25b789accf) {
        tracepos = self.origin + vectorNormalize(vec) * i;
        var_da461b632fc8e9de = tracepos + (0, 0, 150);
        passed = scripts\engine\trace::sphere_trace_passed(tracepos, var_da461b632fc8e9de, 8, ignore, collisioncontents);

        if(passed) {
          line(tracepos, var_da461b632fc8e9de, (0.1, 0.7, 0.7), 1, 0, 150);

          var_af4a7323e71b404++;
        } else {
          line(tracepos, var_da461b632fc8e9de, (0.7, 0.2, 0.2), 1, 0, 40);
        }

        i *= 1.1;
      }
    }

    if(var_af4a7323e71b404 > 10) {
      announcement("Wallcheck!");
    }
  }

  self setvehgoalpos(pos + offset, 0);

  if(isDefined(level.var_903f92904b8791e0)) {
    self setneargoalnotifydist(level.var_903f92904b8791e0);
  }

  if(isDefined(update_time) && update_time > 0) {
    var_2bc7779d8637c25d = 0;
    thread function_a953e534ff89430a(self.var_e61fb1ba553fe9af);

    while(true) {
      wait update_time;

      if(isDefined(node.origin)) {
        pos = node.origin;
      }

      self setvehgoalpos(pos + offset, 0);

      if(isDefined(self.var_3589a53ab80793c7)) {
        continue;
      }

      if(!drone_turret_canseetarget(node, offset, self)) {
        if(distancesquared(self.origin, pos + offset) > 22500) {
          self notify("stop_tracking");
          continue;
        }

        ignore = [];

        if(level.drone_turrets.size > 0) {
          for(i = 0; i < level.drone_turrets.size; i++) {
            ignore[ignore.size] = level.drone_turrets[i];
            ignore[ignore.size] = level.drone_turrets[i].clip;
          }
        }

        contents = physics_createcontents(["physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
        checktrace = scripts\engine\trace::ray_trace(self.origin, node.origin, ignore, contents);
        self.var_3589a53ab80793c7 = spawnStruct();
        self.var_3589a53ab80793c7.origin = checktrace["position"];
        node = self.var_3589a53ab80793c7;
      }
    }
  }
}

function function_a953e534ff89430a(timer) {
  self endon("death");
  self endon("stop_tracking");
  thread function_f0794596985dcdb4();
  wait timer;
  self notify("stop_tracking");
}

function function_f0794596985dcdb4() {
  self endon("death");
  self waittill("stop_tracking");
  thread function_721cc43274bb86af("alert");
  self setturningability(self.turningability);
}

function stop_at_node() {
  self.move_speed = 0;
  self vehicle_setspeed(self.base_speed * 0.05, 12, 12);
}

function function_5e52ae7fc7833e15() {
  self endon("death");

  while(true) {
    self waittill("pause_move");
    self vehicle_setspeedimmediate(0, 15, 15);
    wait 0.5;
    self vehicle_setspeed(self.move_speed, 12, 12);
  }
}

function enemy_sentry_debug() {
  self endon("death");
  self endon("kill_turret");
  level endon("game_ended");
  org = self.origin;
  interval = 0.05;
  frames = int(interval * 20);

  while(true) {
    print3d(org, "<dev string:x15b>" + self.health + "<dev string:x172>" + self.maxhealth, (1, 1, 1), 1, 1, frames, 1);

    print3d(org + (0, 0, 10), "<dev string:x174>" + self.heatlevel, (1, 1, 1), 1, 1, frames, 1);

    wait interval;
  }
}

function function_721cc43274bb86af(state, only_leader) {
  if(!isDefined(self.light_fx_tag)) {
    self.light_fx_tag = "tag_camera_fx";
  }

  self.var_34a833cf8e285177 = self.light_state;
  self.light_state = state;
  function_9fda1f9dca69810c();

  if(self.light_state == "danger") {
    playFXOnTag(level._effect["drone_swarm_light_danger"], self, self.light_fx_tag);
    return;
  }

  if(self.light_state == "alert") {
    playFXOnTag(level._effect["drone_swarm_light_alert"], self, self.light_fx_tag);
  }
}

function function_9fda1f9dca69810c() {
  if(!isDefined(self.var_34a833cf8e285177)) {
    return;
  }

  if(self.var_34a833cf8e285177 == "alert") {
    stopFXOnTag(level._effect["drone_swarm_light_alert"], self, self.light_fx_tag);
    return;
  }

  if(self.var_34a833cf8e285177 == "danger") {
    stopFXOnTag(level._effect["drone_swarm_light_danger"], self, self.light_fx_tag);
  }
}

function function_27b2b1f4f6013d20() {
  self endon("death");

  if(!isDefined(self.var_dddcf6433ffa5aaa) && is_equal(self.var_db46c7d01ee9223f.leader, self)) {
    self.var_dddcf6433ffa5aaa = 1;
    drop_location = self.origin;
    velocity = (0, 0, -10);

    if(isDefined(self.var_565ae80d9fecf7ca)) {
      drop_location = self.var_565ae80d9fecf7ca.origin;
    }

    magicgrenademanual("smoke_grenade_mp", drop_location, velocity, 0.05);
    thread play_sound_in_space("smoke_grenade_expl_trans", self.origin);
  }
}

function damage_feedback_watch() {
  self endon("death");
  level endon("game_ended");
  self setCanDamage(0);
  self.health = 100000;
  self.clip setCanDamage(1);
  self.clip.health = 100000;
  self.clip.fake_health = self.starting_health;
  is_axis = self.team == "axis";
  self.var_689d46e1e37cc5ad = &function_c5d04118503d4ea7;

  while(true) {
    self.clip waittill("damage", idamage, eattacker, vdir, vpoint, smeansofdeath, smodelname, stagname, spartname, idflags, objweapon, origin, angles, normal, einflictor, eventid);
    self.clip.fake_health -= idamage;
    self.clip.health = 100000;

    if(!isDefined(eattacker) || is_axis && !isPlayer(eattacker) && (!isDefined(eattacker.owner) || !isPlayer(eattacker.owner))) {
      continue;
    }

    if(isDefined(self.mgturret)) {
      self notify("pause_move");
    } else if(isDefined(self.drone_base)) {
      self.drone_base notify("pause_move");
    }

    function_76b97d7b11066363();
    thread function_25586d738b30af98(eattacker);

    if(self.clip.fake_health <= 0) {
      self.health = 1;
    }

    scripts\cp\damagefeedback::process_damage_feedback(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vdir, vdir, spartname, undefined, self);
  }
}

function function_c5d04118503d4ea7(idamage) {
  return self.clip.fake_health <= 0;
}

function function_76b97d7b11066363() {
  if(istrue(level.var_7ae7ccff11823a4b)) {
    level.var_7ae7ccff11823a4b = 0;
  }
}

function function_25586d738b30af98(eattacker) {
  self notify("new_damage");
  self endon("new_damage");
  self.last_damaged_by = eattacker;
  self.last_damaged_time = gettime();
  wait 5;
  self.last_damaged_by = undefined;
  self.last_damaged_time = undefined;
}

function watch_for_death() {
  self endon("death");

  while(true) {
    if(self.clip.fake_health <= 0 || self.health <= 0) {
      if(is_equal(level.drone_attacking_player, self)) {
        level.drone_attacking_player = undefined;
      }

      if(isPlayer(self.last_damaged_by)) {
        level thread namespace_6edc30873082da43::function_1497fbfc6507c390();
      }

      if(istrue(level.var_f753d22ae87b557b) || istrue(self.var_8d8144287647fbc5)) {
        thread bomb_explode();
      } else {
        thread kill_drone();
      }
    }

    wait 0.1;
  }
}

function function_94d8111112ffc480() {
  self endon("death");
  level endon("game_ended");
  level endon("end_drone_encounter");
  self endon("stop_dive_bomb");
  dist = self.var_22bae4a863898ca6;
  dist_sq = dist * dist;

  while(true) {
    enemy_list = function_eac4117ecb82b75e();

    for(i = 0; i < enemy_list.size; i++) {
      if(isPlayer(enemy_list[i]) && enemy_list[i] isswimunderwater() && !function_3ff5fa5cffdd0aa8(enemy_list[i])) {
        continue;
      }

      if(isDefined(level.var_3b24acb8a1c0031d)) {
        if(gettime() < level.var_3b24acb8a1c0031d + 250) {
          continue;
        }
      }

      if(distancesquared(enemy_list[i].origin, self.origin) < dist_sq) {
        if(is_equal(level.drone_attacking_player, self)) {
          level.drone_attacking_player = undefined;
        }

        level notify("drone_exploded_on_proximity", self);
        thread bomb_explode();
      }
    }

    wait 0.1;
  }
}

function bomb_explode() {
  if(!isDefined(self) || is_dead_or_dying(self) || istrue(self.exploding)) {
    return;
  }

  level.activekillstreaks = array_remove(level.activekillstreaks, self);
  level.var_3b24acb8a1c0031d = gettime();
  self.exploding = 1;
  self.var_cefcafdecc575902 = 1;
  player_range = 170;
  drone_range = getdvarfloat(@ "hash_e16c68f05c21521c", 275);
  var_3c27a8da881baab2 = drone_range * drone_range;
  armorhealth = level.players[0].maxarmorhealth;
  min_dam = int(armorhealth * 0.05);
  med_dam = int(armorhealth * 0.125);
  max_dam = int(armorhealth * 0.3);

  if(scripts\cp\cp_gameskill::function_f8448fd91abb54c8()) {
    min_dam = int(armorhealth * 0.2);
    med_dam = int(armorhealth * 0.4);
    max_dam = int(armorhealth * 0.65);
  }

  weapon_name = "assault_drone_mp";
  type = "MOD_EXPLOSIVE";
  thread function_5eafe20e3889d3a9(var_3c27a8da881baab2);

  if(istrue(self.var_aea7973ab15d030f)) {
    glassradiusdamage(self.origin, player_range, 25, 50);
    min_dam = 0;
    max_dam = 0;
    player_range = 0;
    flag_set("mansion_window_theatrics");
  }

  self radiusdamage(self.origin, player_range, max_dam, min_dam, undefined, type, weapon_name);
  level thread function_28cb88cb0ccbffed(self.origin, player_range);
  level thread function_f33c56cd33b96d7a(self.origin, player_range * 0.2, min_dam);
  var_e7a08f629e00c5b7 = self.origin;
  thread kill_drone();

  if(istrue(level.var_f753d22ae87b557b)) {
    var_3e3af5dc3694a80c = level.drone_turrets;
    var_3e3af5dc3694a80c = sortbydistance(var_3e3af5dc3694a80c, var_e7a08f629e00c5b7);

    foreach(other_drone in var_3e3af5dc3694a80c) {
      if(!isent(other_drone)) {
        continue;
      }

      if(other_drone == self) {
        continue;
      }

      if(istrue(other_drone.exploding)) {
        continue;
      }

      if(istrue(self.var_aea7973ab15d030f)) {
        continue;
      }

      range = istrue(self.var_8d8144287647fbc5) ? var_3c27a8da881baab2 * getdvarfloat(@ "hash_22deb493408f6d10", 0.2) : var_3c27a8da881baab2;

      if(distancesquared(var_e7a08f629e00c5b7, other_drone.origin) > range) {
        continue;
      }

      wait getdvarfloat(@ "hash_9177219698f61b83", 0.5);

      if(istrue(other_drone.exploding)) {
        continue;
      }

      other_drone thread bomb_explode();
    }
  }

  level notify("bomb_drone_explode", var_e7a08f629e00c5b7, player_range, min_dam, max_dam);
}

function function_5eafe20e3889d3a9(var_3c27a8da881baab2) {
  c4 = spawn("script_model", self.origin);
  c4 setModel("tag_origin_drone_explosion_cp");
  c4 setscriptablepartstate("effects", "explodeAir");
  wait 1;
  c4 delete();
}

function function_f33c56cd33b96d7a(origin, radius, damage) {
  players = [];

  if(isDefined(origin) && isDefined(radius)) {
    players = getplayersinradius(origin, radius);
  }

  foreach(player in players) {
    if(isDefined(player) && isPlayer(player) && isDefined(damage) && isDefined(origin)) {
      player dodamage(damage, origin, undefined, undefined, "MOD_EXPLOSIVE", "assault_drone_mp");
    }
  }
}

function function_28cb88cb0ccbffed(origin, radius) {
  level endon("game_ended");
  radius += 500;
  players = give_all_players_nearby(origin, radius * radius);
  wait 3;

  foreach(player in players) {
    if(!isPlayer(player)) {
      continue;
    }

    if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(scripts\cp\laststand::isinlaststand(player)) {
      continue;
    }

    player notify("force_regeneration");
  }
}

function kill_drone() {
  if(istrue(self.drone_dying)) {
    return;
  }

  self.drone_dying = 1;
  explode_fx();

  if(isDefined(self.clip.fake_health) && self.clip.fake_health > 0) {
    self.clip dodamage(9999, self.origin, self);
  }

  level.drone_turrets = array_remove(level.drone_turrets, self);
  level.vehicle_ai_script_models = array_remove(level.vehicle_ai_script_models, self);
  self.var_db46c7d01ee9223f.drones = array_remove(self.var_db46c7d01ee9223f.drones, self);
  self freeentitysentient();
  refs = [self.clip, self];
  level thread function_34a36f44dd3b1ea9(refs);

  if(isDefined(self.clip)) {
    if(issentient(self.clip)) {
      self.clip freeentitysentient();
    }

    self.clip notify("death");
    self.clip delete();
  }

  if(isDefined(self.node_grid)) {
    self.node_grid = undefined;
  }

  var_34a9757868bb0162 = self;

  if(isDefined(var_34a9757868bb0162) && isent(var_34a9757868bb0162)) {
    if(isDefined(var_34a9757868bb0162)) {
      var_34a9757868bb0162 delete();
    }
  }

  waitframe();

  if(isDefined(var_34a9757868bb0162) && isent(var_34a9757868bb0162)) {
    var_34a9757868bb0162 notify("death");
    var_34a9757868bb0162 delete();
  }
}

function explode_fx() {
  playFX(getfx("drone_turret_explode"), self.origin);
  self playSound("cp_bomb_drone_death");
}

function function_eac4117ecb82b75e() {
  enemy_list = get_array_of_valid_players();

  if(self.team == "allies") {
    enemy_list = getaiarray("axis");
  }

  if(isDefined(self.var_3589a53ab80793c7)) {
    enemy_list[enemy_list.size] = self.var_3589a53ab80793c7;
  }

  return enemy_list;
}

function function_1ef2364d60a8af83(struct, radius_override) {
  level endon("game_ended");
  radius = 800;

  if(isDefined(radius_override)) {
    radius = radius_override;
  }

  radius_sq = radius * radius;

  if(!isDefined(struct)) {
    return;
  }

  while(true) {
    nearby_player = struct get_closest_living_player(radius_sq);

    if(isDefined(nearby_player)) {
      level.var_8d1cb2f62ce55c8a = nearby_player;
      wait randomfloatrange(3, 6);
    } else {
      level.var_8d1cb2f62ce55c8a = undefined;
    }

    wait 0.5;
  }
}

function function_53747f8ce3d99087() {
  self endon("death");
  level endon("game_ended");
  level endon("end_drone_encounter");
  var_a395b21f16f97ccf = 0;

  while(true) {
    if(isDefined(self.var_8534d2048fa254a3) && self.origin == self.var_8534d2048fa254a3) {
      var_a395b21f16f97ccf += 1;
    }

    self.var_8534d2048fa254a3 = self.origin;

    if(var_a395b21f16f97ccf == 2) {
      if(!isDefined(level.var_452ebc20a68aa0f0)) {
        level.var_452ebc20a68aa0f0 = 0;
      }

      level.var_452ebc20a68aa0f0++;

      if(isDefined(self.current_node)) {
        if(isDefined(self.current_node.target)) {
          target_struct = getStruct(self.current_node.target, "targetname");

          if(isDefined(target_struct) && isDefined(target_struct.open) && target_struct.open == 0) {
            target_struct.open = 1;
          }
        }
      }

      self.re_path = 1;
    }

    if(var_a395b21f16f97ccf > 6) {
      if(!isDefined(level.var_7e0160e361500662)) {
        level.var_7e0160e361500662 = 0;
      }

      level.var_7e0160e361500662++;

      thread kill_drone();
    }

    wait 2.5;
  }
}

function function_d222480796864019() {
  self endon("death");
  level endon("game_ended");
  level endon("end_drone_encounter");

  while(istrue(level.var_7ae7ccff11823a4b) || !flag("Player_detected")) {
    wait 1;
  }

  var_a395b21f16f97ccf = 0;

  while(true) {
    wait 1.5;

    if(self.var_db46c7d01ee9223f.role == "defense") {
      var_a395b21f16f97ccf = 0;
      continue;
    }

    if(isDefined(self.var_a0790d172d45f316) && isDefined(self.current_node) && isDefined(self.current_node.origin) && self.current_node.origin == self.var_a0790d172d45f316) {
      var_a395b21f16f97ccf += 1;
    } else {
      var_a395b21f16f97ccf = int(max(0, var_a395b21f16f97ccf - 1));
    }

    if(isDefined(self.current_node) && isDefined(self.current_node.origin)) {
      self.var_a0790d172d45f316 = self.current_node.origin;
    }

    if(!isDefined(self.current_node)) {
      if(isDefined(self.node_grid)) {
        closest_node = getclosest(self.origin, self.node_grid);
        self.current_node = closest_node;
      }
    }

    if(var_a395b21f16f97ccf > 2) {
      diveBombing = 0;

      foreach(drone in self.var_db46c7d01ee9223f.drones) {
        diveBombing = istrue(drone.var_8d8144287647fbc5);

        if(diveBombing) {
          break;
        }
      }

      if(diveBombing) {
        continue;
      }

      if(drone_turret_canseetarget(level.player, (0, 0, 0), self, 8, 1)) {
        if(!isDefined(level.var_58bd9d1e7901ba30)) {
          level.var_58bd9d1e7901ba30 = 0;
        }

        level.var_58bd9d1e7901ba30++;

        self.var_3589a53ab80793c7 = spawnStruct();
        self.var_3589a53ab80793c7.origin = level.player.origin;
        self setlookatent(level.player);
      } else if(var_a395b21f16f97ccf > 4) {
        start_pos = self.origin;
        exclude = self;
        dyn_node = spawnStruct();
        dyn_node.origin = self.origin;
        var_a49fe39fe684c761 = sighttracepassed(self.origin + (0, 0, 18), level.player getEye(), 0, self);

        if(var_a49fe39fe684c761) {
          new_pos = (self.origin + level.player.origin) * 0.5;
          path = scripts\cp\astar::function_845fd743c0fadc39(self.node_grid, start_pos, new_pos, self, dyn_node, 500);

          if(isDefined(path)) {
            self.path_data = path;
            continue;
          } else {
            offset = 100;
            var_a49fe39fe684c761 = sighttracepassed(self.origin + (0, 0, offset), level.player getEye(), 0, self);

            while(!var_a49fe39fe684c761 && offset > -50) {
              offset -= 10;
            }

            self vehicle_setspeed(self.base_speed * 0.5, self.base_speed * 0.2, self.base_speed * 0.95);
            thread update_goal_pos(new_pos, (0, 0, 100));
          }
        } else {
          node_array = sortbydistancecullbyradius(self.node_grid, self.origin + randomvectorrange(-100, 100), 400);
          var_bf69efb8bf208747 = array_random(node_array);

          if(!isDefined(var_bf69efb8bf208747)) {
            function_9ab4de075453475b();
          } else {
            start_pos = self.origin;
            exclude = self;
            dyn_node = spawnStruct();
            dyn_node.origin = self.origin;
            path = scripts\cp\astar::function_845fd743c0fadc39(self.node_grid, start_pos, var_bf69efb8bf208747.origin, self, dyn_node, 500);
            self.path_data = default_to(path, self.path_data);
          }
        }
      }

      if(var_a395b21f16f97ccf > 10) {
        if(!isDefined(level.var_2bb6dd8f3f3f19a)) {
          level.var_2bb6dd8f3f3f19a = 0;
        }

        level.var_2bb6dd8f3f3f19a++;

        thread kill_drone();
      }
    }
  }
}

function function_18871f933340b91b(var_8d20a2cd0457e5b1) {
  if(!isDefined(level.drone_turrets)) {
    return;
  }

  var_f00f10160eacb571 = level.drone_turrets;

  for(i = 0; i < var_f00f10160eacb571.size; i++) {
    drone = var_f00f10160eacb571[i];

    if(!isDefined(drone) || !isent(drone)) {
      continue;
    }

    if(!isDefined(drone.swarm_id)) {
      continue;
    }

    if(isDefined(drone.clip) && drone.clip.fake_health <= 0) {
      continue;
    }

    if(isDefined(var_8d20a2cd0457e5b1)) {
      var_5c266234f3e3ad4e = 0;

      foreach(player in level.players) {
        if(distance(drone.origin, player.origin) < var_8d20a2cd0457e5b1) {
          var_5c266234f3e3ad4e = 1;
        }
      }

      if(var_5c266234f3e3ad4e) {
        continue;
      }
    }

    wait randomfloatrange(0.2, 0.55);
    drone thread kill_drone();
  }
}
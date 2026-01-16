/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\see2_drones.gsc
*****************************************************/

#include maps\_anim;
#include maps\_utility;
#include common_scripts\utility;
#include maps\pel2_util;
#include maps\_vehicle_utility;

main() {
  character\char_rus_r_rifle::precache();
  character\char_ger_wrmcht_k98::precache();
  character\char_rus_h_reznov_coat::precache();
  character\char_rus_p_chernova::precache();
  precacheModel("vehicle_rus_tracked_t34");
  level.drone_spawnFunction["allies"] = character\char_rus_r_rifle::main;
  level.drone_spawnFunction["axis"] = character\char_ger_wrmcht_k98::main;
  level.droneCustomDeath = ::see2_drone_death;
  maps\_drones::init();
  level._effect["water_exploder"] = loadfx("weapon/tank/fx_tank_water");
  level._effect["dirt_exploder"] = loadfx("weapon/tank/fx_tank_dirt");
  level._effect["dummy_tank_fire"] = loadfx("weapon/muzzleflashes/fx_tank_t34_fire_flash");
  level._effect["dummy_tank_explode"] = loadfx("explosions/large_vehicle_explosion");
  level.num_drone_areas = 3;
  custom_level_run_cycles();
  see2_droneanim_init();
  level thread init_drone_manager();
  level thread start_drone_waves();
}

#using_animtree("fakeshooters");

custom_level_run_cycles() {
  level.drone_run_cycle["run_deep_a"] = % ai_run_deep_water_a;
  level.drone_run_cycle["run_deep_b"] = % ai_run_deep_water_b;
  level.drone_trigger_spawn_time = 3;
}

wait_for_kill_trigger(areaNum) {
  while (1) {
    self waittill("trigger", guy);
    if(isPlayer(guy)) {
      break;
    }
  }
  level.valid[areaNum] = false;
}

wait_for_master_trigger(areaNum) {
  while (1) {
    self waittill("trigger", guy);
    if(isPlayer(guy)) {
      break;
    }
  }
  level.valid[areaNum] = true;
}

start_drone_waves() {
  level.trigger_arrays = [];
  level.valid = [];
  for (i = 1; i <= level.num_drone_areas; i++) {
    level thread do_random_explosions(i);
    level thread do_random_smoke(i);
    master_trigger = getEnt("area " + i + " master drone trigger", "script_noteworthy");
    master_trigger thread wait_for_master_trigger(i);
    level.trigger_arrays[i] = getEntArray("area " + i + " drone trigger", "script_noteworthy");
    level.valid[i] = false;
    kill_trigger = getEnt("area " + i + " drone kill trigger", "script_noteworthy");
    kill_trigger thread wait_for_kill_trigger(i);
  }
  level waittill("controls_active");
  if(get_players().size > 1) {
    return;
  }
  min_time_between_waves = 1;
  max_time_between_waves = 4;
  for (i = 1; i < level.num_drone_areas; i++) {
    for (j = 0; j < level.trigger_arrays[i].size; j++) {
      level.trigger_arrays[i][j].cooldown_timer = 0;
      level.trigger_arrays[i][j] thread do_cooldown();
    }
  }
  while (1) {
    players = get_players();
    for (k = 1; k <= level.num_drone_areas; k++) {
      if(!level.valid[k]) {
        continue;
      }
      loop_size = level.trigger_arrays[k].size;
      loop_size = level.trigger_arrays[k].size - 2;
      for (m = 0; m < loop_size; m++) {
        level.trigger_arrays[k][m] notify("trigger");
        wait_network_frame();
      }
    }
    wait(randomfloatrange(min_time_between_waves, max_time_between_waves));
  }
}

do_cooldown() {
  self endon("kill drones");
  while (1) {
    if(isDefined(self.cooldown_timer) && self.cooldown_timer > 0) {
      self.cooldown_timer -= 0.05;
    }
    wait(0.05);
  }
}

find_best_drone_triggers(num) {
  best_dist = 10000000000;
  best_trigger = undefined;
  worst_dist = 0;
  worst_trigger = undefined;
  return_array = [];
  for (i = 0; i < level.drone_triggers.size; i++) {
    if(!isDefined(level.drone_triggers[i].cooldown_timer) || level.drone_triggers[i].cooldown_timer <= 0) {
      dist = distanceSquared(level.drone_triggers[i].origin, level.centroid);
      if(dist < best_dist) {
        best_dist = dist;
        best_trigger = level.drone_triggers[i];
      }
      if(return_array.size < num || dist < worst_dist) {
        if(return_array.size == num) {
          return_array = array_remove(return_array, worst_trigger);
          return_array = array_add(return_array, level.drone_triggers[i]);
          worst_trigger = get_worst_drone_trigger(return_array);
          worst_dist = distanceSquared(worst_trigger.origin, level.centroid);
        } else {
          return_array = array_add(return_array, level.drone_triggers[i]);
        }
        if(dist > worst_dist) {
          worst_dist = dist;
          worst_trigger = level.drone_triggers[i];
        }
      }
    }
  }
  return return_array;
}

get_worst_drone_trigger(array) {
  worst_dist = 0;
  worst_trigger = undefined;
  for (i = 0; i < array.size; i++) {
    dist = distanceSquared(array[i].origin, level.centroid) > worst_dist;
    if(dist) {
      worst_dist = dist;
      worst_trigger = array[i];
    }
  }
  return worst_trigger;
}

remove_drone_triggers(remove_id) {
  remove_list = [];
  for (i = 0; i < level.drone_triggers.size; i++) {
    if(level.drone_triggers[i].script_string == remove_id) {
      remove_list = array_add(remove_list, level.drone_triggers[i]);
    }
  }
  for (j = 0; j < remove_list.size; j++) {
    level.drone_triggers = array_remove(level.drone_triggers, remove_list[j]);
    remove_list[j] notify("kill drones");
    remove_list[j] delete();
  }
}

do_random_explosions(wave) {
  level endon("stop wave " + wave);
  exploder_array = getEntArray("exploder wave" + wave, "script_noteworthy");
  while (1) {
    if(!isDefined(exploder_array) || exploder_array.size < 1) {
      break;
    }
    rand = randomintrange(2, 5);
    wait(rand);
    if(!level.valid[wave]) {
      continue;
    }
    rand = randomint(exploder_array.size - 1);
    if(exploder_array[rand].targetname == "dirt_exploder") {
      playfx(level._effect["dirt_exploder"], exploder_array[rand].origin);
    } else {
      playfx(level._effect["water_exploder"], exploder_array[rand].origin);
    }
    radiusDamage(exploder_array[rand].origin, 500, 500, 500);
  }
}

do_random_smoke(wave) {
  smoke_array = getEntArray("smoke wave" + wave, "script_noteworthy");
  for (i = 0; i < smoke_array.size; i++) {
    smoke_array[i] thread do_smoke_at_intervals(wave);
  }
}

do_smoke_at_intervals(wave) {
  level endon("stop wave " + wave);
  wait(randomintrange(1, 22));
  while (1) {
    if(level.valid[wave]) {
      playfx(level._effect["drone_smoke"], self.origin);
    }
    rand = randomintrange(25, 30);
    wait(rand);
  }
}

do_dummy_vehicles(wave, model, maxTimeBeforeDestroy, minSpeed, maxSpeed, staggerAmt) {
  level.vehicle_starts = GetEntArray("wave" + wave + " tank start", "script_noteworthy");
  level.valid_path = [];
  for (i = 0; i < level.vehicle_starts.size; i++) {
    level.valid_path = array_add(level.valid_path, true);
    thread do_single_dummy_vehicle(i, model, maxTimeBeforeDestroy, minSpeed, maxSpeed, staggerAmt);
    wait_network_frame();
  }
  level.static_vehicles = GetEntArray("wave" + wave + " dummy tank", "script_noteworthy");
  for (i = 0; i < level.static_vehicles.size; i++) {
    level.static_vehicles[i] thread do_single_static_dummy_vehicle(model, maxTimeBeforeDestroy);
    wait_network_frame();
  }
}

do_single_static_dummy_vehicle(model, maxTimeBeforeDestroy) {
  self endon("destroy dummy vehicle");
  myModel = spawn("script_model", groundpos(self.origin));
  myModel setModel(model);
  myModel.angles = self.angles;
  self thread wait_for_destroy(maxTimeBeforeDestroy, myModel);
  while (1) {
    wait(randomint(6, 10));
    playfxontag(level._effect["dummy_tank_fire"], myModel, "tag_flash");
  }
}

wait_for_destroy(maxTimeBeforeDestroy, model) {
  if(maxTimeBeforeDestroy < 60) {
    maxTimeBeforeDestroy = 60;
  }
  wait(randomfloat(59, maxTimeBeforeDestroy));
  playfx(level._effect["dummy_tank_explode"], model.origin);
  model setModel(model.model + "_dmg");
  self notify("destroy dummy vehicle");
}

#using_animtree("see2_models");

do_single_dummy_vehicle(pathnum, model, maxTimeBeforeDestroy, minSpeed, maxSpeed, staggerAmt) {
  wait(randomfloat(staggerAmt));
  speed = randomfloatrange(minSpeed, maxSpeed);
  time = 0;
  toNode = GetEnt(level.vehicle_starts[pathnum].target, "targetname");
  fromNode = level.vehicle_starts[pathnum];
  toVec = toNode.origin - fromNode.origin;
  myModel = spawn("script_model", fromNode.origin + (0, 0, 15));
  myModel.angles = vectortoangles(toVec);
  myModel setModel(model);
  myModel.animname = "dummy";
  myModel setAnimTree();
  myModel notify("stop anim");
  myModel play_vehicle_anim("tank_scan_straight");
  myModel thread do_fake_firing();
  self thread run_timer(time);
  while (level.valid_path[pathnum]) {
    if(isDefined(fromNode.target)) {
      toNode = GetEnt(fromNode.target, "targetname");
      if(isDefined(fromNode.script_string)) {
        myModel notify("stop anim");
        myModel play_vehicle_anim(fromNode.script_string);
      }
    } else {
      toNode = level.vehicle_starts[pathnum];
    }
    maxTime = distance(fromNode.origin, toNode.origin) / speed;
    goalAngles = vectortoangles(toNode.origin - fromNode.origin);
    if(toNode != level.vehicle_starts[pathnum]) {
      myModel.goalAngles = myModel.angles;
      myModel thread smoothOrient(0.1);
      myModel thread lerpToPos(toNode.origin, speed, maxTime);
      myModel waittill("continue");
    } else {
      myModel delete();
      myModel notify("stop lerping");
      wait(1);
      myModel = spawn("script_model", toNode.origin);
      myModel setModel(model);
      myModel.angles = VectorToAngles(GetEnt(toNode.target, "targetname").origin - toNode.origin);
      myModel.animname = "dummy";
      myModel setAnimTree();
      myModel notify("stop anim");
      myModel play_vehicle_anim("tank_scan_straight");
      myModel thread do_fake_firing();
      wait(0.05);
    }
    if(time > maxTimeBeforeDestroy) {
      destroyDummyVehicle(pathnum, model, myModel);
    } else {
      percentToDestroy = time / maxTimeBeforeDestroy;
      rand = randomfloat(1);
      if(percentToDestroy > rand) {
        destroyDummyVehicle(pathnum, model, myModel);
      } else {
        fromNode = toNode;
      }
    }
  }
}

play_vehicle_anim(anime) {
  self endon("stop anim");
  self SetFlaggedAnimKnobRestart("blend_anim" + anime, level.scr_anim[self.animname][anime], 1, 0.2, 1);
  self waittillmatch("blend_anim" + anime, "end");
}

do_fake_firing() {
  while (isDefined(self)) {
    playfxontag(level._effect["dummy_tank_fire"], self, "tag_flash");
    wait(randomint(6, 10));
  }
}

destroyDummyVehicle(pathnum, model, origin) {}
smoothOrient(max_dev_per_frame) {
  self endon("stop lerping");
  while (1) {
    if(self.angles == self.goalAngles) {
      wait(0.05);
      continue;
    } else {
      normGoalAngles = angle_normalize180(self.goalAngles);
      normAngles = angle_normalize180(self.angles);
      diff1 = self.goalAngles - self.angles;
      normGoalAngles = (normGoalAngles[0], normGoalAngles[1], normGoalAngles[2]);
      normAngles = (normAngles[0], normAngles[1], normAngles[2]);
      diff2 = normGoalAngles - normAngles;
      finalDiff = [];
      for (i = 0; i < 3; i++) {
        if(abs(diff1[i]) < abs(diff2[i])) {
          finalDiff = array_add(finalDiff, diff1[i]);
        } else {
          finalDiff = array_add(finalDiff, diff2[i]);
        }
      }
      if(abs(finalDiff[0]) > max_dev_per_frame) {
        if(finalDiff[0] > 0) {
          self.angles = (self.angles[0] + max_dev_per_frame, self.angles[1], self.angles[2]);
        } else {
          self.angles = (self.angles[0] - max_dev_per_frame, self.angles[1], self.angles[2]);
        }
      } else {
        self.angles = (self.goalAngles[0], self.angles[1], self.angles[2]);
      }
      if(abs(finalDiff[1]) > max_dev_per_frame) {
        if(finalDiff[1] > 0) {
          self.angles = (self.angles[0], self.angles[1] + max_dev_per_frame, self.angles[2]);
        } else {
          self.angles = (self.angles[0], self.angles[1] - max_dev_per_frame, self.angles[2]);
        }
      } else {
        self.angles = (self.angles[0], self.goalAngles[1], self.angles[2]);
      }
      if(abs(finalDiff[2]) > max_dev_per_frame) {
        if(finalDiff[2] > 0) {
          self.angles = (self.angles[0], self.angles[1], self.angles[2] + max_dev_per_frame);
        } else {
          self.angles = (self.angles[0], self.angles[1], self.angles[2] - max_dev_per_frame);
        }
      } else {
        self.angles = (self.angles[0], self.angles[1], self.goalAngles[2]);
      }
      wait(0.05);
    }
  }
}

lerpToPos(goalPos, speed, maxTime) {
  self endon("stop lerping");
  startPos = self.origin;
  toVec = goalPos - self.origin;
  toVec = vectorNormalize(toVec);
  time = 0;
  while (1) {
    scaled_move = (toVec[0] * speed * 0.05, toVec[1] * speed * 0.05, toVec[2] * speed * 0.05);
    self.origin += scaled_move;
    self.origin = groundpos(self.origin + (0, 0, 100));
    proj_loc = self.origin + scaled_move + (0, 0, 100);
    self.goalAngles = vectorToAngles(groundpos(proj_loc) - self.origin);
    wait(0.05);
    time += 0.05;
    if(vec_approx_equals(self.origin, startPos, goalPos, 0.05) || time > maxTime) {
      self notify("continue");
      break;
    }
  }
}

vec_approx_equals(vec, vec1, vec2, diff) {
  if(abs(vec[0] - vec2[0]) <= abs(vec1[0] - vec2[0]) * diff) {
    if(abs(vec[1] - vec2[1]) <= abs(vec1[1] - vec2[1]) * diff) {
      if(abs(vec[2] - vec2[2]) <= abs(vec1[2] - vec2[2]) * diff) {
        return true;
      }
    }
  }
  return false;
}

run_timer(time) {
  wait(0.05);
  time += 0.05;
}

angle_normalize180(angles) {
  retAngles = [];
  for (i = 0; i < 3; i++) {
    scaledAngle = angles[i] * (1.0 / 360.0);
    if((scaledAngle + 0.5) > 1) {
      floor = 1;
    } else {
      floor = 0;
    }
    retAngles[i] = (scaledAngle - floor) * 360.0;
  }
  return retAngles;
}

#using_animtree("generic_human");

see2_droneanim_init() {
  level.drone_anims["stand"]["idle"] = % drone_stand_idle;
  level.drone_anims["stand"]["run"] = % drone_stand_run;
  level.drone_anims["stand"]["reload"] = % exposed_crouch_reload;
  level.drone_anims["stand"]["death"] = [];
  level.drone_anims["stand"]["death"][0] = % drone_stand_death;
  level.drone_anims["stand"]["death"][1] = % death_explosion_up10;
  level.drone_anims["stand"]["death"][2] = % death_explosion_back13;
  level.drone_anims["stand"]["death"][3] = % death_explosion_forward13;
  level.drone_anims["stand"]["death"][4] = % death_explosion_left11;
  level.drone_anims["stand"]["death"][5] = % death_explosion_right13;
  level.drone_anims["stand"]["death"][6] = % ch_pby_explosion_back;
  level.drone_anims["stand"]["death"][7] = % ch_pby_explosion_front;
  level.drone_anims["stand"]["death"][8] = % ch_pby_explosion_right;
  level.drone_anims["stand"]["death"][9] = % ch_pby_explosion_left;
}

see2_drone_death() {
  self endon("no_drone_death_thread");
  if(!isDefined(level.drone_death_queue)) {
    ASSERT(false, "The drone death manager has not been inited");
  }
  drone = self;
  damage_type = self;
  damage_ori = self;
  death_index = 0;
  while (isDefined(drone)) {
    drone waittill("damage", amount, attacker, damage_dir, damage_ori, damage_type);
    if(drone.health <= 0) {
      break;
    }
    if(damage_type == "MOD_BURNED") {
      break;
    }
  }
  println(damage_type);
  if(damage_type == "MOD_PROJECTILE" || damage_type == "MOD_PROJECTILE_SPLASH") {
    drone.special_death_fx = "drone_burst";
  }
  drone unlink();
  if(damage_type == "MOD_EXPLOSIVE" || damage_type == "MOD_PROJECTILE_SPLASH") {
    index = randomint(4);
    switch (index) {
      case 0:
        death_index = 2;
        break;
      case 1:
        death_index = 3;
        break;
      case 2:
        death_index = 5;
        break;
      case 3:
        death_index = 4;
        break;
      case 4:
        death_index = 6;
        break;
      case 5:
        death_index = 7;
        break;
      case 6:
        death_index = 8;
        break;
      case 7:
        death_index = 9;
        break;
    }
    if(isDefined(drone.combust)) {
      drone thread torch_ai(0.1);
    }
  } else if(damage_type == "MOD_BURNED") {
    drone thread torch_ai(0.1);
    death_index = 0;
  } else {
    death_index = 0;
  }
  drone notify("death");
  drone stopAnimScripted();
  if(isDefined(drone.special_death_fx)) {
    drone.special_death_fx = "drone_burst";
    PlayFXOnTag(level._effect[drone.special_death_fx], drone, "J_SpineLower");
  }
  drone.need_notetrack = true;
  drone maps\_drone::drone_play_anim(level.drone_anims["stand"]["death"][death_index]);
  drone add_me_to_the_death_queue();
}

add_me_to_the_death_queue() {
  level.drone_death_queue[level.drone_death_queue.size] = self;
  level notify("drone_manager_process");
}

init_drone_manager() {
  MAX_DEAD_DRONES = 10;
  level.drone_death_queue = [];
  while (1) {
    level waittill("drone_manager_process");
    if(level.drone_death_queue.size > MAX_DEAD_DRONES) {
      while (level.drone_death_queue.size > MAX_DEAD_DRONES) {
        removed_guy = level.drone_death_queue[0];
        new_drone_queue = [];
        for (i = 1; i < (level.drone_death_queue.size); i++) {
          new_drone_queue[i - 1] = level.drone_death_queue[i];
        }
        if(isDefined(removed_guy)) {
          removed_guy Delete();
        }
        level.drone_death_queue = new_drone_queue;
      }
    }
  }
}

torch_ai(delay) {
  tagArray = [];
  tagArray[tagArray.size] = "J_Wrist_RI";
  tagArray[tagArray.size] = "J_Wrist_LE";
  tagArray[tagArray.size] = "J_Elbow_LE";
  tagArray[tagArray.size] = "J_Elbow_RI";
  tagArray[tagArray.size] = "J_Knee_RI";
  tagArray[tagArray.size] = "J_Knee_LE";
  tagArray[tagArray.size] = "J_Ankle_RI";
  tagArray[tagArray.size] = "J_Ankle_LE";
  tagArray = maps\_utility::array_randomize(tagArray);
  for (i = 0; i < 3; i++) {
    PlayFxOnTag(level._effect["character_fire_death_sm"], self, tagArray[i]);
    if(isDefined(delay)) {
      wait(delay);
    }
  }
  PlayFxOnTag(level._effect["character_fire_death_torso"], self, "J_SpineLower");
}
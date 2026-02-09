/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_plane_weapons.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;

main() {}
build_bomb_explosions(type, quakepower, quaketime, quakeradius, range, min_damage, max_damage) {
  if(!isDefined(level.plane_bomb_explosion)) {
    level.plane_bomb_explosion = [];
  }
  AssertEx(isDefined(quakepower), "_plane_weapons::build_bomb_explosions(): no quakepower specified!");
  AssertEx(isDefined(quaketime), "_plane_weapons::build_bomb_explosions(): no quaketime specified!");
  AssertEx(isDefined(quakeradius), "_plane_weapons::build_bomb_explosions(): no quakeradius specified!");
  AssertEx(isDefined(range), "_plane_weapons::build_bomb_explosions(): no range specified!");
  AssertEx(isDefined(min_damage), "_plane_weapons::build_bomb_explosions(): no min_damage specified!");
  AssertEx(isDefined(max_damage), "_plane_weapons::build_bomb_explosions(): no max_damage specified!");
  struct = spawnStruct();
  struct.quakepower = quakepower;
  struct.quaketime = quaketime;
  struct.quakeradius = quakeradius;
  struct.range = range;
  struct.mindamage = min_damage;
  struct.maxdamage = max_damage;
  level.plane_bomb_explosion[type] = struct;
}
build_bombs(type, bombmodel, bombfx, bomb_sound) {
  AssertEx(isDefined(type), "_plane_weapons::build_bombs(): no vehicletype specified!");
  AssertEx(isDefined(bombmodel), "_plane_weapons::build_bombs(): no bomb model specified!");
  AssertEx(isDefined(bombfx), "_plane_weapons::build_bombs(): no bomb explosion FX specified!");
  AssertEx(isDefined(bomb_sound), "_plane_weapons::build_bombs(): no bomb explosion sound specified!");
  if(!isDefined(level.plane_bomb_model)) {
    level.plane_bomb_model = [];
  }
  if(!isDefined(level.plane_bomb_model[type])) {
    level.plane_bomb_model[type] = bombmodel;
  }
  if(!isDefined(level.plane_bomb_fx)) {
    level.plane_bomb_fx = [];
  }
  if(!isDefined(level.plane_bomb_fx[type])) {
    fx = LoadFx(bombfx);
    level.plane_bomb_fx[type] = fx;
  }
  if(!isDefined(level.plane_bomb_sound)) {
    level.plane_bomb_sound = [];
  }
  if(!isDefined(level.plane_bomb_sound[type])) {
    level.plane_bomb_sound[type] = bomb_sound;
  }
}
bomb_init(bomb_count) {
  errormsg = "Can't find the bomb model for this vehicletype. Check your vehicle's script file; you may need to call its setup_bombs function.";
  AssertEx(isDefined(level.plane_bomb_model[self.vehicletype]), errormsg);
  errormsg = "Can't find the bomb explosion fx for this vehicletype. Check your vehicle's script file; you may need to call its setup_bombs function.";
  AssertEx(isDefined(level.plane_bomb_fx[self.vehicletype]), errormsg);
  errormsg = "Can't find the bomb explosion sound for this vehicletype. Check your vehicle's script file; you may need to call its setup_bombs function.";
  AssertEx(isDefined(level.plane_bomb_sound[self.vehicletype]), errormsg);
  self.bomb_count = bomb_count;
  if(bomb_count > 0) {
    self thread attach_bombs();
    self thread drop_bombs_waittill();
    self thread bomb_drop_end();
  }
}
drop_bombs_waittill() {
  self endon("death");
  self endon("reached_end_node");
  while(1) {
    self waittill("drop_bombs", amount, delay, delay_trace);
    drop_bombs(amount, delay, delay_trace);
  }
}
bomb_drop_end() {
  self waittill("reached_end_node");
  if(isDefined(self.bomb)) {
    for(i = 0; i < self.bomb.size; i++) {
      if(isDefined(self.bomb[i]) && !self.bomb[i].dropped) {
        self.bomb[i] Delete();
      }
    }
  }
}
attach_bombs() {
  self.bomb = [];
  bomb_tag = [];
  switch (self.model) {
    case "t5_veh_jet_mig17":
    case "t5_veh_jet_mig17_gear":
      bomb_tag[0] = "tag_left_wingtip";
      bomb_tag[1] = "tag_right_wingtip";
      break;
    default:
      bomb_tag[0] = "tag_smallbomb01left";
      bomb_tag[1] = "tag_smallbomb02left";
      bomb_tag[2] = "tag_smallbomb01right";
      bomb_tag[3] = "tag_smallbomb02right";
      bomb_tag[4] = "tag_BIGbomb";
      break;
  }
  for(i = 0; i < self.bomb_count; i++) {
    self.bomb[i] = spawn("script_model", (self.origin));
    self.bomb[i] setModel(level.plane_bomb_model[self.vehicletype]);
    self.bomb[i].dropped = false;
    if(isDefined(bomb_tag[i])) {
      self.bomb[i] LinkTo(self, bomb_tag[i], (0, 0, -4), (-10, 0, 0));
    }
  }
}
drop_bombs(amount, delay, delay_trace, trace_dist) {
  self endon("reached_end_node");
  self endon("death");
  total_bomb_count = array_removeUndefined(self.bomb).size;
  user_delay = undefined;
  new_bomb_index = undefined;
  if(!isDefined(self.bomb.size)) {
    return;
  }
  if(amount == 0) {
    return;
  }
  if(total_bomb_count <= 0) {
    println("^3_plane_weapons::drop_bombs(): Plane at " + self.origin + " with targetname " + self.targetname + " has no bombs to drop!");
    return;
  }
  if(isDefined(delay)) {
    user_delay = delay;
  }
  if(!isDefined(amount) || (amount > total_bomb_count)) {
    amount = total_bomb_count;
  }
  for(i = 0; i < amount; i++) {
    if(total_bomb_count <= 0) {
      println("^3_plane_weapons::drop_bombs(): Plane at " + self.origin + " with targetname " + self.targetname + " has no more bombs to drop!");
      return;
    }
    if((isDefined(self.bomb[i]) && self.bomb[i].dropped) || !isDefined(self.bomb[i])) {
      for(q = 0; q < self.bomb.size; q++) {
        if(isDefined(self.bomb[i + q]) && !self.bomb[i + q].dropped) {
          new_bomb_index = i + q;
          break;
        }
      }
    } else {
      new_bomb_index = i;
    }
    total_bomb_count--;
    self.bomb_count--;
    self.bomb[new_bomb_index].dropped = true;
    forward = anglesToForward(self.angles);
    vec = vector_scale(forward, self GetSpeed());
    vec_predict = self.bomb[new_bomb_index].origin + vector_scale(forward, (self GetSpeed() * 0.06));
    self.bomb[new_bomb_index] UnLink();
    self.bomb[new_bomb_index].origin = vec_predict;
    self.bomb[new_bomb_index] MoveGravity(((vec)), 10);
    self.bomb[new_bomb_index] thread bomb_wiggle();
    self.bomb[new_bomb_index] thread bomb_trace(self.vehicletype, delay_trace, trace_dist);
    if(isDefined(user_delay)) {
      delay = user_delay;
    } else {
      delay = 0.1 + RandomFloat(0.5);
    }
    wait(delay);
  }
}
bomb_wiggle() {
  self endon("death");
  original_angles = self.angles;
  while(1) {
    roll = 10 + RandomFloat(20);
    yaw = 4 + RandomFloat(3);
    time = 0.25 + RandomFloat(0.25);
    time_in_half = time / 3;
    self bomb_pitch(time);
    self RotateTo((self.pitch, (original_angles[1] + (yaw * -2)), (roll * -2)), (time * 2), (time_in_half * 2), (time_in_half * 2));
    self waittill("rotatedone");
    self bomb_pitch(time);
    self RotateTo((self.pitch, (original_angles[1] + (yaw * 2)), (roll * 2)), (time * 2), (time_in_half * 2), (time_in_half * 2));
    self waittill("rotatedone");
  }
}
bomb_pitch(time_of_rotation) {
  self endon("death");
  if(!isDefined(self.pitch)) {
    original_pitch = self.angles;
    self.pitch = original_pitch[0];
    time = 15 + RandomFloat(5);
  }
  if(self.pitch < 80) {
    self.pitch = (self.pitch + (40 * time_of_rotation));
    if(self.pitch > 80) {
      self.pitch = 80;
    }
  }
  return;
}
bomb_trace(type, delay_trace, trace_dist) {
  self endon("death");
  if(isDefined(delay_trace)) {
    wait(delay_trace);
  }
  if(!isDefined(trace_dist)) {
    trace_dist = 64;
  }
  while(1) {
    vec1 = self.origin;
    direction = anglesToForward((90, 0, 0));
    vec2 = vec1 + vector_scale(direction, 10000);
    trace_result = bulletTrace(vec1, vec2, false, undefined);
    dist = Distance(self.origin, trace_result["position"]);
    if(dist < trace_dist || dist >= 10000) {
      self thread bomb_explosion(type);
    }
    wait(0.05);
  }
}
bomb_explosion(type) {
  Assert(isDefined(level.plane_bomb_explosion[type]), "_plane_weapons::bomb_explosion(): No plane_bomb_explosion info set up for vehicletype " + type + ". Make sure to run _plane_weapons::build_bomb_explosions() first.");
  struct = level.plane_bomb_explosion[type];
  quake_power = struct.quakepower;
  quake_time = struct.quaketime;
  quake_radius = struct.quakeradius;
  damage_range = struct.range;
  max_damage = struct.mindamage;
  min_damage = struct.maxdamage;
  sound_org = spawn("script_origin", self.origin);
  sound_org playSound(level.plane_bomb_sound[type]);
  sound_org thread bomb_sound_delete();
  playFX(level.plane_bomb_fx[type], self.origin);
  Earthquake(quake_power, quake_time, self.origin, quake_radius);
  RadiusDamage(self.origin, damage_range, max_damage, min_damage);
  self Delete();
}
bomb_sound_delete() {
  wait(5);
  self Delete();
}
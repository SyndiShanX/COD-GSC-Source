/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_planeweapons.gsc
*****************************************************/

#include maps\_utility;
#include common_scripts\utility;

main() {}
build_bomb_explosions(type, quakepower, quaketime, quakeradius, range, min_damage, max_damage) {
  if(!isDefined(level.plane_bomb_explosion)) {
    level.plane_bomb_explosion = [];
  }
  AssertEx(isDefined(quakepower), "_planeweapons::build_bomb_explosions(): no quakepower specified!");
  AssertEx(isDefined(quaketime), "_planeweapons::build_bomb_explosions(): no quaketime specified!");
  AssertEx(isDefined(quakeradius), "_planeweapons::build_bomb_explosions(): no quakeradius specified!");
  AssertEx(isDefined(range), "_planeweapons::build_bomb_explosions(): no range specified!");
  AssertEx(isDefined(min_damage), "_planeweapons::build_bomb_explosions(): no min_damage specified!");
  AssertEx(isDefined(max_damage), "_planeweapons::build_bomb_explosions(): no max_damage specified!");
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
  AssertEx(isDefined(type), "_planeweapons::build_bombs(): no vehicletype specified!");
  AssertEx(isDefined(bombmodel), "_planeweapons::build_bombs(): no bomb model specified!");
  AssertEx(isDefined(bombfx), "_planeweapons::build_bombs(): no bomb explosion FX specified!");
  AssertEx(isDefined(bomb_sound), "_planeweapons::build_bombs(): no bomb explosion sound specified!");
  if(!isDefined(level.plane_bomb_model)) {
    level.plane_bomb_model = [];
  }
  if(!isDefined(level.plane_bomb_model[type])) {
    level.plane_bomb_model[type] = bombmodel;
    PrecacheModel(level.plane_bomb_model[type]);
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
  errormsg = "Can't find the bomb model for this vehicletype. Try running _planeweapons::build_bombs() to fix this!";
  AssertEx(isDefined(level.plane_bomb_model[self.vehicletype]), errormsg);
  errormsg = "Can't find the bomb explosion fx for this vehicletype. Try running _planeweapons::build_bombs() to fix this!";
  AssertEx(isDefined(level.plane_bomb_fx[self.vehicletype]), errormsg);
  errormsg = "Can't find the bomb explosion sound for this vehicletype. Try running _planeweapons::build_bombs() to fix this!";
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
  tag_l1 = "tag_smallbomb01left";
  tag_l2 = "tag_smallbomb02left";
  tag_r1 = "tag_smallbomb01right";
  tag_r2 = "tag_smallbomb02right";
  tag_c = "tag_BIGbomb";
  if(self.model == "vehicle_usa_aircraft_f4ucorsair_dist") {
    tag_l1 = "tag_bomb_left";
    tag_l2 = "tag_bomb_left";
    tag_r1 = "tag_bomb_right";
    tag_r2 = "tag_bomb_right";
    tag_c = "tag_bomb_right";
  }
  for(i = 0; i < self.bomb_count; i++) {
    self.bomb[i] = spawn("script_model", (self.origin));
    self.bomb[i] setModel(level.plane_bomb_model[self.vehicletype]);
    self.bomb[i].dropped = false;
    if(i == 0) {
      self.bomb[i] LinkTo(self, tag_l1, (0, 0, -4), (-10, 0, 0));
    } else if(i == 1) {
      self.bomb[i] LinkTo(self, tag_r1, (0, 0, -4), (-10, 0, 0));
    } else if(i == 2) {
      self.bomb[i] LinkTo(self, tag_l2, (0, 0, -4), (-10, 0, 0));
    } else if(i == 3) {
      self.bomb[i] LinkTo(self, tag_r2, (0, 0, -4), (-10, 0, 0));
    } else {
      self.bomb[i] LinkTo(self, tag_c, (0, 0, -4), (-10, 0, 0));
    }
  }
}

drop_bombs(amount, delay, delay_trace, trace_dist) {
  self endon("reached_end_node");
  self endon("death");
  total_bomb_count = self.bomb.size;
  user_delay = undefined;
  if(!isDefined(self.bomb.size)) {
    return;
  }
  if(self.bomb.size == 0 || total_bomb_count == 0) {
    println("^3_planeweapons::drop_bombs(): Plane at " + self.origin + " with targetname " + self.targetname + " has no bombs to drop!");
    return;
  }
  if(isDefined(delay)) {
    user_delay = delay;
  }
  if(isDefined(amount)) {
    if(amount == 0) {
      return;
    }
    if(amount > self.bomb_count) {
      amount = self.bomb_count;
    }
    for(i = 0; i < amount; i++) {
      if(total_bomb_count <= 0) {
        println("^3_planeweapons::drop_bombs(): Plane at " + self.origin + " with targetname " + self.targetname + " has no more bombs to drop!");
        return;
      }
      if(isDefined(self.bomb[i]) && self.bomb[i].dropped) {
        for(q = 0; q < self.bomb_count; q++) {
          if(isDefined(self.bomb[q]) && !self.bomb[q].dropped) {
            i = q;
            q = (self.bomb_count + 1);
          }
        }
      } else if(!isDefined(self.bomb[i])) {
        for(q = 0; q < self.bomb_count; q++) {
          if(isDefined(self.bomb[q]) && !self.bomb[q].dropped) {
            i = q;
            q = (self.bomb_count + 1);
          }
        }
      }
      total_bomb_count--;
      self.bomb_count--;
      self.bomb[i].dropped = true;
      forward = anglesToForward(self.angles);
      vec = vectorScale(forward, self GetSpeed());
      vec_predict = self.bomb[i].origin + vectorScale(forward, (self GetSpeed() * 0.06));
      self.bomb[i] UnLink();
      self.bomb[i].origin = vec_predict;
      self.bomb[i] MoveGravity(((vec)), 10);
      self.bomb[i] thread bomb_wiggle();
      self.bomb[i] thread bomb_trace(self.vehicletype, delay_trace, trace_dist);
      if(isDefined(user_delay)) {
        delay = user_delay;
      } else {
        delay = 0.1 + RandomFloat(0.5);
      }
      wait(delay);
    }
  } else {
    for(i = 0; i < self.bomb.size; i++) {
      if(!isDefined(self.bomb[i]) || self.bomb[i].dropped) {
        continue;
      }
      if(total_bomb_count <= 0) {
        println("^3_planeweapons::drop_bombs(): Plane at " + self.origin + " with targetname " + self.targetname + " has no bombs to drop!");
        return;
      }
      total_bomb_count--;
      self.bomb_count--;
      forward = anglesToForward(self.angles);
      vec = vectorScale(forward, self GetSpeed());
      vec_predict = self.bomb[i].origin + vectorScale(forward, (self GetSpeed() * 0.06));
      vec = ((vec[0] + (-20 + RandomFloat(40))), (vec[1] + (-20 + RandomFloat(40))), vec[2]);
      self.bomb[i] UnLink();
      self.bomb[i].origin = vec_predict;
      self.bomb[i] MoveGravity((vec), 10);
      self.bomb[i] thread bomb_wiggle();
      self.bomb[i] thread bomb_trace(self.vehicletype, delay_trace, trace_dist);
      if(isDefined(user_delay)) {
        delay = user_delay;
      } else {
        delay = 0.1 + RandomFloat(0.5);
      }
      wait(delay);
    }
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
    vec2 = vec1 + vectorScale(direction, 10000);
    trace_result = bulletTrace(vec1, vec2, false, undefined);
    dist = Distance(self.origin, trace_result["position"]);
    if(dist < trace_dist || dist >= 10000) {
      self thread bomb_explosion(type);
    }
    wait(0.05);
  }
}

bomb_explosion(type) {
  Assert(isDefined(level.plane_bomb_explosion[type]), "_planeweapons::bomb_explosion(): No plane_bomb_explosion info set up for vehicletype " + type + ". Make sure to run _planeweapons::build_bomb_explosions() first.");
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
  println("^1plane bomb goes BOOM!!! ^7( Dmg Radius: ", damage_range, " | Max Dmg: ", max_damage, " | Min Dmg: ", min_damage, " )");
  playFX(level.plane_bomb_fx[type], self.origin);
  Earthquake(quake_power, quake_time, self.origin, quake_radius);
  RadiusDamage(self.origin, damage_range, max_damage, min_damage);
  self Delete();
}

bomb_sound_delete() {
  wait(5);
  self Delete();
}
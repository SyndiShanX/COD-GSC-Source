/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\mg_penetration.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\mgturret;
#using scripts\sp\utility;
#namespace mg_penetration;

function gunner_think(turret) {
  if(!isDefined(level.shared_portable_turrets)) {
    level.shared_portable_turrets = [];
  }

  self endon("death");
  self notify("end_mg_behavior");
  self endon("end_mg_behavior");
  self.can_fire_turret = 1;
  self.wants_to_fire = 0;

  if(!use_the_turret(turret)) {
    self notify("continue_cover_script");
    return;
  }

  self.last_enemy_sighting_position = undefined;
  thread record_enemy_sightings();
  forward = anglesToForward(turret.angles);
  ent = spawn("script_origin", (0, 0, 0));
  thread target_ent_cleanup(ent);
  ent.origin = turret.origin + forward * 500;

  if(isDefined(self.last_enemy_sighting_position)) {
    ent.origin = self.last_enemy_sighting_position;
  }

  turret settargetentity(ent);
  enemy = undefined;

  for(;;) {
    if(!isalive(self.current_enemy)) {
      stop_firing();
      self waittill("new_enemy");
    }

    start_firing();
    shoot_enemy_until_he_hides_then_shoot_wall(ent);

    if(!isalive(self.current_enemy)) {
      continue;
    }

    if(self cansee(self.current_enemy)) {
      continue;
    }

    self waittill("saw_enemy");
  }
}

function target_ent_cleanup(ent) {
  waittill_either("death", "end_mg_behavior");
  ent delete();
}

function shoot_enemy_until_he_hides_then_shoot_wall(ent) {
  self endon("death");
  self endon("new_enemy");
  self.current_enemy endon("death");
  enemy = self.current_enemy;

  while(self cansee(enemy)) {
    angles = vectortoangles(enemy getEye() - ent.origin);
    angles = anglesToForward(angles);
    ent moveTo(ent.origin + angles * 12, 0.1);
    wait 0.1;
  }

  if(isPlayer(enemy)) {
    self endon("saw_enemy");
    eye = enemy getEye();
    angles = vectortoangles(eye - ent.origin);
    angles = anglesToForward(angles);
    units_per_second = 150;
    timer = distance(ent.origin, self.last_enemy_sighting_position) / units_per_second;

    if(timer > 0) {
      ent moveTo(self.last_enemy_sighting_position, timer);
      wait timer;
    }

    org = ent.origin + angles * 180;
    oldorigin = get_suppress_point(self getEye(), ent.origin, org);

    if(!isDefined(oldorigin)) {
      oldorigin = ent.origin;
    }

    ent moveTo(ent.origin + angles * 80 + (0, 0, randomfloatrange(15, 50) * -1), 3, 1, 1);
    wait 3.5;
    ent moveTo(oldorigin + angles * -20, 3, 1, 1);
  }

  wait randomfloatrange(2.5, 4);
  stop_firing();
}

function set_firing(val) {
  if(val) {
    self.can_fire_turret = 1;

    if(self.wants_to_fire) {
      self.turret notify("startfiring");
    }

    return;
  }

  self.can_fire_turret = 0;
  self.turret notify("stopfiring");
}

function stop_firing() {
  self.wants_to_fire = 0;
  self.turret notify("stopfiring");
}

function start_firing() {
  self.wants_to_fire = 1;

  if(self.can_fire_turret) {
    self.turret notify("startfiring");
  }
}

function create_mg_team() {
  if(isDefined(level.mg_gunner_team)) {
    level.mg_gunner_team[level.mg_gunner_team.size] = self;
    return;
  }

  level.mg_gunner_team = [];
  level.mg_gunner_team[level.mg_gunner_team.size] = self;
  waittillframeend();
  ent = spawnStruct();
  array_thread(level.mg_gunner_team, &mg_gunner_death_notify, ent);
  array = level.mg_gunner_team;
  level.mg_gunner_team = undefined;
  ent waittill("gunner_died");

  for(i = 0; i < array.size; i++) {
    if(!isalive(array[i])) {
      continue;
    }

    array[i] notify("stop_using_built_in_burst_fire");
    array[i] thread solo_fires();
  }
}

function mg_gunner_death_notify(ent) {
  self waittill("death");
  ent notify("gunner_died");
}

function solo_firing(mgteam) {
  mggunner = undefined;

  for(i = 0; i < mgteam.size; i++) {
    if(!isalive(mgteam[i])) {
      continue;
    }

    mggunner = mgteam[i];
    break;
  }

  if(!isDefined(mggunner)) {
    return;
  }
}

function solo_fires() {
  self endon("death");

  for(;;) {
    self.turret startfiring();
    wait randomfloatrange(0.3, 0.7);
    self.turret stopfiring();
    wait randomfloatrange(0.1, 1.1);
  }
}

function dual_firing(mgteam) {
  for(i = 0; i < mgteam.size; i++) {
    mgteam[i] endon("death");
  }

  a = 0;
  b = 1;

  for(;;) {
    if(isalive(mgteam[a])) {
      mgteam[a] set_firing(1);
    }

    if(isalive(mgteam[b])) {
      mgteam[b] set_firing(0);
    }

    c = a;
    a = b;
    b = c;
    wait randomfloatrange(2.3, 3.5);
  }
}

function get_suppress_point(origin, trace_start, trace_end) {
  traces = distance(trace_start, trace_end) * 0.05;

  if(traces < 5) {
    traces = 5;
  }

  if(traces > 20) {
    traces = 20;
  }

  vectordif = trace_end - trace_start;
  vectordif = (vectordif[0] / traces, vectordif[1] / traces, vectordif[2] / traces);
  offset = (0, 0, 0);
  hit_pos = undefined;

  for(i = 0; i < traces + 2; i++) {
    trace = scripts\engine\trace::_bullet_trace(origin, trace_start + offset, 0, undefined);

    if(trace["fraction"] < 1) {
      hit_pos = trace["position"];
      break;
    }

    offset += vectordif;
  }

  return hit_pos;
}

function record_enemy_sightings() {
  self endon("death");
  self endon("end_mg_behavior");
  self.current_enemy = undefined;

  for(;;) {
    record_sighting();
    wait 0.05;
  }
}

function record_sighting() {
  if(!isalive(self.enemy)) {
    return;
  }

  if(!self cansee(self.enemy)) {
    return;
  }

  self.last_enemy_sighting_position = self.enemy getEye();
  self notify("saw_enemy");

  if(!isalive(self.current_enemy) || self.current_enemy != self.enemy) {
    self.current_enemy = self.enemy;
    self notify("new_enemy");
  }
}
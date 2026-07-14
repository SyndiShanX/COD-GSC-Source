/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\mg_penetration.gsc
*****************************************/

#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\mgturret;
#namespace mg_penetration;

function gunner_think(turret) {
  if(!isDefined(level.shared_portable_turrets)) {
    level.shared_portable_turrets = [];
  }

  self endon("\x1e\xfd\xd1\xa2\a");
  self notify("U\x9cXW\t\xd5\x1a\t\t\x16\xb8\xb6\xbex\x91");
  self endon("U\x9cXW\t\xd5\x1a\t\t\x16\xb8\xb6\xbex\x91");
  self.can_fire_turret = 1;
  self.wants_to_fire = 0;

  if(!mgturret::use_the_turret(turret)) {
    self notify("\x11\x13\r\x17\xc2\xc6\xeet`\x8e\xbb\xb1V\xc9$\x84c\x85\x91\xd8\xaf");
    return;
  }

  self.last_enemy_sighting_position = undefined;
  thread record_enemy_sightings();
  forward = anglesToForward(turret.angles);
  ent = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", (0, 0, 0));
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
      self waittill("\x03\xcc\x86\xc0z|r(E");
    }

    start_firing();
    shoot_enemy_until_he_hides_then_shoot_wall(ent);

    if(!isalive(self.current_enemy)) {
      continue;
    }

    if(self cansee(self.current_enemy)) {
      continue;
    }

    self waittill("\xb1\xa4\xe6\xfd\x1e\xaf\xd3O{");
  }
}

function target_ent_cleanup(ent) {
  utility::waittill_any("\x1e\xfd\xd1\xa2\a", "U\x9cXW\t\xd5\x1a\t\t\x16\xb8\xb6\xbex\x91");
  ent delete();
}

function shoot_enemy_until_he_hides_then_shoot_wall(ent) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x03\xcc\x86\xc0z|r(E");
  self.current_enemy endon("\x1e\xfd\xd1\xa2\a");
  enemy = self.current_enemy;

  while(self cansee(enemy)) {
    angles = vectortoangles(enemy getEye() - ent.origin);
    angles = anglesToForward(angles);
    ent moveTo(ent.origin + angles * 12, 0.1);
    wait 0.1;
  }

  if(isPlayer(enemy)) {
    self endon("\xb1\xa4\xe6\xfd\x1e\xaf\xd3O{");
    eye = enemy getEye();
    angles = vectortoangles(eye - ent.origin);
    angles = anglesToForward(angles);
    var_93115ee91c046c7c = 150;
    timer = distance(ent.origin, self.last_enemy_sighting_position) / var_93115ee91c046c7c;

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
      self.turret notify("gQ\xe9\xa5D\xce\xe0 \xc6\xdd\xb5");
    }

    return;
  }

  self.can_fire_turret = 0;
  self.turret notify("\xdc\x8e\xb7\x83\x99\xd2rZ7;");
}

function stop_firing() {
  self.wants_to_fire = 0;
  self.turret notify("\xdc\x8e\xb7\x83\x99\xd2rZ7;");
}

function start_firing() {
  self.wants_to_fire = 1;

  if(self.can_fire_turret) {
    self.turret notify("gQ\xe9\xa5D\xce\xe0 \xc6\xdd\xb5");
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
  utility::array_thread(level.mg_gunner_team, &mg_gunner_death_notify, ent);
  array = level.mg_gunner_team;
  level.mg_gunner_team = undefined;
  ent waittill("\x04\xc6\xe1+\x97n\xd2\xd6\x80\xb4L");

  for(i = 0; i < array.size; i++) {
    if(!isalive(array[i])) {
      continue;
    }

    array[i] notify("?\x96\xd1\xf5\xe7\a1\x14\x99\xb8P\x9d\xfc@\xfa\xdb\xbe8\xb9\xaa]\x193:\x1b%\x83\x8b\xf5\x81");
    array[i] thread solo_fires();
  }
}

function mg_gunner_death_notify(ent) {
  self waittill("\x1e\xfd\xd1\xa2\a");
  ent notify("\x04\xc6\xe1+\x97n\xd2\xd6\x80\xb4L");
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
  self endon("\x1e\xfd\xd1\xa2\a");

  for(;;) {
    self.turret startfiring();
    wait randomfloatrange(0.3, 0.7);
    self.turret stopfiring();
    wait randomfloatrange(0.1, 1.1);
  }
}

function dual_firing(mgteam) {
  for(i = 0; i < mgteam.size; i++) {
    mgteam[i] endon("\x1e\xfd\xd1\xa2\a");
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
    trace = trace::_bullet_trace(origin, trace_start + offset, 0, undefined);

    if(trace["\xda\x16\x81\aw}^i"] < 1) {
      hit_pos = trace["\xc1\xbd\xdci\xe8i{7"];
      break;
    }

    offset += vectordif;
  }

  return hit_pos;
}

function record_enemy_sightings() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("U\x9cXW\t\xd5\x1a\t\t\x16\xb8\xb6\xbex\x91");
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
  self notify("\xb1\xa4\xe6\xfd\x1e\xaf\xd3O{");

  if(!isalive(self.current_enemy) || self.current_enemy != self.enemy) {
    self.current_enemy = self.enemy;
    self notify("\x03\xcc\x86\xc0z|r(E");
  }
}
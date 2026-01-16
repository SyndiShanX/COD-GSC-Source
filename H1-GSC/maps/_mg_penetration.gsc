/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_mg_penetration.gsc
********************************/

gunner_think(var_0) {
  self endon("death");
  self notify("end_mg_behavior");
  self endon("end_mg_behavior");
  self.can_fire_turret = 1;
  self.wants_to_fire = 0;

  if(!maps\_mgturret::use_the_turret(var_0)) {
    self notify("continue_cover_script");
    return;
  }

  self.last_enemy_sighting_position = undefined;
  thread record_enemy_sightings();
  var_1 = anglestoforward(var_0.angles);
  var_2 = spawn("script_origin", (0, 0, 0));
  thread target_ent_cleanup(var_2);
  var_2.origin = var_0.origin + var_1 * 500;

  if(isdefined(self.last_enemy_sighting_position))
    var_2.origin = self.last_enemy_sighting_position;

  var_0 settargetentity(var_2);
  var_3 = undefined;

  for (;;) {
    if(!isalive(self.current_enemy)) {
      stop_firing();
      self waittill("new_enemy");
    }

    start_firing();
    shoot_enemy_until_he_hides_then_shoot_wall(var_2);

    if(!isalive(self.current_enemy)) {
      continue;
    }
    if(self cansee(self.current_enemy)) {
      continue;
    }
    self waittill("saw_enemy");
  }
}

target_ent_cleanup(var_0) {
  common_scripts\utility::waittill_either("death", "end_mg_behavior");
  var_0 delete();
}

shoot_enemy_until_he_hides_then_shoot_wall(var_0) {
  self endon("death");
  self endon("new_enemy");
  self.current_enemy endon("death");
  var_1 = self.current_enemy;

  while (self cansee(var_1)) {
    var_2 = vectortoangles(var_1 geteye() - var_0.origin);
    var_2 = anglestoforward(var_2);
    var_0 moveto(var_0.origin + var_2 * 12, 0.1);
    wait 0.1;
  }

  if(isplayer(var_1)) {
    self endon("saw_enemy");
    var_3 = var_1 geteye();
    var_2 = vectortoangles(var_3 - var_0.origin);
    var_2 = anglestoforward(var_2);
    var_4 = 150;
    var_5 = distance(var_0.origin, self.last_enemy_sighting_position) / var_4;

    if(var_5 > 0) {
      var_0 moveto(self.last_enemy_sighting_position, var_5);
      wait(var_5);
    }

    var_6 = var_0.origin + var_2 * 180;
    var_7 = get_suppress_point(self geteye(), var_0.origin, var_6);

    if(!isdefined(var_7))
      var_7 = var_0.origin;

    var_0 moveto(var_0.origin + var_2 * 80 + (0, 0, randomfloatrange(15, 50) * -1), 3, 1, 1);
    wait 3.5;
    var_0 moveto(var_7 + var_2 * -20, 3, 1, 1);
  }

  wait(randomfloatrange(2.5, 4));
  stop_firing();
}

set_firing(var_0) {
  if(var_0) {
    self.can_fire_turret = 1;

    if(self.wants_to_fire)
      self.turret notify("startfiring");
  } else {
    self.can_fire_turret = 0;
    self.turret notify("stopfiring");
  }
}

stop_firing() {
  self.wants_to_fire = 0;
  self.turret notify("stopfiring");
}

start_firing() {
  self.wants_to_fire = 1;

  if(self.can_fire_turret)
    self.turret notify("startfiring");
}

create_mg_team() {
  if(isdefined(level.mg_gunner_team)) {
    level.mg_gunner_team[level.mg_gunner_team.size] = self;
    return;
  }

  level.mg_gunner_team = [];
  level.mg_gunner_team[level.mg_gunner_team.size] = self;
  waittillframeend;
  var_0 = spawnstruct();
  common_scripts\utility::array_thread(level.mg_gunner_team, ::mg_gunner_death_notify, var_0);
  var_1 = level.mg_gunner_team;
  level.mg_gunner_team = undefined;
  var_0 waittill("gunner_died");

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    if(!isalive(var_1[var_2])) {
      continue;
    }
    var_1[var_2] notify("stop_using_built_in_burst_fire");
    var_1[var_2] thread solo_fires();
  }
}

mg_gunner_death_notify(var_0) {
  self waittill("death");
  var_0 notify("gunner_died");
}

mgteam_take_turns_firing(var_0) {
  wait 1;
  level notify("new_mg_firing_team" + var_0[0].script_noteworthy);
  level endon("new_mg_firing_team" + var_0[0].script_noteworthy);

  for (;;) {
    dual_firing(var_0);
    solo_firing(var_0);
  }
}

solo_firing(var_0) {
  var_1 = undefined;

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    if(!isalive(var_0[var_2])) {
      continue;
    }
    var_1 = var_0[var_2];
    break;
  }

  if(!isdefined(var_1))
    return;
}

solo_fires() {
  self endon("death");

  for (;;) {
    self.turret startfiring();
    wait(randomfloatrange(0.3, 0.7));
    self.turret stopfiring();
    wait(randomfloatrange(0.1, 1.1));
  }
}

dual_firing(var_0) {
  for (var_1 = 0; var_1 < var_0.size; var_1++)
    var_0[var_1] endon("death");

  var_2 = 0;
  var_3 = 1;

  for (;;) {
    if(isalive(var_0[var_2]))
      var_0[var_2] set_firing(1);

    if(isalive(var_0[var_3]))
      var_0[var_3] set_firing(0);

    var_4 = var_2;
    var_2 = var_3;
    var_3 = var_4;
    wait(randomfloatrange(2.3, 3.5));
  }
}

spotted_an_enemy(var_0, var_1) {
  start_firing();
  self endon("death");
  self endon("new_enemy");
  var_1 endon("death");

  while (self cansee(var_1)) {
    var_2 = vectortoangles(var_1 geteye() - var_0.origin);
    var_2 = anglestoforward(var_2);
    var_0 moveto(var_0.origin + var_2 * 10, 0.2);
    wait 0.2;
  }

  var_2 = vectortoangles(var_1 geteye() - var_0.origin);
  var_2 = anglestoforward(var_2);
  var_3 = 150;
  var_4 = distance(var_0.origin, self.last_enemy_sighting_position) / var_3;
  var_0 moveto(self.last_enemy_sighting_position, var_4);
  wait(var_4);
  var_5 = var_0.origin;
  var_0 moveto(var_0.origin + var_2 * 80 + (0, 0, -25), 3, 1, 1);
  wait 3.5;
  var_0 moveto(var_5 + var_2 * -20, 3, 1, 1);
  wait 1;
  stop_firing();
}

get_suppress_point(var_0, var_1, var_2) {
  var_3 = distance(var_1, var_2) * 0.05;

  if(var_3 < 5)
    var_3 = 5;

  if(var_3 > 20)
    var_3 = 20;

  var_4 = var_2 - var_1;
  var_4 = (var_4[0] / var_3, var_4[1] / var_3, var_4[2] / var_3);
  var_5 = (0, 0, 0);
  var_6 = undefined;

  for (var_7 = 0; var_7 < var_3 + 2; var_7++) {
    var_8 = bullettrace(var_0, var_1 + var_5, 0, undefined);

    if(var_8["fraction"] < 1) {
      var_6 = var_8["position"];
      break;
    }

    var_5 = var_5 + var_4;
  }

  return var_6;
}

record_enemy_sightings() {
  self endon("death");
  self endon("end_mg_behavior");
  self.current_enemy = undefined;

  for (;;) {
    record_sighting();
    wait 0.05;
  }
}

record_sighting() {
  if(!isalive(self.enemy)) {
    return;
  }
  if(!self cansee(self.enemy)) {
    return;
  }
  self.last_enemy_sighting_position = self.enemy geteye();
  self notify("saw_enemy");

  if(!isalive(self.current_enemy) || self.current_enemy != self.enemy) {
    self.current_enemy = self.enemy;
    self notify("new_enemy");
  }
}
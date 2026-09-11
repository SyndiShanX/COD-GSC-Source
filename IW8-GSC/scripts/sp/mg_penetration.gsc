/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\mg_penetration.gsc
***********************************************/

function gunner_think(var0) {
  if(!isDefined(level.shared_portable_turrets)) {
    level.shared_portable_turrets = [];
  }

  self endon("death");
  self notify("end_mg_behavior");
  self endon("end_mg_behavior");
  self.can_fire_turret = 1;
  self.wants_to_fire = 0;

  if(!scripts\sp\mgturret::use_the_turret(var0)) {
    self notify("continue_cover_script");
    return;
  }

  self.last_enemy_sighting_position = undefined;
  thread record_enemy_sightings();
  var1 = anglesToForward(var0.angles);
  var2 = spawn("script_origin", (0, 0, 0));
  thread target_ent_cleanup(var2);
  var2.origin = var0.origin + var1 * 500;

  if(isDefined(self.last_enemy_sighting_position)) {
    var2.origin = self.last_enemy_sighting_position;
  }

  var0 settargetentity(var2);
  var3 = undefined;

  for(;;) {
    if(!isalive(self.current_enemy)) {
      stop_firing();
      self waittill("new_enemy");
    }

    start_firing();
    shoot_enemy_until_he_hides_then_shoot_wall(var2);

    if(!isalive(self.current_enemy)) {
      continue;
    }

    if(self cansee(self.current_enemy)) {
      continue;
    }

    self waittill("saw_enemy");
  }
}

function target_ent_cleanup(var0) {
  scripts\engine\utility::waittill_either("death", "end_mg_behavior");
  var0 delete();
}

function shoot_enemy_until_he_hides_then_shoot_wall(var0) {
  self endon("death");
  self endon("new_enemy");
  self.current_enemy endon("death");
  var1 = self.current_enemy;

  while(self cansee(var1)) {
    var2 = vectortoangles(var1 getEye() - var0.origin);
    var2 = anglesToForward(var2);
    var0 moveTo(var0.origin + var2 * 12, 0.1);
    wait 0.1;
  }

  if(isPlayer(var1)) {
    self endon("saw_enemy");
    var3 = var1 getEye();
    var2 = vectortoangles(var3 - var0.origin);
    var2 = anglesToForward(var2);
    var4 = 150;
    var5 = distance(var0.origin, self.last_enemy_sighting_position) / var4;

    if(var5 > 0) {
      var0 moveTo(self.last_enemy_sighting_position, var5);
      wait var5;
    }

    var6 = var0.origin + var2 * 180;
    var7 = get_suppress_point(self getEye(), var0.origin, var6);

    if(!isDefined(var7)) {
      var7 = var0.origin;
    }

    var0 moveTo(var0.origin + var2 * 80 + (0, 0, randomfloatrange(15, 50) * -1), 3, 1, 1);
    wait 3.5;
    var0 moveTo(var7 + var2 * -20, 3, 1, 1);
  }

  wait randomfloatrange(2.5, 4);
  stop_firing();
}

function set_firing(var0) {
  if(var0) {
    self.can_fire_turret = 1;

    if(self.wants_to_fire) {
      self.turret notify("startfiring");
      return;
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
    return;
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
  var0 = spawnStruct();
  scripts\engine\utility::array_thread(level.mg_gunner_team, &mg_gunner_death_notify, var0);
  var1 = level.mg_gunner_team;
  level.mg_gunner_team = undefined;
  var0 waittill("gunner_died");

  for(var2 = 0; var2 < var1.size; var2++) {
    if(!isalive(var1[var2])) {
      continue;
    }

    var1[var2] notify("stop_using_built_in_burst_fire");
    thread solo_fires();
  }
}

function mg_gunner_death_notify(var0) {
  self waittill("death");
  var0 notify("gunner_died");
}

function solo_firing(var0) {
  var1 = undefined;

  for(var2 = 0; var2 < var0.size; var2++) {
    if(!isalive(var0[var2])) {
      continue;
    }

    var1 = var0[var2];
    break;
  }

  if(!isDefined(var1)) {
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

function dual_firing(var0) {
  for(var1 = 0; var1 < var0.size; var1++) {
    var0[var1] endon("death");
  }

  var2 = 0;
  var3 = 1;

  for(;;) {
    if(isalive(var0[var2])) {
      set_firing(var0[var2], 1);
    }

    if(isalive(var0[var3])) {
      set_firing(var0[var3], 0);
    }

    var4 = var2;
    var2 = var3;
    var3 = var4;
    wait randomfloatrange(2.3, 3.5);
  }
}

function get_suppress_point(var0, var1, var2) {
  var3 = distance(var1, var2) * 0.05;

  if(var3 < 5) {
    var3 = 5;
  }

  if(var3 > 20) {
    var3 = 20;
  }

  var4 = var2 - var1;
  var4 = (var4[0] / var3, var4[1] / var3, var4[2] / var3);
  var5 = (0, 0, 0);
  var6 = undefined;

  for(var7 = 0; var7 < var3 + 2; var7++) {
    var8 = scripts\engine\trace::_bullet_trace(var0, var1 + var5, 0, undefined);

    if(var8["fraction"] < 1) {
      var6 = var8["position"];
      break;
    }

    var5 += var4;
  }

  return var6;
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
    return;
  }
}
/*********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\alien\alien_spider\_alien_spider_melee.gsc
*********************************************************************/

main() {
  self endon("killanimscript");
  self scragentsetphysicsmode("noclip");
  var_0 = gettime();
  self scragentsetorientmode("face angle abs", self.angles);
  self.looktarget = self.enemy;
  thread wait_for_downed_state();
  level.spider_regen_sfx = 0;

  switch (self.melee_type) {
    case "egg_attack":
      eggspawn(self.enemy);
      break;
    case "close_melee":
      closemelee();
      break;
    case "bomb_attack":
      projectilespit();
      break;
    case "beam_attack":
      beamattack();
      self.has_fired_beam = 1;
      break;
    case "beamsweep_attack":
      beamsweepattack();
      break;
    case "posture_attack":
      posture();
      break;
    case "traverse":
      traverse();
      break;
    case "regenpod_attack":
      spawnregenpods();
      break;
    case "regen_attack":
      regeneration();
      break;
    case "elevated_retreat_attack":
      elevatedretreat();
      break;
    case "elevated_return_attack":
      elevatedreturn();
      break;
    default:
      break;
  }

  if(var_0 == gettime()) {
    wait 0.05;
  }

  while(self.vulnerable) {
    wait 0.05;
  }

  self notify("melee_complete");
}

spawnregenpod(var_0) {
  self.spawned = 1;

  if(isDefined(self.pod_coll_model)) {
    self.pod_coll_model delete();
  }

  self.pod_coll_model = spawn("script_model", self.origin);
  self.pod_coll_model setModel("armory_alien_hive_spore_coll");
  self.pod_coll_model.angles = self.angles;
  self.pod_coll_model.maxhealth = 102000;
  self.pod_coll_model.health = 102000;
  self.pod_coll_model setCanDamage(1);
  self.pod_coll_model setCanRadiusDamage(1);
  self setscriptablepartstate(0, "start_active");
  thread regenpoddamagehandler();
  wait 3;
  self setscriptablepartstate(0, "loop_active");
  playFX(level._effect["spider_regen_pod"], self.origin + (0, 0, 40));
  var_1 = 0;

  while(var_0 > 0) {
    if(!isDefined(self.pod_coll_model) && !self.drainable && !self.spawned) {
      var_1 = 1;
      break;
    }

    var_0 = var_0 - 0.05;
    wait 0.05;
  }

  var_2 = undefined;

  if(!var_1) {
    self.drainable = 1;
    self waittill("destroyed", var_3);
  } else
    var_3 = "killed";

  if(var_3 == "drained") {
    self setscriptablepartstate(0, "not_killed");
  } else if(var_3 == "killed") {
    self setscriptablepartstate(0, "killed");

    if(!isDefined(var_2) && isDefined(self.final_attacker)) {
      var_2 = self.final_attacker;
    }

    if(isDefined(var_2) && isplayer(var_2)) {
      var_4 = int(level.alien_types["brute"].attributes["reward"] * 2);
      maps\mp\alien\_gamescore::givekillreward(var_2, var_4, "large", "soft");
    }
  }

  wait 3;
  self setscriptablepartstate(0, "inactive");

  if(isDefined(self.pod_coll_model)) {
    self.pod_coll_model setCanDamage(0);
    self.pod_coll_model setCanRadiusDamage(0);
    self.pod_coll_model delete();
  }

  self.spawned = 0;
}

regenpoddamagehandler() {
  self endon("destroyed");
  var_0 = undefined;
  self.final_attacker = undefined;

  while(isDefined(self.pod_coll_model) && self.pod_coll_model.health > 100000) {
    self.pod_coll_model waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(isDefined(var_2) && isplayer(var_2)) {
      var_2 thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback("standard");
      var_0 = var_2;
    }

    if(var_1 > 2000) {
      self.pod_coll_model.health = self.pod_coll_model.health + int((var_1 - 2000) * 1.1);
    }
  }

  self.pod_coll_model setCanDamage(0);
  self.pod_coll_model delete();
  self.drainable = 0;
  self.spawned = 0;
  self.final_attacker = var_0;
  self notify("destroyed", "killed", var_0);
}

getregenpods() {
  var_0 = [];

  foreach(var_2 in level.spider_regen_pods) {
    if(distance(var_2.origin, self.origin) > 2000) {
      continue;
    }
    if(isDefined(var_2) && isDefined(var_2.spawned) && var_2.spawned) {
      var_0[var_0.size] = var_2;
    }
  }

  return var_0;
}

getavailableregenpods() {
  var_0 = getregenpods();
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isDefined(var_3) && isDefined(var_3.drainable) && var_3.drainable == 1) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

isbelowregenhp() {
  return maps\mp\agents\alien\alien_spider\_alien_spider::gethealthratio() < 0.5;
}

spawnregenpods() {
  self endon("regen_interrupted");
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("attack_melee_swipe", 1, "attack_melee", "end", maps\mp\agents\alien\alien_spider\_alien_spider::handlespidernotetracks);
  thread spawnregenpodsraw();
}

getregenpodscaledspawncount() {
  switch (level.players.size) {
    case 1:
      return 2;
    case 2:
      return 2;
    case 3:
      return 3;
    default:
      return 3;
  }
}

spawnregenpodsraw() {
  var_0 = maps\mp\agents\alien\alien_spider\_alien_spider::gethealthratio();

  if(var_0 <= 1 && var_0 > 0.66) {
    var_1 = 18;
  } else if(var_0 <= 0.66 && var_0 > 0.33) {
    var_1 = 15;
  } else {
    var_1 = 12;
  }

  var_2 = 0;
  var_3 = getavailableregenpods();

  if(var_3.size < 3) {
    var_2 = 3 - var_3.size;
  }

  var_4 = getregenpodscaledspawncount();
  var_2 = min(var_4, var_2);
  level notify("dlc_vo_notify", "spider_vo", "spider_pods");
  var_5 = common_scripts\utility::array_randomize(level.spider_regen_pods);

  for(var_6 = 0; var_6 < var_2; var_6++) {
    var_5[var_6] thread spawnregenpod(var_1);
  }
}

regeneration() {
  self endon("death");
  self endon("spider_stage_end");
  self endon("regen_interrupted");
  var_0 = getavailableregenpods();
  var_1 = var_0[0];
  thread resetregenpodidleoninterrupt(var_1);
  maps\mp\agents\alien\_alien_anim_utils::turntowardsentity(var_1);
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("attack_regen", 0, "attack_regen", "end", maps\mp\agents\alien\alien_spider\_alien_spider::handlespidernotetracks);
  var_1 setscriptablepartstate(0, "healing");
  regenpoddrain(var_1);
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("attack_regen", 1, "attack_regen", "end", maps\mp\agents\alien\alien_spider\_alien_spider::handlespidernotetracks);
}

resetregenpodidleoninterrupt(var_0) {
  self endon("death");
  self endon("regen_complete");
  var_0 endon("destroyed");
  self waittill("regen_interrupted");
  var_0 setscriptablepartstate(0, "loop_active");
}

regenpoddrain(var_0) {
  self endon("death");
  self endon("spider_stage_end");
  self endon("regen_interrupted");
  var_0 endon("destroyed");

  if(!isDefined(var_0)) {
    return;
  }
  thread regenfx(var_0);
  var_1 = self getanimentry("attack_regen", 1);
  var_2 = getanimlength(var_1);
  var_3 = 5;
  var_4 = 0.12 * (self.maxhealth - level.spider_health_padding);
  var_5 = int(var_4 / 2);
  var_6 = max(1, var_4 - var_5);
  self.health = self.health + var_5;
  var_7 = int(var_3 / var_2) + 1;

  for(var_8 = 0; var_8 < var_7; var_8++) {
    self.health = self.health + int(var_6 / var_7);

    if(self.health > self.maxhealth) {
      self.health = self.maxhealth;
    }

    self notify("hp_update");
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("attack_regen", 2, "attack_regen", "end", maps\mp\agents\alien\alien_spider\_alien_spider::handlespidernotetracks);
  }

  self notify("regen_complete", var_0);
  var_0.drainable = 0;
  var_0 notify("destroyed", "drained");
}

regenfx(var_0) {
  self endon("death");
  self endon("spider_stage_end");
  self endon("regen_interrupted");
  self endon("regen_complete");
  var_0 endon("destroyed");
  var_1 = vectornormalize(self gettagorigin("tag_belly_f") - var_0.origin) * 300;
  var_2 = var_1 * -1;
  var_3 = 0.25;

  for(var_4 = 10; var_4 > 0 && isDefined(var_0) && isDefined(var_0); var_4 = var_4 - var_3) {
    thread regen_sfx(var_4, var_3);
    playFX(level._effect["spider_regen_spider"], self gettagorigin("tag_belly_f"), var_2);
    playFX(level._effect["spider_regen_pod"], var_0.origin, var_1);
    wait(var_3);
  }
}

regen_sfx(var_0, var_1) {
  if(level.spider_regen_sfx == 0) {
    self playLoopSound("spdr_rchrg_lp");

    for(level.spider_regen_sfx = 1; var_0 > 0; var_0 = var_0 - var_1) {
      wait(var_1);
    }

    self stoploopsound("spdr_rchrg_lp");
    self playsoundonmovingent("spdr_rchrg_end");
    level.spider_regen_sfx = 0;
  }
}

beamprecursor() {
  self endon("death");
  self endon("spider_stage_end");
  self endon("beam_interrupted");
  playFX(level._effect["beam_attack_charge"], self gettagorigin("tag_belly_f") + (0, 0, 40));
  wait 0.6;
  wait 1.15;
}

beamchargeup() {
  self endon("death");
  self endon("spider_stage_end");
  self endon("beam_interrupted");
  self setanimstate("attack_satellite", 0, 1.0);
  var_0 = self getanimentry("attack_satellite", 0);
  var_1 = getanimlength(var_0);
  wait(var_1 * 0.35);
  var_2 = int(var_1 * 0.65 / 0.1);

  for(var_3 = 0; var_3 < var_2; var_3++) {
    playFXOnTag(level._effect["beam_fire_flash"], self, "tag_back_laser_l");
    playFXOnTag(level._effect["beam_fire_flash"], self, "tag_back_laser_r");
    wait 0.1;
  }
}

beamsweepattack() {
  self endon("death");
  self endon("spider_stage_end");
  self endon("beam_interrupted");
  beamprecursor();
  beamchargeup();
  var_0 = get_mid_point(self.beam_turret["left"].origin, self.beam_turret["right"].origin);
  var_1 = var_0[2] + -64;
  var_2 = beam_find_new_target();

  if(!isDefined(var_2)) {
    var_2 = sortbydistance(level.players, self.origin)[0];
  }

  var_3 = 1;

  if(common_scripts\utility::cointoss()) {
    var_3 = -1;
  }

  var_4 = (var_2.origin[0], var_2.origin[1], var_1);
  var_5 = var_4 - var_0;
  var_6 = vectortoangles(var_5) - var_3 * (0, 25, 0);
  var_7 = anglesToForward(var_6) * max(distance2d(var_0, var_2.origin), 1250) + var_0;
  var_8 = var_6 + var_3 * (0, 100, 0);
  var_9 = anglesToForward(var_8) * max(distance2d(var_0, var_2.origin), 1250) + var_0;

  if(!isDefined(self.sweep_dummy)) {
    self.sweep_dummy = spawn("script_origin", var_7);
  } else {
    self.sweep_dummy unlink();
    self.sweep_dummy.origin = var_7;
  }

  if(!isDefined(self.beam_origin_dummy)) {
    self.beam_origin_dummy = spawn("script_origin", self.origin);
  } else {
    self.beam_origin_dummy.origin = self.origin;
  }

  self.beam_origin_dummy.angles = self.angles;
  self.sweep_dummy linkto(self.beam_origin_dummy);
  self.beam_turret["left"] settargetentity(self.sweep_dummy);
  self.beam_turret["right"] settargetentity(self.sweep_dummy);
  thread beam_anim_turn_monitor(self.sweep_dummy, self.sweep_dummy, 10);
  thread beam_cone_damage(self.beam_turret["left"]);
  thread beam_cone_damage(self.beam_turret["right"]);
  var_10 = 0.25;
  var_11 = 4;
  var_12 = var_11 / var_10;
  var_13 = var_3 * 100 / var_12;

  for(var_14 = 2; var_14 > 0; var_13 = -1 * var_13) {
    thread beamattacktarget(self.sweep_dummy, "left", var_11, undefined);
    thread beamattacktarget(self.sweep_dummy, "right", var_11, 0.1);

    for(var_15 = 0; var_15 < var_12; var_15++) {
      self.beam_origin_dummy rotateyaw(var_13, var_10);
      wait(var_10);
    }

    var_14--;
  }

  self notify("beam_stop");
  maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack("attack_satellite", 1, 1.0, "attack_satellite", "end", maps\mp\agents\alien\alien_spider\_alien_spider::handlespidernotetracks);
}

beam_cone_damage(var_0) {
  self endon("beam_stop");
  self endon("death");
  self endon("spider_stage_end");
  self endon("beam_interrupted");
  wait 0.2;

  for(;;) {
    var_1 = var_0 gettagangles("tag_flash");
    var_2 = vectornormalize(anglesToForward(var_1));
    var_3 = var_0 gettagorigin("tag_flash");

    foreach(var_5 in level.players) {
      if(!self agentcanseesentient(var_5) || !isalive(var_5) || isDefined(var_5.laststand) && var_5.laststand) {
        continue;
      }
      var_6 = vectordot(var_2, vectornormalize(var_5.origin - var_3));

      if(var_6 >= 0.995) {
        var_5 dodamage(3, var_5.origin, self, var_0);
      }
    }

    wait 0.05;
  }
}

beamattack() {
  self endon("death");
  self endon("spider_stage_end");
  self endon("beam_interrupted");
  var_0 = beam_find_new_target();

  if(!isDefined(var_0)) {
    return;
  }
  var_0 beam_setup_new_target(self);
  level notify("dlc_vo_notify", "spider_vo", "spider_before_lasers");
  maps\mp\agents\alien\_alien_anim_utils::turntowardsentity(var_0);
  beamprecursor();

  if(isDefined(var_0) && isDefined(var_0.target_dummy)) {
    self.beam_turret["left"] settargetentity(var_0.target_dummy);
    self.beam_turret["right"] settargetentity(var_0.target_dummy);
  }

  beamchargeup();
  playsoundatpos(self.origin, "alien_fence_shock");
  level notify("dlc_vo_notify", "spider_vo", "spider_lasers");

  if(!maps\mp\alien\_utility::isplayingsolo()) {
    var_1 = 4.5;
  } else if(isDefined(self.has_fired_beam)) {
    var_1 = 3.5;
  } else {
    var_1 = 1.75;
  }

  var_2 = 0;

  if(isDefined(var_0) && isDefined(var_0.target_dummy)) {
    var_0 thread update_target_dummy(self, self.beam_turret);
    thread beam_anim_turn_monitor(var_0.target_dummy, var_0);
    var_2 = beamsattacktarget(var_0, var_1);
  }

  if(!isDefined(var_2) || !var_2) {
    var_3 = var_0.origin;
    var_0 = beam_find_new_target();

    if(isDefined(var_0)) {
      var_0 beam_setup_new_target(self, var_3);

      if(isDefined(var_0) && isDefined(var_0.target_dummy)) {
        self.beam_turret["left"] settargetentity(var_0.target_dummy);
        self.beam_turret["right"] settargetentity(var_0.target_dummy);
        var_0 thread update_target_dummy(self, self.beam_turret, 1);
        thread beam_anim_turn_monitor(var_0.target_dummy, var_0);
        beamsattacktarget(var_0, var_1);
      }
    }
  }

  if(isDefined(var_0) && isDefined(var_0.target_dummy)) {
    var_0.target_dummy delete();
  }

  self notify("beam_stop");
  maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack("attack_satellite", 1, 1.0, "attack_satellite", "end", maps\mp\agents\alien\alien_spider\_alien_spider::handlespidernotetracks);
}

beam_setup_new_target(var_0, var_1) {
  if(isDefined(self) && isDefined(self.target_dummy)) {
    self.target_dummy delete();
  }

  if(!isDefined(var_1)) {
    var_1 = self.origin;
  }

  self.target_dummy = spawn("script_origin", var_1);
}

beam_find_new_target() {
  var_0 = undefined;
  var_1 = sortbydistance(level.players, self.origin);
  var_2 = [];

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_4 = var_1[var_3];

    if(!isalive(var_4) || isDefined(var_4.laststand) && var_4.laststand) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  if(isDefined(var_2) && var_2.size) {
    var_0 = var_2[0];

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      if(isvalidtarget(var_2[var_3])) {
        var_0 = var_2[var_3];
        break;
      }
    }
  }

  return var_0;
}

beam_anim_turn_monitor(var_0, var_1, var_2) {
  self endon("death");
  self endon("spider_stage_end");
  self endon("beam_stop");
  self endon("beam_interrupted");

  if(!isDefined(var_0)) {
    return;
  } else {
    var_0 endon("death");
  }

  if(!isDefined(var_2)) {
    var_2 = 35;
  }

  if(isDefined(var_1)) {
    var_1 endon("death");
    var_1 endon("last_stand");
  }

  for(;;) {
    var_3 = vectornormalize(var_1.origin - self.origin);
    var_4 = maps\mp\agents\alien\_alien_anim_utils::getprojectiondata(anglesToForward(self.angles), var_3, anglestoup(self.angles));

    if(var_4.rotatedyaw > var_2) {
      if(var_4.projintooutright > 0) {
        var_5 = 1;
      } else {
        var_5 = 0;
      }

      self.sweepturning = 1;
      maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack("attack_satellite_turn", var_5, 1.0, "attack_satellite_turn", "end", maps\mp\agents\alien\alien_spider\_alien_spider::handlespidernotetracks);
      self.sweepturning = 0;
      continue;
    }

    self.sweepturning = 0;
    wait 0.05;
  }
}

get_mid_point(var_0, var_1) {
  return ((var_0[0] + var_1[0]) / 2, (var_0[1] + var_1[1]) / 2, (var_0[2] + var_1[2]) / 2);
}

update_target_dummy(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0 endon("beam_stop");
  var_0 endon("spider_stage_end");
  var_0 endon("beam_interrupted");
  self endon("death");
  self endon("last_stand");
  thread remove_dummy_on_target_death(var_0);
  self.target_dummy endon("death");
  var_3 = 1.5;

  if(isDefined(var_2) && var_2) {
    var_4 = self.origin;

    if(!is_target_in_attack_cone(var_0, var_4, 0.85)) {
      var_4 = get_edge_of_cone(var_0, var_4, 0.85);
    }

    self.target_dummy moveto(var_4, var_3);
    wait(var_3);
  }

  var_5 = 0;

  for(;;) {
    var_6 = get_mid_point(var_1["left"].origin, var_1["right"].origin);

    if(self.origin[2] <= var_6[2]) {
      var_7 = (0, 0, 0);
    } else {
      var_8 = distance(var_6, self.origin);

      if(var_8 <= 0.001 && var_8 >= -0.001) {
        var_8 = 0.001;
      }

      var_9 = self.origin[2] - var_6[2];
      var_10 = min(15, asin(var_9 / var_8));
      var_7 = var_10 / 15 * (0, 0, 64);
    }

    var_4 = self.origin + var_7;

    if(!is_target_in_attack_cone(var_0, var_4, 0.85)) {
      var_4 = get_edge_of_cone(var_0, var_4, 0.85);
    }

    var_11 = anglesToForward(var_0.angles);
    var_12 = self.origin - var_0.origin;
    var_13 = abs(vectortoangles(var_11)[1] - vectortoangles(var_12)[1]);
    var_14 = abs(var_5 - var_13);
    var_5 = var_13;
    var_15 = 3;
    var_16 = vectornormalize(self.target_dummy.origin - var_4) * (var_14 * var_15) + var_4;
    self.target_dummy moveto(var_16, 0.1);
    wait 0.1;
  }
}

get_edge_of_cone(var_0, var_1, var_2) {
  var_3 = distance(var_0.origin, var_1);
  var_4 = var_1[2];
  var_5 = var_0.angles + (0, acos(var_2), 0);
  var_6 = var_0.angles - (0, acos(var_2), 0);
  var_7 = var_0.origin + vectornormalize(anglesToForward(var_5)) * var_3;
  var_8 = var_0.origin + vectornormalize(anglesToForward(var_6)) * var_3;
  var_7 = (var_7[0], var_7[1], var_4);
  var_8 = (var_8[0], var_8[1], var_4);

  if(distance(var_7, var_1) <= distance(var_8, var_1)) {
    return var_7;
  } else {
    return var_8;
  }
}

is_target_in_attack_cone(var_0, var_1, var_2) {
  var_3 = vectornormalize(var_1 - var_0.origin);
  var_3 = (var_3[0], var_3[1], 0);
  var_4 = (anglesToForward(var_0.angles)[0], anglesToForward(var_0.angles)[1], 0);
  var_5 = vectordot(var_3, var_4);

  if(var_5 > var_2) {
    return 1;
  }

  return 0;
}

remove_dummy_on_target_death(var_0) {
  var_0 endon("death");
  var_0 endon("beam_stop");
  var_0 endon("beam_interrupted");
  var_0 endon("spider_stage_end");
  common_scripts\utility::waittill_any("death", "last_stand");

  if(isDefined(self) && isDefined(self.target_dummy)) {
    self.target_dummy delete();
  }
}

isvalidtarget(var_0) {
  if(!isalive(var_0) || isDefined(var_0.laststand) && var_0.laststand) {
    return 0;
  }

  var_1 = distance(self.origin, var_0.origin);

  if(var_1 < 4000 && var_1 > 10 && self agentcanseesentient(var_0)) {
    return 1;
  }

  return 0;
}

beamsattacktarget(var_0, var_1) {
  var_0 endon("last_stand");
  var_0 endon("death");
  self endon("target_lost");
  thread monitortargetvisibility(var_0);
  thread beamattacktarget(var_0.target_dummy, "left", var_1, undefined);
  thread beamattacktarget(var_0.target_dummy, "right", var_1, 0.1);
  wait(var_1);
  return 1;
}

monitortargetvisibility(var_0) {
  self endon("death");
  self endon("spider_stage_end");
  self endon("beam_stop");
  self notify("monitorTargetVisibility");
  self endon("monitorTargetVisibility");

  if(!issentient(var_0)) {
    return;
  }
  var_0 endon("death");
  var_0 endon("last_stand");

  for(;;) {
    if(!self agentcanseesentient(var_0)) {
      wait 0.75;

      if(!self agentcanseesentient(var_0)) {
        self notify("target_lost");
        break;
      }
    }

    wait 0.05;
  }
}

beamattacktarget(var_0, var_1, var_2, var_3) {
  self endon("beam_stop");
  self endon("death");
  self endon("spider_stage_end");
  self endon("beam_interrupted");
  var_4 = self.beam_turret[var_1];
  var_5 = weaponfiretime("spider_beam_mp");
  var_6 = 10;

  if(isDefined(var_2) && var_2 < var_6) {
    var_6 = var_2;
  }

  thread beamattackfx(var_4, var_6, var_3);
  thread beamattackanim(var_0);

  while(var_6 > 0 && isDefined(var_0)) {
    var_7 = var_4 gettagangles("tag_flash");
    var_8 = vectornormalize(anglesToForward(var_7));
    var_9 = vectornormalize(var_0.origin - var_4.origin);
    var_10 = vectordot(var_8, var_9);

    if(var_10 > 0.95) {
      var_4 shootturret();
    }

    var_6 = var_6 - var_5;
    wait(var_5);
  }

  self notify("internal_beamAttackTarget_ended");
}

beamattackanim(var_0) {
  self endon("beam_stop");
  self endon("death");
  self endon("spider_stage_end");
  self endon("beam_interrupted");
  self endon("internal_beamAttackTarget_ended");
  var_1 = self getanimentry("attack_satellite", 2);
  var_2 = getanimlength(var_1);

  if(!isDefined(self.sweepturning)) {
    self.sweepturning = 0;
  }

  while(isDefined(var_0)) {
    if(!self.sweepturning) {
      self setanimstate("attack_satellite", 2, 1.0);
      wait(var_2);
    }

    wait 0.05;
  }
}

beamattackfx(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    wait(var_2);
  }

  if(!isDefined(self) || !isDefined(var_0)) {
    return;
  }
  playFXOnTag(level._effect["darts_fire_1"], var_0, "tag_flash");
  thread cleanupbeamfirefx(var_0);
  var_1 = max(0, var_1 - 0.5);
  common_scripts\utility::waittill_any_timeout(var_1, "beam_stop", "death", "weapon_death", "beam_interrupted");
  stopFXOnTag(level._effect["darts_fire_1"], var_0, "tag_flash");
}

cleanupbeamfirefx(var_0) {
  self endon("death");
  self endon("spider_stage_end");
  var_0 notify("CleanUpBeamFireFx");
  var_0 endon("CleanUpBeamFireFx");
  var_0 waittill("death");
  self notify("weapon_death");
}

setupbeamweapons() {
  setupbeamweapon("tag_back_laser_l", "left", "axis");
  setupbeamweapon("tag_back_laser_r", "right", "axis");
}

setupbeamweapon(var_0, var_1, var_2) {
  if(!isDefined(self.beam_turret)) {
    self.beam_turret = [];
  }

  if(isDefined(self.beam_turret[var_1])) {
    return;
  }
  self.beam_turret[var_1] = spawnturret("misc_turret", self gettagorigin(var_0), "spider_beam_mp");
  self.beam_turret[var_1] linkto(self, var_0);
  self.beam_turret[var_1] setModel("spider_beam_gun");
  self.beam_turret[var_1].angles = self gettagangles(var_0);
  self.beam_turret[var_1].team = var_2;
  self.beam_turret[var_1] maketurretinoperable();
  self.beam_turret[var_1] makeunusable();
  self.beam_turret[var_1].health = 1000000;
  self.beam_turret[var_1].maxhealth = 1000000;
  self.beam_turret[var_1] setmode("manual");
  self.beam_turret[var_1] setturretteam(var_2);
}

projectilespit() {
  self endon("projectile_spit_interrupted");
  self endon("killanimscript");
  self endon("spider_stage_end");
  maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack("attack_bomb", 0, 1.0, "attack_bomb", "end");
  var_0 = getplayerspittargets(3);
  var_1 = getchokespittargets(3);
  var_2 = [];

  if(var_0.size == 0) {
    var_2 = var_1;
  } else {
    var_2[0] = var_0[0];

    for(var_3 = 0; var_3 < 2; var_3++) {
      var_2[var_2.size] = var_1[var_3];
    }
  }

  foreach(var_5 in var_2) {
    var_6 = var_5.origin;
    maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack("attack_bomb", 2, 1.0, "attack_bomb", "start_attack");

    if(isDefined(var_5.lastspittime)) {
      var_5.lastspittime = gettime();
    }

    thread spitattack(var_6);
    maps\mp\agents\_scriptedagents::waituntilnotetrack("attack_bomb", "end");
  }

  maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack("attack_bomb", 1, 1.0, "attack_bomb", "end");
}

getchokespittargets(var_0) {
  var_1 = [];
  var_2 = getavailablespitchokes(35.0);
  var_3 = "Not enough 'available' spit choke nodes in range, has " + var_2.size + ", need " + max(var_0, 4);
  var_4 = [];

  foreach(var_6 in level.players) {
    if(!isalive(var_6)) {
      continue;
    }
    var_4[var_4.size] = var_6;
  }

  var_4 = common_scripts\utility::array_randomize(var_4);

  if(var_4.size == 0) {
    return var_1;
  }

  var_8 = max(0, var_0 - var_4.size);
  var_9 = [];

  foreach(var_6 in var_4) {
    for(var_11 = 0; var_11 < var_8 + 1; var_11++) {
      var_9[var_9.size] = sortbydistance(var_2, var_6.origin)[var_11];
    }

    var_8 = 0;
  }

  var_1 = sortbydistance(var_9, self.origin);
  return var_1;
}

getavailablespitchokes(var_0) {
  var_1 = [];
  var_2 = gettime();

  foreach(var_4 in level.spider_spit_choke_structs) {
    var_5 = distance2d(self.origin, var_4.origin);

    if(var_5 > 2500 && var_5 < 256) {
      continue;
    }
    if(var_2 - var_4.lastspittime > var_0 * 1000) {
      var_1[var_1.size] = var_4;
    }
  }

  return var_1;
}

getplayerspittargets(var_0) {
  var_1 = [];
  var_2 = common_scripts\utility::array_randomize(level.players);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];

    if(!isalive(var_4)) {
      continue;
    }
    if(player_in_spit_exclusion_volume(var_4)) {
      continue;
    }
    var_5 = distance2d(self.origin, var_4.origin);

    if(var_5 < 2500 && var_5 > 256 && var_1.size < var_0) {
      var_1[var_1.size] = var_4;
    }
  }

  return var_1;
}

player_in_spit_exclusion_volume(var_0) {
  var_1 = getent("spit_exclusion", "targetname");

  if(var_0 istouching(var_1)) {
    return 1;
  }

  return 0;
}

spitattack(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = self gettagorigin("tag_tail_laser_r") + (self gettagorigin("tag_tail_laser_l") - self gettagorigin("tag_tail_laser_r")) * 0.5;
  var_2 = var_0;
  var_3 = trajectorycalculateinitialvelocity(var_1, var_2, (0, 0, -1500), 3);
  var_4 = spawn("script_model", var_1);
  var_4.angles = self.angles;
  var_4 setModel("mp_ext_alien_hive_physics");
  var_4.owner = self;
  common_scripts\utility::waitframe();

  if(maps\mp\alien\_utility::is_true(level.spider_boss_easter_egg_active)) {
    playFXOnTag(level._effect["easter_egg_spitter_trail"], var_4, "tag_origin");
  } else {
    playFXOnTag(level._effect["projectile_spit_trail"], var_4, "tag_origin");
  }

  var_4 physicslaunchserver((5, 0, 0), var_3 * 22, 1500);
  wait 2.25;
  var_5 = var_4.origin;
  playFX(level._effect["bomb_airburst"], var_5);

  if(maps\mp\alien\_utility::is_true(level.spider_boss_easter_egg_active)) {
    stopFXOnTag(level._effect["easter_egg_spitter_trail"], var_4, "tag_origin");
  } else {
    stopFXOnTag(level._effect["projectile_spit_trail"], var_4, "tag_origin");
  }

  var_4 delete();
  var_6 = 175;

  for(var_7 = 0; var_7 < 2; var_7++) {
    wait(randomfloatrange(0.25, 0.45));
    var_0 = var_0 + (var_6 / 2 - var_7 * var_6, var_6 / 2 - var_7 * var_6, 0);
    var_8 = magicbullet("spider_gas_mp", var_5, var_0, self);
    var_8.owner = self;

    if(isDefined(var_8)) {
      var_8 thread gascloudimpact();
    }
  }
}

gascloudimpact() {
  self waittill("explode", var_0);

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = spawn("trigger_radius", var_0, 0, 150, 128);

  if(!isDefined(var_1)) {
    return;
  }
  var_1.onplayer = 1;
  playFX(level._effect["proj_spit_AOE"], var_0 + (0, 0, 8), (0, 0, 1), (1, 0, 0));
  thread spit_aoe_cloud_damage(var_0, var_1);
  wait 35.0;
  var_1 delete();
}

spit_aoe_cloud_damage(var_0, var_1) {
  var_1 endon("death");
  var_2 = 2.0;
  wait(var_2);

  for(;;) {
    var_1 waittill("trigger", var_3);

    if(!isplayer(var_3)) {
      continue;
    }
    if(!isalive(var_3)) {
      continue;
    }
    damage_player(var_3, var_1);
  }
}

damage_player(var_0, var_1) {
  var_0 shellshock("alien_spitter_gas_cloud", 0.5);
  var_2 = 0.5;
  var_3 = 12.0;
  var_4 = 9.0;
  var_5 = gettime();

  if(!isDefined(var_0.last_spitter_gas_damage_time)) {
    var_6 = var_2;
  } else if(var_0.last_spitter_gas_damage_time + var_2 * 1000.0 > var_5) {
    return;
  } else {
    var_6 = min(var_2, (var_5 - var_0.last_spitter_gas_damage_time) * 0.001);
  }

  if(!maps\mp\alien\_utility::isplayingsolo()) {
    var_7 = int(var_3 * var_6);
  } else {
    var_7 = int(var_4 * var_6);
  }

  if(var_7 > 0) {
    var_0 thread[[level.callbackplayerdamage]](var_1, var_1, var_7, 0, "MOD_SUICIDE", "spider_gas_mp", var_1.origin, (0, 0, 0), "none", 0);
  }

  var_0.last_spitter_gas_damage_time = var_5;
}

closemelee() {
  self endon("vulnerable");

  if(isDefined(self.close_melee_target)) {
    var_0 = anglesToForward(self.angles);
    var_1 = vectornormalize(self.close_melee_target.origin - self.origin);
    var_2 = angleclamp180(vectortoyaw(var_1) - self.angles[1]);
    var_3 = maps\mp\agents\_scriptedagents::getangleindex(var_2);
  } else
    var_3 = randomint(self getanimentrycount("attack_melee_swipe"));

  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("attack_melee_directional", var_3, "attack_melee", "start_melee");
  handlemeleedamage();
  maps\mp\agents\_scriptedagents::waituntilnotetrack("attack_melee", "end");
}

handlemeleedamage() {
  var_0 = level.alien_types[self.alien_type].attributes["swipe_max_distance"] * level.alien_types[self.alien_type].attributes["swipe_max_distance"] * 1.25;
  earthquake(0.5, 0.25, self.origin, var_0 + 200);

  if(isalive(self.close_melee_target)) {
    var_1 = distance2dsquared(self.origin, self.close_melee_target.origin);

    if(distancesquared(self.origin, self.close_melee_target.origin) < var_0) {
      maps\mp\agents\alien\_alien_melee::melee_dodamage(self.close_melee_target, "swipe");
      self.close_melee_target player_impulse(800, vectornormalize(self.close_melee_target.origin - self.origin));
    }
  }
}

player_impulse(var_0, var_1) {
  var_2 = 600.0;
  var_3 = self getvelocity();
  var_4 = var_1 * var_0;
  var_5 = (var_3 + var_4) * (1, 1, 0);
  var_6 = length(var_5);

  if(var_6 >= 400.0) {
    var_5 = vectornormalize(var_5) * 400.0;
  }

  self setvelocity(var_5);
}

portalspawn() {
  self endon("portal_spawn_failed");
  var_0 = 4000.0;
  var_1 = gettime() + var_0;
  var_2 = getportalspawncount();

  for(;;) {
    if(maps\mp\alien\_spawn_director::reserve_custom_spawn_space(var_2, 0) >= var_2) {
      break;
    }

    if(gettime() >= var_1) {
      self notify("portal_spawn_failed");
    }

    wait 0.05;
  }

  maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack("attack_satellite", 0, 1, "attack_satellite", "end", maps\mp\agents\alien\alien_spider\_alien_spider::handlespidernotetracks);
  var_3 = get_mid_point(self gettagorigin("tag_back_laser_l"), self gettagorigin("tag_back_laser_r"));
  var_3 = var_3 + (0, 0, -50);

  if(isDefined(self.portal_ent)) {
    self.portal_ent delete();
  }

  self.portal_ent = spawn("script_model", var_3);
  self.portal_ent setModel("tag_origin");
  self.portal_ent.angles = self.angles;
  common_scripts\utility::waitframe();
  playsoundatpos(self.portal_ent.origin, "alien_fence_shock");
  playFXOnTag(level._effect["beam_vortex"], self.portal_ent, "tag_origin");
  thread playflashfxonspider(2, "tag_back_laser_l", "tag_back_laser_r");
  wait 2;

  for(var_4 = 0; var_4 < var_2; var_4++) {
    spawnthroughportal(self.portal_ent);
    wait 1;
  }

  stopFXOnTag(level._effect["beam_vortex"], self.portal_ent, "tag_origin");
  self notify("stopFlashFxOnSpider");
  maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack("attack_satellite", 1, 1.0, "attack_satellite", "end", maps\mp\agents\alien\alien_spider\_alien_spider::handlespidernotetracks);
  self.portal_ent delete();
}

getportalspawncount() {
  var_0 = level.alien_types[self.alien_type].attributes[self.stage]["portalspawn_count"];
  var_1 = maps\mp\alien\_spawn_director::get_current_spawn_count_multiplier();
  var_0 = var_0 * var_1;

  if(var_0 > 0 && var_0 < 1.0) {
    var_0 = 1;
  }

  return int(var_0);
}

playflashfxonspider(var_0, var_1, var_2) {
  self endon("stopFlashFxOnSpider");
  self endon("portal_spawn_failed");
  self endon("death");
  self endon("spider_stage_end");
  var_3 = int(var_0 / 0.1);

  for(var_4 = 0; var_4 < var_3; var_4++) {
    playFXOnTag(level._effect["beam_fire_flash"], self, var_1);
    playFXOnTag(level._effect["beam_fire_flash"], self, var_2);
    wait 0.1;
  }
}

spawnthroughportal(var_0) {
  var_1 = level.alien_types[self.alien_type].attributes[self.stage]["portalspawn_alien_type"];
  var_2 = maps\mp\alien\_spawn_director::process_spawn(var_1, var_0, undefined);
  level.pending_custom_spawns--;
  var_3 = anglesToForward(var_0.angles);
  var_4 = 1;
  var_5 = "ground_slam";

  if(var_1 != "elite") {
    var_5 = "posture";
  }

  var_2 thread doportalanimation(var_5, var_4, var_3);
}

doportalanimation(var_0, var_1, var_2) {
  self endon("death");

  for(var_3 = 0; var_3 < var_1; var_3++) {
    if(var_0 == "posture") {
      self scragentsetscripted(1);
      maps\mp\alien\_utility::set_alien_emissive(0.2, 1);
      self scragentsetorientmode("face angle abs", self.angles);
      maps\mp\agents\_scriptedagents::playanimuntilnotetrack("posture", "posture", "end", maps\mp\agents\alien\alien_spider\_alien_spider::handlespidernotetracks);
      maps\mp\alien\_utility::set_alien_emissive_default(0.2);
      self scragentsetscripted(0);
    }

    if(var_0 == "ground_slam") {
      self scragentsetscripted(1);
      maps\mp\alien\_utility::set_alien_emissive(0.2, 1);
      self scragentsetorientmode("face angle abs", self.angles);
      maps\mp\agents\_scriptedagents::playanimuntilnotetrack("attack_melee_swipe", "attack_melee", "end", maps\mp\agents\alien\alien_spider\_alien_spider::handlespidernotetracks);
      maps\mp\alien\_utility::set_alien_emissive_default(0.2);
      self scragentsetscripted(0);
    }

    wait(randomfloatrange(0.5, 1.0));
  }
}

eggspawn(var_0) {
  self endon("death");
  self endon("spider_stage_end");
  self endon("egg_interrupted");
  self endon("egg_spawn_failed");
  var_1 = 4000.0;
  var_2 = gettime() + var_1;
  var_3 = geteggspawncount();

  for(;;) {
    if(int(maps\mp\alien\_spawn_director::reserve_custom_spawn_space(var_3, 0)) >= var_3) {
      break;
    }

    if(gettime() >= var_2) {
      var_3 = int(maps\mp\alien\_spawn_director::reserve_custom_spawn_space(var_3, 1));
      break;
    }

    wait 0.05;
  }

  self.egg_spawn_remaining = var_3;

  if(var_3 == 0) {
    self notify("egg_spawn_failed");
    return;
  } else
    thread release_custom_spawn_space_on_interrupt();

  var_4 = findeggspawnpoint(var_0);
  var_5 = common_scripts\utility::array_randomize(var_4.spawn_nodes);
  var_6 = geteggattackindex(var_4.origin);
  maps\mp\agents\alien\_alien_anim_utils::turntowardsentity(var_4);
  playeggattackanim("egg_spawn_enter", var_6);
  playeggspawnsequence(var_5[0], 0);

  if(var_3 > 1) {
    for(var_7 = 0; var_7 < var_3 - 1; var_7++) {
      common_scripts\utility::waitframe();
      playeggspawnsequence(var_5[var_7 + 1], var_7 + 1);

      if(isevenint(var_7) || var_7 == var_3 - 1) {
        playeggattackanim("egg_spawn_fire", var_6);
      }
    }
  } else
    playeggattackanim("egg_spawn_fire", var_6);

  level notify("dlc_vo_notify", "spider_vo", "spider_eggs");
  maps\mp\agents\_scriptedagents::waituntilnotetrack("egg_spawn_fire", "end");
  playeggattackanim("egg_spawn_exit", var_6);
}

release_custom_spawn_space_on_interrupt() {
  self endon("death");
  self endon("melee_complete");
  self waittill("egg_interrupted");
  var_0 = max(0, self.egg_spawn_remaining);
  maps\mp\alien\_spawn_director::release_custom_spawn_space(var_0);
}

isevenint(var_0) {
  if(common_scripts\utility::mod(var_0, 2) == 0) {
    return 1;
  }

  return 0;
}

geteggattackindex(var_0) {
  var_1 = level.alien_types[self.alien_type].attributes["egg_attack_far_distance"] * level.alien_types[self.alien_type].attributes["egg_attack_far_distance"];

  if(distancesquared(var_0, self.origin) < var_1) {
    return 0;
  } else {
    return 1;
  }
}

playeggspawnsequence(var_0, var_1) {
  self.egg_spawn_remaining--;
  thread throwegg(var_0, var_1);
}

playeggattackanim(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = "end";
  }

  maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack(var_0, var_1, 1.0, var_0, var_2, maps\mp\agents\alien\alien_spider\_alien_spider::handlespidernotetracks);
}

geteggspawncount() {
  var_0 = level.alien_types[self.alien_type].attributes[self.stage]["egg_min_count"];
  var_1 = level.alien_types[self.alien_type].attributes[self.stage]["egg_max_count"];
  var_2 = randomfloatrange(var_0, var_1);

  switch (level.players.size) {
    case 1:
      var_3 = 0.75;
      break;
    case 2:
      var_3 = 1;
      break;
    case 3:
      var_3 = 1;
      break;
    default:
      var_3 = 1.0;
      break;
  }

  return int(max(var_3 * var_2, 1));
}

handle_egg_custom_spawn_cleanup(var_0) {
  self endon(var_0);
  common_scripts\utility::waittill_any_return("death", "spider_stage_end");
  maps\mp\alien\_spawn_director::release_custom_spawn_space(1);
}

throwegg(var_0, var_1) {
  var_2 = "egg_hatch" + var_1;
  thread handle_egg_custom_spawn_cleanup(var_2);
  self endon("death");
  self endon("spider_stage_end");

  if(!isDefined(var_0)) {
    return;
  }
  var_3 = self gettagorigin("tag_tail_laser_r") + (self gettagorigin("tag_tail_laser_l") - self gettagorigin("tag_tail_laser_r")) * 0.5;
  var_4 = 2;

  if(abs(self gettagorigin("tag_tail_laser_r")[2] - var_0.origin[2]) >= 128) {
    var_4 = 2.5;
  }

  var_5 = trajectorycalculateinitialvelocity(var_3, var_0.origin, (0, 0, -1500), var_4);
  var_6 = spawn("script_model", var_3);
  var_6.angles = self.angles;
  var_6 setModel("alien_spider_egg");
  var_6.owner = self;
  var_6.targetname = "alien_spider_egg";

  if(isevenint(var_1)) {
    var_6 linkto(self, "tag_tail_laser_r");
  } else {
    var_6 linkto(self, "tag_tail_laser_l");
  }

  wait 0.45;
  thread fx_throw_egg_effect();
  var_6 unlink();
  common_scripts\utility::waitframe();

  if(maps\mp\alien\_utility::is_true(level.spider_boss_easter_egg_active)) {
    playFXOnTag(level._effect["easter_egg_trl"], var_6, "tag_origin");
  } else {
    playFXOnTag(level._effect["egg_launch_trail"], var_6, "tag_origin");
  }

  var_6 thread nonphysicslaunch(var_6, var_5, var_4);
  thread waitforegghatch(var_6, var_0, var_2);
  self waittill(var_2, var_7, var_8, var_9, var_10);

  if(!isDefined(var_8)) {
    return;
  }
  var_11 = !isDefined(var_7);
  thread egg_cleanup(var_11, var_8);

  if(isDefined(var_7)) {
    level notify("egg_" + var_7 + "_hatched");

    if(!var_9) {
      var_0 = spawn("script_origin", var_8.origin);
    }

    var_12 = maps\mp\alien\_spawn_director::process_custom_spawn(var_7, var_0, undefined);

    if(!isDefined(var_12)) {
      return;
    }
    if(var_7 == "brute") {
      var_13 = "egg_hatch";
      var_14 = getanimlength(var_12 getanimentry(var_13, 0));
    } else {
      var_13 = undefined;
      var_14 = 0.1;
    }

    var_12 thread burst_out(var_8, var_0.origin, var_13, var_14);

    if(!var_9) {
      var_0 delete();
      return;
    }
  } else {
    if(isDefined(var_10) && isplayer(var_10)) {
      var_15 = level.alien_types["brute"].attributes["reward"];
      maps\mp\alien\_gamescore::givekillreward(var_10, var_15, "large", "soft");
    }

    maps\mp\alien\_spawn_director::release_custom_spawn_space(1);
  }
}

nonphysicslaunch(var_0, var_1, var_2) {
  var_0 endon("death");
  var_3 = var_0.origin;
  var_0 rotatevelocity((360, 360, 360), var_2);
  var_4 = 0;
  var_5 = 0.05;

  for(var_6 = var_3; var_4 <= var_2; var_4 = var_4 + var_5) {
    var_7 = var_1[0] * var_4;
    var_8 = var_1[1] * var_4;
    var_9 = var_1[2] * var_4 - 750.0 * var_4 * var_4;
    var_0.origin = var_3 + (var_7, var_8, var_9);
    var_6 = var_0.origin;
    wait(var_5);
  }
}

burst_out(var_0, var_1, var_2, var_3) {
  self endon("death");
  maps\mp\alien\_utility::enable_alien_scripted();
  self scragentsetgoalradius(4000);
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", self.angles);
  self scragentsetphysicsmode("noclip");
  self setorigin(var_1);
  var_4 = 1.5;
  var_3 = var_3 / var_4;

  if(isDefined(var_2)) {
    self setanimstate(var_2, 0, var_4);
  }

  var_5 = var_0.origin;
  var_6 = 0.4;
  wait(var_3 * var_6);

  if(maps\mp\alien\_utility::is_true(level.spider_boss_easter_egg_active)) {
    playFX(level._effect["easter_egg_explode"], common_scripts\utility::drop_to_ground(var_5, 32, -500));
  } else {
    playFX(level._effect["egg_explosion"], common_scripts\utility::drop_to_ground(var_5, 32, -500));
  }

  wait 0.1;

  if(isDefined(var_0)) {
    var_0 delete();
  }

  wait(var_3 * (1.0 - var_6));
  self scragentsetphysicsmode("gravity");
  clear_ignore_enemy();
}

egg_cleanup(var_0, var_1) {
  if(!var_0) {
    var_1 common_scripts\utility::waittill_any_timeout(10, "death", "destroyed");
  }

  if(isDefined(var_1)) {
    var_1 delete();
  }
}

clear_ignore_enemy() {
  maps\mp\alien\_utility::disable_alien_scripted();

  foreach(var_1 in maps\mp\alien\_utility::get_players()) {
    self getenemyinfo(var_1);
  }
}

movetoendonground(var_0, var_1, var_2, var_3) {
  var_4 = 2;
  var_5 = 60;
  var_6 = 32;
  var_7 = self getanimentry(var_0, var_1);
  var_8 = getanimlength(var_7);
  var_9 = getmovedelta(var_7, 0, 1);
  var_10 = rotatevector(var_9, self.angles);
  var_11 = self.origin + (var_10[0], var_10[1], var_5);
  var_12 = var_11 - (0, 0, 2 * var_5);
  var_13 = self aiphysicstrace(var_11, var_12, var_6, 65);
  var_14 = var_13 - var_10 + (0, 0, var_4);
  self setorigin(var_14);
}

monitoroutofbound(var_0, var_1, var_2) {
  self endon("death");
  var_3 = 18000;

  while(isDefined(var_0)) {
    var_4 = var_0.classname;
    var_5 = var_0.origin;
    var_6 = "unknown";

    if(isDefined(var_0.model)) {
      var_6 = var_0.model;
    }

    var_7 = "(" + var_6 + ")(" + var_4 + ")(origin:" + var_5 + ")(initialVelocity:" + var_1 + ")(startPos:" + var_2 + ")";

    if(isoutofbound(var_0, var_3)) {
      var_0 notify("out_of_bound");
      var_0 delete();
    }

    common_scripts\utility::waitframe();
  }
}

isoutofbound(var_0, var_1) {
  var_2 = abs(var_0.origin[0]) >= var_1;
  var_3 = abs(var_0.origin[1]) >= var_1;
  var_4 = abs(var_0.origin[2]) >= var_1;
  return var_2 || var_3 || var_4;
}

fx_throw_egg_effect() {
  wait 0.3;
  playFXOnTag(level._effect["egg_launch"], self, "j_tail_3");
}

waitforegghatch(var_0, var_1, var_2) {
  self endon("death");
  self endon(var_2);
  var_3 = lerpeggtospawnpoint(var_0, var_1, var_2);
  var_3 playSound("egg_land");
  var_3 endon("death");
  var_3 endon("destroyed");
  thread processeggdamage(var_3, var_2, 1);
  var_4 = 4;

  if(level.players.size == 1 || maps\mp\alien\_utility::isplayingsolo()) {
    var_4 = 6;
  }

  wait(var_4);
  var_5 = "brute";

  if(maps\mp\alien\_utility::isplayingsolo()) {
    if(!isDefined(self.gooncount)) {
      self.gooncount = 0;
    }

    if(self.gooncount < 2) {
      var_5 = "goon";
      self.gooncount++;
    } else
      self.gooncount = 0;
  }

  self notify(var_2, var_5, var_3, 1);
}

lerpeggtospawnpoint(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::drop_to_ground(var_1.origin, 32, -500) - (0, 0, 3);
  var_4 = 40000;
  var_5 = 5;

  while(distancesquared(var_3, var_0.origin) > var_4 && var_5 > 0) {
    var_5 = var_5 - 0.05;
    wait 0.05;
  }

  var_6 = var_0.origin;
  var_7 = var_0.angles;
  var_8 = (0.0, var_1.angles[1], 0.0);
  var_9 = 0.2;
  var_10 = spawn("script_model", var_6);
  var_10.angles = var_0.angles;
  var_10 setModel("alien_spider_egg");
  var_10.owner = self;
  playFXOnTag(level._effect["egg_glow"], var_10, "tag_origin");
  var_0 delete();
  var_10 scriptmodelplayanim("egg_drone_egg_scale_up");

  while(var_9 <= 1.0) {
    wait 0.05;
    var_10.origin = vectorlerp(var_6, var_3, var_9);
    var_10.angles = vectorlerp(var_7, var_8, var_9);
    var_9 = var_9 + 0.2;
  }

  var_10.origin = var_3;
  var_10.angles = var_8;
  return var_10;
}

processeggdamage(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0 endon("destroyed");
  self endon(var_1);
  var_0 setCanDamage(1);
  var_0 thread process_damage_feedback();
  var_0.maxhealth = level.alien_types[self.alien_type].attributes[self.stage]["egg_health"];
  var_0.health = var_0.maxhealth;
  var_0 waittill("death", var_3);

  if(maps\mp\alien\_utility::is_true(level.spider_boss_easter_egg_active)) {
    playFX(level._effect["easter_egg_explode"], common_scripts\utility::drop_to_ground(var_0.origin, 32, -500));
  } else {
    playFX(level._effect["egg_explosion"], common_scripts\utility::drop_to_ground(var_0.origin, 32, -500));
  }

  level notify("egg_destroyed");
  var_0 playSound("egg_destroy");
  self notify(var_1, undefined, var_0, var_2, var_3);
}

process_damage_feedback() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(isDefined(var_1) && isplayer(var_1)) {
      var_1 thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback("standard");
    }
  }
}

findeggspawnpoint(var_0) {
  var_1 = 2200;
  var_2 = [];
  var_3 = sortbydistance(level.spider_egg_spawn_structs, self.origin);

  for(var_4 = 1; var_4 < var_3.size; var_4++) {
    var_5 = var_3[var_4];

    if(distance(var_5.origin, self.origin) > var_1) {
      break;
    }

    var_2[var_2.size] = var_5;
  }

  var_3 = sortbydistance(var_2, var_0.origin);
  var_6 = 1;
  var_7 = [];
  var_8 = 1.0;

  for(var_9 = 0; var_9 < var_3.size; var_9++) {
    for(var_4 = 0; var_4 < int(var_8); var_4++) {
      var_7[var_7.size] = var_9;
    }

    var_8 = var_8 + var_6;
  }

  var_10 = var_7[randomint(var_7.size)];
  var_11 = var_3[var_10];
  return var_11;
}

posture() {
  self endon("vulnerable");

  if(isDefined(self.enemy)) {
    maps\mp\agents\alien\_alien_anim_utils::turntowardsentity(self.enemy);
  }

  self.posture = 1;
  thread posture_spawn();
  thread posture_internal();
  thread fx_vulnerable_effects();
  level notify("dlc_vo_notify", "spider_vo", "spider_hurt");
  self waittill("end_posture");
  self.posture = 0;
  self notify("posture_finished");
}

fx_vulnerable_effects() {
  self setscriptablepartstate("body", "vulnerable");
  self waittill("posture_finished");
  self setscriptablepartstate("body", "normal");
}

posture_internal() {
  self endon("death");
  self endon("spider_stage_end");
  self endon("killanimscript");
  self endon("downed");
  var_0 = self getanimentrycount("posture");
  var_1 = randomint(var_0);
  maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack("posture", var_1, 1.5, "posture", "end", ::handle_posture_note);
  self notify("end_posture");
}

handle_posture_note(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "mouth_open":
      maps\mp\alien\_utility::set_alien_emissive(0.1, 1.0);
      return;
    case "mouth_close":
      maps\mp\alien\_utility::set_alien_emissive_default(0.1);
      return;
  }
}

get_posture_spawn_event() {
  var_0 = self.posture_spawn_count;
  self.posture_spawn_count++;
  var_1 = level.alien_types[self.alien_type].attributes[self.stage]["event_id_start"];
  var_2 = level.alien_types[self.alien_type].attributes[self.stage]["event_id_end"];

  if(var_2 > var_1) {
    var_0 = var_0 % (var_2 - var_1);
  } else {
    var_0 = 0;
  }

  return "posture_" + (var_0 + var_1);
}

posture_spawn() {
  wait 0.3;
  var_0 = get_posture_spawn_event();
  maps\mp\alien\_spawn_director::activate_spawn_event(var_0);
}

watch_for_vulnerability() {
  self endon("death");
  self endon("spider_stage_end");
  self endon("killanimscript");
  self endon("end_posture");
  var_0 = 0;

  for(var_1 = 1000; var_0 < var_1 && self.health > level.spider_health_padding; var_0 = var_0 + var_2) {
    self waittill("damage", var_2, var_3);
  }

  self notify("end_posture", 1);
}

vulnerable_internal(var_0) {
  self endon("death");
  self endon("spider_stage_end");
  self endon("killanimscript");
  self endon("end_vulnerable");
  wait(var_0);
  self notify("end_vulnerable", 0);
}

traverse() {
  play_retreat();
}

play_retreat() {
  level notify("dlc_vo_notify", "spider_retreat");
  var_0 = common_scripts\utility::getstruct("spider_blocker_01", "targetname");
  var_1 = anglesToForward(var_0.angles);
  maps\mp\agents\alien\alien_spider\_alien_spider::setxyanimscale(1.0);
  self scragentsetphysicsmode("noclip");
  maps\mp\agents\alien\_alien_anim_utils::turntowardsvector(var_1);
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", var_0.angles);
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(self.retreatstate, self.retreatindex, self.retreatstate, "end");
  self.retreatstate = undefined;
  self.retreatindex = undefined;
  self suicide();
}

elevatedretreat() {
  maps\mp\agents\alien\alien_spider\_alien_spider_idle::perform_move(1);
  maps\mp\agents\alien\alien_spider\_alien_spider::setxyanimscale(1.0);
  self.disable_idle_move = 1;
  var_0 = anglesToForward(self.retreatstruct.angles);
  self scragentsetphysicsmode("noclip");
  maps\mp\agents\alien\_alien_anim_utils::turntowardsvector(var_0);
  var_1 = self getanimentry("elevated_retreat", 0);
  self setplayerangles(self.retreatstruct.angles);
  self scragentsetorientmode("face angle abs", self.retreatstruct.angles);
  thread maps\mp\agents\alien\_alien_melee::synch_attack_anim_lerp(var_1, self.retreatstruct.origin, self.retreatstruct.angles);
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("elevated_retreat", 0, "elevated_retreat", "end");
  self setorigin(self.elevatedretreatstruct.origin);
  self setplayerangles(self.elevatedretreatstruct.angles);
}

elevatedreturn() {
  maps\mp\agents\alien\alien_spider\_alien_spider::setxyanimscale(1.0);
  var_0 = anglesToForward(self.elevatedretreatstruct.angles);
  self scragentsetphysicsmode("noclip");
  maps\mp\agents\alien\_alien_anim_utils::turntowardsvector(var_0);
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", self.elevatedretreatstruct.angles);
  self setplayerangles(self.elevatedretreatstruct.angles);
  self scragentsetorientmode("face angle abs", self.elevatedretreatstruct.angles);
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("elevated_retreat", 1, "elevated_retreat", "end");
}

wait_for_downed_state() {
  self endon("killanimscript");
  thread clearn_vulnerable_on_killanim();
  self waittill("vulnerable");
  self notify("egg_interrupted");
  self notify("regen_interrupted");
  self notify("beam_interrupted");
  self notify("projectile_spit_interrupted");
  downed_state();
}

downed_state() {
  maps\mp\agents\alien\alien_spider\_alien_spider::activate_weakpoint();
  maps\mp\alien\_utility::set_alien_emissive(2.0, 0.0);
  var_0 = get_random_anim_index("pain_enter");
  var_1 = self getanimentry("pain_enter", var_0);
  var_2 = getanimlength(var_1);
  thread downed_enter(var_0);
  thread vulnerable_internal(7.0 + var_2);
  level notify("dlc_vo_notify", "spider_vo", "spider_chest");
  self waittill("end_vulnerable", var_3);
  maps\mp\agents\alien\alien_spider\_alien_spider::disable_weakpoints();
  maps\mp\alien\_utility::set_alien_emissive_default(2.0);

  if(!var_3) {
    maps\mp\agents\_scriptedagents::playanimuntilnotetrack("pain_exit", "pain_exit", "end");
  } else {
    maps\mp\agents\_scriptedagents::playanimuntilnotetrack("pain_wounded", "pain_wounded", "end");
  }

  self.vulnerable = 0;
  self notify("downed_state_over");
}

get_random_anim_index(var_0) {
  var_1 = self getanimentrycount(var_0);
  return randomint(var_1);
}

downed_enter(var_0) {
  self endon("end_vulnerable");
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("pain_enter", var_0, "pain_enter", "end");
  var_1 = get_random_anim_index("pain_idle");
  self setanimstate("pain_idle", var_1);
}

clearn_vulnerable_on_killanim() {
  self endon("downed_state_over");
  self waittill("killanimscript");
  self.vulnerable = 0;
}
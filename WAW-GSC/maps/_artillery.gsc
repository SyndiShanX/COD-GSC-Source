/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_artillery.gsc
*****************************************************/

#include maps\_vehicle_aianim;
#include maps\_vehicle;
#include maps\_anim;
#include maps\_utility;
#include common_scripts\utility;
#using_animtree("vehicles");

main(model, type, no_deathmodel) {
  build_template("artillery", model, type);
  build_localinit(::init_local);
  if(isDefined(no_deathmodel) && no_deathmodel) {
    build_deathmodel("artillery_ger_pak43");
    build_deathmodel("artillery_rus_m30");
    build_deathmodel("artillery_jap_47mm");
  } else {
    build_deathmodel("artillery_ger_pak43", "artillery_ger_pak43");
    build_deathmodel("artillery_rus_m30", "artillery_rus_m30");
    build_deathmodel("artillery_jap_47mm", "artillery_jap_47mm_d");
  }
  build_shoot_shock("tankblast");
  build_deathfx("explosions/large_vehicle_explosion", undefined, "explo_metal_rand");
  build_treadfx(type);
  build_life(999, 500, 1500);
  if(issubstr(model, "usa")) {
    build_team("allies");
  } else {
    build_team("axis");
  }
  build_mainturret();
  arty_anims();
}

init_local() {
  self.state = "arty_start";
  self.crewsize = 0;
  self.arty_crew_info["animname"][0] = "commander";
  self.arty_crew_info["tag_a"][0] = "tag_handle_right";
  self.arty_crew_info["tag_b"][0] = "tag_commander";
  self.arty_crew_info["animname"][1] = "arty_left";
  self.arty_crew_info["tag_a"][1] = "tag_shield_left";
  self.arty_crew_info["tag_b"][1] = "tag_shield_left";
  self.arty_crew_info["animname"][2] = "arty_right";
  self.arty_crew_info["tag_a"][2] = "tag_shield_right";
  self.arty_crew_info["tag_b"][2] = "tag_shield_right";
  self.arty_crew_info["animname"][3] = "loader";
  self.arty_crew_info["tag_a"][3] = "tag_handle_left";
  self.arty_crew_info["tag_b"][3] = "tag_loader";
  arty_crew_init(self);
}

arty_crew_init(vehicle) {
  arty_targets = getEntArray(self.target, "targetname");
  arty_spawners = [];
  vehicle.arty_crew = [];
  for(i = 0; i < arty_targets.size; i++) {
    arty_target = arty_targets[i];
    if(issubstr(arty_target.classname, "actor")) {
      arty_spawners[arty_spawners.size] = arty_target;
    }
  }
  for(i = 0; i < arty_spawners.size; i++) {
    vehicle.arty_crew[self.arty_crew.size] = arty_spawners[i] spawn_crewmember();
    vehicle.arty_crew[i].position = i;
    vehicle.arty_crew[i].animname = vehicle.arty_crew_info["animname"][i];
    vehicle.arty_crew[i].tag_a = vehicle.arty_crew_info["tag_a"][i];
    vehicle.arty_crew[i].tag_b = vehicle.arty_crew_info["tag_b"][i];
    vehicle.arty_crew[i] thread arty_crew_death_think(vehicle);
    vehicle.arty_crew[i] thread arty_crew_dismount(vehicle);
    vehicle.crewsize++;
  }
  vehicle notify("arty crew ready");
}

arty_crew_death_think(vehicle) {
  if(self.animname == "commander") {
    return;
  }
  self waittill_multiple("damage", "death");
  self animscripts\shared::placeWeaponOn(self.primaryweapon, "right");
  if(isDefined(vehicle) && (vehicle.health > 0)) {
    vehicle notify("shut down arty");
    vehicle setspeed(0, 100000, 100000);
  }
}

arty_crew_dismount(vehicle) {
  self endon("death");
  vehicle waittill("shut down arty");
  self unlink();
  self animscripts\shared::placeWeaponOn(self.primaryweapon, "right");
  self.deathAnim = self.olddeathAnim;
  self.health = self.oldhealth;
  self.ignoreall = false;
}

artycrew_animation_think(vehicle, tag) {
  vehicle endon("changing positions");
  vehicle endon("shut down arty");
  self endon("death");
  for(;;) {
    self thread arty_crew_play_anim(vehicle, vehicle.state, tag);
    self waittill("artycrew animation done");
  }
}

arty_crew_play_anim(vehicle, animname, tag) {
  vehicle endon("changing positions");
  vehicle endon("shut down arty");
  self endon("death");
  tagOrigin = vehicle getTagOrigin(tag);
  tagAngles = vehicle getTagAngles(tag);
  if(isalive(self)) {
    self animscripted("arty_anim_done", tagOrigin, tagAngles, level.scr_anim[self.animname][animname]);
    self.allowDeath = 1;
    self waittillmatch("arty_anim_done", "end");
    self notify("artycrew animation done");
    vehicle notify("artycrew animation done");
  }
}

arty_fire_loop() {
  self endon("shut down arty");
  self endon("stop_arty_fire_loop");
  while(1) {
    if(self.state == "arty_fire") {
      self waittill("artycrew animation done");
      self notify("arty_fire");
      self fireweapon();
      wait(1);
    }
    wait(1);
  }
}

arty_fire_without_move() {
  self disconnectpaths();
  for(i = 0; i < self.arty_crew.size; i++) {
    if(isalive(self.arty_crew[i])) {
      self.arty_crew[i] animscripts\shared::placeWeaponOn(self.arty_crew[i].primaryweapon, "none");
    }
  }
  for(i = 0; i < self.arty_crew.size; i++) {
    if(isalive(self.arty_crew[i])) {
      self.arty_crew[i] linkto(self, self.arty_crew[i].tag_b);
    }
  }
  for(i = 0; i < self.arty_crew.size; i++) {
    if(isalive(self.arty_crew[i])) {
      self.arty_crew[i] thread artycrew_animation_think(self, self.arty_crew[i].tag_b);
    }
  }
  self waittill("artycrew animation done");
  self.state = "arty_idle";
}

arty_move(goal_pos, stopAtGoal) {
  self endon("shut down arty");
  self endon("death");
  self notify("changing positions");
  for(i = 0; i < self.arty_crew.size; i++) {
    self.arty_crew[i] unlink();
    self.arty_crew[i] endon("death");
  }
  self connectpaths();
  if(isDefined(self.arty_crew[0])) {
    self thread anim_reach_for_all("arty_start", "tag_handle_right", self.arty_crew[0]);
  }
  if(isDefined(self.arty_crew[1])) {
    self thread anim_reach_for_all("arty_start", "tag_shield_left", self.arty_crew[1]);
  }
  if(isDefined(self.arty_crew[2])) {
    self thread anim_reach_for_all("arty_start", "tag_shield_right", self.arty_crew[2]);
  }
  if(isDefined(self.arty_crew[3])) {
    self thread anim_reach_for_all("arty_start", "tag_handle_left", self.arty_crew[3]);
  }
  for(i = 0; i < self.arty_crew.size; i++) {
    self.arty_crew[i] animscripts\shared::placeWeaponOn(self.arty_crew[i].primaryweapon, "right");
  }
  self waittill_multiple("arty crew 1 in place", "arty crew 2 in place", "arty crew 3 in place", "arty crew 4 in place");
  for(i = 0; i < self.arty_crew.size; i++) {
    self.arty_crew[i] animscripts\shared::placeWeaponOn(self.arty_crew[i].primaryweapon, "none");
  }
  self disconnectpaths();
  for(i = 0; i < self.arty_crew.size; i++) {
    self.arty_crew[i] linkto(self, self.arty_crew[i].tag_a);
  }
  for(i = 0; i < self.arty_crew.size; i++) {
    self.arty_crew[i] thread artycrew_animation_think(self, self.arty_crew[i].tag_a);
  }
  self waittill("artycrew animation done");
  self.state = "arty_push";
  if(!isDefined(stopAtGoal)) {
    stopAtGoal = 1;
  }
  self SetSpeed(5, 100, 100);
  self setVehGoalPos(goal_pos, stopAtGoal);
  self waittill("goal");
  self notify("changing positions");
  self.state = "arty_stop";
  for(i = 0; i < self.arty_crew.size; i++) {
    self.arty_crew[i] unlink();
  }
  self connectpaths();
  for(i = 0; i < self.arty_crew.size; i++) {
    self.arty_crew[i] animscripts\shared::placeWeaponOn(self.arty_crew[i].primaryweapon, "right");
  }
  self thread anim_reach_for_all("arty_stop", "tag_commander", self.arty_crew[0]);
  self thread anim_reach_for_all("arty_stop", "tag_shield_left", self.arty_crew[1]);
  self thread anim_reach_for_all("arty_stop", "tag_shield_right", self.arty_crew[2]);
  self thread anim_reach_for_all("arty_stop", "tag_loader", self.arty_crew[3]);
  self waittill_multiple("arty crew 1 in place", "arty crew 2 in place", "arty crew 3 in place", "arty crew 4 in place");
  for(i = 0; i < self.arty_crew.size; i++) {
    self.arty_crew[i] animscripts\shared::placeWeaponOn(self.arty_crew[i].primaryweapon, "none");
  }
  self disconnectpaths();
  for(i = 0; i < self.arty_crew.size; i++) {
    self.arty_crew[i] linkto(self, self.arty_crew[i].tag_b);
  }
  for(i = 0; i < self.arty_crew.size; i++) {
    self.arty_crew[i] thread artycrew_animation_think(self, self.arty_crew[i].tag_b);
  }
  self waittill("artycrew animation done");
  self.state = "arty_idle";
  self notify("arty move done");
}

anim_reach_for_all(the_anim, the_tag, guy) {
  guy anim_reach_solo(guy, the_anim, the_tag, undefined, self);
  self notify("arty crew " + (guy.position + 1) + " in place");
}

arty_fire() {
  self.state = "arty_fire";
  self thread arty_fire_loop();
}

spawn_crewmember() {
  while(!OkTospawn()) {
    wait(0.05);
  }
  spawn = self spawn_ai();
  if(spawn_failed(spawn)) {
    assertex(0, "spawn failed from arty piece");
    return;
  }
  spawn endon("death");
  spawn.olddeathAnim = spawn.deathAnim;
  spawn.allowDeath = true;
  spawn.oldhealth = spawn.health;
  spawn.health = 1;
  spawn.ignoreall = true;
  return spawn;
}

#using_animtree("generic_human");

arty_anims() {
  level.scr_anim["commander"]["arty_fire"] = % crew_artillery1_commander_fire;
  level.scr_anim["commander"]["arty_idle"] = % crew_artillery1_commander_idle;
  level.scr_anim["commander"]["arty_pinned"] = % crew_artillery1_commander_pinneddown;
  level.scr_anim["commander"]["arty_push"] = % crew_artillery1_handleright_push_medium;
  level.scr_anim["commander"]["arty_stop"] = % crew_artillery1_handleright_stop;
  level.scr_anim["commander"]["arty_start"] = % crew_artillery1_handleright_start;
  level.scr_anim["commander"]["arty_rot_cw"] = % crew_artillery1_handleright_rotate_cw;
  level.scr_anim["commander"]["arty_rot_ccw"] = % crew_artillery1_handleright_rotate_ccw;
  level.scr_anim["arty_left"]["arty_fire"] = % crew_artillery1_shieldleft_fire;
  level.scr_anim["arty_left"]["arty_idle"] = % crew_artillery1_shieldleft_idle;
  level.scr_anim["arty_left"]["arty_pinned"] = % crew_artillery1_shieldleft_pinneddown;
  level.scr_anim["arty_left"]["arty_push"] = % crew_artillery1_shieldleft_push_medium;
  level.scr_anim["arty_left"]["arty_stop"] = % crew_artillery1_shieldleft_push_stop;
  level.scr_anim["arty_left"]["arty_start"] = % crew_artillery1_shieldleft_push_start;
  level.scr_anim["arty_left"]["arty_rot_cw"] = % crew_artillery1_shieldleft_rotate_cw;
  level.scr_anim["arty_left"]["arty_rot_ccw"] = % crew_artillery1_shieldleft_rotate_ccw;
  level.scr_anim["arty_right"]["arty_fire"] = % crew_artillery1_shieldright_fire;
  level.scr_anim["arty_right"]["arty_idle"] = % crew_artillery1_shieldright_idle;
  level.scr_anim["arty_right"]["arty_pinned"] = % crew_artillery1_shieldright_pinneddown;
  level.scr_anim["arty_right"]["arty_push"] = % crew_artillery1_shieldright_push_medium;
  level.scr_anim["arty_right"]["arty_stop"] = % crew_artillery1_shieldright_push_stop;
  level.scr_anim["arty_right"]["arty_start"] = % crew_artillery1_shieldright_push_start;
  level.scr_anim["arty_right"]["arty_rot_cw"] = % crew_artillery1_shieldright_rotate_cw;
  level.scr_anim["arty_right"]["arty_rot_ccw"] = % crew_artillery1_shieldright_rotate_ccw;
  level.scr_anim["loader"]["arty_fire"] = % crew_artillery1_loader_fire;
  level.scr_anim["loader"]["arty_idle"] = % crew_artillery1_loader_idle;
  level.scr_anim["loader"]["arty_pinned"] = % crew_artillery1_loader_pinneddown;
  level.scr_anim["loader"]["arty_push"] = % crew_artillery1_handleleft_push_medium;
  level.scr_anim["loader"]["arty_stop"] = % crew_artillery1_handleleft_stop;
  level.scr_anim["loader"]["arty_start"] = % crew_artillery1_handleleft_start;
  level.scr_anim["loader"]["arty_rot_cw"] = % crew_artillery1_handleleft_rotate_cw;
  level.scr_anim["loader"]["arty_rot_ccw"] = % crew_artillery1_handleleft_rotate_ccw;
}
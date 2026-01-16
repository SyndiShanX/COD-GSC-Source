/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_model3.gsc
*****************************************************/

#include maps\_vehicle_aianim;
#include maps\_vehicle;
#include maps\_anim;
#include maps\_utility;
#include common_scripts\utility;
#using_animtree("vehicles");

main(model, type) {
  build_template("model3", model, type);
  build_localinit(::init_local);
  build_deathmodel("artillery_jap_model3", "artillery_jap_model3");
  build_deathmodel("artillery_jap_model3_dist", "artillery_jap_model3_dist");
  build_shoot_shock("tankblast");
  build_deathfx("explosions/large_vehicle_explosion", undefined, "explo_metal_rand");
  build_life(999, 500, 1500);
  build_team("axis");
  build_mainturret();
  arty_anims();
  arty_anims_gun();
}

init_local() {
  self.state = "arty_idle";
  self.animname = "gun";
  self.crewsize = 0;
  self.arty_crew_info["animname"][0] = "commander";
  self.arty_crew_info["tag"][0] = "tag_turret";
  self.arty_crew_info["animname"][1] = "arty_left";
  self.arty_crew_info["tag"][1] = "tag_turret";
  self.arty_crew_info["animname"][2] = "arty_right";
  self.arty_crew_info["tag"][2] = "tag_turret";
  arty_crew_init(self);
  arty_gun_init(self);
}

arty_crew_init(vehicle) {
  if(!isDefined(self) || !isDefined(self.target)) {
    return;
  }
  arty_targets = getentarray(self.target, "targetname");
  arty_spawners = [];
  vehicle.arty_crew = [];
  arty_dismount_trig = undefined;
  for (i = 0; i < arty_targets.size; i++) {
    arty_target = arty_targets[i];
    if(issubstr(arty_target.classname, "actor")) {
      arty_spawners[arty_spawners.size] = arty_target;
    } else if(isDefined(arty_target.script_noteworthy) && arty_target.script_noteworthy == "dismount") {
      arty_dismount_trig = arty_target;
    }
  }
  for (i = 0; i < arty_spawners.size; i++) {
    vehicle.arty_crew[self.arty_crew.size] = arty_spawners[i] spawn_crewmember();
    vehicle.arty_crew[i].position = i;
    vehicle.arty_crew[i] animscripts\shared::placeWeaponOn(vehicle.arty_crew[i].primaryweapon, "none");
    vehicle.arty_crew[i].animname = vehicle.arty_crew_info["animname"][i];
    vehicle.arty_crew[i].tag = vehicle.arty_crew_info["tag"][i];
    vehicle.arty_crew[i] thread artycrew_animation_think(self, vehicle.arty_crew[i].tag, i);
    vehicle.arty_crew[i] thread waittill_dismount_trig(arty_dismount_trig, vehicle.arty_crew[i], self);
    vehicle.arty_crew[i] thread crew_watcher(self);
    vehicle thread dismount_vehicle();
    vehicle.crewsize++;
  }
  vehicle notify("arty crew ready");
}

arty_gun_init(vehicle) {
  if(!isDefined(self) || !isDefined(self.target)) {
    return;
  }
  vehicle thread artygun_animation_think(vehicle, level.gun_load_anim);
}

dismount_vehicle() {
  self waittill("dismount crew");
  for (i = 0; i < self.arty_crew.size; i++) {
    if(isalive(self.arty_crew[i])) {
      self.arty_crew[i] unlink();
      self.arty_crew[i] animscripts\shared::placeWeaponOn(self.arty_crew[i].primaryweapon, "right");
    }
  }
  self notify("crew dismounted");
}

waittill_dismount_trig(trig, gunner, vehicle) {
  gunner endon("death");
  trig waittill("trigger");
  vehicle notify("dismount crew");
}

crew_watcher(vehicle) {
  self waittill_any("bulletwhizby", "death");
  vehicle notify("dismount crew");
}

artycrew_animation_think(vehicle, tag, crew_num) {
  vehicle endon("crew dismounted");
  self endon("death");
  for (;;) {
    self notify("playing_crew_prefire");
    self arty_crew_play_anim(vehicle, "arty_prefire", tag);
    self arty_crew_play_anim(vehicle, "arty_fire", tag);
  }
}

artygun_animation_think(vehicle, animation) {
  vehicle endon("crew dismounted");
  for (;;) {
    if(isDefined(vehicle.arty_crew[2])) {
      vehicle.arty_crew[2] waittill("playing_crew_prefire");
      vehicle SetFlaggedAnimKnobRestart("gunanim", animation);
    } else {
      return;
    }
  }
}

arty_crew_play_anim(vehicle, animname, tag) {
  vehicle endon("crew dismounted");
  tagOrigin = vehicle getTagOrigin(tag);
  tagAngles = vehicle getTagAngles(tag);
  if(isalive(self)) {
    self anim_single_solo(self, animname, tag, undefined, vehicle);
    self.allowDeath = 1;
    self notify("artycrew animation done");
    vehicle notify("artycrew animation done");
  }
}

arty_fire(vehicle) {
  vehicle fireweapon();
}

spawn_crewmember() {
  spawn = self spawn_ai();
  if(spawn_failed(spawn)) {
    assertex(0, "spawn failed from arty piece");
    return;
  }
  spawn endon("death");
  spawn.allowDeath = true;
  spawn.oldhealth = spawn.health;
  spawn.health = 1;
  return spawn;
}

arty_anims_gun() {
  level.gun_load_anim = % v_model3_load;
}

#using_animtree("generic_human");

arty_anims() {
  level.scr_anim["commander"]["arty_fire"] = % crew_model3_driver_fire;
  level.scr_anim["commander"]["arty_idle"] = % crew_model3_driver_idle;
  level.scr_anim["commander"]["arty_prefire"] = % crew_model3_driver_prefire;
  level.scr_anim["arty_left"]["arty_fire"] = % crew_model3_loader_left_fire;
  level.scr_anim["arty_left"]["arty_idle"] = % crew_model3_loader_left_idle;
  level.scr_anim["arty_left"]["arty_prefire"] = % crew_model3_loader_left_prefire;
  level.scr_anim["arty_right"]["arty_fire"] = % crew_model3_loader_right_fire;
  level.scr_anim["arty_right"]["arty_idle"] = % crew_model3_loader_right_idle;
  level.scr_anim["arty_right"]["arty_prefire"] = % crew_model3_loader_right_prefire;
}
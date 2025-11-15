/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombietron_ai_engineer.gsc
********************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombietron_utility;

precache_engineer_fx() {
  level._effect["engineer_groundhit"] = LoadFx("maps/zombie/fx_zombie_boss_grnd_hit");
  level._effect["engineer_spawn"] = LoadFx("maps/zombie/fx_zombie_boss_spawn");
}

#using_animtree("generic_human");
engineer_prespawn() {
  maps\_zombietron_spawner::zombie_spawn_init("boss_zombie");
  self boss_zombie_idle_setup();
  self.idle_override = ::play_idle;
  self.a.overrideIdleAnimArray = [];
  self.a.overrideIdleAnimArray[0] = % ai_zombie_boss_idle_a;
  self.a.overrideIdleAnimArray[1] = % ai_zombie_boss_idle_b;
  self.anim_array[self.animname]["stop"]["stand"]["none"]["idle"] = self.a.overrideIdleAnimArray;
  self notify("zombie_init_done");
}

play_idle() {
  transTime = 0.2;
  idleAnim = self.a.overrideIdleAnimArray[randomInt(self.a.overrideIdleAnimArray.size)];
  self SetFlaggedAnimKnobAllRestart("idle", idleAnim, % body, 1, transTime, self.animplaybackrate);
  self animscripts\zombie_shared::DoNoteTracks("idle");
}

boss_zombie_idle_setup() {
  self.a.array["turn_left_45"] = % exposed_tracking_turn45L;
  self.a.array["turn_left_90"] = % exposed_tracking_turn90L;
  self.a.array["turn_left_135"] = % exposed_tracking_turn135L;
  self.a.array["turn_left_180"] = % exposed_tracking_turn180L;
  self.a.array["turn_right_45"] = % exposed_tracking_turn45R;
  self.a.array["turn_right_90"] = % exposed_tracking_turn90R;
  self.a.array["turn_right_135"] = % exposed_tracking_turn135R;
  self.a.array["turn_right_180"] = % exposed_tracking_turn180L;
  self.a.array["exposed_idle"] = array( % ai_zombie_boss_idle_a, % ai_zombie_boss_idle_b);
  self.a.array["straight_level"] = % ai_zombie_boss_idle_a;
  self.a.array["stand_2_crouch"] = % ai_zombie_shot_leg_right_2_crawl;
}

init_engineer_zombie_anims() {
  if(!isDefined(level._zombie_melee)) {
    level._zombie_melee = [];
  }
  if(!isDefined(level._zombie_walk_melee)) {
    level._zombie_walk_melee = [];
  }
  if(!isDefined(level._zombie_run_melee)) {
    level._zombie_run_melee = [];
  }
  if(!isDefined(level._zombie_melee_crawl)) {
    level._zombie_melee_crawl = [];
  }
  if(!isDefined(level._zombie_stumpy_melee)) {
    level._zombie_stumpy_melee = [];
  }
  if(!isDefined(level._zombie_deaths)) {
    level._zombie_deaths = [];
  }
  if(!isDefined(level._zombie_rise_anims)) {
    level._zombie_rise_anims = [];
  }
  if(!isDefined(level._zombie_rise_death_anims)) {
    level._zombie_rise_death_anims = [];
  }
  if(!isDefined(level._zombie_tesla_death)) {
    level._zombie_tesla_death = [];
  }
  level._zombie_deaths["boss_zombie"] = [];
  level._zombie_deaths["boss_zombie"][0] = % ai_zombie_boss_death;
  level._zombie_deaths["boss_zombie"][1] = % ai_zombie_boss_death_a;
  level._zombie_deaths["boss_zombie"][2] = % ai_zombie_boss_death_explode;
  level._zombie_deaths["boss_zombie"][3] = % ai_zombie_boss_death_mg;
  level.scr_anim["boss_zombie"]["death1"] = % ai_zombie_boss_death;
  level.scr_anim["boss_zombie"]["death2"] = % ai_zombie_boss_death_a;
  level.scr_anim["boss_zombie"]["death3"] = % ai_zombie_boss_death_explode;
  level.scr_anim["boss_zombie"]["death4"] = % ai_zombie_boss_death_mg;
  level.scr_anim["boss_zombie"]["walk1"] = % ai_zombie_boss_walk_a;
  level.scr_anim["boss_zombie"]["walk2"] = % ai_zombie_boss_walk_a;
  level.scr_anim["boss_zombie"]["walk3"] = % ai_zombie_boss_walk_a;
  level.scr_anim["boss_zombie"]["walk4"] = % ai_zombie_boss_walk_a;
  level.scr_anim["boss_zombie"]["walk5"] = % ai_zombie_boss_walk_a;
  level.scr_anim["boss_zombie"]["walk6"] = % ai_zombie_boss_walk_a;
  level.scr_anim["boss_zombie"]["walk7"] = % ai_zombie_boss_walk_a;
  level.scr_anim["boss_zombie"]["walk8"] = % ai_zombie_boss_walk_a;
  level.scr_anim["boss_zombie"]["run1"] = % ai_zombie_boss_walk_a;
  level.scr_anim["boss_zombie"]["run2"] = % ai_zombie_boss_walk_a;
  level.scr_anim["boss_zombie"]["run3"] = % ai_zombie_boss_walk_a;
  level.scr_anim["boss_zombie"]["run4"] = % ai_zombie_boss_walk_a;
  level.scr_anim["boss_zombie"]["run5"] = % ai_zombie_boss_walk_a;
  level.scr_anim["boss_zombie"]["run6"] = % ai_zombie_boss_walk_a;
  level.scr_anim["boss_zombie"]["sprint1"] = % ai_zombie_boss_sprint_a;
  level.scr_anim["boss_zombie"]["sprint2"] = % ai_zombie_boss_sprint_b;
  level.scr_anim["boss_zombie"]["sprint3"] = % ai_zombie_boss_sprint_a;
  level.scr_anim["boss_zombie"]["sprint4"] = % ai_zombie_boss_sprint_b;
  level._zombie_melee["boss_zombie"] = [];
  level._zombie_walk_melee["boss_zombie"] = [];
  level._zombie_run_melee["boss_zombie"] = [];
  level._zombie_melee["boss_zombie"][0] = % ai_zombie_boss_attack_multiswing_a;
  level._zombie_melee["boss_zombie"][1] = % ai_zombie_boss_attack_multiswing_b;
  level._zombie_melee["boss_zombie"][2] = % ai_zombie_boss_attack_swing_overhead;
  level._zombie_melee["boss_zombie"][3] = % ai_zombie_boss_attack_swing_swipe;
  level._zombie_melee["boss_zombie"][4] = % ai_zombie_boss_headbutt;
  level._zombie_walk_melee["boss_zombie"][0] = % ai_zombie_boss_headbutt;
  level._zombie_run_melee["boss_zombie"][0] = % ai_zombie_boss_attack_running;
  level._zombie_run_melee["boss_zombie"][1] = % ai_zombie_boss_attack_sprinting;
  level._zombie_run_melee["boss_zombie"][2] = % ai_zombie_boss_attack_running;
  level._zombie_run_melee["boss_zombie"][2] = % ai_zombie_boss_run_hitground;
  level._zombie_tesla_death["boss_zombie"] = [];
  level._zombie_tesla_death["boss_zombie"][0] = % ai_zombie_boss_death_explode;
  level._zombie_tesla_death["boss_zombie"][1] = % ai_zombie_boss_death_explode;
  level._zombie_tesla_death["boss_zombie"][2] = % ai_zombie_boss_death_explode;
  level._zombie_tesla_death["boss_zombie"][3] = % ai_zombie_boss_death_explode;
  level._zombie_rise_anims["boss_zombie"] = [];
  level._zombie_rise_death_anims["boss_zombie"] = [];
}
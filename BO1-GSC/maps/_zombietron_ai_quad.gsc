/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombietron_ai_quad.gsc
****************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombietron_utility;

wait_for_leap() {
  while(1) {
    wait(5);
    self.custom_attack = true;
    wait(.5);
    self.custom_attack = false;
  }
}
#using_animtree("generic_human");

quad_prespawn() {
  self.animname = "quad_zombie";
  self.custom_idle_setup = maps\_zombietron_ai_quad::quad_zombie_idle_setup;
  self.a.idleAnimOverrideArray = [];
  self.a.idleAnimOverrideArray["stand"] = [];
  self.a.idleAnimOverrideArray["stand"] = [];
  self.a.idleAnimOverrideArray["stand"][0][0] = % ai_zombie_quad_idle;
  self.a.idleAnimOverrideWeights["stand"][0][0] = 10;
  self.a.idleAnimOverrideArray["stand"][0][1] = % ai_zombie_quad_idle_2;
  self.a.idleAnimOverrideWeights["stand"][0][1] = 10;
  self maps\_zombietron_spawner::zombie_spawn_init("quad_zombie");
  self setTeamForEntity("axis");
  self playSound("zmb_quad_spawn");
  self thread quad_vox();
  self thread quad_close();
  self set_default_attack_properties();
  self thread maps\_zombietron_ai_quad::quad_zombie_think();
  self.moveplaybackrate = 1.3;
  self.is_quad = true;
}
quad_zombie_idle_setup() {
  self.a.array["turn_left_45"] = % exposed_tracking_turn45L;
  self.a.array["turn_left_90"] = % exposed_tracking_turn90L;
  self.a.array["turn_left_135"] = % exposed_tracking_turn135L;
  self.a.array["turn_left_180"] = % exposed_tracking_turn180L;
  self.a.array["turn_right_45"] = % exposed_tracking_turn45R;
  self.a.array["turn_right_90"] = % exposed_tracking_turn90R;
  self.a.array["turn_right_135"] = % exposed_tracking_turn135R;
  self.a.array["turn_right_180"] = % exposed_tracking_turn180L;
  self.a.array["exposed_idle"] = array(%ai_zombie_quad_idle, %ai_zombie_quad_idle_2);
  self.a.array["straight_level"] = % ai_zombie_quad_idle;
  self.a.array["stand_2_crouch"] = % ai_zombie_shot_leg_right_2_crawl;
}
init_quad_zombie_anims() {
  level.scr_anim["quad_zombie"]["death1"] = % ai_zombie_quad_death;
  level.scr_anim["quad_zombie"]["death2"] = % ai_zombie_quad_death_2;
  level.scr_anim["quad_zombie"]["death3"] = % ai_zombie_quad_death_3;
  level.scr_anim["quad_zombie"]["death4"] = % ai_zombie_quad_death_4;
  level.scr_anim["quad_zombie"]["walk1"] = % ai_zombie_quad_crawl_sprint_3;
  level.scr_anim["quad_zombie"]["walk2"] = % ai_zombie_quad_crawl_sprint_3;
  level.scr_anim["quad_zombie"]["walk3"] = % ai_zombie_quad_crawl_sprint_3;
  level.scr_anim["quad_zombie"]["walk4"] = % ai_zombie_quad_crawl_sprint_3;
  level.scr_anim["quad_zombie"]["walk5"] = % ai_zombie_quad_crawl_sprint_3;
  level.scr_anim["quad_zombie"]["walk6"] = % ai_zombie_quad_crawl_sprint_3;
  level.scr_anim["quad_zombie"]["walk7"] = % ai_zombie_quad_crawl_sprint_3;
  level.scr_anim["quad_zombie"]["walk8"] = % ai_zombie_quad_crawl_sprint_3;
  level.scr_anim["quad_zombie"]["run1"] = % ai_zombie_quad_crawl_sprint_3;
  level.scr_anim["quad_zombie"]["run2"] = % ai_zombie_quad_crawl_sprint_3;
  level.scr_anim["quad_zombie"]["run3"] = % ai_zombie_quad_crawl_sprint_3;
  level.scr_anim["quad_zombie"]["run4"] = % ai_zombie_quad_crawl_sprint_3;
  level.scr_anim["quad_zombie"]["run5"] = % ai_zombie_quad_crawl_sprint_3;
  level.scr_anim["quad_zombie"]["run6"] = % ai_zombie_quad_crawl_sprint_3;
  level.scr_anim["quad_zombie"]["sprint1"] = % ai_zombie_quad_crawl_sprint_3;
  level.scr_anim["quad_zombie"]["sprint2"] = % ai_zombie_quad_crawl_sprint_3;
  level.scr_anim["quad_zombie"]["sprint3"] = % ai_zombie_quad_crawl_sprint_3;
  level.scr_anim["quad_zombie"]["sprint4"] = % ai_zombie_quad_crawl_sprint_3;
  level.scr_anim["quad_zombie"]["crawl1"] = % ai_zombie_quad_crawl_sprint_3;
  level.scr_anim["quad_zombie"]["crawl2"] = % ai_zombie_quad_crawl_sprint_3;
  level.scr_anim["quad_zombie"]["crawl3"] = % ai_zombie_quad_crawl_sprint_3;
  level.scr_anim["quad_zombie"]["crawl4"] = % ai_zombie_quad_crawl_sprint_3;
  level.scr_anim["quad_zombie"]["crawl5"] = % ai_zombie_quad_crawl_sprint_3;
  level.scr_anim["quad_zombie"]["crawl6"] = % ai_zombie_quad_crawl_sprint_3;
  level.scr_anim["quad_zombie"]["crawl_hand_1"] = % ai_zombie_walk_on_hands_a;
  level.scr_anim["quad_zombie"]["crawl_hand_2"] = % ai_zombie_walk_on_hands_b;
  level.scr_anim["quad_zombie"]["crawl_sprint1"] = % ai_zombie_quad_crawl_sprint_3;
  level.scr_anim["quad_zombie"]["crawl_sprint2"] = % ai_zombie_quad_crawl_sprint_3;
  level.scr_anim["quad_zombie"]["crawl_sprint3"] = % ai_zombie_quad_crawl_sprint_3;
  if(!isDefined(level._zombie_melee)) {
    level._zombie_melee = [];
  }
  if(!isDefined(level._zombie_walk_melee)) {
    level._zombie_walk_melee = [];
  }
  if(!isDefined(level._zombie_run_melee)) {
    level._zombie_run_melee = [];
  }
  level._zombie_melee["quad_zombie"] = [];
  level._zombie_walk_melee["quad_zombie"] = [];
  level._zombie_run_melee["quad_zombie"] = [];
  level._zombie_melee["quad_zombie"][0] = % ai_zombie_quad_attack;
  level._zombie_melee["quad_zombie"][1] = % ai_zombie_quad_attack_2;
  level._zombie_melee["quad_zombie"][2] = % ai_zombie_quad_attack_3;
  level._zombie_melee["quad_zombie"][3] = % ai_zombie_quad_attack_4;
  level._zombie_melee["quad_zombie"][4] = % ai_zombie_quad_attack_5;
  level._zombie_melee["quad_zombie"][5] = % ai_zombie_quad_attack_6;
  level._zombie_melee["quad_zombie"][6] = % ai_zombie_quad_attack_double;
  level._zombie_melee["quad_zombie"][7] = % ai_zombie_quad_attack_double_2;
  level._zombie_melee["quad_zombie"][8] = % ai_zombie_quad_attack_double_3;
  level._zombie_melee["quad_zombie"][9] = % ai_zombie_quad_attack_double_4;
  level._zombie_melee["quad_zombie"][10] = % ai_zombie_quad_attack_double_5;
  level._zombie_melee["quad_zombie"][11] = % ai_zombie_quad_attack_double_6;
  if(isDefined(level.quad_zombie_anim_override)) {
    [[level.quad_zombie_anim_override]]();
  }
  if(!isDefined(level._zombie_melee_crawl)) {
    level._zombie_melee_crawl = [];
  }
  level._zombie_melee_crawl["quad_zombie"] = [];
  level._zombie_melee_crawl["quad_zombie"][0] = % ai_zombie_attack_crawl;
  level._zombie_melee_crawl["quad_zombie"][1] = % ai_zombie_attack_crawl_lunge;
  if(!isDefined(level._zombie_stumpy_melee)) {
    level._zombie_stumpy_melee = [];
  }
  level._zombie_stumpy_melee["quad_zombie"] = [];
  level._zombie_stumpy_melee["quad_zombie"][0] = % ai_zombie_walk_on_hands_shot_a;
  level._zombie_stumpy_melee["quad_zombie"][1] = % ai_zombie_walk_on_hands_shot_b;
  if(!isDefined(level._zombie_tesla_death)) {
    level._zombie_tesla_death = [];
  }
  level._zombie_tesla_death["quad_zombie"] = [];
  level._zombie_tesla_death["quad_zombie"][0] = % ai_zombie_quad_death_tesla;
  level._zombie_tesla_death["quad_zombie"][1] = % ai_zombie_quad_death_tesla_2;
  level._zombie_tesla_death["quad_zombie"][2] = % ai_zombie_quad_death_tesla_3;
  level._zombie_tesla_death["quad_zombie"][3] = % ai_zombie_quad_death_tesla_4;
  if(!isDefined(level._zombie_tesla_crawl_death)) {
    level._zombie_tesla_crawl_death = [];
  }
  level._zombie_tesla_crawl_death["quad_zombie"] = [];
  level._zombie_tesla_crawl_death["quad_zombie"][0] = % ai_zombie_tesla_crawl_death_a;
  level._zombie_tesla_crawl_death["quad_zombie"][1] = % ai_zombie_tesla_crawl_death_b;
  if(!isDefined(level._zombie_deaths)) {
    level._zombie_deaths = [];
  }
  level._zombie_deaths["quad_zombie"] = [];
  level._zombie_deaths["quad_zombie"][0] = % ai_zombie_quad_death;
  level._zombie_deaths["quad_zombie"][1] = % ai_zombie_quad_death_2;
  level._zombie_deaths["quad_zombie"][2] = % ai_zombie_quad_death_3;
  level._zombie_deaths["quad_zombie"][3] = % ai_zombie_quad_death_4;
  level._zombie_deaths["quad_zombie"][4] = % ai_zombie_quad_death_5;
  level._zombie_deaths["quad_zombie"][5] = % ai_zombie_quad_death_6;
  if(!isDefined(level._zombie_rise_anims)) {
    level._zombie_rise_anims = [];
  }
  level._zombie_rise_anims["quad_zombie"] = [];
  level._zombie_rise_anims["quad_zombie"][1]["walk"][0] = % ai_zombie_quad_traverse_ground_crawlfast;
  level._zombie_rise_anims["quad_zombie"][1]["run"][0] = % ai_zombie_quad_traverse_ground_crawlfast;
  level._zombie_rise_anims["quad_zombie"][1]["sprint"][0] = % ai_zombie_quad_traverse_ground_crawlfast;
  level._zombie_rise_anims["quad_zombie"][2]["walk"][0] = % ai_zombie_quad_traverse_ground_crawlfast;
  if(!isDefined(level._zombie_rise_death_anims)) {
    level._zombie_rise_death_anims = [];
  }
  level._zombie_rise_death_anims["quad_zombie"] = [];
  level._zombie_rise_death_anims["quad_zombie"][1]["in"][0] = % ai_zombie_traverse_ground_v1_deathinside;
  level._zombie_rise_death_anims["quad_zombie"][1]["in"][1] = % ai_zombie_traverse_ground_v1_deathinside_alt;
  level._zombie_rise_death_anims["quad_zombie"][1]["out"][0] = % ai_zombie_traverse_ground_v1_deathoutside;
  level._zombie_rise_death_anims["quad_zombie"][1]["out"][1] = % ai_zombie_traverse_ground_v1_deathoutside_alt;
  level._zombie_rise_death_anims["quad_zombie"][2]["in"][0] = % ai_zombie_traverse_ground_v2_death_low;
  level._zombie_rise_death_anims["quad_zombie"][2]["in"][1] = % ai_zombie_traverse_ground_v2_death_low_alt;
  level._zombie_rise_death_anims["quad_zombie"][2]["out"][0] = % ai_zombie_traverse_ground_v2_death_high;
  level._zombie_rise_death_anims["quad_zombie"][2]["out"][1] = % ai_zombie_traverse_ground_v2_death_high_alt;
  if(!isDefined(level._zombie_run_taunt)) {
    level._zombie_run_taunt = [];
  }
  if(!isDefined(level._zombie_board_taunt)) {
    level._zombie_board_taunt = [];
  }
  level._zombie_run_taunt["quad_zombie"] = [];
  level._zombie_board_taunt["quad_zombie"] = [];
  level._zombie_board_taunt["quad_zombie"][0] = % ai_zombie_quad_taunt;
  level._zombie_board_taunt["quad_zombie"][1] = % ai_zombie_quad_taunt_2;
  level._zombie_board_taunt["quad_zombie"][2] = % ai_zombie_quad_taunt_3;
  level._zombie_board_taunt["quad_zombie"][3] = % ai_zombie_quad_taunt_4;
  level._zombie_board_taunt["quad_zombie"][4] = % ai_zombie_quad_taunt_5;
  level._zombie_board_taunt["quad_zombie"][5] = % ai_zombie_quad_taunt_6;
}
quad_vox() {
  self endon("death");
  wait(5);
  quad_wait = 5;
  while(1) {
    players = getplayers();
    for(i = 0; i < players.size; i++) {
      if(DistanceSquared(self.origin, players[i].origin) > 1200 * 1200) {
        self playSound("zmb_quad_amb");
        quad_wait = 7;
      } else if(DistanceSquared(self.origin, players[i].origin) > 200 * 200) {
        self playSound("zmb_quad_vox");
        quad_wait = 5;
      } else if(DistanceSquared(self.origin, players[i].origin) < 150 * 150) {
        wait(.05);
      }
    }
    wait randomfloatrange(1, quad_wait);
  }
}
quad_close() {
  self endon("death");
  while(1) {
    players = getplayers();
    for(i = 0; i < players.size; i++) {
      if(is_player_valid(players[i], true)) {
        if(DistanceSquared(self.origin, players[i].origin) < 150 * 150) {
          self playSound("zmb_quad_close");
          wait randomfloatrange(1, 2);
        }
      }
    }
    wait_network_frame();
  }
}
set_leap_attack_properties() {
  self.pathEnemyFightDist = 320;
  self.goalradius = 320;
  self.maxsightdistsqrd = 256 * 256;
  self.can_leap = true;
  self.in_special_attack = true;
}
set_default_attack_properties() {
  self.pathEnemyFightDist = 64;
  self.meleeAttackDist = 64;
  self.goalradius = 16;
  self.maxsightdistsqrd = 128 * 128;
  self.can_leap = false;
  self.in_special_attack = undefined;
}
check_wait() {
  min_dist = 96;
  max_dist = 144;
  if(isDefined(self.enemy)) {
    delta = self.enemy.origin - self.origin;
    dist = length(delta);
    if(dist > min_dist && dist < max_dist) {
      self set_leap_attack_properties();
    } else {
      self set_default_attack_properties();
    }
  }
}
quad_zombie_think() {
  self endon("death");
  self.specialAttack = maps\_zombietron_ai_quad::TryLeap;
  self.state = "waiting";
  self.isAttacking = false;
  self.nextSpecial = GetTime();
  for(;;) {
    switch (self.state) {
      case "waiting":
        check_wait();
        break;
      case "leaping":
        break;
    }
    wait_network_frame();
  }
}
trackCollision() {
  self endon("death");
  self endon("stop_coll");
  while(1) {
    check = self GetHitEntType();
    if(check != "none") {
      self thread quad_stop_leap();
      self notify("stop_leap");
      self notify("stop_coll");
    }
    wait_network_frame();
  }
}
quad_finish_leap() {
  self endon("death");
  self.state = "waiting";
  self.isAttacking = false;
  self.nextSpecial = GetTime() + 2000;
  self animMode("none");
  self.syncedMeleeTarget = undefined;
  self OrientMode("face enemy");
}
quad_stop_leap() {
  self endon("death");
  self SetFlaggedAnimKnobAllRestart("attack", %ai_zombie_quad_attack_leap_loop_out, %body, 1, .1, self.moveplaybackrate);
  self animscripts\zombie_shared::DoNoteTracks("attack");
  self quad_finish_leap();
}
quad_leap_attack() {
  self endon("death");
  self endon("stop_leap");
  self.state = "leaping";
  self.isAttacking = true;
  if(isDefined(self.enemy)) {
    self.syncedMeleeTarget = self.enemy;
    angles = VectorToAngles(self.enemy.origin - self.origin);
    self OrientMode("face angle", angles[1]);
  }
  self set_default_attack_properties();
  self.goalradius = 4;
  self animMode("nogravity");
  self notify("stop_coll");
  self SetFlaggedAnimKnobAllRestart("attack", %ai_zombie_quad_attack_leap_loop, %body, 1, .1, self.moveplaybackrate);
  time = getAnimLength(%ai_zombie_quad_attack_leap_loop);
  wait time;
  self SetFlaggedAnimKnobAllRestart("attack", %ai_zombie_quad_attack_leap_attack, %body, 1, .1, self.moveplaybackrate);
  time = getAnimLength(%ai_zombie_quad_attack_leap_attack);
  wait time;
  self OrientMode("face enemy");
  wait 1;
  quad_finish_leap();
}
TryLeap() {
  if(self.state == "leaping") {
    return true;
  }
  if(!isDefined(self.enemy)) {
    return false;
  }
  if(DistanceSquared(self.origin, self.enemy.origin) > 512 * 512) {
    return false;
  }
  if(self.a.pose == "prone") {
    return false;
  }
  if(!self.can_leap) {
    return false;
  }
  self thread maps\_zombietron_ai_quad::quad_leap_attack();
  self notify("special_attack");
  return true;
}
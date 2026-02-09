/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombietron_ai_dog.gsc
***************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombietron_utility;

precache_dog_fx() {
  level._effect["lightning_dog_spawn"] = Loadfx("maps/zombie/fx_zombie_dog_lightning_buildup");
  level._effect["dog_eye_glow"] = Loadfx("maps/zombie/fx_zombie_dog_eyes");
  level._effect["dog_gib"] = Loadfx("maps/zombie/fx_zombie_dog_explosion");
  level._effect["dog_trail_fire"] = Loadfx("maps/zombie/fx_zombie_dog_fire_trail");
  level._effect["dog_trail_ash"] = Loadfx("maps/zombie/fx_zombie_dog_ash_trail");
}
#using_animtree("dog");
dog_prespawn() {
  self.targetname = "zombie_dog";
  self.script_noteworthy = undefined;
  self.animname = "zombie_dog";
  self.allowdeath = true;
  self.allowpain = false;
  self.force_gib = true;
  self.is_zombie = true;
  self.has_legs = true;
  self.is_dog = true;
  self.gibbed = false;
  self.head_gibbed = false;
  animscripts\zombie_dog_init::change_anim_set(getDvar(#"zombie_dog_animset"));
  self.grenadeawareness = 0;
  self.badplaceawareness = 0;
  self.ignoreSuppression = true;
  self.suppressionThreshold = 1;
  self.noDodgeMove = true;
  self.dontShootWhileMoving = true;
  self.pathenemylookahead = 0;
  self.badplaceawareness = 0;
  self.chatInitialized = false;
  self setTeamForEntity("axis");
  self dog_fx_eye_glow();
  self dog_fx_trail();
  self thread dog_death();
  self thread dog_move_audio();
  self.a.disablePain = true;
  self disable_react();
  self ClearEnemy();
  self ClearGoalVolume();
  self.flame_damage_time = 0;
  self notify("zombie_init_done");
}
dog_fx_eye_glow() {
  self.fx_dog_eye = spawn("script_model", self GetTagOrigin("J_EyeBall_LE"));
  assert(isDefined(self.fx_dog_eye));
  self.fx_dog_eye.angles = self GetTagAngles("J_EyeBall_LE");
  self.fx_dog_eye setModel("tag_origin");
  self.fx_dog_eye LinkTo(self, "J_EyeBall_LE");
}
dog_fx_trail() {
  if(randomint(100) > level.zombie_vars["dog_fire_trail_percent"]) {
    self.fx_dog_trail_type = level._effect["dog_trail_ash"];
    self.fx_dog_trail_sound = "dog_trail_fire_breath";
  } else {
    self.a.nodeath = true;
    self.fx_dog_trail_type = level._effect["dog_trail_fire"];
    self.fx_dog_trail_sound = "dog_trail_fire";
  }
  self.fx_dog_trail = spawn("script_model", self GetTagOrigin("tag_origin"));
  assert(isDefined(self.fx_dog_trail));
  self.fx_dog_trail.angles = self GetTagAngles("tag_origin");
  self.fx_dog_trail setModel("tag_origin");
  self.fx_dog_trail LinkTo(self, "tag_origin");
}
dog_death() {
  self waittill("death");
  if(!isDefined(self)) {
    return;
  }
  self playSound("zmb_hellhound_vox_death");
  if(isDefined(self.attacker) && isai(self.attacker)) {
    self.attacker notify("killed", self);
  }
  assert(isDefined(self.fx_dog_eye));
  self.fx_dog_eye delete();
  assert(isDefined(self.fx_dog_trail));
  self.fx_dog_trail delete();
  if(isDefined(self.a.nodeath)) {
    level thread dog_explode_fx(self.origin);
    self delete();
  }
}
dog_explode_fx(origin) {
  if(!isDefined(origin)) {
    return;
  }
  fx = spawn("script_model", origin);
  fx setModel("tag_origin");
  playFXOnTag(level._effect["dog_gib"], fx, "tag_origin");
  fx playSound("zmb_hellhound_explode");
  wait(5);
  fx delete();
}
dog_player_damage() {
  if(isDefined(self.tank) || isDefined(self.heli)) {
    return;
  }
  self DoDamage(100, self.origin);
}
dog_move_audio() {
  self endon("death");
  level.doggy_movement_vox = 0;
  level.doggy_attack_vox = 0;
  self.playing_attack_vox = false;
  self.playing_movement_vox = false;
  wait(RandomFloatRange(.25, 1));
  while(1) {
    players = get_players();
    for(i = 0; i < players.size; i++) {
      if((DistanceSquared(self.origin, players[i].origin) < 50 * 50) && (level.doggy_attack_vox <= 3) && !self.playing_attack_vox) {
        level.doggy_attack_vox++;
        self.playing_attack_vox = true;
        self thread vox_timer("attack");
        self playSound("zmb_hellhound_vox_attack");
      }
    }
    if(!self.playing_movement_vox && !self.playing_attack_vox && (level.doggy_movement_vox <= 8)) {
      level.doggy_movement_vox++;
      self.playing_movement_vox = true;
      self thread vox_timer("movement");
      self playSound("zmb_hellhound_vox_move");
    }
    wait(.1);
  }
}
vox_timer(type) {
  self endon("death");
  switch (type) {
    case "attack":
      wait(RandomFloatRange(1.5, 2.5));
      self.playing_attack_vox = false;
      if(level.doggy_attack_vox > 0) {
        level.doggy_attack_vox--;
      }
      break;
    case "movement":
      wait(RandomFloatRange(3, 5));
      self.playing_movement_vox = false;
      if(level.doggy_movement_vox > 0) {
        level.doggy_movement_vox--;
      }
      break;
  }
}
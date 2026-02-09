/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_zombiemode_ai_director\.csc
*****************************************************/

#include clientscripts\_utility;
#include clientscripts\_music;
#include clientscripts\_zombiemode_weapons;
#include clientscripts\_zombiemode;

init() {
  level._effect["director_weapon_light"] = loadfx("maps/zombie/fx_zombie_boss_weapon_light");
  level._effect["director_weapon_light_big"] = loadfx("maps/zombie/fx_zombie_boss_weapon_light_big");
  level._effect["director_weapon_light_blink"] = loadfx("maps/zombie/fx_zombie_boss_weapon_light_blink");
  level._effect["director_weapon_docile"] = loadfx("maps/zombie/fx_zombie_boss_weapon_docile");
  level._effect["director_death_head"] = loadfx("maps/zombie/fx_zombie_boss_death_head");
  level._effect["director_death_torso"] = loadfx("maps/zombie/fx_zombie_boss_death_torso");
  level._effect["director_death_weapon"] = loadfx("maps/zombie/fx_zombie_boss_weapon_defeat");
  level._effect["director_impact_humangun"] = loadfx("weapon/human_gun/fx_hgun_impact_exp_lrg");
  level._effect["director_impact_humangun_upgraded"] = loadfx("weapon/human_gun/fx_hgun_impact_exp_lrg_ug");
  level thread zombie_director_aggro();
}
zombie_director_aggro() {
  while(1) {
    level waittill("ZDA");
    players = GetLocalPlayers();
    for(i = 0; i < players.size; i++) {
      player = players[i];
      PlayRumbleOnPosition(i, "explosion_generic", player.origin);
      player Earthquake(0.4, 1.7, player.origin, 1000);
    }
  }
}
player_blur() {
  self endon("death");
  self endon("disconnect");
  if(!isDefined(self.blurred)) {
    self.blurred = true;
    self SetBlur(5, 0.1);
    wait(1.7);
    self SetBlur(0, 0.1);
    self.blurred = undefined;
  }
}
zombie_director_light_update(local_client_num, set, newEnt) {
  self endon("death");
  self endon("entityshutdown");
  if(local_client_num != 0) {
    return;
  }
  if(!isDefined(self.humangun_zombie_hit_response)) {
    self.humangun_zombie_hit_response = ::humangun_director_hit_response;
  }
  players = GetLocalPlayers();
  if(!isDefined(self.health_state)) {
    self.health_state = "pristine";
    self.health_fx = "director_weapon_docile";
  } else {
    if(self.health_state == "pristine") {
      self.health_state = "health_full";
      self.health_fx = "director_weapon_light_big";
    } else if(self.health_state == "health_full") {
      self.health_state = "health_damage_one";
      self.health_fx = "director_weapon_light";
    } else if(self.health_state == "health_damage_one") {
      self.health_state = "health_damage_two";
      self.health_fx = "director_weapon_light_blink";
    } else if(self.health_state == "health_damage_two") {
      self.health_state = undefined;
    }
  }
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(isDefined(player._zombie_director_light_fx)) {
      DeleteFx(i, player._zombie_director_light_fx);
      player._zombie_director_light_fx = undefined;
    }
    player._zombie_director_light_fx = playFXOnTag(i, level._effect[self.health_fx], self, "tag_light");
  }
}
zombie_director_death(local_client_num, set, newEnt) {
  self endon("death");
  self endon("entityshutdown");
  if(local_client_num != 0) {
    return;
  }
  players = GetLocalPlayers();
  if(set) {
    for(i = 0; i < players.size; i++) {
      player = players[i];
      if(isDefined(player.zombie_director_impact_humangun)) {
        DeleteFx(i, player.zombie_director_impact_humangun);
        player.zombie_director_impact_humangun = undefined;
      }
      if(isDefined(player._zombie_director_death_torso_fx)) {
        DeleteFx(i, player._zombie_director_death_torso_fx);
        player._zombie_director_death_torso_fx = undefined;
      }
      player.zombie_director_impact_humangun = playFXOnTag(i, level._effect["director_death_head"], self, "j_neck");
      player._zombie_director_death_torso_fx = playFXOnTag(i, level._effect["director_death_torso"], self, "J_SpineLower");
    }
  } else {
    for(i = 0; i < players.size; i++) {
      player = players[i];
      if(isDefined(player.zombie_director_impact_humangun)) {
        DeleteFx(i, player.zombie_director_impact_humangun);
        player.zombie_director_impact_humangun = undefined;
      }
      if(isDefined(player._zombie_director_death_torso_fx)) {
        DeleteFx(i, player._zombie_director_death_torso_fx);
        player._zombie_director_death_torso_fx = undefined;
      }
    }
  }
}
humangun_director_hit_response(local_client_num, set, newEnt, upgraded) {
  self endon("death");
  self endon("entityshutdown");
  if(local_client_num != 0) {
    return;
  }
  players = GetLocalPlayers();
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(isDefined(player._zombie_director_impact_humangun_fx)) {
      DeleteFx(i, player._zombie_director_impact_humangun_fx);
      player._zombie_director_impact_humangun_fx = undefined;
    }
    impact_fx = level._effect["director_impact_humangun"];
    if(upgraded) {
      impact_fx = level._effect["director_impact_humangun_upgraded"];
    }
    player._zombie_director_impact_humangun_fx = playFXOnTag(i, impact_fx, self, "J_SpineLower");
  }
}
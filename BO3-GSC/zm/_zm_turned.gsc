/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_turned.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\math_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_utility;
#using scripts\zm\gametypes\_spawnlogic;
#using scripts\zm\gametypes\_zm_gametype;
#namespace zm_turned;

function init() {
  dvar = getdvarstring("ui_gametype");
  if(dvar == "zcleansed") {
    level.weaponzmturnedmelee = getweapon("zombiemelee");
    level.weaponzmturnedmeleedw = getweapon("zombiemelee_dw");
    if(!isDefined(level.vsmgr_prio_visionset_zombie_turned)) {
      level.vsmgr_prio_visionset_zombie_turned = 123;
    }
    visionset_mgr::register_info("visionset", "zombie_turned", 1, level.vsmgr_prio_visionset_zombie_turned, 1, 1);
    clientfield::register("toplayer", "turned_ir", 1, 1, "int");
    clientfield::register("allplayers", "player_has_eyes", 1, 1, "int");
    clientfield::register("allplayers", "player_eyes_special", 1, 1, "int");
    thread setup_zombie_exerts();
  }
}

function setup_zombie_exerts() {
  wait(0.05);
  level.exert_sounds[1]["burp"] = "null";
  level.exert_sounds[1]["hitmed"] = "null";
  level.exert_sounds[1]["hitlrg"] = "null";
}

function delay_turning_on_eyes() {
  self endon("death");
  self endon("disconnect");
  util::wait_network_frame();
  wait(0.1);
  self clientfield::set("player_has_eyes", 1);
}

function turn_to_zombie() {
  if(self.sessionstate == "playing" && (isDefined(self.is_zombie) && self.is_zombie) && (!(isDefined(self.laststand) && self.laststand))) {
    return;
  }
  if(isDefined(self.is_in_process_of_zombify) && self.is_in_process_of_zombify) {
    return;
  }
  while(isDefined(self.is_in_process_of_humanify) && self.is_in_process_of_humanify) {
    wait(0.1);
  }
  if(!level flag::get("pregame")) {
    self playsoundtoplayer("evt_spawn", self);
    playsoundatposition("evt_disappear_3d", self.origin);
    if(!self.is_zombie) {
      playsoundatposition((("vox_plr_" + randomintrange(0, 4)) + "_exert_death_high_") + randomintrange(0, 4), self.origin);
    }
  }
  self._can_score = 1;
  self clientfield::set("player_has_eyes", 0);
  self ghost();
  self turned_disable_player_weapons();
  self notify("clear_red_flashing_overlay");
  self notify("zombify");
  self.is_in_process_of_zombify = 1;
  self.team = level.zombie_team;
  self.pers["team"] = level.zombie_team;
  self.sessionteam = level.zombie_team;
  util::wait_network_frame();
  self zm_gametype::onspawnplayer();
  self freezecontrols(1);
  self.is_zombie = 1;
  self setburn(0);
  if(isDefined(self.turned_visionset) && self.turned_visionset) {
    visionset_mgr::deactivate("visionset", "zombie_turned", self);
    util::wait_network_frame();
    util::wait_network_frame();
    if(!isDefined(self)) {
      return;
    }
  }
  visionset_mgr::activate("visionset", "zombie_turned", self);
  self.turned_visionset = 1;
  self clientfield::set_to_player("turned_ir", 1);
  self zm_audio::setexertvoice(1);
  self.laststand = undefined;
  util::wait_network_frame();
  if(!isDefined(self)) {
    return;
  }
  self enableweapons();
  self show();
  playsoundatposition("evt_appear_3d", self.origin);
  playsoundatposition("zmb_zombie_spawn", self.origin);
  self thread delay_turning_on_eyes();
  self thread turned_player_buttons();
  self setperk("specialty_playeriszombie");
  self setperk("specialty_unlimitedsprint");
  self setperk("specialty_fallheight");
  self turned_give_melee_weapon();
  self setmovespeedscale(1);
  self.animname = "zombie";
  self disableoffhandweapons();
  self allowstand(1);
  self allowprone(0);
  self allowcrouch(0);
  self allowads(0);
  self allowjump(0);
  self disableweaponcycling();
  self setmovespeedscale(1);
  self setsprintduration(4);
  self setsprintcooldown(0);
  self stopshellshock();
  self.maxhealth = 256;
  self.health = 256;
  self.meleedamage = 1000;
  self detachall();
  if(isDefined(level.custom_zombie_player_loadout)) {
    self[[level.custom_zombie_player_loadout]]();
  } else {
    self setModel("c_zom_player_zombie_fb");
    self.voice = "american";
    self.skeleton = "base";
  }
  self.shock_onpain = 0;
  self disableinvulnerability();
  if(isDefined(level.player_movement_suppressed)) {
    self freezecontrols(level.player_movement_suppressed);
  } else if(!(isDefined(self.hostmigrationcontrolsfrozen) && self.hostmigrationcontrolsfrozen)) {
    self freezecontrols(0);
  }
  self.is_in_process_of_zombify = 0;
}

function turn_to_human() {
  if(self.sessionstate == "playing" && (!(isDefined(self.is_zombie) && self.is_zombie)) && (!(isDefined(self.laststand) && self.laststand))) {
    return;
  }
  if(isDefined(self.is_in_process_of_humanify) && self.is_in_process_of_humanify) {
    return;
  }
  while(isDefined(self.is_in_process_of_zombify) && self.is_in_process_of_zombify) {
    wait(0.1);
  }
  self playsoundtoplayer("evt_spawn", self);
  playsoundatposition("evt_disappear_3d", self.origin);
  self clientfield::set("player_has_eyes", 0);
  self ghost();
  self notify("humanify");
  self.is_in_process_of_humanify = 1;
  self.is_zombie = 0;
  self notify("clear_red_flashing_overlay");
  self.team = self.prevteam;
  self.pers["team"] = self.prevteam;
  self.sessionteam = self.prevteam;
  util::wait_network_frame();
  self zm_gametype::onspawnplayer();
  self.maxhealth = 100;
  self.health = 100;
  self freezecontrols(1);
  if(self hasweapon(level.weaponzmdeaththroe)) {
    self takeweapon(level.weaponzmdeaththroe);
  }
  self unsetperk("specialty_playeriszombie");
  self unsetperk("specialty_unlimitedsprint");
  self unsetperk("specialty_fallheight");
  self turned_enable_player_weapons();
  self zm_audio::setexertvoice(0);
  self.turned_visionset = 0;
  visionset_mgr::deactivate("visionset", "zombie_turned", self);
  self clientfield::set_to_player("turned_ir", 0);
  self setmovespeedscale(1);
  self.ignoreme = 0;
  self.shock_onpain = 1;
  self enableweaponcycling();
  self allowstand(1);
  self allowprone(1);
  self allowcrouch(1);
  self allowads(1);
  self allowjump(1);
  self turnedhuman();
  self enableoffhandweapons();
  self stopshellshock();
  self.laststand = undefined;
  self.is_burning = undefined;
  self.meleedamage = undefined;
  self detachall();
  self[[level.givecustomcharacters]]();
  if(!self hasweapon(level.weaponbasemelee)) {
    self giveweapon(level.weaponbasemelee);
  }
  util::wait_network_frame();
  if(!isDefined(self)) {
    return;
  }
  self disableinvulnerability();
  if(isDefined(level.player_movement_suppressed)) {
    self freezecontrols(level.player_movement_suppressed);
  } else if(!(isDefined(self.hostmigrationcontrolsfrozen) && self.hostmigrationcontrolsfrozen)) {
    self freezecontrols(0);
  }
  self show();
  playsoundatposition("evt_appear_3d", self.origin);
  self.is_in_process_of_humanify = 0;
}

function deletezombiesinradius(origin) {
  zombies = zombie_utility::get_round_enemy_array();
  maxradius = 128;
  foreach(zombie in zombies) {
    if(isDefined(zombie) && isalive(zombie) && (!(isDefined(zombie.is_being_used_as_spawner) && zombie.is_being_used_as_spawner))) {
      if(distancesquared(zombie.origin, origin) < (maxradius * maxradius)) {
        playFX(level._effect["wood_chunk_destory"], zombie.origin);
        zombie thread silentlyremovezombie();
      }
      wait(0.05);
    }
  }
}

function turned_give_melee_weapon() {
  assert(isDefined(self.weaponzmturnedmelee));
  assert(self.weaponzmturnedmelee != level.weaponnone);
  self.turned_had_knife = self hasweapon(level.weaponbasemelee);
  if(isDefined(self.turned_had_knife) && self.turned_had_knife) {
    self takeweapon(level.weaponbasemelee);
  }
  self giveweapon(self.weaponzmturnedmeleedw);
  self givemaxammo(self.weaponzmturnedmeleedw);
  self giveweapon(self.weaponzmturnedmelee);
  self givemaxammo(self.weaponzmturnedmelee);
  self switchtoweapon(self.weaponzmturnedmeleedw);
  self switchtoweapon(self.weaponzmturnedmelee);
}

function turned_player_buttons() {
  self endon("disconnect");
  self endon("humanify");
  level endon("end_game");
  while(isDefined(self.is_zombie) && self.is_zombie) {
    if(self attackbuttonpressed() || self adsbuttonpressed() || self meleebuttonpressed()) {
      if(math::cointoss()) {
        self notify("bhtn_action_notify", "attack");
      }
      while(self attackbuttonpressed() || self adsbuttonpressed() || self meleebuttonpressed()) {
        wait(0.05);
      }
    }
    if(self usebuttonpressed()) {
      self notify("bhtn_action_notify", "taunt");
      while(self usebuttonpressed()) {
        wait(0.05);
      }
    }
    if(self issprinting()) {
      while(self issprinting()) {
        self notify("bhtn_action_notify", "sprint");
        wait(0.05);
      }
    }
    wait(0.05);
  }
}

function turned_disable_player_weapons() {
  if(isDefined(self.is_zombie) && self.is_zombie) {
    return;
  }
  weaponinventory = self getweaponslist();
  self.lastactiveweapon = self getcurrentweapon();
  self setlaststandprevweap(self.lastactiveweapon);
  self.laststandpistol = undefined;
  self.hadpistol = 0;
  if(!isDefined(self.weaponzmturnedmelee)) {
    self.weaponzmturnedmelee = level.weaponzmturnedmelee;
  }
  if(!isDefined(self.weaponzmturnedmeleedw)) {
    self.weaponzmturnedmeleedw = level.weaponzmturnedmeleedw;
  }
  self takeallweapons();
  self disableweaponcycling();
}

function turned_enable_player_weapons() {
  self takeallweapons();
  self enableweaponcycling();
  self enableoffhandweapons();
  self.turned_had_knife = undefined;
  rottweil_weapon = getweapon("rottweil72");
  if(isDefined(level.humanify_custom_loadout)) {
    self thread[[level.humanify_custom_loadout]]();
    return;
  }
  if(!self hasweapon(rottweil_weapon)) {
    self giveweapon(rottweil_weapon);
    self switchtoweapon(rottweil_weapon);
  }
  if(!(isDefined(self.is_zombie) && self.is_zombie) && !self hasweapon(level.start_weapon)) {
    if(!self hasweapon(level.weaponbasemelee)) {
      self giveweapon(level.weaponbasemelee);
    }
    self zm_utility::give_start_weapon(0);
  }
  if(self hasweapon(rottweil_weapon)) {
    self setweaponammoclip(rottweil_weapon, 2);
    self setweaponammostock(rottweil_weapon, 0);
  }
  if(self hasweapon(level.start_weapon)) {
    self givemaxammo(level.start_weapon);
  }
  if(self hasweapon(self zm_utility::get_player_lethal_grenade())) {
    self getweaponammoclip(self zm_utility::get_player_lethal_grenade());
  } else {
    self giveweapon(self zm_utility::get_player_lethal_grenade());
  }
  self setweaponammoclip(self zm_utility::get_player_lethal_grenade(), 2);
}

function get_farthest_available_zombie(player) {
  while(true) {
    zombies = array::get_all_closest(player.origin, getaiteamarray(level.zombie_team));
    for(x = 0; x < zombies.size; x++) {
      zombie = zombies[x];
      if(isDefined(zombie) && isalive(zombie) && (!(isDefined(zombie.in_the_ground) && zombie.in_the_ground)) && (!(isDefined(zombie.gibbed) && zombie.gibbed)) && (!(isDefined(zombie.head_gibbed) && zombie.head_gibbed)) && (!(isDefined(zombie.is_being_used_as_spawnpoint) && zombie.is_being_used_as_spawnpoint)) && zombie zm_utility::in_playable_area()) {
        zombie.is_being_used_as_spawnpoint = 1;
        return zombie;
      }
    }
    wait(0.05);
  }
}

function get_available_human() {
  players = getplayers();
  foreach(player in players) {
    if(!(isDefined(player.is_zombie) && player.is_zombie)) {
      return player;
    }
  }
}

function silentlyremovezombie() {
  self.skip_death_notetracks = 1;
  self.nodeathragdoll = 1;
  self dodamage(self.maxhealth * 2, self.origin, self, self, "none", "MOD_SUICIDE");
  self zm_utility::self_delete();
}

function getspawnpoint() {
  spawnpoint = self spawnlogic::getspawnpoint_dm(level._turned_zombie_respawnpoints);
  return spawnpoint;
}
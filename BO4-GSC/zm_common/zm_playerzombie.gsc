/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_playerzombie.gsc
***********************************************/

#include scripts\core_common\aat_shared;
#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\ai\zombie_death;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai_puppeteer_shared;
#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\globallogic\globallogic_vehicle;
#include scripts\core_common\hud_util_shared;
#include scripts\core_common\killcam_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\lui_shared;
#include scripts\core_common\potm_shared;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\status_effects\status_effects;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\core_common\visionset_mgr_shared;
#include scripts\zm_common\bb;
#include scripts\zm_common\gametypes\globallogic;
#include scripts\zm_common\gametypes\globallogic_player;
#include scripts\zm_common\gametypes\globallogic_scriptmover;
#include scripts\zm_common\gametypes\globallogic_spawn;
#include scripts\zm_common\gametypes\zm_gametype;
#include scripts\zm_common\util;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_blockers;
#include scripts\zm_common\zm_crafting;
#include scripts\zm_common\zm_daily_challenges;
#include scripts\zm_common\zm_equipment;
#include scripts\zm_common\zm_ffotd;
#include scripts\zm_common\zm_game_module;
#include scripts\zm_common\zm_hero_weapon;
#include scripts\zm_common\zm_hud;
#include scripts\zm_common\zm_laststand;
#include scripts\zm_common\zm_melee_weapon;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_placeable_mine;
#include scripts\zm_common\zm_player;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_quick_spawning;
#include scripts\zm_common\zm_round_logic;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_wallbuy;
#include scripts\zm_common\zm_weapons;
#include scripts\zm_common\zm_zonemgr;

#namespace zm_playerzombie;

zombify_player() {
  self zm_score::player_died_penalty();
  self recordplayerdeathzombies();

  if(isDefined(level.var_1025308b)) {
    self[[level.var_1025308b]]();
  }

  if(isDefined(level.func_clone_plant_respawn) && isDefined(self.s_clone_plant)) {
    self[[level.func_clone_plant_respawn]]();
    return;
  }

  if(!isDefined(zombie_utility::get_zombie_var(#"zombify_player")) || !zombie_utility::get_zombie_var(#"zombify_player")) {
    self thread zm_player::spawnspectator();
    return;
  }

  self val::set(#"zombify_player", "ignoreme", 1);
  self.is_zombie = 1;
  self.zombification_time = gettime();
  self.team = level.zombie_team;
  self notify(#"zombified");

  if(isDefined(self.revivetrigger)) {
    self.revivetrigger delete();
  }

  self.revivetrigger = undefined;
  self setmovespeedscale(0.3);
  self reviveplayer();
  self takeallweapons();
  self disableweaponcycling();
  self disableoffhandweapons();
  self thread zombie_utility::zombie_eye_glow();
  self thread playerzombie_player_damage();
  self thread playerzombie_soundboard();
}

playerzombie_player_damage() {
  self endon(#"death", #"disconnect");
  self thread playerzombie_infinite_health();
  self.zombiehealth = level.zombie_health;

  while(true) {
    waitresult = self waittill(#"damage");
    attacker = waitresult.attacker;
    amount = waitresult.amount;

    if(!isDefined(attacker) || !isplayer(attacker)) {
      waitframe(1);
      continue;
    }

    self.zombiehealth -= amount;

    if(self.zombiehealth <= 0) {
      self thread playerzombie_downed_state();
      self waittill(#"playerzombie_downed_state_done");
      self.zombiehealth = level.zombie_health;
    }
  }
}

playerzombie_downed_state() {
  self endon(#"death", #"disconnect");
  downtime = 15;
  starttime = gettime();
  endtime = starttime + downtime * 1000;
  self thread playerzombie_downed_hud();
  self.playerzombie_soundboard_disable = 1;
  self thread zombie_utility::zombie_eye_glow_stop();
  self disableweapons();
  self allowstand(0);
  self allowcrouch(0);
  self allowprone(1);

  while(gettime() < endtime) {
    waitframe(1);
  }

  self.playerzombie_soundboard_disable = 0;
  self thread zombie_utility::zombie_eye_glow();
  self enableweapons();
  self allowstand(1);
  self allowcrouch(0);
  self allowprone(0);
  self notify(#"playerzombie_downed_state_done");
}

playerzombie_downed_hud() {

  self endon(#"death", #"disconnect");
  text = newdebughudelem(self);
  text.alignx = "<dev string:x38>";
  text.aligny = "<dev string:x41>";
  text.horzalign = "<dev string:x4a>";
  text.vertalign = "<dev string:x58>";
  text.foreground = 1;
  text.font = "<dev string:x66>";
  text.fontscale = 1.8;
  text.alpha = 0;
  text.color = (1, 1, 1);
  text settext(#"zombie/playerzombie_downed");
  text.y = -113;

  if(self issplitscreen()) {
    text.y = -137;
  }

  text fadeovertime(0.1);
  text.alpha = 1;
  self waittill(#"playerzombie_downed_state_done");
  text fadeovertime(0.1);
  text.alpha = 0;

}

playerzombie_infinite_health() {
  self endon(#"death", #"disconnect");
  bighealth = 100000;

  while(true) {
    if(self.health < bighealth) {
      self.health = bighealth;
    }

    wait 0.1;
  }
}

playerzombie_soundboard() {
  self endon(#"death", #"disconnect");
  self.playerzombie_soundboard_disable = 0;
  self.buttonpressed_use = 0;
  self.buttonpressed_attack = 0;
  self.buttonpressed_ads = 0;
  self.usesound_waittime = 3000;
  self.usesound_nexttime = gettime();
  usesound = "playerzombie_usebutton_sound";
  self.attacksound_waittime = 3000;
  self.attacksound_nexttime = gettime();
  attacksound = "playerzombie_attackbutton_sound";
  self.adssound_waittime = 3000;
  self.adssound_nexttime = gettime();
  adssound = "playerzombie_adsbutton_sound";
  self.inputsound_nexttime = gettime();

  while(true) {
    if(self.playerzombie_soundboard_disable) {
      waitframe(1);
      continue;
    }

    if(self usebuttonpressed()) {
      if(self can_do_input("use")) {
        self thread playerzombie_play_sound(usesound);
        self thread playerzombie_waitfor_buttonrelease("use");
        self.usesound_nexttime = gettime() + self.usesound_waittime;
      }
    } else if(self attackbuttonpressed()) {
      if(self can_do_input("attack")) {
        self thread playerzombie_play_sound(attacksound);
        self thread playerzombie_waitfor_buttonrelease("attack");
        self.attacksound_nexttime = gettime() + self.attacksound_waittime;
      }
    } else if(self adsbuttonpressed()) {
      if(self can_do_input("ads")) {
        self thread playerzombie_play_sound(adssound);
        self thread playerzombie_waitfor_buttonrelease("ads");
        self.adssound_nexttime = gettime() + self.adssound_waittime;
      }
    }

    waitframe(1);
  }
}

can_do_input(inputtype) {
  if(gettime() < self.inputsound_nexttime) {
    return 0;
  }

  cando = 0;

  switch (inputtype) {
    case #"use":
      if(gettime() >= self.usesound_nexttime && !self.buttonpressed_use) {
        cando = 1;
      }

      break;
    case #"attack":
      if(gettime() >= self.attacksound_nexttime && !self.buttonpressed_attack) {
        cando = 1;
      }

      break;
    case #"ads":
      if(gettime() >= self.usesound_nexttime && !self.buttonpressed_ads) {
        cando = 1;
      }

      break;
    default:
      assertmsg("<dev string:x70>" + inputtype);
      break;
  }

  return cando;
}

playerzombie_play_sound(alias) {
  self zm_utility::play_sound_on_ent(alias);
}

playerzombie_waitfor_buttonrelease(inputtype) {
  if(inputtype != "use" && inputtype != "attack" && inputtype != "ads") {
    assertmsg("<dev string:xa1>" + inputtype + "<dev string:xd7>");
    return;
  }

  notifystring = "waitfor_buttonrelease_" + inputtype;
  self notify(notifystring);
  self endon(notifystring);

  if(inputtype == "use") {
    self.buttonpressed_use = 1;

    while(self usebuttonpressed()) {
      waitframe(1);
    }

    self.buttonpressed_use = 0;
    return;
  }

  if(inputtype == "attack") {
    self.buttonpressed_attack = 1;

    while(self attackbuttonpressed()) {
      waitframe(1);
    }

    self.buttonpressed_attack = 0;
    return;
  }

  if(inputtype == "ads") {
    self.buttonpressed_ads = 1;

    while(self adsbuttonpressed()) {
      waitframe(1);
    }

    self.buttonpressed_ads = 0;
  }
}
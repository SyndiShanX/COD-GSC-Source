/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_playerzombie.gsc
***********************************************/

#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_puppeteer_shared;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\globallogic\globallogic_vehicle;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\killcam_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\potm_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\status_effects\status_effects;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\bb;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\gametypes\globallogic_player;
#using scripts\zm_common\gametypes\globallogic_scriptmover;
#using scripts\zm_common\gametypes\globallogic_spawn;
#using scripts\zm_common\gametypes\zm_gametype;
#using scripts\zm_common\util;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_blockers;
#using scripts\zm_common\zm_crafting;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_ffotd;
#using scripts\zm_common\zm_game_module;
#using scripts\zm_common\zm_hud;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_melee_weapon;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_placeable_mine;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_quick_spawning;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_wallbuy;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;
#namespace zm_playerzombie;

function zombify_player() {
  self zm_score::player_died_penalty();
  self recordplayerdeathzombies();

  if(isDefined(level.var_1025308b)) {
    self[[level.var_1025308b]]();
  }

  if(isDefined(level.func_clone_plant_respawn) && isDefined(self.s_clone_plant)) {
    self[[level.func_clone_plant_respawn]]();
    return;
  }

  gametype = hash(util::get_game_type());

  if(gametype == # "zsurvival") {
    self val::reset(#"laststand", "ignoreme");
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
  self thread playerzombie_player_damage();
  self thread playerzombie_soundboard();
}

function playerzombie_player_damage() {
  self endon(#"death", #"disconnect");
  self thread playerzombie_infinite_health();
  self.zombiehealth = level.zombie_health;

  while(true) {
    waitresult = self waittill(#"damage");
    attacker = waitresult.attacker;
    amount = waitresult.amount;

    if(!isDefined(attacker) || !isPlayer(attacker)) {
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

function playerzombie_downed_state() {
  self endon(#"death", #"disconnect");
  downtime = 15;
  starttime = gettime();
  endtime = starttime + downtime * 1000;
  self thread playerzombie_downed_hud();
  self.playerzombie_soundboard_disable = 1;
  self disableweapons();
  self allowstand(0);
  self allowcrouch(0);
  self allowprone(1);

  while(gettime() < endtime) {
    waitframe(1);
  }

  self.playerzombie_soundboard_disable = 0;
  self enableweapons();
  self allowstand(1);
  self allowcrouch(0);
  self allowprone(0);
  self notify(#"playerzombie_downed_state_done");
}

function playerzombie_downed_hud() {
  self endon(#"death", #"disconnect");
  text = newdebughudelem(self);
  text.alignx = "<dev string:x38>";
  text.aligny = "<dev string:x42>";
  text.horzalign = "<dev string:x4c>";
  text.vertalign = "<dev string:x5b>";
  text.foreground = 1;
  text.font = "<dev string:x6a>";
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

function playerzombie_infinite_health() {
  self endon(#"death", #"disconnect");
  bighealth = 100000;

  while(true) {
    if(self.health < bighealth) {
      self.health = bighealth;
    }

    wait 0.1;
  }
}

function playerzombie_soundboard() {
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

    if(self useButtonPressed()) {
      if(self can_do_input("use")) {
        self thread playerzombie_play_sound(usesound);
        self thread playerzombie_waitfor_buttonrelease("use");
        self.usesound_nexttime = gettime() + self.usesound_waittime;
      }
    } else if(self attackButtonPressed()) {
      if(self can_do_input("attack")) {
        self thread playerzombie_play_sound(attacksound);
        self thread playerzombie_waitfor_buttonrelease("attack");
        self.attacksound_nexttime = gettime() + self.attacksound_waittime;
      }
    } else if(self adsButtonPressed()) {
      if(self can_do_input("ads")) {
        self thread playerzombie_play_sound(adssound);
        self thread playerzombie_waitfor_buttonrelease("ads");
        self.adssound_nexttime = gettime() + self.adssound_waittime;
      }
    }

    waitframe(1);
  }
}

function can_do_input(inputtype) {
  if(gettime() < self.inputsound_nexttime) {
    return 0;
  }

  cando = 0;

  switch (inputtype) {
    case # "use":
      if(gettime() >= self.usesound_nexttime && !self.buttonpressed_use) {
        cando = 1;
      }

      break;
    case # "attack":
      if(gettime() >= self.attacksound_nexttime && !self.buttonpressed_attack) {
        cando = 1;
      }

      break;
    case # "ads":
      if(gettime() >= self.usesound_nexttime && !self.buttonpressed_ads) {
        cando = 1;
      }

      break;
    default:
      assertmsg("<dev string:x75>" + inputtype);
      break;
  }

  return cando;
}

function playerzombie_play_sound(alias) {
  self zm_utility::play_sound_on_ent(alias);
}

function playerzombie_waitfor_buttonrelease(inputtype) {
  if(inputtype != "use" && inputtype != "attack" && inputtype != "ads") {
    assertmsg("<dev string:xa7>" + inputtype + "<dev string:xde>");
    return;
  }

  notifystring = "waitfor_buttonrelease_" + inputtype;
  self notify(notifystring);
  self endon(notifystring);

  if(inputtype == "use") {
    self.buttonpressed_use = 1;

    while(self useButtonPressed()) {
      waitframe(1);
    }

    self.buttonpressed_use = 0;
    return;
  }

  if(inputtype == "attack") {
    self.buttonpressed_attack = 1;

    while(self attackButtonPressed()) {
      waitframe(1);
    }

    self.buttonpressed_attack = 0;
    return;
  }

  if(inputtype == "ads") {
    self.buttonpressed_ads = 1;

    while(self adsButtonPressed()) {
      waitframe(1);
    }

    self.buttonpressed_ads = 0;
  }
}
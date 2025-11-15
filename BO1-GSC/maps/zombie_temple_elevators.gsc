/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_temple_elevators.gsc
********************************************/

#include animscripts\zombie_utility;
#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_utility;
#include maps\zombie_temple;
#include maps\zombie_temple_pack_a_punch;

init_elevator() {
  init_geyser_anims();
  flag_wait("all_players_connected");
  init_temple_geyser();
}

init_temple_geyser() {
  level.geysers = getEntArray("temple_geyser", "targetname");
  for(i = 0; i < level.geysers.size; i++) {
    level.geysers[i].enabled = false;
    level.geysers[i].line_emitter = i;
    geyserTrigger = level.geysers[i];
    parms = strTok(geyserTrigger.script_parameters, ",");
    geyserTrigger.push_x = Float(parms[0]);
    geyserTrigger.push_y = Float(parms[1]);
    geyserTrigger.push_z = Float(parms[2]);
    geyserTrigger.push_time = Float(parms[3]);
    geyserTrigger.lift = getEnt(geyserTrigger.target, "targetname");
    geyserTrigger.bottom = getStruct(geyserTrigger.target, "targetname");
    if(!isDefined(geyserTrigger.bottom.angles)) {
      geyserTrigger.bottom.angles = (0, 0, 0);
    }
    geyserTrigger.top = getStruct(geyserTrigger.bottom.target, "targetname");
    if(!isDefined(geyserTrigger.top.angles)) {
      geyserTrigger.top.angles = (0, 0, 0);
    }
    geyserTrigger.trigger_dust = getEnt("trigger_" + geyserTrigger.script_noteworthy + "_dust", "targetname");
    if(isDefined(geyserTrigger.trigger_dust)) {
      geyserTrigger.trigger_dust thread geyser_trigger_dust_think();
    }
    if(isDefined(geyserTrigger.script_noteworthy)) {
      flag_init(geyserTrigger.script_noteworthy + "_active");
      blocker = getEnt(geyserTrigger.script_noteworthy + "_blocker", "targetname");
      if(isDefined(blocker)) {
        geyserTrigger thread geyser_blocker_think(blocker);
      }
      geysertrigger.jump_down_start = GetNode(geyserTrigger.script_noteworthy + "_jump_down", "targetname");
      if(isDefined(geysertrigger.jump_down_start)) {
        geysertrigger.jump_down_end = GetNode(geysertrigger.jump_down_start.target, "targetname");
      }
    }
  }
}

alternate_geysers() {
  currentGeyser = undefined;
  level waittill("geyser_enabled");
  while(true) {
    geysers = [];
    for(i = 0; i < level.geysers.size; i++) {
      g = level.geysers[i];
      if((!isDefined(currentGeyser) || g != currentGeyser) && g.enabled) {
        geysers[geysers.size] = g;
      }
    }
    if(isDefined(currentGeyser)) {
      currentGeyser notify("geyser_end");
      currentGeyser = undefined;
    }
    if(geysers.size > 0) {
      currentGeyser = random(geysers);
      currentGeyser thread geyser_start();
    }
    level waittill("between_round_over");
  }
}

geyser_start() {
  self.geyser_active = false;
  self thread geyser_watch_for_player();
}

geyser_watch_for_zombies() {
  self endon("geyser_end");
  while(1) {
    self waittill("trigger", who);
    if(!self.geyser_active) {
      continue;
    }
    if(isAI(who)) {
      who zombie_geyser_kill();
    }
  }
}

geyser_watch_for_player() {
  self endon("geyser_end");
  level endon("intermission");
  level endon("fake_death");
  while(1) {
    self waittill("trigger", who);
    if(!isPlayer(who)) {
      continue;
    }
    if(who.sessionstate == "spectator") {
      continue;
    }
    if(!self.geyser_active) {
      if(who.origin[2] - self.bottom.origin[2] > 70) {
        continue;
      }
    }
    if(self.geyser_active) {
      who thread player_geyser_move(self);
      continue;
    }
    self playSound("evt_geyser_buildup");
    startTime = GetTime();
    players = get_players();
    while(1) {
      playersTouching = [];
      for(i = 0; i < players.size; i++) {
        if(players[i] isTouching(self)) {
          playersTouching[playersTouching.size] = players[i];
        }
      }
      if(playersTouching.size == 0) {
        break;
      }
      Earthquake(0.2, 0.1, self.bottom.origin, 100);
      if(GetTime() - startTime > 1800) {
        self thread geyser_activate(playersTouching);
        break;
      }
      wait .1;
    }
  }
}

geyser_activate(playersTouching) {
  self geyser_erupt(playersTouching);
  wait 5;
}

geyser_erupt(playersTouching) {
  self.geyser_active = true;
  if(isDefined(self.trigger_dust)) {
    self.trigger_dust thread geyser_trigger_dust_activate();
  }
  self thread geyser_fx();
  if(isDefined(self.line_emitter)) {
    clientnotify("ge" + self.line_emitter);
  }
  for(i = 0; i < playersTouching.size; i++) {
    playersTouching[i] thread player_geyser_move(self);
    playersTouching[i] thread maps\_zombiemode_audio::create_and_play_dialog("general", "geyser");
  }
  if(isDefined(self.jump_down_start) && isDefined(self.jump_down_end)) {
    unlinknodes(self.jump_down_start, self.jump_down_end);
  }
  flag_set(self.script_noteworthy + "_active");
  wait 10;
  self notify("stop_geyser_fx");
  flag_clear(self.script_noteworthy + "_active");
  if(isDefined(self.jump_down_start) && isDefined(self.jump_down_end)) {
    linknodes(self.jump_down_start, self.jump_down_end);
  }
  self.geyser_active = false;
}

player_geyser_move(geyser) {
  self endon("death");
  self endon("disconnect");
  self endon("spawned_spectator");
  if(is_true(self.riding_geyser) || is_true(self.intermission)) {
    return;
  }
  self.riding_geyser = true;
  if(self maps\_laststand::player_is_in_laststand()) {
    self.geyser_anim = level._CF_PLAYER_GEYSER_FAKE_PLAYER_SETUP_PRONE;
  } else if(self GetStance() == "prone") {
    self setclientflag(level._CF_PLAYER_GEYSER_FAKE_PLAYER_SETUP_PRONE);
    self.geyser_anim = level._CF_PLAYER_GEYSER_FAKE_PLAYER_SETUP_PRONE;
  } else {
    self setclientflag(level._CF_PLAYER_GEYSER_FAKE_PLAYER_SETUP_STAND);
    self.geyser_anim = level._CF_PLAYER_GEYSER_FAKE_PLAYER_SETUP_STAND;
  }
  if(!self maps\_laststand::player_is_in_laststand()) {
    self hide();
  }
  self.geyser_dust_time = gettime() + 2000;
  scale = (geyser.top.origin[2] - self.origin[2]) / (geyser.top.origin[2] - geyser.bottom.origin[2]);
  scale = clamp(scale, .4, 1.0);
  mover = spawn("script_origin", self.origin);
  self PlayerLinkTo(mover);
  x = geyser.push_x;
  y = geyser.push_y;
  z = geyser.push_z * scale;
  time = geyser.push_time * scale;
  if(self.sessionstate == "playing") {
    self SetWaterSheeting(1, time * 2);
  }
  mover movegravity((x, y, z), time);
  self player_geyser_move_wait(time);
  vel = self GetVelocity();
  if(isDefined(self)) {
    self clearclientflag(self.geyser_anim);
    wait_network_frame();
    if(!self maps\_laststand::player_is_in_laststand()) {
      self show();
    }
  }
  self unlink();
  mover Delete();
  if(y > 0) {
    self SetVelocity(vel + (0, 175, 0));
  } else {
    self SetVelocity(vel + (0, -175, 0));
  }
  wait(0.1);
  self.riding_geyser = false;
}

player_geyser_move_wait(waitTime) {
  self endon("death");
  self endon("player_downed");
  wait waitTime;
}

geyser_erupt_old(playersTouching) {
  self.geyser_active = true;
  self thread geyser_fx();
  moveUpTime = .5;
  moveDownTime = .1;
  moveDist = 500;
  lift = getEnt("geyser_lift", "targetname");
  wait .1;
  start_origin = self.lift.origin;
  start_angles = self.lift.angles;
  for(i = 0; i < playersTouching.size; i++) {
    playersTouching[i] StartCameraTween(0.1);
    playersTouching[i] SetPlayerAngles(self.bottom.angles);
  }
  self.lift movez(moveDist, moveUpTime, .1, .3);
  wait moveUpTime;
  bounceTime = .3;
  bounceDist = 20;
  for(i = 0; i < 2; i++) {
    self.lift movez(bounceDist, bounceTime, bounceTime / 2, bounceTime / 2);
    wait bounceTime;
    self.lift movez(-1 * bounceDist, bounceTime, bounceTime / 2, bounceTime / 2);
    wait bounceTime;
  }
  self.lift movez(-250, 3, .2, .2);
  wait 3;
  self.lift notSolid();
  self.lift.angles = start_angles;
  self.lift.origin = start_origin;
  wait .1;
  self.lift Solid();
  wait 5;
  self notify("stop_geyser_fx");
  self.geyser_active = false;
}

geyser_fx() {
  self thread geyser_earthquake();
  fxObj = spawnFX(level._effect["fx_ztem_geyser"], self.bottom.origin);
  TriggerFX(fxObj);
  self waittill("stop_geyser_fx");
  wait 5;
  fxObj Delete();
}

geyser_earthquake() {
  self endon("stop_geyser_fx");
  while(1) {
    Earthquake(0.2, 0.1, self.origin, 100);
    wait .1;
  }
}

zombie_geyser_kill() {
  self StartRagdoll();
  self launchragdoll((0, 0, 1) * 300);
  wait_network_frame();
  self dodamage(self.health + 666, self.origin);
}

geyser_blocker_think(blocker) {
  switch (self.script_noteworthy) {
    case "start_geyser":
      flag_wait_any("cave02_to_cave_water", "cave_water_to_power", "cave_water_to_waterfall");
      exploder(8);
      geyser_sounds("geyser02", "evt_water_spout02", "evt_geyser_amb", 1.0);
      break;
    case "minecart_geyser":
      flag_wait_any("start_to_pressure", "pressure_to_cave01");
      flag_wait_any("cave01_to_cave02", "pressure_to_cave01");
      exploder(9);
      geyser_sounds("geyser01", "evt_water_spout01", "evt_geyser_amb", 1.0);
    default:
      break;
  }
  blocker thread geyser_blocker_remove();
  self thread geyser_start();
  self.enabled = true;
  level notify("geyser_enabled", self);
}

geyser_sounds(struct_name, sfx_start, sfx_loop, sfx_loop_delay) {
  sound_struct = getstruct(struct_name, "targetname");
  if(isDefined(sound_struct)) {
    level thread play_sound_in_space(sfx_start, sound_struct.origin);
    if(isDefined(sfx_loop_delay) && sfx_loop_delay > 0.0) {
      wait(sfx_loop_delay);
    }
    ambient_ent = spawn("script_origin", (0, 0, 1));
    if(isDefined(ambient_ent)) {
      ambient_ent.origin = sound_struct.origin;
      ambient_ent thread play_loop_sound_on_entity(sfx_loop);
    }
  }
}

geyser_blocker_remove() {
  clip = getEnt(self.target, "targetname");
  clip Delete();
  struct = spawnStruct();
  struct.origin = self.origin + (0, 0, 500);
  struct.angles = self.angles + (0, 180, 0);
  self.script_noteworthy = "jiggle";
  self.script_firefx = "poltergeist";
  self.script_fxid = "large_ceiling_dust";
  self maps\_zombiemode_blockers::debris_move(struct);
}

geyser_trigger_dust_activate() {
  self trigger_on();
  wait(3);
  self trigger_off();
}

geyser_trigger_dust_think() {
  while(1) {
    self waittill("trigger", player);
    if(isDefined(player) && isDefined(player.geyser_dust_time) && player.geyser_dust_time > gettime()) {
      playFX(level._effect["player_land_dust"], player.origin);
      player playSound("fly_bodyfall_large_dirt");
      player.geyser_dust_time = 0;
    }
  }
}

#using_animtree("zombie_coast");
init_geyser_anims() {
  level.geyser_anims = [];
  level.geyser_anims["player_geyser_stand_crouch"] = % pb_rifle_stand_flinger_flail;
  level.geyser_anims["player_geyser_prone"] = % pb_rifle_prone_flinger_flail;
  level.geyser_animtree = #animtree;
}
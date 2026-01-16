/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_cod5_sumpf_trap_perk_electric.gsc
*********************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_utility;

init_elec_trap_trigs() {
  trap_trigs = getentarray("elec_trap_trig", "targetname");
  if(level.mutators["mutator_noTraps"]) {
    maps\_zombiemode_traps::disable_traps(trap_trigs);
    return;
  }
  for(i = 0; i < trap_trigs.size; i++) {
    trap_trigs[i] thread electric_trap_think();
    trap_trigs[i] thread electric_trap_dialog();
    wait_network_frame();
  }
}

electric_trap_dialog() {
  self endon("warning_dialog");
  level endon("switch_flipped");
  timer = 0;
  while(1) {
    wait(0.5);
    players = get_players();
    for(i = 0; i < players.size; i++) {
      dist = distancesquared(players[i].origin, self.origin);
      if(dist > 70 * 70) {
        timer = 0;
        continue;
      }
      if(dist < 70 * 70 && timer < 3) {
        wait(0.5);
        timer++;
      }
      if(dist < 70 * 70 && timer == 3) {
        wait(3);
        self notify("warning_dialog");
      }
    }
  }
}

electric_trap_think() {
  self sethintstring(&"WAW_ZOMBIE_BUTTON_NORTH_FLAMES");
  self setCursorHint("HINT_NOICON");
  self.is_available = true;
  self.zombie_cost = 1000;
  self.in_use = 0;
  level thread maps\zombie_cod5_sumpf::turnLightGreen(self.script_string);
  while(1) {
    self waittill("trigger", who);
    if(who in_revive_trigger()) {
      continue;
    }
    if(!isDefined(self.is_available)) {
      continue;
    }
    if(is_player_valid(who)) {
      if(who.score >= self.zombie_cost) {
        if(!self.in_use) {
          self.in_use = 1;
          play_sound_at_pos("purchase", who.origin);
          who maps\_zombiemode_audio::create_and_play_dialog("level", "trap_barrel");
          self thread electric_trap_move_switch(self);
          self waittill("switch_activated");
          who maps\_zombiemode_score::minus_to_player_score(self.zombie_cost);
          self trigger_off();
          level thread maps\zombie_cod5_sumpf::turnLightRed(self.script_string);
          self.zombie_dmg_trig = getEnt(self.target, "targetname");
          self.zombie_dmg_trig trigger_on();
          self thread activate_electric_trap(who);
          self waittill("elec_done");
          clientnotify(self.script_string + "off");
          if(isDefined(self.fx_org)) {
            self.fx_org delete();
          }
          if(isDefined(self.zapper_fx_org)) {
            self.zapper_fx_org delete();
          }
          if(isDefined(self.zapper_fx_switch_org)) {
            self.zapper_fx_switch_org delete();
          }
          self.zombie_dmg_trig trigger_off();
          wait(90);
          self trigger_on();
          level thread maps\zombie_cod5_sumpf::turnLightGreen(self.script_string);
          pa_system = getEnt("speaker_by_log", "targetname");
          playsoundatposition("warning", pa_system.origin);
          self notify("available");
          self.in_use = 0;
        }
      }
    }
  }
}

electric_trap_move_switch(parent) {
  tswitch = getEnt(parent.script_linkto, "script_linkname");
  if(tswitch.script_linkname == "110") {
    tswitch rotatePitch(180, .5);
    tswitch playsound("amb_sparks_l_b");
    tswitch waittill("rotatedone");
    self notify("switch_activated");
    self waittill("available");
    tswitch rotatePitch(-180, .5);
  } else if(tswitch.script_linkname == "111") {
    tswitch rotatePitch(180, .5);
    tswitch playsound("amb_sparks_l_b");
    tswitch waittill("rotatedone");
    self notify("switch_activated");
    self waittill("available");
    tswitch rotatePitch(-180, .5);
  } else if(tswitch.script_linkname == "112") {
    tswitch rotatePitch(180, .5);
    tswitch playsound("amb_sparks_l_b");
    tswitch waittill("rotatedone");
    self notify("switch_activated");
    self waittill("available");
    tswitch rotatePitch(-180, .5);
  } else if(tswitch.script_linkname == "113") {
    tswitch rotatePitch(180, .5);
    tswitch playsound("amb_sparks_l_b");
    tswitch waittill("rotatedone");
    self notify("switch_activated");
    self waittill("available");
    tswitch rotatePitch(-180, .5);
  }
}

activate_electric_trap(who) {
  clientnotify(self.target);
  fire_points = getstructarray(self.target, "targetname");
  for(i = 0; i < fire_points.size; i++) {
    wait_network_frame();
    fire_points[i] thread electric_trap_fx(self);
  }
  self.zombie_dmg_trig thread elec_barrier_damage(who);
  level waittill("arc_done");
}

electric_trap_fx(notify_ent) {
  self.tag_origin = spawn("script_model", self.origin);
  self.tag_origin playsound("zmb_elec_start");
  self.tag_origin playLoopSound("zmb_elec_loop");
  self thread play_electrical_sound();
  wait(25);
  if(isDefined(self.script_sound)) {
    self.tag_origin stopLoopSound();
  }
  self.tag_origin delete();
  notify_ent notify("elec_done");
  level notify("arc_done");
}

play_electrical_sound() {
  level endon("arc_done");
  while(1) {
    wait(randomfloatrange(0.1, 0.5));
    playsoundatposition("zmb_elec_arc", self.origin);
  }
}

elec_barrier_damage(who) {
  while(1) {
    self waittill("trigger", ent);
    if(isplayer(ent)) {
      ent thread player_elec_damage();
    } else {
      if(ent.isdog && is_magic_bullet_shield_enabled(ent)) {
        continue;
      }
      if(!isDefined(ent.marked_for_death)) {
        ent.marked_for_death = true;
        ent thread zombie_elec_death(randomInt(100));
        who.trapped_used[self.targetname] = level.round_number;
      }
    }
  }
}

play_elec_vocals() {
  if(isDefined(self)) {
    org = self.origin;
    wait(0.15);
    playsoundatposition("zmb_elec_vocals", org);
    playsoundatposition("zmb_zombie_arc", org);
    playsoundatposition("zmb_exp_jib_zombie", org);
  }
}

player_elec_damage() {
  self endon("death");
  self endon("disconnect");
  if(!isDefined(level.elec_loop)) {
    level.elec_loop = 0;
  }
  if(!isDefined(self.is_burning) && !self maps\_laststand::player_is_in_laststand()) {
    self.is_burning = 1;
    self setelectrified(1.25);
    shocktime = 2.5;
    self shellshock("electrocution", shocktime);
    if(level.elec_loop == 0) {
      elec_loop = 1;
      self playsound("zombie_arc");
    }
    if(!self hasperk("specialty_armorvest") || self.health - 100 < 1) {
      radiusdamage(self.origin, 10, self.health + 100, self.health + 100);
      self.is_burning = undefined;
    } else {
      self dodamage(50, self.origin);
      wait(.1);
      self.is_burning = undefined;
    }
  }
}

zombie_elec_death(flame_chance) {
  self endon("death");
  if(flame_chance > 90 && level.burning_zombies.size < 6) {
    level.burning_zombies[level.burning_zombies.size] = self;
    self thread zombie_flame_watch();
    self playsound("ignite");
    self thread animscripts\zombie_death::flame_death_fx();
    wait(randomfloat(1.25));
  } else {
    refs[0] = "guts";
    refs[1] = "right_arm";
    refs[2] = "left_arm";
    refs[3] = "right_leg";
    refs[4] = "left_leg";
    refs[5] = "no_legs";
    refs[6] = "head";
    self.a.gib_ref = refs[randomInt(refs.size)];
    playsoundatposition("zmb_zombie_arc", self.origin);
    if(randomInt(100) > 40) {
      if(!flag("dog_round")) {
        self thread electroctute_death_fx();
      }
      self thread play_elec_vocals();
    }
    wait(randomfloat(1.25));
    self playsound("zmb_zombie_arc");
  }
  self dodamage(self.health + 666, self.origin);
}

zombie_flame_watch() {
  self waittill("death");
  self stopLoopSound();
  level.burning_zombies = array_remove_nokeys(level.burning_zombies, self);
}

electroctute_death_fx() {
  self endon("death");
  if(isDefined(self.is_electrocuted) && self.is_electrocuted) {
    return;
  }
  self.is_electrocuted = true;
  self thread electrocute_timeout();
  if(self.team == "axis") {
    level.bcOnFireTime = gettime();
    level.bcOnFireOrg = self.origin;
  }
  tagArray = [];
  tagArray[0] = "J_Elbow_LE";
  tagArray[1] = "J_Elbow_RI";
  tagArray[2] = "J_Knee_RI";
  tagArray[3] = "J_Knee_LE";
  tagArray = array_randomize(tagArray);
  if(isDefined(tagArray[0])) {
    PlayFxOnTag(level._effect["elec_md"], self, tagArray[0]);
  }
  self playsound("zmb_elec_jib_zombie");
  wait 1;
  self playsound("zmb_elec_jib_zombie");
  tagArray[0] = "J_Wrist_RI";
  tagArray[1] = "J_Wrist_LE";
  if(!isDefined(self.a.gib_ref) || self.a.gib_ref != "no_legs") {
    tagArray[2] = "J_Ankle_RI";
    tagArray[3] = "J_Ankle_LE";
  }
  tagArray = array_randomize(tagArray);
  if(isDefined(tagArray[0])) {
    PlayFxOnTag(level._effect["elec_sm"], self, tagArray[0]);
  }
  if(isDefined(tagArray[1])) {
    PlayFxOnTag(level._effect["elec_sm"], self, tagArray[1]);
  }
}

electrocute_timeout() {
  self endon("death");
  self playLoopSound("amb_fire_manager_0");
  wait 12;
  self stopLoopSound();
  if(isDefined(self) && isalive(self)) {
    self.is_electrocuted = false;
    self notify("stop_flame_damage");
  }
}
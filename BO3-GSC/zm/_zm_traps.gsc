/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_traps.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_death;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_net;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;
#namespace zm_traps;

function autoexec __init__sytem__() {
  system::register("zm_traps", &__init__, &__main__, undefined);
}

function __init__() {
  level.trap_kills = 0;
  level.burning_zombies = [];
  callback::on_finalize_initialization(&init);
}

function init() {
  traps = getEntArray("zombie_trap", "targetname");
  array::thread_all(traps, &trap_init);
}

function __main__() {
  traps = getEntArray("zombie_trap", "targetname");
  array::thread_all(traps, &trap_main);
}

function trap_init() {
  self flag::init("flag_active");
  self flag::init("flag_cooldown");
  self._trap_type = "";
  if(isDefined(self.script_noteworthy)) {
    self._trap_type = self.script_noteworthy;
    if(isDefined(level._custom_traps) && isDefined(level._custom_traps[self.script_noteworthy]) && isDefined(level._custom_traps[self.script_noteworthy].activate)) {
      self._trap_activate_func = level._custom_traps[self.script_noteworthy].activate;
    } else {
      switch (self.script_noteworthy) {
        case "rotating": {
          self._trap_activate_func = &trap_activate_rotating;
          break;
        }
        case "flipper": {
          self._trap_activate_func = &trap_activate_flipper;
          break;
        }
        default: {
          self._trap_activate_func = &trap_activate_fire;
        }
      }
    }
    if(isDefined(level._zombiemode_trap_use_funcs) && isDefined(level._zombiemode_trap_use_funcs[self._trap_type])) {
      self._trap_use_func = level._zombiemode_trap_use_funcs[self._trap_type];
    } else {
      self._trap_use_func = &trap_use_think;
    }
  }
  self trap_model_type_init();
  self._trap_use_trigs = [];
  self._trap_lights = [];
  self._trap_movers = [];
  self._trap_switches = [];
  components = getEntArray(self.target, "targetname");
  for(i = 0; i < components.size; i++) {
    if(isDefined(components[i].script_noteworthy)) {
      switch (components[i].script_noteworthy) {
        case "counter_1s": {
          self.counter_1s = components[i];
          continue;
        }
        case "counter_10s": {
          self.counter_10s = components[i];
          continue;
        }
        case "counter_100s": {
          self.counter_100s = components[i];
          continue;
        }
        case "mover": {
          self._trap_movers[self._trap_movers.size] = components[i];
          continue;
        }
        case "switch": {
          self._trap_switches[self._trap_switches.size] = components[i];
          continue;
        }
        case "light": {
          self._trap_lights[self._trap_lights.size] = components[i];
          continue;
        }
      }
    }
    if(isDefined(components[i].script_string)) {
      switch (components[i].script_string) {
        case "flipper1": {
          self.flipper1 = components[i];
          continue;
        }
        case "flipper2": {
          self.flipper2 = components[i];
          continue;
        }
        case "flipper1_radius_check": {
          self.flipper1_radius_check = components[i];
          continue;
        }
        case "flipper2_radius_check": {
          self.flipper2_radius_check = components[i];
          continue;
        }
        case "target1": {
          self.target1 = components[i];
          continue;
        }
        case "target2": {
          self.target2 = components[i];
          continue;
        }
        case "target3": {
          self.target3 = components[i];
          continue;
        }
      }
    }
    switch (components[i].classname) {
      case "trigger_use": {
        self._trap_use_trigs[self._trap_use_trigs.size] = components[i];
        break;
      }
      case "script_model": {
        if(components[i].model == self._trap_light_model_off) {
          self._trap_lights[self._trap_lights.size] = components[i];
        } else if(components[i].model == self._trap_switch_model) {
          self._trap_switches[self._trap_switches.size] = components[i];
        }
      }
    }
  }
  self._trap_fx_structs = [];
  components = struct::get_array(self.target, "targetname");
  for(i = 0; i < components.size; i++) {
    if(isDefined(components[i].script_string) && components[i].script_string == "use_this_angle") {
      self.use_this_angle = components[i];
      continue;
    }
    self._trap_fx_structs[self._trap_fx_structs.size] = components[i];
  }
  assert(self._trap_use_trigs.size > 0, "" + self.target);
  if(!isDefined(self.zombie_cost)) {
    self.zombie_cost = 1000;
  }
  self._trap_in_use = 0;
  self._trap_cooling_down = 0;
  self thread trap_dialog();
}

function trap_main() {
  level flag::wait_till("start_zombie_round_logic");
  for(i = 0; i < self._trap_use_trigs.size; i++) {
    self._trap_use_trigs[i] setcursorhint("HINT_NOICON");
  }
  if(!isDefined(self.script_string) || "disable_wait_for_power" != self.script_string) {
    self trap_set_string(&"ZOMBIE_NEED_POWER");
    if(isDefined(self.script_int)) {
      level flag::wait_till("power_on" + self.script_int);
    } else {
      level flag::wait_till("power_on");
    }
  }
  if(isDefined(self.script_flag_wait)) {
    self trap_set_string("");
    self triggerenable(0);
    self trap_lights_red();
    if(!isDefined(level.flag[self.script_flag_wait])) {
      level flag::init(self.script_flag_wait);
    }
    level flag::wait_till(self.script_flag_wait);
    self triggerenable(1);
  }
  self trap_set_string(&"ZOMBIE_BUTTON_BUY_TRAP", self.zombie_cost);
  self trap_lights_green();
  for(i = 0; i < self._trap_use_trigs.size; i++) {
    self._trap_use_trigs[i] thread[[self._trap_use_func]](self);
    self._trap_use_trigs[i] thread update_trigger_visibility();
  }
}

function trap_use_think(trap) {
  while(true) {
    self waittill("trigger", who);
    if(who zm_utility::in_revive_trigger()) {
      continue;
    }
    if(who.is_drinking > 0) {
      continue;
    }
    if(zm_utility::is_player_valid(who) && !trap._trap_in_use) {
      players = getplayers();
      if(who zm_score::can_player_purchase(trap.zombie_cost)) {
        who zm_score::minus_to_player_score(trap.zombie_cost);
      } else {
        self playSound("zmb_trap_deny");
        who zm_audio::create_and_play_dialog("general", "outofmoney");
        continue;
      }
      trap.activated_by_player = who;
      trap._trap_in_use = 1;
      trap trap_set_string(&"ZOMBIE_TRAP_ACTIVE");
      zm_utility::play_sound_at_pos("purchase", who.origin);
      if(!(isDefined(level.b_trap_start_custom_vo) && level.b_trap_start_custom_vo)) {
        who zm_audio::create_and_play_dialog("trap", "start");
      }
      if(trap._trap_switches.size) {
        trap thread trap_move_switches();
        trap waittill("switch_activated");
      }
      trap triggerenable(1);
      trap thread[[trap._trap_activate_func]]();
      trap waittill("trap_done");
      trap triggerenable(0);
      trap._trap_cooling_down = 1;
      trap trap_set_string(&"ZOMBIE_TRAP_COOLDOWN");
      if(getdvarint("") >= 1) {
        trap._trap_cooldown_time = 5;
      }
      wait(trap._trap_cooldown_time);
      trap._trap_cooling_down = 0;
      playsoundatposition("zmb_trap_ready", trap.origin);
      if(isDefined(level.sndtrapfunc)) {
        level thread[[level.sndtrapfunc]](trap, 0);
      }
      trap notify("available");
      trap._trap_in_use = 0;
      trap trap_set_string(&"ZOMBIE_BUTTON_BUY_TRAP", trap.zombie_cost);
    }
  }
}

function private update_trigger_visibility() {
  self endon("death");
  while(true) {
    for(i = 0; i < level.players.size; i++) {
      if(distancesquared(level.players[i].origin, self.origin) < 16384) {
        if(level.players[i].is_drinking > 0) {
          self setinvisibletoplayer(level.players[i], 1);
          continue;
        }
        self setinvisibletoplayer(level.players[i], 0);
      }
    }
    wait(0.25);
  }
}

function trap_lights_red() {
  for(i = 0; i < self._trap_lights.size; i++) {
    light = self._trap_lights[i];
    str_light_red = light.targetname + "_red";
    str_light_green = light.targetname + "_green";
    exploder::stop_exploder(str_light_green);
    exploder::exploder(str_light_red);
  }
}

function trap_lights_green() {
  for(i = 0; i < self._trap_lights.size; i++) {
    light = self._trap_lights[i];
    if(isDefined(light._switch_disabled)) {
      continue;
    }
    str_light_red = light.targetname + "_red";
    str_light_green = light.targetname + "_green";
    exploder::stop_exploder(str_light_red);
    exploder::exploder(str_light_green);
  }
}

function trap_set_string(string, param1, param2) {
  for(i = 0; i < self._trap_use_trigs.size; i++) {
    if(!isDefined(param1)) {
      self._trap_use_trigs[i] sethintstring(string);
      continue;
    }
    if(!isDefined(param2)) {
      self._trap_use_trigs[i] sethintstring(string, param1);
      continue;
    }
    self._trap_use_trigs[i] sethintstring(string, param1, param2);
  }
}

function trap_move_switches() {
  self trap_lights_red();
  for(i = 0; i < self._trap_switches.size; i++) {
    self._trap_switches[i] rotatepitch(180, 0.5);
    if(isDefined(self._trap_type) && self._trap_type == "fire") {
      self._trap_switches[i] playSound("evt_switch_flip_trap_fire");
      continue;
    }
    self._trap_switches[i] playSound("evt_switch_flip_trap");
  }
  self._trap_switches[0] waittill("rotatedone");
  self notify("switch_activated");
  self waittill("available");
  for(i = 0; i < self._trap_switches.size; i++) {
    self._trap_switches[i] rotatepitch(-180, 0.5);
  }
  self._trap_switches[0] waittill("rotatedone");
  self trap_lights_green();
}

function trap_activate_fire() {
  self._trap_duration = 40;
  self._trap_cooldown_time = 60;
  fx_points = struct::get_array(self.target, "targetname");
  for(i = 0; i < fx_points.size; i++) {
    util::wait_network_frame();
    fx_points[i] thread trap_audio_fx(self);
  }
  self thread trap_damage();
  wait(self._trap_duration);
  self notify("trap_done");
}

function trap_activate_rotating() {
  self endon("trap_done");
  self._trap_duration = 30;
  self._trap_cooldown_time = 60;
  self thread trap_damage();
  self thread trig_update(self._trap_movers[0]);
  old_angles = self._trap_movers[0].angles;
  for(i = 0; i < self._trap_movers.size; i++) {
    self._trap_movers[i] rotateyaw(360, 5, 4.5);
  }
  wait(5);
  step = 1.5;
  t = 0;
  while(t < self._trap_duration) {
    for(i = 0; i < self._trap_movers.size; i++) {
      self._trap_movers[i] rotateyaw(360, step);
    }
    wait(step);
    t = t + step;
  }
  for(i = 0; i < self._trap_movers.size; i++) {
    self._trap_movers[i] rotateyaw(360, 5, 0, 4.5);
  }
  wait(5);
  for(i = 0; i < self._trap_movers.size; i++) {
    self._trap_movers[i].angles = old_angles;
  }
  self notify("trap_done");
}

function trap_activate_flipper() {}

function trap_audio_fx(trap) {
  if(isDefined(level._custom_traps) && isDefined(level._custom_traps[trap.script_noteworthy]) && isDefined(level._custom_traps[trap.script_noteworthy].audio)) {
    self[[level._custom_traps[trap.script_noteworthy].audio]](trap);
  } else {
    sound_origin = undefined;
    trap util::waittill_any_timeout(trap._trap_duration, "trap_done");
    if(isDefined(sound_origin)) {
      playsoundatposition("wpn_zmb_electrap_stop", sound_origin.origin);
      sound_origin stoploopsound();
      wait(0.05);
      sound_origin delete();
    }
  }
}

function trap_damage() {
  self endon("trap_done");
  while(true) {
    self waittill("trigger", ent);
    if(isPlayer(ent)) {
      if(isDefined(level._custom_traps) && isDefined(level._custom_traps[self._trap_type]) && isDefined(level._custom_traps[self._trap_type].player_damage)) {
        ent thread[[level._custom_traps[self._trap_type].player_damage]]();
        jump loc_0000209C;
      } else {
        switch (self._trap_type) {
          case "rocket": {
            ent thread player_fire_damage();
            break;
          }
          case "rotating": {
            if(ent getstance() == "stand") {
              ent dodamage(50, ent.origin + vectorscale((0, 0, 1), 20));
              ent setstance("crouch");
            }
            break;
          }
        }
      }
    } else if(!isDefined(ent.marked_for_death)) {
      if(isDefined(level._custom_traps) && isDefined(level._custom_traps[self._trap_type]) && isDefined(level._custom_traps[self._trap_type].damage)) {
        ent thread[[level._custom_traps[self._trap_type].damage]](self);
        jump loc_000021CC;
      } else {
        switch (self._trap_type) {
          case "rocket": {
            ent thread zombie_trap_death(self, 100);
            break;
          }
          case "rotating": {
            ent thread zombie_trap_death(self, 200);
            break;
          }
          default: {
            ent thread zombie_trap_death(self, randomint(100));
            break;
          }
        }
      }
    }
  }
}

function trig_update(parent) {
  self endon("trap_done");
  start_angles = self.angles;
  while(true) {
    self.angles = parent.angles;
    wait(0.05);
  }
}

function player_elec_damage() {
  self endon("death");
  self endon("disconnect");
  if(!isDefined(level.elec_loop)) {
    level.elec_loop = 0;
  }
  if(!(isDefined(self.is_burning) && self.is_burning) && zm_utility::is_player_valid(self)) {
    self.is_burning = 1;
    if(isDefined(level.trap_electric_visionset_registered) && level.trap_electric_visionset_registered) {
      visionset_mgr::activate("overlay", "zm_trap_electric", self, 1.25, 1.25);
    } else {
      self setelectrified(1.25);
    }
    shocktime = 2.5;
    if(isDefined(level.str_elec_damage_shellshock_override)) {
      str_elec_shellshock = level.str_elec_damage_shellshock_override;
    } else {
      str_elec_shellshock = "electrocution";
    }
    self shellshock(str_elec_shellshock, shocktime);
    self playrumbleonentity("damage_heavy");
    if(level.elec_loop == 0) {
      elec_loop = 1;
      self playSound("wpn_zmb_electrap_zap");
    }
    if(!self hasperk("specialty_armorvest") || (self.health - 100) < 1) {
      self dodamage(self.health + 100, self.origin);
      self.is_burning = undefined;
    } else {
      self dodamage(50, self.origin);
      wait(0.1);
      self.is_burning = undefined;
    }
  }
}

function player_fire_damage() {
  self endon("death");
  self endon("disconnect");
  if(!(isDefined(self.is_burning) && self.is_burning) && !self laststand::player_is_in_laststand()) {
    self.is_burning = 1;
    if(isDefined(level.trap_fire_visionset_registered) && level.trap_fire_visionset_registered) {
      visionset_mgr::activate("overlay", "zm_trap_burn", self, 1.25, 1.25);
    } else {
      self setburn(1.25);
    }
    self notify("burned");
    if(!self hasperk("specialty_armorvest") || (self.health - 100) < 1) {
      radiusdamage(self.origin, 10, self.health + 100, self.health + 100);
      self.is_burning = undefined;
    } else {
      self dodamage(50, self.origin);
      wait(0.1);
      self.is_burning = undefined;
    }
  }
}

function zombie_trap_death(trap, param) {
  self endon("death");
  self.marked_for_death = 1;
  switch (trap._trap_type) {
    case "rocket": {
      if(isDefined(self.animname) && self.animname != "zombie_dog") {
        if(param > 90 && level.burning_zombies.size < 6) {
          level.burning_zombies[level.burning_zombies.size] = self;
          self thread zombie_flame_watch();
          self playSound("zmb_ignite");
          self thread zombie_death::flame_death_fx();
          playFXOnTag(level._effect["character_fire_death_torso"], self, "J_SpineLower");
          wait(randomfloat(1.25));
        } else {
          refs[0] = "guts";
          refs[1] = "right_arm";
          refs[2] = "left_arm";
          refs[3] = "right_leg";
          refs[4] = "left_leg";
          refs[5] = "no_legs";
          refs[6] = "head";
          self.a.gib_ref = refs[randomint(refs.size)];
          playsoundatposition("wpn_zmb_electrap_zap", self.origin);
          wait(randomfloat(1.25));
          self playSound("wpn_zmb_electrap_zap");
        }
      }
      if(isDefined(self.fire_damage_func)) {
        self[[self.fire_damage_func]](trap);
      } else {
        level notify("trap_kill", self, trap);
        self dodamage(self.health + 666, self.origin, trap);
      }
      break;
    }
    case "centrifuge":
    case "rotating": {
      ang = vectortoangles(trap.origin - self.origin);
      direction_vec = vectorscale(anglestoright(ang), param);
      if(isDefined(self.trap_reaction_func)) {
        self[[self.trap_reaction_func]](trap);
      }
      level notify("trap_kill", self, trap);
      self startragdoll();
      self launchragdoll(direction_vec);
      util::wait_network_frame();
      self.a.gib_ref = "head";
      self dodamage(self.health, self.origin, trap);
      break;
    }
  }
  if(isDefined(trap.activated_by_player) && isPlayer(trap.activated_by_player)) {
    trap.activated_by_player zm_stats::increment_challenge_stat("ZOMBIE_HUNTER_KILL_TRAP");
  }
}

function zombie_flame_watch() {
  self waittill("death");
  self stoploopsound();
  arrayremovevalue(level.burning_zombies, self);
}

function play_elec_vocals() {
  if(isDefined(self)) {
    org = self.origin;
    wait(0.15);
    playsoundatposition("zmb_elec_vocals", org);
    playsoundatposition("wpn_zmb_electrap_zap", org);
    playsoundatposition("zmb_exp_jib_zombie", org);
  }
}

function electroctute_death_fx() {
  self endon("death");
  if(isDefined(self.is_electrocuted) && self.is_electrocuted) {
    return;
  }
  self.is_electrocuted = 1;
  self thread electrocute_timeout();
  if(self.team == level.zombie_team) {
    level.bconfiretime = gettime();
    level.bconfireorg = self.origin;
  }
  if(isDefined(level._effect["elec_torso"])) {
    playFXOnTag(level._effect["elec_torso"], self, "J_SpineLower");
  }
  self playSound("zmb_elec_jib_zombie");
  wait(1);
  tagarray = [];
  tagarray[0] = "J_Elbow_LE";
  tagarray[1] = "J_Elbow_RI";
  tagarray[2] = "J_Knee_RI";
  tagarray[3] = "J_Knee_LE";
  tagarray = array::randomize(tagarray);
  if(isDefined(level._effect["elec_md"])) {
    playFXOnTag(level._effect["elec_md"], self, tagarray[0]);
  }
  self playSound("zmb_elec_jib_zombie");
  wait(1);
  self playSound("zmb_elec_jib_zombie");
  tagarray[0] = "J_Wrist_RI";
  tagarray[1] = "J_Wrist_LE";
  if(!isDefined(self.a.gib_ref) || self.a.gib_ref != "no_legs") {
    tagarray[2] = "J_Ankle_RI";
    tagarray[3] = "J_Ankle_LE";
  }
  tagarray = array::randomize(tagarray);
  if(isDefined(level._effect["elec_sm"])) {
    playFXOnTag(level._effect["elec_sm"], self, tagarray[0]);
    playFXOnTag(level._effect["elec_sm"], self, tagarray[1]);
  }
}

function electrocute_timeout() {
  self endon("death");
  self playLoopSound("amb_fire_manager_0");
  wait(12);
  self stoploopsound();
  if(isDefined(self) && isalive(self)) {
    self.is_electrocuted = 0;
    self notify("stop_flame_damage");
  }
}

function trap_dialog() {
  self endon("warning_dialog");
  level endon("switch_flipped");
  timer = 0;
  while(true) {
    wait(0.5);
    players = getplayers();
    for(i = 0; i < players.size; i++) {
      if(!isDefined(players[i])) {
        continue;
      }
      dist = distancesquared(players[i].origin, self.origin);
      if(dist > 4900) {
        timer = 0;
        continue;
      }
      if(dist < 4900 && timer < 3) {
        wait(0.5);
        timer++;
      }
      if(dist < 4900 && timer == 3) {
        index = zm_utility::get_player_index(players[i]);
        plr = ("plr_" + index) + "_";
        wait(3);
        self notify("warning_dialog");
      }
    }
  }
}

function get_trap_array(trap_type) {
  ents = getEntArray("zombie_trap", "targetname");
  traps = [];
  for(i = 0; i < ents.size; i++) {
    if(ents[i].script_noteworthy == trap_type) {
      traps[traps.size] = ents[i];
    }
  }
  return traps;
}

function trap_disable() {
  cooldown = self._trap_cooldown_time;
  if(self._trap_in_use) {
    self notify("trap_done");
    self._trap_cooldown_time = 0.05;
    self waittill("available");
  }
  array::thread_all(self._trap_use_trigs, &triggerenable, 0);
  self trap_lights_red();
  self._trap_cooldown_time = cooldown;
}

function trap_enable() {
  array::thread_all(self._trap_use_trigs, &triggerenable, 1);
  self trap_lights_green();
}

function trap_model_type_init() {
  if(!isDefined(self.script_parameters)) {
    self.script_parameters = "default";
  }
  switch (self.script_parameters) {
    case "pentagon_electric": {
      self._trap_light_model_off = "zombie_trap_switch_light";
      self._trap_light_model_green = "zombie_trap_switch_light_on_green";
      self._trap_light_model_red = "zombie_trap_switch_light_on_red";
      self._trap_switch_model = "zombie_trap_switch_handle";
      break;
    }
    case "default":
    default: {
      self._trap_light_model_off = "zombie_zapper_cagelight";
      self._trap_light_model_green = "zombie_zapper_cagelight";
      self._trap_light_model_red = "zombie_zapper_cagelight";
      self._trap_switch_model = "zombie_zapper_handle";
      break;
    }
  }
}

function is_trap_registered(a_registered_traps) {
  return isDefined(a_registered_traps[self.script_noteworthy]);
}

function register_trap_basic_info(str_trap, func_activate, func_audio) {
  assert(isDefined(str_trap), "");
  assert(isDefined(func_activate), "");
  assert(isDefined(func_audio), "");
  _register_undefined_trap(str_trap);
  level._custom_traps[str_trap].activate = func_activate;
  level._custom_traps[str_trap].audio = func_audio;
}

function _register_undefined_trap(str_trap) {
  if(!isDefined(level._custom_traps)) {
    level._custom_traps = [];
  }
  if(!isDefined(level._custom_traps[str_trap])) {
    level._custom_traps[str_trap] = spawnStruct();
  }
}

function register_trap_damage(str_trap, func_player_damage, func_damage) {
  assert(isDefined(str_trap), "");
  _register_undefined_trap(str_trap);
  level._custom_traps[str_trap].player_damage = func_player_damage;
  level._custom_traps[str_trap].damage = func_damage;
}
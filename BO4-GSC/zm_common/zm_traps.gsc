/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_traps.gsc
***********************************************/

#include script_2f9a68261f6a17be;
#include script_301f64a4090c381a;
#include scripts\core_common\ai\zombie_death;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\trigger_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\visionset_mgr_shared;
#include scripts\zm_common\trials\zm_trial_disable_buys;
#include scripts\zm_common\util;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_contracts;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_laststand;
#include scripts\zm_common\zm_net;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_utility;

#namespace zm_traps;

autoexec __init__system__() {
  system::register(#"zm_traps", &__init__, &__main__, undefined);
}

__init__() {
  level.trap_kills = 0;

  if(!isDefined(level._custom_traps)) {
    level._custom_traps = [];
  }

  level.burning_zombies = [];
  callback::on_finalize_initialization(&init);
}

init() {
  if(!zm_custom::function_901b751c(#"zmtrapsenabled")) {
    return;
  }

  traps = getEntArray("zombie_trap", "targetname");
  array::thread_all(traps, &trap_init);
}

__main__() {
  if(!zm_custom::function_901b751c(#"zmtrapsenabled")) {
    return;
  }

  traps = getEntArray("zombie_trap", "targetname");
  array::thread_all(traps, &trap_main);
}

trap_init() {
  self flag::init("flag_active");
  self flag::init("flag_cooldown");
  self._trap_type = "";

  if(isDefined(self.script_noteworthy)) {
    self._trap_type = self.script_noteworthy;

    if(isDefined(level._custom_traps) && isDefined(level._custom_traps[self.script_noteworthy]) && isDefined(level._custom_traps[self.script_noteworthy].activate)) {
      self._trap_activate_func = level._custom_traps[self.script_noteworthy].activate;
    } else {
      switch (self.script_noteworthy) {
        case #"rotating":
          self._trap_activate_func = &trap_activate_rotating;
          break;
        case #"flipper":
          self._trap_activate_func = &trap_activate_flipper;
          break;
        default:
          self._trap_activate_func = &trap_activate_fire;
          break;
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
        case #"counter_1s":
          self.counter_1s = components[i];
          continue;
        case #"counter_10s":
          self.counter_10s = components[i];
          continue;
        case #"counter_100s":
          self.counter_100s = components[i];
          continue;
        case #"mover":
          self._trap_movers[self._trap_movers.size] = components[i];
          continue;
        case #"switch":
          self._trap_switches[self._trap_switches.size] = components[i];
          continue;
        case #"light":
          self._trap_lights[self._trap_lights.size] = components[i];
          continue;
      }
    }

    if(isDefined(components[i].script_string)) {
      switch (components[i].script_string) {
        case #"flipper1":
          self.flipper1 = components[i];
          continue;
        case #"flipper2":
          self.flipper2 = components[i];
          continue;
        case #"flipper1_radius_check":
          self.flipper1_radius_check = components[i];
          continue;
        case #"flipper2_radius_check":
          self.flipper2_radius_check = components[i];
          continue;
        case #"target1":
          self.target1 = components[i];
          continue;
        case #"target2":
          self.target2 = components[i];
          continue;
        case #"target3":
          self.target3 = components[i];
          continue;
      }
    }

    switch (components[i].classname) {
      case #"trigger_use_new":
      case #"trigger_use":
        self._trap_use_trigs[self._trap_use_trigs.size] = components[i];
        components[i]._trap = self;
        break;
      case #"script_model":
        if(components[i].model == self._trap_light_model_off) {
          self._trap_lights[self._trap_lights.size] = components[i];
        } else if(components[i].model == self._trap_switch_model) {
          self._trap_switches[self._trap_switches.size] = components[i];
        }

        break;
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

  if(!isDefined(self.zombie_cost)) {
    self.zombie_cost = 1000;
  }

  self._trap_in_use = 0;
  self thread trap_dialog();
}

trap_main() {
  level flag::wait_till("start_zombie_round_logic");

  for(i = 0; i < self._trap_use_trigs.size; i++) {
    self._trap_use_trigs[i] setcursorhint("HINT_NOICON");
  }

  if(!isDefined(self.script_string) || "disable_wait_for_power" != self.script_string) {
    self trap_set_string(#"zombie/need_power");

    if(isDefined(self.script_int) && level flag::exists("power_on" + self.script_int)) {
      level flag::wait_till("power_on" + self.script_int);
    } else {
      level flag::wait_till("power_on");
    }
  }

  if(isDefined(self.script_flag_wait)) {
    self trap_set_string("");
    self triggerenable(0);
    self trap_lights_red();

    if(!level flag::exists(self.script_flag_wait)) {
      level flag::init(self.script_flag_wait);
    }

    level flag::wait_till(self.script_flag_wait);
    self triggerenable(1);
  }

  self.var_b3166dc1 = 1;
  self function_783f63e9();

  for(i = 0; i < self._trap_use_trigs.size; i++) {
    self._trap_use_trigs[i] thread[[self._trap_use_func]](self);
    self._trap_use_trigs[i] thread update_trigger_visibility();
  }
}

function_783f63e9(var_1c9c3123 = 1) {
  if(zm_trial_disable_buys::is_active()) {
    self trap_set_string(#"hash_55d25caf8f7bbb2f");
    return;
  }

  if(isDefined(self.var_fc36786e) && self.var_fc36786e || isDefined(level.var_4f7df1ac) && level.var_4f7df1ac) {
    self trap_set_string(#"zombie/trap_locked");
    return;
  }

  if(zm_utility::is_standard() || namespace_b28d86fd::is_active()) {
    cheat_too_friendly_s_ = zm_utility::function_d6046228(#"hash_24a438482954901", #"hash_61d85c966dd9e83f");
    self trap_set_string(cheat_too_friendly_s_);

    if(var_1c9c3123) {
      self trap_lights_green();
    }

    return;
  }

  cheat_too_friendly_s_ = zm_utility::function_d6046228(#"hash_23c1c09e94181fdb", #"hash_6e8ef1b690e98e51");
  self trap_set_string(cheat_too_friendly_s_, self.zombie_cost);

  if(var_1c9c3123) {
    self trap_lights_green();
  }
}

trap_use_think(trap) {
  while(true) {
    waitresult = self waittill(#"trigger");
    e_player = waitresult.activator;

    if(!zm_utility::can_use(e_player)) {
      continue;
    }

    if(isDefined(self.var_fc36786e) && self.var_fc36786e || isDefined(level.var_4f7df1ac) && level.var_4f7df1ac || zm_trial_disable_buys::is_active()) {
      continue;
    }

    if(zm_utility::is_player_valid(e_player) && !trap._trap_in_use) {
      b_purchased = self trap_purchase(e_player, trap.zombie_cost);

      if(!b_purchased) {
        continue;
      }

      trap_activate(trap, e_player);
    }
  }
}

trap_purchase(e_player, n_cost) {
  if(namespace_b28d86fd::is_active()) {
    return 1;
  }

  if(e_player zm_score::can_player_purchase(n_cost)) {
    e_player zm_score::minus_to_player_score(n_cost);
    return 1;
  }

  self playSound(#"zmb_trap_deny");
  e_player zm_audio::create_and_play_dialog(#"general", #"outofmoney");
  return 0;
}

trap_activate(trap, who) {
  trap.activated_by_player = who;
  trap._trap_in_use = 1;
  trap trap_set_string(#"zombie/trap_active");

  if(isDefined(who)) {
    zm_utility::play_sound_at_pos("purchase", who.origin);

    if(isDefined(trap._trap_type)) {
      who zm_audio::create_and_play_dialog(#"trap_activate", trap._trap_type);
    }

    level notify(#"trap_activated", {
      #trap_activator: who, 
      #trap: trap
    });
  }

  if(isarray(trap._trap_switches) && trap._trap_switches.size) {
    trap thread trap_move_switches();
    trap waittill(#"switch_activated");
  }

  trap triggerenable(1);
  trap thread[[trap._trap_activate_func]]();
  trap waittill(#"trap_done");
  trap triggerenable(0);
  trap trap_set_string(#"zombie/trap_cooldown");

  if(getdvarint(#"zombie_cheat", 0) >= 1) {
    trap._trap_cooldown_time = 5;
  }

    n_cooldown = function_da13db45(trap._trap_cooldown_time, who);
  wait n_cooldown;
  playsoundatposition(#"zmb_trap_ready", trap.origin);

  if(isDefined(level.sndtrapfunc)) {
    level thread[[level.sndtrapfunc]](trap, 0);
  }

  trap notify(#"available");
  trap._trap_in_use = 0;
  trap function_783f63e9();
}

private update_trigger_visibility() {
  self endon(#"death");

  while(true) {
    foreach(player in getplayers()) {
      if(distancesquared(player.origin, self.origin) < 16384) {
        if(player zm_utility::is_drinking()) {
          self setinvisibletoplayer(player, 1);
          continue;
        }

        self setinvisibletoplayer(player, 0);
      }
    }

    wait 0.25;
  }
}

trap_lights_red() {
  if(isDefined(level._custom_traps[self._trap_type]) && isDefined(level._custom_traps[self._trap_type].var_75734507)) {
    self[[level._custom_traps[self._trap_type].var_75734507]]();
    return;
  }

  for(i = 0; i < self._trap_lights.size; i++) {
    light = self._trap_lights[i];
    str_light_red = light.targetname + "_red";
    str_light_green = light.targetname + "_green";
    exploder::kill_exploder(str_light_green);
    exploder::exploder(str_light_red);
  }
}

trap_lights_green() {
  if(isDefined(level._custom_traps) && isDefined(level._custom_traps[self._trap_type]) && isDefined(level._custom_traps[self._trap_type].var_53d35f37)) {
    self[[level._custom_traps[self._trap_type].var_53d35f37]]();
    return;
  }

  for(i = 0; i < self._trap_lights.size; i++) {
    light = self._trap_lights[i];

    if(isDefined(light.var_1cc6f364)) {
      continue;
    }

    str_light_red = light.targetname + "_red";
    str_light_green = light.targetname + "_green";
    exploder::kill_exploder(str_light_red);
    exploder::exploder(str_light_green);
  }
}

trap_set_string(string, param1, param2) {
  if(isDefined(self) && isDefined(self._trap_use_trigs)) {
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
}

trap_move_switches() {
  self trap_lights_red();

  for(i = 0; i < self._trap_switches.size; i++) {
    self._trap_switches[i] rotatepitch(180, 0.5);

    if(isDefined(self._trap_type) && self._trap_type == "fire") {
      self._trap_switches[i] playSound(#"evt_switch_flip_trap_fire");
      continue;
    }

    self._trap_switches[i] playSound(#"evt_switch_flip_trap");
  }

  self._trap_switches[0] waittill(#"rotatedone");
  self notify(#"switch_activated");
  self waittill(#"available");

  for(i = 0; i < self._trap_switches.size; i++) {
    self._trap_switches[i] rotatepitch(-180, 0.5);
  }

  self._trap_switches[0] waittill(#"rotatedone");

  if(!(isDefined(self.var_fc36786e) && self.var_fc36786e) && !(isDefined(level.var_4f7df1ac) && level.var_4f7df1ac)) {
    self trap_lights_green();
  }
}

trap_activate_fire() {
  self._trap_duration = 40;
  self._trap_cooldown_time = 60;
  fx_points = struct::get_array(self.target, "targetname");

  for(i = 0; i < fx_points.size; i++) {
    util::wait_network_frame();
    fx_points[i] thread trap_audio_fx(self);
  }

  self thread trap_damage();
  wait self._trap_duration;
  self notify(#"trap_done");
}

trap_activate_rotating() {
  self endon(#"trap_done");
  self._trap_duration = 30;
  self._trap_cooldown_time = 60;
  self thread trap_damage();
  self thread trig_update(self._trap_movers[0]);
  old_angles = self._trap_movers[0].angles;

  for(i = 0; i < self._trap_movers.size; i++) {
    self._trap_movers[i] rotateyaw(360, 5, 4.5);
  }

  wait 5;
  step = 1.5;
  t = 0;

  while(t < self._trap_duration) {
    for(i = 0; i < self._trap_movers.size; i++) {
      self._trap_movers[i] rotateyaw(360, step);
    }

    wait step;
    t += step;
  }

  for(i = 0; i < self._trap_movers.size; i++) {
    self._trap_movers[i] rotateyaw(360, 5, 0, 4.5);
  }

  wait 5;

  for(i = 0; i < self._trap_movers.size; i++) {
    self._trap_movers[i].angles = old_angles;
  }

  self notify(#"trap_done");
}

trap_activate_flipper() {}

trap_audio_fx(trap) {
  if(isDefined(level._custom_traps) && isDefined(level._custom_traps[trap.script_noteworthy]) && isDefined(level._custom_traps[trap.script_noteworthy].audio)) {
    self[[level._custom_traps[trap.script_noteworthy].audio]](trap);
    return;
  }

  sound_origin = undefined;
  trap waittilltimeout(trap._trap_duration, #"trap_done");

  if(isDefined(sound_origin)) {
    playsoundatposition(#"wpn_zmb_electrap_stop", sound_origin.origin);
    sound_origin stoploopsound();
    waitframe(1);
    sound_origin delete();
  }
}

trap_damage() {
  self endon(#"trap_done");

  while(true) {
    waitresult = self waittill(#"trigger");
    ent = waitresult.activator;

    if(isplayer(ent)) {
      if(self function_3f401e8d(ent)) {
        continue;
      }

      if(isDefined(level._custom_traps) && isDefined(level._custom_traps[self._trap_type]) && isDefined(level._custom_traps[self._trap_type].player_damage)) {
        ent thread[[level._custom_traps[self._trap_type].player_damage]](self);
      } else {
        switch (self._trap_type) {
          case #"rocket":
            ent thread player_fire_damage();
            break;
          case #"rotating":
            if(ent getstance() == "stand") {
              ent dodamage(50, ent.origin + (0, 0, 20));
              ent setstance("crouch");
            }

            break;
        }
      }

      if(ent.health <= 1 && !(isDefined(ent.var_acc576f0) && ent.var_acc576f0)) {
        ent thread function_783361ed(self);
      }

      continue;
    }

    if(!isDefined(ent.marked_for_death)) {
      if(isDefined(level._custom_traps) && isDefined(level._custom_traps[self._trap_type]) && isDefined(level._custom_traps[self._trap_type].damage)) {
        ent thread[[level._custom_traps[self._trap_type].damage]](self);
        continue;
      }

      switch (self._trap_type) {
        case #"rocket":
          ent thread zombie_trap_death(self, 100);
          break;
        case #"rotating":
          ent thread zombie_trap_death(self, 200);
          break;
        case #"werewolfer":
          ent thread zombie_trap_death(self, 100);
          break;
        default:
          ent thread zombie_trap_death(self, randomint(100));
          break;
      }
    }
  }
}

function_783361ed(e_trap) {
  self endon(#"disconnect");
  self.var_acc576f0 = 1;
  level notify(#"trap_downed_player", {
    #e_victim: self, 
    #e_trap: e_trap
  });

  while(isalive(self) && self laststand::player_is_in_laststand()) {
    waitframe(1);
  }

  self.var_acc576f0 = undefined;
}

trig_update(parent) {
  self endon(#"trap_done");
  start_angles = self.angles;

  while(true) {
    self.angles = parent.angles;
    waitframe(1);
  }
}

player_elec_damage(trigger) {
  self endon(#"death", #"disconnect");

  if(!isDefined(level.elec_loop)) {
    level.elec_loop = 0;
  }

  if(!(isDefined(self.is_burning) && self.is_burning) && zm_utility::is_player_valid(self)) {
    self.is_burning = 1;
    shocktime = 2.5;

    if(isDefined(level.str_elec_damage_shellshock_override)) {
      str_elec_shellshock = level.str_elec_damage_shellshock_override;
    } else {
      str_elec_shellshock = "electrocution";
    }

    self shellshock(str_elec_shellshock, shocktime);
    self playrumbleonentity("damage_heavy");
    self playSound(#"hash_5af2a9d11f007b9");

    if(zm_utility::is_standard()) {
      self dodamage(50, self.origin, undefined, trigger);
    } else {
      self dodamage(150, self.origin, undefined, trigger);
    }

    wait 1;
    self.is_burning = undefined;
  }
}

player_fire_damage() {
  self endon(#"death", #"disconnect");

  if(!(isDefined(self.is_burning) && self.is_burning) && !self laststand::player_is_in_laststand()) {
    self.is_burning = 1;

    if(isDefined(level.trap_fire_visionset_registered) && level.trap_fire_visionset_registered) {
      visionset_mgr::activate("overlay", "zm_trap_burn", self, 1.25, 1.25);
    } else {
      self setburn(1.25);
    }

    self notify(#"burned");

    if(!self hasperk(#"specialty_armorvest") || self.health - 100 < 1) {
      radiusdamage(self.origin, 10, self.health + 100, self.health + 100);
      self.is_burning = undefined;
      return;
    }

    self dodamage(50, self.origin);
    wait 0.1;
    self.is_burning = undefined;
  }
}

zombie_trap_death(e_trap, param) {
  self endon(#"death");
  self.marked_for_death = 1;

  switch (e_trap._trap_type) {
    case #"rocket":
      if(isDefined(self.animname) && self.animname != "zombie_dog") {
        if(param > 90 && level.burning_zombies.size < 6) {
          level.burning_zombies[level.burning_zombies.size] = self;
          self thread zombie_flame_watch();
          self playSound(#"zmb_ignite");
          self thread zombie_death::flame_death_fx();
          playFXOnTag(level._effect[#"character_fire_death_torso"], self, "J_SpineLower");
          wait randomfloat(1.25);
        } else {
          refs[0] = "guts";
          refs[1] = "right_arm";
          refs[2] = "left_arm";
          refs[3] = "right_leg";
          refs[4] = "left_leg";
          refs[5] = "no_legs";
          refs[6] = "head";
          self.a.gib_ref = refs[randomint(refs.size)];
          playsoundatposition(#"wpn_zmb_electrap_zap", self.origin);
          wait randomfloat(1.25);
          self playSound(#"wpn_zmb_electrap_zap");
        }
      }

      if(isDefined(self.var_5475b4ad)) {
        self[[self.var_5475b4ad]](e_trap);
      } else {
        level notify(#"trap_kill", {
          #e_victim: self, 
          #e_trap: e_trap
        });
        self dodamage(self.health + 666, self.origin, e_trap);
      }

      break;
    case #"rotating":
    case #"centrifuge":
      ang = vectortoangles(e_trap.origin - self.origin);
      direction_vec = vectorscale(anglestoright(ang), param);

      if(isDefined(self.var_d89f2f98)) {
        self[[self.var_d89f2f98]](e_trap);
      }

      level notify(#"trap_kill", {
        #e_victim: self, 
        #e_trap: e_trap
      });
      self startragdoll();
      self launchragdoll(direction_vec);
      util::wait_network_frame();
      self.a.gib_ref = "head";
      self dodamage(self.health, self.origin, e_trap);
      break;
  }

  if(isDefined(e_trap.activated_by_player) && isplayer(e_trap.activated_by_player)) {
    e_trap.activated_by_player zm_stats::increment_challenge_stat(#"zombie_hunter_kill_trap");
    e_trap.activated_by_player contracts::increment_zm_contract(#"contract_zm_trap_kills");
  }
}

zombie_flame_watch() {
  self waittill(#"death");

  if(isDefined(self)) {
    self stoploopsound();
    arrayremovevalue(level.burning_zombies, self);
  }
}

play_elec_vocals() {
  if(isDefined(self)) {
    org = self.origin;
    wait 0.15;
    playsoundatposition(#"zmb_elec_vocals", org);
    playsoundatposition(#"wpn_zmb_electrap_zap", org);
    playsoundatposition(#"zmb_exp_jib_zombie", org);
  }
}

electroctute_death_fx() {
  self endon(#"death");

  if(isDefined(self.is_electrocuted) && self.is_electrocuted) {
    return;
  }

  self.is_electrocuted = 1;
  self thread electrocute_timeout();

  if(self.team == level.zombie_team) {
    level.bconfiretime = gettime();
    level.bconfireorg = self.origin;
  }

  if(isDefined(level._effect[#"elec_torso"])) {
    playFXOnTag(level._effect[#"elec_torso"], self, "J_SpineLower");
  }

  self playSound(#"zmb_elec_jib_zombie");
  wait 1;
  tagarray = [];
  tagarray[0] = "J_Elbow_LE";
  tagarray[1] = "J_Elbow_RI";
  tagarray[2] = "J_Knee_RI";
  tagarray[3] = "J_Knee_LE";
  tagarray = array::randomize(tagarray);

  if(isDefined(level._effect[#"elec_md"])) {
    playFXOnTag(level._effect[#"elec_md"], self, tagarray[0]);
  }

  self playSound(#"zmb_elec_jib_zombie");
  wait 1;
  self playSound(#"zmb_elec_jib_zombie");
  tagarray[0] = "J_Wrist_RI";
  tagarray[1] = "J_Wrist_LE";

  if(!isDefined(self.a.gib_ref) || self.a.gib_ref != "no_legs") {
    tagarray[2] = "J_Ankle_RI";
    tagarray[3] = "J_Ankle_LE";
  }

  tagarray = array::randomize(tagarray);

  if(isDefined(level._effect[#"elec_sm"])) {
    playFXOnTag(level._effect[#"elec_sm"], self, tagarray[0]);
    playFXOnTag(level._effect[#"elec_sm"], self, tagarray[1]);
  }
}

electrocute_timeout() {
  self endon(#"death");
  self playLoopSound(#"amb_fire_manager_0");
  wait 12;
  self stoploopsound();

  if(isDefined(self) && isalive(self)) {
    self.is_electrocuted = 0;
    self notify(#"stop_flame_damage");
  }
}

trap_dialog() {
  self endon(#"warning_dialog");
  level endon(#"switch_flipped");
  timer = 0;

  while(true) {
    wait 0.5;
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
        wait 0.5;
        timer++;
      }

      if(!isDefined(players[i])) {
        continue;
      }

      if(dist < 4900 && timer == 3) {
        index = zm_utility::get_player_index(players[i]);
        plr = "plr_" + index + "_";
        wait 3;
        self notify(#"warning_dialog");
      }
    }
  }
}

get_trap_array(trap_type) {
  ents = getEntArray("zombie_trap", "targetname");
  traps = [];

  for(i = 0; i < ents.size; i++) {
    if(ents[i].script_noteworthy == trap_type) {
      traps[traps.size] = ents[i];
    }
  }

  return traps;
}

trap_disable(var_ccf895cc = #"zombie/trap_locked") {
  if(!(isDefined(self.var_b3166dc1) && self.var_b3166dc1)) {
    return;
  }

  cooldown = self._trap_cooldown_time;

  if(self._trap_in_use) {
    self notify(#"trap_done");
    self notify(#"trap_finished");
    self._trap_cooldown_time = 0.05;
    self waittill(#"available");
  }

  if(isarray(self._trap_use_trigs)) {
    foreach(t_trap in self._trap_use_trigs) {
      t_trap.var_fc36786e = 1;
    }
  }

  self trap_lights_red();
  self._trap_cooldown_time = cooldown;
  self trap_set_string(var_ccf895cc);
}

trap_enable(var_f9afc2b3 = #"hash_23c1c09e94181fdb", var_b8c50025 = #"hash_6e8ef1b690e98e51") {
  if(!(isDefined(self.var_b3166dc1) && self.var_b3166dc1)) {
    return;
  }

  if(isarray(self._trap_use_trigs)) {
    foreach(t_trap in self._trap_use_trigs) {
      t_trap.var_fc36786e = undefined;
    }
  }

  str_text = zm_utility::function_d6046228(var_f9afc2b3, var_b8c50025);
  self trap_set_string(str_text, self.zombie_cost);
  self trap_lights_green();
}

function_6966417b(var_ccf895cc = #"zombie/trap_locked") {
  a_t_traps = getEntArray("zombie_trap", "targetname");

  foreach(t_trap in a_t_traps) {
    t_trap thread trap_disable(var_ccf895cc);
  }

  level.var_4f7df1ac = 1;
}

function_9d0c9706(var_f9afc2b3 = #"hash_23c1c09e94181fdb", var_b8c50025 = #"hash_6e8ef1b690e98e51") {
  a_t_traps = getEntArray("zombie_trap", "targetname");

  foreach(t_trap in a_t_traps) {
    t_trap thread trap_enable(var_f9afc2b3, var_b8c50025);
  }

  level.var_4f7df1ac = undefined;
}

trap_model_type_init() {
  if(!isDefined(self.script_parameters)) {
    self.script_parameters = "default";
  }

  switch (self.script_parameters) {
    case #"pentagon_electric":
      self._trap_light_model_off = "zombie_trap_switch_light";
      self._trap_light_model_green = "zombie_trap_switch_light_on_green";
      self._trap_light_model_red = "zombie_trap_switch_light_on_red";
      self._trap_switch_model = "zombie_trap_switch_handle";
      break;
    case #"default":
    default:
      self._trap_light_model_off = "zombie_zapper_cagelight";
      self._trap_light_model_green = "zombie_zapper_cagelight";
      self._trap_light_model_red = "zombie_zapper_cagelight";
      self._trap_switch_model = "zombie_zapper_handle";
      break;
  }
}

function_3f401e8d(e_player) {
  if(e_player hasperk(#"specialty_mod_phdflopper") || isDefined(self.var_efc76c5d) && self.var_efc76c5d || isDefined(e_player.var_c09a076a) && e_player.var_c09a076a) {
    if(e_player issliding()) {
      e_player thread function_a1812da9();
      return true;
    } else if(isDefined(e_player.var_9beb4442) && e_player.var_9beb4442 || isDefined(e_player.var_c09a076a) && e_player.var_c09a076a) {
      return true;
    }
  }

  if(e_player bgb::is_enabled(#"zm_bgb_anti_entrapment")) {
    if(!isDefined(e_player.var_410e7c36)) {
      e_player.var_410e7c36 = [];
    } else if(!isarray(e_player.var_410e7c36)) {
      e_player.var_410e7c36 = array(e_player.var_410e7c36);
    }

    if(!isinarray(e_player.var_410e7c36, self)) {
      if(!isDefined(e_player.var_410e7c36)) {
        e_player.var_410e7c36 = [];
      } else if(!isarray(e_player.var_410e7c36)) {
        e_player.var_410e7c36 = array(e_player.var_410e7c36);
      }

      e_player.var_410e7c36[e_player.var_410e7c36.size] = self;
      e_player zm_stats::increment_challenge_stat(#"hash_108042c8bd6693fb");
    }

    return true;
  }

  return false;
}

function_a1812da9() {
  self notify(#"hash_337fc06844d7d1bb");
  self endon(#"disconnect", #"hash_337fc06844d7d1bb");
  self.var_9beb4442 = 1;
  wait 0.25;
  self.var_9beb4442 = undefined;
}

function_19d61a68() {
  self.var_efc76c5d = 1;
}

function_da13db45(n_cooldown, e_player) {
  if(isDefined(e_player) && e_player hasperk(#"specialty_cooldown")) {
    n_cooldown *= 0.5;
  }

  return n_cooldown;
}

is_trap_registered(a_registered_traps) {
  return isDefined(a_registered_traps[self.script_noteworthy]);
}

register_trap_basic_info(str_trap, func_activate, func_audio) {
  assert(isDefined(str_trap), "<dev string:x38>");
  assert(isDefined(func_activate), "<dev string:x78>");
  assert(isDefined(func_audio), "<dev string:xb9>");
  _register_undefined_trap(str_trap);
  level._custom_traps[str_trap].activate = func_activate;
  level._custom_traps[str_trap].audio = func_audio;
}

_register_undefined_trap(str_trap) {
  if(!isDefined(level._custom_traps)) {
    level._custom_traps = [];
  }

  if(!isDefined(level._custom_traps[str_trap])) {
    level._custom_traps[str_trap] = spawnStruct();
  }
}

register_trap_damage(str_trap, func_player_damage, func_damage) {
  assert(isDefined(str_trap), "<dev string:x38>");
  _register_undefined_trap(str_trap);
  level._custom_traps[str_trap].player_damage = func_player_damage;
  level._custom_traps[str_trap].damage = func_damage;
}

function_60d9e800(str_trap, var_75734507, var_53d35f37) {
  assert(isDefined(str_trap), "<dev string:x38>");
  _register_undefined_trap(str_trap);
  level._custom_traps[str_trap].var_75734507 = var_75734507;
  level._custom_traps[str_trap].var_53d35f37 = var_53d35f37;
}
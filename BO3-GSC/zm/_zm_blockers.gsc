/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_blockers.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\demo_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_bb;
#using scripts\zm\_util;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_daily_challenges;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_pers_upgrades_functions;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_zonemgr;
#namespace zm_blockers;

function autoexec __init__sytem__() {
  system::register("zm_blockers", & __init__, & __main__, undefined);
}

function __init__() {
  zm_utility::add_zombie_hint("default_buy_debris", & "ZOMBIE_BUTTON_BUY_CLEAR_DEBRIS_COST");
  zm_utility::add_zombie_hint("default_buy_door", & "ZOMBIE_BUTTON_BUY_OPEN_DOOR_COST");
  zm_utility::add_zombie_hint("default_buy_door_close", & "ZOMBIE_BUTTON_BUY_CLOSE_DOOR");
  init_blockers();
}

function __main__() {
  if(isDefined(level.quantum_bomb_register_result_func)) {
    [[level.quantum_bomb_register_result_func]]("open_nearest_door", & quantum_bomb_open_nearest_door_result, 35, & quantum_bomb_open_nearest_door_validation);
  }
}

function init_blockers() {
  level.exterior_goals = struct::get_array("exterior_goal", "targetname");
  array::thread_all(level.exterior_goals, & blocker_init);
  zombie_doors = getEntArray("zombie_door", "targetname");
  if(isDefined(zombie_doors)) {
    level flag::init("door_can_close");
    array::thread_all(zombie_doors, & door_init);
  }
  zombie_debris = getEntArray("zombie_debris", "targetname");
  array::thread_all(zombie_debris, & debris_init);
  flag_blockers = getEntArray("flag_blocker", "targetname");
  array::thread_all(flag_blockers, & flag_blocker);
}

function door_init() {
  self.type = undefined;
  self.purchaser = undefined;
  self._door_open = 0;
  ent_targets = getEntArray(self.target, "targetname");
  node_targets = getnodearray(self.target, "targetname");
  targets = arraycombine(ent_targets, node_targets, 0, 1);
  if(isDefined(self.script_flag) && !isDefined(level.flag[self.script_flag])) {
    if(isDefined(self.script_flag)) {
      tokens = strtok(self.script_flag, ",");
      for(i = 0; i < tokens.size; i++) {
        level flag::init(self.script_flag);
      }
    }
  }
  if(!isDefined(self.script_noteworthy)) {
    self.script_noteworthy = "default";
  }
  self.doors = [];
  for(i = 0; i < targets.size; i++) {
    targets[i] door_classify(self);
    if(!isDefined(targets[i].og_origin)) {
      targets[i].og_origin = targets[i].origin;
      targets[i].og_angles = targets[i].angles;
    }
  }
  cost = 1000;
  if(isDefined(self.zombie_cost)) {
    cost = self.zombie_cost;
  }
  self setcursorhint("HINT_NOICON");
  self thread blocker_update_prompt_visibility();
  self thread door_think();
  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "electric_door" || self.script_noteworthy == "electric_buyable_door") {
      if(getdvarstring("ui_gametype") == "zgrief") {
        self setinvisibletoall();
        return;
      }
      self sethintstring(&"ZOMBIE_NEED_POWER");
      if(isDefined(level.door_dialog_function)) {
        self thread[[level.door_dialog_function]]();
      }
      return;
    }
    if(self.script_noteworthy == "local_electric_door") {
      if(getdvarstring("ui_gametype") == "zgrief") {
        self setinvisibletoall();
        return;
      }
      self sethintstring(&"ZOMBIE_NEED_LOCAL_POWER");
      if(isDefined(level.door_dialog_function)) {
        self thread[[level.door_dialog_function]]();
      }
      return;
    }
    if(self.script_noteworthy == "kill_counter_door") {
      self sethintstring(&"ZOMBIE_DOOR_ACTIVATE_COUNTER", cost);
      return;
    }
  }
  self zm_utility::set_hint_string(self, "default_buy_door", cost);
}

function door_classify(parent_trig) {
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "air_buy_gate") {
    unlinktraversal(self);
    parent_trig.doors[parent_trig.doors.size] = self;
    return;
  }
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "clip") {
    parent_trig.clip = self;
    parent_trig.script_string = "clip";
  } else {
    if(!isDefined(self.script_string)) {
      if(isDefined(self.script_angles)) {
        self.script_string = "rotate";
      } else if(isDefined(self.script_vector)) {
        self.script_string = "move";
      }
    } else {
      if(!isDefined(self.script_string)) {
        self.script_string = "";
      }
      switch (self.script_string) {
        case "anim": {
          assert(isDefined(self.script_animname), "" + self.targetname);
          assert(isDefined(level.scr_anim[self.script_animname]), "" + self.script_animname);
          assert(isDefined(level.blocker_anim_func), "");
          break;
        }
        case "counter_1s": {
          parent_trig.counter_1s = self;
          return;
        }
        case "counter_10s": {
          parent_trig.counter_10s = self;
          return;
        }
        case "counter_100s": {
          parent_trig.counter_100s = self;
          return;
        }
        case "explosives": {
          if(!isDefined(parent_trig.explosives)) {
            parent_trig.explosives = [];
          }
          parent_trig.explosives[parent_trig.explosives.size] = self;
          return;
        }
      }
    }
  }
  if(self.classname == "script_brushmodel") {
    self disconnectpaths();
  }
  parent_trig.doors[parent_trig.doors.size] = self;
}

function door_buy() {
  self waittill("trigger", who, force);
  if(isDefined(level.custom_door_buy_check)) {
    if(!who[[level.custom_door_buy_check]](self)) {
      return false;
    }
  }
  if(getdvarint("zombie_unlock_all") > 0 || (isDefined(force) && force)) {
    return true;
  }
  if(!who usebuttonpressed()) {
    return false;
  }
  if(who zm_utility::in_revive_trigger()) {
    return false;
  }
  if(who.is_drinking > 0) {
    return false;
  }
  cost = 0;
  upgraded = 0;
  if(zm_utility::is_player_valid(who)) {
    players = getplayers();
    cost = self.zombie_cost;
    if(who zm_pers_upgrades_functions::is_pers_double_points_active()) {
      cost = who zm_pers_upgrades_functions::pers_upgrade_double_points_cost(cost);
      upgraded = 1;
    }
    if(self._door_open == 1) {
      self.purchaser = undefined;
    } else {
      if(who zm_score::can_player_purchase(cost)) {
        who zm_score::minus_to_player_score(cost);
        scoreevents::processscoreevent("open_door", who);
        demo::bookmark("zm_player_door", gettime(), who);
        who zm_stats::increment_client_stat("doors_purchased");
        who zm_stats::increment_player_stat("doors_purchased");
        who zm_stats::increment_challenge_stat("SURVIVALIST_BUY_DOOR");
        self.purchaser = who;
      } else {
        zm_utility::play_sound_at_pos("no_purchase", self.doors[0].origin);
        if(isDefined(level.custom_door_deny_vo_func)) {
          who thread[[level.custom_door_deny_vo_func]]();
        } else {
          if(isDefined(level.custom_generic_deny_vo_func)) {
            who thread[[level.custom_generic_deny_vo_func]](1);
          } else {
            who zm_audio::create_and_play_dialog("general", "outofmoney");
          }
        }
        return false;
      }
    }
  }
  if(isDefined(level._door_open_rumble_func)) {
    who thread[[level._door_open_rumble_func]]();
  }
  who recordmapevent(5, gettime(), who.origin, level.round_number, cost);
  bb::logpurchaseevent(who, self, cost, self.target, upgraded, "_door", "_purchase");
  who zm_stats::increment_challenge_stat("ZM_DAILY_PURCHASE_DOORS");
  return true;
}

function blocker_update_prompt_visibility() {
  self endon("kill_door_think");
  self endon("kill_debris_prompt_thread");
  self endon("death");
  dist = 16384;
  while(true) {
    players = level.players;
    if(isDefined(players)) {
      for(i = 0; i < players.size; i++) {
        if(distancesquared(players[i].origin, self.origin) < dist) {
          if(players[i].is_drinking > 0) {
            self setinvisibletoplayer(players[i], 1);
            continue;
          }
          self setinvisibletoplayer(players[i], 0);
        }
      }
    }
    wait(0.25);
  }
}

function door_delay() {
  if(isDefined(self.explosives)) {
    for(i = 0; i < self.explosives.size; i++) {
      self.explosives[i] show();
    }
  }
  if(!isDefined(self.script_int)) {
    self.script_int = 5;
  }
  all_trigs = getEntArray(self.target, "target");
  for(i = 0; i < all_trigs.size; i++) {
    all_trigs[i] triggerenable(0);
  }
  wait(self.script_int);
  for(i = 0; i < self.script_int; i++) {
    iprintln(self.script_int - i);
    wait(1);
  }
  if(isDefined(self.explosives)) {
    for(i = 0; i < self.explosives.size; i++) {
      playFX(level._effect["def_explosion"], self.explosives[i].origin, anglesToForward(self.explosives[i].angles));
      self.explosives[i] hide();
    }
  }
}

function door_activate(time, open = 1, quick, use_blocker_clip_for_pathing) {
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "air_buy_gate") {
    if(open) {
      linktraversal(self);
    } else {
      unlinktraversal(self);
    }
    return;
  }
  if(!isDefined(time)) {
    time = 1;
    if(isDefined(self.script_transition_time)) {
      time = self.script_transition_time;
    }
  }
  if(isDefined(self.door_moving)) {
    if(isDefined(self.script_noteworthy) && self.script_noteworthy == "clip" || (isDefined(self.script_string) && self.script_string == "clip")) {
      if(!(isDefined(use_blocker_clip_for_pathing) && use_blocker_clip_for_pathing)) {
        if(!open) {
          return;
        }
      }
    } else {
      return;
    }
  }
  self.door_moving = 1;
  level notify("snddooropening");
  if(open || (!(isDefined(quick) && quick))) {
    self notsolid();
  }
  if(self.classname == "script_brushmodel" || self.classname == "script_model") {
    if(open) {
      self connectpaths();
    }
  }
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "clip" || (isDefined(self.script_string) && self.script_string == "clip")) {
    if(!open) {
      self util::delay(time, undefined, & self_disconnectpaths);
      wait(0.1);
      self solid();
    }
    return;
  }
  if(isDefined(self.script_sound)) {
    if(open) {
      playsoundatposition(self.script_sound, self.origin);
    } else {
      playsoundatposition(self.script_sound + "_close", self.origin);
    }
  } else {
    zm_utility::play_sound_at_pos("zmb_heavy_door_open", self.origin);
  }
  scale = 1;
  if(!open) {
    scale = -1;
  }
  switch (self.script_string) {
    case "rotate": {
      if(isDefined(self.script_angles)) {
        rot_angle = self.script_angles;
        if(!open) {
          rot_angle = self.og_angles;
        }
        self rotateto(rot_angle, time, 0, 0);
        self thread door_solid_thread();
        if(!open) {
          self thread disconnect_paths_when_done();
        }
      }
      wait(randomfloat(0.15));
      break;
    }
    case "move":
    case "slide_apart": {
      if(isDefined(self.script_vector)) {
        vector = vectorscale(self.script_vector, scale);
        if(time >= 0.5) {
          self moveto(self.origin + vector, time, time * 0.25, time * 0.25);
        } else {
          self moveto(self.origin + vector, time);
        }
        self thread door_solid_thread();
        if(!open) {
          self thread disconnect_paths_when_done();
        }
      }
      wait(randomfloat(0.15));
      break;
    }
    case "anim": {
      self[[level.blocker_anim_func]](self.script_animname);
      self thread door_solid_thread_anim();
      wait(randomfloat(0.15));
      break;
    }
    case "physics": {
      self thread physics_launch_door(self);
      wait(0.1);
      break;
    }
    case "zbarrier": {
      self thread door_zbarrier_move();
      break;
    }
  }
  if(isDefined(self.script_firefx)) {
    playFX(level._effect[self.script_firefx], self.origin);
  }
}

function kill_trapped_zombies(trigger) {
  zombies = getaiteamarray(level.zombie_team);
  if(!isDefined(zombies)) {
    return;
  }
  for(i = 0; i < zombies.size; i++) {
    if(!isDefined(zombies[i])) {
      continue;
    }
    if(zombies[i] istouching(trigger)) {
      zombies[i].marked_for_recycle = 1;
      zombies[i] dodamage(zombies[i].health + 666, trigger.origin, self);
      wait(randomfloat(0.15));
      continue;
    }
    if(isDefined(level.custom_trapped_zombies)) {
      zombies[i] thread[[level.custom_trapped_zombies]]();
      wait(randomfloat(0.15));
    }
  }
}

function any_player_touching(trigger) {
  foreach(player in getplayers()) {
    if(player istouching(trigger)) {
      return true;
    }
    wait(0.01);
  }
  return false;
}

function any_player_touching_any(trigger, more_triggers) {
  foreach(player in getplayers()) {
    if(zm_utility::is_player_valid(player, 0, 1)) {
      if(isDefined(trigger) && player istouching(trigger)) {
        return true;
      }
      if(isDefined(more_triggers) && more_triggers.size > 0) {
        foreach(trig in more_triggers) {
          if(isDefined(trig) && player istouching(trig)) {
            return true;
          }
        }
      }
    }
  }
  return false;
}

function any_zombie_touching_any(trigger, more_triggers) {
  zombies = getaiteamarray(level.zombie_team);
  foreach(zombie in zombies) {
    if(isDefined(trigger) && zombie istouching(trigger)) {
      return true;
    }
    if(isDefined(more_triggers) && more_triggers.size > 0) {
      foreach(trig in more_triggers) {
        if(isDefined(trig) && zombie istouching(trig)) {
          return true;
        }
      }
    }
  }
  return false;
}

function wait_trigger_clear(trigger, more_triggers, end_on) {
  self endon(end_on);
  while(any_player_touching_any(trigger, more_triggers) || any_zombie_touching_any(trigger, more_triggers)) {
    wait(1);
  }
  println("");
  self notify("trigger_clear");
}

function waittill_door_trigger_clear_local_power_off(trigger, all_trigs) {
  self endon("trigger_clear");
  while(true) {
    if(isDefined(self.local_power_on) && self.local_power_on) {
      self waittill("local_power_off");
    }
    println("");
    self wait_trigger_clear(trigger, all_trigs, "local_power_on");
  }
}

function waittill_door_trigger_clear_global_power_off(trigger, all_trigs) {
  self endon("trigger_clear");
  while(true) {
    if(isDefined(self.power_on) && self.power_on) {
      self waittill("power_off");
    }
    println("");
    self wait_trigger_clear(trigger, all_trigs, "power_on");
  }
}

function waittill_door_can_close() {
  trigger = undefined;
  if(isDefined(self.door_hold_trigger)) {
    trigger = getent(self.door_hold_trigger, "targetname");
  }
  all_trigs = getEntArray(self.target, "target");
  switch (self.script_noteworthy) {
    case "local_electric_door": {
      if(isDefined(trigger) || isDefined(all_trigs)) {
        self waittill_door_trigger_clear_local_power_off(trigger, all_trigs);
        self thread kill_trapped_zombies(trigger);
      } else if(isDefined(self.local_power_on) && self.local_power_on) {
        self waittill("local_power_off");
      }
      return;
    }
    case "electric_door": {
      if(isDefined(trigger) || isDefined(all_trigs)) {
        self waittill_door_trigger_clear_global_power_off(trigger, all_trigs);
        if(isDefined(trigger)) {
          self thread kill_trapped_zombies(trigger);
        }
      } else if(isDefined(self.power_on) && self.power_on) {
        self waittill("power_off");
      }
      return;
    }
  }
}

function door_think() {
  self endon("kill_door_think");
  cost = 1000;
  if(isDefined(self.zombie_cost)) {
    cost = self.zombie_cost;
  }
  self sethintlowpriority(1);
  while(true) {
    switch (self.script_noteworthy) {
      case "local_electric_door": {
        if(!(isDefined(self.local_power_on) && self.local_power_on)) {
          self waittill("local_power_on");
        }
        if(!(isDefined(self._door_open) && self._door_open)) {
          println("");
          self door_opened(cost, 1);
          if(!isDefined(self.power_cost)) {
            self.power_cost = 0;
          }
          self.power_cost = self.power_cost + 200;
        }
        self sethintstring("");
        if(isDefined(level.local_doors_stay_open) && level.local_doors_stay_open) {
          return;
        }
        wait(3);
        self waittill_door_can_close();
        self door_block();
        if(isDefined(self._door_open) && self._door_open) {
          println("");
          self door_opened(cost, 1);
        }
        self sethintstring(&"ZOMBIE_NEED_LOCAL_POWER");
        wait(3);
        continue;
      }
      case "electric_door": {
        if(!(isDefined(self.power_on) && self.power_on)) {
          self waittill("power_on");
        }
        if(!(isDefined(self._door_open) && self._door_open)) {
          println("");
          self door_opened(cost, 1);
          if(!isDefined(self.power_cost)) {
            self.power_cost = 0;
          }
          self.power_cost = self.power_cost + 200;
        }
        self sethintstring("");
        if(isDefined(level.local_doors_stay_open) && level.local_doors_stay_open) {
          return;
        }
        wait(3);
        self waittill_door_can_close();
        self door_block();
        if(isDefined(self._door_open) && self._door_open) {
          println("");
          self door_opened(cost, 1);
        }
        self sethintstring(&"ZOMBIE_NEED_POWER");
        wait(3);
        continue;
      }
      case "electric_buyable_door": {
        if(!(isDefined(self.power_on) && self.power_on)) {
          self waittill("power_on");
        }
        self zm_utility::set_hint_string(self, "default_buy_door", cost);
        if(!self door_buy()) {
          continue;
        }
        break;
      }
      case "delay_door": {
        if(!self door_buy()) {
          continue;
        }
        self door_delay();
        break;
      }
      default: {
        if(isDefined(level._default_door_custom_logic)) {
          self[[level._default_door_custom_logic]]();
          break;
        }
        if(!self door_buy()) {
          continue;
        }
        break;
      }
    }
    self door_opened(cost);
    if(!level flag::get("door_can_close")) {
      break;
    }
  }
}

function self_and_flag_wait(msg) {
  self endon(msg);
  if(isDefined(self.power_door_ignore_flag_wait) && self.power_door_ignore_flag_wait) {
    level waittill("forever");
  } else {
    level flag::wait_till(msg);
  }
}

function door_block() {
  if(isDefined(self.doors)) {
    for(i = 0; i < self.doors.size; i++) {
      if(isDefined(self.doors[i].script_noteworthy) && self.doors[i].script_noteworthy == "clip" || (isDefined(self.doors[i].script_string) && self.doors[i].script_string == "clip")) {
        self.doors[i] solid();
      }
    }
  }
}

function door_opened(cost, quick_close) {
  if(isDefined(self.door_is_moving) && self.door_is_moving) {
    return;
  }
  self.has_been_opened = 1;
  all_trigs = getEntArray(self.target, "target");
  self.door_is_moving = 1;
  foreach(trig in all_trigs) {
    trig.door_is_moving = 1;
    trig triggerenable(0);
    trig.has_been_opened = 1;
    if(!isDefined(trig._door_open) || trig._door_open == 0) {
      trig._door_open = 1;
      trig notify("door_opened");
    } else {
      trig._door_open = 0;
    }
    if(isDefined(trig.script_flag) && trig._door_open == 1) {
      tokens = strtok(trig.script_flag, ",");
      for(i = 0; i < tokens.size; i++) {
        level flag::set(tokens[i]);
      }
    } else if(isDefined(trig.script_flag) && trig._door_open == 0) {
      tokens = strtok(trig.script_flag, ",");
      for(i = 0; i < tokens.size; i++) {
        level flag::clear(tokens[i]);
      }
    }
    if(isDefined(quick_close) && quick_close) {
      trig zm_utility::set_hint_string(trig, "");
      continue;
    }
    if(trig._door_open == 1 && level flag::get("door_can_close")) {
      trig zm_utility::set_hint_string(trig, "default_buy_door_close");
      continue;
    }
    if(trig._door_open == 0) {
      trig zm_utility::set_hint_string(trig, "default_buy_door", cost);
    }
  }
  level notify("door_opened");
  if(isDefined(self.doors)) {
    is_script_model_door = 0;
    have_moving_clip_for_door = 0;
    use_blocker_clip_for_pathing = 0;
    foreach(door in self.doors) {
      if(isDefined(door.ignore_use_blocker_clip_for_pathing_check) && door.ignore_use_blocker_clip_for_pathing_check) {
        continue;
      }
      if(isDefined(door.script_noteworthy) && door.script_noteworthy == "air_buy_gate") {
        continue;
      }
      if(door.classname == "script_model") {
        is_script_model_door = 1;
        continue;
      }
      if(door.classname == "script_brushmodel" && (!isDefined(door.script_noteworthy) || door.script_noteworthy != "clip") && (!isDefined(door.script_string) || door.script_string != "clip")) {
        have_moving_clip_for_door = 1;
      }
    }
    use_blocker_clip_for_pathing = is_script_model_door && !have_moving_clip_for_door;
    for(i = 0; i < self.doors.size; i++) {
      self.doors[i] thread door_activate(self.doors[i].script_transition_time, self._door_open, quick_close, use_blocker_clip_for_pathing);
    }
    if(self.doors.size) {
      zm_utility::play_sound_at_pos("purchase", self.origin);
    }
  }
  level.active_zone_names = zm_zonemgr::get_active_zone_names();
  wait(1);
  self.door_is_moving = 0;
  foreach(trig in all_trigs) {
    trig.door_is_moving = 0;
  }
  if(isDefined(quick_close) && quick_close) {
    for(i = 0; i < all_trigs.size; i++) {
      all_trigs[i] triggerenable(1);
    }
    return;
  }
  if(level flag::get("door_can_close")) {
    wait(2);
    for(i = 0; i < all_trigs.size; i++) {
      all_trigs[i] triggerenable(1);
    }
  }
}

function physics_launch_door(door_trig) {
  vec = vectorscale(vectornormalize(self.script_vector), 10);
  self rotateroll(5, 0.05);
  wait(0.05);
  self moveto(self.origin + vec, 0.1);
  self waittill("movedone");
  self physicslaunch(self.origin, self.script_vector * 300);
  wait(60);
  self delete();
}

function door_solid_thread() {
  self util::waittill_either("rotatedone", "movedone");
  self.door_moving = undefined;
  while(true) {
    players = getplayers();
    player_touching = 0;
    for(i = 0; i < players.size; i++) {
      if(players[i] istouching(self)) {
        player_touching = 1;
        break;
      }
    }
    if(!player_touching) {
      self solid();
      return;
    }
    wait(1);
  }
}

function door_solid_thread_anim() {
  self waittillmatch("door_anim");
  self.door_moving = undefined;
  while(true) {
    players = getplayers();
    player_touching = 0;
    for(i = 0; i < players.size; i++) {
      if(players[i] istouching(self)) {
        player_touching = 1;
        break;
      }
    }
    if(!player_touching) {
      self solid();
      return;
    }
    wait(1);
  }
}

function disconnect_paths_when_done() {
  self util::waittill_either("rotatedone", "movedone");
  self disconnectpaths();
}

function self_disconnectpaths() {
  self disconnectpaths();
}

function debris_init() {
  cost = 1000;
  if(isDefined(self.zombie_cost)) {
    cost = self.zombie_cost;
  }
  self zm_utility::set_hint_string(self, "default_buy_debris", cost);
  self setcursorhint("HINT_NOICON");
  if(isDefined(self.script_flag) && !isDefined(level.flag[self.script_flag])) {
    level flag::init(self.script_flag);
  }
  if(isDefined(self.target)) {
    targets = getEntArray(self.target, "targetname");
    foreach(target in targets) {
      if(target iszbarrier()) {
        for(i = 0; i < target getnumzbarrierpieces(); i++) {
          target setzbarrierpiecestate(i, "closed");
        }
      }
    }
    a_nd_targets = getnodearray(self.target, "targetname");
    foreach(nd_target in a_nd_targets) {
      if(isDefined(nd_target.script_noteworthy) && nd_target.script_noteworthy == "air_buy_gate") {
        unlinktraversal(nd_target);
      }
    }
  }
  self thread blocker_update_prompt_visibility();
  self thread debris_think();
}

function debris_think() {
  if(isDefined(level.custom_debris_function)) {
    self[[level.custom_debris_function]]();
  }
  junk = getEntArray(self.target, "targetname");
  for(i = 0; i < junk.size; i++) {
    if(isDefined(junk[i].script_noteworthy)) {
      if(junk[i].script_noteworthy == "clip") {
        junk[i] disconnectpaths();
      }
    }
  }
  while(true) {
    self waittill("trigger", who, force);
    if(getdvarint("zombie_unlock_all") > 0 || (isDefined(force) && force)) {} else {
      if(!who usebuttonpressed()) {
        continue;
      }
      if(who.is_drinking > 0) {
        continue;
      }
      if(who zm_utility::in_revive_trigger()) {
        continue;
      }
    }
    if(zm_utility::is_player_valid(who)) {
      players = getplayers();
      if(getdvarint("zombie_unlock_all") > 0) {} else {
        if(who zm_score::can_player_purchase(self.zombie_cost)) {
          who zm_score::minus_to_player_score(self.zombie_cost);
          scoreevents::processscoreevent("open_door", who);
          demo::bookmark("zm_player_door", gettime(), who);
          who zm_stats::increment_client_stat("doors_purchased");
          who zm_stats::increment_player_stat("doors_purchased");
          who zm_stats::increment_challenge_stat("SURVIVALIST_BUY_DOOR");
        } else {
          zm_utility::play_sound_at_pos("no_purchase", self.origin);
          who zm_audio::create_and_play_dialog("general", "outofmoney");
          continue;
        }
      }
      self notify("kill_debris_prompt_thread");
      junk = getEntArray(self.target, "targetname");
      if(isDefined(self.script_flag)) {
        tokens = strtok(self.script_flag, ",");
        for(i = 0; i < tokens.size; i++) {
          level flag::set(tokens[i]);
        }
      }
      zm_utility::play_sound_at_pos("purchase", self.origin);
      level notify("hash_bf60bc80");
      move_ent = undefined;
      a_clip = [];
      for(i = 0; i < junk.size; i++) {
        junk[i] connectpaths();
        if(isDefined(junk[i].script_noteworthy)) {
          if(junk[i].script_noteworthy == "clip") {
            a_clip[a_clip.size] = junk[i];
            continue;
          }
        }
        struct = undefined;
        if(junk[i] iszbarrier()) {
          move_ent = junk[i];
          junk[i] thread debris_zbarrier_move();
          continue;
        }
        if(isDefined(junk[i].script_linkto)) {
          struct = struct::get(junk[i].script_linkto, "script_linkname");
          if(isDefined(struct)) {
            move_ent = junk[i];
            junk[i] thread debris_move(struct);
          } else {
            junk[i] delete();
          }
          continue;
        }
        if(isDefined(junk[i].target)) {
          struct = struct::get(junk[i].target, "targetname");
          if(isDefined(struct)) {
            move_ent = junk[i];
            junk[i] thread debris_move(struct);
          } else {
            junk[i] delete();
          }
          continue;
        }
        junk[i] delete();
      }
      a_nd_targets = getnodearray(self.target, "targetname");
      foreach(nd_target in a_nd_targets) {
        if(isDefined(nd_target.script_noteworthy) && nd_target.script_noteworthy == "air_buy_gate") {
          linktraversal(nd_target);
        }
      }
      all_trigs = getEntArray(self.target, "target");
      for(i = 0; i < all_trigs.size; i++) {
        all_trigs[i] delete();
      }
      for(i = 0; i < a_clip.size; i++) {
        a_clip[i] delete();
      }
      if(isDefined(move_ent)) {
        move_ent waittill("movedone");
      }
      break;
    }
  }
}

function debris_zbarrier_move() {
  playsoundatposition("zmb_lightning_l", self.origin);
  playFX(level._effect["poltergeist"], self.origin);
  for(i = 0; i < self getnumzbarrierpieces(); i++) {
    self thread move_chunk(i, 1);
  }
}

function door_zbarrier_move() {
  for(i = 0; i < self getnumzbarrierpieces(); i++) {
    self thread move_chunk(i, 0);
  }
}

function move_chunk(index, b_hide) {
  self setzbarrierpiecestate(index, "opening");
  while(self getzbarrierpiecestate(index) == "opening") {
    wait(0.1);
  }
  self notify("movedone");
  if(b_hide) {
    self hidezbarrierpiece(index);
  }
}

function debris_move(struct) {
  self util::script_delay();
  self notsolid();
  self zm_utility::play_sound_on_ent("debris_move");
  playsoundatposition("zmb_lightning_l", self.origin);
  if(isDefined(self.script_firefx)) {
    playFX(level._effect[self.script_firefx], self.origin);
  }
  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "jiggle") {
      num = randomintrange(3, 5);
      og_angles = self.angles;
      for(i = 0; i < num; i++) {
        angles = og_angles + (-5 + randomfloat(10), -5 + randomfloat(10), -5 + randomfloat(10));
        time = randomfloatrange(0.1, 0.4);
        self rotateto(angles, time);
        wait(time - 0.05);
      }
    }
  }
  time = 0.5;
  if(isDefined(self.script_transition_time)) {
    time = self.script_transition_time;
  }
  self moveto(struct.origin, time, time * 0.5);
  self rotateto(struct.angles, time * 0.75);
  self waittill("movedone");
  if(isDefined(self.script_fxid)) {
    playFX(level._effect[self.script_fxid], self.origin);
    playsoundatposition("zmb_zombie_spawn", self.origin);
  }
  self delete();
}

function blocker_disconnect_paths(start_node, end_node, two_way) {}

function blocker_connect_paths(start_node, end_node, two_way) {}

function blocker_init() {
  if(!isDefined(self.target)) {
    return;
  }
  pos = zm_utility::groundpos(self.origin) + vectorscale((0, 0, 1), 8);
  if(isDefined(pos)) {
    self.origin = pos;
  }
  targets = getEntArray(self.target, "targetname");
  self.barrier_chunks = [];
  for(j = 0; j < targets.size; j++) {
    if(targets[j] iszbarrier()) {
      if(isDefined(level.zbarrier_override)) {
        self thread[[level.zbarrier_override]](targets[j]);
        continue;
      }
      self.zbarrier = targets[j];
      self.zbarrier.chunk_health = [];
      for(i = 0; i < self.zbarrier getnumzbarrierpieces(); i++) {
        self.zbarrier.chunk_health[i] = 0;
      }
      continue;
    }
    if(isDefined(targets[j].script_string) && targets[j].script_string == "rock") {
      targets[j].material = "rock";
    }
    if(isDefined(targets[j].script_parameters)) {
      if(targets[j].script_parameters == "grate") {
        if(isDefined(targets[j].script_noteworthy)) {
          if(targets[j].script_noteworthy == "2" || targets[j].script_noteworthy == "3" || targets[j].script_noteworthy == "4" || targets[j].script_noteworthy == "5" || targets[j].script_noteworthy == "6") {
            targets[j] hide();
            iprintlnbold("");
          }
        }
      } else {
        if(targets[j].script_parameters == "repair_board") {
          targets[j].unbroken_section = getent(targets[j].target, "targetname");
          if(isDefined(targets[j].unbroken_section)) {
            targets[j].unbroken_section linkto(targets[j]);
            targets[j] hide();
            targets[j] notsolid();
            targets[j].unbroken = 1;
            if(isDefined(targets[j].unbroken_section.script_noteworthy) && targets[j].unbroken_section.script_noteworthy == "glass") {
              targets[j].material = "glass";
              targets[j] thread destructible_glass_barricade(targets[j].unbroken_section, self);
            } else if(isDefined(targets[j].unbroken_section.script_noteworthy) && targets[j].unbroken_section.script_noteworthy == "metal") {
              targets[j].material = "metal";
            }
          }
        } else if(targets[j].script_parameters == "barricade_vents") {
          targets[j].material = "metal_vent";
        }
      }
    }
    if(isDefined(targets[j].targetname)) {}
    targets[j] update_states("repaired");
    targets[j].destroyed = 0;
    targets[j] show();
    targets[j].claimed = 0;
    targets[j].anim_grate_index = 0;
    targets[j].og_origin = targets[j].origin;
    targets[j].og_angles = targets[j].angles;
    self.barrier_chunks[self.barrier_chunks.size] = targets[j];
  }
  target_nodes = getnodearray(self.target, "targetname");
  for(j = 0; j < target_nodes.size; j++) {
    if(target_nodes[j].type == "Begin") {
      self.neg_start = target_nodes[j];
      if(isDefined(self.neg_start.target)) {
        self.neg_end = getnode(self.neg_start.target, "targetname");
      }
      blocker_disconnect_paths(self.neg_start, self.neg_end);
    }
  }
  if(isDefined(self.zbarrier)) {
    if(isDefined(self.barrier_chunks)) {
      for(i = 0; i < self.barrier_chunks.size; i++) {
        self.barrier_chunks[i] delete();
      }
      self.barrier_chunks = [];
    }
  }
  if(isDefined(self.zbarrier) && should_delete_zbarriers()) {
    self.zbarrier delete();
    self.zbarrier = undefined;
    return;
  }
  self blocker_attack_spots();
  self.trigger_location = struct::get(self.target, "targetname");
  self thread blocker_think();
}

function should_delete_zbarriers() {
  gametype = getdvarstring("ui_gametype");
  if(!zm_utility::is_classic() && !zm_utility::is_standard() && gametype != "zgrief") {
    return true;
  }
  return false;
}

function destructible_glass_barricade(unbroken_section, node) {
  unbroken_section setCanDamage(1);
  unbroken_section.health = 99999;
  unbroken_section waittill("damage", amount, who);
  if(zm_utility::is_player_valid(who) || who laststand::player_is_in_laststand()) {
    self thread zm_spawner::zombie_boardtear_offset_fx_horizontle(self, node);
    level thread remove_chunk(self, node, 1);
    self update_states("destroyed");
    self notify("destroyed");
    self.unbroken = 0;
  }
}

function blocker_attack_spots() {
  spots = [];
  numslots = self.zbarrier getzbarriernumattackslots();
  numslots = int(max(numslots, 1));
  if(numslots % 2) {
    spots[spots.size] = zm_utility::groundpos_ignore_water_new(self.zbarrier.origin + vectorscale((0, 0, 1), 60));
  }
  if(numslots > 1) {
    reps = floor(numslots / 2);
    slot = 1;
    for(i = 0; i < reps; i++) {
      offset = self.zbarrier getzbarrierattackslothorzoffset() * (i + 1);
      spots[spots.size] = zm_utility::groundpos_ignore_water_new((spots[0] + (anglestoright(self.angles) * offset)) + vectorscale((0, 0, 1), 60));
      slot++;
      if(slot < numslots) {
        spots[spots.size] = zm_utility::groundpos_ignore_water_new((spots[0] + (anglestoright(self.angles) * (offset * -1))) + vectorscale((0, 0, 1), 60));
        slot++;
      }
    }
  }
  taken = [];
  for(i = 0; i < spots.size; i++) {
    taken[i] = 0;
  }
  self.attack_spots_taken = taken;
  self.attack_spots = spots;
  self thread zm_utility::debug_attack_spots_taken();
}

function blocker_choke() {
  level._blocker_choke = 0;
  level endon("stop_blocker_think");
  while(true) {
    wait(0.05);
    level._blocker_choke = 0;
  }
}

function blocker_think() {
  level endon("stop_blocker_think");
  if(!isDefined(level._blocker_choke)) {
    level thread blocker_choke();
  }
  use_choke = 0;
  if(isDefined(level._use_choke_blockers) && level._use_choke_blockers == 1) {
    use_choke = 1;
  }
  while(true) {
    wait(0.5);
    if(use_choke) {
      if(level._blocker_choke > 3) {
        wait(0.05);
      }
    }
    level._blocker_choke++;
    if(zm_utility::all_chunks_intact(self, self.barrier_chunks)) {
      continue;
    }
    if(zm_utility::no_valid_repairable_boards(self, self.barrier_chunks)) {
      continue;
    }
    self blocker_trigger_think();
  }
}

function player_fails_blocker_repair_trigger_preamble(player, players, trigger, hold_required) {
  if(!isDefined(trigger)) {
    return true;
  }
  if(!zm_utility::is_player_valid(player)) {
    return true;
  }
  if(players.size == 1 && isDefined(players[0].intermission) && players[0].intermission == 1) {
    return true;
  }
  if(hold_required && !player usebuttonpressed()) {
    return true;
  }
  if(!hold_required && !player util::use_button_held()) {
    return true;
  }
  if(player zm_utility::in_revive_trigger()) {
    return true;
  }
  if(player.is_drinking > 0) {
    return true;
  }
  return false;
}

function has_blocker_affecting_perk() {
  has_perk = undefined;
  if(self hasperk("specialty_fastreload")) {
    has_perk = "specialty_fastreload";
  }
  return has_perk;
}

function do_post_chunk_repair_delay(has_perk) {
  if(!self util::script_delay()) {
    wait(1);
  }
}

function handle_post_board_repair_rewards(cost, zbarrier) {
  self zm_stats::increment_client_stat("boards");
  self zm_stats::increment_player_stat("boards");
  if(isDefined(self.pers["boards"]) && (self.pers["boards"] % 10) == 0) {
    self zm_audio::create_and_play_dialog("general", "rebuild_boards");
  }
  self zm_pers_upgrades_functions::pers_boards_updated(zbarrier);
  self.rebuild_barrier_reward = self.rebuild_barrier_reward + cost;
  if(self.rebuild_barrier_reward < level.zombie_vars["rebuild_barrier_cap_per_round"]) {
    self zm_score::player_add_points("rebuild_board", cost);
    self zm_utility::play_sound_on_ent("purchase");
  }
  if(isDefined(self.board_repair)) {
    self.board_repair = self.board_repair + 1;
  }
}

function blocker_unitrigger_think() {
  self endon("kill_trigger");
  while(true) {
    self waittill("trigger", player);
    self.stub.trigger_target notify("trigger", player);
  }
}

function blocker_trigger_think() {
  self endon("blocker_hacked");
  if(isDefined(level.no_board_repair) && level.no_board_repair) {
    return;
  }
  println("");
  level endon("stop_blocker_think");
  cost = 10;
  if(isDefined(self.zombie_cost)) {
    cost = self.zombie_cost;
  }
  original_cost = cost;
  if(!isDefined(self.unitrigger_stub)) {
    radius = 94.21;
    height = 94.21;
    if(isDefined(self.trigger_location)) {
      trigger_location = self.trigger_location;
    } else {
      trigger_location = self;
    }
    if(isDefined(trigger_location.radius)) {
      radius = trigger_location.radius;
    }
    if(isDefined(trigger_location.height)) {
      height = trigger_location.height;
    }
    trigger_pos = zm_utility::groundpos(trigger_location.origin) + vectorscale((0, 0, 1), 4);
    self.unitrigger_stub = spawnStruct();
    self.unitrigger_stub.origin = trigger_pos;
    self.unitrigger_stub.radius = radius;
    self.unitrigger_stub.height = height;
    self.unitrigger_stub.script_unitrigger_type = "unitrigger_radius";
    self.unitrigger_stub.hint_string = zm_utility::get_hint_string(self, "default_reward_barrier_piece");
    self.unitrigger_stub.cursor_hint = "HINT_NOICON";
    self.unitrigger_stub.trigger_target = self;
    zm_unitrigger::unitrigger_force_per_player_triggers(self.unitrigger_stub, 1);
    self.unitrigger_stub.prompt_and_visibility_func = & blockertrigger_update_prompt;
    zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, & blocker_unitrigger_think);
    zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
    if(!isDefined(trigger_location.angles)) {
      trigger_location.angles = (0, 0, 0);
    }
    self.unitrigger_stub.origin = (zm_utility::groundpos(trigger_location.origin) + vectorscale((0, 0, 1), 4)) + (anglesToForward(trigger_location.angles) * -11);
  }
  self thread trigger_delete_on_repair();
  thread zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, & blocker_unitrigger_think);
  if(getdvarint("") > 0) {
    thread zm_utility::debug_blocker(trigger_pos, radius, height);
  }
  while(true) {
    self waittill("trigger", player);
    has_perk = player has_blocker_affecting_perk();
    if(zm_utility::all_chunks_intact(self, self.barrier_chunks)) {
      self notify("all_boards_repaired");
      return;
    }
    if(zm_utility::no_valid_repairable_boards(self, self.barrier_chunks)) {
      self notify("hash_46d36511");
      return;
    }
    if(isDefined(level._zm_blocker_trigger_think_return_override)) {
      if(self[[level._zm_blocker_trigger_think_return_override]](player)) {
        return;
      }
    }
    while(true) {
      players = getplayers();
      trigger = self.unitrigger_stub zm_unitrigger::unitrigger_trigger(player);
      if(player_fails_blocker_repair_trigger_preamble(player, players, trigger, 0)) {
        break;
      }
      player notify("boarding_window", self);
      if(isDefined(self.zbarrier)) {
        chunk = zm_utility::get_random_destroyed_chunk(self, self.barrier_chunks);
        self thread replace_chunk(self, chunk, has_perk, isDefined(player.pers_upgrades_awarded["board"]) && player.pers_upgrades_awarded["board"]);
      } else {
        chunk = zm_utility::get_random_destroyed_chunk(self, self.barrier_chunks);
        if(isDefined(chunk.script_parameter) && chunk.script_parameters == "repair_board" || chunk.script_parameters == "barricade_vents") {
          if(isDefined(chunk.unbroken_section)) {
            chunk show();
            chunk solid();
            chunk.unbroken_section zm_utility::self_delete();
          }
        } else {
          chunk show();
        }
        if(!isDefined(chunk.script_parameters) || chunk.script_parameters == "board" || chunk.script_parameters == "repair_board" || chunk.script_parameters == "barricade_vents") {
          if(!(isDefined(level.use_clientside_board_fx) && level.use_clientside_board_fx)) {
            if(!isDefined(chunk.material) || (isDefined(chunk.material) && chunk.material != "rock")) {
              chunk zm_utility::play_sound_on_ent("rebuild_barrier_piece");
            }
            playsoundatposition("zmb_cha_ching", (0, 0, 0));
          }
        }
        if(chunk.script_parameters == "bar") {
          chunk zm_utility::play_sound_on_ent("rebuild_barrier_piece");
          playsoundatposition("zmb_cha_ching", (0, 0, 0));
        }
        if(isDefined(chunk.script_parameters)) {
          if(chunk.script_parameters == "bar") {
            if(isDefined(chunk.script_noteworthy)) {
              if(chunk.script_noteworthy == "5") {
                chunk hide();
              } else if(chunk.script_noteworthy == "3") {
                chunk hide();
              }
            }
          }
        }
        self thread replace_chunk(self, chunk, has_perk, isDefined(player.pers_upgrades_awarded["board"]) && player.pers_upgrades_awarded["board"]);
      }
      if(isDefined(self.clip)) {
        self.clip triggerenable(1);
        self.clip disconnectpaths();
      } else {
        blocker_disconnect_paths(self.neg_start, self.neg_end);
      }
      self do_post_chunk_repair_delay(has_perk);
      if(!zm_utility::is_player_valid(player)) {
        break;
      }
      player handle_post_board_repair_rewards(cost, self);
      if(zm_utility::all_chunks_intact(self, self.barrier_chunks)) {
        self notify("all_boards_repaired");
        player increment_window_repaired();
        return;
      }
      if(zm_utility::no_valid_repairable_boards(self, self.barrier_chunks)) {
        self notify("hash_46d36511");
        player increment_window_repaired(self);
        return;
      }
    }
  }
}

function increment_window_repaired(s_barrier) {
  self zm_stats::increment_challenge_stat("SURVIVALIST_BOARD");
  self incrementplayerstat("windowsBoarded", 1);
  self thread zm_daily_challenges::increment_windows_repaired(s_barrier);
}

function blockertrigger_update_prompt(player) {
  can_use = self.stub blockerstub_update_prompt(player);
  self setinvisibletoplayer(player, !can_use);
  self sethintstring(self.stub.hint_string);
  return can_use;
}

function blockerstub_update_prompt(player) {
  if(!zm_utility::is_player_valid(player)) {
    return false;
  }
  if(player zm_utility::in_revive_trigger()) {
    return false;
  }
  if(player.is_drinking > 0) {
    return false;
  }
  return true;
}

function random_destroyed_chunk_show() {
  wait(0.5);
  self show();
}

function door_repaired_rumble_n_sound() {
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    if(distance(players[i].origin, self.origin) < 150) {
      if(isalive(players[i])) {
        players[i] thread board_completion();
      }
    }
  }
}

function board_completion() {
  self endon("disconnect");
}

function trigger_delete_on_repair() {
  while(true) {
    self util::waittill_either("all_boards_repaired", "no valid boards");
    zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
    break;
  }
}

function rebuild_barrier_reward_reset() {
  self.rebuild_barrier_reward = 0;
}

function remove_chunk(chunk, node, destroy_immediately, zomb) {
  chunk update_states("mid_tear");
  if(isDefined(chunk.script_parameters)) {
    if(chunk.script_parameters == "board" || chunk.script_parameters == "repair_board" || chunk.script_parameters == "barricade_vents") {
      chunk thread zombie_boardtear_audio_offset(chunk);
    }
  }
  if(isDefined(chunk.script_parameters)) {
    if(chunk.script_parameters == "bar") {
      chunk thread zombie_bartear_audio_offset(chunk);
    }
  }
  chunk notsolid();
  fx = "wood_chunk_destory";
  if(isDefined(self.script_fxid)) {
    fx = self.script_fxid;
  }
  if(isDefined(chunk.script_moveoverride) && chunk.script_moveoverride) {
    chunk hide();
  }
  if(isDefined(chunk.script_parameters) && chunk.script_parameters == "bar") {
    if(isDefined(chunk.script_noteworthy) && chunk.script_noteworthy == "4") {
      ent = spawn("script_origin", chunk.origin);
      ent.angles = node.angles + vectorscale((0, 1, 0), 180);
      dist = 100;
      if(isDefined(chunk.script_move_dist)) {
        dist_max = chunk.script_move_dist - 100;
        dist = 100 + randomint(dist_max);
      } else {
        dist = 100 + randomint(100);
      }
      dest = ent.origin + (anglesToForward(ent.angles) * dist);
      trace = bulletTrace(dest + vectorscale((0, 0, 1), 16), dest + (vectorscale((0, 0, -1), 200)), 0, undefined);
      if(trace["fraction"] == 1) {
        dest = dest + (vectorscale((0, 0, -1), 200));
      } else {
        dest = trace["position"];
      }
      chunk linkto(ent);
      time = ent zm_utility::fake_physicslaunch(dest, 300 + randomint(100));
      if(randomint(100) > 40) {
        ent rotatepitch(180, time * 0.5);
      } else {
        ent rotatepitch(90, time, time * 0.5);
      }
      wait(time);
      chunk hide();
      wait(0.1);
      ent delete();
    } else {
      ent = spawn("script_origin", chunk.origin);
      ent.angles = node.angles + vectorscale((0, 1, 0), 180);
      dist = 100;
      if(isDefined(chunk.script_move_dist)) {
        dist_max = chunk.script_move_dist - 100;
        dist = 100 + randomint(dist_max);
      } else {
        dist = 100 + randomint(100);
      }
      dest = ent.origin + (anglesToForward(ent.angles) * dist);
      trace = bulletTrace(dest + vectorscale((0, 0, 1), 16), dest + (vectorscale((0, 0, -1), 200)), 0, undefined);
      if(trace["fraction"] == 1) {
        dest = dest + (vectorscale((0, 0, -1), 200));
      } else {
        dest = trace["position"];
      }
      chunk linkto(ent);
      time = ent zm_utility::fake_physicslaunch(dest, 260 + randomint(100));
      if(randomint(100) > 40) {
        ent rotatepitch(180, time * 0.5);
      } else {
        ent rotatepitch(90, time, time * 0.5);
      }
      wait(time);
      chunk hide();
      wait(0.1);
      ent delete();
    }
    chunk update_states("destroyed");
    chunk notify("destroyed");
  }
  if(isDefined(chunk.script_parameters) && chunk.script_parameters == "board" || chunk.script_parameters == "repair_board" || chunk.script_parameters == "barricade_vents") {
    ent = spawn("script_origin", chunk.origin);
    ent.angles = node.angles + vectorscale((0, 1, 0), 180);
    dist = 100;
    if(isDefined(chunk.script_move_dist)) {
      dist_max = chunk.script_move_dist - 100;
      dist = 100 + randomint(dist_max);
    } else {
      dist = 100 + randomint(100);
    }
    dest = ent.origin + (anglesToForward(ent.angles) * dist);
    trace = bulletTrace(dest + vectorscale((0, 0, 1), 16), dest + (vectorscale((0, 0, -1), 200)), 0, undefined);
    if(trace["fraction"] == 1) {
      dest = dest + (vectorscale((0, 0, -1), 200));
    } else {
      dest = trace["position"];
    }
    chunk linkto(ent);
    time = ent zm_utility::fake_physicslaunch(dest, 200 + randomint(100));
    if(isDefined(chunk.unbroken_section)) {
      if(!isDefined(chunk.material) || chunk.material != "metal") {
        chunk.unbroken_section zm_utility::self_delete();
      }
    }
    if(randomint(100) > 40) {
      ent rotatepitch(180, time * 0.5);
    } else {
      ent rotatepitch(90, time, time * 0.5);
    }
    wait(time);
    if(isDefined(chunk.unbroken_section)) {
      if(isDefined(chunk.material) && chunk.material == "metal") {
        chunk.unbroken_section zm_utility::self_delete();
      }
    }
    chunk hide();
    wait(0.1);
    ent delete();
    chunk update_states("destroyed");
    chunk notify("destroyed");
  }
  if(isDefined(chunk.script_parameters) && chunk.script_parameters == "grate") {
    if(isDefined(chunk.script_noteworthy) && chunk.script_noteworthy == "6") {
      ent = spawn("script_origin", chunk.origin);
      ent.angles = node.angles + vectorscale((0, 1, 0), 180);
      dist = 100 + randomint(100);
      dest = ent.origin + (anglesToForward(ent.angles) * dist);
      trace = bulletTrace(dest + vectorscale((0, 0, 1), 16), dest + (vectorscale((0, 0, -1), 200)), 0, undefined);
      if(trace["fraction"] == 1) {
        dest = dest + (vectorscale((0, 0, -1), 200));
      } else {
        dest = trace["position"];
      }
      chunk linkto(ent);
      time = ent zm_utility::fake_physicslaunch(dest, 200 + randomint(100));
      if(randomint(100) > 40) {
        ent rotatepitch(180, time * 0.5);
      } else {
        ent rotatepitch(90, time, time * 0.5);
      }
      wait(time);
      chunk hide();
      ent delete();
      chunk update_states("destroyed");
      chunk notify("destroyed");
    } else {
      chunk hide();
      chunk update_states("destroyed");
      chunk notify("destroyed");
    }
  }
}

function remove_chunk_rotate_grate(chunk) {
  if(isDefined(chunk.script_parameters) && chunk.script_parameters == "grate") {
    chunk vibrate(vectorscale((0, 1, 0), 270), 0.2, 0.4, 0.4);
    return;
  }
}

function zombie_boardtear_audio_offset(chunk) {
  if(isDefined(chunk.material) && !isDefined(chunk.already_broken)) {
    chunk.already_broken = 0;
  }
  if(isDefined(chunk.material) && chunk.material == "glass" && chunk.already_broken == 0) {
    chunk playSound("zmb_break_glass_barrier");
    wait(randomfloatrange(0.3, 0.6));
    chunk playSound("zmb_break_glass_barrier");
    chunk.already_broken = 1;
  } else {
    if(isDefined(chunk.material) && chunk.material == "metal" && chunk.already_broken == 0) {
      chunk playSound("grab_metal_bar");
      wait(randomfloatrange(0.3, 0.6));
      chunk playSound("break_metal_bar");
      chunk.already_broken = 1;
    } else {
      if(isDefined(chunk.material) && chunk.material == "rock") {
        if(!(isDefined(level.use_clientside_rock_tearin_fx) && level.use_clientside_rock_tearin_fx)) {
          chunk playSound("zmb_break_rock_barrier");
          wait(randomfloatrange(0.3, 0.6));
          chunk playSound("zmb_break_rock_barrier");
        }
        chunk.already_broken = 1;
      } else {
        if(isDefined(chunk.material) && chunk.material == "metal_vent") {
          if(!(isDefined(level.use_clientside_board_fx) && level.use_clientside_board_fx)) {
            chunk playSound("evt_vent_slat_remove");
          }
        } else {
          if(!(isDefined(level.use_clientside_board_fx) && level.use_clientside_board_fx)) {
            chunk zm_utility::play_sound_on_ent("break_barrier_piece");
            wait(randomfloatrange(0.3, 0.6));
            chunk zm_utility::play_sound_on_ent("break_barrier_piece");
          }
          chunk.already_broken = 1;
        }
      }
    }
  }
}

function zombie_bartear_audio_offset(chunk) {
  chunk zm_utility::play_sound_on_ent("grab_metal_bar");
  wait(randomfloatrange(0.3, 0.6));
  chunk zm_utility::play_sound_on_ent("break_metal_bar");
  wait(randomfloatrange(1, 1.3));
  chunk zm_utility::play_sound_on_ent("drop_metal_bar");
}

function ensure_chunk_is_back_to_origin(chunk) {
  if(chunk.origin != chunk.og_origin) {
    chunk notsolid();
    chunk waittill("movedone");
  }
}

function replace_chunk(barrier, chunk, perk, upgrade, via_powerup) {
  if(!isDefined(barrier.zbarrier)) {
    chunk update_states("mid_repair");
    assert(isDefined(chunk.og_origin));
    assert(isDefined(chunk.og_angles));
    sound = "rebuild_barrier_hover";
    if(isDefined(chunk.script_presound)) {
      sound = chunk.script_presound;
    }
  }
  has_perk = 0;
  if(isDefined(perk)) {
    has_perk = 1;
  }
  if(!isDefined(via_powerup) && isDefined(sound)) {
    zm_utility::play_sound_at_pos(sound, chunk.origin);
  }
  if(upgrade) {
    barrier.zbarrier zbarrierpieceuseupgradedmodel(chunk);
    barrier.zbarrier.chunk_health[chunk] = barrier.zbarrier getupgradedpiecenumlives(chunk);
  } else {
    barrier.zbarrier zbarrierpieceusedefaultmodel(chunk);
    barrier.zbarrier.chunk_health[chunk] = 0;
  }
  scalar = 1;
  if(has_perk) {
    if("specialty_fastreload" == perk) {
      scalar = 0.31;
    }
  }
  barrier.zbarrier showzbarrierpiece(chunk);
  barrier.zbarrier setzbarrierpiecestate(chunk, "closing", scalar);
  waitduration = barrier.zbarrier getzbarrierpieceanimlengthforstate(chunk, "closing", scalar);
  wait(waitduration);
}

function open_all_zbarriers() {
  foreach(barrier in level.exterior_goals) {
    if(isDefined(barrier.zbarrier)) {
      for(x = 0; x < barrier.zbarrier getnumzbarrierpieces(); x++) {
        barrier.zbarrier setzbarrierpiecestate(x, "opening");
      }
    }
    if(isDefined(barrier.clip)) {
      barrier.clip triggerenable(0);
      barrier.clip connectpaths();
      continue;
    }
    blocker_connect_paths(barrier.neg_start, barrier.neg_end);
  }
}

function zombie_boardtear_audio_plus_fx_offset_repair_horizontal(chunk) {
  if(isDefined(chunk.material) && chunk.material == "rock") {
    if(isDefined(level.use_clientside_rock_tearin_fx) && level.use_clientside_rock_tearin_fx) {
      chunk clientfield::set("tearin_rock_fx", 0);
    } else {
      earthquake(randomfloatrange(0.3, 0.4), randomfloatrange(0.2, 0.4), chunk.origin, 150);
      wait(randomfloatrange(0.3, 0.6));
      chunk zm_utility::play_sound_on_ent("break_barrier_piece");
    }
  } else {
    if(isDefined(level.use_clientside_board_fx) && level.use_clientside_board_fx) {
      chunk clientfield::set("tearin_board_vertical_fx", 0);
    } else {
      earthquake(randomfloatrange(0.3, 0.4), randomfloatrange(0.2, 0.4), chunk.origin, 150);
      wait(randomfloatrange(0.3, 0.6));
      chunk zm_utility::play_sound_on_ent("break_barrier_piece");
    }
  }
}

function zombie_boardtear_audio_plus_fx_offset_repair_verticle(chunk) {
  if(isDefined(chunk.material) && chunk.material == "rock") {
    if(isDefined(level.use_clientside_rock_tearin_fx) && level.use_clientside_rock_tearin_fx) {
      chunk clientfield::set("tearin_rock_fx", 0);
    } else {
      earthquake(randomfloatrange(0.3, 0.4), randomfloatrange(0.2, 0.4), chunk.origin, 150);
      wait(randomfloatrange(0.3, 0.6));
      chunk zm_utility::play_sound_on_ent("break_barrier_piece");
    }
  } else {
    if(isDefined(level.use_clientside_board_fx) && level.use_clientside_board_fx) {
      chunk clientfield::set("tearin_board_horizontal_fx", 0);
    } else {
      earthquake(randomfloatrange(0.3, 0.4), randomfloatrange(0.2, 0.4), chunk.origin, 150);
      wait(randomfloatrange(0.3, 0.6));
      chunk zm_utility::play_sound_on_ent("break_barrier_piece");
    }
  }
}

function zombie_gratetear_audio_plus_fx_offset_repair_horizontal(chunk) {
  earthquake(randomfloatrange(0.3, 0.4), randomfloatrange(0.2, 0.4), chunk.origin, 150);
  chunk zm_utility::play_sound_on_ent("bar_rebuild_slam");
  switch (randomint(9)) {
    case 0: {
      playFX(level._effect["fx_zombie_bar_break"], chunk.origin + (vectorscale((-1, 0, 0), 30)));
      wait(randomfloatrange(0, 0.3));
      playFX(level._effect["fx_zombie_bar_break_lite"], chunk.origin + (vectorscale((-1, 0, 0), 30)));
      break;
    }
    case 1: {
      playFX(level._effect["fx_zombie_bar_break"], chunk.origin + (vectorscale((-1, 0, 0), 30)));
      wait(randomfloatrange(0, 0.3));
      playFX(level._effect["fx_zombie_bar_break"], chunk.origin + (vectorscale((-1, 0, 0), 30)));
      break;
    }
    case 2: {
      playFX(level._effect["fx_zombie_bar_break_lite"], chunk.origin + (vectorscale((-1, 0, 0), 30)));
      wait(randomfloatrange(0, 0.3));
      playFX(level._effect["fx_zombie_bar_break"], chunk.origin + (vectorscale((-1, 0, 0), 30)));
      break;
    }
    case 3: {
      playFX(level._effect["fx_zombie_bar_break"], chunk.origin + (vectorscale((-1, 0, 0), 30)));
      wait(randomfloatrange(0, 0.3));
      playFX(level._effect["fx_zombie_bar_break_lite"], chunk.origin + (vectorscale((-1, 0, 0), 30)));
      break;
    }
    case 4: {
      playFX(level._effect["fx_zombie_bar_break_lite"], chunk.origin + (vectorscale((-1, 0, 0), 30)));
      wait(randomfloatrange(0, 0.3));
      playFX(level._effect["fx_zombie_bar_break_lite"], chunk.origin + (vectorscale((-1, 0, 0), 30)));
      break;
    }
    case 5: {
      playFX(level._effect["fx_zombie_bar_break_lite"], chunk.origin + (vectorscale((-1, 0, 0), 30)));
      break;
    }
    case 6: {
      playFX(level._effect["fx_zombie_bar_break_lite"], chunk.origin + (vectorscale((-1, 0, 0), 30)));
      break;
    }
    case 7: {
      playFX(level._effect["fx_zombie_bar_break"], chunk.origin + (vectorscale((-1, 0, 0), 30)));
      break;
    }
    case 8: {
      playFX(level._effect["fx_zombie_bar_break"], chunk.origin + (vectorscale((-1, 0, 0), 30)));
      break;
    }
  }
}

function zombie_bartear_audio_plus_fx_offset_repair_horizontal(chunk) {
  earthquake(randomfloatrange(0.3, 0.4), randomfloatrange(0.2, 0.4), chunk.origin, 150);
  chunk zm_utility::play_sound_on_ent("bar_rebuild_slam");
  switch (randomint(9)) {
    case 0: {
      playFXOnTag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_left");
      wait(randomfloatrange(0, 0.3));
      playFXOnTag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_right");
      break;
    }
    case 1: {
      playFXOnTag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_left");
      wait(randomfloatrange(0, 0.3));
      playFXOnTag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_right");
      break;
    }
    case 2: {
      playFXOnTag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_left");
      wait(randomfloatrange(0, 0.3));
      playFXOnTag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_right");
      break;
    }
    case 3: {
      playFXOnTag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_left");
      wait(randomfloatrange(0, 0.3));
      playFXOnTag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_right");
      break;
    }
    case 4: {
      playFXOnTag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_left");
      wait(randomfloatrange(0, 0.3));
      playFXOnTag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_right");
      break;
    }
    case 5: {
      playFXOnTag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_left");
      break;
    }
    case 6: {
      playFXOnTag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_right");
      break;
    }
    case 7: {
      playFXOnTag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_left");
      break;
    }
    case 8: {
      playFXOnTag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_right");
      break;
    }
  }
}

function zombie_bartear_audio_plus_fx_offset_repair_verticle(chunk) {
  earthquake(randomfloatrange(0.3, 0.4), randomfloatrange(0.2, 0.4), chunk.origin, 150);
  chunk zm_utility::play_sound_on_ent("bar_rebuild_slam");
  switch (randomint(9)) {
    case 0: {
      playFXOnTag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_top");
      wait(randomfloatrange(0, 0.3));
      playFXOnTag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_bottom");
      break;
    }
    case 1: {
      playFXOnTag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_top");
      wait(randomfloatrange(0, 0.3));
      playFXOnTag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_bottom");
      break;
    }
    case 2: {
      playFXOnTag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_top");
      wait(randomfloatrange(0, 0.3));
      playFXOnTag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_bottom");
      break;
    }
    case 3: {
      playFXOnTag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_top");
      wait(randomfloatrange(0, 0.3));
      playFXOnTag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_bottom");
      break;
    }
    case 4: {
      playFXOnTag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_top");
      wait(randomfloatrange(0, 0.3));
      playFXOnTag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_bottom");
      break;
    }
    case 5: {
      playFXOnTag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_top");
      break;
    }
    case 6: {
      playFXOnTag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_bottom");
      break;
    }
    case 7: {
      playFXOnTag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_top");
      break;
    }
    case 8: {
      playFXOnTag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_bottom");
      break;
    }
  }
}

function flag_blocker() {
  if(!isDefined(self.script_flag_wait)) {
    assertmsg(("" + self.origin) + "");
    return;
  }
  if(!isDefined(level.flag[self.script_flag_wait])) {
    level flag::init(self.script_flag_wait);
  }
  type = "connectpaths";
  if(isDefined(self.script_noteworthy)) {
    type = self.script_noteworthy;
  }
  level flag::wait_till(self.script_flag_wait);
  self util::script_delay();
  if(type == "connectpaths") {
    self connectpaths();
    self triggerenable(0);
    return;
  }
  if(type == "disconnectpaths") {
    self disconnectpaths();
    self triggerenable(0);
    return;
  }
  assertmsg(((("" + self.origin) + "") + type) + "");
}

function update_states(states) {
  assert(isDefined(states));
  self.state = states;
}

function quantum_bomb_open_nearest_door_validation(position) {
  range_squared = 32400;
  zombie_doors = getEntArray("zombie_door", "targetname");
  for(i = 0; i < zombie_doors.size; i++) {
    if(distancesquared(zombie_doors[i].origin, position) < range_squared) {
      return true;
    }
  }
  zombie_airlock_doors = getEntArray("zombie_airlock_buy", "targetname");
  for(i = 0; i < zombie_airlock_doors.size; i++) {
    if(distancesquared(zombie_airlock_doors[i].origin, position) < range_squared) {
      return true;
    }
  }
  zombie_debris = getEntArray("zombie_debris", "targetname");
  for(i = 0; i < zombie_debris.size; i++) {
    if(distancesquared(zombie_debris[i].origin, position) < range_squared) {
      return true;
    }
  }
  return false;
}

function quantum_bomb_open_nearest_door_result(position) {
  range_squared = 32400;
  zombie_doors = getEntArray("zombie_door", "targetname");
  for(i = 0; i < zombie_doors.size; i++) {
    if(distancesquared(zombie_doors[i].origin, position) < range_squared) {
      self thread zm_audio::create_and_play_dialog("kill", "quant_good");
      zombie_doors[i] notify("trigger", self, 1);
      [
        [level.quantum_bomb_play_area_effect_func]
      ](position);
      return;
    }
  }
  zombie_airlock_doors = getEntArray("zombie_airlock_buy", "targetname");
  for(i = 0; i < zombie_airlock_doors.size; i++) {
    if(distancesquared(zombie_airlock_doors[i].origin, position) < range_squared) {
      self thread zm_audio::create_and_play_dialog("kill", "quant_good");
      zombie_airlock_doors[i] notify("trigger", self, 1);
      [
        [level.quantum_bomb_play_area_effect_func]
      ](position);
      return;
    }
  }
  zombie_debris = getEntArray("zombie_debris", "targetname");
  for(i = 0; i < zombie_debris.size; i++) {
    if(distancesquared(zombie_debris[i].origin, position) < range_squared) {
      self thread zm_audio::create_and_play_dialog("kill", "quant_good");
      zombie_debris[i] notify("trigger", self, 1);
      [
        [level.quantum_bomb_play_area_effect_func]
      ](position);
      return;
    }
  }
}
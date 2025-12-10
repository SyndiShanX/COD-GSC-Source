/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_temple_triggers.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_zm_score;
#using scripts\zm\zm_temple_ai_monkey;
#namespace zm_temple_triggers;

function main() {
  level thread init_code_triggers();
  level thread init_water_drop_triggers();
  level thread init_slow_trigger();
  level thread init_code_structs();
}

function init_code_triggers() {
  triggers = getEntArray("code_trigger", "targetname");
  array::thread_all(triggers, &trigger_code);
}

function trigger_code() {
  code = self.script_noteworthy;
  if(!isDefined(code)) {
    code = "DPAD_UP DPAD_UP DPAD_DOWN DPAD_DOWN DPAD_LEFT DPAD_RIGHT DPAD_LEFT DPAD_RIGHT BUTTON_B BUTTON_A";
  }
  if(!isDefined(self.script_string)) {
    self.script_string = "cash";
  }
  self.players = [];
  while(true) {
    self waittill("trigger", who);
    if(is_in_array(self.players, who)) {
      continue;
    }
    who thread watch_for_code_touching_trigger(code, self);
  }
}

function watch_for_code_touching_trigger(code, trigger) {
  if(!isDefined(trigger.players)) {
    trigger.players = [];
  } else if(!isarray(trigger.players)) {
    trigger.players = array(trigger.players);
  }
  trigger.players[trigger.players.size] = self;
  self thread watch_for_code(code);
  self thread touching_trigger(trigger);
  returnnotify = self util::waittill_any_return("code_correct", "stopped_touching_trigger", "death");
  self notify("code_trigger_end");
  if(returnnotify == "code_correct") {
    trigger code_trigger_activated(self);
  } else {
    trigger.players = arrayremovevalue(trigger.players, self);
  }
}

function is_in_array(array, item) {
  foreach(index in array) {
    if(index == item) {
      return true;
    }
  }
  return false;
}

function array_remove(array, object) {
  if(!isDefined(array) && !isDefined(object)) {
    return;
  }
  new_array = [];
  foreach(item in array) {
    if(item != object) {
      if(!isDefined(new_array)) {
        new_array = [];
      } else if(!isarray(new_array)) {
        new_array = array(new_array);
      }
      new_array[new_array.size] = item;
    }
  }
  return new_array;
}

function array_removeundefined(array) {
  if(!isDefined(array)) {
    return;
  }
  new_array = [];
  foreach(item in array) {
    if(isDefined(item)) {
      if(!isDefined(new_array)) {
        new_array = [];
      } else if(!isarray(new_array)) {
        new_array = array(new_array);
      }
      new_array[new_array.size] = item;
    }
  }
  return new_array;
}

function code_trigger_activated(who) {
  switch (self.script_string) {
    case "cash": {
      who zm_score::add_to_player_score(100);
      break;
    }
    default: {}
  }
}

function touching_trigger(trigger) {
  self endon("code_trigger_end");
  while(self istouching(trigger)) {
    wait(0.1);
  }
  self notify("stopped_touching_trigger");
}

function watch_for_code(code) {
  self endon("code_trigger_end");
  codes = strtok(code, " ");
  while(true) {
    for(i = 0; i < codes.size; i++) {
      button = codes[i];
      if(!self button_pressed(button, 0.3)) {
        break;
      }
      if(!self button_not_pressed(button, 0.3)) {
        break;
      }
      if(i == (codes.size - 1)) {
        self notify("code_correct");
        return;
      }
    }
    wait(0.1);
  }
}

function button_not_pressed(button, time) {
  endtime = gettime() + (time * 1000);
  while(gettime() < endtime) {
    if(!self buttonpressed(button)) {
      return true;
    }
    wait(0.01);
  }
  return false;
}

function button_pressed(button, time) {
  endtime = gettime() + (time * 1000);
  while(gettime() < endtime) {
    if(self buttonpressed(button)) {
      return true;
    }
    wait(0.01);
  }
  return false;
}

function init_slow_trigger() {
  level flag::wait_till("initial_players_connected");
  slowtriggers = getEntArray("slow_trigger", "targetname");
  for(t = 0; t < slowtriggers.size; t++) {
    trig = slowtriggers[t];
    if(!isDefined(trig.script_float)) {
      trig.script_float = 0.5;
    }
    trig.inturp_time = 1;
    trig.inturp_rate = trig.script_float / trig.inturp_time;
    trig thread trigger_slow_touched_wait();
  }
}

function trigger_slow_touched_wait() {
  while(true) {
    self waittill("trigger", player);
    player notify("enter_slowtrigger");
    self trigger::function_d1278be0(player, &trigger_slow_ent, &trigger_unslow_ent);
    wait(0.1);
  }
}

function trigger_slow_ent(player, endon_condition) {
  player endon(endon_condition);
  if(isDefined(player)) {
    prevtime = gettime();
    while(player.movespeedscale > self.script_float) {
      wait(0.05);
      delta = gettime() - prevtime;
      player.movespeedscale = player.movespeedscale - ((delta / 1000) * self.inturp_rate);
      prevtime = gettime();
      player setmovespeedscale(player.movespeedscale);
    }
    player.movespeedscale = self.script_float;
    player allowjump(0);
    player allowsprint(0);
    player setmovespeedscale(self.script_float);
    player setvelocity((0, 0, 0));
  }
}

function trigger_unslow_ent(player) {
  player endon("enter_slowtrigger");
  if(isDefined(player)) {
    prevtime = gettime();
    while(player.movespeedscale < 1) {
      wait(0.05);
      delta = gettime() - prevtime;
      player.movespeedscale = player.movespeedscale + ((delta / 1000) * self.inturp_rate);
      prevtime = gettime();
      player setmovespeedscale(player.movespeedscale);
    }
    player.movespeedscale = 1;
    player allowjump(1);
    player allowsprint(1);
    player setmovespeedscale(1);
  }
}

function trigger_corpse() {
  if(!isDefined(self.script_string)) {
    self.script_string = "";
  }
  while(true) {
    box(self.origin, self.mins, self.maxs, 0, (1, 0, 0));
    corpses = getcorpsearray();
    for(i = 0; i < corpses.size; i++) {
      corpse = corpses[i];
      box(corpse.orign, corpse.mins, corpse.maxs, 0, (1, 1, 0));
      if(corpse istouching(self)) {
        self trigger_corpse_activated();
        return;
      }
    }
    wait(0.3);
  }
}

function trigger_corpse_activated() {
  iprintlnbold("Corpse Trigger Activated");
}

function init_water_drop_triggers() {
  triggers = getEntArray("water_drop_trigger", "script_noteworthy");
  for(i = 0; i < triggers.size; i++) {
    trig = triggers[i];
    trig.water_drop_time = 0.5;
    trig.waterdrops = 1;
    trig.watersheeting = 1;
    if(isDefined(trig.script_string)) {
      if(trig.script_string == "sheetingonly") {
        trig.waterdrops = 0;
      } else if(trig.script_string == "dropsonly") {
        trig.watersheeting = 0;
      }
    }
    trig thread water_drop_trigger_think();
  }
}

function water_drop_trigger_think() {
  level flag::wait_till("initial_players_connected");
  wait(1);
  if(isDefined(self.script_flag)) {
    level flag::wait_till(self.script_flag);
  }
  if(isDefined(self.script_float)) {
    wait(self.script_float);
  }
  while(true) {
    self waittill("trigger", who);
    if(isplayer(who)) {
      self trigger::function_d1278be0(who, &water_drop_trig_entered, &water_drop_trig_exit);
    } else if(isDefined(who.water_trigger_func)) {
      who thread[[who.water_trigger_func]](self);
    }
  }
}

function water_drop_trig_entered(player, endon_string) {
  if(isDefined(endon_string)) {
    player endon(endon_string);
  }
  player notify("water_drop_trig_enter");
  player endon("death");
  player endon("disconnect");
  player endon("spawned_spectator");
  if(player.sessionstate == "spectator") {
    return;
  }
  if(!isDefined(player.water_drop_ents)) {
    player.water_drop_ents = [];
  }
  if(isDefined(self.script_sound)) {
    player playSound(self.script_sound);
  }
  if(self.waterdrops) {
    if(!isDefined(player.water_drop_ents)) {
      player.water_drop_ents = [];
    } else if(!isarray(player.water_drop_ents)) {
      player.water_drop_ents = array(player.water_drop_ents);
    }
    player.water_drop_ents[player.water_drop_ents.size] = self;
    if(!self.watersheeting) {
      player setwaterdrops(player player_get_num_water_drops());
    }
  }
  if(self.watersheeting) {
    self thread function_4dedd2e(player);
  }
}

function function_4dedd2e(player) {
  player notify("water_drop_trig_enter");
  player endon("death");
  player endon("disconnect");
  player endon("spawned_spectator");
  player endon("irt");
  player clientfield::set_to_player("floorrumble", 1);
  player thread intermission_rumble_clean_up();
  visionset_mgr::activate("overlay", "zm_waterfall_postfx", player);
}

function water_drop_trig_exit(player) {
  if(!isDefined(player.water_drop_ents)) {
    player.water_drop_ents = [];
  }
  if(self.waterdrops) {
    if(self.watersheeting) {
      player notify("irt");
      player clientfield::set_to_player("floorrumble", 0);
      player setwaterdrops(player player_get_num_water_drops());
      visionset_mgr::deactivate("overlay", "zm_waterfall_postfx", player);
    }
    player.water_drop_ents = array_remove(player.water_drop_ents, self);
    if(player.water_drop_ents.size == 0) {
      player water_drop_remove(0);
    } else {
      player setwaterdrops(player player_get_num_water_drops());
    }
  }
}

function water_drop_remove(delay) {
  self endon("death");
  self endon("disconnect");
  self endon("water_drop_trig_enter");
  wait(delay);
  self setwaterdrops(0);
}

function player_get_num_water_drops() {
  if(self.water_drop_ents.size > 0) {
    return 50;
  }
  return 0;
}

function init_code_structs() {
  structs = struct::get_array("code_struct", "targetname");
  array::thread_all(structs, &structs_code);
}

function structs_code() {
  code = self.script_noteworthy;
  if(!isDefined(code)) {
    code = "DPAD_UP DPAD_DOWN DPAD_LEFT DPAD_RIGHT BUTTON_B BUTTON_A";
  }
  self.codes = strtok(code, " ");
  if(!isDefined(self.script_string)) {
    self.script_string = "cash";
  }
  self.reward = self.script_string;
  if(!isDefined(self.radius)) {
    self.radius = 32;
  }
  self.radiussq = self.radius * self.radius;
  playersinradius = [];
  while(true) {
    players = getplayers();
    for(i = playersinradius.size - 1; i >= 0; i--) {
      player = playersinradius[i];
      if(!self is_player_in_radius(player)) {
        if(isDefined(player)) {
          playersinradius = array_remove(playersinradius, player);
          self notify("end_code_struct");
        } else {
          playersinradius = array_removeundefined(playersinradius);
        }
      }
      players = array_remove(players, player);
    }
    for(i = 0; i < players.size; i++) {
      player = players[i];
      if(self is_player_in_radius(player)) {
        self thread code_entry(player);
        playersinradius[playersinradius.size] = player;
      }
    }
    wait(0.5);
  }
}

function code_entry(player) {
  self endon("end_code_struct");
  player endon("death");
  player endon("disconnect");
  while(true) {
    for(i = 0; i < self.codes.size; i++) {
      button = self.codes[i];
      if(!player button_pressed(button, 0.3)) {
        break;
      }
      if(!player button_not_pressed(button, 0.3)) {
        break;
      }
      if(i == (self.codes.size - 1)) {
        self code_reward(player);
        return;
      }
    }
    wait(0.1);
  }
}

function code_reward(player) {
  switch (self.reward) {
    case "cash": {
      player zm_score::add_to_player_score(100);
      break;
    }
    case "mb": {
      zm_temple_ai_monkey::monkey_ambient_gib_all();
      break;
    }
    default: {}
  }
}

function is_player_in_radius(player) {
  if(!zombie_utility::is_player_valid(player)) {
    return false;
  }
  if((abs(self.origin[2] - player.origin[2])) > 30) {
    return false;
  }
  if(distance2dsquared(self.origin, player.origin) > self.radiussq) {
    return false;
  }
  return true;
}

function intermission_rumble_clean_up() {
  self endon("irt");
  level waittill("intermission");
  self clientfield::set_to_player("floorrumble", 0);
}
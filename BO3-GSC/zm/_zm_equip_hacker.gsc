/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_equip_hacker.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_utility;
#namespace zm_equip_hacker;

function autoexec __init__sytem__() {
  system::register("zm_equip_hacker", & __init__, & __main__, undefined);
}

function __init__() {
  zm_equipment::register("equip_hacker", & "ZOMBIE_EQUIP_HACKER_PICKUP_HINT_STRING", & "ZOMBIE_EQUIP_HACKER_HOWTO", undefined, "hacker");
  level._hackable_objects = [];
  level._pooled_hackable_objects = [];
  callback::on_connect( & hacker_on_player_connect);
  callback::on_spawned( & function_fa12cef4);
  level thread hack_trigger_think();
  level thread hacker_trigger_pool_think();
  level thread hacker_round_reward();
  if(getdvarint("scr_debug_hacker") == 1) {
    level thread hacker_debug();
  }
  level.var_bbd4901d = getweapon("equip_hacker");
}

function __main__() {
  zm_equipment::register_for_level("equip_hacker");
  zm_equipment::include("equip_hacker");
}

function function_fa12cef4() {
  self thread function_b743c597();
  self thread function_778301bd();
}

function hacker_round_reward() {
  while (true) {
    level waittill("end_of_round");
    if(!isdefined(level._from_nml)) {
      players = getplayers();
      for (i = 0; i < players.size; i++) {
        if(isdefined(players[i] zm_equipment::get_player_equipment()) && players[i] zm_equipment::get_player_equipment() == level.var_bbd4901d) {
          if(isdefined(players[i].equipment_got_in_round[level.var_bbd4901d])) {
            got_in_round = players[i].equipment_got_in_round[level.var_bbd4901d];
            rounds_kept = level.round_number - got_in_round;
            rounds_kept = rounds_kept - 1;
            if(rounds_kept > 0) {
              rounds_kept = min(rounds_kept, 5);
              score = rounds_kept * 500;
              players[i] zm_score::add_to_player_score(int(score));
            }
          }
        }
      }
    } else {
      level._from_nml = undefined;
    }
  }
}

function hacker_debug() {
  while (true) {
    for (i = 0; i < level._hackable_objects.size; i++) {
      hackable = level._hackable_objects[i];
      if(isdefined(hackable.pooled) && hackable.pooled) {
        if(isdefined(hackable._trigger)) {
          col = vectorscale((0, 1, 0), 255);
          if(isdefined(hackable.custom_debug_color)) {
            col = hackable.custom_debug_color;
          }
          print3d(hackable.origin, "", col, 1, 1);
        } else {
          print3d(hackable.origin, "", vectorscale((0, 0, 1), 255), 1, 1);
        }
        continue;
      }
      print3d(hackable.origin, "", vectorscale((1, 0, 0), 255), 1, 1);
    }
    wait(0.1);
  }
}

function hacker_trigger_pool_think() {
  if(!isdefined(level._zombie_hacker_trigger_pool_size)) {
    level._zombie_hacker_trigger_pool_size = 8;
  }
  pool_active = 0;
  level._hacker_pool = [];
  while (true) {
    if(pool_active) {
      if(!any_hackers_active()) {
        destroy_pooled_items();
      } else {
        sweep_pooled_items();
        add_eligable_pooled_items();
      }
    } else if(any_hackers_active()) {
      pool_active = 1;
    }
    wait(0.1);
  }
}

function destroy_pooled_items() {
  pool_active = 0;
  for (i = 0; i < level._hacker_pool.size; i++) {
    level._hacker_pool[i]._trigger delete();
    level._hacker_pool[i]._trigger = undefined;
  }
  level._hacker_pool = [];
}

function sweep_pooled_items() {
  new_hacker_pool = [];
  for (i = 0; i < level._hacker_pool.size; i++) {
    if(level._hacker_pool[i] should_pooled_object_exist()) {
      new_hacker_pool[new_hacker_pool.size] = level._hacker_pool[i];
      continue;
    }
    if(isdefined(level._hacker_pool[i]._trigger)) {
      level._hacker_pool[i]._trigger delete();
    }
    level._hacker_pool[i]._trigger = undefined;
  }
  level._hacker_pool = new_hacker_pool;
}

function should_pooled_object_exist() {
  players = getplayers();
  for (i = 0; i < players.size; i++) {
    if(players[i] zm_equipment::hacker_active()) {
      if(isdefined(self.entity)) {
        if(self.entity != players[i]) {
          if(distance2dsquared(players[i].origin, self.entity.origin) <= (self.radius * self.radius)) {
            return true;
          }
        }
        continue;
      }
      if(distance2dsquared(players[i].origin, self.origin) <= (self.radius * self.radius)) {
        return true;
      }
    }
  }
  return false;
}

function add_eligable_pooled_items() {
  candidates = [];
  for (i = 0; i < level._hackable_objects.size; i++) {
    hackable = level._hackable_objects[i];
    if(isdefined(hackable.pooled) && hackable.pooled && !isdefined(hackable._trigger)) {
      if(!isinarray(level._hacker_pool, hackable)) {
        if(hackable should_pooled_object_exist()) {
          candidates[candidates.size] = hackable;
        }
      }
    }
  }
  for (i = 0; i < candidates.size; i++) {
    candidate = candidates[i];
    height = 72;
    radius = 32;
    if(isdefined(candidate.radius)) {
      radius = candidate.radius;
    }
    if(isdefined(candidate.height)) {
      height = candidate.height;
    }
    trigger = spawn("trigger_radius_use", candidate.origin, 0, radius, height);
    trigger usetriggerrequirelookat();
    trigger triggerignoreteam();
    trigger setcursorhint("HINT_NOICON");
    trigger.radius = radius;
    trigger.height = height;
    trigger.beinghacked = 0;
    candidate._trigger = trigger;
    level._hacker_pool[level._hacker_pool.size] = candidate;
  }
}

function get_hackable_trigger() {
  if(isdefined(self.door)) {
    return self.door;
  }
  if(isdefined(self.perk)) {
    return self.perk;
  }
  if(isdefined(self.window)) {
    return self.window.unitrigger_stub.trigger;
  }
  if(isdefined(self.classname) && getsubstr(self.classname, 0, 7) == "trigger_") {
    return self;
  }
}

function any_hackers_active() {
  players = getplayers();
  for (i = 0; i < players.size; i++) {
    if(players[i] zm_equipment::hacker_active()) {
      return true;
    }
  }
  return false;
}

function register_hackable(name, callback_func, qualifier_func) {
  structs = struct::get_array(name, "script_noteworthy");
  if(!isdefined(structs)) {
    println(("" + name) + "");
    return;
  }
  for (i = 0; i < structs.size; i++) {
    if(!isinarray(level._hackable_objects, structs[i])) {
      structs[i]._hack_callback_func = callback_func;
      structs[i]._hack_qualifier_func = qualifier_func;
      structs[i].pooled = level._hacker_pooled;
      if(isdefined(structs[i].targetname)) {
        structs[i].hacker_target = getent(structs[i].targetname, "targetname");
      }
      level._hackable_objects[level._hackable_objects.size] = structs[i];
      if(isdefined(level._hacker_pooled)) {
        level._pooled_hackable_objects[level._pooled_hackable_objects.size] = structs[i];
      }
      structs[i] thread hackable_object_thread();
      util::wait_network_frame();
    }
  }
}

function register_hackable_struct(struct, callback_func, qualifier_func) {
  if(!isinarray(level._hackable_objects, struct)) {
    struct._hack_callback_func = callback_func;
    struct._hack_qualifier_func = qualifier_func;
    struct.pooled = level._hacker_pooled;
    if(isdefined(struct.targetname)) {
      struct.hacker_target = getent(struct.targetname, "targetname");
    }
    level._hackable_objects[level._hackable_objects.size] = struct;
    if(isdefined(level._hacker_pooled)) {
      level._pooled_hackable_objects[level._pooled_hackable_objects.size] = struct;
    }
    struct thread hackable_object_thread();
  }
}

function register_pooled_hackable_struct(struct, callback_func, qualifier_func) {
  level._hacker_pooled = 1;
  register_hackable_struct(struct, callback_func, qualifier_func);
  level._hacker_pooled = undefined;
}

function register_pooled_hackable(name, callback_func, qualifier_func) {
  level._hacker_pooled = 1;
  register_hackable(name, callback_func, qualifier_func);
  level._hacker_pooled = undefined;
}

function deregister_hackable_struct(struct) {
  if(isinarray(level._hackable_objects, struct)) {
    new_list = [];
    for (i = 0; i < level._hackable_objects.size; i++) {
      if(level._hackable_objects[i] != struct) {
        new_list[new_list.size] = level._hackable_objects[i];
        continue;
      }
      level._hackable_objects[i] notify("hackable_deregistered");
      if(isdefined(level._hackable_objects[i]._trigger)) {
        level._hackable_objects[i]._trigger delete();
      }
      if(isdefined(level._hackable_objects[i].pooled) && level._hackable_objects[i].pooled) {
        arrayremovevalue(level._hacker_pool, level._hackable_objects[i]);
        arrayremovevalue(level._pooled_hackable_objects, level._hackable_objects[i]);
      }
    }
    level._hackable_objects = new_list;
  }
}

function deregister_hackable(noteworthy) {
  new_list = [];
  for (i = 0; i < level._hackable_objects.size; i++) {
    if(!isdefined(level._hackable_objects[i].script_noteworthy) || level._hackable_objects[i].script_noteworthy != noteworthy) {
      new_list[new_list.size] = level._hackable_objects[i];
    } else {
      level._hackable_objects[i] notify("hackable_deregistered");
      if(isdefined(level._hackable_objects[i]._trigger)) {
        level._hackable_objects[i]._trigger delete();
      }
    }
    if(isdefined(level._hackable_objects[i].pooled) && level._hackable_objects[i].pooled) {
      arrayremovevalue(level._hacker_pool, level._hackable_objects[i]);
    }
  }
  level._hackable_objects = new_list;
}

function hack_trigger_think() {
  while (true) {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
      player = players[i];
      for (j = 0; j < level._hackable_objects.size; j++) {
        hackable = level._hackable_objects[j];
        if(isdefined(hackable._trigger)) {
          qualifier_passed = 1;
          if(isdefined(hackable._hack_qualifier_func)) {
            qualifier_passed = hackable[[hackable._hack_qualifier_func]](player);
          }
          if(player zm_equipment::hacker_active() && qualifier_passed && !hackable._trigger.beinghacked) {
            hackable._trigger setinvisibletoplayer(player, 0);
            continue;
          }
          hackable._trigger setinvisibletoplayer(player, 1);
        }
      }
    }
    wait(0.1);
  }
}

function is_facing(facee) {
  orientation = self getplayerangles();
  forwardvec = anglestoforward(orientation);
  forwardvec2d = (forwardvec[0], forwardvec[1], 0);
  unitforwardvec2d = vectornormalize(forwardvec2d);
  tofaceevec = facee.origin - self.origin;
  tofaceevec2d = (tofaceevec[0], tofaceevec[1], 0);
  unittofaceevec2d = vectornormalize(tofaceevec2d);
  dotproduct = vectordot(unitforwardvec2d, unittofaceevec2d);
  dot_limit = 0.8;
  if(isdefined(facee.dot_limit)) {
    dot_limit = facee.dot_limit;
  }
  return dotproduct > dot_limit;
}

function can_hack(hackable) {
  if(!isalive(self)) {
    return false;
  }
  if(self laststand::player_is_in_laststand()) {
    return false;
  }
  if(!self zm_equipment::hacker_active()) {
    return false;
  }
  if(!isdefined(hackable._trigger)) {
    return false;
  }
  if(isdefined(hackable.player)) {
    if(hackable.player != self) {
      return false;
    }
  }
  if(self throwbuttonpressed()) {
    return false;
  }
  if(self fragbuttonpressed()) {
    return false;
  }
  if(isdefined(hackable._hack_qualifier_func)) {
    if(!hackable[[hackable._hack_qualifier_func]](self)) {
      return false;
    }
  }
  if(!isinarray(level._hackable_objects, hackable)) {
    return false;
  }
  radsquared = 1024;
  if(isdefined(hackable.radius)) {
    radsquared = hackable.radius * hackable.radius;
  }
  origin = hackable.origin;
  if(isdefined(hackable.entity)) {
    origin = hackable.entity.origin;
  }
  if(distance2dsquared(self.origin, origin) > radsquared) {
    return false;
  }
  if(!isdefined(hackable.no_touch_check) && !self istouching(hackable._trigger)) {
    return false;
  }
  if(!self is_facing(hackable)) {
    return false;
  }
  if(!isdefined(hackable.no_sight_check) && !sighttracepassed(self.origin + vectorscale((0, 0, 1), 50), origin, 0, undefined)) {
    return false;
  }
  if(!isdefined(hackable.no_bullet_trace) && !bullettracepassed(self.origin + vectorscale((0, 0, 1), 50), origin, 0, undefined)) {
    return false;
  }
  return true;
}

function is_hacking(hackable) {
  return can_hack(hackable) && self usebuttonpressed();
}

function set_hack_hint_string() {
  if(isdefined(self._trigger)) {
    if(isdefined(self.custom_string)) {
      self._trigger sethintstring(self.custom_string);
    } else {
      if(!isdefined(self.script_int) || self.script_int <= 0) {
        self._trigger sethintstring(&"ZOMBIE_HACK_NO_COST");
      } else {
        self._trigger sethintstring(&"ZOMBIE_HACK", self.script_int);
      }
    }
  }
}

function tidy_on_deregister(hackable) {
  self endon("clean_up_tidy_up");
  hackable waittill("hackable_deregistered");
  if(isdefined(self.hackerprogressbar)) {
    self.hackerprogressbar hud::destroyelem();
  }
  if(isdefined(self.hackertexthud)) {
    self.hackertexthud destroy();
  }
}

function hacker_do_hack(hackable) {
  timer = 0;
  hacked = 0;
  hackable._trigger.beinghacked = 1;
  if(!isdefined(self.hackerprogressbar)) {
    self.hackerprogressbar = self hud::createprimaryprogressbar();
  }
  if(!isdefined(self.hackertexthud)) {
    self.hackertexthud = newclienthudelem(self);
  }
  hack_duration = hackable.script_float;
  if(self hasperk("specialty_fastreload")) {
    hack_duration = hack_duration * 0.66;
  }
  hack_duration = max(1.5, hack_duration);
  self thread tidy_on_deregister(hackable);
  self.hackerprogressbar hud::updatebar(0.01, 1 / hack_duration);
  self.hackertexthud.alignx = "center";
  self.hackertexthud.aligny = "middle";
  self.hackertexthud.horzalign = "center";
  self.hackertexthud.vertalign = "bottom";
  self.hackertexthud.y = -140;
  if(issplitscreen()) {
    self.hackertexthud.y = -134;
  }
  self.hackertexthud.foreground = 1;
  self.hackertexthud.font = "default";
  self.hackertexthud.fontscale = 1.8;
  self.hackertexthud.alpha = 1;
  self.hackertexthud.color = (1, 1, 1);
  self.hackertexthud settext(&"ZOMBIE_HACKING");
  self playloopsound("zmb_progress_bar", 0.5);
  while (self is_hacking(hackable)) {
    wait(0.05);
    timer = timer + 0.05;
    if(self laststand::player_is_in_laststand()) {
      break;
    }
    if(timer >= hack_duration) {
      hacked = 1;
      break;
    }
  }
  self stoploopsound(0.5);
  if(hacked) {
    self playsound("vox_mcomp_hack_success");
  } else {
    self playsound("vox_mcomp_hack_fail");
  }
  if(isdefined(self.hackerprogressbar)) {
    self.hackerprogressbar hud::destroyelem();
  }
  if(isdefined(self.hackertexthud)) {
    self.hackertexthud destroy();
  }
  hackable set_hack_hint_string();
  if(isdefined(hackable._trigger)) {
    hackable._trigger.beinghacked = 0;
  }
  self notify("clean_up_tidy_up");
  return hacked;
}

function lowreadywatcher(player) {
  player endon("disconnected");
  self endon("kill_lowreadywatcher");
  self waittill("hackable_deregistered");
  player setlowready(0);
}

function hackable_object_thread() {
  self endon("hackable_deregistered");
  height = 72;
  radius = 64;
  if(isdefined(self.radius)) {
    radius = self.radius;
  }
  if(isdefined(self.height)) {
    height = self.height;
  }
  if(!isdefined(self.pooled)) {
    trigger = spawn("trigger_radius_use", self.origin, 0, radius, height);
    trigger usetriggerrequirelookat();
    trigger setcursorhint("HINT_NOICON");
    trigger.radius = radius;
    trigger.height = height;
    trigger.beinghacked = 0;
    self._trigger = trigger;
  }
  cost = 0;
  if(isdefined(self.script_int)) {
    cost = self.script_int;
  }
  duration = 1;
  if(isdefined(self.script_float)) {
    duration = self.script_float;
  }
  while (true) {
    wait(0.1);
    if(!isdefined(self._trigger)) {
      continue;
    }
    players = getplayers();
    if(isdefined(self._trigger)) {
      if(isdefined(self.entity)) {
        self.origin = self.entity.origin;
        self._trigger.origin = self.entity.origin;
        if(isdefined(self.trigger_offset)) {
          self._trigger.origin = self._trigger.origin + self.trigger_offset;
        }
      }
    }
    for (i = 0; i < players.size; i++) {
      if(players[i] can_hack(self)) {
        self set_hack_hint_string();
        break;
      }
    }
    for (i = 0; i < players.size; i++) {
      hacker = players[i];
      if(!hacker is_hacking(self)) {
        continue;
      }
      if(hacker.score >= cost || cost <= 0) {
        hacker setlowready(1);
        self thread lowreadywatcher(hacker);
        hack_success = hacker hacker_do_hack(self);
        self notify("kill_lowreadywatcher");
        if(isdefined(hacker)) {
          hacker setlowready(0);
        }
        if(isdefined(hacker) && hack_success) {
          if(cost) {
            if(cost > 0) {
              hacker zm_score::minus_to_player_score(cost);
            } else {
              hacker zm_score::add_to_player_score(cost * -1, 1, "equip_hacker");
            }
          }
          hacker notify("successful_hack");
          if(isdefined(self._hack_callback_func)) {
            self thread[[self._hack_callback_func]](hacker);
          }
        }
        continue;
      }
      hacker zm_utility::play_sound_on_ent("no_purchase");
      hacker zm_audio::create_and_play_dialog("general", "no_money", 1);
    }
  }
}

function hacker_on_player_connect() {
  struct = spawnstruct();
  struct.origin = self.origin;
  struct.radius = 48;
  struct.height = 64;
  struct.script_float = 10;
  struct.script_int = 500;
  struct.entity = self;
  struct.trigger_offset = vectorscale((0, 0, 1), 48);
  register_pooled_hackable_struct(struct, & player_hack, & player_qualifier);
  struct thread player_hack_disconnect_watcher(self);
}

function player_hack_disconnect_watcher(player) {
  player waittill("disconnect");
  deregister_hackable_struct(self);
}

function function_b743c597() {
  self notify("hash_36caa6f");
  self endon("hash_36caa6f");
  self endon("disconnect");
  while (true) {
    self waittill("player_given", equipment);
    if(equipment == level.var_bbd4901d) {
      self clientfield::set_player_uimodel("hudItems.showDpadDown_HackTool", 1);
    }
  }
}

function function_778301bd() {
  self notify("hash_b90a8375");
  self endon("hash_b90a8375");
  self endon("disconnect");
  while (true) {
    self waittill("hash_e15d5390");
    self clientfield::set_player_uimodel("hudItems.showDpadDown_HackTool", 0);
  }
}

function player_hack(hacker) {
  if(isdefined(self.entity)) {
    self.entity zm_score::player_add_points("hacker_transfer", 500);
  }
  if(isdefined(hacker)) {
    hacker thread zm_audio::create_and_play_dialog("general", "hack_plr");
  }
}

function player_qualifier(player) {
  if(player == self.entity) {
    return false;
  }
  if(self.entity laststand::player_is_in_laststand()) {
    return false;
  }
  if(player laststand::player_is_in_laststand()) {
    return false;
  }
  if(isdefined(self.entity.sessionstate == "spectator") && self.entity.sessionstate == "spectator") {
    return false;
  }
  return true;
}

function hide_hint_when_hackers_active(custom_logic_func, custom_logic_func_param) {
  invis_to_any = 0;
  while (true) {
    if(isdefined(custom_logic_func)) {
      self[[custom_logic_func]](custom_logic_func_param);
    }
    if(any_hackers_active()) {
      players = getplayers();
      for (i = 0; i < players.size; i++) {
        if(players[i] zm_equipment::hacker_active()) {
          self setinvisibletoplayer(players[i], 1);
          invis_to_any = 1;
          continue;
        }
        self setinvisibletoplayer(players[i], 0);
      }
    } else if(invis_to_any) {
      invis_to_any = 0;
      players = getplayers();
      for (i = 0; i < players.size; i++) {
        self setinvisibletoplayer(players[i], 0);
      }
    }
    wait(0.1);
  }
}

function hacker_debug_print(msg, color) {
  if(!getdvarint("")) {
    return;
  }
  if(!isdefined(color)) {
    color = (1, 1, 1);
  }
  print3d(self.origin + vectorscale((0, 0, 1), 60), msg, color, 1, 1, 40);
}
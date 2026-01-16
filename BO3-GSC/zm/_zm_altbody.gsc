/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_altbody.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace zm_altbody;

function autoexec __init__sytem__() {
  system::register("zm_altbody", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("clientuimodel", "player_lives", 1, 2, "int");
  clientfield::register("toplayer", "player_in_afterlife", 1, 1, "int");
  clientfield::register("clientuimodel", "player_mana", 1, 8, "float");
  clientfield::register("allplayers", "player_altbody", 1, 1, "int");
}

function init(name, kiosk_name, trigger_hint, visionset_name, visionset_priority, loadout, character_index, enter_callback, exit_callback, allow_callback, notrigger_hint, var_1982079a) {
  if(!isdefined(level.altbody_enter_callbacks)) {
    level.altbody_enter_callbacks = [];
  }
  if(!isdefined(level.altbody_exit_callbacks)) {
    level.altbody_exit_callbacks = [];
  }
  if(!isdefined(level.altbody_allow_callbacks)) {
    level.altbody_allow_callbacks = [];
  }
  if(!isdefined(level.altbody_loadouts)) {
    level.altbody_loadouts = [];
  }
  if(!isdefined(level.altbody_visionsets)) {
    level.altbody_visionsets = [];
  }
  if(!isdefined(level.altbody_charindexes)) {
    level.altbody_charindexes = [];
  }
  if(isdefined(visionset_name)) {
    level.altbody_visionsets[name] = visionset_name;
    visionset_mgr::register_info("visionset", visionset_name, 1, visionset_priority, 1, 1);
  }
  function_b32967de(name, kiosk_name, trigger_hint, notrigger_hint);
  level.altbody_enter_callbacks[name] = enter_callback;
  level.altbody_exit_callbacks[name] = exit_callback;
  level.altbody_allow_callbacks[name] = allow_callback;
  level.altbody_loadouts[name] = loadout;
  level.altbody_charindexes[name] = character_index;
  level.var_ba1ef2b1[name] = var_1982079a;
  level thread function_a2c7acf5();
}

function function_a2c7acf5() {
  level waittill("end_game");
  players = getplayers();
  for (i = 0; i < players.size; i++) {
    players[i] notify("altbody_end");
  }
}

function devgui_start_altbody(name) {
  self player_altbody(name);
}

function private function_3c17a460(trigger, name) {
  if(self.is_drinking > 0 && (!(isdefined(self.trigger_kiosks_in_altbody) && self.trigger_kiosks_in_altbody))) {
    return false;
  }
  if(self zm_utility::in_revive_trigger()) {
    return false;
  }
  if(self laststand::player_is_in_laststand()) {
    return false;
  }
  if(self isthrowinggrenade()) {
    return false;
  }
  if(self function_a27a52af(name)) {
    return false;
  }
  callback = level.altbody_allow_callbacks[name];
  if(isdefined(callback)) {
    if(!self[[callback]](name, trigger.kiosk)) {
      return false;
    }
  }
  return true;
}

function private player_can_altbody(kiosk, name) {
  if(isdefined(self.altbody) && self.altbody) {
    return false;
  }
  if(self.is_drinking > 0 && (!(isdefined(self.trigger_kiosks_in_altbody) && self.trigger_kiosks_in_altbody))) {
    return false;
  }
  if(self zm_utility::in_revive_trigger()) {
    return false;
  }
  if(self laststand::player_is_in_laststand()) {
    return false;
  }
  if(self isthrowinggrenade()) {
    return false;
  }
  if(self function_a27a52af(name)) {
    return false;
  }
  callback = level.altbody_allow_callbacks[name];
  if(isdefined(callback)) {
    if(!self[[callback]](name, kiosk)) {
      return false;
    }
  }
  return true;
}

function function_a27a52af(name) {
  foreach(str_bgb in level.var_ba1ef2b1[name]) {
    if(self bgb::is_enabled(str_bgb)) {
      return true;
    }
  }
  return false;
}

function private player_try_altbody(trigger, name) {
  self endon("disconnect");
  if(self player_can_altbody(trigger, name)) {
    level notify("kiosk_used", trigger.stub.kiosk);
    self player_altbody(name, trigger);
  }
}

function private player_altbody(name, trigger) {
  self.altbody = 1;
  self thread function_1f9554ce();
  self player_enter_altbody(name, trigger);
  self waittill("altbody_end");
  self player_exit_altbody(name, trigger);
  self.altbody = 0;
}

function private function_1f9554ce() {
  self endon("disconnect");
  was_inv = self enableinvulnerability();
  wait(1);
  if(isdefined(self) && (!(isdefined(was_inv) && was_inv))) {
    self disableinvulnerability();
  }
}

function get_altbody_weapon_limit(player) {
  return 16;
}

function private player_enter_altbody(name, trigger) {
  charindex = level.altbody_charindexes[name];
  self.var_b2356a6c = self.origin;
  self.var_227fe352 = self.angles;
  self setperk("specialty_playeriszombie");
  self thread function_72c3fae0(1);
  self setcharacterbodytype(charindex);
  self setcharacterbodystyle(0);
  self setcharacterhelmetstyle(0);
  clientfield::set_to_player("player_in_afterlife", 1);
  self player_apply_loadout(name);
  self thread player_apply_visionset(name);
  callback = level.altbody_enter_callbacks[name];
  if(isdefined(callback)) {
    self[[callback]](name, trigger);
  }
  clientfield::set("player_altbody", 1);
}

function private player_apply_visionset(name) {
  if(!isdefined(self.altbody_visionset)) {
    self.altbody_visionset = [];
  }
  visionset = level.altbody_visionsets[name];
  if(isdefined(visionset)) {
    if(isdefined(self.altbody_visionset[name]) && self.altbody_visionset[name]) {
      visionset_mgr::deactivate("visionset", visionset, self);
      util::wait_network_frame();
      util::wait_network_frame();
      if(!isdefined(self)) {
        return;
      }
    }
    visionset_mgr::activate("visionset", visionset, self);
    self.altbody_visionset[name] = 1;
  }
}

function private player_apply_loadout(name) {
  self bgb::suspend_weapon_cycling();
  loadout = level.altbody_loadouts[name];
  if(isdefined(loadout)) {
    self disableweaponcycling();
    assert(!isdefined(self.get_player_weapon_limit));
    self.get_player_weapon_limit = & get_altbody_weapon_limit;
    self.altbody_loadout[name] = zm_weapons::player_get_loadout();
    self zm_weapons::player_give_loadout(loadout, 0, 1);
    if(!isdefined(self.altbody_loadout_ever_had)) {
      self.altbody_loadout_ever_had = [];
    }
    if(isdefined(self.altbody_loadout_ever_had[name]) && self.altbody_loadout_ever_had[name]) {
      self seteverhadweaponall(1);
    }
    self.altbody_loadout_ever_had[name] = 1;
    self util::waittill_any_timeout(1, "weapon_change_complete");
    self resetanimations();
  }
}

function private player_exit_altbody(name, trigger) {
  clientfield::set("player_altbody", 0);
  clientfield::set_to_player("player_in_afterlife", 0);
  callback = level.altbody_exit_callbacks[name];
  if(isdefined(callback)) {
    self[[callback]](name, trigger);
  }
  if(!isdefined(self.altbody_visionset)) {
    self.altbody_visionset = [];
  }
  visionset = level.altbody_visionsets[name];
  if(isdefined(visionset)) {
    visionset_mgr::deactivate("visionset", visionset, self);
    self.altbody_visionset[name] = 0;
  }
  self thread player_restore_loadout(name);
  self unsetperk("specialty_playeriszombie");
  self detachall();
  self thread function_72c3fae0(0);
  self[[level.givecustomcharacters]]();
}

function private player_restore_loadout(name, trigger) {
  loadout = level.altbody_loadouts[name];
  if(isdefined(loadout)) {
    if(isdefined(self.altbody_loadout[name])) {
      self zm_weapons::switch_back_primary_weapon(self.altbody_loadout[name].current, 1);
      self.altbody_loadout[name] = undefined;
      self util::waittill_any_timeout(1, "weapon_change_complete");
    }
    self zm_weapons::player_take_loadout(loadout);
    assert(self.get_player_weapon_limit == ( & get_altbody_weapon_limit));
    self.get_player_weapon_limit = undefined;
    self resetanimations();
    self enableweaponcycling();
  }
  self bgb::resume_weapon_cycling();
}

function function_72c3fae0(washuman) {
  if(washuman) {
    playfx(level._effect["human_disappears"], self.origin);
  } else {
    playfx(level._effect["zombie_disappears"], self.origin);
    playsoundatposition("zmb_player_disapparate", self.origin);
    self playlocalsound("zmb_player_disapparate_2d");
  }
}

function function_b32967de(name, kiosk_name, trigger_hint, notrigger_hint) {
  if(!isdefined(level.altbody_kiosks)) {
    level.altbody_kiosks = [];
  }
  level.altbody_kiosks[name] = struct::get_array(kiosk_name, "targetname");
  foreach(kiosk in level.altbody_kiosks[name]) {
    function_9621c06b(kiosk, name, trigger_hint, notrigger_hint);
  }
  level notify("hash_725464dc", name);
}

function function_9621c06b(kiosk, name, trigger_hint, notrigger_hint) {
  width = 128;
  height = 128;
  length = 128;
  unitrigger_stub = spawnstruct();
  unitrigger_stub.origin = kiosk.origin + vectorscale((0, 0, 1), 32);
  unitrigger_stub.angles = kiosk.angles;
  unitrigger_stub.script_unitrigger_type = "unitrigger_radius_use";
  unitrigger_stub.cursor_hint = "HINT_NOICON";
  unitrigger_stub.radius = 64;
  unitrigger_stub.require_look_at = 0;
  unitrigger_stub.kiosk = kiosk;
  unitrigger_stub.altbody_name = name;
  unitrigger_stub.trigger_hint = trigger_hint;
  unitrigger_stub.notrigger_hint = notrigger_hint;
  unitrigger_stub.prompt_and_visibility_func = & kiosk_trigger_visibility;
  zm_unitrigger::register_static_unitrigger(unitrigger_stub, & kiosk_trigger_think);
}

function kiosk_trigger_visibility(player) {
  visible = !(isdefined(player.altbody) && player.altbody) || (isdefined(player.see_kiosks_in_altbody) && player.see_kiosks_in_altbody);
  self.stub.usable = player player_can_altbody(self.stub.kiosk, self.stub.altbody_name);
  if(self.stub.usable) {
    self.stub.hint_string = self.stub.trigger_hint;
  } else {
    self.stub.hint_string = self.stub.notrigger_hint;
  }
  self sethintstring(self.stub.hint_string);
  self setinvisibletoplayer(player, !visible);
  return visible;
}

function kiosk_trigger_think() {
  while (true) {
    self waittill("trigger", player);
    if(isdefined(self.stub.usable) && self.stub.usable) {
      self.stub.usable = 0;
      name = self.stub.altbody_name;
      if(isdefined(player.custom_altbody_callback)) {
        player thread[[player.custom_altbody_callback]](self, name);
      } else {
        player thread player_try_altbody(self, name);
      }
    }
  }
}

function private watch_kiosk_triggers(name, trigger_name, trigger_hint, whenvisible) {
  triggers = getentarray(trigger_name, "targetname");
  if(!triggers.size) {
    triggers = getentarray(trigger_name, "script_noteworthy");
  }
  array::thread_all(triggers, & trigger_watch_kiosk, name, trigger_name, trigger_hint, whenvisible);
}

function private trigger_watch_kiosk(name, trigger_name, trigger_hint, whenvisible) {
  self endon("death");
  self sethintstring(trigger_hint);
  self setcursorhint("HINT_NOICON");
  self setvisibletoall();
  self thread trigger_monitor_visibility(name, whenvisible);
  if(whenvisible) {
    if(isdefined(self.target)) {
      target = getent(self.target, "targetname");
      self.kiosk = target;
    }
    while (isdefined(self)) {
      self waittill("trigger", player);
      if(isdefined(player.custom_altbody_callback)) {
        player thread[[player.custom_altbody_callback]](self, name);
      } else {
        player thread player_try_altbody(self, name);
      }
    }
  }
}

function trigger_monitor_visibility(name, whenvisible) {
  self endon("death");
  self setinvisibletoall();
  level flagsys::wait_till("start_zombie_round_logic");
  self setvisibletoall();
  pid = 0;
  self.is_unlocked = 1;
  while (isdefined(self)) {
    players = level.players;
    if(pid >= players.size) {
      pid = 0;
    }
    player = players[pid];
    pid++;
    if(isdefined(player)) {
      visible = 1;
      visible = player player_can_altbody(self, name);
      if(visible == whenvisible && (!(isdefined(player.altbody) && player.altbody) || (isdefined(player.see_kiosks_in_altbody) && player.see_kiosks_in_altbody)) && (isdefined(self.is_unlocked) && self.is_unlocked)) {
        self setvisibletoplayer(player);
      } else {
        self setinvisibletoplayer(player);
      }
    }
    wait(randomfloatrange(0.2, 0.5));
  }
}
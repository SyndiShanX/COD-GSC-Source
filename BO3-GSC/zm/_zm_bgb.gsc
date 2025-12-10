/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_bgb.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\animation_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\demo_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_bgb_machine;
#using scripts\zm\_zm_bgb_token;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\gametypes\_globallogic_score;
#namespace bgb;

function autoexec __init__sytem__() {
  system::register("bgb", &__init__, &__main__, undefined);
}

function private __init__() {
  callback::on_spawned(&on_player_spawned);
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  level.weaponbgbgrab = getweapon("zombie_bgb_grab");
  level.weaponbgbuse = getweapon("zombie_bgb_use");
  level.bgb = [];
  clientfield::register("clientuimodel", "bgb_current", 1, 8, "int");
  clientfield::register("clientuimodel", "bgb_display", 1, 1, "int");
  clientfield::register("clientuimodel", "bgb_timer", 1, 8, "float");
  clientfield::register("clientuimodel", "bgb_activations_remaining", 1, 3, "int");
  clientfield::register("clientuimodel", "bgb_invalid_use", 1, 1, "counter");
  clientfield::register("clientuimodel", "bgb_one_shot_use", 1, 1, "counter");
  clientfield::register("toplayer", "bgb_blow_bubble", 1, 1, "counter");
  zm::register_vehicle_damage_callback(&vehicle_damage_override);
}

function private __main__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb_finalize();
  level thread setup_devgui();
  level._effect["samantha_steal"] = "zombie/fx_monkey_lightning_zmb";
}

function private on_player_spawned() {
  self.bgb = "none";
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  self function_52dbea8c();
  self thread bgb_player_init();
}

function private function_52dbea8c() {
  if(!(isDefined(self.var_c2d95bad) && self.var_c2d95bad)) {
    self.var_c2d95bad = 1;
    self globallogic_score::initpersstat("bgb_tokens_gained_this_game", 0);
    self.bgb_tokens_gained_this_game = 0;
  }
}

function private bgb_player_init() {
  if(isDefined(self.bgb_pack)) {
    return;
  }
  self.bgb_pack = self getbubblegumpack();
  self.bgb_pack_randomized = [];
  self.bgb_stats = [];
  foreach(bgb in self.bgb_pack) {
    if(bgb == "weapon_null") {
      continue;
    }
    if(!(isDefined(level.bgb[bgb].consumable) && level.bgb[bgb].consumable)) {
      continue;
    }
    self.bgb_stats[bgb] = spawnStruct();
    self.bgb_stats[bgb].var_e0b06b47 = self getbgbremaining(bgb);
    self.bgb_stats[bgb].bgb_used_this_game = 0;
  }
  self.bgb_machine_uses_this_round = 0;
  self clientfield::set_to_player("zm_bgb_machine_round_buys", self.bgb_machine_uses_this_round);
  self init_weapon_cycling();
  self thread bgb_player_monitor();
  self thread bgb_end_game();
}

function private bgb_end_game() {
  self endon("disconnect");
  if(!level flag::exists("consumables_reported")) {
    level flag::init("consumables_reported");
  }
  self flag::init("finished_reporting_consumables");
  self waittill("report_bgb_consumption");
  self thread take();
  self __protected__reportnotedloot();
  self zm_stats::set_global_stat("bgb_tokens_gained_this_game", self.bgb_tokens_gained_this_game);
  foreach(bgb in self.bgb_pack) {
    if(!isDefined(self.bgb_stats[bgb]) || !self.bgb_stats[bgb].bgb_used_this_game) {
      continue;
    }
    level flag::set("consumables_reported");
    zm_utility::increment_zm_dash_counter("end_consumables_count", self.bgb_stats[bgb].bgb_used_this_game);
    self reportlootconsume(bgb, self.bgb_stats[bgb].bgb_used_this_game);
  }
  self flag::set("finished_reporting_consumables");
}

function private bgb_finalize() {
  statstablename = util::getstatstablename();
  keys = getarraykeys(level.bgb);
  for(i = 0; i < keys.size; i++) {
    level.bgb[keys[i]].item_index = getitemindexfromref(keys[i]);
    level.bgb[keys[i]].rarity = int(tablelookup(statstablename, 0, level.bgb[keys[i]].item_index, 16));
    if(0 == level.bgb[keys[i]].rarity || 4 == level.bgb[keys[i]].rarity) {
      level.bgb[keys[i]].consumable = 0;
    } else {
      level.bgb[keys[i]].consumable = 1;
    }
    level.bgb[keys[i]].camo_index = int(tablelookup(statstablename, 0, level.bgb[keys[i]].item_index, 5));
    var_cf65a2c0 = tablelookup(statstablename, 0, level.bgb[keys[i]].item_index, 15);
    if(issubstr(var_cf65a2c0, "dlc")) {
      level.bgb[keys[i]].dlc_index = int(var_cf65a2c0[3]);
      continue;
    }
    level.bgb[keys[i]].dlc_index = 0;
  }
}

function private bgb_player_monitor() {
  self endon("disconnect");
  while(true) {
    str_return = level util::waittill_any_return("between_round_over", "restart_round");
    if(isDefined(level.var_4824bb2d)) {
      if(!(isDefined(self[[level.var_4824bb2d]]()) && self[[level.var_4824bb2d]]())) {
        continue;
      }
    }
    if(str_return === "restart_round") {
      level waittill("between_round_over");
    } else {
      self.bgb_machine_uses_this_round = 0;
      self clientfield::set_to_player("zm_bgb_machine_round_buys", self.bgb_machine_uses_this_round);
    }
  }
}

function private setup_devgui() {
  waittillframeend();
  setdvar("", "");
  setdvar("", -1);
  bgb_devgui_base = "";
  keys = getarraykeys(level.bgb);
  foreach(key in keys) {
    adddebugcommand((((((bgb_devgui_base + key) + "") + "") + "") + key) + "");
  }
  adddebugcommand(((((bgb_devgui_base + "") + "") + "") + "") + "");
  adddebugcommand(((((bgb_devgui_base + "") + "") + "") + "") + "");
  for(i = 0; i < 4; i++) {
    playernum = i + 1;
    adddebugcommand(((((((bgb_devgui_base + "") + playernum) + "") + "") + "") + i) + "");
  }
  level thread bgb_devgui_think();
}

function private bgb_devgui_think() {
  for(;;) {
    var_fe9a7d67 = getdvarstring("");
    if(var_fe9a7d67 != "") {
      bgb_devgui_acquire(var_fe9a7d67);
    }
    setdvar("", "");
    wait(0.5);
  }
}

function private bgb_devgui_acquire(bgb_name) {
  playerid = getdvarint("");
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    if(playerid != -1 && playerid != i) {
      continue;
    }
    if("" == bgb_name) {
      players[i] thread take();
      continue;
    }
    __protected__setbgbunlocked(1);
    players[i] thread bgb_gumball_anim(bgb_name, 0);
    __protected__setbgbunlocked(0);
  }
}

function private bgb_debug_text_display_init() {
  self.bgb_debug_text = newclienthudelem(self);
  self.bgb_debug_text.elemtype = "";
  self.bgb_debug_text.font = "";
  self.bgb_debug_text.fontscale = 1.8;
  self.bgb_debug_text.horzalign = "";
  self.bgb_debug_text.vertalign = "";
  self.bgb_debug_text.alignx = "";
  self.bgb_debug_text.aligny = "";
  self.bgb_debug_text.x = 15;
  self.bgb_debug_text.y = 35;
  self.bgb_debug_text.sort = 2;
  self.bgb_debug_text.color = (1, 1, 1);
  self.bgb_debug_text.alpha = 1;
  self.bgb_debug_text.hidewheninmenu = 1;
}

function private bgb_set_debug_text(name, activations_remaining) {
  if(!isDefined(self.bgb_debug_text)) {
    return;
  }
  if(isDefined(activations_remaining)) {
    self clientfield::set_player_uimodel("", 1);
  } else {
    self clientfield::set_player_uimodel("", 0);
  }
  self notify("bgb_set_debug_text_thread");
  self endon("bgb_set_debug_text_thread");
  self endon("disconnect");
  self.bgb_debug_text fadeovertime(0.05);
  self.bgb_debug_text.alpha = 1;
  prefix = "";
  short_name = name;
  if(issubstr(name, prefix)) {
    short_name = getsubstr(name, prefix.size);
  }
  if(isDefined(activations_remaining)) {
    self.bgb_debug_text settext(((("" + short_name) + "") + activations_remaining) + "");
  } else {
    self.bgb_debug_text settext("" + short_name);
  }
  wait(1);
  if("" == name) {
    self.bgb_debug_text fadeovertime(1);
    self.bgb_debug_text.alpha = 0;
  }
}

function bgb_print_stats(bgb) {
  printtoprightln((bgb + "") + self.bgb_stats[bgb].var_e0b06b47, (1, 1, 1));
  printtoprightln((bgb + "") + self.bgb_stats[bgb].bgb_used_this_game, (1, 1, 1));
  n_available = self.bgb_stats[bgb].var_e0b06b47 - self.bgb_stats[bgb].bgb_used_this_game;
  printtoprightln((bgb + "") + n_available, (1, 1, 1));
}

function private has_consumable_bgb(bgb) {
  if(!isDefined(self.bgb_stats[bgb]) || (!(isDefined(level.bgb[bgb].consumable) && level.bgb[bgb].consumable))) {
    return false;
  }
  return true;
}

function sub_consumable_bgb(bgb) {
  if(!has_consumable_bgb(bgb)) {
    return;
  }
  if(isDefined(level.bgb[bgb].var_35e23ba2) && ![[level.bgb[bgb].var_35e23ba2]]()) {
    return;
  }
  self.bgb_stats[bgb].bgb_used_this_game++;
  self flag::set("used_consumable");
  zm_utility::increment_zm_dash_counter("consumables_used", 1);
  if(level flag::exists("first_consumables_used")) {
    level flag::set("first_consumables_used");
  }
  self luinotifyevent(&"zombie_bgb_used", 1, level.bgb[bgb].item_index);
  bgb_print_stats(bgb);
}

function get_bgb_available(bgb) {
  if(!isDefined(self.bgb_stats[bgb])) {
    return 1;
  }
  var_3232aae6 = self.bgb_stats[bgb].var_e0b06b47;
  n_bgb_used_this_game = self.bgb_stats[bgb].bgb_used_this_game;
  n_bgb_remaining = var_3232aae6 - n_bgb_used_this_game;
  return 0 < n_bgb_remaining;
}

function private function_c3e0b2ba(bgb, activating) {
  if(!(isDefined(level.bgb[bgb].var_7ca0e2a7) && level.bgb[bgb].var_7ca0e2a7)) {
    return;
  }
  was_invulnerable = self enableinvulnerability();
  self util::waittill_any_timeout(2, "bgb_bubble_blow_complete");
  if(isDefined(self) && (!(isDefined(was_invulnerable) && was_invulnerable))) {
    self disableinvulnerability();
  }
}

function bgb_gumball_anim(bgb, activating) {
  self endon("disconnect");
  level endon("end_game");
  unlocked = __protected__getbgbunlocked();
  if(activating) {
    self thread function_c3e0b2ba(bgb);
    self thread zm_audio::create_and_play_dialog("bgb", "eat");
  }
  while(self isswitchingweapons()) {
    self waittill("weapon_change_complete");
  }
  gun = self bgb_play_gumball_anim_begin(bgb, activating);
  evt = self util::waittill_any_return("fake_death", "death", "player_downed", "weapon_change_complete", "disconnect");
  succeeded = 0;
  if(evt == "weapon_change_complete") {
    succeeded = 1;
    if(activating) {
      if(isDefined(level.bgb[bgb].var_7ea552f4) && level.bgb[bgb].var_7ea552f4 || self function_b616fe7a(1)) {
        self notify("hash_83da9d01", bgb);
        self activation_start();
        self thread run_activation_func(bgb);
      } else {
        succeeded = 0;
      }
    } else {
      if(!(isDefined(unlocked) && unlocked)) {
        return 0;
      }
      self notify("bgb_gumball_anim_give", bgb);
      self thread give(bgb);
      self zm_stats::increment_client_stat("bgbs_chewed");
      self zm_stats::increment_player_stat("bgbs_chewed");
      self zm_stats::increment_challenge_stat("GUM_GOBBLER_CONSUME");
      self adddstat("ItemStats", level.bgb[bgb].item_index, "stats", "used", "statValue", 1);
      health = 0;
      if(isDefined(self.health)) {
        health = self.health;
      }
      self recordmapevent(4, gettime(), self.origin, level.round_number, level.bgb[bgb].item_index, health);
      demo::bookmark("zm_player_bgb_grab", gettime(), self);
      if(sessionmodeisonlinegame()) {
        util::function_a4c90358("zm_bgb_consumed", 1);
      }
    }
  }
  self bgb_play_gumball_anim_end(gun, bgb, activating);
  return succeeded;
}

function private run_activation_func(bgb) {
  self endon("disconnect");
  self set_active(1);
  self do_one_shot_use();
  self notify("bgb_bubble_blow_complete");
  self[[level.bgb[bgb].activation_func]]();
  self set_active(0);
  self activation_complete();
}

function private bgb_get_gumball_anim_weapon(bgb, activating) {
  if(activating) {
    return level.weaponbgbuse;
  }
  return level.weaponbgbgrab;
}

function private bgb_play_gumball_anim_begin(bgb, activating) {
  self zm_utility::increment_is_drinking();
  self zm_utility::disable_player_move_states(1);
  w_original = self getcurrentweapon();
  weapon = bgb_get_gumball_anim_weapon(bgb, activating);
  self giveweapon(weapon, self calcweaponoptions(level.bgb[bgb].camo_index, 0, 0));
  self switchtoweapon(weapon);
  if(weapon == level.weaponbgbgrab) {
    self playSound("zmb_bgb_powerup_default");
  }
  if(weapon == level.weaponbgbuse) {
    self clientfield::increment_to_player("bgb_blow_bubble");
  }
  return w_original;
}

function private bgb_play_gumball_anim_end(w_original, bgb, activating) {
  assert(!w_original.isperkbottle);
  assert(w_original != level.weaponrevivetool);
  self zm_utility::enable_player_move_states();
  weapon = bgb_get_gumball_anim_weapon(bgb, activating);
  if(self laststand::player_is_in_laststand() || (isDefined(self.intermission) && self.intermission)) {
    self takeweapon(weapon);
    return;
  }
  self takeweapon(weapon);
  if(self zm_utility::is_multiple_drinking()) {
    self zm_utility::decrement_is_drinking();
    return;
  }
  if(w_original != level.weaponnone && !zm_utility::is_placeable_mine(w_original) && !zm_equipment::is_equipment_that_blocks_purchase(w_original)) {
    self zm_weapons::switch_back_primary_weapon(w_original);
    if(zm_utility::is_melee_weapon(w_original)) {
      self zm_utility::decrement_is_drinking();
      return;
    }
  } else {
    self zm_weapons::switch_back_primary_weapon();
  }
  self util::waittill_any_timeout(1, "weapon_change_complete");
  if(!self laststand::player_is_in_laststand() && (!(isDefined(self.intermission) && self.intermission))) {
    self zm_utility::decrement_is_drinking();
  }
}

function private bgb_clear_monitors_and_clientfields() {
  self notify("bgb_limit_monitor");
  self notify("bgb_activation_monitor");
  self clientfield::set_player_uimodel("bgb_display", 0);
  self clientfield::set_player_uimodel("bgb_activations_remaining", 0);
  self clear_timer();
}

function private bgb_limit_monitor() {
  self endon("disconnect");
  self endon("bgb_update");
  self notify("bgb_limit_monitor");
  self endon("bgb_limit_monitor");
  self clientfield::set_player_uimodel("bgb_display", 1);
  self thread function_5fc6d844(self.bgb);
  switch (level.bgb[self.bgb].limit_type) {
    case "activated": {
      self thread bgb_activation_monitor();
      for(i = level.bgb[self.bgb].limit; i > 0; i--) {
        level.bgb[self.bgb].var_32fa3cb7 = i;
        if(level.bgb[self.bgb].var_336ffc4e) {
          function_497386b0();
        } else {
          self set_timer(i, level.bgb[self.bgb].limit);
        }
        self clientfield::set_player_uimodel("bgb_activations_remaining", i);
        self thread bgb_set_debug_text(self.bgb, i);
        self waittill("bgb_activation");
        while(isDefined(self get_active()) && self get_active()) {
          wait(0.05);
        }
        self playsoundtoplayer("zmb_bgb_power_decrement", self);
      }
      level.bgb[self.bgb].var_32fa3cb7 = 0;
      self playsoundtoplayer("zmb_bgb_power_done_delayed", self);
      self set_timer(0, level.bgb[self.bgb].limit);
      while(isDefined(self.bgb_activation_in_progress) && self.bgb_activation_in_progress) {
        wait(0.05);
      }
      break;
    }
    case "time": {
      self thread bgb_set_debug_text(self.bgb);
      self thread run_timer(level.bgb[self.bgb].limit);
      wait(level.bgb[self.bgb].limit);
      self playsoundtoplayer("zmb_bgb_power_done", self);
      break;
    }
    case "rounds": {
      self thread bgb_set_debug_text(self.bgb);
      count = level.bgb[self.bgb].limit + 1;
      for(i = 0; i < count; i++) {
        self set_timer(count - i, count);
        level waittill("end_of_round");
        self playsoundtoplayer("zmb_bgb_power_decrement", self);
      }
      self playsoundtoplayer("zmb_bgb_power_done_delayed", self);
      break;
    }
    case "event": {
      self thread bgb_set_debug_text(self.bgb);
      self bgb_set_timer_clientfield(1);
      self[[level.bgb[self.bgb].limit]]();
      self playsoundtoplayer("zmb_bgb_power_done_delayed", self);
      break;
    }
    default: {
      assert(0, ((("" + self.bgb) + "") + level.bgb[self.bgb].limit_type) + "");
    }
  }
  self thread take();
}

function private bgb_bled_out_monitor() {
  self endon("disconnect");
  self endon("bgb_update");
  self notify("bgb_bled_out_monitor");
  self endon("bgb_bled_out_monitor");
  self waittill("bled_out");
  self notify("bgb_about_to_take_on_bled_out");
  wait(0.1);
  self thread take();
}

function private bgb_activation_monitor() {
  self endon("disconnect");
  self notify("bgb_activation_monitor");
  self endon("bgb_activation_monitor");
  if("activated" != level.bgb[self.bgb].limit_type) {
    return;
  }
  for(;;) {
    self waittill("bgb_activation_request");
    if(!self function_b616fe7a(0)) {
      continue;
    }
    if(self bgb_gumball_anim(self.bgb, 1)) {
      self notify("bgb_activation", self.bgb);
    }
  }
}

function private function_b616fe7a(var_5827b083 = 0) {
  var_bb1d9487 = isDefined(level.bgb[self.bgb].validation_func) && !self[[level.bgb[self.bgb].validation_func]]();
  var_847ec8da = isDefined(level.var_9cef605e) && !self[[level.var_9cef605e]]();
  if(!var_5827b083 && (isDefined(self.is_drinking) && self.is_drinking) || (isDefined(self.bgb_activation_in_progress) && self.bgb_activation_in_progress) || self laststand::player_is_in_laststand() || var_bb1d9487 || var_847ec8da) {
    self clientfield::increment_uimodel("bgb_invalid_use");
    self playlocalsound("zmb_bgb_deny_plr");
    return false;
  }
  return true;
}

function private function_5fc6d844(bgb) {
  self endon("disconnect");
  self endon("bled_out");
  self endon("bgb_update");
  if(isDefined(level.bgb[bgb].var_50fe45f6) && level.bgb[bgb].var_50fe45f6) {
    function_650ca64(6);
  } else {
    return;
  }
  self waittill("bgb_activation_request");
  self thread take();
}

function function_650ca64(n_value) {
  self setactionslot(1, "bgb");
  self clientfield::set_player_uimodel("bgb_activations_remaining", n_value);
}

function function_eabb0903(n_value) {
  self clientfield::set_player_uimodel("bgb_activations_remaining", 0);
}

function function_336ffc4e(name) {
  level.bgb[name].var_336ffc4e = 1;
}

function do_one_shot_use(skip_demo_bookmark = 0) {
  self clientfield::increment_uimodel("bgb_one_shot_use");
  if(!skip_demo_bookmark) {
    demo::bookmark("zm_player_bgb_activate", gettime(), self);
  }
}

function private activation_start() {
  self.bgb_activation_in_progress = 1;
}

function private activation_complete() {
  self.bgb_activation_in_progress = 0;
  self notify("activation_complete");
}

function private set_active(b_is_active) {
  self.bgb_active = b_is_active;
}

function get_active() {
  return isDefined(self.bgb_active) && self.bgb_active;
}

function is_active(name) {
  if(!isDefined(self.bgb)) {
    return 0;
  }
  return self.bgb == name && (isDefined(self.bgb_active) && self.bgb_active);
}

function is_team_active(name) {
  foreach(player in level.players) {
    if(player is_active(name)) {
      return true;
    }
  }
  return false;
}

function increment_ref_count(name) {
  if(!isDefined(level.bgb[name])) {
    return 0;
  }
  var_ad8303b0 = level.bgb[name].ref_count;
  level.bgb[name].ref_count++;
  return var_ad8303b0;
}

function decrement_ref_count(name) {
  if(!isDefined(level.bgb[name])) {
    return 0;
  }
  level.bgb[name].ref_count--;
  return level.bgb[name].ref_count;
}

function private calc_remaining_duration_lerp(start_time, end_time) {
  if(0 >= (end_time - start_time)) {
    return 0;
  }
  now = gettime();
  frac = (float(end_time - now)) / (float(end_time - start_time));
  return math::clamp(frac, 0, 1);
}

function private function_f9fad8b3(var_eeab9300, percent) {
  self endon("disconnect");
  self endon("hash_f9fad8b3");
  start_time = gettime();
  end_time = start_time + 1000;
  var_6d8b0ec7 = var_eeab9300;
  while(var_6d8b0ec7 > percent) {
    var_6d8b0ec7 = lerpfloat(percent, var_eeab9300, calc_remaining_duration_lerp(start_time, end_time));
    self clientfield::set_player_uimodel("bgb_timer", var_6d8b0ec7);
    wait(0.05);
  }
}

function private bgb_set_timer_clientfield(percent) {
  self notify("hash_f9fad8b3");
  var_eeab9300 = self clientfield::get_player_uimodel("bgb_timer");
  if(percent < var_eeab9300 && 0.1 <= (var_eeab9300 - percent)) {
    self thread function_f9fad8b3(var_eeab9300, percent);
  } else {
    self clientfield::set_player_uimodel("bgb_timer", percent);
  }
}

function private function_497386b0() {
  self bgb_set_timer_clientfield(1);
}

function set_timer(current, max) {
  self bgb_set_timer_clientfield(current / max);
}

function run_timer(max) {
  self endon("disconnect");
  self notify("bgb_run_timer");
  self endon("bgb_run_timer");
  current = max;
  while(current > 0) {
    self set_timer(current, max);
    wait(0.05);
    current = current - 0.05;
  }
  self clear_timer();
}

function clear_timer() {
  self bgb_set_timer_clientfield(0);
  self notify("bgb_run_timer");
}

function register(name, limit_type, limit, enable_func, disable_func, validation_func, activation_func) {
  assert(isDefined(name), "");
  assert("" != name, ("" + "") + "");
  assert(!isDefined(level.bgb[name]), ("" + name) + "");
  assert(isDefined(limit_type), ("" + name) + "");
  assert(isDefined(limit), ("" + name) + "");
  assert(!isDefined(enable_func) || isfunctionptr(enable_func), ("" + name) + "");
  assert(!isDefined(disable_func) || isfunctionptr(disable_func), ("" + name) + "");
  switch (limit_type) {
    case "activated": {
      assert(!isDefined(validation_func) || isfunctionptr(validation_func), ((("" + name) + "") + limit_type) + "");
      assert(isDefined(activation_func), ((("" + name) + "") + limit_type) + "");
      assert(isfunctionptr(activation_func), ((("" + name) + "") + limit_type) + "");
    }
    case "rounds":
    case "time": {
      assert(isint(limit), ((((("" + name) + "") + limit) + "") + limit_type) + "");
      break;
    }
    case "event": {
      assert(isfunctionptr(limit), ((("" + name) + "") + limit_type) + "");
      break;
    }
    default: {
      assert(0, ((("" + name) + "") + limit_type) + "");
    }
  }
  level.bgb[name] = spawnStruct();
  level.bgb[name].name = name;
  level.bgb[name].limit_type = limit_type;
  level.bgb[name].limit = limit;
  level.bgb[name].enable_func = enable_func;
  level.bgb[name].disable_func = disable_func;
  if("activated" == limit_type) {
    level.bgb[name].validation_func = validation_func;
    level.bgb[name].activation_func = activation_func;
    level.bgb[name].var_336ffc4e = 0;
  }
  level.bgb[name].ref_count = 0;
}

function register_actor_damage_override(name, actor_damage_override_func) {
  assert(isDefined(level.bgb[name]), ("" + name) + "");
  level.bgb[name].actor_damage_override_func = actor_damage_override_func;
}

function register_vehicle_damage_override(name, vehicle_damage_override_func) {
  assert(isDefined(level.bgb[name]), ("" + name) + "");
  level.bgb[name].vehicle_damage_override_func = vehicle_damage_override_func;
}

function register_actor_death_override(name, actor_death_override_func) {
  assert(isDefined(level.bgb[name]), ("" + name) + "");
  level.bgb[name].actor_death_override_func = actor_death_override_func;
}

function register_lost_perk_override(name, lost_perk_override_func, lost_perk_override_func_always_run) {
  assert(isDefined(level.bgb[name]), ("" + name) + "");
  level.bgb[name].lost_perk_override_func = lost_perk_override_func;
  level.bgb[name].lost_perk_override_func_always_run = lost_perk_override_func_always_run;
}

function function_ff4b2998(name, add_to_player_score_override_func, add_to_player_score_override_func_always_run) {
  assert(isDefined(level.bgb[name]), ("" + name) + "");
  level.bgb[name].add_to_player_score_override_func = add_to_player_score_override_func;
  level.bgb[name].add_to_player_score_override_func_always_run = add_to_player_score_override_func_always_run;
}

function function_4cda71bf(name, var_7ca0e2a7) {
  assert(isDefined(level.bgb[name]), ("" + name) + "");
  level.bgb[name].var_7ca0e2a7 = var_7ca0e2a7;
}

function function_93da425(name, var_35e23ba2) {
  assert(isDefined(level.bgb[name]), ("" + name) + "");
  level.bgb[name].var_35e23ba2 = var_35e23ba2;
}

function function_2060b89(name) {
  assert(isDefined(level.bgb[name]), ("" + name) + "");
  level.bgb[name].var_50fe45f6 = 1;
}

function function_f132da9c(name) {
  assert(isDefined(level.bgb[name]), ("" + name) + "");
  level.bgb[name].var_7ea552f4 = 1;
}

function function_d35f60a1(name) {
  unlocked = __protected__getbgbunlocked();
  if(unlocked) {
    self give(name);
  }
}

function give(name) {
  self thread take();
  if("none" == name) {
    return;
  }
  assert(isDefined(level.bgb[name]), ("" + name) + "");
  self notify("bgb_update", name, self.bgb);
  self notify("bgb_update_give_" + name);
  self.bgb = name;
  self clientfield::set_player_uimodel("bgb_current", level.bgb[name].item_index);
  self luinotifyevent(&"zombie_bgb_notification", 1, level.bgb[name].item_index);
  if(isDefined(level.bgb[name].enable_func)) {
    self thread[[level.bgb[name].enable_func]]();
  }
  if(isDefined("activated" == level.bgb[name].limit_type)) {
    self setactionslot(1, "bgb");
  }
  self thread bgb_limit_monitor();
  self thread bgb_bled_out_monitor();
}

function take() {
  if("none" == self.bgb) {
    return;
  }
  self setactionslot(1, "");
  self thread bgb_set_debug_text("none");
  if(isDefined(level.bgb[self.bgb].disable_func)) {
    self thread[[level.bgb[self.bgb].disable_func]]();
  }
  self bgb_clear_monitors_and_clientfields();
  self notify("bgb_update", "none", self.bgb);
  self notify("bgb_update_take_" + self.bgb);
  self.bgb = "none";
}

function get_enabled() {
  return self.bgb;
}

function is_enabled(name) {
  assert(isDefined(self.bgb));
  return self.bgb == name;
}

function any_enabled() {
  assert(isDefined(self.bgb));
  return self.bgb !== "none";
}

function is_team_enabled(str_name) {
  foreach(player in level.players) {
    assert(isDefined(player.bgb));
    if(player.bgb == str_name) {
      return true;
    }
  }
  return false;
}

function get_player_dropped_powerup_origin() {
  powerup_origin = (self.origin + vectorscale(anglesToForward((0, self getplayerangles()[1], 0)), 60)) + vectorscale((0, 0, 1), 5);
  self zm_stats::increment_challenge_stat("GUM_GOBBLER_POWERUPS");
  return powerup_origin;
}

function function_dea74fb0(str_powerup, v_origin = self get_player_dropped_powerup_origin()) {
  var_93eb638b = zm_powerups::specific_powerup_drop(str_powerup, v_origin);
  wait(1);
  if(isDefined(var_93eb638b) && (!var_93eb638b zm::in_enabled_playable_area() && !var_93eb638b zm::in_life_brush())) {
    level thread function_434235f9(var_93eb638b);
  }
}

function function_434235f9(var_93eb638b) {
  if(!isDefined(var_93eb638b)) {
    return;
  }
  var_93eb638b ghost();
  var_93eb638b.clone_model = util::spawn_model(var_93eb638b.model, var_93eb638b.origin, var_93eb638b.angles);
  var_93eb638b.clone_model linkto(var_93eb638b);
  direction = var_93eb638b.origin;
  direction = (direction[1], direction[0], 0);
  if(direction[1] < 0 || (direction[0] > 0 && direction[1] > 0)) {
    direction = (direction[0], direction[1] * -1, 0);
  } else if(direction[0] < 0) {
    direction = (direction[0] * -1, direction[1], 0);
  }
  if(!(isDefined(var_93eb638b.sndnosamlaugh) && var_93eb638b.sndnosamlaugh)) {
    players = getplayers();
    for(i = 0; i < players.size; i++) {
      if(isalive(players[i])) {
        players[i] playlocalsound(level.zmb_laugh_alias);
      }
    }
  }
  playFXOnTag(level._effect["samantha_steal"], var_93eb638b, "tag_origin");
  var_93eb638b.clone_model unlink();
  var_93eb638b.clone_model movez(60, 1, 0.25, 0.25);
  var_93eb638b.clone_model vibrate(direction, 1.5, 2.5, 1);
  var_93eb638b.clone_model waittill("movedone");
  if(isDefined(self.damagearea)) {
    self.damagearea delete();
  }
  var_93eb638b.clone_model delete();
  if(isDefined(var_93eb638b)) {
    if(isDefined(var_93eb638b.damagearea)) {
      var_93eb638b.damagearea delete();
    }
    var_93eb638b zm_powerups::powerup_delete();
  }
}

function actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return damage;
  }
  if(isplayer(attacker)) {
    name = attacker get_enabled();
    if(name !== "none" && isDefined(level.bgb[name]) && isDefined(level.bgb[name].actor_damage_override_func)) {
      damage = [
        [level.bgb[name].actor_damage_override_func]
      ](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
    }
  }
  return damage;
}

function vehicle_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return idamage;
  }
  if(isplayer(eattacker)) {
    name = eattacker get_enabled();
    if(name !== "none" && isDefined(level.bgb[name]) && isDefined(level.bgb[name].vehicle_damage_override_func)) {
      idamage = [
        [level.bgb[name].vehicle_damage_override_func]
      ](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
    }
  }
  return idamage;
}

function actor_death_override(attacker) {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return 0;
  }
  if(isplayer(attacker)) {
    name = attacker get_enabled();
    if(name !== "none" && isDefined(level.bgb[name]) && isDefined(level.bgb[name].actor_death_override_func)) {
      damage = [
        [level.bgb[name].actor_death_override_func]
      ](attacker);
    }
  }
  return damage;
}

function lost_perk_override(perk) {
  b_result = 0;
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return b_result;
  }
  if(!(isDefined(self.laststand) && self.laststand)) {
    return b_result;
  }
  keys = getarraykeys(level.bgb);
  for(i = 0; i < keys.size; i++) {
    name = keys[i];
    if(isDefined(level.bgb[name].lost_perk_override_func_always_run) && level.bgb[name].lost_perk_override_func_always_run && isDefined(level.bgb[name].lost_perk_override_func)) {
      b_result = [
        [level.bgb[name].lost_perk_override_func]
      ](perk, self, undefined);
      if(b_result) {
        return b_result;
      }
    }
  }
  foreach(player in level.activeplayers) {
    name = player get_enabled();
    if(name !== "none" && isDefined(level.bgb[name]) && isDefined(level.bgb[name].lost_perk_override_func)) {
      b_result = [
        [level.bgb[name].lost_perk_override_func]
      ](perk, self, player);
      if(b_result) {
        return b_result;
      }
    }
  }
  return b_result;
}

function add_to_player_score_override(n_points, str_awarded_by) {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return n_points;
  }
  str_enabled = self get_enabled();
  keys = getarraykeys(level.bgb);
  for(i = 0; i < keys.size; i++) {
    str_bgb = keys[i];
    if(str_bgb === str_enabled) {
      continue;
    }
    if(isDefined(level.bgb[str_bgb].add_to_player_score_override_func_always_run) && level.bgb[str_bgb].add_to_player_score_override_func_always_run && isDefined(level.bgb[str_bgb].add_to_player_score_override_func)) {
      n_points = [
        [level.bgb[str_bgb].add_to_player_score_override_func]
      ](n_points, str_awarded_by, 0);
    }
  }
  if(str_enabled !== "none" && isDefined(level.bgb[str_enabled]) && isDefined(level.bgb[str_enabled].add_to_player_score_override_func)) {
    n_points = [[level.bgb[str_enabled].add_to_player_score_override_func]](n_points, str_awarded_by, 1);
  }
  return n_points;
}

function function_d51db887() {
  keys = array::randomize(getarraykeys(level.bgb));
  for(i = 0; i < keys.size; i++) {
    if(level.bgb[keys[i]].rarity != 1) {
      continue;
    }
    if(level.bgb[keys[i]].dlc_index > 0) {
      continue;
    }
    return keys[i];
  }
}

function function_4ed517b9(n_max_distance, var_98a3e738, var_287a7adb) {
  self endon("disconnect");
  self endon("bled_out");
  self endon("bgb_update");
  self.var_6638f10b = [];
  while(true) {
    foreach(e_player in level.players) {
      if(e_player == self) {
        continue;
      }
      array::remove_undefined(self.var_6638f10b);
      var_368e2240 = array::contains(self.var_6638f10b, e_player);
      var_50fd5a04 = zm_utility::is_player_valid(e_player, 0, 1) && function_2469cfe8(n_max_distance, self, e_player);
      if(!var_368e2240 && var_50fd5a04) {
        array::add(self.var_6638f10b, e_player, 0);
        if(isDefined(var_98a3e738)) {
          self thread[[var_98a3e738]](e_player);
        }
        continue;
      }
      if(var_368e2240 && !var_50fd5a04) {
        arrayremovevalue(self.var_6638f10b, e_player);
        if(isDefined(var_287a7adb)) {
          self thread[[var_287a7adb]](e_player);
        }
      }
    }
    wait(0.05);
  }
}

function private function_2469cfe8(n_distance, var_d21815c4, var_441f84ff) {
  var_31dc18aa = n_distance * n_distance;
  var_2931dc75 = distancesquared(var_d21815c4.origin, var_441f84ff.origin);
  if(var_2931dc75 <= var_31dc18aa) {
    return true;
  }
  return false;
}

function function_ca189700() {
  self clientfield::increment_uimodel("bgb_invalid_use");
  self playlocalsound("zmb_bgb_deny_plr");
}

function suspend_weapon_cycling() {
  self flag::clear("bgb_weapon_cycling");
}

function resume_weapon_cycling() {
  self flag::set("bgb_weapon_cycling");
}

function init_weapon_cycling() {
  if(!self flag::exists("bgb_weapon_cycling")) {
    self flag::init("bgb_weapon_cycling");
  }
  self flag::set("bgb_weapon_cycling");
}

function function_378bff5d() {
  self flag::wait_till("bgb_weapon_cycling");
}

function revive_and_return_perk_on_bgb_activation(perk) {
  self notify("revive_and_return_perk_on_bgb_activation" + perk);
  self endon("revive_and_return_perk_on_bgb_activation" + perk);
  self endon("disconnect");
  self endon("bled_out");
  if(perk == "specialty_widowswine") {
    var_376ad33c = self getweaponammoclip(self.current_lethal_grenade);
  }
  self waittill("player_revived", e_reviver);
  if(isDefined(self.var_df0decf1) && self.var_df0decf1 || (isDefined(e_reviver) && (isDefined(self.bgb) && self is_enabled("zm_bgb_near_death_experience")) || (isDefined(e_reviver.bgb) && e_reviver is_enabled("zm_bgb_near_death_experience")))) {
    if(zm_perks::use_solo_revive() && perk == "specialty_quickrevive") {
      level.solo_game_free_player_quickrevive = 1;
    }
    wait(0.05);
    self thread zm_perks::give_perk(perk, 0);
    if(perk == "specialty_widowswine" && isDefined(var_376ad33c)) {
      self setweaponammoclip(self.current_lethal_grenade, var_376ad33c);
    }
  }
}

function bgb_revive_watcher() {
  self endon("disconnect");
  self endon("death");
  self.var_df0decf1 = 1;
  self waittill("player_revived", e_reviver);
  wait(0.05);
  if(isDefined(self.var_df0decf1) && self.var_df0decf1) {
    self notify("bgb_revive");
    self.var_df0decf1 = undefined;
  }
}
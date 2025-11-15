/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_perks.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\demo_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_bb;
#using scripts\zm\_util;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_magicbox;
#using scripts\zm\_zm_pers_upgrades_functions;
#using scripts\zm\_zm_power;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace zm_perks;

function init() {
  level.perk_purchase_limit = 4;
  perks_register_clientfield();
  if(!level.enable_magic) {
    return;
  }
  initialize_custom_perk_arrays();
  perk_machine_spawn_init();
  vending_weapon_upgrade_trigger = [];
  vending_triggers = getEntArray("zombie_vending", "targetname");
  if(vending_triggers.size < 1) {
    return;
  }
  level.machine_assets = [];
  if(!isDefined(level.custom_vending_precaching)) {
    level.custom_vending_precaching = & default_vending_precaching;
  }
  [[level.custom_vending_precaching]]();
  zombie_utility::set_zombie_var("zombie_perk_cost", 2000);
  array::thread_all(vending_triggers, & vending_trigger_think);
  array::thread_all(vending_triggers, & electric_perks_dialog);
  if(level._custom_perks.size > 0) {
    a_keys = getarraykeys(level._custom_perks);
    for(i = 0; i < a_keys.size; i++) {
      if(isDefined(level._custom_perks[a_keys[i]].perk_machine_thread)) {
        level thread[[level._custom_perks[a_keys[i]].perk_machine_thread]]();
      }
      if(isDefined(level._custom_perks[a_keys[i]].perk_machine_power_override_thread)) {
        level thread[[level._custom_perks[a_keys[i]].perk_machine_power_override_thread]]();
        continue;
      }
      if(isDefined(level._custom_perks[a_keys[i]].alias) && isDefined(level._custom_perks[a_keys[i]].radiant_machine_name) && isDefined(level._custom_perks[a_keys[i]].machine_light_effect)) {
        level thread perk_machine_think(a_keys[i], level._custom_perks[a_keys[i]]);
      }
    }
  }
  if(isDefined(level.quantum_bomb_register_result_func)) {
    [[level.quantum_bomb_register_result_func]]("give_nearest_perk", & quantum_bomb_give_nearest_perk_result, 10, & quantum_bomb_give_nearest_perk_validation);
  }
  level thread perk_hostmigration();
}

function perk_machine_think(str_key, s_custom_perk) {
  str_endon = str_key + "_power_thread_end";
  level endon(str_endon);
  str_on = s_custom_perk.alias + "_on";
  str_off = s_custom_perk.alias + "_off";
  str_notify = str_key + "_power_on";
  while(true) {
    machine = getEntArray(s_custom_perk.radiant_machine_name, "targetname");
    machine_triggers = getEntArray(s_custom_perk.radiant_machine_name, "target");
    for(i = 0; i < machine.size; i++) {
      machine[i] setModel(level.machine_assets[str_key].off_model);
      machine[i] solid();
    }
    level thread do_initial_power_off_callback(machine, str_key);
    array::thread_all(machine_triggers, & set_power_on, 0);
    level waittill(str_on);
    for(i = 0; i < machine.size; i++) {
      machine[i] setModel(level.machine_assets[str_key].on_model);
      machine[i] vibrate(vectorscale((0, -1, 0), 100), 0.3, 0.4, 3);
      machine[i] playSound("zmb_perks_power_on");
      machine[i] thread perk_fx(s_custom_perk.machine_light_effect);
      machine[i] thread play_loop_on_machine();
    }
    level notify(str_notify);
    array::thread_all(machine_triggers, & set_power_on, 1);
    if(isDefined(level.machine_assets[str_key].power_on_callback)) {
      array::thread_all(machine, level.machine_assets[str_key].power_on_callback);
    }
    level waittill(str_off);
    if(isDefined(level.machine_assets[str_key].power_off_callback)) {
      array::thread_all(machine, level.machine_assets[str_key].power_off_callback);
    }
    array::thread_all(machine, & turn_perk_off);
  }
}

function default_vending_precaching() {
  if(level._custom_perks.size > 0) {
    a_keys = getarraykeys(level._custom_perks);
    for(i = 0; i < a_keys.size; i++) {
      if(isDefined(level._custom_perks[a_keys[i]].precache_func)) {
        level[[level._custom_perks[a_keys[i]].precache_func]]();
      }
    }
  }
}

function do_initial_power_off_callback(machine_array, perkname) {
  if(!isDefined(level.machine_assets[perkname])) {
    println("");
    return;
  }
  if(!isDefined(level.machine_assets[perkname].power_off_callback)) {
    return;
  }
  wait(0.05);
  array::thread_all(machine_array, level.machine_assets[perkname].power_off_callback);
}

function use_solo_revive() {
  if(isDefined(level.override_use_solo_revive)) {
    return [[level.override_use_solo_revive]]();
  }
  players = getplayers();
  solo_mode = 0;
  if(players.size == 1 || (isDefined(level.force_solo_quick_revive) && level.force_solo_quick_revive)) {
    solo_mode = 1;
  }
  level.using_solo_revive = solo_mode;
  return solo_mode;
}

function set_power_on(state) {
  self.power_on = state;
}

function turn_perk_off(ishidden) {
  self notify("stop_loopsound");
  if(!(isDefined(self.b_keep_when_turned_off) && self.b_keep_when_turned_off)) {
    newmachine = spawn("script_model", self.origin);
    newmachine.angles = self.angles;
    newmachine.targetname = self.targetname;
    if(isDefined(ishidden) && ishidden) {
      newmachine.ishidden = 1;
      newmachine ghost();
      newmachine notsolid();
    }
    self delete();
  } else {
    perk_fx(undefined, 1);
  }
}

function play_loop_on_machine() {
  if(isDefined(level.sndperksacolaloopoverride)) {
    return;
  }
  sound_ent = spawn("script_origin", self.origin);
  sound_ent playLoopSound("zmb_perks_machine_loop");
  sound_ent linkto(self);
  self waittill("stop_loopsound");
  sound_ent unlink();
  sound_ent delete();
}

function perk_fx(fx, turnofffx) {
  if(isDefined(turnofffx)) {
    self.perk_fx = 0;
    if(isDefined(self.b_keep_when_turned_off) && self.b_keep_when_turned_off && isDefined(self.s_fxloc)) {
      self.s_fxloc delete();
    }
  } else {
    wait(3);
    if(!isDefined(self)) {
      return;
    }
    if(!(isDefined(self.b_keep_when_turned_off) && self.b_keep_when_turned_off)) {
      if(isDefined(self) && (!(isDefined(self.perk_fx) && self.perk_fx))) {
        playFXOnTag(level._effect[fx], self, "tag_origin");
        self.perk_fx = 1;
      }
    } else if(isDefined(self) && !isDefined(self.s_fxloc)) {
      self.s_fxloc = util::spawn_model("tag_origin", self.origin);
      playFXOnTag(level._effect[fx], self.s_fxloc, "tag_origin");
      self.perk_fx = 1;
    }
  }
}

function electric_perks_dialog() {
  self endon("death");
  wait(0.01);
  level flag::wait_till("start_zombie_round_logic");
  players = getplayers();
  if(players.size == 1) {
    return;
  }
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
        if(!isDefined(players[i])) {
          continue;
        }
        players[i] thread zm_utility::do_player_vo("vox_start", 5);
        wait(3);
        self notify("warning_dialog");
        iprintlnbold("");
      }
    }
  }
}

function reset_vending_hint_string() {
  perk = self.script_noteworthy;
  solo = use_solo_revive();
  if(isDefined(level._custom_perks)) {
    if(isDefined(level._custom_perks[perk]) && isDefined(level._custom_perks[perk].cost) && isDefined(level._custom_perks[perk].hint_string)) {
      if(isfunctionptr(level._custom_perks[perk].cost)) {
        n_cost = [
          [level._custom_perks[perk].cost]
        ]();
      } else {
        n_cost = level._custom_perks[perk].cost;
      }
      self sethintstring(level._custom_perks[perk].hint_string, n_cost);
    }
  }
}

function vending_trigger_can_player_use(player) {
  if(player laststand::player_is_in_laststand() || (isDefined(player.intermission) && player.intermission)) {
    return false;
  }
  if(player zm_utility::in_revive_trigger()) {
    return false;
  }
  if(!player zm_magicbox::can_buy_weapon()) {
    return false;
  }
  if(player isthrowinggrenade()) {
    return false;
  }
  if(player isswitchingweapons()) {
    return false;
  }
  if(player.is_drinking > 0) {
    return false;
  }
  return true;
}

function vending_trigger_think() {
  self endon("death");
  wait(0.01);
  perk = self.script_noteworthy;
  solo = 0;
  start_on = 0;
  level.revive_machine_is_solo = 0;
  if(isDefined(perk) && perk == "specialty_quickrevive") {
    level flag::wait_till("start_zombie_round_logic");
    solo = use_solo_revive();
    self endon("stop_quickrevive_logic");
    level.quick_revive_trigger = self;
    if(solo) {
      if(!(isDefined(level.revive_machine_is_solo) && level.revive_machine_is_solo)) {
        if(!(isDefined(level.initial_quick_revive_power_off) && level.initial_quick_revive_power_off)) {
          start_on = 1;
        }
        players = getplayers();
        foreach(player in players) {
          if(!isDefined(player.lives)) {
            player.lives = 0;
          }
        }
        level zm::set_default_laststand_pistol(1);
      }
      level.revive_machine_is_solo = 1;
    }
  }
  self sethintstring(&"ZOMBIE_NEED_POWER");
  self setcursorhint("HINT_NOICON");
  self usetriggerrequirelookat();
  cost = level.zombie_vars["zombie_perk_cost"];
  if(isDefined(level._custom_perks[perk]) && isDefined(level._custom_perks[perk].cost)) {
    if(isint(level._custom_perks[perk].cost)) {
      cost = level._custom_perks[perk].cost;
    } else {
      cost = [
        [level._custom_perks[perk].cost]
      ]();
    }
  }
  self.cost = cost;
  if(!start_on) {
    notify_name = perk + "_power_on";
    level waittill(notify_name);
  }
  start_on = 0;
  if(!isDefined(level._perkmachinenetworkchoke)) {
    level._perkmachinenetworkchoke = 0;
  } else {
    level._perkmachinenetworkchoke++;
  }
  for(i = 0; i < level._perkmachinenetworkchoke; i++) {
    util::wait_network_frame();
  }
  self thread zm_audio::sndperksjingles_timer();
  self thread check_player_has_perk(perk);
  if(isDefined(level._custom_perks[perk]) && isDefined(level._custom_perks[perk].hint_string)) {
    self sethintstring(level._custom_perks[perk].hint_string, cost);
  }
  for(;;) {
    self waittill("trigger", player);
    index = zm_utility::get_player_index(player);
    if(!vending_trigger_can_player_use(player)) {
      wait(0.1);
      continue;
    }
    if(player hasperk(perk) || player has_perk_paused(perk)) {
      cheat = 0;
      if(getdvarint("") >= 5) {
        cheat = 1;
      }
      if(cheat != 1) {
        self playSound("evt_perk_deny");
        player zm_audio::create_and_play_dialog("general", "sigh");
        continue;
      }
    }
    if(isDefined(level.custom_perk_validation)) {
      valid = self[[level.custom_perk_validation]](player);
      if(!valid) {
        continue;
      }
    }
    current_cost = self.cost;
    if(player zm_pers_upgrades_functions::is_pers_double_points_active()) {
      current_cost = player zm_pers_upgrades_functions::pers_upgrade_double_points_cost(current_cost);
    }
    if(!player zm_score::can_player_purchase(current_cost)) {
      self playSound("evt_perk_deny");
      player zm_audio::create_and_play_dialog("general", "outofmoney");
      continue;
    }
    if(!player zm_utility::can_player_purchase_perk()) {
      self playSound("evt_perk_deny");
      player zm_audio::create_and_play_dialog("general", "sigh");
      continue;
    }
    sound = "evt_bottle_dispense";
    playsoundatposition(sound, self.origin);
    player zm_score::minus_to_player_score(current_cost);
    bb::logpurchaseevent(player, self, current_cost, perk, 0, "_perk", "_purchased");
    perkhash = -1;
    if(isDefined(level._custom_perks[perk]) && isDefined(level._custom_perks[perk].var_2c8ee667)) {
      perkhash = level._custom_perks[perk].var_2c8ee667;
    }
    player recordmapevent(29, gettime(), self.origin, level.round_number, perkhash);
    player.perk_purchased = perk;
    player notify("perk_purchased", perk);
    self thread zm_audio::sndperksjingles_player(1);
    self thread vending_trigger_post_think(player, perk);
  }
}

function vending_trigger_post_think(player, perk) {
  player endon("disconnect");
  player endon("end_game");
  player endon("perk_abort_drinking");
  gun = player perk_give_bottle_begin(perk);
  evt = player util::waittill_any_return("fake_death", "death", "player_downed", "weapon_change_complete", "perk_abort_drinking", "disconnect");
  if(evt == "weapon_change_complete") {
    player thread wait_give_perk(perk, 1);
  }
  player perk_give_bottle_end(gun, perk);
  if(player laststand::player_is_in_laststand() || (isDefined(player.intermission) && player.intermission)) {
    return;
  }
  player notify("burp");
  if(isDefined(level.pers_upgrade_cash_back) && level.pers_upgrade_cash_back) {
    player zm_pers_upgrades_functions::cash_back_player_drinks_perk();
  }
  if(isDefined(level.pers_upgrade_perk_lose) && level.pers_upgrade_perk_lose) {
    player thread zm_pers_upgrades_functions::pers_upgrade_perk_lose_bought();
  }
  if(isDefined(level.perk_bought_func)) {
    player[[level.perk_bought_func]](perk);
  }
  player.perk_purchased = undefined;
  if(!(isDefined(self.power_on) && self.power_on)) {
    wait(1);
    perk_pause(self.script_noteworthy);
  }
}

function wait_give_perk(perk, bought) {
  self endon("player_downed");
  self endon("disconnect");
  self endon("end_game");
  self endon("perk_abort_drinking");
  self util::waittill_any_timeout(0.5, "burp", "player_downed", "disconnect", "end_game", "perk_abort_drinking");
  self give_perk(perk, bought);
}

function return_retained_perks() {
  if(isDefined(self._retain_perks_array)) {
    keys = getarraykeys(self._retain_perks_array);
    foreach(perk in keys) {
      if(isDefined(self._retain_perks_array[perk]) && self._retain_perks_array[perk]) {
        self give_perk(perk, 0);
      }
    }
  }
}

function give_perk_presentation(perk) {
  self endon("player_downed");
  self endon("disconnect");
  self endon("end_game");
  self endon("perk_abort_drinking");
  self zm_audio::playerexert("burp");
  if(isDefined(level.remove_perk_vo_delay) && level.remove_perk_vo_delay) {
    self zm_audio::create_and_play_dialog("perk", perk);
  } else {
    self util::delay(1.5, undefined, & zm_audio::create_and_play_dialog, "perk", perk);
  }
  self setblur(9, 0.1);
  wait(0.1);
  self setblur(0, 0.1);
}

function give_perk(perk, bought) {
  self setperk(perk);
  self.num_perks++;
  if(isDefined(bought) && bought) {
    self thread give_perk_presentation(perk);
    self notify("perk_bought", perk);
    self zm_stats::increment_challenge_stat("SURVIVALIST_BUY_PERK");
  }
  if(isDefined(level._custom_perks[perk]) && isDefined(level._custom_perks[perk].player_thread_give)) {
    self thread[[level._custom_perks[perk].player_thread_give]]();
  }
  self set_perk_clientfield(perk, 1);
  demo::bookmark("zm_player_perk", gettime(), self);
  self zm_stats::increment_client_stat("perks_drank");
  self zm_stats::increment_client_stat(perk + "_drank");
  self zm_stats::increment_player_stat(perk + "_drank");
  self zm_stats::increment_player_stat("perks_drank");
  if(!isDefined(self.perk_history)) {
    self.perk_history = [];
  }
  array::add(self.perk_history, perk, 0);
  if(!isDefined(self.perks_active)) {
    self.perks_active = [];
  }
  if(!isDefined(self.perks_active)) {
    self.perks_active = [];
  } else if(!isarray(self.perks_active)) {
    self.perks_active = array(self.perks_active);
  }
  self.perks_active[self.perks_active.size] = perk;
  self notify("perk_acquired");
  self thread perk_think(perk);
}

function perk_set_max_health_if_jugg(str_perk, set_premaxhealth, clamp_health_to_max_health) {
  n_max_total_health = undefined;
  switch (str_perk) {
    case "specialty_armorvest": {
      if(set_premaxhealth) {
        self.premaxhealth = self.maxhealth;
      }
      n_max_total_health = self.maxhealth + level.zombie_vars["zombie_perk_juggernaut_health"];
      break;
    }
    case "jugg_upgrade": {
      if(set_premaxhealth) {
        self.premaxhealth = self.maxhealth;
      }
      if(self hasperk("specialty_armorvest")) {
        n_max_total_health = n_max_total_health + level.zombie_vars["zombie_perk_juggernaut_health"];
      } else {
        n_max_total_health = level.zombie_vars["player_base_health"];
      }
      break;
    }
    case "health_reboot": {
      n_max_total_health = level.zombie_vars["player_base_health"];
      if(isDefined(self.n_player_health_boost)) {
        n_max_total_health = n_max_total_health + self.n_player_health_boost;
      }
      if(self hasperk("specialty_armorvest")) {
        n_max_total_health = n_max_total_health + level.zombie_vars["zombie_perk_juggernaut_health"];
      }
    }
  }
  if(isDefined(n_max_total_health)) {
    if(self zm_pers_upgrades_functions::pers_jugg_active()) {
      n_max_total_health = n_max_total_health + level.pers_jugg_upgrade_health_bonus;
    }
    self.maxhealth = n_max_total_health;
    self setmaxhealth(n_max_total_health);
    if(isDefined(clamp_health_to_max_health) && clamp_health_to_max_health == 1) {
      if(self.health > self.maxhealth) {
        self.health = self.maxhealth;
      }
    }
  }
}

function check_player_has_perk(perk) {
  self endon("death");
  if(getdvarint("") >= 5) {
    return;
  }
  dist = 16384;
  while(true) {
    players = getplayers();
    for(i = 0; i < players.size; i++) {
      if(distancesquared(players[i].origin, self.origin) < dist) {
        if(!players[i] hasperk(perk) && self vending_trigger_can_player_use(players[i]) && !players[i] has_perk_paused(perk) && !players[i] zm_utility::in_revive_trigger() && !zm_equipment::is_equipment_that_blocks_purchase(players[i] getcurrentweapon()) && !players[i] zm_equipment::hacker_active()) {
          self setinvisibletoplayer(players[i], 0);
          continue;
        }
        self setinvisibletoplayer(players[i], 1);
      }
    }
    wait(0.1);
  }
}

function vending_set_hintstring(perk) {
  switch (perk) {
    case "specialty_armorvest": {
      break;
    }
  }
}

function perk_think(perk) {
  self endon("disconnect");
  if(getdvarint("") >= 5) {
    if(isDefined(self.perk_hud[perk])) {
      return;
    }
  }
  perk_str = perk + "_stop";
  result = self util::waittill_any_return("fake_death", "death", "player_downed", perk_str);
  while(self bgb::lost_perk_override(perk)) {
    result = self util::waittill_any_return("fake_death", "death", "player_downed", perk_str);
  }
  do_retain = 1;
  if(use_solo_revive() && perk == "specialty_quickrevive") {
    do_retain = 0;
  }
  if(do_retain) {
    if(isDefined(self._retain_perks) && self._retain_perks) {
      return;
    }
    if(isDefined(self._retain_perks_array) && (isDefined(self._retain_perks_array[perk]) && self._retain_perks_array[perk])) {
      return;
    }
  }
  self unsetperk(perk);
  self.num_perks--;
  if(isDefined(level._custom_perks[perk]) && isDefined(level._custom_perks[perk].player_thread_take)) {
    self thread[[level._custom_perks[perk].player_thread_take]](0, perk_str, result);
  }
  self set_perk_clientfield(perk, 0);
  self.perk_purchased = undefined;
  if(isDefined(level.perk_lost_func)) {
    self[[level.perk_lost_func]](perk);
  }
  if(isDefined(self.perks_active) && isinarray(self.perks_active, perk)) {
    arrayremovevalue(self.perks_active, perk, 0);
  }
  self notify("perk_lost");
}

function set_perk_clientfield(perk, state) {
  if(isDefined(level._custom_perks[perk]) && isDefined(level._custom_perks[perk].clientfield_set)) {
    self[[level._custom_perks[perk].clientfield_set]](state);
  }
}

function perk_hud_destroy(perk) {
  self.perk_hud[perk] zm_utility::destroy_hud();
  self.perk_hud[perk] = undefined;
}

function perk_hud_grey(perk, grey_on_off) {
  if(grey_on_off) {
    self.perk_hud[perk].alpha = 0.3;
  } else {
    self.perk_hud[perk].alpha = 1;
  }
}

function perk_give_bottle_begin(perk) {
  self zm_utility::increment_is_drinking();
  self zm_utility::disable_player_move_states(1);
  original_weapon = self getcurrentweapon();
  weapon = "";
  if(isDefined(level._custom_perks[perk]) && isDefined(level._custom_perks[perk].perk_bottle_weapon)) {
    weapon = level._custom_perks[perk].perk_bottle_weapon;
  }
  self giveweapon(weapon);
  self switchtoweapon(weapon);
  return original_weapon;
}

function perk_give_bottle_end(original_weapon, perk) {
  self endon("perk_abort_drinking");
  assert(!original_weapon.isperkbottle);
  assert(original_weapon != level.weaponrevivetool);
  self zm_utility::enable_player_move_states();
  weapon = "";
  if(isDefined(level._custom_perks[perk]) && isDefined(level._custom_perks[perk].perk_bottle_weapon)) {
    weapon = level._custom_perks[perk].perk_bottle_weapon;
  }
  if(self laststand::player_is_in_laststand() || (isDefined(self.intermission) && self.intermission)) {
    self takeweapon(weapon);
    return;
  }
  self takeweapon(weapon);
  if(self zm_utility::is_multiple_drinking()) {
    self zm_utility::decrement_is_drinking();
    return;
  }
  if(original_weapon != level.weaponnone && !zm_utility::is_placeable_mine(original_weapon) && !zm_equipment::is_equipment_that_blocks_purchase(original_weapon)) {
    self zm_weapons::switch_back_primary_weapon(original_weapon);
    if(zm_utility::is_melee_weapon(original_weapon)) {
      self zm_utility::decrement_is_drinking();
      return;
    }
  } else {
    self zm_weapons::switch_back_primary_weapon();
  }
  self waittill("weapon_change_complete");
  if(!self laststand::player_is_in_laststand() && (!(isDefined(self.intermission) && self.intermission))) {
    self zm_utility::decrement_is_drinking();
  }
}

function perk_abort_drinking(post_delay) {
  if(self.is_drinking) {
    self notify("perk_abort_drinking");
    self zm_utility::decrement_is_drinking();
    self zm_utility::enable_player_move_states();
    if(isDefined(post_delay)) {
      wait(post_delay);
    }
  }
}

function give_random_perk() {
  random_perk = undefined;
  a_str_perks = getarraykeys(level._custom_perks);
  perks = [];
  for(i = 0; i < a_str_perks.size; i++) {
    perk = a_str_perks[i];
    if(isDefined(self.perk_purchased) && self.perk_purchased == perk) {
      continue;
    }
    if(!self hasperk(perk) && !self has_perk_paused(perk)) {
      perks[perks.size] = perk;
    }
  }
  if(perks.size > 0) {
    perks = array::randomize(perks);
    random_perk = perks[0];
    self give_perk(random_perk);
  } else {
    self playsoundtoplayer(level.zmb_laugh_alias, self);
  }
  return random_perk;
}

function lose_random_perk() {
  a_str_perks = getarraykeys(level._custom_perks);
  perks = [];
  for(i = 0; i < a_str_perks.size; i++) {
    perk = a_str_perks[i];
    if(isDefined(self.perk_purchased) && self.perk_purchased == perk) {
      continue;
    }
    if(self hasperk(perk) || self has_perk_paused(perk)) {
      perks[perks.size] = perk;
    }
  }
  if(perks.size > 0) {
    perks = array::randomize(perks);
    perk = perks[0];
    perk_str = perk + "_stop";
    self notify(perk_str);
    if(use_solo_revive() && perk == "specialty_quickrevive") {
      self.lives--;
    }
  }
}

function update_perk_hud() {
  if(isDefined(self.perk_hud)) {
    keys = getarraykeys(self.perk_hud);
    for(i = 0; i < self.perk_hud.size; i++) {
      self.perk_hud[keys[i]].x = i * 30;
    }
  }
}

function quantum_bomb_give_nearest_perk_validation(position) {
  vending_triggers = getEntArray("zombie_vending", "targetname");
  range_squared = 32400;
  for(i = 0; i < vending_triggers.size; i++) {
    if(distancesquared(vending_triggers[i].origin, position) < range_squared) {
      return true;
    }
  }
  return false;
}

function quantum_bomb_give_nearest_perk_result(position) {
  [[level.quantum_bomb_play_mystery_effect_func]](position);
  vending_triggers = getEntArray("zombie_vending", "targetname");
  nearest = 0;
  for(i = 1; i < vending_triggers.size; i++) {
    if(distancesquared(vending_triggers[i].origin, position) < distancesquared(vending_triggers[nearest].origin, position)) {
      nearest = i;
    }
  }
  players = getplayers();
  perk = vending_triggers[nearest].script_noteworthy;
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(player.sessionstate == "spectator" || player laststand::player_is_in_laststand()) {
      continue;
    }
    if(!player hasperk(perk) && (!isDefined(player.perk_purchased) || player.perk_purchased != perk) && randomint(5)) {
      if(player == self) {
        self thread zm_audio::create_and_play_dialog("kill", "quant_good");
      }
      player give_perk(perk);
      player[[level.quantum_bomb_play_player_effect_func]]();
    }
  }
}

function perk_pause(perk) {
  if(isDefined(level.dont_unset_perk_when_machine_paused) && level.dont_unset_perk_when_machine_paused) {
    return;
  }
  for(j = 0; j < getplayers().size; j++) {
    player = getplayers()[j];
    if(!isDefined(player.disabled_perks)) {
      player.disabled_perks = [];
    }
    player.disabled_perks[perk] = isDefined(player.disabled_perks[perk]) && player.disabled_perks[perk] || player hasperk(perk);
    if(player.disabled_perks[perk]) {
      player unsetperk(perk);
      player set_perk_clientfield(perk, 2);
      if(isDefined(level._custom_perks[perk]) && isDefined(level._custom_perks[perk].player_thread_take)) {
        player thread[[level._custom_perks[perk].player_thread_take]](1);
      }
      println(((("" + player.name) + "") + perk) + "");
    }
  }
}

function perk_unpause(perk) {
  if(isDefined(level.dont_unset_perk_when_machine_paused) && level.dont_unset_perk_when_machine_paused) {
    return;
  }
  if(!isDefined(perk)) {
    return;
  }
  for(j = 0; j < getplayers().size; j++) {
    player = getplayers()[j];
    if(isDefined(player.disabled_perks) && (isDefined(player.disabled_perks[perk]) && player.disabled_perks[perk])) {
      player.disabled_perks[perk] = 0;
      player set_perk_clientfield(perk, 1);
      player setperk(perk);
      println(((("" + player.name) + "") + perk) + "");
      player perk_set_max_health_if_jugg(perk, 0, 0);
      if(isDefined(level._custom_perks[perk]) && isDefined(level._custom_perks[perk].player_thread_give)) {
        player thread[[level._custom_perks[perk].player_thread_give]]();
      }
    }
  }
}

function perk_pause_all_perks(power_zone) {
  vending_triggers = getEntArray("zombie_vending", "targetname");
  foreach(trigger in vending_triggers) {
    if(!isDefined(power_zone)) {
      perk_pause(trigger.script_noteworthy);
      continue;
    }
    if(isDefined(trigger.script_int) && trigger.script_int == power_zone) {
      perk_pause(trigger.script_noteworthy);
    }
  }
}

function perk_unpause_all_perks(power_zone) {
  vending_triggers = getEntArray("zombie_vending", "targetname");
  foreach(trigger in vending_triggers) {
    if(!isDefined(power_zone)) {
      perk_unpause(trigger.script_noteworthy);
      continue;
    }
    if(isDefined(trigger.script_int) && trigger.script_int == power_zone) {
      perk_unpause(trigger.script_noteworthy);
    }
  }
}

function has_perk_paused(perk) {
  if(isDefined(self.disabled_perks) && isDefined(self.disabled_perks[perk]) && self.disabled_perks[perk]) {
    return true;
  }
  return false;
}

function getvendingmachinenotify() {
  if(!isDefined(self)) {
    return "";
  }
  str_perk = undefined;
  if(isDefined(level._custom_perks[self.script_noteworthy]) && isDefined(isDefined(level._custom_perks[self.script_noteworthy].alias))) {
    str_perk = level._custom_perks[self.script_noteworthy].alias;
  }
  return str_perk;
}

function perk_machine_removal(machine, replacement_model) {
  if(!isDefined(machine)) {
    return;
  }
  trig = getent(machine, "script_noteworthy");
  machine_model = undefined;
  if(isDefined(trig)) {
    trig notify("warning_dialog");
    if(isDefined(trig.target)) {
      parts = getEntArray(trig.target, "targetname");
      for(i = 0; i < parts.size; i++) {
        if(isDefined(parts[i].classname) && parts[i].classname == "script_model") {
          machine_model = parts[i];
          continue;
        }
        if(isDefined(parts[i].script_noteworthy && parts[i].script_noteworthy == "clip")) {
          model_clip = parts[i];
          continue;
        }
        parts[i] delete();
      }
    }
    if(isDefined(replacement_model) && isDefined(machine_model)) {
      machine_model setModel(replacement_model);
    } else if(!isDefined(replacement_model) && isDefined(machine_model)) {
      machine_model delete();
      if(isDefined(model_clip)) {
        model_clip delete();
      }
      if(isDefined(trig.clip)) {
        trig.clip delete();
      }
    }
    if(isDefined(trig.bump)) {
      trig.bump delete();
    }
    trig delete();
  }
}

function perk_machine_spawn_init() {
  match_string = "";
  location = level.scr_zm_map_start_location;
  if(location == "default" || location == "" && isDefined(level.default_start_location)) {
    location = level.default_start_location;
  }
  match_string = (level.scr_zm_ui_gametype + "_perks_") + location;
  a_s_spawn_pos = [];
  if(isDefined(level.override_perk_targetname)) {
    structs = struct::get_array(level.override_perk_targetname, "targetname");
  } else {
    structs = struct::get_array("zm_perk_machine", "targetname");
  }
  foreach(struct in structs) {
    if(isDefined(struct.script_string)) {
      tokens = strtok(struct.script_string, " ");
      foreach(token in tokens) {
        if(token == match_string) {
          a_s_spawn_pos[a_s_spawn_pos.size] = struct;
        }
      }
      continue;
    }
    a_s_spawn_pos[a_s_spawn_pos.size] = struct;
  }
  if(a_s_spawn_pos.size == 0) {
    return;
  }
  if(isDefined(level.randomize_perk_machine_location) && level.randomize_perk_machine_location) {
    a_s_random_perk_locs = struct::get_array("perk_random_machine_location", "targetname");
    if(a_s_random_perk_locs.size > 0) {
      a_s_random_perk_locs = array::randomize(a_s_random_perk_locs);
    }
    n_random_perks_assigned = 0;
  }
  foreach(s_spawn_pos in a_s_spawn_pos) {
    perk = s_spawn_pos.script_noteworthy;
    if(isDefined(perk) && isDefined(s_spawn_pos.model)) {
      if(isDefined(level.randomize_perk_machine_location) && level.randomize_perk_machine_location && a_s_random_perk_locs.size > 0 && isDefined(s_spawn_pos.script_notify)) {
        s_new_loc = a_s_random_perk_locs[n_random_perks_assigned];
        s_spawn_pos.origin = s_new_loc.origin;
        s_spawn_pos.angles = s_new_loc.angles;
        if(isDefined(s_new_loc.script_int)) {
          s_spawn_pos.script_int = s_new_loc.script_int;
        }
        if(isDefined(s_new_loc.target)) {
          s_tell_location = struct::get(s_new_loc.target);
          if(isDefined(s_tell_location)) {
            util::spawn_model("p7_zm_perk_bottle_broken_" + perk, s_tell_location.origin, s_tell_location.angles);
          }
        }
        n_random_perks_assigned++;
      }
      t_use = spawn("trigger_radius_use", s_spawn_pos.origin + vectorscale((0, 0, 1), 60), 0, 40, 80);
      t_use.targetname = "zombie_vending";
      t_use.script_noteworthy = perk;
      if(isDefined(s_spawn_pos.script_int)) {
        t_use.script_int = s_spawn_pos.script_int;
      }
      t_use triggerignoreteam();
      perk_machine = spawn("script_model", s_spawn_pos.origin);
      if(!isDefined(s_spawn_pos.angles)) {
        s_spawn_pos.angles = (0, 0, 0);
      }
      perk_machine.angles = s_spawn_pos.angles;
      perk_machine setModel(s_spawn_pos.model);
      if(isDefined(level._no_vending_machine_bump_trigs) && level._no_vending_machine_bump_trigs) {
        bump_trigger = undefined;
      } else {
        bump_trigger = spawn("trigger_radius", s_spawn_pos.origin + vectorscale((0, 0, 1), 20), 0, 40, 80);
        bump_trigger.script_activated = 1;
        bump_trigger.script_sound = "zmb_perks_bump_bottle";
        bump_trigger.targetname = "audio_bump_trigger";
      }
      if(isDefined(level._no_vending_machine_auto_collision) && level._no_vending_machine_auto_collision) {
        collision = undefined;
      } else {
        collision = spawn("script_model", s_spawn_pos.origin, 1);
        collision.angles = s_spawn_pos.angles;
        collision setModel("zm_collision_perks1");
        collision.script_noteworthy = "clip";
        collision disconnectpaths();
      }
      t_use.clip = collision;
      t_use.machine = perk_machine;
      t_use.bump = bump_trigger;
      if(isDefined(s_spawn_pos.script_notify)) {
        perk_machine.script_notify = s_spawn_pos.script_notify;
      }
      if(isDefined(s_spawn_pos.target)) {
        perk_machine.target = s_spawn_pos.target;
      }
      if(isDefined(s_spawn_pos.blocker_model)) {
        t_use.blocker_model = s_spawn_pos.blocker_model;
      }
      if(isDefined(s_spawn_pos.script_int)) {
        perk_machine.script_int = s_spawn_pos.script_int;
      }
      if(isDefined(s_spawn_pos.turn_on_notify)) {
        perk_machine.turn_on_notify = s_spawn_pos.turn_on_notify;
      }
      t_use.script_sound = "mus_perks_speed_jingle";
      t_use.script_string = "speedcola_perk";
      t_use.script_label = "mus_perks_speed_sting";
      t_use.target = "vending_sleight";
      perk_machine.script_string = "speedcola_perk";
      perk_machine.targetname = "vending_sleight";
      if(isDefined(bump_trigger)) {
        bump_trigger.script_string = "speedcola_perk";
      }
      if(isDefined(level._custom_perks[perk]) && isDefined(level._custom_perks[perk].perk_machine_set_kvps)) {
        [
          [level._custom_perks[perk].perk_machine_set_kvps]
        ](t_use, perk_machine, bump_trigger, collision);
      }
    }
  }
}

function get_perk_machine_start_state(perk) {
  if(isDefined(level.vending_machines_powered_on_at_start) && level.vending_machines_powered_on_at_start) {
    return 1;
  }
  if(perk == "specialty_quickrevive") {
    assert(isDefined(level.revive_machine_is_solo));
    return level.revive_machine_is_solo;
  }
  return 0;
}

function perks_register_clientfield() {
  if(isDefined(level.zombiemode_using_perk_intro_fx) && level.zombiemode_using_perk_intro_fx) {
    clientfield::register("scriptmover", "clientfield_perk_intro_fx", 1, 1, "int");
  }
  if(isDefined(level._custom_perks)) {
    a_keys = getarraykeys(level._custom_perks);
    for(i = 0; i < a_keys.size; i++) {
      if(isDefined(level._custom_perks[a_keys[i]].clientfield_register)) {
        level[[level._custom_perks[a_keys[i]].clientfield_register]]();
      }
    }
  }
}

function thread_bump_trigger() {
  for(;;) {
    self waittill("trigger", trigplayer);
    trigplayer playSound(self.script_sound);
    while(zm_utility::is_player_valid(trigplayer) && trigplayer istouching(self)) {
      wait(0.5);
    }
  }
}

function players_are_in_perk_area(perk_machine) {
  perk_area_origin = level.quick_revive_default_origin;
  if(isDefined(perk_machine._linked_ent)) {
    perk_area_origin = perk_machine._linked_ent.origin;
    if(isDefined(perk_machine._linked_ent_offset)) {
      perk_area_origin = perk_area_origin + perk_machine._linked_ent_offset;
    }
  }
  in_area = 0;
  players = getplayers();
  dist_check = 9216;
  foreach(player in players) {
    if(distancesquared(player.origin, perk_area_origin) < dist_check) {
      return true;
    }
  }
  return false;
}

function perk_hostmigration() {
  level endon("end_game");
  level notify("perk_hostmigration");
  level endon("perk_hostmigration");
  while(true) {
    level waittill("host_migration_end");
    if(isDefined(level._custom_perks) && level._custom_perks.size > 0) {
      a_keys = getarraykeys(level._custom_perks);
      foreach(key in a_keys) {
        if(isDefined(level._custom_perks[key].radiant_machine_name) && isDefined(level._custom_perks[key].machine_light_effect)) {
          level thread host_migration_func(level._custom_perks[key], key);
        }
      }
    }
  }
}

function host_migration_func(s_custom_perk, keyname) {
  a_machines = getEntArray(s_custom_perk.radiant_machine_name, "targetname");
  foreach(perk in a_machines) {
    if(isDefined(perk.model) && perk.model == level.machine_assets[keyname].on_model) {
      perk perk_fx(undefined, 1);
      perk thread perk_fx(s_custom_perk.machine_light_effect);
    }
  }
}

function spare_change(str_trigger = "audio_bump_trigger", str_sound = "zmb_perks_bump_bottle") {
  a_t_audio = getEntArray(str_trigger, "targetname");
  foreach(t_audio_bump in a_t_audio) {
    if(t_audio_bump.script_sound === str_sound) {
      t_audio_bump thread check_for_change();
    }
  }
}

function check_for_change() {
  self endon("death");
  while(true) {
    self waittill("trigger", player);
    if(player getstance() == "prone") {
      player zm_score::add_to_player_score(100);
      zm_utility::play_sound_at_pos("purchase", player.origin);
      break;
    }
    wait(0.1);
  }
}

function get_perk_array() {
  perk_array = [];
  if(level._custom_perks.size > 0) {
    a_keys = getarraykeys(level._custom_perks);
    for(i = 0; i < a_keys.size; i++) {
      if(self hasperk(a_keys[i])) {
        perk_array[perk_array.size] = a_keys[i];
      }
    }
  }
  return perk_array;
}

function initialize_custom_perk_arrays() {
  if(!isDefined(level._custom_perks)) {
    level._custom_perks = [];
  }
}

function register_revive_success_perk_func(revive_func) {
  if(!isDefined(level.a_revive_success_perk_func)) {
    level.a_revive_success_perk_func = [];
  }
  level.a_revive_success_perk_func[level.a_revive_success_perk_func.size] = revive_func;
}

function register_perk_basic_info(str_perk, str_alias, n_perk_cost, str_hint_string, w_perk_bottle_weapon) {
  assert(isDefined(str_perk), "");
  assert(isDefined(str_alias), "");
  assert(isDefined(n_perk_cost), "");
  assert(isDefined(str_hint_string), "");
  assert(isDefined(w_perk_bottle_weapon), "");
  _register_undefined_perk(str_perk);
  level._custom_perks[str_perk].alias = str_alias;
  level._custom_perks[str_perk].var_2c8ee667 = hashstring(str_alias);
  level._custom_perks[str_perk].cost = n_perk_cost;
  level._custom_perks[str_perk].hint_string = str_hint_string;
  level._custom_perks[str_perk].perk_bottle_weapon = w_perk_bottle_weapon;
}

function register_perk_machine(str_perk, func_perk_machine_setup, func_perk_machine_thread) {
  assert(isDefined(str_perk), "");
  assert(isDefined(func_perk_machine_setup), "");
  _register_undefined_perk(str_perk);
  if(!isDefined(level._custom_perks[str_perk].perk_machine_set_kvps)) {
    level._custom_perks[str_perk].perk_machine_set_kvps = func_perk_machine_setup;
  }
  if(!isDefined(level._custom_perks[str_perk].perk_machine_thread) && isDefined(func_perk_machine_thread)) {
    level._custom_perks[str_perk].perk_machine_thread = func_perk_machine_thread;
  }
}

function register_perk_machine_power_override(str_perk, func_perk_machine_power_override) {
  assert(isDefined(str_perk), "");
  assert(isDefined(func_perk_machine_power_override), "");
  _register_undefined_perk(str_perk);
  if(!isDefined(level._custom_perks[str_perk].perk_machine_power_override_thread) && isDefined(func_perk_machine_power_override)) {
    level._custom_perks[str_perk].perk_machine_power_override_thread = func_perk_machine_power_override;
  }
}

function register_perk_precache_func(str_perk, func_precache) {
  assert(isDefined(str_perk), "");
  assert(isDefined(func_precache), "");
  _register_undefined_perk(str_perk);
  if(!isDefined(level._custom_perks[str_perk].precache_func)) {
    level._custom_perks[str_perk].precache_func = func_precache;
  }
}

function register_perk_threads(str_perk, func_give_player_perk, func_take_player_perk) {
  assert(isDefined(str_perk), "");
  assert(isDefined(func_give_player_perk), "");
  _register_undefined_perk(str_perk);
  if(!isDefined(level._custom_perks[str_perk].player_thread_give)) {
    level._custom_perks[str_perk].player_thread_give = func_give_player_perk;
  }
  if(isDefined(func_take_player_perk)) {
    if(!isDefined(level._custom_perks[str_perk].player_thread_take)) {
      level._custom_perks[str_perk].player_thread_take = func_take_player_perk;
    }
  }
}

function register_perk_clientfields(str_perk, func_clientfield_register, func_clientfield_set) {
  assert(isDefined(str_perk), "");
  assert(isDefined(func_clientfield_register), "");
  assert(isDefined(func_clientfield_set), "");
  _register_undefined_perk(str_perk);
  if(!isDefined(level._custom_perks[str_perk].clientfield_register)) {
    level._custom_perks[str_perk].clientfield_register = func_clientfield_register;
  }
  if(!isDefined(level._custom_perks[str_perk].clientfield_set)) {
    level._custom_perks[str_perk].clientfield_set = func_clientfield_set;
  }
}

function register_perk_host_migration_params(str_perk, str_radiant_name, str_effect_name) {
  assert(isDefined(str_perk), "");
  assert(isDefined(str_radiant_name), "");
  assert(isDefined(str_effect_name), "");
  _register_undefined_perk(str_perk);
  if(!isDefined(level._custom_perks[str_perk].radiant_name)) {
    level._custom_perks[str_perk].radiant_machine_name = str_radiant_name;
  }
  if(!isDefined(level._custom_perks[str_perk].light_effect)) {
    level._custom_perks[str_perk].machine_light_effect = str_effect_name;
  }
}

function _register_undefined_perk(str_perk) {
  if(!isDefined(level._custom_perks)) {
    level._custom_perks = [];
  }
  if(!isDefined(level._custom_perks[str_perk])) {
    level._custom_perks[str_perk] = spawnStruct();
  }
}

function register_perk_damage_override_func(func_damage_override) {
  assert(isDefined(func_damage_override), "");
  if(!isDefined(level.perk_damage_override)) {
    level.perk_damage_override = [];
  }
  array::add(level.perk_damage_override, func_damage_override, 0);
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_magicbox.gsc
***********************************************/

#include scripts\core_common\aat_shared;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\demo_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\potm_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\bb;
#include scripts\zm_common\trials\zm_trial_disable_buys;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_cleanup_mgr;
#include scripts\zm_common\zm_contracts;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_daily_challenges;
#include scripts\zm_common\zm_equipment;
#include scripts\zm_common\zm_hero_weapon;
#include scripts\zm_common\zm_laststand;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_vo;
#include scripts\zm_common\zm_weapons;
#include scripts\zm_common\zm_zonemgr;

#namespace zm_magicbox;

autoexec __init__system__() {
  system::register(#"zm_magicbox", &__init__, &__main__, undefined);
}

__init__() {
  level.start_chest_name = "start_chest";
  level._effect[#"hash_2ff87d61167ea531"] = #"hash_d66a9f5776f1fba";
  level._effect[#"hash_4048cb4967032c4a"] = #"hash_1e43d43c6586fcb5";
  level._effect[#"lght_marker"] = #"zombie/fx_weapon_box_marker_zmb";
  level._effect[#"lght_marker_flare"] = #"zombie/fx_weapon_box_marker_fl_zmb";
  level._effect[#"poltergeist"] = #"zombie/fx_barrier_buy_zmb";
  clientfield::register("zbarrier", "magicbox_open_fx", 1, 1, "int");
  clientfield::register("zbarrier", "magicbox_closed_fx", 1, 1, "int");
  clientfield::register("zbarrier", "magicbox_leave_fx", 1, 1, "counter");
  clientfield::register("zbarrier", "zbarrier_show_sounds", 1, 1, "counter");
  clientfield::register("zbarrier", "zbarrier_leave_sounds", 1, 1, "counter");
  clientfield::register("zbarrier", "force_stream_magicbox", 1, 1, "int");
  clientfield::register("zbarrier", "force_stream_magicbox_leave", 1, 1, "int");
  clientfield::register("scriptmover", "force_stream", 1, 1, "int");
  clientfield::register("zbarrier", "t8_magicbox_crack_glow_fx", 1, 1, "int");
  clientfield::register("zbarrier", "t8_magicbox_ambient_fx", 1, 1, "int");
  clientfield::register("zbarrier", "" + #"hash_2fcdae6b889933c7", 1, 1, "int");
  level flag::init("magicbox_initialized");
  level thread magicbox_host_migration();
}

__main__() {
  level flag::wait_till("start_zombie_round_logic");

  if(!isDefined(level.chest_joker_model)) {
    level.chest_joker_model = "p7_zm_teddybear";
  }

  if(!isDefined(level.magic_box_zbarrier_state_func)) {
    level.magic_box_zbarrier_state_func = &process_magic_box_zbarrier_state;
  }

  if(!isDefined(level.magic_box_check_equipment)) {
    level.magic_box_check_equipment = &default_magic_box_check_equipment;
  }

  waitframe(1);
  treasure_chest_init(level.start_chest_name);
  level thread function_4873c058();

  if(zm_custom::function_901b751c(#"zmmysteryboxlimitround")) {
    level thread function_338c302b();
  }

  level flag::set("magicbox_initialized");
}

treasure_chest_init(start_chest_name) {
  level flag::init("moving_chest_enabled");
  level flag::init("moving_chest_now");
  level flag::init("chest_has_been_used");
  level flag::init("chest_weapon_has_been_taken");
  level.chest_moves = 0;
  level.chest_level = 0;
  level.chests = struct::get_array("treasure_chest_use", "targetname");

  if(level.chests.size == 0) {
    return;
  }

  for(i = 0; i < level.chests.size; i++) {
    level.chests[i].box_hacks = [];
    level.chests[i].orig_origin = level.chests[i].origin;
    level.chests[i] get_chest_pieces();

    if(isDefined(level.chests[i].zombie_cost)) {
      level.chests[i].old_cost = level.chests[i].zombie_cost;
      continue;
    }

    level.chests[i].old_cost = 950;
  }

  if(!level.enable_magic || zm_custom::function_901b751c(#"zmmysteryboxstate") == 0) {
    foreach(chest in level.chests) {
      chest hide_chest();
    }

    return;
  }

  level.chest_accessed = 0;

  if(level.chests.size > 1) {
    level flag::set("moving_chest_enabled");
    level.chests = array::randomize(level.chests);
  } else {
    level.chest_index = 0;
    level.chests[0].no_fly_away = 1;
  }

  init_starting_chest_location(start_chest_name);
  array::thread_all(level.chests, &treasure_chest_think);
}

init_starting_chest_location(start_chest_name) {
  level.chest_index = 0;
  start_chest_found = 0;

  if(level.chests.size == 1) {
    start_chest_found = 1;

    if(isDefined(level.chests[level.chest_index].zbarrier)) {
      level.chests[level.chest_index].zbarrier set_magic_box_zbarrier_state("initial");
      level.chests[level.chest_index] thread zm_audio::function_ef9ba49c(#"box", 0, -1, 500, array("left", "trigger"));
    }
  } else if(zm_custom::function_901b751c(#"zmmysteryboxstate") == 3) {
    for(i = 0; i < level.chests.size; i++) {
      level.chests[i] function_2db086bf();
      level.chests[i].no_fly_away = 1;
      level.chests[i] thread show_chest();
    }
  } else if(zm_custom::function_901b751c(#"zmmysteryboxstate") == 1) {
    level.chest_index = -1;

    for(i = 0; i < level.chests.size; i++) {
      level.chests[i] hide_chest();
    }
  } else {
    for(i = 0; i < level.chests.size; i++) {
      if(isDefined(level.random_pandora_box_start) && level.random_pandora_box_start == 1) {
        if(start_chest_found || isDefined(level.chests[i].start_exclude) && level.chests[i].start_exclude == 1) {
          level.chests[i] hide_chest();
        } else {
          level.chest_index = i;
          level.chests[i] thread function_2db086bf();
          start_chest_found = 1;
        }

        continue;
      }

      if(start_chest_found || !isDefined(level.chests[i].script_noteworthy) || !issubstr(level.chests[i].script_noteworthy, start_chest_name)) {
        level.chests[i] hide_chest();
        continue;
      }

      level.chest_index = i;
      level.chests[i] thread function_2db086bf();
      start_chest_found = 1;
    }
  }

  if(!isDefined(level.pandora_show_func)) {
    if(isDefined(level.custom_pandora_show_func)) {
      level.pandora_show_func = level.custom_pandora_show_func;
    } else {
      level.pandora_show_func = &default_pandora_show_func;
    }
  }

  if(!(isDefined(zm_custom::function_901b751c(#"zmmysteryboxstate") == 1) && zm_custom::function_901b751c(#"zmmysteryboxstate") == 1)) {
    level.chests[level.chest_index] thread[[level.pandora_show_func]]();
  }
}

set_treasure_chest_cost(cost) {
  level.zombie_treasure_chest_cost = cost;
}

get_chest_pieces() {
  self.chest_box = getent(self.script_noteworthy + "_zbarrier", "script_noteworthy");
  self.chest_rubble = [];
  rubble = getEntArray(self.script_noteworthy + "_rubble", "script_noteworthy");

  for(i = 0; i < rubble.size; i++) {
    if(distancesquared(self.origin, rubble[i].origin) < 10000) {
      self.chest_rubble[self.chest_rubble.size] = rubble[i];
    }
  }

  self.zbarrier = getent(self.script_noteworthy + "_zbarrier", "script_noteworthy");

  if(isDefined(self.zbarrier)) {
    self.zbarrier zbarrierpieceuseboxriselogic(3);
    self.zbarrier zbarrierpieceuseboxriselogic(4);
  }

  self.unitrigger_stub = zm_unitrigger::function_9267812e(104, 45, 50);
  zm_unitrigger::function_47625e58(self.unitrigger_stub, self.origin + anglestoright(self.angles) * -22.5, self.angles);
  zm_unitrigger::function_2547d31f(self.unitrigger_stub, &boxtrigger_update_prompt);
  zm_unitrigger::unitrigger_force_per_player_triggers(self.unitrigger_stub, 1);
  self.unitrigger_stub.trigger_target = self;
  self.zbarrier.owner = self;
}

boxtrigger_update_prompt(player) {
  can_use = self boxstub_update_prompt(player);

  if(zm_custom::function_901b751c(#"zmmysteryboxlimitround") && !(isDefined(self.stub.trigger_target._box_open) && self.stub.trigger_target._box_open)) {
    if((isDefined(level.var_40f4f72d) ? level.var_40f4f72d : 0) >= zm_custom::function_901b751c(#"zmmysteryboxlimitround")) {
      can_use = 0;
    }
  }

  if(isDefined(self.hint_string)) {
    if(isDefined(self.hint_parm1)) {
      self sethintstring(self.hint_string, self.hint_parm1);
    } else {
      self sethintstring(self.hint_string);
    }
  }

  return can_use;
}

boxstub_update_prompt(player) {
  if(isDefined(self.stub.var_dd0d4460) && self.stub.var_dd0d4460) {
    return false;
  }

  if(isDefined(self.stub.trigger_target.is_locked) && self.stub.trigger_target.is_locked) {
    return false;
  }

  if(!self trigger_visible_to_player(player)) {
    return false;
  }

  if(isDefined(level.func_magicbox_update_prompt_use_override)) {
    if(self[[level.func_magicbox_update_prompt_use_override]](player)) {
      if(zm_utility::is_standard()) {
        return true;
      } else {
        return false;
      }
    }
  }

  self.hint_parm1 = undefined;

  if(isDefined(self.stub.trigger_target.grab_weapon_hint) && self.stub.trigger_target.grab_weapon_hint) {
    cursor_hint = "HINT_WEAPON";
    cursor_hint_weapon = self.stub.trigger_target.grab_weapon;
    self setcursorhint(cursor_hint, cursor_hint_weapon);

    if(isDefined(level.magic_box_check_equipment) && [
        [level.magic_box_check_equipment]
      ](cursor_hint_weapon)) {
      if(function_8b1a219a()) {
        self.hint_string = #"hash_51b8af0794e70749";
      } else {
        self.hint_string = #"hash_53005c8d5b45bca3";
      }

      if(!(isDefined(self.stub.trigger_target.var_1f9dff37) && self.stub.trigger_target.var_1f9dff37) && !(isDefined(self.stub.trigger_target.var_481aa649) && self.stub.trigger_target.var_481aa649) && isDefined(self.stub.trigger_target.var_c2f3a87c) && self.stub.trigger_target.var_c2f3a87c) {
        if(function_8b1a219a()) {
          self.hint_string = #"hash_90ca7c41027482c";
        } else {
          self.hint_string = #"hash_4320539409034300";
        }
      }
    } else {
      if(function_8b1a219a()) {
        self.hint_string = #"hash_62a71d8ac2e7af43";
      } else {
        self.hint_string = #"hash_6a4c5538a960189d";
      }

      if(!(isDefined(self.stub.trigger_target.var_1f9dff37) && self.stub.trigger_target.var_1f9dff37) && !(isDefined(self.stub.trigger_target.var_481aa649) && self.stub.trigger_target.var_481aa649) && isDefined(self.stub.trigger_target.var_c2f3a87c) && self.stub.trigger_target.var_c2f3a87c) {
        if(function_8b1a219a()) {
          self.hint_string = #"hash_6b94377deeed6d0e";
        } else {
          self.hint_string = #"hash_4a972ee1265d60a";
        }
      }
    }
  } else if(zm_trial_disable_buys::is_active()) {
    self sethintstring(#"hash_55d25caf8f7bbb2f");
    return true;
  } else {
    self setcursorhint("HINT_NOICON");
    self.hint_parm1 = self.stub.trigger_target.zombie_cost;
    self.hint_string = zm_utility::get_hint_string(self, "default_treasure_chest");
  }

  return true;
}

default_magic_box_check_equipment(weapon) {
  return zm_loadout::is_offhand_weapon(weapon);
}

trigger_visible_to_player(player) {
  self setinvisibletoplayer(player);
  visible = 1;
  var_5f6b2789 = self.stub.trigger_target;

  if(isDefined(var_5f6b2789.chest_user) && !isDefined(var_5f6b2789.box_rerespun)) {
    wpn_current = var_5f6b2789.chest_user getcurrentweapon();

    if(player != var_5f6b2789.chest_user && isDefined(var_5f6b2789.var_1f9dff37) && var_5f6b2789.var_1f9dff37 || player != var_5f6b2789.chest_user && !(isDefined(var_5f6b2789.var_481aa649) && var_5f6b2789.var_481aa649) || zm_loadout::is_placeable_mine(wpn_current) || wpn_current.isheroweapon || wpn_current.isgadget || wpn_current.isriotshield || var_5f6b2789.chest_user zm_equipment::hacker_active()) {
      visible = 0;
    }
  } else if(!player can_buy_weapon()) {
    visible = 0;
  }

  if(player bgb::is_enabled(#"zm_bgb_disorderly_combat")) {
    visible = 0;
  }

  if(isDefined(var_5f6b2789.weapon_out) && var_5f6b2789.weapon_out) {
    if(player zm_weapons::has_weapon_or_upgrade(var_5f6b2789.zbarrier.weapon)) {
      return false;
    }
  }

  if(isDefined(level.var_2f57e2d2)) {
    if(!self[[level.var_2f57e2d2]](player)) {
      visible = 0;
    }
  }

  if(!visible) {
    return false;
  }

  self setvisibletoplayer(player);
  return true;
}

magicbox_unitrigger_think() {
  self endon(#"kill_trigger");

  while(true) {
    self.stub.trigger_target notify(#"trigger", self waittill(#"trigger"));
  }
}

play_crazi_sound() {
  self playlocalsound(#"hash_7d764f09cd3dea92");
}

function_2db086bf() {
  self.hidden = 0;
  self.zbarrier.state = "initial";
  level flagsys::wait_till("start_zombie_round_logic");

  if(isDefined(self.zbarrier)) {
    self.zbarrier set_magic_box_zbarrier_state("initial");
    self thread zm_audio::function_ef9ba49c(#"box", 0, -1, 500, array("left", "trigger"));

    if(self.zbarrier.classname === "zbarrier_zm_esc_magicbox") {
      self.zbarrier thread function_ecf6901d();
    } else if(self.zbarrier.script_string === "t8_magicbox") {
      self.zbarrier thread function_504f4fcb();
      self.zbarrier clientfield::set("t8_magicbox_ambient_fx", 1);
    }
  }

  level notify(#"hash_e39eca74fa250b4", {
    #s_magic_box: self
  });
}

show_chest() {
  if(!level.enable_magic || zm_custom::function_901b751c(#"zmmysteryboxstate") == 0) {
    return;
  }

  self.zbarrier set_magic_box_zbarrier_state("arriving");
  self.zbarrier waittilltimeout(5, #"arrived");
  assert(isDefined(level.pandora_show_func), "<dev string:x38>");

  if(isDefined(level.pandora_show_func)) {
    self thread[[level.pandora_show_func]]();
  }

  if(self.zbarrier.script_string !== "t8_magicbox") {
    self.zbarrier clientfield::set("magicbox_closed_fx", 1);
  } else {
    self.zbarrier clientfield::set("t8_magicbox_ambient_fx", 1);
  }

  thread zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, &magicbox_unitrigger_think);
  self.zbarrier clientfield::increment("zbarrier_show_sounds");
  self.hidden = 0;

  if(isDefined(self.box_hacks[#"summon_box"])) {
    self[[self.box_hacks[#"summon_box"]]](0);
  }

  level notify(#"hash_e39eca74fa250b4", {
    #s_magic_box: self
  });
}

hide_chest(doboxleave) {
  if(isDefined(self.unitrigger_stub)) {
    thread zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
  }

  if(isDefined(self.pandora_light)) {
    self.pandora_light delete();
  }

  if(self.zbarrier.script_string === "t8_magicbox") {
    self.zbarrier clientfield::set("t8_magicbox_ambient_fx", 0);
  }

  self.zbarrier clientfield::set("magicbox_closed_fx", 0);
  self.hidden = 1;

  if(isDefined(self.box_hacks) && isDefined(self.box_hacks[#"summon_box"])) {
    self[[self.box_hacks[#"summon_box"]]](1);
  }

  if(isDefined(self.zbarrier)) {
    if(isDefined(doboxleave) && doboxleave) {
      self.zbarrier clientfield::increment("zbarrier_leave_sounds");
      self.zbarrier thread magic_box_zbarrier_leave();

      if(self.zbarrier.script_string === "t8_magicbox") {
        self.zbarrier thread function_c9c4c0f6();
      }

      if(self.zbarrier.state == "leaving") {
        s_result = self.zbarrier waittilltimeout(10, #"left", #"zbarrier_state_change");

        if(s_result._notify !== "left") {
          self.zbarrier notify(#"timeout_away");
          level notify(#"hash_e39eca74fa250b4", {
            #s_magic_box: self
          });
          return;
        }
      }

      if(self.zbarrier.script_string !== "t8_magicbox") {
        if(isDefined(level.var_678333a6)) {
          str_fx = level.var_678333a6;
        } else {
          str_fx = level._effect[#"poltergeist"];
        }

        playFX(str_fx, self.zbarrier.origin, anglestoup(self.zbarrier.angles), anglesToForward(self.zbarrier.angles));
      }
    } else {
      self.zbarrier thread set_magic_box_zbarrier_state("away");
    }
  }

  level notify(#"hash_e39eca74fa250b4", {
    #s_magic_box: self
  });
}

private function_c9c4c0f6() {
  wait 0.5;
  self clientfield::increment("magicbox_leave_fx");
}

default_pandora_fx_func() {
  self endon(#"death");
  self.pandora_light = spawn("script_model", self.zbarrier.origin);
  s_pandora_fx_pos_override = struct::get(self.target, "targetname");

  if(isDefined(s_pandora_fx_pos_override) && s_pandora_fx_pos_override.script_noteworthy === "pandora_fx_pos_override") {
    self.pandora_light.origin = s_pandora_fx_pos_override.origin;
  }

  self.pandora_light.angles = self.zbarrier.angles + (-90, 0, -90);
  self.pandora_light setModel(#"tag_origin");

  if(!(isDefined(level._box_initialized) && level._box_initialized)) {
    level flag::wait_till("start_zombie_round_logic");
    level._box_initialized = 1;
  }

  wait 1;

  if(isDefined(self) && isDefined(self.pandora_light)) {
    if(self.zbarrier.script_string === "t8_magicbox") {
      playFXOnTag(level._effect[#"hash_2ff87d61167ea531"], self.pandora_light, "tag_origin");
      return;
    }

    playFXOnTag(level._effect[#"lght_marker"], self.pandora_light, "tag_origin");
  }
}

default_pandora_show_func(anchor, anchortarget, pieces) {
  if(!isDefined(self.pandora_light)) {
    if(!isDefined(level.pandora_fx_func)) {
      level.pandora_fx_func = &default_pandora_fx_func;
    }

    self thread[[level.pandora_fx_func]]();
  }

  if(self.zbarrier.script_string === "t8_magicbox") {
    playFX(level._effect[#"hash_4048cb4967032c4a"], self.pandora_light.origin);
    return;
  }

  playFX(level._effect[#"lght_marker_flare"], self.pandora_light.origin);
}

function_504f4fcb() {
  self clientfield::set("t8_magicbox_crack_glow_fx", 1);
  self waittill(#"zbarrier_state_change");
  self clientfield::set("t8_magicbox_crack_glow_fx", 0);
}

function_ecf6901d() {
  self clientfield::set("" + #"hash_2fcdae6b889933c7", 1);
  self waittill(#"zbarrier_state_change");
  self clientfield::set("" + #"hash_2fcdae6b889933c7", 0);
}

unregister_unitrigger_on_kill_think() {
  self notify(#"unregister_unitrigger_on_kill_think");
  self endon(#"unregister_unitrigger_on_kill_think");
  self waittill(#"kill_chest_think");
  thread zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
}

treasure_chest_think() {
  self endon(#"kill_chest_think");
  user = undefined;
  user_cost = undefined;
  self.box_rerespun = undefined;
  self.weapon_out = undefined;
  self thread unregister_unitrigger_on_kill_think();

  while(true) {
    if(!isDefined(self.forced_user)) {
      waitresult = self waittill(#"trigger");
      user = waitresult.activator;

      if(user == level || isDefined(user.var_838c00de) && user.var_838c00de) {
        continue;
      }
    } else {
      user = self.forced_user;
    }

    self.var_75c86f89 = undefined;

    if(!user can_buy_weapon() || isDefined(self.disabled) && self.disabled || zm_trial_disable_buys::is_active() || isDefined(self.being_removed) && self.being_removed) {
      wait 0.1;
      continue;
    }

    reduced_cost = undefined;

    if(isDefined(self.auto_open) && zm_utility::is_player_valid(user)) {
      if(!isDefined(self.var_3b8f3332)) {
        user zm_score::minus_to_player_score(self.zombie_cost);
        user_cost = self.zombie_cost;
      } else {
        user_cost = 0;
      }

      self.chest_user = user;
      break;
    } else if(zm_utility::is_player_valid(user) && user zm_score::can_player_purchase(self.zombie_cost)) {
      user zm_score::minus_to_player_score(self.zombie_cost);

      if(user bgb::is_enabled(#"zm_bgb_shopping_free")) {
        user_cost = 0;
      } else {
        user_cost = self.zombie_cost;
      }

      self.chest_user = user;
      break;
    } else if(isDefined(reduced_cost) && user zm_score::can_player_purchase(reduced_cost)) {
      user zm_score::minus_to_player_score(reduced_cost);
      user_cost = reduced_cost;
      self.chest_user = user;
      break;
    } else if(!user zm_score::can_player_purchase(self.zombie_cost)) {
      zm_utility::play_sound_at_pos("no_purchase", self.origin);
      user zm_audio::create_and_play_dialog(#"general", #"outofmoney");
      continue;
    }

    waitframe(1);
  }

  level flag::set("chest_has_been_used");
  demo::bookmark(#"zm_player_use_magicbox", gettime(), user);
  potm::bookmark(#"zm_player_use_magicbox", gettime(), user);
  user zm_stats::increment_client_stat("use_magicbox");
  user zm_stats::increment_player_stat("use_magicbox");
  user zm_stats::increment_challenge_stat(#"survivalist_buy_magic_box", undefined, 1);
  user zm_stats::forced_attachment("boas_use_magicbox");
  user zm_daily_challenges::increment_magic_box();
  user zm_stats::function_c0c6ab19(#"boxbuys", 1, 1);
  user zm_stats::function_c0c6ab19(#"weapons_bought", 1, 1);
  user contracts::increment_zm_contract(#"contract_zm_weapons_bought", 1, #"zstandard");

  if(isplayer(self.chest_user)) {
    self.chest_user util::delay(0, "death", &zm_audio::create_and_play_dialog, #"box", #"interact");
    level notify(#"hash_39b0256c6c9885fc", {
      #e_player: self.chest_user
    });
  }

  self thread watch_for_emp_close();
  self thread zm_trial_disable_buys::function_8327d26e();

  if(isDefined(level.var_f39bb42a)) {
    self thread[[level.var_f39bb42a]]();
  }

  self._box_open = 1;
  self._box_opened_by_fire_sale = 0;

  if(isDefined(zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on")) && zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on") && !isDefined(self.auto_open) && self[[level._zombiemode_check_firesale_loc_valid_func]]()) {
    self._box_opened_by_fire_sale = 1;
  }

  if(zm_custom::function_901b751c(#"zmmysteryboxlimit")) {
    if(!isDefined(level.var_bcd3620a)) {
      level.var_bcd3620a = 0;
    }

    level.var_bcd3620a += 1;

    if(level.var_bcd3620a >= zm_custom::function_901b751c(#"zmmysteryboxlimit")) {
      zm_powerups::powerup_remove_from_regular_drops("fire_sale");
      level thread function_7d384b90();
    }
  }

  if(zm_custom::function_901b751c(#"zmmysteryboxlimitround")) {
    if(level.var_fc02e2df !== level.round_number) {
      level.var_40f4f72d = 1;
      level.var_fc02e2df = level.round_number;
    } else {
      level.var_40f4f72d += 1;
    }
  }

  if(isDefined(self.chest_lid)) {
    self.chest_lid thread treasure_chest_lid_open();
  }

  if(isDefined(self.zbarrier)) {
    self.zbarrier set_magic_box_zbarrier_state("open");
  }

  self.timedout = 0;
  self.weapon_out = 1;
  self.zbarrier thread treasure_chest_weapon_spawn(self, user);

  if(isDefined(level.custom_treasure_chest_glowfx)) {
    self.zbarrier thread[[level.custom_treasure_chest_glowfx]]();
  } else {
    self.zbarrier thread treasure_chest_glowfx();
  }

  thread zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
  self.zbarrier waittill(#"randomization_done", #"box_hacked_respin");

  if(isDefined(user)) {
    if(level flag::get("moving_chest_now") && !self._box_opened_by_fire_sale && isDefined(user_cost)) {
      user zm_score::add_to_player_score(user_cost, 0, "magicbox_bear");
    }
  }

  if(level flag::get("moving_chest_now") && !zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on") && !self._box_opened_by_fire_sale) {
    self thread treasure_chest_move(self.chest_user);
  } else {
    if(!(isDefined(self.unbearable_respin) && self.unbearable_respin) && !(isDefined(self.var_afba7c1f) && self.var_afba7c1f)) {
      if(isDefined(user)) {
        self.grab_weapon_hint = 1;
        self.grab_weapon = self.zbarrier.weapon;
        self.chest_user = user;
        bb::logpurchaseevent(user, self, user_cost, self.grab_weapon, 0, "_magicbox", "_offered");
        weaponidx = undefined;

        if(isDefined(self.grab_weapon)) {
          weaponidx = matchrecordgetweaponindex(self.grab_weapon);
        }

        if(isDefined(weaponidx)) {
          user recordmapevent(10, gettime(), user.origin, level.round_number, weaponidx);
        }

        thread zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, &magicbox_unitrigger_think);

        if(!(isDefined(self.zbarrier.weapon.isheroweapon) && self.zbarrier.weapon.isheroweapon) && zm_utility::get_number_of_valid_players() > 1 && !(isDefined(self.var_1f9dff37) && self.var_1f9dff37)) {
          self thread function_e4dcca48();
        }
      }

      if(isDefined(self.zbarrier) && !(isDefined(self.zbarrier.var_7672d70d) && self.zbarrier.var_7672d70d)) {
        self thread treasure_chest_timeout(user);
      }
    }

    while(!(isDefined(self.var_7672d70d) && self.var_7672d70d) && !(isDefined(self.var_afba7c1f) && self.var_afba7c1f)) {
      waitresult = self waittill(#"trigger");
      grabber = waitresult.activator;
      self.weapon_out = undefined;

      if(isDefined(level.magic_box_grab_by_anyone) && level.magic_box_grab_by_anyone || isDefined(self.var_481aa649) && self.var_481aa649) {
        if(isplayer(grabber)) {
          user = grabber;
        }
      }

      if(isDefined(user)) {
        wpn_current = user getcurrentweapon();

        if(grabber != level && grabber zm_utility::is_drinking() || grabber == user && wpn_current == level.weaponnone || grabber == user && wpn_current.isriotshield) {
          wait 0.1;
          continue;
        }

        if(grabber != level && isDefined(self.box_rerespun) && self.box_rerespun) {
          user = grabber;
        }
      }

      if(grabber == user || grabber == level) {
        self.box_rerespun = undefined;
        current_weapon = level.weaponnone;

        if(zm_utility::is_player_valid(user)) {
          current_weapon = user getcurrentweapon();
        }

        if(grabber == user && zm_utility::is_player_valid(user) && !user zm_utility::is_drinking() && !zm_loadout::is_placeable_mine(current_weapon) && !zm_equipment::is_equipment(current_weapon) && !user zm_utility::is_player_revive_tool(current_weapon) && !current_weapon.isheroweapon && !current_weapon.isgadget) {
          bb::logpurchaseevent(user, self, user_cost, self.zbarrier.weapon, 0, "_magicbox", "_grabbed");
          weaponidx = undefined;

          if(isDefined(self.zbarrier) && isDefined(self.zbarrier.weapon)) {
            weaponidx = matchrecordgetweaponindex(self.zbarrier.weapon);
          }

          if(isDefined(weaponidx)) {
            user recordmapevent(11, gettime(), user.origin, level.round_number, weaponidx);
          }

          self notify(#"user_grabbed_weapon");
          user notify(#"user_grabbed_weapon");
          user thread treasure_chest_give_weapon(self.zbarrier.weapon, self.var_75c86f89, self.zbarrier);
          demo::bookmark(#"zm_player_grabbed_magicbox", gettime(), user);
          potm::bookmark(#"zm_player_grabbed_magicbox", gettime(), user);
          user zm_stats::increment_client_stat("grabbed_from_magicbox");
          user zm_stats::increment_player_stat("grabbed_from_magicbox");
          user zm_stats::forced_attachment("boas_grabbed_from_magicbox");

          if(isDefined(level.var_bb6907a4)) {
            self[[level.var_bb6907a4]](user);
          }

          break;
        } else if(grabber == level) {
          self.timedout = 1;

          if(isDefined(user)) {
            bb::logpurchaseevent(user, self, user_cost, self.zbarrier.weapon, 0, "_magicbox", "_returned");
            weaponidx = undefined;

            if(isDefined(self.zbarrier) && isDefined(self.zbarrier.weapon)) {
              weaponidx = matchrecordgetweaponindex(self.zbarrier.weapon);
            }

            if(isDefined(weaponidx)) {
              user recordmapevent(12, gettime(), user.origin, level.round_number, weaponidx);
            }
          }

          break;
        }
      }

      waitframe(1);
    }

    self.grab_weapon_hint = 0;
    self.zbarrier notify(#"weapon_grabbed");

    if(!(isDefined(self._box_opened_by_fire_sale) && self._box_opened_by_fire_sale)) {
      level.chest_accessed += 1;
    }

    thread zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);

    if(isDefined(self.chest_lid)) {
      self.chest_lid thread treasure_chest_lid_close(self.timedout);
    }

    if(isDefined(self.zbarrier)) {
      self.zbarrier set_magic_box_zbarrier_state("close");
      zm_utility::play_sound_at_pos("close_chest", self.origin);
      self.zbarrier waittill(#"closed");
      wait 1;
    } else {
      wait 3;
    }

    if(isDefined(zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on")) && zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on") && self[[level._zombiemode_check_firesale_loc_valid_func]]() || zm_custom::function_901b751c(#"zmmysteryboxstate") == 3 || zm_custom::function_901b751c(#"zmmysteryboxstate") == 1 || self == level.chests[level.chest_index]) {
      thread zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, &magicbox_unitrigger_think);
    }
  }

  self._box_open = 0;
  self._box_opened_by_fire_sale = 0;
  self.var_afba7c1f = undefined;
  self.unbearable_respin = undefined;
  self.chest_user = undefined;
  self notify(#"chest_accessed");
  level flag::set("chest_weapon_has_been_taken");

  if(zm_custom::function_901b751c(#"zmmysteryboxlimit")) {
    if(level.var_bcd3620a >= zm_custom::function_901b751c(#"zmmysteryboxlimit")) {
      return;
    }
  }

  self thread treasure_chest_think();
}

function_e4dcca48() {
  self.chest_user endon(#"bled_out", #"death");
  self.zbarrier endon(#"weapon_grabbed");
  self.var_481aa649 = 0;
  self.var_c2f3a87c = 0;
  var_369ce419 = self.chest_user;
  var_63f52acb = self.zbarrier.weapon_model;

  if(isDefined(var_63f52acb)) {
    var_63f52acb endon(#"death");
  }

  for(var_1e99deea = undefined; !isDefined(var_1e99deea); var_1e99deea = zm_unitrigger::function_f1794fbf(self.unitrigger_stub, var_369ce419)) {
    util::wait_network_frame();
  }

  var_1e99deea endon(#"kill_trigger");

  while(true) {
    self.var_c2f3a87c = 0;

    if(isDefined(var_369ce419) && isDefined(var_63f52acb)) {
      if(var_369ce419 util::is_looking_at(var_63f52acb)) {
        self.var_c2f3a87c = 1;
      }
    }

    if(isDefined(var_369ce419) && var_369ce419 meleebuttonpressed() && self.var_c2f3a87c && var_369ce419 istouching(var_1e99deea)) {
      self.var_481aa649 = 1;
      self.var_75c86f89 = var_369ce419;

      if(isDefined(var_63f52acb)) {
        var_63f52acb clientfield::set("powerup_fx", 1);
      }

      var_369ce419 thread zm_audio::create_and_play_dialog(#"magicbox", #"share");
      break;
    }

    waitframe(1);
  }
}

watch_for_emp_close() {
  self endon(#"chest_accessed");
  self.var_7672d70d = 0;

  if(!zm_utility::should_watch_for_emp()) {
    return;
  }

  if(isDefined(self.zbarrier)) {
    self.zbarrier.var_7672d70d = 0;
  }

  while(true) {
    waitresult = level waittill(#"emp_detonate");

    if(distancesquared(waitresult.position, self.origin) < waitresult.radius * waitresult.radius) {
      break;
    }
  }

  if(level flag::get("moving_chest_now")) {
    return;
  }

  self.var_7672d70d = 1;

  if(isDefined(self.zbarrier)) {
    self.zbarrier.var_7672d70d = 1;
    self.zbarrier notify(#"box_hacked_respin");

    if(isDefined(self.zbarrier.weapon_model)) {
      self.zbarrier.weapon_model notify(#"kill_weapon_movement");
    }

    if(isDefined(self.zbarrier.weapon_model_dw)) {
      self.zbarrier.weapon_model_dw notify(#"kill_weapon_movement");
    }
  }

  wait 0.1;
  self notify(#"trigger", {
    #activator: level
  });
}

can_buy_weapon(var_5429ee1f = 1) {
  if(!isDefined(self)) {
    return false;
  }

  if(var_5429ee1f && zm_custom::function_901b751c(#"zmmysteryboxlimitround")) {
    if((isDefined(level.var_40f4f72d) ? level.var_40f4f72d : 0) >= zm_custom::function_901b751c(#"zmmysteryboxlimitround")) {
      return false;
    }
  }

  if(self zm_utility::is_drinking()) {
    return false;
  }

  if(self zm_equipment::hacker_active()) {
    return false;
  }

  current_weapon = self getcurrentweapon();

  if(zm_loadout::is_placeable_mine(current_weapon) || zm_equipment::is_equipment_that_blocks_purchase(current_weapon)) {
    return false;
  }

  if(self zm_utility::in_revive_trigger()) {
    return false;
  }

  if(current_weapon == level.weaponnone) {
    return false;
  }

  if(current_weapon.isheroweapon || current_weapon.isgadget || current_weapon.isriotshield) {
    return false;
  }

  if(!self zm_laststand::laststand_has_players_weapons_returned()) {
    return false;
  }

  return true;
}

default_box_move_logic() {
  index = -1;

  for(i = 0; i < level.chests.size; i++) {
    if(issubstr(level.chests[i].script_noteworthy, "move" + level.chest_moves + 1) && i != level.chest_index) {
      index = i;
      break;
    }
  }

  if(index != -1) {
    level.chest_index = index;
  } else {
    level.chest_index++;
  }

  if(level.chest_index >= level.chests.size) {
    temp_chest_name = level.chests[level.chest_index - 1].script_noteworthy;
    level.chest_index = 0;
    level.chests = array::randomize(level.chests);

    if(temp_chest_name == level.chests[level.chest_index].script_noteworthy) {
      level.chest_index++;
    }
  }
}

treasure_chest_move(player_vox) {
  level waittill(#"weapon_fly_away_start");
  players = getplayers();
  array::thread_all(players, &play_crazi_sound);
  level thread function_f81251c9();

  if(isDefined(player_vox)) {
    player_vox thread zm_audio::create_and_play_dialog(#"magicbox", #"move", undefined, 2);
  }

  level waittill(#"weapon_fly_away_end");

  if(isDefined(self.zbarrier)) {
    self hide_chest(1);
  }

  wait 0.1;
  post_selection_wait_duration = 7;

  if(isDefined(level._zombiemode_custom_box_move_logic)) {
    [[level._zombiemode_custom_box_move_logic]]();
  } else {
    default_box_move_logic();
  }

  if(zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on") == 1 && self[[level._zombiemode_check_firesale_loc_valid_func]]()) {
    current_sale_time = zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_time");
    util::wait_network_frame();
    self thread fire_sale_fix();
    zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_time", current_sale_time);

    while(zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_time") > 0) {
      wait 0.1;
    }
  } else {
    post_selection_wait_duration += 5;
  }

  level.verify_chest = 0;

  if(isDefined(level.chests[level.chest_index].box_hacks[#"summon_box"])) {
    level.chests[level.chest_index][[level.chests[level.chest_index].box_hacks[#"summon_box"]]](0);
  }

  wait post_selection_wait_duration;

  if(level.chests[level.chest_index].zbarrier.script_string !== "t8_magicbox") {
    if(isDefined(level.var_678333a6)) {
      str_fx = level.var_678333a6;
    } else {
      str_fx = level._effect[#"poltergeist"];
    }

    playFX(str_fx, level.chests[level.chest_index].zbarrier.origin, anglestoup(level.chests[level.chest_index].zbarrier.angles), anglesToForward(level.chests[level.chest_index].zbarrier.angles));
  }

  level.chests[level.chest_index] show_chest();
  level flag::clear("moving_chest_now");
  self.zbarrier.chest_moving = 0;
}

function_f81251c9() {
  level endon(#"game_over", #"hash_5002eab927d4056d");
  wait 5;
  level thread zm_audio::sndannouncerplayvox(#"boxmove");
}

fire_sale_fix() {
  if(!isDefined(zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on"))) {
    return;
  }

  if(zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on")) {
    self.old_cost = 950;
    self thread show_chest();
    self.zombie_cost = 10;
    zm_unitrigger::function_413f9fcf(self.unitrigger_stub, self, "default_treasure_chest", self.zombie_cost);
    util::wait_network_frame();
    level waittill(#"fire_sale_off");

    for(i = 0; i < level.chests.size; i++) {
      if(i == level.chest_index) {
        level.chests[i].was_temp = undefined;
        continue;
      }

      level.chests[i].was_temp = 1;
    }

    while(isDefined(self._box_open) && self._box_open) {
      wait 0.1;
    }

    self.zombie_cost = self.old_cost;
    self hide_chest(1);
  }
}

check_for_desirable_chest_location() {
  if(!isDefined(level.desirable_chest_location)) {
    return level.chest_index;
  }

  if(level.chests[level.chest_index].script_noteworthy == level.desirable_chest_location) {
    level.desirable_chest_location = undefined;
    return level.chest_index;
  }

  for(i = 0; i < level.chests.size; i++) {
    if(level.chests[i].script_noteworthy == level.desirable_chest_location) {
      level.desirable_chest_location = undefined;
      return i;
    }
  }

  iprintln(level.desirable_chest_location + "<dev string:x54>");

    level.desirable_chest_location = undefined;
  return level.chest_index;
}

rotateroll_box() {
  angles = 40;
  angles2 = 0;

  while(isDefined(self)) {
    self rotateroll(angles + angles2, 0.5);
    wait 0.7;
    angles2 = 40;
    self rotateroll(angles * -2, 0.5);
    wait 0.7;
  }
}

verify_chest_is_open() {
  for(i = 0; i < level.open_chest_location.size; i++) {
    if(isDefined(level.open_chest_location[i])) {
      if(level.open_chest_location[i] == level.chests[level.chest_index].script_noteworthy) {
        level.verify_chest = 1;
        return;
      }
    }
  }

  level.verify_chest = 0;
}

treasure_chest_timeout(user) {
  self endon(#"user_grabbed_weapon");
  self.zbarrier endon(#"box_hacked_respin", #"box_hacked_rerespin");
  n_timeout = isDefined(level.var_ad2674fe) ? level.var_ad2674fe : 12;
  wait n_timeout;
  self notify(#"trigger", {
    #activator: level
  });

  if(isDefined(user)) {
    if(isDefined(level.var_bb6907a4)) {
      self[[level.var_bb6907a4]](user);
    }
  }
}

treasure_chest_lid_open() {
  openroll = 105;
  opentime = 0.5;
  self rotateroll(105, opentime, opentime * 0.5);
}

treasure_chest_lid_close(timedout) {
  closeroll = -105;
  closetime = 0.5;
  self rotateroll(closeroll, closetime, closetime * 0.5);
  self notify(#"lid_closed");
}

function_db355791(player, weapon, var_21b5a3f4 = 1) {
  if(!isDefined(player)) {
    return 0;
  }

  if(!isDefined(player.var_16fc6934)) {
    if(var_21b5a3f4 && isinarray(player.var_ca56e806, weapon)) {
      return 0;
    }

    if(!zm_weapons::get_is_in_box(weapon)) {
      return 0;
    }
  }

  if(player zm_weapons::has_weapon_or_upgrade(weapon)) {
    return 0;
  }

  if(!player zm_weapons::player_can_use_content(weapon)) {
    return 0;
  }

  if(isDefined(level.custom_magic_box_selection_logic) && ![[level.custom_magic_box_selection_logic]](weapon, player)) {
    return 0;
  }

  if(weapon.name == #"ray_gun" && player zm_weapons::has_weapon_or_upgrade(getweapon(#"raygun_mark2"))) {
    return 0;
  }

  if(isDefined(level.special_weapon_magicbox_check)) {
    return player[[level.special_weapon_magicbox_check]](weapon);
  }

  if(!zm_weapons::limited_weapon_below_quota(weapon, player)) {
    return 0;
  }

  if(zm_weapons::is_wonder_weapon(weapon) && !zm_custom::function_901b751c(#"zmwonderweaponisenabled")) {
    return 0;
  }

  if(isinarray(level.var_cbc6587a, weapon)) {
    return 0;
  }

  return 1;
}

function_4aa1f177(player) {
  a_weapons = array::randomize(getarraykeys(level.zombie_weapons));
  var_b865ddb7 = a_weapons[0];
  w_second = a_weapons[1];

  if(isDefined(player)) {
    if(!isDefined(player.var_ca56e806)) {
      player.var_ca56e806 = [];
    } else if(!isarray(player.var_ca56e806)) {
      player.var_ca56e806 = array(player.var_ca56e806);
    }

    if(isDefined(level.customrandomweaponweights)) {
      a_weapons = player[[level.customrandomweaponweights]](a_weapons);
    }

    if(isDefined(player.var_afb3ba4e)) {
      a_weapons = player[[player.var_afb3ba4e]](a_weapons);
    }

    if(isDefined(player.var_16fc6934)) {
      if(isDefined(player.var_61c96978)) {
        player thread[[player.var_61c96978]](self);
      }

      arrayinsert(a_weapons, player.var_16fc6934, 0);
    }
  }

  forced_weapon_name = getdvarstring(#"scr_force_weapon");
  forced_weapon = getweapon(forced_weapon_name);

  if(forced_weapon_name != "<dev string:x73>" && isDefined(level.zombie_weapons[forced_weapon])) {
    arrayinsert(a_weapons, forced_weapon, 0);
  }

    if(isDefined(player)) {
      if(a_weapons[0] === var_b865ddb7 && a_weapons[1] === w_second) {
        var_d07a7ff9 = 1;
        var_bf43f78f = randomfloat(100);

        if(var_bf43f78f > 89) {
          var_1b439d59 = array(7);
        } else if(var_bf43f78f > 74) {
          var_1b439d59 = array(6);
        } else if(var_bf43f78f > 57) {
          var_1b439d59 = array(5);
        } else if(var_bf43f78f > 33) {
          var_1b439d59 = array(4);
        } else if(var_bf43f78f > 18) {
          var_1b439d59 = array(3);
        } else if(var_bf43f78f > 8) {
          var_1b439d59 = array(1, 2);
        } else {
          var_1b439d59 = array(0);
        }
      } else {
        var_d07a7ff9 = 0;
      }

      foreach(weapon in a_weapons) {
        if(var_d07a7ff9) {
          var_7ed75e97 = level.zombie_weapons[weapon].tier;

          if(!isinarray(var_1b439d59, var_7ed75e97)) {
            continue;
          }
        }

        if(function_db355791(player, weapon)) {
          return weapon;
        }
      }

      foreach(weapon in a_weapons) {
        if(function_db355791(player, weapon, 0)) {
          return weapon;
        }
      }
    }

  return level.weaponnone;
}

weapon_show_hint_choke() {
  level._weapon_show_hint_choke = 0;

  while(true) {
    waitframe(1);
    level._weapon_show_hint_choke = 0;
  }
}

decide_hide_show_hint(endon_notify, second_endon_notify, onlyplayer, can_buy_weapon_extra_check_func, var_5429ee1f = 1) {
  self endon(#"death");

  if(isDefined(endon_notify)) {
    self endon(endon_notify);
  }

  if(isDefined(second_endon_notify)) {
    self endon(second_endon_notify);
  }

  if(!isDefined(level._weapon_show_hint_choke)) {
    level thread weapon_show_hint_choke();
  }

  use_choke = 0;

  if(isDefined(level._use_choke_weapon_hints) && level._use_choke_weapon_hints == 1) {
    use_choke = 1;
  }

  while(true) {
    last_update = gettime();

    if(isDefined(self.chest_user) && !isDefined(self.box_rerespun)) {
      if(zm_loadout::is_placeable_mine(self.chest_user getcurrentweapon()) || self.chest_user zm_equipment::hacker_active()) {
        self setinvisibletoplayer(self.chest_user);
      } else {
        self setvisibletoplayer(self.chest_user);
      }
    } else if(isDefined(onlyplayer)) {
      if(onlyplayer can_buy_weapon(var_5429ee1f) && (!isDefined(can_buy_weapon_extra_check_func) || onlyplayer[[can_buy_weapon_extra_check_func]](self.weapon)) && !onlyplayer bgb::is_enabled(#"zm_bgb_disorderly_combat")) {
        self setinvisibletoplayer(onlyplayer, 0);
      } else {
        self setinvisibletoplayer(onlyplayer, 1);
      }
    } else {
      players = getplayers();

      for(i = 0; i < players.size; i++) {
        if(players[i] can_buy_weapon(var_5429ee1f) && (!isDefined(can_buy_weapon_extra_check_func) || players[i][
            [can_buy_weapon_extra_check_func]
          ](self.weapon)) && !players[i] bgb::is_enabled(#"zm_bgb_disorderly_combat")) {
          self setinvisibletoplayer(players[i], 0);
          continue;
        }

        self setinvisibletoplayer(players[i], 1);
      }
    }

    if(use_choke) {
      while(level._weapon_show_hint_choke > 4 && gettime() < last_update + 150) {
        waitframe(1);
      }
    } else {
      wait 0.1;
    }

    level._weapon_show_hint_choke++;
  }
}

get_left_hand_weapon_model_name(weapon) {
  dw_weapon = weapon.dualwieldweapon;

  if(dw_weapon != level.weaponnone) {
    return dw_weapon.worldmodel;
  }

  return weapon.worldmodel;
}

clean_up_hacked_box() {
  self waittill(#"box_hacked_respin");
  self endon(#"box_spin_done");

  if(isDefined(self.weapon_model)) {
    self.weapon_model delete();
    self.weapon_model = undefined;
  }

  if(isDefined(self.weapon_model_dw)) {
    self.weapon_model_dw delete();
    self.weapon_model_dw = undefined;
  }

  self hidezbarrierpiece(3);
  self hidezbarrierpiece(4);
  self setzbarrierpiecestate(3, "closed");
  self setzbarrierpiecestate(4, "closed");
}

treasure_chest_firesale_active() {
  return isDefined(zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on")) && zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on");
}

treasure_chest_should_move(chest, player) {
  if(getdvarint(#"magic_chest_movable", 0) && !(isDefined(chest._box_opened_by_fire_sale) && chest._box_opened_by_fire_sale) && !treasure_chest_firesale_active() && self[[level._zombiemode_check_firesale_loc_valid_func]]() && !(isDefined(player.var_c21099c0) && player.var_c21099c0)) {
    random = randomint(100);
    chance_of_joker = 0;

    if(zm_trial::is_trial_mode()) {
      if(level.chest_accessed >= 3 || isDefined(level.var_bb641599) && level.var_bb641599) {
        return true;
      }
    }

    if(!isDefined(level.chest_min_move_usage)) {
      level.chest_min_move_usage = 4;

      if(zm_custom::function_901b751c(#"zmmysteryboxlimitmove")) {
        if(zm_custom::function_901b751c(#"zmmysteryboxlimitmove") < 4) {
          level.chest_min_move_usage = zm_custom::function_901b751c(#"zmmysteryboxlimitmove") - 1;
        }
      }
    }

    if(level.chest_accessed < level.chest_min_move_usage) {
      chance_of_joker = -1;
    }

    if(zm_custom::function_901b751c(#"zmmysteryboxlimitmove")) {
      var_4066429c = level.chest_accessed - zm_custom::function_901b751c(#"zmmysteryboxlimitmove") * level.chest_moves;

      if(level.chest_accessed >= zm_custom::function_901b751c(#"zmmysteryboxlimitmove")) {
        chance_of_joker = 100;
      } else {
        chance_of_joker = -1;
      }
    } else if(chance_of_joker >= 0) {
      chance_of_joker = level.chest_accessed + 20;

      if(level.chest_moves == 0 && level.chest_accessed >= 8) {
        chance_of_joker = 100;
      }

      if(level.chest_accessed >= 4 && level.chest_accessed < 8) {
        if(random < 15) {
          chance_of_joker = 100;
        } else {
          chance_of_joker = -1;
        }
      }

      if(level.chest_moves > 0) {
        if(level.chest_accessed >= 8 && level.chest_accessed < 13) {
          if(random < 30) {
            chance_of_joker = 100;
          } else {
            chance_of_joker = -1;
          }
        }

        if(level.chest_accessed >= 13) {
          if(random < 50) {
            chance_of_joker = 100;
          } else {
            chance_of_joker = -1;
          }
        }
      }
    }

    if(isDefined(chest.no_fly_away)) {
      chance_of_joker = -1;
    }

    if(isDefined(level.var_b0344a3c)) {
      chance_of_joker = [
        [level.var_b0344a3c]
      ](chance_of_joker);
    }

    if(isDefined(level.var_401aaa92) && level.var_401aaa92) {
      level.var_401aaa92 = 0;
      chance_of_joker = 100;
    }

    if(chance_of_joker > random) {
      return true;
    }
  }

  return false;
}

spawn_joker_weapon_model(player, model, origin, angles) {
  weapon_model = spawn("script_model", origin);

  if(isDefined(angles)) {
    weapon_model.angles = angles;
  }

  weapon_model setModel(model);
  return weapon_model;
}

treasure_chest_weapon_locking(player, weapon, onoff) {
  if(isDefined(self.locked_model)) {
    self.locked_model delete();
    self.locked_model = undefined;
  }

  if(onoff) {
    if(weapon == level.weaponnone) {
      self.locked_model = spawn_joker_weapon_model(player, level.chest_joker_model, self.origin, (0, 0, 0));
    } else if(isDefined(player)) {
      self.locked_model = zm_utility::spawn_buildkit_weapon_model(player, weapon, undefined, self.origin, (0, 0, 0));

      if(!isDefined(player.var_ca56e806)) {
        player.var_ca56e806 = [];
      } else if(!isarray(player.var_ca56e806)) {
        player.var_ca56e806 = array(player.var_ca56e806);
      }

      if(!isinarray(player.var_ca56e806, weapon)) {
        player.var_ca56e806[player.var_ca56e806.size] = weapon;
      }

      if(player.var_ca56e806.size > 8) {
        arrayremoveindex(player.var_ca56e806, 0);
      }
    } else {
      self.locked_model = util::spawn_model(weapon.worldmodel, self.origin, (0, 0, 0));
    }

    self.locked_model ghost();
    self.locked_model clientfield::set("force_stream", 1);
  }
}

treasure_chest_weapon_spawn(chest, player, respin) {
  if(isDefined(level.var_555605da)) {
    self.owner endon(#"box_locked");
    self thread[[level.var_555605da]]();
  }

  self endon(#"box_hacked_respin");
  self thread clean_up_hacked_box();
  assert(isDefined(player));
  self.chest_moving = 0;
  move_the_box = treasure_chest_should_move(chest, player);
  preferred_weapon = undefined;

  if(move_the_box) {
    preferred_weapon = level.weaponnone;
  } else {
    preferred_weapon = function_4aa1f177(player);
  }

  chest treasure_chest_weapon_locking(player, preferred_weapon, 1);
  self.weapon = level.weaponnone;
  modelname = undefined;
  rand = undefined;
  var_943077fe = isDefined(level.var_3ba4b305) ? level.var_3ba4b305 : 40;

  if(player hasperk(#"specialty_cooldown")) {
    var_943077fe = min(var_943077fe, 10);
  }

  var_f91a62a4 = 1;

  if(var_943077fe < 40) {
    var_f91a62a4 = var_943077fe / 40;
  }

  assert(var_f91a62a4 >= 0.1 && var_f91a62a4 <= 2, "<dev string:x76>");

  if(isDefined(chest.zbarrier)) {
    if(isDefined(level.custom_magic_box_do_weapon_rise)) {
      chest.zbarrier thread[[level.custom_magic_box_do_weapon_rise]]();
    } else {
      chest.zbarrier thread magic_box_do_weapon_rise(var_f91a62a4);
    }
  }

  for(i = 0; i < var_943077fe; i++) {
    if(i < var_943077fe * 0.5) {
      waitframe(1);
      continue;
    }

    if(i < var_943077fe * 0.75) {
      wait 0.1;
      continue;
    }

    if(i < var_943077fe * 0.875) {
      wait 0.2;
      continue;
    }

    if(i < var_943077fe * 0.95) {
      wait 0.3;
    }
  }

  if(isDefined(level.var_9e2df930)) {
    [[level.var_9e2df930]]();
  }

  if(!move_the_box && preferred_weapon == level.weaponnone) {
    if(isDefined(player)) {
      player iprintlnbold(#"zombie/magic_box_empty");
    }

    wait 1;

    if(isDefined(player)) {
      player zm_score::add_to_player_score(self.owner.zombie_cost, 0, "magicbox_bear");
    }

    self.owner.var_afba7c1f = 1;
    self notify(#"randomization_done");
    return;
  }

  new_firesale = move_the_box && treasure_chest_firesale_active();

  if(new_firesale) {
    move_the_box = 0;
    preferred_weapon = function_4aa1f177(player);
  }

  if(!move_the_box && function_db355791(player, preferred_weapon, 0)) {
    rand = preferred_weapon;
  } else {
    rand = function_4aa1f177(player);
  }

  if(rand == level.weaponnone) {
    if(isDefined(player)) {
      player iprintlnbold(#"zombie/magic_box_empty");
    }

    wait 1;

    if(isDefined(player)) {
      player zm_score::add_to_player_score(self.owner.zombie_cost, 0, "magicbox_bear");
    }

    self.owner.var_afba7c1f = 1;
    self notify(#"randomization_done");
    return;
  }

  self.weapon = rand;

  if(!move_the_box && rand === getweapon(#"homunculus")) {
    self thread zm_vo::vo_say(#"hash_770c96a35322e11d", 0, 0, 0, 1);
  }

  if(isDefined(level.func_magicbox_weapon_spawned)) {
    self thread[[level.func_magicbox_weapon_spawned]](self.weapon);
  }

  wait 0.1;

  if(isDefined(level.custom_magicbox_float_height)) {
    v_float = anglestoup(self.angles) * level.custom_magicbox_float_height;
  } else {
    v_float = anglestoup(self.angles) * 40;
  }

  self.model_dw = undefined;

  if(isDefined(player)) {
    self.weapon_model = zm_utility::spawn_buildkit_weapon_model(player, rand, undefined, self.origin + v_float, (self.angles[0] * -1, self.angles[1] + 180, self.angles[2] * -1));
  } else {
    self.weapon_model = util::spawn_model(rand.worldmodel, self.origin + v_float, (self.angles[0] * -1, self.angles[1] + 180, self.angles[2] * -1));
  }

  if(rand.isdualwield) {
    dweapon = rand;

    if(isDefined(rand.dualwieldweapon) && rand.dualwieldweapon != level.weaponnone) {
      dweapon = rand.dualwieldweapon;
    }

    if(isDefined(player)) {
      self.weapon_model_dw = zm_utility::spawn_buildkit_weapon_model(player, dweapon, undefined, self.weapon_model.origin - (3, 3, 3), self.weapon_model.angles);
    } else {
      self.weapon_model_dw = util::spawn_model(dweapon.worldmodel, self.weapon_model.origin - (3, 3, 3), self.weapon_model.angles);
    }
  }

  if(move_the_box && !(zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on") && self[[level._zombiemode_check_firesale_loc_valid_func]]())) {
    self.weapon_model setModel(level.chest_joker_model);

    if(isDefined(self.weapon_model_dw)) {
      self.weapon_model_dw delete();
      self.weapon_model_dw = undefined;
    }

    if(isplayer(chest.chest_user)) {
      if(chest.chest_user bgb::is_enabled(#"zm_bgb_unbearable")) {
        level.chest_accessed = 0;
        chest.unbearable_respin = 1;
        chest.chest_user notify(#"zm_bgb_unbearable", {
          #chest: chest
        });
        chest waittill(#"forever");
      } else {
        chest.chest_user contracts::increment_zm_contract(#"contract_zm_move_box");
      }
    }

    if(self.script_string === "t8_magicbox") {
      self thread function_29a783a6();
    }

    self.chest_moving = 1;
    level flag::set("moving_chest_now");
    level.chest_accessed = 0;
    level.chest_moves++;
  }

  self notify(#"randomization_done");

  if(isDefined(self.chest_moving) && self.chest_moving) {
    if(isDefined(level.chest_joker_custom_movement)) {
      self thread[[level.chest_joker_custom_movement]]();
    } else {
      if(isDefined(self.weapon_model)) {
        v_origin = self.weapon_model.origin;
        self.weapon_model delete();
      }

      self.weapon_model = spawn("script_model", v_origin);
      self.weapon_model setModel(level.chest_joker_model);
      self.weapon_model.angles = self.angles + (0, 180, 0);
      wait 0.5;
      level notify(#"weapon_fly_away_start");
      wait 2;

      if(isDefined(self.weapon_model)) {
        v_fly_away = self.origin + anglestoup(self.angles) * 500;
        self.weapon_model moveto(v_fly_away, 4, 3);
      }

      if(isDefined(self.weapon_model_dw)) {
        v_fly_away = self.origin + anglestoup(self.angles) * 500;
        self.weapon_model_dw moveto(v_fly_away, 4, 3);
      }

      if(isDefined(self.weapon_model)) {
        self.weapon_model waittill(#"movedone");
        self.weapon_model delete();
      }

      if(isDefined(self.weapon_model_dw)) {
        self.weapon_model_dw delete();
        self.weapon_model_dw = undefined;
      }

      self notify(#"box_moving");
      level notify(#"weapon_fly_away_end");
    }
  } else {
    if(!isDefined(respin)) {
      if(isDefined(chest.box_hacks[#"respin"])) {
        self[[chest.box_hacks[#"respin"]]](chest, player);
      }
    } else if(isDefined(chest.box_hacks[#"respin_respin"])) {
      self[[chest.box_hacks[#"respin_respin"]]](chest, player);
    }

    if(isDefined(level.custom_magic_box_timer_til_despawn)) {
      self.weapon_model thread[[level.custom_magic_box_timer_til_despawn]](self);
    } else {
      self.weapon_model thread timer_til_despawn(v_float);
    }

    if(isDefined(self.weapon_model_dw)) {
      if(isDefined(level.custom_magic_box_timer_til_despawn)) {
        self.weapon_model_dw thread[[level.custom_magic_box_timer_til_despawn]](self);
      } else {
        self.weapon_model_dw thread timer_til_despawn(v_float);
      }
    }

    self waittill(#"weapon_grabbed");
    self thread zm_vo::vo_stop();

    if(!chest.timedout) {
      if(isDefined(self.weapon_model)) {
        self.weapon_model delete();
      }

      if(isDefined(self.weapon_model_dw)) {
        self.weapon_model_dw delete();
      }
    }
  }

  chest treasure_chest_weapon_locking(player, preferred_weapon, 0);
  self.weapon = level.weaponnone;
  self notify(#"box_spin_done");
}

function_f5503c41() {
  v_origin = self.origin;

  if(isDefined(self.weapon_model)) {
    self.weapon_model delete();
  }

  self.weapon_model = util::spawn_model(level.chest_joker_model, v_origin, self.angles);
  self.weapon_model scene::init("p8_fxanim_zm_zod_magic_box_skull_drop_bundle", self.weapon_model);
  wait 0.5;
  level notify(#"weapon_fly_away_start");

  if(isDefined(self.weapon_model)) {
    self.weapon_model scene::play("p8_fxanim_zm_zod_magic_box_skull_drop_bundle", self.weapon_model);
  }

  if(isDefined(self.weapon_model)) {
    self.weapon_model delete();
  }

  self notify(#"box_moving");
  level notify(#"weapon_fly_away_end");
}

chest_get_min_usage() {
  min_usage = 4;
  return min_usage;
}

chest_get_max_usage() {
  max_usage = 6;
  players = getplayers();

  if(level.chest_moves == 0) {
    if(players.size == 1) {
      max_usage = 3;
    } else if(players.size == 2) {
      max_usage = 4;
    } else if(players.size == 3) {
      max_usage = 5;
    } else {
      max_usage = 6;
    }
  } else if(players.size == 1) {
    max_usage = 4;
  } else if(players.size == 2) {
    max_usage = 4;
  } else if(players.size == 3) {
    max_usage = 5;
  } else {
    max_usage = 7;
  }

  return max_usage;
}

timer_til_despawn(v_float) {
  self endon(#"kill_weapon_movement");

  if(#"hash_30b0badbca0a10de" === self.model) {
    self.angles = (self.angles[0] + 90, self.angles[1], self.angles[2]);
  }

  var_3be81b3b = isDefined(level.var_ad2674fe) ? level.var_ad2674fe : 12;
  self moveto(self.origin - v_float * 0.85, var_3be81b3b, var_3be81b3b * 0.5);
  wait var_3be81b3b;

  if(isDefined(self)) {
    self delete();
  }
}

treasure_chest_glowfx() {
  self clientfield::set("magicbox_open_fx", 1);
  self clientfield::set("magicbox_closed_fx", 0);
  ret_val = self waittill(#"weapon_grabbed", #"box_moving");
  self clientfield::set("magicbox_open_fx", 0);

  if(self.script_string !== "t8_magicbox") {
    if("box_moving" != ret_val._notify) {
      self clientfield::set("magicbox_closed_fx", 1);
    }
  }
}

treasure_chest_give_weapon(weapon, var_75c86f89, e_chest) {
  self.last_box_weapon = gettime();

  if(should_upgrade_weapon(self, weapon)) {
    if(self zm_weapons::can_upgrade_weapon(weapon)) {
      weapon = zm_weapons::get_upgrade_weapon(weapon);
      self notify(#"zm_bgb_crate_power_used");
    }
  }

  if(weapon.name == #"ray_gun" || weapon.name == #"ray_gun_mk2") {
    playsoundatposition(#"mus_raygun_stinger", (0, 0, 0));
    str_vo_line = #"raygun";

    if(weapon.name == #"ray_gun_mk2" && zm_audio::function_63f85f39(#"magicbox", #"raygun_mk2")) {
      str_vo_line = #"raygun_mk2";
    }
  } else if(weapon.name == #"music_box") {
    str_vo_line = #"music_box";
  } else if(zm_weapons::is_wonder_weapon(weapon)) {
    str_vo_line = #"wonder";

    if(isplayer(var_75c86f89) && var_75c86f89 != self) {
      var_75c86f89 zm_utility::giveachievement_wrapper("zm_trophy_straw_purchase");
    }
  } else if(weapon === getweapon(#"homunculus") || weapon === getweapon(#"cymbal_monkey")) {
    str_vo_line = #"homunculus";
  } else if(weapon === getweapon(#"special_ballisticknife_t8_dw")) {
    if(zm_audio::function_63f85f39(#"magicbox", #"ballistic")) {
      str_vo_line = #"ballistic";
    }
  } else if(weapon === getweapon(#"special_crossbow_t8")) {
    if(zm_audio::function_63f85f39(#"magicbox", #"hash_36b817536004725")) {
      str_vo_line = #"hash_36b817536004725";
    }
  } else {
    switch (weapon.weapclass) {
      case #"mg":
        str_vo_line = #"lmg";
        break;
      case #"spread":
        str_vo_line = #"shotgun";
        break;
      case #"pistol":
        str_vo_line = #"pistol";
        break;
      case #"rocketlauncher":
        str_vo_line = #"launcher";
        break;
      case #"smg":
        str_vo_line = #"smg";
        break;
      case #"rifle":
        if(weapon.issniperweapon) {
          str_vo_line = #"sniper";
        } else if(zm_weapons::is_tactical_rifle(weapon)) {
          str_vo_line = #"tactical";
        } else {
          str_vo_line = #"ar";
        }

        break;
      default:
        break;
    }
  }

  if(isDefined(level.var_210f9911)) {
    str_vo_line = [[level.var_210f9911]](weapon, str_vo_line);
  }

  if(isDefined(str_vo_line)) {
    if(str_vo_line == #"homunculus") {
      self thread function_e62595c2(e_chest);
    } else {
      self thread zm_audio::create_and_play_dialog(#"magicbox", str_vo_line);
    }
  }

  if(zm_loadout::is_hero_weapon(weapon) && !self hasweapon(weapon)) {
    self give_hero_weapon(weapon);
  } else if(zm_loadout::is_offhand_weapon(weapon)) {
    self give_offhand_weapon(weapon);
  } else {
    self.var_966bfd1b = 1;
    w_give = self zm_weapons::weapon_give(weapon);
  }

  self contracts::increment_zm_contract(#"contract_zm_magicbox", 1, #"zstandard");
  self callback::callback(#"hash_7d40e25056b9275c", weapon);
}

private function_e62595c2(e_chest) {
  e_chest zm_vo::vo_stop();
  b_said = zm_vo::vo_say(#"hash_6364370b57ccf050" + zm_vo::function_82f9bc9f() + "_homu");

  if(isDefined(b_said) && b_said) {
    wait 1;
  }

  zm_audio::create_and_play_dialog(#"magicbox", #"homunculus");
}

give_hero_weapon(weapon) {
  self zm_hero_weapon::hero_give_weapon(weapon, 0);
  self zm_hero_weapon::function_23978edd();
}

give_offhand_weapon(weapon) {
  offhandslot = 0;

  if(isDefined(self._gadgets_player[offhandslot])) {
    self takeweapon(self._gadgets_player[offhandslot]);
  }

  if(isDefined(self._gadgets_player[1])) {
    if(self gadgetpowerget(1) === 100) {
      self playsoundtoplayer(#"hash_5069ed8fdae493ce", self);
    }
  }

  self giveweapon(weapon);
  self zm_audio::create_and_play_dialog(#"magicbox", #"offhand");
  waitframe(1);
  slot = self gadgetgetslot(weapon);
  self gadgetpowerset(slot, 100);
  self gadgetcharging(slot, 0);
}

should_upgrade_weapon(player, weapon) {
  if(isDefined(level.magicbox_should_upgrade_weapon_override)) {
    return [[level.magicbox_should_upgrade_weapon_override]](player, weapon);
  }

  if(player bgb::is_enabled(#"zm_bgb_crate_power")) {
    return 1;
  }

  return 0;
}

function_4873c058() {
  level endon(#"end_game");

  if(getdvarint(#"hash_69310927ddaeaa87", 0)) {
    return;
  }

    var_3208e12a = 0;

  foreach(chest in level.chests) {
    if(chest.zbarrier.script_string === "t8_magicbox") {
      var_3208e12a = 1;

      if(!isDefined(chest.zone_name)) {
        var_bbab3105 = vectornormalize(anglestoright(chest.zbarrier.angles)) * -64;
        chest.zone_name = zm_zonemgr::get_zone_from_position(chest.zbarrier.origin + var_bbab3105, 1);
        n_z_offset = 8;

        while(!isDefined(chest.zone_name) && n_z_offset <= 64) {
          chest.zone_name = zm_zonemgr::get_zone_from_position(chest.zbarrier.origin + var_bbab3105 + (0, 0, n_z_offset), 1);
          n_z_offset += 8;
        }

        if(!isDefined(chest.zone_name)) {
          assert(0, "<dev string:xaf>" + chest.zbarrier.origin + "<dev string:xd9>");
        }
      }
    }
  }

  if(!var_3208e12a) {
    return;
  }

  level.var_9c9ba8d5 = 0;
  var_f6497afb = 0;

  while(true) {
    a_players = getplayers();
    var_27bcd4e3 = 0;

    foreach(chest in level.chests) {
      if(!var_27bcd4e3 && (!(isDefined(chest.hidden) && chest.hidden) || chest.zbarrier.state === "arriving" || chest.zbarrier.state === "leaving") && isDefined(chest.zone_name)) {
        foreach(e_player in a_players) {
          if(zm_utility::is_player_valid(e_player)) {
            var_59d93ce2 = isDefined(e_player.zone_name) ? hash(e_player.zone_name) : e_player.zone_name;

            if(isDefined(var_59d93ce2) && (e_player.zone_name === chest.zone_name || isinarray(zm_cleanup::get_adjacencies_to_zone(chest.zone_name), var_59d93ce2))) {
              var_cee14c79 = level.var_9c9ba8d5 ? 16000000 : 9000000;

              if(distancesquared(e_player.origin, chest.origin) < var_cee14c79) {
                var_27bcd4e3 = 1;
                break;
              }
            }
          }
        }
      }
    }

    if(var_27bcd4e3 && !level.var_9c9ba8d5) {
      level.var_9c9ba8d5 = 1;
      level.chests[0].zbarrier clientfield::set("force_stream_magicbox", 1);
    }

    if(!var_27bcd4e3 && level.var_9c9ba8d5) {
      level.var_9c9ba8d5 = 0;
      level.chests[0].zbarrier clientfield::set("force_stream_magicbox", 0);
    }

    if(level.var_9c9ba8d5) {
      var_f6497afb += 0.3;

      if(var_f6497afb > 120) {
        level.var_9c9ba8d5 = 0;
        var_f6497afb = 0;
      }
    } else {
      var_f6497afb = 0;
    }

    wait 0.3;
  }
}

function_29a783a6() {
  level.chests[0].zbarrier clientfield::set("force_stream_magicbox_leave", 1);
  self function_50b92d6a(60);
  level.chests[0].zbarrier clientfield::set("force_stream_magicbox_leave", 0);
}

function_50b92d6a(n_timeout) {
  if(isDefined(n_timeout)) {
    __s = spawnStruct();
    __s endon(#"timeout");
    __s util::delay_notify(n_timeout, "timeout");
  }

  do {
    s_notify = level waittill(#"hash_e39eca74fa250b4");
  }
  while(s_notify.s_magic_box.zbarrier == self || s_notify.s_magic_box != level.chests[level.chest_index]);
}

magic_box_do_weapon_rise(var_f91a62a4) {
  self endon(#"box_hacked_respin");
  self setzbarrierpiecestate(3, "closed");
  self setzbarrierpiecestate(4, "closed");
  util::wait_network_frame();
  self zbarrierpieceuseboxriselogic(3);
  self zbarrierpieceuseboxriselogic(4);
  self showzbarrierpiece(3);
  self showzbarrierpiece(4);
  self setzbarrierpiecestate(3, "opening", var_f91a62a4);
  self setzbarrierpiecestate(4, "opening", var_f91a62a4);

  if(var_f91a62a4 != 1) {
    self playSound(#"hash_59a4ec7cb3de7d13");
    self waittill(#"randomization_done");
    self setzbarrierpiecestate(3, "open");
    self setzbarrierpiecestate(4, "open");
  } else {
    self playSound(#"hash_1530a7e6184b9b2e");

    while(self getzbarrierpiecestate(3) != "open") {
      wait 0.5;
    }
  }

  self hidezbarrierpiece(3);
  self hidezbarrierpiece(4);
}

magic_box_do_teddy_flyaway() {
  self showzbarrierpiece(3);
  self setzbarrierpiecestate(3, "closing");
}

is_chest_active() {
  curr_state = self.zbarrier get_magic_box_zbarrier_state();

  if(level flag::get("moving_chest_now")) {
    return false;
  }

  if(curr_state == "open" || curr_state == "close") {
    return true;
  }

  return false;
}

function_15cd8d85() {
  self endon(#"zbarrier_state_change");
  self setzbarrierpiecestate(0, "closed");

  if(self.script_string !== "t8_magicbox") {
    while(true) {
      wait randomfloatrange(180, 1800);
      self setzbarrierpiecestate(0, "opening");
      wait randomfloatrange(180, 1800);
      self setzbarrierpiecestate(0, "closing");
    }
  }
}

function_f6a827d1() {
  self setzbarrierpiecestate(1, "opening");

  if(self.script_string !== "t8_magicbox") {
    self clientfield::set("magicbox_closed_fx", 1);
  }
}

magic_box_zbarrier_leave() {
  self set_magic_box_zbarrier_state("leaving");
  self waittill(#"left", #"timeout_away");
  self set_magic_box_zbarrier_state("away");
}

function_24ce1c91() {
  self setzbarrierpiecestate(1, "opening");

  while(self getzbarrierpiecestate(1) == "opening") {
    waitframe(1);
  }

  self notify(#"arrived");
}

function_65b1adcb() {
  if(self.script_string === "t8_magicbox") {
    self clientfield::set("t8_magicbox_ambient_fx", 0);
  }

  self setzbarrierpiecestate(1, "closing");

  while(self getzbarrierpiecestate(1) == "closing") {
    wait 0.1;
  }

  self notify(#"left");
}

function_12804472() {
  self setzbarrierpiecestate(2, "opening");

  while(self getzbarrierpiecestate(2) == "opening") {
    wait 0.1;
  }

  self notify(#"opened");
}

function_cd5d65b0() {
  self setzbarrierpiecestate(2, "closing");

  while(self getzbarrierpiecestate(2) == "closing") {
    wait 0.1;
  }

  self notify(#"closed");
}

get_magic_box_zbarrier_state() {
  return self.state;
}

set_magic_box_zbarrier_state(state) {
  for(i = 0; i < self getnumzbarrierpieces(); i++) {
    self hidezbarrierpiece(i);
  }

  self notify(#"zbarrier_state_change");
  self[[level.magic_box_zbarrier_state_func]](state);
}

process_magic_box_zbarrier_state(state) {
  switch (state) {
    case #"away":
      self showzbarrierpiece(0);
      self thread function_15cd8d85();
      self.state = "away";
      break;
    case #"arriving":
      self showzbarrierpiece(1);
      self thread function_24ce1c91();
      self.state = "arriving";
      break;
    case #"initial":
      self showzbarrierpiece(1);
      self thread function_f6a827d1();
      thread zm_unitrigger::register_static_unitrigger(self.owner.unitrigger_stub, &magicbox_unitrigger_think);
      self.state = "initial";
      break;
    case #"open":
      self showzbarrierpiece(2);
      self thread function_12804472();
      self.state = "open";
      break;
    case #"close":
      self showzbarrierpiece(2);
      self thread function_cd5d65b0();
      self.state = "close";
      break;
    case #"leaving":
      self showzbarrierpiece(1);
      self thread function_65b1adcb();
      self.state = "leaving";
      break;
    default:
      if(isDefined(level.custom_magicbox_state_handler)) {
        self[[level.custom_magicbox_state_handler]](state);
      }

      break;
  }
}

function_35c66b27(str_state) {
  switch (str_state) {
    case #"away":
      self.state = "away";

      if(!isDefined(self.var_8cab0622)) {
        a_str_tokens = strtok2(self.script_noteworthy, "zbarrier");
        var_72fa2dd1 = a_str_tokens[0] + "plinth";
        self.var_8cab0622 = struct::get(var_72fa2dd1, "targetname");
        assert(isDefined(self.var_8cab0622), "<dev string:x101>" + var_72fa2dd1);
      }

      self.var_8cab0622 scene::play();
      break;
    case #"arriving":
      if(!isDefined(self.var_8cab0622)) {
        a_str_tokens = strtok2(self.script_noteworthy, "zbarrier");
        var_72fa2dd1 = a_str_tokens[0] + "plinth";
        self.var_8cab0622 = struct::get(var_72fa2dd1, "targetname");
        assert(isDefined(self.var_8cab0622), "<dev string:x101>" + var_72fa2dd1);
      }

      self.var_8cab0622 scene::stop(1);
    default:
      self process_magic_box_zbarrier_state(str_state);
      break;
  }
}

magicbox_host_migration() {
  level endon(#"end_game");
  level notify(#"mb_hostmigration");
  level endon(#"mb_hostmigration");

  while(true) {
    level waittill(#"host_migration_end");

    if(!isDefined(level.chests)) {
      continue;
    }

    foreach(chest in level.chests) {
      if(!(isDefined(chest.hidden) && chest.hidden)) {
        if(isDefined(chest) && isDefined(chest.pandora_light)) {
          if(chest.zbarrier.script_string === "t8_magicbox") {
            playFXOnTag(level._effect[#"hash_2ff87d61167ea531"], chest.pandora_light, "tag_origin");
          } else {
            playFXOnTag(level._effect[#"lght_marker"], chest.pandora_light, "tag_origin");
          }
        }
      }

      util::wait_network_frame();
    }
  }
}

function_7d384b90() {
  foreach(s_chest in level.chests) {
    level thread function_d81704a5(s_chest);
  }
}

function_d81704a5(s_chest) {
  while(isDefined(s_chest._box_open) && s_chest._box_open) {
    waitframe(1);
  }

  s_chest.unitrigger_stub.var_dd0d4460 = 1;
}

function_338c302b() {
  level endon(#"game_ended");

  while(true) {
    level waittill(#"start_of_round");
    level.var_40f4f72d = 0;
  }
}
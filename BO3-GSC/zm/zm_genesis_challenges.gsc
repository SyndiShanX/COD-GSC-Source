/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_genesis_challenges.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_devgui;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_power;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\zm_genesis_util;
#namespace zm_genesis_challenges;

function init_clientfields() {
  clientfield::register("clientuimodel", "trialWidget.visible", 15000, 1, "int");
  clientfield::register("clientuimodel", "trialWidget.progress", 15000, 7, "float");
  clientfield::register("clientuimodel", "trialWidget.icon", 15000, 2, "int");
  clientfield::register("toplayer", "challenge1state", 15000, 2, "int");
  clientfield::register("toplayer", "challenge2state", 15000, 2, "int");
  clientfield::register("toplayer", "challenge3state", 15000, 2, "int");
  clientfield::register("toplayer", "challenge_board_eyes", 15000, 1, "int");
  clientfield::register("scriptmover", "challenge_board_base", 15000, 1, "int");
  clientfield::register("scriptmover", "challenge_board_reward", 15000, 1, "int");
}

function autoexec init() {
  callback::on_spawned( & on_player_spawned);
}

function main() {
  level flag::init("all_challenges_completed");
  level flag::init("flag_init_player_challenges");
  if(getdvarint("splitscreen_playerCount") > 2) {
    array::run_all(getentarray("t_lookat_challenge_1", "targetname"), & delete);
    array::run_all(getentarray("t_lookat_challenge_2", "targetname"), & delete);
    array::run_all(getentarray("t_lookat_challenge_3", "targetname"), & delete);
    array::thread_all(struct::get_array("s_challenge_trigger"), & struct::delete);
  } else {
    level.s_challenges = spawnstruct();
    level.s_challenges.a_challenge_1 = [];
    level.s_challenges.a_challenge_2 = [];
    level.s_challenges.a_challenge_3 = [];
    array::add(level.s_challenges.a_challenge_1, init_challenges(1, & "ZM_GENESIS_CHALLENGE_1_1", 10, "update_challenge_1_1", & function_1ce88534));
    array::add(level.s_challenges.a_challenge_1, init_challenges(1, & "ZM_GENESIS_CHALLENGE_1_2", 15, "update_challenge_1_2", & function_8eeff46f));
    array::add(level.s_challenges.a_challenge_1, init_challenges(1, & "ZM_GENESIS_CHALLENGE_1_5", 10, "update_challenge_1_5", & function_84de9b90));
    array::add(level.s_challenges.a_challenge_1, init_challenges(1, & "ZM_GENESIS_CHALLENGE_1_8", 1, "update_challenge_1_8", & function_72fed2e5));
    array::add(level.s_challenges.a_challenge_1, init_challenges(1, & "ZM_GENESIS_CHALLENGE_1_10", 1, "update_challenge_1_10", & function_9592bd2c));
    array::add(level.s_challenges.a_challenge_1, init_challenges(1, & "ZM_GENESIS_CHALLENGE_3_6", 1, "update_challenge_3_6", & function_896db2ad));
    array::add(level.s_challenges.a_challenge_2, init_challenges(2, & "ZM_GENESIS_CHALLENGE_2_2", 10, "update_challenge_2_2", & function_e4aef098));
    array::add(level.s_challenges.a_challenge_2, init_challenges(2, & "ZM_GENESIS_CHALLENGE_2_7", 1, "update_challenge_2_7", & function_a2bb54a5));
    array::add(level.s_challenges.a_challenge_2, init_challenges(2, & "ZM_GENESIS_CHALLENGE_2_8", 15, "update_challenge_2_8", & function_a01222));
    array::add(level.s_challenges.a_challenge_2, init_challenges(2, & "ZM_GENESIS_CHALLENGE_1_9", 10, "update_challenge_1_9", & function_4cfc587c));
    array::add(level.s_challenges.a_challenge_2, init_challenges(2, & "ZM_GENESIS_CHALLENGE_2_10", 10, "update_challenge_2_10", & function_748fccd9));
    array::add(level.s_challenges.a_challenge_2, init_challenges(2, & "ZM_GENESIS_CHALLENGE_2_11", 1, "update_challenge_2_11", & function_4e8d5270));
    array::add(level.s_challenges.a_challenge_3, init_challenges(3, & "ZM_GENESIS_CHALLENGE_3_1", 5, "update_challenge_3_1", & function_17664372));
    array::add(level.s_challenges.a_challenge_3, init_challenges(3, & "ZM_GENESIS_CHALLENGE_3_2", 1, "update_challenge_3_2", & function_f163c909));
    array::add(level.s_challenges.a_challenge_3, init_challenges(3, & "ZM_GENESIS_CHALLENGE_3_3", 1, "update_challenge_3_3", & function_cb614ea0));
    array::add(level.s_challenges.a_challenge_3, init_challenges(3, & "ZM_GENESIS_CHALLENGE_3_4", 1, "update_challenge_3_4", & function_d572a77f));
    array::add(level.s_challenges.a_challenge_3, init_challenges(3, & "ZM_GENESIS_CHALLENGE_3_9", 3, "update_challenge_3_9", & function_477a16ba));
    array::add(level.s_challenges.a_challenge_3, init_challenges(3, & "ZM_GENESIS_CHALLENGE_2_9", 1, "update_challenge_2_9", & function_26a28c8b));
    zm_spawner::register_zombie_death_event_callback( & function_905d9544);
    zm_spawner::register_zombie_damage_callback( & function_6267dc);
    level._margwa_damage_cb = & function_ca31caac;
    level thread all_challenges_completed();
    level flag::set("flag_init_player_challenges");
    if(getdvarint("") > 0) {
      function_b9b4ce34();
    }
  }
}

function init_challenges(n_challenge_index, str_challenge_info, var_80792f67, str_challenge_notify, var_d675d6d8) {
  s_challenge = spawnstruct();
  s_challenge.n_index = n_challenge_index;
  s_challenge.str_info = str_challenge_info;
  s_challenge.n_count = var_80792f67;
  s_challenge.str_notify = str_challenge_notify;
  s_challenge.func_think = var_d675d6d8;
  return s_challenge;
}

function on_player_connect() {
  level flag::wait_till("flag_init_player_challenges");
  self flag::init("flag_player_collected_reward_1");
  self flag::init("flag_player_collected_reward_2");
  self flag::init("flag_player_collected_reward_3");
  self flag::init("flag_player_completed_challenge_1");
  self flag::init("flag_player_completed_challenge_2");
  self flag::init("flag_player_completed_challenge_3");
  self flag::init("flag_player_initialized_reward");
  self.s_challenges = spawnstruct();
  self.s_challenges.a_challenge_1 = [];
  self.s_challenges.a_challenge_2 = [];
  self.s_challenges.a_challenge_3 = [];
  self.s_challenges.a_challenge_1 = array::random(level.s_challenges.a_challenge_1);
  self.s_challenges.a_challenge_2 = array::random(level.s_challenges.a_challenge_2);
  self.s_challenges.a_challenge_3 = array::random(level.s_challenges.a_challenge_3);
  arrayremovevalue(level.s_challenges.a_challenge_1, self.s_challenges.a_challenge_1);
  arrayremovevalue(level.s_challenges.a_challenge_2, self.s_challenges.a_challenge_2);
  arrayremovevalue(level.s_challenges.a_challenge_3, self.s_challenges.a_challenge_3);
  self thread function_b7156b15();
}

function on_player_disconnect() {
  level flag::wait_till("flag_init_player_challenges");
  var_a879fa43 = self getentitynumber();
  array::add(level.s_challenges.a_challenge_1, self.s_challenges.a_challenge_1);
  array::add(level.s_challenges.a_challenge_2, self.s_challenges.a_challenge_2);
  array::add(level.s_challenges.a_challenge_3, self.s_challenges.a_challenge_3);
}

function on_player_spawned() {
  self.var_b5c08e44 = [];
  self thread function_a235a040();
  self thread function_188466cb();
}

function function_188466cb() {
  self endon("death");
  level flag::wait_till_all(array("start_zombie_round_logic", "challenge_boards_ready"));
  var_a879fa43 = self getentitynumber();
  self clientfield::set_to_player("challenge_board_eyes", 1);
}

function function_a235a040() {
  self endon("disconnect");
  while (true) {
    self function_2983de0c();
    level waittill("end_of_round");
  }
}

function function_2983de0c() {
  self.var_b5c08e44["prison_island"] = 0;
  self.var_b5c08e44["asylum_island"] = 0;
  self.var_b5c08e44["temple_island"] = 0;
  self.var_b5c08e44["prototype_island"] = 0;
  self.var_b5c08e44["start_island"] = 0;
}

function function_e8547a5b(var_cc0f18cc) {
  if(self.challenge_text !== var_cc0f18cc) {
    self.challenge_text = var_cc0f18cc;
    self luinotifyevent(&"trial_set_description", 1, self.challenge_text);
  }
}

function function_27f6c3cd(player, n_challenge_index) {
  switch (n_challenge_index) {
    case 1: {
      player function_e8547a5b(player.s_challenges.a_challenge_1.str_info);
      break;
    }
    case 2: {
      player function_e8547a5b(player.s_challenges.a_challenge_2.str_info);
      break;
    }
    case 3: {
      player function_e8547a5b(player.s_challenges.a_challenge_3.str_info);
      break;
    }
  }
}

function function_33e91747(n_challenge_index, var_fe2fb4b9) {
  self clientfield::set_to_player(("challenge" + n_challenge_index) + "state", var_fe2fb4b9);
}

function function_23c9ffd3(trigger) {
  self notify("hash_23c9ffd3");
  self endon("hash_23c9ffd3");
  while (true) {
    wait(0.5);
    if(!isdefined(self)) {
      break;
    }
    if(!isdefined(trigger) || distance(self.origin, trigger.stub.origin) > trigger.stub.radius) {
      self clientfield::set_player_uimodel("trialWidget.visible", 0);
      break;
    }
  }
}

function init_challenge_boards() {
  level flag::init("challenge_boards_ready");
  level.a_e_challenge_boards = [];
  for (x = 0; x < 4; x++) {
    str_name = "challenge_board_" + x;
    var_df95c68b = getent(str_name, "targetname");
    if(!isdefined(level.a_e_challenge_boards)) {
      level.a_e_challenge_boards = [];
    } else if(!isarray(level.a_e_challenge_boards)) {
      level.a_e_challenge_boards = array(level.a_e_challenge_boards);
    }
    level.a_e_challenge_boards[level.a_e_challenge_boards.size] = var_df95c68b;
    v_origin = var_df95c68b gettagorigin("tag_fx_skull_top");
    v_angles = var_df95c68b gettagangles("tag_fx_skull_top");
    var_df95c68b thread scene::play("p7_fxanim_zm_gen_challenge_prizestone_close_bundle", var_df95c68b);
    wait(0.2);
    var_df95c68b clientfield::set("challenge_board_base", 1);
  }
  level flag::set("challenge_boards_ready");
  for (i = 1; i <= 3; i++) {
    foreach(t_lookat in getentarray("t_lookat_challenge_" + i, "targetname")) {
      t_lookat setinvisibletoall();
    }
  }
}

function function_b7156b15() {
  self endon("disconnect");
  self thread function_2ce855f3(self.s_challenges.a_challenge_1);
  self thread function_2ce855f3(self.s_challenges.a_challenge_2);
  self thread function_2ce855f3(self.s_challenges.a_challenge_3);
  self thread function_fbbc8608(self.s_challenges.a_challenge_1.n_index, "flag_player_completed_challenge_1");
  self thread function_fbbc8608(self.s_challenges.a_challenge_2.n_index, "flag_player_completed_challenge_2");
  self thread function_fbbc8608(self.s_challenges.a_challenge_3.n_index, "flag_player_completed_challenge_3");
  self thread function_974d5f1d();
  var_8e2d9e6f = [];
  var_e01fcddc = [];
  var_a879fa43 = self getentitynumber();
  for (i = 1; i <= 3; i++) {
    var_f2dc9f0b = [];
    foreach(t_lookat in getentarray("t_lookat_challenge_" + i, "targetname")) {
      if(t_lookat.script_int == var_a879fa43) {
        t_lookat setvisibletoplayer(self);
        var_e01fcddc[i] = t_lookat;
        break;
      }
      var_8e2d9e6f[i] = i;
    }
    self thread function_a2d25f82(i, var_a879fa43);
  }
  foreach(s_challenge in struct::get_array("s_challenge_trigger")) {
    if(s_challenge.script_int == var_a879fa43) {
      s_challenge function_4e61a018(var_e01fcddc, var_8e2d9e6f);
      break;
    }
  }
}

function function_4e61a018(var_e01fcddc, var_8e2d9e6f) {
  self zm_unitrigger::create_unitrigger("", 128, & function_3ae0d6d5);
  self.s_unitrigger.require_look_at = 0;
  self.s_unitrigger.inactive_reassess_time = 0.1;
  zm_unitrigger::unitrigger_force_per_player_triggers(self.s_unitrigger, 1);
  self.s_unitrigger.var_8e2d9e6f = var_8e2d9e6f;
  self.var_e01fcddc = var_e01fcddc;
  self thread function_424b6fe8();
}

function function_424b6fe8() {
  while (true) {
    self waittill("trigger_activated", e_who);
    n_entity = e_who getentitynumber();
    if(self.script_int == n_entity) {
      if(e_who flag::get("flag_player_initialized_reward")) {
        if(self.var_30ff0d6c.n_challenge == 2) {
          w_current = e_who getcurrentweapon();
          if(zm_utility::is_placeable_mine(w_current) || zm_equipment::is_equipment(w_current) || w_current == level.weaponnone || (isdefined(w_current.isheroweapon) && w_current.isheroweapon) || (isdefined(w_current.isgadget) && w_current.isgadget)) {
            continue;
          }
          if(e_who bgb::is_enabled("zm_bgb_disorderly_combat")) {
            continue;
          }
        } else if(self.var_30ff0d6c.n_challenge == 3) {
          a_perks = e_who getperks();
          if(a_perks.size == level._custom_perks.size) {
            continue;
          }
        }
        e_who playrumbleonentity("zm_stalingrad_interact_rumble");
        self.s_unitrigger.playertrigger[e_who.entity_num] sethintstringforplayer(e_who, "");
        e_who player_give_reward(self.var_30ff0d6c, n_entity);
        if(isdefined(self.var_30ff0d6c)) {
          self.var_30ff0d6c delete();
        }
      } else {
        for (i = 1; i <= 3; i++) {
          if(e_who function_3f67a723(self.var_e01fcddc[i].origin, 15, 0) && distance(e_who.origin, self.origin) < 500) {
            if(isdefined(e_who.var_c981566c) && e_who.var_c981566c) {
              break;
            }
            if(e_who flag::get("flag_player_completed_challenge_" + i) && !e_who flag::get("flag_player_collected_reward_" + i)) {
              e_who playrumbleonentity("zm_stalingrad_interact_rumble");
              self.s_unitrigger.playertrigger[e_who.entity_num] sethintstringforplayer(e_who, "");
              self function_1d22626(e_who, i);
              break;
            }
          }
        }
      }
    }
  }
}

function function_1d22626(e_player, n_challenge) {
  e_player endon("disconnect");
  var_7bb343ef = (0, 90, 0);
  var_93571595 = struct::get_array("s_challenge_reward", "targetname");
  n_entity = e_player getentitynumber();
  foreach(s_reward in var_93571595) {
    if(s_reward.script_int == n_entity) {
      break;
    }
  }
  switch (n_challenge) {
    case 1: {
      var_17b3dc96 = "p7_zm_power_up_max_ammo";
      s_reward.var_e1513629 = vectorscale((0, 0, 1), 6);
      s_reward.var_b90d551 = var_7bb343ef;
      break;
    }
    case 2: {
      var_3728fce1 = [];
      if(!isdefined(var_3728fce1)) {
        var_3728fce1 = [];
      } else if(!isarray(var_3728fce1)) {
        var_3728fce1 = array(var_3728fce1);
      }
      var_3728fce1[var_3728fce1.size] = "lmg_cqb_upgraded";
      if(!isdefined(var_3728fce1)) {
        var_3728fce1 = [];
      } else if(!isarray(var_3728fce1)) {
        var_3728fce1 = array(var_3728fce1);
      }
      var_3728fce1[var_3728fce1.size] = "ar_damage_upgraded";
      if(!isdefined(var_3728fce1)) {
        var_3728fce1 = [];
      } else if(!isarray(var_3728fce1)) {
        var_3728fce1 = array(var_3728fce1);
      }
      var_3728fce1[var_3728fce1.size] = "smg_versatile_upgraded";
      var_17b3dc96 = array::random(var_3728fce1);
      var_6b215f76 = (anglestoright(s_reward.angles) * 5) + (anglestoforward(s_reward.angles) * -2);
      s_reward.var_e1513629 = var_6b215f76 + (0, 0, 1);
      s_reward.var_b90d551 = var_7bb343ef;
      break;
    }
    case 3: {
      var_17b3dc96 = "zombie_pickup_perk_bottle";
      var_1bfa1f7e = anglestoforward(s_reward.angles) * -2;
      s_reward.var_e1513629 = var_1bfa1f7e + vectorscale((0, 0, 1), 7);
      s_reward.var_b90d551 = var_7bb343ef;
      break;
    }
  }
  e_player.var_c981566c = 1;
  var_df95c68b = level.a_e_challenge_boards[n_entity];
  var_df95c68b scene::play("p7_fxanim_zm_gen_challenge_prizestone_open_bundle", var_df95c68b);
  var_df95c68b clientfield::set("challenge_board_reward", 1);
  self function_b1f54cb4(e_player, s_reward, var_17b3dc96, 30);
  self.var_30ff0d6c clientfield::set("powerup_fx", 1);
  self.var_30ff0d6c.n_challenge = n_challenge;
  e_player flag::set("flag_player_initialized_reward");
  self thread function_1ad9d1a0(e_player, 30 * -1, n_entity);
}

function function_1ad9d1a0(e_player, n_dist, n_entity) {
  self endon("hash_422dba45");
  self.var_30ff0d6c movez(n_dist, 12, 6);
  self.var_30ff0d6c waittill("movedone");
  if(isdefined(e_player)) {
    e_player flag::clear("flag_player_initialized_reward");
    e_player.var_c981566c = undefined;
  }
  if(isdefined(self.var_30ff0d6c)) {
    self.var_30ff0d6c delete();
  }
  function_d57066e8(n_entity);
}

function function_b1f54cb4(e_player, s_reward, var_17b3dc96, var_21d0cf95) {
  if(isdefined(self.var_30ff0d6c)) {
    self notify("hash_422dba45");
  }
  var_51a2f105 = s_reward.origin + s_reward.var_e1513629;
  var_9ef5a0dc = s_reward.angles + s_reward.var_b90d551;
  switch (var_17b3dc96) {
    case "ar_damage_upgraded":
    case "lmg_cqb_upgraded":
    case "smg_versatile_upgraded": {
      self.var_30ff0d6c = zm_utility::spawn_buildkit_weapon_model(e_player, getweapon(var_17b3dc96), undefined, var_51a2f105, var_9ef5a0dc);
      self.var_30ff0d6c.str_weapon_name = var_17b3dc96;
      break;
    }
    default: {
      self.var_30ff0d6c = util::spawn_model(var_17b3dc96, var_51a2f105, var_9ef5a0dc);
      break;
    }
  }
  self.var_30ff0d6c movez(var_21d0cf95, 1);
  playsoundatposition("evt_prize_rise", self.origin);
  self.var_30ff0d6c waittill("movedone");
}

function function_d57066e8(n_entity) {
  var_df95c68b = level.a_e_challenge_boards[n_entity];
  var_df95c68b scene::play("p7_fxanim_zm_gen_challenge_prizestone_close_bundle", var_df95c68b);
  var_df95c68b clientfield::set("challenge_board_reward", 0);
}

function function_a2d25f82(n_challenge, var_a879fa43) {
  self endon("disconnect");
  self endon("hash_f9ff0ae7");
  self flag::wait_till("flag_player_completed_challenge_" + n_challenge);
  str_model = "p7_zm_gen_challenge_medal_0" + n_challenge;
  var_df95c68b = level.a_e_challenge_boards[var_a879fa43];
  var_df95c68b attach(str_model, function_94a89297(n_challenge));
}

function function_94a89297(n_challenge) {
  switch (n_challenge) {
    case 1: {
      return "tag_medal_easy";
      break;
    }
    case 2: {
      return "tag_medal_med";
      break;
    }
    default: {
      return "tag_medal_hard";
      break;
    }
  }
}

function function_fbbc8608(n_challenge_index, var_d4adfa57) {
  self endon("disconnect");
  self flag::wait_till(var_d4adfa57);
  var_ea22a0bf = "";
  if(n_challenge_index == 1) {
    var_ea22a0bf = self.s_challenges.a_challenge_1.str_info;
  } else {
    if(n_challenge_index == 2) {
      var_ea22a0bf = self.s_challenges.a_challenge_2.str_info;
    } else {
      var_ea22a0bf = self.s_challenges.a_challenge_3.str_info;
    }
  }
  self luinotifyevent(&"trial_complete", 3, & "ZM_GENESIS_CHALLENGE_COMPLETE", var_ea22a0bf, n_challenge_index - 1);
}

function function_3ae0d6d5(e_player) {
  if(self.stub.related_parent.script_int == e_player getentitynumber()) {
    var_a51a0ba6 = 0;
    if(e_player flag::get("flag_player_initialized_reward")) {
      self sethintstringforplayer(e_player, & "ZM_GENESIS_CHALLENGE_REWARD_TAKE");
      if(self.stub.related_parent.var_30ff0d6c.n_challenge == 3) {
        a_perks = e_player getperks();
        if(a_perks.size == level._custom_perks.size) {
          self sethintstringforplayer(e_player, "");
        }
      }
      var_a51a0ba6 = 1;
      return true;
    }
    for (i = 1; i <= 3; i++) {
      if(e_player function_3f67a723(self.stub.related_parent.var_e01fcddc[i].origin, 15, 0) && distance(e_player.origin, self.stub.origin) < 500) {
        self function_27f6c3cd(e_player, i);
        e_player clientfield::set_player_uimodel("trialWidget.icon", i - 1);
        e_player clientfield::set_player_uimodel("trialWidget.visible", 1);
        e_player clientfield::set_player_uimodel("trialWidget.progress", e_player.var_5315d90d[i]);
        e_player thread function_23c9ffd3(self);
        if(!e_player flag::get("flag_player_completed_challenge_" + i)) {
          self sethintstringforplayer(e_player, "");
          var_a51a0ba6 = 1;
          return true;
        }
        if(!e_player flag::get("flag_player_collected_reward_" + i) && (!(isdefined(e_player.var_c981566c) && e_player.var_c981566c))) {
          self sethintstringforplayer(e_player, & "ZM_GENESIS_CHALLENGE_REWARD");
          var_a51a0ba6 = 1;
          return true;
        }
        self sethintstringforplayer(e_player, "");
        var_a51a0ba6 = 1;
        return true;
      }
    }
    if(!var_a51a0ba6) {
      self sethintstringforplayer(e_player, "");
      e_player clientfield::set_player_uimodel("trialWidget.visible", 0);
      return false;
    }
  } else {
    self sethintstringforplayer(e_player, "");
    return false;
  }
}

function function_3f67a723(origin, var_a0fa82de = 90, do_trace, e_ignore) {
  var_a0fa82de = absangleclamp360(var_a0fa82de);
  var_303bd275 = cos(var_a0fa82de * 0.5);
  if(self util::is_player_looking_at(origin, var_303bd275, do_trace, e_ignore)) {
    return true;
  }
  return false;
}

function player_give_reward(var_30ff0d6c, n_entity) {
  switch (var_30ff0d6c.n_challenge) {
    case 1: {
      level thread zm_powerups::specific_powerup_drop("full_ammo", self.origin);
      playsoundatposition("evt_grab_powerup", self.origin);
      break;
    }
    case 2: {
      if(isdefined(var_30ff0d6c.str_weapon_name)) {
        var_e564b69e = getweapon(var_30ff0d6c.str_weapon_name);
      }
      self thread swap_weapon(var_e564b69e);
      playsoundatposition("evt_grab_weapon", self.origin);
      break;
    }
    case 3: {
      self thread function_6131520e();
      playsoundatposition("evt_grab_perk", self.origin);
      break;
    }
  }
  self flag::set("flag_player_collected_reward_" + var_30ff0d6c.n_challenge);
  self flag::clear("flag_player_initialized_reward");
  self function_33e91747(var_30ff0d6c.n_challenge, 2);
  level thread function_d57066e8(n_entity);
  self.var_c981566c = undefined;
}

function swap_weapon(var_f4612f93) {
  w_current = self getcurrentweapon();
  if(!zm_utility::is_player_valid(self)) {
    return;
  }
  if(self.is_drinking > 0) {
    return;
  }
  if(zm_utility::is_placeable_mine(w_current) || zm_equipment::is_equipment(w_current) || w_current == level.weaponnone) {
    return;
  }
  if(!self hasweapon(var_f4612f93.rootweapon, 1)) {
    if(w_current.type === "melee") {
      self function_3420bc2f(var_f4612f93);
    } else {
      self take_old_weapon_and_give_new(w_current, var_f4612f93);
    }
  } else {
    self givemaxammo(var_f4612f93);
  }
}

function take_old_weapon_and_give_new(w_current, var_f4612f93) {
  var_d2f4cbdf = self getweaponslistprimaries();
  if(isdefined(var_d2f4cbdf) && var_d2f4cbdf.size >= zm_utility::get_player_weapon_limit(self)) {
    self takeweapon(w_current);
  }
  var_6fc96b00 = self zm_weapons::give_build_kit_weapon(var_f4612f93);
  self giveweapon(var_6fc96b00);
  self switchtoweapon(var_6fc96b00);
}

function function_3420bc2f(var_f4612f93) {
  var_6f845c3d = self getweaponslist(1);
  foreach(var_cdee635d in var_6f845c3d) {
    if(var_cdee635d.type === "melee") {
      self takeweapon(var_cdee635d);
      break;
    }
  }
  var_6fc96b00 = self zm_weapons::give_build_kit_weapon(var_f4612f93);
  self giveweapon(var_6fc96b00);
}

function function_6131520e() {
  self endon("disconnect");
  a_str_perks = getarraykeys(level._custom_perks);
  a_str_perks = array::randomize(a_str_perks);
  foreach(str_perk in a_str_perks) {
    if(!self hasperk(str_perk)) {
      self zm_perks::give_perk(str_perk, 0);
      break;
    }
  }
}

function function_1adeaa1c() {
  var_4562cc04 = level.perk_purchase_limit;
  if(self flag::get("flag_player_collected_reward_3")) {
    var_4562cc04++;
  }
  return var_4562cc04;
}

function function_1ce88534() {
  self endon("flag_player_completed_challenge_1");
  self endon("disconnect");
  if(!isdefined(self.n_flogger_trap_kills)) {
    self.n_flogger_trap_kills = 0;
  }
  if(!isdefined(self.n_electric_trap_kills)) {
    self.n_electric_trap_kills = 0;
  }
  self thread function_9b1e43e5();
  self thread function_c120be4e();
}

function function_9b1e43e5() {
  self endon("flag_player_completed_challenge_1");
  self endon("disconnect");
  while (true) {
    level waittill("flogger_killed_zombie", ai_zombie, e_attacker);
    if(e_attacker === self && self.n_flogger_trap_kills < 5) {
      self.n_flogger_trap_kills++;
      self notify("update_challenge_1_1");
    }
  }
}

function function_c120be4e() {
  self endon("flag_player_completed_challenge_1");
  self endon("disconnect");
  while (true) {
    self waittill("zombie_zapped");
    if(self.n_electric_trap_kills < 5) {
      self.n_electric_trap_kills++;
      self notify("update_challenge_1_1");
    }
  }
}

function function_8eeff46f() {
  self endon("flag_player_completed_challenge_1");
  self endon("disconnect");
  while (true) {
    level waittill("beam_killed_zombie", e_attacker);
    if(e_attacker === self) {
      self notify("update_challenge_1_2");
    }
  }
}

function function_68ed7a06() {
  self endon("flag_player_completed_challenge_1");
  self endon("disconnect");
  while (true) {
    str_result = level util::waittill_any("all_rifts_destroyed", "chaos_round_timeout");
    if(str_result === "all_rifts_destroyed") {
      self notify("update_challenge_1_3");
    }
  }
}

function function_aae115f9() {
  self endon("flag_player_completed_challenge_1");
  self endon("disconnect");
  while (true) {
    level waittill("hash_10ed65db", e_attacker);
    if(e_attacker === self) {
      self notify("update_challenge_1_4");
    }
  }
}

function function_84de9b90() {
  self endon("flag_player_completed_challenge_1");
  self endon("disconnect");
  while (true) {
    level waittill("hash_646a26b1", e_attacker);
    if(e_attacker === self) {
      self notify("update_challenge_1_5");
    }
  }
}

function function_f6e60acb() {
  self endon("flag_player_completed_challenge_1");
  self endon("disconnect");
  while (true) {
    level waittill("hash_944787dd", e_attacker);
    if(e_attacker === self) {
      self notify("update_challenge_1_6");
    }
  }
}

function function_d0e39062() {
  self endon("flag_player_completed_challenge_1");
  self endon("disconnect");
  while (true) {
    level waittill("hash_b1d69866", e_attacker);
    if(e_attacker === self) {
      self notify("hash_757347c2");
    }
  }
}

function function_72fed2e5() {
  self endon("flag_player_completed_challenge_1");
  self endon("disconnect");
  while (true) {
    self waittill("new_equipment", weapon);
    if(weapon === level.weaponriotshield) {
      self notify("update_challenge_1_8");
    }
  }
}

function function_4cfc587c() {
  self endon("flag_player_completed_challenge_2");
  self endon("disconnect");
  while (true) {
    level waittill("hash_92ad8590", e_attacker);
    if(e_attacker === self) {
      self notify("update_challenge_1_9");
    }
  }
}

function function_9592bd2c() {
  self endon("flag_player_completed_challenge_1");
  self endon("disconnect");
  while (true) {
    level waittill("hash_7e8efe7c");
    self notify("update_challenge_1_10");
  }
}

function function_56b65fd3() {
  self endon("flag_player_completed_challenge_2");
  self endon("disconnect");
  while (true) {
    level waittill("hash_11ab530d", e_attacker);
    if(e_attacker === self) {
      self notify("update_challenge_2_1");
    }
  }
}

function function_e4aef098() {
  self endon("flag_player_completed_challenge_2");
  self endon("disconnect");
  while (true) {
    level waittill("hash_b1a8571a", e_attacker);
    if(e_attacker === self) {
      self notify("update_challenge_2_2");
    }
  }
}

function function_ab16b01() {
  level flagsys::wait_till("start_zombie_round_logic");
  self endon("flag_player_completed_challenge_2");
  self endon("disconnect");
  var_259ad2d8 = getent("apothicon_island", "targetname");
  level flag::wait_till_all(array("power_on1", "power_on2", "power_on3", "power_on4"));
  while (true) {
    self waittill("hash_a8c34632");
    start_round = level.round_number;
    while (self istouching(var_259ad2d8) && (level.round_number - start_round) < 3) {
      wait(1);
    }
    if((level.round_number - start_round) >= 3) {
      self notify("update_challenge_2_3");
    }
  }
}

function function_c8bdcf0e() {
  self endon("flag_player_completed_challenge_2");
  self endon("disconnect");
  while (true) {
    level waittill("chaos_round_start");
    n_start_time = gettime();
    function_ac2bad00(n_start_time, 120);
    if(n_start_time < 120) {
      self notify("update_challenge_2_4");
    }
  }
}

function function_ac2bad00(n_start_time, var_8d05fd02) {
  level endon("chaos_round_complete");
  level endon("kill_round");
  level endon("chaos_round_timeout");
  n_total_time = 0;
  while (n_total_time < var_8d05fd02) {
    n_current_time = gettime();
    n_total_time = (n_current_time - n_start_time) / 1000;
    util::wait_network_frame();
  }
}

function function_eec04977() {
  self endon("flag_player_completed_challenge_2");
  self endon("disconnect");
  while (true) {
    level waittill("hash_661aa774");
    str_result = level util::waittill_any("power_ritual_aborted", "power_ritual_completed", "non_melee_damage");
    if(str_result === "power_ritual_completed") {
      self notify("update_challenge_2_5");
    }
  }
}

function function_7cb8da3c() {
  self endon("flag_player_completed_challenge_2");
  self endon("disconnect");
  while (true) {
    level waittill("hash_1c04ac7f", e_attacker);
    if(e_attacker === self) {
      self notify("update_challenge_2_6");
    }
  }
}

function function_a2bb54a5() {
  self endon("flag_player_completed_challenge_2");
  self endon("disconnect");
  while (true) {
    level waittill("hash_e15c8839", e_attacker);
    if(e_attacker === self) {
      self notify("update_challenge_2_7");
    }
  }
}

function function_a01222() {
  self endon("flag_player_completed_challenge_2");
  self endon("disconnect");
  while (true) {
    self waittill("player_killed_spider");
    self notify("update_challenge_2_8");
  }
}

function function_26a28c8b() {
  self endon("flag_player_completed_challenge_3");
  self endon("disconnect");
  while (true) {
    level waittill("hash_8dbe1895", e_attacker);
    if(e_attacker === self) {
      self notify("update_challenge_2_9");
    }
  }
}

function function_748fccd9() {
  self endon("flag_player_completed_challenge_2");
  self endon("disconnect");
  while (true) {
    self waittill("hash_21c74868");
    self notify("update_challenge_2_10");
  }
}

function function_4e8d5270() {
  self endon("flag_player_completed_challenge_2");
  self endon("disconnect");
  while (true) {
    self waittill("hash_36abd341");
    self notify("update_challenge_2_11");
  }
}

function function_17664372() {
  self endon("flag_player_completed_challenge_3");
  self endon("disconnect");
  while (true) {
    level waittill("hash_f312481d", e_attacker);
    if(e_attacker === self) {
      self notify("update_challenge_3_1");
    }
  }
}

function function_f163c909() {
  spawner::add_archetype_spawn_function("mechz", & function_8c4a46cf, self);
  self thread function_78a15a9();
}

function function_8c4a46cf(e_player) {
  e_player endon("flag_player_completed_challenge_3");
  e_player endon("disconnect");
  self endon("hash_da235077");
  self waittill("death", e_attacker, n_damage, w_weapon, v_point, v_dir);
  if(e_attacker === e_player) {
    e_attacker notify("update_challenge_3_2");
  }
}

function function_78a15a9() {
  self endon("flag_player_completed_challenge_3");
  self endon("disconnect");
  self endon("update_challenge_3_2");
  while (true) {
    self waittill("damage", n_damage, e_attacker);
    if(e_attacker.archetype === "mechz" || e_attacker.archetype === "margwa") {
      e_attacker notify("hash_da235077");
    }
  }
}

function function_cb614ea0() {
  self endon("flag_player_completed_challenge_3");
  self endon("disconnect");
  while (true) {
    self waittill("hash_bf458b1e");
    self notify("update_challenge_3_3");
  }
}

function function_d572a77f() {
  self endon("flag_player_completed_challenge_3");
  self endon("disconnect");
  var_f434985b = 0;
  var_2576a2b = 0;
  while (true) {
    str_result = self util::waittill_any_return("flag_player_completed_challenge_3", "disconnect", "fire_margwa_death", "shadow_margwa_death");
    if(str_result == "fire_margwa_death") {
      var_f434985b = 1;
    } else if(str_result == "shadow_margwa_death") {
      var_2576a2b = 1;
    }
    if(var_f434985b && var_2576a2b) {
      self notify("update_challenge_3_4");
    }
  }
}

function function_af702d16() {
  level flagsys::wait_till("start_zombie_round_logic");
  self endon("flag_player_completed_challenge_3");
  self endon("disconnect");
  level flag::wait_till_all(array("power_on1", "power_on2", "power_on3", "power_on4"));
  if(level.round_number <= 5) {
    self notify("update_challenge_3_5");
  }
}

function function_896db2ad() {
  self endon("flag_player_completed_challenge_1");
  self endon("disconnect");
  while (true) {
    level waittill("hash_9a954bfc", e_attacker);
    if(e_attacker === self) {
      self notify("update_challenge_3_6");
    }
  }
}

function function_636b3844() {
  self endon("flag_player_completed_challenge_3");
  self endon("disconnect");
  while (true) {
    level waittill("hash_22e3a570", e_attacker);
    if(e_attacker === self) {
      self notify("hash_7a1760a4");
    }
  }
}

function function_6d7c9123() {
  self endon("flag_player_completed_challenge_3");
  self endon("disconnect");
  while (true) {
    level waittill("hash_d290d94f", e_attacker);
    if(e_attacker === self) {
      self notify("hash_8428b983");
    }
  }
}

function function_477a16ba() {
  self endon("flag_player_completed_challenge_3");
  self endon("disconnect");
  while (true) {
    self waittill("hash_7b1b2d");
    self notify("update_challenge_3_9");
  }
}

function function_905d9544(e_attacker) {
  if(isplayer(e_attacker)) {
    if(self.archetype === "apothicon_fury") {
      if(zm_utility::is_headshot(self.damageweapon, self.damagelocation, self.damagemod)) {
        level notify("hash_646a26b1", e_attacker);
      }
    }
    if(isdefined(self.traversal)) {
      if(isdefined(self.traversal.startnode)) {
        if(self.traversal.startnode.script_noteworthy === "flinger_traversal") {
          e_attacker notify("hash_21c74868");
        }
      }
    }
    if(self.archetype === "zombie") {
      self thread function_4d042c7d(e_attacker);
    }
    if(isdefined(e_attacker.var_a3d40b8) && isdefined(self.var_a3d40b8)) {
      if(e_attacker.var_a3d40b8 !== self.var_a3d40b8) {
        level notify("hash_f312481d", e_attacker);
      }
    }
    if(self.archetype === "margwa") {
      if(self.var_b6802ed1[e_attacker.playernum] <= 3) {
        e_attacker notify("hash_bf458b1e");
      }
      if(self.var_f9ebd43e === "fire") {
        e_attacker notify("fire_margwa_death");
      } else if(self.var_f9ebd43e === "shadow") {
        e_attacker notify("shadow_margwa_death");
      }
      if(self.zone_name === "apothicon_interior_zone") {
        e_attacker notify("hash_7b1b2d");
      }
    }
  } else if(isdefined(e_attacker) && e_attacker.archetype === "turret") {
    if(isdefined(e_attacker.activated_by_player)) {
      e_attacker.activated_by_player notify("autoturret_killed_zombie");
      level notify("autoturret_killed_zombie");
      self thread function_4d042c7d(e_attacker.activated_by_player);
    }
  }
}

function function_4d042c7d(player) {
  if(isdefined(self.var_a3d40b8)) {
    var_bc09c7dd = 1;
    switch (self.var_a3d40b8) {
      case "asylum_island":
      case "prison_island":
      case "prototype_island":
      case "start_island":
      case "temple_island": {
        player.var_b5c08e44[self.var_a3d40b8]++;
        a_str_keys = getarraykeys(player.var_b5c08e44);
        foreach(str_key in a_str_keys) {
          if(player.var_b5c08e44[str_key] < 5) {
            var_bc09c7dd = 0;
          }
        }
        if(var_bc09c7dd) {
          player notify("hash_36abd341");
        }
        break;
      }
    }
  }
}

function function_6267dc(str_mod, str_hit_location, v_hit_origin, e_player, n_amount, w_weapon, v_direction, str_tag, str_model, str_part, n_flags, e_inflictor, n_chargelevel) {
  if(isplayer(e_inflictor)) {
    if(!(isdefined(zm_utility::is_melee_weapon(w_weapon)) && zm_utility::is_melee_weapon(w_weapon))) {
      level notify("non_melee_damage");
    }
  }
  return false;
}

function function_2ce855f3(s_challenge) {
  self endon("disconnect");
  self endon("hash_f9ff0ae7");
  if(isdefined(s_challenge.func_think)) {
    self thread[[s_challenge.func_think]]();
  }
  var_80792f67 = s_challenge.n_count;
  if(!isdefined(self.var_5315d90d)) {
    self.var_5315d90d = [];
  }
  self.var_5315d90d[s_challenge.n_index] = 0;
  var_ea184c3d = var_80792f67;
  while (var_80792f67 > 0) {
    self waittill(s_challenge.str_notify);
    var_80792f67--;
    self.var_5315d90d[s_challenge.n_index] = 1 - (var_80792f67 / var_ea184c3d);
  }
  self function_33e91747(s_challenge.n_index, 1);
  self flag::set("flag_player_completed_challenge_" + s_challenge.n_index);
}

function function_974d5f1d() {
  self endon("disconnect");
  a_flags = array("flag_player_completed_challenge_1", "flag_player_completed_challenge_2", "flag_player_completed_challenge_3");
  self flag::wait_till_all(a_flags);
  level notify("hash_41370469");
}

function all_challenges_completed() {
  level.var_c28313cd = 0;
  callback::on_disconnect( & function_b1cd865a);
  while (true) {
    level waittill("hash_41370469");
    level.var_c28313cd++;
    if(level.var_c28313cd >= level.players.size) {
      level flag::set("all_challenges_completed");
      break;
    }
  }
}

function function_b1cd865a() {
  if(level.var_c28313cd >= level.players.size) {
    level flag::set("all_challenges_completed");
  }
}

function function_ca31caac(inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
  if(isplayer(attacker)) {
    if(!isdefined(self.var_b6802ed1)) {
      self.var_b6802ed1 = [];
    }
    if(!isdefined(self.var_b6802ed1[attacker.playernum])) {
      self.var_b6802ed1[attacker.playernum] = 0;
    }
    self.var_b6802ed1[attacker.playernum]++;
  }
}

function function_b9b4ce34() {
  zm_devgui::add_custom_devgui_callback( & challenges_devgui_callback);
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
}

function challenges_devgui_callback(cmd) {
  switch (cmd) {
    case "": {
      level flag::set("");
      return true;
    }
    case "": {
      foreach(e_player in level.players) {
        e_player flag::set("");
        e_player notify("hash_fb393ffe");
        e_player.var_5315d90d[1] = 1;
        e_player function_33e91747(1, 1);
      }
      return true;
    }
    case "": {
      foreach(e_player in level.players) {
        e_player flag::set("");
        e_player notify("hash_d536c595");
        e_player.var_5315d90d[2] = 1;
        e_player function_33e91747(2, 1);
      }
      return true;
    }
    case "": {
      foreach(e_player in level.players) {
        e_player flag::set("");
        e_player notify("hash_af344b2c");
        e_player.var_5315d90d[3] = 1;
        e_player function_33e91747(3, 1);
      }
      return true;
    }
    case "": {
      level function_dcfe1b91();
      foreach(e_player in level.players) {
        e_player function_224232f4();
      }
      return true;
    }
    case "": {
      foreach(e_player in level.players) {
        e_player function_224232f4();
      }
      return true;
    }
  }
  return false;
}

function function_224232f4() {
  self notify("hash_f9ff0ae7");
  self flag::clear("");
  self flag::clear("");
  self flag::clear("");
  self flag::clear("");
  self flag::clear("");
  self flag::clear("");
  self thread function_2ce855f3(self.s_challenges.a_challenge_1);
  self thread function_2ce855f3(self.s_challenges.a_challenge_2);
  self thread function_2ce855f3(self.s_challenges.a_challenge_3);
  var_a879fa43 = self getentitynumber();
  for (i = 1; i <= 3; i++) {
    self.var_5315d90d[i] = 0;
    self function_33e91747(i, 0);
    foreach(s_glyph in struct::get_array("" + i, "")) {
      if(s_glyph.script_int == var_a879fa43) {
        break;
      }
    }
  }
}

function function_dcfe1b91() {
  foreach(e_player in level.players) {
    if(!isdefined(level.s_challenges.a_challenge_1)) {
      level.s_challenges.a_challenge_1 = [];
    } else if(!isarray(level.s_challenges.a_challenge_1)) {
      level.s_challenges.a_challenge_1 = array(level.s_challenges.a_challenge_1);
    }
    level.s_challenges.a_challenge_1[level.s_challenges.a_challenge_1.size] = e_player.s_challenges.a_challenge_1;
    if(!isdefined(level.s_challenges.a_challenge_2)) {
      level.s_challenges.a_challenge_2 = [];
    } else if(!isarray(level.s_challenges.a_challenge_2)) {
      level.s_challenges.a_challenge_2 = array(level.s_challenges.a_challenge_2);
    }
    level.s_challenges.a_challenge_2[level.s_challenges.a_challenge_2.size] = e_player.s_challenges.a_challenge_2;
    if(!isdefined(level.s_challenges.a_challenge_3)) {
      level.s_challenges.a_challenge_3 = [];
    } else if(!isarray(level.s_challenges.a_challenge_3)) {
      level.s_challenges.a_challenge_3 = array(level.s_challenges.a_challenge_3);
    }
    level.s_challenges.a_challenge_3[level.s_challenges.a_challenge_3.size] = e_player.s_challenges.a_challenge_3;
  }
  foreach(e_player in level.players) {
    e_player.s_challenges.a_challenge_1 = array::random(level.s_challenges.a_challenge_1);
    e_player.s_challenges.a_challenge_2 = array::random(level.s_challenges.a_challenge_2);
    e_player.s_challenges.a_challenge_3 = array::random(level.s_challenges.a_challenge_3);
    arrayremovevalue(level.s_challenges.a_challenge_1, e_player.s_challenges.a_challenge_1);
    arrayremovevalue(level.s_challenges.a_challenge_2, e_player.s_challenges.a_challenge_2);
    arrayremovevalue(level.s_challenges.a_challenge_3, e_player.s_challenges.a_challenge_3);
  }
}
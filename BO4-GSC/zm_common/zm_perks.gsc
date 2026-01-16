/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_perks.gsc
***********************************************/

#include script_301f64a4090c381a;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\demo_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\gestures;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\perks;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\potm_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\zm_common\bb;
#include scripts\zm_common\trials\zm_trial_disable_buys;
#include scripts\zm_common\trials\zm_trial_disable_perks;
#include scripts\zm_common\trials\zm_trial_randomize_perks;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_contracts;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_equipment;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;

#namespace zm_perks;

init() {
  if(!isDefined(level.var_c3e5c4cd)) {
    level.var_c3e5c4cd = zm_utility::get_story();
  }

  level.perk_purchase_limit = 4;

  if(!isDefined(level.var_91ac8112)) {
    level.var_91ac8112 = [];
  } else if(!isarray(level.var_91ac8112)) {
    level.var_91ac8112 = array(level.var_91ac8112);
  }

  perks_register_clientfield();

  if(!level.enable_magic) {
    return;
  }

  if(!isDefined(level._custom_perks)) {
    level._custom_perks = [];
  } else if(!isarray(level._custom_perks)) {
    level._custom_perks = array(level._custom_perks);
  }

  level.var_76a7ad28 = [];
  perk_vapor_altar_init();
  vending_weapon_upgrade_trigger = [];
  level.machine_assets = [];
  level.perk_machines = [];

  if(!isDefined(level.custom_vending_precaching)) {
    level.custom_vending_precaching = &default_vending_precaching;
  }

  [[level.custom_vending_precaching]]();
  zombie_utility::set_zombie_var(#"zombie_perk_cost", 2000);

  if(level._custom_perks.size > 0) {
    a_keys = getarraykeys(level._custom_perks);

    for(i = 0; i < a_keys.size; i++) {
      b_enabled = 1;

      if(!isinarray(level.var_b8be892e, a_keys[i])) {
        b_enabled = 0;
      }

      if(b_enabled) {
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
  }

  if(isDefined(level.quantum_bomb_register_result_func)) {
    [[level.quantum_bomb_register_result_func]]("give_nearest_perk", &quantum_bomb_give_nearest_perk_result, 10, &quantum_bomb_give_nearest_perk_validation);
  }

  level thread perk_hostmigration();
  callback::on_connect(&on_player_connect);
  callback::on_spawned(&on_player_spawned);
  register_lost_perk_override(&function_d1cad55c);

  level thread function_545a79c();

}

on_player_connect() {
  if(!isDefined(self.var_c27f1e90)) {
    self.var_c27f1e90 = [];
  } else if(!isarray(self.var_c27f1e90)) {
    self.var_c27f1e90 = array(self.var_c27f1e90);
  }

  if(!isDefined(self.var_c4193958)) {
    self.var_c4193958 = [];
  } else if(!isarray(self.var_c4193958)) {
    self.var_c4193958 = array(self.var_c4193958);
  }

  if(!isDefined(self.var_47654123)) {
    self.var_47654123 = [];
  } else if(!isarray(self.var_47654123)) {
    self.var_47654123 = array(self.var_47654123);
  }

  if(!isDefined(self.var_774e0ad7)) {
    self.var_774e0ad7 = [];
  } else if(!isarray(self.var_774e0ad7)) {
    self.var_774e0ad7 = array(self.var_774e0ad7);
  }

  if(!isDefined(self.var_cd5d9345)) {
    self.var_cd5d9345 = [];
  } else if(!isarray(self.var_cd5d9345)) {
    self.var_cd5d9345 = array(self.var_cd5d9345);
  }

  if(!isDefined(self.var_67ba1237)) {
    self.var_67ba1237 = [];
  } else if(!isarray(self.var_67ba1237)) {
    self.var_67ba1237 = array(self.var_67ba1237);
  }

  if(!isDefined(self.var_eabca645)) {
    self.var_eabca645 = [];
  } else if(!isarray(self.var_eabca645)) {
    self.var_eabca645 = array(self.var_eabca645);
  }

  if(!isDefined(self.var_466b927f)) {
    self.var_466b927f = [];
  } else if(!isarray(self.var_466b927f)) {
    self.var_466b927f = array(self.var_466b927f);
  }

  self.var_ab375b18 = 0;
  j = 0;

  for(i = 1; i <= 4; i++) {
    var_96861ec8 = self zm_loadout::get_loadout_item("specialty" + i);
    s_perk = getunlockableiteminfofromindex(var_96861ec8, 3);
    str_perk = "";

    if(isDefined(s_perk)) {
      str_perk = hash(s_perk.specialties[0]);

      if(!isinarray(level.var_b8be892e, str_perk)) {
        str_perk = "";
      }
    } else {

      iprintlnbold("<dev string:x38>" + self.name + "<dev string:x59>");

    }

    if(!zm_custom::function_d9f0defb(str_perk)) {
      self function_2ac7579(i - 1, 3);
      self thread zm_custom::function_41ed4017();
    }

    self.var_c27f1e90[j] = str_perk;
    self.var_47654123[j] = str_perk == #"specialty_mystery" ? 1 : 0;
    self.var_c4193958[j] = "";
    j++;
  }

  self function_756e6a6d();

}

on_player_spawned() {
  self thread function_7723353c();
  self function_39440031();
}

get_perk_machines() {
  if(!isDefined(level.perk_machines)) {
    level.perk_machines = [];
  }

  return level.perk_machines;
}

perk_machine_think(str_key, s_custom_perk) {
  str_endon = str_key + "_power_thread_end";
  level endon(str_endon);
  str_on = s_custom_perk.alias + "_on";
  str_off = s_custom_perk.alias + "_off";
  str_notify = str_key + "_power_on";

  while(true) {
    machine = getEntArray(s_custom_perk.radiant_machine_name, "targetname");

    for(i = 0; i < machine.size; i++) {
      machine[i] setModel(level.machine_assets[str_key].off_model);
      machine[i] solid();
      machine[i].script_noteworthy = str_key;
      level.perk_machines[level.perk_machines.size] = machine[i];
    }

    level thread do_initial_power_off_callback(machine, str_key);
    array::thread_all(machine, &set_power_on, 0);
    level waittill(str_on);

    for(i = 0; i < machine.size; i++) {
      machine[i] setModel(level.machine_assets[str_key].on_model);
      machine[i] vibrate((0, -100, 0), 0.3, 0.4, 3);
      machine[i] playSound(#"zmb_perks_power_on");
      machine[i] thread perk_fx(s_custom_perk.machine_light_effect);
      machine[i] thread play_loop_on_machine();
    }

    level notify(str_notify);
    array::thread_all(machine, &set_power_on, 1);

    if(isDefined(level.machine_assets[str_key].power_on_callback)) {
      array::thread_all(machine, level.machine_assets[str_key].power_on_callback);
    }

    level waittill(str_off);

    if(isDefined(level.machine_assets[str_key].power_off_callback)) {
      array::thread_all(machine, level.machine_assets[str_key].power_off_callback);
    }

    array::thread_all(machine, &turn_perk_off);
  }
}

default_vending_precaching() {
  if(level._custom_perks.size > 0) {
    a_keys = getarraykeys(level._custom_perks);

    for(i = 0; i < a_keys.size; i++) {
      if(isDefined(level._custom_perks[a_keys[i]].precache_func)) {
        level[[level._custom_perks[a_keys[i]].precache_func]]();
      }
    }
  }
}

do_initial_power_off_callback(machine_array, perkname) {
  if(!isDefined(level.machine_assets[perkname])) {
    println("<dev string:x80>");
    return;
  }

  if(!isDefined(level.machine_assets[perkname].power_off_callback)) {
    return;
  }

  waitframe(1);
  array::thread_all(machine_array, level.machine_assets[perkname].power_off_callback);
}

set_power_on(state) {
  self.power_on = state;
}

turn_perk_off(ishidden) {
  self notify(#"stop_loopsound");

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
    return;
  }

  perk_fx(undefined, 1);
}

play_loop_on_machine() {
  if(isDefined(level.var_29a12b0)) {
    return;
  }

  sound_ent = spawn("script_origin", self.origin);
  sound_ent playLoopSound(#"zmb_perks_machine_loop");
  sound_ent linkto(self);
  self waittill(#"stop_loopsound");
  sound_ent unlink();
  sound_ent delete();
}

perk_fx(fx, turnofffx) {
  if(isDefined(turnofffx)) {
    self.perk_fx = 0;

    if(isDefined(self.b_keep_when_turned_off) && self.b_keep_when_turned_off && isDefined(self.s_fxloc)) {
      self.s_fxloc delete();
    }

    return;
  }

  wait 3;

  if(!isDefined(self)) {
    return;
  }

  if(!(isDefined(self.b_keep_when_turned_off) && self.b_keep_when_turned_off)) {
    if(isDefined(self) && !(isDefined(self.perk_fx) && self.perk_fx)) {
      playFXOnTag(level._effect[fx], self, "tag_origin");
      self.perk_fx = 1;
    }

    return;
  }

  if(isDefined(self) && !isDefined(self.s_fxloc)) {
    self.s_fxloc = util::spawn_model("tag_origin", self.origin);
    playFXOnTag(level._effect[fx], self.s_fxloc, "tag_origin");
    self.perk_fx = 1;
  }
}

electric_perks_dialog() {
  self endon(#"death");
  wait 0.01;
  level flag::wait_till("start_zombie_round_logic");
  players = getplayers();

  if(players.size == 1) {
    return;
  }

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

      if(dist < 4900 && timer == 3) {
        if(!isDefined(players[i])) {
          continue;
        }

        players[i] thread zm_utility::do_player_vo("vox_start", 5);
        wait 3;
        self notify(#"warning_dialog");

        iprintlnbold("<dev string:xe1>");

      }
    }
  }
}

reset_vending_hint_string() {
  perk = self.script_noteworthy;

  if(isDefined(level._custom_perks)) {
    if(isDefined(level._custom_perks[perk]) && isDefined(level._custom_perks[perk].cost) && isDefined(level._custom_perks[perk].hint_string)) {
      n_cost = function_6f418fda(perk);
      self sethintstring(level._custom_perks[perk].hint_string, n_cost);
    }
  }
}

function_6f418fda(perk) {
  if(isfunctionptr(level._custom_perks[perk].cost)) {
    n_cost = [[level._custom_perks[perk].cost]]();
  } else {
    n_cost = level._custom_perks[perk].cost;
  }

  return n_cost;
}

vending_trigger_can_player_use(player, var_93e7ba4f) {
  if(!isplayer(player)) {
    return false;
  }

  if(player laststand::player_is_in_laststand() || isDefined(player.intermission) && player.intermission) {
    return false;
  }

  if(player zm_utility::in_revive_trigger()) {
    return false;
  }

  if(player isthrowinggrenade()) {
    return false;
  }

  if(player isswitchingweapons()) {
    return false;
  }

  if(player zm_utility::is_drinking()) {
    return false;
  }

  if(isDefined(var_93e7ba4f) && var_93e7ba4f) {
    var_7dbbbf1f = array::exclude(level.var_b8be892e, player.perks_active);

    if(!isDefined(var_7dbbbf1f)) {
      return false;
    }

    if(isDefined(self.stub) && isDefined(self.stub.machine) && isDefined(player.var_c27f1e90[self.stub.machine.script_int])) {
      if(!isinarray(level.var_b8be892e, player.var_c27f1e90[self.stub.machine.script_int])) {
        return false;
      }
    }
  }

  return true;
}

function_f29c0595() {
  self endon(#"death");
  wait 0.01;
  perk = self.script_noteworthy;
  level.revive_machine_is_solo = 0;

  if(isDefined(perk) && perk == #"specialty_quickrevive") {
    level flag::wait_till("start_zombie_round_logic");
    self endon(#"stop_quickrevive_logic");
    level.quick_revive_trigger = self;

    if(level.players.size == 1) {
      level.revive_machine_is_solo = 1;
    }
  }

  cost = zombie_utility::get_zombie_var(#"zombie_perk_cost");

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
  notify_name = perk + "_power_on";
  level waittill(notify_name);

  if(!isDefined(level._perkmachinenetworkchoke)) {
    level._perkmachinenetworkchoke = 0;
  } else {
    level._perkmachinenetworkchoke++;
  }

  for(i = 0; i < level._perkmachinenetworkchoke; i++) {
    util::wait_network_frame();
  }

  if(isDefined(level._custom_perks[perk]) && isDefined(level._custom_perks[perk].hint_string)) {
    self.hint_string = level._custom_perks[perk].hint_string;
    self.hint_parm1 = cost;
  }
}

vending_trigger_think() {
  self endon(#"death");
  perk = self.script_noteworthy;
  cost = self.stub.cost;
  n_slot = self.stub.script_int;
  self thread zm_audio::sndperksjingles_timer();

  for(;;) {
    waitresult = self waittill(#"trigger");
    player = waitresult.activator;
    var_f2a92d5e = 0;

    if(isDefined(self.stub.machine)) {
      var_f2a92d5e = self.stub.machine.power_on;
    }

    if(!var_f2a92d5e) {
      wait 0.1;
      continue;
    }

    index = zm_utility::get_player_index(player);

    if(!vending_trigger_can_player_use(player, 1)) {
      wait 0.1;
      continue;
    }

    if(player hasperk(perk) || player has_perk_paused(perk)) {
      cheat = 0;

      if(getdvarint(#"zombie_cheat", 0) >= 5) {
        cheat = 1;
      }

        if(cheat != 1) {
          zm_utility::play_sound_on_ent("no_purchase");
          continue;
        }
    }

    if(isDefined(level.custom_perk_validation)) {
      valid = self[[level.custom_perk_validation]](player);

      if(!valid) {
        continue;
      }
    }

    current_cost = cost;

    if(n_slot == 0 && isDefined(player.talisman_perk_reducecost_1) && player.talisman_perk_reducecost_1) {
      current_cost -= player.talisman_perk_reducecost_1;
    }

    if(n_slot == 1 && isDefined(player.talisman_perk_reducecost_2) && player.talisman_perk_reducecost_2) {
      current_cost -= player.talisman_perk_reducecost_2;
    }

    if(n_slot == 2 && isDefined(player.talisman_perk_reducecost_3) && player.talisman_perk_reducecost_3) {
      current_cost -= player.talisman_perk_reducecost_3;
    }

    if(n_slot == 3 && isDefined(player.talisman_perk_reducecost_4) && player.talisman_perk_reducecost_4) {
      current_cost -= player.talisman_perk_reducecost_4;
    }

    if(!player zm_score::can_player_purchase(current_cost)) {
      zm_utility::play_sound_on_ent("no_purchase");
      player zm_audio::create_and_play_dialog(#"general", #"outofmoney");
      continue;
    }

    if(!player zm_utility::can_player_purchase_perk()) {
      zm_utility::play_sound_on_ent("no_purchase");
      continue;
    }

    sound = "evt_bottle_dispense";
    playsoundatposition(sound, self.origin);
    player zm_score::minus_to_player_score(current_cost);
    bb::logpurchaseevent(player, self, current_cost, perk, 0, "_perk", "_purchased");
    perkhash = -1;

    if(isDefined(level._custom_perks[perk]) && isDefined(level._custom_perks[perk].alias)) {
      perkhash = level._custom_perks[perk].alias;
    }

    player recordmapevent(29, gettime(), self.origin, level.round_number, perkhash);
    player.perk_purchased = perk;
    player notify(#"perk_purchased", {
      #perk: perk
    });
    self thread zm_audio::sndperksjingles_player(1);
    self thread vending_trigger_post_think(player, perk);
  }
}

vending_trigger_post_think(player, perk) {
  player endon(#"disconnect", #"end_game", #"perk_abort_drinking");
  player perk_give_bottle_begin(perk);
  evt = player waittilltimeout(3, #"fake_death", #"death", #"player_downed", #"offhand_end", #"perk_abort_drinking", #"disconnect");

  if(evt._notify == "offhand_end" || evt._notify == #"timeout") {
    player thread wait_give_perk(perk);
  }

  if(player laststand::player_is_in_laststand() || isDefined(player.intermission) && player.intermission) {
    return;
  }

  player notify(#"burp");

  if(isDefined(level.var_c4bedce3)) {
    player[[level.var_c4bedce3]](perk);
  }

  player.perk_purchased = undefined;

  if(!(isDefined(self.stub.machine.power_on) && self.stub.machine.power_on)) {
    wait 1;
    perk_pause(self.script_noteworthy);
  }
}

wait_give_perk(perk) {
  self endon(#"player_downed", #"disconnect", #"end_game", #"perk_abort_drinking");
  self waittilltimeout(0.5, #"burp", #"player_downed", #"disconnect", #"end_game", #"perk_abort_drinking");
  self function_a7ae070c(perk);
  self thread give_perk_presentation(perk);
  self notify(#"perk_bought", {
    #var_16c042b8: perk
  });
  self zm_stats::increment_challenge_stat(#"survivalist_buy_perk");
}

give_perk_presentation(perk) {
  self endon(#"player_downed", #"disconnect", #"end_game", #"perk_abort_drinking");
  self zm_audio::playerexert("burp");
  self thread function_305131b1(perk);
}

function_305131b1(perk) {
  self endon(#"death");
  b_played = self zm_audio::create_and_play_dialog(#"perk", perk);

  if(!(isDefined(b_played) && b_played)) {
    self zm_audio::create_and_play_dialog(#"perk", #"generic");
  }
}

function_a7ae070c(var_16c042b8, var_b169f6df = 0) {
  self perks::perk_setperk(var_16c042b8);

  if(isDefined(level._custom_perks[var_16c042b8].var_658e2856)) {
    if(isarray(level._custom_perks[var_16c042b8].var_658e2856)) {
      foreach(specialty in level._custom_perks[var_16c042b8].var_658e2856) {
        perks::perk_setperk(specialty);
      }
    } else {
      perks::perk_setperk(level._custom_perks[var_16c042b8].var_658e2856);
    }
  }

  if(!var_b169f6df) {
    self.num_perks++;
  }

  if(!isinarray(self.var_67ba1237, var_16c042b8)) {
    if(!isDefined(self.var_67ba1237)) {
      self.var_67ba1237 = [];
    } else if(!isarray(self.var_67ba1237)) {
      self.var_67ba1237 = array(self.var_67ba1237);
    }

    self.var_67ba1237[self.var_67ba1237.size] = var_16c042b8;
    self.var_eabca645[level._custom_perks[var_16c042b8].alias] = self.var_ab375b18;
    self.var_ab375b18++;
  }

  var_9a0250b7 = level._custom_perks[var_16c042b8].alias;
  self function_2ac7579(-1, 1, var_9a0250b7);
  self function_81bc6765(-1, var_9a0250b7);

  if(isDefined(level._custom_perks[var_16c042b8]) && isDefined(level._custom_perks[var_16c042b8].player_thread_give)) {
    self thread[[level._custom_perks[var_16c042b8].player_thread_give]]();
  }

  self set_perk_clientfield(var_16c042b8, 1);

  if(!zm_trial_randomize_perks::is_active()) {
    demo::bookmark(#"zm_player_perk", gettime(), self);
    potm::bookmark(#"zm_player_perk", gettime(), self);
    self zm_stats::increment_client_stat("perks_drank");
    self zm_stats::increment_client_stat(var_16c042b8 + "_drank");
    self zm_stats::increment_player_stat(var_16c042b8 + "_drank");
    self zm_stats::increment_player_stat("perks_drank");

    if(!isDefined(self.perk_history)) {
      self.perk_history = [];
    } else if(!isarray(self.perk_history)) {
      self.perk_history = array(self.perk_history);
    }

    if(!isinarray(self.perk_history, var_16c042b8)) {
      self.perk_history[self.perk_history.size] = var_16c042b8;
    }
  }

  self notify(#"perk_acquired", {
    #var_16c042b8: var_16c042b8
  });
  self thread perk_think(var_16c042b8);
}

vending_set_hintstring(perk) {
  switch (perk) {
    case #"specialty_armorvest":
      break;
  }
}

perk_think(perk) {
  self endon(#"disconnect");
  perk_str = perk + "_stop";
  result = self waittill(#"fake_death", #"death", #"player_downed", perk_str);
  result = result._notify;
  self perks::perk_unsetperk(perk);

  if(isDefined(level._custom_perks[perk].var_658e2856)) {
    if(isarray(level._custom_perks[perk].var_658e2856)) {
      foreach(specialty in level._custom_perks[perk].var_658e2856) {
        perks::perk_unsetperk(specialty);
      }
    } else {
      perks::perk_unsetperk(level._custom_perks[perk].var_658e2856);
    }
  }

  self.num_perks--;

  if(isDefined(level._custom_perks[perk]) && isDefined(level._custom_perks[perk].player_thread_take)) {
    self thread[[level._custom_perks[perk].player_thread_take]](0, perk_str, result, -1);
  }

  self set_perk_clientfield(perk, 0);
  self.perk_purchased = undefined;

  if(isDefined(level.var_a903ab55)) {
    self[[level.var_a903ab55]](perk);
  }

  self function_2ac7579(-1, 0, level._custom_perks[hash(perk)].alias);

  if(isinarray(self.var_67ba1237, perk)) {
    arrayremovevalue(self.var_67ba1237, perk, 1);
    arrayremoveindex(self.var_eabca645, level._custom_perks[hash(perk)].alias, 1);
    self.var_ab375b18--;
  }

  self notify(#"extra_perk_lost");
}

set_perk_clientfield(perk, state) {
  if(isDefined(level._custom_perks[perk]) && isDefined(level._custom_perks[perk].clientfield_set)) {
    self[[level._custom_perks[perk].clientfield_set]](state);
  }
}

perk_give_bottle_begin(str_perk) {
  weapon = get_perk_weapon(str_perk);
  self thread gestures::function_f3e2696f(self, weapon, undefined, 2.5, undefined, undefined, undefined);
}

get_perk_weapon(str_perk) {
  weapon = "";
  assert(isDefined(str_perk), "<dev string:xf1>");

  if(!isDefined(str_perk)) {
    return weapon;
  }

  if(!isDefined(level._custom_perks)) {
    return weapon;
  }

  if(level.var_c3e5c4cd == 1) {
    if(isDefined(level._custom_perks[str_perk]) && isDefined(level._custom_perks[str_perk].perk_bottle_weapon)) {
      weapon = level._custom_perks[str_perk].perk_bottle_weapon;
    }
  } else if(isDefined(level._custom_perks[str_perk]) && isDefined(level._custom_perks[str_perk].var_66de8d1c)) {
    weapon = level._custom_perks[str_perk].var_66de8d1c;
  }

  return weapon;
}

get_perk_weapon_model(str_perk) {
  weapon = get_perk_weapon(str_perk);
  assert(isDefined(weapon), "<dev string:x116>" + str_perk);
  assert(isDefined(weapon.worldmodel), "<dev string:x132>" + str_perk);

  if(isDefined(weapon)) {
    return weapon.worldmodel;
  }

  return "tag_origin";
}

perk_abort_drinking(post_delay) {
  if(zm_utility::is_drinking()) {
    self notify(#"perk_abort_drinking");

    if(isDefined(post_delay)) {
      wait post_delay;
    }
  }
}

function_b2cba45a(var_9bf8fb5c) {
  if(self.var_67ba1237.size >= 6) {
    return undefined;
  }

  var_16c042b8 = self function_5ea0c6cf(var_9bf8fb5c);

  if(isDefined(var_16c042b8)) {
    self function_a7ae070c(var_16c042b8);
    return var_16c042b8;
  }

  self playsoundtoplayer(level.zmb_laugh_alias, self);
  return undefined;
}

lose_random_perk() {
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
  }
}

quantum_bomb_give_nearest_perk_validation(position) {
  vending_machines = get_perk_machines();
  range_squared = 32400;

  for(i = 0; i < vending_machines.size; i++) {
    if(distancesquared(vending_machines[i].origin, position) < range_squared) {
      return true;
    }
  }

  return false;
}

quantum_bomb_give_nearest_perk_result(position) {
  [[level.var_77926928]](position);
  vending_machines = get_perk_machines();
  nearest = 0;

  for(i = 1; i < vending_machines.size; i++) {
    if(distancesquared(vending_machines[i].origin, position) < distancesquared(vending_machines[nearest].origin, position)) {
      nearest = i;
    }
  }

  players = getplayers();
  perk = vending_machines[nearest].script_noteworthy;

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(player.sessionstate == "spectator" || player laststand::player_is_in_laststand()) {
      continue;
    }

    if(!player hasperk(perk) && (!isDefined(player.perk_purchased) || player.perk_purchased != perk) && randomint(5)) {
      player function_a7ae070c(perk);
      player[[level.var_cbbe9244]]();
    }
  }
}

perk_pause(perk) {
  if(isDefined(level.dont_unset_perk_when_machine_paused) && level.dont_unset_perk_when_machine_paused) {
    return;
  }

  for(j = 0; j < getplayers().size; j++) {
    player = getplayers()[j];

    if(player function_e56d8ef4(perk)) {
      continue;
    }

    if(!isDefined(player.var_c4890291)) {
      player.var_c4890291 = [];
    }

    player.var_c4890291[perk] = isDefined(player.var_c4890291[perk]) && player.var_c4890291[perk] || player hasperk(perk);

    if(player.var_c4890291[perk]) {
      player perks::perk_unsetperk(perk);

      if(isDefined(level._custom_perks[perk].var_658e2856)) {
        if(isarray(level._custom_perks[perk].var_658e2856)) {
          foreach(specialty in level._custom_perks[perk].var_658e2856) {
            perks::perk_unsetperk(specialty);
          }
        } else {
          perks::perk_unsetperk(level._custom_perks[perk].var_658e2856);
        }
      }

      n_slot = player function_c1efcc57(perk);
      player function_2ac7579(n_slot, 0, level._custom_perks[perk].alias);
      player set_perk_clientfield(perk, 2);

      if(isDefined(level._custom_perks[perk]) && isDefined(level._custom_perks[perk].player_thread_take)) {
        player thread[[level._custom_perks[perk].player_thread_take]](1, undefined, undefined, -1);
      }

      println("<dev string:x15a>" + player.name + "<dev string:x167>" + perk + "<dev string:x177>");
    }
  }
}

perk_unpause(perk) {
  if(isDefined(level.dont_unset_perk_when_machine_paused) && level.dont_unset_perk_when_machine_paused) {
    return;
  }

  if(!isDefined(perk)) {
    return;
  }

  for(j = 0; j < getplayers().size; j++) {
    player = getplayers()[j];

    if(isDefined(player.var_c4890291) && isDefined(player.var_c4890291[perk]) && player.var_c4890291[perk]) {
      player.var_c4890291[perk] = 0;
      player set_perk_clientfield(perk, 1);
      n_slot = player function_c1efcc57(perk);
      player function_2ac7579(n_slot, 1, level._custom_perks[perk].alias);
      player perks::perk_setperk(perk);

      if(isDefined(level._custom_perks[perk].var_658e2856)) {
        if(isarray(level._custom_perks[perk].var_658e2856)) {
          foreach(specialty in level._custom_perks[perk].var_658e2856) {
            perks::perk_setperk(specialty);
          }
        } else {
          perks::perk_setperk(level._custom_perks[perk].var_658e2856);
        }
      }

      println("<dev string:x15a>" + player.name + "<dev string:x17b>" + perk + "<dev string:x177>");
      player zm_utility::set_max_health();

      if(isDefined(level._custom_perks[perk]) && isDefined(level._custom_perks[perk].player_thread_give)) {
        player thread[[level._custom_perks[perk].player_thread_give]]();
      }
    }
  }
}

perk_pause_all_perks(power_zone) {
  vending_machines = get_perk_machines();

  foreach(trigger in vending_machines) {
    if(!isDefined(power_zone)) {
      perk_pause(trigger.script_noteworthy);
      continue;
    }

    if(isDefined(trigger.script_int) && trigger.script_int == power_zone) {
      perk_pause(trigger.script_noteworthy);
    }
  }
}

perk_unpause_all_perks(power_zone) {
  vending_machines = get_perk_machines();

  foreach(trigger in vending_machines) {
    if(!isDefined(power_zone)) {
      perk_unpause(trigger.script_noteworthy);
      continue;
    }

    if(isDefined(trigger.script_int) && trigger.script_int == power_zone) {
      perk_unpause(trigger.script_noteworthy);
    }
  }
}

function_d053f137() {
  if(isDefined(level.var_b8be892e)) {
    foreach(var_83225a27 in level.var_b8be892e) {
      perk_pause(var_83225a27);
    }
  }
}

function_d087adc6() {
  if(isDefined(level.var_b8be892e)) {
    foreach(var_83225a27 in level.var_b8be892e) {
      perk_unpause(var_83225a27);
    }
  }
}

has_perk_paused(perk) {
  if(isDefined(self.var_c4890291) && isDefined(self.var_c4890291[perk]) && self.var_c4890291[perk]) {
    return true;
  }

  return false;
}

getvendingmachinenotify() {
  if(!isDefined(self)) {
    return "";
  }

  str_perk = undefined;

  if(isDefined(level._custom_perks[self.script_noteworthy]) && isDefined(isDefined(level._custom_perks[self.script_noteworthy].alias))) {
    str_perk = level._custom_perks[self.script_noteworthy].alias;
  }

  return str_perk;
}

function_80cb4982() {
  return self.var_67ba1237.size >= 6;
}

perk_machine_removal(machine, replacement_model) {
  if(!isDefined(machine)) {
    return;
  }

  trig = getent(machine, "script_noteworthy");
  machine_model = undefined;

  if(isDefined(trig)) {
    trig notify(#"warning_dialog");

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

perk_machine_spawn_init() {
  match_string = "";
  location = level.scr_zm_map_start_location;

  if((location == "default" || location == "") && isDefined(level.default_start_location)) {
    location = level.default_start_location;
  }

  match_string = level.scr_zm_ui_gametype + "_perks_" + location;
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

      width = 64;
      height = 128;
      length = 64;
      up = 60;
      fwd = 20;
      forward = anglestoright(s_spawn_pos.angles) * fwd;
      unitrigger_stub = spawnStruct();
      unitrigger_stub.origin = s_spawn_pos.origin + (0, 0, up) + forward;
      unitrigger_stub.angles = s_spawn_pos.angles;
      unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
      unitrigger_stub.cursor_hint = "HINT_NOICON";
      unitrigger_stub.script_width = width;
      unitrigger_stub.script_height = height;
      unitrigger_stub.script_length = length;
      unitrigger_stub.require_look_at = 0;
      unitrigger_stub.targetname = "zombie_vending";
      unitrigger_stub.script_noteworthy = perk;
      unitrigger_stub.hint_string = #"zombie/need_power";
      unitrigger_stub.hint_parm1 = undefined;
      unitrigger_stub.hint_parm2 = undefined;

      if(isDefined(s_spawn_pos.script_int)) {
        unitrigger_stub.script_int = s_spawn_pos.script_int;
      }

      zm_unitrigger::unitrigger_force_per_player_triggers(unitrigger_stub, 1);
      unitrigger_stub.prompt_and_visibility_func = &function_5296af32;
      zm_unitrigger::register_static_unitrigger(unitrigger_stub, &vending_trigger_think);
      perk_machine = spawn("script_model", s_spawn_pos.origin);

      if(!isDefined(s_spawn_pos.angles)) {
        s_spawn_pos.angles = (0, 0, 0);
      }

      perk_machine.angles = s_spawn_pos.angles;
      perk_machine setModel(s_spawn_pos.model);

      if(isDefined(level._no_vending_machine_bump_trigs) && level._no_vending_machine_bump_trigs) {
        bump_trigger = undefined;
      } else {
        bump_trigger = spawn("trigger_radius", s_spawn_pos.origin + (0, 0, 30), 0, 40, 80, 1);
        bump_trigger.script_activated = 1;
        bump_trigger.script_sound = "zmb_perks_bump_bottle";
        bump_trigger.targetname = "audio_bump_trigger";
      }

      if(isDefined(level._no_vending_machine_auto_collision) && level._no_vending_machine_auto_collision) {
        collision = undefined;
      } else {
        collision = spawn("script_model", s_spawn_pos.origin, 1);
        collision.angles = s_spawn_pos.angles;
        collision setModel(#"zm_collision_perks1");
        collision.script_noteworthy = "clip";
        collision disconnectpaths();
      }

      unitrigger_stub.clip = collision;
      unitrigger_stub.machine = perk_machine;
      unitrigger_stub.bump = bump_trigger;

      if(isDefined(s_spawn_pos.script_notify)) {
        perk_machine.script_notify = s_spawn_pos.script_notify;
      }

      if(isDefined(s_spawn_pos.target)) {
        perk_machine.target = s_spawn_pos.target;
      }

      if(isDefined(s_spawn_pos.blocker_model)) {
        unitrigger_stub.blocker_model = s_spawn_pos.blocker_model;
      }

      if(isDefined(s_spawn_pos.script_int)) {
        perk_machine.script_int = s_spawn_pos.script_int;
      }

      if(isDefined(s_spawn_pos.turn_on_notify)) {
        perk_machine.turn_on_notify = s_spawn_pos.turn_on_notify;
      }

      unitrigger_stub.script_sound = "mus_perks_speed_jingle";
      unitrigger_stub.script_string = "speedcola_perk";
      unitrigger_stub.script_label = "mus_perks_speed_sting";
      unitrigger_stub.target = "vending_sleight";
      perk_machine.script_string = "speedcola_perk";
      perk_machine.targetname = "vending_sleight";

      if(isDefined(bump_trigger)) {
        bump_trigger.script_string = "speedcola_perk";
      }

      if(isDefined(level._custom_perks[perk]) && isDefined(level._custom_perks[perk].perk_machine_set_kvps)) {
        [
          [level._custom_perks[perk].perk_machine_set_kvps]
        ](unitrigger_stub, perk_machine, bump_trigger, collision);
      }

      unitrigger_stub thread function_f29c0595();
      unitrigger_stub thread electric_perks_dialog();
    }
  }
}

function_5296af32(player) {
  perk = self.script_noteworthy;
  var_f2a92d5e = 0;

  if(isDefined(self.stub.machine)) {
    var_f2a92d5e = self.stub.machine.power_on;
  }

  if(isDefined(perk) && !player hasperk(perk) && self vending_trigger_can_player_use(player, 1) && !player has_perk_paused(perk) && !player zm_utility::in_revive_trigger() && !zm_equipment::is_equipment_that_blocks_purchase(player getcurrentweapon()) && !player zm_equipment::hacker_active()) {
    b_is_invis = 0;

    if(!var_f2a92d5e) {
      self.stub.hint_string = #"zombie/need_power";
      self.stub.hint_parm1 = undefined;
    } else {
      cost = zombie_utility::get_zombie_var(#"zombie_perk_cost");

      if(isDefined(level._custom_perks[perk]) && isDefined(level._custom_perks[perk].cost)) {
        if(isint(level._custom_perks[perk].cost)) {
          cost = level._custom_perks[perk].cost;
        } else {
          cost = [
            [level._custom_perks[perk].cost]
          ]();
        }
      }

      self.stub.hint_string = level._custom_perks[perk].hint_string;
      self.stub.hint_parm1 = cost;
    }

    zm_unitrigger::function_d0676c62(self.stub, self, player);
  } else {
    b_is_invis = 1;
  }

  return !b_is_invis;
}

check_player_has_perk(perk) {
  self endon(#"death");

  if(getdvarint(#"zombie_cheat", 0) >= 5) {
    return;
  }

    dist = 16384;

  while(true) {
    players = getplayers();

    for(i = 0; i < players.size; i++) {
      if(distancesquared(players[i].origin, self.origin) < dist) {
        if(!players[i] hasperk(perk) && self vending_trigger_can_player_use(players[i], 1) && !players[i] has_perk_paused(perk) && !players[i] zm_utility::in_revive_trigger() && !zm_equipment::is_equipment_that_blocks_purchase(players[i] getcurrentweapon()) && !players[i] zm_equipment::hacker_active()) {
          self setinvisibletoplayer(players[i], 0);
          continue;
        }

        self setinvisibletoplayer(players[i], 1);
      }
    }

    wait 0.1;
  }
}

get_perk_machine_start_state(perk) {
  if(isDefined(level.vending_machines_powered_on_at_start) && level.vending_machines_powered_on_at_start) {
    return 1;
  }

  if(perk == #"specialty_quickrevive") {
    assert(isDefined(level.revive_machine_is_solo));
    return level.revive_machine_is_solo;
  }

  return 0;
}

perks_register_clientfield() {
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

  for(i = 0; i < 4; i++) {
    clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".itemIndex", 1, 5, "int", 0);
    clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".state", 1, 2, "int", 0);
    clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".progress", 1, 5, "float", 0);
    clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".chargeCount", 1, 3, "int", 0);
    clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".timerActive", 1, 1, "int", 0);
    clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".bleedoutOrderIndex", 1, 2, "int", 0);
    clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".bleedoutActive", 1, 1, "int", 0);
    clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".specialEffectActive", 1, 1, "int", 0);
    clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".modifierActive", 6000, 1, "int", 0);
  }

  clientfield::register_clientuimodel("hudItems.perkVapor.bleedoutProgress", 9000, 8, "float", 0);

  for(i = 0; i < 6; i++) {
    n_version = 1;

    if(i >= 4) {
      n_version = 8000;
    }

    clientfield::register_clientuimodel("hudItems.extraPerkVapor." + i + ".itemIndex", n_version, 5, "int", 0);
    clientfield::register_clientuimodel("hudItems.extraPerkVapor." + i + ".state", n_version, 2, "int", 0);
    clientfield::register_clientuimodel("hudItems.extraPerkVapor." + i + ".progress", n_version, 5, "float", 0);
    clientfield::register_clientuimodel("hudItems.extraPerkVapor." + i + ".chargeCount", n_version, 3, "int", 0);
    clientfield::register_clientuimodel("hudItems.extraPerkVapor." + i + ".timerActive", n_version, 1, "int", 0);
    clientfield::register_clientuimodel("hudItems.extraPerkVapor." + i + ".specialEffectActive", n_version, 1, "int", 0);
  }

  clientfield::register("scriptmover", "" + #"hash_cf74c35ecc5a49", 1, 1, "int");
  clientfield::register("toplayer", "" + #"hash_35fe26fc5cb223b3", 1, 3, "int");
  clientfield::register("toplayer", "" + #"hash_6fb426c48a4877e0", 1, 3, "int");
  clientfield::register("toplayer", "" + #"hash_345845080e40675d", 1, 3, "int");
  clientfield::register("toplayer", "" + #"hash_1da6660f0414562", 1, 3, "int");

  if(level.var_c3e5c4cd == 2) {
    clientfield::register("world", "" + #"hash_46334db9e3c76275", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_50eb488e58f66198", 1, 1, "int");
    clientfield::register("allplayers", "" + #"hash_222c3403d2641ea6", 1, 3, "int");
    clientfield::register("toplayer", "" + #"hash_17283692696da23b", 1, 1, "counter");
  }
}

function_ad1814a1(n_index, var_b0ab4cec) {
  if(isDefined(n_index) && n_index >= 0 && n_index < 6) {
    return true;
  }

  println("<dev string:x18d>" + function_9e72a96(var_b0ab4cec) + "<dev string:x19b>");
  return false;
}

function_81bc6765(var_481d50cb, var_b0ab4cec) {
  if(var_481d50cb == -1) {
    if(function_ad1814a1(self.var_eabca645[var_b0ab4cec], var_b0ab4cec)) {
      self clientfield::set_player_uimodel("hudItems.extraPerkVapor." + self.var_eabca645[var_b0ab4cec] + ".itemIndex", getitemindexfromref(var_b0ab4cec));
    }

    return;
  }

  if(var_481d50cb < 4) {
    self clientfield::set_player_uimodel("hudItems.perkVapor." + var_481d50cb + ".itemIndex", getitemindexfromref(var_b0ab4cec));
  }
}

function_2ac7579(var_481d50cb, var_dc149467 = 0, var_b0ab4cec) {
  assert(isDefined(var_481d50cb), "<dev string:x1d4>");

  if(!isDefined(var_481d50cb)) {
    return;
  }

  if(var_481d50cb == -1 && isDefined(var_b0ab4cec)) {
    if(function_ad1814a1(self.var_eabca645[var_b0ab4cec], var_b0ab4cec)) {
      self clientfield::set_player_uimodel("hudItems.extraPerkVapor." + self.var_eabca645[var_b0ab4cec] + ".state", var_dc149467);
    }

    return;
  }

  if(var_481d50cb < 4) {
    self clientfield::set_player_uimodel("hudItems.perkVapor." + var_481d50cb + ".state", var_dc149467);
  }
}

function_13880aa5(var_481d50cb, var_87eb3522 = 0, var_b0ab4cec) {
  assert(isDefined(var_481d50cb), "<dev string:x1d4>");

  if(!isDefined(var_481d50cb)) {
    return;
  }

  if(!isDefined(self.var_f18b8e91)) {
    self.var_f18b8e91 = [];
  }

  if(var_87eb3522 == 1 && isDefined(var_b0ab4cec) && self.var_f18b8e91[var_b0ab4cec] !== 1) {
    self.var_f18b8e91[var_b0ab4cec] = 1;
    self playsoundtoplayer(#"hash_7e01de7cf0aa4995", self);
  } else if(var_87eb3522 != 1) {
    self.var_f18b8e91[var_b0ab4cec] = var_87eb3522;
  }

  if(var_481d50cb == -1 && isDefined(var_b0ab4cec)) {
    if(function_ad1814a1(self.var_eabca645[var_b0ab4cec], var_b0ab4cec)) {
      self clientfield::set_player_uimodel("hudItems.extraPerkVapor." + self.var_eabca645[var_b0ab4cec] + ".progress", var_87eb3522);
    }

    return;
  }

  if(var_481d50cb < 4) {
    self clientfield::set_player_uimodel("hudItems.perkVapor." + var_481d50cb + ".progress", var_87eb3522);
  }
}

function_f2ff97a6(var_481d50cb, var_c3d1c893 = 0, var_b0ab4cec) {
  assert(isDefined(var_481d50cb), "<dev string:x1d4>");

  if(!isDefined(var_481d50cb)) {
    return;
  }

  if(var_481d50cb == -1 && isDefined(var_b0ab4cec)) {
    if(function_ad1814a1(self.var_eabca645[var_b0ab4cec], var_b0ab4cec)) {
      self clientfield::set_player_uimodel("hudItems.extraPerkVapor." + self.var_eabca645[var_b0ab4cec] + ".chargeCount", var_c3d1c893);
    }

    return;
  }

  self clientfield::set_player_uimodel("hudItems.perkVapor." + var_481d50cb + ".chargeCount", var_c3d1c893);
}

function_f0ac059f(var_481d50cb, b_active = 0, var_b0ab4cec) {
  assert(isDefined(var_481d50cb), "<dev string:x1d4>");

  if(!isDefined(var_481d50cb)) {
    return;
  }

  if(var_481d50cb == -1 && isDefined(var_b0ab4cec)) {
    if(function_ad1814a1(self.var_eabca645[var_b0ab4cec], var_b0ab4cec)) {
      self clientfield::set_player_uimodel("hudItems.extraPerkVapor." + self.var_eabca645[var_b0ab4cec] + ".timerActive", b_active);
    }

    return;
  }

  self clientfield::set_player_uimodel("hudItems.perkVapor." + var_481d50cb + ".timerActive", b_active);
}

function_c8c7bc5(var_481d50cb, b_active = 0, var_b0ab4cec) {
  assert(isDefined(var_481d50cb), "<dev string:x1d4>");

  if(!isDefined(var_481d50cb)) {
    return;
  }

  if(var_481d50cb == -1 && isDefined(var_b0ab4cec)) {
    if(function_ad1814a1(self.var_eabca645[var_b0ab4cec], var_b0ab4cec)) {
      self clientfield::set_player_uimodel("hudItems.extraPerkVapor." + self.var_eabca645[var_b0ab4cec] + ".specialEffectActive", b_active);
    }

    return;
  }

  self clientfield::set_player_uimodel("hudItems.perkVapor." + var_481d50cb + ".specialEffectActive", b_active);
}

function_b8c12b0f(var_481d50cb, b_active = 0) {
  if(var_481d50cb < 4) {
    self clientfield::set_player_uimodel("hudItems.perkVapor." + var_481d50cb + ".modifierActive", b_active);
  }
}

function_4acf7b43(n_slot, var_16c042b8) {
  if(!isDefined(level._custom_perks)) {
    return;
  }

  if(isDefined(level._custom_perks[var_16c042b8])) {
    var_52905dda = level._custom_perks[var_16c042b8].alias;
  }

  if(isDefined(var_52905dda)) {
    self thread function_81bc6765(n_slot, var_52905dda);
  }
}

thread_bump_trigger() {
  for(;;) {
    waitresult = self waittill(#"trigger");
    trigplayer = waitresult.activator;
    trigplayer playSound(self.script_sound);

    while(zm_utility::is_player_valid(trigplayer) && trigplayer istouching(self)) {
      wait 0.5;
    }
  }
}

players_are_in_perk_area(perk_machine) {
  perk_area_origin = level.quick_revive_default_origin;

  if(isDefined(perk_machine._linked_ent)) {
    perk_area_origin = perk_machine._linked_ent.origin;

    if(isDefined(perk_machine._linked_ent_offset)) {
      perk_area_origin += perk_machine._linked_ent_offset;
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

perk_hostmigration() {
  level endon(#"end_game");
  level notify(#"perk_hostmigration");
  level endon(#"perk_hostmigration");

  while(true) {
    level waittill(#"host_migration_end");

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

host_migration_func(s_custom_perk, keyname) {
  a_machines = getEntArray(s_custom_perk.radiant_machine_name, "targetname");

  foreach(perk in a_machines) {
    if(isDefined(perk.model) && perk.model == level.machine_assets[keyname].on_model) {
      perk perk_fx(undefined, 1);
      perk thread perk_fx(s_custom_perk.machine_light_effect);
    }
  }
}

spare_change(str_trigger = "audio_bump_trigger", str_sound = "zmb_perks_bump_bottle") {
  a_t_audio = getEntArray(str_trigger, "targetname");

  foreach(t_audio_bump in a_t_audio) {
    if(t_audio_bump.script_sound === str_sound) {
      t_audio_bump thread check_for_change();
    }
  }
}

check_for_change() {
  self endon(#"death");

  while(true) {
    waitresult = self waittill(#"trigger");
    player = waitresult.activator;

    if(player getstance() == "prone") {
      player zm_score::add_to_player_score(100);
      zm_utility::play_sound_at_pos("purchase", player.origin);
      break;
    }

    wait 0.1;
  }
}

get_perk_array() {
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

register_revive_success_perk_func(revive_func) {
  if(!isDefined(level.a_revive_success_perk_func)) {
    level.a_revive_success_perk_func = [];
  }

  level.a_revive_success_perk_func[level.a_revive_success_perk_func.size] = revive_func;
}

register_perk_basic_info(str_perk, str_alias, n_perk_cost, str_hint_string, w_perk_bottle_weapon, var_1408cd4c, var_6334ae50) {
  assert(isDefined(str_perk), "<dev string:x1f8>");
  assert(isDefined(str_alias), "<dev string:x238>");
  assert(isDefined(n_perk_cost), "<dev string:x279>");
  assert(isDefined(str_hint_string), "<dev string:x2bc>");
  assert(isDefined(w_perk_bottle_weapon), "<dev string:x303>");
  assert(isDefined(var_1408cd4c), "<dev string:x34f>");
  _register_undefined_perk(str_perk);
  level._custom_perks[str_perk].alias = str_alias;
  level._custom_perks[str_perk].cost = n_perk_cost;
  level._custom_perks[str_perk].hint_string = str_hint_string;
  level._custom_perks[str_perk].perk_bottle_weapon = w_perk_bottle_weapon;
  level._custom_perks[str_perk].var_66de8d1c = var_1408cd4c;

  if(!getgametypesetting(#"magic")) {
    return;
  }

  if(!isDefined(level.var_b8be892e)) {
    level.var_b8be892e = [];
  }

  if(!isDefined(var_6334ae50) || isDefined(zm_custom::function_901b751c(var_6334ae50)) && zm_custom::function_901b751c(var_6334ae50)) {
    if(!isDefined(level.var_b8be892e)) {
      level.var_b8be892e = [];
    } else if(!isarray(level.var_b8be892e)) {
      level.var_b8be892e = array(level.var_b8be892e);
    }

    if(!isinarray(level.var_b8be892e, str_perk)) {
      level.var_b8be892e[level.var_b8be892e.size] = str_perk;
    }
  }

  if(!isDefined(level.var_fa3df1eb)) {
    level.var_fa3df1eb = [];
  }

  if(str_perk != #"specialty_mystery") {
    if(!isDefined(level.var_fa3df1eb)) {
      level.var_fa3df1eb = [];
    } else if(!isarray(level.var_fa3df1eb)) {
      level.var_fa3df1eb = array(level.var_fa3df1eb);
    }

    if(!isinarray(level.var_fa3df1eb, str_perk)) {
      level.var_fa3df1eb[level.var_fa3df1eb.size] = str_perk;
    }
  }
}

register_perk_mod_basic_info(str_perk, str_alias, var_771fabd4, var_5a736864, n_cost) {
  assert(isDefined(str_perk), "<dev string:x394>");
  assert(isDefined(str_alias), "<dev string:x3d8>");
  assert(isDefined(var_5a736864), "<dev string:x41d>");
  assert(isDefined(n_cost), "<dev string:x468>");
  _register_undefined_perk(str_perk);
  level._custom_perks[str_perk].alias = str_alias;
  level._custom_perks[str_perk].var_60e3692f = var_771fabd4;
  level._custom_perks[str_perk].n_cost = n_cost;

  if(!isDefined(level.var_5355c665)) {
    level.var_5355c665 = [];
  } else if(!isarray(level.var_5355c665)) {
    level.var_5355c665 = array(level.var_5355c665);
  }

  level.var_5355c665[var_5a736864] = str_perk;
}

register_perk_machine(str_perk, func_perk_machine_setup, func_perk_machine_thread) {
  assert(isDefined(str_perk), "<dev string:x4aa>");
  assert(isDefined(func_perk_machine_setup), "<dev string:x4e7>");
  _register_undefined_perk(str_perk);
  level._custom_perks[str_perk].perk_machine_set_kvps = func_perk_machine_setup;

  if(isDefined(func_perk_machine_thread)) {
    level._custom_perks[str_perk].perk_machine_thread = func_perk_machine_thread;
  }
}

register_perk_machine_power_override(str_perk, func_perk_machine_power_override) {
  assert(isDefined(str_perk), "<dev string:x533>");
  assert(isDefined(func_perk_machine_power_override), "<dev string:x57f>");
  _register_undefined_perk(str_perk);

  if(isDefined(func_perk_machine_power_override)) {
    level._custom_perks[str_perk].perk_machine_power_override_thread = func_perk_machine_power_override;
  }
}

register_perk_precache_func(str_perk, func_precache) {
  assert(isDefined(str_perk), "<dev string:x5e3>");
  assert(isDefined(func_precache), "<dev string:x626>");
  _register_undefined_perk(str_perk);
  level._custom_perks[str_perk].precache_func = func_precache;
}

register_perk_threads(str_perk, func_give_player_perk, func_take_player_perk, var_9a0b6a21) {
  assert(isDefined(str_perk), "<dev string:x66e>");
  assert(isDefined(func_give_player_perk), "<dev string:x6ab>");
  _register_undefined_perk(str_perk);
  level._custom_perks[str_perk].player_thread_give = func_give_player_perk;
  level._custom_perks[str_perk].player_thread_take = func_take_player_perk;

  if(isDefined(var_9a0b6a21)) {
    level._custom_perks[str_perk].var_9a0b6a21 = var_9a0b6a21;
  }
}

register_perk_clientfields(str_perk, func_clientfield_register, func_clientfield_set) {
  assert(isDefined(str_perk), "<dev string:x6f5>");
  assert(isDefined(func_clientfield_register), "<dev string:x737>");
  assert(isDefined(func_clientfield_set), "<dev string:x78a>");
  _register_undefined_perk(str_perk);
  level._custom_perks[str_perk].clientfield_register = func_clientfield_register;
  level._custom_perks[str_perk].clientfield_set = func_clientfield_set;
}

register_perk_host_migration_params(str_perk, str_radiant_name, str_effect_name) {
  assert(isDefined(str_perk), "<dev string:x7d8>");
  assert(isDefined(str_radiant_name), "<dev string:x823>");
  assert(isDefined(str_effect_name), "<dev string:x876>");
  _register_undefined_perk(str_perk);
  level._custom_perks[str_perk].radiant_machine_name = str_radiant_name;
  level._custom_perks[str_perk].machine_light_effect = str_effect_name;
}

_register_undefined_perk(str_perk) {
  if(!isDefined(level._custom_perks)) {
    level._custom_perks = [];
  }

  if(!isDefined(level._custom_perks[str_perk])) {
    level._custom_perks[str_perk] = spawnStruct();
  }
}

register_perk_damage_override_func(func_damage_override) {
  assert(isDefined(func_damage_override), "<dev string:x8c8>");

  if(!isDefined(level.perk_damage_override)) {
    level.perk_damage_override = [];
  }

  array::add(level.perk_damage_override, func_damage_override, 0);
}

function_2ae97a14(str_perk, var_feae8586) {
  assert(isDefined(str_perk), "<dev string:x91e>");
  assert(isDefined(var_feae8586), "<dev string:x95c>");
  _register_undefined_perk(str_perk);
  level._custom_perks[str_perk].var_658e2856 = var_feae8586;
}

function_6b2d8dc0() {
  return struct::get_array("perk_vapor_altar");
}

function_9a0e9d65() {
  if(!isDefined(self) || !isDefined(self.var_466b927f)) {
    return false;
  }

  return self.var_466b927f.size >= 4;
}

function_80514167() {
  if(!isDefined(self) || !isDefined(self.var_466b927f) || !isDefined(self.var_67ba1237)) {
    return false;
  }

  return !self.var_466b927f.size && !self.var_67ba1237.size;
}

function_39440031() {
  for(i = 0; i < 4; i++) {
    if(isDefined(self.var_c27f1e90[i])) {
      function_4acf7b43(i, self.var_c27f1e90[i]);
    }
  }
}

perk_vapor_altar_init() {
  function_8c7cee86();
  a_s_spawn_pos = [];
  a_structs = array::randomize(struct::get_array("perk_vapor_altar"));

  foreach(struct in a_structs) {
    if(!isDefined(struct.script_int) || struct.script_int == -1) {
      for(i = 0; i < 4; i++) {
        if(!(isDefined(function_c210fc2e(i, a_structs)) && function_c210fc2e(i, a_structs))) {
          struct.script_int = i;
          break;
        }
      }
    }

    a_s_spawn_pos[struct.script_int] = struct;
  }

  if(a_s_spawn_pos.size == 0) {
    return;
  }

  foreach(s_spawn_pos in a_s_spawn_pos) {
    n_slot = s_spawn_pos.script_int;

    if(isDefined(n_slot)) {
      forward = anglestoright(s_spawn_pos.angles) * 0;
      unitrigger_stub = spawnStruct();
      unitrigger_stub.origin = s_spawn_pos.origin + (0, 0, 0) + forward;
      unitrigger_stub.angles = s_spawn_pos.angles;
      unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
      unitrigger_stub.cursor_hint = "HINT_NOICON";
      unitrigger_stub.script_width = 64;
      unitrigger_stub.script_height = 64;
      unitrigger_stub.script_length = 64;
      unitrigger_stub.require_look_at = 0;
      unitrigger_stub.targetname = "perk_vapor_altar_stub";
      unitrigger_stub.script_int = n_slot;
      unitrigger_stub.hint_string = #"zombie/need_power";
      unitrigger_stub.hint_parm1 = undefined;
      unitrigger_stub.hint_parm2 = undefined;
      zm_unitrigger::unitrigger_force_per_player_triggers(unitrigger_stub, 1);
      unitrigger_stub.prompt_and_visibility_func = &function_b7f2c635;
      zm_unitrigger::register_static_unitrigger(unitrigger_stub, &function_f5da744e);
      zm_unitrigger::function_c4a5fdf5(unitrigger_stub, 1);

      if(!isDefined(s_spawn_pos.angles)) {
        s_spawn_pos.angles = (0, 0, 0);
      }

      if(isDefined(level._no_vending_machine_bump_trigs) && level._no_vending_machine_bump_trigs) {
        bump_trigger = undefined;
      } else {
        bump_trigger = spawn("trigger_radius", s_spawn_pos.origin + (0, 0, 30), 0, 40, 80, 1);
        bump_trigger.script_activated = 1;
        bump_trigger.script_sound = "zmb_perks_bump_bottle";
        bump_trigger.targetname = "audio_bump_trigger";
      }

      if(isDefined(level._no_vending_machine_auto_collision) && level._no_vending_machine_auto_collision) {
        collision = undefined;
      } else {
        collision = spawn("script_model", s_spawn_pos.origin, 1);
        collision.angles = s_spawn_pos.angles;
        collision setModel(#"zm_collision_perks1");
        collision.script_noteworthy = "clip";
        collision disconnectpaths();
      }

      unitrigger_stub.clip = collision;
      unitrigger_stub.bump = bump_trigger;

      if(isDefined(s_spawn_pos.blocker_model)) {
        unitrigger_stub.blocker_model = s_spawn_pos.blocker_model;
      }

      unitrigger_stub.var_3468124 = s_spawn_pos;
      unitrigger_stub.var_3468124.var_2977c27 = "off";
      unitrigger_stub thread function_b2ac6ee7();
      unitrigger_stub thread function_8b413937(s_spawn_pos);
      level.var_76a7ad28[level.var_76a7ad28.size] = unitrigger_stub;
    }
  }
}

function_8c7cee86() {
  var_5297120 = struct::get_array("random_perk_vapor_altar", "script_noteworthy");

  if(isDefined(level.var_c032ff64)) {
    var_c4c69578 = [[level.var_c032ff64]]();
  }

  if(var_5297120.size > 0) {
    var_ae36fbfd = [];

    for(i = 0; i <= 4; i++) {
      var_ae36fbfd[i] = [];
    }

    foreach(var_7a9ec77b in var_5297120) {
      if(!isDefined(var_7a9ec77b.script_int) || var_7a9ec77b.script_int > 3 || var_7a9ec77b.script_int < -1) {
        if(!isDefined(var_ae36fbfd[0])) {
          var_ae36fbfd[0] = [];
        } else if(!isarray(var_ae36fbfd[0])) {
          var_ae36fbfd[0] = array(var_ae36fbfd[0]);
        }

        var_ae36fbfd[0][var_ae36fbfd[0].size] = var_7a9ec77b;
        continue;
      }

      if(!isDefined(var_ae36fbfd[var_7a9ec77b.script_int + 1])) {
        var_ae36fbfd[var_7a9ec77b.script_int + 1] = [];
      } else if(!isarray(var_ae36fbfd[var_7a9ec77b.script_int + 1])) {
        var_ae36fbfd[var_7a9ec77b.script_int + 1] = array(var_ae36fbfd[var_7a9ec77b.script_int + 1]);
      }

      var_ae36fbfd[var_7a9ec77b.script_int + 1][var_ae36fbfd[var_7a9ec77b.script_int + 1].size] = var_7a9ec77b;
    }

    foreach(var_ec770e5d in var_ae36fbfd) {
      s_loc = array::random(var_ec770e5d);

      if(isDefined(var_c4c69578)) {
        s_loc = var_c4c69578;
      }

      if(isDefined(s_loc)) {
        arrayremovevalue(var_ec770e5d, s_loc, 0);
      }

      foreach(var_7a9ec77b in var_ec770e5d) {
        e_clip = getent(var_7a9ec77b.target2, "targetname");
        var_528a3a32 = struct::get(var_7a9ec77b.target2);

        if(isDefined(e_clip)) {
          e_clip delete();
        }

        if(isDefined(var_528a3a32)) {
          var_528a3a32 struct::delete();
        }

        var_7a9ec77b struct::delete();
      }
    }
  }
}

function_c210fc2e(n_index, a_structs) {
  foreach(struct in a_structs) {
    if(isDefined(struct.script_int) && struct.script_int == n_index) {
      return true;
    }
  }

  return false;
}

function_b7f2c635(player) {
  n_slot = self.stub.script_int;
  perk = player.var_47654123[n_slot] ? #"specialty_mystery" : player.var_c27f1e90[n_slot];

  if(self.stub.var_36d60c16 !== 1 && player getstance() === "prone" && distancesquared(self.origin, player.origin) < 9216) {
    self.stub.var_36d60c16 = 1;
    player zm_score::add_to_player_score(100);
    self playsoundtoplayer(#"hash_30fa33e2fb90b58f", player);
  }

  if(player.var_47654123[n_slot] && !isDefined(player function_5ea0c6cf())) {
    return false;
  }

  if(isDefined(self.stub.var_e80aca0a) && self.stub.var_e80aca0a) {
    return false;
  }

  if(!isDefined(n_slot) || !isDefined(player.var_c27f1e90) || !isDefined(player.var_c27f1e90[n_slot]) || player.var_c27f1e90[n_slot] == "") {
    return false;
  }

  if(zm_custom::function_8b8fa6e5(player)) {
    return false;
  }

  if(isDefined(player.perk_purchased)) {
    return false;
  }

  var_99442276 = 0;

  if(self.stub.var_3468124.var_2977c27 == "off") {
    self sethintstringforplayer(player, #"zombie/need_power");
    return true;
  }

  if(zm_trial_disable_buys::is_active()) {
    self sethintstringforplayer(player, #"hash_55d25caf8f7bbb2f");
    return true;
  }

  if(zm_trial_disable_perks::is_active() || !zm_custom::function_901b751c(#"zmperksactive") || zm_trial_randomize_perks::is_active()) {
    self sethintstringforplayer(player, #"hash_77db65489366a43");
    return true;
  }

  if(self.stub.var_3468124.var_2977c27 == "on" && isDefined(perk) && !player hasperk(perk) && self vending_trigger_can_player_use(player, 1) && !player has_perk_paused(perk) && !player zm_utility::in_revive_trigger() && !zm_equipment::is_equipment_that_blocks_purchase(player getcurrentweapon()) && !player zm_equipment::hacker_active()) {
    var_99442276 = 1;
  }

  if(var_99442276) {
    b_is_invis = 0;

    if(isDefined(level._custom_perks)) {
      if(isDefined(level._custom_perks[perk]) && isDefined(level._custom_perks[perk].cost) && isDefined(level._custom_perks[perk].hint_string)) {
        n_cost = level function_44915d1(perk, n_slot);

        if(isDefined(level.var_256aa316)) {
          var_c591876d = [
            [level.var_256aa316]
          ](perk);
        } else {
          var_c591876d = level._custom_perks[perk].hint_string;
        }
      }
    }

    if(n_slot == 0 && isDefined(player.talisman_perk_reducecost_1) && player.talisman_perk_reducecost_1) {
      n_cost -= player.talisman_perk_reducecost_1;
    }

    if(n_slot == 1 && isDefined(player.talisman_perk_reducecost_2) && player.talisman_perk_reducecost_2) {
      n_cost -= player.talisman_perk_reducecost_2;
    }

    if(n_slot == 2 && isDefined(player.talisman_perk_reducecost_3) && player.talisman_perk_reducecost_3) {
      n_cost -= player.talisman_perk_reducecost_3;
    }

    if(n_slot == 3 && isDefined(player.talisman_perk_reducecost_4) && player.talisman_perk_reducecost_4) {
      n_cost -= player.talisman_perk_reducecost_4;
    }

    n_cost = player namespace_e38c57c1::function_863dc0ef(n_cost);
    n_cost = int(max(n_cost, 0));

    if(isDefined(var_c591876d) && var_c591876d !== " ") {
      self sethintstringforplayer(player, var_c591876d, n_cost);
    }
  } else {
    b_is_invis = 1;
  }

  return !b_is_invis;
}

function_f5da744e() {
  self endon(#"death");
  n_slot = self.stub.script_int;
  n_cost = self.stub.cost;

  if(level.var_c3e5c4cd == 1) {
    self thread function_9da4880b();
  }

  for(;;) {
    waitresult = self waittill(#"trigger");
    player = waitresult.activator;

    if(self.stub.var_3468124.var_2977c27 != "on") {
      continue;
    }

    if(!vending_trigger_can_player_use(player, 1) || zm_trial_disable_buys::is_active() || zm_trial_disable_perks::is_active() || !zm_custom::function_901b751c(#"zmperksactive")) {
      wait 0.1;
      continue;
    }

    perk = player.var_47654123[n_slot] ? #"specialty_mystery" : player.var_c27f1e90[n_slot];

    if(!isDefined(player.var_c27f1e90) || player.var_c27f1e90.size <= n_slot) {
      return;
    }

    if(player.var_47654123[n_slot] && !isDefined(player function_5ea0c6cf())) {
      return;
    }

    if(player hasperk(perk) || player has_perk_paused(perk)) {
      cheat = 0;

      if(getdvarint(#"zombie_cheat", 0) >= 5) {
        cheat = 1;
      }

        if(cheat != 1) {
          zm_utility::play_sound_on_ent("no_purchase");
          continue;
        }
    }

    if(isDefined(level.custom_perk_validation)) {
      valid = self[[level.custom_perk_validation]](player);

      if(!valid) {
        continue;
      }
    }

    if(isDefined(level._custom_perks)) {
      if(isDefined(level._custom_perks[perk]) && isDefined(level._custom_perks[perk].cost) && isDefined(level._custom_perks[perk].hint_string)) {
        n_cost = level function_44915d1(perk, n_slot);
      }
    }

    current_cost = n_cost;

    if(n_slot == 0 && isDefined(player.talisman_perk_reducecost_1) && player.talisman_perk_reducecost_1) {
      current_cost -= player.talisman_perk_reducecost_1;
    }

    if(n_slot == 1 && isDefined(player.talisman_perk_reducecost_2) && player.talisman_perk_reducecost_2) {
      current_cost -= player.talisman_perk_reducecost_2;
    }

    if(n_slot == 2 && isDefined(player.talisman_perk_reducecost_3) && player.talisman_perk_reducecost_3) {
      current_cost -= player.talisman_perk_reducecost_3;
    }

    if(n_slot == 3 && isDefined(player.talisman_perk_reducecost_4) && player.talisman_perk_reducecost_4) {
      current_cost -= player.talisman_perk_reducecost_4;
    }

    current_cost = player namespace_e38c57c1::function_863dc0ef(current_cost);
    current_cost = int(max(current_cost, 0));

    if(!player zm_score::can_player_purchase(current_cost)) {
      zm_utility::play_sound_on_ent("no_purchase");
      player zm_audio::create_and_play_dialog(#"general", #"outofmoney");
      continue;
    }

    player thread zm_audio::create_and_play_dialog(#"altar", #"interact");
    playsoundatposition(#"hash_489cdfeed1ac55bd", self.origin);

    if(level.var_c3e5c4cd == 1 && !self.var_3cfb2018) {
      playsoundatposition(#"hash_1e20f59360c2377e", self.origin);
    }

    player zm_score::minus_to_player_score(current_cost);
    bb::logpurchaseevent(player, self, current_cost, perk, 0, "_perk", "_purchased");

    if(isDefined(level._custom_perks[perk]) && isDefined(level._custom_perks[perk].alias)) {
      perkhash = level._custom_perks[perk].alias;
    }

    if(!ishash(perkhash)) {
      assertmsg("<dev string:x9a0>");
      perkhash = -1;
    }

    n_round_number = level.round_number;

    if(!isint(n_round_number)) {
      assertmsg("<dev string:x9d7>");
      n_round_number = 0;
    }

    player recordmapevent(29, gettime(), self.origin, n_round_number, perkhash);
    player.perk_purchased = perk;
    player notify(#"perk_purchased", {
      #perk: perk
    });

    if(player.var_47654123[n_slot]) {
      perk = player function_5ea0c6cf();
    }

    self thread taking_cover_tanks_(player, perk, n_slot, self.stub.var_3468124);
  }
}

function_9da4880b() {
  self endon(#"death");
  self.var_3cfb2018 = 0;

  while(true) {
    wait randomintrange(90, 180);

    if(self.stub.var_3468124.var_2977c27 != "on") {
      continue;
    }

    if(math::cointoss() && !self.var_3cfb2018) {
      self.var_3cfb2018 = 1;
      str_alias = #"hash_84373a7c4b63d22" + randomintrangeinclusive(1, 5);
      playsoundatposition(str_alias, self.origin);
      n_wait = float(soundgetplaybacktime(str_alias)) / 1000;
      wait n_wait;
      self.var_3cfb2018 = 0;
    }
  }
}

taking_cover_tanks_(player, perk, n_slot, var_3468124) {
  player endon(#"disconnect", #"end_game");
  player function_fb633f9d(n_slot, 5);
  var_3468124 thread function_e9df56d1();
  player perk_give_bottle_begin(perk);
  evt = player waittilltimeout(3, #"fake_death", #"death", #"player_downed", #"offhand_fire", #"perk_abort_drinking", #"disconnect");
  player.perk_purchased = undefined;

  if(isDefined(player.intermission) && player.intermission) {
    return;
  }

  if(evt._notify == #"offhand_fire" || evt._notify == #"timeout") {
    if(player.var_47654123[n_slot]) {
      player function_f9385a02(perk, n_slot);
      player thread function_ef7f9ab0(n_slot);
    }

    player thread function_9bdf581f(perk, n_slot, 1);

    if(isDefined(level.var_c4bedce3)) {
      player[[level.var_c4bedce3]](perk);
    }

    return;
  }

  if(player.var_47654123[n_slot]) {
    player function_81bc6765(n_slot, level._custom_perks[#"specialty_mystery"].alias);
    player function_2ac7579(n_slot, 0);
  }

  player function_fb633f9d(n_slot, 0);
}

private function_44915d1(var_16c042b8, n_slot) {
  if(n_slot == 3) {
    var_f53f24dd = level.var_5355c665[var_16c042b8];
    n_cost = level._custom_perks[var_f53f24dd].n_cost;
  } else if(isfunctionptr(level._custom_perks[var_16c042b8].cost)) {
    n_cost = [[level._custom_perks[var_16c042b8].cost]]();
  } else {
    n_cost = level._custom_perks[var_16c042b8].cost;
  }

  if(isDefined(level.var_1f3f3e7b)) {
    n_cost = [[level.var_1f3f3e7b]](n_cost, n_slot);
  }

  return n_cost;
}

function_d11d4952() {
  self endon(#"death");
  wait 0.01;
  level flag::wait_till("start_zombie_round_logic");
  players = getplayers();
  self endon(#"warning_dialog");
  level endon(#"switch_flipped");
  timer = 0;

  for(;;) {
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

      if(dist < 4900 && timer == 3) {
        if(!isDefined(players[i])) {
          continue;
        }

        players[i] thread zm_utility::do_player_vo("vox_start", 5);
        wait 3;
        self notify(#"warning_dialog");

        iprintlnbold("<dev string:xe1>");

      }
    }
  }
}

function_b2ac6ee7() {
  self endon(#"death");
  wait 0.01;
  n_slot = self.script_int;
  start_on = 1;

  if(!isDefined(self.cost)) {
    cost = 500 * (n_slot + 1) + 1000;
    self.cost = cost;
  }

  if(!start_on) {
    notify_name = "perk_vapor_altar_" + n_slot + "_power_on";
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

  self.hint_string = #"zombie/usealtar";
  self.hint_parm1 = self.cost;
}

function_9bdf581f(perk, n_slot, b_bought = 0) {
  self endon(#"player_downed", #"disconnect", #"perk_abort_drinking");
  level endon(#"end_game");
  level notify(#"hash_4e566c83cdfabe44", {
    #e_player: self, 
    #perk: perk
  });
  self perks::perk_setperk(perk);

  if(isDefined(level._custom_perks[perk].var_658e2856)) {
    if(isarray(level._custom_perks[perk].var_658e2856)) {
      foreach(specialty in level._custom_perks[perk].var_658e2856) {
        perks::perk_setperk(specialty);
      }
    } else {
      perks::perk_setperk(level._custom_perks[perk].var_658e2856);
    }
  }

  if(isDefined(b_bought) && b_bought) {
    self thread give_perk_presentation(perk);
    self notify(#"perk_bought", {
      #var_16c042b8: perk, 
      #n_slot: n_slot
    });
    self zm_stats::increment_challenge_stat(#"survivalist_buy_perk");
    self zm_stats::function_c0c6ab19(#"perks_used");

    if(zm_utility::is_standard()) {
      self zm_stats::function_c0c6ab19(#"perks_activated");
    }
  }

  if(n_slot < 4) {
    var_9a0250b7 = level._custom_perks[hash(perk)].alias;
    self function_2ac7579(n_slot, 1);

    if(self.var_47654123[n_slot]) {
      self function_81bc6765(n_slot, var_9a0250b7);
    } else if(!(isDefined(b_bought) && b_bought)) {
      self function_fb633f9d(n_slot, 6);
    }

    self stats::inc_stat(#"perk_stats", var_9a0250b7, #"given", #"statvalue", 1);
  } else {
    self stats::inc_stat(#"perk_stats", level._custom_perks[perk].var_60e3692f, #"modifier_given", #"statvalue", 1);
  }

  if(isDefined(level._custom_perks[perk]) && isDefined(level._custom_perks[perk].player_thread_give)) {
    self thread[[level._custom_perks[perk].player_thread_give]]();
  }

  self set_perk_clientfield(perk, 1);
  demo::bookmark(#"zm_player_perk", gettime(), self);
  potm::bookmark(#"zm_player_perk", gettime(), self);

  if(!zm_trial_randomize_perks::is_active()) {
    self zm_stats::increment_client_stat("perks_drank");
    self zm_stats::increment_player_stat("perks_drank");

    if(!isDefined(self.perk_history)) {
      self.perk_history = [];
    } else if(!isarray(self.perk_history)) {
      self.perk_history = array(self.perk_history);
    }

    if(!isinarray(self.perk_history, perk)) {
      self.perk_history[self.perk_history.size] = perk;
    }
  }

  if(!isDefined(self.var_466b927f)) {
    self.var_466b927f = [];
  } else if(!isarray(self.var_466b927f)) {
    self.var_466b927f = array(self.var_466b927f);
  }

  if(!isinarray(self.var_466b927f, perk)) {
    self.var_466b927f[self.var_466b927f.size] = perk;
  }

  function_fc0e5f36();

  if(isDefined(self.talisman_perk_permanent) && self.talisman_perk_permanent - 1 == n_slot || zm_utility::is_standard()) {
    if(!isDefined(self.var_774e0ad7)) {
      self.var_774e0ad7 = [];
    } else if(!isarray(self.var_774e0ad7)) {
      self.var_774e0ad7 = array(self.var_774e0ad7);
    }

    if(!isinarray(self.var_774e0ad7, perk)) {
      self.var_774e0ad7[self.var_774e0ad7.size] = perk;
    }
  } else if(n_slot < 4) {
    if(!isDefined(self.var_cd5d9345)) {
      self.var_cd5d9345 = [];
    } else if(!isarray(self.var_cd5d9345)) {
      self.var_cd5d9345 = array(self.var_cd5d9345);
    }

    if(!isinarray(self.var_cd5d9345, perk)) {
      self.var_cd5d9345[self.var_cd5d9345.size] = perk;
    }
  }

  self notify(#"perk_acquired", {
    #var_16c042b8: perk
  });
  self thread function_329ae65e(perk, n_slot);

  if(self.var_466b927f.size == 4 || isDefined(self.talisman_perk_mod_single) && self.talisman_perk_mod_single && n_slot == 3) {
    var_7bc3cbfd = self.var_c27f1e90[3];

    if(var_7bc3cbfd == #"specialty_mystery") {
      var_7bc3cbfd = self.var_c4193958[3];
    }

    var_f53f24dd = level.var_5355c665[var_7bc3cbfd];

    if(isstring(var_7bc3cbfd)) {
      var_7bc3cbfd = hash(var_7bc3cbfd);
    }

    assert(isDefined(var_f53f24dd), "<dev string:xa13>" + function_9e72a96(var_7bc3cbfd));

      if(isDefined(var_f53f24dd) && !isinarray(self.var_466b927f, var_f53f24dd)) {
        self notify(#"hash_13948ef3726b968f", {
          #var_f53f24dd: var_f53f24dd
        });
        self function_df87281a(var_f53f24dd);
      }
  }
}

function_ef7f9ab0(n_slot) {
  self endon(#"disconnect");

  while(self zm_utility::is_drinking()) {
    wait 0.1;
  }

  self function_fb633f9d(n_slot, 0);
}

function_fc0e5f36() {
  var_1108cad = array::exclude(level.var_fa3df1eb, self.perk_history);

  if(!var_1108cad.size) {
    self zm_utility::giveachievement_wrapper("zm_trophy_perkaholic_relapse");
  }
}

function_329ae65e(perk, n_slot) {
  self endon(#"disconnect");
  perk_str = perk + "_stop";

  do {
    s_result = self waittill(perk_str);
    result = s_result._notify;
  }
  while(!(isDefined(s_result.var_613b7621) && s_result.var_613b7621) && self lost_perk_override(perk));

  var_ac32c1b8 = 0;
  self perks::perk_unsetperk(perk);

  if(isDefined(self.var_47654123[n_slot]) && self.var_47654123[n_slot] && self.var_c27f1e90[n_slot] == perk) {
    self.var_c27f1e90[n_slot] = #"specialty_mystery";
    self.var_c4193958[n_slot] = "";
    var_ac32c1b8 = 1;
  }

  if(isDefined(level._custom_perks[perk].var_658e2856)) {
    if(isarray(level._custom_perks[perk].var_658e2856)) {
      foreach(specialty in level._custom_perks[perk].var_658e2856) {
        perks::perk_unsetperk(specialty);
      }
    } else {
      perks::perk_unsetperk(level._custom_perks[perk].var_658e2856);
    }
  }

  self.num_perks--;

  if(isDefined(level._custom_perks[perk]) && isDefined(level._custom_perks[perk].player_thread_take)) {
    self thread[[level._custom_perks[perk].player_thread_take]](0, perk_str, result, n_slot);
  }

  self set_perk_clientfield(perk, 0);

  if(n_slot < 4) {
    self function_2ac7579(n_slot, 0);

    if(self.var_47654123[n_slot]) {
      if(var_ac32c1b8) {
        self function_81bc6765(n_slot, level._custom_perks[#"specialty_mystery"].alias);
      }
    } else {
      self function_fb633f9d(n_slot, 0);
    }
  }

  if(isDefined(level.var_a903ab55)) {
    self[[level.var_a903ab55]](perk);
  }

  arrayremovevalue(self.var_466b927f, perk, 0);

  if(!(isDefined(s_result.var_fe7072f6) && s_result.var_fe7072f6)) {
    arrayremovevalue(self.var_cd5d9345, perk, 0);
  }

  self notify(#"perk_vapor_lost");
  var_5fe29258 = self.var_c27f1e90[4];

  if(isDefined(var_5fe29258) && isinarray(self.var_466b927f, var_5fe29258)) {
    if(isDefined(self.talisman_perk_mod_single) && self.talisman_perk_mod_single && n_slot < 3) {
      return;
    }

    self notify(var_5fe29258 + "_stop");
    self function_b8c12b0f(3, 0);
    self function_528f82a9();
  }
}

function_c1efcc57(str_name) {
  for(x = 0; x < self.var_c27f1e90.size; x++) {
    if(self.var_c27f1e90[x] == str_name) {
      return x;
    }
  }

  return -1;
}

function_9b641809(n_slot) {
  var_16c042b8 = self.var_c27f1e90[n_slot];

  if(isDefined(level._custom_perks[var_16c042b8].var_9a0b6a21)) {
    self[[level._custom_perks[var_16c042b8].var_9a0b6a21]]();
  }

  if(n_slot == 3) {
    var_fc6c6fba = level.var_5355c665[var_16c042b8];

    if(isDefined(level._custom_perks[var_fc6c6fba].var_9a0b6a21)) {
      self[[level._custom_perks[var_fc6c6fba].var_9a0b6a21]]();
    }
  }
}

function_9829d4a9(n_slot) {
  var_16c042b8 = self.var_67ba1237[n_slot];

  if(isDefined(var_16c042b8) && isDefined(level._custom_perks[var_16c042b8].var_9a0b6a21)) {
    self[[level._custom_perks[var_16c042b8].var_9a0b6a21]]();
  }
}

function_59fb56ff(b_show) {
  if(isDefined(b_show) && b_show) {
    assert(isDefined(self.var_3468124), "<dev string:xa3b>");
    self.var_e80aca0a = 0;

    if(isDefined(self.var_3468124.mdl_altar)) {
      self.var_3468124.mdl_altar show();
      self.var_3468124.mdl_altar solid();
    }

    if(isDefined(self.clip)) {
      self.clip show();
      self.clip solid();
    }

    if(isDefined(self.bump)) {
      self.bump show();
      self.bump solid();
    }

    return;
  }

  assert(isDefined(self.var_3468124), "<dev string:xa3b>");
  self.var_e80aca0a = 1;

  if(isDefined(self.var_3468124.mdl_altar)) {
    self.var_3468124.mdl_altar ghost();
    self.var_3468124.mdl_altar notsolid();
  }

  if(isDefined(self.clip)) {
    self.clip ghost();
    self.clip notsolid();
  }

  if(isDefined(self.bump)) {
    self.bump ghost();
    self.bump notsolid();
  }
}

function_cc24f525() {
  self endon(#"disconnect");

  foreach(n_slot, var_16c042b8 in self.var_c27f1e90) {
    if(!isinarray(self.var_466b927f, var_16c042b8)) {
      if(var_16c042b8 == #"specialty_mystery") {
        var_16c042b8 = self function_5ea0c6cf();
        self.var_47654123[n_slot] = 1;
        self function_f9385a02(var_16c042b8, n_slot);
      } else {
        self.var_47654123[n_slot] = 0;
      }

      self thread function_9bdf581f(var_16c042b8, n_slot);
    }
  }
}

function_29387491(var_16c042b8, n_slot) {
  self endon(#"fake_death", #"death", #"player_downed", #"perk_abort_drinking");

  if(var_16c042b8 == #"specialty_mystery") {
    var_ddd879da = 1;
    var_16c042b8 = self function_5ea0c6cf();

    if(!isDefined(var_16c042b8)) {
      return;
    }
  }

  self perk_give_bottle_begin(var_16c042b8);
  s_result = self waittilltimeout(3, #"offhand_fire");

  if(isDefined(n_slot)) {
    if(isDefined(var_ddd879da) && var_ddd879da) {
      self.var_47654123[n_slot] = 1;
      self function_f9385a02(var_16c042b8, n_slot);
      self thread function_ef7f9ab0(n_slot);
    } else {
      self.var_47654123[n_slot] = 0;
    }

    self thread function_9bdf581f(var_16c042b8, n_slot);
    return;
  }

  if(!self function_80cb4982()) {
    self thread function_a7ae070c(var_16c042b8);
  }
}

function_f9385a02(var_330ce459, n_slot) {
  str_perk = self.var_c4193958[n_slot];

  if(str_perk != "") {
    if(self hasperk(str_perk)) {
      self notify(str_perk + "_stop");

      if(n_slot == 3) {
        var_de7ee14b = level.var_5355c665[hash(str_perk)];

        if(isDefined(var_de7ee14b) && self hasperk(var_de7ee14b)) {
          self notify(var_de7ee14b + "_stop");
        }
      }

      arrayremovevalue(self.var_774e0ad7, str_perk, 0);
    }
  }

  self.var_c4193958[n_slot] = var_330ce459;
  self.var_c27f1e90[n_slot] = var_330ce459;
  waitframe(1);
}

function_5ea0c6cf(var_9bf8fb5c) {
  var_cc1db3c1 = array::exclude(level.var_b8be892e, self.var_67ba1237);
  var_cc1db3c1 = array::exclude(var_cc1db3c1, self.var_c27f1e90);
  var_cc1db3c1 = array::exclude(var_cc1db3c1, #"specialty_mystery");

  if(isarray(var_9bf8fb5c)) {
    var_cc1db3c1 = array::exclude(var_cc1db3c1, var_9bf8fb5c);
  }

  return array::random(var_cc1db3c1);
}

private function_7723353c() {
  self endon(#"disconnect");

  if(isDefined(self.is_hotjoining) && self.is_hotjoining || self util::is_spectating()) {
    return;
  }

  self waittill(#"perks_initialized");
  s_perk = undefined;

  if(isDefined(self.talisman_perk_start_1) && self.talisman_perk_start_1 && isDefined(self.var_c27f1e90[0])) {
    n_slot = 0;
    str_perk = self.var_c27f1e90[0];
    self.talisman_perk_start_1 = 0;
  }

  if(isDefined(self.talisman_perk_start_2) && self.talisman_perk_start_2 && isDefined(self.var_c27f1e90[1])) {
    n_slot = 1;
    str_perk = self.var_c27f1e90[1];
    self.talisman_perk_start_2 = 0;
  }

  if(isDefined(self.talisman_perk_start_3) && self.talisman_perk_start_3 && isDefined(self.var_c27f1e90[2])) {
    n_slot = 2;
    str_perk = self.var_c27f1e90[2];
    self.talisman_perk_start_3 = 0;
  }

  if(isDefined(self.talisman_perk_start_4) && self.talisman_perk_start_4 && isDefined(self.var_c27f1e90[3])) {
    n_slot = 3;
    str_perk = self.var_c27f1e90[3];
    self.talisman_perk_start_4 = 0;
  }

  level flag::wait_till("initial_blackscreen_passed");

  if(isDefined(str_perk)) {
    if(str_perk == #"specialty_mystery") {
      str_perk = self function_5ea0c6cf();
      self function_f9385a02(str_perk, n_slot);
    }

    self function_9bdf581f(str_perk, n_slot);
  }
}

function_8b413937(var_3468124) {
  level endon(#"end_game");
  var_4324192b = var_3468124.var_21c535b;
  var_b6b0d4b0 = struct::get(var_3468124.target, "targetname");

  if(isDefined(var_4324192b) && var_4324192b > -1) {
    if(isDefined(var_b6b0d4b0)) {
      var_b6b0d4b0 thread scene::play("off");
    } else {
      var_3468124 function_a30c73b9("off");
    }

    if(var_4324192b == 0) {
      level flag::wait_till("power_on");
    } else {
      level flag::wait_till("power_on" + var_4324192b);
    }
  }

  var_3468124.var_2977c27 = "on";

  if(isDefined(var_b6b0d4b0)) {
    level scene::add_scene_func(var_b6b0d4b0.scriptbundlename, &function_72c30be7, "on", var_3468124);
    var_b6b0d4b0 thread scene::play("on");
    var_3468124.var_2839b015 = var_b6b0d4b0.scriptbundlename;
  } else {
    var_3468124 function_a30c73b9("on");
    waitframe(1);
    var_3468124.mdl_altar clientfield::set("" + #"hash_cf74c35ecc5a49", 1);
  }

  var_3468124 function_a1bad730();

  if(level.var_c3e5c4cd == 2 && var_3468124.script_int == 2) {
    level thread function_ba56adf1(var_3468124.origin, var_3468124.angles);
  }
}

function_72c30be7(var_dd74d130, var_3468124) {
  var_3468124.mdl_altar = var_dd74d130[#"prop 1"];
  var_3468124.mdl_altar clientfield::set("" + #"hash_cf74c35ecc5a49", 1);
}

function_a30c73b9(str_state) {
  s_statue = struct::get(self.target2);

  if(!isDefined(s_statue)) {
    return;
  }

  if(!isDefined(self.mdl_altar)) {
    if(isDefined(self.script_int)) {
      if(level.var_c3e5c4cd == 1) {
        switch (self.script_int) {
          case 0:
            var_1d373a09 = #"p8_fxanim_zm_perk_vending_brew_mod";
            self.var_2839b015 = #"p8_fxanim_zm_perk_vending_brew_bundle";
            break;
          case 1:
            var_1d373a09 = #"p8_fxanim_zm_perk_vending_cola_mod";
            self.var_2839b015 = #"p8_fxanim_zm_perk_vending_cola_bundle";
            break;
          case 2:
            var_1d373a09 = #"p8_fxanim_zm_perk_vending_soda_mod";
            self.var_2839b015 = #"p8_fxanim_zm_perk_vending_soda_bundle";
            break;
          case 3:
            var_1d373a09 = #"p8_fxanim_zm_perk_vending_tonic_mod";
            self.var_2839b015 = #"p8_fxanim_zm_perk_vending_tonic_bundle";
            break;
        }
      } else {
        switch (self.script_int) {
          case 0:
            var_1d373a09 = #"p8_fxanim_zm_vapor_altar_danu_mod";
            self.var_2839b015 = #"p8_fxanim_zm_vapor_altar_danu_bundle";
            break;
          case 1:
            var_1d373a09 = #"p8_fxanim_zm_vapor_altar_ra_mod";
            self.var_2839b015 = #"p8_fxanim_zm_vapor_altar_ra_bundle";
            break;
          case 2:
            var_1d373a09 = #"p8_fxanim_zm_vapor_altar_zeus_mod";
            self.var_2839b015 = #"p8_fxanim_zm_vapor_altar_zeus_bundle";
            var_30a7cd8c = 1;
            break;
          case 3:
            var_1d373a09 = #"p8_fxanim_zm_vapor_altar_odin_mod";
            self.var_2839b015 = #"p8_fxanim_zm_vapor_altar_odin_bundle";
            break;
        }
      }
    }

    assert(isDefined(var_1d373a09), "<dev string:xa6e>");
    self.mdl_altar = util::spawn_model(var_1d373a09, s_statue.origin, s_statue.angles);

    if(isDefined(var_30a7cd8c) && var_30a7cd8c) {
      waitframe(1);
      self.mdl_altar clientfield::set("" + #"hash_50eb488e58f66198", 1);
    }
  }

  self.mdl_altar thread scene::play(self.var_2839b015, str_state, self.mdl_altar);
}

function_a1bad730() {
  var_97cf25f9 = scene::get_all_shot_names(self.var_2839b015, 1);
  var_953913d1 = array("use1", "use2", "use3", "use4", "use5", "use6");

  foreach(var_3541a62b in var_953913d1) {
    if(isinarray(var_97cf25f9, var_3541a62b)) {
      if(!isDefined(self.var_31cb501c)) {
        self.var_31cb501c = [];
      } else if(!isarray(self.var_31cb501c)) {
        self.var_31cb501c = array(self.var_31cb501c);
      }

      self.var_31cb501c[self.var_31cb501c.size] = var_3541a62b;
    }
  }

  if(isDefined(self.var_31cb501c)) {
    self.var_2a08e958 = 0;
  }
}

function_e9df56d1() {
  if(!isDefined(self.var_31cb501c)) {
    return;
  }

  self.mdl_altar scene::play(self.var_2839b015, self.var_31cb501c[self.var_2a08e958], self.mdl_altar);
  self.mdl_altar thread scene::play(self.var_2839b015, self.var_2977c27, self.mdl_altar);
  self.var_2a08e958++;

  if(self.var_2a08e958 == self.var_31cb501c.size) {
    self.var_2a08e958 = 0;
  }
}

function_efd2c9e6() {
  if(!isDefined(self.mdl_altar)) {
    return;
  }

  if(level.var_c3e5c4cd == 1) {
    self.mdl_altar thread scene::play(self.var_2839b015, "disable", self.mdl_altar);
  }

  n_slot = self.script_int;

  foreach(e_player in level.activeplayers) {
    e_player function_fb633f9d(n_slot, 7);
  }

  self.var_2977c27 = "disable";
}

function_1e721859() {
  if(!isDefined(self.mdl_altar)) {
    return;
  }

  if(level.var_c3e5c4cd == 1) {
    self.mdl_altar thread scene::play(self.var_2839b015, "on", self.mdl_altar);
  }

  self.var_2977c27 = "on";
  n_slot = self.script_int;
  a_players = util::get_active_players();

  foreach(e_player in a_players) {
    if(isinarray(e_player.var_466b927f, e_player.var_c27f1e90[n_slot]) && !e_player.var_47654123[n_slot]) {
      n_state = 6;
    } else {
      n_state = 0;
    }

    e_player function_fb633f9d(n_slot, n_state);
  }
}

function_adc671f5(n_slot) {
  a_s_altars = struct::get_array("perk_vapor_altar");

  foreach(s_altar in a_s_altars) {
    if(s_altar.script_int == n_slot) {
      if(s_altar.var_2977c27 == "on") {
        return 1;
      }

      return 0;
    }
  }

  assertmsg("<dev string:xa9b>" + n_slot);
}

function_3b63b27f(var_3468124) {
  if(!isDefined(level.var_46cdd0e7)) {
    level.var_46cdd0e7 = 0;
  }

  n_altar = var_3468124.script_int;

  switch (n_altar) {
    case 0:
      str_soundalias = #"hash_53f8a70357ec0da8";
      break;
    case 1:
      str_soundalias = #"hash_7e0bcff9cf221f89";
      break;
    case 2:
      str_soundalias = #"hash_7fce3a84b4e750f5";
      break;
    case 3:
      str_soundalias = #"hash_329003fa3cbc92be";
      break;
    default:
      return;
  }

  while(true) {
    wait randomintrange(45, 90);

    if(!level.var_46cdd0e7) {
      level.var_46cdd0e7 = 1;
      playsoundatposition(str_soundalias, var_3468124.origin);
      wait 30;
      level.var_46cdd0e7 = 0;
    }
  }
}

function_3bcaebcb(var_403110e0) {
  if(!isDefined(var_403110e0)) {
    return;
  }

  if(!isDefined(var_403110e0.stub)) {
    return;
  }

  if(!isDefined(var_403110e0.stub.var_3468124)) {
    return;
  }

  n_altar = var_403110e0.stub.var_3468124.script_int;

  switch (n_altar) {
    case 0:
      str_soundalias = #"hash_53f8a70357ec0da8";
      break;
    case 1:
      str_soundalias = #"hash_7e0bcff9cf221f89";
      break;
    case 2:
      str_soundalias = #"hash_7fce3a84b4e750f5";
      break;
    case 3:
      str_soundalias = #"hash_329003fa3cbc92be";
      break;
    default:
      return;
  }

  self playsoundontag(str_soundalias, "j_head");
}

function_fb633f9d(n_slot, n_state) {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(level.var_b8be892e) || !isDefined(self.var_c27f1e90)) {
    return;
  }

  if(!isinarray(level.var_b8be892e, self.var_c27f1e90[n_slot])) {
    return;
  }

  switch (n_slot) {
    case 0:
      str_clientfield = "" + #"hash_35fe26fc5cb223b3";
      break;
    case 1:
      str_clientfield = "" + #"hash_6fb426c48a4877e0";
      break;
    case 2:
      str_clientfield = "" + #"hash_345845080e40675d";
      break;
    case 3:
      str_clientfield = "" + #"hash_1da6660f0414562";
      break;
  }

  if(isDefined(str_clientfield)) {
    if(n_state == 0) {
      if(level function_adc671f5(n_slot)) {
        self clientfield::set_to_player(str_clientfield, self getentitynumber() + 1);
      }

      return;
    }

    if(!level function_adc671f5(n_slot) && n_state != 7) {
      return;
    }

    self clientfield::set_to_player(str_clientfield, n_state);
  }
}

function_ba56adf1(var_c188cf87, var_59ad3e22) {
  level endon(#"end_game");
  level flag::wait_till("all_players_spawned");
  level clientfield::set("" + #"hash_46334db9e3c76275", 1);

  while(true) {
    a_e_players = arraysortclosest(level.players, var_c188cf87, undefined, 0, 750);
    a_e_players = array::filter(a_e_players, 0, &function_66c0d837, var_c188cf87, var_59ad3e22);

    if(a_e_players.size) {
      a_e_players[0] function_c99f4d81(var_c188cf87, var_59ad3e22);
    }

    wait 4;
  }
}

function_c99f4d81(var_c188cf87, var_59ad3e22) {
  self endon(#"death", #"disconnect");
  b_first_loop = 1;

  while(function_66c0d837(self, var_c188cf87, var_59ad3e22)) {
    if(b_first_loop) {
      b_first_loop = 0;
      level.var_223d9df6 = self;
      n_clientfield_val = self getentitynumber() + 1;
      self clientfield::set("" + #"hash_222c3403d2641ea6", n_clientfield_val);
    }

    wait 1;
  }

  self clientfield::set("" + #"hash_222c3403d2641ea6", 0);
  level.var_223d9df6 = undefined;
}

function_66c0d837(e_player, var_c188cf87, var_59ad3e22) {
  if(zm_utility::is_player_valid(e_player) && distancesquared(e_player.origin, var_c188cf87) < 562500 && abs(e_player.origin[2] - var_c188cf87[2]) < 85 && vectordot(vectornormalize(e_player.origin - var_c188cf87), anglesToForward(var_59ad3e22)) > 0) {
    return true;
  }

  return false;
}

function_df87281a(var_16c042b8, b_extra = 0) {
  if(b_extra) {
    self function_a7ae070c(var_16c042b8);
  } else {
    self.var_c27f1e90[4] = var_16c042b8;
    self function_9bdf581f(var_16c042b8, 4);
    self function_b8c12b0f(3, 1);
  }

  self function_4d342a8f();
}

function_4d342a8f() {
  if(!self hasperk(#"specialty_fastreload")) {
    perks::perk_setperk(#"specialty_fastreload");
  }
}

function_528f82a9() {
  if(self hasperk(#"specialty_fastreload")) {
    perks::perk_unsetperk(#"specialty_fastreload");
  }
}

function_c709e667(str_name) {
  return isinarray(level.var_5355c665, str_name);
}

function_b4c0e0ee(n_bleedout_time) {
  self endon(#"player_revived", #"disconnect", #"bled_out");
  level endon(#"round_reset");
  self thread function_d3b5e743();

  if(isDefined(self.var_39c78617) && self.var_39c78617) {
    return;
  }

  n_wait = (n_bleedout_time - 0.1) / 4;
  self function_28ac0614(n_wait);
}

function_d3b5e743() {
  self endon(#"player_revived", #"disconnect");
  level endon(#"round_reset");
  self waittill(#"bled_out");
  self function_28ac0614(undefined, 1);
}

function_28ac0614(var_bbb2c705, var_613b7621 = 0) {
  if(isDefined(self.var_cd5d9345)) {
    var_cd5d9345 = arraycopy(self.var_cd5d9345);
  } else {
    var_cd5d9345 = [];
  }

  var_cd0340f4 = isDefined(var_bbb2c705) && zombie_utility::get_zombie_var("perks_decay") && zm_custom::function_901b751c(#"zmperkdecay") == 1;

  if(var_cd0340f4) {
    self function_dc10fc94(var_cd5d9345, var_bbb2c705);

    foreach(var_d105825e in var_cd5d9345) {
      if(zm_trial_disable_perks::is_active()) {
        b_wait = self zm_trial_disable_perks::lose_perk(var_d105825e);
      } else {
        self notify(var_d105825e + "_stop", {
          #var_613b7621: var_613b7621
        });
        b_wait = 1;
      }

      if(b_wait && !(isDefined(self.var_39c78617) && self.var_39c78617)) {
        self waittilltimeout(var_bbb2c705, #"instakill_player");
      }
    }

    return;
  }

  if(level.enable_magic && isDefined(zm_custom::function_901b751c(#"zmperksactive")) && zm_custom::function_901b751c(#"zmperksactive")) {
    for(i = 3; i >= 0; i--) {
      if(zm_trial_disable_perks::is_active()) {
        self zm_trial_disable_perks::lose_perk(self.var_c27f1e90[i]);
        continue;
      }

      if(isinarray(self.var_466b927f, self.var_c27f1e90[i])) {
        self notify(self.var_c27f1e90[i] + "_stop", {
          #var_613b7621: var_613b7621
        });
      }
    }
  }
}

private function_dc10fc94(var_cd5d9345, var_bbb2c705) {
  var_8b77bf0c = arraycopy(var_cd5d9345);
  var_c25e1f9c = array(0, 1, 2, 3);
  var_b0696a17 = [];

  if(var_8b77bf0c.size <= 1) {
    for(n_slot = 0; n_slot < 4; n_slot++) {
      self clientfield::set_player_uimodel("hudItems.perkVapor." + n_slot + ".bleedoutOrderIndex", n_slot);
      self clientfield::set_player_uimodel("hudItems.perkVapor." + n_slot + ".bleedoutActive", 0);
    }

    self clientfield::set_player_uimodel("hudItems.perkVapor.bleedoutProgress", 1);
    var_b0696a17 = array::reverse(var_c25e1f9c);
  } else {
    arrayremoveindex(var_8b77bf0c, 0);

    for(n_slot = 3; n_slot >= 0; n_slot--) {
      if(var_8b77bf0c.size) {
        var_224c0c9c = function_c1efcc57(var_8b77bf0c[0]);
        arrayremoveindex(var_8b77bf0c, 0);
        arrayremovevalue(var_c25e1f9c, var_224c0c9c);

        if(var_224c0c9c >= 0 && var_224c0c9c < 4) {
          self clientfield::set_player_uimodel("hudItems.perkVapor." + var_224c0c9c + ".bleedoutActive", 1);
        }
      }

      if(!isDefined(var_224c0c9c)) {
        var_224c0c9c = var_c25e1f9c[0];
        arrayremoveindex(var_c25e1f9c, 0);
        self clientfield::set_player_uimodel("hudItems.perkVapor." + var_224c0c9c + ".bleedoutActive", 0);
      }

      if(var_224c0c9c >= 0 && var_224c0c9c < 4) {
        if(!isDefined(var_b0696a17)) {
          var_b0696a17 = [];
        } else if(!isarray(var_b0696a17)) {
          var_b0696a17 = array(var_b0696a17);
        }

        var_b0696a17[var_b0696a17.size] = var_224c0c9c;
        self clientfield::set_player_uimodel("hudItems.perkVapor." + var_224c0c9c + ".bleedoutOrderIndex", n_slot);
      }

      var_224c0c9c = undefined;
    }

    self clientfield::set_player_uimodel("hudItems.perkVapor.bleedoutProgress", 1);
  }

  self thread set_bleedout_progress(var_bbb2c705, var_b0696a17);
}

private set_bleedout_progress(var_bbb2c705, var_b0696a17) {
  self endon(#"player_revived", #"zombified", #"disconnect");
  level endon(#"end_game", #"round_reset");

  if(var_bbb2c705 == 0) {
    var_bbb2c705 = 0.001;
  }

  var_73db1c5d = 0;
  n_time_elapsed = 0;

  while(var_73db1c5d < 4) {
    n_perc = math::clamp(n_time_elapsed / var_bbb2c705, 0, 1);
    var_78835e6 = 1 * (n_perc + var_73db1c5d) / 4;
    self clientfield::set_player_uimodel("hudItems.perkVapor.bleedoutProgress", 1 - var_78835e6);

    if(n_perc == 1) {
      n_time_elapsed = 0;
      var_73db1c5d++;
    }

    n_time_elapsed += 0.05;
    wait 0.05;
  }
}

function_2babacc2() {
  var_8cf447e1 = [];

  foreach(var_16c042b8 in self.var_774e0ad7) {
    n_slot = function_c1efcc57(var_16c042b8);

    if(n_slot >= 0) {
      self function_9bdf581f(var_16c042b8, n_slot, 0);

      if(!isDefined(var_8cf447e1)) {
        var_8cf447e1 = [];
      } else if(!isarray(var_8cf447e1)) {
        var_8cf447e1 = array(var_8cf447e1);
      }

      var_8cf447e1[var_8cf447e1.size] = n_slot;
    }
  }

  for(i = 0; i < 4; i++) {
    if(isinarray(var_8cf447e1, i) && !self.var_47654123[i]) {
      n_state = 6;
    } else {
      n_state = 0;
    }

    self function_fb633f9d(i, n_state);
  }
}

function_e56d8ef4(str_perk_name) {
  if(isinarray(self.var_774e0ad7, str_perk_name)) {
    return true;
  }

  return false;
}

private function_d1cad55c(var_16c042b8) {
  if(function_e56d8ef4(var_16c042b8)) {
    return true;
  }

  return false;
}

register_lost_perk_override(func_override) {
  if(!isDefined(level.var_91ac8112)) {
    level.var_91ac8112 = [];
  } else if(!isarray(level.var_91ac8112)) {
    level.var_91ac8112 = array(level.var_91ac8112);
  }

  level.var_91ac8112[level.var_91ac8112.size] = func_override;
}

lost_perk_override(perk) {
  if(!self laststand::player_is_in_laststand()) {
    return false;
  }

  foreach(var_a4dddafc in level.var_91ac8112) {
    if(self[[var_a4dddafc]](perk)) {
      return true;
    }
  }

  return false;
}

function_b2dfd295(perk, var_8c7df7fc) {
  str_endon = "return_perk_on_revive_" + perk;
  self notify(str_endon);
  self endon(str_endon, #"disconnect", #"bled_out");

  if(!isDefined(self.var_1898de24)) {
    self.var_1898de24 = [];
  } else if(!isarray(self.var_1898de24)) {
    self.var_1898de24 = array(self.var_1898de24);
  }

  if(!isinarray(self.var_1898de24, var_8c7df7fc)) {
    self.var_1898de24[self.var_1898de24.size] = var_8c7df7fc;
  }

  for(x = 0; x < self.var_c27f1e90.size; x++) {
    if(self.var_c27f1e90[x] == perk) {
      var_c3f41835 = x;
    }
  }

  if(var_c3f41835 === 4) {
    return;
  }

  waitresult = self waittill(#"player_revived");
  e_reviver = waitresult.reviver;
  var_84280a99 = waitresult.var_a4916eac;

  foreach(var_8c7df7fc in self.var_1898de24) {
    if(self[[var_8c7df7fc]](e_reviver, var_84280a99)) {
      var_54b72e0c = 1;
      break;
    }
  }

  if(!(isDefined(var_54b72e0c) && var_54b72e0c)) {
    return;
  }

  waitframe(1);

  if(isDefined(var_c3f41835)) {
    if(self.var_47654123[var_c3f41835]) {
      self thread function_f9385a02(perk, var_c3f41835);
    }

    self thread function_9bdf581f(perk, var_c3f41835);
    return;
  }

  self thread function_a7ae070c(perk);
}

register_actor_damage_override(str_perk, actor_damage_override_func) {
  if(!isDefined(level.var_f5021cbd)) {
    level.var_f5021cbd = [];
  }

  level.var_f5021cbd[str_perk] = actor_damage_override_func;
}

actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(isplayer(attacker)) {
    if(isDefined(attacker.var_466b927f) && isarray(attacker.var_466b927f)) {
      foreach(str_perk in attacker.var_466b927f) {
        if(isDefined(level.var_f5021cbd[str_perk])) {
          damage = [
            [level.var_f5021cbd[str_perk]]
          ](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
        }
      }
    }

    if(isDefined(attacker.var_67ba1237) && isarray(attacker.var_67ba1237)) {
      foreach(str_perk in attacker.var_67ba1237) {
        if(isDefined(level.var_f5021cbd[str_perk])) {
          damage = [
            [level.var_f5021cbd[str_perk]]
          ](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
        }
      }
    }
  }

  return damage;
}

function_756e6a6d() {
  ip1 = self getentitynumber() + 1;
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:xada>" + ip1 + "<dev string:xb1b>");
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:xb35>" + ip1 + "<dev string:xb76>");
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:xb8f>" + ip1 + "<dev string:xbd7>");
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:xbf8>" + ip1 + "<dev string:xc3a>");
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:xc55>" + ip1 + "<dev string:xc9c>");
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:xcbb>" + ip1 + "<dev string:xd01>");
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:xd20>" + ip1 + "<dev string:xd62>");
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:xd7d>" + ip1 + "<dev string:xdbe>");
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:xdd7>" + ip1 + "<dev string:xe1b>");
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:xe37>" + ip1 + "<dev string:xe7b>");
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:xe98>" + ip1 + "<dev string:xed6>");
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:xeed>" + ip1 + "<dev string:xf2d>");
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:xf46>" + ip1 + "<dev string:xf88>");
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:xfa3>" + ip1 + "<dev string:xfe3>");
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:xffc>" + ip1 + "<dev string:x1047>");
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:x1060>" + ip1 + "<dev string:x10a3>");
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:x10be>" + ip1 + "<dev string:x1104>");
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:x1123>" + ip1 + "<dev string:x1164>");
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:x117e>" + ip1 + "<dev string:x11b3>");
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:x11ca>" + ip1 + "<dev string:x11ff>");
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:x1216>" + ip1 + "<dev string:x124b>");
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:x1262>" + ip1 + "<dev string:x1297>");
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:x12ae>" + ip1 + "<dev string:x12e5>");
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:x12fa>" + ip1 + "<dev string:x132f>");
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:x1346>" + ip1 + "<dev string:x137b>");
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:x1392>" + ip1 + "<dev string:x13c7>");
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:x13de>" + ip1 + "<dev string:x1413>");
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:x142a>" + ip1 + "<dev string:x1461>");
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:x1476>" + ip1 + "<dev string:x14b5>");
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:x14d6>" + ip1 + "<dev string:x1515>");
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:x1536>" + ip1 + "<dev string:x1575>");
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:x1596>" + ip1 + "<dev string:x15d5>");
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:x15f6>" + ip1 + "<dev string:x1637>");
  adddebugcommand("<dev string:xabb>" + self.name + "<dev string:xad4>" + ip1 + "<dev string:x1656>" + ip1 + "<dev string:x168d>");
}

function_545a79c() {
  level notify(#"zombie_vapor_devgui");
  level endon(#"zombie_vapor_devgui");

  for(;;) {
    cmd = getdvarstring(#"zombie_vapor_devgui");
    str_perk = undefined;
    var_eb4c64e8 = undefined;
    var_f79903dc = undefined;
    var_4ee327af = undefined;
    var_dfa7102 = undefined;
    var_8d1a1acc = undefined;
    var_b1cb5669 = undefined;
    var_c4819a86 = undefined;

    switch (cmd) {
      case #"hash_a687f7ed9396339":
      case #"hash_2b731e891eadd00a":
      case #"hash_714bd7d5b19367cb":
      case #"hash_47e87df26f2bb654":
        str_perk = #"specialty_shield";
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case #"hash_22db822f8cebba1f":
      case #"hash_3547aac06cbbd656":
      case #"hash_2c6e9bd17e4c70e5":
      case #"hash_1fc0acc0b9c31200":
        str_perk = #"specialty_berserker";
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case #"hash_59dfac7d036a7f11":
      case #"hash_5fdbbc96a07023ea":
      case #"hash_72cd05a9f7096d18":
      case #"hash_696b25a08319319f":
        str_perk = #"specialty_awareness";
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case #"hash_20e1f2a12f575ad":
      case #"hash_1067d35a903aa090":
      case #"hash_60a8ca620122ce03":
      case #"hash_37f041c2ceccaa32":
        str_perk = #"specialty_camper";
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case #"hash_4d8a429ced485336":
      case #"hash_451695d8096ae1b8":
      case #"hash_4e334d102e76aa39":
      case #"hash_3797acd439d9338b":
        str_perk = #"specialty_mystery";
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case #"hash_582c07780b2a70d7":
      case #"hash_2ad319babe68ddd9":
      case #"hash_7a8b3d3703b1d56e":
      case #"hash_460157accd31661c":
        str_perk = #"specialty_phdflopper";
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case #"hash_7237eda7099e624d":
      case #"hash_b5286c82d1f26c3":
      case #"hash_7b790d5f36b4c12":
      case #"hash_3fe4509a2ac36a60":
        str_perk = #"specialty_cooldown";
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case #"hash_17377d35be324020":
      case #"hash_4d0551e8fc1a3eaa":
      case #"hash_1e0b58a0910c3247":
      case #"hash_52f021b5af5b6f01":
        str_perk = #"specialty_additionalprimaryweapon";
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case #"hash_215605bc01af2e0":
      case #"hash_77c9ba94611f14a7":
      case #"hash_3c2392a146da0ca1":
      case #"hash_272741eeae13ac9a":
        str_perk = #"specialty_deadshot";
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case #"hash_6650c5a8596d4707":
      case #"hash_4b97c729fbbb68e5":
      case #"hash_12b3c2d6eb971006":
      case #"hash_2ad8c584d069c098":
        str_perk = #"specialty_staminup";
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case #"hash_1f2e309303a233e8":
      case #"hash_77bfaaec70d8daa":
      case #"hash_591f1871abf8a417":
      case #"hash_30bfdad9100956cd":
        str_perk = #"specialty_quickrevive";
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case #"hash_3985b954c5d57fd7":
      case #"hash_4dd9c0937255fe1a":
      case #"hash_2b9b74bc8b7a95b9":
      case #"hash_338cf8868ad12888":
        str_perk = #"specialty_electriccherry";
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case #"hash_73cbb686dc065831":
      case #"hash_3e92ee8a1f94e218":
      case #"hash_6bc1e0d615f04132":
      case #"hash_400b86629283f29f":
        str_perk = #"specialty_widowswine";
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case #"hash_3419add8481e7fa1":
      case #"hash_4d21953ef7610b73":
      case #"hash_5cebc01e01fc9e18":
      case #"hash_74a3737c1fa820fa":
        str_perk = #"specialty_extraammo";
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case #"hash_572d09f7e8a7b929":
      case #"hash_5d8694f5297752a4":
      case #"hash_31f8545325031336":
      case #"hash_4c6b49a740457f87":
        str_perk = #"specialty_etherealrazor";
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case #"hash_5ffd9216593e9fb":
      case #"hash_23b50d4339535dd5":
      case #"hash_6e7de8150825b688":
      case #"hash_6e080192e412f0e6":
        str_perk = #"specialty_zombshell";
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case #"hash_2bc2dabec1637ab7":
      case #"hash_7a33b4202b9ebdc8":
      case #"hash_42ed16109e9963d6":
      case #"hash_3eb60ad87ca70645":
        str_perk = #"specialty_wolf_protector";
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case #"hash_bdedb98e101b1af":
      case #"hash_57394397497fc4ae":
      case #"hash_2ea5f415373bd890":
      case #"hash_6c0c3fd6f9785c85":
        str_perk = #"specialty_death_dash";
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case #"hash_36d28b98c683b0ed":
      case #"hash_122b73a9059c70bc":
      case #"hash_796b16a6e51d3223":
      case #"hash_2621dbc67d96d6b6":
        var_f79903dc = 0;
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case #"hash_122b76a9059c75d5":
      case #"hash_36d28898c683abd4":
      case #"hash_796b17a6e51d33d6":
      case #"hash_2621dac67d96d503":
        var_f79903dc = 1;
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case #"hash_796b18a6e51d3589":
      case #"hash_36d28998c683ad87":
      case #"hash_122b75a9059c7422":
      case #"hash_2621d9c67d96d350":
        var_f79903dc = 2;
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case #"hash_122b70a9059c6ba3":
      case #"hash_36d28698c683a86e":
      case #"hash_2621e0c67d96df35":
      case #"hash_796b19a6e51d373c":
        var_f79903dc = 3;
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case #"hash_63368be670c1631":
      case #"hash_4e75f62ab878637a":
      case #"hash_2227c4347bf7aff7":
      case #"hash_56baf79467fa8098":
        var_f79903dc = 4;
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case #"hash_5c050766529e83a8":
      case #"hash_2a94a682beedaf35":
      case #"hash_4205942f3e57758a":
      case #"hash_75d5e1ee4bb9b063":
        var_4ee327af = 0;
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case #"hash_2a94a382beedaa1c":
      case #"hash_4205932f3e5773d7":
      case #"hash_5c050a66529e88c1":
      case #"hash_75d5e2ee4bb9b216":
        var_4ee327af = 1;
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case #"hash_2a94a482beedabcf":
      case #"hash_5c050966529e870e":
      case #"hash_4205922f3e577224":
      case #"hash_75d5e3ee4bb9b3c9":
        var_4ee327af = 2;
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case #"hash_4205912f3e577071":
      case #"hash_2a94a182beeda6b6":
      case #"hash_5c050c66529e8c27":
      case #"hash_75d5e4ee4bb9b57c":
        var_4ee327af = 3;
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case #"hash_e3aea524ee28666":
      case #"hash_19d7dd5f676b170c":
      case #"hash_5a852048c409f6b7":
      case #"hash_20102f0482e5bdb9":
        var_4ee327af = 4;
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case #"hash_37e9f4522a62290f":
      case #"hash_6fa3e37013c04980":
      case #"hash_21a07f54e2de98fe":
      case #"hash_57ed1fb7940f33b5":
        var_dfa7102 = 0;
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case #"hash_57ed1cb7940f2e9c":
      case #"hash_6fa3e67013c04e99":
      case #"hash_37e9f5522a622ac2":
      case #"hash_21a07e54e2de974b":
        var_dfa7102 = 1;
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case #"hash_57ed1db7940f304f":
      case #"hash_37e9f6522a622c75":
      case #"hash_21a07d54e2de9598":
      case #"hash_6fa3e57013c04ce6":
        var_dfa7102 = 2;
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case #"hash_57ed1ab7940f2b36":
      case #"hash_37e9ef522a622090":
      case #"hash_21a08454e2dea17d":
      case #"hash_6fa3e87013c051ff":
        var_dfa7102 = 3;
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case #"hash_11bcb93b01611b04":
      case #"hash_58bb5da598842e39":
      case #"hash_78960bd8157b64e2":
      case #"hash_79a3bb05585eb7fb":
        var_dfa7102 = 4;
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case #"hash_560a015fd8fc8f56":
      case #"hash_4a38f3e91e628364":
      case #"hash_1f66bfabd16987cb":
      case #"hash_5eee967ea5d92169":
        var_c4819a86 = 1;
        var_8d1a1acc = strtok(cmd, "<dev string:x16a3>");
        var_eb4c64e8 = int(var_8d1a1acc[1]) - 1;
        break;
      case 0:
        break;
    }

    if(isDefined(var_eb4c64e8)) {
      foreach(player in level.players) {
        if(isDefined(player)) {
          if(var_eb4c64e8 == player getentitynumber()) {
            var_b1cb5669 = player;
            break;
          }
        }
      }
    }

    if(isDefined(var_b1cb5669)) {
      if(isDefined(str_perk)) {
        var_b1cb5669 function_36710277(str_perk);
      } else if(isDefined(var_f79903dc)) {
        var_b1cb5669 function_869a50c0(var_f79903dc);
      } else if(isDefined(var_4ee327af)) {
        var_b1cb5669 function_413a7dd7(var_4ee327af);
      } else if(isDefined(var_dfa7102)) {
        var_b1cb5669 function_a18c6089(var_dfa7102);
      } else if(isDefined(var_c4819a86) && var_c4819a86) {
        var_b1cb5669 function_b2cba45a();
      }
    }

    setdvar(#"zombie_vapor_devgui", "<dev string:x16a7>");
    wait 0.5;
  }
}

function_36710277(var_16c042b8) {
  if(self.var_466b927f.size >= 4) {
    iprintlnbold("<dev string:x16aa>");
    return;
  }

  if(isinarray(self.var_c27f1e90, var_16c042b8)) {
    iprintlnbold("<dev string:x16c2>");
    return;
  }

  for(i = 0; i < 4; i++) {
    if(!isinarray(self.var_466b927f, self.var_c27f1e90[i])) {
      self thread function_81bc6765(i, level._custom_perks[var_16c042b8].alias);
      self.var_c27f1e90[i] = var_16c042b8;

      if(i == 3) {
        self.var_c27f1e90[4] = level.var_5355c665[var_16c042b8];
      }

      self function_29387491(var_16c042b8, i);
      return;
    }
  }
}

function_869a50c0(n_slot) {
  if(n_slot < 4) {
    var_16c042b8 = self.var_c27f1e90[n_slot];

    if(isinarray(self.var_466b927f, var_16c042b8)) {
      iprintlnbold("<dev string:x16e4>");
      return;
    }

    self function_29387491(var_16c042b8, n_slot);
    return;
  }

  self function_cc24f525();
}

function_413a7dd7(n_slot) {
  if(n_slot < 4) {
    var_16c042b8 = self.var_c27f1e90[n_slot];

    if(!isinarray(self.var_466b927f, var_16c042b8)) {
      iprintlnbold("<dev string:x1702>");
      return;
    }

    self notify(var_16c042b8 + "<dev string:x1719>", {
      #var_613b7621: 1
    });
    return;
  }

  foreach(var_16c042b8 in self.var_c27f1e90) {
    if(isinarray(self.var_466b927f, var_16c042b8)) {
      self notify(var_16c042b8 + "<dev string:x1719>", {
        #var_613b7621: 1
      });
    }
  }
}

function_a18c6089(n_slot) {
  if(n_slot < 4) {
    self function_9b641809(n_slot);
    return;
  }

  for(i = 0; i < 4; i++) {
    self function_9b641809(i);
  }
}


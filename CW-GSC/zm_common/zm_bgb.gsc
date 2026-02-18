/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_bgb.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\potm_shared;
#using scripts\core_common\rank_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb_pack;
#using scripts\zm_common\zm_contracts;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#namespace bgb;

function private autoexec __init__system__() {
  system::register(#"bgb", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  callback::on_connect(&on_player_connect);

  if(!is_true(level.bgb_in_use)) {
    return;
  }

  level.weaponbgbgrab = getweapon(#"zombie_bgb_grab");
  level.var_ddff6359 = array(getweapon(#"hash_d0f29de78e218ad"), getweapon(#"hash_5e07292c519531e6"), getweapon(#"hash_305e5faa9ecb625a"), getweapon(#"hash_23cc1f9c16b375c3"), getweapon(#"hash_155cc0a9ba3c3260"), getweapon(#"hash_2394c41f048f7d2"), getweapon(#"hash_4565adf3abc61ea3"));
  level.bgb = [];
  clientfield::register_clientuimodel("zmhud.bgb_current", 1, 8, "int", 0);
  clientfield::register_clientuimodel("zmhud.bgb_display", 1, 1, "int", 0);
  clientfield::register_clientuimodel("zmhud.bgb_timer", 1, 8, "float", 0);
  clientfield::register_clientuimodel("zmhud.bgb_activations_remaining", 1, 3, "int", 0);
  clientfield::register_clientuimodel("zmhud.bgb_invalid_use", 1, 1, "counter", 0);
  clientfield::register_clientuimodel("zmhud.bgb_one_shot_use", 1, 1, "counter", 0);
  clientfield::register("toplayer", "bgb_blow_bubble", 1, 1, "counter");
  zm::register_vehicle_damage_callback(&vehicle_damage_override);
  zm_perks::register_lost_perk_override(&lost_perk_override);
}

function private postinit() {
  if(!is_true(level.bgb_in_use)) {
    return;
  }

  bgb_finalize();

  level thread setup_devgui();

  level._effect[# "samantha_steal"] = # "zombie/fx_monkey_lightning_zmb";
}

function private on_player_connect() {
  self.bgb = # "none";

  if(!is_true(level.bgb_in_use)) {
    return;
  }

  self thread bgb_player_init();
  self.var_1898de24 = [];
}

function private bgb_player_init() {
  if(isDefined(self.bgb_pack)) {
    for(i = 0; i < 4; i++) {
      if(isDefined(self.bgb_pack[i]) && isDefined(level.bgb[self.bgb_pack[i]])) {
        self bgb_pack::function_7b91e81c(i, level.bgb[self.bgb_pack[i]].item_index);
      }
    }

    return;
  }

  self.bgb_pack = self getbubblegumpack();

  for(x = 0; x < self.bgb_pack.size; x++) {
    if(isstring(self.bgb_pack[x])) {
      self.bgb_pack[x] = hash(self.bgb_pack[x]);
    }
  }

  self.bgb_pack_randomized = [];
  var_6e18a410 = array();

  for(i = 0; i < 4; i++) {
    str_bgb = self.bgb_pack[i];

    if(str_bgb == # "weapon_null") {
      continue;
    }

    if(zm_custom::function_3ac936c6(str_bgb)) {
      var_6e18a410[i] = str_bgb;
      continue;
    }

    if(str_bgb != # "weapon_null" && self getbgbremaining(str_bgb) > 0) {
      self thread zm_custom::function_deae84ba();
    }
  }

  self.bgb_pack = var_6e18a410;

  if(isDefined(self.var_d03d9cf3)) {
    self.bgb_pack = self.var_d03d9cf3;
  }

  self.bgb_stats = [];

  foreach(bgb in self.bgb_pack) {
    if(bgb == # "weapon_null") {
      continue;
    }

    if(isDefined(level.bgb) && isDefined(level.bgb[bgb]) && !is_true(level.bgb[bgb].consumable)) {
      continue;
    }

    self.bgb_stats[bgb] = spawnStruct();

    if(!isbot(self)) {
      self.bgb_stats[bgb].var_c2a984f0 = self getbgbremaining(bgb);
    } else {
      self.bgb_stats[bgb].var_c2a984f0 = 0;
    }

    self.bgb_stats[bgb].bgb_used_this_game = 0;
  }

  self init_weapon_cycling();
  self thread bgb_player_monitor();
  self thread bgb_end_game();

  for(i = 0; i < 4; i++) {
    if(isDefined(self.bgb_pack[i]) && isDefined(level.bgb[self.bgb_pack[i]])) {
      self bgb_pack::function_7b91e81c(i, level.bgb[self.bgb_pack[i]].item_index);
    }
  }

  if(zm_custom::function_901b751c(#"zmelixirsdurables")) {
    var_66dd5e25 = array(#"zm_bgb_nowhere_but_there", #"zm_bgb_now_you_see_me");
    n_rank = self rank::getrank() + 1;

    foreach(bgb in level.bgb) {
      str_name = bgb.name;

      if(bgb.rarity === 0 && str_name != # "zm_bgb_point_drops" && !array::contains(self.bgb_pack, str_name)) {
        var_544e77f8 = level.bgb[str_name].var_a1750d43;

        if((!isDefined(var_544e77f8) || isDefined(var_544e77f8) && n_rank >= var_544e77f8 || function_bea73b01() == 1) && zm_custom::function_3ac936c6(str_name)) {
          if(!isinarray(var_66dd5e25, str_name)) {
            if(!isDefined(self.var_2b74c8fe)) {
              self.var_2b74c8fe = [];
            } else if(!isarray(self.var_2b74c8fe)) {
              self.var_2b74c8fe = array(self.var_2b74c8fe);
            }

            self.var_2b74c8fe[self.var_2b74c8fe.size] = str_name;
          }

          if(!isDefined(self.var_82971641)) {
            self.var_82971641 = [];
          } else if(!isarray(self.var_82971641)) {
            self.var_82971641 = array(self.var_82971641);
          }

          self.var_82971641[self.var_82971641.size] = str_name;
        }
      }
    }
  }
}

function private bgb_end_game() {
  self endon(#"disconnect");
  self waittill(#"report_bgb_consumption");
  self thread take();
}

function private bgb_finalize() {
  foreach(v in level.bgb) {
    v.item_index = getitemindexfromref(v.name);
    var_ddcb67f4 = getunlockableiteminfofromindex(v.item_index, 2);
    v.stat_index = isDefined(var_ddcb67f4) && isDefined(var_ddcb67f4.var_2f8e25b8) ? var_ddcb67f4.var_2f8e25b8 : 0;
    var_5415dfb9 = function_b143666d(v.item_index, 2);

    if(!isDefined(var_ddcb67f4) || !isDefined(var_5415dfb9)) {
      println("<dev string:x38>" + v.name + "<dev string:x4a>");
      continue;
    }

    if(!isDefined(var_5415dfb9.bgbrarity)) {
      var_5415dfb9.bgbrarity = 0;
    }

    v.rarity = var_5415dfb9.bgbrarity;

    if(0 == v.rarity || 1 == v.rarity) {
      v.consumable = 0;
    } else {
      v.consumable = 1;
    }

    v.camo_index = var_5415dfb9.var_daefc551;
    v.dlc_index = var_ddcb67f4.dlc;
  }
}

function private bgb_player_monitor() {
  self endon(#"disconnect");

  while(true) {
    waitresult = level waittill(#"between_round_over", #"restart_round");
    str_return = waitresult._notify;

    if(isDefined(level.var_b77403b9)) {
      if(!is_true(self[[level.var_b77403b9]]())) {
        continue;
      }
    }

    if(str_return === "restart_round") {
      level waittill(#"between_round_over");
    }
  }
}

function private setup_devgui() {
  waittillframeend();
  setDvar(#"bgb_acquire_devgui", "<dev string:x7b>");
  setDvar(#"hash_7877ee182ba11433", -1);
  bgb_devgui_base = "<dev string:x7f>";
  keys = getarraykeys(level.bgb);

  foreach(key in keys) {
    name = function_9e72a96(level.bgb[key].name);
    adddebugcommand(bgb_devgui_base + name + "<dev string:x96>" + "<dev string:xa7>" + "<dev string:xbd>" + name + "<dev string:xc2>");
  }

  adddebugcommand(bgb_devgui_base + "<dev string:xc9>" + "<dev string:xdf>" + "<dev string:xbd>" + "<dev string:xf4>" + "<dev string:xc2>");

  for(i = 0; i < 4; i++) {
    playernum = i + 1;
    adddebugcommand(bgb_devgui_base + "<dev string:xfa>" + playernum + "<dev string:x10c>" + "<dev string:xdf>" + "<dev string:xbd>" + i + "<dev string:xc2>");
  }

  level thread bgb_devgui_think();
}

function private bgb_devgui_think() {
  for(;;) {
    var_522737d6 = getdvarstring(#"bgb_acquire_devgui");

    if(var_522737d6 != "<dev string:x7b>") {
      bgb_devgui_acquire(var_522737d6);
    }

    setDvar(#"bgb_acquire_devgui", "<dev string:x7b>");
    wait 0.5;
  }
}

function private bgb_devgui_acquire(bgb_name) {
  bgb_name = hash(bgb_name);
  playerid = getdvarint(#"hash_7877ee182ba11433", 0);
  players = getplayers();

  for(i = 0; i < players.size; i++) {
    if(playerid != -1 && playerid != i) {
      continue;
    }

    if(#"none" == bgb_name) {
      players[i] thread take();
      continue;
    }

    players[i] bgb_gumball_anim(bgb_name);

    if(isDefined(level.bgb[bgb_name].activation_func)) {
      players[i] thread run_activation_func(bgb_name);
    }
  }
}

function private bgb_debug_text_display_init() {
  self.bgb_debug_text = newdebughudelem(self);
  self.bgb_debug_text.elemtype = "<dev string:x117>";
  self.bgb_debug_text.font = "<dev string:x11f>";
  self.bgb_debug_text.fontscale = 1.8;
  self.bgb_debug_text.horzalign = "<dev string:x12c>";
  self.bgb_debug_text.vertalign = "<dev string:x134>";
  self.bgb_debug_text.alignx = "<dev string:x12c>";
  self.bgb_debug_text.aligny = "<dev string:x134>";
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

  if(isDefined(activations_remaining)) {}

  self notify(#"bgb_set_debug_text_thread");
  self endon(#"bgb_set_debug_text_thread", #"disconnect");
  self.bgb_debug_text fadeovertime(0.05);
  self.bgb_debug_text.alpha = 1;
  prefix = "<dev string:x13b>";
  short_name = name;

  if(issubstr(name, prefix)) {
    short_name = getsubstr(name, prefix.size);
  }

  if(isDefined(activations_remaining)) {
    self.bgb_debug_text settext("<dev string:x146>" + short_name + "<dev string:x14f>" + activations_remaining + "<dev string:x174>");
  } else {
    self.bgb_debug_text settext("<dev string:x146>" + short_name);
  }

  wait 1;

  if(#"none" == name) {
    self.bgb_debug_text fadeovertime(1);
    self.bgb_debug_text.alpha = 0;
  }
}

function bgb_print_stats(bgb) {
  printtoprightln(function_9e72a96(bgb) + "<dev string:x17e>" + self.bgb_stats[bgb].var_c2a984f0, (1, 1, 1));
  printtoprightln(function_9e72a96(bgb) + "<dev string:x19b>" + self.bgb_stats[bgb].bgb_used_this_game, (1, 1, 1));
  n_available = self.bgb_stats[bgb].var_c2a984f0 - self.bgb_stats[bgb].bgb_used_this_game;
  printtoprightln(function_9e72a96(bgb) + "<dev string:x1b3>" + n_available, (1, 1, 1));
}

function private has_consumable_bgb(bgb) {
  if(!isDefined(self.bgb_stats[bgb]) || !is_true(level.bgb[bgb].consumable)) {
    return 0;
  }

  return 1;
}

function sub_consumable_bgb(bgb) {
  if(!has_consumable_bgb(bgb)) {
    return;
  }

  if(isDefined(level.bgb[bgb].var_f8d9ac8c) && ![[level.bgb[bgb].var_f8d9ac8c]]()) {
    return;
  }

  self.bgb_stats[bgb].bgb_used_this_game++;

  if(level flag::exists("first_consumables_used")) {
    level flag::set("first_consumables_used");
  }

  bgb_print_stats(bgb);
}

function get_bgb_available(bgb) {
  if(!isDefined(bgb)) {
    return false;
  }

  if(!isDefined(self.bgb_stats[bgb])) {
    return true;
  }

  var_cb4d0349 = self.bgb_stats[bgb].var_c2a984f0;
  n_bgb_used_this_game = self.bgb_stats[bgb].bgb_used_this_game;
  n_bgb_remaining = var_cb4d0349 - n_bgb_used_this_game;

  if(is_true(level.var_4af38aa3)) {
    return true;
  }

  return 0 < n_bgb_remaining;
}

function private function_b331a28c(bgb) {
  if(!is_true(level.bgb[bgb].var_50206ca3)) {
    return;
  }

  self val::set(#"bgb_activation", "takedamage", 0);
  s_result = self waittilltimeout(2, #"bgb_bubble_blow_complete");

  if(isDefined(self)) {
    self val::reset(#"bgb_activation", "takedamage");
  }
}

function private function_1f3eb76f(bgb) {
  if(!is_true(level.bgb[bgb].var_f1f46d6b)) {
    return;
  }

  self.var_e75517b1 = 1;
  self waittilltimeout(2, #"bgb_bubble_blow_complete");

  if(isDefined(self)) {
    self.var_e75517b1 = 0;
  }
}

function bgb_gumball_anim(bgb) {
  self endon(#"disconnect");
  level endon(#"end_game");

  if(self isinmovemode("ufo", "noclip")) {
    return false;
  }

  if(self laststand::player_is_in_laststand()) {
    return false;
  }

  weapon = bgb_get_gumball_anim_weapon(bgb);

  if(!isDefined(weapon)) {
    return false;
  }

  while(self isswitchingweapons() || self isusingoffhand() || self isthrowinggrenade() || self ismeleeing() || self function_61efcfe5() || self function_f071483d()) {
    waitframe(1);
  }

  while(is_true(self.var_1d940ef6)) {
    waitframe(1);
  }

  while(self getcurrentweapon() == level.weaponnone) {
    waitframe(1);
  }

  weapon_options = self function_6eff28b5(level.bgb[bgb].camo_index, 0, 0);
  self thread gestures::function_f3e2696f(bgb, weapon, weapon_options, 2.5, &function_16670e75, &function_3b2a02d8, &function_62f40b0d);

  while(self isswitchingweapons()) {
    waitframe(1);
  }

  evt = self waittilltimeout(3, #"hash_593f920e9efd2ecd", #"bgb_gumball_anim_give");

  if(isDefined(evt) && evt.bgb === bgb) {
    if(evt._notify == # "bgb_gumball_anim_give") {
      return true;
    }
  }

  return false;
}

function function_a6c704c(bgb) {
  self endon(#"disconnect");
  level endon(#"end_game");
  self thread function_b331a28c(bgb);
  self thread function_1f3eb76f(bgb);
  util::delay(#"offhand_fire", "death", &zm_audio::create_and_play_dialog, #"elixir", #"drink");

  if(is_true(level.bgb[bgb].var_4a9b0cdc) || self function_e98aa964(1)) {
    self notify(#"hash_27b238d082f65849", bgb);
    self activation_start();
    self thread run_activation_func(bgb);
    return true;
  }

  return false;
}

function run_activation_func(bgb) {
  self endon(#"disconnect");
  self set_active(1);
  self do_one_shot_use();
  self notify(#"bgb_bubble_blow_complete");
  self[[level.bgb[bgb].activation_func]]();
  self set_active(0);
  self activation_complete();
}

function private bgb_get_gumball_anim_weapon(bgb) {
  var_ab8d8da3 = undefined;

  if(isDefined(level.bgb[bgb])) {
    n_rarity = level.bgb[bgb].rarity;

    if(isDefined(level.var_ddff6359) && isDefined(n_rarity)) {
      var_ab8d8da3 = level.var_ddff6359[n_rarity];
    }
  }

  return var_ab8d8da3;
}

function function_16670e75(bgb) {
  if(!isDefined(self)) {
    return;
  }

  if(self laststand::player_is_in_laststand()) {
    return;
  }

  self thread function_b331a28c(bgb);
  self thread function_1f3eb76f(bgb);
}

function function_3b2a02d8(bgb) {
  if(!isDefined(self)) {
    return;
  }

  if(self laststand::player_is_in_laststand()) {
    return;
  }

  self notify(#"bgb_gumball_anim_give", {
    #bgb: bgb
  });
  self thread give(bgb);
  zm_audio::create_and_play_dialog(#"elixir", #"drink");
  self zm_stats::increment_client_stat("bgbs_chewed");
  self zm_stats::increment_player_stat("bgbs_chewed");
  self zm_stats::increment_challenge_stat(#"gum_gobbler_consume");
  self zm_stats::function_8f10788e("boas_bgbs_chewed");
  self zm_stats::function_c0c6ab19(#"hash_67f429ee3f93764d");

  if(level.bgb[bgb].rarity > 0) {
    self zm_stats::increment_challenge_stat(#"hash_41d41d501c70fb30");
  }

  self stats::inc_stat(#"bgb_stats", bgb, #"used", #"statvalue", 1);
  health = 0;

  if(isDefined(self.health)) {
    health = self.health;
  }

  if(is_true(level.bgb[bgb].consumable)) {
    self luinotifyevent(#"zombie_bgb_used", 1, level.bgb[bgb].item_index);
  }

  self recordmapevent(4, gettime(), self.origin, level.round_number, level.bgb[bgb].stat_index, health);
  demo::bookmark(#"zm_player_bgb_grab", gettime(), self);
  potm::bookmark(#"zm_player_bgb_grab", gettime(), self);
}

function function_62f40b0d(bgb, var_f3b15ce0) {
  if(!isDefined(self)) {
    return;
  }

  self notify(#"hash_593f920e9efd2ecd", {
    #bgb: var_f3b15ce0
  });
}

function private bgb_clear_monitors_and_clientfields() {
  self notify(#"bgb_limit_monitor");
  self notify(#"bgb_activation_monitor");
  self clientfield::set_player_uimodel("zmhud.bgb_display", 0);
  self clientfield::set_player_uimodel("zmhud.bgb_activations_remaining", 0);
  self clear_timer();
}

function private bgb_limit_monitor() {
  self notify(#"bgb_limit_monitor");
  self endon(#"bgb_limit_monitor", #"death", #"bgb_update");
  self clientfield::set_player_uimodel("zmhud.bgb_display", 1);
  self playsoundtoplayer(#"hash_56cc165edb993de8", self);

  switch (level.bgb[self.bgb].limit_type) {
    case # "activated":
      for(i = level.bgb[self.bgb].limit; i > 0; i--) {
        if(i != level.bgb[self.bgb].limit) {
          self playsoundtoplayer(#"hash_7bb31f4a25cf34a", self);
        }

        level.bgb[self.bgb].var_dbe7d224 = i;

        if(level.bgb[self.bgb].var_57eb02e) {
          function_f0d592c9();
        } else {
          self set_timer(i, level.bgb[self.bgb].limit);
        }

        self clientfield::set_player_uimodel("zmhud.bgb_activations_remaining", i);

        self thread bgb_set_debug_text(self.bgb, i);

        self waittill(#"bgb_activation");

        while(is_true(self get_active())) {
          waitframe(1);
        }
      }

      if(isDefined(self.bgb) && isDefined(level.bgb[self.bgb])) {
        level.bgb[self.bgb].var_dbe7d224 = 0;
      }

      self playsoundtoplayer(#"hash_b8e60131176554b", self);

      if(isDefined(self.bgb) && isDefined(level.bgb[self.bgb])) {
        self set_timer(0, level.bgb[self.bgb].limit);
      }

      while(is_true(self.bgb_activation_in_progress)) {
        waitframe(1);
      }

      break;
    case # "time":

      self thread bgb_set_debug_text(self.bgb);

      self thread run_timer(level.bgb[self.bgb].limit);
      self waittill(#"hash_347d2afccb8337ab");
      self playsoundtoplayer(#"hash_b8e60131176554b", self);
      break;
    case # "rounds":

      self thread bgb_set_debug_text(self.bgb);

      count = level.bgb[self.bgb].limit + 1;

      for(i = 0; i < count; i++) {
        if(i != 0) {
          self playsoundtoplayer(#"hash_7bb31f4a25cf34a", self);
        }

        self set_timer(count - i, count);
        level waittill(#"end_of_round");
      }

      self playsoundtoplayer(#"hash_b8e60131176554b", self);
      break;
    case # "event":

      self thread bgb_set_debug_text(self.bgb);

      self bgb_set_timer_clientfield(1);
      self[[level.bgb[self.bgb].limit]]();
      self playsoundtoplayer(#"hash_b8e60131176554b", self);
      break;
    default:
      assert(0, "<dev string:x1c3>" + self.bgb + "<dev string:x1e6>" + level.bgb[self.bgb].limit_type + "<dev string:x1f9>");
      break;
  }

  self thread take();
}

function private bgb_bled_out_monitor() {
  self endon(#"disconnect", #"bgb_update");
  self notify(#"bgb_bled_out_monitor");
  self endon(#"bgb_bled_out_monitor");
  self waittill(#"bled_out");
  self notify(#"bgb_about_to_take_on_bled_out");
  wait 0.1;
  self thread take();
}

function private bgb_activation_monitor() {
  self endon(#"disconnect");
  self notify(#"bgb_activation_monitor");
  self endon(#"bgb_activation_monitor");

  if("activated" != level.bgb[self.bgb].limit_type) {
    return;
  }

  for(;;) {
    self waittill(#"bgb_activation_request");
    waitframe(1);

    if(!self function_e98aa964(0)) {
      continue;
    }

    if(self function_a6c704c(self.bgb)) {
      self notify(#"bgb_activation", self.bgb);
    }
  }
}

function function_e98aa964(var_3e37f503 = 0, str_check = self.bgb) {
  var_ceb582a8 = isDefined(level.bgb[str_check].validation_func) && !self[[level.bgb[str_check].validation_func]]();
  var_e6b14ccc = isDefined(level.var_67713b46) && !self[[level.var_67713b46]]();

  if(!var_3e37f503 && is_true(self.is_drinking) || is_true(self.bgb_activation_in_progress) && !is_true(self.var_ec8a9710) || self laststand::player_is_in_laststand() || var_ceb582a8 || var_e6b14ccc || is_true(self.var_16735873) || is_true(self.var_30cbff55)) {
    self clientfield::increment_uimodel("zmhud.bgb_invalid_use");
    return false;
  }

  return true;
}

function private function_1fdcef80(bgb) {
  self endon(#"disconnect", #"bled_out", #"bgb_update");

  if(is_true(level.bgb[bgb].var_5a047886)) {
    function_9c8e12d1(6);
  } else {
    return;
  }

  self waittill(#"bgb_activation_request");
  self thread take();
}

function function_9c8e12d1(n_value) {
  self setactionslot(1, "bgb");
  self clientfield::set_player_uimodel("zmhud.bgb_activations_remaining", n_value);
}

function function_f37655df(n_value) {
  self clientfield::set_player_uimodel("zmhud.bgb_activations_remaining", 0);
}

function function_57eb02e(name) {
  level.bgb[name].var_57eb02e = 1;
}

function do_one_shot_use(skip_demo_bookmark = 0) {
  self clientfield::increment_uimodel("zmhud.bgb_one_shot_use");

  if(!skip_demo_bookmark) {
    demo::bookmark(#"zm_player_bgb_activate", gettime(), self);
    potm::bookmark(#"zm_player_bgb_activate", gettime(), self);
  }
}

function activation_start() {
  self.bgb_activation_in_progress = 1;
}

function private activation_complete() {
  self.bgb_activation_in_progress = 0;
  self notify(#"activation_complete");
}

function private set_active(b_is_active) {
  self.bgb_active = b_is_active;
}

function get_active() {
  return is_true(self.bgb_active);
}

function is_active(name) {
  if(!isDefined(self.bgb)) {
    return false;
  }

  return self.bgb == name && is_true(self.bgb_active);
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

  var_d1efe11 = level.bgb[name].ref_count;
  level.bgb[name].ref_count++;
  return var_d1efe11;
}

function decrement_ref_count(name) {
  if(!isDefined(level.bgb[name])) {
    return 0;
  }

  level.bgb[name].ref_count--;
  return level.bgb[name].ref_count;
}

function private calc_remaining_duration_lerp(start_time, end_time) {
  if(0 >= end_time - start_time) {
    return 0;
  }

  now = gettime();
  frac = float(end_time - now) / float(end_time - start_time);
  return math::clamp(frac, 0, 1);
}

function private function_af43111c(var_f205d85d, percent, var_5f12e334 = 0) {
  self endon(#"disconnect", #"hash_6ae783a3051b411b");

  if(var_5f12e334) {
    self.var_4b0fb2fb = 1;
  }

  start_time = gettime();
  end_time = start_time + 1000;
  var_2cd46f25 = var_f205d85d;

  while(var_2cd46f25 > percent) {
    var_2cd46f25 = lerpfloat(percent, var_f205d85d, calc_remaining_duration_lerp(start_time, end_time));
    self clientfield::set_player_uimodel("zmhud.bgb_timer", var_2cd46f25);
    waitframe(1);
  }

  if(var_5f12e334) {
    self.var_76c47001 = var_2cd46f25;
    self.var_4b0fb2fb = undefined;
  }
}

function private bgb_set_timer_clientfield(percent, var_5f12e334 = 0) {
  self notify(#"hash_6ae783a3051b411b");
  var_f205d85d = self clientfield::get_player_uimodel("zmhud.bgb_timer");

  if(percent < var_f205d85d && 0.1 <= var_f205d85d - percent) {
    self thread function_af43111c(var_f205d85d, percent, var_5f12e334);
    return;
  }

  self clientfield::set_player_uimodel("zmhud.bgb_timer", percent);
}

function private function_f0d592c9() {
  self bgb_set_timer_clientfield(1);
}

function set_timer(current, max, var_5f12e334 = 0) {
  if(!is_true(self.var_4b0fb2fb)) {
    self bgb_set_timer_clientfield(current / max, var_5f12e334);
  }
}

function run_timer(max) {
  self endon(#"disconnect");
  self notify(#"bgb_run_timer");
  self endon(#"bgb_run_timer");
  current = max;
  self.var_ec8a9710 = 1;

  while(current > 0) {
    self set_timer(current, max);
    waitframe(1);

    if(isDefined(self.var_76c47001)) {
      current = max * self.var_76c47001;
      self.var_76c47001 = undefined;
      continue;
    }

    if(!is_true(self.var_4b0fb2fb)) {
      current -= float(function_60d95f53()) / 1000;
    }
  }

  self notify(#"hash_347d2afccb8337ab");
  self clear_timer();
  self.var_ec8a9710 = undefined;
}

function clear_timer() {
  self bgb_set_timer_clientfield(0);
  self notify(#"bgb_run_timer");
}

function register(name, limit_type, limit, enable_func, disable_func, validation_func, activation_func) {
  assert(isDefined(name), "<dev string:x20f>");
  assert(#"none" != name, "<dev string:x238>" + # "none" + "<dev string:x25d>");
  assert(!isDefined(level.bgb[name]), "<dev string:x297>" + name + "<dev string:x2b1>");
  assert(isDefined(limit_type), "<dev string:x297>" + name + "<dev string:x2d2>");
  assert(isDefined(limit), "<dev string:x297>" + name + "<dev string:x2f3>");
  assert(!isDefined(enable_func) || isfunctionptr(enable_func), "<dev string:x297>" + name + "<dev string:x30f>");
  assert(!isDefined(disable_func) || isfunctionptr(disable_func), "<dev string:x297>" + name + "<dev string:x349>");

  switch (limit_type) {
    case # "activated":
      assert(!isDefined(validation_func) || isfunctionptr(validation_func), "<dev string:x297>" + name + "<dev string:x384>" + limit_type + "<dev string:x3d3>");
      assert(isDefined(activation_func), "<dev string:x297>" + name + "<dev string:x3d8>" + limit_type + "<dev string:x3d3>");
      assert(isfunctionptr(activation_func), "<dev string:x297>" + name + "<dev string:x40f>" + limit_type + "<dev string:x3d3>");
    case # "time":
    case # "rounds":
      assert(isint(limit), "<dev string:x297>" + name + "<dev string:x451>" + limit + "<dev string:x45f>" + limit_type + "<dev string:x3d3>");
      break;
    case # "event":
      assert(isfunctionptr(limit), "<dev string:x297>" + name + "<dev string:x484>" + limit_type + "<dev string:x3d3>");
      break;
    default:
      assert(0, "<dev string:x297>" + name + "<dev string:x1e6>" + limit_type + "<dev string:x1f9>");
      break;
  }

  level.bgb[name] = spawnStruct();
  level.bgb[name].name = name;
  level.bgb[name].limit_type = limit_type;
  level.bgb[name].limit = limit;
  level.bgb[name].enable_func = enable_func;
  level.bgb[name].disable_func = disable_func;
  level.bgb[name].validation_func = validation_func;

  if("activated" == limit_type) {
    level.bgb[name].activation_func = activation_func;
    level.bgb[name].var_57eb02e = 0;
  }

  level.bgb[name].ref_count = 0;
}

function register_actor_damage_override(name, actor_damage_override_func) {
  assert(isDefined(level.bgb[name]), "<dev string:x4bc>" + name + "<dev string:x4ec>");
  level.bgb[name].actor_damage_override_func = actor_damage_override_func;
}

function register_vehicle_damage_override(name, vehicle_damage_override_func) {
  assert(isDefined(level.bgb[name]), "<dev string:x506>" + name + "<dev string:x4ec>");
  level.bgb[name].vehicle_damage_override_func = vehicle_damage_override_func;
}

function register_actor_death_override(name, actor_death_override_func) {
  assert(isDefined(level.bgb[name]), "<dev string:x538>" + name + "<dev string:x4ec>");
  level.bgb[name].actor_death_override_func = actor_death_override_func;
}

function register_lost_perk_override(name, lost_perk_override_func, lost_perk_override_func_always_run) {
  assert(isDefined(level.bgb[name]), "<dev string:x567>" + name + "<dev string:x4ec>");
  level.bgb[name].lost_perk_override_func = lost_perk_override_func;
  level.bgb[name].lost_perk_override_func_always_run = lost_perk_override_func_always_run;
}

function function_c2721e81(name, add_to_player_score_override_func, add_to_player_score_override_func_always_run) {
  assert(isDefined(level.bgb[name]), "<dev string:x594>" + name + "<dev string:x4ec>");
  level.bgb[name].add_to_player_score_override_func = add_to_player_score_override_func;
  level.bgb[name].add_to_player_score_override_func_always_run = add_to_player_score_override_func_always_run;
}

function function_72469efe(name, var_50206ca3) {
  assert(isDefined(level.bgb[name]), "<dev string:x5cb>" + name + "<dev string:x4ec>");
  level.bgb[name].var_50206ca3 = var_50206ca3;
}

function function_8a5d8cfb(name, var_f1f46d6b) {
  assert(isDefined(level.bgb[name]), "<dev string:x604>" + name + "<dev string:x4ec>");
  level.bgb[name].var_f1f46d6b = var_f1f46d6b;
}

function function_be42abb0(name, var_f8d9ac8c) {
  assert(isDefined(level.bgb[name]), "<dev string:x637>" + name + "<dev string:x4ec>");
  level.bgb[name].var_f8d9ac8c = var_f8d9ac8c;
}

function function_afe7b8e7(name) {
  assert(isDefined(level.bgb[name]), "<dev string:x666>" + name + "<dev string:x4ec>");
  level.bgb[name].var_5a047886 = 1;
}

function function_e1f37ce7(name) {
  assert(isDefined(level.bgb[name]), "<dev string:x68c>" + name + "<dev string:x4ec>");
  level.bgb[name].var_4a9b0cdc = 1;
}

function function_1fee6b3(name, n_rank) {
  assert(isDefined(level.bgb[name]), "<dev string:x68c>" + name + "<dev string:x4ec>");
  assert(isDefined(n_rank), "<dev string:x6bf>" + name + "<dev string:x6e5>");
  level.bgb[name].var_a1750d43 = n_rank;
}

function give(name) {
  self thread take();

  if(#"none" == name) {
    return;
  }

  assert(isDefined(level.bgb[name]), "<dev string:x708>" + name + "<dev string:x4ec>");
  self notify(#"bgb_update", {
    #var_3aee8e4: name, #var_826ddd38: self.bgb
  });
  self notify("bgb_update_give_" + name);
  self.bgb = name;
  self clientfield::set_player_uimodel("zmhud.bgb_current", level.bgb[name].item_index);
  self luinotifyevent(#"zombie_bgb_notification", 1, level.bgb[name].item_index);
  self luinotifyeventtospectators(#"zombie_bgb_notification", 1, level.bgb[name].item_index);

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
  if(#"none" == self.bgb) {
    return;
  }

  self setactionslot(1, "");

  self thread bgb_set_debug_text(#"none");

  if(isDefined(level.bgb[self.bgb].disable_func)) {
    self thread[[level.bgb[self.bgb].disable_func]]();
  }

  self bgb_clear_monitors_and_clientfields();
  self notify(#"bgb_update", {
    #var_3aee8e4: # "none", #var_826ddd38: self.bgb
  });
  self notify("bgb_update_take_" + self.bgb);
  self.bgb = # "none";
}

function get_enabled() {
  if(isPlayer(self) && isDefined(self.bgb)) {
    return self.bgb;
  }

  return # "none";
}

function is_enabled(name) {
  if(!is_true(level.bgb_in_use)) {
    return false;
  }

  assert(isDefined(self.bgb), "<dev string:x71e>");

  if(!isDefined(self) || !isDefined(self.bgb)) {
    return false;
  }

  return self.bgb === name;
}

function any_enabled() {
  assert(isDefined(self.bgb));
  return self.bgb !== # "none";
}

function is_team_enabled(bgb_name) {
  foreach(player in getplayers()) {
    assert(isDefined(player.bgb));

    if(player.bgb === bgb_name) {
      return true;
    }
  }

  return false;
}

function get_player_dropped_powerup_origin() {
  powerup_origin = self.origin + vectorscale(anglesToForward((0, self getplayerangles()[1], 0)), 60) + (0, 0, 5);
  self zm_stats::increment_challenge_stat(#"gum_gobbler_powerups");
  return powerup_origin;
}

function function_c6cd71d5(str_powerup, v_origin, var_22a4c702 = self get_player_dropped_powerup_origin()) {
  e_powerup = zm_powerups::specific_powerup_drop(v_origin, var_22a4c702, undefined, 0.1, undefined, undefined, 1, 1, 1, 1);
  e_powerup.e_player_owner = self;

  if(isPlayer(self)) {
    self zm_stats::increment_challenge_stat(#"hash_3ebae93ea866519c");
  }
}

function function_9d8118f5(v_origin) {
  if(!self isonground() && !self isplayerswimming()) {
    return 0;
  }

  if(!isDefined(v_origin)) {
    v_origin = self get_player_dropped_powerup_origin();
  }

  var_116b3a00 = 1;
  var_806b07bd = util::spawn_model("tag_origin", v_origin + (0, 0, 40));
  v_origin = var_806b07bd.origin;

  if(isDefined(var_806b07bd) && !var_806b07bd zm_player::in_enabled_playable_area(96) && !var_806b07bd zm_player::in_life_brush()) {
    var_116b3a00 = 0;
  }

  if(self zm_utility::function_ab9a9770() || var_806b07bd zm_utility::function_ab9a9770()) {
    var_116b3a00 = 0;
  }

  v_close = getclosestpointonnavmesh(v_origin, 128, 24);

  if(var_116b3a00 && (!isDefined(v_close) || v_close[2] - v_origin[2] > 40 / 4) && !self isplayerswimming()) {
    var_116b3a00 = 0;
  }

  if(var_116b3a00 && !is_true(bullettracepassed(self getEye(), v_origin, 0, self, undefined, 0, 1))) {
    var_116b3a00 = 0;
  }

  if(isDefined(var_806b07bd)) {
    var_806b07bd delete();
  }

  return var_116b3a00;
}

function actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(isPlayer(attacker)) {
    name = attacker get_enabled();

    if(name !== # "none" && isDefined(level.bgb[name]) && isDefined(level.bgb[name].actor_damage_override_func)) {
      damage = [[level.bgb[name].actor_damage_override_func]](inflictor, attacker, damage, flags, meansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
    }
  }

  return damage;
}

function vehicle_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(!is_true(level.bgb_in_use)) {
    return idamage;
  }

  if(isPlayer(eattacker)) {
    name = eattacker get_enabled();

    if(name !== # "none" && isDefined(level.bgb[name]) && isDefined(level.bgb[name].vehicle_damage_override_func)) {
      idamage = [[level.bgb[name].vehicle_damage_override_func]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
    }
  }

  return idamage;
}

function actor_death_override(attacker) {
  if(!is_true(level.bgb_in_use)) {
    return 0;
  }

  if(isPlayer(attacker)) {
    name = attacker get_enabled();

    if(name !== # "none" && isDefined(level.bgb[name]) && isDefined(level.bgb[name].actor_death_override_func)) {
      damage = [[level.bgb[name].actor_death_override_func]](attacker);
    }
  }

  return damage;
}

function lost_perk_override(perk) {
  b_result = 0;

  if(!is_true(level.bgb_in_use)) {
    return b_result;
  }

  keys = getarraykeys(level.bgb);

  for(i = 0; i < keys.size; i++) {
    name = keys[i];

    if(is_true(level.bgb[name].lost_perk_override_func_always_run) && isDefined(level.bgb[name].lost_perk_override_func)) {
      b_result = [[level.bgb[name].lost_perk_override_func]](perk, self, undefined);

      if(b_result) {
        return b_result;
      }
    }
  }

  foreach(player in function_a1ef346b()) {
    name = player get_enabled();

    if(name !== # "none" && isDefined(level.bgb[name]) && isDefined(level.bgb[name].lost_perk_override_func)) {
      b_result = [[level.bgb[name].lost_perk_override_func]](perk, self, player);

      if(b_result) {
        return b_result;
      }
    }
  }

  return b_result;
}

function add_to_player_score_override(n_points, str_awarded_by) {
  if(!is_true(level.bgb_in_use)) {
    return n_points;
  }

  str_enabled = self get_enabled();
  keys = getarraykeys(level.bgb);

  for(i = 0; i < keys.size; i++) {
    str_bgb = keys[i];

    if(str_bgb === str_enabled) {
      continue;
    }

    if(is_true(level.bgb[str_bgb].add_to_player_score_override_func_always_run) && isDefined(level.bgb[str_bgb].add_to_player_score_override_func)) {
      n_points = [[level.bgb[str_bgb].add_to_player_score_override_func]](n_points, str_awarded_by, 0);
    }
  }

  if(str_enabled !== # "none" && isDefined(level.bgb[str_enabled]) && isDefined(level.bgb[str_enabled].add_to_player_score_override_func)) {
    n_points = [[level.bgb[str_enabled].add_to_player_score_override_func]](n_points, str_awarded_by, 1);
  }

  return n_points;
}

function function_3fa57f3f() {
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

function function_f51e3503(n_max_distance, var_5250f4f6, var_8bc18989) {
  self endon(#"disconnect", #"bled_out", #"bgb_update");
  self.var_9c42f3fe = [];

  while(true) {
    foreach(e_player in level.players) {
      if(e_player == self) {
        continue;
      }

      arrayremovevalue(self.var_9c42f3fe, undefined);
      var_fd14be26 = array::contains(self.var_9c42f3fe, e_player);
      var_d9cac58e = zm_utility::is_player_valid(e_player, 0, 1) && function_b70b2809(n_max_distance, self, e_player);

      if(!var_fd14be26 && var_d9cac58e) {
        array::add(self.var_9c42f3fe, e_player, 0);

        if(isDefined(var_5250f4f6)) {
          self thread[[var_5250f4f6]](e_player);
        }

        continue;
      }

      if(var_fd14be26 && !var_d9cac58e) {
        arrayremovevalue(self.var_9c42f3fe, e_player);

        if(isDefined(var_8bc18989)) {
          self thread[[var_8bc18989]](e_player);
        }
      }
    }

    waitframe(1);
  }
}

function private function_b70b2809(n_distance, var_7b235bec, var_f8084a8) {
  var_8c1c6c8d = n_distance * n_distance;
  var_a91ae6d4 = distancesquared(var_7b235bec.origin, var_f8084a8.origin);

  if(var_a91ae6d4 <= var_8c1c6c8d) {
    return true;
  }

  return false;
}

function function_b57e693f() {
  self clientfield::increment_uimodel("zmhud.bgb_invalid_use");
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

function function_303bde69() {
  self flag::wait_till("bgb_weapon_cycling");
}

function function_bd839f2c(e_reviver, var_84280a99) {
  if(is_true(self.var_bdeb0f02) || isDefined(e_reviver) && isDefined(self.bgb) && self is_enabled(#"zm_bgb_near_death_experience") || isDefined(e_reviver) && isDefined(e_reviver.bgb) && e_reviver is_enabled(#"zm_bgb_near_death_experience") || isDefined(e_reviver) && isDefined(self.bgb) && self is_enabled(#"zm_bgb_phoenix_up") || isDefined(e_reviver) && isDefined(e_reviver.bgb) && e_reviver is_enabled(#"zm_bgb_phoenix_up") || isDefined(var_84280a99)) {
    return true;
  }

  return false;
}

function bgb_revive_watcher() {
  self endon(#"death");
  self.var_bdeb0f02 = 1;
  waitresult = self waittill(#"player_revived");
  e_reviver = waitresult.reviver;
  waitframe(1);

  if(is_true(self.var_bdeb0f02)) {
    self notify(#"bgb_revive");
    self.var_bdeb0f02 = undefined;
  }
}

function function_69b88b5() {
  if(!is_true(self.ready_for_score_events)) {
    return false;
  }

  return true;
}
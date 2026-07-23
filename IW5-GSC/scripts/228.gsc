/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\228.gsc
**************************************/

main() {
  if(isDefined(level.laststand_initialized)) {
    return;
  }
  level.laststand_initialized = 1;
  common_scripts\utility::flag_init("laststand_on");

  foreach(var_1 in level.players) {
    var_1 maps\_utility::ent_flag_init("laststand_downed");
    var_1 maps\_utility::ent_flag_init("laststand_pause_bleedout_timer");
    var_1 maps\_utility::ent_flag_init("laststand_proc_running");
    var_1.laststand_info = spawnStruct();
    var_1.laststand_info.type_getup_lives = 0;
  }

  precachestring(&"SCRIPT_COOP_BLEEDING_OUT_PARTNER");
  precachestring(&"SCRIPT_COOP_BLEEDING_OUT");
  precachestring(&"SCRIPT_COOP_REVIVING_PARTNER");
  precachestring(&"SCRIPT_COOP_REVIVING");
  precachestring(&"SCRIPT_COOP_REVIVE");
  precacheshellshock("laststand_getup");
  precacheitem("fnfiveseven");
  common_scripts\utility::flag_set("laststand_on");
  level.revive_hud_base_offset = 75;

  if(!issplitscreen()) {
    level.revive_hud_base_offset = 120;
  }
  level.revive_bar_offset = 15;
  level.revive_bar_getup_offset = 30;
  level.laststand_hud_elements = [];
  thread laststand_on_load_finished();
}

laststand_on_load_finished() {
  level waittill("load_finished");

  if(laststand_get_type() == 2) {
    precacheshader("specialty_self_revive");
  }
  thread laststand_global_spawn_funcs();

  if(common_scripts\utility::flag_exist("slamzoom_finished") && !common_scripts\utility::flag("slamzoom_finished")) {
    common_scripts\utility::flag_wait("slamzoom_finished");
  }
  thread laststand_notify_on_player_state_changes("laststand_player_state_changed");
  thread laststand_downed_player_manager();
  thread laststand_coop_hud_manager();
  thread laststand_getup_hud_init();
  thread laststand_on_mission_end();
}

laststand_global_spawn_funcs() {
  if(laststand_get_type() == 2) {
    maps\_utility::add_global_spawn_function("axis", ::ai_laststand_on_death);
  }
}

player_laststand_proc() {
  if(!maps\_utility::laststand_enabled()) {
    return;
  }
  if(maps\_utility::ent_flag("laststand_proc_running")) {
    return;
  }
  if(!isDefined(self.original_maxhealth)) {
    self.original_maxhealth = self.maxhealth;
  }
  if(!common_scripts\utility::flag("laststand_on")) {
    return;
  }
  level endon("laststand_on");
  thread player_laststand_proc_ended();

  switch (level.gameskill) {
    case 1:
    case 0:
      self.laststand_info.bleedout_time_default = 120;
      level.laststand_stage2_multiplier = 0.5;
      level.laststand_stage3_multiplier = 0.25;
      break;
    case 2:
      self.laststand_info.bleedout_time_default = 90;
      level.laststand_stage2_multiplier = 0.66;
      level.laststand_stage3_multiplier = 0.33;
      break;
    case 3:
      self.laststand_info.bleedout_time_default = 60;
      level.laststand_stage2_multiplier = 0.5;
      level.laststand_stage3_multiplier = 0.25;
      break;
  }

  maps\_utility::ent_flag_set("laststand_proc_running");
  self enabledeathshield(1);
  maps\_utility::ent_flag_clear("laststand_downed");
  maps\_utility::ent_flag_clear("laststand_pause_bleedout_timer");
  self endon("death");
  var_0 = self.unique_id;

  for(;;) {
    self waittill("deathshield", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(isDefined(self.saved_by_armor) && self.saved_by_armor) {
      continue;
    }
    if(maps\_utility::ent_flag("laststand_downed")) {
      continue;
    }
    if(isDefined(self.laststand_revive_time) && gettime() - self.laststand_revive_time <= 1750.0) {
      continue;
    }
    var_11 = [];
    var_11["damage"] = var_1;
    var_11["player"] = self;

    if(maps\_utility::is_coop() && laststand_downing_will_fail()) {
      var_12 = maps\_utility::get_other_player(self);

      if(var_12 maps\_utility::ent_flag("laststand_downed")) {
        self.coop_death_reason = [];
        self.coop_death_reason["attacker"] = var_2;
        self.coop_death_reason["cause"] = var_5;
        self.coop_death_reason["weapon_name"] = var_10;
      }
    }

    if(!maps\_utility::is_coop()) {
      self.coop_death_reason = [];
      self.coop_death_reason["attacker"] = var_2;
      self.coop_death_reason["cause"] = var_5;
      self.coop_death_reason["weapon_name"] = var_10;
    }

    level.down_player_requests[self.unique_id] = var_11;
    try_crush_player(var_2, var_5);
    level notify("request_player_downed");
  }
}

player_laststand_proc_ended() {
  self endon("death");
  common_scripts\utility::flag_waitopen("laststand_on");
  maps\_utility::ent_flag_clear("laststand_proc_running");
  self enabledeathshield(0);
}

laststand_downed_player_manager() {
  if(maps\_utility::is_coop()) {
    thread laststand_revive_ents_manager();
  }
  level.laststand_recent_player_downed_time = 0;

  for(;;) {
    level.down_player_requests = [];
    level waittill("request_player_downed");
    waittillframeend;
    var_0 = gettime();

    if(var_0 < level.laststand_recent_player_downed_time + level.player_downed_death_buffer_time * 1000) {
      continue;
    }
    level.laststand_recent_player_downed_time = var_0;
    var_1 = 0;
    var_2 = undefined;
    level.down_player_requests = maps\_utility::array_randomize(level.down_player_requests);

    foreach(var_5, var_4 in level.down_player_requests) {
      if(var_4["damage"] >= var_1) {
        var_2 = var_4["player"];
      }
    }

    var_2 thread player_laststand_force_down();
    thread maps\_gameskill::resetskill();
  }
}

laststand_revive_ents_manager() {
  if(!maps\_utility::is_coop()) {
    return;
  }
  level.default_use_radius = getdvarint("player_useradius");
  level endon("special_op_terminated");
  level.revive_ents = [];

  foreach(var_1 in level.players) {
    var_2 = spawn("script_model", var_1.origin + (0, 0, 28));
    var_2 setModel("tag_origin");
    var_2 linkTo(var_1, "tag_origin", (0, 0, 28), (0, 0, 0));
    var_2 setHintString(&"SCRIPT_COOP_REVIVE");
    level.revive_ents[var_1.unique_id] = var_2;
    var_1 thread player_laststand_on_revive();
  }

  for(;;) {
    level waittill("laststand_player_state_changed");

    foreach(var_1 in level.players) {}
    var_1 revive_set_use_target_state(maps\_utility::is_player_down(var_1));

    if(maps\_utility::get_players_healthy().size == level.players.size) {
      setsaveddvar("player_useradius", level.default_use_radius);
      continue;
    }

    setsaveddvar("player_useradius", 128);
  }
}

laststand_notify_on_player_state_changes(var_0) {
  level endon("special_op_terminated");

  foreach(var_2 in level.players) {}
  var_2 endon("death");

  for(;;) {
    foreach(var_2 in level.players) {}
    var_2 thread notify_on_ent_flag_change("laststand_downed", var_0);

    level waittill(var_0);
  }
}

notify_on_ent_flag_change(var_0, var_1) {
  level endon("special_op_terminated");
  level endon(var_1);
  self endon("death");

  if(maps\_utility::ent_flag(var_0)) {
    maps\_utility::ent_flag_waitopen(var_0);
  } else {
    maps\_utility::ent_flag_wait(var_0);
  }
  level notify(var_1);
}

player_laststand_force_down() {
  if(!isalive(self)) {
    return;
  }
  level endon("special_op_terminated");
  self endon("death");
  player_laststand_set_down_attributes();

  if(maps\_utility::is_coop()) {
    thread player_laststand_downed_dialogue();
    thread player_laststand_on_downed_hud_update();
    thread player_laststand_downed_icon();
  }

  maps\_utility::add_wait(maps\_utility::ent_flag_waitopen, "laststand_downed");
  maps\_utility::add_wait(maps\_utility::waittill_msg, "coop_bled_out");
  maps\_utility::do_wait_any();
  self notify("end_func_player_laststand_downed_icon");

  if(maps\_utility::ent_flag("laststand_downed")) {
    player_laststand_kill();
  } else {
    player_laststand_set_original_attributes();
  }
}

player_laststand_on_revive() {
  self endon("death");
  level endon("special_op_terminated");
  var_0 = player_get_revive_ent();
  var_1 = 0;

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(maps\_utility::is_player_down(var_2)) {
      continue;
    }
    self.laststand_savior = var_2;

    if(maps\_utility::is_player_down(self) && var_2 player_laststand_is_reviving(self)) {
      laststand_freeze_players(1, var_2, self);
      level.laststand_recent_player_downed_time = 0;
      wait 0.1;

      if(!maps\_utility::is_player_down(self) || !var_2 player_laststand_is_reviving(self)) {
        var_2 player_laststand_revive_buddy_cleanup(self);
        continue;
      }

      level.bars = [];
      level.bars["p1"] = maps\_hud_util::createclientprogressbar(level.player, level.revive_hud_base_offset + level.revive_bar_offset);
      level.bars["p2"] = maps\_hud_util::createclientprogressbar(level.player2, level.revive_hud_base_offset + level.revive_bar_offset);
      var_3 = randomfloat(1) > 0.33;

      if(var_3) {
        var_2 notify("so_reviving");
      }
      var_1 = 0;
      var_4 = 1.5;

      while(maps\_utility::is_player_down(self) && !maps\_utility::is_player_down(var_2) && var_2 player_laststand_is_reviving(self)) {
        maps\_utility::ent_flag_set("laststand_pause_bleedout_timer");

        foreach(var_6 in level.bars) {}
        var_6 maps\_hud_util::updatebar(var_1 / var_4);

        wait 0.05;
        var_1 = var_1 + 0.05;

        if(maps\_utility::is_player_down(self) && var_1 > var_4) {
          if(!var_3) {
            var_2 notify("so_revived");
          }
          var_2 notify("so_revive_success");
          player_laststand_revive_self();
          break;
        }
      }

      var_2 player_laststand_revive_buddy_cleanup(self);
    }
  }
}

player_laststand_is_reviving(var_0) {
  if(!self useButtonPressed()) {
    return 0;
  }
  if(isDefined(var_0.laststand_savior) && var_0.laststand_savior == self) {
    return 1;
  }
  return 0;
}

player_laststand_revive_self() {
  self.laststand_revive_time = gettime();
  player_dying_effect_remove();
  maps\_utility::ent_flag_clear("laststand_downed");
  self.coop_death_reason = undefined;
  thread maps\_gameskill::resetskill();
  self notify("revived");
}

player_laststand_revive_buddy_cleanup(var_0) {
  level notify("revive_bars_killed");
  revive_hud_cleanup_bars();

  if(isDefined(var_0) && isalive(var_0)) {
    var_0.laststand_savior = undefined;
    var_0 maps\_utility::ent_flag_clear("laststand_pause_bleedout_timer");
  }

  if(isDefined(self) && isalive(self)) {
    laststand_freeze_players(0, self, var_0);
  }
}

laststand_freeze_players(var_0, var_1, var_2) {
  var_2 = maps\_utility::get_other_player(self);

  if(var_0) {
    var_1 freezecontrols(1);
    var_1 disableweapons();
    var_1 disableweaponswitch();
    var_2 freezecontrols(1);
    var_2 disableweapons();
  } else {
    var_1 freezecontrols(0);
    var_1 enableweapons();
    var_1 enableweaponswitch();
    var_2 freezecontrols(0);

    if(!maps\_utility::is_player_down_and_out(var_2)) {
      var_2 enableweapons();
    }
  }
}

player_laststand_downed_dialogue() {
  self endon("death");
  self endon("revived");
  level endon("special_op_terminated");
  wait 1.0;
  self notify("so_downed");
  thread player_laststand_downed_nag_button(0.05);
}

player_laststand_downed_nag_button(var_0) {
  self endon("death");
  self endon("revived");
  level endon("special_op_terminated");

  if(isDefined(var_0) && var_0 > 0) {
    wait(var_0);
  }
  self notifyonplayercommand("nag", "weapnext");

  for(;;) {
    if(!can_show_nag_prompt()) {
      wait 0.05;
      continue;
    }

    if(nag_should_draw_hud()) {
      thread nag_prompt_show();
      thread nag_prompt_cancel();
    }

    var_1 = common_scripts\utility::waittill_any_timeout(level.coop_revive_nag_hud_refreshtime, "nag", "nag_cancel");

    if(var_1 == "nag") {
      self.lastrevivenagbuttonpresstime = gettime();
      thread player_downed_hud_toggle_blinkstate();
      thread maps\_specialops_battlechatter::play_revive_nag();
    }

    wait 0.05;
  }
}

nag_should_draw_hud() {
  var_0 = level.coop_revive_nag_hud_refreshtime * 1000;

  if(isDefined(self) && isDefined(self.nag_hud_on)) {
    return 0;
  } else if(!isDefined(self.lastrevivenagbuttonpresstime)) {
    return 1;
  } else if(gettime() - self.lastrevivenagbuttonpresstime < var_0) {
    return 0;
  }
  return 1;
}

nag_prompt_show() {
  if(!isDefined(self)) {
    return;
  }
  self.nag_hud_on = 1;
  var_0 = 0.05;
  var_1 = &"SPECIAL_OPS_REVIVE_NAG_HINT";
  var_2 = get_nag_hud();
  var_2.alpha = 0;
  var_2 settext(var_1);
  var_2 fadeovertime(var_0);
  var_2.alpha = 1;
  waittill_disable_nag();
  self.nag_hud_on = undefined;
  var_2 fadeovertime(var_0);
  var_2.alpha = 0;
  var_2 common_scripts\utility::delaycall(var_0 + 0.05, ::destroy);
}

get_nag_hud() {
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 50;
  var_0.alignx = "center";
  var_0.aligny = "middle";
  var_0.horzalign = "center";
  var_0.vertalign = "middle";
  var_0.fontscale = 1;
  var_0.color = (1, 1, 1);
  var_0.font = "hudsmall";
  var_0.glowcolor = (0.3, 0.6, 0.3);
  var_0.glowalpha = 0;
  var_0.foreground = 1;
  var_0.hidewheninmenu = 1;
  var_0.hidewhendead = 1;
  return var_0;
}

nag_prompt_cancel() {
  self endon("nag");

  while(maps\_utility::is_player_down(self) && can_show_nag_prompt()) {
    wait 0.05;
  }
  self notify("nag_cancel");
}

can_show_nag_prompt() {
  if(isDefined(level.hide_nag_prompt) && level.hide_nag_prompt) {
    return 0;
  }
  var_0 = maps\_utility::get_other_player(self);

  if(var_0 player_laststand_is_reviving(self)) {
    return 0;
  }
  if(!maps\_specialops_battlechatter::can_say_current_nag_event_type()) {
    return 0;
  }
  return 1;
}

laststand_coop_hud_manager() {
  if(!maps\_utility::is_coop()) {
    return;
  }
  level endon("special_op_terminated");
  var_0 = [];

  foreach(var_2 in level.players) {}
  var_0[var_2.unique_id] = maps\_utility::is_player_down(var_2);

  laststand_coop_hud_create();

  for(;;) {
    level waittill("laststand_player_state_changed");
    waittillframeend;

    foreach(var_2 in level.players) {
      var_5 = maps\_utility::get_other_player(var_2);
      var_6 = var_2 player_laststand_changed_state(var_0);
      var_7 = var_5 player_laststand_changed_state(var_0);

      if(var_6) {
        if(maps\_utility::is_player_down(var_2)) {
          var_2.revive_text_friend.alpha = 0;
          var_2.revive_timer_friend.alpha = 0;
          var_2.revive_text_local thread maps\_specialops::so_hud_pulse_stop();
          var_2.revive_timer_local thread maps\_specialops::so_hud_pulse_stop();
          var_2.revive_text_local.alpha = 1;
          var_2.revive_timer_local.alpha = 1;
          var_2.revive_text_local thread maps\_specialops::so_hud_pulse_create();
          var_2.revive_timer_local thread maps\_specialops::so_hud_pulse_create();
        } else if(maps\_utility::is_player_down(var_5)) {
          var_2.revive_text_local.alpha = 0;
          var_2.revive_timer_local.alpha = 0;
          var_2.revive_text_friend thread maps\_specialops::so_hud_pulse_stop();
          var_2.revive_timer_friend thread maps\_specialops::so_hud_pulse_stop();
          var_2.revive_text_friend.alpha = 1;
          var_2.revive_timer_friend.alpha = 1;
          var_2.revive_text_friend thread maps\_specialops::so_hud_pulse_create();
          var_2.revive_timer_friend thread maps\_specialops::so_hud_pulse_create();
        } else {
          var_2 player_laststand_hud_hide();
        }
      }

      if(var_7) {
        if(!maps\_utility::is_player_down(var_2)) {
          if(maps\_utility::is_player_down(var_5)) {
            var_2.revive_text_local.alpha = 0;
            var_2.revive_timer_local.alpha = 0;
            var_2.revive_text_friend thread maps\_specialops::so_hud_pulse_stop();
            var_2.revive_timer_friend thread maps\_specialops::so_hud_pulse_stop();
            var_2.revive_text_friend.alpha = 1;
            var_2.revive_timer_friend.alpha = 1;
            var_2.revive_text_friend thread maps\_specialops::so_hud_pulse_create();
            var_2.revive_timer_friend thread maps\_specialops::so_hud_pulse_create();
            continue;
          }

          var_2 player_laststand_hud_hide();
        }
      }
    }

    foreach(var_2 in level.players) {}
    var_0[var_2.unique_id] = maps\_utility::is_player_down(var_2);
  }
}

laststand_coop_hud_create() {
  foreach(var_1 in level.players) {
    var_1.revive_text_local = var_1 maps\_hud_util::createserverclientfontstring("hudsmall", 1.0);
    var_1.revive_text_local maps\_hud_util::setpoint("CENTER", undefined, 0, level.revive_hud_base_offset);
    var_1.revive_text_local settext(&"SCRIPT_COOP_BLEEDING_OUT");
    var_1.revive_text_friend = var_1 maps\_hud_util::createserverclientfontstring("hudsmall", 1.0);
    var_1.revive_text_friend maps\_hud_util::setpoint("CENTER", undefined, 0, level.revive_hud_base_offset);
    var_1.revive_text_friend settext(&"SCRIPT_COOP_BLEEDING_OUT_PARTNER");
    var_1.revive_timer_local = var_1 maps\_hud_util::createclienttimer("hudsmall", 1.2);
    var_1.revive_timer_local maps\_hud_util::setpoint("CENTER", undefined, 0, level.revive_hud_base_offset + level.revive_bar_offset);
    var_1.revive_timer_friend = var_1 maps\_hud_util::createclienttimer("hudsmall", 1.2);
    var_1.revive_timer_friend maps\_hud_util::setpoint("CENTER", undefined, 0, level.revive_hud_base_offset + level.revive_bar_offset);
    var_1 player_laststand_hud_hide();
    level.laststand_hud_elements[level.laststand_hud_elements.size] = var_1.revive_text_local;
    level.laststand_hud_elements[level.laststand_hud_elements.size] = var_1.revive_text_friend;
    level.laststand_hud_elements[level.laststand_hud_elements.size] = var_1.revive_timer_local;
    level.laststand_hud_elements[level.laststand_hud_elements.size] = var_1.revive_timer_friend;
  }
}

player_laststand_hud_hide() {
  self.revive_text_local.alpha = 0;
  self.revive_text_friend.alpha = 0;
  self.revive_timer_local.alpha = 0;
  self.revive_timer_friend.alpha = 0;
}

player_laststand_changed_state(var_0) {
  var_1 = maps\_utility::is_player_down(self);
  var_2 = var_0[self.unique_id];
  return var_1 != var_2;
}

laststand_getup_hud_init() {
  if(laststand_get_type() != 2) {
    return;
  }
  foreach(var_1 in level.players) {}
  var_1.laststand_getup_fast = 0;

  laststand_revive_bar_getup_create();
}

laststand_revive_bar_getup_create() {
  foreach(var_1 in level.players) {
    var_2 = level.revive_hud_base_offset + level.revive_bar_getup_offset;
    var_1.revive_bar_getup = maps\_hud_util::createclientprogressbar(var_1, var_2, "white", "black", 130, 12);
    var_1 player_laststand_getup_bar_set_fill(0.5);
    level.laststand_hud_elements[level.laststand_hud_elements.size] = var_1.revive_bar_getup;
    var_1.revive_bar_getup_icon = newclienthudelem(var_1);
    var_1.revive_bar_getup_icon.hidden = 0;
    var_1.revive_bar_getup_icon.elemtype = "icon";
    var_1.revive_bar_getup_icon.hidewheninmenu = 1;
    var_1.revive_bar_getup_icon.archived = 0;
    var_1.revive_bar_getup_icon.x = -93.0;
    var_1.revive_bar_getup_icon.y = var_2;
    var_1.revive_bar_getup_icon.alignx = "center";
    var_1.revive_bar_getup_icon.aligny = "middle";
    var_1.revive_bar_getup_icon.horzalign = "center";
    var_1.revive_bar_getup_icon.vertalign = "middle";
    var_1.revive_bar_getup_icon.children = [];
    var_1.revive_bar_getup_icon.elemtype = "icon";
    var_1.revive_bar_getup_icon setshader("specialty_self_revive", 28, 28);
    level.laststand_hud_elements[level.laststand_hud_elements.size] = var_1.revive_bar_getup_icon;
    var_1.revive_bar_getup maps\_hud_util::hidebar(1);
    var_1.revive_bar_getup_icon.alpha = 0.0;
  }
}

player_laststand_on_downed_hud_update() {
  self endon("end_func_player_laststand_downed_icon");
  self endon("death");
  self endon("revived");
  level endon("special_op_terminated");

  foreach(var_1 in level.players) {
    if(var_1 == self) {
      var_1.revive_timer_local settimer(self.laststand_info.bleedout_time_default - 1);
      continue;
    }

    var_1.revive_timer_friend settimer(self.laststand_info.bleedout_time_default - 1);
  }

  thread player_laststand_countdown_timer(self.laststand_info.bleedout_time_default);
  var_3 = self.laststand_info.bleedout_time_default;

  foreach(var_1 in level.players) {
    if(var_1 == self) {
      var_1.revive_text_local.color = self.revive_text_local.color;
      var_1.revive_timer_local.color = self.revive_text_local.color;
      continue;
    }

    var_1.revive_text_friend.color = var_1.revive_text_local.color;
    var_1.revive_timer_friend.color = var_1.revive_text_local.color;
  }

  waittillframeend;

  while(var_3) {
    foreach(var_1 in level.players) {
      if(var_1 == self) {
        var_7 = var_1.revive_text_local;
        var_8 = var_1.revive_timer_local;
      } else {
        var_7 = var_1.revive_text_friend;
        var_8 = var_1.revive_timer_friend;
      }

      var_9 = var_7.color;
      var_10 = get_coop_downed_hud_color(self.laststand_info.bleedout_time, self.laststand_info.bleedout_time_default, 0, var_1 == self);
      var_7.color = var_10;
      var_8.color = var_10;

      if(distance(var_10, var_9) > 0.001) {
        if(distance(var_10, var_1.coop_icon_color_dying) <= 0.001) {
          var_7.pulse_loop = 1;
          var_8.pulse_loop = 1;
        }

        var_7 thread maps\_specialops::so_hud_pulse_create();
        var_8 thread maps\_specialops::so_hud_pulse_create();
      }
    }

    wait 1.0;
    var_3 = var_3 - 1.0;
  }
}

player_laststand_downed_icon() {
  self endon("end_func_player_laststand_downed_icon");
  self endon("death");
  self endon("revived");
  level endon("special_op_terminated");
  waittillframeend;
  var_0 = maps\_utility::get_other_player(self);
  var_0 maps\_coop::friendlyhudicon_downed();

  while(self.laststand_info.bleedout_time > 0) {
    maps\_utility::ent_flag_waitopen("laststand_pause_bleedout_timer");
    var_0 maps\_coop::friendlyhudicon_update(get_coop_downed_hud_color(self.laststand_info.bleedout_time, self.laststand_info.bleedout_time_default));
    wait 0.05;
  }
}

player_laststand_countdown_timer(var_0) {
  self endon("death");
  self endon("revived");
  level endon("special_op_terminated");

  for(self.laststand_info.bleedout_time = var_0; self.laststand_info.bleedout_time > 0; self.laststand_info.bleedout_time = self.laststand_info.bleedout_time - 0.05) {
    if(maps\_utility::ent_flag("laststand_pause_bleedout_timer")) {
      foreach(var_2 in level.players) {
        if(var_2 == self) {
          var_2.revive_timer_local.alpha = 0;
          continue;
        }

        var_2.revive_timer_friend.alpha = 0;
      }

      maps\_utility::ent_flag_waitopen("laststand_pause_bleedout_timer");

      if(self.laststand_info.bleedout_time >= 1) {
        foreach(var_2 in level.players) {
          if(var_2 == self) {
            var_2.revive_timer_local settimer(self.laststand_info.bleedout_time - 1);
            continue;
          }

          var_2.revive_timer_friend settimer(self.laststand_info.bleedout_time - 1);
        }
      }
    } else {
      foreach(var_2 in level.players) {
        if(var_2 == self) {
          var_2.revive_timer_local.alpha = 1;
          continue;
        }

        if(!maps\_utility::is_player_down(var_2)) {
          var_2.revive_timer_friend.alpha = 1;
        }
      }
    }

    wait 0.05;
  }

  self.laststand_info.bleedout_time = 0;
  maps\_specialops::so_force_deadquote("@DEADQUOTE_SO_BLED_OUT", "ui_bled_out");
  thread maps\_specialops::so_dialog_mission_failed_bleedout();
  self notify("coop_bled_out");
}

get_coop_downed_hud_color(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3) && var_3) {
    var_4 = self;
  } else {
    var_4 = maps\_utility::get_other_player(self);
  }
  if(!isDefined(var_2)) {
    var_2 = 1;
  }
  if(var_2 && coop_downed_hud_should_blink()) {
    if(self.blinkstate == 1) {
      return var_4.coop_icon_color_blink;
    }
  }

  if(var_0 < var_1 * level.laststand_stage3_multiplier) {
    return var_4.coop_icon_color_dying;
  }
  if(var_0 < var_1 * level.laststand_stage2_multiplier) {
    return var_4.coop_icon_color_damage;
  }
  return var_4.coop_icon_color_downed;
}

coop_downed_hud_should_blink() {
  var_0 = maps\_utility::get_other_player(self);

  if(var_0 player_laststand_is_reviving(self)) {
    return 0;
  }
  if(isDefined(self.lastrevivenagbuttonpresstime)) {
    if(gettime() - self.lastrevivenagbuttonpresstime < level.coop_icon_blinktime * 1000) {
      return 1;
    }
  }

  return 0;
}

laststand_hud_destroy() {
  if(isDefined(level.laststand_hud_elements)) {
    foreach(var_1 in level.laststand_hud_elements) {
      if(isDefined(var_1)) {
        var_1 notify("destroying");
        var_1 maps\_hud_util::destroyelem();
      }
    }
  }

  level.laststand_hud_elements = undefined;
}

player_laststand_set_down_attributes() {
  self endon("death");
  self notify("player_downed");
  self.ignorerandombulletdamage = 1;
  self enableinvulnerability();
  maps\_utility::ent_flag_set("laststand_downed");
  self.laststand = 1;
  self.health = 2;
  self.maxhealth = self.original_maxhealth;
  self.ignoreme = 1;
  self disableusability();
  self disableweaponswitch();
  self disableoffhandweapons();
  self disableweapons();

  if(!isDefined(self.laststand_down_count)) {
    self.laststand_down_count = 1;
  } else {
    self.laststand_down_count++;
  }
  if(isDefined(self.placingsentry)) {
    self notify("sentry_placement_canceled");
  }
  thread player_laststand_kill_by_vehicle();

  if(laststand_downing_will_fail()) {
    player_laststand_kill();
  } else {
    thread player_laststand_set_down_part1();
  }
}

player_laststand_set_original_attributes() {
  self.ignorerandombulletdamage = 0;
  maps\_utility::ent_flag_clear("laststand_downed");
  self.laststand = 0;
  self.achieve_downed_kills = undefined;
  self.down_part2_proc_ran = undefined;

  if(maps\_utility::is_coop()) {
    var_0 = maps\_utility::get_other_player(self);
    var_0 maps\_coop::friendlyhudicon_normal();
  }

  self disableweapons();
  remove_pistol_if_extra();
  self.health = self.maxhealth;
  self.ignoreme = 0;
  self setstance("stand");
  self enableusability();
  self enableoffhandweapons();
  self enableweaponswitch();
  self enableweapons();
  self notify("not_in_last_stand");
  wait 1.0;
  self disableinvulnerability();
}

remove_pistol_if_extra() {
  if(isDefined(self.forced_pistol)) {
    self takeweapon(self.forced_pistol);
    self.forced_pistol = undefined;
  }

  if(isDefined(self.preincap_pistol)) {
    self setweaponammoclip(self.preincap_pistol, self.preincap_pistol_clip);
    self setweaponammostock(self.preincap_pistol, self.preincap_pistol_stock);
  }

  if(player_can_restore_weapon(self.preincap_weapon)) {
    self switchtoweapon(self.preincap_weapon);
  } else {
    var_0 = self getweaponslistprimaries();
    self switchtoweapon(var_0[0]);
  }

  self.preincap_weapon = undefined;
}

player_laststand_kill_by_vehicle() {
  self endon("revived");
  self endon("death");
  level endon("special_op_terminated");

  if(common_scripts\utility::flag("special_op_terminated")) {
    return;
  }
  if(!isalive(self)) {
    return;
  }
  for(;;) {
    var_0 = vehicle_getarray();

    foreach(var_2 in var_0) {
      if(isDefined(var_2.dont_crush_player) && var_2.dont_crush_player) {
        continue;
      }
      var_3 = var_2 vehicle_getspeed();

      if(abs(var_3) == 0) {
        continue;
      }
      if(self istouching(var_2)) {
        var_2 maps\_specialops::so_crush_player(self, "MOD_CRUSH");
        return;
      }
    }

    wait 0.05;
  }
}

player_laststand_set_down_part1() {
  self endon("revived");
  self endon("death");
  level endon("special_op_terminated");

  if(laststand_get_type() != 2) {
    wait 0.3;
  }
  thread player_laststand_force_switch_to_pistol();

  if(laststand_get_type() == 2) {
    if(get_lives_remaining() > 0) {
      if(!isDefined(self.laststand_count)) {
        self.laststand_count = 1;
      } else {
        self.laststand_count++;
      }
      if(self.laststand_count <= 9999) {
        thread player_laststand_getup_sequence();
        self waittill("laststand_getup_failed");
      }

      if(!maps\_utility::is_coop() || maps\_utility::is_player_down_and_out(maps\_utility::get_other_player(self))) {
        player_laststand_kill();
        return;
      }
    } else {
      waittillframeend;
    }
  } else {
    wait 0.25;
    self disableinvulnerability();
    thread player_laststand_down_draw_attention();
    self waittill("damage");
  }

  thread player_laststand_set_down_part2();
}

player_laststand_getup_sequence() {
  self endon("revived");
  self endon("death");
  self endon("laststand_getup_failed");
  level endon("special_op_terminated");
  thread player_laststand_getup_sequence_clean_up();
  thread player_laststand_getup_sequence_catch_kills();
  thread player_laststand_getup_sequence_catch_damage();
  thread player_laststand_getup_sequence_bad_place();
  thread player_laststand_effect();
  thread player_laststand_getup_sequence_ignore();
  var_0 = (self.laststand_count - 1) * 0.0;
  var_1 = max(0.5 - var_0, 0.2);
  player_laststand_getup_bar_set_fill(var_1);
  self.revive_bar_getup maps\_hud_util::hidebar(0);
  self.revive_bar_getup_icon.alpha = 1.0;
  wait 2.0;
  self disableinvulnerability();
  self.last_damage_time = gettime();

  for(;;) {
    var_2 = 0;

    if(isDefined(self.laststand_getup_fast) && self.laststand_getup_fast) {
      var_2 = 1;
    } else if(gettime() - self.last_damage_time > 3000.0) {
      var_2 = 1;
    }
    var_3 = common_scripts\utility::ter_op(var_2, 0.01, 0.0025);
    player_laststand_getup_bar_adjust(var_3);
    wait 0.05;
  }
}

player_laststand_getup_sequence_clean_up() {
  level endon("special_op_terminated");
  self endon("death");
  var_0 = common_scripts\utility::waittill_any_return("player_down_and_out", "revived");

  if(isDefined(var_0) && var_0 == "player_down_and_out") {
    self.ignoreme = 1;
  }
  update_lives_remaining(0);
  thread player_laststand_getup_sequence_clean_up_delayed(0.5);
  self.laststand_getup_fast = 0;

  if(isDefined(self.laststand_badplace)) {
    badplace_delete(self.laststand_badplace);
    self.laststand_badplace = undefined;
  }
}

player_laststand_getup_sequence_clean_up_delayed(var_0) {
  level endon("special_op_terminated");
  self endon("player_downed");
  wait(var_0);
  self.revive_bar_getup maps\_hud_util::hidebar(1);
  self.revive_bar_getup_icon.alpha = 0.0;
}

player_laststand_getup_sequence_ignore() {
  self endon("revived");
  self endon("death");
  self endon("laststand_getup_failed");
  level endon("special_op_terminated");
  self.ignoreme = 1;
  wait 0.25;
  self.ignoreme = 0;
}

player_laststand_getup_sequence_catch_kills() {
  self endon("revived");
  self endon("death");
  self endon("laststand_getup_failed");
  level endon("special_op_terminated");

  for(;;) {
    self waittill("revive_kill");
    player_laststand_getup_bar_adjust(1.0);
  }
}

player_laststand_getup_sequence_catch_damage() {
  self endon("revived");
  self endon("death");
  self endon("laststand_getup_failed");
  level endon("special_op_terminated");

  for(;;) {
    common_scripts\utility::waittill_any("damage", "deathshield");
    player_laststand_getup_bar_adjust(-0.1);
    self.last_damage_time = gettime();
    wait 0.2;
  }
}

player_laststand_getup_sequence_bad_place() {
  self endon("revived");
  self endon("death");
  self endon("laststand_getup_failed");
  level endon("special_op_terminated");
  self.laststand_badplace = self.unique_id + "_ls_badplace";

  for(;;) {
    badplace_cylinder(self.laststand_badplace, 90.0, self.origin, 120, 120, "axis");
    wait 90.0;
    badplace_delete(self.laststand_badplace);
  }
}

player_laststand_getup_bar_adjust(var_0) {
  var_0 = clamp(var_0, -1.0, 1.0);
  var_1 = clamp(self.revive_bar_getup.bar.frac + var_0, 0.0, 1.0);
  player_laststand_getup_bar_set_fill(var_1);

  if(var_1 == 1.0) {
    player_laststand_revive_self();
  } else if(var_1 == 0.0) {
    self notify("laststand_getup_failed");
  }
}

player_laststand_getup_bar_set_fill(var_0) {
  var_1 = (1, 0.4, 0.4);
  var_2 = (1, 0, 0);
  self.revive_bar_getup.bar.color = vectorlerp(var_2, var_1, var_0);
  self.revive_bar_getup maps\_hud_util::updatebar(var_0);
}

player_laststand_set_down_part2() {
  self.down_part2_proc_ran = 1;
  self notify("player_down_and_out");
  self disableweapons();
  thread player_dying_effect();
  self.ignoreme = 1;
  self.ignorerandombulletdamage = 1;
  self enableinvulnerability();
}

player_laststand_force_switch_to_pistol() {
  self.preincap_weapon = self getcurrentweapon();
  var_0 = player_laststand_check_for_pistol();
  self.preincap_pistol = undefined;
  self.preincap_pistol_stock = 0;
  self.preincap_pistol_clip = 0;
  var_1 = undefined;

  if(isDefined(var_0)) {
    self.preincap_pistol = var_0;
    self.preincap_pistol_stock = self getweaponammostock(var_0);
    self.preincap_pistol_clip = self getweaponammoclip(var_0);
    var_1 = var_0;
  } else if(isDefined(level.coop_incap_weapon)) {
    var_2 = isDefined(level.coop_incap_weapon) && self hasweapon(level.coop_incap_weapon);

    if(!var_2) {
      self.forced_pistol = level.coop_incap_weapon;
      self giveweapon(level.coop_incap_weapon);
    } else {
      self.preincap_pistol = level.coop_incap_weapon;
      self.preincap_pistol_stock = self getweaponammostock(var_0);
      self.preincap_pistol_clip = self getweaponammoclip(var_0);
    }

    var_1 = level.coop_incap_weapon;
  } else {
    var_1 = "fnfiveseven";
    self.forced_pistol = var_1;
    self giveweapon(var_1);
  }

  self setweaponammoclip(var_1, weaponclipsize(var_1));
  self setweaponammostock(var_1, weaponmaxammo(var_1));
  thread player_laststand_on_reload_fill_stock();
  self switchtoweapon(var_1);
  self enableweapons();
}

player_laststand_on_reload_fill_stock() {
  level endon("special_op_terminated");
  self endon("death");
  self endon("player_down_and_out");
  self endon("not_in_last_stand");
  self endon("revived");
  self endon("weapon_change");

  for(;;) {
    self waittill("reload");
    var_0 = self getcurrentweapon();
    self setweaponammostock(var_0, weaponmaxammo(var_0));
  }
}

player_laststand_down_draw_attention() {
  self endon("death");
  self endon("revived");
  self endon("damage");
  notifyoncommand("draw_attention", "+attack");
  notifyoncommand("draw_attention", "+attack_akimbo_accessible");
  common_scripts\utility::waittill_any_timeout(4, "draw_attention", "player_down_and_out");

  if(maps\_utility::is_player_down_and_out(self)) {
    return;
  }
  self.ignoreme = 0;
  self.ignorerandombulletdamage = 0;
}

ai_laststand_on_death() {
  level endon("special_op_terminated");
  self waittill("death", var_0, var_1, var_2);
  var_3 = 0;

  if(isDefined(var_0) && isalive(var_0) && isPlayer(var_0) && maps\_utility::is_player_down(var_0)) {
    if(isDefined(var_2) && weaponclass(var_2) == "pistol") {
      var_3 = 1;
    } else if(isDefined(var_1) && var_1 == "MOD_MELEE") {
      var_3 = 1;
    }
  }

  if(var_3) {
    var_0 notify("revive_kill");
  }
}

player_dying_effect() {
  self endon("death");
  self endon("revived");

  if(!maps\_utility::ent_flag_exist("laststand_dying_effect")) {
    maps\_utility::ent_flag_init("laststand_dying_effect");
  } else if(maps\_utility::ent_flag("laststand_dying_effect")) {
    return;
  }
  maps\_utility::ent_flag_set("laststand_dying_effect");
  player_shock_effect("default", 60, 1);
}

player_dying_effect_remove() {
  if(maps\_utility::ent_flag_exist("laststand_dying_effect")) {
    maps\_utility::ent_flag_clear("laststand_dying_effect");
  }
  self stopshellshock();
}

player_laststand_effect() {
  self endon("death");
  self endon("revived");
  self endon("player_down_and_out");
  self notify("laststand_effect");
  self endon("laststand_effect");
  player_shock_effect("laststand_getup", 60, 1);
}

player_shock_effect(var_0, var_1, var_2, var_3) {
  self endon("death");
  level endon("special_op_terminated");

  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  if(isDefined(var_3)) {
    var_4 = strtok(var_3, " ");

    foreach(var_6 in var_4) {}
    self endon(var_6);
  }

  for(;;) {
    self shellshock(var_0, var_1);
    wait(var_1);

    if(isDefined(var_2) && !var_2) {
      break;
    }
  }
}

laststand_get_type() {
  var_0 = isDefined(level.laststand_type) && level.laststand_type == 0 || level.laststand_type == 1 || level.laststand_type == 2;

  if(var_0) {
    return level.laststand_type;
  } else {
    return 0;
  }
}

laststand_can_pick_self_up() {
  return laststand_get_type() == 2 && get_lives_remaining() > 0;
}

laststand_downing_will_fail() {
  if(maps\_utility::is_coop()) {
    var_0 = maps\_utility::get_other_player(self);
    var_1 = maps\_utility::is_player_down(var_0) && !var_0 laststand_can_pick_self_up() || maps\_utility::is_player_down_and_out(var_0);

    if(var_1 && !laststand_can_pick_self_up()) {
      return 1;
    }
    return 0;
  } else {
    if(!laststand_can_pick_self_up()) {
      return 1;
    }
    return 0;
  }
}

get_lives_remaining() {
  if(laststand_get_type() == 2 && isDefined(self.laststand_info.type_getup_lives)) {
    return max(0, self.laststand_info.type_getup_lives);
  }
  return 0;
}

update_lives_remaining(var_0) {
  var_0 = common_scripts\utility::ter_op(isDefined(var_0), var_0, 0);
  self.laststand_info.type_getup_lives = max(0, common_scripts\utility::ter_op(var_0, self.laststand_info.type_getup_lives + 1, self.laststand_info.type_getup_lives - 1));
  self notify("laststand_lives_updated");
}

player_laststand_kill() {
  level endon("special_op_terminated");
  thread player_dying_effect_remove();
  self enabledeathshield(0);
  self disableinvulnerability();
  self enablehealthshield(0);
  self.achieve_downed_kills = undefined;
  waittillframeend;
  self kill();
}

try_crush_player(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.dont_crush_player) && var_0.dont_crush_player) {
    return;
  }
  if(!isDefined(var_1)) {
    return;
  }
  if(var_1 != "MOD_CRUSH") {
    return;
  }
  if(isDefined(var_0.vehicletype)) {
    var_2 = var_0 vehicle_getspeed();

    if(abs(var_2) == 0) {
      return;
    }
  }

  if(common_scripts\utility::flag("special_op_terminated")) {
    return;
  }
  var_0 maps\_specialops::so_crush_player(self, var_1);
}

player_laststand_check_for_pistol(var_0) {
  var_1 = self getweaponslistprimaries();

  if(isDefined(var_0)) {
    foreach(var_3 in var_1) {
      if(var_3 == var_0) {
        return var_3;
      }
    }
  }

  var_5 = self getcurrentweapon();

  if(weaponclass(var_5) == "pistol") {
    return var_5;
  }
  foreach(var_3 in var_1) {
    if(weaponclass(var_3) == "pistol") {
      return var_3;
    }
  }

  return undefined;
}

laststand_on_mission_end() {
  level waittill("special_op_terminated");
  revive_destroy_use_targets();
  revive_hud_cleanup_bars();
  laststand_hud_destroy();
}

revive_hud_cleanup_bars() {
  if(isDefined(level.bars)) {
    foreach(var_1 in level.bars) {
      if(isDefined(var_1)) {
        var_1 notify("destroying");
        var_1 maps\_hud_util::destroyelem();
      }
    }

    level.bars = undefined;
  }
}

waittill_disable_nag() {
  level endon("special_op_terminated");
  common_scripts\utility::waittill_any("nag", "nag_cancel", "death", "revived");
}

player_can_restore_weapon(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }
  if(var_0 == "none") {
    return 0;
  }
  if(!self hasweapon(var_0)) {
    return 0;
  }
  return 1;
}

revive_set_use_target_state(var_0) {
  var_1 = player_get_revive_ent();

  if(var_0) {
    var_1 makeusable();
  } else {
    var_1 makeunusable();
  }
  return var_1;
}

player_get_revive_ent() {
  return level.revive_ents[self.unique_id];
}

revive_destroy_use_targets() {
  if(isDefined(level.revive_ents)) {
    foreach(var_1 in level.revive_ents) {}
    var_1 delete();
  }
}

player_downed_hud_toggle_blinkstate() {
  self notify("player_downed_hud_blinkstate");
  self endon("player_downed_hud_blinkstate");
  self endon("death");
  self endon("revived");
  self.blinkstate = 1;

  for(;;) {
    wait(level.coop_icon_blinkcrement);

    if(self.blinkstate == 1) {
      self.blinkstate = 0;
      continue;
    }

    self.blinkstate = 1;
  }
}
/**********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_rave\cp_rave_challenges.gsc
**********************************************************/

register_default_challenges() {
  scripts\engine\utility::flag_init("pause_challenges");
  scripts\cp\zombies\solo_challenges::register_challenge("long_shot", undefined, 0, ::transponder_challenge_success_func, undefined, ::activate_long_shot, ::deactivate_distance_shot, undefined, ::generic_update_challenge);
  scripts\cp\zombies\solo_challenges::register_challenge("kill_melee", undefined, 0, ::rewind_challenge_success_func, undefined, ::generic_activate_challenge, ::blank_deactivate_challenge, undefined, ::generic_update_challenge);
  scripts\cp\zombies\solo_challenges::register_challenge("kill_crawlers", undefined, 0, ::armageddon_challenge_success_func, undefined, ::generic_activate_challenge, ::blank_deactivate_challenge, undefined, ::generic_update_challenge);
  scripts\cp\zombies\solo_challenges::register_challenge("multikills", undefined, 0, ::blackhole_challenge_success_func, undefined, ::generic_activate_challenge, ::blank_deactivate_challenge, undefined, ::generic_update_challenge);
  scripts\cp\zombies\solo_challenges::register_challenge("window_boards", undefined, 0, ::repulsor_challenge_success_func, undefined, ::activate_window_boards, ::blank_deactivate_challenge, undefined, ::generic_update_challenge);
  scripts\cp\zombies\solo_challenges::register_challenge("challenge_failed", undefined, 0, undefined, undefined, scripts\cp\zombies\solo_challenges::default_resetsuccess, scripts\cp\zombies\solo_challenges::default_resetsuccess, undefined, undefined);
  scripts\cp\zombies\solo_challenges::register_challenge("challenge_success", undefined, 0, undefined, undefined, scripts\cp\zombies\solo_challenges::default_resetsuccess, scripts\cp\zombies\solo_challenges::default_resetsuccess, undefined, undefined);
  scripts\cp\zombies\solo_challenges::register_challenge("next_challenge", undefined, 0, undefined, undefined, scripts\cp\zombies\solo_challenges::default_resetsuccess, scripts\cp\zombies\solo_challenges::default_resetsuccess, undefined, undefined);
  level.challenge_list = ["long_shot", "kill_melee", "kill_crawlers", "multikills", "window_boards"];
}

generic_activate_challenge(var_0) {
  var_0 scripts\cp\zombies\solo_challenges::default_resetsuccess();
  var_0.current_challenge.current_progress = 0;
  var_0 scripts\cp\zombies\solo_challenges::update_challenge_progress(0, var_0.current_challenge.objective_icon);
}

generic_update_challenge(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(scripts\engine\utility::flag("pause_challenges")) {
    return;
  }

  self.current_challenge.current_progress = self.current_challenge.current_progress + var_0;
  if(self.current_challenge.current_progress >= self.current_challenge.objective_icon) {
    self.current_challenge.success = 1;
  }

  scripts\cp\zombies\solo_challenges::update_challenge_progress(self.current_challenge.current_progress, self.current_challenge.objective_icon);
  if(self.current_challenge.success) {
    self notify("current_challenge_ended");
    scripts\cp\zombies\solo_challenges::deactivate_current_challenge(self);
    return;
  }

  if(scripts\engine\utility::istrue(var_1)) {
    self notify("current_challenge_ended");
    self.current_challenge.success = 0;
    scripts\cp\zombies\solo_challenges::deactivate_current_challenge(self);
  }
}

enable_interaction_on_new_or_completed_challenge(var_0, var_1, var_2) {
  var_1 endon("disconnect");
  var_3 = var_1 scripts\engine\utility::waittill_any_return_no_endon_death_3("challenge_complete", "new_challenge_started");
  scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(var_0, var_1);
  if(var_3 == "new_challenge_started" && isDefined(var_2)) {
    level thread[[var_2]](var_1);
  }
}

rave_challenge_activate(var_0, var_1, var_2, var_3) {
  scripts\cp\zombies\solo_challenges::activate_new_challenge(var_0, var_1);
  scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_2, var_1);
  level thread enable_interaction_on_new_or_completed_challenge(var_2, var_1, var_3);
  var_1.current_challenge_kiosk = get_client_challenge_station(var_1, var_2);
  var_1.current_challenge_kiosk setscriptablepartstate("light", "complete");
  playsoundatpos(var_1.current_challenge_kiosk.origin, "challenge_station_light");
}

get_client_challenge_station(var_0, var_1) {
  var_2 = var_0 getentitynumber();
  foreach(var_4 in var_1.challenge_stations) {
    if(int(var_4.script_noteworthy) == var_2) {
      return var_4;
    }
  }
}

activate_armageddon_challenge(var_0, var_1) {
  if(!scripts\engine\utility::istrue(var_1.has_armageddon_badge)) {
    rave_challenge_activate("kill_crawlers", var_1, var_0);
    return;
  }

  if(scripts\engine\utility::istrue(var_1.isrewinding)) {
    return;
  }

  var_2 = "power_armageddon";
  if(isDefined(level.powers[var_2].defaultslot)) {
    var_3 = level.powers[var_2].defaultslot;
  } else {
    var_3 = "secondary";
  }

  var_1 playlocalsound("purchase_generic");
  var_1 scripts\cp\powers\coop_powers::givepower(var_2, var_3, undefined, undefined, undefined, 0, 0);
  var_1 thread challenge_interaction_cooldown(var_0, 2);
}

armageddon_challenge_success_func(var_0) {
  var_0.has_armageddon_badge = 1;
  var_0 setclientomnvarbit("zm_challenges_completed", 5, 1);
  var_0 scripts\cp\cp_merits::processmerit("mt_dlc1_challenge_badge");
  var_0 notify("rave_challenge_badge_notify");
  var_0 add_to_completed_challenges("armageddon");
  if(isDefined(self.success)) {
    return self.success;
  }

  return self.default_success;
}

armageddon_challenge_hint(var_0, var_1) {
  if(!scripts\engine\utility::istrue(var_1.has_armageddon_badge)) {
    return &"CP_RAVE_CHALLENGES_ARMAGEDDON_CHALLENGE";
  }

  return &"CP_RAVE_CHALLENGES_PURCHASE_ARMAGEDDON";
}

activate_repulsor_challenge(var_0, var_1) {
  if(!scripts\engine\utility::istrue(var_1.has_repulsor_badge)) {
    rave_challenge_activate("window_boards", var_1, var_0);
    return;
  }

  if(scripts\engine\utility::istrue(var_1.isrewinding)) {
    return;
  }

  var_2 = "power_repulsor";
  if(isDefined(level.powers[var_2].defaultslot)) {
    var_3 = level.powers[var_2].defaultslot;
  } else {
    var_3 = "secondary";
  }

  var_1 playlocalsound("purchase_generic");
  var_1 scripts\cp\powers\coop_powers::givepower(var_2, var_3, undefined, undefined, undefined, 0, 0);
  var_1 thread challenge_interaction_cooldown(var_0, 2);
}

repulsor_challenge_success_func(var_0) {
  var_0.has_repulsor_badge = 1;
  var_0 setclientomnvarbit("zm_challenges_completed", 3, 1);
  var_0 scripts\cp\cp_merits::processmerit("mt_dlc1_challenge_badge");
  var_0 notify("rave_challenge_badge_notify");
  var_0 add_to_completed_challenges("repulsor");
  if(isDefined(self.success)) {
    return self.success;
  }

  return self.default_success;
}

repulsor_challenge_hint(var_0, var_1) {
  if(!scripts\engine\utility::istrue(var_1.has_repulsor_badge)) {
    return &"CP_RAVE_CHALLENGES_REPULSOR_CHALLENGE";
  }

  return &"CP_RAVE_CHALLENGES_PURCHASE_REPULSOR";
}

activate_blackhole_challenge(var_0, var_1) {
  if(!scripts\engine\utility::istrue(var_1.has_blackhole_badge)) {
    rave_challenge_activate("multikills", var_1, var_0);
    return;
  }

  if(scripts\engine\utility::istrue(var_1.isrewinding)) {
    return;
  }

  var_2 = "power_blackholeGrenade";
  if(isDefined(level.powers[var_2].defaultslot)) {
    var_3 = level.powers[var_2].defaultslot;
  } else {
    var_3 = "secondary";
  }

  var_1 playlocalsound("purchase_generic");
  var_1 scripts\cp\powers\coop_powers::givepower(var_2, var_3, undefined, undefined, undefined, 0, 0);
  var_1 thread challenge_interaction_cooldown(var_0, 2);
}

blackhole_challenge_hint(var_0, var_1) {
  if(!scripts\engine\utility::istrue(var_1.has_blackhole_badge)) {
    return &"CP_RAVE_CHALLENGES_BLACKHOLE_CHALLENGE";
  }

  return &"CP_RAVE_CHALLENGES_PURCHASE_BLACKHOLE";
}

blackhole_challenge_success_func(var_0) {
  var_0.has_blackhole_badge = 1;
  var_0 setclientomnvarbit("zm_challenges_completed", 2, 1);
  var_0 scripts\cp\cp_merits::processmerit("mt_dlc1_challenge_badge");
  var_0 notify("rave_challenge_badge_notify");
  var_0 add_to_completed_challenges("blackhole");
  if(isDefined(self.success)) {
    return self.success;
  }

  return self.default_success;
}

activate_transponder_challenge(var_0, var_1) {
  if(!scripts\engine\utility::istrue(var_1.has_transponder_badge)) {
    rave_challenge_activate("long_shot", var_1, var_0, ::deactivate_distance_shot);
    return;
  }

  if(scripts\engine\utility::istrue(var_1.isrewinding)) {
    return;
  }

  var_2 = "power_transponder";
  if(isDefined(level.powers[var_2].defaultslot)) {
    var_3 = level.powers[var_2].defaultslot;
  } else {
    var_3 = "secondary";
  }

  var_1 playlocalsound("purchase_generic");
  var_1 scripts\cp\powers\coop_powers::givepower(var_2, var_3, undefined, undefined, undefined, 0, 0);
  var_1 thread challenge_interaction_cooldown(var_0, 2);
}

transponder_challenge_hint(var_0, var_1) {
  if(!scripts\engine\utility::istrue(var_1.has_transponder_badge)) {
    return &"CP_RAVE_CHALLENGES_TRANSPONDER_CHALLENGE";
  }

  return &"CP_RAVE_CHALLENGES_PURCHASE_TRANSPONDER";
}

transponder_challenge_success_func(var_0) {
  var_0.has_transponder_badge = 1;
  var_0 setclientomnvarbit("zm_challenges_completed", 4, 1);
  var_0 scripts\cp\cp_merits::processmerit("mt_dlc1_challenge_badge");
  var_0 notify("rave_challenge_badge_notify");
  var_0 add_to_completed_challenges("transponder");
  if(isDefined(self.success)) {
    return self.success;
  }

  return self.default_success;
}

activate_rewind_challenge(var_0, var_1) {
  if(!scripts\engine\utility::istrue(var_1.has_rewind_badge)) {
    rave_challenge_activate("kill_melee", var_1, var_0);
    return;
  }

  if(scripts\engine\utility::istrue(var_1.isrewinding)) {
    return;
  }

  var_2 = "power_rewind";
  if(isDefined(level.powers[var_2].defaultslot)) {
    var_3 = level.powers[var_2].defaultslot;
  } else {
    var_3 = "secondary";
  }

  var_1 playlocalsound("purchase_generic");
  var_1 scripts\cp\powers\coop_powers::givepower(var_2, var_3, undefined, undefined, undefined, 0, 0);
  var_1 thread challenge_interaction_cooldown(var_0, 2);
}

rewind_challenge_hint(var_0, var_1) {
  if(!scripts\engine\utility::istrue(var_1.has_rewind_badge)) {
    return &"CP_RAVE_CHALLENGES_REWIND_CHALLENGE";
  }

  return &"CP_RAVE_CHALLENGES_PURCAHSE_REWIND";
}

rewind_challenge_success_func(var_0) {
  var_0.has_rewind_badge = 1;
  var_0 setclientomnvarbit("zm_challenges_completed", 1, 1);
  var_0 scripts\cp\cp_merits::processmerit("mt_dlc1_challenge_badge");
  var_0 notify("rave_challenge_badge_notify");
  var_0 add_to_completed_challenges("rewind");
  if(isDefined(self.success)) {
    return self.success;
  }

  return self.default_success;
}

add_to_completed_challenges(var_0) {
  if(!isDefined(self.completed_challenges)) {
    self.completed_challenges = [];
  }

  self.completed_challenges = scripts\engine\utility::add_to_array(self.completed_challenges, var_0);
  if(self.completed_challenges.size == level.challenge_list.size) {
    scripts\cp\zombies\achievement::update_achievement("TOP_CAMPER", 1);
  }

  self.current_challenge_kiosk.interaction.power hudoutlineenableforclient(self, 3, 1, 1);
}

power_visiblity_monitor(var_0, var_1) {
  for(;;) {
    foreach(var_3 in level.players) {
      if(!isDefined(var_3.completed_challenges)) {
        var_0 hidefromplayer(var_3);
      } else if(!scripts\engine\utility::array_contains(var_3.completed_challenges, var_1)) {
        var_0 hidefromplayer(var_3);
      } else {
        var_0 showtoplayer(var_3);
      }

      wait(0.05);
    }

    wait(1);
  }
}

challenge_station_visibility_monitor() {
  for(;;) {
    foreach(var_1 in level.players) {
      var_2 = var_1 getentitynumber();
      if(int(self.script_noteworthy) != var_2) {
        self hidefromplayer(var_1);
      } else {
        self showtoplayer(var_1);
        if(isDefined(var_1.completed_challenges) && scripts\engine\utility::array_contains(var_1.completed_challenges, self.interaction.script_type)) {
          self setscriptablepartstate("light", "complete");
        } else if(isDefined(var_1.current_challenge_kiosk) && self == var_1.current_challenge_kiosk) {
          self setscriptablepartstate("light", "complete");
        } else {
          self setscriptablepartstate("light", "off");
        }
      }

      wait(0.05);
    }

    wait(1);
  }
}

activate_window_boards(var_0) {
  generic_activate_challenge(var_0);
  var_0 thread window_boards_logic();
}

window_boards_logic() {
  self endon("stop_windowboard_logic");
  self endon("challenge_deactivated");
  self endon("new_challenge_started");
  self endon("disconnect");
  for(;;) {
    level waittill("reboard", var_0, var_1);
    if(self != var_1) {
      continue;
    }

    scripts\cp\zombies\solo_challenges::update_challenge("window_boards", var_0);
  }
}

blank_deactivate_challenge(var_0) {}

add_to_dismember_queue(var_0) {
  if(!isDefined(level.dismember_queue)) {
    level.dismember_queue = [];
  }

  var_1 = spawnStruct();
  var_1.limb = var_0;
  var_1.processed = 0;
  level.dismember_queue = scripts\engine\utility::add_to_array(level.dismember_queue, var_1);
}

activate_dismember_arm() {
  level.dismember_queue_func = ::add_to_dismember_queue;
  level.dismember_queue = [];
  generic_activate_challenge();
  level thread dismember_challenge_logic("arm");
}

activate_dismember_leg() {
  level.dismember_queue_func = ::add_to_dismember_queue;
  level.dismember_queue = [];
  generic_activate_challenge();
  level thread dismember_challenge_logic("leg");
}

dismember_challenge_logic(var_0) {
  level endon("stop_dismember_logic");
  level endon("challenge_deactivated");
  for(;;) {
    if(level.dismember_queue.size > 0) {
      foreach(var_2 in level.dismember_queue) {
        if(var_2.processed) {
          continue;
        }

        if(var_0 == "arm") {
          if(var_2.limb == 1 || var_2.limb == 2) {
            scripts\cp\zombies\solo_challenges::update_challenge("dismember_arm", 1);
          }
        } else if(var_0 == "leg") {
          if(var_2.limb == 4 || var_2.limb == 8) {
            scripts\cp\zombies\solo_challenges::update_challenge("dismember_leg", 1);
          }
        }

        var_2.processed = 1;
      }

      level.dismember_queue = [];
    }

    wait(0.1);
  }
}

deactivate_dismember_challenge() {
  level.dismember_queue_func = undefined;
  level.dismember_queue = undefined;
  level notify("stop_dismember_logic");
  scripts\cp\zombies\solo_challenges::default_resetsuccess();
}

activate_long_shot(var_0) {
  generic_activate_challenge(var_0);
  var_0 thread distance_shot_logic("long_shot");
}

activate_close_shot() {
  generic_activate_challenge();
  level thread distance_shot_logic("close_shot");
}

distance_shot_logic(var_0) {
  self endon("stop_distanceshot_logic");
  self endon("challenge_deactivated");
  self endon("new_challenge_started");
  self endon("disconnect");
  for(;;) {
    if(scripts\engine\utility::flag("pause_challenges")) {
      foreach(var_2 in scripts\mp\mp_agent::getaliveagentsofteam("axis")) {
        if(scripts\engine\utility::istrue(var_2.marked_for_challenge)) {
          scripts\cp\cp_outline::disable_outline_for_player(var_2, self);
          var_2.marked_for_challenge = undefined;
        }
      }

      scripts\engine\utility::flag_waitopen("pause_challenges");
    }

    foreach(var_3, var_2 in scripts\mp\mp_agent::getaliveagentsofteam("axis")) {
      if(!isDefined(var_2.agent_type)) {
        continue;
      }

      if(!scripts\cp\utility::should_be_affected_by_trap(var_2, 1, 1) && var_2.agent_type != "zombie_brute") {
        continue;
      }

      var_5 = undefined;
      if(is_distance_shot(self, undefined, var_2, var_0)) {
        var_5 = 1;
        scripts\cp\cp_outline::enable_outline_for_player(var_2, self, 0, 1, 0, "high");
      } else {
        scripts\cp\cp_outline::disable_outline_for_player(var_2, self);
      }

      var_2.marked_for_challenge = var_5;
      if(var_3 % 2 == 0) {
        wait(0.05);
      }
    }

    wait(0.05);
  }
}

deactivate_distance_shot(var_0) {
  var_0 notify("stop_distanceshot_logic");
  wait(1);
  foreach(var_2 in scripts\mp\mp_agent::getaliveagents()) {
    if(!isDefined(var_2.marked_for_challenge)) {
      continue;
    }

    var_2.marked_for_challenge = undefined;
    scripts\cp\cp_outline::disable_outline_for_player(var_2, var_0);
  }
}

activate_kill_marked() {
  generic_activate_challenge();
  level thread wait_for_marked_zombies(self);
}

wait_for_marked_zombies(var_0) {
  level endon("current_challenge_ended");
  level endon("challenge_deactivated");
  level.num_zombies_marked = 0;
  level.num_marked_zombies_killed = 0;
  for(;;) {
    if(scripts\engine\utility::flag("pause_challenges")) {
      foreach(var_2 in scripts\mp\mp_agent::getaliveagentsofteam("axis")) {
        if(scripts\engine\utility::istrue(var_2.marked_for_challenge)) {
          foreach(var_4 in level.players) {
            scripts\cp\cp_outline::disable_outline_for_player(var_2, var_4);
          }

          level.num_zombies_marked--;
          var_2.marked_for_challenge = undefined;
        }
      }

      scripts\engine\utility::flag_waitopen("pause_challenges");
    }

    var_7 = scripts\mp\mp_agent::getaliveagents();
    foreach(var_2 in var_7) {
      if(!scripts\cp\utility::should_be_affected_by_trap(var_2, 1, 1)) {
        continue;
      }

      if(scripts\engine\utility::istrue(var_2.marked_for_challenge)) {
        continue;
      }

      var_2.marked_for_challenge = 1;
      scripts\cp\cp_outline::enable_outline(var_2, 0, 1, 0);
      var_2 thread remove_outline_on_death();
      level.num_zombies_marked++;
      while(level.num_zombies_marked >= var_0.objective_icon) {
        if(scripts\engine\utility::flag("pause_challenges")) {
          foreach(var_2 in scripts\mp\mp_agent::getaliveagentsofteam("axis")) {
            if(scripts\engine\utility::istrue(var_2.marked_for_challenge)) {
              foreach(var_4 in level.players) {
                scripts\cp\cp_outline::disable_outline_for_player(var_2, var_4);
              }

              level.num_zombies_marked--;
              var_2.marked_for_challenge = undefined;
            }
          }

          scripts\engine\utility::flag_waitopen("pause_challenges");
        }

        wait(0.1);
      }
    }

    wait(0.05);
  }
}

deactivate_kill_marked() {
  foreach(var_1 in scripts\mp\mp_agent::getaliveagents()) {
    if(isDefined(var_1.marked_for_challenge)) {
      var_1.marked_for_challenge = undefined;
      scripts\cp\cp_outline::disable_outline(var_1);
    }
  }

  scripts\cp\zombies\solo_challenges::default_resetsuccess();
}

activate_area_kills() {
  generic_activate_challenge();
  level thread area_kills(self);
}

area_kills(var_0) {
  var_1 = scripts\cp\zombies\zombies_spawning::get_spawn_volumes_players_are_in(undefined, 1);
  var_2 = scripts\engine\utility::random(var_1);
  if(!isDefined(var_2)) {
    var_2 = spawnStruct();
    var_2.basename = "moon";
  } else if(var_2.basename == "arcade_back" || var_2.basename == "underground_route" || var_2.basename == "hidden_room") {
    var_2 = spawnStruct();
    var_2.basename = "moon";
  }

  var_3 = get_kill_spot_in_area(var_2);
  level.area_kill_fx = spawnfx(level._effect["challenge_ring"], var_3.origin + (0, 0, -15), anglesToForward((0, 0, 0)), anglestoup((0, 0, 0)));
  level.challenge_area_marker = spawnStruct();
  level.challenge_area_marker.origin = var_3.origin + (0, 0, -20);
  level.challenge_area_marker.fgetarg = -27120;
  wait(0.1);
  triggerfx(level.area_kill_fx);
  wait(0.1);
}

get_kill_spot_in_area(var_0) {
  var_1 = scripts\engine\utility::getStructArray("area_kill_" + var_0.basename, "targetname");
  return scripts\engine\utility::random(var_1);
}

deactivate_area_kills(var_0) {
  scripts\cp\zombies\solo_challenges::default_resetsuccess();
  level.area_kill_fx delete();
  level.challenge_area_marker = undefined;
}

activate_kill_zombiewhodamagedme() {
  generic_activate_challenge();
}

deactivate_kill_zombiewhodamagedme(var_0) {
  deactivate_distance_shot();
}

activate_kill_nodamage() {
  generic_activate_challenge();
  level thread fail_kill_nodamage(self);
  foreach(var_1 in level.players) {
    var_1 thread kill_nodamage_monitor();
  }
}

fail_kill_nodamage(var_0) {
  level endon("kill_nodamage_complete");
  level endon("challenge_deactivated");
  level waittill("kill_nodamage_failed");
  var_0.success = 0;
  scripts\cp\zombies\solo_challenges::deactivate_current_challenge();
  level notify("kill_nodamage_complete");
}

kill_nodamage_monitor() {
  level endon("kill_nodamage_complete");
  level endon("challenge_deactivated");
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    if(scripts\engine\utility::flag("pause_challenges")) {
      continue;
    }

    if(scripts\engine\utility::istrue(self.ability_invulnerable)) {
      continue;
    }

    if(isDefined(var_1) && isPlayer(var_1) && scripts\cp\utility::is_hardcore_mode()) {
      level notify("kill_nodamage_failed");
      return;
    } else if(isDefined(var_1) && isagent(var_1)) {
      level notify("kill_nodamage_failed");
      return;
    }
  }
}

update_kill_nodamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(scripts\engine\utility::flag("pause_challenges")) {
    return;
  }

  self.current_progress = self.current_progress + var_0;
  if(self.current_progress >= self.objective_icon) {
    self.success = 1;
  }

  scripts\cp\zombies\solo_challenges::update_challenge_progress(self.current_progress, self.objective_icon);
  if(self.success) {
    level notify("kill_nodamage_complete");
    scripts\cp\zombies\solo_challenges::deactivate_current_challenge();
  }
}

challenge_scalar_func(var_0) {
  var_1 = get_scalar_from_table(var_0);
  return var_1;
}

get_scalar_from_table(var_0) {
  var_1 = level.zombie_challenge_table;
  var_2 = 0;
  var_3 = 1;
  var_4 = 99;
  var_5 = 1;
  var_6 = 9;
  for(var_7 = var_3; var_7 <= var_4; var_7++) {
    var_8 = tablelookup(var_1, var_2, var_7, var_5);
    if(var_8 == "") {
      return undefined;
    }

    if(var_8 != var_0) {
      continue;
    }

    var_9 = tablelookup(var_1, var_2, var_7, var_6);
    if(isDefined(var_9)) {
      var_9 = strtok(var_9, " ");
      if(var_9.size > 0) {
        return int(var_9[0]);
      }
    }
  }
}

default_playerdamage_challenge_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(level.current_challenge)) {
    return 0;
  }

  if(scripts\engine\utility::flag("pause_challenges")) {
    return 0;
  }

  switch (level.current_challenge) {
    case "kill_zombiewhodamagedme":
      if(!scripts\engine\utility::istrue(var_1.marked_for_challenge)) {
        var_1 hudoutlineenableforclient(self, 0, 1, 0);
        var_1.marked_for_challenge = 1;
      }

      if(!scripts\engine\utility::array_contains(var_1.damaged_players, self)) {
        var_1.damaged_players[var_1.damaged_players.size] = self;
      }
      return 0;
  }

  return 1;
}

default_death_challenge_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_1.current_player_challenge)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(self.died_poorly)) {
    return 0;
  }

  switch (var_1.current_player_challenge) {
    case "long_shot":
      if(is_distance_shot(var_1, var_4, self, "long_shot")) {
        scripts\cp\zombies\solo_challenges::update_challenge("long_shot", 1, undefined, undefined, undefined, undefined, undefined, undefined, undefined, var_1);
      }
      return 0;

    case "close_shot":
      if(is_distance_shot(var_1, var_4, self, "close_shot")) {
        scripts\cp\zombies\solo_challenges::update_challenge("close_shot", 1, undefined, undefined, undefined, undefined, undefined, undefined, undefined, var_1);
      }
      return 0;

    case "jump_shot":
      if(isDefined(var_1) && isPlayer(var_1) && isDefined(var_4)) {
        if(((isDefined(self.killedby) && var_1 == self.killedby) || var_4 == var_1 getcurrentweapon()) && !var_1 isonground()) {
          scripts\cp\zombies\solo_challenges::update_challenge("jump_shot", 1, undefined, undefined, undefined, undefined, undefined, undefined, undefined, var_1);
        }

        return 0;
      }

      break;

    case "kill_marked":
      if(isDefined(self.marked_for_challenge) && var_3 != "MOD_SUICIDE") {
        scripts\cp\zombies\solo_challenges::update_challenge("kill_marked", 1);
      } else if(var_3 != "MOD_SUICIDE" || isDefined(self.marked_for_challenge) && var_3 == "MOD_SUICIDE") {
        scripts\cp\zombies\solo_challenges::update_challenge("kill_marked", 0, 1);
      }
      return 0;

    case "kill_melee":
      if(isDefined(var_1) && isPlayer(var_1) && var_3 == "MOD_MELEE" || var_4 == "iw7_axe_zm" || var_4 == "iw7_axe_zm_pap1" || var_4 == "iw7_axe_zm_pap2") {
        scripts\cp\zombies\solo_challenges::update_challenge("kill_melee", 1, undefined, undefined, undefined, undefined, undefined, undefined, undefined, var_1);
      }
      return 0;

    case "kill_nodamage":
      if(isDefined(var_1) && isPlayer(var_1)) {
        scripts\cp\zombies\solo_challenges::update_challenge("kill_nodamage", 1);
      }
      return 0;

    case "kill_headshots":
      if(scripts\cp\utility::isheadshot(var_4, var_6, var_3, var_1) && !isDefined(self.marked_for_death)) {
        scripts\cp\zombies\solo_challenges::update_challenge("kill_headshots", 1);
      }
      return 0;

    case "kill_crawlers":
      if(scripts\cp\utility::is_zombie_agent() && scripts\engine\utility::istrue(self.is_crawler)) {
        scripts\cp\zombies\solo_challenges::update_challenge("kill_crawlers", 1, undefined, undefined, undefined, undefined, undefined, undefined, undefined, var_1);
      }
      return 0;

    case "kill_before_enter":
      if(scripts\cp\utility::is_zombie_agent() && !self.entered_playspace) {
        scripts\cp\zombies\solo_challenges::update_challenge("kill_before_enter", 1);
      }
      return 0;

    case "multikills":
      if(!isDefined(var_1.lastkilltime) || !isDefined(var_1.lastmultikilltime)) {
        return 0;
      }

      if(gettime() != var_1.lastkilltime) {
        var_1.lastkilltime = gettime();
        return 0;
      } else if(gettime() == var_1.lastkilltime && var_1.lastmultikilltime != gettime()) {
        scripts\cp\zombies\solo_challenges::update_challenge("multikills", 1, undefined, undefined, undefined, undefined, undefined, undefined, undefined, var_1);
        var_1.lastmultikilltime = gettime();
        var_1.lastkilltime = gettime() + 50;
        return 0;
      }
      return 0;

    case "area_kills":
      if(isDefined(level.challenge_area_marker)) {
        if(isDefined(var_1) && isPlayer(var_1)) {
          if(distancesquared(var_1.origin, level.challenge_area_marker.origin) < level.challenge_area_marker.fgetarg) {
            scripts\cp\zombies\solo_challenges::update_challenge("area_kills", 1);
          }
        }
      }
      return 0;

    case "kill_zombiewhodamagedme":
      if(!isPlayer(var_1)) {
        return 0;
      }

      if(scripts\engine\utility::array_contains(self.damaged_players, var_1)) {
        scripts\cp\zombies\solo_challenges::update_challenge("kill_zombiewhodamagedme", 1);
      }

      break;
  }

  return 1;
}

is_distance_shot(var_0, var_1, var_2, var_3) {
  if(isPlayer(var_0) && isalive(var_0) && !var_0 scripts\cp\utility::isusingremote()) {
    if(var_3 == "long_shot") {
      return distancesquared(var_0.origin, var_2.origin) >= 90000;
    } else if(var_3 == "close_shot") {
      return distancesquared(var_0.origin, var_2.origin) <= 90000;
    }
  }

  return 0;
}

remove_outline_on_death() {
  level endon("game_ended");
  self waittill("death");
  if(isDefined(self.marked_for_challenge)) {
    scripts\cp\cp_outline::disable_outline(self);
  }
}

activate_no_bleedout() {}

update_no_bleedout(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(scripts\engine\utility::flag("pause_challenges")) {
    return;
  }

  self.success = 0;
  scripts\cp\cp_challenge::deactivate_current_challenge();
}

activate_no_laststand() {}

update_no_laststand(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(scripts\engine\utility::flag("pause_challenges")) {
    return;
  }

  self.success = 0;
  scripts\cp\cp_challenge::deactivate_current_challenge();
}

challenge_interaction_cooldown(var_0, var_1) {
  self endon("disconnect");
  scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_0, self);
  var_0.power hudoutlineenableforclient(self, 1, 1, 1);
  for(var_2 = 0; var_2 < var_1; var_2++) {
    level scripts\engine\utility::waittill_either("event_wave_starting", "regular_wave_starting");
  }

  scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(var_0, self);
  var_0.power hudoutlineenableforclient(self, 3, 1, 1);
}
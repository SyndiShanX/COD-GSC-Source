/**********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_rave\cp_rave_challenges.gsc
**********************************************************/

register_default_challenges() {
  scripts\engine\utility::flag_init("pause_challenges");
  scripts\cp\zombies\solo_challenges::register_challenge("long_shot", undefined, 0, ::transponder_challenge_success_func, undefined, ::activate_long_shot, ::deactivate_distance_shot, undefined, ::generic_update_challenge);
  scripts\cp\zombies\solo_challenges::register_challenge("kill_melee", undefined, 0, ::rewind_challenge_success_func, undefined, ::generic_activate_challenge, ::blank_deactivate_challenge, undefined, ::generic_update_challenge);
  scripts\cp\zombies\solo_challenges::register_challenge("kill_crawlers", undefined, 0, ::armageddon_challenge_success_func, undefined, ::generic_activate_challenge, ::blank_deactivate_challenge, undefined, ::generic_update_challenge);
  scripts\cp\zombies\solo_challenges::register_challenge("multikills", undefined, 0, ::blackhole_challenge_success_func, undefined, ::generic_activate_challenge, ::blank_deactivate_challenge, undefined, ::generic_update_challenge);
  scripts\cp\zombies\solo_challenges::register_challenge("window_boards", undefined, 0, ::repulsor_challenge_success_func, undefined, ::activate_window_boards, ::blank_deactivate_challenge, undefined, ::generic_update_challenge);
  scripts\cp\zombies\solo_challenges::register_challenge("challenge_failed", undefined, 0, undefined, undefined, ::scripts\cp\zombies\solo_challenges::default_resetsuccess, ::scripts\cp\zombies\solo_challenges::default_resetsuccess, undefined, undefined);
  scripts\cp\zombies\solo_challenges::register_challenge("challenge_success", undefined, 0, undefined, undefined, ::scripts\cp\zombies\solo_challenges::default_resetsuccess, ::scripts\cp\zombies\solo_challenges::default_resetsuccess, undefined, undefined);
  scripts\cp\zombies\solo_challenges::register_challenge("next_challenge", undefined, 0, undefined, undefined, ::scripts\cp\zombies\solo_challenges::default_resetsuccess, ::scripts\cp\zombies\solo_challenges::default_resetsuccess, undefined, undefined);
  level.challenge_list = ["long_shot", "kill_melee", "kill_crawlers", "multikills", "window_boards"];
}

generic_activate_challenge(param_00) {
  param_00 scripts\cp\zombies\solo_challenges::default_resetsuccess();
  param_00.current_challenge.current_progress = 0;
  param_00 scripts\cp\zombies\solo_challenges::update_challenge_progress(0, param_00.current_challenge.objective_icon);
}

generic_update_challenge(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(scripts\engine\utility::flag("pause_challenges")) {
    return;
  }

  self.current_challenge.current_progress = self.current_challenge.current_progress + param_00;
  if(self.current_challenge.current_progress >= self.current_challenge.objective_icon) {
    self.current_challenge.success = 1;
  }

  scripts\cp\zombies\solo_challenges::update_challenge_progress(self.current_challenge.current_progress, self.current_challenge.objective_icon);
  if(self.current_challenge.success) {
    self notify("current_challenge_ended");
    scripts\cp\zombies\solo_challenges::deactivate_current_challenge(self);
    return;
  }

  if(scripts\engine\utility::istrue(param_01)) {
    self notify("current_challenge_ended");
    self.current_challenge.success = 0;
    scripts\cp\zombies\solo_challenges::deactivate_current_challenge(self);
  }
}

enable_interaction_on_new_or_completed_challenge(param_00, param_01, param_02) {
  param_01 endon("disconnect");
  var_03 = param_01 scripts\engine\utility::waittill_any_return_no_endon_death_3("challenge_complete", "new_challenge_started");
  scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(param_00, param_01);
  if(var_03 == "new_challenge_started" && isDefined(param_02)) {
    level thread[[param_02]](param_01);
  }
}

rave_challenge_activate(param_00, param_01, param_02, param_03) {
  scripts\cp\zombies\solo_challenges::activate_new_challenge(param_00, param_01);
  scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(param_02, param_01);
  level thread enable_interaction_on_new_or_completed_challenge(param_02, param_01, param_03);
  param_01.current_challenge_kiosk = get_client_challenge_station(param_01, param_02);
  param_01.current_challenge_kiosk setscriptablepartstate("light", "complete");
  playsoundatpos(param_01.current_challenge_kiosk.origin, "challenge_station_light");
}

get_client_challenge_station(param_00, param_01) {
  var_02 = param_00 getentitynumber();
  foreach(var_04 in param_01.challenge_stations) {
    if(int(var_04.script_noteworthy) == var_02) {
      return var_04;
    }
  }
}

activate_armageddon_challenge(param_00, param_01) {
  if(!scripts\engine\utility::istrue(param_01.has_armageddon_badge)) {
    rave_challenge_activate("kill_crawlers", param_01, param_00);
    return;
  }

  if(scripts\engine\utility::istrue(param_01.isrewinding)) {
    return;
  }

  var_02 = "power_armageddon";
  if(isDefined(level.powers[var_02].defaultslot)) {
    var_03 = level.powers[var_02].defaultslot;
  } else {
    var_03 = "secondary";
  }

  param_01 playlocalsound("purchase_generic");
  param_01 scripts\cp\powers\coop_powers::givepower(var_02, var_03, undefined, undefined, undefined, 0, 0);
  param_01 thread challenge_interaction_cooldown(param_00, 2);
}

armageddon_challenge_success_func(param_00) {
  param_00.has_armageddon_badge = 1;
  param_00 setclientomnvarbit("zm_challenges_completed", 5, 1);
  param_00 scripts\cp\cp_merits::processmerit("mt_dlc1_challenge_badge");
  param_00 notify("rave_challenge_badge_notify");
  param_00 add_to_completed_challenges("armageddon");
  if(isDefined(self.success)) {
    return self.success;
  }

  return self.default_success;
}

armageddon_challenge_hint(param_00, param_01) {
  if(!scripts\engine\utility::istrue(param_01.has_armageddon_badge)) {
    return & "CP_RAVE_CHALLENGES_ARMAGEDDON_CHALLENGE";
  }

  return & "CP_RAVE_CHALLENGES_PURCHASE_ARMAGEDDON";
}

activate_repulsor_challenge(param_00, param_01) {
  if(!scripts\engine\utility::istrue(param_01.has_repulsor_badge)) {
    rave_challenge_activate("window_boards", param_01, param_00);
    return;
  }

  if(scripts\engine\utility::istrue(param_01.isrewinding)) {
    return;
  }

  var_02 = "power_repulsor";
  if(isDefined(level.powers[var_02].defaultslot)) {
    var_03 = level.powers[var_02].defaultslot;
  } else {
    var_03 = "secondary";
  }

  param_01 playlocalsound("purchase_generic");
  param_01 scripts\cp\powers\coop_powers::givepower(var_02, var_03, undefined, undefined, undefined, 0, 0);
  param_01 thread challenge_interaction_cooldown(param_00, 2);
}

repulsor_challenge_success_func(param_00) {
  param_00.has_repulsor_badge = 1;
  param_00 setclientomnvarbit("zm_challenges_completed", 3, 1);
  param_00 scripts\cp\cp_merits::processmerit("mt_dlc1_challenge_badge");
  param_00 notify("rave_challenge_badge_notify");
  param_00 add_to_completed_challenges("repulsor");
  if(isDefined(self.success)) {
    return self.success;
  }

  return self.default_success;
}

repulsor_challenge_hint(param_00, param_01) {
  if(!scripts\engine\utility::istrue(param_01.has_repulsor_badge)) {
    return & "CP_RAVE_CHALLENGES_REPULSOR_CHALLENGE";
  }

  return & "CP_RAVE_CHALLENGES_PURCHASE_REPULSOR";
}

activate_blackhole_challenge(param_00, param_01) {
  if(!scripts\engine\utility::istrue(param_01.has_blackhole_badge)) {
    rave_challenge_activate("multikills", param_01, param_00);
    return;
  }

  if(scripts\engine\utility::istrue(param_01.isrewinding)) {
    return;
  }

  var_02 = "power_blackholeGrenade";
  if(isDefined(level.powers[var_02].defaultslot)) {
    var_03 = level.powers[var_02].defaultslot;
  } else {
    var_03 = "secondary";
  }

  param_01 playlocalsound("purchase_generic");
  param_01 scripts\cp\powers\coop_powers::givepower(var_02, var_03, undefined, undefined, undefined, 0, 0);
  param_01 thread challenge_interaction_cooldown(param_00, 2);
}

blackhole_challenge_hint(param_00, param_01) {
  if(!scripts\engine\utility::istrue(param_01.has_blackhole_badge)) {
    return & "CP_RAVE_CHALLENGES_BLACKHOLE_CHALLENGE";
  }

  return & "CP_RAVE_CHALLENGES_PURCHASE_BLACKHOLE";
}

blackhole_challenge_success_func(param_00) {
  param_00.has_blackhole_badge = 1;
  param_00 setclientomnvarbit("zm_challenges_completed", 2, 1);
  param_00 scripts\cp\cp_merits::processmerit("mt_dlc1_challenge_badge");
  param_00 notify("rave_challenge_badge_notify");
  param_00 add_to_completed_challenges("blackhole");
  if(isDefined(self.success)) {
    return self.success;
  }

  return self.default_success;
}

activate_transponder_challenge(param_00, param_01) {
  if(!scripts\engine\utility::istrue(param_01.has_transponder_badge)) {
    rave_challenge_activate("long_shot", param_01, param_00, ::deactivate_distance_shot);
    return;
  }

  if(scripts\engine\utility::istrue(param_01.isrewinding)) {
    return;
  }

  var_02 = "power_transponder";
  if(isDefined(level.powers[var_02].defaultslot)) {
    var_03 = level.powers[var_02].defaultslot;
  } else {
    var_03 = "secondary";
  }

  param_01 playlocalsound("purchase_generic");
  param_01 scripts\cp\powers\coop_powers::givepower(var_02, var_03, undefined, undefined, undefined, 0, 0);
  param_01 thread challenge_interaction_cooldown(param_00, 2);
}

transponder_challenge_hint(param_00, param_01) {
  if(!scripts\engine\utility::istrue(param_01.has_transponder_badge)) {
    return & "CP_RAVE_CHALLENGES_TRANSPONDER_CHALLENGE";
  }

  return & "CP_RAVE_CHALLENGES_PURCHASE_TRANSPONDER";
}

transponder_challenge_success_func(param_00) {
  param_00.has_transponder_badge = 1;
  param_00 setclientomnvarbit("zm_challenges_completed", 4, 1);
  param_00 scripts\cp\cp_merits::processmerit("mt_dlc1_challenge_badge");
  param_00 notify("rave_challenge_badge_notify");
  param_00 add_to_completed_challenges("transponder");
  if(isDefined(self.success)) {
    return self.success;
  }

  return self.default_success;
}

activate_rewind_challenge(param_00, param_01) {
  if(!scripts\engine\utility::istrue(param_01.has_rewind_badge)) {
    rave_challenge_activate("kill_melee", param_01, param_00);
    return;
  }

  if(scripts\engine\utility::istrue(param_01.isrewinding)) {
    return;
  }

  var_02 = "power_rewind";
  if(isDefined(level.powers[var_02].defaultslot)) {
    var_03 = level.powers[var_02].defaultslot;
  } else {
    var_03 = "secondary";
  }

  param_01 playlocalsound("purchase_generic");
  param_01 scripts\cp\powers\coop_powers::givepower(var_02, var_03, undefined, undefined, undefined, 0, 0);
  param_01 thread challenge_interaction_cooldown(param_00, 2);
}

rewind_challenge_hint(param_00, param_01) {
  if(!scripts\engine\utility::istrue(param_01.has_rewind_badge)) {
    return & "CP_RAVE_CHALLENGES_REWIND_CHALLENGE";
  }

  return & "CP_RAVE_CHALLENGES_PURCAHSE_REWIND";
}

rewind_challenge_success_func(param_00) {
  param_00.has_rewind_badge = 1;
  param_00 setclientomnvarbit("zm_challenges_completed", 1, 1);
  param_00 scripts\cp\cp_merits::processmerit("mt_dlc1_challenge_badge");
  param_00 notify("rave_challenge_badge_notify");
  param_00 add_to_completed_challenges("rewind");
  if(isDefined(self.success)) {
    return self.success;
  }

  return self.default_success;
}

add_to_completed_challenges(param_00) {
  if(!isDefined(self.completed_challenges)) {
    self.completed_challenges = [];
  }

  self.completed_challenges = scripts\engine\utility::array_add_safe(self.completed_challenges, param_00);
  if(self.completed_challenges.size == level.challenge_list.size) {
    scripts\cp\zombies\achievement::update_achievement("TOP_CAMPER", 1);
  }

  self.current_challenge_kiosk.interaction.power hudoutlineenableforclient(self, 3, 1, 1);
}

power_visiblity_monitor(param_00, param_01) {
  for(;;) {
    foreach(var_03 in level.players) {
      if(!isDefined(var_03.completed_challenges)) {
        param_00 hidefromplayer(var_03);
      } else if(!scripts\engine\utility::array_contains(var_03.completed_challenges, param_01)) {
        param_00 hidefromplayer(var_03);
      } else {
        param_00 showtoplayer(var_03);
      }

      wait(0.05);
    }

    wait(1);
  }
}

challenge_station_visibility_monitor() {
  for(;;) {
    foreach(var_01 in level.players) {
      var_02 = var_01 getentitynumber();
      if(int(self.script_noteworthy) != var_02) {
        self hidefromplayer(var_01);
      } else {
        self showtoplayer(var_01);
        if(isDefined(var_01.completed_challenges) && scripts\engine\utility::array_contains(var_01.completed_challenges, self.interaction.script_type)) {
          self setscriptablepartstate("light", "complete");
        } else if(isDefined(var_01.current_challenge_kiosk) && self == var_01.current_challenge_kiosk) {
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

activate_window_boards(param_00) {
  generic_activate_challenge(param_00);
  param_00 thread window_boards_logic();
}

window_boards_logic() {
  self endon("stop_windowboard_logic");
  self endon("challenge_deactivated");
  self endon("new_challenge_started");
  self endon("disconnect");
  for(;;) {
    level waittill("reboard", var_00, var_01);
    if(self != var_01) {
      continue;
    }

    scripts\cp\zombies\solo_challenges::update_challenge("window_boards", var_00);
  }
}

blank_deactivate_challenge(param_00) {}

add_to_dismember_queue(param_00) {
  if(!isDefined(level.dismember_queue)) {
    level.dismember_queue = [];
  }

  var_01 = spawnStruct();
  var_01.limb = param_00;
  var_01.processed = 0;
  level.dismember_queue = scripts\engine\utility::array_add_safe(level.dismember_queue, var_01);
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

dismember_challenge_logic(param_00) {
  level endon("stop_dismember_logic");
  level endon("challenge_deactivated");
  for(;;) {
    if(level.dismember_queue.size > 0) {
      foreach(var_02 in level.dismember_queue) {
        if(var_02.processed) {
          continue;
        }

        if(param_00 == "arm") {
          if(var_02.limb == 1 || var_02.limb == 2) {
            scripts\cp\zombies\solo_challenges::update_challenge("dismember_arm", 1);
          }
        } else if(param_00 == "leg") {
          if(var_02.limb == 4 || var_02.limb == 8) {
            scripts\cp\zombies\solo_challenges::update_challenge("dismember_leg", 1);
          }
        }

        var_02.processed = 1;
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

activate_long_shot(param_00) {
  generic_activate_challenge(param_00);
  param_00 thread distance_shot_logic("long_shot");
}

activate_close_shot() {
  generic_activate_challenge();
  level thread distance_shot_logic("close_shot");
}

distance_shot_logic(param_00) {
  self endon("stop_distanceshot_logic");
  self endon("challenge_deactivated");
  self endon("new_challenge_started");
  self endon("disconnect");
  for(;;) {
    if(scripts\engine\utility::flag("pause_challenges")) {
      foreach(var_02 in scripts\mp\mp_agent::getaliveagentsofteam("axis")) {
        if(scripts\engine\utility::istrue(var_02.marked_for_challenge)) {
          scripts\cp\cp_outline::disable_outline_for_player(var_02, self);
          var_02.marked_for_challenge = undefined;
        }
      }

      scripts\engine\utility::flag_waitopen("pause_challenges");
    }

    foreach(var_03, var_02 in scripts\mp\mp_agent::getaliveagentsofteam("axis")) {
      if(!isDefined(var_02.agent_type)) {
        continue;
      }

      if(!scripts\cp\utility::should_be_affected_by_trap(var_02, 1, 1) && var_02.agent_type != "zombie_brute") {
        continue;
      }

      var_05 = undefined;
      if(is_distance_shot(self, undefined, var_02, param_00)) {
        var_05 = 1;
        scripts\cp\cp_outline::enable_outline_for_player(var_02, self, 0, 1, 0, "high");
      } else {
        scripts\cp\cp_outline::disable_outline_for_player(var_02, self);
      }

      var_02.marked_for_challenge = var_05;
      if(var_03 % 2 == 0) {
        wait(0.05);
      }
    }

    wait(0.05);
  }
}

deactivate_distance_shot(param_00) {
  param_00 notify("stop_distanceshot_logic");
  wait(1);
  foreach(var_02 in scripts\mp\mp_agent::getaliveagents()) {
    if(!isDefined(var_02.marked_for_challenge)) {
      continue;
    }

    var_02.marked_for_challenge = undefined;
    scripts\cp\cp_outline::disable_outline_for_player(var_02, param_00);
  }
}

activate_kill_marked() {
  generic_activate_challenge();
  level thread wait_for_marked_zombies(self);
}

wait_for_marked_zombies(param_00) {
  level endon("current_challenge_ended");
  level endon("challenge_deactivated");
  level.num_zombies_marked = 0;
  level.num_marked_zombies_killed = 0;
  for(;;) {
    if(scripts\engine\utility::flag("pause_challenges")) {
      foreach(var_02 in scripts\mp\mp_agent::getaliveagentsofteam("axis")) {
        if(scripts\engine\utility::istrue(var_02.marked_for_challenge)) {
          foreach(var_04 in level.players) {
            scripts\cp\cp_outline::disable_outline_for_player(var_02, var_04);
          }

          level.num_zombies_marked--;
          var_02.marked_for_challenge = undefined;
        }
      }

      scripts\engine\utility::flag_waitopen("pause_challenges");
    }

    var_07 = scripts\mp\mp_agent::getaliveagents();
    foreach(var_02 in var_07) {
      if(!scripts\cp\utility::should_be_affected_by_trap(var_02, 1, 1)) {
        continue;
      }

      if(scripts\engine\utility::istrue(var_02.marked_for_challenge)) {
        continue;
      }

      var_02.marked_for_challenge = 1;
      scripts\cp\cp_outline::enable_outline(var_02, 0, 1, 0);
      var_02 thread remove_outline_on_death();
      level.num_zombies_marked++;
      while(level.num_zombies_marked >= param_00.objective_icon) {
        if(scripts\engine\utility::flag("pause_challenges")) {
          foreach(var_02 in scripts\mp\mp_agent::getaliveagentsofteam("axis")) {
            if(scripts\engine\utility::istrue(var_02.marked_for_challenge)) {
              foreach(var_04 in level.players) {
                scripts\cp\cp_outline::disable_outline_for_player(var_02, var_04);
              }

              level.num_zombies_marked--;
              var_02.marked_for_challenge = undefined;
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
  foreach(var_01 in scripts\mp\mp_agent::getaliveagents()) {
    if(isDefined(var_01.marked_for_challenge)) {
      var_01.marked_for_challenge = undefined;
      scripts\cp\cp_outline::disable_outline(var_01);
    }
  }

  scripts\cp\zombies\solo_challenges::default_resetsuccess();
}

activate_area_kills() {
  generic_activate_challenge();
  level thread area_kills(self);
}

area_kills(param_00) {
  var_01 = scripts\cp\zombies\zombies_spawning::get_spawn_volumes_players_are_in(undefined, 1);
  var_02 = scripts\engine\utility::random(var_01);
  if(!isDefined(var_02)) {
    var_02 = spawnStruct();
    var_02.basename = "moon";
  } else if(var_02.basename == "arcade_back" || var_02.basename == "underground_route" || var_02.basename == "hidden_room") {
    var_02 = spawnStruct();
    var_02.basename = "moon";
  }

  var_03 = get_kill_spot_in_area(var_02);
  level.area_kill_fx = spawnfx(level._effect["challenge_ring"], var_03.origin + (0, 0, -15), anglesToForward((0, 0, 0)), anglestoup((0, 0, 0)));
  level.challenge_area_marker = spawnStruct();
  level.challenge_area_marker.origin = var_03.origin + (0, 0, -20);
  level.challenge_area_marker.fgetarg = -27120;
  wait(0.1);
  triggerfx(level.area_kill_fx);
  wait(0.1);
}

get_kill_spot_in_area(param_00) {
  var_01 = scripts\engine\utility::getstructarray("area_kill_" + param_00.basename, "targetname");
  return scripts\engine\utility::random(var_01);
}

deactivate_area_kills(param_00) {
  scripts\cp\zombies\solo_challenges::default_resetsuccess();
  level.area_kill_fx delete();
  level.challenge_area_marker = undefined;
}

activate_kill_zombiewhodamagedme() {
  generic_activate_challenge();
}

deactivate_kill_zombiewhodamagedme(param_00) {
  deactivate_distance_shot();
}

activate_kill_nodamage() {
  generic_activate_challenge();
  level thread fail_kill_nodamage(self);
  foreach(var_01 in level.players) {
    var_01 thread kill_nodamage_monitor();
  }
}

fail_kill_nodamage(param_00) {
  level endon("kill_nodamage_complete");
  level endon("challenge_deactivated");
  level waittill("kill_nodamage_failed");
  param_00.success = 0;
  scripts\cp\zombies\solo_challenges::deactivate_current_challenge();
  level notify("kill_nodamage_complete");
}

kill_nodamage_monitor() {
  level endon("kill_nodamage_complete");
  level endon("challenge_deactivated");
  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
    if(scripts\engine\utility::flag("pause_challenges")) {
      continue;
    }

    if(scripts\engine\utility::istrue(self.ability_invulnerable)) {
      continue;
    }

    if(isDefined(var_01) && isplayer(var_01) && scripts\cp\utility::is_hardcore_mode()) {
      level notify("kill_nodamage_failed");
      return;
    } else if(isDefined(var_01) && isagent(var_01)) {
      level notify("kill_nodamage_failed");
      return;
    }
  }
}

update_kill_nodamage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(scripts\engine\utility::flag("pause_challenges")) {
    return;
  }

  self.current_progress = self.current_progress + param_00;
  if(self.current_progress >= self.objective_icon) {
    self.success = 1;
  }

  scripts\cp\zombies\solo_challenges::update_challenge_progress(self.current_progress, self.objective_icon);
  if(self.success) {
    level notify("kill_nodamage_complete");
    scripts\cp\zombies\solo_challenges::deactivate_current_challenge();
  }
}

challenge_scalar_func(param_00) {
  var_01 = get_scalar_from_table(param_00);
  return var_01;
}

get_scalar_from_table(param_00) {
  var_01 = level.zombie_challenge_table;
  var_02 = 0;
  var_03 = 1;
  var_04 = 99;
  var_05 = 1;
  var_06 = 9;
  for(var_07 = var_03; var_07 <= var_04; var_07++) {
    var_08 = tablelookup(var_01, var_02, var_07, var_05);
    if(var_08 == "") {
      return undefined;
    }

    if(var_08 != param_00) {
      continue;
    }

    var_09 = tablelookup(var_01, var_02, var_07, var_06);
    if(isDefined(var_09)) {
      var_09 = strtok(var_09, " ");
      if(var_09.size > 0) {
        return int(var_09[0]);
      }
    }
  }
}

default_playerdamage_challenge_func(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(!isDefined(level.current_challenge)) {
    return 0;
  }

  if(scripts\engine\utility::flag("pause_challenges")) {
    return 0;
  }

  switch (level.current_challenge) {
    case "kill_zombiewhodamagedme":
      if(!scripts\engine\utility::istrue(param_01.marked_for_challenge)) {
        param_01 hudoutlineenableforclient(self, 0, 1, 0);
        param_01.marked_for_challenge = 1;
      }

      if(!scripts\engine\utility::array_contains(param_01.damaged_players, self)) {
        param_01.damaged_players[param_01.damaged_players.size] = self;
      }
      return 0;
  }

  return 1;
}

default_death_challenge_func(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(!isDefined(param_01.current_player_challenge)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(self.died_poorly)) {
    return 0;
  }

  switch (param_01.current_player_challenge) {
    case "long_shot":
      if(is_distance_shot(param_01, param_04, self, "long_shot")) {
        scripts\cp\zombies\solo_challenges::update_challenge("long_shot", 1, undefined, undefined, undefined, undefined, undefined, undefined, undefined, param_01);
      }
      return 0;

    case "close_shot":
      if(is_distance_shot(param_01, param_04, self, "close_shot")) {
        scripts\cp\zombies\solo_challenges::update_challenge("close_shot", 1, undefined, undefined, undefined, undefined, undefined, undefined, undefined, param_01);
      }
      return 0;

    case "jump_shot":
      if(isDefined(param_01) && isplayer(param_01) && isDefined(param_04)) {
        if(((isDefined(self.killedby) && param_01 == self.killedby) || param_04 == param_01 getcurrentweapon()) && !param_01 isonground()) {
          scripts\cp\zombies\solo_challenges::update_challenge("jump_shot", 1, undefined, undefined, undefined, undefined, undefined, undefined, undefined, param_01);
        }

        return 0;
      }

      break;

    case "kill_marked":
      if(isDefined(self.marked_for_challenge) && param_03 != "MOD_SUICIDE") {
        scripts\cp\zombies\solo_challenges::update_challenge("kill_marked", 1);
      } else if(param_03 != "MOD_SUICIDE" || isDefined(self.marked_for_challenge) && param_03 == "MOD_SUICIDE") {
        scripts\cp\zombies\solo_challenges::update_challenge("kill_marked", 0, 1);
      }
      return 0;

    case "kill_melee":
      if(isDefined(param_01) && isplayer(param_01) && param_03 == "MOD_MELEE" || param_04 == "iw7_axe_zm" || param_04 == "iw7_axe_zm_pap1" || param_04 == "iw7_axe_zm_pap2") {
        scripts\cp\zombies\solo_challenges::update_challenge("kill_melee", 1, undefined, undefined, undefined, undefined, undefined, undefined, undefined, param_01);
      }
      return 0;

    case "kill_nodamage":
      if(isDefined(param_01) && isplayer(param_01)) {
        scripts\cp\zombies\solo_challenges::update_challenge("kill_nodamage", 1);
      }
      return 0;

    case "kill_headshots":
      if(scripts\cp\utility::isheadshot(param_04, param_06, param_03, param_01) && !isDefined(self.marked_for_death)) {
        scripts\cp\zombies\solo_challenges::update_challenge("kill_headshots", 1);
      }
      return 0;

    case "kill_crawlers":
      if(scripts\cp\utility::is_zombie_agent() && scripts\engine\utility::istrue(self.is_crawler)) {
        scripts\cp\zombies\solo_challenges::update_challenge("kill_crawlers", 1, undefined, undefined, undefined, undefined, undefined, undefined, undefined, param_01);
      }
      return 0;

    case "kill_before_enter":
      if(scripts\cp\utility::is_zombie_agent() && !self.entered_playspace) {
        scripts\cp\zombies\solo_challenges::update_challenge("kill_before_enter", 1);
      }
      return 0;

    case "multikills":
      if(!isDefined(param_01.lastkilltime) || !isDefined(param_01.lastmultikilltime)) {
        return 0;
      }

      if(gettime() != param_01.lastkilltime) {
        param_01.lastkilltime = gettime();
        return 0;
      } else if(gettime() == param_01.lastkilltime && param_01.lastmultikilltime != gettime()) {
        scripts\cp\zombies\solo_challenges::update_challenge("multikills", 1, undefined, undefined, undefined, undefined, undefined, undefined, undefined, param_01);
        param_01.lastmultikilltime = gettime();
        param_01.lastkilltime = gettime() + 50;
        return 0;
      }
      return 0;

    case "area_kills":
      if(isDefined(level.challenge_area_marker)) {
        if(isDefined(param_01) && isplayer(param_01)) {
          if(distancesquared(param_01.origin, level.challenge_area_marker.origin) < level.challenge_area_marker.fgetarg) {
            scripts\cp\zombies\solo_challenges::update_challenge("area_kills", 1);
          }
        }
      }
      return 0;

    case "kill_zombiewhodamagedme":
      if(!isplayer(param_01)) {
        return 0;
      }

      if(scripts\engine\utility::array_contains(self.damaged_players, param_01)) {
        scripts\cp\zombies\solo_challenges::update_challenge("kill_zombiewhodamagedme", 1);
      }

      break;
  }

  return 1;
}

is_distance_shot(param_00, param_01, param_02, param_03) {
  if(isplayer(param_00) && isalive(param_00) && !param_00 scripts\cp\utility::isusingremote()) {
    if(param_03 == "long_shot") {
      return distancesquared(param_00.origin, param_02.origin) >= 90000;
    } else if(param_03 == "close_shot") {
      return distancesquared(param_00.origin, param_02.origin) <= 90000;
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

update_no_bleedout(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(scripts\engine\utility::flag("pause_challenges")) {
    return;
  }

  self.success = 0;
  scripts\cp\cp_challenge::deactivate_current_challenge();
}

activate_no_laststand() {}

update_no_laststand(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(scripts\engine\utility::flag("pause_challenges")) {
    return;
  }

  self.success = 0;
  scripts\cp\cp_challenge::deactivate_current_challenge();
}

challenge_interaction_cooldown(param_00, param_01) {
  self endon("disconnect");
  scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(param_00, self);
  param_00.power hudoutlineenableforclient(self, 1, 1, 1);
  for(var_02 = 0; var_02 < param_01; var_02++) {
    level scripts\engine\utility::waittill_either("event_wave_starting", "regular_wave_starting");
  }

  scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(param_00, self);
  param_00.power hudoutlineenableforclient(self, 3, 1, 1);
}
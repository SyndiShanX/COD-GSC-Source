/*****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_disco\kung_fu_mode.gsc
*****************************************************/

setup_kung_fu_powers() {
  scripts\engine\utility::flag_wait("interactions_initialized");
  scripts\cp\powers\coop_powers::powersetupfunctions("power_holdHere", ::blank, ::blank, ::use_hold_here, undefined, "hold_here_used", undefined);
  scripts\cp\powers\coop_powers::powersetupfunctions("power_ohStop", ::blank, ::blank, ::use_oh_stop, undefined, undefined, undefined);
  scripts\cp\powers\coop_powers::powersetupfunctions("power_headPinch", ::blank, ::blank, ::use_head_pinch, undefined, "head_pinch_used", undefined);
  scripts\cp\powers\coop_powers::powersetupfunctions("power_fingerGun", ::blank, ::blank, ::use_finger_gun, undefined, "finger_gun_used", undefined);
  scripts\cp\powers\coop_powers::powersetupfunctions("power_neckSlice", ::blank, ::blank, ::use_neck_slice, undefined, undefined, undefined);
  scripts\cp\powers\coop_powers::powersetupfunctions("power_wipeAway", ::blank, ::blank, ::use_wipe_away, undefined, "wipe_away_used", undefined);
  level.kungfu_weapons[0] = ["iw7_fists_zm_tiger", "iw7_fists_zm_monkey", "iw7_fists_zm_snake", "iw7_fists_zm_crane", "iw7_fists_zm_dragon"];
  level.kungfu_weapons[1] = ["power_shuriken_tiger", "power_fireball", "power_shuriken_snake", "iw7_shuriken_dragon_proj", "iw7_shuriken_tiger_proj", "iw7_shuriken_snake_proj", "iw7_shuriken_crane_proj", "power_shuriken_crane", "power_shuriken_dragon"];
  level.kungfu_weapons[2] = ["power_black_hole_tiger", "power_fingerGun", "power_summon_pet_snake", "power_holdHere", "power_neckSlice", "power_headPinch", "power_fingerGun", "power_fingerGun", "power_wipeAway", "power_wipeAway"];
  level.frozenzombiefunc = ::freeze_zombie;
}

iskungfuweapon(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  for(var_1 = 0; var_1 < level.kungfu_weapons.size; var_1++) {
    if(scripts\engine\utility::array_contains(level.kungfu_weapons[var_1], var_0)) {
      return 1;
    }
  }

  return 0;
}

set_gourd(var_0) {
  var_0 playlocalsound("zmb_kung_fu_gourd_pickup");
  var_0 thread watchforrightdpad(var_0);
  var_0.has_gourd = 1;
}

unset_gourd(var_0) {
  var_0 notify("kill_gourd_watchers");
  var_0.has_gourd = undefined;
}

use_gourd(var_0) {
  var_0 endon("death");
  var_0 endon("last_stand");
  var_0 endon("disconnect");
  var_0.is_using_gourd = 1;
  if(var_0 getstance() == "prone") {
    var_0 setstance("crouch");
  }

  var_0 scripts\engine\utility::allow_melee(0);
  var_1 = var_0 getcurrentweapon();
  level thread use_gourd_handle_early_end(var_0);
  if(issubstr(var_1, "nunchucks") || issubstr(var_1, "katana")) {
    wait(0.75);
  }

  var_0 thread unset_gourd(var_0);
  var_0 thread playgourdgesture(var_0);
  var_0 thread sfx_use_gourd();
  if(isDefined(level.use_gourd_func)) {
    thread[[level.use_gourd_func]](var_0);
  }

  wait(3.5);
  var_0 scripts\engine\utility::allow_melee(1);
  var_0.is_using_gourd = 0;
  var_0 notify("no_early_end");
  thread start_tracking_kung_fu_discipline(var_0);
}

use_gourd_handle_early_end(var_0) {
  var_0 endon("disconnect");
  var_0 endon("no_early_end");
  var_1 = var_0 scripts\engine\utility::waittill_any_return("death", "last_stand");
  var_0 scripts\engine\utility::allow_melee(1);
  var_0.is_using_gourd = 0;
}

sfx_use_gourd() {
  self playlocalsound("zmb_challenge_gourd_use");
  self playlocalsound("zmb_kung_fu_gourd_drink");
}

playgourdgesture(var_0) {
  var_1 = "crane";
  if(isDefined(self.kung_fu_progression.active_discipline)) {
    var_1 = self.kung_fu_progression.active_discipline;
  }

  thread play_gourd_vo(var_0, var_1);
  thread scripts\cp\utility::firegesturegrenade(var_0, "iw7_gourd_zm_" + var_1);
}

attach_fake_gourd(var_0) {
  var_0 attach("weapon_zmb_gourd_wm", "tag_accessory_left", 1);
  wait(3);
  var_0 detach("weapon_zmb_gourd_wm", "tag_accessory_left");
}

play_gourd_vo(var_0, var_1) {
  switch (var_1) {
    case "crane":
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("gourd_crane", "zmb_comment_vo", "medium", 10, 0, 0, 1, 50);
      break;

    case "tiger":
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("gourd_tiger", "zmb_comment_vo", "medium", 10, 0, 0, 1, 50);
      break;

    case "dragon":
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("gourd_dragon", "zmb_comment_vo", "medium", 10, 0, 0, 1, 50);
      break;

    case "snake":
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("gourd_snake", "zmb_comment_vo", "medium", 10, 0, 0, 1, 50);
      break;

    default:
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("gourd_misc", "zmb_comment_vo", "medium", 10, 0, 0, 1, 50);
      break;
  }
}

watchforrightdpad(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("kill_gourd_watchers");
  var_0 setclientomnvar("zm_ui_general_two", 0);
  wait(0.1);
  var_0 setclientomnvar("zm_ui_general_two", 1);
  var_0 notifyonplayercommand("use_gourd", "+actionslot 4");
  for(;;) {
    var_0 waittill("use_gourd");
    if(can_enter_kung_fu_mode(var_0)) {
      break;
    }

    wait(0.1);
  }

  var_0 setclientomnvar("zm_ui_general_two", 0);
  if(!scripts\engine\utility::istrue(var_0.first_kung_fu)) {
    var_0.first_kung_fu = 1;
    if(!scripts\engine\utility::flag("first_kung_fu_mode")) {
      scripts\engine\utility::flag_set("first_kung_fu_mode");
      increase_trainer_interaction_progression();
    }
  }

  var_0 thread use_gourd(var_0);
}

can_enter_kung_fu_mode(var_0) {
  if(scripts\engine\utility::istrue(var_0.playing_ghosts_n_skulls)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(var_0.inlaststand)) {
    return 0;
  }

  if(!isalive(var_0)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(var_0.in_afterlife_arcade)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(var_0.isusingsupercard)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(var_0.playing_game)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(var_0.isrewinding)) {
    return 0;
  }

  if(scripts\mp\agents\zombie\zombie_util::isplayerteleporting(var_0)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(level.disable_kung_fu_mode)) {
    return 0;
  }

  if(isDefined(level.clock_interaction)) {
    if(isDefined(level.clock_interaction.clock_owner) && level.clock_interaction.clock_owner == var_0) {
      return 0;
    }
  }

  if(isDefined(level.clock_interaction_q2)) {
    if(isDefined(level.clock_interaction_q2.clock_owner) && level.clock_interaction_q2.clock_owner == var_0) {
      return 0;
    }
  }

  if(isDefined(level.clock_interaction_q3)) {
    if(isDefined(level.clock_interaction_q3.clock_owner) && level.clock_interaction_q3.clock_owner == var_0) {
      return 0;
    }
  }

  if(scripts\engine\utility::istrue(self.start_breaking_clock)) {
    return 0;
  }

  return 1;
}

usegourdhint(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("use_gourd");
  var_0 endon("kill_gourd_watchers");
  var_0.gourd_hint_display = 0;
  while(var_0.gourd_hint_display < 5) {
    var_0 scripts\cp\utility::setlowermessage("msg_kung_fu_exit_hint", &"CP_DISCO_USE_GOURD_HINT", 4);
    var_0.gourd_hint_display = var_0.gourd_hint_display + 1;
    wait(randomfloatrange(5, 10));
  }
}

use_wipe_away(var_0) {
  self endon("disconnect");
  scripts\cp\powers\coop_powers::power_disablepower();
  var_1 = 250;
  if(self.chi_meter_amount - var_1 <= 0) {
    self.kung_fu_exit_delay = 1;
  }

  self playlocalsound("disco_gest_push_away");
  if(isDefined(self.kung_fu_progression.active_discipline)) {
    var_2 = self.kung_fu_progression.active_discipline;
    var_3 = level.kung_fu_upgrades[var_2].melee_weapon;
  } else {
    var_3 = scripts\cp\utility::getvalidtakeweapon();
  }

  thread run_wipe_away_effects(self, var_3);
  scripts\cp\zombies\zombies_chi_meter::chi_meter_kill_decrement(250);
  wait_for_gesture_length("ges_plyr_gesture041");
  self.kung_fu_exit_delay = 0;
  scripts\cp\powers\coop_powers::power_enablepower();
  self notify("wipe_away_used", 1);
}

run_wipe_away_effects(var_0, var_1) {
  var_0 endon("disconnect");
  wait(0.2);
  if(scripts\engine\utility::istrue(self.crane_super)) {
    return;
  }

  var_2 = getenemiesleftofcenter(20, 750, 3);
  foreach(var_4 in var_2) {
    if(!var_4 scripts\cp\utility::agentisinstakillimmune()) {
      var_4 thread throw_zombie_left(var_4.maxhealth, var_0, var_0, var_1);
    }
  }

  wait(0.6);
  var_2 = getenemiesleftofcenter(15, 750, 2);
  foreach(var_4 in var_2) {
    if(!var_4 scripts\cp\utility::agentisinstakillimmune()) {
      var_4 thread throw_zombie_left(var_4.maxhealth, var_0, var_0, var_1);
    }
  }

  wait(0.3);
  var_2 = getenemiesleftofcenter(10, 750, 1);
  foreach(var_4 in var_2) {
    if(!var_4 scripts\cp\utility::agentisinstakillimmune()) {
      var_4 thread throw_zombie_left(var_4.maxhealth, var_0, var_0, var_1);
    }
  }
}

throw_zombie_left(var_0, var_1, var_2, var_3) {
  self endon("death");
  self.do_immediate_ragdoll = 1;
  self.customdeath = 1;
  self.disable_armor = 1;
  var_4 = vectortoangles(self.origin - var_2.origin);
  var_5 = anglestoleft(var_4);
  var_6 = vectornormalize(var_5) * 2000;
  self setvelocity(var_6 + (0, 0, 200));
  wait(0.1);
  self dodamage(self.health + 1000, var_1.origin, var_2, var_1, "MOD_UNKNOWN", var_3);
}

use_hold_here(var_0) {
  self endon("disconnect");
  scripts\cp\powers\coop_powers::power_disablepower();
  thread run_hold_here_effects(self);
  wait_for_gesture_length("ges_plyr_gesture015");
  self.kung_fu_exit_delay = 0;
  scripts\cp\powers\coop_powers::power_enablepower();
  self notify("hold_here_used", 1);
}

run_hold_here_effects(var_0, var_1) {
  var_0 endon("disconnect");
  wait(0.3);
  if(scripts\engine\utility::istrue(self.crane_super)) {
    return;
  }

  var_2 = 250;
  if(self.chi_meter_amount - var_2 <= 0) {
    self.kung_fu_exit_delay = 1;
  }

  scripts\cp\zombies\zombies_chi_meter::chi_meter_kill_decrement(250);
  if(isDefined(self.kung_fu_progression.active_discipline)) {
    var_3 = self.kung_fu_progression.active_discipline;
    var_1 = level.kung_fu_upgrades[var_3].melee_weapon;
  } else {
    var_1 = scripts\cp\utility::getvalidtakeweapon();
  }

  var_4 = get_enemies_within_fov(50, 750, 8);
  var_4 = sortbydistance(var_4, self.origin);
  foreach(var_6 in var_4) {
    if(!var_6 scripts\cp\utility::agentisinstakillimmune()) {
      var_6 thread freeze_and_kill(var_6.maxhealth, var_0, var_0, var_1);
      wait(0.1);
    }
  }
}

freeze_and_kill(var_0, var_1, var_2, var_3) {
  self.isfrozen = 1;
  self.crane_chi_kill = 1;
  if(self.agent_type == "karatemaster") {
    thread freeze_zombie(self);
  }

  wait(1);
  self.isfrozen = undefined;
  self dodamage(self.health + 1000, var_1.origin, var_2, var_1, "MOD_UNKNOWN", var_3);
}

freeze_zombie(var_0) {
  var_0 endon("death");
  var_0.isfrozen = 1;
  var_0.precacheleaderboards = 1;
  var_0.nocorpse = 1;
  var_0.full_gib = 1;
  var_0.noturnanims = 1;
  if(scripts\engine\utility::istrue(var_0.crane_chi_kill)) {
    thread scripts\engine\utility::play_sound_in_space("chi_crane_freeze", var_0.origin);
    var_0 setscriptablepartstate("crane_chi_fx", "active", 1);
  }

  wait(10.1);
  var_0.isfrozen = undefined;
}

use_oh_stop(var_0) {
  scripts\cp\zombies\zombies_chi_meter::chi_meter_kill_decrement(250);
}

use_head_pinch(var_0) {
  self endon("disconnect");
  scripts\cp\powers\coop_powers::power_disablepower();
  var_1 = 250;
  if(self.chi_meter_amount - var_1 <= 0) {
    self.kung_fu_exit_delay = 1;
  }

  if(isDefined(self.kung_fu_progression.active_discipline)) {
    var_2 = self.kung_fu_progression.active_discipline;
    var_3 = level.kung_fu_upgrades[var_2].melee_weapon;
  } else {
    var_3 = scripts\cp\utility::getvalidtakeweapon();
  }

  thread run_head_pinch_effects(self, var_3);
  scripts\cp\zombies\zombies_chi_meter::chi_meter_kill_decrement(250);
  wait_for_gesture_length("ges_plyr_gesture002");
  self.kung_fu_exit_delay = 0;
  scripts\cp\powers\coop_powers::power_enablepower();
  self notify("head_pinch_used", 1);
}

run_head_pinch_effects(var_0, var_1) {
  var_0 endon("last_stand");
  var_0 endon("disconnect");
  wait(1);
  var_2 = get_enemies_within_reticle(750, 10);
  foreach(var_5, var_4 in var_2) {
    if(!var_4 scripts\cp\utility::agentisinstakillimmune()) {
      thread apply_head_pinch_effects(var_4, var_5, var_1, var_0);
    }
  }

  wait(0.75);
  var_2 = get_enemies_within_reticle(750, 10);
  foreach(var_5, var_4 in var_2) {
    if(!var_4 scripts\cp\utility::agentisinstakillimmune()) {
      thread apply_head_pinch_effects(var_4, var_5, var_1, var_0);
    }
  }

  wait(0.4);
  var_2 = get_enemies_within_reticle(750, 10);
  foreach(var_5, var_4 in var_2) {
    if(!var_4 scripts\cp\utility::agentisinstakillimmune()) {
      thread apply_head_pinch_effects(var_4, var_5, var_1, var_0);
    }
  }
}

apply_head_pinch_effects(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  var_0.pinched = 1;
  if(isDefined(var_0.headmodel)) {
    var_0 detach(var_0.headmodel);
  }

  var_0.precacheleaderboards = 1;
  var_0 dodamage(1, var_0.origin, var_3, var_3, "MOD_UNKNOWN", var_2);
  playFX(level._effect["head_loss"], var_0 gettagorigin("j_head"));
  var_0 setscriptablepartstate("head", "detached");
  wait(0.5);
  var_0 dodamage(var_0.health + 1000, var_0.origin, var_3, var_3, "MOD_UNKNOWN", var_2);
}

get_enemies_within_reticle(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 6;
  }

  var_2 = [];
  var_3 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_4 = scripts\engine\utility::get_array_of_closest(self.origin, var_3, undefined, 24, var_0, 1);
  var_5 = anglesToForward(self.angles);
  var_6 = vectornormalize(var_5) * -35;
  var_7 = 0;
  foreach(var_9 in var_4) {
    if(scripts\engine\utility::istrue(var_9.pinched)) {
      continue;
    }

    var_10 = 0;
    var_11 = var_9.origin;
    var_12 = self worldpointinreticle_circle(var_9 getEye(), 65, 40);
    if(var_12) {
      if(isDefined(var_0)) {
        var_13 = distance2d(self.origin, var_11);
        if(var_13 < var_0) {
          var_10 = 1;
        }
      } else {
        var_10 = 1;
      }
    }

    if(var_10 && var_2.size < var_1) {
      var_2[var_2.size] = var_9;
      var_4 = scripts\engine\utility::array_remove(var_4, var_9);
    }

    if(var_2.size >= var_1) {
      break;
    }
  }

  return var_2;
}

use_finger_gun(var_0) {
  self endon("disconnect");
  scripts\cp\powers\coop_powers::power_disablepower();
  var_1 = 250;
  if(self.chi_meter_amount - var_1 <= 0) {
    self.kung_fu_exit_delay = 1;
  }

  self playlocalsound("disco_gest_fingergun");
  if(isDefined(self.kung_fu_progression.active_discipline)) {
    var_2 = self.kung_fu_progression.active_discipline;
    var_3 = level.kung_fu_upgrades[var_2].melee_weapon;
  } else {
    var_3 = scripts\cp\utility::getvalidtakeweapon();
  }

  var_4 = get_enemies_within_fov(15, 750, 2);
  foreach(var_7, var_6 in var_4) {
    if(!var_6 scripts\cp\utility::agentisinstakillimmune()) {
      thread apply_finger_gun_effects(var_6, var_7, var_3);
    }
  }

  scripts\cp\zombies\zombies_chi_meter::chi_meter_kill_decrement(100);
  wait_for_gesture_length("ges_plyr_gesture010");
  self.kung_fu_exit_delay = 0;
  scripts\cp\powers\coop_powers::power_enablepower();
  self notify("finger_gun_used", 1);
}

apply_finger_gun_effects(var_0, var_1, var_2) {
  var_0 endon("death");
  switch (var_1) {
    case 1:
      wait(0.4);
      break;

    case 0:
      wait(0.5);
      break;

    default:
      wait(0.5);
      break;
  }

  var_0 thread throw_zombie(var_0.maxhealth, self, self, 0, var_2);
}

wait_for_gesture_length(var_0) {
  self endon("disconnect");
  self endon("last_stand");
  while(self isgestureplaying(var_0)) {
    scripts\engine\utility::waitframe();
  }
}

throw_zombie(var_0, var_1, var_2, var_3, var_4) {
  self.do_immediate_ragdoll = 1;
  self.customdeath = 1;
  self.disable_armor = 1;
  wait(0.05);
  if(scripts\engine\utility::istrue(var_3)) {
    self.nocorpse = 1;
    self.full_gib = 1;
    if(isDefined(var_2)) {
      self dodamage(self.health + 1000, self.origin, var_2, var_2, "MOD_UNKNOWN", var_4);
      return;
    }

    self dodamage(self.health + 1000, self.origin, level.players[0], level.players[0], "MOD_UNKNOWN", var_4);
    return;
  }

  self setvelocity(vectornormalize(self.origin - var_1.origin) * 500 + (0, 0, 100));
  wait(0.1);
  if(isDefined(var_2)) {
    self dodamage(self.health + 1000, var_1.origin, var_2, var_1, "MOD_UNKNOWN", var_4);
    return;
  }

  self dodamage(self.health + 1000, var_1.origin, var_1, var_1, "MOD_UNKNOWN", var_4);
}

use_neck_slice(var_0) {
  self endon("disconnect");
  scripts\cp\powers\coop_powers::power_disablepower();
  thread run_neck_slice_logic();
  var_1 = self getgestureanimlength("ges_plyr_gesture010");
  wait(var_1 - 1);
  self.kung_fu_exit_delay = 0;
  scripts\cp\powers\coop_powers::power_enablepower();
  self notify("neck_slice_used", 1);
}

run_neck_slice_logic() {
  self endon("disconnect");
  wait(0.3);
  if(scripts\engine\utility::istrue(self.dragon_super)) {
    return;
  }

  var_0 = 250;
  if(self.chi_meter_amount - var_0 <= 0) {
    self.kung_fu_exit_delay = 1;
  }

  self playlocalsound("chi_dragon_activate");
  if(isDefined(self.kung_fu_progression.active_discipline)) {
    var_1 = self.kung_fu_progression.active_discipline;
    var_2 = level.kung_fu_upgrades[var_1].melee_weapon;
  } else {
    var_2 = scripts\cp\utility::getvalidtakeweapon();
  }

  var_3 = 1;
  var_4 = 5;
  for(;;) {
    if(var_3 > var_4) {
      break;
    }

    var_5 = get_enemies_within_fov(50, 750, 8);
    var_6 = [];
    foreach(var_8 in var_5) {
      if(!scripts\engine\utility::istrue(var_8.dragon_chi)) {
        var_6[var_6.size] = var_8;
      }
    }

    var_5 = var_6;
    if(var_5.size > 0) {
      var_5 = sortbydistance(var_5, self.origin);
      var_10 = var_5[0];
      if(!var_10 scripts\cp\utility::agentisinstakillimmune()) {
        if(var_3 == 0) {
          thread scripts\engine\utility::play_sound_in_space("chi_dragon_strike_first", var_10.origin);
        } else {
          thread scripts\engine\utility::play_sound_in_space("chi_dragon_strike", var_10.origin);
        }

        thread remove_head_and_kill(var_10, var_2);
      }
    }

    var_3++;
    wait(0.1);
  }

  scripts\cp\zombies\zombies_chi_meter::chi_meter_kill_decrement(250);
}

remove_head_and_kill(var_0, var_1) {
  var_0 endon("death");
  var_0.scripted_mode = 1;
  var_0.dragon_chi = 1;
  var_0 give_mp_super_weapon(self.origin);
  wait(0.1);
  var_0 setscriptablepartstate("dragon_chi_fx", "active", 1);
  wait(0.4);
  thread scripts\engine\utility::play_sound_in_space("chi_dragon_blood", var_0.origin);
  var_2 = playFXOnTag(level._effect["blood_fountain"], var_0, "J_neck");
  var_0.scripted_mode = 1;
  var_0 give_mp_super_weapon(var_0.origin);
  wait(0.5);
  var_0 thread kill_zombie(self, var_1);
}

kill_zombie(var_0, var_1) {
  self.do_immediate_ragdoll = 1;
  self.customdeath = 1;
  self.disable_armor = 1;
  self.dragon_chi = undefined;
  wait(0.05);
  if(isDefined(var_0)) {
    self dodamage(self.health + 1000, self.origin, var_0, var_0, "MOD_UNKNOWN", var_1);
    return;
  }

  self dodamage(self.health + 1000, self.origin, level.players[0], level.players[0], "MOD_UNKNOWN", var_1);
}

getenemiesleftofcenter(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 6;
  }

  var_3 = [];
  var_4 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_5 = scripts\engine\utility::get_array_of_closest(self.origin, var_4, undefined, 24, var_1, 1);
  var_6 = anglesToForward(self.angles);
  var_7 = vectornormalize(var_6) * -35;
  var_8 = 0;
  var_9 = anglestoup(self.angles);
  for(var_10 = 1; var_10 <= var_0; var_10++) {
    if(var_5.size < 1) {
      break;
    }

    if(var_8) {
      break;
    }

    var_11 = cos(var_10);
    foreach(var_13 in var_5) {
      var_14 = 0;
      var_15 = var_13.origin;
      var_10 = vectornormalize(var_13.origin - self.origin);
      var_11 = scripts\engine\utility::anglebetweenvectorssigned(var_6, var_10, var_9);
      if(var_11 > 0 && var_11 < 30) {
        if(isDefined(var_1)) {
          var_12 = distance2d(self.origin, var_15);
          if(var_12 < var_1) {
            var_14 = 1;
          }
        } else {
          var_14 = 1;
        }
      }

      if(var_14 && var_3.size < var_2) {
        var_3[var_3.size] = var_13;
        var_5 = scripts\engine\utility::array_remove(var_5, var_13);
      }

      if(var_3.size >= var_2) {
        var_8 = 1;
        break;
      }
    }
  }

  return var_3;
}

get_enemies_within_fov(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 6;
  }

  var_3 = [];
  var_4 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_5 = scripts\engine\utility::get_array_of_closest(self.origin, var_4, undefined, 24, var_1, 1);
  var_6 = anglesToForward(self.angles);
  var_7 = vectornormalize(var_6) * -35;
  var_8 = 0;
  for(var_9 = 1; var_9 <= var_0; var_9++) {
    if(var_5.size < 1) {
      break;
    }

    if(var_8) {
      break;
    }

    var_10 = cos(var_9);
    foreach(var_12 in var_5) {
      var_13 = 0;
      var_14 = var_12.origin;
      var_15 = scripts\engine\utility::within_fov(self getEye() + var_7, self.angles, var_14 + (0, 0, 30), var_10);
      if(var_15) {
        if(isDefined(var_1)) {
          var_10 = distance2d(self.origin, var_14);
          if(var_10 < var_1) {
            var_13 = 1;
          }
        } else {
          var_13 = 1;
        }
      }

      if(var_13 && var_3.size < var_2) {
        var_3[var_3.size] = var_12;
        var_5 = scripts\engine\utility::array_remove(var_5, var_12);
      }

      if(var_3.size >= var_2) {
        var_8 = 1;
        break;
      }
    }
  }

  return var_3;
}

use_fireball(var_0) {
  scripts\cp\zombies\zombies_chi_meter::chi_meter_kill_decrement(100);
}

blank(var_0) {}

setup_kung_fu_mode_upgrades() {
  level.kung_fu_upgrades = [];
  register_kung_fu_upgrade("tiger", "iw7_fists_zm_tiger", "power_shuriken_tiger", "power_headPinch", "power_black_hole_tiger", "power_repulsor");
  register_kung_fu_upgrade("monkey", "iw7_fists_zm_monkey", "power_fireball", "power_fingerGun", "power_fingerGun", "power_repulsor");
  register_kung_fu_upgrade("snake", "iw7_fists_zm_snake", "power_shuriken_snake", "power_fingerGun", "power_summon_pet_snake", "power_repulsor");
  register_kung_fu_upgrade("crane", "iw7_fists_zm_crane", "power_shuriken_crane", "power_wipeAway", "power_holdHere", "power_repulsor");
  register_kung_fu_upgrade("dragon", "iw7_fists_zm_dragon", "power_shuriken_dragon", "power_wipeAway", "power_neckSlice", "power_repulsor");
}

register_kung_fu_upgrade(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6.melee_weapon = var_1;
  var_6.rb = var_2;
  var_6.lb = var_4;
  var_6.super = var_5;
  level.kung_fu_upgrades[var_0] = var_6;
}

setup_player_kung_fu_progression(var_0) {
  var_1 = spawnStruct();
  var_1.disciplines_xp = [];
  var_1.disciplines_xp["tiger"] = 0;
  var_1.disciplines_xp["monkey"] = 0;
  var_1.disciplines_xp["snake"] = 0;
  var_1.disciplines_xp["crane"] = 0;
  var_1.disciplines_xp["dragon"] = 0;
  var_1.disciplines_levels = [];
  var_1.disciplines_levels["tiger"] = 0;
  var_1.disciplines_levels["monkey"] = 0;
  var_1.disciplines_levels["snake"] = 0;
  var_1.disciplines_levels["crane"] = 0;
  var_1.disciplines_levels["dragon"] = 0;
  var_1.challenge_progress = [];
  var_1.challenge_progress["tiger"] = 0;
  var_1.challenge_progress["monkey"] = 0;
  var_1.challenge_progress["snake"] = 0;
  var_1.challenge_progress["crane"] = 0;
  var_1.challenge_progress["dragon"] = 0;
  var_1.has_used = [];
  var_1.has_used["tiger"] = 0;
  var_1.has_used["monkey"] = 0;
  var_1.has_used["snake"] = 0;
  var_1.has_used["crane"] = 0;
  var_1.has_used["dragon"] = 0;
  var_1.disciplines_levels["active"] = "none";
  var_0.kung_fu_progression = var_1;
}

ma_style_init() {
  var_0 = scripts\engine\utility::getStructArray("martial_arts_animals", "script_noteworthy");
  level.all_animal_structs = [];
  level.special_mode_activation_funcs["martial_arts_animals"] = ::setstylescriptables;
  level.normal_mode_activation_funcs["martial_arts_animals"] = ::setstylescriptables;
  foreach(var_2 in var_0) {
    switch (var_2.name) {
      case "tiger":
        var_2.gourd_model = "tag_origin_ma_selection";
        break;

      case "snake":
        var_2.gourd_model = "tag_origin_ma_selection";
        break;

      case "crane":
        var_2.gourd_model = "tag_origin_ma_selection";
        break;

      case "dragon":
        var_2.gourd_model = "tag_origin_ma_selection";
        break;
    }

    if(isDefined(var_2.target)) {
      var_3 = scripts\engine\utility::getstruct(var_2.target, "targetname");
      var_3.origin = var_3.origin + (0, 0, 8);
      var_3.gourd_model = var_2.gourd_model;
      var_3.name = var_2.name;
    }

    scripts\cp\maps\cp_disco\cp_disco::addtopersonalinteractionlist(var_2);
    level.all_animal_structs[level.all_animal_structs.size] = var_2;
  }
}

setstylescriptables(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::istrue(var_3.kung_fu_mode);
  var_5 = scripts\engine\utility::istrue(var_3.kung_fu_cooldown);
  if(!isDefined(var_0.model) || isDefined(var_0.model) && var_0.model != var_1.gourd_model) {
    var_0 setModel(var_1.gourd_model);
  }

  var_6 = 0;
  if(isDefined(var_3.kung_fu_progression.active_discipline) && getactivekungfustyle(var_3) == var_1.name) {
    var_6 = 1;
  }

  if(!scripts\engine\utility::flag("skq_phase_1") || var_4 || var_5 || var_6 && isDefined(var_3.has_gourd)) {
    var_0 setscriptablepartstate("base_model", var_1.name);
    return;
  }

  var_0 setscriptablepartstate("base_model", "alt_" + var_1.name);
}

guord_interaction_init() {
  var_0 = scripts\engine\utility::getStructArray("gourd_station", "script_noteworthy");
  level.all_gourds = [];
  foreach(var_2 in var_0) {
    if(isDefined(var_2.target)) {
      var_3 = scripts\engine\utility::getstruct(var_2.target, "targetname");
      var_3.origin = var_3.origin + (0, 0, 2);
    } else {
      var_2.origin = var_2.origin + (0, 0, 2);
      var_2.groupname = "locOverride";
    }

    var_2.alt = 1;
    var_2.currentlyownedby = [];
    level.all_gourds[level.all_gourds.size] = var_2;
    scripts\cp\maps\cp_disco\cp_disco::addtopersonalinteractionlist(var_2);
  }

  level.special_mode_activation_funcs["gourd_station"] = ::setgourdstationscriptables;
  level.normal_mode_activation_funcs["gourd_station"] = ::setgourdstationscriptables;
}

setgourdonplayerconnect() {
  level endon("game_ended");
  foreach(var_1 in level.players) {
    foreach(var_3 in level.all_gourds) {
      scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_3, var_1);
    }
  }

  for(;;) {
    level waittill("connected", var_6);
    var_6 thread removegourdswhenable(var_6);
  }
}

removegourdswhenable(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  while(!isDefined(var_0.disabled_interactions)) {
    scripts\engine\utility::waitframe();
  }

  foreach(var_2 in level.all_gourds) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_2, var_0);
  }
}

setgourdstationscriptables(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::istrue(var_3.kung_fu_mode);
  var_5 = scripts\engine\utility::istrue(var_3.kung_fu_cooldown);
  if(!isDefined(var_0.model) || isDefined(var_0.model) && var_0.model != "tag_origin_ma_selection") {
    var_0 setModel("tag_origin_ma_selection");
  }

  var_6 = getactivekungfustyle(var_3);
  var_7 = isDefined(var_6) && isDefined(var_1.alt) && var_3.kung_fu_progression.disciplines_levels[var_6] >= 2;
  var_7 = !var_5 && !var_4 && !isDefined(var_3.has_gourd);
  if(isDefined(var_6)) {
    if(var_7) {
      var_0 setscriptablepartstate("base_model", "alt_" + var_6);
      return;
    }

    var_0 setscriptablepartstate("base_model", var_6);
    return;
  }

  var_0 setscriptablepartstate("base_model", "dragon");
}

init_martial_arts_trainer() {
  scripts\engine\utility::flag_init("first_kung_fu_mode");
  var_0 = scripts\engine\utility::getStructArray("martial_arts_trainer", "script_noteworthy");
  level.current_trainer_quest = 0;
  level.current_trainer_quest_backup = 0;
  level.trainer_quests = [];
  level.trainer_quests[level.trainer_quests.size] = ::first_trainer_interaction;
  level.trainer_quests[level.trainer_quests.size] = ::complete_trainer_quest_1;
  level.trainer_quests[level.trainer_quests.size] = ::start_phase_2_task1;
  level.trainer_quests[level.trainer_quests.size] = ::start_phase_2_task2;
  level.trainer_quests[level.trainer_quests.size] = ::start_phase_2_task3;
  level.trainer_quests[level.trainer_quests.size] = ::completephase3;
  level.trainer = getent("ma_trainer", "targetname");
  level.trainer.origin = level.trainer.origin + (25, 0, -25);
  if(isDefined(level.trainer)) {
    level.trainer thread handle_trainer_anims();
  }
}

first_trainer_interaction() {
  scripts\engine\utility::flag_set("skq_phase_1");
}

complete_trainer_quest_1() {
  if(scripts\engine\utility::flag("skq_phase_1")) {
    increase_trainer_interaction_progression();
    [[level.trainer_quests[level.current_trainer_quest]]]();
    return;
  }

  foreach(var_1 in level.players) {
    var_2 = ["pam_generic_response", "pam_return_nothing"];
    if(isDefined(var_1)) {
      var_1 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_2), "pam_dialogue_vo", "highest", 100, 1);
    }
  }

  disable_trainer_interactions();
  level thread wait_for_trainer_challenge();
}

wait_for_trainer_challenge() {
  level endon("game_ended");
  var_0 = ["snake", "tiger", "crane", "dragon", "monkey"];
  var_1 = 0;
  while(!var_1) {
    foreach(var_3 in var_0) {
      foreach(var_5 in level.players) {
        if(var_5.kung_fu_progression.disciplines_levels[var_3] >= 1) {
          var_1 = 1;
          break;
        }
      }

      if(var_1) {
        break;
      }
    }

    if(var_1) {
      break;
    }

    wait(1);
  }

  wait(0.5);
  enable_trainer_interactions();
  increase_trainer_interaction_progression();
}

disable_trainer_interactions() {
  level.current_trainer_quest = -1;
}

enable_trainer_interactions() {
  level.current_trainer_quest = level.current_trainer_quest_backup;
}

increase_trainer_interaction_progression() {
  enable_trainer_interactions();
  level.current_trainer_quest++;
  level.current_trainer_quest_backup = level.current_trainer_quest;
}

talk_to_trainer(var_0, var_1) {
  if(level.wave_num < 5) {
    if(isDefined(level.spoke_to_pam_first) && level.spoke_to_pam_first == var_1) {
      var_2 = ["pam_generic_response", "pam_return_nothing"];
      var_1 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_2), "pam_dialogue_vo", "highest", 100, 1);
      return;
    } else if(!isDefined(level.spoke_to_pam_first)) {
      level.spoke_to_pam_first = var_2;
      switch (var_2.vo_prefix) {
        case "p1_":
          var_2 thread scripts\cp\cp_vo::try_to_play_vo("sally_pam_first_1", "pam_dialogue_vo", "highest", 20, 1);
          break;

        case "p2_":
          var_2 thread scripts\cp\cp_vo::try_to_play_vo("pdex_pam_first_1", "pam_dialogue_vo", "highest", 20, 1);
          break;

        case "p3_":
          var_2 thread scripts\cp\cp_vo::try_to_play_vo("andre_pam_first_1", "pam_dialogue_vo", "highest", 20, 1);
          break;

        case "p4_":
          var_2 thread scripts\cp\cp_vo::try_to_play_vo("aj_pam_first_1", "pam_dialogue_vo", "highest", 20, 1);
          break;

        case "p5_":
          var_2 thread scripts\cp\cp_vo::try_to_play_vo("pam_generic_response", "pam_dialogue_vo", "highest", 20, 1);
          break;

        default:
          break;
      }
    }

    return;
  }

  level.spoke_to_pam_first_after_wave_five = var_2;
  foreach(var_4 in level.players) {
    var_4 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_4);
  }

  if(scripts\engine\utility::flag_exist("heart_picked") && scripts\engine\utility::flag("heart_picked") && !scripts\engine\utility::istrue(var_2.played_heart_vo)) {
    if(var_2.vo_prefix == "p5_") {
      var_2 thread scripts\cp\cp_vo::try_to_play_vo("pam_return_rat_heart", "disco_comment_vo");
      var_2.played_heart_vo = 1;
    }
  } else if(scripts\engine\utility::flag_exist("brain_picked") && scripts\engine\utility::flag("brain_picked") && !scripts\engine\utility::istrue(var_2.played_brain_vo)) {
    if(var_2.vo_prefix == "p5_") {
      var_2 thread scripts\cp\cp_vo::try_to_play_vo("pam_return_rat_brain", "disco_comment_vo");
      var_2.played_brain_vo = 1;
    }
  }

  if(isDefined(level.trainer_quests[level.current_trainer_quest])) {
    [[level.trainer_quests[level.current_trainer_quest]]]();
  } else if(isDefined(level.current_trainer_quest) && level.current_trainer_quest == -1) {
    var_2 thread scripts\cp\cp_vo::try_to_play_vo("pam_quest_return_none", "pam_dialogue_vo", "highest", 100, 1);
  } else {
    var_2 = ["pam_generic_response", "pam_return_nothing"];
    var_1 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_5), "pam_dialogue_vo", "highest", 100, 1);
  }

  scripts\cp\cp_vo::remove_from_nag_vo("pam_quest_return");
}

blackcathintfunc(var_0, var_1) {
  return "";
}

blackcatusefunc(var_0, var_1) {
  if(isDefined(var_1.kung_fu_progression.active_discipline)) {
    var_2 = var_1.kung_fu_progression.active_discipline;
  } else {
    return;
  }

  var_1 playlocalsound("part_pickup");
  var_3 = scripts\engine\utility::random(["power_fingerGun", "power_wipeAway", "power_headPinch"]);
  var_1 thread scripts\cp\powers\coop_powers::givepower(var_3, "secondary", undefined, undefined, undefined, 1, 1);
  var_1.chi_meter_adustment = 1000;
  deactivateblackcats(var_1);
}

blackcatinitfunc() {
  level.special_mode_activation_funcs["black_cat"] = ::blackcatinteractions;
  level.normal_mode_activation_funcs["black_cat"] = ::blackcatblank;
  var_0 = scripts\engine\utility::getStructArray("black_cat", "script_noteworthy");
  level.allcatstructs = var_0;
  level thread watchforplayerconnect(var_0);
  foreach(var_2 in var_0) {
    var_2.groupname = "locOverride";
    var_2 scripts\cp\maps\cp_disco\cp_disco::addtopersonalinteractionlist(var_2);
    foreach(var_4 in level.players) {
      var_4 scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_2, var_4);
    }
  }
}

watchforplayerconnect(var_0) {
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_1);
    var_1 thread removeblackcatsfrompents(var_1, var_0);
  }
}

removeblackcatsfrompents(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("disconnect");
  while(!isDefined(var_0.disabled_interactions)) {
    scripts\engine\utility::waitframe();
  }

  foreach(var_3 in var_1) {
    var_0 scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_3, var_0);
  }
}

blackcatblank(var_0, var_1, var_2, var_3) {
  var_0 setModel("tag_origin");
}

blackcatinteractions(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::istrue(var_3.kung_fu_mode);
  if(!isDefined(var_0.model) || isDefined(var_0.model) && var_0.model != "tag_origin_black_cat") {
    var_0 setModel("tag_origin_black_cat");
  }

  if(var_4) {
    var_0 setscriptablepartstate("effects", "active");
  }
}

trainer_hint_func(var_0, var_1) {
  return &"CP_DISCO_CHALLENGES_TALK_TO_TRAINER";
}

start_phase_2_task1() {
  scripts\engine\utility::flag_set("skq_p2t1_0");
}

start_phase_2_task2() {
  scripts\engine\utility::flag_set("skq_p2t1_5");
}

start_phase_2_task3() {
  scripts\engine\utility::flag_set("skq_p2t2_7");
}

completephase3() {
  scripts\engine\utility::flag_set("skq_p2t3_6");
  if(level.players.size == 4) {
    level thread scripts\cp\cp_vo::try_to_play_vo("final_rat_king_1", "rave_dialogue_vo");
    return;
  }

  foreach(var_1 in level.players) {
    var_1 playlocalsound("pg_final_rat_king_1");
  }
}

style_hint_func(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_1.kung_fu_mode)) {
    return "";
  }

  if(scripts\engine\utility::istrue(var_1.kung_fu_cooldown)) {
    return "";
  }

  if(!scripts\engine\utility::flag("skq_phase_1")) {
    return "";
  }

  var_2 = var_1.kung_fu_progression.disciplines_levels[var_0.name];
  var_3 = undefined;
  if(isDefined(var_1.kung_fu_progression.active_discipline)) {
    var_3 = var_1.kung_fu_progression.active_discipline;
  }

  if(isDefined(var_3) && getactivekungfustyle(var_1) == var_0.name && isDefined(var_1.has_gourd)) {
    return "";
  }

  switch (var_0.name) {
    case "snake":
      var_1.interaction_trigger sethintstringparams(&"CP_DISCO_CHALLENGES_SNAKE");
      break;

    case "tiger":
      var_1.interaction_trigger sethintstringparams(&"CP_DISCO_CHALLENGES_TIGER");
      break;

    case "crane":
      var_1.interaction_trigger sethintstringparams(&"CP_DISCO_CHALLENGES_CRANE");
      break;

    case "dragon":
      var_1.interaction_trigger sethintstringparams(&"CP_DISCO_CHALLENGES_DRAGON");
      break;
  }

  if(var_2 < 1 && !isDefined(var_3) || var_3 != var_0.name) {
    return &"CP_DISCO_CHALLENGES_TRAINING_BEGIN";
  }

  if(var_2 < 3) {
    return &"CP_DISCO_CHALLENGES_CONTINUE";
  }

  return &"CP_DISCO_CHALLENGES_DRINK_GOURD";
}

usegourd_hint_func(var_0, var_1) {
  if(!isDefined(var_1.kung_fu_progression.active_discipline)) {
    return "";
  }

  if(scripts\engine\utility::istrue(var_1.has_gourd)) {
    return "";
  }

  if(scripts\engine\utility::istrue(var_1.kung_fu_mode)) {
    return "";
  }

  if(scripts\engine\utility::istrue(var_1.kung_fu_cooldown)) {
    return "";
  }

  var_2 = var_1.kung_fu_progression.active_discipline;
  switch (var_2) {
    case "snake":
      var_1.interaction_trigger sethintstringparams(&"CP_DISCO_CHALLENGES_SNAKE");
      break;

    case "tiger":
      var_1.interaction_trigger sethintstringparams(&"CP_DISCO_CHALLENGES_TIGER");
      break;

    case "crane":
      var_1.interaction_trigger sethintstringparams(&"CP_DISCO_CHALLENGES_CRANE");
      break;

    case "dragon":
      var_1.interaction_trigger sethintstringparams(&"CP_DISCO_CHALLENGES_DRAGON");
      break;
  }

  if(!scripts\engine\utility::istrue(var_1.kung_fu_mode)) {
    return &"CP_DISCO_CHALLENGES_DRINK_GOURD";
  }
}

direct_boss_give_kung_fu(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_1.kung_fu_mode)) {
    return;
  }

  var_1.kung_fu_progression.active_discipline = var_0;
  if(isDefined(var_1.last_animal_interaction)) {
    var_1 setclientomnvar("zm_ui_show_general", 0);
  }

  var_1.kung_fu_progression.disciplines_levels["snake"] = 3;
  var_1.kung_fu_progression.disciplines_levels["tiger"] = 3;
  var_1.kung_fu_progression.disciplines_levels["crane"] = 3;
  var_1.kung_fu_progression.disciplines_levels["dragon"] = 3;
  var_2 = spawnStruct();
  var_1.last_animal_interaction = var_2;
  var_1 unset_gourd(var_1);
  checkgourdstates(var_2, var_1);
  var_3 = var_1.kung_fu_progression.active_discipline;
  var_4 = var_1.kung_fu_progression.disciplines_levels[var_1.kung_fu_progression.active_discipline];
  var_5 = 1;
  switch (var_0) {
    case "tiger":
      var_5 = 3;
      break;

    case "snake":
      var_5 = 6;
      break;

    case "crane":
      var_5 = 4;
      break;

    case "dragon":
      var_5 = 5;
      break;
  }

  var_6 = var_5 + var_4 * 4;
  if(var_4 == 3) {
    var_6 = var_5;
  }

  var_1 setclientomnvar("ui_intel_active_index", var_6);
  var_1 thread set_gourd(var_1);
  var_1 scripts\cp\cp_interaction::refresh_interaction();
  var_1 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_1);
}

choose_martial_arts_style(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_1.kung_fu_mode)) {
    return;
  }

  if(scripts\engine\utility::istrue(var_1.kung_fu_cooldown)) {
    return;
  }

  if(!scripts\engine\utility::flag("skq_phase_1")) {
    return;
  }

  var_1.kung_fu_progression.active_discipline = var_0.name;
  if(isDefined(var_1.last_animal_interaction)) {
    var_1 setclientomnvar("zm_ui_show_general", 0);
  }

  var_1.last_animal_interaction = var_0;
  var_1 unset_gourd(var_1);
  checkgourdstates(var_0, var_1);
  var_2 = var_1.kung_fu_progression.active_discipline;
  var_3 = var_1.kung_fu_progression.disciplines_levels[var_1.kung_fu_progression.active_discipline];
  var_4 = 1;
  switch (var_0.name) {
    case "tiger":
      var_4 = 3;
      var_5 = ["gourd_misc", "gourd_tiger"];
      var_1 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_5), "zmb_comment_vo");
      break;

    case "snake":
      var_4 = 6;
      var_5 = ["gourd_misc", "gourd_snake"];
      var_1 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_5), "zmb_comment_vo");
      break;

    case "crane":
      var_4 = 4;
      var_5 = ["gourd_misc", "gourd_crane"];
      var_1 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_5), "zmb_comment_vo");
      break;

    case "dragon":
      var_4 = 5;
      var_5 = ["gourd_misc", "gourd_dragon"];
      var_1 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_5), "zmb_comment_vo");
      break;
  }

  var_6 = var_4 + var_3 * 4;
  if(var_3 == 3) {
    var_6 = var_4;
  }

  var_1 setclientomnvar("ui_intel_active_index", var_6);
  var_1 thread set_gourd(var_1);
  level thread scripts\cp\maps\cp_disco\cp_disco_challenges::chi_challenge_activate(var_1);
  var_1 scripts\cp\cp_interaction::refresh_interaction();
  var_1 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_1);
  var_1 thread updategourdinteractions(var_0, var_1);
}

checkgourdstates(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_1.kung_fu_cooldown)) {
    return;
  }

  if(scripts\engine\utility::istrue(var_1.has_gourd)) {
    return;
  }

  if(scripts\engine\utility::istrue(var_1.kung_fu_mode)) {
    return;
  }

  foreach(var_3 in level.all_gourds) {
    scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(var_3, var_1);
  }
}

usegourdstation(var_0, var_1) {
  if(!isDefined(var_1.kung_fu_progression.active_discipline)) {
    return;
  }

  if(scripts\engine\utility::istrue(var_1.kung_fu_cooldown)) {
    return;
  }

  if(scripts\engine\utility::istrue(var_1.has_gourd)) {
    return;
  }

  if(scripts\engine\utility::istrue(var_1.kung_fu_mode)) {
    return;
  }

  if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight() && !scripts\engine\utility::flag("skq_phase_1")) {
    return;
  }

  var_2 = var_1.kung_fu_progression.active_discipline;
  var_1 thread set_gourd(var_1);
  var_0 thread cooldown_struct(var_0, var_1);
}

cooldown_struct(var_0, var_1) {
  var_1 scripts\cp\cp_interaction::refresh_interaction();
  var_1 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_1);
  var_1 thread updategourdinteractions(var_0, var_1);
}

updategourdinteractions(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("disconnect");
  var_1 waittill("spawn_gourds");
  foreach(var_3 in level.all_gourds) {
    scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(var_3, var_1);
  }

  foreach(var_3 in level.all_animal_structs) {
    scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(var_3, var_1);
  }

  var_1 scripts\cp\cp_interaction::refresh_interaction();
  var_1 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_1);
}

start_tracking_kung_fu_discipline(var_0) {
  var_0 thread enter_kung_fu(var_0, getactivekungfustyle(var_0));
}

update_player_abilities(var_0, var_1) {
  if(var_0.kung_fu_progression.disciplines_levels[var_1] < 3) {
    var_0.kung_fu_progression.disciplines_levels[var_1]++;
  }

  var_2 = var_0.kung_fu_progression.disciplines_levels[var_1];
  wait(1);
  switch (var_2) {
    case 1:
      if(!scripts\engine\utility::flag("skq_phase_1")) {
        scripts\engine\utility::flag_set("skq_phase_1");
      }

      var_3 = level.kung_fu_upgrades[var_1].rb;
      if(!scripts\engine\utility::istrue(var_0.kung_fu_exit_delay) && scripts\engine\utility::istrue(var_0.kung_fu_mode)) {
        var_0 thread scripts\cp\powers\coop_powers::givepower(var_3, "primary", undefined, undefined, undefined, 1, 1);
      }
      break;

    case 2:
      var_3 = level.kung_fu_upgrades[var_1].lb;
      if(!scripts\engine\utility::istrue(var_0.kung_fu_exit_delay) && scripts\engine\utility::istrue(var_0.kung_fu_mode)) {
        var_0 thread scripts\cp\powers\coop_powers::givepower(var_3, "secondary", undefined, undefined, undefined, 1, 1);
      }
      break;

    case 3:
      if(!scripts\engine\utility::istrue(var_0.kung_fu_exit_delay) && scripts\engine\utility::istrue(var_0.kung_fu_mode)) {
        if(var_1 == "snake") {
          var_0 setclientomnvar("zm_hud_inventory_1", 1);
        } else if(var_1 == "tiger") {
          var_0 setclientomnvar("zm_hud_inventory_1", 2);
        } else if(var_1 == "crane") {
          var_0 setclientomnvar("zm_hud_inventory_1", 3);
        } else if(var_1 == "dragon") {
          var_0 setclientomnvar("zm_hud_inventory_1", 4);
        }

        var_0 thread activate_level_3_power(var_0, var_1);
        level thread activateblackcats(var_0);
      }
      break;

    default:
      break;
  }
}

activateblackcats(var_0) {
  foreach(var_2 in level.allcatstructs) {
    scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(var_2, var_0);
  }

  var_0 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_0);
}

deactivateblackcats(var_0) {
  if(scripts\engine\utility::flag("rk_fight_started")) {
    return;
  }

  foreach(var_2 in level.allcatstructs) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_2, var_0);
  }

  var_0 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_0);
}

activate_level_3_power(var_0, var_1) {
  wait(0.1);
  if(scripts\engine\utility::istrue(var_0.kung_fu_exit_delay)) {
    return;
  }

  if(!scripts\engine\utility::istrue(var_0.kung_fu_mode)) {
    return;
  }

  var_0 thread watch_for_kung_fu_super_button(var_0, var_1);
}

watch_for_kung_fu_super_button(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 notify("end_super_watcher");
  var_0 endon("end_super_watcher");
  if(var_0 hasweapon("super_default_zm")) {
    var_0 takeweapon("super_default_zm");
  }

  var_2 = "kung_fu_super_zm";
  var_0 giveweapon(var_2);
  var_0 assignweaponoffhandspecial(var_2);
  for(;;) {
    var_0 setweaponammoclip(var_2, 1);
    var_0 waittill("offhand_fired", var_3);
    if(var_3 == var_2) {
      var_0 notify("super_fired");
    }

    if(scripts\engine\utility::istrue(self.tiger_super_use) || scripts\engine\utility::istrue(self.crane_super_use) || scripts\engine\utility::istrue(self.snake_super_use) || scripts\engine\utility::istrue(self.dragon_super_use)) {
      wait(0.1);
      continue;
    }

    if(!var_0 isonground()) {
      wait(0.1);
      continue;
    }

    if(var_3 == var_2) {
      scripts\cp\powers\coop_powers::power_disablepower();
      var_0 notify("put_shuriken_away");
      switch (var_1) {
        case "tiger":
          var_0 notify("super_used");
          var_0 playanimscriptevent("power_active_cp", "gesture021");
          var_0 scripts\cp\maps\cp_disco\kung_fu_mode_tiger::tiger_ground_pound_use(var_1);
          break;

        case "snake":
          var_0 notify("super_used");
          var_0 playanimscriptevent("power_active_cp", "gesture022");
          var_0 scripts\cp\maps\cp_disco\kung_fu_mode_snake::snake_super_use(var_1);
          break;

        case "dragon":
          var_0 notify("super_used");
          var_0 playanimscriptevent("power_active_cp", "gesture020");
          var_0 scripts\cp\maps\cp_disco\kung_fu_mode_dragon::dragon_super_use(var_1);
          break;

        case "crane":
          var_0 notify("super_used");
          var_0 scripts\cp\maps\cp_disco\kung_fu_mode_crane::crane_super_use(var_1);
          break;

        default:
          break;
      }

      var_0 scripts\cp\zombies\zombies_chi_meter::chi_meter_kill_decrement(500);
      wait(1);
    }

    wait(0.1);
  }
}

play_kung_fu_enter_vo(var_0) {
  var_0 thread scripts\cp\cp_vo::try_to_play_vo("enter_kungfu", "zmb_comment_vo", "medium", 10, 0, 0, 1, 50);
  wait(7);
  var_0 thread scripts\cp\cp_vo::try_to_play_vo("ww_kungfu_mode", "rave_announcer_vo", "highest", 70, 0, 0, 1, 100, 1);
}

enter_kung_fu(var_0, var_1) {
  var_0 endon("disconnect");
  if(scripts\engine\utility::istrue(var_0.inlaststand)) {
    return;
  }

  if(scripts\engine\utility::istrue(var_0.isusingsupercard)) {
    return;
  }

  var_0.pre_kung_fu_powers = var_0 scripts\cp\powers\coop_powers::get_info_for_player_powers(var_0);
  foreach(var_3 in getarraykeys(var_0.powers)) {
    var_0 scripts\cp\powers\coop_powers::removepower(var_3);
  }

  level thread play_kung_fu_enter_vo(var_0);
  level.pause_nag_vo = 1;
  var_0.disable_consumables = 1;
  var_0.kung_fu_mode = 1;
  var_0.allow_carry = 0;
  [[level.kung_fu_interaction_func]](var_0);
  var_0.kungfu_style = var_1;
  var_0.no_deadeye = 1;
  var_1 = var_0.kung_fu_progression.active_discipline;
  var_0 getraidspawnpoint();
  var_0 allowprone(0);
  var_5 = 0;
  if(playerhasusedstyle(var_0)) {
    var_5 = 1;
  } else {
    var_0.kung_fu_progression.has_used[var_1]++;
  }

  var_6 = level.kung_fu_upgrades[var_1].melee_weapon;
  var_0 scripts\cp\utility::_giveweapon(var_6, undefined, undefined, var_5);
  var_0 switchtoweaponimmediate(var_6);
  var_0 thread scripts\cp\zombies\zombies_chi_meter::chi_meter_on(var_0, var_1);
  if(var_0.kung_fu_progression.disciplines_levels[var_1] >= 1) {
    var_7 = level.kung_fu_upgrades[var_1].rb;
    var_0 thread scripts\cp\powers\coop_powers::givepower(var_7, "primary", undefined, undefined, undefined, 1, 1);
  }

  if(var_0.kung_fu_progression.disciplines_levels[var_1] >= 2) {
    var_7 = level.kung_fu_upgrades[var_1].lb;
    var_0 thread scripts\cp\powers\coop_powers::givepower(var_7, "secondary", undefined, undefined, undefined, 1, 1);
  }

  if(var_0.kung_fu_progression.disciplines_levels[var_1] >= 3) {
    thread activateblackcats(var_0);
    var_0 thread watch_for_kung_fu_super_button(var_0, var_1);
    if(var_1 == "snake") {
      var_0 setclientomnvar("zm_hud_inventory_1", 1);
    } else if(var_1 == "tiger") {
      var_0 setclientomnvar("zm_hud_inventory_1", 2);
    } else if(var_1 == "crane") {
      var_0 setclientomnvar("zm_hud_inventory_1", 3);
    } else if(var_1 == "dragon") {
      var_0 setclientomnvar("zm_hud_inventory_1", 4);
    }
  } else {
    var_0 setclientomnvar("zm_hud_inventory_1", 0);
  }

  var_0 thread sfx_kungfu_enter(var_1);
  var_0 thread turn_off_wall_buys(var_0);
  var_0 thread kung_fu_symbol_on(var_1);
  var_0 thread watchforforcedexit(var_0);
  var_0 thread handle_kung_fu_on_revive(var_0);
  thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_0);
}

turn_off_wall_buys(var_0) {
  var_0 endon("disconnect");
  foreach(var_2 in level.wall_buy_interactions) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "iw7_katana_zm") {
      continue;
    }

    if(isDefined(var_2.trigger)) {
      var_2.trigger hidefromplayer(var_0);
    }

    scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_2, var_0);
  }
}

turn_on_wall_buys(var_0) {
  var_0 endon("disconnect");
  foreach(var_2 in level.wall_buy_interactions) {
    if(isDefined(var_2.trigger)) {
      var_2.trigger showtoplayer(var_0);
    }

    scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(var_2, var_0);
  }
}

sfx_kungfu_enter(var_0) {
  switch (var_0) {
    case "snake":
      self playlocalsound("zmb_kung_fu_style_snake");
      break;

    case "tiger":
      self playlocalsound("zmb_kung_fu_style_tiger");
      break;

    case "crane":
      self playlocalsound("zmb_kung_fu_style_crane");
      break;

    case "dragon":
      self playlocalsound("zmb_kung_fu_style_dragon");
      break;
  }
}

unset_kung_fu_mode(var_0, var_1) {
  var_2 = var_0.kung_fu_progression.active_discipline;
  var_3 = level.kung_fu_upgrades[var_2].melee_weapon;
  var_0 notify("put_shuriken_away");
  var_0 takeweapon(var_3);
  var_0 thread scripts\cp\cp_vo::try_to_play_vo("exit_kungfu", "zmb_comment_vo", "medium", 10, 0, 0, 1, 50);
  var_0 thread delayed_remove_kung_fu_powers(5, var_0, var_0.pre_kung_fu_powers);
  var_0 restore_pre_kung_fu_powers(var_0, var_0.pre_kung_fu_powers);
  var_0.pre_kung_fu_powers = undefined;
  level.pause_nag_vo = 0;
  var_0.pre_kung_fu_rb_powers = undefined;
  var_0.pre_kung_fu_lb_powers = undefined;
  var_0.kung_fu_mode = undefined;
  var_0.kung_fu_shield = undefined;
  if(scripts\engine\utility::istrue(var_0.refill_powers_after_kungfu)) {
    level scripts\cp\gametypes\zombie::replace_grenades_on_player(var_0);
    var_0.refill_powers_after_kungfu = undefined;
  }

  var_0.allow_carry = undefined;
  [[level.kung_fu_interaction_func]](var_0);
  if(!var_0 hasweapon(var_1)) {
    var_1 = var_0 scripts\cp\utility::getvalidtakeweapon();
  }

  var_0.disable_consumables = undefined;
  var_0.pre_kung_fu_weapon = undefined;
  var_0.no_deadeye = undefined;
  var_0 thread disable_grenades_for_time(1.5);
  var_0 enableweaponswitch();
  var_0 switchtoweapon(var_1);
  if(var_0 hasweapon("kung_fu_super_zm")) {
    var_0 takeweapon("kung_fu_super_zm");
  }

  var_0 scripts\cp\utility::restore_super_weapon();
  var_0 kungfu_buff_cleanup();
  var_0 thread applykungfucooldown(var_0);
  thread deactivateblackcats(var_0);
  var_0 thread turn_on_wall_buys(var_0);
  var_0 allowprone(1);
  var_0 notify("kung_fu_style_timeout");
  var_0 thread scripts\cp\zombies\zombies_chi_meter::chi_meter_off(var_0);
  var_0.shuriken_charged = undefined;
  var_0 setscriptablepartstate("shuriken", "inactive");
}

delayed_remove_kung_fu_powers(var_0, var_1, var_2) {
  var_1 endon("death");
  var_1 endon("disconnect");
  var_1 endon("last_stand");
  var_1 notify("end_delaye_remove_func");
  var_1 endon("end_delaye_remove_func");
  wait(var_0);
  if(scripts\engine\utility::istrue(var_1.kung_fu_mode)) {
    return;
  }

  var_3 = 0;
  foreach(var_5 in level.kung_fu_upgrades) {
    if(isDefined(var_5.rb)) {
      var_6 = var_5.rb;
      if(var_1 scripts\cp\powers\coop_powers::hasequipment(var_6)) {
        var_3 = 1;
      }
    }

    if(isDefined(var_5.lb)) {
      var_6 = var_5.lb;
      if(var_1 scripts\cp\powers\coop_powers::hasequipment(var_6)) {
        var_3 = 1;
      }
    }

    if(var_1 hasweapon("kung_fu_super_zm")) {
      var_3 = 1;
    }
  }

  if(!var_3) {
    return;
  }

  var_1 restore_pre_kung_fu_powers(var_1, var_2);
  var_1.pre_kung_fu_powers = undefined;
  var_1.pre_kung_fu_rb_powers = undefined;
  var_1.pre_kung_fu_lb_powers = undefined;
  if(scripts\engine\utility::istrue(var_1.refill_powers_after_kungfu)) {
    level scripts\cp\gametypes\zombie::replace_grenades_on_player(var_1);
    var_1.refill_powers_after_kungfu = undefined;
  }

  var_1 thread disable_grenades_for_time(1.5);
  if(var_1 hasweapon("kung_fu_super_zm")) {
    var_1 takeweapon("kung_fu_super_zm");
  }

  var_1 scripts\cp\utility::restore_super_weapon();
  var_1 kungfu_buff_cleanup();
  var_1 notify("kung_fu_style_timeout");
}

restoreknifeweapon(var_0) {
  var_1 = var_0.melee_weapon;
  if(!var_0 hasweapon(var_1)) {
    var_0 giveweapon(var_1);
  }
}

disable_grenades_for_time(var_0) {
  scripts\cp\powers\coop_powers::power_disablepower();
  wait(var_0);
  scripts\cp\powers\coop_powers::power_enablepower();
}

applykungfucooldown(var_0) {
  var_0 endon("disconnect");
  var_0.kung_fu_cooldown = 1;
  if(scripts\engine\utility::flag("rk_fight_started")) {
    return;
  }

  level scripts\engine\utility::waittill_any_timeout(300, "wave_starting");
  var_0.kung_fu_cooldown = undefined;
  var_0 notify("spawn_gourds");
}

restore_pre_kung_fu_powers(var_0, var_1) {
  foreach(var_3 in getarraykeys(var_0.powers)) {
    scripts\cp\powers\coop_powers::removepower(var_3);
  }

  foreach(var_3, var_6 in var_1) {
    var_7 = undefined;
    var_8 = 0;
    if(scripts\engine\utility::istrue(var_6.cooldown)) {
      var_7 = 1;
    }

    if(scripts\engine\utility::istrue(var_6.permanent)) {
      var_8 = 1;
    }

    if(var_6.slot == "secondary") {
      var_0 scripts\cp\powers\coop_powers::givepower(var_3, var_6.slot, undefined, undefined, undefined, var_7, var_8);
      var_0 scripts\cp\powers\coop_powers::power_adjustcharges(var_6.charges, var_6.slot, 1);
      continue;
    }

    var_0 scripts\cp\powers\coop_powers::givepower(var_3, var_6.slot, undefined, undefined, undefined, var_7, var_8);
    var_0 scripts\cp\powers\coop_powers::power_adjustcharges(var_6.charges, var_6.slot, 1);
  }
}

clean_up_kung_fu_mode_on_last_stand(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("kung_fu_style_timeout");
  var_0 scripts\engine\utility::waittill_either("last_stand", "death");
  unset_kung_fu_mode(var_0, var_1);
}

handle_kung_fu_on_revive(var_0) {
  var_0 endon("disconnect");
  var_0 endon("kung_fu_style_timeout");
  for(;;) {
    var_0 waittill("stop_revive");
    var_1 = var_0.kung_fu_progression.active_discipline;
    var_0 getraidspawnpoint();
    var_2 = level.kung_fu_upgrades[var_1].melee_weapon;
    var_0 switchtoweapon(var_2);
    wait(0.1);
  }
}

cp_punch_fx(var_0) {
  var_0 endon("disconnect");
  var_0 endon("stop_kung_fu");
  var_0 endon("kung_fu_style_timeout");
  var_1 = 2000;
  for(;;) {
    var_0 waittill("melee_fired");
    wait(0.1);
  }
}

handle_trainer_anims() {
  level endon("game_ended");
  level endon("stop_trainer_idles");
  self.desired_loop = "idle";
  var_0 = undefined;
  for(;;) {
    var_1 = [%iw7_cp_pam_lotus_idle_01, %iw7_cp_pam_lotus_idle_02, %iw7_cp_pam_lotus_idle_03];
    var_2 = ["IW7_cp_pam_lotus_idle_01", "IW7_cp_pam_lotus_idle_02", "IW7_cp_pam_lotus_idle_03"];
    var_3 = [%iw7_cp_pam_lotus_idle_04, %iw7_cp_pam_lotus_idle_05];
    var_4 = ["IW7_cp_pam_lotus_idle_04", "IW7_cp_pam_lotus_idle_05"];
    var_5 = scripts\engine\utility::random(var_2);
    var_6 = scripts\engine\utility::random(var_4);
    switch (self.desired_loop) {
      case "idle":
        switch (var_5) {
          case "IW7_cp_pam_lotus_idle_01":
            var_0 = % iw7_cp_pam_lotus_idle_01;
            break;

          case "IW7_cp_pam_lotus_idle_02":
            var_0 = % iw7_cp_pam_lotus_idle_02;
            break;

          case "IW7_cp_pam_lotus_idle_03":
            var_0 = % iw7_cp_pam_lotus_idle_03;
            break;
        }
        break;

      case "talk":
        switch (var_6) {
          case "IW7_cp_pam_lotus_idle_04":
            var_0 = % iw7_cp_pam_lotus_idle_04;
            break;

          case "IW7_cp_pam_lotus_idle_05":
            var_0 = % iw7_cp_pam_lotus_idle_05;
            break;
        }
        break;
    }

    var_7 = getanimlength(var_0);
    self scriptmodelplayanimdeltamotionfrompos(var_0, self.origin, self.angles);
    wait(var_7);
    self.desired_loop = scripts\engine\utility::random(["idle", "talk"]);
  }
}

kungfuexithint(var_0) {
  if(isDefined(level.wave_num) && level.wave_num >= 15) {
    return;
  }

  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 endon("death");
  var_0 endon("stop_kung_fu");
  var_0 endon("kung_fu_style_timeout");
  var_0.kung_fu_hint_display = 0;
  while(var_0.kung_fu_hint_display < 5) {
    var_0 scripts\cp\utility::setlowermessage("msg_kung_fu_exit_hint", &"CP_DISCO_EXIT_KUNG_FU", 4);
    var_0.kung_fu_hint_display = var_0.kung_fu_hint_display + 1;
    wait(randomfloatrange(5, 10));
  }
}

kungfu_buff_watcher(var_0) {
  self endon("disconnect");
  self endon("stop_kung_fu");
  self endon("kung_fu_style_timeout");
  kungfu_buff_cleanup();
  self.kungfu_style = var_0;
  var_1 = ["crane", "dragon", "snake", "tiger"];
  setkungfubuffstate(var_0, "on");
  for(;;) {
    var_2 = [];
    var_2[self.kungfu_style] = 1;
    var_3 = scripts\engine\utility::get_array_of_closest(self.origin, level.players, undefined, undefined, 1024, 0);
    foreach(var_5 in var_3) {
      if(var_5 == self) {
        continue;
      }

      if(!isDefined(self.kungfu_style)) {
        break;
      }

      var_2[self.kungfu_style] = 1;
    }

    foreach(var_0 in var_1) {
      if(isDefined(var_2[var_0])) {
        setkungfubuffstate(var_0, "on");
        continue;
      }

      setkungfubuffstate(var_0, "off");
    }

    wait(1);
  }
}

kung_fu_symbol_on(var_0) {
  setkungfubuffstate(var_0, "on");
}

kungfu_buff_cleanup() {
  self setscriptablepartstate("kungfu_seal_crane", "off");
  self setscriptablepartstate("kungfu_seal_dragon", "off");
  self setscriptablepartstate("kungfu_seal_snake", "off");
  self setscriptablepartstate("kungfu_seal_tiger", "off");
  self setscriptablepartstate("shuriken", "inactive");
  self setscriptablepartstate("kung_fu_super_fx", "off");
}

setkungfubuffstate(var_0, var_1) {
  if(!isDefined(var_1) || var_1 == "on") {
    self setscriptablepartstate("kungfu_seal_" + var_0, "on");
    return;
  }

  self setscriptablepartstate("kungfu_seal_" + var_0, "off");
}

watchforforcedexit(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("stop_kung_fu");
  var_0 endon("kung_fu_style_timeout");
  var_0 notifyonplayercommand("exit_kung_fu_requested", "+actionslot 4");
  wait(1);
  for(;;) {
    var_0 waittill("exit_kung_fu_requested");
    if(scripts\engine\utility::istrue(var_0.kung_fu_exit_delay)) {
      wait(0.1);
      continue;
    }

    var_0.pre_kung_fu_weapon = scripts\cp\utility::getvalidtakeweapon();
    thread unset_kung_fu_mode(var_0, var_0.pre_kung_fu_weapon);
  }
}

getrbabilitycost() {
  return 100;
}

getlbabilitycost() {
  return 250;
}

getsuperabilitycost() {
  return 500;
}

playerhasusedstyle(var_0) {
  return isDefined(getactivekungfustyle(var_0)) && scripts\engine\utility::istrue(var_0.kung_fu_progression.has_used[getactivekungfustyle(var_0)]);
}

getactivekungfustyle(var_0) {
  if(isDefined(var_0.kung_fu_progression.active_discipline)) {
    return var_0.kung_fu_progression.active_discipline;
  }

  return undefined;
}
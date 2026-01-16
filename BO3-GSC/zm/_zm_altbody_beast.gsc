/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_altbody_beast.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\hud_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\shared\weapons\grapple;
#using scripts\zm\_bb;
#using scripts\zm\_util;
#using scripts\zm\_zm;
#using scripts\zm\_zm_altbody;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_devgui;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_lightning_chain;
#using scripts\zm\_zm_net;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\zm_zod_util;
#namespace zm_altbody_beast;

function autoexec __init__sytem__() {
  system::register("zm_altbody_beast", & __init__, & __main__, undefined);
}

function __init__() {
  clientfield::register("missile", "bminteract", 1, 2, "int");
  clientfield::register("scriptmover", "bminteract", 1, 2, "int");
  clientfield::register("actor", "bm_zombie_melee_kill", 1, 1, "int");
  clientfield::register("actor", "bm_zombie_grapple_kill", 1, 1, "int");
  clientfield::register("toplayer", "beast_blood_on_player", 1, 1, "counter");
  clientfield::register("world", "bm_superbeast", 1, 1, "int");
  level thread function_10dcd1d5("beast_mode_kiosk");
  loadout = array("zombie_beast_grapple_dwr", "zombie_beast_lightning_dwl", "zombie_beast_lightning_dwl2", "zombie_beast_lightning_dwl3");
  beastmode_loadout = zm_weapons::create_loadout(loadout);
  var_55affbc1 = array("zm_bgb_disorderly_combat");
  zm_altbody::init("beast_mode", "beast_mode_kiosk", & "ZM_ZOD_ENTER_BEAST_MODE", "zombie_beast_2", 123, beastmode_loadout, 4, & player_enter_beastmode, & player_exit_beastmode, & player_allow_beastmode, & "ZM_ZOD_CANT_ENTER_BEAST_MODE", var_55affbc1);
  callback::on_connect( & player_on_connect);
  callback::on_spawned( & player_on_spawned);
  callback::on_player_killed( & player_on_killed);
  level.var_87ee6f27 = 4;
  level._effect["human_disappears"] = "zombie/fx_bmode_transition_zmb";
  level._effect["zombie_disappears"] = "zombie/fx_bmode_transition_zmb";
  level._effect["beast_shock"] = "zombie/fx_tesla_shock_zmb";
  level._effect["beast_shock_box"] = "zombie/fx_bmode_dest_pwrbox_zod_zmb";
  level._effect["beast_melee_kill"] = "zombie/fx_bmode_attack_grapple_zod_zmb";
  level._effect["beast_grapple_kill"] = "zombie/fx_bmode_attack_grapple_zod_zmb";
  level._effect["beast_return_aoe"] = "zombie/fx_bmode_attack_grapple_zod_zmb";
  level._effect["beast_return_aoe_kill"] = "zombie/fx_bmode_attack_grapple_zod_zmb";
  level._effect["beast_shock_aoe"] = "zombie/fx_bmode_shock_lvl3_zod_zmb";
  level._effect["beast_3p_trail"] = "zombie/fx_bmode_trail_3p_zod_zmb";
  level.grapple_valid_target_check = & grapple_valid_target_check;
  level.get_grapple_targets = & get_grapple_targets;
  level.grapple_notarget_distance = 120;
  level.grapple_notarget_enabled = 0;
  zm_spawner::register_zombie_damage_callback( & lightning_zombie_damage_response);
  zm_spawner::register_zombie_death_event_callback( & beast_mode_death_watch);
  thread beastmode_devgui();
  triggers = getentarray("trig_beast_mode_kiosk", "targetname");
  foreach(trigger in triggers) {
    trigger delete();
  }
  triggers = getentarray("trig_beast_mode_kiosk_unavailable", "targetname");
  foreach(trigger in triggers) {
    trigger delete();
  }
}

function __main__() {
  thread watch_round_start_mana();
  thread hide_ooze_triggers();
  thread kiosk_cooldown();
  thread make_powerups_grapplable();
  zm_spawner::add_custom_zombie_spawn_logic( & zombie_on_spawn);
  create_lightning_params();
  level.weaponbeastrevivetool = getweapon("syrette_zod_beast");
}

function player_cover_transition(extra_time = 0) {}

function player_disappear_in_flash(washuman) {
  self ghost();
}

function player_enter_beastmode(name, trigger) {
  assert(!(isdefined(self.beastmode) && self.beastmode));
  self notify("clear_red_flashing_overlay");
  self disableoffhandweapons();
  self zm_weapons::suppress_stowed_weapon(1);
  self player_give_mana(1);
  self player_take_lives(1);
  self.beast_mode_return_origin = self.var_b2356a6c;
  self.beast_mode_return_angles = self.var_227fe352;
  self zm_utility::create_streamer_hint(self.origin, self.angles + vectorscale((0, 1, 0), 180), 0.25);
  self thread player_cover_transition();
  self playsound("evt_beastmode_enter");
  if(!isdefined(self.firsttime)) {
    self.firsttime = 1;
    level.n_first_beast_mode_player_index = self.characterindex;
    level notify("hash_571c8e3c");
  }
  self player_disappear_in_flash(1);
  self.overrideplayerdamage_original = self.overrideplayerdamage;
  self.overrideplayerdamage = & player_damage_override_beast_mode;
  self.weaponrevivetool = level.weaponbeastrevivetool;
  self.get_revive_time = & player_get_revive_time;
  self zm_utility::increment_ignoreme();
  self.beastmode = 1;
  self.inhibit_scoring_from_zombies = 1;
  self flag::set("in_beastmode");
  bb::logplayerevent(self, "enter_beast_mode");
  self recordmapevent(1, gettime(), self.origin, level.round_number);
  self allowstand(1);
  self allowprone(0);
  self allowcrouch(0);
  self allowads(0);
  self allowjump(1);
  self allowslide(0);
  self setmovespeedscale(1);
  self setsprintduration(4);
  self setsprintcooldown(0);
  self player_update_beast_mode_objects(1);
  self zm_utility::increment_is_drinking();
  self stopshellshock();
  self setperk("specialty_unlimitedsprint");
  self setperk("specialty_fallheight");
  self setperk("specialty_lowgravity");
  wait(0.1);
  self show();
  self thread player_watch_melee();
  self thread player_watch_melee_juke();
  self thread player_watch_melee_power();
  self thread player_watch_melee_charge();
  self thread player_watch_lightning();
  self thread player_watch_grapple();
  self thread player_watch_grappled_zombies();
  self thread player_watch_grappled_object();
  self thread player_kill_grappled_zombies();
  self thread player_watch_grapple_traverse();
  self thread player_watch_cancel();
  self thread function_92acebd3();
  if(level clientfield::get("bm_superbeast")) {
    self player_enter_superbeastmode();
  }
  scr_beast_no_visionset = getdvarint("") > 0;
  self thread watch_scr_beast_no_visionset();
}

function watch_scr_beast_no_visionset(localclientnum) {
  self endon("player_exit_beastmode");
  was_scr_beast_no_visionset = 0;
  while (isdefined(self)) {
    scr_beast_no_visionset = getdvarint("scr_beast_no_visionset") > 0;
    if(scr_beast_no_visionset != was_scr_beast_no_visionset) {
      name = "beast_mode";
      visionset = "zombie_beast_2";
      if(scr_beast_no_visionset) {
        if(isdefined(visionset)) {
          visionset_mgr::deactivate("visionset", visionset, self);
          self.altbody_visionset[name] = 0;
        }
      } else if(isdefined(visionset)) {
        if(isdefined(self.altbody_visionset[name]) && self.altbody_visionset[name]) {
          visionset_mgr::deactivate("visionset", visionset, self);
          util::wait_network_frame();
          util::wait_network_frame();
          if(!isdefined(self)) {
            return;
          }
        }
        visionset_mgr::activate("visionset", visionset, self);
        self.altbody_visionset[name] = 1;
      }
    }
    was_scr_beast_no_visionset = scr_beast_no_visionset;
    wait(1);
  }
}

function player_enter_superbeastmode() {
  self zm_utility::decrement_ignoreme();
  self.superbeastmana = 1;
  self.see_kiosks_in_altbody = 1;
  self.trigger_kiosks_in_altbody = 1;
  self.custom_altbody_callback = & player_recharge_superbeastmode;
  self disableinvulnerability();
  self thread superbeastmode_override_hp();
  bb::logplayerevent(self, "enter_superbeast_mode");
  self recordmapevent(2, gettime(), self.origin, level.round_number);
}

function player_recharge_superbeastmode(trigger, name) {
  level notify("kiosk_used", trigger.kiosk);
  self.superbeastmana = 1;
  self player_update_beast_mode_objects(1);
}

function superbeastmode_override_hp() {
  self endon("player_exit_beastmode");
  while (isdefined(self)) {
    self.beastmana = self.superbeastmana;
    wait(0.05);
  }
}

function player_exit_beastmode(name, trigger) {
  assert(isdefined(self.beastmode) && self.beastmode);
  self notify("clear_red_flashing_overlay");
  self thread player_cover_transition(0);
  self player_disappear_in_flash(0);
  self player_update_beast_mode_objects(0);
  if(self isthrowinggrenade()) {
    self forcegrenadethrow();
  }
  if(0) {
    wait(0);
  }
  self notify("player_exit_beastmode");
  bb::logplayerevent(self, "exit_beast_mode");
  self thread wait_invulnerable(2);
  self thread wait_enable_offhand_weapons(3);
  while (self isthrowinggrenade() || self isgrappling() || (isdefined(self.teleporting) && self.teleporting)) {
    wait(0.05);
  }
  self unsetperk("specialty_unlimitedsprint");
  self unsetperk("specialty_fallheight");
  self unsetperk("specialty_lowgravity");
  self setmovespeedscale(1);
  self allowstand(1);
  self allowprone(1);
  self allowcrouch(1);
  self allowads(1);
  self allowjump(1);
  self allowdoublejump(0);
  self allowslide(1);
  self stopshellshock();
  self.inhibit_scoring_from_zombies = 0;
  self.beastmode = 0;
  self flag::clear("in_beastmode");
  self.get_revive_time = undefined;
  self.weaponrevivetool = undefined;
  self.overrideplayerdamage = self.overrideplayerdamage_original;
  self.overrideplayerdamage_original = undefined;
  if(level clientfield::get("bm_superbeast")) {
    was_superbeast = 1;
    self.superbeastmana = 0;
    self.see_kiosks_in_altbody = 0;
    self.trigger_kiosks_in_altbody = 0;
    self.custom_altbody_callback = undefined;
  } else {
    was_superbeast = 0;
  }
  self thread wait_and_appear(was_superbeast);
}

function wait_and_appear(no_ignore) {
  self setorigin(self.beast_mode_return_origin);
  self freezecontrols(1);
  v_return_pos = self.beast_mode_return_origin + vectorscale((0, 0, 1), 60);
  a_ai = getaiteamarray(level.zombie_team);
  a_closest = [];
  ai_closest = undefined;
  if(a_ai.size) {
    a_closest = arraysortclosest(a_ai, self.beast_mode_return_origin);
    foreach(ai in a_closest) {
      n_trace_val = ai sightconetrace(v_return_pos, self);
      if(n_trace_val > 0.2) {
        ai_closest = ai;
        break;
      }
    }
    if(isdefined(ai_closest)) {
      self setplayerangles(vectortoangles(ai_closest getcentroid() - v_return_pos));
    }
  }
  if(getdvarint("") > 1) {
    ai_closest = self;
    self enableinvulnerability();
  }
  if(!isdefined(ai_closest)) {
    self setplayerangles(self.beast_mode_return_angles + vectorscale((0, 1, 0), 180));
  }
  wait(0.5);
  self zm_utility::decrement_is_drinking();
  self zm_weapons::suppress_stowed_weapon(0);
  self show();
  self playsound("evt_beastmode_exit");
  self zm_utility::clear_streamer_hint();
  playfx(level._effect["human_disappears"], self.beast_mode_return_origin);
  playfx(level._effect["beast_return_aoe"], self.beast_mode_return_origin);
  a_ai = getaiarray();
  a_aoe_ai = arraysortclosest(a_ai, self.beast_mode_return_origin, a_ai.size, 0, 200);
  foreach(ai in a_aoe_ai) {
    if(isactor(ai)) {
      if(ai.archetype === "zombie") {
        playfx(level._effect["beast_return_aoe_kill"], ai gettagorigin("j_spineupper"));
      } else {
        playfx(level._effect["beast_return_aoe_kill"], ai.origin);
      }
      ai.no_powerups = 1;
      ai.marked_for_recycle = 1;
      ai.has_been_damaged_by_player = 0;
      ai.deathpoints_already_given = 1;
      ai dodamage(ai.health + 1000, self.beast_mode_return_origin, self);
    }
  }
  wait(0.2);
  if(!self zm::in_life_brush() && (self zm::in_kill_brush() || !self zm::in_enabled_playable_area())) {
    wait(3);
  }
  if(isdefined(self.firsttime) && self.firsttime) {
    self.firsttime = 0;
  }
  if(!level.intermission) {
    self freezecontrols(0);
  }
  wait(3);
  b_superbeastmode = level clientfield::get("bm_superbeast");
  if(!no_ignore && !b_superbeastmode) {
    self zm_utility::decrement_ignoreme();
  }
  level notify("a_player_exited_beast_mode", self);
  self thread zm_audio::create_and_play_dialog("beastmode", "exit");
}

function wait_invulnerable(time) {
  was_inv = self enableinvulnerability();
  wait(time);
  if(isdefined(self) && (!(isdefined(was_inv) && was_inv))) {
    self disableinvulnerability();
  }
}

function wait_enable_offhand_weapons(time) {
  self disableoffhandweapons();
  wait(time);
  if(isdefined(self)) {
    self enableoffhandweapons();
  }
  if(isdefined(self.beast_grenades_missed) && self.beast_grenades_missed) {
    lethal_grenade = self zm_utility::get_player_lethal_grenade();
    if(!self hasweapon(lethal_grenade)) {
      self giveweapon(lethal_grenade);
      self setweaponammoclip(lethal_grenade, 0);
    }
    frac = self getfractionmaxammo(lethal_grenade);
    if(frac < 0.25) {
      self setweaponammoclip(lethal_grenade, 2);
    } else {
      if(frac < 0.5) {
        self setweaponammoclip(lethal_grenade, 3);
      } else {
        self setweaponammoclip(lethal_grenade, 4);
      }
    }
  }
  self.beast_grenades_missed = 0;
}

function player_allow_beastmode(name, kiosk) {
  b_superbeastmode = level clientfield::get("bm_superbeast");
  if(!level flagsys::get("start_zombie_round_logic")) {
    return 0;
  }
  if(isdefined(self.beastmode) && self.beastmode && !b_superbeastmode) {
    return 0;
  }
  if(isdefined(kiosk) && !kiosk_allowed(kiosk)) {
    return 0;
  }
  if(level clientfield::get("bm_superbeast")) {
    return 1;
  }
  return self.beastlives >= 1;
}

function kiosk_allowed(kiosk) {
  return !(isdefined(kiosk.is_cooling_down) && kiosk.is_cooling_down);
}

function player_on_connect() {
  self flag::init("in_beastmode");
}

function player_on_spawned() {
  level flag::wait_till("initial_players_connected");
  self.beastmana = 1;
  if(level flag::get("solo_game")) {
    self.beastlives = 3;
  } else {
    self.beastlives = 1;
  }
  self thread update_kiosk_effects();
  self thread player_watch_mana();
  self player_update_beast_mode_objects(0);
}

function make_powerups_grapplable() {
  while (true) {
    level waittill("powerup_dropped", powerup);
    powerup.grapple_type = 2;
    powerup setgrapplabletype(powerup.grapple_type);
  }
}

function function_10dcd1d5(kiosk_name) {
  level.beast_kiosks = struct::get_array(kiosk_name, "targetname");
  foreach(kiosk in level.beast_kiosks) {
    kiosk.var_80eeb471 = (kiosk_name + "_plr_") + kiosk.origin;
    kiosk.var_39a60f4a = (kiosk_name + "_crs_") + kiosk.origin;
    clientfield::register("world", kiosk.var_80eeb471, 1, 4, "int");
    kiosk thread _kiosk_cooldown();
  }
}

function update_kiosk_effects() {
  self endon("death");
  while (isdefined(self)) {
    n_ent_num = self getentitynumber();
    foreach(kiosk in level.beast_kiosks) {
      n_players_allowed = level clientfield::get(kiosk.var_80eeb471);
      if(kiosk_allowed(kiosk)) {
        n_players_allowed = n_players_allowed | (1 << n_ent_num);
      } else {
        n_players_allowed = n_players_allowed & (~(1 << n_ent_num));
      }
      level clientfield::set(kiosk.var_80eeb471, n_players_allowed);
    }
    wait(randomfloatrange(0.2, 0.5));
  }
}

function get_number_of_available_kiosks() {
  n_available_kiosks = 0;
  foreach(kiosk in level.beast_kiosks) {
    if(kiosk_allowed(kiosk)) {
      n_available_kiosks++;
    }
  }
  return n_available_kiosks;
}

function function_f6014f2c(v_origin, var_8ebf7724) {
  a_kiosks = arraysortclosest(level.beast_kiosks, v_origin);
  a_kiosks = array::filter(a_kiosks, 0, & function_b7520b09);
  for (i = 0; i < a_kiosks.size && i < var_8ebf7724; i++) {
    zm_zod_util::function_5cc835d6(v_origin, a_kiosks[i].origin, 1);
    a_kiosks[i].is_cooling_down = 0;
    wait(0.05);
  }
}

function function_b7520b09(s_kiosk) {
  if(!isdefined(s_kiosk) || !isdefined(s_kiosk.is_cooling_down) || !s_kiosk.is_cooling_down) {
    return false;
  }
  return true;
}

function kiosk_cooldown() {
  while (true) {
    level waittill("kiosk_used", e_kiosk);
    if(isdefined(e_kiosk)) {
      e_kiosk thread _kiosk_cooldown();
    }
  }
}

function round_number() {
  n_start_round = 0;
  if(isdefined(level.round_number)) {
    n_start_round = level.round_number;
  }
  return n_start_round;
}

function _kiosk_cooldown() {
  self notify("_kiosk_cooldown");
  self endon("_kiosk_cooldown");
  self.is_cooling_down = 1;
  n_start_round = round_number();
  while ((round_number() - n_start_round) < 1) {
    level waittill("start_of_round");
  }
  self.is_cooling_down = 0;
}

function function_fd8fb00d(b_cooldown = 1) {
  foreach(kiosk in level.beast_kiosks) {
    if(b_cooldown) {
      if(!(isdefined(kiosk.is_cooling_down) && kiosk.is_cooling_down)) {
        kiosk thread _kiosk_cooldown();
      }
      continue;
    }
    if(isdefined(kiosk.is_cooling_down) && kiosk.is_cooling_down) {
      kiosk.is_cooling_down = 0;
    }
  }
}

function player_watch_cancel() {
  self endon("player_exit_beastmode");
  self endon("death");
  if(!self flag::exists("beast_hint_shown")) {
    self flag::init("beast_hint_shown");
  }
  if(!self flag::get("beast_hint_shown")) {
    self thread beast_cancel_hint();
  }
  self.beast_cancel_timer = 0;
  while (isdefined(self)) {
    if(self stancebuttonpressed()) {
      self notify("hide_equipment_hint_text");
      self player_stance_hold_think();
    }
    wait(0.05);
  }
}

function beast_cancel_hint() {
  hint = & "ZM_ZOD_EXIT_BEAST_MODE_HINT";
  y = 315;
  if(level.players.size > 1) {
    hint = & "ZM_ZOD_EXIT_BEAST_MODE_HINT_COOP";
    y = 285;
  }
  self thread watch_beast_hint_use(12, 12.05);
  self thread watch_beast_hint_end(12, 12.05);
  zm_equipment::show_hint_text(hint, 12.05, 1.5, y);
}

function watch_beast_hint_use(mintime, maxtime) {
  self endon("disconnect");
  self util::waittill_any_timeout(maxtime, "smashable_smashed", "grapplable_grappled", "shockable_shocked", "disconnect");
  self flag::set("beast_hint_shown");
}

function watch_beast_hint_end(mintime, maxtime) {
  self endon("disconnect");
  wait(mintime);
  if(isdefined(self)) {
    self flag::wait_till_timeout(maxtime - mintime, "beast_hint_shown");
    self notify("hide_equipment_hint_text");
  }
}

function player_stance_hold_think() {
  self thread player_stance_hold_think_internal();
  retval = self util::waittill_any_return("exit_succeed", "exit_failed");
  if(retval == "exit_succeed") {
    self notify("altbody_end");
    return true;
  }
  self.beast_cancel_timer = 0;
  return false;
}

function function_92acebd3() {
  self endon("player_exit_beastmode");
  self endon("death");
  self waittill("player_did_a_revive");
  self playrumbleonentity("damage_heavy");
  wait(1.5);
  self player_take_mana(1);
  self notify("altbody_end");
}

function player_continue_cancel() {
  if(self isthrowinggrenade()) {
    return false;
  }
  if(!self stancebuttonpressed()) {
    return false;
  }
  if(isdefined(self.teleporting) && self.teleporting) {
    return false;
  }
  return true;
}

function player_stance_hold_think_internal() {
  wait(0.05);
  if(!isdefined(self)) {
    self notify("exit_failed");
    return;
  }
  self.beast_cancel_timer = gettime();
  build_time = 1000;
  self thread player_beast_cancel_bar(self.beast_cancel_timer, build_time);
  while (isdefined(self) && self player_continue_cancel() && (gettime() - self.beast_cancel_timer) < build_time) {
    wait(0.05);
  }
  if(isdefined(self) && self player_continue_cancel() && (gettime() - self.beast_cancel_timer) >= build_time) {
    self notify("exit_succeed");
  } else {
    self notify("exit_failed");
  }
}

function player_beast_cancel_bar(start_time, build_time) {
  self.usebar = self hud::createprimaryprogressbar();
  self.usebartext = self hud::createprimaryprogressbartext();
  self.usebartext settext(&"ZM_ZOD_EXIT_BEAST_MODE");
  self player_progress_bar_update(start_time, build_time);
  self.usebartext hud::destroyelem();
  self.usebar hud::destroyelem();
}

function player_progress_bar_update(start_time, build_time) {
  self endon("death");
  self endon("disconnect");
  self endon("player_exit_beastmode");
  self endon("exit_failed");
  while (isdefined(self) && (gettime() - start_time) < build_time) {
    progress = (gettime() - start_time) / build_time;
    if(progress < 0) {
      progress = 0;
    }
    if(progress > 1) {
      progress = 1;
    }
    self.usebar hud::updatebar(progress);
    wait(0.05);
  }
}

function player_take_mana(mana) {
  self.beastmana = self.beastmana - mana;
  if(self.beastmana <= 0) {
    self.beastmana = 0;
    self notify("altbody_end");
  }
}

function player_give_lives(lives) {
  self.beastlives = self.beastlives + lives;
  if(level flag::get("solo_game")) {
    if(self.beastlives > 3) {
      self.beastlives = 3;
    }
  } else if(self.beastlives > 1) {
    self.beastlives = 1;
  }
}

function player_take_lives(lives) {
  self.beastlives = self.beastlives - lives;
  if(self.beastmana <= 0) {
    self.beastlives = 0;
  }
}

function player_give_mana(mana) {
  self.beastmana = self.beastmana + mana;
  if(self.beastmana > 1) {
    self.beastmana = 1;
  }
}

function player_get_revive_time(player_being_revived) {
  return 0.75;
}

function player_damage_override_beast_mode(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
  if(isdefined(eattacker) && isplayer(eattacker)) {
    return false;
  }
  b_superbeastmode = level clientfield::get("bm_superbeast");
  if(b_superbeastmode) {
    superbeastdamage = idamage * 0.0005;
    if(superbeastdamage > 0.4) {
      superbeastdamage = 0.4;
      self thread zm_zod_util::set_rumble_to_player(3);
    } else {
      self thread zm_zod_util::set_rumble_to_player(2);
    }
    self.superbeastmana = self.superbeastmana - superbeastdamage;
    if(self.superbeastmana <= 0) {
      self notify("altbody_end");
      self player_take_mana(1);
      self.beastlives = 1;
    }
    return false;
  }
  if(isdefined(eattacker) && (isdefined(eattacker.is_zombie) && eattacker.is_zombie || eattacker.team === level.zombie_team)) {
    return false;
  }
  if(idamage < self.health) {
    return false;
  }
  self notify("altbody_end");
  self player_take_mana(1);
  return false;
}

function player_check_grenades() {
  if(isdefined(self.beastmode) && self.beastmode) {
    self.beast_grenades_missed = 1;
  }
}

function watch_round_start_mana() {
  level waittill("start_of_round");
  foreach(player in getplayers()) {
    player player_check_grenades();
  }
  while (true) {
    level waittill("start_of_round");
    foreach(player in getplayers()) {
      if(!(isdefined(player.beastmode) && player.beastmode)) {
        player player_give_mana(1);
      }
      player player_give_lives(1);
      player player_check_grenades();
    }
  }
}

function player_watch_mana() {
  if(!isdefined(self.superbeastmana)) {
    self.superbeastmana = 0;
  }
  self notify("player_watch_mana");
  self endon("player_watch_mana");
  while (isdefined(self)) {
    if(isdefined(level.hostmigrationtimer) && level.hostmigrationtimer) {
      wait(1);
      continue;
    }
    if(isdefined(self.beastmode) && self.beastmode && (!(isdefined(self.teleporting) && self.teleporting))) {
      self player_take_mana(1 / 500);
    }
    if(level clientfield::get("bm_superbeast")) {
      n_mapped_mana = math::linear_map(self.superbeastmana, 0, 1, 0, 1);
    } else {
      n_mapped_mana = math::linear_map(self.beastmana, 0, 1, 0, 1);
    }
    self clientfield::set_player_uimodel("player_mana", n_mapped_mana);
    lives = self.beastlives;
    if(lives != self clientfield::get_player_uimodel("player_lives")) {
      player_give_lives(0);
      lives = self.beastlives;
      self clientfield::set_player_uimodel("player_lives", lives);
    }
    wait(0.05);
  }
}

function player_on_killed() {
  self notify("altbody_end");
  self player_take_mana(1);
}

function hide_ooze_triggers() {
  level flagsys::wait_till("start_zombie_round_logic");
  ooo = getentarray("ooze_only", "script_noteworthy");
  array::thread_all(ooo, & trigger_ooze_only);
  moo = getentarray("beast_melee_only", "script_noteworthy");
  array::thread_all(moo, & trigger_melee_only);
  goo = getentarray("beast_grapple_only", "script_noteworthy");
  array::thread_all(goo, & trigger_grapple_only);
}

function player_update_beast_mode_objects(onoff) {
  bmo = getentarray("beast_mode", "script_noteworthy");
  if(isdefined(level.get_beast_mode_objects)) {
    more_bmo = [
      [level.get_beast_mode_objects]
    ]();
    bmo = arraycombine(bmo, more_bmo, 0, 0);
  }
  array::run_all(bmo, & entity_set_visible, self, onoff);
  bmho = getentarray("not_beast_mode", "script_noteworthy");
  if(isdefined(level.get_beast_mode_hide_objects)) {
    more_bmho = [
      [level.get_beast_mode_hide_objects]
    ]();
    bmho = arraycombine(bmho, more_bmho, 0, 0);
  }
  array::run_all(bmho, & entity_set_visible, self, !onoff);
}

function entity_set_visible(player, onoff) {
  if(onoff) {
    self setvisibletoplayer(player);
  } else {
    self setinvisibletoplayer(player);
  }
}

function player_watch_melee_charge() {
  self endon("player_exit_beastmode");
  self endon("death");
  while (isdefined(self)) {
    self waittill("weapon_melee_charge", weapon);
    self notify("weapon_melee", weapon);
  }
}

function player_watch_melee_power() {
  self endon("player_exit_beastmode");
  self endon("death");
  while (isdefined(self)) {
    self waittill("weapon_melee_power", weapon);
    self notify("weapon_melee", weapon);
  }
}

function player_watch_melee() {
  self endon("player_exit_beastmode");
  self endon("death");
  while (isdefined(self)) {
    self waittill("weapon_melee", weapon);
    if(weapon == getweapon("zombie_beast_grapple_dwr")) {
      self player_take_mana(0.03);
      forward = anglestoforward(self getplayerangles());
      up = anglestoup(self getplayerangles());
      meleepos = (self.origin + (15 * up)) + (30 * forward);
      level notify("beast_melee", self, meleepos);
      self radiusdamage(meleepos, 48, 5000, 5000, self, "MOD_MELEE");
    }
  }
}

function player_watch_melee_juke() {
  self endon("player_exit_beastmode");
  self endon("death");
  while (isdefined(self)) {
    self waittill("weapon_melee_juke", weapon);
    if(weapon == getweapon("zombie_beast_grapple_dwr")) {
      player_beast_melee_juke(weapon);
    }
  }
}

function player_beast_melee_juke(weapon) {
  self endon("weapon_melee");
  self endon("weapon_melee_power");
  self endon("weapon_melee_charge");
  start_time = gettime();
  while ((start_time + 3000) > gettime()) {
    self playrumbleonentity("zod_beast_juke");
    wait(0.1);
  }
}

function function_b484a03e(meleepos, radius) {
  mins = (radius * -1, radius * -1, radius * -1);
  maxs = (radius, radius, radius);
  return self istouchingvolume(meleepos, mins, maxs);
}

function trigger_melee_only() {
  self endon("death");
  level flagsys::wait_till("start_zombie_round_logic");
  if(isdefined(self.target)) {
    target = getent(self.target, "targetname");
    if(isdefined(target)) {
      target enableaimassist();
    }
  }
  self setinvisibletoall();
  while (isdefined(self)) {
    level waittill("beast_melee", player, meleepos);
    if(isdefined(self) && self function_b484a03e(meleepos, 48)) {
      self useby(player);
    }
  }
}

function is_lightning_weapon(weapon) {
  if(!isdefined(weapon)) {
    return false;
  }
  if(weapon == getweapon("zombie_beast_lightning_dwl") || weapon == getweapon("zombie_beast_lightning_dwl2") || weapon == getweapon("zombie_beast_lightning_dwl3")) {
    return true;
  }
  return false;
}

function lightning_weapon_level(weapon) {
  if(!isdefined(weapon)) {
    return 0;
  }
  if(weapon == getweapon("zombie_beast_lightning_dwl")) {
    return 1;
  }
  if(weapon == getweapon("zombie_beast_lightning_dwl2")) {
    return 2;
  }
  if(weapon == getweapon("zombie_beast_lightning_dwl3")) {
    return 3;
  }
  return 0;
}

function player_watch_lightning() {
  self endon("player_exit_beastmode");
  self endon("death");
  self.tesla_enemies = undefined;
  self.tesla_enemies_hit = 0;
  self.tesla_powerup_dropped = 0;
  self.tesla_arc_count = 0;
  while (isdefined(self)) {
    self waittill("weapon_fired", weapon);
    if(is_lightning_weapon(weapon)) {
      self player_take_mana(0);
    }
  }
}

function lightning_aoe(weapon) {
  self endon("disconnect");
  self.tesla_enemies = undefined;
  self.tesla_enemies_hit = 0;
  self.tesla_powerup_dropped = 0;
  self.tesla_arc_count = 0;
  shocklevel = lightning_weapon_level(weapon);
  shockradius = 36;
  switch (shocklevel) {
    case 2: {
      shockradius = 72;
      break;
    }
    case 3: {
      shockradius = 108;
      break;
    }
  }
  forward = anglestoforward(self getplayerangles());
  up = anglestoup(self getplayerangles());
  center = (self.origin + (16 * up)) + (24 * forward);
  if(shocklevel > 1) {
    playfx(level._effect["beast_shock_aoe"], center);
  }
  zombies = array::get_all_closest(center, getaiteamarray(level.zombie_team), undefined, undefined, shockradius);
  foreach(zombie in zombies) {
    zombie thread arc_damage_init(zombie.origin, center, self, shocklevel);
    zombie notify("bhtn_action_notify", "electrocute");
  }
  wait(0.05);
  self.tesla_enemies_hit = 0;
}

function arc_damage_init(hit_location, hit_origin, player, shocklevel) {
  player endon("disconnect");
  if(isdefined(self.zombie_tesla_hit) && self.zombie_tesla_hit) {
    return;
  }
  if(shocklevel < 2) {
    self lightning_chain::arc_damage(self, player, 1, level.beast_lightning_level_1);
  } else {
    if(shocklevel < 3) {
      self lightning_chain::arc_damage(self, player, 1, level.beast_lightning_level_2);
    } else {
      self lightning_chain::arc_damage(self, player, 1, level.beast_lightning_level_3);
    }
  }
}

function create_lightning_params() {
  level.beast_lightning_level_1 = lightning_chain::create_lightning_chain_params(1);
  level.beast_lightning_level_1.should_kill_enemies = 0;
  level.beast_lightning_level_2 = lightning_chain::create_lightning_chain_params(2);
  level.beast_lightning_level_2.should_kill_enemies = 0;
  level.beast_lightning_level_2.clientside_fx = 0;
  level.beast_lightning_level_3 = lightning_chain::create_lightning_chain_params(3);
  level.beast_lightning_level_3.should_kill_enemies = 0;
  level.beast_lightning_level_3.clientside_fx = 0;
}

function get_grapple_targets() {
  if(!isdefined(level.beast_mode_targets)) {
    level.beast_mode_targets = [];
  }
  return level.beast_mode_targets;
}

function trigger_grapple_only() {
  self endon("death");
  level flagsys::wait_till("start_zombie_round_logic");
  self setinvisibletoall();
  while (isdefined(self)) {
    level waittill("grapple_hit", target, player);
    if(isdefined(self) && target istouching(self)) {
      self useby(player);
    }
  }
}

function player_watch_grapple() {
  self endon("player_exit_beastmode");
  self endon("death");
  grapple = getweapon("zombie_beast_grapple_dwr");
  while (isdefined(self)) {
    self waittill("grapple_fired", weapon);
    if(weapon == grapple) {
      if(isdefined(self.lockonentity)) {
        if(!self function_668dcfac(self.lockonentity)) {
          self.lockonentity = undefined;
        }
      }
      self player_take_mana(0);
      self thread player_beast_grapple_rumble(weapon, "zod_beast_grapple_out", 0.4);
    }
  }
}

function function_668dcfac(target) {
  if(isdefined(target.var_deccd0c8) && target.var_deccd0c8) {
    return false;
  }
  target.var_deccd0c8 = 1;
  self thread function_b8488073(target, 5);
  return true;
}

function function_b8488073(target, time) {
  self util::waittill_any_timeout(time, "disconnect", "grapple_cancel", "player_exit_beastmode");
  if(isdefined(target)) {
    target.var_deccd0c8 = undefined;
    if(isdefined(target.is_zombie) && target.is_zombie) {
      target dodamage(target.health + 1000, target.origin);
      if(!isvehicle(target)) {
        target.no_powerups = 1;
        target.marked_for_recycle = 1;
        target.has_been_damaged_by_player = 0;
      }
    }
  }
}

function player_beast_grapple_rumble(weapon, rumble, length) {
  self endon("grapple_stick");
  self endon("grapple_pulled");
  self endon("grapple_landed");
  self endon("grapple_cancel");
  start_time = gettime();
  while ((start_time + 3000) > gettime()) {
    self playrumbleonentity(rumble);
    wait(length);
  }
}

function grapple_valid_target_check(ent) {
  if(!isvehicle(ent)) {
    if(isdefined(ent.is_zombie) && ent.is_zombie) {
      if(!(isdefined(ent.completed_emerging_into_playable_area) && ent.completed_emerging_into_playable_area)) {
        return false;
      }
    }
  }
  return true;
}

function zombie_on_spawn() {
  self endon("death");
  self.grapple_type = 0;
  self setgrapplabletype(self.grapple_type);
  if(!isvehicle(self)) {
    self waittill("completed_emerging_into_playable_area");
  }
  if(!isdefined(self)) {
    return;
  }
  self.grapple_type = 2;
  self setgrapplabletype(self.grapple_type);
}

function player_watch_grappled_object() {
  self endon("player_exit_beastmode");
  self endon("death");
  grapple = getweapon("zombie_beast_grapple_dwr");
  while (isdefined(self)) {
    self waittill("grapple_stick", weapon, target);
    if(weapon == grapple) {
      self notify("grapplable_grappled");
      self playrumbleonentity("zod_beast_grapple_hit");
      if(isdefined(target)) {
        if(isdefined(target.is_zombie) && target.is_zombie) {
          target zombie_gets_pulled(self);
        }
      }
      level notify("grapple_hit", target, self, isdefined(self.pivotentity) && !isplayer(self.pivotentity));
      playsoundatposition("wpn_beastmode_grapple_imp", target.origin);
    }
  }
}

function player_watch_grapple_traverse() {
  self endon("player_exit_beastmode");
  self endon("death");
  grapple = getweapon("zombie_beast_grapple_dwr");
  while (isdefined(self)) {
    self waittill("grapple_reelin", weapon, target);
    if(weapon == grapple) {
      origin = target.origin;
      self thread player_watch_grapple_landing(origin);
      self playsound("wpn_beastmode_grapple_pullin");
      wait(0.15);
      self thread player_beast_grapple_rumble(weapon, "zod_beast_grapple_reel", 0.2);
    }
  }
}

function player_watch_grapple_landing(origin) {
  self endon("player_exit_beastmode");
  self endon("death");
  self notify("player_watch_grapple_landing");
  self endon("player_watch_grapple_landing");
  self waittill("grapple_landed", weapon, target);
  if(distance2dsquared(self.origin, origin) > 1024) {
    self setorigin(origin + (vectorscale((0, 0, -1), 60)));
  }
}

function player_watch_grappled_zombies() {
  self endon("player_exit_beastmode");
  self endon("death");
  grapple = getweapon("zombie_beast_grapple_dwr");
  while (isdefined(self)) {
    self waittill("grapple_pullin", weapon, target);
    if(weapon == grapple) {
      wait(0.15);
      self thread player_beast_grapple_rumble(weapon, "zod_beast_grapple_pull", 0.2);
    }
  }
}

function player_kill_grappled_zombies() {
  self endon("player_exit_beastmode");
  self endon("death");
  grapple = getweapon("zombie_beast_grapple_dwr");
  while (isdefined(self)) {
    self waittill("grapple_pulled", weapon, target);
    if(weapon == grapple) {
      if(isdefined(target)) {
        if(isdefined(target.is_zombie) && target.is_zombie) {} else if(isdefined(target.powerup_name)) {
          target.origin = self.origin;
        }
      }
    }
  }
}

function zombie_gets_pulled(player) {
  self.grapple_is_fatal = 1;
  zombie_to_player = player.origin - self.origin;
  zombie_to_player_2d = vectornormalize((zombie_to_player[0], zombie_to_player[1], 0));
  zombie_forward = anglestoforward(self.angles);
  zombie_forward_2d = vectornormalize((zombie_forward[0], zombie_forward[1], 0));
  zombie_right = anglestoright(self.angles);
  zombie_right_2d = vectornormalize((zombie_right[0], zombie_right[1], 0));
  dot = vectordot(zombie_to_player_2d, zombie_forward_2d);
  if(dot >= 0.5) {
    self.grapple_direction = "front";
  } else {
    if(dot < 0.5 && dot > -0.5) {
      dot = vectordot(zombie_to_player_2d, zombie_right_2d);
      if(dot > 0) {
        self.grapple_direction = "right";
      } else {
        self.grapple_direction = "left";
      }
    } else {
      self.grapple_direction = "back";
    }
  }
  self thread function_d4252c93(player);
}

function function_d4252c93(player) {
  player util::waittill_any_timeout(2.5, "disconnect", "grapple_pulled", "altbody_end");
  wait(0.15);
  if(isdefined(self)) {
    if(isdefined(player)) {
      player playsound("wpn_beastmode_grapple_zombie_imp");
    }
    if(!(isdefined(self.grapple_is_fatal) && self.grapple_is_fatal)) {
      self dodamage(1000, player.origin, player);
    } else {
      if(isdefined(player)) {
        self dodamage(self.health + 1000, player.origin, player);
      } else {
        self dodamage(self.health + 1000, self.origin);
      }
      if(!isvehicle(self)) {
        self.no_powerups = 1;
        self.marked_for_recycle = 1;
        self.has_been_damaged_by_player = 0;
        self startragdoll();
        if(isdefined(player)) {
          player clientfield::increment_to_player("beast_blood_on_player");
        }
      }
    }
  }
}

function lightning_zombie_damage_response(mod, hit_location, hit_origin, player, amount, weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel) {
  if(is_lightning_weapon(weapon)) {
    shocklevel = lightning_weapon_level(weapon);
    self.tesla_death = 0;
    self thread arc_damage_init(hit_location, hit_origin, player, shocklevel);
    return true;
  }
  if(weapon === getweapon("zombie_beast_grapple_dwr")) {
    if(amount > 0 && isdefined(player)) {
      player playrumbleonentity("damage_heavy");
      earthquake(1, 0.75, player.origin, 100);
    }
    return true;
  }
  return false;
}

function watch_lightning_damage(triggers) {
  self endon("delete");
  self setcandamage(1);
  while (isdefined(triggers)) {
    self waittill("damage", amount, attacker, direction, point, mod, tagname, modelname, partname, weapon);
    if(is_lightning_weapon(weapon) && isdefined(attacker) && amount > 0) {
      if(isdefined(attacker)) {
        attacker notify("shockable_shocked");
      }
      if(isdefined(level._effect["beast_shock_box"])) {
        forward = anglestoforward(self.angles);
        playfx(level._effect["beast_shock_box"], self.origin, forward);
      }
      if(!isdefined(triggers)) {
        return;
      }
      if(isarray(triggers)) {
        foreach(trigger in triggers) {
          if(isdefined(trigger)) {
            trigger useby(attacker);
          }
        }
      } else {
        triggers useby(attacker);
      }
    }
  }
}

function beast_mode_death_watch(attacker) {
  if(isdefined(self.attacker) && (isdefined(self.attacker.beastmode) && self.attacker.beastmode)) {
    self.no_powerups = 1;
    self.marked_for_recycle = 1;
    self.has_been_damaged_by_player = 0;
  }
  if(is_lightning_weapon(self.damageweapon)) {
    self.no_powerups = 1;
    self.marked_for_recycle = 1;
    self.has_been_damaged_by_player = 0;
  }
  if(self.damageweapon === getweapon("zombie_beast_grapple_dwr")) {
    self.no_powerups = 1;
    self.marked_for_recycle = 1;
    self.has_been_damaged_by_player = 0;
    if(!isvehicle(self)) {
      if(self.damagemod === "MOD_MELEE") {
        player = self.attacker;
        if(isdefined(player)) {
          player playrumbleonentity("damage_heavy");
          earthquake(1, 0.75, player.origin, 100);
        }
        self clientfield::set("bm_zombie_grapple_kill", 1);
        gibserverutils::annihilate(self);
      } else {
        player = self.attacker;
        if(isdefined(player)) {
          player playrumbleonentity("damage_heavy");
          earthquake(1, 0.75, player.origin, 100);
        }
        self clientfield::set("bm_zombie_melee_kill", 1);
        gibserverutils::annihilate(self);
      }
    }
  }
}

function trigger_ooze_only() {
  self endon("death");
  level flagsys::wait_till("start_zombie_round_logic");
  self setinvisibletoall();
  while (isdefined(self)) {
    level waittill("ooze_detonate", grenade, player);
    if(isdefined(self) && isdefined(grenade) && grenade istouching(self)) {
      self useby(player);
    }
  }
}

function zombie_can_be_zapped() {
  if(isdefined(self.barricade_enter) && self.barricade_enter) {
    return false;
  }
  if(isdefined(self.is_traversing) && self.is_traversing) {
    return false;
  }
  if(!(isdefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area) && !isdefined(self.first_node)) {
    return false;
  }
  if(isdefined(self.is_leaping) && self.is_leaping) {
    return false;
  }
  return true;
}

function lightning_slow_zombie(zombie) {
  zombie endon("death");
  zombie notify("lightning_slow_zombie");
  zombie endon("lightning_slow_zombie");
  if(!zombie zombie_can_be_zapped()) {
    return;
  }
  num = zombie getentitynumber();
  if(!isdefined(zombie.beast_slow_count)) {
    zombie.beast_slow_count = 0;
  }
  zombie.beast_slow_count++;
  if(!isdefined(zombie.animation_rate)) {
    zombie.animation_rate = 1;
  }
  zombie.slow_time_left = 8;
  zombie thread lightning_slow_zombie_fx(zombie);
  while (isdefined(zombie) && isalive(zombie) && zombie.animation_rate > 0.03) {
    zombie.animation_rate = zombie.animation_rate - (0.97 * 0.05);
    if(zombie.animation_rate < 0.03) {
      zombie.animation_rate = 0.03;
    }
    zombie asmsetanimationrate(zombie.animation_rate);
    zombie.slow_time_left = zombie.slow_time_left - 0.05;
    wait(0.05);
  }
  while (isdefined(zombie) && isalive(zombie) && zombie.slow_time_left > 0.5) {
    zombie.slow_time_left = zombie.slow_time_left - 0.05;
    wait(0.05);
  }
  while (isdefined(zombie) && isalive(zombie) && zombie.animation_rate < 1) {
    zombie.animation_rate = zombie.animation_rate + (0.97 * 0.1);
    if(zombie.animation_rate > 1) {
      zombie.animation_rate = 1;
    }
    zombie asmsetanimationrate(zombie.animation_rate);
    zombie.slow_time_left = zombie.slow_time_left - 0.05;
    wait(0.05);
  }
  zombie asmsetanimationrate(1);
  zombie.slow_time_left = 0;
  if(isdefined(zombie)) {
    zombie.beast_slow_count--;
  }
}

function lightning_slow_zombie_fx(zombie) {
  tag = "J_SpineUpper";
  fx = "beast_shock";
  if(isdefined(zombie.isdog) && zombie.isdog) {
    tag = "J_Spine1";
  }
  while (isdefined(zombie) && isalive(zombie) && zombie.slow_time_left > 0) {
    zombie zm_net::network_safe_play_fx_on_tag("beast_slow_fx", 2, level._effect[fx], zombie, tag);
    wait(1);
  }
}

function function_41cc3fc8() {
  players = level.activeplayers;
  foreach(player in players) {
    player thread player_update_beast_mode_objects(isdefined(player.beastmode) && player.beastmode);
  }
}

function function_d7b8b2f5() {
  self endon("player_exit_beastmode");
  self endon("altbody_end");
  n_start_time = undefined;
  while (true) {
    current_zone = self zm_utility::get_current_zone();
    if(!isdefined(current_zone)) {
      if(!isdefined(n_start_time)) {
        n_start_time = gettime();
      }
      n_current_time = gettime();
      n_time = (n_current_time - n_start_time) / 1000;
      if(n_time >= level.var_87ee6f27) {
        self notify("altbody_end");
        return;
      }
    } else {
      n_start_time = undefined;
    }
    wait(0.05);
  }
}

function beastmode_devgui() {
  level flagsys::wait_till("");
  wait(1);
  zm_devgui::add_custom_devgui_callback( & beastmode_devgui_callback);
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  players = getplayers();
  for (i = 0; i < players.size; i++) {
    ip1 = i + 1;
    adddebugcommand(((("" + players[i].name) + "") + ip1) + "");
    adddebugcommand(((("" + players[i].name) + "") + ip1) + "");
  }
}

function beastmode_devgui_callback(cmd) {
  players = getplayers();
  retval = 0;
  switch (cmd) {
    case "": {
      zm_devgui::zombie_devgui_give_powerup(cmd, 1);
      break;
    }
    case "": {
      zm_devgui::zombie_devgui_give_powerup(getsubstr(cmd, 5), 0);
      break;
    }
    case "": {
      array::thread_all(players, & player_zombie_devgui_beast_mode);
      retval = 1;
      break;
    }
    case "": {
      array::thread_all(players, & player_zombie_devgui_superbeast_mode);
      retval = 1;
      break;
    }
    case "": {
      a_trigs = getentarray("", "");
      foreach(e_trig in a_trigs) {
        e_trig useby(level.players[0]);
      }
      a_trigs = getentarray("", "");
      foreach(e_trig in a_trigs) {
        e_trig useby(level.players[0]);
      }
      a_str_ritual_flags = array("", "", "", "");
      foreach(var_83f1459 in a_str_ritual_flags) {
        level flag::set(var_83f1459);
      }
      level flag::set("");
      level flag::set("");
      zm_devgui::zombie_devgui_open_sesame();
      break;
    }
    case "": {
      if(players.size >= 1) {
        players[0] thread player_zombie_devgui_beast_mode();
      }
      retval = 1;
      break;
    }
    case "": {
      if(players.size >= 2) {
        players[1] thread player_zombie_devgui_beast_mode();
      }
      retval = 1;
      break;
    }
    case "": {
      if(players.size >= 3) {
        players[2] thread player_zombie_devgui_beast_mode();
      }
      retval = 1;
      break;
    }
    case "": {
      if(players.size >= 4) {
        players[3] thread player_zombie_devgui_beast_mode();
      }
      retval = 1;
      break;
    }
    case "": {
      array::thread_all(players, & player_zombie_devgui_beast_mode_preserve);
      retval = 1;
      break;
    }
    case "": {
      if(players.size >= 1) {
        players[0] thread player_zombie_devgui_beast_mode_preserve();
      }
      retval = 1;
      break;
    }
    case "": {
      if(players.size >= 2) {
        players[1] thread player_zombie_devgui_beast_mode_preserve();
      }
      retval = 1;
      break;
    }
    case "": {
      if(players.size >= 3) {
        players[2] thread player_zombie_devgui_beast_mode_preserve();
      }
      retval = 1;
      break;
    }
    case "": {
      if(players.size >= 4) {
        players[3] thread player_zombie_devgui_beast_mode_preserve();
      }
      retval = 1;
      break;
    }
  }
  return retval;
}

function player_zombie_devgui_beast_mode() {
  if(self detect_reentry()) {
    return;
  }
  level flagsys::wait_till("");
  if(!(isdefined(self.beastmode) && self.beastmode)) {
    self player_give_mana(1);
    self thread zm_altbody::devgui_start_altbody("");
  } else {
    self notify("altbody_end");
  }
}

function player_zombie_devgui_superbeast_mode() {
  if(self detect_reentry()) {
    return;
  }
  level flagsys::wait_till("");
  b_superbeastmode = level clientfield::get("");
  if(!(isdefined(self.beastmode) && self.beastmode) && !b_superbeastmode) {
    self player_give_mana(1);
    self thread zm_altbody::devgui_start_altbody("");
  } else {
    self notify("altbody_end");
  }
}

function detect_reentry() {
  if(isdefined(self.devgui_preserve_time)) {
    if(self.devgui_preserve_time == gettime()) {
      return true;
    }
  }
  self.devgui_preserve_time = gettime();
  return false;
}

function player_zombie_devgui_beast_mode_preserve() {
  if(self detect_reentry()) {
    return;
  }
  self notify("zombie_devgui_beast_mode_preserve");
  self endon("zombie_devgui_beast_mode_preserve");
  level flagsys::wait_till("");
  self.devgui_preserve_beast_mode = !(isdefined(self.devgui_preserve_beast_mode) && self.devgui_preserve_beast_mode);
  if(self.devgui_preserve_beast_mode) {
    while (isdefined(self)) {
      self player_give_lives(3);
      self player_give_mana(1);
      wait(0.05);
    }
  }
}
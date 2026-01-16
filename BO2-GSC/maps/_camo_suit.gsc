/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_camo_suit.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_scene;
#include maps\_objectives;
#include maps\_dialog;
#include maps\_glasses;

precache() {
  precachestring(&"SCRIPT_HINT_CAMO_SUIT_ON");
  precachestring(&"SCRIPT_HINT_CAMO_SUIT_OFF");
  precachestring(&"SCRIPT_HINT_CAMO_SUIT_ACTIVATE");
  precacheitem("camo_suit_sp");
}

autoexec _camo_suit_perk_init() {
  setup_anim();
  flag_init("lock_breaker_perk_used");
  level.obj_lockbreaker = register_objective("");
  t_use = getent("use_lockbreaker", "targetname");
  t_use sethintstring(&"SCRIPT_HINT_HACK");
  t_use setcursorhint("HINT_NOICON");
  t_use trigger_off();
  flag_wait("level.player");
  level.player waittill_player_has_lock_breaker_perk();
  t_use trigger_on();
  set_objective_perk(level.obj_lockbreaker, t_use, 512);
  t_use waittill("trigger", player);

  if(level.script == "monsoon") {
    level thread monsoon_vo();
    delay_thread(0.05, ::data_glove_on, "lockbreaker_perk");
  }

  if(level.script == "yemen")
    level thread yemen_vo();

  remove_objective_perk(level.obj_lockbreaker);
  flag_set("lock_breaker_perk_used");
  run_scene("lockbreaker_perk");
  player disableweapons();
  screen_fade_out(1);
  player playsound("fly_camo_suit_change");
  wait 1;
  player giveweapon("camo_suit_sp");
  player setactionslot(2, "weapon", "camo_suit_sp");
  player thread player_camo_suit();
  screen_fade_in(1);
  player enableweapons();
}

data_glove_on(str_scene) {
  m_player_body = get_model_or_models_from_scene(str_scene, "player_body");
  m_player_body setforcenocull();
  m_player_body attach("c_usa_cia_frnd_viewbody_vson", "J_WristTwist_LE");
}

#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("animated_props");

setup_anim() {
  if(level.script == "yemen") {
    add_scene("lockbreaker_perk", "lockbreaker_case");
    add_player_anim("player_body", % int_specialty_yemen_lockbreaker, 1);
    add_prop_anim("lockbreaker_dongle", % o_specialty_yemen_lockbreaker_dongle, "t6_wpn_hacking_dongle_prop", 1);
    add_prop_anim("lockbreaker_camosuit", % o_specialty_yemen_lockbreaker_camosuit, "p6_intruder_perk_pickup", 1);
    add_prop_anim("lockbreaker_case", % o_specialty_yemen_lockbreaker_crate);
  } else if(level.script == "monsoon") {
    add_scene("lockbreaker_perk", "lockbreaker_case");
    add_player_anim("player_body", % int_specialty_monsoon_lockbreaker, 1);
    add_prop_anim("lockbreaker_dongle", % o_specialty_monsoon_lockbreaker_dongle, "t6_wpn_hacking_dongle_prop", 1);
    add_prop_anim("lockbreaker_camosuit", % o_specialty_monsoon_lockbreaker_camosuit, "p6_intruder_perk_pickup", 1);
    add_prop_anim("lockbreaker_case", % o_specialty_monsoon_lockbreaker_crate);
  }

  precache_assets();
}

player_camo_suit() {
  self endon("death");

  if(level.script == "monsoon")
    self.camo_visible_dist = 350;
  else
    self.camo_visible_dist = 500;

  self ent_flag_init("camo_suit_on");
  self ent_flag_init("camo_suit_damaged");
  self notify("camo_suit_equipped");
  self thread _watch_toggle_suit();
  self thread player_camo_suit_tutorial();
  add_visor_text("SCRIPT_HINT_CAMO_SUIT_OFF", 0, "default", "medium", 0);
  n_old_maxvisibledist = self.maxvisibledist;
  n_old_attackeraccuracy = self.attackeraccuracy;

  while(true) {
    self ent_flag_wait("camo_suit_on");

    iprintln("camo suit on");

    remove_visor_text("SCRIPT_HINT_CAMO_SUIT_OFF");
    add_visor_text("SCRIPT_HINT_CAMO_SUIT_ON", 0, "default", "medium", 0);
    camo_suit_snd_ent = spawn("script_origin", (0, 0, 0));
    level.player playsound("fly_camo_suit_plr_on");
    camo_suit_snd_ent playloopsound("fly_camo_suit_plr_loop", 1);
    self.maxvisibledist = self.camo_visible_dist;
    self.attackeraccuracy = 0.2;
    self.str_old_vision = self getvisionsetnaked();
    self visionsetnaked("camo_suit", 1);
    self setviewmodel(level.player_camo_viewmodel);
    self thread player_camo_suit_damage_watch();

    while(ent_flag("camo_suit_on")) {
      if(self isfiring() && !issubstr(self getcurrentweapon(), "silencer"))
        self.maxvisibledist = self.camo_visible_dist * 2;
      else if(!ent_flag("camo_suit_damaged"))
        self.maxvisibledist = self.camo_visible_dist;

      wait 0.05;
    }

    self playsound("fly_camo_suit_plr_off");
    camo_suit_snd_ent stoploopsound(0.5);
    camo_suit_snd_ent delete();

    iprintln("camo suit off");

    self notify("camo_suit_off");
    self ent_flag_clear("camo_suit_damaged");
    remove_visor_text("SCRIPT_HINT_CAMO_SUIT_ON");
    add_visor_text("SCRIPT_HINT_CAMO_SUIT_OFF", 0, "default", "medium", 0);
    self.maxvisibledist = n_old_maxvisibledist;
    self.attackeraccuracy = n_old_attackeraccuracy;
    self visionsetnaked(self.str_old_vision, 1);
    self setviewmodel(level.player_viewmodel);
  }
}

player_camo_suit_damage_watch() {
  self endon("camo_suit_off");

  while(true) {
    self waittill("damage");
    self thread player_camo_suit_damage_fall_off();
  }
}

player_camo_suit_damage_fall_off() {
  self notify("starting_fall_off");
  self endon("starting_fall_off");
  self endon("camo_suit_off");
  self ent_flag_set("camo_suit_damaged");
  self.maxvisibledist = self.camo_visible_dist * 2;

  while(self.maxvisibledist > self.camo_visible_dist) {
    self.maxvisibledist = self.maxvisibledist - 5;
    wait 0.05;
  }

  self ent_flag_clear("camo_suit_damaged");
}

player_camo_suit_tutorial() {
  screen_message_create(&"SCRIPT_HINT_CAMO_SUIT_ACTIVATE");
  waittill_notify_or_timeout("camo_suit_on", 5);
  screen_message_delete();
}

_watch_toggle_suit() {
  self endon("death");

  while(true) {
    self waittill("weapon_change", new_weapon, old_weapon);

    if(new_weapon == "camo_suit_sp") {
      self disableweaponfire();
      self disableweaponcycling();
      self disableusability();
      self disableoffhandweapons();
      wait 1;

      if(old_weapon == "none")
        old_weapon = self getweaponslistprimaries()[0];

      self switchtoweapon(old_weapon);
      self waittill_notify_or_timeout("weapon_change", 0.25);
      self ent_flag_toggle("camo_suit_on");
      self enableweaponcycling();
      self enableweaponfire();
      self enableusability();
      self enableoffhandweapons();
    }
  }
}

monsoon_vo() {
  level.crosby queue_dialog("cros_what_s_in_there_sec_0", 4.0, undefined, "start_player_asd_anim");
  level.player queue_dialog("sect_enemy_s_optic_system_0", 1.0, undefined, "start_player_asd_anim");
  level.harper queue_dialog("harp_maybe_you_should_sui_0", 0.5, undefined, "start_player_asd_anim");
}

yemen_vo() {
  level.player queue_dialog("fari_harper_i_secured_a_0", 4.0);
  level.player queue_dialog("harp_good_the_less_att_0", 1.0);
}
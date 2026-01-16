/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nicaragua_menendez_rage.gsc
********************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\nicaragua_util;
#include maps\_gameskill;
#include maps\createart\nicaragua_art;
#include maps\_dialog;

setup_rage() {
  flag_init("rage_off");
  flag_init("rage_weapon_fire_audio_on");
  flag_wait("level.player");
  level.player visionsetnaked("sp_nicaragua_default", 0.05);
  setup_rage_settings();
  hide_ammo_count();
  level.player thread rage_ammo_check();
  level.player thread rage_health_overlay();
  level.player thread rage_sprint_logic();
  level thread rage_chase_after_player();
  setup_rage_enemies();
  wait 1;
  level.player notify("noHealthOverlay");
}

setup_rage_enemies() {
  add_spawn_function_group("actor_Enemy_PDF_Nicaragua_Assault_Base", "classname", ::rage_enemy_override);
  add_spawn_function_group("actor_Enemy_PDF_Nicaragua_Launcher_Base", "classname", ::rage_enemy_override);
  add_spawn_function_group("actor_Enemy_PDF_Nicaragua_LMG_Base", "classname", ::rage_enemy_override);
  add_spawn_function_group("actor_Enemy_PDF_Nicaragua_Shotgun_Base", "classname", ::rage_enemy_override);
  add_spawn_function_group("actor_Enemy_PDF_Nicaragua_SMG_Base", "classname", ::rage_enemy_override);
  add_spawn_function_group("actor_Enemy_PDF_Nicaragua_Sniper_Base", "classname", ::rage_enemy_override);
}

rage_enemy_override() {
  self.overrideactordamage = ::rage_ai_damage_override;
}

setup_rage_settings() {
  level.player.b_rage_sprint_vo = 0;
  level.player.b_rage_fire_vo = 0;
  level.str_rage_on = 1;
  level.str_rage_mode = "reset";
  level.str_rage_breath = "none";
  level.a_rage_settings = [];
  level.a_rage_settings["low"] = _get_low_rage_settings();
  level.a_rage_settings["high"] = _get_high_rage_settings();
}

_get_low_rage_settings() {
  s_settings = spawnstruct();

  switch (getdifficulty()) {
    case "easy":
      s_settings.n_damage_cap = 6;
      s_settings.n_damage_frac = 0.5;
      break;
    case "hard":
      s_settings.n_damage_cap = 6;
      s_settings.n_damage_frac = 0.35;
      break;
    case "fu":
      s_settings.n_damage_cap = 6;
      s_settings.n_damage_frac = 0.25;
      break;
    default:
      s_settings.n_damage_cap = 6;
      s_settings.n_damage_frac = 0.4;
      break;
  }

  return s_settings;
}

_get_high_rage_settings() {
  s_settings = spawnstruct();

  switch (getdifficulty()) {
    case "easy":
      s_settings.n_damage_cap = 5;
      s_settings.n_damage_frac_kill_1 = 0.06;
      s_settings.n_damage_frac_kill_2 = 0.15;
      s_settings.n_damage_frac_kill_3 = 0.25;
      s_settings.n_damage_frac_kill_4 = 0.35;
      s_settings.n_damage_frac_cap = 0.4;
      break;
    case "hard":
      s_settings.n_damage_cap = 5;
      s_settings.n_damage_frac_kill_1 = 0.06;
      s_settings.n_damage_frac_kill_2 = 0.15;
      s_settings.n_damage_frac_kill_3 = 0.15;
      s_settings.n_damage_frac_kill_4 = 0.15;
      s_settings.n_damage_frac_cap = 0.25;
      break;
    case "fu":
      s_settings.n_damage_cap = 5;
      s_settings.n_damage_frac_kill_1 = 0.06;
      s_settings.n_damage_frac_kill_2 = 0.06;
      s_settings.n_damage_frac_kill_3 = 0.06;
      s_settings.n_damage_frac_kill_4 = 0.06;
      s_settings.n_damage_frac_cap = 0.15;
      break;
    default:
      s_settings.n_damage_cap = 5;
      s_settings.n_damage_frac_kill_1 = 0.06;
      s_settings.n_damage_frac_kill_2 = 0.15;
      s_settings.n_damage_frac_kill_3 = 0.25;
      s_settings.n_damage_frac_kill_4 = 0.25;
      s_settings.n_damage_frac_cap = 0.35;
      break;
  }

  return s_settings;
}

precache_rage_mode_overlays() {
  a_images = [];
  a_images[a_images.size] = "hud_nicar_rage_girl_image";

  foreach(image in a_images)
  precacheshader(image);

  level.rage_mode_images = a_images;
}

is_rage_on() {
  if(level.str_rage_on)
    return true;

  return false;
}

rage_disable() {
  flag_set("rage_off");
  rpc("clientscripts/nicaragua", "rage_mode_disable");
  self heartbeat_reset();
  self stop_rage_vo();
  show_ammo_count();
  level notify("disable_rage");
  level.str_rage_breath = "none";
  level.str_rage_mode = "disable";
  self thread maps\_gameskill::healthoverlay();
  level thread maps\createart\nicaragua_art::blend_exposure_over_time(2.2, 0.5);
  self visionsetnaked("sp_nicaragua_default", 2);
}

rage_reset() {
  if(level.str_rage_mode != "reset" && is_rage_on()) {
    flag_set("rage_off");
    level thread maps\createart\nicaragua_art::blend_exposure_over_time(2.2, 0.5);
    rpc("clientscripts/nicaragua", "rage_mode_reset");
    self visionsetnaked("sp_nicaragua_default", 2);
    self heartbeat_reset();
    self stop_rage_vo();
    level.str_rage_breath = "none";
    level.str_rage_mode = "reset";
  }
}

rage_low() {
  if(level.str_rage_mode != "low" && is_rage_on()) {
    flag_set("rage_off");
    level.disable_damage_blur = 1;
    wait 2.75;
    self heartbeat_low();
    self thread rage_melee_player_vo();
    self thread rage_low_player_fire_vo();
    self thread rage_josefina_vo();
    self thread rage_sprint_vo();
    self thread rage_mode_audio_loop("vox_nic_2_01_001a_mene");
    level thread rage_weapon_fire_vo_on();
    level thread maps\createart\nicaragua_art::blend_exposure_over_time(2.2, 0.5);

    if(flag("menendez_intro_part2_done"))
      self visionsetnaked("rage_mode_low", 2);

    rpc("clientscripts/nicaragua", "rage_toggle", 0);
    rpc("clientscripts/nicaragua", "rage_mode_low");
    level.disable_damage_blur = undefined;
    level.str_rage_mode = "low";
  }
}

rage_medium() {
  if(level.str_rage_mode != "medium" && is_rage_on()) {
    flag_set("rage_off");
    flag_clear("rage_weapon_fire_audio_on");
    rpc("clientscripts/nicaragua", "rage_mode_medium");

    if(flag("menendez_intro_part2_done"))
      self visionsetnaked("rage_mode_low", 2);

    self heartbeat_medium();
    level.str_rage_mode = "medium";
  }
}

rage_high(b_is_outdoor) {
  if(level.str_rage_mode != "high" && is_rage_on()) {
    flag_clear("rage_weapon_fire_audio_on");
    flag_clear("rage_off");
    level notify("rage_on");

    if(isDefined(b_is_outdoor) && b_is_outdoor)
      level thread maps\createart\nicaragua_art::blend_exposure_over_time(2.6, 0.5);

    rpc("clientscripts/nicaragua", "rage_toggle", 1);
    rpc("clientscripts/nicaragua", "rage_mode_fade_shift_to_high", 0.4);
    rpc("clientscripts/nicaragua", "rage_mode_high");

    if(flag("menendez_intro_part2_done"))
      self visionsetnaked("rage_mode_high", 0.5);

    self heartbeat_high();
    self thread rage_mode_audio_loop("vox_nic_2_01_002a_mene");
    level.str_rage_mode = "high";
  }
}

heartbeat_reset() {
  self rumble_loop_stop();
}

heartbeat_low() {
  self thread rumble_loop(-1, 0.35, "reload_small");
}

heartbeat_medium() {
  self thread rumble_loop(-1, 0.25, "reload_small");
}

heartbeat_high() {
  self thread rumble_loop(-1, 0.25, "reload_medium");
}

rage_high_logic(str_ai_group, b_first_shot) {
  level.player _rage_high_gameplay_start_setup(str_ai_group, b_first_shot);
  level thread rage_end_by_kills(str_ai_group);
  level thread rage_enemy_logic();
  level.player thread rage_player_invulnerability_disable_based_on_kills(1);
  level.player thread rage_timer();
  level.player thread rage_high_player_damage_vo();
  timescale_tween(1, 0.75, 0.15);
  flag_wait("rage_off");
  timescale_tween(0.75, 1, 0.15);
  level.player _rage_high_gameplay_end_cleanup(str_ai_group);
}

_rage_high_gameplay_start_setup(str_ai_group, b_first_shot) {
  level.n_rage_kills = 0;
  self allowcrouch(0);
  self allowprone(0);
  self enableinvulnerability();
  self setmovespeedscale(1.3);
  self.overrideplayerdamage = ::rage_high_player_damage_override;

  if(isDefined(str_ai_group)) {
    self thread rage_high_weapon_switch_logic(b_first_shot);
    self thread rage_dive_to_prone_logic();
  }
}

rage_dive_to_prone_logic() {
  level endon("rage_off");
  wait 0.05;

  while(self.divetoprone)
    wait 0.05;

  self allow_divetoprone(0);
}

rage_high_weapon_switch_logic(b_first_shot) {
  level endon("rage_off");
  self allowpickupweapons(0);

  if(isDefined(b_first_shot) && b_first_shot) {
    while(level.n_rage_kills < 1)
      wait 0.05;
  }

  self disableweapons(1);
  setsaveddvar("aim_automelee_enabled", 0);
  setdvar("aim_assist_script_disable", 1);
  wait 0.35;
  self rage_high_take_weapons();
  self.b_took_weapons = 1;
  self enableweapons();
  self giveweapon("machete_held_sp");
  self switchtoweapon("machete_held_sp");
}

rage_high_take_weapons() {
  self.curweapon = self getcurrentweapon();
  self.weapons_list = self getweaponslist();
  self.offhand = self getcurrentoffhand();
  weapon_list_modified = [];

  for(i = 0; i < self.weapons_list.size; i++) {
    if(!is_weapon_attachment(self.weapons_list[i]))
      weapon_list_modified[weapon_list_modified.size] = self.weapons_list[i];
  }

  self.weapons_list = weapon_list_modified;

  if(is_weapon_attachment(self.curweapon))
    self.curweapon = get_baseweapon_for_attachment(self.curweapon);

  self.weapons_info = [];

  for(i = 0; i < self.weapons_list.size; i++) {
    self.weapons_info[i] = spawnstruct();

    if(isDefined(self.offhand) && self.weapons_list[i] == self.offhand) {
      self.weapons_info[i]._ammo = 0;
      self.weapons_info[i]._stock = self getweaponammostock(self.weapons_list[i]);
      continue;
    }

    self.weapons_info[i]._ammo = self getweaponammoclip(self.weapons_list[i]);
    self.weapons_info[i]._stock = self getweaponammostock(self.weapons_list[i]);
    self.weapons_info[i]._renderoptions = self getweaponrenderoptions(self.weapons_list[i]);
  }

  foreach(str_weapon in self.weapons_list) {
    if(str_weapon != "machete_held_sp")
      self takeweapon(str_weapon);
  }
}

_rage_high_gameplay_end_cleanup(str_ai_group) {
  self allowcrouch(1);
  self allowprone(1);
  self allow_divetoprone(1);
  self disableinvulnerability();
  self setmovespeedscale(1);
  self.overrideplayerdamage = ::rage_low_player_damage_override;

  if(isDefined(str_ai_group)) {
    self allowpickupweapons(1);
    setsaveddvar("aim_automelee_enabled", 1);
    setdvar("aim_assist_script_disable", 0);

    if(isDefined(self.b_took_weapons) && self.b_took_weapons) {
      self disableweapons(1);
      wait 0.35;
      self takeweapon("machete_held_sp");
      give_weapons();
      self.b_took_weapons = 0;
    }

    self enableweapons();
  }

  level endon("rage_off");
  rpc("clientscripts/nicaragua", "rage_mode_fade_shift_to_low", 1);
  wait 2.25;
  rpc("clientscripts/nicaragua", "rage_toggle", 0);
  self visionsetnaked("rage_mode_low", 2);
}

rage_end_by_kills(str_ai_group) {
  level endon("rage_off");

  if(isDefined(str_ai_group)) {
    waittill_ai_group_cleared(str_ai_group);
    wait 0.15;
    level.player thread rage_low();
  }
}

rage_end_by_no_enemies() {
  level endon("rage_off");

  while(getaiarray("axis").size > 0)
    wait 0.05;

  wait 0.15;
  level.player thread rage_low();
}

rage_high_ammo_check() {
  n_bullets_used = 0;

  while(!flag("rage_off")) {
    str_weapon_current = self getcurrentweapon();

    if(str_weapon_current != "none") {
      n_ammo = self getweaponammoclip(str_weapon_current);
      n_clip_size = weaponclipsize(str_weapon_current);

      if(n_ammo < n_clip_size) {
        n_ammo_used = n_clip_size - n_ammo;
        n_bullets_used = n_bullets_used + n_ammo_used;
        self setweaponammoclip(str_weapon_current, n_clip_size);
      }
    }

    wait 0.05;
  }

  str_weapon_current = self getcurrentweapon();

  if(str_weapon_current != "none") {
    n_clip_size = weaponclipsize(str_weapon_current);

    if(n_bullets_used >= n_clip_size)
      n_ammo_give = 1;
    else
      n_ammo_give = n_clip_size - n_bullets_used;

    self setweaponammoclip(str_weapon_current, n_ammo_give);
  }
}

rage_ammo_check() {
  level endon("disable_rage");
  flag_wait("nicaragua_intro_complete");
  self thread rage_ammo_weapon_change();
  self thread rage_ammo_spas_reload_logic();

  while(!flag("shattered_1_started")) {
    str_weapon_current = self getcurrentweapon();

    if(str_weapon_current != "none") {
      n_ammo = self getweaponammostock(str_weapon_current);
      n_stock_size = weaponmaxammo(str_weapon_current);

      if(n_ammo < n_stock_size)
        self setweaponammostock(str_weapon_current, n_stock_size);
    }

    wait 0.05;
  }
}

rage_ammo_spas_reload_logic() {
  level endon("disable_rage");
  n_ammo_max = weaponclipsize("spas_menendez_sp");

  while(!flag("shattered_1_started")) {
    self waittill("reload_start");
    str_weapon_current = self getcurrentweapon();

    if(str_weapon_current == "spas_menendez_sp") {
      n_ammo = self getweaponammoclip(str_weapon_current);
      n_ammo_diff = n_ammo_max - n_ammo;

      if(n_ammo_diff > 3) {
        self disableweapons(1);
        self rage_ammo_fake_reload(str_weapon_current);
        self enableweapons();
      }
    }

    wait 0.05;
  }
}

rage_ammo_fake_reload(str_weapon_current) {
  self endon("weapon_change");
  self endon("weapon_melee");
  self endon("rage_sprinting");
  n_ammo_max = weaponclipsize(str_weapon_current);
  n_ammo_giveback = n_ammo_max - 2;
  self setweaponammoclip(str_weapon_current, n_ammo_giveback);
  self thread sound_fake_reload();
  wait 0.35;
  self setweaponammoclip(str_weapon_current, n_ammo_max);
}

sound_fake_reload() {
  self endon("weapon_change");
  self endon("weapon_melee");
  self endon("rage_sprinting");
  self playsound("fly_spas_pull");
  wait 0.1;
  self playsound("fly_spas_shell_in");
  wait 0.05;
  self playsound("fly_spas_shell_in");
  wait 0.05;
  self playsound("fly_spas_release");
}

rage_ammo_weapon_change() {
  level endon("disable_rage");

  while(!flag("shattered_1_started")) {
    self waittill("weapon_change", str_weapon);

    if(str_weapon != "none") {
      n_clip_size = weaponclipsize(str_weapon);
      self setweaponammoclip(str_weapon, n_clip_size);
    }

    wait 0.05;
  }
}

should_fast_reload_by_weapon(str_weapon) {
  switch (str_weapon) {
    case "m60_sp":
    case "rpd_sp":
    case "spas_menendez_sp":
      b_fast_reload = 1;
      break;
    default:
      b_fast_reload = 0;
      break;
  }

  return b_fast_reload;
}

rage_player_invulnerability_disable_based_on_kills(n_kills_before_disable) {
  level endon("rage_off");

  while(level.n_rage_kills < n_kills_before_disable)
    wait 0.05;

  self disableinvulnerability();
}

rage_timer() {
  level endon("rage_off");
  wait 3;
  self disableinvulnerability();
  wait 11;
  level.player thread rage_low();
}

rage_enemy_logic() {
  a_enemies = getaiarray("axis");

  foreach(ai_enemy in a_enemies) {
    if(isalive(ai_enemy)) {
      if(!isDefined(ai_enemy.ent_flag["rage_extra_gore"]))
        ai_enemy ent_flag_init("rage_extra_gore");
    }
  }

  flag_wait("rage_off");
  a_enemies = getaiarray("axis");

  foreach(ai_enemy in a_enemies) {
    if(isalive(ai_enemy))
      ai_enemy notify("rage_off");
  }
}

cool_rage_death() {
  level endon("rage_off");
  level.n_rage_kills++;
  n_timescale_kill_slow = _get_timescale_kill_slow();
  timescale_tween(0.75, n_timescale_kill_slow, 0.15);
  wait 0.05;
  timescale_tween(n_timescale_kill_slow, 0.75, 0.15);
}

rage_ragdoll_death(v_hit_direction, v_hit_location) {
  n_dist = distance(level.player.origin, self.origin);

  if(n_dist > 512)
    n_dist = 512;

  n_dist_invert = 512 - n_dist;
  n_launch_force = linear_map(n_dist_invert, 0, 512, 3, 45);
  v_launch = v_hit_direction * n_launch_force;
  n_up_force = linear_map(n_dist_invert, 0, 512, 6, 23);
  v_launch_final = (v_launch[0], v_launch[1], n_up_force);
  playfx(level._effect["rage_mode_blood"], v_hit_location, v_hit_direction);
  self ragdoll_death();

  if(isDefined(self))
    self launchragdoll(v_launch_final);

  if(is_mature())
    self thread blood_splat_logic();
}

rage_blood_enemy_death(v_hit_direction, v_hit_location) {
  if(is_alive(self))
    self disable_long_death();

  if(isDefined(self.ent_flag["rage_extra_gore"])) {
    if(!ent_flag("rage_extra_gore")) {
      self thread rage_extra_gore_cool_down();
      playfx(level._effect["rage_mode_blood"], v_hit_location, v_hit_direction);

      if(is_mature())
        self blood_splat_logic();
    }
  }
}

rage_extra_gore_cool_down() {
  self endon("death");
  ent_flag_set("rage_extra_gore");
  wait 0.85;
  ent_flag_clear("rage_extra_gore");
}

blood_splat_logic(n_alpha_max_forced) {
  level endon("rage_off");
  n_blood_dist_max = 169 - 105;
  n_dist = distance(level.player.origin, self.origin);
  n_dist_clamp = clamp(n_dist, 105, 169);
  n_blood_dist = linear_map(n_dist, 105, 169, 0, n_blood_dist_max);
  n_blood_dist_inverse = n_blood_dist_max - n_blood_dist;
  n_alpha = linear_map(n_blood_dist_inverse, 0, n_blood_dist_max, 0, 1);

  if(isDefined(n_alpha_max_forced) && n_alpha_max_forced)
    n_alpha = n_alpha_max_forced;

  if(n_alpha > 0)
    level.player visionsetnaked("rage_mode_blood", 0.05);

  n_alpha_reset = 0;

  if(isDefined(level.player.b_in_courtyard) && level.player.b_in_courtyard && n_dist <= 192) {
    n_alpha_reset = 0.5;

    if(n_alpha < n_alpha_reset)
      n_alpha = 0.5;
  }

  n_time = linear_map(n_alpha, n_alpha_reset, 1, 0, 3);
  rpc("clientscripts/nicaragua", "blood_splat", n_time, n_alpha, n_alpha_reset);
  level notify("end_other_blood_splat");
  level endon("end_other_blood_splat");
  wait 0.25;

  if(isDefined(level.player.b_in_courtyard) && level.player.b_in_courtyard && flag("rage_off"))
    level.player visionsetnaked("rage_mode_low", 0.05);
  else
    level.player visionsetnaked("rage_mode_high", 0.05);
}

_get_timescale_kill_slow() {
  switch (level.n_rage_kills) {
    case 1:
      n_timescale_kill_slow = 0.15;
      level.player thread maps\_dialog::say_dialog("mene_rage_yell_roar_growl_0");
      break;
    case 2:
      n_timescale_kill_slow = 0.15;
      level.player thread maps\_dialog::say_dialog("mene_rage_yell_roar_growl_1");
      break;
    case 3:
      n_timescale_kill_slow = 0.25;
      level.player thread maps\_dialog::say_dialog("mene_get_out_of_my_way_0");
      break;
    case 4:
      n_timescale_kill_slow = 0.35;
      level.player thread maps\_dialog::say_dialog("mene_rage_yell_roar_growl_2");
      break;
    case 5:
      n_timescale_kill_slow = 0.4;
      level.player thread maps\_dialog::say_dialog("mene_die_0");
      break;
    case 6:
      n_timescale_kill_slow = 0.5;
      break;
    case 7:
      n_timescale_kill_slow = 0.65;
      break;
    default:
      n_timescale_kill_slow = 0.75;
      break;
  }

  return n_timescale_kill_slow;
}

rage_chase_after_player() {
  level endon("disable_rage");
  flag_wait("nicaragua_intro_complete");

  while(!flag("shattered_1_started")) {
    ai_enemy = get_closest_ai(level.player.origin, "axis");

    if(isalive(ai_enemy) && !(isDefined(ai_enemy.b_not_part_of_rage) && ai_enemy.b_not_part_of_rage)) {
      ai_enemy fake_rush();
      ai_enemy thread force_goal();
      ai_enemy.b_picked_rage_fake_rush = 1;
      ai_enemy waittill("death");
    }

    wait 0.05;
  }
}

fake_rush() {
  self.a.neversprintforvariation = 1;
  self.aggressivemode = 1;
  self.disablearrivals = 1;
  self.disableexits = 1;
  self.disablereact = 1;
  self.favoriteenemy = level.player;
  self.goalradius = 128;
  self.ignoresuppression = 1;
  self.noheatanims = 1;
  self.pathenemyfightdist = 128;
  self disable_react();
  self disable_tactical_walk();
  self setgoalentity(level.player);
}

rage_low_player_damage_override(e_inflictor, e_attacker, n_damage, n_flags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime) {
  s_rage_settings_low = level.a_rage_settings["low"];
  n_damage = int(n_damage * s_rage_settings_low.n_damage_frac);

  if(n_damage > s_rage_settings_low.n_damage_cap)
    n_damage = s_rage_settings_low.n_damage_cap;

  return n_damage;
}

rage_high_player_damage_override(e_inflictor, e_attacker, n_damage, n_flags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime) {
  s_rage_settings_high = level.a_rage_settings["high"];

  if(level.n_rage_kills == 0)
    n_damage = 1;
  else if(level.n_rage_kills == 1)
    n_damage = int(n_damage * s_rage_settings_high.n_damage_frac_kill_1);
  else if(level.n_rage_kills == 2)
    n_damage = int(n_damage * s_rage_settings_high.n_damage_frac_kill_2);
  else if(level.n_rage_kills == 3)
    n_damage = int(n_damage * s_rage_settings_high.n_damage_frac_kill_3);
  else if(level.n_rage_kills == 4)
    n_damage = int(n_damage * s_rage_settings_high.n_damage_frac_kill_4);
  else
    n_damage = int(n_damage * s_rage_settings_high.n_damage_frac_cap);

  if(n_damage > s_rage_settings_high.n_damage_cap)
    n_damage = s_rage_settings_high.n_damage_cap;

  level notify("rage_high_player_damage");
  return n_damage;
}

rage_ai_damage_override(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime, str_bone_name) {
  if(!flag("rage_off")) {
    if(level.player getcurrentweapon() == "machete_held_sp")
      level.player playrumbleonentity("reload_clipout");

    self thread rage_blood_enemy_death(v_dir, v_point);

    if(!(isDefined(self.b_cool_rage_death) && self.b_cool_rage_death)) {
      self thread cool_rage_death();
      self.b_cool_rage_death = 1;
    }

    n_damage = self.health;
  } else {
    if(isDefined(e_inflictor) && isplayer(e_inflictor))
      n_damage = int(n_damage * 1.05);

    if(isDefined(level.player.b_in_courtyard) && level.player.b_in_courtyard) {
      n_possible_health = self.health - n_damage;

      if(n_possible_health < 1)
        self thread rage_blood_enemy_death(v_dir, v_point);
    }
  }

  return n_damage;
}

fake_rage_ai_damage_override(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime, str_bone_name) {
  if(isDefined(e_inflictor) && isplayer(e_inflictor)) {
    n_possible_damage = n_damage * 2;
    n_damage = n_possible_damage;
  }

  n_possible_health = self.health - n_damage;

  if(n_possible_health < 1) {
    if(is_alive(self))
      self disable_long_death();

    self thread rage_blood_enemy_death(v_dir, v_point);
  }

  return n_damage;
}

rage_mode_create_hud_elem() {
  hud_elem = newhudelem();
  hud_elem.x = 0;
  hud_elem.y = 0;
  hud_elem.horzalign = "fullscreen";
  hud_elem.vertalign = "fullscreen";
  hud_elem.foreground = 1;
  hud_elem.sort = 1;
  hud_elem.alpha = 1;
  return hud_elem;
}

rage_mode_low_cycle_images() {
  level endon("disable_rage");

  if(!isDefined(self.rage_mode_hud_enabled))
    self.rage_mode_hud_enabled = 0;

  if(self.rage_mode_hud_enabled) {
    return;
  }
  self.rage_mode_hud_enabled = 1;

  if(!isDefined(self.rage_mode_hud))
    self.rage_mode_hud = rage_mode_create_hud_elem();

  a_images = array_randomize(level.rage_mode_images);
  n_image_index = 0;
  wait 55;

  while(!flag("shattered_1_started")) {
    if(flag("rage_off")) {
      self.rage_mode_hud setshader(a_images[n_image_index], 640, 480);
      self.rage_mode_hud rage_fade_image();
      n_image_index++;

      if(n_image_index >= a_images.size)
        n_image_index = 0;
    }

    wait 55;
  }

  self.rage_mode_hud.alpha = 0;
  self.rage_mode_hud destroy();
  self.rage_mode_hud = undefined;
  self.rage_mode_hud_enabled = undefined;
}

rage_fade_image() {
  level endon("rage_on");
  self fade_hud_low_to_high(0, 0.35, 1.5);
  self fade_hud_high_to_low(0.35, 0.25, 0.5);
  self fade_hud_low_to_high(0.25, 0.5, 1);
  self fade_hud_high_to_low(0.5, 0, 3);
}

fade_hud_low_to_high(n_alpha_low, n_alpha_high, n_fade_time) {
  self.alpha = n_alpha_low;
  self fadeovertime(n_fade_time);
  self.alpha = n_alpha_high;
  wait(n_fade_time);
}

fade_hud_high_to_low(n_alpha_high, n_alpha_low, n_fade_time) {
  self.alpha = n_alpha_high;
  self fadeovertime(n_fade_time);
  self.alpha = n_alpha_low;
  wait(n_fade_time);
}

rage_mode_high_cycle_images() {
  a_images = level.rage_mode_images;
  n_index = randomint(a_images.size);

  for(i = 0; i < 3; i++) {
    self.rage_mode_hud.alpha = 0.85;
    self.rage_mode_hud setshader(a_images[n_index], 640, 480);
    wait 0.15;
    self.rage_mode_hud.alpha = 0;
    n_index++;

    if(n_index >= a_images.size)
      n_index = 0;
  }
}

rage_health_overlay() {
  level endon("disable_rage");
  n_alpha = 0;
  b_fading_to_low_damage = 0;
  flag_wait("nicaragua_intro_complete");

  while(!flag("shattered_1_done")) {
    wait 0.05;
    n_target_damage_alpha = 1.0 - self.health / self.maxhealth;

    if(n_target_damage_alpha > 0.75)
      n_target_damage_alpha = 0.75;

    if(n_alpha < n_target_damage_alpha) {
      rpc("clientscripts/nicaragua", "rage_health_fade_end_notify");
      rpc("clientscripts/nicaragua", "rage_health_fade", n_target_damage_alpha, n_alpha);
      b_fading_to_low_damage = 0;
    } else if(n_alpha > n_target_damage_alpha) {
      if(!b_fading_to_low_damage) {
        if(n_target_damage_alpha == 0)
          b_fading_to_low_damage = 1;

        level thread rage_health_high_damage_to_low(n_alpha, n_target_damage_alpha);
      }
    }

    n_alpha = n_target_damage_alpha;
  }
}

rage_health_high_damage_to_low(n_alpha, n_target_damage_alpha) {
  n_time_to_fade_out = 1;

  if(n_target_damage_alpha < 0.15)
    n_time_to_fade_out = 3;

  rpc("clientscripts/nicaragua", "rage_health_fade", n_alpha, n_target_damage_alpha, n_time_to_fade_out);
}

health_fade_off_watcher(n_alpha_previous) {
  level notify("end_health_fade_off_watcher");
  level endon("end_health_fade_off_watcher");
  n_time = 0;

  while(n_time < 0.75) {
    n_time = n_time + 0.05;
    wait 0.05;
  }

  if(isDefined(level.disable_damage_overlay) && level.disable_damage_overlay)
    rpc("clientscripts/nicaragua", "rage_health_fade", n_alpha_previous, 0, 0.05);
}

rage_sprint_logic() {
  level endon("disable_rage");
  flag_wait("nicaragua_intro_complete");

  while(!flag("shattered_1_started")) {
    if(level.str_rage_mode == "high" && self issprinting()) {
      self setmovespeedscale(1.6);
      rpc("clientscripts/nicaragua", "rage_sprint_play");
      self notify("rage_sprinting");
    } else if(level.str_rage_mode == "high") {
      self setmovespeedscale(1.3);
      rpc("clientscripts/nicaragua", "rage_sprint_stop");
    } else if(level.str_rage_mode != "high" && self issprinting()) {
      self setmovespeedscale(1.3);
      rpc("clientscripts/nicaragua", "rage_sprint_play");
      self notify("rage_sprinting");
    } else {
      self setmovespeedscale(1);
      rpc("clientscripts/nicaragua", "rage_sprint_stop");
    }

    wait 0.15;
  }

  self setmovespeedscale(1);
  rpc("clientscripts/nicaragua", "rage_sprint_stop");
}

stop_rage_vo() {
  flag_clear("rage_weapon_fire_audio_on");
  self notify("end_breathing");
  self notify("end_rage_high_player_damage_vo");
  self notify("end_rage_low_player_fire_vo");
  self notify("end_rage_melee_player_vo");
  self notify("end_rage_sprint_vo");
  self notify("kill_pending_dialog");
  self notify("cancel speaking");
  self notify("done speaking");
  self stopsounds();
  level.str_rage_breath = "none";
}

rage_mode_important_vo(str_vo) {
  flag_set("menendez_important_vo");
  level.player notify("kill_pending_dialog");
  level.player notify("cancel speaking");
  level.player maps\_dialog::say_dialog(str_vo);
  flag_clear("menendez_important_vo");
}

rage_mode_audio_loop(str_vox) {
  self notify("end_breathing");
  self endon("end_breathing");

  if(level.str_rage_breath != str_vox) {
    level.str_rage_breath = str_vox;

    while(!flag("shattered_1_started")) {
      self playsound(str_vox, "breathing_done");
      self waittill("breathing_done");
      wait 0.05;
    }
  }
}

rage_josefina_vo() {
  level endon("shattered_1_started");
  level endon("disable_rage");

  if(!isDefined(self.b_josefina_vo_on))
    self.b_josefina_vo_on = 0;

  if(self.b_josefina_vo_on) {
    return;
  }
  self.b_josefina_vo_on = 1;
  n_array_counter = 0;
  a_josefina_vo = array("jose_help_me_0", "jose_raul_1", "jose_help_me_1");

  while(!flag("shattered_1_started")) {
    wait 55;

    if(flag("rage_off") && flag("nicaragua_intro_complete")) {
      rpc("clientscripts/nicaragua", "rage_mode_fade_image");
      wait 1;
      self maps\_dialog::say_dialog(a_josefina_vo[n_array_counter]);
      wait 1;
      self maps\_dialog::say_dialog("mene_josefina_5");
      n_array_counter++;

      if(n_array_counter == a_josefina_vo.size) {
        a_josefina_vo = random_shuffle(a_josefina_vo);
        n_array_counter = 0;
      }
    }
  }
}

rage_melee_player_vo() {
  self notify("end_rage_melee_player_vo");
  self endon("end_rage_melee_player_vo");
  n_array_counter = 0;
  n_melee = 0;
  a_melee_vo = array("mene_rage_mode_machete_0", "mene_rage_mode_various_0", "mene_rage_mode_various_1", "mene_rage_mode_various_2", "mene_rage_mode_various_3", "mene_rage_mode_various_4", "mene_rage_mode_various_5", "mene_rage_mode_various_6");

  while(!flag("shattered_1_started")) {
    self waittill("weapon_melee");

    if(flag("rage_off") && n_melee == 0) {
      if(!flag("menendez_important_vo")) {
        self notify("cancel speaking");
        self notify("kill_pending_dialog");
        self maps\_dialog::say_dialog(a_melee_vo[n_array_counter]);
        n_array_counter++;

        if(n_array_counter == a_melee_vo.size) {
          a_melee_vo = random_shuffle(a_melee_vo);
          n_array_counter = 0;
        }
      }
    }

    n_melee++;

    if(n_melee == 2)
      n_melee = 0;

    wait 0.05;
  }
}

rage_low_player_fire_vo() {
  self notify("end_rage_low_player_fire_vo");
  self endon("end_rage_low_player_fire_vo");
  n_array_counter = 0;
  a_shooting_vo = array("mene_rage_mode_firing_w_0", "mene_rage_mode_firing_w_1", "mene_rage_mode_firing_w_2", "mene_rage_mode_firing_w_3", "mene_rage_mode_firing_w_4");

  while(!flag("shattered_1_started")) {
    self waittill("weapon_fired");

    if(flag("rage_weapon_fire_audio_on") && self.b_rage_sprint_vo != 1) {
      self.b_rage_fire_vo = 1;
      self maps\_dialog::say_dialog(a_shooting_vo[n_array_counter]);
      self.b_rage_fire_vo = 0;
      n_array_counter++;

      if(n_array_counter == a_shooting_vo.size) {
        a_shooting_vo = random_shuffle(a_shooting_vo);
        n_array_counter = 0;
      }
    }

    wait 9;
  }
}

rage_weapon_fire_vo_on() {
  wait 1;
  flag_set("rage_weapon_fire_audio_on");
}

rage_high_player_damage_vo() {
  level endon("rage_off");
  self notify("end_rage_high_player_damage_vo");
  self endon("end_rage_high_player_damage_vo");
  n_damage_times = 0;

  while(!flag("shattered_1_started")) {
    level waittill("rage_high_player_damage");
    n_damage_times++;

    switch (n_damage_times) {
      case 1:
        rage_mode_important_vo("mene_rage_mode_high_if_0");
        break;
      case 2:
        rage_mode_important_vo("mene_rage_mode_high_if_1");
        break;
      case 3:
        rage_mode_important_vo("mene_rage_mode_high_if_2");
        break;
    }

    wait 6;
  }
}

rage_sprint_vo() {
  self notify("end_rage_sprint_vo");
  self endon("end_rage_sprint_vo");
  n_array_counter = 0;
  a_sprint_vo = array("mene_rage_mode_firing_w_2", "mene_rage_mode_firing_w_3", "mene_rage_mode_firing_w_4", "mene_rage_mode_firing_w_0");

  while(!flag("shattered_1_started")) {
    self waittill("rage_sprinting");

    if(self.b_rage_fire_vo != 1) {
      self.b_rage_sprint_vo = 1;
      self maps\_dialog::say_dialog(a_sprint_vo[n_array_counter]);
      self.b_rage_sprint_vo = 0;
      n_array_counter++;

      if(n_array_counter == a_sprint_vo.size) {
        a_sprint_vo = random_shuffle(a_sprint_vo);
        n_array_counter = 0;
      }
    }

    wait 3;
  }
}
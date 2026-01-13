/********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombies_perk_machines.gsc
********************************************************/

register_interactions() {
  level.interaction_hintstrings["perk_machine_revive"] = &"COOP_PERK_MACHINES_1500";
  level.interaction_hintstrings["perk_machine_tough"] = &"COOP_PERK_MACHINES_2500";
  level.interaction_hintstrings["perk_machine_flash"] = &"COOP_PERK_MACHINES_3000";
  level.interaction_hintstrings["perk_machine_more"] = &"COOP_PERK_MACHINES_4000";
  level.interaction_hintstrings["perk_machine_rat_a_tat"] = &"COOP_PERK_MACHINES_2000";
  level.interaction_hintstrings["perk_machine_run"] = &"COOP_PERK_MACHINES_RUN";
  level.interaction_hintstrings["perk_machine_fwoosh"] = &"COOP_PERK_MACHINES_FWOOSH";
  level.interaction_hintstrings["perk_machine_smack"] = &"COOP_PERK_MACHINES_SMACK";
  level.interaction_hintstrings["perk_machine_zap"] = &"COOP_PERK_MACHINES_ZAP";
  level.interaction_hintstrings["perk_machine_boom"] = &"COOP_PERK_MACHINES_BOOM";
  level.interaction_hintstrings["perk_machine_deadeye"] = &"COOP_PERK_MACHINES_1000";
  level.interaction_hintstrings["perk_machine_change"] = &"COOP_PERK_MACHINES_DLC3_CHANGE";
  scripts\cp\cp_interaction::register_interaction("perk_machine_run", "perk", 1, ::hint_string_func, ::activate_perk_machine, 0, 1, ::init_run_machines_func);
  scripts\cp\cp_interaction::register_interaction("perk_machine_revive", "perk", 1, ::hint_string_func, ::activate_perk_machine, 0, 1, ::init_revive_machines_func);
  scripts\cp\cp_interaction::register_interaction("perk_machine_rat_a_tat", "perk", 1, ::hint_string_func, ::activate_perk_machine_gesture_second, 0, 1, ::init_rat_a_tat_machines_func);
  scripts\cp\cp_interaction::register_interaction("perk_machine_tough", "perk", 1, ::hint_string_func, ::activate_perk_machine, 0, 1, ::init_tough_machines_func);
  scripts\cp\cp_interaction::register_interaction("perk_machine_flash", "perk", 1, ::hint_string_func, ::activate_perk_machine, 0, 1, ::init_flash_machines_func);
  scripts\cp\cp_interaction::register_interaction("perk_machine_more", "perk", 1, ::hint_string_func, ::activate_perk_machine, 0, 1, ::init_more_machines_func);
  scripts\cp\cp_interaction::register_interaction("perk_machine_fwoosh", "perk", 1, ::hint_string_func, ::activate_perk_machine, 0, 1, ::init_fwoosh_machines_func);
  scripts\cp\cp_interaction::register_interaction("perk_machine_smack", "perk", 1, ::hint_string_func, ::activate_perk_machine, 0, 1, ::init_smack_machines_func);
  scripts\cp\cp_interaction::register_interaction("perk_machine_zap", "perk", 1, ::hint_string_func, ::activate_perk_machine, 0, 1, ::init_zap_machines_func);
  scripts\cp\cp_interaction::register_interaction("perk_machine_boom", "perk", 1, ::hint_string_func, ::activate_perk_machine, 0, 1, ::init_boom_machines_func);
  scripts\cp\cp_interaction::register_interaction("perk_machine_deadeye", "perk", 1, ::hint_string_func, ::activate_perk_machine, 0, 1, ::init_deadeye_machines_func);
  scripts\cp\cp_interaction::register_interaction("perk_machine_change", "perk", 1, ::hint_string_func, ::activate_perk_machine, 0, 1, ::init_change_machines_func);
}

register_zombie_perks() {
  level._effect["fire_cloud_1st"] = loadfx("vfx\iw7\core\zombie\vfx_zmb_fire_trail_1st.vfx");
  level._effect["fire_cloud_3rd"] = loadfx("vfx\iw7\core\zombie\vfx_zmb_fire_trail_3rd.vfx");
  level._effect["fire_trail"] = loadfx("vfx\iw7\core\zombie\vfx_zmb_fire_trail_ground_line.vfx");
  level._effect["repulsor_wave_red"] = loadfx("vfx\iw7\_requests\coop\zmb_repulsor_wave_red");
  level._effect["repulsor_view_red"] = loadfx("vfx\iw7\_requests\coop\zmb_repulsor_wave_view_red");
  level._effect["reload_zap_s"] = loadfx("vfx\iw7\core\zombie\weapon\zap\vfx_zmb_zap_radial_s.vfx");
  level._effect["reload_zap_m"] = loadfx("vfx\iw7\core\zombie\weapon\zap\vfx_zmb_zap_radial_m.vfx");
  level._effect["reload_zap_l"] = loadfx("vfx\iw7\core\zombie\weapon\zap\vfx_zmb_zap_radial_l.vfx");
  level._effect["reload_zap_screen"] = loadfx("vfx\iw7\core\zombie\weapon\zap\vfx_zmb_zap_radial_sreen.vfx");
  scripts\cp\perks\perkmachines::register_perk_callback("perk_machine_tough", ::give_tough_perk, ::take_tough_perk);
  scripts\cp\perks\perkmachines::register_perk_callback("perk_machine_revive", ::give_revive_perk, ::take_revive_perk);
  scripts\cp\perks\perkmachines::register_perk_callback("perk_machine_flash", ::give_flash_perk, ::take_flash_perk);
  scripts\cp\perks\perkmachines::register_perk_callback("perk_machine_more", ::give_more_perk, ::take_more_perk);
  scripts\cp\perks\perkmachines::register_perk_callback("perk_machine_rat_a_tat", ::give_rat_a_tat_perk, ::take_rat_a_tat_perk);
  scripts\cp\perks\perkmachines::register_perk_callback("perk_machine_run", ::give_run_perk, ::take_run_perk);
  scripts\cp\perks\perkmachines::register_perk_callback("perk_machine_fwoosh", ::give_fwoosh_perk, ::take_fwoosh_perk);
  scripts\cp\perks\perkmachines::register_perk_callback("perk_machine_smack", ::give_smack_perk, ::take_smack_perk);
  scripts\cp\perks\perkmachines::register_perk_callback("perk_machine_zap", ::give_zap_perk, ::take_zap_perk);
  scripts\cp\perks\perkmachines::register_perk_callback("perk_machine_boom", ::give_boom_perk, ::take_boom_perk);
  scripts\cp\perks\perkmachines::register_perk_callback("perk_machine_deadeye", ::give_deadeye_perk, ::take_deadeye_perk);
  scripts\cp\perks\perkmachines::register_perk_callback("perk_machine_change", ::give_change_perk, ::take_change_perk);
  if(isDefined(level.perk_registration_func)) {
    [[level.perk_registration_func]]();
  }

  level.mutilation_perk_func = ::should_mutilate_perk_check;
  level thread update_perk_machines_based_on_num_players();
}

update_perk_machines_based_on_num_players() {
  for(;;) {
    level scripts\engine\utility::waittill_any_3("player_count_determined", "multiple_players");
    update_revive_perks();
  }
}

init_revive_machines_func() {
  init_perk_machines_func("perk_machine_revive");
}

init_tough_machines_func() {
  init_perk_machines_func("perk_machine_tough");
}

init_flash_machines_func() {
  init_perk_machines_func("perk_machine_flash");
}

init_more_machines_func() {
  init_perk_machines_func("perk_machine_more");
}

init_rat_a_tat_machines_func() {
  init_perk_machines_func("perk_machine_rat_a_tat");
}

init_run_machines_func() {
  init_perk_machines_func("perk_machine_run");
}

init_fwoosh_machines_func() {
  init_perk_machines_func("perk_machine_fwoosh");
}

init_smack_machines_func() {
  init_perk_machines_func("perk_machine_smack");
}

init_zap_machines_func() {
  init_perk_machines_func("perk_machine_zap");
}

init_boom_machines_func() {
  init_perk_machines_func("perk_machine_boom");
}

init_deadeye_machines_func() {
  init_perk_machines_func("perk_machine_deadeye");
}

init_change_machines_func() {
  level.change_chew_explosion_func = ::change_chew_explosion;
  var_0 = getdvar("ui_mapname");
  if(var_0 == "cp_town" || var_0 == "cp_final") {
    init_perk_machines_func("perk_machine_change");
  }
}

delay_rotate_func(var_0) {
  wait(var_0);
  var_1 = getent("change_chews_lower", "targetname");
  if(isDefined(var_1)) {
    var_2 = getdvar("ui_mapname");
    if(var_2 == "cp_town") {
      var_1.angles = (0, 276, 0);
      level thread rotate_loop_by_targetname("change_chews_upper", (0, 276, 0), (348, 276, 0));
    }

    if(var_2 == "cp_final") {
      var_1.angles = (0, 156, 0);
      level thread rotate_loop_by_targetname("change_chews_upper", (0, 156, 0), (348, 156, 0));
    }
  }
}

rotate_loop_by_targetname(var_0, var_1, var_2) {
  var_3 = getent(var_0, "targetname");
  for(;;) {
    var_3 rotateto(var_2, 1);
    var_3 waittill("rotatedone");
    var_3 rotateto(var_1, 1);
    var_3 waittill("rotatedone");
  }
}

init_perk_machines_func(var_0) {
  var_1 = scripts\engine\utility::getstructarray(var_0, "script_noteworthy");
  foreach(var_4, var_3 in var_1) {
    var_3 thread revive_power_on_func(var_4);
  }
}

revive_power_on_func(var_0) {
  var_1 = undefined;
  if(isDefined(self.target)) {
    self.setminimap = getent(self.target, "targetname");
    self.setminimap setlightintensity(0);
  }

  init_perk_machine();
  scripts\engine\utility::flag_wait("player_count_determined");
  if(self.script_noteworthy == "perk_machine_revive" && scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    if(var_0 > 0) {
      wait(0.1 * var_0);
    }

    turn_on_light_and_power();
    return;
  }

  if(scripts\engine\utility::istrue(self.requires_power) && isDefined(self.power_area)) {
    for(;;) {
      var_2 = level scripts\engine\utility::waittill_any_return_no_endon_death_3("power_on", self.power_area + " power_on", "power_off");
      if(var_2 == "power_off") {
        turn_off_light_and_power();
        continue;
      }

      if(var_0 > 0) {
        wait(0.1 * var_0);
      }

      turn_on_light_and_power();
    }

    return;
  }

  if(var_0 > 0) {
    wait(0.1 * var_0);
  }

  turn_on_light_and_power();
}

turn_on_light_and_power() {
  self.powered_on = 1;
  if(scripts\cp\utility::map_check(0)) {
    level thread scripts\cp\cp_vo::add_to_nag_vo("dj_perkstation_use_nag", "zmb_dj_vo", 60, 15, 3, 0);
  }

  foreach(var_1 in level.players) {
    var_1 thread scripts\cp\cp_vo::add_to_nag_vo("nag_try_perk", "zmb_comment_vo", 60, 270, 6, 1);
  }

  var_3 = "mus_zmb_tuffnuff_purchase";
  switch (self.script_noteworthy) {
    case "perk_machine_revive":
      var_3 = "mus_zmb_upnatoms_attract";
      break;

    case "perk_machine_flash":
      var_3 = "mus_zmb_quickies_attract";
      break;

    case "perk_machine_more":
      var_3 = "mus_zmb_mulemunchies_attract";
      break;

    case "perk_machine_rat_a_tat":
      var_3 = "mus_zmb_bangbangs_attract";
      break;

    case "perk_machine_run":
      var_3 = "mus_zmb_racinstripes_attract";
      break;

    case "perk_machine_fwoosh":
      var_3 = "mus_zmb_trailblazer_attract";
      break;

    case "perk_machine_smack":
      var_3 = "mus_zmb_slappytaffy_attract";
      break;

    case "perk_machine_zap":
      var_3 = "mus_zmb_bluebolts_attract";
      break;

    case "perk_machine_boom":
      var_3 = "mus_zmb_bombstoppers_attract";
      break;

    case "perk_machine_deadeye":
      var_3 = "mus_zmb_deadeye_attract";
      break;

    case "perk_machine_change":
      var_3 = "mus_zmb_changechews_attract";
      break;
  }

  level scripts\cp\cp_music_and_dialog::add_to_ambient_sound_queue(var_3, self.perk_machine_top.origin + (0, 0, 50), 120, 120, 250000, 100, 10);
  if(isDefined(self.power_area) && self.power_area == "disco_bottom") {
    var_4 = spawn("script_origin", (-1647, 3091, 1236));
    playsoundatpos((-1647, 3091, 1236), "power_buy_neon_vending_turn_on");
    wait(0.05);
    var_4 playLoopSound("power_buy_neon_vending_lp");
  }

  if(isDefined(self.setminimap)) {
    var_5 = 1;
    if(isDefined(self.setminimap.script_intensity_01)) {
      var_5 = self.setminimap.script_intensity_01;
    }

    for(var_6 = 0; var_6 < 4; var_6++) {
      self.setminimap setlightintensity(var_5);
      if(isDefined(self.perk_machine_top)) {
        self.perk_machine_top setscriptablepartstate("perk_sign", "powered_on");
      }

      wait(randomfloat(1));
      if(isDefined(self.perk_machine_top)) {
        self.perk_machine_top setscriptablepartstate("perk_sign", "off");
      }

      self.setminimap setlightintensity(0);
      wait(randomfloat(1));
    }

    var_5 = 1;
    if(isDefined(self.setminimap.script_intensity_01)) {
      var_5 = self.setminimap.script_intensity_01;
    }

    self.setminimap setlightintensity(var_5);
  }

  if(isDefined(self.perk_machine_top)) {
    self.perk_machine_top setscriptablepartstate("perk_sign", "powered_on");
  }

  if(self.perk_type == "perk_machine_revive") {
    wait(1);
    self.perk_machine_top setscriptablepartstate("perk_sign", "up");
  }

  if(self.perk_type == "perk_machine_change") {
    delay_rotate_func(10);
  }
}

turn_off_light_and_power() {
  if(isDefined(self.setminimap)) {
    self.setminimap setlightintensity(0);
  }

  self.powered_on = 0;
}

init_perk_machine() {
  self.perk_type = self.script_noteworthy;
  self.last_time_used = [];
  var_0 = get_array_of_perk_machines_by_type(self.perk_type);
  self.perk_machine_top = scripts\engine\utility::getclosest(self.origin, var_0);
  if(isDefined(self.perk_machine_top)) {
    self.perk_machine_top setscriptablepartstate("perk_sign", "off");
    self.perk_machine_top setnonstick(1);
  }
}

get_array_of_perk_machines_by_type(var_0) {
  var_1 = "";
  switch (var_0) {
    case "perk_machine_revive":
      var_1 = "perk_machine_up_n_atoms_sign";
      break;

    case "perk_machine_tough":
      var_1 = "perk_machine_tuff_nuff_sign";
      break;

    case "perk_machine_run":
      var_1 = "perk_machine_racin_stripes_sign";
      break;

    case "perk_machine_flash":
      var_1 = "perk_machine_quickies_sign";
      break;

    case "perk_machine_more":
      var_1 = "perk_machine_mule_munchies_sign";
      break;

    case "perk_machine_rat_a_tat":
      var_1 = "perk_machine_bang_bangs_sign";
      break;

    case "perk_machine_boom":
      var_1 = "perk_machine_bombstoppers_sign";
      break;

    case "perk_machine_zap":
      var_1 = "perk_machine_blue_bolts_sign";
      break;

    case "perk_machine_fwoosh":
      var_1 = "perk_machine_trail_blazers_sign";
      break;

    case "perk_machine_smack":
      var_1 = "perk_machine_slappy_taffy_sign";
      break;

    case "perk_machine_deadeye":
      var_1 = "perk_machine_deadeye_sign";
      break;

    case "perk_machine_change":
      var_1 = "perk_machine_change_chews_sign";
      break;

    default:
      break;
  }

  return getscriptablearray(var_1, "targetname");
}

activate_perk_machine(var_0, var_1) {
  var_1 endon("disconnect");
  var_2 = [];
  if(isDefined(var_0.script_noteworthy)) {
    var_2 = strtok(var_0.script_noteworthy, "_");
  }

  if(isDefined(var_0.last_time_used) && isDefined(var_0.last_time_used[var_1.name])) {
    return;
  }

  var_3 = scripts\engine\utility::istrue(var_2[0] == "crafted");
  if(!var_3 && var_1 scripts\cp\utility::has_zombie_perk(var_0.perk_type)) {
    if(soundexists("perk_machine_remove_perk")) {
      var_1 playlocalsound("perk_machine_remove_perk");
    }

    if(var_0.perk_type == "perk_machine_revive") {
      var_1.self_revives_purchased--;
    }

    var_1 take_zombies_perk(var_0.perk_type);
    var_1 scripts\cp\cp_interaction::refresh_interaction();
    return;
  }

  if(isDefined(var_1.zombies_perks) && var_1.zombies_perks.size > 4 && !scripts\engine\utility::istrue(var_1.have_gns_perk)) {
    return;
  }

  if(var_1 scripts\cp\utility::has_zombie_perk(var_0.perk_type)) {
    return;
  }

  level thread turn_off_interaction_for_time(var_0, var_1, 2000);
  level thread play_perk_machine_purchase_sound(var_0, var_1);
  scripts\cp\cp_vo::remove_from_nag_vo("dj_perkstation_use_nag");
  if(var_1 scripts\cp\utility::is_consumable_active("perk_refund") && !var_3) {
    var_1 scripts\cp\cp_persistence::give_player_currency(1000, undefined, undefined, 1, "bonus");
    var_1 scripts\cp\utility::notify_used_consumable("perk_refund");
  }

  var_1 play_perk_gesture(var_0.perk_type);
  var_1 give_zombies_perk(var_0.perk_type, 1);
}

activate_perk_machine_gesture_second(var_0, var_1) {
  var_1 endon("disconnect");
  var_2 = [];
  if(isDefined(var_0.script_noteworthy)) {
    var_2 = strtok(var_0.script_noteworthy, "_");
  }

  if(isDefined(var_0.last_time_used) && isDefined(var_0.last_time_used[var_1.name])) {
    return;
  }

  var_3 = scripts\engine\utility::istrue(var_2[0] == "crafted");
  if(!var_3 && var_1 scripts\cp\utility::has_zombie_perk(var_0.perk_type)) {
    if(soundexists("perk_machine_remove_perk")) {
      var_1 playlocalsound("perk_machine_remove_perk");
    }

    if(var_0.perk_type == "perk_machine_revive") {
      var_1.self_revives_purchased--;
    }

    var_1 take_zombies_perk(var_0.perk_type);
    var_1 scripts\cp\cp_interaction::refresh_interaction();
    return;
  }

  if(isDefined(var_1.zombies_perks) && var_1.zombies_perks.size > 4) {
    return;
  }

  if(var_1 scripts\cp\utility::has_zombie_perk(var_0.perk_type)) {
    return;
  }

  level thread turn_off_interaction_for_time(var_0, var_1, 2000);
  level thread play_perk_machine_purchase_sound(var_0, var_1);
  scripts\cp\cp_vo::remove_from_nag_vo("dj_perkstation_use_nag");
  if(var_1 scripts\cp\utility::is_consumable_active("perk_refund") && !var_3) {
    var_1 scripts\cp\cp_persistence::give_player_currency(1000, undefined, undefined, 1, "bonus");
    var_1 scripts\cp\utility::notify_used_consumable("perk_refund");
  }

  var_1 give_zombies_perk(var_0.perk_type, 1);
  wait(1);
  var_1 play_perk_gesture(var_0.perk_type);
}

give_zombies_perk(var_0, var_1) {
  if(!isDefined(self.zombies_perks)) {
    self.zombies_perks = [];
  }

  self.zombies_perks[var_0] = 1;
  scripts\cp\zombies\zombie_analytics::log_perk_machine_used(level.wave_num, var_0);
  scripts\cp\cp_persistence::increment_player_career_perks_used(self);
  self[[level.coop_perk_callbacks[var_0].set]]();
  if(isDefined(self.sub_perks) && isDefined(self.sub_perks[var_0])) {
    var_0 = self.sub_perks[var_0];
  }

  thread set_ui_omnvar_for_perks(var_0);
  if(scripts\engine\utility::istrue(var_1)) {
    scripts\cp\cp_merits::processmerit("mt_purchase_perks");
  }

  if(isDefined(level.additional_give_perk)) {
    self[[level.additional_give_perk]](var_0);
  }

  return 1;
}

give_zombies_perk_immediate(var_0, var_1) {
  if(scripts\cp\utility::has_zombie_perk(var_0)) {
    return;
  }

  if(!isDefined(self.zombies_perks)) {
    self.zombies_perks = [];
  }

  self.zombies_perks[var_0] = 1;
  self[[level.coop_perk_callbacks[var_0].set]]();
  if(isDefined(self.sub_perks) && isDefined(self.sub_perks[var_0])) {
    var_0 = self.sub_perks[var_0];
  }

  if(scripts\engine\utility::istrue(var_1)) {
    thread set_ui_omnvar_for_perks(var_0);
  }

  return 1;
}

play_perk_machine_purchase_sound(var_0, var_1) {
  var_2 = [];
  var_3 = "";
  switch (var_0.name) {
    case "perk_machine_revive":
      var_2 = ["mus_zmb_upnatoms_purchase"];
      if(level.players.size < 2) {
        var_3 = "purchase_perk_revive_solo";
      } else {
        var_3 = "purchase_perk_upnatoms";
      }
      break;

    case "perk_machine_more":
      var_2 = ["mus_zmb_mulemunchies_purchase"];
      var_3 = "purchase_perk_nulemunchies";
      break;

    case "perk_machine_run":
      var_2 = ["mus_zmb_racinstripes_purchase"];
      var_3 = "purchase_perk_racinstripes";
      break;

    case "perk_machine_flash":
      var_2 = ["mus_zmb_quickies_purchase"];
      var_3 = "purchase_perk_quickies";
      break;

    case "perk_machine_tough":
      var_2 = ["mus_zmb_tuffnuff_purchase"];
      var_3 = "purchase_perk_tuffnuff";
      break;

    case "perk_machine_rat_a_tat":
      var_2 = ["mus_zmb_bangbangs_purchase"];
      var_3 = "purchase_perk_bangbangs";
      break;

    case "perk_machine_fwoosh":
      var_2 = ["mus_zmb_trailblazer_purchase"];
      var_3 = "purchase_perk_trailblazers";
      break;

    case "perk_machine_smack":
      var_2 = ["mus_zmb_slappytaffy_purchase"];
      var_3 = "purchase_perk_slappytaffy";
      break;

    case "perk_machine_boom":
      var_2 = ["mus_zmb_bombstoppers_purchase"];
      var_3 = "purchase_perk_bombstoppers";
      break;

    case "perk_machine_zap":
      var_2 = ["mus_zmb_bluebolts_purchase"];
      var_3 = "purchase_perk_bluebolts";
      break;

    case "perk_machine_deadeye":
      var_2 = ["mus_zmb_deadeye_purchase"];
      var_3 = "purchase_perk_deadeyedewdrop";
      break;

    case "perk_machine_change":
      var_2 = ["mus_zmb_changechews_purchase"];
      var_3 = "purchase_perk_changechews";
      break;
  }

  var_1 thread scripts\cp\cp_vo::try_to_play_vo(var_3, "zmb_comment_vo", "low", 10, 0, 1, 0, 50);
  var_1 thread play_perk_vo_additional(var_3);
  if(!var_2.size) {
    return undefined;
  }

  var_4 = scripts\engine\utility::random(var_2);
  if(isDefined(var_4) && soundexists(var_4)) {
    playsoundatpos(var_0.origin, var_4);
    var_5 = lookupsoundlength(var_4);
    wait(var_5 / 1000);
  }
}

play_perk_vo_additional(var_0) {
  wait(scripts\cp\cp_vo::get_sound_length(self.vo_prefix + var_0) + 5);
  thread scripts\cp\cp_vo::try_to_play_vo("purchase_perk", "zmb_comment_vo");
}

play_perk_machine_deny_sound(var_0, var_1) {
  if(soundexists("perk_machine_deny")) {
    var_1 playlocalsound("perk_machine_deny");
  }
}

set_ui_omnvar_for_perks(var_0) {
  var_1 = tablelookup("cp\zombies\zombie_perks_bit_mask_table.csv", 1, var_0, 0);
  var_2 = int(var_1);
  self setclientomnvarbit("zm_active_perks", var_2 - 1, 1);
}

play_perk_gesture(var_0) {
  if(isDefined(self.disableplunger) || isDefined(self.disablecrank)) {
    self notify("end_cutie_gesture_loop");
    wait(0.05);
  }

  self playlocalsound("perk_purchase_foley_candy_box");
  self.playingperkgesture = 1;
  var_1 = "iw7_candybang_zm";
  switch (var_0) {
    case "perk_machine_boom":
      var_1 = "iw7_candybomb_zm";
      break;

    case "perk_machine_zap":
      var_1 = "iw7_candyblue_zm";
      break;

    case "perk_machine_fwoosh":
      var_1 = "iw7_candytrail_zm";
      break;

    case "perk_machine_revive":
      var_1 = "iw7_candyup_zm";
      break;

    case "perk_machine_flash":
      var_1 = "iw7_candyquickies_zm";
      break;

    case "perk_machine_tough":
      var_1 = "iw7_candytuff_zm";
      break;

    case "perk_machine_smack":
      var_1 = "iw7_candyslappy_zm";
      break;

    case "perk_machine_more":
      var_1 = "iw7_candymule_zm";
      break;

    case "perk_machine_run":
      var_1 = "iw7_candyracin_zm";
      break;

    case "perk_machine_rat_a_tat":
      var_1 = "iw7_candybang_zm";
      break;

    case "perk_machine_deadeye":
      var_1 = "iw7_candydeadeye_zm";
      break;

    case "perk_machine_change":
      var_1 = "iw7_candychange_zm";
      break;
  }

  thread scripts\cp\utility::firegesturegrenade(self, var_1);
  while(self getcurrentoffhand() == var_1) {
    wait(0.1);
  }

  self.playingperkgesture = undefined;
}

take_zombies_perk(var_0) {
  if(!scripts\cp\utility::has_zombie_perk(var_0)) {
    return 0;
  }

  var_1 = var_0;
  if(isDefined(self.sub_perks) && isDefined(self.sub_perks[var_0])) {
    var_1 = self.sub_perks[var_0];
  }

  scripts\cp\zombies\zombie_analytics::log_perk_returned(level.wave_num, var_0);
  self[[level.coop_perk_callbacks[var_0].unset]]();
  var_2 = tablelookup("cp\zombies\zombie_perks_bit_mask_table.csv", 1, var_1, 0);
  var_3 = int(var_2);
  self setclientomnvarbit("zm_active_perks", var_3 - 1, 0);
  if(isDefined(level.take_perks_func)) {
    self[[level.take_perks_func]](var_0);
  }

  return 1;
}

sawblade_perk_animation() {
  self setclientomnvar("zombie_coaster_ticket_earned", 1);
  wait(3);
  self setclientomnvar("zombie_coaster_ticket_earned", -1);
}

take_zombies_perk_immediate(var_0) {
  if(!scripts\cp\utility::has_zombie_perk(var_0)) {
    return 0;
  }

  self[[level.coop_perk_callbacks[var_0].unset]]();
  var_1 = var_0;
  if(isDefined(self.sub_perks) && isDefined(self.sub_perks[var_0])) {
    var_1 = self.sub_perks[var_0];
  }

  var_2 = tablelookup("cp\zombies\zombie_perks_bit_mask_table.csv", 1, var_1, 0);
  var_3 = int(var_2);
  self setclientomnvarbit("zm_active_perks", var_3 - 1, 0);
  return 1;
}

hint_string_func(var_0, var_1) {
  if(!scripts\engine\utility::istrue(var_0.powered_on)) {
    if(isDefined(level.needspowerstring)) {
      return level.needspowerstring;
    } else {
      return &"COOP_INTERACTIONS_REQUIRES_POWER";
    }
  }

  if(isDefined(var_0.last_time_used) && isDefined(var_0.last_time_used[var_1.name])) {
    return "";
  }

  if(var_1 scripts\cp\utility::has_zombie_perk(var_0.perk_type)) {
    return &"COOP_PERK_MACHINES_REMOVE_PERK";
  }

  if(isDefined(self.zombies_perks) && self.zombies_perks.size > 4 && !scripts\engine\utility::istrue(self.have_gns_perk)) {
    return &"COOP_PERK_MACHINES_PERK_SLOTS_FULL";
  }

  if(var_0.script_noteworthy == "perk_machine_revive" && scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    return &"COOP_PERK_MACHINES_SELF_REVIVE";
  }

  return level.interaction_hintstrings[var_0.script_noteworthy];
}

turn_off_interaction_for_time(var_0, var_1, var_2) {
  var_3 = gettime();
  var_0.last_time_used[var_1.name] = var_3;
  while(gettime() - var_3 < var_2) {
    wait(0.1);
  }

  var_0.last_time_used[var_1.name] = undefined;
}

give_tough_perk() {
  level notify("tough_purchased", self);
  self.perk_data["health"].max_health = 200;
  self.maxhealth = self.perk_data["health"].max_health;
  self.health = self.maxhealth;
  self notify("health_perk_upgrade");
}

take_tough_perk() {
  self.perk_data["health"].max_health = 100;
  if(self.health > self.perk_data["health"].max_health) {
    self.health = self.perk_data["health"].max_health;
  }

  self.maxhealth = self.perk_data["health"].max_health;
  remove_zombies_perk_icon_and_index("perk_machine_tough");
}

give_revive_perk() {
  if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && self.self_revives_purchased < self.max_self_revive_machine_use) {
    scripts\cp\cp_laststand::set_last_stand_count(self, 1);
    thread manage_self_revive();
    self.self_revives_purchased++;
    return;
  }

  self.perk_data["medic"].revive_time_scalar = 2;
}

adjust_last_stand_type() {
  self endon("turn_off_self_revive");
  self endon("self_revive_removed");
  for(;;) {
    level scripts\engine\utility::waittill_any_3("player_spawned", "disconnected");
    self notify("remove_self_revive");
  }
}

manage_self_revive() {
  self endon("turn_off_self_revive");
  var_0 = scripts\engine\utility::waittill_any_return("last_stand", "death", "remove_self_revive");
  if(var_0 == "last_stand") {
    self waittill("revive");
    take_zombies_perk("perk_machine_revive");
  } else {
    take_zombies_perk("perk_machine_revive");
  }

  self notify("self_revive_removed");
}

take_revive_perk() {
  if(!scripts\cp\utility::isplayingsolo() && !level.only_one_player) {
    self.perk_data["medic"].revive_time_scalar = 1;
  } else if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    scripts\cp\cp_laststand::set_last_stand_count(self, 0);
  }

  remove_zombies_perk_icon_and_index("perk_machine_revive");
}

update_revive_perks() {
  foreach(var_1 in level.players) {
    if(var_1 scripts\cp\utility::has_zombie_perk("perk_machine_revive")) {
      var_1 notify("turn_off_self_revive");
      var_1 scripts\cp\cp_laststand::set_last_stand_count(var_1, 0);
      var_1.perk_data["medic"].revive_time_scalar = 2;
    }
  }
}

give_deadeye_perk() {
  self.old_view_kick_scale = self getviewkickscale();
  self setviewkickscale(0);
  self player_recoilscaleon(0);
  self setaimspreadmovementscale(0.1);
  self.onhelisniper = 1;
  scripts\cp\utility::giveperk("specialty_quickdraw");
  scripts\cp\utility::giveperk("specialty_bulletaccuracy");
  scripts\cp\utility::_setperk("specialty_autoaimhead");
  thread run_deadeye_charge_watcher();
}

take_deadeye_perk() {
  self setviewkickscale(self.old_view_kick_scale);
  self player_recoilscaleon(100);
  self setaimspreadmovementscale(1);
  self.onhelisniper = undefined;
  scripts\cp\utility::_unsetperk("specialty_quickdraw");
  scripts\cp\utility::_unsetperk("specialty_autoaimhead");
  scripts\cp\utility::_unsetperk("specialty_bulletaccuracy");
  self notify("end_deadeye_charge_watcher");
  self.deadeye_charge = undefined;
  remove_zombies_perk_icon_and_index("perk_machine_deadeye");
}

run_deadeye_charge_watcher() {
  self endon("disconnect");
  self endon("end_deadeye_charge_watcher");
  self.deadeye_charge = undefined;
  var_0 = undefined;
  var_1 = undefined;
  for(;;) {
    var_2 = scripts\cp\utility::getweapontoswitchbackto();
    var_3 = func_9B58(var_2);
    if(self adsbuttonpressed() && !scripts\engine\utility::istrue(self.no_deadeye) && !var_3) {
      var_4 = gettime();
      if(!isDefined(var_0)) {
        var_0 = var_4;
        var_1 = var_4 + 2000;
      } else if(var_4 > var_1) {
        if(!scripts\engine\utility::istrue(self.deadeye_charge)) {
          self setclientomnvar("damage_feedback", "pink_arcane_cp");
          self setclientomnvar("damage_feedback_notify", gettime());
          self playlocalsound("gauntlet_armory_hack_wrist_second");
        }

        self.deadeye_charge = 1;
      }
    } else {
      self.deadeye_charge = undefined;
      var_0 = undefined;
      var_1 = undefined;
    }

    scripts\engine\utility::waitframe();
  }
}

give_change_perk() {
  var_0 = randomintrange(1, 5);
  self.sub_perks["perk_machine_change"] = "perk_machine_change" + var_0;
  thread wait_for_change_chews_update();
}

take_change_perk() {
  self notify("stop_change_chews_update");
  self.sub_perks["perk_machine_change"] = undefined;
  remove_zombies_perk_icon_and_index("perk_machine_change");
}

wait_for_change_chews_update() {
  self endon("stop_change_chews_update");
  self endon("disconnect");
  for(;;) {
    self waittill("change_chews_damage", var_0, var_1);
    if(var_1 > 30) {
      continue;
    }

    if(scripts\engine\utility::istrue(self.playing_ghosts_n_skulls)) {
      continue;
    }

    if(isDefined(self.sub_perks) && isDefined(self.sub_perks["perk_machine_change"])) {
      var_2 = self.sub_perks["perk_machine_change"];
      var_3 = tablelookup("cp\zombies\zombie_perks_bit_mask_table.csv", 1, var_2, 0);
      var_4 = int(var_3);
      self setclientomnvarbit("zm_active_perks", var_4 - 1, 0);
    }

    update_change_chews_sub_perk();
    if(isDefined(self.sub_perks) && isDefined(self.sub_perks["perk_machine_change"])) {
      var_2 = self.sub_perks["perk_machine_change"];
      thread set_ui_omnvar_for_perks(var_2);
    }

    while(self.health < 31) {
      wait(0.1);
    }

    wait(0.1);
  }
}

update_change_chews_sub_perk() {
  var_0 = self.sub_perks["perk_machine_change"];
  var_1 = 1;
  switch (var_0) {
    case "perk_machine_change1":
      var_1 = 1;
      break;

    case "perk_machine_change2":
      var_1 = 2;
      break;

    case "perk_machine_change3":
      var_1 = 3;
      break;

    case "perk_machine_change4":
      var_1 = 4;
      break;

    default:
      break;
  }

  var_2 = var_1 + 1;
  if(var_2 > 4) {
    var_2 = 1;
  }

  self.sub_perks["perk_machine_change"] = "perk_machine_change" + var_2;
}

change_chew_explosion(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\engine\utility::isbulletdamage(var_3) || var_3 == "MOD_EXPLOSIVE_BULLET" && var_5 != "none";
  if(!var_6) {
    return;
  }

  if(!scripts\cp\utility::isheadshot(var_4, var_5, var_3, var_0)) {
    return;
  }

  if(!isDefined(self.agent_type) || self.agent_type != "generic_zombie") {
    return;
  }

  thread explode_head_with_fx(var_0, var_5, var_2, undefined, undefined);
}

explode_head_shards(var_0, var_1, var_2, var_3) {
  var_4 = scripts\cp\utility::weaponhasattachment(var_3, "pap1") || scripts\cp\utility::weaponhasattachment(var_3, "pap2");
  var_5 = var_3;
  var_6 = [];
  var_6 = level.spawned_enemies;
  var_7 = [var_2];
  var_8 = 150;
  if(var_4) {
    var_8 = 300;
  }

  var_9 = scripts\engine\utility::get_array_of_closest(var_1, var_6, var_7, undefined, var_8, 0);
  foreach(var_0B in var_9) {
    if(isDefined(var_0B.agent_type) && var_0B.agent_type == "crab_mini" || var_0B.agent_type == "crab_brute") {
      var_0C = 100;
    } else {
      var_0C = 100000;
    }

    var_0B dodamage(var_0C, var_1, var_0, var_0, "MOD_EXPLOSIVE", var_5);
  }
}

explode_head_with_fx(var_0, var_1, var_2, var_3, var_4) {
  self.head_is_exploding = 1;
  var_4 = self gettagorigin("J_Spine4");
  foreach(var_6 in level.players) {
    if(distance(var_6.origin, var_4) <= 350) {
      var_6 thread scripts\cp\zombies\zombies_weapons::showonscreenbloodeffects();
    }
  }

  if(isDefined(self.headmodel)) {
    self detach(self.headmodel);
  }

  self setscriptablepartstate("head", "hide");
}

give_flash_perk() {
  level notify("quickies_purchased", self);
  scripts\cp\utility::giveperk("specialty_fastreload");
  scripts\cp\utility::giveperk("specialty_quickswap");
}

take_flash_perk() {
  scripts\cp\utility::_unsetperk("specialty_fastreload");
  scripts\cp\utility::_unsetperk("specialty_quickswap");
  remove_zombies_perk_icon_and_index("perk_machine_flash");
}

give_more_perk() {
  self.perk_data["pistol"].pistol_overkill = 1;
  thread listen_for_mule_icon();
}

listen_for_mule_icon() {
  self endon("mule_munchies_sold");
  self endon("disconnect");
  for(;;) {
    self waittill("weapon_change");
    var_0 = self getcurrentprimaryweapon();
    var_1 = get_culled_primary_list();
    if(var_1.size > 3) {
      var_0 = self getcurrentprimaryweapon();
      if(var_0 == var_1[var_1.size - 1]) {
        self setclientomnvar("zm_mule_munchies_weapon_icon", 1);
        self.mule_weapon = var_0;
      } else {
        self setclientomnvar("zm_mule_munchies_weapon_icon", 0);
      }

      continue;
    }

    self setclientomnvar("zm_mule_munchies_weapon_icon", 0);
  }
}

take_more_perk() {
  self.perk_data["pistol"].pistol_overkill = 0;
  var_0 = get_culled_primary_list();
  var_1 = 0;
  var_2 = scripts\cp\utility::getvalidtakeweapon();
  if(var_0.size > 3) {
    var_3 = var_0[var_0.size - 1];
    if(var_3 == var_2) {
      var_1 = 1;
    }

    self takeweapon(var_3);
    if(var_1) {
      self switchtoweaponimmediate(var_0[var_0.size - 2]);
    }
  }

  self.mule_weapon = undefined;
  scripts\cp\utility::updatelaststandpistol();
  remove_zombies_perk_icon_and_index("perk_machine_more");
  self notify("mule_munchies_sold");
  self setclientomnvar("zm_mule_munchies_weapon_icon", 0);
}

get_culled_primary_list() {
  var_0 = [];
  var_1 = self getweaponslistprimaries();
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] == "iw7_gunless_zm") {
      continue;
    }

    if(var_1[var_2] == "iw7_entangler_zm") {
      continue;
    }

    if(var_1[var_2] == "iw7_entangler2_zm") {
      continue;
    }

    var_3 = strtok(var_1[var_2], "_");
    if(var_3[0] != "alt") {
      var_0[var_0.size] = var_1[var_2];
    }
  }

  return var_0;
}

give_rat_a_tat_perk() {
  level notify("bangbangs_purchased", self);
  self.perk_data["damagemod"].bullet_damage_scalar = 2;
  var_0 = self getweaponslistprimaries();
  var_1 = scripts\cp\utility::getweapontoswitchbackto();
  foreach(var_3 in var_0) {
    if(issubstr(var_3, "alt") || issubstr(var_3, "knife") || issubstr(var_3, "entangler")) {
      continue;
    }

    var_4 = getweaponattachments(var_3);
    var_5 = scripts\cp\utility::getcurrentcamoname(var_3);
    var_6 = scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_3, "doubletap", var_4, 1, var_5);
    var_7 = func_9B58(var_6);
    if(isDefined(var_6)) {
      var_8 = undefined;
      var_9 = undefined;
      var_0A = self getweaponammoclip(var_3);
      var_0B = self getweaponammostock(var_3);
      if(var_7) {
        var_8 = self getweaponammoclip(var_3, "left");
        var_9 = self getweaponammoclip(var_3, "right");
      }

      self takeweapon(var_3);
      var_6 = scripts\cp\utility::_giveweapon(var_6, undefined, undefined, 1);
      if(var_7) {
        if(issubstr(var_6, "akimbofmg")) {
          self setweaponammoclip(var_6, var_8 + var_9);
        } else {
          self setweaponammoclip(var_6, var_8, "left");
          self setweaponammoclip(var_6, var_9, "right");
        }
      } else {
        self setweaponammoclip(var_6, var_0A);
      }

      self setweaponammostock(var_6, var_0B);
      if(getweaponbasename(var_6) == getweaponbasename(var_1)) {
        var_1 = var_6;
      }
    }
  }

  if(!scripts\engine\utility::istrue(self.kung_fu_mode)) {
    self switchtoweaponimmediate(var_1);
  }
}

func_9B58(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = issubstr(var_0, "akimbo");
  if(!var_1) {
    var_1 = issubstr(var_0, "g18pap2");
  }

  return var_1;
}

take_rat_a_tat_perk() {
  self.perk_data["damagemod"].bullet_damage_scalar = 1;
  remove_zombies_perk_icon_and_index("perk_machine_rat_a_tat");
  if(isDefined(level.mode_weapons_allowed) && scripts\engine\utility::array_contains(level.mode_weapons_allowed, getweaponbasename(self getcurrentweapon()))) {
    var_0 = self getcurrentweapon();
  } else {
    var_0 = self getcurrentprimaryweapon();
  }

  var_1 = self getweaponslistprimaries();
  self.bang_bangs = 1;
  foreach(var_3 in var_1) {
    if(issubstr(var_3, "alt") || issubstr(var_3, "knife")) {
      continue;
    }

    if(scripts\engine\utility::array_contains(level.additional_laststand_weapon_exclusion, var_3)) {
      continue;
    }

    var_4 = func_9B58(var_3);
    var_5 = self getweaponammostock(var_3);
    var_6 = self getweaponammoclip(var_3);
    var_7 = undefined;
    var_8 = undefined;
    if(var_4) {
      var_7 = self getweaponammoclip(var_3, "left");
      var_8 = self getweaponammoclip(var_3, "right");
    }

    self takeweapon(var_3);
    var_9 = getweaponattachments(var_3);
    var_0A = scripts\cp\utility::getcurrentcamoname(var_3);
    if(scripts\engine\utility::array_contains(var_9, "doubletap")) {
      var_9 = scripts\engine\utility::array_remove(var_9, "doubletap");
    }

    if(scripts\engine\utility::array_contains(self.rofweaponslist, getweaponbasename(var_3))) {
      var_9[var_9.size] = "rof";
    }

    var_0B = scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_3, undefined, var_9, undefined, var_0A);
    var_0B = scripts\cp\utility::_giveweapon(var_0B, undefined, undefined, 1);
    if(isDefined(var_0B)) {
      if(var_4) {
        if(issubstr(var_0B, "akimbofmg")) {
          self setweaponammoclip(var_0B, var_7 + var_8);
        } else {
          self setweaponammoclip(var_0B, var_7, "left");
          self setweaponammoclip(var_0B, var_8, "right");
        }
      } else {
        self setweaponammoclip(var_0B, var_6);
      }

      self setweaponammostock(var_0B, var_5);
    }

    if(getweaponbasename(var_0B) == getweaponbasename(var_0)) {
      var_0 = var_0B;
    }
  }

  self switchtoweapon(var_0);
  self.bang_bangs = undefined;
}

run_double_tap_perk() {
  self endon("remove_perk_icon_perk_machine_rat_a_tat");
  for(;;) {
    self waittill("weapon_fired");
    var_0 = self getcurrentweapon();
    var_1 = self getcurrentweaponclipammo();
    var_1 = var_1 - 1;
    self setweaponammoclip(var_0, var_1);
  }
}

give_run_perk() {
  level notify("racingstripes_purchased", self);
  scripts\cp\utility::giveperk("specialty_longersprint");
  scripts\cp\utility::giveperk("specialty_sprintfire");
  if(isDefined(level.player_run_suit)) {
    self setsuit(level.player_run_suit);
    return;
  }

  self setsuit("zom_suit_sprint");
}

take_run_perk() {
  scripts\cp\utility::_unsetperk("specialty_longersprint");
  scripts\cp\utility::_unsetperk("specialty_sprintfire");
  if(isDefined(level.player_suit)) {
    self setsuit(level.player_suit);
  } else {
    self setsuit("zom_suit");
  }

  remove_zombies_perk_icon_and_index("perk_machine_run");
}

give_fwoosh_perk() {
  thread run_fwoosh_perk();
}

take_fwoosh_perk() {
  remove_zombies_perk_icon_and_index("perk_machine_fwoosh");
}

run_fwoosh_perk() {
  self endon("disconnect");
  self endon("remove_perk_icon_perk_machine_fwoosh");
  for(;;) {
    self waittill("sprint_slide_begin");
    create_fire_wave(300);
    var_0 = scripts\engine\utility::waittill_notify_or_timeout_return("energy_replenished", 5);
  }
}

give_smack_perk() {
  level notify("slappytaffy_purchased", self);
}

take_smack_perk() {
  remove_zombies_perk_icon_and_index("perk_machine_smack");
}

give_zap_perk() {
  thread run_zap_perk();
}

take_zap_perk() {
  remove_zombies_perk_icon_and_index("perk_machine_zap");
}

give_boom_perk() {}

take_boom_perk() {
  remove_zombies_perk_icon_and_index("perk_machine_boom");
}

run_zap_perk() {
  self endon("disconnect");
  self endon("remove_perk_icon_perk_machine_zap");
  self.wait_on_reload = [];
  self.consecutive_zap_attacks = 0;
  for(;;) {
    self waittill("reload_start");
    var_0 = self getcurrentweapon();
    var_1 = weaponclipsize(var_0);
    var_2 = self getweaponammoclip(var_0);
    var_3 = var_1 - var_2 / var_1;
    var_4 = max(1045 * var_3, 10);
    var_5 = max(128 * var_3, 48);
    if(scripts\engine\utility::array_contains(self.wait_on_reload, var_0)) {
      continue;
    }

    self.wait_on_reload[self.wait_on_reload.size] = var_0;
    self.consecutive_zap_attacks++;
    thread check_for_reload_complete(var_0);
    if(isDefined(self)) {
      switch (self.consecutive_zap_attacks) {
        case 1:
        case 0:
          var_6 = undefined;
          break;

        case 2:
          var_6 = 8;
          break;

        case 3:
          var_6 = 4;
          break;

        case 4:
          var_6 = 2;
          break;

        default:
          var_6 = 0;
          break;
      }

      thread zap_cooldown_timer(var_0);
      if(isDefined(var_6) && var_6 == 0) {
        continue;
      }

      create_zap_ring(var_5, var_4);
    }
  }
}

zap_cooldown_timer(var_0) {
  self notify("zap_cooldown_started");
  self endon("zap_cooldown_started");
  self endon("death");
  self endon("disconnect");
  var_1 = 0.25;
  if(scripts\cp\utility::has_zombie_perk("perk_machine_flash")) {
    var_1 = var_1 * getdvarfloat("perk_weapReloadMultiplier");
  }

  var_2 = var_1 + 3;
  wait(var_2);
  self.consecutive_zap_attacks = 0;
}

check_for_reload_complete(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("player_lost_weapon_" + var_0);
  thread weapon_replaced_monitor(var_0);
  for(;;) {
    self waittill("reload");
    var_1 = self getcurrentweapon();
    if(var_1 == var_0) {
      self.wait_on_reload = scripts\engine\utility::array_remove(self.wait_on_reload, var_0);
      self notify("weapon_reload_complete_" + var_0);
      break;
    }
  }
}

weapon_replaced_monitor(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("weapon_reload_complete_" + var_0);
  for(;;) {
    self waittill("weapon_purchased");
    var_1 = self getweaponslistprimaries();
    if(!scripts\engine\utility::exist_in_array_MAYBE(var_1, var_0)) {
      self notify("player_lost_weapon_" + var_0);
      self.wait_on_reload = scripts\engine\utility::array_remove(self.wait_on_reload, var_0);
      break;
    }
  }
}

create_zap_ring(var_0, var_1) {
  var_2 = anglesToForward(self.angles);
  var_2 = vectornormalize(var_2);
  var_2 = var_2 * 100;
  var_3 = "reload_zap_m";
  if(var_0 < 72) {
    var_3 = "reload_zap_s";
  } else if(var_0 < 96) {
    var_3 = "reload_zap_m";
  }

  playsoundatpos(self.origin, "perk_blue_bolts_sparks");
  playFX(level._effect[var_3], self.origin + var_2);
  var_3 = "reload_zap_screen";
  self notify("blue_bolts_activated");
  foreach(var_5 in level.players) {
    if(var_5 == self) {
      playfxontagforclients(level._effect[var_3], self, "tag_eye", self);
    }
  }

  wait(0.25);
  self radiusdamage(self.origin, var_0, var_1, var_1, self, "MOD_GRENADE_SPLASH", "iw7_bluebolts_zm");
  var_7 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_8 = var_0 * var_0;
  foreach(var_0A in level.spawned_enemies) {
    if(!scripts\cp\utility::should_be_affected_by_trap(var_0A)) {
      continue;
    }

    if(distancesquared(var_0A.origin, self.origin) < var_8) {
      var_0A thread zap_over_time(2, self);
    }
  }
}

zap_over_time(var_0, var_1) {
  self endon("death");
  if(!isDefined(self.agent_type)) {
    return;
  }

  self.stunned = 1;
  if(isDefined(level.special_zap_start_func)) {
    [[level.special_zap_start_func]](var_1);
  }

  if(self.agent_type != "alien_phantom" && self.agent_type != "alien_goon" && self.agent_type != "alien_rhino" && self.agent_type != "skeleton") {
    thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(self);
  }

  while(var_0 > 0) {
    self.stun_hit_time = gettime() + 1000;
    wait(0.1);
    self dodamage(1, self.origin, var_1, var_1, "MOD_GRENADE_SPLASH", "iw7_bluebolts_zm");
    var_0 = var_0 - 1;
    wait(1);
  }

  self.stunned = undefined;
  if(isDefined(level.special_zap_end_func)) {
    [[level.special_zap_end_func]](var_1);
  }
}

should_mutilate_perk_check(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D) {
  if(var_6 == "iw7_bluebolts_zm") {
    if(isDefined(var_2) && isplayer(var_2) && var_2 scripts\cp\utility::has_zombie_perk("perk_machine_zap")) {
      return 0;
    }
  }

  return var_0;
}

create_fire_patch(var_0) {
  var_1 = spawn("trigger_radius", var_0, 1, 72, 20);
  var_1.triggered = 0;
  var_2 = 1;
  var_3 = self getvelocity();
  var_1.fx = spawnfxforclient(level._effect["fire_cloud_1st"], var_0, self, var_3);
  triggerfx(var_1.fx);
  playsoundatpos(var_1.origin, "perk_fwoosh_fire_trail");
  var_1 thread burn_loop(self);
  wait(var_2);
  var_1 notify("stop_burn_loop");
  var_1.fx delete();
  var_1 delete();
}

create_fire_patch_3rd(var_0, var_1) {
  var_2 = spawn("trigger_radius", var_0, 1, 72, 20);
  var_2.triggered = 0;
  var_3 = 1;
  var_4 = var_1 getvelocity();
  var_2.fx = spawnfxforclient(level._effect["fire_cloud_3rd"], var_0, self, var_4);
  triggerfx(var_2.fx);
  wait(var_3);
  var_2.fx delete();
  var_2 delete();
}

create_fire_trail(var_0) {
  self endon("death");
  self endon("sprint_slide_end");
  var_1 = var_0 * var_0;
  var_2 = self.origin;
  var_3 = self.origin;
  var_4 = 36;
  var_5 = var_4 * var_4;
  var_6 = self getvelocity();
  self.flame_vel = var_6;
  while(distancesquared(self.origin, var_3) < var_1) {
    if(distancesquared(self.origin, var_2) > var_5) {
      thread spawn_fire_trail_fx(self.origin, self.flame_vel);
      var_2 = self.origin;
    }

    scripts\engine\utility::waitframe();
  }
}

spawn_fire_trail_fx(var_0, var_1) {
  var_2 = spawn("trigger_radius", var_0, 1, 72, 20);
  var_2.triggered = 0;
  var_3 = 2;
  var_4 = self getvelocity();
  var_5 = length(var_1);
  var_6 = length(var_4);
  if(var_5 != 0 && var_6 != 0) {
    var_7 = anglesdelta(var_1, var_4);
    if(var_7 > 10) {
      var_1 = var_1 + var_4 / 2;
    }
  }

  self.flame_vel = var_1;
  var_2.fx = spawnfx(level._effect["fire_trail"], var_0, self.flame_vel);
  triggerfx(var_2.fx);
  var_2 thread burn_loop(self);
  wait(var_3);
  var_2 notify("stop_burn_loop");
  wait(1);
  var_2.fx delete();
  var_2 delete();
}

burn_loop(var_0) {
  self endon("stop_burn_loop");
  for(;;) {
    self waittill("trigger", var_1);
    if(isplayer(var_1)) {
      continue;
    }

    if(isDefined(var_1.agent_type) && var_1.agent_type == "zombie_brute" || var_1.agent_type == "zombie_grey") {
      continue;
    }

    if(isalive(var_1) && !scripts\engine\utility::istrue(var_1.marked_for_death)) {
      var_1.marked_for_death = 1;
      var_1 thread scripts\cp\utility::damage_over_time(var_1, var_0, 5, 1900, undefined, "iw7_fwoosh_zm", 0, "burning", "fwoosh_kill");
    }
  }
}

create_fire_wave(var_0) {
  var_1 = var_0 / 2;
  var_2 = vectornormalize(anglesToForward(self.angles));
  var_3 = var_2 * var_1;
  foreach(var_5 in level.players) {
    if(var_5 == self) {
      var_5 thread create_fire_patch(var_5.origin + var_3);
      continue;
    }

    var_5 thread create_fire_patch_3rd(self.origin + var_3, self);
  }

  thread create_fire_trail(var_0);
}

remove_zombies_perk_icon_and_index(var_0) {
  if(isDefined(self.zombies_perks) && isDefined(self.zombies_perks[var_0])) {
    self notify("remove_perk_icon_" + var_0);
    self.zombies_perks[var_0] = undefined;
  }
}

remove_perks_from_player() {
  if(!isDefined(self.zombies_perks)) {
    return;
  }

  if(scripts\engine\utility::istrue(self.dontremoveperks)) {
    return;
  }

  self.stored_zombies_perks = self.zombies_perks;
  var_0 = scripts\cp\utility::is_consumable_active("just_a_flesh_wound");
  if(var_0) {
    thread dontremoveperksuntildeath();
  }

  foreach(var_3, var_2 in self.zombies_perks) {
    if(var_0) {
      if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
        if(var_3 != "perk_machine_revive") {
          continue;
        }
      } else {
        break;
      }
    }

    take_zombies_perk(var_3);
  }
}

dontremoveperksuntildeath() {
  self endon("disconnect");
  level endon("game_ended");
  var_0 = scripts\engine\utility::waittill_any_return("death", "revive");
  scripts\cp\utility::notify_used_consumable("just_a_flesh_wound");
  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    self.keep_perks = 1;
    return;
  }

  if(var_0 == "death") {
    self.stored_zombies_perks = self.zombies_perks;
    foreach(var_3, var_2 in self.zombies_perks) {
      take_zombies_perk(var_3);
    }
  }
}

get_data_for_all_perks() {
  return self.zombies_perks;
}

try_restore_zombie_perks(var_0) {
  if(isDefined(var_0.stored_zombies_perks) && var_0.stored_zombies_perks.size > 0) {
    restore_zombie_perks(var_0, var_0.stored_zombies_perks);
  }
}

restore_zombie_perks(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }

  foreach(var_4, var_3 in var_1) {
    var_0 give_zombies_perk(var_4, 0);
  }
}
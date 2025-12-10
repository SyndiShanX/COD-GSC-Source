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
  var_00 = getdvar("ui_mapname");
  if(var_00 == "cp_town" || var_00 == "cp_final") {
    init_perk_machines_func("perk_machine_change");
  }
}

delay_rotate_func(param_00) {
  wait(param_00);
  var_01 = getent("change_chews_lower", "targetname");
  if(isDefined(var_01)) {
    var_02 = getdvar("ui_mapname");
    if(var_02 == "cp_town") {
      var_01.angles = (0, 276, 0);
      level thread rotate_loop_by_targetname("change_chews_upper", (0, 276, 0), (348, 276, 0));
    }

    if(var_02 == "cp_final") {
      var_01.angles = (0, 156, 0);
      level thread rotate_loop_by_targetname("change_chews_upper", (0, 156, 0), (348, 156, 0));
    }
  }
}

rotate_loop_by_targetname(param_00, param_01, param_02) {
  var_03 = getent(param_00, "targetname");
  for(;;) {
    var_03 rotateto(param_02, 1);
    var_03 waittill("rotatedone");
    var_03 rotateto(param_01, 1);
    var_03 waittill("rotatedone");
  }
}

init_perk_machines_func(param_00) {
  var_01 = scripts\engine\utility::getstructarray(param_00, "script_noteworthy");
  foreach(var_04, var_03 in var_01) {
    var_03 thread revive_power_on_func(var_04);
  }
}

revive_power_on_func(param_00) {
  var_01 = undefined;
  if(isDefined(self.target)) {
    self.setminimap = getent(self.target, "targetname");
    self.setminimap setlightintensity(0);
  }

  init_perk_machine();
  scripts\engine\utility::flag_wait("player_count_determined");
  if(self.script_noteworthy == "perk_machine_revive" && scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    if(param_00 > 0) {
      wait(0.1 * param_00);
    }

    turn_on_light_and_power();
    return;
  }

  if(scripts\engine\utility::istrue(self.requires_power) && isDefined(self.power_area)) {
    for(;;) {
      var_02 = level scripts\engine\utility::waittill_any_return_no_endon_death_3("power_on", self.power_area + " power_on", "power_off");
      if(var_02 == "power_off") {
        turn_off_light_and_power();
        continue;
      }

      if(param_00 > 0) {
        wait(0.1 * param_00);
      }

      turn_on_light_and_power();
    }

    return;
  }

  if(param_00 > 0) {
    wait(0.1 * param_00);
  }

  turn_on_light_and_power();
}

turn_on_light_and_power() {
  self.powered_on = 1;
  if(scripts\cp\utility::map_check(0)) {
    level thread scripts\cp\cp_vo::add_to_nag_vo("dj_perkstation_use_nag", "zmb_dj_vo", 60, 15, 3, 0);
  }

  foreach(var_01 in level.players) {
    var_01 thread scripts\cp\cp_vo::add_to_nag_vo("nag_try_perk", "zmb_comment_vo", 60, 270, 6, 1);
  }

  var_03 = "mus_zmb_tuffnuff_purchase";
  switch (self.script_noteworthy) {
    case "perk_machine_revive":
      var_03 = "mus_zmb_upnatoms_attract";
      break;

    case "perk_machine_flash":
      var_03 = "mus_zmb_quickies_attract";
      break;

    case "perk_machine_more":
      var_03 = "mus_zmb_mulemunchies_attract";
      break;

    case "perk_machine_rat_a_tat":
      var_03 = "mus_zmb_bangbangs_attract";
      break;

    case "perk_machine_run":
      var_03 = "mus_zmb_racinstripes_attract";
      break;

    case "perk_machine_fwoosh":
      var_03 = "mus_zmb_trailblazer_attract";
      break;

    case "perk_machine_smack":
      var_03 = "mus_zmb_slappytaffy_attract";
      break;

    case "perk_machine_zap":
      var_03 = "mus_zmb_bluebolts_attract";
      break;

    case "perk_machine_boom":
      var_03 = "mus_zmb_bombstoppers_attract";
      break;

    case "perk_machine_deadeye":
      var_03 = "mus_zmb_deadeye_attract";
      break;

    case "perk_machine_change":
      var_03 = "mus_zmb_changechews_attract";
      break;
  }

  level scripts\cp\cp_music_and_dialog::add_to_ambient_sound_queue(var_03, self.perk_machine_top.origin + (0, 0, 50), 120, 120, 250000, 100, 10);
  if(isDefined(self.power_area) && self.power_area == "disco_bottom") {
    var_04 = spawn("script_origin", (-1647, 3091, 1236));
    playsoundatpos((-1647, 3091, 1236), "power_buy_neon_vending_turn_on");
    wait(0.05);
    var_04 playLoopSound("power_buy_neon_vending_lp");
  }

  if(isDefined(self.setminimap)) {
    var_05 = 1;
    if(isDefined(self.setminimap.script_intensity_01)) {
      var_05 = self.setminimap.script_intensity_01;
    }

    for(var_06 = 0; var_06 < 4; var_06++) {
      self.setminimap setlightintensity(var_05);
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

    var_05 = 1;
    if(isDefined(self.setminimap.script_intensity_01)) {
      var_05 = self.setminimap.script_intensity_01;
    }

    self.setminimap setlightintensity(var_05);
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
  var_00 = get_array_of_perk_machines_by_type(self.perk_type);
  self.perk_machine_top = scripts\engine\utility::getclosest(self.origin, var_00);
  if(isDefined(self.perk_machine_top)) {
    self.perk_machine_top setscriptablepartstate("perk_sign", "off");
    self.perk_machine_top setnonstick(1);
  }
}

get_array_of_perk_machines_by_type(param_00) {
  var_01 = "";
  switch (param_00) {
    case "perk_machine_revive":
      var_01 = "perk_machine_up_n_atoms_sign";
      break;

    case "perk_machine_tough":
      var_01 = "perk_machine_tuff_nuff_sign";
      break;

    case "perk_machine_run":
      var_01 = "perk_machine_racin_stripes_sign";
      break;

    case "perk_machine_flash":
      var_01 = "perk_machine_quickies_sign";
      break;

    case "perk_machine_more":
      var_01 = "perk_machine_mule_munchies_sign";
      break;

    case "perk_machine_rat_a_tat":
      var_01 = "perk_machine_bang_bangs_sign";
      break;

    case "perk_machine_boom":
      var_01 = "perk_machine_bombstoppers_sign";
      break;

    case "perk_machine_zap":
      var_01 = "perk_machine_blue_bolts_sign";
      break;

    case "perk_machine_fwoosh":
      var_01 = "perk_machine_trail_blazers_sign";
      break;

    case "perk_machine_smack":
      var_01 = "perk_machine_slappy_taffy_sign";
      break;

    case "perk_machine_deadeye":
      var_01 = "perk_machine_deadeye_sign";
      break;

    case "perk_machine_change":
      var_01 = "perk_machine_change_chews_sign";
      break;

    default:
      break;
  }

  return getscriptablearray(var_01, "targetname");
}

activate_perk_machine(param_00, param_01) {
  param_01 endon("disconnect");
  var_02 = [];
  if(isDefined(param_00.script_noteworthy)) {
    var_02 = strtok(param_00.script_noteworthy, "_");
  }

  if(isDefined(param_00.last_time_used) && isDefined(param_00.last_time_used[param_01.name])) {
    return;
  }

  var_03 = scripts\engine\utility::istrue(var_02[0] == "crafted");
  if(!var_03 && param_01 scripts\cp\utility::has_zombie_perk(param_00.perk_type)) {
    if(soundexists("perk_machine_remove_perk")) {
      param_01 playlocalsound("perk_machine_remove_perk");
    }

    if(param_00.perk_type == "perk_machine_revive") {
      param_01.self_revives_purchased--;
    }

    param_01 take_zombies_perk(param_00.perk_type);
    param_01 scripts\cp\cp_interaction::refresh_interaction();
    return;
  }

  if(isDefined(param_01.zombies_perks) && param_01.zombies_perks.size > 4 && !scripts\engine\utility::istrue(param_01.have_gns_perk)) {
    return;
  }

  if(param_01 scripts\cp\utility::has_zombie_perk(param_00.perk_type)) {
    return;
  }

  level thread turn_off_interaction_for_time(param_00, param_01, 2000);
  level thread play_perk_machine_purchase_sound(param_00, param_01);
  scripts\cp\cp_vo::remove_from_nag_vo("dj_perkstation_use_nag");
  if(param_01 scripts\cp\utility::is_consumable_active("perk_refund") && !var_03) {
    param_01 scripts\cp\cp_persistence::give_player_currency(1000, undefined, undefined, 1, "bonus");
    param_01 scripts\cp\utility::notify_used_consumable("perk_refund");
  }

  param_01 play_perk_gesture(param_00.perk_type);
  param_01 give_zombies_perk(param_00.perk_type, 1);
}

activate_perk_machine_gesture_second(param_00, param_01) {
  param_01 endon("disconnect");
  var_02 = [];
  if(isDefined(param_00.script_noteworthy)) {
    var_02 = strtok(param_00.script_noteworthy, "_");
  }

  if(isDefined(param_00.last_time_used) && isDefined(param_00.last_time_used[param_01.name])) {
    return;
  }

  var_03 = scripts\engine\utility::istrue(var_02[0] == "crafted");
  if(!var_03 && param_01 scripts\cp\utility::has_zombie_perk(param_00.perk_type)) {
    if(soundexists("perk_machine_remove_perk")) {
      param_01 playlocalsound("perk_machine_remove_perk");
    }

    if(param_00.perk_type == "perk_machine_revive") {
      param_01.self_revives_purchased--;
    }

    param_01 take_zombies_perk(param_00.perk_type);
    param_01 scripts\cp\cp_interaction::refresh_interaction();
    return;
  }

  if(isDefined(param_01.zombies_perks) && param_01.zombies_perks.size > 4) {
    return;
  }

  if(param_01 scripts\cp\utility::has_zombie_perk(param_00.perk_type)) {
    return;
  }

  level thread turn_off_interaction_for_time(param_00, param_01, 2000);
  level thread play_perk_machine_purchase_sound(param_00, param_01);
  scripts\cp\cp_vo::remove_from_nag_vo("dj_perkstation_use_nag");
  if(param_01 scripts\cp\utility::is_consumable_active("perk_refund") && !var_03) {
    param_01 scripts\cp\cp_persistence::give_player_currency(1000, undefined, undefined, 1, "bonus");
    param_01 scripts\cp\utility::notify_used_consumable("perk_refund");
  }

  param_01 give_zombies_perk(param_00.perk_type, 1);
  wait(1);
  param_01 play_perk_gesture(param_00.perk_type);
}

give_zombies_perk(param_00, param_01) {
  if(!isDefined(self.zombies_perks)) {
    self.zombies_perks = [];
  }

  self.zombies_perks[param_00] = 1;
  scripts\cp\zombies\zombie_analytics::log_perk_machine_used(level.wave_num, param_00);
  scripts\cp\cp_persistence::increment_player_career_perks_used(self);
  self[[level.coop_perk_callbacks[param_00].set]]();
  if(isDefined(self.sub_perks) && isDefined(self.sub_perks[param_00])) {
    param_00 = self.sub_perks[param_00];
  }

  thread set_ui_omnvar_for_perks(param_00);
  if(scripts\engine\utility::istrue(param_01)) {
    scripts\cp\cp_merits::processmerit("mt_purchase_perks");
  }

  if(isDefined(level.additional_give_perk)) {
    self[[level.additional_give_perk]](param_00);
  }

  return 1;
}

give_zombies_perk_immediate(param_00, param_01) {
  if(scripts\cp\utility::has_zombie_perk(param_00)) {
    return;
  }

  if(!isDefined(self.zombies_perks)) {
    self.zombies_perks = [];
  }

  self.zombies_perks[param_00] = 1;
  self[[level.coop_perk_callbacks[param_00].set]]();
  if(isDefined(self.sub_perks) && isDefined(self.sub_perks[param_00])) {
    param_00 = self.sub_perks[param_00];
  }

  if(scripts\engine\utility::istrue(param_01)) {
    thread set_ui_omnvar_for_perks(param_00);
  }

  return 1;
}

play_perk_machine_purchase_sound(param_00, param_01) {
  var_02 = [];
  var_03 = "";
  switch (param_00.name) {
    case "perk_machine_revive":
      var_02 = ["mus_zmb_upnatoms_purchase"];
      if(level.players.size < 2) {
        var_03 = "purchase_perk_revive_solo";
      } else {
        var_03 = "purchase_perk_upnatoms";
      }
      break;

    case "perk_machine_more":
      var_02 = ["mus_zmb_mulemunchies_purchase"];
      var_03 = "purchase_perk_nulemunchies";
      break;

    case "perk_machine_run":
      var_02 = ["mus_zmb_racinstripes_purchase"];
      var_03 = "purchase_perk_racinstripes";
      break;

    case "perk_machine_flash":
      var_02 = ["mus_zmb_quickies_purchase"];
      var_03 = "purchase_perk_quickies";
      break;

    case "perk_machine_tough":
      var_02 = ["mus_zmb_tuffnuff_purchase"];
      var_03 = "purchase_perk_tuffnuff";
      break;

    case "perk_machine_rat_a_tat":
      var_02 = ["mus_zmb_bangbangs_purchase"];
      var_03 = "purchase_perk_bangbangs";
      break;

    case "perk_machine_fwoosh":
      var_02 = ["mus_zmb_trailblazer_purchase"];
      var_03 = "purchase_perk_trailblazers";
      break;

    case "perk_machine_smack":
      var_02 = ["mus_zmb_slappytaffy_purchase"];
      var_03 = "purchase_perk_slappytaffy";
      break;

    case "perk_machine_boom":
      var_02 = ["mus_zmb_bombstoppers_purchase"];
      var_03 = "purchase_perk_bombstoppers";
      break;

    case "perk_machine_zap":
      var_02 = ["mus_zmb_bluebolts_purchase"];
      var_03 = "purchase_perk_bluebolts";
      break;

    case "perk_machine_deadeye":
      var_02 = ["mus_zmb_deadeye_purchase"];
      var_03 = "purchase_perk_deadeyedewdrop";
      break;

    case "perk_machine_change":
      var_02 = ["mus_zmb_changechews_purchase"];
      var_03 = "purchase_perk_changechews";
      break;
  }

  param_01 thread scripts\cp\cp_vo::try_to_play_vo(var_03, "zmb_comment_vo", "low", 10, 0, 1, 0, 50);
  param_01 thread play_perk_vo_additional(var_03);
  if(!var_02.size) {
    return undefined;
  }

  var_04 = scripts\engine\utility::random(var_02);
  if(isDefined(var_04) && soundexists(var_04)) {
    playsoundatpos(param_00.origin, var_04);
    var_05 = lookupsoundlength(var_04);
    wait(var_05 / 1000);
  }
}

play_perk_vo_additional(param_00) {
  wait(scripts\cp\cp_vo::get_sound_length(self.vo_prefix + param_00) + 5);
  thread scripts\cp\cp_vo::try_to_play_vo("purchase_perk", "zmb_comment_vo");
}

play_perk_machine_deny_sound(param_00, param_01) {
  if(soundexists("perk_machine_deny")) {
    param_01 playlocalsound("perk_machine_deny");
  }
}

set_ui_omnvar_for_perks(param_00) {
  var_01 = tablelookup("cp\zombies\zombie_perks_bit_mask_table.csv", 1, param_00, 0);
  var_02 = int(var_01);
  self setclientomnvarbit("zm_active_perks", var_02 - 1, 1);
}

play_perk_gesture(param_00) {
  if(isDefined(self.disableplunger) || isDefined(self.disablecrank)) {
    self notify("end_cutie_gesture_loop");
    wait(0.05);
  }

  self playlocalsound("perk_purchase_foley_candy_box");
  self.playingperkgesture = 1;
  var_01 = "iw7_candybang_zm";
  switch (param_00) {
    case "perk_machine_boom":
      var_01 = "iw7_candybomb_zm";
      break;

    case "perk_machine_zap":
      var_01 = "iw7_candyblue_zm";
      break;

    case "perk_machine_fwoosh":
      var_01 = "iw7_candytrail_zm";
      break;

    case "perk_machine_revive":
      var_01 = "iw7_candyup_zm";
      break;

    case "perk_machine_flash":
      var_01 = "iw7_candyquickies_zm";
      break;

    case "perk_machine_tough":
      var_01 = "iw7_candytuff_zm";
      break;

    case "perk_machine_smack":
      var_01 = "iw7_candyslappy_zm";
      break;

    case "perk_machine_more":
      var_01 = "iw7_candymule_zm";
      break;

    case "perk_machine_run":
      var_01 = "iw7_candyracin_zm";
      break;

    case "perk_machine_rat_a_tat":
      var_01 = "iw7_candybang_zm";
      break;

    case "perk_machine_deadeye":
      var_01 = "iw7_candydeadeye_zm";
      break;

    case "perk_machine_change":
      var_01 = "iw7_candychange_zm";
      break;
  }

  thread scripts\cp\utility::firegesturegrenade(self, var_01);
  while(self getcurrentoffhand() == var_01) {
    wait(0.1);
  }

  self.playingperkgesture = undefined;
}

take_zombies_perk(param_00) {
  if(!scripts\cp\utility::has_zombie_perk(param_00)) {
    return 0;
  }

  var_01 = param_00;
  if(isDefined(self.sub_perks) && isDefined(self.sub_perks[param_00])) {
    var_01 = self.sub_perks[param_00];
  }

  scripts\cp\zombies\zombie_analytics::log_perk_returned(level.wave_num, param_00);
  self[[level.coop_perk_callbacks[param_00].unset]]();
  var_02 = tablelookup("cp\zombies\zombie_perks_bit_mask_table.csv", 1, var_01, 0);
  var_03 = int(var_02);
  self setclientomnvarbit("zm_active_perks", var_03 - 1, 0);
  if(isDefined(level.take_perks_func)) {
    self[[level.take_perks_func]](param_00);
  }

  return 1;
}

sawblade_perk_animation() {
  self setclientomnvar("zombie_coaster_ticket_earned", 1);
  wait(3);
  self setclientomnvar("zombie_coaster_ticket_earned", -1);
}

take_zombies_perk_immediate(param_00) {
  if(!scripts\cp\utility::has_zombie_perk(param_00)) {
    return 0;
  }

  self[[level.coop_perk_callbacks[param_00].unset]]();
  var_01 = param_00;
  if(isDefined(self.sub_perks) && isDefined(self.sub_perks[param_00])) {
    var_01 = self.sub_perks[param_00];
  }

  var_02 = tablelookup("cp\zombies\zombie_perks_bit_mask_table.csv", 1, var_01, 0);
  var_03 = int(var_02);
  self setclientomnvarbit("zm_active_perks", var_03 - 1, 0);
  return 1;
}

hint_string_func(param_00, param_01) {
  if(!scripts\engine\utility::istrue(param_00.powered_on)) {
    if(isDefined(level.needspowerstring)) {
      return level.needspowerstring;
    } else {
      return &"COOP_INTERACTIONS_REQUIRES_POWER";
    }
  }

  if(isDefined(param_00.last_time_used) && isDefined(param_00.last_time_used[param_01.name])) {
    return "";
  }

  if(param_01 scripts\cp\utility::has_zombie_perk(param_00.perk_type)) {
    return &"COOP_PERK_MACHINES_REMOVE_PERK";
  }

  if(isDefined(self.zombies_perks) && self.zombies_perks.size > 4 && !scripts\engine\utility::istrue(self.have_gns_perk)) {
    return &"COOP_PERK_MACHINES_PERK_SLOTS_FULL";
  }

  if(param_00.script_noteworthy == "perk_machine_revive" && scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    return &"COOP_PERK_MACHINES_SELF_REVIVE";
  }

  return level.interaction_hintstrings[param_00.script_noteworthy];
}

turn_off_interaction_for_time(param_00, param_01, param_02) {
  var_03 = gettime();
  param_00.last_time_used[param_01.name] = var_03;
  while(gettime() - var_03 < param_02) {
    wait(0.1);
  }

  param_00.last_time_used[param_01.name] = undefined;
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
  var_00 = scripts\engine\utility::waittill_any_return("last_stand", "death", "remove_self_revive");
  if(var_00 == "last_stand") {
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
  foreach(var_01 in level.players) {
    if(var_01 scripts\cp\utility::has_zombie_perk("perk_machine_revive")) {
      var_01 notify("turn_off_self_revive");
      var_01 scripts\cp\cp_laststand::set_last_stand_count(var_01, 0);
      var_01.perk_data["medic"].revive_time_scalar = 2;
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
  var_00 = undefined;
  var_01 = undefined;
  for(;;) {
    var_02 = scripts\cp\utility::getweapontoswitchbackto();
    var_03 = func_9B58(var_02);
    if(self adsbuttonpressed() && !scripts\engine\utility::istrue(self.no_deadeye) && !var_03) {
      var_04 = gettime();
      if(!isDefined(var_00)) {
        var_00 = var_04;
        var_01 = var_04 + 2000;
      } else if(var_04 > var_01) {
        if(!scripts\engine\utility::istrue(self.deadeye_charge)) {
          self setclientomnvar("damage_feedback", "pink_arcane_cp");
          self setclientomnvar("damage_feedback_notify", gettime());
          self playlocalsound("gauntlet_armory_hack_wrist_second");
        }

        self.deadeye_charge = 1;
      }
    } else {
      self.deadeye_charge = undefined;
      var_00 = undefined;
      var_01 = undefined;
    }

    scripts\engine\utility::waitframe();
  }
}

give_change_perk() {
  var_00 = randomintrange(1, 5);
  self.sub_perks["perk_machine_change"] = "perk_machine_change" + var_00;
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
    self waittill("change_chews_damage", var_00, var_01);
    if(var_01 > 30) {
      continue;
    }

    if(scripts\engine\utility::istrue(self.playing_ghosts_n_skulls)) {
      continue;
    }

    if(isDefined(self.sub_perks) && isDefined(self.sub_perks["perk_machine_change"])) {
      var_02 = self.sub_perks["perk_machine_change"];
      var_03 = tablelookup("cp\zombies\zombie_perks_bit_mask_table.csv", 1, var_02, 0);
      var_04 = int(var_03);
      self setclientomnvarbit("zm_active_perks", var_04 - 1, 0);
    }

    update_change_chews_sub_perk();
    if(isDefined(self.sub_perks) && isDefined(self.sub_perks["perk_machine_change"])) {
      var_02 = self.sub_perks["perk_machine_change"];
      thread set_ui_omnvar_for_perks(var_02);
    }

    while(self.health < 31) {
      wait(0.1);
    }

    wait(0.1);
  }
}

update_change_chews_sub_perk() {
  var_00 = self.sub_perks["perk_machine_change"];
  var_01 = 1;
  switch (var_00) {
    case "perk_machine_change1":
      var_01 = 1;
      break;

    case "perk_machine_change2":
      var_01 = 2;
      break;

    case "perk_machine_change3":
      var_01 = 3;
      break;

    case "perk_machine_change4":
      var_01 = 4;
      break;

    default:
      break;
  }

  var_02 = var_01 + 1;
  if(var_02 > 4) {
    var_02 = 1;
  }

  self.sub_perks["perk_machine_change"] = "perk_machine_change" + var_02;
}

change_chew_explosion(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = scripts\engine\utility::isbulletdamage(param_03) || param_03 == "MOD_EXPLOSIVE_BULLET" && param_05 != "none";
  if(!var_06) {
    return;
  }

  if(!scripts\cp\utility::isheadshot(param_04, param_05, param_03, param_00)) {
    return;
  }

  if(!isDefined(self.agent_type) || self.agent_type != "generic_zombie") {
    return;
  }

  thread explode_head_with_fx(param_00, param_05, param_02, undefined, undefined);
}

explode_head_shards(param_00, param_01, param_02, param_03) {
  var_04 = scripts\cp\utility::weaponhasattachment(param_03, "pap1") || scripts\cp\utility::weaponhasattachment(param_03, "pap2");
  var_05 = param_03;
  var_06 = [];
  var_06 = level.spawned_enemies;
  var_07 = [param_02];
  var_08 = 150;
  if(var_04) {
    var_08 = 300;
  }

  var_09 = scripts\engine\utility::get_array_of_closest(param_01, var_06, var_07, undefined, var_08, 0);
  foreach(var_0B in var_09) {
    if(isDefined(var_0B.agent_type) && var_0B.agent_type == "crab_mini" || var_0B.agent_type == "crab_brute") {
      var_0C = 100;
    } else {
      var_0C = 100000;
    }

    var_0B dodamage(var_0C, param_01, param_00, param_00, "MOD_EXPLOSIVE", var_05);
  }
}

explode_head_with_fx(param_00, param_01, param_02, param_03, param_04) {
  self.head_is_exploding = 1;
  param_04 = self gettagorigin("J_Spine4");
  foreach(var_06 in level.players) {
    if(distance(var_06.origin, param_04) <= 350) {
      var_06 thread scripts\cp\zombies\zombies_weapons::showonscreenbloodeffects();
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
    var_00 = self getcurrentprimaryweapon();
    var_01 = get_culled_primary_list();
    if(var_01.size > 3) {
      var_00 = self getcurrentprimaryweapon();
      if(var_00 == var_01[var_01.size - 1]) {
        self setclientomnvar("zm_mule_munchies_weapon_icon", 1);
        self.mule_weapon = var_00;
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
  var_00 = get_culled_primary_list();
  var_01 = 0;
  var_02 = scripts\cp\utility::getvalidtakeweapon();
  if(var_00.size > 3) {
    var_03 = var_00[var_00.size - 1];
    if(var_03 == var_02) {
      var_01 = 1;
    }

    self takeweapon(var_03);
    if(var_01) {
      self switchtoweaponimmediate(var_00[var_00.size - 2]);
    }
  }

  self.mule_weapon = undefined;
  scripts\cp\utility::updatelaststandpistol();
  remove_zombies_perk_icon_and_index("perk_machine_more");
  self notify("mule_munchies_sold");
  self setclientomnvar("zm_mule_munchies_weapon_icon", 0);
}

get_culled_primary_list() {
  var_00 = [];
  var_01 = self getweaponslistprimaries();
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    if(var_01[var_02] == "iw7_gunless_zm") {
      continue;
    }

    if(var_01[var_02] == "iw7_entangler_zm") {
      continue;
    }

    if(var_01[var_02] == "iw7_entangler2_zm") {
      continue;
    }

    var_03 = strtok(var_01[var_02], "_");
    if(var_03[0] != "alt") {
      var_00[var_00.size] = var_01[var_02];
    }
  }

  return var_00;
}

give_rat_a_tat_perk() {
  level notify("bangbangs_purchased", self);
  self.perk_data["damagemod"].bullet_damage_scalar = 2;
  var_00 = self getweaponslistprimaries();
  var_01 = scripts\cp\utility::getweapontoswitchbackto();
  foreach(var_03 in var_00) {
    if(issubstr(var_03, "alt") || issubstr(var_03, "knife") || issubstr(var_03, "entangler")) {
      continue;
    }

    var_04 = getweaponattachments(var_03);
    var_05 = scripts\cp\utility::getcurrentcamoname(var_03);
    var_06 = scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_03, "doubletap", var_04, 1, var_05);
    var_07 = func_9B58(var_06);
    if(isDefined(var_06)) {
      var_08 = undefined;
      var_09 = undefined;
      var_0A = self getweaponammoclip(var_03);
      var_0B = self getweaponammostock(var_03);
      if(var_07) {
        var_08 = self getweaponammoclip(var_03, "left");
        var_09 = self getweaponammoclip(var_03, "right");
      }

      self takeweapon(var_03);
      var_06 = scripts\cp\utility::_giveweapon(var_06, undefined, undefined, 1);
      if(var_07) {
        if(issubstr(var_06, "akimbofmg")) {
          self setweaponammoclip(var_06, var_08 + var_09);
        } else {
          self setweaponammoclip(var_06, var_08, "left");
          self setweaponammoclip(var_06, var_09, "right");
        }
      } else {
        self setweaponammoclip(var_06, var_0A);
      }

      self setweaponammostock(var_06, var_0B);
      if(getweaponbasename(var_06) == getweaponbasename(var_01)) {
        var_01 = var_06;
      }
    }
  }

  if(!scripts\engine\utility::istrue(self.kung_fu_mode)) {
    self switchtoweaponimmediate(var_01);
  }
}

func_9B58(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  var_01 = issubstr(param_00, "akimbo");
  if(!var_01) {
    var_01 = issubstr(param_00, "g18pap2");
  }

  return var_01;
}

take_rat_a_tat_perk() {
  self.perk_data["damagemod"].bullet_damage_scalar = 1;
  remove_zombies_perk_icon_and_index("perk_machine_rat_a_tat");
  if(isDefined(level.mode_weapons_allowed) && scripts\engine\utility::array_contains(level.mode_weapons_allowed, getweaponbasename(self getcurrentweapon()))) {
    var_00 = self getcurrentweapon();
  } else {
    var_00 = self getcurrentprimaryweapon();
  }

  var_01 = self getweaponslistprimaries();
  self.bang_bangs = 1;
  foreach(var_03 in var_01) {
    if(issubstr(var_03, "alt") || issubstr(var_03, "knife")) {
      continue;
    }

    if(scripts\engine\utility::array_contains(level.additional_laststand_weapon_exclusion, var_03)) {
      continue;
    }

    var_04 = func_9B58(var_03);
    var_05 = self getweaponammostock(var_03);
    var_06 = self getweaponammoclip(var_03);
    var_07 = undefined;
    var_08 = undefined;
    if(var_04) {
      var_07 = self getweaponammoclip(var_03, "left");
      var_08 = self getweaponammoclip(var_03, "right");
    }

    self takeweapon(var_03);
    var_09 = getweaponattachments(var_03);
    var_0A = scripts\cp\utility::getcurrentcamoname(var_03);
    if(scripts\engine\utility::array_contains(var_09, "doubletap")) {
      var_09 = scripts\engine\utility::array_remove(var_09, "doubletap");
    }

    if(scripts\engine\utility::array_contains(self.rofweaponslist, getweaponbasename(var_03))) {
      var_09[var_09.size] = "rof";
    }

    var_0B = scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_03, undefined, var_09, undefined, var_0A);
    var_0B = scripts\cp\utility::_giveweapon(var_0B, undefined, undefined, 1);
    if(isDefined(var_0B)) {
      if(var_04) {
        if(issubstr(var_0B, "akimbofmg")) {
          self setweaponammoclip(var_0B, var_07 + var_08);
        } else {
          self setweaponammoclip(var_0B, var_07, "left");
          self setweaponammoclip(var_0B, var_08, "right");
        }
      } else {
        self setweaponammoclip(var_0B, var_06);
      }

      self setweaponammostock(var_0B, var_05);
    }

    if(getweaponbasename(var_0B) == getweaponbasename(var_00)) {
      var_00 = var_0B;
    }
  }

  self switchtoweapon(var_00);
  self.bang_bangs = undefined;
}

run_double_tap_perk() {
  self endon("remove_perk_icon_perk_machine_rat_a_tat");
  for(;;) {
    self waittill("weapon_fired");
    var_00 = self getcurrentweapon();
    var_01 = self getcurrentweaponclipammo();
    var_01 = var_01 - 1;
    self setweaponammoclip(var_00, var_01);
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
    var_00 = scripts\engine\utility::waittill_notify_or_timeout_return("energy_replenished", 5);
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
    var_00 = self getcurrentweapon();
    var_01 = weaponclipsize(var_00);
    var_02 = self getweaponammoclip(var_00);
    var_03 = var_01 - var_02 / var_01;
    var_04 = max(1045 * var_03, 10);
    var_05 = max(128 * var_03, 48);
    if(scripts\engine\utility::array_contains(self.wait_on_reload, var_00)) {
      continue;
    }

    self.wait_on_reload[self.wait_on_reload.size] = var_00;
    self.consecutive_zap_attacks++;
    thread check_for_reload_complete(var_00);
    if(isDefined(self)) {
      switch (self.consecutive_zap_attacks) {
        case 1:
        case 0:
          var_06 = undefined;
          break;

        case 2:
          var_06 = 8;
          break;

        case 3:
          var_06 = 4;
          break;

        case 4:
          var_06 = 2;
          break;

        default:
          var_06 = 0;
          break;
      }

      thread zap_cooldown_timer(var_00);
      if(isDefined(var_06) && var_06 == 0) {
        continue;
      }

      create_zap_ring(var_05, var_04);
    }
  }
}

zap_cooldown_timer(param_00) {
  self notify("zap_cooldown_started");
  self endon("zap_cooldown_started");
  self endon("death");
  self endon("disconnect");
  var_01 = 0.25;
  if(scripts\cp\utility::has_zombie_perk("perk_machine_flash")) {
    var_01 = var_01 * getdvarfloat("perk_weapReloadMultiplier");
  }

  var_02 = var_01 + 3;
  wait(var_02);
  self.consecutive_zap_attacks = 0;
}

check_for_reload_complete(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("player_lost_weapon_" + param_00);
  thread weapon_replaced_monitor(param_00);
  for(;;) {
    self waittill("reload");
    var_01 = self getcurrentweapon();
    if(var_01 == param_00) {
      self.wait_on_reload = scripts\engine\utility::array_remove(self.wait_on_reload, param_00);
      self notify("weapon_reload_complete_" + param_00);
      break;
    }
  }
}

weapon_replaced_monitor(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("weapon_reload_complete_" + param_00);
  for(;;) {
    self waittill("weapon_purchased");
    var_01 = self getweaponslistprimaries();
    if(!scripts\engine\utility::exist_in_array_MAYBE(var_01, param_00)) {
      self notify("player_lost_weapon_" + param_00);
      self.wait_on_reload = scripts\engine\utility::array_remove(self.wait_on_reload, param_00);
      break;
    }
  }
}

create_zap_ring(param_00, param_01) {
  var_02 = anglesToForward(self.angles);
  var_02 = vectornormalize(var_02);
  var_02 = var_02 * 100;
  var_03 = "reload_zap_m";
  if(param_00 < 72) {
    var_03 = "reload_zap_s";
  } else if(param_00 < 96) {
    var_03 = "reload_zap_m";
  }

  playsoundatpos(self.origin, "perk_blue_bolts_sparks");
  playFX(level._effect[var_03], self.origin + var_02);
  var_03 = "reload_zap_screen";
  self notify("blue_bolts_activated");
  foreach(var_05 in level.players) {
    if(var_05 == self) {
      playfxontagforclients(level._effect[var_03], self, "tag_eye", self);
    }
  }

  wait(0.25);
  self radiusdamage(self.origin, param_00, param_01, param_01, self, "MOD_GRENADE_SPLASH", "iw7_bluebolts_zm");
  var_07 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_08 = param_00 * param_00;
  foreach(var_0A in level.spawned_enemies) {
    if(!scripts\cp\utility::should_be_affected_by_trap(var_0A)) {
      continue;
    }

    if(distancesquared(var_0A.origin, self.origin) < var_08) {
      var_0A thread zap_over_time(2, self);
    }
  }
}

zap_over_time(param_00, param_01) {
  self endon("death");
  if(!isDefined(self.agent_type)) {
    return;
  }

  self.stunned = 1;
  if(isDefined(level.special_zap_start_func)) {
    [[level.special_zap_start_func]](param_01);
  }

  if(self.agent_type != "alien_phantom" && self.agent_type != "alien_goon" && self.agent_type != "alien_rhino" && self.agent_type != "skeleton") {
    thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(self);
  }

  while(param_00 > 0) {
    self.stun_hit_time = gettime() + 1000;
    wait(0.1);
    self dodamage(1, self.origin, param_01, param_01, "MOD_GRENADE_SPLASH", "iw7_bluebolts_zm");
    param_00 = param_00 - 1;
    wait(1);
  }

  self.stunned = undefined;
  if(isDefined(level.special_zap_end_func)) {
    [[level.special_zap_end_func]](param_01);
  }
}

should_mutilate_perk_check(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D) {
  if(param_06 == "iw7_bluebolts_zm") {
    if(isDefined(param_02) && isplayer(param_02) && param_02 scripts\cp\utility::has_zombie_perk("perk_machine_zap")) {
      return 0;
    }
  }

  return param_00;
}

create_fire_patch(param_00) {
  var_01 = spawn("trigger_radius", param_00, 1, 72, 20);
  var_01.triggered = 0;
  var_02 = 1;
  var_03 = self getvelocity();
  var_01.fx = spawnfxforclient(level._effect["fire_cloud_1st"], param_00, self, var_03);
  triggerfx(var_01.fx);
  playsoundatpos(var_01.origin, "perk_fwoosh_fire_trail");
  var_01 thread burn_loop(self);
  wait(var_02);
  var_01 notify("stop_burn_loop");
  var_01.fx delete();
  var_01 delete();
}

create_fire_patch_3rd(param_00, param_01) {
  var_02 = spawn("trigger_radius", param_00, 1, 72, 20);
  var_02.triggered = 0;
  var_03 = 1;
  var_04 = param_01 getvelocity();
  var_02.fx = spawnfxforclient(level._effect["fire_cloud_3rd"], param_00, self, var_04);
  triggerfx(var_02.fx);
  wait(var_03);
  var_02.fx delete();
  var_02 delete();
}

create_fire_trail(param_00) {
  self endon("death");
  self endon("sprint_slide_end");
  var_01 = param_00 * param_00;
  var_02 = self.origin;
  var_03 = self.origin;
  var_04 = 36;
  var_05 = var_04 * var_04;
  var_06 = self getvelocity();
  self.flame_vel = var_06;
  while(distancesquared(self.origin, var_03) < var_01) {
    if(distancesquared(self.origin, var_02) > var_05) {
      thread spawn_fire_trail_fx(self.origin, self.flame_vel);
      var_02 = self.origin;
    }

    scripts\engine\utility::waitframe();
  }
}

spawn_fire_trail_fx(param_00, param_01) {
  var_02 = spawn("trigger_radius", param_00, 1, 72, 20);
  var_02.triggered = 0;
  var_03 = 2;
  var_04 = self getvelocity();
  var_05 = length(param_01);
  var_06 = length(var_04);
  if(var_05 != 0 && var_06 != 0) {
    var_07 = anglesdelta(param_01, var_04);
    if(var_07 > 10) {
      param_01 = param_01 + var_04 / 2;
    }
  }

  self.flame_vel = param_01;
  var_02.fx = spawnfx(level._effect["fire_trail"], param_00, self.flame_vel);
  triggerfx(var_02.fx);
  var_02 thread burn_loop(self);
  wait(var_03);
  var_02 notify("stop_burn_loop");
  wait(1);
  var_02.fx delete();
  var_02 delete();
}

burn_loop(param_00) {
  self endon("stop_burn_loop");
  for(;;) {
    self waittill("trigger", var_01);
    if(isplayer(var_01)) {
      continue;
    }

    if(isDefined(var_01.agent_type) && var_01.agent_type == "zombie_brute" || var_01.agent_type == "zombie_grey") {
      continue;
    }

    if(isalive(var_01) && !scripts\engine\utility::istrue(var_01.marked_for_death)) {
      var_01.marked_for_death = 1;
      var_01 thread scripts\cp\utility::damage_over_time(var_01, param_00, 5, 1900, undefined, "iw7_fwoosh_zm", 0, "burning", "fwoosh_kill");
    }
  }
}

create_fire_wave(param_00) {
  var_01 = param_00 / 2;
  var_02 = vectornormalize(anglesToForward(self.angles));
  var_03 = var_02 * var_01;
  foreach(var_05 in level.players) {
    if(var_05 == self) {
      var_05 thread create_fire_patch(var_05.origin + var_03);
      continue;
    }

    var_05 thread create_fire_patch_3rd(self.origin + var_03, self);
  }

  thread create_fire_trail(param_00);
}

remove_zombies_perk_icon_and_index(param_00) {
  if(isDefined(self.zombies_perks) && isDefined(self.zombies_perks[param_00])) {
    self notify("remove_perk_icon_" + param_00);
    self.zombies_perks[param_00] = undefined;
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
  var_00 = scripts\cp\utility::is_consumable_active("just_a_flesh_wound");
  if(var_00) {
    thread dontremoveperksuntildeath();
  }

  foreach(var_03, var_02 in self.zombies_perks) {
    if(var_00) {
      if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
        if(var_03 != "perk_machine_revive") {
          continue;
        }
      } else {
        break;
      }
    }

    take_zombies_perk(var_03);
  }
}

dontremoveperksuntildeath() {
  self endon("disconnect");
  level endon("game_ended");
  var_00 = scripts\engine\utility::waittill_any_return("death", "revive");
  scripts\cp\utility::notify_used_consumable("just_a_flesh_wound");
  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    self.keep_perks = 1;
    return;
  }

  if(var_00 == "death") {
    self.stored_zombies_perks = self.zombies_perks;
    foreach(var_03, var_02 in self.zombies_perks) {
      take_zombies_perk(var_03);
    }
  }
}

get_data_for_all_perks() {
  return self.zombies_perks;
}

try_restore_zombie_perks(param_00) {
  if(isDefined(param_00.stored_zombies_perks) && param_00.stored_zombies_perks.size > 0) {
    restore_zombie_perks(param_00, param_00.stored_zombies_perks);
  }
}

restore_zombie_perks(param_00, param_01) {
  if(!isDefined(param_01)) {
    return;
  }

  foreach(var_04, var_03 in param_01) {
    param_00 give_zombies_perk(var_04, 0);
  }
}
/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1571.gsc
**************************************/

get_loadout_item_ref(var_0) {
  return tablelookup(level.loadout_table, 1, var_0, 2);
}

get_loadout_item_ammo(var_0) {
  return tablelookup(level.loadout_table, 2, var_0, 3);
}

survival_preload() {
  if(getdvarint("survival_chaos") == 1) {
    thread maps\_so_survival_chaos::chaos_pre_preload();
  }
  maps/so_survival_precache::main();

  if(!isDefined(level.loadout_table)) {
    level.loadout_table = "sp/survival_waves.csv";
  }
  level.uav_missile_override = "remote_missile_survival";
  level.givexp_kill_func = maps/_so_survival_ai::givexp_kill;
  maps/_so_survival_armory::armory_preload();
  maps/_so_survival_ai::ai_preload();
  maps/_so_survival_perks::perks_preload();
  maps/_so_survival_challenge::_id_3F32();
  precacheitem("smoke_grenade_fast");
  precacherumble("damage_light");
  precacheminimapsentrycodeassets();
  precachestring(&"SO_SURVIVAL_SURVIVAL_OBJECTIVE");
  precachestring(&"SO_SURVIVAL_WAVE_TITLE");
  precachestring(&"SO_SURVIVAL_WAVE_SUCCESS_TITLE");
  precachestring(&"SO_SURVIVAL_SURVIVE_TIME");
  precachestring(&"SO_SURVIVAL_WAVE_TIME");
  precachestring(&"SO_SURVIVAL_PARTNER_READY");
  precachestring(&"SO_SURVIVAL_READY_UP_WAIT");
  precachestring(&"SO_SURVIVAL_READY_UP");
  precacheshader("gradient_inset_rect");
  precacheshader("teamperk_blast_shield");
  precacheshader("specialty_self_revive");
  maps/_so_survival_code::precache_loadout_item(get_loadout_item_ref("weapon_1"));
  maps/_so_survival_code::precache_loadout_item(get_loadout_item_ref("weapon_2"));
  maps/_so_survival_code::precache_loadout_item(get_loadout_item_ref("weapon_3"));
  maps\_load::set_player_viewhand_model("viewhands_player_delta");
  thread maps/_so_survival_code::highest_player_rank();
  thread so_start_trigger_delete();
  level._id_3E86 = 1;

  if(getdvarint("survival_chaos") == 1) {
    thread maps\_so_survival_chaos::chaos_preload();
  }
  precachemenu("so_survival_dvar_reset");
}

so_start_trigger_delete() {
  var_0 = getEntArray("trigger_multiple_flag_set", "classname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_flag) && var_2.script_flag == "start_survival") {
      var_2 common_scripts\utility::trigger_off();
    }
  }
}

hurtplayersthink(var_0) {
  level endon("special_op_terminated");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isDefined(var_1) && isPlayer(var_1) && var_1 == self) {
      break;
    }
  }

  maps\_utility::kill_wrapper();
}

survival_postload() {
  maps/_so_survival_armory::armory_postload();
  maps/_so_survival_loot::loot_postload();

  if(getdvarint("survival_chaos") == 1) {
    thread maps\_so_survival_chaos::chaos_postload();
  }
}

survival_init() {
  foreach(var_1 in level.players) {}
  var_1 openpopupmenu("so_survival_dvar_reset");

  common_scripts\utility::flag_init("bosses_spawned");
  common_scripts\utility::flag_init("aggressive_mode");
  common_scripts\utility::flag_init("boss_music");
  common_scripts\utility::flag_init("slamzoom_finished");
  common_scripts\utility::flag_set("so_player_death_nofail");
  level.custom_eog_no_defaults = 1;
  level.eog_summary_callback = ::custom_eog_summary;
  level.suppress_challenge_success_print = 1;
  level.congrat_min_wave = 5;
  level.so_survival_score_func = ::survival_leaderboard_score_func;
  level.so_survival_wave_func = ::survival_leaderboard_wave_func;
  level.skip_pilot_kill_count = 1;
  level.uav_missle_start_forward_distance = 128.0;
  level.uav_missle_start_right_distance = 0.0;
  setsaveddvar("ai_foliageSeeThroughDist", 50000);
  setsaveddvar("g_friendlyfireDamageScale", 0.5);
  forcesharedammo();
  thread maps\_specialops::enable_challenge_timer("start_survival", "win_survival", undefined, 1);
  thread maps\_specialops::fade_challenge_in(undefined, 0);
  thread maps\_specialops::fade_challenge_out("win_survival");
  level.wave_spawn_locs = maps/_squad_enemies::squad_setup(1);
  maps\_drone_ai::init();
  maps/_so_survival_armory::armory_init();
  maps/_so_survival_loot::loot_init();
  maps/_so_survival_ai::ai_init();
  maps/_so_survival_perks::perks_init();

  if(getdvarint("survival_chaos") != 1) {
    maps/_so_survival_challenge::_id_3F3A();
  }
  maps/_so_survival_dialog::survival_dialog_init();
  maps\_audio::aud_disable_deathsdoor_audio();
  thread setup_players();
  thread survival_logic();

  if(getdvarint("survival_chaos") == 1) {
    thread maps\_so_survival_chaos::chaos_init();
  }
}

survival_leaderboard_wave_func() {
  return level.current_wave;
}

survival_leaderboard_score_func() {
  foreach(var_1 in level.players) {}

  var_3 = (level.challenge_end_time - level.challenge_start_time) / 1000;
  var_4 = level.current_wave;
  var_5 = 0;

  foreach(var_1 in level.players) {}
  var_5 = var_5 + var_1.game_performance["credits"];

  var_8 = 999 * min(var_5 / (var_4 * 10000), 1.0);

  if(var_4 == 1) {
    return int(var_8);
  }
  var_9 = var_4 * 1000;
  var_10 = int(var_9 + var_8);
  return var_10;
}

other_player_performance(var_0, var_1) {
  if(maps\_utility::is_coop()) {
    return maps\_utility::get_other_player(var_0).game_performance[var_1];
  } else {
    return undefined;
  }
}

custom_eog_summary() {
  var_0 = int(min(level.challenge_end_time - level.challenge_start_time, 86400000));
  var_1 = int(var_0 % 1000 / 100);
  var_2 = int(var_0 / 1000) % 60;
  var_3 = int(var_0 / 60000) % 60;
  var_4 = int(var_0 / 3600000);

  if(var_4 < 10) {
    var_4 = "0" + var_4;
  }
  if(var_3 < 10) {
    var_3 = "0" + var_3;
  }
  if(var_2 < 10) {
    var_2 = "0" + var_2;
  }
  var_5 = var_4 + ":" + var_3 + ":" + var_2 + "." + var_1;
  var_6 = survival_leaderboard_score_func();

  foreach(var_8 in level.players) {
    var_9 = var_8.game_performance["kill"];
    var_10 = other_player_performance(var_8, "kill");
    var_11 = var_8.game_performance["headshot"];
    var_12 = other_player_performance(var_8, "headshot");
    var_13 = var_8.game_performance["accuracy"] + "%";
    var_14 = other_player_performance(var_8, "accuracy");

    if(isDefined(var_14)) {
      var_14 = var_14 + "%";
    }
    var_15 = var_8.game_performance["credits"];
    var_16 = other_player_performance(var_8, "credits");
    var_17 = var_8.game_performance["downed"];
    var_18 = other_player_performance(var_8, "downed");
    var_19 = var_8.game_performance["revives"];
    var_20 = other_player_performance(var_8, "revives");
    var_8 maps\_utility::set_eog_success_heading(level.current_wave);

    if(maps\_utility::is_coop()) {
      setDvar("ui_hide_hint", 1);
      var_8 maps\_utility::add_custom_eog_summary_line("", "@SPECIAL_OPS_PERFORMANCE_YOU", "@SPECIAL_OPS_PERFORMANCE_PARTNER");
      var_8 maps\_utility::add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_KILLS", var_9, var_10);
      var_8 maps\_utility::add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_HEADSHOT", var_11, var_12);
      var_8 maps\_utility::add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_ACCURACY", var_13, var_14);
      var_8 maps\_utility::add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_REVIVES", var_19, var_20);
      var_8 maps\_utility::add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_CREDITS_EARNED", var_15, var_16);
      var_8 maps\_utility::add_custom_eog_summary_line_blank();
      var_8 maps\_utility::add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_TIME", var_5);
      var_8 maps\_utility::add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_SCORE", var_6);
      continue;
    }

    setDvar("ui_hide_hint", 0);
    var_8 maps\_utility::add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_KILLS", var_9);
    var_8 maps\_utility::add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_HEADSHOT", var_11);
    var_8 maps\_utility::add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_ACCURACY", var_13);
    var_8 maps\_utility::add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_CREDITS_EARNED", var_15);
    var_8 maps\_utility::add_custom_eog_summary_line_blank();
    var_8 maps\_utility::add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_TIME", var_5);
    var_8 maps\_utility::add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_SCORE", var_6);
  }
}

survival_logic() {
  wait 0.05;
  maps/_so_survival_armory::armory_setup_players();
  thread survival_objective();
  thread survival_completion();

  if(getdvarint("survival_chaos") == 1) {
    thread maps\_so_survival_chaos::chaos_wave();
  } else {
    thread survival_wave();
  }
  thread survival_hud();
  thread survival_credits();
  thread survival_armory_hint();
}

survival_objective() {
  wait 2;

  if(getdvarint("survival_chaos") == 1) {
    objective_add(1, "active", &"SO_SURVIVAL_CHAOS_OBJECTIVE");
  } else {
    objective_add(1, "active", &"SO_SURVIVAL_SURVIVAL_OBJECTIVE");
  }
  objective_current_nomessage(1);
}

survival_completion() {
  level waittill("so_player_has_died");

  if(!common_scripts\utility::flag("start_survival")) {
    common_scripts\utility::flag_wait("start_survival");
  }
  if(!common_scripts\utility::flag("so_player_death_nofail")) {
    return;
  }
  common_scripts\utility::flag_set("win_survival");
}

survival_success_or_fail() {
  level endon("special_op_terminated");

  for(;;) {
    level waittill("wave_ended", var_0);

    if(var_0 >= 0) {
      common_scripts\utility::flag_set("so_player_death_nofail");
      return;
    }
  }
}

waittill_survival_start() {
  common_scripts\utility::flag_wait_or_timeout("start_survival", 5);
}

setup_players() {
  if(level.console) {
    setsaveddvar("aim_aimAssistRangeScale", "1");
    setsaveddvar("aim_autoAimRangeScale", "0");
  }

  var_0 = getEntArray("trigger_hurt", "classname");

  foreach(var_2 in level.players) {
    var_2 thread do_slamzoom();
    var_2 thread give_loadout();

    foreach(var_4 in var_0) {}
    var_2 thread hurtplayersthink(var_4);
  }

  thread player_performance_init();
  waittill_survival_start();
  level.so_c4_array = [];
  level.so_claymore_array = [];

  foreach(var_2 in level.players) {
    var_2 thread camping_think();
    var_2 thread decrease_rev_time();
    var_2 thread weapon_collect_ammo_adjust();
    var_2 thread watch_grenade_usage();
  }
}

watch_grenade_usage() {
  self endon("death");
  self endon("disconnect");
  thread watch_c4_usage();
  thread watch_claymore_usage();
}

watch_c4_usage() {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(isDefined(var_0) && isDefined(var_1) && isDefined(weaponinventorytype(var_1)) && weaponinventorytype(var_1) == "item" && issubstr(var_1, "c4")) {
      if(level.so_c4_array.size) {
        level.so_c4_array = common_scripts\utility::array_removeundefined(level.so_c4_array);

        if(level.so_c4_array.size >= 20) {
          level.so_c4_array[0] detonate();
        }
      }

      level.so_c4_array[level.so_c4_array.size] = var_0;
    }
  }
}

watch_claymore_usage() {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(isDefined(var_0) && isDefined(var_1) && isDefined(weaponinventorytype(var_1)) && weaponinventorytype(var_1) == "item" && issubstr(var_1, "claymore")) {
      if(level.so_claymore_array.size) {
        level.so_claymore_array = common_scripts\utility::array_removeundefined(level.so_claymore_array);

        if(level.so_claymore_array.size >= 20) {
          level.so_claymore_array[0] detonate();
        }
      }

      level.so_claymore_array[level.so_claymore_array.size] = var_0;
    }
  }
}

give_loadout() {
  self endon("death");
  self takeallweapons();
  give_player_weapon("weapon_1");
  give_player_weapon("weapon_2");
  give_player_weapon("weapon_3");
  give_player_grenade("grenade_1");
  give_player_grenade("grenade_2");
  give_player_armor("armor_1");
  wait 0.05;
  give_player_equipment("equipment_1");
  give_player_equipment("equipment_2");
  give_player_equipment("equipment_3");
  give_player_airsupport("airsupport_1");
  give_player_airsupport("airsupport_2");
  give_player_airsupport("airsupport_3");
  give_player_perk("perk_1");
  give_player_perk("perk_2");
  give_player_perk("perk_3");
}

give_player_weapon(var_0) {
  var_1 = get_loadout_item_ref(var_0);
  var_2 = get_loadout_item_ammo(var_1);

  if(var_1 != "") {
    self giveweapon(var_1);
    var_3 = weaponclass(var_1);

    if(var_3 == "pistol") {
      level.coop_incap_weapon = var_1;
    }
    if(var_2 == "max") {
      self setweaponammostock(var_1, weaponmaxammo(var_1));
    } else {
      self setweaponammostock(var_1, int(var_2));
    }
    if(var_0 == "weapon_1") {
      self switchtoweapon(var_1);
    }
  }
}

give_player_grenade(var_0) {
  var_1 = get_loadout_item_ref(var_0);
  var_2 = get_loadout_item_ammo(var_1);

  if(var_1 != "") {
    self giveweapon(var_1);

    if(var_2 == "max") {
      self setweaponammostock(var_1, weaponmaxammo(var_1));
    } else {
      self setweaponammostock(var_1, int(var_2));
    }
    if(var_1 == "flash_grenade") {
      self setoffhandsecondaryclass("flash");
    }
  }
}

give_player_armor(var_0) {
  var_1 = get_loadout_item_ref(var_0);
  var_2 = int(get_loadout_item_ammo(var_1));

  if(var_1 != "") {
    maps/_so_survival_armory::give_armor_amount(var_1, var_2);
  }
}

give_player_equipment(var_0) {
  var_1 = get_loadout_item_ref(var_0);

  if(var_1 != "") {
    var_2 = maps/_so_survival_armory::get_func_give("equipment", var_1);
    self thread[[var_2]](var_1);
  }
}

give_player_airsupport(var_0) {
  var_1 = get_loadout_item_ref(var_0);

  if(var_1 != "") {
    var_2 = maps/_so_survival_armory::get_func_give("airsupport", var_1);
    self thread[[var_2]](var_1);
  }
}

give_player_perk(var_0) {
  var_1 = get_loadout_item_ref(var_0);

  if(var_1 != "") {
    thread maps/_so_survival_perks::give_perk(var_1);
  }
}

decrease_rev_time() {
  if(!maps\_utility::is_coop()) {
    return;
  }
  for(;;) {
    level waittill("wave_ended");
    var_0 = 120;
    var_0 = var_0 - level.current_wave * 8;
    var_0 = max(var_0, 30);
    self.laststand_info.bleedout_time_default = var_0;
  }
}

weapon_collect_ammo_adjust() {
  level endon("special_op_terminated");
  self endon("death");

  if(!isDefined(self.survival_weapons_swapped)) {
    self.survival_weapons_swapped = [];
  }
  var_0 = self getweaponslistprimaries();

  for(;;) {
    self waittill("weapon_change", var_1);

    if(!weapon_collect_ammo_adjust_valid(var_1)) {
      continue;
    }
    var_2 = !maps\_utility::array_contains(var_0, var_1);

    if(!var_2) {
      continue;
    }
    if(!weapon_collect_ammo_adjust_was_recent(var_1)) {
      if(weapon_collect_balance_ammo(var_1)) {
        wave_has_boss(var_1);
      }
    }

    var_3 = self getweaponslistprimaries();

    foreach(var_5 in var_0) {
      if(!maps\_utility::array_contains(var_3, var_5)) {
        if(!weapon_collect_ammo_adjust_valid(var_5)) {
          continue;
        }
        wave_has_boss(var_5);
      }
    }

    var_0 = var_3;
    weapon_collect_clean_recorded_weapons();
  }
}

weapon_collect_ammo_adjust_valid(var_0) {
  if(weaponclass(var_0) == "none" || weaponclass(var_0) == "rocketlauncher" || weaponclass(var_0) == "item") {
    return 0;
  }
  if(weaponinventorytype(var_0) != "primary") {
    return 0;
  }
  return 1;
}

weapon_collect_ammo_adjust_was_recent(var_0) {
  if(!isDefined(self.survival_weapons_swapped)) {
    return 0;
  }
  if(!isDefined(self.survival_weapons_swapped[var_0])) {
    return 0;
  }
  if(gettime() - self.survival_weapons_swapped[var_0] <= 10000) {
    return 1;
  }
  return 0;
}

weapon_collect_balance_ammo(var_0) {
  var_1 = self getweaponammoclip(var_0);
  var_2 = self getweaponammostock(var_0);
  var_3 = weaponclipsize(var_0);
  var_4 = weaponmaxammo(var_0);

  if(var_1 == var_3) {
    return 0;
  }
  if(var_2 <= 0) {
    return 0;
  }
  var_5 = var_3 - var_1;
  var_6 = 0;

  if(var_5 > var_2) {
    var_6 = var_2;
  } else {
    var_6 = var_5;
  }
  self setweaponammoclip(var_0, var_1 + var_6);
  self setweaponammostock(var_0, var_2 - var_6);
  return 1;
}

wave_has_boss(var_0) {
  if(!isDefined(self.survival_weapons_swapped)) {
    self.survival_weapons_swapped = [];
  }
  self.survival_weapons_swapped[var_0] = gettime();
}

weapon_collect_clean_recorded_weapons() {
  if(!isDefined(self.survival_weapons_swapped) || !self.survival_weapons_swapped.size) {
    return;
  }
  var_0 = [];

  foreach(var_3, var_2 in self.survival_weapons_swapped) {
    if(weapon_collect_ammo_adjust_was_recent(var_3)) {
      var_0[var_3] = self.survival_weapons_swapped[var_3];
    }
  }

  self.survival_weapons_swapped = var_0;
}

do_slamzoom() {
  self disableweapons();
  self disableoffhandweapons();
  self freezecontrols(1);

  if(isDefined(self.last_modelfunc)) {
    self detachall();
    self setModel("");
  }

  var_0 = 1.75;
  var_1 = 16000;
  var_2 = self.origin;
  self playersetstreamorigin(var_2);
  self.origin = var_2 + (0, 0, var_1);
  var_3 = spawn("script_model", (69, 69, 69));
  var_3 setModel("tag_origin");
  var_3.origin = self.origin;
  var_3.angles = self.angles;
  self playerlinkTo(var_3, undefined, 1, 0, 0, 0, 0);
  var_3.angles = (var_3.angles[0] + 89, var_3.angles[1], 0);
  var_3 moveTo(var_2 + (0, 0, 0), var_0, 0, var_0);
  wait 0.05;
  self playSound("survival_slamzoom_out");
  wait(var_0 - 0.55);
  self visionsetnakedforplayer("coup_sunblind", 0.25);
  var_3 rotateTo((var_3.angles[0] - 89, var_3.angles[1], 0), 0.5, 0.3, 0.2);
  wait 0.2;
  self visionsetnakedforplayer("", 1.0);
  wait 0.5;
  self unlink();
  self enableweapons();
  self enableoffhandweapons();
  self freezecontrols(0);
  self playerclearstreamorigin();
  self notify("player_update_model");
  wait 0.5;
  common_scripts\utility::flag_set("slamzoom_finished");
  var_3 delete();
}

survival_waves_setup() {
  level.pmc_alljuggernauts = 0;
  level.skip_juggernaut_intro_sound = 1;
  level.survival_wave_intermission = 0;
  level.uav_struct.view_cone = 12;
  setsaveddvar("g_compassShowEnemies", "0");
  common_scripts\utility::array_thread(level.players, maps/_remotemissile_utility::setup_remote_missile_target);
  maps\_utility::add_global_spawn_function("axis", maps/_so_survival_code::ai_remote_missile_fof_outline);
  level.current_wave = 1;
  level thread update_wave();
}

update_wave() {
  level endon("special_op_terminated");
  var_0 = undefined;
  var_1 = 0;

  for(;;) {
    level waittill("wave_ended", var_2);
    var_3 = var_2 + 1;

    if(!maps/_so_survival_ai::wave_exist(var_3)) {
      if(!isDefined(var_0)) {
        var_0 = 0;
        var_1 = 1;
      }

      if(var_0 == level.survival_repeat_wave.size) {
        var_0 = 0;
        var_1++;
      }

      var_4 = spawnStruct();
      var_4.repeating = var_3 - 1;
      var_4.num = var_3;
      var_4._id_3D4B = level.survival_repeat_wave[var_0]._id_3D4B;
      var_4._id_3D4C = level.survival_repeat_wave[var_0]._id_3D4C;
      var_4._id_3D4D = level.survival_repeat_wave[var_0]._id_3D4D;
      var_4._id_3D4E = level.survival_repeat_wave[var_0]._id_3D4E;
      var_4._id_3D50 = level.survival_repeat_wave[var_0]._id_3D50;
      var_4._id_3D51 = level.survival_repeat_wave[var_0]._id_3D51;
      var_4._id_3D4F = level.survival_repeat_wave[var_0]._id_3D4F;
      var_4._id_3D52 = level.survival_repeat_wave[var_0]._id_3D52;
      var_4._id_3D53 = level.survival_repeat_wave[var_0]._id_3D53;
      var_4._id_3D54 = level.survival_repeat_wave[var_0]._id_3D54;
      var_5 = level.survival_wave[var_2];
      level.survival_wave = [];
      level.survival_wave[var_2] = var_5;
      level.survival_wave[var_4.num] = var_4;
      var_0++;
      level.survival_waves_repeated++;
    }
  }
}

survival_wave() {
  level endon("special_op_terminated");
  survival_waves_setup();
  thread intro_music();
  waittill_survival_start();

  if(!common_scripts\utility::flag("start_survival")) {
    common_scripts\utility::flag_set("start_survival");
  }
  level notify("wave_started", level.current_wave);
  setsaveddvar("bg_viewKickScale", "0.2");

  for(;;) {
    if(isDefined(level.leaders.size) && level.leaders.size >= 3) {}

    var_0 = maps/_so_survival_ai::get_squad_array(level.current_wave);
    var_1 = 0;

    foreach(var_3 in var_0) {
      if(var_3 > 0) {
        var_1 = var_1 + spawn_wave(1, var_3);
      }
    }

    level.special_ai = [];
    var_5 = maps/_so_survival_ai::get_special_ai(level.current_wave);

    if(isDefined(var_5)) {
      foreach(var_7 in var_5) {
        if(issubstr(var_7, "dog")) {
          thread maps/_so_survival_ai::spawn_dogs(var_7, maps/_so_survival_ai::get_dog_quantity(level.current_wave));
          continue;
        }

        var_8 = maps/_so_survival_ai::get_special_ai_type_quantity(level.current_wave, var_7);

        if(isDefined(var_8) && var_8 > 0) {
          var_9 = spawn_special_ai(var_7, var_8);
        }
      }
    }

    if(var_0[0] > 0) {
      thread reenforcement_squad_spawn(1, var_0[0]);
    }
    if(wave_has_boss(level.current_wave)) {
      thread spawn_boss();
    }
    level thread delayed_enemy_ping();

    for(var_11 = getaiarray("axis").size + maps/_so_survival_ai::dog_get_count(); var_11 > 4; var_11 = getaiarray("axis").size + maps/_so_survival_ai::dog_get_count()) {
      level common_scripts\utility::waittill_any_timeout(1.0, "axis_died");
    }
    common_scripts\utility::flag_set("aggressive_mode");
    maps/_squad_enemies::squad_disband(0, maps/_so_survival_ai::aggressive_squad_leader);
    level.squad_leader_behavior_func = maps/_so_survival_ai::aggressive_ai;
    level.special_ai_behavior_func = maps/_so_survival_ai::aggressive_ai;

    if(isDefined(level.special_ai) && level.special_ai.size > 0) {
      foreach(var_13 in level.special_ai) {}
      var_13 thread maps/_so_survival_ai::aggressive_ai();
    }

    for(var_11 = getaiarray("axis").size + maps/_so_survival_ai::dog_get_count(); var_11 > 0; var_11 = getaiarray("axis").size + maps/_so_survival_ai::dog_get_count()) {
      level common_scripts\utility::waittill_any_timeout(1.0, "axis_died");
    }
    level.squad_leader_behavior_func = maps/_so_survival_ai::default_ai;
    level.special_ai_behavior_func = maps/_so_survival_ai::default_ai;

    if(wave_has_boss(level.current_wave)) {
      common_scripts\utility::flag_wait("bosses_spawned");

      while(isDefined(level.bosses) && level.bosses.size) {
        wait 0.1;
      }
    }

    common_scripts\utility::flag_clear("aggressive_mode");
    level notify("wave_ended", level.current_wave);
    setsaveddvar("g_compassShowEnemies", "0");

    if(common_scripts\utility::flag("boss_music")) {
      level notify("end_boss_music");
      common_scripts\utility::flag_clear("boss_music");
      maps\_utility::music_stop(3);
    }

    survival_wave_pickup_downed_players();
    survival_wave_intermission();
    level.current_wave++;
    level notify("wave_started", level.current_wave);
  }
}

delayed_enemy_ping() {
  level endon("wave_ended");
  wait 7;
  setsaveddvar("g_compassShowEnemies", "1");
}

survival_wave_intermission() {
  level endon("special_op_terminated");
  level.survival_wave_intermission = 1;
  var_0 = 30;
  var_1 = 5;

  if(var_0 > 0) {
    wait 5;
    var_0 = var_0 - 5;
    common_scripts\utility::array_thread(level.players, ::survival_wave_catch_player_ready, "survival_all_ready", var_0 + var_1);
    level common_scripts\utility::waittill_any_timeout(var_0, "survival_all_ready");
    level notify("survival_all_ready");
  }

  foreach(var_3 in level.players) {}
  var_3 thread matchstarttimer(var_1);

  wait(var_1);
  level.survival_wave_intermission = 0;
}

survival_wave_catch_player_ready(var_0, var_1) {
  self endon("death");
  level endon("special_op_terminated");
  level endon(var_0);
  var_2 = maps\_specialops::so_hud_ypos() - 130;
  self.elem_ready_up = maps\_specialops::so_create_hud_item(-2, var_2, &"SO_SURVIVAL_READY_UP", self, 1);
  self.elem_ready_up elem_ready_up_setup();
  thread survival_wave_catch_player_ready_update("survival_player_ready", var_0, self.elem_ready_up, var_1);
  thread survival_wave_catch_player_ready_clean(var_0);

  if(level.console) {
    self notifyonplayercommand("survival_player_ready", "+stance");
  } else {
    self notifyonplayercommand("survival_player_ready", "skip");
  }
  self waittill("survival_player_ready");

  if(!isDefined(level.survival_players_ready)) {
    level.survival_players_ready = 1;
  } else {
    level.survival_players_ready++;
  }
  self.elem_ready_up maps\_specialops::so_remove_hud_item(1);

  if(level.survival_players_ready == level.players.size) {
    level notify(var_0);
  } else {
    var_3 = maps\_utility::get_other_player(self);

    if(isDefined(var_3) && isDefined(var_3.elem_ready_up)) {
      var_3.elem_ready_up.label = &"SO_SURVIVAL_PARTNER_READY";
    }
    self.elem_ready_up = maps\_specialops::so_create_hud_item(-2, var_2, &"SO_SURVIVAL_READY_UP_WAIT", self, 1);
    self.elem_ready_up elem_ready_up_setup();
  }
}

elem_ready_up_setup() {
  self.alignx = "left";
  self.fontscale = 0.75;
  self.alpha = 0.0;

  if(issplitscreen()) {
    self.horzalign = "center";
    self.x = 36;
    self.y = -22;
  }

  thread maps\_hud_util::fade_over_time(1.0, 0.5);
}

survival_wave_catch_player_ready_update(var_0, var_1, var_2, var_3) {
  level endon(var_1);
  self endon(var_0);

  for(var_3 = int(var_3); isDefined(var_2) && var_3 > 0; var_3--) {
    var_2 setvalue(var_3);
    wait 1.0;
  }
}

survival_wave_catch_player_ready_clean(var_0) {
  level waittill(var_0);
  level.survival_players_ready = undefined;

  if(isDefined(self.elem_ready_up)) {
    self.elem_ready_up maps\_specialops::so_remove_hud_item(1);
  }
}

survival_wave_pickup_downed_players() {
  foreach(var_1 in level.players) {
    if(maps\_utility::is_player_down(var_1)) {
      var_1.laststand_getup_fast = 1;
    }
  }
}

spawn_wave(var_0, var_1) {
  level endon("special_op_terminated");

  for(var_0 = int(var_0); var_0; var_0--) {
    var_2 = maps/_squad_enemies::spawn_far_squad(level.wave_spawn_locs, get_class("leader"), get_class("follower"), var_1 - 1);

    foreach(var_4 in var_2) {
      var_4 setthreatbiasgroup("axis");
      var_4 thread maps/_so_survival_ai::setup_ai_weapon();
    }
  }

  return level.leaders.size;
}

get_class(var_0) {
  var_1 = maps/_so_survival_ai::get_squad_type(level.current_wave);
  var_2 = maps/_so_survival_ai::get_squad_type(var_1);

  if(isDefined(var_0)) {}

  return var_2;
}

spawn_special_ai(var_0, var_1) {
  var_2 = [];
  var_2[var_2.size] = level.player;

  if(maps\_utility::is_coop()) {
    var_2[var_2.size] = level.players[1];
  }
  var_3 = maps/_so_survival_ai::get_squad_type(var_0);
  var_4 = maps/_so_survival_code::get_spawners_by_classname(var_3)[0];

  for(var_5 = 0; var_5 < var_1; var_5++) {
    wait 0.05;
    var_6 = maps/_so_survival_code::get_furthest_from_these(level.wave_spawn_locs, var_2, 4);
    var_4.count = 1;
    var_4.origin = var_6.origin;
    var_4.angles = var_6.angles;

    if(getdvarint("survival_chaos") == 1) {
      var_7 = var_4 maps\_utility::spawn_ai();
    } else {
      var_7 = var_4 maps\_utility::spawn_ai(1);
    }
    if(isDefined(var_7)) {
      var_7 setthreatbiasgroup("axis");
      var_7.ai_type = maps/_so_survival_ai::get_wave_number_by_index(var_0);
      level.special_ai[level.special_ai.size] = var_7;
      var_7 thread maps/_so_survival_code::clear_from_special_ai_array_when_dead();
      var_7 thread maps/_so_survival_ai::setup_ai_weapon();
      var_7 thread[[level.special_ai_behavior_func]]();
    }
  }

  return level.special_ai;
}

reenforcement_squad_spawn(var_0, var_1) {
  level endon("special_op_terminated");
  level endon("wave_ended");
  var_2 = level.leaders.size;
  var_3 = 0;

  while(var_3 < var_0) {
    if(level.leaders.size >= var_2) {
      wait 0.05;
      continue;
    }

    var_4 = getaiarray();

    if(var_4.size >= 32 - var_1) {
      wait 0.05;
      continue;
    }

    var_5 = maps/_squad_enemies::spawn_far_squad(level.wave_spawn_locs, get_class("leader"), get_class("follower"), var_1 - 1);

    foreach(var_7 in var_5) {
      var_7 setthreatbiasgroup("axis");
      var_7 thread maps/_so_survival_ai::setup_ai_weapon();
    }

    var_3++;
  }
}

reenforcement_special_ai_spawn(var_0, var_1) {
  level endon("special_op_terminated");
  level endon("wave_ended");
  var_2 = level.special_ai.size;
  var_3 = 0;

  while(var_3 < var_1) {
    if(level.special_ai.size >= var_2) {
      wait 0.05;
      continue;
    }

    var_4 = getaiarray();

    if(var_4.size > 31) {
      wait 0.05;
      continue;
    }

    spawn_special_ai(var_0, 1);
    var_3++;
    wait 0.05;
  }
}

wave_has_boss(var_0) {
  var_1 = maps/_so_survival_ai::get_bosses_ai(var_0);
  var_2 = maps/_so_survival_ai::get_bosses_nonai(var_0);

  if(isDefined(var_1) || isDefined(var_2)) {
    return 1;
  }
  return 0;
}

spawn_boss() {
  common_scripts\utility::flag_clear("bosses_spawned");

  if(level.survival_wave[level.current_wave]._id_3D4F && common_scripts\utility::flag_exist("aggressive_mode") && !common_scripts\utility::flag("aggressive_mode")) {
    common_scripts\utility::flag_wait("aggressive_mode");
  }
  level notify("boss_spawning", level.current_wave);
  level.bosses = [];
  var_0 = maps/_so_survival_ai::get_bosses_ai(level.current_wave);
  var_1 = maps/_so_survival_ai::get_bosses_nonai(level.current_wave);

  if(isDefined(var_0)) {
    if(getdvarint("survival_chaos") == 1) {
      spawn_boss_ai(var_0, 0);
    } else {
      spawn_boss_ai(var_0, 1);
    }
    if(level.bosses.size && isDefined(var_1)) {
      level common_scripts\utility::waittill_any_timeout(30, "juggernaut_jumpedout");
      wait 6;
    }
  }

  if(isDefined(var_1)) {
    thread spawn_boss_nonai(var_1, !isDefined(var_0));
  }
  common_scripts\utility::flag_set("bosses_spawned");
}

spawn_boss_ai(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(var_3 == "jug_minigun") {
      continue;
    }
    if(!issubstr(var_3, "jug_")) {
      continue;
    }
    var_4 = maps/_so_survival_code::chopper_wait_for_cloest_open_path_start(maps/_so_survival_code::random_player_origin(), "drop_path_start", "script_unload");
    thread maps/_so_survival_ai::spawn_juggernaut(var_3, var_4);
    wait 0.5;
  }

  if(var_1) {
    thread music_boss("juggernaut");
  }
}

spawn_boss_nonai(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(issubstr(var_3, "chopper")) {
      var_4 = maps/_so_survival_code::chopper_wait_for_cloest_open_path_start(maps/_so_survival_code::random_player_origin(), "chopper_boss_path_start", "script_stopnode");
      var_5 = maps/_so_survival_ai::spawn_chopper_boss(var_3, var_4);
      continue;
    }
  }

  if(var_1) {
    thread music_boss("chopper");
  }
}

spawn_allies(var_0, var_1, var_2) {
  var_3 = maps/_so_survival_code::chopper_wait_for_cloest_open_path_start(var_0, "drop_path_start", "script_unload");
  level notify("so_airsupport_incoming", var_1);
  maps/_so_survival_ai::spawn_ally_team(var_1, 3, var_3, var_2);
}

player_performance_init() {
  wait 0.05;
  level.performance_bonus["accuracy"] = 3;
  level.performance_bonus["damagetaken"] = 2;
  level.performance_bonus["time"] = 2;

  if(maps\_utility::is_coop()) {
    level.performance_bonus["wavebonus"] = 50;
    level.performance_bonus["headshot"] = 50;
    level.performance_bonus["kill"] = 50;
  } else {
    level.performance_bonus["wavebonus"] = 25;
    level.performance_bonus["headshot"] = 20;
    level.performance_bonus["kill"] = 10;
  }

  foreach(var_1 in level.players) {
    var_1.game_performance = [];
    var_1.game_performance["headshot"] = 0;
    var_1.game_performance["accuracy"] = 0;
    var_1.game_performance["damagetaken"] = 0;
    var_1.game_performance["kill"] = 0;
    var_1.game_performance["credits"] = 0;
    var_1.game_performance["downed"] = 0;
    var_1.game_performance["revives"] = 0;
    var_1.performance = [];
    var_1.performance["headshot"] = 0;
    var_1.performance["accuracy"] = 0;
    var_1.performance["time"] = 0;
    var_1.performance["damagetaken"] = 0;
    var_1.performance["kill"] = 0;
    var_1.performance["wavebonus"] = 0;
    var_1 player_performance_ui_init();
    var_1 thread player_performance_think();
  }

  maps\_utility::add_global_spawn_function("axis", ::performance_track_headshot);
}

player_performance_reset() {
  maps\_specialops::_setplayerdata_single("surHUD_performance_reward", 0);

  foreach(var_2, var_1 in self.performance) {
    self.performance[var_2] = 0;
    maps\_specialops::_setplayerdata_array("surHUD_performance", var_2, 0);
    maps\_specialops::_setplayerdata_array("surHUD_performance_p2", var_2, 0);
    maps\_specialops::_setplayerdata_array("surHUD_performance_credit", var_2, 0);
  }
}

player_performance_think() {
  self endon("death");
  thread performance_wave_reset();
  thread performance_track_downed();
  thread performance_track_revives();
  thread performance_track_credits();
  thread performance_track_time();
  thread performance_track_damage();
  thread performance_track_accuracy();
  thread performance_track_kills();
  thread performance_track_waves();

  for(;;) {
    level waittill("wave_ended");
    maps\_player_stats::career_stat_increment("waves_survived", 1);
    waittillframeend;
    var_0 = reward_calculation();

    if(var_0["total"]) {
      thread maps\_utility::givexp("personal_wave_reward", var_0["total"]);
    }
    thread performance_summary(var_0);
    level waittill("wave_started");
    self.camping_time = 0;
  }
}

performance_wave_reset() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    level waittill("wave_started");
    player_performance_reset();
    self.stats["kills"] = 0;
    self.stats["shots_fired"] = 0;
    self.stats["shots_hit"] = 0;
  }
}

performance_track_revives() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("so_revive_success");
    self.game_performance["revives"]++;
  }
}

performance_track_downed() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("player_downed");
    self.game_performance["downed"]++;
  }
}

performance_track_credits() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("deposit_credits", var_0, var_1);

    if(self.survival_credit >= 50000 && !isDefined(self._id_00DE)) {
      self._id_00DE = 1;
      thread maps\_specialops::so_achievement_update("GET_RICH_OR_DIE_TRYING");
    }

    if(isDefined(var_1) && var_1) {
      continue;
    }
    if(var_0 > 0) {
      self.game_performance["credits"] = self.game_performance["credits"] + var_0;
    }
  }
}

performance_track_time() {
  level endon("special_op_terminated");
  self endon("death");
  waittill_survival_start();

  for(;;) {
    var_0 = gettime();
    level waittill("wave_ended");
    self.performance["time"] = gettime() - var_0;
    level waittill("wave_started");
  }
}

performance_track_headshot() {
  level endon("special_op_terminated");

  if(!isai(self)) {
    return;
  }
  var_0 = 0;
  self waittill("death", var_1, var_2, var_3, var_4, var_5, var_6, var_7);

  if(maps/_so_survival_code::was_headshot() && isPlayer(var_1)) {
    var_8 = "player.performance array is missing headshot setting";
    var_1.performance["headshot"]++;
    var_1.game_performance["headshot"]++;
    var_1 notify("sur_ch_headshot");
  }
}

performance_track_damage() {
  level endon("special_op_terminated");
  self endon("death");

  if(isDefined(self.armor)) {
    self.previous_armor = self.armor["points"];
  } else {
    self.previous_armor = 0;
  }
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_1) && var_1 != self && isDefined(var_1.team) && var_1.team == self.team) {
      continue;
    }
    thread performance_damagetaken_update(var_0);
  }
}

performance_damagetaken_update(var_0) {
  var_1 = 100 + self.previous_armor;
  var_2 = int(min(var_1, var_0));
  self.performance["damagetaken"] = self.performance["damagetaken"] + var_2;
  self.game_performance["damagetaken"] = self.game_performance["damagetaken"] + var_2;
  waittillframeend;

  if(isDefined(self.armor)) {
    self.previous_armor = self.armor["points"];
  } else {
    self.previous_armor = 0;
  }
}

performance_track_accuracy() {
  level endon("special_op_terminated");
  self endon("death");
  var_0 = 0;
  var_1 = 0;

  for(;;) {
    self waittill("weapon_fired");
    var_2 = max(1, float(self.stats["shots_fired"]));
    var_3 = float(self.stats["shots_hit"]);
    var_0 = var_0 + var_2;
    var_1 = var_1 + var_3;
    self.performance["accuracy"] = maps/_so_survival_code::int_capped(100 * (var_3 / var_2), 0, 100);
    self.game_performance["accuracy"] = maps/_so_survival_code::int_capped(100 * (var_1 / var_0), 0, 100);
  }
}

performance_track_kills() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    level waittill("specops_player_kill", var_0);

    if(isDefined(var_0) && isPlayer(var_0) && var_0 == self) {
      self.performance["kill"]++;
      self.game_performance["kill"]++;
    }
  }
}

performance_track_waves() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    level waittill("wave_ended", var_0);
    self.performance["wavebonus"] = var_0;

    if(!isDefined(self._id_00DF)) {
      self._id_00DF = 1;
      thread maps\_specialops::so_achievement_update("I_LIVE");
    }

    if(var_0 == 9) {
      thread maps\_specialops::so_achievement_update("SURVIVOR");
    }
    if(var_0 == 14) {
      thread maps\_specialops::so_achievement_update("UNSTOPPABLE");
    }
  }
}

reward_calculation() {
  var_0 = self.performance["headshot"] * level.performance_bonus["headshot"];
  var_1 = int(max(self.performance["accuracy"] - 25, 0)) * level.performance_bonus["accuracy"];
  var_2 = 400;
  var_2 = var_2 - self.performance["damagetaken"] * level.performance_bonus["damagetaken"];
  var_2 = int(max(var_2, 0));
  var_3 = self.performance["kill"] * level.performance_bonus["kill"];
  var_4 = 0;
  var_5 = 90;
  var_6 = max(var_5 - int(self.performance["time"] / 1000), 0);
  var_4 = int(level.performance_bonus["time"] * var_6);
  var_7 = self.performance["wavebonus"] * level.performance_bonus["wavebonus"];
  var_8 = [];
  var_8["time"] = var_4;
  var_8["headshot"] = var_0;
  var_8["accuracy"] = var_1;
  var_8["damagetaken"] = var_2;
  var_8["kill"] = var_3;
  var_8["wavebonus"] = var_7;
  var_9 = 0;

  foreach(var_11 in var_8) {}
  var_9 = var_9 + var_11;

  var_8["total"] = get_reward(var_9);
  thread performance_summary_debug(var_8);
  return var_8;
}

get_reward(var_0) {
  return int(max(0, int(var_0)));
}

camping_think() {
  self endon("death");

  if(!isDefined(self.camper_detection)) {
    self.camper_detection = 0;
  }
  self.camping_locs = [];
  self.camping_time = 0;
  thread camp_response();
  var_0 = self.origin;
  var_1 = 0;
  var_2 = 0;

  for(;;) {
    self.camping = 0;
    self.camping_loc = self.origin;
    var_1 = 0;
    var_0 = self.origin;

    while(var_1 <= 20) {
      if(distance(var_0, self.origin) < 220) {
        var_1++;
      } else {
        var_1 = var_1 - 2;
      }
      if(self.health < 40) {
        var_1--;
      }
      if(self.stats["kills"] - var_2 > 0) {
        var_1 = var_1 + (self.stats["kills"] - var_2);
      }
      if(var_1 <= 0 || level.survival_wave_intermission || maps\_utility::ent_flag_exist("laststand_downed") && maps\_utility::ent_flag("laststand_downed")) {
        var_1 = 0;
        var_0 = self.origin;
      }

      var_2 = self.stats["kills"];
      wait 1;
    }

    self.camping = 1;
    self.camping_loc = self.origin;
    self.camping_locs[self.camping_locs.size] = self.camping_loc;
    self notify("camping");

    while(distance(var_0, self.origin) < 260) {
      self.camping_time++;
      wait 1;
    }

    self notify("stopped camping");
  }
}

camp_response() {
  self endon("death");
  level.camp_response_interval = 8;

  for(;;) {
    wait 0.05;

    if(!isDefined(self.camping) || !isDefined(self.camping_loc) || !isDefined(self.camping_time)) {
      continue;
    }
    if(self.camping) {
      thread level_ai_respond(self.camping_loc, self.camping_time);
      thread level_ai_boss_respond(self.camping_loc, self.camping_time);
      wait(level.camp_response_interval);
    }
  }
}

level_ai_respond(var_0, var_1) {
  var_2 = getaiarray("axis");

  foreach(var_4 in var_2) {}
  var_4 thread maps/_so_survival_code::throw_grenade_at_player(self);
}

level_ai_boss_respond(var_0, var_1) {
  if(isDefined(level.bosses) && level.bosses.size) {
    var_2 = level.bosses[randomint(level.bosses.size)];
  }
}

survival_credits() {
  level endon("special_op_terminated");

  foreach(var_1 in level.players) {}
  var_1 credits_ui_init();

  waittill_survival_start();

  foreach(var_1 in level.players) {
    var_1.survival_credit = 0;

    if(getdvarint("survival_chaos") != 1) {
      var_1 thread update_from_xp();
      var_1 thread update_from_credits();
    }
  }
}

update_from_xp() {
  self endon("death");

  for(;;) {
    self.old_xp = self.summary["rankxp"];
    self.old_credits = self.survival_credit;
    self waittill("xp_updated", var_0);

    if(!isDefined(var_0)) {
      continue;
    }
    var_1 = self.summary["rankxp"] - self.old_xp;
    self.survival_credit = self.survival_credit + var_1;

    if(isDefined(self.rankupdatetotal) && self.rankupdatetotal > var_1) {
      thread ui_rolling_credits(self.old_credits, self.rankupdatetotal);
    } else {
      thread ui_rolling_credits(self.old_credits, var_1);
    }
    self notify("deposit_credits", var_1);
  }
}

update_from_credits() {
  self endon("death");

  for(;;) {
    self.old_xp = self.summary["rankxp"];
    self.old_credits = self.survival_credit;
    self waittill("credit_updated", var_0);
    var_1 = self.survival_credit - self.old_credits;

    if(isDefined(self.rankupdatetotal) && self.rankupdatetotal > var_1) {
      thread ui_rolling_credits(self.old_credits, self.rankupdatetotal);
    } else {
      thread ui_rolling_credits(self.old_credits, var_1);
    }
    self notify("deposit_credits", var_1, var_0);
  }
}

intro_music(var_0) {
  level endon("special_op_terminated");
  var_1 = "so_survival_regular_music";
  wait 1.5;
  maps\_utility::musicplaywrapper(var_1);
  wait 5;
  maps\_utility::music_stop(20);
}

music_boss(var_0) {
  level endon("special_op_terminated");
  level endon("end_boss_music");
  common_scripts\utility::flag_set("boss_music");
  maps\_utility::music_stop(3);

  if(var_0 == "chopper") {
    var_1 = "so_survival_boss_music_01";
  } else if(var_0 == "juggernaut") {
    var_1 = "so_survival_boss_music_02";
  } else {
    var_1 = "so_survival_boss_music_01";
  }
  var_2 = maps\_utility::musiclength(var_1) + 2;

  while(common_scripts\utility::flag("boss_music")) {
    maps\_utility::musicplaywrapper(var_1);
    wait(var_2);
  }
}

hud_init() {
  level endon("special_op_terminated");
}

survival_hud() {
  thread hud_init();
  thread wave_splash();

  foreach(var_1 in level.players) {
    var_1 maps/_so_survival_code::player_reward_splash_init();
    var_1 thread wave_hud();
    var_1 thread armor_hud();

    if(getdvarint("survival_chaos") != 1) {
      var_1 thread laststand_hud();
    }
    var_1 thread perk_hud();
    var_1 thread enemy_remaining_hud();
  }
}

credits_ui_init() {
  maps\_specialops::_setplayerdata_single("surHUD_credits", 0);
  maps\_specialops::_setplayerdata_single("surHUD_credits_delta", 0);
  maps\_specialops::surhud_enable("credits");
}

ui_rolling_credits(var_0, var_1) {
  self notify("stop_animate_credits");
  self endon("stop_animate_credits");
  maps\_specialops::_setplayerdata_single("surHUD_credits_delta", 0);
  maps\_specialops::surhud_animate("credits");
  maps\_specialops::_setplayerdata_single("surHUD_credits", self.survival_credit);
  maps\_specialops::_setplayerdata_single("surHUD_credits_delta", var_1);
}

wave_timer_player_setup() {
  level endon("special_op_terminated");
  var_0 = "Player is either dead or removed while trying to setup its hud.";
  var_1 = 28;
  var_2 = maps\_specialops::so_hud_ypos();
  var_3 = var_2 + 12 + var_1;
  self.hud_so_wave_timer_time = maps\_specialops::so_create_hud_item(-1, var_2, &"SO_SURVIVAL_SURVIVE_TIME", self, 1);
  self.hud_so_wave_timer_clock = maps\_specialops::so_create_hud_item(-1, var_2 - var_1, undefined, self, 1);
  self.hud_so_wave_timer_time.alignx = "left";
  self.hud_so_wave_timer_clock.alignx = "left";
  self.hud_so_wave_timer_clock setshader("hud_show_timer", var_1, var_1);
  self.hud_so_wave_timer_clock.alpha = 0;
  self.hud_so_wave_timer_time.alpha = 0;
  thread wave_timer_wait_start(self.hud_so_wave_timer_time, self.hud_so_wave_timer_clock);
}

wave_timer_wait_start(var_0, var_1) {
  level endon("special_op_terminated");
  self endon("death");
  waittill_survival_start();

  for(;;) {
    var_0.label = "";
    var_0 settenthstimerup(0.0);
    var_2 = gettime();
    var_0 thread maps\_hud_util::fade_over_time(1.0, 0.5);
    var_1 thread maps\_hud_util::fade_over_time(1.0, 0.5);
    level waittill("wave_ended");
    var_0.label = "";
    var_3 = max(1, (gettime() - var_2) / 1000);
    var_0 settenthstimerstatic(var_3);
    var_4 = "";

    if(1) {
      var_4 = common_scripts\utility::waittill_any_timeout(1.75, "wave_started");
    }
    if(isDefined(var_4) && var_4 == "wave_started") {
      var_0 thread maps\_hud_util::fade_over_time(0.0, 0.0);
      var_1 thread maps\_hud_util::fade_over_time(0.0, 0.0);
      continue;
    }

    var_0 thread maps\_hud_util::fade_over_time(0.0, 0.5);
    var_1 thread maps\_hud_util::fade_over_time(0.0, 0.5);
    level waittill("wave_started");
  }
}

armor_hud() {
  self endon("death");
  self.armor_x = 0;

  if(issplitscreen()) {
    self.armor_y = 112 + (self == level.player) * 27;
  } else {
    self.armor_y = 196;
  }
  if(getdvarint("survival_chaos") == 1) {
    self.armor_shield_size = 38;
  } else {
    self.armor_shield_size = 28;
  }
  self.shield_elem = special_item_hudelem(self.armor_x, self.armor_y);
  self.shield_elem setshader("teamperk_blast_shield", self.armor_shield_size, self.armor_shield_size);
  self.shield_elem.alpha = 0.85;
  self.shield_elem_fade = special_item_hudelem(self.armor_x, self.armor_y);
  self.shield_elem_fade.alpha = 0;
  thread print_armor_hint();
  waittillframeend;

  for(;;) {
    if(isDefined(self.armor) && isDefined(self.armor["points"]) && self.armor["points"]) {
      if(getdvarint("survival_chaos") == 1) {
        var_0 = 250;
      } else {
        var_0 = 100;
      }
      var_1 = maps/_so_survival_code::float_capped(self.armor["points"] / (var_0 / 2), 0, 1);
      var_2 = 1 - maps/_so_survival_code::float_capped((self.armor["points"] - var_0 / 2) / (var_0 / 2), 0, 1);
      self.shield_elem.alpha = 0.85;
      self.shield_elem.color = (1, maps/_so_survival_code::float_capped(var_1, 0, 0.95), maps/_so_survival_code::float_capped(var_1, 0, 0.7));

      if(getdvarint("survival_chaos") == 1) {
        if(self.armor["points"] < var_0) {
          thread armor_jitter();
        }
      } else {
        thread armor_jitter();
      }
    } else {
      self.shield_elem.alpha = 0;
    }
    common_scripts\utility::waittill_any("damage", "health_update");
  }
}

armor_jitter() {
  self endon("death");
  self.shield_elem_fade.alpha = 0.85;
  var_0 = 20;

  for(var_1 = 0; var_1 <= var_0; var_1++) {
    var_2 = randomint(int(max(1, 5 - var_1 / (var_0 / 5)))) - int(2 - var_1 / (var_0 / 2));
    self.shield_elem.x = self.armor_x + var_2;
    self.shield_elem.y = self.armor_y + var_2;
    var_3 = int(var_1 * (40 / var_0));
    self.shield_elem_fade setshader("teamperk_blast_shield", self.armor_shield_size + var_3, self.armor_shield_size + var_3);
    self.shield_elem_fade.alpha = max((var_0 * 0.85 - var_1) / var_0, 0);
    wait 0.05;
  }

  self.shield_elem_fade.alpha = 0;
  self.shield_elem.x = self.armor_x;
  self.shield_elem.y = self.armor_y;
}

print_armor_hint(var_0) {
  self endon("death");
  self.armor_label = special_item_hudelem(self.armor_x, self.armor_y);
  self.armor_label.alpha = 0.85;
  self.armor_label.elemtype = "font";
  self.armor_label.label = &"SO_SURVIVAL_ARMOR_POINTS";
  self.armor_label.y = self.armor_label.y - 2;
  self.armor_label.x = self.armor_label.x - 58;
  self.armor_label.font = "hudbig";
  self.armor_label.fontscale = 0.5;
  self.armor_label.width = 0;
  self.armor_label.color = (1, 0.95, 0.7);
  self.armor_label.alignx = "left";

  if(isDefined(self.armor)) {
    self.armor_label setvalue(self.armor["points"]);
  } else {
    self.armor_label setvalue(0);
  }
  var_1 = 14;

  for(;;) {
    if(!isDefined(self.armor) || !isDefined(self.armor["points"]) || !self.armor["points"]) {
      self.armor_label.alpha = 0;
      wait 0.05;
      continue;
    }

    self.armor_label.alpha = 0.85;
    var_2 = "";
    var_3 = 2;
    var_4 = 6;

    while(var_4 > 0 || var_1 > 0) {
      var_2 = common_scripts\utility::waittill_any_timeout(0.5, "damage", "health_update");
      self.armor_label setvalue(self.armor["points"]);
      var_4 = var_4 - 0.5;

      if(var_1 > 0) {
        var_1 = var_1 - 0.5;
      }
      if(self.armor["points"] <= 0) {
        var_3 = 0.5;
        break;
      }
    }

    self.armor_label fadeovertime(var_3);
    self.armor_label.alpha = 0;

    if(var_2 != "damage" && var_2 != "health_update") {
      common_scripts\utility::waittill_any("damage", "health_update");
    }
  }
}

enemy_remaining_hud() {
  self endon("death");
  maps\_specialops::surhud_disable("enemy");
  maps\_specialops::_setplayerdata_single("surHUD_enemy", 0);

  for(;;) {
    level common_scripts\utility::waittill_either("axis_spawned", "axis_died");

    if(!common_scripts\utility::flag("aggressive_mode")) {
      maps\_specialops::surhud_disable("enemy");
      continue;
    }

    if(getdvarint("survival_chaos") != 1) {
      maps\_specialops::surhud_enable("enemy");
      maps\_specialops::_setplayerdata_single("surHUD_enemy", level.enemy_remaining);
    }
  }
}

perk_hud() {
  self endon("death");
  self.perk_icon_hud = spawnStruct();

  if(getdvarint("survival_chaos") == 1) {
    self.perk_icon_hud.pos_x = -138 + level.perk_offset;
  } else {
    self.perk_icon_hud.pos_x = -138;
  }
  if(issplitscreen()) {
    self.perk_icon_hud.pos_y = 112 + (self == level.player) * 27;
  } else {
    self.perk_icon_hud.pos_y = 196;
  }
  self.perk_icon_hud.icon_size = 28;
  self.perk_icon_hud.icon = special_item_hudelem(self.perk_icon_hud.pos_x, self.perk_icon_hud.pos_y);
  self.perk_icon_hud.icon.color = (1, 1, 1);
  self.perk_icon_hud.icon.alpha = 0.0;

  for(;;) {
    self waittill("give_perk", var_0);
    var_1 = level.armory["airsupport"][var_0].icon;
    self.perk_icon_hud.icon setshader(var_1, self.perk_icon_hud.icon_size, self.perk_icon_hud.icon_size);
    self.perk_icon_hud.icon.alpha = 0.85;
  }
}

laststand_hud() {
  self endon("death");
  self.laststand_hud_lives = spawnStruct();
  self.laststand_hud_lives.pos_x = -104;

  if(issplitscreen()) {
    self.laststand_hud_lives.pos_y = 112 + (self == level.player) * 27;
  } else {
    self.laststand_hud_lives.pos_y = 196;
  }
  self.laststand_hud_lives.icon_size = 28;
  self.laststand_hud_lives.icon = special_item_hudelem(self.laststand_hud_lives.pos_x, self.laststand_hud_lives.pos_y);
  self.laststand_hud_lives.icon setshader("specialty_self_revive", self.laststand_hud_lives.icon_size, self.laststand_hud_lives.icon_size);
  self.laststand_hud_lives.icon.color = (1, 1, 1);
  self.laststand_hud_lives.icon.alpha = 0.0;

  for(;;) {
    var_0 = common_scripts\utility::waittill_any_return("laststand_lives_updated", "player_downed");

    if(var_0 == "player_downed") {
      self.laststand_hud_lives.icon.alpha = 0.0;
      continue;
    }

    if(maps\_laststand::get_lives_remaining() > 0) {
      self.laststand_hud_lives.icon.alpha = 1;
      continue;
    }

    self.laststand_hud_lives.icon.alpha = 0.0;
  }
}

special_item_hudelem(var_0, var_1) {
  var_2 = newclienthudelem(self);
  var_2.hidden = 0;
  var_2.elemtype = "icon";
  var_2.hidewheninmenu = 1;
  var_2.archived = 0;
  var_2.x = var_0;
  var_2.y = var_1;
  var_2.alignx = "center";
  var_2.aligny = "middle";
  var_2.horzalign = "center";
  var_2.vertalign = "middle";
  return var_2;
}

wave_hud() {
  self endon("death");
  maps\_specialops::surhud_disable("wave");
  maps\_specialops::_setplayerdata_single("surHUD_wave", 0);

  for(;;) {
    level waittill("wave_started");
    maps\_specialops::surhud_enable("wave");
    maps\_specialops::_setplayerdata_single("surHUD_wave", level.current_wave);
  }
}

matchstarttimer(var_0) {
  var_1 = creatcountdownhudelem("hudbig", 1);
  var_1 maps\_hud_util::setpoint("CENTER", "CENTER", 0, 0);
  var_1.sort = 1001;
  var_1.glowcolor = (0.15, 0.35, 0.85);
  var_1.color = (0.95, 0.95, 0.95);
  var_1.foreground = 0;
  var_1.hidewheninmenu = 1;
  var_1 fontpulseinit();
  matchstarttimer_internal(int(var_0), var_1);
  var_1 destroy();
}

fontpulseinit(var_0) {
  self.basefontscale = self.fontscale;

  if(isDefined(var_0)) {
    self.maxfontscale = min(var_0, 6.3);
  } else {
    self.maxfontscale = min(self.fontscale * 2, 6.3);
  }
  self.inframes = 2;
  self.outframes = 4;
}

creatcountdownhudelem(var_0, var_1) {
  var_2 = newclienthudelem(self);
  var_2.elemtype = "font";
  var_2.font = "hudbig";
  var_2.fontscale = var_1;
  var_2.basefontscale = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2 maps\_hud_util::setparent(level.uiparent);
  var_2.hidden = 0;
  return var_2;
}

matchstarttimer_internal(var_0, var_1) {
  while(var_0 > 0) {
    if(var_0 > 99) {
      var_1.alpha = 0;
    } else {
      var_1.alpha = 1;
    }
    foreach(var_3 in level.players) {}
    var_3 playSound("so_countdown_beep");

    var_1 thread fontpulse();
    wait(var_1.inframes * 0.05);
    var_1 setvalue(var_0);
    var_0--;
    wait(1 - var_1.inframes * 0.05);
  }
}

fontpulse() {
  self notify("fontPulse");
  self endon("fontPulse");
  self endon("death");
  self changefontscaleovertime(self.inframes * 0.05);
  self.fontscale = self.maxfontscale;
  wait(self.inframes * 0.05);
  self changefontscaleovertime(self.outframes * 0.05);
  self.fontscale = self.basefontscale;
}

player_performance_ui_init() {
  player_performance_reset();
  maps\_specialops::surhud_disable("performance");
}

performance_summary(var_0) {
  self endon("death");

  if(maps\_utility::is_coop()) {
    waittillframeend;
  }
  foreach(var_4, var_2 in self.performance) {
    maps\_specialops::_setplayerdata_array("surHUD_performance", var_4, self.performance[var_4]);
    maps\_specialops::_setplayerdata_array("surHUD_performance_credit", var_4, var_0[var_4]);

    if(maps\_utility::is_coop()) {
      var_3 = maps\_utility::get_other_player(self);
      maps\_specialops::_setplayerdata_array("surHUD_performance_p2", var_4, var_3.performance[var_4]);
    }
  }

  maps\_specialops::_setplayerdata_single("surHUD_performance_reward", var_0["total"]);
  wait 1;
  maps\_specialops::surhud_animate("performance");
}

performance_summary_debug(var_0) {
  var_1 = "---------------------------------------------";
  var_2 = "COOP";

  if(!maps\_utility::is_coop()) {
    var_2 = "SOLO";
  }
  foreach(var_5, var_4 in var_0) {
    if(var_5 == "total") {
      continue;
    }
  }
}

wave_splash() {
  level endon("special_op_terminated");
  waittill_survival_start();

  for(;;) {
    level waittill("wave_started");
    thread wave_start_splash("");
    level waittill("wave_ended", var_0);
    maps/_so_survival_code::waittill_players_ready_for_splash(10);
    thread wave_clear_splash(var_0);
  }
}

wave_start_splash(var_0) {
  var_1 = spawnStruct();
  var_1.title = &"SO_SURVIVAL_WAVE_TITLE";
  var_1.duration = 1.5;
  var_1.sound = "survival_wave_start_splash";
  common_scripts\utility::array_thread(level.players, ::player_wave_splash, var_1);
}

wave_clear_splash(var_0) {
  var_1 = spawnStruct();
  var_1.title = &"SO_SURVIVAL_WAVE_SUCCESS_TITLE";
  var_1.title_set_value = var_0;
  var_1.duration = 2.5;
  var_1.sound = "survival_wave_end_splash";
  common_scripts\utility::array_thread(level.players, ::player_wave_splash, var_1);
}

player_wave_splash(var_0) {
  if(isDefined(self.doingnotify) && self.doingnotify) {
    while(self.doingnotify) {
      wait 0.05;
    }
  }

  if(!isDefined(var_0.duration)) {
    var_0.duration = 1.5;
  }
  var_0.title_glowcolor = (0.15, 0.35, 0.85);
  var_0.title_color = (0.95, 0.95, 0.95);
  var_0.type = "wave";
  var_0.title_font = "hudbig";
  var_0.playsoundlocally = 1;
  var_0.zoomin = 1;
  var_0.zoomout = 1;
  var_0.fadein = 1;
  var_0.fadeout = 1;

  if(issplitscreen()) {
    var_0.title_basefontscale = 1;
    var_0.desc_basefontscale = 1.2;
  } else {
    var_0.title_basefontscale = 1.1;
    var_0.desc_basefontscale = 1.2;
  }

  maps/_so_survival_code::splash_notify_message(var_0);
}

survival_armory_hint() {
  level endon("special_op_terminated");

  foreach(var_1 in level.players) {
    var_1 maps\_specialops::surhud_disable("armory");
    var_1 maps\_specialops::_setplayerdata_array("surHUD_unlock_hint_armory", "name", "");
    var_1 maps\_specialops::_setplayerdata_array("surHUD_unlock_hint_armory", "icon", "");
    var_1 maps\_specialops::_setplayerdata_array("surHUD_unlock_hint_armory", "desc", "");
  }

  for(;;) {
    level waittill("armory_open", var_3);
    var_4 = "";
    var_5 = "";
    var_6 = var_3.icon;

    if(var_3._id_3EC8 == "weapon") {
      var_4 = "@SO_SURVIVAL_ARMORY_WEAPON_AV";
      var_5 = "@SO_SURVIVAL_ARMORY_WEAPON_DESC";
    } else if(var_3._id_3EC8 == "airsupport") {
      var_4 = "@SO_SURVIVAL_ARMORY_AIRSUPPORT_AV";
      var_5 = "@SO_SURVIVAL_ARMORY_AIRSUPPORT_DESC";
    } else if(var_3._id_3EC8 == "equipment") {
      var_4 = "@SO_SURVIVAL_ARMORY_EQUIPMENT_AV";
      var_5 = "@SO_SURVIVAL_ARMORY_EQUIPMENT_DESC";
    }

    foreach(var_1 in level.players) {
      var_1 maps\_specialops::_setplayerdata_array("surHUD_unlock_hint_armory", "name", var_4);
      var_1 maps\_specialops::_setplayerdata_array("surHUD_unlock_hint_armory", "icon", var_6);
      var_1 maps\_specialops::_setplayerdata_array("surHUD_unlock_hint_armory", "desc", var_5);
      var_1 maps\_specialops::surhud_animate("armory");
    }
  }
}
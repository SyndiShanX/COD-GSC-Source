/*****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zquests\casual\island_ee_main.gsc
*****************************************************/

init_difficulty_settings() {
  level.zmb_island_escorts_wave_penalty = 1;
  level.zmb_anointed_pest_dies_to_ripsaw_gun = 0;
  level.pommel_room_boss_peacetime = 10;
  maps / mp / zquests / casual / island_ee_util::add_difficulty_setting("zmb_escort_bomber_health", 225, 100);
  maps / mp / zquests / casual / island_ee_util::add_difficulty_setting("zmb_escort_hc_pest_spawn_rate", 1, 0.4);
  maps / mp / zquests / casual / island_ee_util::add_difficulty_setting("zmb_escort_hc_pest_spawn_numbers", [6, 6, 10, 12]);
  maps / mp / zquests / casual / island_ee_util::add_difficulty_setting("zmb_escort_hc_pest_health_buddy", 10, 24, ::current_fodder_zombie_health, 20);
  maps / mp / zquests / casual / island_ee_util::add_difficulty_setting("zmb_escort_hc_pest_health_main", 15, 35, ::current_fodder_zombie_health, 20);
  maps / mp / zquests / casual / island_ee_util::add_difficulty_setting("zmb_escort_hc_follower_spawn_numbers", [2, 3, 3, 4]);
  maps / mp / zquests / casual / island_ee_util::add_difficulty_setting("zmb_escort_hc_follower_health_buddy", 30, 45, ::current_fodder_zombie_health, 20);
  maps / mp / zquests / casual / island_ee_util::add_difficulty_setting("zmb_escort_hc_follower_health_main", 45, 65, ::current_fodder_zombie_health, 20);
  maps / mp / zquests / casual / island_ee_util::add_difficulty_setting("zmb_escort_hc_assassin_health_main", 55, 70, ::current_fodder_zombie_health, 20);
  maps / mp / zquests / casual / island_ee_util::add_difficulty_setting("zmb_assassin_boss_health_1", 20, 40, ::current_fodder_zombie_health, 20);
  maps / mp / zquests / casual / island_ee_util::add_difficulty_setting("zmb_assassin_boss_health_2", 20, 40, ::current_fodder_zombie_health, 20);
  maps / mp / zquests / casual / island_ee_util::add_difficulty_setting("zmb_assassin_boss_health_3", 23, 50, ::current_fodder_zombie_health, 20);
  maps / mp / zquests / casual / island_ee_util::add_difficulty_setting("zmb_assassin_boss_health_4", 25, 55, ::current_fodder_zombie_health, 20);
  maps / mp / zquests / casual / island_ee_util::add_difficulty_setting("zmb_assassin_boss_fireman_health", 25, 30, ::current_fodder_zombie_health, 20);
  maps / mp / zquests / casual / island_ee_util::add_difficulty_setting("zmb_pommel_room_sacrifice_requirements", [50, 75, 75, 75]);
  maps / mp / zquests / casual / island_ee_util::add_difficulty_setting("zmb_assassin_boss_phase_1_zombie_count", 6, 8);
  maps / mp / zquests / casual / island_ee_util::add_difficulty_setting("zmb_assassin_boss_phase_2_zombie_count", 8, 12);
  maps / mp / zquests / casual / island_ee_util::add_difficulty_setting("zmb_assassin_boss_phase_3_zombie_count", 10, 14);
  maps / mp / zquests / casual / island_ee_util::add_difficulty_setting("zmb_assassin_boss_phase_4_zombie_count", 14, 14);
  maps / mp / zquests / casual / island_ee_util::add_difficulty_setting("zmb_assassin_boss_num_fire_panels", [5, 5, 6, 7]);
}

current_fodder_zombie_health(param_00) {
  if(level.var_A980 < param_00) {
    var_01 = param_00;
  } else {
    var_01 = level.var_A980;
  }

  return maps / mp / gametypes / zombies::func_1E59(lib_0547::func_A51("zombie_generic"), var_01);
}

get_difficulty_setting(param_00, param_01) {
  var_02 = level.zmb_island_difficulty_settings[param_00];
  if(isarray(var_02)) {
    var_03 = var_02[level.players.size - 1];
  } else {
    var_04 = lerp(var_03.minval, var_03.maxval, maps / mp / zquests / casual / island_ee_util::get_player_frac(level.players.size));
    var_03 = var_04 * [[var_02.var_3F02]](var_02.var_6E5C);
  }

  return var_03;
}

init() {
  common_scripts\utility::func_3C87("dont_spawn_fireman");
  common_scripts\utility::func_3C87("fireman_defeated");
  common_scripts\utility::func_3C87("flag_map_collected");
  common_scripts\utility::func_3C87("flag_corpse_door_found");
  common_scripts\utility::func_3C87("flag_ranger_head_taken");
  common_scripts\utility::func_3C87("flag_ranger_head_placed");
  common_scripts\utility::func_3C87("flag_subpen_traps_completed");
  common_scripts\utility::func_3C87("flag_freezer_combat_started");
  common_scripts\utility::func_3C87("flag_crane_in_motion");
  common_scripts\utility::func_3C87("flag_loader_complete");
  common_scripts\utility::func_3C87("fuel_valve_1");
  common_scripts\utility::func_3C87("fuel_valve_2");
  common_scripts\utility::func_3C87("fuel_valve_3");
  common_scripts\utility::func_3C87("flag_open_corpse_door");
  common_scripts\utility::func_3C87("razergun_1_placed");
  common_scripts\utility::func_3C87("razergun_2_placed");
  common_scripts\utility::func_3C87("razergun_3_placed");
  common_scripts\utility::func_3C87("players_have_razergun_1");
  common_scripts\utility::func_3C87("players_have_razergun_2");
  common_scripts\utility::func_3C87("players_have_razergun_3");
  common_scripts\utility::func_3C87("razergun_charged");
  common_scripts\utility::func_3C87("razergun_half_charged");
  common_scripts\utility::func_3C87("razergun_infused");
  common_scripts\utility::func_3C87("flag_straub_finishes_plane_talk");
  common_scripts\utility::func_3C87("flag_ui_planes_ee_done");
  common_scripts\utility::func_3C87("flag_used_island_turret");
  common_scripts\utility::func_3C87("flag_players_have_won");
  common_scripts\utility::func_3C87("flag_aa_guns_powered_on");
  common_scripts\utility::func_3C87("flag_radio_part_1_collected");
  common_scripts\utility::func_3C87("flag_radio_part_2_collected");
  common_scripts\utility::func_3C87("flag_hc_bomb_escort_complete");
  common_scripts\utility::func_3C87("flag_loader_zombie_unavailable");
  common_scripts\utility::func_3C87("flag_bomber_wave_punished");
  common_scripts\utility::func_3C87("flag_first_ship_spawned");
  common_scripts\utility::func_3C87("flag_destroyers_quest_complete");
  common_scripts\utility::func_3C87("flag_artillery_out_of_ammo_quest_started");
  common_scripts\utility::func_3C87("all wustlings spawned");
  common_scripts\utility::func_3C87("can_spawn_");
  common_scripts\utility::func_3C87("bring_in_next_type");
  common_scripts\utility::func_3C87("flag_first_plane_has_spawn");
  common_scripts\utility::func_3C87("flag_vo_inside_subpen");
  common_scripts\utility::func_3C87("flag_vo_subcrates");
  common_scripts\utility::func_3C87("flag_lookat_radio_dude");
  common_scripts\utility::func_3C87("frontline_zombies_spawned");
  common_scripts\utility::func_3C87("spawn_ships_straub_monologue_complete");
  thread vo_inside_subpens();
  thread setup_aa_guns_power_switch();
  thread blood_trail_vo();
  level.intro_zombies_sprint = 0;
  level.zombies_killed_in_intro = 0;
  level.subpen_switches_on = 0;
  level.the_classic_donation = 0;
  level.show_spine_harvest_text = 0;
  level thread aa_gun_trap_init();
  level thread maps\mp\_utility::func_6F74(::playerinwaterthink);
  level thread maps\mp\_utility::func_6F74(::beachassaultfadein);
  level thread spawn_heavies_pommel_room();
  lib_0557::func_7846("Explore the Beach", ::lib_0557::func_30D8, [], lib_0557::removed_quest_hint());
  lib_0557::func_781E("Explore the Beach", "Survive the Beach", ::quest_step_do_intro_assault, ::quest_step_intro_on_complete, lib_0557::removed_quest_hint());
  lib_0557::func_781E("Explore the Beach", "Reach Sub Pens", ::quest_step_reach_pen, ::lib_0557::func_30D8, lib_0557::removed_quest_hint());
  lib_0557::func_7848("Explore the Beach");
  thread quest_init_intro();
  lib_0557::func_7846("explore_the_island", ::lib_0557::func_30D8, ["Explore the Beach"], lib_0557::removed_quest_hint());
  lib_0557::func_781E("explore_the_island", "Pen Power", ::func_784F, ::quest_step_complete_enable_power, lib_0557::removed_quest_hint());
  lib_0557::func_781E("explore_the_island", "Explore Pen", ::quest_step_wait_for_corpsegate_found, ::quest_step_complete_wait_for_corpsegate_found, lib_0557::removed_quest_hint());
  lib_0557::func_7848("explore_the_island");
  lib_0557::func_7846("CORPSE_GATE", ::lib_0557::func_30D8, ["Aquire Wonder Weapon"], lib_0557::removed_quest_hint());
  lib_0557::func_781E("CORPSE_GATE", "Find way to open Gate", ::quest_step_wait_for_razor_gun_assembly, ::lib_0557::func_30D8, lib_0557::removed_quest_hint());
  lib_0557::func_781E("CORPSE_GATE", "Decapitate Ranger", ::quest_step_decap_ranger, ::quest_step_complete_decap_ranger, lib_0557::removed_quest_hint());
  lib_0557::func_781E("CORPSE_GATE", "Open Corpse Gate", ::quest_step_wait_for_first_corpsegate_opened, ::quest_step_complete_corpsegate_opened, lib_0557::removed_quest_hint());
  lib_0557::func_7848("CORPSE_GATE");
  thread quest_init_corpse_gate();
  common_scripts\utility::func_3C87("Commence Weapon Assembly");
  lib_0557::func_7846("Aquire Wonder Weapon", ::lib_0557::func_30D8, ["explore_the_island"], lib_0557::removed_quest_hint());
  lib_0557::func_781E("Aquire Wonder Weapon", "Melee Razor Gun Built", ::quest_step_build_razergun_1, ::razergun_build_melee_reward, lib_0557::removed_quest_hint());
  lib_0557::func_781E("Aquire Wonder Weapon", "Ranged Razor Gun Built", ::quest_step_build_razergun_2, ::razergun_build_ranged_reward, lib_0557::removed_quest_hint());
  lib_0557::func_7848("Aquire Wonder Weapon");
  thread quest_init_razergun_assembly();
  lib_0557::func_7846("Flak Tower", ::lib_0557::func_30D8, ["flag_straub_finishes_plane_talk"], lib_0557::removed_quest_hint());
  lib_0557::func_781E("Flak Tower", "Defend Flak Tower", ::quest_step_defend_the_flak_tower, ::flak_complete_xp_reward, lib_0557::removed_quest_hint());
  lib_0557::func_781E("Flak Tower", "Find crashed plane", ::quest_step_crashed_plane_find, ::flak_complete_xp_reward, lib_0557::removed_quest_hint());
  lib_0557::func_7848("Flak Tower");
  level.active_planes = [];
  lib_0557::func_7846("Interact with radio", ::lib_0557::func_30D8, ["Flak Tower"], lib_0557::removed_quest_hint());
  lib_0557::func_781E("Interact with radio", "Find Missing Part", ::quest_step_radio_find, ::lib_0557::func_30D8, lib_0557::removed_quest_hint());
  lib_0557::func_781E("Interact with radio", "Place Radio", ::quest_step_radio_place, ::lib_0557::func_30D8, lib_0557::removed_quest_hint());
  lib_0557::func_7848("Interact with radio");
  thread quest_init_radio();
  lib_0557::func_7846("Destroy 2nd Destroyer", ::lib_0557::func_30D8, ["Interact with radio"], lib_0557::removed_quest_hint());
  lib_0557::func_781E("Destroy 2nd Destroyer", "Find Artillery Ammo", ::quest_step_escort_loader, ::lib_0557::func_30D8, lib_0557::removed_quest_hint());
  lib_0557::func_781E("Destroy 2nd Destroyer", "1st Ship Destroyed", ::quest_step_get_destroyer1_hits, ::destroyer_complete_xp_reward, lib_0557::removed_quest_hint());
  lib_0557::func_7848("Destroy 2nd Destroyer");
  lib_0557::func_7846("Artillery Ammo", ::lib_0557::func_30D8, ["flag_artillery_out_of_ammo_quest_started"], lib_0557::removed_quest_hint());
  lib_0557::func_781E("Artillery Ammo", "Charge Artillery Ammo", ::quest_step_charge_artillery_ammo, ::lib_0557::func_30D8, lib_0557::removed_quest_hint());
  lib_0557::func_7848("Artillery Ammo");
  thread quest_init_destroyers();
  lib_0557::func_7846("Final Boss Island", ::lib_0557::func_30D8, ["Destroy 2nd Destroyer"], lib_0557::removed_quest_hint());
  lib_0557::func_781E("Final Boss Island", "Final Boss Island Part 1", ::quest_step_final_boss_island, ::bombers_init, lib_0557::removed_quest_hint());
  lib_0557::func_781E("Final Boss Island", "Final Boss Island Part 2", ::quest_step_final_boss_persuit_1, ::lib_0557::func_30D8, lib_0557::removed_quest_hint());
  lib_0557::func_781E("Final Boss Island", "Final Boss Island Part 3", ::quest_step_final_boss_persuit_2, ::lib_0557::func_30D8, lib_0557::removed_quest_hint());
  lib_0557::func_781E("Final Boss Island", "Defeat Wustlings", ::quest_step_final_boss_persuit_3, ::on_final_boss_defeated, lib_0557::removed_quest_hint());
  lib_0557::func_7848("Final Boss Island");
  thread quest_init_final_boss();
}

wait_on_hardcore_completed() {
  common_scripts\utility::func_3C9F("flag_pommel_given");
  lib_0557::func_782D("Epilogue Island", "Epilogue Island Continue Quest");
}

get_aa_turrets() {
  return getEntArray("tur_flak_gun", "script_noteworthy");
}

spawn_heavies_pommel_room() {
  var_00 = common_scripts\utility::func_46B7("zombie_assassin_pagan_room_spawner", "targetname");
  level thread run_pommel_room_assassin_timer();
  for(;;) {
    wait(30);
    if(common_scripts\utility::func_562E(level.disable_assassin_pushers)) {
      continue;
    }

    if(level.assassin_pommel_room_spawn_timer > 25 && pommel_room_assassin_player_pushes() < 3) {
      var_01 = maps / mp / zombies / zombie_assassin_spawner_logic::spawn_an_assassin(undefined, undefined, common_scripts\utility::func_7A33(var_00), undefined, "Phase 1: Entrance", 1, 1, undefined, undefined, undefined, undefined, ["isolated_room_zone"]);
      var_01.pommelroomplayerpusher = 1;
    }
  }
}

quest_step_final_boss_persuit_1() {}

quest_step_final_boss_persuit_2() {}

quest_step_final_boss_persuit_3() {}

run_pommel_room_assassin_timer() {
  level.assassin_pommel_room_spawn_timer = 0;
  for(;;) {
    wait(1);
    var_00 = 0;
    foreach(var_02 in level.players) {
      if(lib_055A::func_7413(var_02, "isolated_room_zone")) {
        var_00 = 1;
        break;
      }
    }

    if(var_00) {
      level.assassin_pommel_room_spawn_timer++;
      continue;
    }

    level.assassin_pommel_room_spawn_timer = 0;
  }
}

pommel_room_assassin_player_pushes() {
  var_00 = lib_0547::func_408F();
  var_01 = 0;
  foreach(var_03 in var_00) {
    if(common_scripts\utility::func_562E(var_03.pommelroomplayerpusher)) {
      var_01++;
    }
  }

  return var_01;
}

beachassaultfadein() {
  if(common_scripts\utility::func_3C77("frontline_zombies_spawned")) {
    return;
  }

  self.var_6772 = newclienthudelem(self);
  self.var_6772 setshader("black", 640, 480);
  self.var_6772.sort = 999;
  self.var_6772.horzalign = "fullscreen";
  self.var_6772.vertalign = "fullscreen";
  self.var_6772.foreground = 0;
  while(!level.var_3FA6) {
    wait 0.05;
  }

  common_scripts\utility::func_3C9F("frontline_zombies_spawned");
  thread animscripts / notetracks_common::do_fade_from_black(1.15);
}

_______globals__________() {}

aa_gun_trap_init() {
  var_00 = common_scripts\utility::func_46B7("aa_gun_trap", "targetname");
  common_scripts\utility::func_3C87("flak_cannons_ready");
  foreach(var_02 in var_00) {
    var_02 aa_gun_trap_prep();
    var_02 thread aa_gun_trap_buy_me();
  }

  foreach(var_05 in get_aa_turrets()) {
    var_05 thread plane_ee_manage_aa_swaps();
  }
}

aa_gun_trap_prep() {
  var_00 = common_scripts\utility::func_44BE(self.target, "targetname");
  self.var_1176 = [];
  foreach(var_02 in var_00) {
    switch (var_02.script_noteworthy) {
      case "trig_use":
        self.var_9D65 = var_02;
        self.var_9D65.hint_string_available = &"ZOMBIE_ISLAND_BUY_FLAK";
        self.var_9D65.hint_string_unavailable = &"ZOMBIE_ISLAND_FLAK_DISABLED";
        self.var_9D65.hint_string_no_power = &"ZOMBIE_ISLAND_FLAK_NO_POWER";
        var_02 setHintString(self.var_9D65.hint_string_unavailable);
        break;

      case "tur_flak_gun":
        self.var_9EDD = var_02;
        break;

      case "flak_cannon_attack_points":
        self.var_1176 = common_scripts\utility::func_F6F(self.var_1176, var_02);
        break;

      case "sbm_wall":
        self.wall_model = var_02;
        self.wall_model.health = 500;
        self.wall_model common_scripts\utility::func_3799("this_turret_is_done");
        break;
    }
  }
}

quest_init_freezer_zombie_manager() {}

_______intro_assault__________() {}

quest_init_intro() {}

quest_step_do_intro_assault() {
  level lib_0378::func_8D74("begin_intro_assault");
  level.var_1F4F["normal"] = ::dontdroppickups;
  level.var_ABDA = 1;
  var_00 = 50;
  level.eventpointmultiplier = 0.08;
  level.eventxpoverride = 5;
  var_01 = getEntArray("start_zone_spawners", "targetname");
  var_02 = common_scripts\utility::func_46B5("intro_bunker_struct", "targetname");
  level.intro_bunker_struct = var_02;
  var_03 = common_scripts\utility::func_44BE(var_02.target, "targetname");
  var_02.rush_spawners = [];
  foreach(var_05 in var_03) {
    switch (var_05.script_noteworthy) {
      case "zombie_spawner":
        switch (var_05.var_81A1) {
          case "zombie_beach_rush_spawner":
            var_02.rush_spawners = common_scripts\utility::func_F6F(var_02.rush_spawners, var_05);
            break;
        }
        break;
    }
  }

  var_07 = common_scripts\utility::func_46B7("zmb_island_frontline_zombies", "targetname");
  while(!level.var_3FA6) {
    wait 0.05;
  }

  while(!isDefined(level.var_6F43) || !lib_054D::func_1F70("zombie_generic")) {
    wait 0.05;
  }

  for(var_08 = 0; var_08 < var_07.size; var_08++) {
    try_spawn_intro_assault_zombie(1, var_07[var_08]);
  }

  common_scripts\utility::func_3C8F("frontline_zombies_spawned");
  wait(1);
  var_09 = lib_0557::func_782F(undefined, level.preplaced_turrets);
  lib_0557::func_781D("Explore the Beach", var_09);
  foreach(var_0B in level.players) {
    lib_0547::func_ABC9(var_0B, 3);
  }

  foreach(var_0E in level.var_AC1D) {
    foreach(var_10 in var_0E.var_9DC2) {
      var_10 common_scripts\utility::func_9D9F();
    }
  }

  thread turret_outline_logic();
  thread vo_beach_turrets_nags_check();
  thread vo_beach_blood();
  var_13 = lib_0547::func_408F();
  for(var_08 = 0; var_08 < 17; var_08++) {
    try_spawn_intro_assault_zombie(1);
    wait 0.05;
  }

  foreach(var_0B in level.players) {
    var_0B maps\mp\_utility::func_2CED(3, ::lib_0367::func_8E3D, "startbeach_both");
    var_0B maps\mp\_utility::func_2CED(8, ::lib_0367::func_8E3D, "mg42look_both");
  }

  var_16 = gettime();
  var_17 = 25;
  level thread start_intro_sprint();
  for(;;) {
    if(gettime() - var_16 / 1000 >= var_17) {
      break;
    }

    var_18 = gettime() - var_16 / 1000;
    try_spawn_intro_assault_zombie(undefined, undefined, var_18);
    if(level.players.size == 1) {
      wait(1);
      continue;
    }

    wait(0.5);
  }

  lib_0547::func_7BA9(::zombieskilledinintro);
  for(;;) {
    var_13 = lib_0547::func_408F();
    if(var_13.size <= 0) {
      break;
    }

    wait(0.1);
  }

  lib_0557::func_782D("Explore the Beach", "Survive the Beach");
  level.eventpointmultiplier = undefined;
  level.eventxpoverride = undefined;
  foreach(var_0E in level.var_AC1D) {
    foreach(var_10 in var_0E.var_9DC2) {
      var_10 common_scripts\utility::func_9DA3();
    }
  }

  foreach(var_0B in level.players) {
    if(var_0B.var_62D6 % 10 != 0) {
      var_0B maps / mp / gametypes / zombies::func_4798(5);
    }
  }

  lib_0547::func_2D8C(::zombieskilledinintro);
  level lib_0378::func_8D74("end_intro_assault");
  wait(5);
  foreach(var_0B in level.players) {
    var_0B lib_0367::func_8E3D("beachover_both");
  }
}

start_intro_sprint() {
  level endon("zombies_manual_start");
  if(level.players.size == 1) {
    return;
  }

  var_00 = [];
  var_01 = 0.7;
  wait(2);
  while(var_00.size < 10) {
    var_02 = lib_0547::func_408F();
    var_02 = common_scripts\utility::func_F7D(var_02, var_00);
    var_03 = common_scripts\utility::func_4461(level.players[0].origin, var_02);
    if(isDefined(var_03)) {
      var_03.var_6941 = 1;
      var_00 = common_scripts\utility::func_F6F(var_00, var_03);
    }

    if(var_01 <= 0.1) {
      var_01 = 0.1;
    }

    wait(var_01);
    var_01 = var_01 - 0.1;
  }
}

vo_beach_turrets_nags_check() {
  level endon("flag Explore the Beach Survive the Beach");
  wait(15);
  var_00 = 0;
  var_01 = 0;
  if(level.players.size > 1) {
    level.turrets_to_check = 2;
  } else {
    level.turrets_to_check = 1;
  }

  for(var_02 = 0; var_02 < level.turrets_to_check; var_02++) {
    if(level.players[var_02] isusingturret()) {
      level.players[var_02].using_turret = 1;
      continue;
    }

    level.players[var_02].using_turret = 0;
  }

  for(var_02 = 0; var_02 < level.turrets_to_check; var_02++) {
    if(level.players[var_02].using_turret == 0) {
      var_01 = 0;
      continue;
    }

    var_01 = 1;
  }

  if(var_01 == 0) {
    if(!common_scripts\utility::func_3C77("flag Explore the Beach Survive the Beach")) {
      lib_0367::snd_zmb_plr_dlg_play_line_on_each_player("mg42nag__both");
    }
  }
}

try_spawn_intro_assault_zombie(param_00, param_01, param_02) {
  var_03 = common_scripts\utility::func_46B7("zombie_spawner", "script_noteworthy");
  var_04 = lib_0547::func_408F();
  if(var_04.size >= lib_056D::func_4577()) {
    return;
  }

  var_05 = common_scripts\utility::func_7A33(level.intro_bunker_struct.rush_spawners);
  if(isDefined(param_01)) {
    var_05 = param_01;
  }

  var_06 = lib_054D::func_90BA("zombie_generic", var_05, "beach_rush_intro", 0, 1, 1);
  var_06 lib_0547::func_84CB();
  var_06 endon("death");
  if(isDefined(param_00)) {
    var_06.health = int(var_06.health * param_00);
  }

  if(isDefined(param_02) && param_02 >= 5) {
    if(level.players.size > 1) {
      var_07 = randomint(2);
    } else {
      var_07 = 1;
    }

    if(var_07 == 0) {
      var_06.var_6941 = 1;
    }
  }

  wait 0.05;
  var_08 = common_scripts\utility::func_44F5("water_wake_stationary");
  wait 0.05;
  playFXOnTag(var_08, var_06, "tag_origin");
}

turret_outline_logic() {
  level.turrets_used = 0;
  while(!common_scripts\utility::func_3C77("flag Explore the Beach Survive the Beach")) {
    foreach(var_01 in level.players) {
      if(!isalive(var_01)) {
        continue;
      }

      if(!var_01 isusingturret()) {
        continue;
      }

      var_02 = var_01 method_85E3();
      if(!isDefined(var_02)) {
        continue;
      }

      level.turrets_used = 1;
    }

    wait 0.05;
  }
}

quest_step_intro_on_complete() {
  level.var_1F4F["normal"] = ::droppickups;
  if(!maps / mp / zquests / casual / island_ee_util::has_anyone_used_preplaced_turrets()) {
    maps / mp / gametypes / zombies::func_47A8("DLC1_ZM_GOTTHIS");
  }

  level thread common_scripts\_exploder::func_88E(222);
  foreach(var_01 in level.players) {
    lib_0547::func_ABCA(var_01, 0);
    lib_0547::func_ABCA(var_01, 3);
  }

  level.var_2F6C = 0;
  if(common_scripts\utility::func_562E(level.var_ABDA)) {
    level notify("zombies_manual_start");
  }
}

quest_step_reach_pen() {
  common_scripts\utility::func_3CA2("right_climb_to_sub_pens_1", "vista_beach_to_sub_pens_1");
  lib_0557::func_782D("Explore the Beach", "Reach Sub Pens");
}

wait_for_player() {
  while(isDefined(self)) {
    foreach(var_01 in level.players) {
      if(distance(var_01.origin, self.origin) < 64) {
        var_01 maps / mp / gametypes / zombies::func_4798(250, 1);
        self delete();
        break;
      }
    }

    wait 0.05;
  }
}

zombieskilledinintro(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(!lib_0547::func_5565(self.var_A4B, "zombie_generic")) {
    return;
  }

  if(!isDefined(param_01)) {
    return;
  }

  if(!isPlayer(param_01)) {
    return;
  }

  var_09 = lib_0547::func_408F();
  if(var_09.size > 1) {
    return;
  }

  var_0A = getEnt("vol_player_beach_area", "targetname");
  var_0B = common_scripts\utility::func_46B7("beach_attack_pickup_location", "targetname");
  var_0C = common_scripts\utility::func_7A33(var_0B);
  var_0D = var_09[0];
  if(isDefined(var_0D) && isDefined(var_0A) && var_0D istouching(var_0A)) {
    maps / mp / gametypes / zombies::func_281C("ammo", var_0D.origin, "random", 1, 0);
    return;
  }

  maps / mp / gametypes / zombies::func_281C("ammo", var_0C.origin, "random", 1, 0);
}

func_9D28() {
  return 3;
}

func_9D2A() {
  return 1;
}

dontdroppickups(param_00) {
  return 0;
}

droppickups(param_00) {
  return 1;
}

playerinwaterthink() {
  var_00 = self;
  var_00 endon("disconnect");
  var_01 = getEntArray("vol_player_in_water", "targetname");
  var_00 common_scripts\utility::func_3799("flag_player_in_water");
  wait 0.05;
  for(;;) {
    var_02 = var_00 isplayerinwatercheck(var_01);
    if(var_02 != 1) {
      if(var_00 common_scripts\utility::func_3794("flag_player_in_water")) {
        var_00 common_scripts\utility::func_3796("flag_player_in_water");
        if(common_scripts\utility::func_562E(var_00.oncartride)) {
          continue;
        }

        if(var_00 getcurrentprimaryweapon() == "stone_baby_zm") {
          continue;
        }

        var_00 method_8114(1);
      }

      wait 0.05;
      continue;
    }

    if(!var_00 common_scripts\utility::func_3794("flag_player_in_water")) {
      var_00 common_scripts\utility::func_379A("flag_player_in_water");
      if(common_scripts\utility::func_562E(var_00.oncartride)) {
        continue;
      }

      if(var_00 getcurrentprimaryweapon() == "stone_baby_zm") {
        continue;
      }

      var_00 method_8114(0);
    }

    wait 0.05;
  }
}

isplayerinwatercheck(param_00) {
  foreach(var_02 in param_00) {
    if(self istouching(var_02)) {
      return 1;
    }
  }

  return 0;
}

______sub_pens_and_corpse_gate__________() {}

quest_init_corpse_gate() {
  thread setup_subpen_switches();
  thread cgate_ranger_init();
  thread cgate_init();
  thread cgate_blocker_init();
  thread cgate_found_listener();
}

func_784F() {
  common_scripts\utility::func_3C9F("power_sz2");
  lib_0557::func_782D("explore_the_island", "Pen Power");
}

quest_step_complete_enable_power() {
  if(!common_scripts\utility::func_3C77("power_sz2")) {
    common_scripts\utility::func_3C8F("power_sz2");
  }
}

quest_step_wait_for_corpsegate_found() {
  common_scripts\utility::func_3C9F("flag_corpse_door_found");
  lib_0557::func_782D("explore_the_island", "Explore Pen");
}

quest_step_complete_wait_for_corpsegate_found() {
  if(!common_scripts\utility::func_3C77("flag_corpse_door_found")) {
    common_scripts\utility::func_3C8F("flag_corpse_door_found");
  }
}

quest_step_wait_for_razor_gun_assembly() {
  common_scripts\utility::func_3CA2(lib_0557::func_7838("Aquire Wonder Weapon", "Ranged Razor Gun Built"), "flag_ranger_head_taken");
  lib_0557::func_782D("CORPSE_GATE", "Find way to open Gate");
}

quest_step_decap_ranger() {
  var_00 = undefined;
  var_01 = undefined;
  var_02 = getEnt("corpse_gate_sacrifice", "targetname");
  if(isDefined(var_02)) {
    var_01 = getEnt(var_02.target, "targetname");
    if(isDefined(var_01) && isDefined(var_01.target)) {
      var_00 = getEnt(var_01.target, "targetname");
    }

    thread head_corpse_vo();
  }

  common_scripts\utility::func_3C9F("flag_ranger_head_taken");
  lib_0557::func_782D("CORPSE_GATE", "Decapitate Ranger");
}

head_corpse_vo() {
  common_scripts\utility::func_3C9F("start_to_right_climb");
  var_00 = getEnt("corpse_gate_sacrifice", "targetname");
  if(!isDefined(var_00)) {
    return;
  }

  var_00 endon("death");
  while(!common_scripts\utility::func_3C77("flag_ranger_head_taken")) {
    foreach(var_02 in level.players) {
      if(distance(var_02.origin, var_00.origin) > 250 || common_scripts\utility::func_562E(var_02.saw_head)) {
        continue;
      }

      var_02 lib_0367::func_8E3D("rippedapart_both");
      var_02.saw_head = 1;
      var_03 = var_02 method_82D5();
      if(issubstr(var_03, "razergun_zm") == 0) {
        var_02 lib_0367::func_8E3D("planecrashlook");
      }
    }

    wait(1);
  }
}

head_corpse_razer_gun_vo() {
  common_scripts\utility::func_3C9F("razergun_3_placed");
  var_00 = getEnt("corpse_gate_sacrifice", "targetname");
  foreach(var_02 in level.players) {
    var_02.got_head = 0;
  }

  while(!common_scripts\utility::func_3C77("flag_ranger_head_taken")) {
    foreach(var_02 in level.players) {
      if(distance(var_02.origin, var_00.origin) < 250) {
        if(var_02.got_head == 0) {
          var_05 = var_02 method_82D5();
          if(issubstr(var_05, "razergun_zm") == 0) {
            var_02 lib_0367::func_8E3D("officercluetwo");
            var_02.got_head = 1;
          }
        }
      }
    }

    wait(1);
  }
}

quest_step_complete_decap_ranger() {
  if(!common_scripts\utility::func_3C77("flag_ranger_head_taken")) {
    common_scripts\utility::func_3C8F("flag_ranger_head_taken");
  }
}

quest_step_wait_for_first_corpsegate_opened() {
  common_scripts\utility::func_3C9F("flag_ranger_head_placed");
  var_00 = getEnt("corpse_gate_wall", "targetname");
  foreach(var_02 in level.players) {
    if(distance(var_02.origin, var_00.origin) < 500) {
      var_02 thread lib_0367::func_8E3D("corpsegateheadplace");
    }
  }

  lib_0557::func_7822("CORPSE_GATE", lib_0557::removed_quest_hint());
  common_scripts\utility::func_3C9F("sub_pens_corpse_gate");
  lib_0557::func_7822("CORPSE_GATE", lib_0557::removed_quest_hint());
  level.zmb_locked_spawn_zones = ["sub_pens_1_zone"];
  maps / mp / zquests / casual / island_ee_util::clear_all_zombies();
  level thread monitor_player_attendance();
  run_freezer_combat();
  common_scripts\utility::func_3C9F("flag_subpen_traps_completed");
  maps / mp / zquests / casual / island_ee_util::clear_all_zombies();
  level.zmb_locked_spawn_zones = undefined;
  lib_0557::func_7822("CORPSE_GATE", lib_0557::removed_quest_hint());
  common_scripts\utility::func_3C9F("flag_open_corpse_door");
  lib_0557::func_782D("CORPSE_GATE", "Open Corpse Gate");
}

quest_step_complete_corpsegate_opened() {
  foreach(var_01 in level.players) {
    var_01 maps\mp\zombies\_zombies_rank::func_AC23("corpsegate");
    var_01 lib_0378::func_8D74("objective_complete", "corpsegate");
  }

  if(!common_scripts\utility::func_3C77("flag_ranger_head_placed")) {
    common_scripts\utility::func_3C8F("flag_ranger_head_placed");
  }

  if(!common_scripts\utility::func_3C77("sub_pens_corpse_gate")) {
    common_scripts\utility::func_3C8F("sub_pens_corpse_gate");
  }

  if(!common_scripts\utility::func_3C77("flag_subpen_traps_completed")) {
    common_scripts\utility::func_3C8F("flag_subpen_traps_completed");
  }

  if(!common_scripts\utility::func_3C77("flag_ranger_head_placed")) {
    common_scripts\utility::func_3C8F("flag_ranger_head_placed");
  }

  if(!common_scripts\utility::func_3C77("flag_ranger_head_taken")) {
    common_scripts\utility::func_3C8F("flag_ranger_head_taken");
  }

  if(!common_scripts\utility::func_3C77("flag_corpse_door_found")) {
    common_scripts\utility::func_3C8F("flag_corpse_door_found");
  }

  if(!common_scripts\utility::func_3C77("flag_open_corpse_door")) {
    common_scripts\utility::func_3C8F("flag_open_corpse_door");
  }

  if(!common_scripts\utility::func_3C77("sub_pens_corpse_gate")) {
    common_scripts\utility::func_3C8F("sub_pens_corpse_gate");
  }
}

cgate_ranger_init() {
  var_00 = getEnt("corpse_gate_sacrifice", "targetname");
  var_00.var_B9 = getEnt(var_00.target, "targetname");
  var_00.var_18A8 = getEnt(var_00.var_B9.target, "targetname");
  var_00.head_trig = getEnt(var_00.var_18A8.target, "targetname");
  var_00.pecking_crows = spawnlinkedfx(level.var_611["zmb_isl_corpse_crows_peck"], var_00.var_18A8, "TAG_ORIGIN");
  triggerfx(var_00.pecking_crows, -1);
  var_00 thread cgate_ranger_think();
  level thread maps\mp\_utility::func_6F74(::scare_crows_when_looked_at, var_00);
  wait 0.05;
}

scare_crows_when_looked_at(param_00) {
  var_01 = self;
  var_01 endon("disconnect");
  wait(1);
  level endon("crows_gone");
  for(;;) {
    if(!isDefined(param_00) || !isDefined(param_00.var_B9)) {
      return;
    }

    var_02 = param_00.var_B9.origin;
    var_03 = self getEye();
    var_04 = vectorNormalize(var_02 - var_03);
    var_05 = vectorNormalize(anglesToForward(self geteyeangles()));
    var_06 = vectordot(var_04, var_05);
    wait 0.05;
    var_07 = acos(clamp(var_06, -1, 1));
    if(var_07 < 25 && distance(var_02, var_03) < 420) {
      param_00 thread scare_off_crows();
      level notify("crows_gone");
    }
  }
}

cgate_ranger_think() {
  self setHintString(&"ZOMBIES_EMPTY_STRING");
  self.head_trig waittill("razer_blade_touched", var_00);
  level childthread common_scripts\_exploder::func_88E(219);
  self.head_trig delete();
  var_01 = common_scripts\utility::func_46B5("head_landing_scripted_node", "targetname");
  self.var_B9 method_8495("s2_zom_island_corpse_head", var_01.origin, common_scripts\utility::func_98E7(isDefined(var_01.angles), var_01.angles, (0, 0, 0)), "head_fall_anim");
  self.var_B9 lib_0378::func_8D74("nazi_head_roll");
  wait(getanimlength(%s2_zom_island_corpse_head));
  self setHintString(&"ZOMBIE_ISLAND_PICK_UP_HEAD");
  self waittill("trigger", var_02);
  self.var_B9 delete();
  self delete();
  common_scripts\utility::func_3C8F("flag_ranger_head_taken");
}

scare_off_crows() {
  if(isDefined(self.pecking_crows)) {
    self.pecking_crows delete();
  }

  playFXOnTag(level.var_611["zmb_isl_corpse_crows_scatter"], self.var_18A8, "TAG_ORIGIN");
  lib_0378::func_8D74("aud_scare_off_crows");
}

sub_pen_blocker_listener() {
  level thread maps\mp\_utility::func_6F74(::push_off_the_fence, self.var_241F);
  for(;;) {
    var_00 = level common_scripts\utility::waittill_any_return("sub_pen_blockers_open", "sub_pen_blockers_close");
    var_01 = self.var_3255 getscriptablepartstate("gate");
    if(var_00 == "sub_pen_blockers_open") {
      if(var_01 == "opened") {
        continue;
      }

      common_scripts\utility::func_3C8F("dont_spawn_fireman");
      common_scripts\utility::func_3C8F("fireman_defeated");
      var_02 = lib_0547::func_4090("zombie_fireman");
      foreach(var_04 in var_02) {
        var_04.nomaxammo = 1;
        var_04 suicide();
      }

      self.var_241F.var_565F = 0;
      self.var_241F connectpaths();
      self.var_241F notsolid();
      self.var_3255 setscriptablepartstate("gate", "opening");
      wait(0.7);
      self.var_3255 setscriptablepartstate("gate", "opened");
      continue;
    }

    if(var_00 == "sub_pen_blockers_close") {
      if(var_01 == "closed") {
        continue;
      }

      self.var_241F.var_565F = 1;
      self.var_241F method_805F();
      self.var_241F solid();
      self.var_3255 setscriptablepartstate("gate", "closing");
      wait(0.7);
      self.var_3255 setscriptablepartstate("gate", "closed");
    }
  }
}

push_off_the_fence(param_00) {
  self endon("disconnect");
  var_01 = common_scripts\utility::func_46B5("zmb_addon_fence_teleport_line", "targetname");
  var_02 = common_scripts\utility::func_46B5(var_01.target, "targetname");
  var_03 = [var_01.origin, var_02.origin];
  for(;;) {
    wait 0.05;
    if(!common_scripts\utility::func_562E(param_00.var_565F)) {
      continue;
    }

    if(distance(self.origin, param_00.origin) > 256) {
      continue;
    }

    if(lib_0547::func_5565(self method_8551(), param_00)) {
      var_04 = pointonsegmentnearesttopoint(var_03[0], var_03[1], self.origin);
      self setOrigin((var_04[0], var_04[1], self.origin[2]), 0);
    }
  }
}

cgate_found_listener() {
  var_00 = 0;
  var_01 = common_scripts\utility::func_46B7("corpse_gate", "targetname");
  var_02 = undefined;
  lib_0547::func_A78B();
  foreach(var_04 in var_01) {
    if(var_04.var_819A == "sub_pens_corpse_gate") {
      var_02 = var_04;
    }
  }

  while(!var_00) {
    foreach(var_07 in level.players) {
      if(distance(var_07.origin, var_02.origin) < 128) {
        var_00 = 1;
      }
    }

    wait(0.125);
  }

  common_scripts\utility::func_3C8F("flag_corpse_door_found");
}

run_freezer_combat() {
  var_00 = common_scripts\utility::func_46B5("corpse_freezer_combat_sequence", "targetname");
  var_01 = common_scripts\utility::func_44BE(var_00.target, "targetname");
  thread start_combat();
}

cgate_blocker_init() {
  var_00 = common_scripts\utility::func_46B7("subpen_battle_blocker", "targetname");
  foreach(var_02 in var_00) {
    var_03 = common_scripts\utility::func_44BE(var_02.target, "targetname");
    var_04 = function_021F(var_02.target, "targetname");
    foreach(var_06 in var_03) {
      if(!isDefined(var_06.script_noteworthy)) {
        continue;
      }

      switch (var_06.script_noteworthy) {
        case "blocker_clip":
          var_02.var_241F = var_06;
          var_02.var_241F common_scripts\utility::func_2CBE(3, ::connectpaths);
          var_02.var_241F notsolid();
          break;
      }
    }

    foreach(var_06 in var_04) {
      var_09 = var_06 method_85CE();
      if(var_09 == "animated_zmi_sub_bay_spike") {
        var_02.var_3255 = var_06;
        var_02.var_3255 setscriptablepartstate("gate", "opened");
      }
    }

    var_02 thread sub_pen_blocker_listener();
  }
}

run_corpse_door() {
  thread cgate_head_place_think();
  thread cgate_set_state("dead_idle");
  self.corpse_trig thread cgate_wait_for_deposit();
  common_scripts\utility::func_3C9F("flag_ranger_head_placed");
  thread wait_for_objective_complete();
  common_scripts\utility::func_3C9F("sub_pens_corpse_gate");
  level thread cgate_start_collar_fx(self.var_3255);
  cgate_set_state("intro");
  thread cgate_set_state("active_idle");
  lib_0378::func_8D74("corpse_gate_talk", "alarm");
  common_scripts\utility::func_3C9F("flag_subpen_traps_completed");
  maps / mp / mp_zombie_nest_ee_wave_manipulation::func_8608();
  self.corpse_trig common_scripts\utility::func_9DA3();
  self.corpse_trig setHintString(&"ZOMBIE_ISLAND_CORPSE_GATE_OPEN");
  lib_0378::func_8D74("corpse_gate_talk", "beg");
  self.corpse_trig thread wait_for_activate_after_fire_panel_battle();
  common_scripts\utility::func_3C9F("flag_open_corpse_door");
  self.corpse_trig delete();
  level thread maps / mp / gametypes / zombies::orders_and_contracts_report_event("mp_zombie_island_corpsegate_open");
  cgate_set_state("outro");
  setDvar("4712", 2);
  thread freezer_lights();
  setDvar("4712", 1);
  if(isDefined(self.var_819A)) {
    common_scripts\utility::func_3C8F(self.var_819A);
  }
}

spawn_corpse_gate_fireman() {
  wait(2.5);
  level thread corpse_gate_open_vo();
  var_00 = common_scripts\utility::func_46B5("zmb_fireman_spawnpoint_corpsegate", "targetname");
  if(!common_scripts\utility::func_3C77("dont_spawn_fireman")) {
    var_01 = lib_0564::func_3C11(0, var_00, 0);
    if(isDefined(var_01)) {
      var_01 lib_0547::func_84CB();
      var_01 lib_0378::func_8D74("aud_isla_fireman_intro");
    }

    lib_0547::func_7BA9(::zombie_firemen_max_ammo);
  }

  for(;;) {
    var_02 = lib_0547::func_4090("zombie_fireman");
    if(var_02.size <= 0) {
      level notify("sub_pen_blockers_open");
      maps / mp / mp_zombie_island_cart::make_a_transport_request(undefined, undefined, "unlock");
      break;
    }

    wait(1);
  }

  common_scripts\utility::func_3C8F("fireman_defeated");
  thread planes_enroute_vo();
}

zombie_firemen_max_ammo(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(lib_0547::func_5565(self.var_A4B, "zombie_fireman")) {
    if(!common_scripts\utility::func_562E(self.nomaxammo)) {
      maps / mp / gametypes / zombies::func_281C("ammo", self.origin, "random", 0, 0);
    }

    lib_0547::func_2D8C(::zombie_firemen_max_ammo);
  }
}

freezer_lights() {
  wait(9);
  var_00 = function_021F("on1", "targetname");
  foreach(var_02 in var_00) {
    wait(6);
    var_02 setscriptablepartstate("lightpart", "on");
  }

  wait(4);
  var_04 = function_021F("on2", "targetname");
  foreach(var_06 in var_04) {
    wait(7);
    var_06 setscriptablepartstate("lightpart", "on");
  }

  wait(4);
  var_08 = function_021F("on3", "targetname");
  foreach(var_0A in var_08) {
    wait(6);
    var_0A setscriptablepartstate("lightpart", "on");
  }
}

cgate_head_place_think() {
  level.corpse_gate.var_B9 hide();
  level.corpse_gate.guts hide();
  common_scripts\utility::func_3C9F("flag_ranger_head_placed");
  level.corpse_gate.var_B9 show();
}

cgate_set_state(param_00) {
  var_01 = level.corpse_gate;
  switch (param_00) {
    case "dead_idle":
      var_01.var_3255 method_8495("s2_zom_island_corpse_gate_dead_idle", var_01.anim_origin.origin, var_01.anim_origin.angles);
      var_01.var_B9 method_8495("s2_zom_island_corpse_gate_dead_idle_head", var_01.anim_origin.origin, var_01.anim_origin.angles);
      var_05 = getanimlength(%s2_zom_island_corpse_gate_dead_idle);
      wait(var_05);
      break;

    case "intro":
      level.corpse_gate.guts show();
      var_01 lib_0378::func_8D74("corpse_gate_talk", "awake");
      var_01.var_3255 method_8495("s2_zom_island_corpse_gate_intro", var_01.anim_origin.origin, var_01.anim_origin.angles);
      var_01.guts method_8495("s2_zom_island_corpse_gate_intro_guts", var_01.anim_origin.origin, var_01.anim_origin.angles);
      var_01.var_B9 method_8495("s2_zom_island_corpse_gate_intro_head", var_01.anim_origin.origin, var_01.anim_origin.angles);
      var_05 = getanimlength(%s2_zom_island_corpse_gate_intro);
      wait(var_05);
      break;

    case "active_idle":
      var_01.var_3255 method_8495("s2_zom_island_corpse_gate_idle", var_01.anim_origin.origin, var_01.anim_origin.angles);
      var_01.guts method_8495("s2_zom_island_corpse_gate_idle_guts", var_01.anim_origin.origin, var_01.anim_origin.angles);
      var_01.var_B9 method_8495("s2_zom_island_corpse_gate_idle_head", var_01.anim_origin.origin, var_01.anim_origin.angles);
      var_05 = getanimlength(%s2_zom_island_corpse_gate_idle);
      wait(var_05);
      break;

    case "outro":
      level thread corpse_gate_open_rumble(var_01.var_3255);
      level thread common_scripts\_exploder::func_88E(211);
      var_01.var_3255 lib_0378::func_8D74("aud_corpse_gate_open");
      level thread common_scripts\_exploder::func_88E(230);
      var_01 lib_0378::func_8D74("corpse_gate_talk", "beg");
      var_01.var_3255 method_8495("s2_zom_island_corpse_gate_outro", var_01.anim_origin.origin, var_01.anim_origin.angles);
      var_01.guts method_8495("s2_zom_island_corpse_gate_outro_guts", var_01.anim_origin.origin, var_01.anim_origin.angles);
      var_01.var_B9 method_8495("s2_zom_island_corpse_gate_outro_head", var_01.anim_origin.origin, var_01.anim_origin.angles);
      var_05 = getanimlength(%s2_zom_island_corpse_gate_outro);
      var_01.var_3255 method_80B1();
      wait(15.16667);
      foreach(var_03 in var_01.clip_blockers) {
        var_03 connectpaths();
        var_03 delete();
      }

      level thread spawn_corpse_gate_fireman();
      wait(5.866667);
      var_01.is_opened = 1;
      break;

    case "tug":
      var_01.var_3255 method_8495("s2_zom_island_corpse_gate_tug", var_01.anim_origin.origin, var_01.anim_origin.angles);
      var_01.guts method_8495("s2_zom_island_corpse_gate_tug_guts", var_01.anim_origin.origin, var_01.anim_origin.angles);
      var_01.var_B9 method_8495("s2_zom_island_corpse_gate_tug_head", var_01.anim_origin.origin, var_01.anim_origin.angles);
      var_05 = getanimlength(%s2_zom_island_corpse_gate_tug);
      wait(var_05);
      break;
  }
}

corpse_gate_open_rumble(param_00) {
  wait(3.5);
  foreach(var_02 in level.players) {
    if(distance(var_02.origin, param_00.origin) < 500) {
      function_01BC("tank_rumble", var_02.origin);
    }
  }

  wait(5);
  function_01BD();
}

vo_corpse_gate_touch() {
  level endon("sub_pens_corpse_gate");
  common_scripts\utility::func_3C9F("power_sz2");
  for(;;) {
    foreach(var_01 in level.players) {
      if(!isDefined(self.corpse_trig)) {
        break;
      }

      if(var_01 istouching(self.corpse_trig)) {
        if(!common_scripts\utility::func_562E(var_01.dlg_flag_see_cgate)) {
          var_01 lib_0367::func_8E3D("touchcorpsegate");
          var_01 lib_0367::func_8E3D("emptycorpsegate");
          var_01.dlg_flag_see_cgate = 1;
        }
      }
    }

    wait 0.05;
  }
}

vo_beach_blood() {
  common_scripts\utility::func_3C9F("start_to_right_climb");
  lib_0367::snd_zmb_plr_dlg_play_line_on_each_player("followpath");
  common_scripts\utility::func_3C9F("right_climb_to_sub_pens_1");
  lib_0367::snd_zmb_plr_dlg_play_line_on_each_player("nagsubpen");
}

wait_for_objective_complete() {
  self.corpse_trig common_scripts\utility::func_9D9F();
  if(!common_scripts\utility::func_3C77("sub_pens_corpse_gate")) {
    var_00 = 15;
    switch (level.players.size) {
      case 1:
        var_00 = 10;
        break;

      case 2:
        var_00 = 15;
        break;

      case 3:
        var_00 = 15;
        break;

      case 4:
        var_00 = 15;
        break;
    }

    var_01 = spawn("script_model", self.var_B9.origin);
    var_01 setModel("tag_origin");
    var_01.issoulcollecting = 1;
    var_01 thread cgate_toggle_soul_pos();
    var_01 thread cgate_tug();
    var_01 maps / mp / mp_zombies_soul_collection::func_170B(var_00, 400, undefined, "corpse_door_soul_charged", undefined, "tag_origin");
    level thread maps / mp / gametypes / zombies::orders_and_contracts_report_event("geistcraft_device_powered");
    common_scripts\utility::func_3C8F("sub_pens_corpse_gate");
    var_01.issoulcollecting = 0;
  }
}

cgate_tug() {
  while(self.issoulcollecting == 1) {
    level waittill("corpse_door_soul_charged");
    cgate_set_state("tug");
  }
}

cgate_toggle_soul_pos() {
  var_00 = common_scripts\utility::func_46B5("corspe_gate_lightning_point", "targetname");
  var_01 = common_scripts\utility::func_46B5(var_00.target, "targetname");
  while(self.issoulcollecting) {
    self.origin = var_00.origin;
    wait(1);
    self.origin = var_01.origin;
    wait(1);
  }
}

cgate_start_collar_fx(param_00) {
  wait(0.2);
  var_01 = spawnlinkedfx(level.var_611["zmb_dlc1_corpse_gate_gk_collar_1"], param_00, "collar");
  triggerfx(var_01);
}

cgate_wait_for_deposit() {
  common_scripts\utility::func_3C9F("flag_ranger_head_taken");
  self setHintString(&"ZOMBIE_ISLAND_PLACE_RANGER_HEAD");
  for(;;) {
    self waittill("trigger", var_00);
    if(common_scripts\utility::func_3C77("flag_ranger_head_taken")) {
      var_00 lib_0367::func_8E3D("corpseheadplace");
      break;
    }
  }

  common_scripts\utility::func_3C8F("flag_ranger_head_placed");
}

wait_for_activate_after_fire_panel_battle() {
  for(;;) {
    self waittill("trigger", var_00);
    break;
  }

  common_scripts\utility::func_3C8F("flag_open_corpse_door");
}

cgate_init() {
  var_00 = common_scripts\utility::func_46B5("corpse_gate", "targetname");
  if(isDefined(var_00)) {
    if(isDefined(var_00.var_819A)) {
      common_scripts\utility::func_3C87(var_00.var_819A);
    }

    var_01 = common_scripts\utility::func_44BE(var_00.target, "targetname");
    var_02 = [];
    var_03 = undefined;
    foreach(var_05 in var_01) {
      switch (var_05.script_noteworthy) {
        case "corpse_gate_clip_blocker":
          var_02 = common_scripts\utility::func_F6F(var_02, var_05);
          break;

        case "zombies_corpse_trigger":
          var_03 = var_05;
          break;
      }
    }

    var_00.clip_blockers = var_02;
    var_00.corpse_trig = var_03;
    var_00.var_3255 = getEnt("corpse_gate_wall", "targetname");
    var_00.guts = getEnt("corpse_gate_guts_model", "script_noteworthy");
    var_00.var_B9 = getEnt("corpse_gate_head_model", "script_noteworthy");
    var_00.anim_origin = common_scripts\utility::func_46B5("anim_origin_corpse_gate", "targetname");
    level.corpse_gate = var_00;
    level.corpse_gate thread run_corpse_door();
    level.corpse_gate thread vo_corpse_gate_touch();
  }
}

vo_inside_subpens() {
  common_scripts\utility::func_3C9F("flag_vo_inside_subpen");
  foreach(var_01 in level.players) {
    var_01 thread lib_0367::func_8E3C("insidesubpen");
  }

  common_scripts\utility::func_3C9F("flag_vo_subcrates");
  foreach(var_01 in level.players) {
    var_01 thread lib_0367::func_8E3C("subcrates_both");
  }
}

start_combat() {
  level notify("sub_pen_blockers_close");
  maps / mp / mp_zombie_island_cart::make_a_transport_request(undefined, undefined, "lockdown");
  wait(5);
  maps / mp / mp_zombie_island_straub_pa_events::pa_system_dialogue_all_players("zmb_isla_stra_achtungithascometomyatten", 0);
  maps / mp / mp_zombie_island_straub_pa_events::pa_system_dialogue_all_players("zmb_isla_stra_americansasusualyouhavear", 0);
  maps / mp / mp_zombie_island_straub_pa_events::pa_system_dialogue_all_players("zmb_isla_stra_wearealmostfinishedhereih");
  level.maxed_zombies_sprint = 1;
  maps / mp / mp_zombie_nest_ee_wave_manipulation::func_8606();
  level thread initial_rush();
  thread fire_panels_logic();
  maps\mp\_utility::func_2CED(7, ::common_scripts\utility::func_3C8F, "flag_freezer_combat_started");
  lib_0367::snd_zmb_plr_dlg_play_line_on_each_player("lockedingottafightthemoff");
  common_scripts\utility::func_3C9F("flag_subpen_traps_completed");
  level notify("stop_stoves");
  maps / mp / mp_zombie_nest_ee_wave_manipulation::func_8607();
  level.maxed_zombies_sprint = 0;
}

is_zone_a_locked_spawn_zone(param_00) {
  if(!isDefined(level.zmb_locked_spawn_zones)) {
    return 0;
  }

  var_01 = common_scripts\utility::func_F79(level.zmb_locked_spawn_zones, param_00);
  return var_01;
}

monitor_player_attendance() {
  var_00 = getEnt("sub_event_volume", "targetname");
  level.zmb_lockdown_event_active = 1;
  while(!common_scripts\utility::func_3C77("fireman_defeated")) {
    var_01 = 0;
    var_02 = 0;
    foreach(var_04 in level.players) {
      if(var_04 istouching(var_00)) {
        var_04.participatinginevent = 1;
        var_01++;
        continue;
      }

      var_04 notify("not_participating_in_subpen_event");
      var_04.participatinginevent = 0;
    }

    level.plr_event_attendance = var_01;
    var_06 = lib_0547::func_408F();
    foreach(var_08 in var_06) {
      if(isDefined(var_08.var_9024)) {
        var_09 = var_08.var_9024;
      } else {
        var_09 = "";
      }

      if(var_08 istouching(var_00) || is_zone_a_locked_spawn_zone(var_09)) {
        var_08.participatinginevent = 1;
        var_02++;
        continue;
      }

      var_08.participatinginevent = 0;
      var_08 lib_056D::func_5A86();
    }

    level.zmb_event_attendance = var_02;
    if(level.plr_event_attendance == 0) {
      var_01 = 0;
      var_02 = 0;
      level notify("sub_pen_blockers_open");
      break;
    }

    wait 0.05;
  }

  level.zmb_lockdown_event_active = 0;
  level.zmb_locked_spawn_zones = undefined;
  level.plr_event_attendance = undefined;
  level.zmb_event_attendance = undefined;
}

initial_rush() {
  var_00 = common_scripts\utility::func_46B5("corpse_freezer_combat_sequence", "targetname");
  var_01 = common_scripts\utility::func_46B7("sub_pens_event_spawners", "targetname");
  foreach(var_03 in var_01) {
    lib_054D::func_90BA("zombie_generic", var_03, "beach_rush_intro", 0, 1, 1);
  }

  earthquake(0.25, 7.5, var_00.origin, 1000);
  var_05 = lib_0380::func_6842("zmb_well_group_scream", undefined, var_00.origin);
  var_06 = lib_0380::func_6842("zmb_tower_alarm", undefined, var_00.origin);
  wait(17.5);
  lib_0380::func_6850(var_06, 0.25);
  lib_0380::func_6850(var_05, 0.25);
}

fire_panels_logic() {
  var_00 = [];
  var_01 = getEntArray("stove_panel", "targetname");
  var_02 = [];
  var_02 = common_scripts\utility::func_F6F(var_02, 0);
  for(var_03 = 1; var_03 < 35; var_03++) {
    var_04 = getEnt("fire_panel_" + var_03, "targetname");
    var_00 = common_scripts\utility::func_F6F(var_00, var_04);
  }

  foreach(var_04 in var_00) {
    var_06 = common_scripts\utility::func_4461(var_04.origin, var_01);
    var_02 = common_scripts\utility::func_F6F(var_02, var_06);
  }

  foreach(var_09 in level.players) {
    var_09.vo_fire_panel_warning_received = 0;
  }

  level.burn_tags = [];
  level notify("flag_subpen_traps_started");
  fire_panels_intro(var_02);
  thread fire_panels_valve_panels_logic(var_02);
  lib_0378::func_8D74("start_corpse_gate_alarm");
  for(;;) {
    wait(5);
    foreach(var_09 in level.players) {
      var_09.vo_fire_panel_warning_received = 0;
    }

    var_0D = randomintrange(0, 6);
    switch (var_0D) {
      case 0:
        fire_pattern_right_wave(var_02);
        break;

      case 1:
        fire_pattern_right_wave_reverse(var_02);
        break;

      case 2:
        fire_pattern_left_wave(var_02);
        break;

      case 3:
        fire_pattern_left_wave_reverse(var_02);
        break;

      case 4:
        fire_pattern_mid_upper(var_02);
        break;

      case 5:
        fire_pattern_mid_lower(var_02);
        break;

      default:
        break;
    }

    if(common_scripts\utility::func_3C77("flag_subpen_traps_completed")) {
      lib_0378::func_8D74("stop_corpse_gate_alarm");
      break;
    }
  }
}

fire_panels_valve_panels_logic(param_00) {
  level endon("flag_subpen_traps_completed");
  thread fire_panels_always_burn(param_00[2]);
  thread fire_panels_always_burn(param_00[14]);
  thread fire_panels_always_burn(param_00[27]);
  var_01 = [];
  var_01 = common_scripts\utility::func_F6F(var_01, param_00[2]);
  var_01 = common_scripts\utility::func_F6F(var_01, param_00[14]);
  var_01 = common_scripts\utility::func_F6F(var_01, param_00[27]);
  var_02 = undefined;
  var_03 = undefined;
  var_04 = undefined;
  var_05 = undefined;
  foreach(var_07 in level.var_A2A0) {
    if(lib_0547::func_5565(var_07.targetname, "fuel_valve")) {
      if(isDefined(var_07.var_819A) && var_07.var_819A == "fuel_valve_1") {
        var_02 = common_scripts\utility::func_4461(var_07.origin, var_01);
      }

      if(isDefined(var_07.var_819A) && var_07.var_819A == "fuel_valve_2") {
        var_03 = common_scripts\utility::func_4461(var_07.origin, var_01);
      }

      if(isDefined(var_07.var_819A) && var_07.var_819A == "fuel_valve_3") {
        var_04 = common_scripts\utility::func_4461(var_07.origin, var_01);
      }
    }
  }

  wait(30);
  var_09 = 0;
  var_0A = 0;
  var_0B = 0;
  for(;;) {
    if(var_09 == 0) {
      if(common_scripts\utility::func_3C77("fuel_valve_1")) {
        var_01 = common_scripts\utility::func_F93(var_01, var_02);
        var_09 = 1;
      }
    }

    if(var_0A == 0) {
      if(common_scripts\utility::func_3C77("fuel_valve_2")) {
        var_01 = common_scripts\utility::func_F93(var_01, var_03);
        var_0A = 1;
      }
    }

    if(var_0B == 0) {
      if(common_scripts\utility::func_3C77("fuel_valve_3")) {
        var_01 = common_scripts\utility::func_F93(var_01, var_04);
        var_0B = 1;
      }
    }

    var_05 = common_scripts\utility::func_7A33(var_01);
    if(isDefined(var_05)) {
      var_05.temporarily_turn_off = 1;
      var_05 lib_0378::func_8D74("fire_panel_turn_off");
    }

    wait(15);
    wait(20);
  }
}

fire_panels_intro(param_00) {
  level endon("flag_subpen_traps_completed");
  var_01 = 1;
  thread fire_panels(param_00[1]);
  thread fire_panels(param_00[2]);
  wait(var_01);
  thread fire_panels(param_00[3]);
  thread fire_panels(param_00[4]);
  wait(var_01);
  thread fire_panels(param_00[5]);
  thread fire_panels(param_00[6]);
  thread fire_panels(param_00[15]);
  thread fire_panels(param_00[16]);
  thread fire_panels(param_00[17]);
  wait(var_01);
  thread fire_panels(param_00[7]);
  thread fire_panels(param_00[8]);
  thread fire_panels(param_00[18]);
  thread fire_panels(param_00[19]);
  thread fire_panels(param_00[20]);
  wait(var_01);
  thread fire_panels(param_00[9]);
  thread fire_panels(param_00[10]);
  thread fire_panels(param_00[21]);
  thread fire_panels(param_00[22]);
  thread fire_panels(param_00[23]);
  wait(var_01);
  thread fire_panels(param_00[11]);
  thread fire_panels(param_00[12]);
  thread fire_panels(param_00[24]);
  thread fire_panels(param_00[25]);
  thread fire_panels(param_00[26]);
  wait(var_01);
  thread fire_panels(param_00[13]);
  thread fire_panels(param_00[14]);
  thread fire_panels(param_00[27]);
  thread fire_panels(param_00[28]);
  thread fire_panels(param_00[29]);
}

fire_pattern_right_wave(param_00) {
  level endon("flag_subpen_traps_completed");
  var_01 = 1.5;
  thread fire_panels_new(param_00[1]);
  wait(var_01);
  thread fire_panels_new(param_00[3]);
  thread fire_panels_new(param_00[4]);
  wait(var_01);
  thread fire_panels_new(param_00[5]);
  thread fire_panels_new(param_00[6]);
  wait(var_01);
  thread fire_panels_new(param_00[7]);
  thread fire_panels_new(param_00[8]);
  wait(var_01);
  thread fire_panels_new(param_00[9]);
  thread fire_panels_new(param_00[10]);
  wait(var_01);
  thread fire_panels_new(param_00[11]);
  thread fire_panels_new(param_00[12]);
  wait(var_01);
  thread fire_panels_new(param_00[13]);
  wait(var_01);
}

fire_pattern_right_wave_reverse(param_00) {
  level endon("flag_subpen_traps_completed");
  var_01 = 1.5;
  thread fire_panels_new(param_00[13]);
  wait(var_01);
  thread fire_panels_new(param_00[11]);
  thread fire_panels_new(param_00[12]);
  wait(var_01);
  thread fire_panels_new(param_00[9]);
  thread fire_panels_new(param_00[10]);
  wait(var_01);
  thread fire_panels_new(param_00[7]);
  thread fire_panels_new(param_00[8]);
  wait(var_01);
  thread fire_panels_new(param_00[5]);
  thread fire_panels_new(param_00[6]);
  wait(var_01);
  thread fire_panels_new(param_00[3]);
  thread fire_panels_new(param_00[4]);
  wait(var_01);
  thread fire_panels_new(param_00[1]);
  wait(var_01);
}

fire_pattern_left_wave(param_00) {
  level endon("flag_subpen_traps_completed");
  var_01 = 1.5;
  thread fire_panels_new(param_00[15]);
  thread fire_panels_new(param_00[16]);
  thread fire_panels_new(param_00[17]);
  wait(var_01);
  thread fire_panels_new(param_00[18]);
  thread fire_panels_new(param_00[19]);
  thread fire_panels_new(param_00[20]);
  wait(var_01);
  thread fire_panels_new(param_00[21]);
  thread fire_panels_new(param_00[22]);
  wait(var_01);
  thread fire_panels_new(param_00[23]);
  wait(var_01);
  thread fire_panels_new(param_00[24]);
  thread fire_panels_new(param_00[25]);
  wait(var_01);
  thread fire_panels_new(param_00[26]);
  thread fire_panels_new(param_00[28]);
  wait(var_01);
}

fire_pattern_left_wave_reverse(param_00) {
  level endon("flag_subpen_traps_completed");
  var_01 = 1.5;
  thread fire_panels_new(param_00[26]);
  thread fire_panels_new(param_00[28]);
  wait(var_01);
  thread fire_panels_new(param_00[24]);
  thread fire_panels_new(param_00[25]);
  wait(var_01);
  thread fire_panels_new(param_00[23]);
  wait(var_01);
  thread fire_panels_new(param_00[21]);
  thread fire_panels_new(param_00[22]);
  wait(var_01);
  thread fire_panels_new(param_00[18]);
  thread fire_panels_new(param_00[19]);
  thread fire_panels_new(param_00[20]);
  wait(var_01);
  thread fire_panels_new(param_00[15]);
  thread fire_panels_new(param_00[16]);
  thread fire_panels_new(param_00[17]);
  wait(var_01);
}

fire_pattern_mid_upper(param_00) {
  level endon("flag_subpen_traps_completed");
  thread fire_panels_new(param_00[29]);
  thread fire_panels_new(param_00[30]);
  thread fire_panels_new(param_00[31]);
}

fire_pattern_mid_lower(param_00) {
  level endon("flag_subpen_traps_completed");
  thread fire_panels_new(param_00[32]);
  thread fire_panels_new(param_00[33]);
  thread fire_panels_new(param_00[34]);
}

fire_panels(param_00) {
  playFX(common_scripts\utility::func_44F5("zmb_isl_fire_pyro_rnr"), param_00.origin, anglesToForward(param_00.angles));
  param_00 lib_0378::func_8D74("sub_pen_floor_trap_pyro_flame");
  param_00 lib_0378::func_8D74("sub_pen_floor_trap_decaying_fire");
  var_01 = getEnt(param_00.target, "targetname");
  var_02 = gettime();
  for(;;) {
    fire_panel_player_apply_damage(var_01);
    var_03 = lib_0547::func_408F();
    foreach(var_05 in var_03) {
      if(var_05 istouching(var_01)) {
        var_05 thread feet_fire_vfx();
      }
    }

    if(gettime() - var_02 / 1000 >= 1) {
      break;
    }

    wait 0.05;
  }
}

vo_fire_panels(param_00) {
  level endon("flag_subpen_traps_completed");
  var_01 = gettime();
  for(;;) {
    foreach(var_03 in level.players) {
      if(var_03 istouching(param_00) && !common_scripts\utility::func_562E(var_03.vo_fire_panel_warning_received)) {
        var_03.vo_fire_panel_warning_received = 1;
        var_04 = randomint(5);
        switch (var_04) {
          case 0:
            var_03 thread lib_0367::func_8E3D("valveson");
            break;

          case 1:
            var_03 thread lib_0367::func_8E3D("watchthefloor");
            break;

          case 2:
            var_03 thread lib_0367::func_8E3D("lookout");
            break;

          case 3:
            var_03 thread lib_0367::func_8E3D("itsonfire");
            break;

          case 4:
            var_03 thread lib_0367::func_8E3D("move");
            break;

          default:
            break;
        }

        break;
      }
    }

    if(gettime() - var_01 / 1000 >= 3.5) {
      break;
    }

    wait 0.05;
  }
}

fire_panels_new(param_00) {
  level endon("flag_subpen_traps_completed");
  var_01 = getEnt(param_00.target, "targetname");
  thread vo_fire_panels(var_01);
  playFX(common_scripts\utility::func_44F5("zmb_isl_fire_licks_rnr"), param_00.origin, anglesToForward(param_00.angles));
  param_00 lib_0378::func_8D74("sub_pen_floor_trap_warning_fire");
  wait(3);
  wait(randomfloatrange(0.2, 1));
  playFX(common_scripts\utility::func_44F5("zmb_isl_fire_pyro_rnr"), param_00.origin, anglesToForward(param_00.angles));
  playFX(common_scripts\utility::func_44F5("zmb_isl_fire_pyro_repeating_rnr"), param_00.origin, anglesToForward(param_00.angles));
  param_00 lib_0378::func_8D74("sub_pen_floor_trap_pyro_flame");
  param_00 lib_0378::func_8D74("sub_pen_floor_trap_decaying_fire");
  var_02 = gettime();
  for(;;) {
    fire_panel_player_apply_damage(var_01);
    var_03 = lib_0547::func_408F();
    foreach(var_05 in var_03) {
      if(var_05 istouching(var_01)) {
        var_05 thread feet_fire_vfx();
      }
    }

    if(gettime() - var_02 / 1000 >= 4.5) {
      break;
    }

    wait 0.05;
  }
}

fire_panel_player_apply_damage(param_00) {
  if(!isDefined(level.panelattacker)) {
    level.panelattacker = spawn("script_model", (0, 0, 0));
    level.panelattacker setModel("tag_origin");
    level.panelattacker.var_A4B = "zombie_fireman";
  }

  foreach(var_02 in level.players) {
    if(var_02 istouching(param_00)) {
      var_02 thread attempt_apply_player_damage();
    }
  }
}

attempt_apply_player_damage() {
  var_00 = self;
  if(!isDefined(var_00.lastburntime)) {
    var_00.lastburntime = 0;
  }

  if(gettime() - var_00.lastburntime / 1000 >= 0.65) {
    var_00.lastburntime = gettime();
    var_00 dodamage(15, var_00.origin, level.panelattacker, level.panelattacker, "MOD_ENERGY");
  }
}

fire_panels_always_burn(param_00) {
  level endon("flag_subpen_traps_completed");
  param_00.temporarily_turn_off = 0;
  var_01 = spawnfx(common_scripts\utility::func_44F5("zmb_isl_fire_licks_m"), param_00.origin, anglesToForward(param_00.angles));
  param_00 lib_0378::func_8D74("sub_pen_floor_trap_warning_fire");
  level.burn_tags = common_scripts\utility::func_F6F(level.burn_tags, var_01);
  triggerfx(var_01);
  wait(3);
  var_01 delete();
  level.burn_tags = common_scripts\utility::func_F93(level.burn_tags, var_01);
  var_01 = spawnfx(common_scripts\utility::func_44F5("zmb_isl_fire_pyro_repeating"), param_00.origin, anglesToForward(param_00.angles));
  level.burn_tags = common_scripts\utility::func_F6F(level.burn_tags, var_01);
  triggerfx(var_01);
  playFX(common_scripts\utility::func_44F5("zmb_isl_fire_pyro"), param_00.origin, anglesToForward(param_00.angles));
  param_00 lib_0378::func_8D74("sub_pen_floor_trap_pyro_flame");
  param_00 lib_0378::func_8D74("fire_panel_turn_on");
  var_02 = getEnt(param_00.target, "targetname");
  var_03 = gettime();
  for(;;) {
    fire_panel_player_apply_damage(var_02);
    var_04 = lib_0547::func_408F();
    foreach(var_06 in var_04) {
      if(var_06 istouching(var_02)) {
        var_06 thread feet_fire_vfx();
      }
    }

    if(param_00.temporarily_turn_off) {
      break;
    }

    wait 0.05;
  }

  var_01 delete();
  level.burn_tags = common_scripts\utility::func_F93(level.burn_tags, var_01);
  wait(15);
  thread fire_panels_always_burn(param_00);
}

feet_fire_vfx() {
  if(!isDefined(level.var_611["zmb_isl_zmb_feet_fire"])) {
    return;
  }

  playFXOnTag(level.var_611["zmb_isl_zmb_feet_fire"], self, "Tag_Origin");
}

setup_subpen_switches() {
  level.var_A2A0 = getEntArray("valve", "script_noteworthy");
  foreach(var_01 in level.var_A2A0) {
    var_01.valve_type = "custom";
    var_01.var_9ED7 = 8;
    var_01.var_A2A4 = 4;
    var_01.var_A2A5 = 0;
  }

  foreach(var_01 in level.var_A2A0) {
    if(lib_0547::func_5565(var_01.targetname, "fuel_valve")) {
      var_01 thread func_A29E();
    }
  }

  var_05 = getEntArray("valveTrigger", "script_noteworthy");
  foreach(var_07 in var_05) {
    var_07 common_scripts\utility::func_9D9F();
  }

  common_scripts\utility::func_3C9F("flag_freezer_combat_started");
  foreach(var_07 in var_05) {
    var_07 common_scripts\utility::func_9DA3();
  }

  for(;;) {
    if(common_scripts\utility::func_3C77("fuel_valve_1") && common_scripts\utility::func_3C77("fuel_valve_2") && common_scripts\utility::func_3C77("fuel_valve_3")) {
      level notify("subpen_switches_success");
      common_scripts\utility::func_3C8F("flag_subpen_traps_completed");
      if(isDefined(level.burn_tags)) {
        foreach(var_0C in level.burn_tags) {
          var_0C delete();
        }
      }

      break;
    }

    wait 0.05;
  }

  if(isDefined(level.panelattacker)) {
    level.panelattacker delete();
  }
}

func_A29E() {
  var_00 = self;
  var_01 = common_scripts\utility::func_46B7("gas_vfx", "script_noteworthy");
  var_02 = common_scripts\utility::func_46B7("indicator_light_vfx", "script_noteworthy");
  var_03 = common_scripts\utility::func_4461(self.origin, var_02);
  var_04 = common_scripts\utility::func_46B7("indicator_light_vfx_top", "script_noteworthy");
  var_05 = common_scripts\utility::func_4461(self.origin, var_04);
  var_06 = spawnfx(common_scripts\utility::func_44F5("zmb_nest_generator_light_off"), var_03.origin, anglesToForward(var_03.angles), anglestoup(var_03.angles));
  var_07 = spawnfx(common_scripts\utility::func_44F5("zmb_nest_generator_bulb_off"), var_05.origin, anglesToForward(var_05.angles), anglestoup(var_05.angles));
  triggerfx(var_06, 0.5);
  triggerfx(var_07, 0.5);
  common_scripts\utility::func_3C9F("flag_freezer_combat_started");
  var_06 delete();
  var_07 delete();
  var_06 = spawnfx(common_scripts\utility::func_44F5("zmb_nest_generator_light_red"), var_03.origin, anglesToForward(var_03.angles), anglestoup(var_03.angles));
  var_07 = spawnfx(common_scripts\utility::func_44F5("zmb_nest_generator_bulb_red"), var_05.origin, anglesToForward(var_05.angles), anglestoup(var_05.angles));
  triggerfx(var_06);
  triggerfx(var_07);
  common_scripts\utility::func_3C9F(self.var_819A);
  var_06 delete();
  var_07 delete();
  var_06 = spawnfx(common_scripts\utility::func_44F5("zmb_nest_generator_light_green"), var_03.origin, anglesToForward(var_03.angles), anglestoup(var_03.angles));
  var_07 = spawnfx(common_scripts\utility::func_44F5("zmb_nest_generator_bulb_green"), var_05.origin, anglesToForward(var_05.angles), anglestoup(var_05.angles));
  triggerfx(var_06);
  triggerfx(var_07);
}

setup_aa_guns_power_switch() {
  var_00 = common_scripts\utility::func_46B7("aagun_switch", "targetname");
  foreach(var_02 in var_00) {
    var_02 initialize_aagun_switches();
    var_02 thread run_aagun_switches();
  }
}

initialize_aagun_switches() {
  var_00 = common_scripts\utility::func_44BE(self.target, "targetname");
  var_01 = function_021F("power_switch_island_aagun", "targetname");
  self.computer_panels = common_scripts\utility::func_4461(self.origin, var_01);
  self.computer_panels setscriptablepartstate("cbreaker", "standby_idle");
  self.computer_panels setscriptablepartstate("light_red", "on");
  self.computer_panels setscriptablepartstate("light_green", "off");
  self.computer_panels setscriptablepartstate("light_power", "off");
  self.computer_panels setscriptablepartstate("light_graph", "off");
  foreach(var_03 in var_00) {
    switch (var_03.script_noteworthy) {
      case "use_trigger":
        self.var_9D65 = var_03;
        self.var_9D65 setHintString(&"ZOMBIES_POWER_ON");
        self.var_9D65 waittill("trigger", var_04);
        level.subpen_switches_on++;
        self.var_9D65 common_scripts\utility::func_9D9F();
        self.var_9D65 setHintString("");
        self.computer_panels setscriptablepartstate("cbreaker", "ready");
        self.computer_panels setscriptablepartstate("light_red", "off");
        self.computer_panels setscriptablepartstate("light_green", "on");
        self.computer_panels setscriptablepartstate("light_power", "on");
        self.computer_panels setscriptablepartstate("light_graph", "on");
        common_scripts\utility::func_3C8F("flag_aa_guns_powered_on");
        break;
    }
  }
}

run_aagun_switches() {
  level endon("subpen_switches_success");
  for(;;) {
    self.var_9D65 waittill("trigger", var_00);
    level.subpen_switches_on++;
    self.var_9D65 common_scripts\utility::func_9D9F();
    self.var_9D65 setHintString("");
    self.computer_panels setscriptablepartstate("cbreaker", "ready");
    self.computer_panels setscriptablepartstate("light_red", "off");
    self.computer_panels setscriptablepartstate("light_green", "on");
    self.computer_panels setscriptablepartstate("light_power", "on");
    self.computer_panels setscriptablepartstate("light_graph", "on");
    common_scripts\utility::func_3C8F("flag_aa_guns_powered_on");
  }
}

_______________planes_______________() {}

plane_ee_init() {
  level.current_score = 0;
  level.points_to_win = 9999;
  level.aagun_ee_difficulty = 0;
  level.current_score = 0;
  lib_0378::func_8D74("aud_plane_mission_start");
  var_00 = getEnt("zmb_island_plane_crash_strap", "targetname");
  var_00 hide();
  plane_ee_set_rules();
  level thread plane_ee_score_counter();
  level thread plane_ee_wave_handler();
  level thread plane_ee_cloud_handler();
  foreach(var_02 in level.players) {
    var_02.plane_vo_reaction = 0;
  }
}

aa_gun_trap_buy_me() {
  self.var_9D65.var_267B = 750;
  while(!lib_0557::func_7831("CORPSE_GATE")) {
    wait 0.05;
  }

  level thread wait_for_objective_start();
  common_scripts\utility::func_3C9F("flak_cannons_ready");
  self.var_9D65 setHintString(self.var_9D65.hint_string_no_power);
  common_scripts\utility::func_3C9F("flag_aa_guns_powered_on");
  common_scripts\utility::func_3C8F("flag_used_island_turret");
  self.var_9D65 setHintString(self.var_9D65.hint_string_available);
  thread wait_for_aa_turret_trigger_interact();
  var_00 = undefined;
  for(;;) {
    level waittill("aa_gun_request", var_01, var_02);
    if(isDefined(var_02) && var_02 != self) {
      continue;
    }

    if(!isPlayer(var_01)) {
      if(common_scripts\utility::func_562E(var_01)) {
        handle_turret_lockdown();
      }

      self.var_9D65 setHintString(self.var_9D65.hint_string_available);
      continue;
    } else {
      var_00 = var_01;
    }

    if(!var_00 maps / mp / gametypes / zombies::func_11C2(self.var_9D65.var_267B)) {
      var_00 thread lib_054E::func_695("needmoney");
      continue;
    } else {
      self.var_9D65 common_scripts\utility::func_9D9F();
      self.wall_model thread set_wall_up();
      self.wall_model set_player_using_turret(var_00, self.var_9EDD);
      var_00 lib_0367::func_8E3D("flakon_both");
      var_03 = ["zombie_generic", "zombie_berserker"];
      self.wall_model thread maps / mp / mp_zombies_attack_object::create_inanimate_zombie_enemy(3, 400, "this_turret_is_done", 1024, 512, ::stunning_burst_zombies, [::player_left, ::player_died, ::player_disconnected], self.var_1176, var_03, ["zombie_is_passive", "zombie_is_crawler", "zombie_is_objective", "zombie_is_stunned"], var_00);
      self.wall_model common_scripts\utility::func_379C("this_turret_is_done");
      self.wall_model unset_player_using_turret(var_00, self.var_9EDD);
      self.wall_model common_scripts\utility::func_3796("this_turret_is_done");
      playFX(level.var_611["zmb_isl_aa_gun_gk_energy"], self.wall_model.origin, anglesToForward(self.wall_model.angles));
      var_00 lib_0378::func_8D74("aud_stunning_burst_use");
      self.wall_model thread set_wall_down();
      wait(1);
      self.var_9D65 common_scripts\utility::func_9DA3();
      self.var_9D65 setHintString(self.var_9D65.hint_string_unavailable);
      wait(12.5);
      handle_turret_lockdown();
      self.var_9D65 setHintString(self.var_9D65.hint_string_available);
    }
  }
}

handle_turret_lockdown() {
  while(common_scripts\utility::func_562E(level.aa_guns_locked)) {
    self.var_9D65 setHintString(self.var_9D65.hint_string_unavailable);
    wait(0.125);
  }
}

wait_for_aa_turret_trigger_interact() {
  for(;;) {
    self.var_9D65 waittill("trigger", var_00);
    level notify("aa_gun_request", var_00, self);
  }
}

lock_island_aa_gun_turrets(param_00) {
  level.aa_guns_locked = param_00;
  level notify("aa_gun_request", param_00);
}

wait_for_objective_start() {
  common_scripts\utility::func_3C9F(lib_0557::func_7838("CORPSE_GATE", "Open Corpse Gate"));
  common_scripts\utility::func_3C8F("flak_cannons_ready");
}

set_wall_up() {
  self scriptmodelplayanim("s2_zom_flak_gun_gate_close");
  lib_0378::func_8D74("flak_gun_gate_up");
  wait(getanimlength(%s2_zom_flak_gun_gate_open));
  self scriptmodelplayanim("s2_zom_flak_gun_gate_close_idle");
}

set_wall_down() {
  self scriptmodelplayanim("s2_zom_flak_gun_gate_open");
  lib_0378::func_8D74("flak_gun_gate_down");
  wait(getanimlength(%s2_zom_flak_gun_gate_open));
  self scriptmodelplayanim("s2_zom_flak_gun_gate_open_idle");
}

stunning_burst_zombies() {
  var_00 = lib_0547::func_408F();
  var_01 = 0;
  foreach(var_03 in common_scripts\utility::func_40B0(self.origin, var_00, undefined, undefined, 200)) {
    if(lib_0547::func_5565(var_03.var_A4B, "zombie_generic") || lib_0547::func_5565(var_03.var_A4B, "zombie_berserker")) {
      var_03 lib_056D::func_5A86();
    }
  }
}

set_player_using_turret(param_00, param_01) {
  self.turret_player = param_00;
  self.var_9EDD = param_01;
  param_00.ignoreme = 1;
  param_00.on_aa_gun = 1;
  param_01 useby(param_00);
  param_00.var_480F = 1;
  param_00 setclientomnvar("ui_zm_turret_health", 1);
  param_00 method_80EB();
  wait(1.5);
  param_00 method_80EC();
}

unset_player_using_turret(param_00, param_01) {
  param_00.ignoreme = 0;
  param_00.on_aa_gun = 0;
  param_00 method_85E9();
  param_00.var_480F = 0;
  param_00 setclientomnvar("ui_zm_turret_health", 0);
  param_00 notify("left_aa_gun");
}

turret_time_limit(param_00) {
  self endon(param_00);
  wait(15);
}

player_left(param_00) {
  self endon(param_00);
  self.var_9EDD waittill("turret_deactivate");
}

player_died(param_00) {
  self endon(param_00);
  while(isDefined(self.turret_player) && isalive(self.turret_player) && !common_scripts\utility::func_562E(self.turret_player.var_5728)) {
    wait 0.05;
  }
}

player_disconnected(param_00) {
  self endon(param_00);
  self.turret_player waittill("disconnect");
}

plane_ee_set_rules() {
  level.aagun_ee_difficulty = level.players.size;
  if(level.aagun_ee_difficulty == 1) {
    level.points_to_win = 10;
  }

  if(level.aagun_ee_difficulty == 2) {
    level.points_to_win = 12;
  }

  if(level.aagun_ee_difficulty >= 3) {
    level.points_to_win = 13;
  }
}

plane_ee_adjust_rules() {
  var_00 = level.aagun_ee_difficulty;
  var_01 = level.players.size;
  if(var_01 >= var_00) {
    if(var_01 == 2) {
      level.points_to_win = 12;
    }

    if(var_01 >= 3) {
      level.points_to_win = 13;
    }
  }
}

plane_ee_score_counter() {
  common_scripts\utility::func_3C87("flag_planes_half_way_done");
  while(level.current_score <= level.points_to_win) {
    level waittill("plane_killed");
    level.current_score++;
  }

  if(level.current_score >= level.points_to_win / 2) {
    if(!common_scripts\utility::func_3C77("flag_planes_half_way_done")) {
      level thread vo_players_half_way_done();
    }
  }

  if(level.current_score >= level.points_to_win) {
    level notify("island_plane_destroyed");
    common_scripts\utility::func_3C8F("flag_players_have_won");
    var_00 = getvehiclenode("plane_start_node_radio", "targetname");
    var_00 plane_ee_spawn_radio_plane(1);
    return;
  }

  thread plane_ee_score_counter();
}

plane_ee_cloud_handler() {
  var_00 = common_scripts\utility::func_46B7("struct_cloud_fx_spawner_village", "targetname");
  var_01 = common_scripts\utility::func_46B7("struct_cloud_fx_spawner_docks", "targetname");
  var_02 = common_scripts\utility::func_46B7("struct_cloud_fx_spawner_ocean", "targetname");
  var_03 = common_scripts\utility::func_46B7("struct_cloud_fx_spawner_beach", "targetname");
  var_04 = common_scripts\utility::func_46B7("struct_cloud_fx_spawner_lighthouse", "targetname");
  foreach(var_06 in var_00) {
    playFX(level.var_611["zmb_clouds_puff_static"], var_06.origin, (1, 1, 0));
  }

  foreach(var_06 in var_01) {
    playFX(level.var_611["zmb_clouds_puff_static"], var_06.origin, (1, -1, 0));
  }

  foreach(var_06 in var_02) {
    playFX(level.var_611["zmb_clouds_puff_static"], var_06.origin, (0, -1, 0));
  }

  foreach(var_06 in var_03) {
    playFX(level.var_611["zmb_clouds_puff_static"], var_06.origin, (-1, -1, 0));
  }

  foreach(var_06 in var_04) {
    playFX(level.var_611["zmb_clouds_puff_static"], var_06.origin, (-1, 1, 0));
  }
}

plane_ee_wave_handler() {
  var_00 = [1, 2, 3, 4];
  while(!common_scripts\utility::func_3C77("flag_players_have_won")) {
    var_01 = common_scripts\utility::func_7A33(var_00);
    var_00 = common_scripts\utility::func_F93(var_00, var_01);
    if(var_00.size <= 0) {
      var_00 = [1, 2, 3, 4];
    }

    switch (var_01) {
      case 1:
        level.plane_wave_vo_played = 0;
        plane_ee_adjust_rules();
        level.wave_a = function_01DC("plane_start_node_a", "targetname");
        var_02 = level.wave_a plane_ee_do_spawn_plane_wave();
        level thread vo_planes_by_village();
        break;

      case 2:
        level.plane_wave_vo_played = 0;
        plane_ee_adjust_rules();
        level.wave_b = function_01DC("plane_start_node_b", "targetname");
        var_02 = level.wave_b plane_ee_do_spawn_plane_wave();
        level thread vo_planes_by_docks();
        break;

      case 3:
        level.plane_wave_vo_played = 0;
        plane_ee_adjust_rules();
        level.wave_c = function_01DC("plane_start_node_c", "targetname");
        var_02 = level.wave_c plane_ee_do_spawn_plane_wave();
        level thread vo_planes_by_beach();
        break;

      case 4:
        level.plane_wave_vo_played = 0;
        plane_ee_adjust_rules();
        level.wave_d = function_01DC("plane_start_node_d", "targetname");
        var_02 = level.wave_d plane_ee_do_spawn_plane_wave();
        level thread vo_planes_by_lighthouse();
        break;

      default:
        break;
    }

    wait(30);
  }
}

plane_ee_do_spawn_plane_wave() {
  var_00 = [];
  var_01 = 0;
  foreach(var_03 in self) {
    var_04 = var_03 plane_ee_do_spawn_planes();
    var_00 = common_scripts\utility::func_F6F(var_00, var_04);
  }

  var_06 = var_00[0].targetname;
  thread plane_ee_bonus_point_counter(var_00, var_06);
  return var_00;
}

plane_ee_bonus_point_counter(param_00, param_01) {
  var_02 = 0;
  thread plane_ee_plane_cleaner(param_00);
  while(param_00.size >= 0) {
    level waittill(param_01);
    var_02++;
    if(var_02 >= 6) {
      level.current_score = level.current_score + 1;
      break;
    }

    wait(1);
  }
}

plane_ee_plane_cleaner(param_00) {
  while(param_00.size >= 0) {
    param_00 = common_scripts\utility::func_FA0(param_00);
    wait(0.5);
  }
}

plane_ee_do_spawn_planes() {
  var_00 = "ger_bomber_stuka_hub";
  var_01 = "ger_bomber_stuka_vista";
  var_02 = spawnhelicopter(self.origin, self.angles, var_00, var_01);
  var_02.targetname = self.targetname;
  level.active_planes[level.active_planes.size] = var_02;
  var_02 method_80B1();
  var_02 notify("forward");
  var_02.veh_transmission = "forward";
  var_02.veh_pathdir = "forward";
  var_02.var_17DC = 0;
  var_02.var_931A = "forward";
  var_02 lib_0378::func_8D74("aud_plane_spawn");
  var_02 thread plane_ee_do_plane_turrets();
  var_02 startpath(self);
  var_02 thread plane_ee_vehicle_paths_non_heli(self);
  var_02 thread maps\mp\gametypes\_damage::func_8676(100);
  var_02.health = 60;
  var_02.var_29B5 = ::func_703F;
  var_02 thread plane_ee_handleflakprojectileproximity();
  var_02 thread plane_ee_do_plane_cleanup();
  return var_02;
}

plane_ee_spawn_radio_plane(param_00, param_01) {
  var_02 = "ger_bomber_stuka_hub";
  var_03 = "ger_bomber_stuka_vista";
  var_04 = spawnhelicopter(self.origin, self.angles, var_02, var_03);
  var_04.targetname = self.targetname;
  var_04.mustfindacrashpath = common_scripts\utility::func_562E(param_00);
  var_05 = common_scripts\utility::func_7A33(level.players);
  var_05 thread lib_0367::func_8E3C("planegone");
  var_04 common_scripts\utility::func_3799("plane_crashed");
  var_04 common_scripts\utility::func_3799("plane_got_away");
  var_04 notify("forward");
  var_04.veh_transmission = "forward";
  var_04.veh_pathdir = "forward";
  var_04.var_17DC = 0;
  var_04.var_931A = "forward";
  var_04 thread plane_ee_do_plane_turrets();
  var_04 startpath(self);
  var_04 lib_0378::func_8D74("aud_last_plane_spawn");
  var_04 thread plane_ee_vehicle_paths_non_heli(self);
  var_04 thread maps\mp\gametypes\_damage::func_8676(100);
  var_04.health = 60;
  var_04.var_29B5 = ::func_703F;
  var_04 thread plane_ee_handleflakprojectileproximity();
  if(common_scripts\utility::func_3C77("flag_ui_planes_ee_done")) {
    var_04 thread ensure_death_scene();
  }

  var_04 common_scripts\utility::func_379E("plane_crashed", "plane_got_away");
  if(var_04 common_scripts\utility::func_3794("plane_got_away")) {
    var_04 delete();
    var_04 = getvehiclenode("plane_start_node_radio", "targetname");
    var_04 plane_ee_spawn_radio_plane(1, 1);
    return;
  }

  level thread maps / mp / mp_zombie_island::ee_casual_plane_cliff_crash();
  lib_0378::func_8D74("aud_last_plane_crash", var_04.origin);
  lib_0557::func_782D("Flak Tower", "Defend Flak Tower");
  var_04 delete();
  wait(2);
  thread plane_wreckage_radio_vo();
}

ensure_death_scene() {
  while(!common_scripts\utility::func_3C83("aud_last_plane_spawned")) {
    wait 0.05;
  }

  plane_ee_plane_crashy();
}

plane_ee_do_plane_sound() {}

plane_damage_player() {
  self endon("death");
  var_00 = getEnt("vol_plane_damage_area", "targetname");
  while(common_scripts\utility::func_3794("turret_on")) {
    if(lib_0547::func_5565(level.plane_wave_vo_played, 0)) {
      thread plane_wave_diving_vo();
    }

    var_01 = self.origin;
    var_02 = anglesToForward(self gettagangles("TAG_MUZZLE_FX_1"));
    var_03 = 10000;
    var_04 = 180;
    var_05 = bulletTrace(self gettagorigin("TAG_MUZZLE_FX_1"), var_01 + var_02 * var_03, 0, undefined, 1, 1, 0, 0, 0, 0, 0);
    if(isDefined(var_05["position"])) {
      var_06 = var_05["position"];
      var_07 = lib_0547::func_408F();
      var_07 = function_01AC(var_07, var_06, var_04, 1);
      foreach(var_09 in var_07) {
        if(bullettracepassed(var_06 + (0, 0, 25), var_09 getEye(), 0)) {
          var_09 dodamage(80, self.origin);
        }
      }

      var_0B = function_01AC(level.players, var_06, var_04, 1);
      foreach(var_0D in var_0B) {
        if(bullettracepassed(var_06 + (0, 0, 25), var_0D.origin, 0) || bullettracepassed(var_06 + (0, 0, 25), var_0D gettagorigin("j_spine4"), 0) || bullettracepassed(var_06 + (0, 0, 25), var_0D getEye(), 0)) {
          var_0D dodamage(23, self.origin);
          var_0D notify("aagun_damage");
        }
      }
    }

    wait(0.22);
  }
}

plane_wave_diving_vo() {
  level.plane_wave_vo_played = 1;
  wait(1);
  var_00 = randomint(4);
  switch (var_00) {
    case 0:
      lib_0367::snd_zmb_plr_dlg_play_line_on_each_player("planewarn");
      break;

    case 1:
      lib_0367::snd_zmb_plr_dlg_play_line_on_each_player("planewarn2");
      break;

    case 2:
      lib_0367::snd_zmb_plr_dlg_play_line_on_each_player("planewarn3");
      break;

    case 3:
      lib_0367::snd_zmb_plr_dlg_play_line_on_each_player("planewarn4");
      break;
  }
}

plane_ee_do_plane_turrets() {
  self endon("death");
  common_scripts\utility::func_3799("turret_on");
  common_scripts\utility::func_3799("turret_off");
  common_scripts\utility::func_379C("turret_on");
  var_00 = self gettagorigin("TAG_MUZZLE_FX_1");
  var_01 = self gettagorigin("TAG_MUZZLE_FX_2");
  common_scripts\utility::func_379C("turret_on");
  lib_0378::func_8D74("aud_plane_firing");
  thread plane_damage_player();
  while(common_scripts\utility::func_3794("turret_on")) {
    playFXOnTag(level.var_611["zmb_isl_enemy_plane_tracer"], self, "TAG_MUZZLE_FX_1");
    playFXOnTag(level.var_611["zmb_isl_enemy_plane_tracer"], self, "TAG_MUZZLE_FX_2");
    wait(0.2);
  }
}

plane_ee_do_plane_cleanup() {
  wait(4);
  for(;;) {
    if(isDefined(self) && self.veh_speed <= 0) {
      level.active_planes = common_scripts\utility::func_F93(level.active_planes, self);
      self notify("death");
      self delete();
      break;
    }

    wait(3);
  }
}

func_703F(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  self endon("plane_killed");
  if(common_scripts\utility::func_562E(self.findingacrashpath)) {
    return;
  }

  if(isDefined(param_01.var_1D1) && !isPlayer(param_01)) {
    param_01 = param_01 method_80E2();
  }

  if(isDefined(self.parent)) {
    var_0C = self.parent;
  } else {
    var_0C = self;
  }

  if(param_05 != "turretweapon_ger_btry_flak38_mp_zombie" && param_05 != "bazooka_mp" && param_05 != "panzerschreck_mp" && param_05 != "fliegerfaust_zm" && param_05 != "fliegerfaust_pap_zm") {
    param_02 = 1;
  }

  var_0C.health = var_0C.health - param_02;
  if(var_0C.health <= 0) {
    if(isDefined(param_01)) {
      param_01 maps\mp\gametypes\_damagefeedback::func_A102("killshot");
      if(isDefined(level.zmb_events_player_destroyed_stuka)) {
        param_01 thread[[level.zmb_events_player_destroyed_stuka]]();
      }

      var_0D = randomintrange(0, 11);
      if(var_0D <= 4) {
        param_01 thread vo_plane_killed();
      }
    }

    if(isDefined(param_05) && isPlayer(param_01)) {
      param_01 notify("plane_crashy", param_05);
    }

    var_0C plane_ee_plane_crashy();
    return;
  }

  if(isDefined(param_01)) {
    param_01 maps\mp\gametypes\_damagefeedback::func_A102("standard");
  }
}

func_7040(param_00, param_01, param_02, param_03) {
  self endon("death");
  self.attacker = param_00;
}

plane_ee_plane_crashy() {
  if(common_scripts\utility::func_562E(self.findingacrashpath)) {
    return;
  }

  if(!isDefined(self.var_272B) || self.var_272B == 0) {
    self.var_272B = 1;
    self notify("crashing");
    lib_0378::func_8D74("aud_plane_tailspin");
    if(common_scripts\utility::func_562E(self.mustfindacrashpath)) {
      self.findingacrashpath = 1;
      common_scripts\utility::func_3C8F("flag_ui_planes_ee_done");
      wait_for_valid_crash_path();
    }

    var_00 = self.var_2944;
    if(isDefined(var_00) && isDefined(var_00.var_81EF)) {
      self.crashingspecial = 1;
      var_00 = self.var_2944;
      plane_ee_goto_linkto_path(var_00);
      wait 0.05;
      self waittill("reached_dynamic_path_end");
      common_scripts\utility::func_379A("plane_crashed");
      return;
    } else {
      var_01 = randomfloatrange(-90, 90);
      var_02 = (0, cos(var_01), sin(var_01));
      var_03 = (randomfloatrange(-1000, 1000), randomfloatrange(-1000, 1000), randomfloatrange(-1000, 1000));
      var_04 = 1.2;
      self method_8224(level.player.origin + var_03, self method_8283() * var_04, var_02);
    }

    common_scripts\utility::waittill_notify_or_timeout("veh_collision", randomfloatrange(0.5, 3));
  }

  if(!isDefined(self.crashingspecial) || self.crashingspecial == 0) {
    plane_ee_plane_go_boom();
  }
}

wait_for_valid_crash_path() {
  self endon("plane_got_away");
  for(;;) {
    if(isDefined(self.var_2944) && isDefined(self.var_2944.var_81EF)) {
      var_00 = function_01DC(self.var_2944.var_81EF, "script_linkname");
      if(var_00.size > 0) {
        break;
      }
    }

    wait 0.05;
  }

  return 1;
}

plane_ee_plane_go_boom(param_00) {
  if(!isDefined(self)) {
    return;
  }

  var_01 = anglesToForward(self.angles);
  if(!common_scripts\utility::func_562E(param_00)) {
    playFX(level.var_611["plane_death"], self.origin, var_01);
    lib_0378::func_8D74("aud_plane_explode", self.origin);
  }

  level notify(self.targetname);
  level notify("plane_killed");
  self notify("delete");
  waittillframeend;
  self delete();
  self notify("plane_killed");
}

plane_ee_manage_aa_swaps() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("turretownerchange");
    var_00 = self method_80E2();
    if(isDefined(var_00) && isPlayer(var_00)) {
      thread plane_ee_capture_turret_fire(var_00);
    }
  }
}

plane_ee_capture_turret_fire(param_00) {
  self endon("death");
  level endon("game_ended");
  self endon("turretownerchange");
  for(;;) {
    self waittill("turret_fire", var_01);
    if(!isDefined(var_01[0])) {
      continue;
    }

    thread plane_ee_flakprojectilezombieproximitydetonate(var_01[0], param_00);
    level notify("flak_projectile_fired", var_01[0], param_00);
  }
}

plane_ee_handleflakprojectileproximity() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  for(;;) {
    level waittill("flak_projectile_fired", var_00, var_01);
    if(!isDefined(var_00)) {
      continue;
    }

    thread plane_ee_flakprojectileproximitydetonate(var_00, var_01);
  }
}

plane_ee_flakprojectilezombieproximitydetonate(param_00, param_01) {
  param_01 endon("disconnect");
  level endon("game_ended");
  param_00 endon("death");
  var_02 = 64;
  var_03 = common_scripts\utility::func_4461(param_00.origin, lib_0547::func_408F());
  for(;;) {
    if(isDefined(var_03) && distance2d(var_03 getEye(), param_00.origin) < var_02 && abs(param_00.origin[2] - var_03.origin[2]) < 120) {
      param_01 maps\mp\gametypes\_damagefeedback::func_A102("standard");
      param_00 detonateusingweapon("turretweapon_ger_btry_flak38_mp_zombie", param_01, param_00);
      break;
    }

    wait 0.05;
  }
}

plane_ee_flakprojectileproximitydetonate(param_00, param_01) {
  self endon("death");
  self endon("crashing");
  param_01 endon("disconnect");
  level endon("game_ended");
  param_00 endon("death");
  var_02 = 250000;
  for(;;) {
    var_03 = self.origin;
    var_04 = distancesquared(param_00.origin, var_03);
    if(var_04 < var_02) {
      param_00 notify("plane_death");
      self dodamage(500, var_03, param_01, param_00, "MOD_PROJECTILE", param_00.var_A9E0);
      param_00 method_81D6();
    }

    wait 0.05;
  }
}

plane_ee_get_from_vehicle_node(param_00) {
  return getvehiclenode(param_00, "targetname");
}

plane_ee_get_from_vehicle_node_reverse(param_00) {
  var_01 = getvehiclenode(param_00, "targetname");
  var_02 = var_01 method_8650();
  return var_02 method_8650();
}

plane_ee_get_path_getfunc(param_00) {
  var_01 = ::plane_ee_get_from_vehicle_node;
  return var_01;
}

plane_ee_get_path_getfunc_reverse(param_00) {
  var_01 = ::plane_ee_get_from_vehicle_node_reverse;
  return var_01;
}

plane_ee_deathrollon() {
  if(self.health > 0) {
    self.var_7ED6 = 1;
  }
}

plane_ee_deathrolloff() {
  self.var_7ED6 = undefined;
  self notify("deathrolloff");
}

plane_ee_goto_linkto_path(param_00) {
  waittillframeend;
  if(isDefined(param_00) && isDefined(param_00.var_81EF)) {
    var_01 = function_01DC(param_00.var_81EF, "script_linkname");
    if(isDefined(var_01) && isDefined(var_01[0])) {
      thread plane_ee_vehicle_paths_non_heli(var_01[0]);
      self startpath(var_01[0]);
    }
  }
}

plane_ee_node_wait(param_00, param_01, param_02) {
  if(self.var_1146 == param_00 && !isDefined(param_01)) {
    self notify("node_wait_terminated");
    waittillframeend;
    return;
  }

  if(isDefined(self.var_A01E)) {
    var_03 = "node_wait_triggered" + self.var_A01E;
  } else {
    var_03 = "node_wait_triggered";
  }

  if(!isDefined(param_00.var_9DBB) || param_00.var_9DBB != gettime()) {
    var_04 = spawnStruct();
    plane_ee_wait_til_node_wait_triggered(var_04, var_03, param_00, param_02);
    var_04 waittill(var_03);
  }

  param_00.var_9DBB = undefined;
}

plane_ee_wait_til_node_wait_triggered(param_00, param_01, param_02, param_03) {
  var_04 = 0;
  var_05 = param_02;
  while(isDefined(param_02) && var_04 < 3) {
    var_04++;
    thread plane_ee_node_wait_triggered(param_00, param_01, param_02);
    if(!isDefined(param_02.target)) {
      return;
    }

    param_02 = [[param_03]](param_02.target);
  }
}

plane_ee_node_wait_triggered(param_00, param_01, param_02) {
  self endon("newpath");
  self endon("death");
  param_00 endon(param_01);
  param_02 waittill("trigger");
  param_02.var_9DBB = gettime();
  waittillframeend;
  param_00 notify(param_01);
}

plane_ee_vehicle_paths_non_heli(param_00) {
  self notify("newpath");
  if(isDefined(param_00)) {
    self.var_1146 = param_00;
  }

  var_01 = self.var_1146;
  self.var_2944 = self.var_1146;
  if(!isDefined(var_01)) {
    return;
  }

  self endon("newpath");
  self endon("death");
  var_02 = var_01;
  var_03 = undefined;
  var_04 = var_01;
  var_05 = plane_ee_get_path_getfunc(var_01);
  var_06 = plane_ee_get_path_getfunc_reverse(var_01);
  if(self.veh_pathdir == "reverse") {
    var_07 = var_06;
  } else {
    var_07 = var_06;
  }

  while(isDefined(var_04)) {
    plane_ee_node_wait(var_04, var_03, var_07);
    if(!isDefined(self)) {
      return;
    }

    self.var_2944 = var_04;
    if(isDefined(var_04.script_noteworthy)) {
      self notify(var_04.script_noteworthy);
      self notify("noteworthy", var_04.script_noteworthy);
    }

    waittillframeend;
    if(!isDefined(self)) {
      return;
    }

    if(isDefined(var_04.var_8272)) {
      var_04.var_8186 = var_04.var_8272;
      var_04.var_8272 = undefined;
    }

    if(isDefined(var_04.var_8186)) {
      var_08 = var_04.var_8187;
      if(isDefined(var_08)) {
        level maps\mp\_utility::func_2CED(var_08, ::common_scripts\_exploder::func_392A, var_04.var_8186);
      } else {
        level common_scripts\_exploder::func_392A(var_04.var_8186);
      }
    }

    if(isDefined(var_04.var_81A0)) {
      common_scripts\utility::func_3C8F(var_04.var_81A0);
    }

    if(isDefined(var_04.var_8183)) {
      common_scripts\utility::func_379A(var_04.var_8183);
    }

    if(isDefined(var_04.var_8182)) {
      common_scripts\utility::func_3796(var_04.var_8182);
    }

    if(isDefined(var_04.var_819B)) {
      common_scripts\utility::func_3C7B(var_04.var_819B);
    }

    if(isDefined(var_04.script_noteworthy)) {
      if(var_04.script_noteworthy == "godon") {
        self.var_480F = 1;
      }

      if(var_04.script_noteworthy == "godoff") {
        self.var_480F = 0;
      }

      if(var_04.script_noteworthy == "engineoff") {
        self method_828D();
      }
    }

    if(isDefined(var_04.var_8145)) {
      self.var_8145 = var_04.var_8145;
    }

    if(isDefined(var_04.var_8121)) {
      self.var_8121 = var_04.var_8121;
    }

    if(isDefined(var_04.var_82B2)) {
      self.var_82B2 = var_04.var_82B2;
    }

    if(isDefined(var_04.var_82C1)) {
      self notify("turning", var_04.var_82C1);
    }

    if(isDefined(var_04.var_8150)) {
      if(var_04.var_8150 == 0) {
        thread plane_ee_deathrolloff();
      } else {
        thread plane_ee_deathrollon();
      }
    }

    if(isDefined(var_04.var_82D4)) {
      if(isDefined(var_04.var_8260) && var_04.var_8260 == "queue") {
        self.var_7889 = 1;
      }
    }

    if(isDefined(var_04.var_812B)) {
      self.veh_brake = var_04.var_812B;
    }

    if(isDefined(var_04.var_8265)) {
      self.veh_pathtype = var_04.var_8265;
    }

    if(isDefined(var_04.var_8262)) {
      self.veh_pathdir = var_04.var_8262;
    }

    if(isDefined(var_04.var_8184)) {
      var_09 = 35;
      if(isDefined(var_04.var_8151)) {
        var_09 = var_04.var_8151;
      }

      self method_8280(0, var_09);
      common_scripts\utility::func_379C(var_04.var_8184);
      if(!isDefined(self)) {
        return;
      }

      var_0A = 60;
      if(isDefined(var_04.var_80F6)) {
        var_0A = var_04.var_80F6;
      }

      self method_8293(var_0A);
    }

    var_03 = var_04;
    if(!isDefined(var_04.target)) {
      break;
    }

    if(self.veh_pathdir == "reverse") {
      var_07 = var_06;
    } else {
      var_07 = var_05;
    }

    var_04 = [[var_07]](var_04.target);
    if(!isDefined(var_04)) {
      var_04 = var_03;
      break;
    } else if(!isDefined(var_04.target) || isDefined(var_04.var_82CA)) {
      var_0B = max(0.01, length(self method_8289()));
      var_0C = distance(self.origin, var_04.origin);
      var_0D = max(0.01, var_0C / var_0B);
      self notify("about_to_stop", var_0D);
    }
  }

  self notify("reached_dynamic_path_end");
  if(isDefined(self.var_82D3)) {
    self notify("delete");
    waittillframeend;
    self delete();
    return;
  }

  thread plane_ee_goto_linkto_path(var_04);
}

track_damage(param_00, param_01) {
  func_A725("turretweapon_ger_btry_flak38_mp_zombie");
}

func_A725(param_00) {
  self setCanDamage(1);
  for(;;) {
    self waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
    if(!isDefined(var_0A) || !issubstr(var_0A, param_00)) {
      continue;
    }

    break;
  }
}

quest_step_defend_the_flak_tower() {
  level thread maps / mp / mp_zombie_island_ee_fog_manager::set_fog_locked_to_off();
  level thread plane_ee_init();
  var_00 = 1;
  for(var_01 = 0; var_01 < var_00; var_01++) {
    level waittill("island_plane_destroyed");
  }
}

flak_complete_xp_reward() {
  foreach(var_01 in level.players) {
    var_01 maps\mp\zombies\_zombies_rank::func_AC23("flak");
    var_01 lib_0378::func_8D74("objective_complete", "flak");
  }
}

vo_check_first_plane_spawn() {
  var_00 = 0;
  if(!common_scripts\utility::func_3C77("flag_first_plane_has_spawn")) {
    common_scripts\utility::func_3C8F("flag_first_plane_has_spawn");
    var_00 = 1;
    return var_00;
  }

  return var_00;
}

vo_planes_by_village() {
  var_00 = common_scripts\utility::func_7A33(level.players);
  var_00 thread lib_0367::func_8E3C("planevillage");
}

vo_planes_by_docks() {
  var_00 = common_scripts\utility::func_7A33(level.players);
  var_00 thread lib_0367::func_8E3C("planedocks");
}

vo_planes_by_beach() {
  var_00 = common_scripts\utility::func_7A33(level.players);
  var_00 thread lib_0367::func_8E3C("planebeach");
}

vo_planes_by_lighthouse() {
  var_00 = common_scripts\utility::func_7A33(level.players);
  var_00 thread lib_0367::func_8E3C("planelighthouse");
}

vo_plane_killed() {
  var_00 = randomintrange(1, 4);
  var_01 = undefined;
  if(var_00 == 1) {
    var_01 = "planehit";
  }

  if(var_00 == 2) {
    var_01 = "planehit2";
  }

  if(var_00 == 3) {
    var_01 = "planehit3";
  }

  if(isDefined(self.plane_vo_reaction) && self.plane_vo_reaction == 0) {
    thread vo_plane_killed_reaction();
    thread lib_0367::func_8E3C(var_01);
  }
}

vo_plane_killed_reaction() {
  self.plane_vo_reaction = 1;
  wait(2.5);
  self.plane_vo_reaction = 0;
}

vo_players_half_way_done() {
  var_00 = [];
  foreach(var_02 in level.players) {
    if(var_02 isusingturret()) {
      var_00 = common_scripts\utility::func_F6F(var_00, var_02);
    }
  }

  var_02 = common_scripts\utility::func_7A33(var_00);
  if(isDefined(var_02)) {
    var_02 thread lib_0367::func_8E3C("planemore");
  }

  common_scripts\utility::func_3C8F("flag_planes_half_way_done");
}

______________razer_gun_assembly_____________() {}

quest_init_razergun_assembly() {
  razergun_bench_init();
  level thread maps\mp\_utility::func_6F74(::comment_on_workbench_vo);
  level thread razergun_parts_collect();
  var_00 = common_scripts\utility::func_46B7("weapon_assembly_bench", "targetname");
  foreach(var_02 in var_00) {
    var_02 thread manage_bench_trigger();
    var_02 thread razergun_build_melee();
    var_02 thread razergun_build_ranged();
  }

  level thread activate_workbench_on_parts_placed();
  common_scripts\utility::func_3C9F(lib_0557::func_7838("explore_the_island", "Explore Pen"));
  common_scripts\utility::func_3C8F("Commence Weapon Assembly");
}

comment_on_workbench_vo() {
  self endon("death");
  self endon("disconnect");
  var_00 = common_scripts\utility::func_46B5("weapon_assembly_bench", "targetname");
  while(distance(self.origin, var_00.origin) > var_00.var_14F || abs(var_00.origin[2] - self.origin[2]) > var_00.height) {
    lib_0547::func_A6F6();
  }

  thread lib_0367::func_8E3C("weaponbenchtouch");
}

manage_bench_trigger() {
  common_scripts\utility::func_3CA2("players_have_razergun_1", "players_have_razergun_2");
  self.assembly_trig setHintString(&"ZOMBIE_ISLAND_PART_PLACE");
  common_scripts\utility::func_3CA2("razergun_1_placed", "razergun_2_placed");
  self.assembly_trig common_scripts\utility::func_9D9F();
  common_scripts\utility::func_3CA0("players_have_razergun_1", "players_have_razergun_2");
  self.assembly_trig common_scripts\utility::func_9DA3();
  common_scripts\utility::func_3CA0("razergun_1_placed", "razergun_2_placed");
  self.assembly_trig setHintString(&"ZOMBIES_EMPTY_STRING");
  self.assembly_trig makeunusable();
  foreach(var_01 in self.assembly_ranged_trigs) {
    if(isDefined(var_01)) {
      var_01 makeusable();
      if(lib_0547::func_5819(var_01)) {
        lib_0547::func_8A4F(var_01, ::razergun_bench_assign_trig);
      }

      var_01 thread razergun_bench_assemble_think();
    }
  }

  common_scripts\utility::func_3C9F("razergun_3_placed");
  foreach(var_01 in self.assembly_ranged_trigs) {
    var_01 makeunusable();
  }

  common_scripts\utility::func_3C9F("razergun_charged");
  self.assembly_trig makeusable();
  common_scripts\utility::func_3C9F("razergun_infused");
  self.assembly_trig makeunusable();
  foreach(var_01 in self.assembly_ranged_trigs) {
    var_01 makeusable();
  }
}

activate_workbench_on_parts_placed() {
  common_scripts\utility::func_3CA0("razergun_1_placed", "razergun_2_placed");
  common_scripts\utility::func_3C8F("Commence Weapon Assembly");
}

quest_step_build_razergun_1() {
  common_scripts\utility::func_3CA0("players_have_razergun_1", "players_have_razergun_2");
  lib_0557::func_7822("Aquire Wonder Weapon", lib_0557::removed_quest_hint());
  common_scripts\utility::func_3CA0("razergun_1_placed", "razergun_2_placed");
  lib_0557::func_782D("Aquire Wonder Weapon", "Melee Razor Gun Built");
}

quest_step_build_razergun_2() {
  common_scripts\utility::func_3C9F("players_have_razergun_3");
  lib_0557::func_7822("Aquire Wonder Weapon", lib_0557::removed_quest_hint());
  common_scripts\utility::func_3C9F("razergun_3_placed");
  lib_0557::func_7822("Aquire Wonder Weapon", lib_0557::removed_quest_hint());
  common_scripts\utility::func_3C9F("razergun_infused");
  lib_0557::func_782D("Aquire Wonder Weapon", "Ranged Razor Gun Built");
}

razergun_build_melee() {
  var_00 = 0;
  var_01 = 1;
  thread razergun_build_part(self.assembly_model_2, "razergun_1_placed", "players_have_razergun_1");
  thread razergun_build_part(self.assembly_model_1, "razergun_2_placed", "players_have_razergun_2");
  common_scripts\utility::func_3CA0("razergun_1_placed", "razergun_2_placed");
  var_02 = [self.assembly_model_1, self.assembly_model_2];
  var_03 = getEnt("ripsaw_bench", "targetname");
  playFX(level.var_611["zmb_isl_sawrack_charge_pnt"], var_03.origin, anglesToForward(var_03.angles));
  lib_0378::func_8D74("ripsaw_weapon_build_infusion", var_03.origin);
}

razergun_build_melee_reward() {
  if(!common_scripts\utility::func_3C77("razergun_1_placed")) {
    common_scripts\utility::func_3C8F("razergun_1_placed");
  }

  if(!common_scripts\utility::func_3C77("razergun_2_placed")) {
    common_scripts\utility::func_3C8F("razergun_2_placed");
  }

  if(!common_scripts\utility::func_3C77("players_have_razergun_1")) {
    common_scripts\utility::func_3C8F("players_have_razergun_1");
  }

  if(!common_scripts\utility::func_3C77("players_have_razergun_2")) {
    common_scripts\utility::func_3C8F("players_have_razergun_2");
  }

  foreach(var_01 in level.players) {
    var_01 maps\mp\zombies\_zombies_rank::func_AC23("razergunmelee");
    var_01 lib_0378::func_8D74("objective_complete", "razergunmelee");
  }
}

razergun_build_ranged() {
  lib_0557::func_7870("Aquire Wonder Weapon", "Melee Razor Gun Built");
  var_00 = 0;
  var_01 = 1;
  common_scripts\utility::func_3C9F("razergun_3_placed");
  self.assembly_model_3 show();
  self.assembly_model_3 lib_0378::func_8D74("ripsaw_insert_charged_spine");
  if(!common_scripts\utility::func_3C77("razergun_charged")) {
    thread razergun_bench_charge();
    common_scripts\utility::func_3C9F("razergun_charged");
  }

  if(!common_scripts\utility::func_3C77("razergun_infused")) {
    thread razergun_bench_infuse();
    common_scripts\utility::func_3C9F("razergun_infused");
  }

  level thread maps / mp / gametypes / zombies::orders_and_contracts_report_event("geistcraft_device_powered");
  var_02 = [self.assembly_model_1, self.assembly_model_2, self.assembly_model_3];
  var_03 = getEnt("ripsaw_bench", "targetname");
  playFX(level.var_611["zmb_isl_sawrack_charge_pnt"], var_03.origin, anglesToForward(var_03.angles));
  lib_0378::func_8D74("ripsaw_weapon_build_infusion", var_03.origin);
}

razergun_build_ranged_reward() {
  if(!common_scripts\utility::func_3C77("razergun_3_placed")) {
    common_scripts\utility::func_3C8F("razergun_3_placed");
  }

  if(!common_scripts\utility::func_3C77("razergun_charged")) {
    common_scripts\utility::func_3C8F("razergun_charged");
  }

  if(!common_scripts\utility::func_3C77("razergun_infused")) {
    common_scripts\utility::func_3C8F("razergun_infused");
  }

  if(!common_scripts\utility::func_3C77("players_have_razergun_3")) {
    common_scripts\utility::func_3C8F("players_have_razergun_3");
  }

  if(!common_scripts\utility::func_3C77("razergun_half_charged")) {
    common_scripts\utility::func_3C8F("razergun_half_charged");
  }

  foreach(var_01 in level.players) {
    var_01 maps\mp\zombies\_zombies_rank::func_AC23("razergunranged");
    var_01 lib_0378::func_8D74("objective_complete", "razergunranged");
  }

  thread head_corpse_razer_gun_vo();
}

razergun_bench_init() {
  var_00 = common_scripts\utility::func_46B7("weapon_assembly_bench", "targetname");
  foreach(var_02 in var_00) {
    var_03 = common_scripts\utility::func_44BE(var_02.target, "targetname");
    foreach(var_05 in var_03) {
      switch (var_05.script_noteworthy) {
        case "assembly_bench_trig":
          var_02.assembly_trig = var_05;
          break;

        case "assembly_bench_ranged_trig":
          if(!isDefined(var_02.assembly_ranged_trigs)) {
            var_02.assembly_ranged_trigs = [];
          }

          var_02.assembly_ranged_trigs[var_02.assembly_ranged_trigs.size] = var_05;
          var_05 makeunusable();
          break;

        case "assembly_bench_weap_model_1":
          var_02.assembly_model_1 = var_05;
          var_02.assembly_model_1 hide();
          break;

        case "assembly_bench_weap_model_2":
          var_02.assembly_model_2 = var_05;
          var_02.assembly_model_2 hide();
          break;

        case "assembly_bench_weap_model_3":
          var_02.assembly_model_3 = var_05;
          var_02.assembly_model_3 hide();
          break;

        case "assembly_bench_weap_model_4":
          var_02.assembly_model_4 = var_05;
          var_02.assembly_model_4 hide();
          break;

        case "assembly_bench_weap_power_transfer":
          var_02.soul_collection_ent = var_05;
          break;
      }
    }

    var_07 = function_021F(var_02.target, "targetname");
    foreach(var_09 in var_07) {
      var_0A = var_09 method_85CE();
      switch (var_0A) {
        case "animated_zmi_workbench_gauge":
          var_02.soul_meter = var_09;
          var_02.soul_meter thread razergun_bench_display_voltage();
          break;
      }
    }
  }
}

razergun_bench_assign_trig(param_00) {
  thread razergun_bench_update_hint(param_00);
}

razergun_bench_update_hint(param_00) {
  param_00 endon("disconnect");
  var_01 = 1;
  var_02 = 0;
  wait(1);
  var_03 = lib_0552::func_7BE1(param_00, self, 0);
  var_03.var_2F74 = 1;
  var_03.var_6642 = 1;
  var_04 = 0;
  for(;;) {
    waittillframeend;
    var_05 = param_00 wait_for_workbench_message();
    if(common_scripts\utility::func_3C77("razergun_infused")) {
      var_03 update_workbench_prompt_for(param_00, "razergun_zm", "razergun_saw_gun_buy_state");
      continue;
    }

    if(common_scripts\utility::func_3C77("razergun_charged")) {
      var_03.var_2F74 = 0;
      var_03.var_6642 = 1;
      var_03.var_4028 = lib_0552::func_44FF("razergun_saw_gun_infuse_state");
      continue;
    }

    if(common_scripts\utility::func_3C77("razergun_3_placed")) {
      var_04 = 0;
      var_03.var_2F74 = 1;
      var_03.var_6642 = 1;
      continue;
    }

    if(common_scripts\utility::func_3C77("razergun_2_placed")) {
      var_06 = param_00 getcurrentweapon();
      if(issubstr(var_06, "spine_inspect") && !issubstr(var_06, "depleted")) {
        var_03.var_4028 = lib_0552::func_44FF("razergun_saw_part_place");
        var_03.var_2F74 = 0;
        var_03.var_401E = 0;
        var_04 = 1;
        var_03.var_6642 = 1;
      }

      if((isDefined(var_05) && var_05 == "spine_destroyed") || var_04 && issubstr(var_06, "spine_inspect") && issubstr(var_06, "depleted")) {
        var_04 = 0;
      }

      if(!var_04) {
        var_03 update_workbench_prompt_for(param_00, "razergun_melee_zm", "razergun_saw_buy_state");
      }

      continue;
    }

    wait(0.1);
  }
}

update_workbench_prompt_for(param_00, param_01, param_02) {
  if(common_scripts\utility::func_F79(param_00 getweaponslistall(), param_01)) {
    self.var_2F74 = 1;
  } else {
    self.var_2F74 = 0;
    self.var_4028 = lib_0552::func_44FF(param_02);
    self.var_401E = param_00 get_razergun_cost_for_player(param_01);
  }

  self.var_6642 = 1;
}

get_razergun_cost_for_player(param_00) {
  var_01 = self;
  if(param_00 == "razergun_melee_zm") {
    return 2500;
  }

  var_02 = var_01 getweaponslistall();
  if(common_scripts\utility::func_F79(var_02, "razergun_melee_zm")) {
    return 500;
  }

  return 3000;
}

wait_for_workbench_message() {
  self endon("disconnect");
  if(!common_scripts\utility::func_562E(self.inited_state)) {
    self.inited_state = 1;
    return "init";
  }

  var_00 = spawnStruct();
  childthread wait_for_player_message(var_00);
  level childthread wait_for_level_message(var_00);
  var_00 waittill("message", var_01);
  return var_01;
}

wait_for_player_message(param_00) {
  param_00 endon("message");
  var_01 = common_scripts\utility::waittill_any_return_no_endon_death("spine_collected", "spine_destroyed", "weapon_change", "new_equipment");
  param_00 notify("message", var_01);
}

wait_for_level_message(param_00) {
  param_00 endon("message");
  level common_scripts\utility::waittill_any("razergun_1_placed", "razergun_2_placed", "razergun_3_placed", "razergun_charged", "razergun_infused");
  param_00 notify("message", "objective_update");
}

wait_for_ranged_weapon_reveal() {
  level endon("razergun_infused");
  common_scripts\utility::waittill_any("weapon_change", "new_equipment");
}

razergun_bench_infuse() {
  self.assembly_trig waittill("trigger", var_00);
  common_scripts\utility::func_3C8F("razergun_infused");
}

razergun_bench_charge() {
  self.soul_collection_ent maps / mp / mp_zombies_soul_collection::func_170B(10, 400, 64, "razergun_soul_collection", undefined, "tag_origin", undefined, "tag_origin", undefined, self.soul_collection_ent, (0, 0, 64));
  common_scripts\utility::func_3C8F("razergun_half_charged");
  self.soul_collection_ent maps / mp / mp_zombies_soul_collection::func_170B(15, 400, 64, "razergun_soul_collection", undefined, "tag_origin", undefined, "tag_origin", undefined, self.soul_collection_ent, (0, 0, 64));
  common_scripts\utility::func_3C8F("razergun_charged");
}

razergun_bench_display_voltage() {
  self setscriptablepartstate("main", "off");
  common_scripts\utility::func_3C9F("razergun_half_charged");
  self setscriptablepartstate("main", "mid_on");
  wait(2.866667);
  self setscriptablepartstate("main", "mid_on_idle");
  common_scripts\utility::func_3C9F("razergun_charged");
  self setscriptablepartstate("main", "full_on");
  wait(3.033333);
  self setscriptablepartstate("main", "full_on_idle");
  common_scripts\utility::func_3C9F("razergun_infused");
  self setscriptablepartstate("main", "discharge");
  wait(0.5333334);
  self setscriptablepartstate("main", "off");
}

razergun_bench_assemble_think(param_00) {
  level endon("game_ended");
  for(;;) {
    var_01 = lib_0547::func_A795();
    var_02 = var_01[0];
    var_03 = var_01[1];
    if(!isalive(var_02)) {
      continue;
    }

    if(!common_scripts\utility::func_3C77("razergun_3_placed")) {
      if(!isDefined(var_02.spine_curret)) {
        if(!var_02 attempt_to_buy_razergun("razergun_melee_zm")) {
          continue;
        }

        var_02 lib_0586::func_78C("razergun_melee_zm");
        var_02 lib_0586::func_78E("razergun_melee_zm");
        var_02 thread show_razergun_instructions();
        var_02 thread nag_razergun_could_be_better();
      } else {
        var_02 maps / mp / zquests / casual / island_ee_util::spine_player_clear_data();
        common_scripts\utility::func_3C8F("players_have_razergun_3");
        common_scripts\utility::func_3C8F("razergun_3_placed");
        var_02 thread lib_0367::func_8E3C("workbenchuber");
      }

      continue;
    }

    if(!var_02 attempt_to_buy_razergun("razergun_zm")) {
      continue;
    }

    var_02 notify("acquired ripsaw ranged");
    var_02.isupgradingrazergunmodel = 1;
    var_02 lib_0586::func_78C("razergun_zm");
    var_02 lib_0586::func_78E("razergun_zm");
    wait 0.05;
    var_02.isupgradingrazergunmodel = 0;
    var_02 thread show_razergun_instructions();
  }
}

attempt_to_buy_razergun(param_00) {
  return !common_scripts\utility::func_F79(self getweaponslistall(), param_00) && maps / mp / gametypes / zombies::func_11C2(get_razergun_cost_for_player(param_00));
}

show_razergun_instructions() {
  var_00 = maps\mp\gametypes\_hud_util::createfontstring("default", 1);
  var_00 maps\mp\gametypes\_hud_util::setpoint("CENTER", undefined, 0, -30);
  var_00.label = &"ZOMBIE_ISLAND_RAZERGUN_HINT";
  wait(2.45);
  var_00 destroy();
}

nag_razergun_could_be_better() {
  self endon("death");
  self endon("disconnect");
  self endon("acquired ripsaw ranged");
  self notify("new ripsaw nag");
  self endon("new ripsaw nag");
  wait(4.1);
  thread lib_0367::func_8E3C("build_ripsawbase");
  wait(9);
  thread lib_0367::func_8E3C("harvestfog");
  for(;;) {
    wait(180 + randomint(300));
    thread lib_0367::func_8E3C("harvestfog");
    wait(420 + randomint(180));
    thread lib_0367::func_8E3C("build_ripsawbase");
  }
}

razergun_part_1_collected(param_00, param_01) {
  level thread common_scripts\_exploder::func_2A6D(222, undefined, 0);
  common_scripts\utility::func_3C8F("players_have_razergun_2");
  lib_0378::func_8D74("ripsaw_collect_gun_chassis", param_01);
  if(isDefined(param_00)) {
    param_00 thread play_razergun_part_vo(1);
  }
}

razergun_part_2_collected(param_00, param_01) {
  level thread common_scripts\_exploder::func_2A6D(221, undefined, 0);
  common_scripts\utility::func_3C8F("players_have_razergun_1");
  lib_0378::func_8D74("ripsaw_collect_saw_blade", param_01);
  if(isDefined(param_00)) {
    param_00 thread play_razergun_part_vo();
  }
}

play_razergun_part_vo(param_00) {
  self endon("disconnect");
  self endon("death");
  if(common_scripts\utility::func_562E(param_00)) {
    lib_0367::func_8E3C("ripsawpart");
  }

  wait(1.75);
  if(common_scripts\utility::func_3C77("players_have_razergun_1") && common_scripts\utility::func_3C77("players_have_razergun_2")) {
    thread lib_0367::func_8E3C("ripsaw_both");
  }
}

razergun_build_part(param_00, param_01, param_02) {
  common_scripts\utility::func_3C9F(param_02);
  self.assembly_trig thread razergun_wait_for_interact(param_01);
  common_scripts\utility::func_3C9F(param_01);
  param_00 show();
  if(param_00 == self.assembly_model_1) {
    param_00 lib_0378::func_8D74("ripsaw_insert_chassis");
    return;
  }

  if(param_00 == self.assembly_model_2) {
    param_00 lib_0378::func_8D74("ripsaw_insert_sawblade");
  }
}

razergun_wait_for_interact(param_00) {
  self waittill("trigger", var_01);
  common_scripts\utility::func_3C8F(param_00);
}

razergun_bench_all_parts_shown() {
  var_00 = 0;
  if(common_scripts\utility::func_562E(self.assembly_model_1.var_8BE)) {
    var_00++;
  }

  if(common_scripts\utility::func_562E(self.assembly_model_2.var_8BE)) {
    var_00++;
  }

  if(common_scripts\utility::func_562E(self.assembly_model_3.var_8BE)) {
    var_00++;
  }

  return var_00 == 3;
}

razergun_parts_collect() {
  razergun_blade_handle_pickup();
  razergun_stock_handle_pickup();
  common_scripts\utility::func_3CA0("players_have_razergun_1", "players_have_razergun_2");
  lib_0557::func_782D("explore_the_island", "Explore Pen");
}

add_zombie_part_glint(param_00, param_01, param_02) {
  var_03 = spawnStruct();
  var_03.var_3F74 = param_00;
  var_03.var_378F = param_01;
  var_03.var_95AA = param_02;
  level thread maps\mp\_utility::func_6F74(::handleplayerglintlookat, var_03);
  return var_03;
}

remove_zombie_part_glint(param_00) {
  param_00 notify("glint_removed");
}

handleplayerglintlookat(param_00) {
  self endon("death");
  self endon("disconnect");
  toggle_glint_visiblity(param_00);
  param_00.var_378F method_8511();
  function_0294(common_scripts\utility::func_44F5(param_00.var_3F74), param_00.var_378F, param_00.var_95AA, self);
}

toggle_glint_visiblity(param_00) {
  self endon("death");
  self endon("disconnect");
  playfxontagforclients(common_scripts\utility::func_44F5(param_00.var_3F74), param_00.var_378F, param_00.var_95AA, self);
  param_00 waittill("glint_removed");
}

wait_for_player_facing(param_00, param_01, param_02) {
  self endon("death");
  self endon("disconnect");
  for(;;) {
    wait 0.05;
    var_03 = maps\mp\_utility::func_3B8E(self, param_00, param_02);
    if(!param_01) {
      var_03 = !var_03;
    }

    if(var_03) {
      return;
    }
  }
}

razergun_blade_handle_pickup() {
  var_00 = getEntArray("grab_razergun_blade", "targetname");
  foreach(var_02 in var_00) {
    var_02 thread razergun_part_give_on_pickup(::razergun_part_1_collected, undefined, "pickup_saw_blade");
  }

  thread sawblade_corpse_vo();
}

sawblade_corpse_vo() {
  common_scripts\utility::func_3C9F("start_to_right_climb");
  var_00 = getEnt("grab_razergun_blade", "targetname");
  if(!isDefined(var_00)) {
    return;
  }

  var_00 endon("death");
  while(!common_scripts\utility::func_3C77("players_have_razergun_2")) {
    foreach(var_02 in level.players) {
      if(distance(var_02.origin, var_00.origin) > 250 || common_scripts\utility::func_562E(var_02.var_806F)) {
        continue;
      }

      var_02 lib_0367::func_8E3D("bloodtrailtwo_both");
      var_02.var_806F = 1;
    }

    wait(1);
  }
}

razergun_stock_handle_pickup() {
  var_00 = getEnt("grab_razergun_stock", "targetname");
  var_01 = common_scripts\utility::func_46B7("ripsaw_frame_position", "script_noteworthy");
  var_02 = common_scripts\utility::func_7A33(var_01);
  var_00.origin = var_02.origin;
  var_03 = spawn("script_model", var_02.origin);
  var_03 setModel("zmi_ripsaw_parts_01");
  var_03.angles = var_02.angles;
  wait 0.05;
  var_00 thread razergun_part_give_on_pickup(::razergun_part_2_collected, var_03, "pickup_saw_stock");
}

razergun_part_give_on_pickup(param_00, param_01, param_02) {
  while(!isDefined(level.var_47DD)) {
    wait 0.05;
  }

  lib_0559::func_7BE3(self, param_02);
  if(!isDefined(param_01) && isDefined(self.target)) {
    param_01 = getEnt(self.target, "targetname");
  }

  var_03 = add_zombie_part_glint("zmb_isl_rzgun_pickup_glint2", param_01, "tag_origin");
  self setHintString(&"ZOMBIE_ISLAND_PART_PICKUP");
  self usetouchtriggerrequirefacingposition(1, param_01.origin);
  self waittill("trigger", var_04);
  [[param_00]](var_04, param_01.origin);
  remove_zombie_part_glint(var_03);
  common_scripts\utility::func_9D9F();
}

______________radio_____________() {}

quest_init_radio() {
  hide_radio();
  thread radio_part_corpse_listener();
}

quest_step_radio_find() {
  var_00 = undefined;
  var_01 = [];
  foreach(var_03 in level.cuttable_ropes) {
    var_01[var_01.size] = var_03.my_box;
  }

  var_05 = getEnt("radio_corpse_trig", "targetname");
  if(isDefined(var_05) && isDefined(var_05.target)) {
    var_01[var_01.size] = getEnt(var_05.target, "targetname");
  }

  if(var_01.size > 0) {
    var_06 = lib_0557::func_782F(undefined, var_01);
    lib_0557::func_781D("Interact with radio", var_06);
  }

  lib_0367::snd_zmb_plr_dlg_play_line_on_each_player("airstrike_both");
  common_scripts\utility::func_3CA0("flag_radio_part_1_collected", "flag_radio_part_2_collected");
  lib_0557::func_782D("Interact with radio", "Find Missing Part");
}

quest_step_crashed_plane_find() {
  var_00 = undefined;
  var_01 = [];
  foreach(var_03 in level.cuttable_ropes) {
    var_01[var_01.size] = var_03.my_box;
  }

  var_05 = getEnt("radio_corpse_trig", "targetname");
  if(isDefined(var_05) && isDefined(var_05.target)) {
    var_01[var_01.size] = getEnt(var_05.target, "targetname");
  }

  common_scripts\utility::func_3C9F("flag_radio_part_2_collected");
  maps / mp / mp_zombie_island_ee_fog_manager::unlock_fog_from_lock();
}

quest_step_radio_place() {
  var_00 = getEnt("radio_placement_trigger", "targetname");
  var_00 setHintString(&"ZOMBIE_ISLAND_RADIO_ASSEMBLE");
  var_01 = getEntArray("radio_table_equipment", "script_noteworthy");
  var_02 = lib_0557::func_782F(undefined, var_01);
  lib_0557::func_781D("Interact with radio", var_02);
  var_03 = common_scripts\utility::func_7A33(level.players);
  if(isDefined(var_03)) {
    var_03 thread lib_0367::func_8E3C("radiopartsall");
  }

  var_00 waittill("trigger", var_04);
  var_00 lib_0378::func_8D74("radio_parts_assemble");
  var_00 setHintString(&"ZOMBIES_EMPTY_STRING");
  show_radio();
  level thread radio_dialogue_tower(var_04);
  lib_0557::func_782D("Interact with radio", "Place Radio");
}

set_radio_part_2_found() {
  common_scripts\utility::func_3C8F("flag_radio_part_2_collected");
}

radio_part_corpse_listener() {
  var_00 = getEnt("radio_corpse_trig", "targetname");
  if(!isDefined(var_00)) {
    return;
  }

  var_01 = getEnt(var_00.target, "targetname");
  var_00 setHintString(&"ZOMBIE_ISLAND_RADIO_PART_PICKUP");
  var_00 thread radio_corpse_vo();
  var_00 waittill("trigger", var_02);
  var_02 thread lib_0367::func_8E3C("radioparts", level.players);
  var_01 delete();
  var_00 delete();
  common_scripts\utility::func_3C8F("flag_radio_part_1_collected");
}

radio_corpse_vo() {
  var_00 = self;
  if(!isDefined(var_00)) {
    return;
  }

  var_00 endon("death");
  common_scripts\utility::func_3C9F("start_to_right_climb");
  for(;;) {
    foreach(var_02 in level.players) {
      if(distance(var_02.origin, var_00.origin) > 250 || common_scripts\utility::func_562E(var_02.saw_radio)) {
        continue;
      }

      var_02 lib_0367::func_8E3D("deadreangerfind");
      var_02.saw_radio = 1;
    }

    wait(1);
  }
}

blood_trail_vo() {
  common_scripts\utility::func_3C9F("start_to_right_climb");
  var_00 = common_scripts\utility::func_46B5("vo_blood_trail_point", "targetname");
  if(!isDefined(var_00)) {
    return;
  }

  while(!common_scripts\utility::func_3C77("players_have_razergun_2")) {
    foreach(var_02 in level.players) {
      if(distance(var_02.origin, var_00.origin) > 1000 || !var_02 zombies_look_at(var_00) || common_scripts\utility::func_562E(var_02.saw_blood_trail)) {
        continue;
      }

      var_02 lib_0367::func_8E3D("bloodtrailfollow_both");
      var_02.saw_blood_trail = 1;
    }

    wait(2);
  }
}

plane_wreckage_radio_vo() {
  common_scripts\utility::func_3C9F("flag_players_have_won");
  var_00 = getEnt("rope_box", "script_noteworthy");
  if(!isDefined(var_00)) {
    return;
  }

  var_00 endon("death");
  while(!common_scripts\utility::func_3C77("flag_radio_part_2_collected")) {
    foreach(var_02 in level.players) {
      if(!var_02 zombies_look_at(var_00) || common_scripts\utility::func_562E(var_02.saw_wreckage_radio)) {
        continue;
      }

      var_02 lib_0367::func_8E3D("planeclue");
      var_03 = var_02 method_82D5();
      if(issubstr(var_03, "razergun_zm") == 0) {
        var_02 lib_0367::func_8E3D("planecrashlook");
      }

      var_02.saw_wreckage_radio = 1;
    }

    wait(2);
  }
}

zombies_look_at(param_00) {
  var_01 = param_00.origin;
  var_02 = self getEye();
  var_03 = vectorNormalize(var_01 - var_02);
  var_04 = vectorNormalize(anglesToForward(self geteyeangles()));
  var_05 = vectordot(var_03, var_04);
  wait 0.05;
  var_06 = acos(clamp(var_05, -1, 1));
  if(var_06 < 25 && distance(var_01, var_02) < 420) {
    return 1;
  }

  return 0;
}

hide_radio() {
  var_00 = getEnt("radio_placement_trigger", "targetname");
  var_01 = getEnt(var_00.target, "targetname");
  var_01 hide();
}

show_radio() {
  var_00 = getEnt("radio_placement_trigger", "targetname");
  var_01 = getEnt(var_00.target, "targetname");
  var_01 show();
}

radio_dialogue_tower(param_00) {
  param_00 lib_0367::func_8E3C("radiotransmission", level.players);
  var_01 = common_scripts\utility::func_46B5("struct_radio_dialogue", "targetname");
  var_02 = spawn("script_model", var_01.origin);
  var_02 setModel("tag_origin");
  var_02.radio_talk_snd = lib_0380::func_288B("zmb_isla_comd_altyourmessagehasbeenrece", undefined, var_02);
  lib_0380::func_288F(var_02.radio_talk_snd, var_02, "radio_line_done");
  var_02 waittill("radio_line_done");
  wait(0.85);
  maps / mp / mp_zombie_island_straub_pa_events::pa_system_dialogue_all_players("zmb_isla_stra_10secondsofangrygermanswe", 0);
  maps / mp / mp_zombie_island_straub_pa_events::pa_system_dialogue_all_players("zmb_isla_stra_soyousurvivedthehellofmit", 0);
  maps / mp / mp_zombie_island_straub_pa_events::pa_system_dialogue_all_players("zmb_isla_stra_youandyouralliedcomradesa", 0);
  common_scripts\utility::func_3C8F("spawn_ships_ee_destroyer_attacker");
  maps / mp / mp_zombie_island_straub_pa_events::pa_system_dialogue_all_players("zmb_isla_stra_welljustlikeinbavariayoua", 0);
  maps / mp / mp_zombie_island_straub_pa_events::pa_system_dialogue_all_players("zmb_isla_stra_thebrittishplanesaredoome");
  common_scripts\utility::func_3C8F("spawn_ships_straub_monologue_complete");
  var_02 delete();
}

______________destroyers_____________() {}

quest_init_destroyers() {
  lib_0547::func_7BA9(::artillery_zombie_listener);
  level thread spawn_ships();
  level thread ambient_straub_pa_dialog();
  level thread spawn_bomber_escort_setup();
}

artillery_zombie_listener(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(lib_0547::func_5565(level.escort_bomber, self)) {
    level.escort_bomber = undefined;
    if(common_scripts\utility::func_3C77("flag_hc_bomb_escort_complete")) {
      lib_0547::func_2D8C(::artillery_zombie_listener);
    }
  }
}

quest_step_escort_loader() {
  while(!isDefined(level.artillery_power_source_model)) {
    wait 0.05;
  }

  lib_0557::func_782D("Destroy 2nd Destroyer", "Find Artillery Ammo");
}

quest_step_get_destroyer1_hits() {
  for(var_00 = 0; var_00 < 3; var_00++) {
    level waittill("destoyer_2_hit");
    wait 0.05;
    if(level.artillery_ee_ships.size < 1) {
      break;
    }
  }

  lib_0557::func_782D("Destroy 2nd Destroyer", "1st Ship Destroyed");
  common_scripts\utility::func_3C8F("flag_destroyers_quest_complete");
}

quest_step_charge_artillery_ammo() {
  common_scripts\utility::func_3C9F("flag_destroyers_quest_complete");
  lib_0557::func_782D("Artillery Ammo", "Charge Artillery Ammo");
}

destoyer_add_hit() {
  level notify("destoyer_2_hit");
}

summon_artillery_loader_control_think() {
  var_00 = self;
  var_00 setHintString(&"ZOMBIE_ISLAND_SUMMON_ARTILLERY_LOADER");
  var_01 = function_021F("zombie_loader_control", "targetname");
  for(;;) {
    common_scripts\utility::func_3C9F("flag_crane_in_motion");
    var_00 setHintString(&"ZOMBIE_ISLAND_SUMMON_ARTILLERY_LOADER_UNAVAILABLE");
    self.var_82EF thread activate_machine();
    while(common_scripts\utility::func_3C77("flag_crane_in_motion")) {
      self.var_82EF setscriptablepartstate("light", "off");
      wait(0.5);
      self.var_82EF setscriptablepartstate("light", "green");
      wait(0.5);
    }

    if(isDefined(level.escort_bomber) && common_scripts\utility::func_562E(level.zmb_island_escorts_wave_penalty)) {
      self.var_82EF setscriptablepartstate("light", "red");
      maps / mp / zquests / casual / island_ee_util::wait_one_round_bomber();
      while(level.freezer_crane.var_931A == "request_retrieve") {
        wait 0.05;
      }

      common_scripts\utility::func_3CA9("flag_crane_in_motion");
    }

    if(common_scripts\utility::func_3C77("flag_loader_zombie_unavailable")) {
      common_scripts\utility::func_3CA9("flag_loader_zombie_unavailable");
    }

    var_02 = self.var_82EF getscriptablepartstate("light");
    var_00 setHintString(&"ZOMBIE_ISLAND_SUMMON_ARTILLERY_LOADER");
    if(var_02 != "green") {
      self.var_82EF setscriptablepartstate("light", "green");
    }
  }
}

activate_machine() {
  self setscriptablepartstate("machine_main", "activate");
  wait(3.866667);
  self setscriptablepartstate("machine_main", "idle");
}

ambient_straub_pa_dialog() {
  level endon("flag_destroyers_quest_complete");
  common_scripts\utility::func_3C9F("spawn_ships_straub_monologue_complete");
  thread maps / mp / mp_zombie_island_straub_pa_events::ambient_straub_pa_dialog_cleanup();
  wait(100);
  maps / mp / mp_zombie_island_straub_pa_events::play_straub_story_5();
  wait(20);
  maps / mp / mp_zombie_island_straub_pa_events::play_straub_story_6();
  wait(20);
  maps / mp / mp_zombie_island_straub_pa_events::play_straub_story_7();
}

spawn_bomber_escort_setup() {
  var_00 = collect_bomber_waypoints_1();
  var_01 = collect_bomber_waypoints_oberland();
  var_02 = 1;
  var_03 = getEnt("trig_control_interact_call_bomber", "script_noteworthy");
  if(isDefined(var_03.target)) {
    var_03.face_targ = common_scripts\utility::func_46B5(var_03.target, "targetname");
    if(isDefined(var_03.face_targ)) {
      var_03 usetouchtriggerrequirefacingposition(1, var_03.face_targ.origin);
    }

    var_04 = function_021F(var_03.target, "targetname");
    if(isDefined(var_04) && var_04.size > 0) {
      var_03.var_82EF = var_04[0];
      var_03.var_82EF setscriptablepartstate("light", "green");
    }

    var_03 common_scripts\utility::func_3799("freezer_machine_working");
    var_03 thread summon_artillery_loader_control_think();
  }

  while(!isDefined(level.var_A980) || level.var_A980 < 1) {
    wait(0.125);
  }

  var_05 = 0;
  while(!common_scripts\utility::func_3C77("flag_loader_complete")) {
    var_03 common_scripts\utility::func_9DA3();
    var_03 waittill("trigger", var_06);
    var_03 common_scripts\utility::func_9D9F();
    if(!lib_0547::is_power_on(var_06)) {
      continue;
    }

    if(common_scripts\utility::func_3C77("flag_crane_in_motion") || level.freezer_crane.var_931A == "request_retrieve" || common_scripts\utility::func_3C77("flag_loader_zombie_unavailable") || common_scripts\utility::func_3C77("flag_bomber_wave_punished")) {
      continue;
    }

    var_07 = level.var_A980;
    level notify("freezeer_summon_zombie", "escort_bomber");
    if(var_05 == 0) {
      lib_0367::snd_zmb_plr_dlg_play_line_on_each_player("freezer");
      maps\mp\_utility::func_2CED(5, ::lib_0367::snd_zmb_plr_dlg_play_line_on_each_player, "subpencrates2");
      var_05 = 1;
    }

    if(common_scripts\utility::func_3C77("flag_hc_bomb_escort_complete")) {
      level waittill("freezer_zombie_placed", var_08);
      waittill_ent_death_timeout(var_08, "death", 120);
      continue;
    }

    common_scripts\utility::func_3C8F("flag_loader_zombie_unavailable");
    var_03 common_scripts\utility::func_379A("freezer_machine_working");
    level waittill("freezer_zombie_placed", var_08);
    maps / mp / mp_zombie_nest_ee_wave_manipulation::func_8606();
    var_08 thread set_zone_locked_on_me();
    level.maxed_zombies_sprint = 1;
    var_08 thread make_noise();
    var_03 common_scripts\utility::func_3796("freezer_machine_working");
    if(common_scripts\utility::func_562E(var_02)) {
      var_06 maps\mp\_utility::func_2CED(1.25, ::lib_0367::func_8E3D, "shipbomber");
    }

    var_02 = 0;
    setup_escort_bomber_post_drop(var_08);
    var_09 = level.escort_bomber escort_begin(var_00, var_01);
    maps / mp / mp_zombie_nest_ee_wave_manipulation::func_8607();
    level unset_zone_locked_on_zombie();
    level.maxed_zombies_sprint = 0;
    if(isDefined(var_09) && var_09 == 1) {
      level.escort_bomber on_reached_dest();
      var_03 setHintString("");
      common_scripts\utility::func_3C7B("flag_loader_zombie_unavailable");
      common_scripts\utility::func_3C8F("flag_loader_complete");
      continue;
    }

    if(isDefined(level.escort_bomber)) {
      level.escort_bomber suicide();
      level.escort_bomber = undefined;
    }

    common_scripts\utility::func_3C7B("flag_loader_zombie_unavailable");
    continue;
  }
}

make_noise() {
  self endon("death");
  for(;;) {
    maps / mp / mp_zombie_island_fog_behavior::alarm_fog_zombies(650, self.origin);
    wait(1);
  }
}

planes_enroute_vo() {
  maps / mp / mp_zombie_nest_ee_wave_manipulation::func_8607();
  wait(5);
  lib_0367::snd_zmb_plr_dlg_play_line_on_each_player("nagplanes");
  common_scripts\utility::func_3C8F("flag_straub_finishes_plane_talk");
}

corpse_gate_open_vo() {
  maps / mp / mp_zombie_island_straub_pa_events::pa_system_dialogue_all_players("zmb_isla_stra_didyounoticetheairstripon", 0);
  maps / mp / mp_zombie_island_straub_pa_events::pa_system_dialogue_all_players("zmb_isla_stra_theplanesihaveorderedthem", 0);
  maps / mp / mp_zombie_island_straub_pa_events::pa_system_dialogue_all_players("zmb_isla_stra_thatisoneoftheadvantagest");
}

do_artillery_bomber_hitreaction(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(isPlayer(param_06)) {
    return;
  }

  thread maps / mp / agents / humanoid / _humanoid::func_32B0(param_00, param_01, param_02, param_03, param_04, param_05, param_06);
}

set_zone_locked_on_me() {
  self.lockzoneonme = 1;
  wait_for_termination();
  self.lockzoneonme = undefined;
  level.zmb_locked_spawn_zones = undefined;
}

wait_for_termination() {
  self endon("death");
  level endon("cancel_zone_lock");
  while(self.lockzoneonme) {
    level.zmb_locked_spawn_zones = [get_escort_pressure_zone(lib_055A::func_4562(self.origin))];
    wait(0.125);
  }
}

get_escort_pressure_zone(param_00) {
  var_01 = ["sub_pens_1_zone", "corner_bluffs_zone", "vista_zone_3", "vista_middle_zone", "high_canon"];
  var_02 = param_00;
  for(var_03 = 0; var_03 < var_01.size; var_03++) {
    if(lib_0547::func_5565(param_00, var_01[var_03])) {
      return common_scripts\utility::func_98E7(var_03 == var_01.size - 1, var_01[var_01.size - 1], var_01[var_03 + 1]);
    }
  }

  return var_02;
}

unset_zone_locked_on_zombie() {
  level notify("cancel_zone_lock");
  wait 0.05;
  level.zmb_locked_spawn_zones = undefined;
}

setup_escort_bomber() {
  level.escort_bomber = self;
  level.escort_bomber.escort_zombie = 1;
  level.escort_bomber.isobjectiveexemptfromfog = 1;
  level.escort_bomber.var_6816 = 1;
  level.escort_bomber.var_C29 = 0;
  level.escort_bomber.var_297D = ::maps / mp / zquests / casual / island_ee_util::escort_custom_movemode;
  level.escort_bomber.shouldnotpreventlaststand = 1;
  level.escort_bomber.ispassiveexempt = 1;
  level.escort_bomber.var_55AB = 1;
  level.escort_bomber.shouldnotpreventlaststand = 1;
  level.escort_bomber maps / mp / agents / _agent_utility::func_83FE(level.var_746E);
  level.escort_bomber.ignoreme = 1;
  level.escort_bomber lib_0547::func_8A6D(1);
  level.escort_bomber.var_6734 = 1;
  wait 0.05;
  level.escort_bomber exploder_swap_bomb_for_uber();
  var_00 = int(get_difficulty_setting("zmb_escort_bomber_health"));
  self.var_3937.var_3F22 = 1;
  level.escort_bomber maps / mp / agents / _agent_common::func_83FD(int(var_00));
  level.escort_bomber thread setup_escort_bomber_failsafe();
  level.escort_bomber thread the_classic_ee();
}

the_classic_ee() {
  self endon("death");
  common_scripts\utility::func_92C("moneyCloud", "vfx/gameplay/mp/zombie/gj_pickup_zombies_01_money");
  while(!isDefined(level.var_8AD2)) {
    wait 0.05;
  }

  while(isalive(self)) {
    level waittill("spawned_money_share");
    foreach(var_01 in level.var_8AD2) {
      if(level.the_classic_donation < 1000) {
        childthread tip_bomber_watch(var_01, self);
      }
    }
  }
}

tip_bomber_watch(param_00, param_01) {
  level endon("spawned_money_share");
  while(isalive(param_01)) {
    level endon("the_classic_full_donation");
    if(distance(param_01.origin, param_00.origin) < 50 && !isDefined(param_00.donated_to_bomber)) {
      var_02 = param_00.owner;
      if(!isPlayer(var_02) || !isDefined(param_00.var_8AD3) || param_00.var_8AD3.size == 0) {
        wait 0.05;
        continue;
      }

      var_03 = var_02 getentitynumber();
      var_04 = param_00.var_62D3;
      param_00.donated_to_bomber = 1;
      param_00 maps\mp\zombies\_zombies_money::func_8ADD(var_03, 0);
      thread func_62D8(self.origin);
      param_00.var_6FD4 = 0;
      param_00.var_6FCB = 0;
      level.the_classic_donation = level.the_classic_donation + int(var_04);
      if(level.the_classic_donation >= 1000) {
        maps\mp\zombies\_zombies_magicbox::func_9C8("ppsh41_classic_zm", "extended_mag", "none", "none");
        wait 0.05;
        level notify("the_classic_full_donation");
        return;
      }

      wait 0.05;
      continue;
    }

    wait(0.35);
  }
}

func_62D8(param_00) {
  var_01 = spawnfx(common_scripts\utility::func_44F5("moneyCloud"), param_00);
  triggerfx(var_01);
  wait(3);
  var_01 delete();
}

setup_escort_bomber_post_drop(param_00) {
  param_00.agentname = &"ZOMBIE_ISLAND_LOADER_ZOMBIE_NAME";
  param_00.ignoreme = 0;
  param_00 lib_0547::func_8A6D(0);
  thread maps / mp / zquests / casual / island_ee_util::escort_health_display_start(param_00, -40);
  param_00 thread maps / mp / zquests / casual / island_ee_util::escort_health_display_death_listener();
  param_00 thread maps / mp / zquests / casual / island_ee_util::escort_health_display_damage_listener();
  param_00 thread maps / mp / zquests / casual / island_ee_util::escort_health_display_heal_listener();
  param_00 thread escort_plane_death_think();
}

exploder_swap_bomb_for_uber() {
  self method_802E(self.var_3391, self.var_A99D);
  self.var_3391 = "tag_origin";
  self attach(self.var_3391, self.var_A99D);
}

setup_escort_bomber_failsafe() {
  self endon("death");
  wait(600);
  if(isDefined(self)) {
    self suicide();
  }
}

escort_plane_death_think() {
  var_00 = self;
  var_00 endon("death");
  var_01 = getEnt("vol_escort_bomber_death_setup", "targetname");
  var_02 = getEnt("vol_escort_bomber_death_now", "targetname");
  var_03 = common_scripts\utility::func_46B5("struct_escort_killer", "targetname");
  while(!common_scripts\utility::func_3C77("flag_players_have_won")) {
    if(!isDefined(var_01)) {
      break;
    }

    if(var_00 istouching(var_01)) {
      level.wave_a = function_01DC("plane_start_node_escort_killer", "targetname");
      var_04 = level.wave_a plane_ee_do_spawn_plane_wave();
      var_00 maps / mp / zquests / casual / island_ee_util::waittill_touching(var_02, 1);
      var_05 = spawn("script_model", var_03.origin);
      var_05 setModel("tag_origin");
      var_05 common_scripts\utility::func_3799("turret_on");
      var_05 common_scripts\utility::func_379A("turret_on");
      var_05 lib_0378::func_8D74("aud_plane_firing");
      for(var_06 = 0; var_06 < 12; var_06++) {
        var_05.angles = vectortoangles(var_00.origin - var_05.origin);
        playFXOnTag(level.var_611["zmb_isl_enemy_plane_tracer"], var_05, "TAG_ORIGIN");
        playFXOnTag(level.var_611["zmb_isl_enemy_plane_tracer"], var_05, "TAG_ORIGIN");
        wait(0.2);
      }

      var_05 common_scripts\utility::func_3796("turret_on");
      wait 0.05;
      var_05 delete();
      var_00 suicide();
    }

    wait(1);
  }
}

collect_bomber_waypoints_1() {
  var_00 = common_scripts\utility::func_46B5("artillery_bomber_waypoint_set1_1", "script_noteworthy");
  var_01 = var_00 maps / mp / zquests / casual / island_ee_util::make_array_from_struct_chain();
  return var_01;
}

collect_bomber_waypoints_oberland() {
  var_00 = common_scripts\utility::func_46B5("artillery_bomber_goal", "script_noteworthy");
  var_01 = common_scripts\utility::func_46B5("artillery_bomber_waypoint_1a", "script_noteworthy");
  var_02 = common_scripts\utility::func_46B5("artillery_bomber_waypoint_1b", "script_noteworthy");
  var_03 = common_scripts\utility::func_46B5("artillery_bomber_waypoint_2a", "script_noteworthy");
  var_04 = common_scripts\utility::func_46B5("artillery_bomber_waypoint_2b", "script_noteworthy");
  var_05 = common_scripts\utility::func_46B5("artillery_bomber_waypoint_2c", "script_noteworthy");
  var_06 = common_scripts\utility::func_46B5("artillery_bomber_waypoint_3", "script_noteworthy");
  var_07 = common_scripts\utility::func_46B5("artillery_bomber_waypoint_4a", "script_noteworthy");
  var_08 = common_scripts\utility::func_46B5("artillery_bomber_waypoint_4b", "script_noteworthy");
  var_09 = [var_00, var_08, var_07, var_06, var_05, var_04, var_03, var_02, var_01];
  return var_09;
}

on_reached_dest() {
  self endon("death");
  var_00 = common_scripts\utility::func_46B7("artillery_struct", "targetname");
  foreach(var_02 in var_00) {
    var_02 maps / mp / zquests / casual / island_ee_util::add_ammo(1);
  }

  common_scripts\utility::func_3C8F("flag_hc_bomb_escort_complete");
  maps / mp / mp_zombie_nest_ee_wave_manipulation::func_8607();
  lib_0378::func_8D74("artillery_battery_placed");
  foreach(var_02 in var_00) {
    var_02 thread artillery_ammo_soul_collection();
  }

  level thread maps / mp / gametypes / zombies::orders_and_contracts_report_event("mp_zombie_nest_01_tower_battle", int(100 * self.health / self.maxhealth));
  self suicide();
}

escort_begin(param_00, param_01) {
  var_02 = self;
  var_02 endon("death");
  self.var_3937 endon("detonate");
  var_02 maps / mp / zquests / casual / island_ee_util::escort_waypoints_linear(param_00);
  var_03 = var_02 maps / mp / zquests / casual / island_ee_util::escort_waypoints_dynamic(param_01);
  return var_03;
}

spawn_ships() {
  common_scripts\utility::func_3C9F("spawn_ships_ee_destroyer_attacker");
  level.artillery_ee_ships = ships_setup();
  thread ships_nag();
  var_00 = common_scripts\utility::func_46B7("org_boat_spawner_set1", "targetname");
  var_01 = common_scripts\utility::func_46B7("org_boat_spawner_set2", "targetname");
  var_02 = common_scripts\utility::func_46B7("org_boat_spawner_set3", "targetname");
  spawn_ship_and_move(common_scripts\utility::func_7A33(var_00), level.artillery_ee_ships[0], randomfloatrange(35, 45));
  if(level.players.size > 2) {
    thread spawn_ship_and_move(common_scripts\utility::func_7A33(var_01), level.artillery_ee_ships[1], randomfloatrange(35, 45));
  } else {
    level.artillery_ee_ships = common_scripts\utility::func_F9A(level.artillery_ee_ships, 1);
  }

  foreach(var_04 in level.players) {
    var_04 maps\mp\_utility::func_2CED(3, ::lib_0367::func_8E3D, "shipnew");
  }

  spawn_ship_and_move(common_scripts\utility::func_7A33(var_02), level.artillery_ee_ships[0], randomfloatrange(35, 45));
}

ships_setup() {
  var_00 = getEntArray("obj_artillery_boats", "targetname");
  foreach(var_02 in var_00) {
    var_03 = common_scripts\utility::func_44BE(var_02.target, "targetname");
    var_02.cannons = [];
    var_02.var_241F = [];
    var_02.hit_points = [];
    foreach(var_05 in var_03) {
      switch (var_05.script_noteworthy) {
        case "org_hit_point":
          var_02.hit_points[var_02.hit_points.size] = var_05;
          var_05 method_8449(var_02);
          break;

        case "obj_artillery_boat":
          var_02.boat_model = var_05;
          var_02.boat_model method_8449(var_02);
          break;

        case "clip_boat":
          var_02.var_241F[var_02.var_241F.size] = var_05;
          var_05 method_8449(var_02);
          break;

        case "org_cannon_1":
          var_02.cannons[0] = var_05;
          var_05 method_8449(var_02);
          break;

        case "org_cannon_2":
          var_02.cannons[1] = var_05;
          var_05 method_8449(var_02);
          break;

        case "org_cannon_3":
          var_02.cannons[2] = var_05;
          var_05 method_8449(var_02);
          break;
      }
    }
  }

  return var_00;
}

spawn_ship_and_move(param_00, param_01, param_02) {
  var_03 = 3;
  var_04 = common_scripts\utility::func_46B5(param_00.target, "targetname");
  param_01.origin = param_00.origin;
  param_01.angles = param_00.angles;
  param_01.in_motion = 1;
  param_01 moveTo(var_04.origin, param_02, 0, var_03);
  if(!common_scripts\utility::func_3C77("flag_first_ship_spawned")) {
    common_scripts\utility::func_3C8F("flag_first_ship_spawned");
    var_05 = common_scripts\utility::func_7A33(param_01.cannons);
    param_01 ship_fire_at_radio_tower(var_05);
    foreach(var_07 in level.players) {
      var_07 maps\mp\_utility::func_2CED(0.75, ::lib_0367::func_8E3D, "shipwarn");
    }
  }

  param_01 thread ship_fire_at_player_wait(param_02);
  param_01 ship_clean_up();
}

ship_fire_at_radio_tower(param_00) {
  var_01 = common_scripts\utility::func_46B5("struct_tower_boom_spot", "targetname").origin;
  if(isDefined(level.current_fog_flag) && maps / mp / mp_zombie_island_ee_fog_manager::get_is_fog_active()) {
    playFX(common_scripts\utility::func_44F5("zmb_battleship_cannon_muzzle_rnr"), param_00.origin);
  } else {
    playFX(common_scripts\utility::func_44F5("zmb_battleship_cannon_muz_fog_rnr"), param_00.origin);
  }

  param_00 lib_0378::func_8D74("radio_tower_artillery_shot");
  var_02 = magicartillery("zmi_airstrike_bomb", param_00.origin, var_01, 3, var_01[2] + 2000);
  var_02 lib_0378::func_8D74("radio_tower_incoming_mortar");
  var_02 waittill("explode", var_03);
  var_02 lib_0378::func_8D74("radio_tower_mortar_impact");
  wait(0.01);
  playFX(common_scripts\utility::func_44F5("zmb_radio_tower_explosion_rnr"), var_01, (-1, 0, 0));
  lib_0378::func_8D74("radio_tower_explosion", var_01);
  wait(0.7);
  var_04 = getEnt("sm_radio_tower", "targetname");
  var_04 scriptmodelplayanim("s2_zom_damaged_radio_tower", "tower_destroyed");
  playrumbleonposition("artillery_rumble", var_03);
}

ship_fire_at_player_wait(param_00) {
  self endon("hit_by_cannon");
  wait(param_00);
  self notify("at_end");
  self.in_motion = undefined;
  thread ship_fire_at_player();
}

ship_clean_up() {
  self waittill("hit_by_cannon");
  level.artillery_ee_ships = common_scripts\utility::func_F93(level.artillery_ee_ships, self);
  level.artillery_ee_ships = common_scripts\utility::func_FA0(level.artillery_ee_ships);
  thread sink_ship();
}

sink_ship() {
  self moveTo(self.origin - (0, 0, 400), 6);
  var_00 = common_scripts\utility::func_8FFC();
  var_00.origin = common_scripts\utility::func_7A33(self.cannons).origin;
  playFXOnTag(level.var_611["zmb_isl_ship_explosion_set"], var_00, "tag_origin");
  var_00 delete();
  wait(6);
  level notify("ship_sank");
  func_0F7B(self.hit_points);
  func_0F7B(self.var_241F);
  func_0F7B(self.cannons);
  self.boat_model delete();
  self delete();
}

func_0F7B(param_00) {
  for(var_01 = 0; var_01 < param_00.size; var_01++) {
    param_00[var_01] delete();
  }
}

ship_fire_at_player() {
  self endon("hit_by_cannon");
  if(level.players.size == 1) {
    var_00 = 9;
    var_01 = 18;
  } else {
    var_00 = 6;
    var_01 = 12;
  }

  var_02 = [var_00, var_01];
  while(isDefined(self) &isDefined(level.players)) {
    var_03 = common_scripts\utility::func_7A33(level.players);
    var_03 thread fire_shell_at_player(common_scripts\utility::func_7A33(self.cannons));
    wait(randomfloatrange(var_02[0], var_02[1]));
  }
}

play_watchout_dialogue(param_00) {
  var_01 = 800;
  foreach(var_03 in level.players) {
    if(isDefined(var_03.heard_watchout) && gettime() - var_03.heard_watchout / 1000 < 20) {
      continue;
    }

    if(distance(var_03.origin, param_00) > var_01) {
      continue;
    }

    var_03 thread lib_0367::func_8E3C("watchout");
    var_03.heard_watchout = gettime();
  }
}

fire_shell_at_player(param_00) {
  var_01 = 350;
  var_02 = 800;
  var_03 = 0;
  if(randomint(100) > 35) {
    var_03 = 1;
  }

  if(common_scripts\utility::func_562E(var_03)) {
    var_01 = 150;
    var_02 = 300;
  }

  var_04 = maps / mp / zquests / casual / island_ee_util::random_2d_vector_safe_zone(self, var_01, var_02);
  if(isDefined(level.current_fog_flag) && maps / mp / mp_zombie_island_ee_fog_manager::get_is_fog_active()) {
    playFX(common_scripts\utility::func_44F5("zmb_battleship_cannon_muzzle_rnr"), param_00.origin);
  } else {
    playFX(common_scripts\utility::func_44F5("zmb_battleship_cannon_muz_fog_rnr"), param_00.origin);
  }

  param_00 lib_0378::func_8D74("dist_artillery_shot");
  var_05 = magicartillery("zmi_airstrike_bomb", param_00.origin, var_04, 3, level.player.origin[2] + 2000);
  var_05 lib_0378::func_8D74("dist_ship_artillery_inc");
  var_05 waittill("explode", var_06);
  var_05 lib_0378::func_8D74("dist_ship_artillery_impact");
  playrumbleonposition("artillery_rumble", var_06);
  radiusdamage(var_06, 750, 50, 15, undefined, "MOD_PROJECTILE", "zmi_airstrike_bomb", 1);
  thread play_watchout_dialogue(var_06);
}

destroyer_complete_xp_reward() {
  foreach(var_01 in level.players) {
    var_01 maps\mp\zombies\_zombies_rank::func_AC23("destroyers");
    var_01 lib_0378::func_8D74("objective_complete", "destroyers");
  }
}

ships_nag() {
  var_00 = 0;
  var_01 = ["shipnag", "shipnagtwo"];
  var_02 = getEnt("vol_artillery_nag_deadzone", "targetname");
  level endon(lib_0557::func_7838("Destroy 2nd Destroyer", "1st Ship Destroyed"));
  while(common_scripts\utility::func_3C77(lib_0557::func_7838("Destroy 2nd Destroyer", "1st Ship Destroyed"))) {
    wait(randomintrange(128, 256));
    if(var_00 < 2) {
      var_03 = var_01[var_00];
    } else {
      var_03 = common_scripts\utility::func_7A33(var_01);
    }

    foreach(var_05 in level.players) {
      if(var_05 istouching(var_02)) {
        continue;
      }

      var_05 thread lib_0367::func_8E3C(var_03);
    }

    var_00++;
  }
}

waittill_ent_death_timeout(param_00, param_01, param_02) {
  param_00 endon("wait_timeout");
  if(isDefined(param_00)) {
    param_00 thread waittill_ent_death_timeout_end(param_01);
  }

  wait(param_02);
}

waittill_ent_death_timeout_end(param_00) {
  self waittill(param_00);
  self notify("wait_timeout");
}

artillery_ammo_soul_collection() {
  var_00 = common_scripts\utility::func_46B5("zmb_island_artillery_soul_collection", "targetname");
  self.soul_collection_ent = spawn("script_model", var_00.origin);
  self.soul_collection_ent setModel("tag_origin");
  for(;;) {
    if(self.controller.ammo_count >= 7) {
      wait 0.05;
      continue;
    }

    self.soul_collection_ent maps / mp / mp_zombies_soul_collection::func_170B(4, 400, 128, "artillery_ammo_soul_collection", undefined, "tag_origin", undefined, "tag_origin", undefined, self.soul_collection_ent, (0, 0, 64));
    maps / mp / zquests / casual / island_ee_util::add_ammo(1);
  }
}

______________final_boss_____________() {}

quest_init_final_boss() {
  common_scripts\utility::func_3C87("final boss wrapped up");
  maps / mp / zquests / casual / island_ee_final_boss::init();
}

get_respawn_flag(param_00) {
  return "can_spawn_" + param_00;
}

watch_assassin_bounty(param_00) {
  foreach(var_02 in param_00) {
    var_03 = get_bounty_flag(var_02);
    common_scripts\utility::func_3C9F(var_03);
  }

  common_scripts\utility::func_3C8F("bring_in_next_type");
}

get_bounty_flag(param_00) {
  return param_00 + "_was_player_killed";
}

watch_for_despawn() {
  self waittill("death");
  playFX(level.var_611["zmi_assassin_critical_hit"], self.origin);
  common_scripts\utility::func_3C8F("can_spawn_");
}

quest_final_boss_island_outro() {
  run_outro();
  maps / mp / gametypes / zombies::func_47A8("DLC1_ZM_HISTORY");
  maps / mp / mp_zombie_island_cart::make_a_transport_request(undefined, undefined, "unlock");
}

on_final_boss_defeated() {
  foreach(var_01 in level.players) {
    if(common_scripts\utility::func_562E(var_01.var_596A)) {
      var_01.besttimetrialtimes[4] = int(gettime() / 1000);
    }
  }

  lock_island_aa_gun_turrets(0);
  preload_outro_cinematic();
  maps / mp / mp_zombie_nest_ee_wave_manipulation::func_8608();
  maps / mp / gametypes / zombies::func_7E57();
  maps / mp / mp_zombie_island_cart::waitforplayersrevived();
  quest_final_boss_island_outro();
  final_boss_island_complete_xp_reward();
  level.zmb_locked_spawn_zones = undefined;
  maps / mp / mp_zombie_nest_ee_wave_manipulation::func_8607();
  level thread maps / mp / gametypes / zombies::orders_and_contracts_report_event("mp_zombie_island_final_boss");
  level thread maps / mp / gametypes / zombies::orders_and_contracts_report_event("any_boss_completed");
  level.var_400E[level.var_400E.size] = ["wicht_set 1 1", "all"];
  if(func_744B()) {
    foreach(var_01 in level.players) {
      var_01 lib_056A::func_4772(1);
    }
  }

  common_scripts\utility::func_3C8F("final boss wrapped up");
  level.zmb_boss_fight_in_progress = 0;
}

func_744B() {
  return common_scripts\utility::func_3C77("flag_pommel_given");
}

final_boss_island_complete_xp_reward() {
  foreach(var_01 in level.players) {
    var_01 maps\mp\zombies\_zombies_rank::func_AC23("islandboss");
    var_01 lib_0378::func_8D74("objective_complete", "islandboss");
  }
}

bombers_init() {
  var_00 = function_01DC("plane_start_node_escort", "targetname");
  var_01 = function_01DC("plane_start_node_bomber", "targetname");
  foreach(var_03 in var_01) {
    var_03 spawn_aircraft("usa_bomber_b25_doorsopen", 1);
  }

  foreach(var_06 in var_00) {
    var_06 spawn_aircraft("usa_fighter_thunderbolt", 0);
  }

  maps / mp / mp_zombie_island_ee_fog_manager::unlock_fog_from_lock();
}

spawn_aircraft(param_00, param_01) {
  var_02 = "ger_bomber_stuka_hub";
  if(!isDefined(param_00)) {
    param_00 = "usa_fighter_thunderbolt";
  }

  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  var_03 = 9999;
  var_04 = spawnhelicopter(self.origin, self.angles, var_02, param_00);
  var_04 notify("forward");
  var_04.veh_transmission = "forward";
  var_04.veh_pathdir = "forward";
  var_04.var_17DC = 0;
  var_04.var_931A = "forward";
  var_04 startpath(self);
  if(param_01) {
    var_04 thread drop_bomb_handler();
  }

  var_04 thread plane_cleanup();
}

drop_bomb_handler() {
  self endon("death");
  for(;;) {
    var_00 = randomintrange(1, 25);
    var_01 = randomintrange(1, 25);
    var_02 = magicgrenademanual("frag_grenade_zm", self.origin, (0, 0, -1), 10);
    var_03 = spawn("script_model", var_02.origin);
    var_03 setModel("zom_bomb");
    var_03 linkTo(var_02);
    var_03 thread delete_self(10);
    wait(2);
  }
}

plane_cleanup() {
  wait(4);
  for(;;) {
    if(isDefined(self) && self.veh_speed <= 0) {
      self notify("death");
      self delete();
      break;
    }

    wait(3);
  }
}

delete_self(param_00) {
  wait(param_00);
  if(isDefined(self)) {
    self delete();
  }
}

run_outro_for_player() {
  var_00 = self;
  var_00 endon("disconnect");
  var_00 method_8003();
  var_00 disableweapons();
  var_00 setclientomnvar("ui_hide_hud", 1);
  var_00 method_8626("isl_outro_movie");
  var_00.var_324E = 1;
  var_00 lib_0547::func_8A6D(1);
  var_01 = 72.5;
  var_02 = 1;
  var_03 = 0;
  var_04 = 0.5;
  var_05 = "black";
  var_06 = common_scripts\utility::func_46B7("zmb_beach_test_spawns", "targetname");
  var_07 = var_06[0].origin;
  if(!isDefined(var_00.var_1781)) {
    var_00.var_1781 = maps / mp / zquests / casual / island_ee_util::func_2787(var_05, 0, var_00, undefined);
  }

  var_08 = var_00.var_1781;
  var_08 setshader(var_05, 640, 480);
  var_08 thread maps / mp / zquests / casual / island_ee_util::overlayfade(0, var_04, 1);
  wait(var_04);
  var_08 thread maps / mp / zquests / casual / island_ee_util::overlayfade(0, var_04, 0);
  var_08 thread maps / mp / zquests / casual / island_ee_util::overlayfade(var_01 - var_04, var_04, 1);
  function_0290(var_00, "mp/mp_zombie_island_outro", var_02, var_03);
  wait(var_01);
  function_0292(var_00);
  var_08 thread maps / mp / zquests / casual / island_ee_util::overlayfade(0, var_04, 0);
  var_00 unlink();
  var_00 method_8004();
  var_00 enableweapons();
  var_00 setclientomnvar("ui_hide_hud", 0);
  var_00.var_324E = 0;
  var_00 lib_0547::func_8A6D(0);
  var_00 method_8627("isl_outro_movie");
  level notify("zombie_outro_finished");
}

run_outro() {
  maps / mp / zombies / _zombies_audio_dlc1::try_run_conversation(level.on_boss_finished_story, 1, 25, 1);
  level.var_AC21 = 1;
  foreach(var_01 in lib_0547::func_408F()) {
    var_01 lib_056D::func_5A86();
  }

  foreach(var_04 in level.players) {
    var_04 thread run_outro_for_player();
  }

  level waittill("zombie_outro_finished");
  for(var_06 = 0; var_06 < level.players.size; var_06++) {
    level.players[var_06] setOrigin(level.zmb_island_final_boss_phases_spawns[var_06].origin);
    if(isDefined(level.zmb_island_final_boss_phases_spawns[var_06].angles)) {
      level.players[var_06] setplayerangles(level.zmb_island_final_boss_phases_spawns[var_06].angles);
    }
  }

  level.var_AC21 = 0;
}

preload_outro_cinematic() {
  function_028E("mp/mp_zombie_island_outro");
}

quest_step_final_boss_island() {
  common_scripts\utility::func_3C87("players_boss_spawn_done");
  maps / mp / _events_z::start_boss_battle_tracking();
  wait_for_players_at_beach();
  maps / mp / mp_zombie_island_ee_fog_manager::set_fog_locked_to_off(1);
  level.zmb_fog_passive_lock = 1;
  lock_island_aa_gun_turrets(1);
  maps / mp / mp_zombie_nest_ee_wave_manipulation::func_8608();
  level.block_normal_assassin_spawns = 1;
  lib_0557::func_7822("Final Boss Island", lib_0557::removed_quest_hint());
  maps / mp / zquests / casual / island_ee_final_boss::init_final_boss_event();
  level thread maps / mp / zquests / casual / island_ee_final_boss::move_players_to_boss_start();
  maps / mp / mp_zombie_island_ee_fog_manager::set_fog_rolling_in();
  level thread maps / mp / mp_zombie_island_ee_fog_manager::set_fog_locked_to_on();
  var_00 = maps / mp / mp_zombie_island_aud::get_random_alive_player();
  var_00 thread lib_0367::func_8E3C("bossability");
  level.ignore_cart_touching_check = 1;
  close_boss_battle_doors();
  level.maxed_zombies_sprint = 1;
  level.free_cart_rides = 1;
  level.zmb_island_pommel_detor_blocked = 1;
  level.zmb_boss_fight_in_progress = 1;
  common_scripts\utility::func_3C9F("players_boss_spawn_done");
  wait_for_island_boss_defeated();
  level.zmb_island_pommel_detor_blocked = 0;
  level.free_cart_rides = 0;
  level.maxed_zombies_sprint = 0;
  level.zmb_fog_passive_lock = 0;
  open_boss_battle_doors();
  level.ignore_cart_touching_check = 0;
  level.block_normal_assassin_spawns = 0;
  maps / mp / _events_z::end_boss_battle_tracking();
  lib_0557::func_782D("Final Boss Island", "Defeat Wustlings");
}

wait_for_players_at_beach() {
  var_00 = getEnt("radio_placement_trigger", "targetname");
  var_01 = undefined;
  if(!common_scripts\utility::func_562E(var_01) && lib_0547::func_5565(level.zmb_uses_hint_notebook, 0)) {
    maps / mp / zombies / weapons / _zombie_aoe_grenade::register_as_pommel_grenade_target(var_00);
    var_00 waittill("pommel_damage");
  }

  var_00 setHintString(&"ZOMBIE_ISLAND_ACTIVATE_BOSS_RADIO");
  if(lib_0547::func_5565(level.zmb_uses_hint_notebook, 1)) {
    foreach(var_03 in level.players) {
      maps\mp\_utility::func_2CED(2, ::lib_0555::func_83DD, "generic_no_return", var_03);
    }
  }

  for(;;) {
    var_00 waittill("trigger", var_05);
    if(var_00 all_players_ready()) {
      break;
    } else {
      var_00 common_scripts\utility::func_9D9F();
      wait(0.2);
      var_00 common_scripts\utility::func_9DA3();
    }
  }

  var_00 common_scripts\utility::func_9D9F();
}

all_players_ready() {
  foreach(var_01 in level.players) {
    if(var_01.sessionstate == "spectator") {
      return 0;
    }

    if(common_scripts\utility::func_562E(var_01.var_5728)) {
      return 0;
    }

    if(distance(self.origin, var_01.origin) > 152) {
      return 0;
    }
  }

  return 1;
}

close_boss_battle_doors() {
  foreach(var_01 in level.var_AC1D) {
    if(isDefined(var_01.var_3280) && var_01.var_3280 == "closeable") {
      var_01 notify("close");
    } else {
      var_01 notify("open");
    }

    foreach(var_03 in var_01.var_9DC2) {
      var_03 common_scripts\utility::func_9D9F();
    }
  }
}

open_boss_battle_doors() {
  foreach(var_01 in level.var_AC1D) {
    if(isDefined(var_01.var_3280) && var_01.var_3280 == "closeable") {
      var_01 notify("open");
    }

    foreach(var_03 in var_01.var_9DC2) {
      var_03 common_scripts\utility::func_9DA3();
    }
  }
}

wait_for_island_boss_defeated() {
  common_scripts\utility::func_3C87("intro_boss_done");
  var_00 = common_scripts\utility::func_46B5("zmb_island_boss_ammo", "targetname");
  var_01 = common_scripts\utility::func_46B7(var_00.target, "targetname");
  foreach(var_03 in var_01) {
    maps / mp / gametypes / zombies::func_281C("ammo", var_03.origin, "random", 0, 0);
  }

  if(level.zmi_final_boss_settings["phase_2_mercy"]) {
    var_05 = common_scripts\utility::func_46B5("zmb_final_boss_overcharge_giveaway", "targetname");
    maps / mp / gametypes / zombies::func_281C("ability_fill", var_05.origin, "random", 0, 0);
  }

  var_06 = common_scripts\utility::func_46B7("zmb_island_boss_intro_zombies", "targetname");
  var_07 = common_scripts\utility::func_46B5("zmb_island_boss_intro_zombies_freefire_target", "targetname");
  var_06 = common_scripts\utility::func_F6F(var_06, var_07);
  foreach(var_09 in var_06) {
    var_0A = common_scripts\utility::func_7A33(level.zmi_final_boss_settings["intro_zombies"]);
    var_0B = lib_054D::func_90BA(var_0A, var_09, "boss_intro_spawn", 0, 1, 1, undefined, 1);
    var_0B lib_0547::func_84CB();
    var_0B.bossintrozombiespawn = 1;
    var_0B thread lib_053C::func_9C74();
  }

  var_0D = spawnStruct();
  var_0D.var_3F11 = [::wait_for_shellshock_ready];
  var_0E = common_scripts\utility::func_46B5("zmb_assassin_spawnpoint_boss_intro_shellshock", "targetname");
  var_0F = maps / mp / zombies / zombie_assassin_spawner_logic::spawn_an_assassin("zombie_assassin_shellshock", 99999, var_0E, 1, "Phase 3: ATTACK", 1, undefined, undefined, var_0D, 1, undefined, ["start_zone"]);
  var_0F.nochill = 1;
  var_0F.custom_on_shellshock_func = ::maps / mp / zombies / zombie_assassin_shellshock::throw_debris;
  var_0F thread set_attack_in(0, 4, "zmb_final_boss_intro_goal_shellshock");
  var_10 = common_scripts\utility::func_46B5("zmb_assassin_spawnpoint_boss_intro_freefire", "targetname");
  var_0F = maps / mp / zombies / zombie_assassin_spawner_logic::spawn_an_assassin("zombie_assassin_freefire", 99999, var_10, 1, "Phase 3: ATTACK", 1, undefined, undefined, var_0D, 1, undefined, ["start_zone"]);
  var_0F.nochill = 1;
  var_0F.forcedtarget = var_07;
  var_0F thread set_attack_in(0, 1.8, "zmb_final_boss_intro_goal_freefire");
  common_scripts\utility::func_3C87("asn_players_are_blinded");
  var_11 = common_scripts\utility::func_46B5("zmb_assassin_spawnpoint_boss_intro_camo", "targetname");
  var_0F = maps / mp / zombies / zombie_assassin_spawner_logic::spawn_an_assassin("zombie_assassin_camoflauge", 99999, var_11, 1, "Phase 3: ATTACK", 1, undefined, undefined, var_0D, 1, undefined, ["start_zone"]);
  var_0F.nochill = 1;
  var_0F thread set_attack_in(6.1, 0, "zmb_final_boss_intro_goal_camo");
  level thread set_intro_done();
  common_scripts\utility::func_3C9F("asn_players_are_blinded");
  foreach(var_09 in level.zmb_isl_conditional_boss_spawns) {
    var_09.is_zombies_spawner_script_disabled = 1;
  }

  foreach(var_15 in level.zmb_island_final_boss_phases) {
    level thread maps / mp / zquests / casual / island_ee_final_boss::start_zombie_island_boss_phase(var_15);
    common_scripts\utility::func_3C9F(var_15.phase_flag);
  }

  foreach(var_09 in level.zmb_isl_conditional_boss_spawns) {
    var_09.is_zombies_spawner_script_disabled = 0;
  }
}

set_intro_done() {
  wait(10.1);
  common_scripts\utility::func_3C8F("intro_boss_done");
}

wait_for_shellshock_ready() {
  while(!common_scripts\utility::func_562E(self.readytoshowoff)) {
    wait 0.05;
  }
}

set_attack_in(param_00, param_01, param_02) {
  self endon("death");
  self.leaveafterspecial = 1;
  self.noflurry = 1;
  self scragentsetscripted(1);
  maps / mp / agents / _scripted_agent_anim_util::func_8732(1, "idle_noncombat");
  maps / mp / agents / _scripted_agent_anim_util::func_8415("idle_asn", 1, 1);
  self.bossintroassassin = 1;
  self.preformingbossintro = 1;
  self.var_1928 = common_scripts\utility::func_46B5(param_02, "targetname");
  wait(param_00);
  self scragentsetscripted(0);
  maps / mp / agents / _scripted_agent_anim_util::func_8732(0, "idle_noncombat");
  wait(param_01);
  self.bossintroassassin = 0;
  self.preformingbossintro = 0;
  self.dontwaitonfirstattack = 1;
  self.readytoshowoff = 1;
  while(!common_scripts\utility::func_562E(self.hasassassinspecialed)) {
    wait 0.05;
  }

  wait(0.15);
  self.var_1928 = undefined;
  common_scripts\utility::func_3C9F("asn_players_are_blinded");
  self setOrigin((0, 0, 0));
  maps / mp / zombies / zombie_assassin_spawner_logic::set_assassin_removed_from_game();
}

boss_ammo_pickup(param_00) {
  var_01 = undefined;
  for(;;) {
    foreach(var_03 in level.players) {
      if(distance(var_03.origin, self.origin) < 64) {
        var_01 = var_03;
        break;
      }
    }

    if(isDefined(var_01)) {
      break;
    }

    wait 0.05;
  }

  self delete();
  if(!common_scripts\utility::func_562E(param_00)) {
    maps / mp / gametypes / zombies::func_DB9(var_01, 1);
    return;
  }

  maps / mp / gametypes / zombies::func_840(var_01, 1);
}

initialize_intro_struct() {
  var_00 = common_scripts\utility::func_46B5("final_boss_intro_struct", "targetname");
  var_01 = common_scripts\utility::func_44BE(var_00.target, "targetname");
  var_00.assassin_spawners = [];
  foreach(var_03 in var_01) {
    switch (var_03.script_noteworthy) {
      case "zmb_assassin_spawner":
        var_00.assassin_spawners = common_scripts\utility::func_F6F(var_00.assassin_spawners, var_03);
        break;

      case "intro_cam_temp":
        var_00.intro_cam = var_03;
        var_00.intro_dest = common_scripts\utility::func_46B5(var_03.target, "targetname");
        break;
    }
  }

  return var_00;
}

wait_for_wustling_extinction() {
  var_00 = 0;
  while(!var_00) {
    var_01 = lib_0547::func_408F();
    var_00 = 1;
    foreach(var_03 in var_01) {
      if(common_scripts\utility::func_562E(var_03.iswustlingzombie)) {
        var_00 = 0;
      }
    }

    wait(0.125);
  }
}

unset_cinematic() {
  foreach(var_01 in level.players) {
    var_01 unlink();
    var_01 method_8004();
    var_01 method_848C();
    var_01 enableweapons();
    var_01 maps\mp\_utility::func_3E8E(0);
    var_01 setclientomnvar("ui_hide_hud", 0);
  }

  level.var_7317 delete();
}

in_game_cinematic(param_00, param_01, param_02) {
  level childthread[[param_00]]();
  if(!isDefined(level.var_7317)) {
    level.var_7317 = spawn("script_model", (0, 0, 0));
    level.var_7317 setModel("player_generic_world_body");
    level.var_7317 method_8511();
  }

  foreach(var_04 in level.players) {
    var_04 setclientomnvar("ui_hide_hud", 1);
    var_04 method_848D();
    var_04 method_8003();
    var_04 disableweapons();
    var_04 maps\mp\_utility::func_3E8E(1);
    var_04 setOrigin(level.var_7317 gettagorigin("tag_player"));
    var_04 setplayerangles(level.var_7317 gettagangles("tag_player"));
    var_04 playerlinktoabsolute(level.var_7317, "tag_player");
  }

  var_06 = common_scripts\utility::func_46B5(param_01, "targetname");
  var_07 = common_scripts\utility::func_46B5(var_06.target, "targetname");
  level.var_7317.origin = var_06.origin;
  level.var_7317.angles = var_06.angles;
  level.var_7317 moveTo(var_07.origin, param_02);
  wait_for_intermission(param_02);
}

flourish_assassins() {}

destroyer_sink() {
  var_00 = getEnt("last_destroyer", "targetname");
  var_01 = common_scripts\utility::func_46B5(var_00.target, "targetname");
  var_00 moveTo(var_01.origin, 10);
  var_00 rotateTo(var_01.angles, 10);
}

spawn_the_bosses() {}

spawn_boss_assassin(param_00) {}

wait_for_spawner_intro() {
  wait(5);
}

wait_for_intermission(param_00) {
  wait(param_00);
}

attach_armor(param_00) {
  foreach(var_02 in param_00) {
    var_03 = var_02.script_noteworthy;
    var_02.origin = self gettagorigin(var_03);
    var_02 linkTo(self, var_03, get_pos_offset_for_armor(var_03), get_angle_offset_for_armor(var_03));
  }
}

get_pos_offset_for_armor(param_00) {
  var_01 = (0, 0, 0);
  switch (param_00) {
    case "J_SpineUpper":
      var_01 = var_01 + (8, 10, 0);
      break;

    case "J_Knee_LE":
      var_01 = var_01 + (0, 0, 0);
      break;

    case "J_Knee_RI":
      var_01 = var_01 + (0, 0, 0);
      break;

    case "J_Elbow_LE":
      var_01 = var_01 + (0, 0, 0);
      break;

    case "J_Elbow_RI":
      var_01 = var_01 + (0, 0, 0);
      break;

    default:
      break;
  }

  return var_01;
}

get_angle_offset_for_armor(param_00) {
  var_01 = self gettagangles(param_00);
  switch (param_00) {
    case "J_SpineUpper":
      var_01 = var_01 + (0, 180, 0);
      break;

    case "J_Knee_LE":
      var_01 = (180, 0, 90);
      break;

    case "J_Knee_RI":
      var_01 = (-180, 180, 90);
      break;

    case "J_Elbow_LE":
      var_01 = var_01 + (0, 0, 180);
      break;

    case "J_Elbow_RI":
      var_01 = var_01 + (270, 90, 180);
      break;

    default:
      break;
  }

  return var_01;
}

show_parts() {
  foreach(var_01 in self) {
    var_01 show();
  }
}

assassin_part_collected() {
  return common_scripts\utility::func_3C77("players_have_razergun_3");
}
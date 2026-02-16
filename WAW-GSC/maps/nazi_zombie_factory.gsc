/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nazi_zombie_factory.gsc
****************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_utility;
#include maps\_zombiemode_zone_manager;
#include maps\nazi_zombie_factory_teleporter;
#include maps\_music;

main() {
  maps\nazi_zombie_factory_fx::main();

  level.pulls_since_last_ray_gun = 0;
  level.pulls_since_last_tesla_gun = 0;
  level.player_drops_tesla_gun = false;

  level.dogs_enabled = true;
  level.mixed_rounds_enabled = true;
  level.burning_zombies = [];
  level.traps = [];
  level.zombie_rise_spawners = [];
  level.max_barrier_search_dist_override = 400;

  level.door_dialog_function = maps\_zombiemode::play_door_dialog;
  level.achievement_notify_func = maps\_zombiemode_utility::achievement_notify;
  level.dog_spawn_func = maps\_zombiemode_dogs::dog_spawn_factory_logic;

  script_anims_init();

  level thread maps\_callbacksetup::SetupCallbacks();

  level.zombie_anim_override = maps\nazi_zombie_factory::anim_override_func;

  setDvar("perk_altMeleeDamage", 1000);

  precachestring(&"ZOMBIE_FLAMES_UNAVAILABLE");
  precachestring(&"ZOMBIE_ELECTRIC_SWITCH");

  precachestring(&"ZOMBIE_POWER_UP_TPAD");
  precachestring(&"ZOMBIE_TELEPORT_TO_CORE");
  precachestring(&"ZOMBIE_LINK_TPAD");
  precachestring(&"ZOMBIE_LINK_ACTIVE");
  precachestring(&"ZOMBIE_INACTIVE_TPAD");
  precachestring(&"ZOMBIE_START_TPAD");

  precacheshellshock("electrocution");
  precachemodel("zombie_zapper_cagelight_red");
  precachemodel("zombie_zapper_cagelight_green");
  precacheModel("lights_indlight_on");
  precacheModel("lights_milit_lamp_single_int_on");
  precacheModel("lights_tinhatlamp_on");
  precacheModel("lights_berlin_subway_hat_0");
  precacheModel("lights_berlin_subway_hat_50");
  precacheModel("lights_berlin_subway_hat_100");
  precachemodel("collision_geo_32x32x128");

  precachestring(&"ZOMBIE_BETTY_ALREADY_PURCHASED");
  precachestring(&"ZOMBIE_BETTY_HOWTO");

  include_weapons();
  include_powerups();
  level.use_zombie_heroes = true;
  maps\_zombiemode::main("receiver_zone_spawners");

  init_sounds();
  init_achievement();
  level thread power_electric_switch();

  level thread magic_box_init();

  thread init_elec_trap_trigs();

  level.zone_manager_init_func = ::factory_zone_init;
  level thread maps\_zombiemode_zone_manager::manage_zones("receiver_zone");

  teleporter_init();

  players = get_players();

  for(i = 0; i < players.size; i++) {
    players[i] thread player_killstreak_timer();
    players[i] thread player_zombie_awareness();
  }

  players[randomint(players.size)] thread level_start_vox();

  level thread intro_screen();

  level thread jump_from_bridge();
  level lock_additional_player_spawner();

  level thread bridge_init();

  level thread phono_egg_init("phono_one", "phono_one_origin");
  level thread phono_egg_init("phono_two", "phono_two_origin");
  level thread phono_egg_init("phono_three", "phono_three_origin");
  level thread meteor_egg("meteor_one");
  level thread meteor_egg("meteor_two");
  level thread meteor_egg("meteor_three");
  level thread meteor_egg_play();
  level thread radio_egg_init("radio_one", "radio_one_origin");
  level thread radio_egg_init("radio_two", "radio_two_origin");
  level thread radio_egg_init("radio_three", "radio_three_origin");
  level thread radio_egg_init("radio_four", "radio_four_origin");
  level thread radio_egg_init("radio_five", "radio_five_origin");
  level.monk_scream_trig = getent("monk_scream_trig", "targetname");
  level thread play_giant_mythos_lines();
  level thread play_level_easteregg_vox("vox_corkboard_1");
  level thread play_level_easteregg_vox("vox_corkboard_2");
  level thread play_level_easteregg_vox("vox_corkboard_3");
  level thread play_level_easteregg_vox("vox_teddy");
  level thread play_level_easteregg_vox("vox_fieldop");
  level thread play_level_easteregg_vox("vox_telemap");
  level thread play_level_easteregg_vox("vox_maxis");
  level thread play_level_easteregg_vox("vox_illumi_1");
  level thread play_level_easteregg_vox("vox_illumi_2");

  set_zombie_var("zombie_powerup_drop_max_per_round", 3);

  trigs = getEntArray("audio_bump_trigger", "targetname");
  for(i = 0; i < trigs.size; i++) {
    if(isDefined(trigs[i].script_sound) && trigs[i].script_sound == "perks_rattle") {
      trigs[i] thread check_for_change();
    }
  }

  trigs = getEntArray("trig_ee", "targetname");
  array_thread(trigs, ::extra_events);

  level thread flytrap();
  level thread hanging_dead_guy("hanging_dead_guy");

  spawncollision("collision_geo_32x32x128", "collider", (-5, 543, 112), (0, 348.6, 0));
}

init_achievement() {
  include_achievement("achievement_shiny");
  include_achievement("achievement_monkey_see");
  include_achievement("achievement_frequent_flyer");
  include_achievement("achievement_this_is_a_knife");
  include_achievement("achievement_martian_weapon");
  include_achievement("achievement_double_whammy");
  include_achievement("achievement_perkaholic");
  include_achievement("achievement_secret_weapon", "zombie_kar98k_upgraded");
  include_achievement("achievement_no_more_door");
  include_achievement("achievement_back_to_future");
}
factory_zone_init() {
  add_adjacent_zone("receiver_zone", "outside_east_zone", "enter_outside_east");

  add_adjacent_zone("receiver_zone", "outside_west_zone", "enter_outside_west");

  add_adjacent_zone("wnuen_zone", "outside_east_zone", "enter_wnuen_building");

  add_adjacent_zone("wnuen_zone", "wnuen_bridge_zone", "enter_wnuen_loading_dock");

  add_adjacent_zone("warehouse_bottom_zone", "outside_west_zone", "enter_warehouse_building");

  add_adjacent_zone("warehouse_bottom_zone", "warehouse_top_zone", "enter_warehouse_second_floor");
  add_adjacent_zone("warehouse_top_zone", "bridge_zone", "enter_warehouse_second_floor");

  add_adjacent_zone("tp_east_zone", "wnuen_zone", "enter_tp_east");
  flag_array[0] = "enter_tp_east";
  flag_array[1] = "enter_wnuen_building";
  add_adjacent_zone("tp_east_zone", "outside_east_zone", flag_array, true);

  add_adjacent_zone("tp_south_zone", "outside_south_zone", "enter_tp_south");

  add_adjacent_zone("tp_west_zone", "warehouse_top_zone", "enter_tp_west");
  flag_array[0] = "enter_tp_west";
  flag_array[1] = "enter_warehouse_second_floor";
  add_adjacent_zone("tp_west_zone", "warehouse_bottom_zone", flag_array, true);
}
intro_screen() {
  flag_wait("all_players_connected");
  wait(2);
  level.intro_hud = [];
  for(i = 0; i < 3; i++) {
    level.intro_hud[i] = newHudElem();
    level.intro_hud[i].x = 0;
    level.intro_hud[i].y = 0;
    level.intro_hud[i].alignX = "left";
    level.intro_hud[i].alignY = "bottom";
    level.intro_hud[i].horzAlign = "left";
    level.intro_hud[i].vertAlign = "bottom";
    level.intro_hud[i].foreground = true;

    if(level.splitscreen && !level.hidef) {
      level.intro_hud[i].fontScale = 2.75;
    } else {
      level.intro_hud[i].fontScale = 1.75;
    }
    level.intro_hud[i].alpha = 0.0;
    level.intro_hud[i].color = (1, 1, 1);
    level.intro_hud[i].inuse = false;
  }
  level.intro_hud[0].y = -110;
  level.intro_hud[1].y = -90;
  level.intro_hud[2].y = -70;

  level.intro_hud[0] settext(&"ZOMBIE_INTRO_FACTORY_LEVEL_PLACE");
  level.intro_hud[1] settext("");
  level.intro_hud[2] settext("");

  for(i = 0; i < 3; i++) {
    level.intro_hud[i] FadeOverTime(3.5);
    level.intro_hud[i].alpha = 1;
    wait(1.5);
  }
  wait(1.5);
  for(i = 0; i < 3; i++) {
    level.intro_hud[i] FadeOverTime(3.5);
    level.intro_hud[i].alpha = 0;
    wait(1.5);
  }
  for(i = 0; i < 3; i++) {
    level.intro_hud[i] destroy();
  }
}
#using_animtree("zombie_factory");
script_anims_init() {
  level.scr_anim["half_gate"] = % o_zombie_lattice_gate_half;
  level.scr_anim["full_gate"] = % o_zombie_lattice_gate_full;
  level.scr_anim["difference_engine"] = % o_zombie_difference_engine_ani;

  level.blocker_anim_func = ::factory_playanim;
}

factory_playanim(animname) {
  self UseAnimTree(#animtree);
  self animscripted("door_anim", self.origin, self.angles, level.scr_anim[animname]);
}

#using_animtree("generic_human");
anim_override_func() {
  level._zombie_melee[0] = % ai_zombie_attack_forward_v1;
  level._zombie_melee[1] = % ai_zombie_attack_forward_v2;
  level._zombie_melee[2] = % ai_zombie_attack_v1;
  level._zombie_melee[3] = % ai_zombie_attack_v2;
  level._zombie_melee[4] = % ai_zombie_attack_v1;
  level._zombie_melee[5] = % ai_zombie_attack_v4;
  level._zombie_melee[6] = % ai_zombie_attack_v6;

  level._zombie_run_melee[0] = % ai_zombie_run_attack_v1;
  level._zombie_run_melee[1] = % ai_zombie_run_attack_v2;
  level._zombie_run_melee[2] = % ai_zombie_run_attack_v3;

  level.scr_anim["zombie"]["run4"] = % ai_zombie_run_v2;
  level.scr_anim["zombie"]["run5"] = % ai_zombie_run_v4;
  level.scr_anim["zombie"]["run6"] = % ai_zombie_run_v3;

  level.scr_anim["zombie"]["walk5"] = % ai_zombie_walk_v6;
  level.scr_anim["zombie"]["walk6"] = % ai_zombie_walk_v7;
  level.scr_anim["zombie"]["walk7"] = % ai_zombie_walk_v8;
  level.scr_anim["zombie"]["walk8"] = % ai_zombie_walk_v9;
}

lock_additional_player_spawner() {
  spawn_points = getstructarray("player_respawn_point", "targetname");
  for(i = 0; i < spawn_points.size; i++) {
    spawn_points[i].locked = true;
  }
}
bridge_init() {
  flag_init("bridge_down");
  wnuen_bridge = getent("wnuen_bridge", "targetname");
  wnuen_bridge_coils = getEntArray("wnuen_bridge_coils", "targetname");
  for(i = 0; i < wnuen_bridge_coils.size; i++) {
    wnuen_bridge_coils[i] LinkTo(wnuen_bridge);
  }
  wnuen_bridge rotatepitch(90, 1, .5, .5);

  warehouse_bridge = getent("warehouse_bridge", "targetname");
  warehouse_bridge_coils = getEntArray("warehouse_bridge_coils", "targetname");
  for(i = 0; i < warehouse_bridge_coils.size; i++) {
    warehouse_bridge_coils[i] LinkTo(warehouse_bridge);
  }
  warehouse_bridge rotatepitch(-90, 1, .5, .5);

  bridge_audio = getstruct("bridge_audio", "targetname");

  flag_wait("electricity_on");

  wnuen_bridge rotatepitch(-90, 4, .5, 1.5);
  warehouse_bridge rotatepitch(90, 4, .5, 1.5);

  if(isDefined(bridge_audio)) {
    playsoundatposition("bridge_lower", bridge_audio.origin);
  }

  wnuen_bridge connectpaths();
  warehouse_bridge connectpaths();

  exploder(500);

  wnuen_bridge waittill("rotatedone");

  flag_set("bridge_down");
  if(isDefined(bridge_audio)) {
    playsoundatposition("bridge_hit", bridge_audio.origin);
  }

  wnuen_bridge_clip = getent("wnuen_bridge_clip", "targetname");
  wnuen_bridge_clip delete();

  warehouse_bridge_clip = getent("warehouse_bridge_clip", "targetname");
  warehouse_bridge_clip delete();

  maps\_zombiemode_zone_manager::connect_zones("wnuen_bridge_zone", "bridge_zone");
  maps\_zombiemode_zone_manager::connect_zones("warehouse_top_zone", "bridge_zone");
}
jump_from_bridge() {
  trig = GetEnt("trig_outside_south_zone", "targetname");
  trig waittill("trigger");

  maps\_zombiemode_zone_manager::connect_zones("outside_south_zone", "bridge_zone", true);
  maps\_zombiemode_zone_manager::connect_zones("outside_south_zone", "wnuen_bridge_zone", true);
}

init_sounds() {
  maps\_zombiemode_utility::add_sound("break_stone", "break_stone");
  maps\_zombiemode_utility::add_sound("gate_door", "open_door");
  maps\_zombiemode_utility::add_sound("heavy_door", "open_door");
}
#include_weapons() {
  include_weapon("zombie_colt");
  include_weapon("zombie_colt_upgraded", false);
  include_weapon("zombie_sw_357");
  include_weapon("zombie_sw_357_upgraded", false);

  include_weapon("zombie_kar98k");
  include_weapon("zombie_kar98k_upgraded", false);

  include_weapon("zombie_m1carbine");
  include_weapon("zombie_m1carbine_upgraded", false);
  include_weapon("zombie_m1garand");
  include_weapon("zombie_m1garand_upgraded", false);
  include_weapon("zombie_gewehr43");
  include_weapon("zombie_gewehr43_upgraded", false);

  include_weapon("zombie_stg44");
  include_weapon("zombie_stg44_upgraded", false);
  include_weapon("zombie_thompson");
  include_weapon("zombie_thompson_upgraded", false);
  include_weapon("zombie_mp40");
  include_weapon("zombie_mp40_upgraded", false);
  include_weapon("zombie_type100_smg");
  include_weapon("zombie_type100_smg_upgraded", false);

  include_weapon("ptrs41_zombie");
  include_weapon("ptrs41_zombie_upgraded", false);

  include_weapon("molotov");
  include_weapon("stielhandgranate");

  include_weapon("m1garand_gl_zombie");
  include_weapon("m1garand_gl_zombie_upgraded", false);
  include_weapon("m7_launcher_zombie");
  include_weapon("m7_launcher_zombie_upgraded", false);

  include_weapon("m2_flamethrower_zombie");
  include_weapon("m2_flamethrower_zombie_upgraded", false);

  include_weapon("zombie_doublebarrel");
  include_weapon("zombie_doublebarrel_upgraded", false);
  include_weapon("zombie_shotgun");
  include_weapon("zombie_shotgun_upgraded", false);

  include_weapon("zombie_bar");
  include_weapon("zombie_bar_upgraded", false);
  include_weapon("zombie_fg42");
  include_weapon("zombie_fg42_upgraded", false);

  include_weapon("zombie_30cal");
  include_weapon("zombie_30cal_upgraded", false);
  include_weapon("zombie_mg42");
  include_weapon("zombie_mg42_upgraded", false);
  include_weapon("zombie_ppsh");
  include_weapon("zombie_ppsh_upgraded", false);

  include_weapon("panzerschrek_zombie");
  include_weapon("panzerschrek_zombie_upgraded", false);

  include_weapon("ray_gun", true, ::factory_ray_gun_weighting_func);
  include_weapon("ray_gun_upgraded", false);
  include_weapon("tesla_gun", true);
  include_weapon("tesla_gun_upgraded", false);
  include_weapon("zombie_cymbal_monkey", true, ::factory_cymbal_monkey_weighting_func);

  include_weapon("mine_bouncing_betty", false);

  maps\_zombiemode_weapons::add_limited_weapon("zombie_colt", 0);
  maps\_zombiemode_weapons::add_limited_weapon("zombie_gewehr43", 0);
  maps\_zombiemode_weapons::add_limited_weapon("zombie_m1garand", 0);
}

factory_ray_gun_weighting_func() {
  if(level.box_moved == true) {
    num_to_add = 1;

    if(isDefined(level.pulls_since_last_ray_gun)) {
      if(level.pulls_since_last_ray_gun > 11) {
        num_to_add += int(level.zombie_include_weapons.size * 0.1);
      } else if(level.pulls_since_last_ray_gun > 7) {
        num_to_add += int(.05 * level.zombie_include_weapons.size);
      }
    }
    return num_to_add;
  } else {
    return 0;
  }
}
factory_cymbal_monkey_weighting_func() {
  players = get_players();
  count = 0;
  for(i = 0; i < players.size; i++) {
    if(players[i] maps\_zombiemode_weapons::has_weapon_or_upgrade("zombie_cymbal_monkey")) {
      count++;
    }
  }
  if(count > 0) {
    return 1;
  } else {
    if(level.round_number < 10) {
      return 3;
    } else {
      return 5;
    }
  }
}

#include_powerups() {
  include_powerup("nuke");
  include_powerup("insta_kill");
  include_powerup("double_points");
  include_powerup("full_ammo");
  include_powerup("carpenter");
}
activate_vending_machines() {}

#using_animtree("generic_human");
force_zombie_crawler() {
  if(!isDefined(self)) {
    return;
  }

  if(!self.gibbed) {
    refs = [];

    refs[refs.size] = "no_legs";

    if(refs.size) {
      self.a.gib_ref = animscripts\death::get_random(refs);

      self.has_legs = false;
      self AllowedStances("crouch");

      which_anim = RandomInt(5);

      if(which_anim == 0) {
        self.deathanim = % ai_zombie_crawl_death_v1;
        self set_run_anim("death3");
        self.run_combatanim = level.scr_anim["zombie"]["crawl1"];
        self.crouchRunAnim = level.scr_anim["zombie"]["crawl1"];
        self.crouchrun_combatanim = level.scr_anim["zombie"]["crawl1"];
      } else if(which_anim == 1) {
        self.deathanim = % ai_zombie_crawl_death_v2;
        self set_run_anim("death4");
        self.run_combatanim = level.scr_anim["zombie"]["crawl2"];
        self.crouchRunAnim = level.scr_anim["zombie"]["crawl2"];
        self.crouchrun_combatanim = level.scr_anim["zombie"]["crawl2"];
      } else if(which_anim == 2) {
        self.deathanim = % ai_zombie_crawl_death_v1;
        self set_run_anim("death3");
        self.run_combatanim = level.scr_anim["zombie"]["crawl3"];
        self.crouchRunAnim = level.scr_anim["zombie"]["crawl3"];
        self.crouchrun_combatanim = level.scr_anim["zombie"]["crawl3"];
      } else if(which_anim == 3) {
        self.deathanim = % ai_zombie_crawl_death_v2;
        self set_run_anim("death4");
        self.run_combatanim = level.scr_anim["zombie"]["crawl4"];
        self.crouchRunAnim = level.scr_anim["zombie"]["crawl4"];
        self.crouchrun_combatanim = level.scr_anim["zombie"]["crawl4"];
      } else if(which_anim == 4) {
        self.deathanim = % ai_zombie_crawl_death_v1;
        self set_run_anim("death3");
        self.run_combatanim = level.scr_anim["zombie"]["crawl5"];
        self.crouchRunAnim = level.scr_anim["zombie"]["crawl5"];
        self.crouchrun_combatanim = level.scr_anim["zombie"]["crawl5"];
      }
    }

    if(self.health > 50) {
      self.health = 50;

      self thread animscripts\death::do_gib();
    }
  }
}
magic_box_init() {
  level.open_chest_location = [];
  level.open_chest_location[0] = "chest1";
  level.open_chest_location[1] = "chest2";
  level.open_chest_location[2] = "chest3";
  level.open_chest_location[3] = "chest4";
  level.open_chest_location[4] = "chest5";
  level.open_chest_location[5] = "start_chest";
}

power_electric_switch() {
  trig = getent("use_power_switch", "targetname");
  master_switch = getent("power_switch", "targetname");
  master_switch notsolid();
  trig sethintstring(&"ZOMBIE_ELECTRIC_SWITCH");

  cheat = false;

  if(GetDvarInt("zombie_cheat") >= 3) {
    wait(5);
    cheat = true;
  }

  user = undefined;
  if(cheat != true) {
    trig waittill("trigger", user);
  }

  master_switch rotateroll(-90, .3);

  master_switch playSound("switch_flip");
  flag_set("electricity_on");
  wait_network_frame();
  clientnotify("revive_on");
  wait_network_frame();
  clientnotify("fast_reload_on");
  wait_network_frame();
  clientnotify("doubletap_on");
  wait_network_frame();
  clientnotify("jugger_on");
  wait_network_frame();
  level notify("sleight_on");
  wait_network_frame();
  level notify("revive_on");
  wait_network_frame();
  level notify("doubletap_on");
  wait_network_frame();
  level notify("juggernog_on");
  wait_network_frame();
  level notify("Pack_A_Punch_on");
  wait_network_frame();
  level notify("specialty_armorvest_power_on");
  wait_network_frame();
  level notify("specialty_rof_power_on");
  wait_network_frame();
  level notify("specialty_quickrevive_power_on");
  wait_network_frame();
  level notify("specialty_fastreload_power_on");
  wait_network_frame();
  ClientNotify("pl1");
  exploder(600);

  trig delete();

  playFX(level._effect["switch_sparks"], getstruct("power_switch_fx", "targetname").origin);

  maps\_zombiemode_zone_manager::connect_zones("outside_east_zone", "outside_south_zone");
  maps\_zombiemode_zone_manager::connect_zones("outside_west_zone", "outside_south_zone", true);
}

init_elec_trap_trigs() {
  array_thread(getEntArray("warehouse_electric_trap", "targetname"), ::electric_trap_think, "enter_warehouse_building");
  array_thread(getEntArray("wuen_electric_trap", "targetname"), ::electric_trap_think, "enter_wnuen_building");
  array_thread(getEntArray("bridge_electric_trap", "targetname"), ::electric_trap_think, "bridge_down");
}

electric_trap_dialog() {
  self endon("warning_dialog");
  level endon("switch_flipped");
  timer = 0;
  while(1) {
    wait(0.5);
    players = get_players();
    for(i = 0; i < players.size; i++) {
      dist = distancesquared(players[i].origin, self.origin);
      if(dist > 70 * 70) {
        timer = 0;
        continue;
      }
      if(dist < 70 * 70 && timer < 3) {
        wait(0.5);
        timer++;
      }
      if(dist < 70 * 70 && timer == 3) {
        index = maps\_zombiemode_weapons::get_player_index(players[i]);
        plr = "plr_" + index + "_";

        wait(3);
        self notify("warning_dialog");
      }
    }
  }
}

electric_trap_think(enable_flag) {
  self sethintstring(&"ZOMBIE_FLAMES_UNAVAILABLE");
  self.zombie_cost = 1000;

  self thread electric_trap_dialog();

  triggers = getEntArray(self.targetname, "targetname");
  flag_wait("electricity_on");

  self.zombie_dmg_trig = getent(self.target, "targetname");
  self.zombie_dmg_trig.in_use = 0;

  self sethintstring(&"ZOMBIE_BUTTON_NORTH_FLAMES");

  light_name = "";
  tswitch = getent(self.script_linkto, "script_linkname");
  switch (tswitch.script_linkname) {
    case "10":
    case "11":
      light_name = "zapper_light_wuen";
      break;

    case "20":
    case "21":
      light_name = "zapper_light_warehouse";
      break;

    case "30":
    case "31":
      light_name = "zapper_light_bridge";
      break;
  }

  if(!flag(enable_flag)) {
    self trigger_off();

    zapper_light_red(light_name);
    flag_wait(enable_flag);

    self trigger_on();
  }

  zapper_light_green(light_name);

  while(1) {
    self waittill("trigger", who);
    if(who in_revive_trigger()) {
      continue;
    }

    if(is_player_valid(who)) {
      if(who.score >= self.zombie_cost) {
        if(!self.zombie_dmg_trig.in_use) {
          self.zombie_dmg_trig.in_use = 1;

          array_thread(triggers, ::trigger_off);

          play_sound_at_pos("purchase", who.origin);
          self thread electric_trap_move_switch(self);

          self waittill("switch_activated");

          who maps\_zombiemode_score::minus_to_player_score(self.zombie_cost);

          self.zombie_dmg_trig trigger_on();

          self thread activate_electric_trap();

          self waittill("elec_done");

          clientnotify(self.script_string + "off");

          if(isDefined(self.fx_org)) {
            self.fx_org delete();
          }
          if(isDefined(self.zapper_fx_org)) {
            self.zapper_fx_org delete();
          }
          if(isDefined(self.zapper_fx_switch_org)) {
            self.zapper_fx_switch_org delete();
          }

          self.zombie_dmg_trig trigger_off();
          wait(25);

          array_thread(triggers, ::trigger_on);

          self notify("available");

          self.zombie_dmg_trig.in_use = 0;
        }
      }
    }
  }
}
electric_trap_move_switch(parent) {
  light_name = "";
  tswitch = getent(parent.script_linkto, "script_linkname");
  switch (tswitch.script_linkname) {
    case "10":
    case "11":
      light_name = "zapper_light_wuen";
      break;

    case "20":
    case "21":
      light_name = "zapper_light_warehouse";
      break;

    case "30":
    case "31":
      light_name = "zapper_light_bridge";
      break;
  }

  zapper_light_red(light_name);
  tswitch rotatepitch(180, .5);
  tswitch playSound("amb_sparks_l_b");
  tswitch waittill("rotatedone");

  self notify("switch_activated");
  self waittill("available");
  tswitch rotatepitch(-180, .5);

  zapper_light_green(light_name);
}
activate_electric_trap() {
  if(isDefined(self.script_string) && self.script_string == "warehouse") {
    clientnotify("warehouse");
  } else if(isDefined(self.script_string) && self.script_string == "wuen") {
    clientnotify("wuen");
  } else {
    clientnotify("bridge");
  }

  clientnotify(self.target);

  fire_points = getstructarray(self.target, "targetname");

  for(i = 0; i < fire_points.size; i++) {
    wait_network_frame();
    fire_points[i] thread electric_trap_fx(self);
  }

  self.zombie_dmg_trig thread elec_barrier_damage();

  level waittill("arc_done");
}
electric_trap_fx(notify_ent) {
  self.tag_origin = spawn("script_model", self.origin);

  self.tag_origin playSound("elec_start");
  self.tag_origin playLoopSound("elec_loop");
  self thread play_electrical_sound();

  wait(25);

  self.tag_origin stoploopsound();

  self.tag_origin delete();
  notify_ent notify("elec_done");
  level notify("arc_done");
}
play_electrical_sound() {
  level endon("arc_done");
  while(1) {
    wait(randomfloatrange(0.1, 0.5));
    playsoundatposition("elec_arc", self.origin);
  }
}
elec_barrier_damage() {
  while(1) {
    self waittill("trigger", ent);

    if(isPlayer(ent)) {
      ent thread player_elec_damage();
    } else {
      if(!isDefined(ent.marked_for_death)) {
        ent.marked_for_death = true;
        ent thread zombie_elec_death(randomint(100));
      }
    }
  }
}
play_elec_vocals() {
  if(isDefined(self)) {
    org = self.origin;
    wait(0.15);
    playsoundatposition("elec_vocals", org);
    playsoundatposition("zombie_arc", org);
    playsoundatposition("exp_jib_zombie", org);
  }
}
player_elec_damage() {
  self endon("death");
  self endon("disconnect");

  if(!isDefined(level.elec_loop)) {
    level.elec_loop = 0;
  }

  if(!isDefined(self.is_burning) && !self maps\_laststand::player_is_in_laststand()) {
    self.is_burning = 1;
    self setelectrified(1.25);
    shocktime = 2.5;

    self shellshock("electrocution", shocktime);

    if(level.elec_loop == 0) {
      elec_loop = 1;

      self playSound("zombie_arc");
    }
    if(!self hasperk("specialty_armorvest") || self.health - 100 < 1) {
      radiusdamage(self.origin, 10, self.health + 100, self.health + 100);
      self.is_burning = undefined;
    } else {
      self dodamage(50, self.origin);
      wait(.1);

      self.is_burning = undefined;
    }
  }

}

zombie_elec_death(flame_chance) {
  self endon("death");

  if(flame_chance > 90 && level.burning_zombies.size < 6) {
    level.burning_zombies[level.burning_zombies.size] = self;
    self thread zombie_flame_watch();
    self playSound("ignite");
    self thread animscripts\death::flame_death_fx();
    wait(randomfloat(1.25));
  } else {
    refs[0] = "guts";
    refs[1] = "right_arm";
    refs[2] = "left_arm";
    refs[3] = "right_leg";
    refs[4] = "left_leg";
    refs[5] = "no_legs";
    refs[6] = "head";
    self.a.gib_ref = refs[randomint(refs.size)];

    playsoundatposition("zombie_arc", self.origin);
    if(!self enemy_is_dog() && randomint(100) > 50) {
      self thread electroctute_death_fx();
      self thread play_elec_vocals();
    }
    wait(randomfloat(1.25));
    self playSound("zombie_arc");
  }

  self dodamage(self.health + 666, self.origin);
  iprintlnbold("should be damaged");
}

zombie_flame_watch() {
  self waittill("death");
  self stoploopsound();
  level.burning_zombies = array_remove_nokeys(level.burning_zombies, self);
}
zapper_light_red(lightname) {
  zapper_lights = getEntArray(lightname, "targetname");
  for(i = 0; i < zapper_lights.size; i++) {
    zapper_lights[i] setModel("zombie_zapper_cagelight_red");

    if(isDefined(zapper_lights[i].fx)) {
      zapper_lights[i].fx delete();
    }

    zapper_lights[i].fx = maps\_zombiemode_net::network_safe_spawn("trap_light_red", 2, "script_model", zapper_lights[i].origin);
    zapper_lights[i].fx setModel("tag_origin");
    zapper_lights[i].fx.angles = zapper_lights[i].angles + (-90, 0, 0);
    playFXOnTag(level._effect["zapper_light_notready"], zapper_lights[i].fx, "tag_origin");
  }
}
zapper_light_green(lightname) {
  zapper_lights = getEntArray(lightname, "targetname");
  for(i = 0; i < zapper_lights.size; i++) {
    zapper_lights[i] setModel("zombie_zapper_cagelight_green");

    if(isDefined(zapper_lights[i].fx)) {
      zapper_lights[i].fx delete();
    }

    zapper_lights[i].fx = maps\_zombiemode_net::network_safe_spawn("trap_light_green", 2, "script_model", zapper_lights[i].origin);
    zapper_lights[i].fx setModel("tag_origin");
    zapper_lights[i].fx.angles = zapper_lights[i].angles + (-90, 0, 0);
    playFXOnTag(level._effect["zapper_light_ready"], zapper_lights[i].fx, "tag_origin");
  }
}
electroctute_death_fx() {
  self endon("death");

  if(isDefined(self.is_electrocuted) && self.is_electrocuted) {
    return;
  }

  self.is_electrocuted = true;

  self thread electrocute_timeout();

  self StartTanning();

  if(self.team == "axis") {
    level.bcOnFireTime = gettime();
    level.bcOnFireOrg = self.origin;
  }

  playFXOnTag(level._effect["elec_torso"], self, "J_SpineLower");
  self playSound("elec_jib_zombie");
  wait 1;

  tagArray = [];
  tagArray[0] = "J_Elbow_LE";
  tagArray[1] = "J_Elbow_RI";
  tagArray[2] = "J_Knee_RI";
  tagArray[3] = "J_Knee_LE";
  tagArray = array_randomize(tagArray);

  playFXOnTag(level._effect["elec_md"], self, tagArray[0]);
  self playSound("elec_jib_zombie");

  wait 1;
  self playSound("elec_jib_zombie");

  tagArray[0] = "J_Wrist_RI";
  tagArray[1] = "J_Wrist_LE";
  if(!isDefined(self.a.gib_ref) || self.a.gib_ref != "no_legs") {
    tagArray[2] = "J_Ankle_RI";
    tagArray[3] = "J_Ankle_LE";
  }
  tagArray = array_randomize(tagArray);

  playFXOnTag(level._effect["elec_sm"], self, tagArray[0]);
  playFXOnTag(level._effect["elec_sm"], self, tagArray[1]);
}

electrocute_timeout() {
  self endon("death");
  self playLoopSound("fire_manager_0");
  wait 12;
  self stoploopsound();
  if(isDefined(self) && isalive(self)) {
    self.is_electrocuted = false;
    self notify("stop_flame_damage");
  }
}

/

level_start_vox() {
  index = maps\_zombiemode_weapons::get_player_index(self);
  plr = "plr_" + index + "_";
  wait(6);
  self thread create_and_play_dialog(plr, "vox_level_start", 0.25);
}

check_for_change() {
  while(1) {
    self waittill("trigger", player);

    if(player GetStance() == "prone") {
      player maps\_zombiemode_score::add_to_player_score(25);
      play_sound_at_pos("purchase", player.origin);
      break;
    }
  }
}

extra_events() {
  self UseTriggerRequireLookAt();
  self SetCursorHint("HINT_NOICON");
  self waittill("trigger");

  targ = GetEnt(self.target, "targetname");
  if(isDefined(targ)) {
    targ MoveZ(-10, 5);
  }
}
flytrap() {
  flag_init("hide_and_seek");
  level.flytrap_counter = 0;

  level thread hide_and_seek_target("ee_exp_monkey");
  wait_network_frame();
  level thread hide_and_seek_target("ee_bowie_bear");
  wait_network_frame();
  level thread hide_and_seek_target("ee_perk_bear");
  wait_network_frame();

  trig_control_panel = GetEnt("trig_ee_flytrap", "targetname");

  upgrade_hit = false;
  while(!upgrade_hit) {
    trig_control_panel waittill("damage", amount, inflictor, direction, point, type);

    weapon = inflictor getcurrentweapon();
    if(maps\_zombiemode_weapons::is_weapon_upgraded(weapon)) {
      upgrade_hit = true;
    }
  }

  trig_control_panel playSound("flytrap_hit");
  playsoundatposition("flytrap_creeper", trig_control_panel.origin);
  thread play_sound_2d("sam_fly_laugh");

  level achievement_notify("DLC3_ZOMBIE_ANTI_GRAVITY");
  level ClientNotify("ag1");
  wait(9.0);
  thread play_sound_2d("sam_fly_act_0");
  wait(6.0);

  thread play_sound_2d("sam_fly_act_1");

  flag_set("hide_and_seek");

  flag_wait("ee_exp_monkey");
  flag_wait("ee_bowie_bear");
  flag_wait("ee_perk_bear");
}
hide_and_seek_target(target_name) {
  flag_init(target_name);

  obj_array = getEntArray(target_name, "targetname");
  for(i = 0; i < obj_array.size; i++) {
    obj_array[i] Hide();
  }

  trig = GetEnt("trig_" + target_name, "targetname");
  trig trigger_off();
  flag_wait("hide_and_seek");

  for(i = 0; i < obj_array.size; i++) {
    obj_array[i] Show();
  }
  trig trigger_on();
  trig waittill("trigger");

  level.flytrap_counter = level.flytrap_counter + 1;
  thread flytrap_samantha_vox();
  trig playSound("object_hit");

  for(i = 0; i < obj_array.size; i++) {
    obj_array[i] Hide();
  }
  flag_set(target_name);
}

phono_egg_init(trigger_name, origin_name) {
  if(!isDefined(level.phono_counter)) {
    level.phono_counter = 0;
  }
  players = getplayers();
  phono_trig = getent(trigger_name, "targetname");
  phono_origin = getent(origin_name, "targetname");

  if((!isDefined(phono_trig)) || (!isDefined(phono_origin))) {
    return;
  }

  phono_trig UseTriggerRequireLookAt();
  phono_trig SetCursorHint("HINT_NOICON");

  for(i = 0; i < players.size; i++) {
    phono_trig waittill("trigger", players);
    level.phono_counter = level.phono_counter + 1;
    phono_origin play_phono_egg();
  }
}

play_phono_egg() {
  if(!isDefined(level.phono_counter)) {
    level.phono_counter = 0;
  }

  if(level.phono_counter == 1) {
    self playSound("phono_one");
  }
  if(level.phono_counter == 2) {
    self playSound("phono_two");
  }
  if(level.phono_counter == 3) {
    self playSound("phono_three");
  }
}

radio_egg_init(trigger_name, origin_name) {
  players = getplayers();
  radio_trig = getent(trigger_name, "targetname");
  radio_origin = getent(origin_name, "targetname");

  if((!isDefined(radio_trig)) || (!isDefined(radio_origin))) {
    return;
  }

  radio_trig UseTriggerRequireLookAt();
  radio_trig SetCursorHint("HINT_NOICON");
  radio_origin playLoopSound("radio_static");

  for(i = 0; i < players.size; i++) {
    radio_trig waittill("trigger", players);
    radio_origin stoploopsound(.1);

    radio_origin playSound(trigger_name);
  }
}
hanging_dead_guy(name) {
  dead_guy = getent(name, "targetname");

  if(!isDefined(dead_guy)) {
    return;
  }
  dead_guy physicslaunch(dead_guy.origin, (randomintrange(-20, 20), randomintrange(-20, 20), randomintrange(-20, 20)));
}

play_music_easter_egg() {
  if(!isDefined(level.eggs)) {
    level.eggs = 0;
  }

  level.eggs = 1;
  setmusicstate("eggs");

  wait(270);
  setmusicstate("WAVE_1");
  level.eggs = 0;
}

meteor_egg(trigger_name) {
  while(1) {
    if(!isDefined(level.meteor_counter)) {
      level.meteor_counter = 0;
    }

    meteor_trig = getent(trigger_name, "targetname");

    if(!isDefined(meteor_trig)) {
      return;
    }
    meteor_trig UseTriggerRequireLookAt();
    meteor_trig SetCursorHint("HINT_NOICON");

    meteor_trig waittill("trigger", player);
    player playSound("meteor_affirm");
    level.meteor_counter = level.meteor_counter + 1;
    return;
  }
}

meteor_egg_play() {
  while(1) {
    if(!isDefined(level.meteor_counter)) {
      level.meteor_counter = 0;
    }

    if(level.meteor_counter == 3) {
      thread play_music_easter_egg();
      return;
    }
    wait(0.05);
  }
}

flytrap_samantha_vox() {
  if(!isDefined(level.flytrap_counter)) {
    level.flytrap_counter = 0;
  }

  if(level.flytrap_counter == 1) {
    thread play_sound_2d("sam_fly_first");
  }
  if(level.flytrap_counter == 2) {
    thread play_sound_2d("sam_fly_second");
  }
  if(level.flytrap_counter == 3) {
    thread play_sound_2d("sam_fly_last");
    return;
  }
  wait(0.05);
}

play_giant_mythos_lines() {
  round = 5;

  wait(10);
  while(1) {
    vox_rand = randomintrange(1, 100);

    if(level.round_number <= round) {
      if(vox_rand <= 2) {
        players = get_players();
        p = randomint(players.size);
        index = maps\_zombiemode_weapons::get_player_index(players[p]);
        plr = "plr_" + index + "_";
        players[p] thread create_and_play_dialog(plr, "vox_gen_giant", .25);
      }
    } else if(level.round_number > round) {
      return;
    }
    wait(randomintrange(60, 240));
  }
}

play_level_easteregg_vox(object) {
  percent = 35;

  trig = getent(object, "targetname");

  if(!isDefined(trig)) {
    return;
  }

  trig UseTriggerRequireLookAt();
  trig SetCursorHint("HINT_NOICON");

  while(1) {
    trig waittill("trigger", who);

    vox_rand = randomintrange(1, 100);

    if(vox_rand <= percent) {
      index = maps\_zombiemode_weapons::get_player_index(who);
      plr = "plr_" + index + "_";

      switch (object) {
        case "vox_corkboard_1":

          who thread create_and_play_dialog(plr, "vox_resp_corkmap", .25);
          break;
        case "vox_corkboard_2":

          who thread create_and_play_dialog(plr, "vox_resp_corkmap", .25);
          break;
        case "vox_corkboard_3":

          who thread create_and_play_dialog(plr, "vox_resp_corkmap", .25);
          break;
        case "vox_teddy":
          if(index != 2) {
            who thread create_and_play_dialog(plr, "vox_resp_teddy", .25);
          }
          break;
        case "vox_fieldop":
          if((index != 1) && (index != 3)) {
            who thread create_and_play_dialog(plr, "vox_resp_fieldop", .25);
          }
          break;
        case "vox_maxis":
          if(index == 3) {
            who thread create_and_play_dialog(plr, "vox_resp_maxis", .25);
          }
          break;
        case "vox_illumi_1":
          if(index == 3) {
            who thread create_and_play_dialog(plr, "vox_resp_maxis", .25);
          }
          break;
        case "vox_illumi_2":
          if(index == 3) {
            who thread create_and_play_dialog(plr, "vox_resp_maxis", .25);
          }
          break;
        default:
          return;
      }
    } else {
      index = maps\_zombiemode_weapons::get_player_index(who);
      plr = "plr_" + index + "_";

      who thread create_and_play_dialog(plr, "vox_gen_sigh", .25);
    }
    wait(15);
  }
}
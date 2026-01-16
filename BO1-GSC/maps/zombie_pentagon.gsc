/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_pentagon.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_utility;
#include maps\_zombiemode_zone_manager;
#include maps\zombie_pentagon_teleporter;

main() {
  maps\zombie_pentagon_fx::main();
  maps\zombie_pentagon_amb::main();
  maps\zombie_pentagon_anim::main();
  level pentagon_precache();
  PrecacheShader("zom_icon_trap_switch_handle");
  level.dogs_enabled = false;
  level.random_pandora_box_start = false;
  level thread maps\_callbacksetup::SetupCallbacks();
  level.quad_move_speed = 35;
  level.quad_explode = true;
  level.dog_spawn_func = maps\_zombiemode_ai_dogs::dog_spawn_factory_logic;
  level.exit_level_func = ::pentagon_exit_level;
  level.custom_ai_type = [];
  level.custom_ai_type = array_add(level.custom_ai_type, maps\_zombiemode_ai_dogs::init);
  level.custom_ai_type = array_add(level.custom_ai_type, maps\_zombiemode_ai_quad::init);
  level.custom_ai_type = array_add(level.custom_ai_type, maps\_zombiemode_ai_thief::init);
  level.door_dialog_function = maps\_zombiemode::play_door_dialog;
  include_weapons();
  include_powerups();
  level.use_zombie_heroes = true;
  level.disable_protips = 1;
  level.delete_when_in_createfx = ::delete_in_createfx;
  maps\_zombiemode::main();
  level maps\zombie_pentagon_magic_box::magic_box_init();
  battlechatter_off("allies");
  battlechatter_off("axis");
  maps\_compass::setupMiniMap("menu_map_zombie_pentagon");
  level.zone_manager_init_func = ::pentagon_zone_init;
  init_zones[0] = "conference_level1";
  level thread maps\_zombiemode_zone_manager::manage_zones(init_zones);
  level.random_spawners = true;
  level maps\zombie_pentagon_traps::init_traps();
  level thread maps\_zombiemode_auto_turret::init();
  level thread maps\zombie_pentagon_elevators::init();
  level thread electric_switch();
  level thread enable_zone_elevators_init();
  level thread maps\zombie_pentagon_teleporter::pentagon_packapunch_init();
  level thread maps\zombie_pentagon_teleporter::pack_door_init();
  level thread maps\zombie_pentagon_teleporter::teleporter_power_cable();
  level thread vision_set_init();
  level thread laststand_bleedout_init();
  level thread lab_shutters_init();
  level thread pentagon_brush_lights_init();
  level.bonfire_init_func = ::pentagon_bonfire_init;
  init_sounds();
  init_pentagon_client_flags();
  level thread play_starting_vox();
}

init_pentagon_client_flags() {
  level.ZOMBIE_PENTAGON_PLAYER_PORTALFX = 5;
  level.ZOMBIE_PENTAGON_PLAYER_PORTALFX_COOL = 6;
}

delete_in_createfx() {
  if(getDvar(#"createfx") != "") {
    exterior_goals = getstructarray("exterior_goal", "targetname");
    for(i = 0; i < exterior_goals.size; i++) {
      if(!isDefined(exterior_goals[i].target)) {
        continue;
      }
      targets = getEntArray(exterior_goals[i].target, "targetname");
      for(j = 0; j < targets.size; j++) {
        if(isDefined(targets[j].script_parameters) && targets[j].script_parameters == "repair_board") {
          unbroken_section = getEnt(targets[j].target, "targetname");
          if(isDefined(unbroken_section)) {
            unbroken_section self_delete();
          }
        }
        targets[j] self_delete();
      }
    }
    return;
  }
}

pentagon_zone_init() {
  flag_init("always_on");
  flag_set("always_on");
  add_adjacent_zone("conference_level1", "hallway_level1", "conf1_hall1");
  add_adjacent_zone("hallway3_level1", "hallway_level1", "conf1_hall1");
  add_adjacent_zone("conference_level2", "war_room_zone_south", "war_room_entry", true);
  add_adjacent_zone("conference_level2", "war_room_zone_north", "war_room_special", true);
  add_adjacent_zone("war_room_zone_top", "war_room_zone_south", "war_room_stair");
  add_adjacent_zone("war_room_zone_top", "war_room_zone_north", "war_room_stair");
  add_adjacent_zone("war_room_zone_south", "war_room_zone_north", "war_room_stair");
  add_adjacent_zone("war_room_zone_south", "war_room_zone_north", "war_room_west");
  add_adjacent_zone("war_room_zone_north", "war_room_zone_elevator", "war_room_elevator");
  add_adjacent_zone("labs_elevator", "labs_hallway1", "labs_enabled");
  add_adjacent_zone("labs_hallway1", "labs_hallway2", "labs_enabled");
  add_adjacent_zone("labs_hallway2", "labs_zone1", "lab1_level3");
  add_adjacent_zone("labs_hallway1", "labs_zone2", "lab2_level3");
  add_adjacent_zone("labs_hallway2", "labs_zone2", "lab2_level3");
  add_adjacent_zone("labs_hallway1", "labs_zone3", "lab3_level3");
  level.zones["conference_level1"].num_spawners = 4;
  level.zones["hallway_level1"].num_spawners = 4;
}

enable_zone_elevators_init() {
  elev_zone_trig = getEnt("elevator1_down_riders", "targetname");
  elev_zone_trig thread maps\zombie_pentagon_teleporter::enable_zone_portals();
  elev_zone_trig2 = getEnt("elevator2_down_riders", "targetname");
  elev_zone_trig2 thread maps\zombie_pentagon_teleporter::enable_zone_portals();
}

include_weapons() {
  include_weapon("frag_grenade_zm", false, true);
  include_weapon("claymore_zm", false, true);
  include_weapon("m1911_zm", false);
  include_weapon("m1911_upgraded_zm", false);
  include_weapon("python_zm");
  include_weapon("python_upgraded_zm", false);
  include_weapon("cz75_zm");
  include_weapon("cz75_upgraded_zm", false);
  include_weapon("m14_zm", false, true);
  include_weapon("m14_upgraded_zm", false);
  include_weapon("m16_zm", false, true);
  include_weapon("m16_gl_upgraded_zm", false);
  include_weapon("g11_lps_zm");
  include_weapon("g11_lps_upgraded_zm", false);
  include_weapon("famas_zm");
  include_weapon("famas_upgraded_zm", false);
  include_weapon("ak74u_zm", false, true);
  include_weapon("ak74u_upgraded_zm", false);
  include_weapon("mp5k_zm", false, true);
  include_weapon("mp5k_upgraded_zm", false);
  include_weapon("mpl_zm", false, true);
  include_weapon("mpl_upgraded_zm", false);
  include_weapon("pm63_zm", false, true);
  include_weapon("pm63_upgraded_zm", false);
  include_weapon("spectre_zm");
  include_weapon("spectre_upgraded_zm", false);
  include_weapon("cz75dw_zm");
  include_weapon("cz75dw_upgraded_zm", false);
  include_weapon("ithaca_zm", false, true);
  include_weapon("ithaca_upgraded_zm", false);
  include_weapon("rottweil72_zm", false, true);
  include_weapon("rottweil72_upgraded_zm", false);
  include_weapon("spas_zm");
  include_weapon("spas_upgraded_zm", false);
  include_weapon("hs10_zm");
  include_weapon("hs10_upgraded_zm", false);
  include_weapon("aug_acog_zm");
  include_weapon("aug_acog_mk_upgraded_zm", false);
  include_weapon("galil_zm");
  include_weapon("galil_upgraded_zm", false);
  include_weapon("commando_zm");
  include_weapon("commando_upgraded_zm", false);
  include_weapon("fnfal_zm");
  include_weapon("fnfal_upgraded_zm", false);
  include_weapon("dragunov_zm");
  include_weapon("dragunov_upgraded_zm", false);
  include_weapon("l96a1_zm");
  include_weapon("l96a1_upgraded_zm", false);
  include_weapon("rpk_zm");
  include_weapon("rpk_upgraded_zm", false);
  include_weapon("hk21_zm");
  include_weapon("hk21_upgraded_zm", false);
  include_weapon("m72_law_zm");
  include_weapon("m72_law_upgraded_zm", false);
  include_weapon("china_lake_zm");
  include_weapon("china_lake_upgraded_zm", false);
  include_weapon("zombie_cymbal_monkey");
  include_weapon("ray_gun_zm");
  include_weapon("ray_gun_upgraded_zm", false);
  include_weapon("freezegun_zm");
  include_weapon("freezegun_upgraded_zm", false);
  include_weapon("crossbow_explosive_zm");
  include_weapon("crossbow_explosive_upgraded_zm", false);
  include_weapon("knife_ballistic_zm", true);
  include_weapon("knife_ballistic_upgraded_zm", false);
  include_weapon("knife_ballistic_bowie_zm", false);
  include_weapon("knife_ballistic_bowie_upgraded_zm", false);
  level._uses_retrievable_ballisitic_knives = true;
  maps\_zombiemode_weapons::add_limited_weapon("m1911_zm", 0);
  maps\_zombiemode_weapons::add_limited_weapon("freezegun_zm", 1);
  maps\_zombiemode_weapons::add_limited_weapon("crossbow_explosive_zm", 1);
  maps\_zombiemode_weapons::add_limited_weapon("knife_ballistic_zm", 1);
  precacheItem("explosive_bolt_zm");
  precacheItem("explosive_bolt_upgraded_zm");
  level.collector_achievement_weapons = array_add(level.collector_achievement_weapons, "bowie_knife_zm");
}

include_powerups() {
  include_powerup("nuke");
  include_powerup("insta_kill");
  include_powerup("double_points");
  include_powerup("full_ammo");
  include_powerup("carpenter");
  include_powerup("fire_sale");
  include_powerup("bonfire_sale");
  PreCacheItem("minigun_zm");
  include_powerup("minigun");
}

electric_switch() {
  trig = getEnt("use_elec_switch", "targetname");
  trig sethintstring(&"ZOMBIE_ELECTRIC_SWITCH");
  trig setcursorhint("HINT_NOICON");
  level thread wait_for_power();
  trig waittill("trigger", user);
  trig delete();
  flag_set("power_on");
  Objective_State(8, "done");
}

wait_for_power() {
  master_switch = getEnt("elec_switch", "targetname");
  master_switch notsolid();
  flag_wait("power_on");
  exploder(3500);
  stop_exploder(2000);
  exploder(2001);
  level thread regular_portal_fx_on();
  level thread maps\zombie_pentagon::change_pentagon_vision();
  master_switch rotateroll(-90, .3);
  master_switch playsound("zmb_switch_flip");
  level notify("revive_on");
  level notify("juggernog_on");
  level notify("sleight_on");
  level notify("doubletap_on");
  level notify("Pack_A_Punch_on");
  clientnotify("ZPO");
  maps\zombie_pentagon_teleporter::teleporter_init();
  master_switch waittill("rotatedone");
  playfx(level._effect["switch_sparks"], getstruct("elec_switch_fx", "targetname").origin);
  master_switch playsound("zmb_turn_on");
  level thread maps\zombie_pentagon_amb::play_pentagon_announcer_vox("zmb_vox_pentann_poweron");
}

init_sounds() {
  maps\_zombiemode_utility::add_sound("wood_door_fall", "zmb_wooden_door_fall");
  maps\_zombiemode_utility::add_sound("window_grate", "zmb_window_grate_slide");
  maps\_zombiemode_utility::add_sound("lab_door", "zmb_lab_door_slide");
  maps\_zombiemode_utility::add_sound("lab_door_swing", "zmb_door_wood_open");
}

quad_traverse_death_fx() {
  self endon("quad_end_traverse_anim");
  self waittill("death");
  playfx(level._effect["quad_grnd_dust_spwnr"], self.origin);
}

zombie_pathing_init() {
  cleanup_trig = getEntArray("zombie_movement_cleanup", "targetname");
  for(i = 0; i < cleanup_trig.size; i++) {
    cleanup_trig[i] thread zombie_pathing_cleanup();
  }
}

zombie_pathing_cleanup() {
  while(true) {
    self waittill("trigger", who);
    if(isDefined(who.animname) && who.animname == "thief_zombie") {
      continue;
    } else if(who.team == "axis") {
      level.zombie_total++;
      who DoDamage(who.health + 100, who.origin);
    }
  }
}

vision_set_init() {
  level waittill("start_of_round");
  exploder(2000);
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    players[i] visionSetNaked("zombie_pentagon", 0.5);
  }
}

change_pentagon_vision() {
  if(flag("thief_round")) {
    return;
  }
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i].floor = maps\_zombiemode_ai_thief::thief_check_floor(players[i]);
    setClientSysState("levelNotify", "vis" + players[i].floor, players[i]);
    wait_network_frame();
  }
}

laststand_bleedout_init() {
  flag_wait("all_players_connected");
  players = get_players();
  if(players.size > 1) {
    for(i = 0; i < players.size; i++) {
      players[i] thread wait_for_laststand_notify();
      players[i] thread bleedout_listener();
    }
  }
}

wait_for_laststand_notify() {
  self endon("disconnect");
  while(true) {
    num_on_floor = 0;
    num_floor_laststand = 0;
    self waittill("player_downed");
    while(self maps\_laststand::player_is_in_laststand()) {
      self.floor = maps\_zombiemode_ai_thief::thief_check_floor(self);
      current_floor = self.floor;
      players = get_players();
      for(i = 0; i < players.size; i++) {
        players[i].floor = maps\_zombiemode_ai_thief::thief_check_floor(players[i]);
        if(players[i].floor == current_floor) {
          num_on_floor++;
          if(players[i] maps\_laststand::player_is_in_laststand()) {
            num_floor_laststand++;
          }
        }
      }
      wait_network_frame();
      if(players.size > 1 && num_on_floor == num_floor_laststand) {
        self thread maps\zombie_pentagon_elevators::laststand_elev_zombies_away();
      }
      wait(5);
    }
  }
}

bleedout_listener() {
  while(true) {
    self waittill("spawned_spectator");
    wait(2);
    level thread check_if_empty_floors();
    wait(1);
  }
}

pentagon_bonfire_init() {
  if(flag("defcon_active") && level.defcon_activated == false) {
    return;
  } else if(flag("defcon_active") && level.defcon_activated == true) {
    level.defcon_countdown_time = 30;
    level.defcon_level = 5;
    return;
  }
  current_defcon_level = level.defcon_level;
  punch_switches = getEntArray("punch_switch", "targetname");
  signs = getEntArray("defcon_sign", "targetname");
  pack_door_slam = getEnt("slam_pack_door", "targetname");
  flag_set("bonfire_reset");
  level.defcon_level = 1;
  level notify("pack_room_reset");
  wait(0.1);
  if(isDefined(punch_switches)) {
    for(i = 0; i < punch_switches.size; i++) {
      punch_switches[i] notify("trigger");
      wait(0.5);
    }
  }
  if(level.zones["conference_level2"].is_occupied) {
    wait(1);
    level thread start_defcon_countdown();
  }
  level waittill("bonfire_sale_off");
  if(level.defcon_activated == true || level.zones["conference_level2"].is_occupied) {
    return;
  } else {
    flag_clear("defcon_active");
    level thread regular_portal_fx_on();
    level.defcon_level = 1;
    level notify("pack_room_reset");
    level thread defcon_sign_lights();
  }
  flag_clear("bonfire_reset");
}

lab_shutters_init() {
  shutters = getEntArray("lab_shutter", "script_noteworthy");
  if(isDefined(shutters)) {
    for(i = 0; i < shutters.size; i++) {
      shutters[i] thread lab_shutters_think();
    }
  }
}

lab_shutters_think() {
  door_pos = self.origin;
  time = 1;
  scale = 1;
  if(isDefined(self.script_flag) && !flag(self.script_flag)) {
    flag_wait(self.script_flag);
    if(flag("thief_round")) {
      while(flag("thief_round")) {
        wait(0.5);
      }
    }
    if(isDefined(self.script_vector)) {
      vector = vector_scale(self.script_vector, scale);
      thief_vector = vector_scale(self.script_vector, .2);
      while(true) {
        self moveTo(door_pos + vector, time, time * 0.25, time * 0.25);
        self thread maps\_zombiemode_blockers::door_solid_thread();
        flag_wait("thief_round");
        self moveTo(door_pos + thief_vector, time, time * 0.25, time * 0.25);
        self thread maps\_zombiemode_blockers::door_solid_thread();
        while(flag("thief_round")) {
          wait(0.5);
        }
      }
    }
  }
}

play_starting_vox() {
  flag_wait("all_players_connected");
  level thread maps\zombie_pentagon_amb::play_pentagon_announcer_vox("zmb_vox_pentann_levelstart");
}

pentagon_brush_lights_init() {
  sbrush_office_ceiling_lights_off = getEntArray("sbrushmodel_interior_office_lights", "targetname");
  if(isDefined(sbrush_office_ceiling_lights_off) && sbrush_office_ceiling_lights_off.size > 0) {
    array_thread(sbrush_office_ceiling_lights_off, ::pentagon_brush_lights);
  }
}

pentagon_brush_lights() {
  if(!isDefined(self.target)) {
    return;
  }
  self.off_version = getEnt(self.target, "targetname");
  self.off_version hide();
  flag_wait("power_on");
  self hide();
  self.off_version Show();
}

pentagon_precache() {
  PreCacheModel("zombie_zapper_cagelight_red");
  precachemodel("zombie_zapper_cagelight_green");
  PreCacheShellShock("electrocution");
  PreCacheModel("viewmodel_usa_pow_arms");
  PreCacheModel("zombie_trap_switch");
  PreCacheModel("zombie_trap_switch_light");
  PreCacheModel("zombie_trap_switch_light_on_green");
  PreCacheModel("zombie_trap_switch_light_on_red");
  PreCacheModel("zombie_trap_switch_handle");
  PreCacheModel("p_zom_monitor_screen_fsale1");
  PreCacheModel("p_zom_monitor_screen_fsale2");
  PreCacheModel("p_zom_monitor_screen_labs0");
  PreCacheModel("p_zom_monitor_screen_labs1");
  PreCacheModel("p_zom_monitor_screen_labs2");
  PreCacheModel("p_zom_monitor_screen_labs3");
  PreCacheModel("p_zom_monitor_screen_lobby0");
  PreCacheModel("p_zom_monitor_screen_lobby1");
  PreCacheModel("p_zom_monitor_screen_lobby2");
  PreCacheModel("p_zom_monitor_screen_logo");
  PreCacheModel("p_zom_monitor_screen_off");
  PreCacheModel("p_zom_monitor_screen_on");
  PreCacheModel("p_zom_monitor_screen_warroom0");
  PreCacheModel("p_zom_monitor_screen_warroom1");
  PreCacheModel("p_pent_light_ceiling");
  PreCacheModel("p_pent_light_tinhat_off");
  PreCacheModel("p_rus_rb_lab_warning_light_01");
  PreCacheModel("p_rus_rb_lab_warning_light_01_off");
  PreCacheModel("p_rus_rb_lab_light_core_on");
  PreCacheModel("p_rus_rb_lab_light_core_off");
  PreCacheModel("p_zom_pent_defcon_sign_02");
  PreCacheModel("p_zom_pent_defcon_sign_03");
  PreCacheModel("p_zom_pent_defcon_sign_04");
  PreCacheModel("p_zom_pent_defcon_sign_05");
}

pentagon_exit_level() {
  zombies = GetAiArray("axis");
  for(i = 0; i < zombies.size; i++) {
    if(zombies[i].animname == "thief_zombie") {
      continue;
    } else {
      zombies[i] thread pentagon_find_exit_point();
    }
  }
}

pentagon_find_exit_point() {
  self endon("death");
  player = getplayers()[0];
  dist_zombie = 0;
  dist_player = 0;
  dest = 0;
  away = VectorNormalize(self.origin - player.origin);
  endPos = self.origin + vector_scale(away, 600);
  locs = array_randomize(level.enemy_dog_locations);
  for(i = 0; i < locs.size; i++) {
    dist_zombie = distanceSquared(locs[i].origin, endPos);
    dist_player = distanceSquared(locs[i].origin, player.origin);
    if(dist_zombie < dist_player) {
      dest = i;
      break;
    }
  }
  self notify("stop_find_flesh");
  self notify("zombie_acquire_enemy");
  self setgoalpos(locs[dest].origin);
  while(1) {
    if(!flag("wait_and_revive")) {
      break;
    }
    wait_network_frame();
  }
  self thread maps\_zombiemode_spawner::find_flesh();
}
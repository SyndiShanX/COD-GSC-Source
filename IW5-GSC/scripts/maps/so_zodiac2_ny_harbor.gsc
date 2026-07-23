/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\so_zodiac2_ny_harbor.gsc
*************************************************/

main() {
  level.primary_weapon = "mp7_reflex";
  level.secondary_weapon = "aa12";
  setsaveddvar("sm_sunshadowscale", 0.85);
  level.old_shadow_scale = getdvarfloat("sm_sunshadowscale");
  maps\_shg_common::so_vfx_entity_fixup("msg_vfx");
  maps\_shg_common::so_mark_class("trigger_multiple_audio");
  maps\_specialops::so_delete_all_triggers();
  maps\_specialops::so_delete_all_spawners();
  maps\_specialops::so_delete_all_vehicles();
  common_scripts\utility::flag_init("hatch_player_using_ladder");
  common_scripts\utility::flag_init("outside_above_water");
  common_scripts\utility::flag_init("so_zodiac2_ny_harbor_complete");
  common_scripts\utility::flag_init("so_zodiac2_ny_harbor_start");
  common_scripts\utility::flag_init("players_in_reactor_room");
  common_scripts\utility::flag_init("stop_missile_launch");
  common_scripts\utility::flag_init("times_up");
  common_scripts\utility::flag_init("hatch_open");
  common_scripts\utility::flag_init("times_up_reactor");
  common_scripts\utility::flag_init("bombs_defused_missile_room");
  common_scripts\utility::flag_init("bombs_defused_reactor_room");
  common_scripts\utility::flag_init("reactor_thermite_start");
  common_scripts\utility::flag_init("detonate_sub");
  common_scripts\utility::flag_init("submine_planted");
  common_scripts\utility::flag_init("sub_breach_started");
  common_scripts\utility::flag_init("entering_water");
  common_scripts\utility::flag_init("launch_missiles");
  common_scripts\utility::flag_init("player_on_boat");
  common_scripts\utility::flag_init("msg_vfx_sub_interior_red_light_pulse");
  common_scripts\utility::flag_init("laststand_downed");
  common_scripts\utility::flag_init("a_thing_is_being_defused");
  common_scripts\utility::flag_init("russian_sub_spawned");
  common_scripts\utility::flag_init("reactor_saved");
  common_scripts\utility::flag_init("close_hatch");
  common_scripts\utility::flag_init("switch_chinook");
  common_scripts\utility::flag_init("door_3_is_open");
  common_scripts\utility::flag_init("been_hit");
  precacheitem("mp7_reflex");
  precachemodel("weapon_thermite_device_obj");
  precachemodel("ny_harbor_sub_pipe_valve_02_obj");
  precacheshader("nightvision_overlay_goggles");
  precachestring("SCRIPT_MISSIONFAIL_KILLTEAM_AMERICAN");
  maps\_utility::add_hint_string("hint_friendly", &"SCRIPT_MISSIONFAIL_KILLTEAM_AMERICAN", ::_id_02AF);
  precacheanims();
  prefx();
  prevo();
  precacheminimapsentrycodeassets();
  _id_02AD::main();
  maps/ny_harbor_precache::main();
  maps\ny_harbor_aud::main();
  maps\_load::main();
  maps\so_aud::main();
  maps\_compass::setupminimap("compass_map_ny_harbor");
  level.so_zodiac2_ny_harbor = 1;
  maps/ny_harbor_fx::main();
  maps\_audio::set_stringtable_mapname("shg");
  setup();
  gameplay();
}

setup() {
  thread maps\_specialops::enable_challenge_timer("so_zodiac2_ny_harbor_start", "so_zodiac2_ny_harbor_complete");
  thread maps\_specialops::fade_challenge_in();
  thread maps\_specialops::fade_challenge_out("so_zodiac2_ny_harbor_complete");
  thread maps\_specialops::enable_escape_warning();
  thread maps\_specialops::enable_escape_failure();
  thread maps\_audio_zone_manager::azm_start_zone("nyhb_surface_battle");
  setup_players();
  thread objectives();
  handle_end_of_game_bonuses();
  common_scripts\utility::array_thread(level.players, maps\_specialops::enable_challenge_counter, 3, &"SO_ZODIAC2_NY_HARBOR_BONUS_CLOSE_SMALL", "bonus1_count");
  level.so_mission_worst_time = 600000;
  level.so_mission_min_time = 104000;
  maps\_shg_common::so_eog_summary("@SO_ZODIAC2_NY_HARBOR_BONUS_CLOSE", 250, undefined);
}

gameplay() {
  globals();
  setup_ocean();
  thread dialogue();
  thread setup_intro();
  thread sub_interior();
  difficulty_specific_items();
}

debug() {
  wait 3;
  iprintlnbold("start_time= " + level.challenge_start_time);
}

globals() {
  maps\_utility::add_global_spawn_function("axis", ::monitor_damage_type);
  common_scripts\utility::array_thread(level.players, ::halt_if_downed);
  thread _id_02AE();
  level.maars_interface_fontscale = 1.5;
  level.turn_time = 7;
  level.pipesdamage = 0;

  if(level.single_player) {
    level.time_to_disarm_each_thermite = 14;
    level.num_explosives = 4;
  } else {
    level.time_to_disarm_each_thermite = 9;
    level.num_explosives = 8;
  }
}

_id_02AE() {
  level waittill("friendlyfire_mission_fail");

  foreach(var_1 in level.players) {}
  var_1 thread maps\_utility::display_hint_timeout("hint_friendly", 2);
}

_id_02AF() {
  if(common_scripts\utility::flag("laststand_downed")) {
    return 1;
  } else {
    return 0;
  }
}

halt_if_downed() {
  for(;;) {
    self waittill("player_downed");
    common_scripts\utility::flag_set("laststand_downed");
    self waittill("revived");
    common_scripts\utility::flag_clear("laststand_downed");
  }
}

setup_players() {
  level.single_player = 1;

  if(isDefined(level.players[1])) {
    level.single_player = 0;
  }
  foreach(var_1 in level.players) {
    var_1 takeallweapons();
    var_1 giveweapon(level.primary_weapon);
    var_1 giveweapon(level.secondary_weapon);
    var_1 giveweapon("fraggrenade");
    var_1 giveweapon("flash_grenade");
    var_1 setoffhandsecondaryclass("flash");
    var_1 switchtoweapon(level.primary_weapon);
  }
}

so_objective_create(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }
  objective_add(maps\_utility::obj(var_0), "active", var_1);
  objective_current(maps\_utility::obj(var_0));
  objective_position(maps\_utility::obj(var_0), (var_2.origin[0], var_2.origin[1], var_2.origin[2] + var_3));
}

so_objective_complete(var_0) {
  maps\_utility::objective_clearadditionalpositions(var_0);
  maps\_utility::objective_complete(maps\_utility::obj(var_0));
}

objectives() {
  wait 10;
  objective_1_getinsub();
  objective_2_gettoreactor();
  objective_3_getoutofsub();
  objective_4_gettoextraction();
}

objective_1_getinsub() {
  var_0 = getEnt("obj_get_in_sub", "targetname");
  so_objective_create(1, &"SO_ZODIAC2_NY_HARBOR_OBJ_GET_IN_SUB", var_0);
  objective_setpointertextoverride(1, &"SO_ZODIAC2_NY_HARBOR_HINT_DISARM");
  common_scripts\utility::flag_wait("hatch_open");
  objective_position(maps\_utility::obj(1), (0, 0, 0));
  maps\_utility::objective_complete(maps\_utility::obj(1));
}

objective_2_gettoreactor() {
  objective_add(maps\_utility::obj(2), "active", &"SO_ZODIAC2_NY_HARBOR_OBJ_REACTOR");
  objective_current(maps\_utility::obj(2));
  var_0 = getEnt("obj_reactor2", "targetname");
  objective_position(maps\_utility::obj(2), var_0.origin);
  common_scripts\utility::flag_wait("bombs_defused_missile_room");
  wait 5.5;
  objective_position(maps\_utility::obj(2), (0, 0, 0));
  wait 0.5;
  var_1 = [];

  if(level.single_player) {
    if(isDefined(level.players[0].upper_floor) && level.players[0].upper_floor) {
      var_1 = getEntArray("exit_hint_single", "targetname");
    } else {
      var_1 = getEntArray("exit_hint_single_bottom", "targetname");
    }
  }

  if(!level.single_player) {
    var_1 = getEntArray("exit_hint_multi", "targetname");
  }
  var_2 = [];

  foreach(var_5, var_4 in var_1) {
    objective_additionalposition(maps\_utility::obj(2), var_5 + 1, var_4.origin);
    objective_setpointertextoverride(2, &"SO_ZODIAC2_NY_HARBOR_HINT_EXIT");
    var_2[var_5] = var_5 + 1;
  }

  wait 7;

  foreach(var_7 in var_2) {}
  objective_additionalposition(maps\_utility::obj(2), var_7, (0, 0, 0));

  wait 0.5;
  objective_setpointertextoverride(2, "");
  var_0 = getEnt("obj_reactor2", "targetname");
  objective_position(maps\_utility::obj(2), var_0.origin);
  common_scripts\utility::flag_wait("reactor_saved");
  objective_position(maps\_utility::obj(2), (0, 0, 0));
  maps\_utility::objective_complete(maps\_utility::obj(2));
}

objective_3_getoutofsub() {
  objective_add(maps\_utility::obj(3), "active", &"SO_ZODIAC2_NY_HARBOR_OBJ_GET_OUT");
  objective_current(maps\_utility::obj(3));
  common_scripts\utility::array_thread(level.players, ::obj_crumb_logic);
  common_scripts\utility::flag_wait("obj_zod_crumb_flag");
  objective_position(maps\_utility::obj(3), (0, 0, 0));
  maps\_utility::objective_complete(maps\_utility::obj(3));
  wait 0.1;
}

obj_crumb_logic(var_0, var_1) {
  wait_till_player_is_close(3, "obj_escape_bc1");
  wait_till_player_is_close(3, "obj_escape_bc2");
  wait_till_player_is_close(3, "obj_get_to_zodiac_crumb1", 1);
  wait_till_player_is_close(3, "obj_get_to_zodiac_crumb2");
}

wait_till_player_is_close(var_0, var_1, var_2) {
  var_3 = getEnt(var_1, "targetname");
  objective_position(maps\_utility::obj(var_0), var_3.origin);

  if(isDefined(var_2)) {
    objective_setpointertextoverride(3, &"SO_ZODIAC2_NY_HARBOR_HINT_EXIT");
  }
  while(distance(self.origin, var_3.origin) > 96) {
    wait 0.05;
  }
}

objective_4_gettoextraction() {
  objective_add(maps\_utility::obj(4), "active", &"SO_ZODIAC2_NY_HARBOR_OBJ_AWAIT_CHOPPER");
  objective_current(maps\_utility::obj(4));
  wait 2;
  var_0 = getEnt("obj_extraction", "targetname");
  objective_position(maps\_utility::obj(4), var_0.origin);
  common_scripts\utility::flag_wait("so_zodiac2_ny_harbor_complete");
  maps\_utility::objective_complete(maps\_utility::obj(4));
}

dialogue() {
  common_scripts\utility::flag_wait("vo_nuclear");
  maps\_utility::radio_dialogue("so_zodiac2_hqr_riggedsub");
  common_scripts\utility::flag_wait("vo_reactor");
  maps\_utility::radio_dialogue("so_zodiac2_hqr_nearingreactor");
  common_scripts\utility::flag_wait("start_reactor_countdown");
  maps\_utility::radio_dialogue("so_zodiac2_hqr_raditionlevels");
  common_scripts\utility::flag_wait("reactor_saved");
  maps\_utility::radio_dialogue("so_zodiac2_hqr_rendezvous");
  common_scripts\utility::flag_wait("kill_spawners_4");
  maps\_utility::radio_dialogue("so_zodiac2_hqr_areaishot");
  common_scripts\utility::flag_wait("open_rear_hatch");
  maps\_utility::radio_dialogue("so_zodiac2_hqr_onisr");
  common_scripts\utility::flag_wait("shoot_at_stragglers");
  maps\_utility::radio_dialogue("so_zodiac2_hqr_readywhen");
}

setup_intro() {
  common_scripts\utility::flag_set("so_zodiac2_ny_harbor_start");
  thread play_music_and_effects();
  thread silo_doors_and_missiles();
  common_scripts\utility::array_thread(level.players, ::setup_thermal_vision);
  thread setup_hind();
  thread setup_ally_helis();
  thread setup_deck();
  thread spawner_cleanup();
  level.sandman = getEnt("sandman", "targetname");
  wait 0.05;
  level.sandman kill();
}

sub_interior() {
  thread visions();
  thread setup_ai_sub();
  thread make_sub_look_like_old_sub();
  thread setup_missile_room();
  thread handle_reactor_setup();
  thread handle_exit();
  thread intro_jets();
  common_scripts\utility::array_thread(level.players, ::rockingsub);
}

setup_thermal_vision() {
  self notifyonplayercommand("use_thermal", "+actionslot 4");
  self setweaponhudiconoverride("actionslot4", "hud_icon_nvg");
  self.thermal = 0;

  for(;;) {
    self waittill("use_thermal");
    turn_on_thermal_vision();
    self waittill("use_thermal");
    turn_off_thermal_vision();
  }
}

turn_on_thermal_vision() {
  maps\_load::thermal_effectson();
  self thermalvisionon();
  self visionsetthermalforplayer("so_sniper_hamburg_thermal", 0);
  self playSound("item_nightvision_on");
  self.thermal = 1;
  gasmask_on_player_so();
  wait 0.5;
}

turn_off_thermal_vision() {
  maps\_load::thermal_effectsoff();
  self thermalvisionoff();
  self playSound("item_nightvision_off");
  self.thermal = 0;
  gasmask_off_player_so();
  wait 0.5;
}

gasmask_on_player_so() {
  sethudlighting(1);
  self.gasmask_hud_elem = newclienthudelem(self);
  self.gasmask_hud_elem.x = 0;
  self.gasmask_hud_elem.y = 0;
  self.gasmask_hud_elem.alignx = "left";
  self.gasmask_hud_elem.aligny = "top";
  self.gasmask_hud_elem.horzalign = "fullscreen";
  self.gasmask_hud_elem.vertalign = "fullscreen";
  self.gasmask_hud_elem.foreground = 0;
  self.gasmask_hud_elem.sort = -10;
  self.gasmask_hud_elem setshader("nightvision_overlay_goggles", 650, 490);
  self.gasmask_hud_elem.archived = 1;
  self.gasmask_hud_elem.hidein3rdperson = 1;
  self.gasmask_hud_elem.alpha = 1.0;
}

gasmask_off_player_so() {
  if(isDefined(self.gasmask_hud_elem)) {
    self.gasmask_hud_elem destroy();
    sethudlighting(0);
  }
}

play_music_and_effects() {
  thread play_random_creepy_audio();
  thread cosmetic_fx_and_geo_for_harbor();
  common_scripts\utility::flag_wait("hind_ready_for_land");
  maps\_audio_music::mus_play("so_harb_board_sub", 4);
  common_scripts\utility::flag_wait("in_missile_room");
  maps\_audio_music::mus_play("so_harb_sub_combat2", 0.2, 3);
  level waittill("trigger_missile_bombs");
  maps\_audio_music::mus_play("so_harb_sub_combat1", 0.2, 3);
  level notify("msg_vfx_sub_interior_b_deactivating");
  common_scripts\utility::flag_clear("msg_vfx_sub_interior_b");
  level waittill("in_missile_room2");
  maps\_audio_music::mus_play("so_harb_sub_combat2", 0.2, 3);
  level waittill("reactor_area_clear");
  maps\_audio_music::mus_play("so_harb_board_sub", 4);
  common_scripts\utility::flag_wait("start_reactor_countdown");
  maps\_audio_music::mus_play("so_harb_sub_combat1", 0.2, 3);
  common_scripts\utility::flag_wait("kill_spawners_4");
  maps\_audio_music::mus_play("so_harb_finale", 4);
}

play_random_creepy_audio() {
  common_scripts\utility::flag_wait("stop_missile_launch");
  var_0 = common_scripts\utility::getStructArray("ambient_sound", "targetname");
  var_1 = ["harb_battleship_stress", "harb_battleship_sink", "harb_sub_stress", "harb_sub_stress_sub_by", "russian_sub_missile_door"];
  var_2 = common_scripts\utility::spawn_tag_origin();

  for(;;) {
    wait(randomfloatrange(5.0, 15.0));
    var_3 = maps\_utility::getclosest(level.players[0].origin, var_0);
    var_2.origin = var_3.origin;
    var_2 playSound(var_1[randomint(var_1.size)], "sound_done");
    var_2 waittill("sound_done");
  }
}

cosmetic_fx_and_geo_for_harbor() {
  var_0 = common_scripts\utility::getStruct("fx_oil_fire", "targetname");
  playFX(common_scripts\utility::getfx("burning_oil_slick_1"), var_0.origin);
  var_1 = getEnt("sinking_ship", "targetname");
  var_1 delete();
  common_scripts\utility::flag_wait("turn_off_fire");
  common_scripts\utility::flag_clear("msg_vfx_sub_interior_a");
  var_2 = getEnt("for_fire", "targetname");
  playFX(common_scripts\utility::getfx("fire_gen"), var_2.origin);
  var_3 = getEnt("for_fire_steam", "targetname");
  var_4 = spawn_tag_to_loc(var_3);
  playFXOnTag(common_scripts\utility::getfx("steam_jet1"), var_4, "tag_origin");
  var_5 = getEnt("for_fire_jet", "targetname");
  var_6 = spawn_tag_to_loc(var_5);
  playFXOnTag(common_scripts\utility::getfx("fire_steam"), var_6, "tag_origin");
}

setup_ai_sub() {
  for(;;) {
    var_0 = getaiarray("axis");
    common_scripts\utility::array_thread(var_0, ::enemy_ai_for_sub);
    wait 2;
  }
}

spawn_missile_room_1_guys(var_0, var_1) {
  var_2 = getEntArray(var_0, "targetname");
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = var_5 maps\_utility::spawn_ai(1);
    var_3[var_3.size] = var_6;
  }

  return var_3;
}

make_sub_look_like_old_sub() {
  var_0 = getEnt("bridge_breach_loc", "targetname");
  var_1 = getEnt("captain_dead", "targetname");
  var_2 = var_1 maps\_utility::spawn_ai(1);
  var_2.animname = "generic";
  var_0 maps\_anim::anim_generic(var_2, "ny_harbor_paried_takedown_captain_die");
  var_2 = var_2 dummy_keep_pose(var_0, "ny_harbor_paried_takedown_captain_dead_1");
  common_scripts\utility::array_thread(level.players, ::no_prone_on_back_of_sub);
}

no_prone_on_back_of_sub() {
  var_0 = getEnt("no_prone_vol", "targetname");

  for(;;) {
    if(var_0 istouching(self)) {
      self allowprone(0);

      while(var_0 istouching(self)) {
        wait 0.05;
      }
      self allowprone(1);
    }

    wait 0.05;
  }
}

remove_silho_door_geo() {
  var_0 = getEntArray("ladder_trigger", "targetname");
  var_1 = getEntArray("ladder_trigger_2", "targetname");
  var_2 = getEntArray("missile_silo_door", "targetname");
}

hide_silho_geo(var_0, var_1, var_2) {
  for(;;) {
    wait_for_both_players_to_enter(var_1, var_0);
    common_scripts\utility::array_call(var_2, ::hide);
    wait_for_both_players_to_enter(var_0, var_1);
    common_scripts\utility::array_call(var_2, ::show);
  }
}

wait_for_both_players_to_enter(var_0, var_1) {
  level.in_sub = 0;

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(var_2 == self) {
      var_1 waittill("trigger", var_2);

      if(var_2 == self) {
        level.in_sub++;
      }
    }

    if(level.in_sub >= level.players.size) {
      break;
    }
  }
}

dummy_keep_pose(var_0, var_1) {
  var_2 = maps\_vehicle_aianim::convert_guy_to_drone(self);
  var_2 startusingheroonlylighting();

  if(isarray(maps\_utility::getgenericanim(var_1))) {
    var_1 = var_1 + "_nl";
  }
  var_0 maps\_anim::anim_generic_first_frame(var_2, var_1);
  var_2 notsolid();
  return var_2;
}

spawner_cleanup() {
  kill_spawners_noteworthy("kill_spawners_1", 6901);
  kill_spawners_noteworthy("kill_spawners_2", 6902);
  kill_spawners_noteworthy("kill_spawners_3", 6903);
  kill_spawners_noteworthy("kill_spawners_4", 6904);
}

kill_spawners_noteworthy(var_0, var_1) {
  common_scripts\utility::flag_wait(var_0);
  maps\_spawner::kill_spawnernum(var_1);
}

setup_deck() {
  thread open_hatch_rear();
  thread spawn_ladder_if_downed();
  thread get_ladder_use_trigger_and_handle();

  if(level.gameskill > 1) {
    maps\_utility::add_global_spawn_function("axis", ::_id_02B0);
  }
  level.thermite_entrance = thermite_setup(undefined, "thermite_entrance", undefined, 75);
  level.thermite_entrance arm_thermite_and_monitor("hatch_open");
  common_scripts\utility::flag_wait("start_jet_strafe");

  if(level.gameskill > 1) {
    maps\_utility::remove_global_spawn_function("axis", ::_id_02B0);
  }
}

_id_02B0() {
  self endon("deah");

  if(isDefined(self)) {
    self.ignoreall = 1;
  }
  common_scripts\utility::flag_wait("start_jet_strafe");
  wait 1.25;

  if(isDefined(self)) {
    self.ignoreall = 0;
  }
}

get_ladder_use_trigger_and_handle() {
  var_0 = getEnt("sight_trigger_front_hatch", "targetname");
  var_1 = var_0.origin;
  var_0.origin = (50, 50, 50);
  var_0.moved = 1;
  common_scripts\utility::flag_wait("hatch_open");
  wait 2;
  var_0.origin = var_1;
  var_0.moved = 0;
  common_scripts\utility::array_thread(level.players, ::hide_trigger_when_ladder_in_use_front, var_0, "check_for_player_front_hatch");
  hatch_player_slide("sight_trigger_front_hatch", "rear_ladder_pos1", "rear_ladder_pos2");
}

spawn_ladder_if_downed() {
  var_0 = getEnt("ladder_brush", "targetname");
  var_1 = var_0.origin;
  var_0.origin = (50, 50, 50);
  var_2 = getEnt("rear_hatch_cap", "targetname");
  var_3 = getEnt("downed_vol_deck", "targetname");

  for(;;) {
    common_scripts\utility::flag_wait("laststand_downed");

    if(common_scripts\utility::flag("hatch_open")) {
      if(player_on_deck(var_3)) {
        var_0.origin = var_1;
        var_2 notsolid();
        var_4 = getEnt("rear_hatch_col", "targetname");
        var_4 notsolid();
        var_5 = getEnt("rear_cap_coll_2", "targetname");
        var_5 notsolid();
      }

      while(common_scripts\utility::flag("laststand_downed")) {
        wait 0.05;
      }
      var_0.origin = (50, 50, 50);
    }

    wait 0.05;
  }
}

player_on_deck(var_0) {
  foreach(var_2 in level.players) {
    if(var_0 istouching(var_2) && var_2 maps\_utility::ent_flag_exist("laststand_downed") && var_2 maps\_utility::ent_flag("laststand_downed")) {
      return 1;
    }
  }

  return 0;
}

arm_thermite_and_monitor(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 75;
  }
  level._id_4656 = self[0];
  level._id_4656.shiny = [];

  foreach(var_3 in level.players) {
    var_3 thread force_player_look_to_defuse(level._id_4656, 100, var_1);
    var_3 thread end_messages_if_both_disarm();
  }

  monitor_remaining_bombs(var_0, self);
}

end_messages_if_both_disarm() {
  level._id_4656 waittill("im_defused");
  self forceusehintoff();

  foreach(var_1 in level._id_4656.shiny) {
    if(isDefined(var_1)) {
      var_1 delete();
    }
  }
}

difficulty_specific_items() {
  var_0 = 0;

  if(level.single_player) {
    var_1 = getEntArray("multi_player", "script_noteworthy");
  } else {
    var_1 = getEntArray("single_player", "script_noteworthy");
  }
  foreach(var_3 in var_1) {}
  var_3 delete();
}

kill_helis(var_0) {
  common_scripts\utility::flag_wait("hatch_open");
  maps\_audio::aud_send_msg("so_harbor_kill_helis", var_0);

  foreach(var_2 in var_0) {
    foreach(var_4 in var_2.riders) {}
    var_4 kill();

    var_2 delete();
  }
}

setup_ally_helis() {
  var_0 = getEntArray("ally_helis", "targetname");
  maps\_audio::aud_send_msg("so_harbor_ally_helis", var_0);
  common_scripts\utility::array_thread(var_0, maps\_vehicle::gopath);
  common_scripts\utility::array_thread(var_0, ::get_allies);
  thread kill_helis(var_0);
  level notify("missiles_spawned");
}

get_allies() {
  foreach(var_1 in self.riders) {}
  var_1.script_godmode = 1;
}

intro_jets() {
  level waittill("spawn_exit_chopper");
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("end_enemy_chopper");
  maps\_audio::aud_send_msg("so_harbor_enemy_chopper_flyover", var_0);
  var_1 = getEnt("exit_ladder_pos1", "targetname");
  wait 20;
  var_2 = make_jet_and_go("f15_enemy_intro");
  wait 1;
  var_3 = make_jet_and_go("f15_enemy_intro2");
  var_1 playSound("f15_final_flyby_fronts", "sound_done");
}

make_jet_and_go(var_0) {
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(var_0);
  var_1 thread kill_jets_when_done();
  return var_1;
}

kill_jets_when_done() {
  common_scripts\utility::flag_wait("remove_intro_f15");
  self delete();
}

inaccurate_magicbullet(var_0, var_1, var_2, var_3) {
  var_4 = var_2[0] + randomfloatrange(var_1 * -1, var_1);
  var_5 = var_2[1] + randomfloatrange(var_1 * -1, var_1);
  var_6 = var_2[2] + randomfloatrange(var_1 * -1, var_1);
  magicbullet(var_0, var_3.origin, (var_4, var_5, var_6));
}

one_item_at_time(var_0) {
  var_0 waittill("im_defused");

  if(isDefined(self.item) && self.item == var_0) {
    self.item = undefined;
  }
}

ok_to_disarm(var_0) {
  if(common_scripts\utility::flag("times_up")) {
    return 0;
  } else if(common_scripts\utility::flag("laststand_downed")) {
    return 0;
  } else if(!isDefined(self.item)) {
    self.item = var_0;
    return 1;
  } else if(self.item == var_0) {
    return 1;
  } else if(self.item != var_0) {
    return 0;
  } else {
    return 1;
  }
}

end_if_timesup() {
  common_scripts\utility::flag_wait("times_up");
  self notify("times_up");
}

force_player_look_to_defuse(var_0, var_1, var_2) {
  level._id_4656 endon("im_defused");
  level._id_4656 thread end_if_timesup();
  thread one_item_at_time(level._id_4656);
  level._id_4656.hidden = 0;
  level._id_4656.defused = 0;
  var_3 = undefined;
  self.message_on = 0;
  level._id_4656.in_use = 0;

  if(!isDefined(var_2)) {
    var_2 = 50;
  }
  while(!level._id_4656.defused) {
    wait 0.05;
    var_4 = self getEye();
    hint_text_logic(var_4, var_2);

    if(isDefined(level._id_4656) && !level._id_4656.hidden && distance(var_4, level._id_4656.origin) < var_2) {
      level._id_4656.shiny[level._id_4656.shiny.size] = make_shiny_thermite(level._id_4656);
      level._id_4656 remove();
      continue;
    }

    if(isDefined(level._id_4656) && level._id_4656.hidden && distance(var_4, level._id_4656.origin) < var_2 && (!isDefined(level._id_4656.inuse) || !level._id_4656.inuse)) {
      while(!common_scripts\utility::flag("laststand_downed") && self useButtonPressed()) {
        self forceusehintoff();

        if(ok_to_disarm(level._id_4656) && level._id_4656 maps\_shg_common::progress_bar(self, undefined, 2, &"SO_ZODIAC2_NY_HARBOR_HINT_DEFUSING", &"SO_ZODIAC2_NY_HARBOR_HINT_DISARM_SUCCESS", undefined, &"SO_ZODIAC2_NY_HARBOR_HINT_DISARM_FAIL")) {
          level._id_4656.defused = 1;
          level._id_4656 kill_fx_on_thermite();
          remove_all_thermites(var_3);
          level._id_4656 notify("im_defused");
        } else {
          self forceusehinton(&"SO_ZODIAC2_NY_HARBOR_HINT_DEFUSE");
          self.item = undefined;
        }

        wait 0.05;
      }

      continue;
    }

    if(isDefined(level._id_4656) && level._id_4656.hidden && isDefined(var_3) && distance(var_4, level._id_4656.origin) > var_2) {
      delete_thermite_and_message(var_3);
      level._id_4656 display();
      continue;
    }

    if(!isDefined(level._id_4656)) {
      delete_thermite_and_message(var_3);
      break;
    } else if(common_scripts\utility::flag("laststand_downed")) {
      wait_for_laststand(var_3);
    }
  }
}

remove_all_thermites(var_0) {
  if(isDefined(var_0)) {
    var_0 delete();
  }
  if(isDefined(level._id_4656)) {
    level._id_4656 hide();
  }
}

delete_thermite_and_message(var_0) {
  if(isDefined(var_0)) {
    var_0 delete();
  }
  self forceusehintoff();
}

wait_for_laststand(var_0) {
  if(isDefined(var_0)) {
    var_0 delete();
  }
  level._id_4656 display();
  self forceusehintoff();

  while(common_scripts\utility::flag("laststand_downed")) {
    wait 0.05;
  }
}

hint_text_logic(var_0, var_1) {
  if(!level._id_4656.in_use && !self.message_on && distance(var_0, level._id_4656.origin) < var_1) {
    self forceusehinton(&"SO_ZODIAC2_NY_HARBOR_HINT_DEFUSE");
    self.message_on = 1;
  } else if(level._id_4656.in_use && !self.message_on && distance(var_0, level._id_4656.origin) < var_1) {
    self forceusehintoff();
    self.message_on = 0;
  } else if(distance(var_0, level._id_4656.origin) > var_1) {
    self forceusehintoff();
    self.message_on = 0;
  }
}

display() {
  self show();
  self.hidden = 0;
}

remove() {
  self hide();
  self.hidden = 1;
}

make_shiny_thermite(var_0) {
  var_1 = "weapon_thermite_device_obj";
  var_2 = spawn("script_model", var_0.origin);
  var_2 setModel(var_1);
  var_2 angles_and_origin(var_0);
  return var_2;
}

kill_fx_on_thermite() {
  stopFXOnTag(common_scripts\utility::getfx("red_dot"), self.tag_light, "tag_origin");
  stopFXOnTag(common_scripts\utility::getfx("red_dot"), self, "tag_fx");
  stopFXOnTag(common_scripts\utility::getfx("light_c4_blink"), self, "tag_fx");
  stopFXOnTag(common_scripts\utility::getfx("white_light"), self, "tag_fx");
}

setup_hind() {
  level.player_hind = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("player_hind");
  maps\_audio::aud_send_msg("so_start_harbor_player_hind", level.player_hind);
  thread heli_fail_safe_on_death();
  level.player_hind.bow = make_custom_tag_from_struct("hind_bow", level.player_hind);
  level.players[0].heli_pos[0] = make_custom_tag_from_targetname("player_position1", level.player_hind);
  level.players[0].heli_pos[1] = make_custom_tag_from_targetname("player_position1b", level.player_hind);
  level.players[0].heli_pos[2] = make_custom_tag_from_targetname("player_position1c", level.player_hind);
  level.players[0] thread heli_unload();

  if(!level.single_player) {
    level.players[1].heli_pos[0] = make_custom_tag_from_targetname("player_position2", level.player_hind);
    level.players[1].heli_pos[1] = make_custom_tag_from_targetname("player_position2b", level.player_hind);
    level.players[1].heli_pos[2] = make_custom_tag_from_targetname("player_position2c", level.player_hind);
    level.players[1] thread heli_unload();
  }

  foreach(var_1 in level.players) {
    var_1 teleport_and_clamp_view(var_1.heli_pos[0]);
    var_1 allowstand(0);
    var_1 allowprone(0);
  }

  level.player_hind thread make_invulnerable();
  level.player_hind fix_hind_doors_so();
}

make_invulnerable() {
  while(!common_scripts\utility::flag("hind_ready_for_land")) {
    self.health = 30000;
    wait 0.05;
  }

  wait 1;
}

heli_unload() {
  common_scripts\utility::flag_clear("laststand_on");
  common_scripts\utility::flag_wait("start_jet_strafe");
  common_scripts\utility::flag_set("laststand_on");
  var_0 = spawn_tag_to_loc(self.heli_pos[1]);
  self playerlinktoblend(self.heli_pos[1], "tag_origin", 0.25);
  wait 0.25;
  self playerlinktoblend(self.heli_pos[2], "tag_origin", 0.25);
  wait 0.25;
  self unlink();
  wait 1;
  self disableinvulnerability();
  self enableweapons();
  self allowstand(1);
  self allowprone(1);
}

fix_hind_doors_so() {
  wait 0.05;
  var_0 = [];
  var_0[0] = self;
  maps\_anim::anim_single(var_0, "open_door_idle", undefined, undefined, "ny_harbor_hind");
}

handle_reactor_setup() {
  thread setup_timer();
  thread setup_valve();
  thread setup_steam();
  thread setup_lights();
  thread setup_sounds();
  thread monitor_steam_shutoff();

  foreach(var_1 in level.players) {}
  var_1 thread missing_objective_warning("so_missed_reactor_objective", &"SO_ZODIAC2_NY_HARBOR_HINT_OBJ_MISSED", "reactor_saved");

  level waittill("rotation_counter");
  thread opendoor("door_reactor2", "org_door_reactor2", 100, "reactor_clip2");
  thread opendoor("door_reactor3", "org_door_reactor3", 100, "reactor_clip3");
  maps\_utility::activate_trigger_with_noteworthy("reactor_spawner");
}

missing_objective_warning(var_0, var_1, var_2) {
  level endon("special_op_terminated");

  if(!common_scripts\utility::flag(var_2)) {
    level.objective_warning_triggers = getEntArray(var_0, "script_noteworthy");

    while(!common_scripts\utility::flag(var_2)) {
      wait 0.05;

      foreach(var_4 in level.objective_warning_triggers) {
        if(!isDefined(self.obj_missed_active)) {
          if(self istouching(var_4)) {
            self.obj_missed_active = 1;
            thread ping_objective_warning(var_1, var_4, var_2);
          }

          continue;
        }

        if(!isDefined(self.ping_objective_splash)) {
          thread ping_objective_warning(var_1, var_4, var_2);
        }
      }
    }
  }
}

setup_timer() {
  common_scripts\utility::flag_wait("hatch_open");
  thread thermite_timer_reactor_room();
}

setup_sounds() {
  level waittill("in_missile_room2");
  var_0 = getEnt("camera_reactor", "targetname");
  var_0 playLoopSound("sub_emt_alarm_01");
  level.reactor_valve play_valve_sounds();
  common_scripts\utility::flag_wait("reactor_saved");
  var_0 stoploopsound();
}

setup_lights() {
  var_0 = common_scripts\utility::getStructArray("ambient_light", "targetname");
  common_scripts\utility::array_thread(var_0, ::make_lights);
}

make_lights() {
  var_0 = spawn_tag_to_loc(self);
  common_scripts\utility::flag_wait("reactor_saved");
}

sync_with(var_0) {
  for(;;) {
    angles_and_origin(var_0);
    wait 0.05;
  }
}

setup_valve() {
  level.reactor_valve = getEnt("reactor_valve", "targetname");
  var_0 = make_shiny_valve(level.reactor_valve);
  var_0 thread sync_with(level.reactor_valve);
  level.valve_in_use = 0;
  var_1 = undefined;
  level.reactor_valve.rotation = 0;

  while(!common_scripts\utility::flag("reactor_saved")) {
    show_shiny_valve(var_0);
    reset_valve_interaction(var_1);
    var_0 waittill("trigger", var_2);
    level.reactor_valve thread turning(var_2);
    hide_shiny_valve(var_0);
    var_1 = spawn_tag_to_loc(level.reactor_valve);

    if(var_1 _id_3F42(6, var_2)) {
      common_scripts\utility::flag_set("reactor_saved");
      var_0 hide();
      level.reactor_valve show();
      break;
    }
  }
}

reset_valve_interaction(var_0) {
  if(isDefined(var_0)) {
    var_0 delete();
  }
  if(level.reactor_valve.rotation > 0) {
    level.reactor_valve thread reverse_turning();
  }
}

show_shiny_valve(var_0) {
  var_0 makeusable();
  level.reactor_valve hide();
  var_0 show();
}

hide_shiny_valve(var_0) {
  var_0 makeunusable();
  var_0 hide();
  level.reactor_valve show();
}

turning(var_0) {
  var_1 = 10;

  while(var_0 useButtonPressed()) {
    level.valve_in_use = 1;
    var_2 = self.angles;
    self rotateTo((var_2[0], var_2[1], var_2[2] - var_1), 0.1);
    self.rotation = self.rotation + var_1;
    level.turn_time = level.turn_time - 0.1;
    wait 0.1;

    if(var_0.laststand == 1) {
      break;
    }

    if(common_scripts\utility::flag("reactor_saved")) {
      break;
    }
  }

  level.valve_in_use = 0;
}

play_valve_sounds() {
  while(!level.valve_in_use) {
    wait 0.05;
  }
  self playLoopSound("sub_emt_vent_steamy");
  var_0 = spawn_tag_to_loc(self);
  common_scripts\utility::flag_wait("reactor_saved");
  self stoploopsound();
  var_0 waittill("sound_done");
  var_0 delete();
}

reverse_turning(var_0) {
  self endon("trigger");
  var_1 = 5;

  while(!players_use_button() && !self.rotation <= 0 && !common_scripts\utility::flag("reactor_saved")) {
    var_2 = self.angles;
    self rotateTo((var_2[0], var_2[1], var_2[2] + var_1), 0.1);
    self.rotation = self.rotation - var_1;
    level.turn_time = level.turn_time + 0.05;
    wait 0.1;
  }
}

players_use_button() {
  level.pressed = 0;

  foreach(var_1 in level.players) {
    if(var_1 useButtonPressed()) {
      level.pressed++;
    }
  }

  if(level.pressed > 0) {
    return 1;
  } else {
    return 0;
  }
}

monitor_steam_shutoff() {
  var_0 = level.reactor_valve.rotation;

  while(!common_scripts\utility::flag("reactor_saved")) {
    if(var_0 < level.reactor_valve.rotation - 10 || var_0 > level.reactor_valve.rotation + 10) {
      level notify("rotation_counter");
      var_0 = level.reactor_valve.rotation;
    }

    wait 0.05;
  }
}

_id_3F42(var_0, var_1) {
  if(maps\_shg_common::progress_bar(var_1, undefined, level.turn_time, &"SO_ZODIAC2_NY_HARBOR_HINT_VALVE_TURNING", &"SO_ZODIAC2_NY_HARBOR_HINT_DISARM_SUCCESS", undefined, undefined)) {
    return 1;
  } else {
    return 0;
  }
}

make_shiny_valve(var_0) {
  var_1 = "ny_harbor_sub_pipe_valve_02_obj";
  var_2 = spawn("script_model", var_0.origin);
  var_2 setModel(var_1);
  var_2 angles_and_origin(var_0);
  var_2 setHintString(&"SO_ZODIAC2_NY_HARBOR_HINT_VALVE");
  return var_2;
}

setup_steam() {
  var_0 = getEntArray("reactor_steam", "targetname");
  var_1 = make_steam(var_0);
  var_1 = maps\_utility::array_randomize(var_1);
  var_2 = 0;

  while(!common_scripts\utility::flag("reactor_saved")) {
    var_3 = level.reactor_valve.rotation;
    level waittill("rotation_counter");

    if(var_3 < level.reactor_valve.rotation) {
      if(isDefined(var_1[var_2])) {
        stopFXOnTag(common_scripts\utility::getfx("steam_jet1"), var_1[var_2], "tag_origin");
        var_1[var_2] stoploopsound();
      }

      var_2++;
      continue;
    }

    if(isDefined(var_1[var_2])) {
      playFXOnTag(common_scripts\utility::getfx("steam_jet1"), var_1[var_2], "tag_origin");
      var_1[var_2] playLoopSound("sub_emt_steam_lp_01");
    }

    var_2--;
  }

  common_scripts\utility::flag_wait("reactor_saved");

  foreach(var_5 in var_1) {}
  stopFXOnTag(common_scripts\utility::getfx("steam_jet1"), var_5, "tag_origin");
}

make_steam(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in var_0) {
    var_1[var_4] = spawn_tag_to_loc(var_3);
    playFXOnTag(common_scripts\utility::getfx("steam_jet1"), var_1[var_4], "tag_origin");
    var_1[var_4] playLoopSound("sub_emt_steam_lp_01");
  }

  return var_1;
}

setup_missile_room() {
  door_blockers();
  thread thermite_hunt();
  thread combat_missile_room1();
  thread combat_after_thermite();
}

combat_missile_room1() {
  thread open_doors_with_animations();
  common_scripts\utility::flag_wait("kill_spawners_1");
  var_0 = spawn_missile_room_1_guys("spawner_mis1_1", ::add_enemy_flashlight);
  common_scripts\utility::array_thread(level.players, ::thermal_reminder_on, "thermal_reminder_trig");
  common_scripts\utility::array_thread(level.players, ::thermal_reminder_off, "exit_missile_room_1");
  common_scripts\utility::flag_wait("in_missile_room");
  common_scripts\utility::array_thread(level.players, ::put_light_on_players);
  waittill_guys_are_dead(var_0);
  common_scripts\utility::flag_set("bombs_defused_missile_room");
  thread play_alarm_missile_room();
}

timer(var_0, var_1) {
  wait(var_0);
  self notify(var_1);
}

thermal_reminder_on(var_0) {
  for(;;) {
    var_1 = get_and_wait_for_trigger(var_0);

    if(var_1 == self && !self.thermal) {
      self forceusehinton(&"SO_ZODIAC2_NY_HARBOR_HINT_THERMAL_ON");
      thread timer(3.5, "timer_up");
      common_scripts\utility::waittill_either("thermal_on", "timer_up");
      self forceusehintoff();
      break;
    }
  }
}

thermal_reminder_off(var_0) {
  for(;;) {
    var_1 = get_and_wait_for_trigger(var_0);

    if(var_1 == self && self.thermal) {
      self forceusehinton(&"SO_ZODIAC2_NY_HARBOR_HINT_THERMAL_ON");
      thread timer(3.5, "timer_up");
      common_scripts\utility::waittill_either("thermal_off", "timer_up");
      self forceusehintoff();
      break;
    }
  }
}

get_and_wait_for_trigger(var_0) {
  var_1 = getEnt(var_0, "targetname");
  var_1 waittill("trigger", var_2);
  return var_2;
}

play_alarm_missile_room() {
  var_0 = getEnt("camera1", "targetname");
  var_1 = getEnt("camera2", "targetname");
  var_1 playLoopSound("sub_emt_alarm_01");
  var_0 playLoopSound("sub_emt_alarm_01");
  wait 1;
  level notify("trigger_missile_bombs");
}

open_doors_with_animations() {
  thread move_big_block();
  common_scripts\utility::flag_wait("bombs_defused_missile_room");
  var_0 = getEnt("spawners_door_guys", "targetname");

  if(level.single_player) {
    var_1 = getEnt("upper_vol", "targetname");
    var_2 = getEnt("big_coll_block1_b", "targetname");
    var_2 notsolid();
    var_3 = getEnt("big_coll_block2_b", "targetname");
    var_3 notsolid();
    var_4 = getEnt("big_coll_block1", "targetname");
    var_4 notsolid();
    var_5 = getEnt("big_coll_block2", "targetname");
    var_5 notsolid();

    if(var_1 istouching(level.players[0])) {
      thread anim_open_door(var_0, "door_open_north_top_org", "door_missile_room_1_1", "door_clip_top_north");
      level.players[0].upper_floor = 1;
      return;
    }

    thread anim_open_door(var_0, "door_open_north_org", "door_missile_room_1_2", "door_clip_bottom_north");
    return;
  } else {
    thread anim_open_door_special(var_0, "door_open_south_org", "door_missile_room_1_3", "door_clip_top_south", "door_exit_1_3_origin", "door_exit_1_3_coll2");
    wait 0.5;
    thread anim_open_door(var_0, "door_open_north_org", "door_missile_room_1_2", "door_clip_bottom_north");
  }
}

coll_not_solid_if_player_is_near(var_0) {
  var_1 = getEnt(var_0, "targetname");
  var_2 = getEnt("vol_for_door_coll_issue", "targetname");

  for(;;) {
    wait 0.05;

    if(players_touching(var_2)) {
      var_1 notsolid();
    } else {
      var_1 solid();
    }
    if(common_scripts\utility::flag("door_3_is_open") && !players_touching(var_2)) {
      var_1 solid();
      break;
    }
  }
}

players_touching(var_0) {
  foreach(var_2 in level.players) {
    if(var_0 istouching(var_2)) {
      return 1;
    }
  }

  return 0;
}

anim_open_door_special(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getEnt(var_1, "targetname");
  var_7 = getEnt(var_3, "targetname");
  var_8 = getEnt(var_2, "targetname");
  var_9 = getEnt(var_5, "targetname");
  var_10 = getEnt("path_blocker", "targetname");
  var_9 notsolid();
  var_10 notsolid();
  var_11 = getEnt("vol_for_door_coll_issue", "targetname");
  var_6 spawn_guy_and_start_door_anim(var_0);
  wait 6.83333;
  var_12 = getEnt(var_4, "targetname");
  var_13 = spawn_tag_to_loc(var_12);
  var_9 linkTo(var_13, "tag_origin");
  var_8 linkTo(var_13, "tag_origin");
  var_13 rotateTo((0, 80, 0), 1);
  wait 1;
  var_13 rotateTo((0, 120, 0), 1.1);
  wait 1;
  var_7.origin = (0, 0, 0);
  wait 5.83333;
  common_scripts\utility::flag_set("door_3_is_open");
  var_7 connectpaths();
  var_10 solid();
  var_10 connectpaths();
  var_9 connectpaths();
}

move_big_block() {
  var_0 = getEnt("big_coll_block2", "targetname");
  var_1 = getEnt("big_coll_block1", "targetname");
  var_1 notsolid();
  var_2 = getEnt("big_coll_block2_b", "targetname");
  var_3 = getEnt("big_coll_block1_b", "targetname");
  var_3 notsolid();
  var_4 = var_0.origin;
  var_5 = var_1.origin;
  var_6 = var_3.origin;
  common_scripts\utility::flag_wait("bombs_defused_missile_room");
  wait 6.83333;
  var_0 moveTo(var_5, 1.5);
  var_2 moveTo(var_6, 1.5);
  wait 1.5;
  var_0 connectpaths();
  var_2 connectpaths();
  var_1 connectpaths();
  var_3 connectpaths();
  var_0 delete();
}

spawn_guy_and_start_door_anim(var_0) {
  wait(randomfloatrange(0.5, 1.2));
  var_1 = var_0 stalingradspawn();

  if(isDefined(var_1)) {
    var_2 = self.animation;
    var_1.animname = "generic";
    thread maps\_anim::anim_generic(var_1, var_2);
    var_1 thread stop_anim_if_dead();
  }
}

anim_open_door(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getEnt(var_1, "targetname");
  var_6 = getEnt(var_3, "targetname");
  var_7 = getEnt(var_2, "targetname");
  var_7.origin = (0, 0, 0);
  var_8 = maps\_utility::spawn_anim_model("door", var_5.origin);
  var_9 = "open_with_wheel";
  var_5 maps\_anim::anim_first_frame_solo(var_8, var_9);
  var_5 spawn_guy_and_start_door_anim(var_0);
  var_8.animname = "door";
  var_8 maps\_anim::setanimtree();
  var_5 thread maps\_anim::anim_single_solo(var_8, var_9);
  wait 7.83333;
  var_6.origin = (0, 0, 0);
  var_6 connectpaths();
}

stop_anim_if_dead() {
  while(isDefined(self) && self.health > 10) {
    wait 0.05;
  }
  if(isDefined(self)) {
    self stopanimScripted();
  }
}

waittill_guys_are_dead(var_0) {
  var_1 = var_0.size - 2;
  var_2 = var_0.size - var_1;

  while(var_0.size > var_2) {
    var_0 = maps\_utility::array_removedead(var_0);
    wait 0.05;
  }
}

add_enemy_flashlight() {}

thermite_hunt() {
  var_0 = getEntArray("therm_mis1", "targetname");
  common_scripts\utility::array_call(var_0, ::delete);
}

thermite_setup(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_5 = [];
  var_5 = getEntArray(var_1, "targetname");
  var_5 = maps\_utility::array_randomize(var_5);

  if(!isDefined(var_0)) {
    var_0 = var_5.size;
  }
  foreach(var_7 in var_5) {}
  var_7 hide();

  for(var_9 = 0; var_9 < var_0; var_9++) {
    var_5[var_9] show();
    var_4[var_4.size] = var_5[var_9];
    var_5[var_9] thread create_bomb_lights(var_2);
  }

  return var_4;
}

create_bomb_lights(var_0) {
  if(isDefined(var_0)) {
    level waittill(var_0);
  }
  var_1 = self gettagangles("tag_fx");
  var_2 = anglestoup(var_1);
  var_3 = self.origin + var_2 * 5;
  self.tag_light = common_scripts\utility::spawn_tag_origin();
  self.tag_light.origin = var_3;
  wait(randomfloatrange(0.1, 0.6));
  playFXOnTag(level._effect["red_dot"], self.tag_light, "tag_origin");
  playFXOnTag(level._effect["light_c4_blink"], self, "tag_fx");
  playFXOnTag(level._effect["light_c4_blink"], self, "tag_fx");
  playFXOnTag(level._effect["red_dot"], self, "tag_fx");
  playFXOnTag(level._effect["white_light"], self, "tag_fx");
  thread beep_cycle();
}

beep_cycle() {
  if(!isDefined(self.defused)) {
    self.defused = 0;
  }
  while(!self.defused) {
    if(isDefined(self)) {
      thread maps\_utility::play_sound_on_entity("veh_mine_beep");
    } else {
      break;
    }
    wait 1;
  }
}

monitor_remaining_bombs(var_0, var_1) {
  level.bombs = var_1.size + 1;

  while(!common_scripts\utility::flag(var_0)) {
    if(var_1.size < 1) {
      common_scripts\utility::flag_set(var_0);
    } else {
      foreach(var_3 in var_1) {
        if(isDefined(var_3.defused) && var_3.defused) {
          var_1 = common_scripts\utility::array_remove(var_1, var_3);
          level.bombs--;

          if(level.bombs == 1) {
            level notify("one_bomb_left");
          }
          if(level.bombs == var_1.size) {
            level notify("one_bomb_defused");
          }
        }
      }
    }

    wait 0.05;
  }
}

opendoor(var_0, var_1, var_2, var_3) {
  var_4 = 3;
  var_5 = getEnt(var_0, "targetname");
  var_6 = getEnt(var_1, "targetname");
  var_7 = spawn_tag_to_loc(var_6);
  var_5 linkTo(var_7, "tag_origin");
  var_7 rotateTo((0, var_2, 0), var_4);
  wait(var_4 / 2);

  if(isDefined(var_3)) {
    var_8 = getEnt(var_3, "targetname");
    var_8.origin = (0, 0, 0);
    var_8 connectpaths();
  }
}

get_index_in_array(var_0, var_1) {
  var_2 = -1;

  foreach(var_5, var_4 in var_0) {
    if(var_4 == var_1) {
      var_2 = var_5;
    }
  }

  return var_2;
}

thermite_timer_reactor_room() {
  var_0 = 300;
  thread start_countdown(var_0, &"SO_ZODIAC2_NY_HARBOR_HINT_MELTDOWN", "times_up_reactor");
  thread thermite_fail("times_up_reactor", "reactor_saved");
  thread timer_hud_remove_if_valve_in_use();
  common_scripts\utility::flag_wait("reactor_saved");

  foreach(var_2 in level.elements) {
    if(isDefined(var_2)) {
      var_2 destroy();
    }
  }
}

timer_hud_remove_if_valve_in_use() {
  while(!common_scripts\utility::flag("reactor_saved")) {
    if(level.valve_in_use) {
      level.elements hud_alpha(0);
    } else {
      level.elements hud_alpha(1);
    }
    wait 0.05;
  }
}

hud_alpha(var_0) {
  foreach(var_2 in self) {
    if(isDefined(var_2)) {
      var_2.alpha = var_0;
    }
  }
}

thermite_fail(var_0, var_1) {
  common_scripts\utility::flag_wait(var_0);
  var_2 = getEntArray("nuke_view", "targetname");
  wait 0.25;

  while(level.valve_in_use) {
    wait 0.5;
  }
  if(!common_scripts\utility::flag(var_1)) {
    var_3 = blackout(&"SO_ZODIAC2_NY_HARBOR_HINT_FAIL");
    var_3 thread fadeblackout(0.25);
    wait 0.5;
    end_mission_fail();
  }
}

end_mission_fail() {
  level.challenge_end_time = gettime();
  maps\_specialops::so_force_deadquote("@DEADQUOTE_SO_TRY_NEW_DIFFICULTY");
  maps\_utility::missionfailedwrapper();
}

teleport_and_clamp_view(var_0) {
  teleport_player_so(var_0);
  self playerlinktodelta(var_0, "tag_origin", 1);
  self lerpviewangleclamp(0, 0.5, 0, 110, 110, 90, 90);
}

teleport_player_so(var_0) {
  self setOrigin(var_0.origin);

  if(isDefined(var_0.angles)) {
    self setplayerangles(var_0.angles);
  }
}

put_light_on_players() {
  var_0 = getEnt("exit_missile_room_1", "targetname");

  for(;;) {
    var_0 waittill("trigger", var_1);
    level notify("in_missile_room2");

    if(var_1 == self) {
      break;
    }
  }
}

combat_after_thermite() {
  common_scripts\utility::flag_wait("bombs_defused_missile_room");
  maps\_utility::activate_trigger_with_noteworthy("f_spawner_mis2");
}

enemy_ai_for_sub() {
  var_0 = 0.7;
  var_1 = 1;
  maps\_utility::enable_cqbwalk();
  self.accuracy = var_0;
  self.baseaccuracy = self.baseaccuracy * var_1;

  if(common_scripts\utility::cointoss()) {
    self.ignoresuppression = 1;
  } else {
    self.ignoresuppression = 0;
  }
}

door_blockers() {
  var_0 = getEntArray("pressure_door_model", "targetname");
  common_scripts\utility::array_call(var_0, ::delete);
  var_1 = getEntArray("pressure_door_coll", "targetname");
  common_scripts\utility::array_call(var_1, ::delete);
  var_2 = getEntArray("sub_pressuredoor_rocker_opposite", "targetname");
  common_scripts\utility::array_call(var_2, ::delete);
  var_3 = getEntArray("sub_pressuredoor_rocker", "targetname");
  common_scripts\utility::array_call(var_3, ::delete);
  var_4 = getEntArray("ladder_coll_bridge_exit", "targetname");
  common_scripts\utility::array_call(var_4, ::delete);
  delete_this("barracks_door_coll_01", 1);
  delete_this("breach_door_col");
  delete_this("brush_missile_room_door", 1);
  delete_this("clip_reactor_room_hall_door", 1);
  delete_this("clip_barracks_exit", 1);
  delete_this("barracks_open_door_col", 1);
  delete_this("barracks_open_door_right_col", 1);
  delete_this("sub_graph_blocker", 1);
  level.frag = getEnt("frag_grenade", "targetname");
  level.frag hide();
}

delete_this(var_0, var_1) {
  var_2 = getEnt(var_0, "targetname");

  if(isDefined(var_2)) {
    var_2.origin = (0, 0, 0);

    if(isDefined(var_1)) {
      var_2 connectpaths();
    }
  }
}

open_hatch() {
  foreach(var_1 in level.players) {}
  var_1.ladder = 0;

  common_scripts\utility::flag_wait("open_rear_hatch");
  maps\_compass::setupminimap("compass_map_ny_harbor");
  var_3 = getEntArray("rear_hatch_collision", "targetname");
  common_scripts\utility::array_call(var_3, ::delete);
  var_4 = getEnt("hatch_component1", "targetname");
  var_5 = getEnt("hatch_component2", "targetname");
  var_6 = getEnt("hatch_org", "targetname");
  var_7 = spawn_tag_to_loc(var_6);
  var_4 linkTo(var_7, "tag_origin");
  var_5 linkTo(var_7, "tag_origin");
  var_7 rotateTo((154, 0, 180), 1.35);
  level notify("spawn_exit_chopper");
}

handle_exit_movement() {
  thread open_hatch();
  thread handle_ladder_up_down("hatch_player_slide", "exit_trigger_sub", "check_for_player_using_ladder");
}

handle_ladder_up_down(var_0, var_1, var_2) {
  thread hatch_player_slide(var_0, "exit_ladder_pos1", "exit_ladder_pos0");
  var_3 = getEnt(var_0, "targetname");
  var_3.moved = 0;
  common_scripts\utility::array_thread(level.players, ::hide_trigger_when_ladder_in_use, var_3, var_2);
  var_4 = getEnt(var_1, "targetname");

  for(;;) {
    var_4 waittill("trigger", var_5);
    var_5 move_guy_up();
  }
}

hide_trigger_when_ladder_in_use(var_0, var_1) {
  var_2 = getEnt(var_1, "targetname");
  var_3 = var_0.origin;

  for(;;) {
    wait 0.05;

    if(var_2 istouching(self) && !var_0.moved) {
      var_0.moved = 1;
      var_0.origin = (50, 50, 50);
      continue;
    }

    if(!var_2 istouching(self) && var_0.moved) {
      var_0.origin = var_3;
      var_0.moved = 0;
    }
  }
}

hide_trigger_when_ladder_in_use_front(var_0, var_1) {
  var_2 = getEnt(var_1, "targetname");
  var_3 = var_0.origin;

  for(;;) {
    wait 0.05;

    if(var_2 istouching(self) && !var_0.moved) {
      var_0.moved = 1;
      var_0.origin = (50, 50, 50);
      continue;
    }

    if(!var_2 istouching(self) && var_0.moved && isoktouseladder(self)) {
      var_0.origin = var_3;
      var_0.moved = 0;
    }
  }
}

isoktouseladder(var_0) {
  var_1 = getEnt("ladder_safety_clip_vol", "targetname");

  if(!level.single_player) {
    foreach(var_3 in level.players) {
      if(var_1 istouching(var_3)) {
        return 0;
      }
    }

    return 1;
  } else {
    return 1;
  }
}

hatch_player_slide(var_0, var_1, var_2) {
  var_3 = getEnt(var_0, "targetname");
  var_4 = getEnt("dont_allow_ladder", "targetname");

  for(;;) {
    var_3 setHintString(&"NY_HARBOR_HINT_USE_TO_ENTER");
    var_3 useTriggerRequireLookAt();
    var_3 waittill("trigger", var_5);

    if(!var_4 istouching(var_5)) {
      var_5 move_guy_down(var_1, var_2);
    }
  }
}

player_using_ladder() {
  var_0 = getEnt("check_for_player_using_ladder", "targetname");

  foreach(var_2 in level.players) {
    if(var_0 istouching(var_2)) {
      return 1;
    }
  }

  return 0;
}

move_guy_down(var_0, var_1) {
  var_2 = getEnt(var_0, "targetname");
  var_3 = getEnt(var_1, "targetname");

  if(!self.ladder && !player_using_ladder()) {
    var_4 = spawn_tag_to_loc(self);
    self.ladder = 1;
    self playerlinkTo(var_4, "tag_origin", 1);
    var_4 moveTo(var_2.origin, 0.25);
    wait 0.25;
    var_4 moveTo(var_3.origin, 0.75);
    var_4 rotateTo(var_3.angles, 0.75);
    wait 0.8;
    self unlink();
    self.ladder = 0;
    var_4 delete();
  }
}

move_guy_up() {
  var_0 = getEnt("exit_ladder_pos1", "targetname");
  var_1 = getEnt("exit_ladder_pos2_p0", "targetname");
  var_2 = getEnt("exit_ladder_pos2_p1", "targetname");

  if(!self.ladder) {
    var_3 = spawn_tag_to_loc(self);
    self.ladder = 1;
    self playerlinkTo(var_3, "tag_origin", 1);
    var_3 moveTo(var_0.origin, 1);
    wait 1;

    if(self == level.players[0]) {
      var_3 moveTo(var_1.origin, 1);
      var_3 rotateTo(var_1.angles, 1);
    } else {
      var_3 moveTo(var_2.origin, 1);
      var_3 rotateTo(var_2.angles, 1);
    }

    wait 1;
    self unlink();
    self.ladder = 0;
  }
}

handle_exit() {
  thread handle_exit_chopper();
  thread remove_end_mission_triggers();
  thread handle_enemy_choppers();
  thread handle_exit_movement();
  thread close_hatch_rear();
  common_scripts\utility::flag_wait("reactor_saved");
  common_scripts\utility::flag_init("so_exit_volume");
  maps\_specialops::enable_triggered_complete("so_exit_volume", "so_zodiac2_ny_harbor_complete", "all");
  common_scripts\utility::flag_wait("so_zodiac2_ny_harbor_complete");
  var_0 = getaiarray("axis");
  common_scripts\utility::array_call(var_0, ::kill);
}

remove_end_mission_triggers() {
  level waittill("spawn_exit_chopper");
  var_0 = getEntArray("player_trying_to_escape", "targetname");

  foreach(var_2 in var_0) {}
  var_2.origin = (0, 0, 0);
}

handle_enemy_choppers() {
  common_scripts\utility::flag_wait("spawn_enemy_chopper2");
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("end_enemy_chopper2");
}

handle_exit_chopper() {
  common_scripts\utility::flag_wait("spawn_exit_chopper");
  var_0 = getEnt("so_exit_volume", "script_noteworthy");
  maps\_audio::aud_send_msg("so_start_harbor_exit_hind", level.player_hind);
  var_0 thread move_vol_with_veh(level.player_hind);
}

fire_at_enemies_when_close() {
  common_scripts\utility::flag_wait("shoot_at_stragglers");

  for(;;) {
    wait 0.05;
    var_0 = maps\_utility::get_closest_ai(self.origin, "axis");
    var_1 = self.fire_tags[randomint(self.fire_tags.size)];

    if(isDefined(var_0)) {
      var_1 shoot_dude(var_0);
    }
  }
}

shoot_dude(var_0) {
  var_1 = randomintrange(5, 12);

  for(var_2 = 0; var_2 < var_1; var_2++) {
    if(isDefined(var_0)) {
      inaccurate_magicbullet("mp7_reflex", 15, var_0.origin, self);
    }
    wait 0.05;
  }
}

move_vol_with_veh(var_0) {
  for(;;) {
    self.origin = var_0.origin;
    wait 0.05;
  }
}

open_hatch_rear() {
  var_0 = getEnt("rear_hatch_col", "targetname");
  var_0 notsolid();
  common_scripts\utility::flag_wait("hatch_open");
  var_1 = create_hatch_movable();
  maps\_compass::setupminimap("compass_map_ny_harbor_sub", "sub_minimap_corner");
  setsaveddvar("compassmaxrange", 1000);
  var_1 rotateTo((89, var_1.angles[1], var_1.angles[2]), 3);
}

close_hatch_rear() {
  var_0 = getEnt("exit_missile_room_1", "targetname");
  common_scripts\utility::array_thread(level.players, ::verify_player_in_sub, var_0);
  var_1 = getEnt("ladder_brush_bridge", "targetname");
  var_2 = var_1.origin;
  var_1.origin = (50, 50, 50);
  common_scripts\utility::flag_wait("spawn_enemy_chopper2");
  var_3 = getEnt("sight_trigger_front_hatch", "targetname");
  var_3.origin = (50, 50, 50);

  if(common_scripts\utility::flag("close_hatch")) {
    var_4 = create_hatch_movable();
    var_4 rotateTo((-89, var_4.angles[1], var_4.angles[2]), 3);
    var_5 = getEnt("rear_hatch_col", "targetname");
    var_5 solid();
    var_6 = getEnt("rear_hatch_cap", "targetname");
    var_6 solid();
    var_7 = getEnt("rear_cap_coll_2", "targetname");
    var_7 solid();
  } else {
    var_1.origin = var_2;
  }
}

verify_player_in_sub(var_0) {
  level.is_in_sub = 0;

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(var_1 == self) {
      level.is_in_sub++;

      if(level.is_in_sub == level.players.size) {
        common_scripts\utility::flag_set("close_hatch");
      }
      break;
    }
  }
}

create_hatch_movable() {
  var_0 = getEnt("rear_hatch_component1", "targetname");
  var_1 = getEnt("rear_hatch_component2", "targetname");
  var_2 = getEnt("rear_hatch_col_top", "targetname");
  var_2 notsolid();
  var_3 = getEnt("rear_hatch_org", "targetname");
  var_4 = spawn_tag_to_loc(var_3);
  var_0 linkTo(var_4, "tag_origin");
  var_1 linkTo(var_4, "tag_origin");
  var_2 linkTo(var_4, "tag_origin");
  var_5 = getEnt("rear_hatch_col_interior", "targetname");
  var_5 notsolid();
  return var_4;
}

make_custom_tag_from_structarray(var_0, var_1) {
  var_2 = [];
  var_3 = common_scripts\utility::getStructArray(var_0, "targetname");

  foreach(var_5 in var_3) {
    var_6 = make_tag_with_origin(var_5, var_1);
    var_2[var_2.size] = var_6;
  }

  return var_2;
}

make_custom_tag_from_struct(var_0, var_1) {
  var_2 = common_scripts\utility::getStruct(var_0, "targetname");
  var_3 = make_tag_with_origin(var_2, var_1);
  return var_3;
}

make_custom_tag_from_targetname(var_0, var_1) {
  var_2 = getEnt(var_0, "targetname");
  var_3 = make_tag_with_origin(var_2, var_1);
  return var_3;
}

make_custom_tag_from_ent(var_0, var_1) {
  var_2 = make_tag_with_origin(var_0, var_1);
  return var_2;
}

make_tag_with_origin(var_0, var_1) {
  var_2 = spawn_tag_to_loc(var_0);
  var_2 linkTo(var_1, "tag_origin");
  return var_2;
}

spawn_tag_to_loc(var_0) {
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1 angles_and_origin(var_0);
  return var_1;
}

angles_and_origin(var_0) {
  self.origin = var_0.origin;

  if(isDefined(var_0.angles)) {
    self.angles = var_0.angles;
  }
}

silo_doors_and_missiles() {
  thread play_smoke_for_missiles();
  var_0 = ["missile_hatch_r_8", "missiles_r_8", "missle_silo_r_5"];
  var_1 = ["missile_hatch_r_7", "missiles_r_7", "missle_silo_r_4", "missle_silo_r_3"];
  var_2 = ["missile_hatch_r_6", "missiles_r_6", "missle_silo_r_3"];
  var_3 = ["missile_hatch_r_5", "missiles_r_5", "missle_silo_r_3"];
  var_4 = ["missile_hatch_r_4", "missiles_r_4", "missle_silo_r_2"];
  var_5 = ["missile_hatch_r_3", "missiles_r_3", "missle_silo_r_2"];
  var_6 = ["missile_hatch_r_2", "missiles_r_2", "missle_silo_r_1"];
  var_7 = ["missile_hatch_r_1", "missiles_r_1", "missle_silo_r_1", "missle_silo_r_0"];
  var_8 = ["missile_hatch_r_1", "missiles_r_1", "missle_silo_r_0"];
  var_9 = ["missile_hatch_l_8", "missiles_l_8", "missle_silo_l_5"];
  var_10 = ["missile_hatch_l_7", "missiles_l_7", "missle_silo_l_4", "missle_silo_l_3"];
  var_11 = ["missile_hatch_l_6", "missiles_l_6", "missle_silo_l_3"];
  var_12 = ["missile_hatch_l_5", "missiles_l_5", "missle_silo_l_3"];
  var_13 = ["missile_hatch_l_4", "missiles_l_4", "missle_silo_l_2"];
  var_14 = ["missile_hatch_l_3", "missiles_l_3", "missle_silo_l_2"];
  var_15 = ["missile_hatch_l_2", "missiles_l_2", "missle_silo_l_1"];
  var_16 = ["missile_hatch_l_1", "missiles_l_1", "missle_silo_l_1", "missle_silo_l_0"];
  var_17 = ["missile_hatch_l_1", "missiles_l_1", "missle_silo_l_0"];
  level.right_missile_groups = [];
  level.right_missile_groups[0] = var_0;
  level.right_missile_groups[1] = var_8;
  level.left_missile_groups = [];
  level.left_missile_groups[0] = var_9;
  level.left_missile_groups[1] = var_17;
  common_scripts\utility::flag_wait("hind_ready_for_land");
  close_doors_and_delete();
}

random_missile_launch(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = [];
  wait(randomfloatrange(1.0, 4.0));

  while(!common_scripts\utility::flag("in_missile_room")) {
    var_4 = randomint(var_0.size);

    if(!isDefined(var_3[var_4])) {
      var_1[var_1.size] = open_missile_silo(var_0[var_4][2], var_4);
      var_3[var_4] = 1;
    } else {
      wait 4;
    }
    var_2[var_2.size] = open_missile_hatch(var_0[var_4][0]);
    launch_ssn19(var_0[var_4][1]);
    wait(randomfloatrange(0.05, 0.5));
  }
}

close_doors_and_delete(var_0, var_1) {
  var_2 = getEntArray("missile_silo_door", "targetname");
  common_scripts\utility::array_call(var_2, ::hide);
  var_3 = getEntArray("missle_silo_pocket_middle", "targetname");
  common_scripts\utility::array_call(var_3, ::hide);
  var_4 = getEntArray("missle_silo_pocket", "targetname");
  common_scripts\utility::array_call(var_4, ::hide);
  var_5 = getEntArray("missle_silo_pocket_rear", "targetname");
  common_scripts\utility::array_call(var_5, ::hide);
}

open_missile_hatch(var_0) {
  var_1 = getEntArray(var_0, "script_noteworthy");
  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(!isDefined(var_4.targetname)) {
      continue;
    }
    if(var_4.targetname == "missile_hatch") {
      var_2 = var_4;
      break;
    }
  }

  var_2.animname = "missile_hatch";
  var_2 maps\_anim::setanimtree();
  var_6 = common_scripts\utility::spawn_tag_origin();
  var_6.origin = var_2.origin;
  var_6.angles = (270, 0, 0);
  playFXOnTag(common_scripts\utility::getfx("steam_missile_tube"), var_6, "tag_origin");
  var_2 maps\_anim::anim_single_solo(var_2, "open");
  var_7 = randomfloat(3) + 2;
  wait(var_7);
  stopFXOnTag(common_scripts\utility::getfx("steam_missile_tube"), var_6, "tag_origin");
  var_6 delete();
  return var_2;
}

open_missile_silo(var_0, var_1) {
  var_2 = getEntArray(var_0, "script_noteworthy");
  var_3 = undefined;

  foreach(var_5 in var_2) {
    if(!isDefined(var_5.targetname)) {
      continue;
    }
    if(var_5.targetname == "missile_silo_door") {
      var_3 = var_5;
      break;
    }
  }

  var_7 = undefined;

  foreach(var_5 in var_2) {
    if(!isDefined(var_5.targetname)) {
      continue;
    }
    if(var_5.targetname == var_3.target) {
      var_7 = var_5;
      break;
    }
  }

  var_3.animname = "missile_door";
  var_3 maps\_anim::setanimtree();
  var_7 linkTo(var_3, "door");
  maps\_audio::aud_send_msg("sub_missile_door_open", var_7);
  var_7 playSound("russian_sub_missile_door");
  var_3 maps\_anim::anim_single_solo(var_3, "open");
  return var_3;
}

play_ssn19fx(var_0) {
  wait 0.95;
  playFXOnTag(common_scripts\utility::getfx("ssn12_launch_smoke12"), self, "tag_tail");
  wait 0.5;
  maps\_utility::ent_flag_waitopen("contrails");
  stopFXOnTag(common_scripts\utility::getfx("ssn12_launch_smoke12"), self, "tag_tail");
}

play_ssn19fx_alt(var_0) {
  wait 0.5;
  playFXOnTag(common_scripts\utility::getfx("ssn12_launch_smoke"), self, "tag_tail");
  wait 0.5;
  playFXOnTag(common_scripts\utility::getfx("ssn12_init"), self, "tag_tail");
}

open_ssn19_wings() {
  self endon("death");
  wait 0.5;
  self setanim(level.scr_anim["ss_n_12_missile"]["open"], 1, 0);
}

launch_ssn19(var_0) {
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname(var_0);
  var_1.animname = "ss_n_12_missile";
  var_1 maps\_anim::setanimtree();
  var_1 setanim(var_1 maps\_utility::getanim("close_idle"), 1, 0);
  var_1.script_vehicle_selfremove = 1;
  var_1 thread play_ssn19fx(var_0);
  maps\_audio::aud_send_msg("so_sub_missile_launch", var_1);
  wait 0.75;
  var_1 thread open_ssn19_wings();
  thread maps\_vehicle::gopath(var_1);
  maps\_audio::aud_send_msg("so_sub_missile_launch", var_1);
}

stoprocking(var_0) {
  common_scripts\utility::flag_wait("so_zodiac2_ny_harbor_complete");
  level notify("stop_rocking");
  level.player playersetgroundreferenceent(undefined);
  self delete();

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

onoutsideofsub() {
  level.rocking_mag[0] = 0.5;
  level.rocking_mag[1] = 1.5;
  common_scripts\utility::flag_set("outside_above_water");
}

oninsideofsub() {
  level.rocking_mag[0] = 1.0;
  level.rocking_mag[1] = 2.5;
  common_scripts\utility::flag_clear("outside_above_water");
}

rockingsub() {
  level endon("stop_rocking");
  var_0 = getEnt("rocking_reference", "targetname");
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_2 = undefined;

  if(!isDefined(var_0)) {
    var_1.angles = (0, 0, 0);
  } else {
    var_1.origin = var_0.origin;
    var_1.angles = var_0.angles;
  }

  var_1 thread stoprocking(var_2);
  var_3 = 1;
  level.rocking_mag[0] = 1.0;
  level.rocking_mag[1] = 2.5;
  var_4 = getEntArray("rocking_water", "targetname");
  var_5 = getEntArray("bobbing_small", "script_noteworthy");

  foreach(var_7 in var_5) {
    var_7.start_origin = var_7.origin;
    var_7.start_angles = var_7.angles;
    var_8 = cos(var_7.angles[1]);
    var_9 = sin(var_7.angles[1]);
    var_7.rock_ang = (var_8, 0, var_9);
  }

  if(isDefined(var_2)) {
    foreach(var_7 in var_4) {}
    var_7 linkTo(var_2, "tag_origin");
  }

  thread setup_ent_rockers();
  self playersetgroundreferenceent(var_1);
  thread set_grav(var_1);

  for(;;) {
    var_13 = randomfloatrange(2.0, 3.0);
    var_14 = var_3 * randomfloatrange(level.rocking_mag[0], level.rocking_mag[1]);
    var_3 = -1 * var_3;
    var_15 = (0, 0, var_14);
    var_1.targetangles = var_15;
    var_1.targettime = gettime() + 1000 * var_13;
    maps\_audio::aud_send_msg("if_the_sub_is_a_rocking_dont_come_a_knocking");
    var_1 rotateTo(var_15, var_13, var_13 / 3, var_13 / 3);

    if(isDefined(var_2)) {
      var_15 = (0, 0, 0.5 * var_14);
      var_2 rotateTo(var_15, var_13, var_13 / 3, var_13 / 3);
    }

    wait(var_13);
  }
}

setup_ent_rockers() {
  level.rockers = [];
  level.rockers_opp = [];
  level.rocker_hangers = [];
  var_0 = getEntArray("sub_pressuredoor_rocker", "targetname");

  foreach(var_2 in var_0) {
    var_3 = getEnt(var_2.target, "targetname");
    var_2 linkTo(var_3);
    level.rockers[level.rockers.size] = var_3;
  }

  var_0 = getEntArray("sub_pressuredoor_rocker_opposite", "targetname");

  foreach(var_2 in var_0) {
    var_3 = getEnt(var_2.target, "targetname");
    var_2 linkTo(var_3);
    level.rockers_opp[level.rockers_opp.size] = var_3;
  }

  var_7 = getEntArray("dyn_hanger", "targetname");

  foreach(var_9 in var_7) {
    var_3 = getEnt(var_9.target, "targetname");
    var_9 linkTo(var_3);
    level.rocker_hangers[level.rocker_hangers.size] = var_3;
  }
}

rock_ents(var_0, var_1, var_2, var_3) {
  var_4 = 3 * (level.rocking_mag[1] * var_0);

  foreach(var_6 in level.rockers) {}
  var_6 rotateTo((var_6.angles[0], var_6.angles[1] + var_4, var_6.angles[0]), var_1, var_2, var_3);

  foreach(var_6 in level.rockers_opp) {}
  var_6 rotateTo((var_6.angles[0], var_6.angles[1] + -1 * var_4, var_6.angles[0]), var_1, var_2, var_3);

  foreach(var_6 in level.rocker_hangers) {
    switch (var_6.script_noteworthy) {
      case "x":
        var_6 rotateTo((var_6.angles[0] + var_4, var_6.angles[1], var_6.angles[0]), var_1, var_2, var_3);
        break;
      case "x_neg":
        var_6 rotateTo((var_6.angles[0] + -1 * var_4, var_6.angles[1], var_6.angles[0]), var_1, var_2, var_3);
        break;
      case "y":
        var_6 rotateTo((var_6.angles[0], var_6.angles[1] + var_4, var_6.angles[0]), var_1, var_2, var_3);
        break;
      case "y_neg":
        var_6 rotateTo((var_6.angles[0], var_6.angles[1] + -1 * var_4, var_6.angles[0]), var_1, var_2, var_3);
        break;
      case "z":
        var_6 rotateTo((var_6.angles[0], var_6.angles[1], var_6.angles[0] + var_4), var_1, var_2, var_3);
        break;
      case "z_neg":
        var_6 rotateTo((var_6.angles[0], var_6.angles[1], var_6.angles[0] + -1 * var_4), var_1, var_2, var_3);
        break;
      default:
        break;
    }
  }
}

rock_debris(var_0, var_1, var_2, var_3, var_4) {
  var_5 = (0, 1, 0);
  var_6 = var_1[2];
  var_7 = var_6 / 2.5;

  foreach(var_9 in var_0) {
    var_10 = randomfloatrange(4, 12);
    var_11 = var_9.start_origin + var_10 * var_7 * var_5;
    var_9 moveTo(var_11, var_2, var_3, var_4);
    var_12 = randomfloatrange(3 * level.rocking_mag[0], 3 * level.rocking_mag[1]);
    var_13 = var_12 * var_7;
    var_14 = (var_9.rock_ang[0] * var_13, var_9.rock_ang[1] * var_13, var_9.rock_ang[2] * var_13);
    var_1 = var_9.start_angles + var_14;
    var_9 rotateTo(var_1, var_2, var_3, var_4);
  }
}

set_grav(var_0) {
  level endon("stop_rocking");
  thread reset_grav();
  var_1 = 0;
  var_2 = common_scripts\utility::getStruct("jolter", "targetname");
  common_scripts\utility::flag_wait("hatch_player_using_ladder");

  for(;;) {
    var_3 = anglestoup(var_0.angles);
    var_4 = -1 * var_3;
    var_5 = var_4 * (1, 10, 0.75);
    var_6 = vectorNormalize(var_5);
    setphysicsgravitydir(var_6);
    var_1++;

    if(var_1 > 10) {
      physicsjitter(var_2.origin, 1000, 800, 0.01, 0.1);
      var_1 = 0;
    }

    wait 0.05;
  }
}

reset_grav() {
  level waittill("stop_rocking");
  wait 0.05;
  setphysicsgravitydir((0, 0, -1));
}

visions() {
  var_0 = maps\_utility::create_vision_set_fog("so_zodiac2_ny_harbor_sub_1");
  var_0.startdist = 163.765;
  var_0.halfwaydist = 624.903;
  var_0.red = 0.311765;
  var_0.green = 0.311765;
  var_0.blue = 0.321765;
  var_0.maxopacity = 0.332562;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 0;
  var_0.sunred = 0.75853;
  var_0.sungreen = 0.747528;
  var_0.sunblue = 0.658636;
  var_0.sundir = (-0.506012, 0.588929, 0.630171);
  var_0.sunbeginfadeangle = 0;
  var_0.sunendfadeangle = 17.001;
  var_0.normalfogscale = 3.83587;
  var_0 = maps\_utility::create_vision_set_fog("so_zodiac2_ny_harbor_sub_2");
  var_0.startdist = 263.765;
  var_0.halfwaydist = 624.903;
  var_0.red = 0.311765;
  var_0.green = 0.311765;
  var_0.blue = 0.321765;
  var_0.maxopacity = 0.232562;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 0;
  var_0.sunred = 0.75853;
  var_0.sungreen = 0.747528;
  var_0.sunblue = 0.658636;
  var_0.sundir = (-0.506012, 0.588929, 0.630171);
  var_0.sunbeginfadeangle = 0;
  var_0.sunendfadeangle = 17.001;
  var_0.normalfogscale = 3.83587;
  common_scripts\utility::flag_wait("in_missile_room");
  thread maps\_utility::vision_set_fog_changes("so_zodiac2_ny_harbor_sub_1", 1);
  level waittill("in_missile_room2");
  thread maps\_utility::vision_set_fog_changes("so_zodiac2_ny_harbor_sub_2", 2);
}

ping_objective_warning(var_0, var_1, var_2) {
  if(isDefined(self.ping_objective_splash)) {
    return;
  }
  if(!self istouching(var_1)) {
    return;
  }
  if(common_scripts\utility::flag(var_2)) {
    return;
  }
  self endon("death");
  self.ping_objective_splash = maps\_shg_common::create_splitscreen_safe_hud_item(3.5, 0, var_0);
  self.ping_objective_splash.alignx = "center";
  self.ping_objective_splash.horzalign = "center";

  while(self istouching(var_1)) {
    self.ping_objective_splash.alpha = 1;
    self.ping_objective_splash fadeovertime(1);
    self.ping_objective_splash.alpha = 0.5;
    self.ping_objective_splash.fontscale = 1.5;
    self.ping_objective_splash changefontscaleovertime(1);
    self.ping_objective_splash.fontscale = 1;
    wait 1;
  }

  self.ping_objective_splash.alpha = 0.5;
  self.ping_objective_splash fadeovertime(0.25);
  self.ping_objective_splash.alpha = 0;
  wait 0.25;
  self.escape_hint_active = undefined;

  if(isDefined(self.ping_objective_splash)) {
    self.ping_objective_splash destroy();
  }
}

harbor_create_hud_item(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_3)) {}

  if(!isDefined(var_0)) {
    var_0 = 0;
  }
  if(!isDefined(var_1)) {
    var_1 = 0;
  }
  var_0 = var_0 + 2;
  var_5 = undefined;

  if(isDefined(var_3)) {
    var_5 = maps\_hud_util::get_countdown_hud(-60, undefined, var_3, 1);
  } else {
    var_5 = maps\_hud_util::get_countdown_hud(-60, undefined, undefined, 1);
  }
  var_5.alignx = "center";
  var_5.aligny = "top";
  var_5.horzalign = "center";
  var_5.vertalign = "middle";
  var_5.x = var_1;
  var_5.y = -160 + 15 * var_0;
  var_5.font = "hudsmall";
  var_5.foreground = 1;
  var_5.hidewheninmenu = 1;
  var_5.hidewhendead = 1;
  var_5.sort = 2;
  var_5.color = (0.9, 0.9, 1);
  var_5.fontscale = 1.15;

  if(isDefined(var_2)) {
    var_5.label = var_2;
  }
  if(!isDefined(var_4) || !var_4) {
    if(isDefined(var_3)) {
      if(!var_3 maps\_specialops_code::so_hud_can_show()) {
        var_3 thread maps\_specialops_code::so_create_hud_item_delay_draw(var_5);
      }
    }
  }

  return var_5;
}

fadeblackout(var_0) {
  self fadeovertime(var_0);
  self.alpha = 1;
}

blackout(var_0) {
  var_1 = newhudelem();
  var_1 setshader("black", 640, 480);
  var_1.horzalign = "fullscreen";
  var_1.vertalign = "fullscreen";
  var_1.alpha = 0;
  var_1.sort = 2;
  return var_1;
}

play_smoke_for_missiles() {
  var_0 = common_scripts\utility::getStructArray("missile_smoke", "targetname");

  foreach(var_2 in var_0) {}
  playFX(common_scripts\utility::getfx("smokescreen"), var_2.origin);

  wait 1;

  for(;;) {
    var_0 play_smoke();
  }
}

play_smoke() {
  foreach(var_1 in self) {}
  playFX(common_scripts\utility::getfx("smokescreen"), var_1.origin);

  wait 30;
}

start_countdown(var_0, var_1, var_2, var_3) {
  thread so_enable_countdown_timer(var_0, 0, var_1, undefined, var_3);
  wait(var_0);

  if(isDefined(var_2)) {
    common_scripts\utility::flag_set(var_2);
  } else {
    return 1;
  }
}

so_enable_countdown_timer(var_0, var_1, var_2, var_3, var_4) {
  level endon("special_op_terminated");

  if(!isDefined(var_2)) {
    var_2 = &"SPECIAL_OPS_STARTING_IN";
  }
  var_5 = harbor_create_hud_item(0, -60, var_2, var_4);
  var_5 setpulsefx(50, var_0 * 1000, 500);
  var_6 = harbor_create_hud_item(0, 115, undefined, var_4);
  var_6 thread maps\_specialops::show_countdown_timer_time(var_0, var_3);
  level.elements = [var_5, var_6];
  wait(var_0);
  level.player playSound("arcademode_zerodeaths");

  if(isDefined(var_1) && var_1) {
    level.challenge_start_time = gettime();
  }
  thread so_destroy_countdown_timer(var_5, var_6);
}

so_destroy_countdown_timer(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    common_scripts\utility::flag_wait(var_2);
  }
  wait 1;

  if(isDefined(var_0) && isDefined(var_1)) {
    var_0 destroy();
    var_1 destroy();
  }
}

setup_ocean_params(var_0, var_1, var_2, var_3, var_4) {
  var_5[0] = 3;
  var_6[0] = 3;
  var_7[0] = 30;
  var_8[0] = 4;
  var_9[0] = 0;
  var_5[1] = 8;
  var_6[1] = 8;
  var_7[1] = 10;
  var_8[1] = 1.75;
  var_9[1] = 45;
  var_5[2] = 2;
  var_6[2] = 2;
  var_7[2] = 0;
  var_8[2] = 2;
  var_9[2] = 315;
  maps\ocean_perlin::setup_ocean_perlin(var_0);

  for(var_10 = 0; var_10 < 3; var_10++) {
    var_0.uscale[var_10] = 0.0001 * var_1 * var_5[var_10];
    var_0.vscale[var_10] = 0.0001 * var_2 * var_6[var_10];
    var_0.amplitude[var_10] = var_3 * var_7[var_10];
    var_0.uscrollrate[var_10] = cos(var_9[var_10]) * var_4 * var_8[var_10];
    var_0.vscrollrate[var_10] = sin(var_9[var_10]) * var_4 * var_8[var_10];
  }

  var_0.uoff = -0.5;
  var_0.voff = -0.5;
  var_0.gametimeoffset = 0.0;
  var_0.displacement_uvscale = 1.0;
  maps\ny_harbor_code_sub::showwater(0);
}

setup_ocean() {
  var_0 = 1;
  var_1 = 1;
  var_2 = 1;
  var_3 = 0.025;
  level.oceantextures["water_patch"] = spawnStruct();
  setup_ocean_params(level.oceantextures["water_patch"], var_0, var_1, var_2, var_3);
  level.oceantextures["water_patch_med"] = spawnStruct();
  setup_ocean_params(level.oceantextures["water_patch_med"], var_0, var_1, 0.5 * var_2, var_3);
  level.oceantextures["water_patch_calm"] = spawnStruct();
  setup_ocean_params(level.oceantextures["water_patch_calm"], var_0, var_1, 0, var_3);
}

precacheanims() {
  hind_anims();
  script_model_anims();
  building_destruction();
  body_anims();
  door();
}

player_anims() {}

ss_n_12_anims() {}

#using_animtree("vehicles");

hind_anims() {
  level.scr_animtree["ny_harbor_hind"] = #animtree;
  level.scr_anim["ny_harbor_hind"]["open_door"] = % ny_harbor_hind_open_door;
  level.scr_anim["ny_harbor_hind"]["open_door_idle"] = % ny_harbor_hind_open_door_idle;
}

#using_animtree("script_model");

script_model_anims() {
  level.scr_animtree["door_charge"] = #animtree;
  level.scr_model["door_charge"] = "weapon_frame_charge_iw5";
  level.scr_anim["door_charge"]["ny_harbor_door_breach"] = % ny_harbor_door_breach_player_charge2;
  level.scr_animtree["breach_door"] = #animtree;
  level.scr_model["breach_door"] = "ny_harbor_sub_pressuredoor_bridge";
  level.scr_anim["breach_door"]["ny_harbor_door_breach"] = % ny_harbor_door_breach_pressure_door;
  level.scr_animtree["smoke_column"] = #animtree;
  level.scr_anim["smoke_column"]["fire"] = % fx_ny_smoke_column_anim;
  level.scr_anim["smoke_column"]["rot"] = % fx_ny_smoke_column_rot_anim;
  level.scr_animtree["missile_door"] = #animtree;
  level.scr_anim["missile_door"]["open"] = % ny_harbor_sub_missile_door_open;
  level.scr_animtree["missile_hatch"] = #animtree;
  level.scr_anim["missile_hatch"]["open"] = % ny_harbor_sub_missile_hatch_open;
  level.scr_animtree["wave_front"] = #animtree;
  level.scr_anim["wave_front"]["wave"] = % fx_nyharbor_wave_front_anim;
  level.scr_animtree["wave_crashing"] = #animtree;
  level.scr_anim["wave_crashing"]["wave"] = % fx_nyharbor_wave_crashing_anim;
  level.scr_animtree["wave_side"] = #animtree;
  level.scr_anim["wave_side"]["wave"] = % fx_nyharbor_wave_side_anim;
  level.scr_animtree["explosion_wave"] = #animtree;
  level.scr_anim["explosion_wave"]["wave"] = % fx_nyharbor_explosion_wave_anim;
  level.scr_animtree["wave_displace"] = #animtree;
  level.scr_anim["wave_displace"]["wave"] = % fx_nyharbor_wave_displace_anim;
}

building_destruction() {
  level.scr_animtree["building_des"] = #animtree;
  level.scr_anim["building_des"]["ny_manhattan_building_exchange_01_facade_des_anim"] = % ny_manhattan_building_exchange_01_facade_des_anim;
}

door() {
  level.scr_animtree["door"] = #animtree;
  level.scr_model["door"] = "ny_harbor_sub_pressuredoor_rigged";
  level.scr_anim["door"]["open_with_wheel"] = % ny_harbor_delta_bulkhead_open_door_v2;
}

#using_animtree("generic_human");

body_anims() {
  level.scr_animtree["floating_body"] = #animtree;
  level.scr_anim["generic"]["ny_harbor_paried_takedown_captain_dead_1"] = % ny_harbor_paried_takedown_captain_dead_1;
  level.scr_anim["generic"]["ny_harbor_paried_takedown_captain_die"] = % ny_harbor_paried_takedown_captain_die;
  level.scr_anim["generic"]["ny_harbor_delta_bulkhead_open_guy1_v2"] = % ny_harbor_delta_bulkhead_open_guy1_v2;
}

prefx() {
  level._effect["smokescreen"] = loadfx("smoke/smoke_grenade_low");
  level._effect["red_dot"] = loadfx("misc/aircraft_light_cockpit_red");
  level._effect["light_c4_blink"] = loadfx("misc/light_c4_blink");
  level._effect["white_light"] = loadfx("misc/aircraft_light_white_blink");
  level._effect["red_light"] = loadfx("lights/hijack_fxlight_red_blink");
  level._effect["steam_jet1"] = loadfx("smoke/steam_jet_loop_cheap");
  level._effect["steam_jet2"] = loadfx("smoke/steam_jet_med_loop_harbor");
  level._effect["fire_gen"] = loadfx("fire/cpu_fire");
  level._effect["fire_steam"] = loadfx("impacts/pipe_fire_looping");
}

prevo() {
  level.scr_radio["so_zodiac2_hqr_oncamera"] = "so_zodiac2_hqr_oncamera";
  level.scr_radio["so_zodiac2_hqr_riggedsub"] = "so_zodiac2_hqr_riggedsub";
  level.scr_radio["so_zodiac2_hqr_nearingreactor"] = "so_zodiac2_hqr_nearingreactor";
  level.scr_radio["so_zodiac2_hqr_raditionlevels"] = "so_zodiac2_hqr_raditionlevels";
  level.scr_radio["so_zodiac2_hqr_rendezvous"] = "so_zodiac2_hqr_rendezvous";
  level.scr_radio["so_zodiac2_hqr_areaishot"] = "so_zodiac2_hqr_areaishot";
  level.scr_radio["so_zodiac2_hqr_readywhen"] = "so_zodiac2_hqr_readywhen";
  level.scr_radio["so_zodiac2_hqr_onisr"] = "so_zodiac2_hqr_onisr";
}

handle_end_of_game_bonuses() {
  foreach(var_1 in level.players) {
    var_1.bonus_1 = 0;
    var_1.bonus_2 = 1;
  }

  thread level_complete_under_time();
}

monitor_damage_type() {
  var_0 = getEnt("smoke_kills_vol", "targetname");
  self waittill("death", var_1, var_2, var_3);

  if(isPlayer(var_1) && var_0 istouching(self)) {
    var_1.bonus_1++;
    var_1 notify("bonus1_count", var_1.bonus_1);
  }
}

is_bonus_weapon(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }
  if(!isDefined(var_1)) {
    return 0;
  }
  if(var_0 == "MOD_MELEE") {
    return 1;
  } else {
    return 0;
  }
}

level_complete_under_time() {
  common_scripts\utility::array_thread(level.players, ::fail_if_missionfail);
  common_scripts\utility::array_thread(level.players, ::_id_02B1);
  wait 300;

  foreach(var_1 in level.players) {}
  var_1.bonus_2 = 0;
}

fail_if_missionfail() {
  self waittill("death");

  foreach(var_1 in level.players) {}
  var_1.bonus_2 = 0;
}

_id_02B1() {
  level waittill("friendlyfire_mission_fail");

  foreach(var_1 in level.players) {}
  var_1.bonus_2 = 0;
}

heli_fail_safe_on_death() {
  level endon("so_zodiac2_ny_harbor_complete");
  common_scripts\utility::flag_set("special_op_no_unlink");
  level waittill("missionfailed");

  if(!isDefined(level.player_hind)) {
    return;
  }
  level.player_hind vehicle_setspeedimmediate(0, 60, 60);

  foreach(var_1 in level.players) {}
  var_1 takeallweapons();
}
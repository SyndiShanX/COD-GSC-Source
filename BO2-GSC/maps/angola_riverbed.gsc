/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\angola_riverbed.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_objectives;
#include maps\_vehicle;
#include maps\angola_utility;
#include maps\_music;
#include maps\createart\angola_art;
#include maps\_mortar;

skipto_riverbed_intro() {
  skipto_teleport_players("player_skipto_riverbed");
}

skipto_riverbed() {
  skipto_teleport_players("player_skipto_riverbed");
  level.savimbi = init_hero("savimbi", ::savimbi_setup);
  level thread maps\createart\angola_art::riverbed_skipto();
  level thread riverbed_savimbi();
  flag_set("riverbed_done");
}

init_flags() {
  flag_init("riverbed_done");
  flag_init("riverbed_player_intro_done");
  flag_init("savimbi_reached_savannah");
}

riverbed_intro() {
  level.savimbi = init_hero("savimbi", ::savimbi_setup);
  level thread prep_intro_fx();
  level thread turn_on_convoy_headlights();
  blocker = getent("buffel_start_blocker", "targetname");
  blocker hide();
  blocker notsolid();
  drone = getent("drone_name", "targetname");
  drone hide();
  m_buffel_windshield = getent("buffel_windshield", "targetname");
  a_buffel_cracked_windshields = [];
  a_buffel_cracked_windshields[0] = spawn_model("veh_t6_mil_buffelapc_windshield_cracked01", m_buffel_windshield.origin - (1, 0, 0), m_buffel_windshield.angles);
  a_buffel_cracked_windshields[1] = spawn_model("veh_t6_mil_buffelapc_windshield_cracked02", m_buffel_windshield.origin - (1, 0, 0), m_buffel_windshield.angles);
  a_buffel_cracked_windshields[2] = spawn_model("veh_t6_mil_buffelapc_windshield_cracked03", m_buffel_windshield.origin - (1, 0, 0), m_buffel_windshield.angles);
  a_buffel_cracked_windshields[3] = spawn_model("veh_t6_mil_buffelapc_windshield_cracked04", m_buffel_windshield.origin - (1, 0, 0), m_buffel_windshield.angles);
  a_buffel_cracked_windshields[4] = spawn_model("veh_t6_mil_buffelapc_windshield_cracked05", m_buffel_windshield.origin - (1, 0, 0), m_buffel_windshield.angles);

  foreach(window in a_buffel_cracked_windshields)
  window hide();

  level thread animate_grass(1);
  level thread hide_victory_grass();
  a_veh_buffels = getentarray("convoy", "script_noteworthy");
  array_thread(a_veh_buffels, ::init_convoy_vehicle);

  if(!is_mature()) {
    level.graphic_filter_on = 1;
    run_scene_first_frame("level_intro_player_censored");
  } else
    run_scene_first_frame("level_intro_player");

  level.player setclientdvar("compass", 0);
  setmusicstate("ANGOLA_INTRO");
  level clientnotify("intro");
  run_scene_first_frame("level_intro_fx");
  exploder(1100);
  exploder(1000);
  exploder(1001);
  level thread scripted_intro_fx();
  clientnotify("intr");
  wait 2;
  level thread riverbed_intro_player();
  level thread riverbed_savimbi();
  level thread riverbed_intro_convoy();
  level thread riverbed_intro_buffel(m_buffel_windshield, a_buffel_cracked_windshields);
  level thread show_victory_vehicles(0);
}

check_graphic_intro() {
  if(!is_mature())
    level.graphic_filter_on = 1;
}

prep_intro_fx() {
  level.fire_fx_ent = spawn_model("tag_origin_animate");
  level.fire_fx_ent.animname = "fire_fx_ent";
}

scripted_intro_fx() {
  if(!is_mature())
    player_body = get_model_or_models_from_scene("level_intro_player_censored", "player_body");
  else
    player_body = get_model_or_models_from_scene("level_intro_player", "player_body");

  playfxontag(level._effect["fx_ango_intro_truck_fade_fire"], player_body, "tag_camera");
  playfxontag(level._effect["fx_ango_intro_truck_fade"], level.fire_fx_ent, "origin_animate_jnt");

  if(is_mature()) {
    wait 6.0;
    burned_body = get_model_or_models_from_scene("level_intro_player", "burning_man");
    playfxontag(level._effect["fx_ango_intro_arm_fire"], burned_body, "J_Wrist_LE");
    playfxontag(level._effect["fx_ango_intro_arm_fire"], burned_body, "J_Elbow_LE");
    playfxontag(level._effect["fx_ango_intro_shoulder_fire"], burned_body, "J_SpineLower");
    wait 0.1;
    playfxontag(level._effect["fx_ango_intro_arm_fire"], burned_body, "J_Wrist_RI");
    playfxontag(level._effect["fx_ango_intro_arm_fire"], burned_body, "J_Elbow_RI");
    playfxontag(level._effect["fx_ango_intro_shoulder_fire"], burned_body, "J_Clavicle_LE");
    wait 0.1;
    playfxontag(level._effect["fx_ango_intro_head_fire"], burned_body, "J_head");
    playfxontag(level._effect["fx_ango_intro_shoulder_fire"], burned_body, "J_Shoulder_RI");
    playfxontag(level._effect["fx_ango_intro_shoulder_fire"], burned_body, "J_Shoulder_LE");
    wait 0.1;
    playfxontag(level._effect["fx_ango_intro_arm_fire"], burned_body, "J_Spine4");
    playfxontag(level._effect["fx_ango_intro_arm_fire"], burned_body, "J_Clavicle_RI");
    playfxontag(level._effect["fx_ango_intro_arm_fire"], burned_body, "J_Hip_RI");
    wait 0.1;
    playfxontag(level._effect["fx_ango_intro_arm_fire"], burned_body, "J_Hip_LE");
    playfxontag(level._effect["fx_ango_intro_head_fire"], burned_body, "J_neck");
    playfxontag(level._effect["fx_ango_intro_shoulder_fire"], burned_body, "J_SpineUpper");
  }
}

riverbed_intro_player() {
  m_shovel = spawn_model("tag_origin_animate");
  m_shovel.animname = "intro_shovel";
  level thread intro_notetrack_catcher();

  if(is_mature())
    level thread run_scene("level_intro_player");
  else
    level thread run_scene("level_intro_player_censored");

  level thread run_scene("level_intro_fx");
  level thread run_scene("level_intro_shovel");
  level thread run_scene("riverbed_mortar_react_loop");
  level thread run_scene("level_intro_chopper");
  level thread set_react_ai_goals();
  level thread riverbed_intro_mortars();
  m_player_body = getent("player_body", "targetname");
  m_player_body attach("t6_wpn_machete_prop", "tag_weapon");

  if(is_mature())
    scene_wait("level_intro_player");
  else
    scene_wait("level_intro_player_censored");

  level.player setclientdvar("compass", 1);
  flag_set("riverbed_player_intro_done");
  level.savimbi unequip_savimbi_machete();
  level thread riverbed_mortars();
  level thread mortar_react();
}

set_react_ai_goals() {
  wait 0.2;
  shocked1 = get_ais_from_scene("riverbed_mortar_react_loop", "riverbed_mortar_react_3");
  nd_goal = getnode("shocked_2", "targetname");
  shocked1 setgoalnode(nd_goal);
  shocked2 = get_ais_from_scene("riverbed_mortar_react_loop", "riverbed_mortar_react_4");
  nd_goal = getnode("shocked_1", "targetname");
  shocked2 setgoalnode(nd_goal);
}

intro_notetrack_catcher() {
  level thread maps\createart\angola_art::burning_man();
  level clientnotify("fog_change");
}

player_looking_at_savimbi_reveal(m_body) {
  if(isDefined(level.graphic_filter_on) && level.graphic_filter_on) {
    level.graphic_filter_on = undefined;
    screen_fade_in(0.2);
  }

  level thread maps\createart\angola_art::savimbi_reveal();
  level clientnotify("fog_change");
  rpc("clientscripts/angola_amb", "sndDuckMortars");
  stop_exploder(1100);
  level thread reveal_lighting_swap();
  wait 3;
  level thread maps\createart\angola_art::riverbed();
}

reveal_lighting_swap() {
  stop_exploder(1001);
  wait 0.1;
  exploder(1002);
}

player_head_look(m_body) {
  m_player_body = getent("player_body", "targetname");
  level.player playerlinktodelta(m_player_body, "tag_player", 1, 10, 20, 20, 0, 1, 1);
}

player_looking_at_savimbi(m_body) {
  level thread maps\createart\angola_art::burning_sky();
  level clientnotify("fog_change");
}

player_looking_at_burning_man(m_body) {
  level thread maps\createart\angola_art::burning_man();
  level clientnotify("fog_change");
}

riverbed_intro_buffel(m_pristine_window, a_buffel_cracked_windshields) {
  flag_wait("player_hit_window");
  flag_clear("player_hit_window");
  a_buffel_cracked_windshields[0] show();
  m_pristine_window delete();

  for(i = 0; i < 2; i++) {
    flag_wait("player_hit_window");
    flag_clear("player_hit_window");
  }

  windshield_swap(a_buffel_cracked_windshields, 1);
  flag_wait("player_looking_at_savimbi");
  exploder(1010);
  flag_wait("player_hit_window");
  flag_clear("player_hit_window");
  windshield_swap(a_buffel_cracked_windshields, 2);
  flag_wait("player_hit_window");
  flag_clear("player_hit_window");
  windshield_swap(a_buffel_cracked_windshields, 3);
  flag_wait("player_hit_window");
  flag_clear("player_hit_window");
  windshield_swap(a_buffel_cracked_windshields, 4);
  flag_wait("player_looking_at_savimbi_reveal");
  wait 16;
  stop_exploder(1002);
  a_buffel_cracked_windshields[4] delete();
  hack_windows = getentarray("buffel_windshields", "targetname");

  foreach(window in hack_windows)
  window delete();
}

windshield_swap(a_buffel_cracked_windshields, n_index) {
  a_buffel_cracked_windshields[n_index] show();
  a_buffel_cracked_windshields[n_index - 1] delete();
  exploder(1010);
}

riverbed_intro_convoy() {
  stop_exploder(1002);
  wait 1;
  nd_eland_start = getvehiclenode("intro_eland_path", "script_noteworthy");
  nd_buffel_start = getvehiclenode("intro_buffel_path", "script_noteworthy");
  vehicle = spawn_vehicle_from_targetname("start_convoy_eland");
  vehicle setclientflag(10);
  vehicle thread go_path(nd_eland_start);
  vehicle thread riverbed_convoy_think();
  wait 2;
  vehicle = spawn_vehicle_from_targetname("start_convoy_buffel");
  vehicle thread go_path(nd_buffel_start);
  vehicle thread riverbed_convoy_think();
}

riverbed_savimbi() {
  level thread riverbed_savimbi_intro_buffel();
  run_scene("level_intro_savimbi");
  level.savimbi detach("t6_wpn_launch_mm1_world", "tag_weapon_left");
  level.savimbi attach("t6_wpn_launch_mm1_world", "tag_weapon_right");
  end_scene("level_intro_savimbi");
  end_scene("riverbed_lower_loop");
  end_scene("riverbed_upper_loop");
  level thread run_scene("riverbed_lower");
  level thread run_scene("riverbed_upper");
  wait 0.05;
  level thread run_scene("player_ride_buffel_intro");
  level.player playrumblelooponentity("tank_rumble");
  wait 0.05;
  level.player player_enable_weapons();
  level.player showviewmodel();
  level.player setlowready(1);
  level thread vo_riverbed();
  run_scene("savimbi_ride_rally");
  level thread run_scene("savimbi_ride_idle");
  autosave_by_name("riverbed");
}

riverbed_savimbi_intro_buffel() {
  level thread run_scene("level_intro_savimbi_buffel");
  veh_buffel = getent("savimbi_buffel", "targetname");
  veh_buffel veh_magic_bullet_shield(1);
  veh_buffel.drivepath = 1;
  veh_buffel hidepart("tag_mirror");
  nd_start = getvehiclenode("savimbi_intro_path", "targetname");
  veh_convoy = getent("riverbed_convoy_eland", "targetname");
  veh_convoy.drivepath = 1;
  scene_wait("level_intro_savimbi");
  veh_convoy thread go_path();
  veh_buffel thread go_path(nd_start);
  veh_buffel thread play_dust_fx();
  veh_buffel waittill("reached_end_node");
  wait 0.1;
  blocker = getent("buffel_start_blocker", "targetname");
  blocker show();
  blocker solid();
  riverbed_blocker = getent("riverbed_blocker", "targetname");
  riverbed_blocker solid();
  flag_set("savimbi_reached_savannah");
}

riverbed() {
  level thread riverbed_ambient_scenes();
  level thread riverbed_convoy();
  level thread riverbed_fail_watch();
  flag_wait("riverbed_player_intro_done");
  a_convoy_trailers = get_ai_array("convoy_trailers", "script_noteworthy");

  foreach(guy in a_convoy_trailers)
  guy magic_bullet_shield();

  level thread prep_start_buffel_unload();
  flag_wait("riverbed_done");
  wait 2;
}

prep_start_buffel_unload() {
  level thread run_scene("brim_start_loop1");
  level thread run_scene("brim_start_loop2");
  level thread prep_brim_start_models();
  flag_wait("savannah_start_unload");
  end_scene("brim_start_loop1");
  end_scene("brim_start_loop2");

  for(x = 1; x < 5; x++) {
    level thread unload_and_run_to_clash(x);
    wait(randomfloatrange(0.05, 0.2));
  }

  flag_set("clash_runners_ready");
}

unload_and_run_to_clash(n_soldier) {
  run_scene("brim_start_unload" + n_soldier);

  if(n_soldier != 4)
    run_to_clash(n_soldier);
}

run_to_clash(n_soldier) {
  flag_wait("start_clash_idle");
  run_scene("unita_wait_runners_intro" + n_soldier);
  level thread run_scene("unita_wait_runners" + n_soldier);
  wait 0.2;
  level notify("u_w_r" + n_soldier);
}

prep_brim_start_models() {
  wait 0.2;
  brim_start_array = get_ais_from_scene("brim_start_loop1");

  foreach(brim_start in brim_start_array) {
    brim_start.goalradius = 4;
    brim_start attach("t6_wpn_ar_ak47_world", "tag_weapon_left");
  }

  brim_start_array = get_ais_from_scene("brim_start_loop2");

  foreach(brim_start in brim_start_array) {
    brim_start.goalradius = 4;
    brim_start attach("t6_wpn_ar_ak47_world", "tag_weapon_left");
  }
}

riverbed_intro_mortars() {
  level._explosion_stopnotify["mortar_intro"] = "stop_intro_mortars";
  level thread maps\_mortar::set_mortar_delays("mortar_intro", 0.5, 2);
  level thread maps\_mortar::set_mortar_damage("mortar_intro", 1, 0, 0);
  level thread maps\_mortar::mortar_loop("mortar_intro");
  flag_wait("riverbed_player_intro_done");
  level notify("stop_intro_mortars");
}

riverbed_mortars() {
  level._explosion_stopnotify["mortar_riverbed"] = "stop_riverbed_mortars";
  level thread maps\_mortar::set_mortar_delays("mortar_riverbed", 1, 2);
  level thread maps\_mortar::set_mortar_damage("mortar_riverbed", 256, 1001, 1003);
  level thread maps\_mortar::set_mortar_range("mortar_riverbed", 256, 3072);
  level thread maps\_mortar::mortar_loop("mortar_riverbed");
  flag_wait_all("clash_runners_ready", "savimbi_reached_savannah");
  level notify("stop_riverbed_mortars");
}

riverbed_ambient_scenes() {
  for(i = 1; i < 8; i++)
    level thread run_scene("level_intro_soldier_" + i);

  m_actors = [];

  for(i = 1; i < 3; i++) {
    wait 0.1;
    m_actor = create_friendly_model_actor();
    m_actor.targetname = "riverbed_ambience_" + i;

    if(i == 3 || i == 8)
      m_actor attach("t6_wpn_machete_prop", "tag_weapon_left");
    else if(i == 4) {
    } else if(i == 1 || i == 2)
      level thread fake_weapon(m_actor);

    level thread run_scene("riverbed_ambience_" + i);
    m_actors[m_actors.size] = m_actor;
  }

  m_bodies = [];

  for(i = 1; i < 9; i++) {
    wait 0.1;
    m_body = create_friendly_model_actor();
    m_body.targetname = "riverbed_corpses_" + i;

    if(i == 4 || i == 7 || i == 6)
      m_body attach("t6_wpn_machete_prop", "tag_weapon_left");

    level thread run_scene("riverbed_corpses_" + i);
    m_bodies[m_bodies.size] = m_body;
  }

  m_driver = create_friendly_model_actor();
  m_driver.targetname = "riverbed_corpses_driver";
  wait 0.05;
  level thread run_scene("riverbed_corpses_driver");
  level thread riverbed_soldiers_move_up();
  level thread run_scene("riverbed_lower_loop");
  level thread run_scene("riverbed_upper_loop");
  lower_group = get_model_or_models_from_scene("riverbed_lower_loop");
  upper_group = get_model_or_models_from_scene("riverbed_upper_loop");

  foreach(model in lower_group) {
    if(issubstr(model.targetname, "lower")) {
      if(issubstr(model.targetname, "lower9")) {
        model attach("t6_wpn_crowbar_prop", "tag_weapon_left");
        continue;
      }

      if(!issubstr(model.targetname, "lower8"))
        level thread fake_weapon(model);
    }
  }

  foreach(model in upper_group) {
    if(issubstr(model.targetname, "upper"))
      level thread fake_weapon(model);
  }

  flag_wait_all("clash_runners_ready", "savimbi_reached_savannah");

  for(i = 1; i < 8; i++) {
    a_soldiers = getentarray("intro_soldier_" + i + "_ai", "targetname");

    foreach(soldier in a_soldiers)
    soldier delete();
  }
}

riverbed_soldiers_move_up() {
}

riverbed_convoy() {
  a_nd_starts_intro = getvehiclenodearray("start_convoy_intro_path", "script_noteworthy");
  a_nd_starts = getvehiclenodearray("start_convoy_path", "targetname");
  a_nd_random = [];

  while(!flag("savannah_base_reached")) {
    if(is_mature()) {
      if(!flag("level_intro_player_done"))
        a_nd_random = array_randomize(a_nd_starts_intro);
      else
        a_nd_random = array_randomize(a_nd_starts);
    } else if(!flag("level_intro_player_censored_done"))
      a_nd_random = array_randomize(a_nd_starts_intro);
    else
      a_nd_random = array_randomize(a_nd_starts);

    foreach(nd in a_nd_random) {
      vehicle = spawn_vehicle_from_targetname(riverbed_get_random_vehicle());

      if(vehicle.vehicletype != "truck_gaz66_cargo")
        vehicle setclientflag(10);

      vehicle thread go_path(nd);
      vehicle thread riverbed_convoy_think();
      wait(randomfloatrange(3.0, 10.0));
    }
  }
}

riverbed_get_random_vehicle() {
  a_str_veh[1] = "start_convoy_eland";
  a_str_veh[2] = "start_convoy_gaz66";
  a_str_veh[3] = "start_convoy_buffel";
  a_str_veh[4] = "start_convoy_eland";
  a_str_veh[0] = "start_convoy_gaz66";
  return a_str_veh[randomint(a_str_veh.size)];
}

riverbed_convoy_think() {
  self veh_magic_bullet_shield(1);
  self load_convoy_vehicle();
  self waittill("reached_end_node");
  self unload_convoy_vehicle();
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

load_convoy_vehicle() {
  self load_buffel(1);
  self load_gaz66();
}

unload_convoy_vehicle() {
  self unload_buffel();
  self unload_gaz66();
}

savimbi_intro_swap(e_model) {
  e_model detach("t6_wpn_launch_mm1_world", "tag_weapon_right");
  e_model attach("t6_wpn_launch_mm1_world", "tag_weapon_left");
}

play_dust_fx() {
  self play_fx("fx_ango_treadfx_dust", self.origin, undefined, "end_dust_fx", 1, "tag_origin", 1);
  self waittill("reached_end_node");
  self notify("end_dust_fx");
}

spawn_burned_guy() {
  ai_burned_guy = simple_spawn_single("burning_man");
}

player_hit_rumble(m_body) {
  level.player playrumbleonentity("damage_light");
}

vo_riverbed() {
  level.player say_dialog("maso_what_about_woods_yo_0", 0.5);
  level.player say_dialog("huds_right_now_it_s_all_0", 0.5);
  level.player say_dialog("huds_we_expect_savimbi_s_0", 0.5);
}

vo_riverbed_savimbi_nag() {
  level endon("savannah_base_reached");
  n_count = 1;
  vh_savimbi_buffel = getent("savimbi_buffel", "targetname");

  while(!flag("savannah_base_reached")) {
    n_delta = distance2d(level.player.origin, vh_savimbi_buffel.origin);

    if(n_delta < 1024) {
      wait 1;
      continue;
    }

    if(n_count % 2 != 0)
      level.savimbi say_dialog("savi_i_would_not_wish_you_0", 0.5);
    else
      level.savimbi say_dialog("savi_stay_close_to_the_co_0", 0.5);

    wait 12.5;
    n_count++;
  }
}

mortar_react() {
  mortar_struct = getstruct("mortar_react", "targetname");
  playfx(getfx("mortar_savannah"), mortar_struct.origin);
  playsoundatposition("exp_mortar", mortar_struct.origin);
  run_scene("riverbed_mortar_react");
  run_scene("riverbed_mortar_react_end");
}

mortar_helper_message(delay) {
  level endon("strafe_run_called");

  if(isDefined(delay) && delay)
    wait(delay);

  if(flag("strafe_hint_active")) {
    screen_message_create(&"ANGOLA_STRAFE_HINT", & "ANGOLA_MORTAR_TUTORIAL");
    wait 5;
    screen_message_create(&"ANGOLA_STRAFE_HINT");
  } else {
    screen_message_create(&"ANGOLA_MORTAR_TUTORIAL");
    wait 5;
    screen_message_delete();
  }
}

init_convoy_vehicle() {
  self veh_magic_bullet_shield(1);
  self load_buffel();
}
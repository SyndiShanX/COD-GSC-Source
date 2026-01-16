/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\haiti_transmission.gsc
***************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_music;
#include maps\_objectives;
#include maps\_scene;
#include maps\_vehicle;
#include maps\haiti_util;
#include maps\haiti;
#include maps\haiti_front_door;
#include maps\haiti_anim;
#include maps\_fire_direction;
#include maps\_glasses;
#include maps\_quadrotor;
#include maps\_fxanim;
#include maps\_metal_storm;
#include maps\_flashgrenades;

init_flags() {
  flag_init("lobby_support");
  flag_init("general_video_done");
  flag_init("theater_attack_start");
  flag_init("theater_doors_open");
  flag_init("bomb_exploded");
  flag_init("open_menendez_door");
  flag_init("sliding_door_start");
  flag_init("brute_force_perk_used");
  flag_init("friendly_asd_died");
  flag_init("asd_in_theater");
  flag_init("close_ending_transition");
}

init_spawn_funcs() {
}

skipto_foyer() {
  maps\haiti::fxanim_construct_front_door();
  model_restore_area("convert_front_door");
  model_restore_area("convert_lobby");
  setup_harper();
  skipto_teleport("skipto_foyer");
  level thread maps\haiti_front_door::start_ground_events();
  level thread maps\haiti_front_door::walkway_collapse();
}

skipto_theater() {
  maps\haiti_anim::interior_anims();
  maps\haiti::fxanim_construct_interior();
  model_restore_area("convert_lobby_theater");
  setup_harper();
  skipto_teleport("skipto_theater");
  level thread squad_replenish_init();
}

skipto_transmission() {
  maps\haiti_anim::interior_anims();
  maps\haiti::fxanim_construct_interior();
  model_restore_area("convert_lobby_theater");
  a_m_big_screen = getentarray("big_screen", "targetname");

  foreach(m_big_screen in a_m_big_screen)
  m_big_screen hide();

  level thread door_think("m_room_door", "theater_doors_open", "stop_transmission_3_done", vectorscale((0, 1, 0), 65.0));
  setup_harper();
  skipto_teleport("skipto_transmission");
  level thread squad_replenish_init();
}

skipto_its_a_trap() {
  maps\haiti_anim::interior_anims();
  maps\haiti::fxanim_construct_interior();
  model_restore_area("convert_lobby_theater");
  model_restore_area("convert_after_trap");
  level thread control_room_closet();
  level thread door_think("m_room_door", "theater_doors_open", "stop_transmission_3_done", vectorscale((0, 1, 0), 65.0));
  setup_harper();
  skipto_teleport("skipto_transmission");
}

skipto_find_menendez() {
  maps\haiti_anim::interior_anims();
  maps\haiti::fxanim_construct_interior();
  model_restore_area("convert_lobby_theater");
  model_restore_area("convert_after_trap");
  level thread door_think("control_room_door", undefined, undefined, vectorscale((-1, 0, 0), 65.0), 0.05);
  level thread control_room_closet();
  m_door = getent("trappedinthecloset", "targetname");
  m_door delete();
  setup_harper();
  skipto_teleport("skipto_find_menendez");
  level thread distant_explosions();
  setmusicstate("HAITI_MENENDEZ_CHASE");
}

skipto_celerium() {
  level.n_find_menendez_start_time = gettime();
  maps\haiti_anim::interior_anims();
  maps\haiti::fxanim_construct_interior();
  model_restore_area("convert_after_trap");
  setup_harper();
  skipto_teleport("skipto_sliding_door");
}

foyer_main() {
  a_ai_defenders = simple_spawn("foyer_defenders", ::enemy_battle_think, 0, 1);
  flag_wait("at_foyer_entrance");
  level.player maps\_fire_direction::_fire_direction_kill();
  t_perk = getent("t_bruteforce", "targetname");

  if(isDefined(t_perk))
    t_perk delete();

  t_perk = getent("t_intruder", "targetname");

  if(isDefined(t_perk))
    t_perk delete();

  set_objective(level.obj_assault_builidng, undefined, "done");
  level thread objective_breadcrumb(level.obj_goto_control_room, "obj_control_room");
  level thread lobby_dialog();
  simple_spawn("foyer_upper_defenders", ::enemy_battle_think, 0, 1);
  simple_spawn("foyer_runners", ::enemy_battle_think, 1);
  level thread foyer_support();
  n_time = 1.0;
  level thread door_think("lab_entry_door", "haiti_gump_interior", undefined, vectorscale((1, 0, 0), 56.0), n_time);
  level thread door_think("lab_entry_door_01", "haiti_gump_interior", undefined, vectorscale((-1, 0, 0), 56.0), n_time);
  flag_wait("close_outer_doors");
  a_ai_flashbangers = simple_spawn("flashbangers", ::ai_toss_flashbang);
  level thread get_squadmates_inside();
  stop_exploder(222);
  load_gump("haiti_gump_interior");
  level thread autosave_by_name("haiti_flashbangers");
  wait 0.05;
  model_restore_area("convert_lobby_theater");
  maps\haiti::fxanim_construct_interior();
  level thread assembly_line();
  simple_spawn("scanner_guys", ::scanner_guy_think, 1);
  maps\haiti_anim::interior_anims();
  flag_wait("throw_flashbangs");
  level thread lockbreaker_perk();
  level cleanup_ents("cleanup_foyer");
  simple_spawn("flashbang_seals", ::ally_battle_think);
  simple_spawn("flashbang_guys", ::enemy_battle_think, 1);
  level thread factory_quadrotors();
  level thread general_video();
  trigger_wait("t_loading_dock");
  simple_spawn("loading_dock_guys");
  flag_wait("near_loading_dock");
  level thread autosave_by_name("haiti_ambush");
  level thread loading_dock_dialog();
  s_defend = getstruct("asd_defend", "targetname");
  vh_asd = spawn_vehicle_from_targetname("loading_dock_asd");
  vh_asd thread ambush_asd_think(s_defend.origin);
  level thread assembly_seals();
  trigger_wait("trig_ambush_asd");
  cleanup_ents("cleanup_halls");
  a_asds = spawn_vehicles_from_targetname("rally_point_asd");
  array_thread(a_asds, ::ambush_asd_think, s_defend.origin);
  simple_spawn("rally_point_enemies", ::enemy_battle_think, 1);
  trigger_wait("t_loading_hall");
  simple_spawn("loading_hall_enemies", ::enemy_battle_think, 1);
  level thread theater_dialog();
}

theater_main() {
  a_m_big_screen = getentarray("big_screen", "targetname");

  foreach(m_big_screen in a_m_big_screen)
  m_big_screen hide();

  level thread door_think("m_room_door", "theater_doors_open", "stop_transmission_3_done", vectorscale((0, 1, 0), 65.0));
  trigger_wait("trig_theater_screeners");
  level thread autosave_by_name("haiti_theater");
  simple_spawn("theater_guys", ::enemy_battle_think, 1);
  level thread theater_attack();
  level thread theater_cleanup();
  level thread autosave_by_name("haiti_theater");
  waittill_ai_group_ai_count("theater", 2);
  flag_set("theater_doors_open");
  simple_spawn("theater_guys2", ::enemy_battle_think, 1);
}

transmission_main() {
  level thread control_room_closet();
  a_ai_defenders = simple_spawn("control_room_defenders");

  foreach(ai_defender in a_ai_defenders) {
    ai_defender.goalradius = 96;
    ai_defender.script_radius = 96;
    ai_defender disable_long_death();
  }

  ai_computer_guy = simple_spawn_single("computer_guy", ::computer_guy_think);
  waittill_ai_group_cleared("control_room_defenders");
  setmusicstate("HAITI_PRE_MENENDEZ");
  set_objective(level.obj_goto_control_room, undefined, "delete");
  t_console = getent("trig_stop_transmission", "targetname");
  set_objective(level.obj_stop_control, t_console);
  t_console waittill("trigger");
  set_objective(level.obj_stop_control, undefined, "done");
  flag_clear("squad_spawning");
  setmusicstate("HAITI_MENENDEZ_SPEECH");
  cleanup_ents("cleanup_halls");
  cleanup_ents("cleanup_theater");
  level thread model_restore_area("convert_after_trap");

  if(level.is_harper_alive)
    level thread run_scene_and_delete("stop_transmission_1_harper", 0.5);

  level thread run_scene_and_delete("stop_transmission_1", 0.35);
  wait 1.0;
  level thread run_scene_first_frame("stop_transmission_chair_2");

  foreach(ai_squadmate in level.a_ai_player_squad) {
    if(isalive(ai_squadmate))
      ai_squadmate delete();
  }

  scene_wait("stop_transmission_1");

  if(level.is_harper_alive)
    level thread run_scene_and_delete("stop_transmission_2_harper");

  level run_scene_and_delete("stop_transmission_2");
}

its_a_trap_main() {
  m_door = getent("trappedinthecloset", "targetname");
  m_door delete();
  level thread door_think("control_room_door", undefined, undefined, vectorscale((-1, 0, 0), 65.0), 0.05);

  if(level.is_harper_alive)
    level thread run_scene_and_delete("stop_transmission_3_harper");

  level run_scene_and_delete("stop_transmission_3");
  setmusicstate("HAITI_MENENDEZ_CHASE");
  level thread autosave_by_name("haiti_transmission");
}

find_menendez_main() {
  if(level.is_harper_alive)
    set_objective(level.obj_find_menendez, level.ai_harper, "follow");
  else
    set_objective(level.obj_find_menendez);

  level thread spawn_static_actors("hall_body");
  run_thread_on_targetname("t_explosion", ::triggered_explosion);
  level thread find_menendez_dialog();
  trigger_wait("t_hallway1_pmcs");
  level thread hallway1_pmcs();
  trigger_wait("t_lab1");
  simple_spawn("lab_seals", ::ally_battle_think);
  simple_spawn("lab_pmcs1", ::enemy_battle_think);
  trigger_wait("t_lab2");
  simple_spawn("lab_pmcs2", ::enemy_battle_think, 1);
  simple_spawn("lab_camo_pmcs", ::camo_suit_think);
}

celerium_main() {
  n_time = 2.0;
  level thread door_think("lab_door_left", undefined, "close_ending_transition", vectorscale((0, -1, 0), 56.0), n_time);
  level thread door_think("lab_door_right", undefined, "close_ending_transition", vectorscale((0, 1, 0), 56.0), n_time);
  trigger_wait("t_hallway2");
  simple_spawn("hallway2_pmcs1", ::hallway_pmc_think);
  level hangar_gump_wait(n_time);
  maps\haiti_anim::endings_anims();
  level thread spin_emergency_light("fxanim_emergency_light", "fxanim_emergency_light_start", "ending_explosions");
  ending_ceiling = getent("ending_ceiling", "targetname");
  ending_ceiling hide();
  level thread autosave_by_name("door_room");
  simple_spawn("menendez_escort", ::guard_think);
  level thread sliding_door_think();
  trigger_wait("t_teleport_harper");

  if(level.is_harper_alive)
    level thread teleport_harper_to_end();

  flag_wait("ending_start");
  set_objective(level.obj_find_menendez, undefined, "done");
  level thread cleanup_ents("cleanup_celerium", 2.0);
}

foyer_defenders(a_ai_defenders) {
  a_ai_defenders = array_randomize(a_ai_defenders);
  n_num_defenders = 0;

  for(i = 0; i < a_ai_defenders.size; i++) {
    if(isalive(a_ai_defenders[i])) {
      if(n_num_defenders < 2) {
        n_num_defenders++;
        continue;
      }

      a_ai_defenders[i] setgoalvolumeauto(level.goalvolumes["vol_inner_rally_point"]);
      wait(randomfloatrange(0.05, 0.5));
    }
  }
}

foyer_support() {
  level endon("throw_flashbangs");
  wait 5.0;
  level.player thread queue_dialog("sect_watch_your_fire_fr_0", 2, undefined, "close_outer_doors");
  a_sp_support[0] = "seal_assault";

  if(level.is_sco_supporting) {
    a_sp_support[1] = "seal_assault";
    a_sp_support[2] = "sco_assault";
  }

  nd_exit = getnode("nd_foyer_upper_exit", "targetname");
  a_s_support = getstructarray("s_foyer_upper", "targetname");

  foreach(s_support in a_s_support)
  s_support thread ambient_support_respawner(a_sp_support, "throw_flashbangs", "foyer_upper_defenders", nd_exit);
}

ambient_support_respawner(a_sp_support, str_endflag, str_target_group, nd_exit) {
  if(isDefined(self.target))
    nd_dest = getnode(self.target, "targetname");

  while(!flag(str_endflag)) {
    ai_support = simple_spawn_single(random(a_sp_support), ::ambient_support_think, self, nd_dest, str_target_group, nd_exit);

    if(isDefined(ai_support))
      ai_support waittill("death");

    wait(randomfloatrange(1.5, 6.0));
  }
}

ambient_support_think(s_start, nd_dest, str_target_group, nd_exit) {
  self endon("death");
  self forceteleport(s_start.origin, s_start.angles);
  self.script_noteworthy = s_start.script_noteworthy;
  self change_movemode("cqb");

  if(isDefined(nd_dest))
    self setgoalnode(nd_dest);
  else
    self setgoalpos(self.origin);

  self thread ai_ally_attack_think(str_target_group, nd_exit);
}

get_squadmates_inside() {
  flag_clear("squad_spawning");
  e_volume = getent("convert_lobby", "script_noteworthy");
  a_nd_squadmates = getnodearray("nd_lobby_squadmates", "targetname");

  for(i = 0; i < level.a_ai_player_squad.size; i++) {
    if(isalive(level.a_ai_player_squad[i]) && !level.a_ai_player_squad[i] istouching(e_volume))
      level.a_ai_player_squad[i] forceteleport(a_nd_squadmates[i].origin, a_nd_squadmates[i].angles);
  }

  if(level.is_harper_alive && !level.ai_harper istouching(e_volume))
    level.ai_harper forceteleport(a_nd_squadmates[i].origin, a_nd_squadmates[i].angles);

  flag_wait("haiti_gump_interior");

  foreach(ai_squadmember in level.a_ai_player_squad) {
    if(isalive(ai_squadmember) && !ai_squadmember istouching(e_volume))
      ai_squadmember dodamage(ai_squadmember.health, ai_squadmember.origin);
  }

  wait 0.5;
  flag_set("squad_spawning");
}

scanner_guy_think(b_aggressive) {
  self.ignoreall = 1;
  self.ignoreme = 1;
  wait 0.8;
  self.ignoreme = 0;
  self.ignoreall = 0;
  self enemy_battle_think(b_aggressive);
}

factory_quadrotors() {
  a_vh_qr = spawn_vehicles_from_targetname("factory_qr");

  foreach(vh_qr in a_vh_qr) {
    vh_qr setthreatbiasgroup("ally_priority");
    nd_tether = getnode(vh_qr.target, "targetname");
    vh_qr maps\_vehicle::defend(nd_tether.origin, 400);
  }

  nd_exit = getnode("nd_factory_exit", "targetname");
  a_ai_allies = simple_spawn("factory_seal", ::ai_ally_attack_think, undefined, nd_exit);
  level waittill("cleanup_halls");
  kill_array(a_vh_qr);
}

general_video() {
  wait 6;
  level thread run_scene_and_delete("general_speech");
  wait 1;
  level maps\_glasses::play_bink_on_hud("generalstore");
  flag_set("general_video_done");
}

ai_toss_flashbang() {
  self endon("death");
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.a.allow_shooting = 0;
  flag_wait("throw_flashbangs");
  wait(self.script_float);
  s_grenade_start = getstruct(self.target, "targetname");
  s_grenade_end = getstruct(s_grenade_start.target, "targetname");
  v_velocity = vectornormalize(s_grenade_end.origin - s_grenade_start.origin) * 500;
  self magicgrenadetype("flash_grenade_sp", s_grenade_start.origin, v_velocity, 2.0);
  wait 2.0;
  self.ignoreall = 0;
  self.ignoreme = 0;
  self.a.allow_shooting = 1;
  self thread enemy_battle_think(1);
}

assembly_seals() {
  nd_exit = getnode("nd_assembly_exit", "targetname");
  s_start = getstruct("s_assembly_seal_start", "targetname");
  a_sp_support[0] = "seal_assault";

  if(level.is_sco_supporting) {
    a_sp_support[1] = "seal_assault";
    a_sp_support[2] = "sco_assault";
  }

  i = randomintrange(2, 6);

  while(!flag("player_left_docks")) {
    ai_support = simple_spawn_single(random(a_sp_support));
    ai_support forceteleport(s_start.origin, s_start.angles);
    ai_support.script_noteworthy = "cleanup_theater";
    ai_support change_movemode("cqb_sprint");
    ai_support thread delete_on_goal(nd_exit);
    wait(randomfloatrange(1.0, 3.0));
    i--;

    if(i <= 0) {
      wait(randomfloatrange(8.0, 15.0));
      i = randomintrange(2, 6);
    }
  }
}

assembly_line() {
  level endon("cleanup_theater");
  s_hoist = getstruct("s_assembly_hoist", "targetname");
  s_dest_hoist = getstruct(s_hoist.target, "targetname");
  s_bigdog = getstruct("s_assembly_bigdog", "targetname");
  s_dest_bigdog = getstruct(s_bigdog.target, "targetname");

  for(i = 0; i < 7; i++) {
    n_fraction = i / 7;
    v_origin = lerpvector(s_hoist.origin, s_dest_hoist.origin, n_fraction);
    m_hoist = spawn("script_model", v_origin);
    m_hoist.angles = s_hoist.angles;
    m_hoist setmodel("p6_claw_hoist");
    v_origin = lerpvector(s_bigdog.origin, s_dest_bigdog.origin, n_fraction);
    m_bigdog = spawn("script_model", v_origin);
    m_bigdog.angles = s_bigdog.angles;
    m_bigdog setmodel("veh_t6_drone_claw_mk2_alt");
    n_interval = lerpfloat(70, 0, n_fraction);
    m_hoist moveto(s_dest_hoist.origin, n_interval);
    m_bigdog moveto(s_dest_bigdog.origin, n_interval);
    m_hoist thread delete_at_end_of_line(m_bigdog);
    wait 0.05;
  }

  while(true) {
    m_hoist = spawn("script_model", s_hoist.origin);
    m_hoist.angles = s_hoist.angles;
    m_hoist setmodel("p6_claw_hoist");
    m_bigdog = spawn("script_model", s_bigdog.origin);
    m_bigdog.angles = s_bigdog.angles;
    m_bigdog setmodel("veh_t6_drone_claw_mk2_alt");
    m_hoist moveto(s_dest_hoist.origin, 70);
    m_bigdog moveto(s_dest_bigdog.origin, 70);
    m_hoist thread delete_at_end_of_line(m_bigdog);
    wait 10;
  }
}

delete_at_end_of_line(m_bigdog) {
  self endon("death");
  self waittill("movedone");
  m_bigdog delete();
  self delete();
}

delete_on_goal(nd_exit) {
  self endon("death");
  self.goalradius = 20;
  self setgoalpos(nd_exit.origin);
  self waittill("goal");
  self delete();
}

ambush_asd_think(v_defend_spot) {
  self endon("death");
  self thread maps\_vehicle::defend(v_defend_spot, 450);
  flag_wait("player_left_docks");

  while(true) {
    self thread maps\_vehicle::defend(level.player.origin, 256);
    wait 1.0;
  }
}

theater_attack_lookat() {
  level endon("theater_attack_start");
  s_lookat = getstruct("s_control_room_lookat", "targetname");
  level.player waittill_player_looking_at(s_lookat.origin, 45, 1);
  flag_set("theater_attack_start");
}

theater_attack() {
  level thread theater_attack_lookat();
  flag_wait("theater_attack_start");
  wait 0.5;
  s_theater_defend = getstruct("s_theater_defend", "targetname");
  a_vh_qr = spawn_vehicles_from_targetname("theater_qr");
  array_thread(a_vh_qr, ::qr_theater_think, s_theater_defend);
}

qr_theater_think(s_defend) {
  self endon("death");
  wait(randomfloatrange(0.0, 0.5));
  self thread maps\_quadrotor::quadrotor_fire_for_time(1.0);
  self gopath();
  self maps\_quadrotor::quadrotor_start_ai();
  self defend(s_defend.origin, 600);
}

theater_cleanup() {
  trigger_wait("obj_transmission");
  a_vh_qr = getentarray("theater_qr", "targetname");

  foreach(vh_qr in a_vh_qr) {
    vh_qr dodamage(1000, vh_qr.origin);
    wait(randomfloatrange(0.5, 1.0));
  }

  a_ai_theater = get_ai_group_ai("theater");

  foreach(ai_theater in a_ai_theater) {
    ai_theater dodamage(ai_theater.health, ai_theater.origin);
    wait(randomfloatrange(0.3, 1.0));
  }
}

control_room_closet() {
  a_m_destroyed = getentarray("control_room_destroyed", "targetname");

  foreach(m_destroyed in a_m_destroyed)
  m_destroyed hide();

  flag_wait("bomb_exploded");
  level clientnotify("sndAlarms");

  foreach(m_destroyed in a_m_destroyed)
  m_destroyed show();

  a_m_clean = getentarray("control_room_clean", "targetname");

  foreach(m_clean in a_m_clean)
  m_clean delete();
}

computer_guy_think() {
  level thread run_scene_and_delete("guy_at_computer_idle");
  self.health = 100000;
  self.goalradius = 8;
  self setgoalpos(self.origin);
  self disable_long_death();
  e_origin = spawn("script_origin", self.origin);
  self linkto(e_origin);
  self computer_guy_wait();
  end_scene("guy_at_computer_idle");
  level thread run_scene_and_delete("guy_at_computer_stand");
  self waittill("damage");
  scene_wait("guy_at_computer_stand");
  self.ignoreme = 1;
  run_scene_and_delete("guy_at_computer_die");
  e_origin delete();
}

computer_guy_wait() {
  self endon("damage");
  trigger_wait("obj_transmission");
}

fill_theater_right(player) {
  m_door = getent("m_room_aispawn_left", "targetname");
  m_door movey(-59, 1.0);
  m_door = getent("m_room_aispawn_right", "targetname");
  m_door movey(59, 1.0);
  n_start_time = gettime();
  s_start_loc = getstruct("s_theater_enter_right", "targetname");
  a_s_stage_right = getstructarray("s_theater_right_scout", "targetname");

  foreach(s_loc in a_s_stage_right) {
    thread enter_theater(s_start_loc, s_loc, 1);
    wait(randomfloatrange(0.7, 1.0));
  }

  wait 2;
  a_s_stage_right = getstructarray("s_theater_right", "targetname");

  foreach(s_loc in a_s_stage_right) {
    thread enter_theater(s_start_loc, s_loc);
    wait(randomfloatrange(0.8, 1.2));
  }

  n_wait_time = 19.0 - (gettime() - n_start_time) / 1000;

  if(n_wait_time > 0)
    wait(n_wait_time);

  level thread spawn_static_actors("stage_right_idle");
}

fill_theater_left(player) {
  n_start_time = gettime();
  s_start_loc = getstruct("s_theater_enter_left", "targetname");
  a_s_stage_left = getstructarray("s_theater_left_scout", "targetname");

  foreach(s_loc in a_s_stage_left) {
    thread enter_theater(s_start_loc, s_loc, 1);
    wait(randomfloatrange(0.7, 1.1));
  }

  wait 2;
  a_s_stage_left = getstructarray("s_theater_left", "targetname");

  foreach(s_loc in a_s_stage_left) {
    thread enter_theater(s_start_loc, s_loc);
    wait(randomfloatrange(1.0, 1.5));
  }

  n_wait_time = 6.0 - (gettime() - n_start_time) / 1000;

  if(n_wait_time > 0)
    wait(n_wait_time);

  level thread spawn_static_actors("stage_left_idle");
}

enter_theater(s_start_loc, s_loc_end, b_is_cqb) {
  if(!isDefined(b_is_cqb))
    b_is_cqb = 0;

  ai_seal = simple_spawn_single("seal_assault");
  ai_seal forceteleport(s_start_loc.origin, s_start_loc.angles);

  if(b_is_cqb)
    ai_seal change_movemode("cqb");

  ai_seal add_cleanup_ent("cleanup_transmission");
  ai_seal.goalradius = 12;
  ai_seal setgoalpos(s_loc_end.origin, s_loc_end.angles);
  ai_seal waittill("goal");

  if(isDefined(s_loc_end.script_string)) {
    if(s_loc_end.script_string == "delete") {
      ai_seal delete();
      return;
    }
  }

  ai_seal change_movemode("run");
}

menendez_movie(m_actor) {
  a_m_big_screen = getentarray("big_screen", "targetname");

  foreach(m_big_screen in a_m_big_screen)
  m_big_screen show();

  play_movie_on_surface_async("haiti_int_1", 0, 0, undefined, undefined, 0.3, 1);
  play_movie_on_surface_async("haiti_int_1b", 0, 0, undefined, undefined, 0.3, 1);
  play_movie_on_surface_async("haiti_int_1c", 0, 0, undefined, "movie_done", 0.3, 1);
}

viewmodel_arms_up(m_player) {
  level.player setlowready(1);
  level.player enableweapons();
  level.player showviewmodel();
}

viewmodel_arms_down(m_player) {
  level.player disableweapons();
  wait 4;
  level.player hideviewmodel();
  level.player setlowready(0);
}

theater_light(m_player, str_notetrack) {
  e_light = getent("theater_light", "targetname");

  switch (str_notetrack) {
    case "red_light_on":
    case "red_light_on_2":
      e_light setlightcolor((1.0, 0.8, 0.6));
      break;
    case "white_light_on":
    case "white_light_on_2":
      e_light setlightcolor((1, 1, 1));
      break;
    case "white_light_off":
      e_light setlightintensity(2.0);
      break;
  }
}

booby_trap_explode(m_actor) {
  flag_set("bomb_exploded");
  level notify("fxanim_closet_bomb_start");
  level.player playsound("wpn_grenade_explode");
  level.player playsound("evt_closet_explo_swt");
  level.player playrumbleonentity("damage_heavy");
  wait 0.5;
  level.player playsound("wpn_grenade_explode_metal");
  level thread distant_explosions();
  cleanup_ents("cleanup_transmission");
  ai_guy = get_ais_from_scene("stop_transmission_3", "soldier2");

  if(isDefined(ai_guy))
    ai_guy gun_remove();
}

distant_explosions() {
  level endon("ending_start");
  n_next_big_explosion = gettime() + 15;
  n_magnitude = 0;
  n_duration = 0;
  str_rumble = "";

  while(true) {
    wait(randomfloatrange(1.0, 7.0));
    b_big_explosion = 0;

    if(gettime() < n_next_big_explosion)
      b_big_explosion = 1;

    if(b_big_explosion) {
      n_magnitude = randomfloatrange(1.6, 2.0);
      n_duration = randomfloatrange(1.0, 1.5);
      str_rumble = "anim_heavy";
    } else {
      n_magnitude = randomfloatrange(0.2, 0.5);
      n_duration = randomfloatrange(0.5, 1.0);
      str_rumble = "anim_light";
    }

    n_distance = (1 - n_magnitude) * 512;
    v_location = level.player.origin + anglestoforward((0, randomint(360), 0)) * n_distance;
    earthquake(n_magnitude, n_duration, level.player.origin, 100);
    level.player playrumbleonentity(str_rumble);
    level.player playsound("exp_interior_explo");
  }
}

triggered_explosion() {
  self waittill("trigger");
  a_sp_guys = getentarray(self.target, "targetname");
  simple_spawn(a_sp_guys);
  s_explosion = getstruct(self.target, "targetname");

  if(isDefined(s_explosion.script_delay))
    wait(s_explosion.script_delay);

  if(isDefined(self.script_string))
    level notify(self.script_string);

  exploder(self.script_int);
  earthquake(2.0, 0.5, s_explosion.origin, 1000);
  level.player startfadingblur(2.0, 0.5);
  level.player playrumbleonentity("artillery_rumble");
  n_radius_squared = s_explosion.radius * s_explosion.radius;
  n_magnitude = 125.0;

  if(isDefined(s_explosion.script_float))
    n_magnitude = s_explosion.script_float;

  v_force = anglestoforward(s_explosion.angles) * n_magnitude;
  a_ai_guys = getaiarray("axis", "allies");

  foreach(ai_guy in a_ai_guys) {
    if(distancesquared(s_explosion.origin, ai_guy.origin) < n_radius_squared)
      ai_guy thread _launch_ai(v_force);
  }

  radiusdamage(s_explosion.origin, s_explosion.radius * 1.2, 500, 50, undefined, "MOD_EXPLOSIVE");
}

trig_wait_for_player(s_loc) {
  level endon("cleanup_scanning");
  s_loc endon("point_removed");
  n_dot = cos(30);

  while(true) {
    self waittill("trigger");

    if(level.player is_player_looking_at(s_loc.origin, n_dot, 0)) {
      set_objective(s_loc.n_objective, s_loc, "remove");

      foreach(n_index, s_scan_loc in level.a_s_scan_locations) {
        if(s_scan_loc == s_loc)
          level.a_s_scan_locations[n_index] = undefined;
      }

      level notify("location_removed");
      screen_message_create(&"HAITI_SOURCE_MISMATCH");
      wait 2.0;
      screen_message_delete();
      self delete();
      return;
    }

    wait 0.1;
  }
}

follow_player() {
  self.goalradius = 256;
  nd_curr = getnearestnode(level.player.origin);
  self setgoalnode(nd_curr);
  nd_last = nd_curr;
  wait 2.0;

  while(true) {
    n_dist_sq = distancesquared(level.player.origin, self.origin);

    if(n_dist_sq > 262144)
      self change_movemode("cqb_sprint");
    else
      self change_movemode("cqb");

    if(n_dist_sq > 65536) {
      nd_curr = getnearestnode(level.player.origin);

      if(isDefined(nd_curr) && nd_curr != nd_last) {
        self setgoalnode(nd_curr);
        nd_last = nd_curr;
      }
    }

    wait 2.0;
  }
}

hallway_pmc_think(b_unaware) {
  if(!isDefined(b_unaware))
    b_unaware = 0;

  self.goalradius = 1000;
  self.script_radius = 1000;
  self.fixednode = 0;
  self.canflank = 1;
  self.aggressivemode = 1;
  self change_movemode("cqb_sprint");

  if(isDefined(self.target)) {
    n_node = getnode(self.target, "targetname");
    self thread force_goal(n_node, 64, 1);
  }

  if(b_unaware) {
    self.ignoreall = 1;
    wait 2;
    self.ignoreall = 0;
  }
}

hallway1_pmcs() {
  simple_spawn("hallway1_pmcs", ::hallway_pmc_think, 1);
  flag_wait_or_timeout("hallway1_seals_enter", 15);
  simple_spawn("hallway1_seals", ::ally_battle_think, "hallway1_pmcs", "nd_hall_seals1_exit");
}

harper_celerium_catchup(str_triggername, e_vol) {
  level endon("close_ending_transition");
}

hangar_gump_wait(n_door_close_delay) {
  t_wait = getent("t_ending_transition", "targetname");
  t_wait waittill("trigger");
  e_vol = getent("vol_ending_gump", "targetname");

  if(level.is_harper_alive) {
    if(!level.ai_harper istouching(e_vol)) {
      s_loc = getstruct(t_wait.target, "targetname");
      level.ai_harper forceteleport(s_loc.origin, s_loc.angles);
    }

    while(!level.player istouching(e_vol) || !level.ai_harper istouching(e_vol))
      wait 0.05;
  }

  flag_set("close_ending_transition");
  wait(n_door_close_delay);
  cleanup_ents("cleanup_search");
  cleanup_ents("cleanup_lab");
  maps\_fxanim::fxanim_delete("fxanim_interior");
  load_gump("haiti_gump_hangar");
  thread maps\haiti::fxanim_construct_hangar();
  simple_spawn("celerium_camo_pmcs", ::camo_suit_think);
  level thread door_think("slide_door_top", undefined, undefined, vectorscale((0, 0, 1), 56.0), 2.0);
  level thread door_think("slide_door_bottom", undefined, undefined, vectorscale((0, 0, -1), 56.0), 2.0);
}

guard_think() {
  self endon("death");
  self camo_suit_think();
  flag_wait("sliding_door_start");
  self.ignoreall = 0;
}

sliding_door_think() {
  m_sliding_door = getent("slide_door_escape", "targetname");
  m_sliding_door movez(108, 0.05);
  flag_wait_or_timeout("sliding_door_start", 30);
  m_sliding_door movez(-78, 10);
  playsoundatposition("evt_horizontal_doors_02", (-19725, 4528, 864));
}

spin_emergency_light(str_targetname, str_start_notify, str_endon) {
  m_light = getent(str_targetname, "targetname");
  playfxontag(level._effect["emergency_light"], m_light, "tag_light_fx");
  level notify(str_start_notify);

  if(isDefined(str_endon))
    level waittill(str_endon);

  m_light delete();
}

teleport_harper_to_end() {
  e_volume = getent("vol_final_hallway", "targetname");

  if(!level.ai_harper istouching(e_volume)) {
    a_s_tp_locs = getstructarray("s_harper_skipto_end", "targetname");

    foreach(s_tp_loc in a_s_tp_locs) {
      if(level.ai_harper teleport(s_tp_loc.origin, s_tp_loc.angles))
        return;
    }
  }
}

lockbreaker_perk() {
  t_perk = getent("t_lockbreaker", "targetname");
  t_perk trigger_off();
  flag_wait("haiti_gump_interior");
  level.vh_lockbreaker_asd = spawn_vehicle_from_targetname("lockbreaker_asd");
  level.vh_lockbreaker_asd.ignoreme = 1;
  level.vh_lockbreaker_asd maps\_metal_storm::metalstorm_off();
  level.player waittill_player_has_lock_breaker_perk();
  t_perk trigger_on();
  set_objective_perk(level.obj_perk_lockbreaker, t_perk);
  t_perk waittill("trigger");
  flag_set("brute_force_perk_used");
  remove_objective_perk(level.obj_perk_lockbreaker);
  level.vh_lockbreaker_asd thread convert_asd();
  run_scene_and_delete("lockbreaker");
  level thread autosave_by_name("asd_perk");
  level thread asd_perk_dialog();
}

convert_asd() {
  self endon("death");
  wait 2;
  self maps\_metal_storm::metalstorm_set_team("allies");
  self maps\_metal_storm::metalstorm_on();
  self gopath();
  self.ignoreme = 0;
  self thread friendly_asd_death();
  self thread friendly_asd_in_theater();
  n_dist_min = 250000;

  while(true) {
    n_dist = distancesquared(self.origin, level.player.origin);

    if(n_dist > n_dist_min) {
      self thread maps\_vehicle::defend(level.player.origin, 144);
      self setspeed(15, 5, 5);
    }

    wait 0.05;
  }
}

friendly_asd_death() {
  self waittill("death");
  flag_set("friendly_asd_died");
}

friendly_asd_in_theater() {
  self endon("death");
  trig = getent("asd_in_theater", "targetname");

  while(!self istouching(trig))
    wait 0.05;

  flag_set("asd_in_theater");
}

challenge_asd_theater(str_notify) {
  self endon("death");
  flag_wait("asd_in_theater");

  if(flag("brute_force_perk_used") && !flag("friendly_asd_died"))
    self notify(str_notify);
}

lobby_dialog() {
  squadmate_dialog("usr1_contact_high_0", 3);
  flag_wait("close_outer_doors");
  level.player say_dialog("sect_this_way_down_the_0");
  flag_wait("throw_flashbangs");
  wait 3;

  if(level.player maps\_flashgrenades::isflashbanged())
    level.player say_dialog("sect_dammit_return_fire_0");
}

loading_dock_dialog() {
  level endon("player_left_docks");
  wait 2;
  harper_dialog("harp_they_re_setting_up_d_0");
  harper_dialog("harp_maintain_fire_on_the_0");
  harper_dialog("harp_don_t_let_them_breat_0");
  wait(randomfloatrange(2, 4));
  squadmate_dialog("usr3_find_cover_0");
  wait(randomfloatrange(1, 3));
  squadmate_dialog("usr0_enemy_asds_0");
  squadmate_dialog("usr1_kill_it_0");
  wait(randomfloatrange(4, 6));
  squadmate_dialog("usr0_suppressive_fire_0");
  wait(randomfloatrange(4, 6));
}

asd_perk_dialog() {
  level.player say_dialog("sect_enemy_asd_reprogramm_0");
}

theater_dialog() {
  level.player queue_dialog("sect_keep_moving_broadc_0");
  dialog_start_convo();
  level.player say_dialog("sect_main_effort_has_loca_0");
  level.player say_dialog("se1_100_series_building_0");
  level.player say_dialog("sect_se_1_switch_profile_0");
  level.player say_dialog("se1_roger_that_0");
  dialog_end_convo();
  flag_wait("theater_attack_start");

  if(level.is_harper_alive)
    harper_dialog("harp_more_quads_take_th_0");
  else
    level.player say_dialog("sect_enemy_quads_incoming_0");

  flag_wait("theater_doors_open");
  level.player say_dialog("sect_push_forward_we_ve_0");
  waittill_ai_group_cleared("control_room_defenders");

  if(level.is_harper_alive) {
    harper_dialog("harp_clear_0");
    harper_dialog("harp_okay_section_shu_0");
  }
}

find_menendez_dialog() {
  level.player say_dialog("se2_section_this_se_2_0");
  level.player say_dialog("sect_it_s_menendez_he_s_0");
  level.player say_dialog("sect_all_stations_this_ne_0");
  level.player say_dialog("usr3_checkpoint_4_we_ha_0", 10);
  level thread checkpoint_dialog();
  level.player say_dialog("sect_push_checkpoint_4_s_0", 2);
  s_final_goal = getstruct("menendez_point", "targetname");
  set_objective(level.obj_find_menendez, s_final_goal);
}

checkpoint_dialog() {
  level.player say_dialog("usr3_halt_hands_up_dro_0");
  level.player say_dialog("mene_we_are_americans_t_0");
  level.player say_dialog("usr3_orders_are_no_one_pa_0");
  level.player say_dialog("mene_relax_we_are_on_the_0");
  level.player say_dialog("sect_check_point_4_is_dow_0", 3);
}
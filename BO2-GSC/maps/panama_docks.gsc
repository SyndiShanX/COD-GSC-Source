/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\panama_docks.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_vehicle;
#include maps\_vehicle_aianim;
#include maps\panama_utility;
#include maps\_objectives;
#include maps\_turret;
#include maps\_dynamic_nodes;
#include maps\_music;
#include maps\createart\panama3_art;
#include maps\_audio;

skipto_docks() {
  level.noriega = init_hero("noriega");
  a_heroes = array(level.mason, level.noriega);
  flag_set("movie_done");
  skipto_teleport("player_teleport_elevator", a_heroes);
}

skipto_sniper() {
  level.mason = init_hero("mason");
  level.noriega = init_hero("noriega");
  a_heroes = array(level.mason, level.noriega);
  skipto_teleport("player_skipto_sniper", a_heroes);
  spawn_vehicles_from_targetname("end_scene_vehicles");
  level thread kick_off_end_event();
}

skipto_betrayal() {
  level.mason = simple_spawn_single("mason_prisoner");
  level.noriega = init_hero("noriega");
  a_heroes = array(level.mason, level.noriega);
  skipto_teleport("player_skipto_sniper", a_heroes);
}

kick_off_end_event() {
  sniper_event();
  betrayed_event();
}

kick_off_betrayal_event() {
  flag_set("movie_done");
  betrayed_event();
}

main() {
  wait 0.6;
  teleport_struct = getstruct("player_teleport_elevator", "targetname");
  level.player setorigin(teleport_struct.origin);
  level.player setplayerangles(teleport_struct.angles);
  level.player setlowready(1);
  level thread docks_ik_headtracking_limits();
  flag_set("docks_entering_elevator");
  level.noriega change_movemode("walk");
  level thread run_scene_and_delete("noriega_idle_elevator");
  flag_wait("movie_done");
  level thread dock_vo();
  elevator_ride();
  sniper_event();
  betrayed_event();
}

jeep_intro_setup() {
  trigger_off("sniper_turret_trigger", "targetname");
  maps\createart\panama3_art::docks();
  s_elevator_light_attach_marker = getstruct("elevator_light_attach_marker", "targetname");
  m_elevator_light_attach_point = spawn_model("tag_origin", s_elevator_light_attach_marker.origin, s_elevator_light_attach_marker.angles);
  m_elevator_light_attach_point linkto(getent("docks_elevator", "targetname"), "tag_origin");
  playfxontag(getfx("elevator_light"), m_elevator_light_attach_point, "tag_origin");
  level.vh_player_jeep = spawn("script_model", (0, 0, 0));
  level.vh_player_jeep setmodel("veh_iw_hummer_opentop");
  level.vh_player_jeep.animname = "player_jeep";
  level.vh_player_jeep.targetname = "player_jeep";
  playfxontag(level._effect["jeep_spot_light"], level.vh_player_jeep, "tag_headlight_left");
  playfxontag(level._effect["jeep_headlight"], level.vh_player_jeep, "tag_headlight_left");
}

docks_magic_rpg_setup() {
  a_triggers = getentarray("docks_rpg", "targetname");
  array_thread(a_triggers, ::docks_magic_rpg_think);
}

docks_magic_rpg_think() {
  self waittill("trigger");
  s_rpg_start = getstruct(self.target, "targetname");
  s_rpg_end = getstruct(s_rpg_start.target, "targetname");
  magicbullet("rpg_magic_bullet_sp", s_rpg_start.origin, s_rpg_end.origin);
  self delete();
}

docks_container_moment() {
  flag_wait("jeep_fence_crash");
  simple_spawn_single("docks_container_pdf_rpg", ::init_docks_container_pdf_rpg);
  simple_spawn("docks_container_pdf", ::init_docks_container_pdf);
  vh_contrainer_truck = spawn_vehicle_from_targetname_and_drive("docks_container_truck");
  trigger_wait("docks_rpg");
  wait 2;

  for(i = 0; i < 6; i++) {
    blowup_origin = getent("container_damage_points_" + (i + 1), "targetname");
    radiusdamage(blowup_origin.origin, 50, 50, 100, undefined, "MOD_EXPLOSIVE");
    wait 0.2;
  }

  super_fly = getentarray("super_fly_pdf", "script_noteworthy");

  for(i = 0; i < super_fly.size; i++) {
    if(isai(super_fly[i])) {
      if(isDefined(super_fly[i])) {
        playfxontag(level._effect["pdf_armstrong_fire_Fx"], super_fly[i], "tag_origin");
        super_fly[i] startragdoll();
        super_fly[i] launchragdoll((180, 0, 150));
        break;
      }
    }
  }

  wait 1;
  vh_contrainer_truck notify("death");
}

init_docks_container_pdf_rpg() {
  self endon("death");
  self.ignoreme = 1;
  self.ignoreall = 1;
  trigger_wait("docks_rpg");
  e_rpg_jeep_target = getent("rpg_jeep_target", "targetname");
  wait 4;
  magicbullet("rpg_magic_bullet_sp", self gettagorigin("tag_flash"), e_rpg_jeep_target.origin);
}

init_docks_container_pdf() {
  self endon("death");
  self.ignoreall = 1;
  trigger_wait("docks_rpg");
  self.ignoreall = 0;
}

jeep_crash_moments() {
  a_foliage_crash_1 = getentarray("foliage_crash_1", "targetname");
  flag_wait("jeep_fence_crash");
  level notify("fxanim_fence_break_start");
}

jeep_intro_ride() {
  level thread docks_gate_ambush();
  level thread docks_container_moment();
  level thread jeep_crash_moments();
  level thread red_barrel_detect_damage();
  level thread dock_rumble();
  level.player enableinvulnerability();
  level.noriega set_ignoreall(1);
  level.noriega set_ignoreme(1);
  level thread run_scene("player_jeep_rail_jeep");
  level thread run_scene("player_jeep_rail");
  level thread do_drive_by_shooting_sequence();
  exploder(802);
  scene_wait("player_jeep_rail");
  level.noriega.ignoreme = 1;
  level.noriega.ignoreall = 1;
  enemies = getaiarray("axis");

  for(i = 0; i < enemies.size; i++)
    enemies[i] delete();

  autosave_by_name("finish_driveby");
  colt_victim = simple_spawn("docks_colt_victims");
  level thread run_scene("player_jeep_jeep_idle");
  level thread run_scene("player_jeep_idle_loop");
  player_body = get_model_or_models_from_scene("player_jeep_rail", "player_body");
  level thread give_player_max_ammo();
  level.player enableweapons();
  wait 0.05;
  level.player playerlinktodelta(player_body, "tag_player", 0.5, 30, 30, 40, 30);
  level.player showviewmodel();
  level.player disableweaponcycling();
  player_body hide();

  while(true) {
    colt_victim = array_removedead(colt_victim);

    if(colt_victim.size == 0) {
      break;
    }

    wait 0.05;
  }

  level.player playerlinktoabsolute(player_body, "tag_player");
  level notify("viewmodel_off");
  level.player disableweapons();
  wait 0.5;
  level.player takeweapon("m1911_1handed_sp");
  level.player hideviewmodel();
  player_body show();
  level.player enableweaponcycling();
  level.player switchtoweapon(level.player.original_weapon);
  level thread run_scene("player_jeep_jeep_idle_end");
  run_scene("player_jeep_idle_end");
  flag_set("docks_cleared");
  autosave_by_name("finish_driveby");
}

do_drive_by_shooting_sequence() {
  wait 1;
  player_body = get_model_or_models_from_scene("player_jeep_rail", "player_body");
  level.player.current_weapon = level.player getcurrentweapon();
  level.player.original_weapon = level.player getcurrentweapon();
  modelname = getweaponmodel(level.player.current_weapon);
  player_body attach(modelname, "tag_weapon");
  wait 4;
  level.player enableweapons();
  level.player setlowready(1);
  level waittill("viewmodel_on");
  level thread give_player_max_ammo();
  level thread timescale_tween(1, 0.5, 1);
  level.player playerlinktodelta(player_body, "tag_player", 0.5, 40, 30, 40, 30);
  level.player setlowready(0);
  level.player showviewmodel();
  level.player disableweaponcycling();
  level.player allowads(0);
  player_body hide();
  level waittill("viewmodel_off");
  player_body detach(modelname, "tag_weapon");
  level.player playerlinktoabsolute(player_body, "tag_player");
  player_body show();
  level.player hideviewmodel();
  level.player enableweaponcycling();
  level.player disableweapons();
  level.player allowads(1);
  level.player giveweapon("m1911_1handed_sp");
  level.player switchtoweapon("m1911_1handed_sp");
  timescale_tween(0.5, 1, 1);
}

give_player_max_ammo() {
  level.player.current_weapon = level.player getcurrentweapon();
  level.player setweaponammoclip(level.player.current_weapon, 400);
  level.player givemaxammo(level.player.current_weapon);
}

red_barrel_detect_damage() {
  dam_trigger = getentarray("drive_by_damage_trigger", "targetname");
  array_thread(dam_trigger, ::deal_damage_when_shot);
}

deal_damage_when_shot() {
  while(true) {
    self waittill("damage", amount, attacker);

    if(attacker == level.player) {
      radiusdamage(self.origin, 50, 50, 100, undefined, "MOD_EXPLOSIVE");
      break;
    }
  }
}

docks_gate_ambush() {
  add_spawn_function_veh("docks_gate_turret_truck", ::init_docks_gate_turret_truck);
  a_docks_gate_runners = getentarray("docks_gate_runners", "targetname");
  array_thread(a_docks_gate_runners, ::add_spawn_function, ::init_docks_frontgate_pdf);
  a_docks_frontgate_pdf = getentarray("docks_frontgate_pdf", "targetname");
  array_thread(a_docks_frontgate_pdf, ::add_spawn_function, ::init_docks_frontgate_pdf);
  wait 2;
  simple_spawn("docks_frontgate_pdf");
  wait 2;
  spawn_vehicle_from_targetname_and_drive("docks_gate_turret_truck");
  wait 2;
  simple_spawn("docks_gate_runners");
}

init_docks_gate_turret_truck() {
  self endon("death");
  flag_wait("start_gate_ambush");
  self maps\_turret::set_turret_burst_parameters(3.0, 5.0, 1.0, 2.0, 1);
  self enable_turret(1);
  flag_wait("jeep_fence_crash");
  self disable_turret(1);
  self notify("death");
}

init_docks_frontgate_pdf() {
  self endon("death");
  self.ignoreall = 1;
  self.ignoreme = 1;
  flag_wait("start_gate_ambush");
  self.ignoreall = 0;
  self.ignoreme = 0;
  flag_wait("jeep_fence_crash");
  self die();
}

jeep_unload_player() {
  self.e_jeep_door_mount = spawn("script_origin", self.origin);
  self.e_jeep_door_mount.angles = self.angles;
  self playerlinkto(self.e_jeep_door_mount, undefined, 0, 7, 45, 15, 7);
}

jeep_drive(docks_jeep) {
  docks_jeep veh_toggle_tread_fx(1);
  run_scene("docks_drive");
  docks_jeep veh_toggle_tread_fx(0);
}

init_flags() {
  flag_init("docks_battle_one_trigger_event");
  flag_init("docks_cleared");
  flag_init("docks_entering_elevator");
  flag_init("docks_rifle_mounted");
  flag_init("docks_kill_menendez");
  flag_init("sniper_start_timer");
  flag_init("sniper_stop_timer");
  flag_init("sniper_mason_shot1");
  flag_init("sniper_mason_shot2");
  flag_init("docks_mason_down");
  flag_init("docks_betrayed_fade_in");
  flag_init("docks_betrayed_fade_out");
  flag_init("docks_mason_dead_reveal");
  flag_init("docks_final_cin_fade_in");
  flag_init("docks_final_cin_fade_out");
  flag_init("docks_final_cin_landed1");
  flag_init("docks_final_cin_landed2");
  flag_init("challenge_nodeath_check_start");
  flag_init("challenge_nodeath_check_end");
  flag_init("challenge_docks_guards_speed_kill_start");
  flag_init("challenge_docks_guards_speed_kill_pause");
  flag_init("jeep_foliage_crash_1");
  flag_init("jeep_foliage_crash_2");
  flag_init("jeep_fence_crash");
  flag_init("start_gate_ambush");
  flag_init("fuel_tanks_destroyed");
  flag_init("noriega_delivered_bringout_line");
}

challenge_docks_guards_speed_kill(str_notify) {
  flag_wait("challenge_docks_guards_speed_kill_start");
  n_timer_start = gettime();
  flag_wait("challenge_docks_guards_speed_kill_pause");
  n_total_time = gettime() - n_timer_start;
  flag_wait("challenge_docks_guards_speed_kill_start");
  n_timer_start = gettime();
  flag_wait("docks_cleared");
  n_total_time = n_total_time + (gettime() - n_timer_start);

  if(n_total_time < 15000)
    self notify(str_notify);
}

docks_elevator_wait_vo() {
  level.player say_dialog("im_at_the_elevato_009", 0.5);
  level.player say_dialog("take_it_up_to_the_010", 0.5);
}

docks_elevator_ride_vo() {
  level.player say_dialog("maso_woods_are_you_in_po_0", 0.5);
  level.player say_dialog("where_are_you_bro_002");
  level.player say_dialog("fucking_comms_006", 1.0);
}

docks_elevator_exit_vo() {
  level.player say_dialog("woods_what_is_y_004");
  level.player say_dialog("hudson_ive_lo_005", 0.5);
}

docks_sniping_setup_vo() {
  level.player say_dialog("do_you_see_nexus_t_006", 0.5);
  level.player say_dialog("its_him_menend_007", 0.5);
  level.player say_dialog("make_it_quick_woo_008", 0.5);
}

docks_sniping_walk_vo() {
  level.player say_dialog("hudson_confirm_h_009", 1.5);
  level.player say_dialog("take_the_headshot_010", 0.5);
}

elevator_ride() {
  flag_init("noriega_delivered_bringout_line");
  level.player disableoffhandweapons();
  level.player setlowready(1);
  a_end_scene_vehicles = spawn_vehicles_from_targetname("end_scene_vehicles");

  foreach(vh_vehicle in a_end_scene_vehicles)
  vh_vehicle godon();

  setmusicstate("PANAMA_ELEVATOR");
  top_roll_door = getent("dock_top_roll_door", "targetname");
  e_elevator = getent("docks_elevator", "targetname");
  e_elevator setmovingplatformenabled(1);
  top_roll_door linkto(e_elevator);
  e_elevator_move_target = getstruct("docks_elevator_move_target", "targetname");
  level.player playsound("evt_elevator_quad");
  e_elevator moveto(e_elevator_move_target.origin, 5.0);
  e_elevator waittill("movedone");
  level thread maps\createart\panama3_art::sniper();
  level notify("elevator_stop_top");
  level thread open_top_elevator_door();
  wait 1;
  end_scene("noriega_idle_elevator");
  level.noriega unlink();
  level thread run_scene_and_delete("noriega_exit_elevator");
  level.player setmovespeedscale(0);
  wait 3;
  level.player setmovespeedscale(1);
  elevator_door_clip = getent("elevator_top_player_clip", "targetname");
  elevator_door_clip delete();
  level.player thread player_walk_speed_adjustment(level.noriega, "docks_rifle_mounted", 128, 256, 0.2, 0.4);
  level.player allowsprint(0);
  level.player allowjump(0);
  level thread autosave_by_name("sniper_start");
}

open_bottom_elevator_door() {
  bottom_door_bottom = getent("dock_elevator_bottom_door_bottom", "targetname");
  bottom_door_top = getent("dock_elevator_bottom_door_top", "targetname");
  bottom_roll = getent("dock_bottom_roll_door", "targetname");
  bottom_door_top playsound("evt_elevator_middoor");
  bottom_door_bottom movez(-74, 2);
  bottom_door_top movez(74, 2);
  bottom_door_top waittill("movedone");
  bottom_roll playsound("evt_elevator_topdoor");
  bottom_roll movez(130, 4);
  bottom_roll waittill("movedone");
  elevator_door_clip = getent("elevator_player_clip", "targetname");
  elevator_door_clip trigger_off();
}

close_bottom_door_elevator() {
  bottom_door_bottom = getent("dock_elevator_bottom_door_bottom", "targetname");
  bottom_door_top = getent("dock_elevator_bottom_door_top", "targetname");
  bottom_roll = getent("dock_bottom_roll_door", "targetname");
  elevator_door_clip = getent("elevator_player_clip", "targetname");
  trigger_wait("elevator_trigger_interior");
  elevator_door_clip trigger_on();
  bottom_door_top playsound("evt_elevator_middoor");
  bottom_door_bottom movez(74, 2);
  bottom_door_top movez(-74, 2);
  bottom_roll playsound("evt_elevator_topdoor");
  bottom_roll = getent("dock_bottom_roll_door", "targetname");
  bottom_roll movez(-130, 4);
  bottom_roll waittill("movedone");
  e_elevator = getent("docks_elevator", "targetname");
  bottom_roll linkto(e_elevator);
}

open_top_elevator_door() {
  top_door_bottom = getent("dock_elevator_top_door_bottom", "targetname");
  top_door_top = getent("dock_elevator_top_door_top", "targetname");
  top_roll = getent("dock_top_roll_door", "targetname");
  top_roll unlink();
  top_door_top playsound("evt_elevator_middoor");
  top_door_bottom movez(-74, 2);
  top_door_top movez(74, 2);
  top_door_bottom waittill("movedone");
  top_roll playsound("evt_elevator_topdoor");
  top_roll movez(130, 4);
  top_roll waittill("movedone");
}

sniper_event() {
  level thread run_scene_and_delete("sniper_idle_door");
  scene_wait("noriega_exit_elevator");
  level thread run_scene_and_delete("noriega_idle_sniper_door");
  trigger_wait("sniper_noriega_kill_guard_trigger");
  level thread sniper_dialog();
  run_scene_and_delete("noriega_kill_guard_give_sniper");
  level.player setlowready(0);
  setmusicstate("PANAMA_SNIPE");
  level thread run_scene("noriega_idle_woods_snipe");
  setsaveddvar("cg_fovmin", 5);
  flag_set("docks_rifle_mounted");
  wait 0.05;
  level.player takeallweapons();
  level.player giveweapon("barretm82_highvzoom_sp");
  level.player thread keep_giving_the_player_ammo_till_sniper_over();
  level.player disableweaponfire();
  autosave_by_name("sniper_sequence");
  level waittill("bring_out_mason");
  add_spawn_function_group("sniper_guards", "targetname", ::set_ignoreall, 1);
  ai_sniper_guards = simple_spawn("sniper_guards");
  level.mason = simple_spawn_single("mason_prisoner");
  level.mason attach("c_usa_captured_mason_sack_clean", "J_Helmet");
  level.mason.overrideactordamage = ::mason_damage_override;
  level.mason.team = "axis";
  level.mason magic_bullet_shield();
  level.mason thread mason_damage_events();
  array_thread(ai_sniper_guards, ::sniper_guard_damage_fail);
  level thread run_noriega_scene_that_plays_bringout_vo();
  level thread noriega_idle_watch();
  level thread run_scene_and_delete("sniper_walk");
  level thread run_sniper_idle();
  level thread maps\createart\panama3_art::walk();
  flag_wait("docks_mason_down");
  set_objective(level.obj_docks_kill_menendez, level.mason, "done");
  setmusicstate("PANAMA_RUN");
  screen_fade_out(0.05);
}

run_noriega_scene_that_plays_bringout_vo() {
  level thread run_scene("noriega_idle_woods_snipe_bring_him_out");
  wait 4.0;
  flag_set("noriega_delivered_bringout_line");
}

noriega_idle_watch() {
  level endon("docks_mason_down");
  scene_wait("noriega_idle_woods_snipe_bring_him_out");
  level thread run_scene("noriega_idle_woods_snipe");
  scene_wait("sniper_walk");
  run_scene("noriega_idle_woods_snipe_take_the_shot");
  level thread run_scene("noriega_idle_woods_snipe");
}

run_sniper_idle() {
  level endon("sniper_mason_shot1");
  scene_wait("noriega_idle_woods_snipe_bring_him_out");
  flag_set("docks_kill_menendez");
  level.player enableweaponfire();
  level thread run_scene_and_delete("sniper_start_idle");
}

keep_giving_the_player_ammo_till_sniper_over() {
  level endon("docks_mason_down");

  while(true) {
    level.player waittill("weapon_fired");
    level.player givemaxammo("barretm82_highvzoom_sp");
  }
}

set_sniper_turret_zoom() {
  setsaveddvar("cg_fovmin", 3);
  setsaveddvar("turretscopezoom", 7.5);
  setsaveddvar("turretscopezoommax", 7.5);
  setsaveddvar("turretscopezoommin", 3);
  setsaveddvar("turretscopezoomrate", 7);
}

mason_damage_events(e_sniper_turret) {
  self waittill("damage");
  level notify("mason_shot");
  flag_set("sniper_mason_shot1");

  if(self is_fatal_shot()) {
    if(is_mature()) {
      if(self.damagelocation == "helmet" || self.damagelocation == "neck")
        playfxontag(getfx("mason_fatal_blood"), self, "j_head");
    }

    self detach("c_usa_captured_mason_sack_clean", "j_helmet");
    self attach("c_usa_captured_mason_sack", "j_helmet");
    level.player set_story_stat("MASON_SR_DEAD", 1);
    level.mason_dead = 1;
    level thread run_scene_and_delete("sniper_shot");
  } else {
    level.player thread say_dialog("huds_shoot_him_in_the_fuc_0");
    end_scene("sniper_start_idle");
    run_scene_and_delete("sniper_injured_shot");
    level thread run_scene_and_delete("sniper_shot_idle");
    self waittill("damage");
    flag_set("sniper_mason_shot2");

    if(self is_fatal_shot()) {
      if(is_mature()) {
        if(self.damagelocation == "helmet" || self.damagelocation == "neck")
          playfxontag(getfx("mason_fatal_blood"), self, "j_head");
      }

      self detach("c_usa_captured_mason_sack_clean", "j_helmet");
      self attach("c_usa_captured_mason_sack", "j_helmet");
      level.player set_story_stat("MASON_SR_DEAD", 1);
      level.mason_dead = 1;
    } else {
      iprintln("MASON LIVES!!!...");

      level.player set_story_stat("MASON_SR_DEAD", 0);
      self detach("c_usa_captured_mason_head_shot");
      wait 0.05;
      self attach("c_usa_captured_mason_head_normal");
      level.player giveachievement_wrapper("SP_STORY_MASON_LIVES");
    }

    level thread run_scene_and_delete("sniper_injured_last_shot");
  }

  wait 1.5;
  flag_set("docks_mason_down");
}

mason_damage_override(e_inflictor, e_attacker, n_damage, n_flags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime, str_bone_name) {
  if(!(str_hit_loc == "helmet" || str_hit_loc == "neck" || str_hit_loc == "torso_upper")) {
    if(is_mature())
      self play_fx("mason_non_fatal_blood", v_point);
  }

  return n_damage;
}

mason_no_snipe_fail() {
  level endon("mason_shot");
  flag_wait("sniper_stop_timer");
  fail_player(&"PANAMA_SNIPER_FAIL");
}

sniper_guard_damage_fail() {
  level endon("sniping finished");
  self magic_bullet_shield();

  while(true) {
    self waittill("damage");
    wait 0.2;
    self waittill("damage");
    fail_player(&"PANAMA_SNIPER_FAIL");
  }
}

is_fatal_shot() {
  if(self.damagelocation == "helmet" || self.damagelocation == "neck" || self.damagelocation == "head")
    return true;

  return false;
}

#using_animtree("player");

betrayed_event() {
  mason_prisoner = getent("mason_prisoner_ai", "targetname");
  mason_prisoner_weapon = spawn_model("t6_wpn_pistol_m1911_world", mason_prisoner gettagorigin("tag_weapon_right"), mason_prisoner gettagangles("tag_weapon_right"));
  mason_prisoner_weapon linkto(mason_prisoner, "tag_weapon_right");
  wait 2;
  level thread screen_fade_in(0.5);
  end_scene("noriega_idle_woods_snipe");
  soldier = getentarray("sniper_guards_ai", "targetname");

  for(i = 0; i < soldier.size; i++)
    soldier[i] delete();

  level.menendez = init_hero("menendez");
  level thread run_scene_and_delete("betrayed_weapon_1");

  if(is_mature())
    exploder(1001);

  run_scene_and_delete("betrayed");
  level thread run_scene_and_delete("betrayed_weapon_2");
  level thread run_scene_and_delete("betrayed_2");
  level thread run_scene("betrayed_shotgun_2");
  level thread start_hearbeat();
  anim_len = getanimlength( % p_pan_09_01_betrayed_2_player);
  wait(anim_len - 0.1);
  rpc("clientscripts/panama_3_amb", "pre_end_snapshot");
  screen_fade_out(0.05);
  level notify("kill_heartbeat");
  level thread init_for_menendez_scene();
  old_man_woods("panama_int_3", "sndTheEnd");

  if(isDefined(level.mason_dead)) {
    level.mason detach("c_usa_captured_mason_sack", "J_Helmet");
    level thread run_scene_first_frame("ending_bare_room_1");
  } else {
    level.mason detach("c_usa_captured_mason_sack_clean", "J_Helmet");
    level thread run_scene_first_frame("ending_bare_room_1_mason_alive");
  }

  level thread maps\_audio::switch_music_wait("PANAMA_ENDING", 0.1);
  level thread screen_fade_in(1);
  exploder(909);
  level thread run_scene_and_delete("ending_bare_room_1_shotgun");

  if(isDefined(level.mason_dead)) {
    run_scene_and_delete("ending_bare_room_1");
    run_scene_and_delete("ending_bare_room_2");
    run_scene_and_delete("ending_bare_room_3");
  } else {
    run_scene_and_delete("ending_bare_room_1_mason_alive");
    run_scene_and_delete("ending_bare_room_2_mason_alive");
    run_scene_and_delete("ending_bare_room_3_mason_alive");
  }

  flag_set("challenge_nodeath_check_start");
  flag_wait("challenge_nodeath_check_end");
  nextmission();
}

start_hearbeat() {
  level endon("kill_heartbeat");
  level waittill("start_heartbeat");
  wait 1;

  while(true) {
    level.player playrumbleonentity("heartbeat_low");
    wait(randomfloatrange(0.75, 1.25));
  }
}

init_for_menendez_scene() {
  level.hudson = level thread init_hero("hudson");
  level.menendez set_ignoreall(1);
}

swap_player_body_dmg1(e_player_body) {
  magicbullet("m1911_sp", level.noriega_betrayed_weapon gettagorigin("tag_flash"), e_player_body gettagorigin("J_Knee_LE"));
  playfxontag(getfx("player_knee_shot_l"), e_player_body, "J_Knee_LE");
  e_player_body setmodel("c_usa_woods_panama_lower_dmg1_viewbody");
  flag_set("docks_mason_dead_reveal");
}

swap_player_body_dmg2(e_player_body) {
  magicbullet("m1911_sp", level.noriega_betrayed_weapon gettagorigin("tag_flash"), e_player_body gettagorigin("J_Knee_RI"));
  playfxontag(getfx("player_knee_shot_r"), e_player_body, "J_Knee_RI");
  e_player_body setmodel("c_usa_woods_panama_lower_dmg2_viewbody");
}

swap_player_body_dmg3(e_player_body) {
  a_sniper_guards = getentarray("sniper_guards_ai", "targetname");

  foreach(e_guard in a_sniper_guards) {
    if(e_guard.script_animname == "sniper_guard1_ai")
      e_sniper_guard = e_guard;
  }

  assert(isDefined(e_sniper_guard), "No 'sniper_guard1_ai' for shot 3.");
  magicbullet("ak47_sp", e_sniper_guard gettagorigin("tag_flash"), e_player_body gettagorigin("J_Wrist_RI"));
  playfxontag(getfx("player_knee_shot_r"), e_player_body, "J_Wrist_RI");
}

dock_vo() {
  level endon("docks_mason_down");
  level.player say_dialog("maso_woods_are_you_in_po_0");
  level.player say_dialog("wood_mason_is_already_in_0");
  level.player say_dialog("maso_on_top_of_the_west_b_0");
  level.player say_dialog("wood_fucking_comms_0");
}

sniper_dialog() {
  level endon("sniper_mason_shot1");
  level endon("docks_mason_down");
  scene_wait("noriega_kill_guard_give_sniper");
  level.player say_dialog("wood_hudson_0", 2);
  level.player say_dialog("huds_it_s_him_woods_nex_0", 1);
  level.player say_dialog("wood_you_should_have_told_0", 0.5);
  level.player say_dialog("wood_you_should_have_told_1", 0.4);
  level notify("bring_out_mason");
  flag_wait("noriega_delivered_bringout_line");
  level.player say_dialog("wood_they_re_bringing_the_0", 0.5);
  level.player say_dialog("huds_confirm_visual_0", 0.3);
  set_objective(level.obj_docks_kill_menendez, level.mason, "Kill");

  if(level.player get_story_stat("KRAVCHENKO_INTERROGATED"))
    level.player thread say_dialog("krav_he_even_has_people_i_1", 0.5);

  flag_wait("docks_kill_menendez");
  level.player say_dialog("huds_end_this_now_woods_0");
  wait 3;
  level.player say_dialog("huds_take_the_headshot_0");
  wait 3;
  wait 3;
  level.player say_dialog("huds_that_is_a_direct_ord_0");
}

dock_rumble() {
  level.player playrumblelooponentity("angola_hind_ride");
  flag_wait("jeep_fence_crash");
  level.player playrumbleonentity("grenade_rumble");
  wait 10.5;
  level.player playrumbleonentity("grenade_rumble");
  scene_wait("player_jeep_rail");
  level.player stoprumble("angola_hind_ride");
  flag_wait("docks_entering_elevator");
  level.player playrumblelooponentity("angola_hind_ride");
  level waittill("elevator_stop_top");
  level.player stoprumble("angola_hind_ride");
}

start_fire_work() {
  rotator = getent("the_great_rotator", "targetname");
  spawners = getentarray("firework_spawner", "script_noteworthy");

  for(i = 0; i < spawners.size; i++)
    spawners[i] linkto(rotator);

  while(true) {
    firework_forward_launch();
    wait 0.05;
  }
}

firework_forward_launch() {
  for(i = 1; i < 11; i++) {
    firework = simple_spawn_single("firework_pdf_" + i);
    firework.targetname = "fire_works";
    firework thread delete_in_five();
    playfxontag(level._effect["pdf_armstrong_fire_Fx"], firework, "tag_origin");
    playfxontag(level._effect["jet_contrail"], firework, "tag_origin");
    firework startragdoll();
    firework launchragdoll((360 - (i - 1) * 72, 0, 750));
    wait 0.2;
  }

  for(i = 10; i > 0; i--) {
    firework = simple_spawn_single("firework_pdf_" + i);
    firework.targetname = "fire_works";
    firework thread delete_in_five();
    playfxontag(level._effect["pdf_armstrong_fire_Fx"], firework, "tag_origin");
    playfxontag(level._effect["jet_contrail"], firework, "tag_origin");
    firework startragdoll();
    firework launchragdoll((-360 - (i - 10) * 72, 0, 750));
    wait 0.1;
  }
}

delete_in_five() {
  wait 2;
  self delete();
}

docks_ik_headtracking_limits() {
  setsaveddvar("ik_pitch_limit_thresh", 20);
  setsaveddvar("ik_pitch_limit_max", 70);
  setsaveddvar("ik_roll_limit_thresh", 40);
  setsaveddvar("ik_roll_limit_max", 100);
  setsaveddvar("ik_yaw_limit_thresh", 20);
  setsaveddvar("ik_yaw_limit_max", 90);
}
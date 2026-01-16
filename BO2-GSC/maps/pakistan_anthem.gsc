/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\pakistan_anthem.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_vehicle;
#include maps\pakistan_util;
#include maps\_glasses;
#include maps\_scene;
#include maps\_turret;
#include maps\_objectives;
#include maps\_dialog;
#include maps\_music;
#include maps\_anim;
#include maps\_patrol;

skipto_anthem() {
  iprintln("Anthem");

  level.harper = init_hero("harper");
  skipto_teleport("skipto_anthem", array(level.harper));
}

main() {
  anthem_setup();
  wall_grapple_event();
  id_menendez_event();
  menendez_surveillance_event();
  flag_wait("tower_melee_complete");
}

anthem_setup() {
  screen_fade_out(0);
  level.player thread take_and_giveback_weapons("grapple_done");
  level.harper = init_hero("harper");
  level.player set_ignoreme(1);
  level.harper set_ignoreme(1);
  level.harper set_ignoreall(1);
  level.harper change_movemode("cqb_walk");
  hide_post_grenade_room();
  maps\_patrol::patrol_init();
  spawn_vehicle_from_targetname("confirm_menendez_gaz");
  spawn_vehicle_from_targetname("courtyard_gaz_1");
  spawn_vehicle_from_targetname("courtyard_gaz_2");
  setup_doors();
  level thread courtyard_sounds();
  level thread fake_spotlight_movement();
  level thread surveillance_spotlight_movement();
  level thread courtyard_btrs();
  level thread anthem_saves();
  level thread anthem_objectives();
  courtyard_spawn_funcs();
}

crosby_behavior() {
  self endon("death");
  self.animname = "crosby";
  self setgoalpos(self.origin);
  e_target = getent("grapple_target", "targetname");
  self thread aim_at_target(e_target);
}

init_courtyard_ai() {
  a_courtyard_enemies = [];

  for(i = 0; i < 4; i++)
    a_courtyard_enemies[i] = simple_spawn_single("anthem_courtyard_soldiers" + i);

  a_enemies = a_courtyard_enemies;

  foreach(ai_enemy in a_enemies) {
    ai_enemy set_ignoreall(1);
    ai_enemy set_ignoreme(1);
  }

  foreach(e_spawner in getentarray("btr_guys", "script_noteworthy"))
  e_spawner add_spawn_function(::btr_scene_spawn_func);

  run_scene_first_frame("courtyard_btr_entrance");
  level thread run_scene("courtyard_btr_director");
  trigger_use("trigger_vtol");
}

monitor_player_weaponfire() {
  self endon("death");
  self waittill_any("damage", "bulletwhizby", "grenade_fire", "pain", "alert_drones");
  flag_set("alert_drones");
  self stopanimscripted(1);
  self set_ignoreall(0);
}

courtyard_guards_alerted() {
  self endon("death");
  flag_wait("alert_drones");
  self stopanimscripted(1);
  self set_ignoreall(0);
}

courtyard_ai_behavior() {
  a_ai_guys = getaiarray("axis");

  foreach(ai_guy in a_ai_guys) {
    ai_guy thread monitor_player_weaponfire();
    ai_guy thread courtyard_guards_alerted();
  }
}

stealth_init_spawn_func() {
  if(isDefined(self.script_noteworthy)) {
  }
}

courtyard_logic() {
  self endon("death");
  self set_ignoreall(1);
  self set_ignoreme(1);
  self set_goalradius(8);
}

btr_scene_spawn_func() {
  scene_wait("courtyard_btr_entrance");
  self set_ignoreme(1);
  self set_ignoreall(1);
  self set_goalradius(8);
  self waittill("goal");
  self delete();
}

courtyard_btrs() {
  a_s_spawnpts = [];
  level.a_vh_btrs = [];
  a_start_nodes = [];

  for(i = 1; i < 5; i++)
    a_s_spawnpts[i] = getstruct("courtyard_btr_spawnpt" + i, "targetname");

  for(i = 1; i < 5; i++)
    a_start_nodes[i] = getvehiclenode("start_btr" + i, "targetname");

  for(i = 1; i < 5; i++) {
    level.a_vh_btrs[i] = spawn_vehicle_from_targetname("isi_btr");
    level.a_vh_btrs[i].origin = a_s_spawnpts[i].origin;
    level.a_vh_btrs[i].angles = a_s_spawnpts[i].angles;
    level.a_vh_btrs[i] attachpath(a_start_nodes[i]);
  }
}

courtyard_btr_logic() {
  wait 20;
  level.a_vh_btrs[1] headlights_on();
  wait 1.3;
  level.a_vh_btrs[3] headlights_on();
  wait 0.8;
  level.a_vh_btrs[2] headlights_on();
  wait 0.3;
  level.a_vh_btrs[4] headlights_on();
  playsoundatposition("amb_anthem_btr_multiples", (-19497, 40017, 659));

  for(i = 1; i < 5; i++) {
    level.a_vh_btrs[i] pathfixedoffset((0, randomfloatrange(-24, 24), 0));
    level.a_vh_btrs[i] thread gopath();
    level.a_vh_btrs[i] thread delete_vehicle_at_end();

    if(i == 3)
      level thread confirm_menendez_gaz_driveaway();

    wait 4.0;
  }
}

delete_vehicle_at_end() {
  self waittill("reached_end_node");
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

courtyard_spawn_funcs() {
  add_spawn_function_group("anthem_courtyard_runner1", "targetname", ::courtyard_runner_logic);
  add_spawn_function_group("anthem_courtyard_runner2", "targetname", ::courtyard_runner_logic);
  add_spawn_function_group("bodyguard1", "targetname", ::bodyguard_logic);
  add_spawn_function_group("bodyguard2", "targetname", ::bodyguard_logic);
}

#using_animtree("generic_human");
#using_animtree("vehicles");

vtol_spawn_func() {
  self endon("death");
  self veh_magic_bullet_shield(1);
  vtol_ent = spawn("script_origin", self.origin);
  vtol_ent playloopsound("evt_vtol_idle_stdy");
  self setforcenocull();
  wait 1;
  self veh_toggle_exhaust_fx(0);
  self veh_toggle_tread_fx(0);
  self lights_off();
  self vehicle_toggle_sounds(0);
  flag_wait("rooftop_meeting_defalco_started");
  wait(getanimlength( % ch_pakistan_5_7_meeting_defalco) - 3);
  self setanim( % v_vtol_doors_close, 1, 2.5, 1);
  wait 3;
  flag_set("osprey_away");
  vtol_ent delete();
  vtol_launch_ent = spawn("script_origin", self.origin);
  vtol_launch_ent playsound("evt_launch_sweet");
  vtol_launch_ent playloopsound("evt_launch_up");
  s_goal1 = getstruct("vtol_goal1", "targetname");
  s_goal2 = getstruct("vtol_goal2", "targetname");
  s_goal3 = getstruct("vtol_goal3", "targetname");
  s_goal4 = getstruct("vtol_goal4", "targetname");
  self veh_toggle_exhaust_fx(1);
  self veh_toggle_tread_fx(1);
  self lights_on();
  self vehicle_toggle_sounds(1);
  wait 1;
  self setspeed(8, 3, 1);
  self setvehgoalpos(s_goal1.origin, 0);
  self waittill("goal");
  self setspeed(25, 10, 5);
  self setvehgoalpos(s_goal2.origin, 0);
  self waittill("goal");
  self setspeed(55, 20, 15);
  self setvehgoalpos(s_goal3.origin, 0);
  self waittill("goal");
  self setspeed(75, 30, 25);
  self setvehgoalpos(s_goal4.origin, 0);
  self waittill("goal");
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();

  vtol_launch_ent delete();
}

courtyard_runner_logic() {
  self endon("death");
  self.goalradius = 64;
  self.animname = "generic";
  self set_run_anim("combat_jog");
  self set_ignoreall(1);
  self set_ignoreme(1);
  self waittill("goal");
  self delete();
}

anthem_objectives() {
  set_objective(level.obj_get_to_base, undefined, undefined, undefined, 0);
  set_objective(level.obj_get_to_base, undefined, "done", undefined, 0);
  flag_wait("anthem_grapple_idle_body_started");
  set_objective(level.obj_grapple, getent("grapple_anchor", "targetname"), "target");
  flag_wait("delete_rope_harper");
  wait 2;
  set_objective(level.obj_grapple, getent("grapple_anchor", "targetname"), "remove");
  set_objective(level.obj_grapple, undefined, "done");
  set_objective(level.obj_grapple, undefined, "delete");
  flag_wait("spawn_rooftop_guard");
  wait 1;
  set_objective(level.obj_id_menendez, getent("id_melee_guard_ai", "targetname"), "");
  flag_wait_any("id_melee_success_started", "rooftop_clear");
  set_objective(level.obj_id_menendez, getent("id_melee_guard_ai", "targetname"), "remove");
  flag_wait("anthem_facial_recognition_complete");
  set_objective(level.obj_id_menendez, undefined, "done");
  wait 1;
  set_objective(level.obj_record_menendez, level.harper, "follow");
  flag_wait("harper_path4_started");
  set_objective(level.obj_record_menendez, level.harper, "remove");
  set_objective(level.obj_record_menendez, undefined, "done", undefined, 0);
  set_objective(level.obj_reacquire, level.harper, "follow");
  flag_wait("rooftop_meeting_convoy_start");
  set_objective(level.obj_reacquire, level.harper, "remove");
  set_objective(level.obj_reacquire, getstruct("railyard_melee_objective_marker", "targetname"), "breadcrumb");
  flag_wait("trigger_jump_down");
  set_objective(level.obj_reacquire, getstruct("railyard_melee_objective_marker", "targetname"), "remove");
  flag_wait("trainyard_melee_finished");
  set_objective(level.obj_reacquire, level.harper, "follow");
  flag_wait("trainyard_melee_harper_door_idle_started");
  set_objective(level.obj_reacquire, level.harper, "remove");
  set_objective(level.obj_reacquire, getstruct("railyard_drone_meeting_obj_marker", "targetname"), "breadcrumb");
  flag_wait("trainyard_drone_meeting_started");
  set_objective(level.obj_reacquire, getstruct("railyard_drone_meeting_obj_marker", "targetname"), "remove");
  set_objective(level.obj_reacquire, undefined, "done");
  set_objective(level.obj_reacquire, undefined, "delete");
  set_objective(level.obj_record_menendez, undefined, "delete");
  set_objective(level.obj_record_menendez_again);
  flag_wait("trainyard_drone_meeting_done");
  set_objective(level.obj_record_menendez_again, undefined, "done", undefined, 0);
  set_objective(level.obj_reacquire_again, level.harper, "follow");
  flag_wait("trainyard_drone_meeting_harper_exit_done");
  set_objective(level.obj_reacquire_again, level.harper, "remove");
  set_objective(level.obj_reacquire_again, getstruct("railyard_millibar_meeting_obj_marker", "targetname"), "breadcrumb");
  flag_wait("railyard_player_millibar_start");
  set_objective(level.obj_reacquire_again, getstruct("railyard_millibar_meeting_obj_marker", "targetname"), "remove");
  set_objective(level.obj_reacquire_again, undefined, "done");
  set_objective(level.obj_reacquire_again, undefined, "delete");
  flag_wait("trainyard_millibar_grenades_warp_done");
  set_objective(level.obj_salazar, level.harper, "follow");
  flag_wait("spawn_spotlight_drone");
  set_objective(level.obj_salazar, level.harper, "remove");
  set_objective(level.obj_salazar, undefined, "done");
  set_objective(level.obj_salazar, undefined, "delete");
  wait 2;
  set_objective(level.obj_clear_railyard);
  flag_wait("pakistan_is_raining");
  set_objective(level.obj_clear_railyard, undefined, "done");
  set_objective(level.obj_clear_railyard, undefined, "delete");
  wait 3;
  set_objective(level.obj_escape, getstruct("soct_mount_objective_marker", "targetname"), "enter");
  flag_wait("mount_soct_player_started");
  set_objective(level.obj_escape, undefined, "done");
}

argus_enable() {
  wait 3;
  a_enemies = getaiarray("axis");
  a_enemies = array_exclude(a_enemies, level.militia_leader);
  clientnotify("enable_argus");

  foreach(ai_enemy in a_enemies) {
    if(isDefined(ai_enemy.script_noteworthy) && ai_enemy.script_noteworthy == "photo_1")
      addargus(ai_enemy, "soldier1");
    else if(isDefined(ai_enemy.script_noteworthy) && ai_enemy.script_noteworthy == "photo_2")
      addargus(ai_enemy, "soldier2");
    else if(isDefined(ai_enemy.script_noteworthy) && ai_enemy.script_noteworthy == "photo_3")
      addargus(ai_enemy, "soldier3");
    else if(isDefined(ai_enemy.script_noteworthy) && ai_enemy.script_noteworthy == "photo_4")
      addargus(ai_enemy, "soldier4");
    else if(isDefined(ai_enemy.script_noteworthy) && ai_enemy.script_noteworthy == "photo_5")
      addargus(ai_enemy, "soldier5");
    else if(isDefined(ai_enemy.script_noteworthy) && ai_enemy.script_noteworthy == "photo_6")
      addargus(ai_enemy, "soldier6");
    else
      addargus(ai_enemy, "soldier6");

    luinotifyevent(&"hud_pak_add_poi", 1, ai_enemy getentitynumber());
  }

  addargus(level.militia_leader, "militia_leader");
  luinotifyevent(&"hud_pak_add_poi", 1, level.militia_leader getentitynumber());
}

argus_disable() {
  clientnotify("disable_argus");
}

setup_doors() {
  foreach(e_door in getentarray("animated_door", "script_noteworthy"))
  getent(e_door.target, "targetname") linkto(e_door, "door_hinge_jnt");

  run_scene_first_frame("rooftop_entrance_open");
  run_scene_first_frame("tower_chair");
  run_scene_first_frame("rooftop_exit_open");
  run_scene_first_frame("trainyard_melee_door_door_open");
  e_door = getent("drone_entrance", "targetname");
  e_door notsolid();
  e_door_clip = getent("drone_entrance_collision", "targetname");
  e_door_clip notsolid();
}

setup_lights() {
  foreach(m_spotlight in getentarray("modern_spotlights", "targetname"))
  playfxontag(getfx("courtyard_spotlight"), m_spotlight, "tag_light");
}

wall_grapple_event() {
  level.b_grapple_success = 0;
  has_player_fired_grapple_device = 0;
  level thread screen_fade_in();
  level.player setwaterdrops(25);
  level thread pregrappel_drone_flyby();
  level thread harper_grappel();
  level thread rooftop_light();
  setmusicstate("PAK_2_INTRO");
  run_scene("anthem_grapple_player_setup");
  level.player setwaterdrops(0);
  level thread vo_grapple();
  level thread grapple_hud_text();
  level thread run_scene("anthem_grapple_idle_body");
  flag_wait("anthem_grapple_idle_body_started");
  level.player setwaterdrops(80);
  level.player giveweapon("grenade_grapple_pakistan_sp");
  level.player disableweaponfire();
  level.player showviewmodel();
  level.player enableweapons();
  level.player enableoffhandweapons();

  while(level.player fragbuttonpressed())
    wait 0.05;

  screen_message_create(&"PAKISTAN_SHARED_GRENADE_GRAPPLE");
  e_grapple_target = getent("grapple_target", "targetname");

  while(!level.player fragbuttonpressed())
    wait 0.05;

  level.player thread monitor_grapple_grenade_ammo();
  screen_message_delete();
  level.player thread check_grapple_target();

  while(true) {
    level.player waittill("grenade_fire", e_grenade);
    remove_visor_text("PAKISTAN_SHARED_GRAPPLE_SCAN");
    remove_visor_text("PAKISTAN_SHARED_GRAPPLE_LOCATED");
    remove_visor_text("PAKISTAN_SHARED_GRAPPLE_STANDBY");
    level.player playrumbleonentity("pistol_fire");

    if(getdvarint(#"cg_BallisticArc_ForceHitIndicator")) {
      break;
    }
  }

  level.player takeweapon("grenade_grapple_pakistan_sp");
  level.harper playsound("evt_grapple_fire_harper");
  level thread spawn_rooftop_melee();
  level.player thread rumble_player();
  grapple_rope(e_grenade);
  level thread wall_climb_drone();
  level thread init_courtyard_ai();
  flag_set("anthem_grapple_complete");
  level.player disableweapons();
  level.player hideviewmodel();
  level.player setlowready(1);
  level thread grapple_drone_flyby();
  run_scene("anthem_player_grapple");
  level.player setwaterdrops(0);
  remove_visor_text("PAKISTAN_SHARED_GRAPPLE_SCAN");
  remove_visor_text("PAKISTAN_SHARED_GRAPPLE_LOCATED");
  remove_visor_text("PAKISTAN_SHARED_GRAPPLE_STANDBY");
  level.player notify("grapple_done");
  level thread take_train_car();
  level thread run_courtyard_scenes();
  level thread vo_pa_announcement();
  t_dmg = getent("trigger_dmg_start", "targetname");
  t_dmg trigger_on();
  level.player thread waterdrops_on_visor();
  wait 0.05;
  level.player setlowready(1);
  level thread drone_punishment();
  level thread courtyard_ai_behavior();
}

waterdrops_on_visor() {
  flag_wait("id_melee_done");
  self setwaterdrops(25);
  flag_wait("harper_control_room");
  self setwaterdrops(0);
  flag_wait("control_room_exit");
  self setwaterdrops(25);
  flag_wait("railyard_drone_meeting_room_entered");
  self setwaterdrops(0);
}

grapple_hud_text() {
  add_visor_text("PAKISTAN_SHARED_GRAPPLE_INIT", 0);
  maps\_glasses::perform_visor_wipe();
  wait 2;
  remove_visor_text("PAKISTAN_SHARED_GRAPPLE_INIT");
  add_visor_text("PAKISTAN_SHARED_GRAPPLE_SEARCH_ACTIVATED", 0);
  wait 2;
  remove_visor_text("PAKISTAN_SHARED_GRAPPLE_SEARCH_ACTIVATED");
  add_visor_text("PAKISTAN_SHARED_GRAPPLE_STANDBY", 0);
}

check_grapple_target() {
  level endon("anthem_player_grapple_started");
  e_grapple_target = getent("grapple_anchor", "targetname");
  n_angle = 8;

  while(true) {
    add_visor_text("PAKISTAN_SHARED_GRAPPLE_STANDBY", 0);

    while(!self fragbuttonpressed())
      wait 0.05;

    remove_visor_text("PAKISTAN_SHARED_GRAPPLE_STANDBY");

    if(self fragbuttonpressed()) {
      if(self get_dot_from_eye(e_grapple_target.origin) > cos(n_angle) && !level.b_grapple_success) {
        rpc("clientscripts/pakistan_2", "SetGrappelTarget", 1);
        remove_visor_text("PAKISTAN_SHARED_GRAPPLE_SCAN");
        add_visor_text("PAKISTAN_SHARED_GRAPPLE_LOCATED", 0);
        level.b_grapple_success = 1;
      } else if(self get_dot_from_eye(e_grapple_target.origin) < cos(n_angle) && level.b_grapple_success) {
        rpc("clientscripts/pakistan_2", "SetGrappelTarget", 0);
        remove_visor_text("PAKISTAN_SHARED_GRAPPLE_LOCATED");
        add_visor_text("PAKISTAN_SHARED_GRAPPLE_SCAN", 0);
        level.b_grapple_success = 0;
      }
    }

    wait 0.05;
  }
}

harper_grappel() {
  exploder(501);
  run_scene("anthem_grapple_setup");
  level thread run_scene("anthem_grapple_idle");
  flag_wait("anthem_player_grapple_started");
  remove_visor_text("PAKISTAN_SHARED_GRAPPLE_STANDBY");
  level.harper thread harper_anim_blends();
  run_scene("anthem_grapple");
  level thread courtyard_ambience();
  level thread harper_rooftop_melee();
  run_scene("id_melee_approach_harper");

  if(!flag("id_melee_success_started"))
    level thread run_scene("id_melee_approach_idle_harper");
}

harper_rooftop_melee() {
  flag_wait("id_melee_started");

  if(!flag("id_melee_approach_harper_done"))
    end_scene("id_melee_approach_harper");

  if(flag("id_melee_approach_idle_harper_started"))
    end_scene("id_melee_approach_idle_harper");

  wait 4;
  run_scene("id_melee_success");
  run_scene("confirm_menendez");
  level thread run_scene("confirm_menendez_idle");
}

harper_anim_blends() {
  flag_wait("anthem_grapple_started");
  self anim_set_blend_out_time(0.2);
  self anim_set_blend_in_time(0.2);
  flag_wait("confirm_menendez_exit_started");
  self anim_set_blend_in_time(0.2);
  flag_wait("harper_path1_started");
  self anim_set_blend_out_time(0.2);
  self anim_set_blend_in_time(0.2);
  flag_wait("harper_path2_climb_started");
  self anim_set_blend_out_time(0.2);
  self anim_set_blend_in_time(0.2);
  flag_wait("harper_path4_started");
  self anim_set_blend_out_time(0.2);
  self anim_set_blend_in_time(0.2);
  flag_wait("harper_path4_hide_exit_started");
  self anim_set_blend_out_time(0.2);
  self anim_set_blend_in_time(0.2);
  flag_wait("harper_path4_hide_exit_done");

  if(!flag("jump_down_player_started")) {
    flag_wait("trainyard_melee_harper_cross_bridge_started");
    self anim_set_blend_out_time(0.2);
  }

  flag_wait("jump_down_attack_harper_started");
  self anim_set_blend_out_time(0.2);
}

courtyard_ambience() {
  level thread start_courtyard_ambient_drones();
  wait 12;
  level thread run_scene("courtyard_btr_entrance");
}

grapple_rope(e_grenade) {
  start = level.player getweaponmuzzlepoint();
  forward = level.player getweaponforwarddir();
  end = start + forward * 8000;
  s_grapple_point = getstruct("anthem_grapple_point");
  len = distance(start, s_grapple_point.origin);

  if(len > 400)
    len = 400;

  e_player_body = get_model_or_models_from_scene("anthem_grapple_player_setup", "player_body");
  rope_id = createrope(start, (0, 0, 0), len, e_grenade);
  ropesetparam(rope_id, "width", 0.2);
  e_grenade waittill("death");
  v_player_offset = vectorscale((0, -1, 0), 24.0);
  playsoundatposition("evt_grapple_gun_imp", s_grapple_point.origin);
  level thread grapple_rope_run(rope_id, s_grapple_point.origin);
}

grapple_rope_run(rope_id, grapple_origin) {
  level.player enableinvulnerability();
  e_player_body = get_model_or_models_from_scene("anthem_grapple_player_setup", "player_body");
  len = 400;

  while(!flag("delete_rope_player")) {
    deleterope(rope_id);
    len = distance(e_player_body gettagorigin("tag_weapon1"), grapple_origin);
    rope_id = createrope(grapple_origin, (0, 0, 0), len, e_player_body, "tag_weapon1");
    ropesetparam(rope_id, "width", 0.2);
    wait 0.05;
  }

  flag_wait("delete_rope_player");
  wait 0.3;
  deleterope(rope_id);
  level.player disableinvulnerability();
}

monitor_grapple_grenade_ammo() {
  self endon("grapple_done");

  while(true) {
    if(self getweaponammoclip("grenade_grapple_pakistan_sp") < 1)
      self givemaxammo("grenade_grapple_pakistan_sp");

    wait 0.1;
  }
}

rumble_player() {
  wait 1;
  self playrumblelooponentity("rappel_falling");
  flag_wait("delete_rope_player");
  self stoprumble("rappel_falling");
  stop_exploder(501);
  wait 0.5;
  self playrumbleonentity("shotgun_fire");
}

pregrappel_drone_flyby() {
  s_spawnpt = getstruct("pregrappel_drone_spawnpt");
  vh_osprey = spawn_vehicle_from_targetname("isi_osprey");
  vh_osprey.origin = s_spawnpt.origin;
  vh_osprey.angles = s_spawnpt.angles;
  vh_osprey thread pregrappel_osprey_flyby();
  wait 1;
  v_offset = (0, 0, 0);

  for(i = 0; i < 3; i++) {
    vh_drone = spawn_vehicle_from_targetname("isi_drone");
    vh_drone.origin = s_spawnpt.origin + v_offset;
    vh_drone.angles = s_spawnpt.angles;
    vh_drone thread pregrappel_drone_flyby_logic();
    v_offset = v_offset + (randomintrange(-200, -100), 0, randomintrange(200, 300));
    wait 1;
  }
}

pregrappel_osprey_flyby() {
  self setforcenocull();
  self setneargoalnotifydist(300);
  self setspeed(55, 30, 20);
  self setvehgoalpos(self.origin + (0, -5000, 300), 0);
  self waittill_any("goal", "near_goal");
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

pregrappel_drone_flyby_logic() {
  e_spotlight_target = spawn("script_model", self.origin);
  e_spotlight_target setmodel("tag_origin");
  e_spotlight_target linkto(self, "tag_origin");
  self setforcenocull();
  self set_turret_target(e_spotlight_target, anglestoforward(self.angles) * 800 + vectorscale((0, 0, -1), 500.0), 0);
  wait 0.5;
  self play_fx("drone_spotlight_cheap", self gettagorigin("tag_spotlight"), self gettagangles("tag_spotlight"), "kill_spotlight", 1, "tag_spotlight");
  self setneargoalnotifydist(300);
  self setspeed(55, 30, 20);
  self setvehgoalpos(self.origin + vectorscale((0, -1, 0), 5000.0), 0);
  self waittill_any("goal", "near_goal");
  e_spotlight_target delete();
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

wall_climb_drone() {
  s_spawnpt = getstruct("grapple_drone_spawnpt");
  s_goal1 = getstruct("grapple_drone_goal1");
  s_goal2 = getstruct("grapple_drone_goal2");
  s_goal3 = getstruct("grapple_drone_goal3");
  s_goal4 = getstruct("grapple_drone_goal4");
  wait 4;
  vh_drone = spawn_vehicle_from_targetname("isi_drone");
  vh_drone.origin = s_spawnpt.origin;
  vh_drone.angles = s_spawnpt.angles;
  e_spotlight_target = spawn("script_model", vh_drone.origin + anglestoforward(vh_drone.angles) * 500);
  e_spotlight_target setmodel("tag_origin");
  e_spotlight_target linkto(vh_drone, "tag_origin", vectorscale((0, 0, -1), 500.0));
  vh_drone set_turret_target(e_spotlight_target, anglestoforward(vh_drone.angles) * 800 + vectorscale((0, 0, -1), 500.0), 0);
  vh_drone play_fx("drone_spotlight_cheap", vh_drone gettagorigin("tag_spotlight"), vh_drone gettagangles("tag_spotlight"), "kill_spotlight", 1, "tag_spotlight");
  vh_drone setneargoalnotifydist(300);
  vh_drone setspeed(45, 30, 20);
  vh_drone setvehgoalpos(s_goal1.origin, 0);
  vh_drone waittill_any("goal", "near_goal");
  vh_drone setspeed(25, 20, 10);
  vh_drone setvehgoalpos(s_goal2.origin, 0);
  vh_drone waittill_any("goal", "near_goal");
  vh_drone setvehgoalpos(s_goal3.origin, 0);
  vh_drone waittill_any("goal", "near_goal");
  vh_drone setvehgoalpos(s_goal4.origin, 0);
  vh_drone waittill_any("goal", "near_goal");
  vh_drone.delete_on_death = 1;
  vh_drone notify("death");

  if(!isalive(vh_drone))
    vh_drone delete();
}

grapple_drone_flyby() {
  vh_drone = spawn_vehicle_from_targetname("grapple_flyby_drone");
  e_spotlight_target = getent("grapple_flyby_spotlight_target", "targetname");
  e_salazar_spotlight_start = getent("grapple_salazar_spotlight_target", "targetname");
  vh_drone play_fx("drone_spotlight_cheap", vh_drone gettagorigin("tag_spotlight"), vh_drone gettagangles("tag_spotlight"), "kill_spotlight", 1, "tag_spotlight");
  e_spotlight_target linkto(vh_drone, "tag_origin");
  vh_drone set_turret_target(e_spotlight_target, undefined, 0);
  flag_wait("delete_rope_harper");
  level clientnotify("clck");
  vh_drone thread go_path(getvehiclenode("anthem_drone_flyby_path_enter", "targetname"));
  vh_drone waittill("look_salazar");
  vh_drone setlookatent(e_salazar_spotlight_start);
  vh_drone set_turret_target(e_salazar_spotlight_start, undefined, 0);
  wait 2.0;
  vh_drone clearlookatent();
  vh_drone clear_turret_target(0);
  vh_drone thread go_path(getvehiclenode("grapple_drone_exit", "targetname"));
  level notify("drone_spotlight_swapped");
  vh_drone waittill("delete");
  vh_drone.delete_on_death = 1;
  vh_drone notify("death");

  if(!isalive(vh_drone))
    vh_drone delete();
}

ground_drone_landing() {
  s_spawnpt = getstruct("anthem_drone_landing_end", "targetname");
  vh_drone = spawn_vehicle_from_targetname("anthem_courtyard_drone_ground");
  vh_drone.origin = s_spawnpt.origin;
  vh_drone.angles = s_spawnpt.angles;
  vh_drone setrotorspeed(0);
  vh_drone veh_toggle_tread_fx(0);
  vh_drone vehicle_toggle_sounds(0);
  vh_drone veh_toggle_exhaust_fx(0);
  wait 1;
  vh_drone setrotorspeed(0.8);
  vh_drone veh_toggle_tread_fx(1);
  vh_drone vehicle_toggle_sounds(1);
  vh_drone veh_toggle_exhaust_fx(1);
  flag_wait_any("rooftop_guards_alerted", "id_melee_done");
  wait 1;
  vh_drone thread go_path(getvehiclenode("anthem_drone_landing_start", "targetname"));
  wait 2;
  vh_drone thread drone_searchlight();
  vh_drone waittill("reached_end_node");
  vh_drone.delete_on_death = 1;
  vh_drone notify("death");

  if(!isalive(vh_drone))
    vh_drone delete();
}

vehicles_rollout() {
  flag_wait_any("rooftop_guards_alerted", "id_melee_done");
  flag_wait_or_timeout("anthem_facial_recognition_complete", 10);
  end_scene("courtyard_btr_director");
  level thread btr_entrance_lights();
  flag_wait("lead_gaz_go");
  wait 4;
  level thread spawn_courtyard_runners();
}

drone_searchlight() {
  e_spotlight_target = getent("anthem_ground_drone_spotlight_target", "targetname");
  self play_fx("drone_spotlight_cheap", self gettagorigin("tag_spotlight"), self gettagangles("tag_spotlight"), "spotlight_off", 1, "tag_spotlight");
  self set_turret_target(e_spotlight_target, anglestoforward(self.angles) * 800 + vectorscale((0, 0, -1), 500.0), 0);
  e_spotlight_target linkto(self, "tag_origin");
}

#using_animtree("animated_props");

btr_entrance_lights() {
  vh_btr = get_model_or_models_from_scene("courtyard_btr_entrance", "anthem_cin_btr");
  vh_btr thread headlights_on();
  anim_length = getanimlength( % v_pakistan_5_3_activity_below_btr_gate_entrance_btr);
  wait(anim_length);

  if(isDefined(vh_btr))
    vh_btr delete();
}

headlights_on() {
  self play_fx("fx_vlight_headlight_default", self.origin, self.angles, undefined, 1, "tag_headlight_left", 1);
  self play_fx("fx_vlight_headlight_default", self.origin, self.angles, undefined, 1, "tag_headlight_right", 1);
  self play_fx("fx_vlight_brakelight_default", self.origin, self.angles, undefined, 1, "tag_tail_light_left", 1);
  self play_fx("fx_vlight_brakelight_default", self.origin, self.angles, undefined, 1, "tag_tail_light_right", 1);
}

ambient_drone_start(n_drone) {
  vh_drone = spawn_vehicle_from_targetname("ambient_drone" + n_drone);
  nd_start = getvehiclenode("ambient_drone_start" + n_drone, "targetname");
  vh_drone.origin = nd_start.origin;
  e_spotlight_target = spawn("script_model", vh_drone.origin);
  e_spotlight_target setmodel("tag_origin");
  e_spotlight_target linkto(vh_drone, "tag_origin");
  vh_drone setforcenocull();
  vh_drone set_turret_target(e_spotlight_target, anglestoforward(vh_drone.angles) * 800 + vectorscale((0, 0, -1), 500.0), 0);
  vh_drone play_fx("drone_spotlight_cheap", vh_drone gettagorigin("tag_spotlight"), vh_drone gettagangles("tag_spotlight"), "spotlight_off", 1, "tag_spotlight");
  vh_drone thread go_path(nd_start);
  vh_drone waittill("delete");
  vh_drone.delete_on_death = 1;
  vh_drone notify("death");

  if(!isalive(vh_drone))
    vh_drone delete();

  e_spotlight_target delete();
}

id_menendez_event() {
  level thread ground_drone_landing();
  level thread vehicles_rollout();
  level thread vo_anthem();
  level thread id_melee();
  flag_set("xcam_off");
  flag_wait("spawn_rooftop_guard");
  level thread setup_menendez_and_crew();
  setmusicstate("PAK_ANTHEM");
  flag_wait("surv_ready");
  luinotifyevent(&"hud_pak_surveillance");
  level thread id_think(level.menendez, 60.0, 2.5, 1);
  wait 0.1;
  level thread handle_xcam();
  level thread argus_enable();
  level thread surveillance_zoom_hint();
  level thread waittill_menendez_id();
  level thread vo_nag_id_menendez();
  flag_wait_or_timeout("anthem_facial_recognition_complete", 25);
  level thread drop_down_invulnerability_think();
  level thread menendez_crew_pathing();
  level notify("id_complete");
  level thread argus_disable();

  if(flag("anthem_facial_recognition_complete"))
    level thread autosave_by_name("anthem_id_complete");
}

vo_nag_id_menendez() {
  level endon("anthem_facial_recognition_complete");
  flag_wait("surv_ready");
  wait 6;
  level.harper say_dialog("harp_we_know_he_s_here_so_0", 0);
  wait 7;
  level.harper say_dialog("harp_keep_looking_till_yo_0", 0);
}

surveillance_zoom_hint() {
  wait 2.0;
  level thread screen_message_create(&"PAKISTAN_SHARED_SURV_ZOOM", undefined, undefined, undefined, 5);

  while(!level.player adsbuttonpressed())
    wait 0.05;

  screen_message_delete();
}

setup_menendez_and_crew() {
  level.menendez = init_hero("menendez");
  level.militia_leader = simple_spawn_single("militia_leader");
  ai_bodyguard1 = simple_spawn_single("bodyguard1");
  ai_bodyguard2 = simple_spawn_single("bodyguard2");
  level.menendez gun_remove();
  level.militia_leader gun_remove();
  level.menendez set_ignoreme(1);
  level.menendez set_ignoreall(1);
  level.menendez.disablearrivals = 1;
  level.menendez.disableexits = 1;
  level.menendez.disableturns = 1;
  level.menendez.goalradius = 16;
  level.militia_leader set_ignoreme(1);
  level.militia_leader set_ignoreall(1);
  level.militia_leader.disablearrivals = 1;
  level.militia_leader.disableexits = 1;
  level.militia_leader.disableturns = 1;
  level.militia_leader.goalradius = 16;
  level thread bodyguard_walk_anims();
  level.menendez set_run_anim("menendez_walk");
  level.militia_leader set_run_anim("militia_leader_walk");

  if(level.str_align_menendez == "menendez_align_1") {
    s_pos = getstruct("menendez_startpos_1", "targetname");
    level.menendez forceteleport(s_pos.origin, s_pos.angles);
    level.militia_leader forceteleport(s_pos.origin + vectorscale((-1, 0, 0), 100.0), s_pos.angles);
  } else if(level.str_align_menendez == "menendez_align_2") {
    s_pos = getstruct("menendez_startpos_2", "targetname");
    level.menendez forceteleport(s_pos.origin, s_pos.angles);
    level.militia_leader forceteleport(s_pos.origin + vectorscale((-1, 0, 0), 100.0), s_pos.angles);
  } else {
    s_pos = getstruct("menendez_startpos_3", "targetname");
    level.menendez forceteleport(s_pos.origin, s_pos.angles);
    level.militia_leader forceteleport(s_pos.origin + (-50, -100, 0), s_pos.angles);
  }

  level.menendez setgoalpos(level.menendez.origin);
  level.militia_leader setgoalpos(level.militia_leader.origin);
  level thread run_scene("menendez_idle");
  level thread run_scene("militia_idle");
  flag_wait_any("rooftop_clear", "id_melee_done");
  end_scene("menendez_idle");
  end_scene("militia_idle");
  level thread run_scene("confirm_menendez_crew_idle");
  level thread run_scene("confirm_menendez_militia_idle");
  flag_wait("confirm_menendez_crew_done");
  s_stairs = getstruct("menendez_stairs", "targetname");
  level.menendez.goalradius = 16;
  level.menendez setgoalpos(s_stairs.origin + vectorscale((1, 0, 0), 100.0));
  level.militia_leader.goalradius = 16;
  level.militia_leader setgoalpos(s_stairs.origin + vectorscale((1, -1, 0), 100.0));
  level.menendez thread hide_ai_until_bridgewalk();
  level.militia_leader thread hide_ai_until_bridgewalk();
  flag_wait("show_menendez_bridge");
  s_menendez = getstruct("menendez_bridge", "targetname");
  s_militia_leader = getstruct("militia_leader_bridge", "targetname");
  level.menendez forceteleport(s_menendez.origin, s_menendez.angles);
  level.militia_leader forceteleport(s_militia_leader.origin, s_militia_leader.angles);
}

#using_animtree("generic_human");

bodyguard_walk_anims() {
  level.scr_anim["generic"]["patrol_walk"] = % patrol_bored_patrolwalk;
}

bodyguard_logic() {
  self endon("death");
  self set_ignoreme(1);
  self set_ignoreall(1);
  self.disablearrivals = 1;
  self.disableexits = 1;
  self.disableturns = 1;
  self.goalradius = 16;
  self.animname = "generic";
  self set_run_anim("patrol_walk");
  self setgoalpos(self.origin);
  level waittill("driver_in");
  wait(randomfloatrange(0.5, 1.5));
  self setgoalpos(self.origin + vectorscale((1, 0, 0), 100.0));
  self waittill("goal");
  self setgoalpos(self.origin);
  self.goalradius = 16;
  flag_wait("confirm_menendez_crew_done");
  wait(randomfloatrange(0.5, 1.5));
  self setgoalpos((-18072, 40440, 539.5));
  self waittill("goal");
  self setgoalpos(self.origin);
  flag_wait("anthem_harper_stand");
  self delete();
}

hide_ai_until_bridgewalk() {
  self waittill("goal");
  self hide();
}

take_train_car() {
  level thread ambient_drone_start(1);
  train_cars = getentarray("courtyard_train_cars", "targetname");
  script_car = getent("courtyard_cin_train", "targetname");
  engine = getent("courtyard_train_engine", "targetname");
  engine playsound("evt_anthem_train_hookup");
  engine moveto((-20540, 39160, 515.5), 10, 0, 5);
  engine waittill("movedone");
  script_car linkto(engine);

  for(i = 0; i < train_cars.size; i++)
    train_cars[i] linkto(engine);

  level thread courtyard_btr_logic();
  playsoundatposition("evt_anthem_train_depart", engine.origin);
  engine movey(-6000, 30, 5, 0);
  engine waittill("movedone");
  engine delete();
  script_car delete();

  for(i = 0; i < train_cars.size; i++)
    train_cars[i] delete();
}

spawn_rooftop_melee() {
  flag_wait("spawn_rooftop_guard");
  level thread id_melee_approach("id_melee_approach_guard", "id_melee_approach_idle_guard");
  wait 0.1;
  waittill_ai_group_cleared("group_rooftop_melee");
  flag_set("rooftop_clear");
  level.player setlowready(1);
}

id_melee() {
  level endon("melee_failed");
  level endon("rooftop_guards_alerted");
  level thread id_melee_fail();
  level thread id_melee_bypass_fail();
  level thread id_melee_guards_alerted();
  level thread guard_alerted_by_touch();
  level thread alerted_by_gunfire();
  t_melee = getent("id_melee_trigger", "targetname");

  while(!flag("rooftop_melee")) {
    trigger_wait("id_melee_trigger");
    screen_message_create(&"PAKISTAN_SHARED_MELEE_HINT");

    while(level.player istouching(t_melee)) {
      if(level.player meleebuttonpressed()) {
        screen_message_delete();
        flag_set("rooftop_melee");
        break;
      }

      wait 0.05;
    }

    screen_message_delete();
  }

  level notify("melee_succeeded");
  level thread id_melee_success();
  run_scene("id_melee");
  wait 0.05;
  level.player setlowready(1);
  level thread menendez_surveillance_bypass_fail();
  wait 1.0;
  flag_set("anthem_harper_vo_id");
}

id_melee_success() {
  wait 0.5;
  ai_guard = get_ais_from_scene("id_melee_approach_idle_guard", "id_melee_guard2");
  ai_guard gun_remove();
  level.player playrumbleonentity("damage_heavy");
  wait 1.5;
  level.player playrumbleonentity("grenade_rumble");
  wait 1;
  level.player playrumbleonentity("grenade_rumble");
  wait 1;
  level.player playrumbleonentity("damage_heavy");
}

id_melee_fail() {
  level endon("melee_succeeded");
  trigger_wait("id_melee_fail_trigger");
  flag_set("rooftop_guards_alerted");
  level.player set_ignoreme(0);
}

id_melee_guards_alerted() {
  level endon("melee_succeeded");
  flag_wait("rooftop_guards_alerted");
  level notify("melee_failed");
  screen_message_delete();
  end_scene("id_melee_approach_idle_guard");
  level.player setlowready(0);
  level.player enableweaponfire();
  level.player enableweapons();
  wait 2;

  if(get_ai_group_count("group_rooftop_melee"))
    flag_set("alert_drones");
  else {
    level.player setlowready(1);
    level.player set_ignoreme(1);

    if(!flag("id_melee_approach_harper_done") && flag("id_melee_approach_harper_started"))
      scene_wait("id_melee_approach_harper");

    if(flag("id_melee_approach_idle_harper_started") && !flag("id_melee_approach_idle_harper_done"))
      end_scene("id_melee_approach_idle_harper");

    run_scene("confirm_menendez_reach");
    run_scene("confirm_menendez");
    level thread run_scene("confirm_menendez_idle");
  }
}

id_melee_bypass_fail() {
  level endon("melee_succeeded");
  level endon("confirm_menendez_reach_started");
  trigger_wait("trigger_id_melee_warning");
  level.harper thread say_dialog("harp_you_re_gonna_give_aw_0", 0);
  trigger_wait("trigger_id_melee_bypass");
  level notify("melee_failed");
  end_scene("id_melee_approach_idle_harper");
  end_scene("id_melee_approach_idle_guard");
  flag_set("alert_drones");
}

guard_alerted_by_touch() {
  level endon("melee_succeeded");
  level endon("rooftop_guards_alerted");
  level endon("player_detected");
  flag_wait("id_melee_approach_idle_guard_started");
  ai_guard = get_ais_from_scene("id_melee_approach_idle_guard", "id_melee_guard");

  while(true) {
    if(isDefined(ai_guard) && isalive(ai_guard)) {
      if(level.player.origin[0] <= ai_guard.origin[0] + 35) {
        wait 1;

        if(level.player.origin[0] <= ai_guard.origin[0] + 35)
          flag_set("rooftop_guards_alerted");
      }
    }

    wait 0.1;
  }
}

alerted_by_gunfire() {
  level endon("melee_succeeded");
  level endon("player_detected");

  while(true) {
    level.player waittill_any("weapon_fired", "grenade_fire", "grenade_launcher_fire");

    if(level.player isfiring() && !issubstr(level.player getcurrentweapon(), "silencer"))
      flag_set("alert_drones");
  }
}

id_melee_approach(str_anim, str_idle) {
  run_scene(str_anim);

  if(isalive(getent("id_melee_guard_ai", "targetname")))
    run_scene(str_idle);
}

spawn_courtyard_runners() {
  simple_spawn_single("anthem_courtyard_runner1");
  wait 0.8;
  simple_spawn_single("anthem_courtyard_runner1");

  for(i = 0; i < 3; i++) {
    simple_spawn_single("anthem_courtyard_runner2");
    wait(randomfloatrange(0.6, 1.3));
  }
}

confirm_menendez_gaz_driveaway() {
  veh_gaz = getent("confirm_menendez_gaz", "targetname");
  sp_guy = getent("confirm_menendez_soldiers", "targetname");
  level thread gaz_tigers_go();
  guy2 = sp_guy spawn_ai(1);
  guy2.animname = "generic";
  guy2 set_run_anim("combat_jog");
  guy2 gaz_load_and_delete(veh_gaz, "tag_driver");
  level notify("driver_in");
  wait 0.5;
  veh_gaz playsound("veh_gaz_turnon_0");
  veh_gaz headlights_on();
  wait 1;
  veh_gaz notify("gaz_go");
  veh_gaz thread go_path(getvehiclenode("confirm_menendez_gaz_path", "targetname"));
  flag_set("lead_gaz_go");
  veh_gaz waittill("reached_end_node");
  veh_gaz.delete_on_death = 1;
  veh_gaz notify("death");

  if(!isalive(veh_gaz))
    veh_gaz delete();
}

gaz_tigers_go() {
  wait 6;
  vh_gaz1 = getent("courtyard_gaz_1", "targetname");
  vh_gaz2 = getent("courtyard_gaz_2", "targetname");
  ai_guy0 = getent("anthem_courtyard_soldiers0_ai", "targetname");
  ai_guy1 = getent("anthem_courtyard_soldiers1_ai", "targetname");
  ai_guy2 = getent("anthem_courtyard_soldiers2_ai", "targetname");
  ai_guy3 = getent("anthem_courtyard_soldiers3_ai", "targetname");
  ai_guy0.animname = "generic";
  ai_guy0 set_run_anim("combat_jog");
  ai_guy0 thread run_to_vehicle_load(vh_gaz1, 0, "tag_driver");
  wait 0.2;
  ai_guy1.animname = "generic";
  ai_guy1 set_run_anim("combat_jog");
  ai_guy1 thread run_to_vehicle_load(vh_gaz1, 0, "tag_passenger");
  wait 0.3;
  ai_guy2.animname = "generic";
  ai_guy2 set_run_anim("combat_jog");
  ai_guy2 thread run_to_vehicle_load(vh_gaz2, 0, "tag_driver");
  wait 0.1;
  ai_guy3.animname = "generic";
  ai_guy3 set_run_anim("combat_jog");
  ai_guy3 run_to_vehicle_load(vh_gaz2, 0, "tag_passenger");
  wait 2;
  vh_gaz1 playsound("veh_gaz_turnon_1");
  vh_gaz1 headlights_on();
  flag_wait("lead_gaz_go");
  wait 1;
  vh_gaz1 thread go_path(getvehiclenode("gaz1_path", "targetname"));
  vh_gaz2 playsound("veh_gaz_turnon_2");
  vh_gaz2 headlights_on();
  wait 0.5;
  vh_gaz2 thread go_path(getvehiclenode("gaz2_path", "targetname"));
  vh_gaz1 waittill("reached_end_node");
  vh_gaz1.delete_on_death = 1;
  vh_gaz1 notify("death");

  if(!isalive(vh_gaz1))
    vh_gaz1 delete();

  ai_guy0 delete();
  ai_guy1 delete();
  vh_gaz2 waittill("reached_end_node");
  vh_gaz2.delete_on_death = 1;
  vh_gaz2 notify("death");

  if(!isalive(vh_gaz2))
    vh_gaz2 delete();

  ai_guy2 delete();
  ai_guy3 delete();
  flag_wait("confirm_menendez_crew_started");
  level thread start_ambient_ground_vehicles();
}

gaz_load_and_delete(veh_gaz, str_tag) {
  self run_to_vehicle_load(veh_gaz, 0, str_tag);
  self delete();
}

start_ambient_ground_vehicles() {
  level endon("harper_path1_started");

  while(true) {
    nd_start = getvehiclenode("ambient_tiger_startnode" + randomintrange(1, 3), "targetname");
    vh_gaz = spawn_vehicle_from_targetname("isi_tiger");
    vh_gaz thread go_path(nd_start);
    vh_gaz lights_on();
    vh_gaz thread vehicle_delete_at_end_of_path();
    wait(randomintrange(4, 5));
  }
}

vehicle_delete_at_end_of_path() {
  self waittill("reached_end_node");
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

menendez_crew_pathing() {
  end_scene("confirm_menendez_crew_idle");
  end_scene("confirm_menendez_militia_idle");
  run_scene("confirm_menendez_crew");
  flag_wait("show_menendez_bridge");
  level.menendez show();
  level.militia_leader show();
  flag_wait("player_dropdown_bridge");
  level.militia_leader thread queue_dialog("isi3_the_drone_was_taken_0", 3);
  level.militia_leader thread queue_dialog("isi3_we_think_it_was_look_0", 4);
  level thread run_scene("militia_leader_path3");
  level thread run_scene("menendez_path3");
  flag_wait("menendez_path3_done");
  s_menendez_end = getstruct("menendez_bridge_end", "targetname");
  s_militia_leader_end = getstruct("militia_leader_bridge_end", "targetname");
  level.militia_leader setgoalpos(s_militia_leader_end.origin);
  level.militia_leader set_ignoreall(1);
  level.menendez setgoalpos(s_menendez_end.origin);
  level.menendez set_ignoreall(1);
  level.menendez notify("unmark");
  wait 4.0;
  flag_set("anthem_harper_stand");
  wait 4.0;
  level.player setstance("stand");
}

menendez_surveillance_event() {
  level thread rooftop_meeting_scene_setup_think();
  level.harper thread surveillance_harper_pathing();
}

surveillance_mark_menendez() {
  level.menendez play_fx("friendly_marker", level.menendez gettagorigin("J_Head"), undefined, "unmark", 1, "J_Head");
}

dropdown_drone() {
  flag_wait("player_jumpdown_ac");
  level.player playrumbleonentity("damage_light");
  s_spawnpt = getstruct("dropdown_drone_spawnpt");
  s_goal1 = getstruct("dropdown_drone_goal1");
  s_goal2 = getstruct("dropdown_drone_goal2");
  s_goal3 = getstruct("dropdown_drone_goal3");
  s_goal4 = getstruct("dropdown_drone_goal4");
  s_goal5 = getstruct("dropdown_drone_goal5");
  vh_drone = spawn_vehicle_from_targetname("isi_drone");
  vh_drone.origin = s_spawnpt.origin;
  vh_drone.angles = s_spawnpt.angles;
  e_spotlight_target = getent("isi_vtol", "targetname");
  vh_drone set_turret_target(e_spotlight_target, undefined, 0);
  vh_drone setneargoalnotifydist(300);
  vh_drone setspeed(25, 20, 10);
  wait 0.5;
  vh_drone setvehgoalpos(s_goal1.origin, 1);
  vh_drone waittill_any("goal", "near_goal");
  vh_drone play_fx("drone_spotlight_cheap", vh_drone gettagorigin("tag_spotlight"), vh_drone gettagangles("tag_spotlight"), "kill_spotlight", 1, "tag_spotlight");
  vh_drone setspeed(10, 8, 5);
  vh_drone setvehgoalpos(s_goal2.origin, 0);
  vh_drone waittill_any("goal", "near_goal");
  vh_drone setvehgoalpos(s_goal3.origin, 0);
  vh_drone waittill_any("goal", "near_goal");
  vh_drone setvehgoalpos(s_goal4.origin, 0);
  vh_drone waittill_any("goal", "near_goal");
  vh_drone clear_turret_target(0);
  vh_drone setspeed(45, 15, 10);
  vh_drone setvehgoalpos(s_goal5.origin, 0);
  vh_drone waittill_any("goal", "near_goal");
  vh_drone.delete_on_death = 1;
  vh_drone notify("death");

  if(!isalive(vh_drone))
    vh_drone delete();
}

drop_down_invulnerability_think() {
  trigger_wait("drop_invuln_trigger");
  level.player enableinvulnerability();
  level.player playrumbleonentity("damage_light");
  level thread run_scene("rooftop_meeting_idle");
  level thread run_scene("rooftop_meeting_talkers_idle");
  level thread run_scene("rooftop_meeting_soldiers2_idle");
  level thread run_scene("rooftop_meeting_soldiers3_idle");
  level thread run_scene("rooftop_meeting_soldiers45_idle");
  level thread run_scene("rooftop_meeting_soldiers67_idle");
  wait 0.5;
  level.player disableinvulnerability();
}

guard_tower_melee() {
  level thread guard_tower_melee_fail();
  level thread run_scene("tower_melee_guard_idle");
}

guard_tower_melee_fail() {
  level endon("tower_melee_complete");
  level endon("harper_rooftop_door_close_started");
  trigger_wait("tower_melee_fail_trigger");
  level notify("melee_failed");
  flag_set("alert_drones");
}

menendez_surveillance_bypass_fail() {
  level endon("anthem_harper_vo_surveillance");
  trigger_wait("trigger_id_melee_bypass");
  level.harper thread say_dialog("harp_you_re_gonna_give_aw_0", 0);
  trigger_wait("trigger_surveillance_bypass");
  level notify("melee_failed");
  flag_set("alert_drones");
}

fake_spotlight_movement() {
  e_spotlight = getent("fake_spotlight", "targetname");
  e_spotlight setforcenocull();
  e_target = spawn("script_origin", getent("fake_search_path1", "targetname").origin);
  e_spotlight play_fx("big_spotlight_cheap", e_spotlight gettagorigin("tag_flash"), e_spotlight gettagangles("tag_flash"), "kill_spotlight", 1, "tag_flash");
  e_spotlight thread spotlight_search_path(getent("fake_search_path1", "targetname"), 512, 0, 0, e_target);
}

surveillance_harper_pathing() {
  level endon("player_detected");
  trigger_wait("menendez_at_stairs", "targetname", level.menendez);
  level thread vo_rooftop();
  flag_set("anthem_harper_vo_surveillance");
  level thread dropdown_drone();
  flag_wait("confirm_menendez_exit_done");
  level.harper change_movemode("cqb_run");
  run_scene("harper_path1");
  flag_set("anthem_harper_vo_interference");
  run_scene("harper_path2");
  level thread run_scene("harper_path2_idle");
  flag_wait("player_dropdown_bridge");
  run_scene("harper_path2_crawl");
  level thread run_scene("harper_path2_prone");
  flag_wait("anthem_harper_stand");
  wait 1;
  level thread guard_tower_melee();
  run_scene("harper_path2_climb");
  level thread close_automatic_door();
  level thread run_scene("rooftop_entrance_open");
  level thread run_scene("tower_chair");
  level.harper anim_set_blend_out_time(1);
  level.harper change_movemode("cqb_walk");
  run_scene("harper_path3");
  level.harper anim_set_blend_in_time(1);
  level thread run_scene("harper_rooftop_door_idle");
  flag_wait("harper_control_room");
  level.player setmovespeedscale(0.2);
  level.harper change_movemode("cqb_run");
  level.harper attach("t6_wpn_knife_base_prop", "tag_weapon_left");
  run_scene("harper_rooftop_door_close");
  level.player setmovespeedscale(1);
  level.harper detach("t6_wpn_knife_base_prop", "tag_weapon_left");
  flag_set("tower_melee_complete");
  level thread run_scene("harper_path3_idle");
}

close_automatic_door() {
  e_clip = getent("guard_entrance_clip", "targetname");
  e_clip trigger_off();
  trigger_wait("trigger_control_door");
  e_clip trigger_on();
  level thread run_scene("rooftop_entrance_close");
}

surveillance_spotlight_movement() {
  level endon("player_detected");
  e_spotlight = getent("courtyard_spotlight", "targetname");
  e_spotlight.spotlight_target = getent("spotlight_target_rooftop", "targetname");
  e_spotlight setforcenocull();
  e_spotlight thread spotlight_on_player();
  e_spotlight thread spotlight_done();
  e_spotlight thread spotlight_capture_player();
  e_spotlight set_turret_target(e_spotlight.spotlight_target, undefined, 0);
  wait 0.1;
  e_spotlight play_fx("big_spotlight_cheap", e_spotlight gettagorigin("tag_flash"), e_spotlight gettagangles("tag_flash"), "kill_spotlight", 1, "tag_flash");

  while(!flag("delete_rope_player")) {
    e_spotlight.spotlight_target movex(-800, 5);
    e_spotlight.spotlight_target waittill("movedone");
    e_spotlight.spotlight_target movex(800, 5);
    e_spotlight.spotlight_target waittill("movedone");
  }

  e_spotlight notify("kill_spotlight");
  e_spotlight play_fx("big_spotlight_targeting", e_spotlight gettagorigin("tag_flash"), e_spotlight gettagangles("tag_flash"), "kill_spotlight", 1, "tag_flash");
  e_spotlight play_fx("spotlight_lens_flare", e_spotlight gettagorigin("tag_flash"), e_spotlight gettagangles("tag_flash"), "kill_spotlight", 1, "tag_flash");
  e_spotlight.spotlight_target moveto((-17990, 40751, 960), 4);
  e_spotlight.spotlight_target waittill("movedone");
  flag_wait("spawn_rooftop_guard");
  wait 3;
  s_target1 = getstruct("spotlight_blocker1", "targetname");
  s_target2 = getstruct("spotlight_blocker2", "targetname");
  e_spotlight.spotlight_target moveto(s_target1.origin, 5);
  e_spotlight.spotlight_target waittill("movedone");
  e_spotlight.spotlight_target thread rooftop_blocker_logic();

  while(!flag("anthem_harper_vo_surveillance")) {
    e_spotlight.spotlight_target moveto(s_target2.origin, 5);
    e_spotlight.spotlight_target waittill("movedone");

    if(flag("anthem_harper_vo_surveillance")) {
      break;
    }

    wait 0.5;
    e_spotlight.spotlight_target moveto(s_target1.origin, 5);
    e_spotlight.spotlight_target waittill("movedone");

    if(flag("anthem_harper_vo_surveillance")) {
      break;
    }

    wait 0.5;
  }

  flag_set("searchlight_focus_off");
  getent("spotlight_jump_down_wait", "targetname").target = undefined;
  e_spotlight notify("stop_searching");
  e_rooftop_target = getent("surveillance_search_path2", "targetname");
  e_spotlight.spotlight_target moveto(e_rooftop_target.origin, 3);
  e_spotlight.spotlight_target waittill("movedone");
  e_spotlight clear_turret_target(0);
  e_spotlight set_turret_target(e_rooftop_target, undefined, 0);
  e_rooftop_target thread rooftop_spotlight_target_move();
  flag_wait("player_dropdown_bridge");
  wait 3;
  e_rooftop_target = getent("surveillance_search_path3", "targetname");
  e_spotlight set_turret_target(level.player, vectorscale((0, 0, 1), 100.0), 0);
  e_spotlight waittill("turret_on_target");
  level.player thread surveillance_prone_hint();
  wait 4;
  e_spotlight thread spotlight_dodge_fail_think();
  e_spotlight set_turret_target(e_rooftop_target, undefined, 0);
  e_rooftop_target thread spotlight_move_away();
  v_lightpos1 = e_rooftop_target.origin;
  v_lightpos2 = getent(e_rooftop_target.target, "targetname").origin;

  while(!flag("anthem_harper_stand")) {
    e_rooftop_target moveto(v_lightpos2, 6);
    e_rooftop_target waittill("movedone");
    e_rooftop_target moveto(v_lightpos1, 6);
    e_rooftop_target waittill("movedone");
  }

  flag_set("searchlight_focus_off");
  e_spotlight notify("kill_spotlight");
  e_spotlight play_fx("big_spotlight_cheap", e_spotlight gettagorigin("tag_flash"), e_spotlight gettagangles("tag_flash"), "kill_spotlight", 1, "tag_flash");
  e_spotlight notify("stop_spotlight_flare");
}

spotlight_capture_player() {
  level endon("detection_complete");
  flag_wait("player_detected");
  wait 0.2;
  self set_turret_target(level.player, undefined, 0);
}

rooftop_blocker_logic() {
  level endon("confirm_menendez_exit_started");
  level endon("player_detected");

  while(true) {
    if(level.player.origin[1] <= self.origin[1] + 50 && level.player.origin[0] >= self.origin[0] - 300)
      flag_set("alert_drones");

    wait 0.1;
  }
}

spotlight_on_player() {
  level endon("trainyard_melee_finished");
  self set_turret_target(level.player, undefined, 0);
}

spotlight_detection() {
  self endon("death");
  self endon("stop_spotlight_flare");
  level.b_flare = 0;

  while(true) {
    v_spotlight_origin = self gettagorigin("tag_flash");
    v_spotlight_angles = self gettagangles("tag_flash");
    v_player_trace_origin = level.player get_eye();
    v_to_player = vectornormalize(v_player_trace_origin - v_spotlight_origin);
    v_forward = anglestoforward(v_spotlight_angles);
    n_dot = vectordot(v_forward, v_to_player);
    n_sight_trace = level.player sightconetrace(v_spotlight_origin, self, v_forward, 10);
    b_can_see = n_sight_trace > 0.667;

    if(b_can_see && n_dot > 0.95 && !level.b_flare) {
      self play_fx("spotlight_lens_flare", undefined, undefined, "lens_flare_off", 1, "tag_flash");
      level.b_flare = 1;
    } else if(n_dot < 0.95 && level.b_flare) {
      self notify("lens_flare_off");
      level.b_flare = 0;
    }

    wait 0.05;
  }
}

surveillance_prone_hint() {
  if(!level.console && !self gamepadusedlast())
    screen_message_create(&"PAKISTAN_SHARED_HINT_PRONE_KEYBOARD");
  else
    screen_message_create(&"PAKISTAN_SHARED_HINT_PRONE");

  if(self getstance() != "prone")
    level.harper thread say_dialog("harp_get_down_man_0", 0.5);

  level thread vo_prone_bridge();

  while(self getstance() != "prone")
    wait 0.1;

  screen_message_delete();
}

spotlight_done() {
  flag_wait("anthem_harper_stand");
  self notify("stop_spotlight_fail");
}

rooftop_spotlight_target_move() {
  e_spotlight = getent("courtyard_spotlight", "targetname");
  self thread detect_player_on_rooftop();
  self movex(-200, 2);
  self waittill("movedone");

  while(!flag("spotlight_jump_down_enter")) {
    self movex(700, 5);
    self waittill("movedone");
    self movex(-700, 5);
    self waittill("movedone");
  }

  self movex(-1500, 10);

  while(self.origin[0] > -17700)
    wait 0.05;

  flag_set("searchlight_focus_off");
}

detect_player_on_rooftop() {
  level endon("harper_path2_started");

  while(true) {
    if(distance2dsquared(self.origin, level.player.origin) < 90000)
      flag_set("alert_drones");

    wait 0.5;
  }
}

focus_rooftop_guard(e_target) {
  e_target_fx = spawn("script_model", e_target.origin);
  e_target_fx setmodel("tag_origin");
  e_target_fx.direction = anglestoforward(self gettagangles("tag_flash")) * -1;
  e_target_fx.angles = vectortoangles(e_target_fx.direction);
  e_target_fx play_fx("spotlight_target", e_target_fx.origin, e_target_fx.angles, "stop_focus", 1, "tag_origin", 1);

  while(true) {
    e_target_fx.direction = anglestoforward(self gettagangles("tag_flash")) * -1;
    e_target_fx.angles = vectortoangles(e_target_fx.direction);
    e_target_fx.origin = e_target.origin;

    if(flag("searchlight_focus_off")) {
      e_target_fx notify("e_target_fx");
      e_target_fx delete();
      flag_clear("searchlight_focus_off");
      break;
    }

    wait 0.05;
  }
}

spotlight_move_away() {
  level endon("player_dropdown_scaffold");
  level endon("player_detected");
  flag_wait("anthem_harper_stand");
  self movey(1200, 7);
  flag_wait("harper_rooftop_door_close_done");
  self moveto(getstruct("searchlight_control_tower", "targetname").origin, 3);
  self waittill("movedone");
  level thread monitor_control_tower_fail();

  while(true) {
    self moveto(getstruct("searchlight_control_tower2", "targetname").origin, 3);
    self waittill("movedone");
    self moveto(getstruct("searchlight_control_tower", "targetname").origin, 3);
    self waittill("movedone");
  }
}

monitor_control_tower_fail() {
  level endon("player_dropdown_scaffold");

  while(true) {
    trigger_wait("trigger_outside_control");
    level.harper say_dialog("harp_you_re_gonna_give_aw_0", 0.5);
    wait 4;

    if(level.player istouching(getent("trigger_outside_control", "targetname"))) {
      flag_set("alert_drones");
      break;
    }
  }
}

spotlight_dodge_fail_think() {
  self endon("stop_spotlight_fail");
  wait 3;

  while(true) {
    e_spotlight_prone_trigger = getent("spotlight_prone_trigger", "targetname");

    if(level.player istouching(e_spotlight_prone_trigger) && level.player getstance() != "prone") {
      self set_turret_target(level.player, undefined, 0);
      flag_set("alert_drones");
      screen_message_delete();
      self notify("stop_spotlight_fail");
    }

    wait 0.5;
  }
}

rooftop_meeting_scene_setup_think() {
  trigger_wait("tower_melee_prompt_trigger");

  foreach(ai_soldier in getentarray("anthem_helipad_soldiers_ai", "targetname"))
  ai_soldier set_ignoreall(1);
}

detection_fail_think() {
  level endon("courtyard_cleared");
  flag_wait("alert_drones");
  wait 5.0;
  getaiarray("axis")[0] magicgrenade(level.player.origin + vectorscale((0, 0, 1), 128.0), level.player.origin, 0.25);
}

courtyard_sounds() {
  motor_pool = spawn("script_origin", (-20149, 39202, 1230));
  flag_wait("player_detected");
  motor_pool playloopsound("evt_fail_alarm");
}

run_courtyard_scenes() {
  level.player setclientdvars("cg_drawfriendlynames", 0);
  ai_guy1 = simple_spawn_single("courtyard_activity_guy");
  ai_guy1.animname = "crates_guy_1";
  ai_guy2 = simple_spawn_single("courtyard_activity_guy");
  ai_guy2.animname = "crates_guy_2";
  ai_guy3 = simple_spawn_single("courtyard_activity_guy");
  ai_guy3.animname = "crates_guy_3";
  ai_guy4 = simple_spawn_single("courtyard_activity_guy");
  ai_guy4.animname = "crates_guy_4";
  level thread run_scene("courtyard_crates_1");
  level thread run_scene("courtyard_crates_2");
  level thread run_scene("storage_room_1");
  level thread run_scene("storage_room_2");
  level thread run_scene("tower_room");
  flag_wait("player_dropdown_bridge");
  delete_scene_all("courtyard_crates_1", 1);
  delete_scene_all("courtyard_crates_2", 1);
  delete_scene_all("storage_room_1", 1);
  delete_scene_all("storage_room_2", 1);
  delete_scene_all("tower_room", 1);
  level.player setclientdvars("cg_drawfriendlynames", 1);
}

handle_xcam() {
  level endon("player_detected");
  turn_on_xcam();
  flag_wait("anthem_harper_vo_surveillance");
  turn_off_xcam();
  stop_surveillance();
  trigger_wait("anthem_menendez_continue_trigger1");
  turn_on_xcam();
  level thread surveillance_think(level.menendez);
  flag_wait("anthem_harper_stand");
  wait 3;
  turn_off_xcam();
  stop_surveillance();
  flag_wait("tower_melee_complete");
  turn_on_xcam();
  level thread surveillance_think(level.menendez);
  flag_wait("meeting_over");
  wait 11;
  turn_off_xcam();
  stop_surveillance();
  flag_wait("railyard_drone_meeting_room_entered");
  wait 1;
  turn_on_xcam();
  level thread surveillance_think(level.menendez);
  flag_wait("train_arrived");
  stop_surveillance();
  turn_off_xcam();
}

handle_surveillance_toggle() {
  flag_set("xcam_off");
  screen_message_create(&"PAKISTAN_SHARED_SURV_ACTIVATE");

  while(!level.player actionslotonebuttonpressed())
    wait 0.05;

  screen_message_delete();
  turn_on_xcam();
  luinotifyevent(&"hud_pak_surveillance");
  level thread id_think(level.menendez, 60.0, 2.5, 1);
  wait 0.1;
  level thread argus_enable();
  luinotifyevent(&"hud_pak_add_poi", 2, level.menendez getentitynumber(), 1);
  flag_set("id_ready");
  wait 1;
  flag_wait("anthem_harper_vo_surveillance");
  wait 0.5;

  if(!flag("xcam_off")) {
    screen_message_create(&"PAKISTAN_SHARED_SURV_TOGGLE");

    while(!flag("xcam_off"))
      wait 0.05;

    screen_message_delete();
  }
}

waittill_menendez_id() {
  flag_wait("anthem_facial_recognition_complete");
  level clientnotify("surv_ON");
  level thread surveillance_think(level.menendez);
  level.player queue_dialog("sect_id_confirmed_that_0", 1);
  level thread vo_scanner_nag();
}

vo_grapple() {
  level.player thread say_dialog("sect_secure_ropes_0");
  scene_wait("anthem_player_grapple");
  level.harper thread say_dialog("harp_take_the_one_on_the_0", 1);
}

vo_pa_announcement() {
  e_pa_vo = getent("fake_pa_vo", "targetname");
  e_pa_vo say_dialog("pa_attention_attentio_0", 0, 1);
  e_pa_vo say_dialog("pa_this_is_a_level_4_se_0", 0.5, 1);
  e_pa_vo say_dialog("pa_patrols_detected_a_b_0", 1, 1);
  e_pa_vo say_dialog("pa_possible_infiltratio_0", 1, 1);
  e_pa_vo say_dialog("pa_hunter_team_sweep_of_0", 1, 1);
  e_pa_vo say_dialog("pa_all_units_are_advise_0", 1, 1);
  e_pa_vo say_dialog("pa_report_any_suspiciou_0", 1.5, 1);
  e_pa_vo delete();
}

vo_rooftop() {
  flag_wait("anthem_harper_vo_surveillance");

  if(flag("anthem_facial_recognition_complete")) {
    level.player thread say_dialog("sect_they_re_moving_out_o_0", 1);
    level.player thread say_dialog("sect_can_t_get_a_clear_si_0", 1.5);
    wait 2;
    level thread run_scene("confirm_menendez_exit");
  } else
    mission_fail(&"PAKISTAN_SHARED_FAIL_ID");

  flag_wait("player_jumpdown_ac");
  level.harper queue_dialog("harp_stay_out_of_the_spot_0", 1);
}

vo_anthem() {
  level endon("player_detected");
  flag_wait("player_dropdown_bridge");
  level.harper queue_dialog("harp_they_re_talking_abou_0", 1);
  level.player queue_dialog("sect_dammit_they_re_mo_0", 1, "anthem_harper_stand");
  level.harper queue_dialog("harp_let_s_go_0", 1);
}

vo_prone_bridge() {
  level endon("player_detected");
  level endon("anthem_harper_stand");
  level.harper say_dialog("harp_here_they_come_bet_0", 3);
  wait 1;

  if(level.player getstance() != "prone")
    level.harper say_dialog("harp_you_re_gonna_give_aw_0", 0.5);
}

vo_scanner_nag() {
  level endon("player_detected");
  wait 3;

  if(level.str_hud_current_state != "recording")
    level.harper queue_dialog("harp_keep_the_scanner_on_0", 1);

  wait 3;

  if(level.str_hud_current_state != "recording")
    level.harper queue_dialog("harp_come_on_section_s_0", 0.5);
}

turn_on_xcam() {
  level.player clearclientflag(7);
  level.player giveweapon("data_glove_surv_sp");
  level.player disableweaponcycling();
  level.player disableweaponfire();
  level.player disableoffhandweapons();
  level.player switchtoweapon("data_glove_surv_sp");
  level.player setlowready(0);

  if(level.wiiu) {
    controller_type = level.player getcontrollertype();

    if(controller_type == "remote")
      setsaveddvar("wiiu_viewmodelTrackOffsetY", -12);
  }

  level.player waittill("weapon_change_complete");
  add_visor_text("PAKISTAN_SHARED_SURVEILLANCE_INITIALIZE", 3);
  maps\_glasses::perform_visor_wipe();
  wait 1;

  if(!isDefined(level.e_xcam)) {
    level.e_xcam = spawn("script_model", level.player.origin);
    level.e_xcam setmodel("tag_origin");
  }

  level.e_xcam setclientflag(6);

  if(isDefined(level.menendez))
    level.menendez setclientflag(3);

  clientnotify("xcam_on");
  wait 1.5;
  luinotifyevent(&"hud_pak_rec_visibility", 1, 1);
  luinotifyevent(&"hud_pak_add_poi", 2, level.menendez getentitynumber(), 1);
  flag_clear("xcam_off");
  level.player thread monitor_surveillance_zoom();
  flag_set("id_ready");
  wait 2;
  add_visor_text("PAKISTAN_SHARED_SURVEILLANCE_ACTIVE", 0);
}

turn_off_xcam() {
  level.player takeweapon("data_glove_surv_sp");
  level.player enableweaponcycling();
  level.player enableweaponfire();
  level.player enableoffhandweapons();
  level.player setlowready(1);
  remove_visor_text("PAKISTAN_SHARED_SURVEILLANCE_ACTIVE");
  wait 0.3;

  if(level.wiiu)
    setsaveddvar("wiiu_viewmodelTrackOffsetY", 0);

  add_visor_text("PAKISTAN_SHARED_SURVEILLANCE_DEACTIVATE", 3);
  maps\_glasses::perform_visor_wipe(0.5);
  wait 0.25;

  if(isDefined(level.e_xcam))
    level.e_xcam clearclientflag(6);

  if(isDefined(level.menendez))
    level.menendez clearclientflag(3);

  level clientnotify("surv_END");
  flag_set("xcam_off");
  luinotifyevent(&"hud_pak_rec_visibility", 1, 0);
}

start_courtyard_ambient_drones() {
  s_spawn_drone1 = getstruct("ambient_drone1_spawnpt", "targetname");
  vh_drone1 = spawn_vehicle_from_targetname("isi_drone");
  vh_drone1.origin = s_spawn_drone1.origin;
  vh_drone1.angles = s_spawn_drone1.angles;
  vh_drone1 thread ambient_flight_path(getstruct(s_spawn_drone1.target, "targetname"));
  s_delete = getstruct("ambient_drone1_delete", "targetname");
  vh_drone1 thread delete_drone(s_delete);
  s_spawn_drone1 structdelete();
  s_spawn_drone2 = getstruct("ambient_drone2_spawnpt", "targetname");
  vh_drone2 = spawn_vehicle_from_targetname("isi_drone");
  vh_drone2.origin = s_spawn_drone2.origin;
  vh_drone2.angles = s_spawn_drone2.angles;
  vh_drone2 thread ambient_flight_path(getstruct(s_spawn_drone2.target, "targetname"));
  s_delete = getstruct("ambient_drone2_delete", "targetname");
  vh_drone2 thread delete_drone(s_delete);
  s_spawn_drone2 structdelete();
  flag_wait("heading_to_ac");
  s_spawn_drone3 = getstruct("ambient_drone3_spawnpt", "targetname");
  vh_drone3 = spawn_vehicle_from_targetname("isi_drone");
  vh_drone3.origin = s_spawn_drone3.origin;
  vh_drone3.angles = s_spawn_drone3.angles;
  vh_drone3 thread ambient_flight_path(getstruct(s_spawn_drone3.target, "targetname"));
  s_spawn_drone3 structdelete();
  wait 1;
  s_spawn_drone4 = getstruct("ambient_drone4_spawnpt", "targetname");
  vh_drone4 = spawn_vehicle_from_targetname("isi_drone");
  vh_drone4.origin = s_spawn_drone4.origin;
  vh_drone4.angles = s_spawn_drone4.angles;
  vh_drone4 thread ambient_flight_path(getstruct(s_spawn_drone4.target, "targetname"));
  s_spawn_drone4 structdelete();
}

delete_drone(s_delete) {
  self endon("death");
  flag_wait_all("heading_to_ac", "anthem_facial_recognition_complete");
  self notify("stop_follow_path");
  self setspeed(0);
  wait 3;
  self setspeed(15, 10, 5);
  self setvehgoalpos(self.origin + vectorscale((0, 0, -1), 800.0), 1);
  self waittill("goal");
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

drone_punishment() {
  level endon("jump_down_player_started");
  flag_wait("alert_drones");
  flag_set("player_detected");
  setdvar("ui_deadquote", & "PAKISTAN_SHARED_KILLED_BY_DRONE");
  level thread drone_death_hud(level.player);
  level thread kill_player_after_time();
  level.player setlowready(0);
  level.player enableweaponfire();
  level.player enableweapons();
  wait 1;

  if(!flag("xcam_off") && (flag("confirm_menendez_done") || flag("confirm_menendez_reach_done"))) {
    turn_off_xcam();
    stop_surveillance();
  }

  a_s_drones = getstructarray("drone_punisher", "targetname");
  a_vh_drones = [];

  for(i = 0; i < a_s_drones.size; i++) {
    a_vh_drones[i] = spawn_vehicle_from_targetname("isi_drone");
    a_vh_drones[i].origin = a_s_drones[i].origin;
    a_vh_drones[i].angles = a_s_drones[i].angles;
    a_vh_drones[i] thread drone_punisher_logic(a_s_drones[i].target);
  }

  level.harper say_dialog("harp_damn_1", 2);
}

drone_death_hud(player) {
  player waittill("death");
  overlay = newclienthudelem(player);
  overlay.x = 0;
  overlay.y = 0;
  overlay setshader("hud_pak_drone", 120, 80);
  overlay.alignx = "center";
  overlay.aligny = "middle";
  overlay.horzalign = "center";
  overlay.vertalign = "middle";
  overlay.foreground = 1;
  overlay.alpha = 0;
  overlay fadeovertime(1);
  overlay.alpha = 1;
}

anthem_saves() {
  flag_wait("anthem_player_grapple_done");
  level thread autosave_now("anthem_rooftop_reached");
  flag_wait("anthem_harper_vo_surveillance");
  wait 1;
  level thread autosave_by_name("anthem_surveillance_mid");
  flag_wait("harper_control_room");
  level thread autosave_by_name("tower_control_reached");
  flag_wait("osprey_away");
  level thread autosave_by_name("rooftop_meeting_end");
}

rooftop_light() {
  e_light = getent("harper_light", "targetname");
  flag_wait("anthem_player_grapple_done");
  e_light setlightintensity(0);
}
/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\monsoon_lab_defend.gsc
***************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_objectives;
#include maps\monsoon_util;
#include maps\_scene;
#include maps\_vehicle;
#include maps\_dialog;
#include maps\_anim;
#include maps\_dynamic_nodes;
#include maps\_music;
#include maps\_glasses;
#include maps\monsoon_lab_defend;
#include maps\monsoon_celerium_chamber;
#include maps\monsoon_lab;
#include maps\_audio;
#include maps\createart\monsoon_art;
#include maps\_metal_storm;
#include maps\_ai_rappel;
#include maps\_cic_turret;

skipto_lab_defend() {
  level.harper = init_hero("harper");
  level.salazar = init_hero("salazar");
  level.crosby = init_hero("crosby");
  skipto_teleport("player_skipto_lab_defend", get_heroes());
  init_lab_interior();
  lab_spawn_funcs();
  level thread maps\monsoon_lab_defend::player_isaac_container();
  level thread maps\monsoon_celerium_chamber::turn_off_all_lab_trigs();
  level thread maps\monsoon_lab::remove_hallway_ai_clip();
  level thread maps\monsoon_lab::lab_doors();
  s_glass_hallway_damage_pulse = getstruct("glass_hallway_damage_pulse", "targetname");
  radiusdamage(s_glass_hallway_damage_pulse.origin, 100, 400, 200);
  level thread challenge_kill_challenge_watch();
  level thread ddm_machines();
  level.player.overrideplayerdamage = ::player_nitrogen_death;
  level.player setlowready(1);
  level thread emergency_light_init();
  level.ignoreneutralfriendlyfire = 1;
  make_model_not_cheap();
}

init_lab_defend_flags() {
  flag_init("squad_at_ddm");
  flag_init("riotshield_hint_timeout");
  flag_init("start_asd_wall_crash");
  flag_init("start_ceiling_rappelers");
  flag_init("spawn_left_defend_squad");
  flag_init("spawn_left_camo_squad");
  flag_init("spawn_right_camo_squad");
  flag_init("set_obj_help_isaac");
  flag_init("player_at_isaac");
  flag_init("heroes_fallback");
  flag_init("start_defend_sm_think");
  flag_init("stop_defend_sm_think");
  flag_init("isaac_defend_start");
  flag_init("lab_defend_done");
  flag_init("rocket_intro_start");
  flag_init("rocket_intro_done");
  flag_init("open_asd_door");
  flag_init("player_asd_rollout");
  flag_init("section_defend_line_1");
  flag_init("section_defend_line_2");
  flag_init("section_defend_line_3");
  flag_init("start_container_noise");
  flag_init("give_player_shield");
  flag_init("give_back_player_weapons");
  flag_init("start_first_wall_hit");
  flag_init("asd_player_vo");
}

lab_defend_waves() {
  level thread asd_wall_crash();
  level thread ceiling_rappelers();
  level thread left_defend_squad();
  level thread left_camo_squad();
  level thread right_camo_squad();
  level thread monitor_defend_spawns();
}

player_defend_dialog() {
  flag_wait("section_defend_line_1");
  level.player queue_dialog("sect_woods_told_us_just_h_1");
  flag_wait("section_defend_line_2");
  level.player queue_dialog("sect_he_s_been_investing_0", 0.5);
  flag_wait("start_container_noise");
  level.player setlowready(0);
  flag_clear("asd_player_vo");
  flag_wait("section_defend_line_3");
  level.harper queue_dialog("harp_stay_the_fuck_down_0", 0.5);
  level.player queue_dialog("sect_defensive_positions_0", 0.5);
  flag_clear("section_defend_line_1");
  flag_wait("start_ceiling_rappelers");
  level.salazar queue_dialog("sala_enemy_pmcs_repellin_0", 0.25);
  level.player queue_dialog("sect_hold_the_line_0", 1.0);
}

lab_defend_main() {
  flag_wait("start_lab_defend");
  array_thread(getspawnerarray(), ::add_spawn_function, ::watch_assault_shield_damage);
  lab_defend_waves();
  flag_set("asd_player_vo");
  level.salazar thread salazar_defend_scene();
  level.crosby thread crosby_defend_scene();
  level.harper thread harper_defend_scene();
  level thread player_defend_dialog();
  level.isaac = simple_spawn_single("isaac");
  level.isaac make_hero();
  level.isaac bloodimpact("none");
  level.isaac.ignoreme = 1;
  run_scene_first_frame("isaac_defend_intro");
  array_wait(get_heroes(), "squad_at_ddm_pos");
  array_func(get_heroes(), ::idle_at_cover, 0);
  autosave_by_name("ddm_regroup");
  flag_set("player_at_ddm");
  flag_set("set_obj_help_isaac");
  level thread isaac_cabinet_nag();
  trig_isaac_player = getent("trig_isaac_player", "targetname");
  trig_isaac_player trigger_on();
  trig_isaac_player sethintstring(&"MONSOON_ERIK_CONTAINER_HINT");
  trig_isaac_player setcursorhint("HINT_NOICON");
  trig_isaac_player waittill("trigger");
  trig_isaac_player delete();
  level thread blast_doors_close();
  level.isaac thread isaac_defend_scene();

  if(level.player ent_flag_exist("camo_suit_on") && level.player ent_flag("camo_suit_on"))
    level.player ent_flag_clear("camo_suit_on");

  run_scene("player_isaac_interact");
  level.player setlowready(1);
  level thread player_riotshield();
  level thread lab_defend_event_timer();
}

watch_assault_shield_damage() {
  self waittill("damage", idamage, eattacker, direction, point, type, tagname, modelname, partname, weaponname);

  if(weaponname == "riotshield_sp" && eattacker == level.player)
    idamage = self.health + 30;

  return idamage;
}

player_isaac_container() {
  run_scene_first_frame("player_isaac_container");
  flag_wait("player_at_isaac");
  e_container_keypad = getent("container_keypad", "targetname");
  e_container_keypad setmodel("p6_monsoon_crate_access_unlocked");
  clearallcorpses();
  exploder(3233);
  run_scene("player_isaac_container");
}

isaac_defend_scene() {
  flag_wait("player_at_isaac");
  run_scene("isaac_defend_intro");
  level thread run_scene("isaac_defend_loop");
  autosave_now("lab_defend_intro");
}

blast_doors_close() {
  e_lab_blast_doors = getent("lab_blast_doors", "targetname");
  e_lab_blast_doors show();
  e_lab_blast_doors solid();
  e_lab_blast_doors disconnectpaths();
  a_blast_door_nodes = getnodearray("blast_door_nodes", "targetname");

  foreach(node in a_blast_door_nodes)
  node node_disconnect_from_path();

  end_scene("cower_3_loop");
  delete_scene_all("cower_3_loop");
  end_scene("lab_cower_1_loop");
  delete_scene_all("lab_cower_1_loop");
  end_scene("scientist_4");
  delete_scene_all("scientist_4");
  delete_scene_all("lab_corpse_1_loop");
  delete_scene_all("lab_corpse_2_loop");
  delete_scene_all("lab_corpse_3_loop");
}

player_riotshield() {
  scene_wait("harper_shield_plant");
  flag_set("player_ddm_ready");
  flag_wait("player_shield_is_ready");
  set_objective(level.obj_lab_defend, getstruct("obj_player_riotshield"), "breadcrumb");
  trig_player_riotshield = getent("trig_player_riotshield", "targetname");
  trig_player_riotshield trigger_on();
  trig_player_riotshield sethintstring(&"MONSOON_PLAYER_SHIELD_HINT");
  trig_player_riotshield setcursorhint("HINT_NOICON");
  trig_player_riotshield waittill("trigger");
  trig_player_riotshield delete();
  set_objective(level.obj_lab_defend, getstruct("obj_player_riotshield"), "remove");
  level thread run_scene("player_defend_shield");
  run_scene("player_shield_grab");
  level.player giveweapon("riotshield_sp");
  level.player switchtoweapon("riotshield_sp");
  level thread riotshield_hint_message();
}

riotshield_hint_message() {
  wait 1.5;
  screen_message_create(&"MONSOON_RIOTSHIELD_HINT");
  level thread riotshield_hint_timeout();
  level.player thread monitor_shield_deployment();
  flag_wait("riotshield_hint_timeout");
  screen_message_delete();
}

monitor_shield_deployment() {
  level endon("riotshield_hint_timeout");
  level.player waittill("deploy_riotshield");
  flag_set("riotshield_hint_timeout");
}

riotshield_hint_timeout() {
  wait 5;
  flag_set("riotshield_hint_timeout");
}

isaac_cabinet_nag() {
  level endon("player_at_isaac");

  if(!isDefined(level.a_cabinet_nag)) {
    level.a_cabinet_nag[0] = "harp_let_s_see_what_we_ve_0";
    level.a_cabinet_nag[1] = "harp_open_it_section_0";
  }

  foreach(nag in level.a_cabinet_nag) {
    wait 8;
    level.harper queue_dialog(nag);
    nag = undefined;
  }
}

crosby_defend_scene() {
  self disable_ai_color(1);
  run_scene("crosby_defend_approach");
  end_scene("crosby_defend_approach");
  delete_scene("crosby_defend_approach");
  level thread run_scene("crosby_defend_loop");
  self notify("squad_at_ddm_pos");
  flag_wait("player_at_isaac");
  run_scene("crosby_defend_intro");
  end_scene("crosby_defend_intro");
  delete_scene("crosby_defend_intro");
  self.dontmelee = 1;
  self disable_pain();
  self.goalradius = 32;
  self.fixednode = 1;
  nd_crosby_defend = getnode("nd_crosby_defend", "targetname");
  self setgoalnode(nd_crosby_defend);
  self waittill("goal");
  flag_wait("heroes_fallback");
  nd_salazar_celerium_door = getnode("nd_salazar_celerium_door", "targetname");
  self thread force_goal(nd_salazar_celerium_door, 64, 1);
}

harper_defend_scene() {
  self disable_ai_color(1);
  run_scene("harper_defend_approach");
  level thread run_scene("harper_defend_loop");
  self notify("squad_at_ddm_pos");
  level.isaac notify("squad_at_ddm_pos");
  flag_wait("player_at_isaac");
  run_scene("harper_defend_intro");
  nd_harper_celerium_door = getnode("nd_harper_celerium_door", "targetname");
  self setgoalnode(nd_harper_celerium_door);
  self waittill("goal");
  flag_set("harper_ddm_ready");
  flag_wait("harper_shield_is_ready");
  level thread shield_vo();
  self.dontmelee = 1;
  self.goalradius = 32;
  self disable_pain();
  self monsoon_hero_rampage(1);
  self bloodimpact("none");
  run_scene("harper_shield_plant");
  nd_harper_defend = getnode("nd_harper_defend", "targetname");
  self setgoalnode(nd_harper_defend);
  self waittill("goal");
  self.fixednode = 1;
  wait 5;
  flag_wait("heroes_fallback");
  nd_crosby_defend = getnode("nd_crosby_defend", "targetname");
  self setgoalnode(nd_crosby_defend);
  self waittill("goal");
}

harper_shield_fx(guy) {
  e_shield = get_model_or_models_from_scene("harper_shield_plant", "harper_shield");
  playfxontag(getfx("shield_deploy_dust"), e_shield, "tag_origin");
  wait 0.8;
  playfxontag(getfx("shield_lights"), e_shield, "tag_fx");
}

shield_vo() {
  level.player queue_dialog("sect_grab_some_of_these_s_0", 1);
  level.player queue_dialog("sect_set_em_down_as_cove_0", 1.5);
}

salazar_defend_scene() {
  self disable_ai_color(1);
  run_scene("salazar_defend_approach");
  level thread run_scene("salazar_defend_loop");
  self notify("squad_at_ddm_pos");
  flag_wait("player_at_isaac");
  run_scene("salazar_defend_intro");
  nd_salazar_defend = getnode("nd_salazar_defend", "targetname");
  self setgoalnode(nd_salazar_defend);
  self waittill("goal");
  self.fixednode = 1;
  self.dontmelee = 1;
  self disable_pain();
  self.goalradius = 32;
}

monitor_defend_spawns() {
  level endon("stop_defend_sm_think");
  flag_wait("start_defend_sm_think");
  trig_spawn_area_1 = getent("trig_spawn_area_1", "targetname");
  trig_spawn_area_2 = getent("trig_spawn_area_2", "targetname");

  while(true) {
    if(level.player istouching(trig_spawn_area_1)) {
      spawn_manager_disable("trig_sm_area_defend_area_2");
      spawn_manager_enable("trig_sm_area_defend_area_1");
    } else if(level.player istouching(trig_spawn_area_2)) {
      spawn_manager_disable("trig_sm_area_defend_area_1");
      spawn_manager_enable("trig_sm_area_defend_area_2");
    }

    wait 0.05;
  }
}

lab_defend_enemy_vo() {
  flag_wait("start_asd_wall_crash");
  ai_pmc = get_closest_living(level.player.origin, getaiarray("axis"));
  ai_pmc queue_dialog("cub0_stay_behind_the_asds_0", 4.0);
  ai_pmc = get_closest_living(level.player.origin, getaiarray("axis"));
  ai_pmc queue_dialog("cub1_watch_your_fire_do_0", 5.0);
  scene_wait("harper_shield_plant");
  ai_pmc = get_closest_living(level.player.origin, getaiarray("axis"));
  ai_pmc queue_dialog("cub0_they_re_too_well_def_0", 1.0);
  ai_pmc = get_closest_living(level.player.origin, getaiarray("axis"));
  ai_pmc queue_dialog("cub1_stay_on_them_0", 2.0);
}

lab_defend_event_timer() {
  flag_wait("start_first_wall_hit");
  level notify("fxanim_defend_room_door_01_start");
  level notify("fxanim_defend_room_monitors_01_start");
  exploder(1998);
  earthquake(0.2, 0.5, level.player.origin, 256);
  level.player playsound("exp_carrier_impact1");
  level.player playrumbleonentity("damage_heavy");
  level.player setlowready(0);
  level thread maps\_audio::switch_music_wait("MONSOON_DEFEND_EVENT", 1);
  wait 4;
  level notify("fxanim_defend_room_door_02_start");
  level notify("fxanim_defend_room_monitors_02_start");
  exploder(1999);
  earthquake(0.4, 1.0, level.player.origin, 256);
  level.player playsound("exp_carrier_impact2");
  level.player playrumbleonentity("damage_heavy");
  wait 2;
  clientnotify("defend_room_destroy");
  level thread maps\createart\monsoon_art::defend_vision();
  exploder(1500);
  flag_set("isaac_defend_start");
  t_use = getent("trig_asd_player", "targetname");
  set_objective(level.obj_bruteforce, t_use, "remove");

  if(isDefined(t_use)) {
    t_use trigger_off();
    t_use setcursorhint("HINT_NOICON");
    t_use sethintstring("");
  }

  wait 6;
  flag_set("start_ceiling_rappelers");
  wait 5;
  flag_set("start_asd_wall_crash");
  simple_spawn("wall_crash_enemies");
  spawn_vehicle_from_targetname("asd_defend_1");
  spawn_vehicle_from_targetname_and_drive("asd_defend_2");
  level thread asd_intro_destruction();
  level thread lab_defend_enemy_vo();
  wait 5;
  level thread left_turret_defend();
  level thread right_turret_defend();
  wait 2;
  level.harper thread queue_dialog("harp_these_fuckers_mean_b_0");
  wait 8;
  clientnotify("defend_room_destroy");
  level thread maps\createart\monsoon_art::lab_vision();
  flag_set("spawn_left_camo_squad");
  flag_set("spawn_left_defend_squad");
  flag_set("spawn_right_camo_squad");
  flag_set("start_defend_sm_think");
  wait 30;
  flag_set("stop_defend_sm_think");
  spawn_manager_disable("trig_sm_area_defend_area_1");
  spawn_manager_disable("trig_sm_area_defend_area_2");
  wait 0.1;
  spawn_manager_kill("trig_sm_area_defend_area_1");
  spawn_manager_kill("trig_sm_area_defend_area_2");
  simple_spawn("last_stand_enemies");
  wait 1;
  a_lab_defend_spawners = getentarray("lab_defend_spawners", "script_noteworthy");

  foreach(spawner in a_lab_defend_spawners) {
    if(isDefined(spawner))
      spawner delete();

    wait 0.05;
  }

  a_last_stand_enemies = getentarray("last_stand_enemies", "script_noteworthy");

  foreach(spawner in a_last_stand_enemies) {
    if(isDefined(spawner))
      spawner delete();

    wait 0.05;
  }

  wait 1;
  a_ai = getaiarray("axis");

  foreach(ai in a_ai) {
    ai.goalradius = 32;
    ai set_spawner_targets("enemy_push_nodes");
  }

  vh_right_defend_turret = getent("right_defend_turret", "targetname");

  if(isDefined(vh_right_defend_turret))
    vh_right_defend_turret notify("death");

  wait 1;
  vh_left_defend_turret = getent("left_defend_turret", "targetname");

  if(isDefined(vh_left_defend_turret))
    vh_left_defend_turret notify("death");

  wait 0.05;
  a_ai_axis = getaiarray("axis");
  array_wait(a_ai_axis, "death");
  a_defend_asds = getentarray("defend_asds", "script_noteworthy");

  foreach(asd in a_defend_asds) {
    if(issentient(asd))
      asd notify("death");
  }

  level.salazar queue_dialog("sala_we_re_clear_0", 0.25);
  level.harper queue_dialog("harp_now_the_celerium_0", 0.3);
  level.isaac thread queue_dialog("isaa_this_way_the_locki_0", 0.25);
  autosave_by_name("defend_end");
  flag_set("lab_defend_done");
  setmusicstate("MONSOON_DEFEND_EVENT_END");
}

asd_wall_crash() {
  flag_wait("start_asd_wall_crash");
  defend_crash_hide = getentarray("defend_crash_hide", "targetname");

  foreach(piece in defend_crash_hide)
  piece hide();

  m_defend_crash_hide = getent("defend_crash_hide", "targetname");
  m_defend_crash_hide connectpaths();
  m_defend_crash_hide delete();
  s_wall_blast_pos = getstruct("wall_blast_pos", "targetname");
  earthquake(1.0, 0.75, level.player.origin, 250);
  level.player playrumbleonentity("damage_heavy");
  n_distance = distancesquared(s_wall_blast_pos.origin, level.player.origin);

  if(n_distance < 400)
    level.player kill();

  exploder(2000);
  level notify("fxanim_defend_room_01_start");
  wait 0.05;
  level notify("fxanim_defend_room_monitors_03_start");
  m_asd_defend_panel_1 = getent("asd_defend_panel_1", "targetname");
  m_asd_defend_panel_1 delete();
  m_asd_defend_panel_2 = getent("asd_defend_panel_2", "targetname");
  m_asd_defend_panel_2 delete();
  e_fxanim_defend_room_door = getent("fxanim_defend_room_door", "targetname");
  e_fxanim_defend_room_door connectpaths();
  e_fxanim_defend_room_door delete();
  s_wall_blast_pos = getstruct("wall_blast_pos", "targetname");
  n_distance = distancesquared(s_wall_blast_pos.origin, level.player.origin);

  if(n_distance < 240)
    level.player kill();
}

init_defend_left_asd() {
  self endon("death");
  self thread player_asd_rumble();
  self setneargoalnotifydist(64);
  self maps\_metal_storm::metalstorm_stop_ai();
  self.ignoreme = 1;
  self veh_magic_bullet_shield(1);
  nd_start_node = getvehiclenode(self.target, "targetname");
  self thread go_path(nd_start_node);
  flag_wait("rocket_intro_start");
  s_column_target = getstruct("column_target", "targetname");
  magicbullet("metalstorm_launcher", self gettagorigin("TAG_MISSILE1"), s_column_target.origin);
  wait 0.2;
  magicbullet("metalstorm_launcher", self gettagorigin("TAG_MISSILE2"), s_column_target.origin);
  wait 0.2;
  magicbullet("metalstorm_launcher", self gettagorigin("TAG_MISSILE3"), s_column_target.origin);
  self veh_magic_bullet_shield(0);
  self.ignoreme = 0;
  flag_set("rocket_intro_done");
  self thread metalstorm_weapon_think();
  wait 2;
  self setneargoalnotifydist(128);
  self maps\_vehicle::vehicle_pathdetach();
  s_left_asd_attack_pos = getstruct("left_asd_attack_pos", "targetname");
  self setvehgoalpos(s_left_asd_attack_pos.origin, 1, 2, 1);
  self waittill_any("goal", "near_goal");
  flag_set("heroes_fallback");
  self maps\_vehicle::defend(s_left_asd_attack_pos.origin, 128);
  flag_wait("stop_defend_sm_think");
  self notify("death");
}

init_defend_right_asd() {
  self endon("death");
  self thread player_asd_rumble();
  self setneargoalnotifydist(64);
  self maps\_metal_storm::metalstorm_stop_ai();
  self.ignoreme = 1;
  flag_wait("rocket_intro_done");
  self thread metalstorm_weapon_think();
  self.ignoreme = 0;
  wait 5;
  self setneargoalnotifydist(128);
  self maps\_vehicle::vehicle_pathdetach();
  s_right_asd_attack_pos = getstruct("right_asd_attack_pos", "targetname");
  self setvehgoalpos(s_right_asd_attack_pos.origin, 1, 2, 1);
  self waittill_any("goal", "near_goal");
  flag_set("heroes_fallback");
  self maps\_vehicle::defend(s_right_asd_attack_pos.origin, 128);
  flag_wait("stop_defend_sm_think");
  wait 2.5;
  self notify("death");
}

init_right_path_asd() {
  self endon("death");
  self thread player_asd_rumble();
  self maps\_metal_storm::metalstorm_stop_ai();
  nd_start_node = getvehiclenode(self.target, "targetname");
  self thread go_path(nd_start_node);
  self setspeed(5, 4, 1);
  self waittill("reached_end_node");
  self maps\_vehicle::vehicle_pathdetach();
  self maps\_vehicle::defend(self.origin, 200);
  trigger_wait("trig_3_2_right_half");
  s_right_path_asd_fallback = getstruct("right_path_asd_fallback", "targetname");
  self setvehgoalpos(s_right_path_asd_fallback.origin, 1, 2, 1);
  self waittill_any("goal", "near_goal");
  self maps\_vehicle::defend(self.origin, 200);
}

asd_intro_destruction() {
  level endon("defend_asd_destroyed");
  s_column_target = getstruct("column_target", "targetname");
  trig_damage_pillar = getent("trig_damage_pillar", "targetname");
  trig_damage_tv = getent("trig_damage_tv", "targetname");
  trigger_wait("trig_damage_pillar");
  earthquake(0.65, 0.75, level.player.origin, 512);
  level.player playrumbleonentity("damage_heavy");
  defend_pillar_hide = getentarray("defend_pillar_hide", "targetname");

  foreach(piece in defend_pillar_hide)
  piece hide();

  level notify("fxanim_defend_room_02_start");
  defend_pillar_show = getentarray("defend_pillar_show", "targetname");

  foreach(piece in defend_pillar_show)
  piece show();
}

ceiling_rappelers() {
  flag_wait("start_ceiling_rappelers");
  a_rappel_glass_structs = getstructarray("rappel_glass_structs", "targetname");

  foreach(glass_struct in a_rappel_glass_structs) {
    radiusdamage(glass_struct.origin, 100, 400, 200);
    wait 0.05;
  }

  simple_spawn_single("defend_rappelers_guy_1", ::init_defend_rappelers);
  playsoundatposition("evt_enemy_rappel_01", (7810, 56028, -1051));
  wait(randomintrange(1, 2));
  simple_spawn_single("defend_rappelers_guy_2", ::init_defend_rappelers);
  playsoundatposition("evt_enemy_rappel_02", (7727, 55763, -1047));
  ai_pmc = get_closest_living(level.player.origin, getaiarray("axis"));
  ai_pmc thread queue_dialog("cub3_cut_them_down_0", 3.0);
  wait(randomintrange(1, 2));
  simple_spawn_single("defend_rappelers_guy_3", ::init_defend_rappelers);
  playsoundatposition("evt_enemy_rappel_03", (7807, 56287, -1043));
  flag_wait("start_asd_wall_crash");
  simple_spawn_single("wave_2_rappelers_guy_1", ::init_defend_rappelers);
  playsoundatposition("evt_enemy_rappel_01", (7552, 56414, -1088));
  wait(randomintrange(1, 2));
  simple_spawn_single("wave_2_rappelers_guy_2", ::init_defend_rappelers);
  playsoundatposition("evt_enemy_rappel_02", (7816, 56317, -1084));
  wait(randomintrange(1, 2));
  simple_spawn_single("wave_2_rappelers_guy_3", ::init_defend_rappelers);
  playsoundatposition("evt_enemy_rappel_01", (7810, 56028, -1051));
  wait(randomintrange(1, 2));
  simple_spawn_single("wave_2_rappelers_guy_4", ::init_defend_rappelers);
  playsoundatposition("evt_enemy_rappel_03", (7552, 55787, -1038));
}

init_defend_rappelers() {
  self endon("death");
  s_rappel_struct = getstruct(self.target, "targetname");
  self thread maps\_ai_rappel::start_ai_rappel(2.5, s_rappel_struct, 1, 1);
  self.a.deathforceragdoll = 1;
  self waittill("rappel_done");
  self.a.deathforceragdoll = 0;
}

ragdoll_death() {
  self waittill("death");
  self startragdoll();
}

left_defend_squad() {
  flag_wait("spawn_left_defend_squad");
  simple_spawn("left_defend_squad");
  e_defend_door_03l = getent("defend_door_03l", "targetname");
  e_defend_door_03l_clip = getent("defend_door_03l_clip", "targetname");
  e_defend_door_03l_clip linkto(e_defend_door_03l);
  e_defend_door_03r = getent("defend_door_03r", "targetname");
  e_defend_door_03r_clip = getent("defend_door_03r_clip", "targetname");
  e_defend_door_03r_clip linkto(e_defend_door_03r);
  e_defend_door_03l movey(-52, 1);
  e_defend_door_03r movey(52, 1);
  e_defend_door_03r waittill("movedone");
  e_defend_door_03l connectpaths();
  e_defend_door_03r connectpaths();
  e_defend_door_03l_clip connectpaths();
  e_defend_door_03r_clip connectpaths();
}

left_camo_squad() {
  flag_wait("spawn_left_camo_squad");
  simple_spawn("left_camo_squad");
  m_defend_door_01l = getent("defend_door_01l", "targetname");
  bm_defend_door_01l_clip = getent("defend_door_01l_clip", "targetname");
  bm_defend_door_01l_clip linkto(m_defend_door_01l);
  m_defend_door_01r = getent("defend_door_01r", "targetname");
  bm_defend_door_01r_clip = getent("defend_door_01r_clip", "targetname");
  bm_defend_door_01r_clip linkto(m_defend_door_01r);
  m_defend_door_01l movey(54, 0.5);
  m_defend_door_01r movey(-54, 0.5);
  m_defend_door_01l waittill("movedone");
  m_defend_door_01l connectpaths();
  m_defend_door_01r connectpaths();
  bm_defend_door_01l_clip connectpaths();
  bm_defend_door_01r_clip connectpaths();
}

right_camo_squad() {
  flag_wait("spawn_right_camo_squad");
  simple_spawn("right_camo_squad");
  m_defend_door_02l = getent("defend_door_02l", "targetname");
  bm_defend_door_02l_clip = getent("defend_door_02l_clip", "targetname");
  bm_defend_door_02l_clip linkto(m_defend_door_02l);
  m_defend_door_02r = getent("defend_door_02r", "targetname");
  bm_defend_door_02r_clip = getent("defend_door_02r_clip", "targetname");
  bm_defend_door_02r_clip linkto(m_defend_door_02r);
  m_defend_door_02l movex(54, 0.5);
  m_defend_door_02r movex(-54, 0.5);
  m_defend_door_02l waittill("movedone");
  m_defend_door_02l connectpaths();
  m_defend_door_02r connectpaths();
  bm_defend_door_02l_clip connectpaths();
  bm_defend_door_02r_clip connectpaths();
}

left_turret_defend() {
  bm_left_turret_tile_1 = getent("left_turret_tile_1", "targetname");
  bm_right_turret_tile_1 = getent("right_turret_tile_1", "targetname");
  vh_left_defend_turret = spawn_vehicle_from_targetname("left_defend_turret");
  vh_left_defend_turret maps\_cic_turret::cic_turret_off();
  bm_left_turret_arm_1 = getent("left_turret_arm_1", "targetname");
  vh_left_defend_turret linkto(bm_left_turret_arm_1);
  vh_left_defend_turret veh_magic_bullet_shield(1);
  bm_left_turret_tile_1 movez(10, 0.5);
  bm_right_turret_tile_1 movez(10, 0.5);
  bm_right_turret_tile_1 waittill("movedone");
  bm_left_turret_tile_1 movey(32, 0.5);
  bm_right_turret_tile_1 movey(-32, 0.5);
  bm_right_turret_tile_1 waittill("movedone");
  bm_left_turret_arm_1 movez(-125, 3.5);
  bm_left_turret_arm_1 waittill("movedone");
  vh_left_defend_turret veh_magic_bullet_shield(0);
  vh_left_defend_turret maps\_cic_turret::cic_turret_start_ai();
  bm_left_turret_arm_1 movez(1, 0.25);
  bm_left_turret_arm_1 waittill("movedone");
  bm_left_turret_arm_1 movez(-1, 0.25);
  bm_left_turret_arm_1 waittill("movedone");
  bm_left_turret_tile_1 movey(-32, 0.5);
  bm_right_turret_tile_1 movey(32, 0.5);
  bm_right_turret_tile_1 waittill("movedone");
  bm_left_turret_tile_1 movez(-10, 0.5);
  bm_right_turret_tile_1 movez(-10, 0.5);
  bm_right_turret_tile_1 waittill("movedone");
}

right_turret_defend() {
  bm_left_turret_tile_2 = getent("left_turret_tile_2", "targetname");
  bm_right_turret_tile_2 = getent("right_turret_tile_2", "targetname");
  vh_right_defend_turret = spawn_vehicle_from_targetname("right_defend_turret");
  vh_right_defend_turret maps\_cic_turret::cic_turret_off();
  bm_left_turret_arm_2 = getent("left_turret_arm_2", "targetname");
  vh_right_defend_turret linkto(bm_left_turret_arm_2);
  vh_right_defend_turret veh_magic_bullet_shield(1);
  bm_left_turret_tile_2 movez(10, 0.5);
  bm_right_turret_tile_2 movez(10, 0.5);
  bm_right_turret_tile_2 waittill("movedone");
  bm_left_turret_tile_2 movey(32, 0.5);
  bm_right_turret_tile_2 movey(-32, 0.5);
  bm_right_turret_tile_2 waittill("movedone");
  bm_left_turret_arm_2 movez(-125, 3.5);
  bm_left_turret_arm_2 waittill("movedone");
  vh_right_defend_turret veh_magic_bullet_shield(0);
  vh_right_defend_turret maps\_cic_turret::cic_turret_start_ai();
  bm_left_turret_arm_2 movez(1, 0.25);
  bm_left_turret_arm_2 waittill("movedone");
  bm_left_turret_arm_2 movez(-1, 0.25);
  bm_left_turret_arm_2 waittill("movedone");
  bm_left_turret_tile_2 movey(-32, 0.5);
  bm_right_turret_tile_2 movey(32, 0.5);
  bm_right_turret_tile_2 waittill("movedone");
  bm_left_turret_tile_2 movez(-10, 0.5);
  bm_right_turret_tile_2 movez(-10, 0.5);
  bm_right_turret_tile_2 waittill("movedone");
}

asd_perk_visor_text() {
  wait 4.3;
  add_visor_text("MONSOON_IDKFA", 0, "default", "medium");
  wait 2;
  remove_visor_text("MONSOON_IDKFA");
  wait 0.05;
  add_visor_text("MONSOON_J_5_ACTIVATING", 0, "default", "medium");
  wait 2;
  remove_visor_text("MONSOON_J_5_ACTIVATING");
}

asd_perk_death_visor_text() {
  add_visor_text("MONSOON_J_5_DEAD", 0, "default", "medium");
  wait 2;
  remove_visor_text("MONSOON_J_5_DEAD");
}

show_erik_name(guy) {
  level.isaac.name = "Erik";
}
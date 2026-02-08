/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\pel1b_event2.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;
#include maps\pel1b_event2_util;
#include maps\_music;
#using_animtree("generic_human");

event2_main_function() {
  flag_init("flaming_left1_done");
  flag_init("flaming_right1_done");
  flag_init("flaming_left2_done");
  flag_init("flaming_right2_done");
  flag_init("flaming_left3_done");
  flag_init("cave_artillery_active");

  level.plane_bomb_model["p51"] = "aircraft_bomb";
  level.plane_bomb_fx["p51"] = level._effect["napalm_explosion"];
  level.plane_bomb_sound["p51"] = "temp_sound";
  maps\_planeweapons::build_bomb_explosions("p51", randomfloatrange(.3, .5), 3, 5000, 700, 250, 1000);

  createthreatbiasgroup("oblivious_enemies");
  setthreatbias("players", "oblivious_enemies", -1000000);
  setthreatbias("heroes", "oblivious_enemies", 0);

  level thread setup_spawn_functions();

  level thread change_heros_colors();

  level thread initial_plane_napalm_drop();
  level thread second_plane_napalm_drop();

  level.flametank thread flametank_carnage_event();

  level thread setup_objectives();

  level thread cave_effects();

  level thread dialogue_setup();
}
change_heros_colors() {
  trigger = getent("ev2_pacing_starts", "targetname");
  trigger waittill("trigger");

  level.sarge disable_ai_color();
  level.walker disable_ai_color();

  level.sarge set_force_color("o");
  level.walker set_force_color("g");

  if(!NumRemoteClients()) {
    trig1 = getent("ev2_allies_reinforcements_trig", "targetname");
    trig1 notify("trigger");

    trig2 = getent("ev2_allies_reinforcementsb_trig", "targetname");
    trig2 notify("trigger");
  } else if(NumRemoteClients() == 1) {
    trig2 = getent("ev2_allies_reinforcementsb_trig", "targetname");
    trig2 notify("trigger");
  }
}
initial_plane_napalm_drop() {
  trigger = getent("ev2_initial_plane_spawn", "targetname");
  trigger waittill("trigger");

  level notify("event2_bombing_starts");

  wait(0.5);

  plane1 = getent("event2_bombing_plane_01", "targetname");
  plane2 = getent("event2_bombing_plane_02", "targetname");

  plane1 thread bomber_sound_flyby("auto4986", 0.1);
  plane2 thread bomber_sound_flyby("auto4984", 0.1);

  plane1 thread load_bombs(6);
  plane2 thread load_bombs(6);

  wait(0.7);

  plane1 thread drop_bombs("event2_bombing_drop_011", false, 1);
  plane1 thread drop_bombs("event2_bombing_drop_012", false, 1);
  plane1 thread drop_bombs("event2_bombing_drop_013", false, 1);

  plane2 thread drop_bombs("event2_bombing_drop_021", false, 1);
  plane2 thread drop_bombs("event2_bombing_drop_022", false, 1);
  plane2 thread drop_bombs("event2_bombing_drop_023", false, 1);

  level waittill("event2_bombing_drop_011");

  thread drop_bombs_rumble();

  thread battlechatter_on("allies");
  thread battlechatter_on("axis");

  level thread napalm_chain("initial_napalm_drops_chain");

  level waittill("ev2_blow_up_stuff");
  level thread initial_napalm_drones1();

  level waittill("ev2_blow_up_stuff2");
  level thread initial_napalm_drones2();

  radiusdamage((44310, 5649, 200), 50, 5000, 5000);

  wait(4);
  playFX(level._effect["fireball_explosion"], (44012, 4927, 214.4));

  trigger = getent("ev2_plane_strafe_trigger", "targetname");
  trigger notify("trigger");
}

initial_napalm_drones1() {
  if(!NumRemoteClients() || (NumRemoteClients() == 1)) {
    level thread play_explosion_death_anim("ev2_blow_up_guys_3", "script_noteworthy");
    wait_network_frame();
    level thread play_explosion_death_anim("ev2_blow_up_guys_4", "script_noteworthy");
  }
}

initial_napalm_drones2() {
  if(!NumRemoteClients() || (NumRemoteClients() == 1)) {
    level thread play_explosion_death_anim("ev2_blow_up_guys_1", "script_noteworthy");
    wait_network_frame();
    level thread play_explosion_death_anim("ev2_blow_up_guys_2", "script_noteworthy");
  }
}

second_plane_napalm_drop() {
  trigger = getent("ev2_plane_strafe_trigger", "targetname");
  trigger waittill("trigger");

  level notify("plane_strafe_start");

  wait(0.1);

  plane1 = getent("event2_bombing_plane_1", "targetname");
  plane2 = getent("event2_bombing_plane_2", "targetname");
  plane3 = getent("event2_bombing_plane_3", "targetname");

  plane1 thread bomber_sound_flyby("auto2598", 0.1);
  plane2 thread bomber_sound_flyby("auto3941", 0.1);
  plane3 thread bomber_sound_flyby("auto3946", 0.1);

  plane1 thread load_bombs(2);
  plane2 thread load_bombs(2);
  plane3 thread load_bombs(2);

  plane1 thread drop_bombs("event2_bombing_drop_1", true);
  plane2 thread drop_bombs("event2_bombing_drop_2", true);
  plane3 thread drop_bombs("event2_bombing_drop_3", true);

  level thread additional_bomb("plane_drop_bomb_extra", "event2_bombing_drop_3");

  level waittill("event2_bombing_drop_1");

  thread drop_bombs_rumble();

  wait(1);

  fire_points = getstructarray("naplam_battle_residual_fire", "targetname");
  for(i = 0; i < fire_points.size; i++) {
    playFX(level._effect["fire_foliage_large"], fire_points[i].origin);
  }

  level notify("bombing_complete");
}

bomber_sound_flyby(vehiclenode_targetname, wait_time) {
  node = getvehiclenode(vehiclenode_targetname, "targetname");
  node waittill("trigger");

  if(isDefined(wait_time)) {
    wait(wait_time);
  }

  self playSound("p51_bomber_by");
}
setup_spawn_functions() {
  ignore_players_guy = getEntArray("ignore_player_guy", "script_noteworthy");
  array_thread(ignore_players_guy, ::add_spawn_function, ::force_to_goal_ignore_player);

  friendlies = getEntArray("ev2_allies_reinforcements", "script_noteworthy");
  array_thread(friendlies, ::add_spawn_function, ::friendlies_setup);

  radio_guy = getEntArray("ev2_radio_guy", "script_noteworthy");
  array_thread(radio_guy, ::add_spawn_function, ::radio_guy_setup);
}
friendlies_setup() {
  self thread magic_bullet_shield();
}
radio_guy_setup() {
  self thread magic_bullet_shield();
  level.radio_guy = self;
}
flametank_carnage_event() {
  self endon("death");

  flag_wait("flametank_in_second_area");

  flag_wait("flametank_visible_by_player");

  wait(1);
  setthreatbias("players", "oblivious_enemies", 0);

  level.flametank.turretrotscale = 1;

  self setspeed(4, 5, 8);

  trigger = getvehiclenode("auto3964", "targetname");
  trigger waittill("trigger");

  setmusicstate("DROP_OFF");

  self thread flame_battle_left1();

  self thread flame_battle_right1();

  self thread flame_battle_left2();

  self thread flame_battle_right2();

  self thread flame_battle_left3();

  self thread flametank_tree_sniper();
}

flametank_tree_sniper() {
  tree = getent("test_tree", "script_noteworthy");

  tree thread flame_notify();

  model_tag_origin = spawn("script_model", tree.origin);
  model_tag_origin setModel("tag_origin");
  model_tag_origin linkto(tree, "tag_origin", (0, 0, 0), (0, 0, 0));

  node = getvehiclenode("auto5390", "targetname");
  node waittill("trigger");

  playFXOnTag(level._effect["sniper_leaf_loop"], model_tag_origin, "TAG_ORIGIN");

  level.flametank setspeed(0, 10, 10);

  sniper_spawner = getent("ev2_tree_sniper", "targetname");
  sniper = force_spawn_guy(sniper_spawner);

  wait(0.05);
  if(isDefined(sniper) && isalive(sniper)) {
    level.flametank clearturrettarget();

    level.flametank setturrettargetent(sniper);

    level.flametank fireweapon();
  }

  wait(5);

  level.flametank setspeed(0, 10, 10);
  level.flametank clearturrettarget();

  level.flametank stopfireweapon();
  level.flametank setspeed(4, 5, 8);
}

flame_notify() {
  node = getvehiclenode("auto5390", "targetname");
  node waittill("trigger");

  wait(0.05);

  guy = get_ai_group_ai("tree_guy")[0];

  if(isDefined(guy) && isalive(guy)) {
    self waittill("broken", broken_notify, attacker);
    guy animscripts\death::flame_death_fx();

    node = getent("auto17", "targetname");
    createrope(node.origin, (0, 0, 0), 100, guy, "j_ankle_ri");

    wait(0.05);

    guy startragdoll();

    guy dodamage(guy.health + 300, guy.origin, attacker);
  }
}
flame_battle_left1() {
  level endon("flaming_left1_done");

  start_fire_node = getvehiclenode("auto3718", "targetname");
  start_fire_node waittill("trigger");

  self thread set_turret_target_by_name("fire_point_left_1");
  self fireweapon();

  level notify("flametank_started_flaming");

  self thread fire_guys_in_area("flaming_left1_done", "axis_area_trig_left1", "axis_area_goal_left1");

  stop_n_fire_node = getvehiclenode("auto3731", "targetname");
  stop_n_fire_node waittill("trigger");
  self setspeed(0, 10, 10);
}
flame_battle_right1() {
  level endon("flaming_right1_done");

  level waittill("flaming_left1_done");

  self setspeed(4, 5, 8);

  start_fire_node = getvehiclenode("auto5206", "targetname");
  start_fire_node waittill("trigger");

  self thread set_turret_target_by_name("fire_point_right_1");
  self fireweapon();

  self thread fire_guys_in_area("flaming_right1_done", "axis_area_trig_right1", "axis_area_goal_right1");

  stop_n_fire_node = getvehiclenode("auto3721", "targetname");
  stop_n_fire_node waittill("trigger");
  self setspeed(0, 10, 10);
}
flame_battle_left2() {
  level endon("flaming_left2_done");

  level waittill("flaming_right1_done");

  trigger = getent("event2_japs_flow_left_2", "script_noteworthy");
  trigger notify("trigger");

  self setspeed(4, 5, 8);

  start_fire_node = getvehiclenode("auto5200", "targetname");
  start_fire_node waittill("trigger");

  self thread set_turret_target_by_name("fire_point_left_2");
  self fireweapon();

  self thread fire_guys_in_area("flaming_left2_done", "axis_area_trig_left2", "axis_area_goal_left2");

  stop_n_fire_node = getvehiclenode("auto5199", "targetname");
  stop_n_fire_node waittill("trigger");
  self setspeed(0, 10, 10);
}
flame_battle_right2() {
  level endon("flaming_right2_done");

  level waittill("flaming_left2_done");

  trigger = getent("event2_japs_flow_right_2", "script_noteworthy");
  trigger notify("trigger");

  self setspeed(4, 5, 8);

  start_fire_node = getvehiclenode("auto5228", "targetname");
  start_fire_node waittill("trigger");

  self thread set_turret_target_by_name("fire_point_right_2");
  self fireweapon();

  self thread fire_guys_in_area("flaming_right2_done", "axis_area_trig_right2", "axis_area_goal_right2");

  stop_n_fire_node = getvehiclenode("auto5227", "targetname");
  stop_n_fire_node waittill("trigger");
  self setspeed(0, 10, 10);
}
flame_battle_left3() {
  level endon("flaming_left3_done");

  level waittill("flaming_right2_done");

  trigger = getent("event2_japs_flow_left_3a", "script_noteworthy");
  trigger notify("trigger");

  wait(0.05);

  trigger = getent("event2_japs_flow_left_3b", "script_noteworthy");
  trigger notify("trigger");

  self setspeed(4, 5, 8);

  start_fire_node = getvehiclenode("auto5231", "targetname");
  start_fire_node waittill("trigger");

  self thread set_turret_target_by_name("fire_point_left_3");
  self fireweapon();

  self thread fire_guys_in_area("flaming_left3_done", "axis_area_trig_left3", "axis_area_goal_left3");

  stop_n_fire_node = getvehiclenode("auto3724", "targetname");
  stop_n_fire_node waittill("trigger");
  self setspeed(0, 10, 10);
}
fire_guys_in_area(event_flag, trigger_targetname, goal_volume) {
  area_trigger = getent(trigger_targetname, "targetname");

  self thread check_ai_existance(event_flag, area_trigger, goal_volume);

  self thread should_move_ahead(randomintrange(15, 20), event_flag);

  while(!flag(event_flag)) {
    self clearturrettarget();

    axis_guys = getAIarrayTouchingVolume("axis", goal_volume);

    i = 0;

    if(axis_guys.size >= 2)
      i = randomintrange(0, axis_guys.size - 1);

    if(axis_guys.size >= 1) {
      if(!flag(event_flag) && isalive(axis_guys[i]) && axis_guys[i] istouching(area_trigger)) {
        self setturrettargetent(axis_guys[i], (0, 0, randomintrange(30, 60)));
        self waittill_notify_or_timeout("turret_on_target", randomintrange(3, 5));
      }
    } else if(!flag(event_flag)) {
      flag_set(event_flag);

      level notify(event_flag);

      self stopfireweapon();
      self clearturrettarget();
    }
  }

  level notify(event_flag);
}
check_ai_existance(event_flag, area_trigger, goal_volume) {
  while(!flag(event_flag)) {
    ai_count = 0;

    axis_guys = getAIarrayTouchingVolume("axis", goal_volume);

    for(i = 0; i < axis_guys.size; i++) {
      if(isalive(axis_guys[i]) && axis_guys[i] istouching(area_trigger))
        ai_count++;
    }

    if(ai_count == 0 && !flag(event_flag)) {
      flag_set(event_flag);

      level notify(event_flag);

      self stopfireweapon();
      self clearturrettarget();
    }

    wait(0.01);
  }
}
should_move_ahead(timeout, event_flag) {
  wait(timeout);

  if(!flag(event_flag)) {
    flag_set(event_flag);

    level notify(event_flag);

    self stopfireweapon();
    self clearturrettarget();
  }
}
pel1b_outro() {
  guys = [];
  guys[0] = level.walker;
  guys[1] = level.sarge;
  guys[2] = level.radio_guy;

  guys[0].animname = "walker";
  guys[1].animname = "sarge";
  guys[2].animname = "radio_guy";

  guys[0] disable_ai_color();
  guys[1] disable_ai_color();
  guys[2] disable_ai_color();

  guys[0].ignoreall = true;
  guys[1].ignoreall = true;
  guys[2].ignoreall = true;

  anim_struct = getstruct("outro_anim", "targetname");

  goal_node_roebuck = getnode("roebuck_outro", "targetname");
  goal_node_polonsky = getnode("polonsky_outro", "targetname");
  goal_node_radio = getnode("radio_outro", "targetname");

  setmusicstate("LEVEL_END");

  guys[0] thread pacing_vignette_in_place_think(anim_struct, "roebuck_reached_outro", "outro_in", "outro_loop");
  guys[1] thread pacing_vignette_in_place_think(anim_struct, "polonsky_reached_outro", "outro_in", "outro_loop");
  guys[2] thread pacing_vignette_in_place_think(anim_struct, "radio_guy_reached_outro", "outro_in", "outro_loop");

  flag_wait_all("roebuck_reached_outro", "polonsky_reached_outro", "radio_guy_reached_outro");

  players = get_players();
  player_close = false;
  while(!player_close) {
    for(i = 0; i < players.size; i++) {
      if(distancesquared(players[i].origin, guys[0].origin) < 400 * 400) {
        player_close = true;
      }
    }

    wait(0.05);
  }

  for(i = 0; i < players.size; i++) {
    players[i] DisableWeapons();
    players[i] EnableInvulnerability();
  }

  guys[2] notify("radio_anim_starting");
  anim_single(guys, "outro", undefined, undefined, anim_struct);

  objective_state(7, "done");
}

pacing_vignette_in_place_think(goal_node, flag_name, anim_in, anim_looping) {
  startorg = getstartOrigin(goal_node.origin, goal_node.angles, level.scr_anim[self.animname][anim_in]);
  startang = getstartAngles(goal_node.origin, goal_node.angles, level.scr_anim[self.animname][anim_in]);

  self.goalradius = 32;
  self SetGoalPos(startorg, startang);
  self disable_ai_color();
  self PushPlayer(true);

  self waittill("goal");
  self waittill_notify_or_timeout("orientdone", 1);

  wait(0.75);

  anim_single_solo(self, anim_in, undefined, undefined, goal_node);
  thread anim_loop_solo(self, anim_looping, undefined, undefined, goal_node);

  if(self.animname == "radio_guy") {
    self thread outro_animate_radio_model(goal_node);
  }

  flag_set(flag_name);
}

#using_animtree("animated_props");
outro_animate_radio_model(goal_node) {
  radio_model = spawn("script_model", self.origin);
  radio_model setModel("char_usa_marine_radiohandset");
  radio_model linkto(self, "tag_weapon_left", (0, 0, 0), (0, 0, 0));

  radio_model UseAnimTree(#animtree);
  radio_model.animname = "radio";

  thread anim_loop_solo(radio_model, "outro_loop", undefined, undefined, goal_node);

  self waittill("radio_anim_starting");
  anim_single_solo(radio_model, "outro", undefined, undefined, goal_node);

  radio_model delete();
}
setup_objectives() {
  objective_add(3, "current", &"PEL1B_OBJECTIVE_EV2_FLANK", (43393.7, 4060.1, 168.2));

  trigger = getent("ev2_initial_plane_spawn", "targetname");
  trigger waittill("trigger");

  objective_state(3, "done");
  objective_delete(3);

  autosave_by_name("airstrike done");

  objective_add(4, "current", &"PEL1B_OBJECTIVE_EV2_FOLLOW_FLAME");
  Objective_additionalPosition(4, 0, level.flametank);
  level.flametank thread objective_follow_me(4, "tank_destroyed");
  level thread trigger_wait_with_notify("cave_entrance_trigger", "targetname", "tank_destroyed");
  level waittill("tank_destroyed");
  objective_state(4, "done");

  autosave_by_name("flametank dead");

  objective_add(5, "current", &"PEL1B_OBJECTIVE_EV2_ASSAULT_CAVE");
  cave_entrance_trigger = getent("cave_entrance", "targetname");
  cave_entrance_trigger waittill("trigger");
  objective_state(5, "done");

  autosave_by_name("cave entrance");

  objective_add(6, "current", &"PEL1B_OBJECTIVE_EV2_CAVE_CLEAR", (40871.2, -218.9, 885.508));
  final_trigger = getent("last_cave_room_reached", "targetname");
  final_trigger waittill("trigger");

  autosave_by_name("artillery room");

  objective_string(6, &"PEL1B_OBJECTIVE_EV2_ART_CLEAR");
  final_room = getent("final_room_trigger", "targetname");
  wait(5);
  while(1) {
    cleared = true;
    axis_guys = GetAiArray("axis");
    for(i = 0; i < axis_guys.size; i++) {
      if(axis_guys[i] istouching(final_room)) {
        cleared = false;
      }
    }

    if(cleared) {
      break;
    }

    wait(1);
  }
  objective_state(6, "done");

  thread battlechatter_off("allies");
  thread battlechatter_off("axis");

  objective_add(7, "current", &"PEL1B_OBJECTIVE_FOLLOW_SQUAD", (41063.2, -538.3, 857.6));

  level thread pel1b_outro();
}

objective_monitor_endon(num, endon_str) {
  self endon("stop objective monitor");
  level waittill(endon_str);

  Objective_additionalPosition(num, 0, (0, 0, 0));

  self notify("stop objective monitor");
}

objective_monitor_death(num) {
  self endon("stop objective monitor");
  self waittill("death");

  Objective_additionalPosition(num, 0, (0, 0, 0));

  self notify("stop objective monitor");
}

objective_follow_me(num, endon_str) {
  self thread objective_monitor_endon(num, endon_str);
  self thread objective_monitor_death(num);
}
cave_effects() {
  trigger1 = getent("ev2_start_art_dust", "targetname");
  trigger1 waittill("trigger");
  flag_set("cave_artillery_active");
  level notify("cave_artillery_active");

  level thread cave_dust_fx_loop();

  trigger1 = getent("ev2_stop_art_dust", "targetname");
  trigger1 waittill("trigger");

  flag_clear("cave_artillery_active");
}

cave_dust_fx_loop() {
  level endon("stop_dust_fx");

  setmusicstate("CAVE");

  while(flag("cave_artillery_active")) {
    wait(randomfloat(3) + 3);
    playsoundatposition("mortar_dirt", (41063.2, -538.3, 857.6));

    level thread play_dust_fx_near_players();
  }
}
dialogue_setup() {
  level thread ev2_pacing_dialog();
  level thread ev2_bombing_dialog();
  level thread ev2_wait_for_tank_dialog();
  level thread ev2_tank_move_up_dialog();
  level thread ev2_stay_behind_tank_dialog();
  level thread ev2_enter_tunnel_dialog();
}

say_dialogue(theLine) {
  self.og_animname = self.animname;
  self.animname = "generic";
  self anim_single_solo(self, theLine);
  self.animname = self.og_animname;
}

ev2_pacing_dialog() {
  wait(8);

  level.sarge say_dialogue("good_work");
  level.sarge say_dialogue("move_gully");
  level.walker say_dialogue("watch_trees");
  level.sarge say_dialogue("keep_tight");
}

ev2_bombing_dialog() {
  level waittill("ev2_blow_up_stuff2");
  wait(1);

  level.walker say_dialogue("airforce_know");
  level.sarge say_dialogue("heads_down");
}

ev2_wait_for_tank_dialog() {
  trigger = getent("ev2_plane_strafe_trigger", "targetname");
  trigger waittill("trigger");
  wait(1);

  level.sarge say_dialogue("tanks_cover");
  level.sarge say_dialogue("help_clear");
  level.sarge say_dialogue("stay_cover");
}

ev2_tank_move_up_dialog() {
  level waittill("flametank_started_flaming");

  level.walker say_dialogue("tank_move_up");
  level.sarge say_dialogue("move_with_it");
  level.sarge say_dialogue("go_now");
  level.sarge say_dialogue("stay_with");
}

ev2_stay_behind_tank_dialog() {
  trigger = getent("flametank_middle", "targetname");
  trigger waittill("trigger");

  if(isDefined(level.flametank) && isalive(level.flametank))
    level.sarge say_dialogue("watch_tank");
}

ev2_enter_tunnel_dialog() {
  trigger = getent("cave_entrance", "targetname");
  trigger waittill("trigger");

  level.sarge say_dialogue("take_left");
  level.walker say_dialogue("hear_you");
  level.sarge say_dialogue("this_is_it");
  level.sarge say_dialogue("clear_caves");
}
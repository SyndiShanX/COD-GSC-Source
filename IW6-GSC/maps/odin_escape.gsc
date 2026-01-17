/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\odin_escape.gsc
*****************************************************/

escape_start() {
  maps\odin_util::move_player_to_start_point("start_odin_escape");
  wait 0.1;
  maps\odin_util::actor_teleport(level.ally, "odin_escape_ally_tp");
  level.ally.animname = "odin_ally";
  maps\odin_util::fx_odin_monitor_bink_init();
  thread maps\odin_util::dynamic_object_pusher();
  level.player thread maps\odin::give_weapons();
  common_scripts\utility::flag_set("ally_clear");
  common_scripts\utility::flag_set("ally_out_of_z");
  thread crew_quarters_combat();
  thread maps\odin_audio::sfx_play_alarms();
  thread maps\odin_fx::satellite_rcs_thrusters();
  maps\_utility::delaythread(2, maps\odin_ally::post_z_push);
  wait 1;
  thread maps\odin_util::create_sliding_space_door("z_hall_close_door", 1, 0, 0, 0, "lock_z_hall_close_door", "unlock_z_hall_close_door");
  common_scripts\utility::flag_set("lock_z_hall_close_door");
}

section_precache() {
  precacheitem("odin_rod_missile");
  precachestring(&"ODIN_ADS_TIP");
  precachestring(&"ODIN_ESCAPE_DOOR_PROMPT");
}

section_flag_init() {
  common_scripts\utility::flag_init("escape_clear");
  common_scripts\utility::flag_init("player_open_escape_door");
  common_scripts\utility::flag_init("kyra_push_bag_anim");
  common_scripts\utility::flag_init("window_VO_Done");
  common_scripts\utility::flag_init("remove_window_blocker");
  common_scripts\utility::flag_init("open_second_pod");
  common_scripts\utility::flag_init("escape_blocker_door_trig");
  common_scripts\utility::flag_init("clear_to_tweak_player");
  common_scripts\utility::flag_init("lock_escape_window_auto_door");
  common_scripts\utility::flag_init("unlock_escape_window_auto_door");
  common_scripts\utility::flag_init("lock_z_hall_close_door");
  common_scripts\utility::flag_init("lock_escape_door_blocker");
  common_scripts\utility::flag_init("unlock_escape_door_blocker");
  common_scripts\utility::flag_init("lock_spin_door_blocker");
  common_scripts\utility::flag_init("unlock_spin_door_blocker");
  common_scripts\utility::flag_init("escape_enc_activated");
  common_scripts\utility::flag_init("cq_killer_dead");
  common_scripts\utility::flag_init("enc_movement_token_taken");
  common_scripts\utility::flag_init("esc_combat_done");
  common_scripts\utility::flag_init("ready_to_fire_next_salvo");
  common_scripts\utility::flag_init("fire_rog");
  common_scripts\utility::flag_init("ally_at_console");
  common_scripts\utility::flag_init("ally_console_scene_done");
  common_scripts\utility::flag_init("destruction_sequence_started");
  common_scripts\utility::flag_init("objective_escape_sat");
  common_scripts\utility::flag_init("escape_overlap_dialogue");
}

section_hint_string_init() {
  maps\_utility::add_hint_string("escape_ADS_Hint", &"ODIN_ADS_TIP", ::hints_ads_escape);
  maps\_utility::add_hint_string("escape_door_prompt", &"ODIN_ESCAPE_DOOR_PROMPT", ::hints_ads_escape);
}

hints_ads_escape() {
  if(common_scripts\utility::flag("esc_combat_done") || level.player adsbuttonpressed())
    return 1;
  else
    return 0;
}

escape_main() {
  common_scripts\utility::flag_wait("ally_clear");
  common_scripts\utility::flag_set("unlock_escape_window_auto_door");
  setsaveddvar("ammoCounterHide", "0");
  thread escape_combat_door();
  escape_setup();
  common_scripts\utility::flag_wait("esc_combat_done");
  maps\_utility::autosave_by_name("escape_combat_done");
  crew_quarters_aftermath();
  thread early_decomp_checker();
  ally_console_scene();
  maps\_utility::autosave_by_name("escape_window_done");

  if(!common_scripts\utility::flag("absolute_fire_decompression"))
    destruction_sequence();

  common_scripts\utility::flag_wait_all("escape_clear", "player_exited_escape_hallway");
  escape_cleanup();
}

escape_combat_door() {
  level endon("kyra_got_impatient");
  thread escape_no_push_zone();
  var_0 = maps\_utility::spawn_anim_model("space_square_hatch");
  var_0.targetname = "escape_door_to_open";
  var_1 = getent("player_escape_door_blocker", "targetname");
  var_2 = getent("player_escape_door_blocker_origin", "targetname");
  var_3 = common_scripts\utility::getstruct("kyra_move_node01", "targetname");
  var_3 maps\_anim::anim_first_frame_solo(var_0, "odin_escape_open_door_player");
  var_2 linkto(var_0, "tag_origin");
  var_1 linkto(var_2);
  common_scripts\utility::flag_wait("esc_combat_done");
  common_scripts\utility::flag_clear("clear_to_tweak_player");
  var_0 makeusable();
  var_0 sethintstring(&"ODIN_ESCAPE_DOOR_PROMPT");
  var_0 waittill("trigger");
  thread player_escape_door_open(var_3, var_0);
  var_0 makeunusable();
  common_scripts\utility::flag_wait("player_open_escape_door");
  var_3 maps\_anim::anim_single_solo(var_0, "odin_escape_open_door_player");
  common_scripts\utility::flag_set("clear_to_tweak_player");
  var_1 delete();
  var_2 delete();
}

escape_no_push_zone() {
  level endon("escape_clear");
  wait 1;

  while(!common_scripts\utility::flag("player_open_escape_door")) {
    if(common_scripts\utility::flag("player_at_escape_door"))
      common_scripts\utility::flag_set("no_push_zone");
    else
      common_scripts\utility::flag_clear("no_push_zone");

    wait 0.05;
  }
}

escape_ally_movement_start() {
  level endon("player_opened_escape_door");
  var_0 = common_scripts\utility::getstruct("kyra_move_node01", "targetname");
  thread kyra_escape_move_bags(var_0);
  var_0 notify("stop_loop");
  thread kyra_grabs_escape_gun(var_0);
  var_0 maps\_anim::anim_single_solo(self, "odin_escape_first_encounter_end_ally01");
  var_0 thread maps\_anim::anim_loop_solo(self, "odin_escape_first_encounter_end_loop_ally01", "stop_loop");
  thread maps\odin_util::finale_anim_loop_killer(var_0, "stop_loop");
  ally_wait_to_get_impatient(4.5);
  common_scripts\utility::flag_waitopen("player_at_escape_door");
  level notify("kyra_got_impatient");
  var_0 notify("stop_loop");
  var_1 = getent("escape_door_to_open", "targetname");
  var_1 makeunusable();
  level.ally.escape_bag_push = "odin_escape_zigzag_bag_02";
  common_scripts\utility::flag_set("kyra_push_bag_anim");
  thread maps\odin_util::push_out_of_doorway("X", "<", 1000, 1000);
  var_0 thread maps\_anim::anim_single_solo(var_1, "odin_escape_zigzag_start_door");
  common_scripts\utility::flag_set("clear_to_tweak_player");
  thread maps\odin_audio::sfx_kyra_open_station_door();
  var_0 maps\_anim::anim_single_solo(self, "odin_escape_zigzag_start_ally01");
  thread escape_ally_movement_start_part_2(var_0);
}

escape_ally_movement_start_part_2(var_0) {
  level endon("early_decomp");
  thread maps\odin_spin::prespawn_decomp_crates();
  var_0 notify("stop_loop");
  var_0 thread maps\_anim::anim_loop_solo(self, "odin_escape_zigzag_start_loop_ally01", "stop_loop");
  thread maps\odin_util::finale_anim_loop_killer(var_0, "stop_loop");
  common_scripts\utility::flag_wait("escape_blocker_door_trig");
  var_0 notify("stop_loop");
  var_0 = common_scripts\utility::getstruct("kyra_move_node02", "targetname");
  var_0 maps\_anim::anim_single_solo(self, "odin_escape_zigzag_second_ally01");
  var_0 maps\_anim::anim_single_solo(self, "odin_escape_zigzag_to_spin_ally01");
  var_0 thread maps\_anim::anim_loop_solo(self, "odin_escape_zigzag_to_spin_loop_ally01", "stop_loop");
  thread maps\odin_util::finale_anim_loop_killer(var_0, "stop_loop");
  self setgoalpos(self.origin);
  common_scripts\utility::flag_set("escape_clear");
  self notify("done_with_escape");
  common_scripts\utility::flag_wait("start_near_explosion_sequence");
  var_0 notify("stop_loop");
}

kyra_grabs_escape_gun(var_0) {
  level.ally maps\_utility::gun_remove();
  var_1 = maps\_utility::spawn_anim_model("kyra_gun");
  var_1 attach("weapon_acog_iw6", "tag_acog_2", 1);
  var_1 attach("weapon_barrel_shroud_iw6", "tag_silencer", 1);
  var_0 maps\_anim::anim_single_solo(var_1, "odin_escape_first_encounter_end_tar21");
  var_1 delete();
  level.ally maps\_utility::gun_recall();
}

ally_wait_to_get_impatient(var_0) {
  for(var_1 = 0; var_1 < var_0; var_1++) {
    if(level.ally.origin[0] < level.player.origin[0] - 64) {
      break;
    }

    wait 1;
  }
}

kyra_escape_move_bags(var_0) {
  var_1 = maps\_utility::spawn_anim_model("space_escape_pack");
  var_0 maps\_anim::anim_first_frame_solo(var_1, "odin_escape_zigzag_bag_01");
  common_scripts\utility::flag_wait("kyra_push_bag_anim");
  var_0 maps\_anim::anim_single_solo(var_1, level.ally.escape_bag_push);
}

player_escape_door_open(var_0, var_1) {
  level endon("kyra_got_impatient");
  level notify("player_opened_escape_door");
  var_2 = maps\_utility::spawn_anim_model("player_rig");
  var_2 hide();
  var_0 maps\_anim::anim_first_frame_solo(var_2, "odin_escape_open_door_player");
  var_3 = 0;
  thread maps\odin_audio::sfx_plr_open_station_door();
  level.player disableweapons();
  level.player playerlinktoblend(var_2, "tag_player", 0.5, 0, 0);
  wait 0.5;
  level.player playerlinktodelta(var_2, "tag_player", 1, var_3, var_3, var_3, var_3, 1);
  thread escape_door_anim_player(var_0, var_2);
  var_0 notify("stop_loop");
  level.ally.escape_bag_push = "odin_escape_zigzag_bag_01";
  common_scripts\utility::flag_set("kyra_push_bag_anim");
  var_0 maps\_anim::anim_single_solo(level.ally, "odin_escape_open_door_player");
  level.ally thread escape_ally_movement_start_part_2(var_0);
}

escape_door_anim_player(var_0, var_1) {
  var_2 = maps\_utility::spawn_anim_model("finale_gun");
  var_2.origin = var_1 gettagorigin("tag_weapon");
  var_2.angles = var_1 gettagangles("tag_weapon");
  var_2 linkto(var_1, "tag_weapon");
  var_1 show();
  var_0 maps\_anim::anim_single_solo(var_1, "odin_escape_open_door_player");
  common_scripts\utility::flag_clear("no_push_zone");
  level.player unlink();
  var_2 delete();
  var_1 delete();
  level.player enableweapons();
  wait 1;
}

escape_door_open_rumble(var_0) {
  level.player playrumbleonentity("light_1s");
}

escape_door_open_flag(var_0) {
  common_scripts\utility::flag_set("player_open_escape_door");
}

escape_setup() {
  setsaveddvar("ragdoll_max_life", 90000);
  thread maps\odin_util::floating_corpses("floaters_zigzag_module");
  thread maps\odin_util::create_sliding_space_door("post_z_door", 1.2, 0.1, 0, 0, "lock_post_z_room", "unlock_post_z_room");
  thread maps\odin_util::create_sliding_space_door("escape_window_auto_door", 1.2, 0.1, 0, 0, "lock_escape_window_auto_door", "unlock_escape_window_auto_door");
  thread maps\odin_util::create_sliding_space_door("escape_door_blocker", 1, 0, 0, 0, "lock_escape_door_blocker", "unlock_escape_door_blocker");
  thread maps\odin_util::create_sliding_space_door("spin_door_blocker", 0.75, 0, 0, 0, "lock_spin_door_blocker", "unlock_spin_door_blocker");
  thread escape_blocker_door_lens_cap();
  common_scripts\utility::flag_set("unlock_escape_door_blocker");
  common_scripts\utility::flag_set("unlock_spin_door_blocker");
  thread manage_earth("show");
  var_0 = maps\odin_util::satellite_get_script_mover();
  var_1 = getent("escape_sat_orientation", "targetname");
  var_0 moveto(var_1.origin, 0.1, 0, 0);
  var_0 rotateto(var_1.angles, 0.1, 0, 0);
  wait 0.15;
  thread prepare_odin_for_window_scene();
  level.decomp_door = thread maps\odin_util::create_sliding_space_door("spin_decomp_door", 0.3, 0.1, 0, 0, "lock_decomp_room", "open_decomp_room_door");
}

prepare_odin_for_window_scene() {
  level.odin_animnode maps\_anim::anim_single(level.animated_sat_part, "sat_blossom_close");
  var_0 = [];
  var_1 = [];
  var_2 = [];
  var_0["odin_sat_section_04_pod_doorR_01"] = level.animated_sat_part["odin_sat_section_04_pod_doorR_01"];
  var_2["odin_sat_section_04_pod_doorR_02"] = level.animated_sat_part["odin_sat_section_04_pod_doorR_02"];
  var_1["odin_sat_section_04_pod_doorR_03"] = level.animated_sat_part["odin_sat_section_04_pod_doorR_03"];
  var_0["odin_sat_section_04_pod_doorR_04"] = level.animated_sat_part["odin_sat_section_04_pod_doorR_04"];
  var_0["odin_sat_section_04_pod_doorL_01"] = level.animated_sat_part["odin_sat_section_04_pod_doorL_01"];
  var_2["odin_sat_section_04_pod_doorL_02"] = level.animated_sat_part["odin_sat_section_04_pod_doorL_02"];
  var_1["odin_sat_section_04_pod_doorL_03"] = level.animated_sat_part["odin_sat_section_04_pod_doorL_03"];
  var_0["odin_sat_section_04_pod_doorL_04"] = level.animated_sat_part["odin_sat_section_04_pod_doorL_04"];
  level.odin_animnode maps\_anim::anim_first_frame(var_0, "sat_blossom_open");
  level.odin_animnode maps\_anim::anim_first_frame(var_1, "sat_blossom_open");
  level.odin_animnode maps\_anim::anim_first_frame(var_2, "sat_blossom_open");
  level thread maps\odin_fx::fx_sat_doors_open(var_0);
  level.odin_animnode thread maps\_anim::anim_single(var_0, "sat_blossom_open");
  common_scripts\utility::flag_wait("start_odin_firing_scene");
  level thread maps\odin_fx::fx_sat_doors_open(var_1);
  level.odin_animnode thread maps\_anim::anim_single(var_1, "sat_blossom_open");
  wait 5;
  level thread maps\odin_fx::fx_sat_doors_open(var_2);
  level.odin_animnode thread maps\_anim::anim_single(var_2, "sat_blossom_open");
}

escape_blocker_door_lens_cap() {
  var_0 = getent("escape_door_blocker_lens_cap", "targetname");
  var_1 = getent("escape_door_blocker_lens_cap_origin", "targetname");
  var_2 = var_1.origin;
  var_0 linkto(var_1);
  var_1 moveto((0, 0, 0), 0.1, 0, 0);
  var_0 hide();
  common_scripts\utility::flag_wait("lock_escape_door_blocker");
  var_1 moveto(var_2, 0.1, 0, 0);
  wait 1;
  var_0 show();
}

crew_quarters_combat() {
  level.ally maps\_utility::set_ignoreall(1);
  level.ally maps\_utility::gun_remove();
  level.ally.ignoreme = 1;
  common_scripts\utility::flag_set("unlock_post_z_room");
  crew_quarters_combat_setup();
  level.ally thread move_ally_into_cq();
  wait 1.0;
  thread set_flag_on_player_action("escape_enc_activated");
  crew_quarters_crew_killed();
  common_scripts\utility::flag_wait_all("first_enc_dead", "cq_killer_dead");
  common_scripts\utility::flag_set("esc_combat_done");
  common_scripts\utility::flag_set("kyra_ally_vo_01");
}

create_escape_doors() {}

move_ally_into_cq() {
  maps\_utility::delaythread(3.0, maps\_utility::smart_radio_dialogue, "odin_kyr_budlookouttheres");
  common_scripts\utility::flag_wait("ally_out_of_z");
  var_0 = common_scripts\utility::getstruct("kyra_move_node01", "targetname");
  var_0 maps\_anim::anim_single_solo(self, "odin_escape_first_encounter_ally01");
  var_0 thread maps\_anim::anim_loop_solo(self, "odin_escape_first_encounter_loop_ally01", "stop_loop");
  thread maps\odin_util::finale_anim_loop_killer(var_0, "stop_loop");
}

crew_quarters_crew_killed() {
  var_0 = getent("cq_enc_enemy_killer", "script_noteworthy");
  var_1 = var_0 maps\odin_util::spawn_odin_actor_internal(1);
  var_1 maps\_utility::forceuseweapon(level.player.weapon_interior, "primary");
  var_1 hidepart("tag_silencer");
  var_2 = getent("cq_killed_crew", "targetname");
  var_3 = var_2 maps\odin_util::spawn_odin_actor_internal(1);
  var_3.team = "neutral";
  var_1.ignoreall = 1;
  var_1.animname = "odin_opfor";
  var_1.allowdeath = 1;
  var_1 thread maps\odin_util::odin_drop_weapon();
  var_3.ignoreall = 1;
  var_3.nodeathimpulse = 1;
  var_3.animname = "odin_redshirt";
  var_3 maps\_utility::gun_remove();
  var_4 = common_scripts\utility::getstruct("kyra_move_node01", "targetname");
  var_4 thread maps\_anim::anim_single_solo(var_1, "odin_escape_first_encounter_opfor");
  thread redshirt_cq_enc_handles(var_3, var_4);
  var_4 = getnode("node_cq_enc_middle_middle", "targetname");

  if(isalive(var_1)) {
    var_1.fixednode = 1;
    var_1.ignoreall = 0;
    var_1 setgoalpos(var_1.origin);
    var_1.favoriteenemy = level.player;
  }

  while(isalive(var_1))
    wait 0.01;

  if(isalive(var_3))
    var_3 kill();

  wait 1.5;

  for(var_5 = 0; var_5 < 25; var_5++) {
    physicsexplosionsphere(var_4.origin, 48, 32, 0.1);
    wait 0.05;
  }
}

redshirt_cq_enc_handles(var_0, var_1) {
  var_0 endon("death");
  var_0.forceragdollimmediate = 1;
  var_1 maps\_anim::anim_single_solo(var_0, "odin_escape_first_encounter_redshirt");
  wait 0.1;

  if(isalive(var_0))
    var_0 kill();
}

escape_destruct_boxes(var_0) {
  var_1 = getscriptablearray(var_0, "targetname");

  foreach(var_3 in var_1) {
    wait(randomfloatrange(0.2, 0.6));
    magicbullet("microtar_space_interior+acogsmg_sp+spaceshroud_sp", var_3.origin + (randomfloatrange(1, 2), randomfloatrange(1, 2), randomfloatrange(1, 2)), var_3.origin);
  }
}

crew_quarters_combat_setup() {
  var_0 = getEntArray("cq_enc_enemies", "targetname");
  level.aenemies = [];

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    switch (var_0[var_1].script_noteworthy) {
      case "cq_enc_enemy_00":
        var_0[var_1] maps\_utility::add_spawn_function(::escape_enemy_00_think);
        break;
      case "cq_enc_enemy_01":
        var_0[var_1] maps\_utility::add_spawn_function(::escape_enemy_01_think);
        break;
      case "cq_enc_enemy_02":
        var_0[var_1] maps\_utility::add_spawn_function(::escape_enemy_02_think);
        break;
      case "cq_enc_enemy_03":
        var_0[var_1] maps\_utility::add_spawn_function(::escape_enemy_03_think);
        break;
    }

    level.cq_enemies[var_1] = var_0[var_1] maps\odin_util::spawn_odin_actor_internal(1);
  }
}

cq_room_destruction() {
  level endon("enter_window_scene");
  common_scripts\utility::flag_wait("escape_enc_activated");
  var_0 = getent("escape_crates_damage_check", "targetname");
  var_0 setCanDamage(1);
  var_0 waittill("damage");
  var_1 = getEntArray("cq_dyn_cargo_01_static", "targetname");

  foreach(var_3 in var_1)
  var_3 delete();
}

escape_enemy_setup() {
  self.ignoreall = 1;
  self.moveplaybackrate = 1.0;
  self.goalradius = 16;
  thread maps\odin_util::odin_drop_weapon();
}

cq_combat_movement() {
  self endon("stop_combat");
  self endon("death");
  var_0 = getnodearray("nodes_cq_enc", "script_noteworthy");

  for(;;) {
    wait(randomfloatrange(0.5, 2.5));

    if(common_scripts\utility::flag("enc_movement_token_taken"))
      common_scripts\utility::flag_waitopen_or_timeout("enc_movement_token_taken", 4);

    if(getaicount("axis") == 1) {
      self endon("death");
      self.goalradius = 64;

      for(;;) {
        self setgoalpos(level.player.origin);
        wait 2.0;
      }

      continue;
    }

    var_1 = var_0[randomintrange(0, var_0.size)];
    self.goalradius = 16;

    if(!isnodeoccupied(var_1)) {
      common_scripts\utility::flag_set("enc_movement_token_taken");
      self setgoalnode(var_1);
      self waittill("goal");
      common_scripts\utility::flag_clear("enc_movement_token_taken");
      wait 2.0;
    }
  }

  common_scripts\utility::flag_clear("enc_movement_token_taken");
}

escape_enemy_00_think() {
  self endon("death");
  maps\_utility::gun_remove();
  maps\_utility::forceuseweapon(level.player.weapon_interior, "primary");
  self.fixednode = 1;
  maps\_utility::set_goal_radius(2);
  thread maps\odin_util::npc_physics_pulse();
  escape_enemy_setup();
  common_scripts\utility::flag_wait_or_timeout("escape_enc_activated", 6);
  common_scripts\utility::flag_set("escape_enc_activated");
  wait(randomfloatrange(0.3, 1.0));
  self.ignoreall = 0;
  self.favoriteenemy = level.player;
  var_0 = getnode("node_cq_enc_forward_left", "targetname");
  self setgoalnode(var_0);
  self waittill("goal");
}

escape_enemy_01_think() {
  maps\_utility::gun_remove();
  maps\_utility::forceuseweapon(level.player.weapon_interior, "primary");
  self.fixednode = 1;
  maps\_utility::set_goal_radius(2);
  thread maps\odin_util::npc_physics_pulse();
  escape_enemy_setup();
  common_scripts\utility::flag_wait_or_timeout("escape_enc_activated", 6);
  common_scripts\utility::flag_set("escape_enc_activated");
  wait(randomfloatrange(0.3, 1.0));
  self.ignoreall = 0;
  self.favoriteenemy = level.player;
  var_0 = getnode("node_cq_enc_middle_right", "targetname");
  self setgoalnode(var_0);
  self waittill("goal");
  thread cq_combat_movement();
  self waittill("death");
  common_scripts\utility::flag_clear("enc_movement_token_taken");
  self notify("stop_combat");
}

escape_enemy_02_think() {
  maps\_utility::gun_remove();
  maps\_utility::forceuseweapon(level.player.weapon_interior, "primary");
  thread maps\odin_util::npc_physics_pulse();
  var_0 = getent("cq_killed_crew2", "targetname");
  var_1 = var_0 maps\odin_util::spawn_odin_actor_internal(1);
  var_1.team = "neutral";
  self.ignoreall = 1;
  self.animname = "odin_opfor";
  self.allowdeath = 1;
  var_1.ignoreall = 1;
  var_1.nodeathimpulse = 1;
  var_1.animname = "odin_redshirt";
  var_1 maps\_utility::gun_remove();
  var_2 = common_scripts\utility::getstruct("kyra_move_node01", "targetname");
  var_2 thread maps\_anim::anim_single_solo(self, "odin_escape_first_encounter_opfor02");
  thread redshirt_cq_enc_handles2(var_1, var_2);
  var_2 = getnode("node_cq_enc_middle_right", "targetname");

  if(isalive(self)) {
    self.fixednode = 1;
    self.ignoreall = 0;
    self setgoalnode(var_2);
    thread cq_combat_movement();
    self.favoriteenemy = level.player;
  }

  self.fixednode = 1;
  maps\_utility::set_goal_radius(2);
  escape_enemy_setup();
  thread firing_into_bunks();
  common_scripts\utility::flag_wait_or_timeout("escape_enc_activated", 6);
  common_scripts\utility::flag_set("escape_enc_activated");
  wait(randomfloatrange(0.3, 1.0));
  self.ignoreall = 0;
  self.favoriteenemy = level.player;
  var_3 = getnode("node_cq_enc_middle_right", "targetname");
  self setgoalnode(var_3);
  self waittill("death");
  thread escape_destruct_boxes("esc_fuse_boxes_01_exploder");
  common_scripts\utility::flag_set("trigger_third_guy");
  common_scripts\utility::flag_clear("enc_movement_token_taken");
  self notify("stop_combat");
}

redshirt_cq_enc_handles2(var_0, var_1) {
  var_1 maps\_anim::anim_single_solo(var_0, "odin_escape_first_encounter_redshirt02");
  var_0.forceragdollimmediate = 1;
  wait 0.1;

  if(isalive(var_0))
    var_0 kill();
}

escape_enemy_03_think() {
  self endon("death");
  maps\_utility::gun_remove();
  maps\_utility::forceuseweapon(level.player.weapon_interior, "primary");
  var_0 = level.player.threatbias;
  var_1 = level.ally.threatbias;
  var_2 = getent("thirdGuyTarget", "targetname");
  maps\_utility::set_goal_radius(2);
  self setgoalpos(var_2.origin);
  self.fixednode = 1;
  maps\_utility::magic_bullet_shield();
  maps\_utility::disable_arrivals();
  thread maps\odin_util::odin_drop_weapon();
  thread maps\odin_util::npc_physics_pulse();
  common_scripts\utility::flag_wait_or_timeout("trigger_third_guy", 8);
  thread maps\odin_audio::sfx_phantom_door_close();
  maps\_utility::stop_magic_bullet_shield();
  level.ally.ignoreme = 1;
  var_2 = getnode("third_guy_destination", "targetname");
  self setgoalpos(var_2.origin);
  self.ignoreall = 0;
  self.favoriteenemy = level.ally;
  level.ally.threatbias = 10000;
  self waittill("goal");
  level.player.threatbias = var_0;
  level.ally.threatbias = var_1;
  level.player.ignoreme = 0;
  level.ally.ignoreme = 1;
  self waittill("death");
  thread escape_destruct_boxes("esc_fuse_boxes_02_exploder");
  common_scripts\utility::flag_clear("enc_movement_token_taken");
  self notify("stop_combat");
}

third_enemy_shooting() {
  self endon("death");
  var_0 = gettime();
  var_1 = gettime() - 3000;
  var_2 = getnode("cq_ally_position", "targetname");

  while(var_1 < var_0) {
    var_1 = gettime() - 3000;
    var_3 = randomfloatrange(0.1, 0.5);

    for(var_4 = 0; var_4 < 3; var_4++) {
      if(isalive(self))
        self shoot(1, var_2.origin, 1);
      else
        break;

      wait 0.05;
    }

    wait(var_3);
  }
}

firing_into_bunks() {
  self endon("death");
  level endon("escape_enc_activated");
  self.goalradius = 16;
  self waittill("goal");
  maps\_utility::disable_pain();
  var_0 = getent(self.script_noteworthy + "_aim", "targetname");

  for(var_1 = 0; var_1 < 5; var_1++) {
    magicbullet(self.weapon, self gettagorigin("tag_flash"), var_0.origin);
    wait(randomfloatrange(0.1, 0.5));
  }

  self setgoalpos(self.origin);
}

set_flag_on_player_action(var_0) {
  level endon(var_0);

  if(common_scripts\utility::flag(var_0)) {
    return;
  }
  for(;;) {
    level.player waittill("weapon_fired");
    break;
  }

  common_scripts\utility::flag_set(var_0);
}

crew_quarters_aftermath() {
  level.ally thread escape_ally_movement_start();
  thread escape_dialogue();
  common_scripts\utility::flag_wait("start_odin_firing_scene");
}

escape_dialogue() {
  maps\_utility::smart_radio_dialogue("odin_shq_odinpayload1uploading");

  if(!common_scripts\utility::flag("start_odin_firing_scene"))
    maps\_utility::smart_radio_dialogue("odin_atl_targetinglosangeles");

  wait 0.9;

  if(!common_scripts\utility::flag("start_odin_firing_scene"))
    maps\_utility::smart_radio_dialogue("odin_atl_sandiegolocked");

  wait 1.2;

  if(!common_scripts\utility::flag("start_odin_firing_scene"))
    maps\_utility::smart_radio_dialogue("odin_atl_phoenixlocked");

  wait 0.4;

  if(!common_scripts\utility::flag("start_odin_firing_scene"))
    maps\_utility::smart_radio_dialogue("odin_atl_targetinghouston");

  if(!common_scripts\utility::flag("start_odin_firing_scene"))
    maps\_utility::smart_radio_dialogue("odin_atl_targetingmiami");

  if(!common_scripts\utility::flag("start_odin_firing_scene"))
    maps\_utility::smart_radio_dialogue("odin_shq_odintargetingsolutionsare");

  if(!common_scripts\utility::flag("start_odin_firing_scene"))
    maps\_utility::smart_radio_dialogue("odin_shq_rodfeedengaging");

  if(!common_scripts\utility::flag("start_odin_firing_scene"))
    maps\_utility::smart_radio_dialogue("odin_kyr_budfollowmewe");
}

check_for_escape_dialogue_overlap(var_0) {
  common_scripts\utility::flag_set("escape_overlap_dialogue");
  maps\_utility::smart_radio_dialogue(var_0);
  common_scripts\utility::flag_clear("escape_overlap_dialogue");
}

ally_console_scene() {
  level endon("early_decomp");
  common_scripts\utility::flag_wait("start_odin_firing_scene");
  thread lock_auto_door();
  thread console_scene_player_blocker();
  level.ally play_console_scene();
}

lock_auto_door() {
  level endon("early_decomp");
  common_scripts\utility::flag_wait("escape_blocker_door_trig");
  common_scripts\utility::flag_set("lock_escape_window_auto_door");
}

play_console_scene() {
  level endon("early_decomp");
  thread odin_firing_sequence();
  console_scene_dialogue();
}

ally_dialogue_overlap_check(var_0) {
  if(common_scripts\utility::flag("escape_overlap_dialogue"))
    maps\_utility::smart_radio_dialogue_overlap(var_0);
  else
    maps\_utility::smart_radio_dialogue(var_0);
}

window_vo_01(var_0) {
  ally_dialogue_overlap_check("odin_ast1_ohnoodinis");
}

window_vo_02(var_0) {
  common_scripts\utility::flag_set("open_second_pod");
  ally_dialogue_overlap_check("odin_kyr_theyreuploadingmore");
  common_scripts\utility::flag_set("fire_rog");
}

window_vo_03(var_0) {
  maps\_utility::radio_dialogue_stop();
  maps\_utility::smart_radio_dialogue("odin_ast1_houstonwhatdowe");
}

window_vo_04(var_0) {
  maps\_utility::radio_dialogue_stop();
  maps\_utility::smart_radio_dialogue("odin_ho2_odincontrolwehave");
}

window_vo_05(var_0) {
  maps\_utility::radio_dialogue_stop();
  maps\_utility::smart_radio_dialogue("odin_ho2_imsorrymosley");
}

window_vo_06(var_0) {
  maps\_utility::radio_dialogue_stop();
  maps\_utility::smart_radio_dialogue("odin_ast1_copyhouston");
  common_scripts\utility::flag_set("remove_window_blocker");
}

window_vo_07(var_0) {
  maps\_utility::radio_dialogue_stop();
  thread maps\_utility::smart_radio_dialogue("odin_ho2_initiatingin10seconds_2");
  maps\_utility::smart_radio_dialogue_overlap("odin_kyr_budweneedto_2");
  common_scripts\utility::flag_set("window_VO_Done");
}

console_scene_dialogue() {
  level endon("early_decomp");
  common_scripts\utility::flag_set("fire_rog");
  level notify("player_has_shroud_now");
  check_for_escape_dialogue_overlap("odin_shq_estimatedcasualties112");
  common_scripts\utility::flag_wait("window_VO_Done");
  common_scripts\utility::flag_clear("clear_to_tweak_player");
  common_scripts\utility::flag_set("objective_escape_sat");
  common_scripts\utility::flag_set("ally_console_scene_done");
  thread maps\_utility::smart_radio_dialogue("odin_kyr_comeonbudif");
  common_scripts\utility::flag_set("fire_rog");
  thread maps\odin_audio::sfx_scuttle_pre_decomp();
  wait 2.0;
  maps\_utility::smart_radio_dialogue_overlap("odin_shq_stationdetonationin3");
  common_scripts\utility::flag_set("destruction_sequence_started");
  thread post_window_nag();
}

post_window_nag() {
  level endon("early_decomp");
  level endon("player_exited_escape_hallway");
  var_0 = 4;

  for(;;) {
    wait(var_0);
    maps\_utility::smart_radio_dialogue("odin_kyr_budweneedto_2");
    var_0 = var_0 + 2;

    if(var_0 > 20)
      var_0 = 20;
  }
}

odin_firing_sequence() {
  level endon("player_exited_escape_hallway");
  thread prepare_odin_to_fire();
  thread maps\odin_fx::fx_escape_fire_rods();
  common_scripts\utility::flag_wait("ally_at_console");
  wait 3.0;
}

prepare_odin_to_fire() {
  level endon("player_exited_escape_hallway");
  common_scripts\utility::flag_wait("ready_to_fire_next_salvo");

  for(var_0 = 1; var_0 <= 4; var_0++) {
    common_scripts\utility::exploder("fx_odin_pods_opening_0" + var_0);
    var_1 = getEntArray("odin_pod_panels_0" + var_0, "targetname");

    foreach(var_3 in var_1) {
      var_4 = getent(var_3.target, "targetname");
      var_3 moveto(var_4.origin, randomfloatrange(10, 14), 0.5, 5);
      var_3 rotateto((var_3.angles[0] + randomint(4), var_3.angles[1] + randomint(4), var_3.angles[2] + randomint(4)), 12, 0.5, 10);
    }

    common_scripts\utility::flag_clear("ready_to_fire_next_salvo");
    common_scripts\utility::flag_wait("ready_to_fire_next_salvo");
    wait 0.1;
  }
}

add_dialogue_line_timed(var_0, var_1, var_2, var_3) {
  thread maps\_utility::add_dialogue_line(var_0, var_1, var_2);
  wait(var_3);
}

console_scene_player_blocker() {
  var_0 = getent("console_player_blocker", "targetname");
  common_scripts\utility::flag_wait("remove_window_blocker");
  var_0 delete();
}

destruction_sequence() {
  common_scripts\utility::flag_wait("destruction_sequence_started");
  thread ramping_explosions();
  thread random_ambient_escape_fx();
  thread escape_explosion_player_timeout();
  common_scripts\utility::flag_wait("player_exited_escape_hallway");
}

ramping_explosions() {
  level endon("start_near_explosion_sequence");
  level.play_shake_sound = 1;
  var_0 = 0.02;
  var_1 = 0.1;
  thread maps\odin_audio::sfx_escape_destruction_fire_puffs();
  common_scripts\utility::exploder("escape_destruction");

  if(maps\_utility::is_gen4())
    common_scripts\utility::exploder("escape_destruction_ng");

  thread maps\odin_audio::sfx_scuttle_alarm();

  for(;;) {
    thread maps\odin_audio::sfx_shaking_logic();
    earthquake(randomfloatrange(var_0, var_1), 1.0, level.player.origin, 500);

    if(common_scripts\utility::cointoss())
      level.player playrumbleonentity("light_3s");
    else
      level.player playrumbleonentity("heavy_1s");

    common_scripts\utility::exploder("escape_destruction_random");
    wait(randomfloatrange(0.8, 2.4));
    var_0 = var_0 + 0.05;
    var_1 = var_1 + 0.08;

    if(var_0 > 0.15)
      var_0 = 0.15;

    if(var_1 > 0.35)
      var_1 = 0.35;
  }
}

random_ambient_escape_fx() {
  level endon("player_exited_escape_hallway");
  wait(randomfloatrange(1.2, 2.2));
  common_scripts\utility::exploder("escape_destruction_random");
}

escape_explosion_player_timeout() {
  level endon("odin_start_spin_decomp");
  wait 20;
  var_0 = getEntArray("escape_fail_explosion_FX_Origin", "script_noteworthy");
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;

  foreach(var_5 in var_0) {
    var_1 = randomintrange(-40, 40);
    var_2 = randomintrange(-40, 40);
    var_3 = randomintrange(0, 40);
    var_5.origin = level.player.origin + (var_1, var_2, var_3);
    playFX(common_scripts\utility::getfx("spc_explosion_1200"), var_5.origin);
  }

  level.player playSound("scn_odin_decompression_explode2_ss");
  wait 0.5;

  foreach(var_5 in var_0)
  playFX(common_scripts\utility::getfx("spc_explosion_1200"), var_5.origin);

  wait 0.5;
  level.player kill();
  level notify("new_quote_string");
  setdvar("ui_deadquote", &"ODIN_WINDOW_TIMEOUT");
  maps\_utility::missionfailedwrapper();
}

early_decomp_checker() {
  common_scripts\utility::flag_wait("absolute_fire_decompression");
  level notify("early_decomp");
  level notify("player_exited_escape_hallway");
  level notify("odin_start_spin_decomp");
  level notify("start_near_explosion_sequence");
  common_scripts\utility::flag_set("start_near_explosion_sequence");
  common_scripts\utility::flag_set("player_exited_escape_hallway");
  common_scripts\utility::flag_set("escape_clear");
}

escape_cleanup(var_0) {
  var_1 = getEntArray("space_cover_test", "targetname");

  foreach(var_3 in var_1)
  var_3 delete();

  var_5 = getEntArray("cq_dynamic_objects", "script_noteworthy");

  foreach(var_7 in var_5)
  var_7 delete();
}

manage_earth(var_0) {
  var_1 = getent("fake_earth", "targetname");

  if(!isDefined(var_1)) {
    return;
  }
  switch (var_0) {
    case "hide":
      var_1 hide();
      break;
    case "show":
      var_1 show();
      break;
    case "delete":
      var_1 delete();
      break;
  }
}
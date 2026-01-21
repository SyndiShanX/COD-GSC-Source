/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\enemyhq_intro.gsc
*****************************************************/

enemyhq_intro_pre_load() {
  common_scripts\utility::flag_init("intro_done");
  common_scripts\utility::flag_init("drive_in_done");
  common_scripts\utility::flag_init("drive_start");
  common_scripts\utility::flag_init("FLAG_intro_truck_arrived");
  common_scripts\utility::flag_init("FLAG_spawn_checkpoint_guys");
  common_scripts\utility::flag_init("FLAG_blow_sticky_failsafe");
  common_scripts\utility::flag_init("FLAG_player_bust_windshield");
  common_scripts\utility::flag_init("FLAG_player_gun_up");
  common_scripts\utility::flag_init("FLAG_stop_hit_reactions");
  common_scripts\utility::flag_init("bring_up_clacker");
  common_scripts\utility::flag_init("start_truck_flip_scene");
  common_scripts\utility::flag_init("FLAG_clacked_the_clacker");
  common_scripts\utility::flag_init("FLAG_truck_close_to_bash");
  common_scripts\utility::flag_init("ally1_enter_veh");
  common_scripts\utility::flag_init("ally2_enter_veh");
  common_scripts\utility::flag_init("ally3_enter_veh");
  common_scripts\utility::flag_init("ally4_enter_veh");
  common_scripts\utility::flag_init("ally5_enter_veh");
  common_scripts\utility::flag_init("veh_jolt");
  common_scripts\utility::flag_init("FLAG_keegan_turn_right");
  common_scripts\utility::flag_init("FLAG_keegan_turn_left");
  common_scripts\utility::flag_init("FLAG_truck_exploder_start");
  common_scripts\utility::flag_init("FLAG_blow_sticky_04");
  common_scripts\utility::flag_init("FLAG_drive_in_startpoint");
  common_scripts\utility::flag_init("FLAG_start_pathblockers");
  common_scripts\utility::flag_init("FLAG_dog_bark");
  common_scripts\utility::flag_init("FLAG_dog_bark_truck");
  common_scripts\utility::flag_init("FLAG_player_failcase_road_overrun");
  common_scripts\utility::flag_init("FLAG_player_failcase_road");
  common_scripts\utility::flag_init("FLAG_ehq_give_objective");
  common_scripts\utility::flag_init("FLAG_obj_rescueajax");
  common_scripts\utility::flag_init("obj_rescue_obj");
}

setup_drive_in() {
  level.start_point = "drive_in";
  common_scripts\utility::flag_set("intro_done");
  maps\enemyhq::setup_common();
  waittillframeend;
  spawn_player_truck();
  level.allies[1] thread keegan_enter_veh();
  thread dead_guys_near_truck();
  thread player_failcase_road();
  maps\_utility::battlechatter_off("allies");
  maps\_utility::battlechatter_off("axis");
  common_scripts\utility::flag_set("picked_up_mk32");
  common_scripts\utility::flag_set("FLAG_drive_in_startpoint");
  thread maps\enemyhq_audio::aud_check("drive_in");
  level.dog maps\enemyhq_code::lock_player_control();
  common_scripts\utility::flag_set("merrick_done_lookat");
}

begin_drive_in() {
  thread spawn_checkpoint_guys();
  thread fly_by_01();
  thread obj_getingetajaxgetout();
  thread gold_door_on_player_truck();

  foreach(var_1 in level.allies)
  var_1.alertlevel = "noncombat";

  thread maps\_utility::autosave_now();
  thread get_in_truck_nag_vo();
  thread maps\enemyhq_rooftop_intro::blow_wall();
  thread truck_bash_moment();
  thread truck_flip_moment();
  thread truck_start_driving();
  thread truck_pathblockers();
  thread sticky_grenade_01();
  thread sticky_grenade_02();
  thread sticky_grenade_03();
  thread sticky_grenade_05();
  thread sticky_grenade_06();
  thread sticky_grenade_07();
  thread truck_exploder_start_driving();
  thread drive_in_handle_ps4_ssao();
  setup_allies_vehicle_approach();
  thread maps\enemyhq_code::player_enter_truck_progression(level.player_truck);
  common_scripts\utility::flag_wait("drive_in_done");
}

drive_in_handle_ps4_ssao() {
  if(!level.ps4) {
    return;
  }
  common_scripts\utility::flag_wait("FLAG_player_enter_truck");
  wait 13;
  maps\_art::disable_ssao_over_time(2);
  common_scripts\utility::flag_wait("FLAG_stop_hit_reactions");
  maps\_art::enable_ssao_over_time(2);
}

fly_by_01() {
  var_0 = getent("intro_transport_01", "targetname");
  var_1 = getent("intro_transport_02", "targetname");
  var_2 = getent("intro_transport_01b", "targetname");
  var_3 = getent("intro_transport_02b", "targetname");
  var_4 = getEntArray("flyby_hide_on_load", "script_noteworthy");
  common_scripts\utility::array_call(var_4, ::show);
  var_0 thread intro_transport_mover(65000, 15);
  var_1 thread intro_transport_mover(65000, 15);
  var_2 thread intro_transport_mover(65000, 15);
  var_3 thread intro_transport_mover(65000, 15);
  var_5 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("intro_escort_01");
  var_6 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("intro_escort_02");
  var_7 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("intro_escort_03");
  var_8 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("intro_escort_04");
  var_9 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("intro_escort_05");
  common_scripts\utility::exploder(6877);
}

intro_transport_mover(var_0, var_1) {
  var_2 = anglesToForward(self.angles);
  var_3 = self.origin + var_2 * var_0;
  self moveto(var_3, var_1, 1, 1);
  wait(var_1);
  self delete();
}

get_in_truck_nag_vo() {
  level endon("end_truck_nag");
  common_scripts\utility::flag_wait("FLAG_intro_truck_arrived");
  wait 0.5;
  level.allies[0] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_alrightletsloadup");
  wait 7;
  level.allies[0] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_adammoveit");
  wait 10;
  level.allies[0] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_getinadamlets");
}

dead_guys_near_truck() {
  var_0 = common_scripts\utility::getstruct("dog_scratch_truck", "targetname");
  var_1 = [];
  var_2 = getent("intro_truck_dead_guy1", "targetname");
  var_3 = getent("intro_truck_dead_guy2", "targetname");
  var_2 thread maps\enemyhq_code::corpse_setup(var_0, "truck_enter_dead_body1", "bring_up_clacker");
  var_3 thread maps\enemyhq_code::corpse_setup(var_0, "truck_enter_dead_body2", "bring_up_clacker");
}

gold_door_on_player_truck() {
  common_scripts\utility::flag_wait("FLAG_intro_truck_arrived");
  wait 1;
  level.gold_player_door = spawn("script_model", level.player_truck.origin);
  level.gold_player_door setModel("vehicle_man_7t_front_door_RI_obj");
  level.gold_player_door.angles = level.player_truck.angles;
  level.gold_player_door linkto(level.player_truck);
  common_scripts\utility::flag_wait("FLAG_player_enter_truck");
  maps\_utility::disable_trigger_with_targetname("TRIG_get_in_truck");
  wait 1;
  level.gold_player_door delete();
}

setup_allies_vehicle_approach() {
  foreach(var_1 in level.allies)
  var_1 maps\_utility::enable_ai_color();

  if(level.start_point != "drive_in") {
    thread maps\enemyhq_rooftop_intro::merrick_look_at_flyby();
    maps\enemyhq_code::safe_activate_trigger_with_targetname("TRIG_intro_allies_wait_for_ride");
  }

  var_3 = getnode("ally1node", "targetname");
  var_4 = getnode("ally2node", "targetname");
  var_5 = getnode("ally3node", "targetname");
  var_6 = getnode("ally4node", "targetname");
  var_7 = getnode("ally5node", "targetname");
  level.allies[0].animname = "baker";
  level.allies[1].animname = "keegan";
  level.allies[2].animname = "hesh";
  thread merrick_goto_veh_and_enter(level.allies[0], var_3, "ally1_enter_veh");
  common_scripts\utility::flag_wait("FLAG_intro_truck_arrived");
  level notify("dudes_need_to_load_up");
  thread guy_goto_veh_and_enter(level.allies[2], level.player_truck, var_5, "ally3_enter_veh");
  thread dog_goto_veh_and_enter(level.dog, level.player_truck, "ally5_enter_veh");
}

guy_goto_veh_and_enter(var_0, var_1, var_2, var_3) {
  var_0 setgoalnode(var_2);
  var_0.goalradius = 32;
  var_0 waittill("goal");
  common_scripts\utility::flag_wait("FLAG_player_enter_truck");

  if(var_0.animname == "baker") {
    wait 2;
    var_0 maps\_utility::teleport_ai(var_2);
    var_0 linkto(level.player_truck, "tag_detach");
    var_1 thread maps\_anim::anim_loop_solo(var_0, "enter_truck_loop", "stop_baker_loop", "tag_detach");
  }

  if(var_0.animname == "hesh") {
    wait 2;
    var_0 maps\_utility::teleport_ai(var_2);
    var_0 linkto(level.player_truck, "tag_detach");
    var_1 thread maps\_anim::anim_loop_solo(var_0, "enter_truck_loop", "stop_hesh_loop", "tag_detach");
  }

  common_scripts\utility::flag_set(var_3);
}

merrick_goto_veh_and_enter(var_0, var_1, var_2) {
  common_scripts\utility::flag_wait("merrick_done_lookat");
  var_0 setgoalnode(var_1);
  var_0.goalradius = 32;
  var_0 waittill("goal");
  common_scripts\utility::flag_wait("FLAG_player_enter_truck");
  wait 2;
  var_0 maps\_utility::teleport_ai(var_1);
  var_0 linkto(level.player_truck, "tag_detach");
  level.player_truck thread maps\_anim::anim_loop_solo(var_0, "enter_truck_loop", "stop_baker_loop", "tag_detach");
  common_scripts\utility::flag_set(var_2);
}

keegan_enter_veh() {
  common_scripts\utility::flag_wait("picked_up_mk32");
  self notify("stop_intro_loop");
  level notify("stop_intro_loop");
  maps\_utility::anim_stopanimscripted();
  waittillframeend;
  maps\_utility::gun_remove();
  self linkto(level.player_truck, "tag_driver");
  level.player_truck thread maps\_anim::anim_loop_solo(self, "enter_truck_loop", "stop_keegan_loop", "tag_driver");
  thread truck_starts_up();
  thread keegan_additional_drivein_anims();
  common_scripts\utility::flag_set("ally2_enter_veh");
}

truck_starts_up() {
  common_scripts\utility::flag_wait("FLAG_intro_truck_arrived");
  wait 2;
  level.player_truck maps\_vehicle::vehicle_lights_on("headlightsL");
  level.player_truck maps\_vehicle::vehicle_lights_on("headlightsR");
  thread maps\enemyhq_audio::aud_truck_start();
}

#using_animtree("generic_human");

override_ride_anims() {
  wait 0.1;
  self.vehicle_idle_override = % ehq_truck_enter_loop_keegan;
}

keegan_additional_drivein_anims() {
  level endon("stop_truck_hit_reactions");
  thread keegan_turn_left_anims();
  thread keegan_turn_right_anims();
  common_scripts\utility::flag_wait("bring_up_clacker");
  common_scripts\utility::waitframe();
  thread keegan_turn_right_anims_rush();
  thread keegan_turn_left_anims_rush();
}

#using_animtree("vehicles");

keegan_turn_left_anims() {
  level endon("c4_detonated");

  while(!common_scripts\utility::flag("FLAG_clacked_the_clacker")) {
    common_scripts\utility::flag_wait("FLAG_keegan_turn_left");
    common_scripts\utility::flag_clear("FLAG_keegan_turn_left");
    common_scripts\utility::waitframe();
    level.player_truck notify("stop_keegan_loop");
    level.truck_player_arms thread maps\_anim::anim_single_solo(level.truck_player_arms, "truck_lean_left");
    level.player_truck setanim(%ehq_truck_enter_turn_left_truck);
    level.player_truck maps\_anim::anim_single_solo(self, "truck_turn_left", "tag_driver");
    level.player_truck clearanim(%ehq_truck_enter_turn_left_truck, 0);
    level.player_truck thread maps\_anim::anim_loop_solo(self, "enter_truck_loop", "stop_keegan_loop", "tag_driver");
  }
}

keegan_turn_right_anims() {
  level endon("c4_detonated");

  while(!common_scripts\utility::flag("FLAG_clacked_the_clacker")) {
    common_scripts\utility::flag_wait("FLAG_keegan_turn_right");
    common_scripts\utility::flag_clear("FLAG_keegan_turn_right");
    level.player_truck notify("stop_keegan_loop");
    common_scripts\utility::waitframe();
    level.truck_player_arms thread maps\_anim::anim_single_solo(level.truck_player_arms, "truck_lean_right");
    level.player_truck setanim(%ehq_truck_enter_turn_right_truck);
    level.player_truck maps\_anim::anim_single_solo(self, "truck_turn_right", "tag_driver");
    level.player_truck clearanim(%ehq_truck_enter_turn_right_truck, 0);
    level.player_truck thread maps\_anim::anim_loop_solo(self, "enter_truck_loop", "stop_keegan_loop", "tag_driver");
  }
}

keegan_and_dog_frantic_loops() {
  level.player_truck notify("stop_keegan_loop");
  common_scripts\utility::waitframe();
  level.player_truck thread maps\_anim::anim_loop_solo(level.allies[1], "enter_truck_loop_rush", "stop_keegan_loop", "tag_driver");
  level.player_truck notify("stop_dog_loop");
  common_scripts\utility::waitframe();
  level.player_truck thread maps\_anim::anim_loop_solo(level.dog, "veh_idle_frantic", "stop_dog_loop", "tag_dog");
}

keegan_turn_right_anims_rush() {
  level endon("stop_truck_hit_reactions");

  for(;;) {
    common_scripts\utility::flag_wait("FLAG_keegan_turn_right");
    common_scripts\utility::flag_clear("FLAG_keegan_turn_right");
    level.player_truck notify("stop_keegan_loop");
    common_scripts\utility::waitframe();
    level.truck_player_arms thread maps\_anim::anim_single_solo(level.truck_player_arms, "truck_lean_right");
    level.player_truck setanim(%ehq_truck_enter_turn_right_rush_truck);
    level.player_truck maps\_anim::anim_single_solo(self, "truck_turn_right_rush", "tag_driver");
    level.player_truck clearanim(%ehq_truck_enter_turn_right_rush_truck, 0);
    level.player_truck thread maps\_anim::anim_loop_solo(self, "enter_truck_loop_rush", "stop_keegan_loop", "tag_driver");
  }
}

keegan_turn_left_anims_rush() {
  level endon("stop_truck_hit_reactions");

  for(;;) {
    common_scripts\utility::flag_wait("FLAG_keegan_turn_left");
    common_scripts\utility::flag_clear("FLAG_keegan_turn_left");
    level.player_truck notify("stop_keegan_loop");
    common_scripts\utility::waitframe();
    level.truck_player_arms thread maps\_anim::anim_single_solo(level.truck_player_arms, "truck_lean_left");
    level.player_truck setanim(%ehq_truck_enter_turn_left_rush_truck);
    level.player_truck maps\_anim::anim_single_solo(self, "truck_turn_left_rush", "tag_driver");
    level.player_truck clearanim(%ehq_truck_enter_turn_left_rush_truck, 0);
    level.player_truck thread maps\_anim::anim_loop_solo(self, "enter_truck_loop_rush", "stop_keegan_loop", "tag_driver");
  }
}

vehicle_play_scripted_single_anim(var_0) {
  var_1 = getanimlength(level.scr_anim[self.animname][var_0]);
  thread maps\_anim::anim_single_solo(self, var_0);
  wait(var_1 - 0.1);
  maps\_anim::anim_set_rate_single(self, var_0, 0);
}

vehicle_play_scripted_loop_anim(var_0) {
  var_1 = getanimlength(level.scr_anim[self.animname][var_0]);
  thread maps\_anim::anim_single_solo(self, var_0);
  wait(var_1 - 0.1);
  maps\_anim::anim_set_rate_single(self, var_0, 0);
}

dog_goto_veh_and_enter(var_0, var_1, var_2) {
  var_0 thread dog_scratch_and_path();
  common_scripts\utility::flag_wait("FLAG_player_enter_truck");
  var_1 maps\_anim::anim_single_solo(var_0, "enter_truck", "tag_dog");
  var_0 linkto(level.player_truck, "tag_dog");
  var_1 thread maps\_anim::anim_loop_solo(var_0, "veh_idle", "stop_dog_loop", "tag_dog");
  common_scripts\utility::flag_set(var_2);
}

dog_scratch_and_path() {
  level endon("end_truck_nag");
  level.dog maps\_utility::disable_ai_color();
  level.dog maps\enemyhq_code::set_dog_scripted_mode(level.player);
  var_0 = common_scripts\utility::getstruct("dog_scratch_truck", "targetname");
  var_0 maps\_anim::anim_reach_solo(self, "found_door");
  self playSound("anml_dog_whine");
  thread maps\enemyhq_audio::aud_dog_scratch();
  var_0 maps\_anim::anim_single_solo(self, "found_door");
  var_1 = getnode("intro_dog_teleport", "targetname");
  self setgoalnode(var_1);
}

dog_additional_drivein_anims() {
  level endon("stop_truck_hit_reactions");
  thread stop_vehicle_hit_reactions();

  while(!common_scripts\utility::flag("FLAG_stop_hit_reactions")) {
    level.player_truck waittill("veh_jolt", var_0);
    level.player_truck notify("stop_dog_loop");
    level.player_truck maps\_anim::anim_single_solo(self, "truck_smash", "tag_dog");
    level.player_truck thread maps\_anim::anim_loop_solo(self, "veh_idle_frantic", "stop_dog_loop", "tag_dog");
  }
}

dog_bark_anims() {
  level.player_truck notify("stop_dog_loop");
  level.player_truck maps\_anim::anim_single_solo(level.dog, "dog_bark_truck", "tag_dog");
  level.player_truck thread maps\_anim::anim_loop_solo(level.dog, "veh_idle_frantic", "stop_dog_loop", "tag_dog");
}

stop_vehicle_hit_reactions() {
  common_scripts\utility::flag_wait("FLAG_stop_hit_reactions");
  level notify("stop_truck_hit_reactions");
}

truck_start_driving() {
  ehq_intro_flag_wait_all("ally1_enter_veh", "ally2_enter_veh", "ally3_enter_veh", "ally5_enter_veh", "FLAG_player_enter_truck");
  thread maps\enemyhq_audio::aud_truck_drive();
  wait 1;
  level.player_truck.dontunloadonend = 1;
  common_scripts\utility::flag_set("drive_start");
  maps\_utility::stop_exploder(5150);
  maps\_utility::stop_exploder(5600);
  common_scripts\utility::exploder(5700);
  level.player enabledeathshield(1);
  thread drive_in_vo();
  var_0 = getvehiclenode("drive_start_path", "targetname");
  level.player_truck thread maps\_vehicle::vehicle_paths(var_0);
  level.player_truck startpath(var_0);
  level.player_truck thread handle_phys_debris();
}

vehicle_drive_shake() {
  level endon("stop_vehicle_shake_loop");

  for(;;) {
    screenshake(level.player.origin, 0.4, 0.5, 0, 0.3, 0, 0.2, 0, 4, 30, 30, 32);
    wait 0.2;
  }
}

handle_phys_debris() {
  common_scripts\utility::flag_wait("FLAG_VO_hang_on_again");
  maps\_utility::delaythread(4, common_scripts\utility::flag_clear, "FLAG_VO_hang_on_again");
  var_0 = [];
  var_1 = [];
  var_0[0] = vectornormalize((100, 0, 60));
  var_1[0] = 28000;
  var_0[1] = vectornormalize((150, 0, 20));
  var_1[1] = 42000;
  var_0[2] = vectornormalize((80, 0, 80));
  var_1[2] = 20000;
  wait 0.2;

  while(common_scripts\utility::flag("FLAG_VO_hang_on_again")) {
    var_2 = (275, randomintrange(-60, -10), 30);
    var_3 = var_0[0];
    var_4 = var_1[0];
    maps\enemyhq_code::physics_fountain("ehq_seat_dyn", self, var_2, var_3, 0, 4, 1, var_4);
    var_2 = (275, 0, 30);
    var_3 = var_0[1];
    var_4 = var_1[1];
    maps\enemyhq_code::physics_fountain("ehq_seat_dyn", self, var_2, var_3, 0, 4, 1, var_4);
    var_2 = (275, randomintrange(10, 60), 30);
    var_3 = var_0[2];
    var_4 = var_1[2];
    maps\enemyhq_code::physics_fountain("ehq_seat_dyn", self, var_2, var_3, 0, 4, 1, var_4);
    wait 0.25;
  }
}

vehicle_loop_anim() {
  self setflaggedanimrestart("vehicle_anim_flag", maps\_utility::getanim("truck_loop"));
  wait 12;
  self clearanim(maps\_utility::getanim("truck_loop"), 0);
}

drive_in_vo() {
  thread clacker_vo_failsafe();
  wait 1.5;
  level.allies[0] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_herestheplanget");
  common_scripts\utility::flag_set("FLAG_ehq_give_objective");
  wait 1;
  level.allies[0] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_wellhitemat");
  wait 2;
  level.allies[0] thread maps\enemyhq_code::char_dialog_add_and_go("enemyhq_kgn_approachinggate");
  wait 1;
  thread maps\enemyhq_code::play_rumble_seconds("damage_light", 3);
  common_scripts\utility::flag_wait("bring_up_clacker");
  level.allies[0] thread maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_alrightadamclackit");
  common_scripts\utility::flag_wait("FLAG_player_gun_up");
  level.allies[0] thread maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_weaponsfree");
  common_scripts\utility::flag_wait("FLAG_VO_cut_off1");
  level.allies[0] thread maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_detour");
  common_scripts\utility::flag_wait("FLAG_VO_cut_off2");
  thread maps\enemyhq_audio::aud_bumpy_ride();
  level.allies[0] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_theyareboxingus");
  level.allies[0] thread maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_holdon");
}

clacker_vo_failsafe() {
  level endon("c4_detonated");
  common_scripts\utility::flag_wait("FLAG_blow_sticky_02");
  level.allies[1] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_loganblowitnow");
}

player_failcase_road() {
  thread player_failcase_road_overrun();
  level endon("end_truck_nag");
  var_0 = [];
  var_0[0] = "enemyhq_mrk_logangetbackhere";
  var_0[1] = "enemyhq_mrk_whereareyougoing";

  for(;;) {
    common_scripts\utility::flag_wait("FLAG_player_failcase_road");
    var_1 = 0;

    while(common_scripts\utility::flag("FLAG_player_failcase_road")) {
      if(var_1 > var_0.size - 1) {
        setdvar("ui_deadquote", &"ENEMY_HQ_YOU_LEFT_YOUR_TEAM_BEHIND");
        maps\_utility::missionfailedwrapper();
        break;
      }

      level.allies[0] maps\enemyhq_code::char_dialog_add_and_go(var_0[var_1]);
      var_1++;
      wait(randomfloatrange(2, 4));
    }
  }
}

player_failcase_road_overrun() {
  level endon("end_truck_nag");
  common_scripts\utility::flag_wait("FLAG_player_failcase_road_overrun");
  setdvar("ui_deadquote", &"ENEMY_HQ_YOU_LEFT_YOUR_TEAM_BEHIND");
  maps\_utility::missionfailedwrapper();
}

spawn_trucks() {
  level.convoy_veh_01 = maps\_vehicle::spawn_vehicle_from_targetname("convoy_veh_01");
  level.convoy_veh_01a = maps\_vehicle::spawn_vehicle_from_targetname("convoy_veh_01a");
  level.convoy_veh_02 = maps\_vehicle::spawn_vehicle_from_targetname("convoy_veh_02");
  level.convoy_veh_03 = maps\_vehicle::spawn_vehicle_from_targetname("convoy_veh_03");
  level.convoy_veh_03a = maps\_vehicle::spawn_vehicle_from_targetname("convoy_veh_03a");
  level.convoy_veh_05 = maps\_vehicle::spawn_vehicle_from_targetname("convoy_veh_05");
  level.convoy_veh_07 = maps\_vehicle::spawn_vehicle_from_targetname("convoy_veh_07");
}

spawn_player_truck() {
  level.player_truck = maps\_vehicle::spawn_vehicle_from_targetname("player_truck");

  if(level.start_point == "intro" || level.start_point == "introshoot" || level.start_point == "drive_in")
    thread handle_truck_windshield_break();
}

handle_truck_windshield_break() {
  level.truck_broke_glass = getent("mdl_truck_broken_glass", "targetname");
  level.truck_broke_glass notsolid();
  level.truck_broke_glass linkto(level.player_truck, "tag_window_front_right");
  level.truck_broke_glass hide();
  common_scripts\utility::flag_wait("FLAG_truck_bash");
  level.truck_broke_glass show();
}

spawn_checkpoint_guys() {
  common_scripts\utility::flag_wait("FLAG_spawn_checkpoint_guys");
  var_0 = maps\enemyhq_code::array_spawn_targetname_allow_fail("intro_checkpoint_guys");
  level.truck_bash_guys = maps\enemyhq_code::array_spawn_targetname_allow_fail("intro_checkpoint_guys_truck_bash");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.animation)) {
      var_2 maps\_utility::gun_remove();
      var_2 thread maps\_anim::anim_generic_loop(var_2, var_2.animation);
    }
  }

  var_4 = [];
  var_4[0] = "drivein_react1";
  var_4[1] = "drivein_react2";
  var_4[2] = "drivein_react3";
  common_scripts\utility::flag_wait("FLAG_blow_sticky_01");
  wait 0.1;

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isalive(var_2)) {
      var_2 maps\_utility::gun_recall();
      var_2 notify("stop_loop");
      var_2 maps\_utility::anim_stopanimscripted();
      var_6 = var_4[randomint(var_4.size)];
      var_2.animname = "generic";
      var_2 thread maps\_anim::anim_generic(var_2, var_6);
      var_2 thread ignoreall_false_end_anim();
    }
  }
}

ignoreall_false_end_anim() {
  self waittillmatch("anim single", "end");
  self.ignoreall = 0;
}

truck_exploder_start_driving() {
  common_scripts\utility::flag_wait("FLAG_truck_exploder_start");
  var_0 = maps\_utility::get_ai_group_ai("field_chaos1_guys");

  foreach(var_2 in var_0)
  var_2 delete();
}

truck_pathblockers() {
  common_scripts\utility::flag_wait("FLAG_start_pathblockers");
  var_0 = maps\enemyhq_code::array_spawn_targetname_allow_fail("field_guys7");
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("convoy_veh_pathblocker_2b");
  wait 2;
  var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("convoy_veh_pathblocker_3");
}

sticky_grenade_01() {
  common_scripts\utility::flag_wait("FLAG_blow_sticky_01");
  thread maps\enemyhq_audio::aud_blow_vehicle_low(level.convoy_veh_01);
  level.allies[1] thread maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_detonating");
  level.player thread maps\_c4::remove_detonator();
  var_0 = common_scripts\utility::getstruct("convoy_veh_01_exp", "targetname");
  var_1 = common_scripts\utility::getstruct("convoy_veh_02_exp", "targetname");
  physicsexplosionsphere(var_1.origin, 50, 40, 85);
  radiusdamage(level.convoy_veh_01a.origin, 50, 4000, 1000, level.player, "MOD_EXPLOSIVE");
  playFXOnTag(level._effect["vfx_fire_truck"], level.convoy_veh_01a, "tag_origin");
  level.player disableweapons();
  wait 1;
  physicsexplosionsphere(var_0.origin, 50, 40, 85);
  radiusdamage(level.convoy_veh_01.origin, 50, 4000, 1000, level.player, "MOD_EXPLOSIVE");
  thread maps\enemyhq_audio::aud_blow_vehicle_low(level.convoy_veh_01);
  playFXOnTag(level._effect["vfx_fire_truck"], level.convoy_veh_01, "tag_origin");
  wait 0.25;
  thread keegan_and_dog_frantic_loops();
}

sticky_grenade_02() {
  common_scripts\utility::flag_wait("FLAG_blow_sticky_02");
  common_scripts\utility::flag_wait("FLAG_clacked_the_clacker");
  var_0 = getent("convoy_veh_02_blow_spot", "targetname");

  foreach(var_2 in level.truck_bash_guys)
  var_2 kill();

  var_4 = getent("truck_bash_jeep", "targetname");
  thread maps\enemyhq_audio::aud_blow_vehicle_low(var_4);
  var_5 = var_4.origin;
  var_4 dodamage(9999, var_5);
  radiusdamage(var_4.origin, 30, 4000, 1000, level.player, "MOD_EXPLOSIVE");
  playFX(level._effect["vfx_ehq_lynxexplode"], var_4.origin);
  playFXOnTag(level._effect["vfx_lynx_fire"], var_4, "tag_origin");
  common_scripts\utility::exploder(356);
  var_4 setModel("vehicle_iveco_lynx_destroyed_iw6");

  if(!common_scripts\utility::flag("FLAG_truck_close_to_bash")) {
    var_4.animname = "intro_jeep_ram";
    var_4 useanimtree(level.scr_animtree[var_4.animname]);
    var_0 thread maps\_anim::anim_single_solo(var_4, "jeep_ram_long");
  } else {
    var_4.animname = "intro_jeep_ram";
    var_4 useanimtree(level.scr_animtree[var_4.animname]);
    var_0 thread maps\_anim::anim_single_solo(var_4, "jeep_ram_short");
  }

  var_6 = maps\enemyhq_code::array_spawn_targetname_allow_fail("field_guys1");
  maps\_utility::stop_exploder(9090);
  maps\_utility::stop_exploder(8010);
}

truck_flip_moment() {
  var_0 = common_scripts\utility::getstruct("truck_flip_blocker", "targetname");
  common_scripts\utility::flag_wait("bring_up_clacker");
  var_1 = maps\_utility::spawn_anim_model("flip_light_prop", var_0.origin);
  var_2 = maps\_utility::spawn_anim_model("flip_light", var_0.origin);
  var_2 linkto(var_1, "J_prop_1");
  var_1.animname = "flip_light_prop";
  var_0 maps\_anim::anim_first_frame_solo(var_1, "jeep_flip");
  common_scripts\utility::flag_wait("start_truck_flip_scene");
  wait 0.3;
  var_3 = getent("flip_jeep", "targetname");
  var_3 maps\_utility::assign_animtree("drive_jeep_flip");
  thread maps\enemyhq_audio::aud_blow_vehicle(var_3);
  var_4 = var_3.origin;
  var_3 dodamage(9999, var_4);
  radiusdamage(var_3.origin, 750, 4000, 1000, level.player, "MOD_EXPLOSIVE");
  playFX(level._effect["vfx_ehq_lynxexplode"], var_3.origin);
  playFXOnTag(level._effect["vfx_lynx_crash"], var_3, "tag_origin");
  playFXOnTag(level._effect["vfx_ehq_sparks_light"], var_1, "j_prop_2");
  common_scripts\utility::exploder(98);
  common_scripts\utility::exploder(99);
  thread stop_lynx_fx(var_3);
  var_3 setModel("vehicle_iveco_lynx_destroyed_iw6");
  var_5 = [];
  var_5[0] = var_1;
  var_5[1] = var_3;
  thread maps\enemyhq_audio::aud_jeep_flip();
  var_0 maps\_anim::anim_single(var_5, "jeep_flip");
}

stop_lynx_fx(var_0) {
  common_scripts\utility::flag_wait("FLAG_stop_hit_reactions");
  stopFXOnTag(level._effect["vfx_lynx_crash"], var_0, "tag_origin");
}

truck_bash_moment() {
  common_scripts\utility::flag_wait("FLAG_truck_bash");

  if(common_scripts\utility::flag("FLAG_clacked_the_clacker")) {
    thread maps\enemyhq_code::screen_shake_vehicles();
    thread maps\enemyhq_code::reaction_anims();
    var_0 = getent("convoy_veh_02_blow_spot", "targetname");
    var_1 = getent("truck_bash_jeep", "targetname");
    var_1.animname = "intro_jeep_ram";
    var_1 useanimtree(level.scr_animtree[var_1.animname]);
    var_0 thread maps\_anim::anim_single_solo(var_1, "jeep_ram");
    level.player_truck thread maps\enemyhq_code::listen_player_jolt_jumps();
    wait 1;
    common_scripts\utility::flag_set("FLAG_player_bust_windshield");
  } else {
    thread maps\enemyhq_code::screen_shake_vehicles();
    thread maps\enemyhq_code::reaction_anims();
    var_0 = getent("convoy_veh_02_blow_spot", "targetname");
    var_1 = getent("truck_bash_jeep", "targetname");
    var_1.animname = "intro_jeep_ram";
    var_1 useanimtree(level.scr_animtree[var_1.animname]);
    var_0 thread maps\_anim::anim_single_solo(var_1, "jeep_ram");
    setdvar("ui_deadquote", &"ENEMY_HQ_YOU_FAILED_TO_CREATE");
    common_scripts\utility::flag_set("FLAG_clacked_the_clacker");
    maps\_utility::missionfailedwrapper();
  }
}

silent_magic_bullet_windshield() {
  var_0 = getent("drivein_magic_bullet_start", "targetname");
  magicbullet("nosound_magicbullet", var_0.origin, level.player.origin);
  wait 0.125;
  magicbullet("nosound_magicbullet", var_0.origin, level.player.origin);
  wait 0.125;
  magicbullet("nosound_magicbullet", var_0.origin, level.player.origin);
  wait 0.125;
}

sticky_grenade_03() {
  common_scripts\utility::flag_wait("FLAG_blow_sticky_03");
  thread maps\enemyhq_audio::aud_blow_vehicle(level.convoy_veh_03);
  var_0 = level.convoy_veh_03.origin;
  var_1 = common_scripts\utility::getstruct("convoy_veh_03_exp", "targetname");
  var_2 = common_scripts\utility::getstruct("convoy_veh_03b_exp", "targetname");
  radiusdamage(level.convoy_veh_03.origin, 350, 4000, 1000, level.player, "MOD_EXPLOSIVE");
  physicsexplosionsphere(var_1.origin, 300, 250, 34);
  common_scripts\utility::exploder(357);
  common_scripts\utility::exploder(31);
  wait 0.85;
  thread common_scripts\utility::play_sound_in_space("car_explode", var_2.origin);
  radiusdamage(var_2.origin, 25, 1000, 100, level.player, "MOD_EXPLOSIVE");
  physicsexplosionsphere(var_2.origin, 30, 20, 15);
  common_scripts\utility::exploder(32);
  wait 2;
  var_3 = level.convoy_veh_03a.origin;
  level.convoy_veh_03a dodamage(9999, var_3);
  radiusdamage(level.convoy_veh_03a.origin, 350, 4000, 1000, level.player, "MOD_EXPLOSIVE");
}

sticky_grenade_04() {
  common_scripts\utility::flag_wait("FLAG_blow_sticky_04");
  thread maps\enemyhq_audio::aud_blow_vehicle(level.convoy_veh_04);
  var_0 = level.convoy_veh_04.origin;
  level.convoy_veh_04 dodamage(9999, var_0);
  radiusdamage(level.convoy_veh_04.origin, 350, 4000, 1000, level.player, "MOD_EXPLOSIVE");
}

sticky_grenade_05() {
  common_scripts\utility::flag_wait("FLAG_blow_sticky_05");
  thread maps\enemyhq_audio::aud_blow_vehicle(level.convoy_veh_05);
  var_0 = level.convoy_veh_05.origin;
  level.convoy_veh_05 dodamage(9999, var_0);
  radiusdamage(level.convoy_veh_05.origin, 350, 4000, 1000, level.player, "MOD_EXPLOSIVE");
  playFXOnTag(level._effect["vfx_fire_truck_05"], level.convoy_veh_05, "tag_origin");
  common_scripts\utility::exploder(99);
  maps\_utility::stop_exploder(356);
  maps\_utility::stop_exploder(357);
  maps\_utility::stop_exploder(31);
  maps\_utility::stop_exploder(32);
  thread stop_truck_05_fx(level.convoy_veh_05);
  var_1 = maps\enemyhq_code::array_spawn_targetname_allow_fail("field_guys6");
  var_2 = maps\enemyhq_code::array_spawn_targetname_allow_fail("field_guys6_ignore");

  foreach(var_4 in var_2)
  var_4.ignoreall = 1;
}

stop_truck_05_fx(var_0) {
  common_scripts\utility::flag_wait("FLAG_stop_hit_reactions");
  stopFXOnTag(level._effect["vfx_fire_truck_05"], var_0, "tag_origin");
  maps\_utility::stop_exploder(99);
  maps\_utility::stop_exploder(5700);
}

sticky_grenade_06() {
  common_scripts\utility::flag_wait("FLAG_blow_sticky_06");
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("convoy_veh_pathblocker_2");
}

sticky_grenade_07() {
  common_scripts\utility::flag_wait("FLAG_blow_sticky_07");
  thread maps\enemyhq_audio::aud_blow_vehicle(level.convoy_veh_07);
  var_0 = level.convoy_veh_07.origin;
  level.convoy_veh_07 dodamage(9999, var_0);
  var_1 = common_scripts\utility::getstruct("convoy_veh_07_exp", "targetname");
  physicsexplosionsphere(var_1.origin, 300, 250, 100);
  radiusdamage(level.convoy_veh_07.origin, 350, 4000, 1000, level.player, "MOD_EXPLOSIVE");
}

ehq_intro_flag_wait_all(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_0))
    common_scripts\utility::flag_wait(var_0);

  if(isDefined(var_1))
    common_scripts\utility::flag_wait(var_1);

  if(isDefined(var_2))
    common_scripts\utility::flag_wait(var_2);

  if(isDefined(var_3))
    common_scripts\utility::flag_wait(var_3);

  if(isDefined(var_4))
    common_scripts\utility::flag_wait(var_4);

  if(isDefined(var_5))
    common_scripts\utility::flag_wait(var_5);
}

obj_getingetajaxgetout() {
  common_scripts\utility::flag_wait("FLAG_ehq_give_objective");
  level.rescueajax = maps\_utility::obj("rescueajax");
  objective_add(level.rescueajax, "active", &"ENEMY_HQ_RESCUE_AJAX");
  objective_current(level.rescueajax);
  common_scripts\utility::flag_wait("obj_rescue_obj");
  maps\_utility::objective_complete(level.rescueajax);
}

hesh_intro_line(var_0) {
  var_0 maps\enemyhq_code::char_dialog_add_and_go("enemyhq_hsh_convoyincoming");
}
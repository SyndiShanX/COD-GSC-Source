/*********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\stpetersburg\stpetersburg_vig_script_gauntlet.gsc
*********************************************************************/

gauntlet_vig_init() {
  scripts\engine\utility::flag_init("flag_actual_hit");
  scripts\engine\utility::flag_init("flag_test");
  scripts\engine\utility::flag_init("flag_gauntlet_civs_scatter");
  scripts\engine\utility::flag_init("flag_gauntlet_start_civs");
  scripts\engine\utility::flag_init("flag_gauntlet_player_in_van");
}

gauntlet_vig_start() {
  thread butcher_hit_timing_handler();
  thread gauntlet_vig_civ_1();
  thread gauntlet_vig_civ_2();
  thread gauntlet_vig_civ_3();
  thread gauntlet_vig_civ_4();
  thread gauntlet_vig_civ_5();
  thread gauntlet_vig_civ_6();
  thread gauntlet_vig_civ_7();
  thread gauntlet_vig_civ_8();
  thread gauntlet_background_fakecivs();
}

gauntlet_vig_civ_1() {
  var_0 = scripts\engine\utility::getStruct("gauntlet_vig_civ_1_struct", "targetname");
  var_1 = scripts\engine\sp\utility::spawn_targetname("gauntlet_vig_civ_1", 1);
  var_1 thread gauntlet_civ_setup();
  var_1.animname = "generic";
  var_1 scripts\engine\sp\utility::set_allowdeath(1);
  var_1 endon("death");
  var_1 endon("entitydeleted");
  waitframe();
  var_0 scripts\common\anim::anim_single_solo_run(var_1, "lon_pic_010_civ20_standoff");
  var_1 scripts\common\anim::anim_single_solo_run(var_1, "civ_casual_run_exit_2");
  var_1 scripts\asm\asm_bb::bb_setcivilianstate("panic");
  var_1 scripts\engine\sp\utility::set_goal_radius(32);
  var_2 = getnode("gauntlet_vig_civ_1_node", "targetname");
  var_1 scripts\engine\sp\utility::set_goal_node(var_2);
  wait 1;
  scripts\engine\utility::waittill_any_ents(level, "flag_gauntlet_complete", self, "goal");
  var_1 delete();
}

gauntlet_vig_civ_2() {
  var_0 = scripts\engine\utility::getStruct("gauntlet_vig_civ_2_struct", "targetname");
  var_1 = scripts\engine\sp\utility::spawn_targetname("gauntlet_vig_civ_2", 1);
  var_1 thread gauntlet_civ_setup();
  var_1.animname = "generic";
  var_1 scripts\engine\sp\utility::set_allowdeath(1);
  var_1 endon("death");
  var_1 endon("entitydeleted");
  waitframe();
  var_0 thread scripts\common\anim::anim_loop_solo(var_1, "lon_pic_010_civ36_idle", "gauntlet_civ_2_end_loop");
  scripts\engine\utility::flag_wait("flag_gauntlet_enforcer_van_hit");
  var_0 notify("gauntlet_civ_2_end_loop");
  var_0 scripts\common\anim::anim_single_solo_run(var_1, "lon_pic_010_civ36_standoff");
  var_1 scripts\common\anim::anim_single_solo_run(var_1, "civ_casual_run_exit_2");
  var_1 scripts\engine\sp\utility::set_goal_radius(32);
  var_2 = getnode("gauntlet_vig_civ_2_node", "targetname");
  var_1 scripts\engine\sp\utility::set_goal_node(var_2);
  wait 1;
  scripts\engine\utility::waittill_any_ents(level, "flag_gauntlet_complete", self, "goal");
  var_1 delete();
}

gauntlet_vig_civ_3() {
  var_0 = scripts\engine\utility::getStruct("gauntlet_vig_civ_3_struct", "targetname");
  var_1 = scripts\engine\sp\utility::spawn_targetname("gauntlet_vig_civ_3", 1);
  var_1 thread gauntlet_civ_setup();
  var_1.animname = "generic";
  var_1 scripts\engine\sp\utility::set_allowdeath(1);
  var_1 endon("death");
  var_1 endon("entitydeleted");
  waitframe();
  var_0 scripts\common\anim::anim_first_frame_solo(var_1, "stp_can_020_street_civs_flee_civ01");
  scripts\engine\utility::flag_wait("flag_gauntlet_enforcer_hit_vig");
  var_0 scripts\common\anim::anim_single_solo_run(var_1, "stp_can_020_street_civs_flee_civ01");
  var_1 scripts\engine\sp\utility::set_goal_radius(32);
  var_2 = getnode("gauntlet_vig_civ_3_node", "targetname");
  var_1 scripts\engine\sp\utility::set_goal_node(var_2);
  wait 1;
  scripts\engine\utility::waittill_any_ents(level, "flag_gauntlet_complete", self, "goal");
  var_1 delete();
}

gauntlet_vig_civ_4() {
  var_0 = scripts\engine\utility::getStruct("gauntlet_vig_civ_4_struct", "targetname");
  var_1 = scripts\engine\sp\utility::spawn_targetname("gauntlet_vig_civ_4", 1);
  var_1 thread gauntlet_civ_setup();
  var_1.animname = "generic";
  var_1 scripts\engine\sp\utility::set_allowdeath(1);
  var_1 endon("death");
  var_1 endon("entitydeleted");
  waitframe();
  var_0 scripts\common\anim::anim_single_solo(var_1, "lon_pic_010_civ01_standoff");
  var_1 scripts\asm\asm_bb::bb_setcivilianstate("panic");
  var_1 scripts\common\anim::anim_single_solo_run(var_1, "civ_casual_run_exit_2");
  var_1 scripts\engine\sp\utility::set_goal_radius(32);
  var_2 = getnode("gauntlet_vig_civ_4_node", "targetname");
  var_1 scripts\engine\sp\utility::set_goal_node(var_2);
  wait 1;
  scripts\engine\utility::waittill_any_ents(level, "flag_gauntlet_complete", self, "goal");
  var_1 delete();
}

gauntlet_vig_civ_5() {
  var_0 = scripts\engine\utility::getStruct("gauntlet_vig_civ_5a_struct", "targetname");
  var_1 = scripts\engine\utility::getStruct("gauntlet_vig_civ_5b_struct", "targetname");
  var_2 = scripts\engine\sp\utility::spawn_targetname("gauntlet_vig_civ_5", 1);
  var_2 thread gauntlet_civ_setup();
  var_2.animname = "generic";
  var_2 scripts\engine\sp\utility::set_allowdeath(1);
  var_2 endon("death");
  var_2 endon("entitydeleted");
  waitframe();
  var_0 thread scripts\common\anim::anim_loop_solo(var_2, "sh_022_marketplace_idle_civ02", "gauntlet_civ_5_end_loop");
  scripts\engine\utility::flag_wait("flag_gauntlet_enforcer_hit_vig");
  var_0 notify("gauntlet_civ_5_end_loop");
  var_0 scripts\common\anim::anim_single_solo(var_2, "sh_022_marketplace_react_coward_civ02");
  var_2 scripts\asm\asm_bb::bb_setcivilianstate("panic");
  var_2 scripts\common\anim::anim_single_solo_run(var_2, "civ_stl_exposed_stand_fast_exit_2");
  var_1 scripts\sp\anim::anim_reach_solo(var_2, "hf_grnd_red_civ_run_turn_r_6_trip");
  var_1 scripts\common\anim::anim_single_solo_run(var_2, "hf_grnd_red_civ_run_turn_r_6_trip");
  var_2 scripts\engine\sp\utility::set_goal_radius(32);
  var_3 = getnode("gauntlet_vig_civ_5_node", "targetname");
  var_2 scripts\engine\sp\utility::set_goal_node(var_3);
  wait 1;
  scripts\engine\utility::waittill_any_ents(level, "flag_gauntlet_complete", self, "goal");
  var_2 delete();
}

gauntlet_vig_civ_6() {
  var_0 = scripts\engine\utility::getStruct("gauntlet_vig_civ_6_struct", "targetname");
  var_1 = scripts\engine\sp\utility::spawn_targetname("gauntlet_vig_civ_6", 1);
  var_1 thread gauntlet_civ_setup();
  var_1.animname = "generic";
  var_1 scripts\engine\sp\utility::set_allowdeath(1);
  var_1 endon("death");
  var_1 endon("entitydeleted");
  waitframe();
  var_1 thread gauntlet_vig_civ_react_handler(var_0, "lon_pic_010_civ04_standoff");
  var_1 thread gauntlet_vig_civ_prox_handler();
  var_1 scripts\engine\utility::waittill_any("react_done", "player_near");
  var_1 scripts\engine\sp\utility::anim_stopanimScripted();
  var_1 scripts\asm\asm_bb::bb_setcivilianstate("panic");
  var_1 scripts\common\anim::anim_single_solo_run(var_1, "civ_casual_run_exit_2");
  var_1 scripts\engine\sp\utility::set_goal_radius(32);
  var_2 = getnode("gauntlet_vig_civ_6_node", "targetname");
  var_1 scripts\engine\sp\utility::set_goal_node(var_2);
  wait 1;
  scripts\engine\utility::waittill_any_ents(level, "flag_gauntlet_complete", self, "goal");
  var_1 delete();
}

gauntlet_vig_civ_react_handler(var_0, var_1) {
  self endon("death");
  self endon("entitydeleted");
  var_0 scripts\common\anim::anim_single_solo(self, var_1);
  self notify("react_done");
}

gauntlet_vig_civ_prox_handler() {
  self endon("death");
  self endon("entitydeleted");

  for(;;) {
    waitframe();

    if(scripts\engine\sp\utility::players_within_distance(400, self.origin)) {
      self notify("player_near");
      return;
    }
  }
}

gauntlet_vig_civ_7() {
  var_0 = scripts\engine\sp\utility::spawn_targetname("gauntlet_vig_civ_7", 1);
  var_0 thread gauntlet_civ_setup();
  var_0.animname = "generic";
  var_0 scripts\engine\sp\utility::set_allowdeath(1);
  var_0 endon("death");
  var_0 endon("entitydeleted");
  waitframe();
  var_0 scripts\engine\sp\utility::set_goal_radius(32);
  var_1 = getnode("gauntlet_vig_civ_7_node", "targetname");
  var_0 scripts\engine\sp\utility::set_goal_node(var_1);
  wait 1;
  scripts\engine\utility::waittill_any_ents(level, "flag_gauntlet_complete", self, "goal");
  var_0 delete();
}

gauntlet_vig_civ_8() {
  var_0 = scripts\engine\utility::getStruct("gauntlet_vig_civ_8_struct", "targetname");
  var_1 = scripts\engine\sp\utility::spawn_targetname("gauntlet_vig_civ_8", 1);
  var_1 thread gauntlet_civ_setup();
  var_1.animname = "generic";
  var_1 scripts\engine\sp\utility::set_allowdeath(1);
  var_1 endon("death");
  var_1 endon("entitydeleted");
  waitframe();
  var_0 thread scripts\common\anim::anim_loop_solo(var_1, "lon_pic_010_civ08_idle", "gauntlet_civ_8_end_loop");
  scripts\engine\utility::flag_wait("flag_gauntlet_enforcer_hit_vig");
  var_0 notify("gauntlet_civ_8_end_loop");
  var_0 scripts\common\anim::anim_single_solo_run(var_1, "lon_pic_010_civ08_standoff");
  var_1 scripts\common\anim::anim_single_solo_run(var_1, "civ_stl_exposed_stand_fast_exit_3");
  var_1 scripts\asm\asm_bb::bb_setcivilianstate("panic");
  var_1 scripts\engine\sp\utility::set_goal_radius(32);
  var_2 = getnode("gauntlet_vig_civ_8_node", "targetname");
  var_1 scripts\engine\sp\utility::set_goal_node(var_2);
  wait 1;
  scripts\engine\utility::waittill_any_ents(level, "flag_gauntlet_complete", self, "goal");
  var_1 delete();
}

walking_vig_handler() {
  var_0 = scripts\engine\utility::getStruct("civ_gauntlet_react_1_struct", "targetname");
  var_1 = scripts\engine\sp\utility::spawn_targetname("civ_gauntlet_react_1", 1);
  var_1 thread gauntlet_civ_setup();
  var_1.animname = "generic";
  var_1 scripts\engine\sp\utility::set_allowdeath(1);
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_0 scripts\common\anim::anim_first_frame_solo(var_1, "piccadilly_aftermath_civ_03");
  scripts\engine\utility::flag_wait("flag_gauntlet_start_civs");
  var_0 thread scripts\common\anim::anim_single_solo(var_1, "piccadilly_aftermath_civ_03");
  scripts\engine\utility::flag_wait("flag_actual_hit");
  var_1 scripts\engine\sp\utility::anim_stopanimScripted();
  wait 0.1;
  var_1 scripts\asm\asm_bb::bb_setcivilianstate("panic");
  var_1 scripts\asm\asm_bb::bb_civilianrequestspeed(180);
  var_1 scripts\engine\sp\utility::set_goal_radius(64);
  var_1 scripts\sp\spawner::go_to_node(scripts\engine\utility::getStruct("male_walker_1_path", "targetname"));
  var_2 = scripts\engine\utility::getStruct("male_walker_1_turn", "targetname");
  var_2 scripts\sp\anim::anim_reach_solo(var_1, "hf_grnd_red_civ_run_turn_r_6_trip");
  var_2 scripts\common\anim::anim_single_solo_run(var_1, "hf_grnd_red_civ_run_turn_r_6_trip");
  var_1 scripts\engine\sp\utility::set_goal_node(getnode("male_walker_1_goal", "targetname"));
  var_1 thread delete_off_screen(4);
}

woman_hiding_handler() {
  var_0 = scripts\engine\sp\utility::spawn_targetname("civ_gauntlet_react_2", 1);
  var_0 thread gauntlet_civ_setup();
  var_0 scripts\engine\sp\utility::set_allowdeath(1);
  var_0 endon("death");
  var_0 endon("entitydeleted");
  scripts\engine\utility::flag_wait("flag_gauntlet_start_civs");
  var_1 = getEnt("woman_stop_look_goal", "targetname");
  var_0 setgoalvolumeauto(var_1);
  var_0 scripts\asm\asm_bb::bb_setcivilianstate("casual");
  var_0 scripts\asm\asm_bb::bb_civilianrequestspeed(60);
  scripts\engine\utility::flag_wait("flag_actual_hit");
  var_0 scripts\asm\asm_bb::bb_setcivilianstate("panic");
  scripts\engine\utility::flag_wait("flag_gauntlet_civs_scatter");
  var_1 = getEnt("final_goal_left", "targetname");
  var_0 setgoalvolumeauto(var_1);
  var_0 scripts\asm\asm_bb::bb_civilianrequestspeed(175);
  var_0 thread delete_off_screen(4);
}

shocked_vig_handler() {
  var_0 = getspawner("civ_gauntlet_react_3", "targetname");
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1.animname = "generic";
  var_1 scripts\engine\sp\utility::set_allowdeath(1);
  var_1 endon("death");
  var_1 endon("entitydeleted");
  scripts\engine\utility::flag_wait("flag_gauntlet_start_civs");
  var_1 thread scripts\common\anim::anim_loop_solo(var_1, "hf_grnd_red_civ_hide_shellshock06", "stop_loop");
  scripts\engine\utility::flag_wait("flag_gauntlet_civs_scatter");
  wait 0.5;
  var_1 notify("stop_loop");
  var_1 scripts\engine\sp\utility::anim_stopanimScripted();
  var_2 = getEnt("final_goal_right", "targetname");
  var_1 setgoalvolumeauto(var_2);
  var_1 scripts\asm\asm_bb::bb_setcivilianstate("panic");
  var_1 scripts\asm\asm_bb::bb_civilianrequestspeed(190);
  var_1 thread delete_off_screen(4);
}

woman_ground_handler() {
  var_0 = getspawner("civ_gauntlet_react_5", "targetname");
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1.animname = "generic";
  var_1 scripts\engine\sp\utility::set_allowdeath(1);
  var_1 endon("death");
  var_1 endon("entitydeleted");
  scripts\engine\utility::flag_wait("flag_gauntlet_start_civs");
  var_2 = scripts\engine\utility::getStruct("civ_gauntlet_react_5_struct", "targetname");
  var_2 thread scripts\common\anim::anim_loop_solo(var_1, "stp_apt_hall_blockers_stand_idle_civ02", "stop_loop");
  scripts\engine\utility::flag_wait("flag_actual_hit");
  var_1 scripts\asm\asm_bb::bb_setcivilianstate("panic");
  var_1 scripts\asm\asm_bb::bb_civilianrequestspeed(160);
  var_2 notify("stop_loop");
  var_1 scripts\engine\sp\utility::anim_stopanimScripted();
  scripts\engine\utility::flag_wait("flag_gauntlet_civs_scatter");
  wait 1.5;
  var_3 = getEnt("male_shocked_3_goal", "targetname");
  var_1 setgoalvolumeauto(var_3);
  waitframe();
  var_4 = getEnt("final_goal_right", "targetname");
  var_1 setgoalvolumeauto(var_4);
  var_1 thread delete_off_screen(5);
}

butcher_hit_timing_handler() {
  waitframe();
  scripts\engine\utility::flag_wait("flag_gauntlet_enforcer_van_hit");
  wait 1;
  scripts\engine\utility::flag_set("flag_actual_hit");
  wait 0.5;
  scripts\engine\utility::flag_set("flag_gauntlet_civs_scatter");
}

look_at_until(var_0, var_1) {
  self endon("death");
  self endon("entitydeleted");

  if(!isDefined(var_0)) {
    return;
  }
  self setlookatentity(var_0);

  if(isDefined(var_1)) {
    scripts\engine\utility::flag_wait(var_1);
    self setlookatentity();
  }
}

delete_off_screen(var_0) {
  if(isDefined(var_0))
    wait(var_0);

  var_1 = cos(60);

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    if(!scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self.origin, var_1)) {
      if(isDefined(self)) {
        self delete();
        return;
      }
    }

    wait 0.25;
  }
}

gauntlet_background_fakecivs() {
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::background_fakeciv_setup("gauntlet_bg_fakeciv_idle1", "flag_actual_hit", "flag_gauntlet_player_in_van");
}

gauntlet_civ_setup() {
  self endon("death");
  self endon("entitydeleted");
  scripts\engine\sp\utility::set_ignoreme(1);
  self.dontavoidplayer = 0;
  self.script_pushable = 1;
  self enableavoidance(1);
  self.doavoidanceblocking = 1;
  self.dontchangepushplayer = 1;
  self pushplayer(0);
  self.disableplayeradsloscheck = 1;
  self notify("stop_civ_stationary_ff_penalty");
  thread scripts\sp\utility::civilianfailwrapper(undefined, undefined, 1500);
  scripts\engine\utility::flag_wait_either("flag_gauntlet_player_in_van", "flag_gauntlet_enemies_spawn");
  self notify("stop_civilian_fail_wrapper");
}
/*****************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\stpetersburg\stpetersburg_vig_script_gauntlet.gsc
*****************************************************************************/

function gauntlet_vig_init() {
  scripts\engine\utility::flag_init("flag_actual_hit");
  scripts\engine\utility::flag_init("flag_test");
  scripts\engine\utility::flag_init("flag_gauntlet_civs_scatter");
  scripts\engine\utility::flag_init("flag_gauntlet_start_civs");
  scripts\engine\utility::flag_init("flag_gauntlet_player_in_van");
}

function gauntlet_vig_start() {
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

function gauntlet_vig_civ_1() {
  var0 = scripts\engine\utility::getStruct("gauntlet_vig_civ_1_struct", "targetname");
  var1 = scripts\engine\sp\utility::spawn_targetname("gauntlet_vig_civ_1", 1);
  thread gauntlet_civ_setup();
  var1.animname = "generic";
  var1 scripts\engine\sp\utility::set_allowdeath(1);
  var1 endon("death");
  var1 endon("entitydeleted");
  waitframe();
  var0 scripts\common\anim::anim_single_solo_run(var1, "lon_pic_010_civ20_standoff");
  var1 scripts\common\anim::anim_single_solo_run(var1, "civ_casual_run_exit_2");
  var1 scripts\asm\asm_bb::bb_setcivilianstate("panic");
  var1 scripts\engine\sp\utility::set_goal_radius(32);
  var2 = getnode("gauntlet_vig_civ_1_node", "targetname");
  var1 scripts\engine\sp\utility::set_goal_node(var2);
  wait 1;
  scripts\engine\utility::waittill_any_ents(level, "flag_gauntlet_complete", self, "goal");
  var1 delete();
}

function gauntlet_vig_civ_2() {
  var0 = scripts\engine\utility::getStruct("gauntlet_vig_civ_2_struct", "targetname");
  var1 = scripts\engine\sp\utility::spawn_targetname("gauntlet_vig_civ_2", 1);
  thread gauntlet_civ_setup();
  var1.animname = "generic";
  var1 scripts\engine\sp\utility::set_allowdeath(1);
  var1 endon("death");
  var1 endon("entitydeleted");
  waitframe();
  var0 thread scripts\common\anim::anim_loop_solo(var1, "lon_pic_010_civ36_idle", "gauntlet_civ_2_end_loop");
  scripts\engine\utility::flag_wait("flag_gauntlet_enforcer_van_hit");
  var0 notify("gauntlet_civ_2_end_loop");
  var0 scripts\common\anim::anim_single_solo_run(var1, "lon_pic_010_civ36_standoff");
  var1 scripts\common\anim::anim_single_solo_run(var1, "civ_casual_run_exit_2");
  var1 scripts\engine\sp\utility::set_goal_radius(32);
  var2 = getnode("gauntlet_vig_civ_2_node", "targetname");
  var1 scripts\engine\sp\utility::set_goal_node(var2);
  wait 1;
  scripts\engine\utility::waittill_any_ents(level, "flag_gauntlet_complete", self, "goal");
  var1 delete();
}

function gauntlet_vig_civ_3() {
  var0 = scripts\engine\utility::getStruct("gauntlet_vig_civ_3_struct", "targetname");
  var1 = scripts\engine\sp\utility::spawn_targetname("gauntlet_vig_civ_3", 1);
  thread gauntlet_civ_setup();
  var1.animname = "generic";
  var1 scripts\engine\sp\utility::set_allowdeath(1);
  var1 endon("death");
  var1 endon("entitydeleted");
  waitframe();
  var0 scripts\common\anim::anim_first_frame_solo(var1, "stp_can_020_street_civs_flee_civ01");
  scripts\engine\utility::flag_wait("flag_gauntlet_enforcer_hit_vig");
  var0 scripts\common\anim::anim_single_solo_run(var1, "stp_can_020_street_civs_flee_civ01");
  var1 scripts\engine\sp\utility::set_goal_radius(32);
  var2 = getnode("gauntlet_vig_civ_3_node", "targetname");
  var1 scripts\engine\sp\utility::set_goal_node(var2);
  wait 1;
  scripts\engine\utility::waittill_any_ents(level, "flag_gauntlet_complete", self, "goal");
  var1 delete();
}

function gauntlet_vig_civ_4() {
  var0 = scripts\engine\utility::getStruct("gauntlet_vig_civ_4_struct", "targetname");
  var1 = scripts\engine\sp\utility::spawn_targetname("gauntlet_vig_civ_4", 1);
  thread gauntlet_civ_setup();
  var1.animname = "generic";
  var1 scripts\engine\sp\utility::set_allowdeath(1);
  var1 endon("death");
  var1 endon("entitydeleted");
  waitframe();
  var0 scripts\common\anim::anim_single_solo(var1, "lon_pic_010_civ01_standoff");
  var1 scripts\asm\asm_bb::bb_setcivilianstate("panic");
  var1 scripts\common\anim::anim_single_solo_run(var1, "civ_casual_run_exit_2");
  var1 scripts\engine\sp\utility::set_goal_radius(32);
  var2 = getnode("gauntlet_vig_civ_4_node", "targetname");
  var1 scripts\engine\sp\utility::set_goal_node(var2);
  wait 1;
  scripts\engine\utility::waittill_any_ents(level, "flag_gauntlet_complete", self, "goal");
  var1 delete();
}

function gauntlet_vig_civ_5() {
  var0 = scripts\engine\utility::getStruct("gauntlet_vig_civ_5a_struct", "targetname");
  var1 = scripts\engine\utility::getStruct("gauntlet_vig_civ_5b_struct", "targetname");
  var2 = scripts\engine\sp\utility::spawn_targetname("gauntlet_vig_civ_5", 1);
  thread gauntlet_civ_setup();
  var2.animname = "generic";
  var2 scripts\engine\sp\utility::set_allowdeath(1);
  var2 endon("death");
  var2 endon("entitydeleted");
  waitframe();
  var0 thread scripts\common\anim::anim_loop_solo(var2, "sh_022_marketplace_idle_civ02", "gauntlet_civ_5_end_loop");
  scripts\engine\utility::flag_wait("flag_gauntlet_enforcer_hit_vig");
  var0 notify("gauntlet_civ_5_end_loop");
  var0 scripts\common\anim::anim_single_solo(var2, "sh_022_marketplace_react_coward_civ02");
  var2 scripts\asm\asm_bb::bb_setcivilianstate("panic");
  var2 scripts\common\anim::anim_single_solo_run(var2, "civ_stl_exposed_stand_fast_exit_2");
  var1 scripts\sp\anim::anim_reach_solo(var2, "hf_grnd_red_civ_run_turn_r_6_trip");
  var1 scripts\common\anim::anim_single_solo_run(var2, "hf_grnd_red_civ_run_turn_r_6_trip");
  var2 scripts\engine\sp\utility::set_goal_radius(32);
  var3 = getnode("gauntlet_vig_civ_5_node", "targetname");
  var2 scripts\engine\sp\utility::set_goal_node(var3);
  wait 1;
  scripts\engine\utility::waittill_any_ents(level, "flag_gauntlet_complete", self, "goal");
  var2 delete();
}

function gauntlet_vig_civ_6() {
  var0 = scripts\engine\utility::getStruct("gauntlet_vig_civ_6_struct", "targetname");
  var1 = scripts\engine\sp\utility::spawn_targetname("gauntlet_vig_civ_6", 1);
  thread gauntlet_civ_setup();
  var1.animname = "generic";
  var1 scripts\engine\sp\utility::set_allowdeath(1);
  var1 endon("death");
  var1 endon("entitydeleted");
  waitframe();
  thread gauntlet_vig_civ_react_handler(var1, var0);
  thread gauntlet_vig_civ_prox_handler();
  var1 scripts\engine\utility::waittill_any("react_done", "player_near");
  var1 scripts\engine\sp\utility::anim_stopanimScripted();
  var1 scripts\asm\asm_bb::bb_setcivilianstate("panic");
  var1 scripts\common\anim::anim_single_solo_run(var1, "civ_casual_run_exit_2");
  var1 scripts\engine\sp\utility::set_goal_radius(32);
  var2 = getnode("gauntlet_vig_civ_6_node", "targetname");
  var1 scripts\engine\sp\utility::set_goal_node(var2);
  wait 1;
  scripts\engine\utility::waittill_any_ents(level, "flag_gauntlet_complete", self, "goal");
  var1 delete();
}

function gauntlet_vig_civ_react_handler(var0, var1) {
  self endon("death");
  self endon("entitydeleted");
  var0 scripts\common\anim::anim_single_solo(self, var1);
  self notify("react_done");
}

function gauntlet_vig_civ_prox_handler() {
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

function gauntlet_vig_civ_7() {
  var0 = scripts\engine\sp\utility::spawn_targetname("gauntlet_vig_civ_7", 1);
  thread gauntlet_civ_setup();
  var0.animname = "generic";
  var0 scripts\engine\sp\utility::set_allowdeath(1);
  var0 endon("death");
  var0 endon("entitydeleted");
  waitframe();
  var0 scripts\engine\sp\utility::set_goal_radius(32);
  var1 = getnode("gauntlet_vig_civ_7_node", "targetname");
  var0 scripts\engine\sp\utility::set_goal_node(var1);
  wait 1;
  scripts\engine\utility::waittill_any_ents(level, "flag_gauntlet_complete", self, "goal");
  var0 delete();
}

function gauntlet_vig_civ_8() {
  var0 = scripts\engine\utility::getStruct("gauntlet_vig_civ_8_struct", "targetname");
  var1 = scripts\engine\sp\utility::spawn_targetname("gauntlet_vig_civ_8", 1);
  thread gauntlet_civ_setup();
  var1.animname = "generic";
  var1 scripts\engine\sp\utility::set_allowdeath(1);
  var1 endon("death");
  var1 endon("entitydeleted");
  waitframe();
  var0 thread scripts\common\anim::anim_loop_solo(var1, "lon_pic_010_civ08_idle", "gauntlet_civ_8_end_loop");
  scripts\engine\utility::flag_wait("flag_gauntlet_enforcer_hit_vig");
  var0 notify("gauntlet_civ_8_end_loop");
  var0 scripts\common\anim::anim_single_solo_run(var1, "lon_pic_010_civ08_standoff");
  var1 scripts\common\anim::anim_single_solo_run(var1, "civ_stl_exposed_stand_fast_exit_3");
  var1 scripts\asm\asm_bb::bb_setcivilianstate("panic");
  var1 scripts\engine\sp\utility::set_goal_radius(32);
  var2 = getnode("gauntlet_vig_civ_8_node", "targetname");
  var1 scripts\engine\sp\utility::set_goal_node(var2);
  wait 1;
  scripts\engine\utility::waittill_any_ents(level, "flag_gauntlet_complete", self, "goal");
  var1 delete();
}

function walking_vig_handler() {
  var0 = scripts\engine\utility::getStruct("civ_gauntlet_react_1_struct", "targetname");
  var1 = scripts\engine\sp\utility::spawn_targetname("civ_gauntlet_react_1", 1);
  thread gauntlet_civ_setup();
  var1.animname = "generic";
  var1 scripts\engine\sp\utility::set_allowdeath(1);
  var1 endon("death");
  var1 endon("entitydeleted");
  var0 scripts\common\anim::anim_first_frame_solo(var1, "piccadilly_aftermath_civ_03");
  scripts\engine\utility::flag_wait("flag_gauntlet_start_civs");
  var0 thread scripts\common\anim::anim_single_solo(var1, "piccadilly_aftermath_civ_03");
  scripts\engine\utility::flag_wait("flag_actual_hit");
  var1 scripts\engine\sp\utility::anim_stopanimScripted();
  wait 0.1;
  var1 scripts\asm\asm_bb::bb_setcivilianstate("panic");
  var1 scripts\asm\asm_bb::bb_civilianrequestspeed(180);
  var1 scripts\engine\sp\utility::set_goal_radius(64);
  var1 scripts\sp\spawner::go_to_node(scripts\engine\utility::getStruct("male_walker_1_path", "targetname"));
  var2 = scripts\engine\utility::getStruct("male_walker_1_turn", "targetname");
  var2 scripts\sp\anim::anim_reach_solo(var1, "hf_grnd_red_civ_run_turn_r_6_trip");
  var2 scripts\common\anim::anim_single_solo_run(var1, "hf_grnd_red_civ_run_turn_r_6_trip");
  var1 scripts\engine\sp\utility::set_goal_node(getnode("male_walker_1_goal", "targetname"));
  thread delete_off_screen(var1);
}

function woman_hiding_handler() {
  var0 = scripts\engine\sp\utility::spawn_targetname("civ_gauntlet_react_2", 1);
  thread gauntlet_civ_setup();
  var0 scripts\engine\sp\utility::set_allowdeath(1);
  var0 endon("death");
  var0 endon("entitydeleted");
  scripts\engine\utility::flag_wait("flag_gauntlet_start_civs");
  var1 = getEnt("woman_stop_look_goal", "targetname");
  var0 setgoalvolumeauto(var1);
  var0 scripts\asm\asm_bb::bb_setcivilianstate("casual");
  var0 scripts\asm\asm_bb::bb_civilianrequestspeed(60);
  scripts\engine\utility::flag_wait("flag_actual_hit");
  var0 scripts\asm\asm_bb::bb_setcivilianstate("panic");
  scripts\engine\utility::flag_wait("flag_gauntlet_civs_scatter");
  var1 = getEnt("final_goal_left", "targetname");
  var0 setgoalvolumeauto(var1);
  var0 scripts\asm\asm_bb::bb_civilianrequestspeed(175);
  thread delete_off_screen(var0);
}

function shocked_vig_handler() {
  var0 = getspawner("civ_gauntlet_react_3", "targetname");
  var1 = var0 scripts\engine\sp\utility::spawn_ai(1);
  var1.animname = "generic";
  var1 scripts\engine\sp\utility::set_allowdeath(1);
  var1 endon("death");
  var1 endon("entitydeleted");
  scripts\engine\utility::flag_wait("flag_gauntlet_start_civs");
  var1 thread scripts\common\anim::anim_loop_solo(var1, "hf_grnd_red_civ_hide_shellshock06", "stop_loop");
  scripts\engine\utility::flag_wait("flag_gauntlet_civs_scatter");
  wait 0.5;
  var1 notify("stop_loop");
  var1 scripts\engine\sp\utility::anim_stopanimScripted();
  var2 = getEnt("final_goal_right", "targetname");
  var1 setgoalvolumeauto(var2);
  var1 scripts\asm\asm_bb::bb_setcivilianstate("panic");
  var1 scripts\asm\asm_bb::bb_civilianrequestspeed(190);
  thread delete_off_screen(var1);
}

function woman_ground_handler() {
  var0 = getspawner("civ_gauntlet_react_5", "targetname");
  var1 = var0 scripts\engine\sp\utility::spawn_ai(1);
  var1.animname = "generic";
  var1 scripts\engine\sp\utility::set_allowdeath(1);
  var1 endon("death");
  var1 endon("entitydeleted");
  scripts\engine\utility::flag_wait("flag_gauntlet_start_civs");
  var2 = scripts\engine\utility::getStruct("civ_gauntlet_react_5_struct", "targetname");
  var2 thread scripts\common\anim::anim_loop_solo(var1, "stp_apt_hall_blockers_stand_idle_civ02", "stop_loop");
  scripts\engine\utility::flag_wait("flag_actual_hit");
  var1 scripts\asm\asm_bb::bb_setcivilianstate("panic");
  var1 scripts\asm\asm_bb::bb_civilianrequestspeed(160);
  var2 notify("stop_loop");
  var1 scripts\engine\sp\utility::anim_stopanimScripted();
  scripts\engine\utility::flag_wait("flag_gauntlet_civs_scatter");
  wait 1.5;
  var3 = getEnt("male_shocked_3_goal", "targetname");
  var1 setgoalvolumeauto(var3);
  waitframe();
  var4 = getEnt("final_goal_right", "targetname");
  var1 setgoalvolumeauto(var4);
  thread delete_off_screen(var1);
}

function butcher_hit_timing_handler() {
  waitframe();
  scripts\engine\utility::flag_wait("flag_gauntlet_enforcer_van_hit");
  wait 1;
  scripts\engine\utility::flag_set("flag_actual_hit");
  wait 0.5;
  scripts\engine\utility::flag_set("flag_gauntlet_civs_scatter");
}

function look_at_until(var0, var1) {
  self endon("death");
  self endon("entitydeleted");

  if(!isDefined(var0)) {
    return;
  }

  self setlookatentity(var0);

  if(isDefined(var1)) {
    scripts\engine\utility::flag_wait(var1);
    self setlookatentity();
    return;
  }
}

function delete_off_screen(var0) {
  if(isDefined(var0)) {
    wait var0;
  }

  var1 = cos(60);

  for(;;) {
    if(!isDefined(self)) {
      return;
    }

    if(!scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self.origin, var1)) {
      if(isDefined(self)) {
        self delete();
        return;
      }
    }

    wait 0.25;
  }
}

function gauntlet_background_fakecivs() {
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::background_fakeciv_setup("gauntlet_bg_fakeciv_idle1", "flag_actual_hit", "flag_gauntlet_player_in_van");
}

function gauntlet_civ_setup() {
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
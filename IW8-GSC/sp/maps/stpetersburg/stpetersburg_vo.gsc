/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\stpetersburg\stpetersburg_vo.gsc
****************************************************/

vo_stakeout_intro() {}

vo_stakeout_choose_weapon() {
  level endon("flag_stakeout_player_has_weapon");
  thread vo_stakeout_price_in_here();
  scripts\engine\utility::flag_wait_all("flag_stakeout_player_in_kitchen", "flag_stakeout_nikolai_kitchen_ready");
  wait 1.0;

  if(!scripts\engine\utility::flag("flag_stakeout_player_has_weapon"))
    thread vo_stakeout_nikolai_gun_nag("stakeout_kitchen_idle_twitch01");

  wait(randomfloatrange(6.0, 8.0));
  scripts\engine\utility::flag_wait("flag_stakeout_price_kitchen_ready");
  var_0[0] = ["nikolai", "stakeout_kitchen_idle_twitch02"];
  var_0[1] = ["price", "stakeout_kitchen_idle_twitch01"];
  var_0[2] = ["price", "stakeout_kitchen_idle_twitch02"];

  while(!scripts\engine\utility::flag("flag_stakeout_player_has_weapon") && var_0.size > 0) {
    var_1 = randomint(var_0.size);

    if(var_0[var_1][0] == "nikolai")
      thread vo_stakeout_nikolai_gun_nag(var_0[var_1][1]);
    else
      thread vo_stakeout_price_gun_nag(var_0[var_1][1]);

    var_0 = scripts\engine\utility::array_remove_index(var_0, var_1);
    wait(randomfloatrange(6.0, 8.0));
  }
}

vo_stakeout_price_gun_nag(var_0) {
  var_1 = scripts\engine\utility::getStruct("stakeout_apt_scene_org", "targetname");
  var_1 notify("end_price_kitchen_idle");
  level.price scripts\engine\sp\utility::anim_stopanimScripted();
  scripts\engine\utility::flag_clear("flag_stakeout_price_kitchen_ready");
  var_1 scripts\common\anim::anim_single_solo(level.price, var_0);
  var_1 thread scripts\common\anim::anim_loop_solo(level.price, "stakeout_kitchen_idle", "end_price_kitchen_idle");
  scripts\engine\utility::flag_set("flag_stakeout_price_kitchen_ready");
}

vo_stakeout_nikolai_gun_nag(var_0) {
  var_1 = scripts\engine\utility::getStruct("stakeout_apt_scene_org", "targetname");
  var_1 notify("end_nikolai_kitchen_idle");
  level.nikolai scripts\engine\sp\utility::anim_stopanimScripted();
  scripts\engine\utility::flag_clear("flag_stakeout_nikolai_kitchen_ready");
  var_1 scripts\common\anim::anim_single_solo(level.nikolai, var_0);
  var_1 thread scripts\common\anim::anim_loop_solo(level.nikolai, "stakeout_kitchen_idle", "end_nikolai_kitchen_idle");
  scripts\engine\utility::flag_set("flag_stakeout_nikolai_kitchen_ready");
}

vo_stakeout_price_in_here() {
  level.player endon("death");
  level endon("missionfailed");
  level endon("flag_stakeout_player_in_kitchen");
  var_0 = [];
  var_1 = [];
  var_0[0] = "dx_vom_pri_stakeout_exit_50";
  var_0[1] = "dx_vom_pri_stakeout_exit_70";
  var_0[2] = "dx_vom_pri_acquire_street_90";
  var_0[3] = "dx_vom_pri_evade_defend_10";
  var_1[0] = "Waitin' on you, Garrick.";
  var_1[1] = "Let's go, Kyle. Now.";
  var_1[2] = "Let's go, Sergeant!";
  var_1[3] = "Hell are you waiting for, Sergeant?!";

  if(!scripts\engine\utility::flag("flag_stakeout_player_in_kitchen"))
    level.price scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::dialogue_naglogic(var_1, var_0, 6, level, "flag_stakeout_player_in_kitchen", 5);
}

vo_stakeout_move_to_street_level() {
  level.player endon("death");
  level endon("missionfailed");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_nikolai("Good stopping power.", "dx_vom_nik_stakeout_gear_choose_40");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Conceal it for now.", "dx_vom_pri_stakeout_gear_choose_50");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_nikolai("Rally at the warehouse.", "dx_vom_nik_stakeout_exit_20");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Copy. Bring the package.", "dx_vom_pri_stakeout_exit_30");

  if(!scripts\engine\utility::flag("flag_stakeout_price_move_down_stairs_1"))
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_nikolai("On the way, Captain.", "dx_vom_nik_stakeout_exit_40");
}

vo_stakeout_exit_apartment() {
  level endon("flag_stakeout_price_move_down_stairs_1");
  wait(randomfloatrange(6.0, 8.0));
  var_0[0] = ["nikolai", "stakeout_kitchen_idle02_twitch01"];
  var_0[1] = ["price", "stakeout_stairs_idle_twitch01"];
  var_0[2] = ["price", "stakeout_stairs_idle_twitch02"];

  while(!scripts\engine\utility::flag("flag_stakeout_price_move_down_stairs_1") && var_0.size > 0) {
    var_1 = randomint(var_0.size);

    if(var_0[var_1][0] == "nikolai")
      thread vo_stakeout_nikolai_stairs_nag(var_0[var_1][1]);
    else
      thread vo_stakeout_price_stairs_nag(var_0[var_1][1]);

    var_0 = scripts\engine\utility::array_remove_index(var_0, var_1);
    wait(randomfloatrange(6.0, 8.0));
  }
}

vo_stakeout_price_stairs_nag(var_0) {
  var_1 = scripts\engine\utility::getStruct("stakeout_apt_scene_org", "targetname");
  var_1 notify("end_stairs_idle");
  level.price scripts\engine\sp\utility::anim_stopanimScripted();
  scripts\engine\utility::flag_clear("flag_stakeout_price_stairs_ready");
  var_1 scripts\common\anim::anim_single_solo(level.price, var_0);
  var_1 thread scripts\common\anim::anim_loop_solo(level.price, "stakeout_idle_stairs", "end_stairs_idle");
  scripts\engine\utility::flag_set("flag_stakeout_price_stairs_ready");
}

vo_stakeout_nikolai_stairs_nag(var_0) {
  var_1 = scripts\engine\utility::getStruct("stakeout_apt_scene_org", "targetname");
  var_1 notify("end_nikolai_kitchen_idle02");
  level.nikolai scripts\engine\sp\utility::anim_stopanimScripted();
  scripts\engine\utility::flag_clear("flag_stakeout_nikolai_stairs_ready");
  var_1 scripts\common\anim::anim_single_solo(level.nikolai, var_0);
  var_1 thread scripts\common\anim::anim_loop_solo(level.nikolai, "stakeout_kitchen_idle02", "end_nikolai_kitchen_idle02");
  scripts\engine\utility::flag_set("flag_stakeout_nikolai_stairs_ready");
}

vo_stakeout_start_down_stairs() {
  level.player endon("death");
  level endon("missionfailed");
  level.player endon("weapon_fired");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("I know you want another shot at the Butcher.", "dx_vom_pri_stakeout_exit_80", 0.75);
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_kyle("No grave deep enough for that sick bastard, sir...", "dx_vom_kyle_stakeout_exit_90", 0.5);
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("You'll have that chance, but right now, we need the Butcher alive.", "dx_vom_pri_stakeout_exit_100", 0.5);
}

vo_stakeout_fire_weapon_indoors() {
  level.player endon("death");
  level endon("missionfailed");
  level endon("flag_alley_stealth_price_opening_door");
  var_0 = [];
  var_1 = [];
  var_0[0] = "dx_vom_pri_stakeout_exit_41";
  var_0[1] = "dx_vom_pri_stakeout_exit_42";
  var_0[2] = "dx_vom_pri_stakeout_exit_43";
  var_0[3] = "dx_vom_pri_stakeout_exit_44";
  var_1[0] = "What the hell, Garrick?!";
  var_1[1] = "Check fire, Sergeant, they'll hear us!";
  var_1[2] = "Kyle, quit fuckin' about!!";
  var_1[3] = "Sort yourself, Garrick, you'll give us away!";
  var_2 = 0;

  while(!scripts\engine\utility::flag("flag_stakeout_end")) {
    level.player waittill("weapon_fired");

    if(var_2 < var_0.size - 1) {
      scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price(var_1[var_2], var_0[var_2]);
      wait 3.0;
      var_2++;
    } else
      thread scripts\sp\maps\stpetersburg\stpetersburg_gameplay_club.gsc::fire_weapon_fail();

    wait 0.1;
  }
}

vo_stakeout_civ_on_stairs_casual() {
  level.player endon("death");
  level endon("missionfailed");
  self endon("death");
  self endon("civ_alerted");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_civilian("<Russian> Hello.", "dx_vom_rcm1_stakeout_exit_120");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("<Russian> Hello.", "dx_vom_pri_stakeout_exit_130", 0.25);
  var_0 = getEnt("intro_stakeout_player_greet_vol", "targetname");

  if(level.player istouching(var_0)) {
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_kyle("<Russian> Good Morning.", "dx_vom_kyle_stakeout_exit_140", 0.5);
    thread vo_stakeout_pri_not_bad();
  }
}

vo_stakeout_pri_not_bad() {
  level.player endon("death");
  level endon("missionfailed");
  level.player endon("weapon_fired");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Not bad.", "dx_vom_pri_stakeout_exit_150", 1.0);
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_kyle("That's all I got.", "dx_vom_kyle_stakeout_exit_160", 0.5);
}

vo_stakeout_civ_on_stairs_alerted() {
  level.player endon("death");
  level endon("missionfailed");
  self endon("death");
  self endon("entitydeleted");
  level.price scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::dialogue_stop();
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_civilian("<Russian> Don't hurt me!", "dx_vom_rcm2_bar_street_alley_35");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Sort yourself, Garrick, you'll give us away!", "dx_vom_pri_stakeout_exit_44");
}

vo_stakeout_civ_on_stairs_killed() {
  level.price scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::dialogue_stop();
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("What the hell, Garrick?!", "dx_vom_pri_stakeout_exit_41");
}

vo_alley_stealth_quickly_and_quietly() {
  level.player endon("death");
  level endon("missionfailed");
  scripts\engine\utility::flag_wait("flag_alley_stealth_price_bottom_stairs");
  wait 1.0;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("We sweep the guards up so they can't alert the others, then move in on the rear door.", "dx_vom_pri_stakeout_exit_170");

  if(scripts\engine\utility::flag("flag_stealth_start_patrols_1"))
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_kyle("Rog.", "dx_vom_kyle_stakeout_exit_180", 0.5);
}

vo_alley_stealth_price_at_door() {
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Guns on my signal, not before.", "dx_vom_pri_stakeout_exit_190");
}

vo_stealth_again_holster_weapon_nag() {
  level.player endon("death");
  level endon("missionfailed");
  level endon("weapon_holstered");
  var_0 = [];
  var_0[0] = "dx_vom_pri_stakeout_exit_200";
  var_0[1] = "dx_vom_pri_stakeout_exit_210";
  var_0[2] = "dx_vom_pri_stakeout_exit_220";
  var_0[3] = "dx_vom_pri_stakeout_exit_230";
  var_1 = [];
  var_1[0] = "Put your gun away.";
  var_1[1] = "Conceal it, you'll blow our cover.";
  var_1[2] = "Gun away for now, Garrick.";
  var_1[3] = "Conceal your gun, Kyle.";
  var_2 = 0;

  while(scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::player_weapon_holstered() == 0) {
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price(var_1[var_2], var_0[var_2]);
    var_2++;

    if(var_2 > var_0.size - 1) {
      return;
    }
    wait(randomfloatrange(6, 8));
  }
}

vo_alley_stealth_price_conversation() {
  level.player endon("death");
  level endon("missionfailed");
  level endon("flag_alley_stealth_cover_blown");
  level endon("flag_alley_stealth_aq_dead");
  setmusicstate("mx_stpete_tmp_street_kill");
  wait 3;
  thread vo_alley_stealth_price_ambush();
  var_0 = scripts\engine\sp\utility::get_living_ai("alley_stealth_aq01", "targetname");
  var_0 endon("death");
}

vo_alley_stealth_price_ambush() {
  level.player endon("death");
  level endon("missionfailed");
  level endon("flag_alley_stealth_cover_blown");
  level endon("flag_alley_stealth_aq_dead");
  scripts\engine\utility::flag_wait("flag_alley_stealth_price_ambush_begin");
  var_0 = scripts\engine\sp\utility::get_living_ai("alley_stealth_aq01", "targetname");

  if(isDefined(var_0))
    var_0 scripts\engine\utility::delaythread(1.0, scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::dialogue_stop);

  level.price scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::dialogue_stop();
  waitframe();
  thread vo_alley_stealth_enemies_alerted(1);
}

vo_alley_stealth_cover_blown() {
  level.player endon("death");
  level endon("missionfailed");
  setmusicstate("mx_stpete_tmp_alley_coverblown");
  level.price scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::dialogue_stop();
  thread vo_alley_stealth_enemies_alerted(0);
  wait 0.5;
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Kyle, take 'em out before they alert the others.", "dx_vom_pri_alley_stealth_permits_75");
}

vo_alley_stealth_enemies_alerted(var_0) {
  level.player endon("death");
  level endon("missionfailed");
  var_1 = scripts\engine\sp\utility::get_living_ai_array("alley_stealth_aq", "script_noteworthy");

  if(var_0) {
    var_2 = scripts\engine\sp\utility::get_living_ai("alley_stealth_aq01", "targetname");

    if(isDefined(var_2))
      var_1 = scripts\engine\utility::array_remove(var_1, var_2);
  }

  if(var_1.size > 0) {
    var_1[0] scripts\engine\sp\utility::set_battlechatter(1);
    var_1[0] thread scripts\engine\sp\utility::smart_dialogue_generic("dx_cbc_aq1_reaction_hostile_burst");
    wait(randomfloatrange(0.5, 1.5));

    if(isDefined(var_1[1])) {
      var_1[1] scripts\engine\sp\utility::set_battlechatter(1);
      var_1[1] thread scripts\engine\sp\utility::smart_dialogue_generic("dx_cbc_aq2_reaction_hostile_burst");
    }

    wait(randomfloatrange(0.5, 1.5));

    if(isDefined(var_1[2])) {
      var_1[2] scripts\engine\sp\utility::set_battlechatter(1);
      var_1[2] thread scripts\engine\sp\utility::smart_dialogue_generic("dx_cbc_aq3_reaction_hostile_burst");
    }
  }
}

vo_alley_stealth_butcher_alerted_fail() {
  var_0 = scripts\engine\sp\utility::get_living_ai_array("alley_stealth_aq", "script_noteworthy");

  if(var_0.size > 0)
    var_0[0] thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_aq_soldier("Boss! Enemies in the alley!", "dx_vom_aq1_alley_stealth_permits_77");

  wait 1;

  if(scripts\engine\utility::flag("flag_alley_stealth_price_ambush_begin"))
    thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("They've alerted the Butcher!", "dx_vom_pri_alley_stealth_permits_78");
  else
    thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("You gave us away, Sergeant!", "dx_vom_pri_alley_stealth_permits_73");
}

vo_alley_stealth_enemies_dead() {
  wait 1;
  setmusicstate("");

  if(!scripts\engine\utility::flag("flag_alley_stealth_mission_fail")) {
    if(scripts\engine\utility::flag("flag_alley_stealth_cover_blown"))
      scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Keep it tidy, Garrick.", "dx_vom_pri_alley_stealth_permits_50");
    else if(scripts\engine\utility::flag("flag_alley_stealth_player_killed_aq") && !scripts\engine\utility::flag("flag_alley_stealth_near_fail"))
      scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Nicely done.", "dx_vom_pri_alley_stealth_permits_80");
    else
      scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Stay the course, Sergeant.", "dx_vom_pri_alley_stealth_permits_60");
  }

  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Nikolai, trash in the alley.", "dx_vom_pri_alley_stealth_permits_90");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_nikolai("<Radio> I brought bags.", "dx_vom_nik_alley_stealth_permits_100", 0, undefined, undefined, 1);
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("You think of everything.", "dx_vom_pri_alley_stealth_permits_110");
}

vo_alley_stealth_move_to_bar_door() {
  level.player endon("death");
  level endon("missionfailed");
  thread vo_alley_stealth_move_to_bar_door_nag();
  scripts\engine\utility::flag_wait("flag_alley_stealth_player_opens_bar_door");
}

vo_alley_stealth_move_to_bar_door_nag() {
  level.player endon("death");
  level endon("missionfailed");
  level endon("flag_bar_alley_entrance_door_opened");
  var_0 = [];
  var_0[0] = "dx_vom_pri_alley_stealth_permits_120";
  var_0[1] = "dx_vom_pri_alley_stealth_permits_130";
  var_0[2] = "dx_vom_pri_alley_stealth_permits_140";
  var_0[3] = "dx_vom_pri_alley_stealth_permits_150";
  var_1 = [];
  var_1[0] = "Door, Sergeant. Take point.";
  var_1[1] = "On you, Sergeant, let's go.";
  var_1[2] = "Door, Kyle, lead us in.";
  var_1[3] = "Garrick, waitin' on you at the door.";

  if(!scripts\engine\utility::flag("flag_alley_stealth_player_opens_bar_door"))
    level.price scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::dialogue_naglogic(var_1, var_0, 8, level, "flag_alley_stealth_player_opens_bar_door", 7);
}

vo_back_room_price_dont_kill_butcher() {
  level.player endon("death");
  level endon("missionfailed");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Check your shots. Butcher gets us Hadir. We need him breathing until he does.", "dx_vom_pri_alley_stealth_permits_160");
}

vo_back_room_price_on_your_mark() {
  level.player endon("death");
  level endon("missionfailed");
  level endon("flag_player_blew_backroom_stealth");
  level endon("flag_player_shoots_in_backroom");
  level endon("flag_backroom_butcher_convo_over");
  level endon("flag_backroom_player_seen_standing");
  level endon("flag_player_jumps_in_backroom");
  wait 1;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("There he is.", "dx_vom_pri_bar_backroom_meeting_20");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_kyle("Affirm. Yellow, behind the table.", "dx_vom_kyle_bar_backroom_meeting_30");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("All yours, Garrick. Don't hit the Butcher.", "dx_vom_pri_bar_backroom_meeting_140", 5.0);
}

vo_back_room_butcher_conversation() {
  level.player endon("death");
  level endon("missionfailed");
  level.enforcer endon("death");
  level endon("flag_player_blew_backroom_stealth");
  level endon("flag_player_shoots_in_backroom");
  level endon("flag_backroom_butcher_convo_over");
  level endon("flag_backroom_player_seen_standing");
  level endon("flag_player_jumps_in_backroom");
  var_0 = scripts\engine\sp\utility::get_living_ai("enemy_bomb_room_left", "script_noteworthy");
  var_1 = scripts\engine\sp\utility::get_living_ai("enemy_bomb_room_right", "script_noteworthy");
  var_2 = scripts\engine\sp\utility::get_living_ai("backroom_front_enemies", "script_noteworthy");
  var_0 endon("death");
  var_1 endon("death");
  var_2 endon("death");
  scripts\engine\utility::flag_set("flag_vo_stp_no_step_hadir_line");
  thread scripts\sp\maps\stpetersburg\stpetersburg_gameplay_club.gsc::optional_stealth_handler();
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher("Good. This is retaliation... Today, the pain and suffering is not ours, but theirs.", "dx_vom_bch_bar_backroom_meeting_50");
  scripts\engine\utility::flag_clear("flag_vo_stp_no_step_hadir_line");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher("We give special thanks to our new soldier, whose strong will is our good fortune.", "dx_vom_bch_bar_backroom_meeting_55");
  wait 3.5;
  thread vo_back_room_butcher_conversation_commentary();
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher("If the Wolf is alive, he will be proud of you... and if he is gone, we deliver his truth to those who intervene where they are not invited.", "dx_vom_bch_bar_backroom_meeting_122");
  var_0 thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_aq_soldier("Glory to Al-Qatala.", "dx_vom_aq1_bar_backroom_meeting_60");
  var_1 thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_aq_soldier("Glory to Al-Qatala.", "dx_vom_aq2_bar_backroom_meeting_70");
  var_2 thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_aq_soldier("Glory to Al-Qatala.", "dx_vom_aq3_bar_backroom_meeting_80");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher("Glory to Al Qatala.", "dx_vom_bch_bar_backroom_meeting_90");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher("Tonight, we send our message to the world. Get your teams are in place and we'll reconvene at sundown.", "dx_vom_bch_bar_backroom_meeting_130");
  wait 1;
  scripts\engine\utility::flag_set("flag_backroom_butcher_convo_over");
}

vo_back_room_butcher_conversation_commentary() {
  level.player endon("death");
  level endon("missionfailed");
  level.enforcer endon("death");
  level endon("flag_player_blew_backroom_stealth");
  level endon("flag_player_shoots_in_backroom");
  level endon("flag_backroom_butcher_convo_over");
  level endon("flag_backroom_player_seen_standing");
  level endon("flag_player_jumps_in_backroom");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_kyle("New soldier...", "dx_vom_kyle_bar_backroom_meeting_100");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Hadir.", "dx_vom_pri_bar_backroom_meeting_110");
  scripts\engine\utility::flag_set("flag_vo_stp_no_step_hadir_line");
  wait 5;
  var_0 = [];
  var_0[0] = "dx_vom_pri_bar_backroom_meeting_150";
  var_0[1] = "dx_vom_pri_bar_backroom_meeting_160";
  var_1 = [];
  var_1[0] = "Clean shots Kyle, take 'em.";
  var_1[1] = "Hell are you waiting for, Sergeant?!";
  level.price scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::dialogue_naglogic(var_1, var_0, 9, level, ["flag_player_blew_backroom_stealth", "flag_player_shoots_in_backroom", "flag_backroom_butcher_convo_over", "flag_backroom_player_seen_standing"], 7);
}

vo_back_room_player_rushed_door() {
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Don't botch it up, Kyle!", "dx_vom_pri_alley_stealth_permits_72");
}

vo_back_room_player_blew_cover() {
  level endon("flag_bomb_room_enemies_dead");
  level endon("flag_bomb_room_price_advance");
  var_0 = scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::get_closest_living_ai(level.player.origin, "axis", [level.enforcer]);

  if(isDefined(var_0))
    var_0 scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_aq_soldier("Who's there...?", "dx_vom_aq1_bar_shootout_ambush_10");
}

vo_back_room_enemy_engaged() {
  level.player endon("death");
  level endon("missionfailed");
  level.enforcer endon("death");
  scripts\engine\utility::flag_wait_any("flag_player_blew_backroom_stealth", "flag_player_shoots_in_backroom", "flag_backroom_butcher_convo_over", "flag_backroom_player_seen_standing");

  if(isDefined(level.enforcer))
    level.enforcer scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::dialogue_stop();

  setmusicstate("mx_stpete_tmp_chase");
  var_0 = scripts\engine\sp\utility::get_living_ai("enemy_bomb_room_left", "script_noteworthy");

  if(isDefined(var_0))
    var_0 scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::dialogue_stop();

  wait 1;
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher("Back of the room! Kill them!", "dx_vom_bch_bar_shootout_ambush_20");
  wait 0.5;
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Butcher is running!", "dx_vom_pri_bar_shootout_ambush_31");
  wait 0.5;
  var_1 = scripts\engine\sp\utility::get_living_ai_array("spawner_bomb_room", "targetname");
  var_0 = scripts\engine\sp\utility::get_living_ai("enemy_bomb_room_left", "script_noteworthy");
  var_2 = undefined;

  if(isDefined(var_0))
    var_2 = var_0;
  else if(var_1.size > 0)
    var_2 = var_1[0];

  if(isDefined(var_2))
    var_2 scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_aq_soldier("How many are there?!", "dx_vom_aq2_bar_shootout_ambush_40");

  var_2 = undefined;
  var_1 = scripts\engine\utility::array_removedead_or_dying(var_1);
  var_3 = scripts\engine\sp\utility::get_living_ai("enemy_bomb_room_right", "script_noteworthy");

  if(isDefined(var_3))
    var_2 = var_3;
  else if(var_1.size > 0)
    var_2 = var_1[0];

  if(isDefined(var_2))
    var_2 scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_aq_soldier("I don't know!", "dx_vom_aq3_bar_shootout_ambush_50");
}

vo_back_room_enemies_dead() {
  level.player endon("death");
  level endon("missionfailed");

  if(!isDefined(level.player)) {
    return;
  }
  wait 2;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Clear!", "dx_vom_pri_bar_shootout_ambush_60");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_kyle("All clear!", "dx_vom_kyle_bar_shootout_ambush_70");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Get after him!", "dx_vom_pri_bar_shootout_ambush_80");
}

vo_bar_shootout_through_door() {
  level.player endon("death");
  level endon("missionfailed");
  scripts\engine\utility::flag_wait("flag_bar_shootout_through_door");
  wait 2;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_kyle("Door! Behind the bar!", "dx_vom_kyle_bar_shootout_mainroom_21");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Force in! Got your six!", "dx_vom_pri_bar_shootout_ambush_100", 1.0);
}

vo_bar_shootout_entrance() {
  level.player endon("death");
  level endon("missionfailed");
  scripts\engine\utility::flag_wait("flag_bar_shootout_through_door");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher("Don't let them follow! Kill them!", "dx_vom_bch_bar_shootout_mainroom_10");
}

vo_bar_shootout_enemies_cleared() {
  level.player endon("death");
  level endon("missionfailed");
  level endon("flag_ambusher_blindfire_end");
  scripts\engine\utility::flag_wait("flag_bar_shootout_enemies_dead");
  wait 0.75;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_kyle("Last call, boys.", "dx_vom_kyle_bar_shootout_mainroom_31");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Don't let him get away!", "dx_vom_pri_canal_chase_42");
}

vo_bar_shootout_approaching_kitchen() {
  level.player endon("death");
  level endon("missionfailed");
  scripts\engine\utility::flag_wait("flag_ambusher_blindfire_end");
  wait 1;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Take him!", "dx_vom_pri_bar_shootout_mainroom_40");
  wait 1;
  var_0 = scripts\engine\sp\utility::get_living_ai("aq_ambusher", "script_noteworthy");

  if(isDefined(var_0)) {
    var_0 scripts\engine\sp\utility::set_battlechatter(1);
    var_0 scripts\engine\sp\utility::smart_dialogue_generic("dx_cbc_aq1_reaction_hostile_burst");
  }
}

vo_bar_shootout_kitchen_clear() {
  level.player endon("death");
  level endon("missionfailed");
  scripts\engine\utility::flag_wait("flag_aq_ambusher_dead");
  wait 0.75;

  if(!scripts\engine\utility::flag("flag_player_near_exit_club"))
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_kyle("Down!", "dx_vom_kyle_bar_shootout_mainroom_50");

  scripts\engine\utility::flag_wait("flag_player_near_exit_club");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_kyle("Street door's open...", "dx_vom_kyle_bar_street_alley_10");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Butcher's on the run!", "dx_vom_pri_bar_street_alley_20");

  if(!scripts\engine\utility::flag("flag_enforcer_run_into_alley"))
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_kyle("Can't be far.", "dx_vom_kyle_bar_street_alley_30");

  scripts\engine\utility::flag_set("flag_bar_shootout_player_done_speaking");
}

vo_bar_street_wheres_enforcer() {
  level.player endon("death");
  level endon("missionfailed");
  scripts\engine\utility::flag_wait_all("flag_enforcer_run_into_alley", "flag_bar_shootout_player_done_speaking");
  wait 1;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Civilians! Check fire!", "dx_vom_pri_bar_street_alley_40");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_kyle("Fuckin' hell...!", "dx_vom_kyle_bar_street_alley_50", 0.5);
}

vo_bar_street_civilians() {
  level.player endon("death");
  level endon("missionfailed");
  scripts\engine\utility::flag_wait("flag_enforcer_run_into_alley");
  wait(randomfloatrange(0.5, 1.5));
  var_0 = scripts\engine\sp\utility::get_living_ai_array("streetciv_male", "script_noteworthy");

  if(var_0.size > 0)
    var_0[0] thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_civilian("<Russian> Run! He's got a gun!", "dx_vom_rcm1_bar_street_alley_31");

  wait(randomfloatrange(1.0, 2.0));
  var_0 = scripts\engine\utility::array_removedead_or_dying(var_0);

  if(var_0.size > 0 && scripts\engine\utility::cointoss())
    var_0[0] thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_civilian("<Russian> Out of the way!", "dx_vom_rcm2_bar_street_alley_32");
}

vo_bar_street_enforcer_flee() {
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher("Stop them, brothers! STOP THEM!!", "dx_vom_bch_bar_street_alley_70");
  wait 1;
  var_0 = scripts\engine\sp\utility::get_living_ai_array("bar_street_aq", "targetname");

  if(var_0.size > 0) {
    var_0[0] scripts\engine\sp\utility::set_battlechatter(1);
    var_0[0] scripts\engine\sp\utility::smart_dialogue_generic("dx_cbc_aq4_order_suppress");
  }
}

vo_bar_street_enemies_cleared() {
  level.player endon("death");
  level endon("missionfailed");
  scripts\engine\utility::flag_wait_any("flag_bar_street_aq_all_dead", "flag_bar_street_player_advance", "flag_bar_street_around_corner");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Nikolai, target is moving north. Stand by for extract.", "dx_vom_pri_bar_street_alley_80");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_nikolai("<Radio> Copy. I'm tracking you.", "dx_vom_nik_bar_street_alley_90", 0, undefined, undefined, 1);
  level endon("flag_apartment_price_go_around_corner");

  if(!scripts\engine\utility::flag("flag_bar_street_player_near_apt")) {
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("How?", "dx_vom_pri_bar_street_alley_100");
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_nikolai("<Radio> The gunshots, of course.", "dx_vom_nik_bar_street_alley_110", 0, undefined, undefined, 1);
  }

  if(!scripts\engine\utility::flag("flag_bar_street_player_near_apt"))
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Stay with us - out.", "dx_vom_pri_bar_street_alley_120");

  wait 1.0;

  if(!scripts\engine\utility::flag("flag_bar_street_player_advance"))
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Keep close, Garrick, don't lose him!", "dx_vom_pri_canal_chase_45");
}

vo_apartment_price_spotted_target() {
  level.player endon("death");
  level endon("missionfailed");
  wait 2;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("He went interior!", "dx_vom_kyle_bar_street_alley_130");
}

vo_apartment_price_tell_player_to_hurry() {
  level.player endon("death");
  level endon("missionfailed");
  wait 1;

  if(!scripts\engine\utility::flag("flag_bar_street_player_near_apt"))
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Keep close, Garrick, don't lose him!", "dx_vom_pri_canal_chase_45");
}

vo_apartment_price_flank_target() {
  level.player endon("death");
  level endon("missionfailed");
  scripts\engine\utility::flag_wait("blindfire_entrance_vignette_end");
  scripts\engine\utility::flag_set("flag_apartment_price_go_around_corner");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Stay on him. I'll circle around for intercept.", "dx_vom_pri_bar_street_alley_140");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_kyle("Roger.", "dx_vom_kyle_bar_street_alley_150");
}

vo_apartment_civ_stairs() {
  self endon("death");
  self endon("entitydeleted");

  if(scripts\engine\utility::cointoss())
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_civilian("<Russian> He's crazy!", "dx_vom_rcm3_bar_street_alley_33");
}

vo_apartment_civ_hallway() {
  self endon("death");
  self endon("entitydeleted");
  wait 0.5;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_civilian("(scream)", "dx_vom_civ_female_scream");
}

vo_apartment_civ_shocked() {
  self endon("death");
  self endon("entitydeleted");

  for(;;) {
    var_0 = scripts\engine\sp\utility::players_within_distance(256, self.origin);

    if(var_0 == 1) {
      scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_civilian("<Russian> Don't shoot!", "dx_vom_rcm2_apartment_hunt_10");
      return;
    }

    wait 0.2;
  }
}

vo_apartment_enforcer_hallway_taunt() {
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher("I'll take your head, motherfucker! You hear me!?", "dx_vom_bch_apartment_hunt_20");
}

vo_apartment_enforcer_grenade_taunt() {
  level.player endon("death");
  level endon("missionfailed");
  wait 1;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher("They die, because of you!", "dx_vom_bch_apartment_hunt_40");
}

vo_apartment_price_grenade_aftermath() {
  level.player endon("death");
  level endon("missionfailed");
  wait 1;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("<Radio> Sergeant...?!", "dx_vom_pri_apartment_hunt_50", 0, undefined, undefined, 1);
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_kyle("I'm good, sir. Target's on the move, river side...", "dx_vom_kyle_apartment_hunt_60");
  scripts\engine\utility::flag_set("flag_apartment_player_done_speaking");
}

vo_canal_enforcer_on_bridge() {
  level.player endon("death");
  level endon("missionfailed");
  scripts\engine\utility::flag_wait_all("flag_canal_player_jump_down", "flag_apartment_player_done_speaking");
  wait 1;

  if(scripts\engine\utility::flag("flag_canal_enforcer_over_bridge"))
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Get after him or we'll lose him!", "dx_vom_pri_canal_chase_41");
  else
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Butcher going over the bridge, Sergeant!", "dx_vom_pri_canal_chase_20");
}

vo_canal_aq_inbound() {
  level.player endon("death");
  level endon("missionfailed");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Contact, vehicle, up ahead!", "dx_vom_pri_canal_chase_100");
  wait 1.0;
  var_0 = scripts\engine\sp\utility::get_living_ai_array("canal_aq", "script_noteworthy");

  if(var_0.size > 0) {
    var_0[0] scripts\engine\sp\utility::set_battlechatter(1);
    var_0[0] scripts\engine\sp\utility::smart_dialogue_generic("dx_cbc_aq2_reaction_hostile_burst");
  }
}

vo_canal_enforcer_shoot_them() {
  level.enforcer endon("death");
  level.player endon("death");
  level endon("missionfailed");
  scripts\engine\utility::flag_wait_any("flag_canal_enforcer_on_bridge", "flag_canal_player_jump_down");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher("You are dead men! You hear me?! Whoever you are, I will cook your fucking corpse!!", "dx_vom_bch_bar_street_alley_60");
}

vo_canal_price_rpg() {
  level.player endon("death");
  level endon("missionfailed");
  level endon("flag_canal_end");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Shit! They got an RPG! Take it out!", "dx_vom_pri_canal_chase_101", 2.0);

  if(!scripts\engine\utility::flag("flag_canal_rpg_dead") && !scripts\engine\utility::flag("flag_canal_end"))
    thread vo_canal_price_rpg_nag();

  scripts\engine\utility::flag_wait("flag_canal_rpg_dead");
  wait 2.0;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_kyle("RPG is down!", "dx_vom_kyle_canal_chase_104");
  scripts\engine\utility::flag_set("flag_canal_player_done_speaking");
}

vo_canal_price_rpg_nag() {
  level.player endon("death");
  level endon("missionfailed");
  level endon("flag_canal_end");
  level endon("flag_canal_rpg_dead");
  var_0 = [];
  var_0[0] = "dx_vom_pri_canal_chase_102";
  var_0[1] = "dx_vom_pri_canal_chase_103";
  var_1 = [];
  var_1[0] = "Hit that RPG!";
  var_1[1] = "Get fire on that RPG, Garrick!";
  level.price scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::dialogue_naglogic(var_1, var_0, 8, level, ["flag_canal_rpg_dead", "flag_canal_end"], 7);
}

vo_canal_price_into_alley() {
  level.enforcer endon("death");
  level.player endon("death");
  level endon("missionfailed");
  var_0 = scripts\engine\utility::flag_wait_any_return("flag_canal_end", "flag_canal_rpg_dead");

  if(var_0 == "flag_canal_rpg_dead") {
    scripts\engine\utility::flag_wait("flag_canal_player_done_speaking");
    var_1 = scripts\engine\utility::flag_wait_any_return("flag_canal_end", "flag_canal_enemies_dead");

    if(var_1 == "flag_canal_enemies_dead") {
      wait 1;
      scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Clear... Butcher’s runnin’ for it! Get him!", "dx_vom_pri_canal_chase_90");
      return;
    }

    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("The alley... follow him!", "dx_vom_pri_canal_chase_110");
    return;
  } else
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("The alley... follow him!", "dx_vom_pri_canal_chase_110");
}

vo_canal_civilian_driveby_warning() {
  var_0 = scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::get_closest_living_ai(level.player.origin, "neutral");

  if(isDefined(var_0) && scripts\engine\utility::cointoss())
    var_0 scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_civilian("<Russian> Watch out!", "dx_vom_rcm1_apartment_chase_00");
}

vo_acquire_price_nowhere_left_to_run() {
  level.player endon("death");
  level endon("missionfailed");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Step it up!", "dx_vom_pri_canal_cafe_30");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher("If you come closer, you will die!", "dx_vom_enf_bar_street_chase_40");
  wait 1.0;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("He's cornered, watch the perimeter!", "dx_vom_pri_canal_chase_120");
}

vo_acquire_price_beyond_the_fence() {
  level.player endon("death");
  level endon("missionfailed");
  scripts\engine\utility::flag_wait("flag_acquire_player_enter_traversal");
  wait 1;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("There! Just beyond the fence!", "dx_vom_pri_canal_chase_111");
  wait 1.0;
  var_0 = scripts\engine\sp\utility::get_living_ai("acquire_alley_ar", "targetname");

  if(isDefined(var_0)) {
    var_0 scripts\engine\sp\utility::set_battlechatter(1);
    var_0 scripts\engine\sp\utility::smart_dialogue_generic("dx_cbc_aq3_reaction_hostile_burst");
  }
}

vo_acquire_price_keep_on_him() {
  level endon("missionfailed");
  level.player endon("death");
  scripts\engine\utility::flag_wait("flag_acquire_alley_ar_dead");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Nik, he's cutting through the cafe, river side, south, where are you?", "dx_vom_pri_canal_cafe_10");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_nikolai("<Radio> Inbound, Captain...", "dx_vom_nik_canal_cafe_20", 0, undefined, undefined, 1);
}

vo_evade_price_into_cafe() {
  if(!scripts\engine\utility::flag("flag_acquire_complete"))
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Stay with him, Kyle!", "dx_vom_pri_canal_chase_46");
}

vo_evade_butcher_taunt() {
  level endon("missionfailed");
  level.player endon("death");
  level.enforcer endon("death");
  scripts\engine\utility::flag_wait("flag_evade_down_stairs");
  wait 1;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher("You will never catch me!", "dx_vom_enf_bar_street_chase_80");
}

vo_evade_aq_runby() {
  level.player endon("death");
  level endon("missionfailed");
  level endon("flag_evade_spawn_teargas");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Watch for reinforcements!", "dx_vom_pri_canal_cafe_70");
  thread vo_evade_aq_runby_taunt();
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_kyle("Where the hell are they coming from?!", "dx_vom_kyle_canal_cafe_80");
}

vo_evade_aq_runby_taunt() {
  level.player endon("death");
  level endon("missionfailed");
  var_0 = scripts\engine\sp\utility::get_living_ai_array("evade_police", "script_noteworthy");

  if(var_0.size > 0) {
    var_0[0] scripts\engine\sp\utility::set_battlechatter(1);
    var_0[0] scripts\engine\sp\utility::smart_dialogue_generic("dx_cbc_aq4_exposed_acquired");
  }

  if(isDefined(var_0[1])) {
    var_0[1] scripts\engine\sp\utility::set_battlechatter(1);
    var_0[1] scripts\engine\sp\utility::smart_dialogue_generic("dx_cbc_aq4_response_threat_affirm");
  }
}

vo_evade_police_deploy_flashbangs() {
  level.player endon("death");
  level endon("missionfailed");
  thread vo_evade_aq_molotov_taunt();
  wait 0.75;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Molotov! Heads up!", "dx_vom_pri_canal_cafe_40");
  scripts\engine\utility::flag_wait_all("flag_player_flashbanged", "flag_enforcer_exited_cafe");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_kyle("He's getting away!", "dx_vom_kyle_canal_cafe_50", 1.0);
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Find a way through!", "dx_vom_pri_canal_cafe_60");
}

vo_evade_aq_molotov_taunt() {
  level.player endon("death");
  level endon("missionfailed");
  var_0 = scripts\engine\sp\utility::get_living_ai_array("evade_police", "script_noteworthy");

  if(var_0.size > 0) {
    var_0[0] scripts\engine\sp\utility::set_battlechatter(1);
    var_0[0] scripts\engine\sp\utility::smart_dialogue_generic("dx_cbc_aq4_inform_molotov");
  }

  wait 1.0;

  if(isDefined(var_0[1])) {
    var_0[1] scripts\engine\sp\utility::set_battlechatter(1);
    var_0[1] scripts\engine\sp\utility::smart_dialogue_generic("dx_cbc_aq4_order_move_combat");
  }
}

vo_evade_police_dead() {
  level.player endon("death");
  level endon("missionfailed");
  level endon("flag_evade_exit_cafe");
  scripts\engine\utility::flag_wait("flag_evade_police_dead");
  wait 1.0;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_kyle("Three down!", "dx_vom_kyle_canal_cafe_90");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Don't lose him!", "dx_vom_pri_canal_cafe_100");
}

vo_gauntlet_price_heading_for_river() {
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("He's heading for the river!", "dx_vom_pri_canal_street_10");
}

vo_gauntlet_player_chase_enforcer() {
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher("Stay away from me--!", "dx_vom_enf_bar_street_chase_20");
}

vo_gauntlet_player_approach_enforcer() {
  level.player endon("death");
  level.enforcer endon("death");
  level endon("missionfailed");
  scripts\engine\utility::flag_wait("flag_gauntlet_enforcer_van_hit");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher("<Pain/Anger>", "dx_vom_bch_acquire_street_40");
  scripts\engine\utility::flag_wait("flag_gauntlet_enforcer_ground_impact");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Nikolai!", "dx_vom_pri_acquire_street_10", 1.0);
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_kyle("We got him!", "dx_vom_kyle_acquire_street_20");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_nikolai("Is hard to run with concussion, no?", "dx_vom_nik_acquire_street_30", 0.5);
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Only a scratch... Get him in the van!", "dx_vom_pri_acquire_street_50", 0.5);
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher("Who are you...? So my men can send your heads home to your families...", "dx_vom_bch_acquire_street_60", 1.0);

  if(scripts\engine\sp\utility::players_within_distance(300, level.enforcer.origin))
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_kyle("Fuck off, shit-pouch.", "dx_vom_kyle_acquire_street_70");

  thread vo_gauntlet_price_get_in_van();
}

vo_gauntlet_price_get_in_van() {
  level.player endon("death");
  level.enforcer endon("death");
  level endon("missionfailed");
  level endon("flag_gauntlet_player_in_van");

  if(scripts\engine\utility::flag("flag_gauntlet_player_in_van")) {
    return;
  }
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Get in, Sergeant!", "dx_vom_pri_acquire_street_80");
  wait 4;
  var_0 = [];
  var_0[0] = "dx_vom_pri_acquire_street_90";
  var_0[1] = "dx_vom_pri_evade_defend_10";
  var_1 = [];
  var_1[0] = "Let's go, Sergeant!";
  var_1[1] = "Hell are you waiting for, Sergeant?!";
  level.price scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::dialogue_naglogic(var_1, var_0, 8, level, "flag_gauntlet_player_in_van", 7);
}

vo_gauntlet_player_in_van() {
  level.player endon("death");
  level endon("missionfailed");
  level endon("flag_gauntlet_van_destroyed");
  scripts\engine\utility::flag_set("flag_gauntlet_nikolai_start_van");
  wait 1;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_nikolai("Uh, small problem!", "dx_vom_nik_evade_defend_20");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("What?", "dx_vom_pri_evade_defend_30");
  scripts\engine\utility::flag_set("flag_gauntlet_enemies_spawn");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_nikolai("Engine is little bit... cranky!", "dx_vom_nik_evade_defend_40");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Sing it a bloody lullaby! We gotta move!", "dx_vom_pri_evade_defend_50");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Cover us, Kyle! Light 'em up!", "dx_vom_pri_evade_defend_70", 1.0);
}

vo_gauntlet_police_incoming() {
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Police are here!", "dx_vom_pri_evade_defend_121");
}

vo_gauntlet_van_almost_leaves() {
  level.player endon("death");
  level endon("missionfailed");
  level endon("flag_gauntlet_van_destroyed");
  scripts\engine\utility::flag_wait("flag_gauntlet_aq_car_3_incoming");

  if(scripts\engine\utility::flag("flag_gauntlet_player_in_van")) {
    return;
  }
  wait 1;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_nikolai("Come on, baby, come on...!", "dx_vom_nik_evade_defend_110");
}

vo_gauntlet_van_leaves() {
  level.player endon("death");
  level endon("missionfailed");
  level endon("flag_gauntlet_van_destroyed");
  setmusicstate("mx_stpete_tmp_driveaway");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_nikolai("There she is...!", "dx_vom_nik_evade_defend_120");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("Floor it! GO!!", "dx_vom_pri_evade_defend_130");
}

vo_gauntlet_init_van_damage_nags() {
  level.van_damage_nag = [];
  level.van_damage_nag[0] = ["Price", "They're tearing the van apart!", "dx_vom_pri_evade_defend_101"];
  level.van_damage_nag[1] = ["Price", "We're taking too much fire!", "dx_vom_pri_evade_defend_102"];
  level.van_damage_nag[2] = ["Nikolai", "They're hitting the engine block!", "dx_vom_nik_evade_defend_103"];
  level.van_damage_nag[3] = ["Nikolai", "Give me cover fire! I need more time!", "dx_vom_nik_evade_defend_104"];
  level.van_damage_nag = scripts\engine\utility::array_randomize(level.van_damage_nag);
}

vo_gauntlet_van_damage_warning() {
  level endon("missionfailed");
  level.player endon("death");
  level endon("flag_gauntlet_van_destroyed");

  if(!isDefined(level.price)) {
    return;
  }
  if(!isDefined(level.nikolai)) {
    return;
  }
  if(level.van_damage_nag.size > 0 && !scripts\engine\utility::flag("flag_gauntlet_van_damage_warning_playing")) {
    scripts\engine\utility::flag_set("flag_gauntlet_van_damage_warning_playing");
    var_0 = randomint(level.van_damage_nag.size - 1);
    var_1 = level.van_damage_nag[var_0];

    if(var_1[0] == "Price")
      scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price(var_1[1], var_1[2]);
    else
      scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_nikolai(var_1[1], var_1[2]);

    level.van_damage_nag = scripts\engine\utility::array_remove_index(level.van_damage_nag, var_0);
    scripts\engine\utility::flag_clear("flag_gauntlet_van_damage_warning_playing");
  }
}

vo_pursuit_target_escaping_nag() {
  var_0 = [];
  var_0[0] = "dx_vom_pri_canal_chase_41";
  var_0[1] = "dx_vom_pri_canal_chase_42";
  var_0[2] = "dx_vom_pri_canal_chase_43";
  var_0[3] = "dx_vom_pri_canal_chase_44";
  var_0[4] = "dx_vom_pri_canal_chase_45";
  var_0[5] = "dx_vom_pri_canal_chase_46";
  var_1 = [];
  var_1[0] = "Get after him or we'll lose him!";
  var_1[1] = "Don't let him get away!";
  var_1[2] = "He's running, stay on him!";
  var_1[3] = "Butcher's moving, follow him!";
  var_1[4] = "Keep close, Garrick, don't lose him!";
  var_1[5] = "Stay with him, Kyle!";
  var_2 = randomint(var_0.size - 1);
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price(var_1[var_2], var_0[var_2]);
}

vo_pursuit_target_escaped_fail() {
  var_0 = [];
  var_0[0] = "dx_vom_pri_canal_fail_10";
  var_0[1] = "dx_vom_pri_canal_fail_20";
  var_0[2] = "dx_vom_pri_canal_fail_30";
  var_0[3] = "dx_vom_pri_canal_fail_40";
  var_1 = [];
  var_1[0] = "Butcher is MIA.";
  var_1[1] = "We've lost the target. Repeat, we have lost the target.";
  var_1[2] = "The Butcher is gone. We failed.";
  var_1[3] = "Butcher is in the wind.";
  var_2 = randomint(var_0.size - 1);
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price(var_1[var_2], var_0[var_2]);
}

vo_pursuit_target_hurt_nag() {
  var_0 = [];
  var_0[0] = "dx_vom_pri_bar_street_chase_90";
  var_0[1] = "dx_vom_pri_bar_street_chase_100";
  var_1 = [];
  var_1[0] = "Kyle, watch your shot!";
  var_1[1] = "Kyle, we need him alive!";

  if(!isDefined(level.enforcer_hurt_nag)) {
    level.enforcer_hurt_nag = 1;
    var_2 = randomint(var_0.size - 1);
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price(var_1[var_2], var_0[var_2]);
    wait 8.0;
    level.enforcer_hurt_nag = undefined;
  }
}

vo_pursuit_target_killed_fail() {
  var_0 = [];
  var_0[0] = "dx_vom_pri_bar_street_chase_110";
  var_0[1] = "dx_vom_pri_bar_street_chase_120";
  var_1 = [];
  var_1[0] = "He's no use to us dead!";
  var_1[1] = "We needed him alive, Kyle!";
  var_2 = randomint(var_0.size - 1);
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price(var_1[var_2], var_0[var_2]);
}

vo_player_wander_nag() {
  var_0 = [];
  var_0[0] = "dx_vom_pri_bar_street_chase_130";
  var_0[1] = "dx_vom_pri_bar_street_chase_140";
  var_0[2] = "dx_vom_pri_bar_street_chase_150";
  var_0[3] = "dx_vom_pri_bar_street_chase_160";
  var_1 = [];
  var_1[0] = "Kyle, where are you headed?";
  var_1[1] = "Kyle, over here.";
  var_1[2] = "Stay with me, Sergeant.";
  var_1[3] = "There's no time to fuck about, Sergeant.";
  var_2 = randomint(var_0.size - 1);
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price(var_1[var_2], var_0[var_2]);
}

vo_player_crazy_fail() {
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("You blew our cover, Garrick!", "dx_vom_pri_alley_stealth_permits_74");
}

vo_player_wander_fail() {
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("<Radio> Abort mission. We've lost the Sergeant.", "dx_vom_pri_bar_street_chase_180", 0, undefined, undefined, 1);
}

vo_price_kyle_content_warning() {
  level.escortdrones[0] stopsounds();
  waitframe();
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife("I demand to know why we are here!", "dx_vom_ousa_interrogation_room_doorway_60");
}

vo_price_content_warning_nags() {
  level.player endon("death");
  level endon("warning_nags_end");
  var_0 = ["content_warning_nag_1", "content_warning_nag_2", "content_warning_nag_3"];
  wait 8;

  while(var_0.size > 0) {
    level.priceanimnode scripts\common\anim::anim_single_solo(level.price, var_0[0]);
    var_0 = scripts\engine\utility::array_remove_index(var_0, 0);
    level.priceanimnode notify("stop_loop");
    level.priceanimnode thread scripts\common\anim::anim_loop_solo(level.price, "content_warning_idle");
    wait(randomfloatrange(5.5, 7.5));
  }
}

vo_price_warning_accepted() {
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_kyle("I'm in.", "dx_vom_kyle_interrogation_room_interrogate_10");
}

vo_price_warning_rejected() {
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_kyle("I'm out, sir...", "dx_vom_kyle_interrogation_room_opt_out_10");
}

vo_interrogation_nikolai_intro() {
  level.nikolaivan endon("trigger");

  while(distance(level.player.origin, level.nikolai.origin) > 540)
    waitframe();

  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_kyle("What is it?", "dx_vom_kyle_interrogation_intro_family_20");
  wait 1;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_nikolai("Truth serum.", "dx_vom_nik_interrogation_intro_family_30");
}

vo_interrogation_door_intro_linger() {
  wait 11;
  var_0 = 250;
  var_1 = distance2d(level.player.origin, level.enforcer.origin);

  if(var_1 <= var_0) {
    scripts\engine\utility::delaythread(0.75, scripts\engine\utility::play_sound_in_space, "melee_thru_door", level.enforcer.origin);
    scripts\engine\utility::delaythread(1.75, scripts\engine\utility::play_sound_in_space, "melee_thru_door", level.enforcer.origin);
    scripts\engine\utility::delaythread(2.75, scripts\engine\utility::play_sound_in_space, "melee_thru_door", level.enforcer.origin);
    thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_yegor("<punches/strikes>", "dx_vom_ygr_interrogation_intro_intro_20");
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher("<pain/hits/breath>", "dx_vom_bch_interrogation_intro_intro_10");
  }

  wait 3.5;
  var_1 = distance2d(level.player.origin, level.enforcer.origin);

  if(var_1 <= var_0) {
    scripts\engine\utility::delaythread(0.99, scripts\engine\utility::play_sound_in_space, "melee_thru_door", level.enforcer.origin);
    scripts\engine\utility::delaythread(2.0, scripts\engine\utility::play_sound_in_space, "melee_thru_door", level.enforcer.origin);
    thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_yegor("<punches/strikes>", "dx_vom_ygr_interrogation_intro_intro_30");
    wait 0.95;
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher("<pain/hits/breath>", "dx_vom_enf_interrogation_intro_intro_10");
  }
}

vo_interrogation_acquire_nikolai_remark() {
  level endon("escort_slowdown");

  while(distance(level.player.origin, level.nikolai.origin) > 150)
    waitframe();

  scripts\engine\utility::flag_waitopen("pause_nikolai_vo");
  scripts\engine\utility::flag_clear("interrogation_escort_idle");
  scripts\engine\utility::flag_set("pause_nikolai_vo");
  childthread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_nikolai("I'll be standing by when he breaks.", "dx_vom_nik_interrogation_intro_family_160", undefined, undefined, undefined, undefined, 1);
  level.outeranimnode scripts\common\anim::anim_single_solo(level.nikolai, "car_remark");
  level.outeranimnode notify("stop_loop");
  level.outeranimnode thread scripts\common\anim::anim_loop_solo(level.nikolai, "acquire_idle");
  scripts\engine\utility::delaythread(5, scripts\engine\utility::flag_clear, "pause_nikolai_vo");
}

vo_interrogation_intro_nikolai_nags() {
  var_0["near"] = [["Captain is waiting, Sergeant -- Open up...", "dx_vom_nik_interrogation_intro_family_45"], ["Garrick, Price is waiting for the package.", "dx_vom_nik_interrogation_intro_family_55"], ["Package is the van, take it to the Captain.", "dx_vom_nik_interrogation_intro_family_65"]];
  var_0["far"] = [["Captain is waiting, Sergeant -- Open up...", "dx_vom_nik_interrogation_intro_family_40"], ["Garrick, Price is waiting for the package.", "dx_vom_nik_interrogation_intro_family_50"], ["Package is the van, take it to the Captain.", "dx_vom_nik_interrogation_intro_family_60"]];
  return var_0;
}

vo_interrogation_acquire_nikolai_nags() {
  var_0["near"] = [["Sergeant, take them to the Captain.", "dx_vom_nik_interrogation_intro_family_135"], ["Garrick, get them inside. We don't have much time.", "dx_vom_nik_interrogation_intro_family_145"]];
  var_0["far"] = [["Sergeant, take them to the Captain.", "dx_vom_nik_interrogation_intro_family_130"], ["Garrick, get them inside. We don't have much time.", "dx_vom_nik_interrogation_intro_family_140"]];
  return var_0;
}

vo_interrogation_escort_nikolai_nags() {
  var_0["near"] = [["Take them in...", "dx_vom_nik_interrogation_intro_family_175"], ["Garrick, take the package in.", "dx_vom_nik_interrogation_intro_family_195"], ["The Captain is waiting, Sergeant.", "dx_vom_nik_interrogation_intro_family_185"]];
  var_0["far"] = [["Take them in...", "dx_vom_nik_interrogation_intro_family_170"], ["Garrick, take the package in.", "dx_vom_nik_interrogation_intro_family_190"], ["The Captain is waiting, Sergeant.", "dx_vom_nik_interrogation_intro_family_180"]];
  return var_0;
}

vo_interrogation_nikolai_van_open_remark() {
  level.enforcerwife endon("trigger");
  level waittill("acquire_van_wife_vo");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife("Please, let us go. We know nothing.", "dx_vom_ousa_interrogation_intro_family_70");
  level waittill("nikolai_escort_remark");
  wait 7.5;
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_son("Momma, what's happening??", "dx_vom_amon_interrogation_intro_family_100");
  wait 2;
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife("It's okay, my son.", "dx_vom_ousa_interrogation_intro_family_120");
}

vo_interrogation_escort_start() {
  level endon("escort_slowdown");
  wait 3;
  scripts\engine\utility::flag_waitopen("interrogation_escort_idle");

  if(distance(level.player.origin, level.interrogationdoor.origin) > 700)
    thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife("Where are you taking us...?", "dx_vom_ousa_interrogation_intro_family_166");

  thread vo_interrogation_escort_move();
  level waittill("nik_nag_trigger");
  wait 5;
  scripts\engine\utility::flag_set("pause_nikolai_vo");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife("Please- Let us go...", "dx_vom_ousa_interrogation_intro_family_163");
  scripts\engine\utility::flag_clear("pause_nikolai_vo");
  level waittill("nik_nag_trigger");
  wait 5;
  scripts\engine\utility::flag_set("pause_nikolai_vo");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife("We've done nothing...", "dx_vom_ousa_interrogation_intro_family_164");
  scripts\engine\utility::flag_clear("pause_nikolai_vo");
  level waittill("nik_nag_trigger");
  wait 5;
  scripts\engine\utility::flag_set("pause_nikolai_vo");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife("This is wrong...", "dx_vom_ousa_interrogation_intro_family_165");
  scripts\engine\utility::flag_clear("pause_nikolai_vo");
}

vo_interrogation_escort_move() {
  level endon("escort_slowdown");

  while(distance(level.player.origin, level.interrogationdoor.origin) > 625)
    waitframe();

  scripts\engine\utility::flag_set("pause_family_vo");
  scripts\engine\utility::flag_set("pause_nikolai_vo");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_son("Where are we going, momma?", "dx_vom_amon_interrogation_intro_family_200", undefined, undefined, undefined, undefined, 1);
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife("We are going to talk to some men, and then, we will go home, okay...", "dx_vom_ousa_interrogation_intro_family_210", undefined, undefined, undefined, undefined, 1);
  scripts\engine\utility::flag_clear("pause_nikolai_vo");
  wait 4;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife("Let us go, we will go home and tell no one...", "dx_vom_ousa_interrogation_intro_family_220", undefined, undefined, undefined, undefined, 1);
  scripts\engine\utility::flag_clear("pause_family_vo");
}

vo_interrogation_escort_halt() {
  level endon("warning_nags_end");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher("AARRRHH!", "dx_vom_enf_interrogation_revolver_linger_kill_21");
  wait 1.5;
  scripts\engine\utility::flag_clear("pause_family_vo");
  waitframe();
  wait 9;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife("I know nothing, I can't help you...", "dx_vom_ousa_interrogation_intro_family_240");
}

vo_interrogation_room_enter() {
  level waittill("script_dx_vom_ousa_interrogation_room_interrogate_50");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife("No! Nooo! Please!", "dx_vom_ousa_interrogation_room_interrogate_50");
  level waittill("script_dx_vom_amon_interrogation_room_interrogate_70");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_son("Daddy?", "dx_vom_amon_interrogation_room_interrogate_70");
  level waittill("script_dx_vom_ousa_interrogation_room_interrogate_100");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife("They won't let us go, what have you done...?!", "dx_vom_ousa_interrogation_room_interrogate_100");
}

vo_interrogation_family_idle_loop(var_0) {
  var_1 = scripts\engine\utility::ter_op(scripts\engine\utility::flag("final_phase"), "dx_stpburg_wifechild_idlehigh_loop", "dx_stpburg_wifechild_idle_loop");

  if(istrue(var_0) || !scripts\engine\utility::flag("pause_family_vo") && !scripts\engine\utility::flag("interrogation_abandoned"))
    level.enforcerwife playLoopSound(var_1);
}

vo_interrogation_room_intro() {
  level waittill("script_dx_vom_kyle_interrogation_room_interrogate_230");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_kyle("None...", "dx_vom_kyle_interrogation_room_interrogate_230");
}

vo_interrogation_weapon_pickup() {
  level endon("family_ads_reaction_active");
  level.actioncount++;
  level waittill("script_dx_vom_ousa_interrogation_revolver_pickup_100");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife("Please, please… We are not involved with any of this, I assure you..?", "dx_vom_ousa_interrogation_revolver_pickup_100");
  level.actioncount++;
  level waittill("script_dx_vom_amon_interrogation_revolver_pickup_110");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_son("Papa make it stop..", "dx_vom_amon_interrogation_revolver_pickup_110");
  level.actioncount++;
  vo_interrogation_family_idle_loop();
  level waittill("gun_pickup_vo_done");
  level.actioncount++;
  level notify("enable_ads_reactions_enforcer");
}

vo_interrogation_family_aim() {
  level.player endon("dry_fired");
  level.player endon("weapon_fired");
  level endon("revolver_phase_family_ads");
  level endon("interrogation_abandoned");
  var_0 = 1.5;
  level.enforcerwife scripts\engine\utility::delaythread(var_0, scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::dialogue_stop_and_clear_stack);
  level.enforcerson scripts\engine\utility::delaythread(var_0, scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::dialogue_stop_and_clear_stack);
  scripts\engine\utility::delaythread(var_0 + 0.05, scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife, "<frightened breaths/murmurs>", "dx_vom_ousa_interrogation_revolver_aim_90");
  scripts\engine\utility::delaythread(var_0 + 0.05, scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_son, "<frightened breaths/murmurs>", "dx_vom_amon_interrogation_revolver_aim_100");
  level.enforcer scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::dialogue_stop_and_clear_stack();
  waitframe();
  scripts\engine\utility::flag_set("pause_butcher_vo");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher("No! They have nothing to do with this!", "dx_vom_enf_interrogation_revolver_aim_80", undefined, undefined, undefined, undefined, 1);
  wait 0.25;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife("Please, please, please, no...", "dx_vom_ousa_interrogation_revolver_aim_110");
  level.actioncount++;
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife("Do something! For your son...!", "dx_vom_ousa_interrogation_revolver_aim_120");
  wait 2;
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife("Tell the truth! If you know the truth, tell them!", "dx_vom_ousa_interrogation_revolver_aim_130");
  wait 1.5;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife("TELL THEM!", "dx_vom_ousa_interrogation_revolver_aim_140");
  vo_interrogation_family_idle_loop();
  level notify("enable_ads_reactions_enforcer");
  scripts\engine\utility::flag_clear("pause_butcher_vo");
  level.revolvervodone["aim_family"] = 1;
}

vo_interrogation_family_ads() {
  level.player endon("dry_fired");
  level.player endon("weapon_fired");
  level endon("interrogation_abandoned");
  var_0 = 3;
  level.enforcerwife scripts\engine\utility::delaythread(var_0, scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::dialogue_stop_and_clear_stack);
  level.enforcerson scripts\engine\utility::delaythread(var_0, scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::dialogue_stop_and_clear_stack);
  scripts\engine\utility::delaythread(var_0 + 0.05, scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife, "<frightened breaths/murmurs>", "dx_vom_ousa_interrogation_revolver_aim_90");
  scripts\engine\utility::delaythread(var_0 + 0.05, scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_son, "<frightened breaths/murmurs>", "dx_vom_amon_interrogation_room_interrogate_110");
  level.enforcer scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::dialogue_stop_and_clear_stack();
  waitframe();
  scripts\engine\utility::flag_set("pause_butcher_vo");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher("NO, NO, NO! DON'T, sergeant. Leave them alone, they know nothing of this...", "dx_vom_enf_interrogation_revolver_ads_kid_10", undefined, undefined, undefined, undefined, 1);
  wait 0.5;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_kyle("Tell that to the boy in the Embassy...", "dx_vom_kyle_interrogation_revolver_ads_kid_20");
  level.actioncount++;
  vo_interrogation_family_idle_loop();
  wait 0.5;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher("DON'T! PLEASE-- Leave them alone, please, Captain, Sergeant... They have no information for you!", "dx_vom_enf_interrogation_revolver_aim_150", undefined, undefined, undefined, undefined, 1);
  wait 0.25;
  wait 0.5;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("We want Hadir and the gas, where are they?", "dx_vom_pri_interrogation_revolver_aim_210");
  level.actioncount++;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher("You can not fix these things, They will happen, nothing here will change that...", "dx_vom_enf_interrogation_revolver_aim_220", undefined, undefined, undefined, undefined, 1);
  level notify("enable_ads_reactions_enforcer");
  scripts\engine\utility::flag_clear("pause_butcher_vo");
  level.revolvervodone["aim_family"] = 1;
  level.revolvervodone["ads_family"] = 1;
}

vo_interrogation_ads_no_target() {
  level.player endon("dry_fired");
  level.player endon("weapon_fired");

  if(scripts\engine\utility::flag("bullets_offered") || scripts\engine\utility::flag("final_phase")) {
    return;
  }
  level.enforcerwife stoploopsound();
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife("Shhhh-Shhhh-Shhhhh-- that's Momma's good boy...", "dx_vom_ousa_interrogation_revolver_aim_10");
  wait 2;
  vo_interrogation_family_idle_loop();
}

vo_interrogation_dry_fire_nags() {
  level.player endon("dry_fired");
  level.player endon("weapon_fired");

  if(scripts\engine\utility::flag("bullets_offered") || scripts\engine\utility::flag("final_phase")) {
    return;
  }
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("He's right there, Sergeant.", "dx_vom_pri_interrogation_revolver_testfire_70");
  wait(randomintrange(5, 7));
  scripts\engine\utility::flag_waitopen("pause_inactive_vo");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("What's it gonna be?", "dx_vom_pri_interrogation_revolver_testfire_80");
  wait(randomintrange(5, 7));
  scripts\engine\utility::flag_waitopen("pause_inactive_vo");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("How's the pull on that, Sergeant?", "dx_vom_pri_interrogation_revolver_testfire_90");
  wait 2;
  scripts\engine\utility::flag_waitopen("pause_inactive_vo");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher("Afraid, Sergeant?", "dx_vom_enf_interrogation_revolver_testfire_100");
  wait(randomintrange(5, 7));
  scripts\engine\utility::flag_waitopen("pause_inactive_vo");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher("Looks like you are the coward here...", "dx_vom_enf_interrogation_revolver_testfire_110");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("We'll see...", "dx_vom_pri_interrogation_revolver_testfire_120");
}

mus_kyle_dryfire() {
  setmusicstate("");
  wait 7.0;
  setmusicstate("mx_stpete_tmp_confess");
}

mus_kyle_pointgun() {
  if(!scripts\engine\utility::flag("dry_fire_complete"))
    setmusicstate("mx_stpete_tmp_roulette");
}

mus_enforcer_hit() {
  wait 1.5;
  setmusicstate("");
}

mus_intro_torture() {
  setmusicstate("mx_stpete_tmp_intel");
}

mus_kyle_leave() {
  scripts\engine\utility::flag_wait("interrogation_end");
  setmusicstate("");
  wait 5.2;
  setmusicstate("mx_stpete_police_bust");
}

vo_interrogation_price_ads() {
  var_0 = [["Watch yourself there, Sergeant.", "dx_vom_pri_interrogation_revolver_ads_price_10"], ["Let's not fuck about now, Sergeant.", "dx_vom_pri_interrogation_revolver_ads_price_20"], ["Keep your head there, Sergeant.", "dx_vom_pri_interrogation_revolver_ads_price_30"]];
  return var_0;
}

vo_interrogation_dry_fire() {
  level waittill("script_dx_vom_kyle_interrogation_revolver_empty_10");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_kyle("What the hell?!", "dx_vom_kyle_interrogation_revolver_empty_10");
}

vo_interrogation_final_phase() {
  level waittill("script_dx_vom_ousa_interrogation_revolver_empty_80");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_son("<scared>", "dx_vom_amon_interrogation_revolver_empty_90");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife("Sergeant, Please, I'm begging you...", "dx_vom_ousa_interrogation_revolver_empty_80");
  vo_interrogation_family_idle_loop();
  level waittill("script_dx_vom_ousa_interrogation_revolver_empty_160");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife("You are foolish! All of this is your fault! We are innocent!", "dx_vom_ousa_interrogation_revolver_empty_160");
  wait 2;
  vo_interrogation_family_idle_loop();
}

vo_interrogation_final_load_weapon() {
  level waittill("script_dx_vom_kyle_interrogation_revolver_load_80");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_kyle("Where's Hadir?", "dx_vom_kyle_interrogation_revolver_load_80");
}

vo_interrogation_exit_nags() {
  level endon("interrogation_end");

  if(scripts\engine\utility::flag("interrogation_end")) {
    return;
  }
  wait 5;
  scripts\engine\utility::flag_waitopen("pause_price_vo");
  level.outeranimnode scripts\common\anim::anim_single_solo(level.price, "car_nag_1");
  level.outeranimnode notify("stop_loop");
  level.outeranimnode thread scripts\common\anim::anim_loop_solo(level.price, "car_idle");
  wait(randomintrange(6, 8));
  scripts\engine\utility::flag_waitopen("pause_price_vo");
  level.outeranimnode scripts\common\anim::anim_single_solo(level.price, "car_nag_2");
  level.outeranimnode notify("stop_loop");
  level.outeranimnode thread scripts\common\anim::anim_loop_solo(level.price, "car_idle");
}

vo_interrogation_exit_player(var_0) {
  level endon("interrogation_end");
  thread vo_interrogation_exit_killed_butcher();
  scripts\engine\utility::flag_wait("police_car_nag_spoken");
  var_1 = scripts\engine\utility::ter_op(istrue(var_0), "dx_vom_kyle_evade_capture_190", "dx_vom_kyle_evade_capture_200");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_kyle("Rog.", var_1);
}

vo_interrogation_exit_killed_butcher() {
  if(!scripts\engine\utility::flag("enforcer_dead")) {
    return;
  }
  wait 4;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("There's a fine line between right and wrong.", "dx_vom_pri_evade_capture_145");
}

vo_interrogation_enforcer_defeated() {
  level endon("enforcer_dead");
  level endon("interrogation_end");
  wait 0.25;
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife("<frightened breaths/murmurs>", "dx_vom_ousa_interrogation_revolver_linger_10");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_son("<frightened breaths/murmurs>", "dx_vom_amon_interrogation_revolver_linger_20");
  scripts\engine\utility::flag_waitopen("pause_butcher_vo");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher("I told you everything, Sergeant.", "dx_vom_enf_interrogation_revolver_linger_30");
  wait 0.5;
  scripts\engine\utility::flag_waitopen("pause_family_vo");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife("Go... you have what you want!", "dx_vom_ousa_interrogation_revolver_linger_60");
  wait 3;
  scripts\engine\utility::flag_waitopen("pause_butcher_vo");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher("If you're going to shoot me, kill me, please.", "dx_vom_enf_interrogation_revolver_linger_80");
  scripts\engine\utility::flag_waitopen("pause_family_vo");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife("Stop it!", "dx_vom_ousa_interrogation_revolver_linger_90");
  vo_interrogation_family_idle_loop();
  wait 1;
  scripts\engine\utility::flag_waitopen("pause_butcher_vo");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher("You tried to be a hero. But you are just another angry boy...", "dx_vom_enf_interrogation_revolver_linger_100");
  wait 0.5;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_kyle("Don't call me 'boy'...", "dx_vom_kyle_interrogation_revolver_linger_110");
  thread vo_interrogation_linger_no_shot();
  thread vo_interrogation_linger_ads();
}

vo_interrogation_linger_no_shot() {
  level.player endon("weapon_fired");
  level endon("enforcer_dead");
  level endon("defeated_state_family_ads");
  level endon("interrogation_end");
  wait 13;
  scripts\engine\utility::flag_waitopen("pause_family_vo");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife("<humming/whispering>", "dx_vom_ousa_interrogation_revolver_linger_nokill_10");
  wait 0.5;
  scripts\engine\utility::flag_waitopen("pause_family_vo");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_son("More, momma... more...", "dx_vom_amon_interrogation_revolver_linger_nokill_20");
  wait 1;
  scripts\engine\utility::flag_waitopen("pause_family_vo");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife("<humming>", "dx_vom_ousa_interrogation_revolver_linger_nokill_30");
  wait 4;
  vo_interrogation_family_idle_loop();
}

vo_interrogation_linger_ads() {
  level endon("enforcer_dead");
  level endon("missionfailed");
  level endon("interrogation_end");
  wait 1;
  level scripts\engine\sp\utility::wait_for_notify_or_timeout("defeated_state_family_ads", randomintrange(10, 13));
  scripts\engine\utility::flag_waitopen("pause_butcher_vo");
  level.enforceranimnode scripts\common\anim::anim_single_solo(level.enforcer, "linger_aim_1");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife("<frightened breaths/murmurs>", "dx_vom_ousa_interrogation_revolver_linger_ads_20");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_son("<frightened breaths/murmurs>", "dx_vom_amon_interrogation_revolver_linger_ads_30");
  level.enforceranimnode notify("stop_loop");
  level.enforceranimnode thread scripts\common\anim::anim_loop_solo(level.enforcer, "idle_interrogate_high");
  wait 2;
  level scripts\engine\sp\utility::wait_for_notify_or_timeout("defeated_state_family_ads", randomintrange(10, 13));
  scripts\engine\utility::flag_waitopen("pause_butcher_vo");
  level.enforceranimnode scripts\common\anim::anim_single_solo(level.enforcer, "linger_aim_2");
  level.enforceranimnode notify("stop_loop");
  level.enforceranimnode thread scripts\common\anim::anim_loop_solo(level.enforcer, "idle_interrogate_high");
  wait 2;
  level scripts\engine\sp\utility::wait_for_notify_or_timeout("defeated_state_family_ads", randomintrange(10, 13));
  scripts\engine\utility::flag_waitopen("pause_butcher_vo");
  level.enforceranimnode scripts\common\anim::anim_single_solo(level.enforcer, "linger_aim_3");
  level.enforceranimnode notify("stop_loop");
  level.enforceranimnode thread scripts\common\anim::anim_loop_solo(level.enforcer, "idle_interrogate_high");
  scripts\engine\utility::flag_waitopen("pause_family_vo");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife("Sergeant...", "dx_vom_ousa_interrogation_revolver_linger_ads_60");
  scripts\engine\utility::flag_waitopen("pause_family_vo");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife("Thank you for not hurting my son. He is a good boy...", "dx_vom_ousa_interrogation_revolver_linger_ads_70");
  wait 0.25;
  scripts\engine\utility::flag_waitopen("pause_family_vo");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_son("Momma...", "dx_vom_amon_interrogation_revolver_linger_ads_80");
  wait 0.25;
  scripts\engine\utility::flag_waitopen("pause_family_vo");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_son("Yes, you are a very good boy, and Momma is very proud of you...", "dx_vom_ousa_interrogation_revolver_linger_ads_90");
  wait 2;
  vo_interrogation_family_idle_loop();
  level scripts\engine\sp\utility::wait_for_notify_or_timeout("defeated_state_family_ads", randomintrange(10, 13));
  scripts\engine\utility::flag_waitopen("pause_butcher_vo");
  level.enforceranimnode scripts\common\anim::anim_single_solo(level.enforcer, "linger_aim_4");
  level.enforceranimnode notify("stop_loop");
  level.enforceranimnode thread scripts\common\anim::anim_loop_solo(level.enforcer, "idle_interrogate_high");
  level notify("interrogation_room_vo_exhausted");
}

vo_interrogation_linger_idle() {
  level endon("demeanor_monitor_end");
  level endon("interrogation_end");

  if(scripts\engine\utility::flag("enforcer_dead"))
    var_0 = 5;
  else {
    var_1 = level scripts\engine\utility::waittill_any_return("enforcer_dead", "interrogation_room_vo_exhausted", "price_hallway_nags_trigger");
    var_0 = scripts\engine\utility::ter_op(var_1 == "enforcer_dead", 8, 0);
  }

  wait(var_0);
  scripts\engine\utility::flag_waitopen("pause_price_vo");
  level.outeranimnode scripts\common\anim::anim_single_solo(level.price, "hallway_nags");
  level.outeranimnode notify("stop_loop");
  level.outeranimnode thread scripts\common\anim::anim_loop_solo(level.price, "hallway_idle");
  level.outeranimnode thread scripts\common\anim::anim_loop_solo(level.nikolai, "hallway_idle");
}

vo_interrogation_lines_setup() {
  level.voicelines["idle"][0] = ["Leave my family out of this!", "They have done nothing!"];
  level.voicelines["idle"][1] = ["(cries)", "We are not with him!", "Please, we have harmed no one!"];
  level.voicelines["idle"][2] = ["(cries)"];
  level.voicelines["ads_enforcer"][0] = [["Shoot me, Sergeant! Go on… kill me!", "dx_vom_enf_interrogation_revolver_aim_20"], ["Do it! Kill me, and you will never find what you are looking for!", "dx_vom_enf_interrogation_revolver_aim_30"], ["Go on, Sergeant! Show your Captain how tough you are... take a shot...", "dx_vom_enf_interrogation_revolver_aim_40"], ["Do it... do it...", "dx_vom_enf_interrogation_revolver_aim_50"]];
  level.voicelines["ads_enforcer_wife_dead"][0] = ["You coward!", "Do it!", "Just leave the boy alone!"];
  level.voicelines["ads_enforcer_son_dead"][0] = ["You son of a bitch!", "He was just a boy!"];
  level.voicelines["ads_family"][0] = ["Wait, don't shoot them!", "They are innocent!", "It's me you want!"];
  level.voicelines["ads_family_wife_dead"][0] = ["No!", "Please!", "He's just a boy!"];
  level.voicelines["ads_family_son_dead"][0] = ["No, no, no!", "Ousa! No, Ousa!", "Ousa, I am so sorry!"];
  level.voicelines["ads_family"][1] = ["No! Please!", "We've done nothing!", "Let us go!"];
  level.voicelines["melee_enforcer"][0] = ["Oof!"];
  level.voicelines["melee_family"][0] = ["Stop!", "No!", "Stop it!"];
  level.voicelines["melee_family_wife_dead"][0] = ["Stop!", "No!", "Stop it!"];
  level.voicelines["melee_family_son_dead"][0] = ["Stop!", "You'll kill them!", "Stop it!"];
  level.voicelines["melee_family"][1] = ["(screams)"];
  level.voicelines["shot_enforcer"][0] = ["Ahh!", "Gahhh!", "Fahhh!"];
  level.voicelines["shot_enforcer"][1] = [["(scream)", "dx_vom_ousa_interrogation_revolver_linger_kill_51"], ["(scream)", "dx_vom_ousa_interrogation_revolver_linger_kill_52"], ["(scream)", "dx_vom_ousa_interrogation_revolver_linger_kill_53"], ["(scream)", "dx_vom_ousa_interrogation_revolver_linger_kill_54"]];
  level.voicelines["shot_family"][0] = ["No!", "Bastard! Stop it!", "Shoot at me, you coward!"];
  level.voicelines["shot_family_wife_dead"][0] = ["Please!", "Do not hurt him!", "Let him be!"];
  level.voicelines["shot_family_son_dead"][0] = ["Stop!", "Leave her be!", "Shoot at me, you coward!"];
  level.voicelines["shot_family"][1] = ["(screams)"];
  level.voicelines["reaction_wife_death"][0] = ["Noooo!!"];
  level.voicelines["reaction_wife_death"][2] = ["(screams)"];
  level.voicelines["grieve_wife_death"][0] = ["Ousa!!!", "Gahhhh!", "She had nothing to do with this!"];
  level.voicelines["grieve_wife_death"][2] = ["(cries)", "Omi! Upi! Why?"];
  level.voicelines["reaction_son_death"][0] = ["Noooo!!"];
  level.voicelines["reaction_son_death"][1] = ["Amon!"];
  level.voicelines["grieve_son_death"][0] = ["Gahhhhh!", "You bastard!", "He was just a boy!"];
  level.voicelines["grieve_son_death"][1] = ["(cries)"];
  level.voicelines["reaction_family_death"][0] = ["Gahhhhh!"];
  level.voicelines["grieve_family_death"][0] = ["(cries) You fucking bastard!", "(cries) Go on! Finish it!", "(cries) Shoot me!", "I said shoot me! (cries)"];
  level.voicelines["reaction_enforcer_death"][1] = ["(screams)"];
  level.voicelines["reaction_enforcer_death"][2] = ["(screams)"];
  level.voicelines["grieve_enforcer_death"][1] = ["Please! No more! Do not do this!", "Please let us go! We have harmed no one!", "We knew he was a bad man! That's why we left!", "I'm begging you -- please! Don't!"];
  level.voicelines["grieve_enforcer_death"][2] = ["(cries)"];
  level.voicelines["inactive"][0] = ["You don't have to do this.", "Please just let them go."];
  level.voicelines["inactive_wife_dead"][0] = ["You hesitate.", "Please -- there has been enough bloodshed.", "Let us mourn."];
  level.voicelines["inactive_son_dead"][0] = ["You hesitate.", "Please -- there has been enough bloodshed.", "Let us mourn."];
  level.voicelines["inactive_enforcer_dead"][1] = ["I don't understand.", "Is it over?", "Will you -- let us live?"];
  level.voicelines["ads_defeated"][0] = ["Do what you want.", "I have nothing more to say.", "..."];
}

play_line_and_rotate(var_0, var_1) {
  if(level.alivestates[var_1]) {
    switch (var_1) {
      case 0:
        thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher(level.voicelines[var_0][var_1][0]);
        break;
      case 1:
        thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife(level.voicelines[var_0][var_1][0]);
        break;
      case 2:
        thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_son(level.voicelines[var_0][var_1][0]);
        break;
    }

    level.voicelines[var_0][var_1] = scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::array_rotate(level.voicelines[var_0][var_1]);
    return 1;
  } else
    return 0;
}

play_line_no_rotate(var_0, var_1) {
  if(level.alivestates[var_1] && level.voicelines[var_0][var_1].size > 0) {
    switch (var_1) {
      case 0:
        thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher(level.voicelines[var_0][var_1][0]);
        break;
      case 1:
        thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife(level.voicelines[var_0][var_1][0]);
        break;
      case 2:
        thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_son(level.voicelines[var_0][var_1][0]);
        break;
    }

    level.voicelines[var_0][var_1] = scripts\engine\utility::array_remove_index(level.voicelines[var_0][var_1], 0);
    return 1;
  } else
    return 0;
}

vo_interrogation_enforcer_ads() {
  if(!scripts\engine\utility::flag("pause_butcher_vo")) {
    if(level.voicelines["ads_enforcer"][0].size > 0) {
      level.enforcer scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::dialogue_stop_and_clear_stack();
      waitframe();
      thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher(level.voicelines["ads_enforcer"][0][0][0], level.voicelines["ads_enforcer"][0][0][1]);
      level.voicelines["ads_enforcer"][0] = scripts\engine\utility::array_remove_index(level.voicelines["ads_enforcer"][0], 0);
    } else
      level.revolvervodone["ads_enforcer"] = 1;
  }
}

vo_interrogation_enforcer_ads_family_reaction() {
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife("<frightened breaths/murmurs>", "dx_vom_ousa_interrogation_revolver_aim_60");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_son("<frightened breaths/murmurs>", "dx_vom_amon_interrogation_revolver_aim_70");
  vo_interrogation_family_idle_loop();
}

vo_interrogation_enforcer_melee() {
  play_line_and_rotate("melee_enforcer", 0);
}

vo_interrogation_family_melee() {
  if(level.alivestates[1] && level.alivestates[2]) {
    if(level.alivestates[0])
      play_line_and_rotate("melee_family", 0);

    wait 0.5;
    play_line_and_rotate("melee_family", 1);
  } else if(!level.alivestates[1] && !level.alivestates[2]) {
    return;
  }
  if(!level.alivestates[1])
    play_line_and_rotate("melee_family_wife_dead", 0);
  else if(!level.alivestates[2])
    play_line_and_rotate("melee_family_son_dead", 0);
}

vo_interrogation_enforcer_shot() {
  level notify("butcher_shot_vo");
  level endon("butcher_shot_vo");
  level endon("enforcer_dead");
  var_0 = ["dx_vom_enf_interrogation_revolver_linger_kill_20", "dx_vom_enf_interrogation_revolver_linger_kill_21", "dx_vom_enf_interrogation_revolver_linger_kill_22", "dx_vom_enf_interrogation_revolver_linger_kill_23", "dx_vom_enf_interrogation_revolver_linger_kill_24", "dx_vom_enf_interrogation_revolver_linger_kill_25"];
  var_1 = ["dx_vom_enf_interrogation_revolver_linger_kill_30", "dx_vom_enf_interrogation_revolver_linger_kill_31", "dx_vom_enf_interrogation_revolver_linger_kill_32", "dx_vom_enf_interrogation_revolver_linger_kill_33", "dx_vom_enf_interrogation_revolver_linger_kill_34", "dx_vom_enf_interrogation_revolver_linger_kill_35"];
  level.enforcer scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::dialogue_stop_and_clear_stack();
  wait 0.1;
  var_2 = randomint(6);
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher(undefined, var_0[var_2], undefined, undefined, undefined, undefined, 1);
  var_0 = scripts\engine\utility::array_remove_index(var_0, var_2);
  wait 0.5;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher(undefined, var_1[var_2], undefined, undefined, undefined, undefined, 1);
  var_1 = scripts\engine\utility::array_remove_index(var_1, var_2);
}

vo_interrogation_family_scream() {
  level.enforcerwife scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::dialogue_stop_and_clear_stack();
  waitframe();
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife(level.voicelines["shot_enforcer"][1][0][0], level.voicelines["shot_enforcer"][1][0][1], undefined, undefined, undefined, undefined, 1);
  level.voicelines["shot_enforcer"][1] = scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::array_rotate(level.voicelines["shot_enforcer"][1]);
}

vo_interrogation_wife_death() {}

vo_interrogation_son_death() {}

vo_interrogation_family_death() {}

vo_interrogation_enforcer_death() {
  level endon("interrogation_end");
  level.enforcerwife scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::dialogue_stop_and_clear_stack();
  wait 0.2;
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_son("<frightened breaths/murmurs>", "dx_vom_amon_interrogation_revolver_linger_kill_70", undefined, undefined, undefined, undefined, 1);
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife("<screams>", "dx_vom_ousa_interrogation_revolver_linger_kill_55", undefined, undefined, undefined, undefined, 1);
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife("No!", "dx_vom_ousa_interrogation_revolver_linger_kill_10", undefined, undefined, undefined, undefined, 1);
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_butcher_wife("Shhh", "dx_vom_ousa_interrogation_revolver_linger_kill_50", undefined, undefined, undefined, undefined, 1);
  vo_interrogation_family_idle_loop();
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\hometown\hometown_vo.gsc
***********************************************/

main() {}

register_buried_sources() {
  var_0 = level.player getEye();
  scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source_at_pos("rescuer_1", "Rescuer 1", var_0 + (0, 0, 60));
  scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source_at_pos("rescuer_2", "Rescuer 2", var_0 + (0, 0, 60));
  scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source_at_pos("rescuer_3", "Rescuer 3", var_0 + (0, 0, 60));
  scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source_at_pos("rescuer_4", "Rescuer 4", var_0 + (-400, 400, 60));
  scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source_at_pos("rescuer_5", "Rescuer 5", var_0 + (-350, 450, 60));
  scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source_at_pos("rescuer_6", "Rescuer 6", var_0 + (400, 400, 60));
  scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source_at_pos("rescuer_7", "Rescuer 7", var_0 + (350, 450, 60));
  scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source_at_pos("civilian_1", "Civilian 1", var_0 + (-350, -450, 60));
  scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source_at_pos("civilian_2", "Civilian 2", var_0 + (-400, -500, 60));
  scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source_at_pos("father", "Father", (2215, 900, 60));
  level.player scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("farah", "Farah");
}

buried_start_vo() {
  level endon("buried_complete");
  level endon("buried_scene_start_vo");
  register_buried_sources();
  childthread start_weak_moans();
  childthread wait_pull_arm();
  childthread wait_grab_tile();
  childthread farah_hit_grunts();
  wait 1;
  childthread buried_background_conversations();
  wait 1;
  buried_unheard_yells();
  buried_heard_yells();
}

start_weak_moans() {
  level endon("farah_pulled_arm");
  wait 1;
  level.player scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_far_buried_start_rubble_10");
}

buried_unheard_yells() {
  level endon("farah_buried_vo_press");
  var_0 = load_rubble_res1_yells_01();
  var_1 = load_rubble_res2_yells_01();
  var_2 = load_rubble_res3_yells_01();
  var_3 = load_rubble_dad_yells_01();
  var_4 = load_rubble_res1_calming_01();
  var_5 = load_rubble_res1_yells_02();
  var_6 = load_rubble_res2_yells_02();
  var_7 = load_rubble_res3_yells_02();
  var_8 = load_rubble_res1_yells_03();
  var_9 = load_rubble_res2_yells_03();
  var_10 = load_rubble_res3_yells_03();
  wait 1;
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();
  wait 0.8;
  var_11 = 0.4;
  var_12 = 1;
  var_13 = 100;
  var_14 = 100;

  for(;;) {
    var_1 thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();
    var_1 wait_plus_minus_vo_bucket_duration(var_11, var_12);
    var_2 thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();
    var_2 wait_plus_minus_vo_bucket_duration(var_11, var_12);
    var_15 = randomfloatrange(0, 100);

    if(var_15 < var_13) {
      var_3 scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();
      var_4 thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();
      var_4 wait_plus_minus_vo_bucket_duration(var_11, var_12);

      if(var_13 > 20)
        var_13 = var_13 - 20;
    }

    var_6 thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();
    var_6 wait_plus_minus_vo_bucket_duration(var_11, var_12);
    var_7 thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();
    var_7 wait_plus_minus_vo_bucket_duration(var_11, var_12);
    var_5 thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();
    var_5 wait_plus_minus_vo_bucket_duration(var_11, var_12);
    var_15 = randomfloatrange(0, 100);

    if(var_15 < var_14) {
      var_3 scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();
      var_4 thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();
      var_4 wait_plus_minus_vo_bucket_duration(var_11, var_12);
      var_14 = var_14 - 33.334;
    }

    var_9 thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();
    var_9 wait_plus_minus_vo_bucket_duration(var_11, var_12);
    var_8 thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();
    var_8 wait_plus_minus_vo_bucket_duration(var_11, var_12);
    var_10 thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();
    var_10 wait_plus_minus_vo_bucket_duration(var_11, var_12);
  }
}

wait_plus_minus_vo_bucket_duration(var_0, var_1) {
  var_2 = self;
  var_3 = var_2.last_played.duration;
  wait(randomfloatrange(var_3 * var_0, var_3 + var_1));
}

buried_background_conversations() {
  level endon("farah_buried_vo_press");
  var_0 = load_rubble_res4_5_getwater_01();
  var_1 = load_rubble_res6_7_getrope_01();
  var_2 = load_rubble_civ1_2_phone_convo_01();
  wait 5;

  for(;;) {
    var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket_looping(0.1, 1);
    var_1 scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket_looping(0.1, 1);
    var_2 scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket_looping(0.1, 1);
  }
}

wait_pull_arm() {
  level endon("tile_grab_vo");
  level waittill("farah_pulled_arm");
  level.player scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_far_buried_start_rubble_725", 1);
  level.player scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_far_buried_start_rubble_730", 1);
  level.player scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_far_buried_start_rubble_740", 1);
}

wait_grab_tile() {
  level endon("farah_buried_vo_press");
  level waittill("tile_grab_vo");
  wait 2.5;
  level.player scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_far_buried_start_rubble_1040", 1);
  level.player scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_far_buried_start_rubble_1045", 1);
  level.player scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_far_buried_start_rubble_1050", 1);
}

farah_hit_grunts() {
  var_0 = ["dx_vom_far_buried_start_noise1_10", "dx_vom_far_buried_start_noise2_10", "dx_vom_far_buried_start_noise3_10"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0);

  for(;;) {
    level waittill("farah_buried_vo_press_begin");
    level.player thread scripts\sp\maps\hometown\hometown_vo_util.gsc::say(var_1 scripts\engine\sp\utility::deck_draw(), 1);
  }
}

buried_heard_yells() {
  var_0 = 0;
  level.player scripts\engine\utility::delaycall(2.0, ::setclienttriggeraudiozone, "ht_rubble_underneath_people_near", 3.5);
  play_rescuer_reaction01();
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("father", "dx_vom_dad_buried_start_noise1_50", "That's them, I told you...!");

  if(level.rebar_hits > 1) {
    level.rebar_hits = 1;
    scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("rescuer_2", "dx_vom_re2_buried_start_noise2_70", "Keep going, we hear you!");
  } else {
    wait 0.2;
    play_rescuer_nags();
    var_0 = play_rescuer_reaction02(0);
  }

  if(level.rebar_hits < 2) {
    play_rescuer_nags();
    play_rescuer_reaction02(var_0);
  }

  level notify("buried_hit_vo_finished");
  level.buried_vo_finished = 1;
}

play_rescuer_reaction01() {
  if(!scripts\sp\maps\hometown\hometown_vo_util.gsc::get_vo_source_is_speaking("rescuer_1"))
    scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("rescuer_1", "dx_vom_re1_buried_start_noise1_10", "Quiet! Quiet! I heard something!");
  else if(!scripts\sp\maps\hometown\hometown_vo_util.gsc::get_vo_source_is_speaking("rescuer_2"))
    scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("rescuer_2", "dx_vom_re2_buried_start_noise1_20", "Shh...shh... Listen, listen...");
  else
    scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("rescuer_3", "dx_vom_re3_buried_start_noise1_30", "Did you hear that?");
}

play_rescuer_nags() {
  var_0 = load_noise_res_nags();
  level endon("farah_buried_vo_press");

  for(;;) {
    var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();
    wait 0.1;
  }
}

play_rescuer_reaction02(var_0) {
  if(!scripts\sp\maps\hometown\hometown_vo_util.gsc::get_vo_source_is_speaking("rescuer_1") && var_0 != 1) {
    scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("rescuer_1", "dx_vom_re1_buried_start_noise1_40", "Here, here, over here...");
    return 1;
  } else if(!scripts\sp\maps\hometown\hometown_vo_util.gsc::get_vo_source_is_speaking("rescuer_2") && var_0 != 2) {
    scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("rescuer_2", "dx_vom_re2_buried_start_noise2_40", "Keep making noise so we can find you!");
    return 2;
  } else {
    scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("rescuer_3", "dx_vom_re3_buried_start_noise2_90", "Someone’s in there, I heard the sound.");
    return 3;
  }
}

carried_start_vo() {
  level endon("alley_vo_started");
  level waittill("buried_scene_start_vo");
  var_0 = level.player gettagorigin("tag_eye");
  wait 28.85;
  scripts\sp\maps\hometown\hometown_vo_util.gsc::unregister_all_vo_sources();
  childthread scripts\engine\utility::play_sound_in_space("dx_vom_dad_carried_start_rescue_140", (2207, 885, 60));
  wait 64.15;
  attack_sequence();
}

attack_sequence() {
  thread scripts\engine\utility::play_sound_in_space("dx_vom_cvm1_carried_start_attack_10", (414.682, -797.072, 60));
  wait 30;
  childthread russian_vo();
}

russian_vo() {
  var_0 = spawn("script_origin", (487, -956, 60));
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_ru1_carried_start_attack_60");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_ru1_carried_start_attack_70");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_ru2_carried_start_attack_80");
  var_0 delete();
}

alley_start_vo() {
  level.player endon("death");
  level notify("alley_vo_started");
  level.player endon("farah_entered_house_notify");
  var_0 = [];
  var_0[var_0.size] = "dx_vom_dad_alley_sneak_71";
  var_0[var_0.size] = "dx_vom_dad_alley_sneak_72";
  var_0[var_0.size] = "dx_vom_dad_alley_sneak_73";
  var_0[var_0.size] = "dx_vom_dad_alley_sneak_74";
  var_0[var_0.size] = "dx_vom_dad_alley_sneak_75";
  var_0[var_0.size] = "dx_vom_dad_alley_street_32";
  var_0[var_0.size] = "dx_vom_dad_alley_street_34";
  var_1 = scripts\engine\sp\utility::create_deck(var_0);
  var_0 = [];
  var_0[var_0.size] = "dx_vom_dad_alley_street_31";
  var_0[var_0.size] = "dx_vom_dad_alley_street_33";
  var_0[var_0.size] = "dx_vom_dad_alley_street_35";
  var_0[var_0.size] = "dx_vom_dad_alley_street_36";
  var_0[var_0.size] = "dx_vom_dad_alley_street_37";
  var_2 = scripts\engine\sp\utility::create_deck(var_0);
  level.farah_father_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::nagtill_distance(8, "alley_pre_start_passed", var_2, var_1, 300, 5);
  wait 2;
  level.farah_father_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_dad_alley_sneak_60");
  level.farah_father_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::nagtill_distance(8, "alley_start_passed", var_2, var_1, 300, 5);
  level.farah_father_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_dad_alley_street_10");
  level.farah_father_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::nagtill_distance(8, "alley_mid_passed", var_2, var_1, 300, 5);
  level.farah_father_ai childthread wrong_way_warning();
  wait 0.5;
  level.farah_father_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_dad_alley_street_30");
  wait 0.5;
  thread civilian_death_sequence_01();
  wait 0.5;
  level.farah_father_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_dad_alley_street_20");
  thread injured_civilian_reactions();
  level.farah_father_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::nagtill_distance(8, "alley_attack_start_passed", var_2, var_1, 300, 5);
  thread civilian_gas_reactions();
  level.farah_father_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_dad_alley_street_150", 1);
  wait 4.5;
  level.farah_father_ai thread scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_dad_alley_triage_90");
  wait 1;
  level.player thread scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_far_alley_triage_95");
  level.farah_father_ai scripts\sp\maps\hometown\hometown_util.gsc::wait_near((-1263.7, -2491.46, 23), 80);
  level.farah_father_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_dad_alley_house_10");
  wait 0.3;
  var_3 = (-1277, -2494, 160);
  level.farah_father_ai say_if_good_distance("dx_vom_dad_alley_house_20", var_3, 0.6);
  wait 0.3;
  level.farah_father_ai say_if_good_distance("dx_vom_dad_alley_house_50", var_3, 0.6);
}

say_if_good_distance(var_0, var_1, var_2) {
  var_3 = get_min_time_to_point(var_1[0], var_1[1], length2d(level.player getvelocity()));

  if(scripts\sp\maps\hometown\hometown_vo_util.gsc::get_player_progress_toward_self() <= 0.5)
    scripts\sp\maps\hometown\hometown_vo_util.gsc::say(var_0);
  else if(var_3 > lookupsoundlength(var_0) / 1000 * var_2)
    scripts\sp\maps\hometown\hometown_vo_util.gsc::say(var_0);
}

get_min_time_to_point(var_0, var_1, var_2) {
  if(!isDefined(var_2) || var_2 == 0)
    return 2147483647;

  var_3 = (var_0, var_1, 0);
  var_4 = distance2d(level.player.origin, var_3);
  return var_4 / var_2;
}

wrong_way_warning() {
  childthread alley_wrong_way_spotted();
  level endon("stop_all_wrong_way_warnings");
  var_0 = [];
  var_0[var_0.size] = "dx_vom_dad_alley_street_106";
  var_0[var_0.size] = "dx_vom_dad_alley_street_105";
  var_0[var_0.size] = "dx_vom_dad_alley_street_104";
  var_0[var_0.size] = "dx_vom_dad_alley_street_103";
  var_0[var_0.size] = "dx_vom_dad_alley_street_102";
  var_0[var_0.size] = "dx_vom_dad_alley_street_101";
  var_1 = scripts\engine\sp\utility::create_deck(var_0, 0);
  var_1.autoshuffle = 1;

  for(;;) {
    while(level.player.origin[0] < -400 || scripts\sp\maps\hometown\hometown_vo_util.gsc::get_player_progress_toward_self() > 0.7)
      waitframe();

    thread scripts\sp\maps\hometown\hometown_vo_util.gsc::nagtill("stop_wrong_way_nag", var_1, 3, 1.3, 8);

    while(scripts\sp\maps\hometown\hometown_vo_util.gsc::get_player_progress_toward_self() < 0.7 && level.player.origin[0] > -400)
      waitframe();

    self notify("stop_wrong_way_nag");
  }
}

alley_wrong_way_spotted() {
  for(;;) {
    level waittill("stealth_event", var_0);

    if(var_0.type == "cover_blown" || var_0.type == "combat") {
      level notify("stop_all_wrong_way_warnings");
      level.farah_father_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::say_as_chatter("dx_vom_dad_alley_street_102", 1);
      level.russian_shooter_3_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::say_as_chatter("dx_vom_ru3_alley_street_110");
      level.russian_shooter_2_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::say_as_chatter("dx_vom_ru2_alley_street_120");
      return;
    }
  }
}

injured_civilian_reactions() {
  wait 4;
  level.gasattack_civ_female_01 scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("civilian_female_1");
  level.gasattack_civ_male_01 scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("civilian_male_1");
  level.gasattack_civ_male_02 scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("civilian_male_2");
  level.gasattack_civ_male_03 scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("civilian_male_3");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_male_1", "dx_vom_cvm1_alley_triage_10", "Bring water! Get the bandages!");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_male_2", "dx_vom_cvm2_alley_triage_20", "No, we have to take them to a hospital!");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_male_1", "dx_vom_cvm1_alley_triage_30", "They won't make it! We'll sew them up here.");
}

civilian_gas_reactions() {
  wait 1;
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_male_2", "dx_vom_cvm2_alley_triage_40", "What's that sound?");
  wait 3.5;
  thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_male_1", "dx_vom_cvm1_alley_triage_50", "Please! No!");
  wait 0.3;
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_male_2", "dx_vom_cvm2_alley_triage_60", "Have mercy!");
  thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_male_1", "dx_vom_cvm1_alley_triage_70", "<choking sounds>");
  wait 0.2;
  thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_male_2", "dx_vom_cvm2_alley_triage_80", "<choking sounds>");
  wait 0.1;
  thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_male_1", "dx_vom_cvm1_alley_triage_100", "<coughing/pain efforts>");
  wait 0.05;
  thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_male_2", "dx_vom_cvm2_alley_triage_110", "<coughing/pain efforts>");
  wait 0.75;
  thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_male_3", "dx_vom_cvm3_alley_triage_120", "<coughing/pain efforts>");
}

civilian_death_sequence_01() {
  level scripts\engine\utility::play_sound_in_space("dx_vom_cvm2_alley_street_40", (550, -1030, 10));
  level.russian_shooter_2_ai scripts\engine\sp\utility::smart_dialogue("dx_vom_ru2_alley_street_60");
  wait 0.1;
  level.russian_shooter_2_ai scripts\engine\sp\utility::smart_dialogue("dx_vom_ru2_alley_street_70");
  level.russian_shooter_3_ai scripts\engine\sp\utility::smart_dialogue("dx_vom_ru3_alley_street_80");
  level.russian_shooter_2_ai scripts\engine\sp\utility::smart_dialogue("dx_vom_ru2_alley_street_90");
}

register_house_enter_vo_sources() {
  level.farah_father_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("father", "Father");
  level.hadir_body_model scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("hadir", "Hadir");
  level.player scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("farah", "Farah");
}

house_enter_start_vo() {
  level.player endon("grabbed_by_boss");

  if(scripts\sp\maps\hometown\hometown_util.gsc::skipchildrenkillingscene())
    level endon("house_enter_boss_anim_complete");

  level.player scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("farah", "Farah");
  level.player scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_far_house_enter_reunion_00", 1);
  level.player scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_far_house_enter_reunion_05");
  scripts\engine\utility::flag_wait("objective_prepare_to_escape");
  thread wait_for_get_phone();
  level waittill("waiting_in_foyer");
  nag_get_to_foyer();
  register_house_enter_vo_sources();
  scripts\engine\utility::flag_wait("russian_entered_house");
  wait 47.25;
  level notify("stop_farah_reaction");

  if(level.player scripts\sp\maps\hometown\hometown_util.gsc::get_is_looking_at(level.farah_father_ai, undefined, "j_chest", 1))
    level.player scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_far_house_boss_dadfight_60");

  thread farah_idle_hide_hints();
  wait 10;
  play_start_hunting_vo();
}

nag_get_to_foyer() {
  var_0 = [];
  var_0[var_0.size] = "dx_vom_dad_house_enter_foyer_70";
  var_0[var_0.size] = "dx_vom_dad_house_enter_foyer_80";
  var_0[var_0.size] = "dx_vom_dad_house_enter_foyer_90";
  var_0[var_0.size] = "dx_vom_dad_house_enter_foyer_100";
  var_0[var_0.size] = "dx_vom_dad_house_enter_foyer_110";
  var_0[var_0.size] = "dx_vom_dad_house_enter_foyer_111";
  var_0[var_0.size] = "dx_vom_dad_house_enter_foyer_120";
  var_0[var_0.size] = "dx_vom_dad_house_enter_foyer_130";
  var_0[var_0.size] = "dx_vom_dad_house_enter_kitchen_13";
  var_0[var_0.size] = "dx_vom_dad_house_enter_kitchen_14";
  var_1 = scripts\engine\sp\utility::create_deck(var_0);
  level.farah_father_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::nagtill_delayed(10, "player_went_to_foyer", var_1, 12, 1.2, 20);
}

wait_for_get_phone() {
  level endon("player_got_phone");
  var_0 = [];
  var_0[var_0.size] = "dx_vom_dad_house_enter_kitchen_10";
  var_0[var_0.size] = "dx_vom_dad_house_enter_kitchen_11";
  var_0[var_0.size] = "dx_vom_dad_house_enter_kitchen_12";
  var_0[var_0.size] = "dx_vom_dad_house_enter_kitchen_13";
  var_0[var_0.size] = "dx_vom_dad_house_enter_kitchen_14";
  var_1 = scripts\engine\sp\utility::create_deck(var_0);
  var_0 = [];
  var_0[var_0.size] = "dx_vom_dad_house_enter_kitchen_20";
  var_0[var_0.size] = "dx_vom_dad_house_enter_kitchen_25";
  var_2 = scripts\engine\sp\utility::create_deck(var_0);
  var_3 = getEnt("kitchen", "script_noteworthy");

  for(;;) {
    level.farah_father_ai childthread scripts\sp\maps\hometown\hometown_vo_util.gsc::nagtill_delayed(8, "stop_phone_nags", var_2, 12, 1.2);

    while(level.player istouching(var_3))
      waitframe();

    level.farah_father_ai notify("stop_phone_nags");
    level.farah_father_ai childthread scripts\sp\maps\hometown\hometown_vo_util.gsc::nagtill_delayed(5, "stop_kitchen_nags", var_1, 14, 1.8, 60);

    while(!level.player istouching(var_3))
      var_3 waittill("trigger");

    level.farah_father_ai notify("stop_kitchen_nags");
  }
}

register_house_boss_vo_sources() {
  level.hadir_body_model scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("hadir", "Hadir");
  level.player scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("farah", "Farah");
  level.goliath_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("russian_j12", "Russian J-12");
  level.goliath_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source_attached("russian_j13", "Russian J-13", "tag_stowed_hip_rear");
}

house_boss_start_vo() {
  register_house_boss_vo_sources();
  thread lookat_brother_vo();
  level.boss_vo = spawnStruct();
  level.boss_vo.last_stab_time = -10000000;
  level.boss_vo.start_time = gettime();
  goto_boss_phase(0);
  thread update_boss_vo_context();
  thread start_boss_checks();
  thread check_stabbed();
  thread check_grabbed();
  thread check_stab_countered();
  thread boss_struggle_vo();
}

farah_idle_hide_hints() {
  level.player endon("death");
  level.player endon("grabbed_by_boss");
  level endon("boss_stab_vo_start");
  level endon("boss_struggle_vo_start");
  level endon("goliath_weapon_exists");
  wait_not_hidden_for_time(6);
  wait 0.5;
  level.player scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_far_house_boss_hide_20");
  wait_not_hidden_for_time(12);
  wait 0.5;
  level.player scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_far_house_boss_hide_10");
}

wait_not_hidden_for_time(var_0) {
  var_1 = gettime();
  var_2 = var_0;
  var_3 = [level.goliath_ai, level.player];
  var_4 = scripts\engine\trace::create_ainosight_contents();

  for(;;) {
    var_5 = !scripts\engine\trace::ray_trace_passed(level.player.origin + (0, 0, 5), level.player.origin + (0, 0, 50), [level.player], scripts\engine\trace::create_all_contents());

    if(var_5)
      var_1 = gettime();

    var_6 = scripts\engine\utility::time_has_passed(var_1, var_2);
    var_7 = scripts\engine\trace::ray_trace_passed(level.goliath_ai getEye(), level.player getEye(), var_3, var_4);

    if(var_6 && var_7) {
      break;
    }

    waitframe();
  }
}

check_stab_countered() {
  level endon("boss_struggle_vo_start");
  level waittill("boss_counter_vo_start");
  stop_boss_checks();

  switch (level.player.context_melee_animation) {
    case "boss_counter_left":
      thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line_delayed(0.85, "farah", "dx_vom_far_house_boss_stab3_20", "<choking/struggling efforts>");
      wait 0.15;
      scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("russian_j12", "dx_vom_rj12_house_boss_caught_30", "What do we have here?!");
      scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("russian_j12", "dx_vom_rj12_house_boss_caught_20", "Got you, suka!");
      scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("russian_j12", "dx_vom_rj12_house_boss_stab3_50", "That’s it... go to sleep. Go to sleep...");
      break;
    case "boss_counter_right":
      thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line_delayed(1.5, "farah", "dx_vom_far_house_boss_stab1_25", "<stab effort>");
      thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line_delayed(4.25, "farah", "dx_vom_far_house_boss_stab1_00", "<hurt/getting hit by soldier>");
      scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("russian_j12", "dx_vom_rj12_house_boss_caught_10", "There you are!");
      scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("russian_j12", "dx_vom_rj12_house_boss_stab1_80", "Noisey little rat!");
      break;
    case "boss_counter_back":
      thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line_delayed(0.65, "farah", "dx_vom_far_house_boss_stab3_20", "<choking/struggling efforts>");
      wait 0.15;
      scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("russian_j12", "dx_vom_rj12_house_boss_caught_40", "You little rat!");
      wait 0.1;
      scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("russian_j12", "dx_vom_rj12_house_boss_stab3_30", "Trying to kill me?!");
      wait 1;
      scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("russian_j12", "dx_vom_rj12_house_boss_stab1_70", "Too slow , suka!");
      break;
    case "boss_counter_front":
      thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line_delayed(1.75, "farah", "dx_vom_far_house_boss_stab1_25", "<hurt/getting hit by soldier>");
      scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("russian_j12", "dx_vom_rj12_house_boss_stab3_10", "Bitch!");
      wait 0.85;
      scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("russian_j12", "dx_vom_rj12_house_boss_stab3_40", "Lose to a child- fucking girl...?!, no way...!");
      break;
    default:
      break;
  }
}

play_start_hunting_vo() {
  level.goliath_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("russian_j12", "Russian J-12");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("russian_j12", "dx_vom_rj12_house_boss_patrol_10", "Sonovabitch!");
  wait 0.45;
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("russian_j12", "dx_vom_rj12_house_boss_patrol_20", "Fuck you. Piece of shit.");
}

update_boss_vo_context() {
  level endon("boss_struggle_vo_start");

  for(;;) {
    waitframe();
    var_0 = scripts\engine\trace::ray_trace_passed(level.goliath_ai getEye(), level.player getEye(), [level.player, level.goliath_ai], scripts\engine\trace::create_ainosight_contents());
    level.boss_vo.context["can_see_player"] = var_0;
    var_1 = !scripts\engine\trace::ray_trace_passed(level.player.origin + (0, 0, 5), level.player.origin + (0, 0, 50), [level.player], scripts\engine\trace::create_all_contents());
    level.boss_vo.context["player_under_something"] = var_1;
  }
}

lookat_brother_vo() {
  level endon("boss_struggle_vo_start");
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("farah", "dx_vom_far_house_boss_brother_40", "Brother...?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("farah", "dx_vom_far_house_boss_brother_50", "Hadir...?");
  var_1 = 0;
  var_2 = level.hadir_body_model gettagorigin("j_clavicle_ri");

  while(isDefined(level.hadir_body_model)) {
    level.player scripts\sp\maps\hometown\hometown_util.gsc::wait_lookat(var_2, 150, undefined, 0.3, 35);
    var_1++;
    var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();

    if(var_0.open_lines.size > 0) {
      wait 2;
      continue;
    }

    wait 5;
  }
}

cool_circle(var_0, var_1, var_2) {
  self endon("stop_drawing_cool_circle");

  for(;;) {
    var_3 = var_2;
    var_4 = 50;

    for(var_5 = 0; var_5 < var_4; var_5++) {
      scripts\engine\utility::draw_circle(var_0 + (0, 0, var_3), var_1, (1, 1, 1), 1 - var_5 / var_4, 1, 1);
      var_3 = var_3 + 0.5;
    }

    waitframe();
  }
}

check_grabbed() {
  level endon("boss_struggle_vo_start");
  level.player waittill("grabbed_by_boss");
  level.boss_vo notify("stop_checks");
  wait 1.3;
  thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("farah", "dx_vom_far_house_boss_stab3_20", "<choking/struggling efforts>");
  wait 0.7;
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("russian_j12", "dx_vom_rj12_house_boss_stab3_50", "You're coming with me...");
}

skip_to_final_phase() {
  level.goliath_boss_round = 2;

  for(var_0 = 0; var_0 <= 4; var_0++)
    goto_boss_phase(var_0);

  level.player waittill("knife_change");
}

start_boss_checks() {
  level.goliath_ai endon("death");
  level.player endon("death");
  level.boss_vo endon("stop_checks");
  level endon("boss_stab_vo_start");
  level endon("boss_struggle_vo_start");
  level.boss_vo thread start_idle();
  level.boss_vo childthread check_heard_player();
  level.boss_vo childthread check_found_player();
  level.boss_vo childthread check_lost_player();
}

stop_boss_checks() {
  level.boss_vo notify("stop_checks");
}

start_idle() {
  level.player endon("death");
  level.goliath_ai endon("death");
  level.boss_vo endon("stop_idle");
  level.boss_vo endon("stop_checks");
  level endon("boss_stab_vo_start");
  level endon("boss_struggle_vo_start");

  if(level.goliath_ai[[level.goliath_ai.fnisinstealthcombat]]())
    idle_combat();
  else
    idle_hunt();
}

stop_idle() {
  level.boss_vo notify("stop_idle");
}

goto_boss_phase(var_0) {
  if(isDefined(level.boss_vo.phase) && level.boss_vo.phase == var_0) {
    return;
  }
  switch (var_0) {
    case 0:
      level.boss_vo.noise = load_noise0();
      level.boss_vo.spotted = load_spotted0();
      level.boss_vo.lost = load_lost0();
      level.boss_vo.hunt = load_hunt0();
      level.boss_vo.hunt_loop = load_hunt0_loop();
      level.boss_vo.combat = load_combat0();
      level.boss_vo.combat_loop = load_combat0_loop();
      break;
    case 1:
      level.boss_vo.noise = load_noise1();
      level.boss_vo.spotted = load_spotted1();
      level.boss_vo.lost = load_lost1();
      level.boss_vo.hunt = load_hunt1();
      level.boss_vo.hunt_loop = load_hunt1_loop();
      level.boss_vo.combat = load_combat1();
      level.boss_vo.combat_loop = load_combat1_loop();
      break;
    case 2:
      level.boss_vo.noise = load_noise2();
      level.boss_vo.spotted = load_spotted2();
      level.boss_vo.lost = load_lost2();
      level.boss_vo.hunt = load_hunt2();
      level.boss_vo.hunt_loop = load_hunt2_loop();
      level.boss_vo.combat = load_combat2();
      level.boss_vo.combat_loop = load_combat2_loop();
      break;
    case 3:
      level.boss_vo.noise = load_noise3();
      level.boss_vo.spotted = load_spotted3();
      level.boss_vo.lost = load_lost3();
      level.boss_vo.hunt = load_hunt3();
      level.boss_vo.hunt_loop = load_hunt3_loop();
      level.boss_vo.combat = load_combat3();
      level.boss_vo.combat_loop = load_combat3_loop();
      break;
    case 4:
      level.boss_vo.noise = load_noise4();
      level.boss_vo.spotted = load_spotted4();
      level.boss_vo.lost = load_lost4();
      level.boss_vo.hunt = load_hunt4();
      level.boss_vo.hunt_loop = load_hunt4_loop();
      level.boss_vo.combat = load_combat4();
      level.boss_vo.combat_loop = load_combat4_loop();
      break;
    default:
      break;
  }

  level.boss_vo.phase = var_0;
}

check_heard_player() {
  var_0 = -1;

  for(;;) {
    level waittill("stealth_event", var_1);

    if(var_1.type == "combat") {
      continue;
    }
    if(level.goliath_ai[[level.goliath_ai.fnisinstealthcombat]]() || !scripts\engine\utility::time_has_passed(level.boss_vo.last_stab_time, 10)) {
      continue;
    }
    thread heard_player(var_0);
    var_0 = gettime();
  }
}

heard_player(var_0) {
  level endon("stealth_event");
  stop_idle();

  if(scripts\engine\utility::time_has_passed(var_0, 1))
    level.boss_vo.noise scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();

  if(level.boss_vo.phase == 0 && level.boss_vo.lost.open_lines.size == 0)
    goto_boss_phase(1);

  if(level.boss_vo.phase == 0)
    play_giveup_after_time();

  thread start_idle();
}

check_found_player() {
  level.player endon("death");

  for(;;) {
    level.goliath_ai waittill("stealth_combat");
    found_player();
  }
}

found_player() {
  if(level.boss_vo.phase < 2)
    goto_boss_phase(2);

  stop_idle();

  if(scripts\engine\utility::time_has_passed(level.boss_vo.last_stab_time, 10))
    level.boss_vo.spotted scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();

  thread start_idle();
}

play_giveup_after_time() {
  wait 5;
  level.boss_vo.lost scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();
}

check_lost_player() {
  level.player endon("death");

  for(;;) {
    level.goliath_ai waittill("stealth_hunt");
    lost_player();
  }
}

lost_player() {
  if(scripts\sp\maps\hometown\hometown_vo_util.gsc::get_vo_source_is_speaking("russian_j12")) {
    scripts\sp\maps\hometown\hometown_vo_util.gsc::get_vo_source("russian_j12") scripts\engine\utility::waittill_any("stop_vo", "vo_finished");
    stop_idle();
    wait 0.5;
  }

  stop_idle();

  if(scripts\engine\utility::time_has_passed(level.boss_vo.start_time, 1))
    level.boss_vo.lost scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();

  thread start_idle();
}

check_stabbed() {
  level endon("boss_struggle_vo_start");
  level endon("boss_counter_vo_start");
  level waittill("boss_stab_vo_start");
  stop_boss_checks();
  stop_idle();
  level.boss_vo.last_stab_time = gettime();
  thread check_stabbed();
  boss_stabbed();
}

boss_stabbed() {
  level endon("boss_stab_vo_start");

  if(level.boss_vo.phase < 3) {
    goto_boss_phase(3);
    childthread first_stab_lines();
  } else if(level.boss_vo.phase == 3 && level.goliath_boss_round == 0) {
    level.boss_vo.combat = load_combat3();
    childthread first_stab_lines();
  } else {
    goto_boss_phase(4);
    childthread second_stab_lines();
  }

  level.goliath_ai waittill("context_melee_anim_ended");
  thread start_boss_checks();
}

second_stab_lines() {
  thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line_delayed(0.6, "farah", "dx_vom_far_house_boss_kill_13", "<stab effort>");
  wait 1;
  thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line_delayed(1.2, "farah", "dx_vom_far_house_boss_stab1_25", "<stab effort>");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("russian_j12", "dx_vom_rj12_house_boss_stab2_10", "<large pain, wounded effort>");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("russian_j12", "dx_vom_rj12_house_boss_stab2_20", "Fucking rat!");
}

first_stab_lines() {
  thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line_delayed(0.6, "farah", "dx_vom_far_house_boss_stab1_00", "<hurt/getting hit by soldier>");
  wait 1;
  thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line_delayed(0.85, "farah", "dx_vom_far_house_boss_kill_11", "<stab effort>");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("russian_j12", "dx_vom_rj12_house_boss_stab1_10", "Shit!");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("russian_j12", "dx_vom_rj12_house_boss_stab1_20", "God damn mother fu----!");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("russian_j12", "dx_vom_rj12_house_boss_stab1_30", "<wounded, hurt knife pull effort>");
}

idle_hunt() {
  level.boss_vo.hunt endon("interrupted");

  for(;;) {
    wait(randomfloatrange(6, 10));

    if(level.boss_vo.hunt.open_lines.size == 0) {
      if(level.boss_vo.phase == 0)
        goto_boss_phase(1);
      else
        level.boss_vo.hunt = level.boss_vo.hunt_loop;
    }

    level.boss_vo.hunt scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();
  }
}

idle_combat() {
  level.boss_vo.combat endon("interrupted");

  for(;;) {
    wait(randomfloatrange(1, 3));

    if(level.boss_vo.combat.open_lines.size == 0)
      level.boss_vo.combat = level.boss_vo.combat_loop;

    if(level.boss_vo.phase == 2 && level.boss_vo.context["player_under_something"]) {
      level.boss_vo.hunt_loop scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket(level.boss_vo.context);
      continue;
    }

    level.boss_vo.combat scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket(level.boss_vo.context);
  }
}

boss_struggle_vo() {
  level waittill("boss_struggle_vo_start");
  thread boss_final_struggle_catch_lines();
  wait 1;
  thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("farah", "dx_vom_far_house_boss_stab3_20", "<choking/struggling efforts>");
  wait 5;
  level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("hadir", "Hadir");
  wait 5;
  continuous_stabs();
  thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line_delayed(2, "russian_j12", "dx_vom_rj12_house_boss_stab1_30", "Argghhh...!!");
  wait 6;
  thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line_delayed(0.25, "russian_j12", "dx_vom_rj12_house_boss_kill_65", "I'll crush your little neck...!");
  wait 1.5;
  hadir_choking();
  thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line_delayed(0, "hadir", "dx_vom_had_house_boss_kill_105", "<struggling / getting out from under boss");
  thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line_delayed(0.2, "farah", "dx_vom_far_house_boss_kill_100", "<firing efforts / roar>Ahhh!");
  setmusicstate("");
  wait 0.1;
  scripts\sp\maps\hometown\hometown_vo_util.gsc::stop_vo_source("russian_j12");
  wait 0.2;
}

boss_final_struggle_catch_lines() {
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("russian_j12", "dx_vom_rj12_house_boss_caught_10", "There you are!");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("russian_j12", "dx_vom_rj12_house_boss_caught_20", "Got you, suka!");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("russian_j12", "dx_vom_rj12_house_boss_stab3_30", "Trying to kill me?!");
  wait 0.85;
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("russian_j12", "dx_vom_rj12_house_boss_stab3_10", "Bitch!");
  wait 1;
  thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("russian_j12", "dx_vom_rj12_house_boss_rescued_12", "<struggling to free himself>");
}

hadir_choking() {
  level endon("player_shot_boss");
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("hadir", "dx_vom_had_house_boss_kill_72", "<efforts of being strangled>");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("hadir", "dx_vom_had_house_boss_kill_70", "<efforts of getting choked>");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::set_vo_bucket_sequential();

  for(;;)
    var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();
}

timeout_vo() {
  level waittill("stab_delay_time_exceeded");
  wait 1.8;
  level.hadir_ai stopsounds();
  level.goliath_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_rj12_house_boss_dadfight_808");
}

continuous_stabs() {
  level endon("start_kill_flip_vo");
  childthread timeout_vo();
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("hadir", "dx_vom_had_house_boss_kill_40", "Good , Farah!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("hadir", "dx_vom_had_house_boss_kill_30", "Again, sister!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("hadir", "dx_vom_had_house_boss_kill_50", "It's working!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::set_vo_bucket_sequential();
  var_1 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_1 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("farah", "dx_vom_far_house_boss_kill_11", "<efforts of stabbing Russian soldier>");
  var_1 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("farah", "dx_vom_far_house_boss_kill_12", "<efforts of stabbing Russian soldier>");
  var_1 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("farah", "dx_vom_far_house_boss_kill_13", "<efforts of stabbing Russian soldier>");
  var_1 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("farah", "dx_vom_far_house_boss_kill_14", "<efforts of stabbing Russian soldier>");
  var_1 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("farah", "dx_vom_far_house_boss_kill_15", "<efforts of stabbing Russian soldier>");
  var_2 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_2 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_kill_21", "<pain efforts of getting stabbed>");
  var_2 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_kill_22", "<pain efforts of getting stabbed>");
  var_2 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_kill_23", "<pain efforts of getting stabbed>");
  var_2 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_kill_24", "<pain efforts of getting stabbed>");
  var_2 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_kill_25", "<pain efforts of getting stabbed>");
  var_3 = ["dx_vom_had_house_boss_rescued_32", "dx_vom_had_house_boss_rescued_31", "dx_vom_had_house_boss_rescued_30"];
  var_4 = scripts\engine\sp\utility::create_deck(var_3, 0);
  var_4.autoshuffle = 1;
  thread get_him_farah();

  for(;;) {
    level waittill("start_stab");
    var_1 childthread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();
    wait 0.1;
    childthread boss_efforts_getting_stabbed(var_2);
    wait 0.15;

    if(equals_any(level.boss_stabbed_amount, [0, 1, 2]))
      childthread play_hadir_stab_cheer(var_0, var_4);
  }
}

boss_efforts_getting_stabbed(var_0) {
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();
  wait 0.25;
  thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("russian_j12", "dx_vom_rj12_house_boss_rescued_12", "<struggling to free himself>");
}

get_him_farah() {
  level endon("start_stab");
  wait 1;
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("hadir", "dx_vom_had_house_boss_kill_32", "Get him, Farah!");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("hadir", "dx_vom_had_house_boss_rescued_11", "<struggling / fighting soldier>");
}

play_hadir_stab_cheer(var_0, var_1) {
  level endon("start_stab");
  wait 0.6;
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();
  var_2 = "dx_vom_had_house_boss_rescued_11";
  level.hadir_ai thread scripts\sp\maps\hometown\hometown_vo_util.gsc::say(var_2);
  wait 1;
  level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::say(var_1 scripts\engine\sp\utility::deck_draw(), 1);
  level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::say(var_2);
}

equals_any(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(var_0 == var_3)
      return 1;
  }

  return 0;
}

knock_off_check() {
  for(;;) {
    var_0 = level.goliath_ai scripts\engine\utility::waittill_any_return("smartobject_knock_off_30", "smartobject_knock_off_36");
    iprintlnbold(var_0);
    wait 2;
  }
}

lean_table_check() {
  for(;;) {
    var_0 = level.goliath_ai scripts\engine\utility::waittill_any_return("smartobject_lean_table_30", "smartobject_lean_table_36", "smartobject_lean_table_l_30", "smartobject_lean_table_l_36", "smartobject_lean_table_r_30", "smartobject_lean_table_r_36");
    iprintlnbold(var_0);
    wait 2;
  }
}

lean_wall_check() {
  for(;;) {
    var_0 = level.goliath_ai scripts\engine\utility::waittill_any_return("smartobject_lean_wall_l", "smartobject_lean_wall_r");
    iprintlnbold(var_0);
    wait 2;
  }
}

look_check() {
  for(;;) {
    var_0 = level.goliath_ai scripts\engine\utility::waittill_any_return("smartobject_look_down", "smartobject_look_high", "smartobject_look_over", "smartobject_look_under_10");
    iprintlnbold(var_0);
    wait 2;
  }
}

house_exit_start_vo() {
  level.boss_vo = undefined;
  scripts\sp\maps\hometown\hometown_vo_util.gsc::unregister_all_vo_sources();
  level.player scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("farah", "Farah");
  level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("hadir", "Hadir");
  childthread wait_mourn_father();
  level.hadir_ai waittill("trigger");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("farah", "dx_vom_far_house_exit_loot_20", "Don't be afraid... We are together.");
  level notify("farah_reassure_vo_finish");
  level waittill("loot_interacts_active");
  thread equipment_nags();
  level waittill("hadir_mourn_father");
  thread hadir_mourn_father();
  scripts\engine\utility::flag_wait("hadir_start_boost_vo");
  lock_boost_nags();
  wait 7;
  thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("farah", "dx_vom_far_tryknob", "<effort trying knob>");
  wait 1;
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("farah", "dx_vom_far_house_exit_lock_75", "It's stuck.");
  lock_pry_nags();
  wait 0.1;
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("farah", "dx_vom_far_house_exit_lock_102", "<prying/snapping lock effort>");
}

walk_to_dad() {
  level endon("hadir_mourn_father");
  wait 2;

  for(;;) {
    waitframe();
    var_0 = level.hadir_ai pathdisttogoal();

    if(300 > var_0 && var_0 > 150) {
      scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("hadir", "dx_vom_had_poppies_start_fields_30", "We'll go through the poppies. They'll hide us. Let's go.");
      break;
    } else if(var_0 < 150)
      return;
  }
}

hadir_mourn_father() {
  wait 1;
  wait 1;
}

reassure_hadir() {
  level endon("boss_stuff_pickup");
  scripts\engine\utility::flag_set("hadir_reassured");
}

wait_mourn_father() {
  level endon("house_exit_complete");
  level waittill("player_mourn_father");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("farah", "dx_vom_far_house_exit_dad_40", "Good-bye, daddy. I love you.");
}

equipment_nags() {
  while(!scripts\engine\utility::flag("got_gas_mask_from_boss") || !scripts\engine\utility::flag("tried_to_get_gun")) {
    if(!scripts\engine\utility::flag("got_gas_mask_from_boss") && !scripts\engine\utility::flag("tried_to_get_gun")) {
      thread play_vo_on_stuff_pickup();
      get_either_nags();
    } else if(scripts\engine\utility::flag("tried_to_get_gun")) {
      get_mask_nags();
      thread get_mask_vo();
    } else {
      get_gun_nags();
      thread get_gun_vo();
    }

    level scripts\engine\utility::waittill_any("got_gas_mask_from_boss", "tried_to_get_gun");
  }

  wait 1;
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("hadir", "dx_vom_had_house_exit_dad_10", "Come on...");
  thread walk_to_dad();
}

play_vo_on_stuff_pickup() {
  level.player waittill("boss_stuff_pickup", var_0);

  if(var_0 == "gas_mask")
    get_mask_vo();
  else
    get_gun_vo();
}

lock_pry_nags() {
  level endon("lock_broken");
  childthread lock_pry_efforts();
  scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source_at_pos("hadir", "Hadir", (-1318, -2503, 40));
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("hadir", "dx_vom_had_house_exit_lock_70", "Try to pry it open.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("hadir", "dx_vom_had_house_exit_lock_80", "Try to pry the lock...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("hadir", "dx_vom_had_house_exit_lock_90", "You can do it, sister...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("hadir", "dx_vom_had_house_exit_lock_100", "Pry it open.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket(undefined, "dx_vom_had_house_exit_lock_70");
  wait 3;
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket(undefined, "dx_vom_had_house_exit_lock_90");

  for(;;) {
    wait(randomfloatrange(7, 12));

    if(!level.player useButtonPressed())
      var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();
  }
}

lock_pry_efforts() {
  level waittill("start_lock_pry");

  for(;;) {
    for(var_0 = 0; var_0 < 0.5; var_0 = var_0 + 0.05) {
      if(!level.player useButtonPressed())
        var_0 = 0;

      waitframe();
    }

    level.player thread scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_far_house_exit_lock_101", 1);
    wait 0.5;

    while(level.player useButtonPressed())
      waitframe();

    level.player thread scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_far_prylock", 1);
  }
}

lock_boost_nags() {
  level.hadir_ai endon("trigger");
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("hadir", "dx_vom_had_house_exit_lock_10", "I can't reach the lock!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("hadir", "dx_vom_had_house_exit_lock_20", "Come, I'll lift you...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("hadir", "dx_vom_had_house_exit_lock_30", "Help me, Farah, I can't reach.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("hadir", "dx_vom_had_house_exit_lock_32", "Step here, sister.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("hadir", "dx_vom_had_house_exit_lock_34", "It's too high, help me...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("hadir", "dx_vom_had_house_exit_lock_40", "Over the door...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("hadir", "dx_vom_had_house_exit_lock_50", "See if you can reach it...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("hadir", "dx_vom_had_house_exit_lock_52", "I'll help you reach the lock, sister.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("hadir", "dx_vom_had_house_exit_lock_54", "I'm not tall enough we have to do it together.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("hadir", "dx_vom_had_house_exit_lock_56", "Step here. I'll help you up.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket(undefined, "dx_vom_had_house_exit_lock_10");
  wait 0.5;
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket(undefined, "dx_vom_had_house_exit_lock_20");

  for(;;) {
    wait(randomfloatrange(7, 12));
    var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();
  }
}

get_either_nags() {
  level.player endon("boss_stuff_pickup");
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("hadir", "dx_vom_had_house_exit_loot_32", "Farah, let's see what he's got.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("hadir", "dx_vom_had_house_exit_loot_33", "He has things we can use.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("hadir", "dx_vom_had_house_exit_loot_34", "Sister, let's take his things.");
  wait 5;

  for(;;) {
    wait(randomfloatrange(7, 12));
    var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();
  }
}

get_mask_nags() {
  level.player endon("boss_stuff_pickup");
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("hadir", "dx_vom_had_house_exit_loot_70", "Take his mask, sister...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("hadir", "dx_vom_had_house_exit_loot_80", "The mask, Farah, take it.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("hadir", "dx_vom_had_house_exit_loot_81", "You need the mask for the gas outside, remember?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("hadir", "dx_vom_had_house_exit_loot_82", "We can't go if you have no mask, Farah.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::wait_vo_source_finish_speaking("hadir");
  wait 4;
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket(undefined, "dx_vom_had_house_exit_loot_70");

  for(;;) {
    wait(randomfloatrange(7, 12));
    var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();
  }
}

get_gun_nags() {
  level.player endon("boss_stuff_pickup");
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("hadir", "dx_vom_had_house_exit_loot_35", "Let's try to take his rifle.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("hadir", "dx_vom_had_house_exit_loot_36", "Maybe you can take his gun.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("hadir", "dx_vom_had_house_exit_loot_37", "Try to grab his gun, sister.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::wait_vo_source_finish_speaking("hadir");
  wait 1;
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket(undefined, "dx_vom_had_house_exit_loot_35");

  for(;;) {
    wait(randomfloatrange(7, 12));
    var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();
  }
}

get_gun_vo() {
  wait 0.85;
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("farah", "dx_vom_far_house_exit_loot_40", "<efforts straining to pick up gun>");
  wait 0.5;
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("farah", "dx_vom_far_house_exit_loot_50", "He's too heavy.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("farah", "dx_vom_far_house_exit_loot_60", "We have to go.");
}

get_mask_vo() {
  wait 6;
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("farah", "dx_vom_far_house_exit_loot_90", "Got it.");
}

escape_vo_init() {
  if(!isDefined(level.hadir_ai.escape_nags))
    init_gas_escape_vo();
}

init_gas_escape_vo() {
  var_0 = [];
  var_1 = ["dx_vom_had_gas_start_playground_60", "dx_vom_had_gas_start_playground_61", "dx_vom_had_gas_start_playground_62", "dx_vom_had_gas_start_streets_170"];
  var_0["wrong_way"] = scripts\engine\sp\utility::create_deck(var_1);
  var_2 = [];
  var_2[var_2.size] = "dx_vom_had_gas_start_playground_120";
  var_2[var_2.size] = "dx_vom_had_gas_start_streets_21";
  var_2[var_2.size] = "dx_vom_had_gas_start_streets_22";
  var_0["crossing_seen_approaching"] = scripts\engine\sp\utility::create_deck(var_2);
  var_3 = [];
  var_3[var_3.size] = "dx_vom_had_gas_start_playground_41";
  var_3[var_3.size] = "dx_vom_had_gas_start_streets_180";
  var_3[var_3.size] = "dx_vom_had_gas_start_streets_242";
  var_3[var_3.size] = "dx_vom_had_gas_start_streets_282";
  var_3[var_3.size] = "dx_vom_had_gas_start_streets_22";
  var_0["crossing_seen"] = scripts\engine\sp\utility::create_deck(var_3);
  var_4 = [];
  var_4[var_4.size] = "dx_vom_had_gas_mid_carhide_32";
  var_4[var_4.size] = "dx_vom_had_gas_mid_carhide_262";
  var_4[var_4.size] = "dx_vom_had_gas_mid_carhide_310";
  var_4[var_4.size] = "dx_vom_had_gas_mid_carhide_351";
  var_0["crossing_unseen"] = scripts\engine\sp\utility::create_deck(var_4);
  var_5 = [];
  var_5[var_5.size] = "dx_vom_had_gas_exit_alley_21";
  var_5[var_5.size] = "dx_vom_had_gas_exit_alley_22";
  var_5[var_5.size] = "dx_vom_had_gas_start_streets_270";
  var_5[var_5.size] = "dx_vom_had_gas_start_streets_280";
  var_5[var_5.size] = "dx_vom_had_gas_start_playground_51";
  var_0["crawling"] = scripts\engine\sp\utility::create_deck(var_5);
  var_6 = ["dx_vom_had_gas_start_playground_51", "dx_vom_had_gas_start_playground_52"];
  var_0["playground"] = scripts\engine\sp\utility::create_deck(var_6);
  var_7 = ["dx_vom_had_gas_mid_carhide_30", "dx_vom_had_gas_mid_carhide_31"];
  var_0["yellow_car"] = scripts\engine\sp\utility::create_deck(var_7);
  var_0["blue_car"] = scripts\engine\sp\utility::create_deck("dx_vom_had_gas_mid_carhide_261");
  var_0["red_truck"] = scripts\engine\sp\utility::create_deck("dx_vom_had_gas_mid_carhide_312");
  var_0["white_car"] = scripts\engine\sp\utility::create_deck("dx_vom_had_gas_mid_carhide_353");
  var_0["black_truck"] = scripts\engine\sp\utility::create_deck("dx_vom_had_gas_mid_carhide_430");
  var_8 = ["dx_vom_had_gas_mid_carhide_440", "dx_vom_had_gas_mid_carhide_441", "dx_vom_had_gas_mid_carhide_442", "dx_vom_had_gas_start_streets_240"];
  var_0["alley"] = scripts\engine\sp\utility::create_deck(var_8);
  var_9 = ["dx_vom_had_gas_exit_window_30", "dx_vom_had_gas_exit_window_31", "dx_vom_had_gas_exit_window_32", "dx_vom_had_gas_exit_alley_21"];
  var_0["poppies"] = scripts\engine\sp\utility::create_deck(var_9);
  var_10 = [];
  var_10[var_10.size] = "dx_vom_had_gas_mid_carhide_260";
  var_10[var_10.size] = "dx_vom_had_gas_mid_carhide_350";
  var_10[var_10.size] = "dx_vom_had_gas_mid_carhide_352";
  var_10[var_10.size] = "dx_vom_had_gas_start_playground_40";
  var_10[var_10.size] = "dx_vom_had_gas_start_playground_42";
  var_10[var_10.size] = "dx_vom_had_gas_start_playground_50";
  var_10[var_10.size] = "dx_vom_had_gas_start_streets_160";
  var_10[var_10.size] = "dx_vom_had_gas_start_streets_241";
  var_10[var_10.size] = "dx_vom_had_gas_start_streets_281";
  var_0["generic"] = scripts\engine\sp\utility::create_deck(var_10);
  level.hadir_ai.escape_nags = var_0;
}

is_near(var_0, var_1) {
  return distance2dsquared(self.origin, var_0) < var_1 * var_1;
}

get_hadir_gas_escape_nag() {
  var_0 = gettime();

  for(;;) {
    var_1 = level.player get_in_danger();

    if(scripts\sp\maps\hometown\hometown_vo_util.gsc::get_player_progress_toward_self() > 0.5) {
      return;
    }
    if(scripts\sp\maps\hometown\hometown_vo_util.gsc::get_player_progress_toward_self() == 0.5 && !scripts\engine\utility::time_has_passed(var_0, 12) && var_1 < 2) {} else {
      var_2 = level.hadir_ai is_near((-375.315, -2392.98, 7.96669), 82);
      var_3 = level.hadir_ai is_near((-20.4396, -2455.15, 6.21089), 318);
      var_4 = level.hadir_ai is_near((585.258, -2742.31, 10.7235), 118);
      var_5 = level.hadir_ai is_near((748.985, -2976.42, -6.40835), 150);
      var_6 = level.hadir_ai is_near((1018.49, -3061.24, 24.9231), 186);
      var_7 = level.hadir_ai is_near((1190.28, -2767.94, -0.530097), 128);
      var_8 = level.hadir_ai is_near((1472.25, -2449.1, 30.9651), 172);
      var_9 = level.hadir_ai is_near((2263.27, -2225.97, 20.1957), 336);
      var_10 = level.hadir_ai is_near((3228.07, -2247.75, 52.6683), 284);
      var_11 = level.player is_near((-882.589, -2506.98, 6.99609), 142);
      var_12 = level.player is_near((585.258, -2742.31, 10.7235), 118);
      var_13 = level.player is_near((748.985, -2976.42, -6.40835), 150);
      var_14 = level.player is_near((1018.49, -3061.24, 24.9231), 186);
      var_15 = level.player is_near((1190.28, -2767.94, -0.530097), 128);
      var_16 = level.player is_near((2263.27, -2225.97, 20.1957), 336);
      var_17 = var_11 || var_12 || var_13 || var_14;
      var_18 = 0;

      if(isDefined(level.player.last_nag_pos)) {
        var_19 = level.hadir_ai.origin - level.player.origin;
        var_20 = level.hadir_ai.origin - level.player.last_nag_pos;
        var_21 = length2dsquared(var_20) - length2dsquared(var_19);
        var_18 = var_21 < -1600;
      }

      level.player.last_nag_pos = level.player.origin;
      var_22 = level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::get_player_progress_toward_self() <= 0.3 && var_18;
      var_23 = level.hadir_ai get_nag(level.hadir_ai.escape_nags, "crossing_seen_approaching", var_1 > 1);

      if(isDefined(var_23))
        return var_23;

      var_23 = level.hadir_ai get_nag(level.hadir_ai.escape_nags, "crossing_seen", var_1);

      if(isDefined(var_23))
        return var_23;

      var_23 = level.hadir_ai get_nag(level.hadir_ai.escape_nags, "wrong_way", var_22);

      if(isDefined(var_23))
        return var_23;

      var_23 = level.hadir_ai get_nag(level.hadir_ai.escape_nags, "crawling", var_2);

      if(isDefined(var_23))
        return var_23;

      var_23 = level.hadir_ai get_nag(level.hadir_ai.escape_nags, "yellow_car", var_4 && !var_12);

      if(isDefined(var_23))
        return var_23;

      var_23 = level.hadir_ai get_nag(level.hadir_ai.escape_nags, "blue_car", var_5 && !var_13);

      if(isDefined(var_23))
        return var_23;

      var_23 = level.hadir_ai get_nag(level.hadir_ai.escape_nags, "red_truck", var_6 && !var_14);

      if(isDefined(var_23))
        return var_23;

      var_23 = level.hadir_ai get_nag(level.hadir_ai.escape_nags, "white_car", var_7 && !var_15);

      if(isDefined(var_23))
        return var_23;

      var_23 = level.hadir_ai get_nag(level.hadir_ai.escape_nags, "alley", var_9 && !var_16);

      if(isDefined(var_23))
        return var_23;

      var_23 = level.hadir_ai get_nag(level.hadir_ai.escape_nags, "poppies", var_10);

      if(isDefined(var_23))
        return var_23;

      var_23 = level.hadir_ai get_nag(level.hadir_ai.escape_nags, "crossing_unseen", var_17 && !var_1);

      if(isDefined(var_23))
        return var_23;

      var_23 = level.hadir_ai get_nag(level.hadir_ai.escape_nags, "generic", 1);

      if(isDefined(var_23))
        return var_23;

      foreach(var_25 in level.hadir_ai.escape_nags) {
        if(var_25 scripts\engine\sp\utility::deck_is_empty())
          var_25 scripts\engine\sp\utility::deck_shuffle();
      }
    }

    wait 1;
  }
}

get_nag(var_0, var_1, var_2) {
  if(var_2 && !var_0[var_1] scripts\engine\sp\utility::deck_is_empty())
    return var_0[var_1] scripts\engine\sp\utility::deck_draw();
}

gas_sources() {
  scripts\sp\maps\hometown\hometown_vo_util.gsc::unregister_all_vo_sources();
  level.player scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("farah", "Farah");
  level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("hadir", "Hadir");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::find_and_register_vo_source("ru_soldier_1", "Russian Soldier", "russian_gas_execution_a1", "script_noteworthy");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::find_and_register_vo_source("ru_soldier_2", "Russian Soldier", "russian_gas_execution_a2", "script_noteworthy");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::find_and_register_vo_source("ru_soldier_3", "Russian Soldier", "russian_gas_patrol", "script_noteworthy");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::get_vo_source("ru_soldier_1") scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source_attached("ru_team_leader", "Russian Team Leader", "tag_stowed_hip_rear");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source_at_pos("civilian_male_1", "Civilian", (-780, -2732, 8));
  scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source_at_pos("civilian_child_male_1", "Civilian", (-364.5, -2361.5, 8));
}

gas_start_vo() {
  gas_sources();
  escape_vo_init();
  thread missing_ru_soldier();
  level.hadir_ai waittill("goal");
  scripts\engine\utility::flag_wait("road_cross_flag");
  thread hadir_soldier_warning();
  level.hadir_ai waittill("goal_changed");
  var_0 = [];
  var_0[var_0.size] = "dx_vom_had_gas_start_playground_62";
  var_0[var_0.size] = "dx_vom_had_gas_mid_carhide_260";
  var_0[var_0.size] = "dx_vom_had_gas_mid_carhide_352";
  var_0[var_0.size] = "dx_vom_had_gas_mid_carhide_350";
  var_1 = level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::goalpos_and_nagtill(8, "road_cross_mid_flag", var_0, 12);

  if(var_1)
    level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_had_gas_mid_carhide_262", 0);

  wait 0.5;
  var_0 = scripts\engine\utility::array_combine(["dx_vom_had_gas_start_streets_281", "dx_vom_had_gas_start_streets_282"], var_0);
  level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::goalpos_and_nagtill(6, "playground_pre_flag", var_0, 8);
  level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_had_gas_start_streets_260");
  wait 1;
  var_0 = ["dx_vom_had_gas_start_streets_270", "dx_vom_had_gas_start_streets_280", "dx_vom_had_gas_exit_alley_21", "dx_vom_had_gas_exit_alley_22"];
  thread notify_enter_tunnel();
  level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::nagtill("player_entering_tunnel", var_0, 8);
  level waittill("playground_pipe_exit_vo");
  level.player scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_far_gas_start_playground_10");
  var_0 = [];
  var_0[var_0.size] = "dx_vom_had_gas_start_playground_40";
  var_0[var_0.size] = "dx_vom_had_gas_start_playground_51";
  var_0[var_0.size] = "dx_vom_had_gas_start_playground_52";
  var_0[var_0.size] = "dx_vom_had_gas_start_playground_41";
  var_0[var_0.size] = "dx_vom_had_gas_start_playground_42";
  var_0[var_0.size] = "dx_vom_had_gas_start_playground_50";
  var_0[var_0.size] = "dx_vom_had_gas_start_streets_240";
  var_0[var_0.size] = "dx_vom_had_gas_start_streets_241";
  var_2 = scripts\engine\sp\utility::create_deck(var_0);
  level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::goalpos_and_nagtill(8, "playground_mid_flag", var_2, 12);
  level.hadir_ai scripts\sp\maps\hometown\hometown_util.gsc::wait_near((185, -2586, 0), 60);
  level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_had_gas_start_playground_80");
  level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_had_gas_start_playground_90");
  var_3 = 0;
  level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::nagtill_delayed(12, "playground_gate_flag", var_2, 15);
  var_4 = (gettime() - var_3) / 1000;
  wait(clamp(var_4, 0.5, 2.5));
  level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_had_gas_mid_carhide_10");
}

hadir_soldier_warning() {
  level endon("road_cross_mid_flag");
  level.hadir_ai thread scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_had_gas_start_streets_21");
  level.hadir_ai thread scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_had_gas_start_playground_110");
  wait 8.5;
  level.hadir_ai thread scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_had_gas_mid_carhide_330");
  wait 2.5;
  level.hadir_ai thread scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_had_gas_mid_carhide_311");
}

gas_mid_start_vo() {
  if(!isDefined(level.hadir_ai.escape_nags)) {
    wait 0.5;
    level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_had_gas_mid_carhide_10");
    escape_vo_init();
  }

  thread russian_carhide_convo();
  level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::goalpos_and_nagtill(3, "cars_street_start_flag", ::get_hadir_gas_escape_nag, 3, 1.2, 5, 0.5, 1);

  if(!scripts\engine\utility::flag("safe_for_hadir_to_progress")) {
    level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_had_gas_mid_carhide_240");
    level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_had_gas_mid_carhide_250");
  }

  wait 1;
  level.hadir_ai color_traversal_nagtill(2, "cars_flank_mid_flag", ::get_hadir_gas_escape_nag, 1, 1.2, 3, 0.5, 1.2, 1);
  wait 0.2;
  level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_had_gas_mid_carhide_370");
  wait 9;
  level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_had_gas_mid_carhide_270");
  wait 1;
  level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_had_gas_mid_carhide_290");
  wait 0.5;
  level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_had_gas_mid_carhide_300");
  level.hadir_ai color_traversal_nagtill(2, "town_exit_gate_start_flag", ::get_hadir_gas_escape_nag, 1, 1.2, 3, 0.5, 1.2, 1);
}

color_traversal_nagtill(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(var_1)) {
    if(!isarray(var_1))
      var_1 = [var_1];

    foreach(var_10 in var_1) {
      if(scripts\engine\utility::flag_exist(var_10) && scripts\engine\utility::flag(var_10)) {
        return;
      }
      level endon(var_10);
      self endon(var_10);
    }
  }

  for(;;) {
    while(!scripts\sp\maps\hometown\hometown_vo_util.gsc::get_at_goalpos(undefined, 40))
      waitframe();

    childthread scripts\sp\maps\hometown\hometown_vo_util.gsc::nagtill_delayed(var_0, "new_goal", var_2, var_3, var_4, var_5, var_6, var_7, var_8);

    while(scripts\sp\maps\hometown\hometown_vo_util.gsc::get_at_goalpos(undefined, 40))
      waitframe();

    self notify("new_goal");
  }
}

hadir_setgoal(var_0) {
  level.hadir_ai setgoalnode(var_0);
  level.hadir_ai notify("new_setgoal", var_0);
  level.hadir_ai endon("stop_color_nags");
  level.hadir_ai.reached_goal = undefined;
  level.hadir_ai.reached_goal = level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::goalpos_and_nagtill(2, "new_setgoal", ::get_hadir_gas_escape_nag, 1, 1);
}

russian_carhide_convo() {
  scripts\engine\sp\utility::trigger_wait("cars_street_start_trigger", "script_noteworthy");
  wait 5;
  scripts\sp\maps\hometown\hometown_vo_util.gsc::find_and_register_vo_source("ru_soldier_1", "Russian Soldier", "russian_gas_execution_b1", "script_noteworthy");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::find_and_register_vo_source("ru_soldier_2", "Russian Soldier", "russian_gas_execution_b2", "script_noteworthy");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::find_and_register_vo_source("ru_soldier_3", "Russian Soldier", "russian_gas_briefing_latecomer", "script_noteworthy");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::find_and_register_vo_source("ru_soldier_4", "Russian Soldier", "russian_gas_briefing_straggler", "script_noteworthy");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::get_vo_source("ru_soldier_2") scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source_attached("ru_team_leader", "Russian Team Leader", "tag_stowed_hip_rear");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source_at_pos("civilian_male_3", "Civilian", (671.8, -2832, 8));
  wait 7;
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_gas_mid_carhide_50", "This one's still breathing...");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_gas_mid_carhide_60", "We have orders to kill the wounded...");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_gas_mid_carhide_70", "Have you ever been on a mission like this?");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_gas_mid_carhide_80", "Never. But what are we going to do- break orders?");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_gas_mid_carhide_81", "I've heard Barkov executes people for less.");
  scripts\engine\utility::flag_wait("cars_flank_mid_flag");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_gas_mid_carhide_90", "And Moscow is fine with him taking all the women and children?");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_gas_mid_carhide_91", "I doubt they even know...");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_gas_mid_carhide_92", "Quiet. Here comes Viktor.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_3", "dx_vom_ru3_gas_mid_carhide_100", "Full sweep.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_gas_mid_carhide_110", "Any resistance?");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_3", "dx_vom_ru3_gas_mid_carhide_120", "Nothing we couldn't handle.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_gas_mid_carhide_130", "Women? Children?");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_3", "dx_vom_ru3_gas_mid_carhide_140", "On their way to the trucks. Full load.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_team_leader", "dx_vom_rutl_gas_mid_carhide_170", "D Group- confirm status?");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_gas_mid_carhide_180", "This is D-5. Objective is complete. We're ready to clear out.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_team_leader", "dx_vom_rutl_gas_mid_carhide_190", "Copy. Any additional cargo?");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_gas_mid_carhide_200", "They're inbound to the trucks now.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_team_leader", "dx_vom_rutl_gas_mid_carhide_210", "Understood.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_team_leader", "dx_vom_rutl_gas_mid_carhide_220", "J-Group reported a casualty. Maintain a perimeter at your location until the threat is neutralized. Clear?");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_gas_mid_carhide_230", "Will comply.");
}

gas_exit_start_vo() {
  escape_vo_init();
  scripts\engine\utility::flag_wait("town_exit_gate_start_flag");
  wait 1;
  level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::goalpos_and_nagtill(8, "town_exit_alley_mid_flag", ::get_hadir_gas_escape_nag, 12);
  level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::goalpos_and_nagtill(8, "gas_last_building_enter_flag", ::get_hadir_gas_escape_nag, 12);
  level.hadir_ai scripts\engine\sp\utility::wait_for_notify_or_timeout("stop_loop", 1);
  level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_had_gas_exit_window_10");
  level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::goalpos_and_nagtill(8, "village_exit_flag", ::get_hadir_gas_escape_nag, 12);
}

alley_attack() {}

get_in_danger(var_0) {
  if(isDefined(self.origin))
    var_1 = self;
  else
    var_1 = level.player;

  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::default_if_undefined(var_0, 400);
  var_2 = vectorNormalize(level.player getvelocity());
  var_3 = 0;

  foreach(var_5 in getaiarrayinradius(var_1.origin, var_0, "axis")) {
    if(!scripts\engine\trace::ray_trace_passed(var_5 getEye(), level.player getEye(), [level.player, var_5], scripts\engine\trace::create_ainosight_contents())) {
      continue;
    }
    if(var_2 == (0, 0, 0))
      return 1;

    var_6 = vectorNormalize(var_5.origin - var_1.origin);

    if(scripts\engine\math::anglebetweenvectors(var_2, var_6) < 90)
      return 2;
    else
      var_3 = 1;
  }

  return var_3;
}

notify_enter_tunnel() {
  waitframe();
  var_0 = (-459.151, -2414.09, 18.9434);

  for(;;) {
    var_1 = level.player getstance() == "prone";
    var_2 = distance2dsquared(level.player.origin, var_0) < 1600;

    if(var_1 && var_2) {
      break;
    }

    wait 1;
  }

  level notify("player_entering_tunnel");
}

bool_to_string(var_0) {
  if(var_0)
    return "true";

  return "false";
}

missing_ru_soldier() {
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_male_1", "dx_vom_cvm1_gas_start_streets_30", "<coughing/dying efforts>");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_gas_start_streets_40", "Is this one of them?");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_gas_start_streets_50", "Doesn't matter.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_3", "dx_vom_ru3_gas_start_streets_52", "They're all terrorists. So Barkov wants the whole place wiped out. It's the only way to be sure.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_team_leader", "dx_vom_rutl_gas_start_streets_60", "J Group, we're ready to finish this up. What's your status?");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_gas_start_streets_70", "I'm getting a headcount, stand by.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_3", "dx_vom_ru3_gas_start_streets_80", "Sir, we've got a man missing.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_gas_start_streets_90", "Who?");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_3", "dx_vom_ru3_gas_start_streets_100", "J-12. He's not responding on radio.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_gas_start_streets_110", "How can you lose him? He's the size of a truck.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_gas_start_streets_120", "Take two men and sweep the area. Start with that house.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_3", "dx_vom_ru3_gas_start_streets_130", "Yes, Commander.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_gas_start_streets_140", "J Group has a man missing. We're holding here until we find him.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_team_leader", "dx_vom_rutl_gas_start_streets_150", "Copy.");
}

poppies_vo_sources() {
  scripts\sp\maps\hometown\hometown_vo_util.gsc::unregister_all_vo_sources();
  level.player scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("farah", "Farah");
  level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("hadir", "Hadir");
}

get_poppies_nags() {
  var_0 = [];
  var_0[var_0.size] = "dx_vom_had_poppies_start_fields_40";
  var_0[var_0.size] = "dx_vom_had_poppies_start_fields_42";
  var_0[var_0.size] = "dx_vom_had_poppies_start_fields_170";
  var_0[var_0.size] = "dx_vom_had_poppies_start_barn_10";
  var_0[var_0.size] = "dx_vom_had_poppies_start_barn_20";
  var_0[var_0.size] = "dx_vom_had_poppies_start_barn_30";
  var_0[var_0.size] = "dx_vom_had_pistol_start_overlook_20";
  var_0[var_0.size] = "dx_vom_had_pistol_start_overlook_30";
  return scripts\engine\sp\utility::create_deck(var_0);
}

poppies_start_vo() {
  poppies_vo_sources();

  if(isDefined(level.start_point) && level.start_point == "poppies_start") {
    escape_vo_init();
    wait 5;
  }

  level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::nagtill_delayed(8, "gas_mask_remove_trigger", level.hadir_ai.escape_nags["generic"], 12, 1.2, 20);
  level.hadir_ai.escape_nags = undefined;
  level.hadir_ai.poppies_nags = get_poppies_nags();
  level.hadir_ai thread color_traversal_nagtill(8, "stop_color_nags", level.hadir_ai.poppies_nags, 12, 1.2, 20);
  thread mask_remove_helo_react();
  scripts\engine\sp\utility::trigger_wait("start_execution_trigger", "script_noteworthy");
  thread civilians_plead();
  thread execution();
  scripts\engine\sp\utility::trigger_wait("hadir_stayahead_wait_off_execution", "script_noteworthy");
  level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_had_poppies_start_fields_160");
  level.hadir_ai.poppies_nags deck_add("dx_vom_had_poppies_start_fields_172");
  level.hadir_ai.poppies_nags deck_add("dx_vom_had_poppies_start_fields_171");
  scripts\engine\sp\utility::trigger_wait("civ_execution_trigger", "script_noteworthy");
  level.hadir_ai.poppies_nags deck_remove("dx_vom_had_poppies_start_fields_172");
  level.hadir_ai.poppies_nags deck_remove("dx_vom_had_poppies_start_fields_171");
  scripts\engine\sp\utility::trigger_wait("pistol_intro_start_trigger", "script_noteworthy");
  level.hadir_ai notify("stop_color_nags");
}

deck_add(var_0) {
  self.items = scripts\engine\utility::array_insert(self.items, var_0, self.index);
}

deck_remove(var_0) {
  self.items = scripts\engine\utility::array_remove(self.items, var_0);
}

mask_remove_helo_react() {
  scripts\engine\utility::flag_wait("gas_mask_remove_flag");
  wait 1.5;
  level.hadir_ai thread scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_had_poppies_start_fields_44");
  wait 3.2;
  level.player thread scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_far_poppies_start_fields_35");
}

civilians_plead() {
  level endon("shoot_all_the_civs");

  while(!isDefined(level.poppies_enemies))
    waitframe();

  level.poppies_enemies[0] scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("ru_soldier_1", "Russian Soldier");
  level.poppies_enemies[1] scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("ru_soldier_2", "Russian Soldier");
  level.execution_civs_array[1] scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("civilian_male_3");
  level.execution_civs_array[2] scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("civilian_male_1");
  level.execution_civs_array[3] scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("civilian_male_2");
  level.execution_civs_array[5] scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("civilian_female_1");
  level.execution_civs_array[6] scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("civilian_child_female_2");
  level.execution_civs_array[7] scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("civilian_female_2");
  level.execution_civs_array[9] scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("civilian_child_female_1");
  thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_female_1", "dx_vom_cvf1_poppies_start_fields_50", "<screams/struggling efforts>");
  thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line_delayed(5, "civilian_child_female_1", "dx_vom_ccf1_poppies_start_fields_60", "Baba! Baba!");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line_delayed(7, "civilian_male_3", "dx_vom_cvm3_poppies_start_fields_70", "Don't touch her!");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_male_3", "dx_vom_cvm3_poppies_start_fields_80", "<pain/wounded efforts>");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_child_female_2", "dx_vom_ccf2_poppies_start_fields_180", "<crying/pleading>No! No, please!");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_female_2", "dx_vom_cf2_poppies_start_fields_190", "Why are you doing this?!");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru4_poppies_start_fields_200", "Two days ago, our men were ambushed by terrorists. I lost soldiers. Good soldiers.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru3_poppies_start_fields_90", "Get over there!");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru3_poppies_start_fields_100", "Against the barn! Don't try anything, understand?!");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru3_poppies_start_fields_110", "You too! Against the barn!");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_male_1", "dx_vom_cvm1_poppies_start_fields_120", "<struggling/wounded efforts>We didn't do anything! We aren't fighters!");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru3_poppies_start_fields_130", "Shut up! Not another word!");
  thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_male_2", "dx_vom_cvm2_poppies_start_fields_140", "<struggling/wounded efforts>");
  wait 0.2;
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_poppies_start_fields_150", "Move ‘em out!");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru4_poppies_start_fields_210", "Those responsible were tracked back to this village. We know they're here. So do you.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru4_poppies_start_fields_230", "If you harbor terrorists, you are complicit in their attacks against our forces. This cannot go unpunished.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_male_3", "dx_vom_cvm3_poppies_start_fields_240", "It's him! He helps them!");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_male_1", "dx_vom_cvm1_poppies_start_fields_250", "Liar!");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_male_3", "dx_vom_cvm3_poppies_start_fields_260", "I saw him with weapons! I can show you!");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_male_1", "dx_vom_cvm1_poppies_start_fields_270", "He's lying! He's trying to save himself!");
  wait 0.5;
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru4_poppies_start_fields_280", "I see...");
}

execution() {
  level waittill("shoot_all_the_civs");
  thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru4_poppies_start_fields_290", "Kill them all.");
  wait 0.6;
  thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_male_1", "dx_vom_cvm1_poppies_start_fields_300", "No! Wait-!");
  wait 1;
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_female_1", "dx_vom_cvf1_poppies_start_fields_310", "No!");
  wait 1;
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_female_2", "dx_vom_cf2_poppies_start_fields_311", "You killed them!");
  thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_female_2", "dx_vom_cf2_pistol_start_overlook_11", "<crying/moaning efforts>");
}

captured_civ_screams() {
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_child_female_1", "dx_vom_ccf1_poppies_start_fields_314", "Baba!");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_child_female_2", "dx_vom_ccf2_poppies_start_fields_315", "<crying/screaming>");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_female_1", "dx_vom_cvf1_poppies_start_fields_316", "<crying/screaming>");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_poppies_start_fields_320", "Get the rest on the truck! Move!");
}

pistol_vo_sources() {
  scripts\sp\maps\hometown\hometown_vo_util.gsc::unregister_all_vo_sources();
  level.player scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("farah", "Farah");
  level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("hadir", "Hadir");
  level.pistol_enemy_02_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("ru_soldier_1", "Russian Soldier");
  level.pistol_enemy_01_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("ru_soldier_2", "Russian Soldier");
  level.pistol_enemy_02_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source_attached("ru_team_leader", "Russian Team Leader", "tag_stowed_hip_rear");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source_at_pos("civilian_female_1", "Civilian", (5810.91, -4777.24, -439.707));
  scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source_at_pos("civilian_child_female_1", "Civilian", (5810.91, -4777.24, -439.707));
  scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source_at_pos("civilian_child_female_2", "Civilian", (5810.91, -4777.24, -439.707));
}

pistol_start_vo() {
  pistol_vo_sources();
  escape_vo_init();
  thread children_crying();

  if(!isDefined(level.hadir_ai.poppies_nags))
    level.hadir_ai.poppies_nags = get_poppies_nags();

  level.hadir_ai.poppies_nags deck_add("dx_vom_had_pistol_start_overlook_40");
  level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::nagtill_delayed(12, "pistol_start_trigger", level.hadir_ai.poppies_nags, 8, 1.2, 20);
  thread captured_civ_screams();
  level waittill("remove_blocker");
  level.pistol_enemy_02_ai scripts\engine\sp\utility::set_battlechatter(0);
  level.pistol_enemy_01_ai scripts\engine\sp\utility::set_battlechatter(0);
  level.pistol_vo = spawnStruct();
  level.pistol_vo.context = [];
  level.pistol_vo.context["never_spotted"] = 1;
  level.pistol_vo.context["first_lost"] = 1;
  level.pistol_vo.context["player_got_gun"] = 0;
  level.pistol_vo.context["soldiers_alive"] = "both";
  level.pistol_vo.context["times_called"] = 0;
  level.pistol_vo.hunt = load_unharmed_pistol_fight_hunt();
  level.pistol_vo.spotted = load_unharmed_pistol_fight_spotted();
  level.pistol_vo.lost = load_unharmed_pistol_fight_lost();
  level.pistol_vo.combat = load_unharmed_pistol_fight_combat();
  level.pistol_vo.combat_distract = load_unharmed_pistol_combat_distract();
  level.pistol_vo.distract = load_ru1_unspotted_pistol_idle_distract();
  level.pistol_vo.distract_followup = load_ru2_unspotted_pistol_idle_distract();
  level.pistol_vo.distract_end = load_unharmed_pistol_idle_distract_end();
  level.pistol_vo.distract_end_followup = undefined;
  level.pistol_vo.state = "idle";
  thread pistol_fight_vo();
  thread stealth_combat_check();
  thread stealth_event_check();
  thread pistol_pickup_check();
  level.pistol_enemy_01_ai.shot_at_react = load_ru2_pistol_shot_at();
  level.pistol_enemy_02_ai.shot_at_react = load_ru1_pistol_shot_at();
  level.pistol_enemy_01_ai thread shot_at_check();
  level.pistol_enemy_02_ai thread shot_at_check();
  wait_soldier_death();
  wait_truck_door_interact();
}

pistol_pickup_check() {
  scripts\engine\utility::flag_wait("objective_shoot_the_soldiers");
  level.pistol_vo.context["player_got_gun"] = 1;
}

wait_truck_door_interact() {
  level endon("car_door_interacted");

  if(getdvarint("greenlight") || getdvarint("greenlight_three_stab")) {
    return;
  }
  var_0 = (5579.22, -4307.96, -418.156);
  level.hadir_ai scripts\sp\maps\hometown\hometown_util.gsc::wait_near(var_0, 1000);
  level.hadir_ai scripts\sp\maps\hometown\hometown_util.gsc::wait_near(level.player, 400);
  level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::say("dx_vom_had_pistol_start_truck_30");
  var_1 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_1 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("hadir", "dx_vom_had_pistol_start_truck_40", "Let's get out of here.");
  var_1 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("hadir", "dx_vom_had_pistol_start_truck_50", "Let's get in the truck.");
  var_1 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("hadir", "dx_vom_had_pistol_start_truck_60", "Come, Farah! It's time to go!");
  var_1 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("hadir", "dx_vom_had_pistol_start_truck_70", "In the truck, sister!");
  wait 1;
  var_1 scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket(undefined, "dx_vom_had_pistol_start_truck_40");

  for(;;) {
    wait(randomfloatrange(7, 12));
    var_1 scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();
  }
}

first_spotted() {
  level.pistol_enemy_01_ai endon("stealth_hunt");
  level.pistol_enemy_02_ai endon("stealth_hunt");

  if(isalive(level.pistol_enemy_02_ai))
    scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_spotted_10", "What the fuck?!");

  level.pistol_vo.context["never_spotted"] = 0;

  if(!isalive(level.pistol_enemy_02_ai) || !isalive(level.pistol_enemy_01_ai)) {
    return;
  }
  level.pistol_vo.distract = load_unharmed_pistol_hunt_distract();
  level.pistol_vo.distract_followup = undefined;
  level.pistol_vo.distract_end = load_unharmed_pistol_hunt_distract_end();
  level.pistol_vo.distract_end_followup = load_unharmed_pistol_hunt_distract_end_followup();
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_spotted_20", "There's a girl!");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_spotted_30", "Hey! You!");
}

first_lost() {
  level.pistol_vo.context["first_lost"] = 0;

  if(level.pistol_vo.context["player_got_gun"])
    scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_spotted_60", "Find her!");
  else {
    scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_spotted_50", "Was she armed?");
    scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_spotted_60", "Find her!");
    wait 1.5;
    scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_spotted_70", "I don't think so...");
  }
}

wait_soldier_death() {
  for(;;) {
    if(isalive(level.pistol_enemy_01_ai) && isalive(level.pistol_enemy_02_ai))
      scripts\engine\utility::waittill_any_ents(level.pistol_enemy_01_ai, "death", level.pistol_enemy_02_ai, "death");
    else if(isalive(level.pistol_enemy_01_ai))
      level.pistol_enemy_01_ai waittill("death");
    else if(isalive(level.pistol_enemy_02_ai))
      level.pistol_enemy_02_ai waittill("death");
    else
      break;

    level.pistol_vo notify("enemy_died");
    level notify("pistol_fight_state_change");
    level.pistol_vo.state = "soldier_dying";
    scripts\sp\maps\hometown\hometown_vo_util.gsc::stop_vo_source("ru_soldier_1");
    scripts\sp\maps\hometown\hometown_vo_util.gsc::stop_vo_source("ru_soldier_2");
    wait 1;
    scripts\sp\maps\hometown\hometown_vo_util.gsc::wait_vo_source_finish_speaking("ru_soldier_1");
    scripts\sp\maps\hometown\hometown_vo_util.gsc::wait_vo_source_finish_speaking("ru_soldier_2");

    if(isalive(level.pistol_enemy_01_ai)) {
      level.pistol_vo.context["soldiers_alive"] = "ru_soldier_2";
      thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_20", "Luka! No-!");
      level.pistol_vo.hunt = load_ru1_killed_hunt();
      level.pistol_vo.combat = load_ru1_killed_combat();
      level.pistol_vo.spotted = load_ru1_killed_spotted();
      level.pistol_vo.lost = load_ru1_killed_lost();
      level.pistol_vo.distract = load_ru1_killed_distract();
      level.pistol_vo.combat_distract = level.pistol_vo.distract;
    } else if(isalive(level.pistol_enemy_02_ai)) {
      level.pistol_vo.context["soldiers_alive"] = "ru_soldier_1";
      thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_kill_10", "Andrei! No-!");
      level.pistol_vo.hunt = load_ru2_killed_hunt();
      level.pistol_vo.combat = load_ru2_killed_combat();
      level.pistol_vo.spotted = load_ru2_killed_spotted();
      level.pistol_vo.lost = load_ru2_killed_lost();
      level.pistol_vo.distract = load_ru2_killed_distract();
      level.pistol_vo.combat_distract = level.pistol_vo.distract;
    } else
      break;

    level.pistol_vo.distract_followup = undefined;
    level.pistol_vo.distract_end = undefined;
    level.pistol_vo.distract_end_followup = undefined;
    level.pistol_vo.context["never_spotted"] = 0;
    level.pistol_vo.context["first_lost"] = 0;

    if(is_in_combat()) {
      thread goto_state("combat");
      continue;
    }

    thread goto_state("hunt");
  }
}

stealth_combat_check() {
  for(;;) {
    scripts\engine\utility::waittill_any_ents(level.pistol_vo, "fake_soldier_combat", level.pistol_enemy_01_ai, "stealth_combat", level.pistol_enemy_02_ai, "stealth_combat");
    waitframe();
  }
}

shot_at_check() {
  self endon("death");
  var_0 = 0;

  for(;;) {
    self waittill("bulletwhizby", var_1, var_2, var_3, var_4);

    if(level.pistol_vo.state == "shot_at") {
      continue;
    }
    level.pistol_vo.state = "shot_at";
    wait 0.1;
    level notify("pistol_fight_state_change");

    if(self == level.pistol_enemy_01_ai)
      ru_1_shot_at(var_0);

    if(self == level.pistol_enemy_02_ai)
      ru_2_shot_at(var_0);

    var_0++;

    if(is_in_combat()) {
      thread goto_state("combat");
      continue;
    }

    thread goto_state("hunt");
  }
}

ru_1_shot_at(var_0) {
  level endon("pistol_fight_state_change");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_shotat_20", "<reaction to getting shot at>");
  level.pistol_enemy_01_ai.shot_at_react scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket(level.pistol_vo.context);

  if(isalive(level.pistol_enemy_02_ai) && var_0 == 0) {
    wait 1;
    scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_shotat2_90", "She get you?!");
    wait 0.2;
    scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_shotat2_140", "Negative!");
  }
}

ru_2_shot_at(var_0) {
  level endon("pistol_fight_state_change");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_shotat_10", "<reaction to getting shot at>");
  level.pistol_enemy_02_ai.shot_at_react scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket(level.pistol_vo.context);
  scripts\sp\maps\hometown\hometown_vo_util.gsc::wait_vo_source_finish_speaking("ru_soldier_1");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::wait_vo_source_finish_speaking("ru_soldier_2");
  wait 1;

  if(var_0 == 0 && isalive(level.pistol_enemy_02_ai))
    scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_shotat2_100", "Work on your aim, suka!");
  else if(var_0 == 1 && isalive(level.pistol_enemy_01_ai))
    scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_shotat2_120", "She missed again!");
}

stealth_event_check() {
  for(;;) {
    level waittill("stealth_event", var_0);

    if(!isDefined(var_0.entity.source_name) || var_0.entity.source_name != "farah") {
      continue;
    }
    if(var_0.type == "combat" && level.pistol_vo.state != "combat")
      thread goto_state("combat");

    waitframe();
  }
}

get_closest_enemy_to_hadir() {
  var_0 = distance2dsquared(level.hadir_ai.origin, level.pistol_enemy_01_ai.origin);
  var_1 = distance2dsquared(level.hadir_ai.origin, level.pistol_enemy_02_ai.origin);

  if(var_0 < var_1)
    return level.pistol_enemy_01_ai;
  else
    return level.pistol_enemy_02_ai;
}

goto_state(var_0) {
  level notify("pistol_fight_state_change");
  level endon("pistol_fight_state_change");
  level.player endon("death");
  level.pistol_vo endon("enemy_died");
  var_1 = undefined;

  switch (var_0) {
    case "combat":
      level.pistol_vo.state = "combat";
      var_2 = is_in_combat();

      if(!var_2 && level.pistol_vo.context["never_spotted"])
        first_spotted();
      else if(!var_2)
        level.pistol_vo.spotted scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();

      var_1 = wait_combat_exit();
    case "hunt":
      level.pistol_vo.state = "hunt";
      var_3 = !isDefined(var_1) || var_1;
      scripts\sp\maps\hometown\hometown_vo_util.gsc::wait_vo_source_finish_speaking("ru_soldier_1");
      scripts\sp\maps\hometown\hometown_vo_util.gsc::wait_vo_source_finish_speaking("ru_soldier_2");

      if(var_3 && level.pistol_vo.context["first_lost"])
        first_lost();
      else if(var_3)
        level.pistol_vo.lost scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();

      wait_hunt_exit();
      break;
    case "investigate":
      break;
    case "idle":
      break;
    default:
      break;
  }
}

is_in_combat() {
  var_0 = !isDefined(level.pistol_enemy_01_ai) || level.pistol_enemy_01_ai[[level.pistol_enemy_01_ai.fnisinstealthcombat]]();
  var_1 = !isDefined(level.pistol_enemy_02_ai) || level.pistol_enemy_02_ai[[level.pistol_enemy_02_ai.fnisinstealthcombat]]();
  return var_0 && var_1;
}

wait_combat_exit() {
  level.pistol_enemy_01_ai endon("stealth_hunt");
  level.pistol_enemy_02_ai endon("stealth_hunt");

  if(!is_in_combat())
    return 1;

  scripts\sp\maps\hometown\hometown_vo_util.gsc::wait_vo_source_finish_speaking("ru_soldier_1");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::wait_vo_source_finish_speaking("ru_soldier_2");

  for(;;) {
    wait(randomfloatrange(4, 6));
    level.pistol_vo.combat scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();
  }
}

wait_hunt_exit() {
  for(;;) {
    wait(randomfloatrange(4, 6));
    level.pistol_vo.hunt scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();
  }
}

pistol_fight_vo() {
  level endon("pistol_enemies_dead");
  childthread russian_found_revolver();
  childthread fail_steal_truck();
  childthread distract_check();

  if(!scripts\sp\maps\hometown\hometown_util.gsc::skipchildrenkillingscene()) {
    childthread get_revolver_reminders();
    thread pistol_fired_check();
  }
}

fail_steal_truck() {
  level waittill("car_door_interacted_early");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_truckspot_10", "Hey! At the truck!");
}

pistol_fired_check() {
  level endon("car_door_interacted");
  scripts\engine\utility::flag_wait("objective_shoot_the_soldiers");
  var_0 = [];
  var_0[var_0.size] = "dx_vom_far_pistol_start_firstfire_10";
  var_0[var_0.size] = "dx_vom_far_house_boss_kill_11";
  var_0[var_0.size] = "dx_vom_far_house_boss_kill_12";
  var_1 = scripts\engine\sp\utility::create_deck(var_0);

  for(;;) {
    level.player waittill("weapon_fired");
    thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("farah", var_1 scripts\engine\sp\utility::deck_draw(), "<surprised/squeal effort>Agh!");
  }
}

get_revolver_reminders() {
  level endon("objective_shoot_the_soldiers");
  var_0 = getEnt("farah_pistol_pickup", "script_noteworthy");
  var_1 = ["dx_vom_far_pistol_start_objective_10", "dx_vom_far_pistol_start_objective_20", "dx_vom_far_pistol_start_objective_30"];
  var_2 = scripts\engine\sp\utility::create_deck(var_1);
  level waittill("pistol_can_interact");
  wait 10;
  level.player scripts\sp\maps\hometown\hometown_util.gsc::wait_lookat(var_0.origin + (0, 0, 40), 160, undefined, 0.3, 400);
  wait(randomfloatrange(0.1, 0.65));

  if(distance2dsquared(level.player.origin, var_0.origin) > 16000)
    level.player scripts\sp\maps\hometown\hometown_vo_util.gsc::say(var_2 scripts\engine\sp\utility::deck_draw_specific("dx_vom_far_pistol_start_objective_20"));

  var_3 = 10;
  var_4 = 2;

  for(;;) {
    wait(randomfloatrange(var_3 - var_4, var_3 + var_4));
    level.player scripts\sp\maps\hometown\hometown_util.gsc::wait_lookat(var_0.origin + (0, 0, 40), 160, undefined, 0.3, 400);
    wait(randomfloatrange(0.1, 0.65));

    if(distance2dsquared(level.player.origin, var_0.origin) < 16000) {
      continue;
    }
    level.player scripts\sp\maps\hometown\hometown_vo_util.gsc::say(var_2 scripts\engine\sp\utility::deck_draw());
    var_3 = min(var_3 + 5, 25);
    var_4 = min(var_4 + 1, 5);
  }
}

value_plus_or_minus_offset(var_0, var_1) {
  return randomfloatrange(var_0 - var_1, var_0 + var_1);
}

distract_check() {
  for(;;) {
    level.player waittill("use_cellphone");
    wait 2;
    level notify("pistol_fight_state_change");
    level.pistol_vo.state = "distracted";
    scripts\sp\maps\hometown\hometown_vo_util.gsc::stop_vo_source("ru_soldier_1");
    scripts\sp\maps\hometown\hometown_vo_util.gsc::stop_vo_source("ru_soldier_2");
    thread enemies_distracted();
    level.pistol_vo.context["times_called"]++;
  }
}

enemies_distracted() {
  level endon("pistol_fight_state_change");
  var_0 = level.pistol_vo.context["times_called"];
  wait 0.1;

  if(is_in_combat()) {
    level.pistol_vo.combat_distract scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket(level.pistol_vo.context);

    if(level.pistol_vo.context["never_spotted"]) {
      return;
    }
    if(is_in_combat())
      thread goto_state("combat");
    else
      thread goto_state("hunt");
  } else {
    if(isDefined(level.pistol_vo.distract)) {
      level.pistol_vo.distract scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();

      if(isDefined(level.pistol_vo.distract_followup)) {
        wait 0.2;
        level.pistol_vo.distract_followup scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();
      }
    }

    var_1 = spawnStruct();
    var_1.finished_convo = 1;

    if(level.pistol_vo.context["never_spotted"]) {
      if(var_0 == 0)
        childthread confused_about_phone(var_1);

      level.pistol_enemy_02_ai scripts\engine\utility::waittill_any("stealth_idle");
    } else
      wait(randomfloatrange(8, 15));

    if(var_1.finished_convo) {
      if(isDefined(level.pistol_vo.distract_end)) {
        level.pistol_vo.distract_end scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();

        if(isDefined(level.pistol_vo.distract_end_followup)) {
          wait 0.2;
          level.pistol_vo.distract_end_followup scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();
        }
      }
    }

    if(level.pistol_vo.context["never_spotted"]) {
      return;
    }
    if(is_in_combat()) {
      thread goto_state("combat");
      return;
    }

    thread goto_state("hunt");
  }
}

confused_about_phone(var_0) {
  var_0.finished_convo = 0;
  wait 2;
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_distractidle_10", "What do you think it was?");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_distractidle_20", "Don't know. Some animal?");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_distractidle_30", "That didn't sound like an animal.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_distractidle_40", "Could be a cricket.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_distractidle_50", "It's broad daylight. They come out at night.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_distractidle_60", "Maybe the gas fucked ‘em up, then.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_distractidle_70", "Maybe the gas fucked you up if you think that was a cricket.");
  var_0.finished_convo = 1;
}

russian_found_revolver() {
  level endon("pistol_fight_state_change");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_rubanter_10", "A-2, you've got another truck on its way.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_team_leader", "dx_vom_rutl_pistol_start_rubanter_20", "Understood.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_rubanter_30", "Hey, check it out!");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_rubanter_40", "I found a revolver!");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_rubanter_50", "He was armed?");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_rubanter_60", "Yeah. He didn't even go for it.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_rubanter_70", "Look at this thing, it's brand new.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_rubanter_80", "What do you need a revolver for? It's only six shots. You have a sidearm.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_rubanter_90", "Not like this one.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_rubanter_100", "Heh , so cool...");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_rubanter_110", "Reap your spoils later, Ushkuinik. Finish searching these fuckers.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_rubanter_120", "Yeah, but you stay away from my shit, okay?");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_rubanter_130", "I don't care about your shit. It can't even penetrate armor.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_rubanter_140", "It's a .44! It'll punch a hole right through you.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_rubanter_150", "Bull shit.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_rubanter_160", "Want to bet on it?");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_rubanter_170", "You're not shooting that thing at me.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_rubanter_180", "Yeah, because you're scared I'm right.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_rubanter_190", "No, you just have shitty aim.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_rubanter_200", "We'll test it back at camp, then.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_rubanter_210", "How much?");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_rubanter_220", "No money. If you lose, you take my clean-up shift.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_rubanter_230", "Cleanup?");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_rubanter_240", "What block?");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_rubanter_250", "General's quarters.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_rubanter_260", "Are you fucking crazy?!");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_rubanter_270", "Don't be a bitch.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_rubanter_290", "You'd rather sweat over opium than wipe up a little mess?");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_rubanter_300", "100 percent.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_team_leader", "dx_vom_rutl_pistol_start_rubanter_310", "K-4, General Barkov's convoy is exiting the city. They're headed your way now. We need extra security on the vehicles.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_rubanter_320", "Copy. Will comply.");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_rubanter_330", "Okay, let's finish this up before the General gets here.");
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_corpseloot_10", "This one's clean.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_corpseloot_20", "Same here.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_corpseloot_30", "Fuckin' heat...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_corpseloot_40", "Nothing on this one, either.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_corpseloot_50", "Keep searching 'em.");

  for(;;) {
    wait(randomfloatrange(5, 8));
    var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_bucket();
  }
}

children_crying() {
  thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_female_1", "dx_vom_cvf1_pistol_start_overlook_10", "<crying/moaning efforts>");
  wait 1;
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_child_male_1", "dx_vom_ccm1_pistol_start_overlook_12", "<crying/moaning efforts>");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_child_male_2", "dx_vom_ccm2_pistol_start_overlook_13", "<crying/moaning efforts>");
}

more_crying() {
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_female_1", "dx_vom_cvf1_pistol_start_overlook_140", "<crying/pleading efforts>");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_female_2", "dx_vom_cf2_pistol_start_overlook_141", "<crying/pleading efforts>");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_child_male_1", "dx_vom_ccm1_pistol_start_overlook_142", "<crying/pleading efforts>");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_child_male_2", "dx_vom_ccm2_pistol_start_overlook_143", "<crying/pleading efforts>");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_child_female_1", "dx_vom_ccf1_pistol_start_overlook_144", "<crying/pleading efforts>");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("civilian_child_female_2", "dx_vom_ccf2_pistol_start_overlook_145", "<crying/pleading efforts>");
}

drive_start_vo() {
  level endon("drive_start_vo_kill");
  level.player scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source("farah", "Farah");
  scripts\sp\maps\hometown\hometown_vo_util.gsc::register_vo_source_at_pos("ru_soldier_4", "Russian Soldier", level.player.origin);
  wait 9;
  wait 1;
  scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("farah", "dx_vom_far_pistol_start_taken_50", "<struggling/hitting efforts>");
  thread scripts\sp\maps\hometown\hometown_vo_util.gsc::play_vo_line("farah", "dx_vom_far_pistol_start_taken_60", "No! Let go! Let go!");
}

load_rubble_res1_yells_01() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket("rubble_res1_yells_01");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_1", "dx_vom_re1_buried_start_rubble_20", "Keep looking! There could be more survivors!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_1", "dx_vom_re1_buried_start_rubble_30", "Listen for movement!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_1", "dx_vom_re1_buried_start_rubble_40", "Don't stop, more people may be trapped underneath!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_1", "dx_vom_re1_buried_start_rubble_50", "Come on , come on- There could still be people in there!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_1", "dx_vom_re1_buried_start_rubble_60", "Listen closely for voices in the rubble!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_1", "dx_vom_re1_buried_start_rubble_70", "There may be others, keep digging!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_1", "dx_vom_re1_buried_start_rubble_80", "Pay attention- if we don't see them we may hear them!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_1", "dx_vom_re1_buried_start_rubble_90", "Fast as you can, come on, let's find these people!;");
  return var_0;
}

load_rubble_dad_yells_01() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket("rubble_dad_yells_01");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("father", "dx_vom_dad_buried_start_rubble_100", "My family is in there!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("father", "dx_vom_dad_buried_start_rubble_760", "Sahar?! Fatima, Farah, Hadir?!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::end_vo_group(1);
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("father", "dx_vom_dad_buried_start_rubble_110", "Please hurry... My wife and children were here!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("father", "dx_vom_dad_buried_start_rubble_120", "Brother, please, my wife and kidsare under there!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("father", "dx_vom_dad_buried_start_rubble_130", "Hurry, hurry, please, my family was here, I'm telling you...!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("father", "dx_vom_dad_buried_start_rubble_140", "We have to find them , please!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("father", "dx_vom_dad_buried_start_rubble_150", "They went shopping after school, with my wife...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::set_vo_bucket_selection("highest_weight");
  return var_0;
}

load_rubble_res1_calming_01() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket("rubble_res1_calming_01");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_1", "dx_vom_re1_buried_start_rubble_160", "If they're here, we'll find them, brother!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_1", "dx_vom_re1_buried_start_rubble_170", "Have faith , man, we'll get them out!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_1", "dx_vom_re1_buried_start_rubble_180", "Calm downn , my friend, we'll find them.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_1", "dx_vom_re1_buried_start_rubble_190", "Don't worry, friend , they'll get to them.");
  return var_0;
}

load_rubble_res2_yells_01() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket("rubble_res2_yells_01");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_2", "dx_vom_re2_buried_start_rubble_200", "Move that concrete!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_2", "dx_vom_re2_buried_start_rubble_220", "Push , push!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_2", "dx_vom_re2_buried_start_rubble_230", "Hard as you can, hard as you can!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_2", "dx_vom_re2_buried_start_rubble_240", "Help us, help us!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_2", "dx_vom_re2_buried_start_rubble_250", "Give me a shovel!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_2", "dx_vom_re2_buried_start_rubble_260", "Watch that rebar!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_2", "dx_vom_re2_buried_start_rubble_280", "Watch it now, don't fall!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_2", "dx_vom_re2_buried_start_rubble_290", "Help me move this!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_2", "dx_vom_re2_buried_start_rubble_300", "Pass it here, pass it here...!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_2", "dx_vom_re2_buried_start_rubble_310", "I'll help you!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_2", "dx_vom_re2_buried_start_rubble_320", "Give me some room!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_2", "dx_vom_re2_buried_start_rubble_330", "I got it!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_2", "dx_vom_re2_buried_start_rubble_340", "Both hands, guys, both hands...!");
  return var_0;
}

load_rubble_res3_yells_01() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket("rubble_res3_yells_01");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_rubble_350", "Watch your step, watch your step.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_rubble_360", "Bring the sledge! We need to break up these pieces!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_rubble_370", "Pry it with the shovel!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_rubble_380", "Put the pieces over here!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_rubble_390", "Watch you head, watch your head!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_rubble_400", "Help him out over there!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_rubble_410", "Careful , it's heavy!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_rubble_420", "Lift with me, lift it!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_rubble_430", "I got it, I got it...!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_rubble_440", "Coming through, coming through!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_rubble_450", "We need more manpower!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_rubble_460", "Out of the way!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_rubble_470", "Hand me a bucket!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_rubble_480", "Pass it down!");
  return var_0;
}

load_rubble_res4_5_getwater_01() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket("rubble_res4_5_getwater_01");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_4", "dx_vom_re4_buried_start_rubble_490", "Take these buckets, get water.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_5", "dx_vom_re5_buried_start_rubble_500", "From where?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_4", "dx_vom_re4_buried_start_rubble_510", "The hydrant in the square.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_5", "dx_vom_re5_buried_start_rubble_520", "The hydrant is buried under rubble!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_4", "dx_vom_re4_buried_start_rubble_530", "Take water from the fountain, go quickly!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::set_vo_bucket_sequential();
  return var_0;
}

load_rubble_res6_7_getrope_01() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket("rubble_res6_7_getrope_01");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_6", "dx_vom_re6_buried_start_rubble_540", "Joseph, we need more rope, go to my shop.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_7", "dx_vom_re7_buried_start_rubble_550", "Where do I look?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_6", "dx_vom_re6_buried_start_rubble_560", "In the basement.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_7", "dx_vom_re7_buried_start_rubble_570", "I'll need a flashlight.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_6", "dx_vom_re6_buried_start_rubble_580", "Behind the door. Bring it back with you, go!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_7", "dx_vom_re7_buried_start_rubble_590", "Tell my wife where I went!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_6", "dx_vom_re6_buried_start_rubble_600", "I will. Tell mine I'm here!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::set_vo_bucket_sequential();
  return var_0;
}

load_rubble_civ1_2_phone_convo_01() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket("rubble_civ1_2_phone_convo_01");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("civilian_1", "dx_vom_civ1_buried_start_rubble_610", "My phone died.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("civilian_2", "dx_vom_civ2_buried_start_rubble_620", "Take mine!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("civilian_1", "dx_vom_civ1_buried_start_rubble_630", "Are you sure?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("civilian_2", "dx_vom_civ2_buried_start_rubble_640", "Yes, just give it back when you're through.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("civilian_1", "dx_vom_civ1_buried_start_rubble_650", "I am trying to find my brother.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("civilian_2", "dx_vom_civ2_buried_start_rubble_660", "Where was he?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("civilian_1", "dx_vom_civ1_buried_start_rubble_670", "Making deliveries in the city.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("civilian_2", "dx_vom_civ2_buried_start_rubble_680", "Let's hope he's okay.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("civilian_1", "dx_vom_civ1_buried_start_rubble_690", "If he is, we could use his truck...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("civilian_1", "dx_vom_civ1_buried_start_rubble_700", "Orhan, where are you...? I have no battery, a guy lent this to me... Yes, I'm fine, we are near the market... There was more than 5 bombs, I can tell you that, more than 2 hit the market and we could hear the bombs hitting before and after... They're still in the sky now, maybe you can you see them from where you are... Listen, if you can bring your truck back here we could really use it-");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("civilian_1", "dx_vom_civ1_buried_start_rubble_710", "My brother says the roads are all blocked with checkpoints, people are evacuating and the highway is not moving...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("civilian_2", "dx_vom_civ2_buried_start_rubble_720", "Better to go on foot, just bring plenty of water.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::set_vo_bucket_sequential();
  return var_0;
}

load_rubble_res1_yells_02() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket("rubble_770_850");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_1", "dx_vom_re1_buried_start_rubble_770", "Stand back! Give us room to work!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_1", "dx_vom_re1_buried_start_rubble_780", "Watch yourself, watch yourself!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_1", "dx_vom_re1_buried_start_rubble_790", "Hey, out of the street, we have vehicles coming through...!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_1", "dx_vom_re1_buried_start_rubble_800", "Watch where you step, it's sharp!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_1", "dx_vom_re1_buried_start_rubble_820", "Out of the way!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_1", "dx_vom_re1_buried_start_rubble_830", "Step aside!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_1", "dx_vom_re1_buried_start_rubble_840", "Clear a path!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_1", "dx_vom_re1_buried_start_rubble_850", "Move, move!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_1", "dx_vom_re1_buried_start_noise2_130", "Let’s keep searching this area.");
  return var_0;
}

load_rubble_res2_yells_02() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket("rubble_920_1030");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_2", "dx_vom_re2_buried_start_rubble_1000", "Hand it down the line!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_2", "dx_vom_re2_buried_start_rubble_1010", "Break up those cinder blocks!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_2", "dx_vom_re2_buried_start_rubble_1020", "Pile them here!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_2", "dx_vom_re2_buried_start_rubble_1030", "Pass it down, pass it down!");
  return var_0;
}

load_rubble_res3_yells_02() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket("rubble_860_910");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_rubble_860", "Go to my truck, quickly, get my tools!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_rubble_870", "Grab a shovel! And get the crowbar!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_rubble_880", "Here take my keys, go!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_rubble_890", "Fast as you can, friend, go!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_rubble_900", "Get a flashlight too!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_rubble_910", "Bring the first-aid kit!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_noise2_150", "Pass me the shovel…");
  return var_0;
}

load_rubble_res1_yells_03() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket("rubble_1060_1100");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_1", "dx_vom_re1_buried_start_noise3_40", "Dig here , dig here!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_1", "dx_vom_re1_buried_start_noise3_50", "We’ll get you out, don’t worry…!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_1", "dx_vom_re1_buried_start_noise3_100", "Set it down, watch the weight!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_1", "dx_vom_re1_buried_start_rubble_1060", "I hear the Russian planes! They're coming back!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_1", "dx_vom_re1_buried_start_rubble_1070", "They're getting closer , I can hear it!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_1", "dx_vom_re1_buried_start_rubble_1080", "The Russian are moving in, we have to hurry!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_1", "dx_vom_re1_buried_start_rubble_1090", "Let's move it, people, quickly, quickly!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_1", "dx_vom_re1_buried_start_rubble_1100", "Hurry up, hurry up, every second counts!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_noise2_20", "It’s close...");
  return var_0;
}

load_rubble_res2_yells_03() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket("rubble_1180_1270");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_2", "dx_vom_re2_buried_start_rubble_1150", "Someone watch the sky for movement!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_2", "dx_vom_re2_buried_start_rubble_1160", "Watch the air for Russian fighters!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_2", "dx_vom_re2_buried_start_rubble_1170", "Yusef, watch the sky for fighter jets!");
  return var_0;
}

load_rubble_res3_yells_03() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket("rubble_1180_1270");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_rubble_1180", "I found an arm here...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_rubble_1190", "Get me a bag!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_rubble_1200", "Take these buckets!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_rubble_1210", "I see a body under the cinder blocks.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_rubble_1220", "Keep these together, and bring another bag...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_rubble_1230", "Let's find the rest of him if we can...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_rubble_1240", "That leg belongs with this one, set it down gently.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_rubble_1250", "The other shoe goes with it , don't separate them.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_rubble_1260", "We need a body bag over here!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_rubble_1270", "Gently with that, gently...!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_noise3_80", "That’s it, it’s coming loose…");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_3", "dx_vom_re3_buried_start_noise3_120", "Almost there!");
  return var_0;
}

load_noise_res_nags() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_1", "dx_vom_re1_buried_start_noise1_70", "If you can hear me, make that sound again!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_1", "dx_vom_re1_buried_start_noise1_80", "Make some noise if you can move...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("rescuer_2", "dx_vom_re2_buried_start_noise1_110", "Knock again if you can hear me...!");
  return var_0;
}

load_noise0() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_investigate_10", "Who’s there?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_investigate_20", "Hello?");
  return var_0;
}

load_spotted0() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_sighted_10", "Hey!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_sighted_20", "You! Halt!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_sighted_30", "Hey, girl!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_sighted_31", "Stop! Don't move!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_sighted_32", "Hold it!");
  return var_0;
}

load_lost0() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_investigate_70", "Nothing.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_investigate_60", "Hrmph...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_investigate_80", "Probably rats...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0.65, "russian_j12", "dx_vom_rj12_house_boss_investigate_90", "Or those fucking chickens...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_investigate_101", "No one here?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0, "russian_j12", "dx_vom_rj12_house_boss_investigate_103", "Maybe not.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_investigate_102", "Yes...? No...?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_investigate_104", "Hmph...rats in the walls.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::set_vo_bucket_sequential();
  return var_0;
}

load_hunt0() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_patrol_30", "Rrgh! Worthless shit...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_patrol_40", "Argh...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j13", "dx_vom_rj13_house_boss_patrol_50", "12, report.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(1.65, "russian_j13", "dx_vom_rj13_house_boss_patrol_60", "Report.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0.65, "russian_j12", "dx_vom_rj12_house_boss_patrol_70", "Searching house to house- Got a kid for the boss...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0.25, "russian_j12", "dx_vom_rj12_house_boss_patrol_110", "Should I kill him?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0.65, "russian_j13", "dx_vom_rj13_house_boss_patrol_120", "Negative. Bring him to the trucks.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0.65, "russian_j12", "dx_vom_rj12_house_boss_patrol_121", "Bring the trucks here, no?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0.65, "russian_j13", "dx_vom_rj13_house_boss_patrol_122", "No.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0.65, "russian_j12", "dx_vom_rj12_house_boss_patrol_123", "Why?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0.65, "russian_j13", "dx_vom_rj13_house_boss_patrol_124", "Those are the orders.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0.65, "russian_j13", "dx_vom_rj13_house_boss_patrol_125", "Can't you carry him?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0.65, "russian_j12", "dx_vom_rj12_house_boss_patrol_126", "Then I can only bring one.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0.65, "russian_j13", "dx_vom_rj13_house_boss_patrol_127", "Do you have more than one?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0.65, "russian_j12", "dx_vom_rj12_house_boss_patrol_128", "No, but how can I search?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0.65, "russian_j13", "dx_vom_rj13_house_boss_patrol_129", "He'll be a human shield.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0.65, "russian_j12", "dx_vom_rj12_house_boss_patrol_131", "Are there snipers?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0.65, "russian_j13", "dx_vom_rj13_house_boss_patrol_132", "We've heard reports.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0.65, "russian_j12", "dx_vom_rj12_house_boss_patrol_133", "Where?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0.65, "russian_j13", "dx_vom_rj13_house_boss_patrol_134", "Just bring what you have, and kill the rest.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0.65, "russian_j12", "dx_vom_rj12_house_boss_patrol_135", "Copy that- Out.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0.65, "russian_j12", "dx_vom_rj12_house_boss_patrol_136", "Asshole.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::set_vo_bucket_sequential();
  return var_0;
}

load_hunt0_loop() {
  return undefined;
}

load_combat0() {
  return undefined;
}

load_combat0_loop() {
  return undefined;
}

load_noise1() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_investigate_40", "Come out, lemme see your hands.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_investigate_50", "Let’s go...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_investigate_51", "Russian Army, show yourself.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_investigate_52", "Show me your hands.");
  return var_0;
}

load_spotted1() {
  return level.boss_vo.spotted;
}

load_lost1() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_investigate_60", "Hrmph...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_investigate_102", "Yes...? No...?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::set_vo_bucket_sequential();
  return var_0;
}

load_hunt1() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_investigate_30", "Someone there?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_investigate_57", "Who's in the house?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::set_vo_bucket_sequential();
  return var_0;
}

load_hunt1_loop() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_investigate_53", "Say something...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_investigate_54", "Talk to me, I can help you.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_investigate_55", "Let me see you, I won't shoot.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_investigate_56", "Are you hurt, I have medicine.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_investigate_58", "Don't be afraid...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_investigate_59", "I won't hurt you...");
  return var_0;
}

load_combat1() {
  return undefined;
}

load_combat1_loop() {
  return undefined;
}

load_noise2() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_search_00", "I can hear you, little one...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_search_01", "I heard that, child.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_search_02", "You're a clumsy little mouse, aren't you?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::set_vo_bucket_sequential();
  return var_0;
}

load_spotted2() {
  return level.boss_vo.spotted;
}

load_lost2() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_search_30", "Now where did you go, eh?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_rnd1trans_20", "Where are you?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_search_61", "Don't hide, it's not nice.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_rnd1trans_40", "You want to hide, eh? Okay...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_rnd1trans_50", "Don't make me have to come find you...!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_rnd1trans_60", "Where are you, little girl?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::set_vo_bucket_sequential();
  return var_0;
}

load_hunt2() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_search_20", "It’s okay , let me see you.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_search_64", "Everything is going to be fine, just come out now.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_search_68", "Come with me, we'll get help for your father.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_search_69", "Your brother is asleep, help me wake him.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_search_71", "I think I hear your friends , let's go see...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_search_72", "You like sweets...? I have candy...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_search_73", "You want some...? You can have it...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_search_74", "Don't you want some candy...?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::set_vo_bucket_sequential();
  return var_0;
}

load_hunt2_loop() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_searchloop_10", "Come on, get out here...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_searchloop_20", "I know you're still here...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_rule("'player_under_something == false");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_searchloop_30", "Come on out now...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_searchloop_40", "Stop hiding.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_searchloop_50", "Enough of this. Come out here.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_searchloop_60", "I promise I won't shoot, okay?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_searchloop_70", "You don't have to hide...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::set_vo_bucket_sequential();
  return var_0;
}

load_combat2() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_rnd1grab_10", "Stay where you are!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_rnd1grab_20", "Don't even think about running!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_rnd1grab_40", "Don't move, understand?!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_rnd1grab_50", "Stay right there...!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::end_vo_group(0, "'can_see_player");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_search_10", "Come back, little one! Don’t run!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_search_40", "Don’t worry, nothing to be afraid of.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_search_50", "I can protect you. Don’t be afraid.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_search_60", "Come back. I won’t shoot!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_search_62", "It's okay! The bad guys are gone now...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_search_63", "Nothing will happen to you...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_search_65", "Come on, now, let's go for a walk.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_search_66", "Let me show you something... come now.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_search_67", "Stop this, child, it's not safe for you here.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::end_vo_group(0, "'can_see_player == false");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::set_vo_bucket_fills_all();
  return var_0;
}

load_combat2_loop() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_searchbucket_10", "Don't run away!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_searchbucket_20", "Come back!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_searchbucket_30", "Get back here!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_searchbucket_40", "Stop running!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_searchbucket_50", "Where are you going?!");
  return var_0;
}

load_noise3() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_noise1_10", "I heard that, you little shit!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_noise1_20", "I know you’re here!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_noise1_30", "I’m coming for you, tifl(child)!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::set_vo_bucket_sequential();
  return var_0;
}

load_spotted3() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_spotted1_10", "I see you!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_spotted1_20", "You bitch!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_spotted1_40", "You little shit!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_spotted1_50", "Gotcha now!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_spotted1_60", "Now you’re in trouble!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0.65, "russian_j12", "dx_vom_rj12_house_boss_spotted1_70", "Real trouble!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::end_vo_group(0);
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_spotted2_10", "There’s the fucking rat!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_spotted2_20", "You’re mine, rat!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_spotted2_30", "Found you, bitch!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::set_vo_bucket_sequential();
  return var_0;
}

load_lost3() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_rnd2trans_20", "Go ahead and hide, bitch!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_rnd2trans_30", "I will find you!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_rnd2trans_40", "You'd better hide, suka!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_rnd2trans_50", "Hide all you want! You're stuck in here with me!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_rnd2trans_60", "Run away, little girl! Run and hide!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_hunt1_140", "You think you can hide forever?!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::end_vo_group(0);
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_rnd2trans_10", "Hiding again , eh?!");
  return var_0;
}

load_hunt3() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_rnd2hunt_10", "Who else is here?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_rnd2hunt_20", "Where's the mother...?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(1, "russian_j12", "dx_vom_rj12_house_boss_rnd2hunt_30", "Maybe she's with you...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0.85, "russian_j12", "dx_vom_rj12_house_boss_rnd2hunt_40", "Hiding...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_rnd2hunt_50", "Don't have time for this...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_hunt1_150", "There’s no escape, tifl(child)! Come out and let’s go outside.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_hunt1_160", "The air is very dirty. I have something to help you...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(1, "russian_j12", "dx_vom_rj12_house_boss_hunt1_170", "Come, I’ll give it to you...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_rnd2hunt_80", "Could just open the door...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0.65, "russian_j12", "dx_vom_rj12_house_boss_rnd2hunt_90", "Let the gas in...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_hunt1_60", "Or take you to my friends...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_hunt1_80", "Come on , try that again. Show me how brave you are...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j13", "dx_vom_rj13_house_boss_hunt1_180", "J-13 to 12, where are you?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0, "russian_j12", "dx_vom_rj12_house_boss_hunt1_190", "Searching... I found a girl.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0, "russian_j13", "dx_vom_rj13_house_boss_hunt1_200", "Good- General Barkov is here.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0, "russian_j13", "dx_vom_rj13_house_boss_hunt1_220", "Yes. Don’t come back empty handed. Out.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0, "russian_j12", "dx_vom_rj12_house_boss_hunt1_230", "Shit...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::set_vo_bucket_sequential();
  return var_0;
}

load_hunt3_loop() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_hunt2_80", "God damn heat.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_hunt2_90", "Every fucking day... no thanks...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_hunt2_250", "Nothing but trouble this one...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_hunt2_270", "There’s no way out, tifl! You’re trapped!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_hunt2_280", "Just give up...!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_hunt2_290", "Stop resisting...!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_hunt2_300", "Argghhh...!!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_hunt2_360", "Fucking armor plates... don’t do shit...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_hunt2_420", "Fuck this place...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_hunt2_430", "Too hot... Dry...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::end_vo_group(1);
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_hunt2_60", "You think I can’t find you!?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_hunt2_120", "Hiding only makes it worse!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_hunt2_40", "Where are you, little shit!?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::end_vo_group(0);
  return var_0;
}

load_combat3() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_hunt1_20", "Look what you did to my leg, you bitch!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_hunt1_40", "You stab me? A little piece of shit child...?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_hunt1_131", "The general doesn't like little terrorists...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::set_vo_bucket_sequential();
  return var_0;
}

load_combat3_loop() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_hunt1_124", "You're dead now, you little bitch!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_combat2loop_10", "Don't run away from me!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_combat2loop_20", "Come back here!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_combat2loop_30", "I'm coming for you, tifl!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_combat2loop_40", "Come here!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0.65, "russian_j12", "dx_vom_rj12_house_boss_combat2loop_50", "I'm gonna kill you!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_hunt2_225", "Don't run away you little shit!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_hunt2_220", "Come face me!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_hunt2_210", "You’re dead, you hear me?! Fucking dead!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_hunt1_30", "Just like your fucking father!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_hunt2_230", "This fucking family...!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_hunt2_240", "These fucking pathetic people!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_rnd3combatloop_10", "Get back here!!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_rnd3combatloop_20", "Don't run away from me!!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_rnd3combatloop_30", "You're going to die here, little girl!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_rnd3combatloop_40", "You're gonna fuckin' get it!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_rnd3combatloop_50", "Hiding won't save you!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_rnd3combatloop_60", "There's no escaping this, suka! You're fucking done!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::end_vo_group(0, "'can_see_player == false", undefined, 1000);
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_found_10", "I know you're under there...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_found_40", "I can see you, suka...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_found_50", "Get out from under there...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_found_70", "I see you under there...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_found_120", "Hiding under the furniture like a scared cat...!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_found_140", "You think you're safe from me?!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_found_150", "That won't protect you, child.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_found_160", "You're not safe there , kid!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_found_170", "Hiding under there won't save you!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_found_180", "Hiding there won't save you!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::end_vo_group(0, "'player_under_something", undefined, 100000);
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_found_190", "Time to see father again!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_found_200", "Game over, suka!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_found_210", "This is how I deal with rats!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_found_220", "I told you I'd find you!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("russian_j12", "dx_vom_rj12_house_boss_found_230", "Don't worry. I'll take care of you.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::end_vo_group(0);
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::set_vo_bucket_fills_all();
  return var_0;
}

load_noise4() {
  return level.boss_vo.noise;
}

load_spotted4() {
  return level.boss_vo.spotted;
}

load_lost4() {
  return level.boss_vo.lost;
}

load_hunt4() {
  return level.boss_vo.hunt;
}

load_hunt4_loop() {
  return level.boss_vo.hunt_loop;
}

load_combat4() {
  return level.boss_vo.combat_loop;
}

load_combat4_loop() {
  return level.boss_vo.combat;
}

load_unharmed_pistol_fight_combat() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_hunt_30", "You can't run. Surrender- Now!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_hunt_180", "Surrender! Now!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_shotat2_160", "Kill this bitch!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_shotat2_170", "Get her! What are you waiting for?!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_shotat2_180", "It’s just a kid! Go after her!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_shot_spot_10", "Shoot her!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_shot_spot_20", "Kill her!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_spotted_33", "Get her, Luka!");
  return var_0;
}

load_unharmed_pistol_fight_hunt() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_hunt_90", "You got anything?!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0.2, "ru_soldier_2", "dx_vom_ru2_pistol_start_hunt_100", "Negative! She's still out here…");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_hunt_110", "Get out here!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_search_10", "It's dangerous out here, kid. Don't get yourself hurt...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_search_20", "Don't be difficult. Get out here!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_search_30", "We have food and water. You must be thirsty, yes?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_search_40", "No need to hide. Come on out.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_search_50", "You must be scared, out here all by yourself.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_search_60", "We know you're unarmed, kid.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_search_70", "It's over! Get out here, now!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_search_80", "You need to listen to us. Don't make things worse for yourself.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_search_90", "Show yourself. You don't have to hide.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_search_100", "Surrender, kid. There's no need to fight.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_hunt_120", "We’re gonna find you!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_hunt_130", "You’re just a kid! You don’t want to hurt anyone!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_hunt_140", "Show yourself!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_hunt_150", "Come on out!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_hunt_160", "Come out now! It’s over!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_hunt_170", "This isn't a game, child! You're going to get yourself killed…");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_distract_loop_60", "You don't have to run away! Come on out!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_distract_loop_70", "Where are you?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_distract_loop_80", "Come back here , kid. Don't run!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_distract_loop_90", "Where the fuck did you run off to, eh?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_distract_loop_100", "Get back out here!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_distract_loop_110", "Where did you go, little one?!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_distract_loop_120", "You don't have to run away! Come on out!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_distract_return_150", "She can’t just disappear. Let's keep searching.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_distract_return_160", "The girl's still here. Find her…");
  return var_0;
}

load_unharmed_pistol_fight_spotted() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_hunt_spot_10", "Got her!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_hunt_spot_20", "She's here!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_hunt_spot_30", "I see her!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_hunt_spot_40", "Bitch!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_hunt_spot_50", "I found her!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_hunt_spot_60", "Right here!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_hunt_spot_70", "Got her!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_hunt_spot_80", "She's here!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_hunt_spot_90", "I see her!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_hunt_spot_100", "Bitch!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_hunt_spot_110", "I found her!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_hunt_spot_120", "Right here!");
  return var_0;
}

load_unharmed_pistol_fight_lost() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_shotat_40", "Did you get her?!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0.65, "ru_soldier_1", "dx_vom_ru1_pistol_start_shotat_50", "Negative!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_shotat_60", "Fuck- where'd she go?!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0.25, "ru_soldier_2", "dx_vom_ru2_pistol_start_shotat_70", "I don't know. Find her!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0.45, "ru_soldier_1", "dx_vom_ru1_pistol_start_shotat_80", "Okay, watch my back!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_shotat2_130", "Where is she?!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0.35, "ru_soldier_2", "dx_vom_ru2_pistol_start_shotat2_150", "Just find her already!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_hunt_70", "Fuck- I don’t see her!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_hunt_80", "She's hiding! Keep looking!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_hunt_112", "Fuck! We lost her!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0.2, "ru_soldier_2", "dx_vom_ru2_pistol_start_hunt_114", "No we didn't! She's still out here!");
  return var_0;
}

load_ru1_unspotted_pistol_idle_distract() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket(undefined, 1);
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_distract_10", "You hear that?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_distract_20", "It's coming from over there now...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_distract_30", "There it is again...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_distract_40", "Who's out there?! Show yourself!");
  return var_0;
}

load_ru2_unspotted_pistol_idle_distract() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket(undefined, 1);
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_distract_50", "Check it...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_distract_60", "Let's go...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_distract_70", "Someone's playing games...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_distract_80", "Find this son of a bitch...");
  return var_0;
}

load_unharmed_pistol_hunt_distract() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_hunt_distract_110", "I’ll check it.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_hunt_distract_120", "I’m on it. Cover me.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_hunt_distract_130", "I got it. Just watch my back.");
  return var_0;
}

load_unharmed_pistol_idle_distract_end() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_distractidle_80", "I don't see anything.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_distractidle_90", "Probably nothing...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_distractidle_100", "Sounds like it stopped. Whatever it was...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_distractidle_110", "No visual. Could've been nothing...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_distractidle_120", "Couldn't find anything.");
  return var_0;
}

load_unharmed_pistol_hunt_distract_end() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_distract_return_10", "No sign of the girl...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_distract_return_20", "Nothing but the wind out there.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_distract_return_30", "She’s not out there.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_distract_return_70", "Couldn't find anything.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line_linked(0.2, "ru_soldier_2", "dx_vom_ru2_pistol_start_distract_return_80", "The girl's still here. Find her…");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_distract_return_90", "Nothing's out there…");
  return var_0;
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
}

load_unharmed_pistol_hunt_distract_end_followup() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_distract_return_40", "She’s here somewhere...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_distract_return_50", "It could hide her movement. Stay alert.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_distract_return_60", "She can’t just disappear. Keep searching.");
  return var_0;
}

load_unharmed_pistol_combat_distract() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_hunt_distract_10", "The fuck?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_hunt_distract_20", "What--?!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_hunt_distract_30", "Over there!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_hunt_distract_40", "Huh?!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_hunt_distract_50", "-Shit!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_hunt_distract_60", "The fuck?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_hunt_distract_70", "What--?!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_hunt_distract_80", "Over there!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_hunt_distract_90", "Huh?!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_hunt_distract_100", "-Shit!");
  return var_0;
}

load_ru1_killed_combat() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_hunt_70", "You killed my friend you fucking bitch!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_hunt_80", "You’re dead, you hear me?!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_hunt_90", "You think I’m afraid of a little girl?!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_taunt_40", "You shoot at me, you’d better kill me!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_taunt_50", "I’m still here , suka! Try again!");
  return var_0;
}

load_ru2_killed_combat() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_kill_hunt_20", "You’re dead, you hear me?!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_kill_hunt_30", "You think I’m afraid of a little girl?!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_kill_taunt_10", "You shoot at me, you’d better kill me!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_kill_taunt_20", "I’m still here , suka! Try again!");
  return var_0;
}

load_ru1_killed_hunt() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_30", "You killed my friend you fucking bitch!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_40", "You're dead you hear me?!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_50", "You'll be food for the fuckin' worms!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_60", "Come on! Take your shot!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_hunt_110", "Think you can get a shot before I find you?!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_hunt_120", "Come out! Bring your gun! Let’s play...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_taunt_60", "Take your shot , little girl. Come play...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_hunt_100", "I know you have a gun, suka!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_hunt_280", "Come out and fight! Come on!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_hunt_290", "You’re going to die out here! You’ll be food for the fuckin’ worms!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_hunt_300", "C’mon! Let me see that little face of yours!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_hunt_40", "Don’t risk your life. Drop the gun.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_hunt_50", "Don't do anything stupid, kid.");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_hunt_60", "You're just making it harder on yourself!");
  return var_0;
}

load_ru2_killed_hunt() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_kill_hunt_130", "You killed my friend you fucking bitch!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_hunt_10", "Russian Army! Come out now!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_hunt_20", "I know you're here! Just give up!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_kill_hunt_50", "Think you can get a shot before I find you?!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_kill_hunt_60", "Come out! Bring your gun! Let’s play...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_kill_taunt_30", "Take your shot , little girl. Come play...");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_kill_hunt_40", "I know you have a gun, suka!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_kill_hunt_250", "Come out and fight! Come on!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_kill_hunt_260", "You’re going to die out here! You’ll be food for the fuckin’ worms!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_kill_hunt_270", "C’mon! Let me see that little face of yours!");
  return var_0;
}

load_ru1_killed_spotted() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_spot_70", "Got you!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_spot_80", "Little shit!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_spot_90", "Fucker!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_spot_100", "Bitch!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_spot_110", "Found you!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_spot_120", "I see you, bitch!");
  return var_0;
}

load_ru2_killed_spotted() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_kill_spot_10", "Got you!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_kill_spot_20", "Little shit!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_kill_spot_30", "Fucker!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_kill_spot_40", "Bitch!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_kill_spot_50", "Found you!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_kill_spot_60", "I see you, bitch!");
  return var_0;
}

load_ru1_killed_lost() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_70", "That's it! Run away!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_80", "You think I won't find you?!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_90", "I know you're out there!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_100", "You can't hide forever!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_shot2_distract_70", "Shit, where’d she go?!");
  return var_0;
}

load_ru2_killed_lost() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_distract_loop_10", "Where are you?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_distract_loop_20", "Come back here , kid. Don't run!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_distract_loop_30", "Where the fuck did you run off to, eh?");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_distract_loop_40", "Get back out here!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_distract_loop_50", "Where did you go, little one?!");
  return var_0;
}

load_ru1_killed_distract() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_miss_130", "Fuckin’ bitch!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_miss_140", "Asshole!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_miss_150", "What the fuck is that?!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_miss_160", "Son of a bitch!");
  return var_0;
}

load_ru2_killed_distract() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_kill_miss_10", "Fuckin’ bitch!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_kill_miss_20", "Asshole!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_kill_miss_30", "What the fuck is that?!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_kill_miss_40", "Son of a bitch!");
  return var_0;
}

load_ru1_pistol_shot_at() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_shotat2_10", "Fucker!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_shotat2_20", "Get down!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_shotat2_30", "Shit!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_shotat2_40", "Cover! Cover!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_kill_distract_10", "Fucker!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_kill_distract_20", "Bitch!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_kill_distract_30", "Shit!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_1", "dx_vom_ru1_pistol_start_kill_distract_40", "Agh!");
  return var_0;
}

load_ru2_pistol_shot_at() {
  var_0 = scripts\sp\maps\hometown\hometown_vo_util.gsc::create_vo_bucket();
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_shotat2_50", "Fucker!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_shotat2_60", "Get down!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_shotat2_70", "Shit!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_shotat2_80", "Cover! Cover!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_distract_50", "Fucker!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_distract_60", "Bitch!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_distract_70", "Shit!");
  var_0 scripts\sp\maps\hometown\hometown_vo_util.gsc::add_vo_line("ru_soldier_2", "dx_vom_ru2_pistol_start_kill_distract_80", "Agh!");
  return var_0;
}
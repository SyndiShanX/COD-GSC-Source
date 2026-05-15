/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\carrier_audio.gsc
*****************************************************/

main() {
  aud_init_globals();
  thread aud_ocean01_line_emitter_create();
  thread aud_ocean02_line_emitter_create();
}

aud_init_globals() {
  level.aud_can_play_tilt_screams = 0;
  level.aud_osprey_run = 0;
  level.aud_sparrow_launcher_loop = spawn("script_origin", level.player.origin);
  level.aud_slowmo_bg = spawn("script_origin", level.player.origin);
  level.aud_in_sparrow = 0;
}

aud_ignore_timescale() {
  soundsettimescalefactor("norestrict2d", 0);
  soundsettimescalefactor("voice", 0);
}

aud_check(var_0) {
  if(var_0 == "slow_intro") {
    level.player setclienttriggeraudiozone("intro_part1");
  } else if(var_0 == "medbay") {
    thread slow_intro_alarms();
    thread aud_medbay_alarms();
    thread aud_medbay_pa();
  } else if(var_0 == "deck_combat")
    thread aud_play_medbay_music();
  else if(var_0 == "deck_transition") {
    level.player setclienttriggeraudiozone("deck_transition");
    thread aud_carr_osprey_engines();
  } else if(var_0 == "defend_zodiac") {
    level.player setclienttriggeraudiozone("defend_zodiac");
    thread aud_play_zodiac_music();
  } else if(var_0 == "run_to_sparrow") {
    level.player setclienttriggeraudiozone("sparrow_run");
    thread aud_gunship_circling_pattern();
  } else if(var_0 == "defend_sparrow") {
    level.player setclienttriggeraudiozone("sparrow_run");
    thread aud_gunship_circling_pattern();
    thread aud_sparrow_run_spawn_fires();
    thread aud_sparrow_tone();
  } else if(var_0 == "victory_deck") {
    thread aud_play_victory_deck_music();
    thread aud_carr_victory_deck_checkpoint();
    thread aud_sparrow_run_spawn_fires();
  } else if(var_0 == "deck_tilt") {
    level.player setclienttriggeraudiozone("victory_deck");
    thread aud_sparrow_run_spawn_fires();
  }
}

aud_play_intro_music() {
  maps\_utility::music_play("mus_carrier_intro");
}

aud_play_battlestations_music() {}

aud_play_deck_reveal_music() {
  level.player setclienttriggeraudiozone("carrier_music_heavy", 0.5);
  wait 0.5;
  maps\_utility::music_crossfade("mus_carrier_deck_reveal", 2);
  wait 5;
  level.player clearclienttriggeraudiozone(1.0);
}

aud_play_medbay_music() {}

aud_play_deck_music() {}

aud_play_zodiac_music() {}

aud_post_sparrow_music() {
  maps\_utility::music_play("mus_carr_victory_deck");
}

aud_play_victory_deck_music() {
  maps\_utility::music_play("mus_carr_victory_deck");
}

aud_play_tilt_music() {
  maps\_utility::music_play("mus_carr_tilt");
}

aud_play_exfil_music() {
  level.aud_can_play_tilt_screams = 0;
  wait 0.75;
  maps\_utility::music_crossfade("mus_carr_exfil", 2.5);
}

aud_deck_transition_zone() {
  common_scripts\utility::flag_wait("deck_combat_finished");
  level.player setclienttriggeraudiozone("deck_transition", 7);
}

aud_defend_zodiac_zone() {
  if(!common_scripts\utility::flag("defend_zodiac_finished")) {
    level.player setclienttriggeraudiozone("defend_zodiac", 6);
  }
}

aud_defend_zodiac_osprey_zone() {
  if(level.aud_osprey_run < 2.0) {
    level.player setclienttriggeraudiozone("defend_zodiac", 0.2);
  } else {
    level.player setclienttriggeraudiozone("sparrow_run", 0.2);
    thread aud_gunship_circling_pattern();
  }
}

aud_zodiac_to_sparrow_zone() {
  level.player setclienttriggeraudiozone("sparrow_run", 3);
  wait 1;
  level.aud_gunship_loc = spawn("script_origin", level.ac_130.origin);
  level.aud_gunship_loc linkto(level.ac_130);
  level.aud_gunship_loc maps\_utility::sound_fade_in("scn_gunship_circling_pattern", 1, 0.5, 1);
  level waittill("circling_pattern_off");
  level.aud_gunship_loc maps\_utility::sound_fade_and_delete(7);
}

aud_intro_seq_lr() {}

aud_switch_zone_medbay() {
  wait 1;
  level.player setclienttriggeraudiozone("medbay_room");
  wait 0.1;
}

aud_clear_zone_medbay() {
  wait 5;
  level.player clearclienttriggeraudiozone(0.05);
  wait 0.1;
  level.player setclienttriggeraudiozonepartial("music_heavy_mix", "mix");
}

aud_carr_begin_promotion() {
  thread aud_carr_promotion_hsh();
  thread aud_carr_promotion_mrk();
  thread aud_carr_promotion_plr();
  thread aud_carr_promotion_dog();
}

aud_carr_promotion_mrk() {
  wait 28.52;
  thread common_scripts\utility::play_sound_in_space("scn_carr_promotion_mrk", (-710, 7539, 1300));
}

aud_carr_promotion_hsh() {
  var_0 = spawn("script_origin", (-613, 7359, 1300));
  wait 30.53;
  var_0 playSound("scn_carr_promotion_hsh");
  wait 2;
  var_0 moveto((-707, 7493, 1300), 5);
  wait 30;
  var_0 delete();
}

aud_carr_promotion_plr() {
  wait 53.36;
  level.player playSound("scn_carr_promotion_plr");
  wait 13.95;
  level.player playSound("scn_carr_medbay_pick_up_mask");
}

aud_carr_promotion_dog() {
  wait 58;
  thread common_scripts\utility::play_sound_in_space("scn_carr_dog_pet_1", (-707, 7493, 1287));
}

aud_carr_ghost_mask_on_plr() {
  level.player playSound("scn_carr_medbay_put_on_mask");
}

slow_intro_alarms() {
  common_scripts\utility::flag_wait("slow_intro_alarms");
  var_0 = getEntArray("slow_intro_alarm", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread maps\_utility::sound_fade_in("emt_crew_alarm", 2.0, 3.0, 1);
  }

  common_scripts\utility::flag_waitopen("slow_intro_alarms");
  common_scripts\utility::array_thread(var_0, maps\_utility::sound_fade_and_delete, 2);
}

aud_carr_pharmacy_shut() {
  wait 2.36;
  thread common_scripts\utility::play_sound_in_space("scn_carr_pharmacy_shut", (-993, 6334, 1326));
}

aud_medbay_alarms() {
  thread aud_play_loop_until_flag("emt_medbay_alarm", (-1001, 6331, 1325), "medbay_finished");
}

aud_flight_deck_bell() {
  thread common_scripts\utility::play_sound_in_space("scn_carr_medbay_bell", (-1264, 5171, 1489));
}

aud_medbay_pa() {}

aud_hatch_close() {
  wait 0.5;
  thread common_scripts\utility::play_sound_in_space("deck_hatch_close", (-1200, 5122, 1460));
}

aud_deck_tugger() {
  thread aud_deck_jet_idle();
  var_0 = spawn("script_origin", (-565, 4811, 1542));
  var_0 playSound("scn_carr_deck_tugger");
  var_0 moveto((-751, 4221, 1524), 2);
  wait 2;
  var_0 moveto((-431, 4039, 1524), 2.7);
  wait 3;
  var_0 moveto((-835, 4034, 1524), 3.2);
  wait 7;
  var_0 delete();
}

aud_deck_jet_idle() {
  var_0 = spawn("script_origin", (-1364, 4017, 1810));
  var_0 maps\_utility::sound_fade_in("scn_carr_jet_idle_lp", 1, 2.5, 1);
  common_scripts\utility::flag_wait("deck_combat_finished");
  var_0 maps\_utility::sound_fade_and_delete(8);
}

aud_deck_siren() {
  wait 1;

  for(var_0 = 0; var_0 < 12; var_0 = var_0 + 1) {
    thread common_scripts\utility::play_sound_in_space("scn_carr_deck_siren", (-441, 5315, 2391));
    wait 4;
  }
}

aud_play_jets_zoomby() {
  thread aud_deck_siren();
  var_0 = spawn("script_origin", (-4738, 5784, 2187));
  var_0 playSound("carr_jetby_01");
  var_0 moveto((5749, 2716, 2533), 2);
  wait 0.6;
  var_1 = spawn("script_origin", (-4799, 5024, 1762));
  var_1 playSound("carr_jetby_02");
  var_1 moveto((4824, 2030, 2649), 2);
}

aud_deck_jet_catapult_01() {
  var_0 = getent("anim_jet_launcher2", "targetname");
  var_1 = spawn("script_origin", var_0.origin);
  var_1 linkto(var_0);
  wait 4;
  var_1 playSound("elm_jet_catapult", "sounddone");
  var_1 waittill("sounddone");
  waittillframeend;
  var_1 delete();
}

aud_deck_jet_catapult_02() {
  var_0 = getent("anim_jet_launcher1", "targetname");
  var_1 = spawn("script_origin", var_0.origin);
  var_1 linkto(var_0);
  wait 7.5;
  var_1 playSound("elm_jet_catapult", "sounddone");
  var_1 waittill("sounddone");
  waittillframeend;
  var_1 delete();
}

aud_wave2_ambient_jets() {
  var_0 = getent("low_flyby_enemy", "targetname");
  var_1 = spawn("script_origin", var_0.origin);
  var_1 linkto(var_0);
  var_2 = getent("low_flyby_ally", "targetname");
  var_3 = spawn("script_origin", var_2.origin);
  var_3 linkto(var_2);
  wait 15;
  var_1 playSound("carr_jetby_01", "sounddone");
  var_3 playSound("carr_jetby_02", "sounddone");
  var_1 waittill("sounddone");
  waittillframeend;
  var_1 delete();
  var_3 waittill("sounddone");
  waittillframeend;
  var_3 delete();
}

aud_wave3_ambient_jets() {
  var_0 = getent("jet_dogfighter_enemy", "targetname");
  var_1 = spawn("script_origin", var_0.origin);
  var_1 linkto(var_0);
  var_2 = getent("jet_dogfighter_ally", "targetname");
  var_3 = spawn("script_origin", var_2.origin);
  var_3 linkto(var_2);
  var_1 playSound("carr_jetby_01", "sounddone");
  var_3 playSound("carr_jetby_02", "sounddone");
  var_1 waittill("sounddone");
  waittillframeend;
  var_1 delete();
  var_3 waittill("sounddone");
  waittillframeend;
  var_3 delete();
}

aud_carr_osprey_engines() {
  var_0 = getent("taxing_osprey_clip", "targetname");
  var_1 = spawn("script_origin", var_0.origin);
  var_1 linkto(var_0);
  var_2 = getent("taxing_osprey_clip", "targetname");
  var_3 = spawn("script_origin", var_2.origin);
  var_3 linkto(var_2);
  var_1 playSound("scn_carr_osprey_engines");
  wait 33;
  var_1 stopsounds();
  var_3 playLoopSound("scn_carr_osprey_liftoff");
  common_scripts\utility::flag_wait("aud_osprey_takeoff");
  var_3 unlink(var_2);
  var_3 moveto((176, 7154, 2016), 5);
  wait 1;
  var_3 maps\_utility::sound_fade_and_delete(8);
  var_1 delete();
}

aud_carr_elevator_front() {
  var_0 = spawn("script_origin", level.front_elevator.origin);
  var_0 linkto(level.front_elevator);
  var_0 playSound("amb_carr_deck_elevator_start");
  wait 0.08;
  var_0 playLoopSound("amb_carr_deck_elevator_loop");
  common_scripts\utility::flag_wait("elevator_up_ding_ding");
  var_0 playSound("amb_carr_deck_elevator_stop");
  wait 0.08;
  var_0 stoploopsound("amb_carr_deck_elevator_loop");
  wait 2;
  var_0 delete();
}

aud_carr_osprey_doors() {
  wait 15.63;
  thread common_scripts\utility::play_sound_in_space("scn_osprey_doors", (368, 6547, 1451));
  wait 18.02;
  thread common_scripts\utility::play_sound_in_space("scn_osprey_doors", (368, 6547, 1451));
}

aud_carr_osprey_loader(var_0) {
  wait 0.75;
  var_1 = spawn("script_origin", var_0.origin);
  var_1 linkto(var_0);
  var_1 playSound("scn_osprey_loader", "sounddone");
  var_1 waittill("sounddone");
  waittillframeend;
  var_1 delete();
}

aud_jet_attack() {
  thread jet_attack_1();
  thread jet_attack_2();
}

jet_attack_1() {
  wait 2.8;
  var_0 = spawn("script_origin", (-881, 15679, 3129));
  var_0 playSound("carr_jetby_med_01", "sounddone");
  var_0 moveto((1681, -14348, 4036), 7.5);
  var_0 waittill("sounddone");
  waittillframeend;
  var_0 delete();
}

jet_attack_2() {
  wait 3.4;
  var_0 = spawn("script_origin", (-1246, 19016, 3266));
  var_0 playSound("carr_jetby_med_02", "sounddone");
  var_0 moveto((1999, -8523, 3147), 6);
  var_0 waittill("sounddone");
  waittillframeend;
  var_0 delete();
}

jet_attack_3() {
  wait 2.8;
  var_0 = spawn("script_origin", (-9220, 13672, 4443));
  var_0 playSound("carr_jetby_med_02", "sounddone");
  var_0 moveto((11512, -2897, 3500), 6);
  var_0 waittill("sounddone");
  waittillframeend;
  var_0 delete();
}

aud_fast_jets() {}

aud_carr_hesh_talk_explode() {
  wait 1.5;
  thread common_scripts\utility::play_sound_in_space("amb_carr_incoming", (-103, 7854, 1977));
  wait 2;
  thread common_scripts\utility::play_sound_in_space("scn_carr_deck_105mm", (-271, 7536, 1500));
}

aud_carr_pickup_osprey_control() {
  level.player playSound("scn_carr_osprey_control_pickup");
}

aud_carr_zodiac_deck_explode() {
  wait 0.5;
  thread common_scripts\utility::play_sound_in_space("amb_carr_incoming", (1366, 4346, 1598));
  wait 2;
  thread common_scripts\utility::play_sound_in_space("scn_carr_deck_105mm", (1360, 4349, 1553));
}

aud_carr_zodiac_deck_explode_vista() {
  thread common_scripts\utility::play_sound_in_space("scn_carr_deck_explode_vista", (1512, 2379, 1536));
}

aud_carr_player_cuts_rope() {
  level.player playSound("scn_carr_rope_cut");
}

aud_carr_elevator_rear() {
  var_0 = spawn("script_origin", level.rear_elevator.origin);
  var_0 linkto(level.rear_elevator);
  var_0 playSound("amb_carr_deck_elevator_start");
  wait 0.08;
  var_0 playLoopSound("amb_carr_deck_elevator_loop");
  common_scripts\utility::flag_wait("rear_elevator_raised");
  var_0 playSound("amb_carr_deck_elevator_stop");
  wait 0.08;
  var_0 stoploopsound("amb_carr_deck_elevator_loop");
  wait 2;
  var_0 delete();
}

aud_carr_osprey_zone_on() {
  level.player setclienttriggeraudiozone("carr_osprey_int", 0.1);
  level.player playSound("scn_carr_into_osprey_ops");
}

aud_carr_osprey_zone_off() {
  level.aud_osprey_run = level.aud_osprey_run + 1.0;
  thread aud_defend_zodiac_osprey_zone();
}

aud_osprey_fire() {
  thread common_scripts\utility::play_sound_in_space("scn_carr_osprey_fire_lr", level.player.origin);
}

aud_osprey_mgun_fire() {
  thread common_scripts\utility::play_sound_in_space("scn_carr_osprey_fire_lr", level.player.origin);
}

aud_osprey_controller_on() {
  level.player playSound("scn_carr_osprey_on");
}

aud_osprey_controller_off() {
  level.player playSound("scn_carr_osprey_off");
}

aud_zodiac_jet_catapult_01() {
  var_0 = getent("anim_jet_launcher2", "targetname");
  var_1 = spawn("script_origin", var_0.origin);
  var_1 linkto(var_0);
  wait 17;
  var_1 playSound("elm_jet_catapult_zodiac", "sounddone");
  var_1 waittill("sounddone");
  wait 1;
  var_1 delete();
}

aud_zodiac_jet_catapult_02() {}

aud_zodiac_gunship_attack_barrels() {}

aud_carr_slowmo_slide() {
  level.player playSound("scn_carr_slowmo_slide");
}

aud_carr_slowmo_in() {
  level.player playSound("scn_carr_slowmo_in");
}

aud_carr_slowmo_bg() {
  level.aud_slowmo_bg playSound("scn_carr_slowmo_bg");
}

aud_carr_slowmo_out() {
  level.aud_slowmo_bg maps\_utility::sound_fade_and_delete(0.5);
  level.player playSound("scn_carr_slowmo_out");
  level.player setclienttriggeraudiozone("sparrow_run", 0.5);
}

aud_carr_slowmo_roll() {
  wait 0.5;
  level.player playSound("scn_carr_slowmo_roll");
}

aud_sparrow_tone() {
  var_0 = spawn("script_origin", (1007, 8055, 1199));
  var_0 playLoopSound("scn_carr_sparrow_ops_tone");
  level waittill("sparrow_tone_off");
  var_0 maps\_utility::sound_fade_and_delete(1);
}

aud_carr_dead_sparrow_ops() {
  thread common_scripts\utility::play_sound_in_space("scn_carr_dead_sparrow_ops", (1042, 8090, 1293));
  wait 3.25;
  level notify("sparrow_tone_off");
  wait 0.51;
  level.player playSound("scn_carr_into_sparrow_ops");
}

aud_carr_sparrow_zone_on() {
  level notify("circling_pattern_off");
  level.player setclienttriggeraudiozone("defend_sparrow", 0.2);
  level.aud_in_sparrow = 1;
}

aud_carr_sparrow_zone_off() {
  level.player setclienttriggeraudiozone("victory_deck", 3);
  wait 0.3;
  thread aud_player_jumps_from_sparrow();
  thread common_scripts\utility::play_sound_in_space("scn_carr_sparrow_death_exp", (1067, 8155, 1328));
  thread common_scripts\utility::play_sound_in_space("scn_carr_sparrow_death_debris", (1055, 8155, 1328));
  thread aud_victory_deck_spawn_fires();
  wait 1;
  var_0 = spawn("script_origin", (5084, 6906, 3832));
  var_0 playSound("scn_carr_gunship_death");
  var_0 moveto((-6829, 3888, 2126), 13);
  wait 15;
  var_0 delete();
}

aud_sparrow_aiming() {
  self endon("death");
  self endon("defend_sparrow_finished");
  wait 1;
  var_0 = level.player getplayerangles();

  while(!common_scripts\utility::flag("defend_sparrow_finished")) {
    var_1 = level.player getplayerangles();

    if(distance(var_0, var_1) > 0.001) {
      level.aud_sparrow_launcher_loop maps\_utility::sound_fade_in("scn_carr_sparrow_aim", 1, 0.06, 1);
    } else {
      level.aud_sparrow_launcher_loop stoploopsound();
    }

    var_0 = var_1;
    common_scripts\utility::waitframe();
  }
}

aud_carr_victory_deck_checkpoint() {
  level.player setclienttriggeraudiozone("victory_deck");
  thread common_scripts\utility::play_sound_in_space("scn_carr_sparrow_death_exp", (1067, 8155, 1328));
  thread common_scripts\utility::play_sound_in_space("scn_carr_sparrow_death_debris", (1055, 8155, 1328));
  wait 0.3;
  thread aud_player_jumps_from_sparrow();
  thread aud_victory_deck_spawn_fires();
  wait 1;
  var_0 = spawn("script_origin", (5084, 6906, 3832));
  var_0 playSound("scn_carr_gunship_death");
  var_0 moveto((-6829, 3888, 2126), 12);
  wait 15;
  var_0 delete();
}

aud_player_jumps_from_sparrow() {
  thread common_scripts\utility::play_sound_in_space("scn_carr_jump_from_sparrow", (1055, 8155, 1328));
}

aud_gunship_loc() {}

aud_carr_gunship_attack_run() {
  level.aud_gunship_loc2 = spawn("script_origin", level.ac_130.origin);
  level.aud_gunship_loc2 linkto(level.ac_130);
  level.aud_gunship_loc2 playSound("scn_carr_gunship_attack_run");
}

aud_gunship_circling_pattern() {
  wait 1;
  level.aud_gunship_loc = spawn("script_origin", level.ac_130.origin);
  level.aud_gunship_loc linkto(level.ac_130);
  level.aud_gunship_loc maps\_utility::sound_fade_in("scn_gunship_circling_pattern", 1, 0.5, 1);
  level waittill("circling_pattern_off");
  level.aud_gunship_loc maps\_utility::sound_fade_and_delete(7);
}

aud_carr_sparrow_run_hit() {
  thread common_scripts\utility::play_sound_in_space("scn_carr_sparrow_run_exp_head", (-631, 4604, 1504));
  thread common_scripts\utility::play_sound_in_space("scn_carr_sparrow_run_exp", (-550, 4604, 1504));
  thread aud_sparrow_run_spawn_fires();
  thread aud_sparrow_tone();
}

aud_carr_sparrow_105_incoming() {
  thread common_scripts\utility::play_sound_in_space("amb_carr_incoming", (1978, 8176, 1588));
}

aud_carr_sparrow_105_hit(var_0) {
  if(level.aud_in_sparrow == 1) {
    thread common_scripts\utility::play_sound_in_space("scn_carr_105_shell_exp_lr", (1707, 6915, 1721));
  } else {
    thread common_scripts\utility::play_sound_in_space("scn_carr_sparrow_exp", var_0);
  }
}

aud_carr_gunship_killed() {
  var_0 = spawn("script_origin", level.ac_130.origin);
  var_0 linkto(level.ac_130);
  var_0 playSound("scn_gunship_killed_01");
  wait 0.47;
  var_0 playSound("scn_gunship_killed_02");
  wait 0.73;
  var_0 playSound("scn_gunship_killed_03");
  wait 5;
  var_0 delete();
}

aud_sparrow_run_spawn_fires() {
  var_0 = spawn("script_origin", (906, 7790, 1123));
  var_0 playLoopSound("carr_smallfire");
  var_1 = spawn("script_origin", (1296, 8011, 1125));
  var_1 playLoopSound("carr_smallfire");
  var_2 = spawn("script_origin", (1267, 7409, 1072));
  var_2 playLoopSound("carr_medfire");
  var_3 = spawn("script_origin", (1361, 6888, 1443));
  var_3 playLoopSound("carr_medfire");
  var_4 = spawn("script_origin", (1010, 7304, 1259));
  var_4 playLoopSound("carr_bigfire");
  var_5 = spawn("script_origin", (1092, 7037, 1302));
  var_5 playLoopSound("carr_bigfire");
}

aud_victory_deck_spawn_fires() {
  var_0 = spawn("script_origin", (702, 7503, 1555));
  var_0 playLoopSound("carr_medfire");
  var_1 = spawn("script_origin", (497, 2599, 1555));
  var_1 playLoopSound("carr_bigfire");
}

aud_zodiac_gunship_attack_105_fake(var_0) {
  thread common_scripts\utility::play_sound_in_space("amb_carr_incoming", var_0.origin);
  wait(randomfloatrange(1, 2));
  thread common_scripts\utility::play_sound_in_space("scn_carr_sparrow_exp", var_0.origin);
}

aud_gunship_incoming_zodiac() {}

aud_gunship_trans_4_105_01() {
  var_0 = common_scripts\utility::getstruct("sparrow_trans_105_pre_01", "targetname");
  wait 2;
  thread common_scripts\utility::play_sound_in_space("scn_carr_deck_105mm", var_0.origin);
}

aud_gunship_trans_4_105_02() {
  var_0 = common_scripts\utility::getstruct("sparrow_trans_105_pre_02", "targetname");
  wait 2;
  thread common_scripts\utility::play_sound_in_space("scn_carr_deck_105mm", var_0.origin);
}

aud_carr_tilt_plr_death() {
  level.player playSound("carr_deck_slide_death_front");
}

aud_carr_tilt_plr_vault() {
  level.player playSound("carr_deck_vault");
}

tilt_odin_impact() {
  level.player setclienttriggeraudiozone("deck_tilt", 3);
  thread common_scripts\utility::play_sound_in_space("scn_carr_odin_incoming", (-1259, 6628, 2216));
  wait 1.5;
  thread common_scripts\utility::play_sound_in_space("scn_carr_odin_strike_a", (915, 5134, 1867));
  thread common_scripts\utility::play_sound_in_space("scn_carr_odin_strike_b", (930, 5714, 1991));
  maps\_utility::music_stop(1.2);
  wait 0.5;
  thread aud_play_tilt_music();
  thread aud_ship_listing();
  thread aud_tilt_debris_01();
  thread aud_tilt_barrels_01();
  thread aud_tilt_sliding_cart_01();
  wait 1.5;
}

aud_ship_listing() {
  wait 1.25;
  thread common_scripts\utility::play_sound_in_space("carr_shiplist_01", (1336, 5365, 1844));
}

aud_tilt_debris_01() {
  wait 3;
  thread common_scripts\utility::play_sound_in_space("carr_sliding_01", (348, 6575, 1482));
  thread common_scripts\utility::play_sound_in_space("carr_barrels_roll", (406, 6381, 1514));
  thread common_scripts\utility::play_sound_in_space("scn_tilt_misc_debris_01", (660, 6404, 1541));
}

aud_tilt_barrels_01() {
  wait 1;
  var_0 = spawn("script_origin", (-690, 7353, 1514));
  var_0 playSound("carr_barrels_roll");
  var_0 moveto((885, 7353, 1514), 4);
  wait 8;
  var_0 delete();
}

aud_tilt_sliding_cart_01() {
  wait 9;
  thread common_scripts\utility::play_sound_in_space("carr_metal_fall_01", (494, 5592, 1461));
}

aud_tilt_pitch_fx() {
  var_0 = spawn("script_origin", (-78, 1189, 1820));
  var_0 playSound("carr_flight_deck_pitch_fx_lo");
  common_scripts\utility::flag_wait("player_at_silenthawk");
  var_0 maps\_utility::sound_fade_and_delete(3);
}

aud_play_random_tilt_scream(var_0, var_1, var_2) {}

tilt_helicopter_destroyed(var_0) {}

aud_dish_crash() {
  thread aud_cart_crash();
  wait 4.9;
  thread common_scripts\utility::play_sound_in_space("carr_dish_impact", (256, 6606, 1460));
}

aud_cart_crash() {
  wait 3.75;
  thread common_scripts\utility::play_sound_in_space("carr_cart_impact", (731, 6937, 1460));
  wait 1.2;
}

aud_tower_collapse(var_0) {
  wait 3.72;
  thread common_scripts\utility::play_sound_in_space("scn_carr_tower_fall", (-612, 5606, 2182));
  thread aud_tower_to_deck();
  wait 11.06;
  thread common_scripts\utility::play_sound_in_space("scn_carr_tower_impact", (-29, 5143, 1646));
  wait 1.28;
  thread common_scripts\utility::play_sound_in_space("scn_carr_tower_impact_head", (269, 5228, 1581));
  wait 1.2;
  thread common_scripts\utility::play_sound_in_space("carr_barrels_roll", (-96, 4633, 1540));
  wait 1;
  thread common_scripts\utility::play_sound_in_space("scn_tilt_misc_debris_04", (69, 4633, 1540));
}

aud_tower_to_deck() {
  wait 10.95;
  thread common_scripts\utility::play_sound_in_space("carr_explosion_02", (-305, 5236, 1460));
}

aud_tilt_sliding_guya() {
  var_0 = spawn("script_origin", (-687, 4425, 1486));
  var_1 = (515, 4403, 1474);
  wait 8;
  var_0 moveto(var_1, 6);
  var_0 playSound("scn_sliding_guya_1");
  wait 1.5;
  var_0 playSound("scn_sliding_guya_2");
  wait 1.5;
  var_0 playSound("scn_sliding_guya_3");
  wait 1.5;
  var_0 playSound("scn_sliding_guya_4");
  wait 1.5;
  var_0 playSound("scn_sliding_guya_5");
  wait 3;
  var_0 delete();
}

aud_tilt_sliding_guyb() {
  var_0 = spawn("script_origin", (-371, 4390, 1495));
  var_1 = (332, 4437, 1500);
  wait 2;
  var_0 moveto(var_1, 4);
  var_0 playSound("scn_sliding_guyb_1");
  wait 1.5;
  var_0 playSound("scn_sliding_guyb_2");
  wait 1.5;
  var_0 playSound("scn_sliding_guyb_3");
  wait 3;
  var_0 delete();
}

aud_carr_deck_tilt_osprey() {
  var_0 = getent("tilt_osprey_clip", "targetname");
  var_1 = spawn("script_origin", var_0.origin);
  var_1 linkto(var_0);
  var_2 = getent("tilt_osprey_clip", "targetname");
  var_3 = spawn("script_origin", var_2.origin);
  var_3 linkto(var_2);
  wait 1.2;
  var_1 playSound("scn_carr_deck_tilt_osprey");
  var_3 playSound("carr_sliding_06");
}

aud_carr_exp_heli_exp() {
  thread common_scripts\utility::play_sound_in_space("scn_carr_exploding_heli_exp", (-1040, 2363, 1716));
  thread aud_tilt_pitch_fx();
  thread aud_tilt_front_deck();
  thread aud_carr_exp_heli_blade();
  thread aud_carr_exp_heli_bounce();
  thread aud_carr_exp_heli_whoosh();
}

aud_carr_exp_heli_blade() {
  var_0 = getent("e_heli_clip_rotor_blade", "targetname");
  var_1 = spawn("script_origin", var_0.origin);
  var_1 linkto(var_0);
  wait 0.6;
  var_1 playSound("scn_carr_exploding_heli_blades");
}

aud_carr_exp_heli_bounce() {
  var_0 = getent("e_heli_clip_body", "targetname");
  var_1 = spawn("script_origin", var_0.origin);
  var_1 linkto(var_0);
  wait 1.88;
  var_1 playSound("scn_carr_exploding_heli_bounce");
}

aud_carr_exp_heli_whoosh() {
  var_0 = getent("e_heli_clip_body", "targetname");
  var_1 = spawn("script_origin", var_0.origin);
  var_1 linkto(var_0);
  wait 3.05;
  var_1 playSound("scn_carr_exploding_heli_whoosh");
}

aud_carr_bg_rog_01() {
  var_0 = getent("deck_tilt_bg_rog_01", "targetname");
  var_1 = spawn("script_origin", var_0.origin);
  var_1 linkto(var_0);
  var_1 playSound("scn_carr_rog_bg");
  wait 6;
  waittillframeend;
  var_1 delete();
}

aud_carr_bg_rog_02() {
  var_0 = getent("deck_tilt_bg_rog_02", "targetname");
  var_1 = spawn("script_origin", var_0.origin);
  var_1 linkto(var_0);
  var_1 playSound("scn_carr_rog_bg");
  wait 6;
  waittillframeend;
  var_1 delete();
}

aud_carr_bg_rog_03() {
  var_0 = getent("deck_tilt_bg_rog_03", "targetname");
  var_1 = spawn("script_origin", var_0.origin);
  var_1 linkto(var_0);
  var_1 playSound("scn_carr_rog_bg");
  wait 6;
  waittillframeend;
  var_1 delete();
}

aud_carr_elevator_exp() {
  thread common_scripts\utility::play_sound_in_space("scn_carr_elevator_exp", (-1203, 1537, 1755));
  wait 2;
  thread common_scripts\utility::play_sound_in_space("carr_deck_rumble", (-756, 2234, 1492));
  wait 1.5;
  thread common_scripts\utility::play_sound_in_space("scn_front_deck_destruct_04", (-228, 2523, 1441));
}

aud_tilt_front_deck() {
  wait 5;
  thread common_scripts\utility::play_sound_in_space("carr_explosion_01", (-804, 3212, 1594));
  wait 3;
  thread common_scripts\utility::play_sound_in_space("scn_front_deck_destruct_01", (-263, 684, 1777));
  wait 3;
  thread common_scripts\utility::play_sound_in_space("scn_front_deck_destruct_02", (-1095, 3104, 1460));
  thread common_scripts\utility::play_sound_in_space("carr_metal_fall_05", (-685, 2338, 1460));
  wait 3;
  thread common_scripts\utility::play_sound_in_space("scn_front_deck_destruct_03", (153, 2882, 1609));
}

aud_carr_exfil_heli(var_0) {
  var_0 vehicle_turnengineoff();
  var_1 = spawn("script_origin", var_0.origin);
  var_1 linkto(var_0);
  var_2 = spawn("script_origin", var_0.origin);
  var_2 linkto(var_0);
  var_1 playLoopSound("carr_exfil_heli_drone");
  common_scripts\utility::flag_wait_all("player_can_exfil", "player_at_silenthawk");
  level.player playSound("scn_carr_plr_into_exfil");
  thread aud_carr_exfil_rog_incoming();
  var_1 maps\_utility::sound_fade_and_delete(5);
  var_2 playSound("carr_exfil_heli_interior_amb");
}

aud_carr_exfil_rog_incoming() {
  wait 2;
  thread common_scripts\utility::play_sound_in_space("scn_carr_exfil_rog_incoming", (-1113, 11, 1774));
}

aud_carr_exfil_rog() {
  thread common_scripts\utility::play_sound_in_space("scn_carr_exfil_2nd_rog", (-1113, 11, 1774));
}

aud_carr_exfil_bg_heli(var_0) {
  var_0 vehicle_turnengineoff();
  var_1 = spawn("script_origin", var_0.origin);
  var_1 linkto(var_0);
  wait 2.78;
  var_1 playSound("scn_carr_exfil_bg_heli");
}

aud_ocean01_line_emitter_create() {
  var_0 = [];
  var_0[0] = spawn("script_origin", (1976, 9908, 1688));
  var_0[1] = spawn("script_origin", (2487, -3588, 352));
  ocean_line_emitter_logic(var_0, "emt_carrier_ocean_lp", "rog_impacts_deck");
}

aud_ocean02_line_emitter_create() {
  var_0 = [];
  var_0[0] = spawn("script_origin", (-2272, 8924, 1688));
  var_0[1] = spawn("script_origin", (-1995, -3337, 1688));
  ocean_line_emitter_logic(var_0, "emt_carrier_ocean_lp", "rog_impacts_deck");
}

aud_play_loop_until_flag(var_0, var_1, var_2) {
  var_3 = spawn("script_origin", var_1);
  var_3 playLoopSound(var_0);
  common_scripts\utility::flag_wait(var_2);
  var_3 scalevolume(0, 1);
  wait 1;
  var_3 stoploopsound();
  common_scripts\utility::waitframe();
  var_3 delete();
}

ocean_line_emitter_logic(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    self endon(var_2);
  }

  var_3 = spawn("script_origin", (0, 0, 0));
  var_4 = undefined;
  var_5 = undefined;
  var_6 = 0;

  for(;;) {
    var_7 = 0;
    var_8 = common_scripts\utility::get_array_of_closest(level.player.origin, var_0, undefined, 2);

    foreach(var_10 in var_8) {
      if(var_7 == 0) {
        var_7 = 1;
        var_4 = var_10;
        continue;
      }

      var_5 = var_10;
    }

    var_12 = pointonsegmentnearesttopoint(var_4.origin, var_5.origin, level.player.origin);
    var_3 moveto(var_12, 0.01);

    if(var_6 == 0) {
      var_3 playLoopSound(var_1);
      var_6 = 1;
    }

    wait 0.1;
  }
}
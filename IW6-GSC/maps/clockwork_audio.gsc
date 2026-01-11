/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\clockwork_audio.gsc
*****************************************************/

main() {
  thread aud_init_flags();
  thread aud_init_globals();
  thread time_synchronizer();
  thread aud_init_animation_sounds();
  thread aud_gear_sounds();
  setdvarifuninitialized("cg_foliagesnd_alias", "clkw_foot_foliage_player");
}

aud_init_flags() {
  common_scripts\utility::flag_init("aud_woods_oneshots");
  common_scripts\utility::flag_init("aud_ambush_done");
  common_scripts\utility::flag_init("aud_lights_out_music_started");
  common_scripts\utility::flag_init("aud_stop_music_during_thermite");
  common_scripts\utility::flag_init("aud_alarms_on");
  common_scripts\utility::flag_init("aud_alarms_off");
  common_scripts\utility::flag_init("aud_stop_interior_combat_pa");
  common_scripts\utility::flag_init("aud_stop_vault_water");
  common_scripts\utility::flag_init("aud_stop_fan_sound");
  common_scripts\utility::flag_init("aud_defend_started");
  common_scripts\utility::flag_init("aud_defend_combat_started");
  common_scripts\utility::flag_init("aud_tick");
  common_scripts\utility::flag_init("aud_fade_out");
  common_scripts\utility::flag_init("aud_pre_lookout");
  common_scripts\utility::flag_init("aud_chase_interior");
  common_scripts\utility::flag_init("aud_baker_getin");
  common_scripts\utility::flag_init("aud_cypher_getin");
  common_scripts\utility::flag_init("aud_keegan_getin");
  common_scripts\utility::flag_init("aud_kill_idle");
  common_scripts\utility::flag_init("chase_punch_it");
  common_scripts\utility::flag_init("chase_garage_pre_exit_skid");
  common_scripts\utility::flag_init("chase_garage_exit");
  common_scripts\utility::flag_init("chase_crossroad");
  common_scripts\utility::flag_init("chase_enter_ravine");
  common_scripts\utility::flag_init("chase_enter_tunnel");
  common_scripts\utility::flag_init("chase_exit_tunnel");
  common_scripts\utility::flag_init("chase_under_bridge_1");
  common_scripts\utility::flag_init("chase_sharp_turn");
  common_scripts\utility::flag_init("chase_under_bridge_2");
  common_scripts\utility::flag_init("chase_under_bridge_3");
  common_scripts\utility::flag_init("chase_enter_chasm");
  common_scripts\utility::flag_init("chase_tight_spot");
  common_scripts\utility::flag_init("chase_under_bridge_4");
  common_scripts\utility::flag_init("chase_sub_comes_up");
  common_scripts\utility::flag_init("aud_land_roof_playing");
  common_scripts\utility::flag_init("aud_land_pileup_playing");
  common_scripts\utility::flag_init("aud_pileup_playing");
  common_scripts\utility::flag_init("aud_land_tires_big_playing");
  common_scripts\utility::flag_init("aud_land_tires_small_playing");
  common_scripts\utility::flag_init("aud_collision_playing");
  common_scripts\utility::flag_init("aud_leftground_playing");
  common_scripts\utility::flag_init("aud_start_pileup");
}

aud_init_globals() {
  level.bdriverkilled = 0;
  level.bdoorbreakfoleyplayed = 0;
  level.aud_last_time = 0;
  level.bdrillon = 0;
  level.aud_charge_set = 0;
  level.bsnowmobilesstarted = 0;
  level.pileupcounter = 0;
  level.bcrashmix = 0;
  level.crashtimer = 0;
  level.pileupsequence = 1;
  level.aud_drillholenumber = 0;
  level.area1_ents = [];
  level.bcqb_pa_playing = 0;
  level.bdefenddoorexplosionplaying = 0;
}

aud_init_animation_sounds() {
  wait 0.1;
  anim.notetracks["frnt_l_open"] = ::ambush_jeep_latch_open_lf;
  anim.notetracks["frnt_l_close"] = ::ambush_jeep_latch_close_lf;
  anim.notetracks["frnt_r_open"] = ::ambush_jeep_latch_open_rf;
  anim.notetracks["frnt_r_close"] = ::ambush_jeep_latch_close_rf;
  anim.notetracks["rear_r_open"] = ::ambush_jeep_latch_open_rr;
  anim.notetracks["rear_r_close"] = ::ambush_jeep_latch_close_rr;
  anim.notetracks["drill_get"] = ::vault_keegan_drill_get;
  anim.notetracks["drill_set"] = ::vault_keegan_drill_set;
  anim.notetracks["charge_set"] = ::vault_keegan_charge_set;
}

aud_gear_sounds() {
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0) {
    var_2 setclothtype("cloth type");
  }
}

checkpoint_start_ambush() {
  wait 0.05;
  thread pre_ambush();
}

checkpoint_interior() {
  wait 0.05;
  thread security_amb();
}

checkpoint_interior_vault_scene() {
  wait 0.05;
  thread hacking_music();
}

checkpoint_interior_combat() {
  wait 0.05;
  level.player playSound("clkw_scn_power_up");
  thread vault_water();
  thread pa_announcements_interior_combat();
  thread alarms_1();
  thread door_debris_l();
  thread door_debris_r();
}

checkpoint_interior_cqb() {
  wait 0.05;
  thread vault_water();
  thread alarms_1();
}

checkpoint_defend() {
  wait 0.05;
  thread alarms_2();
}

checkpoint_chaos() {}

checkpoint_exfil() {
  wait 0.05;
  thread alarms_3();
  thread exfil_keegan_and_cypher_enter_jeep();
  thread exfil_baker_enter_jeep();
  wait 3;
  thread pa_announcements_chaos();
}

checkpoint_tank() {
  wait 0.05;
  thread chase_music();
  common_scripts\utility::flag_set("aud_start_pileup");
  thread chase_amb_enter_tunnel();
  thread chase_amb_exit_tunnel();
  thread chase_amb_under_bridge_1();
  thread chase_amb_sharp_turn();
  thread chase_amb_under_bridge_2();
  thread chase_amb_under_bridge_3();
  thread chase_amb_enter_chasm();
  thread chase_amb_tight_spot();
  thread chase_amb_under_bridge_4();
  thread chase_amb_sub_comes_up();
}

checkpoint_bridge() {
  wait 0.05;
  thread chase_music();
  common_scripts\utility::flag_set("aud_start_pileup");
  thread chase_amb_under_bridge_1();
  thread chase_amb_sharp_turn();
  thread chase_amb_under_bridge_2();
  thread chase_amb_under_bridge_3();
  thread chase_amb_enter_chasm();
  thread chase_amb_tight_spot();
  thread chase_amb_under_bridge_4();
  thread chase_amb_sub_comes_up();
}

checkpoint_cave() {
  wait 0.05;
  thread chase_music();
  common_scripts\utility::flag_set("aud_start_pileup");
  thread chase_amb_under_bridge_2();
  thread chase_amb_under_bridge_3();
  thread chase_amb_enter_chasm();
  thread chase_amb_tight_spot();
  thread chase_amb_under_bridge_4();
  thread chase_amb_sub_comes_up();
}

time_synchronizer() {
  for(;;) {
    var_0 = gettime();

    if(var_0 - level.aud_last_time > 950) {
      common_scripts\utility::flag_set("aud_tick");
      level.aud_last_time = var_0;
    }

    wait 0.05;
    common_scripts\utility::flag_clear("aud_tick");
  }
}

intro_black() {
  thread intro_gear();
  thread intro_gusts1();
  thread intro_mask();
  thread woods_oneshots();
}

intro_gear() {
  wait 3;
  common_scripts\utility::play_sound_in_space("clkw_scn_intro_gear", (-31930, 9037, 3527));
}

intro_gusts1() {
  wait 1.2;
  level.player playSound("clkw_amb_intro_gusts_lr");
}

intro_watch() {
  level.player playSound("clkw_scn_intro_whoosh");
  wait 2;
  level.player playSound("clkw_scn_clock_tick");
}

intro_mask() {
  wait 5.8;
  level.player playSound("clkw_scn_intro_mask");
}

intro_headlamp_smash() {
  common_scripts\utility::play_sound_in_space("clkw_scn_intro_smash_headlamp", (-31819, 8972, 3514));
}

woods_oneshots() {
  common_scripts\utility::flag_wait("aud_woods_oneshots");
  wait 1.5;
  thread common_scripts\utility::play_sound_in_space("clkw_distant_wolf", (-34996, 10916, 4220));
}

jeeps_by() {
  thread jeep1_by();
  wait 0.75;
  thread jeep2_by();
}

jeep1_by() {
  var_0 = spawn("script_origin", (-33425, 10931, 3586));
  var_1 = (-34456, 8972, 3586);
  var_2 = (-35421, 8299, 3586);
  var_3 = (-37562, 9396, 3586);
  var_0 playSound("clkw_scn_jeep1_by", "sounddone");
  var_0 moveto(var_1, 5);
  wait 5;
  var_0 moveto(var_2, 3.0);
  wait 3;
  var_0 moveto(var_3, 4.0);
  var_0 waittill("sounddone");
  var_0 delete();
}

jeep2_by() {
  var_0 = spawn("script_origin", (-33753, 10221, 3586));
  var_1 = (-34456, 8972, 3586);
  var_2 = (-35421, 8299, 3586);
  var_3 = (-37562, 9396, 3586);
  var_0 playSound("clkw_scn_jeep2_by", "sounddone");
  var_0 moveto(var_1, 5.5);
  wait 5.5;
  var_0 moveto(var_2, 3.0);
  wait 3;
  var_0 moveto(var_3, 4.0);
  var_0 waittill("sounddone");
  var_0 delete();
}

pre_ambush() {}

player_drag_body() {
  wait 0.5;
  level.player playSound("clkw_scn_player_drag_body");
}

foley_pre_ambush() {
  thread keegan_drag_body();
  wait 2;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_bag_throw", (-37668, 9088, 3563));
  wait 0.5;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_bag_catch", (-37719, 9139, 3551));
  wait 12.7;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_bag_drop", (-38361, 9684, 3501));
  wait 2.4;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_bag_drop", (-38331, 9708, 3501));
}

foley_post_ambush() {
  wait 7.1;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_bag_drop", (-38240, 9596, 3545));
  wait 2.3;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_bag_drop", (-38240, 9596, 3545));
  wait 2;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_bag_throw", (-38392, 9594, 3551));
  wait 0.5;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_bag_catch", (-38330, 9620, 3547));
  wait 1.5;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_bag_drop", (-38240, 9596, 3545));
}

keegan_drag_body() {
  wait 4;
  var_0 = spawn("script_origin", (-37686, 9058, 3509));
  var_1 = (-37737, 8948, 3509);
  var_0 playSound("clkw_scn_keegan_drag_body", "sounddone");
  wait 0.5;
  var_0 moveto(var_1, 2.5);
  wait 2.5;
  var_0 waittill("sounddone");
  var_0 delete();
}

baker_drag_body1() {
  thread baker_drop_bag();
  wait 3.5;
  var_0 = spawn("script_origin", (-38301, 9460, 3509));
  var_1 = (-38505, 9633, 3509);
  var_2 = (-38557, 9576, 3509);
  var_0 playSound("clkw_scn_baker_drag_body", "sounddone");
  wait 2.5;
  var_0 moveto(var_1, 5);
  wait 5;
  var_0 moveto(var_2, 1.5);
  var_0 waittill("sounddone");
  var_0 delete();
}

baker_drop_bag() {
  wait 15.7;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_bag_catch", (-38498, 9597, 3508));
}

vehicles_approaching() {
  thread jeep_and_btr_appear();
  wait 9;
  level.jeep playSound("clkw_scn_ambush_jeep_stop");
}

jeep_and_btr_appear() {
  var_0 = spawn("script_origin", (-38361, 12435, 3868));
  var_1 = (-38682, 10678, 3696);
  var_2 = (-36290, 8662, 3568);
  var_0 playSound("clkw_scn_ambush_approach", "sounddone");
  wait 7;
  var_0 moveto(var_1, 5);
  wait 6;
  var_0 moveto(var_2, 8);
  var_0 waittill("sounddone");
  var_0 delete();
}

ambush_kill_driver_player() {
  wait 0.3;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_ambush_driver_kill", (-38247, 9521, 3548));
  thread horn();
  wait 0.4;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_ambush_pass1_pull", (-38331, 9591, 3537));
  wait 2.5;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_ambush_driver_pull_player", (-38212, 9518, 3548));
  wait 3;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_ambush_driver_drop", (-38200, 9423, 3545));
  wait 1.7;
  thread dash_wipe();
}

horn() {
  wait 1.3;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_ambush_driver_kill_horn", (-38302, 9484, 3548));
}

dash_wipe() {
  if(level.bdriverkilled == 0) {
    level.bdriverkilled = 1;
    thread common_scripts\utility::play_sound_in_space("clkw_scn_ambush_dash_wipe", (-38261, 9515, 3548));
  }
}

ambush_jeep_latch_open_lf(var_0, var_1) {
  thread common_scripts\utility::play_sound_in_space("clkw_scn_ambush_latch_open", (-38243, 9509, 3542));
}

ambush_jeep_latch_close_lf(var_0, var_1) {
  thread common_scripts\utility::play_sound_in_space("clkw_scn_ambush_latch_close", (-38243, 9509, 3542));
}

ambush_jeep_latch_open_rf(var_0, var_1) {
  thread common_scripts\utility::play_sound_in_space("clkw_scn_ambush_latch_open", (-38303, 9552, 3542));
}

ambush_jeep_latch_close_rf(var_0, var_1) {
  thread common_scripts\utility::play_sound_in_space("clkw_scn_ambush_latch_close", (-38303, 9552, 3542));
}

ambush_jeep_latch_open_rr(var_0, var_1) {
  thread common_scripts\utility::play_sound_in_space("clkw_scn_ambush_latch_open", (-38288, 9579, 3542));
}

ambush_jeep_latch_close_rr(var_0, var_1) {
  thread common_scripts\utility::play_sound_in_space("clkw_scn_ambush_latch_close", (-38288, 9579, 3542));
}

ambush_kill_driver_cypher() {
  wait 0.5;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_ambush_pass1_pull", (-38331, 9591, 3537));
  wait 1.3;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_ambush_driver_pull", (-38212, 9518, 3548));
  wait 2.5;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_ambush_driver_drop", (-38200, 9423, 3545));
  wait 1.5;
  thread keegan_drag_body2();
  wait 3.5;
  thread dash_wipe();
}

keegan_drag_body2() {
  var_0 = spawn("script_origin", (-38363, 9575, 3522));
  var_1 = (-38533, 9643, 3522);
  var_0 playSound("clkw_scn_keegan_drag_body", "sounddone");
  wait 0.5;
  var_0 moveto(var_1, 2.5);
  wait 2.5;
  var_0 waittill("sounddone");
  var_0 delete();
}

enter_jeep() {
  level.player playSound("clkw_scn_enter_jeep");
  wait 2;
  common_scripts\utility::flag_set("aud_ambush_done");
}

vehicle_player_01() {
  level.player playSound("clkw_vehicle_player_01");
  thread jeep_start_music();
  wait 20;
  wait 7.5;
  thread btr_by_mountainside();
  wait 14.5;
  thread security_amb();
}

jeep_start_music() {
  maps\_utility::music_play("mus_clock_driver_stab");
}

btr_by_mountainside() {
  var_0 = spawn("script_origin", (-32286, 3039, 2252));
  var_1 = (-32979, 2986, 2344);
  var_0 playSound("clkw_scn_interior_btr_by", "sounddone");
  var_0 moveto(var_1, 2);
  var_0 waittill("sounddone");
  var_0 delete();
}

exit_jeep() {
  level.player playSound("clkw_scn_interior_jeep_exit");
  thread garage_misc();
}

garage_misc() {
  wait 3.5;
  thread jeep_exit_bags();
}

jeep_exit_bags() {
  var_0 = spawn("script_origin", (-29197, 2934, 2064));
  var_1 = (-29246, 2938, 2064);
  var_0 playSound("clkw_scn_pickup_bags");
  wait 1;
  var_0 moveto(var_1, 0.5);
  wait 1;
  var_0 playSound("clkw_scn_bag_drop");
  wait 0.5;
  var_0 playSound("clkw_scn_bag_drop", "sounddone");
  var_0 waittill("sounddone");
  var_0 delete();
}

timer_tick() {
  var_0 = spawn("script_origin", (0, 0, 0));
  common_scripts\utility::flag_wait("aud_tick");

  while(!common_scripts\utility::flag("lights_out")) {
    wait 0.4;
    var_0 playSound("clkw_scn_clock_tick", "sounddone");
    var_0 waittill("sounddone");
    common_scripts\utility::flag_wait("aud_tick");
  }

  var_0 delete();
}

entry_door_close() {
  wait 6.5;
  thread entry_door_beeper();
  thread entry_door_close_layer2();
  var_0 = spawn("script_origin", (-28749, 2619, 2120));
  var_0 playSound("clkw_scn_entry_door_close");
  wait 22.25;
  thread entry_door_stop();
  thread team_foley_lights_out();
}

entry_door_close_layer2() {
  var_0 = spawn("script_origin", (-28605, 2602, 2129));
  var_1 = (-28735, 2746, 2129);
  var_2 = (-28891, 2608, 2129);
  var_0 playSound("clkw_scn_entry_door_close_layer2", "sounddone");
  var_0 moveto(var_1, 8.5);
  wait 8.5;
  var_0 moveto(var_2, 8.5);
  var_0 waittill("sounddone");
  var_0 delete();
}

security_amb() {
  wait 11;
  thread security_vo();
}

security_vo() {
  common_scripts\utility::play_sound_in_space("clockwork_fs_pictureid", (-28147, 2003, 2117));
  wait 2.2;
  common_scripts\utility::play_sound_in_space("clockwork_fs_wait", (-28147, 2003, 2117));
}

team_foley_lights_out() {
  thread common_scripts\utility::play_sound_in_space("clkw_keegan_ready_lights_out", (-28545, 2083, 2060));
  thread common_scripts\utility::play_sound_in_space("clkw_cypher_ready_lights_out", (-28643, 1938, 2060));
  thread common_scripts\utility::play_sound_in_space("clkw_baker_ready_lights_out", (-28590, 1931, 2060));
}

pre_thermite_amb() {
  level.player playSound("clkw_scn_power_down_lyr2");
}

security_beeps() {
  wait 6.5;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_security_beep", (-28361, 1978, 2152));
  wait 9;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_security_beep", (-28361, 1978, 2152));
  wait 4.5;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_security_beep", (-28361, 2025, 2152));
  wait 6.5;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_security_gun_tray", (-28462, 1931, 2033));
}

entry_door_beeper() {
  wait 1.5;
  var_0 = spawn("script_origin", (-28751, 2619, 2111));
  var_0 playLoopSound("clkw_scn_entry_door_beeper");
  wait 0.05;
  common_scripts\utility::flag_wait("aud_lights_out_music_started");
  wait 7;
  var_0 scalevolume(0, 0.5);
  wait 0.6;
  var_0 delete();
}

entry_door_stop() {
  thread common_scripts\utility::play_sound_in_space("clkw_scn_entry_door_stop", (-28959, 2595, 2098));
  thread common_scripts\utility::play_sound_in_space("clkw_scn_entry_door_stop_layer2", (-28748, 2595, 2098));
}

lights_out_music() {
  wait 1.5;
  common_scripts\utility::flag_set("aud_lights_out_music_started");
  common_scripts\utility::flag_wait("lights_out");
  maps\_utility::music_stop(0.5);
}

power_down() {
  level.player playSound("clkw_scn_power_down");
  wait 2;
  thread pre_thermite_amb();
}

hacking() {
  wait 1;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_hacking", (-26144, 1965, 2125));
  wait 14.7;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_hacking_complete", (-26144, 1965, 2125));
  wait 5;
}

hacking_music() {
  maps\_utility::music_play("mus_clock_computer_hack");
}

glowstick_hacking() {
  wait 1.8;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_door_stick_break", (-26189, 1933, 2166));
  wait 12;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_door_stick_drop_01", (-26178, 1969, 2070));
}

glowsticks(var_0) {
  wait 1;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_door_stick_drop_01", (-26882, 670, 1938));
  wait 0.1;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_door_stick_drop_02", (-26860, 772, 1938));
}

vault_foley() {
  wait 2;
  thread door_break_foley();
  thread vault_bag_drops();
}

door_break_foley() {
  var_0 = spawn("script_origin", (-26724, 752, 1995));
  var_1 = (-26888, 752, 1995);
  var_0 playSound("clkw_scn_door_break_foley_01", "sounddone");
  var_0 moveto(var_1, 1.5);
  wait 1.5;
  var_0 waittill("sounddone");
  var_0 delete();
}

vault_bag_drops() {
  wait 2.5;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_bag_drop", (-26885, 689, 1944));
  wait 0.7;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_bag_drop", (-26858, 849, 1944));
}

drill_pullout() {
  level.player playSound("clkw_scn_vault_drill_pullout");
}

drill_monitor() {
  if(level.aud_drillholenumber == 0) {
    thread common_scripts\utility::play_sound_in_space("clkw_scn_vault_drill_monitor", (-26896, 773, 2007));
    level.aud_drillholenumber = 1;
  } else {
    wait 2.8;
    thread common_scripts\utility::play_sound_in_space("clkw_scn_vault_drill_monitor", (-26896, 706, 2000));
  }
}

vault_keegan_drill_get(var_0, var_1) {
  thread common_scripts\utility::play_sound_in_space("clkw_scn_vault_keegan_bag_foley", (-26880, 845, 1945));
}

vault_keegan_drill_set(var_0, var_1) {
  thread common_scripts\utility::play_sound_in_space("clkw_scn_vault_keegan_drill_place", (-26887, 790, 1943));
}

vault_keegan_charge_set(var_0, var_1) {
  if(level.aud_charge_set == 0) {
    wait 0.2;
    thread common_scripts\utility::play_sound_in_space("clkw_scn_door_expl_attach", (-26900, 779, 1993));
    level.aud_charge_set = 1;
  } else {
    wait 0.1;
    thread common_scripts\utility::play_sound_in_space("clkw_scn_door_expl_attach", (-26896, 715, 1993));
  }
}

chalk_swipe1() {
  thread common_scripts\utility::play_sound_in_space("clkw_scn_vault_drill_chalk_swipe", (-26896, 773, 2007));
}

chalk_swipe2() {
  thread common_scripts\utility::play_sound_in_space("clkw_scn_vault_drill_chalk_swipe", (-26896, 706, 2000));
}

drill_plant() {
  wait 0.25;
  level.player playSound("clkw_scn_vault_drill_plant");
}

thermite() {
  common_scripts\utility::flag_wait("glow_start");
  thread thermite_start();
  thread common_scripts\utility::play_sound_in_space("clkw_scn_thermite", (-26903, 9967, 2011));
  thread common_scripts\utility::play_sound_in_space("clkw_scn_thermite", (-26903, 751, 2011));
  common_scripts\utility::flag_set("aud_stop_music_during_thermite");
  common_scripts\utility::flag_wait("explosion_start");
  thread door_explosion();
}

thermite_start() {
  common_scripts\utility::flag_wait("thermite_start");
  thread common_scripts\utility::play_sound_in_space("clkw_scn_thermite_start", (-26922, 741, 1995));
}

blowit_beep() {
  wait 1;
  thread common_scripts\utility::play_sound_in_space("clkw_mine_beep", (-26871, 754, 1995));
  wait 0.1;
  thread common_scripts\utility::play_sound_in_space("clkw_mine_beep", (-26871, 754, 1995));
  wait 0.1;
  thread common_scripts\utility::play_sound_in_space("clkw_mine_beep", (-26871, 754, 1995));
}

door_explosion() {
  thread common_scripts\utility::play_sound_in_space("clkw_scn_door_expl_source", (-26896, 744, 1995));
  level.player playSound("clkw_scn_door_expl_debris");
  thread power_up();
  thread flying_debris();
  thread door_debris_l();
  thread door_debris_r();
  wait 0.3;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_door_glass_break_01", (-27089, 805, 1997));
  thread common_scripts\utility::play_sound_in_space("clkw_scn_door_glass_break_02", (-27089, 697, 1997));
  wait 1;
  thread common_scripts\utility::play_sound_in_space("clkw_door_explosion_lights", (-26840, 758, 2060));
  thread vault_water();
  wait 1;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_door_glass_fragments", (-27089, 750, 1997));
}

flying_debris() {
  wait 0.3;
  thread common_scripts\utility::play_sound_in_space("clkw_expl_metal_debris", (-26165, 727, 1995));
  wait 0.1;
  thread common_scripts\utility::play_sound_in_space("clkw_expl_metal_debris", (-26561, 965, 1995));
  wait 0.15;
  thread common_scripts\utility::play_sound_in_space("clkw_expl_metal_debris", (-26545, 330, 1995));
  wait 0.2;
  thread common_scripts\utility::play_sound_in_space("clkw_expl_metal_debris", (-26188, 935, 1995));
}

vault_water() {
  var_0 = spawn("script_origin", (-27093, 746, 2076));
  var_0 playLoopSound("clkw_emt_vault_water");
  var_0 scalevolume(0);
  var_0 scalevolume(1, 1);
  common_scripts\utility::flag_wait("aud_stop_vault_water");
  var_0 scalevolume(0, 1);
  var_0 delete();
}

vault_water2() {
  var_0 = spawn("script_origin", (-27093, 746, 2076));
  var_0 playLoopSound("clkw_emt_vault_water");
  var_0 scalevolume(0);
  var_0 scalevolume(1, 1);
}

door_debris_l() {
  var_0 = 50;
  var_1 = 30;

  for(;;) {
    common_scripts\utility::flag_wait("touching_debris");
    var_2 = level.player.origin + anglesToForward(level.player.angles) * var_0 + (0, -10, var_1);
    thread common_scripts\utility::play_sound_in_space("clkw_foot_metal_debris_player", var_2);
    wait(randomfloatrange(1, 2.5));
    level.player maps\clockwork_code::waittill_movement();
  }
}

door_debris_r() {
  var_0 = 50;
  var_1 = 30;

  for(;;) {
    common_scripts\utility::flag_wait("touching_debris");
    var_2 = level.player.origin + anglesToForward(level.player.angles) * var_0 + (0, 10, var_1);
    thread common_scripts\utility::play_sound_in_space("clkw_foot_metal_debris_player", var_2);
    wait(randomfloatrange(1, 2.5));
    level.player maps\clockwork_code::waittill_movement();
  }
}

power_up() {
  common_scripts\utility::flag_wait("explosion_start");
  wait 1;
  level.player playSound("clkw_scn_power_up");
  level.player clearclienttriggeraudiozone();
  wait 0.5;
  thread pa_announcements_interior_combat();
  thread alarms_1();
  maps\_utility::music_play("mus_clock_combat_quick");
}

alarms_1() {
  if(!common_scripts\utility::flag("aud_alarms_on")) {
    common_scripts\utility::flag_set("aud_alarms_on");
    var_0 = spawn("script_origin", (-28579, 802, 2160));
    var_1 = spawn("script_origin", (-27287, 194, 2160));
    var_0 playLoopSound("clkw_emt_clockwork_alarm_1", (-28579, 802, 2160));
    var_1 playLoopSound("clkw_emt_clockwork_alarm_2", (-27287, 194, 2160));
    common_scripts\utility::flag_wait("aud_alarms_off");
    var_0 maps\_utility::sound_fade_and_delete(2);
    var_1 maps\_utility::sound_fade_and_delete(2);
    common_scripts\utility::flag_clear("aud_alarms_on");
  }
}

alarms_2() {
  var_0 = spawn("script_origin", (-30025, -4292, 1949));
  var_1 = spawn("script_origin", (-28175, -1632, 1605));
  var_0 playLoopSound("clkw_emt_clockwork_alarm_3");
  var_1 playLoopSound("clkw_emt_clockwork_alarm_4");
  common_scripts\utility::flag_wait("aud_defend_combat_started");
  var_0 scalevolume(0.2, 4);
  var_1 scalevolume(0.2, 4);
  wait 15;
  var_0 scalevolume(0, 10);
  var_1 scalevolume(0, 10);
  wait 10;
  var_0 stoploopsound("clkw_emt_clockwork_alarm_3");
  var_1 stoploopsound("clkw_emt_clockwork_alarm_4");
  var_0 delete();
  var_1 delete();
}

alarms_3() {
  wait 0.1;
  var_0 = spawn("script_origin", (-28579, 802, 2160));
  var_1 = spawn("script_origin", (-27287, 194, 2160));
  var_2 = spawn("script_origin", (-25885, 1587, 2081));
  var_3 = spawn("script_origin", (-26629, 1277, 2143));
  var_4 = spawn("script_origin", (-25593, 2296, 2165));
  var_5 = spawn("script_origin", (-28850, 1968, 2139));
  var_6 = spawn("script_origin", (-29099, 3995, 2127));
  var_0 playLoopSound("clkw_emt_clockwork_alarm_1");
  var_1 playLoopSound("clkw_emt_clockwork_alarm_2");
  var_2 playLoopSound("clkw_emt_clockwork_alarm_5");
  var_3 playLoopSound("clkw_emt_clockwork_alarm_6");
  var_4 playLoopSound("clkw_emt_clockwork_alarm_7");
  var_5 playLoopSound("clkw_emt_clockwork_alarm_8");
  var_6 playLoopSound("clkw_emt_clockwork_alarm_9");
  var_0 scalevolume(0);
  var_1 scalevolume(0);
  var_2 scalevolume(0);
  var_3 scalevolume(0);
  var_4 scalevolume(0);
  var_5 scalevolume(0);
  var_6 scalevolume(0);
  wait 0.05;
  var_0 scalevolume(0.3, 4);
  var_1 scalevolume(0.3, 4);
  var_2 scalevolume(0.3, 4);
  var_3 scalevolume(0.3, 4);
  var_4 scalevolume(0.3, 4);
  var_5 scalevolume(0.3, 4);
  var_6 scalevolume(0.3, 4);
  wait 4.5;
  var_0 scalevolume(1, 1);
  var_1 scalevolume(1, 1);
  var_2 scalevolume(1, 1);
  var_3 scalevolume(1, 1);
  var_4 scalevolume(1, 1);
  var_5 scalevolume(1, 1);
  var_6 scalevolume(1, 1);
  common_scripts\utility::flag_wait("aud_kill_idle");
  wait 4;
  var_0 scalevolume(0, 5);
  var_1 scalevolume(0, 5);
  var_2 scalevolume(0, 5);
  var_3 scalevolume(0, 5);
  var_4 scalevolume(0, 5);
  var_5 scalevolume(0, 5);
  var_6 scalevolume(0, 5);
  wait 5;
  var_0 stoploopsound("clkw_emt_clockwork_alarm_1");
  var_1 stoploopsound("clkw_emt_clockwork_alarm_2");
  var_2 stoploopsound("clkw_emt_clockwork_alarm_5");
  var_3 stoploopsound("clkw_emt_clockwork_alarm_6");
  var_4 stoploopsound("clkw_emt_clockwork_alarm_7");
  var_5 stoploopsound("clkw_emt_clockwork_alarm_8");
  var_6 stoploopsound("clkw_emt_clockwork_alarm_9");
  var_0 delete();
  var_1 delete();
  var_2 delete();
  var_3 delete();
  var_4 delete();
  var_5 delete();
  var_6 delete();
}

pa_announcements_interior_combat() {
  var_0 = [];
  var_0[var_0.size] = "clockwork_mpa_redalert";
  var_0[var_0.size] = "clockwork_mpa_quarters";
  var_0[var_0.size] = "clockwork_mpa_securelocation";
  var_0[var_0.size] = "clockwork_mpa_stations";
  var_0[var_0.size] = "clockwork_mpa_level3";
  var_0 = common_scripts\utility::array_randomize(var_0);
  level thread pa_announcements_interior_combat_thread("speaker_path_1", var_0);
}

pa_announcements_cqb() {
  var_0 = [];
  var_0[var_0.size] = "clockwork_mpa_intrudershavebreachedthe";
  var_0[var_0.size] = "clockwork_mpa_allsquadsreportto";
  var_0[var_0.size] = "clockwork_mpa_attentionintrudershave";
  var_0[var_0.size] = "clockwork_mpa_combatpersonnelreportto";
  var_0[var_0.size] = "clockwork_mpa_ourelectronicsurveillance";
  var_0 = common_scripts\utility::array_randomize(var_0);
  level thread pa_announcements_cqb_thread("speaker_path_2", var_0);
}

pa_announcements_chaos() {
  var_0 = [];
  var_0[var_0.size] = "clockwork_mpa_checktheidof";
  var_0[var_0.size] = "clockwork_mpa_damagecontrolreportto";
  var_0[var_0.size] = "clockwork_mpa_medicsareneededin";
  var_0[var_0.size] = "clockwork_mpa_additionaltechpersonnel";
  var_0[var_0.size] = "clockwork_mpa_theintrudersarewearing";
  var_0 = common_scripts\utility::array_randomize(var_0);
  level thread pa_announcements_chaos_thread("speaker_path_3", var_0);
}

pa_announcements_interior_combat_thread(var_0, var_1) {
  var_2 = common_scripts\utility::getstruct(var_0, "targetname");
  var_3 = 700;
  var_3 = var_3 * var_3;
  var_4 = [];
  var_5 = spawnStruct();
  var_5.delay = 0;
  var_5.waiting_for_sound = 0;

  for(var_6 = 0; var_6 < 2; var_6++) {
    var_4[var_6] = spawn("script_origin", (0, 0, 0));
    var_4[var_6].id = var_6 + 1;
  }

  var_7 = 0;

  while(!common_scripts\utility::flag("aud_stop_interior_combat_pa")) {
    var_8 = get_closest_speaker_nodes(var_2);

    foreach(var_6, var_10 in var_4) {
      var_10.origin = var_8[var_6].origin;
    }

    if(gettime() > var_5.delay && !var_5.waiting_for_sound) {
      if(distancesquared(level.player.origin, var_8[0].origin) > var_3) {
        wait 0.1;
        continue;
      }

      var_11 = var_7 % var_1.size;
      var_7++;

      if(var_11 == 0) {
        var_1 = common_scripts\utility::array_randomize(var_1);
      }

      var_5 thread speaker_playSound(var_4, var_1[var_11]);
    }

    wait 0.1;
  }
}

pa_announcements_cqb_thread(var_0, var_1) {
  var_2 = common_scripts\utility::getstruct(var_0, "targetname");
  var_3 = 700;
  var_3 = var_3 * var_3;
  var_4 = [];
  var_5 = spawnStruct();
  var_5.delay = 0;
  var_5.waiting_for_sound = 0;

  for(var_6 = 0; var_6 < 2; var_6++) {
    var_4[var_6] = spawn("script_origin", (0, 0, 0));
    var_4[var_6].id = var_6 + 1;
  }

  var_7 = 0;

  while(!common_scripts\utility::flag("aud_defend_started")) {
    var_8 = get_closest_speaker_nodes(var_2);

    foreach(var_6, var_10 in var_4) {
      var_10.origin = var_8[var_6].origin;
    }

    if(gettime() > var_5.delay && !var_5.waiting_for_sound) {
      if(distancesquared(level.player.origin, var_8[0].origin) > var_3) {
        wait 0.1;
        continue;
      }

      var_11 = var_7 % var_1.size;
      var_7++;

      if(var_11 == 0) {
        var_1 = common_scripts\utility::array_randomize(var_1);
      }

      var_5 thread speaker_playSound(var_4, var_1[var_11]);
    }

    wait 0.1;
  }
}

pa_announcements_chaos_thread(var_0, var_1) {
  var_2 = common_scripts\utility::getstruct(var_0, "targetname");
  var_3 = 700;
  var_3 = var_3 * var_3;
  var_4 = [];
  var_5 = spawnStruct();
  var_5.delay = 0;
  var_5.waiting_for_sound = 0;

  for(var_6 = 0; var_6 < 2; var_6++) {
    var_4[var_6] = spawn("script_origin", (0, 0, 0));
    var_4[var_6].id = var_6 + 1;
  }

  var_7 = 0;

  while(!common_scripts\utility::flag("aud_kill_idle")) {
    var_8 = get_closest_speaker_nodes(var_2);

    foreach(var_6, var_10 in var_4) {
      var_10.origin = var_8[var_6].origin;
    }

    if(gettime() > var_5.delay && !var_5.waiting_for_sound) {
      if(distancesquared(level.player.origin, var_8[0].origin) > var_3) {
        wait 0.1;
        continue;
      }

      var_11 = var_7 % var_1.size;
      var_7++;

      if(var_11 == 0) {
        var_1 = common_scripts\utility::array_randomize(var_1);
      }

      var_5 thread speaker_playSound(var_4, var_1[var_11]);
    }

    wait 0.1;
  }
}

speaker_playSound(var_0, var_1) {
  self.waiting_for_sound = 1;

  foreach(var_3 in var_0) {
    var_3 playSound(var_1, "sounddone");
  }

  var_0[0] waittill("sounddone");
  self.waiting_for_sound = 0;
  self.delay = gettime() + randomfloatrange(1, 8) * 1000;
}

get_closest_speaker_nodes(var_0) {
  var_1 = distancesquared(level.player.origin, var_0.origin);
  var_2 = var_0;

  while(isDefined(var_0.target)) {
    var_0 = common_scripts\utility::getstruct(var_0.target, "targetname");
    var_3 = distancesquared(level.player.origin, var_0.origin);

    if(var_3 < var_1) {
      var_1 = var_3;
      var_2 = var_0;
    }
  }

  var_4 = undefined;
  var_4 = common_scripts\utility::getstruct(var_2.targetname, "target");
  var_5 = undefined;

  if(isDefined(var_2.target)) {
    var_5 = common_scripts\utility::getstruct(var_2.target, "targetname");
  }

  var_1 = 64000000;
  var_6 = [var_2];
  var_7 = undefined;
  var_8 = [];

  if(isDefined(var_4)) {
    var_8[var_8.size] = var_4;
  }

  if(isDefined(var_5)) {
    var_8[var_8.size] = var_5;
  }

  if(var_8.size > 0) {
    var_1 = distancesquared(level.player.origin, var_8[0].origin);
    var_7 = var_8[0];
  }

  foreach(var_10 in var_8) {
    var_3 = distancesquared(level.player.origin, var_10.origin);

    if(var_3 < var_1) {
      var_1 = var_3;
      var_7 = var_10;
    }
  }

  if(isDefined(var_7)) {
    var_6[var_6.size] = var_7;
  }

  return var_6;
}

cqb_door_shove() {
  wait 2.1;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_cqb_doorbreak_hit_2", (-29566, -941, 1996));
  wait 2.1;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_cqb_doorbreak_break", (-29566, -941, 1996));
  thread cqb_fans();
}

cqb_door_open_slow() {
  wait 0.5;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_cqb_door_open_slow", (-30017, -941, 1996));
  wait 0.3;
  thread pre_lookout();
  common_scripts\utility::flag_set("aud_stop_vault_water");
}

cqb_door_close_behind() {
  wait 1;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_cqb_door_close_behind", (-29580, -950, 1994));
}

cqb_fans() {
  thread common_scripts\utility::play_loopsound_in_space("clkw_scn_cqb_fan_blade_1", (-30088, -660, 1994));
  thread common_scripts\utility::play_loopsound_in_space("clkw_scn_cqb_fan_blade_2", (-30088, -1223, 1994));
  thread common_scripts\utility::play_loopsound_in_space("clkw_scn_cqb_fan_blade_3", (-30088, -1546, 1994));
  common_scripts\utility::flag_wait("aud_stop_fan_sound");
}

pre_lookout() {
  common_scripts\utility::flag_wait("aud_pre_lookout");

  if(level.bcqb_pa_playing == 0) {
    thread pa_announcements_cqb();
    level.bcqb_pa_playing = 1;
  }
}

locker_brawl(var_0) {
  wait 1;
  var_1 = spawn("script_origin", (-30664, -1684, 1856));
  var_2 = (-30650, -1613, 1860);
  var_3 = (-30628, -1733, 1855);
  var_4 = (-30627, -1687, 1803);
  var_1 playSound("clkw_scn_cqb_locker_brawl", "sounddone");
  var_1 moveto(var_2, 1);
  wait 2;
  var_1 moveto(var_3, 0.5);
  wait 0.7;
  var_1 moveto(var_4, 0.5);
  var_1 waittill("sounddone");
  var_1 delete();
  thread alarms_2();
}

locker_brawl_vo(var_0) {
  var_1 = spawn("script_origin", (-30664, -1684, 1856));
  wait 1;
  var_1 playSound("scn_clockwork_catwalk_npc_death", "sounddone");
  var_2 = (-30650, -1613, 1860);
  var_3 = (-30628, -1733, 1855);
  var_4 = (-30627, -1687, 1803);
  var_1 moveto(var_2, 1);
  wait 2;
  var_1 moveto(var_3, 0.5);
  wait 0.7;
  var_1 moveto(var_4, 0.5);
  var_1 waittill("sounddone");
  var_1 delete();
  thread alarms_2();
}

rotunda_kill() {
  wait 4.6;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_cqb_encounter_foley_1", (-29922, -2931, 1740));
  wait 0.6;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_cqb_encounter_foley_2", (-29883, -2891, 1740));
}

defend_start() {
  wait 0.05;
  common_scripts\utility::flag_set("aud_defend_started");
  common_scripts\utility::flag_set("aud_alarms_off");
}

defend_combat() {
  wait 18;
  common_scripts\utility::flag_set("aud_defend_combat_started");
  wait 30;
  maps\_utility::music_play("mus_clock_defend_combat1");
  wait 76;
  maps\_utility::music_play("mus_clock_defend_combat2");
}

defend_door_explosion(var_0) {
  if(level.bdefenddoorexplosionplaying == 0) {
    level.bdefenddoorexplosionplaying = 1;
    thread common_scripts\utility::play_sound_in_space("clkw_defend_door_explosion", var_0);
    level.player playSound("clkw_defend_door_expl_debris");
    wait 1;
    level.bdefenddoorexplosionplaying = 0;
  }
}

defend_fire(var_0) {
  if(level.bdefenddoorexplosionplaying == 0) {
    level.bdefenddoorexplosionplaying = 1;
    thread common_scripts\utility::play_sound_in_space("clkw_defend_door_explosion", var_0 + (0, -100, 0));
    thread common_scripts\utility::play_sound_in_space("clkw_defend_fire_blocker_expl", var_0 + (0, -100, 0));
    thread common_scripts\utility::play_loopsound_in_space("clkw_defend_fire", var_0 + (0, -100, 0));
    wait 1;
    level.bdefenddoorexplosionplaying = 0;
  }
}

command_platform_bag_cypher() {
  wait 2.2;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_defend_bag_drop_cypher", (-27927, -623, 1462));
}

command_platform_bag_keegan() {
  wait 2.2;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_defend_bag_drop_keegan", (-27948, -696, 1462));
}

command_platform_bag_baker() {
  wait 3;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_defend_bag_drop_baker", (-27871, -714, 1462));
}

command_platform_bag_player() {
  wait 0.62;
  thread common_scripts\utility::play_sound_in_space("clkw_mine_drop_bag", (-27856, -649, 1451));
}

teargas_grab() {
  level.player playSound("clkw_defend_item_grab");
}

mines_grab() {
  level.player playSound("clkw_defend_item_grab");
  wait 0.8;
  level.player playSound("clkw_mine_pickup");
}

mines_ready_to_throw() {
  wait 0.95;
  level.player playSound("clkw_mine_pickup");
}

mine_explode(var_0) {
  thread common_scripts\utility::play_sound_in_space("clkw_mine_flare", var_0);
  wait 1.5;
  thread common_scripts\utility::play_sound_in_space("clkw_mine_explode", var_0);
}

defend_door_open() {
  common_scripts\utility::play_sound_in_space("clkw_scn_defend_door_open", (-27656, 276, 1457));
}

defend_door_close() {
  common_scripts\utility::play_sound_in_space("clkw_scn_defend_door_close", (-27656, 276, 1457));
}

chaos_music() {
  common_scripts\utility::flag_wait("inpos_player_elevator");
}

elevator() {
  level.player playSound("clkw_scn_elevator");
  wait 7;
  thread alarms_3();
  wait 8;
  thread pa_announcements_chaos();
}

elevator_door_close() {
  thread common_scripts\utility::play_sound_in_space("clkw_scn_elevator_door_close", (-27369, 1062, 1469));
  maps\_utility::music_play("mus_clock_walking_out");
}

elevator_door_open() {
  level.player playSound("clkw_scn_elevator_door_open", (-27369, 1062, 1990));
  thread vault_water2();
  thread exfil_keegan_and_cypher_enter_jeep();
  thread exfil_baker_enter_jeep();
}

garage_jeep_start_skid() {
  maps\_utility::music_stop(3);
  var_0 = spawn("script_origin", (-28277, 2732, 2060));
  var_1 = (-27091, 3032, 2060);
  var_0 playSound("clkw_garage_jeep_start_skid", "sounddone");
  wait 2.1;
  var_0 moveto(var_1, 5);
  var_0 waittill("sounddone");
  var_0 delete();
}

exfil_enter_jeep() {
  level.player playSound("clkw_scn_exfil_enter_jeep");
}

exfil_keegan_and_cypher_enter_jeep() {
  common_scripts\utility::flag_wait("aud_keegan_getin");
  thread exfil_keegan_enter_jeep();
  thread exfil_cypher_enter_jeep();
}

exfil_keegan_enter_jeep() {
  thread exfil_jeep_latch_open_lf();
  wait 1.5;
  thread common_scripts\utility::play_sound_in_space("clkw_keegan_enter_jeep", (-28656, 3079, 2062));
  wait 1.5;
  thread exfil_jeep_latch_close_lf();
  wait 0.5;
  thread exfil_engine_start_keegan();
}

exfil_cypher_enter_jeep() {
  thread exfil_jeep_latch_open_lr();
  wait 0.5;
  thread common_scripts\utility::play_sound_in_space("clkw_cypher_enter_jeep", (-28677, 3095, 2062));
  wait 1.8;
  thread exfil_jeep_latch_close_lr();
}

exfil_baker_enter_jeep() {
  common_scripts\utility::flag_wait("aud_baker_getin");
  thread exfil_engine_starts_axis();
  thread exfil_jeep_latch_open_rf();
  wait 1.5;
  thread common_scripts\utility::play_sound_in_space("clkw_baker_enter_jeep", (-28678, 3044, 2062));
  wait 2;
  thread exfil_jeep_latch_close_rf();
}

exfil_engine_starts_axis() {
  thread common_scripts\utility::play_sound_in_space("clkw_scn_exfil_engine_start_b", (-28449, 3083, 2088));
  wait 1.5;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_exfil_engine_start_c", (-29112, 2915, 2088));
}

exfil_engine_start_keegan() {
  var_0 = spawn("script_origin", (-28603, 3008, 2088));
  var_0 playSound("clkw_scn_exfil_engine_start_a", "sounddone");
  common_scripts\utility::flag_wait("aud_kill_idle");
  var_0 scalevolume(0, 1);
  var_0 delete();
}

exfil_jeep_latch_open_lf() {
  thread common_scripts\utility::play_sound_in_space("clkw_scn_ambush_latch_open", (-28638, 3085, 2090));
}

exfil_jeep_latch_close_lf() {
  thread common_scripts\utility::play_sound_in_space("clkw_scn_ambush_latch_close", (-28638, 3085, 2090));
}

exfil_jeep_latch_open_rf() {
  thread common_scripts\utility::play_sound_in_space("clkw_scn_ambush_latch_open", (-28691, 3035, 2090));
}

exfil_jeep_latch_close_rf() {
  thread common_scripts\utility::play_sound_in_space("clkw_scn_ambush_latch_close", (-28691, 3035, 2090));
}

exfil_jeep_latch_open_lr() {
  thread common_scripts\utility::play_sound_in_space("clkw_scn_ambush_latch_open", (-28661, 3106, 2090));
}

exfil_gun_cock(var_0) {
  thread common_scripts\utility::play_sound_in_space("clkw_gun_cock", var_0);
}

exfil_jeep_latch_close_lr() {
  thread common_scripts\utility::play_sound_in_space("clkw_scn_ambush_latch_close", (-28661, 3106, 2090));
}

exfil_hoodsmack() {
  thread common_scripts\utility::play_sound_in_space("clkw_exfil_hood_smack", (-23988, 3659, 2063));
}

lead_jeep() {
  var_0 = spawn("script_origin", (-28451, 3096, 2074));
  var_1 = (-28320, 2865, 2074);
  var_2 = (-27412, 2934, 2074);
  var_3 = (-25944, 3491, 2069);
  var_0 playSound("clkw_garage_lead_jeep_by", "sounddone");
  var_0 moveto(var_1, 1.5);
  wait 1.5;
  var_0 moveto(var_2, 4);
  wait 4;
  var_0 moveto(var_3, 3.5);
  wait 3.5;
  var_0 waittill("sounddone");
  var_0 delete();
}

exfil_get_on_turret() {
  wait 3.5;
  level.player playSound("clkw_scn_chase_stand_up");
}

chase_tower_fire() {
  var_0 = spawn("script_origin", (-8014, -3763, 949));
  var_1 = spawn("script_origin", (-8014, -3763, 949));
  var_2 = spawn("script_origin", (-8014, -3763, 949));
  var_3 = (-10889, -5143, 286);
  var_4 = (-10433, -4780, 264);
  var_5 = (-9275, -4338, 264);
  var_0 playSound("clkw_scn_chase_tower_fire_01", "sounddone");
  var_0 moveto(var_3, 1);
  wait 1;
  var_1 playSound("clkw_scn_chase_tower_fire_01", "sounddone");
  var_1 moveto(var_4, 1);
  wait 1;
  var_2 playSound("clkw_scn_chase_tower_fire_01", "sounddone");
  var_2 moveto(var_5, 1);
  var_2 waittill("sounddone");
  var_0 delete();
  var_1 delete();
  var_2 delete();
}

chase_player() {
  thread exit_tunnel_jeep_by();
  thread checkpoint_foley();
  common_scripts\utility::flag_set("aud_kill_idle");
  thread chase_amb_garage_start();
  thread chase_amb_garage_punch_it();
  thread chase_amb_garage_pre_exit();
  thread chase_amb_garage_pre_exit_skid();
  thread chase_amb_garage_exit();
  thread chase_amb_crossroad();
  thread chase_amb_enter_ravine();
  thread chase_amb_enter_tunnel();
  thread chase_amb_exit_tunnel();
  thread chase_amb_under_bridge_1();
  thread chase_amb_sharp_turn();
  thread chase_amb_under_bridge_2();
  thread chase_amb_under_bridge_3();
  thread chase_amb_enter_chasm();
  thread chase_amb_tight_spot();
  thread chase_amb_under_bridge_4();
  thread chase_amb_sub_comes_up();
}

exit_tunnel_jeep_by() {
  wait 9.2;
  var_0 = spawn("script_origin", (-25590, 3743, 2069));
  var_1 = (-26031, 3615, 2069);
  var_0 playSound("clkw_exfil_garage_jeep_by", "sounddone");
  var_0 moveto(var_1, 4);
  var_0 waittill("sounddone");
  var_0 delete();
}

checkpoint_foley() {
  wait 16.5;
  thread common_scripts\utility::play_sound_in_space("clkw_garage_checkpoint_foley", (-23761, 3818, 2081));
}

chase_player_collision() {
  level.player playSound("clkw_scn_chase_player_impact");
}

chase_player_jolt() {
  level.player playSound("clkw_scn_chase_player_jolt");
}

chase_concussion() {}

chase_pileup_counter() {
  var_0 = level.pileupcounter;
  level.pileupcounter = var_0 + 1;
  wait 1.6;
  var_1 = level.pileupcounter;
  level.pileupcounter = var_1 - 1;
}

chase_crashmix(var_0) {
  if(!level.bcrashmix && !common_scripts\utility::flag("chase_under_bridge_4") && common_scripts\utility::flag("aud_start_pileup")) {
    var_1 = 0.25;
    level.bcrashmix = 1;
    var_2 = level._audio.mix.current;
    level.player playSound("clkw_scn_ice_chase_expl_2d");
    level.player playSound("clkw_chase_expl_close_debris");

    while(level.crashtimer < var_1) {
      wait 0.1;
      level.crashtimer = level.crashtimer + 0.1;
    }

    level.bcrashmix = 0;
    level.crashtimer = 0;
  } else
    level.crashtimer = 0;
}

chase_land_tires_big(var_0) {
  thread chase_pileup_counter();

  if(!common_scripts\utility::flag("aud_land_tires_big_playing")) {
    thread common_scripts\utility::play_sound_in_space("clkw_scn_chase_land_tires_big", var_0);
    common_scripts\utility::flag_set("aud_land_tires_big_playing");
    wait 1;
    common_scripts\utility::flag_clear("aud_land_tires_big_playing");
  }
}

chase_land_tires_small(var_0) {
  thread chase_pileup_counter();

  if(!common_scripts\utility::flag("aud_land_tires_small_playing")) {
    thread common_scripts\utility::play_sound_in_space("clkw_scn_chase_land_tires_small", var_0);
    common_scripts\utility::flag_set("aud_land_tires_small_playing");
    wait 3;
    common_scripts\utility::flag_clear("aud_land_tires_small_playing");
  }
}

chase_land_roof(var_0) {
  thread chase_pileup_counter();
  thread chase_pileup_counter();

  if(level.pileupcounter > 4) {
    thread pileup(var_0);
  }

  if(!common_scripts\utility::flag("aud_land_roof_playing")) {
    thread common_scripts\utility::play_sound_in_space("clkw_scn_chase_land_roof", var_0);
    common_scripts\utility::flag_set("aud_land_roof_playing");
    wait 2;
    common_scripts\utility::flag_clear("aud_land_roof_playing");
  }
}

chase_leftground(var_0) {
  thread chase_pileup_counter();
  thread chase_pileup_counter();

  if(level.pileupcounter > 8) {
    thread pileup(var_0);
  }

  if(!common_scripts\utility::flag("aud_leftground_playing")) {
    thread common_scripts\utility::play_sound_in_space("clkw_scn_chase_leftground", var_0);
    var_1 = randomint(2);

    if(var_1 == 1) {
      thread common_scripts\utility::play_sound_in_space("clockwork_chase_scream", var_0);
    }

    common_scripts\utility::flag_set("aud_leftground_playing");
    wait 1;
    common_scripts\utility::flag_clear("aud_leftground_playing");
  }
}

chase_collision(var_0) {
  thread chase_pileup_counter();

  if(level.pileupcounter > 15) {
    thread pileup(var_0);
  }

  if(!common_scripts\utility::flag("aud_collision_playing")) {
    thread common_scripts\utility::play_sound_in_space("clkw_scn_chase_collision", var_0);
    common_scripts\utility::flag_set("aud_collision_playing");
    wait 0.5;
    common_scripts\utility::flag_clear("aud_collision_playing");
  }
}

chase_sm_leftground(var_0) {
  if(!common_scripts\utility::flag("aud_leftground_playing")) {
    thread common_scripts\utility::play_sound_in_space("clkw_scn_chase_leftground", var_0);
    var_1 = randomint(2);

    if(var_1 == 1) {
      thread common_scripts\utility::play_sound_in_space("clockwork_chase_scream", var_0);
    }

    common_scripts\utility::flag_set("aud_leftground_playing");
    wait 1;
    common_scripts\utility::flag_clear("aud_leftground_playing");
  }
}

chase_sm_collision(var_0) {
  if(!common_scripts\utility::flag("aud_collision_playing")) {
    thread common_scripts\utility::play_sound_in_space("clkw_scn_chase_sm_collision", var_0);
  }
}

pileup(var_0) {
  if(common_scripts\utility::flag("aud_start_pileup")) {
    if(!common_scripts\utility::flag("aud_pileup_playing") && level.pileupsequence == 1) {
      thread common_scripts\utility::play_sound_in_space("clkw_scn_chase_pileup_04", var_0);
      var_1 = randomint(2);

      if(var_1 == 1) {
        thread common_scripts\utility::play_sound_in_space("clockwork_chase_scream", var_0);
      }

      common_scripts\utility::flag_set("aud_pileup_playing");
      wait 6;
      common_scripts\utility::flag_clear("aud_pileup_playing");
      level.pileupsequence = 2;
    } else if(!common_scripts\utility::flag("aud_pileup_playing") && level.pileupsequence == 2) {
      thread common_scripts\utility::play_sound_in_space("clkw_scn_chase_pileup_02", var_0);
      var_1 = randomint(2);

      if(var_1 == 1) {
        thread common_scripts\utility::play_sound_in_space("clockwork_chase_scream", var_0);
      }

      common_scripts\utility::flag_set("aud_pileup_playing");
      wait 6;
      common_scripts\utility::flag_clear("aud_pileup_playing");
      level.pileupsequence = 3;
    } else if(!common_scripts\utility::flag("aud_pileup_playing") && level.pileupsequence == 3) {
      thread common_scripts\utility::play_sound_in_space("clkw_scn_chase_pileup_03", var_0);
      var_1 = randomint(2);

      if(var_1 == 1) {
        thread common_scripts\utility::play_sound_in_space("clockwork_chase_scream", var_0);
      }

      common_scripts\utility::flag_set("aud_pileup_playing");
      wait 6;
      common_scripts\utility::flag_clear("aud_pileup_playing");
      level.pileupsequence = 4;
    } else if(!common_scripts\utility::flag("aud_pileup_playing") && level.pileupsequence == 4) {
      thread common_scripts\utility::play_sound_in_space("clkw_scn_chase_pileup_01", var_0);
      var_1 = randomint(2);

      if(var_1 == 1) {
        thread common_scripts\utility::play_sound_in_space("clockwork_chase_scream", var_0);
      }

      common_scripts\utility::flag_set("aud_pileup_playing");
      wait 6;
      common_scripts\utility::flag_clear("aud_pileup_playing");
      level.pileupsequence = 1;
    }
  }
}

chase_sink(var_0) {
  thread common_scripts\utility::play_sound_in_space("clkw_scn_ice_chase_hole_loud", var_0);
  var_1 = randomint(2);

  if(var_1 == 1) {
    wait 0.1;
    thread common_scripts\utility::play_sound_in_space("clkw_scn_ice_chase_crack", var_0);
  }
}

chase_crack_icehole(var_0) {
  var_1 = randomint(2);

  if(var_1 == 1) {
    wait 0.1;
    thread common_scripts\utility::play_sound_in_space("clkw_scn_ice_chase_crack", var_0);
  }
}

chase_amb_garage_start() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 playSound("clkw_scn_chase_garage_start");
  common_scripts\utility::flag_wait("chase_punch_it");
  var_0 maps\_utility::sound_fade_and_delete(1);
  maps\_utility::music_stop(3);
  thread chase_music();
}

chase_amb_garage_punch_it() {
  common_scripts\utility::flag_wait("chase_punch_it");
  level.player playSound("clkw_scn_chase_garage_punch_it");
  wait 1;
  thread garage_velocity_loops();
}

garage_velocity_loops() {
  var_0 = spawn("script_origin", (-26797, 3359, 2079));
  var_1 = spawn("script_origin", (-25634, 3768, 2079));
  var_2 = spawn("script_origin", (-24862, 3925, 2079));
  var_3 = spawn("script_origin", (-24241, 3960, 2079));
  var_4 = spawn("script_origin", (-23679, 3949, 2079));
  var_5 = spawn("script_origin", (-23081, 3906, 2079));
  var_6 = spawn("script_origin", (-26787, 3027, 2079));
  var_7 = spawn("script_origin", (-25633, 3490, 2079));
  var_8 = spawn("script_origin", (-24890, 3610, 2079));
  var_9 = spawn("script_origin", (-24230, 3613, 2079));
  var_10 = spawn("script_origin", (-23864, 3693, 2079));
  var_11 = spawn("script_origin", (-23083, 3659, 2079));
  var_0 scalevolume(0.1);
  var_1 scalevolume(0.1);
  var_2 scalevolume(0.1);
  var_3 scalevolume(0.1);
  var_4 scalevolume(0.1);
  var_5 scalevolume(0.1);
  var_6 scalevolume(0.1);
  var_7 scalevolume(0.1);
  var_8 scalevolume(0.1);
  var_9 scalevolume(0.1);
  var_10 scalevolume(0.1);
  var_11 scalevolume(0.1);
  wait 0.05;
  var_0 playLoopSound("clkw_velocity_loop");
  var_1 playLoopSound("clkw_velocity_loop");
  var_2 playLoopSound("clkw_velocity_loop");
  var_3 playLoopSound("clkw_velocity_loop");
  var_4 playLoopSound("clkw_velocity_loop");
  var_5 playLoopSound("clkw_velocity_loop");
  var_6 playLoopSound("clkw_velocity_loop");
  var_7 playLoopSound("clkw_velocity_loop");
  var_8 playLoopSound("clkw_velocity_loop");
  var_9 playLoopSound("clkw_velocity_loop");
  var_10 playLoopSound("clkw_velocity_loop");
  var_11 playLoopSound("clkw_velocity_loop");
  var_0 scalevolume(1, 2);
  var_1 scalevolume(1, 2);
  var_2 scalevolume(1, 2);
  var_3 scalevolume(1, 2);
  var_4 scalevolume(1, 2);
  var_5 scalevolume(1, 2);
  var_6 scalevolume(1, 2);
  var_7 scalevolume(1, 2);
  var_8 scalevolume(1, 2);
  var_9 scalevolume(1, 2);
  var_10 scalevolume(1, 2);
  var_11 scalevolume(1, 2);
  common_scripts\utility::flag_wait("chase_garage_exit");
  wait 3;
  var_0 stoploopsound("clkw_amb_velocity_loop_light");
  var_1 stoploopsound("clkw_amb_velocity_loop_light");
  var_2 stoploopsound("clkw_amb_velocity_loop_light");
  var_3 stoploopsound("clkw_amb_velocity_loop_light");
  var_4 stoploopsound("clkw_amb_velocity_loop_light");
  var_5 stoploopsound("clkw_amb_velocity_loop_light");
  var_6 stoploopsound("clkw_amb_velocity_loop_light");
  var_7 stoploopsound("clkw_amb_velocity_loop_light");
  var_8 stoploopsound("clkw_amb_velocity_loop_light");
  var_9 stoploopsound("clkw_amb_velocity_loop_light");
  var_10 stoploopsound("clkw_amb_velocity_loop_light");
  var_11 stoploopsound("clkw_amb_velocity_loop_light");
  var_0 delete();
  var_1 delete();
  var_2 delete();
  var_3 delete();
  var_4 delete();
  var_5 delete();
  var_6 delete();
  var_7 delete();
  var_8 delete();
  var_9 delete();
  var_10 delete();
  var_11 delete();
}

chase_amb_garage_pre_exit() {
  common_scripts\utility::flag_wait("chase_punch_it");
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 scalevolume(0.1);
  wait 0.2;
  var_0 playLoopSound("clkw_scn_chase_garage_pre_exit");
  wait 0.05;
  var_0 scalevolume(1, 1.8);
  common_scripts\utility::flag_wait("chase_garage_exit");
  wait 0.5;
  var_0 maps\_utility::sound_fade_and_delete(1);
}

chase_amb_garage_pre_exit_skid() {
  common_scripts\utility::flag_wait("chase_punch_it");
  level.player playSound("clkw_scn_chase_skid_player");
  wait 0.7;
  level.player playSound("clkw_scn_chase_roadblock_smash");
  wait 0.4;
  thread common_scripts\utility::play_sound_in_space("clkw_garage_hit_vehicle", (-23793, 3826, 2065));
  wait 0.3;
  level.player playSound("clkw_garage_hit_body", (-23785, 3734, 2052));
}

chase_amb_garage_exit() {
  common_scripts\utility::flag_wait("chase_garage_exit");
  maps\_utility::music_play("mus_clock_chase1");
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 playLoopSound("clkw_scn_chase_garage_exit");
  var_0 scalevolume(0.1);
  wait 0.05;
  var_0 scalevolume(0.891, 0.2);
  wait 2;
  var_0 scalevolume(0.707, 6);
  common_scripts\utility::flag_wait("chase_crossroad");
  wait 1;
  var_0 maps\_utility::sound_fade_and_delete(1);
}

chase_amb_crossroad() {
  common_scripts\utility::flag_wait("chase_crossroad");
  thread chase_roadblock_smash();
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 scalevolume(0.1);
  wait 0.02;
  var_0 playLoopSound("clkw_scn_chase_crossroad");
  var_0 scalevolume(1, 1);
  level.player playSound("clkw_scn_chase_skid_player");
  common_scripts\utility::flag_wait("chase_enter_ravine");
  wait 2;
  var_0 maps\_utility::sound_fade_and_delete(1);
}

chase_roadblock_smash() {
  wait 0.2;
  level.player setclienttriggeraudiozone("chase_roadblock");
  level.player playSound("clkw_scn_chase_roadblock_smash", "sounddone");
  thread common_scripts\utility::play_sound_in_space("clkw_scn_roadblock_roll", (-18358, -3107, 381));
  wait 1;
  level.player clearclienttriggeraudiozone(1);
  thread ravine_jeeps_to_the_right();
}

chase_amb_enter_ravine() {
  common_scripts\utility::flag_wait("chase_enter_ravine");
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 scalevolume(0.1);
  wait 0.05;
  var_0 playLoopSound("clkw_scn_chase_enter_ravine");
  var_0 scalevolume(1, 0.5);
  wait 0.25;
  level.player playSound("clkw_ravine_start_skid");
  wait 1;
  level.player playSound("clkw_scn_chase_skid_player");
  wait 3;
  common_scripts\utility::flag_set("aud_start_pileup");
  common_scripts\utility::flag_wait("chase_enter_tunnel");
  var_0 maps\_utility::sound_fade_and_delete(2);
}

ravine_jeeps_to_the_right() {
  wait 9.5;
  var_0 = spawn("script_origin", (-12520, -2842, 461));
  var_1 = (-8667, -4029, 461);
  var_0 playSound("clkw_scn_chase_jeeps_right", "sounddone");
  var_0 scalevolume(0.562);
  var_0 moveto(var_1, 8, 4);
  var_0 waittill("sounddone");
  var_0 delete();
}

chase_amb_enter_tunnel() {
  common_scripts\utility::flag_wait("chase_enter_tunnel");
  var_0 = spawn("script_origin", (0, 0, 0));
  common_scripts\utility::flag_set("aud_chase_interior");
  var_0 scalevolume(0.1);
  wait 0.02;
  var_0 playLoopSound("clkw_scn_chase_enter_tunnel");
  var_0 scalevolume(1, 0.5);
  wait 4.15;
  level.player playSound("clkw_scn_chase_skid_player");
  common_scripts\utility::flag_wait("chase_exit_tunnel");
  var_0 maps\_utility::sound_fade_and_delete(2);
}

chase_tunnel_jeep() {
  thread snowmobiles_tunnel();
  var_0 = spawn("script_origin", (-6356, -6559, 319));
  var_1 = (-5572, -6555, 257);
  var_0 playSound("clkw_scn_chase_tunnel_jeep", "sounddone");
  var_0 moveto(var_1, 1.8);
  var_0 waittill("sounddone");
  var_0 delete();
}

snowmobiles_tunnel() {
  wait 4;
  var_0 = spawn("script_origin", (-5741, -7607, 285));
  var_0 playSound("clkw_scn_chase_snowmb_tunnel", "sounddone");
  var_1 = (-5018, -8417, 285);
  var_2 = (-972, -8607, 285);
  var_0 moveto(var_1, 1.3);
  wait 1.3;
  var_0 moveto(var_2, 5);
  var_0 waittill("sounddone");
  var_0 delete();
}

chase_amb_exit_tunnel() {
  common_scripts\utility::flag_wait("chase_exit_tunnel");
  thread tunnel_exit_jeeps();
  var_0 = spawn("script_origin", (0, 0, 0));
  common_scripts\utility::flag_clear("aud_chase_interior");
  var_0 playLoopSound("clkw_scn_chase_exit_tunnel");
  var_0 scalevolume(0.1);
  wait 0.05;
  var_0 scalevolume(0.562, 0.2);
  wait 2.5;
  var_0 scalevolume(1, 3);
  wait 2;
  level.player playSound("clkw_scn_chase_skid_player");
  common_scripts\utility::flag_wait("chase_under_bridge_1");
  var_0 maps\_utility::sound_fade_and_delete(2);
}

tunnel_exit_jeeps() {
  maps\_utility::music_play("mus_clock_chase2");
  var_0 = spawn("script_origin", (-472, -9053, 274));
  var_1 = (273, -8376, 274);
  var_2 = (762, -7454, 266);
  var_0 playSound("clkw_scn_chase_tunnel_exit_jeeps", "sounddone");
  var_0 moveto(var_1, 1.5);
  wait 1.5;
  var_0 moveto(var_2, 1.5);
  var_0 waittill("sounddone");
  var_0 delete();
}

chase_amb_under_bridge_1() {
  common_scripts\utility::flag_wait("chase_under_bridge_1");
  thread snowmobiles();
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 scalevolume(0.1);
  wait 0.05;
  var_0 playLoopSound("clkw_scn_chase_under_bridge_1");
  var_0 scalevolume(1, 0.2);
  wait 0.05;
  var_0 scalevolume(0.63, 10);
  wait 5.25;
  level.player playSound("clkw_scn_chase_skid_player");
  wait 7.3;
  level.player playSound("clkw_scn_chase_skid_player");
  common_scripts\utility::flag_wait("chase_sharp_turn");
  var_0 maps\_utility::sound_fade_and_delete(2);
}

snowmobiles() {
  if(level.bsnowmobilesstarted == 0) {
    level.bsnowmobilesstarted = 1;
    wait 1.5;
    var_0 = spawn("script_origin", (-273, -1821, 272));
    var_1 = (348, 3222, 272);
    var_2 = (3711, 2575, 272);
    var_0 moveto(var_1, 5);
    wait 1;
    var_0 playSound("clkw_scn_chase_snowmobiles", "sounddone");
    wait 4;
    var_0 moveto(var_2, 3);
    var_0 waittill("sounddone");
    var_0 delete();
  }
}

bigjump() {
  wait 0.5;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_chase_leftground_loud", (5365, 1031, 369));
  wait 1.2;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_chase_land_tires_big", (5938, 676, 252));
}

chase_amb_sharp_turn() {
  common_scripts\utility::flag_wait("chase_sharp_turn");
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 scalevolume(0.1);
  wait 0.05;
  var_0 playLoopSound("clkw_scn_chase_sharp_turn");
  var_0 scalevolume(0.501, 0.2);
  wait 3.3;
  level.player playSound("clkw_scn_chase_skid_player");
  thread bridge_siren();
  wait 2.3;
  var_0 scalevolume(1, 2);
  level.player playSound("clkw_scn_chase_skid_player");
  common_scripts\utility::flag_wait("chase_under_bridge_2");
  var_0 maps\_utility::sound_fade_and_delete(2);
}

bridge_siren() {
  var_0 = spawn("script_origin", (12982, 2282, 655));
  var_0 playSound("clkw_scn_chase_bridge_siren", "sounddone");
  var_0 waittill("sounddone");
  var_0 delete();
}

chase_amb_under_bridge_2() {
  common_scripts\utility::flag_wait("chase_under_bridge_2");
  thread bridge_jeep_by();
  thread bridge_jeeps_to_the_right();
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 scalevolume(0.1);
  wait 0.05;
  var_0 playLoopSound("clkw_scn_chase_under_bridge_2");
  var_0 scalevolume(1, 0.2);
  wait 1;
  var_0 scalevolume(0.562, 2);
  wait 0.4;
  level.player playSound("clkw_scn_chase_skid_player");
  wait 2.2;
  level.player playSound("clkw_scn_chase_skid_player");
  wait 5;
  level.player playSound("clkw_scn_chase_skid_player");
  common_scripts\utility::flag_wait("chase_under_bridge_3");
  var_0 maps\_utility::sound_fade_and_delete(2);
}

bridge_jeep_by() {
  wait 1;
  var_0 = spawn("script_origin", (15959, 3132, 273));
  var_1 = (15300, 4213, 273);
  var_0 playSound("clkw_scn_chase_bridge_jeep_by", "sounddone");
  wait 1.25;
  var_0 moveto(var_1, 0.8);
  var_0 waittill("sounddone");
  var_0 delete();
}

bridge_jeeps_to_the_right() {
  wait 2;
  var_0 = spawn("script_origin", (14058, 4127, 273));
  var_1 = (15625, 4386, 273);
  var_2 = (18420, 6547, 273);
  var_3 = (19251, 9325, 273);
  var_0 playSound("clkw_scn_chase_jeeps_right", "sounddone");
  var_0 moveto(var_1, 3);
  wait 3;
  var_0 moveto(var_2, 4);
  wait 4;
  var_0 moveto(var_3, 4);
  var_0 waittill("sounddone");
  var_0 delete();
}

chase_amb_under_bridge_3() {
  common_scripts\utility::flag_wait("chase_under_bridge_3");
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 scalevolume(0.1);
  wait 0.05;
  var_0 playLoopSound("clkw_scn_chase_under_bridge_3");
  var_0 scalevolume(1, 0.2);
  wait 1.5;
  level.player playSound("clkw_scn_chase_skid_player");
  common_scripts\utility::flag_wait("chase_enter_chasm");
  var_0 maps\_utility::sound_fade_and_delete(2);
}

chase_amb_enter_chasm() {
  common_scripts\utility::flag_wait("chase_enter_chasm");
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 scalevolume(0.1);
  wait 0.05;
  var_0 playLoopSound("clkw_scn_chase_enter_chasm");
  var_0 scalevolume(1, 0.2);
  common_scripts\utility::flag_wait("chase_tight_spot");
  var_0 maps\_utility::sound_fade_and_delete(2);
}

chase_amb_tight_spot() {
  common_scripts\utility::flag_wait("chase_tight_spot");
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 scalevolume(0.1);
  wait 0.05;
  var_0 playLoopSound("clkw_scn_chase_tight_spot");
  var_0 scalevolume(1, 0.2);
  wait 1.6;
  level.player playSound("clkw_scn_chase_skid_player");
  common_scripts\utility::flag_wait("chase_under_bridge_4");
  var_0 maps\_utility::sound_fade_and_delete(2);
}

chase_amb_under_bridge_4() {
  common_scripts\utility::flag_wait("chase_under_bridge_4");
  thread submarine_rise();
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 scalevolume(0.1);
  wait 0.05;
  var_0 playLoopSound("clkw_scn_chase_under_bridge_4");
  var_0 scalevolume(1, 0.2);
  thread dip_ambience(var_0);
  common_scripts\utility::flag_wait("chase_sub_comes_up");
  level.player playSound("clkw_scn_submarine_jeep_stop");
  wait 3;
  var_0 maps\_utility::sound_fade_and_delete(2);
  wait 3.5;
  level.player playSound("clkw_amb_end_gusts");
}

dip_ambience(var_0) {
  wait 4.3;
  var_0 scalevolume(0, 1);
  wait 4.7;
  var_0 scalevolume(1, 2);
}

chase_amb_sub_comes_up() {
  common_scripts\utility::flag_wait("chase_sub_comes_up");
  thread snow_spray();
}

submarine_rise() {
  wait 2.5;
  level.player setclienttriggeraudiozone("chase_sub_breach");
  wait 1.5;
  level.player playSound("clkw_scn_submarine_ice_chunks_02", (34247, 19655, 681));
  thread sub_breach_ice_chunks();
  wait 4.4;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_submarine_proto", (35697, 21236, 399));
  wait 0.6;
  level.player clearclienttriggeraudiozone(1);
  thread common_scripts\utility::play_sound_in_space("clkw_scn_submarine_rise", (34640, 20204, 681));
  wait 1;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_submarine_rise_lyr2", (35228, 20734, 681));
}

sub_breach_ice_chunks() {
  thread common_scripts\utility::play_sound_in_space("clkw_scn_submarine_breach_01", (35204, 21388, 681));
  wait 0.5;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_submarine_breach_02", (35200, 20415, 681));
  wait 0.7;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_submarine_breach_03", (34889, 18522, 681));
  wait 0.8;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_submarine_breach_04", (36476, 21402, 681));
  wait 0.3;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_sub_breach_boom_ly2", (34075, 19528, 681));
  wait 0.8;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_submarine_breach_01", (36410, 22123, 681));
  wait 0.5;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_submarine_breach_04", (34575, 20001, 826));
  wait 0.8;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_submarine_breach_03", (34759, 20361, 681));
  wait 0.3;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_submarine_breach_01", (35986, 21630, 681));
  wait 0.3;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_submarine_breach_03", (34947, 20497, 681));
  wait 0.3;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_submarine_breach_02", (33576, 19010, 681));
  wait 0.7;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_submarine_breach_04", (34003, 20768, 681));
}

snow_spray() {
  common_scripts\utility::flag_wait("chase_sub_comes_up");
  wait 2.5;
  level.player playSound("clkw_scn_sub_breach_crack_close");
  wait 1.5;
  level.player playSound("clkw_scn_jeep_snow_spray");
}

chase_music() {
  common_scripts\utility::flag_wait("chase_sub_comes_up");
  thread end_jumpout();
  thread end_fade();
  wait 3.1;
  maps\_utility::music_crossfade("mus_clock_outro", 0.25);
  wait 3;
}

chase_stinger_music() {
  thread maps\_utility::music_crossfade("mus_clock_chase_stinger", 2.5);
}

end_jumpout() {
  wait 7.3;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_end_keegan_exit_jeep", (34275, 19726, 547));
  wait 0.3;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_end_cypher_exit_jeep", (34247, 19687, 547));
  wait 0.2;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_end_baker_exit_jeep", (34282, 19693, 547));
  wait 0.2;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_end_latch_open", (34284, 19748, 547));
  wait 0.2;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_end_latch_open", (34276, 19671, 547));
  wait 0.3;
  thread common_scripts\utility::play_sound_in_space("clkw_scn_end_latch_open", (34252, 19670, 547));
  wait 1.5;
  level.player playSound("clkw_scn_end_jumpout");
}

end_fade() {
  wait 10.8;
  level notify("cut_on_end");
  wait 5;
  level.player setclienttriggeraudiozone("end_fade");
}
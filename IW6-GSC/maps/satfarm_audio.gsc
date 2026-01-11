/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\satfarm_audio.gsc
*****************************************************/

main() {
  thread aud_init_globals();
  thread aud_init_flags();
  thread aud_ignore_timescale();
}

aud_init_globals() {
  level.bdamagesoundplaying = 0;
  level.bdeathsoundplaying = 0;
  level.bplrpostsoundplaying = 0;
  level.bnpcpostsoundplaying = 0;
  level.bgazcrushsndplaying = 0;
  level.bthermalon = 0;
  level.btankmoving = 0;
  level.bsprinton = 0;
  level.bwalldestroyedsoundplayed = 0;
  level.bwalldestroyed = 0;
  level.tank_sound_pitch = 0.8;
}

aud_init_flags() {
  common_scripts\utility::flag_init("tow_cam_sound_off");
  common_scripts\utility::flag_init("aud_cargo_doors_open");
  common_scripts\utility::flag_init("aud_tank_drop");
  common_scripts\utility::flag_init("aud_tank_destroyed");
  common_scripts\utility::flag_init("tank_landed");
  common_scripts\utility::flag_init("above_ground");
  common_scripts\utility::flag_init("below_ground");
  common_scripts\utility::flag_init("aud_move_to_tank_hud");
  common_scripts\utility::flag_init("aud_enter_hangar");
  common_scripts\utility::flag_init("aud_tank_rubble");
  common_scripts\utility::flag_init("aud_exfil");
}

aud_ignore_timescale() {
  soundsettimescalefactor("norestrict2d", 0);
  soundsettimescalefactor("auto", 0);
  soundsettimescalefactor("voice", 0);
  soundsettimescalefactor("effects2d1", 0);
  soundsettimescalefactor("effects2d2", 0);
}

checkpoint_crash_site() {
  level.player setclienttriggeraudiozone("tank");
  maps\_utility::music_play("mus_sfarm_tank_combat1");
}

checkpoint_base_array() {
  level.player setclienttriggeraudiozone("tank");
}

checkpoint_air_strip() {
  level.player setclienttriggeraudiozone("tank");
}

checkpoint_air_strip_secured() {
  level.player setclienttriggeraudiozone("exterior");
}

checkpoint_tower() {
  level.player setclienttriggeraudiozone("exterior");
}

satfarm_intro() {
  wait 0.5;
  level.player setclienttriggeraudiozone("intro_cargo");
  thread cargo_amb();
  wait 0.5;
  thread intro_shrapnel();
  thread intro_shake1();
  thread intro_shake2();
  thread wind_amb();
  common_scripts\utility::flag_wait("aud_move_to_tank_hud");
  common_scripts\utility::flag_wait("tank_landed");
  maps\_utility::music_play("mus_sfarm_tank_combat1");
}

cargo_amb() {
  common_scripts\utility::flag_wait("aud_move_to_tank_hud");
  wait 0.75;
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 playLoopSound("satf_amb_intro_jet");
  thread jet_whine();
  common_scripts\utility::flag_wait("aud_cargo_doors_open");
  var_0 maps\_utility::sound_fade_and_delete(5);
  common_scripts\utility::flag_wait("aud_tank_drop");
  level.player setclienttriggeraudiozone("intro_drop");
}

jet_whine() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 playSound("satf_intro_turbine_whine");
  common_scripts\utility::flag_wait("aud_cargo_doors_open");
  var_0 maps\_utility::sound_fade_and_delete(5);
}

intro_shrapnel() {
  common_scripts\utility::flag_wait("aud_move_to_tank_hud");
  wait 2;
  level.player playSound("satf_intro_shrapnel_01");
  wait 4.1;
  level.player playSound("satf_intro_shrapnel_02");
  wait 4.75;
  level.player playSound("satf_intro_shrapnel_03");
  wait 1.75;
  level.player playSound("satf_intro_shrapnel_04");
  wait 5.5;
  level.player playSound("satf_intro_shrapnel_05");
  wait 3.5;
  level.player playSound("satf_intro_shrapnel_06");
}

intro_shake1() {
  common_scripts\utility::flag_wait("aud_move_to_tank_hud");
  wait 2;
  thread common_scripts\utility::play_sound_in_space("satf_intro_shake", level.player.origin);
}

intro_shake2() {
  common_scripts\utility::flag_wait("aud_move_to_tank_hud");
  wait 9;
  thread common_scripts\utility::play_sound_in_space("satf_intro_shake", level.player.origin);
}

intro_rumble() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 maps\_utility::sound_fade_in("satf_intro_rumble", 1, 8, 1);
  common_scripts\utility::flag_wait("aud_tank_drop");
  var_0 maps\_utility::sound_fade_and_delete(1);
}

bullet_holes1() {
  thread common_scripts\utility::play_sound_in_space("satf_intro_shake", level.player.origin);
  var_0 = spawn("script_origin", (-47294, 1750, 1228));
  var_1 = (-47084, 1516, 1158);
  var_0 playSound("satf_bullet_holes_1", "sounddone");
  var_0 moveto(var_1, 1.5);
  thread aud_intro_alarms();
  var_0 waittill("sounddone");
  var_0 delete();
  wait 4;
  thread bullet_holes2();
}

bullet_holes2() {
  thread common_scripts\utility::play_sound_in_space("satf_bullet_holes_2", level.player.origin);
}

bullet_holes3() {
  thread aud_engine_fail();
  var_0 = spawn("script_origin", (-44945, 1334, 1230));
  var_1 = (-44866, 1095, 1230);
  var_0 playSound("satf_bullet_holes_3", "sounddone");
  var_0 moveto(var_1, 1.5);
  var_0 waittill("sounddone");
  var_0 delete();
}

end_missile_launch_alarm() {
  wait 0.5;
  var_0 = spawn("script_origin", (-5011, 54683, 463));
  var_0 playLoopSound("satf_end_missile_alarm");
  common_scripts\utility::flag_wait("missile_launched");
  wait 0.5;
  var_0 maps\_utility::sound_fade_and_delete(2);
}

end_missile_launch_hatch() {
  thread common_scripts\utility::play_sound_in_space("satf_end_missile_hatch", (-6199, 55839, 157));
}

aud_engine_fail() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 playSound("satf_engine_fail");
  common_scripts\utility::flag_wait("tank_landed");
  var_0 maps\_utility::sound_fade_and_delete(0.2);
}

wind_amb() {
  common_scripts\utility::flag_wait("aud_tank_drop");
}

tank_drop() {
  thread tank_drop_jet_center();
  thread drop_layer2();
  thread tank_drop_player();
  thread tank_drop_jet_left();
  thread tank_drop_jet_right();
  thread intro_explosion();
  thread tank_drop_slide_allies();
  thread tank_drop_fighter_1();
  thread tank_drop_fighter_2();
  thread intro_explosion2();
}

tank_drop_player() {
  var_0 = spawn("script_origin", (0, 0, 0));
  wait 2.1;
  thread common_scripts\utility::play_sound_in_space("satf_intro_death_fall", (-26278, -18137, 1713));
  wait 2.1;
  var_0 playSound("satf_tank_drop_slide_plr", "sounddone");
  common_scripts\utility::flag_set("tank_landed");
  wait 0.2;
  level.player setclienttriggeraudiozone("tank");
  wait 1.8;
  thread common_scripts\utility::play_sound_in_space("satf_tank_drop_turbine", level.player.origin);
  var_0 waittill("sounddone");
  var_0 delete();
}

tank_drop_jet_center() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 playSound("satf_tank_drop_jet_center");
  common_scripts\utility::flag_wait("tank_landed");
  var_0 maps\_utility::sound_fade_and_delete(0.2);
}

drop_layer2() {
  thread common_scripts\utility::play_sound_in_space("satf_intro_drop_layer2", level.player.origin);
}

tank_drop_jet_left() {
  wait 0.5;
  var_0 = spawn("script_origin", (-29525, -23227, 1189));
  var_1 = (-29502, -6641, 2025);
  var_0 playSound("satf_tank_drop_jet_left", "sounddone");
  var_0 moveto(var_1, 9.25);
  var_0 waittill("sounddone");
  var_0 delete();
}

tank_drop_jet_right() {
  wait 4;
  var_0 = spawn("script_origin", (-26803, -20129, 1138));
  var_1 = (-24412, -2417, 3214);
  var_0 playSound("satf_tank_drop_jet_right", "sounddone");
  var_0 moveto(var_1, 8);
  var_0 waittill("sounddone");
  var_0 delete();
}

intro_explosion() {
  wait 7.85;
  thread common_scripts\utility::play_sound_in_space("satf_intro_explosion", (-27177, -14460, 1117));
}

intro_explosion2() {
  wait 19.3;
  thread common_scripts\utility::play_sound_in_space("satf_intro_explosion", (-25957, -1208, 1192));
}

tank_drop_slide_allies() {
  wait 8;
  thread common_scripts\utility::play_sound_in_space("satf_tank_drop_slide_allies", (-26793, -17658, 951));
}

tank_drop_fighter_1() {
  wait 15.5;
  var_0 = spawn("script_origin", (-30074, -24011, 1806));
  var_1 = (-25836, -110, 1767);
  var_0 playSound("satf_tank_drop_fighter_1", "sounddone");
  var_0 moveto(var_1, 3);
  var_0 waittill("sounddone");
  var_0 delete();
}

tank_drop_fighter_2() {
  wait 13.5;
  var_0 = spawn("script_origin", (-29537, -24954, 2181));
  var_1 = (-25414, -4713, 2962);
  var_0 playSound("satf_tank_drop_fighter_2", "sounddone");
  var_0 moveto(var_1, 3);
  var_0 waittill("sounddone");
  var_0 delete();
}

tow_missile_launch() {
  var_0 = spawn("script_origin", (0, 0, 0));
  level.player setclienttriggeraudiozone("tow_missile");
  var_0 playSound("satf_tow_launch");
  var_0 playSound("satf_tow_camera");
  common_scripts\utility::flag_wait("tow_cam_sound_off");
  level.player setclienttriggeraudiozone("tank");
  var_0 maps\_utility::sound_fade_and_delete(0.1);
  wait 0.5;
  thread common_scripts\utility::play_sound_in_space("satf_tank_gun_reload", level.player.origin);
}

tow_missile_explode(var_0) {
  wait 0.25;
  thread common_scripts\utility::play_sound_in_space("satf_tow_explosion", var_0);
  common_scripts\utility::flag_clear("tow_cam_sound_off");
}

gaz_crush(var_0) {
  if(level.bgazcrushsndplaying == 0) {
    level.bgazcrushsndplaying = 1;

    if(!common_scripts\utility::flag("aud_exfil")) {
      thread common_scripts\utility::play_sound_in_space("satf_tank_metal_crush", var_0);
    } else {
      thread common_scripts\utility::play_sound_in_space("satf_tank_metal_crush_small", var_0);
    }

    wait 0.3;
    level.bgazcrushsndplaying = 0;
  }
}

a10_crash_approach() {
  var_0 = spawn("script_origin", (-20490, 48120, 3125));
  var_1 = (-6317, 37717, 698);
  var_0 playSound("satf_hangar_a10_incoming", "sounddone");
  var_0 moveto(var_1, 2.75);
  var_0 waittill("sounddone");
  var_0 delete();
}

a10_crash_impact() {
  thread hangar_wall_debris();
  thread common_scripts\utility::play_sound_in_space("satf_hangar_a10_impact", (-6971, 37569, 633));
  wait 1;
  thread common_scripts\utility::play_sound_in_space("satf_hangar_tower_collapse", (-6317, 37717, 698));
  wait 0.5;
  thread common_scripts\utility::play_sound_in_space("satf_hangar_a10_impact_debris", (-9301, 35535, 128));
  wait 2;
  thread common_scripts\utility::play_sound_in_space("satf_hangar_tower_collapse_debris", (-6800, 39555, 498));
}

hangar_wall_shot(var_0) {
  if(level.bwalldestroyedsoundplayed == 0) {
    level.bwalldestroyedsoundplayed = 1;
    thread common_scripts\utility::play_sound_in_space("satf_concrete_barrier_shot", var_0);
  }
}

hangar_wall_debris() {
  common_scripts\utility::flag_wait("aud_enter_hangar");

  if(!level.bwalldestroyed) {
    thread common_scripts\utility::play_sound_in_space("satf_concrete_barrier_crush_plr_lyr2", level.player.origin);
  }
}

walldowncheck() {
  level.bwalldestroyed = 1;
}

overlord_trans1() {
  wait 0.2;
  level.player setclienttriggeraudiozone("overlord");
  wait 1.5;
  common_scripts\utility::flag_wait("chopper_flyin_begin");
  level.player setclienttriggeraudiozone("heli_interior");
  common_scripts\utility::flag_wait("start_jump");
  wait 3.2;
  thread common_scripts\utility::play_sound_in_space("satf_tower_dropoff_heli_away", (-3930, 52511, 512));
  wait 0.3;
  level.player clearclienttriggeraudiozone(1);
}

tower_jump() {
  wait 0.5;
  thread common_scripts\utility::play_sound_in_space("satf_tower_jump", level.player.origin);
}

tower_windows() {
  var_0 = spawn("script_origin", (-5693, 52142, 470));
  var_1 = spawn("script_origin", (-4268, 51716, 470));
  var_2 = spawn("script_origin", (-3185, 52760, 470));
  var_0 maps\_utility::sound_fade_in("satf_tower_windows_1", 1, 2, 1);
  var_1 maps\_utility::sound_fade_in("satf_tower_windows_2", 1, 2, 1);
  var_2 maps\_utility::sound_fade_in("satf_tower_windows_3", 1, 2, 1);
}

elevator() {
  thread common_scripts\utility::play_sound_in_space("satf_elevator_gate_close", (-5173, 54719, -179));
  wait 2;
  thread common_scripts\utility::play_sound_in_space("satf_elevator", level.player.origin);
  thread common_scripts\utility::play_sound_in_space("satf_warehouse_train_stop", (-5960, 57055, -383));
  common_scripts\utility::flag_wait("elevator_landed");
  thread common_scripts\utility::play_sound_in_space("satf_elevator_gate_open", (-5295, 55088, -622));
}

fire_ext_grab() {
  wait 2;
  thread common_scripts\utility::play_sound_in_space("satf_tower_door_fire_ext_grab", (-5150, 53503, 268));
}

tower_door_listen() {
  var_0 = spawn("script_origin", (-5233, 53557, 268));
  var_0 maps\_utility::sound_fade_in("satf_tower_door_breach_listen", 1, 1, 1);
  common_scripts\utility::flag_wait("breach_start");
  wait 2;
  var_0 maps\_utility::sound_fade_and_delete(0.5);
}

tower_door_listen_2() {
  wait 0.5;

  if(!common_scripts\utility::flag("breach_start")) {
    thread common_scripts\utility::play_sound_in_space("satf_tower_door_breach_listen_2", (-5233, 53557, 268));
  }
}

tower_door_breach() {
  thread fire_ext_throw();
  thread common_scripts\utility::play_sound_in_space("satf_tower_door_breach_kick", level.player.origin);
  thread common_scripts\utility::play_sound_in_space("satf_tower_door_breach", level.player.origin);
  thread tower_door_pitchfx();
  wait 1;
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 playSound("satf_tower_door_breach_layer2");
  level waittill("slowmo_breach_ending");
  var_0 maps\_utility::sound_fade_and_delete(2);
}

fire_ext_throw() {
  wait 0.35;
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 playSound("satf_tower_door_fire_ext_throw");
  common_scripts\utility::flag_wait_either("player_shot_extinguisher", "ghost1_shot_extinguisher");
  var_0 maps\_utility::sound_fade_and_delete(1);
}

tower_door_pitchfx() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 playSound("satf_tower_door_breach_pitchfx");
  level waittill("slowmo_breach_ending");
  var_0 maps\_utility::sound_fade_and_delete(2);
  thread post_breach_positional_ambience();
}

post_breach_positional_ambience() {
  thread tower_wreckage();
  thread tower_distant_combat();
  thread tower_a10_flyby();
  thread tower_a10_strafe_1();
  thread tower_a10_strafe_2();
  thread tower_command_table();
  thread tower_falling_debris();
  thread tower_distant_choppers();
}

tower_door_explosion() {
  thread common_scripts\utility::play_sound_in_space("satf_tower_door_breach_explosion", level.player.origin);
}

tower_wreckage() {
  var_0 = spawn("script_origin", (-5194, 54363, 349));
  var_0 maps\_utility::sound_fade_in("satf_tower_wreckage", 1, 2, 1);
}

tower_distant_combat() {
  var_0 = spawn("script_origin", (-4797, 54894, 268));
  var_0 maps\_utility::sound_fade_in("satf_tower_distant_combat", 1, 2, 1);
  common_scripts\utility::flag_wait("warehouse_begin");
  var_0 maps\_utility::sound_fade_and_delete(3);
}

tower_a10_flyby() {
  common_scripts\utility::flag_wait("start_breach_outside_ambience");
  wait 9;
  var_0 = spawn("script_origin", (14496, 66235, 1380));
  var_1 = (-22083, 56416, 1380);
  var_0 playSound("satf_tower_jets_by", "sounddone");
  var_0 moveto(var_1, 6);
  wait 3;
  var_0 waittill("sounddone");
  var_0 delete();
}

tower_a10_strafe_1() {
  common_scripts\utility::flag_wait("start_breach_outside_ambience");
  wait 9;
  var_0 = spawn("script_origin", (14496, 66235, 1380));
  var_1 = (-22083, 56416, 1380);
  var_0 moveto(var_1, 6);
  wait 1.5;
  var_0 playSound("satf_a10_tower_strafe_1", "sounddone");
  var_0 waittill("sounddone");
  var_0 delete();
}

tower_a10_strafe_2() {
  common_scripts\utility::flag_wait("start_breach_outside_ambience");
  wait 9;
  var_0 = spawn("script_origin", (14496, 66235, 1380));
  var_1 = (-22083, 56416, 1380);
  var_0 moveto(var_1, 6);
  wait 2;
  var_0 playSound("satf_a10_tower_strafe_2", "sounddone");
  var_0 waittill("sounddone");
  var_0 delete();
  wait 2;
  thread tower_a10_strafe_3();
}

tower_a10_strafe_3() {
  thread common_scripts\utility::play_sound_in_space("satf_a10_tower_strafe_2", (-22083, 56416, 1380));
}

tower_distant_choppers() {
  wait 10;
  thread common_scripts\utility::play_sound_in_space("satf_tower_distant_choppers", (-9678, 57330, 269));
}

tower_command_table() {
  thread common_scripts\utility::play_loopsound_in_space("satf_command_table", (-4907, 53783, 266));
}

tower_command_table_typing() {
  wait 2;
  thread common_scripts\utility::play_sound_in_space("satf_command_table_typing", (-4927, 53831, 258));
}

tower_falling_debris() {
  thread common_scripts\utility::play_sound_in_space("satf_tower_falling_debris", (-5081, 53876, 349));
  thread common_scripts\utility::play_sound_in_space("satf_tower_falling_debris", (-5388, 53815, 349));
  wait 0.1;
  thread common_scripts\utility::play_sound_in_space("satf_tower_falling_debris", (-4951, 53893, 349));
  wait 0.2;
  thread common_scripts\utility::play_sound_in_space("satf_tower_falling_debris", (-5081, 53876, 349));
  wait 0.5;
  thread common_scripts\utility::play_sound_in_space("satf_tower_falling_debris", (-5388, 53815, 349));
  var_0 = 1;

  while(!common_scripts\utility::flag("missile_launch_start")) {
    wait(var_0);
    var_0++;
    thread common_scripts\utility::play_sound_in_space("satf_tower_falling_debris", (-5194, 54363, 349));
  }
}

launch_button() {
  wait 0.3;
  thread common_scripts\utility::play_sound_in_space("satf_launch_button", level.player.origin);
  wait 1;
  maps\_utility::music_play("mus_sfarm_rocket_launch");
}

train_leaving() {
  var_0 = spawn("script_origin", (-5089, 57586, -620));
  var_1 = spawn("script_origin", (-7525, 56839, -620));
  var_2 = (-3928, 58025, -620);
  var_3 = (-4634, 57776, -620);
  var_0 playSound("satf_warehouse_train_start_front");
  var_1 playSound("satf_warehouse_train_start_rear");
  var_0 moveto(var_2, 23, 5);
  var_1 moveto(var_3, 23, 5);
}

overlord_trans2() {
  wait 0.6;
  level.player setclienttriggeraudiozone("overlord");
  wait 18;
  level.player setclienttriggeraudiozone("exterior");
  common_scripts\utility::waitframe();
  level.player clearclienttriggeraudiozone(1);
}

thermal() {
  level.bthermalon = 1;
  level.player playSound("satf_change_view_thermal");
  level.player setclienttriggeraudiozone("thermal");
  level.player common_scripts\utility::waittill_any("thermal", "tank_dismount", "thermal_off", "missile_tank_dismount");
  level.bthermalon = 0;
  level.player playSound("satf_change_view_normal");
  level.player setclienttriggeraudiozone("tank");
}

player_tank_sounds() {
  thread player_tank_turret_sounds();
  thread player_tank_driving_sound();
  thread player_acceleration_sounds();
  thread player_tank_impeded_sound();
}

player_tank_driving_sound() {
  var_0 = spawn("script_origin", (0, 0, 0));
  level.tank_sound_pitch = 0.8;
  var_0 playLoopSound("satf_tank_move");

  while(common_scripts\utility::flag("player_in_tank") && !common_scripts\utility::flag("aud_tank_destroyed")) {
    var_1 = level.left_stick[0];
    var_2 = level.left_stick[1];
    var_3 = level.playertank vehicle_getspeed();

    if(var_3 > 0) {
      level.tank_sound_pitch = 0.8 + 0.2 * (var_3 / 50);
    }

    if(var_1 < 0) {
      var_1 = var_1 - var_1 * 2;
    }

    if(var_2 < 0) {
      var_2 = var_2 - var_2 * 2;
    }

    if(var_1 > 0.05 || var_2 > 0.05) {
      var_4 = var_1 + var_2;

      if(var_4 > 1) {
        var_4 = 1;
      }

      var_0 scalevolume(var_4, 0.2);
    } else
      var_0 scalevolume(0, 2);

    var_0 scalepitch(level.tank_sound_pitch, 0.2);
    wait 0.5;
  }

  if(isDefined(var_0)) {
    var_0 maps\_utility::sound_fade_and_delete(0.2);
  }
}

player_tank_impeded_sound() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 playLoopSound("satf_tank_impeded");
  var_0 scalevolume(0);
  var_1 = 0;

  while(common_scripts\utility::flag("player_in_tank") && !common_scripts\utility::flag("aud_tank_destroyed")) {
    var_2 = level.left_stick[0];
    var_3 = level.left_stick[1];
    var_4 = level.playertank vehicle_getspeed();

    if(var_2 < 0) {
      var_2 = var_2 - var_2 * 2;
    }

    if(var_3 < 0) {
      var_3 = var_3 - var_3 * 2;
    }

    var_5 = var_2 + var_3;

    if(var_5 > 0.8 && var_4 < 10 && var_1 == 0) {
      var_1 = 1;
      var_0 scalevolume(0.5, 0);
      common_scripts\utility::waitframe();
      var_0 scalevolume(1, 0.3);
    }

    if(common_scripts\utility::flag("aud_tank_rubble") && var_4 > 10) {
      var_1 = 1;
      var_0 scalevolume(1);
    } else if(var_4 >= 30 && var_1 == 1 || var_5 <= 0.8 && var_1 == 1) {
      var_1 = 0;
      var_0 scalevolume(0, 2);
    }

    wait 0.05;
  }

  if(isDefined(var_0)) {
    var_0 maps\_utility::sound_fade_and_delete(0.2);
  }
}

player_tank_turret_sounds() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_1 = spawn("script_origin", (0, 0, 0));
  var_2 = spawn("script_origin", (0, 0, 0));
  var_3 = spawn("script_origin", (0, 0, 0));
  level.x_turretcheck = 0;
  level.y_turretcheck = 0;
  var_4 = 1;
  var_5 = 1;
  var_6 = 1;
  var_7 = 1;
  var_8 = 1;

  while(common_scripts\utility::flag("player_in_tank") && !common_scripts\utility::flag("aud_tank_destroyed")) {
    if(level.bthermalon == 1) {
      level.player setclienttriggeraudiozone("thermal");
    } else {
      level.player clearclienttriggeraudiozone(1);
    }

    var_9 = level.player getnormalizedcameramovement();
    level.left_stick = level.player getnormalizedmovement();
    var_10 = var_9[0];
    var_11 = var_9[1];
    var_12 = level.left_stick[0];
    var_13 = level.left_stick[1];

    if(var_12 < -0.2 || var_12 > 0.2 || (var_13 < -0.2 || var_13 > 0.2)) {
      var_4 = 0.5;
      var_14 = 0.5;
      var_6 = 0.5;
      var_7 = 1;
      var_8 = 1;
    } else {
      if(var_10 < -0.9 || var_10 > 0.9) {
        var_14 = 1;
        var_8 = 1.5;
      } else {
        var_14 = 0.5;
        var_8 = 1;
      }

      if(var_11 < -0.9 || var_11 > 0.9) {
        var_4 = 1;
        var_7 = 1.5;
      } else {
        var_4 = 0.5;
        var_7 = 1;
      }

      var_6 = 1;
    }

    var_0 scalevolume(var_14, 0.1);
    var_1 scalevolume(var_4, 0.1);
    var_2 scalevolume(var_6, 0.1);
    var_3 scalevolume(var_6, 0.1);
    var_0 scalepitch(var_8, 0.1);
    var_1 scalepitch(var_7, 0.1);

    if((var_10 < -0.05 || var_10 > 0.05) && level.x_turretcheck != 1) {
      level.x_turretcheck = 1;
      var_0 playLoopSound("satf_tank_turret_spin_v");
    }

    if((var_11 < -0.05 || var_11 > 0.05) && level.y_turretcheck != 1) {
      level.y_turretcheck = 1;
      var_1 playLoopSound("satf_tank_turret_spin_h");
      var_3 playSound("satf_tank_turret_start");
    }

    if(var_10 >= -0.05 && var_10 <= 0.05) {
      level.x_turretcheck = 0;
      var_0 stoploopsound("satf_tank_turret_spin_v");
    }

    if(var_11 >= -0.05 && var_11 <= 0.05) {
      if(level.y_turretcheck == 1) {
        var_2 playSound("satf_tank_turret_stop");
      }

      level.y_turretcheck = 0;
      wait 0.05;
      var_1 stoploopsound("satf_tank_turret_spin_h");
    }

    wait 0.05;
  }

  if(isDefined(var_0)) {
    var_0 delete();
  }

  if(isDefined(var_1)) {
    var_1 delete();
  }

  if(isDefined(var_2)) {
    var_2 delete();
  }

  if(isDefined(var_3)) {
    var_3 delete();
  }
}

player_acceleration_sounds() {
  thread player_acceleration_low();
  thread player_acceleration_high();
}

player_acceleration_low() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_1 = 0;

  while(common_scripts\utility::flag("player_in_tank") && !common_scripts\utility::flag("aud_tank_destroyed")) {
    var_2 = level.left_stick[0];
    var_3 = level.left_stick[1];

    if(var_2 < -0.1 || var_2 > 0.1 || (var_3 < -0.1 || var_3 > 0.1)) {
      level.btankmoving = 1;
      var_1 = 0;
      var_0 scalevolume(1, 0);
      common_scripts\utility::waitframe();
      var_0 playSound("satf_tank_accelerate");

      while(var_2 < -0.1 || var_2 > 0.1 || (var_3 < -0.1 || var_3 > 0.1)) {
        common_scripts\utility::waitframe();
        var_2 = level.left_stick[0];
        var_3 = level.left_stick[1];
      }
    }

    if(var_2 > -0.1 && var_2 < 0.1 && (var_3 > -0.1 && var_3 < 0.1) && var_1 == 0) {
      level.btankmoving = 0;
      var_1 = 1;
      thread common_scripts\utility::play_sound_in_space("satf_tank_decelerate", level.player.origin);
      var_0 scalevolume(0, 0.5);
      wait 0.5;
      var_0 stopsounds();
    }

    var_0 scalepitch(level.tank_sound_pitch, 0.2);
    common_scripts\utility::waitframe();
  }

  var_0 delete();
  level.btankmoving = 0;
}

cleanup_ent_on_dismount(var_0) {
  level endon("player_acceleration_high_end");
  level.player common_scripts\utility::waittill_either("tank_dismount", "missile_tank_dismount");
  var_0 delete();
}

player_acceleration_high() {
  level.player endon("tank_dismount");
  level.player endon("missile_tank_dismount");
  var_0 = spawn("script_origin", (0, 0, 0));
  thread cleanup_ent_on_dismount(var_0);

  while(common_scripts\utility::flag("player_in_tank") && !common_scripts\utility::flag("aud_tank_destroyed")) {
    level.playertank waittill("veh_boost_activated");
    var_0 scalevolume(1, 0);
    common_scripts\utility::waitframe();

    if(level.btankmoving == 1) {
      level.bsprinton = 1;
      var_0 scalepitch(level.tank_sound_pitch, 0.2);
      var_0 playSound("satf_tank_sprint");
    }

    level.playertank waittill("veh_boost_deactivated");

    if(level.btankmoving == 1) {
      level.bsprinton = 0;
      var_0 scalepitch(level.tank_sound_pitch, 0.2);
    }

    var_0 scalevolume(0, 0.5);
    wait 0.5;
    var_0 stopsounds();
    common_scripts\utility::waitframe();
  }

  level notify("player_acceleration_high_end");
  var_0 delete();
}

reload() {
  wait 0.5;
  level.player playSound("satf_tank_gun_reload");
}

player_post_collision() {
  if(level.bplrpostsoundplaying == 0) {
    level.bplrpostsoundplaying = 1;
    thread common_scripts\utility::play_sound_in_space("satf_tank_collision_small_plr", level.player.origin);
    wait 0.2;
    level.bplrpostsoundplaying = 0;
  }
}

npc_post_collision(var_0) {
  if(level.bnpcpostsoundplaying == 0) {
    level.bnpcpostsoundplaying = 1;
    thread common_scripts\utility::play_sound_in_space("satf_tank_collision_npc", var_0);
    wait 0.2;
    level.bnpcpostsoundplaying = 0;
  }
}

chopper_death_player(var_0) {
  if(level.bdeathsoundplaying == 0) {
    if(isDefined(var_0)) {
      level.bdeathsoundplaying = 1;
      thread common_scripts\utility::play_sound_in_space("satf_tank_death_player", var_0);
      wait 0.5;
      thread common_scripts\utility::play_sound_in_space("satf_helicopter_explosion_debris", var_0);
    }

    level.bdeathsoundplaying = 0;
  }
}

tank_death_player(var_0) {
  if(level.bdeathsoundplaying == 0) {
    wait 0.1;

    if(isDefined(var_0)) {
      level.bdeathsoundplaying = 1;
      thread common_scripts\utility::play_sound_in_space("satf_tank_death_player", var_0);
    }

    wait 1;
    level.bdeathsoundplaying = 0;
  }
}

tank_damage_player(var_0) {
  if(level.bdamagesoundplaying == 0) {
    level.bdamagesoundplaying = 1;
    thread common_scripts\utility::play_sound_in_space("satf_tank_damage_player", var_0);
    wait 1;
    level.bdamagesoundplaying = 0;
  }
}

tank_death_allies(var_0) {
  if(level.bdeathsoundplaying == 0) {
    level.bdeathsoundplaying = 1;
    thread common_scripts\utility::play_sound_in_space("satf_tank_death_allies", var_0);
    wait 1;
    level.bdeathsoundplaying = 0;
  }
}

tank_damage_allies(var_0) {
  if(level.bdamagesoundplaying == 0) {
    level.bdamagesoundplaying = 1;
    thread common_scripts\utility::play_sound_in_space("satf_tank_damage_allies", var_0);
    wait 1;
    level.bdamagesoundplaying = 0;
  }
}

tower_ambient_explosions(var_0) {
  thread common_scripts\utility::play_sound_in_space("satf_tower_explosion", var_0);
  thread common_scripts\utility::play_sound_in_space("satf_building_shake_ly2", level.player.origin);
  wait(randomfloatrange(0.4, 0.7));
  thread common_scripts\utility::play_sound_in_space("satf_building_shake", var_0);
}

building_hit_moment() {
  thread common_scripts\utility::play_sound_in_space("satf_building_shake_large", level.player.origin);
  wait 2;
  thread common_scripts\utility::play_loopsound_in_space("satf_tower_sprinkler", (-4991, 54426, -145));
  thread common_scripts\utility::play_loopsound_in_space("satf_tower_sprinkler", (-5580, 54241, -145));
}

exit_tank_final() {
  level.player setclienttriggeraudiozone("exterior_foot");
}

complex_expl() {
  wait 0.1;
  var_0 = spawn("script_origin", (29552, 24086, 2668));
  wait 2.8;
  maps\_utility::music_play("satf_final");
  wait 1;
  var_0 playSound("satf_complex_expl_inc");
  wait 1.2;
  var_0 maps\_utility::sound_fade_and_delete(0.3);
  level.player playSound("satf_complex_expl_imp");
  level.player setclienttriggeraudiozone("rog_hit");
  wait 13;
}

aud_intro_tank_hud() {
  thread common_scripts\utility::play_sound_in_space("scn_satf_intro_tank_hud", level.player.origin);
  wait 0.5;
  level.player setclienttriggeraudiozone("intro_cargo", 0.3);
}

aud_intro_cargo_doors() {
  common_scripts\utility::flag_set("aud_cargo_doors_open");
  level.player setclienttriggeraudiozone("intro_cargo_doors_open");
  thread common_scripts\utility::play_sound_in_space("scn_satf_intro_doors", level.player.origin);
  wait 1;
  thread cargo_winds_front();
  thread cargo_winds_rear();
  wait 9.9;
  thread common_scripts\utility::play_sound_in_space("scn_satf_intro_tank_rollers", level.player.origin);
  wait 1.46;
  thread common_scripts\utility::play_sound_in_space("scn_satf_intro_parachute", level.player.origin);
  wait 1.5;
  thread common_scripts\utility::play_sound_in_space("satf_tank_para_deploy2", level.player.origin);
}

cargo_winds_front() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 playSound("scn_satf_intro_cargo_winds");
  common_scripts\utility::flag_wait("aud_tank_drop");
  var_0 maps\_utility::sound_fade_and_delete(1.2);
}

cargo_winds_rear() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 playSound("scn_satf_intro_cargo_winds_rear");
  common_scripts\utility::flag_wait("aud_tank_drop");
  var_0 maps\_utility::sound_fade_and_delete(1.2);
}

aud_intro_alarms() {
  wait 1;
  thread aud_play_loop_until_flag("scn_satf_intro_alarm_01", (-47075, 1557, 1287), "intro_end");
  thread aud_play_loop_until_flag("scn_satf_intro_alarm_02", (-47281, 1531, 1287), "intro_end");
}

aud_player_tank_int_on() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 playSound("satf_intro_tank_interior");
  level.player setclienttriggeraudiozone("intro_tank_int");
  common_scripts\utility::flag_wait("aud_move_to_tank_hud");
  thread common_scripts\utility::play_sound_in_space("scn_satf_intro_into_tank", level.player.origin);
  common_scripts\utility::flag_wait("aud_tank_drop");
  var_0 maps\_utility::sound_fade_and_delete(1);
}

intro_tank_foley() {
  wait 8.2;
  thread common_scripts\utility::play_sound_in_space("satf_intro_fist_bump", (-49530, 1115, 1305));
  wait 5.7;
  thread common_scripts\utility::play_sound_in_space("satf_tank_hud_cloth", level.player.origin);
}

intro_bins() {
  wait 11.5;
  thread common_scripts\utility::play_sound_in_space("satf_intro_cargo_bins", (-47181, 1635, 1201));
}

aud_play_loop_until_flag(var_0, var_1, var_2) {
  var_3 = spawn("script_origin", var_1);
  var_3 playLoopSound(var_0);
  common_scripts\utility::flag_wait(var_2);
  var_3 maps\_utility::sound_fade_and_delete(1);
  common_scripts\utility::waitframe();
  var_3 delete();
}
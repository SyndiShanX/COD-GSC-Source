/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\loki_audio.gsc
*****************************************************/

main() {
  soundsettimescalefactor("player1", 0);
  soundsettimescalefactor("weapon", 0);
  soundsettimescalefactor("bulletwhizbyin", 0);
  soundsettimescalefactor("bulletwhizbyout", 0);
  soundsettimescalefactor("effects2d1", 0);
  soundsettimescalefactor("body", 0);
  soundsettimescalefactor("ambient", 0);
  soundsettimescalefactor("hurt", 0);
  thread audio_set_default_ambience();
  level.connection_sound = spawn("script_origin", (0, 0, 0));
  level.play_connection_sound = 0;
  level.play_npc_deaths = 1;
  thread mission_music();
}

audio_flag_inits() {
  common_scripts\utility::flag_init("combat_one_music_start");
  common_scripts\utility::flag_init("combat_one_music_end");
  common_scripts\utility::flag_init("combat_two_music_start");
  common_scripts\utility::flag_init("combat_two_music_end");
  common_scripts\utility::flag_init("turn_off_creaks");
  common_scripts\utility::flag_init("fuel_line_first_fire");
  common_scripts\utility::flag_init("fuel_line_first_leak");
  common_scripts\utility::flag_init("fuel_line_bullet_gate");
}

audio_set_default_ambience() {
  level.space_breathing_enabled = 1;
  level.space_intense_breathing = 0;
  wait 0.1;
  level.player setclienttriggeraudiozone("loki_default", 2);
  level.player maps\_space_player::player_space_breathing();
}

audio_set_ending_ambience() {
  level.space_breathing_enabled = 1;
  level.space_intense_breathing = 0;
  wait 0.1;
  level.player setclienttriggeraudiozone("loki_rog_trans", 0.5);
  level.player maps\_space_player::player_space_breathing();
  wait 7;
  level.player setclienttriggeraudiozone("loki_default", 2);
}

audio_set_fadein_ambience() {
  level.space_breathing_enabled = 0;
  wait 0.15;
  level.player setclienttriggeraudiozone("loki_intro", 0.001);
}

audio_set_infil_ambience() {
  level.space_breathing_enabled = 1;
  level.space_intense_breathing = 0;
  wait 0.1;
  level.player maps\_space_player::player_space_breathing();
  thread sfx_loki_shuttle_zone();
}

mission_music() {
  wait 0.1;

  switch (level.start_point) {
    case "infil":
      maps\_utility::music_play("mus_loki_infil");
      common_scripts\utility::flag_wait("combat_one_music_start");
      wait 1.4;
    case "combat_one":
      maps\_utility::music_play("mus_loki_combat_01");
      common_scripts\utility::flag_wait("combat_one_music_end");
      maps\_utility::music_stop(2);
    case "combat_two":
    case "moving_cover":
      common_scripts\utility::flag_wait("combat_two_music_start");
      maps\_utility::music_play("mus_loki_combat_02");
    case "space_breach":
      common_scripts\utility::flag_wait("combat_two_music_end");
      wait 3.0;
      break;
    case "rog":
      maps\_utility::music_stop(0.6);
    case "ending":
    case "default":
  }
}

sfx_loki_breathing_logic(var_0) {
  wait 0.5;
  level.space_intense_breathing = var_0;
}

sfx_intro_load_weapon() {
  self playSound("scn_loki_intro_plr_breathing");
  level maps\_utility::delaythread(6.35, ::sfx_beginning_rog_fire);
  wait 0.25;
  self playSound("scn_loki_intro_load_weapon");
  wait 6.75;
  level.space_breathing_enabled = 1;
}

sfx_intro_seat_unlock() {
  self playSound("scn_loki_intro_shuttle_shake");
  wait 5.0;
  self playSound("scn_loki_intro_door_open");
  wait 5.0;
  self playSound("scn_loki_intro_seat_unlock_spin");
  wait 4.0;
  self playSound("scn_loki_intro_seat_unlock");
}

sfx_gas_line_fuel_burst(var_0) {
  var_0 playSound("scn_loki_gas_line_burst");
}

sfx_gas_line_fuel_leak(var_0) {
  wait 0.6;

  if(!common_scripts\utility::flag("fuel_line_first_leak")) {
    var_0 playSound("scn_loki_gas_line_fuel_leak");
    common_scripts\utility::flag_set("fuel_line_first_leak");
  } else if(!common_scripts\utility::flag("fuel_line_bullet_gate")) {
    common_scripts\utility::flag_set("fuel_line_bullet_gate");
    var_1 = 1;

    foreach(var_3 in level.bullet_caused_fuel_leaks) {
      if(distance(var_3.origin, var_0.origin) < 80 && distance(var_3.origin, var_0.origin) > 2) {
        if(var_3.is_on_fire == 0) {
          var_1 = 0;
          break;
        } else
          var_1 = 1;
      }
    }

    if(var_1 == 1) {
      var_0 playSound("scn_loki_gas_line_fuel_leak");
    }

    wait 0.5;
    common_scripts\utility::flag_clear("fuel_line_bullet_gate");
  }
}

sfx_gas_line_ignite(var_0) {
  var_0 playSound("scn_loki_gas_line_ignite");
}

sfx_gas_line_fire_lp(var_0, var_1) {
  if(!common_scripts\utility::flag("fuel_line_first_fire")) {
    common_scripts\utility::flag_set("fuel_line_first_fire");
    var_0 playLoopSound("scn_loki_gas_line_fire_lp");
  } else if(var_1 == 0) {
    var_2 = 1;
    var_3 = 0;

    foreach(var_5 in level.bullet_caused_fuel_leaks) {
      if(distance(var_5.origin, var_0.origin) < 160 && distance(var_5.origin, var_0.origin) > 2) {
        if(var_5.is_on_fire == 0) {
          if(var_3 == 0) {
            var_2 = 0;
            var_3 = 1;
          }

          continue;
        }

        thread sfx_gas_line_stop_fire(var_5);

        if(var_3 == 0) {
          var_2 = 1;
        }
      }
    }

    if(var_2 == 1) {
      var_0 playLoopSound("scn_loki_gas_line_fire_lp");

      if(var_1) {
        thread sfx_gas_line_cull_fire(var_0);
      }
    }
  }
}

sfx_gas_line_cull_fire(var_0) {
  wait 1;

  if(isDefined(var_0)) {
    foreach(var_2 in level.bullet_caused_fuel_leaks) {
      if(distance(var_2.origin, var_0.origin) < 160) {
        if(var_2.is_on_fire) {
          var_2 stoploopsound("scn_loki_gas_line_fire_lp");
          continue;
        }

        thread sfx_gas_line_stop_fire(var_2);
      }
    }
  }
}

sfx_gas_line_stop_fire(var_0) {
  wait 0.6;

  if(isDefined(var_0)) {
    var_0 stoploopsound("scn_loki_gas_line_fire_lp");
  }
}

sfx_gas_line_stop_sfx(var_0) {
  var_0 stoploopsound("scn_loki_gas_line_fire_lp");
}

sfx_gas_line_explo_logic() {
  level.space_breathing_enabled = 0;
  var_0 = spawn("script_origin", (-31629, -10789, 20409));
  var_0 playSound("scn_loki_moving_cover_part1_3d");
  level.player playSound("loki_ply_uhhhhhplayerstunnedby");
  level.player playSound("scn_loki_gas_line_explo");
  level.space_intense_breathing = 2;
  level.player setclienttriggeraudiozone("loki_gas_line_explo", 0.1);
  wait 0.1;
  level.player playSound("loki_ply_slightlyheavylabored");
  wait 2.3;
  level.player playSound("scn_loki_moving_cover_part1_lr");
  wait 7.6;
  level.player setclienttriggeraudiozone("loki_default", 4.0);
  wait 0.02;
  wait 3.5;
  level.sfx_faked_hurt_breathing = 0;
  level.space_breathing_enabled = 1;
}

sfx_gas_line_scene_plr_hit() {
  wait 0.2;
  level.player playSound("scn_loki_gas_line_plr_hit");
  wait 2.134;
  level.player playSound("loki_ply_uhhhhhplayerstunnedby");
}

sfx_gas_line_scene_suit_beeps() {
  wait 0.6;
}

sfx_gas_line_scene_faked_hurt_breathing() {
  while(level.sfx_faked_hurt_breathing) {
    level.player playSound("scn_loki_gas_line_breathing_hurt");
    var_0 = randomfloatrange(0.9, 1.55);
    wait(var_0);
  }
}

sfx_gas_line_dist_explo(var_0) {
  common_scripts\utility::play_sound_in_space("scn_loki_gas_line_explo_small", var_0);
}

sfx_space_breach_logic() {
  soundsettimescalefactor("weapon", 0.5);
  soundsettimescalefactor("bulletwhizbyin", 0.5);
  soundsettimescalefactor("bulletwhizbyout", 0.5);
  soundsettimescalefactor("bulletflesh1", 0.4);
  soundsettimescalefactor("bulletflesh2", 0.4);
  soundsettimescalefactor("bulletflesh1npc", 0.6);
  soundsettimescalefactor("bulletflesh2npc", 0.6);
  level.player playSound("scn_loki_space_breach");
  level.space_intense_breathing = 2;
  thread sfx_breach_stop_music();
  level.player setclienttriggeraudiozone("loki_breach", 1.1);
  wait 8.5;
  level.space_breathing_enabled = 0;
  wait 3.9;
  level.space_breathing_enabled = 1;
  level.space_intense_breathing = 3;
}

sfx_breach_stop_music() {
  maps\_utility::music_stop(7.5);
}

sfx_ally_shoot() {
  self playSound("scn_loki_space_breach_ally_shoot");
}

sfx_space_breach_over() {
  level.space_intense_breathing = 0;
  level.player playSound("scn_loki_space_breach_end");
  level.player setclienttriggeraudiozone("loki_default", 0.1);
}

sfx_laptop_offline_lp() {
  if(!isDefined(level.sfx_laptop)) {
    level.sfx_laptop = spawn("script_origin", (-31594, -9018, 21801));
  }

  level.sfx_laptop playLoopSound("scn_loki_laptop_offline_lp");
}

sfx_laptop_reboot() {
  level.sfx_laptop stoploopsound("scn_loki_laptop_offline_lp");
  wait 0.1;
  level.sfx_laptop playSound("scn_loki_laptop_rebooting");
}

sfx_laptop_target_lp() {
  wait 0.1;
  level.sfx_laptop playLoopSound("scn_loki_laptop_target_lp");
}

sfx_laptop_launching() {
  level.sfx_laptop stoploopsound("scn_loki_laptop_target_lp");
  wait 0.1;
  level.sfx_laptop playSound("scn_loki_laptop_launching");
}

sfx_laptop_connecting() {
  wait 0.1;
  level.sfx_laptop playSound("scn_loki_laptop_connecting");
  wait 2.6;
  level.player playSound("scn_loki_laptop_connecting_03");
}

sfx_laptop_static() {
  if(!isDefined(level.sfx_laptop_static)) {
    level.sfx_laptop_static = spawn("script_origin", (-96615, 90824, 92968));
  }

  level.sfx_laptop_static playSound("scn_loki_laptop_static");
}

sfx_set_rog_amb() {
  wait 0.15;
  level.player setclienttriggeraudiozone("loki_rog_fire", 1);
}

sfx_rog_incoming(var_0) {
  wait 0.3;
  var_0 playSound("scn_loki_rog_incoming");
}

sfx_set_combat_amb() {
  wait 0.15;
  level.player setclienttriggeraudiozone("loki_combat", 1);
  level.space_intense_breathing = 2;
}

sfx_set_combat_two_amb() {
  wait 4.0;
  level.player setclienttriggeraudiozone("loki_combat", 1);
  level.space_intense_breathing = 2;
}

sfx_end_combat_amb() {
  level.player setclienttriggeraudiozone("loki_default", 1);
  level.space_intense_breathing = 0;
}

sfx_setup_jet_nodes() {
  level.jet_passby_01 = spawn("script_origin", (-16563, -130463, -115933));
  level.jet_passby_01b = spawn("script_origin", (-16563, -130463, -115933));
  level.jet_passby_02 = spawn("script_origin", (16280, -93370, -121483));
  level.jet_passby_02b = spawn("script_origin", (16280, -93370, -121483));
  level.jet_passby_03 = spawn("script_origin", (-17525, -29160, -118181));
  level.jet_passby_04 = spawn("script_origin", (708, -29302, -119056));
  level.jet_passby_04b = spawn("script_origin", (708, -29302, -119056));
  level.jet_passby_05 = spawn("script_origin", (708, -29302, -119056));
  level.jet_passby_06 = spawn("script_origin", (708, -29302, -122000));
  level.jet_passby_06b = spawn("script_origin", (708, -29302, -122000));
  level.jet_passby_07 = spawn("script_origin", (708, -29302, -122000));
  level.jet_passby_08 = spawn("script_origin", (530, -21242, -124623));
  level.jet_passby_09 = spawn("script_origin", (32431, -49070, -122643));
  level.jet_passby_09b = spawn("script_origin", (-18232, -10413, -118082));
  level.jet_passby_10 = spawn("script_origin", (-17249, 25279, -119672));
  level.jet_passby_11 = spawn("script_origin", (-30323, 11521, -120099));
  level.jet_passby_12 = spawn("script_origin", (-30323, 11521, -120099));
  level.jet_passby_13 = spawn("script_origin", (-30323, 11521, -120099));
  level.jet_passby_14 = spawn("script_origin", (-30323, 11521, -120099));
  level.jet_passby_15 = spawn("script_origin", (-30323, 11521, -120099));
  level.jet_passby_01.destroyed = 0;
  level.jet_passby_01b.destroyed = 0;
  level.jet_passby_02.destroyed = 0;
  level.jet_passby_02b.destroyed = 0;
  level.jet_passby_03.destroyed = 0;
  level.jet_passby_04.destroyed = 0;
  level.jet_passby_04b.destroyed = 0;
  level.jet_passby_05.destroyed = 0;
  level.jet_passby_06.destroyed = 0;
  level.jet_passby_06b.destroyed = 0;
  level.jet_passby_07.destroyed = 0;
  level.jet_passby_08.destroyed = 0;
  level.jet_passby_09.destroyed = 0;
  level.jet_passby_09b.destroyed = 0;
  level.jet_passby_10.destroyed = 0;
  level.jet_passby_11.destroyed = 0;
  level.jet_passby_12.destroyed = 0;
  level.jet_passby_13.destroyed = 0;
  level.jet_passby_14.destroyed = 0;
  level.jet_passby_15.destroyed = 0;
  wait 5;
  thread watch_first_wave();
}

watch_first_wave() {
  level.jet_passby_04 thread jet_watch_delete("destroyed");
  level.jet_passby_04b thread jet_watch_delete("destroyed");
  level.jet_passby_05 thread jet_watch_delete("destroyed");
  level.jet_passby_06 thread jet_watch_delete("destroyed");
  level.jet_passby_06b thread jet_watch_delete("destroyed");
  level.jet_passby_07 thread jet_watch_delete("destroyed");
  wait 15;
  thread watch_second_wave();
}

watch_second_wave() {
  level.jet_passby_09b thread jet_watch_delete("destroyed");
  wait 30;
  thread watch_third_wave();
}

watch_third_wave() {
  level.jet_passby_10 thread jet_watch_delete("destroyed");
  level.jet_passby_11 thread jet_watch_delete("destroyed");
  level.jet_passby_12 thread jet_watch_delete("destroyed");
  level.jet_passby_13 thread jet_watch_delete("destroyed");
  level.jet_passby_14 thread jet_watch_delete("destroyed");
  level.jet_passby_15 thread jet_watch_delete("destroyed");
}

jet_watch_delete(var_0) {
  self endon("sounddone");
  self waittill(var_0);
  self.destroyed = 1;
  self stopsounds();
  wait 1;
  self notify("sounddone");
}

sfx_jet_passby_01() {
  wait 0.1;
  level.jet_passby_01 playSound("scn_loki_jet_passby_close_01", "sounddone");
  level.jet_passby_01 moveto((-9198, -93067, -115384), 3);
  wait 0.9;
  level.jet_passby_01b playSound("scn_loki_jet_passby_close_02", "sounddone");
  level.jet_passby_01b moveto((-9198, -93067, -115384), 2);
  level.jet_passby_01 waittill("sounddone");
  level.jet_passby_01 delete();
  level.jet_passby_01b waittill("sounddone");
  level.jet_passby_01b delete();
}

sfx_jet_passby_02() {
  wait 1.5;
  level.jet_passby_02 playSound("scn_loki_jet_passby_dist_04", "sounddone");
  level.jet_passby_02 moveto((4311, -46791, -121483), 3);
  wait 2.5;
  level.jet_passby_02b playSound("scn_loki_jet_passby_dist_01", "sounddone");
  level.jet_passby_02b moveto((4311, -46791, -121483), 4);
  thread sfx_jet_passby_03();
  level.jet_passby_02 waittill("sounddone");
  level.jet_passby_02 delete();
  level.jet_passby_02b waittill("sounddone");
  level.jet_passby_02b delete();
}

sfx_jet_passby_03() {
  wait 1.7;
  level.jet_passby_03 playSound("scn_loki_jet_passby_dist_02", "sounddone");
  level.jet_passby_03 moveto((-38290, -88235, -115198), 6);
  level.jet_passby_03 waittill("sounddone");
  level.jet_passby_03 delete();
}

sfx_jet_passby_04() {
  wait 0.4;

  if(level.jet_passby_04.destroyed == 0) {
    level.jet_passby_04 playSound("scn_loki_jet_passby_med_01", "sounddone");
    level.jet_passby_04 moveto((-28769, -80586, -116586), 4);
  }

  wait 1.3;

  if(level.jet_passby_04b.destroyed == 0) {
    level.jet_passby_04b playSound("scn_loki_jet_passby_close_05", "sounddone");
    level.jet_passby_04b moveto((21164, -97900, -119423), 4);
  }

  level.jet_passby_04 waittill("sounddone");
  level.jet_passby_04 delete();
  level.jet_passby_04b waittill("sounddone");
  level.jet_passby_04b delete();
}

sfx_jet_passby_05() {
  wait 1.6;

  if(level.jet_passby_05.destroyed == 0) {
    level.jet_passby_05 playSound("scn_loki_jet_passby_med_02", "sounddone");
    level.jet_passby_05 moveto((-22969, -83249, -116586), 4);
  }

  thread sfx_jet_passby_06();
  thread sfx_jet_passby_06b();
  thread sfx_jet_passby_07();
  level.jet_passby_05 waittill("sounddone");
  level.jet_passby_05 delete();
}

sfx_jet_passby_06() {
  wait 1.6;

  if(level.jet_passby_06.destroyed == 0) {
    level.jet_passby_06 playSound("scn_loki_jet_passby_close_03", "sounddone");
    level.jet_passby_06 moveto((-4461, -89713, -117839), 3);
  }

  level.jet_passby_06 waittill("sounddone");
  level.jet_passby_06 delete();
}

sfx_jet_passby_06b() {
  wait 1.7;

  if(level.jet_passby_06b.destroyed == 0) {
    level.jet_passby_06b playSound("scn_loki_jet_passby_close_05", "sounddone");
    level.jet_passby_06b moveto((23119, -81839, -117839), 3);
  }

  level.jet_passby_06b waittill("sounddone");
  level.jet_passby_06b delete();
}

sfx_jet_passby_07() {
  wait 2.7;
  level.jet_passby_07 moveto((-10405, -82882, -108826), 1.7);

  if(level.jet_passby_07.destroyed == 0) {
    wait 0.3;
    level.jet_passby_07 playSound("scn_loki_jet_passby_close_04", "sounddone");
  }

  level.jet_passby_07 waittill("sounddone");
  level.jet_passby_07 delete();
}

sfx_jet_passby_08() {
  wait 8;
  level.jet_passby_08 playSound("scn_loki_jet_passby_med_03", "sounddone");
  level.jet_passby_08 moveto((32431, -49070, -122643), 4);
  thread sfx_jet_passby_09();
  level.jet_passby_08 waittill("sounddone");
  level.jet_passby_08 delete();
}

sfx_jet_passby_09() {
  wait 1.5;
  level.jet_passby_09 moveto((530, -21242, -124623), 4);
  wait 1;
  level.jet_passby_09 playSound("scn_loki_jet_passby_med_04", "sounddone");
  level.jet_passby_09 waittill("sounddone");
  level.jet_passby_09 delete();
  thread sfx_jet_passby_09b();
}

sfx_jet_passby_09b() {
  wait 6.5;

  if(level.jet_passby_09b.destroyed == 0) {
    level.jet_passby_09b playSound("scn_loki_jet_passby_dist_04", "sounddone");
  }

  level.jet_passby_09b waittill("sounddone");
  level.jet_passby_09b delete();
}

sfx_jet_passby_10() {
  wait 7;

  if(level.jet_passby_10.destroyed == 0) {
    level.jet_passby_10 playSound("scn_loki_jet_passby_dist_02", "sounddone");
    level.jet_passby_10 moveto((23920, -2304, -122187), 6);
  }

  level.jet_passby_10 waittill("sounddone");
  level.jet_passby_10 delete();
}

sfx_jet_passby_11() {
  if(level.jet_passby_11.destroyed == 0) {
    level.jet_passby_11 playSound("scn_loki_jet_passby_med_01", "sounddone");
  }

  if(level.jet_passby_12.destroyed == 0) {
    level.jet_passby_12 playSound("scn_loki_jet_passby_med_02", "sounddone");
  }

  wait 1;
  level.jet_passby_11 moveto((31102, 7344, -106177), 2);

  if(level.jet_passby_13.destroyed == 0) {
    level.jet_passby_13 moveto((31102, 7344, -106177), 2.4);
    level.jet_passby_13 playSound("scn_loki_jet_passby_close_05", "sounddone");
  }

  level.jet_passby_12 moveto((27424, 18213, -111537), 2);
  wait 0.7;

  if(level.jet_passby_14.destroyed == 0) {
    level.jet_passby_14 moveto((31150, 7400, -106177), 3);
    level.jet_passby_14 playSound("scn_loki_jet_passby_close_03", "sounddone");
  }

  level.jet_passby_15 moveto((27424, 18213, -111537), 3);
  wait 0.5;

  if(level.jet_passby_15.destroyed == 0) {
    level.jet_passby_15 playSound("scn_loki_jet_passby_close_04", "sounddone");
  }

  level.jet_passby_11 waittill("sounddone");
  level.jet_passby_11 delete();
  level.jet_passby_12 waittill("sounddone");
  level.jet_passby_12 delete();
  level.jet_passby_13 waittill("sounddone");
  level.jet_passby_13 delete();
  level.jet_passby_14 waittill("sounddone");
  level.jet_passby_14 delete();
  level.jet_passby_15 waittill("sounddone");
  level.jet_passby_15 delete();
}

sfx_temp_redshirt_stinger() {
  level.player playSound("bullet_large_flesh");
}

sfx_beginning_rog_fire() {
  wait 0.7;
  var_0 = spawn("script_origin", (-28172, -17882, 20077));
  var_0 playSound("scn_loki_rog_fire_space_infil");
  wait 2;
  var_0 moveto((-49896, -17251, 18536), 5);
}

sfx_rog_impact(var_0) {
  var_0 playSound("scn_loki_rog_explode");
  level.player playSound("scn_loki_rog_explode_lsrs");
}

sfx_loki_shuttle_zone() {
  level.player setclienttriggeraudiozone("loki_shuttle_beginning", 0.1);
}

sfx_loki_npc_monitor_foley(var_0) {
  wait 7.5;
  var_0 playSound("scn_loki_ending_ally_foley");
  wait 0.45;
  level.npc_foley_hand = spawn("script_origin", (-31596, -9009, 21804));
  level.npc_foley_hand playSound("scn_loki_ending_ally_hand_foley", "sounddone");
  level.npc_foley_hand waittill("sounddone");
  level.npc_foley_hand delete();
}

sfx_ending_bink_connecting() {
  level.player playSound("scn_loki_laptop_connecting_02");
}

sfx_ending_bink() {
  wait 0.3;
  thread sfx_laptop_static_02();
  wait 0.2;

  if(!isDefined(level.sfx_laptop)) {
    level.sfx_laptop = spawn("script_origin", (-31594, -9018, 21801));
  }

  level.sfx_laptop playSound("scn_loki_laptop_coord");
  wait 2;
  thread sfx_laptop_static_02();
  wait 0.2;
  level.sfx_laptop playLoopSound("scn_loki_laptop_target_lp");
  level waittill("player_flipped_switch_anim_done");
  level.sfx_laptop delete();
  level.sfx_laptop_static_02 delete();
}

sfx_laptop_static_02() {
  if(isDefined(level.sfx_laptop_static)) {
    level.sfx_laptop_static delete();
  }

  if(!isDefined(level.sfx_laptop_static_02)) {
    level.sfx_laptop_static_02 = spawn("script_origin", (-31594, -9018, 21800));
  }

  level.sfx_laptop_static_02 playSound("scn_loki_laptop_static_02");
}

sfx_laptop_ending_fail() {
  if(!isDefined(level.sfx_laptop_static_02)) {
    level.sfx_laptop_static_02 = spawn("script_origin", (-31594, -9018, 21800));
  }

  level.sfx_laptop stoploopsound("scn_loki_laptop_target_lp");
  level.sfx_laptop_static_02 playSound("scn_loki_laptop_fail_static", "sounddone");
  level.sfx_laptop_static_02 waittill("sounddone");
  level.sfx_laptop_static_02 delete();
  level.sfx_laptop delete();
}

sfx_loki_ending_charging_start() {
  level.power = spawn("script_origin", (4800, 1800, 1));
  wait 4;
  level.power playLoopSound("scn_loki_rog_end_charging");
  level.player playSound("scn_loki_rog_end_machine");
}

sfx_loki_ending_machinery_sound() {
  wait 1;
  level.player playSound("scn_loki_rog_end_machine");
}

sfx_wait_to_play_ending_sound() {
  common_scripts\utility::flag_wait("player_flipped_switch");
  level.player playSound("scn_loki_rog_end");
  wait 1;

  if(isDefined(level.power)) {
    common_scripts\utility::flag_wait("final_rog_fired");
    level.power stoploopsound();
    wait 0.1;
    level.power delete();
  }

  level.player setclienttriggeraudiozone("loki_end", 0.3);
  level.space_breathing_enabled = 0;
}

sfx_loki_control_room_start() {
  level.player playSound("scn_loki_control_room_start_lr");
  wait 9;
  level.power = spawn("script_origin", (4800, 1800, 1));
  level.power playLoopSound("scn_loki_control_room_powerup");
}

sfx_control_room_launch() {
  level.player playSound("scn_loki_control_room_launch_lr");
  level.player setclienttriggeraudiozone("loki_control_launch", 1);
  wait 4;

  if(isDefined(level.power)) {
    level.power stoploopsound();
    wait 0.1;
    level.power delete();
  }
}

sfx_control_room_rog_launch() {
  wait 0.4;
  level.sfx_sat_01 = spawn("script_origin", (-35851, -11696, 22412));
  level.sfx_sat_01 playSound("scn_loki_rog_cntrl_fire_01", "sounddone");
  wait 0.16;
  level.sfx_sat_02 = spawn("script_origin", (-40828, -7812, 24983));
  level.sfx_sat_02 playSound("scn_loki_rog_cntrl_fire_02");
  level.sfx_sat_01 waittill("sounddone");
  level.sfx_sat_01 delete();
}

sfx_moving_cover_3rd_piece(var_0) {
  var_0 playSound("scn_loki_moving_cover_part3_lr");
}

play_sound_on_cover_piece(var_0, var_1) {
  var_2 = spawn("script_origin", self gettagorigin(var_0));
  var_2 linkto(self, var_0);
  var_2 playSound("scn_loki_moving_cover_obj_01_lr");
  wait 10.0;
  var_2 delete();
}

play_sound_on_moving_cover_object(var_0, var_1) {
  common_scripts\utility::flag_wait("moving_cover_started");

  if(isDefined(var_1)) {
    wait(var_1);
  }

  if(isDefined(var_0)) {
    self playSound(var_0);
  }
}

sfx_moving_cover_2() {
  level.player playSound("scn_loki_moving_cover_part2_lr");
}
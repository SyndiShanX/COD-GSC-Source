/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_vips\sa_vips_audio.gsc
*****************************************************/

main() {
  _id_DEC7();
}

_id_5D0D() {}

_id_13E94() {}

_id_949A() {}

_id_9A66() {}

_id_3A63() {
  level.player setsoundsubmix("sa_ship_interior");
}

_id_DDFD() {}

_id_68FC() {}

_id_5D0E() {
  level.player clearsoundsubmix();
}

_id_13E95() {
  level.player clearsoundsubmix();
}

_id_949B() {
  level.player clearsoundsubmix();
  level thread _id_0F00::_id_CD09("snd_battle_background_ambience", "sa_ext_battle_bg_distant", "entering_ship_interior");
  thread _id_6A1D();
}

_id_87DB() {
  thread _id_570D();
  thread _id_570C();
}

_id_9A67() {
  thread _id_570D();
  thread _id_570C();
}

_id_3A64() {
  thread _id_570D();
  thread _id_570C();
  level.player setsoundsubmix("sa_ship_interior");
}

_id_DDFE() {
  thread _id_570D();
  thread _id_570C();
}

_id_68FD() {}

_id_A237() {}

_id_13E93() {
  wait 4.5;
  level thread _id_0F00::_id_CD09("snd_battle_background_ambience", "sa_ext_battle_bg_distant", "entering_ship_interior");
  thread _id_6A1D();
}

_id_FB65() {
  foreach(var_1 in self.turrets) {
    foreach(var_3 in var_1) {
      if(isDefined(var_3._id_B04C) == 1) {
        var_3 notify("new_loop_sound");
        var_3 notify("stop_shooting");
      }

      if(isDefined(var_3._id_10241) == 1) {
        var_3._id_10241._id_1283 = var_3._id_10241._id_6D32;
        var_3._id_10241._id_1284 = var_3._id_10241._id_6D34;
        var_3._id_10241._id_6D32 = undefined;
        var_3._id_10241._id_6D34 = undefined;
      }
    }
  }
}

_id_FBF6() {
  foreach(var_1 in self.turrets) {
    foreach(var_3 in var_1) {
      if(isDefined(var_3._id_10241) == 1 && isDefined(var_3._id_10241._id_1284) == 1) {
        var_3._id_10241._id_6D32 = var_3._id_10241._id_1283;
        var_3._id_10241._id_6D34 = var_3._id_10241._id_1284;
        var_3._id_10241._id_1283 = undefined;
        var_3._id_10241._id_1284 = undefined;
      }
    }
  }
}

_id_9499() {
  level waittill("breach_detonation");

  while(isDefined(level._id_3965) == 0)
    scripts\engine\utility::waitframe();

  thread _id_2F55();
  thread _id_570D();
  thread _id_2F74();
  level waittill("zero_g_mantle_started");
  level._id_3965 _id_FB65();
  wait 2;
  scripts\engine\utility::flag_set("entering_ship_interior");
  level thread _id_0F00::_id_CDD7("war");
  level.player setsoundsubmix("sa_ship_interior");
  _id_D6B9();
}

_id_87DA() {
  level.player clearclienttriggeraudiozone(1);
  setglobalsoundcontext("sa_location", "interior");
  wait 4;
  _id_9A63();
  wait 8;
  level thread _id_0F00::_id_CDD7("war");
}

_id_9A65() {
  level.player clearclienttriggeraudiozone(1);
  setglobalsoundcontext("sa_location", "interior");
  wait 4;
  _id_9A63();
  wait 8;
  level thread _id_0F00::_id_CDD7("war");
}

_id_3A62() {
  level thread _id_0F00::_id_CDD7("war");
  _id_9A63();
  scripts\engine\utility::flag_wait("sa_hangar_start");
  _id_8A10();
}

_id_DDFC() {
  level thread _id_0F27::_id_10EDA();
  level thread _id_0F00::_id_CDD7("war");
  _id_8A10();
}

_id_68FB() {
  level thread _id_0F27::_id_10EDA();
  level thread _id_0F00::_id_CDD7("war");
  _id_9A63();
}

_id_DEC7() {}

_id_6A1D() {
  level.player notify("started_dynamic_ambience");
  thread _id_0F00::_id_FBEF("sa_ext_expl_close", 2, 10, 4, 15, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("sa_ext_expl_med", 2, 5, 3, 7, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
}

_id_D6B9() {
  level.player notify("started_dynamic_ambience");
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_large", 12, 24, 10, 12, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_medium_distant", 10, 20, 10, 12, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_air_release_distant", 18, 30, 15, 17, 3000, 3001, 300, 270, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_impact_distant", 10, 18, 0, 3, 3000, 3001, 300, 0, 90, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_movement_distant_long", 14, 25, 8, 10, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_movement_distant_short", 9, 16, 3, 6, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_servo_distant", 8, 12, 6, 10, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_long_dist", 20, 30, 25, 28, 3000, 3001, 300, 180, 270, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_medium_distant", 15, 27, 21, 23, 3000, 3001, 300, 0, 180, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_short_distant", 22, 34, 1, 5, 3000, 3001, 300, 90, 180, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_medium_distant", 10, 20, 9, 14, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_alarm_buzzer", 20, 31, 13, 15, 5000, 5001, 300, 0, 100, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_battle_distant", 3, 10, 3, 10, 100, 1000, 300, 90, 90, 4, 0, 0, 0);
  thread _id_0F00::_id_FBEF("vips_int_explosion_sm", 0.2, 18, 3, 8, 100, 1000, 300, 5, 5, 2, 1, 0.2, 0.1);
  thread _id_0F00::_id_FBEF("vips_int_explosion_lg", 0.2, 25, 3, 8, 100, 1000, 300, 5, 5, 2, 1, 0.7, 0.1);
  thread _id_0F00::_id_FBEF("vips_int_mixed_battle_thumps", 4, 5, 4, 5, 5000, 6000, 10, 30, 50, 6, 0, 0, 0);
}

_id_9A63() {
  level.player notify("started_dynamic_ambience");
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_large", 12, 24, 10, 12, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_medium_distant", 10, 20, 10, 12, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_air_release_distant", 18, 30, 15, 17, 3000, 3001, 300, 270, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_impact_distant", 10, 18, 0, 3, 3000, 3001, 300, 0, 90, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_movement_distant_long", 14, 25, 8, 10, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_movement_distant_short", 9, 16, 3, 6, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_servo_distant", 8, 12, 6, 10, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_long_dist", 20, 30, 25, 28, 3000, 3001, 300, 180, 270, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_medium_distant", 15, 27, 21, 23, 3000, 3001, 300, 0, 180, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_short_distant", 22, 34, 1, 5, 3000, 3001, 300, 90, 180, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_medium_distant", 10, 20, 9, 14, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_alarm_buzzer", 20, 31, 13, 15, 5000, 5001, 300, 0, 100, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_battle_distant", 3, 10, 3, 10, 100, 1000, 300, 90, 90, 4, 0, 0, 0);
  thread _id_0F00::_id_FBEF("vips_int_explosion_sm", 0.2, 18, 3, 8, 100, 1000, 300, 5, 5, 2, 1, 0.2, 0.1);
  thread _id_0F00::_id_FBEF("vips_int_explosion_lg", 0.2, 25, 3, 8, 100, 1000, 300, 5, 5, 2, 1, 0.7, 0.1);
  thread _id_0F00::_id_FBEF("vips_int_mixed_battle_thumps", 4, 5, 4, 5, 5000, 6000, 10, 30, 50, 6, 0, 0, 0);
}

_id_8A10() {
  level.player notify("started_dynamic_ambience");
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_medium", 10, 20, 10, 12, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_large_deep", 10, 20, 10, 12, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_air_release_distant", 18, 30, 15, 17, 3000, 3001, 300, 270, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_medium_medium", 10, 18, 0, 3, 3000, 3001, 300, 0, 90, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_short_distant", 14, 25, 8, 10, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_small", 8, 12, 6, 10, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_ominous", 20, 30, 25, 28, 3000, 3001, 300, 180, 270, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_impact_distant_deep", 15, 27, 21, 23, 3000, 3001, 300, 0, 180, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_movement_distant_long_deep", 22, 34, 1, 5, 3000, 3001, 300, 90, 180, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_movement_distant_short_deep", 10, 20, 9, 14, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_lights_buzzing_distant", 20, 31, 13, 15, 5000, 5001, 300, 0, 100, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_battle_distant_deep", 5, 12, 0, 4, 100, 1000, 300, 90, 90, 4, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_impact_deep", 8, 22, 4, 8, 100, 1000, 300, 180, 180, 2, 1, 0.5, 3);
  thread _id_0F00::_id_FBEF("vips_int_explosion_sm", 0.2, 18, 3, 8, 100, 1000, 300, 5, 5, 2, 1, 0.2, 0.1);
  thread _id_0F00::_id_FBEF("vips_int_explosion_lg", 0.2, 25, 3, 8, 100, 1000, 300, 5, 5, 2, 1, 0.7, 0.1);
  thread _id_0F00::_id_FBEF("vips_int_mixed_battle_thumps", 4, 5, 4, 5, 5000, 6000, 10, 30, 50, 6, 0, 0, 0);
}

_id_AA9E() {
  var_0 = scripts\engine\utility::play_loopsound_in_space("amb_launch_tube_rumble", (-87588, -78360, 11590));
  level.player waittill("jackal_ret_launch");
  var_0 scripts\sp\utility::_id_10460(1);
}

_id_AA7F() {
  _id_0F00::_id_E9C3();
  level.player playSound("sa_launch_tube_exit_lr");
}

_id_5E1E() {
  wait 0.1;
  level.player clearsoundsubmix();
  level.player playSound("vips_dropship_intro_lr");
}

button_pressed_from_string() {
  level.player playSound("vip_button_press_gravity");
}

_id_3A23() {
  level.player setsoundsubmix("sa_vips_captain");
  level._id_133E0 waittill("stop_initial_execution_idle");
  wait 5;
  level.player setsoundsubmix("sa_ship_interior");
}

_id_2F55() {
  var_0 = scripts\engine\utility::spawn_tag_origin((-681, -1240, 63));
  var_0 _meth_8278(0);
  wait 0.5;
  var_0 _meth_8278(1, 4);

  while(!scripts\engine\utility::flag("infiltrate_end")) {
    var_0 playSound("vips_breach_alarm");
    wait 0.6;
  }

  wait 4;
  var_0 delete();
}

_id_570D() {
  level._id_570A = scripts\engine\utility::spawn_tag_origin((2714, -5, 181));
  level._id_570A _meth_8278(0);
  level._id_570B = scripts\engine\utility::spawn_tag_origin((5650, -10, 100));
  level._id_570B _meth_8278(0);
  level._id_570A _meth_8278(0.3, 4);
  level._id_570A playLoopSound("vips_distant_alarm_1");
  level._id_570B _meth_8278(0.3, 4);
  level._id_570B playLoopSound("vips_distant_alarm_2");
}

_id_570C() {
  level._id_570A _meth_8278(1, 2);
  level._id_570B _meth_8278(1, 2);
}

_id_8792() {
  _id_0F00::_id_CCC7("sa_vips_big_screen_animation_v1", (-518, -967, 70));
}

_id_E460() {
  wait 2.9;
  thread _id_8511();
  thread _id_8514();
  thread _id_8518();
  wait 0.2;
  thread _id_8517();
  thread _id_8515();
}

_id_8511() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 playSound("gravity_on", "sounddone");
  var_0 waittill("sounddone");
  var_0 delete();
}

_id_8514() {
  var_0 = scripts\engine\utility::spawn_tag_origin((301, -1475, 17));
  var_0 playSound("gravity_on_compression", "sounddone");
  var_0 waittill("sounddone");
  var_0 delete();
}

_id_8517() {
  wait 0.1;
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 playSound("gravity_on_metal_debris", "sounddone");
  var_0 waittill("sounddone");
  var_0 delete();
}

_id_8515() {
  thread _id_8513();
  thread _id_8516();
  thread _id_8512();
}

_id_8513() {
  wait 0.4;
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 playSound("gravity_on_canisters_fall", "sounddone");
  var_0 waittill("sounddone");
  var_0 delete();
}

_id_8516() {
  wait 0.7;
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 playSound("gravity_on_gun_fall", "sounddone");
  var_0 waittill("sounddone");
  var_0 delete();
}

_id_8512() {
  wait 1.3;
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 playSound("gravity_on_body_fall", "sounddone");
  var_0 waittill("sounddone");
  var_0 delete();
}

_id_8518() {
  wait 0.25;
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 playSound("gravity_on_plr_imp_metal", "sounddone");
  var_0 waittill("sounddone");
  var_0 delete();
}

_id_83CC() {
  var_0 = scripts\engine\utility::spawn_tag_origin((-1001, -1204, 10));
  var_0 playLoopSound("breach_glass_pieces");

  while(!level.player isonground())
    wait 0.05;

  var_0 stopsounds();
  scripts\engine\utility::waitframe();
  var_0 delete();
}

_id_2F74() {
  wait 6;
  _id_0F00::_id_CE21("breach_floating_debris", (-1001, -1204, 10));
  thread _id_83CC();
}

_id_F0E7() {
  wait 1;
  level.player playSound("vips_force_hydraulic_door_open");
  thread _id_570C();
}

_id_5F14(var_0) {
  level.player _id_0F00::_id_CE24("duct_grate_grab", 0.2);
  level.player _id_0F00::_id_CE24("duct_grate_remove", 1);
  level.player _id_0F00::_id_CE24("duct_grate_place", 2.6);
  var_0 _id_0F00::_id_CE24("duct_grate_slide", 3.7);
  level.player _id_0F00::_id_CE24("duct_exit", 4.3);
}

_id_10ED0(var_0, var_1) {
  if(!scripts\engine\utility::flag("body_bag_melee_kill_enemy_dead_or_alerted")) {
    level.player _id_0F00::_id_CE24("stealth_kill_approach");
    level.player _id_0F00::_id_CE24("stealth_kill_vo_pain", 0.65);
    level.player _id_0F00::_id_CE24("stealth_kill_stab", 1.2);
    level.player _id_0F00::_id_CE24("stealth_kill_knifeout", 2.25);
    level.player _id_0F00::_id_CE24("stealth_kill_vo_death", 2.75);
    level.player _id_0F00::_id_CE24("stealth_kill_bodydrop", 4.05);
  } else {}
}

_id_68EE() {
  level.player playSound("exfil_airlock_grab_handle");
  wait 0.7;
  level.player playSound("exfil_airlock_entry_door_open");
  thread _id_6903();
  level.player notify("started_dynamic_ambience");
  level._id_3965 _id_FBF6();
  wait 0.2;
  thread _id_68F3();
  wait 2.5;
  level.player _meth_82C0("vips_airlock", 6);
  level._id_570A _meth_8278(0, 6);
  level._id_570B _meth_8278(0, 6);
}

_id_68EF() {
  wait 0.4;
  level.player playSound("exfil_airlock_exit_door_open_lr");
  level.player clearclienttriggeraudiozone(6);
  level.player clearsoundsubmix();
  wait 1;
  _id_6A1D();
  wait 2;
  scripts\engine\utility::play_sound_in_space("exfil_jackal_approach_swt", (744, -2164, -100));
}

_id_6903() {
  wait 5;
  level.player _id_0F00::_id_CE21("exfil_airlock_depressurize_lr");
  wait 1;
  level.player _meth_8559(1);
}

_id_68F3() {
  var_0 = scripts\engine\utility::play_loopsound_in_space("vips_airlock_vent_1", (779, -1652, -30));
  var_1 = scripts\engine\utility::play_loopsound_in_space("vips_airlock_vent_2", (950, -1652, -30));
  scripts\engine\utility::flag_wait("infiltrate_door_opened");
  var_0 scripts\sp\utility::_id_10460(3);
  var_1 scripts\sp\utility::_id_10460(3);
}
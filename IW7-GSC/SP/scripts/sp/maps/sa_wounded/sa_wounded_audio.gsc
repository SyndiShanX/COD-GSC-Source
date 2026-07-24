/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_wounded\sa_wounded_audio.gsc
***********************************************************/

main() {
  _id_953A();
}

_id_953A() {
  level._id_2571._id_1D66 = ["insertion_to_hallway", "hallway_to_atrium", "atrium_to_hallway", "hallway_to_life_support", "life_support_to_hallway", "hallway_to_armory", "insertion_to_hallway_secondary", "hallway_to_atrium_secondary", "atrium_to_hallway_secondary", "hallway_to_life_support_secondary", "life_support_to_hallway_secondary", "hallway_to_armory_secondary"];

  foreach(var_1 in level._id_2571._id_1D66)
  scripts\engine\utility::flag_init(var_1);

  scripts\engine\utility::flag_init("random_ambience_started");
  scripts\engine\utility::flag_init("audio_entering_hangar");
  scripts\engine\utility::flag_init("stop_sfx_emitter");
}

_id_3B36() {}

_id_3B2F() {}

_id_3B35() {}

_id_3B38() {}

_id_3B2B() {}

_id_3B41() {}

_id_3B32() {}

_id_476C() {
  level thread _id_10D4A();
}

_id_4769() {}

_id_476B() {
  thread _id_DC6D();
  level thread _id_0F00::_id_CDD7("war");
  _id_0F00::_id_FC1D();
  level.player _meth_8559(0);
}

_id_476D() {
  level thread _id_0F00::_id_CDD7("war");
  level.player _meth_8559(0);
}

_id_4768() {
  level thread _id_0F00::_id_CDD7("war");
  level.player _meth_8559(0);
}

_id_476E() {
  level thread _id_0F00::_id_CDD7("war");
  level.player _meth_8559(0);
}

_id_476A() {
  level thread _id_0F00::_id_CDD7("war");
  level.player _meth_8559(0);
}

_id_10D4A() {
  while(isDefined(level._id_D127) == 0)
    scripts\engine\utility::waitframe();

  var_0 = 131072;
  var_1 = 2048;
  level._id_D127 thread _id_11898();
  level._id_D127 thread _id_4306();
  level._id_D127 thread _id_A3A4();
  level._id_D127 thread _id_0F00::_id_FB7F("thunder_crack", 3, 7, var_0, var_0, var_0 - var_0 * 2, var_0);
  level._id_D127 thread _id_0F00::_id_FB81("wind_gust", 3, 7, var_1, var_1 + 1, 0, 1, 180, 10);
  level._id_D127 waittill("jackal_touchdown");
  level._id_D127 notify("stop_sfx_emitter");
  level._id_D127 notify("stop_jackal_interior_sound");
  level._id_D127 notify("stop_thunder_wind");
  level._id_D127 notify("stop_cockpit_debris");
}

_id_65CF() {
  wait 2.4;
  thread _id_0F00::_id_CE21("cap_spark_up", (-13889, 123, 1567));
}

_id_65B1() {
  var_0 = thread scripts\engine\utility::play_loopsound_in_space("engine_slow", (-13889, 123, 1567));
  scripts\engine\utility::flag_wait("enemy_jackals_dead");
  var_0 delete();
}

_id_10B9B() {
  var_0 = getEntArray("wounded_ambient_cannon_sounds_org", "targetname");
  var_1 = [];

  if(var_0.size) {
    foreach(var_3 in var_0) {
      var_4 = scripts\engine\utility::spawn_tag_origin(var_3.origin);
      var_4 thread scripts\sp\utility::play_loop_sound_on_tag("amb_wounded_fire_lp", "tag_origin", 1, 1);
      var_1[var_1.size] = var_4;
    }

    scripts\engine\utility::flag_wait("hanger_allies_go");
    scripts\engine\utility::array_call(var_0, ::delete);
    scripts\engine\utility::array_call(var_1, ::delete);
  }
}

_id_9A54() {
  level thread _id_9A5B();
  level thread _id_10D4A();
  thread _id_0F00::_id_D050();
  thread _id_65B1();
}

_id_9A5B() {
  while(!isDefined(level._id_9ADD))
    scripts\engine\utility::waitframe();

  level._id_9ADD scripts\sp\utility::_id_65E3("hellas_in_sight");
}

_id_3D2E() {
  level thread _id_10B9B();
  thread _id_65CF();
  thread _id_3959();
}

_id_9910() {
  level thread _id_0F00::_id_CDD7("war");
  _id_990F();
}

_id_9914() {
  level._id_D127 playSound("chase_hanger_enter");
}

_id_AC51() {
  level thread _id_0F00::_id_CDD7("war");
  _id_4FC5();
}

_id_21BC() {
  level thread _id_0F00::_id_CDD7("war");
  _id_9A63();
}

_id_21BD() {
  scripts\engine\utility::flag_wait("wounded_armory_ambush_done");
  scripts\engine\utility::flag_wait("proximity_hacking");
}

_id_E40F() {
  level thread _id_0F00::_id_CDD7("war");
  _id_9A63();
}

_id_6940() {
  level thread _id_0F00::_id_CDD7("war");
  _id_9A63();
  scripts\engine\utility::flag_wait("begin_outro_scene");
}

_id_DC6D() {
  if(scripts\engine\utility::flag("random_ambience_started")) {
    return;
  }
  scripts\engine\utility::flag_set("random_ambience_started");

  for(;;) {
    var_0 = scripts\engine\utility::waittill_any_in_array_return(level._id_2571._id_1D66);

    switch (var_0) {
      case "insertion_to_hallway":
        scripts\engine\utility::flag_waitopen("insertion_to_hallway");

        if(scripts\engine\utility::flag("insertion_to_hallway_secondary"))
          _id_4FC5();
        else
          _id_990F();

        break;
      case "hallway_to_atrium":
        scripts\engine\utility::flag_waitopen("hallway_to_atrium");

        if(scripts\engine\utility::flag("hallway_to_atrium_secondary"))
          _id_9A63();
        else
          _id_4FC5();

        break;
      case "atrium_to_hallway":
        scripts\engine\utility::flag_waitopen("atrium_to_hallway");

        if(scripts\engine\utility::flag("atrium_to_hallway_secondary"))
          _id_4FC5();
        else
          _id_9A63();

        break;
      case "hallway_to_life_support":
        scripts\engine\utility::flag_waitopen("hallway_to_life_support");

        if(scripts\engine\utility::flag("hallway_to_life_support_secondary"))
          _id_9A63();
        else
          _id_4FC5();

        break;
      case "life_support_to_hallway":
        scripts\engine\utility::flag_waitopen("life_support_to_hallway");

        if(scripts\engine\utility::flag("life_support_to_hallway_secondary"))
          _id_4FC5();
        else
          _id_9A63();

        break;
      case "hallway_to_armory":
        scripts\engine\utility::flag_waitopen("hallway_to_armory");

        if(scripts\engine\utility::flag("hallway_to_armory_secondary"))
          _id_9A63();
        else
          _id_4FC5();

        break;
      default:
        break;
    }
  }
}

_id_990F() {
  level.player notify("started_dynamic_ambience");
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_large", 10, 20, 10, 12, 3000, 3001, 300, 0, 359, 0, 0, 0, 0, "linear_up");
  thread _id_0F00::_id_FBEF("amb_sa_machine_air_release_distant", 18, 30, 15, 17, 3000, 3001, 300, 270, 359, 0, 0, 0, 0, "linear_up");
  thread _id_0F00::_id_FBEF("amb_sa_machine_impact_distant", 10, 18, 0, 3, 3000, 3001, 300, 0, 90, 0, 0, 0, 0, "linear_up");
  thread _id_0F00::_id_FBEF("amb_sa_machine_movement_distant_long", 14, 25, 8, 10, 3000, 3001, 300, 0, 359, 0, 0, 0, 0, "linear_up");
  thread _id_0F00::_id_FBEF("amb_sa_machine_movement_distant_short", 9, 16, 3, 6, 3000, 3001, 300, 0, 359, 0, 0, 0, 0, "linear_up");
  thread _id_0F00::_id_FBEF("amb_sa_machine_servo_distant", 8, 12, 6, 10, 3000, 3001, 300, 0, 359, 0, 0, 0, 0, "linear_up");
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_long_dist", 20, 30, 25, 28, 3000, 3001, 300, 180, 270, 0, 0, 0, 0, "linear_up");
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_medium_distant", 15, 27, 21, 23, 3000, 3001, 300, 0, 180, 0, 0, 0, 0, "linear_up");
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_short_distant", 22, 34, 1, 5, 3000, 3001, 300, 90, 180, 0, 0, 0, 0, "linear_up");
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_medium_distant", 10, 20, 9, 14, 3000, 3001, 300, 0, 359, 0, 0, 0, 0, "linear_up");
  thread _id_0F00::_id_FBEF("amb_sa_alarm_buzzer", 20, 31, 13, 15, 5000, 5001, 300, 0, 100, 0, 0, 0, 0, "linear_up");
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_ominous", 10, 20, 10, 12, 3000, 3001, 300, 0, 359, 0, 0, 0, 0, "linear_up");
}

_id_9A63() {
  level.player notify("started_dynamic_ambience");
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_large", 12, 24, 10, 12, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_medium_distant", 10, 20, 11, 16, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_small", 12, 19, 8, 12, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_long_close", 16, 29, 6, 10, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_long_dist", 14, 28, 15, 26, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_air_release_distant", 18, 30, 15, 17, 3000, 3001, 300, 270, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_impact_distant", 10, 18, 0, 3, 3000, 3001, 300, 0, 90, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_movement_distant_long", 14, 25, 8, 10, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_movement_distant_short", 9, 16, 3, 6, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_servo_distant", 8, 12, 6, 10, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_long_dist", 20, 30, 25, 28, 3000, 3001, 300, 180, 270, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_medium_distant", 15, 27, 21, 23, 3000, 3001, 300, 0, 180, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_medium_medium", 12, 20, 21, 23, 3000, 3001, 300, 0, 180, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_medium_close", 16, 26, 21, 23, 3000, 3001, 300, 180, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_short_distant", 22, 34, 1, 5, 3000, 3001, 300, 90, 180, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_alarm_buzzer", 20, 31, 13, 15, 5000, 5001, 300, 0, 100, 0, 0, 0, 0);
}

_id_4FC5() {
  level.player notify("started_dynamic_ambience");
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_large_deep", 12, 24, 10, 12, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_medium_distant_deep", 10, 20, 11, 16, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_ominous", 16, 30, 15, 20, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_small_deep", 12, 19, 8, 12, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_long_close_deep", 16, 29, 6, 10, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_long_dist_deep", 14, 28, 15, 26, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_air_release_distant_deep", 18, 30, 15, 17, 3000, 3001, 300, 270, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_impact_distant_deep", 10, 18, 0, 3, 3000, 3001, 300, 0, 90, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_movement_distant_long_deep", 14, 25, 8, 10, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_movement_distant_short_deep", 9, 16, 3, 6, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_servo_distant_deep", 8, 12, 6, 10, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_long_dist_deep", 20, 30, 25, 28, 3000, 3001, 300, 180, 270, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_medium_distant_deep", 15, 27, 21, 23, 3000, 3001, 300, 0, 180, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_medium_medium_deep", 12, 20, 21, 23, 3000, 3001, 300, 0, 180, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_medium_close_deep", 16, 26, 21, 23, 3000, 3001, 300, 180, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_short_distant_deep", 22, 34, 1, 5, 3000, 3001, 300, 90, 180, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_alarm_buzzer_deep", 20, 31, 13, 15, 5000, 5001, 300, 0, 100, 0, 0, 0, 0);
}

_id_3959() {
  while(isDefined(level._id_3965) == 0)
    scripts\engine\utility::waitframe();

  if(!isDefined(level._id_A73E) || !isDefined(level._id_A73C))
    scripts\sp\maps\sa_wounded\sa_wounded_fx::_id_3AB7();

  var_0 = scripts\engine\utility::spawn_tag_origin(level._id_A73E.origin + (-1500, 0, 0));
  var_1 = scripts\engine\utility::spawn_tag_origin(level._id_DBA9.origin + (-1500, 0, 0));
  var_2 = var_0.origin;
  var_3 = (var_2[0], var_2[1] + (var_1.origin[1] - var_2[1]) / 2, var_2[2]);
  var_4 = scripts\engine\utility::spawn_tag_origin(var_3);
  var_5 = scripts\engine\utility::spawn_tag_origin(var_3);
  var_0 linkTo(level._id_3965);
  var_1 linkTo(level._id_3965);
  var_4 linkTo(level._id_3965);
  var_5 linkTo(level._id_3965);
  var_0 playLoopSound("cap_jetwash_lp");
  var_1 playLoopSound("cap_jetwash_lp");
  var_4 playLoopSound("jetwash_cockpit_lr");
  var_5 playLoopSound("cap_jetwash_sweet_lp");
  thread _id_A48A(var_0, var_1, var_4, var_5);
}

_id_A48A(var_0, var_1, var_2, var_3) {
  while(isDefined(level._id_D127) == 0)
    scripts\engine\utility::waitframe();

  while(!scripts\engine\utility::flag("audio_entering_hangar")) {
    if(level._id_D127.origin[0] > var_0.origin[0]) {
      var_0 _meth_8278(0.2, 1);
      var_1 _meth_8278(0.2, 1);
      var_2 _meth_8278(0.1, 1);
      var_3 _meth_8278(0.1, 1);
    } else {
      var_0 _meth_8278(1, 1);
      var_1 _meth_8278(1, 1);
      var_2 _meth_8278(1, 1);
      var_3 _meth_8278(1, 1);
    }

    wait 0.1;
  }

  wait 3;
  var_0 _meth_8278(0, 1);
  var_1 _meth_8278(0, 1);
  var_2 _meth_8278(0, 1);
  var_3 _meth_8278(0, 1);
  var_0 stopsounds();
  var_1 stopsounds();
  var_2 stopsounds();
  var_3 stopsounds();
  scripts\engine\utility::waitframe();
  var_0 delete();
  var_1 delete();
  var_2 delete();
  var_3 delete();
}

_id_5D1C() {
  level.player playSound("sa_exterior_expl_1");
  level.player playSound("jackal_ambient_rattle_lg");
}

_id_3E62() {
  level.player playSound("chemical_grab");
}

_id_A37F() {
  wait 0.3;
  level.player playSound("chase_hanger_landing");
  wait 4.0;
  var_0 = 1.0;
  level.player clearclienttriggeraudiozone(var_0);
}

_id_A3A5() {
  self endon("stop_jackal_interior_sound");

  for(;;) {
    level.player playSound("jackal_ambient_rattle_sm");
    wait(randomfloatrange(0.1, 5));
  }
}

_id_A3A4() {
  self endon("stop_jackal_interior_sound");

  for(;;) {
    level.player playSound("jackal_ambient_rattle_lg");
    wait(randomfloatrange(1, 4));
  }
}

_id_11898() {
  self endon("stop_thunder_wind");
  level._id_D127 childthread _id_0F00::_id_FB7D("thunder_wind", 5, 10);
}

_id_4306() {
  self endon("stop_cockpit_debris");
  level._id_D127 childthread _id_0F00::_id_FB7D("moon_cockpit_debris", 1, 4);
}

_id_D06A() {
  level.player playSound("wounded_fall");
}
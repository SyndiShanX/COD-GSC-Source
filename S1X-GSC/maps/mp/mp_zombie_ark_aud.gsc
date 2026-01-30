/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_ark_aud.gsc
*****************************************/

main() {
  thread onplayerconnectedaudio();
  level.radioalive = 1;
  level.radioent1 = spawn("script_origin", (21316, 853, 742));
  level.radioent2 = spawn("script_origin", (21316, 853, 742));
  level.radioent3 = spawn("script_origin", (21316, 853, 742));
  level.radioent4 = spawn("script_origin", (21316, 853, 742));
  level.radioent5 = spawn("script_origin", (21316, 853, 742));
  level.radiostate = 1;
  thread radioswitchinit();
  level.customzombiemusicstates = ::customzombiemusicstates;
  level.aud_drunk_ent = spawn("script_origin", (0, 0, 0));
  level.aud_cage_playing = 0;
  level.aud_plinko_moving = 0;
  level.aud_play_stop_sound = 0;
  level.aud_plinko_ent = spawn("script_origin", (-128, 803, 1149));
  level.aud_plinko_gate_last_loc = 0;
  level.aud_plinko_machine_activated = 0;
}

onplayerconnectedaudio() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 clientaddsoundsubmix("master_mix");
    var_0 clientaddsoundsubmix("mute_security");
  }
}

customzombiemusicstates() {
  level thread maps\mp\zombies\_zombies_music::setupmusicstate(1, "round_normal", ["zmb_mus_wave_07_lp", "zmb_mus_wave_08_lp", "zmb_mus_wave_05_lp", "zmb_mus_wave_06_lp"], 0, 1, 1, 1);
  level thread maps\mp\zombies\_zombies_music::setupmusicstate(1, "round_zombie_dog", ["zmb_mus_spec_02_lp", "zmb_mus_wave_06_lp", "zmb_mus_wave_04_lp"], 0, 1, 1, 1);
  level thread maps\mp\zombies\_zombies_music::setupmusicstate(1, "round_zombie_host", ["zmb_mus_spec_02_lp", "zmb_mus_wave_06_lp", "zmb_mus_wave_04_lp"], 0, 1, 1, 1);
  level thread maps\mp\zombies\_zombies_music::setupmusicstate(2, "round_intermission", ["zmb_mus_postround", "zmb_mus_postround_02", "zmb_mus_postround_03", "zmb_mus_postround_04"], 0, 1, 1, 0);
  level thread maps\mp\zombies\_zombies_music::setupmusicstate(0, "victory", "zmb_mus_victory", 0, 0, 0, 0);
}

grenade_in_hopper() {
  level.aud_plinko_machine_activated = 1;
  playsoundatpos((-130, 803, 1157), "plinko_gren_in_hopper");
}

gate_moving(var_0, var_1) {
  if(var_0 < 0.2) {
    return;
  } else if(var_0 < 1) {
    if(abs(level.aud_plinko_gate_last_loc - var_1) > 30) {
      playsoundatpos((-128, 803, 1149), "plinko_hopper_move_start_fast");
      level.aud_play_stop_sound = 1;
    } else {
      playsoundatpos((-128, 803, 1149), "plinko_hopper_move_start");
    }

    level.aud_plinko_moving = 1;
    level.aud_plinko_ent playLoopSound("plinko_hopper_move");
    level.aud_plinko_gate_last_loc = var_1;
  } else if(level.aud_plinko_moving == 0) {
    level.aud_plinko_moving = 1;
    level.aud_play_stop_sound = 1;
    playsoundatpos((-128, 803, 1149), "plinko_hopper_move_start");

    if(level.aud_plinko_machine_activated) {
      level.aud_plinko_ent playLoopSound("plinko_hopper_move");
    }
  }
}

gate_stopped() {
  self endon("gates_moved");
  wait 0.1;

  if(level.aud_plinko_moving) {
    level.aud_plinko_ent stoploopsound();
    level.aud_plinko_moving = 0;

    if(level.aud_play_stop_sound) {
      playsoundatpos((-128, 803, 1149), "plinko_hopper_move_stop");
      level.aud_play_stop_sound = 0;
    }
  }
}

got_code() {
  self playlocalsound("ee_code_pickup");
}

code_accepted() {
  self playlocalsound("ee_code_accept");
}

idle_shark_sound() {
  for(;;) {
    self waittillmatch("shark_notetrack", "shark_anim_start");
    self playsoundonmovingent("zombie_shark_in_tank");
  }
}

start_obstacle_course() {
  activateclientexploder(200);
}

stop_obstacle_course() {
  stopclientexploder(200);

  foreach(var_1 in level.players) {
    var_1 thread mute_obstacle_field_hum();
  }
}

mute_obstacle_field_hum() {
  self clientaddsoundsubmix("mute_security2");
  wait 2;
  self clientclearsoundsubmix("mute_security2");
}

throw_rum_bottle(var_0) {
  wait 0.3;
  var_0 playSound("ee_bottle_drop");
}

drink_rum() {
  if(maps\mp\zombies\_util::is_true(self.intoxicated)) {
    return;
  }
  var_0 = "pilot_drink_exert";
  self playlocalsound("ee_drink_rum");
  wait 0.75;

  switch (self.characterindex) {
    case 0:
      var_0 = "guard_drink_exert";
      break;
    case 1:
      var_0 = "exec_drink_exert";
      break;
    case 2:
      var_0 = "it_drink_exert";
      break;
    case 3:
    default:
      if(maps\mp\zombies\_util::getzombieslevelnum() < 3) {
        var_0 = "janitor_drink_exert";
      }

      break;
  }

  self.isspeaking = 1;
  self playlocalsound(var_0);
  wait 0.75;
  self clientclearsoundsubmix("mute_security");
  self clientaddsoundsubmix("infected");
  level.aud_drunk_ent playLoopSound("ee_drunk_loop");
  self.isspeaking = 0;
}

rum_wears_off(var_0) {
  var_0 clientaddsoundsubmix("mute_security");
  var_0 clientclearsoundsubmix("infected");
  wait 5;
  level.aud_drunk_ent stoploopsound();
}

obstacle_course_complete() {
  foreach(var_1 in level.players) {
    var_1 playlocalsound("ee_obstacle_course_complete");
  }
}

teleporter_parts_missing() {
  playsoundatpos((-1869, 1181, 815), "teleporter_broken");
}

teleporter_place_parts(var_0) {
  self playlocalsound("ee_teleport_machine_repair");
  wait 1;
  playsoundatpos((-1869, 1181, 815), "teleporter_repair_progress_" + var_0);
}

teleporter_repaired() {
  playsoundatpos((-1869, 1181, 815), "teleporter_power_on");
  var_0 = spawn("script_origin", (-1869, 1181, 815));
  var_0 playLoopSound("teleporter_hum");
}

get_weapon_disposal_item(var_0) {
  self playlocalsound("ee_fishing_grab_item");
}

use_fishing_item(var_0) {
  if(var_0 == "reel") {
    playsoundatpos((-1647, -543, 1017), "ee_fishing_install_reel");
  } else if(var_0 == "line") {
    playsoundatpos((-1647, -543, 1017), "ee_fishing_install_line");
  } else if(var_0 == "hook") {
    playsoundatpos((-1647, -543, 1017), "ee_fishing_install_hook");
  }
}

fishing_cast_line() {
  playsoundatpos((-1647, -543, 1017), "ee_fishing_cast_line");
  wait 2;
  playsoundatpos((-1715, -543, 903), "ee_fishing_cast_splash");
}

fishing_retrieve_line() {
  wait 0.5;
  playsoundatpos((-1647, -543, 1017), "ee_fishing_retrieve_line");
  wait 1.3;
  playsoundatpos((-1715, -543, 903), "ee_fishing_retrieve_splash");
}

fishing_drop_item() {
  self playlocalsound("ee_fishing_drop_item");
  wait 0.8;
  playsoundatpos((-1715, -543, 903), "ee_fishing_cast_splash");
}

fishing_grab_item(var_0) {
  self playlocalsound("ee_fishing_grab_item");
}

island_timer_start() {
  self endon("disconnect");
  wait 5;
  self playlocalsound("ee_island_timer");
}

dig() {
  self playSound("ee_player_dig");
}

treasure_found() {
  self playSound("ee_treasure_found");
}

treasure_opened() {
  self playSound("ee_treasure_open");
}

switch_pickup() {
  self playlocalsound("ee_pickup_cage_switch");
}

switch_place_in_socket() {
  self playlocalsound("ee_cage_switch_place");
}

cage_switch() {
  playsoundatpos((157, 602, 890), "ee_cage_switch_throw");
}

cage_down() {
  playsoundatpos((731, 420, 958), "ee_shark_cage_lower");
  playsoundatpos((731, 420, 793), "zark_moonpool_doors_open");
  wait 3.5;
  playsoundatpos((731, 420, 793), "ee_shark_cage_splash");
}

cage_up() {
  if(level.aud_cage_playing == 0) {
    level.aud_cage_playing = 1;
    playsoundatpos((731, 420, 958), "ee_shark_cage_raise");
    wait 2.5;
    playsoundatpos((731, 420, 793), "zark_moonpool_doors_close");
    wait 5;
    level.aud_cage_playing = 0;
  }
}

shark_enters() {}

shark_loop() {}

shark_leaves() {}

shark_attack(var_0) {
  var_0 playlocalsound("ee_shark_attack");
}

grab_eyeball() {
  self playlocalsound("ee_eyeball");
}

open_locker(var_0) {
  playsoundatpos(var_0.origin, "ee_locker_opened");
}

radioswitchinit() {
  thread radioalivemonitor();
  var_0 = getent("island_radio", "targetname");
  var_1 = common_scripts\utility::cointoss();
  var_2 = "temp";

  if(var_1 == 0) {
    var_2 = "zmb_mus_radio_04";
  } else {
    var_2 = "zmb_mus_radio_05";
  }

  level.radioent2 scalevolume(0.02, 0.1);
  level.radioent3 scalevolume(0.02, 0.1);
  level.radioent4 scalevolume(0.02, 0.1);
  level.radioent1 playLoopSound("zmb_mus_radio_01");
  level.radioent2 playLoopSound("zmb_mus_radio_02");
  level.radioent3 playLoopSound("zmb_mus_radio_03");
  level.radioent4 playLoopSound(var_2);

  if(isDefined(var_0)) {
    for(;;) {
      var_0 waittill("trigger");

      if(level.radioalive == 1) {
        radiochangestation();
        level.radioent5 playSound("zmb_radio_change");
      }

      if(level.radioalive == 0) {}
    }
  }
}

radiochangestation() {
  if(level.radiostate == 1) {
    radiosetvolumes(2);
    level.radiostate = 2;
  } else if(level.radiostate == 2) {
    radiosetvolumes(3);
    level.radiostate = 3;
  } else if(level.radiostate == 3) {
    radiosetvolumes(1);
    level.radiostate = 4;
  } else if(level.radiostate == 4) {
    radiosetvolumes(2);
    level.radiostate = 5;
  } else if(level.radiostate == 5) {
    radiosetvolumes(3);
    level.radiostate = 6;
  } else if(level.radiostate == 6) {
    radiosetvolumes(1);
    level.radiostate = 7;
  } else if(level.radiostate == 7) {
    radiosetvolumes(2);
    level.radiostate = 8;
  } else if(level.radiostate == 8) {
    radiosetvolumes(3);
    level.radiostate = 9;
  } else if(level.radiostate == 9) {
    radiosetvolumes(1);
    level.radiostate = 10;
  } else if(level.radiostate == 10) {
    radiosetvolumes(2);
    level.radiostate = 11;
  } else if(level.radiostate == 11) {
    radiosetvolumes(3);
    level.radiostate = 12;
  } else if(level.radiostate == 12) {
    radiosetvolumes(1);
    level.radiostate = 13;
  } else if(level.radiostate == 13) {
    radiosetvolumes(4);
    level.radiostate = 1;
  } else {}
}

radiosetvolumes(var_0) {
  var_1[1] = level.radioent1;
  var_1[2] = level.radioent2;
  var_1[3] = level.radioent3;
  var_1[4] = level.radioent4;
  var_1[1] scalevolume(0.02, 0.1);
  var_1[2] scalevolume(0.02, 0.1);
  var_1[3] scalevolume(0.02, 0.1);
  var_1[4] scalevolume(0.02, 0.1);
  var_1[var_0] scalevolume(1.0, 0.1);
}

radioalivemonitor() {
  var_0 = getent("island_radio_dmg", "targetname");
  wait 0.5;
  var_0 waittill("trigger", var_1);
  level.radioalive = 0;
  level.radioent1 scalevolume(0.0, 0.1);
  level.radioent2 scalevolume(0.0, 0.1);
  level.radioent3 scalevolume(0.0, 0.1);
  level.radioent4 scalevolume(0.0, 0.1);
  wait 1;
  level.radioent1 delete();
  level.radioent2 delete();
  level.radioent3 delete();
  level.radioent4 delete();
  level.radioent5 delete();
}
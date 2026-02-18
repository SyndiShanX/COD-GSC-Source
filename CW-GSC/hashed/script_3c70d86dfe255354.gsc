/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3c70d86dfe255354.gsc
***********************************************/

#using script_3dc93ca9902a9cda;
#using script_86ebb5dd573a003;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\teleport_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\util;
#namespace namespace_3e1df757;

function init() {}

function function_459479b6() {}

function function_3102d55b() {
  if(isDefined(level.intro_music) == 0) {}
}

function function_8ecbf13c(guy) {
  thread function_9ddf3464();
}

function function_9ddf3464() {
  snd::wait_init();

  if(isDefined(level.var_a21c4cd1) == 0) {
    level waittill(#"hash_7f7d6afd4a2b34ce");
    level.var_a21c4cd1 = undefined;
  }
}

function function_fafe48ab() {
  wait 3;
}

function function_dda7b522() {
  wait 10;
  wait 15;
  level flag::wait_till("player_in_bar");
  level flag::wait_till("flag_found_contact");
  music::setmusicstate("");
}

function function_b8875614() {
  if(isDefined(level.var_a4604f0b) == 0) {
    level waittill(#"hash_5a450f78eb5b0fcf");
    level.var_a4604f0b = undefined;
  }
}

function function_2a14a407() {
  level waittill(#"apartment_explosive_placed");
}

function function_cb9087f2() {
  level notify(#"hash_7f7d6afd4a2b34ce");
}

function function_84a289c9() {
  wait 5;
  wait 5;
  wait 26;
}

function function_680be032() {
  level.var_6a42da5d = undefined;
}

function function_db44861a() {
  if(isDefined(level.var_a74423a9) == 0) {
    wait 8;
    wait 41;
    level waittill(#"hash_23f29d4743d9c8b5");
    wait 12;
    level flag::wait_till("at_escape_car");
    level.var_1bf78f11 = undefined;
    level.var_a21c4cd1 = undefined;
  }
}

function function_1bf78f11() {
  if(isDefined(level.intro_music) == 1) {
    return;
  }

  if(isDefined(level.var_1bf78f11) == 0 && isDefined(level.start_point) == 1 && level.start_point != "gl_demo") {
    wait 5;
    level flag::wait_till("at_escape_car");
    level.var_1bf78f11 = undefined;
  }
}

function function_4ead2f45() {
  thread function_1e72a624("apt_transition");
}

function function_fabce54(guy) {
  level flag::wait_till_any(array("apt_street_lobby_entry", "flag_inside_lobby"));
  thread function_1e72a624("lobby_musak");
}

function function_b524c30d() {
  level flag::wait_till("apt_street_done");
  level flag::set("flag_apartment_door_open");
  thread function_1e72a624("stop_lobby_musak");
  thread function_1e72a624("drone1");
  thread function_1e72a624("drone3");
  thread function_1e72a624("stinger_wife");
  thread function_1e72a624("wife_darted");
  thread function_1e72a624("stinger_shadow_1");
  thread function_1e72a624("stinger_shadow_2");
  thread function_1e72a624("stinger_use_briefcase");
  thread function_1e72a624("stinger_betrayal");
  time = 3;
  limit = 2;
  thread function_4c8d0d5d(time, limit);
}

function function_1e72a624(music) {
  switch (music) {
    case # "apt_transition":
      wait 10;
      wait 20;
      break;
    case # "lobby_musak":
      break;
    case # "stop_lobby_musak":
      break;
    case # "drone1":
      level flag::wait_till("flag_see_kraus_shadow");
      break;
    case # "drone3":
      level flag::wait_till("flag_see_kraus_shadow");
      level flag::wait_till("flag_start_betrayal");
      break;
    case # "stinger_wife":
      level flag::wait_till("flag_1st_entry_front_door");
      level.var_1ab56aba = 1.7;
      wait 1.2;
      break;
    case # "wife_darted":
      level.var_3559e9e waittill(#"darted", #"death");
      level.var_1ab56aba = 1.3;
      break;
    case # "stinger_shadow_1":
      level flag::wait_till("flag_see_kraus_shadow");
      level.var_1ab56aba = 0.9;
      thread function_3a85df46();
      wait 1.5;
      break;
    case # "stinger_shadow_2":
      level flag::wait_till("flag_see_kraus_shadow_2");
      level.var_1ab56aba = 0.5;
      break;
    case # "stinger_use_briefcase":
      level flag::wait_till("flag_start_betrayal");
      wait 1;
      level flag::set("flag_stop_timer_audio");
      break;
    case # "stinger_betrayal":
      getplayers()[0] waittill(#"hash_1c40b84cb7816a58", #"death");
      break;
  }
}

function function_3a85df46() {
  if(!isDefined(level.var_8c3480d2)) {
    iprintlnbold("<dev string:x38>");

    return;
  }

  while(level.var_8c3480d2 > 0.1) {
    level.var_8c3480d2 *= 0.9;
    wait 1;
  }
}

function function_4c8d0d5d(time, limit) {
  getplayers()[0] endon(#"death");
  level.var_87fd218c = time;
  level.var_1ab56aba = limit;
  level.var_8c3480d2 = 1;

  while(!level flag::get("flag_stop_timer_audio")) {
    if(level.var_8c3480d2 < 0.1) {}

    getplayers()[0] notify(#"hash_424d09b390df49ba");
    function_e53faedd();

    if(level.var_8c3480d2 < 0.1) {}

    getplayers()[0] notify(#"hash_4a573d79afe442ff");
    function_e53faedd();
  }
}

function function_e53faedd() {
  wait level.var_87fd218c;
  level.var_87fd218c *= 0.97;

  if(level.var_87fd218c < level.var_1ab56aba) {
    level.var_87fd218c = level.var_1ab56aba;
  }
}
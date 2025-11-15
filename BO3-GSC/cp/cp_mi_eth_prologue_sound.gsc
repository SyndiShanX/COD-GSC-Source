/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_mi_eth_prologue_sound.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_util;
#using scripts\shared\music_shared;
#using scripts\shared\util_shared;
#namespace cp_mi_eth_prologue_sound;

function main() {
  level thread function_b3c510e0();
  level thread function_96d9cac5();
  level thread function_8066773b();
  level thread function_a4815b6c();
  level thread function_44ee5cb7();
  level thread function_a4312bfe();
  level thread namespace_21b2c1f2::function_7a818f3c();
}

function function_b3c510e0() {
  soundstruct = getent("amb_garbled_screen", "targetname");
  if(isDefined(soundstruct)) {
    soundstruct playLoopSound("amb_garbled_voice");
  }
}

function function_96d9cac5() {
  sound_org = getent("amb_offices", "targetname");
  if(isDefined(sound_org)) {
    sound_org playLoopSound("amb_offices");
  }
  level waittill("hash_400d768d");
  level thread namespace_21b2c1f2::function_973b77f9();
  if(isDefined(sound_org)) {
    sound_org stoploopsound();
    playsoundatposition("amb_power_down", sound_org.origin);
  }
}

function function_8066773b() {
  var_30031844 = getEntArray("amb_office_power_on", "targetname");
  for(i = 0; i < var_30031844.size; i++) {
    var_30031844[i] thread function_55f749fc();
  }
}

function function_55f749fc() {
  self playLoopSound(self.script_sound);
  level waittill("hash_400d768d");
  self stoploopsound();
  wait(randomfloatrange(0.2, 3.1));
  self playSound("amb_spark_generic");
}

function function_a4815b6c() {
  level endon("breech");
  level endon("game_ended");
  level waittill("siren");
  while(true) {
    wait(2);
    playsoundatposition("amb_troop_alarm", (3529, 427, -334));
  }
}

function function_44ee5cb7() {
  level endon("breech");
  level endon("game_ended");
  level waittill("hash_5ea48ae9");
  while(true) {
    wait(1);
    playsoundatposition("amb_troop_alarm", (5945, -2320, -119));
  }
}

function function_a4312bfe() {
  level endon("hash_f8e975b8");
  level waittill("hash_fc089399");
  while(true) {
    wait(1);
    playsoundatposition("amb_phone_ring", (-1760, -1624, 384));
    wait(2);
  }
}

#namespace namespace_21b2c1f2;

function function_973b77f9() {
  music::setmusicstate("none");
}

function play_intro_igc() {
  music::setmusicstate("intro_igc");
}

function play_outro_igc() {
  music::setmusicstate("outro_igc");
}

function function_e245d17f() {
  music::setmusicstate("nrc_knocks");
}

function function_fd00a4f2() {
  music::setmusicstate("door_breach");
}

function function_e847067() {
  music::setmusicstate("scanning_for_minister");
}

function function_fa2e45b8() {
  wait(16);
  music::setmusicstate("battle_1");
}

function function_baefe66d() {
  music::setmusicstate("battle_1");
}

function function_d4c52995() {
  music::setmusicstate("tension_loop");
}

function function_2f85277b() {
  wait(1.5);
  music::setmusicstate("minister_rescued");
}

function function_fb4a2ce1() {
  music::setmusicstate("khalil_rescue");
}

function function_1c0460dd() {
  music::setmusicstate("battle_2_intro_loop");
}

function function_6c35b4f3() {
  music::setmusicstate("battle_2");
}

function function_49fef8f4() {
  music::setmusicstate("gather_loop");
}

function function_9f50ebc2() {
  wait(3);
  music::setmusicstate("none");
}

function function_c4c71c7() {
  wait(3);
  music::setmusicstate("drop_your_weapons");
}

function function_43ead72c(a_ents) {
  wait(10);
  music::setmusicstate("taylor_entrance");
}

function function_46333a8a() {
  wait(3);
  music::setmusicstate("battle_3");
}

function function_37906040() {
  music::setmusicstate("hall_stinger");
}

function function_7a818f3c() {
  level waittill("hash_64976832");
  music::setmusicstate("hall_heroic_run");
}

function function_b83aa9c5() {
  wait(6);
  music::setmusicstate("battle_4");
}

function function_3c37ec50() {
  music::setmusicstate("dark_pad");
}

function function_a0f24f9b() {
  music::setmusicstate("office_battle");
}

function function_2a66b344() {
  music::setmusicstate("post_office_drone");
}

function function_63ffe714() {
  music::setmusicstate("vtol_approach");
}

function function_f573bcb9() {
  music::setmusicstate("taylor_is_a_hero");
  util::clientnotify("saw");
}

function function_448421b7() {
  music::setmusicstate("robot_entrance");
}

function function_fb0b7bb6() {
  music::setmusicstate("post_robot_horde");
}

function function_37a511a() {
  music::setmusicstate("dark_loop_pre_apc");
}

function function_da98f0c7() {
  music::setmusicstate("apc_rail");
}

function function_27bc11a3() {
  music::setmusicstate("crash");
}

function function_8feece84() {
  music::setmusicstate("apc_rail");
}

function function_92382f5c() {
  wait(3);
  music::setmusicstate("battle_5");
}

function function_fcb67450() {
  music::setmusicstate("skycrane");
}
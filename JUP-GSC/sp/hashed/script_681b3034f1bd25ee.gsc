/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_681b3034f1bd25ee.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp\cp_audio;
#using scripts\cp\utility;
#using scripts\engine\utility;
#namespace namespace_69ea95a8f8923497;

function main() {
  while(!isDefined(level.player)) {
    waitframe();
  }

  level.player setsoundsubmix("cp_jup_apt_default");
  level.player clearsoundsubmix("cp_jup_apt_combat", 0);
  thread function_4edc5479d9ca43a("balcony_clear", "cp_jup_apt_combat", 1, 8);
  location_list = [(2065, 1978, 1026), (1793, 3819, 1084), (2619, 3575, 1240), (2943, 3537, 1298), (1728, 1961, 1778), (2711, 1692, 1400), (3015, 2782.6, 1330), (2070, 1912, 1800), (2975, 3612, 1850), (2661, 1826, 1826), (1800, 3840, 1800), (3560, 1728, 1800), (3190, 2628, 1810)];
  thread scripts\cp\cp_audio::function_ec9b3af8f8e2d59f(4, "balcony_clear", "jup_apt_alarm_a_close", "cp_jup_apt_alarm_attenuate", location_list);
}

function function_4edc5479d9ca43a(stop_flag, submix, var_fd3848745fed2346, var_5ba95f0968004ed7) {
  level endon("game_ended");
  var_48f15edf0b01719e = "hidden";

  while(!flag(stop_flag)) {
    if(var_48f15edf0b01719e != function_eac0cd99c9c6d8ee()) {
      if(function_eac0cd99c9c6d8ee() == "hidden") {
        level.player clearsoundsubmix(submix, var_5ba95f0968004ed7);
      } else if(function_eac0cd99c9c6d8ee() == "spotted") {
        level.player setsoundsubmix(submix, var_fd3848745fed2346);
      }
    }

    var_48f15edf0b01719e = function_eac0cd99c9c6d8ee();
    wait 0.5;
  }
}

function function_63e6de435da0d83f() {
  setglobalsoundcontext("jup_shoulder_carry", "fly_hvt_carry");
}

function function_55b61726e8e1f043() {
  setglobalsoundcontext("jup_shoulder_carry", "");
}

function function_854485abe0254369(linkpos) {
  level.player setsoundsubmix("jup_cp_apt_container_enemy_moment");
  linkpos playsoundonmovingent("cp_apt_scn_enemy_container_drop");
  wait 4;
  level.player clearsoundsubmix("jup_cp_apt_container_enemy_moment");
}

function function_ae0a4a264baff88c(linkpos) {
  linkpos stopsounds();
  waitframe();
  linkpos playsoundonmovingent("cp_apt_scn_enemy_container_death_vo_2");
}

function function_1db933d9a1fea0e7() {
  level.player setsoundsubmix("jup_cp_apt_infil_basement");
}

function function_6c83d1f9b8824de2() {
  level.player clearsoundsubmix("jup_cp_apt_infil_basement");
}

function function_b248bf57abb8eb43() {
  level.player setsoundsubmix("jup_cp_apt_price_sniper_scene_mix");
}

function function_87fa20426a85dd01(var_aa530e82ac4b938b) {
  level waittill("price_fire");
  var_aa530e82ac4b938b playSound("cp_apt_scn_price_zipline_shot_whizby");
}

function function_62e0ae6e1529d894(var_aa530e82ac4b938b) {
  var_aa530e82ac4b938b playSound("cp_apt_scn_price_zipline_bullet_impact");
}

function function_a60e7c732b5440e2(var_a2e02bc146e6ebfd) {
  playsoundatpos(var_a2e02bc146e6ebfd, "zipline_rope_lower");
}

function function_8d21939fb067fc32() {
  level.player setsoundsubmix("jup_cp_apt_hvt_skyhook_attach", 2);
}

function function_f62c9a99dcc80e17() {
  level.player clearsoundsubmix("jup_cp_apt_hvt_skyhook_attach", 0.5);
}

function function_515796d61b108c60() {
  level.player setsoundsubmix("jup_cp_apt_skyhook_exfil", 2);
  wait 7.5;
  level.player setsoundsubmix("jup_cp_apt_skyhook_exfil_yoink");
}

function function_1f92d589b3ae4c01() {
  level.player setsoundsubmix("jup_cp_apt_skyhook_exfil_fade_to_black");
  level.player clearsoundsubmix("jup_cp_apt_skyhook_exfil");
  level.player clearsoundsubmix("jup_cp_apt_skyhook_exfil_yoink");
  level.player clearsoundsubmix("cp_jup_apt_default");
}

function function_c1aee80b88bad254() {
  level.player setsoundsubmix("jup_cp_apt_rooftop_helicopter_scene_mix");
}

function function_d1b66b48341bf2ea(var_9c6043b223bcc972, var_9c6042b223bcc73f) {
  var_9c6043b223bcc972 playsoundonmovingent("veh_jup_apt_enemy_heli_fly_in_1b");
  var_9c6042b223bcc73f playsoundonmovingent("veh_jup_apt_enemy_heli_fly_in_1a");
}

function function_8681483e6d3d3522(var_9c6043b223bcc972) {
  var_9c6043b223bcc972 playsoundonmovingent("veh_jup_apt_enemy_heli_fly_in_2a");
}

function function_573981212498b10b(var_9c6042b223bcc73f) {
  var_9c6042b223bcc73f playsoundonmovingent("veh_jup_apt_enemy_heli_fly_in_2b");
}

function function_9e0d228709e80dbc(var_9c6043b223bcc972, var_9c6042b223bcc73f) {
  var_9c6043b223bcc972 playsoundonmovingent("veh_jup_apt_enemy_heli_fly_in_3a");
  var_9c6042b223bcc73f playsoundonmovingent("veh_jup_apt_enemy_heli_fly_in_3b");
}

function function_6c22b1feac90c495() {
  level.player playSound("jup_door_wood_stuck_01");
}
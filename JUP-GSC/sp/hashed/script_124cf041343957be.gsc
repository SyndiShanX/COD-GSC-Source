/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_124cf041343957be.gsc
*************************************************/

#using script_19163c4e4e504a5e;
#using script_1db908936531314b;
#using script_53f4e6352b0b2425;
#using script_6bf6c8e2e1fdccaa;
#using scripts\common\anim;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\utility;
#namespace namespace_903e62fdf3033337;

function main() {
  while(!isDefined(level.player)) {
    waitframe();
  }

  thread function_e6926f1db06eb503();
}

function function_e6926f1db06eb503() {
  waitframe();
  level.player setsoundsubmix("sp_jup_milbase_global_mix", 0, 1);
}

function jltv1() {
  if(isDefined(level.var_d4ce7a272ba5d4b0)) {
    level.var_d4ce7a272ba5d4b0 vehicle_turnengineoff();
    wait 0.5;
    snd_play("jup_milbase_jltv1_engine_in", level.var_d4ce7a272ba5d4b0);
    wait 3;
    snd_play("jup_milbase_jltv1_engine_seek", level.var_d4ce7a272ba5d4b0);
  }
}

function jltv2() {
  if(isDefined(level.var_a7eb2624fdb259e6)) {
    level.var_a7eb2624fdb259e6 vehicle_turnengineoff();
  }
}

function function_f14533e453bdebd3() {
  if(isDefined(level.var_a7eb2824fdb25e4c)) {
    level.var_a7eb2824fdb25e4c vehicle_turnengineoff();
    snd_play("jup_milbase_jltv4_pt1_engine", level.var_a7eb2824fdb25e4c);
  }
}

function function_f14534e453bdee06() {
  if(isDefined(level.var_a7eb2824fdb25e4c)) {
    snd_play("jup_milbase_jltv4_pt2_engine", level.var_a7eb2824fdb25e4c);
  }
}

function function_f14535e453bdf039() {
  if(isDefined(level.var_a7eb2824fdb25e4c)) {
    snd_play("jup_milbase_jltv4_pt3_engine", level.var_a7eb2824fdb25e4c);
  }
}

function function_f14536e453bdf26c() {
  if(isDefined(level.var_a7eb2824fdb25e4c)) {
    snd_play("jup_milbase_jltv4_pt4_engine", level.var_a7eb2824fdb25e4c);
  }
}

function cargo_truck() {
  if(isDefined(level.var_da38302e01d23b97)) {
    level.var_da38302e01d23b97 vehicle_turnengineoff();
    snd_play("jup_milbase_cargo_truck_engine", level.var_da38302e01d23b97);
    wait 15;
    snd_play("jup_milbase_cargo_truck_stop", level.var_da38302e01d23b97);
  }
}

function cargo_truck2() {
  if(isDefined(level.var_bbcd9a2e01592bdf)) {
    level.var_bbcd9a2e01592bdf vehicle_turnengineoff();
  }
}

function heli1() {
  wait 3.5;
  level.heli_hind playsoundonmovingent("jup_milbase_heli1_seek");
}

function heli2() {}

function function_8d5f368f1a68af0b() {
  level.player setsoundsubmix("sp_jup_milbase_keycard_pickup");
}

function function_8868b1102543bfc3() {
  level.player setsoundsubmix("sp_jup_milbase_yuri_blink");
  level.player clearsoundsubmix("sp_jup_milbase_keycard_pickup");
}

function function_e7d14c9764d93d0f() {
  level.player clearsoundsubmix("sp_jup_milbase_yuri_blink");
}

function function_2a601799e4831973() {
  level.player setsoundsubmix("sp_jup_milbase_escape_sequence");
  var_2dec36d542b42af7 = (6243, 48243, 1094);
  playsoundatpos(var_2dec36d542b42af7, "sp_jup_milbase_panic_walla_front_entrance");
  var_c47a52768ebdf37 = (6221, 47768, 1096);
  playsoundatpos(var_c47a52768ebdf37, "sp_jup_milbase_panic_walla_lobby");
  var_43d1a8d4c3da5f73 = (6097, 48107, 1095);
  var_87725b8e1d649248 = snd_play([0, "sp_jup_milbase_gas_cloud_front_entrance", 0.5], var_43d1a8d4c3da5f73);
  level waittill("move_civ_1");
  panic_walla_first_hall_01 = (6381, 47680, 1036);
  playsoundatpos(panic_walla_first_hall_01, "sp_jup_milbase_panic_walla_first_hall_01");
  level waittill("move_civ_2");
  panic_walla_first_hall_02 = (6683, 47171, 1036);
  playsoundatpos(panic_walla_first_hall_02, "sp_jup_milbase_panic_walla_first_hall_02");
  level waittill("vo_gas_4");
  var_641ef37d60b5fb8b = (6950, 47057, 1096);
  playsoundatpos(var_641ef37d60b5fb8b, "sp_jup_milbase_panic_walla_stairwell");
  level waittill("gas_5");
  panic_walla_second_hall_01 = (6266, 47192, 1204);
  playsoundatpos(panic_walla_second_hall_01, "sp_jup_milbase_panic_walla_second_hall_01");
  level waittill("gas_flee_spawn");
  panic_walla_second_hall_02 = (6320, 46870, 1216);
  playsoundatpos(panic_walla_second_hall_02, "sp_jup_milbase_panic_walla_second_hall_02");
  level waittill("gas_7");
  panic_walla_third_hall_01 = (6426, 46979, 1552);
  playsoundatpos(panic_walla_third_hall_01, "sp_jup_milbase_panic_walla_third_hall_01");
  level waittill("vo_gas_8");
  panic_walla_third_hall_02 = (6536, 46972, 1508);
  playsoundatpos(panic_walla_third_hall_02, "sp_jup_milbase_panic_walla_third_hall_02");
}

function function_19813e462cbab96c() {
  level.player playSound("sp_jup_milbase_pre_exfil_heli_incoming");
  var_8e3b83bdc37ff852 = (6959, 47003, 1694);
  var_9fad48ba63c620b3 = snd_play("sp_jup_milbase_pre_exfil_heli_lp", var_8e3b83bdc37ff852);
  function_74726126b3d8b0aa(var_9fad48ba63c620b3, "start_heli_exfil", 1);
  level.player clearsoundsubmix("sp_jup_milbase_escape_sequence");
}

function function_d832a8c5ebdf4139() {
  level.player playSound("sp_jup_milbase_exfil_heli_incoming");
  var_41c97e6bfd9c695e = (6959, 47003, 1694);
  heli_idle_lp = snd_play("sp_jup_milbase_exfil_heli_idle", var_41c97e6bfd9c695e);
  function_74726126b3d8b0aa(heli_idle_lp, "chopper_reached", 2);
}

function function_a8ee3f549e9967e3() {
  level.player clearsoundsubmix("sp_jup_milbase_escape_sequence");
  level.player setsoundsubmix("sp_jup_milbase_exfil");
  level.player playSound("sp_jup_milbase_exfil_heli_takeoff");
}
/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_red_door_riddle_event.gsc
*************************************************************/

function init() {
  if(getdvarint("scr_br_warpDoorRiddle", 0) == 0) {
    return;
  }

  level.ref_12aaf = spawnStruct();
  level.ref_12aaf.ref_138b0 = ["dx_brm_stc_numbers_0_10", "dx_brm_stc_numbers_1_10", "dx_brm_stc_numbers_2_10", "dx_brm_stc_numbers_3_10", "dx_brm_stc_numbers_4_10", "dx_brm_stc_numbers_5_10", "dx_brm_stc_numbers_6_10", "dx_brm_stc_numbers_7_10", "dx_brm_stc_numbers_8_10", "dx_brm_stc_numbers_9_10", "dx_brm_stc_numbers_10_10", "dx_brm_stc_numbers_11_10", "dx_brm_stc_numbers_12_10", "dx_brm_stc_numbers_13_10", "dx_brm_stc_numbers_14_10", "dx_brm_stc_numbers_15_10", "dx_brm_stc_numbers_16_10", "dx_brm_stc_numbers_17_10", "dx_brm_stc_numbers_18_10", "dx_brm_stc_numbers_19_10", "dx_brm_stc_numbers_20_10", "dx_brm_stc_numbers_21_10", "dx_brm_stc_numbers_22_10", "dx_brm_stc_numbers_23_10", "dx_brm_stc_numbers_24_10", "dx_brm_stc_numbers_25_10", "dx_brm_stc_numbers_26_10"];
  level.ref_12aaf.ref_138af = [];
  level.ref_12aaf.ref_138af[1] = [12, 1, 25];
  level.ref_12aaf.ref_138af[2] = [20, 8, 5];
  level.ref_12aaf.ref_138af[3] = [11, 9, 14, 7];
  level.ref_12aaf.ref_138af[4] = [20, 15];
  level.ref_12aaf.ref_138af[5] = [6, 9, 14, 1, 12];
  level.ref_12aaf.ref_138af[6] = [18, 5, 19, 20];
  level.ref_12aaf.ref_138af[7] = [1, 2, 15, 22, 5];
  level.ref_12aaf.ref_138af[8] = [20, 8, 5];
  level.ref_12aaf.ref_138af[9] = [2, 15, 14, 5, 19];
  level.ref_12aaf.ref_138af[10] = [15, 6];
  level.ref_12aaf.ref_138af[11] = [19, 9, 24];
  level.ref_12aaf.ref_138af[12] = [6, 5, 5, 20];
  level.ref_12aaf.ref_138af[13] = [4, 5, 16, 20, 8];
  level.ref_12aaf.ref_12d38 = [];
  level.ref_12aaf.ref_12d37 = (-17065, -1628, -259);
  thread amped_victim_starttime();
}

function supersbyextraweapon() {
  level.ref_12aaf = spawnStruct();
  level.ref_12aaf.safesetalpha = ["dx_bra_gfac_control_numbers_eviscerate", "dx_bra_gfac_control_numbers_give_break", "dx_bra_gfac_control_numbers_kill_count", "dx_bra_gfac_control_numbers_lose_count", "dx_bra_gfac_control_numbers_who_cares", "dx_bra_gfac_control_numbers_yada"];
  level.ref_12aaf.ref_12d38 = [];
}

function amped_victim_starttime() {
  level waittill("prematch_fade_done");
  var_0 = easepower("br_dirt_mound_event", level.ref_12aaf.ref_12d37);
  var_0.keepinmap = 1;
  scripts\engine\scriptable::scriptable_addusedcallback(&adrenaline_crate_spawn);
}

function adrenaline_crate_spawn(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0.type) || var_0.type != "br_dirt_mound_event") {
    return;
  }

  var_5 = var_3 getcurrentweapon();
  var_6 = 1;
  var_6 &= isDefined(var_5.basename) && var_5.basename == "iw8_me_t9cane_mp";
  var_7 = istrue(var_3.ref_12ab0);
  var_8 = var_6 && !var_7 && istrue(var_3.show_charge);

  if(var_8) {
    var_3 scripts\cp\vehicles\vehicle_compass_cp::ref_120a4("control_room_puzzle_completed");
    var_9 = getdvarint("scr_br_warpDoor_riddleReward", 5000);
    var_10 = int(var_9 / 100);
    var_3 scripts\mp\gametypes\br_plunder::ref_12627(var_10);
    var_3 playsoundtoplayer("br_splash_mission_complete", var_3);
    var_3 thread scripts\mp\hud_message::showsplash("br_red_door_control_room_splash", 99);
    var_3.ref_12ab0 = 1;
    var_3.show_charge = undefined;
  } else {
    var_3 playsoundtoplayer("br_splash_mission_failure", var_3);
  }

  if(var_1 == "mound" && var_2 == "usable") {
    var_0 setscriptablepartstate("mound", "used");
    return;
  }
}

function ref_13871(var_0, var_1) {
  if(!isDefined(level.ref_12aaf)) {
    return;
  }

  if(istrue(level.ref_12aaf.ref_12d38[var_0])) {
    return;
  }

  level.ref_12aaf.ref_12d38[var_0] = 1;

  if(getdvarint("scr_br_warpDoorHweenEnabled", 0)) {
    thread ref_1273a(var_0, var_1);
    return;
  }

  thread ref_12761(var_0, var_1);
}

function ref_1273a(var_0, var_1) {
  level endon("game_ended");
  var_2 = randomint(level.ref_12aaf.safesetalpha.size);
  var_3 = isDefined(var_2);

  if(!var_3) {
    return;
  }

  wait 4;
  var_4 = "dx_brm_cont_speaker_message_0";
  playsoundatpos(var_1, var_4);
  wait 2.5;
  var_5 = level.ref_12aaf.safesetalpha[var_2];
  playsoundatpos(var_1, var_5);
  level.ref_12aaf.ref_12d38[var_0] = 0;
}

function ref_12761(var_0, var_1) {
  level endon("game_ended");
  var_2 = level.ref_12aaf.ref_138af[var_0];
  var_3 = isDefined(var_2);

  if(!var_3) {
    return;
  }

  for(var_4 = 0; var_4 < 4; var_4++) {
    wait 4;
    var_5 = "dx_brm_cont_speaker_message_0";
    playsoundatpos(var_1, var_5);

    foreach(var_7 in var_2) {
      wait 2.5;
      var_8 = level.ref_12aaf.ref_138b0[var_7];
      playsoundatpos(var_1, var_8);
    }
  }

  level.ref_12aaf.ref_12d38[var_0] = 0;
}
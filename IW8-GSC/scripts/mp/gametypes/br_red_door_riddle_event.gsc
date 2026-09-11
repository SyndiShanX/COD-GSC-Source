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
  var0 = easepower("br_dirt_mound_event", level.ref_12aaf.ref_12d37);
  var0.keepinmap = 1;
  scripts\engine\scriptable::scriptable_addusedcallback(&adrenaline_crate_spawn);
}

function adrenaline_crate_spawn(var0, var1, var2, var3, var4) {
  if(!isDefined(var0.type) || var0.type != "br_dirt_mound_event") {
    return;
  }

  var5 = var3 getcurrentweapon();
  var6 = 1;
  var6 &= isDefined(var5.basename) && var5.basename == "iw8_me_t9cane_mp";
  var7 = istrue(var3.ref_12ab0);
  var8 = var6 && !var7 && istrue(var3.show_charge);

  if(var8) {
    var3 scripts\cp\vehicles\vehicle_compass_cp::ref_120a4("control_room_puzzle_completed");
    var9 = getdvarint("scr_br_warpDoor_riddleReward", 5000);
    var10 = int(var9 / 100);
    var3 scripts\mp\gametypes\br_plunder::ref_12627(var10);
    var3 playsoundtoplayer("br_splash_mission_complete", var3);
    var3 thread scripts\mp\hud_message::showsplash("br_red_door_control_room_splash", 99);
    var3.ref_12ab0 = 1;
    var3.show_charge = undefined;
  } else {
    var3 playsoundtoplayer("br_splash_mission_failure", var3);
  }

  if(var1 == "mound" && var2 == "usable") {
    var0 setscriptablepartstate("mound", "used");
    return;
  }
}

function ref_13871(var0, var1) {
  if(!isDefined(level.ref_12aaf)) {
    return;
  }

  if(istrue(level.ref_12aaf.ref_12d38[var0])) {
    return;
  }

  level.ref_12aaf.ref_12d38[var0] = 1;

  if(getdvarint("scr_br_warpDoorHweenEnabled", 0)) {
    thread ref_1273a(var0, var1);
    return;
  }

  thread ref_12761(var0, var1);
}

function ref_1273a(var0, var1) {
  level endon("game_ended");
  var2 = randomint(level.ref_12aaf.safesetalpha.size);
  var3 = isDefined(var2);

  if(!var3) {
    return;
  }

  wait 4;
  var4 = "dx_brm_cont_speaker_message_0";
  playsoundatpos(var1, var4);
  wait 2.5;
  var5 = level.ref_12aaf.safesetalpha[var2];
  playsoundatpos(var1, var5);
  level.ref_12aaf.ref_12d38[var0] = 0;
}

function ref_12761(var0, var1) {
  level endon("game_ended");
  var2 = level.ref_12aaf.ref_138af[var0];
  var3 = isDefined(var2);

  if(!var3) {
    return;
  }

  for(var4 = 0; var4 < 4; var4++) {
    wait 4;
    var5 = "dx_brm_cont_speaker_message_0";
    playsoundatpos(var1, var5);

    foreach(var7 in var2) {
      wait 2.5;
      var8 = level.ref_12aaf.ref_138b0[var7];
      playsoundatpos(var1, var8);
    }
  }

  level.ref_12aaf.ref_12d38[var0] = 0;
}
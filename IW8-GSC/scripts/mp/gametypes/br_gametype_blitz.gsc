/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_blitz.gsc
******************************************************/

function init() {
  level.computer_animation_off = spawnStruct();
  var0 = getdvarint("scr_blitz_circle_delay_time_1", 0);
  var1 = getdvarint("scr_blitz_circle_delay_time_2", 45);
  var2 = getdvarint("scr_blitz_circle_delay_time_3", 20);
  var3 = getdvarint("scr_blitz_circle_delay_time_4", 20);
  var4 = getdvarint("scr_blitz_circle_delay_time_5", 15);
  var5 = getdvarint("scr_blitz_circle_delay_time_6", 15);
  var6 = getdvarint("scr_blitz_circle_delay_time_7", 10);
  var7 = getdvarint("scr_blitz_circle_delay_time_8", 5);
  var8 = getdvarint("scr_blitz_circle_close_time_1", 120);
  var9 = getdvarint("scr_blitz_circle_close_time_2", 200);
  var10 = getdvarint("scr_blitz_circle_close_time_3", 180);
  var11 = getdvarint("scr_blitz_circle_close_time_4", 140);
  var12 = getdvarint("scr_blitz_circle_close_time_5", 110);
  var13 = getdvarint("scr_blitz_circle_close_time_6", 70);
  var14 = getdvarint("scr_blitz_circle_close_time_7", 50);
  var15 = getdvarint("scr_blitz_circle_close_time_8", 90);

  switch (getdvarint("scr_blitz_circle_speed", 1)) {
    case 0:
      level.computer_animation_off.groundentity = [210, 90, 75, 60, 60, 45, 30, 10];
      level.computer_animation_off.ground_spawners = [270, 210, 170, 110, 70, 50, 50, 30];
      break;
    case 1:
      level.computer_animation_off.groundentity = [0, 45, 20, 20, 15, 15, 10, 5];
      level.computer_animation_off.ground_spawners = [120, 200, 180, 140, 110, 70, 50, 90];
      break;
    case 2:
      level.computer_animation_off.groundentity = [0, 45, 20, 20, 15, 15, 10, 5];
      level.computer_animation_off.ground_spawners = [120, 300, 230, 190, 120, 80, 60, 90];
      break;
    case 3:
      level.computer_animation_off.groundentity = [var0, var1, var2, var3, var4, var5, var6, var7];
      level.computer_animation_off.ground_spawners = [var8, var9, var10, var11, var12, var13, var14, var15];
      break;
  }

  level.decoyassists = &groundz;
}

function groundz() {
  level.br_level.br_circledelaytimes = level.computer_animation_off.groundentity;
  level.br_level.br_circleclosetimes = level.computer_animation_off.ground_spawners;
  level.br_level.default_player_connect_black_screen = [0, 0, 0, 0, 0, 0, 0, 0];
  level.br_level.default_suicidebomber_combat = [0, 0, 0, 0, 0, 0, 0, 0];
  level.br_level.br_circleradii = [100000, 72500, 50000, 32500, 17500, 10000, 5000, 2000, 0];
  level.br_level.br_circleminimapradii = [10500, 10500, 10500, 9000, 8000, 6500, 5500, 5500];
}
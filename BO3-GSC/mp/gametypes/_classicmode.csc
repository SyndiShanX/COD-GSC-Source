/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\_classicmode.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace classicmode;

function autoexec __init__sytem__() {
  system::register("classicmode", &__init__, undefined, undefined);
}

function __init__() {
  level.classicmode = getgametypesetting("classicMode");
  if(level.classicmode) {
    enableclassicmode();
  }
}

function enableclassicmode() {
  setDvar("bg_t7BlockMeleeUsageTime", 100);
  setDvar("doublejump_enabled", 0);
  setDvar("wallRun_enabled", 0);
  setDvar("slide_maxTime", 550);
  setDvar("playerEnergy_slideEnergyEnabled", 0);
  setDvar("trm_maxSideMantleHeight", 0);
  setDvar("trm_maxBackMantleHeight", 0);
  setDvar("player_swimming_enabled", 0);
  setDvar("player_swimHeightRatio", 0.9);
  setDvar("player_sprintSpeedScale", 1.5);
  setDvar("jump_slowdownEnable", 1);
  setDvar("player_sprintUnlimited", 0);
  setDvar("sprint_allowRestore", 0);
  setDvar("sprint_allowReload", 0);
  setDvar("sprint_allowRechamber", 0);
  setDvar("cg_blur_time", 500);
  setDvar("tu11_enableClassicMode", 1);
}
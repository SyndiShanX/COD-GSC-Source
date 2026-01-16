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
  system::register("classicmode", & __init__, undefined, undefined);
}

function __init__() {
  level.classicmode = getgametypesetting("classicMode");
  if(level.classicmode) {
    enableclassicmode();
  }
}

function enableclassicmode() {
  setdvar("bg_t7BlockMeleeUsageTime", 100);
  setdvar("doublejump_enabled", 0);
  setdvar("wallRun_enabled", 0);
  setdvar("slide_maxTime", 550);
  setdvar("playerEnergy_slideEnergyEnabled", 0);
  setdvar("trm_maxSideMantleHeight", 0);
  setdvar("trm_maxBackMantleHeight", 0);
  setdvar("player_swimming_enabled", 0);
  setdvar("player_swimHeightRatio", 0.9);
  setdvar("player_sprintSpeedScale", 1.5);
  setdvar("jump_slowdownEnable", 1);
  setdvar("player_sprintUnlimited", 0);
  setdvar("sprint_allowRestore", 0);
  setdvar("sprint_allowReload", 0);
  setdvar("sprint_allowRechamber", 0);
  setdvar("cg_blur_time", 500);
  setdvar("tu11_enableClassicMode", 1);
}
/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\ob_season5.gsc
**************************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace ob_season5;

function autoexec init() {
  level callback::add("ob_season_main", &main);
}

function main(params) {
  level callback::remove("ob_season_main", &main);
}
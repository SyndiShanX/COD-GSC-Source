/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6f25504bd5cad829.gsc
*************************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_c8486b8d494f563e;

function autoexec init() {
  level callback::add("ob_season_main", &main);
}

function main(params) {
  level callback::remove("ob_season_main", &main);
}
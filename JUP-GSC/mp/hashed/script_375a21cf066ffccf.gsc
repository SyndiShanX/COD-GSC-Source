/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_375a21cf066ffccf.gsc
*************************************************/

#using scripts\common\ae_utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_gametype_resurgence;
#namespace namespace_dfad913738a5e768;

function private autoexec main() {
  if(getdvarint(@ "hash_292601f5bad99456", 0) > 0) {
    thread init();
  }
}

function init() {
  level endon("game_ended");
  thread function_f3fde6cdcc37ae72();
  level waittill("prematch_done");
  function_93a8cc186ef89237();
}

function function_f3fde6cdcc37ae72() {
  level endon("game_ended");
  waitframe();
  level.brgametype.dialogprefix = "dx_br_brrs_";
  game["dialog"]["match_start"] = "bssc_grav_aaa18";
}

function function_93a8cc186ef89237() {
  scripts\mp\gametypes\br_gametype_resurgence::initloadouts("classtable:classtable_br_resurgence_supreme", 1);
  scripts\mp\gametypes\br_gametype_resurgence::initloadouts("classtable:classtable_br_resurgence_circle2_supreme");
  scripts\mp\gametypes\br_gametype_resurgence::initloadouts("classtable:classtable_br_resurgence_circle3_supreme");
}
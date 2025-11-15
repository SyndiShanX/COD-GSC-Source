/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\gametypes\zclassic.csc
***************************************************/

main() {
  level._zombie_gamemodeprecache = ::onprecachegametype;
  level._zombie_gamemodemain = ::onstartgametype;

  println("************ ZCLASSIC MAIN");
}

onprecachegametype() {
  println("************ ZCLASSIC PRECACHE");
}

onstartgametype() {
  println("************ ZCLASSIC MAIN MAIN");
}
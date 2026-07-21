/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\tunnels\gen\tunnels_art.gsc
***********************************************/

main() {
  level.tweakfile = 1;
  level.player = getEntArray("player", "classname")[0];
  thread settessellationvalues();
}

settessellationvalues() {
  waitframe();
  setsaveddvar("NOSQLKNSQO", 150);
  setsaveddvar("LMNOQSTMKN", 700);
  setsaveddvar("TSPOQPTMS", 600);
}
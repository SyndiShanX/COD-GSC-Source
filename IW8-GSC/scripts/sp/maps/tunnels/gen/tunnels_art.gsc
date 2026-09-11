/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\tunnels\gen\tunnels_art.gsc
*******************************************************/

function main() {
  level.tweakfile = 1;
  level.player = getEntArray("player", "classname")[0];
  thread settessellationvalues();
}

function settessellationvalues() {
  waitframe();
  setsaveddvar("NOSQLKNSQO", 150);
  setsaveddvar("LMNOQSTMKN", 700);
  setsaveddvar("TSPOQPTMS", 600);
}
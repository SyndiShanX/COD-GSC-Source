/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\white_phosphorus_mp.gsc
**********************************************************/

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("white_phosphorus", &scripts\cp_mp\killstreaks\white_phosphorus::tryusewpfromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("white_phosphorus", "startMapSelectSequence", &white_phosphorus_startmapselectsequence);
  scripts\cp_mp\utility\script_utility::registersharedfunc("white_phosphorus", "getSelectMapPoint", &white_phosphorus_getmapselectpoint);
}

function white_phosphorus_startmapselectsequence(var0, var1, var2, var3) {
  scripts\mp\killstreaks\mapselect::startmapselectsequence(var0, var1, var2);
}

function white_phosphorus_getmapselectpoint(var0, var1, var2) {
  return scripts\mp\killstreaks\mapselect::getselectmappoint(var0, var1, var2);
}
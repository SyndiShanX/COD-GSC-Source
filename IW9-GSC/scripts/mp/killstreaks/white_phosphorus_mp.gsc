/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\white_phosphorus_mp.gsc
**********************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("white_phosphorus", scripts\cp_mp\killstreaks\white_phosphorus::tryusewpfromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("white_phosphorus", "startMapSelectSequence", ::white_phosphorus_startmapselectsequence);
  scripts\cp_mp\utility\script_utility::registersharedfunc("white_phosphorus", "getSelectMapPoint", ::white_phosphorus_getmapselectpoint);
}

white_phosphorus_startmapselectsequence(_id_FB5BCF10CCC2C5DF, _id_EDC5BB5A4B3DD2FF, _id_7426E996C9EB34D3, _id_3922786267CCC2A8) {
  scripts\mp\killstreaks\mapselect::_id_90F093CA8576232F(_id_FB5BCF10CCC2C5DF, _id_EDC5BB5A4B3DD2FF, _id_7426E996C9EB34D3);
}

white_phosphorus_getmapselectpoint(streakinfo, _id_CDCE0F8BE900C487, _id_EDC5BB5A4B3DD2FF) {
  return scripts\mp\killstreaks\mapselect::_id_A5839924B6723EAC(streakinfo, _id_CDCE0F8BE900C487, _id_EDC5BB5A4B3DD2FF);
}
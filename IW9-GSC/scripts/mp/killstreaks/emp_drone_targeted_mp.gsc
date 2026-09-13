/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\emp_drone_targeted_mp.gsc
************************************************************/

init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("empDroneTargeted", "getSelectMapPoint", ::emp_drone_targeted_getmapselectpoint);
  scripts\cp_mp\utility\script_utility::registersharedfunc("empDroneTargeted", "startMapSelectSequence", ::emp_drone_targeted_startmapselectsequence);
  scripts\cp_mp\utility\script_utility::registersharedfunc("empDroneTargeted", "monitorDamage", ::emp_drone_targeted_monitordamage);
}

emp_drone_targeted_getmapselectpoint(streakinfo, _id_CDCE0F8BE900C487, _id_EDC5BB5A4B3DD2FF) {
  return scripts\mp\killstreaks\mapselect::_id_A5839924B6723EAC(streakinfo, _id_CDCE0F8BE900C487, _id_EDC5BB5A4B3DD2FF);
}

emp_drone_targeted_startmapselectsequence(_id_FB5BCF10CCC2C5DF, _id_EDC5BB5A4B3DD2FF, _id_7426E996C9EB34D3, _id_3922786267CCC2A8) {
  scripts\mp\killstreaks\mapselect::_id_90F093CA8576232F(_id_FB5BCF10CCC2C5DF, _id_EDC5BB5A4B3DD2FF, _id_7426E996C9EB34D3, _id_3922786267CCC2A8);
}

emp_drone_targeted_monitordamage(maxhealth, damagefeedback, _id_C5D89C3A1224B118, _id_D7B6456018542238, _id_A1823AC1157568DB, rumble, _id_22435C27E2916650) {
  scripts\mp\damage::monitordamage(maxhealth, damagefeedback, _id_C5D89C3A1224B118, _id_D7B6456018542238, _id_A1823AC1157568DB, rumble, _id_22435C27E2916650);
}
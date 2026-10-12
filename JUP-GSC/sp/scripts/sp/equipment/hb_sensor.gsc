/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\equipment\hb_sensor.gsc
***********************************************/



#using scripts\sp\equipment\offhands;
#namespace hb_sensor;

function precache(offhand) {
  registeroffhandfirefunc(offhand, &function_8f256a2c4afab75f);
}

function function_8f256a2c4afab75f(grenade, weapon) {
  waitframe();

  if(isDefined(grenade)) {
    grenade delete();
  }
}
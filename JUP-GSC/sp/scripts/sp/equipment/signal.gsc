/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\equipment\signal.gsc
***********************************************/



#using scripts\sp\equipment\offhands;
#namespace signal;

function precache(offhand) {
  registeroffhandfirefunc(offhand, &signalfiremain);
}

function signalfiremain(grenade, weapon) {}
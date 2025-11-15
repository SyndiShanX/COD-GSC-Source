/*****************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\archetype_warlord_interface.gsc
*****************************************************/

#using scripts\shared\ai\systems\ai_interface;
#using scripts\shared\ai\warlord;
#namespace warlordinterface;

function registerwarlordinterfaceattributes() {
  ai::registermatchedinterface("warlord", "can_be_meleed", 0, array(1, 0));
}

function addpreferedpoint(position, min_duration, max_duration, name) {
  warlordserverutils::addpreferedpoint(self, position, min_duration, max_duration, name);
}

function deletepreferedpoint(name) {
  warlordserverutils::deletepreferedpoint(self, name);
}

function clearallpreferedpoints() {
  warlordserverutils::clearallpreferedpoints(self);
}

function clearpreferedpointsoutsidegoal() {
  warlordserverutils::clearpreferedpointsoutsidegoal(self);
}

function setwarlordaggressivemode(b_aggressive_mode) {
  warlordserverutils::setwarlordaggressivemode(self);
}
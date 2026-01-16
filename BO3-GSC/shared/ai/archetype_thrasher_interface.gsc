/******************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\archetype_thrasher_interface.gsc
******************************************************/

#using scripts\shared\ai\archetype_thrasher;
#using scripts\shared\ai\systems\ai_interface;
#namespace thrasherinterface;

function registerthrasherinterfaceattributes() {
  ai::registermatchedinterface("thrasher", "stunned", 0, array(1, 0));
  ai::registermatchedinterface("thrasher", "move_mode", "normal", array("normal", "friendly"), & thrasherserverutils::thrashermovemodeattributecallback);
  ai::registermatchedinterface("thrasher", "use_attackable", 0, array(1, 0));
}
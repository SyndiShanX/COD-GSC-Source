/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\connect_event_aggregator.gsc
***********************************************************/

init() {
  level thread onplayerconnect();
}

onplayerconnect() {
  if(!isDefined(level._id_E2E7DBB91B6632CF))
    level._id_E2E7DBB91B6632CF = [];

  for(;;) {
    level waittill("connected", player);
    player thread onplayerconnected();
  }
}

_id_8ECE37593311858A(callback) {
  if(!isDefined(level._id_E2E7DBB91B6632CF))
    level._id_E2E7DBB91B6632CF = [];

  level._id_E2E7DBB91B6632CF[level._id_E2E7DBB91B6632CF.size] = callback;
}

onplayerconnected() {
  self endon("disconnect");

  foreach(callback in level._id_E2E7DBB91B6632CF)
  self[[callback]]();
}
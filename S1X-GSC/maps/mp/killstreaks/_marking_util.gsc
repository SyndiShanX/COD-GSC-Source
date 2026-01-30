/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_marking_util.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

playerProcessTaggedAssist(victim) {
  if(level.teamBased && isDefined(victim)) {
    self thread maps\mp\_events::processAssistEvent(victim);
  }
}
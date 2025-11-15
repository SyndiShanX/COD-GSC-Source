/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_highlights.gsc
*****************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

giveHighlight(ref, value) {
  highlightCount = getClientMatchData("highlightCount");
  if(highlightCount < 18) {
    setClientMatchData("highlights", highlightCount, "award", ref);
    setClientMatchData("highlights", highlightCount, "clientId", self.clientMatchDataId);
    setClientMatchData("highlights", highlightCount, "value", value);

    highlightCount++;
    setClientMatchData("highlightCount", highlightCount);
  }
}
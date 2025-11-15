/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\mp\_highlights.gsc
********************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

giveHighlight(ref, value) {
  highlightCount = getClientMatchData("highlightCount");
  if(highlightCount < 18) // must match MaxHighlights in clientmatchdata definition
  {
    setClientMatchData("highlights", highlightCount, "award", ref);
    setClientMatchData("highlights", highlightCount, "clientId", self.clientMatchDataId);
    setClientMatchData("highlights", highlightCount, "value", value);

    highlightCount++;
    setClientMatchData("highlightCount", highlightCount);
  }
}
/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\sp_killstreaks\_popups.gsc
*******************************************/

#include maps\_utility;
#include common_scripts\utility;

init() {
  level.medalsettings.waittime = 1.25;
  level.contractsettings = spawnstruct();
  level.contractsettings.waittime = 4.2;
  level.killstreaksettings = spawnstruct();
  level.killstreaksettings.waittime = 3;
  level.ranksettings = spawnstruct();
  level.ranksettings.waittime = 3;
  level.startmessage = spawnstruct();
  level.startmessagedefaultduration = 2.0;
  level.endmessagedefaultduration = 2.0;
  level.challengesettings = spawnstruct();
  level.challengesettings.waittime = 3;
  level.teammessage = spawnstruct();
  level.teammessage.waittime = 3;
  level.regulargamemessages = spawnstruct();
  level.regulargamemessages.waittime = 6;
  level.wagersettings = spawnstruct();
  level.wagersettings.waittime = 3;
  level.momentumnotifywaittime = 0.5;
  level thread onplayerconnect();
}

displaypopupswaiter() {
  self endon("disconnect");
  self.killstreaknotifyqueue = [];
  self.messagenotifyqueue = [];
  self.startmessagenotifyqueue = [];

  while(true) {
    if(self.killstreaknotifyqueue.size == 0 && self.messagenotifyqueue.size == 0)
      self waittill("received award");

    waittillframeend;

    if(self.startmessagenotifyqueue.size > 0) {
      self clearcenterpopups();
      nextnotifydata = self.startmessagenotifyqueue[0];

      for(i = 1; i < self.startmessagenotifyqueue.size; i++)
        self.startmessagenotifyqueue[i - 1] = self.startmessagenotifyqueue[i];

      self.startmessagenotifyqueue[i - 1] = undefined;

      if(isDefined(nextnotifydata.duration))
        duration = nextnotifydata.duration;
      else
        duration = level.startmessagedefaultduration;

      wait(duration);
    } else if(self.killstreaknotifyqueue.size > 0) {
      streakcount = self.killstreaknotifyqueue[0].streakcount;
      killstreaktablenumber = self.killstreaknotifyqueue[0].killstreaktablenumber;
      hardpointtype = self.killstreaknotifyqueue[0].hardpointtype;

      for(i = 1; i < self.killstreaknotifyqueue.size; i++)
        self.killstreaknotifyqueue[i - 1] = self.killstreaknotifyqueue[i];

      self.killstreaknotifyqueue[i - 1] = undefined;

      if(!isDefined(streakcount))
        streakcount = 0;

      self displaykillstreak(streakcount, killstreaktablenumber);
      wait(level.killstreaksettings.waittime);
    } else if(self.messagenotifyqueue.size > 0) {
      self clearcenterpopups();
      nextnotifydata = self.messagenotifyqueue[0];

      for(i = 1; i < self.messagenotifyqueue.size; i++)
        self.messagenotifyqueue[i - 1] = self.messagenotifyqueue[i];

      self.messagenotifyqueue[i - 1] = undefined;

      if(isDefined(nextnotifydata.duration))
        duration = nextnotifydata.duration;
      else
        duration = level.regulargamemessages.waittime;
    }
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connecting", player);
    player clearendgame();
    player clearpopups();
    player.resetgameoverhudrequired = 0;
    player thread displaypopupswaiter();
  }
}
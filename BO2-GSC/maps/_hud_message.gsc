/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_hud_message.gsc
**************************************/

#include maps\_hud_util;
#include common_scripts\utility;
#include maps\_utility;

init() {
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connecting", player);
    player thread initnotifymessage();
  }
}

hintmessageplayers(players, hinttext) {
  notifydata = spawnstruct();
  notifydata.notifytext = hinttext;

  for(i = 0; i < players.size; i++)
    players[i] notifymessage(notifydata);
}

hintmessage(hinttext) {
  notifydata = spawnstruct();
  notifydata.notifytext = hinttext;
  notifymessage(notifydata);
}

initnotifymessage() {
  if(isDefined(self.notifytitle)) {
    return;
  }
  self thread initnotifymessageinternal();
}

initnotifymessageinternal() {
  if(level.splitscreen) {
    titlesize = 2.0;
    textsize = 1.5;
    iconsize = 24;
    font = "default";
    point = "TOP";
    relativepoint = "BOTTOM";
    yoffset = 30;
    xoffset = 0;
  } else {
    titlesize = 2.5;
    textsize = 1.75;
    iconsize = 30;
    font = "objective";
    point = "TOP";
    relativepoint = "BOTTOM";
    yoffset = 30;
    xoffset = 0;
  }

  self.notifytitle = createfontstring(font, titlesize, self);
  self.notifytitle setpoint(point, undefined, xoffset, yoffset);
  self.notifytitle.glowalpha = 1;
  self.notifytitle.hidewheninmenu = 1;
  self.notifytitle.archived = 0;
  self.notifytitle.alpha = 0;
  self.notifytext = createfontstring(font, textsize, self);
  self.notifytext setparent(self.notifytitle);
  self.notifytext setpoint(point, relativepoint, 0, 0);
  self.notifytext.glowalpha = 1;
  self.notifytext.hidewheninmenu = 1;
  self.notifytext.archived = 0;
  self.notifytext.alpha = 0;
  self.notifytext2 = createfontstring(font, textsize, self);
  self.notifytext2 setparent(self.notifytitle);
  self.notifytext2 setpoint(point, relativepoint, 0, 0);
  self.notifytext2.glowalpha = 1;
  self.notifytext2.hidewheninmenu = 1;
  self.notifytext2.archived = 0;
  self.notifytext2.alpha = 0;
  self.notifyicon = createicon("white", iconsize, iconsize, self);
  self.notifyicon setparent(self.notifytext2);
  self.notifyicon setpoint(point, relativepoint, 0, 0);
  self.notifyicon.hidewheninmenu = 1;
  self.notifyicon.archived = 0;
  self.notifyicon.alpha = 0;
  self.notifytext3 = createfontstring(font, textsize, self);
  self.notifytext3 setparent(self.notifytitle);
  self.notifytext3 setpoint(point, relativepoint, 0, 0);
  self.notifytext3.glowalpha = 1;
  self.notifytext3.hidewheninmenu = 1;
  self.notifytext3.archived = 0;
  self.notifytext3.alpha = 0;
  self.doingnotify = 0;
  self.notifyqueue = [];
}

notifymessage(notifydata) {
  self endon("death");
  self endon("disconnect");

  if(!self.doingnotify) {
    self thread shownotifymessage(notifydata);
    return;
  }

  self.notifyqueue[self.notifyqueue.size] = notifydata;
}

shownotifymessage(notifydata) {
  self thread shownotifymessageinternal(notifydata);
}

shownotifymessageinternal(notifydata) {
  self endon("disconnect");
  self.doingnotify = 1;
  waitrequirevisibility(0);

  if(isDefined(notifydata.duration))
    duration = notifydata.duration;
  else if(level.gameended)
    duration = 2.0;
  else
    duration = 4.0;

  self thread resetoncancel();

  if(isDefined(notifydata.sound))
    self playlocalsound(notifydata.sound);

  if(isDefined(notifydata.glowcolor))
    glowcolor = notifydata.glowcolor;
  else
    glowcolor = (0, 0, 0);

  anchorelem = self.notifytitle;

  if(isDefined(notifydata.titletext)) {
    if(level.splitscreen) {
      if(isDefined(notifydata.titlelabel))
        self iprintlnbold(notifydata.titlelabel, notifydata.titletext);
      else
        self iprintlnbold(notifydata.titletext);
    } else {
      if(isDefined(notifydata.titlelabel))
        self.notifytitle.label = notifydata.titlelabel;
      else
        self.notifytitle.label = & "";

      if(isDefined(notifydata.titlelabel) && !isDefined(notifydata.titleisstring))
        self.notifytitle setvalue(notifydata.titletext);
      else
        self.notifytitle settext(notifydata.titletext);

      self.notifytitle setpulsefx(100, int(duration * 1000), 1000);
      self.notifytitle.glowcolor = glowcolor;
      self.notifytitle.alpha = 1;
    }
  }

  if(isDefined(notifydata.notifytext)) {
    if(level.splitscreen) {
      if(isDefined(notifydata.textlabel))
        self iprintlnbold(notifydata.textlabel, notifydata.notifytext);
      else
        self iprintlnbold(notifydata.notifytext);
    } else {
      if(isDefined(notifydata.textlabel))
        self.notifytext.label = notifydata.textlabel;
      else
        self.notifytext.label = & "";

      if(isDefined(notifydata.textlabel) && !isDefined(notifydata.textisstring))
        self.notifytext setvalue(notifydata.notifytext);
      else
        self.notifytext settext(notifydata.notifytext);

      self.notifytext setpulsefx(100, int(duration * 1000), 1000);
      self.notifytext.glowcolor = glowcolor;
      self.notifytext.alpha = 1;
      anchorelem = self.notifytext;
    }
  }

  if(isDefined(notifydata.notifytext2)) {
    if(level.splitscreen) {
      if(isDefined(notifydata.text2label))
        self iprintlnbold(notifydata.text2label, notifydata.notifytext2);
      else
        self iprintlnbold(notifydata.notifytext2);
    } else {
      self.notifytext2 setparent(anchorelem);

      if(isDefined(notifydata.text2label))
        self.notifytext2.label = notifydata.text2label;
      else
        self.notifytext2.label = & "";

      if(isDefined(notifydata.text2label) && !isDefined(notifydata.textisstring))
        self.notifytext2 setvalue(notifydata.notifytext2);
      else
        self.notifytext2 settext(notifydata.notifytext2);

      self.notifytext2 settext(notifydata.notifytext2);
      self.notifytext2 setpulsefx(100, int(duration * 1000), 1000);
      self.notifytext2.glowcolor = glowcolor;
      self.notifytext2.alpha = 1;
      anchorelem = self.notifytext2;
    }
  }

  if(isDefined(notifydata.notifytext3)) {
    if(level.splitscreen) {
      if(isDefined(notifydata.text3label))
        self iprintlnbold(notifydata.text3label, notifydata.notifytext3);
      else
        self iprintlnbold(notifydata.notifytext3);
    } else {
      self.notifytext3 setparent(anchorelem);

      if(isDefined(notifydata.text3label))
        self.notifytext3.label = notifydata.text3label;
      else
        self.notifytext3.label = & "";

      if(isDefined(notifydata.text3label) && !isDefined(notifydata.textisstring))
        self.notifytext3 setvalue(notifydata.notifytext3);
      else
        self.notifytext3 settext(notifydata.notifytext3);

      self.notifytext3 settext(notifydata.notifytext3);
      self.notifytext3 setpulsefx(100, int(duration * 1000), 1000);
      self.notifytext3.glowcolor = glowcolor;
      self.notifytext3.alpha = 1;
      anchorelem = self.notifytext3;
    }
  }

  if(isDefined(notifydata.iconname) && !level.splitscreen) {
    self.notifyicon setparent(anchorelem);
    self.notifyicon setshader(notifydata.iconname, 60, 60);
    self.notifyicon.alpha = 0;
    self.notifyicon fadeovertime(1.0);
    self.notifyicon.alpha = 1;
    waitrequirevisibility(duration);
    self.notifyicon fadeovertime(0.75);
    self.notifyicon.alpha = 0;
  } else {
    waitrequirevisibility(duration);
    self.notifytext settext("");
    self.notifytext2 settext("");
    self.notifytext3 settext("");
  }

  self notify("notifyMessageDone");
  self.doingnotify = 0;

  if(self.notifyqueue.size > 0) {
    nextnotifydata = self.notifyqueue[0];
    newqueue = [];

    for(i = 1; i < self.notifyqueue.size; i++)
      self.notifyqueue[i - 1] = self.notifyqueue[i];

    self.notifyqueue[i - 1] = undefined;
    self thread shownotifymessageinternal(nextnotifydata);
  }
}

waitrequirevisibility(waittime) {
  while(!self canreadtext())
    wait 0.05;

  while(waittime > 0) {
    wait 0.05;

    if(self canreadtext())
      waittime = waittime - 0.05;
  }
}

canreadtext() {
  return true;
}

resetoncancel() {
  self notify("resetOnCancel");
  self endon("resetOnCancel");
  self endon("notifyMessageDone");
  self endon("disconnect");
  level waittill("cancel_notify");
  resetnotify();
}

resetnotify() {
  self.notifytitle.alpha = 0;
  self.notifytext.alpha = 0;
  self.notifyicon.alpha = 0;
  self.doingnotify = 0;
}

waittillnotifiesdone() {
  pendingnotifies = 1;

  for(timewaited = 0; pendingnotifies && timewaited < 12; timewaited = timewaited + 0.2) {
    pendingnotifies = 0;
    players = get_players();

    for(i = 0; i < players.size; i++) {
      if(isDefined(players[i].notifyqueue) && players[i].notifyqueue.size > 0)
        pendingnotifies = 1;
    }

    if(pendingnotifies)
      wait 0.2;
  }
}
/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: common_scripts\iw4x_utility.gsc
*******************************************/

_noclip() {
  if(self.clientflags & 1) {
    self iprintln(&"GAME_NOCLIPOFF");
    self.clientflags &= ~1;
  } else {
    self iprintln(&"GAME_NOCLIPON");
    self.clientflags |= 1;
  }
}

_ufo() {
  if(self.clientflags & 2) {
    self iprintln(&"GAME_UFOOFF");
    self.clientflags &= ~2;
  } else {
    self iprintln(&"GAME_UFOON");
    self.clientflags |= 2;
  }
}

god() {
  FL_GODMODE = 1 << 0;
  msg = & "";

  if(self.entityflags & FL_GODMODE) {
    msg = & "GAME_GODMODE_OFF";
    self.entityflags &= ~FL_GODMODE;
  } else {
    msg = & "GAME_GODMODE_ON";
    self.entityflags |= FL_GODMODE;
  }

  if(isPlayer(self)) {
    self iprintln(msg);
  }
}

demiGod() {
  FL_DEMI_GODMODE = 1 << 1;
  msg = & "";

  if(self.entityflags & FL_DEMI_GODMODE) {
    msg = & "GAME_DEMI_GODMODE_OFF";
    self.entityflags &= ~FL_DEMI_GODMODE;
  } else {
    msg = & "GAME_DEMI_GODMODE_ON";
    self.entityflags |= FL_DEMI_GODMODE;
  }

  if(isPlayer(self)) {
    self iprintln(msg);
  }
}

noTarget() {
  FL_NOTARGET = 1 << 2;
  msg = & "";

  if(self.entityflags & FL_NOTARGET) {
    msg = & "GAME_NOTARGETOFF";
    self.entityflags &= ~FL_NOTARGET;
  } else {
    msg = & "GAME_NOTARGETON";
    self.entityflags |= FL_NOTARGET;
  }

  if(isPlayer(self)) {
    self iprintln(msg);
  }
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\utility\hitmarker.gsc
***********************************************/

#using scripts\engine\utility;
#namespace hitmarker;

function frontend_hitmarker(var_f182d284b07a828e, isdeath, iscivilian, isbody) {
  if(!isDefined(isdeath)) {
    isdeath = 0;
  }

  if(!isDefined(iscivilian)) {
    iscivilian = 0;
  }

  if(!isDefined(isbody)) {
    isbody = 0;
  }

  alias = getDvar(@ "hash_d6875627fd8914de");

  if(isbody && isdeath) {
    level.player playlocalsound("mp_kill_alert");
  } else if(isDefined(var_f182d284b07a828e)) {
    playsoundatpos(var_f182d284b07a828e.origin, alias);
  } else {
    self playSound(alias);
  }

  function_2a968ddf3c277ce("standard", isdeath, 0, iscivilian);
}

function function_2a968ddf3c277ce(markertype, killingblow, headshot, nonplayer, icontype) {
  if(!isDefined(markertype)) {
    return;
  }

  if(!isDefined(killingblow)) {
    killingblow = 0;
  }

  if(!isDefined(headshot)) {
    headshot = 0;
  }

  if(!isDefined(nonplayer)) {
    nonplayer = 0;
  }

  priority = function_e133bfd0c1ab18c9(markertype);

  if(isDefined(self.lasthitmarkertime) && self.lasthitmarkertime == gettime() && priority <= self.lasthitmarkerpriority && !killingblow) {
    return;
  }

  self.lasthitmarkertime = gettime();
  self.lasthitmarkerpriority = priority;

  if(isDefined(icontype) && !istrue(killingblow)) {
    self setclientomnvar("damage_feedback_icon", icontype);
    self setclientomnvar("damage_feedback_icon_notify", gettime());
  }

  self setclientomnvar("damage_feedback", markertype);
  self setclientomnvar("damage_feedback_notify", gettime());

  if(killingblow) {
    self setclientomnvar("damage_feedback_kill", 1);
  } else {
    self setclientomnvar("damage_feedback_kill", 0);
  }

  if(headshot) {
    self setclientomnvar("damage_feedback_headshot", 1);
  } else {
    self setclientomnvar("damage_feedback_headshot", 0);
  }

  if(nonplayer) {
    self setclientomnvar("damage_feedback_nonplayer", 1);
    return;
  }

  self setclientomnvar("damage_feedback_nonplayer", 0);
}

function function_e133bfd0c1ab18c9(hitmarkertype) {
  if(!isDefined(level.hitmarkerpriorities[hitmarkertype])) {
    return 0;
  }

  return level.hitmarkerpriorities[hitmarkertype];
}
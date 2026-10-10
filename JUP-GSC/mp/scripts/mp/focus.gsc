/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\focus.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\utility\player;
#using scripts\mp\utility\spawn_event_aggregator;
#namespace focus;

function init() {
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
}

function onplayerspawned() {
  self.focus = 0;
  self.focuslasttime = -99999;
  thread managefocus();
}

function managefocus() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(true) {
    while(!self isholdingbreath()) {
      waitframe();
    }

    childthread watchforfire();
    dofocus();
  }
}

function dofocus() {
  var_663dab9b536c9a71 = !istrue(level.wpinprogress);

  if(var_663dab9b536c9a71) {
    self.focus = 1;
    focusvision();
  }

  while(self isholdingbreath()) {
    waitframe();
  }

  self notify("stop_focus_fire_watcher");

  if(var_663dab9b536c9a71) {
    self.focus = 0;
    restorebasevisionset(0.35);
  }
}

function watchforfire() {
  self endon("stop_focus_fire_watcher");
  self waittill("weapon_fired");
  self.focuslasttime = gettime();
}

function function_bd0d33f283ede2f8() {
  weapontype = scripts\cp_mp\weapon::getweaponclasstoken(self.currentweapon.basename);

  switch (weapontype) {
    case #"hash_fa0ed9f6bd4f4e9a":
    case #"hash_fa18d2f6bd57925a":
    case #"hash_fa21c4f6bd5e3815":
    case #"hash_fa27b9f6bd62a3f2":
    case #"hash_fa4dbdf6bd80bf52":
    case #"hash_fa50b4f6bd82efbe":
    case #"hash_fa50b6f6bd82f2e4":
    case #"hash_fa50b9f6bd82f79d":
      return 1;
    default:
      return 0;
  }
}

function focusvision() {
  self visionsetnakedforplayer("focus", 0.57);
}
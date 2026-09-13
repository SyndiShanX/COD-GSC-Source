/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\focus.gsc
***********************************************/

init() {
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);
}

onplayerspawned() {
  self.focus = 0;
  self._id_054F2B36B0D0243E = -99999;
  thread _id_668D6646DE9F85E6();
}

_id_668D6646DE9F85E6() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    while(!self isholdingbreath())
      waitframe();

    childthread _id_ED919A465E89E98F();
    _id_31801AB8533AE1D8();
  }
}

_id_31801AB8533AE1D8() {
  _id_663DAB9B536C9A71 = !istrue(level.wpinprogress);

  if(_id_663DAB9B536C9A71) {
    self.focus = 1;
    _id_BCD83CC8BED2F95B();
  }

  while(self isholdingbreath())
    waitframe();

  self notify("stop_focus_fire_watcher");

  if(_id_663DAB9B536C9A71) {
    self.focus = 0;
    scripts\mp\utility\player::restorebasevisionset(0.35);
  }
}

_id_ED919A465E89E98F() {
  self endon("stop_focus_fire_watcher");
  self waittill("weapon_fired");
  self._id_054F2B36B0D0243E = gettime();
}

_id_BCD83CC8BED2F95B() {
  self visionsetnakedforplayer("focus", 0.57);
}
/**************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\killstreaks\_zombie_camouflage.gsc
**************************************************************/

init() {
  level.camo_duration = 20;
  level.killstreakfuncs["zm_camouflage"] = ::tryusezombiecamouflage;
}

tryusezombiecamouflage(var_0, var_1) {
  if(maps\mp\zombies\_util::arekillstreaksdisabled()) {
    return 0;
  }

  thread maps\mp\zombies\_zombies_audio::playerkillstreakcratevo("ss_shield");
  thread playercamouflagemode();
  return 1;
}

playercamouflagemode(var_0) {
  if(!isDefined(var_0)) {
    var_0 = level.camo_duration;
  }

  var_1 = int(gettime() + var_0 * 1000);

  if(isDefined(self.crategodmode) && self.crategodmode) {
    var_2 = self getclientomnvar("ui_zm_camo");

    if(var_2 >= var_1) {
      return;
    }
  }

  self notify("playerCamouflageMode");

  if(!isDefined(self.crategodmode)) {
    self.crategodmode = 0;
  }

  self playlocalsound("zmb_ss_camo_use");
  self.crategodmode++;
  maps\mp\zombies\_util::setzombiesignoreme(1);
  self setclientomnvar("ui_zm_camo", var_1);
  playercamouflagemodewait(var_0);

  if(isDefined(self)) {
    maps\mp\zombies\_util::setzombiesignoreme(0);
    self.crategodmode--;
  }
}

playercamouflagemodewait(var_0) {
  self endon("playerCamouflageMode");
  wait(var_0);
}
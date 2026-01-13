/******************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_teamammorefill.gsc
******************************************************/

init() {
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("team_ammo_refill", ::func_12908);
}

func_12908(var_0) {
  var_1 = stopsounds();
  if(var_1) {
    scripts\mp\matchdata::logkillstreakevent("team_ammo_refill", self.origin);
  }

  return var_1;
}

stopsounds() {
  if(level.teambased) {
    foreach(var_1 in level.players) {
      if(var_1.team == self.team) {
        var_1 refillammo(1);
      }
    }
  } else {
    refillammo(1);
  }

  level thread scripts\mp\utility::teamplayercardsplash("used_team_ammo_refill", self);
  return 1;
}

refillammo(var_0) {
  var_1 = self getweaponslistall();
  if(var_0) {}

  foreach(var_3 in var_1) {
    if(issubstr(var_3, "grenade") || getsubstr(var_3, 0, 2) == "gl") {
      if(!var_0 || self getrunningforwardpainanim(var_3) >= 1) {
        continue;
      }
    }

    self givemaxammo(var_3);
  }

  self playlocalsound("ammo_crate_use");
}
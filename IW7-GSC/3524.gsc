/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3524.gsc
***************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("team_ammo_refill", ::func_12908);
}

func_12908(var_00) {
  var_01 = stopsounds();

  if(var_01) {
    scripts\mp\matchdata::logkillstreakevent("team_ammo_refill", self.origin);
  }

  return var_01;
}

stopsounds() {
  if(level.teambased) {
    foreach(var_01 in level.players) {
      if(var_1.team == self.team) {
        var_01 refillammo(1);
      }
    }
  } else
    refillammo(1);

  level thread scripts\mp\utility\game::teamplayercardsplash("used_team_ammo_refill", self);
  return 1;
}

refillammo(var_00) {
  var_01 = self getweaponslistall();

  if(var_00) {}

  foreach(var_03 in var_01) {
    if(issubstr(var_03, "grenade") || getsubstr(var_03, 0, 2) == "gl") {
      if(!var_00 || self getammocount(var_03) >= 1) {
        continue;
      }
    }

    self givemaxammo(var_03);
  }

  self playlocalsound("ammo_crate_use");
}
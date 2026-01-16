/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\smokegrenade.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\duplicaterender_mgr;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\renderoverridebundle;
#include scripts\core_common\sound_shared;
#include scripts\core_common\util_shared;

#namespace smokegrenade;

init_shared() {
  clientfield::register("allplayers", "inenemysmoke", 14000, 1, "int", &insmoke, 0, 0);
  clientfield::register("scriptmover", "smoke_state", 16000, 1, "int", &function_ffbaa2ce, 0, 0);
  clientfield::register("allplayers", "insmoke", 16000, 2, "int", &insmoke, 0, 0);
  renderoverridebundle::function_f72f089c(#"hash_8120ecc0ceec5c6", "rob_mute_smoke_outline", &function_28db726, undefined, undefined, 1);
  renderoverridebundle::function_f72f089c(#"hash_224b6b4d7364dbb5", "rob_mute_smoke_outline_team", &function_62ec0142, undefined, undefined, 1);
  callback::on_localplayer_spawned(&on_local_player_spawned);
  level.var_7cc76271 = &vehicle_transition;
}

on_local_player_spawned(local_client_num) {
  thread function_e69d0e4d(local_client_num);
  thread track_grenades(local_client_num);
  players = getplayers(local_client_num);

  foreach(player in players) {
    if(isDefined(player) && isalive(player)) {
      player function_4fc900e1(local_client_num);
    }
  }
}

track_grenades(local_client_num) {
  self notify(#"track_grenades");
  self endon(#"track_grenades", #"death", #"disconnect");
  waitresult = self waittill(#"grenade_fire");
  grenade = waitresult.projectile;
  weapon = waitresult.weapon;
}

function_709fad19() {
  weapon = getweapon(#"eq_smoke");

  if(!isDefined(weapon) || weapon == level.weaponnone || !isDefined(weapon.customsettings)) {
    return 128;
  }

  var_b0b958b3 = getscriptbundle(weapon.customsettings);
  return isDefined(var_b0b958b3.var_40dfefd1) ? var_b0b958b3.var_40dfefd1 : 128;
}

monitor_smoke(local_client_num) {
  var_d3f60df1 = self;
  self notify(#"monitor_smoke");
  self endon(#"monitor_smoke", #"death", #"delete");
  localplayer = function_5c10bd79(local_client_num);

  if(isDefined(var_d3f60df1) && isDefined(var_d3f60df1.owner) && isDefined(localplayer) && var_d3f60df1.owner != localplayer) {
    return;
  }

  radius = function_709fad19();

  while(isDefined(var_d3f60df1)) {
    waitresult = var_d3f60df1 waittilltimeout(0.25, #"death");
    players = getplayers(local_client_num);

    foreach(player in players) {
      dist = distance2d(player.origin, var_d3f60df1.origin);

      if(dist < radius) {
        if(!isDefined(player.var_d3f60df1)) {
          player.var_d3f60df1 = var_d3f60df1;
          player function_4fc900e1(local_client_num);
        }

        continue;
      }

      if(isDefined(player.var_d3f60df1)) {
        player.var_d3f60df1 = undefined;
        player function_4fc900e1(local_client_num);
      }
    }

    if(waitresult._notify != "timeout") {
      break;
    }
  }
}

function_ffbaa2ce(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self thread monitor_smoke(local_client_num);
    return;
  }

  self notify(#"monitor_smoke");
  players = getplayers(local_client_num);

  foreach(player in players) {
    if(isDefined(player) && isalive(player)) {
      player.var_d3f60df1 = undefined;
      player function_4fc900e1(local_client_num);
    }
  }
}

function_e69d0e4d(local_client_num) {
  self notify(#"hash_2286178f49f4601d");
  self endon(#"hash_2286178f49f4601d", #"death", #"disconnect");
  var_e098466f = 0;

  while(true) {
    isinfrared = isinfrared(local_client_num);

    if(isDefined(var_e098466f) && var_e098466f && !isinfrared || !(isDefined(var_e098466f) && var_e098466f) && isinfrared) {
      var_85098191 = function_5778f82(local_client_num, #"hash_410c46b5ff702c96");

      if(var_85098191) {
        players = getplayers(local_client_num);

        foreach(player in players) {
          if(isDefined(player) && isalive(player)) {
            player function_4fc900e1(local_client_num);
          }
        }
      }

      var_e098466f = isinfrared;
    }

    wait 0.25;
  }
}

function_62ec0142(local_client_num, bundle) {
  var_85098191 = function_5778f82(local_client_num, #"hash_410c46b5ff702c96");

  if(!var_85098191) {
    return false;
  }

  if(util::is_player_view_linked_to_entity(local_client_num)) {
    return false;
  }

  if(!self function_83973173()) {
    return false;
  }

  if(isinfrared(local_client_num)) {
    return false;
  }

  if(!(isDefined(self.insmoke) && self.insmoke&2)) {
    return false;
  }

  localplayer = function_5c10bd79(local_client_num);

  if(self == localplayer) {
    curweapon = self function_d2c2b168();
    blade = getweapon(#"sig_blade");

    if(!isthirdperson(local_client_num) || curweapon != blade) {
      return false;
    }
  }

  weapon = getweapon("eq_smoke");

  if(isDefined(weapon.customsettings)) {
    var_ed9e87ac = getscriptbundle(weapon.customsettings);
    assert(isDefined(var_ed9e87ac));

    if(!(isDefined(var_ed9e87ac.var_563d4859) ? var_ed9e87ac.var_563d4859 : 0)) {
      return false;
    }
  }

  return true;
}

function_28db726(local_client_num, bundle) {
  var_85098191 = function_5778f82(local_client_num, #"hash_410c46b5ff702c96");

  if(!var_85098191) {
    return false;
  }

  if(util::is_player_view_linked_to_entity(local_client_num)) {
    return false;
  }

  if(self function_83973173()) {
    return false;
  }

  if(isinfrared(local_client_num)) {
    return false;
  }

  if(!(isDefined(self.insmoke) && self.insmoke&1)) {
    return false;
  }

  weapon = getweapon("eq_smoke");

  if(isDefined(weapon.customsettings)) {
    var_ed9e87ac = getscriptbundle(weapon.customsettings);
    assert(isDefined(var_ed9e87ac));

    if((isDefined(var_ed9e87ac.var_ae2b2941) ? var_ed9e87ac.var_ae2b2941 : 0) && self hastalent(local_client_num, #"talent_coldblooded")) {
      return false;
    }
  }

  return true;
}

vehicle_transition(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  players = getplayers(local_client_num);

  foreach(player in players) {
    if(isalive(player)) {
      var_85098191 = function_5778f82(local_client_num, #"hash_410c46b5ff702c96");

      if(var_85098191) {
        player function_4fc900e1(local_client_num);
      }
    }
  }
}

function_4fc900e1(local_client_num) {
  self renderoverridebundle::function_c8d97b8e(local_client_num, #"friendly_smoke", #"hash_8120ecc0ceec5c6");
  self renderoverridebundle::function_c8d97b8e(local_client_num, #"enemy_smoke", #"hash_224b6b4d7364dbb5");
}

insmoke(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  player = self;
  player.insmoke = newval;
  var_85098191 = function_5778f82(local_client_num, #"hash_410c46b5ff702c96");

  if(var_85098191) {
    function_4fc900e1(local_client_num);
  }
}
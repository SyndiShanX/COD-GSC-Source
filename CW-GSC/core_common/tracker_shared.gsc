/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\tracker_shared.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\globallogic\globallogic_player;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\weapons\weaponobjects;
#namespace tracker;

function init_shared() {
  register_clientfields();
  level.trackerperk = spawnStruct();
  level.var_c8241070 = &function_c8241070;
  level.var_b3e158f6 = &function_ec3bbe79;
  thread function_a7e7bda0();
  level.trackerperk.var_ec00f4ac = [];
  callback::on_spawned(&onplayerspawned);
  callback::on_disconnect(&onplayerdisconnect);
  var_398a0413 = getdvarint(#"hash_3f50d960d95b965a");
  level.var_398a0413 = var_398a0413 < 0 ? 2000 : var_398a0413;
  var_5b162bc3 = getdvarint(#"hash_7ae43b6918bd9bac");
  level.var_5b162bc3 = var_5b162bc3 < 0 ? 1000 : var_5b162bc3;
}

function register_clientfields() {
  clientfield::register_clientuimodel("huditems.isExposedOnMinimap", 1, 1, "int");
  serverfield::register("sf_tracker_spotting", 1, 6, "int", &function_1085f2e2);
  clientfield::register("allplayers", "cf_tracker_spotting", 1, 6, "int");
}

function onplayerspawned() {
  self clientfield::set_player_uimodel("huditems.isExposedOnMinimap", 0);
}

function onplayerdisconnect() {
  var_f6536836 = self getentitynumber();

  if(isDefined(level.var_a7185e8f[var_f6536836])) {
    var_c77f744a = getarraykeys(level.var_a7185e8f[var_f6536836]);

    foreach(targetentnum in var_c77f744a) {
      function_486aa28(targetentnum, var_f6536836);
    }
  }
}

function function_1085f2e2(oldval, newval) {
  if(!isDefined(self.var_a7185e8f)) {
    self.var_a7185e8f = [];
  }

  var_f6536836 = self getentitynumber();

  if(newval) {
    var_b80b7c6b = newval - 1;
    newtarget = getentbynum(var_b80b7c6b);

    if(isPlayer(newtarget)) {
      if(!isDefined(newtarget.var_50575fa8)) {
        newtarget.var_50575fa8 = [];
      }

      newtarget.var_50575fa8[var_f6536836] = 1;
      self.var_a7185e8f[var_b80b7c6b] = -1;
    }
  }

  if(oldval) {
    var_2aabed59 = oldval - 1;
    self.var_a7185e8f[var_2aabed59] = gettime() + level.var_398a0413 + level.var_5b162bc3;
    self thread function_6eab3112(var_f6536836);
  }

  self clientfield::set("cf_tracker_spotting", newval);
}

function function_6eab3112(var_f6536836) {
  self notify(#"hash_4447a820f3360c98");
  self endon(#"disconnect", #"hash_4447a820f3360c98");

  while(isDefined(self.var_a7185e8f) && self.var_a7185e8f.size) {
    var_4ad6fbe5 = 0;
    var_c77f744a = getarraykeys(self.var_a7185e8f);

    foreach(targetentnum in var_c77f744a) {
      endtime = self.var_a7185e8f[targetentnum];

      if(endtime != -1) {
        var_4ad6fbe5++;

        if(gettime() > endtime) {
          self.var_a7185e8f[targetentnum] = undefined;
          function_486aa28(targetentnum, var_f6536836);

          if(!self.var_a7185e8f.size) {
            self.var_a7185e8f = undefined;
            return;
          }
        }
      }
    }

    if(var_4ad6fbe5 == 0) {
      return;
    }

    wait 0.1;
  }
}

function function_486aa28(targetentnum, var_f6536836) {
  target = getentbynum(targetentnum);

  if(isPlayer(target) && isDefined(target.var_50575fa8)) {
    target.var_50575fa8[var_f6536836] = undefined;

    if(!target.var_50575fa8.size) {
      target.var_50575fa8 = undefined;
    }
  }
}

function function_ec3bbe79(data) {
  if(!isPlayer(self)) {
    return;
  }

  victim = data.victim;
  spotters = data.var_83d5e1bd;

  if(!isDefined(spotters)) {
    return;
  }

  var_c1a7eb10 = getarraykeys(spotters);

  foreach(var_f6536836 in var_c1a7eb10) {
    spotter = getentbynum(var_f6536836);

    if(isPlayer(spotter) && spotter != self && spotter.team === self.team) {
      scoreevents::processscoreevent(#"hash_250eb876852d8525", spotter, victim);
    }
  }

  victim.var_50575fa8 = undefined;
}

function function_c8241070(player, weapon) {
  level.trackerperk.var_ec00f4ac[weapon.clientid] = gettime() + float(getdvarint(#"hash_6f3f10e68d2fedba", 0)) / 1000;
}

function function_43084f6c(player) {
  if(level.teambased) {
    otherteam = util::getotherteam(player.team);

    foreach(var_f53fe24c in getplayers(otherteam)) {
      if(var_f53fe24c function_d210981e(player.origin)) {
        return true;
      }
    }
  } else {
    enemies = getplayers();

    foreach(enemy in enemies) {
      if(enemy == player) {
        continue;
      }

      if(enemy function_d210981e(player.origin)) {
        return true;
      }
    }
  }

  return false;
}

function function_2c77961d(player) {
  expiretime = level.trackerperk.var_ec00f4ac[player.clientid];

  if(!isDefined(expiretime)) {
    return false;
  }

  if(gettime() > expiretime) {
    return false;
  }

  return true;
}

function function_796e0334(player) {
  if(1 && globallogic_player::function_eddea888(player)) {
    return true;
  }

  if(1 && globallogic_player::function_43084f6c(player)) {
    return true;
  }

  if(1 && function_2c77961d(player)) {
    return true;
  }

  if(1 && globallogic_player::function_ce33e204(player)) {
    return true;
  }

  return false;
}

function function_a7e7bda0() {
  if(getgametypesetting(#"hardcoremode")) {
    return;
  }

  while(true) {
    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }

      if(!player hasperk(#"specialty_detectedicon")) {
        continue;
      }

      if(function_796e0334(player)) {
        if(!isDefined(player.var_7241f6e3)) {
          player.var_7241f6e3 = gettime() + 100;
        }

        if(player.var_7241f6e3 <= gettime()) {
          player clientfield::set_player_uimodel("huditems.isExposedOnMinimap", 1);
          player.var_99811216 = gettime() + 100;
        }

        continue;
      }

      if(isDefined(player.var_99811216) && gettime() > player.var_99811216 && player clientfield::get_player_uimodel("huditems.isExposedOnMinimap")) {
        player clientfield::set_player_uimodel("huditems.isExposedOnMinimap", 0);
        player.var_7241f6e3 = undefined;
      }
    }

    wait 0.1;
  }
}
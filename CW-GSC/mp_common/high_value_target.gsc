/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\high_value_target.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\mp_common\player\player_utils;
#namespace high_value_target;

function private autoexec __init__system__() {
  system::register(#"high_value_target", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.var_8d51c9b1 = getgametypesetting(#"hash_6141cddd96ac214e");
  callback::on_spawned(&onplayerspawned);
  player::function_cf3aa03d(&onplayerkilled);
  level.var_63b58cff = [];

  for(i = 1; i <= 20; i++) {
    eventname = hash(#"hash_782e222fd957d953" + i);
    level.var_63b58cff[eventname] = eventname;
  }
}

function onplayerspawned() {
  killstreakcount = isDefined(self.pers[# "cur_kill_streak"]) ? self.pers[# "cur_kill_streak"] : 0;

  if(killstreakcount < level.var_8d51c9b1) {
    if(self.ishvt !== 0) {
      self clientfield::set("high_value_target", 0);
      self.ishvt = 0;
    }

    return;
  }

  if(self.ishvt !== 1) {
    self clientfield::set("high_value_target", 1);
    self.ishvt = 1;
  }
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(isDefined(psoffsettime) && isDefined(psoffsettime.pers[# "cur_kill_streak"])) {
    var_f5d993e3 = isDefined(psoffsettime.pers[# "cur_kill_streak"]) ? psoffsettime.pers[# "cur_kill_streak"] : 0;

    if(var_f5d993e3 >= level.var_8d51c9b1 && psoffsettime clientfield::get("high_value_target") !== 1) {
      psoffsettime clientfield::set("high_value_target", 1);
      psoffsettime.ishvt = 1;
    }
  }

  if(isDefined(self) && self.ishvt === 1) {
    if(isDefined(psoffsettime) && isPlayer(psoffsettime) && psoffsettime hasperk(#"hash_1c40ade36b54ff8") && psoffsettime != self && psoffsettime.team != self.team) {
      var_13f7eb29 = self.pers[# "kill_streak_before_death"];

      if(!isDefined(var_13f7eb29) || var_13f7eb29 < level.var_8d51c9b1) {
        return;
      }

      if(var_13f7eb29 > 20) {
        scoreevent = # "hash_782e222fd957d953" + 20;
      } else {
        scoreevent = # "hash_782e222fd957d953" + var_13f7eb29;
      }

      scoreevents::processscoreevent(scoreevent, psoffsettime, self, deathanimduration);
      psoffsettime contracts::increment_contract(#"hash_587a28da043d491d", 1);
      psoffsettime stats::function_a47092b5(#"hash_dfaf3206d734ea9", 1, #"hash_5de4e8563e882e42");
    }
  }
}

function function_66a9a1e4(event) {
  return isDefined(level.var_63b58cff[event]);
}
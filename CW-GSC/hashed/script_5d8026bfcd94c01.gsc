/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5d8026bfcd94c01.gsc
***********************************************/

#using script_335d0650ed05d36d;
#using script_44b0b8420eabacad;
#using script_b9a55edd207e4ca;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\dogtags;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\util;
#namespace namespace_f2e23b4a;

function private autoexec __init__system__() {
  system::register(#"hash_112a74f076cda31", &function_62730899, undefined, undefined, #"territory");
}

function event_handler[gametype_init] main(eventstruct) {
  namespace_2938acdc::init();
  spawning::addsupportedspawnpointtype("tdm");
  callback::on_spawned(&on_player_spawned);
  level.var_61d4f517 = 1;
  level.var_febab1ea = # "conf_dogtags_hpc";
  level.var_e7b05b51 = 1;
}

function private function_62730899() {
  if(isDefined(level.territory) && level.territory.name != "zoo") {
    namespace_2938acdc::function_4212369d();
  }

  level.onstartgametype = &onstartgametype;
  player::function_cf3aa03d(&onplayerkilled);
  level.teamscoreperkillconfirmed = getgametypesetting(#"teamscoreperkillconfirmed");
  level.teamscoreperkilldenied = getgametypesetting(#"teamscoreperkilldenied");
}

function onstartgametype() {
  dogtags::init();

  if(!util::isoneround()) {
    level.displayroundendtext = 1;
  }
}

function function_79b13f76(attacker) {
  if(abs(level.mapcenter[2] + self.origin[2]) > 100000) {
    return;
  }

  numdogtags = 1;

  for(index = 0; index < numdogtags; index++) {
    posoffset = (randomintrange(-20, 20), randomintrange(-20, 20), 0) * index;
    level thread dogtags::spawn_dog_tag(self, attacker, &onuse, 0, posoffset);
  }
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(!isPlayer(psoffsettime) || psoffsettime.team == self.team) {
    return;
  }

  if(!isDefined(killstreaks::get_killstreak_for_weapon(deathanimduration)) || is_true(level.killstreaksgivegamescore)) {
    psoffsettime globallogic_score::giveteamscoreforobjective(psoffsettime.team, level.teamscoreperkill);
  }

  function_79b13f76(psoffsettime);
}

function onuse(player) {
  tacinsertboost = 0;
  var_5f50a7ed = 0;
  player.pers[#"objectives"]++;
  player.objectives = player.pers[#"objectives"];

  if(!util::function_fbce7263(player.team, self.victimteam)) {
    tacinsertboost = self.tacinsert;

    if(isDefined(self.attacker) && !util::function_fbce7263(self.attacker.team, self.attackerteam)) {
      self.attacker luinotifyevent(#"player_callout", 2, #"mp/kill_denied", player.entnum);
    }

    if(!tacinsertboost) {
      player globallogic_score::giveteamscoreforobjective(player.team, level.teamscoreperkilldenied);
    }

    return;
  }

  assert(isDefined(player.lastkillconfirmedtime));
  assert(isDefined(player.lastkillconfirmedcount));

  if(isDefined(self.attacker) && util::function_fbce7263(self.attacker.team, player.team)) {
    self.attacker luinotifyevent(#"player_callout", 2, #"hash_75462478f6a06755", player.entnum);
  }

  player.pers[#"killsconfirmed"]++;
  player.killsconfirmed = player.pers[#"killsconfirmed"];
  player globallogic_score::giveteamscoreforobjective(player.team, level.teamscoreperkillconfirmed);

  if(!tacinsertboost) {
    currenttime = gettime();

    if(player.lastkillconfirmedtime + 4000 > currenttime) {
      player.lastkillconfirmedcount++;

      if(player.lastkillconfirmedcount >= 3) {
        scoreevents::processscoreevent(#"kill_confirmed_multi", player, undefined, undefined);
        player.lastkillconfirmedcount = 0;
      }
    } else {
      player.lastkillconfirmedcount = 1;
    }

    player.lastkillconfirmedtime = currenttime;
  }
}

function on_player_spawned() {
  self.usingobj = undefined;

  if(spawning::usestartspawns() && !level.ingraceperiod) {
    spawning::function_7a87efaa();
  }

  self.lastkillconfirmedtime = 0;
  self.lastkillconfirmedcount = 0;
}
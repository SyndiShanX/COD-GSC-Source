/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\conf.gsc
***********************************************/

#using script_335d0650ed05d36d;
#using script_44b0b8420eabacad;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\dogtags;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\gametypes\cranked;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\hostmigration;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\spawning;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\util;
#namespace conf;

function event_handler[gametype_init] main(eventstruct) {
  globallogic::init();
  spawning::addsupportedspawnpointtype("tdm");
  spawning::function_32b97d1b(&spawning::function_90dee50d);
  spawning::function_adbbb58a(&spawning::function_c24e290c);
  level.onstartgametype = &onstartgametype;
  level.onspawnplayer = &onspawnplayer;
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

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(!isPlayer(psoffsettime) || psoffsettime.team == self.team) {
    return;
  }

  level thread dogtags::spawn_dog_tag(self, psoffsettime, &onuse, 0);

  if(!isDefined(killstreaks::get_killstreak_for_weapon(deathanimduration)) || is_true(level.killstreaksgivegamescore)) {
    psoffsettime globallogic_score::giveteamscoreforobjective(psoffsettime.team, level.teamscoreperkill);
  }
}

function onuse(player) {
  tacinsertboost = 0;
  player.pers[#"objectives"]++;
  player.objectives = player.pers[#"objectives"];

  if(level.var_ac25d260 === 1) {
    player cranked::function_cf725f10();
  }

  if(player.team != self.attackerteam) {
    tacinsertboost = self.tacinsert;

    if(isDefined(self.attacker) && self.attacker.team == self.attackerteam) {
      self.attacker luinotifyevent(#"player_callout", 2, #"mp/kill_denied", player.entnum);
    }

    if(!tacinsertboost) {
      player globallogic_score::giveteamscoreforobjective(player.team, level.teamscoreperkilldenied);
      player contracts::increment_contract(#"hash_7f29e6dade49a6b7", 1);
    }

    return;
  }

  assert(isDefined(player.lastkillconfirmedtime));
  assert(isDefined(player.lastkillconfirmedcount));

  player.pers[#"killsconfirmed"]++;
  player.killsconfirmed = player.pers[#"killsconfirmed"];
  player globallogic_score::giveteamscoreforobjective(player.team, level.teamscoreperkillconfirmed);
  player contracts::increment_contract(#"hash_27de6edf9043b26f", 1);

  if(level.var_ac25d260 === 1 && isDefined(self.attacker) && self.attacker !== player) {
    self.attacker cranked::function_cf725f10();
  }

  if(!tacinsertboost) {
    currenttime = gettime();

    if(player.lastkillconfirmedtime + 4000 > currenttime) {
      player.lastkillconfirmedcount++;

      if(player.lastkillconfirmedcount >= 3) {
        scoreevents::processscoreevent(#"kill_confirmed_multi", player, undefined, undefined);
        player contracts::increment_contract(#"hash_2185f973f409838f", 1);
        player stats::function_cc215323(#"hash_1b563e11d9caca7e", 1);
        player.lastkillconfirmedcount = 0;
      }
    } else {
      player.lastkillconfirmedcount = 1;
    }

    player.lastkillconfirmedtime = currenttime;
  }
}

function onspawnplayer(predictedspawn) {
  self.usingobj = undefined;

  if(spawning::usestartspawns() && !level.ingraceperiod) {
    spawning::function_7a87efaa();
  }

  self.lastkillconfirmedtime = 0;
  self.lastkillconfirmedcount = 0;
  spawning::onspawnplayer(predictedspawn);
  dogtags::on_spawn_player();
}
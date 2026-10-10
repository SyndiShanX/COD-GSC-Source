/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_294f6be0d87c3600.gsc
*************************************************/

#using scripts\common\values;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\warrior;
#using scripts\mp\teamrevive;
#using scripts\mp\tweakables;
#using scripts\mp\utility\game;
#using scripts\mp\utility\teams;
#namespace warrior_revive;

function function_12d48a74b22a6cce() {
  level.var_6298f362ec23d83.var_ed4e34303b974aa4 = [];
  level.var_6298f362ec23d83.var_ed4e34303b974aa4["allies"] = spawnStruct();
  level.var_6298f362ec23d83.var_ed4e34303b974aa4["axis"] = spawnStruct();
  level.var_6298f362ec23d83.var_ed4e34303b974aa4["team_three"] = spawnStruct();
  level.laststandtimer = 60;
  level.var_28a06842b082bea1 = 1;
  scripts\mp\tweakables::settweakablevalue("player", "laststand", 3);
  thread scripts\mp\teamrevive::init();
  thread onplayerspawned();
  thread function_8b680aaf88eed250();
  level.var_6298f362ec23d83.var_1a1560a31a0ed63b = level.addlaststandoverheadiconcallback;
  level.addlaststandoverheadiconcallback = &addlaststandoverheadiconcallback;
  setomnvar("ui_hide_player_icons", 1);
  val::group_register("laststand_revive", ["allow_movement", "usability", "reload", "fire", "offhand_weapons", "offhand_primary_weapons", "offhand_secondary_weapons", "killstreaks", "supers", "gesture", "allow_jump", "sprint", "melee", "stand", "prone"]);
  thread function_492b4dec632917ec("warrior_revive");
}

function function_7826f269377f2e62() {
  foreach(player in level.players) {
    player val::group_reset("revive");
    player.var_1391ec6ead831d00 = undefined;
  }

  level.addlaststandoverheadiconcallback = level.var_6298f362ec23d83.var_1a1560a31a0ed63b;
  setomnvar("ui_hide_player_icons", 0);
  level notify("warrior_revive_complete");
}

function onplayerspawned() {
  level endon("game_ended");
  level endon("round_end_finished");

  while(true) {
    level waittill("player_spawned", player);
    player takeallweapons();
    fistsweapon = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845("iw9_me_fists_mp");
    player giveweapon(fistsweapon);
    player setspawnweapon(fistsweapon);
  }
}

function function_8b680aaf88eed250() {
  scripts\mp\flags::function_1240434f4201ac9d("prematch_done");

  foreach(team in level.teamnamelist) {
    players = getteamdata(team, "players");

    if(isDefined(players)) {
      randomnum = randomint(2);
      players[randomnum] val::group_set("laststand_revive", 0);
      players[randomnum][[level.callbackplayerlaststand]](undefined, undefined, undefined, "MOD_SUICIDE", undefined, undefined, "none");
      players[randomnum] setstance("crouch");
      players[randomnum] thread function_f7c51f5832b5273a();
      players[randomnum] thread function_268bf779da4261bf();
      players[randomnum].var_1391ec6ead831d00 = 1;
    }
  }
}

function function_f7c51f5832b5273a() {
  level endon("game_ended");
  level endon("round_end_finished");

  while(true) {
    self waittill("handle_revive_message");
    val::group_set("laststand_revive", 0);
  }
}

function function_268bf779da4261bf() {
  level endon("warrior_revive_complete");
  self waittill("last_stand_revived");
  scripts\mp\gamelogic::endgame(self.team, game["end_reason"]["objective_completed"]);
}

function function_d63a7e17a1e870f2(winner, endreasontext, nukedetonated) {
  setscore = 0;

  if(winner != "tie") {
    scripts\mp\gamescore::giveteamscoreforobjective(winner, 1, 1);
    setscore = 1;
  }

  return setscore;
}

function getspawnteam() {
  if(isDefined(level.var_6298f362ec23d83.var_ed4e34303b974aa4[self.team].player1)) {
    return function_925e255e3693811a();
  }

  level.var_6298f362ec23d83.var_ed4e34303b974aa4[self.team].player1 = self;
  return self.team;
}

function function_925e255e3693811a() {
  enemyteam = function_9c3e1d94e41dffb();
  level.var_6298f362ec23d83.var_ed4e34303b974aa4[enemyteam].player2 = self;
  return enemyteam;
}

function function_9c3e1d94e41dffb() {
  for(i = 0; i < level.teamnamelist.size; i++) {
    if(level.teamnamelist[i] == self.team) {
      if(i < level.teamnamelist.size - 1) {
        return level.teamnamelist[i + 1];
      }

      return level.teamnamelist[0];
    }
  }
}

function addlaststandoverheadiconcallback() {}
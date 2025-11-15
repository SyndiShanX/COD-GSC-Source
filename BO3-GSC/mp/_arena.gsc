/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_arena.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\teams\_teams;
#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace arena;

function autoexec __init__sytem__() {
  system::register("arena", & __init__, undefined, undefined);
}

function __init__() {
  callback::on_connect( & on_connect);
}

function on_connect() {
  if(isDefined(self.pers["arenaInit"]) && self.pers["arenaInit"] == 1) {
    return;
  }
  draftenabled = getgametypesetting("pregameDraftEnabled") == 1;
  voteenabled = getgametypesetting("pregameItemVoteEnabled") == 1;
  if(!draftenabled && !voteenabled) {
    self arenabeginmatch();
  }
  self.pers["arenaInit"] = 1;
}

function update_arena_challenge_seasons() {
  perseasonwins = self getdstat("arenaPerSeasonStats", "wins");
  if(perseasonwins >= getdvarint("arena_seasonVetChallengeWins")) {
    arenaslot = arenagetslot();
    currentseason = self getdstat("arenaStats", arenaslot, "season");
    seasonvetchallengearraycount = self getdstatarraycount("arenaChallengeSeasons");
    for(i = 0; i < seasonvetchallengearraycount; i++) {
      challengeseason = self getdstat("arenaChallengeSeasons", i);
      if(challengeseason == currentseason) {
        return;
      }
      if(challengeseason == 0) {
        self setdstat("arenaChallengeSeasons", i, currentseason);
        break;
      }
    }
  }
}

function match_end(winner) {
  for(index = 0; index < level.players.size; index++) {
    player = level.players[index];
    if(isDefined(player.pers["arenaInit"]) && player.pers["arenaInit"] == 1) {
      if(winner == "tie") {
        player arenaendmatch(0);
        continue;
      }
      if(winner == player.pers["team"]) {
        player arenaendmatch(1);
        player update_arena_challenge_seasons();
        continue;
      }
      player arenaendmatch(-1);
    }
  }
}
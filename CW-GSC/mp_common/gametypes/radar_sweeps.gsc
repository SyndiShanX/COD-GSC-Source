/************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\radar_sweeps.gsc
************************************************/

#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\mp_common\gametypes\globallogic_utils;
#namespace radar_sweeps;

function radarsweeps() {
  level endon(#"game_ended");

  if(!sessionmodeismultiplayergame()) {
    return;
  }

  level.var_f0eb9bca = getgametypesetting(#"hash_6aba2f652c6f4e07");
  level.var_fdd4b16 = getgametypesetting(#"hash_926bf70c5a0d23b");
  level.var_e4cfa0c3 = getgametypesetting(#"hash_3da025c068c34bcb");

  while(game.state !== # "playing") {
    wait 1;
  }

  if(level.var_f0eb9bca) {
    while(!level.var_fdd4b16 || float(globallogic_utils::gettimeremaining()) / 1000 > level.var_e4cfa0c3) {
      wait level.var_f0eb9bca;
      var_bc40925b = level.var_f0eb9bca > 10;
      thread doradarsweep(var_bc40925b);
    }
  } else if(level.var_fdd4b16) {
    while(float(globallogic_utils::gettimeremaining()) / 1000 > level.var_e4cfa0c3) {
      wait 1;
    }
  }

  if(level.var_fdd4b16) {
    while(game.state == # "playing") {
      wait level.var_fdd4b16;
      var_bc40925b = level.var_fdd4b16 > 10;
      thread doradarsweep();
    }
  }
}

function private doradarsweep(var_bc40925b) {
  if(isDefined(var_bc40925b) && globallogic_utils::gettimeremaining() > 10) {
    thread globallogic_audio::leader_dialog("bountyUAVSweep");
  }

  foreach(team, _ in level.teams) {
    setteamspyplane(team, 1);
  }

  wait 5;

  foreach(team, _ in level.teams) {
    setteamspyplane(team, 0);
  }
}
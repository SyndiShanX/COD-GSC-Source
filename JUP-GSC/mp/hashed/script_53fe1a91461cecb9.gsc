/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_53fe1a91461cecb9.gsc
*************************************************/

#using script_47a7dd805c87b33f;
#using scripts\common\utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_ending;
#namespace namespace_af9589a759e3ad0c;

function function_1748039e0a11f61b() {
  if(!isDefined(level.player) || !isDefined(level.allybot)) {
    return;
  }

  level.blackoverlay = function_c0e79dfb73eaae6a("black", 0);
  level.blackoverlay.alpha = 1;
  level.player setstance("stand");
  level.allybot setstance("stand");
  level.blackoverlay fadeovertime(0.5);
  level.blackoverlay.alpha = 0;
  level.player setplayerangles((0, 50, 0));
  level.player playxcam("wz_gulag_player_acknowledge_r_xcam", 0, level.player.origin, (0, 55, 0));
  level.player playanimscriptsceneevent("scripted_scene", "wz_gulag_player_acknowledge_r_pistol");
  level.allybot playanimscriptsceneevent("scripted_scene", "wz_gulag_player_acknowledge_l");
  wait 4;
  level.blackoverlay fadeovertime(0.5);
  level.blackoverlay.alpha = 1;
  wait 0.5;
  level.player stopxcam();
  level.player stopanimscriptsceneevent();
  level.player setplayerangles(level.ftuedata.var_9d94e563e4be46b8);
  level.player setstance(level.ftuedata.var_396891c2565891d8);
  level.allybot stopanimscriptsceneevent();
  level.allybot setstance(level.ftuedata.var_8c5da83724fd450b);
  waitframe();
  level.blackoverlay fadeovertime(0.5);
  level.blackoverlay.alpha = 0;
}

function function_c155068cdb5d5105() {
  level endon("endingSceneStop");

  if(istrue(level.var_409e991baf3101bb)) {
    return;
  }

  level.var_409e991baf3101bb = 1;
  level thread function_5a0fd2fe14b493f9();

  foreach(operator in level.players) {
    if(operator != level.players[0]) {
      operator function_a593971d75d82113();
      operator function_379bb555405c16bb("ftue_infilexfil::ftue_exfilLaunch()");
    }
  }

  level thread scripts\mp\gametypes\br::handleendgamesplash(level.player.team, 0);
  level.player setclientomnvar("ui_br_player_position", 1);
  wait 2;
  winners = [];
  winners = array_add(winners, level.player);
  level.var_d81f9416f44ab4ba = spawnStruct();
  level.var_d81f9416f44ab4ba.var_747d19faf68a7748 = "mgl_ftue_tutorial";
  scripts\mp\gametypes\br_ending::play_ending(winners);
  waitframe();
  function_c73f942aa663ad4a();
  level notify("endingSceneDone");
}

function function_5a0fd2fe14b493f9() {
  level endon("endingSceneDone");
  hostplayer = scripts\mp\gamelogic::gethostplayer();

  if(!isDefined(hostplayer)) {
    return;
  }

  while(hostplayer buttonPressed("DPAD_LEFT")) {
    waitframe();
  }

  while(!hostplayer buttonPressed("DPAD_LEFT")) {
    waitframe();
  }

  level notify("endingSceneStop");
  scripts\mp\gametypes\br_ending::cleanup_ending(level.br_ending);
  function_c73f942aa663ad4a();
}

function function_c73f942aa663ad4a() {
  setomnvarforallclients("ui_world_fade", 1);
  setomnvarforallclients("ui_br_end_game_splash_type", 0);
  scripts\mp\gametypes\br_ending::function_e50b941afd09e62e([]);

  foreach(player in level.players) {
    if(isDefined(player.hidehudenabled) && player.hidehudenabled > 0) {
      player utility::hidehuddisable();
    }

    player cameraunlink();
    player stopxcam();
    player unlink();

    if(isDefined(player.player_rig)) {
      player.player_rig delete();
    }

    if(isDefined(player.__ending_origin)) {
      player setOrigin(player.__ending_origin);
    }

    player scripts\mp\gametypes\br_ending::player_abilities_enable();
    player.plotarmor = undefined;
    player.oobimmunity = undefined;
  }

  if(isDefined(level.br_ending)) {
    if(isDefined(level.br_ending.transientname)) {
      unloadinfiltransient(level.br_ending.transientname);
    }

    scripts\mp\gametypes\br_ending::cleanup_ending(level.br_ending);
    level.br_ending = undefined;
  }

  level.var_409e991baf3101bb = 0;
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_245dddcaf477a7c4.gsc
***********************************************/

_id_1748039E0A11F61B() {
  if(!isDefined(level.player) || !isDefined(level._id_3896BF00E9C5CA00)) {
    return;
  }
  level.blackoverlay = _id_78DAC680A1677E7C::_id_C0E79DFB73EAAE6A("black", 0);
  level.blackoverlay.alpha = 1;
  level.player setstance("stand");
  level._id_3896BF00E9C5CA00 setstance("stand");
  level.blackoverlay fadeovertime(0.5);
  level.blackoverlay.alpha = 0;
  level.player setplayerangles((0, 50, 0));
  level.player _meth_33010A90BCF48DB4("wz_gulag_player_acknowledge_r_xcam", 0, level.player.origin, (0, 55, 0));
  level.player playanimscriptsceneevent("scripted_scene", "wz_gulag_player_acknowledge_r_pistol");
  level._id_3896BF00E9C5CA00 playanimscriptsceneevent("scripted_scene", "wz_gulag_player_acknowledge_l");
  wait 4;
  level.blackoverlay fadeovertime(0.5);
  level.blackoverlay.alpha = 1;
  wait 0.5;
  level.player _meth_8FF8FD7841F6EBA2();
  level.player stopanimscriptsceneevent();
  level.player setplayerangles(level._id_DBF4D97004E64BD5._id_9D94E563E4BE46B8);
  level.player setstance(level._id_DBF4D97004E64BD5._id_396891C2565891D8);
  level._id_3896BF00E9C5CA00 stopanimscriptsceneevent();
  level._id_3896BF00E9C5CA00 setstance(level._id_DBF4D97004E64BD5._id_8C5DA83724FD450B);
  waitframe();
  level.blackoverlay fadeovertime(0.5);
  level.blackoverlay.alpha = 0;
}

_id_919B5AD1E695966C() {
  level._id_D81F9416F44AB4BA = spawnStruct();
  level._id_D81F9416F44AB4BA._id_747D19FAF68A7748 = "mgl_ftue_tutorial";
}

_id_C155068CDB5D5105() {
  level endon("endingSceneStop");

  if(istrue(level._id_409E991BAF3101BB)) {
    return;
  }
  level._id_409E991BAF3101BB = 1;
  level thread _id_5A0FD2FE14B493F9();

  foreach(operator in level.players) {
    if(operator != level.players[0]) {
      operator scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
      operator scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("ftue_infilexfil::ftue_exfilLaunch()");
    }
  }

  level thread _id_1E4A61DB11011446::handleendgamesplash(level.player.team, 0);
  level.player setclientomnvar("ui_br_player_position", 1);
  wait 2;
  winners = [];
  winners = scripts\engine\utility::array_add(winners, level.player);
  _id_919B5AD1E695966C();
  _id_5C6B989A6F25F7FA::play_ending(winners);
  waitframe();
  _id_C73F942AA663AD4A();
  level notify("endingSceneDone");
}

_id_5A0FD2FE14B493F9() {
  level endon("endingSceneDone");
  _id_9D709D44ADD4A33A = scripts\mp\gamelogic::gethostplayer();

  if(!isDefined(_id_9D709D44ADD4A33A)) {
    return;
  }
  while(_id_9D709D44ADD4A33A buttonPressed("DPAD_LEFT"))
    waitframe();

  while(!_id_9D709D44ADD4A33A buttonPressed("DPAD_LEFT"))
    waitframe();

  level notify("endingSceneStop");
  _id_5C6B989A6F25F7FA::_id_9D9D6ECB7D1FD8E3(level.br_ending);
  _id_C73F942AA663AD4A();
}

_id_C73F942AA663AD4A() {
  setomnvarforallclients("ui_world_fade", 1);
  setomnvarforallclients("ui_br_end_game_splash_type", 0);

  foreach(player in level.players) {
    if(isDefined(player.hidehudenabled) && player.hidehudenabled > 0)
      player scripts\cp_mp\utility\player_utility::hidehuddisable();

    player cameraunlink();
    player _meth_8FF8FD7841F6EBA2();
    player unlink();

    if(isDefined(player.player_rig))
      player.player_rig delete();

    if(isDefined(player.__ending_origin))
      player setOrigin(player.__ending_origin);

    player _id_5C6B989A6F25F7FA::player_abilities_enable();
    player.plotarmor = undefined;
    player.oobimmunity = undefined;
  }

  if(isDefined(level.br_ending)) {
    if(isDefined(level.br_ending.transientname))
      unloadinfiltransient(level.br_ending.transientname);

    _id_5C6B989A6F25F7FA::_id_9D9D6ECB7D1FD8E3(level.br_ending);
    level.br_ending = undefined;
  }

  level._id_409E991BAF3101BB = 0;
}
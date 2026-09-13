/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5238dee479bbf7fb.gsc
***********************************************/

setupcirclepeek() {
  if(istrue(level.br_circle_disabled) || istrue(level.br_level.staticcircle) || istrue(level._id_CB9A9BFBBC8B8A0F)) {
    return;
  }
  level.circlepeeks = [];
  level.teamswithcirclepeek = [];

  for(index = 1; index < level.br_level.br_circleradii.size; index++)
    _id_587A4AE46D3A9611(index);

  level thread _id_27D74F1CF559CA7B();
}

_id_0126F8ECA2FA7D72() {
  foreach(_id_582E2E465A7917EE in level.circlepeeks) {
    foreach(_id_CBC7B6C43788BDBD in _id_582E2E465A7917EE._id_B0F4BF8621B96C0A)
    _id_CBC7B6C43788BDBD scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
  }

  level.circlepeeks = undefined;
}

_id_587A4AE46D3A9611(circleindex) {
  if(!isDefined(level.circlepeeks)) {
    return;
  }
  level.circlepeeks[circleindex] = spawnStruct();
  level.circlepeeks[circleindex]._id_B0F4BF8621B96C0A = [];
  circleradius = level.br_level.br_circleradii[circleindex];
  _id_C669C821EE772A3D = _id_58F20490049AF6AC::_id_D987886BB9DE9137();

  if(_id_C669C821EE772A3D > 1) {
    _id_ED09715E306A1455 = level._id_B31733F431ED12E0;

    if(circleindex < level._id_B31733F431ED12E0._id_8A10C39962F6D9FD || circleindex >= level._id_B31733F431ED12E0._id_C22567ED8CFE3761)
      _id_C669C821EE772A3D = 1;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C669C821EE772A3D; _id_AC0E594AC96AA3A8++) {
      circleorigin = _id_ED09715E306A1455._id_8D99DD732455FBF2[_id_AC0E594AC96AA3A8]._id_8AE269616D09DFC5[circleindex];
      _id_EC0FF24840E615D5(circleindex, circleorigin, circleradius);
    }
  } else {
    circleorigin = level.br_level.br_circlecenters[circleindex];
    _id_EC0FF24840E615D5(circleindex, circleorigin, circleradius);
  }
}

_id_EC0FF24840E615D5(circleindex, circleorigin, circleradius) {
  if(!isDefined(level.circlepeeks[circleindex])) {
    return;
  }
  _id_CBC7B6C43788BDBD = spawnStruct();
  _id_CBC7B6C43788BDBD scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("PeekCircle_Br", circleorigin, circleradius);
  _id_CBC7B6C43788BDBD scripts\cp_mp\utility\game_utility::_id_04EAF685BC40A3B9();
  _id_A61C75B156FC1EE0 = level.circlepeeks[circleindex]._id_B0F4BF8621B96C0A.size;
  level.circlepeeks[circleindex]._id_B0F4BF8621B96C0A[_id_A61C75B156FC1EE0] = _id_CBC7B6C43788BDBD;
}

_id_27D74F1CF559CA7B() {
  self endon("game_ended");
  level endon("CirclePeekCleanup");

  for(;;) {
    level waittill("br_circle_set");

    foreach(_id_CBC7B6C43788BDBD in level.circlepeeks[level.br_circle.circleindex + 1]._id_B0F4BF8621B96C0A)
    _id_CBC7B6C43788BDBD scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();

    foreach(team in getarraykeys(level.teamswithcirclepeek)) {
      level.teamswithcirclepeek[team]--;

      if(level.teamswithcirclepeek[team] < 0)
        level.teamswithcirclepeek[team] = 0;
    }
  }
}

_id_647A8C40104E4866(team) {
  if(istrue(level.br_circle_disabled) || getdvarint("br_circle_pause") == 1) {
    return;
  }
  if(!isDefined(level.teamswithcirclepeek[team]))
    level.teamswithcirclepeek[team] = 0;

  _id_F33D844D70BC5292 = -1;

  if(level.teamswithcirclepeek[team] == 0) {
    _id_BE2EEA72DFA2C196 = getdvarint("dvar_0A8B73338DF20273", 15);

    if(_id_BE2EEA72DFA2C196 >= _id_2695A20D4011076D::_id_ABBFB4D18D1A9CA7()) {
      level.teamswithcirclepeek[team]++;
      _id_F33D844D70BC5292 = level.teamswithcirclepeek[team] + level.br_circle.circleindex + 1;
    }
  }

  level.teamswithcirclepeek[team]++;
  index = level.teamswithcirclepeek[team] + level.br_circle.circleindex + 1;

  if(!isDefined(level.circlepeeks[index])) {
    foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
      if(_id_F33D844D70BC5292 != -1 && isDefined(level.circlepeeks[_id_F33D844D70BC5292])) {
        foreach(_id_CBC7B6C43788BDBD in level.circlepeeks[_id_F33D844D70BC5292]._id_B0F4BF8621B96C0A)
        _id_CBC7B6C43788BDBD scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(player);
      }

      player scripts\mp\utility\lower_message::setlowermessageomnvar("circle_peek_limit", undefined, 5);
    }

    return;
  }

  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
    foreach(_id_CBC7B6C43788BDBD in level.circlepeeks[index]._id_B0F4BF8621B96C0A)
    _id_CBC7B6C43788BDBD scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(player);

    if(_id_F33D844D70BC5292 != -1) {
      foreach(_id_CBC7B6C43788BDBD in level.circlepeeks[_id_F33D844D70BC5292]._id_B0F4BF8621B96C0A)
      _id_CBC7B6C43788BDBD scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(player);
    }
  }
}

_id_B8022B0E5E976F66(_id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  if(istrue(level.br_circle_disabled)) {
    return;
  }
  if(!isDefined(level.teamswithcirclepeek[_id_8A04AA0E0755E7E3]))
    level.teamswithcirclepeek[_id_8A04AA0E0755E7E3] = 0;

  if(!isDefined(level.teamswithcirclepeek[_id_EB06B338608EF354]))
    level.teamswithcirclepeek[_id_EB06B338608EF354] = 0;

  if(level.teamswithcirclepeek[_id_8A04AA0E0755E7E3] > level.teamswithcirclepeek[_id_EB06B338608EF354])
    level.teamswithcirclepeek[_id_EB06B338608EF354] = level.teamswithcirclepeek[_id_8A04AA0E0755E7E3];

  index = level.teamswithcirclepeek[_id_EB06B338608EF354] + level.br_circle.circleindex + 1;

  if(!isDefined(level.circlepeeks[index])) {
    return;
  }
  foreach(player in scripts\mp\utility\teams::getteamdata(_id_EB06B338608EF354, "players")) {
    foreach(_id_CBC7B6C43788BDBD in level.circlepeeks[index]._id_B0F4BF8621B96C0A)
    _id_CBC7B6C43788BDBD scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(player);
  }
}
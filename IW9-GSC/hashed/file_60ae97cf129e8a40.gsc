/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_60ae97cf129e8a40.gsc
***********************************************/

_id_733B23BB49FEB5C3() {
  level thread _id_28C73298E4316AC0::init();
  level thread _id_2DC6E355AF43A711::init();

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    _id_A94C90DC6C858DA4();

    if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73()) {
      spawnorigin = (603, 2705, 1306);

      if(isDefined(level._id_5B908CE3CCA6A715._id_F1AD02BC8D519E7B))
        spawnorigin = level._id_5B908CE3CCA6A715._id_F1AD02BC8D519E7B;

      _id_9F4A3632D9F75D32 = (-15604, 6617, -1000);

      if(isDefined(level._id_5B908CE3CCA6A715._id_C51425C87647226B))
        _id_9F4A3632D9F75D32 = level._id_5B908CE3CCA6A715._id_C51425C87647226B;

      spawnangle = (0, 60, 0);
      _id_4A0D1F5F6BE0F8C7::_id_7E904FF184E6794C(_id_9F4A3632D9F75D32, undefined, undefined, spawnorigin, spawnangle);
    }

    _func_EB7F544259415A09("mp_escape3");
  }
}

_id_A94C90DC6C858DA4() {
  _id_4FF6C6ED304E05BB::init();
  level.br_level = spawnStruct();
  level.br_level.br_corners = [];
  level.br_level.br_corners[0] = (5800, -12000, 200);
  level.br_level.br_corners[1] = (-7000, 14000, 200);
  _id_45ACCFF1681E0276 = 6000;

  if(scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "conflict")
    _id_45ACCFF1681E0276 = 8000;
  else if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    _id_B83C1C9CB27CC9D7 = -1;

    if(getDvar("dvar_7611A2790A0BF7FE", "") == "dmz" || getDvar("dvar_7611A2790A0BF7FE", "") == "plunder")
      _id_B83C1C9CB27CC9D7 = getdvarint("dvar_E432209CC5FBC970", 18000);
    else
      _id_B83C1C9CB27CC9D7 = getdvarint("dvar_E432209CC5FBC970", -1);

    if(_id_B83C1C9CB27CC9D7 != -1)
      _id_45ACCFF1681E0276 = _id_B83C1C9CB27CC9D7;
  }

  _id_45B2B4A889E633FA::setc130heightoverrides(_id_45ACCFF1681E0276, 65);
  level.br_level.c130_speedoverride = 2000;
  _id_3C590D0EE220B409 = min(level.br_level.br_corners[0][0], level.br_level.br_corners[1][0]);
  _id_C978C90E8E5AB1F7 = max(level.br_level.br_corners[0][0], level.br_level.br_corners[1][0]);
  _id_3C590C0EE220B1D6 = min(level.br_level.br_corners[1][1], level.br_level.br_corners[0][1]);
  _id_C978C80E8E5AAFC4 = max(level.br_level.br_corners[1][1], level.br_level.br_corners[0][1]);
  level.br_level.br_mapboundsfull = [];
  level.br_level.br_mapboundsfull[0] = (_id_C978C90E8E5AB1F7, _id_C978C80E8E5AAFC4, 0);
  level.br_level.br_mapboundsfull[1] = (_id_3C590D0EE220B409, _id_3C590C0EE220B1D6, 0);
  _id_3C590D0EE220B409 = level.br_level.br_corners[0][0] * 0.8;
  _id_C978C90E8E5AB1F7 = level.br_level.br_corners[1][0] * 0.8;
  _id_3C590C0EE220B1D6 = level.br_level.br_corners[1][0] * 0.8;
  _id_C978C80E8E5AAFC4 = level.br_level.br_corners[1][1] * 0.8;
  level.br_level.br_mapbounds = [];
  level.br_level.br_mapbounds[0] = (_id_C978C90E8E5AB1F7, _id_C978C80E8E5AAFC4, 0);
  level.br_level.br_mapbounds[1] = (_id_3C590D0EE220B409, _id_3C590C0EE220B1D6, 0);
  level.br_level.br_mapcenter = ((_id_3C590D0EE220B409 + _id_C978C90E8E5AB1F7) / 2, (_id_3C590C0EE220B1D6 + _id_C978C80E8E5AAFC4) / 2, 0);
  level.br_level.br_mapsize = (abs(_id_C978C90E8E5AB1F7 - _id_3C590D0EE220B409), abs(_id_C978C80E8E5AAFC4 - _id_3C590C0EE220B1D6), abs(level.br_level.c130_heightoverride - level.br_level.c130_sealeveloverride));

  if(getdvarint("scr_br_alt_mode_nonstop", 0)) {
    level.br_level.br_circleclosetimes = [360, 270, 225, 135, 90, 60, 45, 90];
    level.br_level.br_circledelaytimes = [60, 0, 0, 0, 0, 0, 0, 0];
    level.br_level.br_circleshowdelaydanger = [60, 0, 0, 0, 0, 0, 0, 0];
  } else if(getdvarint("scr_br_alt_mode_rlh", 0)) {
    level.br_level.br_circleclosetimes = [270, 150, 120, 90, 60, 45, 45, 90];
    level.br_level.br_circledelaytimes = [60, 10, 10, 10, 10, 10, 10, 0];
    level.br_level.br_circleshowdelaydanger = [60, 0, 0, 0, 0, 0, 0, 0];
  } else if(scripts\mp\utility\game::getsubgametype() == "mini" || scripts\mp\utility\game::getsubgametype() == "mini_mgl") {
    level.br_level.br_circleclosetimes = [1, 200, 130, 90, 50, 100];
    level.br_level.br_circledelaytimes = [1, 120, 75, 60, 45, 0];
    level.br_level.br_circleshowdelaydanger = [1, 0, 0, 0, 0, 0];
  } else if(scripts\mp\utility\game::getsubgametype() == "rebirth") {
    level.br_level.br_circleclosetimes = [90, 45, 45, 45, 105];
    level.br_level.br_circledelaytimes = [120, 90, 60, 60, 0];
    level.br_level.br_circleshowdelaydanger = [120, 0, 0, 0, 0];
  } else if(scripts\mp\utility\game::getsubgametype() == "vanilla") {
    level.br_level.br_circleclosetimes = [90, 60, 60, 30, 100];
    level.br_level.br_circledelaytimes = [75, 60, 60, 60, 30];
    level.br_level.br_circleshowdelaydanger = [75, 0, 0, 0, 0];
  } else {
    level.br_level.br_circleclosetimes = [135, 110, 85, 55, 35, 25, 25, 50];
    level.br_level.br_circledelaytimes = [110, 45, 37, 30, 30, 22, 15, 0];
    level.br_level.br_circleshowdelaydanger = [20, 0, 0, 0, 0, 0, 0, 0];
  }

  if(scripts\mp\utility\game::getsubgametype() == "mini" || scripts\mp\utility\game::getsubgametype() == "mini_mgl") {
    level.br_level.br_circleshowdelaysafe = [0, 0, 0, 0, 0, 0];
    level.br_level.br_circleminimapradii = [10500, 10500, 10500, 9000, 8000, 5500];
    _id_5068E43680808E5B = getdvarint("dvar_E84CE12F7A01A55A", 0);

    if(_id_5068E43680808E5B == 1)
      level.br_level.br_circleradii = [75000, 45000, 20000, 7000, 3500, 1500, 0];
    else
      level.br_level.br_circleradii = [60000, 30000, 15000, 7000, 3500, 1500, 0];
  } else if(scripts\mp\utility\game::getsubgametype() == "rebirth") {
    level.br_level.br_circleshowdelaysafe = [0, 0, 0, 0, 0];
    level.br_level.br_circleminimapradii = [10500, 10500, 10500, 9000, 5500];
    level.br_level.br_circleradii = [12000, 10000, 8000, 5000, 1500, 0];
  } else if(scripts\mp\utility\game::getsubgametype() == "vanilla") {
    level.br_level.br_circleshowdelaysafe = [0, 0, 0, 0, 0];
    level.br_level.br_circleminimapradii = [7500, 6500, 5500, 5000, 4500];
    level.br_level.br_circleradii = [16000, 11000, 7500, 4000, 1500, 0];
  } else {
    level.br_level.br_circleshowdelaysafe = [0, 0, 0, 0, 0, 0, 0, 0];
    level.br_level.br_circleminimapradii = [10500, 10500, 10500, 10500, 10500, 9000, 8000, 5500];
    level.br_level.br_circleradii = [9600, 5300, 2500, 1200, 800, 500, 200, 50, 0];
  }

  if(isDefined(level.br_circle_init_func))
    [[level.br_circle_init_func]]();

  _id_2695A20D4011076D::applycirclesettings();
  level.br_prematchspawnlocations = [_id_1E4A61DB11011446::createspawnlocation((-1261, -10218.5, 519.66), 0, 500), _id_1E4A61DB11011446::createspawnlocation((301.573, -6134.04, 692.001), 0, 500), _id_1E4A61DB11011446::createspawnlocation((-3932.99, -2860.85, 622.534), 0, 500), _id_1E4A61DB11011446::createspawnlocation((3565.82, -6494.82, 497.727), 0, 500), _id_1E4A61DB11011446::createspawnlocation((2784.2, -1387.21, 839.998), 0, 500)];
  level.br_badcircleareas = [_id_2695A20D4011076D::createinvalidcirclearea((-18691, 12376, 200), 15000), _id_2695A20D4011076D::createinvalidcirclearea((-19459, -12712, 200), 15000), _id_2695A20D4011076D::createinvalidcirclearea((19261, -12712, 200), 15000), _id_2695A20D4011076D::createinvalidcirclearea((18493, 12376, 200), 15000), _id_2695A20D4011076D::createinvalidcirclearea((-707, 20888, 200), 8000), _id_2695A20D4011076D::createinvalidcirclearea((-707, -22632, 200), 8000), _id_2695A20D4011076D::createinvalidcirclearea((5255, -15805, 200), 4500), _id_2695A20D4011076D::createinvalidcirclearea((8323, -9836, 200), 4500), _id_2695A20D4011076D::createinvalidcirclearea((8642, 3052, 200), 4500), _id_2695A20D4011076D::createinvalidcirclearea((7015, 9413, 200), 4500), _id_2695A20D4011076D::createinvalidcirclearea((4349, 13144, 200), 4500), _id_2695A20D4011076D::createinvalidcirclearea((-7087, 13998, 200), 4500), _id_2695A20D4011076D::createinvalidcirclearea((-8292, 8684, 200), 4500), _id_2695A20D4011076D::createinvalidcirclearea((-9920, 2816, 200), 4500), _id_2695A20D4011076D::createinvalidcirclearea((-8292, 8684, 200), 4500), _id_2695A20D4011076D::createinvalidcirclearea((-9088, -5312, 200), 4500), _id_2695A20D4011076D::createinvalidcirclearea((-7424, -12800, 200), 4500), _id_2695A20D4011076D::createinvalidcirclearea((-1600, -17344, 200), 4500), _id_2695A20D4011076D::createinvalidcirclearea((9923, -2860, 200), 4500), _id_2695A20D4011076D::createinvalidcirclearea((-1859, 16600, 200), 4500), _id_2695A20D4011076D::createinvalidcirclearea((2388, -11256, 200), 2400), _id_2695A20D4011076D::createinvalidcirclearea((-4140, -8184, 200), 2000), _id_2695A20D4011076D::createinvalidcirclearea((-6085, 2857, 200), 1100), _id_2695A20D4011076D::createinvalidcirclearea((-92, 12848, 200), 1100), _id_2695A20D4011076D::createinvalidcirclearea((-4582, 10069, 200), 1100), _id_2695A20D4011076D::createinvalidcirclearea((4957, 4374, 200), 1100), _id_2695A20D4011076D::createinvalidcirclearea((4579, 6143, 200), 1100), _id_2695A20D4011076D::createinvalidcirclearea((-6700, -824, 200), 1100), _id_2695A20D4011076D::createinvalidcirclearea((-3820, -9656, 200), 1100), _id_2695A20D4011076D::createinvalidcirclearea((1556, -13880, 200), 1100)];
  setDvar("br_max_armory_kiosk", 10);
}
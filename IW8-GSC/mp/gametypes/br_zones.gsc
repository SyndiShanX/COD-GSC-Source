/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_zones.gsc
***********************************************/

init() {
  level.deployingplayer = spawnStruct();
  level.deployingplayer.types = [];
  targetsite("_encstr_8DB007073616ECAE95", 1, ::_id_1471A, ::_id_1471D, ::_id_14715, ::_id_14716, ::_id_1239D, ::_id_1471C);
  targetsshot("_encstr_8DB007073616ECAE95", 1, 9, 0);
  level.deployingplayer.zones = [];
  level.deployingplayer._id_11E66 = 0;
  thread swaphelifordrivable("_encstr_93011D6FB8EBF78A5518A2DD7F17B39516D8A79310A60C824F2FAB9450DD2B", "_encstr_B40101", "_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
}

targetsite(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = spawnStruct();
  var_8.name = var_0;
  var_8.set_just_keep_moving = var_1;
  var_8.testing_linked_anims = var_2;
  var_8._id_13386 = var_3;
  var_8.nuke_vault_oil_puddle_watch = var_4;
  var_8.onpostkillcamcallback = var_5;
  var_8.play_loop_nagging_hostage_on_convoy = var_6;
  var_8._id_11DA4 = var_7;
  var_8._id_13C00 = [];
  level.deployingplayer.types[var_0] = var_8;
}

targetsshot(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.color = var_1;
  var_4.icon = var_2;
  var_4.style = var_3;
  level.deployingplayer.types[var_0].mapcircle = var_4;
}

register_module_died_poorly_func(var_0) {
  return level.deployingplayer.zones[var_0];
}

_id_135FC(var_0, var_1, var_2) {
  if(!isDefined(level.deployingplayer.types[var_0])) {
    return;
  }
  var_3 = level.deployingplayer.types[var_0];
  var_4 = spawnStruct();
  var_4.type = var_0;
  var_4._id_13C00 = [];
  var_4.moving = 0;
  var_5 = (var_1[0], var_1[1], var_2);

  if(isDefined(var_3.mapcircle)) {
    var_6 = var_3.mapcircle.color;
    var_7 = var_3.mapcircle.icon;
    var_8 = var_3.mapcircle.style;
    var_4 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::init_tactical_boxes(var_6, var_7, var_8, var_5);
    var_4.mapcircle show();
  } else
    var_4 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::init_tactical_boxes(0, 0, 0, var_5);

  var_4.id = "_encstr_A1FB0622771BA13F" + level.deployingplayer._id_11E66;
  level.deployingplayer._id_11E66++;
  var_4 thread[[var_3.testing_linked_anims]]();
  level.deployingplayer.zones[var_4.id] = var_4;
  var_4 _id_135FD(var_1, var_2);
  return var_4.id;
}

_id_135FD(var_0, var_1) {
  if(isDefined(self.trigger))
    self.trigger delete();

  self.trigger = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (var_0[0], var_0[1], -2000), 0, int(var_1), 12000);
  thread _id_1471F();
}

_id_14714() {
  var_0 = level.deployingplayer.types[self.type];
  self thread[[var_0._id_13386]]();
  self.trigger delete();
  self.mapcircle delete();
  self notify("_encstr_A25F0710622DF3B3D7");
  level.deployingplayer.zones[self.id] = undefined;
}

_id_1471F() {
  self.trigger endon("_encstr_AD75063D571AE108");
  var_0 = level.deployingplayer.types[self.type];

  for(;;) {
    self.trigger waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }
    if(self.moving) {
      var_2 = _id_14718();
      var_3 = _id_14719();
      var_3 = var_3 * var_3;

      if(distance2dsquared(var_1.origin, var_2) > var_3)
        continue;
    }

    if(isDefined(var_0.play_loop_nagging_hostage_on_convoy) && [[var_0.play_loop_nagging_hostage_on_convoy]](var_1)) {
      continue;
    }
    var_4 = var_1.guid;

    if(!isDefined(self._id_13C00[var_4])) {
      var_5 = spawnStruct();
      var_5.player = var_1;
      var_5.start = gettime();
      var_6 = 0;

      if(var_0.set_just_keep_moving) {
        self._id_13C00[var_4] = spawnStruct();

        if(!isDefined(var_0._id_13C00[var_4])) {
          var_5._id_12AC2 = 0;
          var_0._id_13C00[var_4] = var_5;
          var_6 = 1;
        }

        var_0._id_13C00[var_4]._id_12AC2++;
      } else {
        if(!isDefined(var_0._id_13C00[var_4]))
          var_0._id_13C00[var_4] = 0;

        var_0._id_13C00[var_4]++;
        self._id_13C00[var_4] = var_5;
        var_6 = 1;
      }

      if(var_6)
        self thread[[var_0.nuke_vault_oil_puddle_watch]](var_5);
    }

    thread applyprematchplotarmor(var_4);
  }
}

applyprematchplotarmor(var_0) {
  var_1 = self._id_13C00[var_0];
  var_1 notify("_encstr_87A40DCB88304752E316E1677B831B");
  var_1 endon("_encstr_87A40DCB88304752E316E1677B831B");
  waitframe();
  waittillframeend;
  var_2 = level.deployingplayer.types[self.type];
  self._id_13C00[var_0] = undefined;
  var_3 = 0;

  if(var_2.set_just_keep_moving) {
    var_2._id_13C00[var_0]._id_12AC2--;

    if(!var_2._id_13C00[var_0]._id_12AC2) {
      var_1 = var_2._id_13C00[var_0];
      var_2._id_13C00[var_0] = undefined;
      var_3 = 1;
    }
  } else {
    var_2._id_13C00[var_0]--;

    if(!var_2._id_13C00[var_0])
      var_2._id_13C00[var_0] = undefined;

    var_3 = 1;
  }

  if(var_3)
    self thread[[var_2.onpostkillcamcallback]](var_1);
}

_id_1471B(var_0, var_1, var_2) {
  self notify("_encstr_ACA20538F84D39");
  self endon("_encstr_ACA20538F84D39");
  self endon("_encstr_A25F0710622DF3B3D7");
  var_3 = _id_14718();

  if(!isDefined(var_0))
    var_0 = var_3;

  var_4 = _id_14719();

  if(!isDefined(var_1))
    var_1 = var_4;

  if(!isDefined(var_2))
    var_2 = 0;

  var_5 = level.deployingplayer.types[self.type];

  if(isDefined(var_5._id_11DA4))
    self thread[[var_5._id_11DA4]](var_0, var_1, var_2);

  var_6 = var_3 != var_0 || var_4 != var_1;

  if(var_6) {
    var_7 = (var_0[0], var_0[1], var_1);

    if(var_2 <= 0)
      self.mapcircle.origin = var_7 _id_135FD(var_0, var_1);
    else {
      self.moving = 1;

      if(var_4 < var_1)
        _id_135FD(var_0, var_1);

      self.mapcircle moveTo(var_7, var_2);
      childthread applymovingcircles();
      wait(var_2);

      if(var_4 > var_1)
        _id_135FD(var_0, var_1);
    }
  } else {}

  self.moving = 0;
}

applymovingcircles() {
  self.trigger endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0 = _id_14718();
    self.trigger.origin = (var_0[0], var_0[1], -2000);
    waitframe();
  }
}

_id_14718() {
  return (self.mapcircle.origin[0], self.mapcircle.origin[1], 0);
}

_id_14719() {
  return self.mapcircle.origin[2];
}

offlight(var_0) {
  return var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal();
}

og_mbradial(var_0) {
  return var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3();
}

_id_1471A() {
  var_0 = loadfx("_encstr_8EE73B238A0B70A803E06F0DB27D902F27D27BE842A7B81BDD823D2BD893A0E0834A1813DA7BD848F57A0553E07BE8B85BE26E3B234F86A08A7F8BD113");
  self._id_1239C = spawnfx(var_0, _id_14718());
  self._id_1239C unmarkkeyframedmover(1);
  triggerfx(self._id_1239C);
}

_id_1471D() {
  if(isDefined(self._id_1239C))
    self._id_1239C delete();
}

_id_14715(var_0) {
  if(!var_0.player _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3()) {
    var_0.player scripts\cp_mp\utility\game_utility::_visionsetnakedforplayer("_encstr_A5D90FD61CD746DB73997D83B158ECAEB2", 0.5);
    thread _id_14721(var_0);
    thread _id_14722(var_0);
  }

  var_0.player setscriptablepartstate("_encstr_8EED0C21ACE6800D2759EA70721F", "_encstr_99BF0603D0C4979A");
}

_id_14721(var_0) {
  var_1 = getdvarint("_encstr_B1C31B9B1BE47D2639FA9EED37AC37BEC1360BD9EA2BEBC885B5589DAC", 3);
  var_2 = getdvarfloat("_encstr_BA9F26CDB19CBE4C27D7D3BDB9ACCDFAC1C6C23BEACA7D9A57CED9BE8C58AD0B76B2BEB9B10B8D56", 7.0);
  var_3 = getdvarfloat("_encstr_A70920FF7B8AE93EC3F1B2180A776E31A2DC635FF537A175B7CA290182C7A6887B2D", 2);
  var_4 = getdvarint("_encstr_83A21A9B36E4AF4C93FAD3DBB9CAB9FAE0632C76572BAFD8ED5DECA1", 0);
  var_0 endon("_encstr_A6A81247A38F2757D237BA3F2AC72390BA7353A7");
  var_0.player endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    var_5 = var_0.player;

    if(!istrue(var_5.start_death_from_above_sequence)) {
      if(scripts\cp_mp\gasmask::hasgasmask(var_5))
        var_5 scripts\cp_mp\gasmask::processdamage(var_1);
      else {
        var_6 = var_1;

        if(isDefined(level._id_11C95))
          var_6 = var_5[[level._id_11C95]](var_6);

        if(var_5 scripts\mp\utility\killstreak::isjuggernaut())
          var_6 = int(var_6 * var_2);

        var_5 dodamage(var_6, var_5.origin, var_5, undefined, "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3", "_encstr_BA1211895E6630BD3367E7FBFB0A71783FF633");

        if(var_5 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::hasarmor())
          var_5 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::damagearmor(var_6);

        if(var_4)
          var_5 _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::_id_13E18();
      }
    }

    wait(var_3);
  }
}

_id_14722(var_0) {
  var_0 endon("_encstr_A6A81247A38F2757D237BA3F2AC72390BA7353A7");
  var_0.player endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    if(scripts\cp_mp\gasmask::hasgasmask(var_0.player))
      var_0.player _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::plunderrepositoryref("_encstr_8EED0C21ACE6800D2759EA70721F");

    wait 1;
  }
}

_id_14716(var_0) {
  var_0 notify("_encstr_A6A81247A38F2757D237BA3F2AC72390BA7353A7");

  if(!isDefined(var_0.player)) {
    return;
  }
  var_0.player setscriptablepartstate("_encstr_8EED0C21ACE6800D2759EA70721F", "_encstr_A760055987D2E8");

  if(!var_0.player _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3()) {
    if(scripts\cp_mp\gasmask::hasgasmask(var_0.player))
      var_0.player _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::plunderrankupdate("_encstr_8EED0C21ACE6800D2759EA70721F");

    var_0.player scripts\cp_mp\utility\game_utility::_visionsetnakedforplayer("_encstr_B40101", 0.5);
  }
}

_id_1471C(var_0, var_1, var_2) {}

swaphelifordrivable(var_0, var_1, var_2) {
  var_3 = getDvar(var_0, var_1);

  if(var_3 == "_encstr_B40101") {
    return;
  }
  waittillframeend;

  if(isDefined(var_2))
    scripts\mp\flags::gameflagwait(var_2);

  var_4 = getdvarint("_encstr_A67E21DFBFDB592E031FEFD061470B10A755608A683959704AC19393CABE8B41AA61B8", -1);
  var_5 = strtok(var_3, "_encstr_964C0249");

  if(var_4 < 0)
    var_4 = var_5.size;
  else {
    var_4 = min(var_4, var_5.size);
    var_5 = scripts\engine\utility::array_randomize(var_5);
  }

  for(var_6 = 0; var_6 < var_4; var_6++) {
    var_7 = var_5[var_6];
    swap_access_card(var_7);
    thread _id_12DF0(var_7);
  }
}

_id_12DF0(var_0) {
  var_1 = level.deployingplayer._id_11E27[var_0];

  if(!isDefined(var_1)) {
    return;
  }
  if(var_1.ks_circlemoving > var_1.ks_circlemovedist)
    var_2 = randomfloatrange(var_1.ks_circlemovedist, var_1.ks_circlemoving);
  else
    var_2 = var_1.ks_circlemovedist;

  wait(var_2);

  if(var_1.set_mark_distances > 0) {
    var_3 = _id_135FC("_encstr_8DB007073616ECAE95", var_1.origin, 50);
    var_4 = register_module_died_poorly_func(var_3);
    var_4 thread _id_1471B(undefined, var_1.radius, var_1.set_mark_distances);
  } else
    var_3 = _id_135FC("_encstr_8DB007073616ECAE95", var_1.origin, var_1.radius);

  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  var_4 = register_module_died_poorly_func(var_3);

  if(isDefined(var_4))
    var_4 _id_14714();
}

swap_access_card(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.deployingplayer._id_11E27))
    level.deployingplayer._id_11E27 = [];

  if(isDefined(level.deployingplayer._id_11E27[var_0])) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  if(!isDefined(var_2))
    var_2 = -1;

  if(!isDefined(var_3))
    var_3 = 0;

  if(!isDefined(var_4))
    var_4 = 0;

  if(!isDefined(var_5))
    var_5 = 0;

  switch (var_0) {
    case "_encstr_971804ED3712":
      [var_1, var_2, var_3, var_4, var_5] = [(-21543, 47479, 0), 10000, 75, 5, 10];
      break;
    case "_encstr_A77808BB284B9F27D3C1":
      [var_1, var_2, var_3, var_4, var_5] = [(28696, 2288, 0), 10000, 75, 5, 10];
      break;
    case "_encstr_883E0978CAE2A1689B3161":
      [var_1, var_2, var_3, var_4, var_5] = [(9443, -11877, 0), 10000, 75, 5, 10];
      break;
    case "_encstr_A518056F42E350":
      [var_1, var_2, var_3, var_4, var_5] = [(38750, -43340, 0), 10000, 75, 5, 10];
      break;
    case "_encstr_9707038E3B":
      [var_1, var_2, var_3, var_4, var_5] = [(15258, 17988, 0), 10000, 75, 5, 10];
      break;
    case "_encstr_BEB406F03B72BB3B":
      [var_1, var_2, var_3, var_4, var_5] = [(-13027, 9242, 0), 10000, 75, 5, 10];
      break;
    case "_encstr_9B220634456A5747":
      [var_1, var_2, var_3, var_4, var_5] = [(51158, -38213, 0), 10000, 75, 5, 10];
      break;
    case "_encstr_B49507136BBF0EA070":
      [var_1, var_2, var_3, var_4, var_5] = [(34267, 43134, 0), 10000, 75, 5, 10];
      break;
    case "_encstr_A12309057F2275CBB14A51":
      [var_1, var_2, var_3, var_4, var_5] = [(-27531, -10899, 0), 10000, 75, 5, 10];
      break;
    case "_encstr_9A9B055B63DD14":
      [var_1, var_2, var_3, var_4, var_5] = [(21767, -19846, 0), 10000, 75, 5, 10];
      break;
    default:
      break;
  }

  var_16 = spawnStruct();
  var_17 = "_encstr_8EA214CB926B30880ACF695919B7C8E5379BC0D05A87" + var_0 + "_encstr_BA4C02DF";
  var_16.origin = getdvarvector(var_17 + "_encstr_97FE07DE392D76D2CD", var_1);
  var_16.radius = getdvarfloat(var_17 + "_encstr_8D4607ABF0ABE4FB47", var_2) * getdvarfloat("_encstr_85FF205636CB57A992A750A847DF036B6118C0500FB1D5316C577058D7E3199BFA47", 1.0);
  var_16.set_mark_distances = getdvarfloat(var_17 + "_encstr_ADAD0AAF1285E0F883DAE891", var_3) * getdvarfloat("_encstr_881D2337B139AF3193F5C1B1B0EC5DCABED3F6B959AF76E47BBBEBD12DB5CAD7CD1B0B1B95", 1.0);
  var_16.ks_circlemovedist = getdvarfloat(var_17 + "_encstr_96750613A808E91B", var_4) * getdvarfloat("_encstr_8C801F3FE8BBA7DAE5A8120DAFE76325A688D7C3A076D492015F58C98E977AE409", 1.0);
  var_16.ks_circlemoving = getdvarfloat(var_17 + "_encstr_A59A0AB1672C48FBB9E79B91", var_5) * getdvarfloat("_encstr_A3B22382EE85910A2389BB338079D5FA07FA0D7D45B75A55C85097F7C891A001F79E16753D", 1.0);

  if(var_16.radius < 0) {
    return;
  }
  level.deployingplayer._id_11E27[var_0] = var_16;
}

_id_1239D(var_0) {
  return offlight(var_0);
}

updatelocationbesttimehud(var_0, var_1) {
  if(!isDefined(level.deployingplayer) || !isDefined(level.deployingplayer.zones) || !isDefined(level.deployingplayer.types[var_0]))
    return 0;

  return isDefined(level.deployingplayer.types[var_0]._id_13C00[var_1.guid]);
}
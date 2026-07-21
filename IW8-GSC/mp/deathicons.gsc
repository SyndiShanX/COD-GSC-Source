/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\deathicons.gsc
***********************************************/

init() {}

adddeathicon(var_0, var_1, var_2, var_3, var_4) {
  var_2 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(istrue(var_2._id_133CB)) {
    return;
  }
  if(!level.teambased) {
    return;
  }
  if(getDvar("_encstr_876C16B3FFA96BC80CB91B705DE7B815A21301337FF220B0") == "_encstr_934C0218") {
    return;
  }
  if(level.hardcoremode) {
    return;
  }
  if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    return;
  }
  if(istrue(var_2 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag())) {
    return;
  }
  var_5 = scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB";
  var_6 = scripts\mp\utility\game::getgametype() == "_encstr_931D068662634370";
  var_7 = var_0 scripts\mp\utility\perk::_hasperk("_encstr_9BE11576794291812199EB1AC7CE893B61FEEBF084616D");

  if(!var_5 && var_7) {
    return;
  }
  var_8 = var_1.origin;
  var_8 = var_8 + (0, 0, 40);
  var_2 notify("_encstr_83F60F168C2311AC8547344A6CF6E65025");
  var_2 endon("_encstr_83F60F168C2311AC8547344A6CF6E65025");

  if(isDefined(var_2.waittill_usebutton_released_or_time_or_bomb_planted)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_2.waittill_usebutton_released_or_time_or_bomb_planted);
    var_2.waittill_usebutton_released_or_time_or_bomb_planted = undefined;
  }

  var_2 notify("_encstr_A24D138D9D1977833BCBFE19A728631B21703F1080");
  var_9 = "_encstr_B4291521350731F336881D1031EF0693D3CF806BD7933D";
  var_10 = var_3;

  if(var_5) {
    var_11 = scripts\engine\utility::ter_op(isDefined(var_2.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"]), var_2.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"], 0);
    var_9 = "_encstr_87B6160D5374E9A32A9FF58FAB12FFF868A18B18FEC1E0E6" + var_11;

    if(var_7)
      var_10 = [var_2];
    else if(scripts\mp\menus::brking_updateteamscore())
      var_10 = level.squaddata[var_3][var_2.squadindex].players;
    else
      var_10 = scripts\mp\utility\teams::getteamdata(var_2.team, "_encstr_9775086022BE1B413B8B");
  } else if(var_6) {
    if(var_7)
      var_10 = [var_2];
    else
      var_10 = scripts\mp\utility\teams::getteamdata(var_2.team, "_encstr_9775086022BE1B413B8B");
  }

  var_12 = var_2.origin;
  var_13 = var_5;
  var_14 = var_5;
  var_2.waittill_usebutton_released_or_time_or_bomb_planted = var_2 scripts\cp_mp\entityheadicons::setheadicon_singleimage(var_10, var_9, undefined, 1, 0, 0, undefined, undefined, var_13, var_12, var_14);

  if(isDefined(var_2.waittill_usebutton_released_or_time_or_bomb_planted)) {
    if(var_5 || var_6)
      var_2 thread setupminimapmaze(var_7);
    else
      var_2 thread destroyslowly(var_4);
  }
}

setupminimapmaze(var_0) {
  self endon("_encstr_A24D138D9D1977833BCBFE19A728631B21703F1080");
  var_1 = self.team;
  var_2 = self.waittill_usebutton_released_or_time_or_bomb_planted;

  if(!var_0)
    setup_train_entarray_composite(var_2, var_1);

  if(isDefined(self))
    setupdamage();

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_2);

  if(isDefined(self))
    self.waittill_usebutton_released_or_time_or_bomb_planted = undefined;
}

setup_train_entarray_composite(var_0, var_1) {
  var_2 = getdvarfloat("_encstr_AF941D3995B648D39F4AB92022C79588CEE5A3AB2C1FC92DDFD3F14B3A2F40", 10.0);
  var_3 = getdvarfloat("_encstr_8D5324C2B75F43D051B339302D1FDB38531AAFDB9253A93F48339BA3F348A508690ADD1D4BF7", 0.0);
  wait(var_2);
  var_4 = scripts\mp\utility\teams::getfriendlyplayers(var_1);

  foreach(var_6 in var_4) {
    if(!isDefined(var_6)) {
      continue;
    }
    if(var_3 > 0) {
      if(isDefined(self.squadindex) && isDefined(var_6.squadindex) && self.squadindex == var_6.squadindex)
        continue;
    }

    if(isDefined(self) && var_6 == self) {
      continue;
    }
    scripts\cp_mp\entityheadicons::_id_1315E(var_0, var_6);
  }

  if(var_3 > 0) {
    wait(var_3);
    var_4 = scripts\mp\utility\teams::getfriendlyplayers(var_1);

    foreach(var_6 in var_4) {
      if(!isDefined(var_6)) {
        continue;
      }
      if(isDefined(self.squadindex) && isDefined(var_6.squadindex) && self.squadindex != var_6.squadindex) {
        continue;
      }
      if(isDefined(self) && var_6 == self) {
        continue;
      }
      scripts\cp_mp\entityheadicons::_id_1315E(var_0, var_6);
    }
  }
}

setupdamage() {
  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag()) {
    var_0 = getdvarfloat("_encstr_861B1A2395B0D134BED26CDE37BE7BDD735639FAC85D39C28E96DBDC", 15.0);

    if(!scripts\mp\utility\player::isreallyalive(self))
      self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
    else {
      var_1 = gettime() - self.lastspawntime;
      var_0 = var_0 - var_1 / 1000;
    }

    if(var_0 > 0)
      wait(var_0);
  }
}

destroyslowly(var_0) {
  self endon("_encstr_A24D138D9D1977833BCBFE19A728631B21703F1080");
  var_1 = self;
  var_2 = self.waittill_usebutton_released_or_time_or_bomb_planted;
  wait(var_0);
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_2);

  if(isDefined(var_1))
    var_1.waittill_usebutton_released_or_time_or_bomb_planted = undefined;
}

spawn_carriables_from_prefabs_all(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.waittill_usebutton_released_or_time_or_bomb_planted)) {
    return;
  }
  scripts\cp_mp\entityheadicons::_id_1315E(var_0.waittill_usebutton_released_or_time_or_bomb_planted, var_0);
}

_id_12C01(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.waittill_usebutton_released_or_time_or_bomb_planted)) {
    return;
  }
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_0.waittill_usebutton_released_or_time_or_bomb_planted);
  var_0.waittill_usebutton_released_or_time_or_bomb_planted = undefined;
  var_0 notify("_encstr_A24D138D9D1977833BCBFE19A728631B21703F1080");
}

_id_12BFD() {
  foreach(var_1 in level.players)
  _id_12C01(var_1);
}

addenemydeathicon(var_0, var_1, var_2, var_3, var_4) {
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!level.teambased) {
    return;
  }
  if(istrue(var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag())) {
    return;
  }
  var_5 = var_0.origin;
  var_5 = var_5 + (0, 0, 40);
  var_1 notify("_encstr_83F60F168C2311AC8547344A6CF6E65025");
  var_1 endon("_encstr_83F60F168C2311AC8547344A6CF6E65025");

  if(!var_4) {
    if(getDvar("_encstr_876C16B3FFA96BC80CB91B705DE7B815A21301337FF220B0") == "_encstr_934C0218") {
      return;
    }
    if(level.hardcoremode)
      return;
  }

  if(isDefined(var_1.waittill_vo_plays)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_1.waittill_vo_plays);
    var_1.waittill_vo_plays = undefined;
  }

  var_1 notify("_encstr_81FF193D4F0A68508DF71E519D75709BC1D39BA3A30238E0A30D20");

  if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    var_6 = "_encstr_8C861718D5E117FAAB5092DAD8E3F983B9B79CB7E569378359";
    var_7 = 0;
    var_8 = 768;
    var_9 = 10;
  } else {
    var_6 = "_encstr_BE8E1C642D8A30DB9238AE410781D903124FE2BF80CBA72371A860112BAA";
    var_7 = 1;
    var_8 = 768;
    var_9 = 0;
  }

  var_10 = var_1.origin;
  var_1.waittill_vo_plays = var_1 scripts\cp_mp\entityheadicons::setheadicon_singleimage(var_2, var_6, undefined, var_7, var_8, var_9, undefined, undefined, undefined, var_10);

  if(isDefined(var_1.waittill_vo_plays))
    var_1 thread destroyenemyiconslowly(var_3);
}

destroyenemyiconslowly(var_0) {
  self endon("_encstr_81FF193D4F0A68508DF71E519D75709BC1D39BA3A30238E0A30D20");
  var_1 = self;
  var_2 = self.waittill_vo_plays;
  wait(var_0);
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_2);

  if(isDefined(var_1))
    var_1.waittill_vo_plays = undefined;
}
/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_gametype_juggernaut.gsc
***************************************************/

init() {
  level thread disablepersupdates();
  level thread disableplayerkillrewards();
  level thread disableonemilannounce();
  level thread disablepersonalnuke();
}

disablepersupdates() {
  if(getdvarint("_encstr_93A611EA59A06F0A1EF5CF8FC750B28DC86367", 0) == 1) {
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_A78F076CA54E1B1B56");
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_9B220634456A5747");
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_BDC6085DF29A892901C7");
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_BA32084FFD08358F1C99");
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::move_molotov_mortar("_encstr_B603110FA57A675BFC2FA3B0BBE750AD32CAFE");
  }

  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_ADF20D88BB7DC8C9AA6A4653C3822F");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::move_molotov_mortar("_encstr_8CE50ED185C48D59A325B238360B36AC");
}

disableplayerkillrewards() {
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8A38163B98D17952EDA44F0596EFEA2D3FE0C30708A8DDFB", ::disableteamkillrewards);
  waittillframeend;
  scripts\mp\flags::gameflaginit("_encstr_978814C3EB2F9EA349F27B47E7A148EDE3D2FB8933E7", 0);
  level.ontimelimit = ::disabletargetmarkergroups;
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_AC5F143F5D5A2B1F4805FA06DB6001021DCBD37F0165", ::disablespawncamera);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8CBF0F507D400B31BFDF58C86BD50F7FDA", ::disablespawningforplayerfunc);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_A64913C0B57A98844A4FAD938B324D50FB8BEB5898", ::disablespawningforplayer);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_97F512C8522453515F8CF66090D73889570A8878", ::disablelootbunkercachelocations);
  disablefeature();
  level._id_140D9 = [];
  level._id_140D9[0] = "_encstr_92A40EF9E31F7F501AA96573DCC4E8B0";
  level._id_140D9[1] = "_encstr_A1580B19DE5B5A9B0BA35AEDCD";
  level._id_140D9[2] = "_encstr_AF460A7B2649F34FE367455D";
  level._id_1385F = 0;
  level thread disableplayerrewards();
}

disableonemilannounce() {
  wait 1;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_827F0CA01ADBB640298B192B92CB"] = "_encstr_A9491A760B5BB2D1CB38CAF5A9EA7676B29CCDC2AEA3937B970BD895";
}

disablefeature() {
  scripts\cp_mp\utility\game_utility::_id_12C10("_encstr_A7EE0FE3BB593A1C48B68DD5AE585F3225", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\cp_mp\utility\game_utility::_id_12C11("_encstr_920D1AA7081FE397C3407F2F90385F3AD3112D91E1A33BF12841672B", 1);
  scripts\cp_mp\utility\game_utility::_id_12C11("_encstr_B49F18FD153A2D2EB707C88837F6666162FDE571E1F2F116D816", 1);
  scripts\cp_mp\utility\game_utility::_id_12C11("_encstr_99291CC83F37405922F7696D37AA17D09F5630E22963800E1AF7912F6AD7", 1);
}

disablepersonalnuke() {}

disableteamkillrewards(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  wait 1;
  scripts\mp\hud_message::showsplash("_encstr_95AE289827BEB3B0D62B8EBC0E567DA9573B3B2BC9DC2CEA8EEB38C92BD6588E8D86D7DD5663B1B7D656");

  if(!istrue(level.br_infils_disabled)) {
    self waittill("_encstr_8F7D08C66A0125438523");

    while(!self isonground())
      waitframe();
  } else
    level waittill("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::detachriotshield(self);
  wait 1;
  scripts\mp\hud_message::showsplash("_encstr_8E5B1F31E4EB3B856B2BA3F21C2BD735EA76D959939BC2EA1DBEEEACD81BBDD695");
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_8EA412AB830729900AE9375F1AF448E69BAAE3B1", self, 0);
}

disabletargetmarkergroups() {
  if(isDefined(level.numendgame))
    level thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::startendgame(1);

  level.numendgame = undefined;
}

disableplayerrewards() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid()) {
    return;
  }
  level waittill("_encstr_A64211C4E4D70E4E2BB5B0D1C643549B325623");
  level thread display_already_have_weapon_message();
  level thread display_current_cypher_to_player();
  var_0 = 1;

  for(;;) {
    var_1 = getdvarint("_encstr_A39B13FFD7C2B988EB1110ABC84A3FB7375BF12D52", 1);

    if(!var_1) {
      waitframe();
      continue;
    }

    var_2 = _encstr_AB9028F6A91A7BB7236095EDABB080C8900FED03A169B3BE2233379AFBD114EFC608405D7BE54D49236E::resetafkchecks();

    if(level._id_11F2C > 0)
      var_2 = var_2 - level._id_11F2C;

    level.vehicle_isneutraltoplayer = scripts\engine\utility::array_randomize(level.vehicle_isneutraltoplayer);
    var_3 = _encstr_AB9028F6A91A7BB7236095EDABB080C8900FED03A169B3BE2233379AFBD114EFC608405D7BE54D49236E::_id_1334B(var_2, var_0);

    while(!istrue(level._id_1385F)) {
      waitframe();
      continue;
    }

    var_0 = 0;
    level thread _encstr_AB9028F6A91A7BB7236095EDABB080C8900FED03A169B3BE2233379AFBD114EFC608405D7BE54D49236E::_id_1383F(var_3, "_encstr_93621499B39B525CCBD195BFA2C0DF5A4950FE3BA84D");
    level waittill("_encstr_93A11417806EF53C4DADAB2160D39FAF4F14C378326B");

    if(isDefined(level.gulag) && istrue(level.gulag.shutdown)) {
      break;
    }

    var_4 = getdvarint("_encstr_BE841EF37E20A8AEF56EE06FA10FF8B80308F82B5AA367CF87EAEDD8E3C8D1D0", 20);
    wait(var_4);
  }
}

display_already_have_weapon_message() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_978814C3EB2F9EA349F27B47E7A148EDE3D2FB8933E7");
  level._id_1385F = 1;
}

dismount_after_accum_damage_internal(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_834E15F643A97834B1675243A7D81DD4674B302AFB48A1");
    var_1 = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::reinforcement_type();

    if(var_1.size <= var_0) {
      scripts\mp\flags::gameflagset("_encstr_978814C3EB2F9EA349F27B47E7A148EDE3D2FB8933E7");
      break;
    }
  }
}

display_current_cypher_to_player() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = getdvarint("_encstr_8AB317A00AA2FF09830F62E50FEF9661CC729839E3FB3B43F3", 10);
  wait(var_0);
  scripts\mp\flags::gameflagset("_encstr_978814C3EB2F9EA349F27B47E7A148EDE3D2FB8933E7");
}

disablespawncamera(var_0) {}

disablespawningforplayerfunc(var_0) {}

disablespawningforplayer(var_0) {
  level notify("_encstr_93A11417806EF53C4DADAB2160D39FAF4F14C378326B");
}

disablelootbunkercachelocations(var_0) {
  level notify("_encstr_93A11417806EF53C4DADAB2160D39FAF4F14C378326B");
  _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::dropplunderbyrarity(100, var_0);
  var_1 = getdvarint("_encstr_825819CD1BC97D139C7D53BA3BECF523937B83F5B6D2B92D76ABCD", 1);

  if(var_1)
    _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::ml_p1_func("_encstr_A1FF1C139363EDB7D1AFDDB28583ED73D7366BD74626D8B53BBE63AC7656", var_0);
}
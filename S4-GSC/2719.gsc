/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2719.gsc
*************************************************/

_id_6FF6(var_0, var_1, var_2) {
  if(istrue(level.ignorescoring)) {
    return;
  }
  if(isDefined(var_2)) {
    var_3 = var_2;
  } else {
    var_3 = scripts\mp\rank::getscoreinfovalue(var_0);
  }

  var_3 = _id_A012(var_0, var_3, var_1);
  scripts\mp\killstreaks\killstreaks::_id_6FF5(var_0, var_3);
  _id_4B7E(var_3, var_0);
}

_id_700C(var_0, var_1) {
  if(istrue(level.ignorescoring)) {
    return;
  }
  var_2 = undefined;

  if(isDefined(var_1)) {
    var_2 = var_1;
  } else {
    var_2 = scripts\mp\rank::getscoreinfovalue(var_0);
  }

  thread scripts\mp\rank::giverankxp(var_0, var_2);
  thread scripts\mp\rank::_id_CC00(var_0);
}

_id_7003(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(level._id_7003)) {
    thread[[level._id_7003]](var_0, var_1, var_2, var_3, var_4);
  }

  var_7 = scripts\mp\utility\game::getgametype() == "br" && !_id_07D1::_id_60BE("prematch_done");

  if(istrue(level.ignorescoring) && !issubstr(var_0, "assist") && !var_7) {
    return;
  }
  if(istrue(game["practiceRound"])) {
    return;
  }
  if(isDefined(var_2)) {
    var_8 = var_2;
  } else {
    var_8 = scripts\mp\rank::getscoreinfovalue(var_0);
  }

  scripts\mp\gamescore::_id_6FCF(var_0, var_8, var_4);
  var_8 = _id_A012(var_0, var_8, var_1);

  if(isDefined(var_1)) {
    var_9 = scripts\mp\utility\weapon::_id_9ACB(var_1);
    var_10 = getcompleteweaponname(var_9);
    thread scripts\mp\gamelogic::_id_F13D(var_10, var_8, "total_score_earned");
  }

  if(isDefined(var_6)) {
    var_6._id_038F = var_6._id_038F + var_8;
  }

  var_11 = var_0 == "kill";
  var_12 = scripts\mp\killstreaks\killstreaks::_id_878E(var_0);
  var_13 = scripts\mp\killstreaks\killstreaks::_id_88F0(var_0);
  var_14 = istrue(self._id_88DF);
  var_15 = _id_894A(var_1);
  var_16 = scripts\mp\utility\perk::_hasperk("specialty_killstreak_to_scorestreak");

  if((var_11 || var_13) && !scripts\mp\utility\perk::_hasperk("specialty_chain_killstreaks")) {
    self.pers["canKillChain"] = undefined;
  }

  var_17 = var_13 && istrue(self.pers["canKillChain"]) && istrue(var_5);

  if((var_11 || var_12 || var_17 || var_16) && (!var_14 || var_17 || var_16) && !var_15 && scripts\mp\utility\game::getgametype() != "br") {
    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      scripts\mp\killstreaks\killstreaks::_id_6FF5(var_0, 1, var_8);
    }
  }

  scripts\mp\supers::_id_6FF9(var_8, var_0);

  if(!istrue(var_3)) {
    var_18 = var_8;

    if(var_0 == "kill" && var_1 _meth_8624("gunperk_xp", 1)) {
      var_18 = var_18 + 20;
    }

    thread scripts\mp\rank::giverankxp(var_0, var_18, var_1);
  }

  thread _id_07CE::_id_8D83(var_0, 0);
}

_id_A012(var_0, var_1, var_2) {
  switch (var_0) {
    case "damage":
      return 0;
    default:
      break;
  }

  var_3 = 0;
  var_1 = var_1 + var_3;

  if(isDefined(level._id_A013)) {
    var_1 = [[level._id_A013]](var_1, var_0, self, var_2);
  }

  return int(var_1);
}

_id_4B7E(var_0, var_1) {
  if(getdvarint("#x389af232806b57940", 0) == 1) {
    return;
  }
  if(level.codcasterenabled) {
    foreach(var_3 in level.players) {
      if(var_3 _meth_81D3()) {
        var_4 = var_3 getspectatingplayer();

        if(isDefined(var_4)) {
          var_5 = var_4 getentitynumber();
          var_6 = self getentitynumber();

          if(var_5 == var_6) {
            var_3 thread scripts\mp\rank::_id_CC13(var_0);
            var_3 thread scripts\mp\rank::_id_CC00(var_1);
          }
        }
      }
    }
  }

  if(!isDefined(level._id_DDC2)) {
    var_8 = 0;

    if(scripts\mp\utility\game::_id_8A37()) {
      var_8 = var_1 == "kill";
    }

    thread scripts\mp\rank::_id_CC13(var_0, var_8);
  }
}

_id_894A(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(_func_0121(var_0)) {
    var_0 = makeweapon(var_0);
  }

  switch (var_0.basename) {
    case "tur_apc_rus_mp":
    case "lighttank_tur_mp":
    case "s4_tank_tur_mp":
    case "bradley_tow_proj_mp":
      return 1;
  }

  return 0;
}

_id_8868(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(_func_0121(var_0)) {
    var_0 = makeweapon(var_0);
  }

  switch (var_0.basename) {
    case "s4_binoculars_mps":
    case "s4_ks_targeting_radio":
    case "iw8_green_beam_mp":
    case "s4_ks_deploy_flamenaut_mp":
    case "s4_deploy_airdrop_mp":
      return 1;
  }

  return 0;
}
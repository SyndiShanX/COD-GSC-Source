/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3583ff375ab3a91e.gsc
***********************************************/

_id_61B256ED26C0A7F7() {
  _id_1E276F71CDB48ADF();
}

_id_1E276F71CDB48ADF() {
  game["dialog"]["gulag_jailer_intro"] = "ruls_jalr_guin";
}

_id_DA46DE174875958A(_id_1C32CF705599120D, _id_5A6598D5C3959784, _id_03877FE450CF4FD9, _id_65F75E5EFD53FA1E) {
  player = self;

  if(!isDefined(player) || !isDefined(_id_1C32CF705599120D)) {
    return;
  }
  if(isPlayer(_id_1C32CF705599120D) && !istrue(_id_1C32CF705599120D.gulag)) {
    return;
  }
  if(isPlayer(player) && !player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag()) {
    return;
  }
  if(!isDefined(_id_5A6598D5C3959784))
    _id_5A6598D5C3959784 = "outline_nodepth_orange";

  _id_1C32CF705599120D hudoutlineenableforclient(player, _id_5A6598D5C3959784);
  player thread _id_A2B7005FA6C293B5(_id_1C32CF705599120D, _id_03877FE450CF4FD9, _id_65F75E5EFD53FA1E);
}

_id_A2B7005FA6C293B5(_id_ED3544A0AFDE8995, _id_03877FE450CF4FD9, _id_65F75E5EFD53FA1E) {
  if(!isDefined(_id_ED3544A0AFDE8995)) {
    return;
  }
  player = self;
  player endon("disconnect");
  level endon("game_ended");

  if(isDefined(_id_03877FE450CF4FD9) && _id_03877FE450CF4FD9 > 0)
    _id_ED3544A0AFDE8995 scripts\engine\utility::waittill_any_timeout_4(_id_03877FE450CF4FD9, "disconnect", "gulag_end", "gulagLost", "hidePlayerOutlineToPlayer");
  else
    _id_ED3544A0AFDE8995 scripts\engine\utility::waittill_any_4("disconnect", "gulag_end", "gulagLost", "hidePlayerOutlineToPlayer");

  if(isDefined(_id_ED3544A0AFDE8995))
    _id_ED3544A0AFDE8995 hudoutlinedisableforclient(player);

  wait 0.5;

  if(istrue(_id_65F75E5EFD53FA1E))
    player thread _id_DA46DE174875958A(_id_ED3544A0AFDE8995, "outline_nodepth_green");
}

_id_80F9E9903919D770(_id_03877FE450CF4FD9) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player endon("gulag_end");
  player endon("gulagLost");
  wait(_id_03877FE450CF4FD9);
  player notify("hidePlayerOutlineToPlayer");
}

_id_36C9DC5A1D1BB023(arena) {
  if(isDefined(arena._id_801CDCFADC4D465C)) {
    foreach(_id_AC0E424AC96A7113 in arena._id_801CDCFADC4D465C) {
      if(!isDefined(_id_AC0E424AC96A7113)) {
        continue;
      }
      foreach(_id_F0EA4030349A33D5 in arena._id_801CDCFADC4D465C) {
        if(!isDefined(_id_F0EA4030349A33D5)) {
          continue;
        }
        if(_id_F0EA4030349A33D5 == _id_AC0E424AC96A7113) {
          continue;
        }
        if(istrue(level._id_43307855F189EB31._id_2928DFB3A48D00B3))
          _id_AC0E424AC96A7113 thread _id_DA46DE174875958A(_id_F0EA4030349A33D5, "outline_nodepth_green", undefined, 0);

        entnum = _id_F0EA4030349A33D5 getentitynumber();
        _id_5984A7CE217A3E1D = _id_17F3636354648F38(entnum);
        _id_AC0E424AC96A7113 setclientomnvar("ui_br_twotwo_gulag_player_state", _id_5984A7CE217A3E1D);
      }

      if(isDefined(arena._id_AF5243FBBA0720C2)) {
        foreach(_id_90461BE4437C102D in arena._id_AF5243FBBA0720C2)
        _id_AC0E424AC96A7113 thread _id_DA46DE174875958A(_id_90461BE4437C102D, "outline_nodepth_red", 10);
      }
    }
  }

  if(isDefined(arena._id_AF5243FBBA0720C2)) {
    foreach(_id_AC0E424AC96A7113 in arena._id_AF5243FBBA0720C2) {
      if(!isDefined(_id_AC0E424AC96A7113)) {
        continue;
      }
      foreach(_id_F0EA4030349A33D5 in arena._id_AF5243FBBA0720C2) {
        if(!isDefined(_id_AC0E424AC96A7113)) {
          continue;
        }
        if(!isDefined(_id_F0EA4030349A33D5)) {
          continue;
        }
        if(_id_F0EA4030349A33D5 == _id_AC0E424AC96A7113) {
          continue;
        }
        if(istrue(level._id_43307855F189EB31._id_2928DFB3A48D00B3))
          _id_AC0E424AC96A7113 thread _id_DA46DE174875958A(_id_F0EA4030349A33D5, "outline_nodepth_green", undefined, 0);

        entnum = _id_F0EA4030349A33D5 getentitynumber();
        _id_5984A7CE217A3E1D = _id_17F3636354648F38(entnum);
        _id_AC0E424AC96A7113 setclientomnvar("ui_br_twotwo_gulag_player_state", _id_5984A7CE217A3E1D);
      }

      foreach(_id_90461BE4437C102D in arena._id_801CDCFADC4D465C)
      _id_AC0E424AC96A7113 thread _id_DA46DE174875958A(_id_90461BE4437C102D, "outline_nodepth_red", 10);
    }
  }
}

_id_080658D002F64199(_id_C772F50C7278F2D3) {
  _id_3E309C0B51A20219 = self;

  if(level._id_43307855F189EB31._id_C497886247559B89) {
    _id_3E309C0B51A20219 setscriptablepartstate("second_chance_door_dom_gulag", "door_move_up", 0);
    _id_C772F50C7278F2D3 setscriptablepartstate("second_chance_door_dom_gulag", "door_move_up", 0);
  } else {
    _id_3E309C0B51A20219 setscriptablepartstate("second_chance_door_dom_gulag", "door_move_up_slowly", 0);
    _id_C772F50C7278F2D3 setscriptablepartstate("second_chance_door_dom_gulag", "door_move_up_slowly", 0);
  }
}

_id_51B0F4B8CBCE83AD(_id_3CCB8742D21B61D7) {
  level endon("game_ended");
  _id_3CCB8742D21B61D7._id_15FEE21B382BFD2E setscriptablepartstate("second_chance_door_dom_gulag", "door_move_down", 0);
  _id_3CCB8742D21B61D7._id_9A86491B9A098194 setscriptablepartstate("second_chance_door_dom_gulag", "door_move_down", 0);
  wait(level._id_43307855F189EB31._id_61B7B664D529876D);
  _id_3CCB8742D21B61D7._id_15FEE21B382BFD2E setscriptablepartstate("second_chance_door_dom_gulag", "door_standing_still", 0);
  _id_3CCB8742D21B61D7._id_9A86491B9A098194 setscriptablepartstate("second_chance_door_dom_gulag", "door_standing_still_unusable", 0);
  _id_3CCB8742D21B61D7.dooropen = 0;
}

_id_6CE94CF4EEE9EAB7(_id_3CCB8742D21B61D7) {
  player = self;

  if(!isDefined(player)) {
    return;
  }
  objective_addclienttomask(_id_3CCB8742D21B61D7.objid, player);
  objective_showtoplayersinmask(_id_3CCB8742D21B61D7.objid);
}

_id_289F11B986B7A971(arena) {
  _id_3CCB8742D21B61D7 = self;

  foreach(_id_AC0E424AC96A7113 in arena.arenaplayers) {
    if(!isDefined(_id_AC0E424AC96A7113) || isDefined(_id_AC0E424AC96A7113._id_C1057221E17F180B) && _id_AC0E424AC96A7113._id_C1057221E17F180B == _id_3CCB8742D21B61D7) {
      continue;
    }
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(_id_3CCB8742D21B61D7.objid, _id_AC0E424AC96A7113);
  }
}

_id_45C3DC4231157A10() {
  player = self;
  player endon("disconnect");
  level endon("game_ended");
  wait 11;

  if(!player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag())
    player kill();
}

_id_64B7B488766DB3C6(headicon, _id_0CA5A607C4F7A315) {
  _id_B37AEF355BA7B694 = self;
  level endon("game_ended");
  _id_0CA5A607C4F7A315 endon("watchHeadIconDelete");
  scripts\engine\utility::waittill_any_ents(_id_B37AEF355BA7B694, "death", _id_B37AEF355BA7B694, "disconnect", _id_B37AEF355BA7B694, "gulag_end", _id_B37AEF355BA7B694, "gulagLost");

  if(!isDefined(_id_B37AEF355BA7B694)) {
    return;
  }
  removeclientfromheadiconmask(headicon, _id_B37AEF355BA7B694);
}

_id_4CBA46D26023C1DB(headicon, _id_B37AEF355BA7B694) {
  _id_0CA5A607C4F7A315 = self;
  level endon("game_ended");
  scripts\engine\utility::waittill_any_ents(_id_0CA5A607C4F7A315, "death", _id_0CA5A607C4F7A315, "disconnect", _id_0CA5A607C4F7A315, "gulag_end", _id_0CA5A607C4F7A315, "gulagLost");
  _id_0CA5A607C4F7A315 notify("watchHeadIconDelete");
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(headicon);
}

_id_6F05F895A3054FF0(arena) {
  foreach(_id_3CCB8742D21B61D7 in arena._id_CEFC1BF41237BBAC) {
    objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

    if(objid != -1) {
      doorcenter = (_id_3CCB8742D21B61D7._id_15FEE21B382BFD2E.origin + _id_3CCB8742D21B61D7._id_9A86491B9A098194.origin) / 2;
      offset = (doorcenter - _id_3CCB8742D21B61D7.origin) * 0.9;
      scripts\mp\objidpoolmanager::objective_add_objective(objid, "current", _id_3CCB8742D21B61D7.origin + (offset[0], offset[1], 60), "ui_mp_br_icon_gulag_exit_objective");
      scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(objid);
      scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);
    } else {}

    _id_3CCB8742D21B61D7.objid = objid;
  }
}

_id_1167994A7CE49346() {
  player = self;
  player._id_D4516C0702838861 = 0;
  player._id_6FC7042AD8A7DD15 = 0;
}

_id_C84E254980C7C8ED() {
  player = self;

  if(istrue(level.usegulag) && isDefined(level._id_43307855F189EB31) && !istrue(level._id_43307855F189EB31._id_186B191E239ABC1C) && isDefined(player) && isPlayer(player) && player _id_2CEDCC356F1B9FC8::isplayeringulag())
    return 0;

  return 1;
}

_id_A65DF5D97EE38203(arena) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");

  if(!isDefined(arena._id_053A4DA52F050A4F))
    arena._id_053A4DA52F050A4F = 0;

  _id_728EB76C27B59BF0 = _id_26945642F76B4740();
  [totalscore, _id_A12D637DFB1FF12F, _id_20E6D5414D4C7ADE, _id_B2F307125DFF1489, _id_D8FE1C1DD6DDB7C5, _id_83D2E74282CD7DD5] = _id_2F009F7EAAD038CC(_id_728EB76C27B59BF0);
  player _id_A8E64BD30C96ECFB(player._id_32484CD3B17F16C8, _id_728EB76C27B59BF0, _id_B2F307125DFF1489);
  _id_EB9BC703B343267F = 0;

  if(totalscore > arena._id_053A4DA52F050A4F) {
    _id_EB9BC703B343267F = 1;
    arena._id_053A4DA52F050A4F = totalscore;
  }

  player _id_DC8CE3434BD7703D(_id_EB9BC703B343267F, _id_83D2E74282CD7DD5, totalscore);
  player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_51A16F5123111DBE", undefined, int(totalscore / 450) * 10);
}

_id_2F009F7EAAD038CC(_id_728EB76C27B59BF0) {
  player = self;
  _id_72BB89E60D3674DF = 0;
  _id_D68490486B12F2F1 = 0;

  if(isDefined(level._id_43307855F189EB31._id_D8ACF770BB690E88) && level._id_43307855F189EB31._id_D8ACF770BB690E88 > 0)
    _id_D68490486B12F2F1 = level._id_43307855F189EB31._id_D8ACF770BB690E88;

  _id_A12D637DFB1FF12F = 0;

  if(isDefined(level._id_43307855F189EB31._id_D5E82D0C08288A76) && level._id_43307855F189EB31._id_D5E82D0C08288A76 != "") {
    _id_4D2DC00B3EFB6AF8 = strtok(level._id_43307855F189EB31._id_D5E82D0C08288A76, " ");

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_4D2DC00B3EFB6AF8.size; _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + 2) {
      if(int(_id_4D2DC00B3EFB6AF8[_id_AC0E594AC96AA3A8]) >= _id_728EB76C27B59BF0) {
        if(isDefined(_id_4D2DC00B3EFB6AF8[_id_AC0E594AC96AA3A8 - 1]))
          _id_A12D637DFB1FF12F = int(_id_4D2DC00B3EFB6AF8[_id_AC0E594AC96AA3A8 - 1]);
        else
          _id_A12D637DFB1FF12F = int(_id_4D2DC00B3EFB6AF8[_id_AC0E594AC96AA3A8 + 1]);

        break;
      }
    }
  }

  _id_20E6D5414D4C7ADE = 0;

  if(isDefined(player._id_32484CD3B17F16C8) && isDefined(level._id_43307855F189EB31._id_F61587BA0E14EFB3) && level._id_43307855F189EB31._id_F61587BA0E14EFB3 != "") {
    _id_E9C56B253DD633CB = strtok(level._id_43307855F189EB31._id_F61587BA0E14EFB3, " ");

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_E9C56B253DD633CB.size; _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + 2) {
      if(int(_id_E9C56B253DD633CB[_id_AC0E594AC96AA3A8]) <= player._id_32484CD3B17F16C8) {
        if(isDefined(_id_E9C56B253DD633CB[_id_AC0E594AC96AA3A8 + 1]))
          _id_20E6D5414D4C7ADE = int(_id_E9C56B253DD633CB[_id_AC0E594AC96AA3A8 + 1]);
        else
          _id_20E6D5414D4C7ADE = int(_id_E9C56B253DD633CB[_id_AC0E594AC96AA3A8 - 1]);

        break;
      }
    }
  }

  _id_34D1D564DB76A821 = 0;
  _id_88AF353046E1F521 = 0;

  if(isDefined(player._id_322535086C0890FA) && player._id_322535086C0890FA > 0 && isDefined(level._id_43307855F189EB31._id_F38668696712BBEC) && level._id_43307855F189EB31._id_F38668696712BBEC != "") {
    _id_AF552CA0755793EE = strtok(level._id_43307855F189EB31._id_F38668696712BBEC, " ");

    if(isDefined(player._id_D25277121D9D0A6C) && player._id_D25277121D9D0A6C > 0 && isDefined(player._id_322535086C0890FA) && player._id_322535086C0890FA > 0)
      _id_88AF353046E1F521 = int(player._id_D25277121D9D0A6C / player._id_322535086C0890FA * 100);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_AF552CA0755793EE.size; _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + 2) {
      if(int(_id_AF552CA0755793EE[_id_AC0E594AC96AA3A8]) <= _id_88AF353046E1F521) {
        if(isDefined(_id_AF552CA0755793EE[_id_AC0E594AC96AA3A8 + 1]))
          _id_34D1D564DB76A821 = int(_id_AF552CA0755793EE[_id_AC0E594AC96AA3A8 + 1]);
        else
          _id_34D1D564DB76A821 = int(_id_AF552CA0755793EE[_id_AC0E594AC96AA3A8 - 1]);

        break;
      }
    }
  }

  _id_D8FE1C1DD6DDB7C5 = 0;

  if(isDefined(level._id_43307855F189EB31._id_A3C8A88EE8F693B1) && level._id_43307855F189EB31._id_A3C8A88EE8F693B1 != "") {
    _id_690C6123B234EBC1 = strtok(level._id_43307855F189EB31._id_A3C8A88EE8F693B1, " ");

    if(!isDefined(player._id_3A7C9A3E9AA20358))
      _id_D8FE1C1DD6DDB7C5 = int(_id_690C6123B234EBC1[1]);
    else {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_690C6123B234EBC1.size; _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + 2) {
        if(int(_id_690C6123B234EBC1[_id_AC0E594AC96AA3A8]) >= player._id_3A7C9A3E9AA20358) {
          if(isDefined(_id_690C6123B234EBC1[_id_AC0E594AC96AA3A8 - 1]))
            _id_D8FE1C1DD6DDB7C5 = int(_id_690C6123B234EBC1[_id_AC0E594AC96AA3A8 - 1]);
          else
            _id_D8FE1C1DD6DDB7C5 = int(_id_690C6123B234EBC1[_id_AC0E594AC96AA3A8 + 1]);

          break;
        }
      }
    }
  }

  _id_72BB89E60D3674DF = _id_D68490486B12F2F1 + _id_A12D637DFB1FF12F + _id_20E6D5414D4C7ADE + _id_34D1D564DB76A821 + _id_D8FE1C1DD6DDB7C5;
  _id_83D2E74282CD7DD5 = 0;

  if(isDefined(level._id_43307855F189EB31._id_D1562ADE1A147C53) && level._id_43307855F189EB31._id_D1562ADE1A147C53 != "") {
    _id_1DBBD8627F3848EB = strtok(level._id_43307855F189EB31._id_D1562ADE1A147C53, " ");

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1DBBD8627F3848EB.size; _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + 2) {
      if(int(_id_1DBBD8627F3848EB[_id_AC0E594AC96AA3A8]) > _id_72BB89E60D3674DF) {
        if(isDefined(_id_1DBBD8627F3848EB[_id_AC0E594AC96AA3A8 - 1]))
          _id_83D2E74282CD7DD5 = int(_id_1DBBD8627F3848EB[_id_AC0E594AC96AA3A8 - 1]);
        else
          _id_83D2E74282CD7DD5 = int(_id_1DBBD8627F3848EB[_id_AC0E594AC96AA3A8 + 1]);

        break;
      }
    }
  }

  player._id_0938604A8B5DD849 = _id_72BB89E60D3674DF;
  player._id_E1ED3A7677EF1776 = _id_83D2E74282CD7DD5;
  return [_id_72BB89E60D3674DF, _id_A12D637DFB1FF12F, _id_20E6D5414D4C7ADE, _id_88AF353046E1F521, _id_D8FE1C1DD6DDB7C5, _id_83D2E74282CD7DD5];
}

_id_A8E64BD30C96ECFB(_id_8ABA3809EFED9EED, _id_97693C0E23F39F3D, _id_B2F307125DFF1489) {
  player = self;

  if(!isDefined(player)) {
    return;
  }
  if(!isDefined(_id_8ABA3809EFED9EED) || _id_8ABA3809EFED9EED < 0)
    _id_8ABA3809EFED9EED = 0;

  _id_97693C0E23F39F3D = int(_id_97693C0E23F39F3D / 100);
  _id_5C9DDCF56D36F133 = _id_8E6F76B7C8C0EAF0(_id_8ABA3809EFED9EED, _id_97693C0E23F39F3D, _id_B2F307125DFF1489);
  player setclientomnvar("ui_br_ai_gulag_end_score", _id_5C9DDCF56D36F133);
}

_id_8E6F76B7C8C0EAF0(_id_8ABA3809EFED9EED, _id_97693C0E23F39F3D, _id_B2F307125DFF1489) {
  _id_1FEC4C6883C46D11 = 31;
  _id_E6AE9427C9926AE1 = 1023;
  _id_1C43C0D900E63A9D = 1023;
  _id_C8A5261A0FCA66D4 = int(_id_8ABA3809EFED9EED) &_id_1FEC4C6883C46D11;
  _id_C8A5261A0FCA66D4 = _id_C8A5261A0FCA66D4 + ((int(_id_97693C0E23F39F3D) &_id_E6AE9427C9926AE1) << 5);
  _id_C8A5261A0FCA66D4 = _id_C8A5261A0FCA66D4 + ((int(_id_B2F307125DFF1489) &_id_1C43C0D900E63A9D) << 15);
  return _id_C8A5261A0FCA66D4;
}

_id_DC8CE3434BD7703D(_id_EB9BC703B343267F, _id_C8E058E41ED64535, _id_663572CC85C027C6) {
  player = self;

  if(!isDefined(player)) {
    return;
  }
  _id_5C9DDCF56D36F133 = _id_97D23ABEB51A7E62(_id_EB9BC703B343267F, _id_C8E058E41ED64535, _id_663572CC85C027C6);
  player setclientomnvar("ui_br_ai_gulag_end_score_best", _id_5C9DDCF56D36F133);
}

_id_97D23ABEB51A7E62(_id_EB9BC703B343267F, _id_C8E058E41ED64535, _id_663572CC85C027C6) {
  _id_9683861002FA7757 = 1;
  _id_BA6AF4F96DC4A9C9 = 7;
  _id_3E289C2968541EF8 = 268435455;
  _id_C8A5261A0FCA66D4 = int(_id_EB9BC703B343267F) &_id_9683861002FA7757;
  _id_C8A5261A0FCA66D4 = _id_C8A5261A0FCA66D4 + ((int(_id_C8E058E41ED64535) &_id_BA6AF4F96DC4A9C9) << 1);
  _id_C8A5261A0FCA66D4 = _id_C8A5261A0FCA66D4 + ((int(_id_663572CC85C027C6) &_id_3E289C2968541EF8) << 4);
  return _id_C8A5261A0FCA66D4;
}

_id_17F3636354648F38(_id_8E0908C9AD75D350) {
  _id_6891A0702DE9917E = 255;
  _id_C8A5261A0FCA66D4 = int(_id_8E0908C9AD75D350) &_id_6891A0702DE9917E;
  return _id_C8A5261A0FCA66D4;
}

_id_DA0A5D9A9FC8ABC2(arena) {
  objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(objid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(objid, "current", arena.center + (0, 0, -60), "hud_icon_objective_skeleton_key");
    scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(objid);
    scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);
  } else {}

  arena._id_A9350ED31BEC6AEF = objid;
}

_id_9F7B9A86A5328F0B(arena, position) {
  if(!isDefined(arena._id_A9350ED31BEC6AEF)) {
    return;
  }
  objective_position(arena._id_A9350ED31BEC6AEF, position + (0, 0, 20));

  foreach(_id_AC0E424AC96A7113 in arena.arenaplayers) {
    if(!isDefined(_id_AC0E424AC96A7113)) {
      continue;
    }
    objective_addclienttomask(arena._id_A9350ED31BEC6AEF, _id_AC0E424AC96A7113);
    objective_showtoplayersinmask(arena._id_A9350ED31BEC6AEF);
  }
}

_id_00BA5DBC7633C84A(arena) {
  if(!isDefined(arena._id_A9350ED31BEC6AEF)) {
    return;
  }
  foreach(_id_AC0E424AC96A7113 in arena.arenaplayers) {
    if(!isDefined(_id_AC0E424AC96A7113)) {
      continue;
    }
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(arena._id_A9350ED31BEC6AEF, _id_AC0E424AC96A7113);
  }
}

_id_D8F18F1D691C0EF8(arena) {
  if(level._id_43307855F189EB31._id_82FEDF664AD855EB <= 0)
    return 0;

  if(level._id_43307855F189EB31._id_82FEDF664AD855EB == 1)
    return 1;
  else if(level._id_43307855F189EB31._id_82FEDF664AD855EB == 2) {
    if(!istrue(arena._id_5F525E1E05714BB5))
      return 1;
  }

  return 0;
}

_id_D095C23873D8EFED() {
  _id_94AFB7D602135955 = getdvarint("dvar_8BDEE07FA09E810A", -1);

  if(_id_94AFB7D602135955 > -1)
    return level.gulag.arenas[_id_94AFB7D602135955];

  if(!istrue(level.gulag.multiarena))
    return level.gulag.arenas[0];

  _id_F8E38F0423A1A9C5 = 1;

  foreach(arena in level.gulag.arenas) {
    if(arena.matches.size > 0) {
      _id_F8E38F0423A1A9C5 = 0;
      break;
    }
  }

  if(_id_F8E38F0423A1A9C5)
    return level.gulag.arenas[0];

  _id_5DD209C141F918FA = undefined;
  _id_318A1DBF1A07DCB0 = -1;

  foreach(arena in level.gulag.arenas) {
    foreach(_id_AA9F4C033D62BC8A in arena.matches) {
      if(_id_AA9F4C033D62BC8A.size < 2 && _id_318A1DBF1A07DCB0 < 2) {
        foreach(player in _id_AA9F4C033D62BC8A) {
          _id_DE841985A7F29953 = _id_67708F418B1FAC79::_id_6A7526F387D26776(_id_AA9F4C033D62BC8A);

          if(_id_AA9F4C033D62BC8A.size < 2) {
            if(_id_DE841985A7F29953 < 1) {
              _id_318A1DBF1A07DCB0 = _id_AA9F4C033D62BC8A.size;
              _id_5DD209C141F918FA = arena;
            }

            continue;
          }

          if(_id_DE841985A7F29953 < 2) {
            _id_318A1DBF1A07DCB0 = _id_AA9F4C033D62BC8A.size;
            _id_5DD209C141F918FA = arena;
          }
        }
      }
    }
  }

  if(_id_318A1DBF1A07DCB0 != -1)
    return _id_5DD209C141F918FA;

  _id_CA6FB26113ABAF27 = 99;
  _id_5DD209C141F918FA = undefined;

  foreach(arena in level.gulag.arenas) {
    if(arena.matches.size < _id_CA6FB26113ABAF27) {
      _id_AA9F4C033D62BC8A = arena.matches[arena.matches.size - 1];

      if(isDefined(_id_AA9F4C033D62BC8A) && _id_AA9F4C033D62BC8A.size > 0) {
        foreach(player in _id_AA9F4C033D62BC8A) {
          _id_DE841985A7F29953 = _id_67708F418B1FAC79::_id_6A7526F387D26776(_id_AA9F4C033D62BC8A);

          if(_id_DE841985A7F29953 < 2) {
            _id_CA6FB26113ABAF27 = arena.matches.size;
            _id_5DD209C141F918FA = arena;
          }
        }

        continue;
      }

      _id_CA6FB26113ABAF27 = arena.matches.size;
      _id_5DD209C141F918FA = arena;
    }
  }

  if(isDefined(_id_5DD209C141F918FA))
    return _id_5DD209C141F918FA;

  scripts\mp\utility\script::demoforcesre("[GULAG] gulag_playerGetNextArena : could not find a proper gulag arena. Returning a random arena");
  return level.gulag.arenas[randomint(level.gulag.arenas.size)];
}

_id_B57F39D9E91EBF95(arena) {
  _id_2D19E82B56A9C455 = arena.center;
  lootcaches = getlootscriptablearray("br_loot_cache_gulag");

  foreach(_id_B038ED928EC17A81 in lootcaches) {
    if(distance(_id_B038ED928EC17A81.origin, _id_2D19E82B56A9C455) < 8000) {
      items = getscriptablelootcachecontents(_id_B038ED928EC17A81);
      _id_B038ED928EC17A81.contents = _id_552B8E4EA5FF7DF1::_id_EC87B214CD429E96(items, undefined);
      _id_B038ED928EC17A81 setscriptablepartstate("body", "closed_usable");
    }
  }
}

_id_2F4344ABDC200E43(player) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.gulag.arenas.size; _id_AC0E594AC96AA3A8++) {
    _id_F40E6DEEC30EE209 = level.gulag.arenas[_id_AC0E594AC96AA3A8];

    foreach(_id_31210CE93279D451 in _id_F40E6DEEC30EE209.arenaplayers) {
      if(!isDefined(_id_31210CE93279D451)) {
        continue;
      }
      if(_id_31210CE93279D451 == player) {
        arena = level.gulag.arenas[_id_AC0E594AC96AA3A8];
        return arena;
      }
    }
  }

  return undefined;
}

_id_DE20B194B1A37513(player) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.gulag.arenas.size; _id_AC0E594AC96AA3A8++) {
    _id_F40E6DEEC30EE209 = level.gulag.arenas[_id_AC0E594AC96AA3A8];

    foreach(jailedplayers in _id_F40E6DEEC30EE209.jailedplayers) {
      if(!isDefined(jailedplayers)) {
        continue;
      }
      if(jailedplayers == player) {
        arena = level.gulag.arenas[_id_AC0E594AC96AA3A8];
        return arena;
      }
    }
  }

  return undefined;
}

_id_394C37628AFD48EF(arena) {
  if(isDefined(arena._id_6D4E3B180776136F)) {
    foreach(_id_FA4B87EBA037F1BC in arena._id_6D4E3B180776136F) {
      if(!isDefined(_id_FA4B87EBA037F1BC)) {
        continue;
      }
      _id_FA4B87EBA037F1BC freescriptable();
    }

    arena._id_6D4E3B180776136F = [];
    _id_00BA5DBC7633C84A(arena);
  }
}

_id_15997D969114692D(arena) {
  foreach(_id_3CCB8742D21B61D7 in arena._id_CEFC1BF41237BBAC) {
    _id_3CCB8742D21B61D7._id_15FEE21B382BFD2E setscriptablepartstate("second_chance_door_dom_gulag", "door_standing_still", 0);
    _id_3CCB8742D21B61D7._id_15FEE21B382BFD2E.origin = _id_3CCB8742D21B61D7._id_15FEE21B382BFD2E._id_F590D44509C2E578;
    _id_3CCB8742D21B61D7._id_9A86491B9A098194 setscriptablepartstate("second_chance_door_dom_gulag", "door_standing_still", 0);
    _id_3CCB8742D21B61D7._id_9A86491B9A098194.origin = _id_3CCB8742D21B61D7._id_9A86491B9A098194._id_F590D44509C2E578;
  }
}

_id_1794EC0DECE12D2F(arena) {
  foreach(loot in arena._id_62D1855D36CFF5D2) {
    if(!isDefined(loot)) {
      continue;
    }
    loot setscriptablepartstate(loot.type, "visible");
  }

  arena._id_62D1855D36CFF5D2 = [];
}

_id_9EFAE38238E4DF66(attacker, victim) {
  if(!_id_5BC60484D17FA95C::_id_27C68DD3E26C23DB("gulag2v2Teams"))
    return 0;

  arena = _id_2F4344ABDC200E43(attacker);

  if(!isDefined(arena))
    return 0;

  if(isPlayer(victim) && isPlayer(attacker) && istrue(victim.gulag) && istrue(attacker.gulag)) {
    _id_2407F73B07F0C500 = scripts\engine\utility::array_contains(arena._id_801CDCFADC4D465C, attacker);
    _id_4B99B4CADBEEA961 = scripts\engine\utility::array_contains(arena._id_801CDCFADC4D465C, victim);
    _id_95101F232ED9FF74 = undefined;
    _id_D08F19428AEFDD07 = undefined;

    if(isDefined(arena._id_AF5243FBBA0720C2)) {
      _id_95101F232ED9FF74 = scripts\engine\utility::array_contains(arena._id_AF5243FBBA0720C2, attacker);
      _id_D08F19428AEFDD07 = scripts\engine\utility::array_contains(arena._id_AF5243FBBA0720C2, victim);
    }

    if(_id_2407F73B07F0C500 && _id_4B99B4CADBEEA961 || isDefined(_id_95101F232ED9FF74) && isDefined(_id_D08F19428AEFDD07) && (_id_95101F232ED9FF74 && _id_D08F19428AEFDD07))
      return 1;
  }

  return 0;
}

_id_C210E62F0B64CFB1(attacker, victim) {
  if(!_id_5BC60484D17FA95C::_id_27C68DD3E26C23DB("gulag2v2Teams") || !isDefined(victim) || !isDefined(attacker))
    return 0;

  if(victim.team != attacker.team)
    return 0;

  arena = _id_2F4344ABDC200E43(attacker);

  if(!isDefined(arena))
    return 0;

  if(isPlayer(victim) && isPlayer(attacker) && istrue(victim.gulag) && istrue(attacker.gulag)) {
    if(victim.team == attacker.team) {
      _id_2407F73B07F0C500 = scripts\engine\utility::array_contains(arena._id_801CDCFADC4D465C, attacker);
      _id_4B99B4CADBEEA961 = scripts\engine\utility::array_contains(arena._id_801CDCFADC4D465C, victim);
      _id_95101F232ED9FF74 = scripts\engine\utility::array_contains(arena._id_AF5243FBBA0720C2, attacker);
      _id_D08F19428AEFDD07 = scripts\engine\utility::array_contains(arena._id_AF5243FBBA0720C2, victim);

      if(_id_2407F73B07F0C500 && _id_D08F19428AEFDD07 || _id_4B99B4CADBEEA961 && _id_95101F232ED9FF74)
        return 1;
    }
  }

  return 0;
}

_id_63CEF9BB6769F404(arena) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player freezecontrols(1);
  player freezelookcontrols(1);
  wait 1;

  if(!isDefined(player)) {
    return;
  }
  wait 0.1;

  if(!isDefined(player)) {
    return;
  }
  _id_B4637ECADC7205C6 = player.origin + (0, 0, 600);
  _id_6C9E9A5AC1A039A9 = player.origin + (0, 0, 72);
  camera = spawn("script_model", _id_B4637ECADC7205C6);
  camera setModel("tag_origin");
  camera.angles = (60, player.angles[1], 0);
  player._id_0B6149F3189DEB38 = camera;
  player cameralinkTo(camera, "tag_origin", 1, 1);
  wait 2.5;
  camera rotateTo((20, player.angles[1], 0), 1.7, 0.5, 0.5);
  wait 0.5;
  _id_67654372C5D5B194 = undefined;

  if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("isGulagJailTimeoutVariation"))
    _id_67654372C5D5B194 = _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("isGulagJailTimeoutVariation", arena);

  if(istrue(_id_67654372C5D5B194))
    player thread scripts\mp\hud_message::showsplash("br_twotwo_one_v_one_gulag_match_intro");
  else
    player thread scripts\mp\hud_message::showsplash("br_twotwo_gulag_match_intro");

  wait 2.2;

  if(!isDefined(camera) || !isDefined(player)) {
    return;
  }
  camera moveTo(_id_6C9E9A5AC1A039A9, 1.3, 0.5, 0.5);
  camera rotateTo(player.angles, 0.8, 0.3, 0.3);
  wait 1.5;

  if(!isDefined(camera) || !isDefined(player)) {
    return;
  }
  player cameraunlink();
  player freezecontrols(0);
  player freezelookcontrols(0);
  wait 0.5;

  if(!isDefined(camera) || !isDefined(player)) {
    return;
  }
  camera delete();
  player._id_0B6149F3189DEB38 = undefined;
}

_id_85B349978CD4DE4F(arena) {
  player = self;
  level endon("game_ended");
  level endon("gulag_break");
  player endon("disconnect");
  player thread _id_E14E13143D59C4B2(arena);
  player scripts\engine\utility::waittill_notify_or_timeout("gulag_player_ready_loadout", 2.0);

  if(!isDefined(player)) {
    return;
  }
  _id_6C9750573F9A9742 = "wz_gulag_player_acknowledge_l_xcam";
  _id_D9D9EE6E67489912 = "wz_gulag_player_acknowledge_l";

  if(player._id_098482020D94DBD8 == 2) {
    _id_6C9750573F9A9742 = "wz_gulag_player_acknowledge_r_xcam";
    _id_D9D9EE6E67489912 = "wz_gulag_player_acknowledge_r";
  }

  primaryweaponobj = player getcurrentweapon();

  if(isDefined(primaryweaponobj) && primaryweaponobj.classname == "pistol")
    _id_D9D9EE6E67489912 = _id_D9D9EE6E67489912 + "_pistol";

  player thread _id_696F54DA8FCB6BBE("gulag_jailer_intro", arena);

  if(level._id_43307855F189EB31._id_2F9AE625D3D6EF89)
    player freezecontrols(1);

  player dontinterpolate();
  wait 0.8;

  if(!isDefined(player)) {
    return;
  }
  if(isDefined(player._id_600419D0DBB63AF7)) {
    player setOrigin(player._id_600419D0DBB63AF7);
    player._id_600419D0DBB63AF7 = undefined;
  }

  if(isDefined(player._id_35F055A703EC57D7)) {
    player setplayerangles(player._id_35F055A703EC57D7);
    player._id_35F055A703EC57D7 = undefined;
  }

  wait 0.2;

  if(!isDefined(player)) {
    return;
  }
  player _id_5BAB271917698DC4::_id_E68E4BB4F65F5FE4();
  player _meth_33010A90BCF48DB4(_id_6C9750573F9A9742, 0, player.origin, player.angles);
  player playanimscriptsceneevent("scripted_scene", _id_D9D9EE6E67489912);
  _id_8355076D4ED3FC96 = _func_4358B309FDCC6D44(_id_6C9750573F9A9742);
  wait(_id_8355076D4ED3FC96 - 0.75);

  if(!isDefined(player)) {
    return;
  }
  player _id_5BAB271917698DC4::_id_334A8FE67E88BBE7();
  wait 0.7;

  if(!isDefined(player)) {
    return;
  }
  if(level._id_43307855F189EB31._id_2F9AE625D3D6EF89)
    player freezecontrols(0);

  if(level._id_43307855F189EB31._id_592FAF90EA5616F5) {
    player scripts\cp_mp\utility\inventory_utility::_id_F1E9D0C09F38006B(0);
    player thread scripts\cp_mp\utility\inventory_utility::_id_9897D143C3FEEE05();
  }

  player _id_5BAB271917698DC4::_id_E68E4BB4F65F5FE4();
}

_id_608E28250C9D63A9(arena) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  wait 1;

  if(!isDefined(player)) {
    return;
  }
  player thread _id_E14E13143D59C4B2(arena);
  player scripts\engine\utility::waittill_notify_or_timeout("gulag_player_ready_loadout", 2.0);

  if(!isDefined(player)) {
    return;
  }
  if(isDefined(player._id_35F055A703EC57D7)) {
    player setplayerangles(player._id_35F055A703EC57D7);
    player._id_35F055A703EC57D7 = undefined;
  }

  if(isDefined(player._id_600419D0DBB63AF7)) {
    player setOrigin(player._id_600419D0DBB63AF7);
    player._id_600419D0DBB63AF7 = undefined;
  }

  player thread _id_696F54DA8FCB6BBE("gulag_jailer_intro", arena);
  _id_13E3FC231BB8D6B9 = player _id_5BAB271917698DC4::playeriscinematiclayeron();

  if(_id_13E3FC231BB8D6B9)
    player _id_5BAB271917698DC4::_id_E68E4BB4F65F5FE4();
}

_id_E14E13143D59C4B2(arena) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");

  if(player.gulagloadoutindex == 1)
    index = arena._id_1003FA05CFFAADCB;
  else
    index = arena._id_28DDCFCEC434CBF5;

  if(level._id_43307855F189EB31._id_3B156BE10B96EDB9)
    index = arena._id_1003FA05CFFAADCB;

  if(level._id_43307855F189EB31._id_F336DFCEF737A30C >= 0)
    index = level._id_43307855F189EB31._id_F336DFCEF737A30C;

  if(!isDefined(index))
    index = 0;

  _id_F055075301C996B0 = tablelookupbyrow("mp/br_twotwo_gulag_loadout.csv", index, 3);

  for(primaryweaponobj = player getcurrentweapon(); primaryweaponobj.basename != _id_F055075301C996B0; primaryweaponobj = player getcurrentweapon()) {
    wait 0.1;

    if(!isDefined(player))
      return;
  }

  player notify("gulag_player_ready_loadout");
}

_id_7AD9FCB1AC4F3DB8() {
  return istrue(level._id_43307855F189EB31._id_2AD1F292809C28BB);
}

_id_1082D39CDBA869D9() {
  if(isDefined(level._id_43307855F189EB31) && istrue(level._id_43307855F189EB31._id_78A9FE891A9F4771))
    return 1;

  return 0;
}

_id_696F54DA8FCB6BBE(dialog, arena) {
  player = self;

  if(!isDefined(player) || !isDefined(game["dialog"][dialog])) {
    return;
  }
  _id_CB3339ECE72DBDEB = tolower("dx_br_brgj_" + game["dialog"][dialog]);
  _id_1BB86493E750C91F = undefined;

  if(isDefined(arena._id_6F46A87C5570DEAB) && istrue(level._id_43307855F189EB31._id_1A56FC9A83D19E68))
    _id_1BB86493E750C91F = arena._id_6F46A87C5570DEAB.origin;
  else
    _id_1BB86493E750C91F = player.origin;

  if(soundexists(_id_CB3339ECE72DBDEB)) {
    if(isent(arena._id_05C21E504CDF8C47))
      player playsoundtoplayer(_id_CB3339ECE72DBDEB, player, arena._id_05C21E504CDF8C47);
    else {
      _id_1499E7C2D69E0074 = lookupsoundlength(_id_CB3339ECE72DBDEB, 1) / 1000.0;
      player queuedialogforplayer(_id_CB3339ECE72DBDEB, dialog, _id_1499E7C2D69E0074, undefined, undefined, _id_1BB86493E750C91F, _id_1499E7C2D69E0074);
    }
  } else
    scripts\mp\utility\script::demoforcesre("missing VO " + _id_CB3339ECE72DBDEB);
}

_id_63776B389E7C92C1() {
  player = self;
  player._id_F42099A4E4FA8BC9 = gettime();
  player._id_32484CD3B17F16C8 = 0;
  player._id_D919D1C70719E664 = 0;
  arena = _id_2F4344ABDC200E43(player);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.gulag.arenas.size; _id_AC0E594AC96AA3A8++) {
    if(arena == level.gulag.arenas[_id_AC0E594AC96AA3A8])
      player._id_F8A7B6F177E2F466 = _id_AC0E594AC96AA3A8;
  }
}

_id_0DCEAD2B56FDBF3E(_id_6B7CDED46E0D4030) {
  player = self;

  if(!isDefined(player)) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = [];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "waiting_duration";
  _id_AD6498E5D4B1AE34 = _id_AA018B2F697301F3();
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_AD6498E5D4B1AE34;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "gulag_duration";
  _id_902CF2FB782C194F = _id_26945642F76B4740();
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_902CF2FB782C194F;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "gulag_ai_kills";
  _id_5E3569A259244137 = _id_B48CEF39DBA5574C();
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_5E3569A259244137;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "gulag_pickups";
  _id_2134A6B39F9A41FD = _id_86042B32222CF561();
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_2134A6B39F9A41FD;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "gulag_cargo_hold";
  _id_F96046226B97E66D = _id_0A71D1BECF0F787E();
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_F96046226B97E66D;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "gulag_cargo_cable";
  _id_9C99EFDE39BE3331 = _id_3FACAB0D974296C1();
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_9C99EFDE39BE3331;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "gulag_cargo_camera";
  _id_648BAFB49D3955C7 = _id_2D65E8E1F1EFA597();
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_648BAFB49D3955C7;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "gulag_cargo_vent";
  _id_ED714BD83B80FD97 = _id_E80560F9093CBAC7();
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_ED714BD83B80FD97;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "gulag_cargo_bag";
  _id_78B1D64A94559EDE = _id_99B351B3A052DD2E();
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_78B1D64A94559EDE;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "gulag_end";

  if(!isDefined(_id_6B7CDED46E0D4030))
    _id_6B7CDED46E0D4030 = "br_gulag_winner";

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_6B7CDED46E0D4030;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "gulag_people";
  _id_888E16CA56E7E1E7 = _id_45FF0CC82DF08D72();
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_888E16CA56E7E1E7;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "gulag_ai_num";
  _id_8D5B50153020668E = _id_F613B9DF824F0A2F();
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_8D5B50153020668E;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "gulag_ai_accuracy";
  _id_B2F307125DFF1489 = _id_4EEF2886F50DACCC();
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_B2F307125DFF1489;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "gulag_ai_damage_taken";
  _id_9ED070B5404740D0 = _id_733138B15E0833FF();
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_9ED070B5404740D0;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "gulag_ai_score";
  _id_663572CC85C027C6 = _id_26931875C2AE198D(_id_6B7CDED46E0D4030);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_663572CC85C027C6;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "gulag_ai_stars";
  _id_C8E058E41ED64535 = _id_F9741A6951A9C32E(_id_6B7CDED46E0D4030);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_C8E058E41ED64535;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "gulag_damage_to_ai";
  _id_B8FD3452D5B20B5A = _id_15FF7E5147D7F156();
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_B8FD3452D5B20B5A;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "gulag_pickup_key";
  _id_120FC14A48B4D2F7 = _id_37781CB3598A26E7();
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_120FC14A48B4D2F7;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "gulag_arena_index";
  _id_AFC8D0AB589DB589 = _id_73C92ED8B56292A5();
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_AFC8D0AB589DB589;
  dlog_recordevent("dlog_event_ai_gulag", _id_EC6A81EAC0E4DC61);
}

_id_AA018B2F697301F3() {
  player = self;

  if(!isDefined(player._id_AD6498E5D4B1AE34))
    return -1;

  duration = player._id_AD6498E5D4B1AE34;
  return duration;
}

_id_26945642F76B4740() {
  player = self;

  if(!isDefined(player._id_F42099A4E4FA8BC9))
    return -1;

  duration = gettime() - player._id_F42099A4E4FA8BC9;
  return duration;
}

_id_B48CEF39DBA5574C() {
  player = self;

  if(!isDefined(player._id_F73178C689F257AE))
    return -1;

  return player._id_F73178C689F257AE;
}

_id_86042B32222CF561() {
  player = self;

  if(!isDefined(player._id_D919D1C70719E664))
    return -1;

  return player._id_D919D1C70719E664;
}

_id_0A71D1BECF0F787E() {
  player = self;

  if(!isDefined(player._id_44722265234D31B0))
    return 0;

  return player._id_44722265234D31B0;
}

_id_3FACAB0D974296C1() {
  player = self;

  if(!isDefined(player._id_525C703CFDDAF913))
    return 0;

  return player._id_525C703CFDDAF913;
}

_id_2D65E8E1F1EFA597() {
  player = self;

  if(!isDefined(player._id_DBE1D28321E708DD))
    return 0;

  return player._id_DBE1D28321E708DD;
}

_id_E80560F9093CBAC7() {
  player = self;

  if(!isDefined(player._id_E60B359EB0C2F51D))
    return 0;

  return player._id_E60B359EB0C2F51D;
}

_id_99B351B3A052DD2E() {
  player = self;

  if(!isDefined(player._id_2AC81A7104E85B68))
    return 0;

  return player._id_2AC81A7104E85B68;
}

_id_37781CB3598A26E7() {
  player = self;

  if(!isDefined(player._id_C51BE970BA557AF5))
    return 0;

  return player._id_C51BE970BA557AF5;
}

_id_73C92ED8B56292A5() {
  player = self;

  if(!isDefined(player._id_F8A7B6F177E2F466))
    return -1;

  return player._id_F8A7B6F177E2F466;
}

_id_45FF0CC82DF08D72() {
  player = self;
  arena = _id_2F4344ABDC200E43(player);

  if(!isDefined(arena) || !isDefined(arena._id_B6B01621833467D1))
    return -1;

  return arena._id_B6B01621833467D1;
}

_id_F613B9DF824F0A2F() {
  player = self;
  arena = _id_2F4344ABDC200E43(player);

  if(!isDefined(arena) || !isDefined(arena._id_28A470799D66ECD7))
    return -1;

  return arena._id_28A470799D66ECD7;
}

_id_4EEF2886F50DACCC(_id_6B7CDED46E0D4030) {
  player = self;
  _id_88AF353046E1F521 = 0;

  if(isDefined(player._id_D25277121D9D0A6C) && player._id_D25277121D9D0A6C > 0 && isDefined(player._id_322535086C0890FA) && player._id_322535086C0890FA > 0)
    _id_88AF353046E1F521 = int(player._id_D25277121D9D0A6C / player._id_322535086C0890FA * 100);

  return _id_88AF353046E1F521;
}

_id_26931875C2AE198D(_id_6B7CDED46E0D4030) {
  player = self;

  if(_id_6B7CDED46E0D4030 == "lost")
    return -1;

  _id_663572CC85C027C6 = 0;

  if(isDefined(player._id_0938604A8B5DD849))
    _id_663572CC85C027C6 = player._id_0938604A8B5DD849;

  return _id_663572CC85C027C6;
}

_id_F9741A6951A9C32E(_id_6B7CDED46E0D4030) {
  player = self;

  if(_id_6B7CDED46E0D4030 == "lost")
    return -1;

  _id_C8E058E41ED64535 = 0;

  if(isDefined(player._id_E1ED3A7677EF1776))
    _id_C8E058E41ED64535 = player._id_E1ED3A7677EF1776;

  return _id_C8E058E41ED64535;
}

_id_15FF7E5147D7F156() {
  player = self;

  if(!isDefined(player._id_A6E0850023A9D8F9))
    return 0;

  return player._id_A6E0850023A9D8F9;
}

_id_733138B15E0833FF(_id_6B7CDED46E0D4030) {
  player = self;
  _id_9ED070B5404740D0 = 0;

  if(isDefined(player._id_3A7C9A3E9AA20358) && player._id_3A7C9A3E9AA20358 > 0)
    _id_9ED070B5404740D0 = player._id_3A7C9A3E9AA20358;

  return _id_9ED070B5404740D0;
}

_id_3F18739AE34D9958() {
  player = self;
  player._id_F42099A4E4FA8BC9 = undefined;
  player._id_D919D1C70719E664 = undefined;
  player._id_6D34BF5491AD7588 = undefined;
  player._id_32484CD3B17F16C8 = undefined;
  player._id_F73178C689F257AE = undefined;
  player._id_A6E0850023A9D8F9 = undefined;
  player._id_C51BE970BA557AF5 = undefined;
  player._id_D25277121D9D0A6C = undefined;
  player._id_322535086C0890FA = undefined;
  player._id_F8A7B6F177E2F466 = undefined;
  player._id_B6E41A06D7038B6C = undefined;
  player._id_C1E95B394CA1743D = undefined;
  player._id_15682F516CA4FC00 = undefined;
  player._id_936612C9EEEDD33B = undefined;
  player._id_89BD3A34AC165F4F = undefined;
  player._id_44172449614F0738 = undefined;
  player._id_3A7C9A3E9AA20358 = undefined;
  player._id_0938604A8B5DD849 = undefined;
  player._id_E1ED3A7677EF1776 = undefined;
  player._id_43B2A82936A5E974 = undefined;
  player._id_23B7423E3AD7F311 = undefined;
  player._id_C1057221E17F180B = undefined;
  player._id_AD6498E5D4B1AE34 = undefined;
  player._id_44722265234D31B0 = undefined;
  player._id_525C703CFDDAF913 = undefined;
  player._id_DBE1D28321E708DD = undefined;
  player._id_E60B359EB0C2F51D = undefined;
  player._id_2AC81A7104E85B68 = undefined;
  player._id_B5091EFEFE8E436B = "none";
}

_id_0573DFD8CB86D79F(label, value, point, relativepoint, xoffset, yoffset, color, _id_A8EE906B22FCDB1E) {
  player = self;
  fontscale = 1.5;
  _id_372B658AEA9D2487 = newclienthudelem(player);

  if(istrue(_id_A8EE906B22FCDB1E))
    _id_372B658AEA9D2487.elemtype = "timer";
  else
    _id_372B658AEA9D2487.elemtype = "font";

  _id_372B658AEA9D2487.font = "default";
  _id_372B658AEA9D2487.fontscale = fontscale;
  _id_372B658AEA9D2487.basefontscale = fontscale;
  _id_372B658AEA9D2487.x = 0;
  _id_372B658AEA9D2487.y = 0;
  _id_372B658AEA9D2487.width = 0;
  _id_372B658AEA9D2487.height = int(level.fontheight * fontscale);
  _id_372B658AEA9D2487.xoffset = 0;
  _id_372B658AEA9D2487.yoffset = 0;
  _id_372B658AEA9D2487.children = [];
  _id_372B658AEA9D2487 scripts\mp\hud_util::setparent(level.uiparent);
  _id_372B658AEA9D2487.hidden = 0;
  _id_372B658AEA9D2487.archived = 0;
  _id_372B658AEA9D2487.alpha = 1;
  _id_372B658AEA9D2487 scripts\mp\hud_util::setpoint(point, relativepoint, xoffset, yoffset);

  if(isDefined(label))
    _id_372B658AEA9D2487.label = label;

  if(isDefined(value))
    _id_372B658AEA9D2487 setvalue(value);

  if(isDefined(color))
    _id_372B658AEA9D2487.color = color;

  return _id_372B658AEA9D2487;
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3f30c82464ac941e.gsc
***********************************************/

_id_C6E730535C85608B() {
  if(_id_5C61825C1DCE3571::_id_94B952789D039ABB()) {
    _id_52EED65F3AF6AF91::_id_A6CA80CF4F22E262();
    _id_738ECC23FB96110C::_id_E9BCEEAFA296CB55();
    _id_3FB16506404E5493::_id_237759A1F240D382();
    _id_695A872D7D692EFA::_id_8D0BCD24E525CA55();

    if(getdvarint("dvar_7B0A00B0619A6A77"))
      thread _id_5F15879FE297CE1E::_id_9648C9D5F466804A();

    if(_id_833FF7F6BAA0D39B()) {
      _id_B4775D8FC73BC544();
      thread _id_C53F0344E549EDD5();
    } else {
      thread _id_3831034617F002DA();
      thread _id_9B1630FAB943F7D4();
    }
  }
}

_id_AC4F59436445EE89() {
  if(_id_5C61825C1DCE3571::_id_94B952789D039ABB()) {
    level endon("game_ended");
    _id_3FB16506404E5493::_id_237759A1F240D382();
    _id_846B1875331C3BDB("prematch_done");

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      _id_4245ED6808EE4864 = level.players[_id_AC0E594AC96AA3A8];

      if(!isbot(_id_4245ED6808EE4864) && (!scripts\mp\utility\game::isroundbased() || scripts\mp\utility\game::isfirstround())) {
        _id_4245ED6808EE4864 _id_3B76111381194EA5();
        _id_4245ED6808EE4864 thread _id_DCEA22DAF3384249();
      }
    }

    scripts\mp\utility\disconnect_event_aggregator::_id_5B91DF923C38392B(::_id_F8D105769FEA5844);
  }
}

_id_833FF7F6BAA0D39B() {
  if(getDvar("dvar_12E53040D5281856", "") == "scripted")
    return 1;

  return 0;
}

_id_B4775D8FC73BC544() {
  level _id_72A1BB2FB20CBDBA::_id_D5724A0F0CD63D12();
  level _id_3218324DA667674A::_id_1367788E05985A34();
  level _id_7EBCA6AD7CF516D3::_id_7FA382EBD44AC411();
}

_id_C53F0344E549EDD5() {
  level endon("game_ended");

  while(!isDefined(_id_78DAC680A1677E7C::_id_F765ACF5B7C0C4A1()))
    waitframe();

  player = _id_78DAC680A1677E7C::_id_F765ACF5B7C0C4A1();
  player _id_52EED65F3AF6AF91::_id_5135B05917B91C1B();

  if(!player _id_5C61825C1DCE3571::_id_83FC92D8CE12EC9E(2)) {
    player _meth_DEC6429D4BF84464("MobileFTUEOrientationTutorialTooltip");
    player._id_56F36FD7CC3D8098 = 1;
    _id_DD61DE0DD57C1324 = _id_38C7426A6D5F6FD4::_id_A78DEBAC92A88923();
    _id_38C7426A6D5F6FD4::_id_805F1F0B22CA5026(_id_DD61DE0DD57C1324);
    player _id_3FB16506404E5493::_id_B1FF196D3899D7C4();
    thread _id_7EBCA6AD7CF516D3::_id_C53F0344E549EDD5();
  } else {}
}

_id_3831034617F002DA() {
  level endon("game_ended");
  level endon("prematch_done");

  for(;;) {
    level waittill("connected", player);

    if(isPlayer(player) && !isbot(player)) {
      player._id_F4E78B41C7D793A2 = !_id_09E8CCAD6488211B::_id_89E1A31BD1DE0567() || !player _id_09E8CCAD6488211B::_id_EE43F827080726B1();
      player._id_10844DDCB34694EE = player _id_09E8CCAD6488211B::_id_70781ACE6E552A59();
    }
  }
}

_id_9B1630FAB943F7D4() {
  level endon("game_ended");
  thread _id_52EED65F3AF6AF91::_id_1339FDDEE137DCAE();
  _id_3FB16506404E5493::_id_767631661C482A58("wait_for_prematch_started");
  _id_846B1875331C3BDB("br_ready_to_jump");
  _id_3FB16506404E5493::_id_767631661C482A58("wait_for_prematch_finished");
  _id_7AE03E2F9290CA57::init();
  _id_3FB16506404E5493::_id_767631661C482A58("contextual_tips_initialized");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    _id_4245ED6808EE4864 = level.players[_id_AC0E594AC96AA3A8];

    if(!isbot(_id_4245ED6808EE4864)) {
      _id_4245ED6808EE4864 _id_3FB16506404E5493::_id_42716045CDD993D1("ftue_training_match_initializing_player");
      _id_4245ED6808EE4864 _id_52EED65F3AF6AF91::_id_5135B05917B91C1B();
      _id_4245ED6808EE4864 _id_AF7943276538A8F2();
    }
  }

  scripts\mp\utility\disconnect_event_aggregator::_id_5B91DF923C38392B(::_id_F8D105769FEA5844);
}

_id_846B1875331C3BDB(eventname) {
  scripts\mp\flags::_id_1240434F4201AC9D(eventname);

  while(!isDefined(level.players))
    waitframe();
}

_id_AF7943276538A8F2() {
  self endon("disconnect");

  if(!scripts\mp\utility\game::onlinestatsenabled()) {
    _id_3FB16506404E5493::_id_547D18417766045A(1);
    return;
  }

  if(!_id_5C61825C1DCE3571::_id_83FC92D8CE12EC9E(2)) {
    _id_3FB16506404E5493::_id_547D18417766045A(2);
    return;
  }

  _id_CDA7F1D4F4AD320F = _id_09E8CCAD6488211B::_id_EE43F827080726B1();

  if(_id_CDA7F1D4F4AD320F)
    self._id_56F36FD7CC3D8098 = 1;

  _id_3B76111381194EA5();
  childthread _id_C82A99FB9823B6E8();
}

_id_C82A99FB9823B6E8() {
  self _meth_DEC6429D4BF84464("MobileFTUEUnScriptedMatchTooltip");

  if(!isDefined(self._id_FA35B4A136B27ACD))
    self._id_FA35B4A136B27ACD = !_id_5C61825C1DCE3571::_id_523A12B7460EBD22();

  if(getdvarint("dvar_0E6B31B49C864BA1", 1))
    childthread _id_7AE03E2F9290CA57::_id_724DE61C03C5BAFF();

  thread _id_DCEA22DAF3384249();
}

_id_846C531B6E647948(_id_AA9F4C033D62BC8A) {
  return _id_AA9F4C033D62BC8A != 3 && _id_AA9F4C033D62BC8A != 5;
}

_id_3B76111381194EA5() {
  for(progress = 3; progress <= 12; progress++) {
    if(_id_6E6A5CA23B27A0F7(progress)) {
      if(progress == 3)
        self._id_B0F02709599E955C = 1;

      break;
    }
  }

  _id_5C61825C1DCE3571::_id_312E1BABFFBDF863();
}

_id_6E6A5CA23B27A0F7(_id_AA9F4C033D62BC8A) {
  if(_id_AA9F4C033D62BC8A < 3)
    return 0;

  if(_id_AA9F4C033D62BC8A == 4 || _id_AA9F4C033D62BC8A == 6)
    return 0;

  if(_id_5C61825C1DCE3571::_id_83FC92D8CE12EC9E(_id_AA9F4C033D62BC8A))
    return 0;

  _id_93B9CD6D97804488 = 1;
  _id_F976DA02B0A7BC75 = _id_846C531B6E647948(_id_AA9F4C033D62BC8A);

  if(_id_F976DA02B0A7BC75 && self getprivatepartysize() > 1) {
    _id_93B9CD6D97804488 = getdvarint("dvar_C8E3D38B6E1B91F8", 1) == 0;

    if(_id_93B9CD6D97804488)
      _id_93B9CD6D97804488 = getdvarint("dvar_D9D26A804ED1A1AA", 1) == 0 || !self isfireteamleader();
  }

  if(_id_93B9CD6D97804488)
    _id_5C61825C1DCE3571::_id_E05669C955312C22(_id_AA9F4C033D62BC8A, 1);

  return 1;
}

_id_DCEA22DAF3384249() {
  self endon("disconnect");
  _id_A73346037EB9B85F();

  if(_id_1C06712ECEAF01E5())
    _id_DBCDDDAC16CC8D7B();
}

_id_1C06712ECEAF01E5() {
  ent = spawnStruct();
  childthread scripts\engine\utility::waittill_string_no_endon_death("br_player_aar_data_set", ent);
  childthread scripts\engine\utility::waittill_string_no_endon_death("afk_disconnection_imminent", ent);
  level childthread scripts\engine\utility::waittill_string_no_endon_death("game_ended", ent);
  ent waittill("returned", msg);
  ent notify("die");

  if(msg == "game_ended" && scripts\mp\utility\game::isroundbased() && !scripts\mp\utility\game::waslastround())
    return 0;
  else
    return 1;
}

_id_F8D105769FEA5844(player) {
  if(!isbot(player) && isPlayer(player))
    player _id_DBCDDDAC16CC8D7B();
}

_id_DBCDDDAC16CC8D7B() {
  if(isDefined(self._id_28316FF8D673DC35)) {
    return;
  }
  self._id_28316FF8D673DC35 = 1;
  _id_FF9358B3AC96C7AB = gettime();
  _id_FF9358B3AC96C7AB = scripts\mp\matchdata::gettimefrommatchstart(_id_FF9358B3AC96C7AB) * 0.001;
  _id_FF9358B3AC96C7AB = int(_id_FF9358B3AC96C7AB);
  _id_5C61825C1DCE3571::_id_02F80E3CA1B2374A(_id_FF9358B3AC96C7AB);
  _id_657384F0A8678377 = _id_5C61825C1DCE3571::_id_0DA8CF8DBDB763AE();
  _id_3FB16506404E5493::_id_05B53803303E63EB(_id_657384F0A8678377, 0);
}

_id_A73346037EB9B85F() {
  _id_657384F0A8678377 = _id_5C61825C1DCE3571::_id_0DA8CF8DBDB763AE();
  _id_3FB16506404E5493::_id_86403E1B6EC0B2F6(_id_657384F0A8678377);
}
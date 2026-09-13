/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7ae03e2f9290ca57.gsc
***********************************************/

init() {
  _id_0497D0163E00BAA1::_id_A63069A72C46F64B();
  level _id_FA1F5F6731DF7FEA();
  level _id_F450E760A53CA63C();
  level _id_5C61825C1DCE3571::_id_2195503B0DCC12C0();
}

_id_FA1F5F6731DF7FEA() {
  level._id_305547D6DE59EBA4 = spawnStruct();
  level._id_305547D6DE59EBA4._id_1A60753F1CE4E8A4 = 1000;
  level._id_305547D6DE59EBA4._id_988ED2B0FC9199B8 = [];
  level._id_305547D6DE59EBA4._id_DABA424D7F945348 = [];
  level._id_305547D6DE59EBA4._id_0DA1E4DED7DB0B78 = [];
  _id_EFFEC5E680D95771();
  level _id_8A4307513B99D156();
}

_id_758312D1E1139963() {
  foreach(key, _id_FF0F9C5EBEF8424E in level._id_305547D6DE59EBA4._id_988ED2B0FC9199B8)
  self._id_0657F5A0D17435BC._id_0AF8D4CC519C65DE[key] = _id_5C61825C1DCE3571::_id_5F50AE7BFF599E0A(_id_21E002F62EB76644::_id_B4641AE08979F8CE(key));
}

_id_916A7D987CFA6BCE() {
  if(getdvarint("dvar_4AA709AFC06C1732", 1) == 0) {
    return;
  }
  _id_7F58749063130FFB = self._id_BAB8A83285B78528;

  foreach(key, _id_FF0F9C5EBEF8424E in level._id_305547D6DE59EBA4._id_988ED2B0FC9199B8) {
    if(!scripts\engine\utility::array_contains(_id_FF0F9C5EBEF8424E._id_2297E189E2EB2818, -1) && !scripts\engine\utility::array_contains(_id_FF0F9C5EBEF8424E._id_2297E189E2EB2818, _id_7F58749063130FFB)) {
      _id_E775591921435AC7 = scripts\engine\utility::array_find(self._id_B49211DA75D1F882, key);
      self._id_B49211DA75D1F882 = scripts\engine\utility::array_remove_index(self._id_B49211DA75D1F882, _id_E775591921435AC7);
    }
  }
}

_id_724DE61C03C5BAFF() {
  level endon("game_ended");
  self endon("disconnect");
  self._id_0657F5A0D17435BC = spawnStruct();
  self._id_0657F5A0D17435BC._id_11DDFA68D88BF6E0 = 0;
  self._id_5A532B3D41B19C7A = [];
  self._id_802DE948F5F74D91 = [];
  self._id_0FFDDBA74F404A30 = [];
  self._id_8F1C3552AEDDAFFE = [];
  self._id_0657F5A0D17435BC._id_0AF8D4CC519C65DE = [];

  foreach(key, _id_FF0F9C5EBEF8424E in level._id_305547D6DE59EBA4._id_988ED2B0FC9199B8)
  self._id_0657F5A0D17435BC._id_0AF8D4CC519C65DE[key] = 0;

  _id_348E4E7E77FD824D::_id_C3D4E6976E184EC2(2);
  _id_348E4E7E77FD824D::_id_ECC429915026F615(2);
  self._id_0657F5A0D17435BC._id_25D8F562F9F2DAA3 = spawnStruct();
  self._id_0657F5A0D17435BC._id_6D2384744119499A = spawnStruct();
  self._id_0657F5A0D17435BC._id_6D2384744119499A._id_CCCAB5C50E0F393B = 0;
  self._id_0657F5A0D17435BC._id_1E6270FC42010EDD = spawnStruct();
  self._id_0657F5A0D17435BC._id_9FD058151789294E = spawnStruct();
  self._id_0657F5A0D17435BC._id_9FD058151789294E._id_AFC287EEC64AEB6E = 0;
  self._id_0657F5A0D17435BC._id_0480AA6483C54887 = spawnStruct();
  self._id_0657F5A0D17435BC._id_0480AA6483C54887._id_2A182E08ECBC0BD6 = 0;
  self._id_0657F5A0D17435BC._id_8907FAAF3879C3A0 = spawnStruct();
  self._id_0657F5A0D17435BC._id_8907FAAF3879C3A0._id_36FD50D2F2947A0D = 0;
  self._id_0657F5A0D17435BC._id_8907FAAF3879C3A0._id_881877F6B4DFAC21 = 1;
  self._id_0657F5A0D17435BC._id_9DAF1075AF0426FA = spawnStruct();
  self._id_0657F5A0D17435BC._id_9DAF1075AF0426FA._id_3AF3CD0524977042 = 1;
  self._id_0657F5A0D17435BC._id_F028B7EEE8D5AC0D = spawnStruct();
  self._id_0657F5A0D17435BC._id_F028B7EEE8D5AC0D._id_40AE770E8C262522 = 0;
  self._id_0657F5A0D17435BC._id_F028B7EEE8D5AC0D._id_78F9776E5D16BCFB = "";
  self._id_0657F5A0D17435BC._id_EBF862078B683A7A = spawnStruct();
  self._id_0657F5A0D17435BC._id_40834C928484EDFB = spawnStruct();
  self._id_0657F5A0D17435BC._id_40834C928484EDFB._id_654C850C2646F8E0 = 0;
  self._id_0657F5A0D17435BC._id_40834C928484EDFB._id_55D2955394D9DA6F = 0;
  self._id_0657F5A0D17435BC._id_40834C928484EDFB._id_2A182E08ECBC0BD6 = 0;
  self._id_0657F5A0D17435BC._id_40834C928484EDFB._id_FB1ACFDA55750369 = 0;
  self._id_0657F5A0D17435BC._id_40834C928484EDFB._id_78F9776E5D16BCFB = "";
  self._id_0657F5A0D17435BC._id_82CAA11345C69977 = spawnStruct();
  self._id_0657F5A0D17435BC._id_82CAA11345C69977._id_3AF3CD0524977042 = 1;
  self._id_0657F5A0D17435BC._id_CD0CE7CFECDE4C03 = spawnStruct();
  self._id_0657F5A0D17435BC._id_CD0CE7CFECDE4C03._id_EA2FA2C80FEAD697 = 0;
  self._id_0657F5A0D17435BC._id_CD0CE7CFECDE4C03._id_78F9776E5D16BCFB = "";
  self._id_0657F5A0D17435BC._id_108D73DDF65AA72C = spawnStruct();
  self._id_0657F5A0D17435BC._id_108D73DDF65AA72C._id_78F9776E5D16BCFB = "";
  self._id_0657F5A0D17435BC._id_1750EA2A0EE732D8 = spawnStruct();
  self._id_0657F5A0D17435BC._id_1750EA2A0EE732D8._id_10D87FC7594B8040 = 0;
  self._id_0657F5A0D17435BC._id_1750EA2A0EE732D8._id_78F9776E5D16BCFB = "";
  self._id_0657F5A0D17435BC._id_E54398F75467B105 = spawnStruct();
  self._id_0657F5A0D17435BC._id_F7C70704371233CD = 1;
  self._id_0657F5A0D17435BC._id_ABA64102EDBF2CD0 = 1;
  self._id_0657F5A0D17435BC._id_4CB22D8DDA2E06A9 = undefined;
  self._id_0657F5A0D17435BC._id_BDBB54412EEFF8E7 = "";
  self._id_0657F5A0D17435BC._id_3BC7A9DEFA307C4C = "";
  level._id_DBF4D97004E64BD5 = spawnStruct();
  level._id_DBF4D97004E64BD5._id_744254A0A817FF39 = spawnStruct();
  level._id_DBF4D97004E64BD5._id_744254A0A817FF39.sound = 1;
  level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03 = spawnStruct();
  level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03.sound = 1;
  self._id_B49211DA75D1F882 = spawnStruct();
  self._id_B49211DA75D1F882 = level._id_305547D6DE59EBA4._id_6D061CC60360CF78;
  _id_8C7EB4BB28AE167F();
  _id_7A1391F264AF1243();
  _id_916A7D987CFA6BCE();
  _id_758312D1E1139963();
  scripts\mp\flags::gameflagwait("br_ready_to_jump");
  childthread _id_8385F0514B5F730D();
  childthread _id_42C82DBB9D1FC59D();
  childthread _id_B72914D470E29219();
  childthread _id_62D8928848D3EA16();
  childthread _id_65CB702777C34D77();
  level scripts\common\ui::lui_registercallback("force_tooltip_execute", ::_id_1E5C3C919D3F771D);
}

_id_1E5C3C919D3F771D(_id_FE24673A87802A11) {
  level endon("game_ended");
  self endon("disconnect");

  if(self._id_0657F5A0D17435BC._id_5E4D29A54D7EDDF6 != "") {
    _id_52EED65F3AF6AF91::_id_7FD621B8BA80E652();
    self notify("currentContextualTipAborted");
    waitframe();
  }

  _id_8852BFB815524D4B = _id_21E002F62EB76644::_id_C80CF062684CDFE0(_id_FE24673A87802A11);
  childthread _id_58C9AC5C1AAD6962(_id_8852BFB815524D4B);
  self._id_0657F5A0D17435BC._id_D445AAB904364EE1 = 1;
  self waittill("currentContextualTipCompleted");
  self._id_0657F5A0D17435BC._id_D445AAB904364EE1 = 0;
}

_id_6DF0C3EFD3B8A03A() {
  foreach(_id_FF0F9C5EBEF8424E in level._id_305547D6DE59EBA4._id_988ED2B0FC9199B8) {
    if(isDefined(_id_FF0F9C5EBEF8424E._id_C6228A01683251AE) && _id_FF0F9C5EBEF8424E._id_C6228A01683251AE)
      return 1;
  }

  return 0;
}

_id_43C745BC0C2A589E() {
  foreach(_id_FF0F9C5EBEF8424E in level._id_305547D6DE59EBA4._id_988ED2B0FC9199B8) {
    if(isDefined(_id_FF0F9C5EBEF8424E._id_BCE08F4BE4261BC4) && _id_FF0F9C5EBEF8424E._id_BCE08F4BE4261BC4)
      return 1;
  }

  return 0;
}

_id_42C82DBB9D1FC59D() {
  while(_id_6DF0C3EFD3B8A03A()) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      if(!isalliedsentient(level.players[_id_AC0E594AC96AA3A8], self) && distancesquared(level.players[_id_AC0E594AC96AA3A8].origin, self.origin) <= 7590025) {
        self._id_5A532B3D41B19C7A = scripts\engine\utility::array_add_safe(self._id_5A532B3D41B19C7A, level.players[_id_AC0E594AC96AA3A8]);

        if(isalive(level.players[_id_AC0E594AC96AA3A8]))
          self._id_802DE948F5F74D91 = scripts\engine\utility::array_add_safe(self._id_802DE948F5F74D91, level.players[_id_AC0E594AC96AA3A8]);
      }
    }

    wait 1;
    self._id_5A532B3D41B19C7A = undefined;
    self._id_802DE948F5F74D91 = undefined;
  }
}

_id_B72914D470E29219() {
  while(_id_43C745BC0C2A589E()) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      if(isalliedsentient(level.players[_id_AC0E594AC96AA3A8], self) && distancesquared(level.players[_id_AC0E594AC96AA3A8].origin, self.origin) <= 1000000 && level.players[_id_AC0E594AC96AA3A8] != self)
        self._id_0FFDDBA74F404A30 = scripts\engine\utility::array_add_safe(self._id_0FFDDBA74F404A30, level.players[_id_AC0E594AC96AA3A8]);
    }

    wait 1;
    self._id_0FFDDBA74F404A30 = undefined;
  }
}

_id_62D8928848D3EA16() {
  while(_id_43C745BC0C2A589E()) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      if(isalliedsentient(level.players[_id_AC0E594AC96AA3A8], self) && level.players[_id_AC0E594AC96AA3A8] != self)
        self._id_8F1C3552AEDDAFFE = scripts\engine\utility::array_add_safe(self._id_8F1C3552AEDDAFFE, level.players[_id_AC0E594AC96AA3A8]);
    }

    wait 1;
    self._id_8F1C3552AEDDAFFE = undefined;
  }
}

_id_8C7EB4BB28AE167F() {
  self._id_BAB8A83285B78528 = _id_5C61825C1DCE3571::_id_7FBC76F1AEFC8FC5();
}

_id_65CB702777C34D77() {
  _id_34EF8D1070784598 = 0;
  thread _id_EA69EECEC1A8FD38();

  for(;;) {
    self._id_0657F5A0D17435BC._id_5E4D29A54D7EDDF6 = self._id_B49211DA75D1F882[_id_34EF8D1070784598];

    if(!_id_52EED65F3AF6AF91::_id_E4D0F9EFE9C2BCA1()) {
      wait 0.05;
      continue;
    }

    _id_58C9AC5C1AAD6962 = _id_CEEBD29C89F314D5(self._id_0657F5A0D17435BC._id_5E4D29A54D7EDDF6);

    if(_id_58C9AC5C1AAD6962) {
      childthread _id_58C9AC5C1AAD6962(self._id_0657F5A0D17435BC._id_5E4D29A54D7EDDF6);
      childthread _id_51547E875B8DDFF4(self._id_0657F5A0D17435BC._id_5E4D29A54D7EDDF6);
      _id_0EAEF8E75AAC04BF = scripts\engine\utility::waittill_any_return_2("currentContextualTipCompleted", "currentContextualTipAborted");
      self._id_0657F5A0D17435BC._id_0AF8D4CC519C65DE[self._id_0657F5A0D17435BC._id_5E4D29A54D7EDDF6] = 1;
      self._id_0657F5A0D17435BC._id_11DDFA68D88BF6E0++;

      if(isDefined(_id_0EAEF8E75AAC04BF)) {
        if(_id_0EAEF8E75AAC04BF == "currentContextualTipCompleted") {
          _id_52EED65F3AF6AF91::_id_143BBA0D625B5C0C("TIP COMPLETED: " + self._id_0657F5A0D17435BC._id_5E4D29A54D7EDDF6, 1);
          _id_5C61825C1DCE3571::_id_A25D14ECF8DCB49E(_id_21E002F62EB76644::_id_B4641AE08979F8CE(self._id_0657F5A0D17435BC._id_5E4D29A54D7EDDF6));

          if(self._id_0657F5A0D17435BC._id_11DDFA68D88BF6E0 >= level._id_305547D6DE59EBA4._id_1A60753F1CE4E8A4) {
            break;
          }
        } else
          _id_52EED65F3AF6AF91::_id_143BBA0D625B5C0C("TIP ABORTED: " + self._id_0657F5A0D17435BC._id_5E4D29A54D7EDDF6, 1);
      } else {
        _id_52EED65F3AF6AF91::_id_143BBA0D625B5C0C("TIP ABORTED(dead): " + self._id_0657F5A0D17435BC._id_5E4D29A54D7EDDF6, 1);
        _id_C90213A6575F2880 = _id_52EED65F3AF6AF91::_id_DD89477F4A365B0F();
        _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20(_id_C90213A6575F2880, 0, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
      }

      _id_34EF8D1070784598 = 0;
      self._id_0657F5A0D17435BC._id_5E4D29A54D7EDDF6 = "";
      _id_86430E66B500B5C9(12);
      _id_F52F9987E3576615();
      continue;
    }

    _id_34EF8D1070784598++;

    if(_id_34EF8D1070784598 >= self._id_B49211DA75D1F882.size) {
      _id_34EF8D1070784598 = 0;
      _id_86430E66B500B5C9(0.05);
      _id_F52F9987E3576615();
    }
  }
}

_id_EA69EECEC1A8FD38() {
  _id_48F2647A5D71AE8D = 0;

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    if(self.pers["wins"] == 1) {
      break;
    }

    _id_3ABC16C12E768D21 = self getclientomnvar("ui_br_squad_eliminated_active") || self getclientomnvar("post_game_state");

    if(isDefined(_id_3ABC16C12E768D21) && _id_48F2647A5D71AE8D != _id_3ABC16C12E768D21) {
      _id_48F2647A5D71AE8D = _id_3ABC16C12E768D21;
      break;
    }

    waitframe();
  }

  _id_C90213A6575F2880 = _id_52EED65F3AF6AF91::_id_DD89477F4A365B0F();

  if(!isDefined(_id_C90213A6575F2880)) {
    return;
  }
  if(isalive(self) && _id_C90213A6575F2880 != "")
    _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20(_id_C90213A6575F2880, 0, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);

  _id_52EED65F3AF6AF91::_id_7FD621B8BA80E652();
}

_id_F52F9987E3576615() {
  for(;;) {
    waitframe();
    _id_1B7F5108008D55B6 = self._id_0657F5A0D17435BC._id_5E4D29A54D7EDDF6 != "Gulag" && self._id_0657F5A0D17435BC._id_3CEC2BC7BC141BED["GulagStarted"].isactive && !self._id_0657F5A0D17435BC._id_0AF8D4CC519C65DE["Gulag"];

    if(_id_1B7F5108008D55B6)
      self notify("currentContextualTipAborted");

    if(_id_1B7F5108008D55B6 || gettime() > self._id_0657F5A0D17435BC._id_04F9CD1CF342B3F1) {
      break;
    }
  }
}

_id_86430E66B500B5C9(time) {
  self._id_0657F5A0D17435BC._id_04F9CD1CF342B3F1 = gettime() + time * 1000;
}

_id_CEEBD29C89F314D5(_id_C0E68595C1877B35) {
  _id_FF0F9C5EBEF8424E = level._id_305547D6DE59EBA4._id_988ED2B0FC9199B8[_id_C0E68595C1877B35];

  if(self._id_0657F5A0D17435BC._id_0AF8D4CC519C65DE[_id_C0E68595C1877B35])
    return 0;

  result = 1;

  foreach(_id_46260B6EEE9C6E62 in _id_FF0F9C5EBEF8424E._id_BEE13A83D8831F51) {
    if(!isDefined(_id_46260B6EEE9C6E62.func)) {
      continue;
    }
    _id_5F735033C6961BD5 = level._id_06EDC807B8A61C73[_func_1823FF50BB28148D(_id_46260B6EEE9C6E62.func)];

    if(!isDefined(_id_5F735033C6961BD5)) {
      continue;
    }
    if(isDefined(_id_46260B6EEE9C6E62.params))
      _id_CF5324F504AC4A52 = self[[_id_5F735033C6961BD5]](_id_46260B6EEE9C6E62.params);
    else
      _id_CF5324F504AC4A52 = self[[_id_5F735033C6961BD5]]();

    result = result && _id_CF5324F504AC4A52;
  }

  return result;
}

_id_51547E875B8DDFF4(_id_C0E68595C1877B35) {
  waitframe();
  _id_FF0F9C5EBEF8424E = level._id_305547D6DE59EBA4._id_988ED2B0FC9199B8[_id_C0E68595C1877B35];
  self endon("currentContextualTipCompleted");
  self endon("currentContextualTipAborted");
  self endon("currentContextualTipCompleted");
  self endon("currentContextualTipAborted");

  if(isDefined(_id_FF0F9C5EBEF8424E._id_A76969DCC6F15D80)) {
    _id_C5209D14BF481E54 = 0;

    while(!_id_C5209D14BF481E54) {
      foreach(_id_46260B6EEE9C6E62 in _id_FF0F9C5EBEF8424E._id_A76969DCC6F15D80) {
        if(isDefined(_id_46260B6EEE9C6E62.params))
          _id_ACEA8891C2BE0D5C = self[[level._id_06EDC807B8A61C73[_func_1823FF50BB28148D(_id_46260B6EEE9C6E62.func)]]](_id_46260B6EEE9C6E62.params);
        else
          _id_ACEA8891C2BE0D5C = self[[level._id_06EDC807B8A61C73[_func_1823FF50BB28148D(_id_46260B6EEE9C6E62.func)]]]();

        if(istrue(_id_ACEA8891C2BE0D5C)) {
          if(isDefined(_id_46260B6EEE9C6E62.action))
            self[[level._id_06EDC807B8A61C73[_func_1823FF50BB28148D(_id_46260B6EEE9C6E62.action)]]]();

          _id_C5209D14BF481E54 = 1;
          break;
        }
      }

      waitframe();
    }
  }
}

_id_58C9AC5C1AAD6962(_id_C0E68595C1877B35) {
  waitframe();
  self endon("currentContextualTipCompleted");
  self endon("currentContextualTipAborted");
  _id_52EED65F3AF6AF91::_id_143BBA0D625B5C0C(" TIP LAUNCHED: " + self._id_0657F5A0D17435BC._id_5E4D29A54D7EDDF6, 0);
  self childthread[[level._id_06EDC807B8A61C73[_func_1823FF50BB28148D(level._id_305547D6DE59EBA4._id_988ED2B0FC9199B8[_id_C0E68595C1877B35].function)]]]();
}

_id_D44CF044202D9C11(_id_A1E3A34A896A29DC) {
  _id_5CF0C359F6544475 = [];
  _id_1976C1C0FB965CAA = 1;
  _id_977F24E61599CBBA = tablelookupgetnumrows("mobile/UnpausedFTUEStepsData.csv");
  _id_24C416453B6F670C = tablelookupgetnumcols("mobile/UnpausedFTUEStepsData.csv");

  for(_id_09DD5D9E57E7E36D = 1; _id_09DD5D9E57E7E36D < _id_977F24E61599CBBA; _id_09DD5D9E57E7E36D++) {
    _id_A1E3A34A896A29DC[_id_09DD5D9E57E7E36D] = spawnStruct();
    _id_50FEA443D3576EFB = tablelookupistringbyrow("mobile/UnpausedFTUEStepsData.csv", _id_09DD5D9E57E7E36D, 0);

    for(_id_E78EC0335B297403 = 1; _id_E78EC0335B297403 < _id_24C416453B6F670C; _id_E78EC0335B297403++)
      scripts\engine\utility::array_add(_id_A1E3A34A896A29DC[_id_09DD5D9E57E7E36D][_id_50FEA443D3576EFB], tablelookupbyrow("mobile/UnpausedFTUEStepsData.csv", _id_09DD5D9E57E7E36D, _id_E78EC0335B297403));
  }

  return _id_5CF0C359F6544475;
}

_id_8A4307513B99D156() {
  level._id_305547D6DE59EBA4._id_988ED2B0FC9199B8 = _id_21E002F62EB76644::_id_09FCC9920BA3DBE3();
  level._id_305547D6DE59EBA4._id_988ED2B0FC9199B8 = _id_06FB77E285E34771(level._id_305547D6DE59EBA4._id_988ED2B0FC9199B8);
  level._id_305547D6DE59EBA4._id_6D061CC60360CF78 = _id_F5A2921BF524C600(level._id_305547D6DE59EBA4._id_988ED2B0FC9199B8, ::_id_3C23EB60C9A218C6);
}

_id_06FB77E285E34771(_id_988ED2B0FC9199B8) {
  if(!isDefined(_id_988ED2B0FC9199B8)) {
    return;
  }
  _id_F30534F50DB0AF8B = [];

  foreach(key, item in _id_988ED2B0FC9199B8) {
    if(getdvarint(_func_2EF675C13CA1C4AF("dvar_B04566E984B5CAD4", _func_0F28FD66285FA2C9(key))) == 1)
      _id_F30534F50DB0AF8B = scripts\engine\utility::array_add_safe(_id_F30534F50DB0AF8B, key);
  }

  if(_id_F30534F50DB0AF8B.size > 0) {
    foreach(key in _id_F30534F50DB0AF8B)
    _id_988ED2B0FC9199B8 = scripts\engine\utility::array_remove_key(_id_988ED2B0FC9199B8, key);
  }

  return _id_988ED2B0FC9199B8;
}

_id_3C23EB60C9A218C6(_id_4568BDF6C58F6615, _id_4568BAF6C58F5F7C) {
  return _id_4568BDF6C58F6615.priority >= _id_4568BAF6C58F5F7C.priority;
}

_id_F5A2921BF524C600(array, _id_D35FC50E2F1F14DF) {
  _id_8E8176E676AD1FCC = [];

  foreach(key, item in array)
  _id_8E8176E676AD1FCC = scripts\engine\utility::array_add_safe(_id_8E8176E676AD1FCC, key);

  for(_id_AC0E5C4AC96AAA41 = 1; _id_AC0E5C4AC96AAA41 < _id_8E8176E676AD1FCC.size; _id_AC0E5C4AC96AAA41++) {
    key = _id_8E8176E676AD1FCC[_id_AC0E5C4AC96AAA41];

    for(_id_AC0E594AC96AA3A8 = _id_AC0E5C4AC96AAA41 - 1; _id_AC0E594AC96AA3A8 >= 0 && ![[_id_D35FC50E2F1F14DF]](array[_id_8E8176E676AD1FCC[_id_AC0E594AC96AA3A8]], array[key]); _id_AC0E594AC96AA3A8--)
      _id_8E8176E676AD1FCC[_id_AC0E594AC96AA3A8 + 1] = _id_8E8176E676AD1FCC[_id_AC0E594AC96AA3A8];

    _id_8E8176E676AD1FCC[_id_AC0E594AC96AA3A8 + 1] = key;
  }

  return _id_8E8176E676AD1FCC;
}

_id_F450E760A53CA63C() {
  level._id_305547D6DE59EBA4._id_DABA424D7F945348["GulagStarted"] = spawnStruct();
  level._id_305547D6DE59EBA4._id_DABA424D7F945348["GulagStarted"].function = ::_id_D8D5458FC84E29FE;
  level._id_305547D6DE59EBA4._id_DABA424D7F945348["GulagStarted"]._id_942FD5E571E7F0F5 = 5;
  level._id_305547D6DE59EBA4._id_DABA424D7F945348["GulagStarted"]._id_9F0B8EB8B0D1DEE2 = "IsGulagStarted";
  level._id_305547D6DE59EBA4._id_DABA424D7F945348["GulagStarted"]._id_E9F265C1BA0AAEBC = ::_id_0E7F53A3E2391D23;
  level._id_305547D6DE59EBA4._id_DABA424D7F945348["GulagStarted"]._id_B8658683D6717273 = "gulagFinished";
  level._id_305547D6DE59EBA4._id_DABA424D7F945348["EnemiesInMinimap"] = spawnStruct();
  level._id_305547D6DE59EBA4._id_DABA424D7F945348["EnemiesInMinimap"].function = ::_id_5FCD813A97044D45;
  level._id_305547D6DE59EBA4._id_DABA424D7F945348["EnemiesInMinimap"]._id_942FD5E571E7F0F5 = 5;
  level._id_305547D6DE59EBA4._id_DABA424D7F945348["EnemiesInMinimap"]._id_9F0B8EB8B0D1DEE2 = "AreEnemiesInMinimap";
  level._id_305547D6DE59EBA4._id_DABA424D7F945348["PlayerShotByEnemy"] = spawnStruct();
  level._id_305547D6DE59EBA4._id_DABA424D7F945348["PlayerShotByEnemy"].function = ::_id_2F0DA1E9DA7ED50D;
  level._id_305547D6DE59EBA4._id_DABA424D7F945348["PlayerShotByEnemy"]._id_942FD5E571E7F0F5 = 10;
  level._id_305547D6DE59EBA4._id_DABA424D7F945348["PlayerShotByEnemy"]._id_9F0B8EB8B0D1DEE2 = "IsPlayerShotByEnemy";
}

_id_7A1391F264AF1243() {
  self._id_0657F5A0D17435BC._id_3CEC2BC7BC141BED = [];

  foreach(key, _id_0A40C0189DE0033C in level._id_305547D6DE59EBA4._id_DABA424D7F945348) {
    self._id_0657F5A0D17435BC._id_3CEC2BC7BC141BED[key] = spawnStruct();
    self._id_0657F5A0D17435BC._id_3CEC2BC7BC141BED[key].isactive = 0;
  }
}

_id_8385F0514B5F730D() {
  foreach(key, _id_0A40C0189DE0033C in level._id_305547D6DE59EBA4._id_DABA424D7F945348)
  childthread _id_26D4ABDFB928D4FD(_id_0A40C0189DE0033C, key);
}

_id_26D4ABDFB928D4FD(_id_0A40C0189DE0033C, key) {
  for(;;) {
    self._id_0657F5A0D17435BC._id_3CEC2BC7BC141BED[key].isactive = 0;
    self childthread[[_id_0A40C0189DE0033C.function]](_id_0A40C0189DE0033C);
    self waittill(_id_0A40C0189DE0033C._id_9F0B8EB8B0D1DEE2);
    self._id_0657F5A0D17435BC._id_3CEC2BC7BC141BED[key].isactive = 1;

    if(isDefined(_id_0A40C0189DE0033C._id_E9F265C1BA0AAEBC)) {
      self childthread[[_id_0A40C0189DE0033C._id_E9F265C1BA0AAEBC]]();
      self waittill(_id_0A40C0189DE0033C._id_B8658683D6717273);
    }

    if(isDefined(_id_0A40C0189DE0033C._id_942FD5E571E7F0F5))
      wait(_id_0A40C0189DE0033C._id_942FD5E571E7F0F5);
  }
}

_id_578B87D7EB32541C() {
  _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("useZipLine1Tip");
  ascenders = _id_23A85A6F3340BF6F::_id_E89C4A695A431598(self, 5000, 2250000);
  self._id_0657F5A0D17435BC._id_82CAA11345C69977._id_48476CF9CF37777E = _id_23A85A6F3340BF6F::_id_E09FE43DABD5E4CF(self, ascenders);
  _id_B06DEC4DBF57B06B();
  childthread _id_5C154FBF6A4FF505();
}

_id_5C154FBF6A4FF505() {
  while(self._id_0657F5A0D17435BC._id_82CAA11345C69977._id_3AF3CD0524977042) {
    _id_AE695132BEFABC19 = distance2dsquared(self._id_0657F5A0D17435BC._id_82CAA11345C69977._id_48476CF9CF37777E.origin, self.origin);

    if(_id_AE695132BEFABC19 < 10000 && self._id_0657F5A0D17435BC._id_82CAA11345C69977._id_ABA64102EDBF2CD0) {
      _id_52EED65F3AF6AF91::_id_7FD621B8BA80E652();
      _id_A1A89AEB095402F2();
      _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("useZipLine2Tip");
    }

    if(_id_AE695132BEFABC19 >= 10000 && _id_AE695132BEFABC19 <= 2250000 && !self._id_0657F5A0D17435BC._id_82CAA11345C69977._id_ABA64102EDBF2CD0) {
      _id_52EED65F3AF6AF91::_id_7FD621B8BA80E652();
      _id_B06DEC4DBF57B06B();
      _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("useZipLine1Tip");
    }

    if(_id_AE695132BEFABC19 > 9000000) {
      self._id_0657F5A0D17435BC._id_82CAA11345C69977._id_3AF3CD0524977042 = 0;
      _id_A1A89AEB095402F2();
      _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("useZipLine1Tip", 0, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
      self notify("currentContextualTipAborted");
    }

    waitframe();
  }
}

_id_B06DEC4DBF57B06B() {
  _id_DC799D3B5CD8216C = anglesToForward(self._id_0657F5A0D17435BC._id_82CAA11345C69977._id_48476CF9CF37777E.angles);
  _id_0EAF618DB8FDDBE9 = _id_DC799D3B5CD8216C * 1.5;
  position = self._id_0657F5A0D17435BC._id_82CAA11345C69977._id_48476CF9CF37777E.origin + _id_0EAF618DB8FDDBE9;

  if(_id_ADBC48297DB5861E(position))
    position = scripts\engine\utility::drop_to_ground(position) + (0, 0, 20);

  self._id_0657F5A0D17435BC._id_82CAA11345C69977.waypoint = _id_695A872D7D692EFA::_id_E5524FB8509827BF(position, &"FTUE_MOBILE/GO_HERE", "icon_waypoint_objective_general", 15, self);
  self._id_0657F5A0D17435BC._id_82CAA11345C69977._id_ABA64102EDBF2CD0 = 1;
}

_id_A1A89AEB095402F2() {
  _id_695A872D7D692EFA::_id_4D03B9EF456D0972(self._id_0657F5A0D17435BC._id_82CAA11345C69977.waypoint);
  self._id_0657F5A0D17435BC._id_82CAA11345C69977._id_ABA64102EDBF2CD0 = 0;
}

_id_549535E92D5C8D97() {
  self._id_0657F5A0D17435BC._id_BDBB54412EEFF8E7 = "buyStation1Tip";
  self._id_0657F5A0D17435BC._id_3BC7A9DEFA307C4C = "buyStation4Tip";
  self._id_0657F5A0D17435BC._id_0480AA6483C54887._id_B6FFAAA84BABD1BC = "buyStation1Tip";
  self._id_0657F5A0D17435BC._id_F7C70704371233CD = 1;
  childthread _id_D924B34CAAE65526(self._id_0657F5A0D17435BC._id_0480AA6483C54887._id_E7CEE4FBB5B46EF2, (0, 0, 25), 14400, 1000000, 4000000, 1, 0, &"FTUE_MOBILE/OPEN", 15);
  childthread _id_57C654576CDEC173::_id_DADEE81D5CE668BD(::_id_549537E92D5C91FD);
  childthread _id_57C654576CDEC173::_id_CD83759E21F3FF42(::_id_549536E92D5C8FCA);
}

_id_549536E92D5C8FCA() {
  self endon("currentContextualTipCompleted");
  _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20(self._id_0657F5A0D17435BC._id_0480AA6483C54887._id_B6FFAAA84BABD1BC, 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
  self._id_0657F5A0D17435BC._id_0480AA6483C54887._id_B6FFAAA84BABD1BC = "buyStation2Tip";

  if(self._id_0657F5A0D17435BC._id_0480AA6483C54887._id_2A182E08ECBC0BD6) {
    return;
  }
  _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("buyStation2Tip");
  childthread _id_57C654576CDEC173::_id_B40F17685DBCC4E6(::_id_EE934EE06DDE4BF4);
  childthread _id_57C654576CDEC173::_id_4BFC467C67D38FE0(::_id_CFEC8EDEB2FC6DD5);
}

_id_549537E92D5C91FD() {
  self._id_0657F5A0D17435BC._id_0480AA6483C54887._id_2A182E08ECBC0BD6 = 1;
  self._id_0657F5A0D17435BC._id_F7C70704371233CD = 0;
  _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20(self._id_0657F5A0D17435BC._id_0480AA6483C54887._id_B6FFAAA84BABD1BC, 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
  self notify("currentContextualTipCompleted");
}

_id_CFEC8EDEB2FC6DD5() {
  _id_52EED65F3AF6AF91::_id_7FD621B8BA80E652();
  self._id_0657F5A0D17435BC._id_0480AA6483C54887._id_B6FFAAA84BABD1BC = "buyStation3Tip";
  _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("buyStation3Tip");
}

_id_EE934EE06DDE4BF4() {
  if(!self._id_0657F5A0D17435BC._id_0480AA6483C54887._id_2A182E08ECBC0BD6) {
    self._id_0657F5A0D17435BC._id_ABA64102EDBF2CD0 = 1;
    _id_52EED65F3AF6AF91::_id_7FD621B8BA80E652();
    self._id_0657F5A0D17435BC._id_F7C70704371233CD = 1;
    self._id_0657F5A0D17435BC._id_0480AA6483C54887._id_B6FFAAA84BABD1BC = "buyStation1Tip";
  }
}

_id_49A922D5B933EB1F() {
  return 0;
}

_id_79858E3473B63A92(alive) {
  self._id_0657F5A0D17435BC._id_F7C70704371233CD = 0;

  if(alive) {
    _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("reviveAllyDown2Tip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
    self notify("currentContextualTipCompleted");
  } else
    _id_05EBBABA0D200B31("reviveAllyDown2Tip");

  self._id_0657F5A0D17435BC._id_9DAF1075AF0426FA._id_3AF3CD0524977042 = 0;
}

_id_79858D3473B6385F() {
  foreach(ally in self._id_0FFDDBA74F404A30) {
    if(istrue(ally.inlaststand))
      self._id_0657F5A0D17435BC._id_9DAF1075AF0426FA._id_8B6F5F93A32BBA7F = ally;
  }

  childthread _id_23A85A6F3340BF6F::_id_79FF3EA7E538A94A(self._id_0657F5A0D17435BC._id_9DAF1075AF0426FA._id_8B6F5F93A32BBA7F, ::_id_79858E3473B63A92);
  self._id_0657F5A0D17435BC._id_BDBB54412EEFF8E7 = "reviveAllyDown2Tip";
  self._id_0657F5A0D17435BC._id_3BC7A9DEFA307C4C = "reviveAllyDown1Tip";
  self._id_0657F5A0D17435BC._id_F7C70704371233CD = 1;
  childthread _id_D924B34CAAE65526(self._id_0657F5A0D17435BC._id_9DAF1075AF0426FA._id_8B6F5F93A32BBA7F, undefined, 10000, 1000000, 4000000, 0, 0, undefined, undefined);
}

_id_4F790FE93CB38325() {
  self._id_0657F5A0D17435BC._id_8907FAAF3879C3A0._id_36FD50D2F2947A0D = 1;
  _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("parachute4Tip");
}

_id_4F790EE93CB380F2() {
  self endon("FTUEAbortedTipParachute");
  _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("parachute3Tip");
  _id_6B1017606BBE1A47::_id_A67DB5CF006FC19E(50, 30);
  _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("parachute3Tip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
  _id_4F790FE93CB38325();
}

_id_4F7909E93CB375F3() {
  _id_23A85A6F3340BF6F::_id_914E9D5E71CC6EFB();
  _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("parachute2Tip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
  _id_4F790EE93CB380F2();
}

_id_4F7908E93CB373C0() {
  _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("parachute1Tip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
  _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("parachute2Tip");
  _id_4F7909E93CB375F3();
}

_id_4F790BE93CB37A59() {
  _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("parachute1Tip");
  _id_23A85A6F3340BF6F::_id_BA481C5CD3C4F5B4(::_id_4F7908E93CB373C0);
}

_id_ABCA315D6E0D1A92() {
  if(_id_319303AB6A941A9A()) {
    self._id_0657F5A0D17435BC._id_25D8F562F9F2DAA3._id_CE7F7E62DF1E0B51 = scripts\engine\utility::drop_to_ground(self._id_0657F5A0D17435BC._id_25D8F562F9F2DAA3.killedenemy.origin, 100) + (0, 0, 1);
    self._id_0657F5A0D17435BC._id_25D8F562F9F2DAA3.waypoint = _id_695A872D7D692EFA::_id_E5524FB8509827BF(self._id_0657F5A0D17435BC._id_25D8F562F9F2DAA3._id_CE7F7E62DF1E0B51, &"FTUE_MOBILE/PICK_UP_LOOT", "icon_waypoint_objective_general", 25, self, 1);
    _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("lootEnemyTip");
    childthread _id_76B7D1126B57B69C::_id_EC7F69BBA0F79EE7(::_id_CBB841015B2745F2, 1);
  } else
    self notify("currentContextualTipAborted");
}

_id_CBB841015B2745F2() {
  wait 1;
  self._id_0657F5A0D17435BC._id_25D8F562F9F2DAA3._id_71AFF0F17D48E44B = 1;
}

_id_28E0FC227558E22D() {
  if(!isDefined(self.lootcachesopened))
    self._id_0657F5A0D17435BC.lootcachesopened = 0;
  else
    self._id_0657F5A0D17435BC.lootcachesopened = self.lootcachesopened;

  self._id_0657F5A0D17435BC._id_BDBB54412EEFF8E7 = "lootCrate2Tip";
  self._id_0657F5A0D17435BC._id_3BC7A9DEFA307C4C = "lootCrate1Tip";
  self._id_0657F5A0D17435BC._id_EBF862078B683A7A._id_2F8A41AFC9EBEF12 = _id_6FBF6C2055AEEE37();

  if(!isDefined(self._id_0657F5A0D17435BC._id_EBF862078B683A7A._id_2F8A41AFC9EBEF12)) {
    self notify("currentContextualTipAborted");
    return 0;
  }

  self._id_0657F5A0D17435BC._id_F7C70704371233CD = 1;
  childthread _id_D924B34CAAE65526(self._id_0657F5A0D17435BC._id_EBF862078B683A7A._id_2F8A41AFC9EBEF12, (0, 0, 18), 10000, 1000000, 4000000, 1, 0, &"FTUE_MOBILE/OPEN", 15);
  childthread _id_FA457BBE0F704B56();
}

_id_FA457BBE0F704B56() {
  while(self._id_0657F5A0D17435BC._id_F7C70704371233CD) {
    if(isDefined(self.lootcachesopened) && self.lootcachesopened > self._id_0657F5A0D17435BC.lootcachesopened) {
      self._id_0657F5A0D17435BC._id_F7C70704371233CD = 0;

      if(isDefined(self._id_0657F5A0D17435BC._id_4CB22D8DDA2E06A9))
        _id_695A872D7D692EFA::_id_4D03B9EF456D0972(self._id_0657F5A0D17435BC._id_4CB22D8DDA2E06A9);

      if(isDefined(self._id_0657F5A0D17435BC._id_EBF862078B683A7A._id_2F8A41AFC9EBEF12.itemsdropped)) {
        _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("lootCrate2Tip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
        self notify("currentContextualTipCompleted");
      } else
        _id_7ADB37C8E1687DC0();
    }

    waitframe();
  }
}

_id_7ADB37C8E1687DC0() {
  _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("lootCrate2Tip");
  wait 1;
  _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("lootCrate2Tip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
  self notify("currentContextualTipCompleted");
}

_id_76064223FDD75953() {
  if(!self._id_0657F5A0D17435BC._id_6D2384744119499A._id_CCCAB5C50E0F393B) {
    self._id_0657F5A0D17435BC._id_F7C70704371233CD = 0;
    _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("loadoutDrops2Tip");
  }
}

_id_F5EBDD40DEC5A364(_id_36EA89EADC674509) {
  self._id_0657F5A0D17435BC._id_6D2384744119499A._id_CCCAB5C50E0F393B = 1;
  _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("loadoutDrops2Tip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
  self._id_0657F5A0D17435BC._id_6D2384744119499A._id_495BB1C9678267C7 hudoutlinedisableforclient(self);
  _id_695A872D7D692EFA::_id_4D03B9EF456D0972(self._id_0657F5A0D17435BC._id_4CB22D8DDA2E06A9);
  self notify("currentContextualTipCompleted");
}

_id_76064323FDD75B86() {
  self._id_0657F5A0D17435BC._id_BDBB54412EEFF8E7 = "loadoutDrops3Tip";
  self._id_0657F5A0D17435BC._id_3BC7A9DEFA307C4C = "loadoutDrops1Tip";
  self._id_0657F5A0D17435BC._id_F7C70704371233CD = 1;
  childthread _id_15C10CF294641928::_id_4AE36036BF751ABE(::_id_78E6B7AE51B19E28);
  childthread _id_15C10CF294641928::_id_43A9B7793648C22A(::_id_F5EBDD40DEC5A364);
  childthread _id_D924B34CAAE65526(self._id_0657F5A0D17435BC._id_6D2384744119499A._id_495BB1C9678267C7, (0, 0, 67), 10000, 1000000, 4000000, 1, 1, &"FTUE_MOBILE/OPEN", 10);
}

_id_78E6B7AE51B19E28() {
  _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("loadoutDrops3Tip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
  _id_76064223FDD75953();
}

_id_683A9CF72E77D5BF() {
  self endon("currentContextualTipCompleted");
  self endon("currentContextualTipAborted");
  _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("inventorySystem1Tip");
  self._id_0657F5A0D17435BC._id_108D73DDF65AA72C._id_78F9776E5D16BCFB = "inventorySystem1Tip";
  childthread _id_3FF90E1F809E9340::_id_59DED31F4834F8DE(::_id_683A9DF72E77D7F2);
  childthread _id_3FF90E1F809E9340::_id_7D664CE89C1009CA(::_id_9B0AB7A0413CBF27);
  childthread _id_78DAC680A1677E7C::_id_7FDF3CF66304F3C5(self, 45, self._id_0657F5A0D17435BC._id_108D73DDF65AA72C._id_78F9776E5D16BCFB);
}

_id_683A9DF72E77D7F2() {
  _id_3B9295C58310C53A = spawnStruct();
  _id_3B9295C58310C53A.sound = 1;
  _id_3B9295C58310C53A._id_EE011D69B16FF21D = 0.1;
  _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("inventorySystem1Tip", 1, _id_3B9295C58310C53A);
  _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("inventorySystem2Tip");
  self._id_0657F5A0D17435BC._id_108D73DDF65AA72C._id_78F9776E5D16BCFB = "inventorySystem2Tip";
}

_id_9B0AB7A0413CBF27() {
  wait 1;
  _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("inventorySystem2Tip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
  self notify("currentContextualTipCompleted");
}

_id_7FA70C0FD64F5A06() {
  _id_57BE07D0BE7DC867();
  childthread _id_4557767CDFD3DC52();
  _id_744254A0A817FF39 = spawnStruct();
  _id_744254A0A817FF39.duration = 10;
  _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("identifyAllyTip", _id_744254A0A817FF39);
  childthread _id_DEB2C4D739519229();
  waitframe();
  self notify("currentContextualTipCompleted");
}

_id_EDE2F98D54AE4FFE() {
  _id_05EBBABA0D200B31("gulag1Tip");
}

_id_AF141AD10D4457EF() {
  self notify("currentContextualTipCompleted");
}

_id_AF1417D10D445156(_id_783F2268FA543E99) {
  _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("gulag2Tip", _id_783F2268FA543E99, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
  _id_AF141AD10D4457EF();
}

_id_AF1418D10D445389() {
  if(!self._id_0657F5A0D17435BC._id_F028B7EEE8D5AC0D._id_40AE770E8C262522)
    _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("gulag1Tip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);

  _id_744254A0A817FF39 = spawnStruct();
  _id_744254A0A817FF39.duration = 3;
  _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("gulag2Tip", _id_744254A0A817FF39);
  self._id_0657F5A0D17435BC._id_F028B7EEE8D5AC0D._id_78F9776E5D16BCFB = "gulag2Tip";
  _id_52153E8D8E89E9C4::_id_8EFD0509E8D63CA9(::_id_AF1417D10D445156);
}

_id_AF1415D10D444CF0() {
  if(self._id_0657F5A0D17435BC._id_F028B7EEE8D5AC0D._id_40AE770E8C262522)
    _id_AF1418D10D445389();
  else {
    _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("gulag1Tip");
    self._id_0657F5A0D17435BC._id_F028B7EEE8D5AC0D._id_78F9776E5D16BCFB = "gulag1Tip";
    childthread _id_52153E8D8E89E9C4::_id_88B1AD5E2A6D9E6D(::_id_EDE2F98D54AE4FFE);
    _id_52153E8D8E89E9C4::_id_B3E2A55102596658(::_id_AF1418D10D445389);
  }

  return 0;
}

_id_6E076951711F3F0D() {
  self._id_0657F5A0D17435BC._id_1750EA2A0EE732D8._id_10D87FC7594B8040 = 1;
  _id_52EED65F3AF6AF91::_id_7FD621B8BA80E652();
  self notify("currentContextualTipCompleted");
}

_id_6E076851711F3CDA() {
  _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("gasZone1Tip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);

  if(!self._id_0657F5A0D17435BC._id_1750EA2A0EE732D8._id_10D87FC7594B8040) {
    self._id_0657F5A0D17435BC._id_1750EA2A0EE732D8._id_78F9776E5D16BCFB = "gasZone2Tip";
    _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("gasZone2Tip");
  }
}

_id_6E076751711F3AA7() {
  _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("gasZone1Tip");
  self._id_0657F5A0D17435BC._id_1750EA2A0EE732D8._id_78F9776E5D16BCFB = "gasZone1Tip";
  childthread _id_78DAC680A1677E7C::_id_7FDF3CF66304F3C5(self, 45, self._id_0657F5A0D17435BC._id_1750EA2A0EE732D8._id_78F9776E5D16BCFB);
  childthread _id_23A85A6F3340BF6F::_id_331E465C203522E0(::_id_6E076851711F3CDA);
  childthread _id_23A85A6F3340BF6F::_id_506621F96F8313A5(::_id_6E076951711F3F0D);
}

_id_A678411CE9A6F9EA() {
  _id_744254A0A817FF39 = spawnStruct();
  _id_744254A0A817FF39.sound = 1;
  _id_744254A0A817FF39.duration = 3;
  _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("enemiesInMinimap1Tip", _id_744254A0A817FF39);
  waitframe();
  self notify("currentContextualTipCompleted");
}

_id_605B756FF40F6AA8() {
  waitframe();
  _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("createPingsTip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
  self notify("currentContextualTipCompleted");
}

_id_605B786FF40F7141() {
  _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("createPingsTip");
  childthread _id_23A85A6F3340BF6F::_id_9B8F4317C9BEE442(::_id_605B756FF40F6AA8);
  childthread _id_78DAC680A1677E7C::_id_7FDF3CF66304F3C5(self, 30, "createPingsTip");
}

_id_D98F4306380EE473() {
  _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("beRespawnedTip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
  self notify("currentContextualTipCompleted");
}

_id_D98F4406380EE6A6() {
  _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("beRespawnedTip");
  _id_23A85A6F3340BF6F::_id_C3FF6825172B7E02(::_id_D98F4306380EE473);
}

_id_229A87F877A6E5EF() {
  self._id_0657F5A0D17435BC._id_9FD058151789294E._id_CE7F7E62DF1E0B51 = scripts\engine\utility::drop_to_ground(self._id_0657F5A0D17435BC._id_9FD058151789294E._id_0D02731F86E1479E.origin, 100) + (0, 0, 1);
  self._id_0657F5A0D17435BC._id_9FD058151789294E.waypoint = _id_695A872D7D692EFA::_id_E5524FB8509827BF(self._id_0657F5A0D17435BC._id_9FD058151789294E._id_CE7F7E62DF1E0B51, &"FTUE_MOBILE/PICK_UP", "icon_waypoint_objective_general", 15, self, 1);
  _id_1A3C1FF3121DC418 = "cashTip";
  _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E(_id_1A3C1FF3121DC418);
  self._id_0657F5A0D17435BC._id_9FD058151789294E._id_AFC287EEC64AEB6E = 0;
  childthread _id_2BA81D8D4F69CFAD::_id_72C1EC67D589D251(::_id_734A3CE54E168099);
  childthread _id_78DAC680A1677E7C::_id_7FDF3CF66304F3C5(self, 60, _id_1A3C1FF3121DC418, ::_id_FD8C7C643982FFE3);
}

_id_734A3CE54E168099() {
  self._id_0657F5A0D17435BC._id_9FD058151789294E._id_AFC287EEC64AEB6E = 1;
}

_id_05E5DE51CBCC60DC() {
  self endon("currentContextualTipAborted");
  _id_F3DA6461821C0212 = 1;
  _id_14C4829F9474851D = 0;
  _id_E86632D645C137D0 = level.br_circle.dangercircleent.origin[2];
  _id_2E12FF7E544D85F7 = 2000;
  _id_A0B221200D114E38 = _id_E86632D645C137D0 * 0.25;

  if(_id_2E12FF7E544D85F7 > _id_A0B221200D114E38)
    _id_2E12FF7E544D85F7 = _id_A0B221200D114E38;

  while(!_id_14C4829F9474851D) {
    if(_id_23A85A6F3340BF6F::_id_725B52F601C21A7A(_id_2E12FF7E544D85F7, 100) && _id_F3DA6461821C0212) {
      _id_52EED65F3AF6AF91::_id_7FD621B8BA80E652();
      _id_F3DA6461821C0212 = 0;
      _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("gasZoneWarning1Tip");
    }

    if(_id_23A85A6F3340BF6F::_id_725B52F601C21A7A(-1, -200) && !_id_F3DA6461821C0212) {
      _id_52EED65F3AF6AF91::_id_7FD621B8BA80E652();
      _id_F3DA6461821C0212 = 1;
      _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("gasZoneWarning2Tip");
    }

    if(_id_23A85A6F3340BF6F::_id_725B52F601C21A7A(3000, _id_2E12FF7E544D85F7)) {
      _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("gasZoneWarning1Tip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
      _id_52EED65F3AF6AF91::_id_7FD621B8BA80E652();
      _id_14C4829F9474851D = 1;
      self notify("currentContextualTipCompleted");
    }

    waitframe();
  }
}

_id_05E5E151CBCC6775() {
  childthread _id_05E5DE51CBCC60DC();
}

_id_C5EA332184E0A3E8() {
  childthread _id_64F6DBF96D0E6F81();
  self endon("currentContextualTipCompleted");
  self endon("currentContextualTipAborted");

  if(!_id_0999840D29045E44::_id_043C47CF181121E3()) {
    self._id_0657F5A0D17435BC._id_40834C928484EDFB._id_654C850C2646F8E0 = 1;
    _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("redeployAlly1Tip");
    self._id_0657F5A0D17435BC._id_40834C928484EDFB._id_78F9776E5D16BCFB = "redeployAlly1Tip";
    _id_07618F4372CDD1CE();
    _id_8E53D4CA3DE8531A = 0;

    while(_id_8E53D4CA3DE8531A <= 120) {
      if(_id_0999840D29045E44::_id_043C47CF181121E3()) {
        _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("redeployAlly1Tip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
        childthread _id_C5EA362184E0AA81();
        break;
      } else
        _id_8E53D4CA3DE8531A++;

      wait 1;
    }

    if(_id_8E53D4CA3DE8531A >= 120) {
      _id_3FF2B2E0317F4686();
      _id_05EBBABA0D200B31("redeployAlly1Tip");
      return;
    }
  } else
    childthread _id_C5EA362184E0AA81();
}

_id_C5EA362184E0AA81() {
  _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("redeployAlly2Tip");
  self._id_0657F5A0D17435BC._id_40834C928484EDFB._id_78F9776E5D16BCFB = "redeployAlly2Tip";
  childthread _id_59299228AA688748();
  childthread _id_57C654576CDEC173::_id_DADEE81D5CE668BD(::_id_09BA4EFE4F079799, "killstreak");
  childthread _id_57C654576CDEC173::_id_CD83759E21F3FF42(::_id_C5EA352184E0A84E);
  childthread _id_57C654576CDEC173::_id_DADEE81D5CE668BD(::_id_0AA05B333B0355A6);
  _id_8E53D4CA3DE8531A = 0;

  while(_id_8E53D4CA3DE8531A <= 120) {
    _id_8E53D4CA3DE8531A++;
    wait 1;
  }

  if(!self._id_0657F5A0D17435BC._id_40834C928484EDFB._id_FB1ACFDA55750369) {
    _id_66EE5612ECDFBAC6();
    _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("redeployAlly2Tip", 0, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
    self notify("currentContextualTipAborted");
  }
}

_id_C5EA352184E0A84E() {
  childthread _id_66EE5612ECDFBAC6();
  self._id_0657F5A0D17435BC._id_40834C928484EDFB._id_FB1ACFDA55750369 = 1;
  _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("redeployAlly2Tip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
  self._id_0657F5A0D17435BC._id_40834C928484EDFB._id_78F9776E5D16BCFB = "redeployAlly3Tip";

  if(!self._id_0657F5A0D17435BC._id_40834C928484EDFB._id_55D2955394D9DA6F)
    _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("redeployAlly3Tip");

  childthread _id_57C654576CDEC173::_id_B40F17685DBCC4E6(::_id_E13C98CC4BE85C6C);
}

_id_09BA4EFE4F079799() {
  self._id_0657F5A0D17435BC._id_40834C928484EDFB._id_55D2955394D9DA6F = 1;
  _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("redeployAlly3Tip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
  _id_52EED65F3AF6AF91::_id_7FD621B8BA80E652();
  self notify("currentContextualTipCompleted");
}

_id_0AA05B333B0355A6() {
  self._id_0657F5A0D17435BC._id_40834C928484EDFB._id_2A182E08ECBC0BD6 = 1;
  self._id_0657F5A0D17435BC._id_40834C928484EDFB._id_FB1ACFDA55750369 = 0;
  wait 0.5;

  if(!self._id_0657F5A0D17435BC._id_40834C928484EDFB._id_55D2955394D9DA6F) {
    if(!self._id_0657F5A0D17435BC._id_40834C928484EDFB._id_654C850C2646F8E0) {
      _id_52EED65F3AF6AF91::_id_7FD621B8BA80E652();
      childthread _id_C5EA332184E0A3E8();
    } else {
      _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("redeployAlly3Tip", 0, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
      self notify("currentContextualTipAborted");
    }
  }
}

_id_E13C98CC4BE85C6C() {
  self endon("currentContextualTipAborted");
  self endon("currentContextualTipCompleted");
  wait 0.5;

  if(!self._id_0657F5A0D17435BC._id_40834C928484EDFB._id_55D2955394D9DA6F && !self._id_0657F5A0D17435BC._id_40834C928484EDFB._id_2A182E08ECBC0BD6) {
    _id_52EED65F3AF6AF91::_id_7FD621B8BA80E652();
    self._id_0657F5A0D17435BC._id_40834C928484EDFB._id_FB1ACFDA55750369 = 0;
    _id_C5EA362184E0AA81();
  }
}

_id_02CF99FD1DCDA914() {
  childthread _id_962A086325A6EBCC();
  _id_4412F1171BADD735 = scripts\mp\utility\inventory::getfirstprimaryweapon();
  self._id_0657F5A0D17435BC._id_CD0CE7CFECDE4C03._id_7803C95645E637E1 = self getcurrentprimaryweapon();

  if(_id_4412F1171BADD735.basename == self._id_0657F5A0D17435BC._id_CD0CE7CFECDE4C03._id_7803C95645E637E1.basename)
    self._id_0657F5A0D17435BC._id_CD0CE7CFECDE4C03._id_78F9776E5D16BCFB = "switchWeapon1Tip";
  else
    self._id_0657F5A0D17435BC._id_CD0CE7CFECDE4C03._id_78F9776E5D16BCFB = "switchWeapon2Tip";

  _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E(self._id_0657F5A0D17435BC._id_CD0CE7CFECDE4C03._id_78F9776E5D16BCFB);
  childthread _id_78DAC680A1677E7C::_id_7FDF3CF66304F3C5(self, 20, self._id_0657F5A0D17435BC._id_CD0CE7CFECDE4C03._id_78F9776E5D16BCFB);
}

_id_AE5757FDAD4729B8() {
  _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("disableTooltipsTip");
  childthread _id_FC9D282D9AFEEC03();
  childthread _id_78DAC680A1677E7C::_id_7FDF3CF66304F3C5(self, getdvarint("dvar_00954866CDA5724C", 45), "disableTooltipsTip");
}

_id_FC9D282D9AFEEC03() {
  for(;;) {
    self waittill("luinotifyserver", _id_7148C1A6F25491F8);

    if(isDefined(_id_7148C1A6F25491F8) && _id_7148C1A6F25491F8 == "ftue_tips_disabled") {
      _id_52EED65F3AF6AF91::_id_7FD621B8BA80E652();
      self notify("currentContextualTipCompleted");
      break;
    }
  }
}

_id_05EBBABA0D200B31(_id_ADD40DBD3D6EE5CC) {
  _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20(_id_ADD40DBD3D6EE5CC, 0, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
  self notify("currentContextualTipAborted");
}

_id_51221897A20C4CD0() {
  return 0;
}

_id_3197C7AE9B533B7A() {
  _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20(self._id_0657F5A0D17435BC._id_F028B7EEE8D5AC0D._id_78F9776E5D16BCFB, 0, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
  self notify("currentContextualTipAborted");
}

_id_390588110DDAD141() {
  if(!self._id_0657F5A0D17435BC._id_8907FAAF3879C3A0._id_36FD50D2F2947A0D) {
    self notify("FTUEAbortedTipParachute");
    _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("parachute3Tip", 0, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
    self._id_0657F5A0D17435BC._id_8907FAAF3879C3A0._id_881877F6B4DFAC21 = 0;
    _id_4F790FE93CB38325();
  }

  childthread _id_57C4E4D78F96D672();
}

_id_EEB8AA7D0DF4F4AC() {
  self._id_0657F5A0D17435BC._id_C20E4DB3495A7F8A = 1;
}

_id_3912365A58690E4E() {
  _id_66EE5612ECDFBAC6();
  _id_05EBBABA0D200B31(self._id_0657F5A0D17435BC._id_40834C928484EDFB._id_78F9776E5D16BCFB);
}

_id_EEB8AD7D0DF4FB45() {
  return 0;
}

_id_84E2F790050BD9CB() {
  return 0;
}

_id_918C5AB6E5D63B1E() {
  return 0;
}

_id_918C59B6E5D638EB() {
  return 0;
}

_id_2386FBEC5E1CA175() {
  return 0;
}

_id_2386F8EC5E1C9ADC() {
  return 0;
}

_id_91F8E694098031E8() {
  return 0;
}

_id_2DD522F4E3055CC7() {
  return 0;
}

_id_0AA84FB15F18EF8D() {
  return 0;
}

_id_144B9F4EC7316632() {
  return 0;
}

_id_389F36DF89442C4F() {
  return 0;
}

_id_3AB35F644C83FE44() {
  return 0;
}

_id_6E9877DA3497BE33() {
  _id_05EBBABA0D200B31(self._id_0657F5A0D17435BC._id_108D73DDF65AA72C._id_78F9776E5D16BCFB);
}

_id_32A1B6E53B39B557() {
  return 0;
}

_id_FC79C8376F59BF78() {
  return 0;
}

_id_ABB1B1E76E6D3C20() {
  return 0;
}

_id_8E4CE4303149D181() {
  self._id_0657F5A0D17435BC._id_C20E4DB3495A7F8A = 1;
}

_id_B340DA5A8C093458() {
  _id_695A872D7D692EFA::_id_4D03B9EF456D0972(self._id_0657F5A0D17435BC._id_25D8F562F9F2DAA3.waypoint);
  _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("lootEnemyTip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
  self notify("currentContextualTipCompleted");
}

_id_B340DD5A8C093AF1() {
  _id_695A872D7D692EFA::_id_4D03B9EF456D0972(self._id_0657F5A0D17435BC._id_25D8F562F9F2DAA3.waypoint);
  _id_05EBBABA0D200B31("lootEnemyTip");
}

_id_B340DC5A8C0938BE() {
  _id_695A872D7D692EFA::_id_4D03B9EF456D0972(self._id_0657F5A0D17435BC._id_25D8F562F9F2DAA3.waypoint);
  _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("lootEnemyTip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
  self notify("currentContextualTipCompleted");
}

_id_B872AFF17393DF33() {
  return 0;
}

_id_04A531C5BA156E6B() {
  _id_FD8C7C643982FFE3();
  _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("cashTip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
  self notify("currentContextualTipCompleted");
}

_id_04A532C5BA15709E() {
  waitframe();

  if(self._id_0657F5A0D17435BC._id_9FD058151789294E._id_AFC287EEC64AEB6E) {
    return;
  }
  _id_FD8C7C643982FFE3();
  _id_05EBBABA0D200B31("cashTip");
}

_id_FD8C7C643982FFE3() {
  _id_695A872D7D692EFA::_id_4D03B9EF456D0972(self._id_0657F5A0D17435BC._id_9FD058151789294E.waypoint);
}

_id_1873C2C76F8CF9BA() {
  wait 1;
  _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("useZipLine2Tip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
  self._id_0657F5A0D17435BC._id_82CAA11345C69977._id_3AF3CD0524977042 = 0;
  _id_A1A89AEB095402F2();
  self notify("currentContextualTipCompleted");
}

_id_34ECA3F4488832D6() {
  _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20(self._id_0657F5A0D17435BC._id_CD0CE7CFECDE4C03._id_78F9776E5D16BCFB, 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
  self notify("currentContextualTipCompleted");
}

_id_EFFEC5E680D95771() {
  level._id_305547D6DE59EBA4._id_0DA1E4DED7DB0B78[0] = "brloot_plunder_cash_uncommon_1";
  level._id_305547D6DE59EBA4._id_0DA1E4DED7DB0B78[1] = "brloot_plunder_cash_uncommon_2";
  level._id_305547D6DE59EBA4._id_0DA1E4DED7DB0B78[2] = "brloot_plunder_cash_uncommon_3";
  level._id_305547D6DE59EBA4._id_0DA1E4DED7DB0B78[3] = "brloot_plunder_cash_common_1";
  level._id_305547D6DE59EBA4._id_0DA1E4DED7DB0B78[4] = "brloot_plunder_cash_rare_1";
  level._id_305547D6DE59EBA4._id_0DA1E4DED7DB0B78[5] = "brloot_plunder_cash_rare_2";
  level._id_305547D6DE59EBA4._id_0DA1E4DED7DB0B78[6] = "brloot_plunder_cash__epic_1";
  level._id_305547D6DE59EBA4._id_0DA1E4DED7DB0B78[7] = "brloot_plunder_cash__epic_2";
  level._id_305547D6DE59EBA4._id_0DA1E4DED7DB0B78[8] = "brloot_plunder_cash_epic_1";
  level._id_305547D6DE59EBA4._id_0DA1E4DED7DB0B78[9] = "brloot_plunder_cash_epic_2";
  level._id_305547D6DE59EBA4._id_0DA1E4DED7DB0B78[10] = "brloot_plunder_cash_legendary_1";
}

_id_64F6DBF96D0E6F81() {
  self._id_0657F5A0D17435BC._id_40834C928484EDFB._id_F99DDF933802D415 waittill("disconnect");
  _id_66EE5612ECDFBAC6();
  _id_05EBBABA0D200B31(self._id_0657F5A0D17435BC._id_40834C928484EDFB._id_78F9776E5D16BCFB);
}

_id_66EE5612ECDFBAC6() {
  if(isDefined(self._id_0657F5A0D17435BC._id_40834C928484EDFB.waypoint))
    _id_695A872D7D692EFA::_id_4D03B9EF456D0972(self._id_0657F5A0D17435BC._id_40834C928484EDFB.waypoint);

  _id_3FF2B2E0317F4686();
}

_id_07618F4372CDD1CE() {
  self._id_0657F5A0D17435BC._id_9FD058151789294E._id_0D02731F86E1479E = undefined;

  while(!isDefined(self._id_0657F5A0D17435BC._id_9FD058151789294E._id_0D02731F86E1479E)) {
    params = spawnStruct();
    params.mindistance = 50;
    params.maxdistance = 700;
    _id_0999840D29045E44::_id_0123BC3D0AA752E3(params);
    waitframe();
  }

  if(isDefined(self._id_0657F5A0D17435BC._id_9FD058151789294E._id_0D02731F86E1479E) && _id_2BA81D8D4F69CFAD::_id_AD5378568B077260(self._id_0657F5A0D17435BC._id_9FD058151789294E._id_0D02731F86E1479E)) {
    _id_CE7F7E62DF1E0B51 = scripts\engine\utility::drop_to_ground(self._id_0657F5A0D17435BC._id_9FD058151789294E._id_0D02731F86E1479E.origin, 100) + (0, 0, 1);
    self._id_0657F5A0D17435BC._id_40834C928484EDFB._id_AAF25E1B5F78B634 = _id_695A872D7D692EFA::_id_E5524FB8509827BF(_id_CE7F7E62DF1E0B51, &"FTUE_MOBILE/PICK_UP", "icon_waypoint_objective_general", 15, self, 1);
    childthread _id_2BA81D8D4F69CFAD::_id_72C1EC67D589D251(::_id_3FF2B2E0317F4686);
  }
}

_id_3FF2B2E0317F4686() {
  _id_BCC05B5118030161 = level._id_4B646B4BF1C0CD01.waypoints[self._id_0657F5A0D17435BC._id_40834C928484EDFB._id_AAF25E1B5F78B634];

  if(isDefined(_id_BCC05B5118030161))
    _id_695A872D7D692EFA::_id_4D03B9EF456D0972(self._id_0657F5A0D17435BC._id_40834C928484EDFB._id_AAF25E1B5F78B634);
}

_id_59299228AA688748() {
  self._id_0657F5A0D17435BC._id_40834C928484EDFB._id_F99DDF933802D415 endon("disconnect");
  self._id_0657F5A0D17435BC._id_0480AA6483C54887.position = undefined;
  params = spawnStruct();
  params._id_9130F52078745877 = 2000;

  while(!isDefined(self._id_0657F5A0D17435BC._id_0480AA6483C54887.position)) {
    _id_0999840D29045E44::_id_0A568DFA416DEF0B(params);
    waitframe();
  }

  if(isDefined(self._id_0657F5A0D17435BC._id_0480AA6483C54887.position)) {
    self._id_0657F5A0D17435BC._id_40834C928484EDFB.waypoint = _id_695A872D7D692EFA::_id_E5524FB8509827BF(self._id_0657F5A0D17435BC._id_0480AA6483C54887.position, &"FTUE_MOBILE/OPEN", "icon_waypoint_objective_general", 15, self);
    childthread _id_7D8349E57F205396();
  }
}

_id_7D8349E57F205396() {
  _id_2A3C9591A025F773 = 1;

  while(isDefined(self._id_0657F5A0D17435BC._id_40834C928484EDFB.waypoint)) {
    dist = distancesquared(self.origin, self._id_0657F5A0D17435BC._id_0480AA6483C54887.position);

    if(dist <= 14400 && _id_2A3C9591A025F773) {
      _id_2A3C9591A025F773 = 0;
      _id_695A872D7D692EFA::_id_4D03B9EF456D0972(self._id_0657F5A0D17435BC._id_40834C928484EDFB.waypoint);
    }

    if(dist >= 17280.0 && !_id_2A3C9591A025F773) {
      _id_2A3C9591A025F773 = 1;
      self._id_0657F5A0D17435BC._id_40834C928484EDFB.waypoint = _id_695A872D7D692EFA::_id_E5524FB8509827BF(self._id_0657F5A0D17435BC._id_0480AA6483C54887.position, &"FTUE_MOBILE/OPEN", "icon_waypoint_objective_general", 15, self);
    }

    waitframe();
  }
}

_id_962A086325A6EBCC() {
  self._id_0657F5A0D17435BC._id_CD0CE7CFECDE4C03._id_C4473688E477750F[0] = "iw9_armor_plate_deploy_mp";
  self._id_0657F5A0D17435BC._id_CD0CE7CFECDE4C03._id_C4473688E477750F[1] = "iw9_laser_large_ir_mp";
  self._id_0657F5A0D17435BC._id_CD0CE7CFECDE4C03._id_C4473688E477750F[2] = "iw9_spotter_scope_mp";
}

_id_D924B34CAAE65526(_id_4A473547C4684AAD, _id_A435661999ABDCD9, mindistance, _id_2163C31BBD97F4DE, maxdistance, _id_916FCE261219B611, _id_5B15AA58E5C57490, _id_F3DDF301DE020A15, _id_FDE1C4B6FA858B61) {
  self._id_0657F5A0D17435BC._id_ABA64102EDBF2CD0 = 0;
  self._id_0657F5A0D17435BC._id_C20E4DB3495A7F8A = 0;
  _id_7319E8171FD4F224 = 0;
  _id_8A466BEB6B6B8213 = 0;
  _id_AA43F5D64D4F1444 = spawnStruct();
  _id_AA43F5D64D4F1444.sound = 1;
  _id_AA43F5D64D4F1444._id_EE011D69B16FF21D = 0.1;

  while(self._id_0657F5A0D17435BC._id_F7C70704371233CD) {
    _id_0A3CF649039AF835 = distancesquared(_id_4A473547C4684AAD.origin, self.origin);

    if(_id_0A3CF649039AF835 < mindistance && self._id_0657F5A0D17435BC._id_ABA64102EDBF2CD0) {
      _id_7319E8171FD4F224 = 1;

      if(_id_8A466BEB6B6B8213) {
        _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20(self._id_0657F5A0D17435BC._id_3BC7A9DEFA307C4C, 1, _id_AA43F5D64D4F1444);
        _id_E2613FD871099156(_id_916FCE261219B611);
        removeoutline(_id_5B15AA58E5C57490, _id_4A473547C4684AAD);
      }

      _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E(self._id_0657F5A0D17435BC._id_BDBB54412EEFF8E7);
    }

    if(_id_0A3CF649039AF835 >= mindistance && _id_0A3CF649039AF835 <= _id_2163C31BBD97F4DE && !self._id_0657F5A0D17435BC._id_ABA64102EDBF2CD0) {
      _id_8A466BEB6B6B8213 = 1;

      if(_id_7319E8171FD4F224)
        _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20(self._id_0657F5A0D17435BC._id_BDBB54412EEFF8E7, 0, _id_AA43F5D64D4F1444);

      _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E(self._id_0657F5A0D17435BC._id_3BC7A9DEFA307C4C);
      _id_EBA1FC4DAE96C7BF(_id_916FCE261219B611, _id_4A473547C4684AAD, _id_A435661999ABDCD9, _id_F3DDF301DE020A15, _id_FDE1C4B6FA858B61);
      _id_E495C7C7334DD8CE(_id_5B15AA58E5C57490, _id_4A473547C4684AAD);
    }

    if(_id_0A3CF649039AF835 > maxdistance || self._id_0657F5A0D17435BC._id_C20E4DB3495A7F8A) {
      self._id_0657F5A0D17435BC._id_F7C70704371233CD = 0;
      _id_E2613FD871099156(_id_916FCE261219B611);
      removeoutline(_id_5B15AA58E5C57490, _id_4A473547C4684AAD);
      _id_05EBBABA0D200B31(self._id_0657F5A0D17435BC._id_3BC7A9DEFA307C4C);
    }

    waitframe();
  }
}

_id_EBA1FC4DAE96C7BF(_id_916FCE261219B611, _id_4A473547C4684AAD, _id_A435661999ABDCD9, _id_F3DDF301DE020A15, _id_FDE1C4B6FA858B61) {
  self._id_0657F5A0D17435BC._id_ABA64102EDBF2CD0 = 1;

  if(_id_916FCE261219B611)
    self._id_0657F5A0D17435BC._id_4CB22D8DDA2E06A9 = _id_695A872D7D692EFA::_id_E5524FB8509827BF(_id_4A473547C4684AAD.origin + _id_A435661999ABDCD9, _id_F3DDF301DE020A15, "icon_waypoint_objective_general", _id_FDE1C4B6FA858B61, self);
}

_id_E2613FD871099156(_id_916FCE261219B611) {
  self._id_0657F5A0D17435BC._id_ABA64102EDBF2CD0 = 0;

  if(_id_916FCE261219B611)
    _id_695A872D7D692EFA::_id_4D03B9EF456D0972(self._id_0657F5A0D17435BC._id_4CB22D8DDA2E06A9);
}

_id_E495C7C7334DD8CE(_id_5B15AA58E5C57490, _id_4A473547C4684AAD) {
  if(_id_5B15AA58E5C57490)
    _id_4A473547C4684AAD hudoutlineenableforclient(self, "outline_ftue_touch_yellow");
}

removeoutline(_id_5B15AA58E5C57490, _id_4A473547C4684AAD) {
  if(_id_5B15AA58E5C57490)
    _id_4A473547C4684AAD hudoutlinedisableforclient(self);
}

_id_6FBF6C2055AEEE37() {
  _id_37EAE69752FA4856 = _id_25FE7F095B976329::_id_F3BE9FA4B21EAFC2(2000);
  _id_93BACBF8FE541C21 = undefined;
  _id_4525BEC79B5D223B = 4000000;

  foreach(_id_3A6C85B32780A9B2 in _id_37EAE69752FA4856) {
    if(isDefined(_id_3A6C85B32780A9B2.itemsdropped)) {
      continue;
    }
    _id_EEA82522BACDD291 = distancesquared((self.origin[0], self.origin[1], 0), (_id_3A6C85B32780A9B2.origin[0], _id_3A6C85B32780A9B2.origin[1], 0));
    _id_74DA97EBCA1BA2E7 = distancesquared((0, 0, self.origin[2]), (0, 0, _id_3A6C85B32780A9B2.origin[2]));
    _id_74DA97EBCA1BA2E7 = _id_74DA97EBCA1BA2E7 * 5;
    totaldist = _id_EEA82522BACDD291 + _id_74DA97EBCA1BA2E7;

    if(totaldist < _id_4525BEC79B5D223B) {
      _id_4525BEC79B5D223B = totaldist;
      _id_93BACBF8FE541C21 = _id_3A6C85B32780A9B2;
    }
  }

  return _id_93BACBF8FE541C21;
}

_id_319303AB6A941A9A() {
  _id_D611EE18C96EEA5F = 0;

  foreach(_id_80C53303FB317FE2 in self._id_5A532B3D41B19C7A) {
    if(!isalive(_id_80C53303FB317FE2)) {
      foreach(item in _id_80C53303FB317FE2._id_D2DBB2FA012E6D9C) {
        if(!isDefined(item) || isDefined(item.ammotype))
          _id_D611EE18C96EEA5F++;
      }

      if(_id_D611EE18C96EEA5F >= _id_80C53303FB317FE2._id_D2DBB2FA012E6D9C.size)
        return 0;
    }
  }

  return 1;
}

_id_57C4E4D78F96D672() {
  wait 6;

  if(self._id_0657F5A0D17435BC._id_8907FAAF3879C3A0._id_881877F6B4DFAC21) {
    _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("parachute4Tip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
    self notify("currentContextualTipCompleted");
  } else
    _id_05EBBABA0D200B31("parachute4Tip");
}

_id_4557767CDFD3DC52() {
  if(isDefined(self._id_0657F5A0D17435BC._id_E54398F75467B105._id_EBFA76E78F016544))
    self._id_0657F5A0D17435BC._id_E54398F75467B105._id_EBFA76E78F016544 hudoutlineenableforclient(self, "outline_ftue_touch_yellow");
  else
    self notify("currentContextualTipAborted");
}

_id_DEB2C4D739519229() {
  wait 10;

  if(isDefined(self._id_0657F5A0D17435BC._id_E54398F75467B105._id_EBFA76E78F016544))
    self._id_0657F5A0D17435BC._id_E54398F75467B105._id_EBFA76E78F016544 hudoutlinedisableforclient(self);
  else
    self notify("currentContextualTipAborted");
}

_id_57BE07D0BE7DC867() {
  _id_D5BB04F234D19728 = distance2d(self.origin, self._id_0FFDDBA74F404A30[0].origin);
  self._id_0657F5A0D17435BC._id_E54398F75467B105._id_EBFA76E78F016544 = self._id_0FFDDBA74F404A30[0];

  foreach(ally in self._id_0FFDDBA74F404A30) {
    _id_DF8E0358F6E2B842 = distance2d(self.origin, ally.origin);

    if(_id_DF8E0358F6E2B842 < _id_D5BB04F234D19728)
      self._id_0657F5A0D17435BC._id_E54398F75467B105._id_EBFA76E78F016544 = ally;
  }
}

_id_ADBC48297DB5861E(_id_64E31718BD409CED) {
  _id_39EB5394CB83C4C0 = distancesquared(self.origin, _id_64E31718BD409CED);
  _id_F07271DC6DAF7C8D = distancesquared(self.origin, scripts\engine\utility::drop_to_ground(_id_64E31718BD409CED));

  if(_id_F07271DC6DAF7C8D < _id_39EB5394CB83C4C0)
    return 1;

  return 0;
}

_id_D8D5458FC84E29FE(_id_0A40C0189DE0033C) {
  _id_52153E8D8E89E9C4::_id_7F25D3119F627905(::_id_AE8BB3B961EBA2A1);
  _id_52153E8D8E89E9C4::_id_DB3156CAB6C25766(::_id_AE8BB3B961EBA2A1);
  _id_52153E8D8E89E9C4::_id_B3E2A55102596658(::_id_8E9C156E6EAF6CEF);
}

_id_0E7F53A3E2391D23() {
  _id_52153E8D8E89E9C4::_id_8EFD0509E8D63CA9(::_id_22D2C0FF8235B592);
}

_id_22D2C0FF8235B592(message) {
  self notify("gulagFinished");
}

_id_AE8BB3B961EBA2A1(_id_0E73F82F58EB3128) {
  _id_52EED65F3AF6AF91::_id_7FD621B8BA80E652();
  self notify("IsGulagStarted");
}

_id_8E9C156E6EAF6CEF(_id_0E73F82F58EB3128) {
  self._id_0657F5A0D17435BC._id_F028B7EEE8D5AC0D._id_40AE770E8C262522 = 1;
}

_id_5FCD813A97044D45(_id_0A40C0189DE0033C) {
  childthread _id_76B7D1126B57B69C::_id_9E3F4898DB5D314E(::_id_AA8FE7B21A2E4BA6);
}

_id_AA8FE7B21A2E4BA6() {
  self notify("AreEnemiesInMiniMap");
}

_id_2F0DA1E9DA7ED50D(_id_0A40C0189DE0033C) {
  _id_23A85A6F3340BF6F::_id_FF62C3AABF4C0BA8(::_id_6B4F0525D8E95CDE);
}

_id_6B4F0525D8E95CDE(_id_0A40C0189DE0033C) {
  self notify("IsPlayerShotByEnemy");
}
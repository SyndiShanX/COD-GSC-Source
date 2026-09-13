/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\area_swap.gsc
***********************************************/

_id_BADA8F1445D6B954(_id_A95A0F321427A749, _id_071947160FFEDB67, _id_7D52B05C966F0D1C) {
  level._id_E15EC031B92951C8 = 0;
  level._id_D965516E26B0DF11 = 0;
  _id_9771B01C58858423 = gettime() + 1000 * _id_7D52B05C966F0D1C;
  _id_F8E0CEB548D2A1F3(_id_A95A0F321427A749, _id_071947160FFEDB67, _id_7D52B05C966F0D1C);
  level thread scripts\mp\killcam::_id_0E2177089F4DD55A(_id_9771B01C58858423);

  if(_id_A95A0F321427A749 == "test_observatory" && _id_071947160FFEDB67 == "after") {
    level thread _id_0EA720DAB007B7E6(_id_7D52B05C966F0D1C);
    level thread _id_B7BE9E605E46CC80(_id_9771B01C58858423);
  }
}

_id_6C99988DD1C91950(_id_A95A0F321427A749, _id_071947160FFEDB67) {
  if(_id_A95A0F321427A749 == "test_observatory" && _id_071947160FFEDB67 == "after") {
    if(_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE("saba_observatory")) {
      foreach(agent in _func_7E3F22E620F3F71E("saba_observatory", "everybody")) {
        if(isint(agent))
          _id_371B4C2AB5861E62::_id_4E065F1747AADD51(agent);
      }
    }

    level thread _id_164622EB2B0F5390::_id_BD92CC983BD9E5E0();
  }

  _id_CBBD2025AE81A253(_id_A95A0F321427A749, _id_071947160FFEDB67);
}

_id_CBBD2025AE81A253(_id_A95A0F321427A749, _id_071947160FFEDB67) {
  _id_EC6A81EAC0E4DC61 = [];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "match_time";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = scripts\mp\utility\game::gettimepassed();
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "swap_name";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_A95A0F321427A749;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "swap_state";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_071947160FFEDB67;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "num_player_kills";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = level._id_E15EC031B92951C8;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "num_agent_kills";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = level._id_D965516E26B0DF11;
  dlog_recordevent("dlog_event_area_swap_complete", _id_EC6A81EAC0E4DC61);
}

_id_F8E0CEB548D2A1F3(_id_A95A0F321427A749, _id_071947160FFEDB67, _id_7D52B05C966F0D1C) {
  if(isDefined(level._id_EEA8E3772A56914C)) {
    foreach(callback in level._id_EEA8E3772A56914C)
    level thread[[callback]](_id_A95A0F321427A749, _id_071947160FFEDB67, _id_7D52B05C966F0D1C);
  }
}

_id_0EA720DAB007B7E6(_id_7D52B05C966F0D1C) {
  trigger = _func_F159C10D5CF8F0B4("poi_trigger_saba_observatory", "targetname");

  if(isDefined(trigger) && isDefined(trigger[0]))
    trigger = trigger[0];
  else
    return;

  _id_3B5803E733581858 = 0;

  for(_id_42094F93461409F8 = []; _id_3B5803E733581858 < _id_7D52B05C966F0D1C; _id_3B5803E733581858 = _id_3B5803E733581858 + 1) {
    _id_E3B70650B23F4A23 = [];

    foreach(player in level.players) {
      if(!isDefined(player.origin)) {
        continue;
      }
      if(ispointinvolume(player.origin, trigger)) {
        _id_E3B70650B23F4A23[_id_E3B70650B23F4A23.size] = player;
        continue;
      }

      if(isDefined(level._id_2CBAC3F6932A1512)) {
        foreach(trig in level._id_2CBAC3F6932A1512) {
          if(ispointinvolume(player.origin, trig)) {
            _id_E3B70650B23F4A23[_id_E3B70650B23F4A23.size] = player;
            break;
          }
        }
      }
    }

    _id_37B856F573A0288A = scripts\engine\utility::array_difference(_id_42094F93461409F8, _id_E3B70650B23F4A23);
    _id_0FA40D22288D42FD = scripts\engine\utility::array_difference(_id_E3B70650B23F4A23, _id_42094F93461409F8);

    foreach(player in _id_0FA40D22288D42FD) {
      _id_1671F48D05259D22::dangernotifyplayer(player, "missiles_incoming", _id_7D52B05C966F0D1C - _id_3B5803E733581858);
      level thread _id_1671F48D05259D22::watchdangerresetaction(player, player getxuid(), "stop_warning");
    }

    foreach(player in _id_37B856F573A0288A) {
      if(isDefined(player))
        player notify("stop_warning");
    }

    _id_42094F93461409F8 = _id_E3B70650B23F4A23;
    wait 1;
  }

  level._id_9E417C468E76BE96 = [];
}

_id_96A33D9103E9F773() {
  _id_9842240DFFC4A2DE = getdvarint("dvar_A262003123F672D2", 0) == 1;

  if(_id_9842240DFFC4A2DE)
    iprintlnbold("Blending Up");

  _func_7C2E0421AA80F818("enum_6AD044529B89B0B7", 2000);
  wait 20;

  if(_id_9842240DFFC4A2DE)
    iprintlnbold("Blending Down");

  _func_90FB4916AA7FD9F3("enum_6AD044529B89B0B7");
  _func_7C2E0421AA80F818("enum_44C2BBFEAF948F8D", 10000);

  if(_id_9842240DFFC4A2DE)
    iprintlnbold("faded to thin");
}

_id_B7BE9E605E46CC80(_id_9771B01C58858423) {
  waittime = _id_9771B01C58858423 - 2000;

  while(gettime() < waittime)
    waitframe();

  thread _id_96A33D9103E9F773();
  locations = [(0, 0, 0), (0, 0, 0)];

  foreach(index, location in locations) {
    fx = spawn("script_model", location);
    fx setModel("iw9_tag_origin_observatory_ab_site" + (index + 1) + "_fx");
    fx.angles = (0, 0, 0);
    fx setscriptablepartstate("observatory_ab_fx", "observatory_fx");
    fx forcenetfieldhighlod(1);
    fx thread scripts\mp\utility\script::delayentdelete(10);
  }
}

_id_B682BB16078995E0() {
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self._id_0E36446187560069)) {
    _id_7712019717126CB1 = self[[self._id_0E36446187560069]]();

    if(!istrue(_id_7712019717126CB1))
      return;
  }

  if(isDefined(self.streakinfo) || istrue(self.isequipment))
    scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("killstreak", "doDamageToKillstreak", 10000, undefined, undefined, undefined, undefined, "MOD_EXPLOSIVE");
  else if(scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    self._id_A8F4BB03B366AA80 = 1;

    if(istrue(self._id_1693991455559C14))
      scripts\cp_mp\vehicles\vehicle::vehicle_death(self);
    else
      scripts\cp_mp\vehicles\vehicle::_id_AB08028468AB68F9();
  } else if(isPlayer(self)) {
    if(!istrue(level._id_D847EC6FD85E5E49)) {
      if(scripts\cp_mp\utility\player_utility::_isalive()) {
        self._id_29A5B3784B34A6BC = 1;
        scripts\mp\utility\damage::_suicide(undefined, 1);
        level._id_E15EC031B92951C8 = scripts\engine\utility::_id_53C4C53197386572(level._id_E15EC031B92951C8, 0) + 1;
      }
    }
  } else if(isagent(self)) {
    level._id_D965516E26B0DF11 = scripts\engine\utility::_id_53C4C53197386572(level._id_D965516E26B0DF11, 0) + 1;
    _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(self, "skipDeathCount", 1);
    self kill();
  }
}

_id_E437148FB4069430() {
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self._id_0E36446187560069)) {
    _id_7712019717126CB1 = self[[self._id_0E36446187560069]]();

    if(!istrue(_id_7712019717126CB1))
      return;
  }

  if(self getscriptableisreserved()) {
    _id_7E52B56769FA7774::_id_007B67823458CD14();
    self freescriptable();
  } else
    self setscriptablepartstate(self _meth_EC5F4851431F3382(), "hidden", 1);
}
/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevents.gsc
****************************************************/

init() {
  if(getdvarint("dvar_18AFE7A288A4B1E4", 0)) {
    level notify("disable_public_event");
    level._id_034714CE799B6017 = 0;
    return;
  }

  level._id_034714CE799B6017 = 1;
  level._id_B06BB395C37B7AB8 = getdvarint("dvar_965692FA542F0728", 1) == 1;
  level._id_3F6A099030787823 = getdvarint("dvar_B5088319799172EB", 0) == 1;
  level.br_pe_data = [];
  level._id_2A8CE228749BD191 = [];
  level._id_5A7FFDF228D98C9F = getdvarint("dvar_90AFAC1657855099", 2);
  level._id_6ED09339DA2B5658 = _id_2C7A9D19DD88858C("0 0 0 0 0 0 0 0", 1);
  level._id_5E45FF103CDE1CC6 = 0;

  if(_id_B1266056816B8716()) {
    level._id_5C60C997534512DF = _id_2C7A9D19DD88858C("1 3 5 7 9 11 13 15", 3);
    level._id_03061102686242A8 = _id_2C7A9D19DD88858C(2, 2);
  }

  _id_6DE5B883B26A0F41();
  _id_2902155747C5C4FE::registerhandlecommand(::handledevcommand_publicevents);
  _id_2695A20D4011076D::_id_ECA79FA0F341EE08(8, ::dangercircletick);

  if(_id_294DDA4A4B00FFE3::_id_4AD287E0971672A6())
    level thread _id_294DDA4A4B00FFE3::init();

  if(publiceventsenabled()) {
    if(_id_8AAA3648604BF278())
      level thread _id_A59044C0D9B0988B();
    else
      level thread publiceventsmanager();
  }
}

_id_6DE5B883B26A0F41() {
  level notify("init_public_event");
  _id_507E0812F73DE3C2::init();
  _id_270703EC30C04BC2::init();
  _id_64E2037F2E0D7C04::init();

  if(scripts\mp\utility\game::getsubgametype() == "champion") {
    _id_1CBF6B45E1087A51::init();
    _id_3B23BA56A2983E0E::init();
  }

  if(_id_8AAA3648604BF278()) {
    _id_5648FCCDA43A39DA = spawnStruct();
    _id_5648FCCDA43A39DA.weight = 0;
    registerpublicevent(0, _id_5648FCCDA43A39DA);
  }

  waittillframeend;
  _id_42D775349AF86F8B();
}

_id_42D775349AF86F8B() {
  foreach(eventtype, eventdata in level.br_pe_data) {
    if(eventdata.weight <= 0.0 && !_id_BEB7ED17EFAD9BD7(eventdata)) {
      continue;
    }
    if(isDefined(eventdata.validatefunc) && ![[eventdata.validatefunc]]()) {
      continue;
    }
    if(isDefined(eventdata._id_C9E871D29702E8CF))
      eventdata[[eventdata._id_C9E871D29702E8CF]]();
  }
}

_id_4634160166FB7F8B(eventname, _id_7B3A7C3F67CEB677) {
  _id_3C5DFE64E9E89EB8 = getDvar(_func_2EF675C13CA1C4AF("dvar_ABB46656D4B7E51C", eventname, "_circle_event_weights"), _id_7B3A7C3F67CEB677);
  _id_F0F6529C88A18128 = [];

  if(_id_3C5DFE64E9E89EB8 != "") {
    _id_29EEB1CEE9703A92 = strtok(_id_3C5DFE64E9E89EB8, " ");

    foreach(weight in _id_29EEB1CEE9703A92)
    _id_F0F6529C88A18128[_id_F0F6529C88A18128.size] = float(weight);
  }

  return _id_F0F6529C88A18128;
}

_id_2C7A9D19DD88858C(_id_48BFAE9F19B7225E, _id_B760A53C0712ECF5, eventname) {
  if(!isDefined(_id_B760A53C0712ECF5))
    _id_B760A53C0712ECF5 = -1;

  _id_1493DA49A2631455 = _id_48BFAE9F19B7225E;

  switch (_id_B760A53C0712ECF5) {
    case 0:
      if(!isDefined(eventname))
        eventname = "";

      _id_1493DA49A2631455 = getDvar(_func_2EF675C13CA1C4AF("dvar_ABB46656D4B7E51C", eventname, "_circle_event_weights"), _id_48BFAE9F19B7225E);
      break;
    case 1:
      _id_1493DA49A2631455 = getDvar("dvar_D3DA8CF30DF8BEF5", _id_48BFAE9F19B7225E);
      break;
    case 2:
      _id_1493DA49A2631455 = getDvar("dvar_61457203358FE60E", _id_48BFAE9F19B7225E);
      break;
    case 3:
      _id_1493DA49A2631455 = getDvar("dvar_955B56C18D2A6100", _id_48BFAE9F19B7225E);
    default:
      break;
  }

  _id_501B548282C8429A = [];

  if(_id_1493DA49A2631455 != "") {
    _id_B98E2BDB3119A0E3 = strtok(_id_1493DA49A2631455, " ");

    foreach(value in _id_B98E2BDB3119A0E3)
    _id_501B548282C8429A[_id_501B548282C8429A.size] = float(value);
  }

  return _id_501B548282C8429A;
}

registerpublicevent(eventtype, _id_7EC7671A1E0C788F) {
  if(!isDefined(_id_7EC7671A1E0C788F.weight))
    _id_7EC7671A1E0C788F.active = 0;

  if(!isDefined(_id_7EC7671A1E0C788F.weight))
    _id_7EC7671A1E0C788F.weight = 1.0;

  if(_id_8AAA3648604BF278()) {
    if(!isDefined(_id_7EC7671A1E0C788F._id_D72A1842C5B57D1D))
      _id_7EC7671A1E0C788F._id_D72A1842C5B57D1D = 1;

    if(!isDefined(_id_7EC7671A1E0C788F._id_CEB0AAF169DDC698))
      _id_7EC7671A1E0C788F._id_CEB0AAF169DDC698 = [];
  }

  level.br_pe_data[eventtype] = _id_7EC7671A1E0C788F;
  return _id_7EC7671A1E0C788F;
}

_id_44424D94254DFAF5() {
  cancelupcomingpublicevents();

  foreach(eventtype, eventdata in level.br_pe_data)
  _id_2907D01A7D692108(eventtype);
}

cancelupcomingpublicevents() {
  level notify("cancel_public_event");
  level._id_5E45FF103CDE1CC6 = 0;
}

publiceventsenabled() {
  if(!level._id_034714CE799B6017)
    return 0;

  _id_4FC189F604FC0BD0 = getdvarint("dvar_C164D00B9C54B5B8", 0);

  if(_id_4FC189F604FC0BD0 != 0)
    return 1;

  if(scripts\mp\utility\game::isprophuntgametype())
    return 0;

  if(_id_8AAA3648604BF278())
    return _id_79A1303427BFAC85();
  else {
    _id_485602F85C3B72FA = getpubliceventcount();

    if(!_id_485602F85C3B72FA)
      return 0;

    eventchance = getpubliceventchance();

    if(eventchance <= 0.0)
      return 0;

    return 1;
  }
}

shoulddopublicevent(_id_337E580071962696) {
  eventchance = getpubliceventchance();

  if(_id_8AAA3648604BF278() && isDefined(_id_337E580071962696)) {
    if(isDefined(level._id_6ED09339DA2B5658[_id_337E580071962696]))
      eventchance = level._id_6ED09339DA2B5658[_id_337E580071962696];
    else {
      if(_id_B1266056816B8716())
        _id_01CDDCB2898D7667("Public event was not activated due to event chance not being set for time interval " + _id_337E580071962696);
      else
        _id_01CDDCB2898D7667("Public event was not activated due to circle event chance not being set for circle " + _id_337E580071962696);

      return 0;
    }
  }

  if(eventchance <= 0.0)
    return 0;

  return randomfloat(1.0) <= eventchance;
}

_id_7DDADB6D5643BEE4() {
  return level._id_5E45FF103CDE1CC6 > 0;
}

getpubliceventcount() {
  return getdvarint("dvar_CB12FA4BCD5C4FA3", 1);
}

getpubliceventchance() {
  return getdvarfloat("dvar_0C9060BFF9E6D938", 0.0);
}

multiplepubliceventsenabled() {
  _id_8848A3CE32577E8A = getpubliceventcount();
  return _id_8848A3CE32577E8A != 1;
}

publiceventsmanager() {
  level endon("cancel_public_event");
  scripts\mp\flags::gameflagwait("prematch_done");

  if(multiplepubliceventsenabled()) {
    _id_6E6A77283E1803B1 = getdvarfloat("dvar_A02772622B60D034", 240);
    _id_6E8D89283E3E72FF = getdvarfloat("dvar_A04A60622B86F056", 360);
    _id_8848A3CE32577E8A = getpubliceventcount();

    while(_id_8848A3CE32577E8A) {
      waittime = randomfloatrange(_id_6E6A77283E1803B1, _id_6E8D89283E3E72FF);
      wait(waittime);

      if(shoulddopublicevent()) {
        choosepubliceventtype(1);
        _id_8848A3CE32577E8A--;
      }
    }
  } else if(shoulddopublicevent())
    choosepubliceventtype(0);
}

validateevents() {
  _id_50F938AF0FFCDE52 = [];

  foreach(eventtype, eventdata in level.br_pe_data) {
    if(eventdata.weight <= 0.0) {
      _id_01CDDCB2898D7667(_id_B73E6FCFACC71AFD(eventtype) + " was invalidated due to 0 weight");
      continue;
    }

    if(isDefined(eventdata.validatefunc) && ![[eventdata.validatefunc]]()) {
      _id_01CDDCB2898D7667(_id_B73E6FCFACC71AFD(eventtype) + " was invalidated due to failing validate function");
      continue;
    }

    _id_01CDDCB2898D7667(_id_B73E6FCFACC71AFD(eventtype) + " was validated");
    _id_50F938AF0FFCDE52[_id_50F938AF0FFCDE52.size] = eventtype;
  }

  return _id_50F938AF0FFCDE52;
}

getweightedsum(_id_82819A1606FDDCC0, _id_337E580071962696, _id_FB5AD7615EBAB353, _id_4BD41EBBCE2D3BB6) {
  _id_C35D9F1ADC6B131F = 0.0;

  if(!istrue(_id_4BD41EBBCE2D3BB6)) {
    foreach(eventtype in _id_82819A1606FDDCC0) {
      eventdata = level.br_pe_data[eventtype];
      _id_81B26206A5735207 = eventdata.weight;
      weights = scripts\engine\utility::ter_op(_id_FB5AD7615EBAB353, eventdata._id_B9B56551E1ACFEE2, eventdata._id_F0F6529C88A18128);

      if(isDefined(_id_337E580071962696) && isDefined(weights) && isDefined(weights[_id_337E580071962696]))
        _id_81B26206A5735207 = weights[_id_337E580071962696];

      _id_C35D9F1ADC6B131F = _id_C35D9F1ADC6B131F + _id_81B26206A5735207;
    }
  } else {
    weights = level._id_03061102686242A8;

    foreach(eventtype in _id_82819A1606FDDCC0) {
      if(!isDefined(weights[eventtype])) {
        continue;
      }
      _id_C35D9F1ADC6B131F = _id_C35D9F1ADC6B131F + weights[eventtype];
    }
  }

  return _id_C35D9F1ADC6B131F;
}

findeventforchosenweight(_id_82819A1606FDDCC0, _id_3163D28D241D4273, _id_337E580071962696, _id_FB5AD7615EBAB353, _id_4BD41EBBCE2D3BB6) {
  _id_C35D9F1ADC6B131F = 0.0;

  if(!_id_82819A1606FDDCC0.size)
    return 0;

  if(!istrue(_id_4BD41EBBCE2D3BB6)) {
    foreach(eventtype in _id_82819A1606FDDCC0) {
      eventdata = level.br_pe_data[eventtype];
      _id_81B26206A5735207 = eventdata.weight;
      weights = scripts\engine\utility::ter_op(_id_FB5AD7615EBAB353, eventdata._id_B9B56551E1ACFEE2, eventdata._id_F0F6529C88A18128);

      if(isDefined(_id_337E580071962696) && isDefined(weights) && isDefined(weights[_id_337E580071962696]))
        _id_81B26206A5735207 = weights[_id_337E580071962696];

      _id_C35D9F1ADC6B131F = _id_C35D9F1ADC6B131F + _id_81B26206A5735207;

      if(_id_3163D28D241D4273 <= _id_C35D9F1ADC6B131F)
        return eventtype;
    }
  } else {
    weights = level._id_03061102686242A8;
    _id_82819A1606FDDCC0 = scripts\engine\utility::array_sort_with_func(_id_82819A1606FDDCC0, ::_id_CF51A2B5438BB8CB);

    foreach(eventtype in _id_82819A1606FDDCC0) {
      if(!isDefined(weights[eventtype])) {
        break;
      }

      _id_C35D9F1ADC6B131F = _id_C35D9F1ADC6B131F + weights[eventtype];

      if(_id_3163D28D241D4273 <= _id_C35D9F1ADC6B131F)
        return eventtype;
    }
  }

  return 0;
}

_id_CF51A2B5438BB8CB(_id_B43A2D5F59C41773, _id_CABE446A1104AAD7) {
  return _id_B43A2D5F59C41773 < _id_CABE446A1104AAD7;
}

choosepubliceventtype(_id_ACA4779F20EC97B3, _id_337E580071962696, _id_FB5AD7615EBAB353, _id_4BD41EBBCE2D3BB6) {
  if(!isDefined(_id_FB5AD7615EBAB353))
    _id_FB5AD7615EBAB353 = 0;

  _id_50F938AF0FFCDE52 = undefined;

  if(_id_8AAA3648604BF278() && !istrue(_id_4BD41EBBCE2D3BB6)) {
    _id_01CDDCB2898D7667("Selecting event for circle#: " + _id_337E580071962696);
    _id_50F938AF0FFCDE52 = _id_AAEE113BDF9D92B9(_id_337E580071962696, _id_FB5AD7615EBAB353);
  } else
    _id_50F938AF0FFCDE52 = validateevents();

  if(_id_8AAA3648604BF278()) {}

  _id_C35D9F1ADC6B131F = getweightedsum(_id_50F938AF0FFCDE52, _id_337E580071962696, _id_FB5AD7615EBAB353, _id_4BD41EBBCE2D3BB6);
  _id_F3FD55934AF8F5D1 = randomfloat(_id_C35D9F1ADC6B131F);
  eventtype = findeventforchosenweight(_id_50F938AF0FFCDE52, _id_F3FD55934AF8F5D1, _id_337E580071962696, _id_FB5AD7615EBAB353, _id_4BD41EBBCE2D3BB6);
  _id_01CDDCB2898D7667("Selected event: " + _id_B73E6FCFACC71AFD(eventtype));
  _id_4FC189F604FC0BD0 = getdvarint("dvar_C164D00B9C54B5B8", 0);

  if(_id_4FC189F604FC0BD0 != 0) {
    _id_01CDDCB2898D7667("Overriding selected event with: " + _id_B73E6FCFACC71AFD(_id_4FC189F604FC0BD0));
    eventtype = _id_4FC189F604FC0BD0;
  }

  if(isDefined(_id_337E580071962696))
    circleindex = scripts\engine\utility::ter_op(isDefined(_id_337E580071962696), _id_337E580071962696, "unknown");

  level runpubliceventoftype(eventtype, _id_ACA4779F20EC97B3, _id_337E580071962696, _id_FB5AD7615EBAB353, _id_4BD41EBBCE2D3BB6);
}

_id_145E3D3099BB97C4(eventdata) {
  level endon("game_ended");
  level endon("cancel_public_event");

  if(isDefined(eventdata.activatefunc))
    eventdata[[eventdata.activatefunc]]();

  level._id_5E45FF103CDE1CC6 = level._id_5E45FF103CDE1CC6 - 1;
  level notify("br_pe_end");
}

_id_7EF2B71B1D3C3A01(_id_8760A22C33015E96) {
  if(isDefined(_id_8760A22C33015E96) && isDefined(level._id_5C60C997534512DF[_id_8760A22C33015E96 + 1])) {
    if(isDefined(level._id_5C60C997534512DF[_id_8760A22C33015E96])) {
      _id_0CF1441229A2390C = level._id_5C60C997534512DF[_id_8760A22C33015E96 + 1] - level._id_5C60C997534512DF[_id_8760A22C33015E96];

      if(_id_0CF1441229A2390C < 0) {
        _id_01CDDCB2898D7667("Time interval at " + _id_8760A22C33015E96 + " is less than the previous time interval.");
        return -1;
      }

      return _id_0CF1441229A2390C;
    }
  }

  return -1;
}

runpubliceventoftype(eventtype, _id_ACA4779F20EC97B3, _id_337E580071962696, _id_FB5AD7615EBAB353, _id_4BD41EBBCE2D3BB6) {
  level endon("game_ended");
  level endon("cancel_public_event");

  if(eventtype == 0 && !_id_8AAA3648604BF278())
    _id_01CDDCB2898D7667("No event was valid for this run.");
  else {
    eventdata = level.br_pe_data[eventtype];

    if(isDefined(eventdata.waitfunc) && !_id_ACA4779F20EC97B3)
      eventdata[[eventdata.waitfunc]]();

    if(getdvarint("dvar_A1B1B3BA057F4935", 1) > 0) {
      while(_id_7DDADB6D5643BEE4()) {
        level scripts\engine\utility::waittill_any_2("br_pe_end", "cancel_public_event");
        waitframe();
      }
    }

    level._id_5E45FF103CDE1CC6 = level._id_5E45FF103CDE1CC6 + 1;
    eventdata.active = 1;
    _id_715028F54BAD19A1::branalytics_publiceventstarted(eventtype);
    _id_362C58E8BB39BCDA::runbrgametypefunc("onPublicEvent", eventtype, "start");

    if(_id_8AAA3648604BF278()) {
      level._id_608E8DF77C8E41C7 = 1;
      _id_01CDDCB2898D7667("Activating Event: " + _id_B73E6FCFACC71AFD(eventtype));
      level thread _id_145E3D3099BB97C4(eventdata);

      if(!istrue(_id_FB5AD7615EBAB353)) {
        if(!isDefined(level._id_A926065139739A2D))
          level._id_A926065139739A2D = [];

        if(!isDefined(level._id_A926065139739A2D[eventtype]))
          level._id_A926065139739A2D[eventtype] = 0;

        level._id_A926065139739A2D[eventtype]++;

        if(isDefined(_id_337E580071962696))
          level._id_DEB29F8358C3A6CB[eventtype] = _id_337E580071962696;
      }

      _id_BE7CE9A1E0BED2BC = level.br_pe_data[eventtype]._id_CEB0AAF169DDC698;
      _id_E168C332FE66F78F(_id_BE7CE9A1E0BED2BC);

      if(!istrue(_id_4BD41EBBCE2D3BB6)) {
        if(_id_B1266056816B8716()) {
          waittime = _id_7EF2B71B1D3C3A01(_id_337E580071962696);

          if(waittime >= 0)
            wait(waittime);
          else {
            scripts\mp\flags::gameflagwait("overtime_started");
            level._id_08F19FADBF63FBC0 = 1;
          }
        } else
          level waittill("br_circle_set");

        _id_2907D01A7D692108(eventtype);
        level notify("select_new_event");
        return;
      }

      return;
    }

    level _id_145E3D3099BB97C4(eventdata);

    if(istrue(eventdata.active))
      _id_362C58E8BB39BCDA::runbrgametypefunc("onPublicEvent", eventtype, "end");

    eventdata.active = 0;
    _id_715028F54BAD19A1::branalytics_publiceventended(eventtype);
  }
}

_id_2907D01A7D692108(eventtype) {
  if(ispubliceventoftypeactive(eventtype)) {
    eventdata = level.br_pe_data[eventtype];

    if(isDefined(eventdata._id_0F4FD1F55EC89DED))
      eventdata[[eventdata._id_0F4FD1F55EC89DED]]();

    _id_362C58E8BB39BCDA::runbrgametypefunc("onPublicEvent", eventtype, "end");
    eventdata.active = 0;
    _id_715028F54BAD19A1::branalytics_publiceventended(eventtype);
  }
}

ispubliceventoftypeactive(eventtype) {
  if(!level._id_034714CE799B6017 || !isDefined(level.br_pe_data))
    return 0;

  eventdata = level.br_pe_data[eventtype];

  if(!isDefined(eventdata))
    return 0;

  return istrue(eventdata.active);
}

showsplashtoall(splashname, _id_042B1E877AB187C6) {
  foreach(player in level.players)
  player scripts\mp\hud_message::showsplash(splashname, undefined, undefined, undefined, undefined, _id_042B1E877AB187C6);
}

dangercircletick(_id_819EDACDACB810E4, _id_E86632D645C137D0, _id_5D954F1724092F5A) {
  _id_0F8F6EF2EACDE085::dangercircletick(_id_819EDACDACB810E4, _id_E86632D645C137D0, _id_5D954F1724092F5A);
}

_id_6EF55FFE74B87A74(waittime) {
  level endon("game_ended");

  if(isDefined(waittime))
    wait(waittime);

  setomnvar("ui_publicevent_minimap_pulse", 0);
}

handledevcommand_publicevents(_id_10D8148F3496F8DE, _id_434809FD34BABEE0) {}

_id_8AAA3648604BF278() {
  return istrue(level._id_B06BB395C37B7AB8);
}

_id_B1266056816B8716() {
  return istrue(level._id_3F6A099030787823);
}

_id_826D1843088FF270() {
  level endon("game_ended");
  level waittill("bmo_overtime_start");
  level thread choosepubliceventtype(1, undefined, 0, 1);
}

_id_79A1303427BFAC85() {
  _id_D788440E9C4B0193 = getdvarint("dvar_F6D47BA2AE075D35", level.br_level.br_circleradii.size - 1);

  if(_id_D788440E9C4B0193 <= 0)
    return 0;

  _id_9FA6C50B17CD398E = 0;

  foreach(_id_302E82DA1A1989AD in level._id_6ED09339DA2B5658) {
    if(_id_302E82DA1A1989AD > 0) {
      _id_9FA6C50B17CD398E = 1;
      break;
    }
  }

  return _id_9FA6C50B17CD398E;
}

_id_A59044C0D9B0988B() {
  level endon("cancel_public_event");
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  level._id_A926065139739A2D = [];
  level._id_DEB29F8358C3A6CB = [];
  _id_93FE8081BD477CB7 = 0;
  _id_D788440E9C4B0193 = 0;
  _id_1BC1989068D1A2DE = 0;

  if(!_id_B1266056816B8716()) {
    _id_D788440E9C4B0193 = getdvarint("dvar_F6D47BA2AE075D35", level.br_level.br_circleradii.size - 1);
    _id_1BC1989068D1A2DE = level.br_level.br_circleradii.size - 1;
  } else {
    _id_E895A5728084432E = 120;
    _id_417EAACAAC86D96E = _func_C5CF558181E12D1F(scripts\mp\utility\game::gettimelimit() / _id_E895A5728084432E) + 1;
    _id_D788440E9C4B0193 = getdvarint("dvar_F6D47BA2AE075D35", _id_417EAACAAC86D96E);
    _id_1BC1989068D1A2DE = _id_417EAACAAC86D96E;
  }

  while(_id_93FE8081BD477CB7 < _id_1BC1989068D1A2DE) {
    if(_id_93FE8081BD477CB7 == 0) {
      if(!_id_B1266056816B8716())
        level waittill("br_circle_set");
      else {
        level thread _id_826D1843088FF270();
        wait(level._id_5C60C997534512DF[0]);
      }

      _id_EEEAA84E1F3266CF = 5;
      _id_6393850CED28F59E = getdvarint("dvar_23B4B411C19D8090", _id_EEEAA84E1F3266CF);
      wait(_id_6393850CED28F59E);
    } else {
      if(istrue(level._id_608E8DF77C8E41C7) || _id_B1266056816B8716())
        level waittill("select_new_event");
      else
        level waittill("br_circle_set");

      _id_D17757E8D6DA1D50 = 8;

      if(_id_B1266056816B8716())
        _id_D17757E8D6DA1D50 = 0;

      _id_19514771C45F18E3 = getdvarint("dvar_A03801AE050DDF71", _id_D17757E8D6DA1D50);
      wait(_id_19514771C45F18E3);
    }

    if(isDefined(level._id_0383825619799549) && level._id_0383825619799549 == 0)
      _id_ACA4779F20EC97B3 = 0;
    else
      _id_ACA4779F20EC97B3 = 1;

    _id_337E580071962696 = _id_93FE8081BD477CB7;

    if(!_id_B1266056816B8716())
      _id_337E580071962696 = level.br_circle.circleindex;

    if(istrue(level._id_08F19FADBF63FBC0))
      level thread choosepubliceventtype(1, _id_337E580071962696, 0, 1);
    else if(shoulddopublicevent(_id_337E580071962696))
      level thread choosepubliceventtype(_id_ACA4779F20EC97B3, _id_337E580071962696, 0);
    else
      level._id_608E8DF77C8E41C7 = 0;

    _id_93FE8081BD477CB7++;
  }
}

_id_AAEE113BDF9D92B9(_id_337E580071962696, _id_FB5AD7615EBAB353) {
  _id_50F938AF0FFCDE52 = [];

  foreach(eventtype, eventdata in level.br_pe_data) {
    if(eventdata.weight <= 0.0) {
      _id_01CDDCB2898D7667(_id_B73E6FCFACC71AFD(eventtype) + " was invalidated due to 0 weight");
      continue;
    }

    if(isDefined(eventdata.validatefunc) && ![[eventdata.validatefunc]]()) {
      _id_01CDDCB2898D7667(_id_B73E6FCFACC71AFD(eventtype) + " was invalidated due to failing validate function");
      continue;
    }

    if(isDefined(level._id_2A8CE228749BD191) && istrue(level._id_2A8CE228749BD191[eventtype])) {
      _id_01CDDCB2898D7667(_id_B73E6FCFACC71AFD(eventtype) + " was invalidated due to this event being on the blacklist");
      continue;
    }

    if(isDefined(eventdata._id_CEB0AAF169DDC698)) {
      _id_6833992E762847C3 = 0;

      foreach(_id_28F4FE0E827B9977 in eventdata._id_CEB0AAF169DDC698) {
        if(isDefined(level._id_A926065139739A2D[_id_28F4FE0E827B9977])) {
          if(level._id_A926065139739A2D[_id_28F4FE0E827B9977] > 0) {
            _id_6833992E762847C3 = 1;
            break;
          }
        }
      }

      if(_id_6833992E762847C3) {
        _id_01CDDCB2898D7667(_id_B73E6FCFACC71AFD(eventtype) + " was invalidated due to a previously run event to being on this event's blacklist");
        continue;
      }
    }

    weights = scripts\engine\utility::ter_op(_id_FB5AD7615EBAB353, eventdata._id_B9B56551E1ACFEE2, eventdata._id_F0F6529C88A18128);

    if(isDefined(weights)) {
      if(isDefined(weights[_id_337E580071962696]) && weights[_id_337E580071962696] <= 0) {
        _id_01CDDCB2898D7667(_id_B73E6FCFACC71AFD(eventtype) + " was invalidated due to 0 weight");
        continue;
      } else if(!isDefined(weights[_id_337E580071962696])) {
        _id_01CDDCB2898D7667(_id_B73E6FCFACC71AFD(eventtype) + " was invalidated due to missing circle event weight for circle" + _id_337E580071962696);
        continue;
      }
    }

    if(!istrue(_id_FB5AD7615EBAB353)) {
      if(isDefined(level._id_A926065139739A2D) && isDefined(level._id_A926065139739A2D[eventtype])) {
        if(isDefined(eventdata._id_D72A1842C5B57D1D) && level._id_A926065139739A2D[eventtype] >= eventdata._id_D72A1842C5B57D1D) {
          _id_01CDDCB2898D7667(_id_B73E6FCFACC71AFD(eventtype) + " was invalidated due to already activating max times");
          continue;
        }
      }

      if(isDefined(level._id_DEB29F8358C3A6CB) && isDefined(level._id_DEB29F8358C3A6CB[eventtype])) {
        _id_A8239A74FB8AD784 = _id_337E580071962696 - level._id_DEB29F8358C3A6CB[eventtype];

        if(_id_A8239A74FB8AD784 >= level._id_5A7FFDF228D98C9F + 1)
          level._id_DEB29F8358C3A6CB[eventtype] = undefined;
        else {
          _id_01CDDCB2898D7667(_id_B73E6FCFACC71AFD(eventtype) + " was invalidated due to being a previously ran event within the span of the event repetition buffer.");
          continue;
        }
      }
    }

    _id_01CDDCB2898D7667(_id_B73E6FCFACC71AFD(eventtype) + " was validated");
    _id_50F938AF0FFCDE52[_id_50F938AF0FFCDE52.size] = eventtype;
  }

  if(_id_50F938AF0FFCDE52.size == 0)
    _id_50F938AF0FFCDE52[_id_50F938AF0FFCDE52.size] = 0;

  return _id_50F938AF0FFCDE52;
}

_id_01CDDCB2898D7667(message) {
  if(getdvarint("dvar_909FA2D0703B8E6B", 0) == 1)
    logstring("PE: " + message);
}

_id_B73E6FCFACC71AFD(eventtype) {
  switch (eventtype) {
    case 0:
      return "CONST_BR_PE_TYPE_NONE";
    case 2:
      return "CONST_BR_PE_TYPE_FIRESALE";
    case 3:
      return "CONST_BR_PE_TYPE_JAILBREAK";
    case 1:
      return "CONST_BR_PE_TYPE_CHOPPERS";
    case 4:
      return "CONST_BR_PE_TYPE_JUGGERNAUT";
    case 5:
      return "CONST_BR_PE_TYPE_BOMBARDMENT";
    case 6:
      return "CONST_BR_PE_TYPE_STRONGHOLD";
    case 7:
      return "CONST_BR_PE_TYPE_RESTOCK";
    case 8:
      return "CONST_BR_PE_TYPE_DATAHEIST";
    case 9:
      return "CONST_BR_PE_TYPE_AUAVSCAN";
    case 10:
      return "CONST_BR_PE_TYPE_BURN";
    case 11:
      return "CONST_BR_PE_TYPE_PLUNDER_CRATE_DROP";
    case 12:
      return "CONST_BR_PE_TYPE_BLOODMONEY";
    case 13:
      return "CONST_BR_PE_TYPE_HEAT";
    case 14:
      return "CONST_BR_PE_TYPE_MONEYSIPHON";
    case 15:
      return "CONST_BR_PE_TYPE_CONTRACTOR";
    case 16:
      return "CONST_BR_PE_TYPE_CANNONFODDER";
    case 17:
      return "CONST_BR_PE_TYPE_CHAMPION_JUGGERNAUT";
    case 18:
      return "CONST_BR_PE_TYPE_CHAMPION_CHOPPER";
    case 19:
      return "CONST_BR_PE_TYPE_DOUBLEXP_CRATE_DROP";
    case 20:
      return "CONST_BR_PE_TYPE_OUTBREAK";
    default:
      scripts\mp\utility\script::demoforcesre("No name is defined for eventType: " + eventtype);
      return "UNKNOWN_TYPE";
  }
}

_id_E168C332FE66F78F(_id_723C2B64C6CEBC7E) {
  foreach(eventtype in _id_723C2B64C6CEBC7E) {
    if(!isDefined(level._id_2A8CE228749BD191[eventtype]))
      level._id_2A8CE228749BD191[eventtype] = 1;
  }
}

_id_BEB7ED17EFAD9BD7(eventdata) {
  if(isDefined(eventdata._id_B9B56551E1ACFEE2)) {
    foreach(weight in eventdata._id_B9B56551E1ACFEE2) {
      if(weight > 0)
        return 1;
    }
  }

  return 0;
}
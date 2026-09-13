/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\ai_heli_reinforce.gsc
***********************************************/

_id_D0FFCD08E0870CF2() {
  level._id_425DF8E23AAEF18C = 1;
  level endon("game_ended");
  setDvar("dvar_CC62B45CDBE0DDC1", 0);
  setDvar("dvar_44D7EF19E2C9454E", 0);
  setDvar("dvar_83158EF84A03A108", 0);
  setDvar("dvar_31AABCC3AE1AE28B", 0);
  level._id_5BF59658DAC91F53 = getdvarint("dvar_2B8C82F04A4D868C", 15);
  _id_2B95D18CD2EFB24B = getdvarint("dvar_7E7A367EBF018B24", 768);
  level._id_B6596EAC6F86E8F6 = _id_2B95D18CD2EFB24B * _id_2B95D18CD2EFB24B;
  _id_25C50BEA7CFD2659 = getdvarint("dvar_89D19C15B1E73AFA", 3072);
  level._id_021DE02FBB76D8A4 = _id_25C50BEA7CFD2659 * _id_25C50BEA7CFD2659;
  level._id_253D97D4FC2E6355 = getdvarint("dvar_B79AA6C2BCC68805", 1024);
  level thread initvehicles();

  while(!isDefined(level.struct_class_names))
    waitframe();

  level._id_04EB71F2B8CBA5CB = ::_id_9BE6618055CEB851;
  _id_203ACE42414AFB23();
}

initvehicles() {
  waittillframeend;
  _id_6FBA7DF440C493C4::init_vehicles();
  _id_06BC507AFE7A93A3::main();
  _id_69A61780E1CC21A9::main();
}

_id_203ACE42414AFB23() {
  while(!scripts\engine\utility::flag_exist("create_script_initialized"))
    waitframe();

  scripts\engine\utility::flag_wait("create_script_initialized");
  waitframe();
  level._id_3122F605F0E8E125 = scripts\engine\utility::getStructArray("heli_exit", "targetname");

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    while(level._id_B205D90302DA2F07.size == 0)
      waitframe();

    waitframe();

    foreach(_id_171F90B9C4C76D44, _id_B205D90302DA2F07 in level._id_B205D90302DA2F07) {
      struct = spawnStruct();
      struct._id_C4677FCD658FC8E7 = [];
      struct._id_4F922AF45D0CAC6C = [];

      if(istrue(level._id_4CFD75AA6DDDE156)) {
        struct._id_C9464C89A69010E2 = scripts\engine\utility::getStructArray("heli_postLandingDest", "script_noteworthy");
        _id_4F922AF45D0CAC6C = scripts\engine\utility::getStructArray("heli_unload", "script_noteworthy");
        struct._id_4F922AF45D0CAC6C = _id_7802832A1F064CCD(_id_4F922AF45D0CAC6C, "heli_unload");
        struct._id_144FD45F9438FC65 = scripts\engine\utility::getStructArray("heli_exit", "targetname");
        level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["heliReinforceStruct"] = struct;
        _id_50F783A5617F8940 = scripts\engine\utility::getStructArray("heli_reinforceNode", "script_noteworthy");
        _id_5D0D1CE28492DDAD = _id_7802832A1F064CCD(_id_50F783A5617F8940, "heli_reinforceNode");
      } else {
        struct._id_C9464C89A69010E2 = _id_5DEF7AF2A9F04234::_id_9656B61CC8A37CBA(scripts\engine\utility::getStructArray("heli_postLandingDest", "script_noteworthy"), _id_171F90B9C4C76D44);
        _id_4F922AF45D0CAC6C = _id_5DEF7AF2A9F04234::_id_9656B61CC8A37CBA(scripts\engine\utility::getStructArray("heli_unload", "script_noteworthy"), _id_171F90B9C4C76D44);
        struct._id_4F922AF45D0CAC6C = _id_7802832A1F064CCD(_id_4F922AF45D0CAC6C, "heli_unload");
        struct._id_144FD45F9438FC65 = _id_5DEF7AF2A9F04234::_id_9656B61CC8A37CBA(scripts\engine\utility::getStructArray("heli_exit", "targetname"), _id_171F90B9C4C76D44);
        level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["heliReinforceStruct"] = struct;
        _id_50F783A5617F8940 = _id_5DEF7AF2A9F04234::_id_9656B61CC8A37CBA(scripts\engine\utility::getStructArray("heli_reinforceNode", "script_noteworthy"), _id_171F90B9C4C76D44);
        _id_5D0D1CE28492DDAD = _id_7802832A1F064CCD(_id_50F783A5617F8940, "heli_reinforceNode");
      }

      foreach(loc in _id_4F922AF45D0CAC6C) {
        if(isDefined(loc.target)) {
          loc.exit_node = scripts\engine\utility::getStruct(loc.target, "targetname");
          loc.target = undefined;
        }
      }

      foreach(_id_29376CACC64CC4E6 in _id_5D0D1CE28492DDAD) {
        _id_4928EC336FD14163 = level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["heliReinforceStruct"]._id_C4677FCD658FC8E7.size;
        level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["heliReinforceStruct"]._id_C4677FCD658FC8E7[_id_4928EC336FD14163] = _id_29376CACC64CC4E6;

        if(isDefined(_id_29376CACC64CC4E6.target)) {
          for(node = scripts\engine\utility::getStruct(_id_29376CACC64CC4E6.target, "targetname"); isDefined(node) && isDefined(node.target); node = scripts\engine\utility::getStruct(node.target, "targetname")) {
            if(isDefined(node.script_unload)) {
              node._id_9C763A8AF793B77A = _id_29376CACC64CC4E6;
              _id_4928EC336FD14163 = level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["heliReinforceStruct"]._id_4F922AF45D0CAC6C.size;
              level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["heliReinforceStruct"]._id_4F922AF45D0CAC6C[_id_4928EC336FD14163] = node;
            }
          }
        }
      }

      level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["heliReinforceStruct"]._id_C4677FCD658FC8E7 = scripts\engine\utility::array_randomize(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["heliReinforceStruct"]._id_C4677FCD658FC8E7);
    }
  } else {
    level._id_B6D8EEC09E6F3C63 = spawnStruct();
    level._id_B6D8EEC09E6F3C63._id_C4677FCD658FC8E7 = [];
    level._id_B6D8EEC09E6F3C63._id_4F922AF45D0CAC6C = [];
    level._id_B6D8EEC09E6F3C63._id_C9464C89A69010E2 = scripts\engine\utility::getStructArray("heli_postLandingDest", "script_noteworthy");
    _id_4F922AF45D0CAC6C = scripts\engine\utility::getStructArray("heli_unload", "script_noteworthy");
    level._id_B6D8EEC09E6F3C63._id_4F922AF45D0CAC6C = _id_7802832A1F064CCD(_id_4F922AF45D0CAC6C, "heli_unload");
    _id_50F783A5617F8940 = scripts\engine\utility::getStructArray("heli_reinforceNode", "script_noteworthy");
    _id_5D0D1CE28492DDAD = _id_7802832A1F064CCD(_id_50F783A5617F8940, "heli_reinforceNode");

    foreach(_id_29376CACC64CC4E6 in _id_5D0D1CE28492DDAD) {
      level._id_B6D8EEC09E6F3C63._id_C4677FCD658FC8E7[level._id_B6D8EEC09E6F3C63._id_C4677FCD658FC8E7.size] = _id_29376CACC64CC4E6;

      if(isDefined(_id_29376CACC64CC4E6.target)) {
        for(node = scripts\engine\utility::getStruct(_id_29376CACC64CC4E6.target, "targetname"); isDefined(node.target); node = scripts\engine\utility::getStruct(node.target, "targetname")) {
          if(isDefined(node.script_unload)) {
            node._id_9C763A8AF793B77A = _id_29376CACC64CC4E6;
            level._id_B6D8EEC09E6F3C63._id_4F922AF45D0CAC6C[level._id_B6D8EEC09E6F3C63._id_4F922AF45D0CAC6C.size] = node;
          }
        }
      }
    }

    level._id_B6D8EEC09E6F3C63._id_C4677FCD658FC8E7 = scripts\engine\utility::array_randomize(level._id_B6D8EEC09E6F3C63._id_C4677FCD658FC8E7);
  }
}

_id_7802832A1F064CCD(array, name) {
  _id_E4C0C3198C6D4413 = [];

  foreach(loc in array) {
    _id_38E30F6F71988282 = 0;

    foreach(_id_F90358454413407F in _id_E4C0C3198C6D4413) {
      if(distance2dsquared(loc.origin, _id_F90358454413407F.origin) < 65536) {
        _id_38E30F6F71988282 = 1;
        break;
      }
    }

    if(!_id_38E30F6F71988282)
      _id_E4C0C3198C6D4413[_id_E4C0C3198C6D4413.size] = loc;
  }

  return _id_E4C0C3198C6D4413;
}

_id_9BE6618055CEB851(_id_C5E7FCE963586EC0, _id_93390A6953905FEF, team, _id_171F90B9C4C76D44) {
  _id_A9CE0552ED2EA429 = undefined;

  if(0) {
    level thread scripts\mp\utility\debug::drawsphere(_id_C5E7FCE963586EC0, 32, 120, (0, 0, 1));
    level thread scripts\mp\utility\debug::_id_0C577C013F8789A8(_id_C5E7FCE963586EC0, "REINFORCE TO", 120, (0, 0, 1));
  }

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    if(!isDefined(_id_171F90B9C4C76D44))
      _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_C5E7FCE963586EC0);

    _id_A9CE0552ED2EA429 = sortbydistance(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["heliReinforceStruct"]._id_4F922AF45D0CAC6C, _id_C5E7FCE963586EC0);
  } else
    _id_A9CE0552ED2EA429 = sortbydistance(level._id_B6D8EEC09E6F3C63._id_4F922AF45D0CAC6C, _id_C5E7FCE963586EC0);

  _id_1C6832EF5CBB10FC = [];

  foreach(loc in _id_A9CE0552ED2EA429) {
    _id_54B174A893636475 = scripts\engine\utility::drop_to_ground(loc.origin, 100);

    if(abs(_id_54B174A893636475[2] - _id_C5E7FCE963586EC0[2]) <= level._id_253D97D4FC2E6355) {
      _id_1C6832EF5CBB10FC[_id_1C6832EF5CBB10FC.size] = loc;
      continue;
    }

    level thread scripts\mp\utility\debug::_id_0C577C013F8789A8(loc.origin, "FAILED BECAUSE OF HEIGHT", 120, (1, 0, 0));
  }

  _id_A9CE0552ED2EA429 = _id_1C6832EF5CBB10FC;
  _id_8824EED8622B038A = 5;

  if(istrue(_id_93390A6953905FEF))
    _id_8824EED8622B038A = 1;

  _id_A678DFA17EC4C56B = [];

  foreach(loc in _id_A9CE0552ED2EA429) {
    if(_id_A678DFA17EC4C56B.size == _id_8824EED8622B038A) {
      break;
    }

    dist = distance2dsquared(loc.origin, _id_C5E7FCE963586EC0);

    if(dist < level._id_B6596EAC6F86E8F6) {
      if(0) {
        level thread scripts\mp\utility\debug::drawsphere(loc.origin, 32, 60, (1, 0, 0));
        level thread scripts\mp\utility\debug::_id_0C577C013F8789A8(loc.origin, "FAILED BECAUSE TOO CLOSE", 120, (1, 0, 0));
      }

      continue;
    } else if(dist > level._id_021DE02FBB76D8A4) {
      if(0) {
        level thread scripts\mp\utility\debug::drawsphere(loc.origin, 32, 60, (1, 0, 0));
        level thread scripts\mp\utility\debug::_id_0C577C013F8789A8(loc.origin, "FAILED BECAUSE TOO FAR", 120, (1, 0, 0));
      }

      continue;
    } else {
      if(0) {
        level thread scripts\mp\utility\debug::drawsphere(loc.origin, 32, 60, (0, 1, 0));
        level thread scripts\mp\utility\debug::_id_0C577C013F8789A8(loc.origin, "PASSED DISTANCE CHECK", 120, (0, 1, 0));
      }

      _id_A678DFA17EC4C56B[_id_A678DFA17EC4C56B.size] = loc;
    }
  }

  if(!istrue(level._id_85E83F382AEDC103)) {
    _id_A678DFA17EC4C56B = _id_34EA974920AA74B9(_id_A678DFA17EC4C56B);
    _id_A678DFA17EC4C56B = scripts\engine\utility::array_randomize(_id_A678DFA17EC4C56B);
  }

  _id_29376CACC64CC4E6 = _id_321665DCDCBF401E(_id_A678DFA17EC4C56B, _id_C5E7FCE963586EC0, undefined, _id_171F90B9C4C76D44);

  if(isDefined(_id_29376CACC64CC4E6))
    return _id_29376CACC64CC4E6;

  _id_29376CACC64CC4E6 = _id_321665DCDCBF401E(_id_A9CE0552ED2EA429, _id_C5E7FCE963586EC0, _id_8824EED8622B038A, _id_171F90B9C4C76D44);

  if(isDefined(_id_29376CACC64CC4E6))
    return _id_29376CACC64CC4E6;

  return undefined;
}

_id_34EA974920AA74B9(_id_A9CE0552ED2EA429) {
  _id_8D990899198D4647 = undefined;

  foreach(loc in _id_A9CE0552ED2EA429) {
    if(isDefined(loc._id_0F132458BE445204)) {
      if(!isDefined(_id_8D990899198D4647) || loc._id_0F132458BE445204 < _id_8D990899198D4647)
        _id_8D990899198D4647 = loc._id_0F132458BE445204;

      continue;
    }

    _id_8D990899198D4647 = 0;
  }

  _id_8022A89F6197D261 = [];

  foreach(loc in _id_A9CE0552ED2EA429) {
    if(isDefined(loc._id_0F132458BE445204) && loc._id_0F132458BE445204 == _id_8D990899198D4647 || !isDefined(loc._id_0F132458BE445204) && _id_8D990899198D4647 == 0)
      _id_8022A89F6197D261[_id_8022A89F6197D261.size] = loc;
  }

  return _id_8022A89F6197D261;
}

_id_321665DCDCBF401E(array, _id_34CE337E073A0C34, _id_9747C46274DBA9D9, _id_171F90B9C4C76D44) {
  if(!isDefined(array)) {
    return;
  }
  _id_9E334397541DCA8E = spawnStruct();
  index = 0;

  if(isDefined(_id_9747C46274DBA9D9))
    index = _id_9747C46274DBA9D9;

  for(_id_AC0E594AC96AA3A8 = index; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(array[_id_AC0E594AC96AA3A8])) {
      continue;
    }
    loc = array[_id_AC0E594AC96AA3A8];

    if(istrue(loc.used)) {
      level thread scripts\mp\utility\debug::_id_0C577C013F8789A8(loc.origin + (0, 0, 50), "FAILED BECAUSE USED", 120, (1, 0, 0));
      continue;
    }

    if(_id_1174ABEDBEFE9ADA::_id_26879895DB23C779(loc.origin) && !istrue(level._id_291B51C7AF8D1204)) {
      level thread scripts\mp\utility\debug::_id_0C577C013F8789A8(loc.origin + (0, 0, 50), "FAILED BECAUSE IN RADIATION", 120, (1, 0, 0));
      continue;
    }

    node = undefined;

    if(isDefined(loc._id_9C763A8AF793B77A))
      node = loc._id_9C763A8AF793B77A;
    else
      node = _id_42AA412D7E4D7C37(loc, _id_34CE337E073A0C34, _id_171F90B9C4C76D44);

    if(!isDefined(node)) {
      level thread scripts\mp\utility\debug::_id_0C577C013F8789A8(loc.origin + (0, 0, 50), "FAILED UNDEFINED NODE", 120, (1, 0, 0));
      continue;
    }

    if(istrue(node.used)) {
      level thread scripts\mp\utility\debug::_id_0C577C013F8789A8(loc.origin + (0, 0, 50), "FAILED NODE USED", 120, (1, 0, 0));
      continue;
    }

    heli_type = undefined;

    if(isDefined(loc.script_parameters)) {
      _id_75D516368976B166 = strtok(loc.script_parameters, " ");
      heli_type = scripts\engine\utility::random(_id_75D516368976B166);

      if(!scripts\cp_mp\vehicles\vehicle::_id_FA537F1AB52A76D1(heli_type) || !istrue(scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(heli_type).ai._id_289DF80E1DED586F))
        heli_type = undefined;
    }

    _id_9E334397541DCA8E.node = node;
    _id_9E334397541DCA8E._id_00378D6643D1B02A = heli_type;
    _id_9E334397541DCA8E.node._id_4583939A603F7170 = loc.origin;
    _id_9E334397541DCA8E._id_2770AF6F8CECFC40 = loc;
    _id_0B3D7B682F3C2D9D(node, loc);

    if(!isDefined(loc._id_0F132458BE445204))
      loc._id_0F132458BE445204 = 0;

    loc._id_0F132458BE445204++;
    return _id_9E334397541DCA8E;
  }

  return undefined;
}

_id_42AA412D7E4D7C37(loc, _id_34CE337E073A0C34, _id_171F90B9C4C76D44) {
  _id_AACE9CDBDA94ED28 = undefined;

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    if(!isDefined(_id_171F90B9C4C76D44))
      _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_34CE337E073A0C34);

    _id_AACE9CDBDA94ED28 = sortbydistance(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["heliReinforceStruct"]._id_C4677FCD658FC8E7, _id_34CE337E073A0C34);
  } else
    _id_AACE9CDBDA94ED28 = sortbydistance(level._id_B6D8EEC09E6F3C63._id_C4677FCD658FC8E7, _id_34CE337E073A0C34);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_AACE9CDBDA94ED28.size; _id_AC0E594AC96AA3A8++) {
    if(istrue(_id_AACE9CDBDA94ED28[_id_AC0E594AC96AA3A8].used)) {
      continue;
    }
    if(isDefined(_id_AACE9CDBDA94ED28[_id_AC0E594AC96AA3A8].target)) {
      continue;
    }
    return _id_AACE9CDBDA94ED28[_id_AC0E594AC96AA3A8];
  }

  return undefined;
}

_id_DB68D9A06B8C63A6(node, timer) {
  wait(timer);
  node.used = 0;
}

_id_307D3746C484EC65(_id_A3BC9C316B0F9D64) {
  if(isDefined(_id_A3BC9C316B0F9D64)) {
    _id_1DC99ACF04ACEB20 = sortbydistance(level._id_B6D8EEC09E6F3C63._id_C9464C89A69010E2, _id_A3BC9C316B0F9D64);
    return _id_1DC99ACF04ACEB20[0];
  }

  return scripts\engine\utility::random(level._id_B6D8EEC09E6F3C63._id_C9464C89A69010E2);
}

_id_0B3D7B682F3C2D9D(_id_041EE18556B2486F, _id_2770AF6F8CECFC40) {
  _id_041EE18556B2486F.used = 1;
  _id_2770AF6F8CECFC40.used = 1;
  _id_041EE18556B2486F._id_2770AF6F8CECFC40 = _id_2770AF6F8CECFC40;
}

_id_E1310878AB1F5E7C(_id_041EE18556B2486F) {
  _id_041EE18556B2486F.used = 0;

  if(isDefined(_id_041EE18556B2486F._id_2770AF6F8CECFC40)) {
    _id_041EE18556B2486F._id_2770AF6F8CECFC40.used = 0;
    _id_041EE18556B2486F._id_2770AF6F8CECFC40 = undefined;
  }
}

_id_8062C7F3856760FC() {
  level endon("game_ended");
  level notify("stopUnloadTest");
  level endon("stopUnloadTest");
  level._id_85E83F382AEDC103 = 1;
  _id_9577902B42FBD7F6 = level._id_B6D8EEC09E6F3C63._id_4F922AF45D0CAC6C;

  foreach(loc in _id_9577902B42FBD7F6)
  loc._id_5B697C075E0717DC = undefined;

  _id_3663424BF23734E0 = 0;

  for(;;) {
    if(_id_3663424BF23734E0 == _id_9577902B42FBD7F6.size) {
      foreach(loc in _id_9577902B42FBD7F6)
      loc._id_5B697C075E0717DC = undefined;
    }

    _id_3663424BF23734E0 = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_9577902B42FBD7F6.size; _id_AC0E594AC96AA3A8++) {
      loc = _id_9577902B42FBD7F6[_id_AC0E594AC96AA3A8];

      if(istrue(loc._id_5B697C075E0717DC)) {
        _id_3663424BF23734E0++;
        continue;
      }

      riders = _id_03779DEB97B61A65(2, loc.origin, "high", "reinforcements", "debug");

      if(isDefined(riders)) {
        loc._id_5B697C075E0717DC = 1;
        thread scripts\mp\utility\debug::drawsphere(loc.origin, 64, 60, (0, 1, 0));
      }

      wait 15;
    }

    wait 1;
  }
}

_id_03779DEB97B61A65(numagents, _id_C5E7FCE963586EC0, priority, category, _id_1C9CB43BCF3EB16D, groupname, team, _id_93390A6953905FEF, _id_171F90B9C4C76D44, goalradius, _id_21F24AECB313E479, _id_EC862C2C00C7AB5D, _id_F891E067B8802C0D, _id_EBC42E43F4B05504, _id_8E5A9B658FA525ED, _id_06DCE075F68546B3, _id_96E335EAE30651E5) {
  if(isDefined(level._id_33A2175A9A4306BC) && istrue(level._id_33A2175A9A4306BC._id_009BADBB469626F6)) {
    return;
  }
  if(isDefined(level._id_B08B4D8A5FEDEBDB)) {
    riders = [[level._id_B08B4D8A5FEDEBDB]](_id_C5E7FCE963586EC0, team, _id_171F90B9C4C76D44);

    if(isDefined(riders))
      return riders;
  }

  _id_C5E7FCE963586EC0 = _id_120270BD0A747A35::_id_D378CC95ABAB583B(_id_C5E7FCE963586EC0, _id_171F90B9C4C76D44);
  _id_C5E7FCE963586EC0 = getclosestpointonnavmesh(_id_C5E7FCE963586EC0);

  if(!isDefined(_id_171F90B9C4C76D44))
    _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_C5E7FCE963586EC0);

  if(scripts\cp_mp\utility\game_utility::_id_22CD3D64FDB05892())
    _id_9E334397541DCA8E = [[level._id_04EB71F2B8CBA5CB]](_id_C5E7FCE963586EC0, _id_93390A6953905FEF, team);
  else
    _id_9E334397541DCA8E = [[level._id_04EB71F2B8CBA5CB]](_id_C5E7FCE963586EC0, _id_93390A6953905FEF, team, _id_171F90B9C4C76D44);

  if(isDefined(_id_9E334397541DCA8E)) {
    _id_9E334397541DCA8E.node._id_C5E7FCE963586EC0 = _id_C5E7FCE963586EC0;
    _id_9E334397541DCA8E.node.goalradius = goalradius;
    _id_9E334397541DCA8E.node._id_21F24AECB313E479 = _id_21F24AECB313E479;

    if(isDefined(_id_06DCE075F68546B3))
      _id_9E334397541DCA8E._id_00378D6643D1B02A = _id_06DCE075F68546B3;

    if(!isDefined(groupname))
      groupname = _id_48814951E916AF89::_id_78759441C259F58A(_id_C5E7FCE963586EC0, numagents);

    vehicle = level _id_ACF5238E41722111(_id_9E334397541DCA8E.node, _id_9E334397541DCA8E._id_00378D6643D1B02A, numagents, priority, category, _id_1C9CB43BCF3EB16D, groupname, team, _id_93390A6953905FEF, _id_171F90B9C4C76D44, _id_EC862C2C00C7AB5D, _id_F891E067B8802C0D, _id_EBC42E43F4B05504, _id_8E5A9B658FA525ED, _id_96E335EAE30651E5);

    if(isDefined(vehicle)) {
      if(isDefined(level._id_4691A578582AF454))
        [[level._id_4691A578582AF454]](vehicle);

      return vehicle.riders;
    }
  }

  return undefined;
}

_id_173E2A87C2A19ACC(riders, _id_3EC0CE479098AF29) {
  _id_BAFEF05479604422 = ["little_bird", "veh9_blima"];

  if(isDefined(_id_3EC0CE479098AF29) && _id_3EC0CE479098AF29 != "") {
    _id_BAFEF05479604422 = _id_3EC0CE479098AF29;

    if(!isarray(_id_3EC0CE479098AF29))
      _id_BAFEF05479604422 = [_id_3EC0CE479098AF29];
  }

  if(isDefined(riders)) {
    if(riders > 6)
      _id_BAFEF05479604422 = scripts\engine\utility::array_remove(_id_BAFEF05479604422, "little_bird");

    if(riders > 6)
      _id_BAFEF05479604422 = scripts\engine\utility::array_remove(_id_BAFEF05479604422, "veh9_blima");
  }

  return scripts\engine\utility::random(_id_BAFEF05479604422);
}

_id_BD28FA0797F4D5EC() {
  self endon("death");
  self waittill("pushplayerchanged");
  self pushplayer(1);
}

_id_ACF5238E41722111(_id_A4E4A71852A83D8F, _id_00378D6643D1B02A, _id_C0001A6C73106EE1, priority, category, _id_1C9CB43BCF3EB16D, groupname, team, _id_93390A6953905FEF, _id_171F90B9C4C76D44, _id_EC862C2C00C7AB5D, _id_F891E067B8802C0D, _id_EBC42E43F4B05504, _id_8E5A9B658FA525ED, _id_96E335EAE30651E5) {
  heli_type = _id_173E2A87C2A19ACC(_id_C0001A6C73106EE1, _id_00378D6643D1B02A);

  if(isDefined(_id_00378D6643D1B02A) && _id_00378D6643D1B02A != "")
    heli_type = _id_00378D6643D1B02A;

  if(!isDefined(_id_C0001A6C73106EE1))
    _id_C0001A6C73106EE1 = 6;

  if(!isDefined(_id_F891E067B8802C0D))
    _id_F891E067B8802C0D = 0;

  _id_A3AFFCF53BB2D1F8 = undefined;
  _id_86B5AF97E6866B13 = undefined;
  _id_F0147BB7AD8E1A6C = 10000;
  _id_4E2C8F59BEFD65D4 = getdvarint("scr_heliverticaloffset", 0);

  if(_id_4E2C8F59BEFD65D4)
    _id_F0147BB7AD8E1A6C = _id_4E2C8F59BEFD65D4;

  _id_A13C822AE90E7C51 = 8000;
  _id_4E2C8F59BEFD65D4 = getdvarint("dvar_7B5759D6BF7C3B73", 0);

  if(_id_4E2C8F59BEFD65D4)
    _id_A13C822AE90E7C51 = _id_4E2C8F59BEFD65D4;

  _id_1088737A7169A1BB = undefined;

  if(isDefined(_id_A4E4A71852A83D8F._id_4583939A603F7170)) {
    _id_1088737A7169A1BB = _id_A4E4A71852A83D8F.origin;
    _id_D4F8974F990DE095 = _id_A4E4A71852A83D8F.origin - _id_A4E4A71852A83D8F._id_4583939A603F7170;
    _id_D4F8974F990DE095 = vectorNormalize(_id_D4F8974F990DE095);
    _id_A4E4A71852A83D8F.origin = _id_A4E4A71852A83D8F._id_4583939A603F7170 + _id_D4F8974F990DE095 * _id_A13C822AE90E7C51;
    _id_A4E4A71852A83D8F.origin = _id_A4E4A71852A83D8F.origin + (0, 0, _id_F0147BB7AD8E1A6C);
  }

  _id_BC676A8C07563150 = 0;

  if(isDefined(heli_type)) {
    switch (heli_type) {
      case "veh9_blima":
        _id_BC676A8C07563150 = 2;
        _id_C0001A6C73106EE1 = _id_C0001A6C73106EE1 + 2;
        break;
      case "little_bird":
        _id_BC676A8C07563150 = 2;
        break;
      default:
        break;
    }
  }

  if(isDefined(_id_A4E4A71852A83D8F.spawngroup)) {
    spawngroup = _id_A4E4A71852A83D8F.spawngroup;
    _id_171F90B9C4C76D44 = _id_A4E4A71852A83D8F._id_B205D90302DA2F07;

    if(!isDefined(_id_171F90B9C4C76D44)) {
      if(isDefined(_id_A4E4A71852A83D8F._id_4583939A603F7170))
        _id_3A6B42AB825A103E = _id_A4E4A71852A83D8F._id_4583939A603F7170;
      else
        _id_3A6B42AB825A103E = _id_A4E4A71852A83D8F.origin;

      _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_3A6B42AB825A103E);
      _id_A4E4A71852A83D8F._id_B205D90302DA2F07 = _id_171F90B9C4C76D44;
    }

    logstring("Heli reinforcement spawn: " + _id_C0001A6C73106EE1 + " AI at " + _id_A4E4A71852A83D8F.origin);
    spawners = _id_B276F0690CE15746(heli_type, _id_C0001A6C73106EE1, _id_A4E4A71852A83D8F.origin, _id_A4E4A71852A83D8F._id_B205D90302DA2F07, priority, _id_EC862C2C00C7AB5D, category, team, _id_8E5A9B658FA525ED, _id_96E335EAE30651E5);
    riders = [];
    _id_B5424EBE989B94B4 = 0;

    foreach(index, spawner in spawners) {
      spawner.script_demeanor = undefined;
      rider = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(spawner.aitype, spawner.origin, spawner.angles, priority, category, _id_1C9CB43BCF3EB16D, groupname, team, _id_A4E4A71852A83D8F._id_C5E7FCE963586EC0, _id_A4E4A71852A83D8F._id_B205D90302DA2F07, _id_F891E067B8802C0D, undefined, 0);

      if(isDefined(rider)) {
        rider thread _id_BD28FA0797F4D5EC();

        if(heli_type == "veh9_blima" && !istrue(_id_B5424EBE989B94B4) && _id_C0001A6C73106EE1 <= 4) {
          rider.script_startingposition = 5;
          _id_B5424EBE989B94B4 = 1;
        } else if(isDefined(spawner.script_startingposition))
          rider.script_startingposition = int(spawner.script_startingposition);
        else {
          rider.script_startingposition = _id_BC676A8C07563150;
          _id_BC676A8C07563150++;
        }

        rider.vehicle_position = rider.script_startingposition;
        riders[riders.size] = rider;
        rider thread _id_E7D3411DB935E99B(int(rider.script_startingposition));
      }

      waitframe();
    }

    if(riders.size) {
      spawndata = spawnStruct();
      spawndata.origin = _id_A4E4A71852A83D8F.origin;
      spawndata.angles = _id_A4E4A71852A83D8F.angles;
      spawndata.team = team;
      spawndata._id_F16652E1462A3739 = 1;
      _id_14CDE247AC3313A4 = _id_4A64C621DD8090AB(heli_type, riders, _id_8E5A9B658FA525ED);

      if(isDefined(_id_14CDE247AC3313A4))
        spawndata._id_14CDE247AC3313A4 = _id_14CDE247AC3313A4;

      vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn(heli_type, spawndata);

      if(!isDefined(vehicle)) {
        foreach(rider in riders) {
          _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(rider, "skipDeathCount", 1);
          rider kill();
        }

        return;
      }

      vehicle scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable(vehicle);
      vehicle _meth_247AD6A91F6A4FFE(1);
      vehicle vehphys_forcekeyframedmotion();
      vehicle scripts\cp_mp\vehicles\vehicle_interact::_id_5C097A8F16A227D5(0);

      if(isDefined(_id_1088737A7169A1BB))
        _id_A4E4A71852A83D8F.origin = _id_1088737A7169A1BB;

      vehicle._id_B205D90302DA2F07 = _id_A4E4A71852A83D8F._id_B205D90302DA2F07;
      vehicle endon("death");
      _id_7045FB761A4998E3(vehicle);
      vehicle scripts\cp_mp\vehicles\vehicle::_id_F92FAAAF5C5077C6(riders, 1, 1);

      foreach(rider in riders) {
        if(rider _id_BB0826E06FC68038(heli_type)) {
          _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(rider, "skipDeathCount", 1);
          rider.ignoreme = 1;
        }
      }

      wait 1;

      foreach(rider in riders)
      _id_48814951E916AF89::_id_CAF96A86CA85140F(rider);

      if(heli_type == "veh9_blima")
        vehicle._id_7B349DC60A25D9FE = 1;

      level thread _id_BBFEB6CFDBC102A1(vehicle, _id_A4E4A71852A83D8F, heli_type, _id_EBC42E43F4B05504);
      return vehicle;
      return;
    }

    if(isDefined(_id_1088737A7169A1BB))
      _id_A4E4A71852A83D8F.origin = _id_1088737A7169A1BB;

    _id_E1310878AB1F5E7C(_id_A4E4A71852A83D8F);
    return undefined;
    return;
  } else {
    spawndata = spawnStruct();
    spawndata.origin = _id_A4E4A71852A83D8F.origin;
    spawndata.angles = _id_A4E4A71852A83D8F.angles;
    spawndata.team = team;
    spawndata._id_F16652E1462A3739 = 1;
    vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn(heli_type, spawndata);

    if(isDefined(vehicle)) {
      vehicle scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable(vehicle);
      vehicle _meth_247AD6A91F6A4FFE(1);
      vehicle vehphys_forcekeyframedmotion();
    }

    if(isDefined(_id_1088737A7169A1BB))
      _id_A4E4A71852A83D8F.origin = _id_1088737A7169A1BB;

    _id_E1310878AB1F5E7C(_id_A4E4A71852A83D8F);
    return vehicle;
  }
}

_id_BBFEB6CFDBC102A1(vehicle, _id_A4E4A71852A83D8F, heli_type, _id_EBC42E43F4B05504) {
  vehicle thread _id_88982797150BF237(vehicle, _id_A4E4A71852A83D8F, _id_EBC42E43F4B05504);
  _id_07B02A0C55EEDDF9 = 0;
  _id_516E3BAB99FE629E = undefined;
  _id_4F922AF45D0CAC6C = undefined;
  _id_171F90B9C4C76D44 = undefined;

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_A4E4A71852A83D8F._id_4583939A603F7170);
    _id_4F922AF45D0CAC6C = sortbydistance(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["heliReinforceStruct"]._id_4F922AF45D0CAC6C, _id_A4E4A71852A83D8F._id_4583939A603F7170);
  } else
    _id_4F922AF45D0CAC6C = sortbydistance(level._id_B6D8EEC09E6F3C63._id_4F922AF45D0CAC6C, _id_A4E4A71852A83D8F._id_4583939A603F7170);

  if(!_id_3E4B3C31ABEE91E7(heli_type))
    _id_516E3BAB99FE629E = _id_088B89F0F153D496(_id_A4E4A71852A83D8F, _id_A4E4A71852A83D8F._id_2770AF6F8CECFC40);
  else
    _id_516E3BAB99FE629E = _id_A4E4A71852A83D8F._id_2770AF6F8CECFC40;

  if(!isDefined(_id_516E3BAB99FE629E)) {
    _id_E1310878AB1F5E7C(_id_A4E4A71852A83D8F);
    scripts\cp_mp\vehicles\vehicle::vehicle_death(vehicle);
    msg = "We didn't find an unload location for: " + scripts\engine\utility::_id_53C4C53197386572(_id_171F90B9C4C76D44, "Undefined POI Name") + " at location: " + scripts\engine\utility::_id_53C4C53197386572(_id_A4E4A71852A83D8F._id_4583939A603F7170, "Undefined Unload Origin");
    _ = undefined == msg;
    return;
  }

  vehicle scripts\cp_mp\vehicles\vehicle_interact::_id_5C097A8F16A227D5(1);
  vehicle thread _id_E92BAC7B0B067A7B(_id_A4E4A71852A83D8F._id_4583939A603F7170, heli_type);

  if(istrue(vehicle._id_7B349DC60A25D9FE)) {
    node = _id_516E3BAB99FE629E;
    vehicle.currentnode = node;
    ground_pos = scripts\engine\utility::drop_to_ground(node.origin, 100, -1000);
    scenenode = spawnStruct();
    scenenode.origin = ground_pos;
    scenenode.angles = node.angles;
    vehicle.scenenode = scenenode;
    animation = level.vehicle.templates.aianims[vehicle scripts\common\vehicle_code::get_vehicle_classname()][0].vehicle_getoutanim;
    _id_B48C995A0A557FF1 = getstartorigin(scenenode.origin, scenenode.angles, animation);
    _id_B98CF035C97EDEE9 = getstartangles(scenenode.origin, scenenode.angles, animation);
    vehicle vehicle_teleport(_id_B48C995A0A557FF1, _id_B98CF035C97EDEE9);
    vehicle dontinterpolate();
    vehicle scripts\common\vehicle_paths::unload_node(node);
  } else if(isDefined(_id_516E3BAB99FE629E) && !isDefined(_id_A4E4A71852A83D8F._id_79FA6BD3C9BF6A0D)) {
    if(vehicle scripts\common\vehicle::ishelicopter()) {
      vehicle vehphys_setdefaultmotion();
      vehicle scripts\common\vehicle_paths::vehicle_paths_helicopter(_id_516E3BAB99FE629E);
    } else {}
  }

  vehicle._id_598F3BB771CB1027 = 1;

  if(isDefined(vehicle.currentnode) && isDefined(vehicle.currentnode.target))
    _id_07B02A0C55EEDDF9 = 1;

  if(isDefined(_id_A4E4A71852A83D8F._id_5ABE2C141F995FB2))
    vehicle._id_5ABE2C141F995FB2 = 1;

  if(!_id_07B02A0C55EEDDF9)
    vehicle _id_FC805EC1E7B08264(vehicle.currentnode);

  if(isDefined(_id_A4E4A71852A83D8F._id_72772FA651ECBE2B) && isDefined(level._id_A8DC22C62BA69B88[_id_A4E4A71852A83D8F._id_72772FA651ECBE2B]))
    vehicle thread[[level._id_A8DC22C62BA69B88[_id_A4E4A71852A83D8F._id_72772FA651ECBE2B]]]();

  _id_E1310878AB1F5E7C(_id_A4E4A71852A83D8F);
}

_id_088B89F0F153D496(_id_A4E4A71852A83D8F, _id_7DCE14FB8EAE79C2) {
  end = 3;
  _id_104668542102DC3C = _id_7DCE14FB8EAE79C2;
  _id_DD58D7D9A9AB6F6A = [];
  _id_DD58D7D9A9AB6F6A[0] = _id_104668542102DC3C;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < end; _id_AC0E594AC96AA3A8++) {
    _id_104668542102DC3C = _id_DD58D7D9A9AB6F6A[_id_AC0E594AC96AA3A8];
    _id_104668542102DC3C.script_goalyaw = 1;
    _id_9A47AFBB4CA34DBC = spawnStruct();
    _id_DD58D7D9A9AB6F6A[_id_AC0E594AC96AA3A8 + 1] = _id_9A47AFBB4CA34DBC;

    if(_id_AC0E594AC96AA3A8 == 0) {
      _id_42BD6A036CCC9714 = 1000;
      _id_6BD296FF8DB5AB91 = 1000;
      _id_9A47AFBB4CA34DBC.speed = 10;
      offset = _id_3BD98E79A697CE64(_id_A4E4A71852A83D8F, _id_104668542102DC3C, _id_42BD6A036CCC9714, _id_6BD296FF8DB5AB91);
    } else if(_id_AC0E594AC96AA3A8 == 1) {
      _id_42BD6A036CCC9714 = 0;
      _id_6BD296FF8DB5AB91 = 750;
      _id_9A47AFBB4CA34DBC.speed = 25;
      offset = _id_3BD98E79A697CE64(_id_A4E4A71852A83D8F, _id_104668542102DC3C, _id_42BD6A036CCC9714, _id_6BD296FF8DB5AB91);
    } else {
      _id_42BD6A036CCC9714 = 0;
      _id_6BD296FF8DB5AB91 = 500;
      _id_9A47AFBB4CA34DBC.speed = _id_A4E4A71852A83D8F.speed;
      _id_9A47AFBB4CA34DBC.script_stopnode = 1;
      _id_9A47AFBB4CA34DBC.radius = 100;
      offset = _id_3BD98E79A697CE64(_id_A4E4A71852A83D8F, _id_104668542102DC3C, _id_42BD6A036CCC9714, _id_6BD296FF8DB5AB91);
    }

    _id_9A47AFBB4CA34DBC.origin = _id_104668542102DC3C.origin + offset;
    _id_9A47AFBB4CA34DBC.angles = _id_104668542102DC3C.angles;
    _id_9A47AFBB4CA34DBC.radius = 500;
    _id_9A47AFBB4CA34DBC.target = _id_104668542102DC3C;
  }

  return _id_DD58D7D9A9AB6F6A[_id_DD58D7D9A9AB6F6A.size - 1];
}

_id_3BD98E79A697CE64(start_node, end_node, _id_8847A8B73DD41819, mag) {
  _id_BFD00490746E4860 = start_node.origin - end_node.origin;
  offset = vectorNormalize(_id_BFD00490746E4860);
  offset = offset * mag;
  offset = (offset[0], offset[1], _id_8847A8B73DD41819);
  return offset;
}

_id_E92BAC7B0B067A7B(_id_4583939A603F7170, helitype) {
  self endon("death");
  pos = getgroundposition(_id_4583939A603F7170, 1, 1000, 0);
  dist = 500;
  _id_ABD9EE4725B96FC2 = dist * dist;

  while(distance2dsquared(_id_4583939A603F7170, self.origin) > _id_ABD9EE4725B96FC2)
    wait 0.1;

  if(isDefined(helitype)) {
    if(_id_3E4B3C31ABEE91E7(helitype))
      wait 6;
    else
      wait 1;
  } else
    wait 8;

  magicgrenademanual("smoke_grenade_mp", pos, (0, 0, -10), 0.5);
  thread scripts\engine\utility::play_sound_in_space("smoke_grenade_expl_trans", self.origin);
}

_id_3E4B3C31ABEE91E7(heli_type) {
  switch (heli_type) {
    case "veh9_blima":
      return 1;
    case "little_bird":
      return 0;
  }

  return 0;
}

_id_BB0826E06FC68038(helitype) {
  switch (helitype) {
    case "veh9_blima":
      if(self.vehicle_position == 5 || self.vehicle_position == 6)
        return 1;
    case "little_bird":
      return 0;
  }

  return 0;
}

_id_FC805EC1E7B08264(_id_29376CACC64CC4E6) {
  self endon("death");
  _id_61BEC49FD0BA66B6 = _id_757672B5F0CDE59A(_id_29376CACC64CC4E6);

  if(!isDefined(_id_61BEC49FD0BA66B6)) {
    _id_61BEC49FD0BA66B6 = undefined;

    if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
      _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_29376CACC64CC4E6.origin);
      _id_61BEC49FD0BA66B6 = scripts\engine\utility::random(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["heliReinforceStruct"]._id_144FD45F9438FC65);
    }

    if(!isDefined(_id_61BEC49FD0BA66B6))
      _id_61BEC49FD0BA66B6 = scripts\engine\utility::random(level._id_3122F605F0E8E125);
  }

  ground_pos = getgroundposition(self.origin, 1);

  if(distancesquared(self.origin, ground_pos) <= 1000000) {
    offset = _id_3BD98E79A697CE64(_id_61BEC49FD0BA66B6, self, 1000, 1000);
    _id_07B02A0C55EEDDF9 = spawnStruct();
    _id_07B02A0C55EEDDF9.origin = ground_pos + offset;
    _id_07B02A0C55EEDDF9.angles = _id_29376CACC64CC4E6.angles;
    _id_07B02A0C55EEDDF9.radius = 512;
    self._id_918C5A31037E00EE = spawnStruct();
    self._id_918C5A31037E00EE.speed = 85;
    self vehphys_setdefaultmotion();
    scripts\common\vehicle_paths::vehicle_paths_helicopter(_id_07B02A0C55EEDDF9);
  }

  self.end_point = _id_61BEC49FD0BA66B6;
  _id_A9C45240836FE2A5 = _id_61BEC49FD0BA66B6;
  _id_A9C45240836FE2A5.radius = 1000;
  self._id_918C5A31037E00EE = spawnStruct();
  self._id_918C5A31037E00EE.speed = 85;
  self _meth_247AD6A91F6A4FFE(0);
  self._id_6DF468049C1F41DC = 1;
  thread scripts\common\vehicle_paths::vehicle_paths_helicopter(_id_A9C45240836FE2A5);
}

_id_757672B5F0CDE59A(_id_29376CACC64CC4E6) {
  if(!isDefined(_id_29376CACC64CC4E6)) {
    return;
  }
  if(isDefined(_id_29376CACC64CC4E6.exit_node))
    return _id_29376CACC64CC4E6.exit_node;

  org = _id_29376CACC64CC4E6.origin;
  _id_C4F26C1E0080BD7C = _id_29376CACC64CC4E6.angles;
  _id_2B008B868CC6C2F7 = undefined;

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(org);
    _id_2B008B868CC6C2F7 = level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["heliReinforceStruct"]._id_144FD45F9438FC65;
  } else
    _id_2B008B868CC6C2F7 = level._id_3122F605F0E8E125;

  _id_E627E357CF133EAB = -5;
  _id_14BB0BB2B7D418D7 = undefined;
  _id_8631092C00D598F5 = scripts\engine\utility::get_array_of_closest(org, _id_2B008B868CC6C2F7);

  foreach(struct in _id_8631092C00D598F5) {
    dot = scripts\engine\math::get_dot(org, _id_C4F26C1E0080BD7C, struct.origin);

    if(dot > _id_E627E357CF133EAB) {
      _id_E627E357CF133EAB = dot;
      _id_14BB0BB2B7D418D7 = struct;
    }
  }

  return _id_14BB0BB2B7D418D7;
}

_id_B276F0690CE15746(heli_type, _id_4AF808CB9330A11A, origin, _id_171F90B9C4C76D44, priority, _id_EC862C2C00C7AB5D, category, team, _id_8E5A9B658FA525ED, _id_96E335EAE30651E5) {
  _id_E4353165DD6DE45E = scripts\engine\utility::ter_op(isDefined(level._id_F0872E42DAF6D4D5), level._id_F0872E42DAF6D4D5, origin);
  _id_CA38685E5BF373F4 = (0, 0, 0);
  _id_001250F27C957FEC = 7;

  switch (heli_type) {
    case "veh9_blima":
      _id_001250F27C957FEC = 8;
      break;
    case "little_bird":
      _id_001250F27C957FEC = 6;
      break;
    default:
      break;
  }

  if(_id_4AF808CB9330A11A > _id_001250F27C957FEC)
    _id_4AF808CB9330A11A = _id_001250F27C957FEC;

  riders = [];

  if(!isDefined(category))
    category = "reinforcements";

  _id_0644D90DE7685F75 = _id_48814951E916AF89::_id_8C6DBB64C8E1603C(_id_4AF808CB9330A11A, category, origin, _id_171F90B9C4C76D44, 0);

  if(!_id_0644D90DE7685F75 && !_id_48814951E916AF89::_id_359F24553BDCCA92(_id_4AF808CB9330A11A, priority))
    return riders;

  if(isDefined(_id_EC862C2C00C7AB5D)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_4AF808CB9330A11A; _id_AC0E594AC96AA3A8++) {
      riders[_id_AC0E594AC96AA3A8] = spawnStruct();
      riders[_id_AC0E594AC96AA3A8].origin = _id_E4353165DD6DE45E;
      riders[_id_AC0E594AC96AA3A8].angles = _id_CA38685E5BF373F4;

      if(!isDefined(_id_8E5A9B658FA525ED)) {
        _id_8E5A9B658FA525ED = undefined;

        if(isDefined(level._id_72F834B3F8B2A366) && isDefined(level._id_72F834B3F8B2A366[team]))
          _id_8E5A9B658FA525ED = level._id_72F834B3F8B2A366[team];
      }

      if(isDefined(_id_EC862C2C00C7AB5D._id_DD4F509B9C56C76F[_id_AC0E594AC96AA3A8])) {
        riders[_id_AC0E594AC96AA3A8].aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693(_id_EC862C2C00C7AB5D._id_DD4F509B9C56C76F[_id_AC0E594AC96AA3A8].type, scripts\engine\utility::_id_53C4C53197386572(_id_96E335EAE30651E5, _id_EC862C2C00C7AB5D._id_DD4F509B9C56C76F[_id_AC0E594AC96AA3A8].tier), scripts\engine\utility::_id_53C4C53197386572(_id_EC862C2C00C7AB5D._id_DD4F509B9C56C76F[_id_AC0E594AC96AA3A8]._id_8E5A9B658FA525ED, _id_8E5A9B658FA525ED));
        continue;
      }

      if(_id_EC862C2C00C7AB5D._id_DD4F509B9C56C76F.size) {
        riders[_id_AC0E594AC96AA3A8].aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693(_id_EC862C2C00C7AB5D._id_DD4F509B9C56C76F[0].type, scripts\engine\utility::_id_53C4C53197386572(_id_96E335EAE30651E5, _id_EC862C2C00C7AB5D._id_DD4F509B9C56C76F[0].tier), scripts\engine\utility::_id_53C4C53197386572(_id_EC862C2C00C7AB5D._id_DD4F509B9C56C76F[0]._id_8E5A9B658FA525ED, _id_8E5A9B658FA525ED));
        continue;
      }

      aitype = _id_48814951E916AF89::_id_D5BC07EABF352ABB(undefined, _id_171F90B9C4C76D44, undefined, undefined, _id_96E335EAE30651E5);
    }
  } else {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_4AF808CB9330A11A; _id_AC0E594AC96AA3A8++) {
      aitype = _id_48814951E916AF89::_id_D5BC07EABF352ABB(undefined, _id_171F90B9C4C76D44, undefined, undefined, _id_96E335EAE30651E5, _id_8E5A9B658FA525ED);
      riders[_id_AC0E594AC96AA3A8] = spawnStruct();
      riders[_id_AC0E594AC96AA3A8].origin = _id_E4353165DD6DE45E;
      riders[_id_AC0E594AC96AA3A8].angles = _id_CA38685E5BF373F4;
      riders[_id_AC0E594AC96AA3A8].aitype = aitype;
    }
  }

  return riders;
}

_id_7045FB761A4998E3(vehicle) {
  _id_2A94A31F5C16A229 = ["aq_pilot_fullbody_1", "aq_pilot_fullbody_2"];
  _id_C2A106D998C9F3BE = 2;

  if(!isDefined(level.ai_spawn_vehicle_func))
    level.ai_spawn_vehicle_func = [];

  if(!isDefined(level.vehicle_ai_script_models))
    level.vehicle_ai_script_models = [];

  _id_166C0F7056EDB681 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C2A106D998C9F3BE; _id_AC0E594AC96AA3A8++) {
    struct = level.vehicle.templates.aianims[scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD()).ai.classname][_id_AC0E594AC96AA3A8];
    tag = struct.sittag;
    _id_514D9E806D48B808 = vehicle _id_97DC419EF1552C44(_id_AC0E594AC96AA3A8, tag, struct.idle_anim, struct.idle, _id_2A94A31F5C16A229[_id_AC0E594AC96AA3A8]);
    _id_166C0F7056EDB681[_id_166C0F7056EDB681.size] = _id_514D9E806D48B808;
    level.vehicle_ai_script_models[level.vehicle_ai_script_models.size] = _id_514D9E806D48B808;
    vehicle thread _id_C69AE9CD7A024F7A(_id_166C0F7056EDB681);
  }
}

_id_C69AE9CD7A024F7A(_id_166C0F7056EDB681) {
  self waittill("death");

  if(isDefined(_id_166C0F7056EDB681)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_166C0F7056EDB681.size; _id_AC0E594AC96AA3A8++)
      _id_166C0F7056EDB681[_id_AC0E594AC96AA3A8] _id_3A1B698F5E1A66DA();
  }
}

_id_3A1B698F5E1A66DA() {
  if(scripts\engine\utility::array_contains(level.vehicle_ai_script_models, self))
    level.vehicle_ai_script_models = scripts\engine\utility::array_remove(level.vehicle_ai_script_models, self);

  if(isDefined(self))
    self delete();
}

_id_97DC419EF1552C44(_id_DCEF536353EA980B, tag, animname, xanim, model) {
  _id_2626560098D08682 = self gettagorigin(tag);
  _id_B7850001037AA074 = self gettagangles(tag);
  _id_D917428537562C1F = getstartorigin(_id_2626560098D08682, _id_B7850001037AA074, xanim);
  startangles = getstartangles(_id_2626560098D08682, _id_B7850001037AA074, xanim);
  spawned = spawn("script_model", _id_D917428537562C1F);
  spawned.angles = startangles;
  spawned setModel(model);
  spawned linkTo(self);

  if(isDefined(animname))
    spawned scriptmodelplayanim(animname);
  else if(isDefined(xanim))
    spawned scriptmodelplayanim(xanim);

  spawned.vehicle_position = _id_DCEF536353EA980B;
  spawned.disable_gun_recall = 1;
  self.attachedguys[self.attachedguys.size] = spawned;
  self.usedpositions[_id_DCEF536353EA980B] = 1;

  if(_id_DCEF536353EA980B == 0)
    self.driver = spawned;

  return spawned;
}

_id_369DA33099ABB357(_id_C2F1CA305EE16808) {
  self endon("death");
  _id_C2F1CA305EE16808 endon("death");

  if(!isDefined(self) || !isDefined(_id_C2F1CA305EE16808)) {
    return;
  }
  _id_4116E8FD5DA7B698 = 250;

  for(;;) {
    self waittill("damage", amount, attacker, _id_97282C14346A7FCF, point);

    if(isDefined(attacker) && isPlayer(attacker) && isDefined(amount) && amount > 0 && isDefined(point)) {
      if(_id_C2F1CA305EE16808 tagexists("j_head"))
        _id_07461C788CFBE49A = _id_C2F1CA305EE16808 gettagorigin("j_head");
      else
        _id_07461C788CFBE49A = _id_C2F1CA305EE16808.origin + (0, 0, 50);

      _id_07461C788CFBE49A = _id_07461C788CFBE49A + (0, 0, -20);
      start_point = attacker getEye();
      _id_0DE2DC247CDCB29A = vectorNormalize(point - start_point);
      _id_16577D6CD42AB23C = vectorNormalize(_id_07461C788CFBE49A - start_point);
      _id_F22FD5F94653CCB6 = vectordot(_id_0DE2DC247CDCB29A, _id_16577D6CD42AB23C);
      _id_7B3AA6FEBD7B23A0 = vectordot(vectorNormalize(anglesToForward(self.angles)), vectorNormalize(point - self.origin));
      _id_C4B0CACB2BBAB0E5 = _id_C2F1CA305EE16808.origin + (0, 0, 18);

      if(_id_F22FD5F94653CCB6 > 0.99975 && _id_7B3AA6FEBD7B23A0 > 0.73 && point[2] > _id_C4B0CACB2BBAB0E5[2]) {
        _id_4116E8FD5DA7B698 = _id_4116E8FD5DA7B698 - amount;

        if(_id_4116E8FD5DA7B698 <= 0)
          self notify("death", attacker);
      }
    }
  }
}

_id_E7D3411DB935E99B(pos) {
  self endon("death");
  wait 2;
  self.vehicle_position = pos;
  self.script_startingposition = pos;
}

_id_88982797150BF237(vehicle, _id_A4E4A71852A83D8F, _id_EBC42E43F4B05504) {
  vehicle endon("death");
  riders = vehicle.riders;

  if(!istrue(_id_EBC42E43F4B05504) && isDefined(_id_A4E4A71852A83D8F._id_C5E7FCE963586EC0)) {
    foreach(rider in riders)
    _id_120270BD0A747A35::_id_0BD9ACC7C99AD884(rider, _id_A4E4A71852A83D8F._id_C5E7FCE963586EC0, undefined, _id_A4E4A71852A83D8F.goalradius, _id_A4E4A71852A83D8F._id_21F24AECB313E479, 0, riders);
  }

  vehicle waittill("unloaded");
  _id_C5E7FCE963586EC0 = _id_A4E4A71852A83D8F._id_C5E7FCE963586EC0;

  if(!isDefined(_id_C5E7FCE963586EC0))
    _id_C5E7FCE963586EC0 = _id_A130DE01F9E62AA4(vehicle.origin);

  wait 1;

  foreach(rider in riders) {
    if(!istrue(_id_EBC42E43F4B05504))
      rider thread _id_120270BD0A747A35::_id_A5117518725DA028(rider, _id_C5E7FCE963586EC0, undefined, _id_A4E4A71852A83D8F.goalradius, _id_A4E4A71852A83D8F._id_21F24AECB313E479, 0, riders);

    if(isDefined(rider._id_B582B10663B5B2A9) && !rider._id_B582B10663B5B2A9) {
      continue;
    }
    rider thread _id_0E42F5EC55B8546B();
  }
}

_id_0E42F5EC55B8546B() {
  self endon("death");
  wait 10;
  self._id_B582B10663B5B2A9 = 1;
}

_id_A130DE01F9E62AA4(origin, _id_FBB99CD7FA27E8B4) {
  if(level._id_B6D8EEC09E6F3C63._id_C9464C89A69010E2.size == 0) {
    radius = 1000;
    _id_C154E6E386654A30 = 50;
    min = radius - _id_C154E6E386654A30;
    max = radius + _id_C154E6E386654A30;
    _id_BCFEC646853A95C1 = randomfloatrange(min, max) * scripts\engine\utility::ter_op(randomint(100) > 50, 1, -1);
    _id_BCFEC546853A938E = randomfloatrange(min, max) * scripts\engine\utility::ter_op(randomint(100) > 50, 1, -1);
    _id_28545E194202F384 = (origin[0] + _id_BCFEC646853A95C1, origin[1] + _id_BCFEC546853A938E, origin[2]);
    return getclosestpointonnavmesh(_id_28545E194202F384);
  }

  _id_260A7567900F4224 = [];
  _id_D6EB01B1DC33FFDC = undefined;
  _id_42CA41C7DADAE0C0 = 2500000000;
  maxdist = scripts\engine\utility::ter_op(isDefined(_id_FBB99CD7FA27E8B4), _id_FBB99CD7FA27E8B4, 12250000);

  foreach(node in level._id_B6D8EEC09E6F3C63._id_C9464C89A69010E2) {
    dist = distance2dsquared(origin, node.origin);

    if(!isDefined(_id_D6EB01B1DC33FFDC) || _id_42CA41C7DADAE0C0 > dist) {
      _id_D6EB01B1DC33FFDC = node;
      _id_42CA41C7DADAE0C0 = dist;
    }

    if(dist < maxdist)
      _id_260A7567900F4224[_id_260A7567900F4224.size] = node;
  }

  if(_id_260A7567900F4224.size > 0)
    return getclosestpointonnavmesh(scripts\engine\utility::random(_id_260A7567900F4224).origin);
  else
    return getclosestpointonnavmesh(_id_D6EB01B1DC33FFDC.origin);
}

_id_16C5CA10B4C664A7(nodes, override) {
  if(istrue(override))
    level._id_B6D8EEC09E6F3C63._id_C9464C89A69010E2 = [];

  foreach(node in nodes)
  level._id_B6D8EEC09E6F3C63._id_C9464C89A69010E2[level._id_B6D8EEC09E6F3C63._id_C9464C89A69010E2.size] = node;
}

_id_BF8AB11DD9E76F93(function) {
  level._id_04EB71F2B8CBA5CB = function;
}

_id_4A64C621DD8090AB(heli_type, riders, _id_8E5A9B658FA525ED) {
  if(heli_type == "little_bird") {
    if(isDefined(_id_8E5A9B658FA525ED)) {
      if(_id_8E5A9B658FA525ED == "merc" || _id_8E5A9B658FA525ED == "ru")
        return "black";
      else if(_id_8E5A9B658FA525ED == "cartel")
        return "yellow";
    }
  }
}
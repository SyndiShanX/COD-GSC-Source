/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_64acb6ce534155b7.gsc
***********************************************/

_id_BF4FD0B5A7C2F528() {
  if(!getdvarint("dvar_56D4C1121BFFCDF1", 1)) {
    return;
  }
  if(scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm") {
    return;
  }
  level._id_41F4BC9EE8C7C9C6 = spawnStruct();
  level._id_816DBC1FF5F29EB1 = getDvar("dvar_F7685D2B82851266", "mp/br_contracts.csv");
  _id_7630FA0C7B8A8999();
  inittablets();
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::onplayerdisconnect);
  _id_5238DEE479BBF7FB::setupcirclepeek();
  _id_3FF084F114B7F6C9::_id_F3D757808130BAC4(::_id_6BDC6F56944DC3AA);
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::_id_7871E27C25160F63);
  game["dialog"]["mission_gen_accept"] = "gncn_wzan_msst";
  game["dialog"]["mission_misc_success"] = "gncn_wzan_mssc";
  game["dialog"]["mission_obj_change"] = "gncn_wzan_objn";
  game["dialog"]["mission_obj_moved"] = "gncn_wzan_objr";
  game["dialog"]["mission_obj_next_ptarget"] = "gncn_wzan_trgn";
  game["dialog"]["mission_obj_next_nptarget"] = "gncn_wzan_objn";
  game["dialog"]["mission_obj_warning_time"] = "gncn_wzan_mstw";
  game["dialog"]["mission_obj_warning_capture"] = "mission_mission_obj_warning_capture";
  game["dialog"]["mission_obj_circle_fail"] = "gncn_wzan_msfr";
  game["dialog"]["mission_gen_fail"] = "gncn_wzan_msfl";
  game["dialog"]["mission_gen_fail_time"] = "gncn_wzan_msto";
  game["dialog"]["mission_teammate_down"] = "tmmd_wzan_mssn";
  game["dialog"]["mission_enemy_down"] = "enmd_wzan_mssn";
  level._effect["vfx_dom_flare"] = loadfx("vfx/iw8_br/gameplay/vfx_br_flare_dom");
  level._effect["vfx_revive_flare"] = loadfx("vfx/iw8_br/gameplay/vfx_br_flare_revive");
  level._effect["vfx_smktrail_mortar"] = loadfx("vfx/iw8_br/gameplay/vfx_br_flare_smktrail");
  level._effect["vfx_marker_base_orange_pulse"] = loadfx("vfx/iw8_br/gameplay/vfx_br_tr_marker.vfx");
  level.brmodevariantrewardcullfunc = undefined;
  _id_2695A20D4011076D::_id_ECA79FA0F341EE08(3, ::dangercircletick, ::_id_1A1709943670772A, ::_id_6AC289B030B7CABE);
}

_id_7630FA0C7B8A8999() {
  _id_056EDBAF6AE77E7E = tablelookupgetnumrows(level._id_816DBC1FF5F29EB1);
  level._id_41F4BC9EE8C7C9C6._id_7BA7458B5FC820F7 = [];
  level._id_41F4BC9EE8C7C9C6._id_766F9DE01948C219 = [];
  level._id_41F4BC9EE8C7C9C6._id_8764D5E454E66EA3 = [];
  level._id_41F4BC9EE8C7C9C6._id_B6FAE9C9655C73BF = [];
  level._id_41F4BC9EE8C7C9C6._id_AB841CFACA2F23AD = [];
  level._id_41F4BC9EE8C7C9C6._id_8F51BBE0D6629B2C = [];
  level._id_41F4BC9EE8C7C9C6._id_8E0F287A7B13DA80 = [];
  level._id_41F4BC9EE8C7C9C6.defaultfilter = [];
  level._id_41F4BC9EE8C7C9C6.defaultfilter[0] = ::filtercondition_isdead;
  level._id_41F4BC9EE8C7C9C6.defaultfilter[1] = ::filtercondition_ingulag;
  level._id_41F4BC9EE8C7C9C6.rewards = spawnStruct();
  level._id_41F4BC9EE8C7C9C6.rewards.categorytogroup = [];
  level._id_41F4BC9EE8C7C9C6.rewards.grouptorewards = [];
  level._id_41F4BC9EE8C7C9C6.rewards.scalertoscaleinfo = [];
  level._id_41F4BC9EE8C7C9C6.rewards.rewardtotype = [];
  level._id_41F4BC9EE8C7C9C6.rewards.rewardtovalue = [];
  level._id_41F4BC9EE8C7C9C6.tiers = [];
  level._id_41F4BC9EE8C7C9C6._id_5C6031BDE94872A7 = "MP_BR_INGAME/CONTRACT_CANCEL_TIME";
  level._id_41F4BC9EE8C7C9C6._id_8084CAC3D31A6BEE = "MP_BR_INGAME/CONTRACT_CANCEL";

  for(_id_CF471964FC31F4EE = 0; _id_CF471964FC31F4EE < _id_056EDBAF6AE77E7E; _id_CF471964FC31F4EE++) {
    _id_7BA7458B5FC820F7 = spawnStruct();
    _id_7BA7458B5FC820F7.index = _id_CF471964FC31F4EE;
    _id_7BA7458B5FC820F7.enabled = int(tablelookupbyrow(level._id_816DBC1FF5F29EB1, _id_CF471964FC31F4EE, 1));
    _id_7BA7458B5FC820F7.ref = tablelookupbyrow(level._id_816DBC1FF5F29EB1, _id_CF471964FC31F4EE, 0);
    _id_7BA7458B5FC820F7._id_A0CE8000D303764C = tablelookupbyrow(level._id_816DBC1FF5F29EB1, _id_CF471964FC31F4EE, 2);
    _id_7BA7458B5FC820F7.funcs = [];

    switch (_id_7BA7458B5FC820F7.ref) {
      case "dom":
        _id_25E2B333B4736A48::_id_FB7271D5EE18B98D(_id_7BA7458B5FC820F7);
        break;
      case "assassination":
        _id_02BDEFC4B5300716::_id_FB7271D5EE18B98D(_id_7BA7458B5FC820F7);
        break;
      case "vip":
        _id_160D0F1B81840667::_id_FB7271D5EE18B98D(_id_7BA7458B5FC820F7);
        break;
      case "scavenger":
        _id_283E1E9E47346FDC::_id_FB7271D5EE18B98D(_id_7BA7458B5FC820F7);
        break;
      case "timedrun":
        _id_280C491864F4733C::_id_FB7271D5EE18B98D(_id_7BA7458B5FC820F7);
        break;
      case "demo":
        _id_4E77EB48DF5875EE::_id_FB7271D5EE18B98D(_id_7BA7458B5FC820F7);
        break;
      case "intel":
        _id_1C9FA9BFB0A2FD44::_id_FB7271D5EE18B98D(_id_7BA7458B5FC820F7);
        break;
      case "safecracker":
        _id_29E75E5EBECA383D::_id_FB7271D5EE18B98D(_id_7BA7458B5FC820F7);
        break;
      case "elite_arrow":
        _id_728FFCEE8CBF30EE::_id_FB7271D5EE18B98D(_id_7BA7458B5FC820F7);
        break;
      case "strongholdInfil":
        _id_28A1EB678D22E4E3::_id_FB7271D5EE18B98D(_id_7BA7458B5FC820F7);
        break;
      case "searchseizure":
        _id_2190C693B7121AB3::_id_FB7271D5EE18B98D(_id_7BA7458B5FC820F7);
        break;
      case "hacker_phone":
        _id_3FF2458477D23489::_id_FB7271D5EE18B98D(_id_7BA7458B5FC820F7);
        break;
      case "dom_legacy":
      case "timedrun_legacy":
      case "scavenger_legacy":
      case "assassination_legacy":
      case "vip_legacy":
        break;
      default:
    }

    level._id_41F4BC9EE8C7C9C6._id_7BA7458B5FC820F7[level._id_41F4BC9EE8C7C9C6._id_7BA7458B5FC820F7.size] = _id_7BA7458B5FC820F7;
    level._id_41F4BC9EE8C7C9C6._id_766F9DE01948C219[_id_7BA7458B5FC820F7.ref] = _id_7BA7458B5FC820F7;
    level._id_41F4BC9EE8C7C9C6._id_8764D5E454E66EA3[_id_7BA7458B5FC820F7._id_A0CE8000D303764C] = _id_7BA7458B5FC820F7;
  }

  _id_4DB88B018963D039 = tablelookupgetnumrows("mp/brmissions.csv");

  for(_id_82A1684FCFE6E4F5 = 0; _id_82A1684FCFE6E4F5 < _id_4DB88B018963D039; _id_82A1684FCFE6E4F5++) {
    state = spawnStruct();
    state.index = int(tablelookupbyrow("mp/brmissions.csv", _id_82A1684FCFE6E4F5, 0));
    state.ref = tablelookupbyrow("mp/brmissions.csv", _id_82A1684FCFE6E4F5, 1);
    state._id_1BBEB265EF74BC60 = tablelookupbyrow("mp/brmissions.csv", _id_82A1684FCFE6E4F5, 18);
    level._id_41F4BC9EE8C7C9C6._id_8F51BBE0D6629B2C[state.ref] = state;
  }
}

inittablets() {
  level._id_41F4BC9EE8C7C9C6.activetablets = [];
  level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46 = [];
  level._id_41F4BC9EE8C7C9C6._id_A140D7E8412B4051 = [];
  level._id_41F4BC9EE8C7C9C6._id_546B3948246E4AA3 = [];
  level._id_41F4BC9EE8C7C9C6._id_B6012B6FFDB53601 = [];
  _id_64D2F24DF5D49616 = 0.0;
  _id_D1358DA240D157C5 = getdvarfloat("dvar_4EC62B4599196026", 0.667);
  _id_18D89C513B75CAF6 = [];
  _id_7B18BF75C63CF8BE = getdvarint("dvar_61D045AA9B2D5565", 1);
  _id_4C41F1D284A449F2 = getdvarint("dvar_3B86F15E6AB5C0B0", 0);

  if(_id_7B18BF75C63CF8BE > 0 && isDefined(level._id_DBB3DD5AB77CCD48)) {
    foreach(_id_B205D90302DA2F07 in level._id_DBB3DD5AB77CCD48)
    _id_18D89C513B75CAF6[_id_B205D90302DA2F07] = _id_7B18BF75C63CF8BE;
  }

  _id_F7561229EB9C2C64 = 0;

  foreach(type in level._id_41F4BC9EE8C7C9C6._id_7BA7458B5FC820F7) {
    _id_E0D1E3A2B6F5323A = getentitylessscriptablearray(type._id_A0CE8000D303764C);

    if(!type.enabled) {
      foreach(tablet in _id_E0D1E3A2B6F5323A)
      _id_2AA2583AA4C84697(tablet);

      continue;
    }

    level._id_41F4BC9EE8C7C9C6._id_546B3948246E4AA3[type._id_A0CE8000D303764C] = 0;
    level._id_41F4BC9EE8C7C9C6._id_B6012B6FFDB53601[type._id_A0CE8000D303764C] = 0;

    if(isDefined(type._id_2F8B14DBB63CC32A))
      _id_64D2F24DF5D49616 = type._id_2F8B14DBB63CC32A;
    else
      _id_64D2F24DF5D49616 = _id_D1358DA240D157C5;

    _id_6D130EBB53AD2136 = getdvarfloat("dvar_341FD6B76F01C2E8", 1200.0);

    if(_id_6D130EBB53AD2136 > 0 && _id_E0D1E3A2B6F5323A.size > 0) {
      foreach(_id_15B89FF206500554 in level.br_armory_kiosk.scriptables) {
        _id_7BA908D45C350CA4 = getlootscriptablearrayinradius(type._id_A0CE8000D303764C, undefined, _id_15B89FF206500554.origin, _id_6D130EBB53AD2136);

        foreach(_id_EDBA0A1C91AB84BF in _id_7BA908D45C350CA4)
        _id_EDBA0A1C91AB84BF._id_BB2CD2998CC6E4AB = 1;
      }

      for(_id_AC0E594AC96AA3A8 = _id_E0D1E3A2B6F5323A.size - 1; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
        if(!istrue(_id_E0D1E3A2B6F5323A[_id_AC0E594AC96AA3A8]._id_BB2CD2998CC6E4AB)) {
          continue;
        }
        _id_E0D1E3A2B6F5323A[_id_AC0E594AC96AA3A8]._id_BB2CD2998CC6E4AB = undefined;
        result = _id_2AA2583AA4C84697(_id_E0D1E3A2B6F5323A[_id_AC0E594AC96AA3A8]);
        _id_E0D1E3A2B6F5323A[_id_AC0E594AC96AA3A8] = _id_E0D1E3A2B6F5323A[_id_E0D1E3A2B6F5323A.size - 1];
        _id_E0D1E3A2B6F5323A[_id_E0D1E3A2B6F5323A.size - 1] = undefined;
      }
    }

    for(_id_AC0E594AC96AA3A8 = _id_E0D1E3A2B6F5323A.size - 1; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
      tablet = _id_E0D1E3A2B6F5323A[_id_AC0E594AC96AA3A8];
      tablet tabletinit(type);

      if(!tablet.init || _id_4948CDF739393D2D::_id_F0201365C368CF88(tablet.origin) || !_id_2695A20D4011076D::_id_D449927F9683E871(tablet.origin)) {
        result = _id_2AA2583AA4C84697(tablet);
        _id_E0D1E3A2B6F5323A[_id_AC0E594AC96AA3A8] = _id_E0D1E3A2B6F5323A[_id_E0D1E3A2B6F5323A.size - 1];
        _id_E0D1E3A2B6F5323A[_id_E0D1E3A2B6F5323A.size - 1] = undefined;
      }
    }

    _id_F7561229EB9C2C64 = _id_F7561229EB9C2C64 + _id_E0D1E3A2B6F5323A.size;

    if(_id_E0D1E3A2B6F5323A.size)
      setobjectivetypesomvarbit(type);

    _id_2C3363605ABB4836 = _id_E0D1E3A2B6F5323A.size * _id_64D2F24DF5D49616;
    _id_5731F7181809474A = int(_id_2C3363605ABB4836);
    _id_C678B652D11243B9 = _id_2C3363605ABB4836 - _id_5731F7181809474A;

    if(randomfloat(1.0) < _id_C678B652D11243B9)
      _id_5731F7181809474A++;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_5731F7181809474A; _id_AC0E594AC96AA3A8++) {
      _id_2ADBA961C731BAF6 = randomintrange(0, _id_E0D1E3A2B6F5323A.size);
      tablet = _id_E0D1E3A2B6F5323A[_id_2ADBA961C731BAF6];
      level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46[level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46.size] = _id_E0D1E3A2B6F5323A[_id_2ADBA961C731BAF6];
      _id_E0D1E3A2B6F5323A[_id_2ADBA961C731BAF6] = _id_E0D1E3A2B6F5323A[_id_E0D1E3A2B6F5323A.size - 1];
      _id_E0D1E3A2B6F5323A[_id_E0D1E3A2B6F5323A.size - 1] = undefined;
    }

    foreach(tablet in _id_E0D1E3A2B6F5323A) {
      if(_id_18D89C513B75CAF6.size > 0) {
        _id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(tablet.origin);

        if(isDefined(_id_18D89C513B75CAF6[_id_B205D90302DA2F07])) {
          _id_18D89C513B75CAF6[_id_B205D90302DA2F07]--;

          if(!_id_18D89C513B75CAF6[_id_B205D90302DA2F07])
            _id_18D89C513B75CAF6[_id_B205D90302DA2F07] = undefined;
        }
      }
    }

    foreach(tablet in _id_E0D1E3A2B6F5323A) {
      if(_id_4C41F1D284A449F2 > 0) {
        if(_id_2695A20D4011076D::_id_D449927F9683E871(tablet.origin))
          _id_4C41F1D284A449F2--;
      }
    }

    foreach(tablet in _id_E0D1E3A2B6F5323A)
    tablet tabletshow();
  }

  if(_id_18D89C513B75CAF6.size) {
    level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46 = scripts\engine\utility::array_randomize(level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46);

    for(_id_AC0E594AC96AA3A8 = level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46.size - 1; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
      tablet = level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46[_id_AC0E594AC96AA3A8];
      _id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(tablet.origin);

      if(isDefined(_id_18D89C513B75CAF6[_id_B205D90302DA2F07])) {
        level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46[_id_AC0E594AC96AA3A8] = level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46[level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46.size - 1];
        level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46[level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46.size - 1] = undefined;
        tablet tabletshow();
        _id_18D89C513B75CAF6[_id_B205D90302DA2F07]--;

        if(!_id_18D89C513B75CAF6[_id_B205D90302DA2F07]) {
          _id_18D89C513B75CAF6[_id_B205D90302DA2F07] = undefined;

          if(!_id_18D89C513B75CAF6.size) {
            break;
          }
        }
      }
    }
  }

  if(_id_4C41F1D284A449F2 > 0) {
    level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46 = scripts\engine\utility::array_randomize(level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46);

    for(_id_AC0E594AC96AA3A8 = level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46.size - 1; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
      tablet = level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46[_id_AC0E594AC96AA3A8];

      if(_id_2695A20D4011076D::_id_D449927F9683E871(tablet.origin)) {
        level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46[_id_AC0E594AC96AA3A8] = level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46[level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46.size - 1];
        level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46[level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46.size - 1] = undefined;
        tablet tabletshow();
        _id_4C41F1D284A449F2--;

        if(_id_4C41F1D284A449F2 == 0) {
          break;
        }
      }
    }
  }

  _id_391489A137DD38A1 = squared(getdvarint("dvar_526A7311F94AE394", 0));

  if(_id_391489A137DD38A1 > 0) {
    _id_380E9CBE80C1F6CA = 0;
    _id_65462A5DF4649B45 = [];

    for(_id_AC0E594AC96AA3A8 = level._id_41F4BC9EE8C7C9C6.activetablets.size - 1; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
      tablet = level._id_41F4BC9EE8C7C9C6.activetablets[_id_AC0E594AC96AA3A8];

      if(tablet _id_26073A27A7BC12E1(_id_391489A137DD38A1)) {
        level._id_41F4BC9EE8C7C9C6.activetablets[_id_AC0E594AC96AA3A8] = level._id_41F4BC9EE8C7C9C6.activetablets[level._id_41F4BC9EE8C7C9C6.activetablets.size - 1];
        level._id_41F4BC9EE8C7C9C6.activetablets[level._id_41F4BC9EE8C7C9C6.activetablets.size - 1] = undefined;
        _id_65462A5DF4649B45[_id_65462A5DF4649B45.size] = tablet;
        _id_380E9CBE80C1F6CA++;
      }
    }

    level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46 = scripts\engine\utility::array_randomize(level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46);

    for(_id_AC0E594AC96AA3A8 = level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46.size - 1; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
      if(_id_380E9CBE80C1F6CA == 0) {
        break;
      }

      tablet = level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46[_id_AC0E594AC96AA3A8];

      if(!tablet _id_26073A27A7BC12E1(_id_391489A137DD38A1)) {
        tablet tabletshow();
        level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46[_id_AC0E594AC96AA3A8] = level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46[level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46.size - 1];
        level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46[level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46.size - 1] = undefined;
        _id_380E9CBE80C1F6CA--;
      }
    }

    level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46 = scripts\engine\utility::array_combine(level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46, _id_65462A5DF4649B45);
  }

  level thread _id_968DF0AF5E2D28EA();
  _id_3CD9B1B9F24084FA = level._id_41F4BC9EE8C7C9C6.activetablets.size;
  _id_89053505DA6157D0 = level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46.size;
  level thread _id_77DA9DEF0C368FC3();
  _id_715028F54BAD19A1::branalytics_inittablets(_id_F7561229EB9C2C64, _id_3CD9B1B9F24084FA, _id_89053505DA6157D0, _id_64D2F24DF5D49616);

  if(_id_362C58E8BB39BCDA::isfeatureenabled("tabletReplace"))
    level._id_41F4BC9EE8C7C9C6 thread tabletreplace();
  else
    level._id_41F4BC9EE8C7C9C6 thread delayedshowtablets();

  level notify("contractmanager_inittablets_done");
}

_id_26073A27A7BC12E1(_id_4073DFE8BF38BA47) {
  foreach(tablet in level._id_41F4BC9EE8C7C9C6.activetablets) {
    if(!isDefined(tablet) || !isDefined(tablet.origin)) {
      continue;
    }
    if(tablet == self) {
      continue;
    }
    if(distance2dsquared(self.origin, tablet.origin) < _id_4073DFE8BF38BA47)
      return 1;
  }

  return 0;
}

setobjectivetypesomvarbit(type) {
  index = _id_3D262D56274BD22E(type.ref);
  setomnvarbit("ui_br_objective_types", index, 1);
}

tabletreplace() {
  if(!isDefined(level.br_level)) {
    return;
  }
  scripts\mp\flags::gameflagwait("prematch_done");
  level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46 = scripts\engine\utility::array_randomize(level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46);
  _id_FB4145CF6A25541E = 0;
  _id_40FB495A4451D505 = level.tabletreplacefrequency;
  _id_AC0E594AC96AA3A8 = 0;

  while(_id_AC0E594AC96AA3A8 < level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46.size) {
    tablet = level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46[_id_AC0E594AC96AA3A8];
    level waittill("quest_started");

    if(isDefined(level.tabletreplacefrequency) && level.tabletreplacefrequency != -1) {
      _id_FB4145CF6A25541E++;

      if(_id_FB4145CF6A25541E >= _id_40FB495A4451D505) {
        tablet tabletshow();
        _id_40FB495A4451D505 = _id_40FB495A4451D505 + level.tabletreplacefrequency;
        _id_AC0E594AC96AA3A8++;
      }

      continue;
    }

    tablet tabletshow();
    _id_AC0E594AC96AA3A8++;
  }
}

_id_FE5D4D0A6A530B1E(_id_1BBEB265EF74BC60, origin, angles) {
  foreach(data in level._id_41F4BC9EE8C7C9C6._id_7BA7458B5FC820F7) {
    ref = data.ref;

    if(ref == _id_1BBEB265EF74BC60) {
      _id_EE6EA77813E3C559 = spawnscriptable(data._id_A0CE8000D303764C, origin, angles);
      _id_7E52B56769FA7774::registerscriptableinstance(_id_EE6EA77813E3C559);
      _id_EE6EA77813E3C559 tabletinit(data);
      _id_EE6EA77813E3C559 tabletshow();
      return _id_EE6EA77813E3C559;
    }
  }
}

delayedshowtablets() {
  if(!isDefined(level.br_level)) {
    return;
  }
  _id_0046599DAB79A549 = level.br_level.br_circledelaytimes.size - 1 - getdvarint("dvar_96878DA693689CCD", 4);
  _id_F5F66E7F9CB52C09 = getdvarfloat("dvar_743253D28CD0D1F7", 0.3);
  scripts\mp\flags::gameflagwait("prematch_done");
  _id_0495D2ED937E965E = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46.size; _id_AC0E594AC96AA3A8++) {
    tablet = level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46[_id_AC0E594AC96AA3A8];
    tablet.circleindex = _id_58F20490049AF6AC::_id_D5CF183EE258BEFB(tablet.origin);

    if(tablet.circleindex >= 0)
      _id_0495D2ED937E965E[_id_0495D2ED937E965E.size] = tablet;
  }

  level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46 = scripts\engine\utility::array_randomize(_id_0495D2ED937E965E);

  for(;;) {
    level waittill("br_circle_set");

    if(!level.br_circle.circleindex) {
      _id_715028F54BAD19A1::branalytics_delayedshowtablets(0, _id_F5F66E7F9CB52C09, _id_0495D2ED937E965E.size, 0);
      continue;
    }

    _id_391489A137DD38A1 = squared(getdvarint("dvar_526A7311F94AE394", 0));
    _id_0495D2ED937E965E = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46.size; _id_AC0E594AC96AA3A8++) {
      tablet = level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46[_id_AC0E594AC96AA3A8];

      if(tablet.circleindex >= level.br_circle.circleindex) {
        if(!_id_EBDF8F6E61C84882(tablet)) {
          continue;
        }
        if(_id_391489A137DD38A1 > 0) {
          if(tablet _id_26073A27A7BC12E1(_id_391489A137DD38A1))
            continue;
        }

        _id_0495D2ED937E965E[_id_0495D2ED937E965E.size] = tablet;
      }
    }

    if(_id_391489A137DD38A1 > 0 && _id_0495D2ED937E965E.size) {
      for(_id_AC0E594AC96AA3A8 = _id_0495D2ED937E965E.size - 1; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
        tablet = _id_0495D2ED937E965E[_id_AC0E594AC96AA3A8];

        foreach(other in _id_0495D2ED937E965E) {
          if(other == tablet) {
            continue;
          }
          if(distance2dsquared(other.origin, tablet.origin) < _id_391489A137DD38A1) {
            _id_0495D2ED937E965E[_id_AC0E594AC96AA3A8] = _id_0495D2ED937E965E[_id_0495D2ED937E965E.size - 1];
            _id_0495D2ED937E965E[_id_0495D2ED937E965E.size - 1] = undefined;
            break;
          }
        }
      }
    }

    _id_8FA722572853FFB7 = int(ceil(_id_0495D2ED937E965E.size * _id_F5F66E7F9CB52C09));
    _id_CF6DC40CA9D1B393 = int(max(0, getdvarint("dvar_6CD10C5D6E2A6220", 100) - level._id_41F4BC9EE8C7C9C6.activetablets.size));
    _id_8FA722572853FFB7 = int(min(_id_8FA722572853FFB7, _id_CF6DC40CA9D1B393));

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_8FA722572853FFB7; _id_AC0E594AC96AA3A8++) {
      tablet = _id_0495D2ED937E965E[_id_AC0E594AC96AA3A8];
      tablet tabletshow();
    }

    level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46 = [];

    for(_id_AC0E594AC96AA3A8 = _id_8FA722572853FFB7; _id_AC0E594AC96AA3A8 < _id_0495D2ED937E965E.size; _id_AC0E594AC96AA3A8++)
      level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46[level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46.size] = _id_0495D2ED937E965E[_id_AC0E594AC96AA3A8];

    _id_715028F54BAD19A1::branalytics_delayedshowtablets(level.br_circle.circleindex, _id_F5F66E7F9CB52C09, _id_0495D2ED937E965E.size, _id_8FA722572853FFB7);

    if(level.br_circle.circleindex >= _id_0046599DAB79A549) {
      break;
    }
  }
}

_id_EBDF8F6E61C84882(tablet) {
  if(isDefined(tablet._id_B8EBE3F71A08AB40.type.funcs["validateContractNotInStronghold"]))
    return tablet._id_B8EBE3F71A08AB40[[tablet._id_B8EBE3F71A08AB40.type.funcs["validateContractNotInStronghold"]]]();

  return 1;
}

_id_1C1F9F1AA4944459() {
  self endon("game_ended");

  while(!isDefined(level._id_49A5D647639E781E) || level._id_49A5D647639E781E.size < 1)
    wait 0.5;

  foreach(tablet in level._id_41F4BC9EE8C7C9C6.activetablets) {
    if(isDefined(tablet._id_B8EBE3F71A08AB40.type.funcs["validateContractNotInStronghold"]))
      tablet._id_B8EBE3F71A08AB40[[tablet._id_B8EBE3F71A08AB40.type.funcs["validateContractNotInStronghold"]]]();
  }
}

disablealltablets() {
  foreach(type in level._id_41F4BC9EE8C7C9C6._id_7BA7458B5FC820F7) {
    _id_E0D1E3A2B6F5323A = getlootscriptablearray(type._id_A0CE8000D303764C);

    if(type.enabled) {
      foreach(tablet in _id_E0D1E3A2B6F5323A)
      tablet tablethide();
    }
  }
}

_id_2AA2583AA4C84697(tablet) {
  if(scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }
  if(istrue(tablet._id_F1D383D9D3B40188))
    return 0;
  else {
    count = level._id_41F4BC9EE8C7C9C6._id_A140D7E8412B4051.size;
    level._id_41F4BC9EE8C7C9C6._id_A140D7E8412B4051[count] = tablet;
    tablet._id_F1D383D9D3B40188 = 1;
    return 1;
  }
}

_id_968DF0AF5E2D28EA() {
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(tablet in level._id_41F4BC9EE8C7C9C6._id_A140D7E8412B4051) {
    tablet thread tablethide();
    tablet._id_F1D383D9D3B40188 = undefined;
  }

  level._id_41F4BC9EE8C7C9C6._id_A140D7E8412B4051 = undefined;

  foreach(tablet in level._id_41F4BC9EE8C7C9C6._id_294684D6A0DEEF46)
  tablet thread tablethide();

  foreach(tablet in level._id_41F4BC9EE8C7C9C6.activetablets) {
    if(istrue(tablet.startdisabled)) {
      tablet.startdisabled = undefined;
      tablet thread tablethide();
    }
  }
}

tablethide(_id_17076274943ED9BC) {
  self endon("show");

  if(istrue(_id_17076274943ED9BC))
    self._id_9B0DD38E2592BE58 = 1;

  if(isDefined(level._id_41F4BC9EE8C7C9C6._id_B6012B6FFDB53601) && isDefined(level._id_41F4BC9EE8C7C9C6._id_B6012B6FFDB53601[self.type]))
    level._id_41F4BC9EE8C7C9C6._id_B6012B6FFDB53601[self.type]++;

  scripts\mp\flags::gameflagwait("prematch_done");
  _id_7E52B56769FA7774::loothide(self);
}

_id_6AC289B030B7CABE(obj) {
  if(isDefined(obj.tablettype) && !istrue(obj._id_9B0DD38E2592BE58)) {
    _id_65906228324B791B = 1;

    if(isDefined(obj.tablettype.funcs["onShowAgain"]))
      _id_65906228324B791B = obj._id_B8EBE3F71A08AB40[[obj.tablettype.funcs["onShowAgain"]]]();

    if(_id_65906228324B791B)
      obj tabletshow(1);
  }
}

tabletshow(_id_132F5385C2F23A96) {
  if(isDefined(level._id_41F4BC9EE8C7C9C6._id_546B3948246E4AA3) && isDefined(level._id_41F4BC9EE8C7C9C6._id_546B3948246E4AA3[self.type]))
    level._id_41F4BC9EE8C7C9C6._id_546B3948246E4AA3[self.type]++;

  self notify("show");
  part = self.type;
  self setscriptablepartstate(part, "visible");

  if(!scripts\engine\utility::array_contains(level._id_41F4BC9EE8C7C9C6.activetablets, self))
    level._id_41F4BC9EE8C7C9C6.activetablets[level._id_41F4BC9EE8C7C9C6.activetablets.size] = self;

  if(!istrue(_id_132F5385C2F23A96))
    _id_715028F54BAD19A1::branalytics_spawntablet(self);
}

tabletinit(type) {
  if(isDefined(self.init)) {
    return;
  }
  self.init = 1;
  self.tablettype = type;
  tabletinit = type.funcs["onInit"];

  if(isDefined(tabletinit)) {
    _id_B8EBE3F71A08AB40 = spawnStruct();
    _id_B8EBE3F71A08AB40.teams = [];
    _id_B8EBE3F71A08AB40.type = type;
    self._id_B8EBE3F71A08AB40 = _id_B8EBE3F71A08AB40;
    _id_B8EBE3F71A08AB40.tablet = self;
    self.init = _id_B8EBE3F71A08AB40[[tabletinit]]();

    if(!self.init)
      _id_715028F54BAD19A1::branalytics_invalidtablet(self);
  }

  return self.init;
}

_id_4D5DD20E109455F2(instance) {
  level._id_41F4BC9EE8C7C9C6.activetablets = scripts\engine\utility::array_remove(level._id_41F4BC9EE8C7C9C6.activetablets, instance);

  if(isDefined(instance) && isDefined(instance.tablettype) && isDefined(instance.tablettype.ref)) {
    _id_7BA7458B5FC820F7 = _id_2A81BE592ADACDAA(instance.tablettype.ref);

    if(isDefined(_id_7BA7458B5FC820F7) && isDefined(_id_7BA7458B5FC820F7.funcs["onTabletHidden"]))
      [[_id_7BA7458B5FC820F7.funcs["onTabletHidden"]]](instance);
  }
}

_id_8AD1B4DDC1FD852A(team, player) {
  _id_715028F54BAD19A1::branalytics_missionstart(self, player);
  level._id_41F4BC9EE8C7C9C6._id_B6FAE9C9655C73BF[team] = self;
  level._id_41F4BC9EE8C7C9C6._id_8E0F287A7B13DA80[level._id_41F4BC9EE8C7C9C6._id_8E0F287A7B13DA80.size] = self;

  if(!isDefined(self.teams))
    self.teams = [];

  self.teams[self.teams.size] = team;
  self._id_0D154AC2657C5F44 = player;

  if(isDefined(player) && isDefined(player._id_DA28916E7827AF7C))
    self._id_CDBB609588AC1FBB = player._id_DA28916E7827AF7C;

  _id_473AB9452660E60F(self.type.ref);
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(_id_736D8D9188CCBD45 in players) {
    _id_736D8D9188CCBD45 scripts\cp_mp\challenges::oncontractstart(self.type.index, player);
    _id_189B67B2735B981D::_id_55B08D6D71B41402(_id_736D8D9188CCBD45, "contract_start");
  }

  level notify("quest_started", team);
}

_id_93663FE58D95F174(_id_5E671FC71E72D5E8, results, _id_752106078FE9B8FC) {
  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("contractEnd"))
    _id_362C58E8BB39BCDA::_id_D72AFDCCEDFC9B07("contractEnd", self, self.teams[0], isDefined(_id_5E671FC71E72D5E8) && _id_5E671FC71E72D5E8 == self.teams[0]);

  _id_C893965B0B5CC806 = isDefined(_id_5E671FC71E72D5E8);
  _id_EF08909F6CBF35FC = 0;

  foreach(team in self.teams) {
    _id_DA1E4A8F39765732 = _id_C893965B0B5CC806 && _id_5E671FC71E72D5E8 == team;
    uiobjectivehidefromteam(team);
    level._id_41F4BC9EE8C7C9C6._id_B6FAE9C9655C73BF[team] = undefined;
    players = scripts\mp\utility\teams::getteamdata(team, "players");

    foreach(player in players)
    player setclientomnvar("ui_br_objective_index", 0);

    if(_id_DA1E4A8F39765732) {
      players = scripts\mp\utility\teams::getteamdata(team, "players");
      _id_EF08909F6CBF35FC = players.size;

      foreach(player in players) {
        if(!isDefined(player.brmissionscompleted))
          player.brmissionscompleted = 0;

        player.brmissionscompleted++;

        if(level._id_58ADCE74179AB9EF) {
          player scripts\mp\utility\stats::incpersstat("objectivesCompleted", 1);
          player _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("missionsCompleted", player scripts\mp\utility\stats::getpersstat("objectivesCompleted"));
        } else
          player _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("missionsCompleted", player.brmissionscompleted);

        player scripts\cp_mp\challenges::oncontractend(self.type.index, 1, 1, self._id_CDBB609588AC1FBB);
      }

      if(!isDefined(level._id_41F4BC9EE8C7C9C6._id_AB841CFACA2F23AD[team]))
        level._id_41F4BC9EE8C7C9C6._id_AB841CFACA2F23AD[team] = 0;

      level._id_41F4BC9EE8C7C9C6._id_AB841CFACA2F23AD[team]++;
      continue;
    }

    players = scripts\mp\utility\teams::getteamdata(team, "players");

    foreach(player in players)
    player scripts\cp_mp\challenges::oncontractend(self.type.index, 0, 1);

    if(isDefined(_id_752106078FE9B8FC)) {
      _id_0DA60AC7AAE847D8 = scripts\mp\utility\teams::getteamdata(_id_752106078FE9B8FC, "players");

      foreach(_id_C92902AD553E3854 in _id_0DA60AC7AAE847D8)
      _id_C92902AD553E3854 scripts\cp_mp\challenges::oncontractend(self.type.index, 1, 2);
    }
  }

  _id_DE7B4AAABE650264 = spawnStruct();
  _id_DE7B4AAABE650264.questcategory = self.category;

  if(_id_C893965B0B5CC806)
    _id_DE7B4AAABE650264.result = "success";
  else
    _id_DE7B4AAABE650264.result = "failure";

  _id_DE7B4AAABE650264.missionid = scripts\engine\utility::string(self.type.index);

  if(!isDefined(results))
    results = [];

  _id_715028F54BAD19A1::branalytics_missionend(_id_DE7B4AAABE650264, 1, results, _id_EF08909F6CBF35FC);
  level._id_41F4BC9EE8C7C9C6._id_8E0F287A7B13DA80 = scripts\engine\utility::array_remove(level._id_41F4BC9EE8C7C9C6._id_8E0F287A7B13DA80, self);
}

_id_BB413728BC5231D0(instance) {
  _id_A0CE8000D303764C = instance.type;

  if(isDefined(level._id_41F4BC9EE8C7C9C6._id_8764D5E454E66EA3[_id_A0CE8000D303764C].funcs["onTeamAssigned"])) {
    if(_id_7094C7010C5E3827(self.team)) {
      return;
    }
    giveteampoints(self.team, "stat_67EB4B642067882A");
    instance tablethide();
    instance._id_B8EBE3F71A08AB40 _id_8AD1B4DDC1FD852A(self.team, self);
    instance._id_B8EBE3F71A08AB40._id_7CA287A82F54E4F6 = self;
    instance._id_B8EBE3F71A08AB40[[level._id_41F4BC9EE8C7C9C6._id_8764D5E454E66EA3[_id_A0CE8000D303764C].funcs["onTeamAssigned"]]]();
    _id_6AFF3948CF4CCA03::modify_plunder_itemsinworld("brloot_mission_tablet", -1);

    if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("contractStart"))
      _id_362C58E8BB39BCDA::runbrgametypefunc("contractStart", instance._id_B8EBE3F71A08AB40.type.ref, self.team);
  } else {}
}

_id_7094C7010C5E3827(team) {
  return isDefined(level._id_41F4BC9EE8C7C9C6) && isDefined(level._id_41F4BC9EE8C7C9C6._id_B6FAE9C9655C73BF) && isDefined(level._id_41F4BC9EE8C7C9C6._id_B6FAE9C9655C73BF[team]);
}

_id_22239D4CFF05D0A1(team) {
  if(isDefined(level._id_41F4BC9EE8C7C9C6) && isDefined(level._id_41F4BC9EE8C7C9C6._id_B6FAE9C9655C73BF))
    return level._id_41F4BC9EE8C7C9C6._id_B6FAE9C9655C73BF[team];

  return undefined;
}

dangercircletick(_id_819EDACDACB810E4, _id_E86632D645C137D0, _id_5D954F1724092F5A) {
  _id_52D59C928EB97C81 = _id_E86632D645C137D0 + _id_5D954F1724092F5A;
  activetablets = [];

  if(!scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73()) {
    if(!isDefined(level._id_41F4BC9EE8C7C9C6.activetablets))
      return;
    else
      activetablets = level._id_41F4BC9EE8C7C9C6.activetablets;

    foreach(_id_6640C2677653D96F in level._id_41F4BC9EE8C7C9C6._id_7BA7458B5FC820F7) {
      if(isDefined(_id_6640C2677653D96F.funcs["circleTick"])) {
        foreach(_id_B8EBE3F71A08AB40 in level._id_41F4BC9EE8C7C9C6._id_8E0F287A7B13DA80) {
          if(_id_6640C2677653D96F.ref == _id_B8EBE3F71A08AB40.type.ref)
            _id_B8EBE3F71A08AB40[[_id_6640C2677653D96F.funcs["circleTick"]]](_id_819EDACDACB810E4, _id_52D59C928EB97C81);
        }
      }
    }
  } else {
    if(!isDefined(level.questinfo))
      return;
    else
      activetablets = level.questinfo.activetablets;

    foreach(_id_12461E617D024EF9 in level.questinfo.quests) {
      if(isDefined(_id_12461E617D024EF9.funcs["circleTick"])) {
        foreach(instance in _id_12461E617D024EF9.instances)
        instance[[_id_12461E617D024EF9.funcs["circleTick"]]](_id_819EDACDACB810E4, _id_52D59C928EB97C81);
      }
    }
  }

  foreach(tablet in activetablets) {
    if(distance2dsquared(_id_819EDACDACB810E4, tablet.origin) > _id_52D59C928EB97C81 * _id_52D59C928EB97C81) {
      _id_7E52B56769FA7774::loothide(tablet);
      _id_6AFF3948CF4CCA03::modify_plunder_itemsinworld("brloot_mission_tablet", -1);
    }
  }
}

_id_1A1709943670772A() {
  if(!isDefined(level._id_41F4BC9EE8C7C9C6)) {
    return;
  }
  foreach(_id_6640C2677653D96F in level._id_41F4BC9EE8C7C9C6._id_7BA7458B5FC820F7) {
    if(isDefined(_id_6640C2677653D96F.funcs["circleTick"])) {
      foreach(_id_B8EBE3F71A08AB40 in level._id_41F4BC9EE8C7C9C6._id_8E0F287A7B13DA80) {
        if(_id_6640C2677653D96F.ref == _id_B8EBE3F71A08AB40.type.ref)
          _id_B8EBE3F71A08AB40[[_id_6640C2677653D96F.funcs["circleTick"]]]();
      }
    }
  }

  _id_294684D6A0DEEF46 = [];

  foreach(tablet in level._id_41F4BC9EE8C7C9C6.activetablets) {
    if(!isDefined(tablet) || !isDefined(tablet.type)) {
      continue;
    }
    if(!_id_7E52B56769FA7774::isquesttablet(tablet.type)) {
      continue;
    }
    if(!isDefined(tablet.origin)) {
      logstring("br_contract_manager::dangerMultiCircleTick tablet does not have an origin! " + tablet.type);
      continue;
    }

    if(!_id_58F20490049AF6AC::_id_EE854FDD1E77EFC4(tablet.origin)) {
      _id_294684D6A0DEEF46[_id_294684D6A0DEEF46.size] = tablet;
      _id_7E52B56769FA7774::loothide(tablet);
      _id_6AFF3948CF4CCA03::modify_plunder_itemsinworld("brloot_mission_tablet", -1);
    }
  }

  return _id_294684D6A0DEEF46;
}

onplayerkilled(attacker, victim) {
  if(!isDefined(level._id_41F4BC9EE8C7C9C6)) {
    return;
  }
  foreach(_id_6640C2677653D96F in level._id_41F4BC9EE8C7C9C6._id_7BA7458B5FC820F7) {
    if(isDefined(_id_6640C2677653D96F.funcs["onPlayerKilled"])) {
      foreach(_id_B8EBE3F71A08AB40 in level._id_41F4BC9EE8C7C9C6._id_8E0F287A7B13DA80) {
        if(_id_6640C2677653D96F.ref == _id_B8EBE3F71A08AB40.type.ref)
          _id_B8EBE3F71A08AB40[[_id_6640C2677653D96F.funcs["onPlayerKilled"]]](attacker, victim);
      }
    }
  }
}

onplayerconnect(player) {
  if(!isDefined(player.team) || !isDefined(level._id_41F4BC9EE8C7C9C6)) {
    return;
  }
  setquestrewardtier(player.team, getquestrewardtier(player.team));
}

onplayerdisconnect(player) {
  if(!isDefined(level._id_41F4BC9EE8C7C9C6)) {
    return;
  }
  foreach(_id_6640C2677653D96F in level._id_41F4BC9EE8C7C9C6._id_7BA7458B5FC820F7) {
    if(isDefined(_id_6640C2677653D96F.funcs["onPlayerDisconnect"])) {
      foreach(_id_B8EBE3F71A08AB40 in level._id_41F4BC9EE8C7C9C6._id_8E0F287A7B13DA80) {
        if(_id_6640C2677653D96F.ref == _id_B8EBE3F71A08AB40.type.ref)
          _id_B8EBE3F71A08AB40[[_id_6640C2677653D96F.funcs["onPlayerDisconnect"]]](player);
      }
    }
  }
}

onplayerentergulag() {
  if(!isDefined(level._id_41F4BC9EE8C7C9C6)) {
    return;
  }
  if(_id_7094C7010C5E3827(self.team)) {
    _id_B8EBE3F71A08AB40 = _id_22239D4CFF05D0A1(self.team);

    if(isDefined(_id_B8EBE3F71A08AB40.type.funcs["onEnterGulag"]))
      _id_B8EBE3F71A08AB40[[_id_B8EBE3F71A08AB40.type.funcs["onEnterGulag"]]](self);

    if(isDefined(_id_B8EBE3F71A08AB40._id_972EDDBDCF30619C))
      _id_1E64EA5EB68D8119();
  }

  _id_EEDEF3FD7CAC5E44();
}

_id_EEDEF3FD7CAC5E44() {
  foreach(_id_6640C2677653D96F in level._id_41F4BC9EE8C7C9C6._id_7BA7458B5FC820F7) {
    if(isDefined(_id_6640C2677653D96F.funcs["onGlobalPlayerEnterGulag"])) {
      foreach(_id_B8EBE3F71A08AB40 in level._id_41F4BC9EE8C7C9C6._id_8E0F287A7B13DA80) {
        if(_id_6640C2677653D96F.ref == _id_B8EBE3F71A08AB40.type.ref)
          _id_B8EBE3F71A08AB40[[_id_6640C2677653D96F.funcs["onGlobalPlayerEnterGulag"]]](self);
      }
    }
  }
}

onplayerrespawn() {
  if(!isDefined(level._id_41F4BC9EE8C7C9C6)) {
    return;
  }
  self setclientomnvar("ui_player_spawned_notify", gettime());

  if(_id_7094C7010C5E3827(self.team)) {
    _id_B8EBE3F71A08AB40 = _id_22239D4CFF05D0A1(self.team);

    if(isDefined(_id_B8EBE3F71A08AB40.type.funcs["onPlayerRespawn"]))
      _id_B8EBE3F71A08AB40[[_id_B8EBE3F71A08AB40.type.funcs["onPlayerRespawn"]]](self);

    if(isDefined(_id_B8EBE3F71A08AB40._id_972EDDBDCF30619C))
      _id_1E64EA5EB68D8119();
  }

  _id_5E0209988BC99A8A();
}

_id_5E0209988BC99A8A() {
  foreach(_id_6640C2677653D96F in level._id_41F4BC9EE8C7C9C6._id_7BA7458B5FC820F7) {
    if(isDefined(_id_6640C2677653D96F.funcs["onGlobalPlayerRespawn"])) {
      foreach(_id_B8EBE3F71A08AB40 in level._id_41F4BC9EE8C7C9C6._id_8E0F287A7B13DA80) {
        if(_id_6640C2677653D96F.ref == _id_B8EBE3F71A08AB40.type.ref)
          _id_B8EBE3F71A08AB40[[_id_6640C2677653D96F.funcs["onGlobalPlayerRespawn"]]](self);
      }
    }
  }
}

packsplashparambits(_id_D4FC3B4E84704775, _id_501265B5FE210821) {
  value = _id_D4FC3B4E84704775;
  value = value | _id_501265B5FE210821 << 5;
  return value;
}

_id_878EBCC241B54505(_id_F7B6CC6C062A7A43, _id_D4FC3B4E84704775, _id_501265B5FE210821, team, delay, _id_042B1E877AB187C6) {
  if(isDefined(delay) && delay > 0)
    wait(delay);

  params = packsplashparambits(_id_D4FC3B4E84704775, _id_501265B5FE210821);
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players)
  player thread scripts\mp\hud_message::showsplash(_id_F7B6CC6C062A7A43, params, undefined, undefined, undefined, _id_042B1E877AB187C6);
}

displayteamsplash(team, _id_E9AE765E2C4FE816, params, _id_042B1E877AB187C6) {
  players = scripts\mp\utility\teams::getteamdata(team, "players");
  displaysplashtoplayers(players, _id_E9AE765E2C4FE816, params, _id_042B1E877AB187C6);
}

displaysplashtoplayers(players, _id_E9AE765E2C4FE816, params, _id_042B1E877AB187C6) {
  foreach(player in players) {
    if(player _id_2CEDCC356F1B9FC8::isplayeringulag()) {
      continue;
    }
    if(isbot(player) && _id_2CEDCC356F1B9FC8::istutorial()) {
      continue;
    }
    if(isDefined(params)) {
      if(isDefined(params.excludedplayers)) {
        if(scripts\engine\utility::array_contains(params.excludedplayers, player))
          continue;
      }
    }

    displayplayersplash(player, _id_E9AE765E2C4FE816, params, _id_042B1E877AB187C6);
  }
}

displayplayersplash(player, _id_E9AE765E2C4FE816, params, _id_042B1E877AB187C6) {
  if(isDefined(params) && isDefined(params.packedbits))
    player thread scripts\mp\hud_message::showsplash(_id_E9AE765E2C4FE816, params.packedbits, undefined, undefined, undefined, _id_042B1E877AB187C6);
  else if(isDefined(params) && isDefined(params.intvar))
    player thread scripts\mp\hud_message::showsplash(_id_E9AE765E2C4FE816, params.intvar, undefined, undefined, undefined, _id_042B1E877AB187C6);
  else
    player thread scripts\mp\hud_message::showsplash(_id_E9AE765E2C4FE816, undefined, undefined, undefined, undefined, _id_042B1E877AB187C6);
}

displaysquadmessagetoplayer(_id_939B8E8818BFD5AE, state, missionid) {
  player = _id_939B8E8818BFD5AE getentitynumber();

  if(!isDefined(state))
    state = 0;

  if(!isDefined(player))
    player = 0;

  if(!isDefined(missionid))
    missionid = 0;

  value = 0;
  value = missionid << 12 | player << 4 | state;
  self setclientomnvar("ui_br_expanded_obit_message", value);
}

displaysquadmessagetoteam(team, _id_939B8E8818BFD5AE, state, missionid) {
  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players"))
  player displaysquadmessagetoplayer(_id_939B8E8818BFD5AE, state, missionid);
}

giveplayerpoints(player, ref) {
  player thread scripts\mp\utility\points::_id_0366980B6A8796AE(ref);
}

giveteampoints(team, ref) {
  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players"))
  player thread scripts\mp\utility\points::_id_0366980B6A8796AE(ref);
}

giveteamplunderflat(team, amount) {
  _id_8E3C5F90E4F80A58 = getdvarfloat("dvar_7165DAD703502609", 0.4);
  _id_2CEFA8F8A2BA6BFE = 0;

  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
    if(isbot(player) && _id_2CEDCC356F1B9FC8::istutorial()) {
      continue;
    }
    _id_36773A58EB035BFF = amount;

    if(!scripts\mp\utility\player::isreallyalive(player))
      _id_36773A58EB035BFF = int(amount * _id_8E3C5F90E4F80A58);

    player _id_6AFF3948CF4CCA03::playerplunderpickup(_id_36773A58EB035BFF);
    level.br_plunder.plunder_awarded_by_missions_total = level.br_plunder.plunder_awarded_by_missions_total + _id_36773A58EB035BFF;
  }
}

giveteamplunderdistributive(players, amount) {
  _id_6EEBCDA719CD18A1 = int(amount / players.size);

  foreach(player in players) {
    if(isbot(player) && _id_2CEDCC356F1B9FC8::istutorial()) {
      continue;
    }
    player _id_6AFF3948CF4CCA03::playerplunderpickup(_id_6EEBCDA719CD18A1);
    level.br_plunder.plunder_awarded_by_missions_total = level.br_plunder.plunder_awarded_by_missions_total + _id_6EEBCDA719CD18A1;
    _id_715028F54BAD19A1::trackcashevent(player, "mission", _id_6EEBCDA719CD18A1);
  }
}

dropplunder(ammount, _id_5B7BF3433D244CDF, _id_76212928FED46301, _id_41271DE03A84A690) {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }
  _id_5C2AD86C68EAB7E9 = 0;
  _id_168EA84F2950FE38 = 1;
  _id_B590C41D9F9CE9F3 = 2;
  _id_82C3FC1E774A5A35[0] = ["brloot_plunder_cash_uncommon_3", level.br_plunder.quantityepic, getdvarfloat("dvar_53DD15287F7DF644", 0.2)];
  _id_82C3FC1E774A5A35[1] = ["brloot_plunder_cash_uncommon_2", level.br_plunder.quantityrare, getdvarfloat("dvar_8FA17586AC872DA9", 0.3)];
  _id_82C3FC1E774A5A35[2] = ["brloot_plunder_cash_uncommon_1", level.br_plunder.quantitycommon, getdvarfloat("dvar_30BF1DD438567DB0", 0.5)];
  _id_403ADFAFCE8E54AE = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_82C3FC1E774A5A35.size; _id_AC0E594AC96AA3A8++) {
    info = _id_82C3FC1E774A5A35[_id_AC0E594AC96AA3A8];
    _id_403ADFAFCE8E54AE = _id_403ADFAFCE8E54AE + info[_id_B590C41D9F9CE9F3];
  }

  plundertotal = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_82C3FC1E774A5A35.size; _id_AC0E594AC96AA3A8++) {
    info = _id_82C3FC1E774A5A35[_id_AC0E594AC96AA3A8];
    info[_id_B590C41D9F9CE9F3] = info[_id_B590C41D9F9CE9F3] / _id_403ADFAFCE8E54AE;
    plundertotal = plundertotal + info[_id_168EA84F2950FE38] * info[_id_B590C41D9F9CE9F3];
  }

  _id_0CE1BD3FDF0FCECF = ammount / plundertotal;
  _id_F278EB5EB7F1E8BE = ammount;
  _id_C75B43B86B00CB9D = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_82C3FC1E774A5A35.size; _id_AC0E594AC96AA3A8++) {
    info = _id_82C3FC1E774A5A35[_id_AC0E594AC96AA3A8];
    _id_C75B43B86B00CB9D[_id_AC0E594AC96AA3A8] = int(_id_0CE1BD3FDF0FCECF * info[_id_B590C41D9F9CE9F3]);
    _id_F278EB5EB7F1E8BE = _id_F278EB5EB7F1E8BE - _id_C75B43B86B00CB9D[_id_AC0E594AC96AA3A8] * info[_id_168EA84F2950FE38];
  }

  if(_id_F278EB5EB7F1E8BE > 0) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_82C3FC1E774A5A35.size; _id_AC0E594AC96AA3A8++) {
      info = _id_82C3FC1E774A5A35[_id_AC0E594AC96AA3A8];
      extra = int(_id_F278EB5EB7F1E8BE / info[_id_168EA84F2950FE38]);
      _id_C75B43B86B00CB9D[_id_AC0E594AC96AA3A8] = _id_C75B43B86B00CB9D[_id_AC0E594AC96AA3A8] + extra;
      _id_F278EB5EB7F1E8BE = _id_F278EB5EB7F1E8BE - extra * info[_id_168EA84F2950FE38];
    }
  }

  _id_1473580AC7CFA299 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C75B43B86B00CB9D.size; _id_AC0E594AC96AA3A8++) {
    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_C75B43B86B00CB9D[_id_AC0E594AC96AA3A8]; _id_AC0E5C4AC96AAA41++)
      _id_1473580AC7CFA299[_id_1473580AC7CFA299.size] = _id_AC0E594AC96AA3A8;
  }

  _id_1473580AC7CFA299 = scripts\engine\utility::array_randomize(_id_1473580AC7CFA299);
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1473580AC7CFA299.size; _id_AC0E594AC96AA3A8++) {
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, _id_5B7BF3433D244CDF, _id_76212928FED46301, _id_41271DE03A84A690);
    _id_7E52B56769FA7774::spawnpickup(_id_82C3FC1E774A5A35[_id_1473580AC7CFA299[_id_AC0E594AC96AA3A8]][_id_5C2AD86C68EAB7E9], _id_CB4FAD49263E20C4, _id_82C3FC1E774A5A35[_id_1473580AC7CFA299[_id_AC0E594AC96AA3A8]][_id_168EA84F2950FE38], 1);
  }

  level.br_plunder.plunder_awarded_by_missions_total = level.br_plunder.plunder_awarded_by_missions_total + ammount;
  level thread _id_6AFF3948CF4CCA03::dropplundersounds(_id_5B7BF3433D244CDF, _id_1473580AC7CFA299.size);
}

_id_D282041688C032B5(category) {
  _id_1BBEB265EF74BC60 = tablelookup("mp/brmissions.csv", 1, category, 18);
  _id_723B8F7CB71CEB11 = tablelookup(level._id_816DBC1FF5F29EB1, 0, _id_1BBEB265EF74BC60, 3);

  if(!isDefined(_id_723B8F7CB71CEB11) || _id_723B8F7CB71CEB11 == "")
    return 0;

  if(_id_337BD370F7C5E6F9::ispubliceventoftypeactive(15))
    _id_723B8F7CB71CEB11 = _id_723B8F7CB71CEB11 * level.br_pe_data[15]._id_046A451F9012BD1C;

  return int(_id_723B8F7CB71CEB11);
}

_id_D212A5E7A40D7C8D(_id_05A4D4A174EA2EAC, team, _id_4E031B1C97A51F99) {
  _id_2F0B8C1F978FD835 = tablelookup(level._id_816DBC1FF5F29EB1, 0, _id_05A4D4A174EA2EAC, 7);

  if(isDefined(_id_2F0B8C1F978FD835) && _id_2F0B8C1F978FD835 != "")
    return _id_3ACF1C0EBAF602F2::givequestrewardgroup(_id_2F0B8C1F978FD835, team, _id_4E031B1C97A51F99.origin, _id_4E031B1C97A51F99.angles);
}

_id_6DDD1EECBE562ACF(_id_2F0B8C1F978FD835, team, _id_4E031B1C97A51F99) {
  if(isDefined(_id_2F0B8C1F978FD835) && _id_2F0B8C1F978FD835 != "")
    return _id_3ACF1C0EBAF602F2::givequestrewardgroup(_id_2F0B8C1F978FD835, team, _id_4E031B1C97A51F99.origin, _id_4E031B1C97A51F99.angles);
}

_id_3D262D56274BD22E(ref) {
  return level._id_41F4BC9EE8C7C9C6._id_766F9DE01948C219[ref].index;
}

getquestindex(ref) {
  return level._id_41F4BC9EE8C7C9C6._id_8F51BBE0D6629B2C[ref].index;
}

getquesttableindex(ref) {
  index = int(tablelookup("mp/brmissions.csv", 1, ref, 0));
  return index;
}

uiobjectiveshow(ref) {
  index = getquestindex(ref);
  setquestindexomnvar(index);
}

uiobjectiveshowtoteam(ref, team) {
  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players"))
  player uiobjectiveshow(ref);
}

uiobjectivehide() {
  setquestindexomnvar(0);
}

uiobjectivehidefromteam(team) {
  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players"))
  player uiobjectivehide();
}

_id_E2AA45E2C6B5DEC1(value, _id_456C37B4CCDC86C4) {
  foreach(player in scripts\mp\utility\teams::getteamdata(self.teams[0], "players"))
  player uiobjectivesetparameter(value, _id_456C37B4CCDC86C4);
}

uiobjectivesetparameter(value, _id_456C37B4CCDC86C4) {
  self setclientomnvar("ui_br_objective_param", value);

  if(isDefined(_id_456C37B4CCDC86C4))
    self setclientomnvar("ui_br_objective_extraParam", _id_456C37B4CCDC86C4);
}

uiobjectivesetlootid(value) {
  self setclientomnvar("ui_br_objective_loot_id", value);
}

createquestobjicon(_id_CB8E582431CF1641, state, _id_38116998DF9814D4) {
  self.objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(self.objectiveiconid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(self.objectiveiconid, state, (0, 0, 0), _id_CB8E582431CF1641);
    scripts\mp\objidpoolmanager::update_objective_setbackground(self.objectiveiconid, 4);
    objective_showtoplayersinmask(self.objectiveiconid);
    scripts\mp\objidpoolmanager::objective_set_play_intro(self.objectiveiconid, 1);

    if(isDefined(_id_38116998DF9814D4))
      movequestobjicon(_id_38116998DF9814D4);
  } else {}
}

movequestobjicon(_id_A9706ADAF7C52E27) {
  scripts\mp\objidpoolmanager::update_objective_position(self.objectiveiconid, _id_A9706ADAF7C52E27);
}

showquestobjicontoplayer(player) {
  objective_addclienttomask(self.objectiveiconid, player);
}

showquestobjicontoall(objid) {
  objective_addalltomask(objid);
}

hidequestobjiconfromplayer(player) {
  objective_removeclientfrommask(self.objectiveiconid, player);
}

checkforactiveobjicon() {
  return isDefined(self.objectiveiconid);
}

deletequestobjicon() {
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objectiveiconid);
  scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);
}

utilflare_shootflare(spawn_origin, _id_1DA50610F94E1BFB, _id_30A49DC77E377647) {
  level endon("game_ended");
  _id_3E146ED5E207E635 = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 0, 0);
  new_position = scripts\engine\trace::ray_trace(spawn_origin + (0, 0, 4000), spawn_origin, undefined, _id_3E146ED5E207E635, undefined, 1)["position"];

  if(!isDefined(_id_30A49DC77E377647))
    _id_30A49DC77E377647 = 0;

  if(istrue(_id_30A49DC77E377647))
    flare = spawn("script_model", spawn_origin);
  else
    flare = spawn("script_model", new_position);

  if(!isDefined(flare)) {
    return;
  }
  _id_D5685B7BAEE6505E = flare.origin;
  flare.angles = vectortoangles((0, 0, 1));
  flare setModel("equip_flare_br");
  wait 0.5;
  _id_A2124393ACEFA11E = "start";

  if(isDefined(_id_1DA50610F94E1BFB)) {
    if(_id_1DA50610F94E1BFB == "reinforcement_flare")
      _id_A2124393ACEFA11E = "start_reinforcement_flare";
  }

  flare setscriptablepartstate("launch", _id_A2124393ACEFA11E, 0);
  _id_3FC3DAADE1C87824 = "start";

  if(isDefined(_id_1DA50610F94E1BFB)) {
    _id_3FC3DAADE1C87824 = "start_" + _id_1DA50610F94E1BFB;

    if(_id_1DA50610F94E1BFB == "4th_july")
      playsoundatpos(_id_D5685B7BAEE6505E, "mus_iw9_flare_launch_stinger_july4");
  }

  flare setscriptablepartstate("travel", _id_3FC3DAADE1C87824, 0);
  flare thread _utilflare_lerpflare(_id_1DA50610F94E1BFB);
}

_utilflare_lerpflare(_id_1DA50610F94E1BFB) {
  self endon("death");
  level endon("game_ended");
  movetime = 3.125;
  self moveTo(self.origin + (0, 0, 2500), movetime);
  wait(movetime);
  _utilflare_flareexplode(_id_1DA50610F94E1BFB);
}

_utilflare_flareexplode(_id_1DA50610F94E1BFB) {
  if(!isDefined(_id_1DA50610F94E1BFB))
    _id_1DA50610F94E1BFB = "<undefined>";

  self setscriptablepartstate("travel", "off", 0);

  if(!_utilflare_isvalidflaretype(_id_1DA50610F94E1BFB)) {
    return;
  }
  _id_44A98E57FEB74898 = "start_" + _id_1DA50610F94E1BFB;
  self setscriptablepartstate("explode", _id_44A98E57FEB74898, 0);
  thread sfx_br_flare_phosphorus(_id_1DA50610F94E1BFB);
}

_utilflare_isvalidflaretype(_id_1DA50610F94E1BFB) {
  _id_03BA45E0E07877B7 = 0;

  if(isDefined(_id_1DA50610F94E1BFB)) {
    switch (_id_1DA50610F94E1BFB) {
      case "4th_july":
      case "dmz_exfil":
      case "reinforcement_flare":
      case "revive":
      case "dom":
        _id_03BA45E0E07877B7 = 1;
        break;
    }
  }

  return _id_03BA45E0E07877B7;
}

sfx_br_flare_phosphorus(_id_1DA50610F94E1BFB) {
  self endon("death");
  level endon("game_ended");
  self setscriptablepartstate("phosphorus", "start", 0);
  wait 0.3;
  self setscriptablepartstate("phosphorus_loop", "start", 0);

  switch (_id_1DA50610F94E1BFB) {
    case "dmz_exfil":
      wait 40;
      break;
    case "dom":
      break;
    default:
      wait 12;
      break;
  }

  self setscriptablepartstate("phosphorus", "end", 0);
  wait 0.3;
  self setscriptablepartstate("phosphorus_loop", "off", 0);
  wait 5;
  self delete();
}

questpointgetradius(point) {
  radius = 0;

  if(point.spawnflags & 4)
    radius = 256;
  else if(point.spawnflags & 2)
    radius = 128;
  else if(point.spawnflags & 1)
    radius = 168;

  return radius;
}

_id_B891F0C9814330EB(category) {
  _id_89CAD6E3DA206570 = tablelookup(level._id_816DBC1FF5F29EB1, 0, category, 3);

  if(!isDefined(_id_89CAD6E3DA206570) || _id_89CAD6E3DA206570 == "")
    return 0;

  return int(_id_89CAD6E3DA206570);
}

_id_2A81BE592ADACDAA(_id_1BBEB265EF74BC60) {
  if(!isDefined(level._id_41F4BC9EE8C7C9C6) || !isDefined(level._id_41F4BC9EE8C7C9C6._id_766F9DE01948C219))
    return undefined;

  return level._id_41F4BC9EE8C7C9C6._id_766F9DE01948C219[_id_1BBEB265EF74BC60];
}

_id_5A15174D34F0670C(time, _id_09707FF10D99D386) {
  if(!isDefined(_id_09707FF10D99D386))
    _id_09707FF10D99D386 = 0;

  totaltime = time + _id_09707FF10D99D386;
  self.missiontime = gettime() + totaltime * 1000;
  _id_51D3A2B4CDE79545();
}

_id_5606274C76B4A2DF(time) {
  self.missiontime = self.missiontime + time * 1000;
  _id_51D3A2B4CDE79545();
}

_id_234C4428A084CA58(time) {
  if(self.missiontime - gettime() <= 1000) {
    return;
  }
  if(self.missiontime - gettime() - time * 1000 <= 0)
    self.missiontime = gettime() + 1000;
  else
    self.missiontime = self.missiontime - time * 1000;

  _id_51D3A2B4CDE79545();
}

_id_51D3A2B4CDE79545() {
  foreach(player in scripts\mp\utility\teams::getteamdata(self.teams[0], "players"))
  player setclientomnvar("ui_br_objective_countdown_timer", self.missiontime);

  _id_7BA7458B5FC820F7 = _id_2A81BE592ADACDAA(self.category);
  updatefunc = _id_7BA7458B5FC820F7.funcs["onTimerUpdate"];

  if(isDefined(updatefunc))
    [[updatefunc]]();

  thread _id_B58CD7D548D363B4();
}

_id_B58CD7D548D363B4() {
  self notify("updatecontractTimer");
  self endon("game_ended");
  self endon("updatecontractTimer");
  self endon("task_ended");
  waittime = (self.missiontime - gettime()) / 1000;
  wait(waittime);
  _id_7BA7458B5FC820F7 = _id_2A81BE592ADACDAA(self.category);
  _id_73EEDCA966115848 = _id_7BA7458B5FC820F7.funcs["onTimerExpired"];

  if(isDefined(_id_73EEDCA966115848))
    [[_id_73EEDCA966115848]]();
}

questrewardcirclepeek(team) {
  _id_5238DEE479BBF7FB::_id_647A8C40104E4866(team);
}

_id_496ED653FAACACD2(_id_30F14EF6CD430297) {
  _id_20BF70E9BC435ED5 = self;

  if(isDefined(_id_20BF70E9BC435ED5) && scripts\mp\utility\player::isreallyalive(_id_20BF70E9BC435ED5) && !_id_20BF70E9BC435ED5 _id_2CEDCC356F1B9FC8::isplayeringulag())
    _id_20BF70E9BC435ED5 _id_7E52B56769FA7774::forcegivesuper("super_supply_drop", 1, 0, 0, 0);
  else {
    foreach(player in scripts\mp\utility\teams::getteamdata(_id_30F14EF6CD430297, "players")) {
      if(!isDefined(player)) {
        continue;
      }
      if(isDefined(_id_20BF70E9BC435ED5) && player == _id_20BF70E9BC435ED5) {
        continue;
      }
      if(!scripts\mp\utility\player::isreallyalive(player)) {
        continue;
      }
      if(player _id_2CEDCC356F1B9FC8::isplayeringulag()) {
        continue;
      }
      player _id_7E52B56769FA7774::forcegivesuper("super_supply_drop", 1, 0, 0, 0);
      break;
    }
  }
}

_id_9B6275085FBCB8F4(time) {
  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("contractTimeModify"))
    time = _id_362C58E8BB39BCDA::runbrgametypefunc("contractTimeModify", self, time);

  return time;
}

_id_F69C3E487B364F2F(time) {
  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("contractTimeAddModify"))
    time = _id_362C58E8BB39BCDA::runbrgametypefunc("contractTimeAddModify", self, time);

  return time;
}

getquestrewardtier(team) {
  tier = level._id_41F4BC9EE8C7C9C6.tiers[team];

  if(!isDefined(tier))
    tier = 1;

  return tier;
}

setquestrewardtier(team, tier) {
  if(isDefined(level._id_41F4BC9EE8C7C9C6))
    level._id_41F4BC9EE8C7C9C6.tiers[team] = tier;

  setquestrewardtierteamomnvar(team, tier);
}

addquestrewardtier(team, value) {
  setquestrewardtier(team, getquestrewardtier(team) + value);
}

addquestrewardtierframeend(team, value) {
  waittillframeend;
  setquestrewardtier(team, getquestrewardtier(team) + value);
}

_id_473AB9452660E60F(ref) {
  index = getquesttableindex(ref);

  foreach(team in self.teams) {
    players = scripts\mp\utility\teams::getteamdata(team, "players");

    foreach(player in players)
    player setquestindexomnvar(index);
  }
}

setquestindexteamomnvar(team, _id_5E9B1036A4CAE82F) {
  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players"))
  player setquestindexomnvar(_id_5E9B1036A4CAE82F);
}

setquestindexomnvar(_id_5E9B1036A4CAE82F) {
  self setclientomnvar("ui_br_objective_index", _id_5E9B1036A4CAE82F);
}

setquestrewardtierteamomnvar(team, tier) {
  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players"))
  player setquestrewardtieromnvar(tier);
}

setquestrewardtieromnvar(tier) {
  self setclientomnvar("ui_br_objective_reward_tier", tier);
}

_id_19582BA0DBCC0AB0(targetplayer, threatlevel) {
  if(isDefined(self.aq_targethudenabled) && self.aq_targethudenabled && isDefined(targetplayer))
    entitynumber = targetplayer getentitynumber();
  else
    entitynumber = -1;

  entitynumber = entitynumber + 1;
  value = threatlevel << 8 | entitynumber;
  self setclientomnvar("ui_br_assassination_target", value);
}

_id_77DA9DEF0C368FC3() {
  level endon("game_ended");

  while(!isDefined(level._id_41F4BC9EE8C7C9C6.activetablets))
    waitframe();

  _id_B30B3C96C21FB5D8 = 160000;
  _id_2651277C09935BDE(_id_B30B3C96C21FB5D8);

  while(level._id_41F4BC9EE8C7C9C6.activetablets.size > 0) {
    foreach(player in level.players) {
      if(isDefined(player) && isDefined(player.origin) && isDefined(player.team) && isalive(player) && (!_id_7094C7010C5E3827(player.team) || istrue(player._id_45B8E84DE48BB89F))) {
        _id_30A99625B9F5D98C = scripts\engine\utility::_id_4D046F33253E46E0(player.origin, level._id_41F4BC9EE8C7C9C6.activetablets);

        if(isDefined(_id_30A99625B9F5D98C) && distancesquared(_id_30A99625B9F5D98C.origin, player.origin) < _id_B30B3C96C21FB5D8)
          _id_3FF2458477D23489::_id_04F6916C4E48CC55(_id_30A99625B9F5D98C, player);
      }
    }

    wait 1;
  }
}

_id_2651277C09935BDE(mindistancesq) {
  foreach(phone in level._id_41F4BC9EE8C7C9C6.activetablets) {
    foreach(_id_DB1022D1312EB1EB in level._id_41F4BC9EE8C7C9C6.activetablets) {
      if(phone == _id_DB1022D1312EB1EB) {
        continue;
      }
      if(distancesquared(phone.origin, _id_DB1022D1312EB1EB.origin) <= mindistancesq) {}
    }
  }
}

_id_6BDC6F56944DC3AA(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  foreach(_id_B8EBE3F71A08AB40 in level._id_41F4BC9EE8C7C9C6._id_8E0F287A7B13DA80) {
    if(_id_B8EBE3F71A08AB40.type.ref == "assassination") {
      if(_id_B8EBE3F71A08AB40.targetplayer == player) {
        if(isDefined(_id_B8EBE3F71A08AB40.type.funcs["onTargetAssimilated"]))
          _id_B8EBE3F71A08AB40[[_id_B8EBE3F71A08AB40.type.funcs["onTargetAssimilated"]]](player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354);

        continue;
      }

      if(_id_B8EBE3F71A08AB40.targetplayer.team == _id_8A04AA0E0755E7E3) {
        if(isDefined(_id_B8EBE3F71A08AB40.type.funcs["onTargetTeamTearDown"]))
          _id_B8EBE3F71A08AB40[[_id_B8EBE3F71A08AB40.type.funcs["onTargetTeamTearDown"]]](player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354);

        continue;
      }

      if(_id_B8EBE3F71A08AB40.targetplayer.team == _id_EB06B338608EF354) {
        if(isDefined(_id_B8EBE3F71A08AB40.type.funcs["onTargetTeamAssimilated"]))
          _id_B8EBE3F71A08AB40[[_id_B8EBE3F71A08AB40.type.funcs["onTargetTeamAssimilated"]]](player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354);
      }
    }
  }

  if(isDefined(level._id_41F4BC9EE8C7C9C6._id_B6FAE9C9655C73BF[_id_8A04AA0E0755E7E3])) {
    if(isDefined(level._id_41F4BC9EE8C7C9C6._id_B6FAE9C9655C73BF[_id_8A04AA0E0755E7E3].type.funcs["onPlayerTearDown"])) {
      foreach(_id_B8EBE3F71A08AB40 in level._id_41F4BC9EE8C7C9C6._id_8E0F287A7B13DA80) {
        if(level._id_41F4BC9EE8C7C9C6._id_B6FAE9C9655C73BF[_id_8A04AA0E0755E7E3].teams[0] == _id_B8EBE3F71A08AB40.teams[0])
          _id_B8EBE3F71A08AB40[[_id_B8EBE3F71A08AB40.type.funcs["onPlayerTearDown"]]](player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354);
      }
    }
  }

  if(isDefined(level._id_41F4BC9EE8C7C9C6._id_B6FAE9C9655C73BF[_id_EB06B338608EF354])) {
    if(isDefined(level._id_41F4BC9EE8C7C9C6._id_B6FAE9C9655C73BF[_id_EB06B338608EF354].type.funcs["onPlayerAssimilated"])) {
      foreach(_id_B8EBE3F71A08AB40 in level._id_41F4BC9EE8C7C9C6._id_8E0F287A7B13DA80) {
        if(level._id_41F4BC9EE8C7C9C6._id_B6FAE9C9655C73BF[_id_EB06B338608EF354].teams[0] == _id_B8EBE3F71A08AB40.teams[0])
          _id_B8EBE3F71A08AB40 thread _id_17D78A198FEB85D5(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354);
      }
    }
  }

  _id_5238DEE479BBF7FB::_id_B8022B0E5E976F66(_id_8A04AA0E0755E7E3, _id_EB06B338608EF354);
}

_id_17D78A198FEB85D5(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  level endon("game_ended");
  self endon("task_ended");
  waitframe();
  self[[self.type.funcs["onPlayerAssimilated"]]](player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354);
}

_id_8A25384BACDD7B79(_id_EE6EA77813E3C559, _id_A0CE8000D303764C) {
  if(!isDefined(level._id_41F4BC9EE8C7C9C6._id_7BA7458B5FC820F7)) {
    return;
  }
  foreach(data in level._id_41F4BC9EE8C7C9C6._id_7BA7458B5FC820F7) {
    if(data._id_A0CE8000D303764C == _id_A0CE8000D303764C) {
      _id_EE6EA77813E3C559 tabletinit(data);
      break;
    }
  }
}

filtercondition_isdead(player) {
  if(!isalive(player))
    return 0;

  return 1;
}

filtercondition_ingulag(player) {
  if(player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag())
    return 0;

  return 1;
}

_id_EB0A92E43754AF9F(team) {
  validplayers = [];

  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
    if(!player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag() && scripts\mp\utility\player::isreallyalive(player))
      validplayers[validplayers.size] = player;
  }

  return validplayers;
}

_id_581C09AED5AA4ED7(team) {
  _id_F67F078B2693E6C8 = getdvarint("dvar_9D25D6735879EDD5", 1);
  _id_E2FCC37FCCC34974 = getdvarint("dvar_896B3C10C7A229FA", 1);
  _id_DDB222C7FAF5AB50 = getdvarint("dvar_6D95FADFACABA24F", 60);

  if(!isDefined(level.teamdata[team]["currentContractCancels"]))
    level.teamdata[team]["currentContractCancels"] = 0;

  if(_id_F67F078B2693E6C8 > 0) {
    if(level.teamdata[team]["currentContractCancels"] == _id_F67F078B2693E6C8 - 1 && _id_E2FCC37FCCC34974) {
      level.teamdata[team]["cancelDelayTime"] = gettime() + _id_DDB222C7FAF5AB50 * 1000;
      level.teamdata[team]["currentContractCancels"]++;
      return 1;
    } else if(level.teamdata[team]["currentContractCancels"] >= _id_F67F078B2693E6C8) {
      if(_id_E2FCC37FCCC34974) {
        if(gettime() < level.teamdata[team]["cancelDelayTime"]) {
          self._id_972EDDBDCF30619C = [];
          _id_E2B2BBD9E6539F11 = _id_EB0A92E43754AF9F(team);

          foreach(player in _id_E2B2BBD9E6539F11) {
            n = (level.teamdata[team]["cancelDelayTime"] - gettime()) / 1000;
            n = int(max(0, ceil(n)));
            player scripts\mp\hud_message::showerrormessage(level._id_41F4BC9EE8C7C9C6._id_5C6031BDE94872A7, n);
          }

          return 0;
        }

        level.teamdata[team]["cancelDelayTime"] = gettime() + _id_DDB222C7FAF5AB50 * 1000;
        level.teamdata[team]["currentContractCancels"]++;
        return 1;
      } else {
        self._id_972EDDBDCF30619C = [];
        _id_E2B2BBD9E6539F11 = _id_EB0A92E43754AF9F(team);

        foreach(player in _id_E2B2BBD9E6539F11)
        player scripts\mp\hud_message::showerrormessage(level._id_41F4BC9EE8C7C9C6._id_8084CAC3D31A6BEE);

        return 0;
      }
    }
  }

  level.teamdata[team]["currentContractCancels"]++;
  return 1;
}

_id_31378EE55A2FB527(team) {
  if(isDefined(self.type.funcs["onCancel"]))
    self thread[[self.type.funcs["onCancel"]]](team);
}

_id_C142D6B260F19EE7(team) {
  if(!isDefined(self._id_972EDDBDCF30619C))
    self._id_972EDDBDCF30619C = [];

  numplayers = 0;
  _id_E2B2BBD9E6539F11 = _id_EB0A92E43754AF9F(team);

  foreach(player in _id_E2B2BBD9E6539F11) {
    if(scripts\engine\utility::array_contains(self._id_972EDDBDCF30619C, player))
      numplayers++;
  }

  return numplayers;
}

_id_1D3D389050DDCE74(team) {
  if(!isDefined(self._id_972EDDBDCF30619C))
    self._id_972EDDBDCF30619C = [];

  _id_E2B2BBD9E6539F11 = _id_EB0A92E43754AF9F(team);

  if(_id_C142D6B260F19EE7(team) == _id_E2B2BBD9E6539F11.size && _id_581C09AED5AA4ED7(team)) {
    level thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("mission_cancel_complete", team, 1);
    _id_31378EE55A2FB527(team);

    foreach(player in _id_E2B2BBD9E6539F11)
    player setclientomnvar("ui_br_contract_cancellation_state", 0);

    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_gen_fail", team, 1, 2);
    displayteamsplash(team, "br_contract_cancelled_" + self.type.ref);
    return 1;
  }

  return 0;
}

_id_DB96249C7BFDEC0B() {
  if(isDefined(self) && isDefined(self.team) && _id_7094C7010C5E3827(self.team)) {
    _id_6640C2677653D96F = _id_22239D4CFF05D0A1(self.team);

    if(!isDefined(_id_6640C2677653D96F)) {
      return;
    }
    if(!isDefined(_id_6640C2677653D96F.type.funcs["onCancel"])) {
      return;
    }
    if(!isDefined(_id_6640C2677653D96F._id_972EDDBDCF30619C))
      _id_6640C2677653D96F._id_972EDDBDCF30619C = [];

    if(scripts\engine\utility::array_contains(_id_6640C2677653D96F._id_972EDDBDCF30619C, self)) {
      _id_6640C2677653D96F _id_1D3D389050DDCE74(self.team);
      return;
    }

    _id_6640C2677653D96F._id_972EDDBDCF30619C[_id_6640C2677653D96F._id_972EDDBDCF30619C.size] = self;

    if(!_id_6640C2677653D96F _id_1D3D389050DDCE74(self.team)) {
      _id_607DA387F3617ED1 = _id_EB0A92E43754AF9F(self.team);
      _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("mission_cancel_request", scripts\engine\utility::array_remove_array(_id_607DA387F3617ED1, _id_6640C2677653D96F._id_972EDDBDCF30619C));
      _id_7AA06BE6F06BEF26 = _id_6640C2677653D96F _id_C142D6B260F19EE7(self.team);
      totalplayers = _id_607DA387F3617ED1.size;
      _id_587EC5B2038407DE = _id_7AA06BE6F06BEF26 | totalplayers << 3;

      foreach(player in _id_607DA387F3617ED1)
      player setclientomnvar("ui_br_contract_cancellation_state", _id_587EC5B2038407DE);

      if(_id_6640C2677653D96F._id_972EDDBDCF30619C.size > 0) {
        foreach(player in _id_607DA387F3617ED1) {
          if(!scripts\engine\utility::array_contains(_id_6640C2677653D96F._id_972EDDBDCF30619C, player))
            displayplayersplash(player, "br_" + _id_6640C2677653D96F.type.ref + "_quest_pending");
        }

        return;
      }

      return;
    }
  } else {}
}

_id_1E64EA5EB68D8119() {
  if(isDefined(self) && isDefined(self.team) && _id_7094C7010C5E3827(self.team)) {
    _id_6640C2677653D96F = _id_22239D4CFF05D0A1(self.team);
    _id_607DA387F3617ED1 = _id_EB0A92E43754AF9F(self.team);

    if(!isDefined(_id_6640C2677653D96F)) {
      return;
    }
    if(!isDefined(_id_6640C2677653D96F._id_972EDDBDCF30619C)) {
      return;
    }
    if(scripts\engine\utility::array_contains(_id_6640C2677653D96F._id_972EDDBDCF30619C, self)) {
      if(_id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag() || !scripts\mp\utility\player::isreallyalive(self))
        _id_6640C2677653D96F._id_972EDDBDCF30619C = scripts\engine\utility::array_remove(_id_6640C2677653D96F._id_972EDDBDCF30619C, self);
    }

    if(!_id_6640C2677653D96F _id_1D3D389050DDCE74(self.team)) {
      _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("mission_cancel_request", scripts\engine\utility::array_remove_array(_id_607DA387F3617ED1, _id_6640C2677653D96F._id_972EDDBDCF30619C));
      _id_7AA06BE6F06BEF26 = _id_6640C2677653D96F _id_C142D6B260F19EE7(self.team);
      totalplayers = _id_607DA387F3617ED1.size;
      _id_587EC5B2038407DE = _id_7AA06BE6F06BEF26 | totalplayers << 3;

      foreach(player in _id_607DA387F3617ED1)
      player setclientomnvar("ui_br_contract_cancellation_state", _id_587EC5B2038407DE);
    }
  }
}

_id_7871E27C25160F63(_id_EA3E3B2121E6713A, value) {
  if(isDefined(_id_EA3E3B2121E6713A)) {
    switch (_id_EA3E3B2121E6713A) {
      case "br_cancel_contract":
        _id_DB96249C7BFDEC0B();
        break;
    }
  }
}
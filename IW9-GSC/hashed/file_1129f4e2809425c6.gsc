/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1129f4e2809425c6.gsc
***********************************************/

_id_EDA57308516BFC5F() {
  return _id_0D74AE0B4AA21186::_id_BFFB5B682A4EF6A2(::_id_E0844A2B7F904B14, ::_id_E3D9D27A30E4D693, 500);
}

_id_E0844A2B7F904B14(bot) {
  _id_72BB89E60D3674DF = 0;
  target = undefined;
  _id_FDF6F26ABEE82B42 = bot _id_2D121AC0A4E1A5B8::_id_7E7DDFA33EFF2C11();
  _id_FDF6F26ABEE82B42 _id_2D121AC0A4E1A5B8::_id_2F1735D1CB737A0C(bot);
  _id_FDF6F26ABEE82B42 _id_2D121AC0A4E1A5B8::_id_8500E6AE452B1E19(self._id_E889B543C8E054AE._id_93102C55F2858271);

  foreach(player in _id_FDF6F26ABEE82B42.result) {
    if(isbot(player)) {
      continue;
    }
    if(!bot _id_59FF79D681BB860C::_id_3569A4BEC8B9AF17(player)) {
      continue;
    }
    if(_id_A01120D129FA7B98(bot.origin, player.origin)) {
      continue;
    }
    _id_DF8E0358F6E2B842 = distance(bot.origin, player.origin);

    if(_id_DF8E0358F6E2B842 > 15600) {
      continue;
    }
    basescore = _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_DF8E0358F6E2B842, self._id_E889B543C8E054AE._id_96AF88C97DB9ED21, self._id_E889B543C8E054AE._id_49E2976CA0C853EF);
    score = basescore;
    _id_00D3C92F2EE715F0 = player.origin - bot.origin;
    _id_3FB4D99C9FB3DF17 = anglesToForward(bot.angles);
    _id_29A6FCF2B56726C5 = _func_C1AA7C066EC92CA5(_id_00D3C92F2EE715F0, _id_3FB4D99C9FB3DF17);
    _id_591CC61420E4B5B3 = _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_29A6FCF2B56726C5, self._id_E889B543C8E054AE._id_B8EB6B85B8EBB591, self._id_E889B543C8E054AE._id_AA7751BB8BB0BF4E);
    score = score + _id_591CC61420E4B5B3;
    health = bot.health;
    maxhealth = bot.maxhealth;

    if(isDefined(bot._id_8790C077C95DB752)) {
      if(bot _id_07C40FA80892A721::hasarmor())
        health = health + bot _id_07C40FA80892A721::_id_AC266FC218266D08();

      maxhealth = maxhealth + bot._id_8790C077C95DB752;
    }

    _id_559A0810819CF4F0 = health / maxhealth;
    _id_1A8E8250C82242E2 = _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_559A0810819CF4F0, self._id_E889B543C8E054AE._id_DFF6F563A1619566, self._id_E889B543C8E054AE._id_6B5B5A20F3356EE3);
    score = score + _id_1A8E8250C82242E2;
    _id_FC5D9D6DC490CE2E = bot _id_32ABD1C08A25ABB5::_id_FC5D9D6DC490CE2E();
    _id_527A822FE7F798A1 = scripts\engine\utility::ter_op(_id_FC5D9D6DC490CE2E, self._id_E889B543C8E054AE._id_527A822FE7F798A1, 0);
    score = score + _id_527A822FE7F798A1;

    if(isDefined(bot.primaryweaponobj)) {
      _id_7EF185D0CBFCE036 = bot getweaponammoclip(bot.primaryweaponobj);
      clipsize = weaponclipsize(bot.primaryweaponobj);
      _id_D2A5D6A23F329F50 = _id_7EF185D0CBFCE036 / clipsize;
      _id_3E095565A4B9C4C2 = _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_D2A5D6A23F329F50, self._id_E889B543C8E054AE._id_D318160B4EC63DC6, self._id_E889B543C8E054AE._id_B42A419B44ACD2C3);
      score = score + _id_3E095565A4B9C4C2;
    }

    if(score > _id_72BB89E60D3674DF) {
      _id_72BB89E60D3674DF = score;
      target = player;
    }
  }

  if(isDefined(target))
    self._id_DF9D35D9B4BEE654 = _id_E3D9D27A30E4D693(target);

  return _id_72BB89E60D3674DF;
}

_id_E3D9D27A30E4D693(target) {
  targetname = _id_59FF79D681BB860C::_id_EE72E3F03E5196B7(target);
  return _id_0D74AE0B4AA21186::_id_FF35A4D756374EDE("retreat", target, "main", targetname + "/" + target getentitynumber(), ::_id_35671B7B1A04BF58, self, ::_id_F4CAAE7E8AF9D32C);
}

_id_35671B7B1A04BF58(bot) {
  target = self._id_EC02147FEE952CE2;
  target endon("death_or_disconnect");
  _id_E24929C0E254D7B4 = _id_6DA2BC8030016571(bot, target);

  if(!isDefined(_id_E24929C0E254D7B4))
    return "No destination";

  bot botsetstance("stand");
  bot _id_59FF79D681BB860C::_id_9E400058EF021B03(_id_E24929C0E254D7B4, 40);
  result = undefined;
  timeout = gettime() + 10000;

  while(gettime() < timeout) {
    bot botpressbutton("sprint", 1);
    result = bot scripts\engine\utility::waittill_any_in_array_or_timeout(["goal", "bad_path", "long_path"], 1);

    if(result == "goal") {
      break;
    } else if(result != "timeout")
      return result;
  }

  if(result == "goal") {
    bot _id_40E63DD222434655::_id_8B201BCCC0AA3695(target.origin);
    _id_DFE9EC231AA6A11A = randomfloatrange(1, 2);
    wait(_id_DFE9EC231AA6A11A);
  }
}

_id_6DA2BC8030016571(bot, target) {
  _id_49B762AA51419FB1 = _func_767CEA82B001F645(bot.origin - target.origin);
  _id_B56234440660BFDB = (0, 0, 50);
  _id_5DC6E1BA94643E35 = target.origin + _id_B56234440660BFDB;
  _id_85FDF001348A0FB9 = [240, 480, 640];

  foreach(dist in _id_85FDF001348A0FB9) {
    _id_575F3E579533510E = -60;
    _id_7FBCF617807A62B4 = 30;

    for(_id_73B73A6A4727117E = _id_575F3E579533510E; _id_73B73A6A4727117E <= -1 * _id_575F3E579533510E; _id_73B73A6A4727117E = _id_73B73A6A4727117E + _id_7FBCF617807A62B4) {
      _id_404EE9885D942A78 = 97000;
      _id_F5DC775212E51E06 = rotatevector(_id_49B762AA51419FB1, (0, _id_73B73A6A4727117E, 0));
      _id_95E0C7F3C4F7D3B6 = bot.origin + _id_F5DC775212E51E06 * dist;
      _id_FAB2B08DC6826750 = getclosestpointonnavmesh(_id_95E0C7F3C4F7D3B6);

      if(distancesquared(_id_95E0C7F3C4F7D3B6, _id_FAB2B08DC6826750) > _id_404EE9885D942A78) {
        continue;
      }
      _id_7D9A6D00A336393B = _id_2695A20D4011076D::getmintimetillpointindangercircle(_id_95E0C7F3C4F7D3B6);
      _id_52F22C4C2185736B = 5;

      if(_id_7D9A6D00A336393B >= 0 &_id_7D9A6D00A336393B < _id_52F22C4C2185736B) {
        continue;
      }
      _id_1F0571D36D0DF95B = scripts\engine\trace::ray_trace(_id_5DC6E1BA94643E35, _id_FAB2B08DC6826750 + _id_B56234440660BFDB, [bot, target], scripts\engine\trace::create_ainosight_contents());
      _id_8E7BAEB9B487CB3D = distance2dsquared(_id_1F0571D36D0DF95B["position"], bot.origin) > _id_404EE9885D942A78;
      _id_1D8777F78DA475B3 = _id_1F0571D36D0DF95B["hittype"] != "hittype_none";

      if(!_id_8E7BAEB9B487CB3D && _id_1D8777F78DA475B3)
        return _id_FAB2B08DC6826750;
    }
  }

  self._id_A0185A724941F02F _id_27D1CC325885F9B9(bot.origin, target.origin);
  return undefined;
}

_id_A01120D129FA7B98(_id_6305027F095FBC1B, _id_D97760A5FB91D9C4) {
  if(isDefined(self._id_CE6CBD8283ED0EE8) && self._id_CE6CBD8283ED0EE8.size > 0) {
    foreach(_id_5EFF58562BE2DD0B in self._id_CE6CBD8283ED0EE8) {
      _id_0D22FDCA158E266E = 5400;

      if(distancesquared(_id_5EFF58562BE2DD0B._id_6305027F095FBC1B, _id_6305027F095FBC1B) < _id_0D22FDCA158E266E && distancesquared(_id_5EFF58562BE2DD0B._id_D97760A5FB91D9C4, _id_D97760A5FB91D9C4) < _id_0D22FDCA158E266E)
        return 1;
    }
  }

  return 0;
}

_id_27D1CC325885F9B9(_id_6305027F095FBC1B, _id_D97760A5FB91D9C4) {
  _id_5EFF58562BE2DD0B = spawnStruct();
  _id_5EFF58562BE2DD0B._id_6305027F095FBC1B = _id_6305027F095FBC1B;
  _id_5EFF58562BE2DD0B._id_D97760A5FB91D9C4 = _id_D97760A5FB91D9C4;

  if(!isDefined(self._id_CE6CBD8283ED0EE8))
    self._id_CE6CBD8283ED0EE8 = [];

  if(self._id_CE6CBD8283ED0EE8.size >= 5)
    self._id_CE6CBD8283ED0EE8 = scripts\engine\utility::array_remove_index(self._id_CE6CBD8283ED0EE8, 0);

  self._id_CE6CBD8283ED0EE8[self._id_CE6CBD8283ED0EE8.size] = _id_5EFF58562BE2DD0B;
}

_id_F4CAAE7E8AF9D32C(action) {
  if(_id_0D74AE0B4AA21186::_id_D57DD414963503D1())
    self botlookatpoint(undefined);
}
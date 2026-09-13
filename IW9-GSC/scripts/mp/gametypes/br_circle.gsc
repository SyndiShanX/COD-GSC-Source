/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_circle.gsc
***********************************************/

initcircle() {
  if(_id_362C58E8BB39BCDA::isfeaturedisabled("circle")) {
    level.br_circle_disabled = 1;
    return;
  }

  if(!isDefined(level.br_level)) {
    return;
  }
  level.br_circle = spawnStruct();
  level.br_circle.mapbounds = level.br_level.br_mapbounds;

  if(getdvarint("scr_br_circle_fixed_damage", 0) > 0)
    level.br_circle.damagetick = [getdvarint("scr_br_circle_fixed_damage", 0)];
  else if(level.mapname == "mp_quarry2" || level.mapname == "mp_prison" || level.mapname == "mp_lumber")
    level.br_circle.damagetick = [9, 9, 9, 9, 9];
  else
    level.br_circle.damagetick = [9, 9, 9, 9, 9, 9, 9, 9];

  level._id_53C0FA66001CFF52 = getdvarint("dvar_BC78C3747F2A6AB4", 1000);
  setomnvar("ui_br_minimap_radius", level.br_level.br_circleminimapradii[0]);
  _id_B6F3E70EF79763BE = level.br_level.br_circleclosetimes.size;
  setomnvar("ui_br_total_circle_collapse_count", _id_B6F3E70EF79763BE);
  level.br_circle.circleindex = -1;
  level.br_circle._id_0A0D948A339EEE04 = 0;
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "br_isPointInCircle", ::_id_024C5A8D31AE262F);
  _id_3C46A15A541390CF::init();
  _id_21CCCABF14B4DBE6::init();
  level thread _id_58F20490049AF6AC::_id_8E779F490BBD1AE9();

  if(isDefined(level._id_EA923BF109F8A376)) {
    _id_64F6D9B4BA95ED35();
    [[level._id_EA923BF109F8A376]]();
  } else
    _precalcsafecirclecenters();

  _id_3C46A15A541390CF::_id_598312EB02C8EB61();

  if(getdvarint("dvar_6CE99C9BCE6E5660", 0))
    _id_7FB9A2D57C0C42E2();

  if(istrue(_id_4BFF90E55E5E18E4()))
    _id_64AEDA8C8A4179C5(1);
}

_id_0C85D65F8D1F9413() {
  br_circleclosetimes = _id_38773AE9C311A6EA(getDvar("dvar_6CD6DC22DEC17DBF", ""));
  br_circledelaytimes = _id_38773AE9C311A6EA(getDvar("dvar_72781CBA09F3E490", ""));
  br_circleshowdelaydanger = _id_38773AE9C311A6EA(getDvar("dvar_78CF613EDD8CE3F8", ""));
  br_circleshowdelaysafe = _id_38773AE9C311A6EA(getDvar("dvar_2FD27B62394D3332", ""));
  br_circleminimapradii = _id_38773AE9C311A6EA(getDvar("dvar_8C15E38A9558EA05", ""));
  br_circleradii = _id_38773AE9C311A6EA(getDvar("dvar_D29EE9CB1D59BCB6", ""));

  if(br_circleclosetimes.size > 0)
    level.br_level.br_circleclosetimes = br_circleclosetimes;

  if(br_circledelaytimes.size > 0)
    level.br_level.br_circledelaytimes = br_circledelaytimes;

  if(br_circleshowdelaydanger.size > 0)
    level.br_level.br_circleshowdelaydanger = br_circleshowdelaydanger;

  if(br_circleshowdelaysafe.size > 0)
    level.br_level.br_circleshowdelaysafe = br_circleshowdelaysafe;

  if(br_circleminimapradii.size > 0)
    level.br_level.br_circleminimapradii = br_circleminimapradii;

  if(br_circleradii.size > 0)
    level.br_level.br_circleradii = br_circleradii;
}

_id_38773AE9C311A6EA(_id_6686D1519FD59C8D) {
  array = strtok(_id_6686D1519FD59C8D, " ");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++)
    array[_id_AC0E594AC96AA3A8] = int(array[_id_AC0E594AC96AA3A8]);

  return array;
}

initcirclepoststarttocircleindex(origin, _id_8F6402AD8E91DA6A, _id_00836A83C2BCA261, _id_26189638809F7B88) {
  if(isDefined(level.br_circle)) {
    return;
  }
  level.br_circle = spawnStruct();
  level.br_circle.mapbounds = level.br_level.br_mapbounds;
  level.br_circle.damagetick = [9, 9, 9, 9, 9, 9, 9, 9];
  _id_B3720D45E34D6FBB = level.br_level.br_circleclosetimes.size - 1;

  if(!isDefined(_id_00836A83C2BCA261) || _id_00836A83C2BCA261 < 0)
    _id_00836A83C2BCA261 = 0;
  else if(_id_00836A83C2BCA261 > _id_B3720D45E34D6FBB)
    _id_00836A83C2BCA261 = _id_B3720D45E34D6FBB;

  _id_176ECFACEE5F2EF4 = level.br_level.br_circleclosetimes.size - _id_00836A83C2BCA261;
  _id_7A29DCF228EDD854 = level.br_level.br_circleradii[0];

  if(!isDefined(_id_26189638809F7B88) || _id_26189638809F7B88 <= 0)
    _id_26189638809F7B88 = level.br_level.br_circleclosetimes[0];

  level.br_circle.circleindex = -1;
  level.br_level.circle_defaults = undefined;
  level.br_circle.damagetick = copycirclearraystartingat(level.br_circle.damagetick, _id_00836A83C2BCA261);
  level.br_level.br_circleclosetimes = copycirclearraystartingat(level.br_level.br_circleclosetimes, _id_00836A83C2BCA261);
  level.br_level.br_circledelaytimes = getzeroarray(_id_176ECFACEE5F2EF4, _id_8F6402AD8E91DA6A);
  level.br_level.br_circleshowdelaydanger = getzeroarray(_id_176ECFACEE5F2EF4, _id_8F6402AD8E91DA6A);
  level.br_level.br_circleshowdelaysafe = copycirclearraystartingat(level.br_level.br_circleshowdelaysafe, _id_00836A83C2BCA261);
  level.br_level.br_circleminimapradii = copycirclearraystartingat(level.br_level.br_circleminimapradii, _id_00836A83C2BCA261);
  level.br_level.br_circleradii = copycirclearraystartingat(level.br_level.br_circleradii, _id_00836A83C2BCA261);
  level.br_level.br_circleradii[0] = _id_7A29DCF228EDD854;
  level.br_level.br_circleclosetimes[0] = _id_26189638809F7B88;
  applycirclesettings();
  level thread _precalcsafecirclecenters(origin);
  level notify("CirclePeekCleanup");

  if(isDefined(level.circlepeeks)) {
    foreach(_id_582E2E465A7917EE in level.circlepeeks)
    _id_582E2E465A7917EE scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();

    level.circlepeeks = undefined;

    if(getdvarint("dvar_82BDE055B11E6698", 0))
      _id_3ACF1C0EBAF602F2::setupcirclepeek();
    else
      _id_5238DEE479BBF7FB::setupcirclepeek();
  }

  thread runcircles(0);
}

copycirclearraystartingat(_id_4C55469B726B54F6, _id_2F55781AF96F22F9) {
  if(_id_2F55781AF96F22F9 == 0)
    return _id_4C55469B726B54F6;

  _id_4C55469B726B54F6 = scripts\engine\utility::array_slice(_id_4C55469B726B54F6, _id_2F55781AF96F22F9, _id_4C55469B726B54F6.size);
  return _id_4C55469B726B54F6;
}

getzeroarray(_id_A61C75B156FC1EE0, _id_3739E75778DDC8CA) {
  _id_BFC65A378A6D8EFE = [];
  _id_BFC65A378A6D8EFE[0] = _id_3739E75778DDC8CA;

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < _id_A61C75B156FC1EE0; _id_AC0E594AC96AA3A8++)
    _id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size] = 0;

  return _id_BFC65A378A6D8EFE;
}

getsafecircleorigin() {
  if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent))
    return (level.br_circle.safecircleent.origin[0], level.br_circle.safecircleent.origin[1], 0);
  else
    return (0, 0, 0);
}

getsafecircleradius() {
  if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent))
    return level.br_circle.safecircleent.origin[2];
  else
    return 0;
}

getdangercircleorigin() {
  if(isDefined(level.br_circle) && isDefined(level.br_circle.dangercircleent))
    return (level.br_circle.dangercircleent.origin[0], level.br_circle.dangercircleent.origin[1], 0);
  else
    return (0, 0, 0);
}

getdangercircleradius() {
  if(isDefined(level.br_circle) && isDefined(level.br_circle.dangercircleent))
    return level.br_circle.dangercircleent.origin[2];
  else
    return 0;
}

getnextsafecircleorigin() {
  _id_3C3E327952CE34D3 = level.br_circle.circleindex + 2;

  if(_id_3C3E327952CE34D3 < level.br_level.br_circlecenters.size)
    return level.br_level.br_circlecenters[_id_3C3E327952CE34D3];
  else
    return undefined;
}

getnextsafecircleradius() {
  _id_3C3E327952CE34D3 = level.br_circle.circleindex + 2;

  if(_id_3C3E327952CE34D3 < level.br_level.br_circleradii.size)
    return level.br_level.br_circleradii[_id_3C3E327952CE34D3];
  else
    return undefined;
}

canseesafecircleui() {
  return isDefined(level.br_circle.safecircleent) && !istrue(level.br_circle.safecircleent.hidden);
}

canseedangercircleui() {
  return isDefined(level.br_circle.dangercircleent) && !istrue(level.br_circle.dangercircleent.hidden);
}

playercanseedangercircleworld() {
  if(istrue(self.wasingulag))
    return 0;

  if(istrue(self.gulag)) {
    if(istrue(self.gulagarena) || istrue(self.jailed))
      return 0;
  }

  if(istrue(self._id_E6204058F06B94E5))
    return 0;

  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("playerCanSeeDangerCircleWorld")) {
    result = _id_362C58E8BB39BCDA::runbrgametypefunc("playerCanSeeDangerCircleWorld");

    if(isDefined(result))
      return result;
  }

  return canseedangercircleui();
}

cancircledamageplayer(player) {
  return isalive(player) && player playercanseedangercircleworld() && !istrue(player.gulag) && !istrue(player.inrespawnc130) && !player _id_2CEDCC356F1B9FC8::playeriszombie() && !isDefined(player.c130) && !_id_D4FBB8E1E555B4F0(player.origin) && !istrue(player._id_E6204058F06B94E5);
}

_id_D4FBB8E1E555B4F0(position) {
  if(isDefined(level._id_BFBDE2B8715F6C72)) {
    foreach(zone in level._id_BFBDE2B8715F6C72) {
      _id_75FAFF8AF3DDA5B6 = _func_92B7F40B735F689F(zone, position);

      if(_id_75FAFF8AF3DDA5B6)
        return 1;
    }
  }

  return 0;
}

tryplaycoughaudio(_id_DC548D1807CA0B2F) {
  player = self;

  if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
  if(istrue(player.extracted)) {
    return;
  }
  if(!isDefined(player.operatorcustomization)) {
    return;
  }
  if(player scripts\mp\utility\killstreak::isjuggernaut()) {
    return;
  }
  if(isDefined(player.brcirclecoughnexttime) && gettime() < player.brcirclecoughnexttime) {
    return;
  }
  _id_B78D7611DD745DDF = randomintrange(5000, 7000);

  if(isDefined(_id_DC548D1807CA0B2F))
    _id_B78D7611DD745DDF = _id_DC548D1807CA0B2F;

  player.brcirclecoughnexttime = gettime() + _id_B78D7611DD745DDF;

  if(!isai(player))
    player playsoundtoplayer("gas_player_cough", player, player);

  _id_4DE0F8859B1A8D67 = "allies_male_cough";
  _id_95CE4F91D0F58568 = _id_2CEDCC356F1B9FC8::brgetoperatorteam(player);
  _id_AE461AB77282F77C = player.operatorcustomization.gender;

  if(isDefined(_id_95CE4F91D0F58568) && _id_95CE4F91D0F58568 == "axis") {
    if(isDefined(_id_AE461AB77282F77C) && _id_AE461AB77282F77C == "female")
      _id_4DE0F8859B1A8D67 = "axis_female_cough";
    else
      _id_4DE0F8859B1A8D67 = "axis_male_cough";
  } else if(isDefined(_id_AE461AB77282F77C) && _id_AE461AB77282F77C == "female")
    _id_4DE0F8859B1A8D67 = "allies_female_cough";
  else
    _id_4DE0F8859B1A8D67 = "allies_male_cough";

  _id_D4EB9B956E707234 = randomint(game["dialogue"][_id_4DE0F8859B1A8D67].size);
  _id_818F7C4CF3588018 = game["dialogue"][_id_4DE0F8859B1A8D67][_id_D4EB9B956E707234];

  if(isDefined(player) && player scripts\cp_mp\utility\player_utility::_isalive())
    player playSound(_id_818F7C4CF3588018, player, player);
}

_id_F8D9C5F59FC6C187() {
  if(!isDefined(self._id_8D272C0341202E9D)) {
    self._id_8D272C0341202E9D = gettime();
    self setclientomnvar("ui_br_player_is_in_gas", 1);
  }
}

_id_6FCDEA7A7060CE40() {
  self._id_8D272C0341202E9D = undefined;
  self setclientomnvar("ui_br_player_is_in_gas", 0);
}

_id_CE6456364079CCE7() {
  _id_CA59D6183CCB9870 = [60.0, 90.0, 120.0];
  _id_421B5B34A21338D1 = [2.0, 3.0, 10.0];
  data = spawnStruct();
  data.enabled = getdvarint("dvar_A4814B42ABCAA1D7", 1);
  data._id_8D1ED26B4A14CB16 = getdvarint("dvar_8799DCDED2374711", 3);
  data._id_149B29E625082ED4 = [];
  data._id_85DCE75BAB934DA3 = [];
  _id_6B7BEE46F2C6DA28 = 0.0;
  _id_CD78C15DE6F76D7B = 1.0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < data._id_8D1ED26B4A14CB16; _id_AC0E594AC96AA3A8++) {
    _id_F273AC584195F5A3 = undefined;
    _id_680582B33F7DFC98 = undefined;

    if(_id_AC0E594AC96AA3A8 < _id_CA59D6183CCB9870.size) {
      _id_F273AC584195F5A3 = _id_CA59D6183CCB9870[_id_AC0E594AC96AA3A8];
      _id_680582B33F7DFC98 = _id_421B5B34A21338D1[_id_AC0E594AC96AA3A8];
      _id_6B7BEE46F2C6DA28 = _id_F273AC584195F5A3;
      _id_CD78C15DE6F76D7B = _id_680582B33F7DFC98;
    } else {
      _id_6B7BEE46F2C6DA28 = _id_6B7BEE46F2C6DA28 + 1.0;
      _id_CD78C15DE6F76D7B = _id_CD78C15DE6F76D7B + 1.0;
      _id_F273AC584195F5A3 = _id_6B7BEE46F2C6DA28;
      _id_680582B33F7DFC98 = _id_CD78C15DE6F76D7B;
    }

    data._id_149B29E625082ED4[_id_AC0E594AC96AA3A8] = getdvarfloat(_func_2EF675C13CA1C4AF("dvar_1E5BCED3BAD4BB2C", _id_AC0E594AC96AA3A8 + 1), _id_F273AC584195F5A3);
    data._id_85DCE75BAB934DA3[_id_AC0E594AC96AA3A8] = getdvarfloat(_func_2EF675C13CA1C4AF("dvar_73AA78457E1FA15D", _id_AC0E594AC96AA3A8 + 1), _id_680582B33F7DFC98);
  }

  return data;
}

_id_1E0F84E555B3DE7D(data, damagetick) {
  if(!data.enabled)
    return damagetick;

  if(!isDefined(self._id_8D272C0341202E9D))
    return damagetick;

  _id_8C4FA1BB96483AAC = (gettime() - self._id_8D272C0341202E9D) * 0.001;

  for(_id_AC0E594AC96AA3A8 = data._id_8D1ED26B4A14CB16 - 1; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
    _id_6B7BEE46F2C6DA28 = data._id_149B29E625082ED4[_id_AC0E594AC96AA3A8];

    if(_id_8C4FA1BB96483AAC >= _id_6B7BEE46F2C6DA28) {
      _id_CD78C15DE6F76D7B = data._id_85DCE75BAB934DA3[_id_AC0E594AC96AA3A8];
      return int(damagetick * _id_CD78C15DE6F76D7B);
    }
  }

  return damagetick;
}

_id_024C5A8D31AE262F(origin, _id_819EDACDACB810E4, _id_E86632D645C137D0) {
  if(!isDefined(_id_819EDACDACB810E4))
    _id_819EDACDACB810E4 = getdangercircleorigin();

  if(!isDefined(_id_E86632D645C137D0))
    _id_E86632D645C137D0 = getdangercircleradius();

  return distance2dsquared(_id_819EDACDACB810E4, origin) > _id_E86632D645C137D0 * _id_E86632D645C137D0;
}

_id_D449927F9683E871(origin) {
  if(!isDefined(level.br_level) || !isDefined(level.br_level.br_circlecenters) || !isDefined(level.br_level.br_circleradii))
    return 1;

  _id_0B437074E5962CE5 = 0;

  if(getdvarint("dvar_32BD10766631266F", 0) == 1)
    _id_0B437074E5962CE5 = 1;

  _id_A019F99EFFA95BE2 = (level.br_level.br_circlecenters[_id_0B437074E5962CE5][0], level.br_level.br_circlecenters[_id_0B437074E5962CE5][1], 0);
  _id_3675D09395CAF91A = squared(level.br_level.br_circleradii[_id_0B437074E5962CE5]);
  return distance2dsquared(_id_A019F99EFFA95BE2, origin) < _id_3675D09395CAF91A;
}

circledamagetick() {
  level endon("game_ended");
  level endon("endCircleDamageTick");

  while(level.br_circle.circleindex < 0)
    waitframe();

  if(_id_362C58E8BB39BCDA::isfeatureenabled("circleEarlyStart"))
    level waittill("infils_ready");

  _id_5D954F1724092F5A = getdvarfloat("scr_br_circle_object_cleanup_threshold", 1000.0);
  _id_A058DC250ACE641D = _id_CE6456364079CCE7();

  for(;;) {
    if(isDefined(level.br_circle.dangercircleent)) {
      index = level.br_circle.circleindex;

      if(index > level.br_circle.damagetick.size - 1)
        index = level.br_circle.damagetick.size - 1;

      damagetick = level.br_circle.damagetick[index];

      if(isDefined(level.circledamagemultiplier))
        damagetick = damagetick * level.circledamagemultiplier;

      if(damagetick > 0) {
        _id_819EDACDACB810E4 = getdangercircleorigin();
        _id_E86632D645C137D0 = getdangercircleradius();

        foreach(player in level.players) {
          if(!isDefined(player) || !isDefined(player.origin)) {
            continue;
          }
          if(isDefined(player) && istrue(player._id_A6637F42471575BC)) {
            continue;
          }
          if(_id_362C58E8BB39BCDA::isfeatureenabled("circleEarlyStart") && istrue(player.plotarmor)) {
            player _id_6FCDEA7A7060CE40();

            if(getdvarint("dvar_ACFF883BB1879E40", 0))
              logstring("CIRCLE DAMAGE LOGGING: Resetting player gas timer for " + player.name + " during circle index " + index + "for circleEarlyStart and plotArmor.");

            continue;
          }

          _id_ACFA1A113BA7D7C7 = 0;

          if(_id_024C5A8D31AE262F(player.origin, _id_819EDACDACB810E4, _id_E86632D645C137D0)) {
            if(player cancircledamageplayer(player)) {
              _id_ACFA1A113BA7D7C7 = 1;
              player _id_F8D9C5F59FC6C187();

              if(getdvarint("scr_time_in_gas_damage_modifier_enabled", 0) == 1)
                _id_36E462D047634362 = player _id_1E0F84E555B3DE7D(_id_A058DC250ACE641D, damagetick);
              else
                _id_36E462D047634362 = damagetick;

              _id_973F8E42FB3C591B = _id_36E462D047634362;

              if(isDefined(level._id_AA1AAED4A9B80D4B) && isDefined(level._id_152D5A9C5AC5CDAD) && level.br_circle.circleindex <= level._id_AA1AAED4A9B80D4B)
                _id_973F8E42FB3C591B = _id_973F8E42FB3C591B * level._id_152D5A9C5AC5CDAD;

              if(scripts\cp_mp\gasmask::hasgasmask(player)) {
                if(_id_7E52B56769FA7774::_id_F213F06EBA604BBD(player)) {
                  if(istrue(player._id_A18181D8BDAA0DAB))
                    player notify("gasmask_buffer_reset");
                  else if(level._id_5312BC14BD5DB377 > 0) {
                    player._id_A18181D8BDAA0DAB = 1;
                    player thread _id_7E52B56769FA7774::_id_A1D897962A19D27E();
                  }
                }

                if(istrue(player._id_A18181D8BDAA0DAB)) {
                  if(!istrue(player.gasmaskequipped))
                    player _id_81652BAD17CD28BD(_id_36E462D047634362);

                  player scripts\cp_mp\gasmask::processdamage(_id_973F8E42FB3C591B);
                } else if(isDefined(player.gasmaskhealth) && player.gasmaskhealth <= 0) {
                  player playsoundtoplayer("br_gas_mask_break_plr", player);
                  player _id_7E52B56769FA7774::_id_04D16B9C52EFA3B8();
                  player _id_7E52B56769FA7774::_id_8E9B00A1D2B23D72();
                } else {
                  player _id_7E52B56769FA7774::_id_00CDF7F2F6BD3207("br_circle");
                  player scripts\cp_mp\gasmask::processdamage(_id_973F8E42FB3C591B);
                }
              } else
                player _id_81652BAD17CD28BD(_id_36E462D047634362);

              if(_id_2D9D24F7C63AC143::_id_8B121DD10A442DD2())
                player _id_2D9D24F7C63AC143::_id_5323BEF1AD6244B9(_id_973F8E42FB3C591B);
            } else {
              if(getdvarint("dvar_ACFF883BB1879E40", 0))
                logstring("CIRCLE DAMAGE LOGGING: Resetting player gas timer for " + player.name + " during circle index " + index + "for failing canCircleDamagePlayer check.");

              player _id_6FCDEA7A7060CE40();
            }
          } else {
            player _id_6FCDEA7A7060CE40();

            if(scripts\cp_mp\gasmask::hasgasmask(player)) {
              if(_id_7E52B56769FA7774::_id_F213F06EBA604BBD(player)) {
                if(istrue(player._id_A18181D8BDAA0DAB))
                  player notify("gasmask_buffer_reset");
                else if(level._id_5312BC14BD5DB377 > 0) {
                  player._id_A18181D8BDAA0DAB = 1;
                  player thread _id_7E52B56769FA7774::_id_A1D897962A19D27E();
                }
              }

              if(istrue(player._id_A18181D8BDAA0DAB))
                continue;
              else if(isDefined(player.gasmaskhealth) && player.gasmaskhealth <= 0) {
                player playsoundtoplayer("br_gas_mask_break_plr", player);
                player _id_7E52B56769FA7774::_id_04D16B9C52EFA3B8();
              } else
                player _id_7E52B56769FA7774::_id_8206BC54A1ED73CB("br_circle");
            }
          }

          if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
            player updateindangercirclestate(_id_ACFA1A113BA7D7C7);
        }

        _id_58F20490049AF6AC::_id_8C0F978940451524(_id_819EDACDACB810E4, _id_E86632D645C137D0, _id_5D954F1724092F5A);
      }
    }

    wait 1;
  }
}

_id_81652BAD17CD28BD(_id_36E462D047634362) {
  player = self;

  if(isDefined(level.modifybrgasdamage))
    _id_36E462D047634362 = player[[level.modifybrgasdamage]](_id_36E462D047634362);

  if(player scripts\mp\utility\killstreak::isjuggernaut())
    _id_36E462D047634362 = _id_29C32B7117E01180::modifybrgasdamage(_id_36E462D047634362);

  if(getdvarint("dvar_ACFF883BB1879E40", 0) && _id_36E462D047634362 <= 0)
    logstring("CIRCLE DAMAGE LOGGING: Logging modifiedDamageTick of zero for " + player.name + ".");

  player dodamage(_id_36E462D047634362, player.origin, player, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
  player _id_07C40FA80892A721::damagearmor(_id_36E462D047634362);
  player tryplaycoughaudio();
}

updateindangercirclestate(isincircle) {
  if(!isDefined(self.isincircle)) {
    self.isincircle = isincircle;
    self.lastcircleeventtime = gettime();
  }

  if(self.isincircle != isincircle) {
    self.isincircle = isincircle;
    currenttime = gettime();

    if(isincircle) {
      scripts\cp_mp\challenges::startchallengetimer("alive_in_gas");
      _id_715028F54BAD19A1::branalytics_circleenter(self, currenttime - self.lastcircleeventtime);
      _id_21C19CFC7139D773::_id_1976438A8865AC27("br_ftue_gas");
    } else {
      scripts\cp_mp\challenges::stopchallengetimer("alive_in_gas");
      _id_715028F54BAD19A1::branalytics_circleexit(self, currenttime - self.lastcircleeventtime);
    }

    self.lastcircleeventtime = currenttime;
  }
}

startuiclosetimer(waittime, _id_F007CE073DC3C519, _id_6B890E6BE7982EFB, circleindex, skipsplash) {
  level endon("game_ended");

  if(!isDefined(level._id_E486ACB8F70C45A2))
    setomnvar("ui_hardpoint_timer", gettime() + int(waittime * 1000));

  _id_0AE2AD6C65A8689F = _id_FC0F865DDCF551AD() || scripts\mp\utility\game::getsubgametype() == "zxp" || scripts\mp\utility\game::getsubgametype() == "plunder";

  if(!_id_F007CE073DC3C519 && !istrue(skipsplash)) {
    foreach(player in level.players) {
      if(!isbot(player) && !player _id_2CEDCC356F1B9FC8::isplayeringulag()) {
        if(istrue(_id_6B890E6BE7982EFB)) {
          player thread scripts\mp\hud_message::showsplash("br_final_circle");
          continue;
        }

        if(!_id_0AE2AD6C65A8689F || circleindex > 1)
          player thread scripts\mp\hud_message::showsplash("br_new_circle");
      }
    }
  }

  if(!isDefined(level._id_E486ACB8F70C45A2)) {
    if(istrue(_id_6B890E6BE7982EFB))
      setomnvar("ui_br_circle_state", 3);
    else
      setomnvar("ui_br_circle_state", 0);
  }

  _id_4F9EB3B7488639DB = [60, 30, 20, 10, 0];
  _id_2F55781AF96F22F9 = _id_4F9EB3B7488639DB.size - 1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_4F9EB3B7488639DB.size; _id_AC0E594AC96AA3A8++) {
    if(waittime > _id_4F9EB3B7488639DB[_id_AC0E594AC96AA3A8]) {
      _id_2F55781AF96F22F9 = _id_AC0E594AC96AA3A8;
      break;
    }
  }

  if(waittime < _id_4F9EB3B7488639DB[_id_2F55781AF96F22F9]) {
    return;
  }
  wait(waittime - _id_4F9EB3B7488639DB[_id_2F55781AF96F22F9]);

  for(_id_AC0E594AC96AA3A8 = _id_2F55781AF96F22F9; _id_AC0E594AC96AA3A8 < _id_4F9EB3B7488639DB.size - 1; _id_AC0E594AC96AA3A8++) {
    if(_id_AC0E594AC96AA3A8 == 3) {
      if(!isDefined(level._id_E486ACB8F70C45A2))
        setomnvar("ui_br_circle_state", 2);

      _id_0A0D948A339EEE04 = istrue(level.br_circle._id_0A0D948A339EEE04) && !(isDefined(level.isstandardsandbox) && !level.isstandardsandbox);

      if(_id_0A0D948A339EEE04) {
        _id_2948CA54731DE34F = 10.4;
        level thread scripts\mp\music_and_dialog::_id_A486DF26072A530A(level.br_circle.circleindex, level.br_level.br_circleclosetimes.size, _id_2948CA54731DE34F);
      }
    }

    wait(_id_4F9EB3B7488639DB[_id_AC0E594AC96AA3A8] - _id_4F9EB3B7488639DB[_id_AC0E594AC96AA3A8 + 1]);
  }

  level notify("br_circle_closing");
  _id_548072087C9FD504::_id_7D42D3F8DD68280C(0);

  foreach(player in level.players) {
    if(!isbot(player) && !player _id_2CEDCC356F1B9FC8::isplayeringulag() && (!_id_0AE2AD6C65A8689F || circleindex > 0) && !istrue(skipsplash)) {
      player thread scripts\mp\hud_message::showsplash("br_circle_moving");
      player _id_21C19CFC7139D773::_id_1976438A8865AC27("br_ftue_circle");
      player playlocalsound("br_circle_closing");
    }
  }

  if(!isDefined(level._id_E486ACB8F70C45A2))
    setomnvar("ui_br_circle_state", 1);
}

_hidesafecircleui() {
  if(scripts\mp\utility\game::getsubgametype() == "champion") {
    return;
  }
  player = self;
  player setclientomnvar("ui_br_circle0_start_time", 0);
}

setpreviewuicircle(safecircleent) {
  foreach(player in level.players) {
    if(!isbot(player)) {
      player setclientomnvar("ui_br_circle0_start_entity", safecircleent);
      player setclientomnvar("ui_br_circle0_end_entity", safecircleent);
    }
  }
}

setstaticuicircles(duration, safecircleent, _id_FB3B2613D6F0EB05, _id_6B890E6BE7982EFB) {
  foreach(_id_AC0E424AC96A7113 in level.players) {
    if(!isbot(_id_AC0E424AC96A7113)) {
      _id_416318EE02BCD7D9 = _safecircledurationforplayer(_id_AC0E424AC96A7113, duration);
      _id_AC0E424AC96A7113 setclientomnvar("ui_br_circle0_start_time", gettime());
      _id_AC0E424AC96A7113 setclientomnvar("ui_br_circle0_duration", _id_416318EE02BCD7D9);
      _id_AC0E424AC96A7113 setclientomnvar("ui_br_circle0_start_entity", safecircleent);
      _id_AC0E424AC96A7113 setclientomnvar("ui_br_circle0_end_entity", safecircleent);

      if(istrue(_id_6B890E6BE7982EFB))
        _id_AC0E424AC96A7113 _hidesafecircleui();

      _id_416318EE02BCD7D9 = _dangercircledurationforplayer(_id_AC0E424AC96A7113, duration);
      _id_AC0E424AC96A7113 setclientomnvar("ui_br_circle1_start_time", gettime());
      _id_AC0E424AC96A7113 setclientomnvar("ui_br_circle1_duration", _id_416318EE02BCD7D9);
      _id_AC0E424AC96A7113 setclientomnvar("ui_br_circle1_start_entity", _id_FB3B2613D6F0EB05);
      _id_AC0E424AC96A7113 setclientomnvar("ui_br_circle1_end_entity", _id_FB3B2613D6F0EB05);
    }
  }

  thread updatecirclehide(duration, safecircleent, _id_FB3B2613D6F0EB05);
}

setclosinguicircle(duration, safecircleent, _id_FB3B2613D6F0EB05, _id_6B890E6BE7982EFB) {
  foreach(_id_AC0E424AC96A7113 in level.players) {
    if(!isbot(_id_AC0E424AC96A7113)) {
      _id_416318EE02BCD7D9 = _safecircledurationforplayer(_id_AC0E424AC96A7113, duration);
      _id_AC0E424AC96A7113 setclientomnvar("ui_br_circle0_start_time", gettime());
      _id_AC0E424AC96A7113 setclientomnvar("ui_br_circle0_duration", _id_416318EE02BCD7D9);
      _id_AC0E424AC96A7113 setclientomnvar("ui_br_circle0_start_entity", safecircleent);
      _id_AC0E424AC96A7113 setclientomnvar("ui_br_circle0_end_entity", safecircleent);

      if(istrue(_id_6B890E6BE7982EFB))
        _id_AC0E424AC96A7113 _hidesafecircleui();

      _id_416318EE02BCD7D9 = _dangercircledurationforplayer(_id_AC0E424AC96A7113, duration);
      _id_AC0E424AC96A7113 setclientomnvar("ui_br_circle1_start_time", gettime());
      _id_AC0E424AC96A7113 setclientomnvar("ui_br_circle1_duration", _id_416318EE02BCD7D9);
      _id_AC0E424AC96A7113 setclientomnvar("ui_br_circle1_start_entity", _id_FB3B2613D6F0EB05);
      _id_AC0E424AC96A7113 setclientomnvar("ui_br_circle1_end_entity", safecircleent);
    }
  }

  thread updatecirclehide(duration, safecircleent, _id_FB3B2613D6F0EB05);
}

updatecirclehide(duration, safecircleent, _id_FB3B2613D6F0EB05) {
  level notify("update_circle_omnvars");
  level endon("update_circle_omnvars");

  for(;;) {
    level waittill("update_circle_hide");

    foreach(_id_AC0E424AC96A7113 in level.players) {
      if(!isbot(_id_AC0E424AC96A7113)) {
        _id_416318EE02BCD7D9 = _safecircledurationforplayer(_id_AC0E424AC96A7113, duration);
        _id_AC0E424AC96A7113 setclientomnvar("ui_br_circle0_duration", _id_416318EE02BCD7D9);
        _id_416318EE02BCD7D9 = _dangercircledurationforplayer(_id_AC0E424AC96A7113, duration);
        _id_AC0E424AC96A7113 setclientomnvar("ui_br_circle1_duration", _id_416318EE02BCD7D9);
      }
    }
  }
}

_dangercircledurationforplayer(player, _id_C6FA546D9034B033) {
  if(canseedangercircleui())
    return int(_id_C6FA546D9034B033 * 1000);
  else
    return 0;
}

_safecircledurationforplayer(player, _id_C6FA546D9034B033) {
  if(canseesafecircleui())
    return int(_id_C6FA546D9034B033 * 1000);
  else
    return 0;
}

islastcircle() {
  return level.br_circle.circleindex >= level.br_level.br_circleradii.size - 1 || !(level.br_level.br_circleradii[level.br_circle.circleindex + 1] > 0);
}

_id_E55C19338F6E9E0C(circleindex, timeoffset) {
  if(!isDefined(timeoffset))
    timeoffset = 0;

  _id_4A22F0DA61F0C1CF = level.br_circle.starttime / 1000;
  _id_FBDCFBD6233E2398 = gettime() / 1000 + timeoffset;
  timeremaining = _id_FBDCFBD6233E2398 - _id_4A22F0DA61F0C1CF - level.br_level.br_circledelaytimes[circleindex];
  return max(timeremaining, 0);
}

_id_8AECA3ABF89A629D(circleindex, timeoffset) {
  if(!isDefined(timeoffset))
    timeoffset = 0;

  _id_4A22F0DA61F0C1CF = level.br_circle.starttime / 1000;
  _id_FBDCFBD6233E2398 = gettime() / 1000 + timeoffset;
  timeremaining = _id_FBDCFBD6233E2398 - _id_4A22F0DA61F0C1CF - level.br_level.br_circleclosetimes[circleindex];
  return max(timeremaining, 0);
}

_id_2FB1AB6E77CC6A3D(circleindex) {
  _id_74B5B12BB6514385 = level.br_level.br_circledelaytimes[circleindex];
  _id_C2D7D58BFAD1B1EE = level.br_level.br_circleclosetimes[circleindex];
  totaltime = _id_74B5B12BB6514385 + _id_C2D7D58BFAD1B1EE;
  return totaltime;
}

_id_ABBFB4D18D1A9CA7() {
  _id_382E141C1A44E21B = level.br_circle.circleindex;
  _id_8C2CE200A652593D = _id_2FB1AB6E77CC6A3D(_id_382E141C1A44E21B);
  _id_C36DE2EA5FC9F896 = level.br_circle.starttime / 1000;
  _id_D618CF2B46344A74 = gettime() / 1000 - _id_C36DE2EA5FC9F896;
  return _id_8C2CE200A652593D - _id_D618CF2B46344A74;
}

_id_BF5F4D7A498988A8(player, _id_498E4E279FB8ED85, timeoffset) {
  _id_517E15E5E8524C5A = scripts\engine\utility::array_randomize(level.teamdata[player.team]["alivePlayers"]);
  _id_8DD50DB647861D68 = undefined;

  foreach(_id_89C718895A5117B3 in _id_517E15E5E8524C5A) {
    if(_id_89C718895A5117B3 != player) {
      _id_8DD50DB647861D68 = _id_89C718895A5117B3;
      break;
    }
  }

  if(!isDefined(_id_8DD50DB647861D68))
    return undefined;

  point = _id_8DD50DB647861D68.origin;
  _id_046BA883294ABD43 = level.br_circle.circleindex;
  _id_C0FC062071351CDA = _id_E55C19338F6E9E0C(_id_046BA883294ABD43, _id_498E4E279FB8ED85 + timeoffset);
  _id_71E46EAD9308542C = int(min(_id_046BA883294ABD43 + 1, level.br_level.br_circlecenters.size - level.br_level.br_movingcirclecount - 1));
  _id_6F469351639732E2 = level.br_level.br_circleclosetimes[_id_046BA883294ABD43];
  _id_6B1BEF6D15C8772C = level.br_level.br_circlecenters[_id_046BA883294ABD43];
  _id_36EE3127E5558D7B = level.br_level.br_circleradii[_id_046BA883294ABD43];
  _id_3BBBB179E51E3809 = level.br_level.br_circlecenters[_id_71E46EAD9308542C];
  _id_7D66506ED0054176 = level.br_level.br_circleradii[_id_71E46EAD9308542C];
  _id_BFBA751474CD67A6 = (_id_3BBBB179E51E3809 - _id_6B1BEF6D15C8772C) / _id_6F469351639732E2;
  _id_11A5C2966A360011 = (_id_7D66506ED0054176 - _id_36EE3127E5558D7B) / _id_6F469351639732E2;
  _id_2F5FF20FCE786FC1 = _id_6B1BEF6D15C8772C + _id_BFBA751474CD67A6 * _id_C0FC062071351CDA;
  _id_CC3B2AA6CC4D0F2E = _id_36EE3127E5558D7B + _id_11A5C2966A360011 * _id_C0FC062071351CDA;
  dist = distance2d(point, _id_2F5FF20FCE786FC1);
  _id_40CB6248DEE31807 = getdvarint("dvar_7525F014F690C068", 0);
  _id_1FBE1A61E1B49E9B = getdvarfloat("dvar_F8EEBBE68B000328", 1000.0);
  _id_91BE2B7482F940BA = point + (_id_2F5FF20FCE786FC1 - point) * (_id_1FBE1A61E1B49E9B / dist);

  if(isvalidpointinbounds(_id_91BE2B7482F940BA, _id_40CB6248DEE31807, _id_498E4E279FB8ED85 + timeoffset))
    return _id_91BE2B7482F940BA;

  _id_75EC7457D721F50D = getdvarfloat("dvar_921A01E1BEE01D8B", 0.5);
  _id_1FBE1A61E1B49E9B = dist * _id_75EC7457D721F50D;
  _id_91BE2B7482F940BA = point + (_id_2F5FF20FCE786FC1 - point) * (_id_1FBE1A61E1B49E9B / dist);

  if(isvalidpointinbounds(_id_91BE2B7482F940BA, _id_40CB6248DEE31807, _id_498E4E279FB8ED85 + timeoffset))
    return _id_91BE2B7482F940BA;

  _id_16290C9DDA466BCE = point - _id_2F5FF20FCE786FC1;
  _id_91BE2B7482F940BA = _id_2F5FF20FCE786FC1 + _id_CC3B2AA6CC4D0F2E / dist * _id_16290C9DDA466BCE;

  if(isvalidpointinbounds(_id_91BE2B7482F940BA, _id_40CB6248DEE31807, _id_498E4E279FB8ED85 + timeoffset))
    return _id_91BE2B7482F940BA;

  return undefined;
}

isvalidpointinbounds(point, _id_AE913F2DC0534B48, _id_498E4E279FB8ED85) {
  if(!_id_45B2B4A889E633FA::ispointinbounds(point, 1))
    return 0;

  if(istrue(_id_AE913F2DC0534B48) && _ispointinbadarea(point))
    return 0;

  if(isDefined(_id_498E4E279FB8ED85)) {
    _id_653BF8AEF0B21244 = getmintimetillpointindangercircle(point);

    if(_id_498E4E279FB8ED85 > _id_653BF8AEF0B21244)
      return 0;
  }

  return 1;
}

_id_FC52AE1478A8FC25(_id_CFA336CB6BEEEC04, _id_498E4E279FB8ED85) {
  _id_88B32122BF1B04F6 = level.teamdata[self.team]["alivePlayers"];

  if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent) && isDefined(_id_88B32122BF1B04F6)) {
    _id_517E15E5E8524C5A = scripts\engine\utility::array_sort_with_func(_id_88B32122BF1B04F6, ::_id_DAB8DE01355C25EC);

    foreach(_id_89C718895A5117B3 in _id_517E15E5E8524C5A) {
      if(_id_89C718895A5117B3 != self) {
        if(_id_89C718895A5117B3 _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag() == 0) {
          _id_EB253DA880AF5BB6 = _id_2548C1CCAE77830B(_id_89C718895A5117B3.origin, _id_CFA336CB6BEEEC04, _id_498E4E279FB8ED85);

          if(isDefined(_id_EB253DA880AF5BB6))
            return _id_EB253DA880AF5BB6;
        }
      }
    }
  }

  return undefined;
}

_id_DAB8DE01355C25EC(_id_52A462A16496CF97, _id_52A463A16496D1CA) {
  return _id_52A462A16496CF97.health >= _id_52A463A16496D1CA.health;
}

_id_BF16029A7B6FF1FA(_id_CFA336CB6BEEEC04, _id_498E4E279FB8ED85) {
  if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
    foreach(crate in level.br_pickups.crates) {
      if(!isDefined(crate) || !isDefined(crate.team) || crate.team != self.team) {
        continue;
      }
      if(isDefined(crate.playerscaptured) && isDefined(crate.playerscaptured[self getentitynumber()])) {
        continue;
      }
      _id_EB253DA880AF5BB6 = _id_2548C1CCAE77830B(crate.origin, _id_CFA336CB6BEEEC04, _id_498E4E279FB8ED85);

      if(isDefined(_id_EB253DA880AF5BB6))
        return _id_EB253DA880AF5BB6;
    }
  }

  return undefined;
}

_id_2548C1CCAE77830B(targetpos, _id_CFA336CB6BEEEC04, _id_498E4E279FB8ED85) {
  _id_A9AECD1F10A3AC37 = _id_58F20490049AF6AC::_id_DE2F1B656EE04BA9();
  _id_85A64A18900791A9 = _id_58F20490049AF6AC::_id_54798383FA7F572B();
  _id_E87E5B35F702A1ED = _id_58F20490049AF6AC::_id_7D381171EAE99B77();
  _id_F8D6627557732D6F = _id_58F20490049AF6AC::_id_BF15A5AA7E72AEE9();
  _id_40CB6248DEE31807 = getdvarint("dvar_A7A08B8F08B5BC60", 1);
  _id_FDAB7E6125110779 = undefined;
  _id_A243A9012C90F841 = undefined;

  for(index = 0; index < _id_A9AECD1F10A3AC37.size; index++) {
    safeorigin = _id_A9AECD1F10A3AC37[index];
    _id_F434D604C09196AA = _id_85A64A18900791A9[index];
    _id_EF8F7E66DC0FEB2C = _id_E87E5B35F702A1ED[index];
    _id_B2739C0F5213D0E8 = _id_F8D6627557732D6F[index];
    _id_C6AF26CE6F14B427 = _id_F434D604C09196AA * _id_F434D604C09196AA;

    if(_id_C6AF26CE6F14B427 > 0.0) {
      _id_847B006DECFBCE4F = distance2d(targetpos, _id_EF8F7E66DC0FEB2C);
      _id_909901F2C9DD9088 = 4;

      for(_id_E950DFDD6E1577DC = _id_909901F2C9DD9088; _id_E950DFDD6E1577DC >= 0; _id_E950DFDD6E1577DC--) {
        _id_34B395F4B5CA0C66 = _id_B2739C0F5213D0E8 * (_id_E950DFDD6E1577DC / _id_909901F2C9DD9088);
        _id_EB253DA880AF5BB6 = (targetpos - _id_EF8F7E66DC0FEB2C) * (_id_34B395F4B5CA0C66 / _id_847B006DECFBCE4F) * _id_CFA336CB6BEEEC04 + _id_EF8F7E66DC0FEB2C;

        if(isvalidpointinbounds(_id_EB253DA880AF5BB6, _id_40CB6248DEE31807, _id_498E4E279FB8ED85)) {
          if(getdvarint("dvar_7017AD29DBEDC8B1", 1) == 1 && isnavmeshloaded()) {
            _id_EB253DA880AF5BB6 = getclosestpointonnavmesh(_id_EB253DA880AF5BB6);

            if(!isvalidpointinbounds(_id_EB253DA880AF5BB6, _id_40CB6248DEE31807, _id_498E4E279FB8ED85))
              continue;
          }

          _id_DCE4EC4424BB0DD0 = distance2dsquared(_id_EB253DA880AF5BB6, targetpos);

          if(!isDefined(_id_A243A9012C90F841) || _id_DCE4EC4424BB0DD0 < _id_A243A9012C90F841) {
            _id_FDAB7E6125110779 = _id_EB253DA880AF5BB6;
            _id_A243A9012C90F841 = _id_DCE4EC4424BB0DD0;
          }

          break;
        }
      }
    }
  }

  return _id_FDAB7E6125110779;
}

getrandompointinboundscircle(origin, radius, _id_8108B284F99B128A, _id_812BBC84F9C17040, _id_D5998E8874D77B02, _id_38A4C729748AD94C, _id_AE913F2DC0534B48, _id_498E4E279FB8ED85, _id_DE3DE3E91A9D2170, _id_DE1AD9E91A76C3BA) {
  _id_5C9D9A8B7E76E4F2 = 8;
  _id_C6B77E459CBD9727 = origin;
  _id_556ABF7963472F10 = 0;

  if(!isDefined(_id_DE3DE3E91A9D2170))
    _id_DE3DE3E91A9D2170 = 0;

  if(!isDefined(_id_DE1AD9E91A76C3BA))
    _id_DE1AD9E91A76C3BA = 360;

  while(_id_556ABF7963472F10 < _id_5C9D9A8B7E76E4F2) {
    _id_332BFCF7ECA6F520 = getrandompointincircle(origin, radius, _id_8108B284F99B128A, _id_812BBC84F9C17040, 1, 0, _id_DE3DE3E91A9D2170, _id_DE1AD9E91A76C3BA);

    if(isvalidpointinbounds(_id_332BFCF7ECA6F520, _id_AE913F2DC0534B48, _id_498E4E279FB8ED85)) {
      _id_16330882772F973F = _id_332BFCF7ECA6F520;

      if(istrue(_id_38A4C729748AD94C) && isnavmeshloaded()) {
        _id_332BFCF7ECA6F520 = getclosestpointonnavmesh(_id_16330882772F973F);

        if(isvalidpointinbounds(_id_332BFCF7ECA6F520, _id_AE913F2DC0534B48, _id_498E4E279FB8ED85)) {
          _id_C6B77E459CBD9727 = _id_332BFCF7ECA6F520;
          break;
        }
      } else {
        _id_C6B77E459CBD9727 = _id_332BFCF7ECA6F520;
        break;
      }
    }

    _id_6D85A82025F375E8 = level.br_level.br_circlecenters[0] - origin;
    _id_6D85A82025F375E8 = (_id_6D85A82025F375E8[0], _id_6D85A82025F375E8[1], 0);
    yaw = vectortoangles(_id_6D85A82025F375E8)[1];
    _id_3777ECE6A73EADA5 = (1.0 - _id_556ABF7963472F10 / _id_5C9D9A8B7E76E4F2) * 180;
    _id_DE3DE3E91A9D2170 = yaw - _id_3777ECE6A73EADA5;
    _id_DE1AD9E91A76C3BA = yaw + _id_3777ECE6A73EADA5;
    _id_556ABF7963472F10++;
  }

  return _id_C6B77E459CBD9727;
}

getrandompointincircle(origin, radius, _id_8108B284F99B128A, _id_812BBC84F9C17040, _id_D5998E8874D77B02, _id_38A4C729748AD94C, _id_779315766223441A, _id_07F870143D9150C8) {
  if(radius <= 0.0)
    return origin;

  _id_E83450544CF8F718 = 0.0;

  if(isDefined(_id_8108B284F99B128A))
    _id_E83450544CF8F718 = _id_8108B284F99B128A;

  _id_4B623D88FD385C86 = 1.0;

  if(isDefined(_id_812BBC84F9C17040))
    _id_4B623D88FD385C86 = _id_812BBC84F9C17040;

  if(!isDefined(_id_D5998E8874D77B02))
    _id_D5998E8874D77B02 = 1;

  if(!isDefined(_id_38A4C729748AD94C))
    _id_38A4C729748AD94C = 1;

  if(!isDefined(_id_779315766223441A))
    _id_779315766223441A = 0;

  if(!isDefined(_id_07F870143D9150C8))
    _id_07F870143D9150C8 = 360;

  _id_0DDAC6DDE9BE7A08 = squared(radius * _id_E83450544CF8F718);
  _id_7EF9F894C9F94A26 = squared(radius * _id_4B623D88FD385C86);
  r = undefined;

  if(_id_0DDAC6DDE9BE7A08 == _id_7EF9F894C9F94A26)
    r = sqrt(_id_0DDAC6DDE9BE7A08);
  else
    r = sqrt(randomfloatrange(_id_0DDAC6DDE9BE7A08, _id_7EF9F894C9F94A26));

  _id_F157E2C858DD6237 = _id_779315766223441A + randomfloat(_id_07F870143D9150C8 - _id_779315766223441A);
  offset = (r * cos(_id_F157E2C858DD6237), r * sin(_id_F157E2C858DD6237), 0);
  _id_332BFCF7ECA6F520 = origin + offset;

  if(_id_D5998E8874D77B02) {
    contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1);
    _id_332BFCF7ECA6F520 = scripts\engine\utility::drop_to_ground((origin[0], origin[1], 4000) + offset, undefined, undefined, undefined, contents);
  }

  if(_id_38A4C729748AD94C && isnavmeshloaded())
    _id_332BFCF7ECA6F520 = getclosestpointonnavmesh(_id_332BFCF7ECA6F520);

  return _id_332BFCF7ECA6F520;
}

getrandompointincurrentcircle(_id_8108B284F99B128A, _id_812BBC84F9C17040) {
  _id_819EDACDACB810E4 = getdangercircleorigin();
  dist = level.br_level.br_circleradii[level.br_circle.circleindex + 1];
  return getrandompointincircle(_id_819EDACDACB810E4, dist, _id_8108B284F99B128A, _id_812BBC84F9C17040);
}

getrandompointinsafecircle(_id_8108B284F99B128A, _id_812BBC84F9C17040) {
  _id_ADD4FD7502A75A8A = getsafecircleorigin();
  _id_77E882DA07E78CFE = getsafecircleradius();
  return getrandompointincircle(_id_ADD4FD7502A75A8A, _id_77E882DA07E78CFE, _id_8108B284F99B128A, _id_812BBC84F9C17040);
}

getrandompointinboundssafecircle(_id_8108B284F99B128A, _id_812BBC84F9C17040) {
  _id_ADD4FD7502A75A8A = getsafecircleorigin();
  _id_77E882DA07E78CFE = getsafecircleradius();
  return getrandompointinboundscircle(_id_ADD4FD7502A75A8A, _id_77E882DA07E78CFE, _id_8108B284F99B128A, _id_812BBC84F9C17040);
}

ispointincurrentsafecircle(point) {
  if(!isDefined(level.br_circle.dangercircleent))
    return 0;

  _id_DDB2971CE26A24A9 = (level.br_circle.dangercircleent.origin[0], level.br_circle.dangercircleent.origin[1], 0);
  _id_77E882DA07E78CFE = level.br_level.br_circleradii[level.br_circle.circleindex + 1];
  _id_02DB625E063F40B4 = distance2dsquared(point, _id_DDB2971CE26A24A9);

  if(_id_02DB625E063F40B4 < _id_77E882DA07E78CFE * _id_77E882DA07E78CFE)
    return 1;

  return 0;
}

ispointinnextsafecircle(point) {
  _id_0CE1DA41CB549917 = getnextsafecircleorigin();
  _id_1A7E5ABE8E67CAAB = getnextsafecircleradius();

  if(!isDefined(_id_0CE1DA41CB549917) || !isDefined(_id_1A7E5ABE8E67CAAB))
    return 0;

  _id_02DB625E063F40B4 = distance2dsquared(point, _id_0CE1DA41CB549917);

  if(_id_02DB625E063F40B4 < _id_1A7E5ABE8E67CAAB * _id_1A7E5ABE8E67CAAB)
    return 1;

  return 0;
}

_id_C11714256F856E10(point) {
  circleorigin = getdangercircleorigin();
  circleradius = getdangercircleradius();
  _id_8FA87D2C8780E014 = circleradius * circleradius;

  if(distance2dsquared(point, circleorigin) < _id_8FA87D2C8780E014)
    return 1;

  return 0;
}

dangercircleenthidefromplayers() {
  self endon("death");

  for(;;) {
    self show();

    foreach(player in level.players) {
      if(!player playercanseedangercircleworld())
        self hidefromplayer(player);
    }

    level waittill("update_circle_hide");
  }
}

_id_64F6D9B4BA95ED35(_id_21231F7B22A75955) {
  if(isDefined(_id_21231F7B22A75955)) {
    level.br_circle.br_finalcircleoverride = _id_21231F7B22A75955;
    return;
  }

  level.br_circle.br_finalcircleoverride = undefined;
  _id_D7BD8769331C5B66 = getdvarvector("br_final_circle_override", (0, 0, 0));

  if(length(_id_D7BD8769331C5B66) > 0)
    level.br_circle.br_finalcircleoverride = _id_D7BD8769331C5B66;

  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("getFinalCircleCenter"))
    level.br_circle.br_finalcircleoverride = _id_362C58E8BB39BCDA::runbrgametypefunc("getFinalCircleCenter");

  _id_84E5EF30B000EF20();
}

_id_84E5EF30B000EF20() {
  if(!isDefined(level.br_level._id_257DEE2BBC2480F5)) {
    return;
  }
  _id_E60BFC21D3DCED49 = getdvarint("scr_br_final_circle_override", 0);

  if(isDefined(level._id_B31733F431ED12E0) && isDefined(level._id_B31733F431ED12E0._id_E60BFC21D3DCED49))
    _id_E60BFC21D3DCED49 = level._id_B31733F431ED12E0._id_E60BFC21D3DCED49;

  if(!isDefined(level._id_DA89DFF7E3009777)) {
    level._id_DA89DFF7E3009777 = [];
    _id_CB89110314447B2F = 0;

    for(;;) {
      _id_9A1612BF33A317B1 = tablelookupbyrow(level.br_level._id_257DEE2BBC2480F5, _id_CB89110314447B2F, 1);

      if(_id_9A1612BF33A317B1 == "") {
        break;
      }

      _id_406EDB7EDD9769A2 = int(tablelookupbyrow(level.br_level._id_257DEE2BBC2480F5, _id_CB89110314447B2F, 5));

      if(!istrue(_id_406EDB7EDD9769A2)) {
        _id_0BE9720EAAAA043E = int(tablelookupbyrow(level.br_level._id_257DEE2BBC2480F5, _id_CB89110314447B2F, 0));
        _id_0FCFB56E6D8CC156 = int(tablelookupbyrow(level.br_level._id_257DEE2BBC2480F5, _id_CB89110314447B2F, 2));
        _id_0FCFB66E6D8CC389 = int(tablelookupbyrow(level.br_level._id_257DEE2BBC2480F5, _id_CB89110314447B2F, 3));
        _id_0FCFB36E6D8CBCF0 = int(tablelookupbyrow(level.br_level._id_257DEE2BBC2480F5, _id_CB89110314447B2F, 4));
        _id_7D64A7C122B67E8A = spawnStruct();
        _id_7D64A7C122B67E8A.name = _id_9A1612BF33A317B1;
        _id_7D64A7C122B67E8A.id = _id_0BE9720EAAAA043E;
        _id_7D64A7C122B67E8A.origin = (_id_0FCFB56E6D8CC156, _id_0FCFB66E6D8CC389, _id_0FCFB36E6D8CBCF0);
        level._id_DA89DFF7E3009777[level._id_DA89DFF7E3009777.size] = _id_7D64A7C122B67E8A;
      }

      _id_CB89110314447B2F++;
    }
  }

  if(!level._id_DA89DFF7E3009777.size) {
    return;
  }
  if(_id_E60BFC21D3DCED49 == 0) {
    _id_C9BBE66D20810A2B = randomint(level._id_DA89DFF7E3009777.size);
    level.br_circle.br_finalcircleoverride = level._id_DA89DFF7E3009777[_id_C9BBE66D20810A2B].origin;
  } else {
    _id_E943E46F29A2E1CE = _id_8E888649A8178CEA(_id_E60BFC21D3DCED49);

    if(isDefined(_id_E943E46F29A2E1CE))
      level.br_circle.br_finalcircleoverride = level._id_DA89DFF7E3009777[_id_E943E46F29A2E1CE].origin;
  }
}

_id_8E888649A8178CEA(_id_EF1C0E3FA372D6F8) {
  _id_0BE9720EAAAA043E = undefined;
  validlocations = level._id_DA89DFF7E3009777;

  foreach(index, location in validlocations) {
    if(_id_EF1C0E3FA372D6F8 == location.id)
      _id_0BE9720EAAAA043E = index;
  }

  return _id_0BE9720EAAAA043E;
}

_ispointinbadarea(point) {
  if(getdvarint("dvar_507E524AE2B21F76", 0) == 1)
    return 0;

  if(!isDefined(level.br_badcircleareas) || level.br_badcircleareas.size == 0)
    return 0;

  foreach(area in level.br_badcircleareas) {
    distsq = distance2dsquared(point, area.origin);

    if(distsq < area.radiussq)
      return 1;
  }

  return 0;
}

_precalcsafecirclecenters(_id_21231F7B22A75955, _id_B7C9FE00120EA96C, _id_437C3E3159A04F4E) {
  _id_64F6D9B4BA95ED35(_id_21231F7B22A75955);
  level.br_level.br_circlecenters = [];
  mapcenter = (level.br_circle.mapbounds[0] + level.br_circle.mapbounds[1]) * 0.5;

  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("mapCenterFinalCircle"))
    mapcenter = _id_362C58E8BB39BCDA::runbrgametypefunc("mapCenterFinalCircle");

  level.br_level.br_circlecenters[0] = (mapcenter[0], mapcenter[1], 0.0);
  _id_14945B556D8AD888 = mapcenter[0];
  _id_14945C556D8ADABB = mapcenter[1];

  if(istrue(level.br_level.staticcircle)) {
    level.br_level.br_circlecenters[0] = scripts\engine\utility::drop_to_ground((_id_14945B556D8AD888, _id_14945C556D8ADABB, 4000));
    level.br_level.br_circlecenters[1] = level.br_level.br_circlecenters[0];
    return;
  }

  _id_B0FDC1A74465D5B3 = getdvarfloat("scr_br_circle_first_placement_scale", 0.0);
  _id_BA2D3E495CF92C77 = _id_B0FDC1A74465D5B3 * level.br_level.br_circleradii[1];
  _id_DCB0CCFA24D727CA = [];
  _id_DCB0CCFA24D727CA[0] = level.br_circle.mapbounds[0][0] - _id_BA2D3E495CF92C77;
  _id_DCB0CCFA24D727CA[1] = level.br_circle.mapbounds[0][1] - _id_BA2D3E495CF92C77;
  _id_DCB0CCFA24D727CA[2] = level.br_circle.mapbounds[1][0] + _id_BA2D3E495CF92C77;
  _id_DCB0CCFA24D727CA[3] = level.br_circle.mapbounds[1][1] + _id_BA2D3E495CF92C77;
  _id_4E9BDD57294562FD = min(_id_DCB0CCFA24D727CA[0], _id_DCB0CCFA24D727CA[2]);
  _id_4E78E757291F3143 = max(_id_DCB0CCFA24D727CA[0], _id_DCB0CCFA24D727CA[2]);
  _id_A056773A8AB0B014 = min(_id_DCB0CCFA24D727CA[1], _id_DCB0CCFA24D727CA[3]);
  _id_A07A653A8AD90336 = max(_id_DCB0CCFA24D727CA[1], _id_DCB0CCFA24D727CA[3]);
  [_id_91C2149316242976, circlecenter] = _id_3011D71052D72D2A();
  _id_38A4C729748AD94C = getdvarint("dvar_67A8C844BAD5A45B", 0);

  if(!_id_38A4C729748AD94C && _id_362C58E8BB39BCDA::isfeatureenabled("circleSnapToNavMesh"))
    _id_38A4C729748AD94C = 1;

  contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1);

  if(isDefined(level.br_circle.br_finalcircleoverride)) {
    _id_976DDA17532FE2C3 = level.br_circle.br_finalcircleoverride[0];
    _id_976DD917532FE090 = level.br_circle.br_finalcircleoverride[1];
    ispointinbounds = _id_45B2B4A889E633FA::ispointinbounds((_id_976DDA17532FE2C3, _id_976DD917532FE090, 0), 1);
    _id_6E3DA7022558F910 = _ispointinbadarea((_id_976DDA17532FE2C3, _id_976DD917532FE090, 0));
    _id_7956A8D6F7B21EE9 = ispointinbounds && !_id_6E3DA7022558F910;

    if(_id_7956A8D6F7B21EE9) {
      _id_14945B556D8AD888 = _id_976DDA17532FE2C3;
      _id_14945C556D8ADABB = _id_976DD917532FE090;
    }
  } else if(isDefined(_id_91C2149316242976)) {
    _id_14945B556D8AD888 = _id_91C2149316242976[0];
    _id_14945C556D8ADABB = _id_91C2149316242976[1];
    _id_4219A435C7974CB1 = (circlecenter[0], circlecenter[1], 0.0);
    _id_DF4E507441DF7921 = getdvarvector("dvar_8A7C6F38E7C7A8FC", (0, 0, 0));

    if(_id_DF4E507441DF7921 != (0, 0, 0))
      _id_4219A435C7974CB1 = _id_DF4E507441DF7921;

    if(getdvarint("dvar_BBF992A979DF8E2C", 0) == 1) {
      level.br_level.br_circlecenters[0] = _id_4219A435C7974CB1;

      if(getdvarint("dvar_32BD10766631266F", 0) == 1)
        level.br_level.br_circlecenters[1] = _id_4219A435C7974CB1;
    }
  } else {
    _id_5C9D9A8B7E76E4F2 = 8;

    for(_id_556ABF7963472F10 = 0; _id_556ABF7963472F10 < _id_5C9D9A8B7E76E4F2; _id_556ABF7963472F10++) {
      _id_976DDA17532FE2C3 = randomfloatrange(_id_4E9BDD57294562FD, _id_4E78E757291F3143);
      _id_976DD917532FE090 = randomfloatrange(_id_A056773A8AB0B014, _id_A07A653A8AD90336);

      if(_id_45B2B4A889E633FA::ispointinbounds((_id_976DDA17532FE2C3, _id_976DD917532FE090, 0), 1) && !_ispointinbadarea((_id_976DDA17532FE2C3, _id_976DD917532FE090, 0))) {
        _id_45481DBE05C81F00 = 1;

        if(_id_38A4C729748AD94C && isnavmeshloaded()) {
          groundpos = scripts\engine\utility::drop_to_ground((_id_976DDA17532FE2C3, _id_976DD917532FE090, 4000), undefined, undefined, undefined, contents);
          _id_DE5538C1E87E6BF7 = getclosestpointonnavmesh(groundpos);

          if(distance2dsquared(_id_DE5538C1E87E6BF7, (_id_976DDA17532FE2C3, _id_976DD917532FE090, 0)) > 10000.0)
            _id_45481DBE05C81F00 = 0;
        }

        if(_id_45481DBE05C81F00) {
          _id_14945B556D8AD888 = _id_976DDA17532FE2C3;
          _id_14945C556D8ADABB = _id_976DD917532FE090;
          break;
        }
      }

      _id_4E9BDD57294562FD = _id_4E9BDD57294562FD * 0.9;
      _id_4E78E757291F3143 = _id_4E78E757291F3143 * 0.9;
      _id_A056773A8AB0B014 = _id_A056773A8AB0B014 * 0.9;
      _id_A07A653A8AD90336 = _id_A07A653A8AD90336 * 0.9;
    }
  }

  _id_2082F17F2E1C69BF = level.br_level.br_circleradii.size - 1 - level.br_level.br_movingcirclecount;
  level.br_level.br_circlecenters[_id_2082F17F2E1C69BF] = scripts\engine\utility::drop_to_ground((_id_14945B556D8AD888, _id_14945C556D8ADABB, 4000));

  if(istrue(_id_437C3E3159A04F4E)) {
    return;
  }
  _id_7A50883C31353C77 = getdvarfloat("dvar_917B939513F89B55", 200);
  _id_11C1E6222DA58849 = getdvarint("scr_br_circle_clamp_max_circle_speed", 0);
  _id_C80692862885CC6B = 0;

  if(getdvarint("dvar_BBF992A979DF8E2C", 0) == 1) {
    _id_C80692862885CC6B = 1;

    if(getdvarint("dvar_32BD10766631266F", 0) == 1)
      _id_C80692862885CC6B = 2;
  }

  for(circleindex = _id_2082F17F2E1C69BF - 1; circleindex >= _id_C80692862885CC6B; circleindex--) {
    origin = level.br_level.br_circlecenters[circleindex + 1];
    radius = level.br_level.br_circleradii[circleindex];
    _id_9BEDD0ECB39838D6 = 0.0;
    _id_D6BAC3BF0F64D280 = 1.0 - level.br_level.br_circleradii[circleindex + 1] / radius;

    if(isDefined(level.br_circle._id_BF394857229861A5) && isfunction(level.br_circle._id_BF394857229861A5)) {
      [_id_5BD850C4E76AD14E, _id_A82BED82FD7FCB04] = [[level.br_circle._id_BF394857229861A5]](circleindex + 1);

      if(isDefined(_id_5BD850C4E76AD14E))
        _id_9BEDD0ECB39838D6 = max(_id_5BD850C4E76AD14E, _id_9BEDD0ECB39838D6);

      if(isDefined(_id_A82BED82FD7FCB04))
        _id_D6BAC3BF0F64D280 = min(_id_A82BED82FD7FCB04, _id_D6BAC3BF0F64D280);
    }

    _id_B1D0BC03029F6A2C = _id_9BEDD0ECB39838D6 + randomfloat(_id_D6BAC3BF0F64D280 - _id_9BEDD0ECB39838D6);
    _id_C2D7D58BFAD1B1EE = level.br_level.br_circleclosetimes[circleindex];
    prevradius = level.br_level.br_circleradii[circleindex + 1];
    _id_6041996E5CA4B1F3 = radius - prevradius;
    _id_C9F9B6297AB4434A = _id_6041996E5CA4B1F3 / _id_C2D7D58BFAD1B1EE;
    _id_599CA8AAC66AED6F = max(0, _id_7A50883C31353C77 - _id_C9F9B6297AB4434A);
    _id_797B88A97BEDC494 = _id_599CA8AAC66AED6F * _id_C2D7D58BFAD1B1EE;
    _id_6443D240572E7A5B = _id_797B88A97BEDC494 / radius;
    _id_3F139F4756AD700E = _id_B1D0BC03029F6A2C > _id_6443D240572E7A5B;

    if(_id_3F139F4756AD700E && !istrue(_id_B7C9FE00120EA96C)) {
      _id_9ED6827753DB2370 = _id_C9F9B6297AB4434A + _id_B1D0BC03029F6A2C * radius / _id_C2D7D58BFAD1B1EE;
      dlog_recordevent("dlog_event_br_circle_speed_warning", ["player_speed", _id_7A50883C31353C77, "circle_speed", _id_9ED6827753DB2370, "circle_close_time", float(_id_C2D7D58BFAD1B1EE), "circle_current_radius", float(radius), "circle_next_radius", float(prevradius)]);
    }

    if(circleindex) {
      if(_id_11C1E6222DA58849 && _id_3F139F4756AD700E)
        _id_B1D0BC03029F6A2C = _id_9BEDD0ECB39838D6 + randomfloat(_id_6443D240572E7A5B - _id_9BEDD0ECB39838D6);

      level.br_level.br_circlecenters[circleindex] = getrandompointinboundscircle(origin, radius, _id_B1D0BC03029F6A2C, _id_B1D0BC03029F6A2C, 1, _id_38A4C729748AD94C, 1);
      continue;
    }
  }

  for(circleindex = _id_2082F17F2E1C69BF + 1; circleindex < _id_2082F17F2E1C69BF + 1 + level.br_level.br_movingcirclecount; circleindex++) {
    _id_9D2610F6A0B725A4 = level.br_level.br_circleradii[circleindex - 1];
    _id_A754CFA0FF072630 = level.br_level.br_circlecenters[circleindex - 1];
    _id_2E8E1BBFFD8BC082 = level.br_level.br_circleradii[circleindex];
    _id_636C8575D7A7768B = _id_9D2610F6A0B725A4 + _id_2E8E1BBFFD8BC082 + level.br_level.br_movingcirclemovedistmin;
    maxdist = _id_9D2610F6A0B725A4 + _id_2E8E1BBFFD8BC082 + level.br_level.br_movingcirclemovedistmax;
    level.br_level.br_circlecenters[circleindex] = getrandompointinboundscircle(_id_A754CFA0FF072630, maxdist, _id_636C8575D7A7768B / maxdist, 1.0, 1, _id_38A4C729748AD94C, 1);
  }

  level notify("calc_circle_centers");
}

_id_3011D71052D72D2A() {
  _id_2E156443240A8E4B = [];
  _id_D4B9E030F49735D5 = 0.0;
  _id_84C71FBAEDE8B93D = getdvarint("dvar_29097E089CD5654F", 0);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_84C71FBAEDE8B93D; _id_AC0E594AC96AA3A8++) {
    pos = getdvarvector(_func_2EF675C13CA1C4AF("dvar_97BFC9BB98165CC0", _id_AC0E594AC96AA3A8));
    _id_7E682884C9AE9926 = spawnStruct();
    _id_7E682884C9AE9926.pos = pos;
    _id_7E682884C9AE9926.radius = getdvarfloat(_func_2EF675C13CA1C4AF("dvar_7EE50D7EB0AE1F7B", _id_AC0E594AC96AA3A8), 0.0);
    weight = getdvarfloat(_func_2EF675C13CA1C4AF("dvar_2BD6E0674BF7C8ED", _id_AC0E594AC96AA3A8), 1.0);

    if(weight > 0.0) {
      _id_D4B9E030F49735D5 = _id_D4B9E030F49735D5 + weight;
      _id_7E682884C9AE9926.weight = _id_D4B9E030F49735D5;
      _id_2E156443240A8E4B[_id_2E156443240A8E4B.size] = _id_7E682884C9AE9926;
    }
  }

  if(!_id_2E156443240A8E4B.size)
    return [undefined, undefined];

  _id_901F7F6175B781F0 = undefined;
  _id_384446A35F40358C = getdvarint("dvar_2CC91C52F62A55E0", -1);

  if(_id_384446A35F40358C >= 0) {
    if(_id_384446A35F40358C < _id_2E156443240A8E4B.size)
      _id_901F7F6175B781F0 = _id_2E156443240A8E4B[_id_384446A35F40358C];
  } else {
    _id_00AE14C5A8B1B582 = randomfloatrange(0.0, _id_D4B9E030F49735D5);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2E156443240A8E4B.size; _id_AC0E594AC96AA3A8++) {
      if(_id_00AE14C5A8B1B582 < _id_2E156443240A8E4B[_id_AC0E594AC96AA3A8].weight) {
        _id_901F7F6175B781F0 = _id_2E156443240A8E4B[_id_AC0E594AC96AA3A8];
        break;
      }
    }
  }

  if(!isDefined(_id_901F7F6175B781F0))
    return [undefined, undefined];

  if(_id_901F7F6175B781F0.radius > 0) {
    _id_59AF6E9BFE7CF735 = getrandompointinboundscircle(_id_901F7F6175B781F0.pos, _id_901F7F6175B781F0.radius, 0.0, 1.0, 1, 1, 1);
    return [_id_59AF6E9BFE7CF735, _id_901F7F6175B781F0.pos];
  } else
    return [_id_901F7F6175B781F0.pos, _id_901F7F6175B781F0.pos];
}

runcircles(_id_7B6D5DB8CB3C5782) {
  level endon("game_ended");
  level endon("br_ending_start");

  if(isDefined(level._id_80C1E8E18146024F))
    [[level._id_80C1E8E18146024F]](_id_7B6D5DB8CB3C5782);
  else
    _id_3F9DC64647891E08(_id_7B6D5DB8CB3C5782);
}

_id_3F9DC64647891E08(_id_7B6D5DB8CB3C5782) {
  level.br_circle.safecircleent = spawn("script_model", (level.br_level.br_circlecenters[1][0], level.br_level.br_circlecenters[1][1], level.br_level.br_circleradii[1]));
  level.br_circle.safecircleent.hidden = 0;
  level.br_circle.safecircleui = spawn("script_model", level.br_circle.safecircleent.origin);
  level.br_circle.safecircleui.hidden = 0;
  level.br_circle.dangercircleent = spawnbrcircle(level.br_level.br_circlecenters[0][0], level.br_level.br_circlecenters[0][1], level.br_level.br_circleradii[0]);
  level.br_circle.dangercircleent.hidden = 0;
  level.br_circle.dangercircleent thread dangercircleenthidefromplayers();
  level.br_circle.dangercircleui = spawn("script_model", level.br_circle.dangercircleent.origin);
  level.br_circle.dangercircleui.hidden = 0;
  hidedangercircle();
  _id_2F4FB0777EBB4CC0();
  setpreviewuicircle(level.br_circle.safecircleent);

  if(istrue(_id_7B6D5DB8CB3C5782) && !_id_362C58E8BB39BCDA::isfeatureenabled("circleEarlyStart") && !istrue(level.br_prematchstarted))
    level waittill("infils_ready");

  if(istrue(level.usegulag))
    _id_67708F418B1FAC79::setupgulagtimer();

  showdangercircle();
  level.br_circle thread circledamagetick();
  level thread stopcirclesatgameend();
  level.br_circle._id_5B8569581E64D55A = gettime();

  if(isDefined(level.br_level.br_circledelaytimes)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.br_level.br_circledelaytimes.size; _id_AC0E594AC96AA3A8++)
      circletimer(_id_AC0E594AC96AA3A8);
  }

  if(isDefined(level._id_20F62868A14AB570)) {
    foreach(callback in level._id_20F62868A14AB570)[[callback]]();
  }
}

stopcirclesatgameend() {
  level notify("stopCirclesAtGameEnd");
  level endon("stopCirclesAtGameEnd");
  level scripts\engine\utility::waittill_any_two("game_ended", "br_ending_start");

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    setomnvar("ui_hardpoint_timer", 0);
}

getcircleindexforpoint(point) {
  if(!isDefined(level.br_circle))
    return -1;

  circleindex = -1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.br_level.br_circlecenters.size - level.br_level.br_movingcirclecount; _id_AC0E594AC96AA3A8++) {
    center = level.br_level.br_circlecenters[_id_AC0E594AC96AA3A8];
    radius = level.br_level.br_circleradii[_id_AC0E594AC96AA3A8];
    dist = distance2d(point, center);

    if(dist >= radius) {
      break;
    }

    circleindex = _id_AC0E594AC96AA3A8;
  }

  return circleindex;
}

getmintimetillpointindangercircle(point) {
  if(istrue(level.br_circle_disabled))
    return 99999;

  if(!isDefined(level.br_circle))
    return -1;

  if(istrue(level.br_level.staticcircle))
    return -1;

  _id_CF876CD1A06753F5 = 0.0;

  if(level.br_circle.circleindex >= 0) {
    circleindex = level.br_circle.circleindex;
    _id_E39D8E5A89E12A3E = level.br_circle.starttime;
    _id_069FB8ED6A22E7FC = level.br_circle.dangercircleent.origin[2];
    _id_8ACE8BF028CAA1D8 = level.br_circle.dangercircleent.origin;

    if(circleindex >= level.br_level.br_circlecenters.size - level.br_level.br_movingcirclecount)
      circleindex = level.br_level.br_circlecenters.size - 1;
  } else {
    circleindex = 0;
    _id_E39D8E5A89E12A3E = gettime();
    _id_069FB8ED6A22E7FC = level.br_level.br_circleradii[0];
    _id_8ACE8BF028CAA1D8 = level.br_level.br_circlecenters[0];
  }

  pointindex = getcircleindexforpoint(point);

  if(pointindex < 0)
    return _id_CF876CD1A06753F5;
  else if(pointindex < circleindex)
    return _id_CF876CD1A06753F5;
  else if(pointindex == circleindex) {
    if(distance2d(_id_8ACE8BF028CAA1D8, point) > _id_069FB8ED6A22E7FC)
      return _id_CF876CD1A06753F5;
  }

  for(_id_AC0E594AC96AA3A8 = circleindex + 1; _id_AC0E594AC96AA3A8 < pointindex; _id_AC0E594AC96AA3A8++) {
    _id_CF876CD1A06753F5 = _id_CF876CD1A06753F5 + level.br_level.br_circleclosetimes[_id_AC0E594AC96AA3A8];
    _id_CF876CD1A06753F5 = _id_CF876CD1A06753F5 + level.br_level.br_circledelaytimes[_id_AC0E594AC96AA3A8];
  }

  _id_74B5B12BB6514385 = level.br_level.br_circledelaytimes[circleindex];
  _id_C2D7D58BFAD1B1EE = level.br_level.br_circleclosetimes[circleindex];
  _id_3B5803E733581858 = (gettime() - _id_E39D8E5A89E12A3E) / 1000;

  if(pointindex > circleindex) {
    if(scripts\mp\utility\game::getsubgametype() == "champion" && pointindex == level.br_level.br_circlecenters.size - 1)
      return -1;

    totaltime = _id_74B5B12BB6514385 + _id_C2D7D58BFAD1B1EE;
    _id_CF876CD1A06753F5 = _id_CF876CD1A06753F5 + (totaltime - _id_3B5803E733581858);
    _id_CF876CD1A06753F5 = _id_CF876CD1A06753F5 + level.br_level.br_circledelaytimes[pointindex];
    timeremaining = level.br_level.br_circleclosetimes[pointindex];
    startorigin = level.br_level.br_circlecenters[pointindex];
    endorigin = level.br_level.br_circlecenters[pointindex + 1];
    _id_ACC4F45C61ED5FF1 = level.br_level.br_circleradii[pointindex];
    _id_15B8FF04C24C09F4 = level.br_level.br_circleradii[pointindex + 1];
  } else {
    if(_id_3B5803E733581858 < _id_74B5B12BB6514385) {
      _id_CF876CD1A06753F5 = _id_CF876CD1A06753F5 + (_id_74B5B12BB6514385 - _id_3B5803E733581858);
      timeremaining = _id_C2D7D58BFAD1B1EE;
    } else
      timeremaining = _id_C2D7D58BFAD1B1EE - (_id_3B5803E733581858 - _id_74B5B12BB6514385);

    startorigin = _id_8ACE8BF028CAA1D8;
    endorigin = level.br_level.br_circlecenters[circleindex + 1];
    _id_ACC4F45C61ED5FF1 = _id_069FB8ED6A22E7FC;
    _id_15B8FF04C24C09F4 = level.br_level.br_circleradii[circleindex + 1];
  }

  _id_ACC4F45C61ED5FF1 = float(_id_ACC4F45C61ED5FF1);
  _id_15B8FF04C24C09F4 = float(_id_15B8FF04C24C09F4);
  a = point[0];
  _id_CE0F2A78F55FEFB9 = a * a;
  b = startorigin[0];
  _id_CE1C3A78F56E276E = b * b;
  c = (endorigin[0] - startorigin[0]) / timeremaining;
  _id_CE173278F567ECFF = c * c;
  _id_AC0E564AC96A9D0F = point[1];
  _id_CE254278F57857B4 = _id_AC0E564AC96A9D0F * _id_AC0E564AC96A9D0F;
  e = startorigin[1];
  _id_CE204278F5722EDD = e * e;
  f = (endorigin[1] - startorigin[1]) / timeremaining;
  _id_CE2D3278F5802032 = f * f;
  g = _id_ACC4F45C61ED5FF1;
  gs = g * g;
  h = (_id_15B8FF04C24C09F4 - _id_ACC4F45C61ED5FF1) / timeremaining;
  _id_CE363A78F58A5078 = h * h;
  p1 = sqrt(pow(2 * a * c - 2 * b * c + 2 * _id_AC0E564AC96A9D0F * f - 2 * e * f + 2 * g * h, 2) - 4 * (-1 * _id_CE173278F567ECFF - _id_CE2D3278F5802032 + _id_CE363A78F58A5078) * (-1 * _id_CE0F2A78F55FEFB9 + 2 * a * b - _id_CE1C3A78F56E276E - _id_CE254278F57857B4 + 2 * _id_AC0E564AC96A9D0F * e - _id_CE204278F5722EDD + gs));
  p2 = -2 * a * c + 2 * b * c - 2 * _id_AC0E564AC96A9D0F * f + 2 * e * f - 2 * g * h;
  p3 = 2 * (-1 * _id_CE173278F567ECFF - _id_CE2D3278F5802032 + _id_CE363A78F58A5078);

  if(p3 == 0.0)
    return _id_CF876CD1A06753F5;

  _id_6512AD0441B0016D = (-1 * p1 + p2) / p3;
  pos = (p1 + p2) / p3;

  if(_id_6512AD0441B0016D < 0)
    time = pos;
  else if(pos < 0)
    time = _id_6512AD0441B0016D;
  else
    time = min(_id_6512AD0441B0016D, pos);

  _id_CF876CD1A06753F5 = _id_CF876CD1A06753F5 + time;
  return _id_CF876CD1A06753F5;
}

hidedangercircle() {
  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleui)) {
    return;
  }
  level.br_circle.dangercircleui.hidden++;
  level.br_circle.dangercircleent.hidden++;
  level notify("update_circle_hide");
}

hidesafecircle() {
  level.br_circle.safecircleui.hidden++;
  level.br_circle.safecircleent.hidden++;
  level notify("update_circle_hide");
}

showdangercircle() {
  _id_A899490687F828C6 = level.br_circle.dangercircleent.hidden || level.br_circle.dangercircleent.hidden;
  level.br_circle.dangercircleui.hidden--;
  level.br_circle.dangercircleent.hidden--;
  ishidden = level.br_circle.dangercircleui.hidden || level.br_circle.dangercircleent.hidden;

  if(_id_A899490687F828C6 && !ishidden)
    level notify("update_circle_hide");
}

showsafecircle() {
  _id_A899490687F828C6 = level.br_circle.safecircleui.hidden || level.br_circle.safecircleent.hidden;
  level.br_circle.safecircleui.hidden--;
  level.br_circle.safecircleent.hidden--;
  ishidden = level.br_circle.safecircleui.hidden || level.br_circle.safecircleent.hidden;

  if(_id_A899490687F828C6 && !ishidden)
    level notify("update_circle_hide");
}

circletimer(circleindex) {
  level endon("game_ended");
  level endon("br_ending_start");

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    scripts\cp_mp\challenges::_id_9266A0EE3CFB3A75();

  if(istrue(_id_362C58E8BB39BCDA::runbrgametypefunc("circleTimer", circleindex))) {
    return;
  }
  level.br_circle.starttime = gettime();
  level.br_circle.circleindex = circleindex;
  _id_F007CE073DC3C519 = circleindex == 0;
  _id_6B890E6BE7982EFB = circleindex == level.br_level.br_circleclosetimes.size - 1;
  _id_C3D4CAA5CB4132E6 = level.br_level.br_circledelaytimes[circleindex];
  _id_C2D7D58BFAD1B1EE = level.br_level.br_circleclosetimes[circleindex];
  _id_154EF61B7A7F747A = level.br_level.br_circleradii[circleindex + 1];

  if(_id_FC0F865DDCF551AD())
    setomnvar("ui_br_circle_num", circleindex);
  else
    setomnvar("ui_br_circle_num", circleindex + 1);

  thread _id_67708F418B1FAC79::circletimer(circleindex);
  _id_362C58E8BB39BCDA::runbrgametypefunc("circleTimerNext", circleindex);
  level thread br_lerp_minimap_zoom(circleindex);
  _id_5A6E343A8574AF81 = level.br_level.br_circlecenters[circleindex + 1];
  level.br_circle.centertarget = _id_5A6E343A8574AF81;
  level.br_circle.safecircleent.origin = (level.br_circle.centertarget[0], level.br_circle.centertarget[1], _id_154EF61B7A7F747A);
  level.respawnclosets = gathervalidspawnclosets(_id_5A6E343A8574AF81, _id_154EF61B7A7F747A);
  cleanupoutercrates();
  gatheroutercrates(_id_5A6E343A8574AF81, _id_154EF61B7A7F747A);
  _id_A9ED63230D9A3C95 = level.br_level.br_circleshowdelaydanger[circleindex];

  if(_id_A9ED63230D9A3C95 > 0) {
    hidedangercircle();
    scripts\engine\utility::delaythread(_id_A9ED63230D9A3C95, ::showdangercircle);
  }

  _id_4F48A6344EC8A9C7 = level.br_level.br_circleshowdelaysafe[circleindex];

  if(_id_4F48A6344EC8A9C7 > 0) {
    hidesafecircle();
    scripts\engine\utility::delaythread(_id_4F48A6344EC8A9C7, ::showsafecircle);
  }

  level thread startuiclosetimer(_id_C3D4CAA5CB4132E6, _id_F007CE073DC3C519, _id_6B890E6BE7982EFB, circleindex);
  level.br_circle.safecircleui.origin = level.br_circle.safecircleent.origin;
  level.br_circle.dangercircleui.origin = getdangercircleorigin() + (0, 0, getdangercircleradius());
  setstaticuicircles(_id_C3D4CAA5CB4132E6, level.br_circle.safecircleui, level.br_circle.dangercircleui, _id_6B890E6BE7982EFB);

  if(canplaycircleopendialog(circleindex)) {
    if(_id_F007CE073DC3C519)
      _id_2CEDCC356F1B9FC8::brleaderdialog("first_circle", 1);
    else
      _id_2CEDCC356F1B9FC8::brleaderdialog("new_circle", 1);
  }

  if(istrue(level.usegulag))
    level thread _id_67708F418B1FAC79::transitioncircle(_id_154EF61B7A7F747A, _id_C3D4CAA5CB4132E6);

  level notify("br_circle_set");
  wait(_id_C3D4CAA5CB4132E6);
  _id_2F4FB0777EBB4CC0();
  level notify("br_circle_started");
  level.circleclosing = 1;

  if(!isDefined(level._id_E486ACB8F70C45A2))
    setomnvar("ui_hardpoint_timer", gettime() + int(_id_C2D7D58BFAD1B1EE * 1000));

  if(canplaycircleclosedialog(circleindex)) {
    if(_id_6B890E6BE7982EFB)
      _id_2CEDCC356F1B9FC8::brleaderdialog("final_circle", 1);
    else {
      _id_2CEDCC356F1B9FC8::brleaderdialog("circle_closing", 1);
      thread brcirclebattlechatter(circleindex);
    }
  }

  level.br_circle.safecircleui.origin = level.br_circle.safecircleent.origin;
  level.br_circle.dangercircleui.origin = getdangercircleorigin() + (0, 0, getdangercircleradius());
  setclosinguicircle(int(_id_C2D7D58BFAD1B1EE), level.br_circle.safecircleent, level.br_circle.dangercircleui, _id_6B890E6BE7982EFB);
  level.br_circle.dangercircleent brcirclemoveTo(level.br_circle.centertarget[0], level.br_circle.centertarget[1], _id_154EF61B7A7F747A, _id_C2D7D58BFAD1B1EE);
  _id_E499790B0786EB88 = !istrue(level.br_circle._id_0A0D948A339EEE04) && !(isDefined(level.isstandardsandbox) && !level.isstandardsandbox);

  if(_id_E499790B0786EB88)
    level thread scripts\mp\music_and_dialog::_id_A486DF26072A530A(level.br_circle.circleindex, level.br_level.br_circleclosetimes.size, 0.4);

  wait(_id_C2D7D58BFAD1B1EE);
  _id_2F4FB0777EBB4CC0();

  if(resetdangercircleorigin(circleindex)) {
    if(getdvarint("dvar_E0A1364A76DD764E", 1))
      level.br_circle.dangercircleent.origin = (level.br_circle.centertarget[0], level.br_circle.centertarget[1], _id_154EF61B7A7F747A);
  }

  _id_362C58E8BB39BCDA::runbrgametypefunc("onCloseCircleCompleted", _id_6B890E6BE7982EFB);
  _id_F2DA81FB842E7A5E = 5;

  if(_id_F2DA81FB842E7A5E > 0 && circleindex < _id_F2DA81FB842E7A5E) {
    scripts\mp\rank::addglobalrankxpmultiplier(1.2, "cirlceMult_" + scripts\engine\utility::string(circleindex));
    scripts\mp\weaponrank::addweaponrankxpmultiplier(1.2, "cirlceMult_" + scripts\engine\utility::string(circleindex));
  }

  level notify("br_circle_closed");
  level.circleclosing = 0;

  if(isDefined(_id_5A6E343A8574AF81) && isDefined(_id_154EF61B7A7F747A))
    cleanupouterspawnclosets(_id_5A6E343A8574AF81, _id_154EF61B7A7F747A);
}

_id_AB678F36F465FDEB() {
  return getdvarint("dvar_047D8674C992E098", 0) > 0;
}

_id_4BFF90E55E5E18E4() {
  return istrue(_id_AB678F36F465FDEB()) && getdvarint("dvar_192990FC79B06600", 0) > 0;
}

_id_E32A50F37301A6AB() {
  if(isDefined(level.br_circle) && isDefined(level.br_circle._id_EC45F849CE9A05CF))
    return level.br_circle._id_EC45F849CE9A05CF;

  return 0;
}

_id_64AEDA8C8A4179C5(value) {
  if(!istrue(_id_AB678F36F465FDEB()) || !isDefined(level.br_circle) || isDefined(level.br_circle._id_EC45F849CE9A05CF) && level.br_circle._id_EC45F849CE9A05CF == value) {
    return;
  }
  level.br_circle._id_EC45F849CE9A05CF = value;

  if(istrue(level.br_circle._id_EC45F849CE9A05CF))
    level.br_circle notify("circle_paused");
  else
    level.br_circle notify("circle_unpaused");
}

_id_2F4FB0777EBB4CC0() {
  if(istrue(_id_AB678F36F465FDEB()) && istrue(_id_E32A50F37301A6AB()))
    level.br_circle waittill("circle_unpaused");
}

br_lerp_minimap_zoom(circleindex) {
  level endon("game_ended");

  if(circleindex > 0) {
    _id_6D5B4E7465608DF0 = circleindex - 1;
    _id_48D779F8598F6791 = level.br_level.br_circleminimapradii[circleindex];
    _id_D4659DE197D07387 = level.br_level.br_circleminimapradii[_id_6D5B4E7465608DF0];

    if(_id_48D779F8598F6791 == _id_D4659DE197D07387) {
      return;
    }
    _id_D533F7D3FB526D13 = 0.05;
    _id_661A636DBC7D54B5 = 2;
    _id_7F479BCE3ABF8B1B = _id_661A636DBC7D54B5 / _id_D533F7D3FB526D13;
    _id_777913B6F66C8417 = int((_id_D4659DE197D07387 - _id_48D779F8598F6791) / _id_7F479BCE3ABF8B1B);
    _id_D1F50321D77C76DC = level.br_level.br_circleminimapradii[_id_6D5B4E7465608DF0];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_7F479BCE3ABF8B1B; _id_AC0E594AC96AA3A8++) {
      _id_D1F50321D77C76DC = _id_D1F50321D77C76DC - _id_777913B6F66C8417;
      setomnvar("ui_br_minimap_radius", _id_D1F50321D77C76DC);
      wait(_id_D533F7D3FB526D13);
    }

    setomnvar("ui_br_minimap_radius", level.br_level.br_circleminimapradii[circleindex]);
  } else
    setomnvar("ui_br_minimap_radius", level.br_level.br_circleminimapradii[circleindex]);
}

cleanupouterspawnclosets(center, _id_F434D604C09196AA) {
  _id_76C9A6FB0EC8375A = _id_F434D604C09196AA * _id_F434D604C09196AA;

  if(isDefined(level.revivetriggers)) {
    foreach(guid, _id_E751C7771E6A1E5C in level.revivetriggers) {
      if(isDefined(_id_E751C7771E6A1E5C) && distance2dsquared(center, _id_E751C7771E6A1E5C.trigger.origin) > _id_76C9A6FB0EC8375A) {
        _id_97B398030664C65A = gathervalidspawnclosets(_id_E751C7771E6A1E5C.trigger.origin, _id_F434D604C09196AA);

        if(isDefined(_id_97B398030664C65A) && _id_97B398030664C65A.size > 0)
          _id_E751C7771E6A1E5C.victim scripts\mp\teamrevive::relocatetrigger(_id_97B398030664C65A[0].origin);
        else
          _id_E751C7771E6A1E5C.victim scripts\mp\teamrevive::removetrigger(guid);
      }
    }
  }
}

gathervalidspawnclosets(center, _id_77E882DA07E78CFE) {
  if(isDefined(level.respawnclosets)) {
    respawnclosets = scripts\engine\utility::get_array_of_closest(center, level.respawnclosets, undefined, undefined, _id_77E882DA07E78CFE);
    return respawnclosets;
  }

  return undefined;
}

gatheroutercrates(center, _id_F434D604C09196AA) {
  _id_76C9A6FB0EC8375A = _id_F434D604C09196AA * _id_F434D604C09196AA;

  foreach(crate in level.br_pickups.crates) {
    if(isDefined(crate) && distance2dsquared(center, crate.origin) > _id_76C9A6FB0EC8375A)
      level.br_pickups.outercrates[level.br_pickups.outercrates.size] = crate;
  }
}

cleanupoutercrates() {
  foreach(crate in level.br_pickups.outercrates) {
    if(isDefined(crate) && crate.curprogress == 0)
      crate thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
  }

  level.br_pickups.outercrates = [];
}

array_init_fill(value, count) {
  array = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < count; _id_AC0E594AC96AA3A8++)
    array[array.size] = value;

  return array;
}

array_init_distribute(value, num, reverse, a, b, c) {
  results = [];

  if(!isDefined(a))
    a = 0.0;

  if(!isDefined(b))
    b = 0.5;

  if(!isDefined(c))
    c = 0.1;

  if(!isDefined(reverse))
    reverse = 0;

  _id_F74B2939EE4938D8 = a / 3 + b / 2 + c;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < num; _id_AC0E594AC96AA3A8++) {
    if(reverse)
      index = num - _id_AC0E594AC96AA3A8 - 1;
    else
      index = _id_AC0E594AC96AA3A8;

    _id_2E68460884B8A6C9 = (a * (6 * _id_AC0E594AC96AA3A8 * _id_AC0E594AC96AA3A8 + 6 * _id_AC0E594AC96AA3A8 + 2) + 3 * num * (2 * b * _id_AC0E594AC96AA3A8 + b + 2 * c * num)) / (6 * num * num * num);
    _id_6F2C137AD115BCD2 = _id_2E68460884B8A6C9 / _id_F74B2939EE4938D8;
    results[index] = _id_6F2C137AD115BCD2 * value;
  }

  return results;
}

extendcirclelist(circleradius, _id_04F81729168C0B8A, _id_35C9DCAF6DE45F41, _id_83536127FA3A72AA, _id_F32810DA2B97B928, _id_8E386906EAB86E36) {
  if(!isDefined(_id_F32810DA2B97B928))
    _id_F32810DA2B97B928 = 0;

  if(!isDefined(_id_8E386906EAB86E36))
    _id_8E386906EAB86E36 = 0;

  if(!isarray(circleradius))
    circleradius = [circleradius];

  if(!isarray(_id_04F81729168C0B8A))
    _id_04F81729168C0B8A = array_init_fill(_id_04F81729168C0B8A, circleradius.size);

  if(!isarray(_id_35C9DCAF6DE45F41))
    _id_35C9DCAF6DE45F41 = array_init_fill(_id_35C9DCAF6DE45F41, circleradius.size);

  if(!isarray(_id_83536127FA3A72AA))
    _id_83536127FA3A72AA = array_init_fill(_id_83536127FA3A72AA, circleradius.size);

  if(!isarray(_id_F32810DA2B97B928))
    _id_F32810DA2B97B928 = array_init_fill(_id_F32810DA2B97B928, circleradius.size);

  if(!isarray(_id_8E386906EAB86E36))
    _id_8E386906EAB86E36 = array_init_fill(_id_8E386906EAB86E36, circleradius.size);

  _id_31259E6BA118FF73 = level.br_level.br_circleradii[level.br_level.br_circleradii.size - 1];
  level.br_level.br_circleradii[level.br_level.br_circleradii.size - 1] = undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < circleradius.size; _id_AC0E594AC96AA3A8++) {
    _id_A61C75B156FC1EE0 = level.br_level.br_circleradii.size;
    level.br_level.br_circleradii[_id_A61C75B156FC1EE0] = circleradius[_id_AC0E594AC96AA3A8];
    _id_A61C75B156FC1EE0 = level.br_level.br_circleclosetimes.size;
    level.br_level.br_circleclosetimes[_id_A61C75B156FC1EE0] = _id_04F81729168C0B8A[_id_AC0E594AC96AA3A8];
    _id_A61C75B156FC1EE0 = level.br_level.br_circledelaytimes.size;
    level.br_level.br_circledelaytimes[_id_A61C75B156FC1EE0] = _id_35C9DCAF6DE45F41[_id_AC0E594AC96AA3A8];
    _id_A61C75B156FC1EE0 = level.br_level.br_circleminimapradii.size;
    level.br_level.br_circleminimapradii[_id_A61C75B156FC1EE0] = _id_83536127FA3A72AA[_id_AC0E594AC96AA3A8];
    _id_A61C75B156FC1EE0 = level.br_level.br_circleshowdelaydanger.size;
    level.br_level.br_circleshowdelaydanger[_id_A61C75B156FC1EE0] = _id_F32810DA2B97B928[_id_AC0E594AC96AA3A8];
    _id_A61C75B156FC1EE0 = level.br_level.br_circleshowdelaysafe.size;
    level.br_level.br_circleshowdelaysafe[_id_A61C75B156FC1EE0] = _id_8E386906EAB86E36[_id_AC0E594AC96AA3A8];
  }

  level.br_level.br_circleradii[level.br_level.br_circleradii.size] = _id_31259E6BA118FF73;
}

deletecircle(circleindex) {
  level.br_level.br_circleradii = scripts\engine\utility::array_remove_index(level.br_level.br_circleradii, circleindex);
  level.br_level.br_circleclosetimes = scripts\engine\utility::array_remove_index(level.br_level.br_circleclosetimes, circleindex);
  level.br_level.br_circledelaytimes = scripts\engine\utility::array_remove_index(level.br_level.br_circledelaytimes, circleindex);
  level.br_level.br_circleminimapradii = scripts\engine\utility::array_remove_index(level.br_level.br_circleminimapradii, circleindex);
  level.br_level.br_circleshowdelaydanger = scripts\engine\utility::array_remove_index(level.br_level.br_circleshowdelaydanger, circleindex);
  level.br_level.br_circleshowdelaysafe = scripts\engine\utility::array_remove_index(level.br_level.br_circleshowdelaysafe, circleindex);
}

applymovingcircles() {
  if(!getdvarint("scr_br_moving_circle_enabled", 1) || _id_362C58E8BB39BCDA::isfeaturedisabled("movingCircle")) {
    level.br_level.br_movingcirclecount = 0;
    return;
  }

  level.br_level.br_movingcirclecount = getdvarint("scr_br_moving_circle_count", 0);
  level.br_level.br_movingcirclemovedistmin = getdvarfloat("scr_br_moving_circle_move_dist_min", 100);
  level.br_level.br_movingcirclemovedistmax = getdvarfloat("scr_br_moving_circle_move_dist_max", 300);
  _id_9A7CC3CF1CC979D2 = getdvarint("scr_br_moving_circle_preset", 0);
  _id_209967C144016964 = level.br_level.br_circleradii.size - 1;

  switch (_id_9A7CC3CF1CC979D2) {
    case 1:
      if(!level.br_level.br_movingcirclecount)
        level.br_level.br_movingcirclecount = 4;

      _id_15B8FF04C24C09F4 = level.br_level.br_circleradii[_id_209967C144016964];
      _id_31259E6BA118FF73 = level.br_level.br_circleradii[_id_209967C144016964 - 1];
      _id_441E40C8389D209A = level.br_level.br_circleclosetimes[_id_209967C144016964 - 1];
      _id_2B5A25974FAD05D1 = level.br_level.br_circledelaytimes[_id_209967C144016964 - 1];
      _id_D750AECED79DFB3A = level.br_level.br_circleminimapradii[_id_209967C144016964 - 1];
      deletecircle(_id_209967C144016964 - 1);
      _id_F59AB661BA766221 = level.br_level.br_movingcirclecount;
      _id_B7AB27868F552BC2 = getdvarvector("dvar_4CD7066D8EA6D39D", (0, 1, 0));
      circleradius = [];
      _id_C34091CF26E77F50 = array_init_distribute(_id_31259E6BA118FF73 - _id_15B8FF04C24C09F4, _id_F59AB661BA766221 + 1, 1, _id_B7AB27868F552BC2[0], _id_B7AB27868F552BC2[1], _id_B7AB27868F552BC2[2]);
      _id_3777ECE6A73EADA5 = 0;

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F59AB661BA766221; _id_AC0E594AC96AA3A8++) {
        _id_3777ECE6A73EADA5 = _id_3777ECE6A73EADA5 + _id_C34091CF26E77F50[_id_AC0E594AC96AA3A8];
        circleradius[_id_AC0E594AC96AA3A8] = _id_31259E6BA118FF73 - _id_3777ECE6A73EADA5;
      }

      _id_B7AB27868F552BC2 = getdvarvector("dvar_B6771B3F9E9FDD90", (0, 1, 0.125));
      _id_4A963B7CF80E3BE1 = getdvarfloat("dvar_52F861C9D86FC540", 1.0);
      _id_1415F8A99839C7D4 = getdvarfloat("dvar_FE0DAE92131847F9", 0.5);
      _id_7588325A3F6A6120 = (_id_441E40C8389D209A + _id_441E40C8389D209A) * _id_4A963B7CF80E3BE1;
      _id_04F81729168C0B8A = array_init_distribute(_id_7588325A3F6A6120 * _id_1415F8A99839C7D4, _id_F59AB661BA766221, 1, _id_B7AB27868F552BC2[0], _id_B7AB27868F552BC2[1], _id_B7AB27868F552BC2[2]);
      _id_35C9DCAF6DE45F41 = array_init_distribute(_id_7588325A3F6A6120 * (1.0 - _id_1415F8A99839C7D4), _id_F59AB661BA766221, 1, _id_B7AB27868F552BC2[0], _id_B7AB27868F552BC2[1], _id_B7AB27868F552BC2[2]);
      extendcirclelist(circleradius, _id_04F81729168C0B8A, _id_35C9DCAF6DE45F41, _id_D750AECED79DFB3A);
      break;
    case 2:
      deletecircle(_id_209967C144016964 - 1);
      level.br_level.br_movingcirclecount = 4;
      circleradius = [1200, 900, 600, 300];
      _id_04F81729168C0B8A = [30, 30, 30, 30];
      _id_74B5B12BB6514385 = [30, 20, 10, 0];
      _id_1AFD23E03D011EC6 = [5500, 5000, 4500, 4000];
      extendcirclelist(circleradius, _id_04F81729168C0B8A, _id_74B5B12BB6514385, _id_1AFD23E03D011EC6);
      break;
    case 3:
      level.br_level.br_movingcirclecount = 5;
      circleradius = [1200, 900, 600, 300];
      _id_04F81729168C0B8A = [30, 30, 30, 30];
      _id_74B5B12BB6514385 = [30, 20, 10, 0];
      _id_1AFD23E03D011EC6 = [5500, 5000, 4500, 4000];
      extendcirclelist(circleradius, _id_04F81729168C0B8A, _id_74B5B12BB6514385, _id_1AFD23E03D011EC6);
      break;
    case 4:
      deletecircle(_id_209967C144016964 - 1);
      level.br_level.br_movingcirclecount = 4;
      _id_2F36016C369A806F = 1500;
      _id_2F36026C369A82A2 = 750 + randomint(301);
      _id_2F36036C369A84D5 = 1000 + randomint(301);
      circleradius = [_id_2F36016C369A806F, _id_2F36016C369A806F, _id_2F36026C369A82A2, _id_2F36036C369A84D5];
      _id_04F81729168C0B8A = [30, 30, 30, 45];
      _id_74B5B12BB6514385 = [10, 5, 5, 0];
      _id_1AFD23E03D011EC6 = [5500, 5500, 5500, 5500];
      extendcirclelist(circleradius, _id_04F81729168C0B8A, _id_74B5B12BB6514385, _id_1AFD23E03D011EC6);
      break;
    case 5:
      deletecircle(_id_209967C144016964 - 1);
      level.br_level.br_movingcirclecount = 4;
      circleradius = [1500, 1500, 1000, 600];
      _id_04F81729168C0B8A = [30, 30, 20, 20];
      _id_74B5B12BB6514385 = [30, 30, 20, 20];
      _id_1AFD23E03D011EC6 = [4000, 3000, 2000, 1000];
      extendcirclelist(circleradius, _id_04F81729168C0B8A, _id_74B5B12BB6514385, _id_1AFD23E03D011EC6);
      break;
    case 6:
      deletecircle(_id_209967C144016964 - 1);
      level.br_level.br_movingcirclecount = 4;
      _id_2F36016C369A806F = 1500;
      _id_2F36026C369A82A2 = 750 + randomint(301);
      _id_2F36036C369A84D5 = 1000 + randomint(301);
      circleradius = [_id_2F36016C369A806F, _id_2F36016C369A806F, _id_2F36026C369A82A2, _id_2F36036C369A84D5];
      _id_04F81729168C0B8A = [30, 30, 30, 45];
      _id_74B5B12BB6514385 = [10, 5, 5, 0];
      _id_1AFD23E03D011EC6 = [5500, 5500, 5500, 5500];
      extendcirclelist(circleradius, _id_04F81729168C0B8A, _id_74B5B12BB6514385, _id_1AFD23E03D011EC6);
      break;
    case 7:
      deletecircle(_id_209967C144016964 - 1);
      level.br_level.br_movingcirclecount = 4;
      _id_2F36016C369A806F = 3500;
      _id_2F36026C369A82A2 = 1250 + randomint(501);
      _id_2F36036C369A84D5 = 750 + randomint(501);
      _id_2F35FC6C369A7570 = 750 + randomint(301);
      circleradius = [_id_2F36016C369A806F, _id_2F36026C369A82A2, _id_2F36036C369A84D5, _id_2F35FC6C369A7570];
      _id_04F81729168C0B8A = [40, 30, 25, 25];
      _id_74B5B12BB6514385 = [15, 10, 5, 0];
      _id_1AFD23E03D011EC6 = [5500, 5500, 5500, 5500];
      extendcirclelist(circleradius, _id_04F81729168C0B8A, _id_74B5B12BB6514385, _id_1AFD23E03D011EC6);
      break;
    case 8:
      deletecircle(_id_209967C144016964 - 1);
      level.br_level.br_movingcirclecount = 4;
      circleradius = [2000, 1500, 1000, 600];
      _id_04F81729168C0B8A = [30, 30, 20, 20];
      _id_74B5B12BB6514385 = [30, 30, 20, 20];
      _id_1AFD23E03D011EC6 = [4000, 3000, 2000, 1000];
      extendcirclelist(circleradius, _id_04F81729168C0B8A, _id_74B5B12BB6514385, _id_1AFD23E03D011EC6);
      break;
    case 9:
      deletecircle(_id_209967C144016964 - 1);
      level.br_level.br_movingcirclecount = 2;
      _id_2F36016C369A806F = 1000 + randomint(301);
      _id_2F36026C369A82A2 = 750 + randomint(301);
      circleradius = [_id_2F36016C369A806F, _id_2F36026C369A82A2];
      _id_04F81729168C0B8A = [30, 30];
      _id_74B5B12BB6514385 = [10, 5];
      _id_1AFD23E03D011EC6 = [5500, 5500];
      extendcirclelist(circleradius, _id_04F81729168C0B8A, _id_74B5B12BB6514385, _id_1AFD23E03D011EC6);
      break;
    case 10:
      deletecircle(_id_209967C144016964 - 1);
      level.br_level.br_movingcirclecount = 4;
      circleradius = [1500, 1400, 1200, 1000];
      _id_04F81729168C0B8A = [30, 30, 30, 45];
      _id_74B5B12BB6514385 = [15, 10, 5, 5];
      _id_1AFD23E03D011EC6 = [5000, 4500, 3500, 3000];
      extendcirclelist(circleradius, _id_04F81729168C0B8A, _id_74B5B12BB6514385, _id_1AFD23E03D011EC6);
      break;
    case 11:
      deletecircle(_id_209967C144016964 - 1);
      level.br_level.br_movingcirclecount = 2;
      circleradius = [1400, 800];
      _id_04F81729168C0B8A = [70, 60];
      _id_74B5B12BB6514385 = [20, 20];
      _id_1AFD23E03D011EC6 = [5000, 2500];
      extendcirclelist(circleradius, _id_04F81729168C0B8A, _id_74B5B12BB6514385, _id_1AFD23E03D011EC6);
      break;
    case 12:
      deletecircle(_id_209967C144016964 - 1);
      level.br_level.br_movingcirclecount = 3;
      circleradius = [1500, 1200, 1000];
      _id_04F81729168C0B8A = [45, 45, 45];
      _id_74B5B12BB6514385 = [10, 10, 10];
      _id_1AFD23E03D011EC6 = [5000, 4000, 2900];
      extendcirclelist(circleradius, _id_04F81729168C0B8A, _id_74B5B12BB6514385, _id_1AFD23E03D011EC6);
      break;
    case 0:
    default:
      break;
  }

  if(_id_9A7CC3CF1CC979D2) {
    _id_CDFBA54D71F1EE18 = level.br_level.br_circleradii.size - 1;
    level.br_level.br_movingcirclegulagcloseoffset = _id_CDFBA54D71F1EE18 - _id_209967C144016964;
  }
}

applycirclesetdvars() {
  _id_CE1C3B78F56E29A1 = level.br_level;
  _id_6756BD882736E8BC = _id_CE1C3B78F56E29A1.br_circleclosetimes.size;
  _id_1447086D5FC6E031 = _id_CE1C3B78F56E29A1.br_circleradii[_id_6756BD882736E8BC];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_6756BD882736E8BC + 1; _id_AC0E594AC96AA3A8++) {
    _id_8E7449EA7CAF775F = _func_2EF675C13CA1C4AF("scr_br_circle_set_", _id_AC0E594AC96AA3A8);
    _id_1641AFE84817865A = "scr_br_circle_set_" + _id_AC0E594AC96AA3A8;
    value = getDvar(_id_8E7449EA7CAF775F, "");

    if(value == "") {
      continue;
    }
    if(value == "delete") {
      for(_id_AC0E5C4AC96AAA41 = _id_AC0E594AC96AA3A8; _id_AC0E5C4AC96AAA41 < _id_6756BD882736E8BC; _id_AC0E5C4AC96AAA41++) {
        _id_CE1C3B78F56E29A1.br_circleradii[_id_AC0E5C4AC96AAA41] = undefined;
        _id_CE1C3B78F56E29A1.br_circleclosetimes[_id_AC0E5C4AC96AAA41] = undefined;
        _id_CE1C3B78F56E29A1.br_circledelaytimes[_id_AC0E5C4AC96AAA41] = undefined;
        _id_CE1C3B78F56E29A1.br_circleminimapradii[_id_AC0E5C4AC96AAA41] = undefined;
        _id_CE1C3B78F56E29A1.br_circleshowdelaydanger[_id_AC0E5C4AC96AAA41] = undefined;
        _id_CE1C3B78F56E29A1.br_circleshowdelaysafe[_id_AC0E5C4AC96AAA41] = undefined;
      }

      _id_CE1C3B78F56E29A1.br_circleradii[_id_AC0E594AC96AA3A8] = _id_1447086D5FC6E031;
      _id_CE1C3B78F56E29A1.br_circleradii[_id_AC0E5C4AC96AAA41] = undefined;
      break;
    }

    _id_6AF0A57B38E894BE = "?";
    _id_F077ADF688122C36 = strtok(value, ",");

    if(_id_AC0E594AC96AA3A8 >= _id_6756BD882736E8BC) {
      _id_30886FEFF7E7284C = 6;
      circlesettingsassert(_id_F077ADF688122C36.size == _id_30886FEFF7E7284C, "Dvar: " + _id_1641AFE84817865A + " has " + _id_F077ADF688122C36.size + " values, expected " + _id_30886FEFF7E7284C);

      if(_id_F077ADF688122C36.size != _id_30886FEFF7E7284C) {
        break;
      }

      _id_A15637A9566CDCB4 = 1;

      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_30886FEFF7E7284C; _id_AC0E5C4AC96AAA41++) {
        if(_id_F077ADF688122C36[_id_AC0E5C4AC96AAA41] == _id_6AF0A57B38E894BE) {
          _id_A15637A9566CDCB4 = 0;
          break;
        }
      }

      circlesettingsassert(_id_A15637A9566CDCB4, "Dvar: " + _id_1641AFE84817865A + " has requires all " + _id_30886FEFF7E7284C + " values set");

      if(!_id_A15637A9566CDCB4) {
        break;
      }
    }

    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_F077ADF688122C36.size; _id_AC0E5C4AC96AAA41++) {
      _id_E97377032A878881 = _id_F077ADF688122C36[_id_AC0E5C4AC96AAA41];

      if(_id_E97377032A878881 == _id_6AF0A57B38E894BE) {
        continue;
      }
      switch (_id_AC0E5C4AC96AAA41) {
        case 0:
          _id_CE1C3B78F56E29A1.br_circleradii[_id_AC0E594AC96AA3A8] = int(_id_E97377032A878881);
          break;
        case 1:
          _id_CE1C3B78F56E29A1.br_circleclosetimes[_id_AC0E594AC96AA3A8] = int(_id_E97377032A878881);
          break;
        case 2:
          _id_CE1C3B78F56E29A1.br_circledelaytimes[_id_AC0E594AC96AA3A8] = int(_id_E97377032A878881);
          break;
        case 3:
          _id_CE1C3B78F56E29A1.br_circleminimapradii[_id_AC0E594AC96AA3A8] = int(_id_E97377032A878881);
          break;
        case 4:
          _id_CE1C3B78F56E29A1.br_circleshowdelaydanger[_id_AC0E594AC96AA3A8] = int(_id_E97377032A878881);
          break;
        case 5:
          _id_CE1C3B78F56E29A1.br_circleshowdelaysafe[_id_AC0E594AC96AA3A8] = int(_id_E97377032A878881);
          break;
        default:
          break;
      }
    }

    if(_id_AC0E594AC96AA3A8 >= _id_6756BD882736E8BC) {
      _id_CE1C3B78F56E29A1.br_circleradii[_id_AC0E594AC96AA3A8 + 1] = _id_1447086D5FC6E031;
      _id_6756BD882736E8BC++;
    }
  }
}

_id_C96B267DC4F7E14A(_id_D42884B992023310, _id_E891C8F4915DFF8A) {
  level.br_level.br_circleclosetimes = [];
  level.br_level.br_circledelaytimes = [];
  level.br_level.br_circleshowdelaydanger = [];
  level.br_level.br_circleshowdelaysafe = [];
  level.br_level.br_circleminimapradii = [];
  level.br_level.br_circleradii = [];
  _id_573C0BDC9AB8A1F8 = getscriptbundle(_id_D42884B992023310);
  _id_F8E6895D28BFAA60 = _id_573C0BDC9AB8A1F8._id_D67B446A08631E4A;

  foreach(_id_DD2F6ED9DA93223F in _id_F8E6895D28BFAA60) {
    if(istrue(_id_E891C8F4915DFF8A))
      circle = _id_DD2F6ED9DA93223F._id_A57ABCE10CE0B9ED;
    else
      circle = _id_DD2F6ED9DA93223F._id_31E918C38B1E104F;

    level.br_level.br_circleclosetimes = scripts\engine\utility::array_add(level.br_level.br_circleclosetimes, scripts\engine\utility::_id_53C4C53197386572(circle._id_04F81729168C0B8A, 0));
    level.br_level.br_circledelaytimes = scripts\engine\utility::array_add(level.br_level.br_circledelaytimes, scripts\engine\utility::_id_53C4C53197386572(circle._id_35C9DCAF6DE45F41, 0));
    level.br_level.br_circleshowdelaydanger = scripts\engine\utility::array_add(level.br_level.br_circleshowdelaydanger, scripts\engine\utility::_id_53C4C53197386572(circle._id_F32810DA2B97B928, 0));
    level.br_level.br_circleshowdelaysafe = scripts\engine\utility::array_add(level.br_level.br_circleshowdelaysafe, scripts\engine\utility::_id_53C4C53197386572(circle._id_8E386906EAB86E36, 0));
    level.br_level.br_circleminimapradii = scripts\engine\utility::array_add(level.br_level.br_circleminimapradii, scripts\engine\utility::_id_53C4C53197386572(circle._id_5AF681D13C7745A9, 0));
    level.br_level.br_circleradii = scripts\engine\utility::array_add(level.br_level.br_circleradii, scripts\engine\utility::_id_53C4C53197386572(circle.circleradius, 0));
  }

  level.br_level.br_circleradii = scripts\engine\utility::array_add(level.br_level.br_circleradii, 0);
}

applycirclesettings() {
  _id_0C85D65F8D1F9413();
  applymovingcircles();
  applycirclesetdvars();
  timescale = getdvarfloat("dvar_11508C2017D016A5", 1.0);
  _id_CE1C3B78F56E29A1 = level.br_level;
  _id_CE1C3B78F56E29A1.br_circleclosetimes = _applydvarstosettings(_id_CE1C3B78F56E29A1.br_circleclosetimes, "close_time", timescale);
  _id_CE1C3B78F56E29A1.br_circledelaytimes = _applydvarstosettings(_id_CE1C3B78F56E29A1.br_circledelaytimes, "delay_time", timescale);
  _id_CE1C3B78F56E29A1.br_circleshowdelaydanger = _applydvarstosettings(_id_CE1C3B78F56E29A1.br_circleshowdelaydanger, "show_delay_danger", timescale);
  _id_CE1C3B78F56E29A1.br_circleshowdelaysafe = _applydvarstosettings(_id_CE1C3B78F56E29A1.br_circleshowdelaysafe, "show_delay_safe", timescale);

  if(!isDefined(_id_CE1C3B78F56E29A1.br_circleradiizero))
    _id_CE1C3B78F56E29A1.br_circleradiizero = level.br_level.br_circleradii[0];

  assertcirclesettings();
}

_applydvarstosettings(settings, _id_B98E2BDB3119A0E3, timescale) {
  _id_F0F12A9716532101 = getdvarfloat(_func_2EF675C13CA1C4AF("dvar_2F30E28124FF7895", _id_B98E2BDB3119A0E3, "_scale"), 1.0);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < settings.size; _id_AC0E594AC96AA3A8++) {
    _id_C2D7D58BFAD1B1EE = getdvarfloat(_func_2EF675C13CA1C4AF("dvar_F3544A0FDE0FB9B6", _id_B98E2BDB3119A0E3, "_", scripts\engine\utility::string(_id_AC0E594AC96AA3A8)), -1.0);

    if(_id_C2D7D58BFAD1B1EE > 0)
      settings[_id_AC0E594AC96AA3A8] = _id_C2D7D58BFAD1B1EE;

    settings[_id_AC0E594AC96AA3A8] = settings[_id_AC0E594AC96AA3A8] * timescale;
    settings[_id_AC0E594AC96AA3A8] = settings[_id_AC0E594AC96AA3A8] * _id_F0F12A9716532101;
  }

  return settings;
}

assertcirclesettings() {
  circlesettingsassert(isDefined(level.br_level.br_circleclosetimes), "level.br_level.br_circleCloseTimes not defined");
  circlesettingsassert(isDefined(level.br_level.br_circledelaytimes), "level.br_level.br_circleDelayTimes not defined");
  circlesettingsassert(isDefined(level.br_level.br_circleshowdelaydanger), "level.br_level.br_circleShowDelayDanger not defined");
  circlesettingsassert(isDefined(level.br_level.br_circleshowdelaysafe), "level.br_level.br_circleShowDelaySafe not defined");
  circlesettingsassert(isDefined(level.br_level.br_circleminimapradii), "level.br_level.br_circleMinimapRadii not defined");
  circlesettingsassert(isDefined(level.br_level.br_circleradii), "level.br_level.br_circleDelayTimes not defined");
  _id_6756BD882736E8BC = level.br_level.br_circleclosetimes.size;
  circlesettingsassert(_id_6756BD882736E8BC == level.br_level.br_circledelaytimes.size, "level.br_level.br_circleDelayTimes size != " + _id_6756BD882736E8BC);
  circlesettingsassert(_id_6756BD882736E8BC == level.br_level.br_circleshowdelaydanger.size, "level.br_level.br_circleShowDelayDanger size != " + _id_6756BD882736E8BC);
  circlesettingsassert(_id_6756BD882736E8BC == level.br_level.br_circleshowdelaysafe.size, "level.br_level.br_circleShowDelaySafe size != " + _id_6756BD882736E8BC);
  circlesettingsassert(_id_6756BD882736E8BC == level.br_level.br_circleminimapradii.size, "level.br_level.br_circleMinimapRadii size != " + _id_6756BD882736E8BC);
  circlesettingsassert(_id_6756BD882736E8BC == level.br_level.br_circleradii.size - 1, "level.br_level.br_circleRadii size-1 != " + _id_6756BD882736E8BC);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.br_level.br_circleshowdelaydanger.size; _id_AC0E594AC96AA3A8++) {
    _id_74B5B12BB6514385 = level.br_level.br_circledelaytimes[_id_AC0E594AC96AA3A8];
    _id_43A22B73F7AB26B7 = level.br_level.br_circleshowdelaydanger[_id_AC0E594AC96AA3A8];
    circlesettingsassert(_id_43A22B73F7AB26B7 <= _id_74B5B12BB6514385, "level.br_level.br_circleShowDelayDanger[" + _id_AC0E594AC96AA3A8 + "] " + _id_74B5B12BB6514385 + " > " + _id_43A22B73F7AB26B7);
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.br_level.br_circledelaytimes.size; _id_AC0E594AC96AA3A8++) {
    _id_74B5B12BB6514385 = level.br_level.br_circledelaytimes[_id_AC0E594AC96AA3A8];
    _id_43A22B73F7AB26B7 = level.br_level.br_circleshowdelaysafe[_id_AC0E594AC96AA3A8];
    circlesettingsassert(_id_43A22B73F7AB26B7 <= _id_74B5B12BB6514385, "level.br_level.br_circleDelayTimes[" + _id_AC0E594AC96AA3A8 + "] " + _id_74B5B12BB6514385 + " > " + _id_43A22B73F7AB26B7);
  }

  if(getdvarint("scr_br_moving_circle_enabled", 1) && !_id_362C58E8BB39BCDA::isfeaturedisabled("movingCircle"))
    circlesettingsassert(level.br_level.br_circleradii[0] == level.br_level.br_circleradiizero, "Changing circle radius 0 is not supported");
}

circlesettingsassert(value, msg) {
  if(!value)
    return;
}

getcircleclosetime(targetindex) {
  if(!isDefined(level.br_level))
    return 0;

  if(!isDefined(level.br_level.br_circledelaytimes) || !level.br_level.br_circledelaytimes.size)
    return 0;

  _id_6756BD882736E8BC = level.br_level.br_circledelaytimes.size;

  if(targetindex >= _id_6756BD882736E8BC)
    targetindex = _id_6756BD882736E8BC - 1;

  time = 0;

  for(circleindex = 0; circleindex <= targetindex; circleindex++) {
    _id_3702CBA57F844507 = level.br_level.br_circledelaytimes[circleindex];
    _id_3D8565E2775A243C = level.br_level.br_circleclosetimes[circleindex];
    time = time + _id_3702CBA57F844507 + _id_3D8565E2775A243C;
  }

  return time;
}

brcirclebattlechatter(circleindex) {
  waittime = level.br_level.br_circledelaytimes[circleindex] / 5;
  wait(waittime);

  foreach(team in level.teamnamelist)
  level thread doteamcirclebattlechatter(level.teamdata[team]);
}

doteamcirclebattlechatter(team) {
  _id_ADD4FD7502A75A8A = getsafecircleorigin();
  _id_77E882DA07E78CFE = getsafecircleradius();
  players = [];

  foreach(player in team["alivePlayers"]) {
    if(isDefined(player) && cancircledamageplayer(player))
      players = scripts\engine\utility::array_add(players, player);
  }

  if(players.size <= 1) {
    return;
  }
  players = sortbydistance(players, _id_ADD4FD7502A75A8A);
  eventname = undefined;
  _id_5C06026650B5DE35 = distance2dsquared(_id_ADD4FD7502A75A8A, players[0].origin);

  if(_id_5C06026650B5DE35 > _id_77E882DA07E78CFE * _id_77E882DA07E78CFE) {
    if(_id_5C06026650B5DE35 > _id_77E882DA07E78CFE * _id_77E882DA07E78CFE * 4)
      eventname = "sitrep_circle_outfar";
    else
      eventname = "sitrep_circle_out";
  } else {
    _id_06D4B305F9681783 = distance2dsquared(_id_ADD4FD7502A75A8A, players[players.size - 1].origin);

    if(_id_06D4B305F9681783 > _id_77E882DA07E78CFE * _id_77E882DA07E78CFE)
      eventname = "sitrep_circle_mixed";
    else
      eventname = "sitrep_circle_in";
  }

  if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73()) {
    sound = _func_2EF675C13CA1C4AF("stat_6FF1A4B4A68216FF", eventname);
    level thread scripts\mp\battlechatter_mp::trysaylocalsound(players[0], sound);
  } else {
    dialog = "br_" + eventname;
    _id_2CEDCC356F1B9FC8::brleaderdialog(dialog, 1, players);
  }
}

createinvalidcirclearea(origin, radius) {
  zone = spawnStruct();
  zone.origin = origin;
  zone.radius = radius;
  zone.radiussq = radius * radius;
  return zone;
}

canplaycircleopendialog(circleindex) {
  _id_BFF1E3C9BA212857 = 1;
  _id_960FFE6216854A87 = scripts\mp\utility\game::getsubgametype();

  if(_id_960FFE6216854A87 == "mini" || _id_960FFE6216854A87 == "mini_mgl" || _id_960FFE6216854A87 == "kingslayer" || _id_960FFE6216854A87 == "zxp" || _id_960FFE6216854A87 == "rumble_mgl" || _id_960FFE6216854A87 == "resurgence_mgl" || _id_960FFE6216854A87 == "champion") {
    if(circleindex <= 1)
      _id_BFF1E3C9BA212857 = 0;
  } else if(_id_960FFE6216854A87 == "dmz" || _id_960FFE6216854A87 == "exgm" || _id_960FFE6216854A87 == "resurgence" || _id_960FFE6216854A87 == "plunder" || _id_960FFE6216854A87 == "truckwar")
    _id_BFF1E3C9BA212857 = 0;

  return _id_BFF1E3C9BA212857;
}

canplaycircleclosedialog(circleindex) {
  _id_BFF1E3C9BA212857 = 1;
  _id_960FFE6216854A87 = scripts\mp\utility\game::getsubgametype();

  if(_id_960FFE6216854A87 == "mini" || _id_960FFE6216854A87 == "mini_mgl" || _id_960FFE6216854A87 == "zxp" || _id_960FFE6216854A87 == "rumble_mgl" || _id_960FFE6216854A87 == "resurgence_mgl" || _id_960FFE6216854A87 == "champion") {
    if(circleindex == 0)
      _id_BFF1E3C9BA212857 = 0;
  } else if(_id_960FFE6216854A87 == "dmz" || _id_960FFE6216854A87 == "exgm" || _id_960FFE6216854A87 == "plunder")
    _id_BFF1E3C9BA212857 = 0;

  return _id_BFF1E3C9BA212857;
}

resetdangercircleorigin(circleindex) {
  _id_E904BCCA7E8660F2 = 0;
  _id_960FFE6216854A87 = scripts\mp\utility\game::getsubgametype();

  switch (_id_960FFE6216854A87) {
    case "zxp":
    case "resurgence_mgl":
    case "resurgence":
    case "mini_mgl":
    case "mini":
    case "champion":
      if(circleindex == 0)
        _id_E904BCCA7E8660F2 = 1;

      break;
  }

  return _id_E904BCCA7E8660F2;
}

_id_ECA79FA0F341EE08(_id_7F590F6AE7F3BC83, _id_457258EED204DB55, _id_1DC8B3A2BA6E135C, _id_AC90EA5DC05930CD, _id_C660F86463F75E9E) {
  if(isDefined(_id_457258EED204DB55)) {
    level._id_9EBEF1EFB6E8A3A9 = scripts\engine\utility::_id_53C4C53197386572(level._id_9EBEF1EFB6E8A3A9, []);
    level._id_9EBEF1EFB6E8A3A9[_id_7F590F6AE7F3BC83] = _id_457258EED204DB55;
  }

  if(isDefined(_id_1DC8B3A2BA6E135C)) {
    level._id_C7FD2B5CF3ACB3DA = scripts\engine\utility::_id_53C4C53197386572(level._id_C7FD2B5CF3ACB3DA, []);
    level._id_8A12E160A2617C92 = scripts\engine\utility::_id_53C4C53197386572(level._id_8A12E160A2617C92, []);
    level._id_C7FD2B5CF3ACB3DA[_id_7F590F6AE7F3BC83] = _id_1DC8B3A2BA6E135C;
    level._id_8A12E160A2617C92[_id_7F590F6AE7F3BC83] = [];
  }

  if(isDefined(_id_AC90EA5DC05930CD)) {
    level._id_725403A0618F5A10 = scripts\engine\utility::_id_53C4C53197386572(level._id_725403A0618F5A10, []);
    level._id_725403A0618F5A10[_id_7F590F6AE7F3BC83] = _id_AC90EA5DC05930CD;
  }

  if(isDefined(_id_C660F86463F75E9E)) {
    level._id_20F62868A14AB570 = scripts\engine\utility::_id_53C4C53197386572(level._id_20F62868A14AB570, []);
    level._id_20F62868A14AB570[_id_7F590F6AE7F3BC83] = _id_C660F86463F75E9E;
  }
}

_id_4448B165E1F42719(_id_7F590F6AE7F3BC83) {
  if(isDefined(level._id_9EBEF1EFB6E8A3A9))
    level._id_9EBEF1EFB6E8A3A9 = scripts\engine\utility::array_remove_key(level._id_9EBEF1EFB6E8A3A9, _id_7F590F6AE7F3BC83);

  if(isDefined(level._id_C7FD2B5CF3ACB3DA))
    level._id_C7FD2B5CF3ACB3DA = scripts\engine\utility::array_remove_key(level._id_C7FD2B5CF3ACB3DA, _id_7F590F6AE7F3BC83);

  if(isDefined(level._id_8A12E160A2617C92))
    level._id_8A12E160A2617C92 = scripts\engine\utility::array_remove_key(level._id_8A12E160A2617C92, _id_7F590F6AE7F3BC83);

  if(isDefined(level._id_725403A0618F5A10))
    level._id_725403A0618F5A10 = scripts\engine\utility::array_remove_key(level._id_725403A0618F5A10, _id_7F590F6AE7F3BC83);

  if(isDefined(level._id_20F62868A14AB570))
    level._id_20F62868A14AB570 = scripts\engine\utility::array_remove_key(level._id_20F62868A14AB570, _id_7F590F6AE7F3BC83);
}

_id_FC0F865DDCF551AD() {
  return scripts\mp\utility\game::getsubgametype() == "mini" || scripts\mp\utility\game::getsubgametype() == "mini_mgl" || getdvarint("dvar_32BD10766631266F", 0) != 0;
}

_id_7FB9A2D57C0C42E2() {
  level.br_circle._id_DABF59AEB6B1034C = spawnStruct();
  level.br_circle._id_BCE22BA84FCC1CFE = spawnStruct();
  _id_4A28A04E419FA561 = scripts\engine\utility::ter_op(_id_FC0F865DDCF551AD(), 1, 0);
  _id_F6CAA991DFD18A35 = _id_4A28A04E419FA561 + 1;
  level.br_circle._id_DABF59AEB6B1034C scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("Prematch_Preview_Danger_Circle_BR", (level.br_level.br_circlecenters[_id_4A28A04E419FA561][0], level.br_level.br_circlecenters[_id_4A28A04E419FA561][1], 0), level.br_level.br_circleradii[_id_4A28A04E419FA561]);
  level.br_circle._id_BCE22BA84FCC1CFE scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("Prematch_Preview_Safe_Circle_BR", (level.br_level.br_circlecenters[_id_F6CAA991DFD18A35][0], level.br_level.br_circlecenters[_id_F6CAA991DFD18A35][1], 0), level.br_level.br_circleradii[_id_F6CAA991DFD18A35]);
  level.br_circle._id_DABF59AEB6B1034C scripts\cp_mp\utility\game_utility::_id_6988310081DE7B45();
  level.br_circle._id_BCE22BA84FCC1CFE scripts\cp_mp\utility\game_utility::_id_6988310081DE7B45();
  level thread _id_E900C5A0C7A22C7A();
}

_id_E900C5A0C7A22C7A() {
  level endon("game_ended");
  level waittill("prematch_over");
  level.br_circle._id_DABF59AEB6B1034C scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
  level.br_circle._id_BCE22BA84FCC1CFE scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
}
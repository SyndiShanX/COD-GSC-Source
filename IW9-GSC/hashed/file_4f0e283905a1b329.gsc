/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4f0e283905a1b329.gsc
***********************************************/

init() {
  _id_40F522DB9C1FD341 = getdvarint("scr_br_dropbag_delay", 0);

  if(_id_40F522DB9C1FD341 > 0)
    _id_362C58E8BB39BCDA::registerbrgametypedata("dropBagDelay", _id_40F522DB9C1FD341);

  level._id_177A0CF4AB15F08B = [];
  level._id_9AEE9A6ADE732E93 = [];
  level._id_654B6B003C6BCB30 = [];
  _id_EBC27E26CAA61CA4(level.dropzone);
}

_id_B243F0FD0562BBFB() {
  if(!isDefined(level.dropzone))
    level.dropzone = getdvarint("dvar_050CA64A29054BA4", 0);

  return level.dropzone != 0;
}

_id_E9562C5FC769DCF6() {
  if(!isDefined(level.dropzone))
    level.dropzone = getdvarint("dvar_050CA64A29054BA4", 0);

  return level.dropzone > 0 && level.dropzone < 7;
}

_id_EBC27E26CAA61CA4(dropzone) {
  if(dropzone == 0) {
    return;
  }
  _id_BC0ACFF6D6B20A34 = tablelookupgetnumrows("mp/br_drop_zone_info.csv");

  if(!isDefined(_id_BC0ACFF6D6B20A34)) {
    return;
  }
  _id_BA4C3C44112CE67E = 0;
  _id_BB717BDC22D80E71 = 1;
  _id_769C1C0B9E7CA9DE = ",";

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_BC0ACFF6D6B20A34; _id_AC0E594AC96AA3A8++) {
    _id_3140ED80D763092A = tablelookupbyrow("mp/br_drop_zone_info.csv", _id_AC0E594AC96AA3A8, _id_BA4C3C44112CE67E);

    if(_id_3140ED80D763092A == scripts\engine\utility::string(dropzone)) {
      _id_193D6E7CAF09FE5F = strtok(tablelookupbyrow("mp/br_drop_zone_info.csv", _id_AC0E594AC96AA3A8, _id_BB717BDC22D80E71), _id_769C1C0B9E7CA9DE);
      level._id_177A0CF4AB15F08B[level._id_177A0CF4AB15F08B.size] = (float(_id_193D6E7CAF09FE5F[0]), float(_id_193D6E7CAF09FE5F[1]), float(_id_193D6E7CAF09FE5F[2]));
    }

    if(_id_3140ED80D763092A == "center_" + scripts\engine\utility::string(dropzone)) {
      _id_193D6E7CAF09FE5F = strtok(tablelookupbyrow("mp/br_drop_zone_info.csv", _id_AC0E594AC96AA3A8, _id_BB717BDC22D80E71), _id_769C1C0B9E7CA9DE);
      level._id_654B6B003C6BCB30[dropzone] = (float(_id_193D6E7CAF09FE5F[0]), float(_id_193D6E7CAF09FE5F[1]), float(_id_193D6E7CAF09FE5F[2]));
    }
  }
}

_id_5CCEEF367316F829(_id_C87E64F99A703E8E, _id_C87E63F99A703C5B) {
  _id_ADD4FD7502A75A8A = _id_2695A20D4011076D::getsafecircleorigin();
  return distancesquared(_id_C87E64F99A703E8E, _id_ADD4FD7502A75A8A) < distancesquared(_id_C87E63F99A703C5B, _id_ADD4FD7502A75A8A);
}

_id_F43275A6CA9BA831(dropzone, _id_2891322C71EF74A8) {
  if(level._id_177A0CF4AB15F08B.size == 0)
    logstring("DROP ZONE DEBUG: NOT DEFINED DROP ZONE " + scripts\engine\utility::string(dropzone) + " POSITIONS IN CSV FILE");
  else {
    _id_E76814B73476B012 = [];
    dropposition = [];
    _id_ADD4FD7502A75A8A = _id_2695A20D4011076D::getsafecircleorigin();
    _id_77E882DA07E78CFE = _id_2695A20D4011076D::getsafecircleradius();

    foreach(position in level._id_177A0CF4AB15F08B) {
      if(distance2d(position, _id_ADD4FD7502A75A8A) <= _id_77E882DA07E78CFE)
        _id_E76814B73476B012[_id_E76814B73476B012.size] = position;
    }

    if(level._id_9AEE9A6ADE732E93.size > 0) {
      foreach(position in level._id_9AEE9A6ADE732E93) {
        if(_id_E76814B73476B012.size > _id_2891322C71EF74A8)
          _id_E76814B73476B012 = scripts\engine\utility::array_remove(_id_E76814B73476B012, position);
      }
    }

    _id_E76814B73476B012 = scripts\engine\utility::array_sort_with_func(_id_E76814B73476B012, ::_id_5CCEEF367316F829);
    dropposition = _id_E76814B73476B012;
    level._id_9AEE9A6ADE732E93 = dropposition;
  }
}

_id_84AF9E11E23A6EAA(pos) {
  crate = scripts\cp_mp\killstreaks\airdrop::dropcrate(undefined, "neutral", "battle_royale_juggernaut", pos + (0, 0, 4096), (0, randomfloat(360), 0), pos + (0, 0, 512), undefined, 1);
  crate endon("death");
  crate setscriptablepartstate("objective_map", "jugg_world");
  crate setscriptablepartstate("model", "choose");
  crate.isteamonlycrate = 0;
}

_id_F346C0C01D4E8D3C(dropposition, _id_2891322C71EF74A8) {
  if(!isDefined(dropposition)) {
    return;
  }
  level endon("game_ended");

  if(dropposition.size == 0) {
    logstring("DROP ZONE DEBUG: DO NOT HAVE ANY VALID POSITION IN CIRCLE");
    return;
  }

  if(_id_2891322C71EF74A8 > 0)
    scripts\mp\hud_util::showsplashtoall("br_drop_zone_jugg_drop_incoming");

  _id_7C5F25DF310107D4 = 0;
  _id_C9FB3AE0DAE6BA0E = [];

  while(_id_2891322C71EF74A8 > 0) {
    _id_7C5F25DF310107D4 = _id_7C5F25DF310107D4 % dropposition.size;
    _id_C4E74DCD3ECB1933 = dropposition[_id_7C5F25DF310107D4];

    if(isDefined(_id_C9FB3AE0DAE6BA0E[_id_7C5F25DF310107D4])) {
      _id_ADD4FD7502A75A8A = _id_2695A20D4011076D::getsafecircleorigin();
      _id_C4E74DCD3ECB1933 = vectorNormalize(_id_ADD4FD7502A75A8A - _id_C9FB3AE0DAE6BA0E[_id_7C5F25DF310107D4]) * 200 + _id_C9FB3AE0DAE6BA0E[_id_7C5F25DF310107D4];
    }

    _id_84AF9E11E23A6EAA(_id_C4E74DCD3ECB1933);
    _id_C9FB3AE0DAE6BA0E[_id_7C5F25DF310107D4] = _id_C4E74DCD3ECB1933;
    _id_2891322C71EF74A8--;
    _id_7C5F25DF310107D4++;
    waitframe();
  }
}

_id_7D6A2835BB650B9E() {
  level endon("game_ended");

  if(!istrue(level.br_infils_disabled))
    scripts\mp\flags::_id_1240434F4201AC9D("br_ready_to_jump");
  else
    level waittill("infils_ready");

  _id_F7B6CC6C062A7A43 = "br_drop_zone_" + scripts\engine\utility::string(level.dropzone);
  scripts\mp\hud_util::showsplashtoall(_id_F7B6CC6C062A7A43);
}

_id_05B61A0C37FC3665() {
  if(_id_E9562C5FC769DCF6())
    level thread _id_7D6A2835BB650B9E();

  level thread _id_CEEE3F8D1AD5671A();
  level thread _id_90B0B4AAF6EEE08F();
}

_id_CEEE3F8D1AD5671A() {
  _id_CCD8F22DD23B8ABD = getdvarint("dvar_18820C753025C637", 0);
  _id_CCB5FC2DD2155903 = getdvarint("dvar_300A15B2543FC6FD", -1);
  _id_CBB1A41DC897234C = getdvarfloat("dvar_B3D69BDCEF26E42D", 1);
  _id_F9D55560041BF5CC = getdvarint("dvar_CE898FFB160F8113", 2);

  if(_id_CCB5FC2DD2155903 < _id_CCD8F22DD23B8ABD) {
    return;
  }
  level endon("game_ended");
  _id_62A6ED0D69371342 = randomintrange(_id_CCD8F22DD23B8ABD, _id_CCB5FC2DD2155903 + 1);
  wait(_id_62A6ED0D69371342);
  _id_69A3EA43A93363EB = randomfloat(1);

  if(_id_69A3EA43A93363EB <= _id_CBB1A41DC897234C) {
    dropposition = _id_F43275A6CA9BA831(level.dropzone, _id_F9D55560041BF5CC);
    level thread _id_F346C0C01D4E8D3C(dropposition, _id_F9D55560041BF5CC);
  } else
    logstring("DROP ZONE DEBUG: DO NOT DROP FIRST DROP BECAUSE OF POSSIBILITY");

  _id_E438D785653F8999 = getdvarint("dvar_18820D753025C86A", 0);
  _id_E415E98565196977 = getdvarint("dvar_300A12B2543FC064", -1);
  _id_764E634A2802AB20 = getdvarfloat("dvar_B3D698DCEF26DD94", 1);
  _id_F6B1FB6E6A700AB0 = getdvarint("dvar_CE8990FB160F8346", 2);

  if(_id_E415E98565196977 >= _id_E438D785653F8999) {
    _id_99A50DB7302FC16E = randomintrange(_id_E438D785653F8999, _id_E415E98565196977 + 1);
    wait(_id_99A50DB7302FC16E);
    _id_09E3A71B033DD54F = randomfloat(1);

    if(_id_09E3A71B033DD54F <= _id_764E634A2802AB20) {
      dropposition = _id_F43275A6CA9BA831(level.dropzone, _id_F6B1FB6E6A700AB0);
      level thread _id_F346C0C01D4E8D3C(dropposition, _id_F6B1FB6E6A700AB0);
    } else
      logstring("DROP ZONE DEBUG: DO NOT DROP SECOND DROP BECAUSE OF POSSIBILITY");
  }
}

_id_2C89AE0C4852FF9F() {
  _id_962A30A9BB8C0F09 = scripts\cp_mp\killstreaks\airdrop::getleveldata("battle_royale_drop_zone_special_loot");
  _id_962A30A9BB8C0F09.capturestring = &"MP/BR_CRATE_LOADOUT";
  _id_962A30A9BB8C0F09._id_229AB5AFB5B2CF09 = "military_carepackage_03_br";
  _id_962A30A9BB8C0F09.mountmantlemodel = undefined;
  _id_962A30A9BB8C0F09.supportsownercapture = 0;
  _id_962A30A9BB8C0F09.headicon = undefined;
  _id_962A30A9BB8C0F09.usepriority = -1;
  _id_962A30A9BB8C0F09.usefov = 180;
  _id_962A30A9BB8C0F09.timeout = 600;
  _id_962A30A9BB8C0F09.friendlyuseonly = 0;
  _id_962A30A9BB8C0F09.ownerusetime = 0.5;
  _id_962A30A9BB8C0F09.otherusetime = 0.5;
  _id_962A30A9BB8C0F09._id_C23CA3472233553D = 1;
  _id_962A30A9BB8C0F09.activatecallback = ::_id_45F78D51B0FE98C0;
  _id_962A30A9BB8C0F09.capturecallback = ::_id_47C4924194BDD15F;
  _id_962A30A9BB8C0F09.destroycallback = ::_id_6DE2F5C1CD125663;
  _id_962A30A9BB8C0F09.destroyoncapture = 1;
  _id_962A30A9BB8C0F09._id_28EB33FFD1AA3E63 = 1;
}

_id_45F78D51B0FE98C0(isfirstactivation) {
  if(isDefined(self)) {
    if(isDefined(self.smokesignal)) {
      self.smokesignal setscriptablepartstate("smoke_signal", "off", 0);
      self.smokesignal delete();
    }

    self.smokesignal = spawn("script_model", self.origin);
    self.smokesignal setModel("ks_airdrop_crate_br");
    self.smokesignal setscriptablepartstate("smoke_signal", "on", 0);
  }
}

_id_47C4924194BDD15F(player) {
  self setscriptablepartstate("objective_map", "inactive", 0);
  _id_E07E586494BE44B4(player);

  if(isDefined(self.smokesignal)) {
    self.smokesignal setscriptablepartstate("smoke_signal", "off", 0);
    self.smokesignal delete();
  }
}

_id_6DE2F5C1CD125663(immediate) {
  self setscriptablepartstate("objective_map", "inactive", 0);

  if(isDefined(self.smokesignal)) {
    self.smokesignal setscriptablepartstate("smoke_signal", "off", 0);
    self.smokesignal delete();
  }
}

_id_437879FB3DE011A7(position, destination) {
  crate = scripts\cp_mp\killstreaks\airdrop::dropcrate(undefined, "neutral", "battle_royale_drop_zone_special_loot", position, (0, randomfloat(360), 0), destination);
  crate setscriptablepartstate("objective_map", "dropzone_special_drop_world", 0);
  return crate;
}

_id_4807DE09C120FBC4() {
  angle = randomfloat(360);
  return (cos(angle), sin(angle), 0);
}

_id_B2640F464D86D2DC(origin, direction, _id_D5149E29E826569A, _id_D5378829E84C6DF0) {
  _id_11E85672419D0F53 = randomfloatrange(_id_D5149E29E826569A, _id_D5378829E84C6DF0 + 1) * direction;
  droppoint = origin + _id_11E85672419D0F53;
  return droppoint;
}

_id_E72DA309259B008B(_id_C87E64F99A703E8E, _id_C87E63F99A703C5B) {
  _id_BC8F66367F5B6103 = level._id_654B6B003C6BCB30[level.dropzone];
  return distancesquared(_id_C87E64F99A703E8E, _id_BC8F66367F5B6103) < distancesquared(_id_C87E63F99A703C5B, _id_BC8F66367F5B6103);
}

_id_07CCAB162F5822C4(_id_4C5E281C351CBAE6) {
  if(!isDefined(level._id_654B6B003C6BCB30[level.dropzone]))
    return [];

  _id_83A5E1D528B8BA43 = level._id_654B6B003C6BCB30[level.dropzone];
  direction = _id_4807DE09C120FBC4();
  _id_8FA93A72C3FA36E7 = [];
  _id_1A273CD320638F94 = 0;
  _id_DABF4CF09B2C06CA = _id_83A5E1D528B8BA43;

  while(_id_4C5E281C351CBAE6 > 0) {
    droppoint = _id_B2640F464D86D2DC(_id_DABF4CF09B2C06CA, direction, 4000, 8000);

    if(_id_2695A20D4011076D::ispointincurrentsafecircle(droppoint)) {
      _id_8FA93A72C3FA36E7[_id_8FA93A72C3FA36E7.size] = droppoint;
      _id_DABF4CF09B2C06CA = droppoint;
      continue;
    }

    droppoint = _id_B2640F464D86D2DC(_id_DABF4CF09B2C06CA, direction, 4000, 4000);

    if(_id_2695A20D4011076D::ispointincurrentsafecircle(droppoint))
      _id_8FA93A72C3FA36E7[_id_8FA93A72C3FA36E7.size] = droppoint;

    if(istrue(_id_1A273CD320638F94)) {
      break;
    }

    _id_1A273CD320638F94 = 1;
    direction = direction * -1;

    if(isDefined(_id_8FA93A72C3FA36E7[0])) {
      _id_DABF4CF09B2C06CA = _id_8FA93A72C3FA36E7[0];
      continue;
    }

    _id_DABF4CF09B2C06CA = _id_83A5E1D528B8BA43;
  }

  _id_8FA93A72C3FA36E7 = scripts\engine\utility::array_sort_with_func(_id_8FA93A72C3FA36E7, ::_id_E72DA309259B008B);
  _id_5DA12B2B2AFA04AE = scripts\engine\utility::array_slice(_id_8FA93A72C3FA36E7, 0, _id_4C5E281C351CBAE6);
  return _id_5DA12B2B2AFA04AE;
}

getrandompointincircle(origin, radius) {
  randomangle = randomfloat(360);
  offset = (radius * cos(randomangle), radius * sin(randomangle), 0);
  point = origin + offset;
  return point;
}

_id_E07E586494BE44B4(player) {
  self.itemsdropped = 0;

  if(!isDefined(level._id_3996105421E4D86C))
    level._id_3996105421E4D86C = 0;
  else
    level._id_3996105421E4D86C = (level._id_3996105421E4D86C + 1) % 10;

  items = getscriptcachecontents("br_dropzone_special_airdrop", level._id_3996105421E4D86C);

  if(isDefined(items))
    _id_E05413A53B5D9167 = _id_552B8E4EA5FF7DF1::lootcachespawncontents(items, 0, player);

  if(!isDefined(player.lootcachesopened))
    player.lootcachesopened = 1;
  else
    player.lootcachesopened++;
}

_id_ECA5823A6030B791(droppoint) {
  center = level._id_654B6B003C6BCB30[level.dropzone];
  pathdir = vectorNormalize(droppoint - center);
  circleradius = _id_2695A20D4011076D::getsafecircleradius();
  center = center + (0, 0, _id_45B2B4A889E633FA::getc130knownsafeheight());
  startpt = center - pathdir * circleradius;
  endpt = center + pathdir * circleradius;
  pathstruct = spawnStruct();
  pathstruct.startpt = startpt;
  pathstruct.endpt = endpt;
  pathstruct.angle = vectortoangles(pathdir);
  level._id_4EA21FB25AACF0AD = startpt;
  return pathstruct;
}

_id_5995B7744FAAE3B0(_id_C87E64F99A703E8E, _id_C87E63F99A703C5B) {
  _id_4EA21FB25AACF0AD = _id_8658CE8460CD4B5B();
  return distancesquared(_id_C87E64F99A703E8E, _id_4EA21FB25AACF0AD) < distancesquared(_id_C87E63F99A703C5B, _id_4EA21FB25AACF0AD);
}

_id_8658CE8460CD4B5B() {
  if(isDefined(level._id_4EA21FB25AACF0AD))
    return level._id_4EA21FB25AACF0AD;
  else
    return level._id_654B6B003C6BCB30[level.dropzone];
}

_id_92816E8C27272CD2(_id_8FA93A72C3FA36E7, _id_B44F947EEF937CB7) {
  _id_7C5F25DF310107D4 = 0;
  _id_81AA7E8BC8F8C030 = self.startpt;
  travelspeed = _id_45B2B4A889E633FA::getc130speed();

  for(_id_8FA93A72C3FA36E7 = scripts\engine\utility::array_sort_with_func(_id_8FA93A72C3FA36E7, ::_id_5995B7744FAAE3B0); _id_7C5F25DF310107D4 < _id_8FA93A72C3FA36E7.size; _id_81AA7E8BC8F8C030 = _id_F37EF469027DCFA1) {
    _id_F37EF469027DCFA1 = _id_8FA93A72C3FA36E7[_id_7C5F25DF310107D4];
    dist = distance2d(_id_81AA7E8BC8F8C030, _id_F37EF469027DCFA1);
    _id_42F65B4B53C1F5D4 = dist / travelspeed;
    wait(_id_42F65B4B53C1F5D4);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B44F947EEF937CB7; _id_AC0E594AC96AA3A8++) {
      _id_DDD8C97024D1FFCE = getrandompointincircle(_id_F37EF469027DCFA1, 1000);
      _id_437879FB3DE011A7(_id_DDD8C97024D1FFCE + (0, 0, 4096), _id_DDD8C97024D1FFCE + (0, 0, 512));
      waitframe();
    }

    _id_7C5F25DF310107D4++;
  }
}

_id_CEF72E8676F3E895(_id_8FA93A72C3FA36E7, _id_B44F947EEF937CB7) {
  self setscriptablepartstate("audio_lp_dmz", "on", 0);
  self moveTo(self.endpt, self.lifetime);
  thread _id_2E385BC294259245::c130airdrop_deleteatlifetime();
  thread _id_92816E8C27272CD2(_id_8FA93A72C3FA36E7, _id_B44F947EEF937CB7);
}

_id_0814D0E354646685(_id_4C5E281C351CBAE6, _id_B44F947EEF937CB7) {
  level endon("game_ended");
  _id_8FA93A72C3FA36E7 = _id_07CCAB162F5822C4(_id_4C5E281C351CBAE6);

  if(_id_8FA93A72C3FA36E7.size == 0) {
    logstring("DROP ZONE DEBUG: CAN NOT FIND VALID POINT FOR SPECIAL DROP");
    return;
  }

  scripts\mp\hud_util::showsplashtoall("br_drop_zone_drop_incoming");
  pathstruct = _id_ECA5823A6030B791(_id_8FA93A72C3FA36E7[0]);
  dist = distance(pathstruct.startpt, pathstruct.endpt);
  travelspeed = _id_45B2B4A889E633FA::getc130speed();
  time = dist / travelspeed;
  _id_184D0A0CE31A2B27 = _id_2E385BC294259245::c130airdrop_spawn(pathstruct, dist, travelspeed, time);
  scripts\mp\objidpoolmanager::update_objective_icon(_id_184D0A0CE31A2B27.minimapid, "hud_icon_minimap_vehicle_cargo_plane_yellow");
  _id_184D0A0CE31A2B27 _id_CEF72E8676F3E895(_id_8FA93A72C3FA36E7, _id_B44F947EEF937CB7);
}

_id_90B0B4AAF6EEE08F() {
  _id_2C89AE0C4852FF9F();
  level endon("game_ended");
  _id_254D241001FB2581 = getdvarint("dvar_C4CC27A767D8BF9C", 2);
  _id_2F55781AF96F22F9 = 1;

  while(_id_2F55781AF96F22F9 <= _id_254D241001FB2581) {
    _id_5995B36355A7B111 = getdvarint(_func_2EF675C13CA1C4AF("dvar_6C2B83A7F09F38E3", _id_2F55781AF96F22F9), 120);
    _id_59B8C56355CE205F = getdvarint(_func_2EF675C13CA1C4AF("dvar_F4473BA79755A8C9", _id_2F55781AF96F22F9), 150);
    _id_AC29541CD6745E78 = getdvarfloat(_func_2EF675C13CA1C4AF("dvar_3259C4BE3BEC999E", _id_2F55781AF96F22F9), 1);
    _id_4C5E281C351CBAE6 = getdvarint(_func_2EF675C13CA1C4AF("dvar_696DE0C1B7B421DC", _id_2F55781AF96F22F9), 3);
    _id_B44F947EEF937CB7 = getdvarint(_func_2EF675C13CA1C4AF("dvar_2CB2312933A20B75", _id_2F55781AF96F22F9), 2);

    if(_id_59B8C56355CE205F < _id_5995B36355A7B111) {
      logstring("DROP ZONE DEBUG: dropDelayMax Should be greater than dropDelayMin!");
      _id_2F55781AF96F22F9++;
      continue;
    }

    _id_9BEA0D5DEC124F46 = randomintrange(_id_5995B36355A7B111, _id_59B8C56355CE205F + 1);
    wait(_id_9BEA0D5DEC124F46);
    _id_90D30739ECCADC47 = randomfloat(1);

    if(_id_90D30739ECCADC47 <= _id_AC29541CD6745E78)
      level thread _id_0814D0E354646685(_id_4C5E281C351CBAE6, _id_B44F947EEF937CB7);
    else
      logstring("DROP ZONE DEBUG: DO NOT DROP " + _id_254D241001FB2581 + "SPECIAL DROP BECAUSE OF POSSIBILITY");

    _id_2F55781AF96F22F9++;
  }
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\_prop_controls.gsc
***********************************************/

_id_13256() {
  if(isbot(self)) {
    return;
  }
  self notifyonplayercommand("_encstr_ACAD05F147D03F", "_encstr_A9E60828803C73F11780");
  self notifyonplayercommand("_encstr_ACAD05F147D03F", "_encstr_85D21AE322E335C047434F596D2BC333A837576EFFD586FE998ACDF7");
  self notifyonplayercommand("_encstr_AD7B0B41345140846A03AD8F9B", "_encstr_A6E60A229B175A3B48A543AB");
  self notifyonplayercommand("_encstr_ABB40B56CF1B9548AF3997F87F", "_encstr_97410B23BD6B976233901AF2F8");
  self notifyonplayercommand("_encstr_ABB40B56CF1B9548AF3997F87F", "_encstr_B4C60AD707B2BDC0E6CE1309");
  self notifyonplayercommand("_encstr_95AF0C1C27DE38A0264B8DB48E97", "_encstr_8E5F0795E6AD7BAD2B");
  self notifyonplayercommand("_encstr_974C0A72C8F0F317D1BD0F18", "_encstr_9A5C0E7471AFC0EA624018717863626F");
  self notifyonplayercommand("_encstr_86B9078A1DA7A07B32", "_encstr_8C5C0E95C2C63A5AED9BDCC6B7A30199");
  self notifyonplayercommand("_encstr_BE7F0863F060FD6273A5", "_encstr_835C0EF00E5F3B9B32C2427B929587A2");
  thread has_current_combat_action();
}

has_current_combat_action() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD4C133663B22C9B570E96B2E5905AE6C82DDC9D37");
  self waittill("_encstr_AD75063D571AE108");
  thread has_been_turned_on();
}

has_been_turned_on() {
  self notify("_encstr_AD4C133663B22C9B570E96B2E5905AE6C82DDC9D37");

  if(isbot(self)) {
    return;
  }
  self notifyonplayercommandremove("_encstr_ACAD05F147D03F", "_encstr_A9E60828803C73F11780");
  self notifyonplayercommandremove("_encstr_ACAD05F147D03F", "_encstr_85D21AE322E335C047434F596D2BC333A837576EFFD586FE998ACDF7");
  self notifyonplayercommandremove("_encstr_AD7B0B41345140846A03AD8F9B", "_encstr_A6E60A229B175A3B48A543AB");
  self notifyonplayercommandremove("_encstr_ABB40B56CF1B9548AF3997F87F", "_encstr_97410B23BD6B976233901AF2F8");
  self notifyonplayercommandremove("_encstr_ABB40B56CF1B9548AF3997F87F", "_encstr_B4C60AD707B2BDC0E6CE1309");
  self notifyonplayercommandremove("_encstr_95AF0C1C27DE38A0264B8DB48E97", "_encstr_8E5F0795E6AD7BAD2B");
  self notifyonplayercommandremove("_encstr_974C0A72C8F0F317D1BD0F18", "_encstr_9A5C0E7471AFC0EA624018717863626F");
  self notifyonplayercommandremove("_encstr_86B9078A1DA7A07B32", "_encstr_8C5C0E95C2C63A5AED9BDCC6B7A30199");
  self notifyonplayercommandremove("_encstr_BE7F0863F060FD6273A5", "_encstr_835C0EF00E5F3B9B32C2427B929587A2");
}

bettermissiontierbonuses(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 0.9);
  var_4.x = 15;
  var_4.y = self.initturretinteraction;
  var_4.alignx = "_encstr_A5AD056A019C63";
  var_4.aligny = "_encstr_AC190479FF92";
  var_4.horzalign = "_encstr_AD16101BCA66A37DB0194D579B470B261BB2";
  var_4.vertalign = "_encstr_916F0FFC57085917A5D0F39B3B0F43CDC8";
  var_4.fontscale = 1;
  var_4.alpha = 1;
  var_4.glowalpha = 0;
  var_4.hidewheninmenu = 0;
  var_4._id_1384B = var_4.fontscale;

  if(isDefined(var_3) && !scripts\engine\utility::is_player_gamepad_enabled())
    var_4.label = var_3;
  else if(isDefined(var_0))
    var_4.label = var_0;
  else if(isDefined(var_2)) {}

  if(isDefined(var_1))
    var_4 setvalue(var_1);

  self.initturretinteraction = self.initturretinteraction + 18;
  return var_4;
}

_id_128E4() {
  self.initturretinteraction = 152;
  self.getbrgametypedata = bettermissiontierbonuses(&"_encstr_99780DA605FA4112BC1A09A0E48EA8", 0);
  self._id_136F2 = bettermissiontierbonuses(&"_encstr_85440BED0159B28B38DFB95004", undefined, undefined, &"_encstr_AB8E0E904FE80B5C2AFF3021ED81929F");
  self._id_119A2 = bettermissiontierbonuses(&"_encstr_AC6E0B81E93951FC464CA0AE53");
  self._id_11B3D = bettermissiontierbonuses(&"_encstr_ABB90C491BB797AC5E471B01ABA5", undefined, undefined, &"_encstr_AD380F18C76093C4A247A4BF5929D95B86");
  self.armor_piercing = bettermissiontierbonuses();
  self.heli_boss = bettermissiontierbonuses(&"_encstr_868C0C49637F1789E6DE215865B8");
  _id_13178();
  self._id_1472B = bettermissiontierbonuses(&"_encstr_8DFC0BDF6906A070A7D2D5DDB1");
  thread _id_14027();
}

has_keycard() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_AD75063D571AE108");
  thread has_been_turned_on();
  thread has_intel();
}

_id_12E52(var_0) {
  if(isDefined(var_0))
    var_0 destroy();
}

has_intel() {
  self notify("_encstr_8DE6174334A272907058F7BB2868E6022A50EAB01297EC0B69");
  _id_12E52(self.getbrgametypedata);
  _id_12E52(self._id_136F2);
  _id_12E52(self._id_119A2);
  _id_12E52(self._id_11B3D);
  _id_12E52(self.armor_piercing);
  _id_12E52(self._id_1472B);
  _id_12E52(self._id_136DA);
  _id_12E52(self.heli_boss);
}

_id_14027() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isbot(self)) {
    return;
  }
  waittillframeend;
  var_0 = scripts\engine\utility::is_player_gamepad_enabled();

  for(;;) {
    var_1 = scripts\engine\utility::is_player_gamepad_enabled();

    if(var_1 != var_0) {
      var_0 = var_1;

      if(var_1) {
        if(!istrue(self._id_13414))
          self._id_11B3D.label = &"_encstr_ABB90C491BB797AC5E471B01ABA5";
        else
          self._id_11B3D.label = &"_encstr_A3AB0D2507C141A9C6C603C1219D28";
      } else if(!istrue(self._id_13414))
        self._id_11B3D.label = &"_encstr_AD380F18C76093C4A247A4BF5929D95B86";
      else
        self._id_11B3D.label = &"_encstr_9A851078A1D9D1A0EA27D5E8B7274D37C7D7";
    }

    waitframe();
  }
}

_id_128F5() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.lock = 0;
  self._id_13414 = 0;

  if(isbot(self)) {
    return;
  }
  if(!_encstr_8C9D2AD05F059188B39BAA4BD1861F33EAA86BB8BA618F17921E716F391139F3C92A8D0ED09B7DCB26F7BBD6::_id_1408E()) {
    self setclientomnvar("_encstr_B23A103348C8AB7489ABF3D749E07E1F0D41", 0);
    self setclientomnvar("_encstr_950115EAD2F5E043EB6BB0D11BD0B4DCCEEB6E63DB0E56", 0);
  }

  thread _id_12902();
  thread _id_128D9();
  thread _id_12908();
  self._id_12913 = 0;
  self.needdefaultendgameflowonly = 0;
  self.isteamextracted = 1;

  for(;;) {
    var_0 = scripts\engine\utility::_id_143B0("_encstr_ACAD05F147D03F", "_encstr_AD7B0B41345140846A03AD8F9B", "_encstr_ABB40B56CF1B9548AF3997F87F", "_encstr_95AF0C1C27DE38A0264B8DB48E97", "_encstr_974C0A72C8F0F317D1BD0F18");

    if(!isDefined(var_0)) {
      continue;
    }
    if(self._id_12913) {
      continue;
    }
    if(self.needdefaultendgameflowonly) {
      continue;
    }
    waittillframeend;

    if(var_0 == "_encstr_ACAD05F147D03F") {
      _id_128F9();
      continue;
    }

    if(var_0 == "_encstr_AD7B0B41345140846A03AD8F9B") {
      _id_128DA();
      continue;
    }

    if(var_0 == "_encstr_ABB40B56CF1B9548AF3997F87F") {
      _id_128FA();
      continue;
    }

    if(var_0 == "_encstr_95AF0C1C27DE38A0264B8DB48E97") {
      _id_128D3();
      continue;
    }

    if(var_0 == "_encstr_974C0A72C8F0F317D1BD0F18")
      _id_128E2();
  }
}

_id_128F9() {
  if(self ismantling()) {
    return;
  }
  if(self.lock)
    _id_13F1D();
  else
    _id_119A1();
}

_id_12B34(var_0) {
  var_1 = 3;

  if(!isDefined(var_0._id_1406E))
    var_0._id_1406E = 0;

  var_0._id_1406D[var_0._id_1406E] = var_0.prop.info;
  var_0._id_1406E++;

  if(var_0._id_1406E >= var_1)
    var_0._id_1406E = 0;
}

_id_128DA(var_0) {
  if(!_id_128EE() && !istrue(var_0)) {
    return;
  }
  if(istrue(level.pc) && !istrue(var_0)) {
    var_1 = 300;

    if(isDefined(self.warningendcallbacks) && gettime() - self.warningendcallbacks < var_1) {
      return;
    }
    self.warningendcallbacks = gettime();
  }

  self notify("_encstr_96590DC60DB09B3BCA327D0E9CED1C");
  _id_12B34(self);
  self.prop.info = _encstr_8C9D2AD05F059188B39BAA4BD1861F33EAA86BB8BA618F17921E716F391139F3C92A8D0ED09B7DCB26F7BBD6::reset_search_spot_light_nodes(self);
  _id_128DC(self.prop.info);
  self.maxhealth = int(_encstr_8C9D2AD05F059188B39BAA4BD1861F33EAA86BB8BA618F17921E716F391139F3C92A8D0ED09B7DCB26F7BBD6::revive_stim(self.prop.info));
  self setnormalhealth(1.0);
  _id_13177(self.initplayerplunderevents);
  _id_13177("_encstr_A59506C0242F4887");

  if(_encstr_8C9D2AD05F059188B39BAA4BD1861F33EAA86BB8BA618F17921E716F391139F3C92A8D0ED09B7DCB26F7BBD6::_id_1408E()) {
    self.armor_piercing.alpha = 1;
    self.heli_boss.alpha = 1;
  }

  if(!istrue(var_0))
    _id_128E6();
}

_id_128EE() {
  return self.getbrplayersnoteliminated > 0;
}

_id_128E6() {
  _id_1290A(self.getbrplayersnoteliminated - 1);
}

_id_1290A(var_0) {
  self.getbrplayersnoteliminated = var_0;

  if(_encstr_8C9D2AD05F059188B39BAA4BD1861F33EAA86BB8BA618F17921E716F391139F3C92A8D0ED09B7DCB26F7BBD6::_id_1408E()) {
    self.getbrgametypedata setvalue(self.getbrplayersnoteliminated);

    if(self.getbrplayersnoteliminated <= 0)
      self.getbrgametypedata.alpha = 0.5;
    else if(self.getbrplayersnoteliminated > 0 && self.getbrgametypedata.alpha < 1)
      self.getbrgametypedata.alpha = 1.0;
  } else
    self setclientomnvar("_encstr_8C5717AE2DD783A17D73575BD76C860BDCD995E6F5D895CC1D", self.getbrplayersnoteliminated);
}

_id_128DC(var_0) {
  self.prop.info = var_0;
  self._id_128F4 = var_0;
  self.prop setModel(var_0.modelname);
  self.prop._id_1467E = var_0._id_1467E;
  self.prop.building_roof_chopper_reenforce = var_0.building_roof_chopper_reenforce;
  self.prop unlink();
  self._id_128EA unlink();
  self._id_128EA.origin = self._id_128D7.origin;
  self.prop.origin = self._id_128EA.origin;
  self._id_128EA.angles = (self.angles[0], self._id_128EA.angles[1], self.angles[2]);
  self.prop.angles = self._id_128EA.angles;

  if(istrue(self.turret_guncourse_think)) {
    self.prop.angles = self.angles;
    self.turret_guncourse_think = 0;
  }

  _encstr_8C9D2AD05F059188B39BAA4BD1861F33EAA86BB8BA618F17921E716F391139F3C92A8D0ED09B7DCB26F7BBD6::calculateobjectivesheld();
  _encstr_8C9D2AD05F059188B39BAA4BD1861F33EAA86BB8BA618F17921E716F391139F3C92A8D0ED09B7DCB26F7BBD6::cache1_defender_after_spawn();
  self.prop linkTo(self._id_128EA, "_encstr_AFAA093C4628DA52A72756");

  if(self._id_13414 && istrue(self.lock))
    self._id_128EA _id_130A7(self.prop);

  self._id_128EA linkTo(self._id_128D7);
  self._id_13B30 = var_0._id_12905;
  self._id_13B2F = var_0._id_128F1;
  self setcamerathirdperson(1, self._id_13B30, self._id_13B2F);
}

_id_128FA() {
  if(!istrue(self._id_13414)) {
    self._id_13414 = 1;

    if(istrue(self.lock)) {
      self._id_128EA unlink();
      self._id_128EA _id_130A7(self.prop);
      self._id_128EA linkTo(self._id_128D7);
    }

    if(_encstr_8C9D2AD05F059188B39BAA4BD1861F33EAA86BB8BA618F17921E716F391139F3C92A8D0ED09B7DCB26F7BBD6::_id_1408E()) {
      if(scripts\engine\utility::is_player_gamepad_enabled())
        self._id_11B3D.label = &"_encstr_A3AB0D2507C141A9C6C603C1219D28";
      else
        self._id_11B3D.label = &"_encstr_9A851078A1D9D1A0EA27D5E8B7274D37C7D7";
    } else
      self setclientomnvar("_encstr_950115EAD2F5E043EB6BB0D11BD0B4DCCEEB6E63DB0E56", 1);
  } else {
    self._id_13414 = 0;

    if(istrue(self.lock)) {
      self._id_128EA unlink();
      self._id_128EA.angles = (self.angles[0], self._id_128EA.angles[1], self.angles[2]);
      self._id_128EA.origin = self._id_128D7.origin;
      self._id_128EA linkTo(self._id_128D7);
    }

    if(_encstr_8C9D2AD05F059188B39BAA4BD1861F33EAA86BB8BA618F17921E716F391139F3C92A8D0ED09B7DCB26F7BBD6::_id_1408E()) {
      if(scripts\engine\utility::is_player_gamepad_enabled())
        self._id_11B3D.label = &"_encstr_ABB90C491BB797AC5E471B01ABA5";
      else
        self._id_11B3D.label = &"_encstr_AD380F18C76093C4A247A4BF5929D95B86";
    } else
      self setclientomnvar("_encstr_950115EAD2F5E043EB6BB0D11BD0B4DCCEEB6E63DB0E56", 0);
  }
}

_id_128D3() {
  if(_id_128F0()) {
    thread player_name_who_broke_stealth();
    _id_128E8();
  }
}

_id_128E2() {
  if(_id_128EF()) {
    thread heli_boss_logic();
    thread _id_128E7();
  }
}

_id_128EF() {
  return self.heli_boss_shoot > 0;
}

_id_128E7() {
  _id_1290B(self.heli_boss_shoot - 1);
}

_id_1290B(var_0) {
  self.heli_boss_shoot = var_0;

  if(_encstr_8C9D2AD05F059188B39BAA4BD1861F33EAA86BB8BA618F17921E716F391139F3C92A8D0ED09B7DCB26F7BBD6::_id_1408E()) {
    self.heli_boss setvalue(self.heli_boss_shoot);

    if(self.heli_boss_shoot <= 0)
      self.heli_boss.alpha = 0.5;
    else if(self.heli_boss_shoot > 0 && self.heli_boss.alpha < 1)
      self.heli_boss.alpha = 1.0;
  } else
    self setclientomnvar("_encstr_A3B91683F021A8526015170F0F165AFFF0D9BA81C818464B", self.heli_boss_shoot);
}

_id_128F0() {
  return self.armor_target_vo > 0;
}

_id_128E8() {
  _id_1290C(self.armor_target_vo - 1);
}

_id_1290C(var_0) {
  self.armor_target_vo = var_0;

  if(_encstr_8C9D2AD05F059188B39BAA4BD1861F33EAA86BB8BA618F17921E716F391139F3C92A8D0ED09B7DCB26F7BBD6::_id_1408E()) {
    self.armor_piercing setvalue(self.armor_target_vo);

    if(self.armor_target_vo <= 0)
      self.armor_piercing.alpha = 0.5;
    else if(self.armor_target_vo > 0 && self.armor_piercing.alpha < 1)
      self.armor_piercing.alpha = 1.0;
  } else
    self setclientomnvar("_encstr_A3D517ABD2FA381AEBB95DB67D9963B06E43B26ED7D82B331D", self.armor_target_vo);
}

_id_130A7(var_0) {
  var_1 = propwaitminigameinit(var_0, 0);

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = anglesToForward(self.angles);
  var_3 = anglestoright(self.angles);
  var_4 = vectortoangles(var_1);
  var_5 = angleclamp180(var_4[0] + 90);
  var_4 = (0, var_4[1], 0);
  var_6 = anglesToForward(var_4);
  var_7 = vectordot(var_6, var_3);

  if(var_7 < 0)
    var_7 = -1;
  else
    var_7 = 1;

  var_8 = vectordot(var_6, var_2);
  var_9 = var_8 * var_5;
  var_10 = (1 - abs(var_8)) * var_5 * var_7;
  self.angles = (var_9, self.angles[1], var_10);
}

remove_marker_when_player_get_close(var_0, var_1) {
  var_2 = 128;
  var_3 = game["_encstr_B6A70A23CA6659DC91CAE4DC"];
  var_4 = level.teamdata[var_3]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"];

  if(var_4.size > var_2) {
    var_4 = scripts\mp\utility\player::getplayersinradius(var_0, 500, var_3);

    if(var_4.size > var_2) {
      var_4 = scripts\mp\utility\player::getplayersinradius(var_0, 50, var_3);

      if(var_4.size > var_2)
        return var_1;
    }
  }

  var_5 = [];

  foreach(var_7 in var_4)
  var_5[var_5.size] = var_7.prop;
}

propwaitminigameinit(var_0, var_1) {
  if(!isDefined(var_0))
    var_2 = self;
  else
    var_2 = var_0;

  var_3 = remove_marker_when_player_get_close(self.origin, var_2);
  var_4 = [self.origin];

  for(var_5 = -1.0; var_5 <= 1.0; var_5 = var_5 + 2.0) {
    for(var_6 = -1.0; var_6 <= 1.0; var_6 = var_6 + 2.0) {
      var_7 = var_2 getpointinbounds(var_5, var_6, 0.0);
      var_7 = (var_7[0], var_7[1], self.origin[2]);
      var_4[var_4.size] = var_7;
    }
  }

  var_8 = (0, 0, 0);
  var_9 = 0;

  foreach(var_11 in var_4) {
    var_12 = scripts\engine\trace::_bullet_trace(var_11 + (0, 0, 4), var_11 + (0, 0, -16), 0, var_3);
    var_13 = var_12["_encstr_A53009A25003666B9818C6"] > 0.0 && var_12["_encstr_A53009A25003666B9818C6"] < 1;

    if(var_13) {
      var_8 = var_8 + var_12["_encstr_820E07FAE8780B3A4C"];
      var_9++;
    }
  }

  if(var_9 > 0) {
    var_8 = var_8 / var_9;
    return var_8;
  } else
    return undefined;
}

_id_12902() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;

  for(;;) {
    waitframe();
    var_3 = self getnormalizedmovement();
    var_4 = self jumpbuttonPressed();

    if(!isDefined(var_3)) {
      continue;
    }
    if(self._id_12913) {
      continue;
    }
    var_5 = var_3[0] != 0 || var_3[1] != 0 || var_4;

    if(self.lock && var_2 && !var_5)
      var_2 = 0;
    else if(self.lock && !var_0 && var_5)
      var_2 = 1;
    else if(self.lock && var_5 && !var_2)
      _id_13F1D();

    var_0 = self.lock;
    var_1 = var_5;
  }
}

_id_13F1D() {
  self unlink();

  if(self._id_13414) {
    self._id_128EA unlink();
    self._id_128EA.angles = (self.angles[0], self._id_128EA.angles[1], self.angles[2]);
    self._id_128EA.origin = self._id_128D7.origin;
    self._id_128EA linkTo(self._id_128D7);
  }

  self._id_128D7 linkTo(self);
  self.lock = 0;

  if(_encstr_8C9D2AD05F059188B39BAA4BD1861F33EAA86BB8BA618F17921E716F391139F3C92A8D0ED09B7DCB26F7BBD6::_id_1408E()) {
    self._id_119A2.label = &"_encstr_AC6E0B81E93951FC464CA0AE53";
    thread player_origin_inside_subway_car();
  } else
    self setclientomnvar("_encstr_B23A103348C8AB7489ABF3D749E07E1F0D41", 0);
}

_id_119A1() {
  if(!get_alive_bots()) {
    return;
  }
  self._id_128D7 unlink();
  self._id_128D7.origin = self.origin;
  var_0 = self getgroundentity();

  if(isDefined(var_0) && var_0 nuke_vault_suicidebomber_internal())
    self._id_128D7 linkTo(var_0);

  self playerlinkTo(self._id_128D7);

  if(self._id_13414) {
    self._id_128EA unlink();
    self._id_128EA _id_130A7(self.prop);
    self._id_128EA.origin = self.origin;
    self._id_128EA linkTo(self._id_128D7);
  }

  self.lock = 1;
  self notify("_encstr_96DF07C9F2A22F1A3A");

  if(_encstr_8C9D2AD05F059188B39BAA4BD1861F33EAA86BB8BA618F17921E716F391139F3C92A8D0ED09B7DCB26F7BBD6::_id_1408E()) {
    self._id_119A2.label = &"_encstr_ADF90DBDC74FF1B01861371F418D74";
    thread player_origin_inside_subway_car();
  } else
    self setclientomnvar("_encstr_B23A103348C8AB7489ABF3D749E07E1F0D41", 1);
}

nuke_vault_suicidebomber_internal() {
  return isalive(self) && (scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56");
}

player_origin_inside_subway_car() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_AAC61199C6B0E68662DBD85B14C9F6E0D2B25E");
  self endon("_encstr_AAC61199C6B0E68662DBD85B14C9F6E0D2B25E");
  var_0 = self._id_119A2._id_1384B + 0.75;
  self._id_119A2 changefontscaleovertime(0.1);
  self._id_119A2.fontscale = var_0;
  wait 0.1;

  if(isDefined(self._id_119A2)) {
    self._id_119A2 changefontscaleovertime(0.1);
    self._id_119A2.fontscale = self._id_119A2._id_1384B;
  }
}

get_alive_bots() {
  if(!self isonground()) {
    var_0 = getgroundposition(self.origin, 15, 30000, 0);
    var_1 = getEntArray("_encstr_85FE0DD5727A27098513298817CA23", "_encstr_AC110A7F14873B5B3D073009");

    foreach(var_3 in var_1) {
      if(ispointinvolume(var_0, var_3))
        return 0;
    }
  }

  return 1;
}

_id_12910() {
  level endon("_encstr_A2751273B7144EBD0EDC45B7D438591BE858D12B");
  self._id_12913 = 0;
  self.needdefaultendgameflowonly = 0;

  if(!isDefined(self._id_136DB))
    self._id_136DB = 0;

  for(;;) {
    var_0 = scripts\engine\utility::_id_143AC("_encstr_ACC409C37BAB3B430B19CF");

    if(self.needdefaultendgameflowonly) {
      continue;
    }
    if(var_0 == "_encstr_ACC409C37BAB3B430B19CF") {
      if(self._id_12913) {
        self notify("_encstr_B63F10DDF52AC92B0F9BC9C8D75BA3E3535F");
        continue;
      }

      _encstr_8C9D2AD05F059188B39BAA4BD1861F33EAA86BB8BA618F17921E716F391139F3C92A8D0ED09B7DCB26F7BBD6::init_swivelroom_variables();

      if(self._id_136D7.size <= 1) {
        continue;
      }
      self._id_12913 = 1;
      _id_128D4(0);
      thread _id_12911();
      childthread _id_12912();
    }
  }
}

_id_12912() {
  self endon("_encstr_B63F10DDF52AC92B0F9BC9C8D75BA3E3535F");

  if(getkeypadomnvarbitpackinginfo())
    _id_136DD();
  else {
    play_travel_vo(1);
    _id_136DD();
  }

  for(;;) {
    var_0 = scripts\engine\utility::_id_143AD("_encstr_86B9078A1DA7A07B32", "_encstr_BE7F0863F060FD6273A5");

    if(self.needdefaultendgameflowonly) {
      continue;
    }
    if(var_0 == "_encstr_86B9078A1DA7A07B32") {
      play_travel_vo(1);
      getkeypadomnvarbitpackinginfo();
      _id_11DBA();
    }

    if(var_0 == "_encstr_BE7F0863F060FD6273A5") {
      play_travel_vo(0);
      getkeypadomnvarbitpackinginfo();
      _id_11DBA();
    }
  }
}

getkeypadomnvarbitpackinginfo() {
  var_0 = self._id_136D7[self._id_136DB];

  if(!isDefined(var_0))
    return 0;

  if(var_0 == self)
    return 0;

  if(scripts\mp\utility\player::isreallyalive(var_0))
    return 1;

  return 0;
}

play_travel_vo(var_0) {
  var_1 = self._id_136DB;

  for(;;) {
    if(istrue(var_0))
      self._id_136DB++;
    else
      self._id_136DB--;

    if(var_0 && self._id_136D7.size <= self._id_136DB)
      self._id_136DB = 0;
    else if(self._id_136DB < 0)
      self._id_136DB = self._id_136D7.size - 1;

    if(self._id_136DB == var_1) {
      break;
    }

    if(getkeypadomnvarbitpackinginfo()) {
      break;
    }
  }
}

_id_12911() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  init_swivelroom_obj();
  scripts\engine\utility::waittill_any_ents(self, "_encstr_B63F10DDF52AC92B0F9BC9C8D75BA3E3535F", level, "_encstr_A2751273B7144EBD0EDC45B7D438591BE858D12B");

  if(istrue(self.needdefaultendgameflowonly)) {
    return;
  }
  self.needdefaultendgameflowonly = 1;
  lb_mg_impulse_dmg_factor_low();
  _id_12CE7();
  waittillframeend;
  _id_128D4(1);
  self._id_12913 = 0;
  self.needdefaultendgameflowonly = 0;
}

init_swivelroom_obj() {
  self._id_136D9 = scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 1);
  self._id_136D9.label = &"_encstr_91BA13A6A0D74124F2D42815D0869E9AA9A0C911D4";
  self._id_136D9.x = 20;
  self._id_136D9.y = -80;
  self._id_136D9.alignx = "_encstr_A5C407E1658D3339B3";
  self._id_136D9.aligny = "_encstr_8F8D07BB035BDAD5CD";
  self._id_136D9.horzalign = "_encstr_BAC512BEE718EBC723A9C16A94030203300209C7";
  self._id_136D9.vertalign = "_encstr_BD6B122E4FF3ABF775C13060EA0B87E3FFEAA115";
  self._id_136D9.archived = 1;
  self._id_136D9.fontscale = 1;
  self._id_136D9.alpha = 1;
  self._id_136D9.glowalpha = 0.5;
  self._id_136D9.hidewheninmenu = 0;
}

lb_mg_impulse_dmg_factor_low() {
  if(isDefined(self._id_136D9))
    self._id_136D9 destroy();
}

_id_136DD() {
  var_0 = self._id_136D7[self._id_136DB];
  self._id_136DF = var_0;
  self._id_128D7 unlink();
  self._id_128D7.origin = self.origin;
  self setOrigin(var_0.origin);
  self.angles = var_0.angles;
  self playerlinkTo(var_0._id_128D7);
}

_id_11DBA() {
  var_0 = self._id_136D7[self._id_136DB];
  self unlink();
  self.origin = var_0.origin;
  self.angles = var_0.angles;
  self playerlinkTo(var_0._id_128D7);
}

_id_12CE7() {
  self unlink();
  self setOrigin(self._id_128D7.origin);

  if(self.lock)
    self playerlinkTo(self._id_128D7);
  else {
    self._id_128D7 linkTo(self);
    self._id_128D7.origin = self.origin;
  }
}

_id_11EBC() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_A2751273B7144EBD0EDC45B7D438591BE858D12B");
  _id_12E52(self._id_136DA);
}

_id_128D9() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = 10;
  self._id_13B30 = self.prop.info._id_12905;

  for(;;) {
    var_1 = scripts\engine\utility::_id_143AD("_encstr_86B9078A1DA7A07B32", "_encstr_BE7F0863F060FD6273A5");

    if(istrue(self.needdefaultendgameflowonly)) {
      continue;
    }
    if(!isDefined(var_1)) {
      continue;
    }
    if(istrue(self._id_12913)) {
      continue;
    }
    if(var_1 == "_encstr_86B9078A1DA7A07B32") {
      if(self._id_13B30 - var_0 < 50) {
        continue;
      }
      self._id_13B30 = self._id_13B30 - var_0;
      self setcamerathirdperson(1, self._id_13B30, self._id_13B2F);
      continue;
    }

    if(var_1 == "_encstr_BE7F0863F060FD6273A5") {
      var_2 = clamp(self.prop.info._id_12905 + 50, 50, 360);

      if(self._id_13B30 + var_0 > var_2) {
        continue;
      }
      self._id_13B30 = self._id_13B30 + var_0;
      self setcamerathirdperson(1, self._id_13B30, self._id_13B2F);
    }
  }
}

_id_12908() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(self adsButtonPressed(1) && !istrue(self._id_128EA._id_136F1)) {
      self._id_128EA scriptmodelpauseanim(0);
      self._id_128EA._id_136F1 = 1;
    } else if(!self adsButtonPressed(1) && istrue(self._id_128EA._id_136F1)) {
      self._id_128EA scriptmodelpauseanim(1);
      self._id_128EA._id_136F1 = 0;
    }

    wait 0.05;
  }
}

_id_13178() {
  switch (self.initplayerplunderevents) {
    case "_encstr_88A9065F05D67961":
      self.armor_piercing.label = &"_encstr_BA780CE95AB9E94C6F2351216F50";
      break;
    default:
      break;
  }
}

_id_13177(var_0, var_1) {
  switch (var_0) {
    case "_encstr_88A9065F05D67961":
      if(!isDefined(var_1))
        var_1 = level._id_12315.settings._id_12904;

      _id_1290C(var_1);
      break;
    case "_encstr_A59506C0242F4887":
      if(!isDefined(var_1))
        var_1 = level._id_12315.settings._id_12903;

      _id_1290B(var_1);
      break;
    default:
      break;
  }
}

player_pined_danger_feedback(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  thread scripts\mp\shellshock::endondeath();
  self endon("_encstr_BDF90C4D10A95F47E990CAF2D83B");
  self waittill("_encstr_860808CB78E2984063BA", var_1);

  if(!isDefined(var_0)) {
    return;
  }
  player_name_who_broke_stealth(var_0, var_1);
}

player_name_who_broke_stealth(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = self;

  if(!isDefined(var_1))
    var_1 = self.origin;

  playFX(scripts\engine\utility::getfx("_encstr_ABC70A074EDB8364D8C2B9A1"), var_1 + (0, 0, 4));
  playsoundatpos(var_1, "_encstr_82FA0FE8AE78535945E06A4328A50EF3D1");

  foreach(var_3 in level.players) {
    if(var_3 == var_0) {
      continue;
    }
    if(istrue(var_3.player_on_helipad)) {
      continue;
    }
    if(!isDefined(var_3) || !isalive(var_3) || !isDefined(var_3.team) || var_3 _encstr_8C9D2AD05F059188B39BAA4BD1861F33EAA86BB8BA618F17921E716F391139F3C92A8D0ED09B7DCB26F7BBD6::_id_125F0()) {
      continue;
    }
    var_4 = var_1 + (0, 0, 4) - var_3 getEye();
    var_5 = length(var_4);
    var_6 = 500.0;
    var_7 = 150.0;

    if(var_5 <= var_6) {
      if(var_5 <= var_7)
        var_8 = 1;
      else
        var_8 = 1 - (var_5 - var_7) / (var_6 - var_7);

      var_9 = vectorNormalize(var_4);
      var_10 = anglesToForward(var_3 getplayerangles());
      var_11 = vectordot(var_10, var_9);
      var_3 applyflash(var_1 + (0, 0, 4), var_8, var_11, var_0, var_0.team, 2.0);
    }
  }
}

applyflash(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 2.5;

  if(!isDefined(var_5))
    var_5 = 0;

  if(var_2 < 0.25)
    var_2 = 0.25;
  else if(var_2 > 0.8)
    var_2 = 1;

  var_7 = var_1 * var_2 * var_6;
  var_7 = var_7 + var_5;

  if(var_7 < 0.25) {
    return;
  }
  var_3 thread scripts\mp\damagefeedback::updatedamagefeedback("_encstr_A5AE098ADB583E0AF7A5AB");
  thread scripts\mp\equipment\flash_grenade::applyflash(var_3, var_7);
}

lastdirty() {
  var_0 = 9;

  if(self._id_128E3.size + 1 <= var_0) {
    return;
  }
  var_1 = 0;

  foreach(var_3 in self._id_128E3) {
    if(isDefined(var_3))
      var_1++;
  }

  if(var_1 + 1 <= var_0) {
    return;
  }
  var_5 = [];
  var_6 = undefined;

  for(var_7 = 0; var_7 < self._id_128E3.size; var_7++) {
    var_3 = self._id_128E3[var_7];

    if(!isDefined(var_3)) {
      continue;
    }
    if(!isDefined(var_6)) {
      var_6 = var_3;
      continue;
    }

    var_5[var_5.size] = var_3;
  }

  var_6 notify("_encstr_A74F0AADF6C891057A57211B");
  var_6 delete();
  self._id_128E3 = var_5;
}

heli_boss_logic() {
  if(!isDefined(self._id_128E3))
    self._id_128E3 = [];
  else
    lastdirty();

  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.prop.origin);
  var_0.targetname = "_encstr_BACB0A1062A03B0860B8C85D";
  var_0 setModel(self.prop.model);
  var_0.angles = self.prop.angles;
  var_0.health = 50;
  var_0.playerowner = self;
  var_0 setCanDamage(1);
  var_0 thread scripts\mp\damage::monitordamage(var_0.health, "_encstr_A2FB098A2035874AB0F358", ::heli_audio, ::is_station_active);
  var_0 thread _encstr_8C9D2AD05F059188B39BAA4BD1861F33EAA86BB8BA618F17921E716F391139F3C92A8D0ED09B7DCB26F7BBD6::spawn_exfil_techo(game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_A2A117F6AB471B5AE656AFE6DB199583D134FADB930BCD76CA");
  var_0 scripts\mp\sentientpoolmanager::registersentient("_encstr_962E10A2166CE896C6C21BF56A1D0B1DB48D", self.team);
  self._id_128E3[self._id_128E3.size] = var_0;
}

is_station_active(var_0) {
  if(!isDefined(var_0.attacker))
    return 0;

  if(isPlayer(var_0.attacker)) {
    if(istrue(self.unlockprop))
      return 0;

    var_0.attacker thread scripts\mp\damagefeedback::updatedamagefeedback("_encstr_A2FB098A2035874AB0F358");
    self.lastattacker = var_0.inflictor;
  }

  return var_0.damage;
}

heli_audio(var_0) {
  if(!isDefined(self.unlockprop))
    self.unlockprop = 1;

  if(isDefined(self.lastattacker)) {
    self.lastattacker thread _encstr_8C9D2AD05F059188B39BAA4BD1861F33EAA86BB8BA618F17921E716F391139F3C92A8D0ED09B7DCB26F7BBD6::scriptablesmax("_encstr_840D106CD8B7DC2BFA19CAE61DC9DEF2B2C8");

    if(isDefined(self.playerowner))
      self.playerowner thread _encstr_8C9D2AD05F059188B39BAA4BD1861F33EAA86BB8BA618F17921E716F391139F3C92A8D0ED09B7DCB26F7BBD6::scriptablesmax("_encstr_9B8F14A60DE2CDA157DFF0689784792FFB322833272A");
  }

  var_1 = "_encstr_9AD50BE8AE78535941A86A3328";
  var_2 = "_encstr_9B580CE039B707115985D1A18C2C";
  playsoundatpos(self.origin + (0, 0, 4), var_1);
  playFX(scripts\engine\utility::getfx(var_2), self.origin + (0, 0, 4));

  if(isDefined(self))
    self delete();
}

patched_collision(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(var_0))
    var_0 = 5;

  if(!isDefined(var_1))
    var_1 = 1;

  if(!isDefined(var_2))
    var_2 = 1;

  var_3 = newclienthudelem(self);
  var_3.foreground = 0;
  var_3.x = 0;
  var_3.y = 0;
  var_3 setshader("_encstr_83AB065EE1391A7B", 640, 480);
  var_3.alignx = "_encstr_A5AD056A019C63";
  var_3.aligny = "_encstr_AC190479FF92";
  var_3.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_3.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_3.alpha = 0;
  waitframe();

  if(var_1 > 0)
    var_3 fadeovertime(var_1);

  var_3.alpha = 1;
  wait(var_0 - var_2);

  if(var_2 > 0)
    var_3 fadeovertime(var_2);

  var_3.alpha = 0;
  wait(var_2);
  waitframe();
  _id_12E52(var_3);
}

_id_144F6() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notifyonplayercommand("_encstr_AB760F43D123BA8C610BBC9E7DF5C85415", "_encstr_8E5F0795E6AD7BAD2B");

  for(;;) {
    self waittill("_encstr_AB760F43D123BA8C610BBC9E7DF5C85415");
    self._id_13B5E = self._id_13B5E + 1;
  }
}

spawn_carried_punchcard_if_player_down() {
  level waittill("_encstr_9B1D0BC7932875276230426AA1");

  if(_encstr_8C9D2AD05F059188B39BAA4BD1861F33EAA86BB8BA618F17921E716F391139F3C92A8D0ED09B7DCB26F7BBD6::_id_1408E()) {
    level.monitor_player_plundercount.alpha = 0;
    level._id_12315._id_145BB.alpha = 0;
    level._id_145BC.alpha = 0;
  }

  foreach(var_1 in level.players)
  var_1 _id_128D4(0);
}

_id_12E64(var_0, var_1) {
  if(isDefined(var_0))
    var_0.alpha = var_1;
}

_id_128D4(var_0, var_1) {
  if(istrue(var_0))
    var_2 = 1;
  else
    var_2 = 0;

  if(_encstr_8C9D2AD05F059188B39BAA4BD1861F33EAA86BB8BA618F17921E716F391139F3C92A8D0ED09B7DCB26F7BBD6::_id_1408E() || istrue(var_1)) {
    _id_12E64(self.getbrgametypedata, var_2);
    _id_12E64(self._id_136F2, var_2);
    _id_12E64(self._id_119A2, var_2);
    _id_12E64(self._id_11B3D, var_2);
    _id_12E64(self.armor_piercing, var_2);
    _id_12E64(self.heli_boss, var_2);
    _id_12E64(self._id_1472B, var_2);

    if(!istrue(level._id_11EB9))
      _id_12E64(self._id_136DA, var_2);
  }
}
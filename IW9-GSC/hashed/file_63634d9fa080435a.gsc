/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_63634d9fa080435a.gsc
***********************************************/

_id_D45FD98510D7B7E9() {
  _id_F7B6CC6C062A7A43 = "super_high_jump_activate";

  if(getdvarint("dvar_A6321FC4DC1000D7", 1))
    _id_F7B6CC6C062A7A43 = _id_F7B6CC6C062A7A43 + "_alt";

  thread scripts\mp\hud_message::showsplash(_id_F7B6CC6C062A7A43, undefined, self, undefined, undefined, undefined, 1);
  _id_6C9D93D4584E15F7 = spawnStruct();
  _id_AF06892358A3C2F4 = 200;
  _id_6C9D93D4584E15F7.cooldownsec = getdvarint("dvar_E45CB58AA0483DCF", 4);
  _id_6C9D93D4584E15F7.ref = "super_jump";
  _id_B7C365B268301285 = getdvarint("dvar_2A0C18157B681884", 0);

  if(!_id_B7C365B268301285)
    self setclientomnvar("ui_super_high_jump_progress", 0);
  else
    _id_6C9D93D4584E15F7._id_94480E1669B7FF0D = playerpowersaddhudelem(&"MP_ZXP/CHARGED_JUMP", _id_AF06892358A3C2F4);

  self._id_6C9D93D4584E15F7 = _id_6C9D93D4584E15F7;
  _id_81BCD427F4C45B5D = scripts\cp_mp\utility\player_utility::_id_44D612709F857370;

  if(getdvarint("dvar_A6321FC4DC1000D7", 1))
    _id_81BCD427F4C45B5D = scripts\cp_mp\utility\player_utility::_id_1551F039785A297D;
  else
    _id_BD0E084AFB0D192F(1);

  thread _id_6A991BFD08EA6FC5();
  thread _id_856A49AD2900CFF6();
  thread _id_01A0B6D22FD3A0BA(_id_81BCD427F4C45B5D);
  thread _id_2A8B83E2773640C0();
  thread _id_4291EEDAA7D05E6D();
  return 1;
}

_id_8BEA7151CF43738D() {
  return _id_E0A9DAA14C0B948B();
}

_id_FF475E7670D47F79() {
  if(self isonground() || !self isonground())
    return 1;

  if(self _meth_E40102956C887F7C())
    return 1;

  if(self isonladder())
    return 1;

  if(self _meth_415FE9EECA7B2E2B())
    return 1;

  if(isDefined(self.vehicle))
    return 1;

  if(isDefined(self getmovingplatformparent()))
    return 1;

  return 0;
}

_id_E0A9DAA14C0B948B() {
  self endon("disconnect");

  while(!_id_FF475E7670D47F79() && scripts\mp\utility\player::isreallyalive(self))
    wait 0.1;

  thread _id_E4470E4135F2AACC();
  _id_B7C365B268301285 = getdvarint("dvar_2A0C18157B681884", 0);

  if(_id_B7C365B268301285) {
    self._id_6C9D93D4584E15F7._id_94480E1669B7FF0D.barelem scripts\mp\hud_util::destroyelem();
    self._id_6C9D93D4584E15F7._id_94480E1669B7FF0D scripts\mp\hud_util::destroyelem();
  } else {
    self setclientomnvar("ui_super_high_jump_progress", -1);
    self setclientomnvar("ui_field_upgrade_use", 0);
  }

  self._id_6C9D93D4584E15F7 = undefined;
  _id_BD0E084AFB0D192F(0);
  self notify("superJump_end");
  thread _id_104E3370B024F998::_id_269B97F3D86EB172(undefined, undefined, "super_use_finished");
}

_id_E4470E4135F2AACC() {
  self endon("disconnect");
  level endon("game_ended");

  if(!self isonground() && !self _meth_E40102956C887F7C()) {
    self._id_B6AA5954BF6A457A = 1;

    while(scripts\mp\utility\player::_id_AD443BBCDCF37B85(self)) {
      if(self isonground()) {
        waitframe();
        break;
      }

      waitframe();
    }
  }

  self._id_B6AA5954BF6A457A = undefined;
}

_id_4291EEDAA7D05E6D() {
  scripts\engine\utility::waittill_any_5("death", "last_stand_start", "player_killed", "tempV_end");
}

_id_BD0E084AFB0D192F(isactive) {
  if(isactive)
    _id_3B64EB40368C1450::set("jump_superpower", "allow_jump", 0);
  else
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("jump_superpower");
}

_id_01A0B6D22FD3A0BA(_id_81BCD427F4C45B5D) {
  self endon("superJump_end");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    if(self[[_id_81BCD427F4C45B5D]]() && !istrue(self._id_6C9D93D4584E15F7.incooldown)) {
      _id_567BDE1E6ACC007B(undefined, undefined, _id_81BCD427F4C45B5D);
      continue;
    }

    waitframe();
  }
}

_id_2A8B83E2773640C0() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self endon("superJump_end");

  for(;;) {
    self waittill("perform_hero_drop");
    self radiusdamage(self.origin, 256, _id_751F1FE07D7BF833(), 50, self, "MOD_CRUSH", "high_jump_mp");
    thread _id_F5F070B3D96A1C1E();
  }
}

_id_751F1FE07D7BF833() {
  if(!isDefined(self._id_6C9D93D4584E15F7) || !isDefined(self._id_6C9D93D4584E15F7._id_501056BCDA9531C2))
    return 50;

  _id_4CA7B6A31270C32A = getdvarfloat("dvar_710B8F0737994439", 3);
  _id_8A3EBC608BE39514 = clamp(self._id_6C9D93D4584E15F7._id_501056BCDA9531C2 / _id_4CA7B6A31270C32A, 0, 1);
  return 500 * _id_8A3EBC608BE39514;
}

_id_F5F070B3D96A1C1E() {
  self endon("disconnect");
  level endon("game_ended");
  self setscriptablepartstate("heroDiveVfx", "impact", 0);
  wait 1;
  self setscriptablepartstate("heroDiveVfx", "off", 0);
}

_id_567BDE1E6ACC007B(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB, _id_81BCD427F4C45B5D) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("tempV_end");
  _id_2C602BB60DAB6883 = 0.09;
  _id_EA41C3F0BDBF3F3A = 0;
  _id_A2D1E16B613B535C = 0;
  _id_92B09CF3A4719720 = 1300;
  _id_3B3681F0D6AAE16E = 0.2;
  _id_47784F0C32FA1AE1 = 1;
  _id_4CA6E232B3A08AE5 = -1.0;
  _id_943D5ECBD9A29E50 = getdvarint("dvar_5E1D6A08A06AAB7A", _id_EA41C3F0BDBF3F3A);
  _id_57BD73D0ECAEE169 = getdvarfloat("dvar_2FC6C2DC7F9C722A", _id_2C602BB60DAB6883);
  _id_EEC1CA5327266614 = getdvarfloat("dvar_F3ADFE2BA0C4E72E", _id_3B3681F0D6AAE16E);
  _id_E5482B00771C4909 = getdvarint("dvar_2A5201CCBCD3B1A1", _id_47784F0C32FA1AE1);
  _id_6B00AA3867C7F0D9 = getdvarint("dvar_69111E35067F9D8F", _id_4CA6E232B3A08AE5);
  _id_F71D03F58AF1672A = getdvarfloat("dvar_FD6822A1C2607510", _id_92B09CF3A4719720);
  _id_B7C365B268301285 = getdvarint("dvar_2A0C18157B681884", 0);

  while(!self[[_id_81BCD427F4C45B5D]]())
    waitframe();

  _id_FFDFC86379CFC071 = getdvarint("dvar_7C6A7CE1709F1EFF", _id_A2D1E16B613B535C);

  if(_id_FFDFC86379CFC071) {
    self._id_C561B8C04B423CBD = spawn("script_model", self.origin);
    self._id_C561B8C04B423CBD setModel("tag_player");
    self playerlinkTo(self._id_C561B8C04B423CBD, "tag_player");
  }

  self._id_19191156B87B7CD4 = 1;
  _id_3D3F9FB3BC8C8626 = undefined;

  if(_id_B7C365B268301285)
    _id_3D3F9FB3BC8C8626 = self._id_6C9D93D4584E15F7._id_94480E1669B7FF0D.barelem;

  fraction = 0.0;
  up = 1;
  _id_715D7709363E068C = undefined;

  while(self[[_id_81BCD427F4C45B5D]]()) {
    if(_id_B7C365B268301285)
      _id_3D3F9FB3BC8C8626 scripts\mp\hud_util::updatebar(fraction, 0);
    else
      self setclientomnvar("ui_super_high_jump_progress", fraction);

    _id_9D6D9B43B9128E64 = fraction;

    if(up) {
      if(_id_EDA9454EFB18ADFE()) {
        self setscriptablepartstate("heroDiveVfx", "charge_pause", 0);
        waitframe();
        continue;
      } else if(_id_6653AD92A0329507())
        up = 0;
      else {
        self setscriptablepartstate("heroDiveVfx", "charge_begin", 0);
        fraction = fraction + _id_57BD73D0ECAEE169;

        if(fraction >= 1) {
          fraction = 1.0;

          if(_id_943D5ECBD9A29E50)
            up = 0;
          else if(_id_6B00AA3867C7F0D9 >= 0) {
            if(!isDefined(_id_715D7709363E068C)) {
              _id_715D7709363E068C = gettime() + _id_6B00AA3867C7F0D9 * 1000;
              thread playerzombiejumpmaxholdwarning(_id_EF7579BE51267BDB, _id_6B00AA3867C7F0D9);
            }

            if(gettime() >= _id_715D7709363E068C) {
              break;
            }
          }
        }

        if(_id_9D6D9B43B9128E64 < _id_EEC1CA5327266614 && fraction >= _id_EEC1CA5327266614 && _id_B7C365B268301285)
          _id_3D3F9FB3BC8C8626.bar.color = (0, 1, 0);
      }
    } else {
      self setscriptablepartstate("heroDiveVfx", "charge_fail", 0);
      fraction = fraction - _id_57BD73D0ECAEE169;

      if(fraction <= 0) {
        fraction = 0.0;
        up = 1;
      }

      if(_id_B7C365B268301285 && _id_9D6D9B43B9128E64 > _id_EEC1CA5327266614 && fraction <= _id_EEC1CA5327266614)
        _id_3D3F9FB3BC8C8626.bar.color = (1, 1, 1);
    }

    waitframe();
  }

  self notify("jumpChargeEnd");

  if(_id_FFDFC86379CFC071)
    self unlink();

  _id_CB0C533702ADEE19 = _id_D2667047A1186849();

  if(fraction >= _id_EEC1CA5327266614 && _id_CB0C533702ADEE19) {
    if(fraction < 0.33)
      self setscriptablepartstate("heroDiveVfx", "jump_begin_small", 0);
    else if(fraction < 0.66)
      self setscriptablepartstate("heroDiveVfx", "jump_begin_med", 0);
    else
      self setscriptablepartstate("heroDiveVfx", "jump_begin_lrg", 0);

    _id_DEE6508B0BA437C5 = self getplayerangles();
    self setscriptablepartstate("heroDiveVfx", "jump_begin", 0);
    playerapplyjumpvelocity(_id_DEE6508B0BA437C5, _id_F71D03F58AF1672A, fraction);
  } else {
    self setscriptablepartstate("heroDiveVfx", "charge_fail", 0);

    if(_id_E5482B00771C4909) {
      if(_id_B7C365B268301285)
        _id_3D3F9FB3BC8C8626.bar.frac = 0;
      else {
        self setclientomnvar("ui_super_high_jump_progress", 0);
        self setclientomnvar("ui_super_jump_cooldown", 0);
      }
    }
  }

  _id_D59D137D348A395D(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB, 1);
}

_id_55CE74E815A78A70() {
  return !_id_D2667047A1186849();
}

_id_D2667047A1186849() {
  if(self isinexecutionattack() || self isinexecutionvictim())
    return 0;

  if(self ismantling())
    return 0;

  if(self _meth_9CC921A57FF4DEB5())
    return 0;

  if(self isonladder())
    return 0;

  if(self _meth_415FE9EECA7B2E2B())
    return 0;

  if(!self isonground() && !_id_0C3613D04F19E8DE() || self _meth_E40102956C887F7C())
    return 0;

  if(!scripts\mp\utility\player::_id_AD443BBCDCF37B85(self))
    return 0;

  if(self getstance() == "prone")
    return 0;

  if(isDefined(self.carryobject))
    return 0;

  if(scripts\cp_mp\utility\player_utility::_id_B7869F6D9D4242E3(self))
    return 0;

  if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("allow_super_jump"))
    return 0;

  _id_E880AF5898EC6FD1 = scripts\mp\utility\player::getstancetop();
  radius = getdvarint("dvar_947314490033F015", 14);
  _id_4E18BF6F5EEEE2F0 = scripts\mp\utility\player::getstancetop() + anglestoup(self.angles) * 100;
  contents = scripts\engine\trace::create_default_contents(1);

  if(!scripts\engine\trace::sphere_trace_passed(_id_E880AF5898EC6FD1, _id_4E18BF6F5EEEE2F0, radius, self, contents))
    return 0;

  return 1;
}

_id_6653AD92A0329507() {
  if(self isinexecutionattack() || self isinexecutionvictim())
    return 1;

  if(self _meth_415FE9EECA7B2E2B())
    return 1;

  if(self isonladder())
    return 1;

  if(!self isonground() && !_id_0C3613D04F19E8DE() || self _meth_E40102956C887F7C())
    return 1;

  if(!scripts\mp\utility\player::_id_AD443BBCDCF37B85(self))
    return 1;

  if(self _meth_9CC921A57FF4DEB5())
    return 1;

  if(isDefined(self.carryobject))
    return 1;

  return 0;
}

_id_EDA9454EFB18ADFE() {
  if(self ismantling())
    return 1;

  if(self getstance() == "prone")
    return 1;

  return 0;
}

playerpowersaddhudelem(label, currenthudy) {
  _id_94480E1669B7FF0D = scripts\mp\hud_util::createfontstring("default", 1.5);
  _id_94480E1669B7FF0D.alignx = "left";
  _id_94480E1669B7FF0D.aligny = "top";
  _id_94480E1669B7FF0D.horzalign = "left_adjustable";
  _id_94480E1669B7FF0D.vertalign = "top_adjustable";
  _id_94480E1669B7FF0D.alpha = 1;
  _id_94480E1669B7FF0D.glowalpha = 0;
  _id_94480E1669B7FF0D.hidewheninmenu = 1;
  _id_94480E1669B7FF0D.archived = 0;

  if(isDefined(label))
    _id_94480E1669B7FF0D.label = label;

  barelem = scripts\mp\hud_util::createbar((1, 1, 1), 160, 14);
  barelem.x = 13;
  barelem.y = currenthudy;
  barelem.alignx = "left";
  barelem.aligny = "top";
  barelem.horzalign = "left_adjustable";
  barelem.vertalign = "top_adjustable";
  barelem shiftbar();
  barelem.archived = 0;
  barelem.hidewheninmenu = 1;
  barelem.bar.archived = 0;
  barelem.bar.hidewheninmenu = 1;
  _id_94480E1669B7FF0D.barelem = barelem;
  return _id_94480E1669B7FF0D;
}

shiftbar(point, relativepoint, xoffset, yoffset) {
  self.bar.horzalign = self.horzalign;
  self.bar.vertalign = self.vertalign;
  self.bar.alignx = "left";
  self.bar.aligny = self.aligny;
  self.bar.y = self.y + 2;
  self.bar.x = self.x + 2;
  scripts\mp\hud_util::updatebar(self.bar.frac);
}

playerzombiejumpmaxholdwarning(_id_EF7579BE51267BDB, time) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  self endon("playerZombieJumpStop");
  self endon("jumpChargeEnd");

  if(time <= 0) {
    return;
  }
  _id_3D3F9FB3BC8C8626 = self._id_6C9D93D4584E15F7._id_94480E1669B7FF0D.barelem;
  _id_2C728360E4C9326A = _id_2695A20D4011076D::array_init_distribute(time, int(time * 5), 1);
  color = 1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2C728360E4C9326A.size; _id_AC0E594AC96AA3A8++) {
    if(color)
      _id_3D3F9FB3BC8C8626.bar.color = (1, 0, 0);
    else
      _id_3D3F9FB3BC8C8626.bar.color = (0, 1, 0);

    wait(_id_2C728360E4C9326A[_id_AC0E594AC96AA3A8]);
    color = !color;
  }
}

playerapplyjumpvelocity(_id_44AAE8E966034513, _id_F71D03F58AF1672A, fraction) {
  _id_355760D151D56E05 = 1;
  _id_DEE6508B0BA437C5 = _id_44AAE8E966034513;
  _id_A6F73A56325293DB = vectorNormalize(self getvelocity());
  _id_68FD30DB511477F5 = anglesToForward(self.angles);
  dot = vectordot(_id_A6F73A56325293DB, _id_68FD30DB511477F5);
  _id_0441B8B8D8D1BBE0 = dot > 0.875 || dot == 0;

  if(!_id_0441B8B8D8D1BBE0) {
    _id_5A2182BEDEBA5ED9 = vectortoangles(_id_A6F73A56325293DB);
    _id_DEE6508B0BA437C5 = (_id_DEE6508B0BA437C5[0], _id_5A2182BEDEBA5ED9[1], _id_5A2182BEDEBA5ED9[2]);
  }

  if(getdvarint("dvar_CE6D7D66848CDBCC", _id_355760D151D56E05)) {
    _id_AA4EA3B3807E1650 = get_ground_normal();

    if(!isDefined(_id_AA4EA3B3807E1650))
      _id_AA4EA3B3807E1650 = (0, 0, 1);

    _id_0A2A227242F2C364 = (0, _id_DEE6508B0BA437C5[1], 0);
    right = anglestoright(_id_0A2A227242F2C364);
    fwd = vectorcross(_id_AA4EA3B3807E1650, right);
    _id_19AE114150BFC887 = vectortoangles(fwd);
    _id_B184911D23195923 = _id_19AE114150BFC887[0];
    _id_98B04C3F8A107752 = -85;
    _id_5A112B1311CF05E5 = _id_DEE6508B0BA437C5[0];

    if(_id_B184911D23195923 > 90 || _id_B184911D23195923 < -90)
      _id_B184911D23195923 = -90 - _id_B184911D23195923 % 90 * -1;

    _id_9D83796E5DFB9A1C = _id_B184911D23195923;

    if(_id_5A112B1311CF05E5 > _id_B184911D23195923)
      _id_5A112B1311CF05E5 = _id_B184911D23195923;

    _id_E6BC250926C6D64D = getdvarfloat("dvar_9EC479015407C245", -45.0);
    _id_E6980F09269E2B33 = getdvarfloat("dvar_9EE78301542E1FFB", 0.0);
    frac = (_id_5A112B1311CF05E5 - _id_98B04C3F8A107752) / (_id_9D83796E5DFB9A1C - _id_98B04C3F8A107752);
    _id_AEE49E405BF58492 = _id_E6980F09269E2B33 + frac * (_id_E6BC250926C6D64D - _id_E6980F09269E2B33);
    _id_DEE6508B0BA437C5 = (_id_5A112B1311CF05E5 + _id_AEE49E405BF58492, _id_DEE6508B0BA437C5[1], _id_DEE6508B0BA437C5[2]);
  }

  _id_179DB9ACB8F30E85 = getdvarfloat("dvar_CF56037C34EA141F", 0.0);

  if(_id_179DB9ACB8F30E85 != 0.0)
    _id_DEE6508B0BA437C5 = (_id_DEE6508B0BA437C5[0] + _id_179DB9ACB8F30E85, _id_DEE6508B0BA437C5[1], _id_DEE6508B0BA437C5[2]);

  dir = anglesToForward(_id_DEE6508B0BA437C5);
  velocity = dir * fraction * _id_F71D03F58AF1672A;
  self setOrigin(self.origin + (0, 0, 20));
  self setvelocity(velocity);
}

_id_D59D137D348A395D(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB, _id_1FC7E7DDBA5D5771) {
  if(istrue(_id_1FC7E7DDBA5D5771))
    thread playerpowerstartcooldown(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB);

  if(isDefined(self._id_C561B8C04B423CBD))
    self._id_C561B8C04B423CBD delete();

  self._id_19191156B87B7CD4 = undefined;
}

playerpowerstartcooldown(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("tempV_unset");
  self endon("tempV_set");
  self endon("superJump_end");
  self endon("disableCooldown");

  if(!isDefined(self._id_6C9D93D4584E15F7) || istrue(self._id_6C9D93D4584E15F7.incooldown)) {
    return;
  }
  _id_B7C365B268301285 = getdvarint("dvar_2A0C18157B681884", 0);
  cooldownsec = self._id_6C9D93D4584E15F7.cooldownsec;

  if(_id_B7C365B268301285) {
    _id_D671E5BEFA0CFAE3 = self._id_6C9D93D4584E15F7._id_94480E1669B7FF0D.barelem;

    if(_id_D671E5BEFA0CFAE3.bar.frac > 0) {
      self._id_6C9D93D4584E15F7.incooldown = 1;
      fraction = _id_D671E5BEFA0CFAE3.bar.frac;
      cooldownsec = cooldownsec * fraction;
      _id_D671E5BEFA0CFAE3.bar.color = (1, 0.6, 0);
      _id_D671E5BEFA0CFAE3.bar scaleovertime(cooldownsec, 0, _id_D671E5BEFA0CFAE3.height);
      wait(cooldownsec);

      if(!getdvarint("dvar_A6321FC4DC1000D7", 1))
        _id_BD0E084AFB0D192F(1);

      self._id_6C9D93D4584E15F7.incooldown = 0;
      self notify("superJump_cooldownEnd");
    } else
      _id_D671E5BEFA0CFAE3 scripts\mp\hud_util::updatebar(0, 0);

    _id_D671E5BEFA0CFAE3.bar.color = (1, 1, 1);
  } else {
    _id_AA13DCDDA08434C5 = self getclientomnvar("ui_super_high_jump_progress");
    self setclientomnvar("ui_super_jump_cooldown", 1);

    if(_id_AA13DCDDA08434C5 > 0) {
      self._id_6C9D93D4584E15F7.incooldown = 1;
      cooldownsec = cooldownsec * _id_AA13DCDDA08434C5;
      _id_E10D2077EF53FE8A = int(ceil(cooldownsec / 0.05));
      _id_EC4125A1120F6A76 = _id_AA13DCDDA08434C5 / _id_E10D2077EF53FE8A;

      while(_id_E10D2077EF53FE8A && _id_AA13DCDDA08434C5 > 0) {
        self setclientomnvar("ui_super_high_jump_progress", _id_AA13DCDDA08434C5);
        _id_E10D2077EF53FE8A--;
        _id_AA13DCDDA08434C5 = _id_AA13DCDDA08434C5 - _id_EC4125A1120F6A76;
        waitframe();

        if(!getdvarint("dvar_A6321FC4DC1000D7", 1))
          _id_BD0E084AFB0D192F(1);
      }

      self setclientomnvar("ui_super_high_jump_progress", 0);
      self setclientomnvar("ui_super_jump_cooldown", 0);

      if(!getdvarint("dvar_A6321FC4DC1000D7", 1))
        _id_BD0E084AFB0D192F(1);

      self._id_6C9D93D4584E15F7.incooldown = 0;
      self notify("superJump_cooldownEnd");
    } else {
      self setclientomnvar("ui_super_high_jump_progress", 0);
      self setclientomnvar("ui_super_jump_cooldown", 0);
    }
  }
}

get_ground_normal(_id_31CAEF840B7AC074, debug) {
  if(!isDefined(_id_31CAEF840B7AC074))
    ignore = self;
  else
    ignore = _id_31CAEF840B7AC074;

  if(!isDefined(debug))
    debug = 0;

  ignorelist = [ignore];
  _id_D895C679F6A927E5 = [self.origin];

  for(_id_AC0E594AC96AA3A8 = -1.0; _id_AC0E594AC96AA3A8 <= 1.0; _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + 2.0) {
    for(_id_AC0E5C4AC96AAA41 = -1.0; _id_AC0E5C4AC96AAA41 <= 1.0; _id_AC0E5C4AC96AAA41 = _id_AC0E5C4AC96AAA41 + 2.0) {
      _id_4E6D9BE609009734 = ignore getpointinbounds(_id_AC0E594AC96AA3A8, _id_AC0E5C4AC96AAA41, 0.0);
      _id_4E6D9BE609009734 = (_id_4E6D9BE609009734[0], _id_4E6D9BE609009734[1], self.origin[2]);
      _id_D895C679F6A927E5[_id_D895C679F6A927E5.size] = _id_4E6D9BE609009734;
    }
  }

  _id_F863280C4EB41018 = (0, 0, 0);
  _id_97D8F5A9EB04C1F2 = 0;

  foreach(point in _id_D895C679F6A927E5) {
    trace = scripts\engine\trace::_bullet_trace(point + (0, 0, 4), point + (0, 0, -16), 0, ignorelist);
    _id_B68850986D4C6C13 = trace["fraction"] > 0.0 && trace["fraction"] < 1;

    if(_id_B68850986D4C6C13) {
      _id_F863280C4EB41018 = _id_F863280C4EB41018 + trace["normal"];
      _id_97D8F5A9EB04C1F2++;
    }
  }

  if(_id_97D8F5A9EB04C1F2 > 0) {
    _id_F863280C4EB41018 = _id_F863280C4EB41018 / _id_97D8F5A9EB04C1F2;
    return _id_F863280C4EB41018;
  } else
    return undefined;
}

_id_C0D0374F0A3D354E() {
  level endon("game_ended");
  self endon("death_or_disconnect");
}

_id_95ADB84C5CA51C36() {
  return isDefined(self._id_6C9D93D4584E15F7) && isDefined(self._id_6C9D93D4584E15F7.ref) && istrue(self._id_6C9D93D4584E15F7.ref == "super_jump");
}

_id_3A307FD8EB4F27EB() {
  if(self isskydiving())
    self skydive_interrupt();

  self notify("perform_hero_drop");
  return 0;
}

_id_856A49AD2900CFF6() {
  self endon("death_or_disconnect");
  self endon("superJump_end");
  level endon("game_ended");

  if(!isDefined(self._id_6C9D93D4584E15F7)) {
    return;
  }
  self._id_6C9D93D4584E15F7._id_501056BCDA9531C2 = 0;
  _id_9337100AA8DE2451 = 0;
  _id_62601C1642480674 = 0;

  while(isDefined(self._id_6C9D93D4584E15F7)) {
    if(self isonground() || self isparachuting()) {
      if(self isonground() && !_id_62601C1642480674) {
        _id_62601C1642480674 = 1;
        _id_3B64EB40368C1450::set("jump_superpower", "usability", 1);
        _id_3B64EB40368C1450::set("jump_superpower", "allow_jump", 1);
      }

      if(self._id_6C9D93D4584E15F7._id_501056BCDA9531C2 > 0) {
        if(_id_9337100AA8DE2451 >= 3)
          self._id_6C9D93D4584E15F7._id_501056BCDA9531C2 = 0;
        else
          _id_9337100AA8DE2451++;

        waitframe();
        continue;
      }
    } else {
      _id_9337100AA8DE2451 = 0;
      self._id_6C9D93D4584E15F7._id_501056BCDA9531C2 = self._id_6C9D93D4584E15F7._id_501056BCDA9531C2 + level.framedurationseconds;

      if(_id_62601C1642480674) {
        _id_62601C1642480674 = 0;
        _id_3B64EB40368C1450::set("jump_superpower", "usability", 0);
        _id_3B64EB40368C1450::set("jump_superpower", "allow_jump", 0);
      }
    }

    waitframe();
  }

  if(!getdvarint("dvar_A6321FC4DC1000D7", 1))
    _id_BD0E084AFB0D192F(0);
}

_id_6A991BFD08EA6FC5() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("superJump_end");
  self endon("temp_v_finished");

  if(getdvarint("dvar_A6321FC4DC1000D7", 1)) {
    return;
  }
  for(;;) {
    if(self isonladder() || self _meth_415FE9EECA7B2E2B())
      _id_BD0E084AFB0D192F(0);
    else
      _id_BD0E084AFB0D192F(1);

    waitframe();
  }
}

_id_0C3613D04F19E8DE() {
  if(!isDefined(self._id_6C9D93D4584E15F7) || !isDefined(self._id_6C9D93D4584E15F7._id_501056BCDA9531C2))
    return 0;

  return self._id_6C9D93D4584E15F7._id_501056BCDA9531C2 <= getdvarint("dvar_602C04DB38C463C9", 1.0);
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\player_flashlight.gsc
***********************************************/

_id_041B2475A04910BA() {
  level._effect["1st_person_flashlight"] = loadfx("vfx/iw9/cp/vfx_helmet_bright_light_player.vfx");
  level._effect["3rd_person_flashlight"] = loadfx("vfx/iw9/core/flashlight/vfx_flashlight_3rd_person.vfx");
}

_id_B9B3106C0CEF675E() {
  self endon("disconnect");
  wait 0.5;
  thread toggle_flashlight(1);
}

toggle_flashlight(enable) {
  if(!isDefined(self) || !isPlayer(self) || !isalive(self)) {
    return;
  }
  if(!isDefined(enable))
    enable = !isDefined(self._id_4AAD4F06D972E6B2);

  if(enable) {
    if(isDefined(self._id_4AAD4F06D972E6B2)) {
      return;
    }
    if(_id_54846D3AA2D31163()) {
      return;
    }
    thread scripts\cp\utility::playerplaypickupanim("iw9_vm_ges_helmet_light");
    thread flashlight_on();
  } else {
    if(!isDefined(self._id_4AAD4F06D972E6B2)) {
      return;
    }
    if(_id_54846D3AA2D31163()) {
      return;
    }
    thread flashlight_off();
  }
}

_id_CBFCB92384926A17(_id_4A626586E20B384D, delay) {
  if(istrue(_id_4A626586E20B384D)) {
    if(!isDefined(self._id_4AAD4F06D972E6B2))
      return;
  }

  _id_11234B46506E4213 = 3;

  if(!isDefined(delay))
    delay = _id_11234B46506E4213;

  if(delay < _id_11234B46506E4213)
    delay = _id_11234B46506E4213;

  toggle_flashlight();
  wait(delay);
  toggle_flashlight();
}

flashlight_on(ent, tag) {
  self playlocalsound("weap_variable_scope_click");
  self._id_4AAD4F06D972E6B2 = 1;

  if(!isDefined(self._id_CAD18C06D2FAD5C2)) {
    self._id_CAD18C06D2FAD5C2 = spawn("script_model", self.origin);
    self._id_CAD18C06D2FAD5C2 setModel("tag_origin");
    self._id_CAD18C06D2FAD5C2.angles = self.angles;
    self._id_CAD18C06D2FAD5C2 linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  }

  if(!isDefined(self._id_0D10DAD930A698F9)) {
    self._id_0D10DAD930A698F9 = spawn("script_model", self.origin);
    self._id_0D10DAD930A698F9 setModel("tag_origin");
    self._id_0D10DAD930A698F9.angles = self.angles;
    self._id_0D10DAD930A698F9 linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  }

  wait 0.1;

  if(!isDefined(level._id_219755583DC9479B))
    level._id_219755583DC9479B = 0;

  thread _id_75D93EDF3E7E2B10();
  thread _id_638EE621FF6023D2();
}

flashlight_off(ent, tag) {
  self notify("turn_off_flashlight");
  self playlocalsound("weap_variable_scope_click");
  wait 0.1;

  if(isDefined(self._id_CAD18C06D2FAD5C2))
    self._id_CAD18C06D2FAD5C2 delete();

  if(isDefined(self._id_0D10DAD930A698F9))
    self._id_0D10DAD930A698F9 delete();

  self._id_4AAD4F06D972E6B2 = undefined;
}

_id_B7F79CECB63FF5BC(player, _id_25BBC3661DFE101E) {
  _id_DD1D08B0C203D5CE = player _meth_C1092F42B6BBE490();

  if(istrue(_id_25BBC3661DFE101E))
    _id_25622A3C0A7EB960 = !_id_DD1D08B0C203D5CE;
  else
    _id_25622A3C0A7EB960 = _id_DD1D08B0C203D5CE;

  if(istrue(_id_25622A3C0A7EB960)) {
    player._id_CAD18C06D2FAD5C2 hide();
    player._id_0D10DAD930A698F9 show();
    wait 0.1;
    playFXOnTag(level._effect["3rd_person_flashlight"], player._id_0D10DAD930A698F9, "tag_origin");
  } else {
    player._id_CAD18C06D2FAD5C2 show();

    foreach(_id_6EE5484560EC747C in level.players) {
      if(player != _id_6EE5484560EC747C)
        player._id_0D10DAD930A698F9 showtoplayer(_id_6EE5484560EC747C);
    }

    wait 0.1;

    foreach(_id_6EE5484560EC747C in level.players) {
      if(player != _id_6EE5484560EC747C)
        playfxontagforclients(level._effect["3rd_person_flashlight"], player._id_0D10DAD930A698F9, "tag_origin", _id_6EE5484560EC747C);
    }

    playfxontagforclients(level._effect["1st_person_flashlight"], player._id_CAD18C06D2FAD5C2, "tag_origin", player);
  }
}

_id_41C3302121BE1A40() {
  player = self;
  _id_DD1D08B0C203D5CE = player _meth_C1092F42B6BBE490();

  if(istrue(_id_DD1D08B0C203D5CE)) {
    player._id_CAD18C06D2FAD5C2 hide();
    player._id_0D10DAD930A698F9 show();
    wait 0.1;
    playFXOnTag(level._effect["3rd_person_flashlight"], player._id_0D10DAD930A698F9, "tag_origin");
  } else {
    player._id_CAD18C06D2FAD5C2 show();

    foreach(_id_6EE5484560EC747C in level.players) {
      if(player != _id_6EE5484560EC747C)
        player._id_0D10DAD930A698F9 showtoplayer(_id_6EE5484560EC747C);
    }

    wait 0.1;

    foreach(_id_6EE5484560EC747C in level.players) {
      if(player != _id_6EE5484560EC747C)
        playfxontagforclients(level._effect["3rd_person_flashlight"], player._id_0D10DAD930A698F9, "tag_origin", _id_6EE5484560EC747C);
    }

    playfxontagforclients(level._effect["1st_person_flashlight"], player._id_CAD18C06D2FAD5C2, "tag_origin", player);
  }
}

_id_75D93EDF3E7E2B10() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("turn_off_flashlight");
  _id_55870452E821A3C1 = undefined;

  for(;;) {
    if(self tagexists("TAG_helmetlight"))
      self._id_CAD18C06D2FAD5C2 linkTo(self, "TAG_helmetlight", (0, 0, 0), (0, 0, 0));
    else if(self tagexists("j_helmet"))
      self._id_CAD18C06D2FAD5C2 linkTo(self, "j_helmet", (0, 0, 0), (0, 0, 0));
    else if(self tagexists("tag_helmet"))
      self._id_CAD18C06D2FAD5C2 linkTo(self, "tag_helmet", (0, 0, 0), (0, 0, 0));
    else
      self._id_CAD18C06D2FAD5C2 linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));

    if(self tagexists("J_Shoulder_LE")) {
      if(isDefined(self.currentprimaryweapon)) {
        if(self.currentprimaryweapon.basename == "iw9_me_pushfists")
          self._id_0D10DAD930A698F9 linkTo(self, "tag_helmetlight", (-5, 0, 5), (0, 0, 0));
        else if(self.currentprimaryweapon.basename == "iw9_oxygenmask")
          self._id_0D10DAD930A698F9 linkTo(self, "tag_origin", (0, 0, 60), (0, 0, 0));
        else
          self._id_0D10DAD930A698F9 linkTo(self, "J_Shoulder_LE", (0, 10, -5), (-25, -15, 0));
      } else if(isDefined(self.prevweaponobj)) {
        if(self.prevweaponobj.basename == "iw9_me_riotshield_mp")
          self._id_0D10DAD930A698F9 linkTo(self, "tag_origin", (0, 20, 0), (0, 0, 0));
        else if(self.prevweaponobj.basename == "iw9_oxygenmask")
          self._id_0D10DAD930A698F9 linkTo(self, "tag_origin", (0, 0, 70), (0, 0, 0));
        else
          self._id_0D10DAD930A698F9 linkTo(self, "J_Shoulder_LE", (0, 10, -5), (-25, -15, 0));
      } else
        self._id_0D10DAD930A698F9 linkTo(self, "J_Shoulder_LE", (0, 10, -5), (-25, -15, 0));
    } else if(self tagexists("j_helmet"))
      self._id_0D10DAD930A698F9 linkTo(self, "j_helmet", (-5, -5, 0), (0, 270, 0));
    else if(self tagexists("tag_helmet"))
      self._id_0D10DAD930A698F9 linkTo(self, "tag_helmet", (-5, -5, 0), (0, 270, 0));
    else
      self._id_0D10DAD930A698F9 linkTo(self, "tag_origin", (0, 0, 0), (90, 0, 0));

    if(isDefined(_id_55870452E821A3C1)) {
      if(_id_55870452E821A3C1 != "toggled_third_person_camera") {
        if(isDefined(self.currentprimaryweapon.basename) && (self.currentprimaryweapon.basename == "iw9_me_pushfists" || self.currentprimaryweapon.basename == "none"))
          _id_B7F79CECB63FF5BC(self, 1);
        else
          _id_B7F79CECB63FF5BC(self, 0);
      } else
        _id_B7F79CECB63FF5BC(self, 1);
    } else
      _id_B7F79CECB63FF5BC(self, 0);

    _id_55870452E821A3C1 = scripts\engine\utility::waittill_any_return_4("toggled_third_person_camera", "pickedupweapon", "update_flashlight_tags");
  }
}

_id_638EE621FF6023D2() {
  self notify("flashlight_off_on_death");
  self endon("flashlight_off_on_death");
  self endon("disconnect");
  self waittill("death");

  if(!isDefined(self._id_4AAD4F06D972E6B2)) {
    return;
  }
  flashlight_off();
  self._id_4AAD4F06D972E6B2 = undefined;
}

_id_54846D3AA2D31163() {
  if(isDefined(self._id_1D66399E95195D21) && self._id_1D66399E95195D21 > gettime() - 200)
    return 1;

  self._id_1D66399E95195D21 = gettime();
  return 0;
}

_id_491A6611A0B52B99() {
  level._id_F2E48424BAEC7C2E = getEntArray("flashlight_trigger", "targetname");

  if(isDefined(level._id_F2E48424BAEC7C2E)) {
    foreach(trigger in level._id_F2E48424BAEC7C2E)
    trigger thread _id_7FCB92EFB596BD83();
  }
}

_id_7FCB92EFB596BD83() {
  if(isDefined(self.entstouching)) {
    return;
  }
  self.entstouching = [];
  thread _id_B106C5842F87BF13(self);
  thread _id_52A4935663B01117(self);
}

_id_52A4935663B01117(trigger) {
  level endon("game_ended");
  trigger notify("trigger_watchFlashlightTriggerEnter");
  trigger endon("trigger_watchFlashlightTriggerEnter");
  trigger endon("death");

  for(;;) {
    trigger waittill("trigger", ent);

    if(!_id_DC0A66796F616FCE(ent)) {
      continue;
    }
    _id_7DF3C090BEEE2450(trigger, ent);
  }
}

_id_B106C5842F87BF13(trigger) {
  level endon("game_ended");
  trigger notify("trigger_watchFlashlightTriggerExit");
  trigger endon("trigger_watchFlashlightTriggerExit");
  trigger endon("death");

  for(;;) {
    _id_5C397C9CF7A06802 = trigger.entstouching;

    foreach(id, ent in _id_5C397C9CF7A06802) {
      if(!isDefined(ent)) {
        trigger.entstouching[id] = undefined;
        continue;
      }

      _id_05956C54E54EBF3D = trigger istouching(ent);

      if(isPlayer(ent) && !isalive(ent))
        _id_05956C54E54EBF3D = 0;

      if(isDefined(ent) && !_id_05956C54E54EBF3D)
        _id_BD8F6ED981F07AAA(trigger, ent);
    }

    waitframe();
  }
}

_id_DC0A66796F616FCE(ent) {
  if(isDefined(ent)) {
    if(isPlayer(ent)) {
      if(ent scripts\cp_mp\utility\player_utility::_isalive())
        return 1;
    }
  }

  return 0;
}

_id_BD8F6ED981F07AAA(trigger, ent) {
  entnum = ent getentitynumber();
  trigger.entstouching[entnum] = undefined;

  if(!_id_05AA17B8039E280D(trigger, ent))
    ent thread toggle_flashlight(0);
}

_id_7DF3C090BEEE2450(trigger, ent) {
  entnum = ent getentitynumber();

  if(isDefined(trigger.entstouching[entnum])) {
    return;
  }
  trigger.entstouching[entnum] = ent;
  ent thread toggle_flashlight(1);
}

_id_05AA17B8039E280D(trigger, ent) {
  entnum = ent getentitynumber();

  foreach(_id_8DF8A9ED72C2BDAA in level._id_F2E48424BAEC7C2E) {
    if(_id_8DF8A9ED72C2BDAA == trigger) {
      continue;
    }
    if(isDefined(_id_8DF8A9ED72C2BDAA.entstouching[entnum]))
      return 1;
  }

  return 0;
}

_id_47F4F9F3FA1A644D() {
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Debug / CP Flashlight / Toggle Flashlight P1\" \"togglep scr_cpflashlightp1_toggle 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_E39637FEE7DC2C32", ::_id_692ED79CA5616C4E);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Debug / CP Flashlight / Toggle Flashlight P2\" \"togglep scr_cpflashlightp2_toggle 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_39097CBF328765F5", ::_id_692ED69CA5616A1B);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Debug / CP Flashlight / Toggle Flashlight P3\" \"togglep scr_cpflashlightp3_toggle 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_4E79247EFA17EC98", ::_id_692ED59CA56167E8);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Debug / CP Flashlight / Flash x4 Flashlight P1\" \"togglep scr_cpflashlightp1_flash 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_5AFBD1775CCD6B80", ::_id_D3810FCC0316553B);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Debug / CP Flashlight / Flash x4 Flashlight P2\" \"togglep scr_cpflashlightp2_flash 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_B70C1770B63FBA59", ::_id_33703DD50C607CCE);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Debug / CP Flashlight / Flash x4 Flashlight P3\" \"togglep scr_cpflashlightp3_flash 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_B3C0C4997D226C4E", ::_id_36BB90AC457DCAD9);
}

_id_692ED79CA5616C4E() {
  if(isDefined(level.players[0]))
    level.players[0] thread toggle_flashlight();
}

_id_692ED69CA5616A1B() {
  if(isDefined(level.players[1]))
    level.players[1] thread toggle_flashlight();
}

_id_692ED59CA56167E8() {
  if(isDefined(level.players[2]))
    level.players[2] thread toggle_flashlight();
}

_id_D3810FCC0316553B() {
  if(isDefined(level.players[0]))
    level.players[0] thread _id_F25F2E91DBD65167();
}

_id_33703DD50C607CCE() {
  if(isDefined(level.players[1]))
    level.players[1] thread _id_F25F2E91DBD65167();
}

_id_36BB90AC457DCAD9() {
  if(isDefined(level.players[2]))
    level.players[2] thread _id_F25F2E91DBD65167();
}

_id_F25F2E91DBD65167() {
  if(isDefined(self)) {
    announcement("flash 1 / 4, enable");
    thread toggle_flashlight();
    wait 3;
    announcement("flash 2 / 4, disable");
    thread toggle_flashlight();
    wait 3;
    announcement("flash 3 / 4, enable");
    thread toggle_flashlight();
    wait 3;
    announcement("flash 4 / 4, disable");
    thread toggle_flashlight();
  }
}
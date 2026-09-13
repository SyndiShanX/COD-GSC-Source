/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_232b17b3a8abc7dc.gsc
***********************************************/

init() {
  level._id_F707813A2FA1A53D = [];
  level._id_BC62DB1CDA14B969 = [];
  level._id_321D7C9EE241C055 = [];
}

_id_BE8E8B8FB21E050A(_id_AEEE319C47639FA9, _id_1C8CBA6B6772FB39, _id_07AD9D12FB2DAC97, _id_77CCA48D1D04B0B1) {
  init();
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("infil_complete");
  waitframe();

  if(!isDefined(_id_AEEE319C47639FA9) || !isarray(_id_AEEE319C47639FA9)) {
    return;
  }
  if(!isDefined(_id_1C8CBA6B6772FB39) || !isarray(_id_1C8CBA6B6772FB39)) {
    return;
  }
  foreach(obj in _id_AEEE319C47639FA9) {
    if(isstruct(obj)) {
      _id_D252637CA83F476A = _id_1247DAD478B96B07(obj, 1);
      level._id_BC62DB1CDA14B969 = scripts\engine\utility::array_add(level._id_BC62DB1CDA14B969, _id_D252637CA83F476A);
      level._id_F707813A2FA1A53D = scripts\engine\utility::array_add(level._id_F707813A2FA1A53D, _id_D252637CA83F476A);
      continue;
    }

    if(isent(obj)) {
      _id_D252637CA83F476A = _id_1247DAD478B96B07(obj, 0, 1, _id_07AD9D12FB2DAC97);
      level._id_BC62DB1CDA14B969 = scripts\engine\utility::array_add(level._id_BC62DB1CDA14B969, _id_D252637CA83F476A);
      level._id_F707813A2FA1A53D = scripts\engine\utility::array_add(level._id_F707813A2FA1A53D, _id_D252637CA83F476A);
    }
  }

  foreach(obj in _id_1C8CBA6B6772FB39) {
    if(isstruct(obj)) {
      _id_74899AF0A40F06DE = _id_1247DAD478B96B07(obj, 0);
      level._id_321D7C9EE241C055 = scripts\engine\utility::array_add(level._id_321D7C9EE241C055, _id_74899AF0A40F06DE);
      level._id_F707813A2FA1A53D = scripts\engine\utility::array_add(level._id_F707813A2FA1A53D, _id_74899AF0A40F06DE);
    } else if(isent(obj)) {
      _id_74899AF0A40F06DE = _id_1247DAD478B96B07(obj, 1, 1, _id_77CCA48D1D04B0B1);
      level._id_321D7C9EE241C055 = scripts\engine\utility::array_add(level._id_321D7C9EE241C055, _id_74899AF0A40F06DE);
      level._id_F707813A2FA1A53D = scripts\engine\utility::array_add(level._id_F707813A2FA1A53D, _id_74899AF0A40F06DE);
    }

    _id_23502CEE3FA89FC2::_id_03ACF5939A1DB7A7(obj);
  }
}

_id_1247DAD478B96B07(obj, _id_B3BA2D13FC1D315C, _id_23765D364C6D5F3E, model) {
  _id_11FA2985452AC8CF = undefined;

  if(!istrue(_id_23765D364C6D5F3E)) {
    _id_11FA2985452AC8CF = spawn("script_model", obj.origin);

    if(isDefined(obj.angles))
      _id_11FA2985452AC8CF.angles = obj.angles;
    else
      _id_11FA2985452AC8CF.angles = (0, 0, 0);

    if(isDefined(model))
      _id_11FA2985452AC8CF setModel(model);
    else
      _id_11FA2985452AC8CF setModel("container_nitrate_barrel_01");
  } else
    _id_11FA2985452AC8CF = obj;

  _id_11FA2985452AC8CF show();
  _id_11FA2985452AC8CF makeusable();
  _id_11FA2985452AC8CF setCursorHint("HINT_BUTTON");
  _id_11FA2985452AC8CF sethintdisplayrange(90);
  _id_11FA2985452AC8CF sethintdisplayfov(65);
  _id_11FA2985452AC8CF setuserange(90);
  _id_11FA2985452AC8CF setusefov(65);
  _id_11FA2985452AC8CF sethintonobstruction("show");
  _id_11FA2985452AC8CF setuseholdduration("duration_none");
  _id_11FA2985452AC8CF setHintString(&"CP_CONVOYS/LOOT_MARK");
  _id_11FA2985452AC8CF thread _id_34517AACE31A5F6B(_id_B3BA2D13FC1D315C);
  return _id_11FA2985452AC8CF;
}

_id_34517AACE31A5F6B(_id_B3BA2D13FC1D315C) {
  self endon("death");
  self endon("scanned");

  for(;;) {
    self waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    _id_F1BDC94C4D81C9D3(player, _id_B3BA2D13FC1D315C);
  }
}

_id_F1BDC94C4D81C9D3(player, _id_B3BA2D13FC1D315C) {
  weaponobj = makeweapon("ks_remote_device_mp");
  interactstate = spawnStruct();
  interactstate.state = 0;
  streakinfo = player scripts\cp_mp\utility\killstreak_utility::createstreakinfo("", player);
  streakinfo.interactstate = interactstate;

  if(!istrue(player.isjuggernaut)) {
    player _toggletabletallows(1);
    player._id_5336DE1FB1A48079 = 1;
  }

  player._id_6A322B3B29904E18 = _id_B3BA2D13FC1D315C;
  _id_75639AE0D134A10F = scripts\cp_mp\killstreaks\killstreakdeploy::switchtodeployweapon;
  _id_41BF9BF4918115AC = player[[_id_75639AE0D134A10F]](weaponobj, streakinfo, ::_waituntilinteractfinished, undefined, ::_ontabletpulledout, undefined, ::_ontabletputaway);
  _id_A25D3201AA412CD7 = player _id_4697C6C047891C62(_id_B3BA2D13FC1D315C);
  player notify("interact_finished");

  if(istrue(_id_A25D3201AA412CD7)) {
    _id_E2EF0B2FFDC63372 = _id_B3BA2D13FC1D315C;

    if(istrue(_id_E2EF0B2FFDC63372)) {}

    self notify("radioactive_object_scanned");
    self makeunusable();
    self notify("scanned");
  } else
    player setclientomnvar("ui_tablet_usb", 6);
}

_id_4697C6C047891C62(_id_B3BA2D13FC1D315C) {
  self endon("death");
  _id_FBC7CCE627CB4D4F = 5000;
  _id_B8CF204DD62D457F = gettime() + _id_FBC7CCE627CB4D4F;

  while(_id_B8CF204DD62D457F > gettime()) {
    if(!scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(!self useButtonPressed())
      return 0;

    wait 0.05;
  }

  return 1;
}

_ontabletpulledout(streakinfo, _id_41BF9BF4918115AC) {
  if(!istrue(_id_41BF9BF4918115AC)) {
    if(!istrue(self.isjuggernaut)) {
      _toggletabletallows(0);
      self._id_5336DE1FB1A48079 = undefined;
    }
  }

  if(istrue(self._id_6A322B3B29904E18))
    omnvar = 4;
  else
    omnvar = 5;

  self setclientomnvar("ui_tablet_usb", omnvar);
}

_ontabletputaway(streakinfo) {
  if(!istrue(self.isjuggernaut)) {
    _toggletabletallows(0);
    self._id_5336DE1FB1A48079 = undefined;
  }
}

_waituntilinteractfinished(streakinfo) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  interactstate = streakinfo.interactstate;

  if(interactstate.state != 0) {
    return;
  }
  self waittill("interact_finished");

  if(interactstate.state == 2) {
    _id_3504D7A7F76AD9D5 = 5;
    wait(_id_3504D7A7F76AD9D5);
  }

  self setclientomnvar("ui_tablet_usb", 0);
}

_toggletabletallows(_id_DA3010AF8F6BE463) {
  scripts\cp\utility::_freezelookcontrols(_id_DA3010AF8F6BE463);

  if(_id_DA3010AF8F6BE463) {
    _id_3B64EB40368C1450::set("tablet", "allow_movement", 0);
    _id_3B64EB40368C1450::set("tablet", "allow_jump", 0);
    _id_3B64EB40368C1450::set("tablet", "usability", 0);
    _id_3B64EB40368C1450::set("tablet", "melee", 0);
    _id_3B64EB40368C1450::set("tablet", "offhand_weapons", 0);
    _id_3B64EB40368C1450::set("tablet", "weapon_switch", 0);
  } else
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("tablet");
}

_id_D4CAA84AABF067B3() {
  if(getdvarint("dvar_75E2D2B2A0D80A22", 0) != 0)
    return 1;

  return 0;
}
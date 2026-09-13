/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\laststand.gsc
***********************************************/

init() {
  _id_0150B60D7CBD3BA2();
  level._effect["vfx_br_interr_in"] = loadfx("vfx/iw9_br/vfx_br_interr_in");
  level._effect["vfx_br_interr_mid"] = loadfx("vfx/iw9_br/vfx_br_interr_mid");
  level._effect["vfx_br_interr_out"] = loadfx("vfx/iw9_br/vfx_br_interr_out");
  setdvarifuninitialized("dvar_DDBF6F11FC2231F2", 3);
  setdvarifuninitialized("dvar_6ACFBD4650E8691F", 300);
  setdvarifuninitialized("dvar_A8E0E2BF5A22916C", 5);
  setdvarifuninitialized("dvar_3C56D9EF17112CDD", 3);
  setdvarifuninitialized("dvar_C1469BE98181753D", 15.0);
  setdvarifuninitialized("dvar_DE39BEF0E704C70B", 2);
  setdvarifuninitialized("dvar_CC42E9E3EB814F82", 1);
  setdvarifuninitialized("dvar_6CC46C78F1221930", 100);
  setdvarifuninitialized("dvar_DCDD2AA64529509E", 185);
  setdvarifuninitialized("dvar_46685B5A7AB844EB", 0.2);
  setdvarifuninitialized("dvar_A77CF11D23A937F4", 1);
  setdvarifuninitialized("dvar_2E92604AF6208D28", 1);
  setdvarifuninitialized("dvar_97E42D15F6DD7208", 0.2);
  setdvarifuninitialized("dvar_D856D9DC9669C4F2", 100);
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::_id_1CEC99551DBF4DD3);

  if(_id_3FF084F114B7F6C9::_id_6934349B7823D888())
    _id_3FF084F114B7F6C9::_id_F3D757808130BAC4(scripts\mp\teamrevive::_id_DF4A3CFF3137D441);

  level._id_7BCEFA52CAB9850F = 0;
}

laststandthink() {
  level endon("game_ended");
  onenter();
  result = scripts\engine\utility::_id_EFE4706DF8361219("last_stand_heal_success", "last_stand_revived", "last_stand_bleedout", "death", "disconnect", "last_stand_self_revive", "enter_live_ragdoll");

  switch (result) {
    case "last_stand_revived":
      onrevive();
      break;
    case "last_stand_self_revive":
      onrevive(1);
      break;
    case "last_stand_bleedout":
      onbleedout();
      break;
    case "last_stand_heal_success":
      onrevive(0, 1);
      break;
    case "enter_live_ragdoll":
      break;
    case "death":
      if(!((scripts\mp\utility\game::isteamreviveenabled() || scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) && scripts\mp\flags::gameflag("prematch_done")))
        ondeath();
      else {
        onexitcommon();

        if(isDefined(self))
          dropcarryobject();
      }

      break;
    case "disconnect":
      ondeath();
      break;
  }

  if(isDefined(self))
    self setclientomnvar("ui_is_laststand", 0);
}

onenter() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self endon("last_stand_finished");
  self notify("last_stand_start");
  self setclientomnvar("ui_is_laststand", 1);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "stat_1C1A3EBE5F3A23AF", undefined, 0.25);
  self._id_B24E609023CE8208 = _id_556B8AEAA691317F::_id_A35FFF2FF233592A() && !_id_2CEDCC356F1B9FC8::hasselfrevivetoken();

  if(scripts\mp\utility\perk::_hasperk("specialty_survivor"))
    self._id_4945D0D82DD3964B = 1;

  if(scripts\mp\utility\perk::_hasperk("specialty_survivor") && isDefined(self._id_D3BFE8BAAE5DF8E0))
    thread _id_21C19CFC7139D773::_id_8FDD864A86AFE560(self.laststandattacker);

  _id_A776F097EB36E500 = level.laststandhealth;
  self.health = _id_A776F097EB36E500;
  scripts\cp_mp\utility\killstreak_utility::_id_3F55C1FB553A4775(self);
  thread makelaststandinvuln();
  scripts\mp\utility\perk::giveperk("specialty_block_health_regen");
  scripts\mp\utility\perk::giveperk("specialty_blindeye");
  self.inlaststand = 1;
  self.playergoingintols = undefined;
  self.hasshownlaststandicon = 0;
  self.ignoreafkcheck = 1;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && (!_id_2CEDCC356F1B9FC8::hasselfrevivetoken() && !istrue(self._id_B24E609023CE8208))) {
    if(isDefined(level.checkforlaststandfinish))
      [[level.checkforlaststandfinish]]();
  }

  if(scripts\mp\utility\perk::_hasperk("specialty_survivor") && !scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    self.timeuntilbleedout = level.laststandtimer;
    scripts\mp\utility\lower_message::setlowermessageomnvar("survivor_revive", int(gettime() + self.timeuntilbleedout * 1000));
  }

  self.laststandoldweaponobj = scripts\mp\utility\inventory::getlastweapon();

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(!istrue(self.gulag)) {
      _id_362C58E8BB39BCDA::runbrgametypefunc("onLastStandEnter");

      if(!istrue(level._id_7A37960F05887B39)) {
        foreach(_id_F0EA4030349A33D5 in level.teamdata[self.team]["alivePlayers"]) {
          if(!isDefined(_id_F0EA4030349A33D5)) {
            continue;
          }
          if(_id_F0EA4030349A33D5 != self) {
            _id_F0EA4030349A33D5 thread scripts\mp\hud_message::showsplash("br_teammate_down", undefined, self);
            _id_F0EA4030349A33D5 thread _id_21C19CFC7139D773::_id_4E19E6BF429DDA56(self);
          }
        }
      }
    }
  }

  offhandweapon = self getheldoffhand();

  if(!isnullweapon(offhandweapon)) {
    equipmentref = scripts\mp\equipment::getequipmentreffromweapon(offhandweapon);

    if(isDefined(equipmentref) && scripts\mp\equipment::hasequipment(equipmentref)) {
      slot = scripts\mp\equipment::findequipmentslot(equipmentref);

      if(slot == "primary" || slot == "secondary")
        thread scripts\mp\equipment\gas_grenade::gas_takeheldoffhand();
    }
  }

  laststandweapon = level.laststandweapon;

  if(isDefined(level.laststandweaponcallback) && getdvarint("dvar_DDD02929770FCC8C", 0))
    laststandweapon = self[[level.laststandweaponcallback]]();

  if(!isweapon(laststandweapon))
    laststandweapon = makeweapon(laststandweapon);

  if(!istrue(self.usingascender))
    self stopanimscriptsceneevent();

  if(self isviewmodelanimplaying())
    self stopviewmodelanim();

  if(istrue(self.killstreaklaststand) && isDefined(level.killstreak_laststand_func)) {
    self[[level.killstreak_laststand_func]]();
    return;
  }

  if(isDefined(level.modeonlaststandfunc))
    self[[level.modeonlaststandfunc]]();

  if(isDefined(level.levelonlaststandfunc))
    self thread[[level.levelonlaststandfunc]]();

  if(isDefined(level.customlaststandactionset))
    self.laststandactionset = level.customlaststandactionset;
  else
    self.laststandactionset = "laststand";

  if(isDefined(self.vehicle))
    self waittill("vehicle_exit");

  _id_3B64EB40368C1450::_id_3633B947164BE4F3(self.laststandactionset, 0);
  thread handlelaststandweapongivepipeline(laststandweapon);

  if(isDefined(level.addlaststandoverheadiconcallback))
    self[[level.addlaststandoverheadiconcallback]]();
  else
    addoverheadicon();

  _id_276B87B88716C2A5 = level.laststandsuicidetimer;
  scripts\cp_mp\utility\shellshock_utility::_shellshock("last_stand_mp", "damage", _id_276B87B88716C2A5, 0);
  thread revivesetup(self);

  if(_id_2A3C9A91BF1D3911())
    thread _id_35E8814575E3963D(self);

  self.fastcrouchspeedmod = getdvarfloat("dvar_1A0DE898609317B4", 0);
  scripts\cp_mp\challenges::stopchallengetimer("alive_not_downed");

  if(isDefined(self.laststandattacker) && self.laststandattacker scripts\mp\utility\perk::_hasperk("specialty_reduce_regen_delay_on_kill"))
    self.laststandattacker scripts\mp\perks\perkfunctions::regendelayreduce_onkill();

  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    childthread stucktime(_id_276B87B88716C2A5);
  else {
    if(isDefined(self._id_3F78C6A0862F9E25) && !isDefined(level._id_D21C4A649C5ACA6C) || level._id_D21C4A649C5ACA6C)
      _id_4451EF3CADC98110(1);

    childthread dodamagewhiledown();
  }

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    thread last_stand_sfx();

  scripts\cp_mp\challenges::_id_FB2DB8647D693699(self);
  _id_4C770A9A4AD7659C::callback("player_laststand");
  self notify("last_stand_enter_finished");
  level notify("last_stand_enter_finished", self);
}

_id_4451EF3CADC98110(_id_8F1890D7F6B565C4) {
  if(getdvarint("mgl", 0)) {
    if(isDefined(self._id_62735D6FF60D68DC) && self._id_62735D6FF60D68DC == _id_8F1890D7F6B565C4) {
      return;
    }
    foreach(_id_F0EA4030349A33D5 in level.teamdata[self.team]["alivePlayers"]) {
      if(_id_F0EA4030349A33D5 == self) {
        continue;
      }
      if(_id_8F1890D7F6B565C4) {
        _id_F1398052687D83DA = "outline_nodepth_trans_white";
        scripts\mp\outline::hudoutline_enable_internal(_id_F0EA4030349A33D5, "last_stand", _id_F1398052687D83DA);
        continue;
      }

      scripts\mp\outline::_id_32DFA50C47325ABE(_id_F0EA4030349A33D5, "last_stand", 1);
    }

    self._id_62735D6FF60D68DC = _id_8F1890D7F6B565C4;
  } else {
    _id_35FC66318FB49309 = isDefined(self.laststandoutlineid);

    if(_id_35FC66318FB49309 == _id_8F1890D7F6B565C4) {
      return;
    }
    if(_id_8F1890D7F6B565C4) {
      _id_F1398052687D83DA = "outline_nodepth_brplayer" + (self._id_3F78C6A0862F9E25 + 1);
      self.laststandoutlineid = scripts\mp\utility\outline::outlineenableforteam(self, self.team, _id_F1398052687D83DA, "laststand");
    } else {
      scripts\mp\utility\outline::outlinedisable(self.laststandoutlineid, self);
      self.laststandoutlineid = undefined;
    }
  }
}

last_stand_sfx() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](self)) {
      if(!istrue(self.deathsdoorsfx) && !istrue(self._id_A9982ABA7477CC90)) {
        self.deathsdoorsfx = 1;
        self stoplocalsound("deaths_door_out");
        self playlocalsound("deaths_door_in");
        self setsoundsubmix("deaths_door_mp", 0.2, 1);
        self enableplayerbreathsystem(0);
        thread _id_6A5D3BF7A5B7064A::playerbreathingpainsound();
      }
    }
  }
}

handlelaststandweapongivepipeline(laststandweapon) {
  self endon("death_or_disconnect");
  self endon("last_stand_finished");
  level endon("game_ended");

  while(isDefined(self.currentweapon) && isDefined(self.currentweapon.basename) && (self.currentweapon.basename == "iw9_armor_plate_deploy_mp" || self.currentweapon.basename == "teammate_revive_stim_mp"))
    waitframe();

  waitframe();
  _id_DEC5F8278C01CCC3 = makeweapon("iw8_gunless_last_stand_enter");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_DEC5F8278C01CCC3, undefined, undefined, 0);
  thread scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(_id_DEC5F8278C01CCC3);
  wait 1.7;
  self notify("last_stand_transition_done");
  scripts\cp_mp\utility\inventory_utility::_takeweapon(_id_DEC5F8278C01CCC3);

  if(!isweapon(laststandweapon) && (laststandweapon == "none" || laststandweapon == "iw9_me_fists_mp_ls"))
    givedefaultlaststandweapon();
  else {
    laststandweapondelay = level.laststandweapondelay;

    if(laststandweapondelay > 0)
      thread handlelaststandweapongivedelay(laststandweapondelay, laststandweapon);
    else
      givelaststandweapon(laststandweapon);
  }
}

takelaststandtransitionweapon() {
  player = self;
  _id_DEC5F8278C01CCC3 = makeweapon("iw8_gunless_last_stand_enter");

  if(player hasweapon(_id_DEC5F8278C01CCC3))
    player scripts\cp_mp\utility\inventory_utility::_takeweapon(_id_DEC5F8278C01CCC3);
}

handlelaststandweapongivedelay(laststandweapondelay, laststandweapon) {
  self endon("death");
  self endon("last_stand_revived");
  level endon("game_ended");
  _id_003FE001FFF6B3BA = givedefaultlaststandweapon();

  if(issameweapon(_id_003FE001FFF6B3BA, laststandweapon)) {
    return;
  }
  wait(laststandweapondelay);
  self notify("end_switchToFists");
  scripts\cp_mp\utility\inventory_utility::_takeweapon(_id_003FE001FFF6B3BA);
  givelaststandweapon(laststandweapon);
}

givedefaultlaststandweapon() {
  _id_AE0DA1578AECE301 = scripts\mp\utility\dvars::getwatcheddvar("lastStandWeapon");

  if(!isDefined(_id_AE0DA1578AECE301))
    _id_AE0DA1578AECE301 = "iw9_me_fists_mp_ls";

  _id_003FE001FFF6B3BA = makeweapon(_id_AE0DA1578AECE301);
  scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_003FE001FFF6B3BA, undefined, undefined, 1);
  thread scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(_id_003FE001FFF6B3BA);
  return _id_003FE001FFF6B3BA;
}

givelaststandweapon(laststandweapon) {
  if(!isweapon(laststandweapon))
    laststandweapon = _id_2669878CF5A1B6BC::buildweapon(laststandweapon);

  _id_1B47EC827F34BD5B = getcompleteweaponname(laststandweapon);

  if(!self hasweapon(_id_1B47EC827F34BD5B))
    scripts\cp_mp\utility\inventory_utility::_giveweapon(laststandweapon, undefined, undefined, 1);

  thread scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(_id_1B47EC827F34BD5B);
}

disableweaponsovertime(t) {
  level endon("game_ended");
  _id_3B64EB40368C1450::set("disable_weapons_for_time", "weapon", 0);
  scripts\engine\utility::waittill_any_timeout_1(t, "death_or_disconnect");
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("disable_weapons_for_time");
}

switchtofists(laststandweapon) {
  self endon("death_or_disconnect");
  self endon("end_switchToFists");

  while(scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(laststandweapon, 1) == 0)
    waitframe();
}

dodamagewhiledown() {
  self endon("laststand_revived");
  self endon("disconnect");
  self endon("squad_wipe_death");
  _id_C1D466BF2CD119FA = level.laststandhealth;
  _id_D229E334EC96F738 = level.laststandtimer;

  if(_id_D229E334EC96F738 <= 0) {
    onbleedout();
    return;
  }

  _id_76E563DB5D11A0EA = float(_id_C1D466BF2CD119FA) / float(_id_D229E334EC96F738);

  if(getdvarfloat("dvar_A3A7191F4314591F", 0) > 0)
    _id_76E563DB5D11A0EA = _id_76E563DB5D11A0EA * getdvarfloat("dvar_A3A7191F4314591F", 0);

  wait 1.0;
  _id_6561E2B7A451E472 = makeweapon("iw9_me_fists_mp_ls");

  if(!istrue(level._id_28A06842B082BEA1))
    thread suicidesetup();

  _id_3D2A165F057F047A = 0.0;

  while(self.health > 0) {
    if(self isinexecutionvictim()) {
      wait 1.0;
      continue;
    }

    if(!istrue(scripts\mp\utility\player::getbeingrevivedinternal())) {
      _id_703F141D7D6FEA1E = int(_id_3D2A165F057F047A + _id_76E563DB5D11A0EA) - int(_id_3D2A165F057F047A);
      _id_3D2A165F057F047A = _id_3D2A165F057F047A + _id_76E563DB5D11A0EA;
      self.islaststandbleedoutdmg = 1;
      self dodamage(_id_703F141D7D6FEA1E, self.origin, self, undefined, "MOD_TRIGGER_HURT", _id_6561E2B7A451E472, "none");
      self playlocalsound("mvmt_heartbeat_plr_laststand");
      self.islaststandbleedoutdmg = undefined;
    }

    if(self.health <= 0 || istrue(self._id_C4C8B91E0B16AA5E)) {
      onbleedout();
      break;
    }

    wait 1.0;
  }
}

stucktime(_id_276B87B88716C2A5) {
  self.stuckinlaststand = 1;
  wait(_id_276B87B88716C2A5);
  self.stuckinlaststand = 0;
  _id_8DD9F2EB8215A139 = level.laststandtimer;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {}

  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && _id_8DD9F2EB8215A139 != 0)
    _id_8DD9F2EB8215A139 = max(_id_8DD9F2EB8215A139 - level.laststandsuicidetimer, 1);
  else
    _id_8DD9F2EB8215A139 = 0;

  self.timeuntilbleedout = _id_8DD9F2EB8215A139;

  if(isDefined(level._id_B57E01A4F8558A6B))
    self thread[[level._id_B57E01A4F8558A6B]]();
  else {
    thread bleedoutthink();
    thread suicidesetup();
  }
}

selfrevivebuttonPressed(_id_1730C8D8475566CD) {
  if(_id_1730C8D8475566CD usinggamepad())
    return _id_1730C8D8475566CD weaponswitchbuttonPressed();
  else
    return _id_1730C8D8475566CD activatekeypressed();
}

selfrevivethink() {
  _id_6BCC6405C250ECB4 = self;
  _id_1730C8D8475566CD = _id_6BCC6405C250ECB4.owner;
  level endon("game_ended");
  _id_6BCC6405C250ECB4 endon("death");
  _id_1730C8D8475566CD endon("death_or_disconnect");
  _id_1730C8D8475566CD endon("last_stand_revived");
  usetime = scripts\mp\utility\dvars::getwatcheddvar("lastStandReviveTimer") * 1000;

  if(_id_1730C8D8475566CD scripts\mp\utility\perk::_hasperk("specialty_survivor") && isDefined(level._id_D69A2EB29CE33499))
    usetime = level._id_D69A2EB29CE33499;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && _id_1730C8D8475566CD scripts\mp\utility\perk::_hasperk("specialty_br_faster_revive"))
    usetime = usetime * 0.75;

  _id_6BCC6405C250ECB4.usetime = usetime;

  if(!isDefined(self.curprogress))
    self.curprogress = 0;

  for(;;) {
    if(selfrevivebuttonPressed(_id_1730C8D8475566CD) && !istrue(_id_1730C8D8475566CD.isselfreviving) && !istrue(_id_1730C8D8475566CD.beingrevived) && (_id_1730C8D8475566CD isonground() || _id_1730C8D8475566CD _meth_E40102956C887F7C())) {
      _id_6BCC6405C250ECB4 notify("self_revive_start");
      _id_1730C8D8475566CD setlaststandselfreviving(1, istrue(_id_1730C8D8475566CD._id_B24E609023CE8208));

      if(_id_2CEDCC356F1B9FC8::_id_038A924A5F3D8CA8(_id_1730C8D8475566CD))
        _id_1730C8D8475566CD _id_19FD5B5D73D44C18::_id_CC4ED2DDD1A0C88D();

      if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
        _id_1730C8D8475566CD _id_2CEDCC356F1B9FC8::setplayerselfrevivingextrainfo(1);

      _id_6BCC6405C250ECB4 thread selfrevivemonitorrevivebuttonPressed();
    }

    waitframe();
  }
}

_id_8AFB9538DB673551() {
  if(!_id_14430DB14B833985()) {
    self attach("offhand_1h_wm_stim_v0", "tag_accessory_left");
    self._id_F46A64206952C575 = "offhand_1h_wm_stim_v0";
  }
}

_id_A904CC021551FD6B() {
  if(!_id_14430DB14B833985()) {
    self attach("misc_wm_stim_pistol_v0", "tag_accessory_left");
    self._id_F46A64206952C575 = "misc_wm_stim_pistol_v0";
  }
}

_id_9E41F17F1BD6E77E() {
  if(_id_14430DB14B833985()) {
    self detach(self._id_F46A64206952C575, "tag_accessory_left");
    self._id_F46A64206952C575 = undefined;
  }
}

_id_14430DB14B833985() {
  return isDefined(self._id_F46A64206952C575);
}

selfrevivemonitorrevivebuttonPressed() {
  _id_1730C8D8475566CD = self.owner;
  _id_6BCC6405C250ECB4 = self;
  level endon("game_ended");
  _id_1730C8D8475566CD endon("death_or_disconnect");
  _id_1730C8D8475566CD endon("last_stand_finished");
  _id_6BCC6405C250ECB4.waitingforteammaterevive = 0;
  _id_6BCC6405C250ECB4 thread selfrevivebuttonpresscleanup();

  while(scripts\mp\utility\player::isreallyalive(_id_1730C8D8475566CD) && (selfrevivebuttonPressed(_id_1730C8D8475566CD) || _id_1730C8D8475566CD _id_77799F0211BE1728()) && _id_6BCC6405C250ECB4.curprogress < _id_6BCC6405C250ECB4.usetime) {
    while(!(_id_1730C8D8475566CD isonground() || _id_1730C8D8475566CD _meth_E40102956C887F7C()) && selfrevivebuttonPressed(_id_1730C8D8475566CD) && !istrue(_id_1730C8D8475566CD.isselfreviving))
      waitframe();

    if(!selfrevivebuttonPressed(_id_1730C8D8475566CD) && !_id_1730C8D8475566CD _id_77799F0211BE1728()) {
      break;
    }

    if(_id_1730C8D8475566CD isinexecutionvictim()) {
      break;
    }

    if(istrue(_id_1730C8D8475566CD._id_12BFB031C0A0EFD8)) {
      break;
    }

    if(istrue(_id_1730C8D8475566CD._id_FA3003648B3C8EAC)) {
      _id_1730C8D8475566CD scripts\mp\utility\player::setbeingrevivedinternal(0);
      _id_1730C8D8475566CD _id_51FEAA413342A5A1();
      _id_1730C8D8475566CD scripts\mp\gameobjects::updateuiprogress(_id_6BCC6405C250ECB4, 1);
      break;
    }

    if(istrue(_id_1730C8D8475566CD.beingrevived)) {
      _id_1730C8D8475566CD scripts\mp\gameobjects::updateuiprogress(_id_6BCC6405C250ECB4, 1);
      break;
    }

    if(!istrue(_id_1730C8D8475566CD.isselfreviving)) {
      if(istrue(_id_1730C8D8475566CD._id_B24E609023CE8208)) {
        _id_1730C8D8475566CD _id_A904CC021551FD6B();
        _id_1730C8D8475566CD thread _id_2CEDCC356F1B9FC8::playerplaygestureweaponanim("iw8_ges_plyr_self_revive_stim_pistol", 10);
        _id_1730C8D8475566CD._id_C6A5BA98F5F43E0D = 1;
        _id_6BCC6405C250ECB4.inuse = 1;
      } else {
        _id_1730C8D8475566CD _id_8AFB9538DB673551();
        _id_0DD016B4325035D0 = _id_2CEDCC356F1B9FC8::_id_038A924A5F3D8CA8(_id_1730C8D8475566CD);
        _id_1730C8D8475566CD thread _id_2CEDCC356F1B9FC8::playerplaygestureweaponanim("iw8_ges_plyr_self_revive", 10, scripts\engine\utility::ter_op(_id_0DD016B4325035D0, 1, undefined));
      }

      _id_1730C8D8475566CD.isselfreviving = 1;
      _id_1730C8D8475566CD allowmovement(0);
    }

    if(!(_id_1730C8D8475566CD isonground() || _id_1730C8D8475566CD _meth_E40102956C887F7C())) {
      break;
    }

    if(!isDefined(_id_6BCC6405C250ECB4.userate))
      _id_6BCC6405C250ECB4.userate = 0;

    _id_6BCC6405C250ECB4.curprogress = _id_6BCC6405C250ECB4.curprogress + level.frameduration * _id_6BCC6405C250ECB4.userate;
    _id_6BCC6405C250ECB4.userate = 1;
    _id_1730C8D8475566CD scripts\mp\gameobjects::updateuiprogress(_id_6BCC6405C250ECB4, 1);

    if(_id_6BCC6405C250ECB4.curprogress >= _id_6BCC6405C250ECB4.usetime) {
      _id_1730C8D8475566CD stopgestureviewmodel("ges_equip_stim_self_revive");
      _id_1730C8D8475566CD stopgestureviewmodel("iw9_vm_ges_stimpistol_self_revive");

      if(_id_2CEDCC356F1B9FC8::_id_038A924A5F3D8CA8(_id_1730C8D8475566CD))
        _id_1730C8D8475566CD thread _id_19FD5B5D73D44C18::_id_905B7BADA6FD91CB(1);

      wait 0.5;

      if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
        _id_715028F54BAD19A1::branalytics_selfrevive(_id_1730C8D8475566CD);

      _id_1730C8D8475566CD finishreviveplayer("self_revive_success", _id_1730C8D8475566CD);

      if(istrue(_id_1730C8D8475566CD._id_B24E609023CE8208))
        _id_1730C8D8475566CD thread _id_556B8AEAA691317F::_id_31AFE9D7B373900F();
      else if(isDefined(level.removeselfrevivetoken)) {
        _id_1730C8D8475566CD[[level.removeselfrevivetoken]]();
        _id_1730C8D8475566CD _id_7E52B56769FA7774::_id_B76F69CE63757CEA("brloot_self_revive");
      }

      return;
    }

    waitframe();
  }

  _id_1730C8D8475566CD _id_19FD5B5D73D44C18::_id_F009283993C81AFD();

  if(!istrue(_id_1730C8D8475566CD scripts\mp\utility\player::getbeingrevivedinternal())) {
    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
      _id_1E4A61DB11011446::updatesquadmemberlaststandreviveprogress(_id_1730C8D8475566CD, _id_1730C8D8475566CD, _id_6BCC6405C250ECB4.curprogress, 1);

    _id_6BCC6405C250ECB4 thread decayreviveprogress();
  }

  _id_1730C8D8475566CD notify("stopped_self_revive");
}

_id_77799F0211BE1728() {
  return istrue(self._id_C6A5BA98F5F43E0D);
}

_id_51FEAA413342A5A1() {
  self._id_C6A5BA98F5F43E0D = 0;
  self stopgestureviewmodel("iw9_vm_ges_stimpistol_self_revive");
}

selfrevivebuttonpresscleanup() {
  _id_1730C8D8475566CD = self.owner;
  _id_6BCC6405C250ECB4 = self;
  level endon("game_ended");
  _id_1730C8D8475566CD notify("self_revive_cleanup_start");
  _id_1730C8D8475566CD endon("self_revive_cleanup_start");
  _id_1730C8D8475566CD scripts\engine\utility::waittill_any_return_no_endon_death_3("last_stand_finished", "stopped_self_revive", "death_or_disconnect");

  if(isDefined(_id_1730C8D8475566CD)) {
    if(!istrue(_id_1730C8D8475566CD.beingrevived)) {
      _id_1730C8D8475566CD scripts\mp\gameobjects::updateuiprogress(_id_6BCC6405C250ECB4, 0);
      _id_1730C8D8475566CD allowmovement(1);
    }

    _id_1730C8D8475566CD _id_9E41F17F1BD6E77E();
    _id_1730C8D8475566CD stopgestureviewmodel("ges_equip_stim_self_revive");
    _id_1730C8D8475566CD setlaststandselfreviving(0);

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
      _id_1730C8D8475566CD _id_2CEDCC356F1B9FC8::setplayerselfrevivingextrainfo(0);

    _id_1730C8D8475566CD.isselfreviving = 0;
  }
}

onexitcommon(_id_22F7E2F7E3607528) {
  if(!isDefined(self)) {
    return;
  }
  self endon("disconnect");
  level endon("game_ended");
  self.laststandactionset = undefined;
  self._id_C6A5BA98F5F43E0D = undefined;
  scripts\cp_mp\utility\killstreak_utility::_id_17576A4CDCD447A7(self);
  thread clearlaststandinvuln();
  self allowmovement(1);
  self.fastcrouchspeedmod = 0;
  scripts\mp\weapons::updatemovespeedscale();

  if(scripts\mp\utility\perk::_hasperk("specialty_block_health_regen"))
    scripts\mp\utility\perk::removeperk("specialty_block_health_regen");

  if(scripts\mp\utility\perk::_hasperk("specialty_blindeye"))
    scripts\mp\utility\perk::removeperk("specialty_blindeye");

  if(istrue(_id_22F7E2F7E3607528))
    _id_0372301AF73968CB::_id_019B9BB9CEF6A2D3();

  laststandweapon = level.laststandweapon;
  laststandweapon = makeweapon(laststandweapon);

  if(self getcurrentprimaryweapon() != laststandweapon) {
    self notify("end_switchToFists");
    scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(laststandweapon);
  } else
    scripts\cp_mp\utility\inventory_utility::_takeweapon(laststandweapon);

  self notify("last_stand_finished");
  self.laststandoldweapon = undefined;

  if(istrue(scripts\mp\utility\player::getbeingrevivedinternal()))
    scripts\mp\utility\player::setbeingrevivedinternal(0);

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    _id_1E4A61DB11011446::updatesquadmemberlaststandreviveprogress(self, self, 0, 1);
    _id_2CEDCC356F1B9FC8::setplayerbeingrevivedextrainfo(0);
    self.brdownedbyairstriketime = undefined;
  }

  self setclientomnvar("ui_is_laststand", 0);
  self setclientomnvar("ui_securing", 0);
  scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");

  if(isDefined(level.modeonexitlaststandfunc))
    self[[level.modeonexitlaststandfunc]](_id_22F7E2F7E3607528);

  _id_556B8AEAA691317F::_id_807B3B0A3B4128F9();

  if(_id_2A3C9A91BF1D3911()) {
    if(isDefined(self.laststandreviveent)) {
      scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.laststandreviveent._id_121A99ED77D25F87);
      scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.laststandreviveent._id_A2BC763E8380844B);
      self.laststandreviveent._id_121A99ED77D25F87 = undefined;
      self.laststandreviveent._id_A2BC763E8380844B = undefined;
    }

    self setclientomnvar("ui_br_has_been_interrogated", 0);
  }

  waittillframeend;
  self.inlaststand = 0;
  self.ignoreafkcheck = 0;
  self notify("afk_tracking_resume");
}

onrevive(_id_4920BF02DF960BE9, _id_D07B7DCC79B24490) {
  _id_BA5943944B6CBA2F = self.laststandoldweaponobj;
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("laststand");

  if(getDvar("dvar_7611A2790A0BF7FE", "") == "plunder" || getDvar("dvar_7611A2790A0BF7FE", "") == "risk")
    _id_6AFF3948CF4CCA03::plunder_allowallrepositoryuseforplayer(self, 1, 1);

  _id_3B64EB40368C1450::_id_588F2307A3040610(scripts\engine\utility::_id_53C4C53197386572(self.laststandactionset, "laststand"));
  onexitcommon(1);
  self laststandrevive();
  self._id_DE9D369DE44F1953 = gettime();
  self playsoundtoteam("npc_breath_revive", self.team, self, self);
  self playlocalsound("plr_breath_revive");
  self stoplocalsound("mvmt_heartbeat_plr_laststand");
  self notify("laststand_revived");
  laststandweapon = level.laststandweapon;

  if(laststandweapon != "none")
    thread scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(_id_BA5943944B6CBA2F, 1);

  if(!istrue(_id_D07B7DCC79B24490)) {
    _id_A776F097EB36E500 = level.laststandrevivehealth;

    if(!getdvarint("scr_player_laststandreviveretainhealth") || self.health < level.laststandrevivehealth) {
      self.health = level.laststandrevivehealth;
      self notify("force_regeneration");
    }
  } else
    self.health = self.maxhealth;

  if(game["state"] == "postgame")
    scripts\mp\gamelogic::freezeplayerforroundend();

  scripts\mp\utility\player::setbeingrevivedinternal(0);

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && !istrue(self.gulag)) {
    if(!istrue(level._id_7A37960F05887B39)) {
      foreach(_id_F0EA4030349A33D5 in level.teamdata[self.team]["alivePlayers"]) {
        if(!isDefined(_id_F0EA4030349A33D5)) {
          continue;
        }
        if(_id_F0EA4030349A33D5 != self)
          _id_F0EA4030349A33D5 thread scripts\mp\hud_message::showsplash("br_teammate_revived", undefined, self);
      }
    }
  }

  scripts\cp_mp\utility\shellshock_utility::_stopshellshock();

  if(istrue(_id_4920BF02DF960BE9) && istrue(level.allowselfrevive))
    allowselfrevive(0);

  scripts\cp_mp\challenges::_id_0B050ED1983293D8(self, 1, "specialty_survivor", undefined);
  params = spawnStruct();
  params.reviver = self._id_63B104851A574F2A;
  _id_4C770A9A4AD7659C::callback("player_revived", params);
  self._id_63B104851A574F2A = undefined;
  self.laststandattacker = undefined;
  self.laststandmeansofdeath = undefined;
  self.laststandweaponobj = undefined;
  self.laststanddowneddata = undefined;
  self.laststandattackermodifiers = undefined;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(isDefined(self._id_A188FBA649FFD953)) {
      _id_7E52B56769FA7774::forcegivesuper(self._id_A188FBA649FFD953);
      self._id_A188FBA649FFD953 = undefined;
    }

    _id_2CEDCC356F1B9FC8::setplayerdownedextrainfo(0);
  }

  if(istrue(_id_4920BF02DF960BE9))
    _id_189B67B2735B981D::_id_55B08D6D71B41402(self, "self_revive");
}

onbleedout() {
  if(!isDefined(self)) {
    return;
  }
  thread onexitcommon();
  dropcarryobject();

  if(isDefined(self.laststandattacker))
    self.laststandattacker thread scripts\mp\rank::scoreeventpopup("stat_E24741BA71BBB56B");

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(!istrue(level.gameended)) {
      self.deathsdoorsfx = 0;
      self clearsoundsubmix("deaths_door_mp");
      self notify("deaths_door_exit");
      self playlocalsound("deaths_door_death");
      self stoplocalsound("mvmt_heartbeat_plr_laststand");
      self enableplayerbreathsystem(1);
    }
  }

  _id_4C770A9A4AD7659C::callback("player_bleedout");
  inflictor = undefined;

  if(isDefined(self.laststandattacker))
    inflictor = self.laststandattacker;
  else if(isDefined(self.laststanddowneddata) && isDefined(self.laststanddowneddata.attacker))
    inflictor = self.laststanddowneddata.attacker;
  else
    inflictor = self;

  self._id_1CAE08F4D3D931C1 = 1;
  self dodamage(self.health + 1000, self.origin, self, inflictor, "MOD_TRIGGER_HURT", makeweapon("iw9_me_fists_mp_ls"), "none");
  self._id_1CAE08F4D3D931C1 = undefined;
  _id_ED6F8AE3C33ED504(self.laststandattacker);
}

ondeath(_id_642470E1ABC1BBF9) {
  if(!isDefined(self)) {
    return;
  }
  _id_4451EF3CADC98110(0);

  if(isDefined(self.laststandattacker) && scripts\mp\utility\perk::_hasperk("specialty_survivor"))
    _id_ED6F8AE3C33ED504(self.laststandattacker);

  if(isDefined(_id_642470E1ABC1BBF9) && isDefined(self.laststandattacker) && istrue(self.laststandattacker.inlaststand))
    self.laststandattacker thread onlaststandkillenemy(_id_642470E1ABC1BBF9, self.laststandmeansofdeath, self.laststandweaponobj);

  if(istrue(self.isselfreviving))
    self notify("stopped_self_revive");

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(!istrue(level.gameended)) {
      self.deathsdoorsfx = 0;
      self notify("deaths_door_exit");
      self clearsoundsubmix("deaths_door_mp");
      self playlocalsound("deaths_door_death");
      self stoplocalsound("mvmt_heartbeat_plr_laststand");
      self enableplayerbreathsystem(1);
    }
  }

  if(isDefined(level.checkforlaststandwipe))
    [[level.checkforlaststandwipe]](self, 1);

  thread onexitcommon();
  dropcarryobject();
}

dropcarryobject() {
  if(isDefined(self.carryobject))
    self.carryobject thread scripts\mp\gameobjects::setdropped();
}

revivesetup(owner) {
  owner endon("death_or_disconnect");
  level endon("game_ended");
  owner waittill("last_stand_transition_done");
  reviveent = spawn("script_model", owner.origin);
  reviveent setModel("tag_origin");
  owner._id_65A2B57B2B474C00 = reviveent;
  team = owner.team;
  reviveent linkTo(owner, "tag_origin", (0, 0, 20), (0, 0, 0));
  reviveent.owner = owner;
  reviveent.inuse = 0;
  reviveent.id = "laststand_reviver";
  reviveent.trigger = spawnStruct();
  reviveent.trigger.owner = owner;
  reviveent.trigger.id = "laststand_reviver";
  reviveent.trigger.targetname = "revive_trigger";
  reviveent makeusable();
  _id_6B9549A69DC6A346(reviveent);
  reviveent thread _id_4A3B25B6B877FE73(team);
  reviveent thread revivetriggerthink(team);
  reviveent thread endreviveonownerdeathordisconnect();

  if(getdvarint("dvar_7A493092F8A1C04C", 0) && getdvarint("dvar_DDD02929770FCC8C", 0))
    owner thread secondwindthink();

  owner.laststandreviveent = reviveent;
  level.laststandreviveents[reviveent getentitynumber()] = reviveent;
  reviveent thread removereviveentfromlevelarrayondeath();
  owner thread _id_788452276786DCC7();

  if(owner _id_2CEDCC356F1B9FC8::hasselfrevivetoken() || istrue(owner._id_B24E609023CE8208) || istrue(owner scripts\mp\utility\perk::_hasperk("specialty_survivor")) && !isDefined(self._id_D3BFE8BAAE5DF8E0))
    owner.laststandreviveent selfrevivethink();
}

_id_6B9549A69DC6A346(reviveent) {
  if(isDefined(reviveent.owner) && getdvarint("mgl", 0)) {
    reviveent setCursorHint("HINT_BUTTON");
    reviveent sethinticon("hud_icon_cyber_revive");
    reviveent sethintdisplayrange(96);
    reviveent setuserange(96);
  } else
    reviveent setCursorHint("HINT_NOICON");

  reviveent setusehideprogressbar(1);
  reviveent setuseholdduration("duration_none");
  reviveent setHintString(&"MP/LASTSTAND_REVIVE_USE");
  reviveent setusepriority(-3);
  reviveent sethintdisplayfov(90);
  reviveent setusefov(90);

  if(_id_2A3C9A91BF1D3911() && !isDefined(reviveent._id_121A99ED77D25F87) && !isDefined(reviveent._id_A2BC763E8380844B)) {
    reviveent._id_121A99ED77D25F87 = scripts\cp_mp\entityheadicons::setheadicon_singleimage([], "hud_icon_interrogation", 16, 0, 800, 100, undefined, 1, 1);
    reviveent._id_A2BC763E8380844B = scripts\cp_mp\entityheadicons::setheadicon_singleimage([], "hud_icon_interrogation_active", 16, 0, 800, 100, undefined, 1, 1);
    setheadiconteam(reviveent._id_121A99ED77D25F87, reviveent.trigger.owner.team);
  }
}

_id_35E8814575E3963D(owner) {
  owner endon("death_or_disconnect");
  level endon("game_ended");
  owner waittill("last_stand_transition_done");
  _id_CD0DE96A0CA17DB5 = spawn("script_model", owner.origin);
  _id_CD0DE96A0CA17DB5 setModel("tag_origin");
  team = owner.team;
  _id_CD0DE96A0CA17DB5 linkTo(owner, "tag_origin", (0, 0, 12), (0, 0, 0));
  _id_CD0DE96A0CA17DB5.number = level._id_7BCEFA52CAB9850F;
  level._id_7BCEFA52CAB9850F++;
  _id_CD0DE96A0CA17DB5.owner = owner;
  _id_CD0DE96A0CA17DB5.inuse = 0;
  _id_CD0DE96A0CA17DB5.id = "laststand_interrogator";
  _id_CD0DE96A0CA17DB5.count = getdvarint("dvar_001AD2BFEFFAD0C8", 1);
  _id_CD0DE96A0CA17DB5.trigger = spawnStruct();
  _id_CD0DE96A0CA17DB5.trigger.owner = owner;
  _id_CD0DE96A0CA17DB5.trigger.id = "laststand_interrogation";
  _id_CD0DE96A0CA17DB5.trigger.targetname = "interrogation_trigger";
  _id_CD0DE96A0CA17DB5 makeusable();
  _id_CD0DE96A0CA17DB5 setuserange(getdvarfloat("dvar_6CC46C78F1221930", 100));
  _id_2AA6E4D20914E40A(_id_CD0DE96A0CA17DB5);
  owner setclientomnvar("ui_br_has_been_interrogated", 0);
  owner._id_F159F1C13AA75721 = _id_CD0DE96A0CA17DB5;
  _id_CD0DE96A0CA17DB5 thread _id_DC8861A5E3B418D5(team);
  _id_CD0DE96A0CA17DB5 thread _id_56E47961499CA06C(team);
  _id_CD0DE96A0CA17DB5 _id_B76937DBB7CE1D64();
  _id_CD0DE96A0CA17DB5 thread endreviveonownerdeathordisconnect();
}

_id_2AA6E4D20914E40A(_id_CD0DE96A0CA17DB5) {
  if(isDefined(_id_CD0DE96A0CA17DB5.owner) && _id_CD0DE96A0CA17DB5.owner _meth_C6CB3E654225077A()) {
    _id_CD0DE96A0CA17DB5 setCursorHint("HINT_BUTTON");
    _id_CD0DE96A0CA17DB5 sethinticon("ui_mp_br_player_status_interrogation");
    _id_CD0DE96A0CA17DB5 sethintdisplayrange(96);
    _id_CD0DE96A0CA17DB5 setuserange(96);
  } else
    _id_CD0DE96A0CA17DB5 setCursorHint("HINT_NOBUTTON");

  _id_CD0DE96A0CA17DB5 setusehideprogressbar(1);
  _id_CD0DE96A0CA17DB5 setuseholdduration("duration_none");
  _id_CD0DE96A0CA17DB5 setHintString(&"MP/LASTSTAND_INTERROGATE_USE");
  _id_CD0DE96A0CA17DB5 setusepriority(-2);
  _id_CD0DE96A0CA17DB5 sethintdisplayfov(90);
  _id_CD0DE96A0CA17DB5 setusefov(90);
}

secondwindthink() {
  _id_1730C8D8475566CD = self;
  _id_1730C8D8475566CD endon("death_or_disconnect");
  _id_1730C8D8475566CD endon("last_stand_finished");
  level endon("game_ended");
  _id_7BF1255A3715A632 = gettime();
  _id_1730C8D8475566CD waittill("killed_enemy_in_last_stand", _id_E851FFA44B7E0D54, einflictor, objweapon, meansofdeath, weaponname, laststandmeansofdeath, _id_A47D4C036F14FC38, _id_7C51875477EAD31E, _id_738570DC981C9B43);

  for(;;) {
    if(_id_7C51875477EAD31E) {
      _id_1730C8D8475566CD waittill("killed_enemy_in_last_stand", _id_E851FFA44B7E0D54, einflictor, objweapon, meansofdeath, weaponname, laststandmeansofdeath, _id_A47D4C036F14FC38, _id_7C51875477EAD31E, _id_738570DC981C9B43);
      continue;
    }

    break;
  }

  _id_36CD2FA9E32592D7 = _id_E851FFA44B7E0D54.laststandattacker;

  if(!isDefined(_id_36CD2FA9E32592D7))
    _id_36CD2FA9E32592D7 = _id_E851FFA44B7E0D54;

  _id_1450075A920A7DD5 = isDefined(_id_36CD2FA9E32592D7) && _id_36CD2FA9E32592D7 != _id_1730C8D8475566CD;
  _id_C9D5089E35E3FF9E = _id_7C51875477EAD31E;
  _id_E6EF59BD6DC2938A = _id_738570DC981C9B43 || isDefined(einflictor) && einflictor getentitynumber() == worldentnumber();
  _id_5BA6882801957605 = gettime() - _id_7BF1255A3715A632;
  _id_6B0DF23A41285117 = float(_id_5BA6882801957605 / 1000.0);

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    _id_715028F54BAD19A1::branalytics_secondwind(_id_1730C8D8475566CD, _id_36CD2FA9E32592D7, _id_E851FFA44B7E0D54, meansofdeath, weaponname, laststandmeansofdeath, _id_A47D4C036F14FC38, _id_1450075A920A7DD5, _id_C9D5089E35E3FF9E, _id_E6EF59BD6DC2938A, _id_6B0DF23A41285117);

  _id_1730C8D8475566CD finishreviveplayer("self_revive_on_kill_success", _id_1730C8D8475566CD);
  _id_1730C8D8475566CD thread scripts\mp\hud_message::showsplash("br_second_wind");
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(_id_1730C8D8475566CD.team, "players");

  foreach(player in _id_E2B2BBD9E6539F11) {
    if(player != _id_1730C8D8475566CD && isalive(player))
      player thread scripts\mp\hud_message::showsplash("br_teammate_second_wind", undefined, _id_1730C8D8475566CD);
  }
}

onlaststandkillenemy(_id_642470E1ABC1BBF9, laststandmeansofdeath, laststandweaponobj) {
  _id_E851FFA44B7E0D54 = _id_642470E1ABC1BBF9.victim;
  einflictor = _id_642470E1ABC1BBF9.inflictor;
  objweapon = _id_642470E1ABC1BBF9.objweapon;
  meansofdeath = _id_642470E1ABC1BBF9.meansofdeath;
  weaponname = _id_642470E1ABC1BBF9.weaponfullstring;
  _id_7C51875477EAD31E = _id_642470E1ABC1BBF9.attacker != self;
  _id_738570DC981C9B43 = istrue(_id_642470E1ABC1BBF9.assistedsuicide);
  _id_A47D4C036F14FC38 = undefined;

  if(isDefined(laststandweaponobj))
    _id_A47D4C036F14FC38 = getcompleteweaponname(laststandweaponobj);

  self notify("killed_enemy_in_last_stand", _id_E851FFA44B7E0D54, einflictor, objweapon, meansofdeath, weaponname, laststandmeansofdeath, _id_A47D4C036F14FC38, _id_7C51875477EAD31E, _id_738570DC981C9B43);
}

endreviveonownerdeathordisconnect() {
  self endon("death");
  self.owner scripts\engine\utility::waittill_any_4("death_or_disconnect", "last_stand_finished", "last_stand_heal_active", "interrogation_finished");
  self delete();
}

removereviveentfromlevelarrayondeath() {
  level endon("game_ended");
  entnum = self getentitynumber();
  self waittill("death");
  level.laststandreviveents[entnum] = undefined;
}

updateusablebyteam(team) {
  self disableplayeruseforallplayers();
  _id_4C452A6C72371F17();

  foreach(player in level.players) {
    if(team == player.team && player != self.owner && !player _id_2CEDCC356F1B9FC8::playeriszombie())
      self enableplayeruse(player);
  }
}

_id_38F5ADE989B3848F(team) {
  self enableplayeruseforallplayers();

  foreach(player in level.players) {
    if(team == player.team)
      self disableplayeruse(player);
  }
}

_id_4A3B25B6B877FE73(team) {
  self endon("death");
  self.owner endon("last_stand_finished");

  for(;;) {
    updateusablebyteam(self.owner.team);
    self.owner scripts\engine\utility::waittill_any_2("joined_team", "refresh_revives");
  }
}

_id_DC8861A5E3B418D5(team) {
  self endon("death");
  self.owner endon("last_stand_finished");

  for(;;) {
    _id_38F5ADE989B3848F(self.owner.team);
    self.owner waittill("joined_team");
  }
}

_id_B76937DBB7CE1D64() {
  self endon("death");
  self.owner endon("last_stand_finished");

  foreach(player in level.players) {
    if(isDefined(player) && player _id_2CEDCC356F1B9FC8::playeriszombie())
      self disableplayeruse(player);
  }

  thread _id_1679DD002D8E8F9B("zombie_set");
  thread _id_1679DD002D8E8F9B("zombie_unset");
}

_id_1679DD002D8E8F9B(_id_70687E0CC558A009) {
  self endon("death");
  self.owner endon("last_stand_finished");

  for(;;) {
    level waittill(_id_70687E0CC558A009, player);

    if(isDefined(player)) {
      self.owner.laststandreviveent _id_42994E73B40CC1A4(player);

      if(player _id_2CEDCC356F1B9FC8::playeriszombie()) {
        self disableplayeruse(player);
        continue;
      }

      self enableplayeruse(player);
    }
  }
}

_id_7627883AC8601401() {
  if(!self isonground() && !self _meth_E40102956C887F7C())
    return 0;

  if(self _meth_E5BF22923D0004BC())
    return 0;

  return 1;
}

_id_F111048FABF84E37(_id_22F7E3F7E360775B) {
  if(!isDefined(_id_22F7E3F7E360775B))
    return 0;

  if(!isDefined(self))
    return 0;

  return self useButtonPressed() || istrue(self._id_7F59448717B5AA63) || _id_22F7E3F7E360775B _id_556B8AEAA691317F::_id_F0D1C9C39359EFFF();
}

revivetriggerthink(team) {
  self.owner endon("last_stand_finished");
  self.owner endon("last_stand_heal_active");
  self.owner endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", reviver);

    if(istrue(self.owner._id_C6A5BA98F5F43E0D)) {
      continue;
    }
    if(reviver.team != self.owner.team && !istrue(self._id_FD7344B9978191BE)) {
      continue;
    }
    if(istrue(self.owner._id_895C1AAAC16F7256) || istrue(reviver._id_93018D510A589832)) {
      continue;
    }
    _id_2A2F3B9577569F6F = reviver getmovingplatformparent();
    _id_D73E510900C0D7F0 = self.owner getmovingplatformparent();
    _id_B72A36AC20C64B41 = isDefined(_id_2A2F3B9577569F6F) || isDefined(_id_D73E510900C0D7F0);

    if(_id_B72A36AC20C64B41 && !scripts\engine\trace::ray_trace_detail_passed(reviver getEye(), self.origin + (0, 0, 20), [reviver, self.owner], scripts\engine\trace::create_contents(1, 0, 0, 0, 0, 1))) {
      reviver scripts\mp\hud_message::showerrormessage("MP/REVIVE_BLOCKED");
      continue;
    }

    while(reviver _id_F111048FABF84E37(self.owner) && !reviver _id_7627883AC8601401())
      waitframe();

    if(istrue(reviver.insertingarmorplate) && !self.owner _id_556B8AEAA691317F::_id_F0D1C9C39359EFFF()) {
      reviver notify("try_armor_cancel", "last_stand_reviver_start");

      while(istrue(reviver.insertingarmorplate) && reviver _id_F111048FABF84E37(self.owner))
        waitframe();
    }

    if(!reviver _id_F111048FABF84E37(self.owner)) {
      continue;
    }
    self.owner scripts\mp\utility\player::setbeingrevivedinternal(1);

    if(!self.owner _id_556B8AEAA691317F::_id_F0D1C9C39359EFFF())
      reviver thread scripts\mp\teamrevive::_id_C86CF00D5859CE10(self.owner.origin);

    _id_22F7E2F7E3607528 = 0;
    self.owner notify("handle_revive_message");
    self makeunusable();

    if(reviver _meth_C6CB3E654225077A())
      reviver _meth_FC1C1E51058904A3(&"MP/LASTSTAND_REVIVE_USE");

    self.owner allowmovement(0);

    if(!self.owner _id_556B8AEAA691317F::_id_F0D1C9C39359EFFF())
      reviver setlaststandreviving(1, 0);
    else
      reviver setlaststandreviving(1, 1);

    reviver _id_D9BD056C79A6077B(self.owner);
    thread useholdthink(reviver);

    if(!self.owner _id_556B8AEAA691317F::_id_F0D1C9C39359EFFF())
      reviver thread switchtoteammatereviveweapon(self.owner);

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
      self.owner _id_2CEDCC356F1B9FC8::setplayerbeingrevivedextrainfo(1);

    _id_4930CBCE302555B1 = scripts\engine\utility::waittill_any_return_no_endon_death_3("use_hold_revive_success", "use_hold_revive_fail", "death_or_disconnect");

    if(reviver _meth_C6CB3E654225077A())
      reviver forceusehintoff();

    if(_id_4930CBCE302555B1 == "use_hold_revive_success")
      _id_22F7E2F7E3607528 = 1;

    reviver notify("finish_buddy_reviving");
    self.owner scripts\mp\utility\player::setbeingrevivedinternal(0);
    _id_22F7E2F7E3607528 = self.owner finishreviveplayer(_id_4930CBCE302555B1, reviver);

    if(_id_22F7E2F7E3607528) {
      return;
    }
    thread decayreviveprogress();
    self makeusable();
    _id_6B9549A69DC6A346(self);
    updateusablebyteam(self.owner.team);
    waittillframeend;
  }
}

_id_D9BD056C79A6077B(_id_22F7E3F7E360775B) {
  self._id_3C3DE22BD4680EDB = scripts\engine\utility::_id_6D6AF8144A5131F1(self._id_3C3DE22BD4680EDB, _id_22F7E3F7E360775B);

  if(self._id_3C3DE22BD4680EDB.size > 0) {
    _id_22F7E3F7E360775B.reviver = self;
    self.revivingteammate = 1;
  }
}

_id_42D99E200AA9762A(_id_22F7E3F7E360775B) {
  self._id_3C3DE22BD4680EDB = scripts\engine\utility::array_remove(self._id_3C3DE22BD4680EDB, _id_22F7E3F7E360775B);

  if(self._id_3C3DE22BD4680EDB.size <= 0) {
    self.revivingteammate = 0;
    self._id_383E041E3E341315 = undefined;
    _id_22F7E3F7E360775B.reviver = undefined;
  }
}

_id_538E8D0F5B4D6383() {
  if(!isDefined(self._id_3C3DE22BD4680EDB))
    return undefined;

  return scripts\engine\utility::array_get_first_item(self._id_3C3DE22BD4680EDB);
}

_id_56E47961499CA06C(team) {
  self.owner endon("disconnect");
  level endon("game_ended");
  _id_5BEBD2013B0F01EC = self.owner;

  for(;;) {
    self waittill("trigger", interrogator);

    if(interrogator.team == self.owner.team) {
      continue;
    }
    if(interrogator ismeleeing() || interrogator isinexecutionattack()) {
      continue;
    }
    if(istrue(_id_5BEBD2013B0F01EC scripts\mp\utility\player::getbeingrevivedinternal())) {
      if(istrue(_id_5BEBD2013B0F01EC.isselfreviving)) {
        _id_5BEBD2013B0F01EC._id_FA3003648B3C8EAC = 1;
        _id_5BEBD2013B0F01EC scripts\mp\utility\player::setbeingrevivedinternal(0);
        waitframe();
        _id_5BEBD2013B0F01EC._id_FA3003648B3C8EAC = 0;
      } else
        continue;
    }

    while(!interrogator _id_7627883AC8601401() && interrogator _id_F111048FABF84E37(_id_5BEBD2013B0F01EC))
      waitframe();

    if(interrogator getstance() != "stand") {
      _id_CCBC8F28CB6A19E7 = interrogator setstance("stand", 0, 1);

      if(_id_CCBC8F28CB6A19E7)
        wait 0.4;
      else {
        interrogator scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/INTERROGATE_BLOCKED_STANCE");
        wait 0.1;
        continue;
      }
    }

    if(istrue(interrogator.insertingarmorplate)) {
      interrogator notify("try_armor_cancel", "interrogation_interrogator_start");

      while(istrue(interrogator.insertingarmorplate) && interrogator _id_F111048FABF84E37(_id_5BEBD2013B0F01EC))
        waitframe();
    }

    if(!scripts\mp\utility\player::isreallyalive(interrogator) || !scripts\mp\utility\player::isreallyalive(_id_5BEBD2013B0F01EC)) {
      continue;
    }
    if(!interrogator _id_F111048FABF84E37(interrogator)) {
      continue;
    }
    _id_18D0BF9A1F307A7A = _id_0F671D7EFEF879A1(interrogator, _id_5BEBD2013B0F01EC);

    switch (_id_18D0BF9A1F307A7A) {
      case 4:
        interrogator scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/INTERROGATE_BLOCKED_SWIMMING");
        wait 0.1;
        continue;
      case 2:
      case 1:
      case 0:
        break;
      case 5:
        break;
      default:
        interrogator scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/INTERROGATE_BLOCKED");
        wait 0.1;
        continue;
    }

    interrogator setclientomnvar("ui_tablet_usb", 10);
    interrogator _id_4BA85E5091EEE483("stat_D0F9D14B2396542B", 4.0);

    if(getdvarint("dvar_60A0581926005683", 1) != 0)
      thread _id_B3F5EEDE669E7182(interrogator, _id_5BEBD2013B0F01EC);

    _id_5BEBD2013B0F01EC scripts\mp\utility\player::setbeingrevivedinternal(1);
    _id_5BEBD2013B0F01EC _id_2CEDCC356F1B9FC8::_id_CC20F0C1304019D9(1);
    interrogator _id_2CEDCC356F1B9FC8::_id_0EB28F4724F0F14B(1);
    _id_22F7E2F7E3607528 = 0;
    self makeunusable();

    if(interrogator _meth_C6CB3E654225077A())
      interrogator _meth_FC1C1E51058904A3(&"MP/LASTSTAND_INTERROGATE_USE");

    _id_5BEBD2013B0F01EC._id_21FC661949481CED = scripts\mp\utility\outline::outlineenableforteam(_id_5BEBD2013B0F01EC, _id_5BEBD2013B0F01EC.team, "outline_nodepth_orange", "level_script");
    _id_5BEBD2013B0F01EC allowmovement(0);
    interrogator._id_93018D510A589832 = 1;
    _id_5BEBD2013B0F01EC._id_895C1AAAC16F7256 = 1;
    thread useholdthink(interrogator, undefined, 1);

    if(_id_18D0BF9A1F307A7A == 5) {
      thread _id_1D6E0919BCC01C46(interrogator, _id_5BEBD2013B0F01EC, self.usetime);
      interrogator._id_A3FB93A908CC7F32 = 1;
    } else {
      _id_52C70B19D5EA6EDF = rotatevector((4.167, -0.186, 39.969), self.owner.angles);
      interrogator thread _id_96F2172E98188560(self.owner.origin + _id_52C70B19D5EA6EDF);
    }

    interrogator thread switchtoteammatereviveweapon(_id_5BEBD2013B0F01EC, 1);
    thread _id_BEF121E9CC93F796(interrogator, _id_5BEBD2013B0F01EC);
    self.owner.laststandreviveent._id_F1DA02A134648443 = 4;
    self.owner.laststandreviveent _id_4C452A6C72371F17();
    _id_4930CBCE302555B1 = scripts\engine\utility::waittill_any_return_no_endon_death_3("use_hold_interrogate_success", "use_hold_interrogate_fail", "death_or_disconnect");

    if(interrogator _meth_C6CB3E654225077A())
      interrogator forceusehintoff();

    if(_id_4930CBCE302555B1 == "use_hold_interrogate_success")
      _id_5BEBD3013B0F041F = 1;
    else {
      self.owner.laststandreviveent._id_F1DA02A134648443 = 1;
      self.owner.laststandreviveent _id_4C452A6C72371F17();
    }

    interrogator notify("finish_victim_interrogation");

    if(_id_4930CBCE302555B1 == "use_hold_interrogate_success" || _id_4930CBCE302555B1 == "use_hold_interrogate_fail")
      _id_5BEBD2013B0F01EC notify(_id_4930CBCE302555B1);

    _id_5BEBD2013B0F01EC scripts\mp\utility\player::setbeingrevivedinternal(0);
    _id_5BEBD2013B0F01EC _id_2CEDCC356F1B9FC8::_id_CC20F0C1304019D9(0);
    interrogator _id_2CEDCC356F1B9FC8::_id_0EB28F4724F0F14B(0);
    interrogator setclientomnvar("ui_tablet_usb", 0);
    _id_5BEBD3013B0F041F = _id_5BEBD2013B0F01EC _id_70F1DBC7125939B8(_id_4930CBCE302555B1, interrogator, self.owner.team);

    if(_id_4930CBCE302555B1 == "use_hold_interrogate_fail")
      wait 0.25;

    if(!isDefined(self)) {
      return;
    }
    if(istrue(_id_5BEBD3013B0F041F)) {
      self.count--;

      if(self.count <= 0) {
        if(isDefined(self.owner) && isDefined(self.owner.laststandreviveent)) {
          self.owner.laststandreviveent._id_F1DA02A134648443 = 2;
          self.owner.laststandreviveent._id_9D797A762D9195EB = 1;
          self.owner setclientomnvar("ui_br_has_been_interrogated", 1);
          self.owner.laststandreviveent _id_4C452A6C72371F17();
        }

        return;
      }
    }

    thread _id_1F761672C3708743();
    self makeusable();
    self setuserange(getdvarfloat("dvar_6CC46C78F1221930", 100));
    _id_2AA6E4D20914E40A(self);
    _id_38F5ADE989B3848F(self.owner.team);
  }
}

_id_BEF121E9CC93F796(interrogator, _id_5BEBD2013B0F01EC) {
  _id_0D33A0BAA5624A4A = interrogator.team;
  _id_CA6FAC37F3E2227D = _id_5BEBD2013B0F01EC.team;
  _id_DAB2D0F370A19A17(_id_0D33A0BAA5624A4A, _id_CA6FAC37F3E2227D);
  _id_6FFC1D64D4E5832D(interrogator, _id_5BEBD2013B0F01EC);
  _id_A73848EF9A4E7932(_id_0D33A0BAA5624A4A, _id_CA6FAC37F3E2227D);
}

_id_6FFC1D64D4E5832D(interrogator, _id_5BEBD2013B0F01EC) {
  level endon("game_ended");
  self endon("use_hold_interrogate_fail");
  self endon("death_or_disconnect");
  _id_5BEBD2013B0F01EC endon("last_stand_finished");
  _id_5BEBD2013B0F01EC endon("check_for_plea");
  _id_5BEBD2013B0F01EC endon("disconnect");
  interrogator waittill("interrogation_signal_lost");
}

_id_DAB2D0F370A19A17(_id_0D33A0BAA5624A4A, _id_CA6FAC37F3E2227D) {
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("teamAssim", "disablePlayer")) {
    return;
  }
  foreach(player in level.teamdata[_id_0D33A0BAA5624A4A]["players"])[[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "disablePlayer")]](player, "interrogation_" + self.number);

  foreach(player in level.teamdata[_id_CA6FAC37F3E2227D]["players"])[[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "disablePlayer")]](player, "interrogation_" + self.number);
}

_id_A73848EF9A4E7932(_id_0D33A0BAA5624A4A, _id_CA6FAC37F3E2227D) {
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("teamAssim", "enablePlayer")) {
    return;
  }
  foreach(player in level.teamdata[_id_0D33A0BAA5624A4A]["players"])[[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "enablePlayer")]](player, "interrogation_" + self.number);

  foreach(player in level.teamdata[_id_CA6FAC37F3E2227D]["players"])[[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "enablePlayer")]](player, "interrogation_" + self.number);
}

switchtoteammatereviveweapon(_id_22F7E3F7E360775B, interrogation) {
  reviver = self;
  reviver endon("death_or_disconnect");
  level endon("game_ended");

  if(!isDefined(interrogation))
    interrogation = 0;

  if(istrue(interrogation))
    weaponobj = makeweapon("interrogation_tools_mp");
  else
    weaponobj = makeweapon("teammate_revive_stim_mp");

  if(!istrue(reviver._id_A3FB93A908CC7F32)) {
    reviver scripts\cp_mp\utility\inventory_utility::_giveweapon(weaponobj, 0, 0, 0);
    reviver thread _id_4A81A13950A6021D(weaponobj);
  }

  reviver thread watchfordeathwhilereviving();
  reviver thread watchforteammatedeathwhilereviving(_id_22F7E3F7E360775B);
  reviver thread watchforteammaterevivedwhilereviving(_id_22F7E3F7E360775B);

  if(!istrue(reviver._id_A3FB93A908CC7F32)) {
    _id_41BF9BF4918115AC = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(weaponobj, isbot(reviver));

    if(!istrue(_id_41BF9BF4918115AC)) {
      return;
    }
    reviver _id_3B64EB40368C1450::set("last_stand_weapon_switch", "weapon_switch", 0);
  }

  if(isDefined(reviver._id_A3FB93A908CC7F32))
    reviver._id_A3FB93A908CC7F32 = undefined;
}

_id_4A81A13950A6021D(weaponobj) {
  reviver = self;
  level endon("game_ended");
  reviver teammatereviveweaponwaitputaway();

  if(isDefined(reviver)) {
    _id_75D67FBF8F835D55 = 1;

    if(!reviver scripts\cp_mp\utility\player_utility::_isalive() || scripts\mp\utility\player::isinlaststand(reviver))
      _id_75D67FBF8F835D55 = 0;

    reviver thread _id_1D21F6E823B18AA8(weaponobj, _id_75D67FBF8F835D55);
  }
}

_id_1D21F6E823B18AA8(weaponobj, _id_75D67FBF8F835D55) {
  reviver = self;
  reviver endon("disconnect");
  level endon("game_ended");
  reviver _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("last_stand_weapon_switch");
  reviver notify("revive_stim_finished");

  if(reviver scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(weaponobj))
    reviver scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(weaponobj);
  else
    reviver scripts\cp_mp\utility\inventory_utility::_takeweapon(weaponobj);

  if(istrue(_id_75D67FBF8F835D55)) {
    _id_41BF9BF4918115AC = reviver scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(reviver.lastdroppableweaponobj, isbot(reviver));
    currentweapon = reviver getcurrentweapon();

    if(currentweapon.basename == "none")
      reviver scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
  }
}

teammatereviveweaponwaitputaway(streakinfo) {
  reviver = self;
  level endon("game_ended");

  if(!istrue(reviver.revivingteammate) && !istrue(reviver._id_93018D510A589832)) {
    return;
  }
  _id_FA7C7B71DC2C9CB0 = ["death_or_disconnect", "finish_buddy_reviving", "last_stand_start", "finish_victim_interrogation"];
  reviver scripts\engine\utility::waittill_any_in_array_return_no_endon_death(_id_FA7C7B71DC2C9CB0);
}

watchfordeathwhilereviving() {
  reviver = self;
  reviver endon("finish_buddy_reviving");
  reviver endon("finish_victim_interrogation");
  reviver endon("disconnect");
  level endon("game_ended");
  reviver waittill("death");
  reviver notify("finish_buddy_reviving");
}

watchforteammatedeathwhilereviving(_id_22F7E3F7E360775B) {
  reviver = self;
  reviver endon("finish_buddy_reviving");
  reviver endon("finish_victim_interrogation");
  reviver endon("death_or_disconnect");
  level endon("game_ended");
  _id_22F7E3F7E360775B scripts\engine\utility::waittill_any_2("death_or_disconnect", "enter_live_ragdoll");
  reviver notify("finish_buddy_reviving");
}

watchforteammaterevivedwhilereviving(_id_22F7E3F7E360775B) {
  reviver = self;
  reviver endon("finish_buddy_reviving");
  reviver endon("finish_victim_interrogation");
  reviver endon("death_or_disconnect");
  level endon("game_ended");
  _id_22F7E3F7E360775B waittill("last_stand_revived");
  reviver notify("finish_buddy_reviving");
}

_id_788452276786DCC7() {
  _id_22F7E3F7E360775B = self;

  if(!isPlayer(_id_22F7E3F7E360775B)) {
    return;
  }
  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    return;
  }
  _id_98422A847A5A36B3 = getdvarint("dvar_FA3A2702C11C396C", 0) == 1;

  if(!_id_98422A847A5A36B3) {
    return;
  }
  _id_22F7E3F7E360775B endon("death_or_disconnect");
  _id_22F7E3F7E360775B endon("last_stand_revived");

  if(!isai(_id_22F7E3F7E360775B)) {
    _id_22F7E3F7E360775B notifyonplayercommand("stanceChangePressed", "+stancedown");
    _id_22F7E3F7E360775B notifyonplayercommand("stanceChangePressed", "+movedown");
    _id_22F7E3F7E360775B notifyonplayercommand("stanceChangePressed", "+prone");
    _id_22F7E3F7E360775B notifyonplayercommand("stanceChangePressed", "+stance");
    _id_22F7E3F7E360775B notifyonplayercommand("stanceChangePressed", "+togglecrouch");
    _id_22F7E3F7E360775B notifyonplayercommand("stanceChangeReleased", "-stancedown");
    _id_22F7E3F7E360775B notifyonplayercommand("stanceChangeReleased", "-movedown");
    _id_22F7E3F7E360775B notifyonplayercommand("stanceChangeReleased", "-prone");
    _id_22F7E3F7E360775B notifyonplayercommand("stanceChangeReleased", "-stance");
    _id_22F7E3F7E360775B notifyonplayercommand("stanceChangeReleased", "-togglecrouch");
  }

  for(;;) {
    _id_22F7E3F7E360775B waittill("stanceChangePressed");
    _id_8C7AD61293102245 = gettime();
    _id_22F7E3F7E360775B waittill("stanceChangeReleased");
    _id_22DEF5ECDEC8DE62 = gettime() - _id_8C7AD61293102245;
    _id_566B9019751185DE = 350;

    if(_id_22DEF5ECDEC8DE62 < _id_566B9019751185DE)
      _id_FC2445A76915F9E7(_id_22F7E3F7E360775B);
  }
}

_id_FC2445A76915F9E7(_id_22F7E3F7E360775B) {
  _id_22F7E3F7E360775B._id_84649776F0D63667 = !istrue(_id_22F7E3F7E360775B._id_84649776F0D63667);
  _id_DC7D14535D73EDA1 = istrue(_id_22F7E3F7E360775B._id_84649776F0D63667);
  _id_9C0BEC190D4FA4DA = scripts\engine\utility::ter_op(_id_DC7D14535D73EDA1, "MP_BR_INGAME/WILL_REVIVE_INTO_PRONE", "MP_BR_INGAME/WILL_REVIVE_INTO_CROUCH");
  _id_22F7E3F7E360775B scripts\mp\hud_message::showerrormessage(_id_9C0BEC190D4FA4DA);
}

finishreviveplayer(_id_70687E0CC558A009, reviver) {
  _id_22F7E3F7E360775B = self;
  _id_22F7E2F7E3607528 = 0;

  if(!isDefined(_id_22F7E3F7E360775B) || !isalive(_id_22F7E3F7E360775B))
    return 0;

  if(_id_70687E0CC558A009 == "use_hold_revive_success" || _id_70687E0CC558A009 == "self_revive_on_kill_success" || _id_70687E0CC558A009 == "self_revive_success")
    _id_22F7E2F7E3607528 = 1;

  _id_22F7E3F7E360775B.isselfreviving = 0;
  _id_22F7E3F7E360775B scripts\mp\utility\player::setbeingrevivedinternal(0);

  if(_id_70687E0CC558A009 == "self_revive_success")
    _id_22F7E3F7E360775B selfrevivingdoneanimevent();

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    _id_22F7E3F7E360775B _id_2CEDCC356F1B9FC8::setplayerbeingrevivedextrainfo(0);
    _id_22F7E3F7E360775B _id_2CEDCC356F1B9FC8::setplayerselfrevivingextrainfo(0);
  }

  _id_22F7E3F7E360775B allowmovement(1);

  if(_id_22F7E2F7E3607528) {
    _id_22F7E3F7E360775B scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
    _id_22F7E3F7E360775B notify("last_stand_revived");
    self.fastcrouchspeedmod = 0;
    scripts\mp\weapons::updatemovespeedscale();

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
      if(!istrue(level.gameended)) {
        _id_22F7E3F7E360775B _id_2CEDCC356F1B9FC8::setplayerdownedextrainfo(0);
        scripts\mp\events::revivedplayer(reviver, _id_22F7E3F7E360775B);
        scripts\cp_mp\challenges::onlaststandrevive(reviver, _id_22F7E3F7E360775B);
        _id_22F7E3F7E360775B scripts\cp_mp\challenges::startchallengetimer("alive_not_downed");

        if(reviver != _id_22F7E3F7E360775B) {
          reviver scripts\mp\utility\stats::incpersstat("rescues", 1);
          reviver scripts\mp\codcasterclientmatchdata::_id_48544E365F4F5648(17, 1);
          _id_22F7E3F7E360775B scripts\mp\utility\stats::incpersstat("rescued", 1);
        }

        _id_22F7E3F7E360775B.deathsdoorsfx = 0;
        _id_22F7E3F7E360775B _id_6A5D3BF7A5B7064A::onexitdeathsdoor(1);
      }

      if(!_id_2CEDCC356F1B9FC8::istutorial()) {
        _id_8C958BDE9A9F8547 = getdvarint("dvar_60FA486ADA22DBA2", 0);

        switch (_id_8C958BDE9A9F8547) {
          case 1:
            _id_22F7E3F7E360775B playsoundtoteam("br_player_revived", _id_22F7E3F7E360775B.team, undefined, self);
            break;
          case 2:
            playsoundatpos(_id_22F7E3F7E360775B.origin, "br_player_revived");
            break;
          case 0:
          default:
            break;
        }
      }

      _id_4451EF3CADC98110(0);
    }

    if(reviver != _id_22F7E3F7E360775B) {
      if(_id_22F7E3F7E360775B.team == reviver.team) {
        if(_id_396A814D39E7044F::_id_7BA31CB6B21C346F())
          _id_22F7E3F7E360775B thread _id_396A814D39E7044F::_id_36EDF91561322753(2);
        else
          level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "stat_1F1F4FE800E03B33");
      } else
        level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "stat_E44D24D831D79C62");
    } else
      level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "stat_8C6FAF2929248DA5");

    _id_E95CD93FDB0F51A8 = "crouch";

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
      if(istrue(self._id_84649776F0D63667))
        _id_E95CD93FDB0F51A8 = "prone";

      self._id_84649776F0D63667 = undefined;
    }

    _id_CCBC8F28CB6A19E7 = _id_22F7E3F7E360775B setstance(_id_E95CD93FDB0F51A8);

    if(!_id_CCBC8F28CB6A19E7) {
      _id_82EE04DFA5B600E1 = _id_E95CD93FDB0F51A8 == "crouch";
      _id_CCBC8F28CB6A19E7 = _id_22F7E3F7E360775B setstance(scripts\engine\utility::ter_op(_id_82EE04DFA5B600E1, "prone", "crouch"));
    }

    _id_22F7E3F7E360775B._id_63B104851A574F2A = reviver;

    if(reviver != _id_22F7E3F7E360775B) {
      thread _id_189B67B2735B981D::_id_BD70B31DD13292BC(reviver);
      thread _id_189B67B2735B981D::_id_BD70A21DD1326D59(_id_22F7E3F7E360775B);
    }
  }

  _id_22F7E3F7E360775B takelaststandtransitionweapon();
  _id_22F7E3F7E360775B thread _id_78D588E2E4CBDA39();
  return _id_22F7E2F7E3607528;
}

_id_78D588E2E4CBDA39() {
  self endon("death_or_disconnect");

  if(level.gametype != "br") {
    return;
  }
  _id_3B64EB40368C1450::set("laststand", "offhand_secondary_weapons", 0);

  while(self isthrowingbackgrenade()) {
    self._id_47F9A068DF7C5418 = 1;
    self giveandfireoffhand("rock_mp");
    wait 1;
  }

  _id_3B64EB40368C1450::set("laststand", "offhand_secondary_weapons", 1);
}

_id_70F1DBC7125939B8(_id_70687E0CC558A009, interrogator, team) {
  _id_5BEBD2013B0F01EC = self;
  _id_5BEBD3013B0F041F = 0;

  if(!isDefined(_id_5BEBD2013B0F01EC) || !isalive(_id_5BEBD2013B0F01EC))
    return 0;

  self.fastcrouchspeedmod = 0;
  scripts\mp\weapons::updatemovespeedscale();

  if(_id_70687E0CC558A009 == "use_hold_interrogate_success")
    _id_5BEBD3013B0F041F = 1;

  _id_5BEBD2013B0F01EC._id_895C1AAAC16F7256 = 0;
  scripts\mp\utility\outline::outlinedisable(_id_5BEBD2013B0F01EC._id_21FC661949481CED, _id_5BEBD2013B0F01EC);
  _id_5BEBD2013B0F01EC allowmovement(1);

  if(_id_5BEBD3013B0F041F) {
    _id_5BEBD2013B0F01EC scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
    _id_5BEBD2013B0F01EC notify("last_stand_interrogated");

    if(isDefined(self.laststandoutlineid)) {
      scripts\mp\utility\outline::outlinedisable(self.laststandoutlineid, self);
      self.laststandoutlineid = undefined;
    }

    interrogator scripts\mp\utility\stats::incpersstat("interrogations", 1);
    interrogator thread _id_1B56D7C4FE15B79C(interrogator, _id_5BEBD2013B0F01EC);
    objweapon = makeweapon("interrogation_tools_mp");
    obituary(_id_5BEBD2013B0F01EC, interrogator, objweapon, "MOD_INTERROGATE", level.teamdata[interrogator.team]["alivePlayers"]);
    obituary(_id_5BEBD2013B0F01EC, interrogator, objweapon, "MOD_INTERROGATE", level.teamdata[_id_5BEBD2013B0F01EC.team]["alivePlayers"]);

    foreach(_id_F0EA4030349A33D5 in level.teamdata[interrogator.team]["alivePlayers"]) {
      if(!isDefined(_id_F0EA4030349A33D5)) {
        continue;
      }
      _id_9B042F0EF4A15A40 = interrogator getentitynumber();
      _id_F0EA4030349A33D5 thread scripts\mp\hud_message::showsplash("br_enemy_interrogated_center", _id_9B042F0EF4A15A40, interrogator);
    }

    foreach(_id_F0EA4030349A33D5 in level.teamdata[_id_5BEBD2013B0F01EC.team]["alivePlayers"]) {
      if(!isDefined(_id_F0EA4030349A33D5)) {
        continue;
      }
      _id_FBC3739D54C0A83F = _id_5BEBD2013B0F01EC getentitynumber();
      _id_F0EA4030349A33D5 thread scripts\mp\hud_message::showsplash("br_teammate_interrogated_center", _id_FBC3739D54C0A83F, _id_5BEBD2013B0F01EC);
    }

    _id_5BEBD2013B0F01EC playSound("br_player_interrogated_enemy");
    _id_B37595AFABEFA038(interrogator, _id_5BEBD2013B0F01EC);
  }

  return _id_5BEBD3013B0F041F;
}

_id_B37595AFABEFA038(interrogator, _id_5BEBD2013B0F01EC) {
  _id_0E6DF16E26EDACEA = getdvarint("dvar_2E92604AF6208D28", 0);

  if(_id_0E6DF16E26EDACEA != 0) {
    _id_257077AD57A19A9B = 0;

    if(_id_0E6DF16E26EDACEA == 1 || _id_0E6DF16E26EDACEA == 3)
      _id_257077AD57A19A9B = _id_257077AD57A19A9B + getdvarint("dvar_D856D9DC9669C4F2", 100);

    if(_id_0E6DF16E26EDACEA == 2 || _id_0E6DF16E26EDACEA == 3) {
      if(isDefined(_id_5BEBD2013B0F01EC.plundercount) && _id_5BEBD2013B0F01EC.plundercount > 0) {
        _id_FB2196E070A5D84E = _id_5BEBD2013B0F01EC.plundercount;
        _id_8B0211F6498A95B7 = getdvarfloat("dvar_97E42D15F6DD7208", 0.2);
        _id_257077AD57A19A9B = _id_257077AD57A19A9B + int(_id_FB2196E070A5D84E * _id_8B0211F6498A95B7);
        _id_A356A7A2D1D5B890 = int(_id_FB2196E070A5D84E - _id_FB2196E070A5D84E * _id_8B0211F6498A95B7);
        _id_5BEBD2013B0F01EC _id_6AFF3948CF4CCA03::playersetplundercount(_id_A356A7A2D1D5B890);
      }
    }

    lootid = level.br_pickups._id_7B2BFF2D04EE1017["brloot_plunder_cash_uncommon_1"];

    if(isDefined(lootid)) {
      _id_FBB5190911C15C1B = interrogator getvieworigin();
      interrogator _id_7E52B56769FA7774::_id_37BE6E543436F3B3(lootid, _id_FBB5190911C15C1B, 1, _id_257077AD57A19A9B);
    }

    interrogator _id_6AFF3948CF4CCA03::playerplunderpickup(_id_257077AD57A19A9B);
    interrogator _id_6AFF3948CF4CCA03::_id_05A2284274D70F7D(0, _id_257077AD57A19A9B);
    _id_3466C10973E9C476 = _id_6AFF3948CF4CCA03::getplundernamebyamount(_id_257077AD57A19A9B);
    _id_09D5BC8E32EE3635 = _id_7E52B56769FA7774::getcashsoundaliasforplayer(interrogator, _id_3466C10973E9C476);
    playsoundatpos(_id_5BEBD2013B0F01EC.origin, _id_09D5BC8E32EE3635);
  } else if(level._id_A9978096255CD8ED == 1) {
    if(isDefined(_id_5BEBD2013B0F01EC.plundercount) && _id_5BEBD2013B0F01EC.plundercount > 0) {
      _id_FB2196E070A5D84E = _id_5BEBD2013B0F01EC.plundercount;
      _id_8B0211F6498A95B7 = level._id_201395EE05E5C10D;
      _id_6CA9968104A4E778 = int(_id_FB2196E070A5D84E * _id_8B0211F6498A95B7);
      _id_A356A7A2D1D5B890 = _id_FB2196E070A5D84E - _id_6CA9968104A4E778;
      _id_257077AD57A19A9B = interrogator.plundercount + _id_6CA9968104A4E778;
      interrogator _id_6AFF3948CF4CCA03::playersetplundercount(_id_257077AD57A19A9B);
      _id_5BEBD2013B0F01EC _id_6AFF3948CF4CCA03::playersetplundercount(_id_A356A7A2D1D5B890);
    }
  }
}

decayreviveprogress() {
  self.owner endon("last_stand_finished");
  self.owner endon("last_stand_heal_active");
  self.owner endon("disconnect");
  self endon("use_hold_revive_start");
  self endon("use_hold_interrogate_start");
  self endon("self_revive_start");
  self endon("death");
  level endon("game_ended");
  _id_4F9DE8926149AA65 = level.laststandrevivedecayscale;

  if(_id_4F9DE8926149AA65 <= 0) {
    return;
  }
  for(;;) {
    self.curprogress = self.curprogress - level.frameduration * _id_4F9DE8926149AA65;

    if(self.curprogress <= 0) {
      self.curprogress = 0;
      return;
    }

    waitframe();
  }
}

_id_1F761672C3708743() {
  if(getdvarint("dvar_B12DFD71B2D623AF", 0))
    decayreviveprogress();
  else
    self.curprogress = 0;
}

_id_1B56D7C4FE15B79C(interrogator, victim) {
  level endon("game_ended");
  _id_864C4C4116D403EA = interrogator.matchdatalifeindex;
  _id_68FA2B6918F6E714 = victim.matchdatalifeindex;
  _id_2C3D3F5969BF19B5 = getdvarfloat("dvar_6ACFBD4650E8691F", 300);
  _id_4907BB8D6F92AC4D = getdvarfloat("dvar_A8E0E2BF5A22916C", 5);
  _id_74AAB602082BB02B = int(_id_4907BB8D6F92AC4D * 1000);
  _id_8B226FA0A4438980 = 0;
  _id_4F8E6F961392009F = gettime();
  _id_4218A6A2DF4A5555 = 99;
  _id_6562C7C3C91A0C6A = 0;
  victimteam = victim.team;
  _id_0D33A0BAA5624A4A = interrogator.team;
  _id_26568FED2B866C11 = level.teamdata[victimteam]["players"];
  _id_48B7B944A7A02B2C = victim scripts\mp\utility\player::getuniqueid();
  _id_4EC493E39340A7CE = interrogator scripts\mp\utility\player::getuniqueid();

  if(!isDefined(_id_48B7B944A7A02B2C))
    _id_48B7B944A7A02B2C = victim.clientid;

  if(!isDefined(_id_4EC493E39340A7CE))
    _id_4EC493E39340A7CE = interrogator.clientid;

  _id_0F0B26F5F8DB069E = getdvarint("dvar_3C56D9EF17112CDD", 3);

  if(_id_0F0B26F5F8DB069E == 2)
    victim._id_D2F1408E18D00988 = undefined;

  wait 2;
  thread _id_38526FF55909D928(interrogator, victim);

  foreach(player in _id_26568FED2B866C11) {
    if(isDefined(player.plantedlethalequip))
      _id_6562C7C3C91A0C6A = _id_6562C7C3C91A0C6A + player.plantedlethalequip.size;
  }

  _id_7FAC7BEE548FBDD8(_id_0D33A0BAA5624A4A, victimteam, _id_48B7B944A7A02B2C);
  _id_F67D2E6165B4028A = 0;

  while(_id_F67D2E6165B4028A == 0) {
    _id_C3B838DEB5A442D4 = 2;

    if(isDefined(interrogator) && isDefined(victim))
      _id_C3B838DEB5A442D4 = distance2d(interrogator.origin, victim.origin) / _id_2C3D3F5969BF19B5;

    switch (_id_0F0B26F5F8DB069E) {
      case 1:
        _id_F67D2E6165B4028A = _id_8924785604554899(interrogator, victim);
        break;
      case 3:
        _id_F67D2E6165B4028A = _id_B4C6CB65B8221E77(interrogator, victim, _id_4F8E6F961392009F + 2000);
        break;
      case 2:
        if(!isDefined(victim.laststanddowneddata) && !isDefined(victim._id_D2F1408E18D00988))
          victim._id_D2F1408E18D00988 = gettime();

        _id_F67D2E6165B4028A = _id_59DB0668402EF9D0(interrogator, victim);
        break;
      case 4:
        _id_F67D2E6165B4028A = _id_2916FC520C1ADA8D(interrogator, victim, _id_4F8E6F961392009F + 2000);
        break;
      case 0:
      default:
        _id_F67D2E6165B4028A = _id_D5BCE40589690EFB(interrogator, victim, _id_C3B838DEB5A442D4);
        break;
    }

    if(_id_F67D2E6165B4028A) {
      interrogator notify("interrogation_signal_lost");
      _id_8F5CF57CB69D0DF5(_id_0D33A0BAA5624A4A, victimteam, _id_48B7B944A7A02B2C);

      if(isDefined(victim) && isDefined(victim.laststandreviveent)) {
        victim.laststandreviveent._id_F1DA02A134648443 = 3;
        victim.laststandreviveent _id_4C452A6C72371F17();
      }

      break;
    }

    if(_id_8B226FA0A4438980 + _id_74AAB602082BB02B < gettime()) {
      _id_7AA1FF687CFC30D1 = scripts\mp\equipment\snapshot_grenade::snapshot_grenade_createoutlinedata(interrogator, interrogator.origin);
      _id_26568FED2B866C11 = scripts\engine\utility::array_removeundefined(_id_26568FED2B866C11);

      foreach(player in _id_26568FED2B866C11) {
        if(!isalive(player)) {
          continue;
        }
        if(!player scripts\mp\utility\perk::_hasperk("specialty_snapshot_immunity")) {
          player thread _id_DA121B53657256C7(interrogator, _id_4907BB8D6F92AC4D);

          if(getdvarint("dvar_A77CF11D23A937F4", 0) == 1)
            player thread _id_F8B195391CED24FC(interrogator, _id_4907BB8D6F92AC4D);
          else
            player thread _id_980D4A9E760F8E0E(interrogator, _id_4907BB8D6F92AC4D);

          player _id_8B6CB3C86797EAD5(interrogator, _id_4907BB8D6F92AC4D);
          continue;
        }

        interrogator _id_5762AC2F22202BA2::updatedamagefeedback("hittacresist");
      }

      _id_8B226FA0A4438980 = gettime();
    }

    waitframe();
  }

  _id_126C5BA5E88A23B7 = int(gettime() - _id_4F8E6F961392009F);
  scripts\mp\analyticslog::_id_B4E1D087442647EF(_id_864C4C4116D403EA, _id_68FA2B6918F6E714, _id_26568FED2B866C11.size, int(_id_6562C7C3C91A0C6A), _id_126C5BA5E88A23B7, _id_F67D2E6165B4028A);

  if(isDefined(interrogator))
    _id_715028F54BAD19A1::_id_3461C9A3DBBCCECF(interrogator, _id_126C5BA5E88A23B7, scripts\engine\utility::string(_id_6562C7C3C91A0C6A));

  if(isDefined(victim))
    _id_715028F54BAD19A1::_id_82B50D847253078F(victim, _id_26568FED2B866C11.size);
}

_id_38526FF55909D928(attacker, victim) {
  level endon("game_ended");

  if(!isDefined(victim) || !isDefined(attacker)) {
    return;
  }
  _id_122194CEEC0993A8 = level._effect["vfx_br_interr_in"];
  playfxontagforclients(_id_122194CEEC0993A8, victim, "tag_origin", attacker);
  playfxontagforclients(_id_122194CEEC0993A8, victim, "tag_origin", victim);
  scripts\engine\utility::waittill_any_ents(attacker, "interrogation_signal_lost", attacker, "death_or_disconnect", victim, "death_or_disconnect", victim, "last_stand_finished", victim, "enter_live_ragdoll");
  killfxontag(_id_122194CEEC0993A8, victim, "tag_origin");
}

_id_7FAC7BEE548FBDD8(_id_0D33A0BAA5624A4A, victimteam, _id_22932BFDCF2AF2D9) {
  _id_26568FED2B866C11 = level.teamdata[victimteam]["players"];
  _id_CCBA29FA2A3A27FF = level.teamdata[_id_0D33A0BAA5624A4A]["players"];

  foreach(player in _id_26568FED2B866C11) {
    if(!isDefined(player._id_50A75A4BFA03A8E2))
      player._id_50A75A4BFA03A8E2 = [];

    player._id_50A75A4BFA03A8E2 = scripts\engine\utility::_id_6D6AF8144A5131F1(player._id_50A75A4BFA03A8E2, _id_22932BFDCF2AF2D9);
    player setclientomnvar("ui_br_interrogate_team_is_being_tracked", 1);
  }

  foreach(player in _id_CCBA29FA2A3A27FF) {
    if(!isDefined(player._id_8D021AB39B012F9D))
      player._id_8D021AB39B012F9D = [];

    player._id_8D021AB39B012F9D = scripts\engine\utility::_id_6D6AF8144A5131F1(player._id_8D021AB39B012F9D, _id_22932BFDCF2AF2D9);
    player setclientomnvar("ui_br_interrogate_tracking_other_team", 1);
  }
}

_id_8F5CF57CB69D0DF5(_id_0D33A0BAA5624A4A, victimteam, _id_22932BFDCF2AF2D9) {
  _id_26568FED2B866C11 = level.teamdata[victimteam]["players"];
  _id_CCBA29FA2A3A27FF = level.teamdata[_id_0D33A0BAA5624A4A]["players"];

  foreach(player in _id_26568FED2B866C11) {
    if(!isDefined(player._id_50A75A4BFA03A8E2))
      player._id_50A75A4BFA03A8E2 = [];

    player._id_50A75A4BFA03A8E2 = scripts\engine\utility::array_remove(player._id_50A75A4BFA03A8E2, _id_22932BFDCF2AF2D9);

    if(player._id_50A75A4BFA03A8E2.size > 0) {
      player setclientomnvar("ui_br_interrogate_team_is_being_tracked", 1);
      continue;
    }

    player setclientomnvar("ui_br_interrogate_team_is_being_tracked", 0);
  }

  foreach(player in _id_CCBA29FA2A3A27FF) {
    if(!isDefined(player._id_8D021AB39B012F9D))
      player._id_8D021AB39B012F9D = [];

    player._id_8D021AB39B012F9D = scripts\engine\utility::array_remove(player._id_8D021AB39B012F9D, _id_22932BFDCF2AF2D9);

    if(player._id_8D021AB39B012F9D.size > 0) {
      player setclientomnvar("ui_br_interrogate_tracking_other_team", 1);
      continue;
    }

    player setclientomnvar("ui_br_interrogate_tracking_other_team", 0);
  }
}

_id_D5BCE40589690EFB(interrogator, victim, _id_C3B838DEB5A442D4) {
  if(!isDefined(victim) || !scripts\mp\utility\player::isreallyalive(victim))
    return 1;

  if(!scripts\mp\utility\player::isinlaststand(victim))
    return 2;

  if(!isDefined(interrogator) || !scripts\mp\utility\player::isreallyalive(interrogator))
    return 3;

  if(_id_C3B838DEB5A442D4 > 1.0)
    return 4;

  return 0;
}

_id_8924785604554899(interrogator, victim) {
  if(!isDefined(interrogator) || !scripts\mp\utility\player::isreallyalive(interrogator))
    return 3;

  if(!scripts\mp\utility\player::isinlaststand(victim))
    return 2;

  if(!isDefined(victim) || !scripts\mp\utility\player::isreallyalive(victim))
    return 1;

  return 0;
}

_id_59DB0668402EF9D0(interrogator, victim) {
  if(!isDefined(interrogator) || !scripts\mp\utility\player::isreallyalive(interrogator))
    return 3;

  _id_3DE93940B47ADAB4 = 0;

  if(isDefined(victim._id_D2F1408E18D00988)) {
    duration = int(getdvarint("dvar_C1469BE98181753D", 15.0) * 1000);
    _id_3DE93940B47ADAB4 = gettime() > victim._id_D2F1408E18D00988 + duration;
  }

  if(!scripts\mp\utility\player::isinlaststand(victim) && _id_3DE93940B47ADAB4)
    return 2;

  if((!isDefined(victim) || !scripts\mp\utility\player::isreallyalive(victim)) && _id_3DE93940B47ADAB4)
    return 1;

  return 0;
}

_id_B4C6CB65B8221E77(interrogator, victim, starttime) {
  if(!isDefined(interrogator) || !scripts\mp\utility\player::isreallyalive(interrogator))
    return 3;

  duration = int(getdvarint("dvar_C1469BE98181753D", 15.0) * 1000);
  _id_3DE93940B47ADAB4 = gettime() > starttime + duration;

  if(!scripts\mp\utility\player::isinlaststand(victim) && _id_3DE93940B47ADAB4)
    return 2;

  if((!isDefined(victim) || !scripts\mp\utility\player::isreallyalive(victim)) && _id_3DE93940B47ADAB4)
    return 1;

  return 0;
}

_id_2916FC520C1ADA8D(interrogator, victim, starttime) {
  if(!isDefined(interrogator) || !scripts\mp\utility\player::isreallyalive(interrogator))
    return 3;

  duration = int(getdvarint("dvar_C1469BE98181753D", 15.0) * 1000);

  if(gettime() > starttime + duration)
    return 4;

  return 0;
}

_id_0F671D7EFEF879A1(attacker, victim) {
  if(attacker _meth_E40102956C887F7C() || victim _meth_E40102956C887F7C())
    return 4;

  _id_F22D5402740E9B35 = attacker getmovingplatformparent();
  _id_7E63B8C286D4794E = victim getmovingplatformparent();

  if(isDefined(_id_F22D5402740E9B35) || isDefined(_id_7E63B8C286D4794E))
    return 2;

  if(abs(attacker.origin[2] - victim.origin[2]) > 30)
    return 1;

  dir = _id_16F1ED28A559F91F(attacker, victim);
  [_id_691D365A2045E893, _id_67D8DDF901F65B1D, _id_93E84816600B6F9B, _id_439AE466E036AC7D] = _id_341C7024A3E54638(dir, victim, attacker);
  _id_86C1C8628B1D55F8 = victim.origin + _id_691D365A2045E893;
  _id_67D8DDF901F65B1D = (0, _id_67D8DDF901F65B1D[1], 0);
  ignoreents = [attacker, victim];

  if(!attacker scripts\engine\trace::player_trace_passed(attacker.origin + (0, 0, 10), _id_86C1C8628B1D55F8 + (0, 0, 10), _id_67D8DDF901F65B1D, ignoreents))
    return 0;

  return 5;
}

_id_A5C6DC149AFB51C9(interrogator, outlinetime) {
  self endon("disconnect");
  level endon("game_ended");
  victim = self;

  if(isPlayer(victim)) {
    if(isDefined(victim.painted) && victim.painted == 1) {
      return;
    }
    _id_5283D6ED761E8022 = 2000;

    if(istrue(victim._id_89E94D8F0846D342))
      _id_5283D6ED761E8022 = 500;

    if(!isDefined(outlinetime))
      outlinetime = 5;

    victim.painted = 1;
    _id_1F6DF6FD9A4A3EA0 = 0;

    while(_id_1F6DF6FD9A4A3EA0 < level._id_3908273E5522E91D) {
      if(!level.teambased)
        id = scripts\mp\utility\outline::outlineenableforplayer(victim, interrogator, "outlinefill_nodepth_red", "equipment");
      else if(_id_58BE75C518BF0D40::shouldmodesetsquads())
        id = scripts\mp\utility\outline::outlineenableforsquad(victim, interrogator.team, interrogator._id_0FF97225579DE16A, "outlinefill_nodepth_red", "equipment");
      else
        id = scripts\mp\utility\outline::outlineenableforteam(victim, interrogator.team, "outlinefill_nodepth_red", "equipment");

      triggerportableradarpingteam(victim.origin, interrogator.team, level._id_0575CB25B5D41B53, int(_id_5283D6ED761E8022));
      victim iprintlnbold("You are compromised!");
      result = victim scripts\engine\utility::waittill_any_timeout_1(outlinetime, "death");

      if(result == "death") {
        scripts\mp\utility\outline::outlinedisable(id, victim);
        victim.painted = 0;
        return;
      }

      scripts\mp\utility\outline::outlinedisable(id, victim);
      _id_1F6DF6FD9A4A3EA0++;
      wait 1;
    }

    victim.painted = 0;
  }
}

_id_DA121B53657256C7(interrogator, _id_B6B08A6A6F96B5C4) {
  victim = self;

  if(isPlayer(victim)) {
    if(isDefined(victim.painted) && victim.painted == 1) {
      return;
    }
    _id_5283D6ED761E8022 = _id_B6B08A6A6F96B5C4 * 1000;
    _id_2DBCBBE66AA95FAF = getdvarint("dvar_DE39BEF0E704C70B", 1);

    if(_id_2DBCBBE66AA95FAF == 0) {
      return;
    }
    switch (_id_2DBCBBE66AA95FAF) {
      case 3:
        break;
      case 2:
        _id_5283D6ED761E8022 = int(_id_5283D6ED761E8022 * 0.75);
        break;
      case 1:
      default:
        _id_5283D6ED761E8022 = int(_id_5283D6ED761E8022 * 0.25);
        break;
    }

    triggerportableradarpingteam(victim.origin, interrogator.team, level._id_0575CB25B5D41B53, int(_id_5283D6ED761E8022));
  }
}

_id_F8B195391CED24FC(interrogator, waittime) {
  victim = self;

  if(!isDefined(victim)) {
    return;
  }
  if(isPlayer(victim)) {
    if(isDefined(victim._id_8AB4C2FC351EEFF8) && victim._id_8AB4C2FC351EEFF8 == 1) {
      return;
    }
    victim._id_9283BB519D50DCF5 = 1;
    _id_78FE05BBD455392E = getdvarint("dvar_CC42E9E3EB814F82", 1);

    if(_id_78FE05BBD455392E == 0) {
      return;
    }
    if(!isDefined(waittime))
      waittime = 2.5;

    switch (_id_78FE05BBD455392E) {
      case 3:
        break;
      case 2:
        waittime = waittime * 0.75;
        break;
      case 1:
      default:
        waittime = waittime * 0.25;
        break;
    }

    icon = victim thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(interrogator.team, "hud_icon_new_marked", 8, 1, 5000, 500, undefined, 1, 1);
    victim _id_6D68CFDF0836123C::_id_FA08D1D78CF5CB01();
    victim thread _id_80DC9867BC1B31F8(icon, waittime);
  }
}

_id_80DC9867BC1B31F8(icon, waittime) {
  level endon("game_ended");
  self endon("disconnect");
  scripts\engine\utility::waittill_notify_or_timeout("death", waittime);
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(icon);
  self._id_8AB4C2FC351EEFF8 = 0;
}

_id_980D4A9E760F8E0E(interrogator, outlinetime) {
  victim = self;

  if(!isDefined(victim)) {
    return;
  }
  if(isPlayer(victim)) {
    if(isDefined(victim.painted) && victim.painted == 1) {
      return;
    }
    _id_78FE05BBD455392E = getdvarint("dvar_CC42E9E3EB814F82", 1);

    if(_id_78FE05BBD455392E == 0) {
      return;
    }
    if(!isDefined(outlinetime))
      outlinetime = 2.5;

    switch (_id_78FE05BBD455392E) {
      case 3:
        break;
      case 2:
        outlinetime = outlinetime * 0.75;
        break;
      case 1:
      default:
        outlinetime = outlinetime * 0.25;
        break;
    }

    victim.painted = 1;

    if(!level.teambased)
      id = scripts\mp\utility\outline::outlineenableforplayer(victim, interrogator, "outlinefill_nodepth_orange", "equipment");
    else if(_id_58BE75C518BF0D40::shouldmodesetsquads())
      id = scripts\mp\utility\outline::outlineenableforsquad(victim, interrogator.team, interrogator._id_0FF97225579DE16A, "outlinefill_nodepth_orange", "equipment");
    else
      id = scripts\mp\utility\outline::outlineenableforteam(victim, interrogator.team, "outlinefill_nodepth_orange", "equipment");

    victim scripts\mp\utility\outline::_hudoutlineviewmodelenable("outlinefill_nodepth_orange", 0);
    victim _id_6D68CFDF0836123C::_id_FA08D1D78CF5CB01();
    victim thread watchpainted(id, outlinetime);
    victim thread watchpaintedagain(id);
  }
}

_id_8B6CB3C86797EAD5(interrogator, outlinetime) {
  victim = self;

  if(isPlayer(victim)) {
    if(!isDefined(outlinetime))
      outlinetime = 5;

    if(!isDefined(victim.plantedlethalequip) || victim.plantedlethalequip.size == 0) {
      return;
    }
    foreach(equipment in scripts\engine\utility::array_removeundefined(victim.plantedlethalequip)) {
      if(!level.teambased)
        _id_F275474AACD30C96 = scripts\mp\utility\outline::outlineenableforplayer(equipment, interrogator, "outlinefill_nodepth_orange", "equipment");
      else if(_id_58BE75C518BF0D40::shouldmodesetsquads())
        _id_F275474AACD30C96 = scripts\mp\utility\outline::outlineenableforsquad(equipment, interrogator.team, interrogator._id_0FF97225579DE16A, "outlinefill_nodepth_orange", "equipment");
      else
        _id_F275474AACD30C96 = scripts\mp\utility\outline::outlineenableforteam(equipment, interrogator.team, "outlinefill_nodepth_orange", "equipment");

      equipment thread watchpainted(_id_F275474AACD30C96, outlinetime);
      equipment thread watchpaintedagain(_id_F275474AACD30C96);
    }
  }
}

watchpainted(id, timeout) {
  self notify("painted_again");
  self endon("painted_again");
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_timeout_1(timeout, "death");
  scripts\mp\utility\outline::outlinedisable(id, self);

  if(isDefined(self) && isPlayer(self)) {
    self.painted = 0;
    scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
  }

  if(isDefined(self))
    self notify("painted_end");
}

watchpaintedagain(id) {
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_2("painted_again", "painted_end");
  scripts\mp\utility\outline::outlinedisable(id, self);
}

useholdthink(reviver, usetime, interrogation) {
  self.owner endon("last_stand_finished");
  reviver endon("death");
  level endon("game_ended");

  if(!isDefined(interrogation))
    interrogation = 0;

  self._id_4AF51E13229C40FE = reviver;
  _id_22F7E3F7E360775B = self.owner;
  _id_6A1154C8BC126A40 = getdvarint("dvar_C959AF6F995BF79A");
  _id_93DA003F4F870AF4 = spawn("script_origin", self.origin);
  _id_93DA003F4F870AF4 hide();

  if(!_id_6A1154C8BC126A40 && !self.owner _id_556B8AEAA691317F::_id_F0D1C9C39359EFFF())
    reviver _id_3B64EB40368C1450::_id_3633B947164BE4F3("laststand_revive", 0);

  if(istrue(interrogation))
    self notify("use_hold_interrogate_start");
  else
    self notify("use_hold_revive_start");

  if(!self.owner _id_556B8AEAA691317F::_id_F0D1C9C39359EFFF() && !interrogation)
    reviver thread sfx_revive_lp();

  if(_id_6A1154C8BC126A40)
    dragallyprototype(reviver, _id_22F7E3F7E360775B);

  if(!isDefined(self.curprogress) || isDefined(self._id_D50D5A16DF84DF44))
    self.curprogress = 0;

  self._id_D50D5A16DF84DF44 = undefined;
  self.inuse = 1;
  self.userate = 0;
  _id_391186B6DAE520CC = 0;

  if(isDefined(usetime))
    self.usetime = usetime;

  if(!interrogation) {
    if(reviver scripts\mp\utility\perk::_hasperk("specialty_medic"))
      self.usetime = scripts\mp\utility\dvars::getwatcheddvar("lastStandReviveTimer") * 1000 * getdvarfloat("perk_medicReviveSpeedRatio");
    else
      self.usetime = scripts\mp\utility\dvars::getwatcheddvar("lastStandReviveTimer") * 1000;

    if(_id_22F7E3F7E360775B scripts\mp\utility\perk::_hasperk("specialty_survivor") && isDefined(level._id_A4BF58776C3BE9D3))
      self.usetime = level._id_A4BF58776C3BE9D3;

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && reviver scripts\mp\utility\perk::_hasperk("specialty_br_faster_revive"))
      self.usetime = self.usetime * 0.75;
  } else
    self.usetime = getdvarfloat("dvar_DDBF6F11FC2231F2", 3) * 1000;

  if(!interrogation) {
    if(_id_22F7E3F7E360775B.team == reviver.team)
      level thread scripts\mp\battlechatter_mp::trysaylocalsound(reviver, "stat_572347275DFB41AB");
    else
      level thread scripts\mp\battlechatter_mp::trysaylocalsound(reviver, "stat_E716D32302942AAA");
  }

  thread useholdthinkcleanup(reviver, _id_93DA003F4F870AF4, interrogation);
  thread useholdthinkloop(reviver);
}

dragallyprototype(reviver, _id_22F7E3F7E360775B) {
  _id_B25CA392892D7A80 = self;
  _id_22F7E3F7E360775B playerlinkTo(reviver);
  _id_22F7E3F7E360775B playerlinkedoffsetenable();
  _id_22F7E3F7E360775B allowmovement(0);
  reviver setmovespeedscale(getdvarfloat("dvar_CCFB1FE297CE6F9B"));
}

cleanupdragallyprototype(reviver, _id_22F7E3F7E360775B) {
  _id_22F7E3F7E360775B unlink();
  _id_22F7E3F7E360775B allowmovement(1);
  reviver setmovespeedscale(1);
}

useholdthinkcleanup(reviver, _id_93DA003F4F870AF4, interrogation) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(!isDefined(interrogation))
    interrogation = 0;

  _id_6A1154C8BC126A40 = getdvarint("dvar_C959AF6F995BF79A");
  _id_22F7E3F7E360775B = self.owner;
  _id_4930CBCE302555B1 = _id_22F7E3F7E360775B scripts\engine\utility::waittill_any_return_no_endon_death_4("death_or_disconnect", "use_hold_think_success", "use_hold_think_fail", "last_stand_finished");
  _id_888761054DF5B48C = reviver scripts\cp_mp\vehicles\vehicle_occupancy::_id_2E8745A2D6EC9FD1();

  if(isDefined(_id_888761054DF5B48C))
    level thread scripts\cp_mp\vehicles\vehicle::vehicle_preventplayercollisiondamagefortimeafterexit(_id_888761054DF5B48C, reviver);

  self.inuse = 0;
  _id_93DA003F4F870AF4 delete();

  if(isDefined(reviver)) {
    reviver scripts\mp\teamrevive::_id_00A3FFE1D08888C2();
    reviver buddyrevivingdoneanimevent();
    reviver setlaststandreviving(0);

    if(istrue(interrogation)) {
      reviver._id_93018D510A589832 = 0;

      if(isDefined(_id_22F7E3F7E360775B))
        _id_22F7E3F7E360775B._id_895C1AAAC16F7256 = 0;
    } else
      reviver _id_42D99E200AA9762A(_id_22F7E3F7E360775B);

    reviver scripts\mp\gameobjects::updateuiprogress(self, 0);

    if(reviver _meth_C6CB3E654225077A())
      reviver forceusehintoff();

    reviver notify("sfx_revive_done");
  }

  if(isDefined(_id_22F7E3F7E360775B))
    _id_22F7E3F7E360775B scripts\mp\gameobjects::updateuiprogress(self, 0);

  if(scripts\mp\utility\player::isreallyalive(reviver)) {
    if(_id_6A1154C8BC126A40)
      cleanupdragallyprototype(reviver, _id_22F7E3F7E360775B);
    else
      reviver _id_3B64EB40368C1450::_id_588F2307A3040610("laststand_revive");
  }

  if(_id_4930CBCE302555B1 == "use_hold_think_success") {
    if(istrue(interrogation))
      reviver thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_1D723C55CEAA52DC");
    else if(reviver.team == self.owner.team)
      reviver thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_AB2FA142759B4C26");

    if(istrue(level.allowselfrevive))
      reviver allowselfrevive(1);

    if(!scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73()) {
      if(!istrue(interrogation)) {
        if(_id_22F7E3F7E360775B.team == reviver.team)
          _id_22F7E3F7E360775B thread scripts\mp\rank::scoreeventpopup("stat_AB2FB342759B6ABC");
      }
    }

    if(istrue(interrogation)) {
      self._id_D50D5A16DF84DF44 = 1;
      self notify("use_hold_interrogate_success");
    } else {
      if(isDefined(_id_22F7E3F7E360775B)) {
        _id_22F7E3F7E360775B thread scripts\mp\hud_message::showsplash("revived", undefined, reviver);
        _id_22F7E3F7E360775B.inlaststand = 0;
      }

      self notify("use_hold_revive_success");
    }

    return;
  } else if(_id_4930CBCE302555B1 == "use_hold_think_fail") {
    if(isDefined(_id_22F7E3F7E360775B))
      _id_22F7E3F7E360775B notify("handle_revive_message");
  }

  if(istrue(interrogation))
    self notify("use_hold_interrogate_fail");
  else
    self notify("use_hold_revive_fail");

  if(isDefined(reviver))
    reviver._id_A23F35F8460D8857 = undefined;

  if(isDefined(_id_22F7E3F7E360775B))
    _id_22F7E3F7E360775B._id_A23F35F8460D8857 = undefined;
}

sfx_revive_lp() {
  _id_4CF58793CC4F1AD6 = spawn("script_origin", self.origin);
  _id_4CF58793CC4F1AD6 linkTo(self);
  _id_4CF58793CC4F1AD6 playLoopSound("br_reviver_use_lp");
  scripts\engine\utility::waittill_any_2("sfx_revive_done", "disconnect");

  if(isDefined(self.origin))
    playsoundatpos(self.origin, "br_reviver_use_end");

  _id_4CF58793CC4F1AD6 delete();
}

useholdthinkloop(reviver) {
  _id_22F7E3F7E360775B = self.owner;
  level endon("game_ended");
  _id_22F7E3F7E360775B endon("death_or_disconnect");
  _id_22F7E3F7E360775B endon("last_stand_finished");
  _id_0E2C5C56BB79DE4B = getdvarint("dvar_A23E8F787D85F762", 0);
  mintime = getdvarint("dvar_15E9B25B07A2BBB6", 0.5) * 1000 + gettime();
  _id_91C8D5414CB0CD50 = 0;

  while(_id_452247E0CEEC0A3B(reviver, _id_22F7E3F7E360775B, mintime, _id_0E2C5C56BB79DE4B)) {
    if(istrue(reviver.tacopsmedicrole))
      return scripts\mp\utility\player::isreallyalive(reviver);

    self.curprogress = self.curprogress + level.frameduration * self.userate;
    self.userate = 1;
    reviver scripts\mp\gameobjects::updateuiprogress(self, 1);

    if(self.curprogress >= self.usetime) {
      _id_22F7E3F7E360775B notify("use_hold_think_success");
      return;
    }

    waitframe();
  }

  _id_22F7E3F7E360775B notify("use_hold_think_fail");
  return;
}

_id_452247E0CEEC0A3B(reviver, _id_22F7E3F7E360775B, mintime, _id_0E2C5C56BB79DE4B) {
  if(!scripts\mp\utility\player::isreallyalive(reviver))
    return 0;

  if(self.curprogress >= self.usetime)
    return 0;

  if(istrue(reviver.inlaststand))
    return 0;

  if(istrue(reviver.extracted) || istrue(_id_22F7E3F7E360775B.extracted))
    return 0;

  if(!reviver _id_F111048FABF84E37(_id_22F7E3F7E360775B) && !istrue(_id_0E2C5C56BB79DE4B) && !(gettime() < mintime))
    return 0;

  if(distancesquared(reviver.origin, self.origin) > 65536 && !_id_22F7E3F7E360775B _id_556B8AEAA691317F::_id_F0D1C9C39359EFFF())
    return 0;

  if(istrue(reviver._id_12BFB031C0A0EFD8))
    return 0;

  if(istrue(reviver isinexecutionvictim()))
    return 0;

  if(istrue(reviver._id_A23F35F8460D8857) || istrue(_id_22F7E3F7E360775B._id_A23F35F8460D8857))
    return 0;

  return 1;
}

suicidesetup() {
  self endon("death_or_disconnect");
  self endon("last_stand_finished");
  level endon("game_ended");
  thread showsuicidehintstring();
  _id_7831C27971FFDE60 = getdvarint("dvar_45DBDC45BDF8F5FF", 0);
  _id_3CBCAF4EDA0F3704 = getdvarfloat("dvar_F36AD71F9FADEC59", 300);

  if(!isbot(self))
    thread suicidemonitorcrouchbuttonpress();

  holdtime = 0;
  _id_58D906AF2CAC1064 = level._id_21BC3423C7E17C34;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    _id_58D906AF2CAC1064 = level._id_84F71F417B53242E;

    if(_id_2A3C9A91BF1D3911())
      _id_58D906AF2CAC1064 = level._id_CCF76D87061DE768;
  }

  for(;;) {
    waitframe();

    if(self stancebuttonPressed() && self isinexecutionvictim() == 0 && !self getbeingrevived() && !selfrevivebuttonPressed(self) && !_id_77799F0211BE1728()) {
      if(_id_2A3C9A91BF1D3911()) {
        if(isDefined(self.laststandreviveent)) {
          if(istrue(self.laststandreviveent._id_9D797A762D9195EB)) {
            holdtime = 0;
            self setclientomnvar("ui_securing", 0);
            self setclientomnvar("ui_securing_progress", 0);
            scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/INTERROGATION_IN_PROGRESS");
            wait 0.5;
            continue;
          }
        }

        if(_id_7831C27971FFDE60) {
          players = scripts\mp\utility\player::getplayersinradius(self.origin, _id_3CBCAF4EDA0F3704);

          foreach(player in players) {
            if(player.team != self.team) {
              self iprintlnbold("There are enemies near by...");
              holdtime = 0;

              if(!selfrevivebuttonPressed(self) && !_id_77799F0211BE1728()) {
                self setclientomnvar("ui_securing", 0);
                self setclientomnvar("ui_securing_progress", 0);
              }

              wait 0.5;
              break;
            }
          }
        }
      }

      self setclientomnvar("ui_securing", 20);

      if(holdtime >= _id_58D906AF2CAC1064) {
        self setclientomnvar("ui_securing", 0);
        self setclientomnvar("ui_securing_progress", 0);
        break;
      }

      _id_5D3A428E1F92C6BA = holdtime / _id_58D906AF2CAC1064;
      self setclientomnvar("ui_securing_progress", _id_5D3A428E1F92C6BA);
      holdtime = holdtime + level.framedurationseconds;
      continue;
    }

    holdtime = 0;

    if(!selfrevivebuttonPressed(self) && !istrue(self.beingrevived) && !_id_77799F0211BE1728())
      self setclientomnvar("ui_securing", 0);
  }

  suicideonend();
}

_id_D9324DC2BCEEDF27(_id_4CE97D438A53F1D5) {
  self endon("death_or_disconnect");
  self endon("stance_pressed_up");
  self endon("endGivUpProgressBar");
  level endon("game_ended");
  self setclientomnvar("ui_securing", 20);
  progress = 0;

  for(;;) {
    if(progress >= _id_4CE97D438A53F1D5) {
      break;
    }

    _id_5D3A428E1F92C6BA = progress / _id_4CE97D438A53F1D5;
    self setclientomnvar("ui_securing_progress", _id_5D3A428E1F92C6BA);
    progress = progress + level.frameduration;
    waitframe();
  }

  self setclientomnvar("ui_securing", 0);
  self setclientomnvar("ui_securing_progress", 0);
}

suicidemonitorcrouchbuttonpress() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self notifyonplayercommand("stance_pressed_down", "+movedown");
  self notifyonplayercommand("stance_pressed_up", "-movedown");
  self notifyonplayercommand("stance_pressed_down", "+stancedown");
  self notifyonplayercommand("stance_pressed_up", "-stancedown");
  holdtime = gettime();
  _id_95E94C34040BC5AD = 0;
  _id_51BEE2F5B3B4E278 = 0;

  if(_id_2A3C9A91BF1D3911())
    _id_58D906AF2CAC1064 = level._id_CCF76D87061DE768;
  else
    _id_58D906AF2CAC1064 = level._id_21BC3423C7E17C34;

  _id_4CE97D438A53F1D5 = _id_58D906AF2CAC1064 * 1000;
  _id_9A87080FB741DE0C = 0;

  while(!_id_9A87080FB741DE0C && !_id_95E94C34040BC5AD) {
    _id_95E94C34040BC5AD = 0;

    if(!_id_51BEE2F5B3B4E278)
      holdtime = gettime();

    _id_CBA40E031462D0A0 = scripts\engine\utility::waittill_any_timeout_5(_id_58D906AF2CAC1064, "stance_pressed_down", "stance_pressed_up", "last_stand_finished", "last_stand_self_revive", "last_stand_bleedout");

    switch (_id_CBA40E031462D0A0) {
      case "stance_pressed_down":
        holdtime = gettime();
        _id_51BEE2F5B3B4E278 = 1;
        thread _id_D9324DC2BCEEDF27(_id_4CE97D438A53F1D5);
        break;
      case "stance_pressed_up":
        _id_51BEE2F5B3B4E278 = 0;
      case "timeout":
        if(_id_51BEE2F5B3B4E278 && gettime() - holdtime >= _id_4CE97D438A53F1D5) {
          self notify("endGiveUpProgressBar");
          _id_95E94C34040BC5AD = 1;
        }

        break;
      default:
        _id_9A87080FB741DE0C = 1;
        break;
    }

    waitframe();
  }

  if(_id_95E94C34040BC5AD)
    suicideonend();

  self notifyonplayercommandremove("stance_pressed_down", "+movedown");
  self notifyonplayercommandremove("stance_pressed_up", "-movedown");
  self notifyonplayercommandremove("stance_pressed_down", "+stancedown");
  self notifyonplayercommandremove("stance_pressed_up", "-stancedown");
}

suicideonend() {
  if(istrue(self.allowselfrevive))
    self notify("last_stand_self_revive");
  else
    self notify("last_stand_bleedout");
}

showsuicidehintstring() {
  if(istrue(self.allowselfrevive))
    self forceusehinton(&"MP/HEROES_RETURN");
  else if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    thread handlerevivemessage();

  scripts\engine\utility::waittill_any_ents(self, "death_or_disconnect", self, "last_stand_finished", level, "game_ended");

  if(!isDefined(self)) {
    return;
  }
  scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
  self forceusehintoff();
}

handlerevivemessage() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("last_stand_finished");

  for(;;) {
    scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
    _id_649E600E12376E07 = 0;
    _id_5237A188CCDA4D7B = scripts\mp\supers::getcurrentsuperref();

    if(isDefined(_id_5237A188CCDA4D7B) && _id_5237A188CCDA4D7B == "super_laststand_heal" && scripts\mp\supers::issuperready())
      _id_649E600E12376E07 = 1;

    if(istrue(scripts\mp\utility\player::getbeingrevivedinternal()))
      scripts\mp\utility\lower_message::setlowermessageomnvar("being_revived");
    else if(istrue(self.laststandhealisactive))
      scripts\mp\utility\lower_message::setlowermessageomnvar("reviving_self");
    else if(isDefined(self.timeuntilbleedout)) {
      if(_id_649E600E12376E07)
        scripts\mp\utility\lower_message::setlowermessageomnvar("self_revive", int(gettime() + self.timeuntilbleedout * 1000));
      else if(scripts\mp\utility\game::getgametype() != "dm") {
        if(self.pers["lives"] == 0 && scripts\mp\utility\game::isteamreviveenabled())
          scripts\mp\utility\lower_message::setlowermessageomnvar("spawn_revive_wait", int(gettime() + self.timeuntilbleedout * 1000));
        else if(scripts\mp\utility\perk::_hasperk("specialty_survivor"))
          scripts\mp\utility\lower_message::setlowermessageomnvar("survivor_revive", int(gettime() + self.timeuntilbleedout * 1000));
        else
          scripts\mp\utility\lower_message::setlowermessageomnvar("revive_or_respawn", int(gettime() + self.timeuntilbleedout * 1000));
      } else if(scripts\mp\utility\perk::_hasperk("specialty_survivor"))
        scripts\mp\utility\lower_message::setlowermessageomnvar("survivor_revive", int(gettime() + self.timeuntilbleedout * 1000));
      else
        scripts\mp\utility\lower_message::setlowermessageomnvar("ffa_down_give_up", int(gettime() + self.timeuntilbleedout * 1000));
    } else if(_id_649E600E12376E07)
      scripts\mp\utility\lower_message::setlowermessageomnvar("self_revive");
    else if(self.pers["lives"] == 0 && scripts\mp\utility\game::isteamreviveenabled())
      scripts\mp\utility\lower_message::setlowermessageomnvar("spawn_revive_wait");
    else if(scripts\mp\utility\perk::_hasperk("specialty_survivor"))
      scripts\mp\utility\lower_message::setlowermessageomnvar("survivor_revive", int(gettime() + self.timeuntilbleedout * 1000));
    else
      scripts\mp\utility\lower_message::setlowermessageomnvar("revive_or_respawn");

    for(;;) {
      _id_4930CBCE302555B1 = scripts\engine\utility::waittill_any_return_no_endon_death_2("super_ready", "handle_revive_message");

      if(_id_4930CBCE302555B1 == "super_ready" && scripts\mp\supers::getcurrentsuperref() != "super_laststand_heal")
        continue;
      else
        break;
    }
  }
}

bleedoutthink() {
  self endon("death_or_disconnect");
  self endon("last_stand_finished");
  self endon("last_stand_heal_active");
  level endon("game_ended");
  _id_8DD9F2EB8215A139 = self.timeuntilbleedout;

  if(_id_8DD9F2EB8215A139 != 0) {
    for(;;) {
      waitframe();

      if(self isinexecutionvictim()) {
        continue;
      }
      if(!istrue(scripts\mp\utility\player::getbeingrevivedinternal()))
        _id_8DD9F2EB8215A139 = _id_8DD9F2EB8215A139 - level.framedurationseconds;

      if(_id_8DD9F2EB8215A139 <= level.framedurationseconds) {
        self notify("last_stand_bleedout");
        break;
      }

      self.timeuntilbleedout = _id_8DD9F2EB8215A139;
    }
  }
}

addoverheadicon() {
  showto = self.team;
  image = "hud_realism_head_revive";
  offset = 25;
  _id_E0E11F3B4551BE11 = 1;
  _id_C5409CA7522182B3 = 1280;
  _id_30516B4AFD1763DE = 250;
  _id_74B5B12BB6514385 = undefined;
  _id_FA4CF28A58192889 = undefined;
  _id_B3EA37733A1577E5 = 0;
  _id_7591ED99E87A77D3 = undefined;
  showonminimap = 0;
  image = scripts\cp_mp\entityheadicons::setheadicon_singleimage(showto, image, offset, _id_E0E11F3B4551BE11, _id_C5409CA7522182B3, _id_30516B4AFD1763DE, _id_74B5B12BB6514385, _id_FA4CF28A58192889, _id_B3EA37733A1577E5, _id_7591ED99E87A77D3, showonminimap);
  thread cleanupoverheadicon(image);
}

cleanupoverheadicon(image) {
  scripts\engine\utility::waittill_any_2("death_or_disconnect", "last_stand_finished");
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(image);
}

showwaverespawnmessage() {
  _id_3E1DEAE4CD178CFB = getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_waverespawndelay")) > 0;

  if(!_id_3E1DEAE4CD178CFB) {
    return;
  }
  self endon("last_stand_finished");

  for(;;) {
    self.respawntimerstarttime = gettime();
    _id_3E1DEAE4CD178CFB = getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_waverespawndelay")) > 0;

    if(_id_3E1DEAE4CD178CFB) {
      timeuntilspawn = scripts\mp\playerlogic::timeuntilwavespawn(0.0);
      scripts\mp\utility\lower_message::setlowermessageomnvar("next_team_spawn", int(gettime() + timeuntilspawn * 1000));
      wait(timeuntilspawn);
      scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
    }

    wait 2.0;
  }
}

allowselfrevive(_id_CD187E38E3DF8F36) {
  self.allowselfrevive = _id_CD187E38E3DF8F36;
  self setclientomnvar("ui_self_revive", _id_CD187E38E3DF8F36);
}

laststandmonitor() {
  level endon("game_ended");

  if(istrue(level.laststandkillteamifdowndisable)) {
    return;
  }
  for(;;) {
    level waittill("last_stand_enter_finished");

    if(scripts\mp\utility\game::getgametypenumlives() == 0 && !istrue(level.disablespawning)) {
      continue;
    }
    wait 0.6;
    level thread laststandkillteamifdown();
  }
}

laststandkillteamifdown() {
  foreach(_id_F90358454413407F in level.teamnamelist) {
    _id_CC8EF4E09362998C = scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "livesCount");

    if(_id_CC8EF4E09362998C != 0) {
      continue;
    }
    _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getfriendlyplayers(_id_F90358454413407F, 1);
    _id_2D2ABB649737B34E = [];

    foreach(player in _id_E2B2BBD9E6539F11) {
      if(istrue(player.inlaststand) && !istrue(player scripts\mp\utility\perk::_hasperk("specialty_survivor")))
        _id_2D2ABB649737B34E[_id_2D2ABB649737B34E.size] = player;
    }

    if(_id_2D2ABB649737B34E.size > 0 && _id_E2B2BBD9E6539F11.size <= _id_2D2ABB649737B34E.size) {
      level.laststandrequiresmelee = 0;

      foreach(player in _id_2D2ABB649737B34E) {
        if(!isDefined(player)) {
          continue;
        }
        player notify("last_stand_bleedout");
      }
    }
  }
}

getclassiclaststandpistol() {
  weaponlist = self getweaponslistprimaries();

  foreach(weapon in weaponlist) {
    class = weaponclass(weapon);

    if(weaponclass(weapon) == "pistol")
      return weapon;
  }

  weapon = _id_2669878CF5A1B6BC::buildweapon(_id_2669878CF5A1B6BC::getweaponrootname("iw8_pi_golf21_mp"), [], "none", "none", -1);
  return weapon;
}

makelaststandinvuln() {
  _id_E59E0DB049D16BD4 = level.laststandinvulntime;
  clearlaststandinvuln();
  self endon("disconnect");
  self endon("clear_last_stand_invuln");
  scripts\cp_mp\utility\damage_utility::adddamagemodifier("last_stand_invuln", 0, 0, ::laststandinvulnignorefunc);
  scripts\engine\utility::waittill_notify_or_timeout("death", _id_E59E0DB049D16BD4);
  thread clearlaststandinvuln();
}

clearlaststandinvuln() {
  self notify("clear_last_stand_invuln");
  scripts\cp_mp\utility\damage_utility::removedamagemodifier("last_stand_invuln", 0);
}

laststandinvulnignorefunc(inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc) {
  if(meansofdeath == "MOD_TRIGGER_HURT")
    return 1;

  return 0;
}

getdefaultlaststandtimervalue() {
  return 10;
}

getdefaultlaststandrevivetimervalue() {
  return 5;
}

getshellshockinterruptdelayms(duration) {
  return duration * 1000;
}

_id_27D0EA02ED3CC35F(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration) {
  _id_6D8F177C77496430 = scripts\mp\damage::isforcedlaststand(self, einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc);

  if(!istrue(_id_6D8F177C77496430)) {
    if(istrue(self.inlaststand) || istrue(self.playergoingintols))
      return 0;

    if(_id_0448EF4D9E70CE5E::_id_AFB40A34C99DC4E4(objweapon))
      return 0;

    if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && !istrue(self.killstreaklaststand) && (smeansofdeath == "MOD_MELEE" && objweapon.basename != "iw9_me_fists_mp" && objweapon.basename != "iw9_me_fists_mp_ls"))
      return 0;

    if(smeansofdeath == "MOD_EXECUTION")
      return 0;

    if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && scripts\cp_mp\utility\damage_utility::isheadshot(shitloc, smeansofdeath, attacker) && !scripts\mp\utility\perk::_hasperk("specialty_survivor") && !istrue(level._id_0D88255CD662EB5C))
      return 0;

    if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && isexplosivedamagemod(smeansofdeath))
      return 0;

    if(istrue(self.gulagarena)) {
      if(getdvarint("dvar_8D6A8990465B92FC", 0)) {
        if(isDefined(self.name))
          _id_81A6DCF8641471F7 = self.name;
        else
          _id_81A6DCF8641471F7 = "";

        if(isDefined(self.gulagarena))
          _id_54B9737D53438793 = self.gulagarena;
        else
          _id_54B9737D53438793 = "";

        if(isDefined(self.gulag))
          _id_39B32CC7F5D22BCC = self.gulag;
        else
          _id_39B32CC7F5D22BCC = "";

        _id_B0686D6BEEEDBE48 = "[gulag_getPlayerStateWait] Player " + _id_81A6DCF8641471F7 + " has .gulagArena : " + _id_54B9737D53438793 + " and .gulag : " + _id_39B32CC7F5D22BCC;
        logstring(_id_B0686D6BEEEDBE48);
      }

      return 0;
    }

    if(isDefined(attacker) && (isDefined(attacker.classname) && (attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn")))
      return 0;

    if(isDefined(attacker) && attacker == self && !scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
      return 0;

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && scripts\mp\utility\killstreak::isjuggernaut())
      return 0;

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && !scripts\mp\flags::gameflag("prematch_done"))
      return 0;

    if(isDefined(objweapon) && getweaponbasename(objweapon) == "nuke_mp")
      return 0;

    if(isDefined(level.modelaststandallowed) && !self[[level.modelaststandallowed]](einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration))
      return 0;

    if(istrue(level._id_999D19FFA4F37DF9))
      return 0;

    _id_B9ACAB71A2B1FD8A = (scripts\mp\utility\perk::_hasperk("specialty_survivor") || scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) && !istrue(self._id_4945D0D82DD3964B) || scripts\mp\utility\game::islaststandenabled();

    if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && !istrue(level._id_0D88255CD662EB5C) && !_id_B9ACAB71A2B1FD8A)
      return 0;

    if(level.laststand == 2 && !_id_B9ACAB71A2B1FD8A)
      return 0;
  }

  return 1;
}

_id_ED6F8AE3C33ED504(attacker) {
  if(!isDefined(attacker)) {
    return;
  }
  if(scripts\mp\utility\game::getgametype() == "grind" && scripts\mp\flags::gameflag("prematch_done")) {
    level thread _id_1CEA1B70A5AAD392::spawndogtags(self, attacker, "new_tag_spawned", undefined);
    level thread _id_183BA55FED386936::droptags(self, attacker);
  } else if(level.dogtagsenabled && scripts\mp\flags::gameflag("prematch_done"))
    level thread _id_1CEA1B70A5AAD392::spawndogtags(self, attacker, "new_tag_spawned", undefined);

  score = level.scoremod["kill"];

  if(score != 0) {
    if(level.teambased)
      level scripts\mp\gamescore::giveteamscoreforobjective(attacker.pers["team"], score, 0);
    else
      attacker scripts\mp\gamescore::giveplayerscore("stat_EF9582D72160F199", score, self);
  }

  if(scripts\mp\utility\game::_id_F698BFD3EFA33302() || scripts\mp\utility\game::_id_E9F3A160BBEFE208(attacker) || scripts\mp\utility\game::_id_E9F3A160BBEFE208(self))
    scripts\mp\cranked::oncranked(self, attacker);
}

_id_3B4A396318897A49(weapon) {
  if(isstring(weapon))
    weaponname = weapon;
  else
    weaponname = weapon.basename;

  if(!isDefined(weaponname))
    return 0;

  currentweapon = 0;

  switch (weaponname) {
    case "iw8_ges_plyr_self_revive":
    case "iw8_ges_plyr_self_revive_stim_pistol":
      currentweapon = 1;
      break;
  }

  return currentweapon;
}

_id_2A3C9A91BF1D3911() {
  return istrue(level._id_7BEA6884AFD52E81);
}

_id_A2DD7D8143656503(player) {
  if(player getclientomnvar("ui_br_has_been_interrogated") == 1 || player getclientomnvar("ui_br_interrogate_team_is_being_tracked") == 1 || player getclientomnvar("ui_br_interrogate_tracking_other_team") == 1 || istrue(player._id_895C1AAAC16F7256))
    return 1;

  return 0;
}

_id_4C452A6C72371F17() {
  if(!isDefined(self._id_F1DA02A134648443))
    self._id_F1DA02A134648443 = 1;

  foreach(player in level.players) {
    if(!isDefined(player)) {
      return;
    }
    _id_42994E73B40CC1A4(player);
  }
}

_id_42994E73B40CC1A4(player) {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(player)) {
    return;
  }
  _id_4D9B9E1C6D61A950 = self._id_121A99ED77D25F87;

  if(!isDefined(_id_4D9B9E1C6D61A950)) {
    return;
  }
  _id_142B0F57D2AC79D9 = self._id_A2BC763E8380844B;

  if(!isDefined(_id_142B0F57D2AC79D9)) {
    return;
  }
  _id_A2D7F6DAD9C7FAE5 = scripts\mp\utility\player::isfriendly(self.owner.team, player);
  _id_D36495A3A4245392 = getdvarint("dvar_D0CBC658324B1DAE", 0) != 0;

  if(isDefined(self.owner.laststandattacker) && !_id_D36495A3A4245392)
    _id_D36495A3A4245392 = scripts\mp\utility\player::isfriendly(self.owner.laststandattacker.team, player);
  else
    _id_D36495A3A4245392 = 1;

  if(player _id_2CEDCC356F1B9FC8::playeriszombie())
    _id_D36495A3A4245392 = 0;

  if(_id_A2D7F6DAD9C7FAE5 || !_id_D36495A3A4245392) {
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(_id_4D9B9E1C6D61A950, player);
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(_id_142B0F57D2AC79D9, player);
    return;
  }

  if(!isDefined(self._id_F1DA02A134648443)) {
    return;
  }
  switch (self._id_F1DA02A134648443) {
    case 1:
      scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(_id_4D9B9E1C6D61A950, player);
      scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(_id_142B0F57D2AC79D9, player);
      setheadicondrawthroughgeo(_id_4D9B9E1C6D61A950, 0);
      break;
    case 2:
      scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(_id_4D9B9E1C6D61A950, player);
      scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(_id_142B0F57D2AC79D9, player);
      setheadicondrawthroughgeo(_id_4D9B9E1C6D61A950, 0);
      break;
    case 4:
      scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(_id_4D9B9E1C6D61A950, player);
      scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(_id_142B0F57D2AC79D9, player);
      setheadicondrawthroughgeo(_id_4D9B9E1C6D61A950, 1);
      break;
    case 3:
    default:
      scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(_id_4D9B9E1C6D61A950, player);
      scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(_id_142B0F57D2AC79D9, player);
      break;
  }
}

#using_animtree("script_model");

_id_0150B60D7CBD3BA2() {
  _id_E1841AF234A09407(%iw9_wz_interrogate_frontleft_attacker_start, "interrogate_frontleft_attacker_start");
  _id_E1841AF234A09407(%iw9_wz_interrogate_frontleft_attacker_loop, "interrogate_frontleft_attacker_loop");
  _id_E1841AF234A09407(%iw9_wz_interrogate_frontleft_attacker_end, "interrogate_frontleft_attacker_end");
  _id_E1841AF234A09407(%iw9_wz_interrogate_frontleft_defender_start, "interrogate_frontleft_defender_start");
  _id_E1841AF234A09407(%iw9_wz_interrogate_frontleft_defender_loop, "interrogate_frontleft_defender_loop");
  _id_E1841AF234A09407(%iw9_wz_interrogate_frontleft_defender_end, "interrogate_frontleft_defender_end");
  _id_E1841AF234A09407(%iw9_wz_interrogate_frontright_attacker_start, "interrogate_frontright_attacker_start");
  _id_E1841AF234A09407(%iw9_wz_interrogate_frontright_attacker_loop, "interrogate_frontright_attacker_loop");
  _id_E1841AF234A09407(%iw9_wz_interrogate_frontright_attacker_end, "interrogate_frontright_attacker_end");
  _id_E1841AF234A09407(%iw9_wz_interrogate_frontright_defender_start, "interrogate_frontright_defender_start");
  _id_E1841AF234A09407(%iw9_wz_interrogate_frontright_defender_loop, "interrogate_frontright_defender_loop");
  _id_E1841AF234A09407(%iw9_wz_interrogate_frontright_defender_end, "interrogate_frontright_defender_end");
  _id_E1841AF234A09407(%iw9_wz_interrogate_backleft_attacker_start, "interrogate_backleft_attacker_start");
  _id_E1841AF234A09407(%iw9_wz_interrogate_backleft_attacker_loop, "interrogate_backleft_attacker_loop");
  _id_E1841AF234A09407(%iw9_wz_interrogate_backleft_attacker_end, "interrogate_backleft_attacker_end");
  _id_E1841AF234A09407(%iw9_wz_interrogate_backleft_defender_start, "interrogate_backleft_defender_start");
  _id_E1841AF234A09407(%iw9_wz_interrogate_backleft_defender_loop, "interrogate_backleft_defender_loop");
  _id_E1841AF234A09407(%iw9_wz_interrogate_backleft_defender_end, "interrogate_backleft_defender_end");
  _id_E1841AF234A09407(%iw9_wz_interrogate_backright_attacker_start, "interrogate_backright_attacker_start");
  _id_E1841AF234A09407(%iw9_wz_interrogate_backright_attacker_loop, "interrogate_backright_attacker_loop");
  _id_E1841AF234A09407(%iw9_wz_interrogate_backright_attacker_end, "interrogate_backright_attacker_end");
  _id_E1841AF234A09407(%iw9_wz_interrogate_backright_defender_start, "interrogate_backright_defender_start");
  _id_E1841AF234A09407(%iw9_wz_interrogate_backright_defender_loop, "interrogate_backright_defender_loop");
  _id_E1841AF234A09407(%iw9_wz_interrogate_backright_defender_end, "interrogate_backright_defender_end");
  _id_E1841AF234A09407(%iw9_wz_interrogate_frontleft_attacker3pcam_start, "interrogate_frontleft_attacker3pcam_start");
  _id_E1841AF234A09407(%iw9_wz_interrogate_frontleft_attacker3pcam_loop, "interrogate_frontleft_attacker3pcam_loop");
  _id_E1841AF234A09407(%iw9_wz_interrogate_frontleft_attacker3pcam_end, "interrogate_frontleft_attacker3pcam_end");
  _id_E1841AF234A09407(%iw9_wz_interrogate_frontleft_defender3pcam_start, "interrogate_frontleft_defender3pcam_start");
  _id_E1841AF234A09407(%iw9_wz_interrogate_frontleft_defender3pcam_loop, "interrogate_frontleft_defender3pcam_loop");
  _id_E1841AF234A09407(%iw9_wz_interrogate_frontleft_defender3pcam_end, "interrogate_frontleft_defender3pcam_end");
  _id_E1841AF234A09407(%iw9_wz_interrogate_frontright_attacker3pcam_start, "interrogate_frontright_attacker3pcam_start");
  _id_E1841AF234A09407(%iw9_wz_interrogate_frontright_attacker3pcam_loop, "interrogate_frontright_attacker3pcam_loop");
  _id_E1841AF234A09407(%iw9_wz_interrogate_frontright_attacker3pcam_end, "interrogate_frontright_attacker3pcam_end");
  _id_E1841AF234A09407(%iw9_wz_interrogate_frontright_defender3pcam_start, "interrogate_frontright_defender3pcam_start");
  _id_E1841AF234A09407(%iw9_wz_interrogate_frontright_defender3pcam_loop, "interrogate_frontright_defender3pcam_loop");
  _id_E1841AF234A09407(%iw9_wz_interrogate_frontright_defender3pcam_end, "interrogate_frontright_defender3pcam_end");
  _id_E1841AF234A09407(%iw9_wz_interrogate_backleft_attacker3pcam_start, "interrogate_backleft_attacker3pcam_start");
  _id_E1841AF234A09407(%iw9_wz_interrogate_backleft_attacker3pcam_loop, "interrogate_backleft_attacker3pcam_loop");
  _id_E1841AF234A09407(%iw9_wz_interrogate_backleft_attacker3pcam_end, "interrogate_backleft_attacker3pcam_end");
  _id_E1841AF234A09407(%iw9_wz_interrogate_backleft_defender3pcam_start, "interrogate_backleft_defender3pcam_start");
  _id_E1841AF234A09407(%iw9_wz_interrogate_backleft_defender3pcam_loop, "interrogate_backleft_defender3pcam_loop");
  _id_E1841AF234A09407(%iw9_wz_interrogate_backleft_defender3pcam_end, "interrogate_backleft_defender3pcam_end");
  _id_E1841AF234A09407(%iw9_wz_interrogate_backright_attacker3pcam_start, "interrogate_backright_attacker3pcam_start");
  _id_E1841AF234A09407(%iw9_wz_interrogate_backright_attacker3pcam_loop, "interrogate_backright_attacker3pcam_loop");
  _id_E1841AF234A09407(%iw9_wz_interrogate_backright_attacker3pcam_end, "interrogate_backright_attacker3pcam_end");
  _id_E1841AF234A09407(%iw9_wz_interrogate_backright_defender3pcam_start, "interrogate_backright_defender3pcam_start");
  _id_E1841AF234A09407(%iw9_wz_interrogate_backright_defender3pcam_loop, "interrogate_backright_defender3pcam_loop");
  _id_E1841AF234A09407(%iw9_wz_interrogate_backright_defender3pcam_end, "interrogate_backright_defender3pcam_end");
  level.scr_animtree["device"] = #animtree;
  _id_4A6B9ECAE4B71AE5(%iw9_wz_interrogate_backleft_knife_start, "interrogate_backleft_knife_start");
  _id_4A6B9ECAE4B71AE5(%iw9_wz_interrogate_backleft_knife_loop, "interrogate_backleft_knife_loop");
  _id_4A6B9ECAE4B71AE5(%iw9_wz_interrogate_backleft_knife_end, "interrogate_backleft_knife_end");
  _id_4A6B9ECAE4B71AE5(%iw9_wz_interrogate_backright_knife_start, "interrogate_backright_knife_start");
  _id_4A6B9ECAE4B71AE5(%iw9_wz_interrogate_backright_knife_loop, "interrogate_backright_knife_loop");
  _id_4A6B9ECAE4B71AE5(%iw9_wz_interrogate_backright_knife_end, "interrogate_backright_knife_end");
  _id_4A6B9ECAE4B71AE5(%iw9_wz_interrogate_frontleft_knife_start, "interrogate_frontleft_knife_start");
  _id_4A6B9ECAE4B71AE5(%iw9_wz_interrogate_frontleft_knife_loop, "interrogate_frontleft_knife_loop");
  _id_4A6B9ECAE4B71AE5(%iw9_wz_interrogate_frontleft_knife_end, "interrogate_frontleft_knife_end");
  _id_4A6B9ECAE4B71AE5(%iw9_wz_interrogate_frontright_knife_start, "interrogate_frontright_knife_start");
  _id_4A6B9ECAE4B71AE5(%iw9_wz_interrogate_frontright_knife_loop, "interrogate_frontright_knife_loop");
  _id_4A6B9ECAE4B71AE5(%iw9_wz_interrogate_frontright_knife_end, "interrogate_frontright_knife_end");
  _id_4A6B9ECAE4B71AE5(%iw9_wz_interrogate_backleft_pda_start, "interrogate_backleft_pda_start");
  _id_4A6B9ECAE4B71AE5(%iw9_wz_interrogate_backleft_pda_loop, "interrogate_backleft_pda_loop");
  _id_4A6B9ECAE4B71AE5(%iw9_wz_interrogate_backleft_pda_end, "interrogate_backleft_pda_end");
  _id_4A6B9ECAE4B71AE5(%iw9_wz_interrogate_backright_pda_start, "interrogate_backright_pda_start");
  _id_4A6B9ECAE4B71AE5(%iw9_wz_interrogate_backright_pda_loop, "interrogate_backright_pda_loop");
  _id_4A6B9ECAE4B71AE5(%iw9_wz_interrogate_backright_pda_end, "interrogate_backright_pda_end");
  _id_4A6B9ECAE4B71AE5(%iw9_wz_interrogate_frontleft_pda_start, "interrogate_frontleft_pda_start");
  _id_4A6B9ECAE4B71AE5(%iw9_wz_interrogate_frontleft_pda_loop, "interrogate_frontleft_pda_loop");
  _id_4A6B9ECAE4B71AE5(%iw9_wz_interrogate_frontleft_pda_end, "interrogate_frontleft_pda_end");
  _id_4A6B9ECAE4B71AE5(%iw9_wz_interrogate_frontright_pda_start, "interrogate_frontright_pda_start");
  _id_4A6B9ECAE4B71AE5(%iw9_wz_interrogate_frontright_pda_loop, "interrogate_frontright_pda_loop");
  _id_4A6B9ECAE4B71AE5(%iw9_wz_interrogate_frontright_pda_end, "interrogate_frontright_pda_end");
}

_id_1D6E0919BCC01C46(attacker, _id_EE2753C1176F5C7E, _id_F5CA237F98FB4CF6) {
  level endon("game_ended");
  dir = _id_16F1ED28A559F91F(attacker, _id_EE2753C1176F5C7E);
  self notify("interrogation_anim_setup_start");
  _id_4AA5CC0D5AAF5E13(dir, attacker, _id_EE2753C1176F5C7E);
  self notify("interrogation_anim_setup_done");
  thread _id_7AA8B6E88B420BDB(dir, attacker, _id_EE2753C1176F5C7E, _id_F5CA237F98FB4CF6);
}

_id_7AA8B6E88B420BDB(dir, attacker, _id_EE2753C1176F5C7E, _id_F5CA237F98FB4CF6) {
  self endon("use_hold_interrogate_fail");
  attacker endon("death_or_disconnect");
  _id_EE2753C1176F5C7E endon("death_or_disconnect");
  self notify("interrogation_anim_start");
  childthread _id_85B5F0CAFA43FC83(dir, attacker, _id_EE2753C1176F5C7E);

  if(!istrue(self._id_D50D5A16DF84DF44)) {
    remainingtime = _id_A8D9949BCFBF31C6(dir, attacker, _id_EE2753C1176F5C7E, _id_F5CA237F98FB4CF6);

    if(isDefined(remainingtime))
      _id_25BB5B0A542A335C(dir, attacker, _id_EE2753C1176F5C7E, remainingtime);
  }

  self waittill("interrogation_anim_end_done");
  self notify("interrogation_anim_complete");
}

_id_A8D9949BCFBF31C6(dir, attacker, _id_EE2753C1176F5C7E, _id_451899D86C262B06) {
  self endon("use_hold_interrogate_fail");
  self endon("use_hold_interrogate_success");
  attacker endon("death_or_disconnect");
  _id_EE2753C1176F5C7E endon("death_or_disconnect");
  _id_A9A4271FA4D4ACEE = gettime();
  _id_2BC915DA80C90AA0(dir, attacker, _id_EE2753C1176F5C7E, "start", 1, 1);
  _id_A9A4271FA4D4ACEE = _id_451899D86C262B06 - (gettime() - _id_A9A4271FA4D4ACEE);
  _id_A9A4271FA4D4ACEE = max(_id_A9A4271FA4D4ACEE, 0);
  return _id_A9A4271FA4D4ACEE / 1000.0;
}

_id_25BB5B0A542A335C(dir, attacker, _id_EE2753C1176F5C7E, _id_F5CA237F98FB4CF6) {
  self endon("use_hold_interrogate_fail");
  self endon("use_hold_interrogate_success");
  attacker endon("death_or_disconnect");
  _id_EE2753C1176F5C7E endon("death_or_disconnect");

  if(!isDefined(_id_F5CA237F98FB4CF6))
    return 0;

  animlength = _id_FA005DEA3B675DD4(dir, "loop");

  for(_id_8DD9F2EB8215A139 = _id_F5CA237F98FB4CF6; _id_8DD9F2EB8215A139 > 0; _id_8DD9F2EB8215A139 = _id_8DD9F2EB8215A139 - waittime) {
    if(!isDefined(self)) {
      break;
    }

    _id_2BC915DA80C90AA0(dir, attacker, _id_EE2753C1176F5C7E, "loop", 0);
    waittime = min(animlength, _id_8DD9F2EB8215A139);
    wait(waittime);
  }

  self notify("interrogation_anim_loop_done");
  return 1;
}

_id_85B5F0CAFA43FC83(dir, attacker, _id_EE2753C1176F5C7E) {
  self notify("interrogation_anim_end");
  self endon("interrogation_anim_end");

  if(!istrue(self._id_D50D5A16DF84DF44))
    scripts\engine\utility::waittill_any_2("interrogation_anim_loop_done", "use_hold_interrogate_success");

  _id_2BC915DA80C90AA0(dir, attacker, _id_EE2753C1176F5C7E, "end", 1);
  self notify("interrogation_anim_end_done");
}

_id_4AA5CC0D5AAF5E13(dir, attacker, _id_EE2753C1176F5C7E) {
  self endon("use_hold_interrogate_fail");
  attacker endon("death_or_disconnect");
  _id_EE2753C1176F5C7E endon("death_or_disconnect");
  self.angles = (0, _id_EE2753C1176F5C7E.angles[1], 0);
  [_id_691D365A2045E893, _id_67D8DDF901F65B1D, _id_93E84816600B6F9B, _id_439AE466E036AC7D] = _id_341C7024A3E54638(dir, _id_EE2753C1176F5C7E, attacker);
  attacker thread _id_52A9113423FF7CE1(_id_EE2753C1176F5C7E.origin + _id_691D365A2045E893, _id_67D8DDF901F65B1D);
  _id_EE2753C1176F5C7E thread _id_52A9113423FF7CE1(_id_EE2753C1176F5C7E.origin + _id_93E84816600B6F9B, _id_439AE466E036AC7D);
  self._id_61859DD33E04AFAC = _id_64C48800869451A1(attacker, _id_EE2753C1176F5C7E.origin + _id_93E84816600B6F9B, _id_439AE466E036AC7D);
  self._id_862B6F35ADA766B8 = _id_64C48800869451A1(_id_EE2753C1176F5C7E, _id_EE2753C1176F5C7E.origin + _id_93E84816600B6F9B, _id_439AE466E036AC7D);
  self._id_862B6F35ADA766B8 childthread _id_EEF4880F266F99E6(attacker);
  thread _id_8AE5403C4D1733D6(dir, attacker, _id_EE2753C1176F5C7E);
  thread _id_D0010FDBCDAEAF0A(attacker);
  _id_7574E1170872D13A = gettime();
  attacker scripts\cp_mp\utility\inventory_utility::_id_F1E9D0C09F38006B(0);
  _id_F4EC18F455B87D6F = getdvarfloat("dvar_46685B5A7AB844EB", 0.2);
  _id_19C8C749987D4FEA = _id_7574E1170872D13A + _id_F4EC18F455B87D6F * 1000;
  _id_A4994B77554C30DE = gettime();

  if(_id_A4994B77554C30DE < _id_19C8C749987D4FEA)
    wait((_id_19C8C749987D4FEA - _id_A4994B77554C30DE) / 1000);

  attacker.player_rig linkTo(self._id_61859DD33E04AFAC, "tag_origin", (0, 0, 0), (0, 0, 0));
  _id_EE2753C1176F5C7E.player_rig linkTo(self._id_862B6F35ADA766B8, "tag_origin", (0, 0, 0), (0, 0, 0));

  if(!attacker _meth_C1092F42B6BBE490())
    attacker.player_rig showonlytoplayer(attacker);

  if(!_id_EE2753C1176F5C7E _meth_C1092F42B6BBE490())
    _id_EE2753C1176F5C7E.player_rig showonlytoplayer(_id_EE2753C1176F5C7E);
}

_id_EEF4880F266F99E6(attacker) {
  self endon("entitydeleted");
  self notify("vehicleWatchLogic");
  self endon("vehicleWatchLogic");
  _id_A9C79142E2AC7704 = getdvarint("dvar_DCDD2AA64529509E", 185);
  self.trigger = spawn("trigger_radius", self.origin, 0, _id_A9C79142E2AC7704, _id_A9C79142E2AC7704);

  for(;;) {
    self.trigger waittill("trigger", _id_02087E4030AA793B);

    if(isDefined(_id_02087E4030AA793B.classname) && _id_02087E4030AA793B.classname == "script_vehicle") {
      occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupantsandreserving(_id_02087E4030AA793B);

      if(isDefined(occupants) && occupants.size > 0)
        attacker._id_A23F35F8460D8857 = 1;
    }
  }
}

_id_8AE5403C4D1733D6(dir, attacker, _id_EE2753C1176F5C7E) {
  level endon("game_ended");
  self notify("interrogation_anim_cleanup");
  self endon("interrogation_anim_cleanup");
  _id_4930CBCE302555B1 = scripts\engine\utility::waittill_any_return_3("interrogation_anim_complete", "use_hold_interrogate_fail", "last_stand_finished");

  if(isalive(attacker) && isDefined(self._id_61859DD33E04AFAC))
    attacker stopanimscriptsceneevent();

  if(isalive(_id_EE2753C1176F5C7E) && isDefined(self._id_862B6F35ADA766B8))
    _id_EE2753C1176F5C7E stopanimscriptsceneevent();

  if(isDefined(self._id_61859DD33E04AFAC))
    self._id_61859DD33E04AFAC _id_DBC6C6ADF9CF2998();

  if(isDefined(self._id_862B6F35ADA766B8))
    self._id_862B6F35ADA766B8 _id_DBC6C6ADF9CF2998();

  waitframe();
  gunless = makeweapon(scripts\cp_mp\utility\inventory_utility::_id_3D5C51904FD25773());

  if(!isDefined(attacker.gunnlessweapon)) {
    _id_2869A3A20D48E6AD = attacker getcurrentweapon();

    if(_id_2869A3A20D48E6AD == gunless)
      attacker.gunnlessweapon = _id_2869A3A20D48E6AD;
  }

  if(attacker scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(gunless))
    attacker scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(gunless);

  attacker thread scripts\cp_mp\utility\inventory_utility::_id_9897D143C3FEEE05();
  attacker notify("remove_rig");
  _id_EE2753C1176F5C7E notify("remove_rig");
}

_id_DBC6C6ADF9CF2998() {
  if(isalive(self.player) && isDefined(self.player.player_rig) && self.player.player_rig islinked())
    self.player.player_rig unlink();

  if(self islinked())
    self unlink();

  self delete();
}

_id_B5963C08352BE7E9(dir, attacker, _id_EE2753C1176F5C7E) {
  level endon("game_ended");
  self endon("interrogation_anim_setup_start");
  _id_EE2753C1176F5C7E endon("death_or_disconnect");
  self._id_61859DD33E04AFAC _id_DBC6C6ADF9CF2998();
  self._id_862B6F35ADA766B8 _id_DBC6C6ADF9CF2998();
  waitframe();

  if(isalive(attacker)) {
    gunless = makeweapon(scripts\cp_mp\utility\inventory_utility::_id_3D5C51904FD25773());

    if(attacker scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(gunless))
      attacker scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(gunless);

    attacker thread scripts\cp_mp\utility\inventory_utility::_id_9897D143C3FEEE05();
    attacker notify("remove_rig");
  }

  if(isalive(_id_EE2753C1176F5C7E) && isDefined(self._id_862B6F35ADA766B8))
    _id_EE2753C1176F5C7E stopanimscriptsceneevent();

  if(isalive(_id_EE2753C1176F5C7E))
    _id_EE2753C1176F5C7E notify("remove_rig");
}

_id_D0010FDBCDAEAF0A(attacker) {
  _id_74C33A61490F2AF7 = _id_ACC5EA9379317664(attacker, "offhand1h_vm_smartphone_inter", "tag_origin", 1);
  _id_213ABE1DBC252ACA = _id_ACC5EA9379317664(attacker, "offhand1h_wm_smartphone_v0", "tag_accessory_left", 0);
  _id_63254B5552422209 = _id_ACC5EA9379317664(attacker, "att_vm_p33_me_tac_knife01_inter", "tag_origin", 1);
  _id_8973C46D8FFCC3DC = _id_ACC5EA9379317664(attacker, "att_vm_p33_me_tac_knife01_v0", "j_gun", 0);
  attacker._id_74C33A61490F2AF7 = _id_74C33A61490F2AF7;
  attacker._id_213ABE1DBC252ACA = _id_213ABE1DBC252ACA;
  attacker._id_63254B5552422209 = _id_63254B5552422209;
  attacker._id_8973C46D8FFCC3DC = _id_8973C46D8FFCC3DC;
  attacker setclientomnvar("ui_tablet_usb", 10);

  if(isDefined(self._id_61859DD33E04AFAC)) {
    attacker._id_74C33A61490F2AF7 linkTo(self._id_61859DD33E04AFAC, "tag_origin");
    attacker._id_63254B5552422209 linkTo(self._id_61859DD33E04AFAC, "tag_origin");
    attacker._id_74C33A61490F2AF7.animname = "device";
    attacker._id_74C33A61490F2AF7 scripts\common\anim::setanimtree();
    attacker._id_63254B5552422209.animname = "device";
    attacker._id_63254B5552422209 scripts\common\anim::setanimtree();
  }

  thread _id_7005F2911BAFFE7F(attacker);
}

_id_7005F2911BAFFE7F(attacker) {
  level endon("game_ended");
  _id_74C33A61490F2AF7 = attacker._id_74C33A61490F2AF7;
  _id_213ABE1DBC252ACA = attacker._id_213ABE1DBC252ACA;
  _id_63254B5552422209 = attacker._id_63254B5552422209;
  _id_8973C46D8FFCC3DC = attacker._id_8973C46D8FFCC3DC;
  _id_A25061BFC986E905 = scripts\mp\utility\dvars::getwatcheddvar("lastStandReviveTimer") + 5;
  scripts\engine\utility::waittill_any_timeout_3(_id_A25061BFC986E905, "interrogation_anim_complete", "use_hold_interrogate_fail", "last_stand_finished");

  if(isDefined(attacker))
    attacker setclientomnvar("ui_tablet_usb", 0);

  _id_A0B08DAE03DF9DAE(_id_74C33A61490F2AF7);
  _id_A0B08DAE03DF9DAE(_id_213ABE1DBC252ACA);
  _id_A0B08DAE03DF9DAE(_id_63254B5552422209);
  _id_A0B08DAE03DF9DAE(_id_8973C46D8FFCC3DC);
}

_id_2BC915DA80C90AA0(dir, attacker, _id_EE2753C1176F5C7E, _id_D5CC8B378F09BD04, _id_E830F42670718693, _id_7A26E48FE2AEE716) {
  self endon("last_stand_finished");
  self notify("interrogation_anim_play_handle");
  self endon("interrogation_anim_play_handle");
  _id_00B6CA10CADF0A2D = 0;
  _id_BAA7BF816C823379 = 0;

  if(isDefined(attacker))
    _id_00B6CA10CADF0A2D = attacker _meth_C1092F42B6BBE490();

  if(isDefined(_id_EE2753C1176F5C7E))
    _id_BAA7BF816C823379 = _id_EE2753C1176F5C7E _meth_C1092F42B6BBE490();

  _id_FD346D58D905A11B = _id_27E4565CFCBF5E25(dir, _id_D5CC8B378F09BD04, "attacker", _id_00B6CA10CADF0A2D);
  _id_C125143A1B692A67 = _id_27E4565CFCBF5E25(dir, _id_D5CC8B378F09BD04, "defender", _id_BAA7BF816C823379);
  _id_4F0410BBD831664F = _id_27E4565CFCBF5E25(dir, _id_D5CC8B378F09BD04, "knife");
  _id_77A57E091496B231 = _id_27E4565CFCBF5E25(dir, _id_D5CC8B378F09BD04, "pda");

  if(isDefined(self._id_61859DD33E04AFAC) && isDefined(attacker) && isDefined(attacker.player_rig) && isDefined(_id_FD346D58D905A11B)) {
    attacker endon("death_or_disconnect");

    if(istrue(_id_7A26E48FE2AEE716))
      self._id_61859DD33E04AFAC scripts\common\anim::anim_first_frame_solo(attacker.player_rig, _id_FD346D58D905A11B);

    self._id_61859DD33E04AFAC childthread scripts\mp\anim::anim_player_solo(attacker, attacker.player_rig, _id_FD346D58D905A11B);

    if(isDefined(attacker._id_63254B5552422209))
      self._id_61859DD33E04AFAC childthread scripts\common\anim::anim_single_solo(attacker._id_63254B5552422209, _id_4F0410BBD831664F);

    if(isDefined(attacker._id_74C33A61490F2AF7))
      self._id_61859DD33E04AFAC childthread scripts\common\anim::anim_single_solo(attacker._id_74C33A61490F2AF7, _id_77A57E091496B231);
  }

  if(isDefined(self._id_862B6F35ADA766B8) && isDefined(_id_EE2753C1176F5C7E) && isDefined(_id_EE2753C1176F5C7E.player_rig) && isDefined(_id_C125143A1B692A67)) {
    _id_EE2753C1176F5C7E endon("death_or_disconnect");

    if(istrue(_id_7A26E48FE2AEE716))
      self._id_862B6F35ADA766B8 scripts\common\anim::anim_first_frame_solo(_id_EE2753C1176F5C7E.player_rig, _id_C125143A1B692A67);

    self._id_862B6F35ADA766B8 childthread scripts\mp\anim::anim_player_solo(_id_EE2753C1176F5C7E, _id_EE2753C1176F5C7E.player_rig, _id_C125143A1B692A67);
  }

  if(istrue(_id_E830F42670718693)) {
    _id_DBE2F5C8BBBEEE8C = _id_FA005DEA3B675DD4(dir, _id_D5CC8B378F09BD04);
    wait(_id_DBE2F5C8BBBEEE8C);
  }
}

_id_27E4565CFCBF5E25(dir, _id_D5CC8B378F09BD04, _id_846E68FE5B28F790, _id_24B6F4BD2E81097D) {
  if(istrue(_id_24B6F4BD2E81097D))
    _id_846E68FE5B28F790 = _id_846E68FE5B28F790 + "3pcam";

  return "interrogate_" + dir + "_" + _id_846E68FE5B28F790 + "_" + _id_D5CC8B378F09BD04;
}

_id_16F1ED28A559F91F(attacker, _id_EE2753C1176F5C7E) {
  _id_1A91C43C0366371A = getdvarint("dvar_84BA96C2974A8135", 0);

  if(istrue(_id_1A91C43C0366371A))
    return _id_A30D65A6F3331DC1(attacker, _id_EE2753C1176F5C7E);
  else
    return _id_BF625405D3E068AF(attacker, _id_EE2753C1176F5C7E);
}

_id_A30D65A6F3331DC1(attacker, _id_EE2753C1176F5C7E) {
  _id_AC727774017ACCAE = 22.5;
  _id_BBF4A6FB1025338A = 67.5;
  _id_10F21406A3625090 = 112.5;
  _id_7244D6D492287F0E = 157.5;
  _id_3E0D351E6E3A5CC2 = angleclamp(_id_EE2753C1176F5C7E.angles);
  _id_9EF779C4D770E613 = scripts\engine\math::anglebetweenvectorssigned(attacker.origin - _id_EE2753C1176F5C7E.origin, anglesToForward(_id_3E0D351E6E3A5CC2), (0, 0, 1));
  _id_ED478E32F316BD8C = 0;

  if(_id_9EF779C4D770E613 < 0)
    _id_ED478E32F316BD8C = 1;

  if(abs(_id_9EF779C4D770E613) < _id_AC727774017ACCAE)
    dir = "front";
  else if(abs(_id_9EF779C4D770E613) < _id_BBF4A6FB1025338A) {
    if(_id_ED478E32F316BD8C)
      dir = "frontleft";
    else
      dir = "frontright";
  } else if(abs(_id_9EF779C4D770E613) < _id_10F21406A3625090) {
    if(_id_ED478E32F316BD8C)
      dir = "left";
    else
      dir = "right";
  } else if(abs(_id_9EF779C4D770E613) < _id_7244D6D492287F0E) {
    if(_id_ED478E32F316BD8C)
      dir = "backleft";
    else
      dir = "backright";
  } else
    dir = "back";

  return dir;
}

_id_BF625405D3E068AF(attacker, _id_EE2753C1176F5C7E) {
  _id_3E0D351E6E3A5CC2 = angleclamp(_id_EE2753C1176F5C7E.angles);
  _id_9EF779C4D770E613 = scripts\engine\math::anglebetweenvectorssigned(attacker.origin - _id_EE2753C1176F5C7E.origin, anglesToForward(_id_3E0D351E6E3A5CC2), (0, 0, 1));

  if(_id_9EF779C4D770E613 > 0) {
    if(_id_9EF779C4D770E613 > 90)
      dir = "backright";
    else
      dir = "frontright";
  } else if(_id_9EF779C4D770E613 < -90)
    dir = "backleft";
  else
    dir = "frontleft";

  return dir;
}

_id_ACC5EA9379317664(player, _id_7F6D36CC641739D9, animtag, _id_64FC43B788AFAE69, _id_1E2F2224127D2990, anglesoffset) {
  if(!isDefined(_id_1E2F2224127D2990))
    _id_1E2F2224127D2990 = (0, 0, 0);

  if(!isDefined(anglesoffset))
    anglesoffset = (0, 0, 0);

  _id_6728B8AC11978BB2 = spawn("script_model", (0, 0, 0));
  _id_6728B8AC11978BB2 setModel(_id_7F6D36CC641739D9);
  _id_6728B8AC11978BB2 show();

  if(istrue(_id_64FC43B788AFAE69)) {
    if(player _meth_C1092F42B6BBE490())
      _id_6728B8AC11978BB2 hide();
    else
      _id_6728B8AC11978BB2 showonlytoplayer(player);
  } else {
    if(!player _meth_C1092F42B6BBE490())
      _id_6728B8AC11978BB2 hidefromplayer(player);

    _id_6728B8AC11978BB2 linkTo(player, animtag, _id_1E2F2224127D2990, anglesoffset);
  }

  return _id_6728B8AC11978BB2;
}

_id_64C48800869451A1(player, _id_DC1711FFC6CD2BF1, sceneangles) {
  _id_58DEBFD84E38F50B = spawn("script_model", _id_DC1711FFC6CD2BF1);
  _id_58DEBFD84E38F50B.angles = sceneangles;
  _id_58DEBFD84E38F50B setModel("tag_origin");
  _id_58DEBFD84E38F50B hide();
  _id_58DEBFD84E38F50B.player = player;
  return _id_58DEBFD84E38F50B;
}

_id_E1841AF234A09407(_id_B1E6FBABCE1A26BA, _id_41503CD028EFB569) {
  if(!isDefined(_id_41503CD028EFB569)) {
    return;
  }
  level.scr_animtree["player"] = #animtree;
  level.scr_anim["player"][_id_41503CD028EFB569] = _id_B1E6FBABCE1A26BA;
  level.scr_animname["player"][_id_41503CD028EFB569] = getanimname(_id_B1E6FBABCE1A26BA);
  level.scr_eventanim["player"][_id_41503CD028EFB569] = _id_41503CD028EFB569;
}

_id_4A6B9ECAE4B71AE5(_id_B1E6FBABCE1A26BA, _id_41503CD028EFB569) {
  if(!isDefined(_id_41503CD028EFB569)) {
    return;
  }
  level.scr_animtree["device"] = #animtree;
  level.scr_anim["device"][_id_41503CD028EFB569] = _id_B1E6FBABCE1A26BA;
  level.scr_animname["device"][_id_41503CD028EFB569] = getanimname(_id_B1E6FBABCE1A26BA);
  level.scr_eventanim["device"][_id_41503CD028EFB569] = _id_41503CD028EFB569;
}

_id_52A9113423FF7CE1(spawnpos, _id_B7850001037AA074) {
  _id_95658F1D17762B45 = getdvarfloat("dvar_46685B5A7AB844EB", 0.2) - 0.05;
  self.animname = "player";

  if(!isDefined(spawnpos))
    spawnpos = (0, 0, 0);

  if(!isDefined(_id_B7850001037AA074))
    _id_B7850001037AA074 = (0, 0, 0);

  _id_7521C682C7617240 = self _meth_C1092F42B6BBE490();
  self _meth_B88C89BB7CD1AB8E(spawnpos);
  _id_52241BCC3A205EF4 = (0, 0, self getplayerviewheight(self getstance()));
  _id_7B71E4920D76C2C1 = rotatevector(_id_52241BCC3A205EF4, self getplayerangles());
  _id_7B71E4920D76C2C1 = _id_52241BCC3A205EF4 - _id_7B71E4920D76C2C1;
  player_rig = spawn("script_arms", self.origin + _id_7B71E4920D76C2C1, 0, 0, self);
  player_rig.angles = self getplayerangles();
  player_rig.player = self;
  self.player_rig = player_rig;
  self.player_rig hide(1);
  self.player_rig.animname = "player";
  self.player_rig useanimtree(#animtree);
  self.player_rig.updatedversion = 1;

  if(istrue(_id_7521C682C7617240))
    self playerlinktodelta(self.player_rig, "tag_origin", 1, 0, 0, 0, 0, 0, 1, 1);
  else if(!scripts\mp\utility\player::isinlaststand(self))
    self playerlinktodelta(self.player_rig, "tag_origin", 1, 10, 10, 10, 10, 0, 1, 1);
  else
    self playerlinktodelta(self.player_rig, "tag_origin", 1, 4, 4, 8, 8, 0, 1, 1);

  self.player_rig moveTo(spawnpos, _id_95658F1D17762B45, 0.05, _id_95658F1D17762B45 * 0.25);
  self.player_rig rotateTo(_id_B7850001037AA074, _id_95658F1D17762B45, 0.05, _id_95658F1D17762B45 * 0.25);
  self notify("rig_created");
  scripts\engine\utility::waittill_any_2("remove_rig", "player_free_spot");

  if(istrue(level.gameended)) {
    return;
  }
  if(isDefined(self)) {
    self unlink();
    gunless = makeweapon(scripts\cp_mp\utility\inventory_utility::_id_3D5C51904FD25773());

    if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(gunless))
      scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(gunless);

    thread scripts\cp_mp\utility\inventory_utility::_id_9897D143C3FEEE05();
  }

  if(isDefined(player_rig))
    player_rig delete();
}

_id_FA005DEA3B675DD4(dir, _id_D5CC8B378F09BD04) {
  if(!isDefined(dir) || !isDefined(_id_D5CC8B378F09BD04))
    return 0.0;

  animname = _id_27E4565CFCBF5E25(dir, _id_D5CC8B378F09BD04, "attacker");
  animlength = getanimlength(level.scr_anim["player"][animname]);

  if(isDefined(animlength))
    return animlength;

  animname = _id_27E4565CFCBF5E25(dir, _id_D5CC8B378F09BD04, "defender");
  animlength = getanimlength(level.scr_anim["player"][animname]);

  if(isDefined(animlength))
    return animlength;

  return 0.0;
}

_id_341C7024A3E54638(dir, _id_EE2753C1176F5C7E, attacker) {
  _id_DA04238F117F371E = (62.707, 46.051, 6);
  _id_AF1341BEC25FFC13 = (74.806, -48.163, 19);
  _id_4A1C12F2F92B81C4 = (-26.042, 72.986, 19);
  _id_72D69E3F71A14B91 = (-41.891, -85.123, 16);
  _id_C9DE492AD170FA99 = (33.226, -140.939, 0);
  _id_4945066F80FB403A = (47, 144.501, 0);
  _id_C8DA9727E974891D = (47.171, -66.087, 0);
  _id_FCB771762F1BA156 = (42.768, 53.39, 0);
  _id_000F66FD0D606305 = (0, 0, 0);
  _id_524B19D2034E1406 = (0, 0, 0);
  _id_B047501CE5A60BC9 = (0, 0, 0);
  _id_3E0D351E6E3A5CC2 = (0, 0, 0);
  _id_0018BA7FF327954C = _id_FCB771762F1BA156;
  _id_BA0A9212A8D8504F = (0, 0, 0);

  switch (dir) {
    case "frontleft":
      _id_0018BA7FF327954C = _id_C9DE492AD170FA99;
      _id_BA0A9212A8D8504F = _id_DA04238F117F371E;
      break;
    case "frontright":
      _id_0018BA7FF327954C = _id_4945066F80FB403A;
      _id_BA0A9212A8D8504F = _id_AF1341BEC25FFC13;
      break;
    case "backleft":
      _id_0018BA7FF327954C = _id_C8DA9727E974891D;
      _id_BA0A9212A8D8504F = _id_4A1C12F2F92B81C4;
      break;
    case "backright":
      _id_0018BA7FF327954C = _id_FCB771762F1BA156;
      _id_BA0A9212A8D8504F = _id_72D69E3F71A14B91;
      break;
  }

  _id_0F462FA4A0E9AF84 = vectorNormalize(attacker.origin - _id_EE2753C1176F5C7E.origin);
  _id_C2A3587914211083 = anglesToForward(_id_EE2753C1176F5C7E.angles);
  _id_E5CD56AC6F0AC63F = (1, 0, 0);
  _id_D41EA444C61E5935 = scripts\engine\math::anglebetweenvectorssigned(_id_C2A3587914211083, _id_0F462FA4A0E9AF84, (0, 0, 1));
  _id_604CCA21B20714F7 = scripts\engine\math::anglebetweenvectorssigned(_id_E5CD56AC6F0AC63F, _id_BA0A9212A8D8504F, (0, 0, 1));
  _id_4051C7FD18783671 = _id_D41EA444C61E5935 - _id_604CCA21B20714F7;
  _id_28EB2DE6A2E2E9DF = rotatepointaroundvector((0, 0, 1), _id_C2A3587914211083, _id_4051C7FD18783671);
  _id_3E0D351E6E3A5CC2 = scripts\mp\utility\script::vectortoanglessafe(_id_28EB2DE6A2E2E9DF, (0, 0, 1));

  if(getdvarint("dvar_BBD8136229F7E702", 0)) {
    _id_28EB2DE6A2E2E9DF = _id_C2A3587914211083;
    _id_3E0D351E6E3A5CC2 = _id_EE2753C1176F5C7E.angles;
  }

  _id_05019E02FC30E335 = scripts\engine\math::anglebetweenvectorssigned(_id_E5CD56AC6F0AC63F, _id_28EB2DE6A2E2E9DF, (0, 0, 1));
  _id_000F66FD0D606305 = rotatepointaroundvector((0, 0, 1), _id_BA0A9212A8D8504F, _id_05019E02FC30E335);
  _id_181640917809E880 = anglesToForward(_id_0018BA7FF327954C);
  _id_4D034C998A162518 = rotatepointaroundvector((0, 0, 1), _id_181640917809E880, _id_05019E02FC30E335);
  _id_524B19D2034E1406 = scripts\mp\utility\script::vectortoanglessafe(vectorNormalize(_id_4D034C998A162518), (0, 0, 1));
  return [_id_000F66FD0D606305, _id_524B19D2034E1406, _id_B047501CE5A60BC9, _id_3E0D351E6E3A5CC2];
}

_id_A0B08DAE03DF9DAE(_id_7F6D36CC641739D9) {
  if(isDefined(_id_7F6D36CC641739D9)) {
    if(_id_7F6D36CC641739D9 islinked())
      _id_7F6D36CC641739D9 unlink();

    _id_7F6D36CC641739D9 delete();
  }
}

_id_96F2172E98188560(target) {
  if(!isDefined(self) || !isPlayer(self) || !isDefined(target)) {
    return;
  }
  if(getdvarint("dvar_72771711644C3F78", 1) == 0) {
    return;
  }
  if(self _meth_E40102956C887F7C()) {
    return;
  }
  if(isDefined(self._id_88F59C89F67E4385))
    self._id_88F59C89F67E4385 delete();

  startangles = self getplayerangles();
  _id_B98CF035C97EDEE9 = vectortoangles(vectorNormalize(target - self getEye()));
  _id_88F59C89F67E4385 = spawn("script_model", self.origin);
  _id_88F59C89F67E4385.angles = startangles;
  _id_88F59C89F67E4385 setModel("tag_origin");
  _id_88F59C89F67E4385 rotateTo(_id_B98CF035C97EDEE9, 0.4, 0.05);
  _id_88F59C89F67E4385 thread scripts\mp\teamrevive::_id_7F0AEBB7AD935939(self);
  self._id_88F59C89F67E4385 = _id_88F59C89F67E4385;
  mover = self getmovingplatformparent();

  if(isDefined(mover)) {
    scripts\cp_mp\vehicles\vehicle_occupancy::_id_3DFE65E73A7D0C86(self, mover);
    _id_88F59C89F67E4385 linkTo(mover);
    thread scripts\mp\teamrevive::_id_34FD10B9791B7BB2(mover);
  } else
    thread scripts\mp\teamrevive::_id_D75BBD43C2E29F0C();

  self playerlinktodelta(_id_88F59C89F67E4385, "", 1.0, 10, 10, 0, 0, 0, 0, 0, 1, 0.0, 0.3, 0.3);
}

_id_1CEC99551DBF4DD3(player) {
  if(!isDefined(player) || !_id_2A3C9A91BF1D3911()) {
    return;
  }
  if(isDefined(player.laststandreviveent)) {
    if(isDefined(player.laststandreviveent._id_121A99ED77D25F87)) {
      scripts\cp_mp\entityheadicons::setheadicon_deleteicon(player.laststandreviveent._id_121A99ED77D25F87);
      scripts\cp_mp\entityheadicons::setheadicon_deleteicon(player.laststandreviveent._id_A2BC763E8380844B);
      player.laststandreviveent._id_121A99ED77D25F87 = undefined;
      player.laststandreviveent._id_A2BC763E8380844B = undefined;
    }

    player setclientomnvar("ui_br_has_been_interrogated", 0);
  }

  if(istrue(player._id_895C1AAAC16F7256) && isDefined(player._id_F159F1C13AA75721) && isDefined(player._id_F159F1C13AA75721._id_4AF51E13229C40FE) && isPlayer(player._id_F159F1C13AA75721._id_4AF51E13229C40FE)) {
    interrogator = player._id_F159F1C13AA75721._id_4AF51E13229C40FE;
    _id_5BEBD2013B0F01EC = player;
    interrogator thread _id_1B56D7C4FE15B79C(interrogator, _id_5BEBD2013B0F01EC);
    _id_B37595AFABEFA038(interrogator, _id_5BEBD2013B0F01EC);
  }
}

_id_B3F5EEDE669E7182(attacker, victim) {
  level endon("game_ended");
  victim endon("death_or_disconnect");
  victim endon("last_stand_finished");
  victim endon("use_hold_interrogate_success");
  victim endon("use_hold_interrogate_fail");

  for(;;) {
    if(!isDefined(victim) || !isDefined(attacker)) {
      break;
    }

    if(victim useButtonPressed() || istrue(victim._id_7F59448717B5AA63)) {
      victim _id_4BA85E5091EEE483("stat_2F9162F82ED1F900", 4.0);
      victim thread _id_21C19CFC7139D773::_id_8FDD864A86AFE560(attacker);
      wait 1.5;
    }

    waitframe();
  }
}

_id_4BA85E5091EEE483(_id_F2F805FFFE803696, debounce) {
  if(!isDefined(self._id_0B91FC73CFEDFC41))
    self._id_0B91FC73CFEDFC41 = 0;

  if(!isDefined(debounce))
    debounce = 0.0;

  if(self._id_0B91FC73CFEDFC41 == 0) {
    self._id_0B91FC73CFEDFC41 = 1;
    level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, _id_F2F805FFFE803696);
    thread _id_6945DA38C80EC9CF(debounce);
  }
}

_id_6945DA38C80EC9CF(debounce) {
  level endon("game_ended");
  self endon("disconnect");
  wait(debounce);
  self._id_0B91FC73CFEDFC41 = 0;
}
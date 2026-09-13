/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\laststand.gsc
***********************************************/

init() {
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("laststand", ["usability", "vehicle_use", "crate_use", "ascender_use", "weapon_switch", "supers", "gesture", "killstreaks", "offhand_primary_weapons", "offhand_secondary_weapons", "offhand_weapons", "weapon_pickup", "melee", "show_operator_pet"]);
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("laststand_killstreak", ["usability", "weapon_switch", "gesture", "killstreaks", "supers", "fire", "melee", "offhand_primary_weapons", "offhand_secondary_weapons", "weapon_pickup"]);
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("laststand_revive", ["allow_movement", "stance_change", "usability", "reload", "fire", "offhand_weapons", "offhand_primary_weapons", "offhand_secondary_weapons", "killstreaks", "supers", "gesture", "allow_jump", "sprint", "melee", "weapon_pickup"]);
  level.laststandreviveents = [];

  if(isusingmatchrulesdata()) {} else {
    scripts\mp\utility\game::registerlaststandhealthdvar(50);
    scripts\mp\utility\game::registerlaststandrevivehealthdvar(30);
    scripts\mp\utility\game::registerlaststandtimerdvar(10);
    scripts\mp\utility\game::registerlaststandinvulntimerdvar(1);
    scripts\mp\utility\game::registerlaststandsuicidetimerdvar(5);
    scripts\mp\utility\game::registerlaststandrevivetimerdvar(5);
    scripts\mp\utility\game::registerlaststandweapondvar("iw9_me_fists_mp_ls");
    scripts\mp\utility\game::registerlaststandrevivedecayscaledvar(0.5);
    scripts\mp\utility\game::registerlaststandweapondelaydvar(0);
  }

  level.laststandhealth = scripts\mp\utility\dvars::getoverridedvarintexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_lastStandHealth"), "scr_player_lastStandHealth");
  level.laststandrevivehealth = scripts\mp\utility\dvars::getoverridedvarintexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_lastStandReviveHealth"), "scr_player_lastStandReviveHealth");

  if(level.laststandhealth > scripts\mp\tweakables::gettweakablevalue("player", "maxhealth"))
    level.laststandhealth = scripts\mp\tweakables::gettweakablevalue("player", "maxhealth");

  if(level.laststandrevivehealth > scripts\mp\tweakables::gettweakablevalue("player", "maxhealth"))
    level.laststandrevivehealth = scripts\mp\tweakables::gettweakablevalue("player", "maxhealth");

  level.laststandinvulntime = scripts\mp\utility\dvars::getoverridedvarfloatexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_lastStandInvulnTime"), "scr_player_lastStandInvulnTime");
  level.laststandrevivedecayscale = scripts\mp\utility\dvars::getoverridedvarfloatexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_lastStandReviveDecayScale"), "scr_player_lastStandReviveDecayScale");
  level.laststandrevivetimer = scripts\mp\utility\dvars::getoverridedvarfloatexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_lastStandReviveTimer"), "scr_player_lastStandReviveTimer");
  level.laststandsuicidetimer = scripts\mp\utility\dvars::getoverridedvarfloatexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_lastStandSuicideTimer"), "scr_player_lastStandSuicideTimer");
  level.laststandtimer = scripts\mp\utility\dvars::getoverridedvarfloatexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_lastStandTimer"), "scr_player_lastStandTimer");
  level.laststandweapon = scripts\mp\utility\dvars::getoverridedvarexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_lastStandWeapon"), "scr_player_lastStandWeapon");
  level.laststandweapondelay = scripts\mp\utility\dvars::getoverridedvarfloatexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_lastStandWeaponDelay"), "scr_player_lastStandWeaponDelay");
  level._id_D69A2EB29CE33499 = getdvarfloat("dvar_65DF50B82F004CA0", 5) * 1000;
  level._id_A4BF58776C3BE9D3 = getdvarfloat("dvar_46315DA2E5F5A9C2", 3) * 1000;
  level._id_0D88255CD662EB5C = getdvarint("dvar_F477E59410BEC785", 0);
  setdvarifuninitialized("dvar_C959AF6F995BF79A", 0);
  setdvarifuninitialized("dvar_CCFB1FE297CE6F9B", 0.3);
  level thread laststandmonitor();
  _id_4C770A9A4AD7659C::_id_52004C7A02FCFFD6("player_spawned", ::_id_061A6648C0A01CAD);
  game["dialog"]["interrogation_start"] = "ntrr_wzan_dtnc";
  game["dialog"]["interrogation_success"] = "ntrr_wzan_dtcm";
  game["dialog"]["interrogatted_start"] = "ntrr_wzan_slnt";
  game["dialog"]["interrogatted_success"] = "ntrr_wzan_tmcm";
  level._id_7BEA6884AFD52E81 = getdvarint("dvar_1E86798724D1115D", 0);
  level._id_CCF76D87061DE768 = getdvarfloat("dvar_9F647AA84D08A764", 3.0);
  level._id_84F71F417B53242E = getdvarfloat("dvar_019D24C665A9C49E", 3.0);
  level._id_21BC3423C7E17C34 = getdvarfloat("dvar_5BA57F036E2705B3", 0.5);
  level._id_9BAF4B1B4D19E7F8 = getdvarfloat("dvar_476D39E42E96C7A9", 3);
  level._id_44245002F5EC8E6F = getdvarfloat("dvar_855542C7206BD0F4", 10);
  level._id_3908273E5522E91D = getdvarint("dvar_E1C418951C15BB84", 7);
  level._id_0575CB25B5D41B53 = getdvarint("dvar_D2E2CA228DDE9024", 276);
  level._id_A9978096255CD8ED = getdvarint("dvar_5EAF1D7BC20C4F36", 1);
  level._id_201395EE05E5C10D = getdvarfloat("dvar_4D703AFFBBCD1603", 0.1);
}

_id_061A6648C0A01CAD(params) {
  if(istrue(level.laststand))
    self endon("death");
}

laststandthink() {
  level endon("game_ended");
  onenter();
  result = scripts\engine\utility::waittill_any_return_no_endon_death_6("last_stand_heal_success", "last_stand_revived", "last_stand_bleedout", "death_or_disconnect", "last_stand_self_revive", "enter_live_ragdoll");

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
    case "death_or_disconnect":
      if(!(scripts\mp\utility\game::isteamreviveenabled() && scripts\mp\flags::gameflag("prematch_done")))
        ondeath();

      break;
  }

  if(isDefined(self))
    self setclientomnvar("ui_is_laststand", 0);
}

onenter() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("last_stand_finished");
  self notify("last_stand_start");
  self setclientomnvar("ui_is_laststand", 1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound"))
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](self, "stat_1C1A3EBE5F3A23AF", undefined, 0.25);

  _id_A776F097EB36E500 = level.laststandhealth;
  self.health = _id_A776F097EB36E500;
  thread makelaststandinvuln();
  scripts\mp\utility\perk::giveperk("specialty_block_health_regen");
  self.inlaststand = 1;
  self.playergoingintols = undefined;
  self.hasshownlaststandicon = 0;
  self.laststandoldweaponobj = scripts\mp\utility\inventory::getlastweapon();
  self _meth_720152D5D95E2D86();
  laststandweapon = level.laststandweapon;

  if(isDefined(level._id_8B2457623E1802DC))
    laststandweapon = self[[level._id_8B2457623E1802DC]]();

  if(!isweapon(laststandweapon))
    laststandweapon = makeweapon(laststandweapon);

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

  childthread stucktime(_id_276B87B88716C2A5);
  _id_4C770A9A4AD7659C::callback("player_laststand");
}

last_stand_sfx() {
  if(!istrue(self.deathsdoorsfx)) {
    self.deathsdoorsfx = 1;
    self stoplocalsound("deaths_door_out");
    self playlocalsound("deaths_door_in");
    self setsoundsubmix("deaths_door_mp", 0.2, 1);
    self enableplayerbreathsystem(0);
    thread _id_6A5D3BF7A5B7064A::playerbreathingpainsound();
  }
}

handlelaststandweapongivepipeline(laststandweapon) {
  self endon("death_or_disconnect");
  self endon("last_stand_finished");
  level endon("game_ended");

  while(isDefined(self.currentweapon) && isDefined(self.currentweapon.basename) && self.currentweapon.basename == "iw9_armor_plate_deploy_mp")
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
  _id_6561E2B7A451E472 = makeweapon("iw8_gunless");
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
      self.islaststandbleedoutdmg = undefined;
    }

    if(self.health <= 0)
      onbleedout();

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

  _id_6BCC6405C250ECB4.usetime = usetime;

  if(!isDefined(self.curprogress))
    self.curprogress = 0;

  for(;;) {
    if(selfrevivebuttonPressed(_id_1730C8D8475566CD) && !istrue(_id_1730C8D8475566CD.isselfreviving) && (_id_1730C8D8475566CD isonground() || _id_1730C8D8475566CD _meth_E40102956C887F7C())) {
      _id_6BCC6405C250ECB4 notify("self_revive_start");
      _id_1730C8D8475566CD setlaststandselfreviving(1);

      if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
        _id_1730C8D8475566CD _id_2CEDCC356F1B9FC8::setplayerselfrevivingextrainfo(1);

      _id_6BCC6405C250ECB4 thread selfrevivemonitorrevivebuttonPressed();
    }

    waitframe();
  }
}

selfrevivemonitorrevivebuttonPressed() {
  _id_1730C8D8475566CD = self.owner;
  _id_6BCC6405C250ECB4 = self;
  level endon("game_ended");
  _id_1730C8D8475566CD endon("death_or_disconnect");
  _id_1730C8D8475566CD endon("last_stand_finished");
  _id_6BCC6405C250ECB4.waitingforteammaterevive = 0;
  _id_6BCC6405C250ECB4 thread selfrevivebuttonpresscleanup();

  while(scripts\mp\utility\player::isreallyalive(_id_1730C8D8475566CD) && selfrevivebuttonPressed(_id_1730C8D8475566CD) && _id_6BCC6405C250ECB4.curprogress < _id_6BCC6405C250ECB4.usetime) {
    while(!_id_1730C8D8475566CD isonground() && !_id_1730C8D8475566CD _meth_E40102956C887F7C() && selfrevivebuttonPressed(_id_1730C8D8475566CD))
      waitframe();

    if(!selfrevivebuttonPressed(_id_1730C8D8475566CD)) {
      break;
    }

    if(_id_1730C8D8475566CD isinexecutionvictim()) {
      break;
    }

    if(!istrue(_id_1730C8D8475566CD.isselfreviving)) {
      if(istrue(_id_1730C8D8475566CD._id_B24E609023CE8208)) {
        _id_1730C8D8475566CD._id_98D31D9CE04B2B81 = gettime();
        _id_1730C8D8475566CD thread _id_7E4D332E911E1B90::_id_B5216A6D7BD17210("iw8_ges_plyr_self_revive");

        if(!istrue(_id_1730C8D8475566CD.stimmodelattached)) {
          _id_1730C8D8475566CD attach("offhand_wm_stim", "tag_accessory_left");
          _id_1730C8D8475566CD.stimmodelattached = 1;
        }
      } else {
        _id_1730C8D8475566CD thread _id_7E4D332E911E1B90::_id_B5216A6D7BD17210("iw8_ges_plyr_self_revive");

        if(!istrue(_id_1730C8D8475566CD.stimmodelattached)) {
          _id_1730C8D8475566CD attach("offhand_wm_stim", "tag_accessory_left");
          _id_1730C8D8475566CD.stimmodelattached = 1;
        }
      }

      _id_1730C8D8475566CD.isselfreviving = 1;
      _id_1730C8D8475566CD allowmovement(0);
    }

    if(!isDefined(_id_6BCC6405C250ECB4.userate))
      _id_6BCC6405C250ECB4.userate = 0;

    if(istrue(_id_1730C8D8475566CD.beingrevived)) {
      _id_1730C8D8475566CD scripts\mp\gameobjects::updateuiprogress(_id_6BCC6405C250ECB4, 1);
      break;
    }

    if(!_id_1730C8D8475566CD isonground() && !_id_1730C8D8475566CD _meth_E40102956C887F7C()) {
      break;
    }

    _id_6BCC6405C250ECB4.curprogress = _id_6BCC6405C250ECB4.curprogress + level.frameduration * _id_6BCC6405C250ECB4.userate;
    _id_6BCC6405C250ECB4.userate = 1;
    _id_1730C8D8475566CD scripts\mp\gameobjects::updateuiprogress(_id_6BCC6405C250ECB4, 1);

    if(_id_6BCC6405C250ECB4.curprogress >= _id_6BCC6405C250ECB4.usetime) {
      _id_1730C8D8475566CD stopgestureviewmodel("ges_equip_stim_self_revive");
      wait 0.5;
      _id_1730C8D8475566CD finishreviveplayer("self_revive_success", _id_1730C8D8475566CD);

      if(istrue(_id_1730C8D8475566CD._id_B24E609023CE8208)) {
        _id_1730C8D8475566CD._id_B24E609023CE8208 = undefined;
        return;
      }

      if(isDefined(level.removeselfrevivetoken))
        _id_1730C8D8475566CD[[level.removeselfrevivetoken]]();

      return;
    }

    waitframe();
  }

  if(!istrue(_id_1730C8D8475566CD.beingrevived))
    _id_6BCC6405C250ECB4 thread decayreviveprogress();

  _id_1730C8D8475566CD notify("stopped_self_revive");
}

selfrevivebuttonpresscleanup() {
  _id_1730C8D8475566CD = self.owner;
  _id_6BCC6405C250ECB4 = self;
  level endon("game_ended");
  _id_1730C8D8475566CD notify("self_revive_cleanup_start");
  _id_1730C8D8475566CD endon("self_revive_cleanup_start");
  _id_1730C8D8475566CD scripts\engine\utility::waittill_any_return_no_endon_death_3("last_stand_finished", "stopped_self_revive", "death_or_disconnect");

  if(!istrue(_id_1730C8D8475566CD.beingrevived))
    _id_1730C8D8475566CD scripts\mp\gameobjects::updateuiprogress(_id_6BCC6405C250ECB4, 0);

  _id_1730C8D8475566CD allowmovement(1);

  if(istrue(_id_1730C8D8475566CD.stimmodelattached)) {
    _id_1730C8D8475566CD detach("offhand_wm_stim", "tag_accessory_left");
    _id_1730C8D8475566CD.stimmodelattached = 0;
  }

  _id_1730C8D8475566CD stopgestureviewmodel("ges_equip_stim_self_revive");
  _id_1730C8D8475566CD setlaststandselfreviving(0);
  _id_1730C8D8475566CD.isselfreviving = 0;
}

onexitcommon(_id_22F7E2F7E3607528) {
  self endon("disconnect");
  level endon("game_ended");
  self.laststandactionset = undefined;
  thread clearlaststandinvuln();
  self.fastcrouchspeedmod = 0;
  scripts\mp\weapons::updatemovespeedscale();

  if(scripts\mp\utility\perk::_hasperk("specialty_block_health_regen"))
    scripts\mp\utility\perk::removeperk("specialty_block_health_regen");

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

  scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");

  if(isDefined(level.modeonexitlaststandfunc))
    self[[level.modeonexitlaststandfunc]](_id_22F7E2F7E3607528);

  waittillframeend;
  self.inlaststand = 0;
}

onrevive(_id_4920BF02DF960BE9, _id_D07B7DCC79B24490) {
  _id_BA5943944B6CBA2F = self.laststandoldweaponobj;
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("laststand");
  _id_3B64EB40368C1450::_id_588F2307A3040610(scripts\engine\utility::_id_53C4C53197386572(self.laststandactionset, "laststand"));
  onexitcommon(1);
  self laststandrevive();
  self playsoundtoteam("npc_breath_revive", self.team, self, self);
  self playlocalsound("plr_breath_revive");
  self notify("laststand_revived");
  laststandweapon = level.laststandweapon;

  if(laststandweapon != "none")
    thread scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(_id_BA5943944B6CBA2F, 1);

  if(!istrue(_id_D07B7DCC79B24490)) {
    _id_A776F097EB36E500 = level.laststandrevivehealth;

    if(!getdvarint("dvar_BBA79EEB1C990103") || self.health < level.laststandrevivehealth)
      self.health = level.laststandrevivehealth;
  } else
    self.health = self.maxhealth;

  if(game["state"] == "postgame")
    scripts\mp\gamelogic::freezeplayerforroundend();

  scripts\mp\utility\player::setbeingrevivedinternal(0);
  scripts\cp_mp\utility\shellshock_utility::_stopshellshock();

  if(istrue(_id_4920BF02DF960BE9) && istrue(level.allowselfrevive))
    allowselfrevive(0);

  if(_id_396A814D39E7044F::_id_7BA31CB6B21C346F() && !istrue(_id_4920BF02DF960BE9) && !istrue(_id_D07B7DCC79B24490))
    thread _id_396A814D39E7044F::_id_36EDF91561322753(2);

  params = spawnStruct();
  params.reviver = self._id_63B104851A574F2A;
  _id_4C770A9A4AD7659C::callback("player_revived", params);
  self._id_63B104851A574F2A = undefined;
  self.laststandattacker = undefined;
  self.laststandmeansofdeath = undefined;
  self.laststandweaponobj = undefined;
  self.laststanddowneddata = undefined;
  self.laststandattackermodifiers = undefined;
}

onbleedout() {
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.laststandattacker) && scripts\mp\utility\perk::_hasperk("specialty_survivor"))
    _id_ED6F8AE3C33ED504(self.laststandattacker);

  thread onexitcommon();
  dropcarryobject();

  if(isDefined(self.laststandattacker))
    self.laststandattacker thread scripts\mp\rank::scoreeventpopup("stat_E24741BA71BBB56B");

  _id_4C770A9A4AD7659C::callback("player_bleedout");
  scripts\mp\utility\damage::_suicide();
}

ondeath(_id_642470E1ABC1BBF9) {
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.laststandattacker) && scripts\mp\utility\perk::_hasperk("specialty_survivor"))
    _id_ED6F8AE3C33ED504(self.laststandattacker);

  if(isDefined(_id_642470E1ABC1BBF9) && isDefined(self.laststandattacker) && istrue(self.laststandattacker.inlaststand))
    self.laststandattacker thread onlaststandkillenemy(_id_642470E1ABC1BBF9, self.laststandmeansofdeath, self.laststandweaponobj);

  if(istrue(self.isselfreviving))
    self notify("stopped_self_revive");

  thread onexitcommon();
  dropcarryobject();

  if(isDefined(level._id_E41F5F1692CA213E))
    level thread[[level._id_E41F5F1692CA213E]]();
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
  team = owner.team;
  reviveent linkTo(owner, "tag_origin", (0, 0, 6), (0, 0, 0));
  reviveent.owner = owner;
  reviveent.inuse = 0;
  reviveent.id = "laststand_reviver";
  reviveent.trigger = spawnStruct();
  reviveent.trigger.owner = owner;
  reviveent.trigger.id = "laststand_reviver";
  reviveent.trigger.targetname = "revive_trigger";
  reviveent makeusable();

  if(getdvarint("mgl", 0)) {
    reviveent setCursorHint("HINT_BUTTON");
    reviveent sethinticon("hud_icon_cyber_revive");
    reviveent sethintdisplayrange(192);
    reviveent setuserange(192);
  } else
    reviveent setCursorHint("HINT_NOICON");

  reviveent setusehideprogressbar(1);
  reviveent setuseholdduration("duration_none");
  reviveent setHintString(&"MP/LASTSTAND_REVIVE_USE");
  reviveent setusepriority(-3);
  reviveent thread _id_4A3B25B6B877FE73(team);
  reviveent thread revivetriggerthink(team);
  reviveent thread endreviveonownerdeathordisconnect();

  if(getdvarint("dvar_7A493092F8A1C04C", 0) && getdvarint("dvar_DDD02929770FCC8C", 0))
    owner thread secondwindthink();

  owner.laststandreviveent = reviveent;
  owner.laststandreviveent._id_9D797A762D9195EB = 0;
  level.laststandreviveents[reviveent getentitynumber()] = reviveent;
  reviveent thread removereviveentfromlevelarrayondeath();
  owner._id_B24E609023CE8208 = _id_556B8AEAA691317F::_id_A35FFF2FF233592A();
}

_id_35E8814575E3963D(owner) {
  owner endon("death_or_disconnect");
  level endon("game_ended");
  owner waittill("last_stand_transition_done");
  _id_CD0DE96A0CA17DB5 = spawn("script_model", owner.origin);
  _id_CD0DE96A0CA17DB5 setModel("tag_origin");
  team = owner.team;
  _id_CD0DE96A0CA17DB5 linkTo(owner, "tag_origin", (0, 0, 6), (0, 0, 0));
  _id_CD0DE96A0CA17DB5.owner = owner;
  _id_CD0DE96A0CA17DB5.inuse = 0;
  _id_CD0DE96A0CA17DB5.id = "laststand_interrogator";
  _id_CD0DE96A0CA17DB5.trigger = spawnStruct();
  _id_CD0DE96A0CA17DB5.trigger.owner = owner;
  _id_CD0DE96A0CA17DB5.trigger.id = "laststand_interrogation";
  _id_CD0DE96A0CA17DB5.trigger.targetname = "interrogation_trigger";
  _id_CD0DE96A0CA17DB5 makeusable();

  if(getdvarint("mgl", 0)) {
    _id_CD0DE96A0CA17DB5 setCursorHint("HINT_BUTTON");
    _id_CD0DE96A0CA17DB5 sethinticon("hud_icon_cyber_revive");
    _id_CD0DE96A0CA17DB5 sethintdisplayrange(192);
    _id_CD0DE96A0CA17DB5 setuserange(192);
  } else
    _id_CD0DE96A0CA17DB5 setCursorHint("HINT_NOICON");

  _id_CD0DE96A0CA17DB5 setusehideprogressbar(1);
  _id_CD0DE96A0CA17DB5 setuseholdduration("duration_none");
  _id_CD0DE96A0CA17DB5 setHintString(&"MP/LASTSTAND_INTERROGATE_USE");
  _id_CD0DE96A0CA17DB5 setusepriority(-2);
  _id_CD0DE96A0CA17DB5 thread _id_DC8861A5E3B418D5(team);
  _id_CD0DE96A0CA17DB5 thread _id_56E47961499CA06C(team);
  _id_CD0DE96A0CA17DB5 thread endreviveonownerdeathordisconnect();
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
  foreach(player in level.players) {
    if((istrue(level._id_D9A236C9A5AC921E) || team == player.team) && player != self.owner) {
      self enableplayeruse(player);
      continue;
    }

    self disableplayeruse(player);
  }
}

_id_38F5ADE989B3848F(team) {
  _id_0A427DED21077317 = scripts\mp\utility\player::getplayersinradius(self.origin, level._id_0575CB25B5D41B53);

  foreach(player in _id_0A427DED21077317) {
    if(team != player.team && player != self.owner) {
      self enableplayeruse(player);
      continue;
    }

    self disableplayeruse(player);
  }
}

_id_4A3B25B6B877FE73(team) {
  self endon("death");
  self.owner endon("last_stand_finished");

  for(;;) {
    updateusablebyteam(team);
    level waittill("joined_team");
  }
}

_id_DC8861A5E3B418D5(team) {
  self endon("death");
  self.owner endon("last_stand_finished");

  for(;;) {
    _id_38F5ADE989B3848F(team);
    level waittill("joined_team");
  }
}

revivetriggerthink(team) {
  self.owner endon("last_stand_finished");
  self.owner endon("last_stand_heal_active");
  self.owner endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", reviver);

    if(!istrue(level._id_D9A236C9A5AC921E) && reviver.team != team) {
      continue;
    }
    while(!reviver isonground() && !reviver _meth_E40102956C887F7C() && reviver useButtonPressed())
      waitframe();

    if(istrue(reviver.insertingarmorplate)) {
      reviver notify("try_armor_cancel", "last_stand_reviver_start");

      while(istrue(reviver.insertingarmorplate) && reviver useButtonPressed())
        waitframe();
    }

    if(!reviver useButtonPressed()) {
      continue;
    }
    self.owner scripts\mp\utility\player::setbeingrevivedinternal(1);
    _id_22F7E2F7E3607528 = 0;
    self.owner notify("handle_revive_message");
    self makeunusable();

    if(reviver _meth_C6CB3E654225077A())
      reviver _meth_FC1C1E51058904A3(&"MP/LASTSTAND_REVIVE_USE");

    self.owner allowmovement(0);
    reviver setlaststandreviving(1);
    reviver.revivingteammate = 1;
    thread useholdthink(reviver);
    reviver thread switchtoteammatereviveweapon(self.owner);
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
    self setHintString(&"MP/LASTSTAND_REVIVE_USE");

    if(getdvarint("mgl", 0)) {
      self setCursorHint("HINT_BUTTON");
      self sethinticon("hud_icon_cyber_revive");
      self sethintdisplayrange(192);
      self sethintdisplayfov(120);
      self setuserange(192);
      self setusefov(360);
    } else
      self setCursorHint("HINT_NOICON");

    updateusablebyteam(team);
  }
}

_id_56E47961499CA06C(team) {
  self.owner endon("last_stand_finished");
  self.owner endon("disconnect");
  level endon("game_ended");
  _id_5BEBD2013B0F01EC = self.owner;

  for(;;) {
    self waittill("trigger", interrogator);

    if(interrogator.team == team) {
      continue;
    }
    interrogator iprintlnbold("Interrogating...");
    _id_5BEBD2013B0F01EC iprintlnbold("You are being interrogated...");
    _id_2CEDCC356F1B9FC8::brleaderdialogteam("interrogation_start", interrogator.team);
    _id_2CEDCC356F1B9FC8::brleaderdialogteam("interrogatted_start", _id_5BEBD2013B0F01EC.team);

    while(!interrogator isonground() && !interrogator _meth_E40102956C887F7C() && interrogator useButtonPressed())
      waitframe();

    if(istrue(interrogator.insertingarmorplate)) {
      interrogator notify("try_armor_cancel", "interrogation_interrogator_start");

      while(istrue(interrogator.insertingarmorplate) && interrogator useButtonPressed())
        waitframe();
    }

    if(!interrogator useButtonPressed()) {
      continue;
    }
    _id_22F7E2F7E3607528 = 0;
    self makeunusable();

    if(interrogator _meth_C6CB3E654225077A())
      interrogator _meth_FC1C1E51058904A3(&"MP/LASTSTAND_INTERROGATE_USE");

    _id_5BEBD2013B0F01EC allowmovement(0);
    interrogator._id_93018D510A589832 = 1;
    thread useholdthink(interrogator, undefined, 1);
    interrogator thread switchtoteammatereviveweapon(_id_5BEBD2013B0F01EC, 1);
    _id_4930CBCE302555B1 = scripts\engine\utility::waittill_any_return_no_endon_death_3("use_hold_interrogate_success", "use_hold_interrogate_fail", "death_or_disconnect");

    if(interrogator _meth_C6CB3E654225077A())
      interrogator forceusehintoff();

    if(_id_4930CBCE302555B1 == "use_hold_interrogate_success")
      _id_5BEBD3013B0F041F = 1;

    interrogator notify("finish_victim_interrogation");
    _id_5BEBD2013B0F01EC scripts\mp\utility\player::setbeingrevivedinternal(0);
    _id_5BEBD3013B0F041F = _id_5BEBD2013B0F01EC _id_70F1DBC7125939B8(_id_4930CBCE302555B1, interrogator, team);

    if(istrue(_id_5BEBD3013B0F041F)) {
      return;
    }
    thread decayreviveprogress();
    self makeusable();

    if(getdvarint("mgl", 0)) {
      self setCursorHint("HINT_BUTTON");
      self sethinticon("hud_icon_cyber_revive");
      self sethintdisplayrange(192);
      self sethintdisplayfov(120);
      self setuserange(192);
      self setusefov(360);
    } else
      self setCursorHint("HINT_NOICON");

    _id_38F5ADE989B3848F(team);
  }
}

switchtoteammatereviveweapon(_id_22F7E3F7E360775B, interrogation) {
  reviver = self;
  reviver endon("death_or_disconnect");
  level endon("game_ended");

  if(!isDefined(interrogation))
    interrogation = 0;

  if(!istrue(reviver _meth_E40102956C887F7C())) {
    if(istrue(reviver.waitingtoplayreviveanimation)) {
      return;
    }
    if(istrue(interrogation))
      weaponobj = makeweapon("interrogation_tools_mp");
    else
      weaponobj = makeweapon("teammate_revive_stim_mp");

    streakinfo = reviver scripts\cp_mp\utility\killstreak_utility::createstreakinfo("", reviver);
    streakinfo.reviveweapon = weaponobj;

    for(_id_41BF9BF4918115AC = 0; !_id_41BF9BF4918115AC || istrue(reviver.blockreviveanimation); reviver.waitingtoplayreviveanimation = 1) {
      _id_41BF9BF4918115AC = reviver scripts\cp_mp\killstreaks\killstreakdeploy::switchtodeployweapon(weaponobj, streakinfo, ::teammatereviveweaponwaitputaway, undefined, ::onteammatereviveweaponswitchcomplete, undefined, ::onteammatereviveweapontaken, 0);
      waitframe();
    }

    reviver.blockreviveanimation = 1;
    reviver.waitingtoplayreviveanimation = 0;
  }

  reviver thread watchfordeathwhilereviving();
  reviver thread watchforteammatedeathwhilereviving(_id_22F7E3F7E360775B);
  reviver thread watchforteammaterevivedwhilereviving(_id_22F7E3F7E360775B);
}

onteammatereviveweaponswitchcomplete(streakinfo, _id_41BF9BF4918115AC) {
  reviver = self;
  reviver disableweaponswitch();
}

onteammatereviveweapontaken(streakinfo, _id_41BF9BF4918115AC) {
  reviver = self;
  reviver enableweaponswitch();
  reviver notify("revive_stim_finished");

  while(isDefined(self.currentweapon) && isDefined(self.currentweapon.basename) && (self.currentweapon.basename == "teammate_revive_stim_mp" || self.currentweapon.basename == "interrogation_tools_mp"))
    waitframe();

  waitframe();
  reviver.blockreviveanimation = 0;
}

teammatereviveweaponwaitputaway(streakinfo) {
  reviver = self;
  level endon("game_ended");

  if(!istrue(reviver.revivingteammate) && !istrue(reviver._id_93018D510A589832)) {
    return;
  }
  reviver scripts\engine\utility::waittill_any_return_no_endon_death_3("death_or_disconnect", "finish_buddy_reviving", "finish_victim_interrogation");
}

watchfordeathwhilereviving() {
  reviver = self;
  reviver endon("finish_buddy_reviving");
  reviver endon("finish_victim_interrogation");
  reviver endon("disconnect");
  level endon("game_ended");
  reviver waittill("death");
  reviver enableweaponswitch();
}

watchforteammatedeathwhilereviving(_id_22F7E3F7E360775B) {
  reviver = self;
  reviver endon("finish_buddy_reviving");
  reviver endon("finish_victim_interrogation");
  reviver endon("death_or_disconnect");
  level endon("game_ended");
  _id_22F7E3F7E360775B waittill("death_or_disconnect");
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

finishreviveplayer(_id_70687E0CC558A009, reviver) {
  _id_22F7E3F7E360775B = self;
  _id_22F7E2F7E3607528 = 0;

  if(!isDefined(_id_22F7E3F7E360775B) || !isalive(_id_22F7E3F7E360775B))
    return 0;

  self.fastcrouchspeedmod = 0;
  scripts\mp\weapons::updatemovespeedscale();

  if(_id_70687E0CC558A009 == "use_hold_revive_success" || _id_70687E0CC558A009 == "self_revive_on_kill_success" || _id_70687E0CC558A009 == "self_revive_success")
    _id_22F7E2F7E3607528 = 1;

  _id_22F7E3F7E360775B.beingrevived = 0;
  _id_22F7E3F7E360775B.isselfreviving = 0;

  if(_id_70687E0CC558A009 == "self_revive_success")
    _id_22F7E3F7E360775B selfrevivingdoneanimevent();

  _id_22F7E3F7E360775B allowmovement(1);

  if(_id_22F7E2F7E3607528) {
    _id_22F7E3F7E360775B scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
    _id_22F7E3F7E360775B notify("last_stand_revived");
    _id_22F7E3F7E360775B thread _id_A3A340A5D9222A17();
    _id_22F7E3F7E360775B._id_63B104851A574F2A = reviver;
  }

  _id_22F7E3F7E360775B takelaststandtransitionweapon();
  return _id_22F7E2F7E3607528;
}

_id_A3A340A5D9222A17() {
  self endon("death_or_disconnect");
  waitframe();
  _id_CCBC8F28CB6A19E7 = self setstance("stand");

  if(!_id_CCBC8F28CB6A19E7)
    _id_CCBC8F28CB6A19E7 = self setstance("prone");
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
  _id_5BEBD2013B0F01EC allowmovement(1);

  if(_id_5BEBD3013B0F041F) {
    _id_5BEBD2013B0F01EC scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
    _id_5BEBD2013B0F01EC notify("last_stand_interrogated");

    if(isDefined(self.laststandoutlineid)) {
      scripts\mp\utility\outline::outlinedisable(self.laststandoutlineid, self);
      self.laststandoutlineid = undefined;
    }

    interrogator _id_71346BF2430E4F17(_id_5BEBD2013B0F01EC);
  }

  return _id_5BEBD3013B0F041F;
}

decayreviveprogress() {
  self.owner endon("last_stand_finished");
  self.owner endon("last_stand_heal_active");
  self endon("use_hold_revive_start");
  self endon("use_hold_interrogate_start");
  self endon("self_revive_start");
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

_id_71346BF2430E4F17(victim) {
  interrogator = self;
  _id_26568FED2B866C11 = level.teamdata[victim.team]["players"];

  foreach(player in _id_26568FED2B866C11) {
    if(player scripts\mp\utility\perk::_hasperk("specialty_snapshot_immunity")) {
      interrogator _id_5762AC2F22202BA2::updatedamagefeedback("hittacresist");
      return;
    } else {
      player _id_AB6A75B53DE148AB(interrogator, level._id_762FC98BDFE1CB1D);
      triggerportableradarpingteam(player.origin, interrogator.team, level._id_0575CB25B5D41B53, 500);
    }
  }

  _id_2CEDCC356F1B9FC8::brleaderdialogteam("interrogation_success", interrogator.team);
  _id_2CEDCC356F1B9FC8::brleaderdialogteam("interrogatted_finish", victim.team);
}

_id_AB6A75B53DE148AB(interrogator, outlinetime) {
  victim = self;

  if(isPlayer(victim)) {
    if(isDefined(outlinetime))
      outlinetime = outlinetime;
    else
      outlinetime = 2.5;

    victim.painted = 1;

    if(!level.teambased)
      id = scripts\mp\utility\outline::outlineenableforplayer(victim, interrogator, "outlinefill_nodepth_orange", "equipment");
    else if(_id_58BE75C518BF0D40::shouldmodesetsquads())
      id = scripts\mp\utility\outline::outlineenableforsquad(victim, interrogator.team, interrogator._id_0FF97225579DE16A, "outlinefill_nodepth_orange", "equipment");
    else
      id = scripts\mp\utility\outline::outlineenableforteam(victim, interrogator.team, "outlinefill_nodepth_orange", "equipment");

    victim thread watchpainted(id, outlinetime);
    victim thread watchpaintedagain(id);

    foreach(equipment in scripts\engine\utility::array_removeundefined(victim.plantedlethalequip)) {
      if(!level.teambased)
        _id_F275474AACD30C96 = scripts\mp\utility\outline::outlineenableforplayer(equipment, interrogator, "outlinefill_nodepth_orange", "equipment");
      else if(_id_58BE75C518BF0D40::shouldmodesetsquads())
        _id_F275474AACD30C96 = scripts\mp\utility\outline::outlineenableforsquad(equipment, interrogator.team, interrogator._id_0FF97225579DE16A, "outlinefill_nodepth_orange", "equipment");
      else
        _id_F275474AACD30C96 = scripts\mp\utility\outline::outlineenableforteam(equipment, interrogator.team, "outlinefill_nodepth_orange", "equipment");

      equipment thread watchpainted(_id_F275474AACD30C96, outlinetime + 5);
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
  self.painted = 0;
  scripts\mp\utility\outline::outlinedisable(id, self);
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

  _id_22F7E3F7E360775B = self.owner;
  _id_6A1154C8BC126A40 = getdvarint("dvar_C959AF6F995BF79A");
  _id_93DA003F4F870AF4 = spawn("script_origin", self.origin);
  _id_93DA003F4F870AF4 hide();

  if(!_id_6A1154C8BC126A40)
    reviver _id_3B64EB40368C1450::_id_3633B947164BE4F3("laststand_revive", 0);

  if(istrue(interrogation))
    self notify("use_hold_interrogate_start");
  else
    self notify("use_hold_revive_start");

  reviver thread sfx_revive_lp();

  if(_id_6A1154C8BC126A40)
    dragallyprototype(reviver, _id_22F7E3F7E360775B);

  if(!isDefined(self.curprogress))
    self.curprogress = 0;

  self.inuse = 1;
  self.userate = 0;
  _id_391186B6DAE520CC = 0;

  if(isDefined(usetime))
    self.usetime = usetime;
  else if(reviver scripts\mp\utility\perk::_hasperk("specialty_medic"))
    self.usetime = scripts\mp\utility\dvars::getwatcheddvar("lastStandReviveTimer") * 1000 * getdvarfloat("perk_medicReviveSpeedRatio");
  else
    self.usetime = scripts\mp\utility\dvars::getwatcheddvar("lastStandReviveTimer") * 1000;

  if(_id_22F7E3F7E360775B scripts\mp\utility\perk::_hasperk("specialty_survivor") && isDefined(level._id_A4BF58776C3BE9D3))
    self.usetime = level._id_A4BF58776C3BE9D3;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && reviver scripts\mp\utility\perk::_hasperk("specialty_br_faster_revive"))
    self.usetime = self.usetime * 0.75;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound"))
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](reviver, "stat_572347275DFB41AB");

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
  self.inuse = 0;
  _id_93DA003F4F870AF4 delete();
  reviver buddyrevivingdoneanimevent();
  reviver setlaststandreviving(0);

  if(istrue(interrogation))
    reviver._id_93018D510A589832 = 0;
  else
    reviver.revivingteammate = 0;

  if(isDefined(reviver)) {
    reviver scripts\mp\gameobjects::updateuiprogress(self, 0);

    if(reviver _meth_C6CB3E654225077A())
      reviver forceusehintoff();
  }

  if(isDefined(_id_22F7E3F7E360775B))
    _id_22F7E3F7E360775B scripts\mp\gameobjects::updateuiprogress(self, 0);

  if(scripts\mp\utility\player::isreallyalive(reviver)) {
    if(_id_6A1154C8BC126A40)
      cleanupdragallyprototype(reviver, _id_22F7E3F7E360775B);
    else
      reviver _id_3B64EB40368C1450::_id_588F2307A3040610("laststand_revive");
  }

  reviver notify("sfx_revive_done");

  if(_id_4930CBCE302555B1 == "use_hold_think_success") {
    if(istrue(interrogation))
      reviver thread _id_098B53A7358927D9::_id_E800498086E36C29("interrogation");
    else
      reviver thread _id_098B53A7358927D9::_id_E800498086E36C29("reviver");

    if(istrue(level.allowselfrevive))
      reviver allowselfrevive(1);

    _id_EE08B1F41E7C2444 = scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73();

    if(!_id_EE08B1F41E7C2444) {
      if(istrue(interrogation))
        _id_22F7E3F7E360775B thread scripts\mp\rank::scoreeventpopup("stat_40C5F8104D76CC15");
      else
        _id_22F7E3F7E360775B thread scripts\mp\rank::scoreeventpopup("stat_AB2FB342759B6ABC");
    }

    if(istrue(interrogation))
      _id_22F7E3F7E360775B thread scripts\mp\hud_message::showsplash("execution", undefined, reviver);
    else
      _id_22F7E3F7E360775B thread scripts\mp\hud_message::showsplash("revived", undefined, reviver);

    _id_22F7E3F7E360775B.inlaststand = 0;

    if(istrue(interrogation))
      self notify("use_hold_interrogate_success");
    else
      self notify("use_hold_revive_success");

    return;
  } else if(_id_4930CBCE302555B1 == "use_hold_think_fail")
    _id_22F7E3F7E360775B notify("handle_revive_message");

  if(istrue(interrogation))
    self notify("use_hold_interrogate_fail");
  else
    self notify("use_hold_revive_fail");
}

sfx_revive_lp() {
  _id_4CF58793CC4F1AD6 = spawn("script_origin", self.origin);
  _id_4CF58793CC4F1AD6 linkTo(self);
  _id_4CF58793CC4F1AD6 playLoopSound("br_reviver_use_lp");
  self waittill("sfx_revive_done");
  playsoundatpos(self.origin, "br_reviver_use_end");
  _id_4CF58793CC4F1AD6 delete();
}

useholdthinkloop(reviver) {
  _id_22F7E3F7E360775B = self.owner;
  level endon("game_ended");
  _id_22F7E3F7E360775B endon("death_or_disconnect");
  _id_22F7E3F7E360775B endon("last_stand_finished");

  while(scripts\mp\utility\player::isreallyalive(reviver) && reviver useButtonPressed() && self.curprogress < self.usetime && (!isDefined(reviver.inlaststand) || !reviver.inlaststand) && distancesquared(reviver.origin, self.origin) <= 65536) {
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

suicidesetup() {
  self endon("death_or_disconnect");
  self endon("last_stand_finished");
  level endon("game_ended");
  thread showsuicidehintstring();

  if(!isbot(self))
    thread suicidemonitorcrouchbuttonpress();

  holdtime = 0;

  if(_id_2A3C9A91BF1D3911())
    _id_58D906AF2CAC1064 = level._id_CCF76D87061DE768;
  else
    _id_58D906AF2CAC1064 = level._id_21BC3423C7E17C34;

  for(;;) {
    waitframe();

    if(self stancebuttonPressed() && self isinexecutionvictim() == 0) {
      holdtime = holdtime + level.framedurationseconds;

      if(holdtime >= _id_58D906AF2CAC1064) {
        break;
      }
    } else
      holdtime = 0;
  }

  suicideonend();
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
        break;
      case "stance_pressed_up":
      case "timeout":
        if(_id_51BEE2F5B3B4E278 && gettime() - holdtime >= _id_4CE97D438A53F1D5)
          _id_95E94C34040BC5AD = 1;

        _id_51BEE2F5B3B4E278 = 0;
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
        else
          scripts\mp\utility\lower_message::setlowermessageomnvar("revive_or_respawn", int(gettime() + self.timeuntilbleedout * 1000));
      } else
        scripts\mp\utility\lower_message::setlowermessageomnvar("ffa_down_give_up", int(gettime() + self.timeuntilbleedout * 1000));
    } else if(_id_649E600E12376E07)
      scripts\mp\utility\lower_message::setlowermessageomnvar("self_revive");
    else if(self.pers["lives"] == 0 && scripts\mp\utility\game::isteamreviveenabled())
      scripts\mp\utility\lower_message::setlowermessageomnvar("spawn_revive_wait");
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
  _id_37470C2C6BF2DC4F = self.timeuntilbleedout;

  if(_id_8DD9F2EB8215A139 != 0) {
    for(;;) {
      waitframe();

      if(self isinexecutionvictim()) {
        continue;
      }
      if(!istrue(scripts\mp\utility\player::getbeingrevivedinternal()))
        _id_8DD9F2EB8215A139 = _id_8DD9F2EB8215A139 - level.framedurationseconds;

      _id_4C770A9A4AD7659C::callback("bleedout_tick", _id_8DD9F2EB8215A139 / _id_37470C2C6BF2DC4F);

      if(_id_8DD9F2EB8215A139 <= level.framedurationseconds) {
        self notify("last_stand_bleedout");
        break;
      }

      self.timeuntilbleedout = _id_8DD9F2EB8215A139;
    }
  }
}

addoverheadicon() {
  _id_1453F424673CF292 = self.origin;
  icon = newteamhudelem(self.team);
  icon.x = _id_1453F424673CF292[0];
  icon.y = _id_1453F424673CF292[1];
  icon.z = _id_1453F424673CF292[2] + 32;
  icon.alpha = 1.0;
  icon.archived = 0;
  icon.showinkillcam = 0;

  if(level.splitscreen)
    icon setshader("hud_realism_head_revive", 10, 10);
  else
    icon setshader("hud_realism_head_revive", 5, 5);

  icon setwaypoint(0);
  icon settargetEnt(self);
  thread cleanupoverheadicon(icon);
}

cleanupoverheadicon(icon) {
  self waittill("last_stand_finished");
  icon destroy();
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

    if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && scripts\cp_mp\utility\damage_utility::isheadshot(shitloc, smeansofdeath, attacker))
      return 0;

    if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && isexplosivedamagemod(smeansofdeath))
      return 0;

    if(istrue(self.gulagarena))
      return 0;

    if(isDefined(attacker) && (isDefined(attacker.classname) && attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn"))
      return 0;

    if(attacker == self && !scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
      return 0;

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && scripts\mp\utility\killstreak::isjuggernaut())
      return 0;

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && !scripts\mp\flags::gameflag("prematch_done"))
      return 0;

    if(isDefined(level.modelaststandallowed) && !self[[level.modelaststandallowed]](einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration))
      return 0;
  }

  return 1;
}

_id_ED6F8AE3C33ED504(attacker) {
  score = level.scoremod["kill"];

  if(score != 0) {
    if(level.teambased)
      level scripts\mp\gamescore::giveteamscoreforobjective(attacker.pers["team"], score, 0);
    else
      attacker scripts\mp\gamescore::giveplayerscore("stat_EF9582D72160F199", score, self);
  }
}

_id_2A3C9A91BF1D3911() {
  return istrue(level._id_7BEA6884AFD52E81);
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\laststand.gsc
***********************************************/

_id_029CB39AA7064ED6() {
  if(getDvar("r_reflectionprobegenerate") == "1" || level.createfx_enabled) {
    return;
  }
  _id_14609B809484646E::_id_8ECE37593311858A(::_id_A305799C00D57B2E);
  setdvarifuninitialized("dvar_E5275954295CA7D4", 0);
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("laststand", ["usability", "weapon_switch", "supers", "gesture", "killstreaks", "offhand_primary_weapons", "offhand_secondary_weapons", "offhand_weapons", "melee"]);
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("laststand_killstreak", ["usability", "weapon_switch", "gesture", "killstreaks", "supers", "fire", "melee", "offhand_primary_weapons", "offhand_secondary_weapons"]);
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("laststand_revive", ["allow_movement", "usability", "reload", "fire", "offhand_weapons", "offhand_primary_weapons", "offhand_secondary_weapons", "killstreaks", "supers", "gesture", "allow_jump", "sprint", "melee"]);
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("reviveShoot", ["weapon_switch", "offhand_weapons", "gesture", "killstreaks", "supers", "ads", "reload", "autoreload"]);
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("gameEndFreeze", ["usability", "ads", "fire", "weapon_switch", "offhand_weapons", "offhand_primary_weapons", "offhand_secondary_weapons", "killstreaks", "supers", "allow_jump", "sprint", "crouch", "prone", "melee"]);
  level.laststandreviveents = [];
  level.revive_icon_entities = [];
  level.players_being_revived = [];
  level._id_00A42B25FFADA980 = 1;
  level.modeonexitlaststandfunc = ::_id_4FE89278A6B193B2;

  if(!isDefined(level._id_028BCDD92F005721))
    level._id_028BCDD92F005721 = 1;

  _id_37DB281EB241645D(1);
  level._id_D5AB05B7947DE15A = [makeweaponfromstring("iw8_gunless_last_stand_enter"), makeweaponfromstring("iw9_gunless_mp"), makeweaponfromstring("iw9_me_diveknife_mp"), makeweaponfromstring("ks_remote_device_mp"), makeweaponfromstring("iw9_la_mike32_mp")];
  scripts\cp_mp\utility\script_utility::registersharedfunc("shellshock", "lastStandInterruptDelayFunc", ::getshellshockinterruptdelayms);
  level.modeplayerkilledspawn = ::playerkilledspawn;
  scripts\mp\utility\dvars::registerwatchdvar("lastStandWeapon", "iw9_gunless_mp");
  scripts\mp\utility\dvars::registerwatchdvarint("lastStandHealth", 150);
  scripts\mp\utility\dvars::registerwatchdvarint("lastStandReviveHealth", 30);
  scripts\mp\utility\dvars::registerwatchdvarfloat("lastStandTimer", 30);
  scripts\mp\utility\dvars::registerwatchdvarfloat("lastStandInvulnTimer", 8);
  scripts\mp\utility\dvars::registerwatchdvarfloat("lastStandSuicideTimer", 0);
  scripts\mp\utility\dvars::registerwatchdvarfloat("lastStandReviveTimer", 5);
  scripts\mp\utility\dvars::registerwatchdvarfloat("lastStandReviveDecayScale", 0.5);
  scripts\mp\utility\dvars::registerwatchdvarfloat("lastStandWeaponDelay", 0);
  scripts\mp\utility\dvars::registerwatchdvarfloat("lastStandInvulnAfterRevive", 5);
  gametype = scripts\cp\utility::getgametype();
  level.laststandhealth = scripts\mp\utility\dvars::getoverridedvarintexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", gametype, "_lastStandHealth"), "scr_player_lastStandHealth");
  level.laststandrevivehealth = scripts\mp\utility\dvars::getoverridedvarintexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", gametype, "_lastStandReviveHealth"), "scr_player_lastStandReviveHealth");

  if(level.laststandhealth > scripts\mp\tweakables::gettweakablevalue("player", "maxhealth"))
    level.laststandhealth = scripts\mp\tweakables::gettweakablevalue("player", "maxhealth");

  if(level.laststandrevivehealth > scripts\mp\tweakables::gettweakablevalue("player", "maxhealth"))
    level.laststandrevivehealth = scripts\mp\tweakables::gettweakablevalue("player", "maxhealth");

  level.laststandweapon = scripts\mp\utility\dvars::getoverridedvarexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", gametype, "_lastStandWeapon"), "scr_player_lastStandWeapon");
  level.laststandinvulntime = scripts\mp\utility\dvars::getoverridedvarfloatexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", gametype, "_lastStandInvulnTime"), "scr_player_lastStandInvulnTime");
  level.laststandrevivedecayscale = scripts\mp\utility\dvars::getoverridedvarfloatexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", gametype, "_lastStandReviveDecayScale"), "scr_player_lastStandReviveDecayScale");
  level.laststandrevivetimer = scripts\mp\utility\dvars::getoverridedvarfloatexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", gametype, "_lastStandReviveTimer"), "scr_player_lastStandReviveTimer");
  level.laststandsuicidetimer = scripts\mp\utility\dvars::getoverridedvarfloatexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", gametype, "_lastStandSuicideTimer"), "scr_player_lastStandSuicideTimer");
  level.laststandtimer = scripts\mp\utility\dvars::getoverridedvarfloatexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", gametype, "_lastStandTimer"), "scr_player_lastStandTimer");
  level.laststandweapondelay = scripts\mp\utility\dvars::getoverridedvarfloatexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", gametype, "_lastStandWeaponDelay"), "scr_player_lastStandWeaponDelay");
  level._id_AD1D6202B804074E = scripts\mp\utility\dvars::getoverridedvarfloatexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", gametype, "_lastStandInvulnAfterRevive"), "dvar_CDC84574D1513280");
  setdvarifuninitialized("dvar_C959AF6F995BF79A", 0);
  setdvarifuninitialized("dvar_CCFB1FE297CE6F9B", 0.3);
  level thread laststandmonitor();
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug / Last Stand / Enter Last Stand\" \"set scr_start_debug laststand_enter\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug / Last Stand / Enable Revive Icon\" \"set scr_start_debug enableReviveIcon\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug / Last Stand / Disable Revive Icon\" \"set scr_start_debug disableReviveIcon\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug / Last Stand / Allow Manual Revive From Spectatate\" \"set scr_allowManualReviveFromSpectate 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
}

_id_A305799C00D57B2E() {
  _id_8C810A2B49618C0F();
}

_id_8C810A2B49618C0F() {
  foreach(player in level.players)
  player _id_9B04C8ABB560BA40();
}

_id_9B04C8ABB560BA40() {
  _id_116171939929AF39::broadcast_status(self, 0);
  _id_1DAB4A6BAD01C509 = self getentitynumber();
  self setclientomnvar("ui_client_num", _id_1DAB4A6BAD01C509);
  _id_3BCAA2CBAF54ABDD::setcoopplayerdata_for_everyone("EoGPlayer", _id_1DAB4A6BAD01C509, "ui_client_num", _id_1DAB4A6BAD01C509);
  _id_3BCAA2CBAF54ABDD::setcoopplayerdata_for_everyone("EoGPlayer", _id_1DAB4A6BAD01C509, "laststand_time_ms", 0);
  scripts\cp\utility::_id_1DBC717085326045(0, 0, -1);
  self setplayerdata("cp", "EoGPlayer", _id_1DAB4A6BAD01C509, "ui_revivee_entity_num", -1);
  _id_3BCAA2CBAF54ABDD::setcoopplayerdata_for_everyone("EoGPlayer", _id_1DAB4A6BAD01C509, "ui_dog_tags_entity_num", -1);
}

_id_0A44F7E2D76D0108() {
  _id_1DAB4A6BAD01C509 = self getentitynumber();
  _id_8DD9F2EB8215A139 = level.laststandtimer;
  _id_CEEDF73D8321005E = 0;

  switch (_id_CEEDF73D8321005E) {
    case 0:
      _id_116171939929AF39::broadcast_status(self, 1);
    case 1:
      _id_3BCAA2CBAF54ABDD::eog_player_update_stat("downs", 1);
    case 3:
    case 2:
      self setclientomnvar("ui_is_laststand", 1);
    case 4:
      self setclientomnvar("ui_client_num", _id_1DAB4A6BAD01C509);
    case 5:
      _id_3BCAA2CBAF54ABDD::setcoopplayerdata_for_everyone("EoGPlayer", _id_1DAB4A6BAD01C509, "ui_client_num", _id_1DAB4A6BAD01C509);
    case 6:
      _id_3BCAA2CBAF54ABDD::setcoopplayerdata_for_everyone("EoGPlayer", _id_1DAB4A6BAD01C509, "laststand_time_ms", int(_id_8DD9F2EB8215A139 * 1000));
  }
}

_id_3D86B15E0372A8C1() {
  _id_9B04C8ABB560BA40();
}

_id_D9ADF40567AFE0EC(dvar, value) {}

playerkilledspawn(_id_642470E1ABC1BBF9) {
  if(istrue(level._id_307AD42B8F2CCE95))
    return 0;

  return 1;
}

laststandthink(damage_data) {
  level endon("game_ended");
  onenter(damage_data);
  result = "";

  if(istrue(self.shouldskiplaststand)) {
    if(istrue(level._id_2DCE4D6DCB6C3FB9)) {
      scripts\cp\utility::store_weapons_status(level._id_D5AB05B7947DE15A, 1);
      _id_1DB8D0E02A99C5E2::_id_7C70DC615DA72C51();
    }

    result = "last_stand_bleedout";
    wait 0.5;
  } else
    result = scripts\engine\utility::waittill_any_return_no_endon_death_5("last_stand_heal_success", "last_stand_revived", "last_stand_bleedout", "death_or_disconnect", "last_stand_self_revive");

  switch (result) {
    case "last_stand_revived":
      onrevive();
      break;
    case "last_stand_self_revive":
      onrevive(1);
      break;
    case "last_stand_bleedout":
      onbleedout(undefined, undefined, undefined, damage_data);
      break;
    case "last_stand_heal_success":
      onrevive(0, 1);
      break;
    case "death_or_disconnect":
      if(!scripts\mp\flags::gameflag("prematch_done"))
        ondeath();

      break;
  }
}

onenter(damage_data) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("last_stand_finished");
  self notify("last_stand_start");

  if(!istrue(level.gameended))
    level._id_5A1E175009ECEC56 = 1;

  self setclientomnvar("ui_stop_armor_hint", 1);
  _id_116171939929AF39::broadcast_status(self, 1);
  _id_3BCAA2CBAF54ABDD::eog_player_update_stat("downs", 1);
  scripts\cp\cp_analytics::logevent_downed(self, damage_data.attacker);
  gameshouldend = _id_5DE995015A65E87D(self, 1);

  if(gameshouldend && isDefined(level.endgame) && isDefined(level.end_game_string_index)) {
    player_vehicle = scripts\cp_mp\utility\player_utility::getvehicle();

    if(isDefined(player_vehicle)) {
      seatid = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(player_vehicle, self);
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(player_vehicle, seatid, self, undefined, 1);
    }

    _id_BE3B62A925C3795F = scripts\engine\utility::ter_op(isDefined(level._id_04D5F75DF17960BF), level._id_04D5F75DF17960BF, "kia");
    level thread[[level.endgame]]("axis", level.end_game_string_index[_id_BE3B62A925C3795F]);
  }

  if(scripts\cp\utility::touchingbadtrigger())
    self.shouldskiplaststand = 1;

  if(!istrue(level._id_00A42B25FFADA980) || istrue(self.shouldskiplaststand))
    return 0;

  scripts\cp\utility::_id_4CBAED764C116A25(1);
  self setclientomnvar("ui_is_laststand", 1);
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "stat_1C1A3EBE5F3A23AF");
  _id_A776F097EB36E500 = level.laststandhealth;
  thread last_stand_sfx();

  if(istrue(level._id_E1008A2AFED467A7))
    self.maxhealth = _id_A776F097EB36E500;

  self.health = _id_A776F097EB36E500;
  thread makelaststandinvuln();
  scripts\cp\utility::giveperk("specialty_block_health_regen");
  self.inlaststand = 1;
  self.playergoingintols = undefined;
  self.hasshownlaststandicon = 0;
  self.laststandoldweaponobj = scripts\cp\utility::getweapontoswitchbackto();

  if(!isnullweapon(self getheldoffhand()))
    thread scripts\cp\equipment\cp_gas_grenade::gas_takeheldoffhand();

  self.navmodifier = createnavobstaclebyent(self);
  thread _id_DCDB0AC73A967450();
  laststandweapon = level.laststandweapon;

  if(isDefined(level.laststandweaponcallback) && getdvarint("dvar_DDD02929770FCC8C", 0))
    laststandweapon = self[[level.laststandweaponcallback]]();

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
  self.fastcrouchspeedmod = getdvarfloat("dvar_1A0DE898609317B4", 0);
  scripts\cp_mp\challenges::stopchallengetimer("alive_not_downed");
  childthread stucktime(_id_276B87B88716C2A5, damage_data);

  if(getdvarint("dvar_E5275954295CA7D4", 0))
    thread suicidesetup();

  if(getdvarint("dvar_E17DEF891365B5E8"))
    thread dodamagewhiledown();
}

_id_DCDB0AC73A967450() {
  self endon("death_or_disconnect");
  self endon("laststand_revived");
  level endon("game_ended");

  for(;;) {
    self.navmodifier = _func_D37EB02511329AD6(self);
    wait 0.1;
  }
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
  thread scripts\cp_mp\utility\inventory_utility::_switchtoweapon(_id_DEC5F8278C01CCC3);
  wait 1.7;
  self notify("last_stand_transition_done");
  scripts\cp_mp\utility\inventory_utility::_takeweapon(_id_DEC5F8278C01CCC3);

  if(!isweapon(laststandweapon) && (laststandweapon == "none" || laststandweapon == "iw9_gunless_mp"))
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
    _id_AE0DA1578AECE301 = "iw9_gunless_mp";

  _id_003FE001FFF6B3BA = makeweapon(_id_AE0DA1578AECE301);
  scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_003FE001FFF6B3BA, undefined, undefined, 1);
  thread scripts\cp_mp\utility\inventory_utility::_switchtoweapon(_id_003FE001FFF6B3BA);
  return _id_003FE001FFF6B3BA;
}

givelaststandweapon(laststandweapon) {
  if(!isweapon(laststandweapon))
    laststandweapon = _id_2669878CF5A1B6BC::buildweapon(laststandweapon);

  _id_1B47EC827F34BD5B = getcompleteweaponname(laststandweapon);

  if(!self hasweapon(_id_1B47EC827F34BD5B))
    scripts\cp_mp\utility\inventory_utility::_giveweapon(laststandweapon, undefined, undefined, 1);

  thread scripts\cp_mp\utility\inventory_utility::_switchtoweapon(_id_1B47EC827F34BD5B);
}

disableweaponsovertime(t) {
  level endon("game_ended");
  _id_3B64EB40368C1450::set("disableWeaponsOverTime", "weapon", 0);
  scripts\engine\utility::waittill_any_timeout_1(t, "death_or_disconnect");
  _id_3B64EB40368C1450::set("disableWeaponsOverTime", "weapon", 1);
}

switchtofists(laststandweapon) {
  self endon("death_or_disconnect");
  self endon("end_switchToFists");

  while(scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(laststandweapon, 1) == 0)
    waitframe();
}

dodamagewhiledown() {
  level endon("game_ended");
  self endon("death");
  self endon("laststand_revived");
  self endon("death_or_disconnect");
  self endon("last_stand_finished");
  self endon("entered_spectate");
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

  if(getdvarint("dvar_E5275954295CA7D4", 0))
    thread suicidesetup();

  _id_3D2A165F057F047A = 0.0;

  while(self.health > 0) {
    if(self isinexecutionvictim()) {
      wait 1.0;
      continue;
    }

    if(isalive(self) && !istrue(istrue(self.beingrevived) || istrue(self.isselfreviving))) {
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

stucktime(_id_276B87B88716C2A5, damage_data) {
  self.stuckinlaststand = 1;

  if(isDefined(_id_276B87B88716C2A5) && _id_276B87B88716C2A5 > 0)
    wait(_id_276B87B88716C2A5);

  self.stuckinlaststand = 0;
  _id_8DD9F2EB8215A139 = level.laststandtimer;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {}

  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && _id_8DD9F2EB8215A139 != 0)
    _id_8DD9F2EB8215A139 = max(_id_8DD9F2EB8215A139 - level.laststandsuicidetimer, 1);
  else
    _id_8DD9F2EB8215A139 = 0;

  _id_1DAB4A6BAD01C509 = self getentitynumber();
  self setclientomnvar("ui_client_num", _id_1DAB4A6BAD01C509);
  _id_3BCAA2CBAF54ABDD::setcoopplayerdata_for_everyone("EoGPlayer", _id_1DAB4A6BAD01C509, "ui_client_num", _id_1DAB4A6BAD01C509);
  _id_3BCAA2CBAF54ABDD::setcoopplayerdata_for_everyone("EoGPlayer", _id_1DAB4A6BAD01C509, "laststand_time_ms", int(_id_8DD9F2EB8215A139 * 1000));
  self.timeuntilbleedout = _id_8DD9F2EB8215A139;
  thread bleedoutthink(damage_data);

  if(getdvarint("dvar_E5275954295CA7D4", 0))
    thread suicidesetup();
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
  _id_1730C8D8475566CD thread scripts\cp\utility::_id_B94DF25AA73F60A0();
  usetime = scripts\mp\utility\dvars::getwatcheddvar("lastStandReviveTimer") * 1000;

  if(_id_1730C8D8475566CD scripts\cp\utility::_hasperk("specialty_survivor") && isDefined(level._id_D69A2EB29CE33499))
    usetime = level._id_D69A2EB29CE33499;

  if(_id_1730C8D8475566CD scripts\cp\utility::_hasperk("specialty_br_faster_revive"))
    usetime = usetime * 0.75;

  _id_6BCC6405C250ECB4.usetime = usetime;

  if(!isDefined(self.curprogress))
    self.curprogress = 0;

  for(;;) {
    if(selfrevivebuttonPressed(_id_1730C8D8475566CD) && !istrue(_id_1730C8D8475566CD.isselfreviving) && !istrue(_id_1730C8D8475566CD.beingrevived)) {
      _id_6BCC6405C250ECB4 notify("self_revive_start");
      _id_1730C8D8475566CD setlaststandselfreviving(1);
      _id_1730C8D8475566CD setplayerselfrevivingextrainfo(1);
      _id_6BCC6405C250ECB4 selfrevivemonitorrevivebuttonPressed();
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

  while(scripts\cp_mp\utility\player_utility::isreallyalive(_id_1730C8D8475566CD) && selfrevivebuttonPressed(_id_1730C8D8475566CD) && _id_6BCC6405C250ECB4.curprogress < _id_6BCC6405C250ECB4.usetime) {
    while(!(_id_1730C8D8475566CD isonground() || _id_1730C8D8475566CD _meth_E40102956C887F7C()) && selfrevivebuttonPressed(_id_1730C8D8475566CD))
      waitframe();

    if(!selfrevivebuttonPressed(_id_1730C8D8475566CD)) {
      break;
    }

    if(_id_1730C8D8475566CD isinexecutionvictim()) {
      break;
    }

    if(!istrue(_id_1730C8D8475566CD.isselfreviving)) {
      _id_02F319065B4736A4 = _id_1730C8D8475566CD _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("gesture");

      if(istrue(_id_1730C8D8475566CD._id_B24E609023CE8208))
        _id_1730C8D8475566CD thread _id_66122A002AFF5D57::playerplaygestureweaponanim("iw8_ges_plyr_self_revive_stim_pistol", 10);
      else {
        if(!istrue(_id_1730C8D8475566CD.stimmodelattached)) {
          _id_1730C8D8475566CD attach("offhand_wm_stim", "tag_accessory_left");
          _id_1730C8D8475566CD.stimmodelattached = 1;
        }

        _id_1730C8D8475566CD thread _id_66122A002AFF5D57::playerplaygestureweaponanim("iw8_ges_plyr_self_revive", 10);
      }

      _id_1730C8D8475566CD.isselfreviving = 1;
      _id_1730C8D8475566CD allowmovement(0);
    }

    if(!isDefined(_id_6BCC6405C250ECB4.userate))
      _id_6BCC6405C250ECB4.userate = 0;

    if(istrue(_id_1730C8D8475566CD.beingrevived)) {
      if(isDefined(_id_6BCC6405C250ECB4._id_5150A7BB3C2957DA)) {
        _id_6BCC6405C250ECB4.id = _id_6BCC6405C250ECB4._id_5150A7BB3C2957DA;
        _id_6BCC6405C250ECB4._id_5150A7BB3C2957DA = undefined;
      }

      _id_1730C8D8475566CD scripts\cp\utility::_id_1DBC717085326045(6);
      break;
    }

    _id_6BCC6405C250ECB4.curprogress = _id_6BCC6405C250ECB4.curprogress + level.frameduration * _id_6BCC6405C250ECB4.userate;
    _id_6BCC6405C250ECB4.userate = 1;

    if(_id_6BCC6405C250ECB4.id != "self_revive")
      _id_6BCC6405C250ECB4._id_5150A7BB3C2957DA = _id_6BCC6405C250ECB4.id;

    _id_6BCC6405C250ECB4.id = "self_revive";
    _id_1730C8D8475566CD scripts\cp\utility::updateuiprogress(_id_6BCC6405C250ECB4, 1);

    if(_id_6BCC6405C250ECB4.curprogress >= _id_6BCC6405C250ECB4.usetime) {
      _id_1730C8D8475566CD stopgestureviewmodel("ges_equip_stim_self_revive");
      _id_1730C8D8475566CD stopgestureviewmodel("iw9_vm_ges_stimpistol_self_revive");
      wait 0.5;
      _id_1730C8D8475566CD _id_3B64EB40368C1450::_id_588F2307A3040610("laststand");
      _id_1730C8D8475566CD finishreviveplayer("self_revive_success", _id_1730C8D8475566CD);

      if(istrue(_id_1730C8D8475566CD._id_B24E609023CE8208)) {
        _id_1730C8D8475566CD._id_B24E609023CE8208 = undefined;
        return;
      }

      if(isDefined(level.removeselfrevivetoken))
        _id_1730C8D8475566CD[[level.removeselfrevivetoken]]();

      _id_116171939929AF39::broadcast_status(_id_1730C8D8475566CD, 0);
      _id_1730C8D8475566CD _id_66122A002AFF5D57::removeselfrevivetoken();
      _id_1730C8D8475566CD thread _id_1B7EBC11CD2BC4A8();
      level._id_1143DC125C696F7A = 1;
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(_id_1730C8D8475566CD, "stat_8C6FAF2929248DA5");
      _id_1730C8D8475566CD notify("last_stand_revived");
      _id_1730C8D8475566CD notify("last_stand_finished");
      return;
    }

    waitframe();
  }

  if(!istrue(_id_1730C8D8475566CD.beingrevived)) {
    updatesquadmemberlaststandreviveprogress(_id_1730C8D8475566CD, _id_1730C8D8475566CD, _id_6BCC6405C250ECB4.curprogress, 1);
    _id_6BCC6405C250ECB4 thread decayreviveprogress();
  }

  _id_1730C8D8475566CD notify("stopped_self_revive");
}

updatesquadmemberlaststandreviveprogress(_id_22F7E3F7E360775B, reviver, progress, _id_979D1594B4F7F7BE) {
  if(isDefined(_id_22F7E3F7E360775B._id_3F78C6A0862F9E25)) {
    if(!isDefined(level.br_squadrevivestatus))
      level.br_squadrevivestatus = [];

    _id_70401238ACB839BC = get_int_or_0(level.br_squadrevivestatus[_id_22F7E3F7E360775B.team]);

    if(!isalive(_id_22F7E3F7E360775B)) {
      _id_979D1594B4F7F7BE = 1;
      progress = 0;
    }

    _id_053B0B2667F5CEB2 = _id_22F7E3F7E360775B == reviver;
    squadindex = _id_22F7E3F7E360775B._id_3F78C6A0862F9E25;
    _id_98C2F6161F41A683 = int(ceil(clamp(progress, 0, 1) * 128));
    _id_B792D342072A35C0 = _id_98C2F6161F41A683;

    if(istrue(_id_979D1594B4F7F7BE))
      _id_22F7E3F7E360775B setplayerselfrevivingextrainfo(0);
    else if(_id_053B0B2667F5CEB2)
      _id_22F7E3F7E360775B setplayerselfrevivingextrainfo(1);

    _id_64571E3AECCD1A07 = squadindex * 8;
    _id_B27D0EFF739466E0 = (_id_B792D342072A35C0 & 255) << _id_64571E3AECCD1A07;
    _id_F8F977081D3DA8B4 = ~(255 << _id_64571E3AECCD1A07);
    _id_ED711AEAF5E8CB76 = _id_70401238ACB839BC &_id_F8F977081D3DA8B4;
    _id_454D6756FB16FF83 = _id_ED711AEAF5E8CB76 + _id_B27D0EFF739466E0;
    level.br_squadrevivestatus[_id_22F7E3F7E360775B.team] = _id_454D6756FB16FF83;

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getTeamData")) {
      _id_6D5ED003AF1F9612 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getTeamData")]](_id_22F7E3F7E360775B.team, "players");

      if(isDefined(_id_6D5ED003AF1F9612) && _id_6D5ED003AF1F9612.size > 0) {
        foreach(_id_F0EA4030349A33D5 in _id_6D5ED003AF1F9612) {
          if(!istestclient(_id_F0EA4030349A33D5) && isDefined(_id_F0EA4030349A33D5 getclientomnvar("ui_br_squad_revive_status")))
            _id_F0EA4030349A33D5 setclientomnvar("ui_br_squad_revive_status", _id_454D6756FB16FF83);
        }
      }
    }
  }
}

get_int_or_0(value) {
  if(!isDefined(value))
    return 0;

  return int(value);
}

setplayerselfrevivingextrainfo(value) {
  if(istrue(value))
    self.game_extrainfo = self.game_extrainfo | 8192;
  else
    self.game_extrainfo = self.game_extrainfo &~8192;
}

selfrevivebuttonpresscleanup() {
  _id_1730C8D8475566CD = self.owner;
  _id_6BCC6405C250ECB4 = self;
  level endon("game_ended");
  _id_1730C8D8475566CD notify("self_revive_cleanup_start");
  _id_1730C8D8475566CD endon("self_revive_cleanup_start");
  _id_1730C8D8475566CD scripts\engine\utility::waittill_any_return_no_endon_death_3("last_stand_finished", "stopped_self_revive", "death_or_disconnect");

  if(isDefined(_id_6BCC6405C250ECB4._id_5150A7BB3C2957DA)) {
    _id_6BCC6405C250ECB4.id = _id_6BCC6405C250ECB4._id_5150A7BB3C2957DA;
    _id_6BCC6405C250ECB4._id_5150A7BB3C2957DA = undefined;
  }

  if(!istrue(_id_1730C8D8475566CD.beingrevived))
    _id_1730C8D8475566CD scripts\cp\utility::updateuiprogress(_id_6BCC6405C250ECB4, 0);

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

  if(istrue(_id_22F7E2F7E3607528))
    _id_116171939929AF39::broadcast_status(self, 0);

  _id_0372301AF73968CB::_id_019B9BB9CEF6A2D3();
  self setclientomnvar("ui_stop_armor_hint", 0);

  if(!self _meth_6F55D55CCFF20D14())
    self notify("swim_end");

  clear_last_stand_timer(self);
  self.laststandactionset = undefined;
  thread clearlaststandinvuln();
  self.fastcrouchspeedmod = 0;

  if(isDefined(level.move_speed_scale))
    self[[level.move_speed_scale]]();

  if(scripts\cp\utility::_hasperk("specialty_block_health_regen"))
    _id_6E09A830FAB9468F::removeperk("specialty_block_health_regen");

  laststandweapon = level.laststandweapon;
  laststandweapon = makeweapon(laststandweapon);

  if(self getcurrentprimaryweapon() != laststandweapon) {
    self notify("end_switchToFists");
    scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(laststandweapon);
  } else
    scripts\cp_mp\utility\inventory_utility::_takeweapon(laststandweapon);

  self.laststandoldweapon = undefined;

  if(istrue(getbeingrevivedinternal()))
    setbeingrevivedinternal(0);

  self notify("last_stand_finished");
  self setclientomnvar("ui_is_laststand", 0);
  scripts\cp\utility::_id_1DBC717085326045(0, 0, -1);
  scripts\cp\utility::_id_4CBAED764C116A25(0);
  scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");

  if(isDefined(level.modeonexitlaststandfunc))
    self[[level.modeonexitlaststandfunc]](_id_22F7E2F7E3607528);

  self.inlaststand = 0;
}

onrevive(_id_4920BF02DF960BE9, _id_D07B7DCC79B24490) {
  _id_BA5943944B6CBA2F = self.laststandoldweaponobj;
  _id_3B64EB40368C1450::set("on_revive_disables", "vehicle_use", 1);
  _id_3B64EB40368C1450::set("on_revive_disables", "crate_use", 1);
  _id_3B64EB40368C1450::set("on_revive_disables", "ascender_use", 1);

  if(isDefined(self.laststandactionset))
    _id_3B64EB40368C1450::_id_3633B947164BE4F3(self.laststandactionset, 1);

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
    _id_5AD98C689425D831();

  onexitcommon(1);
  self laststandrevive();
  self playsoundtoteam("npc_breath_revive", self.team, self, self);
  self playlocalsound("plr_breath_revive");
  self notify("laststand_revived");

  if(isDefined(self.navmodifier))
    destroynavobstacle(self.navmodifier);

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
    freezeplayerforroundend();

  setbeingrevivedinternal(0);

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && !istrue(self.gulag)) {
    _id_3B64EB40368C1450::set("onRevive", "weapon_switch_clip", 1);

    foreach(_id_F0EA4030349A33D5 in level.teamdata[self.team]["alivePlayers"]) {
      if(!isDefined(_id_F0EA4030349A33D5)) {
        continue;
      }
      if(_id_F0EA4030349A33D5 != self)
        _id_F0EA4030349A33D5 thread scripts\cp\cp_hud_message::showsplash("br_teammate_revived", undefined, self);
    }
  }

  scripts\cp_mp\utility\shellshock_utility::_stopshellshock();

  if(istrue(_id_4920BF02DF960BE9) && istrue(level.allowselfrevive))
    allowselfrevive(0);

  self.laststandattacker = undefined;
  self.laststandmeansofdeath = undefined;
  self.laststandweaponobj = undefined;
  self.laststanddowneddata = undefined;
  self.laststandattackermodifiers = undefined;
}

setbeingrevivedinternal(_id_14DD46408EFEF0F3) {
  self.beingrevived = _id_14DD46408EFEF0F3;
  self setbeingrevived(_id_14DD46408EFEF0F3);
}

getbeingrevivedinternal(_id_B6E6F398EFE5430C) {
  return istrue(self.beingrevived) || !istrue(_id_B6E6F398EFE5430C) && istrue(self.isselfreviving);
}

freezeplayerforroundend(delay) {
  self endon("disconnect");
  scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
  scripts\mp\utility\lower_message::clearlowermessages();

  if(!isDefined(delay))
    delay = level.framedurationseconds;

  wait(delay);
  _id_3B64EB40368C1450::_id_3633B947164BE4F3("gameEndFreeze", 0);

  if(self isonground() || self isonladder())
    self allowmovement(0);
  else
    thread gameendfreezemovement();
}

gameendfreezemovement() {
  _id_8A5D258252579930 = 0.0;

  while(_id_8A5D258252579930 < 1) {
    if(!self isonground())
      _id_8A5D258252579930 = _id_8A5D258252579930 + level.framedurationseconds;
    else {
      self allowmovement(0);
      break;
    }

    wait(level.framedurationseconds);
  }

  self allowmovement(0);
}

onbleedout(attacker, lifeid, smeansofdeath, damage_data) {
  if(!isDefined(self)) {
    return;
  }
  self.respawn_forcespawnorigin = self.origin;
  self.respawn_forcespawnangles = self getplayerangles(1);
  gameshouldend = _id_5DE995015A65E87D(self);

  if(gameshouldend && isDefined(level.endgame) && isDefined(level.end_game_string_index)) {
    player_vehicle = scripts\cp_mp\utility\player_utility::getvehicle();

    if(isDefined(player_vehicle)) {
      seatid = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(player_vehicle, self);
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(player_vehicle, seatid, self, undefined, 1);
    }

    _id_BE3B62A925C3795F = scripts\engine\utility::ter_op(isDefined(level._id_04D5F75DF17960BF), level._id_04D5F75DF17960BF, "kia");
    level thread[[level.endgame]]("axis", level.end_game_string_index[_id_BE3B62A925C3795F]);
  }

  if(isDefined(self.navmodifier))
    destroynavobstacle(self.navmodifier);

  if(self _meth_6F55D55CCFF20D14())
    self._id_D88F609DB87E5503 = 1;

  _id_E74630E55C27F7A8();

  if(isDefined(self.laststandattacker))
    self.laststandattacker thread _id_187A04151C40FB72::scoreeventpopup("stat_E24741BA71BBB56B");

  if(!istrue(level.gameended)) {
    self.deathsdoorsfx = 0;
    self clearsoundsubmix("deaths_door_mp");
    self playlocalsound("deaths_door_death");
    self enableplayerbreathsystem(1);
  }
}

enter_spectate(_id_1730C8D8475566CD, _id_FB1DEF007972B25A, reviveent) {
  _id_1730C8D8475566CD notify("enter_spectate");
  _id_1730C8D8475566CD endon("enter_spectate");
  _id_1730C8D8475566CD endon("disconnect");
  level endon("game_ended");
  level thread _id_153F83A298FAF9C6(_id_1730C8D8475566CD.origin);

  if(isDefined(_id_1730C8D8475566CD.carryicon))
    _id_1730C8D8475566CD.carryicon destroy();

  _id_1730C8D8475566CD.has_building_upgrade = 0;

  if(isDefined(self.instant_revive_buffer))
    self.instant_revive_buffer = undefined;

  _id_7B56CADA70B59153 = 0;

  if(getdvarint("dvar_C88F515E7C55AF60"))
    _id_7B56CADA70B59153 = 1;

  if(istrue(level.enable_manual_revive) || _id_7B56CADA70B59153)
    _id_1730C8D8475566CD thread manualreviveinspec();

  enter_camera_zoomout(_id_1730C8D8475566CD);

  if(istrue(_id_1730C8D8475566CD.fauxdead) || istrue(_id_1730C8D8475566CD.binc130)) {
    _id_1730C8D8475566CD.fauxdead = undefined;
    _id_1730C8D8475566CD enter_bleed_out(_id_1730C8D8475566CD);
    _id_1730C8D8475566CD playslamzoomflash();
  } else
    camera_zoomout(_id_1730C8D8475566CD, _id_FB1DEF007972B25A, reviveent);

  exit_camera_zoomout();
}

manualreviveinspec() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("revive");
  self notify("manualReviveInSpec");
  self endon("manualReviveInSpec");
  _id_D8E99039AB6C1F7B = 1;
  wait(_id_D8E99039AB6C1F7B);
  self notifyonplayercommand("manual_revive", "+usereload");
  thread scripts\cp\utility::hint_prompt("manual_revive", 1);
  self waittill("manual_revive");
  thread scripts\cp\utility::hint_prompt("manual_revive", 0);

  if(isDefined(self.dogtag))
    self.dogtag delete();

  self.reviveent notify("revive_success");
  thread instant_revive(self);
}

teleport_to_location() {
  level.manual_revive_location = level.vehicle_travel_array[0].origin + (0, 0, 200);

  if(!isDefined(level.manual_revive_location)) {
    return;
  }
  level endon("game_ended");
  scripts\engine\utility::waittill_any_timeout_1(3, "revive");
  self setOrigin(level.manual_revive_location);
}

_id_6380168026B7B3CA(player) {
  if(isDefined(player.body)) {
    player.body delete();
    player.body = undefined;
  }

  if(isPlayer(player)) {
    body = player cloneplayer(0);
    body startragdoll();
    player.body = body;
  }
}

ondeath(_id_642470E1ABC1BBF9) {
  if(!isDefined(self)) {
    return;
  }
  self endon("disconnect");
  onexitcommon();

  if(getdvarint("dvar_67A2C37B183BAA49", 0) && hasselfrevivetoken())
    disable_self_revive(self);

  gameshouldend = _id_5DE995015A65E87D(self);

  if(gameshouldend && isDefined(level.endgame) && isDefined(level.end_game_string_index)) {
    player_vehicle = scripts\cp_mp\utility\player_utility::getvehicle();

    if(isDefined(player_vehicle)) {
      seatid = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(player_vehicle, self);
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(player_vehicle, seatid, self, undefined, 1);
    }

    _id_BE3B62A925C3795F = scripts\engine\utility::ter_op(isDefined(level._id_04D5F75DF17960BF), level._id_04D5F75DF17960BF, "kia");
    level thread[[level.endgame]]("axis", level.end_game_string_index[_id_BE3B62A925C3795F]);
  }

  _id_5814D27874B48E54 = spawnStruct();
  _id_5814D27874B48E54.victim = self;
  _id_5814D27874B48E54.attacker = undefined;
  _id_5814D27874B48E54.meansofdeath = self.laststandmeansofdeath;
  _id_5814D27874B48E54.weaponfullstring = _id_642470E1ABC1BBF9.weaponfullstring;

  if(isDefined(self.laststandattacker))
    _id_5814D27874B48E54.attacker = self.laststandattacker;

  if(isDefined(self.laststandweaponobj))
    _id_5814D27874B48E54.weaponfullstring = getcompleteweaponname(self.laststandweaponobj);

  _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_player_death", _id_5814D27874B48E54);

  if(isDefined(_id_642470E1ABC1BBF9) && isDefined(self.laststandattacker) && istrue(self.laststandattacker.inlaststand))
    self.laststandattacker thread onlaststandkillenemy(_id_642470E1ABC1BBF9, self.laststandmeansofdeath, self.laststandweaponobj);

  self.respawn_forcespawnorigin = self.origin;
  self.respawn_forcespawnangles = self getplayerangles(1);

  if(self _meth_6F55D55CCFF20D14())
    self._id_D88F609DB87E5503 = 1;

  _id_E74630E55C27F7A8();

  if(istrue(self.isselfreviving))
    self notify("stopped_self_revive");

  if(!istrue(level.gameended)) {
    self.deathsdoorsfx = 0;
    self clearsoundsubmix("deaths_door_mp");
    self playlocalsound("deaths_door_death");
    self enableplayerbreathsystem(1);
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

dropcarryobject() {
  if(isDefined(self.carryobject))
    return;
}

revivesetup(owner) {
  owner endon("death_or_disconnect");
  level endon("game_ended");

  if(istrue(level.gameended) || _id_9D24182B90507AA9()) {
    return;
  }
  owner waittill("last_stand_transition_done");
  reviveent = spawn("script_model", owner.origin);
  reviveent setModel("tag_origin");
  reviveent makeusable();
  reviveent _meth_DFB78B3E724AD620(1);
  reviveent setHintString(&"MP/LASTSTAND_REVIVE_USE");
  reviveent setCursorHint("HINT_NOICON");
  reviveent setusehideprogressbar(1);
  reviveent setuseholdduration("duration_none");
  reviveent setusepriority(-3);
  reviveent linkTo(owner, "tag_origin", (0, 0, 6), (0, 0, 0));
  team = owner.team;
  reviveent.owner = owner;
  reviveent.inuse = 0;
  reviveent.id = "laststand_reviver";
  reviveent.trigger = spawnStruct();
  reviveent.trigger.owner = owner;
  reviveent.trigger.id = "laststand_reviver";
  reviveent.trigger.targetname = "revive_trigger";
  level.reviveent = reviveent;
  owner.reviveent = reviveent;
  reviveent thread trackteamchanges(team);
  reviveent thread revivetriggerthink(team);
  reviveent thread endreviveonownerdeathordisconnect();

  if(getdvarint("dvar_7A493092F8A1C04C", 0) && getdvarint("dvar_DDD02929770FCC8C", 0))
    owner thread secondwindthink();

  owner.laststandreviveent = reviveent;
  level.laststandreviveents[reviveent getentitynumber()] = reviveent;
  reviveent thread removereviveentfromlevelarrayondeath();

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
    reviveent thread _id_AF3BD2E64377CD03();

  if(owner hasselfrevivetoken())
    owner.laststandreviveent selfrevivethink();
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
  _id_1730C8D8475566CD thread scripts\cp\cp_hud_message::showsplash("br_second_wind");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getTeamData")) {
    _id_E2B2BBD9E6539F11 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getTeamData")]](_id_1730C8D8475566CD.team, "players");

    foreach(player in _id_E2B2BBD9E6539F11) {
      if(player != _id_1730C8D8475566CD && isalive(player))
        player thread scripts\cp\cp_hud_message::showsplash("br_teammate_second_wind", undefined, _id_1730C8D8475566CD);
    }
  }

  _id_1730C8D8475566CD notify("last_stand_revived");
  _id_1730C8D8475566CD notify("last_stand_finished");
}

endreviveonownerdeathordisconnect() {
  self endon("death");
  results = self.owner scripts\engine\utility::waittill_any_return_4("death_or_disconnect", "last_stand_finished", "last_stand_heal_active", "entered_spectate");

  if(isDefined(self.owner)) {
    _id_1DAB4A6BAD01C509 = self.owner getentitynumber();
    _id_3BCAA2CBAF54ABDD::setcoopplayerdata_for_everyone("EoGPlayer", _id_1DAB4A6BAD01C509, "ui_dog_tags_entity_num", -1);
  }

  self delete();
}

_id_AF3BD2E64377CD03() {
  level endon("game_ended");
  self.owner endon("last_stand_finished");
  self endon("death");

  for(;;) {
    if(_id_9D24182B90507AA9()) {
      self _meth_DFB78B3E724AD620(0);
      return;
    }

    wait 0.25;
  }
}

removereviveentfromlevelarrayondeath() {
  level endon("game_ended");
  entnum = self getentitynumber();
  self waittill("death");
  level.laststandreviveents[entnum] = undefined;
}

updateusablebyteam(team) {
  foreach(player in level.players) {
    if(team == player.team && player != self.owner && !istrue(player scripts\cp\utility::_hasperk("specialty_revive_use_weapon")))
      self enableplayeruse(player);
    else
      self disableplayeruse(player);

    if(istrue(player scripts\cp\utility::_hasperk("specialty_revive_use_weapon")))
      player.hiddenreviveents[self getentitynumber()] = self;
  }
}

trackteamchanges(team) {
  self endon("death");
  self.owner endon("last_stand_finished");

  for(;;) {
    updateusablebyteam(team);
    level waittill("joined_team");
  }
}

revivetriggerthink(team) {
  self endon("death");
  self.owner endon("last_stand_finished");
  self.owner endon("last_stand_heal_active");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", reviver);

    if(istrue(self.owner getbeingrevivedinternal(1))) {
      continue;
    }
    if(istrue(reviver.insertingarmorplate)) {
      reviver notify("try_armor_cancel", "last_stand_reviver_start");

      while(istrue(reviver.insertingarmorplate) && reviver useButtonPressed())
        waitframe();
    }

    if(!reviver useButtonPressed()) {
      continue;
    }
    self.id = "laststand_reviver";
    self.owner setbeingrevivedinternal(1);
    _id_22F7E2F7E3607528 = 0;
    self.owner notify("handle_revive_message");
    self _meth_DFB78B3E724AD620(0);
    self.owner allowmovement(0);
    reviver setlaststandreviving(1);
    reviver.revivingteammate = 1;
    thread useholdthink(reviver);
    reviver thread switchtoteammatereviveweapon(self.owner);
    _id_1CC9CCEA4AA0F847 = reviver getentitynumber();
    _id_2155979C4665D382 = self.owner getentitynumber();
    reviver setplayerdata("cp", "EoGPlayer", _id_1CC9CCEA4AA0F847, "ui_revivee_entity_num", _id_2155979C4665D382);
    _id_4930CBCE302555B1 = scripts\engine\utility::waittill_any_return_no_endon_death_3("use_hold_revive_success", "use_hold_revive_fail", "death_or_disconnect");

    if(_id_4930CBCE302555B1 == "use_hold_revive_success")
      _id_22F7E2F7E3607528 = 1;

    if(isDefined(reviver)) {
      reviver setplayerdata("cp", "EoGPlayer", _id_1CC9CCEA4AA0F847, "ui_revivee_entity_num", -1);
      reviver notify("finish_buddy_reviving");
    }

    self.owner setbeingrevivedinternal(0);

    if(_id_22F7E2F7E3607528) {
      if(istrue(self.owner.spectating))
        self.owner._id_86B400F3BC4F6255 = 1;

      if(_id_396A814D39E7044F::_id_7BA31CB6B21C346F())
        self.owner thread _id_396A814D39E7044F::_id_36EDF91561322753(2);
      else
        thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self.owner, "stat_A4C67E28DD65B35F");

      self.owner thread _id_1B7EBC11CD2BC4A8();
      _id_22F7E2F7E3607528 = self.owner finishreviveplayer(_id_4930CBCE302555B1, reviver);
      self.owner notify("last_stand_revived");
      self.owner notify("last_stand_finished");
      return;
    }

    thread decayreviveprogress();
    self _meth_DFB78B3E724AD620(1);
    updateusablebyteam(team);
    _id_22F7E2F7E3607528 = self.owner finishreviveplayer(_id_4930CBCE302555B1, reviver);
  }
}

_id_7956D96AF822A9A3(player) {
  level endon("game_ended");
  reviveent = player.reviveent;

  if(!isDefined(reviveent)) {
    return;
  }
  player setbeingrevivedinternal(0);

  if(istrue(player.spectating))
    player._id_86B400F3BC4F6255 = 1;

  player thread _id_1B7EBC11CD2BC4A8();
  _id_22F7E2F7E3607528 = player finishreviveplayer("use_hold_revive_success", undefined);
  player notify("last_stand_revived");
  player notify("last_stand_finished");
}

_id_656840B28EB4C279(team, _id_35E1BA03A83AA40B, _id_DB3F492B756B2CE7) {
  level endon("game_ended");

  if(isDefined(self.owner))
    _id_B8B0A5E88FAE74DB = self.owner;
  else
    _id_B8B0A5E88FAE74DB = self;

  if(!isinlaststand(_id_B8B0A5E88FAE74DB) && !istrue(_id_B8B0A5E88FAE74DB.spectating)) {
    return;
  }
  _id_B8B0A5E88FAE74DB endon("last_stand_finished");
  _id_B8B0A5E88FAE74DB endon("last_stand_heal_active");
  reviver = _id_DB3F492B756B2CE7;
  _id_B8B0A5E88FAE74DB setbeingrevivedinternal(1);
  _id_22F7E2F7E3607528 = 1;
  _id_B8B0A5E88FAE74DB notify("handle_revive_message");

  if(_id_22F7E2F7E3607528) {
    if(istrue(_id_B8B0A5E88FAE74DB.spectating))
      _id_B8B0A5E88FAE74DB._id_86B400F3BC4F6255 = 1;

    if(_id_396A814D39E7044F::_id_7BA31CB6B21C346F())
      _id_B8B0A5E88FAE74DB thread _id_396A814D39E7044F::_id_36EDF91561322753(2);
    else
      thread scripts\cp\cp_player_battlechatter::trysaylocalsound(_id_B8B0A5E88FAE74DB, "stat_A4C67E28DD65B35F");

    _id_B8B0A5E88FAE74DB thread _id_1B7EBC11CD2BC4A8();
    _id_22F7E2F7E3607528 = _id_B8B0A5E88FAE74DB finishreviveplayer("use_hold_revive_success", reviver);
    _id_B8B0A5E88FAE74DB thread scripts\cp\utility::hint_prompt("revived_by_stim_pistol", 1, 3);
    _id_B8B0A5E88FAE74DB notify("last_stand_revived");
    _id_B8B0A5E88FAE74DB notify("last_stand_finished");
    return;
  }
}

switchtoteammatereviveweapon(_id_22F7E3F7E360775B) {
  reviver = self;
  reviver endon("death_or_disconnect");
  level endon("game_ended");

  if(istrue(reviver.waitingtoplayreviveanimation)) {
    return;
  }
  weaponobj = makeweapon("teammate_revive_stim_mp");
  streakinfo = reviver scripts\cp_mp\utility\killstreak_utility::createstreakinfo("", reviver);
  streakinfo.reviveweapon = weaponobj;

  for(_id_41BF9BF4918115AC = 0; !_id_41BF9BF4918115AC || istrue(reviver.blockreviveanimation); reviver.waitingtoplayreviveanimation = 1) {
    _id_41BF9BF4918115AC = reviver scripts\cp_mp\killstreaks\killstreakdeploy::switchtodeployweapon(weaponobj, streakinfo, ::teammatereviveweaponwaitputaway, undefined, ::onteammatereviveweaponswitchcomplete, undefined, ::onteammatereviveweapontaken, 0);
    waitframe();
  }

  reviver.blockreviveanimation = 1;
  reviver.waitingtoplayreviveanimation = 0;
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

  while(isDefined(self.currentweapon) && isDefined(self.currentweapon.basename) && self.currentweapon.basename == "teammate_revive_stim_mp")
    waitframe();

  waitframe();
  reviver.blockreviveanimation = 0;
}

teammatereviveweaponwaitputaway(streakinfo) {
  reviver = self;
  level endon("game_ended");

  if(!istrue(reviver.revivingteammate)) {
    return;
  }
  reviver scripts\engine\utility::waittill_any_return_no_endon_death_2("death_or_disconnect", "finish_buddy_reviving");
}

watchfordeathwhilereviving() {
  reviver = self;
  reviver endon("finish_buddy_reviving");
  reviver endon("disconnect");
  level endon("game_ended");
  reviver waittill("death");
  reviver enableweaponswitch();
}

watchforteammatedeathwhilereviving(_id_22F7E3F7E360775B) {
  reviver = self;
  reviver endon("finish_buddy_reviving");
  reviver endon("death_or_disconnect");
  level endon("game_ended");
  _id_22F7E3F7E360775B waittill("death_or_disconnect");
  reviver notify("finish_buddy_reviving");
}

watchforteammaterevivedwhilereviving(_id_22F7E3F7E360775B) {
  reviver = self;
  reviver endon("finish_buddy_reviving");
  reviver endon("death_or_disconnect");
  level endon("game_ended");
  _id_22F7E3F7E360775B waittill("last_stand_revived");
  reviver notify("finish_buddy_reviving");
}

finishreviveplayer(_id_70687E0CC558A009, reviver) {
  _id_22F7E3F7E360775B = self;
  _id_22F7E2F7E3607528 = 0;

  if(!isDefined(_id_22F7E3F7E360775B))
    return 0;

  self.fastcrouchspeedmod = 0;

  if(isDefined(level.move_speed_scale))
    self[[level.move_speed_scale]]();

  if(_id_70687E0CC558A009 == "use_hold_revive_success" || _id_70687E0CC558A009 == "self_revive_on_kill_success" || _id_70687E0CC558A009 == "self_revive_success")
    _id_22F7E2F7E3607528 = 1;

  _id_22F7E3F7E360775B.beingrevived = 0;
  _id_22F7E3F7E360775B.isselfreviving = 0;

  if(_id_70687E0CC558A009 == "self_revive_success")
    _id_22F7E3F7E360775B selfrevivingdoneanimevent();

  _id_22F7E3F7E360775B allowmovement(1);

  if(istrue(_id_22F7E2F7E3607528) && isDefined(reviver)) {
    scripts\cp\cp_analytics::logevent_spawnviaplayer(_id_22F7E3F7E360775B, reviver);
    _id_22F7E3F7E360775B scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
    _id_CCBC8F28CB6A19E7 = _id_22F7E3F7E360775B setstance("crouch");

    if(!_id_CCBC8F28CB6A19E7)
      _id_CCBC8F28CB6A19E7 = _id_22F7E3F7E360775B setstance("prone");
  }

  _id_22F7E3F7E360775B takelaststandtransitionweapon();
  _id_22F7E3F7E360775B thread _id_6AE06D3353229425();

  if(isDefined(reviver) && reviver != _id_22F7E3F7E360775B) {
    thread _id_189B67B2735B981D::_id_BD70B31DD13292BC(reviver);
    thread _id_189B67B2735B981D::_id_BD70A21DD1326D59(_id_22F7E3F7E360775B);
  }

  return _id_22F7E2F7E3607528;
}

_id_6AE06D3353229425() {
  wait 1;

  if(!isDefined(self._id_F13B2C408FE7BA46)) {
    return;
  }
  wait 1;

  if(isDefined(self._id_F13B2C408FE7BA46)) {
    slot = "health";

    if(!isDefined(self.equipment[slot]) || _id_7EF95BBA57DC4B82::getequipmentslotammo(slot) == 0)
      _id_7EF95BBA57DC4B82::giveequipment("equip_armorplate", slot);

    _id_07C40FA80892A721::_id_9C6E9A6643B6C9A6(self._id_F13B2C408FE7BA46);
    self._id_F13B2C408FE7BA46 = undefined;
  }
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

useholdthink(reviver, usetime) {
  self.owner endon("last_stand_finished");
  reviver endon("death");
  level endon("game_ended");
  _id_22F7E3F7E360775B = self.owner;
  _id_6A1154C8BC126A40 = getdvarint("dvar_C959AF6F995BF79A");
  _id_93DA003F4F870AF4 = spawn("script_origin", self.origin);
  _id_93DA003F4F870AF4 hide();

  if(!_id_6A1154C8BC126A40)
    reviver _id_3B64EB40368C1450::_id_3633B947164BE4F3("laststand_revive", 0);

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
  else if(reviver scripts\cp\utility::_hasperk("specialty_quick_revive"))
    self.usetime = scripts\mp\utility\dvars::getwatcheddvar("lastStandReviveTimer") * 1000 * 0.5;
  else if(reviver scripts\cp\utility::_hasperk("specialty_medic"))
    self.usetime = scripts\mp\utility\dvars::getwatcheddvar("lastStandReviveTimer") * 1000 * getdvarfloat("perk_medicReviveSpeedRatio");
  else
    self.usetime = scripts\mp\utility\dvars::getwatcheddvar("lastStandReviveTimer") * 1000;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && reviver scripts\cp\utility::_hasperk("specialty_br_faster_revive"))
    self.usetime = self.usetime * 0.75;

  if(isDefined(level._id_9023ACDD4F7E61F4))
    level thread[[level._id_9023ACDD4F7E61F4]](reviver);
  else
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(reviver, "stat_572347275DFB41AB");

  thread useholdthinkcleanup(reviver, _id_93DA003F4F870AF4);
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

useholdthinkcleanup(reviver, _id_93DA003F4F870AF4) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  _id_6A1154C8BC126A40 = getdvarint("dvar_C959AF6F995BF79A");
  _id_22F7E3F7E360775B = self.owner;
  _id_4930CBCE302555B1 = _id_22F7E3F7E360775B scripts\engine\utility::waittill_any_return_no_endon_death_4("death_or_disconnect", "use_hold_think_success", "use_hold_think_fail", "last_stand_finished");
  self.inuse = 0;
  _id_93DA003F4F870AF4 delete();
  reviver buddyrevivingdoneanimevent();
  reviver setlaststandreviving(0);
  reviver.revivingteammate = 0;

  if(isDefined(reviver))
    reviver scripts\cp\utility::updateuiprogress(self, 0);

  if(isDefined(_id_22F7E3F7E360775B))
    _id_22F7E3F7E360775B scripts\cp\utility::updateuiprogress(self, 0);

  if(scripts\cp_mp\utility\player_utility::isreallyalive(reviver)) {
    if(_id_6A1154C8BC126A40)
      cleanupdragallyprototype(reviver, _id_22F7E3F7E360775B);
    else
      reviver _id_3B64EB40368C1450::_id_3633B947164BE4F3("laststand_revive", 1);
  }

  reviver notify("sfx_revive_done");

  if(_id_4930CBCE302555B1 == "use_hold_think_success") {
    if(isPlayer(reviver)) {
      if(!istrue(reviver.can_give_revive_xp))
        reviver thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_AB2FA142759B4C26", undefined, undefined, -1);
      else {
        reviver thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_AB2FA142759B4C26");
        reviver.can_give_revive_xp = 0;
      }
    }

    if(istrue(level.allowselfrevive))
      reviver allowselfrevive(1);

    _id_22F7E3F7E360775B thread _id_187A04151C40FB72::scoreeventpopup("stat_AB2FB342759B6ABC");
    _id_22F7E3F7E360775B thread scripts\cp\cp_hud_message::showsplash("revived", undefined, reviver);
    _id_22F7E3F7E360775B.inlaststand = 0;
    reviver _id_3BCAA2CBAF54ABDD::eog_player_update_stat("revives", 1);
    self notify("use_hold_revive_success");
    return;
  } else if(_id_4930CBCE302555B1 == "use_hold_think_fail")
    _id_22F7E3F7E360775B notify("handle_revive_message");

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
  _id_0E2C5C56BB79DE4B = getdvarint("dvar_A23E8F787D85F762", 0);
  mintime = getdvarint("dvar_15E9B25B07A2BBB6", 0.5) * 1000 + gettime();

  while(scripts\cp_mp\utility\player_utility::isreallyalive(reviver) && self.curprogress < self.usetime && (!isDefined(reviver.inlaststand) || !reviver.inlaststand) && (reviver useButtonPressed() || istrue(_id_0E2C5C56BB79DE4B) || gettime() < mintime) && distancesquared(reviver.origin, self.origin) <= 65536) {
    if(istrue(reviver.tacopsmedicrole))
      return scripts\cp_mp\utility\player_utility::isreallyalive(reviver);

    if(isDefined(reviver.carryobject)) {
      reviver notify("drop_called");
      reviver.carryobject thread _id_6B18C507926DD700::setdropped();
    }

    self.curprogress = self.curprogress + level.frameduration * self.userate;
    self.userate = 1;
    reviver scripts\cp\utility::updateuiprogress(self, 1);

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

  for(;;) {
    waitframe();

    if(self stancebuttonPressed() && self isinexecutionvictim() == 0) {
      holdtime = holdtime + level.framedurationseconds;

      if(holdtime >= 0.5) {
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
  _id_4CE97D438A53F1D5 = 500.0;
  _id_9A87080FB741DE0C = 0;

  while(!_id_9A87080FB741DE0C && !_id_95E94C34040BC5AD) {
    _id_95E94C34040BC5AD = 0;

    if(!_id_51BEE2F5B3B4E278)
      holdtime = gettime();

    _id_CBA40E031462D0A0 = scripts\engine\utility::waittill_any_timeout_5(0.5, "stance_pressed_down", "stance_pressed_up", "last_stand_finished", "last_stand_self_revive", "last_stand_bleedout");

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

    if(istrue(getbeingrevivedinternal()))
      scripts\mp\utility\lower_message::setlowermessageomnvar("being_revived");
    else if(istrue(self.laststandhealisactive))
      scripts\mp\utility\lower_message::setlowermessageomnvar("reviving_self");
    else if(isDefined(self.timeuntilbleedout)) {
      if(_id_649E600E12376E07)
        scripts\mp\utility\lower_message::setlowermessageomnvar("self_revive", int(gettime() + self.timeuntilbleedout * 1000));
      else if(scripts\cp\utility::getgametype() != "dm")
        scripts\mp\utility\lower_message::setlowermessageomnvar("revive_or_respawn", int(gettime() + self.timeuntilbleedout * 1000));
      else
        scripts\mp\utility\lower_message::setlowermessageomnvar("ffa_down_give_up", int(gettime() + self.timeuntilbleedout * 1000));
    } else if(_id_649E600E12376E07)
      scripts\mp\utility\lower_message::setlowermessageomnvar("self_revive");
    else
      scripts\mp\utility\lower_message::setlowermessageomnvar("revive_or_respawn");

    for(;;)
      _id_4930CBCE302555B1 = scripts\engine\utility::waittill_any_return_no_endon_death_2("super_ready", "handle_revive_message");
  }
}

bleedoutthink(damage_data) {
  self endon("death_or_disconnect");
  self endon("last_stand_finished");
  self endon("last_stand_heal_active");
  level endon("game_ended");
  _id_8DD9F2EB8215A139 = self.timeuntilbleedout;
  self setclientomnvar("zm_ui_laststand_end_milliseconds", int(_id_8DD9F2EB8215A139 * 1000));
  _id_1DAB4A6BAD01C509 = self getentitynumber();
  _id_3BCAA2CBAF54ABDD::setcoopplayerdata_for_everyone("EoGPlayer", _id_1DAB4A6BAD01C509, "laststand_time_ms", int(_id_8DD9F2EB8215A139 * 1000));

  if(_id_8DD9F2EB8215A139 != 0) {
    for(;;) {
      waitframe();

      if(self isinexecutionvictim()) {
        continue;
      }
      if(!istrue(getbeingrevivedinternal()))
        _id_8DD9F2EB8215A139 = _id_8DD9F2EB8215A139 - level.framedurationseconds;

      if(_id_8DD9F2EB8215A139 <= level.framedurationseconds) {
        self notify("last_stand_bleedout");
        self.shouldskipdeathsshield = 1;
        self dodamage(self.maxhealth, self.origin);
        break;
      }

      _id_CB3D82B3072EFB83(_id_8DD9F2EB8215A139);
      self.timeuntilbleedout = _id_8DD9F2EB8215A139;
      self setclientomnvar("zm_ui_laststand_end_milliseconds", int(_id_8DD9F2EB8215A139 * 1000));
      _id_3BCAA2CBAF54ABDD::setcoopplayerdata_for_everyone("EoGPlayer", _id_1DAB4A6BAD01C509, "laststand_time_ms", int(_id_8DD9F2EB8215A139 * 1000));
    }
  }
}

_id_CB3D82B3072EFB83(time) {
  if(level.players.size == 1) {
    return;
  }
  if(isDefined(self._id_65E752C434236081)) {
    return;
  }
  if(level.laststandtimer > 20 && int(time) == 15) {
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "stat_1C1A3EBE5F3A23AF");
    thread _id_345DBE24850A1F6C();
    return;
  }

  if(level.laststandtimer > 15 && int(time) == 10) {
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "stat_1C1A3EBE5F3A23AF");
    thread _id_345DBE24850A1F6C();
    return;
  }

  if(level.laststandtimer > 10 && int(time) == 5) {
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "stat_1C1A3EBE5F3A23AF");
    thread _id_345DBE24850A1F6C();
    return;
  }
}

_id_345DBE24850A1F6C() {
  level endon("game_ended");
  self endon("disconnect");
  self._id_65E752C434236081 = gettime();
  wait 3;
  self._id_65E752C434236081 = undefined;
}

addoverheadicon() {
  if(getdvarint("dvar_155DCC14C52DACF8", 1)) {
    return;
  }
  _id_1453F424673CF292 = self.origin;
  icon = newteamhudelem(self.team);
  icon.x = _id_1453F424673CF292[0];
  icon.y = _id_1453F424673CF292[1];
  icon.z = _id_1453F424673CF292[2] + 32;
  icon.alpha = 1.0;
  icon.archived = 0;

  if(level.splitscreen)
    icon setshader("hud_realism_head_revive", 10, 10);
  else
    icon setshader("hud_realism_head_revive", 5, 5);

  icon setwaypoint(1, 1);
  icon settargetEnt(self);
  thread cleanupoverheadicon(icon);
}

cleanupoverheadicon(icon) {
  scripts\engine\utility::waittill_any_3("disconnect", "last_stand_finished", "spawned");
  icon destroy();
}

showwaverespawnmessage() {
  _id_3E1DEAE4CD178CFB = getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\cp\utility::getgametype(), "_waverespawndelay")) > 0;

  if(!_id_3E1DEAE4CD178CFB) {
    return;
  }
  self endon("last_stand_finished");

  for(;;) {
    self.respawntimerstarttime = gettime();
    _id_3E1DEAE4CD178CFB = getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\cp\utility::getgametype(), "_waverespawndelay")) > 0;

    if(_id_3E1DEAE4CD178CFB) {}

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
    waitframe();
    level thread laststandkillteamifdown();
  }
}

laststandkillteamifdown() {
  foreach(_id_F90358454413407F in level.teamnamelist) {
    _id_E2B2BBD9E6539F11 = _id_554B8EE714D13AFB::getfriendlyplayers(_id_F90358454413407F, 1);
    _id_2D2ABB649737B34E = [];

    foreach(player in _id_E2B2BBD9E6539F11) {
      if(istrue(player.inlaststand))
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

_id_1B7EBC11CD2BC4A8() {
  _id_AD1D6202B804074E = level._id_AD1D6202B804074E;
  _id_5A1B682666C7B2A5();
  self endon("disconnect");
  self endon("clear_last_stand_revived_invuln");
  scripts\cp_mp\utility\damage_utility::adddamagemodifier("last_stand_revived_invuln", 0, 0, ::laststandinvulnignorefunc);
  scripts\engine\utility::waittill_notify_or_timeout("death", _id_AD1D6202B804074E);
  thread _id_5A1B682666C7B2A5();
}

_id_5A1B682666C7B2A5() {
  self notify("clear_last_stand_revived_invuln");
  scripts\cp_mp\utility\damage_utility::removedamagemodifier("last_stand_revived_invuln", 0);
}

laststandinvulnignorefunc(inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc) {
  if(meansofdeath == "MOD_TRIGGER_HURT")
    return 1;

  return 0;
}

getdefaultlaststandtimervalue() {
  return 30;
}

getdefaultlaststandrevivetimervalue() {
  return 5;
}

getshellshockinterruptdelayms(duration) {
  return duration * 1000;
}

player_in_laststand(player) {
  return istrue(player.inlaststand);
}

isinlaststand(player) {
  return istrue(player.inlaststand);
}

_id_03EBB302E8386186() {
  if(getdvarint("dvar_820D173460041962", 1))
    return 0;

  return isusingmatchrulesdata();
}

callback_playerlaststand(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration) {
  damage_data = scripts\cp_mp\utility\damage_utility::packdamagedata(attacker, self, idamage, objweapon, smeansofdeath, einflictor, self.origin, vdir, undefined, undefined, undefined, undefined, undefined);
  _id_6D8F177C77496430 = isforcedlaststand(self, einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc);
  self notify("stop_player_combat_state_thread");

  if(!istrue(_id_6D8F177C77496430)) {
    if(isDefined(level.modelaststandallowed) && !self[[level.modelaststandallowed]](einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration))
      return 0;

    if(isDefined(level._id_7B098327E305F16D) && ![[level._id_7B098327E305F16D]](self, damage_data))
      return 0;

    if(!istrue(level._id_00A42B25FFADA980))
      return 0;
  }

  if(isDefined(level.parachuteprelaststandfunc))
    self[[level.parachuteprelaststandfunc]]();

  if(self isskydiving())
    self skydive_interrupt();

  lifeid = self.matchdatalifeindex;

  if(!isDefined(lifeid))
    lifeid = level.maxlives - 1;

  if(isDefined(attacker) && attacker.classname != "worldspawn") {
    if(!isPlayer(attacker)) {
      if(isDefined(attacker.owner) && isPlayer(attacker.owner))
        attacker = attacker.owner;
      else if(isDefined(einflictor) && isDefined(einflictor.owner) && isPlayer(einflictor.owner))
        attacker = einflictor.owner;
    }

    _id_642470E1ABC1BBF9 = playerkilled_initdeathdata(einflictor, attacker, self, idamage, 0, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, 0);
    playerkilled_parameterfixup(_id_642470E1ABC1BBF9);
    playerkilled_precalc(_id_642470E1ABC1BBF9);
    _id_642470E1ABC1BBF9.laststandkill = 1;
    self.playergoingintols = 1;

    if(isPlayer(attacker) && attacker != self) {
      self.laststandattacker = attacker;
      self.laststandmeansofdeath = _id_642470E1ABC1BBF9.meansofdeath;
      self.laststandweaponobj = objweapon;
      self.laststandattackermodifiers = attacker.modifiers;
    }

    _id_642470E1ABC1BBF9.isfriendlyfire = _id_25845ACA699D038D::isfriendlyfire(self, attacker);

    if(getdvarint("dvar_98F5C716D594181B", 1))
      self.laststanddowneddata = _id_642470E1ABC1BBF9;
  }

  _id_3B64EB40368C1450::set("on_revive_disables", "vehicle_use", 0);
  _id_3B64EB40368C1450::set("on_revive_disables", "crate_use", 0);
  _id_3B64EB40368C1450::set("on_revive_disables", "ascender_use", 0);

  if(isDefined(level.checkforlaststandwipe)) {
    if([[level.checkforlaststandwipe]](self))
      return 0;
  }

  if(isDefined(self.carryobject)) {
    self notify("drop_called");
    self.carryobject thread _id_6B18C507926DD700::setdropped();
  }

  if(isPlayer(self))
    _id_189B67B2735B981D::_id_55B08D6D71B41402(self, "player_knocked_down");

  if(isPlayer(attacker) && attacker != self)
    _id_189B67B2735B981D::_id_55B08D6D71B41402(attacker, "knocked_down_enemy");

  thread laststandthink(damage_data);
  return 1;
}

isforcedlaststand(victim, einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc) {
  _id_6D8F177C77496430 = 0;

  if(istrue(self.killstreaklaststand) && isDefined(level.killstreak_laststand_func))
    _id_6D8F177C77496430 = 1;

  return _id_6D8F177C77496430;
}

playerkilled_initdeathdata(inflictor, attacker, victim, damage, damageflags, meansofdeath, objweapon, direction_vec, hitloc, psoffsettime, deathanimduration, isfauxdeath) {
  _id_642470E1ABC1BBF9 = scripts\cp_mp\utility\damage_utility::packdamagedata(attacker, victim, damage, objweapon, meansofdeath, inflictor, undefined, direction_vec, undefined, undefined, undefined, damageflags);
  _id_642470E1ABC1BBF9.hitloc = hitloc;
  _id_642470E1ABC1BBF9.psoffsettime = psoffsettime;
  _id_642470E1ABC1BBF9.deathanimduration = deathanimduration;
  _id_642470E1ABC1BBF9.isfauxdeath = isfauxdeath;

  if(meansofdeath == "MOD_EXECUTION")
    _id_642470E1ABC1BBF9.executionref = scripts\cp_mp\execution::execution_getrefbyplayer(attacker);

  _id_642470E1ABC1BBF9.dokillcam = 0;
  _id_642470E1ABC1BBF9.dofinalkillcam = 1;
  _id_642470E1ABC1BBF9.killcamentity = undefined;
  _id_642470E1ABC1BBF9.killcamentityindex = -1;
  _id_642470E1ABC1BBF9.killcamentitystarttime = 0;
  _id_642470E1ABC1BBF9.inflictoragentinfo = undefined;
  _id_642470E1ABC1BBF9.killcamentstickstovictim = undefined;
  _id_642470E1ABC1BBF9.isfriendlyfire = undefined;
  _id_642470E1ABC1BBF9.primaryweapon = undefined;
  _id_642470E1ABC1BBF9.lifeid = undefined;
  _id_642470E1ABC1BBF9.attackerentnum = undefined;
  _id_642470E1ABC1BBF9.iskillstreakweapon = undefined;
  _id_642470E1ABC1BBF9.weaponfullstring = undefined;
  _id_642470E1ABC1BBF9.isnukekill = 0;
  _id_642470E1ABC1BBF9.deathscenetimesec = getdvarfloat("scr_death_scene_time", 1.75);
  _id_642470E1ABC1BBF9.deathscenetimems = int(_id_642470E1ABC1BBF9.deathscenetimesec * 1000);
  _id_642470E1ABC1BBF9.deathtime = gettime();
  _id_642470E1ABC1BBF9.brvictiminlaststand = undefined;
  return _id_642470E1ABC1BBF9;
}

playerkilled_parameterfixup(_id_642470E1ABC1BBF9) {
  if(isDefined(_id_642470E1ABC1BBF9.inflictor) && istrue(_id_642470E1ABC1BBF9.inflictor._id_26FB072855FD4772)) {
    _id_642470E1ABC1BBF9.meansofdeath = "MOD_CRUSH";
    _id_642470E1ABC1BBF9.attacker = _id_642470E1ABC1BBF9.inflictor;
    _id_642470E1ABC1BBF9.attacker.team = scripts\cp\utility::getotherteam(_id_642470E1ABC1BBF9.victim.team)[0];
  }

  if(_id_642470E1ABC1BBF9.victim == _id_642470E1ABC1BBF9.attacker && _id_642470E1ABC1BBF9.meansofdeath == "MOD_CRUSH")
    _id_642470E1ABC1BBF9.meansofdeath = "MOD_SUICIDE";

  if(_id_642470E1ABC1BBF9.objweapon.basename == "none") {
    if(isDefined(_id_642470E1ABC1BBF9.inflictor) && isDefined(_id_642470E1ABC1BBF9.inflictor.baseweapon))
      _id_642470E1ABC1BBF9.objweapon.basename = _id_642470E1ABC1BBF9.inflictor.baseweapon;
  }

  _id_642470E1ABC1BBF9.victim playerkilled_fixupattacker(_id_642470E1ABC1BBF9);

  if(scripts\cp\utility::isheadshot(_id_642470E1ABC1BBF9.hitloc, _id_642470E1ABC1BBF9.meansofdeath, _id_642470E1ABC1BBF9.attacker))
    _id_642470E1ABC1BBF9.meansofdeath = "MOD_HEAD_SHOT";

  if(_id_642470E1ABC1BBF9.isfauxdeath) {
    _id_642470E1ABC1BBF9.dokillcam = 0;
    _id_642470E1ABC1BBF9.deathanimduration = _id_642470E1ABC1BBF9.victim playerforcedeathanim(_id_642470E1ABC1BBF9.inflictor, _id_642470E1ABC1BBF9.meansofdeath, _id_642470E1ABC1BBF9.objweapon, _id_642470E1ABC1BBF9.hitloc, _id_642470E1ABC1BBF9.direction_vec);
  }
}

playerkilled_precalc(_id_642470E1ABC1BBF9) {
  attacker = _id_642470E1ABC1BBF9.attacker;
  victim = _id_642470E1ABC1BBF9.victim;
  inflictor = _id_642470E1ABC1BBF9.inflictor;
  objweapon = _id_642470E1ABC1BBF9.objweapon;
  victim.perkoutlined = 0;
  victim.deathspectatepos = undefined;
  victim.deathtime = _id_642470E1ABC1BBF9.deathtime;
  victim.attacker = attacker;
  victim.lastdeathpos = victim.origin;
  victim.lastdeathangles = victim getplayerangles();

  if(!isPlayer(inflictor) && isDefined(inflictor.primaryweapon))
    _id_642470E1ABC1BBF9.primaryweapon = inflictor.primaryweapon;
  else if(isDefined(attacker) && isPlayer(attacker) && !isnullweapon(attacker getcurrentprimaryweapon()))
    _id_642470E1ABC1BBF9.primaryweapon = getcompleteweaponname(attacker getcurrentprimaryweapon());
  else if(objweapon.isalternate)
    _id_642470E1ABC1BBF9.primaryweapon = objweapon.basename;
  else
    _id_642470E1ABC1BBF9.primaryweapon = undefined;

  _id_642470E1ABC1BBF9.lifeid = victim.matchdatalifeindex;

  if(!isDefined(_id_642470E1ABC1BBF9.lifeid))
    _id_642470E1ABC1BBF9.lifeid = level.maxlives - 1;

  if(scripts\cp_mp\utility\game_utility::isgameparticipant(attacker))
    _id_642470E1ABC1BBF9.attackerentnum = attacker getentitynumber();
  else
    _id_642470E1ABC1BBF9.attackerentnum = -1;

  _id_642470E1ABC1BBF9.iskillstreakweapon = _id_2669878CF5A1B6BC::iskillstreakweapon(objweapon.basename);
  _id_642470E1ABC1BBF9.weaponfullstring = getcompleteweaponname(objweapon);
  _id_642470E1ABC1BBF9.isfriendlyfire = _id_25845ACA699D038D::isfriendlyfire(victim, attacker);
  _id_642470E1ABC1BBF9.isnukekill = objweapon.basename == "nuke_mp";

  if(isDefined(level._id_C121AA6DC74CCE91))
    _id_642470E1ABC1BBF9 = [[level._id_C121AA6DC74CCE91]](_id_642470E1ABC1BBF9);

  _id_642470E1ABC1BBF9.brvictiminlaststand = isinlaststand(victim);
}

playerkilled_fixupattacker(_id_642470E1ABC1BBF9) {
  _id_642470E1ABC1BBF9.attacker = _validateattacker(_id_642470E1ABC1BBF9.attacker);

  if(isDefined(_id_642470E1ABC1BBF9.inflictor) && istrue(_id_642470E1ABC1BBF9.inflictor._id_26FB072855FD4772)) {
    if(isDefined(level._id_B6E3760A75368EFC))
      _id_642470E1ABC1BBF9.attacker = [[level._id_B6E3760A75368EFC]](_id_642470E1ABC1BBF9.inflictor, _id_642470E1ABC1BBF9.victim);
  }

  assistedsuicide = 0;

  if(!isDefined(_id_642470E1ABC1BBF9.attacker))
    assistedsuicide = 1;
  else if(isDefined(_id_642470E1ABC1BBF9.attacker.classname) && (_id_642470E1ABC1BBF9.attacker.classname == "trigger_hurt" || _id_642470E1ABC1BBF9.attacker.classname == "worldspawn"))
    assistedsuicide = 1;
  else if(_id_642470E1ABC1BBF9.attacker == _id_642470E1ABC1BBF9.victim)
    assistedsuicide = 1;

  if(assistedsuicide) {
    bestplayer = undefined;

    if(isDefined(bestplayer)) {
      _id_642470E1ABC1BBF9.attacker = bestplayer;
      _id_642470E1ABC1BBF9.attacker.assistedsuicide = 1;
      _id_642470E1ABC1BBF9.objweapon = _id_642470E1ABC1BBF9.victim.attackerdata[bestplayer.guid].objweapon;
      _id_642470E1ABC1BBF9.direction_vec = _id_642470E1ABC1BBF9.victim.attackerdata[bestplayer.guid].vdir;
      _id_642470E1ABC1BBF9.hitloc = _id_642470E1ABC1BBF9.victim.attackerdata[bestplayer.guid].shitloc;
      _id_642470E1ABC1BBF9.psoffsettime = _id_642470E1ABC1BBF9.victim.attackerdata[bestplayer.guid].psoffsettime;
      _id_642470E1ABC1BBF9.meansofdeath = _id_642470E1ABC1BBF9.victim.attackerdata[bestplayer.guid].smeansofdeath;
      _id_642470E1ABC1BBF9.damage = _id_642470E1ABC1BBF9.victim.attackerdata[bestplayer.guid].damage;
      _id_642470E1ABC1BBF9.primaryweapon = _id_642470E1ABC1BBF9.victim.attackerdata[bestplayer.guid].sprimaryweapon;

      if(istrue(_id_642470E1ABC1BBF9.victim.squadwiped) && isDefined(_id_642470E1ABC1BBF9.victim.attackerdata[bestplayer.guid].inflictor))
        _id_642470E1ABC1BBF9.inflictor = _id_642470E1ABC1BBF9.victim.attackerdata[bestplayer.guid].inflictor;

      _id_642470E1ABC1BBF9.assistedsuicide = 1;
    }
  }

  if(isDefined(_id_642470E1ABC1BBF9.attacker)) {
    if(_id_642470E1ABC1BBF9.attacker.code_classname == "script_vehicle" && isDefined(_id_642470E1ABC1BBF9.attacker.owner))
      _id_642470E1ABC1BBF9.attacker = _id_642470E1ABC1BBF9.attacker.owner;

    if(_id_642470E1ABC1BBF9.attacker.code_classname == "misc_turret" && isDefined(_id_642470E1ABC1BBF9.attacker.owner)) {
      if(isDefined(_id_642470E1ABC1BBF9.attacker.vehicle))
        _id_642470E1ABC1BBF9.attacker.vehicle notify("killedPlayer", _id_642470E1ABC1BBF9.victim);

      _id_642470E1ABC1BBF9.attacker = _id_642470E1ABC1BBF9.attacker.owner;
    }

    if(isagent(_id_642470E1ABC1BBF9.attacker)) {
      if(isDefined(_id_642470E1ABC1BBF9.attacker.owner))
        _id_642470E1ABC1BBF9.attacker = _id_642470E1ABC1BBF9.attacker.owner;
    }

    if(_id_642470E1ABC1BBF9.attacker.code_classname == "script_model" && isDefined(_id_642470E1ABC1BBF9.attacker.owner)) {
      _id_642470E1ABC1BBF9.attacker = _id_642470E1ABC1BBF9.attacker.owner;

      if(!_id_25845ACA699D038D::isfriendlyfire(_id_642470E1ABC1BBF9.victim, _id_642470E1ABC1BBF9.attacker) && _id_642470E1ABC1BBF9.attacker != _id_642470E1ABC1BBF9.victim)
        _id_642470E1ABC1BBF9.attacker notify("crushed_enemy");
    }
  }

  if(isDefined(_id_642470E1ABC1BBF9.inflictor) && !isPlayer(_id_642470E1ABC1BBF9.inflictor)) {
    if(!isDefined(_id_642470E1ABC1BBF9.attacker)) {
      if(isDefined(_id_642470E1ABC1BBF9.inflictor.owner))
        _id_642470E1ABC1BBF9.attacker = _id_642470E1ABC1BBF9.inflictor.owner;
    } else if(!isPlayer(_id_642470E1ABC1BBF9.attacker)) {
      if(isDefined(_id_642470E1ABC1BBF9.inflictor.owner))
        _id_642470E1ABC1BBF9.attacker = _id_642470E1ABC1BBF9.inflictor.owner;
    }
  }

  if(isDefined(_id_642470E1ABC1BBF9.attacker) && _id_642470E1ABC1BBF9.attacker != _id_642470E1ABC1BBF9.victim) {
    if(isDefined(_id_642470E1ABC1BBF9.inflictor) && _id_642470E1ABC1BBF9.inflictor == _id_642470E1ABC1BBF9.victim)
      _id_642470E1ABC1BBF9.inflictor = _id_642470E1ABC1BBF9.attacker;
  }

  _id_642470E1ABC1BBF9.attacker.assistedsuicide = 0;
}

_validateattacker(eattacker) {
  if(isagent(eattacker) && (!isDefined(eattacker.isactive) || !eattacker.isactive))
    return undefined;

  if(isagent(eattacker) && !isDefined(eattacker.classname))
    return undefined;

  return eattacker;
}

_id_18C42AF5777DCD9F(_id_642470E1ABC1BBF9) {
  _id_642470E1ABC1BBF9._id_28CD1E201ECD8281 = [];
  _id_642470E1ABC1BBF9._id_28CD1E201ECD8281["attacker"] = _id_642470E1ABC1BBF9.attacker;
  _id_642470E1ABC1BBF9._id_28CD1E201ECD8281["victim"] = _id_642470E1ABC1BBF9.victim;
  _id_642470E1ABC1BBF9._id_28CD1E201ECD8281["damage"] = _id_642470E1ABC1BBF9.damage;
  _id_642470E1ABC1BBF9._id_28CD1E201ECD8281["objWeapon"] = _id_642470E1ABC1BBF9.objweapon;
  _id_642470E1ABC1BBF9._id_28CD1E201ECD8281["meansOfDeath"] = _id_642470E1ABC1BBF9.meansofdeath;
  _id_642470E1ABC1BBF9._id_28CD1E201ECD8281["inflictor"] = _id_642470E1ABC1BBF9.inflictor;
  _id_642470E1ABC1BBF9._id_28CD1E201ECD8281["direction_vec"] = _id_642470E1ABC1BBF9.direction_vec;
  _id_642470E1ABC1BBF9._id_28CD1E201ECD8281["damageFlags"] = _id_642470E1ABC1BBF9.damageflags;
  _id_642470E1ABC1BBF9._id_28CD1E201ECD8281["hitLoc"] = _id_642470E1ABC1BBF9.hitloc;
  _id_642470E1ABC1BBF9._id_28CD1E201ECD8281["psOffsetTime"] = _id_642470E1ABC1BBF9.psoffsettime;
  _id_642470E1ABC1BBF9._id_28CD1E201ECD8281["deathAnimDuration"] = _id_642470E1ABC1BBF9.deathanimduration;
  _id_642470E1ABC1BBF9._id_28CD1E201ECD8281["isFauxDeath"] = _id_642470E1ABC1BBF9.isfauxdeath;
}

_id_F9249BB06EB48092(_id_642470E1ABC1BBF9) {}

_id_AF3EBB9D1ECD18E7(_id_642470E1ABC1BBF9) {}

_id_C11E262E2E29094F(_id_E3108E412AFB3811) {
  if(!isDefined(_id_E3108E412AFB3811))
    _id_E3108E412AFB3811 = 1;

  level._id_00A42B25FFADA980 = _id_E3108E412AFB3811;
}

_id_37DB281EB241645D(_id_E3108E412AFB3811) {
  level._id_2DCE4D6DCB6C3FB9 = _id_E3108E412AFB3811;
}

_id_2F75743C7FE59CFC(_id_642470E1ABC1BBF9) {
  player = _id_642470E1ABC1BBF9.victim;
  _id_E0CBA2B0A5510D09 = level.player_respawn[player.respawn_index];
  player.forcespawnorigin = scripts\engine\utility::drop_to_ground(_id_E0CBA2B0A5510D09.origin, 32, -100);
  player.forcespawnangles = (0, _id_E0CBA2B0A5510D09.angles[1], 0);
  return _id_642470E1ABC1BBF9;
}

hide_all_revive_icons(player) {
  foreach(_id_7BBE82017EFE5C94 in player.revive_icons)
  _id_7BBE82017EFE5C94.alpha = 0;
}

instant_revive(player) {
  if(1)
    return;
}

gethealthcap() {
  if(isDefined(level.get_player_health_after_revived_func))
    return [[level.get_player_health_after_revived_func]](self);

  return int(self.maxhealth);
}

clear_last_stand_timer(player) {
  if(isDefined(player)) {
    _id_1DAB4A6BAD01C509 = player getentitynumber();
    player setclientomnvar("zm_ui_laststand_end_milliseconds", 0);
    player setclientomnvar("zm_hint_index", 0);
    player setclientomnvar("zm_hint_progress", 0);
    _id_3BCAA2CBAF54ABDD::setcoopplayerdata_for_everyone("EoGPlayer", _id_1DAB4A6BAD01C509, "laststand_time_ms", 0);
  }
}

get_normal_revive_time() {
  if(isDefined(level.normal_revive_time))
    return level.normal_revive_time;
  else
    return 5000;
}

give_fists_if_no_real_weapon(player) {
  if(has_no_real_weapon(player)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon("iw9_me_fists_mp");
    self switchtoweaponimmediate("iw9_me_fists_mp");
    self setspawnweapon("iw9_me_fists_mp", 1);
  }
}

has_no_real_weapon(player) {
  _id_2622298F62890966 = player getweaponslistall();

  foreach(weapon in _id_2622298F62890966) {
    _id_92FCE7B1696254E3 = weapon.basename;

    if(_id_92FCE7B1696254E3 == "none") {
      continue;
    }
    if(_id_92FCE7B1696254E3 == "iw9_ziptie_mp") {
      continue;
    }
    if(_id_92FCE7B1696254E3 == "iw9_me_climbfists_mp") {
      continue;
    }
    if(_id_92FCE7B1696254E3 == "super_default_zm") {
      continue;
    }
    if(issubstr(_id_92FCE7B1696254E3, "knife")) {
      continue;
    }
    if(_id_92FCE7B1696254E3 == "iw9_me_fists_mp") {
      continue;
    }
    return 0;
  }

  return 1;
}

default_player_init_laststand() {
  init_revive_icon_list();
}

init_revive_icon_list() {
  self.revive_icons = [];
}

_id_ABB98974074387B1(player) {
  gameshouldend = _id_5DE995015A65E87D();

  if(gameshouldend && isDefined(level.endgame) && isDefined(level.end_game_string_index)) {
    player_vehicle = scripts\cp_mp\utility\player_utility::getvehicle();

    if(isDefined(player_vehicle)) {
      seatid = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(player_vehicle, self);
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(player_vehicle, seatid, self, undefined, 1);
    }

    level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
  }
}

_id_5DE995015A65E87D(_id_47E569777F8BB300, _id_DC713579246E29D6) {
  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
    if(_id_10A17AA507F07BD8()) {
      if(_id_9D24182B90507AA9()) {
        if(everyone_else_all_in_laststand(_id_47E569777F8BB300))
          return 1;
      }
    }
  }

  if(istrue(level.enable_manual_revive) || getdvarint("dvar_C88F515E7C55AF60"))
    return 0;

  if(isDefined(_id_47E569777F8BB300) && _id_47E569777F8BB300 hasselfrevivetoken(_id_DC713579246E29D6))
    return 0;

  if(_id_3A7452328B016D0C() && (isDefined(_id_47E569777F8BB300) && _id_47E569777F8BB300 scripts\cp\utility::has_auto_revive()))
    return 0;

  if(_id_3A7452328B016D0C()) {
    if(isDefined(_id_47E569777F8BB300))
      return _id_CFB83A27A2B50413(_id_47E569777F8BB300);
    else
      return 1;
  } else
    return _id_022EF061075EA04D(_id_47E569777F8BB300);
}

_id_3A7452328B016D0C() {
  if(getdvarint("dvar_A315DDE34DFAE829", 0) > 0)
    return 0;

  return istrue(scripts\cp\utility::isplayingsolo()) || istrue(level.only_one_player);
}

_id_CFB83A27A2B50413(_id_47E569777F8BB300) {
  if(istrue(_id_47E569777F8BB300._id_4B75C525AF796F66))
    return 0;

  if(isDefined(level._id_313F285051FA8329))
    return [[level._id_313F285051FA8329]](_id_47E569777F8BB300);

  if(player_in_laststand(_id_47E569777F8BB300))
    return 0;

  return _id_47E569777F8BB300 get_last_stand_count() == 0;
}

get_last_stand_count() {
  return self getplayerdata("cp", "alienSession", "last_stand_count");
}

_id_022EF061075EA04D(_id_47E569777F8BB300) {
  if(isDefined(level.coop_gameshouldendfunc))
    return [[level.coop_gameshouldendfunc]](_id_47E569777F8BB300);

  return everyone_else_all_in_laststand(_id_47E569777F8BB300);
}

_id_05ECCC8D9829E62A(_id_47E569777F8BB300) {
  _id_E031661B7146A294 = 0;
  _id_A2EE5E571404BB61 = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    player = level.players[_id_AC0E594AC96AA3A8];

    if(istrue(player._id_6F037E24E1D55A69)) {
      continue;
    }
    _id_E031661B7146A294++;

    if(_id_AECE408C4E393B72(player))
      _id_A2EE5E571404BB61++;
  }

  return _id_A2EE5E571404BB61 >= _id_E031661B7146A294;
}

_id_AECE408C4E393B72(player) {
  if(player isspectatingplayer())
    return 1;

  if(!isalive(player))
    return 1;

  if(isinlaststand(player) && !player hasselfrevivetoken())
    return 1;

  return 0;
}

_id_EF09962096AA8771() {
  self._id_6F037E24E1D55A69 = 1;
}

everyone_else_all_in_laststand(_id_47E569777F8BB300) {
  foreach(player in level.players) {
    if(isDefined(_id_47E569777F8BB300) && player == _id_47E569777F8BB300)
      continue;
    else if(player isspectatingplayer())
      continue;
    else if(istrue(player._id_6F037E24E1D55A69))
      continue;
    else if(istrue(player.isselfreviving))
      return 0;
    else if(player hasselfrevivetoken())
      return 0;
    else if(isalive(player) && !player_in_laststand(player))
      return 0;
    else if(istrue(player.gettingupfromlaststand))
      return 0;
  }

  return 1;
}

_id_6D977E4DA51C55F3(waittime) {
  if(isDefined(waittime))
    wait(waittime);

  if(isDefined(level._id_E4A74151CFC1435B)) {
    objindex = scripts\cp\cp_objectives::requestworldid("respawn_buy_loc");
    objective_state(objindex, "current");
    objective_setshowoncompass(objindex, 1);
    objective_setlabel(objindex, "");
    objective_position(objindex, level._id_E4A74151CFC1435B);
    objective_setshowdistance(objindex, 1);
    objective_setshowprogress(objindex, 0);
    objective_setbackground(objindex, 1);
    objective_setplayintro(objindex, 0);
    level._id_50AC7F8D5B660A9C = objindex;
    level._id_B51ADB1C7AB7788C = 1;
  }
}

_id_D6EBED99DC9008C2() {
  if(isDefined(level._id_50AC7F8D5B660A9C)) {
    objective_state(level._id_50AC7F8D5B660A9C, "done");
    objective_delete(level._id_50AC7F8D5B660A9C);
    level._id_50AC7F8D5B660A9C = undefined;
    level._id_B51ADB1C7AB7788C = undefined;
    scripts\cp\cp_objectives::freeworldid("respawn_buy_loc");
  }
}

record_revive_success(reviver, _id_1730C8D8475566CD) {
  if(isPlayer(reviver)) {
    reviver scripts\cp\cp_merits::processmerit("mt_reviver");
    reviver _id_3BCAA2CBAF54ABDD::increment_player_career_revives(reviver);
    reviver scripts\cp\cp_merits::processmerit("mt_revives");
    reviver _id_3BCAA2CBAF54ABDD::eog_player_update_stat("revives", 1);
    _id_1730C8D8475566CD thread scripts\cp\cp_hud_message::showsplash("cp_revived", undefined, reviver);

    if(isDefined(level.revive_success_analytics_func))
      [[level.revive_success_analytics_func]](reviver);
  }
}

set_revive_icon_color(_id_729984070498B386, color, _id_056F0B746F85293F) {
  if(istrue(_id_729984070498B386.owner.gettingupfromlaststand)) {
    return;
  }
  _id_729984070498B386.current_revive_icon_color = color;

  if(isDefined(_id_729984070498B386.revive_icons))
    _id_729984070498B386.revive_icons = scripts\engine\utility::array_removeundefined(_id_729984070498B386.revive_icons);

  if(istrue(_id_056F0B746F85293F) || isDefined(_id_729984070498B386.owner.reviver) && !istrue(_id_729984070498B386.owner.reviver.isreviving) || !isDefined(_id_729984070498B386.owner.reviver)) {
    if(isDefined(_id_729984070498B386.revive_icons)) {
      foreach(_id_7BBE82017EFE5C94 in _id_729984070498B386.revive_icons)
      _id_7BBE82017EFE5C94.color = color;
    }
  }
}

enter_camera_zoomout(_id_1730C8D8475566CD) {
  _id_1730C8D8475566CD scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
  _id_1730C8D8475566CD scripts\cp\utility::freezecontrolswrapper(1);
}

exit_camera_zoomout() {
  self cameraunlink();
  scripts\cp\utility::freezecontrolswrapper(0);
}

playslamzoomflash() {
  overlay = newclienthudelem(self);
  overlay.x = 0;
  overlay.y = 0;
  overlay.alignx = "left";
  overlay.aligny = "top";
  overlay.sort = 1;
  overlay.horzalign = "fullscreen";
  overlay.vertalign = "fullscreen";
  overlay.alpha = 0;
  overlay.foreground = 1;
  overlay setshader("white", 640, 480);
  overlay fadeovertime(0.05);
  overlay.alpha = 1;
  wait 0.05;
  overlay destroy();
}

enter_bleed_out(_id_1730C8D8475566CD) {
  if(isDefined(level.player_bleed_out_func))
    _id_1730C8D8475566CD[[level.player_bleed_out_func]](_id_1730C8D8475566CD);
  else if(isDefined(level.enterspectatorfunc))
    _id_1730C8D8475566CD[[level.enterspectatorfunc]]();
}

camera_zoomout(_id_1730C8D8475566CD, _id_FB1DEF007972B25A, reviveent) {
  if(isDefined(reviveent))
    reviveent endon("revive_success");

  if(isDefined(level._id_95B8B02E43BCA8DB)) {
    [[level._id_95B8B02E43BCA8DB]](_id_1730C8D8475566CD, _id_FB1DEF007972B25A, reviveent);
    _id_1730C8D8475566CD enter_bleed_out(_id_1730C8D8475566CD);
    return;
  }

  _id_1F2FAF8B25E8824D = (0, 0, 30);
  _id_F6B7B6D8AA0FE05A = (0, 0, -30);
  _id_DB34FC022FA1EF30 = (0, 0, 100);
  _id_CB3021EF49388DF9 = (0, 0, 400);
  _id_F40E87A5DA630C21 = 2.0;
  _id_4E35DA98CCB4BE51 = 0.6;
  _id_90421BE5304F4C34 = 0.6;
  startpos = _id_FB1DEF007972B25A + _id_1F2FAF8B25E8824D;
  trace = scripts\engine\trace::_bullet_trace(startpos, startpos + _id_DB34FC022FA1EF30, 0, _id_1730C8D8475566CD);
  _id_349336C6178CEBEE = trace["position"];
  trace = scripts\engine\trace::_bullet_trace(_id_349336C6178CEBEE, _id_349336C6178CEBEE + _id_CB3021EF49388DF9, 0, _id_1730C8D8475566CD);
  _id_E2EE67418550390B = trace["position"] + _id_F6B7B6D8AA0FE05A;
  mover = spawn("script_model", _id_349336C6178CEBEE);
  mover setModel("tag_origin");
  mover.angles = vectortoangles((0, 0, -1));
  mover thread cleanuplaststandent(_id_1730C8D8475566CD);
  _id_1730C8D8475566CD cameralinkTo(mover, "tag_origin");

  if(!istrue(level._id_CF829458F676A8EF)) {
    mover moveTo(_id_E2EE67418550390B, _id_F40E87A5DA630C21, _id_4E35DA98CCB4BE51, _id_90421BE5304F4C34);
    mover waittill("movedone");
    mover delete();
  } else {
    wait(_id_F40E87A5DA630C21);
    mover delete();
  }

  _id_1730C8D8475566CD enter_bleed_out(_id_1730C8D8475566CD);
}

cleanuplaststandent(owner, _id_A000DB758EC878AF) {
  self endon("death");

  if(istrue(_id_A000DB758EC878AF))
    owner scripts\engine\utility::waittill_any_3("disconnect", "last_stand_revived", "spawned");
  else
    owner scripts\engine\utility::waittill_any_3("death_or_disconnect", "last_stand_revived", "spawned");

  self delete();
}

_id_73707F2512AA6814() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self._id_80F9D0AEAA47CC0C = spawnStruct();
  self._id_80F9D0AEAA47CC0C.origin = self.origin;
  self._id_80F9D0AEAA47CC0C.angles = self.angles;

  for(;;) {
    wait 1;

    if(scripts\cp\cp_outofbounds::isoob(self, 0) || istrue(self isjumping()) || !istrue(self isonground())) {
      continue;
    }
    self._id_80F9D0AEAA47CC0C.origin = self.origin;
    self._id_80F9D0AEAA47CC0C.angles = self.angles;
  }
}

enable_self_revive(player) {
  player setclientomnvar("ui_self_revive", 1);

  if(!isDefined(player.self_revive))
    player.self_revive = 0;

  player.hasselfrevivetoken = 1;
  player.self_revive++;
}

disable_self_revive(player) {
  if(isDefined(player._id_9F4E140E6DCBC55D)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < player._id_9F4E140E6DCBC55D.size; _id_AC0E594AC96AA3A8++) {
      ref = player._id_9F4E140E6DCBC55D[_id_AC0E594AC96AA3A8].carry_ref;
      scripts\cp\utility::_id_98F7CA3781DAC77C(player, ref);
    }
  }

  player.self_revive--;

  if(player.self_revive <= 0) {
    player.has_auto_revive = undefined;
    player.hasselfrevivetoken = 0;
    player setclientomnvar("ui_self_revive", 0);
  }
}

hasselfrevivetoken(_id_FA774E92EC600C15) {
  if(istrue(_id_FA774E92EC600C15))
    return istrue(self.hasselfrevivetoken);
  else
    return isalive(self) && istrue(self.hasselfrevivetoken);
}

#using_animtree("script_model");

init_laststand_anims() {
  if(istrue(level.ls_anims_init)) {
    return;
  }
  level.ls_anims_init = 1;
  level.scr_animtree["ls_revive_helper"] = #animtree;
  level.scr_animtree["ls_revive_wounded"] = #animtree;
  level.scr_anim["ls_revive_helper"]["in_stand_1"] = % sdr_mp_laststand_stand_revive_in_helper_1;
  level.scr_animname["ls_revive_helper"]["in_stand_1"] = "sdr_mp_laststand_stand_revive_in_helper_1";
  level.scr_eventanim["ls_revive_helper"]["in_stand_1"] = "ls_stand_h_in_1";
  level.scr_anim["ls_revive_helper"]["in_stand_2"] = % sdr_mp_laststand_stand_revive_in_helper_2;
  level.scr_animname["ls_revive_helper"]["in_stand_2"] = "sdr_mp_laststand_stand_revive_in_helper_2";
  level.scr_eventanim["ls_revive_helper"]["in_stand_2"] = "ls_stand_h_in_2";
  level.scr_anim["ls_revive_helper"]["in_stand_3"] = % sdr_mp_laststand_stand_revive_in_helper_3;
  level.scr_animname["ls_revive_helper"]["in_stand_3"] = "sdr_mp_laststand_stand_revive_in_helper_3";
  level.scr_eventanim["ls_revive_helper"]["in_stand_3"] = "ls_stand_h_in_3";
  level.scr_anim["ls_revive_helper"]["in_stand_4"] = % sdr_mp_laststand_stand_revive_in_helper_4;
  level.scr_animname["ls_revive_helper"]["in_stand_4"] = "sdr_mp_laststand_stand_revive_in_helper_4";
  level.scr_eventanim["ls_revive_helper"]["in_stand_4"] = "ls_stand_h_in_4";
  level.scr_anim["ls_revive_helper"]["in_stand_6"] = % sdr_mp_laststand_stand_revive_in_helper_6;
  level.scr_animname["ls_revive_helper"]["in_stand_6"] = "sdr_mp_laststand_stand_revive_in_helper_6";
  level.scr_eventanim["ls_revive_helper"]["in_stand_6"] = "ls_stand_h_in_6";
  level.scr_anim["ls_revive_helper"]["in_stand_7"] = % sdr_mp_laststand_stand_revive_in_helper_7;
  level.scr_animname["ls_revive_helper"]["in_stand_7"] = "sdr_mp_laststand_stand_revive_in_helper_7";
  level.scr_eventanim["ls_revive_helper"]["in_stand_7"] = "ls_stand_h_in_7";
  level.scr_anim["ls_revive_helper"]["in_stand_8"] = % sdr_mp_laststand_stand_revive_in_helper_8;
  level.scr_animname["ls_revive_helper"]["in_stand_8"] = "sdr_mp_laststand_stand_revive_in_helper_8";
  level.scr_eventanim["ls_revive_helper"]["in_stand_8"] = "ls_stand_h_in_8";
  level.scr_anim["ls_revive_helper"]["in_stand_9"] = % sdr_mp_laststand_stand_revive_in_helper_9;
  level.scr_animname["ls_revive_helper"]["in_stand_9"] = "sdr_mp_laststand_stand_revive_in_helper_9";
  level.scr_eventanim["ls_revive_helper"]["in_stand_9"] = "ls_stand_h_in_9";
  level.scr_anim["ls_revive_helper"]["idle_stand_1"] = % sdr_mp_laststand_stand_revive_loop_helper_1;
  level.scr_animname["ls_revive_helper"]["idle_stand_1"] = "sdr_mp_laststand_stand_revive_loop_helper_1";
  level.scr_eventanim["ls_revive_helper"]["idle_stand_1"] = "ls_stand_h_lp_1";
  level.scr_anim["ls_revive_helper"]["idle_stand_2"] = % sdr_mp_laststand_stand_revive_loop_helper_2;
  level.scr_animname["ls_revive_helper"]["idle_stand_2"] = "sdr_mp_laststand_stand_revive_loop_helper_2";
  level.scr_eventanim["ls_revive_helper"]["idle_stand_2"] = "ls_stand_h_lp_2";
  level.scr_anim["ls_revive_helper"]["idle_stand_3"] = % sdr_mp_laststand_stand_revive_loop_helper_3;
  level.scr_animname["ls_revive_helper"]["idle_stand_3"] = "sdr_mp_laststand_stand_revive_loop_helper_3";
  level.scr_eventanim["ls_revive_helper"]["idle_stand_3"] = "ls_stand_h_lp_3";
  level.scr_anim["ls_revive_helper"]["idle_stand_4"] = % sdr_mp_laststand_stand_revive_loop_helper_4;
  level.scr_animname["ls_revive_helper"]["idle_stand_4"] = "sdr_mp_laststand_stand_revive_loop_helper_4";
  level.scr_eventanim["ls_revive_helper"]["idle_stand_4"] = "ls_stand_h_lp_4";
  level.scr_anim["ls_revive_helper"]["idle_stand_6"] = % sdr_mp_laststand_stand_revive_loop_helper_6;
  level.scr_animname["ls_revive_helper"]["idle_stand_6"] = "sdr_mp_laststand_stand_revive_loop_helper_6";
  level.scr_eventanim["ls_revive_helper"]["idle_stand_6"] = "ls_stand_h_lp_6";
  level.scr_anim["ls_revive_helper"]["idle_stand_7"] = % sdr_mp_laststand_stand_revive_loop_helper_7;
  level.scr_animname["ls_revive_helper"]["idle_stand_7"] = "sdr_mp_laststand_stand_revive_loop_helper_7";
  level.scr_eventanim["ls_revive_helper"]["idle_stand_7"] = "ls_stand_h_lp_7";
  level.scr_anim["ls_revive_helper"]["idle_stand_8"] = % sdr_mp_laststand_stand_revive_loop_helper_8;
  level.scr_animname["ls_revive_helper"]["idle_stand_8"] = "sdr_mp_laststand_stand_revive_loop_helper_8";
  level.scr_eventanim["ls_revive_helper"]["idle_stand_8"] = "ls_stand_h_lp_8";
  level.scr_anim["ls_revive_helper"]["idle_stand_9"] = % sdr_mp_laststand_stand_revive_loop_helper_9;
  level.scr_animname["ls_revive_helper"]["idle_stand_9"] = "sdr_mp_laststand_stand_revive_loop_helper_9";
  level.scr_eventanim["ls_revive_helper"]["idle_stand_9"] = "ls_stand_h_lp_9";
  level.scr_anim["ls_revive_helper"]["out_stand_1"] = % sdr_mp_laststand_stand_revive_out_helper_1;
  level.scr_animname["ls_revive_helper"]["out_stand_1"] = "sdr_mp_laststand_stand_revive_out_helper_1";
  level.scr_eventanim["ls_revive_helper"]["out_stand_1"] = "ls_stand_h_out_1";
  level.scr_anim["ls_revive_helper"]["out_stand_2"] = % sdr_mp_laststand_stand_revive_out_helper_2;
  level.scr_animname["ls_revive_helper"]["out_stand_2"] = "sdr_mp_laststand_stand_revive_out_helper_2";
  level.scr_eventanim["ls_revive_helper"]["out_stand_2"] = "ls_stand_h_out_2";
  level.scr_anim["ls_revive_helper"]["out_stand_3"] = % sdr_mp_laststand_stand_revive_out_helper_3;
  level.scr_animname["ls_revive_helper"]["out_stand_3"] = "sdr_mp_laststand_stand_revive_out_helper_3";
  level.scr_eventanim["ls_revive_helper"]["out_stand_3"] = "ls_stand_h_out_3";
  level.scr_anim["ls_revive_helper"]["out_stand_4"] = % sdr_mp_laststand_stand_revive_out_helper_4;
  level.scr_animname["ls_revive_helper"]["out_stand_4"] = "sdr_mp_laststand_stand_revive_out_helper_4";
  level.scr_eventanim["ls_revive_helper"]["out_stand_4"] = "ls_stand_h_out_4";
  level.scr_anim["ls_revive_helper"]["out_stand_6"] = % sdr_mp_laststand_stand_revive_out_helper_6;
  level.scr_animname["ls_revive_helper"]["out_stand_6"] = "sdr_mp_laststand_stand_revive_out_helper_6";
  level.scr_eventanim["ls_revive_helper"]["out_stand_6"] = "ls_stand_h_out_6";
  level.scr_anim["ls_revive_helper"]["out_stand_7"] = % sdr_mp_laststand_stand_revive_out_helper_7;
  level.scr_animname["ls_revive_helper"]["out_stand_7"] = "sdr_mp_laststand_stand_revive_out_helper_7";
  level.scr_eventanim["ls_revive_helper"]["out_stand_7"] = "ls_stand_h_out_7";
  level.scr_anim["ls_revive_helper"]["out_stand_8"] = % sdr_mp_laststand_stand_revive_out_helper_8;
  level.scr_animname["ls_revive_helper"]["out_stand_8"] = "sdr_mp_laststand_stand_revive_out_helper_8";
  level.scr_eventanim["ls_revive_helper"]["out_stand_8"] = "ls_stand_h_out_8";
  level.scr_anim["ls_revive_helper"]["out_stand_9"] = % sdr_mp_laststand_stand_revive_out_helper_9;
  level.scr_animname["ls_revive_helper"]["out_stand_9"] = "sdr_mp_laststand_stand_revive_out_helper_9";
  level.scr_eventanim["ls_revive_helper"]["out_stand_9"] = "ls_stand_h_out_9";
  level.scr_anim["ls_revive_wounded"]["in_stand_1"] = % sdr_mp_laststand_stand_revive_in_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["in_stand_1"] = "sdr_mp_laststand_stand_revive_in_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["in_stand_1"] = "ls_stand_w_in_147";
  level.scr_anim["ls_revive_wounded"]["in_stand_2"] = % sdr_mp_laststand_stand_revive_in_wounded_2;
  level.scr_animname["ls_revive_wounded"]["in_stand_2"] = "sdr_mp_laststand_stand_revive_in_wounded_2";
  level.scr_eventanim["ls_revive_wounded"]["in_stand_2"] = "ls_stand_w_in_2";
  level.scr_anim["ls_revive_wounded"]["in_stand_3"] = % sdr_mp_laststand_stand_revive_in_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["in_stand_3"] = "sdr_mp_laststand_stand_revive_in_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["in_stand_3"] = "ls_stand_w_in_369";
  level.scr_anim["ls_revive_wounded"]["in_stand_4"] = % sdr_mp_laststand_stand_revive_in_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["in_stand_4"] = "sdr_mp_laststand_stand_revive_in_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["in_stand_4"] = "ls_stand_w_in_147";
  level.scr_anim["ls_revive_wounded"]["in_stand_6"] = % sdr_mp_laststand_stand_revive_in_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["in_stand_6"] = "sdr_mp_laststand_stand_revive_in_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["in_stand_6"] = "ls_stand_w_in_369";
  level.scr_anim["ls_revive_wounded"]["in_stand_7"] = % sdr_mp_laststand_stand_revive_in_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["in_stand_7"] = "sdr_mp_laststand_stand_revive_in_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["in_stand_7"] = "ls_stand_w_in_147";
  level.scr_anim["ls_revive_wounded"]["in_stand_8"] = % sdr_mp_laststand_stand_revive_in_wounded_8;
  level.scr_animname["ls_revive_wounded"]["in_stand_8"] = "sdr_mp_laststand_stand_revive_in_wounded_8";
  level.scr_eventanim["ls_revive_wounded"]["in_stand_8"] = "ls_stand_w_in_8";
  level.scr_anim["ls_revive_wounded"]["in_stand_9"] = % sdr_mp_laststand_stand_revive_in_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["in_stand_9"] = "sdr_mp_laststand_stand_revive_in_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["in_stand_9"] = "ls_stand_w_in_369";
  level.scr_anim["ls_revive_wounded"]["idle_stand_1"] = % sdr_mp_laststand_stand_revive_loop_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["idle_stand_1"] = "sdr_mp_laststand_stand_revive_loop_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["idle_stand_1"] = "ls_stand_w_lp_147";
  level.scr_anim["ls_revive_wounded"]["idle_stand_2"] = % sdr_mp_laststand_stand_revive_loop_wounded_2;
  level.scr_animname["ls_revive_wounded"]["idle_stand_2"] = "sdr_mp_laststand_stand_revive_loop_wounded_2";
  level.scr_eventanim["ls_revive_wounded"]["idle_stand_2"] = "ls_stand_w_lp_2";
  level.scr_anim["ls_revive_wounded"]["idle_stand_3"] = % sdr_mp_laststand_stand_revive_loop_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["idle_stand_3"] = "sdr_mp_laststand_stand_revive_loop_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["idle_stand_3"] = "ls_stand_w_lp_369";
  level.scr_anim["ls_revive_wounded"]["idle_stand_4"] = % sdr_mp_laststand_stand_revive_loop_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["idle_stand_4"] = "sdr_mp_laststand_stand_revive_loop_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["idle_stand_4"] = "ls_stand_w_lp_147";
  level.scr_anim["ls_revive_wounded"]["idle_stand_6"] = % sdr_mp_laststand_stand_revive_loop_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["idle_stand_6"] = "sdr_mp_laststand_stand_revive_loop_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["idle_stand_6"] = "ls_stand_w_lp_369";
  level.scr_anim["ls_revive_wounded"]["idle_stand_7"] = % sdr_mp_laststand_stand_revive_loop_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["idle_stand_7"] = "sdr_mp_laststand_stand_revive_loop_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["idle_stand_7"] = "ls_stand_w_lp_147";
  level.scr_anim["ls_revive_wounded"]["idle_stand_8"] = % sdr_mp_laststand_stand_revive_loop_wounded_8;
  level.scr_animname["ls_revive_wounded"]["idle_stand_8"] = "sdr_mp_laststand_stand_revive_loop_wounded_8";
  level.scr_eventanim["ls_revive_wounded"]["idle_stand_8"] = "ls_stand_w_lp_8";
  level.scr_anim["ls_revive_wounded"]["idle_stand_9"] = % sdr_mp_laststand_stand_revive_loop_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["idle_stand_9"] = "sdr_mp_laststand_stand_revive_loop_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["idle_stand_9"] = "ls_stand_w_lp_369";
  level.scr_anim["ls_revive_wounded"]["out_stand_1"] = % sdr_mp_laststand_stand_revive_out_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["out_stand_1"] = "sdr_mp_laststand_stand_revive_out_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["out_stand_1"] = "ls_stand_w_out_147";
  level.scr_anim["ls_revive_wounded"]["out_stand_2"] = % sdr_mp_laststand_stand_revive_out_wounded_2;
  level.scr_animname["ls_revive_wounded"]["out_stand_2"] = "sdr_mp_laststand_stand_revive_out_wounded_2";
  level.scr_eventanim["ls_revive_wounded"]["out_stand_2"] = "ls_stand_w_out_2";
  level.scr_anim["ls_revive_wounded"]["out_stand_3"] = % sdr_mp_laststand_stand_revive_out_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["out_stand_3"] = "sdr_mp_laststand_stand_revive_out_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["out_stand_3"] = "ls_stand_w_out_369";
  level.scr_anim["ls_revive_wounded"]["out_stand_4"] = % sdr_mp_laststand_stand_revive_out_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["out_stand_4"] = "sdr_mp_laststand_stand_revive_out_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["out_stand_4"] = "ls_stand_w_out_147";
  level.scr_anim["ls_revive_wounded"]["out_stand_6"] = % sdr_mp_laststand_stand_revive_out_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["out_stand_6"] = "sdr_mp_laststand_stand_revive_out_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["out_stand_6"] = "ls_stand_w_out_369";
  level.scr_anim["ls_revive_wounded"]["out_stand_7"] = % sdr_mp_laststand_stand_revive_out_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["out_stand_7"] = "sdr_mp_laststand_stand_revive_out_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["out_stand_7"] = "ls_stand_w_out_147";
  level.scr_anim["ls_revive_wounded"]["out_stand_8"] = % sdr_mp_laststand_stand_revive_out_wounded_8;
  level.scr_animname["ls_revive_wounded"]["out_stand_8"] = "sdr_mp_laststand_stand_revive_out_wounded_8";
  level.scr_eventanim["ls_revive_wounded"]["out_stand_8"] = "ls_stand_w_out_8";
  level.scr_anim["ls_revive_wounded"]["out_stand_9"] = % sdr_mp_laststand_stand_revive_out_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["out_stand_9"] = "sdr_mp_laststand_stand_revive_out_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["out_stand_9"] = "ls_stand_w_out_369";
  level.scr_anim["ls_revive_helper"]["in_crouch_1"] = % sdr_mp_laststand_crouch_revive_in_helper_1;
  level.scr_animname["ls_revive_helper"]["in_crouch_1"] = "sdr_mp_laststand_crouch_revive_in_helper_1";
  level.scr_eventanim["ls_revive_helper"]["in_crouch_1"] = "ls_crouch_h_in_1";
  level.scr_anim["ls_revive_helper"]["in_crouch_2"] = % sdr_mp_laststand_crouch_revive_in_helper_2;
  level.scr_animname["ls_revive_helper"]["in_crouch_2"] = "sdr_mp_laststand_crouch_revive_in_helper_2";
  level.scr_eventanim["ls_revive_helper"]["in_crouch_2"] = "ls_crouch_h_in_2";
  level.scr_anim["ls_revive_helper"]["in_crouch_3"] = % sdr_mp_laststand_crouch_revive_in_helper_3;
  level.scr_animname["ls_revive_helper"]["in_crouch_3"] = "sdr_mp_laststand_crouch_revive_in_helper_3";
  level.scr_eventanim["ls_revive_helper"]["in_crouch_3"] = "ls_crouch_h_in_3";
  level.scr_anim["ls_revive_helper"]["in_crouch_4"] = % sdr_mp_laststand_crouch_revive_in_helper_4;
  level.scr_animname["ls_revive_helper"]["in_crouch_4"] = "sdr_mp_laststand_crouch_revive_in_helper_4";
  level.scr_eventanim["ls_revive_helper"]["in_crouch_4"] = "ls_crouch_h_in_4";
  level.scr_anim["ls_revive_helper"]["in_crouch_6"] = % sdr_mp_laststand_crouch_revive_in_helper_6;
  level.scr_animname["ls_revive_helper"]["in_crouch_6"] = "sdr_mp_laststand_crouch_revive_in_helper_6";
  level.scr_eventanim["ls_revive_helper"]["in_crouch_6"] = "ls_crouch_h_in_6";
  level.scr_anim["ls_revive_helper"]["in_crouch_7"] = % sdr_mp_laststand_crouch_revive_in_helper_7;
  level.scr_animname["ls_revive_helper"]["in_crouch_7"] = "sdr_mp_laststand_crouch_revive_in_helper_7";
  level.scr_eventanim["ls_revive_helper"]["in_crouch_7"] = "ls_crouch_h_in_7";
  level.scr_anim["ls_revive_helper"]["in_crouch_8"] = % sdr_mp_laststand_crouch_revive_in_helper_8;
  level.scr_animname["ls_revive_helper"]["in_crouch_8"] = "sdr_mp_laststand_crouch_revive_in_helper_8";
  level.scr_eventanim["ls_revive_helper"]["in_crouch_8"] = "ls_crouch_h_in_8";
  level.scr_anim["ls_revive_helper"]["in_crouch_9"] = % sdr_mp_laststand_crouch_revive_in_helper_9;
  level.scr_animname["ls_revive_helper"]["in_crouch_9"] = "sdr_mp_laststand_crouch_revive_in_helper_9";
  level.scr_eventanim["ls_revive_helper"]["in_crouch_9"] = "ls_crouch_h_in_9";
  level.scr_anim["ls_revive_helper"]["idle_crouch_1"] = % sdr_mp_laststand_crouch_revive_loop_helper_1;
  level.scr_animname["ls_revive_helper"]["idle_crouch_1"] = "sdr_mp_laststand_crouch_revive_loop_helper_1";
  level.scr_eventanim["ls_revive_helper"]["idle_crouch_1"] = "ls_crouch_h_lp_1";
  level.scr_anim["ls_revive_helper"]["idle_crouch_2"] = % sdr_mp_laststand_crouch_revive_loop_helper_2;
  level.scr_animname["ls_revive_helper"]["idle_crouch_2"] = "sdr_mp_laststand_crouch_revive_loop_helper_2";
  level.scr_eventanim["ls_revive_helper"]["idle_crouch_2"] = "ls_crouch_h_lp_2";
  level.scr_anim["ls_revive_helper"]["idle_crouch_3"] = % sdr_mp_laststand_crouch_revive_loop_helper_3;
  level.scr_animname["ls_revive_helper"]["idle_crouch_3"] = "sdr_mp_laststand_crouch_revive_loop_helper_3";
  level.scr_eventanim["ls_revive_helper"]["idle_crouch_3"] = "ls_crouch_h_lp_3";
  level.scr_anim["ls_revive_helper"]["idle_crouch_4"] = % sdr_mp_laststand_crouch_revive_loop_helper_4;
  level.scr_animname["ls_revive_helper"]["idle_crouch_4"] = "sdr_mp_laststand_crouch_revive_loop_helper_4";
  level.scr_eventanim["ls_revive_helper"]["idle_crouch_4"] = "ls_crouch_h_lp_4";
  level.scr_anim["ls_revive_helper"]["idle_crouch_6"] = % sdr_mp_laststand_crouch_revive_loop_helper_6;
  level.scr_animname["ls_revive_helper"]["idle_crouch_6"] = "sdr_mp_laststand_crouch_revive_loop_helper_6";
  level.scr_eventanim["ls_revive_helper"]["idle_crouch_6"] = "ls_crouch_h_lp_6";
  level.scr_anim["ls_revive_helper"]["idle_crouch_7"] = % sdr_mp_laststand_crouch_revive_loop_helper_7;
  level.scr_animname["ls_revive_helper"]["idle_crouch_7"] = "sdr_mp_laststand_crouch_revive_loop_helper_7";
  level.scr_eventanim["ls_revive_helper"]["idle_crouch_7"] = "ls_crouch_h_lp_7";
  level.scr_anim["ls_revive_helper"]["idle_crouch_8"] = % sdr_mp_laststand_crouch_revive_loop_helper_8;
  level.scr_animname["ls_revive_helper"]["idle_crouch_8"] = "sdr_mp_laststand_crouch_revive_loop_helper_8";
  level.scr_eventanim["ls_revive_helper"]["idle_crouch_8"] = "ls_crouch_h_lp_8";
  level.scr_anim["ls_revive_helper"]["idle_crouch_9"] = % sdr_mp_laststand_crouch_revive_loop_helper_9;
  level.scr_animname["ls_revive_helper"]["idle_crouch_9"] = "sdr_mp_laststand_crouch_revive_loop_helper_9";
  level.scr_eventanim["ls_revive_helper"]["idle_crouch_9"] = "ls_crouch_h_lp_9";
  level.scr_anim["ls_revive_helper"]["out_crouch_1"] = % sdr_mp_laststand_crouch_revive_out_helper_1;
  level.scr_animname["ls_revive_helper"]["out_crouch_1"] = "sdr_mp_laststand_crouch_revive_out_helper_1";
  level.scr_eventanim["ls_revive_helper"]["out_crouch_1"] = "ls_crouch_h_out_1";
  level.scr_anim["ls_revive_helper"]["out_crouch_2"] = % sdr_mp_laststand_crouch_revive_out_helper_2;
  level.scr_animname["ls_revive_helper"]["out_crouch_2"] = "sdr_mp_laststand_crouch_revive_out_helper_2";
  level.scr_eventanim["ls_revive_helper"]["out_crouch_2"] = "ls_crouch_h_out_2";
  level.scr_anim["ls_revive_helper"]["out_crouch_3"] = % sdr_mp_laststand_crouch_revive_out_helper_3;
  level.scr_animname["ls_revive_helper"]["out_crouch_3"] = "sdr_mp_laststand_crouch_revive_out_helper_3";
  level.scr_eventanim["ls_revive_helper"]["out_crouch_3"] = "ls_crouch_h_out_3";
  level.scr_anim["ls_revive_helper"]["out_crouch_4"] = % sdr_mp_laststand_crouch_revive_out_helper_4;
  level.scr_animname["ls_revive_helper"]["out_crouch_4"] = "sdr_mp_laststand_crouch_revive_out_helper_4";
  level.scr_eventanim["ls_revive_helper"]["out_crouch_4"] = "ls_crouch_h_out_4";
  level.scr_anim["ls_revive_helper"]["out_crouch_6"] = % sdr_mp_laststand_crouch_revive_out_helper_6;
  level.scr_animname["ls_revive_helper"]["out_crouch_6"] = "sdr_mp_laststand_crouch_revive_out_helper_6";
  level.scr_eventanim["ls_revive_helper"]["out_crouch_6"] = "ls_crouch_h_out_6";
  level.scr_anim["ls_revive_helper"]["out_crouch_7"] = % sdr_mp_laststand_crouch_revive_out_helper_7;
  level.scr_animname["ls_revive_helper"]["out_crouch_7"] = "sdr_mp_laststand_crouch_revive_out_helper_7";
  level.scr_eventanim["ls_revive_helper"]["out_crouch_7"] = "ls_crouch_h_out_7";
  level.scr_anim["ls_revive_helper"]["out_crouch_8"] = % sdr_mp_laststand_crouch_revive_out_helper_8;
  level.scr_animname["ls_revive_helper"]["out_crouch_8"] = "sdr_mp_laststand_crouch_revive_out_helper_8";
  level.scr_eventanim["ls_revive_helper"]["out_crouch_8"] = "ls_crouch_h_out_8";
  level.scr_anim["ls_revive_helper"]["out_crouch_9"] = % sdr_mp_laststand_crouch_revive_out_helper_9;
  level.scr_animname["ls_revive_helper"]["out_crouch_9"] = "sdr_mp_laststand_crouch_revive_out_helper_9";
  level.scr_eventanim["ls_revive_helper"]["out_crouch_9"] = "ls_crouch_h_out_9";
  level.scr_anim["ls_revive_wounded"]["in_crouch_1"] = % sdr_mp_laststand_crouch_revive_in_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["in_crouch_1"] = "sdr_mp_laststand_crouch_revive_in_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["in_crouch_1"] = "ls_crouch_w_in_147";
  level.scr_anim["ls_revive_wounded"]["in_crouch_2"] = % sdr_mp_laststand_crouch_revive_in_wounded_2;
  level.scr_animname["ls_revive_wounded"]["in_crouch_2"] = "sdr_mp_laststand_crouch_revive_in_wounded_2";
  level.scr_eventanim["ls_revive_wounded"]["in_crouch_2"] = "ls_crouch_w_in_2";
  level.scr_anim["ls_revive_wounded"]["in_crouch_3"] = % sdr_mp_laststand_crouch_revive_in_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["in_crouch_3"] = "sdr_mp_laststand_crouch_revive_in_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["in_crouch_3"] = "ls_crouch_w_in_369";
  level.scr_anim["ls_revive_wounded"]["in_crouch_4"] = % sdr_mp_laststand_crouch_revive_in_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["in_crouch_4"] = "sdr_mp_laststand_crouch_revive_in_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["in_crouch_4"] = "ls_crouch_w_in_147";
  level.scr_anim["ls_revive_wounded"]["in_crouch_6"] = % sdr_mp_laststand_crouch_revive_in_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["in_crouch_6"] = "sdr_mp_laststand_crouch_revive_in_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["in_crouch_6"] = "ls_crouch_w_in_369";
  level.scr_anim["ls_revive_wounded"]["in_crouch_7"] = % sdr_mp_laststand_crouch_revive_in_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["in_crouch_7"] = "sdr_mp_laststand_crouch_revive_in_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["in_crouch_7"] = "ls_crouch_w_in_147";
  level.scr_anim["ls_revive_wounded"]["in_crouch_8"] = % sdr_mp_laststand_crouch_revive_in_wounded_8;
  level.scr_animname["ls_revive_wounded"]["in_crouch_8"] = "sdr_mp_laststand_crouch_revive_in_wounded_8";
  level.scr_eventanim["ls_revive_wounded"]["in_crouch_8"] = "ls_crouch_w_in_8";
  level.scr_anim["ls_revive_wounded"]["in_crouch_9"] = % sdr_mp_laststand_crouch_revive_in_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["in_crouch_9"] = "sdr_mp_laststand_crouch_revive_in_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["in_crouch_9"] = "ls_crouch_w_in_369";
  level.scr_anim["ls_revive_wounded"]["idle_crouch_1"] = % sdr_mp_laststand_crouch_revive_loop_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["idle_crouch_1"] = "sdr_mp_laststand_crouch_revive_loop_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["idle_crouch_1"] = "ls_crouch_w_lp_147";
  level.scr_anim["ls_revive_wounded"]["idle_crouch_2"] = % sdr_mp_laststand_crouch_revive_loop_wounded_2;
  level.scr_animname["ls_revive_wounded"]["idle_crouch_2"] = "sdr_mp_laststand_crouch_revive_loop_wounded_2";
  level.scr_eventanim["ls_revive_wounded"]["idle_crouch_2"] = "ls_crouch_w_lp_2";
  level.scr_anim["ls_revive_wounded"]["idle_crouch_3"] = % sdr_mp_laststand_crouch_revive_loop_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["idle_crouch_3"] = "sdr_mp_laststand_crouch_revive_loop_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["idle_crouch_3"] = "ls_crouch_w_lp_369";
  level.scr_anim["ls_revive_wounded"]["idle_crouch_4"] = % sdr_mp_laststand_crouch_revive_loop_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["idle_crouch_4"] = "sdr_mp_laststand_crouch_revive_loop_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["idle_crouch_4"] = "ls_crouch_w_lp_147";
  level.scr_anim["ls_revive_wounded"]["idle_crouch_6"] = % sdr_mp_laststand_crouch_revive_loop_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["idle_crouch_6"] = "sdr_mp_laststand_crouch_revive_loop_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["idle_crouch_6"] = "ls_crouch_w_lp_369";
  level.scr_anim["ls_revive_wounded"]["idle_crouch_7"] = % sdr_mp_laststand_crouch_revive_loop_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["idle_crouch_7"] = "sdr_mp_laststand_crouch_revive_loop_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["idle_crouch_7"] = "ls_crouch_w_lp_147";
  level.scr_anim["ls_revive_wounded"]["idle_crouch_8"] = % sdr_mp_laststand_crouch_revive_loop_wounded_8;
  level.scr_animname["ls_revive_wounded"]["idle_crouch_8"] = "sdr_mp_laststand_crouch_revive_loop_wounded_8";
  level.scr_eventanim["ls_revive_wounded"]["idle_crouch_8"] = "ls_crouch_w_lp_8";
  level.scr_anim["ls_revive_wounded"]["idle_crouch_9"] = % sdr_mp_laststand_crouch_revive_loop_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["idle_crouch_9"] = "sdr_mp_laststand_crouch_revive_loop_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["idle_crouch_9"] = "ls_crouch_w_lp_369";
  level.scr_anim["ls_revive_wounded"]["out_crouch_1"] = % sdr_mp_laststand_crouch_revive_out_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["out_crouch_1"] = "sdr_mp_laststand_crouch_revive_out_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["out_crouch_1"] = "ls_crouch_w_out_147";
  level.scr_anim["ls_revive_wounded"]["out_crouch_2"] = % sdr_mp_laststand_crouch_revive_out_wounded_2;
  level.scr_animname["ls_revive_wounded"]["out_crouch_2"] = "sdr_mp_laststand_crouch_revive_out_wounded_2";
  level.scr_eventanim["ls_revive_wounded"]["out_crouch_2"] = "ls_crouch_w_out_2";
  level.scr_anim["ls_revive_wounded"]["out_crouch_3"] = % sdr_mp_laststand_crouch_revive_out_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["out_crouch_3"] = "sdr_mp_laststand_crouch_revive_out_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["out_crouch_3"] = "ls_crouch_w_out_369";
  level.scr_anim["ls_revive_wounded"]["out_crouch_4"] = % sdr_mp_laststand_crouch_revive_out_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["out_crouch_4"] = "sdr_mp_laststand_crouch_revive_out_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["out_crouch_4"] = "ls_crouch_w_out_147";
  level.scr_anim["ls_revive_wounded"]["out_crouch_6"] = % sdr_mp_laststand_crouch_revive_out_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["out_crouch_6"] = "sdr_mp_laststand_crouch_revive_out_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["out_crouch_6"] = "ls_crouch_w_out_369";
  level.scr_anim["ls_revive_wounded"]["out_crouch_7"] = % sdr_mp_laststand_crouch_revive_out_wounded_1_4_7;
  level.scr_animname["ls_revive_wounded"]["out_crouch_7"] = "sdr_mp_laststand_crouch_revive_out_wounded_1_4_7";
  level.scr_eventanim["ls_revive_wounded"]["out_crouch_7"] = "ls_crouch_w_out_147";
  level.scr_anim["ls_revive_wounded"]["out_crouch_8"] = % sdr_mp_laststand_crouch_revive_out_wounded_8;
  level.scr_animname["ls_revive_wounded"]["out_crouch_8"] = "sdr_mp_laststand_crouch_revive_out_wounded_8";
  level.scr_eventanim["ls_revive_wounded"]["out_crouch_8"] = "ls_crouch_w_out_8";
  level.scr_anim["ls_revive_wounded"]["out_crouch_9"] = % sdr_mp_laststand_crouch_revive_out_wounded_3_6_9;
  level.scr_animname["ls_revive_wounded"]["out_crouch_9"] = "sdr_mp_laststand_crouch_revive_out_wounded_3_6_9";
  level.scr_eventanim["ls_revive_wounded"]["out_crouch_9"] = "ls_crouch_w_out_369";
  level.scr_anim["ls_revive_wounded"]["in_prone_1"] = % sdr_mp_laststand_prone_revive_in_wounded_1;
  level.scr_animname["ls_revive_wounded"]["in_prone_1"] = "sdr_mp_laststand_prone_revive_in_wounded_1";
  level.scr_eventanim["ls_revive_wounded"]["in_prone_1"] = "ls_prone_w_in_1";
  level.scr_anim["ls_revive_wounded"]["in_prone_2"] = % sdr_mp_laststand_prone_revive_in_wounded_2;
  level.scr_animname["ls_revive_wounded"]["in_prone_2"] = "sdr_mp_laststand_prone_revive_in_wounded_2";
  level.scr_eventanim["ls_revive_wounded"]["in_prone_2"] = "ls_prone_w_in_2";
  level.scr_anim["ls_revive_wounded"]["in_prone_3"] = % sdr_mp_laststand_prone_revive_in_wounded_3;
  level.scr_animname["ls_revive_wounded"]["in_prone_3"] = "sdr_mp_laststand_prone_revive_in_wounded_3";
  level.scr_eventanim["ls_revive_wounded"]["in_prone_3"] = "ls_prone_w_in_3";
  level.scr_anim["ls_revive_wounded"]["in_prone_4"] = % sdr_mp_laststand_prone_revive_in_wounded_4;
  level.scr_animname["ls_revive_wounded"]["in_prone_4"] = "sdr_mp_laststand_prone_revive_in_wounded_4";
  level.scr_eventanim["ls_revive_wounded"]["in_prone_4"] = "ls_prone_w_in_4";
  level.scr_anim["ls_revive_wounded"]["in_prone_6"] = % sdr_mp_laststand_prone_revive_in_wounded_6;
  level.scr_animname["ls_revive_wounded"]["in_prone_6"] = "sdr_mp_laststand_prone_revive_in_wounded_6";
  level.scr_eventanim["ls_revive_wounded"]["in_prone_6"] = "ls_prone_w_in_6";
  level.scr_anim["ls_revive_wounded"]["in_prone_7"] = % sdr_mp_laststand_prone_revive_in_wounded_7;
  level.scr_animname["ls_revive_wounded"]["in_prone_7"] = "sdr_mp_laststand_prone_revive_in_wounded_7";
  level.scr_eventanim["ls_revive_wounded"]["in_prone_7"] = "ls_prone_w_in_7";
  level.scr_anim["ls_revive_wounded"]["in_prone_8"] = % sdr_mp_laststand_prone_revive_in_wounded_8;
  level.scr_animname["ls_revive_wounded"]["in_prone_8"] = "sdr_mp_laststand_prone_revive_in_wounded_8";
  level.scr_eventanim["ls_revive_wounded"]["in_prone_8"] = "ls_prone_w_in_8";
  level.scr_anim["ls_revive_wounded"]["in_prone_9"] = % sdr_mp_laststand_prone_revive_in_wounded_9;
  level.scr_animname["ls_revive_wounded"]["in_prone_9"] = "sdr_mp_laststand_prone_revive_in_wounded_9";
  level.scr_eventanim["ls_revive_wounded"]["in_prone_9"] = "ls_prone_w_in_9";
  level.scr_anim["ls_revive_wounded"]["idle_prone_1"] = % sdr_mp_laststand_prone_revive_loop_wounded_1;
  level.scr_animname["ls_revive_wounded"]["idle_prone_1"] = "sdr_mp_laststand_prone_revive_loop_wounded_1";
  level.scr_eventanim["ls_revive_wounded"]["idle_prone_1"] = "ls_prone_w_lp_1";
  level.scr_anim["ls_revive_wounded"]["idle_prone_2"] = % sdr_mp_laststand_prone_revive_loop_wounded_2;
  level.scr_animname["ls_revive_wounded"]["idle_prone_2"] = "sdr_mp_laststand_prone_revive_loop_wounded_2";
  level.scr_eventanim["ls_revive_wounded"]["idle_prone_2"] = "ls_prone_w_lp_2";
  level.scr_anim["ls_revive_wounded"]["idle_prone_3"] = % sdr_mp_laststand_prone_revive_loop_wounded_3;
  level.scr_animname["ls_revive_wounded"]["idle_prone_3"] = "sdr_mp_laststand_prone_revive_loop_wounded_3";
  level.scr_eventanim["ls_revive_wounded"]["idle_prone_3"] = "ls_prone_w_lp_3";
  level.scr_anim["ls_revive_wounded"]["idle_prone_4"] = % sdr_mp_laststand_prone_revive_loop_wounded_4;
  level.scr_animname["ls_revive_wounded"]["idle_prone_4"] = "sdr_mp_laststand_prone_revive_loop_wounded_4";
  level.scr_eventanim["ls_revive_wounded"]["idle_prone_4"] = "ls_prone_w_lp_4";
  level.scr_anim["ls_revive_wounded"]["idle_prone_6"] = % sdr_mp_laststand_prone_revive_loop_wounded_6;
  level.scr_animname["ls_revive_wounded"]["idle_prone_6"] = "sdr_mp_laststand_prone_revive_loop_wounded_6";
  level.scr_eventanim["ls_revive_wounded"]["idle_prone_6"] = "ls_prone_w_lp_6";
  level.scr_anim["ls_revive_wounded"]["idle_prone_7"] = % sdr_mp_laststand_prone_revive_loop_wounded_7;
  level.scr_animname["ls_revive_wounded"]["idle_prone_7"] = "sdr_mp_laststand_prone_revive_loop_wounded_7";
  level.scr_eventanim["ls_revive_wounded"]["idle_prone_7"] = "ls_prone_w_lp_7";
  level.scr_anim["ls_revive_wounded"]["idle_prone_8"] = % sdr_mp_laststand_prone_revive_loop_wounded_8;
  level.scr_animname["ls_revive_wounded"]["idle_prone_8"] = "sdr_mp_laststand_prone_revive_loop_wounded_8";
  level.scr_eventanim["ls_revive_wounded"]["idle_prone_8"] = "ls_prone_w_lp_8";
  level.scr_anim["ls_revive_wounded"]["idle_prone_9"] = % sdr_mp_laststand_prone_revive_loop_wounded_9;
  level.scr_animname["ls_revive_wounded"]["idle_prone_9"] = "sdr_mp_laststand_prone_revive_loop_wounded_9";
  level.scr_eventanim["ls_revive_wounded"]["idle_prone_9"] = "ls_prone_w_lp_9";
  level.scr_anim["ls_revive_wounded"]["out_prone_1"] = % sdr_mp_laststand_prone_revive_out_wounded_1;
  level.scr_animname["ls_revive_wounded"]["out_prone_1"] = "sdr_mp_laststand_prone_revive_out_wounded_1";
  level.scr_eventanim["ls_revive_wounded"]["out_prone_1"] = "ls_prone_w_out_1";
  level.scr_anim["ls_revive_wounded"]["out_prone_2"] = % sdr_mp_laststand_prone_revive_out_wounded_2;
  level.scr_animname["ls_revive_wounded"]["out_prone_2"] = "sdr_mp_laststand_prone_revive_out_wounded_2";
  level.scr_eventanim["ls_revive_wounded"]["out_prone_2"] = "ls_prone_w_out_2";
  level.scr_anim["ls_revive_wounded"]["out_prone_3"] = % sdr_mp_laststand_prone_revive_out_wounded_3;
  level.scr_animname["ls_revive_wounded"]["out_prone_3"] = "sdr_mp_laststand_prone_revive_out_wounded_3";
  level.scr_eventanim["ls_revive_wounded"]["out_prone_3"] = "ls_prone_w_out_3";
  level.scr_anim["ls_revive_wounded"]["out_prone_4"] = % sdr_mp_laststand_prone_revive_out_wounded_4;
  level.scr_animname["ls_revive_wounded"]["out_prone_4"] = "sdr_mp_laststand_prone_revive_out_wounded_4";
  level.scr_eventanim["ls_revive_wounded"]["out_prone_4"] = "ls_prone_w_out_4";
  level.scr_anim["ls_revive_wounded"]["out_prone_6"] = % sdr_mp_laststand_prone_revive_out_wounded_6;
  level.scr_animname["ls_revive_wounded"]["out_prone_6"] = "sdr_mp_laststand_prone_revive_out_wounded_6";
  level.scr_eventanim["ls_revive_wounded"]["out_prone_6"] = "ls_prone_w_out_6";
  level.scr_anim["ls_revive_wounded"]["out_prone_7"] = % sdr_mp_laststand_prone_revive_out_wounded_7;
  level.scr_animname["ls_revive_wounded"]["out_prone_7"] = "sdr_mp_laststand_prone_revive_out_wounded_7";
  level.scr_eventanim["ls_revive_wounded"]["out_prone_7"] = "ls_prone_w_out_7";
  level.scr_anim["ls_revive_wounded"]["out_prone_8"] = % sdr_mp_laststand_prone_revive_out_wounded_8;
  level.scr_animname["ls_revive_wounded"]["out_prone_8"] = "sdr_mp_laststand_prone_revive_out_wounded_8";
  level.scr_eventanim["ls_revive_wounded"]["out_prone_8"] = "ls_prone_w_out_8";
  level.scr_anim["ls_revive_wounded"]["out_prone_9"] = % sdr_mp_laststand_prone_revive_out_wounded_9;
  level.scr_animname["ls_revive_wounded"]["out_prone_9"] = "sdr_mp_laststand_prone_revive_out_wounded_9";
  level.scr_eventanim["ls_revive_wounded"]["out_prone_9"] = "ls_prone_w_out_9";
  level.scr_anim["ls_revive_helper"]["in_prone_1"] = % sdr_mp_laststand_prone_revive_in_helper_1;
  level.scr_animname["ls_revive_helper"]["in_prone_1"] = "sdr_mp_laststand_prone_revive_in_helper_1";
  level.scr_eventanim["ls_revive_helper"]["in_prone_1"] = "ls_prone_h_in_1";
  level.scr_anim["ls_revive_helper"]["in_prone_2"] = % sdr_mp_laststand_prone_revive_in_helper_2;
  level.scr_animname["ls_revive_helper"]["in_prone_2"] = "sdr_mp_laststand_prone_revive_in_helper_2";
  level.scr_eventanim["ls_revive_helper"]["in_prone_2"] = "ls_prone_h_in_2";
  level.scr_anim["ls_revive_helper"]["in_prone_3"] = % sdr_mp_laststand_prone_revive_in_helper_3;
  level.scr_animname["ls_revive_helper"]["in_prone_3"] = "sdr_mp_laststand_prone_revive_in_helper_3";
  level.scr_eventanim["ls_revive_helper"]["in_prone_3"] = "ls_prone_h_in_3";
  level.scr_anim["ls_revive_helper"]["in_prone_4"] = % sdr_mp_laststand_prone_revive_in_helper_4;
  level.scr_animname["ls_revive_helper"]["in_prone_4"] = "sdr_mp_laststand_prone_revive_in_helper_4";
  level.scr_eventanim["ls_revive_helper"]["in_prone_4"] = "ls_prone_h_in_4";
  level.scr_anim["ls_revive_helper"]["in_prone_6"] = % sdr_mp_laststand_prone_revive_in_helper_6;
  level.scr_animname["ls_revive_helper"]["in_prone_6"] = "sdr_mp_laststand_prone_revive_in_helper_6";
  level.scr_eventanim["ls_revive_helper"]["in_prone_6"] = "ls_prone_h_in_6";
  level.scr_anim["ls_revive_helper"]["in_prone_7"] = % sdr_mp_laststand_prone_revive_in_helper_7;
  level.scr_animname["ls_revive_helper"]["in_prone_7"] = "sdr_mp_laststand_prone_revive_in_helper_7";
  level.scr_eventanim["ls_revive_helper"]["in_prone_7"] = "ls_prone_h_in_7";
  level.scr_anim["ls_revive_helper"]["in_prone_8"] = % sdr_mp_laststand_prone_revive_in_helper_8;
  level.scr_animname["ls_revive_helper"]["in_prone_8"] = "sdr_mp_laststand_prone_revive_in_helper_8";
  level.scr_eventanim["ls_revive_helper"]["in_prone_8"] = "ls_prone_h_in_8";
  level.scr_anim["ls_revive_helper"]["in_prone_9"] = % sdr_mp_laststand_prone_revive_in_helper_9;
  level.scr_animname["ls_revive_helper"]["in_prone_9"] = "sdr_mp_laststand_prone_revive_in_helper_9";
  level.scr_eventanim["ls_revive_helper"]["in_prone_9"] = "ls_prone_h_in_9";
  level.scr_anim["ls_revive_helper"]["idle_prone_1"] = % sdr_mp_laststand_prone_revive_loop_helper_1;
  level.scr_animname["ls_revive_helper"]["idle_prone_1"] = "sdr_mp_laststand_prone_revive_loop_helper_1";
  level.scr_eventanim["ls_revive_helper"]["idle_prone_1"] = "ls_prone_h_lp_1";
  level.scr_anim["ls_revive_helper"]["idle_prone_2"] = % sdr_mp_laststand_prone_revive_loop_helper_2;
  level.scr_animname["ls_revive_helper"]["idle_prone_2"] = "sdr_mp_laststand_prone_revive_loop_helper_2";
  level.scr_eventanim["ls_revive_helper"]["idle_prone_2"] = "ls_prone_h_lp_2";
  level.scr_anim["ls_revive_helper"]["idle_prone_3"] = % sdr_mp_laststand_prone_revive_loop_helper_3;
  level.scr_animname["ls_revive_helper"]["idle_prone_3"] = "sdr_mp_laststand_prone_revive_loop_helper_3";
  level.scr_eventanim["ls_revive_helper"]["idle_prone_3"] = "ls_prone_h_lp_3";
  level.scr_anim["ls_revive_helper"]["idle_prone_4"] = % sdr_mp_laststand_prone_revive_loop_helper_4;
  level.scr_animname["ls_revive_helper"]["idle_prone_4"] = "sdr_mp_laststand_prone_revive_loop_helper_4";
  level.scr_eventanim["ls_revive_helper"]["idle_prone_4"] = "ls_prone_h_lp_4";
  level.scr_anim["ls_revive_helper"]["idle_prone_6"] = % sdr_mp_laststand_prone_revive_loop_helper_6;
  level.scr_animname["ls_revive_helper"]["idle_prone_6"] = "sdr_mp_laststand_prone_revive_loop_helper_6";
  level.scr_eventanim["ls_revive_helper"]["idle_prone_6"] = "ls_prone_h_lp_6";
  level.scr_anim["ls_revive_helper"]["idle_prone_7"] = % sdr_mp_laststand_prone_revive_loop_helper_7;
  level.scr_animname["ls_revive_helper"]["idle_prone_7"] = "sdr_mp_laststand_prone_revive_loop_helper_7";
  level.scr_eventanim["ls_revive_helper"]["idle_prone_7"] = "ls_prone_h_lp_7";
  level.scr_anim["ls_revive_helper"]["idle_prone_8"] = % sdr_mp_laststand_prone_revive_loop_helper_8;
  level.scr_animname["ls_revive_helper"]["idle_prone_8"] = "sdr_mp_laststand_prone_revive_loop_helper_8";
  level.scr_eventanim["ls_revive_helper"]["idle_prone_8"] = "ls_prone_h_lp_8";
  level.scr_anim["ls_revive_helper"]["idle_prone_9"] = % sdr_mp_laststand_prone_revive_loop_helper_9;
  level.scr_animname["ls_revive_helper"]["idle_prone_9"] = "sdr_mp_laststand_prone_revive_loop_helper_9";
  level.scr_eventanim["ls_revive_helper"]["idle_prone_9"] = "ls_prone_h_lp_9";
  level.scr_anim["ls_revive_helper"]["out_prone_1"] = % sdr_mp_laststand_prone_revive_out_helper_1;
  level.scr_animname["ls_revive_helper"]["out_prone_1"] = "sdr_mp_laststand_prone_revive_out_helper_1";
  level.scr_eventanim["ls_revive_helper"]["out_prone_1"] = "ls_prone_h_out_1";
  level.scr_anim["ls_revive_helper"]["out_prone_2"] = % sdr_mp_laststand_prone_revive_out_helper_2;
  level.scr_animname["ls_revive_helper"]["out_prone_2"] = "sdr_mp_laststand_prone_revive_out_helper_2";
  level.scr_eventanim["ls_revive_helper"]["out_prone_2"] = "ls_prone_h_out_2";
  level.scr_anim["ls_revive_helper"]["out_prone_3"] = % sdr_mp_laststand_prone_revive_out_helper_3;
  level.scr_animname["ls_revive_helper"]["out_prone_3"] = "sdr_mp_laststand_prone_revive_out_helper_3";
  level.scr_eventanim["ls_revive_helper"]["out_prone_3"] = "ls_prone_h_out_3";
  level.scr_anim["ls_revive_helper"]["out_prone_4"] = % sdr_mp_laststand_prone_revive_out_helper_4;
  level.scr_animname["ls_revive_helper"]["out_prone_4"] = "sdr_mp_laststand_prone_revive_out_helper_4";
  level.scr_eventanim["ls_revive_helper"]["out_prone_4"] = "ls_prone_h_out_4";
  level.scr_anim["ls_revive_helper"]["out_prone_6"] = % sdr_mp_laststand_prone_revive_out_helper_6;
  level.scr_animname["ls_revive_helper"]["out_prone_6"] = "sdr_mp_laststand_prone_revive_out_helper_6";
  level.scr_eventanim["ls_revive_helper"]["out_prone_6"] = "ls_prone_h_out_6";
  level.scr_anim["ls_revive_helper"]["out_prone_7"] = % sdr_mp_laststand_prone_revive_out_helper_7;
  level.scr_animname["ls_revive_helper"]["out_prone_7"] = "sdr_mp_laststand_prone_revive_out_helper_7";
  level.scr_eventanim["ls_revive_helper"]["out_prone_7"] = "ls_prone_h_out_7";
  level.scr_anim["ls_revive_helper"]["out_prone_8"] = % sdr_mp_laststand_prone_revive_out_helper_8;
  level.scr_animname["ls_revive_helper"]["out_prone_8"] = "sdr_mp_laststand_prone_revive_out_helper_8";
  level.scr_eventanim["ls_revive_helper"]["out_prone_8"] = "ls_prone_h_out_8";
  level.scr_anim["ls_revive_helper"]["out_prone_9"] = % sdr_mp_laststand_prone_revive_out_helper_9;
  level.scr_animname["ls_revive_helper"]["out_prone_9"] = "sdr_mp_laststand_prone_revive_out_helper_9";
  level.scr_eventanim["ls_revive_helper"]["out_prone_9"] = "ls_prone_h_out_9";
  scripts\common\anim::addnotetrack_customfunction("ls_revive_wounded", "cp_foley_revive_wounded_down", ::revive_wounded_in_handler);
  scripts\common\anim::addnotetrack_customfunction("ls_revive_wounded", "cp_last_stand_revive_out_wounded", ::revive_wounded_out_handler);
  scripts\common\anim::addnotetrack_customfunction("ls_revive_wounded", "cp_foley_revive_wounded_recover_standing", ::revive_wounded_out_handlerr);
  scripts\common\anim::addnotetrack_customfunction("ls_revive_helper", "stim_attach", ::syringe_out);
  scripts\common\anim::addnotetrack_customfunction("ls_revive_helper", "syringe_inject", ::syringe_inject);
  scripts\common\anim::addnotetrack_customfunction("ls_revive_helper", "syringe_finish", ::syringe_finish);
  scripts\common\anim::addnotetrack_customfunction("ls_revive_helper", "syringe_finish_crouching", ::syringe_finish_crouch);
  scripts\common\anim::addnotetrack_customfunction("ls_revive_helper", "syringe_finish_standing", ::syringe_finish_stand);
}

syringe_out(guy) {
  guy.entity notify("spawn_stim");
  guy playsoundonmovingent("cp_foley_revive_helper_syringe_out");
}

syringe_inject(guy) {
  guy playsoundonmovingent("cp_foley_revive_helper_syringe_inject");
}

syringe_finish(guy) {
  guy playsoundonmovingent("cp_foley_revive_helper_syringe_finish");
  guy.entity notify("remove_stim");
}

syringe_finish_crouch(guy) {
  guy playsoundonmovingent("cp_foley_revive_helper_recover_crouching");
  guy.entity notify("remove_stim");
}

syringe_finish_stand(guy) {
  guy playsoundonmovingent("cp_last_stand_revive_out_helper");
  guy.entity notify("remove_stim");
}

revive_wounded_in_handler(guy) {
  guy playsoundonmovingent("cp_foley_revive_wounded_down");
}

revive_wounded_out_handler(guy) {
  guy playsoundonmovingent("cp_last_stand_revive_out_wounded");
}

revive_wounded_out_handlerr(guy) {
  guy playsoundonmovingent("cp_foley_revive_wounded_recover_standing");
}

set_revive_time(normal_revive_time, spectator_revive_time, fast_revive_time) {
  if(isDefined(normal_revive_time))
    level.normal_revive_time = normal_revive_time;

  if(isDefined(spectator_revive_time))
    level.spectator_revive_time = spectator_revive_time;

  level.fast_revive_time = fast_revive_time;
}

set_cam(camera) {
  if(istrue(self.relic_third_person) || istrue(self._id_911B640702FEC71A)) {
    self setcamerathirdperson(1);
    self _meth_5762CF97C6F1A2C1("first_person");
  } else if(!isDefined(camera)) {
    self cameradefault();
    self setcamerathirdperson(0);
  } else
    self cameraset(camera);
}

any_player_in_laststand() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    if(istrue(level.players[_id_AC0E594AC96AA3A8].inlaststand))
      return 1;
  }

  return 0;
}

_id_9D6AC1BAF6C44970() {
  if(_id_F1F7670D27B96E26()) {
    _id_06FE80416B4BE165 = _id_66122A002AFF5D57::getitemdroporiginandangles(_id_703FDBB02501D31E::_id_B1C55038843DE38B(), self.origin, self.angles);

    if(isDefined(self.plundercount) && self.plundercount > 0) {
      _id_66122A002AFF5D57::_id_34DC33AF893513B2(self.plundercount, _id_703FDBB02501D31E::_id_B1C55038843DE38B());
      _id_06FE80416B4BE165 = _id_66122A002AFF5D57::getitemdroporiginandangles(_id_703FDBB02501D31E::_id_B1C55038843DE38B(), self.origin, self.angles);
      _id_3BCAA2CBAF54ABDD::set_player_currency(0);
    }

    if(isDefined(self.copy_fullweaponlist)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.copy_fullweaponlist.size; _id_AC0E594AC96AA3A8++) {
        if(_id_66122A002AFF5D57::_id_B3B99F9F9371C997(self.copy_fullweaponlist[_id_AC0E594AC96AA3A8])) {
          _id_66122A002AFF5D57::weaponspawn(self.copy_fullweaponlist[_id_AC0E594AC96AA3A8], _id_06FE80416B4BE165, 0, 1);
          _id_06FE80416B4BE165 = _id_66122A002AFF5D57::getitemdroporiginandangles(_id_703FDBB02501D31E::_id_B1C55038843DE38B(), self.origin, self.angles);
        }
      }
    } else if(isDefined(self.primaryweapons)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.primaryweapons.size; _id_AC0E594AC96AA3A8++) {
        if(_id_66122A002AFF5D57::_id_B3B99F9F9371C997(self.primaryweapons[_id_AC0E594AC96AA3A8])) {
          _id_66122A002AFF5D57::weaponspawn(self.primaryweapons[_id_AC0E594AC96AA3A8], _id_06FE80416B4BE165, 0, 1);
          _id_06FE80416B4BE165 = _id_66122A002AFF5D57::getitemdroporiginandangles(_id_703FDBB02501D31E::_id_B1C55038843DE38B(), self.origin, self.angles);
          scripts\cp_mp\utility\inventory_utility::_takeweapon(self.primaryweapons[_id_AC0E594AC96AA3A8]);
        }
      }
    }

    if(isDefined(self.armorqueued) && self.armorqueued >= 1) {
      _id_CB4FAD49263E20C4 = _id_66122A002AFF5D57::getitemdroporiginandangles(_id_703FDBB02501D31E::_id_B1C55038843DE38B(), self.origin, self.angles, self);
      item = _id_66122A002AFF5D57::spawnpickup("brloot_armor_plate", _id_CB4FAD49263E20C4, self.armorqueued, 1, undefined, 1);
    }

    if(isDefined(self.pre_laststand_powers)) {
      powers = getarraykeys(self.pre_laststand_powers);

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < powers.size; _id_AC0E594AC96AA3A8++) {
        _id_D49285246B443066 = _id_66122A002AFF5D57::_id_63699875D9ACA328(powers[_id_AC0E594AC96AA3A8]);
        _id_CB4FAD49263E20C4 = _id_66122A002AFF5D57::getitemdroporiginandangles(_id_703FDBB02501D31E::_id_B1C55038843DE38B(), self.origin, self.angles, self);
        count = self.pre_laststand_powers[powers[_id_AC0E594AC96AA3A8]].charges;
        item = _id_66122A002AFF5D57::spawnpickup(_id_D49285246B443066, _id_CB4FAD49263E20C4, count, 1, undefined, 0);
      }
    } else if(isDefined(self.powers)) {
      powers = getarraykeys(self.powers);

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < powers.size; _id_AC0E594AC96AA3A8++) {
        _id_D49285246B443066 = _id_66122A002AFF5D57::_id_63699875D9ACA328(powers[_id_AC0E594AC96AA3A8]);

        if(isDefined(_id_D49285246B443066)) {
          _id_CB4FAD49263E20C4 = _id_66122A002AFF5D57::getitemdroporiginandangles(_id_703FDBB02501D31E::_id_B1C55038843DE38B(), self.origin, self.angles, self);
          count = self.powers[powers[_id_AC0E594AC96AA3A8]].charges;
          item = _id_66122A002AFF5D57::spawnpickup(_id_D49285246B443066, _id_CB4FAD49263E20C4, count, 1, undefined, 0);
        }
      }
    }

    _id_66122A002AFF5D57::_id_5CFF081D620D2EF3();
  }
}

_id_F1F7670D27B96E26() {
  if(getdvarint("dvar_1BD4D94E5C712D0F"))
    return 0;

  return 1;
}

_id_E74630E55C27F7A8(_id_318ADE4970C8F647, gameshouldend) {
  self notify("wait_in_spectator");
  self endon("wait_in_spectator");
  self endon("disconnect");
  level endon("game_ended");
  setbeingrevivedinternal(0);

  if(!isDefined(gameshouldend))
    gameshouldend = _id_5DE995015A65E87D(self);

  if(!level._id_028BCDD92F005721)
    self._id_A4F1D87B225A8D61 = 1;

  self.begin_spectate = 1;
  self setclientomnvar("ui_out_of_bounds_countdown", 0);
  waitframe();
  _id_116171939929AF39::broadcast_status(self, 2);
  record_bleedout(_id_318ADE4970C8F647);

  if(isDefined(self.bleedoutspawnentityoverride))
    self.bleedoutspawnentityoverride = undefined;

  if(is_killed_by_kill_trigger(_id_318ADE4970C8F647)) {
    _id_1A70694E2F9D6D5D = self;

    if(isDefined(self._id_80F9D0AEAA47CC0C) && scripts\cp\cp_outofbounds::isoob(self, 0))
      _id_1A70694E2F9D6D5D = self._id_80F9D0AEAA47CC0C;
    else if(isDefined(_id_318ADE4970C8F647))
      _id_1A70694E2F9D6D5D = _id_318ADE4970C8F647;

    _id_FB1DEF007972B25A = scripts\engine\utility::drop_to_ground(_id_1A70694E2F9D6D5D.origin, 32, -64) + (0, 0, 5);
    spawnangle = _id_1A70694E2F9D6D5D.angles;
  } else {
    _id_FB1DEF007972B25A = self.origin;
    spawnangle = self.angles;
  }

  clear_last_stand_timer(self);
  self.spectating = 1;

  if(_id_41352B6DB86EF848())
    _id_408EF6A51DACACA4(_id_FB1DEF007972B25A, spawnangle);
  else {
    self notify("entered_spectate");

    if(!istrue(level._id_93B4908CF59EEA60) && isDefined(level.enter_spectator_func))
      level thread[[level.enter_spectator_func]](self);

    if(istrue(level._id_93B4908CF59EEA60)) {
      thread enter_spectate(self, _id_FB1DEF007972B25A, undefined);
      self.last_stand_state = "bleed_out";

      if(scripts\cp\utility::_id_DDAFEF2154FD19BB()) {
        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
          if(level.players[_id_AC0E594AC96AA3A8] != self)
            level.players[_id_AC0E594AC96AA3A8] thread scripts\cp\cp_hud_message::showsplash("cp_respawn_buy_ready");
        }

        thread _id_6D977E4DA51C55F3(3);
      }

      scripts\engine\utility::waittill_any_ents(self, "revive_success");
    } else {
      result = wait_to_be_revived(self, _id_FB1DEF007972B25A, undefined, undefined, 0, get_spectator_revive_time(), (1, 0, 0), undefined, 1, gameshouldend, 1);

      if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
        _id_5AD98C689425D831();
    }

    show_all_revive_icons();
    _id_116171939929AF39::broadcast_status(self, 0);
    self.spectating = undefined;
    self.begin_spectate = undefined;
    scripts\cp\utility::updatesessionstate("playing");

    if(!isDefined(self.forcespawnorigin) && !isDefined(self.forcespawnangles)) {
      self.forcespawnorigin = _id_FB1DEF007972B25A;
      self.forcespawnangles = spawnangle;
    }

    if(isDefined(level.prespawnfromspectatorfunc))
      [[level.prespawnfromspectatorfunc]](self);

    _id_B42CA26B52BD9762 = istrue(self._id_A4F1D87B225A8D61);
    self._id_A4F1D87B225A8D61 = undefined;
    [[level.spawnplayerfunc]](undefined, undefined, _id_B42CA26B52BD9762);

    if(!istrue(level.all_players_skip_last_stand))
      self.shouldskiplaststand = 0;

    scripts\cp\utility::freezecontrolswrapper(0);

    if(scripts\cp\cp_relics::_id_7915E88A08F28705())
      _id_B2820F8C0083D223(self);
  }

  if(isDefined(level._id_595DA6922B3E48DC))
    self[[level._id_595DA6922B3E48DC]]();

  thread onexitcommon(1);
  dropcarryobject();
}

_id_B2820F8C0083D223(player) {
  scripts\cp\cp_relics::init_relic_vars(player);
  player thread scripts\cp\cp_relics::relics_monitor_on_player();
}

_id_41352B6DB86EF848() {
  return isDefined(level.respawn_func) && !istrue(level.dogtag_revive);
}

_id_408EF6A51DACACA4(_id_FB1DEF007972B25A, spawnangle) {
  self.last_stand_state = "bleed_out";

  if(isDefined(level.automated_respawn_func)) {
    while(!istrue(level.automated_respawn_available))
      wait 1;

    if(!istrue(level.automated_respawn_delay_skip))
      level thread[[level.automated_respawn_func]]();
  }

  if(self[[level.respawn_func]](self, _id_FB1DEF007972B25A)) {
    self.bspawningviaac130 = 1;
    show_all_revive_icons();
    _id_116171939929AF39::broadcast_status(self, 0);
    self.spectating = undefined;
    scripts\cp\utility::updatesessionstate("playing");

    if(!isDefined(self.forcespawnorigin) && !isDefined(self.forcespawnangles)) {
      self.forcespawnorigin = _id_FB1DEF007972B25A;
      self.forcespawnangles = spawnangle;
    }

    if(isDefined(level.prespawnfromspectatorfunc))
      [[level.prespawnfromspectatorfunc]](self);

    if(istrue(self.forced_revive)) {
      self.forced_revive = undefined;
      [[level.spawnplayerfunc]]();
    } else
      [[level.spawnplayerfunc]](1);

    self.shouldskiplaststand = 0;
  } else {}
}

record_bleedout(_id_318ADE4970C8F647) {
  _id_3BCAA2CBAF54ABDD::eog_player_update_stat("deaths", 1);

  if(!is_killed_by_kill_trigger(_id_318ADE4970C8F647)) {
    scripts\cp\cp_gamescore::update_team_encounter_performance(scripts\cp\cp_gamescore::get_team_score_component_name(), "num_players_bleed_out");
    scripts\cp\cp_analytics::inc_bleedout_counts();
  }
}

is_killed_by_kill_trigger(_id_318ADE4970C8F647) {
  return isDefined(_id_318ADE4970C8F647) || istrue(self.oob) || istrue(self.shouldskiplaststand) || istrue(self _meth_E40102956C887F7C());
}

wait_to_be_revived(_id_1730C8D8475566CD, _id_FB1DEF007972B25A, _id_AE4FAE9BA66E6AA3, _id_DA0143862335CB2A, _id_960565C8383E5C83, _id_A268CB99479F185D, _id_69BC42A14A8942A3, timelimit, _id_3BC814FCFF1670FD, gameshouldend, _id_ABD29C5AF2A4D78A, _id_BA651AFF199A8CD4) {
  if(isDefined(_id_1730C8D8475566CD.dogtag))
    reviveent = _id_1730C8D8475566CD.dogtag;
  else if(istrue(_id_1730C8D8475566CD._id_A14C34F117DAF30A))
    reviveent = _id_1730C8D8475566CD scripts\engine\utility::spawn_tag_origin();
  else
    reviveent = makereviveentity(_id_1730C8D8475566CD, _id_FB1DEF007972B25A, _id_AE4FAE9BA66E6AA3, _id_DA0143862335CB2A, _id_960565C8383E5C83);

  if(_id_3BC814FCFF1670FD) {
    thread enter_spectate(_id_1730C8D8475566CD, _id_FB1DEF007972B25A, reviveent);
    _id_1730C8D8475566CD.last_stand_state = "bleed_out";
  } else
    level notify("waiting_to_be_revived_from_laststand", _id_1730C8D8475566CD);

  if(_id_9D24182B90507AA9())
    reviveent _meth_DFB78B3E724AD620(0);

  if(gameshouldend) {
    level waittill("forever");
    return 0;
  } else {
    reviveiconent = reviveent;

    if(!istrue(_id_1730C8D8475566CD._id_A14C34F117DAF30A)) {
      if(_id_3BC814FCFF1670FD) {}

      if(_id_ABD29C5AF2A4D78A) {}
    } else
      reviveent setModel("tag_origin");

    _id_1730C8D8475566CD.reviveent = reviveent;
    _id_1730C8D8475566CD.reviveiconent = reviveiconent;

    if(isDefined(level.give_up_func) && (!_id_1730C8D8475566CD isspectatingplayer() || !istrue(_id_3BC814FCFF1670FD)))
      _id_1730C8D8475566CD thread[[level.give_up_func]](_id_1730C8D8475566CD, _id_FB1DEF007972B25A, _id_AE4FAE9BA66E6AA3, _id_DA0143862335CB2A, _id_960565C8383E5C83, _id_A268CB99479F185D, _id_69BC42A14A8942A3, timelimit, _id_3BC814FCFF1670FD, gameshouldend, _id_ABD29C5AF2A4D78A, _id_BA651AFF199A8CD4);

    if(!isDefined(reviveent)) {
      level waittill("forever");
      return 0;
    }

    if(istrue(1))
      reviveent thread laststandmoveawayfromvehicles(_id_1730C8D8475566CD, _id_A268CB99479F185D);

    if(isDefined(timelimit))
      result = reviveent scripts\engine\utility::waittill_any_ents_or_timeout_return(timelimit, reviveent, "revive_success", _id_1730C8D8475566CD, "force_bleed_out", _id_1730C8D8475566CD, "revive_success", _id_1730C8D8475566CD, "challenge_complete_revive");
    else
      result = reviveent scripts\engine\utility::waittill_any_ents_return(reviveent, "revive_success", _id_1730C8D8475566CD, "challenge_complete_revive", _id_1730C8D8475566CD, "force_bleed_out", _id_1730C8D8475566CD, "last_stand_finished");

    if(isDefined(result)) {
      if(result == "timeout" && is_being_revived(_id_1730C8D8475566CD))
        result = reviveent scripts\engine\utility::waittill_any_return_2("revive_success", "revive_fail");

      if(result == "timeout" && player_is_trying_self_revive(_id_1730C8D8475566CD))
        result = reviveent scripts\engine\utility::waittill_any_return_2("revive_success", "revive_fail");
    }

    if(isDefined(_id_1730C8D8475566CD.reviveent))
      _id_1730C8D8475566CD.reviveent delete();

    if(isDefined(_id_1730C8D8475566CD.reviveiconent))
      _id_1730C8D8475566CD.reviveiconent delete();

    _id_1730C8D8475566CD notify("give_up_done");

    if(result == "revive_success" || result == "challenge_complete_revive")
      return 1;
    else
      return 0;
  }
}

get_spectator_revive_time() {
  if(isDefined(level.spectator_revive_time))
    return level.spectator_revive_time;
  else
    return 6000;
}

show_all_revive_icons() {
  if(isDefined(self.revive_icons)) {
    foreach(_id_7BBE82017EFE5C94 in self.revive_icons)
    _id_7BBE82017EFE5C94.alpha = 1;
  }
}

makereviveentity(_id_1730C8D8475566CD, _id_FB1DEF007972B25A, _id_AE4FAE9BA66E6AA3, _id_DA0143862335CB2A, _id_960565C8383E5C83) {
  if(istrue(level.gameended)) {
    return;
  }
  _id_AD42B1DDB060FA39 = (0, 0, 20);
  _id_EEEE6F55BBA7A8EE = anglesToForward(_id_1730C8D8475566CD.angles) * 30;
  _id_FB1DEF007972B25A = scripts\engine\utility::drop_to_ground(_id_FB1DEF007972B25A + _id_AD42B1DDB060FA39 + _id_EEEE6F55BBA7A8EE, 32, -64);
  reviveent = spawn("script_model", _id_1730C8D8475566CD.origin);
  reviveent makeusable();
  reviveent _meth_DFB78B3E724AD620(1);
  reviveent setHintString(&"COOP_GAME_PLAY/REVIVE_USE");
  reviveent setCursorHint("HINT_NOICON");
  reviveent setusehideprogressbar(1);
  reviveent setuseholdduration("duration_none");
  reviveent setusepriority(-3);
  reviveent.trigger = spawnStruct();
  reviveent.trigger.owner = _id_1730C8D8475566CD;
  reviveent.trigger.id = "laststand_reviver";
  reviveent.trigger.targetname = "revive_trigger";
  reviveent.owner = _id_1730C8D8475566CD;
  reviveent.inuse = 0;
  reviveent.targetname = "revive_trigger";
  _id_1730C8D8475566CD.reviveent = reviveent;

  if(isDefined(_id_AE4FAE9BA66E6AA3))
    reviveent setModel(_id_AE4FAE9BA66E6AA3);

  if(isDefined(_id_DA0143862335CB2A))
    reviveent scriptmodelplayanim(_id_DA0143862335CB2A);

  if(_id_960565C8383E5C83)
    reviveent linkTo(_id_1730C8D8475566CD, "tag_origin", _id_AD42B1DDB060FA39, (0, 0, 0));

  reviveent disableplayeruse(_id_1730C8D8475566CD);
  reviveent thread cleanuplaststandent(_id_1730C8D8475566CD);
  return reviveent;
}

makereviveiconentity(_id_1730C8D8475566CD, reviveent) {
  if(istrue(level.gameended)) {
    return;
  }
  reviveiconent = spawn("script_model", reviveent.origin + (0, 0, 30));
  _id_1730C8D8475566CD.reviveiconent = reviveiconent;
  reviveiconent.owner = _id_1730C8D8475566CD;
  reviveiconent thread cleanuplaststandent(_id_1730C8D8475566CD, 1);
  return reviveiconent;
}

makereviveicon(reviveiconent, owner, color, _id_D229E334EC96F738) {
  setup_revive_icon_ent(reviveiconent);
  reviveiconent.current_revive_icon_color = color;
  reviveiconent.revive_icon_color_keep = color;
  reviveiconent thread reviveiconentcleanup(reviveiconent);
  _id_DCC2A5D189ACF48D = undefined;

  foreach(player in level.players) {
    if(player == owner) {}

    if(isDefined(level.should_show_revive_icon_to_player_func) && ![[level.should_show_revive_icon_to_player_func]](player, owner)) {
      continue;
    }
    _id_DCC2A5D189ACF48D = show_revive_icon_to_player(reviveiconent, player);
    add_to_revive_icon_ent_icon_list(reviveiconent, _id_DCC2A5D189ACF48D);
  }

  if(isDefined(_id_D229E334EC96F738))
    reviveiconent thread revive_icon_color_management(_id_D229E334EC96F738, owner);

  return _id_DCC2A5D189ACF48D;
}

setup_revive_icon_ent(_id_729984070498B386) {
  _id_729984070498B386.revive_icons = [];
  add_to_revive_icon_entity_list(_id_729984070498B386);
}

add_to_revive_icon_ent_icon_list(_id_729984070498B386, _id_7BBE82017EFE5C94) {
  _id_729984070498B386.revive_icons[_id_729984070498B386.revive_icons.size] = _id_7BBE82017EFE5C94;
}

reviveiconentcleanup(reviveiconent) {
  reviveiconent waittill("death");
  remove_from_revive_icon_entity_list(reviveiconent);
}

remove_from_revive_icon_entity_list(_id_017EB95D4B724D96) {
  level.revive_icon_entities = scripts\engine\utility::array_remove(level.revive_icon_entities, _id_017EB95D4B724D96);
  level.revive_icon_entities = scripts\engine\utility::array_removeundefined(level.revive_icon_entities);
}

show_revive_icon_to_player(reviveiconent, owner) {
  _id_DCC2A5D189ACF48D = newclienthudelem(owner);

  if(level.splitscreen)
    _id_DCC2A5D189ACF48D setshader("hud_realism_head_revive", 10, 10);
  else
    _id_DCC2A5D189ACF48D setshader("hud_realism_head_revive", 5, 5);

  _id_DCC2A5D189ACF48D setwaypoint(1, 1);
  _id_DCC2A5D189ACF48D settargetEnt(reviveiconent);
  _id_DCC2A5D189ACF48D.alpha = get_revive_icon_initial_alpha(owner);
  _id_DCC2A5D189ACF48D.color = reviveiconent.current_revive_icon_color;
  add_to_player_revive_icon_list(owner, _id_DCC2A5D189ACF48D);
  _id_DCC2A5D189ACF48D thread reviveiconcleanup(reviveiconent, owner);
  return _id_DCC2A5D189ACF48D;
}

get_revive_icon_initial_alpha(player) {
  return 1;
}

add_to_player_revive_icon_list(player, _id_7BBE82017EFE5C94) {
  player.revive_icons[player.revive_icons.size] = _id_7BBE82017EFE5C94;
}

reviveiconcleanup(reviveiconent, owner) {
  scripts\engine\utility::waittill_any_ents_return(reviveiconent, "death", owner, "disconnect");
  remove_from_owner_revive_icon_list(self, owner);

  if(isDefined(self))
    self destroy();
}

remove_from_owner_revive_icon_list(_id_7BBE82017EFE5C94, owner) {
  if(!isDefined(owner)) {
    return;
  }
  owner.revive_icons = scripts\engine\utility::array_remove(owner.revive_icons, _id_7BBE82017EFE5C94);
}

revive_icon_color_management(_id_D229E334EC96F738, downed_player) {
  level endon("game_ended");
  self endon("death");
  self endon("end_revive_icon_color_management");
  thread _id_395D864602540630();
  wait(_id_D229E334EC96F738 / 3);
  set_revive_icon_color(self, (1, 0.941, 0));
  self.revive_icon_color_keep = (1, 0.941, 0);
  wait(_id_D229E334EC96F738 / 3);
  set_revive_icon_color(self, (0.929, 0.231, 0.141));
  self.revive_icon_color_keep = (0.929, 0.231, 0.141);
}

_id_395D864602540630() {
  self.owner endon("disconnect");
  self endon("death");
  self.owner waittill("entered_spectate");
  self notify("end_revive_icon_color_management");
  set_revive_icon_color(self, (0.929, 0.231, 0.141));
  self.revive_icon_color_keep = (0.929, 0.231, 0.141);
}

laststandwaittillrevivebyteammate(_id_1730C8D8475566CD, _id_A268CB99479F185D) {
  level endon("game_ended");
  self endon("death");

  if(isDefined(level.revive_ent_usability_func))
    self thread[[level.revive_ent_usability_func]](_id_1730C8D8475566CD, self);

  for(;;) {
    self _meth_DFB78B3E724AD620(1);
    self setuseprioritymax();
    self waittill("trigger", reviver);
    self _meth_DFB78B3E724AD620(0);

    if(istrue(_id_1730C8D8475566CD getbeingrevivedinternal(1))) {
      continue;
    }
    if(istrue(_id_1730C8D8475566CD.instant_revived)) {
      continue;
    }
    if(istrue(_id_1730C8D8475566CD.isgivingup)) {
      continue;
    }
    if(reviver ismeleeing()) {
      continue;
    }
    if(istrue(reviver.land_usability_disabled)) {
      continue;
    }
    if(!isPlayer(reviver) && !istrue(reviver.can_revive)) {
      continue;
    }
    if(istrue(_id_1730C8D8475566CD.adrenalinepoweractive)) {
      continue;
    }
    if(istrue(reviver.usingascender)) {
      continue;
    }
    if(istrue(reviver.is_riding_hel)) {
      continue;
    }
    if(!isDefined(reviver.revive_vo_time))
      reviver.revive_vo_time = 0;

    if(gettime() > reviver.revive_vo_time) {
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(reviver, "stat_572347275DFB41AB");
      reviver.revive_vo_time = gettime() + 10000;
    }

    reviver notify("started_revive");
    disable_bleedout_ent_usability(_id_1730C8D8475566CD);
    reviver _id_3B64EB40368C1450::set("lastStandWaittillReviveByTeammate", "weapon", 0);
    level thread revivent_watchfordeath_safety(self, reviver);
    _id_377B630BD29A2FAC = get_revive_result(_id_1730C8D8475566CD, reviver, self.origin, int(_id_A268CB99479F185D));
    enable_bleedout_ent_usability(_id_1730C8D8475566CD);

    if(_id_377B630BD29A2FAC) {
      _id_1730C8D8475566CD thread _id_1B7EBC11CD2BC4A8();
      reviver _id_3B64EB40368C1450::set("lastStandWaittillReviveByTeammate", "weapon", 1);

      if(isDefined(reviver.vo_prefix)) {
        if(isDefined(level.revive_success_vo_func))
          level thread[[level.revive_success_vo_func]](reviver, _id_1730C8D8475566CD);
      } else if(_id_396A814D39E7044F::_id_7BA31CB6B21C346F())
        _id_1730C8D8475566CD thread _id_396A814D39E7044F::_id_36EDF91561322753(2);
      else
        level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(_id_1730C8D8475566CD, "stat_1F1F4FE800E03B33");

      record_revive_success(reviver, _id_1730C8D8475566CD);
      reviver notify("revive_teammate", _id_1730C8D8475566CD);
      scripts\cp\cp_analytics::logevent_spawnviaplayer(_id_1730C8D8475566CD, reviver);
      _id_DB24F499F4608B0D = 1;
      _id_1730C8D8475566CD.last_stand_state = undefined;

      if(isPlayer(reviver)) {
        if(!istrue(reviver.can_give_revive_xp))
          reviver thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_AB2FA142759B4C26", undefined, undefined, -1);
        else {
          reviver thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_AB2FA142759B4C26");
          reviver.can_give_revive_xp = 0;
        }
      }

      if(istrue(reviver.relic_third_person) || istrue(reviver._id_911B640702FEC71A)) {
        reviver setcamerathirdperson(1);
        reviver _meth_5762CF97C6F1A2C1("first_person");
      }

      break;
    } else {
      reviver notify("revive_done");
      _id_1730C8D8475566CD notify("revive_done");
      reviver _id_3B64EB40368C1450::set("lastStandWaittillReviveByTeammate", "weapon", 1);
      set_revive_icon_color(_id_1730C8D8475566CD.reviveent, _id_1730C8D8475566CD.reviveent.revive_icon_color_keep, 1);

      if(!reviver scripts\cp_mp\utility\player_utility::_isalive() || reviver.inlaststand) {
        _id_1730C8D8475566CD.reviveent disableplayeruse(reviver);
        reviver thread downed_reviver_watch_for_return_to_usability(_id_1730C8D8475566CD.reviveent, reviver);
      }

      reviver scripts\engine\utility::delaythread(1.5, scripts\cp\utility::force_usability_enabled);

      if(isDefined(reviver.revive_stim)) {
        reviver.revive_stim delete();
        reviver.revive_stim = undefined;
      }

      if(isDefined(reviver.revive_origin)) {
        reviver setOrigin(reviver.revive_origin);
        reviver.revive_origin = undefined;
      }

      self notify("revive_fail");

      if(istrue(reviver.relic_third_person) || istrue(reviver._id_911B640702FEC71A)) {
        reviver setcamerathirdperson(1);
        reviver _meth_5762CF97C6F1A2C1("first_person");
      }

      continue;
    }
  }

  clear_last_stand_timer(_id_1730C8D8475566CD);
  self notify("revive_success");
}

_id_15276C5B8C5146E8(_id_1730C8D8475566CD) {
  if(!_id_1730C8D8475566CD isonground()) {
    if(isDefined(level.custom_putongroundfunc) && isfunction(level.custom_putongroundfunc))
      [[level.custom_putongroundfunc]](_id_1730C8D8475566CD);
    else {
      pos = scripts\engine\utility::drop_to_ground(_id_1730C8D8475566CD.origin, 5, -1500);
      pos = getclosestpointonnavmesh(pos);
      _id_1730C8D8475566CD setOrigin(pos);
    }
  }
}

disable_bleedout_ent_usability(_id_1730C8D8475566CD) {
  if(isDefined(_id_1730C8D8475566CD.executeent)) {
    if(isDefined(level.disable_bleedout_ent_usability_func))
      level thread[[level.disable_bleedout_ent_usability_func]](_id_1730C8D8475566CD);
  }
}

enable_bleedout_ent_usability(_id_1730C8D8475566CD) {
  if(isDefined(_id_1730C8D8475566CD.executeent)) {
    if(isDefined(level.enable_bleedout_ent_usability_func))
      level thread[[level.enable_bleedout_ent_usability_func]](_id_1730C8D8475566CD);
  }
}

revivent_watchfordeath_safety(reviveent, reviver) {
  reviveent endon("revive_fail");
  reviveent endon("revive_success");
  reviver endon("death_or_disconnect");
  reviveent waittill("death");
  reviver scripts\engine\utility::delaythread(1.5, scripts\cp\utility::force_usability_enabled);
}

get_revive_result(downed_player, reviver, pos, use_time) {
  _id_C5D3D8FF129F88BA = scripts\cp\utility::createuseent(pos);
  _id_C5D3D8FF129F88BA thread cleanuplaststandent(downed_player);
  result = revive_use_hold_think(downed_player, reviver, _id_C5D3D8FF129F88BA, use_time - 1500);
  return result;
}

revive_use_hold_think(downed_player, reviver, _id_C5D3D8FF129F88BA, use_time) {
  if(isDefined(reviver.vo_prefix)) {
    if(isDefined(level.revive_use_hold_vo_func))
      level thread[[level.revive_use_hold_vo_func]](reviver, downed_player);
  }

  reviver scripts\cp\utility::_id_1DBC717085326045(undefined, 0, undefined);
  downed_player scripts\cp\utility::_id_1DBC717085326045(undefined, 0, undefined);
  enter_revive_use_hold_think(downed_player, reviver, _id_C5D3D8FF129F88BA, use_time);
  set_revive_icon_color(downed_player.reviveent, (0.0117, 0.9882, 0.9882), 1);
  play_revive_gesture(reviver, downed_player);
  reviver.validtakeweapon = reviver scripts\cp\utility::getvalidtakeweapon();
  thread wait_for_exit_revive_use_hold_think(downed_player, reviver, _id_C5D3D8FF129F88BA, reviver.validtakeweapon);
  downed_player.reviver = reviver;
  _id_14C1392E5D9436BC = 0;
  result = 0;
  enable_on_world_progress_bar_for_other_players(downed_player, reviver);

  if(isPlayer(reviver))
    downed_player notify("reviving");

  while(should_revive_continue(reviver)) {
    if(_id_14C1392E5D9436BC >= use_time) {
      result = 1;
      break;
    }

    _id_5D3A428E1F92C6BA = _id_14C1392E5D9436BC / use_time;
    update_players_revive_progress_bar(downed_player, reviver, _id_5D3A428E1F92C6BA);
    _id_14C1392E5D9436BC = _id_14C1392E5D9436BC + 50;
    waitframe();
  }

  disable_on_world_progress_bar_for_other_players(downed_player, reviver);
  reviver scripts\engine\utility::delaythread(1, ::force_remove_stim);

  if(istrue(result))
    _id_C5D3D8FF129F88BA notify("use_hold_think_success");
  else
    _id_C5D3D8FF129F88BA notify("use_hold_think_fail");

  _id_C5D3D8FF129F88BA waittill("exit_use_hold_think_complete");
  return result;
}

enter_revive_use_hold_think(downed_player, reviver, _id_C5D3D8FF129F88BA, use_time) {
  reviver scripts\cp\utility::_id_1DBC717085326045(5, 0);
  downed_player scripts\cp\utility::_id_1DBC717085326045(6, 0, reviver getentitynumber());
  lock_player_stance(reviver);
  downed_player.being_revived = 1;

  if(isPlayer(reviver)) {
    reviver _id_3B64EB40368C1450::set("reviver_disables", "equipment_primary", 0);
    reviver _id_3B64EB40368C1450::set("reviver_disables", "equipment_secondary", 0);
  }

  reviver.isreviving = 1;
}

play_revive_gesture(reviver, downed_player) {
  if(isDefined(level.nuclear_core_carrier)) {
    if(level.nuclear_core_carrier == reviver)
      return;
  }

  reviver allowmelee(0);
  reviver disableweaponswitch();
  reviver notify("offhand_end");
}

wait_for_exit_revive_use_hold_think(downed_player, reviver, _id_C5D3D8FF129F88BA, _id_4C26C9E7F53F3037) {
  result = scripts\engine\utility::waittill_any_ents_return(_id_C5D3D8FF129F88BA, "use_hold_think_success", _id_C5D3D8FF129F88BA, "use_hold_think_fail", downed_player, "disconnect", downed_player, "revive_success", downed_player, "force_bleed_out", reviver, "challenge_complete", downed_player, "death");

  if(downed_player scripts\cp_mp\utility\player_utility::_isalive()) {
    downed_player.being_revived = 0;
    downed_player unlink();
    downed_player scripts\engine\utility::delaythread(1, ::set_cam);
    downed_player scripts\cp\utility::_id_1DBC717085326045(0, 0, -1);
  }

  reviver.isreviving = 0;

  if(isPlayer(reviver)) {
    reviver stop_revive_gesture(reviver, reviver.validtakeweapon);
    reviver unlink();
    reviver set_cam();
    reviver scripts\cp\utility::_id_1DBC717085326045(0, 0, -1);
    reviver allowstand(1);
    reviver allowcrouch(1);
    reviver allowprone(1);
    reviver.anim_scene_stance_override = undefined;
    reviver _id_3B64EB40368C1450::set("reviver_disables", "equipment_primary", 1);
    reviver _id_3B64EB40368C1450::set("reviver_disables", "equipment_secondary", 1);
    reviver unlink();
    reviver notify("stop_revive");
  }

  _id_C5D3D8FF129F88BA notify("exit_use_hold_think_complete");
}

enable_on_world_progress_bar_for_other_players(downed_player, reviver) {
  index = add_to_players_being_revived(downed_player);
  omnvar = "zm_revive_bar_" + index + "_target";

  foreach(player in level.players) {
    if(player == downed_player || player == reviver) {
      continue;
    }
    player setclientomnvar(omnvar, downed_player);
  }
}

should_revive_continue(reviver) {
  _id_0D1F23C550E310AC = !level.gameended && reviver scripts\cp_mp\utility\player_utility::_isalive() && reviver useButtonPressed() && !player_in_laststand(reviver);

  if(isDefined(reviver.can_revive) && reviver.can_revive == 0)
    return 0;

  return _id_0D1F23C550E310AC;
}

update_players_revive_progress_bar(downed_player, reviver, _id_5D3A428E1F92C6BA) {
  foreach(player in level.players) {
    if(player == downed_player || player == reviver) {
      player scripts\cp\utility::_id_1DBC717085326045(undefined, _id_5D3A428E1F92C6BA, undefined);
      continue;
    }

    player setclientomnvar("zm_revive_bar_" + downed_player.revive_progress_bar_id + "_progress", _id_5D3A428E1F92C6BA);
  }
}

disable_on_world_progress_bar_for_other_players(downed_player, reviver) {
  omnvar = "zm_revive_bar_" + downed_player.revive_progress_bar_id + "_target";
  remove_from_players_being_revived(downed_player);

  foreach(player in level.players) {
    if(player == downed_player || player == reviver) {
      continue;
    }
    player setclientomnvar(omnvar, undefined);
  }
}

add_to_players_being_revived(downed_player) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 2; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(level.players_being_revived[_id_AC0E594AC96AA3A8])) {
      level.players_being_revived[_id_AC0E594AC96AA3A8] = downed_player;
      index = _id_AC0E594AC96AA3A8 + 1;
      downed_player.revive_progress_bar_id = index;
      return index;
    }
  }
}

remove_from_players_being_revived(downed_player) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 2; _id_AC0E594AC96AA3A8++) {
    if(isDefined(level.players_being_revived[_id_AC0E594AC96AA3A8]) && level.players_being_revived[_id_AC0E594AC96AA3A8] == downed_player) {
      level.players_being_revived[_id_AC0E594AC96AA3A8] = undefined;
      downed_player.revive_progress_bar_id = undefined;
      return;
    }
  }
}

force_remove_stim() {
  if(isDefined(self.revive_stim)) {
    self.revive_stim delete();
    self notify("remove_stim");
  }

  self cameradefault();

  if(istrue(self.relic_third_person))
    self setcamerathirdperson(1);
  else
    self setcamerathirdperson(0);
}

lock_player_stance(player) {
  _id_E7AF06F7A4040877 = player getstance();

  switch (_id_E7AF06F7A4040877) {
    case "stand":
      player allowstand(1);
      player allowcrouch(0);
      player allowprone(0);
      return;
    case "crouch":
      player allowstand(0);
      player allowcrouch(1);
      player allowprone(0);
      return;
    case "prone":
      player allowstand(0);
      player allowcrouch(0);
      player allowprone(1);
      return;
  }
}

downed_reviver_watch_for_return_to_usability(reviveent, reviver) {
  level endon("game_ended");
  reviver endon("disconnect");
  scripts\engine\utility::waittill_any_ents(reviver, "revive", reviveent, "death");

  if(isDefined(reviveent) && isalive(reviver))
    reviveent enableplayeruse(reviver);
}

laststandmoveawayfromvehicles(_id_1730C8D8475566CD, _id_A268CB99479F185D) {
  self endon("death");
  level endon("game_ended");
  _id_340C9ED716C44138 = 600;
  _id_3B266F496EA9E0E9 = _id_340C9ED716C44138 * _id_340C9ED716C44138;
  _id_6B7BEE46F2C6DA28 = 0;
  _id_ABAB6BC73FCCEF65 = -3;
  _id_8425EFBC1DDF4A48 = _id_1730C8D8475566CD.origin;

  while(_id_6B7BEE46F2C6DA28 < _id_A268CB99479F185D) {
    if(_id_6B7BEE46F2C6DA28 >= _id_ABAB6BC73FCCEF65 + 3) {
      _id_FA0334FEC6BA2BAC = vehicle_getarray();

      foreach(vehicle in _id_FA0334FEC6BA2BAC) {
        if(distancesquared(_id_1730C8D8475566CD.origin, vehicle.origin) < _id_3B266F496EA9E0E9) {
          _id_B9E9097150D1298C = length2d(_id_1730C8D8475566CD.origin - _id_8425EFBC1DDF4A48);

          if(_id_B9E9097150D1298C > 500 && _id_B9E9097150D1298C < 5000) {
            _id_1730C8D8475566CD scripts\cp\utility::moveplayerperpendicularly(1200);
            _id_ABAB6BC73FCCEF65 = _id_6B7BEE46F2C6DA28;
          }
        }
      }
    }

    _id_6B7BEE46F2C6DA28 = _id_6B7BEE46F2C6DA28 + 2;
    wait 2;
  }
}

is_being_revived(player) {
  return istrue(player.being_revived);
}

player_is_trying_self_revive(player) {
  return istrue(player.using_self_revive);
}

add_to_revive_icon_entity_list(_id_017EB95D4B724D96) {
  level.revive_icon_entities[level.revive_icon_entities.size] = _id_017EB95D4B724D96;
}

stop_revive_gesture(reviver, _id_4C26C9E7F53F3037) {
  if(isDefined(level.nuclear_core_carrier)) {
    if(level.nuclear_core_carrier == reviver)
      return;
  }

  reviver enableweaponswitch();
  reviver allowmelee(1);
}

enable_dogtag_revive(_id_1730C8D8475566CD) {
  if(istrue(level.gameended)) {
    return;
  }
  if(isDefined(_id_1730C8D8475566CD.dogtag)) {
    return;
  }
  _id_BBDCC7365DD1C6BA = _id_1730C8D8475566CD.origin;

  if(istrue(level._id_920CBA4B7B32D2A9))
    _id_BBDCC7365DD1C6BA = scripts\engine\utility::drop_to_ground(_id_BBDCC7365DD1C6BA, 64);

  if(istrue(level._id_57640B5729015657))
    _id_BBDCC7365DD1C6BA = getclosestpointonnavmesh(_id_BBDCC7365DD1C6BA);

  if(scripts\cp\cp_outofbounds::isoob(_id_1730C8D8475566CD, 0)) {
    _id_BBDCC7365DD1C6BA = _id_1730C8D8475566CD._id_80F9D0AEAA47CC0C.origin;
    thread scripts\cp\cp_outofbounds::clearoob(_id_1730C8D8475566CD, 1);
  }

  if(isDefined(level._id_B6CD3626C14C131E)) {
    foreach(struct in level._id_B6CD3626C14C131E) {
      if(_id_1730C8D8475566CD scripts\cp\utility::_id_496139DD736902CC(struct)) {
        _id_BBDCC7365DD1C6BA = scripts\engine\utility::getStruct(struct.target, "targetname").origin;
        break;
      }
    }
  }

  if(isDefined(level._id_289BE3C21F39E36B))
    _id_BBDCC7365DD1C6BA = [[level._id_289BE3C21F39E36B]](_id_1730C8D8475566CD, _id_BBDCC7365DD1C6BA);

  if(_id_1730C8D8475566CD _meth_E40102956C887F7C())
    dogtag = spawn("script_model", _id_BBDCC7365DD1C6BA);
  else
    dogtag = spawn("script_model", _id_BBDCC7365DD1C6BA + (0, 0, 40));

  dogtag _id_C919AFEBF9FE06C4(_id_1730C8D8475566CD);
  _id_1730C8D8475566CD.respawn_forcespawnorigin = _id_BBDCC7365DD1C6BA + (0, 0, 5);
  _id_1730C8D8475566CD.respawn_forcespawnangles = (0, 0, 0);
  _id_1730C8D8475566CD.dogtag = dogtag;
  _id_1730C8D8475566CD.dogtag.owner = _id_1730C8D8475566CD;
  dogtag.owner = _id_1730C8D8475566CD;
  _id_1730C8D8475566CD._id_F13B2C408FE7BA46 = _id_1730C8D8475566CD _id_7EF95BBA57DC4B82::getequipmentslotammo("health");
  _id_1DAB4A6BAD01C509 = _id_1730C8D8475566CD getentitynumber();
  _id_C9F85AEFA1694334 = dogtag getentitynumber();
  _id_3BCAA2CBAF54ABDD::setcoopplayerdata_for_everyone("EoGPlayer", _id_1DAB4A6BAD01C509, "ui_dog_tags_entity_num", _id_C9F85AEFA1694334);

  if(!istrue(_id_1730C8D8475566CD._id_A14C34F117DAF30A))
    _id_0449348B412E6B21(_id_1730C8D8475566CD, dogtag, (0.929, 0.231, 0.141));

  if(scripts\cp\utility::_id_A3577E8E6C88A56B() || scripts\cp\utility::is_raid_gamemode())
    dogtag hudoutlineenable("outline_nodepth_white");

  dogtag thread revivetriggerthink(_id_1730C8D8475566CD.team);
  dogtag thread endreviveonownerdeathordisconnect();
  dogtag thread _id_5C02BCA10D532C9B(_id_1730C8D8475566CD);

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
    dogtag thread _id_AF3BD2E64377CD03();

  level notify("laststand_dogtag_spawned", dogtag);
}

_id_0449348B412E6B21(player, target_ent, _id_0C75370C3A04AFA1, _id_D229E334EC96F738) {
  if(getdvarint("dvar_155DCC14C52DACF8", 1)) {
    return;
  }
  if(!isDefined(_id_0C75370C3A04AFA1))
    _id_0C75370C3A04AFA1 = (0.929, 0.231, 0.141);

  reviveiconent = makereviveiconentity(player, target_ent);
  makereviveicon(reviveiconent, player, _id_0C75370C3A04AFA1, _id_D229E334EC96F738);
  return reviveiconent;
}

_id_5C02BCA10D532C9B(_id_1730C8D8475566CD) {
  minimapid = undefined;
  minimapid = scripts\cp\cp_objectives::requestworldid("dogtag_mimimap", 10);
  objective_state(minimapid, "active");
  objective_icon(minimapid, "hud_icon_minimap_misc_dog_tag");
  objective_setminimapiconsize(minimapid, "icon_small");
  objective_setshowdistance(minimapid, 1);
  objective_setplayintro(minimapid, 0);
  objective_onentity(minimapid, self);
  objective_setownerteam(minimapid, "allies");
  self waittill("death");
  objective_delete(minimapid);
  scripts\cp\cp_objectives::freeworldidbyobjid(minimapid);
}

_id_153F83A298FAF9C6(_id_A00884ED3A6D8B4B) {
  level endon("game_ended");
  _id_BA3322D31F0514EE = ["dx_bc_aqsc_firm_aqs1_gotone", "dx_bc_aqsc_firm_aqs2_gotone", "dx_bc_aqsc_firm_aqs3_gotone", "dx_bc_aqsc_firm_aqs4_gotone", "dx_bc_aqsc_firm_aqs5_gotone", "dx_bc_aqsc_firm_aqs1_ikilledone", "dx_bc_aqsc_firm_aqs2_ikilledone", "dx_bc_aqsc_firm_aqs3_ikilledone", "dx_bc_aqsc_firm_aqs4_ikilledone", "dx_bc_aqsc_firm_aqs5_ikilledone", "dx_bc_aqsc_firm_aqs1_ishotone", "dx_bc_aqsc_firm_aqs2_ishotone", "dx_bc_aqsc_firm_aqs3_ishotone", "dx_bc_aqsc_firm_aqs4_ishotone", "dx_bc_aqsc_firm_aqs5_ishotone", "dx_bc_aqsc_firm_aqs1_theyredead", "dx_bc_aqsc_firm_aqs2_theyredead", "dx_bc_aqsc_firm_aqs3_theyredead", "dx_bc_aqsc_firm_aqs4_theyredead", "dx_bc_aqsc_firm_aqs5_theyredead", "dx_bc_aqsc_firm_aqs1_ikilledthemthatpig", "dx_bc_aqsc_firm_aqs2_ikilledthemthatpig", "dx_bc_aqsc_firm_aqs3_ikilledthemthatpig", "dx_bc_aqsc_firm_aqs4_ikilledthemthatpig", "dx_bc_aqsc_firm_aqs5_ikilledthemthatpig", "dx_bc_aqsc_firm_aqs1_ishotthatone", "dx_bc_aqsc_firm_aqs2_ishotthatone", "dx_bc_aqsc_firm_aqs3_ishotthatone", "dx_bc_aqsc_firm_aqs4_ishotthatone", "dx_bc_aqsc_firm_aqs5_ishotthatone"];
  _id_D067AFD6DB440176 = 512;
  _id_E338D86DC3095BE7 = scripts\engine\utility::getclosest(_id_A00884ED3A6D8B4B, getaiarray(), _id_D067AFD6DB440176);

  if(isDefined(_id_E338D86DC3095BE7) && _id_6EEEF4A78F8955E7(_id_E338D86DC3095BE7))
    _id_E338D86DC3095BE7 playSound(scripts\engine\utility::random(_id_BA3322D31F0514EE));
}

_id_6EEEF4A78F8955E7(ai) {
  if(!isDefined(ai) || !isDefined(ai.aitype))
    return 0;

  _id_947CAC6DF8A8C6B2 = strtok(ai.aitype, "_");
  return scripts\engine\utility::array_contains(_id_947CAC6DF8A8C6B2, "aq");
}

_id_C919AFEBF9FE06C4(_id_1730C8D8475566CD) {
  self setModel("military_dogtags_iw9_blue");
  self makeusable();
  self _meth_DFB78B3E724AD620(1);
  self setHintString(&"MP/LASTSTAND_REVIVE_USE");
  self setCursorHint("HINT_NOICON");
  self setusehideprogressbar(1);
  self setuseholdduration("duration_none");
  self setusepriority(-3);
  self scriptmodelplayanim("mp_dogtag_spin");
  self.trigger = spawnStruct();
  self.trigger.owner = _id_1730C8D8475566CD;
  self.id = "laststand_reviver";
  self.trigger.id = "laststand_reviver";
  self.trigger.targetname = "revive_trigger";
  self endon("death");
}

_id_459987FA892EFB71() {
  return istrue(level._id_DF73B19D71E8BC58);
}

_id_7BF7BA0EC7FF7057() {
  scripts\engine\utility::flag_set("revive_tokens_disabled");
}

_id_51E2F809587F38AC() {
  scripts\engine\utility::flag_clear("revive_tokens_disabled");
}

_id_2767AAACD3DFC97A() {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("hardmode_revive_tokens_setup_complete"))
    scripts\engine\utility::flag_init("hardmode_revive_tokens_setup_complete");

  if(!_id_10A17AA507F07BD8()) {
    return;
  }
  _id_51E2F809587F38AC();
  level._id_F63478BCA59E2670 = getdvarint("dvar_AAE8E9A472853241", 3);

  if(!isDefined(level._id_A80E6D45222F9A47))
    level._id_A80E6D45222F9A47 = level._id_F63478BCA59E2670;

  scripts\engine\utility::flag_wait("objectives_registered");

  while(level.activequests.size == 0)
    wait 0.05;

  wait 0.05;
  scripts\cp\cp_gameskill::_id_3898E5F82C5C37DF(0);
  scripts\engine\utility::flag_set("hardmode_revive_tokens_setup_complete");
}

_id_79DDAC0EF09B8D0F(_id_EE13026B48E61129, _id_440FA28F4FE729DD) {
  level endon("game_ended");
  level._id_F63478BCA59E2670 = getdvarint("dvar_AAE8E9A472853241", 3);
  level._id_A80E6D45222F9A47 = level._id_F63478BCA59E2670;

  if(isDefined(_id_EE13026B48E61129)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      player = level.players[_id_AC0E594AC96AA3A8];

      if(!isDefined(player.respawn_index))
        _id_1C22CBC2D69134C3();

      level.player_respawn[_id_AC0E594AC96AA3A8] = _id_EE13026B48E61129[_id_AC0E594AC96AA3A8];
    }
  }

  _id_064D1449EC4E9520 = undefined;

  foreach(player in level.players) {
    if(!isalive(player) || player isspectatingplayer() || istrue(player.inlaststand)) {
      if(player getbeingrevivedinternal()) {
        _id_064D1449EC4E9520 = "player_revived_while_resetting_revives_done";
        thread _id_2C44CC8CEDD35D79(player);
        continue;
      }

      thread _id_3BE088A84D31A495(player);
    }
  }

  if(isDefined(_id_064D1449EC4E9520))
    level waittill(_id_064D1449EC4E9520);
  else
    waitframe();

  level._id_F63478BCA59E2670 = getdvarint("dvar_AAE8E9A472853241", 3);
  level._id_A80E6D45222F9A47 = level._id_F63478BCA59E2670;
  scripts\cp\cp_gameskill::_id_3898E5F82C5C37DF(istrue(_id_440FA28F4FE729DD));
}

_id_2C44CC8CEDD35D79(player) {
  level endon("game_ended");
  result = player scripts\engine\utility::waittill_any_return_2("revive_success", "last_stand_bleedout");

  if(result == "revive_success") {
    level._id_F63478BCA59E2670 = getdvarint("dvar_AAE8E9A472853241", 3);
    level._id_A80E6D45222F9A47 = level._id_F63478BCA59E2670;
  }

  level notify("player_revived_while_resetting_revives_done");
}

_id_3BE088A84D31A495(player) {
  level endon("game_ended");
  player endon("disconnect");
  _id_7956D96AF822A9A3(player);

  while(!isalive(player) || player isspectatingplayer() || istrue(player.inlaststand))
    waitframe();

  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 1, 0);
  wait 1;
  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 0, 1.1);
  player setOrigin(level.player_respawn[player.respawn_index].origin, 1, 1);
  player setplayerangles(level.player_respawn[player.respawn_index].angles);
}

_id_1C22CBC2D69134C3() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++)
    level.players[_id_AC0E594AC96AA3A8].respawn_index = _id_AC0E594AC96AA3A8;
}

_id_10A17AA507F07BD8() {
  if(scripts\engine\utility::flag("revive_tokens_disabled"))
    return 0;

  return 1;
}

_id_5AD98C689425D831() {
  if(!scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8() || scripts\cp\cp_gameskill::_id_E22F3955AB0D2E8D()) {
    return;
  }
  level._id_A80E6D45222F9A47 = int(level._id_A80E6D45222F9A47);
  _id_9597C3281050A3D8();
}

_id_9D24182B90507AA9() {
  if(!scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
    return 0;

  if(!isDefined(level._id_A80E6D45222F9A47))
    return 1;

  if(level._id_A80E6D45222F9A47 <= 0)
    return 1;

  return 0;
}

_id_BAFDB6475A34D95B(timeout) {
  self endon("disconnect");
  wait(timeout);
  self clearhudtutorialmessage();
}

_id_B18E576EBE57115E() {
  if(!scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
    return;
  }
  if(!_id_10A17AA507F07BD8()) {
    return;
  }
  if(istrue(self._id_0D308E15BA4E0C84)) {
    return;
  }
  self._id_0D308E15BA4E0C84 = 1;
  thread _id_CF26E1B56AE7980B();
}

_id_CF26E1B56AE7980B() {
  self endon("disconnect");
  wait 2;
  self setclientomnvar("ui_limited_revives_active", 2);

  if(level._id_F63478BCA59E2670 > 0)
    _id_2F614FB812A9FE19 = (level._id_A80E6D45222F9A47 + 1) / level._id_F63478BCA59E2670;
  else
    _id_2F614FB812A9FE19 = 0;

  self setclientomnvar("ui_revives_left", _id_2F614FB812A9FE19);
}

_id_9597C3281050A3D8(_id_C7CAC0D22B84DAEE) {
  if(!scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
    return;
  }
  if(!_id_10A17AA507F07BD8()) {
    return;
  }
  if(!isDefined(_id_C7CAC0D22B84DAEE))
    _id_C7CAC0D22B84DAEE = 1;

  _id_EF1EFB2663D51F22 = level._id_A80E6D45222F9A47 / level._id_F63478BCA59E2670;
  level._id_A80E6D45222F9A47 = level._id_A80E6D45222F9A47 - _id_C7CAC0D22B84DAEE;
  level._id_A80E6D45222F9A47 = max(0, level._id_A80E6D45222F9A47);
  _id_2F614FB812A9FE19 = level._id_A80E6D45222F9A47 / level._id_F63478BCA59E2670;
  scripts\cp\cp_gameskill::_id_3898E5F82C5C37DF(0);
}

_id_719A703850A98E7A() {
  objstruct = spawnStruct();
  objstruct._id_24852C22989CCFC5 = &"COOP_GAME_PLAY/HARDMODE_REVIVES_LEFT";
  objstruct._id_B00949364009D589 = &"COOP_GAME_PLAY/HARDMODE_OXYMASK_LEFT";
  return objstruct;
}

_id_A245AA068AAD0C25(_id_E1D097C517C3AF5B) {
  if(!isDefined(_id_E1D097C517C3AF5B))
    _id_E1D097C517C3AF5B = 3;

  if(_id_E1D097C517C3AF5B < 1 || _id_E1D097C517C3AF5B > 4) {
    return;
  }
  foreach(player in level.players)
  player setclientdvar(_func_2EF675C13CA1C4AF("cp_objective_sub_", _id_E1D097C517C3AF5B, "_desc"), "");
}

_id_4FE89278A6B193B2(_id_22F7E2F7E3607528) {
  if(istrue(_id_22F7E2F7E3607528)) {
    if(scripts\cp_mp\utility\game_utility::_id_D2D2B803A7B741A4()) {
      if(!self isnightvisionon())
        self nightvisionviewon(1);
    }
  }
}
/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2024.gsc
*************************************************/

init() {
  scripts\mp\playeractions::_id_C23B("laststand", ["usability", "weapon_switch", "supers", "gesture", "killstreaks", "offhand_primary_weapons", "offhand_secondary_weapons", "offhand_weapons"]);
  scripts\mp\playeractions::_id_C23B("laststand_killstreak", ["usability", "weapon_switch", "gesture", "killstreaks", "supers", "fire", "melee", "offhand_primary_weapons", "offhand_secondary_weapons"]);
  scripts\mp\playeractions::_id_C23B("laststand_revive", ["allow_movement", "weapon_switch", "usability", "reload", "fire", "offhand_weapons", "offhand_primary_weapons", "offhand_secondary_weapons", "killstreaks", "supers", "gesture", "allow_jump", "sprint", "melee"]);
  level._id_9089 = [];

  if(_func_0127()) {} else {
    scripts\mp\utility\game::_id_C26C(50);
    scripts\mp\utility\game::_id_C26F(30);
    scripts\mp\utility\game::_id_C272(10);
    scripts\mp\utility\game::_id_C26D(1);
    scripts\mp\utility\game::_id_C271(5);
    scripts\mp\utility\game::_id_C270(10);
    scripts\mp\utility\game::_id_C274("s4_me_fists_mp_ls");
    scripts\mp\utility\game::_id_C26E(0);
    scripts\mp\utility\game::_id_C273(0);
  }

  level._id_9072 = scripts\mp\utility\dvars::_id_6BFD(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_lastStandHealth"), "#x337da612b146aa5a1");
  level._id_908A = scripts\mp\utility\dvars::_id_6BFD(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_lastStandReviveHealth"), "#x348fdfb7cf90ff4ec");

  if(level._id_9072 > scripts\mp\tweakables::_id_6E14("player", "maxhealth")) {
    level._id_9072 = scripts\mp\tweakables::_id_6E14("player", "maxhealth");
  }

  if(level._id_908A > scripts\mp\tweakables::_id_6E14("player", "maxhealth")) {
    level._id_908A = scripts\mp\tweakables::_id_6E14("player", "maxhealth");
  }

  level._id_9077 = scripts\mp\utility\dvars::_id_6BFB(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_lastStandInvulnTime"), "#x31a4b22861962ddc2");
  level._id_9087 = scripts\mp\utility\dvars::_id_6BFB(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_lastStandReviveDecayScale"), "#x3ddf72be9f5e56f0e");
  level._id_908B = scripts\mp\utility\dvars::_id_6BFB(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_lastStandReviveTimer"), "#x315a01447b51a268f");
  level._id_908C = scripts\mp\utility\dvars::_id_6BFB(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_lastStandSuicideTimer"), "#x3537260a672d8d7c2");
  level._id_908E = scripts\mp\utility\dvars::_id_6BFB(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_lastStandTimer"), "#x38805b9fa0b0f283c");
  level._id_9093 = scripts\mp\utility\dvars::_id_6BF9(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_lastStandWeapon"), "#x335e942742776937");
  level._id_9095 = scripts\mp\utility\dvars::_id_6BFB(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_lastStandWeaponDelay"), "#x35210e6d0c89a7a26");
  setdvarifuninitialized("#x34118f0ef11d9d5d8", 0);
  setdvarifuninitialized("#x3b9b92953fe1117d9", 0.3);
  level thread _id_907D();
}

_id_908D() {
  level endon("game_ended");
  _id_AAC4();
  var_0 = scripts\engine\utility::_id_108A2("last_stand_heal_success", "last_stand_revived", "last_stand_bleedout", "death_or_disconnect", "last_stand_self_revive");

  switch (var_0) {
    case "last_stand_revived":
      _id_AB8D();
      break;
    case "last_stand_self_revive":
      _id_AB8D(1);
      break;
    case "last_stand_bleedout":
      _id_AA7A();
      break;
    case "last_stand_heal_success":
      _id_AB8D(0, 1);
      break;
    case "death_or_disconnect":
      if(!((scripts\mp\utility\game::_id_8A95() || scripts\mp\utility\game::getgametype() == "br") && _id_07D1::_id_60BE("prematch_done"))) {
        _id_AAA4();
      }

      break;
  }

  if(isDefined(self)) {
    self setclientomnvar("ui_is_laststand", 0);
  }
}

_id_AAC4() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self endon("last_stand_finished");
  self notify("last_stand_start");
  self setclientomnvar("ui_is_laststand", 1);
  level thread scripts\mp\battlechatter_mp::_id_F759(self, "player_last_stand", 0.25);
  var_0 = level._id_9072;

  if(level.gametype == "br") {
    thread _id_8F66();
  }

  self.health = var_0;
  thread _id_99F9();
  scripts\mp\utility\perk::_id_6FC2("specialty_block_health_regen");
  self.inlaststand = 1;
  self._id_B6BF = undefined;
  self._id_75B0 = 0;

  if(level.gametype == "br" && !istrue(self._id_75AF)) {
    if(isDefined(level._id_350A)) {
      [[level._id_350A]]();
    }
  }

  self._id_9083 = _id_0A95::_id_6AF9();

  if(scripts\mp\utility\game::getgametype() == "br") {
    scripts\common\utility::_id_1594(0);

    if(!istrue(self._id_7262)) {
      foreach(var_2 in level._id_EF6A[self.team]["alivePlayers"]) {
        if(!isDefined(var_2)) {
          continue;
        }
        if(var_2 != self) {
          var_2 thread scripts\mp\hud_message::showsplash("br_teammate_down", undefined, self);
        }
      }
    }
  }

  if(!isnullweapon(self getheldoffhand())) {
    thread _id_0A0D::_id_61A2();
  }

  var_4 = level._id_9093;

  if(isDefined(level._id_9094) && getdvarint("#x35b9c2e5794f6d63a", 0)) {
    var_4 = self[[level._id_9094]]();
  }

  if(!isweapon(var_4)) {
    var_4 = makeweapon(var_4);
  }

  self _meth_8655();

  if(self _meth_8683()) {
    self _meth_8656();
  }

  if(istrue(self._id_8DD9) && isDefined(level._id_8DB6)) {
    self[[level._id_8DB6]]();
  } else {
    if(isDefined(level._id_9FE7)) {
      self[[level._id_9FE7]]();
    }

    if(isDefined(level._id_9359)) {
      self thread[[level._id_9359]]();
    }

    if(isDefined(level._id_4276)) {
      self._id_905F = level._id_4276;
    } else {
      self._id_905F = "laststand";
    }

    if(isDefined(self.vehicle)) {
      self waittill("vehicle_exit");
    }

    scripts\mp\playeractions::_id_1596(self._id_905F, 0);
    thread _id_7466(var_4);

    if(isDefined(level._id_10DE)) {
      self[[level._id_10DE]]();
    } else {
      _id_110B();
    }

    var_5 = level._id_908C;
    _id_09C8::_id_0CF9("last_stand_mp", "damage", var_5, 0);
    thread _id_C7EA(self);
    self._id_59BC = getdvarfloat("#x35d47c1e220ab843a", 0);
    _id_07BC::_id_E901("alive_not_downed");

    if(isDefined(self._id_9060)) {
      self._id_9060 _id_0A6B::_id_C1B6();
    }

    if(scripts\mp\utility\game::getgametype() != "br") {
      childthread _id_EA92(var_5);
      return;
    }

    if(isDefined(self._id_2ABC)) {
      var_6 = "outline_nodepth_brplayer" + self._id_2ABC;
      self._id_9084 = scripts\mp\utility\outline::_id_ACD2(self, self.team, var_6, "laststand");
    }

    childthread _id_4C57();
  }
}

_id_8F66() {
  if(!istrue(self._id_4409)) {
    self._id_4409 = 1;
    self _meth_83EF("sys_deaths_door_exit");
    self playlocalsound("sys_deaths_door_intro_impact");
    self _meth_867F("deaths_door_mp", 0.2, 1);
    self enableplayerbreathsystem(0);
    thread scripts\mp\healthoverlay::_id_B669();
  }
}

_id_7466(var_0) {
  self endon("death_or_disconnect");
  self endon("last_stand_finished");
  level endon("game_ended");
  var_1 = makeweapon("s4_gunless");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1, undefined, undefined, 0);
  thread scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_1);
  wait 1.7;
  self notify("last_stand_transition_done");
  scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1);

  if(!isweapon(var_0) && (var_0 == "none" || var_0 == "s4_me_fists_mp_ls")) {
    _id_6F8F();
  } else {
    var_2 = level._id_9095;

    if(var_2 > 0) {
      thread _id_7465(var_2, var_0);
    } else {
      _id_6FB0(var_0);
    }
  }
}

_id_7465(var_0, var_1) {
  self endon("death");
  self endon("last_stand_revived");
  level endon("game_ended");
  var_2 = _id_6F8F();

  if(issameweapon(var_2, var_1)) {
    return;
  }
  wait(var_0);
  self notify("end_switchToFists");
  scripts\cp_mp\utility\inventory_utility::_takeweapon(var_2);
  _id_6FB0(var_1);
}

_id_6F8F() {
  var_0 = scripts\mp\utility\dvars::getwatcheddvar("lastStandWeapon");

  if(!isDefined(var_0)) {
    var_0 = "s4_me_fists_mp_ls";
  }

  var_1 = makeweapon(var_0);
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1, undefined, undefined, 1);
  thread scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_1);
  return var_1;
}

_id_6FB0(var_0) {
  if(!isweapon(var_0)) {
    var_0 = scripts\mp\class::buildweapon(var_0);
  }

  var_1 = getcompleteweaponname(var_0);

  if(!self hasweapon(var_1)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0, undefined, undefined, 1);
  }

  thread scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_1);
}

_id_4AFE(var_0) {
  level endon("game_ended");
  scripts\common\utility::_id_158D(0);
  scripts\engine\utility::_id_108A7(var_0, "death_or_disconnect");
  scripts\common\utility::_id_158D(1);
}

_id_EC3A(var_0) {
  self endon("death_or_disconnect");
  self endon("end_switchToFists");

  while(scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, 1) == 0) {
    waitframe();
  }
}

_id_4C57() {
  self endon("laststand_revived");
  self endon("disconnect");
  self endon("squad_wipe_death");
  var_0 = level._id_9072;
  var_1 = level._id_908E;

  if(var_1 <= 0) {
    _id_AA7A();
    return;
  }

  var_2 = float(var_0) / float(var_1);

  if(getdvarfloat("#x39fcadfd30a990181", 0) > 0) {
    var_2 = var_2 * getdvarfloat("#x39fcadfd30a990181", 0);
  }

  wait 1.0;
  var_3 = makeweapon("s4_gunless");
  thread _id_EAF4();
  var_4 = 0.0;

  while(self.health > 0) {
    if(self _meth_86C9()) {
      wait 1.0;
      continue;
    }

    if(!istrue(scripts\mp\playerlogic::_id_690A())) {
      var_5 = int(var_4 + var_2) - int(var_4);
      var_4 = var_4 + var_2;
      self._id_8901 = 1;
      self dodamage(var_5, self.origin, self, undefined, "MOD_TRIGGER_HURT", var_3, "none");
      self._id_8901 = undefined;
    }

    if(self.health <= 0) {
      _id_AA7A();
    }

    wait 1.0;
  }
}

_id_EA92(var_0) {
  self._id_EA91 = 1;
  wait(var_0);
  self._id_EA91 = 0;

  if(scripts\mp\utility\perk::_hasperk("specialty_survivor") && getdvarint("#x389465c9e5fd57277") != 1) {
    var_1 = level._id_908E;
  } else {
    var_1 = level._id_908E;
  }

  if(!isDefined(var_1)) {
    var_1 = level._id_908E;
  }

  if(scripts\mp\utility\game::getgametype() == "br") {}

  self._id_F283 = var_1;
  thread _id_254A();
  thread _id_EAF4();
}

_id_D087(var_0) {
  if(var_0 usinggamepad()) {
    return var_0 _meth_876F();
  } else {
    return var_0 _meth_879C();
  }
}

_id_D089() {
  var_0 = self;
  var_1 = var_0.owner;
  level endon("game_ended");
  var_0 endon("death");
  var_1 endon("death_or_disconnect");
  var_1 endon("last_stand_revived");
  var_2 = scripts\mp\utility\dvars::getwatcheddvar("lastStandReviveTimer") * 1000;

  if(scripts\mp\utility\game::getgametype() == "br" && var_1 scripts\mp\utility\perk::_hasperk("specialty_br_faster_revive")) {
    var_2 = var_2 * 0.75;
  }

  var_0._id_FEE7 = var_2;

  if(!isDefined(self._id_4143)) {
    self._id_4143 = 0;
  }

  for(;;) {
    if(_id_D087(var_1) && !istrue(var_1._id_8A25) && var_1 isonground()) {
      var_0 notify("self_revive_start");
      var_1 _meth_8797(1);
      var_0 thread _id_D088();
    }

    waitframe();
  }
}

_id_D088() {
  var_0 = self.owner;
  var_1 = self;
  level endon("game_ended");
  var_0 endon("death_or_disconnect");
  var_0 endon("last_stand_finished");
  var_1._id_10846 = 0;
  var_1 thread _id_D086();

  while(scripts\mp\utility\player::isreallyalive(var_0) && _id_D087(var_0) && var_1._id_4143 < var_1._id_FEE7) {
    while(!var_0 isonground() && _id_D087(var_0)) {
      waitframe();
    }

    if(!_id_D087(var_0)) {
      break;
    }

    if(var_0 _meth_86C9()) {
      break;
    }

    if(!istrue(var_0._id_8A25)) {
      var_0 thread scripts\mp\gametypes\br_public::_id_B741("iw8_ges_plyr_self_revive", 10);

      if(!istrue(var_0._id_E845)) {
        var_0 attach("offhand_wm_stim", "tag_accessory_left");
        var_0._id_E845 = 1;
      }

      var_0._id_8A25 = 1;
      var_0 allowmovement(0);
    }

    if(!isDefined(var_1._id_FEB1)) {
      var_1._id_FEB1 = 0;
    }

    if(istrue(var_0._id_24C7)) {
      var_0 setclientomnvar("ui_securing", 6);
      break;
    }

    if(!var_0 isonground()) {
      break;
    }

    var_1._id_4143 = var_1._id_4143 + level._id_01E2 * var_1._id_FEB1;
    var_1._id_FEB1 = 1;
    var_0 _id_07D6::_id_FD75(var_1, 1);

    if(var_1._id_4143 >= var_1._id_FEE7) {
      var_0 _meth_8494("ges_equip_stim_self_revive");
      wait 0.5;

      if(scripts\mp\utility\game::getgametype() == "br") {
        scripts\mp\gametypes\br_analytics::_id_2B08(var_0);
      }

      var_0 _id_5B1D("self_revive_success", var_0);
      var_0 scripts\mp\gametypes\br_pickups::_id_C519();
      return;
    }

    waitframe();
  }

  if(!istrue(var_0._id_24C7)) {
    scripts\mp\gametypes\br::_id_FD3E(var_0, var_0, var_1._id_4143, 1);
    var_1 thread _id_450F();
  }

  var_0 notify("stopped_self_revive");
}

_id_D086() {
  var_0 = self.owner;
  var_1 = self;
  level endon("game_ended");
  var_0 notify("self_revive_cleanup_start");
  var_0 endon("self_revive_cleanup_start");
  var_0 scripts\engine\utility::_id_108A0("last_stand_finished", "stopped_self_revive", "death_or_disconnect");

  if(!istrue(var_0._id_24C7)) {
    var_0 _id_07D6::_id_FD75(var_1, 0);
  }

  var_0 allowmovement(1);

  if(istrue(var_0._id_E845)) {
    var_0 detach("offhand_wm_stim", "tag_accessory_left");
    var_0._id_E845 = 0;
  }

  var_0 _meth_8494("ges_equip_stim_self_revive");
  var_0 _meth_8797(0);
  var_0._id_8A25 = 0;
}

_id_AADE(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self._id_905F = undefined;
  thread _id_3951();
  self._id_59BC = 0;
  scripts\mp\weapons::_id_FCCC();

  if(scripts\mp\utility\perk::_hasperk("specialty_block_health_regen")) {
    scripts\mp\utility\perk::removeperk("specialty_block_health_regen");
  }

  var_1 = level._id_9093;
  var_1 = makeweapon(var_1);

  if(self getcurrentprimaryweapon() != var_1) {
    self notify("end_switchToFists");
    scripts\cp_mp\utility\inventory_utility::_id_0E0C(var_1);
  } else
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1);

  self notify("last_stand_finished");
  self._id_9082 = undefined;

  if(istrue(scripts\mp\playerlogic::_id_690A())) {
    scripts\mp\playerlogic::_id_D496(0);
  }

  if(level.gametype == "br") {
    scripts\mp\gametypes\br::_id_FD3E(self, self, 0, 1);
    scripts\mp\gametypes\br_public::_id_D659(0);
    self._id_2B56 = undefined;
  }

  _id_0A99::_id_D5EA(0);

  if(isDefined(level._id_9FE6)) {
    self[[level._id_9FE6]](var_0);
  }

  waittillframeend;
  self.inlaststand = 0;
}

_id_AB8D(var_0, var_1) {
  var_2 = self._id_9083;
  scripts\common\utility::_id_158B(1);
  scripts\common\utility::_id_152F(1);

  if(getDvar("#x3f59526763711edc4", "") == "dmz") {
    scripts\mp\gametypes\br_plunder::_id_B92B(self, 1, 1);
  }

  if(isDefined(self._id_905F)) {
    scripts\mp\playeractions::_id_1596(self._id_905F, 1);
  }

  _id_AADE(1);
  self _meth_8206();
  self notify("laststand_revived");
  var_3 = level._id_9093;

  if(var_3 != "none") {
    thread scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_2, 1);
  }

  if(!istrue(var_1)) {
    var_4 = level._id_908A;

    if(!getdvarint("#x37ca5a72b0ebcab85") || self.health < level._id_908A) {
      self.health = level._id_908A;
    }
  } else
    self.health = self.maxhealth;

  if(game["state"] == "postgame") {
    scripts\mp\gamelogic::_id_5F64();
  }

  scripts\mp\playerlogic::_id_D496(0);

  if(scripts\mp\utility\game::getgametype() == "br" && !istrue(self._id_7262)) {
    scripts\common\utility::_id_1594(1);

    foreach(var_6 in level._id_EF6A[self.team]["alivePlayers"]) {
      if(!isDefined(var_6)) {
        continue;
      }
      if(var_6 != self) {
        var_6 thread scripts\mp\hud_message::showsplash("br_teammate_revived", undefined, self);
      }
    }
  }

  _id_09C8::_id_0D89();

  if(istrue(var_0) && istrue(level._id_15D2)) {
    _id_15D2(0);
  }
}

_id_AA7A() {
  if(!isDefined(self)) {
    return;
  }
  thread _id_AADE();
  _id_5023();

  if(isDefined(self._id_9060)) {
    self._id_9060 thread scripts\mp\rank::_id_CC00("kill_confirmed");
  }

  if(level.gametype == "br") {
    if(!istrue(level.gameended)) {
      self._id_4409 = 0;
      self _meth_8680("deaths_door_mp");
      self playlocalsound("deaths_door_death");
      self enableplayerbreathsystem(0);
    }
  }

  _id_0A8B::_id_0D8A();
}

_id_AAA4(var_0) {
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(var_0) && isDefined(self._id_9060) && istrue(self._id_9060.inlaststand)) {
    self._id_9060 thread _id_AB1E(var_0, self._id_907C, self._id_9096);
  }

  if(istrue(self._id_8A25)) {
    self notify("stopped_self_revive");
  }

  if(level.gametype == "br") {
    if(!istrue(level.gameended)) {
      self._id_4409 = 0;
      self _meth_8680("deaths_door_mp");
      self playlocalsound("deaths_door_death");
      self enableplayerbreathsystem(0);
    }
  }

  thread _id_AADE();
  _id_5023();
}

_id_5023() {
  if(isDefined(self._id_32EC)) {
    self._id_32EC thread _id_07D6::_id_D537();
  }
}

_id_C7EA(var_0) {
  var_0 endon("death_or_disconnect");
  level endon("game_ended");
  var_0 waittill("last_stand_transition_done");
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("tag_origin");
  var_1 setcursorhint("HINT_NOICON");
  var_1 _meth_84D1(1);
  var_1 setuseholdduration("duration_none");
  var_1 sethintstring(&"MP/LASTSTAND_REVIVE_USE");
  var_1 _meth_83A1(-2);
  var_2 = var_0.team;
  var_1 linkto(var_0, "tag_origin", (0, 0, 2), (0, 0, 0));
  var_1.owner = var_0;
  var_1._id_84EF = 0;
  var_1._id_7C8C = "laststand_reviver";
  var_1.trigger = spawnStruct();
  var_1.trigger.owner = var_0;
  var_1.trigger._id_7C8C = "laststand_reviver";
  var_1 makeuseable();
  var_1 thread _id_F436(var_2);
  var_1 thread _id_C7F9(var_2);
  var_1 thread _id_5343();

  if(getdvarint("#x37a5078a3608358c2", 0) && getdvarint("#x35b9c2e5794f6d63a", 0)) {
    var_0 thread _id_CFF3();
  }

  var_0._id_9088 = var_1;
  level._id_9089[var_1 getentitynumber()] = var_1;
  var_1 thread _id_C515();

  if(var_0 scripts\mp\gametypes\br_public::_id_75AF()) {
    var_0._id_9088 _id_D089();
  }
}

_id_CFF3() {
  var_0 = self;
  var_0 endon("death_or_disconnect");
  var_0 endon("last_stand_finished");
  level endon("game_ended");
  var_1 = gettime();
  var_0 waittill("killed_enemy_in_last_stand", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

  for(;;) {
    if(var_9) {
      var_0 waittill("killed_enemy_in_last_stand", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
      continue;
    }

    break;
  }

  var_11 = var_2._id_9060;

  if(!isDefined(var_11)) {
    var_11 = var_2;
  }

  var_12 = isDefined(var_11) && var_11 != var_0;
  var_13 = var_9;
  var_14 = var_10 || isDefined(var_3) && var_3 getentitynumber() == _func_027F();
  var_15 = gettime() - var_1;
  var_16 = float(var_15 / 1000.0);

  if(scripts\mp\utility\game::getgametype() == "br") {
    scripts\mp\gametypes\br_analytics::_id_2B07(var_0, var_11, var_2, var_5, var_6, var_7, var_8, var_12, var_13, var_14, var_16);
  }

  var_0 _id_5B1D("self_revive_on_kill_success", var_0);
  var_0 thread scripts\mp\hud_message::showsplash("br_second_wind");
  var_17 = scripts\mp\utility\teams::_id_6DCA(var_0.team, "players");

  foreach(var_19 in var_17) {
    if(var_19 != var_0 && isalive(var_19)) {
      var_19 thread scripts\mp\hud_message::showsplash("br_teammate_second_wind", undefined, var_0);
    }
  }
}

_id_AB1E(var_0, var_1, var_2) {
  var_3 = var_0._id_103C2;
  var_4 = var_0.inflictor;
  var_5 = var_0.objweapon;
  var_6 = var_0._id_9CD6;
  var_7 = var_0._id_10D86;
  var_8 = var_0.attacker != self;
  var_9 = istrue(var_0._id_1D2B);
  var_10 = undefined;

  if(isDefined(var_2)) {
    var_10 = getcompleteweaponname(var_2);
  }

  self notify("killed_enemy_in_last_stand", var_3, var_4, var_5, var_6, var_7, var_1, var_10, var_8, var_9);
}

_id_5343() {
  self endon("death");
  self.owner scripts\engine\utility::waittill_any_3("death_or_disconnect", "last_stand_finished", "last_stand_heal_active");
  self delete();
}

_id_C515() {
  level endon("game_ended");
  var_0 = self getentitynumber();
  self waittill("death");
  level._id_9089[var_0] = undefined;
}

_id_FD79(var_0) {
  foreach(var_2 in level.players) {
    if(var_0 == var_2.team && var_2 != self.owner && !istrue(var_2 scripts\mp\utility\perk::_hasperk("specialty_revive_use_weapon"))) {
      self _meth_80E0(var_2);
    } else {
      self disableplayeruse(var_2);
    }

    if(istrue(var_2 scripts\mp\utility\perk::_hasperk("specialty_revive_use_weapon"))) {
      var_2._id_7888[self getentitynumber()] = self;
    }
  }
}

_id_F436(var_0) {
  self endon("death");
  self.owner endon("last_stand_finished");

  for(;;) {
    _id_FD79(var_0);
    level waittill("joined_team");
  }
}

_id_C7F9(var_0) {
  self.owner endon("last_stand_finished");
  self.owner endon("last_stand_heal_active");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_1);

    while(!var_1 isonground() && var_1 usebuttonpressed() || istrue(var_1._id_EF84)) {
      waitframe();
    }

    if(!var_1 usebuttonpressed()) {
      continue;
    }
    self.owner scripts\mp\playerlogic::_id_D496(1);
    var_2 = 0;
    self.owner notify("handle_revive_message");
    self makeunusable();
    self.owner allowmovement(0);
    var_1 _meth_8796(1);
    var_1._id_C7FB = 1;
    thread _id_FE7D(var_1);
    var_1 thread _id_EC3D(self.owner);

    if(level.gametype == "br") {
      self.owner scripts\mp\gametypes\br_public::_id_D659(1);
    }

    var_3 = scripts\engine\utility::_id_108A0("use_hold_revive_success", "use_hold_revive_fail", "death_or_disconnect");

    if(var_3 == "use_hold_revive_success") {
      var_2 = 1;
    }

    var_1 notify("finish_buddy_reviving");
    self.owner scripts\mp\playerlogic::_id_D496(0);
    var_2 = self.owner _id_5B1D(var_3, var_1);

    if(var_2) {
      return;
    }
    thread _id_450F();
    self makeuseable();
    _id_FD79(var_0);
  }
}

_id_EC3D(var_0) {
  var_1 = self;
  var_2 = makeweapon("teammate_revive_stim_mp");
  var_3 = var_1 scripts\cp_mp\utility\killstreak_utility::_id_4056("", var_1);
  var_3._id_C7FA = var_2;
  var_4 = var_1 _id_09B9::_id_EC37(var_2, var_3, ::_id_EF86, undefined, ::_id_ABBC, undefined, ::_id_ABBD, 0);
  var_1 thread _id_10B03();
  var_1 thread _id_10B58(var_0);
  var_1 thread _id_EF85();
}

_id_ABBC(var_0, var_1) {
  var_2 = self;
  var_2 disableweaponswitch();
}

_id_ABBD(var_0, var_1) {
  var_2 = self;
  var_2 enableweaponswitch();
  var_2 notify("revive_stim_finished");
}

_id_EF86(var_0) {
  var_1 = self;
  level endon("game_ended");

  if(!istrue(var_1._id_C7FB)) {
    return;
  }
  var_1 scripts\engine\utility::_id_1089F("death_or_disconnect", "finish_buddy_reviving");
}

_id_10B03() {
  var_0 = self;
  var_0 endon("finish_buddy_reviving");
  var_0 endon("disconnect");
  level endon("game_ended");
  var_0 waittill("death");
  var_0 enableweaponswitch();
}

_id_10B58(var_0) {
  var_1 = self;
  var_1 endon("finish_buddy_reviving");
  var_1 endon("death_or_disconnect");
  level endon("game_ended");
  var_0 waittill("death_or_disconnect");
  var_1 notify("finish_buddy_reviving");
}

_id_EF85() {
  var_0 = self;
  var_0 endon("death_or_disconnect");
  level endon("game_ended");

  if(!isDefined(var_0._id_31BE)) {
    var_0._id_EF84 = 1;
  }

  var_0 waittill("revive_stim_finished");
  var_0._id_EF84 = 0;
}

_id_5B1D(var_0, var_1) {
  var_2 = self;
  var_3 = 0;
  self._id_59BC = 0;
  scripts\mp\weapons::_id_FCCC();

  if(var_0 == "use_hold_revive_success" || var_0 == "self_revive_on_kill_success" || var_0 == "self_revive_success") {
    var_3 = 1;
  }

  var_2._id_24C7 = 0;
  var_2._id_8A25 = 0;

  if(var_0 == "self_revive_success") {
    var_2 _meth_8794();
  }

  if(level.gametype == "br") {
    var_2 scripts\mp\gametypes\br_public::_id_D659(0);
  }

  if(!isalive(var_2)) {
    return 0;
  }

  var_2 allowmovement(1);

  if(var_3) {
    var_2 _id_0A99::_id_D5EA(0);
    var_2 notify("last_stand_revived");

    if(level.gametype == "br") {
      if(!istrue(level.gameended)) {
        var_2 scripts\mp\gametypes\br_public::_id_D65F(0);
        _id_07CE::_id_C7E1(var_1, var_2);
        _id_07BC::_id_AB1F(var_1, var_2);
        var_2 _id_07BC::_id_E68C("alive_not_downed");

        if(var_1 != var_2) {
          var_1 scripts\mp\utility\stats::_id_7DAE("revives", 1);
        }

        var_2._id_4409 = 0;
        var_2 _meth_83EF("sys_deaths_door_intro_impact");
        var_2 playlocalsound("sys_deaths_door_exit");
        var_2 _meth_8680("deaths_door_mp");
        var_2 playlocalsound(scripts\engine\utility::ter_op(scripts\mp\utility\player::_id_8855(), "Fem_breathing_better", "breathing_better"));
        var_2 enableplayerbreathsystem(0);
      }

      if(!scripts\mp\gametypes\br_public::_id_8AB8()) {
        playsoundatpos(var_2.origin, "br_player_revived");
      }

      if(isDefined(self._id_9084)) {
        scripts\mp\utility\outline::outlinedisable(self._id_9084, self);
        self._id_9084 = undefined;
      }
    }

    var_4 = var_2 setstance("crouch");

    if(!var_4) {
      var_4 = var_2 setstance("prone");
    }
  }

  return var_3;
}

_id_450F() {
  self.owner endon("last_stand_finished");
  self.owner endon("last_stand_heal_active");
  self endon("use_hold_revive_start");
  self endon("self_revive_start");
  level endon("game_ended");
  var_0 = level._id_9087;

  if(var_0 <= 0) {
    return;
  }
  for(;;) {
    self._id_4143 = self._id_4143 - level._id_01E2 * var_0;

    if(self._id_4143 <= 0) {
      self._id_4143 = 0;
      return;
    }

    waitframe();
  }
}

_id_FE7D(var_0, var_1) {
  self.owner endon("last_stand_finished");
  var_0 endon("death");
  level endon("game_ended");
  var_2 = self.owner;
  var_3 = getdvarint("#x34118f0ef11d9d5d8");
  var_4 = spawn("script_origin", self.origin);
  var_4 hide();

  if(!var_3) {
    var_0 scripts\mp\playeractions::_id_1596("laststand_revive", 0);
  }

  self notify("use_hold_revive_start");
  var_0 thread _id_D938();

  if(var_3) {
    _id_4ED6(var_0, var_2);
  }

  if(!isDefined(self._id_4143)) {
    self._id_4143 = 0;
  }

  self._id_84EF = 1;
  self._id_FEB1 = 0;
  var_5 = 0;

  if(isDefined(var_1)) {
    self._id_FEE7 = var_1;
  } else if(var_0 scripts\mp\utility\perk::_hasperk("specialty_medic")) {
    self._id_FEE7 = scripts\mp\utility\dvars::getwatcheddvar("lastStandReviveTimer") * 1000 * getdvarfloat("#x32c934f652434d3aa");
  } else {
    self._id_FEE7 = scripts\mp\utility\dvars::getwatcheddvar("lastStandReviveTimer") * 1000;
  }

  if(scripts\mp\utility\game::getgametype() == "br" && var_0 scripts\mp\utility\perk::_hasperk("specialty_br_faster_revive")) {
    self._id_FEE7 = self._id_FEE7 * 0.75;
  }

  level thread scripts\mp\battlechatter_mp::_id_F759(var_0, "reviving");
  thread _id_FE7E(var_0, var_4);
  thread _id_FE7F(var_0);
}

_id_4ED6(var_0, var_1) {
  var_2 = self;
  var_1 playerlinkto(var_0);
  var_1 _meth_8263();
  var_1 allowmovement(0);
  var_0 setmovespeedscale(getdvarfloat("#x3b9b92953fe1117d9"));
}

_id_387E(var_0, var_1) {
  var_1 unlink();
  var_1 allowmovement(1);
  var_0 setmovespeedscale(1);
}

_id_FE7E(var_0, var_1) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  var_2 = getdvarint("#x34118f0ef11d9d5d8");
  var_3 = self.owner;
  var_4 = var_3 scripts\engine\utility::_id_108A1("death_or_disconnect", "use_hold_think_success", "use_hold_think_fail", "last_stand_finished");
  self._id_84EF = 0;
  var_1 delete();
  var_0 _meth_8795();
  var_0 _meth_8796(0);
  var_0._id_C7FB = 0;

  if(isDefined(var_0)) {
    var_0 _id_07D6::_id_FD75(self, 0);
  }

  if(isDefined(var_3)) {
    var_3 _id_07D6::_id_FD75(self, 0);
  }

  if(scripts\mp\utility\player::isreallyalive(var_0)) {
    if(var_2) {
      _id_387E(var_0, var_3);
    } else {
      var_0 scripts\mp\playeractions::_id_1596("laststand_revive", 1);
    }
  }

  var_0 notify("sfx_revive_done");

  if(var_4 == "use_hold_think_success") {
    var_0 thread _id_0A9F::_id_7003("reviver");

    if(istrue(level._id_15D2)) {
      var_0 _id_15D2(1);
    }

    var_3 thread scripts\mp\rank::_id_CC00("revived");
    var_3 thread scripts\mp\hud_message::showsplash("revived", undefined, var_0);
    var_3.inlaststand = 0;
    self notify("use_hold_revive_success");
    return;
  } else if(var_4 == "use_hold_think_fail")
    var_3 notify("handle_revive_message");

  self notify("use_hold_revive_fail");
}

_id_D938() {
  var_0 = spawn("script_origin", self.origin);
  var_0 linkto(self);
  var_0 playLoopSound("br_reviver_use_lp");
  self waittill("sfx_revive_done");
  playsoundatpos(self.origin, "br_reviver_use_end");
  var_0 delete();
}

_id_FE7F(var_0) {
  var_1 = self.owner;
  level endon("game_ended");
  var_1 endon("death_or_disconnect");
  var_1 endon("last_stand_finished");

  while(scripts\mp\utility\player::isreallyalive(var_0) && var_0 usebuttonpressed() && self._id_4143 < self._id_FEE7 && (!isDefined(var_0.inlaststand) || !var_0.inlaststand)) {
    if(istrue(var_0._id_ED19)) {
      return scripts\mp\utility\player::isreallyalive(var_0);
    }

    self._id_4143 = self._id_4143 + level._id_01E2 * self._id_FEB1;
    self._id_FEB1 = 1;
    var_0 _id_07D6::_id_FD75(self, 1);

    if(self._id_4143 >= self._id_FEE7) {
      var_1 notify("use_hold_think_success");
      return;
    }

    waitframe();
  }

  var_1 notify("use_hold_think_fail");
  return;
}

_id_EAF4() {
  self endon("death_or_disconnect");
  self endon("last_stand_finished");
  level endon("game_ended");
  thread _id_DCEB();

  if(!isbot(self)) {
    thread _id_EAF1();
  }

  var_0 = 0;

  for(;;) {
    waitframe();

    if(self stancebuttonpressed() && self _meth_86C9() == 0) {
      var_0 = var_0 + level._id_5F3A;

      if(var_0 >= 0.5) {
        break;
      }
    } else
      var_0 = 0;
  }

  _id_EAF2();
}

_id_EAF1() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self notifyonplayercommand("stance_pressed_down", "+movedown");
  self notifyonplayercommand("stance_pressed_up", "-movedown");
  self notifyonplayercommand("stance_pressed_down", "+stancedown");
  self notifyonplayercommand("stance_pressed_up", "-stancedown");
  var_0 = gettime();
  var_1 = 0;
  var_2 = 0;
  var_3 = 500.0;
  var_4 = 0;

  while(!var_4 && !var_1) {
    var_1 = 0;

    if(!var_2) {
      var_0 = gettime();
    }

    var_5 = scripts\engine\utility::_id_108AB(0.5, "stance_pressed_down", "stance_pressed_up", "last_stand_finished", "last_stand_self_revive", "last_stand_bleedout");

    switch (var_5) {
      case "stance_pressed_down":
        var_0 = gettime();
        var_2 = 1;
        break;
      case "stance_pressed_up":
      case "timeout":
        if(var_2 && gettime() - var_0 >= var_3) {
          var_1 = 1;
        }

        var_2 = 0;
        break;
      default:
        var_4 = 1;
        break;
    }

    waitframe();
  }

  if(var_1) {
    _id_EAF2();
  }

  self _meth_824C("stance_pressed_down", "+movedown");
  self _meth_824C("stance_pressed_up", "-movedown");
  self _meth_824C("stance_pressed_down", "+stancedown");
  self _meth_824C("stance_pressed_up", "-stancedown");
}

_id_EAF2() {
  if(istrue(self._id_15D2)) {
    self notify("last_stand_self_revive");
  } else {
    self notify("last_stand_bleedout");
  }
}

_id_DCEB() {
  if(istrue(self._id_15D2)) {
    self _meth_80FD(&"MP/HEROES_RETURN");
  } else {
    thread _id_748D();
  }

  scripts\engine\utility::_id_10888(self, "death_or_disconnect", self, "last_stand_finished", level, "game_ended");

  if(!isDefined(self)) {
    return;
  }
  _id_0A99::_id_D5EA(0);
  self _meth_80FC();
}

_id_748D() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("last_stand_finished");

  for(;;) {
    _id_0A99::_id_D5EA(0);
    var_0 = 0;
    var_1 = scripts\mp\supers::_id_69B0();

    if(isDefined(var_1) && var_1 == "super_laststand_heal" && scripts\mp\supers::_id_8A7B()) {
      var_0 = 1;
    }

    if(level.gametype == "br") {
      _id_0A99::_id_D5EA(60);

      if(scripts\mp\gametypes\br_public::_id_75AF()) {
        _id_0A99::_id_D5EA(73);
      }
    } else if(istrue(scripts\mp\playerlogic::_id_690A()))
      _id_0A99::_id_D5EA(22);
    else if(istrue(self._id_9070)) {
      _id_0A99::_id_D5EA(23);
    } else if(isDefined(self._id_F283)) {
      if(var_0) {
        _id_0A99::_id_D5EA(19, int(gettime() + self._id_F283 * 1000));
      } else if(scripts\mp\utility\game::getgametype() != "dm") {
        if(self.pers["lives"] == 0 && scripts\mp\utility\game::_id_8A95()) {
          _id_0A99::_id_D5EA(5, int(gettime() + self._id_F283 * 1000));
        } else {
          _id_0A99::_id_D5EA(20, int(gettime() + self._id_F283 * 1000));
        }
      } else
        _id_0A99::_id_D5EA(21, int(gettime() + self._id_F283 * 1000));
    } else if(var_0)
      _id_0A99::_id_D5EA(19, int(gettime() + self._id_F283 * 1000));
    else if(self.pers["lives"] == 0 && scripts\mp\utility\game::_id_8A95()) {
      _id_0A99::_id_D5EA(5);
    } else {
      _id_0A99::_id_D5EA(20, int(gettime() + self._id_F283 * 1000));
    }

    for(;;) {
      var_2 = scripts\engine\utility::_id_1089F("super_ready", "handle_revive_message");

      if(var_2 == "super_ready" && scripts\mp\supers::_id_69B0() != "super_laststand_heal") {
        continue;
      } else {
        break;
      }
    }
  }
}

_id_254A() {
  self endon("death_or_disconnect");
  self endon("last_stand_finished");
  self endon("last_stand_heal_active");
  level endon("game_ended");
  var_0 = self._id_F283;

  if(var_0 != 0) {
    for(;;) {
      waitframe();

      if(self _meth_86C9()) {
        continue;
      }
      if(!istrue(scripts\mp\playerlogic::_id_690A())) {
        var_0 = var_0 - level._id_5F3A;
      }

      if(var_0 <= level._id_5F3A) {
        self notify("last_stand_bleedout");
        break;
      }

      self._id_F283 = var_0;
    }
  }
}

_id_110B() {
  var_0 = self.origin;
  var_1 = newteamhudelem(self.team);
  var_1.x = var_0[0];
  var_1.y = var_0[1];
  var_1._id_050C = var_0[2] + 32;
  var_1.alpha = 1.0;
  var_1.archived = 0;
  var_1.showinkillcam = 0;

  if(level.splitscreen) {
    var_1 setshader("hud_realism_head_revive", 10, 10);
  } else {
    var_1 setshader("hud_realism_head_revive", 5, 5);
  }

  var_1 _meth_83B2(0);
  var_1 _meth_8388(self);
  thread _id_3898(var_1);
}

_id_3898(var_0) {
  self waittill("last_stand_finished");
  var_0 destroy();
}

_id_DCFD() {
  var_0 = getdvarint(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_waverespawndelay")) > 0;

  if(!var_0) {
    return;
  }
  self endon("last_stand_finished");

  for(;;) {
    self._id_C6C5 = gettime();
    var_0 = getdvarint(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_waverespawndelay")) > 0;

    if(var_0) {
      var_1 = scripts\mp\playerlogic::_id_F289(0.0);
      _id_0A99::_id_D5EA(10, int(gettime() + var_1 * 1000));
      wait(var_1);
      _id_0A99::_id_D5EA(0);
    }

    wait 2.0;
  }
}

_id_15D2(var_0) {
  self._id_15D2 = var_0;
  self setclientomnvar("ui_self_revive", var_0);
}

_id_907D() {
  level endon("game_ended");

  if(istrue(level._id_907A)) {
    return;
  }
  for(;;) {
    waitframe();

    if(scripts\mp\utility\game::_id_6A65() == 0 && !istrue(level._id_4AE8)) {
      continue;
    }
    level thread _id_9079();
  }
}

_id_9079() {
  foreach(var_1 in level._id_EF89) {
    var_2 = scripts\mp\utility\teams::_id_6A59(var_1, 1);
    var_3 = [];

    foreach(var_5 in var_2) {
      if(istrue(var_5.inlaststand)) {
        var_3[var_3.size] = var_5;
      }
    }

    if(var_3.size > 0 && var_2.size <= var_3.size) {
      level._id_9086 = 0;

      foreach(var_5 in var_3) {
        if(!isDefined(var_5)) {
          continue;
        }
        var_5 notify("last_stand_bleedout");
      }
    }
  }
}

_id_6961() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    var_3 = weaponclass(var_2);

    if(weaponclass(var_2) == "pistol") {
      return var_2;
    }
  }

  var_2 = scripts\mp\class::buildweapon(scripts\mp\utility\weapon::getweaponrootname("s4_pi_mike1911"), [], "none", "none", -1);
  return var_2;
}

_id_99F9() {
  var_0 = level._id_9077;
  _id_3951();
  self endon("disconnect");
  self endon("clear_last_stand_invuln");
  _id_09BF::_id_10A2("last_stand_invuln", 0, 0, ::_id_9076);
  scripts\engine\utility::_id_108F5("death", var_0);
  thread _id_3951();
}

_id_3951() {
  self notify("clear_last_stand_invuln");
  _id_09BF::_id_C48A("last_stand_invuln", 0);
}

_id_9076(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_4 == "MOD_TRIGGER_HURT") {
    return 1;
  }

  return 0;
}

_id_69D3() {
  return 10;
}

_id_69D2() {
  return 10;
}

_id_6D28(var_0) {
  return var_0 * 1000;
}
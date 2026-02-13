/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2488.gsc
*************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "init")]]();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "registerActionSet")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "registerActionSet")]]();
  }

  level._id_8C87 = spawnStruct();
  level._effect["juggernaut_crate_vfx"] = loadfx("vfx/iw8_mp/killstreak/vfx_jugg_carepackage_smoke.vfx");
  _id_8169();
  _id_821C();
  _id_7FC6();
  setdvarifuninitialized("#x316927453ee978cb1", 1);
  scripts\cp_mp\utility\killstreak_utility::_id_C2C8("juggernaut", "mask_on", 1);
  scripts\cp_mp\utility\killstreak_utility::_id_C2C8("juggernaut", "mask_damage_low", 2);
  scripts\cp_mp\utility\killstreak_utility::_id_C2C8("juggernaut", "mask_damage_med", 3);
  scripts\cp_mp\utility\killstreak_utility::_id_C2C8("juggernaut", "mask_damage_high", 4);
  scripts\cp_mp\utility\killstreak_utility::_id_C2C8("juggernaut", "mask_damage_critical", 5);
}

_id_8169() {
  var_0 = level._id_8C87;
  var_1 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "initConfig")) {
    var_1 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "initConfig")]]();
  }

  var_0._id_3B73 = var_1;
  var_2 = get_mp_juggernaut_health();
  var_1._id_7E8B = 1;
  var_1._id_7E8E = 2.0;
  var_1.maxhealth = var_2;
  var_1._id_E6D3 = var_2;
  var_1._id_EAF7 = "s4_ks_juggernaut_mp";
  var_1._id_39FC = "vestheavy";
  var_1._id_3808._id_9683 = "s4_gw_flima35";
  var_1._id_3808._id_9692 = "none";
}

get_mp_juggernaut_health() {
  if(isDefined(level.mp_juggernaut_health_override)) {
    return level.mp_juggernaut_health_override;
  }

  return getdvarint("#x365eef81ba2af55dc", 1000);
}

_id_821C() {
  var_0 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "levelData")) {
    var_0 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "levelData")]]("juggernaut");
  }

  var_0._id_3227 = ::_id_AA96;
  var_0._id_4841 = ::_id_AA97;
  var_0._id_0EE7 = ::_id_AA95;
  var_0._id_75E9 = "v_ui_icon_killstreak_killstreak11";
  var_0._id_3234 = &"KILLSTREAKS_HINTS/FLAMETHROWER_CRATE_PICKUP";
  var_0._id_5FB8 = "military_carepackage_01_juggernaut";
  var_0._id_5420 = "military_carepackage_01_juggernaut";
}

_id_7FC6() {
  game["dialog"]["juggernaut_normal_breath"] = "juggernaut_breath";
  game["dialog"]["juggernaut_labored_breath"] = "juggernaut_labored_breath";
}

_id_F78E(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::_id_4056("juggernaut", self);
  _id_F78F(var_1, var_0);
}

_id_F78F(var_0, var_1) {
  if(getdvarint("#x330e2f73a30ce25b5", 1) == 0) {
    scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/UNAVAILABLE");
    return 0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "canTriggerJuggernaut")) {
    if(!self[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "canTriggerJuggernaut")]](var_0)) {
      return 0;
    }
  }

  if(isDefined(level._id_8DEB)) {
    if(!level[[level._id_8DEB]](var_0)) {
      return 0;
    }
  }

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_0)) {
      return 0;
    }
  }

  var_2 = getdvarint("#x316927453ee978cb1");

  if(var_2 || istrue(var_1)) {
    thread _id_0EF5(var_0);
  } else {
    scripts\cp_mp\vehicles\vehicle_tracking::_id_C59B();
    var_3 = makeweapon("s4_ks_deploy_flamenaut_mp");
    var_4 = _id_09B9::_id_EA03(var_0, var_3, "grenade_fire", undefined, undefined, ::_id_9B56);

    if(!istrue(var_4)) {
      scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
      return 0;
    }
  }

  return 1;
}

_id_9B56(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "incrementFauxVehicleCount")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "incrementFauxVehicleCount")]]();
  }

  var_2.owner = self;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](var_0.streakname, self.origin);
  }

  var_2 thread _id_10BAA(var_0);
  var_0 notify("killstreak_finished_with_deploy_weapon");
  return "success";
}

_id_10BAA(var_0) {
  level endon("game_ended");
  var_1 = self.owner.angles;
  var_2 = self.owner;
  self waittill("explode", var_3);

  if(!isDefined(var_2)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
    }

    scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
  } else {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "dropCrateFromScriptedHeli")) {
      var_0._id_10315 = 1;
      var_4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "dropCrateFromScriptedHeli")]](var_2, var_2.team, "juggernaut", var_3, var_1, var_1 + (0, 180, 0), var_0);
      var_2 thread scripts\cp_mp\killstreaks\airdrop::_id_1397(var_0, "airdrop");

      if(!isDefined(var_4)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
          var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/VEHICLE_REFUND_KILLSTREAK");
        }

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "awardKillstreakFromStruct")) {
          var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "awardKillstreakFromStruct")]](var_0._id_A2B6);
          return;
        }

        return;
      }

      return;
    }

    scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
  }
}

_id_AA95(var_0) {
  if(istrue(var_0)) {
    playFX(scripts\engine\utility::getfx("juggernaut_crate_vfx"), self.origin);
  }
}

_id_AA96(var_0) {
  var_1 = self._id_4350;

  if(istrue(var_0._id_88DF)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "awardKillstreak")) {
      self.streakinfo = var_1;
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "awardKillstreak")]](var_1.streakname, var_0, self);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "showKillstreakSplash")) {
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "showKillstreakSplash")]](var_1.streakname, undefined, 1);
    }
  } else
    var_0 _id_0EF5(var_1);
}

_id_AA97(var_0) {
  var_1 = self._id_4350;

  if(isDefined(level._id_8DD3)) {
    level[[level._id_8DD3]](var_1);
  }
}

_id_0EF5(var_0) {
  var_1 = level._id_8C87;
  var_2 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "makeJuggernaut")) {
    var_2 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "makeJuggernaut")]](var_1._id_3B73, var_0);
  }

  if(!var_2) {
    return 0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "playOperatorUseLine")) {
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "playOperatorUseLine")]](self);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_flamethrower", self);
  }

  _id_4003();

  if(isDefined(self._id_AC3D._id_6285) && self._id_AC3D._id_6285 == "female") {
    self _meth_84A8("gender", "gasmask_female", 0.1);
  } else {
    self _meth_84A8("gender", "gasmask_male", 0.1);
  }

  if(!(scripts\mp\utility\game::_id_875D() && scripts\mp\gametypes\arena_evo_tourney_util::_id_8602(self))) {
    thread _id_10B1D(var_0);
  }

  thread _id_10B1C(var_0);
  thread _id_10B1B(var_0);
  createspawndangerzone();
}

createspawndangerzone() {
  var_0 = getdvarint("#x3e6b51b05234a5974", 0) == 1;

  if(!var_0) {
    return;
  }
  if(!isalive(self)) {
    return;
  }
  self.spawndangerzone = _id_0817::_id_1135(self.origin, 100, 100, self.team, undefined, self, 0, self, 1, 1);

  if(isDefined(self.spawndangerzone)) {
    _id_0817::influencepoint_linktoent(self.spawndangerzone, self);
  }
}

debugdrawspawndangerzone() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    if(getdvarint("#x3a36be24634e38a1", 0) == 1) {
      var_0 = (1, 0, 0);
      _id_09C0::_id_4F3D(self.origin, 100, 100, 0.05, var_0);
    }

    wait 0.05;
  }
}

_id_506D() {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  var_0 = makeweapon("s4_gw_flima35_mp");
  self giveweapon(var_0);
  var_1 = self dropitem(var_0);

  if(!isDefined(var_1)) {
    self takeallweapons();
    return;
  }

  var_1.objweapon = var_0;
  var_1._id_0481 = "dropped_weapon";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "watchPickup")) {
    var_1 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "watchPickup")]]();
  }

  waitframe();
  self takeallweapons();
}

_id_10B1D(var_0) {
  self endon("disconnect");
  self endon("juggernaut_end");
  level waittill("game_ended");

  if(isDefined(self)) {
    scripts\cp_mp\utility\killstreak_utility::_id_C14A(var_0);
  }
}

_id_10B1C(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_1 = self._id_8C2B;
  self waittill("juggernaut_end");

  if(isDefined(self._id_AC3D)) {
    if(isDefined(self._id_AC3D._id_6285) && self._id_AC3D._id_6285 == "female") {
      self _meth_84A8("gender", "female", 0.1);
    } else {
      self _meth_84A8("gender", "", 0.1);
    }
  }

  _id_AB0C(var_0, var_1);
}

_id_AB0C(var_0, var_1) {
  if(isDefined(level._id_8DD3)) {
    level[[level._id_8DD3]](var_0);
  }

  if(isDefined(self.spawndangerzone)) {
    _id_0817::_id_C51F(self.spawndangerzone);
    self.spawndangerzone = undefined;
  }

  var_0._id_57A7 = 1;
  scripts\cp_mp\utility\killstreak_utility::_id_C14A(var_0);
  _id_388C(var_1);
}

_id_10B1B(var_0) {
  self endon("juggernaut_end");
  level endon("game_ended");
  var_1 = self._id_8C2B;
  self waittill("disconnect");
  _id_388C(var_1);
}

_id_4003() {
  var_0 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "requestObjectiveID")) {
    var_0 = scripts\cp_mp\utility\script_utility::getsharedfunc("game", "requestObjectiveID");
  }

  if(isDefined(var_0)) {
    var_1 = [[var_0]](99);
    self._id_8C2B._id_8C88 = var_1;
    _id_07F9::_id_A867(var_1, "active", self.origin, "v_ui_icon_killstreak_killstreak11");
    _id_07F9::_id_A8B1(var_1, 0);
    _id_07F9::_id_A8B2(var_1, 0);

    if(scripts\mp\utility\game::_id_875D()) {
      var_2 = scripts\mp\gametypes\arena_evo_tourney_util::_id_66A5(scripts\mp\gametypes\arena_evo_tourney_util::_id_6661());
      var_2 = scripts\engine\utility::array_remove(var_2, self);
      _id_07F9::objective_playermask_showtoclientlist(var_1, var_2);
    } else
      _id_07F9::_id_A8A4(var_1, self);

    _id_07F9::_id_FB93(var_1, self);
    _id_07F9::_id_FB98(var_1, 1);
    _id_07F9::_id_FB96(var_1, self.team);
  }
}

_id_388C(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](var_0._id_8C88);
  }
}

_id_10B92(var_0, var_1) {
  self notifyonplayercommand("manual_switch_from_minigun", "+weapnext");
  thread _id_C4D8("switched_from_minigun", var_1);
  thread _id_C4D8("minigun_ammo_depleted", var_1);
  thread _id_C4D8("death");
  thread _id_10B93(var_0);
  thread _id_10B91(var_0);
}

_id_10B93(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("dropped_minigun");
  level endon("game_ended");

  for(;;) {
    scripts\engine\utility::waittill_any_2("manual_switch_from_minigun", "weapon_pickup");

    if(self getcurrentweapon() != var_0) {
      continue;
    }
    self notify("switched_from_minigun");
    break;
  }
}

_id_10B91(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("dropped_minigun");
  level endon("game_ended");

  for(;;) {
    var_1 = self getweaponammoclip(var_0);

    if(var_1 <= 0) {
      self notify("minigun_ammo_depleted");
      break;
    }

    waitframe();
  }
}

_id_C4D8(var_0, var_1) {
  self endon("disconnect");
  self endon("dropped_minigun");
  level endon("game_ended");
  self waittill(var_0);
  _id_5036(var_0, var_1);
}

_id_5036(var_0, var_1) {
  self._id_9F06 = undefined;
  self._id_B7E4 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "updateMoveSpeedScale")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "updateMoveSpeedScale")]]();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "allowActionSet")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "allowActionSet")]]("fakeJugg", 1);
  }

  if(!istrue(level._id_4ACD)) {
    self allowmountside(1);
    self allowmounttop(1);
  }

  var_2 = self getcurrentweapon();

  if(!isDefined(var_2) || var_2.basename == "none") {
    var_2 = makeweapon("s4_gw_flima35_mp");
  }

  if(var_0 == "switched_from_minigun" || var_0 == "used_ammo_box") {
    var_3 = self dropitem(var_2);
    var_3.objweapon = var_2;
    var_3._id_0481 = "dropped_weapon";

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "watchPickup")) {
      var_3 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "watchPickup")]]();
    }
  } else if(var_0 == "minigun_ammo_depleted") {
    if(self hasweapon(var_2)) {
      thread _id_46E3(0.5, var_2);
    }
  }

  if(isDefined(var_1)) {
    self._id_8FC2 = var_1;
    self switchtoweapon(var_1);
  }

  self notify("dropped_minigun");
}

_id_46E3(var_0, var_1) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self takeweapon(var_1);
}
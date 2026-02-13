/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2022.gsc
*************************************************/

init() {
  level._effect["death_explosion_vfx"] = loadfx("vfx/s4/killstreaks/vfx_flamethrower_exp.vfx");
  level._effect["death_explosion_valentines_vfx"] = loadfx("vfx/s4/killstreaks/vfx_valentines_killbear_explosion.vfx");
  game["dialog"]["battlespace_crowded"] = "mp_glob_kill_bchr_tbfu";
}

_id_8C08(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");

  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return 0;
  }

  if(!_id_8BE8(var_0)) {
    return 0;
  }

  self._id_88DF = 1;
  thread _id_07F8::killstreak_flamethrower_music();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var_1.streakname);
  }

  if(!isbot(self)) {
    _id_0A0D::_id_61A5();
  }

  var_2 = spawnStruct();
  var_2._id_8C2A = var_0;
  var_2._id_BC24 = self.health;
  var_2._id_BC4C = self.maxhealth;
  var_2._id_BC11 = self _meth_8128();
  var_2._id_BC23 = self _meth_8129();
  var_2._id_BC6A = self _meth_812C();
  var_2._id_BC62 = self._id_B7E4;
  var_2._id_BC65 = self._id_EAF7;
  var_2._id_BC16 = self._id_39FC;
  var_2._id_9B9E = "ui_gas_mask_juggernaut";
  var_2.prevoperatorcustomization = self._id_AC3D;

  if(isDefined(self._id_AC3D)) {
    var_2._id_BC11 = self._id_AC3D._id_25CA;
    var_2._id_BC23 = self._id_AC3D._id_75DA;
  }

  if(scripts\mp\utility\perk::_hasperk("specialty_reaper") && scripts\cp_mp\utility\killstreak_utility::_id_C0B7("juggernaut")) {
    var_0.maxhealth = var_0.maxhealth * 1.5;
    var_0._id_E6D3 = var_0._id_E6D3 * 1.5;

    foreach(var_5, var_4 in self._id_E9FF._id_EA14) {
      if(var_4.streakname == "juggernaut" && istrue(self._id_E9FF._id_EA14[var_5]._id_C0B4)) {
        self._id_E9FF._id_EA14[var_5]._id_C0B4 = undefined;
      }
    }
  }

  self.maxhealth = int(var_0.maxhealth);
  self.health = int(var_0._id_E6D3);
  self.juggernauttankhealth = 500;
  scripts\mp\weapons::_id_CB54();
  scripts\mp\weapons::_id_CB3F();

  if(isDefined(var_0._id_3808)) {
    self notify("non_temp_weapon_switch");
    waittillframeend;
    var_6 = scripts\mp\class::_id_C6BB();
    var_2._id_C6A7 = var_6;
    var_2._id_BC14 = self._id_8FAF;
    var_2._id_BC15 = self._id_3808;
    scripts\mp\class::_id_963A(var_0._id_3808, "juggernaut");
    scripts\mp\class::_id_BB99(var_0._id_3808, 1, 1);
    scripts\mp\class::_id_6FB1(self.team, "juggernaut", 0, 1, 0, 1);
  }

  foreach(var_9, var_8 in var_0.perks) {
    scripts\mp\utility\perk::_id_6FC2(var_9);
  }

  _id_8C1C(var_0._id_15D1, 0);
  self _meth_86B3(0);
  _id_09BE::_id_525B();
  _id_8C15();
  self._id_B7E4 = var_0._id_A25D;
  scripts\mp\weapons::_id_FCCC();
  scripts\mp\utility\player::_id_0CF0(var_0._id_EAF7);
  self _meth_8300(var_0._id_39FC);

  if(var_0._id_7E8B) {
    thread scripts\mp\utility\weapon::_id_7E8D(var_0._id_7E8E);
  }

  self._id_8C2B = var_2;
  self.streakinfo = var_1;
  self notify("juggernaut_start");
  thread _id_07D6::_id_AB0B();

  if(getdvarint("#x3b2bbc6997be2d2de", 0)) {
    thread _id_8C27();
  }

  thread _id_8C21();
  thread _id_8C25();
  thread jugg_watchforforceend();
  thread _id_8C22();
  thread _id_8C24();
  _id_8BFF(var_0);
  wait 1.0;

  if(!scripts\mp\utility\player::isreallyalive(self) || self.primaryweaponobj.basename != "s4_gw_flima35_mp") {
    return 0;
  }

  _id_8BF8(var_2);
  scripts\mp\battlechatter_mp::_id_4A81(self);
  return 1;
}

_id_8C13() {
  var_0 = self._id_8C2B;
  var_1 = var_0._id_8C2A;
  self._id_A360 = undefined;
  _id_8C1C(var_1._id_15D1, 1);

  if(scripts\mp\utility\player::isreallyalive(self)) {
    self.maxhealth = var_0._id_BC4C;
    self.health = var_0._id_BC24;
    _id_09BE::_id_4ACB();

    if(isDefined(var_1._id_3808)) {
      scripts\mp\class::_id_C6A8(var_0._id_C6A7);
      scripts\mp\class::_id_6FB1(self.team, var_0._id_BC14, 0, 1, 1);
    }

    foreach(var_4, var_3 in var_1.perks) {
      scripts\mp\utility\perk::removeperk(var_4);
    }
  }

  if(var_1._id_7E8B) {
    scripts\mp\utility\weapon::_id_E910();
  }

  _id_8C14(var_0);
  self._id_B7E4 = var_0._id_BC62;
  scripts\mp\weapons::_id_FCCC();
  scripts\mp\utility\player::_id_0CF0(var_0._id_BC65);
  self _meth_8300(var_0._id_BC16);
  _id_8BF5(var_0);
  self setscriptablepartstate("juggernaut", "neutral", 0);
  self._id_88DF = 0;
  self._id_8C2B = undefined;
  self.streakinfo = undefined;
  scripts\mp\battlechatter_mp::_id_523A(self);
  self notify("juggernaut_end");
}

_id_8BED(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.maxhealth = 3000;
  var_2._id_E6D3 = var_2.maxhealth;
  var_2._id_A25D = -0.2;
  var_2._id_5ED1 = 1;
  var_2._id_EAF7 = "s4_juggernaut_mp";
  var_2._id_7E8B = 0;
  var_2._id_7E8E = undefined;
  var_2._id_3808 = _id_8BFB();
  var_2._id_15D1 = [];
  var_2._id_15D1["stick_kill"] = 1;
  var_2._id_15D1["health_regen"] = 1;
  var_2._id_15D1["one_hit_melee_victim"] = 1;
  var_2._id_15D1["flashed"] = 1;
  var_2._id_15D1["stunned"] = 1;
  var_2._id_15D1["prone"] = 1;
  var_2._id_15D1["equipment"] = 1;
  var_2._id_15D1["supers"] = 1;
  var_2._id_15D1["killstreaks"] = 1;
  var_2._id_15D1["slide"] = 1;
  var_2._id_15D1["reload"] = 1;
  var_2._id_15D1["weapon_pickup"] = 1;
  var_2._id_15D1["execution_victim"] = 1;
  var_2._id_15D1["vehicle_use"] = 1;
  var_2._id_15D1["cough_gesture"] = 1;
  var_2._id_15D1["offhand_throwback"] = 1;
  var_2.perks = [];
  var_2.perks["specialty_stun_resistance"] = 1;
  var_2.perks["specialty_sharp_focus"] = 1;
  var_2.perks["specialty_melee_resist_damage"] = 1;
  var_2.perks["specialty_melee_resist_finisher"] = 1;
  var_2.perks["specialty_blastshield"] = 1;
  var_2.perks["specialty_armorpiercing"] = 1;
  return var_2;
}

jugg_damagetank(var_0, var_1, var_2, var_3) {
  self.juggernauttankhealth = self.juggernauttankhealth - var_0;

  if(self.juggernauttankhealth <= 0) {
    self _meth_81FA(var_3, var_1);
  }
}

_id_8C1C(var_0, var_1) {
  foreach(var_4, var_3 in var_0) {
    if(var_3) {
      var_4 = tolower(var_4);
      self thread[[level._id_1542[var_4]]](var_1, "juggernaut");
    }
  }

  if(!istrue(level._id_4ACD)) {
    self allowmountside(0);
    self allowmounttop(0);
  }
}

_id_8BFB() {
  var_0 = scripts\mp\class::_id_962A();
  var_0._id_965F = "archetype_assault";
  var_0._id_9683 = "s4_gw_flima35";
  var_0._id_9692 = "none";
  return var_0;
}

_id_8C27() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("juggernaut_end");
  var_0 = 0;
  self notifyonplayercommand("toggle_music", "+actionslot 3");
  self notifyonplayercommand("toggle_music", "killstreak_wheel");
  var_1 = makeweapon("ks_gesture_jugg_music_mp");
  var_2 = weaponfiretime(var_1);

  if(!isDefined(self._id_A360)) {
    var_3 = self _meth_871D();
    self._id_A360 = var_3;
  }

  if(!istrue(self._id_A360)) {
    self setscriptablepartstate("juggernaut", "neutral", 0);
  } else {
    self setscriptablepartstate("juggernaut", "music", 0);
  }

  for(;;) {
    self waittill("toggle_music");

    if(self isonladder() || self _meth_81CE()) {
      continue;
    }
    self _meth_852A(var_1);
    self _meth_827E("mp_jugg_mus_toggle_foley");
    self playlocalsound("mp_jugg_mus_toggle_button");
    var_4 = 0.2;

    if(istrue(self._id_A360)) {
      var_4 = 0.65;
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_4);

    if(istrue(self._id_A360)) {
      self._id_A360 = 0;
      self setscriptablepartstate("juggernaut", "neutral", 0);
    } else {
      self._id_A360 = 1;
      self setscriptablepartstate("juggernaut", "music", 0);
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1.5);
  }
}

_id_8C21() {
  self endon("juggernaut_end");
  self waittill("death");
  var_0 = self _meth_8122();

  if(scripts\mp\utility\game::isholidayenabled(3)) {
    playFXOnTag(scripts\engine\utility::getfx("death_explosion_valentines_vfx"), var_0, "j_spine4");
  } else {
    playFXOnTag(scripts\engine\utility::getfx("death_explosion_vfx"), var_0, "j_spine4");
  }

  _func_01BA(self.origin, 300, 1000, 1000, self, "MOD_EXPLOSIVE");
  thread _id_084C::flamenaut_death_explosion(var_0);
  _id_8C13();
}

_id_8C25() {
  self endon("juggernaut_end");
  var_0 = self._id_8C2B;
  level waittill("game_ended");
  self.maxhealth = var_0._id_BC4C;
  self.health = var_0._id_BC24;
  _id_8BF5(var_0);
  self setscriptablepartstate("juggernaut", "neutral", 0);
}

jugg_watchforforceend() {
  self endon("juggernaut_end");
  var_0 = self._id_8C2B;
  self waittill("jugg_force_ended");
  _id_8C13();
}

_id_8C22() {
  self endon("juggernaut_end");
  var_0 = self._id_8C2B;
  self waittill("disconnect");

  if(isDefined(self)) {
    self.maxhealth = var_0._id_BC4C;
    self.health = var_0._id_BC24;
  }
}

_id_8C24() {
  self endon("juggernaut_end");

  for(;;) {
    self waittill("weapon_fired");
    self.streakinfo._id_DA63++;
  }
}

_id_8BFC() {
  var_0 = [];

  if(scripts\mp\utility\game::isholidayenabled(3)) {
    var_0["body"] = "c_s4_mp_vbear_01";
    var_0["view"] = "c_s4_vm_mp_vbear_01";
  } else {
    var_0["body"] = "c_s4_usa_juggernaut_01";
    var_0["view"] = "viewhands_juggernaut";
  }

  return var_0;
}

_id_8C15() {
  var_0 = _id_8BFC();

  if(isDefined(self._id_7611)) {
    self detach(self._id_7611);
    self._id_7611 = undefined;
  }

  var_1 = var_0["body"];
  var_2 = var_0["view"];
  self setModel(var_1);
  self _meth_83AB(var_2);
}

_id_8C14(var_0) {
  self._id_AC3D = var_0.prevoperatorcustomization;

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    self _meth_8526(var_0._id_BC11, var_0._id_BC23);
    scripts\mp\teams::_id_D4BE(var_0._id_BC11, var_0._id_BC23, var_0._id_BC6A);
  }
}

_id_8C0B(var_0) {
  var_1 = 0;
  var_2 = self getstance();

  switch (var_2) {
    case "stand":
      var_1 = 0;
      break;
    case "crouch":
      if(var_0._id_5ED1 || !var_0._id_003F) {
        var_1 = 1;
        break;
      }

      break;
    case "prone":
      if(var_0._id_5ED1 || !var_0._id_0045) {
        var_1 = 1;
        break;
      }

      break;
  }

  return var_1;
}

_id_8BE8(var_0) {
  return 1;
}

_id_8BFF(var_0) {
  if(_id_8C0B(var_0)) {
    self setstance("stand");
  }
}

_id_8BF8(var_0) {
  self setclientomnvar(var_0._id_9B9E, 1);
  _id_8BFA();
  thread _id_8C28(var_0);
  thread _id_8C26(var_0);
}

_id_8C28(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_1 = self.health;

  for(;;) {
    self waittill("damage");
    self setclientomnvar("ui_gasmask_damage", self.health / var_1);
  }
}

_id_8C26(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_1 = 0;

  for(;;) {
    if(!self _meth_86C8()) {
      if(istrue(var_1)) {
        self setclientomnvar(var_0._id_9B9E, self._id_8C8A);
        self setclientomnvar("ui_gasmask_damage", self.health / self.maxhealth);
        var_1 = 0;
      }

      waitframe();
      continue;
    }

    if(!istrue(var_1)) {
      self setclientomnvar(var_0._id_9B9E, 0);
      self setclientomnvar("ui_gasmask_damage", self.health / self.maxhealth);
      var_1 = 1;
    }

    waitframe();
  }
}

_id_8BF5(var_0) {
  self setclientomnvar(var_0._id_9B9E, 0);
  _id_8C12();
}

_id_8BFA() {
  self endon("death_or_disconnect");
  thread _id_084C::flamenaut_mask_on(self);
  self._id_61D9 = 1;
  var_0 = self _meth_8495("ges_magma_gas_mask_on");

  if(_id_8BE7()) {
    thread scripts\mp\gametypes\br_public::_id_B741("iw8_ges_plyr_gasmask_on", var_0);
  }

  wait(var_0);
  self._id_61D9 = 0;
  self._id_61D4 = 1;
  _id_09BE::_id_525B();

  if(isDefined(self._id_AC3D) && isDefined(self._id_AC3D._id_6285) && self._id_AC3D._id_6285 == "female") {
    self _meth_84A8("gender", "gasmask_female", 0.1);
  } else {
    self _meth_84A8("gender", "gasmask_male", 0.1);
  }
}

_id_8BE7() {
  var_0 = self;
  return !(var_0 scripts\cp_mp\utility\player_utility::isinvehicle(1) || var_0 _meth_86B7() || var_0 _meth_86B8() || var_0 _meth_87AF());
}

_id_8C12() {
  self endon("death_or_disconnect");

  if(!istrue(self._id_88DF)) {
    return;
  }
  var_0 = self _meth_8495("ges_magma_gas_mask_off");

  if(_id_8BE7()) {
    thread scripts\mp\gametypes\br_public::_id_B741("iw8_ges_plyr_gasmask_off", var_0);
  }

  self._id_61D9 = 1;
  wait(var_0);
  self._id_61D9 = 0;
  _id_09BE::_id_4ACB();

  if(isDefined(self._id_AC3D) && isDefined(self._id_AC3D._id_6285) && self._id_AC3D._id_6285 == "female") {
    self _meth_84A8("gender", "female", 0.1);
  } else {
    self _meth_84A8("gender", "", 0.1);
  }
}

_id_8BFD() {
  return -0.2;
}

jugg_forceend() {
  self notify("jugg_force_ended");
}
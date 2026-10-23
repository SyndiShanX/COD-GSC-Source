/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\_zombies_magicbox.gsc
*********************************************************/

_id_5305() {
  level._id_2B6F = 1;
  level._id_2B70 = 0;
  level._id_2B6E = 15;

  if(0) {
    level._id_4400 = ::_id_4403;
    level._id_451F = ::_id_4521;
  }

  level._id_08AD = ::_id_08B7;
  level._id_2A77 = ::_id_2A7A;
  level._id_6C08 = ::_id_6C0A;
  level._id_2448 = ::_id_244B;
  level._id_6AD1 = ::_id_6B9A;
  level._id_74C4 = ::_id_64C6;
  level._effect["magic_box_light"] = loadfx("vfx/zombie/zmb_box_light_marker");
  level._effect["zmb_mystery_box_gun_gk"] = loadfx("vfx/zombie/zmb_mystery_box_gun_gk");
  _id_09E8();
}

_id_09E8() {
  if(1) {
    _id_09C8("jack_in_box_decoy_zm", "none", "none", "none");
  }

  _id_09C8("m1911_zm", "none", "none", "none");
  _id_09C8("lewis_zm", "none", "none", "none");
  _id_09C8("fg42_zm", "none", "none", "none");
  _id_09C8("mg15_zm", "none", "none", "none");
  _id_09C8("mg42_zm", "none", "none", "none");
  _id_09C8("m1941_zm", "none", "none", "none");
  _id_09C8("g43_zm", "none", "none", "none");
  _id_09C8("stg44_zm", "none", "none", "none");
  _id_09C8("walther_zm", "none", "none", "none");
  _id_09C8("mp40_zm", "none", "none", "none");
  _id_09C8("mp28_zm", "none", "none", "none");
  _id_09C8("karabin_zm", "none", "none", "none");
  _id_09C8("thompson_zm", "none", "none", "none");
  _id_09C8("type100_zm", "none", "none", "none");
  _id_09C8("m1garand_zm", "none", "none", "none");
  _id_09C8("winchester1897_zm", "none", "none", "none");
  _id_09C8("svt40_zm", "none", "none", "none");
  _id_09C8("bar_zm", "none", "none", "none");
  _id_09C8("bren_zm", "none", "none", "none");
  _id_09C8("leeenfield_zm", "none", "none", "none");
  _id_09C8("ppsh41_zm", "none", "none", "none");
  _id_09C8("springfield_zm", "none", "none", "none");
  _id_09C8("greasegun_zm", "none", "none", "none");
  _id_09C8("sten_zm", "none", "none", "none");
  _id_09C8("fliegerfaust_zm", "none", "none", "none");
  _id_09C8("breda30_zm", "none", "none", "none");
  _id_09C8("volk_zm", "none", "none", "none");
  _id_09C8("beretta_zm", "none", "none", "none");
  _id_09C8("p38_zm", "none", "none", "none");
  _id_09C8("reich_zm");
  _id_09C8("enfieldno2_zm");
  _id_09C8("mas38_zm");
  _id_09C8("mg81_zm");
  _id_09C8("type5_zm");
  _id_09C8("sterling_zm");
  _id_09C8("m1935_zm");
  _id_09C8("m2carbine_zm");
  _id_09C8("arisaka_zm");
  _id_09C8("leveraction_zm");
  _id_09C8("m1919_zm");
  _id_09C8("nambu_zm");
  _id_09C8("blunderbuss_zm");
  _id_09C8("ptrs41_zm");
  _id_09C8("zk383_zm");
  _id_09C8("delisle_zm");
  _id_09C8("avs36_zm");
  _id_09C8("federov_zm");
  _id_09C8("mosin_zm");
  _id_09C8("ribeyrolles_zm");
  _id_09C8("tokyo_zm");
  _id_09C8("vmg1927_zm");
  _id_09C8("sudaev_zm");
  _id_09C8("sdk_zm");
  _id_09C8("charlton_zm");
  _id_09C8("emp44_zm");
  _id_09C8("dp28_zm");
  _id_09C8("austen_zm");
  _id_09C8("bechowiec_zm");
  _id_09C8("blyskawica_zm");
  _id_09C8("chatelleroult_zm");
  _id_09C8("erma_zm");
  _id_09C8("grofuss_zm");
  _id_09C8("kgm21_zm");
  _id_09C8("lad_zm");
  _id_09C8("m2hyde_zm");
  _id_09C8("mas36_zm");
  _id_09C8("wimmer_zm");
  _id_09C8("wz35_zm");

  if(isDefined(level.initmagicboxweaponsfunc)) {
    [[level.initmagicboxweaponsfunc]]();
  }
}

_id_8360(var_0) {
  return int(var_0 * 20);
}

_id_6B9A(var_0) {
  _id_4D18(var_0, 1);
}

_id_4D18(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(isDefined(var_0.modelent)) {
    var_0.modelent hidepart("TAG_FX");

    if(isDefined(level._effect["magic_box_light"]) && isDefined(var_0.modelent) && isDefined(var_0.modelent._id_1B78)) {
      _stopFXOnTag(common_scripts\utility::getfx("magic_box_light"), var_0.modelent._id_1B78, "tag_origin");
    }
  } else if(isDefined(var_0.issighted)) {
    var_0.issighted setscriptablepartstate("lights", "inactive");

    if(!var_1) {
      var_0.issighted _id_6C0B(1);
    } else {
      var_0.issighted setscriptablepartstate("box", "opened");
    }
  }
}

_id_4403() {
  var_0 = &"ZOMBIES_BUY_MYSTERY_BOX";
  return var_0;
}

_id_4521() {
  var_0 = &"ZOMBIES_EMPTY_STRING";
  return var_0;
}

_id_08B7(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = _id_456D(var_0);

  if(isDefined(var_0.modelent)) {
    if(!isDefined(var_0.modelent._id_1B78)) {
      var_0.modelent._id_1B78 = spawn("script_model", (var_0.modelent.origin[0], var_0.modelent.origin[1], 1650));
      var_0.modelent._id_1B78 setModel("tag_origin");
      var_0.modelent._id_1B78.angles = (-90, -90, -90);
    }

    if(isDefined(level._effect["magic_box_light"]) && isDefined(var_0.modelent._id_1B78)) {
      _playFXOnTag(level._effect["magic_box_light"], var_0.modelent._id_1B78, "tag_origin");
    }
  }

  if(isDefined(var_0.modelent)) {
    var_0.modelent showpart("TAG_FX");
    var_0.modelent scriptmodelplayanim("zmb_mystery_box_2_close_idle");
  } else if(isDefined(var_0.issighted)) {
    var_0.issighted setscriptablepartstate("lights", "active");
    var_0.issighted _id_244C();
  }
}

_id_2A7A(var_0) {
  _id_4D18(var_0);
}

magicboxweaponvisibility(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_2 = 1;

  for(;;) {
    if(!(var_2 && common_scripts\utility::_id_562E(var_0.isdispensingweapon) && isDefined(var_0._id_586E))) {
      var_0 waittill("set magic box weapon");
    }

    var_2 = 0;
    var_3 = 1;

    for(;;) {
      if(var_1 worldweaponsloaded(var_0._id_586E.weaponname)) {
        break;
      }

      if(!common_scripts\utility::_id_562E(var_0.isdispensingweapon) || common_scripts\utility::_id_562E(var_0._id_586E.is_flashing)) {
        var_3 = 0;
        break;
      }

      waitframe();
    }

    if(var_3) {
      var_0._id_586E showtoplayer(var_1);
    }
  }
}

isusingonlinedataoffline(var_0, var_1) {
  if(isDefined(var_0._id_586E)) {
    var_0._id_586E setpickupweapon(var_1);
  } else {
    var_0._id_586E = spawn("weapon_" + var_1, var_0._id_A9EA.origin);
    var_2 = (0, 0, 0);
    var_0._id_586E linkTo(var_0._id_A9EA, "tag_origin", var_2, (0, 0, 0));
  }

  var_0._id_586E makeunusable();
  var_0._id_586E _meth_86B3(0);
  var_0._id_586E ghost();
  var_0._id_586E.weaponname = var_1;
  var_0 notify("set magic box weapon");
}

_id_456D(var_0) {
  if(isDefined(var_0.modelent)) {
    return var_0.modelent;
  }

  if(isDefined(var_0.issighted)) {
    return var_0.issighted;
  }
}

worldweaponsloadedbyplayers(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = 1;

    foreach(var_7 in var_0) {
      if(!var_7 worldweaponsloaded(var_4)) {
        var_5 = 0;
        break;
      }
    }

    if(var_5) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

choosepreviewweapon(var_0) {
  if(!isDefined(level.magicboxpreviewweapons)) {
    level.magicboxpreviewweapons = [];

    foreach(var_2 in level.magicboxweapons) {
      var_3 = var_2["fullName"];

      if(issubstr(var_3, "_pap_")) {
        var_3 = _id_0569::_id_40BD(var_3);
      }

      level.magicboxpreviewweapons[level.magicboxpreviewweapons.size] = var_3;
    }
  }

  var_5 = worldweaponsloadedbyplayers(level.players, level.magicboxpreviewweapons);

  if(var_5.size < 2) {
    var_5 = worldweaponsloadedbyplayers([var_0], level.magicboxpreviewweapons);
  }

  var_3 = common_scripts\utility::random(var_5);
  return var_3;
}

_id_6C0A(var_0, var_1) {
  var_2 = 4.5;
  var_3 = 0.5;
  var_4 = 4;
  var_5 = 0.1;
  var_6 = 0.3;
  var_7 = (2, 1, 2);
  var_8 = 45.0;
  var_9 = getdvarint("scr_zombieDebugS2MagicBoxDraw");
  var_10 = [];
  var_11 = _id_456D(var_0);
  var_10 = _anglestoaxis(var_11.angles);
  var_12 = var_11 getpointinmodelbounds(0.0, 0.0, -1.0);
  var_13 = var_10["up"] * var_7[2];
  var_13 = var_13 + var_10["right"] * var_7[1];
  var_13 = var_13 + var_10["forward"] * var_7[0];
  var_13 = var_13 + var_12;

  if(isDefined(var_0._id_A9EA)) {
    var_0._id_A9EA dontinterpolate();
    var_0._id_A9EA.origin = var_13;
  } else {
    var_0._id_A9EA = spawn("script_origin", var_13);
    var_0._id_A9EA setModel("tag_origin");
    var_0._id_A9EA hide();
  }

  if(isDefined(var_0.modelent)) {
    var_0.modelent scriptmodelplayanim("zmb_mystery_box_2_open");
  } else if(isDefined(var_0.issighted)) {
    var_0.issighted thread _id_6C0B();
  }

  _id_0378::snd_message("mystery_box_open", var_11);
  _id_0378::snd_message("mystery_box_attract_open", var_11);
  wait 1;
  var_0._id_A9EA.angles = _combineangles(var_11.angles, (0, 0, 0));
  var_0._id_A9EA movez(var_8, var_2, var_4, var_3);
  _playFXOnTag(level._effect["zmb_mystery_box_gun_gk"], var_0._id_A9EA, "tag_origin");
  _id_0378::snd_message("mystery_box_elec", var_11, 1);
  wait 1;
  var_17 = [];

  foreach(var_19 in level.players) {
    if(var_19 == var_1) {
      continue;
    } else {
      var_17[var_17.size] = var_19;
    }
  }

  if(var_17.size > 0) {
    var_11 thread releaseclaimedtrigger(var_17, var_1);
  }

  isholdinggrenade(var_1, var_0);
  var_21 = var_0._id_A9C4["selectedWeapon"];
  var_22 = spawn("weapon_" + var_21, var_0._id_A9EA.origin, 1);
  var_22 makeunusable();
  var_22 _meth_86B3(0);
  var_22 ghost();

  for(var_23 = 0; var_23 < var_2; var_23 = var_23 + var_26) {
    var_24 = choosepreviewweapon(var_1);

    if(isDefined(var_24)) {
      isusingonlinedataoffline(var_0, var_24);
    }

    var_25 = var_23 / var_2;
    var_26 = _func_2CA(var_5, var_6, var_25);
    wait(var_26);
  }

  isusingonlinedataoffline(var_0, var_21);
  var_22 delete();
  wait(var_6);
}

releaseclaimedtrigger(var_0, var_1) {
  var_2 = 0.5;
  var_3 = 5;

  for(var_4 = 0; var_4 < var_3; var_4++) {
    wait(var_2);
    self hudoutlineenableforclients(var_0, 0, 0);
    wait(var_2);
    self hudoutlinedisableforclients(var_0);
  }
}

#using_animtree("destructibles");

_id_6C0B(var_0) {
  if(common_scripts\utility::_id_562E(var_0)) {
    self setscriptablepartstate("box", "opening_dud");
  } else {
    self setscriptablepartstate("box", "opening");
  }

  wait(_getanimlength(%zmb_mystery_box_2_open));
  self setscriptablepartstate("box", "opened");
}

_id_244C() {
  self setscriptablepartstate("box", "closing");
  wait(_getanimlength(%zmb_mystery_box_2_close));
  self setscriptablepartstate("box", "closed");
}

_id_244B(var_0) {
  if(isDefined(var_0.issighted)) {
    var_0.issighted _id_244C();
  } else if(isDefined(var_0.modelent)) {
    var_0.modelent scriptmodelplayanim("zmb_mystery_box_2_close");
  }

  var_0 common_scripts\utility::trigger_on();
}

_id_64C6(var_0, var_1) {
  wait 1;
  var_2 = _id_456D(var_0);
  _id_0380::_id_2889("interact_mystery_box_move", undefined, var_2.origin);
  _id_4D18(var_0);
}

init() {
  level thread mapweaponnamestonumbers();
  level thread _id_A7D8();
  level thread magicboxthink();
  level thread magicboxmaps();
  level thread _id_0DB7();
}

_id_A7D8() {
  level._id_A7F1 = [];
  level._id_A7DE = [];
  var_0 = getEntArray("wallbuy", "targetname");
  level._id_A7DE = common_scripts\utility::_id_0F73(level._id_A7DE, var_0);
  var_6 = common_scripts\utility::getstructarray("wallbuy", "targetname");
  level._id_A7DE = common_scripts\utility::_id_0F73(level._id_A7DE, var_6);

  foreach(var_8 in level._id_A7DE) {
    level thread _id_A7E6(var_8);
  }
}

_id_A7E5(var_0) {
  foreach(var_2 in level._id_A7DE) {
    var_3 = getEntArray(var_2.target, "targetname");

    foreach(var_5 in var_3) {
      if(var_0) {
        var_5 common_scripts\utility::trigger_off();
      } else {
        var_5 common_scripts\utility::trigger_on();
      }

      var_5._id_5611 = var_0;
    }
  }
}

_id_A7F0(var_0) {
  var_1 = self;

  if(var_1 != var_0._id_7474) {
    var_0._id_586E _meth_8006(var_1);
    return;
  }

  var_1 endon("disconnect");

  while(!var_1 worldweaponsloaded(var_0._id_586E.weaponname)) {
    waitframe();
  }

  var_0._id_586E showtoplayer(var_1);
}

_id_A7EF(var_0, var_1) {
  var_1 endon("disconnect");
  var_2 = spawnStruct();
  var_2._id_586E = var_0;
  var_2._id_586E ghost();
  var_2._id_7474 = var_1;
  level childthread maps\mp\_utility::_id_6F74(::_id_A7F0, var_2);
}

_id_10E6(var_0) {
  var_0 endon("disconnect");
  var_1 = self;

  while(common_scripts\utility::_id_562E(var_0.playerconnectedbuthasntstreamedweapons)) {
    waitframe();
  }

  wait(_randomfloat(0.5));

  if(isDefined(var_1._id_6C1D)) {
    var_1._id_6C1D delete();
  }

  var_2 = _id_454B(var_0, var_1.weaponname);
  var_3 = "weapon_" + var_2;
  var_4 = spawn(var_3, var_1._id_A9E3, 1);
  var_4.angles = var_1._id_A9BD;
  var_4.weaponname = var_2;
  var_4 makeunusable();
  var_4 _meth_86B3(0);
  _id_A7EF(var_4, var_0);
  var_1._id_6C1D = var_4;
  thread _id_8C2B(var_0);
  thread _id_A7EB(var_0);
  thread _id_A7ED(var_0);
  self setdefaultcostumeifneeded(1, var_1._id_A9E3);
  _id_0559::_id_7C03(var_0, self, self.weaponname);
}

_id_4D1B(var_0) {
  self.issighted _meth_8006(var_0);
}

_id_8C2B(var_0) {
  self.issighted showtoplayer(var_0);
}

_id_A7EB(var_0) {
  var_0 endon("disconnect");
  self._id_A7D7 = 1;
  childthread _id_A7EC(var_0);
  wait(_randomfloat(0.8));
  var_1 = self;
  var_2 = _id_0552::_id_7BFE(var_0, self, 1, var_1._id_A9E3);

  for(;;) {
    wait 0.8;

    if(!self._id_A7D7) {
      continue;
    }
    self._id_A7D7 = 0;

    if(0) {
      self setCursorHint("HINT_NOICON");
    }

    var_3 = var_0 getcurrentprimaryweapon();

    if(_id_0547::isrippedturretweapon(var_3) || _id_0547::_id_5862(var_3)) {
      if(0) {
        self setHintString("");
        self setsecondaryhintstring("");
        self settertiaryhintstring("");
        self._id_3006 = undefined;
      }

      if(1) {
        var_2._id_A9B4 = undefined;
      }

      continue;
    }

    var_4 = var_0 _id_0586::_id_078A(self.weaponname);

    if(isDefined(var_4)) {
      self._id_2925 = self._id_0DB5;

      if(_id_0569::_id_55D4(var_4)) {
        self._id_2925 = 4000;
      }

      self._id_3006 = self._id_2925;

      if(0) {
        self setHintString(_id_4412(self));
        self setsecondaryhintstring(_id_4411(self));
        self settertiaryhintstring("");
      }

      if(1) {
        var_2._id_A9B4 = "ammo";
        var_2._id_A9A5 = self._id_3006;
      }

      continue;
    }

    self._id_2955 = self._id_A9C2;
    self._id_3006 = self._id_2955;

    if(0) {
      self setsecondaryhintstring(_id_4734(self));
      self settertiaryhintstring(_id_4733(self));
      self setHintString(&"ZOMBIES_WALL_BUY_GENERIC");
    }

    if(1) {
      var_2._id_A9B4 = self._id_6C5C;
      var_2._id_A9A5 = self._id_3006;
    }
  }
}

_id_A7EC(var_0) {
  for(;;) {
    var_0 common_scripts\utility::waittill_any("weapon_change", "new_equipment");
    self._id_A7D7 = 1;
  }
}

_id_A7ED(var_0) {
  for(;;) {
    var_0 common_scripts\utility::waittill_any("weapon_change", "new_equipment", "money_update", "special_event_update");
    waittillframeend;

    if(isDefined(self._id_3006)) {
      if(common_scripts\utility::_id_562E(self._id_5611) || var_0.moneycurrent < self._id_3006) {
        _id_A7D2("unaffordable");
        continue;
      }

      _id_A7DD("unaffordable");
    }
  }
}

_id_A7E6(var_0) {
  var_1 = var_0.origin;
  var_2 = var_0.angles;

  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }

  var_3 = var_0._id_0165;
  var_4 = [];

  if(isDefined(var_0.setlookatent)) {
    var_4 = strtok(var_0.setlookatent, ",");
  }

  var_5 = 1000;
  var_6 = 1000;

  if(var_4.size > 0) {
    var_5 = int(var_4[0]);

    if(var_4.size > 1) {
      var_6 = int(var_4[1]);
    } else {
      var_6 = 1000;
    }
  }

  var_7 = 0;

  if(_id_0547::_id_5565(var_0.script_ghettotag, "rand_wallbuy")) {
    var_7 = 1;
  }

  if(isDefined(level.override_weapon_costs)) {
    var_5 = int(level.override_weapon_costs);
    var_6 = int(level.override_weapon_costs / 2);
  }

  var_16 = [];
  var_17 = undefined;
  var_18 = getEntArray(var_0.target, "targetname");

  foreach(var_20 in var_18) {
    var_21 = var_20._id_0165;

    if(!isDefined(var_21)) {
      var_16 = common_scripts\utility::_id_0F6F(var_16, var_20);
      continue;
    }

    switch (var_21) {
      case "gun_card":
        var_17 = var_20;
        break;
    }
  }

  var_23 = _getscriptablearray(var_0.target, "targetname");
  var_0._id_A7E9 = var_16;
  var_0._id_A7E3 = var_23;

  if(isDefined(var_17)) {
    var_0.wallbuyguncard = var_17;
    var_0.wallbuyguncard hide();
  }

  for(var_24 = 0; var_24 < 4; var_24++) {
    var_25 = var_16[var_24];
    var_25._id_A9E3 = var_1;
    var_25._id_A9BD = var_2;

    if(isDefined(var_17)) {
      var_25.gun_card = var_17;
    }

    level thread _id_A7EA(var_25, var_23[var_24], var_3, var_5, var_6, var_7);
  }
}

_id_ABE9(var_0, var_1, var_2, var_3) {
  var_4 = _id_0547::_id_AC4B(var_1, "buy");
  var_4 _id_0547::_id_AC44("cost", var_2);
  var_4 _id_0547::_id_AC48("weapon", var_3);
  var_4 _id_0547::_id_AC48("sub_type", var_0);
  var_4 _id_0547::_id_AC4D();
}

_id_A7EA(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");
  var_0._id_2955 = var_3;
  var_0._id_A9C2 = var_3;
  var_0._id_2925 = var_4;
  var_0._id_0DB5 = var_4;
  var_0.weaponname = var_2;
  var_0._id_6C5C = var_2;
  var_0._id_9DA0 = 0;
  var_0.issighted = var_1;

  if(!common_scripts\utility::_id_562E(var_5)) {
    var_0 thread _id_A7E1();
  }

  var_6 = _id_0547::iszombieequipment(var_2);
  var_7 = _id_0547::_id_5864(var_2);

  if(_id_0547::isusetriggerprimary(var_0) && !var_6) {
    var_8 = level._id_A7F1.size;
    level._id_A7F1[var_8]["baseName"] = var_0._id_6C5C + "_mp";
    level._id_A7F1[var_8]["displayModel"] = _getweaponmodel(var_2);
  }

  if(!common_scripts\utility::_id_562E(var_5)) {
    _id_0547::setupusetriggerforclient(var_0, ::_id_10E6, ::_id_4D1B);
  } else {
    return;
  }

  for(;;) {
    [var_10, var_11] = var_0 _id_0547::waittilltriggerortokenuse();
    var_12 = 0;
    var_13 = var_10 getcurrentprimaryweapon();

    if(_id_0547::isrippedturretweapon(var_13) || _id_0547::_id_5862(var_13)) {
      continue;
    }
    var_14 = var_0._id_2955;
    var_15 = _id_454B(var_10, var_2);

    if(isDefined(level.zmb_trigger_weapon_get_func)) {
      var_15 = [[level.zmb_trigger_weapon_get_func]](var_10, var_0);
    }

    if(_id_0547::_id_73F9(var_10, var_15)) {
      var_14 = var_0._id_2925;
      var_12 = 1;

      if(_id_4B6A(var_10, var_15)) {
        displayfullammomessage(var_10, var_6);
        continue;
      }
    }

    if(var_11 == "token") {
      var_10 maps\mp\gametypes\zombies::spendtoken(var_0.tokencost);
    } else if(!var_10 maps\mp\gametypes\zombies::attempttobuy(var_14)) {
      var_10 thread _id_054E::_id_0695("needmoney");
      continue;
    }

    var_10 thread _id_054E::moneyspend();
    var_0 thread _id_1366();
    var_10 thread _id_054E::playerbuyweapon();

    if(var_6) {
      _id_A7D5(var_10, var_15);
    } else if(var_7) {
      wallbuygivemelee(var_10, var_15);
    } else {
      _id_A7D6(var_10, var_15, undefined, 0);
      _id_0547::_id_0A00(var_10, var_15);
    }

    _id_ABE9("normal_wallbuy", self.origin, var_14, var_15);

    if(maps\mp\_utility::getmapname() == "mp_zombie_island") {
      var_16 = var_10 maps\mp\gametypes\_playerlogic::gather_spawn_weapons();

      if(!isDefined(var_10.magicboxweaponsrolled)) {
        var_10.magicboxweaponsrolled = [];
      }

      if(common_scripts\utility::_id_0F79(var_16, var_15) || !common_scripts\utility::_id_0F79(var_10.magicboxweaponsrolled, var_15)) {
        var_10 notify("invalid_wallbuy");
      }
    }

    if(var_12) {
      _id_0547::_id_4AE4(var_10, "ammo", var_14, var_15, "none");
      _id_0555::issprinting("buy_ammo", var_10, var_15);
    } else {
      _id_0547::_id_4AE4(var_10, "weapons", var_14, var_15, "none");
      _id_0555::issprinting("buy_weapon", var_10, var_15);
      level._id_400E[level._id_400E.size] = ["survivalist_set 3 -1", var_10];
      level._id_400E[level._id_400E.size] = ["survivalist_set 4 -1", var_10];
    }

    var_0 thread _id_A7E2(var_12);
  }
}

_id_A7E1() {
  self.issighted._id_243B = [];
  self.issighted setscriptablepartstate("base", "buy_loop_open");
  self.issighted.ishost = 0;
  self.issighted._id_82A0 = 0;
  thread _id_A7E4(1);
}

_id_A7E4(var_0) {
  self.issighted endon("immediate_state_change");

  if(!isDefined(self.issighted)) {
    return;
  }
  if(self.issighted._id_82A0 && !common_scripts\utility::_id_562E(var_0)) {
    self.issighted._id_09B6 = 1;
  } else {
    var_1 = self.issighted._id_243B.size > 0;

    if(var_0) {
      var_2 = 0;

      if(var_1 && self.issighted.ishost != 2) {
        self.issighted.ishost = 2;
        self.issighted setscriptablepartstate("base", "buy_loop_closed");
        var_2 = 1;
      } else if(!var_1 && self.issighted.ishost != 0) {
        self.issighted.ishost = 0;
        self.issighted setscriptablepartstate("base", "buy_loop_open");
        var_2 = 1;
      }

      if(var_2) {
        self.issighted._id_82A0 = 0;
        self.issighted notify("immediate_state_change");
        self.issighted notify("script_state_change");
        return;
      }

      return;
    }

    var_3 = 0;

    switch (self.issighted.ishost) {
      case 2:
        if(!var_1) {
          var_4 = _id_0380::_id_2889("zmb_wallbuy_open", undefined, self._id_A9E3);
          _id_0378::_id_8D14(var_4);
          self.issighted.ishost = 3;
          self.issighted setscriptablepartstate("base", "buy_loop_opening");
          self.issighted._id_82A0 = 1;
          self.issighted notify("script_state_change");
          wait 1.13333;
          self.issighted.ishost = 0;
          self.issighted setscriptablepartstate("base", "buy_loop_open");
          self.issighted._id_82A0 = 0;
          self.issighted notify("script_state_change");
          var_3 = 1;
        }

        break;
      case 0:
        if(var_1) {
          var_5 = _id_0380::_id_2889("zmb_wallbuy_close", undefined, self._id_A9E3);
          _id_0378::_id_8D14(var_5);
          self.issighted setscriptablepartstate("base", "buy_loop_closing");
          self.issighted.ishost = 1;
          self.issighted._id_82A0 = 1;
          self.issighted notify("script_state_change");
          wait 1.03333;
          self.issighted setscriptablepartstate("base", "buy_loop_closed");
          self.issighted.ishost = 2;
          self.issighted._id_82A0 = 0;
          self.issighted notify("script_state_change");
          var_3 = 0;
        }

        break;
      default:
        return;
    }

    if(var_3 && common_scripts\utility::_id_562E(self.issighted._id_09B6)) {
      self.issighted._id_09B6 = undefined;
      thread _id_A7E4(0);
    }
  }
}

_id_A7D2(var_0) {
  self.issighted._id_243B[var_0] = 1;

  if(self.issighted._id_243B.size == 1) {
    thread _id_A7E4(0);
  }
}

_id_A7DD(var_0) {
  self.issighted._id_243B[var_0] = undefined;

  if(self.issighted._id_243B.size == 0) {
    thread _id_A7E4(0);
  }
}

_id_A7E2(var_0) {
  var_1 = self;

  if(!isDefined(self.issighted)) {
    return;
  }
  var_2 = self.issighted _meth_85CE();

  if(!var_0) {
    if(isDefined(var_1._id_6C1D) && isPlayer(self._id_230A)) {
      var_1._id_6C1D _meth_8006(self._id_230A);
    }
  } else if(var_2 == "animated_zmb_wall_buy_box")
    self.issighted setscriptablepartstate("ammo", "hide");

  _id_A7E7(self);
  thread _id_A7D2("purchase");
  _id_A7EE(2);
  wait 0.25;

  if(!var_0) {
    if(isDefined(var_1._id_6C1D) && isPlayer(self._id_230A)) {
      var_1._id_6C1D showtoplayer(self._id_230A);
    }
  } else if(var_2 == "animated_zmb_wall_buy_box")
    self.issighted setscriptablepartstate("ammo", "show");

  thread _id_A7DD("purchase");
  wait 1.2;
  _id_A7E8(self);
}

_id_A7EE(var_0) {
  for(;;) {
    self.issighted waittill("script_state_change");

    if(self.issighted.ishost == var_0) {
      return;
    }
  }
}

centerweaponforwallbuy(var_0, var_1, var_2) {
  var_3 = [6, 0, 4];

  if(isDefined(var_2)) {
    var_3 = var_2;
  }

  var_4 = var_0.origin;
  var_5 = _anglestoaxis(var_0.angles);
  var_4 = var_4 + var_5["forward"] * var_3[0];
  var_4 = var_4 + var_5["right"] * var_3[1];
  var_4 = var_4 + var_5["up"] * var_3[2];
  var_6 = var_1 getpointinmodelbounds(0.0, 1.0, 0.0);
  var_7 = var_4 - var_6;
  var_1 dontinterpolate();
  var_1.origin = var_1.origin + var_7;
}

_id_4B6A(var_0, var_1) {
  if(var_0 getweaponammostock(var_1) < _weaponmaxammo(var_1, var_0)) {
    return 0;
  }

  if(var_0 getweaponammoclip(var_1) < _weaponclipsize(var_1, var_0)) {
    return 0;
  }

  return 1;
}

displayfullammomessage(var_0, var_1) {
  var_0 playsoundtoplayer("zmb_ui_purchase_fail", var_0);

  if(var_1) {
    _id_0555::issprinting("full_equip", var_0);
  } else {
    _id_0555::issprinting("full_ammo", var_0);
  }
}

_id_4734(var_0) {
  return maps/_vehicle(var_0._id_6C5C);
}

_id_4733(var_0) {
  return _id_0547::_id_4474(var_0._id_2955);
}

_id_4412(var_0) {
  return &"ZOMBIES_WALL_BUY_AMMO";
}

_id_4411(var_0) {
  return _id_0547::_id_4474(var_0._id_2925);
}

_id_473B() {
  var_0 = [];
  var_1 = self getweaponlistprimaries();

  foreach(var_3 in var_1) {
    if(!maps\mp\_utility::_id_5670(var_3)) {
      var_0[var_0.size] = var_3;
    }
  }

  return var_0;
}

wallbuygivemelee(var_0, var_1) {
  if(_id_0547::_id_5864(var_1)) {
    var_0 _id_0586::_id_078C(var_1);
    var_0 _id_0586::_id_078E(var_1);
  }
}

_id_A7D6(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(_id_0547::_id_73F9(var_0, var_1)) {
    zombiesgiveammoandswitch(var_0, var_1);
    var_0 notify("wallbuy_ammo_purchased");

    if(isDefined(var_0._id_7EFE)) {
      var_0._id_7EFE = var_0._id_7EFE + 1;
    }

    return;
  }

  if(var_0 _id_057A::_id_A260()) {
    var_0 notify("weapon_consumable_force_take");
  }

  if(weaponinventorytype(var_1) == "primary") {
    if(!var_0 _id_0586::_id_05DF(var_1)) {
      var_4 = var_0 _id_0586::_id_0637();

      if(var_3 && _id_8B57(var_4)) {
        var_0 _id_348F(var_4);
      } else if(_weapontype(var_4) != "melee") {
        var_0 _id_0586::_id_0790(var_4);
      }
    }
  }

  maps\mp\gametypes\zombies::createzombieweaponstate(var_0, var_1);

  if(isDefined(var_0._id_7F10)) {
    var_0._id_7F10 = var_0._id_7F10 + 1;
  }

  var_5 = undefined;
  var_6 = _id_0547::_id_AAF9(var_1, 0, 0);

  if(var_6 != "none") {
    var_7 = _func_2FF(var_6, "_zm") + "_mp";
    var_8 = maps\mp\zombies\zombie_weapon_kits_shared::_id_5842(var_7);

    if(var_8) {
      var_5 = var_0 getplayerdata(common_scripts\utility::_id_46A8(), "weaponBuildKits", var_7, "charm");
    }
  }

  var_0 _id_0586::_id_078C(var_1, undefined, undefined, var_5);
  var_0 givemaxammo(var_1);
  var_0 givemaxscriptedammo(var_1);
  var_0 _id_0586::_id_078E(var_1);
  var_0 notify("new_wallbuy_weapon");
  writeweaponlisttomatchdata(var_0);
}

_id_A7DC(var_0) {
  foreach(var_2 in var_0._id_4D4D) {
    foreach(var_4 in var_2._id_A7E3) {
      var_4 hudoutlinedisableforclient(var_0);
    }
  }

  var_0._id_4D4D = [];
}

_id_A7D9() {
  var_0 = self;
  var_0 endon("disconnect");
  var_0._id_4D4D = [];
  self._id_A7DA = 1;
  childthread _id_A7DB(var_0);
  var_1 = 0.2;

  while(isDefined(var_0) && var_0 getentitynumber() % 4 != int(gettime() / 50) % 4) {
    waitframe();
  }

  while(isDefined(var_0)) {
    wait(var_1);

    if(!isalive(var_0)) {
      _id_A7DC(var_0);
      break;
    }

    if(!self._id_A7DA) {
      continue;
    }
    self._id_A7DA = 0;

    if(_id_0547::isplayerinlaststand(self)) {
      continue;
    }
    var_2 = self getcurrentweapon();

    if(var_2 == "none") {
      continue;
    }
    var_3 = self getfractionmaxammo(var_2);

    if(var_3 >= 0.1) {
      _id_A7DC(var_0);
      continue;
    }

    foreach(var_5 in level._id_A7DE) {
      if(common_scripts\utility::_id_0F79(var_0._id_4D4D, var_5)) {
        continue;
      }
      var_6 = var_5._id_0165;

      if(_id_0547::_id_5816(var_6)) {
        continue;
      }
      var_7 = _id_0586::_id_0791(var_2, var_6);
      wait(var_1);

      if(common_scripts\utility::_id_562E(var_7)) {
        foreach(var_9 in var_5._id_A7E3) {
          var_9 hudoutlineenableforclient(var_0, 0, 0);
        }

        var_0._id_4D4D = common_scripts\utility::_id_0F6F(var_0._id_4D4D, var_5);
      }
    }
  }
}

_id_A7DB(var_0) {
  while(isDefined(var_0)) {
    [var_2, var_3] = common_scripts\utility::_id_A70E(self, "weapon_fired", self, "weapon_change", self, "wallbuy_ammo_purchased", self, "death", level, "maxAmmoPickup");
    self._id_A7DA = 1;
  }
}

_id_8B57(var_0) {
  return 1;
}

_id_348F(var_0) {
  var_1 = self getweaponammoclip(var_0, "right");
  var_2 = self getweaponammoclip(var_0, "left");
  var_3 = self getweaponammostock(var_0);
  var_4 = _weaponmaxammo(var_0);

  if(var_3 > var_4) {
    var_3 = var_4;
  }

  var_5 = self dropitem(var_0);

  if(!isDefined(var_5)) {
    return;
  }
  var_5 itemweaponsetammo(var_1, var_3, var_2);
  var_5._id_0117 = self;
  var_5.targetname = "dropped_weapon";
  var_5 thread _id_0513::watchpickup();
  var_5 thread _id_0513::deletepickupafterawhile();
  _id_0586::_id_0790(var_0);
}

writeweaponlisttomatchdata(var_0) {
  if(_id_0547::isplayerinlaststand(var_0)) {
    if(isDefined(level.weaponnamemap["LastStand"])) {
      setmatchdata("players", var_0.clientid, "end_misses", level.weaponnamemap["LastStand"]);
      setmatchdata("players", var_0.clientid, "end_games_played", level.weaponnamemap["LastStand"]);
    }
  } else {
    var_1 = var_0 getweaponlistprimaries();
    var_2 = [];

    foreach(var_4 in var_1) {
      var_2[var_2.size] = _getweaponbasename(var_4);
    }

    if(isDefined(var_2[0]) && isDefined(level.weaponnamemap[var_2[0]])) {
      setmatchdata("players", var_0.clientid, "end_misses", level.weaponnamemap[var_2[0]]);
    }

    if(isDefined(var_2[1]) && isDefined(level.weaponnamemap[var_2[1]])) {
      setmatchdata("players", var_0.clientid, "end_games_played", level.weaponnamemap[var_2[1]]);
    }
  }
}

_id_A7D5(var_0, var_1, var_2) {
  if(_id_0547::iszombielethal(var_1)) {
    var_3 = var_0 getlethalweapon();

    if(var_3 != var_1) {
      var_0 _id_0586::_id_0790(var_3);
      var_0 setlethalweapon(var_1);
      var_0 _id_0586::_id_078C(var_1);
      _id_3AC1(var_0, var_1);
      var_0 notify("new_equipment");
      return;
    }

    var_0 setweaponammoclip(var_1, var_0 getweaponammoclip(var_1) + 1);
    return;
  } else if(_id_0547::_id_5866(var_1)) {
    var_4 = var_0 getoffhandsecondaryclass();

    if(var_4 != var_1) {
      var_0 _id_0586::_id_0790(var_4);
      var_0 setoffhandsecondaryclass(var_1);
      var_0 _id_0586::_id_078C(var_1);
      _id_3AC1(var_0, var_1);
      var_0.zmb_plr_tactical = var_1;

      if(var_1 == "jack_in_box_decoy_zm") {
        var_0 thread _id_057D::_id_4766();
      }

      if(isDefined(level.weaponnamemap[var_1])) {
        setmatchdata("players", var_0.clientid, "endHits", level.weaponnamemap[var_1]);
      }

      var_0 notify("new_equipment");
    } else
      var_0 setweaponammoclip(var_1, var_0 getweaponammoclip(var_1) + 1);
  }
}

_id_3AC1(var_0, var_1) {
  var_2 = var_0;

  if(isDefined(level.zmb_grenadier_immune_weapons) && isDefined(var_1) && is_grenadier_immune_weapon(var_1)) {
    var_2 = undefined;
  }

  var_3 = _weaponclipsize(var_1, var_2);
  var_0 setweaponammoclip(var_1, var_3);
}

is_grenadier_immune_weapon(var_0) {
  if(!isDefined(level.zmb_grenadier_immune_weapons)) {
    return 0;
  }

  return common_scripts\utility::_id_0F79(level.zmb_grenadier_immune_weapons, var_0);
}

zombiesgiveammoandswitch(var_0, var_1) {
  var_1 = var_0 _id_0586::_id_078A(var_1);

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = _weaponclipsize(var_1, var_0);
  var_0 setweaponammoclip(var_1, var_2, "right");

  if(issubstr(var_1, "akimbo")) {
    var_0 setweaponammoclip(var_1, var_2, "left");
  }

  var_0 givemaxammo(var_1);
  var_0 givemaxscriptedammo(var_1);
  var_0 _id_0586::_id_078E(var_1, 1);
}

givemaxscriptedammo(var_0) {
  if(issubstr(var_0, "iw5_em1zm_mp")) {
    maps\mp\gametypes\zombies::playersetem1maxammo();
  }

  if(isDefined(level.givemaxscriptedammofunc)) {
    self[[level.givemaxscriptedammofunc]](var_0);
  }
}

magicboxmaps() {
  var_0 = common_scripts\utility::getstructarray("magic_box_map", "targetname");
  common_scripts\utility::_id_0FB2(var_0, ::magicboxmapinit);
}

magicboxmapinit() {
  self.box_locs = [];
  var_0 = getEntArray(self.target, "targetname");
  var_1 = common_scripts\utility::getstructarray(self.target, "targetname");
  var_2 = common_scripts\utility::_id_0F73(var_0, var_1);

  foreach(var_4 in var_2) {
    switch (var_4._id_0165) {
      case "current":
        var_4 hide();
        self.current_ent = var_4;
        break;
      case "all":
        var_4 hide();
        self._id_0BCD = var_4;
        break;
      case "box_loc":
        self.box_locs[self.box_locs.size] = var_4;
        break;
      case "breach_map":
        if(isDefined(level.breachmapfunc)) {
          level thread[[level.breachmapfunc]](var_4);
        }

        break;
      default:
        break;
    }
  }

  common_scripts\utility::flag_wait("magic_box_init");

  foreach(var_7 in self.box_locs) {
    thread magicboxmapcurrentthink(var_7);
  }

  thread magicboxmapallthink();
  thread magicboxmapoffthink();
}

magicboxmapcurrentthink(var_0) {
  for(;;) {
    common_scripts\utility::flag_wait(var_0.setgoalnode);
    var_1 = 0;

    while(maps\mp\_utility::gameflag("fire_sale")) {
      var_1 = 1;
      waitframe();
    }

    var_2 = 0;

    while(maps\mp\_utility::gameflag("power_off")) {
      var_2 = 1;
      waitframe();
    }

    if(var_1 || var_2) {
      common_scripts\utility::flag_waitopen(var_0.setgoalnode);
      continue;
    }

    self.current_ent show();
    self.current_ent.origin = var_0.origin;
    common_scripts\utility::flag_waitopen(var_0.setgoalnode);
  }
}

magicboxmapallthink() {
  for(;;) {
    self._id_0BCD hide();
    maps\mp\_utility::gameflagwait("fire_sale");
    self._id_0BCD show();
    self.current_ent hide();

    while(maps\mp\_utility::gameflag("fire_sale")) {
      waitframe();
    }

    self.current_ent show();
  }
}

magicboxmapoffthink() {
  for(;;) {
    maps\mp\_utility::gameflagwait("power_off");
    self._id_0BCD hide();
    self.current_ent hide();

    while(maps\mp\_utility::gameflag("power_off")) {
      waitframe();
    }

    self.current_ent show();
  }
}

mapweaponnamestonumbers() {
  level.weaponnamemap = [];
  level.weaponnamemap["iw5_rw1zm_mp"] = 1;
  level.weaponnamemap["iw5_vbrzm_mp"] = 2;
  level.weaponnamemap["iw5_gm6zm_mp"] = 3;
  level.weaponnamemap["iw5_rhinozm_mp"] = 4;
  level.weaponnamemap["iw5_lsatzm_mp"] = 5;
  level.weaponnamemap["iw5_asawzm_mp"] = 6;
  level.weaponnamemap["iw5_ak12zm_mp"] = 7;
  level.weaponnamemap["iw5_bal27zm_mp"] = 8;
  level.weaponnamemap["iw5_himarzm_mp"] = 9;
  level.weaponnamemap["iw5_asm1zm_mp"] = 10;
  level.weaponnamemap["iw5_sn6zm_mp"] = 11;
  level.weaponnamemap["iw5_sac3zm_mp"] = 12;
  level.weaponnamemap["iw5_fusionzm_mp"] = 13;
  level.weaponnamemap["distraction_drone_zombie_mp"] = 14;
  level.weaponnamemap["dna_aoe_grenade_zombie_mp"] = 15;
  level.weaponnamemap["iw5_exocrossbowzm_mp"] = 16;
  level.weaponnamemap["iw5_mahemzm_mp"] = 17;
  level.weaponnamemap["iw5_em1zm_mp"] = 18;
  level.weaponnamemap["iw5_dlcgun1zm_mp"] = 19;
  level.weaponnamemap["iw5_arx160zm_mp"] = 20;
  level.weaponnamemap["iw5_mp11zm_mp"] = 21;
  level.weaponnamemap["explosive_drone_zombie_mp"] = 22;
  level.weaponnamemap["contact_grenade_zombies_mp"] = 23;
  level.weaponnamemap["iw5_hbra3zm_mp"] = 24;
  level.weaponnamemap["iw5_hmr9zm_mp"] = 25;
  level.weaponnamemap["iw5_maulzm_mp"] = 26;
  level.weaponnamemap["iw5_m182sprzm_mp"] = 27;
  level.weaponnamemap["iw5_uts19zm_mp"] = 28;
  level.weaponnamemap["contact_grenade_throw_zombies_mp"] = 29;
  level.weaponnamemap["explosive_drone_throw_zombie_mp"] = 30;
  level.weaponnamemap["distraction_drone_throw_zombie_mp"] = 31;
  level.weaponnamemap["dna_aoe_grenade_throw_zombie_mp"] = 32;
  level.weaponnamemap["iw5_titan45zm_mp"] = 33;
  level.weaponnamemap["LastStand"] = 34;
  level.weaponnamemap["iw5_microwavezm_mp"] = 35;
  level.weaponnamemap["iw5_linegunzm_mp"] = 36;
  level.weaponnamemap["frag_grenade_zombies_mp"] = 37;
  level.weaponnamemap["frag_grenade_throw_zombies_mp"] = 38;
  level.weaponnamemap["iw5_dlcgun2zm_mp"] = 39;
  level.weaponnamemap["iw5_dlcgun3zm_mp"] = 40;
  level.weaponnamemap["teleport_zombies_mp"] = 41;
  level.weaponnamemap["repulsor_zombie_mp"] = 42;
}

_id_09C8(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_1)) {
    var_1 = "none";
  }

  if(!isDefined(var_2)) {
    var_2 = "none";
  }

  if(!isDefined(var_3)) {
    var_3 = "none";
  }

  if(!_id_0547::_id_5844(var_0) && !_id_0547::isvalidequipmentzombies(var_0)) {
    return;
  }
  if(!isDefined(level.magicboxweapons)) {
    level.magicboxweapons = [];
  }

  var_6 = _getweaponmodel(var_0);
  var_7 = level.magicboxweapons.size;
  level.magicboxweapons[var_7]["baseNameNoMP"] = var_0;
  level.magicboxweapons[var_7]["baseNameNoZM"] = _func_2FF(var_0, "_zm");
  level.magicboxweapons[var_7]["baseName"] = var_0 + "_mp";
  level.magicboxweapons[var_7]["fullName"] = var_0 + "_mp";
  level.magicboxweapons[var_7]["displayModel"] = var_6;
  level.magicboxweapons[var_7]["attachment1"] = var_1;
  level.magicboxweapons[var_7]["attachment2"] = var_2;
  level.magicboxweapons[var_7]["attachment3"] = var_3;
  level.magicboxweapons[var_7]["limit"] = var_4;

  if(isDefined(var_5)) {
    level.magicboxweapons[var_7]["forceSelect"] = randomint(var_5);
  }

  if(!_id_0547::iszombieequipment(level.magicboxweapons[var_7]["baseName"])) {
    level.magicboxweapons[var_7]["fullName"] = maps\mp\gametypes\_class::buildweaponname(var_0, var_1, var_2, var_3, 0, 0, 0, 0, 0, 0, 0, 0);
  }

  var_9 = maps/_vehicle(level.magicboxweapons[var_7]["fullName"]);
  level.magicboxweapons[var_7]["displayString"] = var_9;
}

removemagicboxweapon(var_0) {
  var_1 = undefined;

  for(var_2 = 0; var_2 < level.magicboxweapons.size; var_2++) {
    if(level.magicboxweapons[var_2]["baseNameNoMP"] == var_0) {
      var_1 = var_2;
      break;
    }
  }

  if(isDefined(var_1)) {
    level.magicboxweapons = common_scripts\utility::_id_0F9A(level.magicboxweapons, var_1);
  }
}

magicboxthink() {
  level endon("game_ended");
  _id_5305();
  level._id_5F7C = 0;
  level.ondeckweapons = [];
  common_scripts\utility::flag_init("magic_box_init");
  common_scripts\utility::flag_init("magic_box_moved");
  level.magicboxlocations = getEntArray("magic_box", "targetname");

  if(level.magicboxlocations.size == 0) {
    return;
  }
  var_0 = undefined;

  foreach(var_12, var_2 in level.magicboxlocations) {
    level thread maps\mp\_utility::_id_6F74(::magicboxweaponvisibility, var_2);
    var_3 = getEntArray(var_2.target, "targetname");

    foreach(var_5 in var_3) {
      if(var_5.classname == "script_brushmodel") {
        var_2._id_24E3 = var_5;
        continue;
      }

      if(var_5.classname == "script_model") {
        var_2.modelent = var_5;
      }
    }

    var_7 = _getscriptablearray(var_2.target, "targetname");

    foreach(var_5 in var_7) {
      var_2.issighted = var_5;
    }

    var_10 = _id_456D(var_2);

    if(isDefined(var_2.modelent)) {
      if(isDefined(var_2.modelent.target)) {
        var_11 = _getEnt(var_2.modelent.target, "targetname");

        if(isDefined(var_11) && var_11._id_003B == "light") {
          var_2.light = var_11;
          var_2.light.lightonintensity = var_2.light getlightintensity();
          var_2.light.lightoffintensity = 0.1;
        }
      }
    }

    var_2._id_08BE = 0;
    var_2.isdispensingweapon = 0;
    var_2.ismoving = 0;

    if(isDefined(var_2.getnegotiationnextnode)) {
      common_scripts\utility::flag_init(var_2.getnegotiationnextnode);
    }

    if(isDefined(level._id_6AD1)) {
      [[level._id_6AD1]](var_2);
    }

    if(_id_0547::_id_5565(var_2.setlookatent, "start_location")) {
      var_0 = var_2;
    }
  }

  if(!isDefined(var_0)) {
    var_0 = common_scripts\utility::random(level.magicboxlocations);
  }

  var_0._id_08BE = 1;
  wait 2;

  foreach(var_2 in level.magicboxlocations) {
    _id_6AE1(var_2);
  }

  common_scripts\utility::flag_set("magic_box_init");

  for(;;) {
    watchmagicboxtrigger(var_0, 0);

    while(maps\mp\_utility::gameflag("fire_sale")) {
      while(maps\mp\_utility::gameflag("fire_sale") || var_0.isdispensingweapon) {
        wait 0.15;
      }

      var_0 notify("fireSaleOver");
    }

    common_scripts\utility::flag_set("magic_box_moved");
    var_15 = [];

    foreach(var_17 in level.magicboxlocations) {
      if(var_0 == var_17) {
        continue;
      }
      if(isscriptedmagicbox(var_17)) {
        continue;
      }
      if(var_17.isdispensingweapon) {
        continue;
      }
      var_15[var_15.size] = var_17;
    }

    if(var_15.size > 0) {
      var_0._id_08BE = 0;

      while(isDefined(var_0.deactivated)) {
        waitframe();
      }

      var_0 = var_15[randomint(var_15.size)];
      var_0._id_08BE = 1;
    }
  }
}

_id_08D7(var_0, var_1, var_2) {
  var_0.cost = _id_43FF(var_2);

  if(1 && isDefined(var_1)) {
    var_1._id_1B73 = 1;
    var_1._id_1B6F = var_0.cost;
    var_1._id_6642 = 1;
  }

  if(0) {
    var_0 setHintString(_id_4401());
    var_0 setsecondaryhintstring(_id_0547::_id_4474(var_0.cost));
  }
}

_id_2A7B(var_0, var_1) {
  if(0) {
    var_0 setHintString(_id_4520());
    var_0 setsecondaryhintstring(_id_0547::_id_4474(0));
  }

  if(1 && isDefined(var_1)) {
    var_1._id_1B73 = 0;
  }
}

_id_6AB4(var_0) {
  if(isDefined(level._id_08AD)) {
    [[level._id_08AD]](var_0);
  }

  var_1 = _id_456D(var_0);
  thread _id_135C(var_1);

  if(isDefined(var_0.light)) {
    var_0.light setlightintensity(var_0.light.lightonintensity);
  }

  if(isDefined(var_0.getnegotiationnextnode)) {
    common_scripts\utility::flag_set(var_0.getnegotiationnextnode);
  }

  if(isDefined(var_0._id_24E3)) {
    var_0._id_24E3 solid();
  }
}

_id_6AE1(var_0, var_1) {
  _id_2A7B(var_0);

  if(isDefined(level._id_2A77)) {
    [[level._id_2A77]](var_0);
  }

  var_2 = _id_456D(var_0);
  thread audio_magicbox_attract_off(var_2);

  if(isDefined(var_0.light)) {
    var_0.light setlightintensity(var_0.light.lightoffintensity);
  }

  if(isDefined(var_0.getnegotiationnextnode)) {
    common_scripts\utility::flag_clear(var_0.getnegotiationnextnode);
  }

  if(isDefined(var_0._id_24E3)) {
    var_0._id_24E3 notsolid();
  }
}

_id_5F73() {
  return common_scripts\utility::flag_exist("magic_box_moved") && common_scripts\utility::flag("magic_box_moved");
}

_id_135C(var_0) {
  if(!isDefined(var_0.soundent)) {
    var_1 = var_0.origin;

    if(isDefined(level._id_456E)) {
      var_1 = [[level._id_456E]](var_0);
    }

    var_0.soundent = spawn("script_origin", var_1);
    var_0.soundent scalevolume(0);
    waitframe();
  }

  _id_0378::snd_message("mystery_box_attract_on", var_0);
}

audio_magicbox_attract_off(var_0) {
  if(!isDefined(var_0.soundent)) {
    return;
  }
  var_0.soundent scalevolume(0, 1);
  wait 1;
  var_0.soundent stoploopsound();
  waitframe();
  var_0.soundent delete();
  _id_0378::snd_message("mystery_box_attract_off", var_0);
}

audio_magicbox_attract_in_use(var_0) {
  var_0.soundent scalevolume(0, 0.5);
  wait 0.5;
  var_0.soundent stoploopsound();
}

_id_1366() {
  var_0 = self;

  if(isDefined(var_0._id_6C1D)) {
    var_0._id_6C1D scalevolume(0, 0.5);
  }

  wait 3.5;

  if(isDefined(var_0._id_6C1D)) {
    var_0._id_6C1D scalevolume(1, 0.5);
  }
}

magicboxusewait() {
  self endon("fireSaleOver");
  self endon("deactivated");
  return _id_0547::waittilltriggerortokenuse();
}

isscriptedmagicbox(var_0) {
  return isDefined(var_0._id_0165) && var_0._id_0165 == "scripted_magic_box";
}

_id_7BEE() {
  self endon("deactivated");
  self endon("unregister_prompts");

  if(!isDefined(self._id_53FB)) {
    self._id_53FB = [];

    for(var_0 = 0; var_0 < 4; var_0++) {
      var_1 = spawnStruct();
      self._id_53FB = common_scripts\utility::_id_0F6F(self._id_53FB, var_1);
    }
  }

  if(!isDefined(self._id_4DBB)) {
    self._id_4DBB = [];

    for(var_0 = 0; var_0 < 4; var_0++) {
      var_1 = spawnStruct();
      self._id_4DBB = common_scripts\utility::_id_0F6F(self._id_4DBB, var_1);
    }
  }

  _id_86D1();

  for(;;) {
    level waittill("connected", var_2);
    _id_8A32(var_2);
  }
}

_id_A041() {
  self notify("unregister_prompts");

  foreach(var_1 in level.players) {
    var_2 = var_1 getentitynumber();
    var_3 = self._id_53FB[var_2];
    _id_2A7B(self, var_3._id_7778);
    var_3._id_7778.disabled = 1;
    var_4 = self._id_4DBB[var_2];
    var_4._id_4D91.disabled = 1;
  }
}

_id_8A32(var_0) {
  var_1 = var_0 getentitynumber();
  var_2 = self._id_53FB[var_1];

  if(isDefined(var_2._id_7778)) {
    var_2._id_7778.disabled = 0;
  } else {
    var_2._id_7778 = _id_0552::_id_7BED(var_0, self);
    var_2._id_7778._id_1B72 = self;
  }

  _id_08D7(self, var_2._id_7778, var_0);
  var_3 = self._id_4DBB[var_1];

  if(isDefined(var_3._id_4D91)) {
    var_3._id_4D91.disabled = 0;
  } else {
    var_3._id_4D91 = _id_0559::_id_7BE2(var_0, self, "mystery");
  }
}

_id_86D1() {
  if(1) {
    foreach(var_1 in level.players) {
      _id_8A32(var_1);
    }
  }
}

playsoundasmaster() {
  foreach(var_1 in level.magicboxlocations) {
    if(var_1._id_08BE) {
      var_1 _id_86D1();
    }
  }
}

_id_86D2(var_0, var_1) {
  var_2 = var_0 getentitynumber();
  var_3 = self._id_53FB[var_2];
  var_3._id_7778._id_1B73 = 2;
  var_3._id_7778._id_1B74 = var_1;
  var_3._id_7778._id_6642 = 1;
}

watchmagicboxtrigger(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = _randomintrange(4, 7);
  var_5 = _id_456D(var_0);
  var_6 = var_5.origin;
  var_0.lastweapon = "";

  if(isDefined(level._id_86C4)) {
    [[level._id_86C4]](var_0);
  }

  _id_6AB4(var_0);

  if(1) {
    var_0 thread _id_7BEE();
  }

  for(;;) {
    if(var_1 && !maps\mp\_utility::gameflag("fire_sale")) {
      break;
    }

    _id_08D7(var_0);
    var_0 _id_86D1();
    var_7 = var_0 magicboxusewait();

    if(!isDefined(var_7)) {
      break;
    }

    [var_9, var_10] = var_7;
    var_11 = var_9 _id_0573::_id_4B7B();
    var_12 = var_9 _id_056B::_id_9D1C();
    var_13 = var_9 _id_0579::_id_4BA5();
    var_14 = maps\mp\_utility::gameflag("fire_sale") || var_11 || isscriptedmagicbox(var_0) || var_13 || var_12;
    var_15 = var_3 >= var_4 && !var_14 && level.magicboxlocations.size > 1;
    var_16 = _id_43FF(var_9);
    var_17 = var_9 getcurrentprimaryweapon();

    if(_id_0547::isrippedturretweapon(var_17) || _id_0547::_id_5862(var_17)) {
      continue;
    }
    if(var_15 && !var_9 maps\mp\gametypes\zombies::canbuy(var_16)) {
      var_9 thread _id_054E::_id_0695("needmoney");
      continue;
    }

    if(!var_15 && !isDefined(self.deactivated)) {
      if(var_10 == "token") {
        var_9 maps\mp\gametypes\zombies::spendtoken(var_0.tokencost);
      } else if(!var_9 maps\mp\gametypes\zombies::attempttobuy(var_16)) {
        var_9 thread _id_054E::_id_0695("needmoney");
        continue;
      }
    }

    if(!var_15 && !isDefined(self.deactivated)) {
      if(var_2 == 0) {
        var_9 thread _id_054E::_id_73E4();
      }

      level notify("magicBoxUse", var_0);

      if(maps\mp\_utility::gameflag("fire_sale")) {} else if(var_12) {
        var_9 _id_056B::_id_9D1D();
      } else {
        var_9 _id_0573::_id_A21E();
      }

      var_0 common_scripts\utility::trigger_off();
      var_0.isdispensingweapon = 1;
      var_9 thread _id_054E::moneyspend();

      if(isDefined(level._id_6C08)) {
        [[level._id_6C08]](var_0, var_9);
      } else {
        wait 0.5;
      }

      if(!isDefined(var_0._id_A9C4)) {
        isholdinggrenade(var_9, var_0);
        isusingonlinedataoffline(var_0, var_0._id_A9C4["selectedWeapon"]);
      }

      var_18 = var_0._id_A9C4;
      var_0._id_A9C4 = undefined;
      var_0.lastweapon = var_18["baseName"];
      _id_0547::_id_4AE4(var_9, "magic_box", var_16, "none", "none");
      level._id_5F7C++;
      var_9._id_5F7C++;
      var_9 notify("magicBoxUse" + var_9._id_5F7C, var_18["baseNameNoMP"]);

      if(!isDefined(var_9.magicboxweaponsrolled)) {
        var_9.magicboxweaponsrolled = [];
      }

      var_9.magicboxweaponsrolled[var_9.magicboxweaponsrolled.size] = var_18["selectedWeapon"];
      level._id_400E[level._id_400E.size] = ["survivalist_set 3 -1", var_9];

      if(var_9._id_5F7C > 2 && level.wavecounter <= 30) {
        level._id_400E[level._id_400E.size] = ["survivalist_set 4 -1", var_9];
      }

      var_19 = var_18["displayString"];

      if(isDefined(var_0._id_5F7A)) {
        var_19 = [[var_0._id_5F7A]]();
      }

      if(0) {
        var_0 setHintString(var_19);
        var_0 setsecondaryhintstring("");
      }

      var_0 _id_86D2(var_9, var_18["baseNameNoMP"]);
      var_9 clientclaimtrigger(var_0);
      var_0 common_scripts\utility::trigger_on();
      var_0 notify("pickupReady");
      var_20 = 8;
      var_21 = gettime() + var_20 * 1000;
      level thread flashweaponmodel(var_0._id_586E);
      var_22 = "nothing";

      while(gettime() < var_21 && var_22 != "trigger") {
        var_23 = (var_21 - gettime()) / 1000;
        var_0 thread _id_08D8(var_23);
        var_24 = var_0 _id_0547::waittill_any_return_parms_no_endon_death("timeout", "trigger");
        var_0 notify("stopActiveMagicBoxTimeout");
        var_22 = var_24[0];

        if(var_22 == "timeout") {
          break;
        }

        var_25 = var_24[1];

        if(isDefined(var_0.magicboxcanpickupfunc)) {
          if(![[var_0.magicboxcanpickupfunc]](var_25)) {
            var_22 = "nothing";
          }
        } else {
          var_17 = var_25 getcurrentprimaryweapon();

          if(_id_0547::isrippedturretweapon(var_17) || _id_0547::_id_5862(var_17)) {
            var_22 = "nothing";
          }
        }

        if(var_22 == "trigger") {
          var_9 = var_25;
        }
      }

      _id_0378::snd_message("mystery_box_elec", var_5, 0);
      _id_0378::snd_message("mystery_box_close", var_5);
      _id_0378::snd_message("mystery_box_attract_closed", var_5);
      var_0 common_scripts\utility::trigger_off();
      var_0 releaseclaimedtrigger();
      var_0._id_586E notify("stop_flashing");
      var_0._id_586E.is_flashing = 0;
      var_0._id_586E hide();
      var_26 = var_18["selectedWeapon"];
      _id_ABE9("magicbox", self.origin, var_16, var_26);

      if(isDefined(level.zmb_events_player_zombie_weapon_from_box)) {
        var_9 thread[[level.zmb_events_player_zombie_weapon_from_box]](maps\mp\_utility::_id_4431(var_26));
      }

      if(isDefined(var_0._id_5F72)) {
        var_0[[var_0._id_5F72]](var_22, var_9);
      } else if(var_22 == "trigger" && maps\mp\_utility::isreallyalive(var_9) && !_id_0547::isplayerinlaststand(var_9)) {
        if(_id_0547::_id_73F9(var_9, var_26)) {
          var_9 _id_0586::_id_0790(var_26);
        }

        var_9 thread _id_054E::playerbuyweapon();

        if(_id_0547::iszombieequipment(var_26)) {
          _id_A7D5(var_9, var_26);
        } else if(_id_0547::_id_5864(var_26)) {
          wallbuygivemelee(var_9, var_26);
        } else {
          _id_A7D6(var_9, var_26);
        }
      }

      level.ondeckweapons = common_scripts\utility::_id_0F93(level.ondeckweapons, var_18["fullName"]);
      var_0.isdispensingweapon = 0;
      var_0 notify("magicBoxUseEnd");

      if(isDefined(level._id_2448)) {
        [[level._id_2448]](var_0);
      } else {
        wait 0.5;
      }

      thread _id_135C(var_5);
      var_2++;

      if(!var_14) {
        var_3++;
      }

      continue;
    }

    var_0 common_scripts\utility::trigger_off();
    var_0.ismoving = 1;

    if(isDefined(level._id_74C4)) {
      [[level._id_74C4]](var_0, var_9);
    }

    var_0.ismoving = 0;
    var_0 common_scripts\utility::trigger_on();
    break;
  }

  if(1) {
    var_0 _id_A041();
  }

  _id_6AE1(var_0);
}

_id_08D8(var_0) {
  self endon("stopActiveMagicBoxTimeout");
  wait(var_0);
  self notify("timeout");
}

flashweaponmodel(var_0) {
  var_0 endon("stop_flashing");
  wait 5;
  var_0.is_flashing = 1;

  for(;;) {
    var_0 ghost();
    wait 0.35;

    foreach(var_2 in level.players) {
      if(var_2 worldweaponsloaded(var_0.weaponname)) {
        var_0 showtoplayer(var_2);
      }
    }

    wait 0.35;
  }
}

isholdinggrenade(var_0, var_1) {
  var_2 = [];
  var_3 = "";
  var_4 = var_0 getweaponlistall();
  var_5 = [];

  foreach(var_7 in var_4) {
    var_8 = _func_3A5(var_7);
    var_5[var_5.size] = _id_0547::_id_9469(var_8["weapon"]);
  }

  foreach(var_16, var_11 in level.magicboxweapons) {
    var_12 = 1;

    foreach(var_7 in var_5) {
      if(var_11["baseNameNoMP"] == var_7) {
        var_12 = 0;
        break;
      }

      if(issubstr(var_7, "_pap_")) {
        var_14 = _id_0569::_id_40BD(var_7);

        if(var_11["baseNameNoMP"] == var_14) {
          var_12 = 0;
          break;
        }
      }
    }

    if(isDefined(var_1.lastweapon)) {
      if(var_1.lastweapon == var_11["baseName"]) {
        var_12 = 0;
      }
    }

    if(islimitreached(var_11)) {
      var_12 = 0;
    }

    if(isDefined(var_11["forceSelect"])) {
      if(var_11["forceSelect"] <= level._id_5F7C) {
        level.magicboxweapons[var_16]["forceSelect"] = undefined;
        var_2 = [var_11];
        break;
      } else
        var_12 = 0;
    }

    if(var_12) {
      var_2[var_2.size] = var_11;
    }
  }

  var_3 = var_2[randomint(var_2.size)];
  var_17 = "";

  if(var_0 _id_0579::_id_4BA5()) {
    var_17 = var_0 _id_0579::_id_A246();

    foreach(var_11 in level.magicboxweapons) {
      if(_id_0586::_id_0791(var_11["baseNameNoMP"], var_17)) {
        var_3 = var_11;
        break;
      }
    }
  } else if(level._id_2B6F) {
    if(randomint(100) < level._id_2B70) {
      var_17 = "jack_in_box_decoy_zm";

      foreach(var_11 in level.magicboxweapons) {
        if(var_17 == var_11["baseNameNoMP"]) {
          var_3 = var_11;
          break;
        }
      }
    } else
      level._id_2B70 = level._id_2B70 + level._id_2B6E;
  }

  if(var_3["baseNameNoMP"] == "jack_in_box_decoy_zm") {
    level._id_2B6F = 0;
  }

  level.ondeckweapons[level.ondeckweapons.size] = var_3["fullName"];

  if(issubstr(var_3["fullName"], "_classic")) {
    var_25 = var_3["fullName"];
  } else {
    var_25 = _id_454B(var_0, var_3["fullName"]);
  }

  if(issubstr(var_3["fullName"], "_pap_")) {
    var_26 = _id_0569::_id_40BD(var_25);
    var_25 = var_0 _id_0586::_id_078B(var_26);
  }

  var_3["selectedWeapon"] = var_25;
  var_1._id_A9C4 = var_3;
}

islimitreached(var_0) {
  if(!isDefined(var_0["limit"])) {
    return 0;
  }

  var_1 = level.ondeckweapons;

  foreach(var_3 in level.players) {
    var_4 = var_3 getweaponlistall();
    var_1 = common_scripts\utility::_id_0F73(var_1, var_4);
  }

  var_6 = 0;
  var_7 = var_0["limit"];

  foreach(var_9 in var_1) {
    var_10 = _func_3A5(var_9);
    var_11 = _id_0547::_id_9469(var_10["weapon"]);

    if(var_11 == var_0["baseNameNoMP"]) {
      var_6++;
    }
  }

  return var_6 >= var_7;
}

_id_4401() {
  var_0 = &"ZOMBIES_EMPTY_STRING";

  if(isDefined(level._id_4400)) {
    var_0 = [[level._id_4400]]();
  }

  return var_0;
}

_id_4520() {
  var_0 = &"ZOMBIES_EMPTY_STRING";

  if(isDefined(level._id_451F)) {
    var_0 = [[level._id_451F]]();
  }

  return var_0;
}

_id_43FF(var_0) {
  if(maps\mp\_utility::gameflag("fire_sale")) {
    return int(10);
  }

  if(isPlayer(var_0) && var_0 _id_056B::_id_9D1C()) {
    return int(0);
  }

  var_1 = int(1000);

  if(isDefined(level.penaltycostincrease)) {
    for(var_2 = 0; var_2 < level.penaltycostincrease; var_2++) {
      var_1 = _id_0547::getincreasedcost(var_1);
    }
  }

  if(isPlayer(var_0) && var_0 _id_0573::_id_4B7B()) {
    var_1 = var_1 * var_0._id_65EC._id_267C;
  }

  return int(var_1);
}

_id_4794() {}

weaponlevelboxinit() {
  initcamolevels();
  level.weaponlevelboxes = getEntArray("weapon_level_box", "targetname");
  common_scripts\utility::_id_0FB2(level.weaponlevelboxes, ::weaponlevelboxthink);
}

weaponlevelboxsetupspecialbox() {
  if(!isDefined(self.modelent) || !isDefined(self.modelent.target) || isDefined(self.modelent.light)) {
    return;
  }
  var_0 = _getEnt(self.modelent.target, "targetname");

  if(isDefined(var_0) && var_0._id_003B == "light") {
    self.modelent.light = var_0;
    self.modelent.light.lightonintensity = self.modelent.light getlightintensity();
    self.modelent.light.lightoffintensity = 0.1;
    self.modelent.light.ison = 1;
  }
}

weaponlevelboxturnonlight() {
  if(isDefined(self.modelent.light) && isDefined(self.modelent.light.lightoffintensity) && isDefined(self.modelent.light.ison) && !self.modelent.light.ison) {
    self.modelent.light setlightintensity(self.modelent.light.lightonintensity);
    self.modelent.light.ison = 1;
  }
}

weaponlevelboxturnofflight() {
  if(isDefined(self.modelent.light) && isDefined(self.modelent.light.lightoffintensity) && isDefined(self.modelent.light.ison) && self.modelent.light.ison) {
    self.modelent.light setlightintensity(self.modelent.light.lightoffintensity);
    self.modelent.light.ison = 0;
  }
}

isspecialweaponbox(var_0) {
  return isDefined(var_0._id_0165) && var_0._id_0165 == "special";
}

weaponlevelboxisplayerweaponmaxed(var_0, var_1) {
  return !isspecialweaponbox(self) && var_0.weaponstate[var_1]["level"] >= 20 || isspecialweaponbox(self) && var_0.weaponstate[var_1]["level"] >= 25;
}

weaponlevelboxupdatehintstrings(var_0) {
  var_0 endon("disconnect");

  for(;;) {
    var_1 = var_0 _id_0547::waittill_any_return_parms_no_endon_death("weapon_change", "no_upgrades");
    var_2 = undefined;

    if(var_1[0] == "no_upgrades" && self._id_0C2F) {
      continue;
    }
    switch (var_1[0]) {
      case "weapon_change":
        var_2 = var_1[1];
        break;
      case "no_upgrades":
        self setHintString("");
        self setsecondaryhintstring("");
        var_0 waittill("allow_upgrades");
        var_2 = _id_0547::getplayerweaponzombies(var_0);
        break;
    }

    var_3 = _getweaponbasename(var_2);
    self setCursorHint("HINT_NOICON");

    if(!_id_0547::haszombieweaponstate(var_0, var_3) || !weaponlevelboxisplayerweaponmaxed(var_0, var_3)) {
      self setHintString(&"ZOMBIES_WEAPON_LEVEL_BOX");
      self setsecondaryhintstring(&"ZOMBIES_COST_2500");
      continue;
    }

    self setHintString("");
    self setsecondaryhintstring("");
  }
}

_id_2A76() {
  self.deactivated = 1;
  self notify("deactivated");
}

_id_7AAB() {
  self.deactivated = undefined;
}

weaponlevelboxthink() {
  level endon("game_ended");
  self.modelent = _getEnt(self.target, "targetname");
  self._id_0C2F = 1;

  if(isspecialweaponbox(self)) {
    weaponlevelboxsetupspecialbox();
    weaponlevelboxturnofflight();
    common_scripts\utility::trigger_off();
    level waittill("special_weapon_box_unlocked");
    weaponlevelboxturnonlight();
  }

  var_0 = self.modelent gettagangles("tag_origin");
  self.modelent playLoopSound("interact_weapon_upgrade_attract");

  if(_id_0547::isusetriggerprimary(self)) {
    _id_0547::playfxontagnetwork(common_scripts\utility::getfx("station_upgrade_weapon_pwr_on"), self.modelent, "tag_origin");
  }

  _id_0547::setupusetriggerforclient(self, ::weaponlevelboxupdatehintstrings);
  var_1 = int(self.setlookatent);

  if(isDefined(level.penaltycostincrease)) {
    for(var_2 = 0; var_2 < level.penaltycostincrease; var_2++) {
      var_3 = _id_0547::getincreasedcost(var_1);
      var_1 = var_3;
    }
  }

  for(;;) {
    [var_5, var_6] = _id_0547::waittilltriggerortokenuse();
    var_7 = _id_0547::getplayerweaponzombies(var_5);
    var_8 = _getweaponbasename(var_7);

    if(!_id_0547::haszombieweaponstate(var_5, var_8)) {
      continue;
    }
    if(weaponlevelboxisplayerweaponmaxed(var_5, var_8)) {
      _id_2EDF(var_5);
      continue;
    }

    if(isspecialweaponbox(self) && var_5.weaponstate[var_8]["level"] != 20) {
      displayrequiredlevelmessage(var_5);
      continue;
    }

    if(var_6 == "token") {
      var_5 maps\mp\gametypes\zombies::spendtoken(self.tokencost);
    } else if(!var_5 maps\mp\gametypes\zombies::attempttobuy(var_1)) {
      var_5 thread _id_054E::_id_0695("needmoney");
      continue;
    }

    self._id_0C2F = 0;

    foreach(var_10 in level.players) {
      var_10 notify("no_upgrades");
    }

    var_12 = undefined;

    if(level._id_010B) {
      var_13 = findholomodel(var_8);
      var_12 = spawn("script_model", self.origin);
      var_12.angles = var_0 - (0, 90, 0);
      var_12 setModel(var_13);
      var_14 = [15, 0, -6];

      if(var_8 == "iw5_exocrossbowzm_mp") {
        var_14 = [13, 0, -13];
        var_12.angles = var_12.angles + (0, 0, -90);
      }

      level thread centerweaponforwallbuy(self.modelent, var_12, var_14);
    }

    _id_0547::playfxontagnetwork(common_scripts\utility::getfx("station_upgrade_weapon"), self.modelent, "tag_origin", 1);
    self.modelent playSound("interact_weapon_upgrade");

    if(isspecialweaponbox(self)) {
      setweaponlevel(var_5, var_7, 25);
    } else {
      setweaponlevel(var_5, var_7, var_5.weaponstate[var_8]["level"] + 1);
    }

    var_5 thread _id_054E::_id_7491(isspecialweaponbox(self), var_5.weaponstate[var_8]["level"]);
    var_5._id_68A0++;
    wait 1.2;

    if(var_5.weaponstate[var_8]["level"] > 19) {
      _id_0547::playfxontagnetwork(common_scripts\utility::getfx("weapon_level_20"), self.modelent, "tag_origin", 1);
      self.modelent playSound("interact_weapon_upgrade_fwks");
    }

    wait 0.75;

    if(isDefined(var_12)) {
      var_12 delete();
    }

    self._id_0C2F = 1;

    foreach(var_10 in level.players) {
      var_10 notify("allow_upgrades");
    }
  }
}

setweaponlevel(var_0, var_1, var_2) {
  var_0 _id_0586::_id_0790(var_1);
  var_3 = _getweaponbasename(var_1);
  var_0.weaponstate[var_3]["level"] = var_2;
  var_4 = _id_454B(var_0, var_3);
  _id_A7D6(var_0, var_4, 0);

  if(issubstr(var_4, "iw5_em1zm_mp")) {
    var_0 maps\mp\gametypes\zombies::playersetem1maxammo();
  }

  if(isDefined(level.setweaponlevelfunc)) {
    var_0[[level.setweaponlevelfunc]](var_1, var_2);
  }

  var_0 playsoundtoplayer("mp_s1_earn_medal", var_0);
}

findholomodel(var_0) {
  foreach(var_2 in level.magicboxweapons) {
    if(var_2["baseName"] == var_0) {
      return var_2["displayModel"];
    }
  }

  foreach(var_2 in level._id_A7F1) {
    if(var_2["baseName"] == var_0) {
      return var_2["displayModel"];
    }
  }

  return "npc_titan45_base_static_holo";
}

_id_454B(var_0, var_1) {
  if(var_1 == "none") {
    return "none";
  }

  var_2 = _id_0547::_id_AAF9(var_1, 1, 1);
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = [];
  var_8 = _id_056C::_id_4735(var_0, var_1);

  if(isDefined(var_8)) {
    if(var_8._id_A9F8) {
      var_4 = _func_314(var_8._id_A9F8);
      var_9 = _func_311(var_8._id_A9F8);

      if(var_9 != "") {
        var_2 = _func_2FF(var_9, "_mp") + "_zm";
      }
    }

    if(var_8._id_7E18) {
      var_5 = var_8._id_7E18;
    }

    if(var_8._id_1EC0) {
      var_3 = var_8._id_1EC0;
    }

    if(var_8._id_297C) {
      var_6 = var_8._id_297C;
    }

    var_7 = common_scripts\utility::_id_0F73(var_7, var_8._id_114C);
  }

  var_10 = _getweaponbasename(var_1);

  for(var_7 = _id_0547::_id_0FB9(var_7); var_7.size < 6; var_7[var_7.size] = 0) {}

  var_11 = maps\mp\gametypes\_class::buildweaponname(var_2, var_7[0], var_7[1], var_7[2], var_7[3], var_7[4], var_7[5], var_4, var_3, 0, var_5, var_6, var_0, undefined);
  return var_11;
}

getcamoforweaponlevel(var_0, var_1) {
  var_1 = int(_min(var_1, level.camolevel.size - 1));
  return level.camolevel[var_1];
}

getattachment1forweaponlevel(var_0, var_1) {
  var_2 = getmagicboxweapondefaultattachment(var_0, "attachment1");

  if(var_1 > 3) {
    switch (var_0) {
      case "iw5_m182sprzm_mp":
      case "iw5_hbra3zm_mp":
      case "iw5_dlcgun1zm_mp":
      case "iw5_ak12zm_mp":
        var_2 = "opticseotech";
        break;
      case "iw5_em1zm_mp":
      case "iw5_arx160zm_mp":
      case "iw5_exocrossbowzm_mp":
      case "iw5_sn6zm_mp":
      case "iw5_bal27zm_mp":
        var_2 = "variablereddot";
        break;
      case "iw5_uts19zm_mp":
      case "iw5_maulzm_mp":
      case "iw5_mp11zm_mp":
      case "iw5_asm1zm_mp":
      case "iw5_vbrzm_mp":
      case "iw5_microwavezm_mp":
        var_2 = "opticsreddot";
        break;
      case "iw5_asawzm_mp":
        var_2 = "opticsthermalar";
        break;
      case "iw5_hmr9zm_mp":
        var_2 = "opticsthermal";
        break;
      case "iw5_dlcgun2zm_mp":
      case "iw5_linegunzm_mp":
      case "iw5_fusionzm_mp":
      case "iw5_himarzm_mp":
      case "iw5_lsatzm_mp":
      case "iw5_rhinozm_mp":
      case "iw5_rw1zm_mp":
      case "iw5_titan45zm_mp":
        var_2 = "opticstargetenhancer";
        break;
      case "iw5_dlcgun3zm_mp":
      case "iw5_sac3zm_mp":
        var_2 = "lasersight";
        break;
      case "iw5_mahemzm_mp":
        var_2 = "quickdraw";
        break;
      case "iw5_gm6zm_mp":
        var_2 = "opticsacog2";
        break;
    }
  }

  return var_2;
}

getattachment2forweaponlevel(var_0, var_1) {
  var_2 = getmagicboxweapondefaultattachment(var_0, "attachment2");

  if(var_1 > 6) {
    switch (var_0) {
      case "iw5_uts19zm_mp":
      case "iw5_maulzm_mp":
      case "iw5_hmr9zm_mp":
      case "iw5_hbra3zm_mp":
      case "iw5_mp11zm_mp":
      case "iw5_arx160zm_mp":
      case "iw5_asm1zm_mp":
      case "iw5_himarzm_mp":
      case "iw5_bal27zm_mp":
      case "iw5_ak12zm_mp":
      case "iw5_asawzm_mp":
      case "iw5_rhinozm_mp":
        var_2 = "lasersight";
        break;
      case "iw5_dlcgun2zm_mp":
      case "iw5_m182sprzm_mp":
      case "iw5_dlcgun1zm_mp":
      case "iw5_fusionzm_mp":
      case "iw5_lsatzm_mp":
        var_2 = "stock";
        break;
      case "iw5_em1zm_mp":
      case "iw5_dlcgun3zm_mp":
      case "iw5_linegunzm_mp":
      case "iw5_gm6zm_mp":
      case "iw5_vbrzm_mp":
      case "iw5_rw1zm_mp":
      case "iw5_titan45zm_mp":
        var_2 = "quickdraw";
        break;
      case "iw5_sac3zm_mp":
      case "iw5_sn6zm_mp":
        var_2 = "firerate";
        break;
      case "iw5_mahemzm_mp":
      case "iw5_exocrossbowzm_mp":
        var_2 = "xmags";
        break;
    }
  }

  return var_2;
}

getattachment3forweaponlevel(var_0, var_1) {
  var_2 = getmagicboxweapondefaultattachment(var_0, "attachment3");

  if(var_1 > 9) {
    switch (var_0) {
      case "iw5_em1zm_mp":
      case "iw5_arx160zm_mp":
      case "iw5_mahemzm_mp":
      case "iw5_himarzm_mp":
      case "iw5_bal27zm_mp":
      case "iw5_ak12zm_mp":
        var_2 = "stock";
        break;
      case "iw5_dlcgun2zm_mp":
      case "iw5_hbra3zm_mp":
      case "iw5_mp11zm_mp":
      case "iw5_exocrossbowzm_mp":
      case "iw5_asm1zm_mp":
      case "iw5_asawzm_mp":
      case "iw5_lsatzm_mp":
        var_2 = "quickdraw";
        break;
      case "iw5_dlcgun3zm_mp":
      case "iw5_uts19zm_mp":
      case "iw5_m182sprzm_mp":
      case "iw5_maulzm_mp":
      case "iw5_hmr9zm_mp":
      case "iw5_dlcgun1zm_mp":
      case "iw5_fusionzm_mp":
      case "iw5_sac3zm_mp":
      case "iw5_sn6zm_mp":
      case "iw5_rhinozm_mp":
      case "iw5_gm6zm_mp":
      case "iw5_vbrzm_mp":
      case "iw5_rw1zm_mp":
      case "iw5_titan45zm_mp":
        var_2 = "xmags";
        break;
      case "iw5_linegunzm_mp":
        var_2 = "xmagslinegun";
        break;
    }
  }

  return var_2;
}

getmagicboxweapondefaultattachment(var_0, var_1) {
  var_2 = "none";

  foreach(var_4 in level.magicboxweapons) {
    if(var_4["baseName"] == var_0) {
      var_2 = var_4[var_1];
      break;
    }
  }

  return var_2;
}

displayrequiredlevelmessage(var_0) {
  var_0 playsoundtoplayer("zmb_ui_purchase_fail", var_0);
}

_id_2EDF(var_0) {
  var_0 playsoundtoplayer("zmb_ui_purchase_fail", var_0);
}

initcamolevels() {
  var_0 = "mp/zmWeaponLevels.csv";
  level.camolevel = [];

  for(var_1 = 0; var_1 <= 25; var_1++) {
    var_2 = int(tablelookup(var_0, 0, var_1, 1));
    level.camolevel[var_1] = var_2;
  }
}

_id_A7E7(var_0) {
  var_0._id_9DA0++;

  if(var_0._id_9DA0 == 1) {
    var_0 common_scripts\utility::trigger_off();
  }
}

_id_A7E8(var_0) {
  var_0._id_9DA0--;

  if(var_0._id_9DA0 == 0) {
    var_0 common_scripts\utility::trigger_on();
  }
}

wallbuydisable(var_0) {
  var_0.weaponent hide();
  _id_0547::killfxontagnetwork(common_scripts\utility::getfx("station_buy_weapon_pwr_on"), var_0.modelent, "tag_origin");
  _id_A7E7(var_0);
}

wallbuyenable(var_0) {
  var_0.weaponent show();
  _id_0547::playfxontagnetwork(common_scripts\utility::getfx("station_buy_weapon_pwr_on"), var_0.modelent, "tag_origin");
  _id_A7E8(var_0);
}

weaponlevelrestoretriggerhintstring(var_0) {
  _id_0547::setupusetriggerforclient(var_0, ::weaponlevelboxupdatehintstrings);
}

weaponlevelboxdisable(var_0) {
  _id_0547::killfxontagnetwork(common_scripts\utility::getfx("station_upgrade_weapon_pwr_on"), var_0.modelent, "tag_origin");
  var_0 weaponlevelboxturnofflight();
  var_0 common_scripts\utility::trigger_off();
}

weaponlevelboxenable(var_0) {
  _id_0547::playfxontagnetwork(common_scripts\utility::getfx("station_upgrade_weapon_pwr_on"), var_0.modelent, "tag_origin");
  var_0 weaponlevelboxturnonlight();
  var_0 common_scripts\utility::trigger_on();
  thread weaponlevelrestoretriggerhintstring(var_0);
}

_id_0DB7() {
  var_0 = getEntArray("ammocrate_trigger", "targetname");
  var_1 = 500;

  foreach(var_3 in var_0) {
    thread _id_0DB8(var_3, var_1);
  }
}

_id_0DB8(var_0, var_1) {
  var_0 useTriggerRequireLookAt();
  var_0 setHintString(&"ZOMBIES_AMMO_CRATE_HINT");
  var_0 setsecondaryhintstring(&"ZOMBIES_COST_500");

  for(;;) {
    [var_3, var_4] = var_0 _id_0547::waittilltriggerortokenuse();
    var_5 = _id_0547::getplayerweaponzombies(var_3);
    var_6 = 0;

    if(_id_4B6A(var_3, var_5)) {
      displayfullammomessage(var_3, var_6);
      continue;
    }

    if(var_3 maps\mp\gametypes\zombies::attempttobuy(var_1)) {
      var_3 iprintlnbold("refill");
      _id_3AC1(var_3, var_5);
      var_3 givemaxammo(var_5);
      var_3 thread _id_054E::moneyspend();
    }
  }
}
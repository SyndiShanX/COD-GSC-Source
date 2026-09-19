/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1245.gsc
**************************************/

init() {
  if(!isDefined(level._id_83E9))
    level._id_83E9 = [];

  level._id_83EA["sentry_minigun"] = "sentry";
  level._id_83E9["sentry_minigun"] = spawnStruct();
  level._id_83E9["sentry_minigun"].health = 999999;
  level._id_83E9["sentry_minigun"].maxhealth = 1000;
  level._id_83E9["sentry_minigun"]._id_1DC4 = 20;
  level._id_83E9["sentry_minigun"]._id_1DC3 = 120;
  level._id_83E9["sentry_minigun"]._id_6F26 = 0.15;
  level._id_83E9["sentry_minigun"]._id_6F25 = 0.35;
  level._id_83E9["sentry_minigun"]._id_83E8 = "sentry";
  level._id_83E9["sentry_minigun"]._id_83E7 = "sentry_offline";
  level._id_83E9["sentry_minigun"]._id_9A01 = 90.0;
  level._id_83E9["sentry_minigun"]._id_90FA = 0.05;
  level._id_83E9["sentry_minigun"]._id_6CA3 = 8.0;
  level._id_83E9["sentry_minigun"]._id_2650 = 0.1;
  level._id_83E9["sentry_minigun"]._id_3F84 = 0.3;
  level._id_83E9["sentry_minigun"]._id_944C = "sentry";
  level._id_83E9["sentry_minigun"]._id_01D1 = "sentry_supplydrop_mp";
  level._id_83E9["sentry_minigun"]._id_6294 = "hub_lootcrate_normal";
  level._id_83E9["sentry_minigun"]._id_629D = "tag_origin";
  level._id_83E9["sentry_minigun"]._id_629E = "tag_origin";
  level._id_83E9["sentry_minigun"]._id_6295 = "hub_lootcrate_normal";
  level._id_83E9["sentry_minigun"]._id_00C5 = &"SENTRY_PICKUP";
  level._id_83E9["sentry_minigun"]._id_00BA = 1;
  level._id_83E9["sentry_minigun"]._id_9869 = "used_sentry";
  level._id_83E9["sentry_minigun"]._id_8BAB = 0;
  level._id_83E9["sentry_minigun"]._id_A5F7 = "sentry_destroyed";
  level._effect["supply_drop_landing_impact_ground"] = loadfx("vfx/smoke/supply_drop_landing_impact_ground");
  level._effect["supply_drop_opening_ground"] = loadfx("vfx/smoke/supply_drop_opening_ground");
  var_0 = loadfx("vfx/unique/supply_drop_impactpulse");
  var_1 = loadfx("vfx/unique/supply_drop_impactpulse_blue");
  var_2 = loadfx("vfx/unique/supply_drop_impactpulse_red");
  var_3 = loadfx("vfx/unique/supply_drop_impactpulse_violet");
  var_4 = loadfx("vfx/unique/supply_drop_impactpulse_heroic");
  level._id_7A71 = [var_0, var_1, var_3, var_2, var_4];
  var_5 = loadfx("vfx/unique/supply_drop_shine_heroic");
  var_6 = loadfx("vfx/unique/supply_drop_shine_red");
  var_7 = loadfx("vfx/unique/supply_drop_shine_violet");
  var_8 = loadfx("vfx/unique/supply_drop_shine_blue");
  var_9 = loadfx("vfx/unique/supply_drop_shine");
  level.zombieimpactfx = loadfx("vfx/unique/supply_drop_impactpulse_zombie");
  level._id_7A72 = [var_9, var_8, var_7, var_6, var_5];
  setDvar("1601", 64);
  setDvar("1730", 0.2);
  setDvar("4002", 0);
  setDvar("3512", 0);
  setdvarifuninitialized("hub_numDevCards", 3);
  level._id_08DE = [];
}

cleanupplayerforsupplydrop() {
  if(_id_028D::_id_5855())
    _id_028D::_id_239A();
}

_id_11BF(var_0) {
  self endon("disconnect");
  cleanupplayerforsupplydrop();
  var_1 = isDefined(self._id_537A) && self._id_537A;

  if(var_1) {
    _id_743D(1);
    _id_A85E();
  }

  self _meth_85EF(&"supply_drop_player_warp_complete");
  self _meth_82FF("ui_hub_prep_supplydrop", 1);

  for(;;) {
    self waittill("luinotifyserver", var_2, var_3);

    if(var_2 != "supply_drop_menu_closed") {
      continue;
    }
    if(var_3) {
      break;
    }
  }

  if(_id_2865() && !_id_04E0::_id_5790() && self _meth_85AC(var_0) > 0 && getdvarint("spv_hub_psd_kswitch", 1) == 0)
    _id_1718(var_0, !var_1);
  else {
    self _meth_82FF("ui_hub_prep_supplydrop", 0);

    if(self _meth_85AC(var_0) <= 0 && !_id_04E0::_id_5790())
      thread _id_04E0::_id_3010("outOfSDs", &"HUB_OUT_OF_SD", undefined, -100, 1.65, 1);
  }
}

_id_1718(var_0, var_1) {
  self endon("death");
  self endon("disconnect");

  if(self._id_56A4) {
    if(isDefined(self._id_155F))
      self._id_155F _id_04E0::_id_1543((0, 0, 80), self);
  }

  self._id_572B = 1;
  _id_04E0::_id_870B(1);
  self._id_4DEF = undefined;
  thread _id_280A();
  _id_8646();
  _id_63CC(var_0, var_1);
}

_id_280A() {
  self._id_4DEF = _func_016("misc_turret", self.origin, level._id_83E9["sentry_minigun"]._id_01D1);
  self._id_4DEF _meth_80B3();
  self._id_4DEF._id_83EA = "sentry_minigun";
  self._id_4DEF.angles = self.angles + (0, 0, 90);
  self._id_4DEF.targetname = "holoPSD";
}

_id_8646() {
  self endon("death");
  self endon("disconnect");
  self._id_4DEF _meth_806C("supplydrop");
  self._id_4DEF setModel(level._id_83E9[self._id_4DEF._id_83EA]._id_629D);
  self._id_4DEF _meth_80F9(self);
  self._id_4DEF _meth_80FA(self);
  self._id_4DEF._id_2002 = self;
  self _meth_82FF("ui_hub_enable_pause", 0);
  _id_7424();
  self _meth_85B4();
  self _meth_85B2(1, "mp_unarmed_stand_flare_pull");
  self _meth_85B3(1);
  self attach("npc_usa_m18_smoke_green", "tag_weapon_right");
  thread _id_9BC5();
  thread oncarrierdeathordisconnect();
}

_id_956A() {
  self endon("death");
  self endon("disconnect");
  wait 0.866667;
}

_id_9BC5() {
  self endon("death");
  self endon("disconnect");
  self._id_4DEF endon("placed");
  self._id_4DEF endon("death");
  self._id_4DEF._id_1F2F = 1;
  var_0 = -1;
  var_1 = self _meth_85E1(0);
  var_2 = self _meth_85E1(1);

  for(;;) {
    if(isDefined(self._id_4DEF)) {
      var_3 = self _meth_82D6(1, 35);
      self._id_4DEF.origin = var_3["origin"];
      self._id_4DEF.angles = var_3["angles"];
      self._id_4DEF._id_1F2F = _id_2865() && self _meth_8346() && var_3["result"] && _id_21EE(self._id_4DEF) && _func_0AE(self._id_4DEF.origin[2] - self.origin[2]) < 8;

      if(self._id_4DEF._id_1F2F) {
        var_4 = self._id_4DEF.origin - self.origin;
        var_4 = vectortoangles(var_4);
        var_4 = var_4 * (0, 1, 0);
        var_5 = self.origin + (0, 0, 73);
        var_6 = self.origin + anglestoright(var_4) * 55 + anglesToForward(var_4) * -60 + (0, 0, 73);
        var_7 = bulletTrace(var_5, var_6, 1, self);
        self._id_4DEF._id_1F2F = var_7["fraction"] == 1.0;
      }

      if(self._id_4DEF._id_1F2F != var_0) {
        if(self._id_4DEF._id_1F2F) {
          _func_295(level._id_94F2, self._id_4DEF, "TAG_ORIGIN", self);
          waitframe();
          _func_14D(level._id_94F1, self._id_4DEF, "TAG_ORIGIN", self);
          self _meth_80D0(&"HUB_VALID_PSD");
        } else {
          _func_295(level._id_94F1, self._id_4DEF, "TAG_ORIGIN", self);
          waitframe();
          _func_14D(level._id_94F2, self._id_4DEF, "TAG_ORIGIN", self);
          self _meth_80D0(&"HUB_INVALID_PSD");
        }
      }

      var_0 = self._id_4DEF._id_1F2F;
      waitframe();

      if(var_1 != self _meth_85E1(0) || var_2 != self _meth_85E1(1)) {
        var_1 = self _meth_85E1(0);
        var_2 = self _meth_85E1(1);
      }

      continue;
    }

    return;
  }
}

_id_63CC(var_0, var_1) {
  self endon("death");
  self endon("disconnect");

  if(var_1) {
    if(!_func_0C1(self)) {
      self _meth_8305(0);
      self _meth_82E1("place_PSD", "+gostand");
      self _meth_82E1("place_PSD", "+attack");
      self _meth_82E1("cancel_PSD", "+stance");
      self _meth_82E1("pauseButton", "togglemenu");
    }

    for(;;) {
      var_2 = common_scripts\utility::_id_A715("place_PSD", "cancel_PSD", "force_cancel_placement", "pauseButton");

      if(var_2 == "cancel_PSD" || var_2 == "force_cancel_placement" || var_2 == "pauseButton") {
        thread _id_3F01();
        return;
      }

      if(self._id_4DEF._id_1F2F) {
        while(!self _meth_8346())
          waitframe();

        break;
      }

      var_3 = _id_0380::_id_2888("ui_negate", self);
      wait 0.3;
    }

    self _meth_84A7("place_PSD", "+gostand");
    self _meth_84A7("place_PSD", "+attack");
    self _meth_84A7("cancel_PSD", "+stance");
    self _meth_84A7("pauseButton", "togglemenu");
    self _meth_8305(1);
  } else
    self.warpingtosupplydrop = undefined;

  self _meth_80D1();

  if(getdvarint("hub_noPSDPlayerLock") == 0) {
    self freezecontrols(1);
    wait 0.1;
  }

  _id_04E0::_id_86A9(0);
  _id_2D6C(var_0);
}

_id_2D6C(var_0) {
  self endon("disconnect");
  self endon("death");
  var_1 = vectorNormalize(self._id_4DEF.origin - self.origin);
  var_1 = vectortoangles(var_1);
  var_1 = self.origin + anglesToForward(var_1) * 70;
  var_2 = self._id_4DEF.angles;
  thread _id_7421(var_1);
  _id_36E1(var_1);
  wait 1;
  self notify("beginReactionAnims");
  thread _id_34A7(var_1, var_2, var_0);
  self._id_4B84 = 1;
}

_id_3F01() {
  _id_36E1();
  thread _id_7422();
  self _meth_84A7("place_PSD", "+gostand");
  self _meth_84A7("place_PSD", "+attack");
  self _meth_84A7("cancel_PSD", "+stance");
  self _meth_84A7("pauseButton", "togglemenu");
  self _meth_80D1();
  self _meth_8305(1);
  self _meth_82FF("ui_hub_enable_pause", 1);
  self _meth_82FF("ui_hub_prep_supplydrop", 0);
  self _meth_82FF("hub_hide_killfeed", 0);
}

_id_34A7(var_0, var_1, var_2) {
  self._id_08DD = spawn("script_model", var_0);
  self._id_08DD setModel(_id_441F(var_2));
  self._id_08DD._id_2742 = var_2;
  self._id_08DD _meth_8385(self);
  thread _id_2343(self._id_08DD);
  self._id_08DD._id_5F0A = 0;
  self._id_08DD._id_579E = 0;
  self._id_08DD.origin = var_0;
  self._id_08DD.angles = (0, var_1[1] + 180, 0);
  self._id_08DD _meth_8278("mp_hub_crate_drop", "psd_drop_notetrack");
  self._id_08DD _meth_805B();
  thread _id_77A5(self._id_08DD, 1);
  _id_7FAF(var_2);
}

_id_86E7() {
  self endon("supplydrop_timeout");
  self endon("death");
  self endon("disconnect");
  self endon("autoFinishSupplyDrop");
  var_0 = 85;

  while(!self._id_2759) {
    foreach(var_2 in level.players) {
      if(isDefined(var_2) && var_2 != self) {
        if(distance(var_2.origin, self.origin) > var_0) {
          var_2 _meth_8005(self);
          continue;
        }

        var_2 _meth_8006(self);
      }
    }

    wait 0.1;
  }

  foreach(var_2 in level.players) {
    if(isDefined(var_2) && var_2 != self)
      var_2 _meth_8005(self);
  }
}

_id_441F(var_0, var_1) {
  var_2 = isDefined(var_1) && var_1;
  var_3 = "";

  if(var_2) {
    var_3 = tablelookup("mp/supplyDropTypes.csv", 1, var_0, 10);

    if(var_3 == "")
      var_3 = "hub_lootcrate_normal_fade";
  } else {
    var_3 = tablelookup("mp/supplyDropTypes.csv", 1, var_0, 9);

    if(var_3 == "")
      var_3 = "hub_lootcrate_normal";
  }

  return var_3;
}

_id_77A5(var_0, var_1) {
  self endon("supplydrop_timeout");
  self endon("death");
  self endon("disconnect");

  if(var_1) {
    var_0 waittillmatch("psd_drop_notetrack", "ps_mp_loot_drop_impact");
    self _meth_85A7("hub_loot_crate_impact", var_0.origin);
    var_0 waittillmatch("psd_drop_notetrack", "end");
    self notify("crate_landed");
  }

  for(;;) {
    if(self._id_08DD._id_5F0A) {
      if(!isDefined(self._id_7D07) || !self._id_7D07) {
        var_0 _meth_8277();
        var_0 _meth_8278("mp_hub_crate_open", "psd_open_notetrack");
        var_0 waittillmatch("psd_open_notetrack", "cam_shake");
        self _meth_85A7("hub_crate_open", var_0.origin);
        var_0 waittillmatch("psd_open_notetrack", "end");
      }

      self._id_08DD._id_579E = 1;
      return;
    }

    waitframe();
  }
}

_id_A6BF() {
  self._id_1387 = 1;
  self notify("autoReveal");
}

hasextraloot(var_0) {
  switch (var_0) {
    case 11:
    case 3:
    case 2:
      return 1;
    default:
      return 0;
  }
}

_id_7FAF(var_0, var_1, var_2) {
  self endon("supplydrop_timeout");
  self endon("death");
  self endon("disconnect");

  if(common_scripts\utility::_id_562E(var_2))
    self._id_08DD._id_5F0A = 1;
  else if(!_id_6BFE(var_0)) {
    _id_7423();
    thread _id_238A();
    thread _id_2393(self);
    return;
  }

  thread maps\mp\_utility::printonteam(&"HUB_NOTIFY_OPEN_SUPPLY_DROP", self.team, self.name);
  self _meth_82FF("hub_hide_killfeed", 1);
  self._id_2759 = 0;
  thread _id_86E7();
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  self._id_5F08 = [];
  self notify("beginLootReveal");
  self _meth_85EF(&"supply_drop_allow_card_reveal", 1, var_0);
  self _meth_82FF("ui_hub_prep_supplydrop", 0);

  for(;;) {
    if(self._id_08DD._id_579E) {
      break;
    }

    waitframe();
  }

  for(;;) {
    if(self._id_08DD._id_5F0A) {
      break;
    }

    waitframe();
  }

  self _meth_85EF(&"supply_drop_begin_card_reveal", 0);
  thread _id_A6BF();
  _id_8737(0);
  var_4 = 3;
  var_6 = [0, 0, 0];
  var_7 = 0;

  if(hasextraloot(var_0)) {
    var_8 = [];

    if(common_scripts\utility::_id_562E(var_2)) {
      for(var_9 = 0; var_9 < self._id_48CC.size; var_9++) {
        if(_func_3B2(self._id_48CC[var_9]))
          var_8[var_8.size] = self._id_48CC[var_9];
      }
    } else {
      for(var_9 = 0; var_9 < self._id_48CC.size; var_9++) {
        if(!_func_3B2(self._id_48CC[var_9])) {
          var_8[var_8.size] = self._id_48CC[var_9];
          continue;
        }

        var_6[var_7] = self._id_48CC[var_9];
        var_7++;
      }
    }

    var_4 = var_8.size;

    for(var_9 = var_4; var_9 < 3; var_9++) {
      if(var_9 == var_4 && var_7 > 0) {
        var_8[var_8.size] = var_6[var_7 - 1];
        continue;
      }

      var_8[var_8.size] = 0;
    }

    self _meth_85D7(var_8);
    self.currentguids = [];
    self.currentguids = var_8;
  } else {
    self _meth_85D7(self._id_48CC);

    if(isDefined(self.currentguids))
      self.currentguids = undefined;
  }

  var_10 = 0;
  _id_0E9B(var_2);

  while(!var_5) {
    if(var_3 == var_4 - 1)
      var_5 = 1;

    var_11 = _id_5106(var_3, var_5, level._id_7A71);

    if(var_11 > var_10)
      var_10 = var_11;

    var_3++;
  }

  var_12 = _id_1459(var_10);
  _id_0468::_id_0A29("openSD", var_12);
  _id_04DC::_id_2D6D(var_12);
  _id_04E0::_id_50F0(["hubFeatureStats", "hubSupplyDrops", "numPublicSupplyDropsOpened"], 1, var_0, undefined);
  _id_04E0::_id_50F0(["hubFeatureStats", "hubSupplyDrops", "numSupplyDropSpectators"], var_12, undefined, undefined);
  var_13 = hasextraloot(var_0) && !common_scripts\utility::_id_562E(var_2);

  if(!var_13)
    self _meth_85EF(&"supply_drop_all_cards_revealed");

  if(!isDefined(self._id_1388) || !self._id_1388) {
    var_14 = 0;

    if(var_13) {
      self notify("open_extra_loot");
      wait 0.5;
      var_14 = 1;
    } else
      var_14 = _id_A6BD();

    if(var_14 != 1)
      thread _id_238A();
    else {
      if(var_13)
        self _meth_85D7(var_6);
      else if(hasextraloot(var_0))
        self _meth_85D7([16977920, 16977920, 5]);
      else
        self _meth_85D7([16977920, 16977920, 16977920]);

      _id_8737(0);

      if(var_13) {
        playFX(level.zombieimpactfx, self._id_08DD gettagorigin("tag_fx1"), anglesToForward(self._id_08DD _meth_8181("tag_fx1")));
        playFX(level.zombieimpactfx, self._id_08DD gettagorigin("tag_fx2"), anglesToForward(self._id_08DD _meth_8181("tag_fx2")));
      }

      self notify("firstItemComingOut");
      self._id_08DD _meth_8277();

      if(var_13) {
        self._id_08DD _meth_8276("mp_hub_crate_cards_in_zombies", "mp_hub_crate_cards_in_zombies", 0, 1.0);
        self._id_08DD waittillmatch("mp_hub_crate_cards_in_zombies", "cam_shake1");
      } else
        self._id_08DD _meth_8276("mp_hub_crate_cards_in", "", 0, 0.00001);
    }

    if(var_14 == 0) {
      self._id_7D07 = undefined;

      foreach(var_16 in level.players) {
        if(isDefined(var_16) && var_16 != self)
          var_16 _meth_8005(self);
      }

      thread _id_7423();
      thread _id_2393(self);
      return;
    }

    if(var_14 == 1) {
      self._id_7D07 = 1;

      if(var_13)
        thread _id_7D08(var_0, 1);
      else
        thread _id_7D08(var_0);

      return;
      return;
    }

    return;
  } else {
    thread _id_238A();
    thread _id_7423();
    thread _id_2393(self);

    foreach(var_16 in level.players) {
      if(isDefined(var_16) && var_16 != self)
        var_16 _meth_8005(self);
    }
  }
}

_id_991D(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  self endon("death");
  wait 0.5;

  if(!isDefined(var_1))
    self notify("supplydrop", var_0);
  else if(!isDefined(var_2))
    self notify("supplydrop", var_0, var_1);
  else if(!isDefined(var_3))
    self notify("supplydrop", var_0, var_1, var_2);
  else
    self notify("supplydrop", var_0, var_1, var_2, var_3);
}

_id_6BFE(var_0) {
  self._id_48CC = undefined;
  var_1 = self _meth_85AC(var_0);

  if(var_1 > 0) {
    thread _id_A6CB();
    return self _meth_85AE(var_0);
  }

  return 0;
}

_id_A6CB() {
  self endon("supplydrop_timeout");
  self endon("disconnect");
  self endon("death");
  thread _id_5F09();
  self waittill("supplydrop", var_0, var_1, var_2, var_3, var_4);
  self._id_48CC = [];

  if(isDefined(var_0))
    self._id_48CC[self._id_48CC.size] = var_0;

  if(isDefined(var_1))
    self._id_48CC[self._id_48CC.size] = var_1;

  if(isDefined(var_2))
    self._id_48CC[self._id_48CC.size] = var_2;

  if(isDefined(var_3))
    self._id_48CC[self._id_48CC.size] = var_3;

  if(isDefined(var_4))
    self._id_48CC[self._id_48CC.size] = var_4;

  self notify("supplydrop_opened");
  self._id_08DD._id_5F0A = 1;
}

_id_5F09() {
  self endon("disconnect");
  self endon("death");
  self endon("supplydrop_opened");
  wait(getdvarint("spv_supplydrop_timeout", 15));
  self iprintlnbold(&"HUB_SUPPLYDROP_TIMEOUT");
  _id_7423();
  thread _id_238A();
  thread _id_2393(self);
  self notify("supplydrop_timeout");
}

_id_7D08(var_0, var_1) {
  self._id_08DD._id_5F0A = 0;

  if(isDefined(self._id_08DD.nextboosterpacktype)) {
    var_0 = self._id_08DD.nextboosterpacktype;
    self._id_08DD.nextboosterpacktype = undefined;
  }

  thread _id_7FAF(var_0, 1, var_1);
}

_id_5106(var_0, var_1, var_2) {
  self endon("death");
  self endon("disconnect");
  var_3 = 0;
  var_4 = "";
  var_5 = 0;
  var_6 = 0;
  var_7 = (var_0 + 1) * 2;
  var_8 = "tag_fx" + common_scripts\utility::_id_9AAD(var_0 + 1);

  if(isDefined(self.currentguids))
    var_3 = self.currentguids[var_0];
  else
    var_3 = self._id_48CC[var_0];

  if(var_3 == 5) {} else {
    var_4 = _func_31A(var_3, 1);
    var_5 = int(_func_31A(var_3, 29));

    if(var_0 == 0)
      self notify("firstItemComingOut");

    self _meth_85DC(var_0, 0);
    self._id_08DD _meth_8276("mp_hub_crate_card_" + var_7 + "_out", "card_" + var_7 + "_out_notetrack");

    if(var_5 == 3 || var_5 == 4)
      _func_147(var_2[var_5], self._id_08DD, var_8);

    self._id_08DD waittillmatch("card_" + var_7 + "_out_notetrack", "show_loot");
    var_9 = "mp_loot_stinger_rarity_0" + (var_5 + 1);

    if(var_5 == 3)
      var_9 = "hub_ann_epic";

    if(var_5 == 4)
      var_9 = "hub_ann_heroic";

    self _meth_85A7("hub_reveal_loot_card", self._id_08DD.origin, self._id_08DD.origin, var_9);
    _func_147(var_2[var_5], self._id_08DD, var_8);

    switch (var_5) {
      case 3:
        thread maps\mp\_utility::printonteam(&"HUB_NOTIFY_RECEIVED_EPIC_ITEM", self.team, self.name);
        break;
      case 4:
        thread maps\mp\_utility::printonteam(&"HUB_NOTIFY_RECEIVED_HEROIC_ITEM", self.team, self.name);
        break;
      default:
        break;
    }

    self _meth_85DC(var_0, 3);
  }

  if(var_1)
    self notify("allLootItemsRevealed");

  return var_5;
}

_id_5F0D(var_0, var_1) {
  self endon("input_revealLootCard" + var_1);
  self endon("death");
  self endon("disconnect");
  self endon("autoFinishSupplyDrop");

  while(!self._id_1387) {
    var_0 _meth_860F("mp_loot_spin_tick_single", self);
    wait 0.1;
  }
}

_id_0E9B(var_0) {
  if(!isDefined(var_0) || !var_0) {
    self._id_08DD _meth_8277();
    self._id_08DD _meth_8276("mp_hub_crate_cards_in", "mp_hub_crate_cards_in", 0, 1.0);
    self._id_08DD waittillmatch("mp_hub_crate_cards_in", "cam_shake3");
  }

  self notify("allLootItemsOut");
  self _meth_85A7("hub_loot_cards_in_position", self._id_08DD.origin);
}

_id_A6BE() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("exit_PSD_sequence");
  self endon("noPostPSDInput");
  self endon("autoFinishSupplyDrop");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 != "hub_supply_drop_reopen_exit") {
      continue;
    }
    if(var_1 == -1) {
      self notify("exit_PSD_sequence");
      break;
    } else {
      self._id_08DD.nextboosterpacktype = var_1;
      self notify("reopen_PSD");
      break;
    }
  }
}

_id_A6BD() {
  self endon("disconnect");
  self endon("death");
  thread _id_A6BE();
  var_0 = common_scripts\utility::_id_A715("reopen_PSD", "exit_PSD_sequence", "noPostPSDInput", "autoFinishSupplyDrop");

  if(var_0 == "exit_PSD_sequence" || var_0 == "noPostPSDInput" || var_0 == "autoFinishSupplyDrop")
    return 0;
  else if(var_0 == "reopen_PSD")
    return 1;
}

_id_21EE(var_0) {
  var_1 = getEntArray("invalid_psd_area", "targetname");

  if(!isDefined(var_1))
    return 1;

  foreach(var_3 in var_1) {
    if(var_0 istouching(var_3))
      return 0;
  }

  foreach(var_6 in level._id_08DE) {
    if(distancesquared(var_0.origin, var_6) <= 7225)
      return 0;
  }

  return 1;
}

_id_2393(var_0) {
  self endon("disconnect");
  self endon("death");
  var_0 notify("psdSequenceDone");
  self._id_08DD _meth_8278("mp_hub_crate_close", "psd_close_notetrack");
  self._id_08DD waittillmatch("psd_close_notetrack", "end");
  _id_7C6A(self._id_08DD);
  var_1 = 0.5;
  wait(2.0 - var_1);
  self._id_08DD setModel(_id_441F(self._id_08DD._id_2742, 1));
  _id_04E0::_id_86A9(1);
  self._id_08DD _meth_8450(1, 0, var_1);
  wait(var_1);
  self._id_08DD delete();
  self._id_08DD = undefined;
  self._id_4B84 = 0;
  self._id_2759 = 1;
  self notify("supplyDropSequenceFullyComplete");
  self _meth_82FF("ui_hub_enable_pause", 1);
}

_id_7C6A(var_0) {
  var_1 = 10.0;

  foreach(var_3 in level._id_08DE) {
    if((var_3[0] + var_1 <= var_0.origin[0] || var_3[0] - var_1 <= var_0.origin[0]) && (var_3[1] + var_1 <= var_0.origin[1] || var_3[1] - var_1 <= var_0.origin[1]) && (var_3[2] + var_1 <= var_0.origin[2] || var_3[2] - var_1 <= var_0.origin[2]))
      level._id_08DE = common_scripts\utility::_id_0F93(level._id_08DE, var_3);
  }
}

_id_8737(var_0) {
  self _meth_85DC(0, var_0);
  self _meth_85DC(1, var_0);
  self _meth_85DC(2, var_0);
}

_id_238A() {
  self _meth_85D7([0, 0, 0]);
  _id_8737(0);
  self _meth_82FF("hub_hide_killfeed", 0);
}

_id_93FA(var_0, var_1) {
  self endon("disconnect");
  self endon("death");
  common_scripts\utility::_id_A715("reopen_PSD", "exit_PSD_sequence", "noPostPSDInput", "autoFinishSupplyDrop", "open_extra_loot");
  _func_149(var_0, self._id_08DD, var_1);
}

_id_7421(var_0) {
  self endon("death");
  self endon("disconnect");
  self _meth_84A7("upDpad", "+actionslot 1");
  self _meth_84A7("downDpad", "+actionslot 2");
  self _meth_84A7("leftDpad", "+actionslot 3");
  self _meth_84A7("rightDpad", "+actionslot 4");
  _id_04E0::_id_721A("mp_unarmed_stand_flare_throw", 1);
  maps\mp\_utility::_id_2CED(1.0, ::_id_49E9);
  self._id_76A5 = _id_04E0::_id_43F8();
  self._id_76A4 = self getplayerangles();
  self _meth_82FF("ui_hub_opening_supplydrop", 1);

  if(getdvarint("hub_noPSDPlayerLock") == 0) {
    thread _id_743E();
    thread _id_7005(var_0, 1);
  }
}

_id_49E9() {
  self endon("death");
  self endon("disconnect");
  self detach("npc_usa_m18_smoke_green", "tag_weapon_right");

  if(!isDefined(self._id_08DD)) {
    return;
  }
  if(!isDefined(level._id_08C2))
    level._id_08C2 = [];

  if(level._id_08C2.size >= 10) {
    return;
  }
  var_0 = self gettagorigin("tag_weapon_right");
  var_1 = spawn("script_model", (var_0[0], var_0[1], self._id_08DD.origin[2]));
  var_1 setModel("npc_usa_m18_smoke_green");
  var_1.angles = var_1.angles + (90, 0, 0);
  var_1.origin = var_1.origin + (0, 0, 4);
  level._id_08C2[level._id_08C2.size] = var_1;
  thread _id_2360(var_1);
  self waittill("crate_landed");
  var_1 delete();
  level._id_08C2 = common_scripts\utility::_id_0F93(level._id_08C2, var_1);
}

_id_2360(var_0) {
  var_0 endon("death");
  common_scripts\utility::_id_A70A("death", "disconnect", "supplydrop_timeout");
  var_0 delete();
  level._id_08C2 = common_scripts\utility::_id_0F93(level._id_08C2, var_0);
}

_id_7423() {
  self endon("death");
  self endon("disconnect");

  if(getdvarint("hub_noPSDPlayerLock") == 0) {
    _id_7D55();
    _id_743D(0);
    self _meth_8113(1);
    self _meth_8308(1);
  }

  self _meth_82E1("upDpad", "+actionslot 1");
  self _meth_82E1("downDpad", "+actionslot 2");
  self _meth_82E1("leftDpad", "+actionslot 3");
  self _meth_82E1("rightDpad", "+actionslot 4");
  self._id_572B = 0;
  _id_04E0::_id_870B(0);
  self _meth_82FF("ui_hub_opening_supplydrop", 0);
  self _meth_85EF(&"exit_supply_drop", 0);
  self._id_1387 = 0;
  self._id_579F = 1;
}

_id_7424() {
  if(getdvarint("hub_noPSDPlayerLock") == 0) {
    self _meth_8179("stand");
    self _meth_8113(0);
    self _meth_8308(0);
    self _meth_85CA();
  }
}

_id_7422() {
  self endon("disconnect");
  self endon("death");

  if(getdvarint("hub_noPSDPlayerLock") == 0) {}

  self._id_572B = 0;
  _id_04E0::_id_870B(0);
  self _meth_8113(1);
  self _meth_8308(1);
  self _meth_85CB();
  self _meth_85B2(1, "mp_unarmed_stand_flare2_stand_idle");
  self _meth_85B3(1);
  self._id_579F = 1;
  wait 0.1;
  self detach("npc_usa_m18_smoke_green", "tag_weapon_right");
}

_id_743D(var_0) {
  self freezecontrols(var_0);
}

_id_743E() {
  self endon("disconnect");
  self endon("death");
  self waittill("beginReactionAnims");
  _id_04E0::_id_721A("mp_hub_react_to_crate_in", 1);
  wait 2.15;
  _id_04E0::_id_721A("mp_hub_react_to_crate_idle", 1);
  self waittill("exit_PSD_sequence");
  _id_04E0::_id_721A("mp_hub_react_to_crate_out", 1);
}

_id_24E2(var_0) {
  var_1 = _func_18E("psd_collision", "targetname");

  if(!isDefined(var_1))
    return undefined;

  var_2 = ((self.origin[0] + var_0[0]) / 2, (self.origin[1] + var_0[1]) / 2, (self.origin[2] + var_0[2]) / 2 - 25);
  var_3 = spawn("script_model", var_2);
  var_3.targetname = "psdCollision";
  var_3 _meth_8275(var_1);
  common_scripts\utility::_id_A715("psdSequenceDone", "death", "disconnect", "exit_PSD_sequence");
  var_3 delete();
}

_id_7005(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  self _meth_85CB();
  var_2 = vectorNormalize(var_0 - self.origin);
  var_2 = vectortoangles(var_2);
  var_2 = var_2 * (0, 1, 0);
  var_3 = self.origin + anglestoright(var_2) * 55 + anglesToForward(var_2) * -60 + (0, 0, 73);
  var_4 = self.origin + anglestoright(var_2) * 15 + anglesToForward(var_2) * 3 + (0, 0, 64);
  var_5 = (var_0[0], var_0[1], self.origin[2] + 55);
  var_5 = var_5 + anglestoright(var_2) * 5;
  var_6 = vectorNormalize(var_5 - var_3);
  var_6 = vectortoangles(var_6);
  self._id_0E9D = spawn("script_model", self._id_76A5);
  self._id_0E9D.targetname = "animatedPSDCamera";
  self._id_0E9D setModel("s2_genericprop");
  self._id_0E9D.angles = self getplayerangles();
  thread _id_2350(self._id_0E9D);
  self _meth_833E(var_6);
  self _meth_85C9(1);
  _id_743D(1);
  self _meth_81E2(self._id_0E9D, "tag_player", 500);
  self._id_0E9D _meth_82B1(var_3, 0.5);
  self._id_0E9D _meth_82B8(var_6, 0.5);
  self waittill("beginReactionAnims");
  self._id_0E9D.origin = self.origin;
  self._id_0E9D.angles = var_2;
  self._id_0E9D._id_A2B4 = var_2;
  self._id_0E9D.targetname = "animatedPSDCamera";
  self _meth_81E2(self._id_0E9D, "tag_origin_animated");
  self._id_0E9D _meth_8278("mp_hub_crate_drop_cam");
  self waittill("firstItemComingOut");
  self._id_0E9D _meth_8277();
  self._id_0E9D _meth_8278("mp_hub_crate_card_cam_in", "card_cam_in_notetrack");
  self _meth_85A7("hub_loot_cam_earthquake", self._id_08DD.origin);
  self._id_0E9D waittillmatch("card_cam_in_notetrack", "end");
  self._id_0E9D _meth_8277();
  self._id_0E9D _meth_8278("mp_hub_crate_card_cam_loop");
}

_id_7D55() {
  self endon("disconnect");
  self endon("death");
  self _meth_85C9(0);
  self._id_0E9D _meth_8277();
  self._id_0E9D _meth_8278("mp_hub_crate_card_out_cam", "psd_exit_cam");
  self._id_0E9D waittillmatch("psd_exit_cam", "end");
  self._id_0E9D _meth_84CA(1);
  self _meth_81E3(500);
  wait 0.6;
  self._id_0E9D delete();
  self._id_0E9D = undefined;
}

_id_36E1(var_0) {
  if(isDefined(level._id_08DE) && isDefined(var_0))
    level._id_08DE[level._id_08DE.size] = var_0;

  if(isDefined(self._id_4DEF)) {
    self._id_4DEF delete();
    self._id_4DEF = undefined;
  }

  self _meth_80D1();
}

_id_2FA9() {
  if(!isDefined(self._id_2F81))
    self._id_2F81 = 0;

  self._id_2F81++;
  self _meth_8322();
}

_id_366B() {
  if(!isDefined(self._id_2F81))
    self._id_2F81 = 0;

  self._id_2F81--;

  if(!self._id_2F81)
    self _meth_8323();
}

oncarrierdeathordisconnect() {
  self._id_4DEF endon("placed");
  self._id_4DEF endon("death");
  common_scripts\utility::_id_A70A("death", "disconnect");
  self._id_4DEF delete();
  self._id_4DEF = undefined;
}

_id_1459(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(isPlayer(var_3) && maps\mp\_utility::isreallyalive(var_3) && self != var_3) {
      if(common_scripts\utility::_id_302B(self._id_08DD.origin, var_3.origin) < 65536) {
        var_1[var_1.size] = var_3;

        if(isDefined(var_0)) {
          var_3 _id_0468::_id_0A29("watchSD", 0, var_0);
          continue;
        }

        var_3 _id_0468::_id_0A29("watchSD", 0, 0);
      }
    }
  }

  return var_1.size;
}

_id_23E0() {
  self endon("death");
  self endon("disconnect");
  wait 5;
  _id_04D9::_id_A124("ch_hub_epicReveal");
}

_id_A85E() {
  level endon("game_ended");
  self endon("disconnect");

  if(!isDefined(level._id_77A6))
    level._id_77A6 = common_scripts\utility::_id_46B7("psd_spawn_location", "targetname");

  var_0 = common_scripts\utility::random(level._id_77A6);
  self.warpingtosupplydrop = 1;
  self _meth_85C9(1);
  self setOrigin(_func_236(var_0.origin), 1);
  self _meth_833E(var_0.angles);
}

checksafewarpposition() {
  var_0 = level._id_77A6;
  var_1 = common_scripts\utility::random(var_0);

  while(var_0.size > 1) {
    if(var_1.origin == (-297, 747.5, 0) || var_1.origin == (242.5, 946.5, 0) || var_1.origin == (-402.5, 914, 0) || var_1.origin == (128.5, 998.5, 0) || var_1.origin == (130, 753.5, 0) || var_1.origin == (-190, 856, 0) || var_1.origin == (-311, 849.5, 0) || var_1.origin == (-245.5, 980.5, 0) || var_1.origin == (-189, 1077.5, 0)) {
      var_0 = common_scripts\utility::_id_0F93(var_0, var_1);
      var_1 = common_scripts\utility::random(var_0);
      continue;
    }

    break;
  }

  return var_1;
}

_id_2343(var_0) {
  var_0 endon("death");
  self waittill("disconnect");

  if(isDefined(var_0)) {
    _id_7C6A(var_0);
    var_0 delete();
  }
}

_id_2350(var_0) {
  var_0 endon("death");
  self waittill("disconnect");

  if(isDefined(var_0))
    var_0 delete();
}

_id_2865() {
  if(self _meth_8178() == "crouch") {
    var_0 = bulletTrace(self.origin, self.origin + (0, 0, 72), 0, self);

    if(var_0["fraction"] != 1) {
      _id_04E0::_id_3010("cantPlaceSD", &"HUB_CANT_PLACE_SD", undefined, -100, 1.65, 1);
      return 0;
    }
  }

  return 1;
}

monitorsupplydropawarded() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 != "supply_drop_awarded") {
      continue;
    }
    if(var_1 == -1) {
      continue;
    }
    var_2 = tablelookup("mp/supplyDropTypes.csv", 1, var_1, 8);

    if(var_2 != "1") {
      continue;
    }
    var_3 = tablelookup("mp/supplyDropTypes.csv", 1, var_1, 0);

    if(var_3 != "")
      thread maps\mp\gametypes\_hud_message::_id_9102(var_3, var_1);
  }
}
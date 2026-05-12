/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_hub_crate.gsc
*********************************************/

func_00D5() {
  if(!isDefined(level.var_83E9)) {
    level.var_83E9 = [];
  }

  level.var_83EA["sentry_minigun"] = "sentry";
  level.var_83E9["sentry_minigun"] = spawnStruct();
  level.var_83E9["sentry_minigun"].var_00BC = 999999;
  level.var_83E9["sentry_minigun"].var_00FB = 1000;
  level.var_83E9["sentry_minigun"].var_1DC4 = 20;
  level.var_83E9["sentry_minigun"].var_1DC3 = 120;
  level.var_83E9["sentry_minigun"].var_6F26 = 0.15;
  level.var_83E9["sentry_minigun"].var_6F25 = 0.35;
  level.var_83E9["sentry_minigun"].var_83E8 = "sentry";
  level.var_83E9["sentry_minigun"].var_83E7 = "sentry_offline";
  level.var_83E9["sentry_minigun"].var_9A01 = 90;
  level.var_83E9["sentry_minigun"].var_90FA = 0.05;
  level.var_83E9["sentry_minigun"].var_6CA3 = 8;
  level.var_83E9["sentry_minigun"].var_2650 = 0.1;
  level.var_83E9["sentry_minigun"].var_3F84 = 0.3;
  level.var_83E9["sentry_minigun"].var_944C = "sentry";
  level.var_83E9["sentry_minigun"].var_01D1 = "sentry_supplydrop_mp";
  level.var_83E9["sentry_minigun"].var_6294 = "hub_lootcrate_normal";
  level.var_83E9["sentry_minigun"].var_629D = "tag_origin";
  level.var_83E9["sentry_minigun"].var_629E = "tag_origin";
  level.var_83E9["sentry_minigun"].var_6295 = "hub_lootcrate_normal";
  level.var_83E9["sentry_minigun"].var_00C5 = &"SENTRY_PICKUP";
  level.var_83E9["sentry_minigun"].var_00BA = 1;
  level.var_83E9["sentry_minigun"].var_9869 = "used_sentry";
  level.var_83E9["sentry_minigun"].var_8BAB = 0;
  level.var_83E9["sentry_minigun"].var_A5F7 = "sentry_destroyed";
  level.var_0611["supply_drop_landing_impact_ground"] = loadfx("vfx/smoke/supply_drop_landing_impact_ground");
  level.var_0611["supply_drop_opening_ground"] = loadfx("vfx/smoke/supply_drop_opening_ground");
  var_00 = loadfx("vfx/unique/supply_drop_impactpulse");
  var_01 = loadfx("vfx/unique/supply_drop_impactpulse_blue");
  var_02 = loadfx("vfx/unique/supply_drop_impactpulse_red");
  var_03 = loadfx("vfx/unique/supply_drop_impactpulse_violet");
  var_04 = loadfx("vfx/unique/supply_drop_impactpulse_heroic");
  level.var_7A71 = [var_00, var_01, var_03, var_02, var_04];
  var_05 = loadfx("vfx/unique/supply_drop_shine_heroic");
  var_06 = loadfx("vfx/unique/supply_drop_shine_red");
  var_07 = loadfx("vfx/unique/supply_drop_shine_violet");
  var_08 = loadfx("vfx/unique/supply_drop_shine_blue");
  var_09 = loadfx("vfx/unique/supply_drop_shine");
  level.zombieimpactfx = loadfx("vfx/unique/supply_drop_impactpulse_zombie");
  level.var_7A72 = [var_09, var_08, var_07, var_06, var_05];
  setDvar("1601", 64);
  setDvar("1730", 0.2);
  setDvar("4002", 0);
  setDvar("3512", 0);
  setdvarifuninitialized("hub_numDevCards", 3);
  level.var_08DE = [];
}

cleanupplayerforsupplydrop() {
  if(common_scripts\_plant_weapon::func_5855()) {
    common_scripts\_plant_weapon::func_239A();
  }
}

func_11BF(param_00) {
  self endon("disconnect");
  cleanupplayerforsupplydrop();
  var_01 = isDefined(self.var_537A) && self.var_537A;
  if(var_01) {
    func_743D(1);
    func_A85E();
  }

  self luinotifyevent(&"supply_drop_player_warp_complete");
  self setclientomnvar("ui_hub_prep_supplydrop", 1);
  for(;;) {
    self waittill("luinotifyserver", var_02, var_03);
    if(var_02 != "supply_drop_menu_closed") {
      continue;
    }

    if(var_03) {
      break;
    }
  }

  if(func_2865() && !maps\mp\gametypes\_hub_unk1::func_5790() && self lootservicegetnumboosterpacksoftype(param_00) > 0 && getdvarint("spv_hub_psd_kswitch", 1) == 0) {
    func_1718(param_00, !var_01);
    return;
  }

  self setclientomnvar("ui_hub_prep_supplydrop", 0);
  if(self lootservicegetnumboosterpacksoftype(param_00) <= 0 && !maps\mp\gametypes\_hub_unk1::func_5790()) {
    thread maps\mp\gametypes\_hub_unk1::func_3010("outOfSDs", &"HUB_OUT_OF_SD", undefined, -100, 1.65, 1);
  }
}

func_1718(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  if(self.var_56A4) {
    if(isDefined(self.var_155F)) {
      self.var_155F maps\mp\gametypes\_hub_unk1::func_1543((0, 0, 80), self);
    }
  }

  self.var_572B = 1;
  maps\mp\gametypes\_hub_unk1::func_870B(1);
  self.var_4DEF = undefined;
  thread func_280A();
  func_8646();
  func_63CC(param_00, param_01);
}

func_280A() {
  self.var_4DEF = spawnturret("misc_turret", self.var_0116, level.var_83E9["sentry_minigun"].var_01D1);
  self.var_4DEF makeunusable();
  self.var_4DEF.var_83EA = "sentry_minigun";
  self.var_4DEF.var_001D = self.var_001D + (0, 0, 90);
  self.var_4DEF.var_01A5 = "holoPSD";
}

func_8646() {
  self endon("death");
  self endon("disconnect");
  self.var_4DEF setmode("supplydrop");
  self.var_4DEF setModel(level.var_83E9[self.var_4DEF.var_83EA].var_629D);
  self.var_4DEF method_80F9(self);
  self.var_4DEF method_80FA(self);
  self.var_4DEF.var_2002 = self;
  self setclientomnvar("ui_hub_enable_pause", 0);
  func_7424();
  self method_85B4();
  self setanimoverride(1, "mp_unarmed_stand_flare_pull");
  self method_85B3(1);
  self attach("npc_usa_m18_smoke_green", "tag_weapon_right");
  thread func_9BC5();
  thread oncarrierdeathordisconnect();
}

func_956A() {
  self endon("death");
  self endon("disconnect");
  wait(0.8666667);
}

func_9BC5() {
  self endon("death");
  self endon("disconnect");
  self.var_4DEF endon("placed");
  self.var_4DEF endon("death");
  self.var_4DEF.var_1F2F = 1;
  var_00 = -1;
  var_01 = self getplayerscurrentanimname(0);
  var_02 = self getplayerscurrentanimname(1);
  for(;;) {
    if(isDefined(self.var_4DEF)) {
      var_03 = self canplayerplacesentry(1, 35);
      self.var_4DEF.var_0116 = var_03["origin"];
      self.var_4DEF.var_001D = var_03["angles"];
      self.var_4DEF.var_1F2F = func_2865() && self isonground() && var_03["result"] && func_21EE(self.var_4DEF) && abs(self.var_4DEF.var_0116[2] - self.var_0116[2]) < 8;
      if(self.var_4DEF.var_1F2F) {
        var_04 = self.var_4DEF.var_0116 - self.var_0116;
        var_04 = vectortoangles(var_04);
        var_04 = var_04 * (0, 1, 0);
        var_05 = self.var_0116 + (0, 0, 73);
        var_06 = self.var_0116 + anglestoright(var_04) * 55 + anglesToForward(var_04) * -60 + (0, 0, 73);
        var_07 = bulletTrace(var_05, var_06, 1, self);
        self.var_4DEF.var_1F2F = var_07["fraction"] == 1;
      }

      if(self.var_4DEF.var_1F2F != var_00) {
        if(self.var_4DEF.var_1F2F) {
          function_0295(level.var_94F2, self.var_4DEF, "TAG_ORIGIN", self);
          wait 0.05;
          playfxontagforclients(level.var_94F1, self.var_4DEF, "TAG_ORIGIN", self);
          self forceusehinton(&"HUB_VALID_PSD");
        } else {
          function_0295(level.var_94F1, self.var_4DEF, "TAG_ORIGIN", self);
          wait 0.05;
          playfxontagforclients(level.var_94F2, self.var_4DEF, "TAG_ORIGIN", self);
          self forceusehinton(&"HUB_INVALID_PSD");
        }
      }

      var_00 = self.var_4DEF.var_1F2F;
      wait 0.05;
      if(var_01 != self getplayerscurrentanimname(0) || var_02 != self getplayerscurrentanimname(1)) {
        var_01 = self getplayerscurrentanimname(0);
        var_02 = self getplayerscurrentanimname(1);
      }

      continue;
    }
  }
}

func_63CC(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  if(param_01) {
    if(!isai(self)) {
      self allowjump(0);
      self notifyonplayercommand("place_PSD", "+gostand");
      self notifyonplayercommand("place_PSD", "+attack");
      self notifyonplayercommand("cancel_PSD", "+stance");
      self notifyonplayercommand("pauseButton", "togglemenu");
    }

    for(;;) {
      var_02 = common_scripts\utility::func_A715("place_PSD", "cancel_PSD", "force_cancel_placement", "pauseButton");
      if(var_02 == "cancel_PSD" || var_02 == "force_cancel_placement" || var_02 == "pauseButton") {
        thread func_3F01();
        return;
      }

      if(self.var_4DEF.var_1F2F) {
        while(!self isonground()) {
          wait 0.05;
        }

        break;
      }

      var_03 = lib_0380::func_2888("ui_negate", self);
      wait(0.3);
    }

    self notifyonplayercommandremove("place_PSD", "+gostand");
    self notifyonplayercommandremove("place_PSD", "+attack");
    self notifyonplayercommandremove("cancel_PSD", "+stance");
    self notifyonplayercommandremove("pauseButton", "togglemenu");
    self allowjump(1);
  } else {
    self.warpingtosupplydrop = undefined;
  }

  self forceusehintoff();
  if(getdvarint("hub_noPSDPlayerLock") == 0) {
    self freezecontrols(1);
    wait(0.1);
  }

  maps\mp\gametypes\_hub_unk1::func_86A9(0);
  func_2D6C(param_00);
}

func_2D6C(param_00) {
  self endon("disconnect");
  self endon("death");
  var_01 = vectornormalize(self.var_4DEF.var_0116 - self.var_0116);
  var_01 = vectortoangles(var_01);
  var_01 = self.var_0116 + anglesToForward(var_01) * 70;
  var_02 = self.var_4DEF.var_001D;
  thread func_7421(var_01);
  func_36E1(var_01);
  wait(1);
  self notify("beginReactionAnims");
  thread func_34A7(var_01, var_02, param_00);
  self.var_4B84 = 1;
}

func_3F01() {
  func_36E1();
  thread func_7422();
  self notifyonplayercommandremove("place_PSD", "+gostand");
  self notifyonplayercommandremove("place_PSD", "+attack");
  self notifyonplayercommandremove("cancel_PSD", "+stance");
  self notifyonplayercommandremove("pauseButton", "togglemenu");
  self forceusehintoff();
  self allowjump(1);
  self setclientomnvar("ui_hub_enable_pause", 1);
  self setclientomnvar("ui_hub_prep_supplydrop", 0);
  self setclientomnvar("hub_hide_killfeed", 0);
}

func_34A7(param_00, param_01, param_02) {
  self.var_08DD = spawn("script_model", param_00);
  self.var_08DD setModel(func_441F(param_02));
  self.var_08DD.var_2742 = param_02;
  self.var_08DD setotherent(self);
  thread func_2343(self.var_08DD);
  self.var_08DD.var_5F0A = 0;
  self.var_08DD.var_579E = 0;
  self.var_08DD.var_0116 = param_00;
  self.var_08DD.var_001D = (0, param_01[1] + 180, 0);
  self.var_08DD method_8278("mp_hub_crate_drop", "psd_drop_notetrack");
  self.var_08DD method_805B();
  thread func_77A5(self.var_08DD, 1);
  func_7FAF(param_02);
}

func_86E7() {
  self endon("supplydrop_timeout");
  self endon("death");
  self endon("disconnect");
  self endon("autoFinishSupplyDrop");
  var_00 = 85;
  while(!self.var_2759) {
    foreach(var_02 in level.var_744A) {
      if(isDefined(var_02) && var_02 != self) {
        if(distance(var_02.var_0116, self.var_0116) > var_00) {
          var_02 showtoclient(self);
          continue;
        }

        var_02 hidefromclient(self);
      }
    }

    wait(0.1);
  }

  foreach(var_02 in level.var_744A) {
    if(isDefined(var_02) && var_02 != self) {
      var_02 showtoclient(self);
    }
  }
}

func_441F(param_00, param_01) {
  var_02 = isDefined(param_01) && param_01;
  var_03 = "";
  if(var_02) {
    var_03 = tablelookup("mp/supplyDropTypes.csv", 1, param_00, 10);
    if(var_03 == "") {
      var_03 = "hub_lootcrate_normal_fade";
    }
  } else {
    var_03 = tablelookup("mp/supplyDropTypes.csv", 1, param_00, 9);
    if(var_03 == "") {
      var_03 = "hub_lootcrate_normal";
    }
  }

  return var_03;
}

func_77A5(param_00, param_01) {
  self endon("supplydrop_timeout");
  self endon("death");
  self endon("disconnect");
  if(param_01) {
    param_00 waittillmatch("ps_mp_loot_drop_impact", "psd_drop_notetrack");
    self method_85A7("hub_loot_crate_impact", param_00.var_0116);
    param_00 waittillmatch("end", "psd_drop_notetrack");
    self notify("crate_landed");
  }

  for(;;) {
    if(self.var_08DD.var_5F0A) {
      if(!isDefined(self.var_7D07) || !self.var_7D07) {
        param_00 scriptmodelclearanim();
        param_00 method_8278("mp_hub_crate_open", "psd_open_notetrack");
        param_00 waittillmatch("cam_shake", "psd_open_notetrack");
        self method_85A7("hub_crate_open", param_00.var_0116);
        param_00 waittillmatch("end", "psd_open_notetrack");
      }

      self.var_08DD.var_579E = 1;
      return;
    }

    wait 0.05;
  }
}

func_A6BF() {
  self.var_1387 = 1;
  self notify("autoReveal");
}

hasextraloot(param_00) {
  switch (param_00) {
    case 11:
    case 3:
    case 2:
      return 1;

    default:
      return 0;
  }
}

func_7FAF(param_00, param_01, param_02) {
  self endon("supplydrop_timeout");
  self endon("death");
  self endon("disconnect");
  if(common_scripts\utility::func_562E(param_02)) {
    self.var_08DD.var_5F0A = 1;
  } else if(!func_6BFE(param_00)) {
    func_7423();
    thread func_238A();
    thread func_2393(self);
    return;
  }

  thread maps\mp\_utility::func_772A(&"HUB_NOTIFY_OPEN_SUPPLY_DROP", self.var_01A7, self.var_0109);
  self setclientomnvar("hub_hide_killfeed", 1);
  self.var_2759 = 0;
  thread func_86E7();
  var_03 = 0;
  var_04 = 0;
  var_05 = 0;
  self.var_5F08 = [];
  self notify("beginLootReveal");
  self luinotifyevent(&"supply_drop_allow_card_reveal", 1, param_00);
  self setclientomnvar("ui_hub_prep_supplydrop", 0);
  for(;;) {
    if(self.var_08DD.var_579E) {
      break;
    }

    wait 0.05;
  }

  for(;;) {
    if(self.var_08DD.var_5F0A) {
      break;
    }

    wait 0.05;
  }

  self luinotifyevent(&"supply_drop_begin_card_reveal", 0);
  thread func_A6BF();
  func_8737(0);
  var_04 = 3;
  var_06 = [0, 0, 0];
  var_07 = 0;
  if(hasextraloot(param_00)) {
    var_08 = [];
    if(common_scripts\utility::func_562E(param_02)) {
      for(var_09 = 0; var_09 < self.var_48CC.size; var_09++) {
        if(isguidaazmconsumable(self.var_48CC[var_09])) {
          var_08[var_08.size] = self.var_48CC[var_09];
        }
      }
    } else {
      for(var_09 = 0; var_09 < self.var_48CC.size; var_09++) {
        if(!isguidaazmconsumable(self.var_48CC[var_09])) {
          var_08[var_08.size] = self.var_48CC[var_09];
          continue;
        }

        var_06[var_07] = self.var_48CC[var_09];
        var_07++;
      }
    }

    var_04 = var_08.size;
    for(var_09 = var_04; var_09 < 3; var_09++) {
      if(var_09 == var_04 && var_07 > 0) {
        var_08[var_08.size] = var_06[var_07 - 1];
        continue;
      }

      var_08[var_08.size] = 0;
    }

    self setsupplydropguids(var_08);
    self.currentguids = [];
    self.currentguids = var_08;
  } else {
    self setsupplydropguids(self.var_48CC);
    if(isDefined(self.currentguids)) {
      self.currentguids = undefined;
    }
  }

  var_0A = 0;
  func_0E9B(var_03);
  while(!var_06) {
    if(var_04 == var_05 - 1) {
      var_06 = 1;
    }

    var_0B = func_5106(var_04, var_06, level.var_7A71);
    if(var_0B > var_0A) {
      var_0A = var_0B;
    }

    var_04++;
  }

  var_0C = func_1459(var_0A);
  lib_0468::func_0A29("openSD", var_0C);
  maps\mp\gametypes\_hub_notifications::func_2D6D(var_0C);
  maps\mp\gametypes\_hub_unk1::func_50F0(["hubFeatureStats", "hubSupplyDrops", "numPublicSupplyDropsOpened"], 1, param_01, undefined);
  maps\mp\gametypes\_hub_unk1::func_50F0(["hubFeatureStats", "hubSupplyDrops", "numSupplyDropSpectators"], var_0C, undefined, undefined);
  var_0D = hasextraloot(param_01) && !common_scripts\utility::func_562E(var_03);
  if(!var_0D) {
    self luinotifyevent(&"supply_drop_all_cards_revealed");
  }

  if(!isDefined(self.var_1388) || !self.var_1388) {
    var_0E = 0;
    if(var_0D) {
      self notify("open_extra_loot");
      wait(0.5);
      var_0E = 1;
    } else {
      var_0E = func_A6BD();
    }

    if(var_0E != 1) {
      thread func_238A();
    } else {
      if(var_0D) {
        self setsupplydropguids(var_07);
      } else if(hasextraloot(param_01)) {
        self setsupplydropguids([16977920, 16977920, 5]);
      } else {
        self setsupplydropguids([16977920, 16977920, 16977920]);
      }

      func_8737(0);
      if(var_0D) {
        playFX(level.zombieimpactfx, self.var_08DD gettagorigin("tag_fx1"), anglesToForward(self.var_08DD gettagangles("tag_fx1")));
        playFX(level.zombieimpactfx, self.var_08DD gettagorigin("tag_fx2"), anglesToForward(self.var_08DD gettagangles("tag_fx2")));
      }

      self notify("firstItemComingOut");
      self.var_08DD scriptmodelclearanim();
      if(var_0D) {
        self.var_08DD scriptmodelplayanim("mp_hub_crate_cards_in_zombies", "mp_hub_crate_cards_in_zombies", 0, 1);
        self.var_08DD waittillmatch("cam_shake1", "mp_hub_crate_cards_in_zombies");
      } else {
        self.var_08DD scriptmodelplayanim("mp_hub_crate_cards_in", "", 0, 1E-05);
      }
    }

    if(var_0E == 0) {
      self.var_7D07 = undefined;
      foreach(var_10 in level.var_744A) {
        if(isDefined(var_10) && var_10 != self) {
          var_10 showtoclient(self);
        }
      }

      thread func_7423();
      thread func_2393(self);
      return;
    }

    if(var_0E == 1) {
      self.var_7D07 = 1;
      if(var_0D) {
        thread func_7D08(param_01, 1);
      } else {
        thread func_7D08(param_01);
      }

      return;
    }

    return;
  }

  thread func_238A();
  thread func_7423();
  thread func_2393(self);
  foreach(var_10 in level.var_744A) {
    if(isDefined(var_10) && var_10 != self) {
      var_10 showtoclient(self);
    }
  }
}

func_991D(param_00, param_01, param_02, param_03) {
  self endon("disconnect");
  self endon("death");
  wait(0.5);
  if(!isDefined(param_01)) {
    self notify("supplydrop", param_00);
    return;
  }

  if(!isDefined(param_02)) {
    self notify("supplydrop", param_00, param_01);
    return;
  }

  if(!isDefined(param_03)) {
    self notify("supplydrop", param_00, param_01, param_02);
    return;
  }

  self notify("supplydrop", param_00, param_01, param_02, param_03);
}

func_6BFE(param_00) {
  self.var_48CC = undefined;
  var_01 = self lootservicegetnumboosterpacksoftype(param_00);
  if(var_01 > 0) {
    thread func_A6CB();
    return self opensupplydrops(param_00);
  }

  return 0;
}

func_A6CB() {
  self endon("supplydrop_timeout");
  self endon("disconnect");
  self endon("death");
  thread func_5F09();
  self waittill("supplydrop", var_00, var_01, var_02, var_03, var_04);
  self.var_48CC = [];
  if(isDefined(var_00)) {
    self.var_48CC[self.var_48CC.size] = var_00;
  }

  if(isDefined(var_01)) {
    self.var_48CC[self.var_48CC.size] = var_01;
  }

  if(isDefined(var_02)) {
    self.var_48CC[self.var_48CC.size] = var_02;
  }

  if(isDefined(var_03)) {
    self.var_48CC[self.var_48CC.size] = var_03;
  }

  if(isDefined(var_04)) {
    self.var_48CC[self.var_48CC.size] = var_04;
  }

  self notify("supplydrop_opened");
  self.var_08DD.var_5F0A = 1;
}

func_5F09() {
  self endon("disconnect");
  self endon("death");
  self endon("supplydrop_opened");
  wait(getdvarint("spv_supplydrop_timeout", 15));
  self iclientprintlnbold(&"HUB_SUPPLYDROP_TIMEOUT");
  func_7423();
  thread func_238A();
  thread func_2393(self);
  self notify("supplydrop_timeout");
}

func_7D08(param_00, param_01) {
  self.var_08DD.var_5F0A = 0;
  if(isDefined(self.var_08DD.nextboosterpacktype)) {
    param_00 = self.var_08DD.nextboosterpacktype;
    self.var_08DD.nextboosterpacktype = undefined;
  }

  thread func_7FAF(param_00, 1, param_01);
}

func_5106(param_00, param_01, param_02) {
  self endon("death");
  self endon("disconnect");
  var_03 = 0;
  var_04 = "";
  var_05 = 0;
  var_06 = 0;
  var_07 = param_00 + 1 * 2;
  var_08 = "tag_fx" + common_scripts\utility::func_9AAD(param_00 + 1);
  if(isDefined(self.currentguids)) {
    var_03 = self.currentguids[param_00];
  } else {
    var_03 = self.var_48CC[param_00];
  }

  if(var_03 == 5) {} else {
    var_04 = function_031A(var_03, 1);
    var_05 = int(function_031A(var_03, 29));
    if(param_00 == 0) {
      self notify("firstItemComingOut");
    }

    self setsupplydropguidsstate(param_00, 0);
    self.var_08DD scriptmodelplayanim("mp_hub_crate_card_" + var_07 + "_out", "card_" + var_07 + "_out_notetrack");
    if(var_05 == 3 || var_05 == 4) {
      playFXOnTag(param_02[var_05], self.var_08DD, var_08);
    }

    self.var_08DD waittillmatch("show_loot", "card_" + var_07 + "_out_notetrack");
    var_09 = "mp_loot_stinger_rarity_0" + var_05 + 1;
    if(var_05 == 3) {
      var_09 = "hub_ann_epic";
    }

    if(var_05 == 4) {
      var_09 = "hub_ann_heroic";
    }

    self method_85A7("hub_reveal_loot_card", self.var_08DD.var_0116, self.var_08DD.var_0116, var_09);
    playFXOnTag(param_02[var_05], self.var_08DD, var_08);
    switch (var_05) {
      case 3:
        thread maps\mp\_utility::func_772A(&"HUB_NOTIFY_RECEIVED_EPIC_ITEM", self.var_01A7, self.var_0109);
        break;

      case 4:
        thread maps\mp\_utility::func_772A(&"HUB_NOTIFY_RECEIVED_HEROIC_ITEM", self.var_01A7, self.var_0109);
        break;

      default:
        break;
    }

    self setsupplydropguidsstate(param_00, 3);
  }

  if(param_01) {
    self notify("allLootItemsRevealed");
  }

  return var_05;
}

func_5F0D(param_00, param_01) {
  self endon("input_revealLootCard" + param_01);
  self endon("death");
  self endon("disconnect");
  self endon("autoFinishSupplyDrop");
  while(!self.var_1387) {
    param_00 method_860F("mp_loot_spin_tick_single", self);
    wait(0.1);
  }
}

func_0E9B(param_00) {
  if(!isDefined(param_00) || !param_00) {
    self.var_08DD scriptmodelclearanim();
    self.var_08DD scriptmodelplayanim("mp_hub_crate_cards_in", "mp_hub_crate_cards_in", 0, 1);
    self.var_08DD waittillmatch("cam_shake3", "mp_hub_crate_cards_in");
  }

  self notify("allLootItemsOut");
  self method_85A7("hub_loot_cards_in_position", self.var_08DD.var_0116);
}

func_A6BE() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("exit_PSD_sequence");
  self endon("noPostPSDInput");
  self endon("autoFinishSupplyDrop");
  for(;;) {
    self waittill("luinotifyserver", var_00, var_01);
    if(var_00 != "hub_supply_drop_reopen_exit") {
      continue;
    }

    if(var_01 == -1) {
      self notify("exit_PSD_sequence");
      break;
    } else {
      self.var_08DD.nextboosterpacktype = var_01;
      self notify("reopen_PSD");
      break;
    }
  }
}

func_A6BD() {
  self endon("disconnect");
  self endon("death");
  thread func_A6BE();
  var_00 = common_scripts\utility::func_A715("reopen_PSD", "exit_PSD_sequence", "noPostPSDInput", "autoFinishSupplyDrop");
  if(var_00 == "exit_PSD_sequence" || var_00 == "noPostPSDInput" || var_00 == "autoFinishSupplyDrop") {
    return 0;
  }

  if(var_00 == "reopen_PSD") {
    return 1;
  }
}

func_21EE(param_00) {
  var_01 = getEntArray("invalid_psd_area", "targetname");
  if(!isDefined(var_01)) {
    return 1;
  }

  foreach(var_03 in var_01) {
    if(param_00 istouching(var_03)) {
      return 0;
    }
  }

  foreach(var_06 in level.var_08DE) {
    if(distancesquared(param_00.var_0116, var_06) <= 7225) {
      return 0;
    }
  }

  return 1;
}

func_2393(param_00) {
  self endon("disconnect");
  self endon("death");
  param_00 notify("psdSequenceDone");
  self.var_08DD method_8278("mp_hub_crate_close", "psd_close_notetrack");
  self.var_08DD waittillmatch("end", "psd_close_notetrack");
  func_7C6A(self.var_08DD);
  var_01 = 0.5;
  wait(2 - var_01);
  self.var_08DD setModel(func_441F(self.var_08DD.var_2742, 1));
  maps\mp\gametypes\_hub_unk1::func_86A9(1);
  self.var_08DD setmaterialscriptparam(1, 0, var_01);
  wait(var_01);
  self.var_08DD delete();
  self.var_08DD = undefined;
  self.var_4B84 = 0;
  self.var_2759 = 1;
  self notify("supplyDropSequenceFullyComplete");
  self setclientomnvar("ui_hub_enable_pause", 1);
}

func_7C6A(param_00) {
  var_01 = 10;
  foreach(var_03 in level.var_08DE) {
    if((var_03[0] + var_01 <= param_00.var_0116[0] || var_03[0] - var_01 <= param_00.var_0116[0]) && (var_03[1] + var_01 <= param_00.var_0116[1] || var_03[1] - var_01 <= param_00.var_0116[1]) && var_03[2] + var_01 <= param_00.var_0116[2] || var_03[2] - var_01 <= param_00.var_0116[2]) {
      level.var_08DE = common_scripts\utility::func_0F93(level.var_08DE, var_03);
    }
  }
}

func_8737(param_00) {
  self setsupplydropguidsstate(0, param_00);
  self setsupplydropguidsstate(1, param_00);
  self setsupplydropguidsstate(2, param_00);
}

func_238A() {
  self setsupplydropguids([0, 0, 0]);
  func_8737(0);
  self setclientomnvar("hub_hide_killfeed", 0);
}

func_93FA(param_00, param_01) {
  self endon("disconnect");
  self endon("death");
  common_scripts\utility::func_A715("reopen_PSD", "exit_PSD_sequence", "noPostPSDInput", "autoFinishSupplyDrop", "open_extra_loot");
  killfxontag(param_00, self.var_08DD, param_01);
}

func_7421(param_00) {
  self endon("death");
  self endon("disconnect");
  self notifyonplayercommandremove("upDpad", "+actionslot 1");
  self notifyonplayercommandremove("downDpad", "+actionslot 2");
  self notifyonplayercommandremove("leftDpad", "+actionslot 3");
  self notifyonplayercommandremove("rightDpad", "+actionslot 4");
  maps\mp\gametypes\_hub_unk1::func_721A("mp_unarmed_stand_flare_throw", 1);
  maps\mp\_utility::func_2CED(1, ::func_49E9);
  self.var_76A5 = maps\mp\gametypes\_hub_unk1::func_43F8();
  self.var_76A4 = self getangles();
  self setclientomnvar("ui_hub_opening_supplydrop", 1);
  if(getdvarint("hub_noPSDPlayerLock") == 0) {
    thread func_743E();
    thread func_7005(param_00, 1);
  }
}

func_49E9() {
  self endon("death");
  self endon("disconnect");
  self method_802E("npc_usa_m18_smoke_green", "tag_weapon_right");
  if(!isDefined(self.var_08DD)) {
    return;
  }

  if(!isDefined(level.var_08C2)) {
    level.var_08C2 = [];
  }

  if(level.var_08C2.size >= 10) {
    return;
  }

  var_00 = self gettagorigin("tag_weapon_right");
  var_01 = spawn("script_model", (var_00[0], var_00[1], self.var_08DD.var_0116[2]));
  var_01 setModel("npc_usa_m18_smoke_green");
  var_01.var_001D = var_01.var_001D + (90, 0, 0);
  var_01.var_0116 = var_01.var_0116 + (0, 0, 4);
  level.var_08C2[level.var_08C2.size] = var_01;
  thread func_2360(var_01);
  self waittill("crate_landed");
  var_01 delete();
  level.var_08C2 = common_scripts\utility::func_0F93(level.var_08C2, var_01);
}

func_2360(param_00) {
  param_00 endon("death");
  common_scripts\utility::func_A70A("death", "disconnect", "supplydrop_timeout");
  param_00 delete();
  level.var_08C2 = common_scripts\utility::func_0F93(level.var_08C2, param_00);
}

func_7423() {
  self endon("death");
  self endon("disconnect");
  if(getdvarint("hub_noPSDPlayerLock") == 0) {
    func_7D55();
    func_743D(0);
    self method_8113(1);
    self method_8308(1);
  }

  self notifyonplayercommand("upDpad", "+actionslot 1");
  self notifyonplayercommand("downDpad", "+actionslot 2");
  self notifyonplayercommand("leftDpad", "+actionslot 3");
  self notifyonplayercommand("rightDpad", "+actionslot 4");
  self.var_572B = 0;
  maps\mp\gametypes\_hub_unk1::func_870B(0);
  self setclientomnvar("ui_hub_opening_supplydrop", 0);
  self luinotifyevent(&"exit_supply_drop", 0);
  self.var_1387 = 0;
  self.var_579F = 1;
}

func_7424() {
  if(getdvarint("hub_noPSDPlayerLock") == 0) {
    self setstance("stand");
    self method_8113(0);
    self method_8308(0);
    self method_85CA();
  }
}

func_7422() {
  self endon("disconnect");
  self endon("death");
  if(getdvarint("hub_noPSDPlayerLock") == 0) {}

  self.var_572B = 0;
  maps\mp\gametypes\_hub_unk1::func_870B(0);
  self method_8113(1);
  self method_8308(1);
  self method_85CB();
  self setanimoverride(1, "mp_unarmed_stand_flare2_stand_idle");
  self method_85B3(1);
  self.var_579F = 1;
  wait(0.1);
  self method_802E("npc_usa_m18_smoke_green", "tag_weapon_right");
}

func_743D(param_00) {
  self freezecontrols(param_00);
}

func_743E() {
  self endon("disconnect");
  self endon("death");
  self waittill("beginReactionAnims");
  maps\mp\gametypes\_hub_unk1::func_721A("mp_hub_react_to_crate_in", 1);
  wait(2.15);
  maps\mp\gametypes\_hub_unk1::func_721A("mp_hub_react_to_crate_idle", 1);
  self waittill("exit_PSD_sequence");
  maps\mp\gametypes\_hub_unk1::func_721A("mp_hub_react_to_crate_out", 1);
}

func_24E2(param_00) {
  var_01 = getent("psd_collision", "targetname");
  if(!isDefined(var_01)) {
    return undefined;
  }

  var_02 = (self.var_0116[0] + param_00[0] / 2, self.var_0116[1] + param_00[1] / 2, self.var_0116[2] + param_00[2] / 2 - 25);
  var_03 = spawn("script_model", var_02);
  var_03.var_01A5 = "psdCollision";
  var_03 clonebrushmodeltoscriptmodel(var_01);
  common_scripts\utility::func_A715("psdSequenceDone", "death", "disconnect", "exit_PSD_sequence");
  var_03 delete();
}

func_7005(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  self method_85CB();
  var_02 = vectornormalize(param_00 - self.var_0116);
  var_02 = vectortoangles(var_02);
  var_02 = var_02 * (0, 1, 0);
  var_03 = self.var_0116 + anglestoright(var_02) * 55 + anglesToForward(var_02) * -60 + (0, 0, 73);
  var_04 = self.var_0116 + anglestoright(var_02) * 15 + anglesToForward(var_02) * 3 + (0, 0, 64);
  var_05 = (param_00[0], param_00[1], self.var_0116[2] + 55);
  var_05 = var_05 + anglestoright(var_02) * 5;
  var_06 = vectornormalize(var_05 - var_03);
  var_06 = vectortoangles(var_06);
  self.var_0E9D = spawn("script_model", self.var_76A5);
  self.var_0E9D.var_01A5 = "animatedPSDCamera";
  self.var_0E9D setModel("s2_genericprop");
  self.var_0E9D.var_001D = self getangles();
  thread func_2350(self.var_0E9D);
  self setangles(var_06);
  self method_85C9(1);
  func_743D(1);
  self method_81E2(self.var_0E9D, "tag_player", 500);
  self.var_0E9D moveto(var_03, 0.5);
  self.var_0E9D rotateto(var_06, 0.5);
  self waittill("beginReactionAnims");
  self.var_0E9D.var_0116 = self.var_0116;
  self.var_0E9D.var_001D = var_02;
  self.var_0E9D.var_A2B4 = var_02;
  self.var_0E9D.var_01A5 = "animatedPSDCamera";
  self method_81E2(self.var_0E9D, "tag_origin_animated");
  self.var_0E9D method_8278("mp_hub_crate_drop_cam");
  self waittill("firstItemComingOut");
  self.var_0E9D scriptmodelclearanim();
  self.var_0E9D method_8278("mp_hub_crate_card_cam_in", "card_cam_in_notetrack");
  self method_85A7("hub_loot_cam_earthquake", self.var_08DD.var_0116);
  self.var_0E9D waittillmatch("end", "card_cam_in_notetrack");
  self.var_0E9D scriptmodelclearanim();
  self.var_0E9D method_8278("mp_hub_crate_card_cam_loop");
}

func_7D55() {
  self endon("disconnect");
  self endon("death");
  self method_85C9(0);
  self.var_0E9D scriptmodelclearanim();
  self.var_0E9D method_8278("mp_hub_crate_card_out_cam", "psd_exit_cam");
  self.var_0E9D waittillmatch("end", "psd_exit_cam");
  self.var_0E9D scriptmodelpauseanim(1);
  self method_81E3(500);
  wait(0.6);
  self.var_0E9D delete();
  self.var_0E9D = undefined;
}

func_36E1(param_00) {
  if(isDefined(level.var_08DE) && isDefined(param_00)) {
    level.var_08DE[level.var_08DE.size] = param_00;
  }

  if(isDefined(self.var_4DEF)) {
    self.var_4DEF delete();
    self.var_4DEF = undefined;
  }

  self forceusehintoff();
}

func_2FA9() {
  if(!isDefined(self.var_2F81)) {
    self.var_2F81 = 0;
  }

  self.var_2F81++;
  self method_8322();
}

func_366B() {
  if(!isDefined(self.var_2F81)) {
    self.var_2F81 = 0;
  }

  self.var_2F81--;
  if(!self.var_2F81) {
    self method_8323();
  }
}

oncarrierdeathordisconnect() {
  self.var_4DEF endon("placed");
  self.var_4DEF endon("death");
  common_scripts\utility::func_A70A("death", "disconnect");
  self.var_4DEF delete();
  self.var_4DEF = undefined;
}

func_1459(param_00) {
  var_01 = [];
  foreach(var_03 in level.var_744A) {
    if(isPlayer(var_03) && maps\mp\_utility::func_57A0(var_03) && self != var_03) {
      if(common_scripts\utility::func_302B(self.var_08DD.var_0116, var_03.var_0116) < 65536) {
        var_01[var_01.size] = var_03;
        if(isDefined(param_00)) {
          var_03 lib_0468::func_0A29("watchSD", 0, param_00);
          continue;
        }

        var_03 lib_0468::func_0A29("watchSD", 0, 0);
      }
    }
  }

  return var_01.size;
}

func_23E0() {
  self endon("death");
  self endon("disconnect");
  wait(5);
  maps\mp\gametypes\_hub_stats::func_A124("ch_hub_epicReveal");
}

func_A85E() {
  level endon("game_ended");
  self endon("disconnect");
  if(!isDefined(level.var_77A6)) {
    level.var_77A6 = common_scripts\utility::func_46B7("psd_spawn_location", "targetname");
  }

  var_00 = common_scripts\utility::func_7A33(level.var_77A6);
  self.warpingtosupplydrop = 1;
  self method_85C9(1);
  self setorigin(function_0236(var_00.var_0116), 1);
  self setangles(var_00.var_001D);
}

checksafewarpposition() {
  var_00 = level.var_77A6;
  var_01 = common_scripts\utility::func_7A33(var_00);
  while(var_00.size > 1) {
    if(var_01.var_0116 == (-297, 747.5, 0) || var_01.var_0116 == (242.5, 946.5, 0) || var_01.var_0116 == (-402.5, 914, 0) || var_01.var_0116 == (128.5, 998.5, 0) || var_01.var_0116 == (130, 753.5, 0) || var_01.var_0116 == (-190, 856, 0) || var_01.var_0116 == (-311, 849.5, 0) || var_01.var_0116 == (-245.5, 980.5, 0) || var_01.var_0116 == (-189, 1077.5, 0)) {
      var_00 = common_scripts\utility::func_0F93(var_00, var_01);
      var_01 = common_scripts\utility::func_7A33(var_00);
      continue;
    }

    break;
  }

  return var_01;
}

func_2343(param_00) {
  param_00 endon("death");
  self waittill("disconnect");
  if(isDefined(param_00)) {
    func_7C6A(param_00);
    param_00 delete();
  }
}

func_2350(param_00) {
  param_00 endon("death");
  self waittill("disconnect");
  if(isDefined(param_00)) {
    param_00 delete();
  }
}

func_2865() {
  if(self getstance() == "crouch") {
    var_00 = bulletTrace(self.var_0116, self.var_0116 + (0, 0, 72), 0, self);
    if(var_00["fraction"] != 1) {
      maps\mp\gametypes\_hub_unk1::func_3010("cantPlaceSD", &"HUB_CANT_PLACE_SD", undefined, -100, 1.65, 1);
      return 0;
    }
  }

  return 1;
}

monitorsupplydropawarded() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_00, var_01);
    if(var_00 != "supply_drop_awarded") {
      continue;
    }

    if(var_01 == -1) {
      continue;
    }

    var_02 = tablelookup("mp/supplyDropTypes.csv", 1, var_01, 8);
    if(var_02 != "1") {
      continue;
    }

    var_03 = tablelookup("mp/supplyDropTypes.csv", 1, var_01, 0);
    if(var_03 != "") {
      thread maps\mp\gametypes\_hud_message::func_9102(var_03, var_01);
    }
  }
}
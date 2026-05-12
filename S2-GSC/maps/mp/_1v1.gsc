/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_1v1.gsc
*********************************************/

func_00D5() {
  var_00 = 1;
  level.var_17EF = 1;
  wait(0.5);
  var_01 = [];
  var_01[0] = spawnStruct();
  var_01[0].var_787F = [];
  var_01[0].var_0F56 = common_scripts\utility::func_46B7("arena_exit_spawn", "targetname");
  var_01[0].var_AA45 = [];
  var_01[0].var_5F1A = [];
  var_01[0].var_7A48 = [];
  foreach(var_03 in var_01[0].var_0F56) {
    if(isDefined(var_03.var_0165) && var_03.var_0165 == "winner") {
      var_01[0].var_AA45 = common_scripts\utility::func_0F6F(var_01[0].var_AA45, var_03);
      continue;
    }

    if(isDefined(var_03.var_0165) && var_03.var_0165 == "loser") {
      var_01[0].var_5F1A = common_scripts\utility::func_0F6F(var_01[0].var_5F1A, var_03);
      continue;
    }

    var_01[0].var_7A48 = common_scripts\utility::func_0F6F(var_01[0].var_7A48, var_03);
  }

  for(var_05 = 1; var_05 <= var_00; var_05++) {
    var_01[var_05] = spawnStruct();
    var_01[var_05].var_08BE = 0;
    var_01[var_05].var_252A = [];
    var_01[var_05].var_2679 = [];
    var_01[var_05].var_0F59 = [];
    var_01[var_05].var_0F59 = common_scripts\utility::func_46B7("arena_" + var_05 + "_spawn", "targetname");
    var_01[var_05].var_180D = [];
    var_01[var_05].var_7B72 = [];
    var_01[var_05].var_0F57 = var_05;
    var_01[var_05].var_AA44 = common_scripts\utility::func_46B5("emote_1v1_winner", "targetname").var_0116;
    var_01[var_05].var_AA43 = common_scripts\utility::func_46B5("emote_1v1_winner", "targetname").var_001D;
    var_01[var_05].var_5F19 = common_scripts\utility::func_46B5("emote_1v1_loser", "targetname").var_0116;
    var_01[var_05].var_5F18 = common_scripts\utility::func_46B5("emote_1v1_loser", "targetname").var_001D;
    var_01[var_05].var_99C4 = common_scripts\utility::func_46B5("emote_1v1_tie", "targetname").var_0116;
    var_01[var_05].var_99C3 = common_scripts\utility::func_46B5("emote_1v1_tie", "targetname").var_001D;
    var_01[var_05].curchampclientnum = -1;
    var_01[var_05] thread monitorlonelyqueuebroadcast();
    foreach(var_03 in var_01[var_05].var_0F59) {
      if(isDefined(var_03.var_0165) && var_03.var_0165 == "blue") {
        var_01[var_05].var_180D = common_scripts\utility::func_0F6F(var_01[var_05].var_180D, var_03);
        continue;
      }

      if(isDefined(var_03.var_0165) && var_03.var_0165 == "red") {
        var_01[var_05].var_7B72 = common_scripts\utility::func_0F6F(var_01[var_05].var_7B72, var_03);
      }
    }
  }

  level.var_4F38 = var_01[0];
  level.var_4F39 = var_01;
  level.var_19D5 = [];
  level thread func_5357();
  level thread func_27CA();
  level.hub_1v1_weapon_mode = getdvarint("spv_hub_1v1_weapon_mode", 0);
}

func_5357() {
  level endon("game_ended");
  wait(1);
  var_00 = common_scripts\utility::func_46B5("hub_1v1_spectate_cam", "targetname");
  level.var_90E0 = spawn("script_model", var_00.var_0116);
  level.var_90E0 setModel("tag_player");
  level.var_90E0.var_001D = var_00.var_001D;
}

func_27CA() {
  var_00 = getent("1v1_clip_spawn1", "targetname");
  if(isDefined(var_00)) {
    var_00 delete();
  }

  var_01 = getent("1v1_clip_spawn2", "targetname");
  if(isDefined(var_01)) {
    var_01 delete();
  }

  var_02 = getent("1v1_clip_spawn3", "targetname");
  if(isDefined(var_02)) {
    var_02 delete();
  }

  var_03 = getent("1v1_clip_spawn4", "targetname");
  if(isDefined(var_03)) {
    var_03 delete();
  }

  var_04 = getent("1v1_clip_cover6", "targetname");
  if(isDefined(var_04)) {
    var_04 delete();
  }

  var_05 = getent("1v1_clip_cover5", "targetname");
  if(isDefined(var_05)) {
    var_05 delete();
  }

  var_06 = getent("1v1_clip_cover3", "targetname");
  if(isDefined(var_06)) {
    var_06 delete();
  }

  var_07 = getent("1v1_clip_cover11", "targetname");
  if(isDefined(var_07)) {
    var_07 delete();
  }

  var_08 = getent("1v1_clip_cover12", "targetname");
  if(isDefined(var_08)) {
    var_08 delete();
  }

  var_09 = getent("1v1_clip_cover13", "targetname");
  if(isDefined(var_09)) {
    var_09 delete();
  }

  var_0A = getent("1v1_clip_cover7", "targetname");
  if(isDefined(var_0A)) {
    var_0A delete();
  }

  var_0B = getent("1v1_clip_cover2", "targetname");
  if(isDefined(var_0B)) {
    var_0B delete();
  }

  var_0C = getent("1v1_clip_generic", "targetname");
  if(isDefined(var_0C)) {
    var_0C delete();
  }

  var_0D = spawn("script_model", (347.42, 4243.77, -417.5));
  var_0D.var_001D = (0, 97, 0);
  var_0D setModel("hub_allies_1vs1_cover_01");
  var_0E = spawn("script_model", (352.413, 3234.86, -417.5));
  var_0E.var_001D = (0, 277, 0);
  var_0E setModel("hub_allies_1vs1_cover_10");
  var_0F = spawn("script_model", (1292.58, 3340.23, -417.5));
  var_0F.var_001D = (0, 277, 0);
  var_0F setModel("hub_allies_1vs1_cover_06");
  var_10 = spawn("script_model", (1287.59, 4349.14, -417.5));
  var_10.var_001D = (0, 97, 0);
  var_10 setModel("hub_allies_1vs1_cover_05");
  var_11 = spawn("script_model", (982.529, 3584.26, -417.5));
  var_11.var_001D = (0, 277, 0);
  var_11 setModel("hub_allies_1vs1_cover_07");
  var_12 = spawn("script_model", (834.619, 3443.18, -417.5));
  var_12.var_001D = (0, 277, 0);
  var_12 setModel("hub_allies_1vs1_cover_08");
  var_13 = spawn("script_model", (611.701, 3601.19, -418));
  var_13.var_001D = (0, 97, 0);
  var_13 setModel("hub_allies_1vs1_cover_09");
  var_14 = spawn("script_model", (263.687, 3727.72, -417.5));
  var_14.var_001D = (0, 97, 0);
  var_14 setModel("hub_allies_1vs1_cover_11");
  var_15 = spawn("script_model", (1375.83, 3860.25, -417.5));
  var_15.var_001D = (0, 277, 0);
  var_15 setModel("hub_allies_1vs1_cover_12");
  var_16 = spawn("script_model", (820, 3792, -418.5));
  var_16.var_001D = (0, 277, 0);
  var_16 setModel("hub_allies_1vs1_cover_13a");
  var_17 = spawn("script_model", (820, 3792, -418.5));
  var_17.var_001D = (0, 277, 0);
  var_17 setModel("hub_allies_1vs1_cover_13b");
  var_18 = spawn("script_model", (820, 3792, -418.5));
  var_18.var_001D = (0, 277, 0);
  var_18 setModel("hub_allies_1vs1_cover_13c");
  var_19 = spawn("script_model", (820, 3792, -418.5));
  var_19.var_001D = (0, 277, 0);
  var_19 setModel("hub_allies_1vs1_cover_13d");
  var_1A = spawn("script_model", (657.471, 3999.74, -417.5));
  var_1A.var_001D = (0, 97, 0);
  var_1A setModel("hub_allies_1vs1_cover_02");
  var_1B = spawn("script_model", (808.376, 4149.25, -417.5));
  var_1B.var_001D = (0, 277, 0);
  var_1B setModel("hub_allies_1vs1_cover_03");
  var_1C = spawn("script_model", (1028.36, 3982.31, -418));
  var_1C.var_001D = (0, 277, 0);
  var_1C setModel("hub_allies_1vs1_cover_04");
}

monitorlonelyqueuebroadcast() {
  level endon("game_ended");
  wait(5);
  for(;;) {
    if(!isDefined(level.var_4F38.var_787F)) {
      wait(10);
      continue;
    }

    if(level.var_4F38.var_787F.size == 1 && !self.var_08BE) {
      iprintln(&"HUB_1V1_SOLO_QUEUE");
    }

    wait(60);
  }
}

func_09FB(param_00, param_01) {
  if(!isDefined(param_00)) {
    return;
  }

  if(!isDefined(param_00.var_258D)) {
    param_00.var_258D = 0;
  }

  if(isDefined(param_01) && param_01) {
    level.var_4F38.var_787F = common_scripts\utility::func_0F86(level.var_4F38.var_787F, param_00, 0);
    level.var_4F38.var_787F = common_scripts\utility::func_0F97(level.var_4F38.var_787F);
  } else {
    level.var_4F38.var_787F = common_scripts\utility::func_0972(level.var_4F38.var_787F, param_00);
    level.var_4F38.var_787F = common_scripts\utility::func_0F97(level.var_4F38.var_787F);
    param_00.var_258D = 0;
  }

  if(param_00.var_258D <= 0) {
    param_00 maps\mp\gametypes\_hub_unk1::func_50F0(["hubFeatureStats", "hub1v1", "numTimesQueuedFor1v1"], 1, level.var_4F38.var_787F.size, undefined);
    param_00.var_6899 = level.var_4F38.var_787F.size;
  }

  if(isDefined(param_01) && param_01) {
    wait(0.25);
  }

  param_00.var_930A = gettime();
  func_1CB0();
  func_21E0();
}

func_7CE0(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  var_01 = param_00 func_462F();
  if(var_01 == -1) {
    return;
  }

  var_01 = var_01 - 1;
  level.var_4F38.var_787F = common_scripts\utility::func_0F9A(level.var_4F38.var_787F, var_01);
  level.var_4F38.var_787F = common_scripts\utility::func_0F97(level.var_4F38.var_787F);
  var_02 = param_00 getentitynumber();
  foreach(var_04 in level.var_4F39) {
    if(var_04 == level.var_4F39[0]) {
      continue;
    }

    if(var_02 == var_04.curchampclientnum) {
      var_04.curchampclientnum = -1;
      setomnvar("ui_one_v_one_champion_clientNum", -1);
    }
  }

  param_00 setclientomnvar("ui_hub_1v1_queueposition", 0);
  func_1CB0();
  func_21E0();
}

func_462F() {
  for(var_00 = 0; var_00 < level.var_4F38.var_787F.size; var_00++) {
    if(level.var_4F38.var_787F[var_00] == self) {
      return var_00 + 1;
    }
  }

  return -1;
}

func_1CB0() {
  foreach(var_01 in level.var_4F38.var_787F) {
    var_02 = var_01 func_462F();
    if(var_02 < 0) {
      var_02 = 0;
    }

    var_01 setclientomnvar("ui_hub_1v1_queueposition", var_02);
    var_01 setclientomnvar(level.var_6B22.var_9FEB, level.var_4F38.var_787F.size);
  }
}

func_21E0() {
  if(!isDefined(level.var_4F38.var_787F)) {
    return;
  }

  wait(0.1);
  foreach(var_01 in level.var_4F39) {
    if(var_01 == level.var_4F39[0]) {
      continue;
    }

    level.var_4F38.var_787F = common_scripts\utility::func_0FA0(level.var_4F38.var_787F);
    if(level.var_4F38.var_787F.size >= 2 && !var_01.var_08BE) {
      var_01 thread func_7576();
      return;
    }
  }
}

func_21C9(param_00) {
  level endon("game_ended");
  param_00 endon("forceCloseReadyChecks");
  maps\mp\gametypes\_hub_unk1::func_7DF8(0, 0, 0, 0, 0);
  maps\mp\gametypes\_hub_unk1::func_870B(1);
  wait(0.5);
  maps\mp\gametypes\_hub_notifications::func_8A34(self, "1V1_CHALLENGE");
  thread maps\mp\gametypes\_hub_unk1::func_8636(10, "1v1InviteTimeout", ["death", "disconnect", "1v1ChoiceMade"]);
  thread func_5DD1(param_00);
  var_01 = common_scripts\utility::func_A715("accepted1v1", "declined1v1", "1v1InviteTimeout");
  if(var_01 == "1v1InviteTimeout") {
    param_00 notify("1v1InviteTimeout");
  }

  if(isDefined(self)) {
    maps\mp\gametypes\_hub_unk1::func_A04C();
    maps\mp\gametypes\_hub_unk1::func_870B(0);
    if(isDefined(self.var_572B) && self.var_572B) {
      self setclientomnvar("ui_hub_enable_pause", 0);
    }

    if(!isDefined(self.var_258D) || self.var_258D <= 0) {
      var_02 = int(gettime() - self.var_930A / 1000);
      maps\mp\gametypes\_hub_unk1::func_50F0(["hubFeatureStats", "hub1v1", "timeIn1v1Queue"], var_02, self.var_6899 - 1, undefined);
      maps\mp\gametypes\_hub_unk1::func_5E88("hq_1v1_queue_end", "hq_1v1", var_02, ["reason", var_01]);
      self.var_6899 = undefined;
    }
  }

  if(var_01 == "accepted1v1") {
    self method_8307(0);
    return 1;
  }

  if(isDefined(self)) {
    self setclientomnvar("ui_hub_1v1_queueposition", -1);
  }

  return 0;
}

func_5DD1(param_00) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("1v1InviteTimeout");
  for(;;) {
    self waittill("luinotifyserver", var_01, var_02);
    if(var_01 == "enter_1v1") {
      break;
    }
  }

  self notify("1v1ChoiceMade");
  param_00 notify("1v1ChoiceMade");
  if(var_02 == 1) {
    self notify("accepted1v1");
    return;
  }

  self notify("declined1v1");
}

func_6374(param_00) {
  self endon("1v1match_ended");
  for(;;) {
    param_00 waittill("corpse_created");
    if(isDefined(param_00.var_18A8)) {
      self.var_2679 = common_scripts\utility::func_0F6F(self.var_2679, param_00.var_18A8);
    }
  }
}

func_237C() {
  self waittill("1v1match_ended");
  foreach(var_01 in self.var_2679) {
    var_01 delete();
  }

  self.var_2679 = [];
}

getarenaprimaryweaponname(param_00) {
  var_01 = maps\mp\_utility::func_4737(param_00.var_6B15["loadoutPrimaryWeaponStruct"]);
  var_02 = maps\mp\gametypes\_class::func_1D66(var_01, param_00.var_6B15["loadoutPrimaryAttachmentsGUID"][0], param_00.var_6B15["loadoutPrimaryAttachmentsGUID"][1], param_00.var_6B15["loadoutPrimaryAttachmentsGUID"][2], param_00.var_6B15["loadoutPrimaryAttachmentsGUID"][3], param_00.var_6B15["loadoutPrimaryAttachmentsGUID"][4], param_00.var_6B15["loadoutPrimaryAttachmentsGUID"][5], maps\mp\_utility::func_472D(param_00.var_6B15["loadoutPrimaryWeaponStruct"]), 0, 0, 0, 0);
  return var_02;
}

isarenaingungame(param_00) {
  return maps\mp\gametypes\onevone::ishqarenaingungame(param_00.onevone_classchoicenum);
}

getarenagungameweapons(param_00) {
  var_01 = [];
  switch (param_00.onevone_classchoicenum) {
    case 41:
      var_01 = ["mas38_mp", "volk_mp", "reich_mp"];
      break;

    case 42:
      var_01 = ["g43_mp", "kar98_mp+iron_sight_sniper", "alt+m30_mp+m30_rifle"];
      break;

    case 43:
      var_01 = ["p38_mp", "enfieldno2_mp+akimbo", "model21_mp"];
      break;

    case 44:
      var_01 = ["mg81_mp", "breda30_mp", "bren_mp+telescopic_sight_bren"];
      break;

    case 45:
      var_01 = ["panzerschreck_mp", "bazooka_mp", "c4_mp"];
      break;
  }

  return var_01;
}

getcurrentgungameweapon(param_00, param_01) {
  var_02 = getarenagungameweapons(param_00);
  param_01 = int(min(param_01, var_02.size));
  return var_02[param_01];
}

getarenaweaponmode(param_00) {
  if(isarenaingungame(param_00)) {
    return 1;
  }

  return 0;
}

stream1v1weapons(param_00) {
  self endon("disconnect");
  self.hasstreamed1v1weapons = 0;
  while(!self method_842C(self, param_00)) {
    wait 0.05;
  }

  self.hasstreamed1v1weapons = 1;
}

stream1v1weapon(param_00) {
  self endon("disconnect");
  stream1v1weapons([param_00]);
}

func_7576() {
  self endon("1v1match_ended");
  level endon("game_ended");
  self.var_6B15 = undefined;
  self.onevone_classchoicenum = undefined;
  self.var_08BE = 1;
  while(self.var_252A.size < 2 && level.var_4F38.var_787F.size >= 2 - self.var_252A.size) {
    var_00 = common_scripts\utility::func_0F82(level.var_4F38.var_787F);
    if(isDefined(var_00)) {
      thread maps\mp\gametypes\_hub_unk1::func_8636(11, "forceCloseReadyChecks", ["1v1InviteTimeout", "1v1ChoiceMade"]);
      var_01 = var_00 func_21C9(self);
      if(isDefined(var_01) && var_01 == 1) {
        self.var_252A = common_scripts\utility::func_0F6F(self.var_252A, var_00);
      }

      level.var_4F38.var_787F = common_scripts\utility::func_0F93(level.var_4F38.var_787F, var_00);
      func_1CB0();
    }
  }

  if(self.var_252A.size != 2 || !isDefined(self.var_252A[0]) || !isDefined(self.var_252A[1])) {
    var_02 = 1;
    self.var_08BE = 0;
    foreach(var_04 in self.var_252A) {
      if(isDefined(var_04)) {
        var_05 = var_04 getentitynumber();
        if(var_05 == self.curchampclientnum) {
          var_02 = 0;
        }

        thread func_09FB(var_04, 1);
        self.var_252A = common_scripts\utility::func_0F93(self.var_252A, var_04);
        continue;
      }

      self.var_252A = common_scripts\utility::func_0F93(self.var_252A, var_04);
    }

    if(var_02) {
      self.curchampclientnum = -1;
      setomnvar("ui_one_v_one_champion_clientNum", -1);
    }

    return;
  }

  self.var_252A[0].var_56AD = 1;
  self.var_252A[1].var_56AD = 1;
  self.var_252A[0] func_237B();
  self.var_252A[1] func_237B();
  self.var_252A[0].var_2922 = self;
  self.var_252A[1].var_2922 = self;
  self.var_252A[0].combatantisreadyforexit = 0;
  self.var_252A[1].combatantisreadyforexit = 0;
  while(self.var_252A[0].var_579F == 0 || self.var_252A[1].var_579F == 0) {
    wait 0.05;
  }

  self.var_252A[0].var_56AD = 0;
  self.var_252A[1].var_56AD = 0;
  self.var_252A[0].var_0F58 = self.var_252A[1];
  self.var_252A[1].var_0F58 = self.var_252A[0];
  self.var_252A[0] thread func_1713(self, 0);
  self.var_252A[1] thread func_1713(self, 1);
  thread handle1v1timeout();
  maps\mp\gametypes\onevone::func_92EF(self.var_252A, self);
  thread func_6374(self.var_252A[0]);
  thread func_6374(self.var_252A[1]);
  thread func_237C();
  thread func_92B7();
  thread func_A0DB();
  thread func_1C87();
  foreach(var_00 in level.var_744A) {
    var_00 iclientprintln(&"HUB_1v1_CHAT", self.var_252A[0].var_0109, self.var_252A[1].var_0109);
  }
}

func_1713(param_00, param_01) {
  thread func_8A11(param_00);
  self method_85BF(1);
  self.var_2923 = 0;
  self.var_2529 = param_01;
  thread func_9086(func_6FB8(self, 1), param_00);
  self method_8307(1);
  maps\mp\gametypes\_hub_unk1::func_6010(self, self.var_0F58);
  maps\mp\gametypes\_hub_unk1::func_4D02();
  self setclientomnvar("ui_onevone_opponent_client_num", self.var_0F58 getentitynumber());
  self sethubopponentent(self.var_0F58);
  thread func_4AA2(param_00);
  thread func_4AA3(param_00);
  thread func_4AA4(param_00);
}

handle1v1timeout() {
  level endon("game_ended");
  self endon("1v1match_ended");
  self.var_252A[0] endon("disconnect");
  self.var_252A[1] endon("disconnect");
  wait(90);
  func_3E22();
}

func_237B() {
  self endon("disconnect");
  level endon("game_ended");
  if(self.var_5692) {
    self.var_579F = 0;
    self notify("forceSurrenderDuel");
    self.var_8B93 = 1;
    return;
  }

  if(self.var_572B) {
    self.var_579F = 0;
    self.var_1388 = 1;
    self notify("force_cancel_placement");
    self notify("autoFinishSupplyDrop");
    return;
  }

  if(self.var_5721) {
    if(self.var_572F) {
      self.var_8C8F = 1;
    }

    maps\mp\gametypes\_hub_range::func_38F2();
    return;
  }

  if(isDefined(self.var_A405) || isDefined(self.var_5CC4)) {
    var_00 = common_scripts\utility::func_98E7(isDefined(self.var_A405), self.var_A405, self.var_5CC4);
    maps\mp\gametypes\_hub_unk2::func_741D(var_00);
    return;
  }

  if(!maps\mp\_utility::func_57A0(self)) {
    self waittill("spawned");
    return;
  }

  if(self.var_5722) {
    foreach(var_02 in level.var_0813) {
      var_03 = var_02 method_80E2();
      if(isDefined(var_03) && var_03 == self) {
        var_03 setclientomnvar("ui_hub_in_flakgun", 0);
        self method_80E0(var_02);
        wait 0.05;
        return;
      }
    }

    return;
  }

  if(self.var_57E0) {
    self notify("forceLeave1v1Spectate");
    return;
  }

  if(self.var_56A4) {
    if(isDefined(self.var_155F)) {
      self.var_155F maps\mp\gametypes\_hub_unk1::func_1543((0, 0, 80), self);
      return;
    }

    return;
  }

  if(common_scripts\utility::func_562E(self.isintimertag)) {
    maps\mp\gametypes\_hub_notifications::cleanupfailedtimertag(1);
    return;
  }
}

func_8A11(param_00) {
  self endon("disconnect");
  param_00 endon("1v1match_ended");
  self.var_572A = 1;
  maps\mp\gametypes\_hub_unk1::func_870B(1);
  self.var_542B = 0;
  self.post1v1 = undefined;
  self setclientomnvar("ui_hide_1v1scores", 0);
  self setclientomnvar("ui_hub_in_1v1", 1);
  self setclientomnvar("ui_party_manipulation_enabled", 0);
  self method_8114(1);
  self method_812A(1);
  self setCanDamage(1);
  self method_85C8();
  maps\mp\gametypes\_hub_unk1::func_2FA2();
  self method_8326();
  self takeallweapons();
  self method_85BE(1);
  self method_85B4();
  self method_84B9(1);
  self.var_00BC = self.var_00FB;
  self setclientomnvar("ui_hub_1v1_queueposition", -1);
  foreach(var_02 in self.var_4E03) {
    if(isDefined(var_02)) {
      self nametagvisibleto(self.var_746C);
    }
  }

  maps\mp\gametypes\_hub_unk1::func_7D1D(1);
  maps\mp\gametypes\_hub_unk1::func_7D1E(0);
  var_04 = "";
  var_05 = 0;
  if(!isDefined(param_00.var_6B15) && !isDefined(param_00.onevone_classchoicenum)) {
    maps\mp\_utility::func_3E8E(1);
    param_00 waittill("onevoneClassCreated");
    if(isarenaingungame(param_00)) {
      var_06 = getarenagungameweapons(param_00);
      thread stream1v1weapons(var_06);
      var_04 = getcurrentgungameweapon(param_00, self.var_2923);
      var_05 = 1;
      if(maps\mp\gametypes\_class::func_5826(var_04, 0)) {
        self method_8349(var_04);
        self giveweapon(var_04);
        var_04 = "shovel_mp";
      }
    } else {
      var_04 = getarenaprimaryweaponname(param_00);
      thread stream1v1weapon(var_04);
    }

    while(!self.hasstreamed1v1weapons) {
      wait 0.05;
    }

    maps\mp\_utility::func_3E8E(0);
  } else if(isarenaingungame(param_00)) {
    var_04 = getcurrentgungameweapon(param_00, self.var_2923);
    var_05 = 1;
    if(maps\mp\gametypes\_class::func_5826(var_04, 0)) {
      self method_8349(var_04);
      self giveweapon(var_04);
      var_04 = "shovel_mp";
    }
  } else {
    var_04 = getarenaprimaryweaponname(param_00);
  }

  self setclientomnvar("ui_hub_in_1v1", getarenaweaponmode(param_00) + 1);
  if(isDefined(param_00.var_6B15)) {
    if(param_00.var_6B15["loadoutEquipmentStruct"].var_48CA != 0) {
      var_07 = maps\mp\_utility::func_44CD(param_00.var_6B15["loadoutEquipmentStruct"]);
      self method_8349(var_07);
      self giveweapon(var_07);
    }

    if(param_00.var_6B15["loadoutOffhandStruct"].var_48CA != 0) {
      var_08 = maps\mp\_utility::func_44CD(param_00.var_6B15["loadoutOffhandStruct"]);
      self method_831E(var_08);
      self giveweapon(var_08);
    }
  }

  self method_8327();
  if(isDefined(param_00.onevone_classchoicenum) && param_00.onevone_classchoicenum == 42) {
    self method_8328();
  }

  maps\mp\_utility::func_47A2("specialty_marksmanvision");
  maps\mp\_utility::func_47A2("specialty_improvedholdbreath");
  maps\mp\_utility::func_0642(var_04);
  if(isarenaingungame(param_00)) {
    self.current1v1weaponmode = 1;
  } else {
    self.current1v1weaponmode = 0;
  }

  self method_812B(1);
  thread maps\mp\gametypes\_hub_range::func_47A9(var_05, 1);
  if(isDefined(self.var_9A9A)) {
    self.var_9A9A.var_0018 = 0;
  }

  thread makesureweaponswitches(var_04, param_00);
}

makesureweaponswitches(param_00, param_01) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  param_01 endon("1v1match_ended");
  wait 0.05;
  for(;;) {
    self switchtoweaponimmediate(param_00);
    wait(0.3);
    if(self getcurrentweapon() == param_00) {
      break;
    }
  }
}

func_77C0(param_00, param_01, param_02) {
  var_03 = param_00;
  var_04 = param_01;
  var_05 = &"HUB_1V1_RESULT_TIED";
  if(param_02 == "win" || param_02 == "loss") {
    var_05 = &"HUB_1V1_RESULT_WINNER";
    if(param_02 == "loss") {
      var_03 = param_01;
      var_04 = param_00;
    }
  }

  foreach(var_07 in level.var_744A) {
    var_07 iclientprintln(var_05, var_03, var_04);
  }
}

func_4AA2(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  param_00 endon("1v1match_ended");
  for(;;) {
    self waittill("death", var_01, var_02, var_03);
    childthread func_6362(param_00);
    if(isDefined(var_01) && isDefined(var_01.var_572A) && var_01.var_572A && self.var_572A) {
      if(isarenaingungame(param_00)) {
        if(maps\mp\_utility::func_5755(var_02)) {
          self.var_2923 = max(0, self.var_2923 - 1);
        } else if(self != var_01) {
          var_01.var_2923 = var_01.var_2923 + 1;
          if(var_01.var_2923 < 3) {
            var_04 = getcurrentgungameweapon(param_00, var_01.var_2923);
            var_01 takeallweapons();
            if(maps\mp\gametypes\_class::func_5826(var_04, 0)) {
              var_01 method_8349(var_04);
              var_01 giveweapon(var_04);
              var_04 = "shovel_mp";
            }

            var_01 maps\mp\_utility::func_0642(var_04);
            var_01 makesureweaponswitches(var_04, param_00);
          }
        } else {
          self.var_2923 = max(0, self.var_2923 - 1);
        }
      } else if(self != var_01) {
        var_01.var_2923 = var_01.var_2923 + 1;
      } else if(self.var_2923 != 0) {
        self.var_2923 = self.var_2923 - 1;
      }

      param_00 thread func_A0DB();
      param_00 thread func_1C87();
      if(var_01.var_2923 >= 3) {
        self method_8307(0);
        self.var_5B8F = self.var_0116;
        func_77C0(self.var_0109, var_01.var_0109, "loss");
        thread func_4AA8("loss", param_00);
        if(self.var_2923 == 0) {
          var_01 thread func_4AA8("win", param_00, 1);
        } else {
          var_01 thread func_4AA8("win", param_00);
        }

        return;
      }
    }
  }
}

func_4AA3(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  param_00 endon("1v1match_ended");
  param_00 endon("1v1_begin_exit");
  for(;;) {
    self waittill("luinotifyserver", var_01, var_02);
    if(var_01 == "hub_leave_activity") {
      thread func_4AA6(param_00);
      return;
    }
  }
}

func_4AA4(param_00) {
  level endon("game_ended");
  param_00 endon("1v1match_ended");
  param_00 endon("1v1_begin_exit");
  self waittill("disconnect");
  if(!isDefined(self)) {
    param_00 thread func_3E22();
    return;
  }

  self.combatantisreadyforexit = 1;
  thread func_4AA6(param_00);
}

func_4AA6(param_00) {
  param_00 notify("1v1_begin_exit");
  self method_8307(0);
  if(param_00.var_252A[0] == self) {
    func_77C0(param_00.var_252A[0].var_0109, param_00.var_252A[1].var_0109, "loss");
    if(isDefined(param_00.var_252A[0])) {
      param_00.var_252A[0] thread func_4AA8("loss", param_00, undefined, 1);
    }

    if(isDefined(param_00.var_252A[1])) {
      param_00.var_252A[1] thread func_4AA8("win", param_00, undefined, 1);
      return;
    }

    return;
  }

  func_77C0(param_00.var_252A[0].var_0109, param_00.var_252A[1].var_0109, "win");
  if(isDefined(param_00.var_252A[0])) {
    param_00.var_252A[0] thread func_4AA8("win", param_00, undefined, 1);
  }

  if(isDefined(param_00.var_252A[1])) {
    param_00.var_252A[1] thread func_4AA8("loss", param_00, undefined, 1);
  }
}

func_6362(param_00) {
  self waittill("spawned");
  param_00.var_252A[0] maps\mp\gametypes\_hub_unk1::func_7D1D(1);
  param_00.var_252A[1] maps\mp\gametypes\_hub_unk1::func_7D1D(1);
  param_00.var_252A[0] sethubopponentent(param_00.var_252A[1]);
  param_00.var_252A[1] sethubopponentent(param_00.var_252A[0]);
}

func_4AA8(param_00, param_01, param_02, param_03) {
  self endon("disconnect");
  level endon("level_ended");
  if(isDefined(self.post1v1)) {
    return;
  }

  self.post1v1 = 1;
  if(param_00 == "win") {
    if(!isDefined(level.var_66A3)) {
      level.var_66A3 = 0;
    } else {
      level.var_66A3++;
      if(level.var_66A3 >= level.var_4F38.var_AA45.size) {
        level.var_66A3 = 0;
      }
    }
  } else if(param_00 == "loss") {
    if(!isDefined(level.var_66A2)) {
      level.var_66A2 = 0;
    } else {
      level.var_66A2++;
      if(level.var_66A2 >= level.var_4F38.var_5F1A.size) {
        level.var_66A2 = 0;
      }
    }
  } else if(param_00 == "tie") {
    if(!isDefined(level.var_66A2)) {
      level.var_66A2 = 0;
    } else {
      level.var_66A2++;
      if(level.var_66A2 >= level.var_4F38.var_5F1A.size) {
        level.var_66A2 = 0;
      }
    }
  }

  var_04 = common_scripts\utility::func_7A33(level.var_4F38.var_7A48);
  switch (param_00) {
    case "win":
      if(isDefined(param_03) && param_03) {
        if(isDefined(self.previousforfeitopponents)) {
          var_05 = 0;
          foreach(var_07 in self.previousforfeitopponents) {
            if(isDefined(var_07) && var_07 == self.var_0F58.var_01D6) {
              var_05 = 1;
              break;
            }
          }

          if(var_05) {
            var_04 = level.var_4F38.var_AA45[level.var_66A3];
            break;
          }
        } else {
          self.previousforfeitopponents = [];
        }

        self.previousforfeitopponents = common_scripts\utility::func_0F6F(self.previousforfeitopponents, self.var_0F58.var_01D6);
      }

      thread maps\mp\gametypes\_missions::func_7752("ch_daily_2");
      thread maps\mp\gametypes\_missions::func_7750("ch_hq_1v1");
      var_09 = self getrankedplayerdata(common_scripts\utility::func_46AB(), "hubStats", "num1v1Wins") + 1;
      self setrankedplayerdata(common_scripts\utility::func_46AB(), "hubStats", "num1v1Wins", var_09);
      maps\mp\gametypes\_hub_unk1::func_84DE(["hubFeatureStats", "hub1v1", "numHub1v1Wins"], var_09);
      maps\mp\gametypes\_hub_unk1::func_83DC("numHub1v1Wins", "hub1v1", 1, undefined, undefined);
      var_04 = level.var_4F38.var_AA45[level.var_66A3];
      if(isDefined(param_02) && param_02) {
        lib_0468::func_0A1C("win", self.var_0F58.var_01D6, 1);
      } else {
        lib_0468::func_0A1C("win", self.var_0F58.var_01D6);
      }
      break;

    case "loss":
      var_09 = self getrankedplayerdata(common_scripts\utility::func_46AB(), "hubStats", "num1v1Losses") + 1;
      self setrankedplayerdata(common_scripts\utility::func_46AB(), "hubStats", "num1v1Losses", var_09);
      maps\mp\gametypes\_hub_unk1::func_84DE(["hubFeatureStats", "hub1v1", "numHub1v1Losses"], var_09);
      lib_0468::func_0A1C("lose", self.var_0F58.var_01D6);
      maps\mp\gametypes\_hub_unk1::func_83DC("numHub1v1Losses", "hub1v1", 1, undefined, undefined);
      var_04 = level.var_4F38.var_5F1A[level.var_66A2];
      break;

    case "tie":
      var_04 = level.var_4F38.var_5F1A[level.var_66A2];
      lib_0468::func_0A1C("tie", self.var_0F58.var_01D6);
      break;

    default:
      var_04 = common_scripts\utility::func_7A33(level.var_4F38.var_7A48);
      break;
  }

  self luinotifyevent(&"wrap_up_1v1", 0);
  maps\mp\gametypes\_hub_unk1::func_A03C(self, self.var_0F58);
  var_0A = param_01.var_9A04;
  if(var_0A > 60) {
    var_0A = 60;
  }

  if(!isDefined(param_03) || !param_03) {
    maps\mp\gametypes\_hub_unk1::func_5E88("hq_1v1_match", "hq_1v1", var_0A, ["match_id", 0, "kills", self.var_2923, "winloss", param_00]);
    var_09 = self getrankedplayerdata(common_scripts\utility::func_46AB(), "hubStats", "num1v1Matches") + 1;
    self setrankedplayerdata(common_scripts\utility::func_46AB(), "hubStats", "num1v1Matches", var_09);
    maps\mp\gametypes\_hub_unk1::func_84DE(["hubFeatureStats", "hub1v1", "numHub1v1Matches"], var_09);
  }

  maps\mp\gametypes\_hub_unk1::func_83DC("numHub1v1Matches", "hub1v1", 1, var_0A, undefined);
  func_4AA5(param_00, param_01);
  func_38EE(var_04);
  if(param_01.var_08BE) {
    param_01.var_252A = [];
    param_01.var_08BE = 0;
    param_01 notify("1v1match_ended");
  }

  self setclientomnvar("ui_onevone_opponent_client_num", -1);
  if(param_00 == "win") {
    param_01.curchampclientnum = self getentitynumber();
    setomnvar("ui_one_v_one_champion_clientNum", param_01.curchampclientnum);
    thread func_09FB(self, 1);
    return;
  }

  if(param_00 == "tie") {
    thread func_21E0();
  }
}

func_4AA5(param_00, param_01) {
  level endon("game_ended");
  self endon("disconnect");
  while(!maps\mp\_utility::func_57A0(self)) {
    wait 0.05;
  }

  self setdemigod(1);
  var_02 = [];
  var_02["win"] = 1;
  var_02["loss"] = -1;
  var_02["draw"] = 0;
  self luinotifyeventextraplayer(&"ui_end_hub_1v1", 5, self.var_2923, self.var_0F58.var_2923, self getentitynumber(), self.var_0F58 getentitynumber(), var_02[param_00]);
  self allowmovement(0);
  self allowjump(0);
  self method_8113(0);
  self method_8114(0);
  self method_85BF(0);
  self method_8307(0);
  wait 0.05;
  maps\mp\gametypes\_hub_unk1::func_7446();
  maps\mp\gametypes\_hub_unk1::func_3663();
  self.var_542B = 1;
  self method_85C7();
  switch (param_00) {
    case "win":
      thread func_75DE("win", param_01);
      break;

    case "loss":
      self method_808C();
      if(isDefined(self.var_5B8F)) {
        maps\mp\gametypes\_hub_unk1::func_8698(self.var_5B8F);
      }

      thread func_75DE("loss", param_01);
      break;

    case "tie":
      if(self.var_2529 == 1) {} else {}

      thread func_75DE("tie", param_01);
      break;

    default:
      break;
  }

  while((isDefined(param_01.var_252A[0]) && !param_01.var_252A[0].combatantisreadyforexit) || isDefined(param_01.var_252A[1]) && !param_01.var_252A[1].combatantisreadyforexit) {
    wait 0.05;
  }

  self allowmovement(1);
  self allowjump(1);
  self method_8113(1);
  self method_8114(1);
  self setdemigod(0);
  self notify("cancelEmoteGodMode");
}

func_237A() {
  self endon("disconnect");
  wait 0.05;
  if(!isDefined(self)) {
    return;
  }

  self notify("1v1_ended");
  self setclientomnvar("ui_hide_1v1scores", 1);
  self setclientomnvar("ui_hub_in_1v1", 0);
  self setclientomnvar("ui_party_manipulation_enabled", 1);
  self luinotifyevent(&"end_hub_1v1", 0);
  func_1C86();
  self.var_2923 = 0;
  self.current1v1weaponmode = undefined;
  self.var_00BC = self.var_00FB;
  self sethubopponentent(undefined);
  self method_84B9(0);
  self.post1v1 = undefined;
  foreach(var_01 in level.var_61ED) {
    if(isDefined(var_01) && isDefined(var_01.var_0117) && var_01.var_0117 == self) {
      var_01 delete();
    }
  }

  maps\mp\gametypes\_hub_unk1::func_8BEB();
  self.var_572A = 0;
  maps\mp\gametypes\_hub_unk1::func_870B(0);
  self method_8114(0);
  self method_812B(0);
  maps\mp\_utility::func_3E8E(0);
  self method_85BE(0);
  self method_812A(0);
  self method_8307(1);
  self.var_1388 = 0;
  if(isDefined(self.var_9A9A)) {
    self.var_9A9A.var_0018 = 1;
  }

  maps\mp\gametypes\_hub_unk1::func_7E4E(1);
  maps\mp\gametypes\_hub_unk1::func_7E4F(0);
  wait 0.05;
  self switchtoweaponimmediate("emote_weapon_mp");
}

func_9086(param_00, param_01) {
  if(!isDefined(param_00)) {
    param_00 = param_01.var_0F59[0];
  }

  param_01.var_252A[0] maps\mp\gametypes\_hub_unk1::func_7D1D(1);
  param_01.var_252A[1] maps\mp\gametypes\_hub_unk1::func_7D1D(1);
  self setorigin(function_0236(param_00.var_0116), 1);
  self setangles(param_00.var_001D);
}

func_92B7() {
  level endon("game_ended");
  self endon("1v1match_ended");
  self.var_252A[0] endon("disconnect");
  self.var_252A[1] endon("disconnect");
  self.var_9A04 = 0;
  setomnvar("ui_hub_1v1_timer", gettime() + -5536);
  self.var_252A[0] luinotifyevent(&"begin_hub_1v1", 0);
  self.var_252A[1] luinotifyevent(&"begin_hub_1v1", 0);
  for(;;) {
    wait(1);
    self.var_9A04++;
    if(self.var_9A04 >= 60) {
      if(self.var_252A[0].var_2923 > self.var_252A[1].var_2923) {
        var_00 = "win";
        var_01 = "loss";
      } else if(self.var_252A[0].var_2923 < self.var_252A[1].var_2923) {
        var_01 = "win";
        var_00 = "loss";
      } else {
        var_00 = "tie";
        var_01 = "tie";
      }

      func_77C0(self.var_252A[0].var_0109, self.var_252A[1].var_0109, var_00);
      self.var_252A[0] thread func_4AA8(var_00, self);
      self.var_252A[1] thread func_4AA8(var_01, self);
      return;
    }
  }
}

func_A0DB() {
  func_A0F7(self.var_252A[0], self.var_252A[1]);
  func_A0F7(self.var_252A[1], self.var_252A[0]);
}

func_1C87() {
  var_00 = self.var_252A[0];
  var_01 = self.var_252A[1];
  foreach(var_03 in level.var_744A) {
    if(var_03 == var_00 || var_03 == var_01) {
      continue;
    }

    if(!isDefined(var_00.var_2923)) {
      var_00.var_2923 = 0;
    }

    if(!isDefined(var_01.var_2923)) {
      var_01.var_2923 = 0;
    }

    var_03 luinotifyeventextraplayer(&"update_hub_1v1_current_score", 4, var_00.var_2923, var_01.var_2923, var_00.var_0109, var_01.var_0109);
  }
}

func_1C86() {
  foreach(var_01 in level.var_744A) {
    var_01 luinotifyeventextraplayer(&"clean_hub_1v1_score", 0);
  }
}

func_A0F7(param_00, param_01) {
  if(!isDefined(param_00.var_2923)) {
    param_00.var_2923 = 0;
  }

  if(!isDefined(param_01.var_2923)) {
    param_01.var_2923 = 0;
  }

  var_02 = 210;
  param_00 luinotifyeventextraplayer(&"update_hub_1v1", 2, param_00.var_2923, param_01.var_2923);
}

func_3E22() {
  var_00 = 0;
  foreach(var_02 in self.var_252A) {
    if(isDefined(var_02)) {
      var_02 maps\mp\gametypes\_hub_unk1::func_7446();
      var_02 maps\mp\gametypes\_hub_unk1::func_3663();
      var_02.var_542B = 1;
      var_02 method_85C7();
      var_02 func_38EE(level.var_4F38.var_7A48[var_00]);
      foreach(var_04 in level.var_61ED) {
        if(isDefined(var_04) && isDefined(var_04.var_0117) && var_04.var_0117 == var_02) {
          var_04 delete();
        }
      }
    }

    var_00++;
  }

  foreach(var_04 in level.var_61ED) {
    if(isDefined(var_04) && !isDefined(var_04.var_0117)) {
      var_04 delete();
    }
  }

  self.var_252A = [];
  self.var_08BE = 0;
  self notify("1v1match_ended");
  func_21E0();
}

func_38EE(param_00) {
  self endon("disconnect");
  if(!isDefined(self)) {
    return;
  }

  maps\mp\gametypes\_hub_unk1::func_8698(param_00.var_0116);
  self setangles(param_00.var_001D);
  self uploadhub1v1leaderboarddata();
  func_237A();
}

func_6FB8(param_00, param_01) {
  if(param_00.var_2922.var_252A.size == 2) {
    var_02 = [];
    if(param_00 == param_00.var_2922.var_252A[0]) {
      if(isDefined(param_01) && param_01) {
        return common_scripts\utility::func_7A33(param_00.var_2922.var_180D);
      }

      var_02 = function_01AC(param_00.var_2922.var_0F59, param_00.var_2922.var_252A[1].var_0116, 3000);
    } else if(param_00 == param_00.var_2922.var_252A[1]) {
      if(isDefined(param_01) && param_01) {
        return common_scripts\utility::func_7A33(param_00.var_2922.var_7B72);
      }

      var_02 = function_01AC(param_00.var_2922.var_0F59, param_00.var_2922.var_252A[0].var_0116, 3000);
    }

    if(var_02.size < 1) {
      return param_00.var_2922.var_0F59[0];
    }

    if(var_02[0].var_0165 == "blue") {
      return common_scripts\utility::func_7A33(param_00.var_2922.var_7B72);
    } else {
      return common_scripts\utility::func_7A33(param_00.var_2922.var_180D);
    }
  }

  return common_scripts\utility::func_7A33(param_01.var_2922.var_0F59);
}

func_75DE(param_00, param_01) {
  self endon("disconnect");
  level endon("game_ended");
  wait(0.5);
  switch (param_00) {
    case "win":
      self.var_258D++;
      if(self getrankedplayerdata(common_scripts\utility::func_46AB(), "hubStats", "longest1v1WinStreak") < self.var_258D) {
        self setrankedplayerdata(common_scripts\utility::func_46AA(), "hubFeatureStats", "hub1v1", "longestHub1v1WinStreak", self.var_258D);
        self setrankedplayerdata(common_scripts\utility::func_46AB(), "hubStats", "longest1v1WinStreak", self.var_258D);
      }

      maps\mp\gametypes\_hub_unk1::func_721A("mp_emote_cheer_yeah");
      wait(3.033333);
      self notify("post1v1EmoteComplete");
      self.combatantisreadyforexit = 1;
      break;

    case "loss":
      maps\mp\gametypes\_hub_unk1::func_721A("mp_emote_defeated_c");
      wait(4.366667);
      self notify("post1v1EmoteComplete");
      self.combatantisreadyforexit = 1;
      break;

    case "tie":
      if(self.var_2529 == 1) {
        wait(1);
        self notify("post1v1EmoteComplete");
        self.combatantisreadyforexit = 1;
      } else {
        wait(1);
        self notify("post1v1EmoteComplete");
        self.combatantisreadyforexit = 1;
      }
      break;

    default:
      break;
  }
}

func_35AC() {
  level endon("game_ended");
  level.var_6B2B = getent("trigger_onevone", "targetname");
  if(!isDefined(level.var_6B2B)) {
    return;
  }

  for(;;) {
    level.var_6B2B waittill("trigger", var_00);
    var_01 = 0;
    if(isDefined(var_00) && isPlayer(var_00)) {
      foreach(var_03 in level.var_4F38.var_252A) {
        if(var_03 == var_00) {
          var_01 = 1;
        }
      }

      if(!var_01) {
        var_05 = common_scripts\utility::func_7A33(level.var_4F38.var_7A48);
        var_00 maps\mp\gametypes\_hub_unk1::func_8698(var_05.var_0116);
        var_00 setangles(var_05.var_001D);
      }
    }
  }
}

func_7475() {
  self notifyonplayercommand("exitSpectateCam", "+stance");
  self method_81E2(level.var_90E0, "tag_player");
  self setclientdvar("cg_fov", 85);
  maps\mp\gametypes\_hub_unk1::func_73E5(1);
  self.var_57E0 = 1;
  maps\mp\gametypes\_hub_unk1::func_870B(1);
  common_scripts\utility::func_A715("exitSpectateCam", "forceLeave1v1Spectate");
  maps\mp\gametypes\_hub_unk1::func_73E5(0);
  self notifyonplayercommandremove("exitSpectateCam", "+stance");
  self method_81E3();
  self setclientdvar("cg_fov", level.var_4F4A);
  self.var_57E0 = 0;
  maps\mp\gametypes\_hub_unk1::func_870B(0);
}
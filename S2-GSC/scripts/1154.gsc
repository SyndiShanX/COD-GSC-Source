/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1154.gsc
**************************************/

init() {
  var_0 = 1;
  level._id_17EF = 1;
  wait 0.5;
  var_1 = [];
  var_1[0] = spawnStruct();
  var_1[0]._id_787F = [];
  var_1[0]._id_0F56 = common_scripts\utility::_id_46B7("arena_exit_spawn", "targetname");
  var_1[0]._id_AA45 = [];
  var_1[0]._id_5F1A = [];
  var_1[0]._id_7A48 = [];

  foreach(var_3 in var_1[0]._id_0F56) {
    if(isDefined(var_3._id_0165) && var_3._id_0165 == "winner") {
      var_1[0]._id_AA45 = common_scripts\utility::_id_0F6F(var_1[0]._id_AA45, var_3);
      continue;
    }

    if(isDefined(var_3._id_0165) && var_3._id_0165 == "loser") {
      var_1[0]._id_5F1A = common_scripts\utility::_id_0F6F(var_1[0]._id_5F1A, var_3);
      continue;
    }

    var_1[0]._id_7A48 = common_scripts\utility::_id_0F6F(var_1[0]._id_7A48, var_3);
  }

  for(var_5 = 1; var_5 <= var_0; var_5++) {
    var_1[var_5] = spawnStruct();
    var_1[var_5]._id_08BE = 0;
    var_1[var_5]._id_252A = [];
    var_1[var_5]._id_2679 = [];
    var_1[var_5]._id_0F59 = [];
    var_1[var_5]._id_0F59 = common_scripts\utility::_id_46B7("arena_" + var_5 + "_spawn", "targetname");
    var_1[var_5]._id_180D = [];
    var_1[var_5]._id_7B72 = [];
    var_1[var_5]._id_0F57 = var_5;
    var_1[var_5]._id_AA44 = common_scripts\utility::_id_46B5("emote_1v1_winner", "targetname").origin;
    var_1[var_5]._id_AA43 = common_scripts\utility::_id_46B5("emote_1v1_winner", "targetname").angles;
    var_1[var_5]._id_5F19 = common_scripts\utility::_id_46B5("emote_1v1_loser", "targetname").origin;
    var_1[var_5]._id_5F18 = common_scripts\utility::_id_46B5("emote_1v1_loser", "targetname").angles;
    var_1[var_5]._id_99C4 = common_scripts\utility::_id_46B5("emote_1v1_tie", "targetname").origin;
    var_1[var_5]._id_99C3 = common_scripts\utility::_id_46B5("emote_1v1_tie", "targetname").angles;
    var_1[var_5].curchampclientnum = -1;
    var_1[var_5] thread monitorlonelyqueuebroadcast();

    foreach(var_3 in var_1[var_5]._id_0F59) {
      if(isDefined(var_3._id_0165) && var_3._id_0165 == "blue") {
        var_1[var_5]._id_180D = common_scripts\utility::_id_0F6F(var_1[var_5]._id_180D, var_3);
        continue;
      }

      if(isDefined(var_3._id_0165) && var_3._id_0165 == "red")
        var_1[var_5]._id_7B72 = common_scripts\utility::_id_0F6F(var_1[var_5]._id_7B72, var_3);
    }
  }

  level._id_4F38 = var_1[0];
  level._id_4F39 = var_1;
  level.bot_funcs = [];
  level thread _id_5357();
  level thread _id_27CA();
  level.hub_1v1_weapon_mode = getdvarint("spv_hub_1v1_weapon_mode", 0);
}

_id_5357() {
  level endon("game_ended");
  wait 1;
  var_0 = common_scripts\utility::_id_46B5("hub_1v1_spectate_cam", "targetname");
  level._id_90E0 = spawn("script_model", var_0.origin);
  level._id_90E0 setModel("tag_player");
  level._id_90E0.angles = var_0.angles;
}

_id_27CA() {
  var_0 = _getent("1v1_clip_spawn1", "targetname");

  if(isDefined(var_0))
    var_0 delete();

  var_1 = _getent("1v1_clip_spawn2", "targetname");

  if(isDefined(var_1))
    var_1 delete();

  var_2 = _getent("1v1_clip_spawn3", "targetname");

  if(isDefined(var_2))
    var_2 delete();

  var_3 = _getent("1v1_clip_spawn4", "targetname");

  if(isDefined(var_3))
    var_3 delete();

  var_4 = _getent("1v1_clip_cover6", "targetname");

  if(isDefined(var_4))
    var_4 delete();

  var_5 = _getent("1v1_clip_cover5", "targetname");

  if(isDefined(var_5))
    var_5 delete();

  var_6 = _getent("1v1_clip_cover3", "targetname");

  if(isDefined(var_6))
    var_6 delete();

  var_7 = _getent("1v1_clip_cover11", "targetname");

  if(isDefined(var_7))
    var_7 delete();

  var_8 = _getent("1v1_clip_cover12", "targetname");

  if(isDefined(var_8))
    var_8 delete();

  var_9 = _getent("1v1_clip_cover13", "targetname");

  if(isDefined(var_9))
    var_9 delete();

  var_10 = _getent("1v1_clip_cover7", "targetname");

  if(isDefined(var_10))
    var_10 delete();

  var_11 = _getent("1v1_clip_cover2", "targetname");

  if(isDefined(var_11))
    var_11 delete();

  var_12 = _getent("1v1_clip_generic", "targetname");

  if(isDefined(var_12))
    var_12 delete();

  var_13 = spawn("script_model", (347.42, 4243.77, -417.5));
  var_13.angles = (0, 97, 0);
  var_13 setModel("hub_allies_1vs1_cover_01");
  var_14 = spawn("script_model", (352.413, 3234.86, -417.5));
  var_14.angles = (0, 277, 0);
  var_14 setModel("hub_allies_1vs1_cover_10");
  var_15 = spawn("script_model", (1292.58, 3340.23, -417.5));
  var_15.angles = (0, 277, 0);
  var_15 setModel("hub_allies_1vs1_cover_06");
  var_16 = spawn("script_model", (1287.59, 4349.14, -417.5));
  var_16.angles = (0, 97, 0);
  var_16 setModel("hub_allies_1vs1_cover_05");
  var_17 = spawn("script_model", (982.529, 3584.26, -417.5));
  var_17.angles = (0, 277, 0);
  var_17 setModel("hub_allies_1vs1_cover_07");
  var_18 = spawn("script_model", (834.619, 3443.18, -417.5));
  var_18.angles = (0, 277, 0);
  var_18 setModel("hub_allies_1vs1_cover_08");
  var_19 = spawn("script_model", (611.701, 3601.19, -418));
  var_19.angles = (0, 97, 0);
  var_19 setModel("hub_allies_1vs1_cover_09");
  var_20 = spawn("script_model", (263.687, 3727.72, -417.5));
  var_20.angles = (0, 97, 0);
  var_20 setModel("hub_allies_1vs1_cover_11");
  var_21 = spawn("script_model", (1375.83, 3860.25, -417.5));
  var_21.angles = (0, 277, 0);
  var_21 setModel("hub_allies_1vs1_cover_12");
  var_22 = spawn("script_model", (820, 3792, -418.5));
  var_22.angles = (0, 277, 0);
  var_22 setModel("hub_allies_1vs1_cover_13a");
  var_23 = spawn("script_model", (820, 3792, -418.5));
  var_23.angles = (0, 277, 0);
  var_23 setModel("hub_allies_1vs1_cover_13b");
  var_24 = spawn("script_model", (820, 3792, -418.5));
  var_24.angles = (0, 277, 0);
  var_24 setModel("hub_allies_1vs1_cover_13c");
  var_25 = spawn("script_model", (820, 3792, -418.5));
  var_25.angles = (0, 277, 0);
  var_25 setModel("hub_allies_1vs1_cover_13d");
  var_26 = spawn("script_model", (657.471, 3999.74, -417.5));
  var_26.angles = (0, 97, 0);
  var_26 setModel("hub_allies_1vs1_cover_02");
  var_27 = spawn("script_model", (808.376, 4149.25, -417.5));
  var_27.angles = (0, 277, 0);
  var_27 setModel("hub_allies_1vs1_cover_03");
  var_28 = spawn("script_model", (1028.36, 3982.31, -418));
  var_28.angles = (0, 277, 0);
  var_28 setModel("hub_allies_1vs1_cover_04");
}

monitorlonelyqueuebroadcast() {
  level endon("game_ended");
  wait 5;

  for(;;) {
    if(!isDefined(level._id_4F38._id_787F)) {
      wait 10;
      continue;
    }

    if(level._id_4F38._id_787F.size == 1 && !self._id_08BE)
      _iprintln(&"HUB_1V1_SOLO_QUEUE");

    wait 60;
  }
}

_id_09FB(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0._id_258D))
    var_0._id_258D = 0;

  if(isDefined(var_1) && var_1) {
    level._id_4F38._id_787F = common_scripts\utility::_id_0F86(level._id_4F38._id_787F, var_0, 0);
    level._id_4F38._id_787F = common_scripts\utility::_id_0F97(level._id_4F38._id_787F);
  } else {
    level._id_4F38._id_787F = common_scripts\utility::_id_0972(level._id_4F38._id_787F, var_0);
    level._id_4F38._id_787F = common_scripts\utility::_id_0F97(level._id_4F38._id_787F);
    var_0._id_258D = 0;
  }

  if(var_0._id_258D <= 0) {
    var_0 _id_04E0::_id_50F0(["hubFeatureStats", "hub1v1", "numTimesQueuedFor1v1"], 1, level._id_4F38._id_787F.size, undefined);
    var_0._id_6899 = level._id_4F38._id_787F.size;
  }

  if(isDefined(var_1) && var_1)
    wait 0.25;

  var_0._id_930A = gettime();
  _id_1CB0();
  _id_21E0();
}

_id_7CE0(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0 _id_462F();

  if(var_1 == -1) {
    return;
  }
  var_1 = var_1 - 1;
  level._id_4F38._id_787F = common_scripts\utility::_id_0F9A(level._id_4F38._id_787F, var_1);
  level._id_4F38._id_787F = common_scripts\utility::_id_0F97(level._id_4F38._id_787F);
  var_2 = var_0 getentitynumber();

  foreach(var_4 in level._id_4F39) {
    if(var_4 == level._id_4F39[0]) {
      continue;
    }
    if(var_2 == var_4.curchampclientnum) {
      var_4.curchampclientnum = -1;
      _setomnvar("ui_one_v_one_champion_clientNum", -1);
    }
  }

  var_0 setclientomnvar("ui_hub_1v1_queueposition", 0);
  _id_1CB0();
  _id_21E0();
}

_id_462F() {
  for(var_0 = 0; var_0 < level._id_4F38._id_787F.size; var_0++) {
    if(level._id_4F38._id_787F[var_0] == self)
      return var_0 + 1;
  }

  return -1;
}

_id_1CB0() {
  foreach(var_1 in level._id_4F38._id_787F) {
    var_2 = var_1 _id_462F();

    if(var_2 < 0)
      var_2 = 0;

    var_1 setclientomnvar("ui_hub_1v1_queueposition", var_2);
    var_1 setclientomnvar(level._id_6B22._id_9FEB, level._id_4F38._id_787F.size);
  }
}

_id_21E0() {
  if(!isDefined(level._id_4F38._id_787F)) {
    return;
  }
  wait 0.1;

  foreach(var_1 in level._id_4F39) {
    if(var_1 == level._id_4F39[0]) {
      continue;
    }
    level._id_4F38._id_787F = common_scripts\utility::_id_0FA0(level._id_4F38._id_787F);

    if(level._id_4F38._id_787F.size >= 2 && !var_1._id_08BE) {
      var_1 thread _id_7576();
      return;
    }
  }
}

_id_21C9(var_0) {
  level endon("game_ended");
  var_0 endon("forceCloseReadyChecks");
  _id_04E0::_id_7DF8(0, 0, 0, 0, 0);
  _id_04E0::_id_870B(1);
  wait 0.5;
  _id_04DC::_id_8A34(self, "1V1_CHALLENGE");
  thread _id_04E0::disablefocus(10, "1v1InviteTimeout", ["death", "disconnect", "1v1ChoiceMade"]);
  thread _id_5DD1(var_0);
  var_1 = common_scripts\utility::waittill_any_return("accepted1v1", "declined1v1", "1v1InviteTimeout");

  if(var_1 == "1v1InviteTimeout")
    var_0 notify("1v1InviteTimeout");

  if(isDefined(self)) {
    _id_04E0::_id_A04C();
    _id_04E0::_id_870B(0);

    if(isDefined(self._id_572B) && self._id_572B)
      self setclientomnvar("ui_hub_enable_pause", 0);

    if(!isDefined(self._id_258D) || self._id_258D <= 0) {
      var_2 = int((gettime() - self._id_930A) / 1000);
      _id_04E0::_id_50F0(["hubFeatureStats", "hub1v1", "timeIn1v1Queue"], var_2, self._id_6899 - 1, undefined);
      _id_04E0::_id_5E88("hq_1v1_queue_end", "hq_1v1", var_2, ["reason", var_1]);
      self._id_6899 = undefined;
    }
  }

  if(var_1 == "accepted1v1") {
    self allowmantle(0);
    return 1;
  }

  if(isDefined(self))
    self setclientomnvar("ui_hub_1v1_queueposition", -1);

  return 0;
}

_id_5DD1(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("1v1InviteTimeout");

  for(;;) {
    self waittill("luinotifyserver", var_1, var_2);

    if(var_1 == "enter_1v1") {
      break;
    }
  }

  self notify("1v1ChoiceMade");
  var_0 notify("1v1ChoiceMade");

  if(var_2 == 1) {
    self notify("accepted1v1");
    return;
  }

  self notify("declined1v1");
}

_id_6374(var_0) {
  self endon("1v1match_ended");

  for(;;) {
    var_0 waittill("corpse_created");

    if(isDefined(var_0._id_18A8))
      self._id_2679 = common_scripts\utility::_id_0F6F(self._id_2679, var_0._id_18A8);
  }
}

_id_237C() {
  self waittill("1v1match_ended");

  foreach(var_1 in self._id_2679)
  var_1 delete();

  self._id_2679 = [];
}

getarenaprimaryweaponname(var_0) {
  var_1 = maps\mp\_utility::_id_4737(var_0._id_6B15["loadoutPrimaryWeaponStruct"]);
  var_2 = maps\mp\gametypes\_class::_id_1D66(var_1, var_0._id_6B15["loadoutPrimaryAttachmentsGUID"][0], var_0._id_6B15["loadoutPrimaryAttachmentsGUID"][1], var_0._id_6B15["loadoutPrimaryAttachmentsGUID"][2], var_0._id_6B15["loadoutPrimaryAttachmentsGUID"][3], var_0._id_6B15["loadoutPrimaryAttachmentsGUID"][4], var_0._id_6B15["loadoutPrimaryAttachmentsGUID"][5], maps\mp\_utility::_id_472D(var_0._id_6B15["loadoutPrimaryWeaponStruct"]), 0, 0, 0, 0);
  return var_2;
}

isarenaingungame(var_0) {
  return maps\mp\gametypes\onevone::ishqarenaingungame(var_0.onevone_classchoicenum);
}

getarenagungameweapons(var_0) {
  var_1 = [];

  switch (var_0.onevone_classchoicenum) {
    case 41:
      var_1 = ["mas38_mp", "volk_mp", "reich_mp"];
      break;
    case 42:
      var_1 = ["g43_mp", "kar98_mp+iron_sight_sniper", "alt+m30_mp+m30_rifle"];
      break;
    case 43:
      var_1 = ["p38_mp", "enfieldno2_mp+akimbo", "model21_mp"];
      break;
    case 44:
      var_1 = ["mg81_mp", "breda30_mp", "bren_mp+telescopic_sight_bren"];
      break;
    case 45:
      var_1 = ["panzerschreck_mp", "bazooka_mp", "c4_mp"];
      break;
  }

  return var_1;
}

getcurrentgungameweapon(var_0, var_1) {
  var_2 = getarenagungameweapons(var_0);
  var_1 = int(_min(var_1, var_2.size));
  return var_2[var_1];
}

getarenaweaponmode(var_0) {
  if(isarenaingungame(var_0))
    return 1;
  else
    return 0;
}

stream1v1weapons(var_0) {
  self endon("disconnect");
  self.hasstreamed1v1weapons = 0;

  while(!self hasloadedcustomizationplayerview(self, var_0))
    waitframe();

  self.hasstreamed1v1weapons = 1;
}

stream1v1weapon(var_0) {
  self endon("disconnect");
  stream1v1weapons([var_0]);
}

_id_7576() {
  self endon("1v1match_ended");
  level endon("game_ended");
  self._id_6B15 = undefined;
  self.onevone_classchoicenum = undefined;
  self._id_08BE = 1;

  while(self._id_252A.size < 2 && level._id_4F38._id_787F.size >= 2 - self._id_252A.size) {
    var_0 = common_scripts\utility::_id_0F82(level._id_4F38._id_787F);

    if(isDefined(var_0)) {
      thread _id_04E0::disablefocus(11, "forceCloseReadyChecks", ["1v1InviteTimeout", "1v1ChoiceMade"]);
      var_1 = var_0 _id_21C9(self);

      if(isDefined(var_1) && var_1 == 1)
        self._id_252A = common_scripts\utility::_id_0F6F(self._id_252A, var_0);

      level._id_4F38._id_787F = common_scripts\utility::_id_0F93(level._id_4F38._id_787F, var_0);
      _id_1CB0();
    }
  }

  if(self._id_252A.size != 2 || !isDefined(self._id_252A[0]) || !isDefined(self._id_252A[1])) {
    var_2 = 1;
    self._id_08BE = 0;

    foreach(var_4 in self._id_252A) {
      if(isDefined(var_4)) {
        var_5 = var_4 getentitynumber();

        if(var_5 == self.curchampclientnum)
          var_2 = 0;

        thread _id_09FB(var_4, 1);
        self._id_252A = common_scripts\utility::_id_0F93(self._id_252A, var_4);
        continue;
      }

      self._id_252A = common_scripts\utility::_id_0F93(self._id_252A, var_4);
    }

    if(var_2) {
      self.curchampclientnum = -1;
      _setomnvar("ui_one_v_one_champion_clientNum", -1);
    }

    return;
  }

  self._id_252A[0]._id_56AD = 1;
  self._id_252A[1]._id_56AD = 1;
  self._id_252A[0] _id_237B();
  self._id_252A[1] _id_237B();
  self._id_252A[0]._id_2922 = self;
  self._id_252A[1]._id_2922 = self;
  self._id_252A[0].combatantisreadyforexit = 0;
  self._id_252A[1].combatantisreadyforexit = 0;

  while(self._id_252A[0]._id_579F == 0 || self._id_252A[1]._id_579F == 0)
    waitframe();

  self._id_252A[0]._id_56AD = 0;
  self._id_252A[1]._id_56AD = 0;
  self._id_252A[0]._id_0F58 = self._id_252A[1];
  self._id_252A[1]._id_0F58 = self._id_252A[0];
  self._id_252A[0] thread _id_1713(self, 0);
  self._id_252A[1] thread _id_1713(self, 1);
  thread handle1v1timeout();
  maps\mp\gametypes\onevone::_id_92EF(self._id_252A, self);
  thread _id_6374(self._id_252A[0]);
  thread _id_6374(self._id_252A[1]);
  thread _id_237C();
  thread _id_92B7();
  thread _id_A0DB();
  thread _id_1C87();

  foreach(var_0 in level.players)
  var_0 iprintln(&"HUB_1v1_CHAT", self._id_252A[0].name, self._id_252A[1].name);
}

_id_1713(var_0, var_1) {
  thread _id_8A11(var_0);
  self _meth_85BF(1);
  self._id_2923 = 0;
  self._id_2529 = var_1;
  thread _id_9086(_id_6FB8(self, 1), var_0);
  self allowmantle(1);
  _id_04E0::_id_6010(self, self._id_0F58);
  _id_04E0::_id_4D02();
  self setclientomnvar("ui_onevone_opponent_client_num", self._id_0F58 getentitynumber());
  self _meth_8656(self._id_0F58);
  thread _id_4AA2(var_0);
  thread _id_4AA3(var_0);
  thread _id_4AA4(var_0);
}

handle1v1timeout() {
  level endon("game_ended");
  self endon("1v1match_ended");
  self._id_252A[0] endon("disconnect");
  self._id_252A[1] endon("disconnect");
  wait 90;
  _id_3E22();
}

_id_237B() {
  self endon("disconnect");
  level endon("game_ended");

  if(self._id_5692) {
    self._id_579F = 0;
    self notify("forceSurrenderDuel");
    self._id_8B93 = 1;
    return;
  } else if(self._id_572B) {
    self._id_579F = 0;
    self._id_1388 = 1;
    self notify("force_cancel_placement");
    self notify("autoFinishSupplyDrop");
    return;
  } else if(self._id_5721) {
    if(self._id_572F)
      self._id_8C8F = 1;

    _id_04DB::_id_38F2();
    return;
  } else if(isDefined(self._id_A405) || isDefined(self._id_5CC4)) {
    var_0 = common_scripts\utility::_id_98E7(isDefined(self._id_A405), self._id_A405, self._id_5CC4);
    _id_04E1::_id_741D(var_0);
    return;
  } else if(!maps\mp\_utility::isreallyalive(self)) {
    self waittill("spawned");
    return;
  } else if(self._id_5722) {
    foreach(var_2 in level._id_0813) {
      var_3 = var_2 getturretowner();

      if(isDefined(var_3) && var_3 == self) {
        var_3 setclientomnvar("ui_hub_in_flakgun", 0);
        self remotecontrolturretoff(var_2);
        waitframe();
        return;
      }
    }
  } else if(self._id_57E0)
    self notify("forceLeave1v1Spectate");
  else if(self._id_56A4) {
    if(isDefined(self._id_155F))
      self._id_155F _id_04E0::_id_1543((0, 0, 80), self);
  } else if(common_scripts\utility::_id_562E(self.isintimertag))
    _id_04DC::cleanupfailedtimertag(1);
}

_id_8A11(var_0) {
  self endon("disconnect");
  var_0 endon("1v1match_ended");
  self._id_572A = 1;
  _id_04E0::_id_870B(1);
  self._id_542B = 0;
  self.post1v1 = undefined;
  self setclientomnvar("ui_hide_1v1scores", 0);
  self setclientomnvar("ui_hub_in_1v1", 1);
  self setclientomnvar("ui_party_manipulation_enabled", 0);
  self allowprone(1);
  self allowmelee(1);
  self setcandamage(1);
  self _meth_85C8();
  _id_04E0::_id_2FA2();
  self disableweaponswitch();
  self takeallweapons();
  self _meth_85BE(1);
  self _meth_85B4();
  self _meth_84B9(1);
  self.health = self.maxhealth;
  self setclientomnvar("ui_hub_1v1_queueposition", -1);

  foreach(var_2 in self._id_4E03) {
    if(isDefined(var_2))
      self _meth_85CD(self._id_746C);
  }

  _id_04E0::_id_7D1D(1);
  _id_04E0::_id_7D1E(0);
  var_4 = "";
  var_5 = 0;

  if(!isDefined(var_0._id_6B15) && !isDefined(var_0.onevone_classchoicenum)) {
    maps\mp\_utility::freezecontrolswrapper(1);
    var_0 waittill("onevoneClassCreated");

    if(isarenaingungame(var_0)) {
      var_6 = getarenagungameweapons(var_0);
      thread stream1v1weapons(var_6);
      var_4 = getcurrentgungameweapon(var_0, self._id_2923);
      var_5 = 1;

      if(maps\mp\gametypes\_class::_id_5826(var_4, 0)) {
        self setlethalweapon(var_4);
        self giveweapon(var_4);
        var_4 = "shovel_mp";
      }
    } else {
      var_4 = getarenaprimaryweaponname(var_0);
      thread stream1v1weapon(var_4);
    }

    while(!self.hasstreamed1v1weapons)
      waitframe();

    maps\mp\_utility::freezecontrolswrapper(0);
  } else if(isarenaingungame(var_0)) {
    var_4 = getcurrentgungameweapon(var_0, self._id_2923);
    var_5 = 1;

    if(maps\mp\gametypes\_class::_id_5826(var_4, 0)) {
      self setlethalweapon(var_4);
      self giveweapon(var_4);
      var_4 = "shovel_mp";
    }
  } else
    var_4 = getarenaprimaryweaponname(var_0);

  self setclientomnvar("ui_hub_in_1v1", getarenaweaponmode(var_0) + 1);

  if(isDefined(var_0._id_6B15)) {
    if(var_0._id_6B15["loadoutEquipmentStruct"].guid != 0) {
      var_7 = maps\mp\_utility::_id_44CD(var_0._id_6B15["loadoutEquipmentStruct"]);
      self setlethalweapon(var_7);
      self giveweapon(var_7);
    }

    if(var_0._id_6B15["loadoutOffhandStruct"].guid != 0) {
      var_8 = maps\mp\_utility::_id_44CD(var_0._id_6B15["loadoutOffhandStruct"]);
      self setoffhandsecondaryclass(var_8);
      self giveweapon(var_8);
    }
  }

  self enableweaponswitch();

  if(isDefined(var_0.onevone_classchoicenum) && var_0.onevone_classchoicenum == 42)
    self _meth_8328();

  maps\mp\_utility::giveperk("specialty_marksmanvision");
  maps\mp\_utility::giveperk("specialty_improvedholdbreath");
  maps\mp\_utility::_giveweapon(var_4);

  if(isarenaingungame(var_0))
    self.current1v1weaponmode = 1;
  else
    self.current1v1weaponmode = 0;

  self allowfire(1);
  thread _id_04DB::_id_47A9(var_5, 1);

  if(isDefined(self._id_9A9A))
    self._id_9A9A.alpha = 0;

  thread makesureweaponswitches(var_4, var_0);
}

makesureweaponswitches(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  var_1 endon("1v1match_ended");
  waitframe();

  for(;;) {
    self switchtoweaponimmediate(var_0);
    wait 0.3;

    if(self getcurrentweapon() == var_0) {
      break;
    }
  }
}

_id_77C0(var_0, var_1, var_2) {
  var_3 = var_0;
  var_4 = var_1;
  var_5 = &"HUB_1V1_RESULT_TIED";

  if(var_2 == "win" || var_2 == "loss") {
    var_5 = &"HUB_1V1_RESULT_WINNER";

    if(var_2 == "loss") {
      var_3 = var_1;
      var_4 = var_0;
    }
  }

  foreach(var_7 in level.players)
  var_7 iprintln(var_5, var_3, var_4);
}

_id_4AA2(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 endon("1v1match_ended");

  for(;;) {
    self waittill("death", var_1, var_2, var_3);
    childthread _id_6362(var_0);

    if(isDefined(var_1) && isDefined(var_1._id_572A) && var_1._id_572A && self._id_572A) {
      if(isarenaingungame(var_0)) {
        if(maps\mp\_utility::_id_5755(var_2))
          self._id_2923 = max(0, self._id_2923 - 1);
        else if(self != var_1) {
          var_1._id_2923 = var_1._id_2923 + 1;

          if(var_1._id_2923 < 3) {
            var_4 = getcurrentgungameweapon(var_0, var_1._id_2923);
            var_1 takeallweapons();

            if(maps\mp\gametypes\_class::_id_5826(var_4, 0)) {
              var_1 setlethalweapon(var_4);
              var_1 giveweapon(var_4);
              var_4 = "shovel_mp";
            }

            var_1 maps\mp\_utility::_giveweapon(var_4);
            var_1 makesureweaponswitches(var_4, var_0);
          }
        } else
          self._id_2923 = max(0, self._id_2923 - 1);
      } else if(self != var_1)
        var_1._id_2923 = var_1._id_2923 + 1;
      else if(self._id_2923 != 0)
        self._id_2923 = self._id_2923 - 1;

      var_0 thread _id_A0DB();
      var_0 thread _id_1C87();

      if(var_1._id_2923 >= 3) {
        self allowmantle(0);
        self._id_5B8F = self.origin;
        _id_77C0(self.name, var_1.name, "loss");
        thread _id_4AA8("loss", var_0);

        if(self._id_2923 == 0)
          var_1 thread _id_4AA8("win", var_0, 1);
        else
          var_1 thread _id_4AA8("win", var_0);

        return;
      }
    }
  }
}

_id_4AA3(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 endon("1v1match_ended");
  var_0 endon("1v1_begin_exit");

  for(;;) {
    self waittill("luinotifyserver", var_1, var_2);

    if(var_1 == "hub_leave_activity") {
      thread _id_4AA6(var_0);
      return;
    }
  }
}

_id_4AA4(var_0) {
  level endon("game_ended");
  var_0 endon("1v1match_ended");
  var_0 endon("1v1_begin_exit");
  self waittill("disconnect");

  if(!isDefined(self)) {
    var_0 thread _id_3E22();
    return;
  }

  self.combatantisreadyforexit = 1;
  thread _id_4AA6(var_0);
}

_id_4AA6(var_0) {
  var_0 notify("1v1_begin_exit");
  self allowmantle(0);

  if(var_0._id_252A[0] == self) {
    _id_77C0(var_0._id_252A[0].name, var_0._id_252A[1].name, "loss");

    if(isDefined(var_0._id_252A[0]))
      var_0._id_252A[0] thread _id_4AA8("loss", var_0, undefined, 1);

    if(isDefined(var_0._id_252A[1]))
      var_0._id_252A[1] thread _id_4AA8("win", var_0, undefined, 1);
  } else {
    _id_77C0(var_0._id_252A[0].name, var_0._id_252A[1].name, "win");

    if(isDefined(var_0._id_252A[0]))
      var_0._id_252A[0] thread _id_4AA8("win", var_0, undefined, 1);

    if(isDefined(var_0._id_252A[1]))
      var_0._id_252A[1] thread _id_4AA8("loss", var_0, undefined, 1);
  }
}

_id_6362(var_0) {
  self waittill("spawned");
  var_0._id_252A[0] _id_04E0::_id_7D1D(1);
  var_0._id_252A[1] _id_04E0::_id_7D1D(1);
  var_0._id_252A[0] _meth_8656(var_0._id_252A[1]);
  var_0._id_252A[1] _meth_8656(var_0._id_252A[0]);
}

_id_4AA8(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  level endon("level_ended");

  if(isDefined(self.post1v1)) {
    return;
  }
  self.post1v1 = 1;

  if(var_0 == "win") {
    if(!isDefined(level._id_66A3))
      level._id_66A3 = 0;
    else {
      level._id_66A3++;

      if(level._id_66A3 >= level._id_4F38._id_AA45.size)
        level._id_66A3 = 0;
    }
  } else if(var_0 == "loss") {
    if(!isDefined(level._id_66A2))
      level._id_66A2 = 0;
    else {
      level._id_66A2++;

      if(level._id_66A2 >= level._id_4F38._id_5F1A.size)
        level._id_66A2 = 0;
    }
  } else if(var_0 == "tie") {
    if(!isDefined(level._id_66A2))
      level._id_66A2 = 0;
    else {
      level._id_66A2++;

      if(level._id_66A2 >= level._id_4F38._id_5F1A.size)
        level._id_66A2 = 0;
    }
  }

  var_4 = common_scripts\utility::random(level._id_4F38._id_7A48);

  switch (var_0) {
    case "win":
      if(isDefined(var_3) && var_3) {
        if(isDefined(self.previousforfeitopponents)) {
          var_5 = 0;

          foreach(var_7 in self.previousforfeitopponents) {
            if(isDefined(var_7) && var_7 == self._id_0F58._id_01D6) {
              var_5 = 1;
              break;
            }
          }

          if(var_5) {
            var_4 = level._id_4F38._id_AA45[level._id_66A3];
            break;
          }
        } else
          self.previousforfeitopponents = [];

        self.previousforfeitopponents = common_scripts\utility::_id_0F6F(self.previousforfeitopponents, self._id_0F58._id_01D6);
      }

      thread maps\mp\gametypes\_missions::_id_7752("ch_daily_2");
      thread maps\mp\gametypes\_missions::processchallenge("ch_hq_1v1");
      var_9 = self getplayerdata(common_scripts\utility::_id_46AB(), "hubStats", "num1v1Wins") + 1;
      self setplayerdata(common_scripts\utility::_id_46AB(), "hubStats", "num1v1Wins", var_9);
      _id_04E0::isusingoffhand(["hubFeatureStats", "hub1v1", "numHub1v1Wins"], var_9);
      _id_04E0::pushplayervector("numHub1v1Wins", "hub1v1", 1, undefined, undefined);
      var_4 = level._id_4F38._id_AA45[level._id_66A3];

      if(isDefined(var_2) && var_2)
        _id_0468::_id_0A1C("win", self._id_0F58._id_01D6, 1);
      else
        _id_0468::_id_0A1C("win", self._id_0F58._id_01D6);

      break;
    case "loss":
      var_9 = self getplayerdata(common_scripts\utility::_id_46AB(), "hubStats", "num1v1Losses") + 1;
      self setplayerdata(common_scripts\utility::_id_46AB(), "hubStats", "num1v1Losses", var_9);
      _id_04E0::isusingoffhand(["hubFeatureStats", "hub1v1", "numHub1v1Losses"], var_9);
      _id_0468::_id_0A1C("lose", self._id_0F58._id_01D6);
      _id_04E0::pushplayervector("numHub1v1Losses", "hub1v1", 1, undefined, undefined);
      var_4 = level._id_4F38._id_5F1A[level._id_66A2];
      break;
    case "tie":
      var_4 = level._id_4F38._id_5F1A[level._id_66A2];
      _id_0468::_id_0A1C("tie", self._id_0F58._id_01D6);
      break;
    default:
      var_4 = common_scripts\utility::random(level._id_4F38._id_7A48);
      break;
  }

  self _meth_85EF(&"wrap_up_1v1", 0);
  _id_04E0::_id_A03C(self, self._id_0F58);
  var_10 = var_1._id_9A04;

  if(var_10 > 60)
    var_10 = 60;

  if(!isDefined(var_3) || !var_3) {
    _id_04E0::_id_5E88("hq_1v1_match", "hq_1v1", var_10, ["match_id", 0, "kills", self._id_2923, "winloss", var_0]);
    var_9 = self getplayerdata(common_scripts\utility::_id_46AB(), "hubStats", "num1v1Matches") + 1;
    self setplayerdata(common_scripts\utility::_id_46AB(), "hubStats", "num1v1Matches", var_9);
    _id_04E0::isusingoffhand(["hubFeatureStats", "hub1v1", "numHub1v1Matches"], var_9);
  }

  _id_04E0::pushplayervector("numHub1v1Matches", "hub1v1", 1, var_10, undefined);
  _id_4AA5(var_0, var_1);
  _id_38EE(var_4);

  if(var_1._id_08BE) {
    var_1._id_252A = [];
    var_1._id_08BE = 0;
    var_1 notify("1v1match_ended");
  }

  self setclientomnvar("ui_onevone_opponent_client_num", -1);

  if(var_0 == "win") {
    var_1.curchampclientnum = self getentitynumber();
    _setomnvar("ui_one_v_one_champion_clientNum", var_1.curchampclientnum);
    thread _id_09FB(self, 1);
  } else if(var_0 == "tie")
    thread _id_21E0();
}

_id_4AA5(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");

  while(!maps\mp\_utility::isreallyalive(self))
    waitframe();

  self setdemigod(1);
  var_2 = [];
  var_2["win"] = 1;
  var_2["loss"] = -1;
  var_2["draw"] = 0;
  self _meth_866C(&"ui_end_hub_1v1", 5, self._id_2923, self._id_0F58._id_2923, self getentitynumber(), self._id_0F58 getentitynumber(), var_2[var_0]);
  self _meth_8546(0);
  self allowjump(0);
  self allowcrouch(0);
  self allowprone(0);
  self _meth_85BF(0);
  self allowmantle(0);
  waitframe();
  _id_04E0::_id_7446();
  _id_04E0::_id_3663();
  self._id_542B = 1;
  self _meth_85C7();

  switch (var_0) {
    case "win":
      thread _id_75DE("win", var_1);
      break;
    case "loss":
      self dontinterpolate();

      if(isDefined(self._id_5B8F))
        _id_04E0::_id_8698(self._id_5B8F);

      thread _id_75DE("loss", var_1);
      break;
    case "tie":
      if(self._id_2529 == 1) {} else {}

      thread _id_75DE("tie", var_1);
      break;
    default:
      break;
  }

  while(isDefined(var_1._id_252A[0]) && !var_1._id_252A[0].combatantisreadyforexit || isDefined(var_1._id_252A[1]) && !var_1._id_252A[1].combatantisreadyforexit)
    waitframe();

  self _meth_8546(1);
  self allowjump(1);
  self allowcrouch(1);
  self allowprone(1);
  self setdemigod(0);
  self notify("cancelEmoteGodMode");
}

_id_237A() {
  self endon("disconnect");
  waitframe();

  if(!isDefined(self)) {
    return;
  }
  self notify("1v1_ended");
  self setclientomnvar("ui_hide_1v1scores", 1);
  self setclientomnvar("ui_hub_in_1v1", 0);
  self setclientomnvar("ui_party_manipulation_enabled", 1);
  self _meth_85EF(&"end_hub_1v1", 0);
  _id_1C86();
  self._id_2923 = 0;
  self.current1v1weaponmode = undefined;
  self.health = self.maxhealth;
  self _meth_8656(undefined);
  self _meth_84B9(0);
  self.post1v1 = undefined;

  foreach(var_1 in level._id_61ED) {
    if(isDefined(var_1) && isDefined(var_1._id_0117) && var_1._id_0117 == self)
      var_1 delete();
  }

  _id_04E0::_id_8BEB();
  self._id_572A = 0;
  _id_04E0::_id_870B(0);
  self allowprone(0);
  self allowfire(0);
  maps\mp\_utility::freezecontrolswrapper(0);
  self _meth_85BE(0);
  self allowmelee(0);
  self allowmantle(1);
  self._id_1388 = 0;

  if(isDefined(self._id_9A9A))
    self._id_9A9A.alpha = 1;

  _id_04E0::_id_7E4E(1);
  _id_04E0::_id_7E4F(0);
  waitframe();
  self switchtoweaponimmediate("emote_weapon_mp");
}

_id_9086(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = var_1._id_0F59[0];

  var_1._id_252A[0] _id_04E0::_id_7D1D(1);
  var_1._id_252A[1] _id_04E0::_id_7D1D(1);
  self setOrigin(_droptoground(var_0.origin), 1);
  self setplayerangles(var_0.angles);
}

_id_92B7() {
  level endon("game_ended");
  self endon("1v1match_ended");
  self._id_252A[0] endon("disconnect");
  self._id_252A[1] endon("disconnect");
  self._id_9A04 = 0;
  _setomnvar("ui_hub_1v1_timer", gettime() + 60000);
  self._id_252A[0] _meth_85EF(&"begin_hub_1v1", 0);
  self._id_252A[1] _meth_85EF(&"begin_hub_1v1", 0);

  for(;;) {
    wait 1;
    self._id_9A04++;

    if(self._id_9A04 >= 60) {
      if(self._id_252A[0]._id_2923 > self._id_252A[1]._id_2923) {
        var_0 = "win";
        var_1 = "loss";
      } else if(self._id_252A[0]._id_2923 < self._id_252A[1]._id_2923) {
        var_1 = "win";
        var_0 = "loss";
      } else {
        var_0 = "tie";
        var_1 = "tie";
      }

      _id_77C0(self._id_252A[0].name, self._id_252A[1].name, var_0);
      self._id_252A[0] thread _id_4AA8(var_0, self);
      self._id_252A[1] thread _id_4AA8(var_1, self);
      return;
    }
  }
}

_id_A0DB() {
  _id_A0F7(self._id_252A[0], self._id_252A[1]);
  _id_A0F7(self._id_252A[1], self._id_252A[0]);
}

_id_1C87() {
  var_0 = self._id_252A[0];
  var_1 = self._id_252A[1];

  foreach(var_3 in level.players) {
    if(var_3 == var_0 || var_3 == var_1) {
      continue;
    }
    if(!isDefined(var_0._id_2923))
      var_0._id_2923 = 0;

    if(!isDefined(var_1._id_2923))
      var_1._id_2923 = 0;

    var_3 _meth_866C(&"update_hub_1v1_current_score", 4, var_0._id_2923, var_1._id_2923, var_0.name, var_1.name);
  }
}

_id_1C86() {
  foreach(var_1 in level.players)
  var_1 _meth_866C(&"clean_hub_1v1_score", 0);
}

_id_A0F7(var_0, var_1) {
  if(!isDefined(var_0._id_2923))
    var_0._id_2923 = 0;

  if(!isDefined(var_1._id_2923))
    var_1._id_2923 = 0;

  var_2 = 210;
  var_0 _meth_866C(&"update_hub_1v1", 2, var_0._id_2923, var_1._id_2923);
}

_id_3E22() {
  var_0 = 0;

  foreach(var_2 in self._id_252A) {
    if(isDefined(var_2)) {
      var_2 _id_04E0::_id_7446();
      var_2 _id_04E0::_id_3663();
      var_2._id_542B = 1;
      var_2 _meth_85C7();
      var_2 _id_38EE(level._id_4F38._id_7A48[var_0]);

      foreach(var_4 in level._id_61ED) {
        if(isDefined(var_4) && isDefined(var_4._id_0117) && var_4._id_0117 == var_2)
          var_4 delete();
      }
    }

    var_0++;
  }

  foreach(var_4 in level._id_61ED) {
    if(isDefined(var_4) && !isDefined(var_4._id_0117))
      var_4 delete();
  }

  self._id_252A = [];
  self._id_08BE = 0;
  self notify("1v1match_ended");
  _id_21E0();
}

_id_38EE(var_0) {
  self endon("disconnect");

  if(!isDefined(self)) {
    return;
  }
  _id_04E0::_id_8698(var_0.origin);
  self setplayerangles(var_0.angles);
  self _meth_801C();
  _id_237A();
}

_id_6FB8(var_0, var_1) {
  if(var_0._id_2922._id_252A.size == 2) {
    var_2 = [];

    if(var_0 == var_0._id_2922._id_252A[0]) {
      if(isDefined(var_1) && var_1)
        return common_scripts\utility::random(var_0._id_2922._id_180D);

      var_2 = _sortbydistance(var_0._id_2922._id_0F59, var_0._id_2922._id_252A[1].origin, 3000);
    } else if(var_0 == var_0._id_2922._id_252A[1]) {
      if(isDefined(var_1) && var_1)
        return common_scripts\utility::random(var_0._id_2922._id_7B72);

      var_2 = _sortbydistance(var_0._id_2922._id_0F59, var_0._id_2922._id_252A[0].origin, 3000);
    }

    if(var_2.size < 1)
      return var_0._id_2922._id_0F59[0];

    if(var_2[0]._id_0165 == "blue")
      return common_scripts\utility::random(var_0._id_2922._id_7B72);
    else
      return common_scripts\utility::random(var_0._id_2922._id_180D);
  }

  return common_scripts\utility::random(var_0._id_2922._id_0F59);
}

_id_75DE(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  wait 0.5;

  switch (var_0) {
    case "win":
      self._id_258D++;

      if(self getplayerdata(common_scripts\utility::_id_46AB(), "hubStats", "longest1v1WinStreak") < self._id_258D) {
        self setplayerdata(common_scripts\utility::_id_46AA(), "hubFeatureStats", "hub1v1", "longestHub1v1WinStreak", self._id_258D);
        self setplayerdata(common_scripts\utility::_id_46AB(), "hubStats", "longest1v1WinStreak", self._id_258D);
      }

      _id_04E0::_id_721A("mp_emote_cheer_yeah");
      wait 3.03333;
      self notify("post1v1EmoteComplete");
      self.combatantisreadyforexit = 1;
      break;
    case "loss":
      _id_04E0::_id_721A("mp_emote_defeated_c");
      wait 4.36667;
      self notify("post1v1EmoteComplete");
      self.combatantisreadyforexit = 1;
      break;
    case "tie":
      if(self._id_2529 == 1) {
        wait 1;
        self notify("post1v1EmoteComplete");
        self.combatantisreadyforexit = 1;
      } else {
        wait 1;
        self notify("post1v1EmoteComplete");
        self.combatantisreadyforexit = 1;
      }

      break;
    default:
      break;
  }
}

_id_35AC() {
  level endon("game_ended");
  level._id_6B2B = _getent("trigger_onevone", "targetname");

  if(!isDefined(level._id_6B2B)) {
    return;
  }
  for(;;) {
    level._id_6B2B waittill("trigger", var_0);
    var_1 = 0;

    if(isDefined(var_0) && isPlayer(var_0)) {
      foreach(var_3 in level._id_4F38._id_252A) {
        if(var_3 == var_0)
          var_1 = 1;
      }

      if(!var_1) {
        var_5 = common_scripts\utility::random(level._id_4F38._id_7A48);
        var_0 _id_04E0::_id_8698(var_5.origin);
        var_0 setplayerangles(var_5.angles);
      }
    }
  }
}

_id_7475() {
  self notifyonplayercommand("exitSpectateCam", "+stance");
  self cameralinkto(level._id_90E0, "tag_player");
  self setclientdvar("cg_fov", 85);
  _id_04E0::_id_73E5(1);
  self._id_57E0 = 1;
  _id_04E0::_id_870B(1);
  common_scripts\utility::waittill_any_return("exitSpectateCam", "forceLeave1v1Spectate");
  _id_04E0::_id_73E5(0);
  self notifyonplayercommandremove("exitSpectateCam", "+stance");
  self cameraunlink();
  self setclientdvar("cg_fov", level._id_4F4A);
  self._id_57E0 = 0;
  _id_04E0::_id_870B(0);
}
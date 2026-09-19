/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1241.gsc
**************************************/

_id_4F3E() {
  if(getdvarint("233") == 1) {
    return;
  }
  _id_04E0::_id_4F43();
  _id_04E0::removeunusedpatchclip();
  level._id_75DF = ::_id_6B85;
  level._id_A592 = ::_id_6BA6;
  level._id_A5A0 = ::_id_A596;
  level._id_A7A2 = _id_04E0::_id_4F45;

  if(getdvarint("3645", 0) == 1)
    level._id_13AC = ::_id_13AB;

  level._id_1728 = 65;
  level._id_1726 = 356;
  level._id_1727 = 18;
  level._id_3EF2 = 65;
  level._id_3EF0 = 180;
  level._id_3EF1 = 3;
  level._id_2BC8 = getdvarfloat("3380");
  level._id_2BC7 = getdvarfloat("1920");
  level._id_ACCA = 1.54;
  level._id_ACC9 = 62.5;
  level._id_2BC6 = (10, -25, 65);
  level._id_2746 = (-25, -50, 60);
  level._effect["level_up"] = loadfx("vfx/level_up/level_up_flag");
  level._effect["prestige_lensflare"] = loadfx("vfx/level_up/prestige_lensflare");
  level._effect["prestige_flag_1"] = loadfx("vfx/level_up/prestige_flag_1");
  level._effect["prestige_flag_2"] = loadfx("vfx/level_up/prestige_flag_2");
  level._effect["prestige_flag_3"] = loadfx("vfx/level_up/prestige_flag_3");
  level._effect["prestige_flag_4"] = loadfx("vfx/level_up/prestige_flag_4");
  level._effect["prestige_flag_5"] = loadfx("vfx/level_up/prestige_flag_5");
  level._effect["prestige_flag_6"] = loadfx("vfx/level_up/prestige_flag_6");
  level._effect["prestige_flag_7"] = loadfx("vfx/level_up/prestige_flag_7");
  level._effect["prestige_flag_8"] = loadfx("vfx/level_up/prestige_flag_8");
  level._effect["prestige_flag_9"] = loadfx("vfx/level_up/prestige_flag_9");
  level._effect["prestige_flag_10"] = loadfx("vfx/level_up/prestige_flag_10");
  level._effect["prestige_icon_1"] = loadfx("vfx/level_up/prestige_icon_vfx/prestige_level_1_icon");
  level._effect["prestige_icon_2"] = loadfx("vfx/level_up/prestige_icon_vfx/prestige_level_2_icon");
  level._effect["prestige_icon_3"] = loadfx("vfx/level_up/prestige_icon_vfx/prestige_level_3_icon");
  level._effect["prestige_icon_4"] = loadfx("vfx/level_up/prestige_icon_vfx/prestige_level_4_icon");
  level._effect["prestige_icon_5"] = loadfx("vfx/level_up/prestige_icon_vfx/prestige_level_5_icon");
  level._effect["prestige_icon_6"] = loadfx("vfx/level_up/prestige_icon_vfx/prestige_level_6_icon");
  level._effect["prestige_icon_7"] = loadfx("vfx/level_up/prestige_icon_vfx/prestige_level_7_icon");
  level._effect["prestige_icon_8"] = loadfx("vfx/level_up/prestige_icon_vfx/prestige_level_8_icon");
  level._effect["prestige_icon_9"] = loadfx("vfx/level_up/prestige_icon_vfx/prestige_level_9_icon");
  level._effect["prestige_icon_10"] = loadfx("vfx/level_up/prestige_icon_vfx/prestige_level_10_icon");
  level._effect["prestige_icon_11"] = loadfx("vfx/level_up/prestige_icon_vfx/prestige_level_11_icon");
  level._effect["hub_granadier_tag_effect"] = loadfx("vfx/map/mp_hub/hub_granadier_tag_effect");
  level._id_4F50 = 0;
  level._id_2D6D = _id_04DC::_id_2D6D;
  setdvarifuninitialized("hub_noPSDPlayerLock", 0);
  setdvarifuninitialized("hub_emote", "mp_emote_salute");
  setdvarifuninitialized("hub_setThirdPerson", 1);
  setdvarifuninitialized("spv_hub_firingrange_kswitch", 1);
  setdvarifuninitialized("spv_hub_vendors_kswitch", 1);
  setdvarifuninitialized("spv_hub_1v1_kswitch", 1);
  setdvarifuninitialized("spv_hub_dueling_kswitch", 1);
  setdvarifuninitialized("spv_hub_psd_kswitch", 1);
  setdvarifuninitialized("spv_hub_planes_kswitch", 1);
  setdvarifuninitialized("spv_hub_quickchat_kswitch", 1);
  setdvarifuninitialized("spv_hub_zombiesVendor_kswitch", 1);
  setdvarifuninitialized("spv_hub_raidsVendor_kswitch", 1);
  setdvarifuninitialized("spv_hub_requisitionsVendor_kswitch", 1);
  setdvarifuninitialized("spv_hub_quartermasterVendor_kswitch", 1);
  setdvarifuninitialized("spv_hub_prestigeVendor_kswitch", 1);
  setdvarifuninitialized("spv_hub_scorestreakVendor_kswitch", 1);
  setdvarifuninitialized("spv_hub_gunsmithVendor_kswitch", 1);
  setdvarifuninitialized("spv_hub_payrollVendor_kswitch", 1);
  setdvarifuninitialized("spv_hub_theater_kswitch", 1);
  setdvarifuninitialized("spv_hub_winter_event_enabled", 0);
  setdvarifuninitialized("spv_hub_timer_tag_kswitch", 1);
  setdvarifuninitialized("spv_hub_prestigeAEFailsafes_kswitch", 1);
  setdvarifuninitialized("spv_hub_rankAEIrregularityLogging_kswitch", 1);
  setdvarifuninitialized("spv_hub_masterPrestigeDrops_kswitch", 0);
  setdvarifuninitialized("spv_hub_1v1_weapon_mode", 0);
  setdvarifuninitialized("spv_supplydrop_timeout", 15);
  setdvarifuninitialized("spv_hub_riotshield_kswitch", 0);
  setdvarifuninitialized("hub_cam_preset_1", 1);
  setdvarifuninitialized("hub_cam_preset_2", 0);
  setdvarifuninitialized("hub_cam_preset_3", 0);
  setdvarifuninitialized("hub_cam_preset_4", 0);
  setdvarifuninitialized("hub_cam_preset_5", 0);
  setdvarifuninitialized("hub_cameraAdjustMode", 0);
  thread _id_04E0::_id_636B();
  setDvar("250", 1);
  setDvar("5679", 1);
  setDvar("3386", 1);
  setDvar("2903", 0);
  setDvar("31", 0.8);
  thread _id_4F3F();

  if(!level._id_A220)
    _id_A598();
  else
    _id_669F();

  level._id_4F49 = ["ch_daily_2", "ch_daily_3", "ch_daily_4", "ch_daily_5"];
}

waitfor_loadmain() {
  while(!isDefined(level._id_947C))
    waitframe();
}

_id_4F3F() {
  level._id_5E0C = 0;
  _id_04E0::_id_4F45("mp_hub_range_2_tr");
  _id_4F40();

  if(_func_3AE() == 0 && !common_scripts\utility::_id_562E(level._id_AC5A)) {
    waitfor_loadmain();
    level._id_5E0C = 1;
    _id_04E0::_id_4F45("mp_hub_spawn_5_tr");
    _id_4F41();
    level._id_5E0C = 2;
    _id_04E0::_id_4F45("mp_hub_main_2_tr");
    _id_4F42();
  }
}

_id_4F40() {
  thread _id_04DB::_id_52B9();
  _id_87B2();
}

_id_4F41() {
  _id_04DD::init();
  thread _id_04E1::init();
  thread _id_04E0::_id_532E();
  thread _id_89D4();
}

_id_4F42() {
  thread _id_0482::init();

  if(!getdvarint("1258", 0))
    thread _id_04D8::_id_85BE();
}

_id_87B2() {
  level._id_5A61 = [];
  maps\mp\gametypes\_missions::_id_1D41();
  level._id_47EE = ["SHG-BParker"];
}

_id_89D4() {
  level._id_9956 = [];

  foreach(var_1 in getEntArray("interactive_chair_trigger", "targetname")) {
    var_1 thread _id_0478::_id_9DC3(::_id_37B9, ::_id_38EF);
    level._id_9956[level._id_9956.size] = var_1;
  }
}

_id_37B9(var_0) {
  if(!isDefined(var_0._id_745E))
    var_0._id_745E = 0;

  var_0._id_745E++;
}

_id_38EF(var_0) {
  var_0._id_745E--;
}

_id_63F3() {
  wait 5;

  for(;;) {
    var_0 = 0;
    var_1 = [];

    if(isDefined(level._id_A012)) {
      foreach(var_3 in level._id_A012._id_21F6) {
        if(isDefined(var_3)) {
          var_1 = common_scripts\utility::_id_0F6F(var_1, var_3);
          var_0++;
        }
      }
    }

    level._id_687C = var_0;
    level._id_0FBE = var_1;
    wait 1;
  }
}

_id_5302() {
  if(common_scripts\utility::_id_562E(self._id_4F3D)) {
    return;
  }
  self._id_4F3D = 1;
  var_0 = _func_3AE() != 0 || common_scripts\utility::_id_562E(level._id_AC5A);
  var_1 = !_func_3B0();
  var_2 = "hq";

  if(common_scripts\utility::_id_562E(level._id_AC5A))
    var_2 = "zm";
  else if(_func_3AE() != 0)
    var_2 = "vl";

  thread _id_0468::_id_0A1B();
  _id_A125();
  self._id_4F4C = _func_03E();
  var_3 = self getplayerdata(common_scripts\utility::_id_46AA(), "hubLifetimeStats", "lifetimeHubSessions") + 1;
  self setplayerdata(common_scripts\utility::_id_46AA(), "hubLifetimeStats", "lifetimeHubSessions", var_3);
  self setplayerdata(common_scripts\utility::_id_46AB(), "hubStats", "lifetimeSessions", var_3);
  _func_0F5("script_mp_hub_event: game_time %d, player_name %s, player_id %d, event_category %s, event_name %s, event_value_int %d, event_value_float %f, event_value_string %s, player_count %d", gettime(), self.name, self.clientid, "hub_session_info", "entered_hub", 1, -1.0, "NA", level.players.size);
  _id_04E0::_id_5E88("join", "hq_session_info", 0, ["join_type", var_2]);
  _id_04E0::_id_531B();
  maps\mp\gametypes\_missions::updatechalleges();
  thread _id_75D7();

  if(!common_scripts\utility::_id_562E(level._id_AC5A) && _func_3AE() == 0)
    thread _id_63B7();

  thread _id_0468::_id_2565();
  thread _id_A77F();
}

_id_A77F() {
  self endon("disconnect");
  self waittill("spawned_player");
  self _meth_85EF(&"hub_fade_in");
  thread afktimer();

  if(getdvarint("spv_hub_special_qm", 0) == 1)
    _func_213(15, self);
}

afktimer() {
  level endon("game_ended");
  self endon("disconnect");
  setdvarifuninitialized("spv_hub_afk_timeout", -1);
  var_0 = 5;

  for(;;) {
    while(getdvarint("spv_hub_afk_timeout", 300) < 0)
      wait(var_0);

    var_1 = getdvarint("spv_hub_afk_timeout", 300);
    var_2 = var_1 / var_0;

    while(var_1 == getdvarint("spv_hub_afk_timeout", 300)) {
      wait 1;
      var_3 = 1;
      var_4 = undefined;

      for(var_5 = 0; var_5 < var_2; var_5++) {
        if(!isDefined(var_4))
          var_4 = self.origin;

        if(var_4 == self.origin && self _meth_844A("ui_hub_is_preoccupied") == 0 && self._id_537B == 0) {
          wait(var_0);
          continue;
        }

        var_3 = 0;
        break;
      }

      if(var_3)
        _func_134(self getentitynumber(), "EXE_PLAYERKICKED_INACTIVE");
    }
  }
}

_id_715F() {
  _func_290(self, "mp/fte_capture", 1, 0);
}

_id_52A1() {
  if(_func_367() && !isDefined(self._id_5520)) {
    if(level._id_A220) {
      thread _id_04E2::_id_636A(self);
      thread _id_04E2::_id_62F5();
    } else
      thread maps\mp\hub_vl_camera::_id_6BA9();

    self._id_5520 = 1;
  }

  setDvar("5666", "1");
}

_id_13AB(var_0) {
  var_1 = ["headquarters_npc", "blacksmith_npc", "raid_npc", "mail_npc", "zombie_npc", "playlist_npc", "general_npc", "commander_npc", "scorestreak_training_npc", "1v1_npc", "quartermaster_npc"];
  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = common_scripts\utility::_id_44BD(var_4, "targetname");
    var_2[var_2.size] = var_5;
  }

  var_2 = common_scripts\utility::_id_0F73(var_2, _id_050D::_id_46A0());
  var_7 = var_0 getentitynumber();
  var_7 = (var_7 + randomint(5)) % var_2.size;
  return var_2[var_7];
}

_id_A596(var_0) {
  var_1 = level._id_3C3F[0];

  if(!isDefined(var_1)) {
    var_2 = common_scripts\utility::_id_46B7("hub_lobby_avatar_spawn", "script_noteworthy");
    var_1 = var_2[0];
  }

  var_0 _meth_805C();
  return var_1;
}

_id_6B85() {
  var_0 = _func_3AE() != 0 || common_scripts\utility::_id_562E(level._id_AC5A);
  var_1 = !_func_3B0();
  setDvar("2766", level._id_1728);
  setDvar("3711", level._id_1727);
  self _meth_82FF("ui_hide_1v1scores", 1);
  self _meth_82FF("ui_hub_1v1_queueposition", -1);

  if(_func_367() && !isDefined(self._id_5520)) {
    if(level._id_A220)
      self _meth_82FF("char_scene_state", 3);
  }

  _id_04E0::_id_870B(0);

  if(!isDefined(level._id_4F50))
    level._id_4F50 = 0;

  if(!_func_25F() && level.players.size <= 1 && _func_2A3() && getdvarint("2568", 0) == 0) {
    if(maps\mp\gametypes\_hud_util::shoulddohubtutorialflow() && (getdvarint("5740", 0) || !_id_04E0::_id_4B90()))
      level._id_4F50 = 1;
  }

  if(level._id_4F50 && getdvarint("intro_anim_debug", 0) != 1) {
    self _meth_82FF("ui_fte_welcome_message_status", 1);

    for(;;) {
      self waittill("luinotifyserver", var_2, var_3);

      if(var_2 == "hub_fte") {
        break;
      }
    }

    self _meth_82FF("ui_fte_welcome_message_status", 0);
    self freezecontrols(1);
    thread _id_715F();
    _id_0378::_id_8D74("theater_cinematic_started");
    waitframe();
    self _meth_82FF("ui_show_fte_division_select", 1);
    wait 52;
    _id_0378::_id_8D74("theater_cinematic_stopped");
    thread _id_04DF::_id_6380();
  } else if(_func_2A3())
    _id_0468::_id_0A1F();

  self._id_572A = 0;
  self._id_6B25 = _id_0482::_id_6FB8;
  self._id_5721 = 0;
  self._id_7891 = 0;
  self._id_5722 = 0;
  self._id_5692 = 0;
  self._id_572F = 0;
  self._id_4E03 = [];
  self._id_537B = 0;
  thread _id_04E1::_id_639F();

  if(!var_0 && !var_1) {
    thread _id_6385();
    thread _id_04E0::_id_63C0();
    thread _id_63C6();
    thread _id_04E0::_id_637C();
    thread _id_04E0::_id_639E();
  } else {
    thread monitorplayerusewithhubkillswitched();

    if(_func_3AE() && !common_scripts\utility::_id_562E(level._id_AC5A)) {
      self._id_537A = 0;
      thread _id_63F8();
    }
  }

  thread _id_637D();
  thread _id_52A1();
  thread _id_04DC::monitorsocialrankup();
  thread _id_04DD::monitorsupplydropawarded();
  thread _id_04DC::monitorsocialmaxrankreward();
}

_id_6BA6() {
  _id_5302();

  if(!isDefined(self._id_572A))
    self._id_572A = 0;

  var_0 = undefined;
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "";
  var_0 = [];
  var_0["loadoutDivision"] = 5;
  var_0["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::_id_473C(16994304, 0);

  for(var_1 = 0; var_1 < 6; var_1++)
    var_0["loadoutPrimaryAttachmentsGUID"][var_1] = 0;

  var_0["loadoutPrimaryBuff"] = "specialty_null";
  var_0["loadoutPrimaryCamoGUID"] = 0;
  var_0["loadoutPrimaryCamo2GUID"] = 0;
  var_0["loadoutPrimaryReticleGUID"] = 0;
  var_0["loadoutPrimaryPaintjobId"] = 0;
  var_0["loadoutPrimaryCharmGUID"] = 0;
  var_0["loadoutSecondaryWeaponStruct"] = maps\mp\_utility::_id_473C(16994304, 0);

  for(var_1 = 0; var_1 < 6; var_1++)
    var_0["loadoutSecondaryAttachmentsGUID"][var_1] = 0;

  var_0["loadoutSecondaryBuff"] = "specialty_null";
  var_0["loadoutSecondaryCamoGUID"] = 0;
  var_0["loadoutSecondaryCamo2GUID"] = 0;
  var_0["loadoutSecondaryReticleGUID"] = 0;
  var_0["loadoutSecondaryPaintjobId"] = 0;
  var_0["loadoutSecondaryCharmGUID"] = 0;
  var_0["loadoutEquipmentStruct"] = maps\mp\_utility::_id_44CE(0, 0);
  var_0["loadoutOffhandStruct"] = maps\mp\_utility::_id_44CE(0, 0);

  for(var_1 = 0; var_1 < 4; var_1++)
    var_0["loadoutKillstreaksGUID"][var_1] = 0;

  var_0["ignoreMeleeSlotWeapon"] = 1;
  var_0["loadoutJuggernaut"] = 0;

  for(var_1 = 0; var_1 < 9; var_1++)
    var_0["loadoutPerksGUID"][var_1] = 0;

  self.pers["gamemodeLoadout"] = var_0;
  self.class = self.pers["class"];
  self.lastclass = self.pers["lastClass"];
  maps\mp\gametypes\_class::_id_4790(level._id_746E, self.class);
  level._id_2BCB = self.class;
  self.maxhealth = 100;
  self.health = self.maxhealth;

  if(!isDefined(self.pers["killstreaks"]))
    self.pers["killstreaks"] = [];

  if(!isDefined(self.pers["kID"]))
    self.pers["kID"] = 10;

  self _meth_82FF("send_map_load_phase", -1);
  thread _id_6372();
  thread _id_6371();
  thread _id_6373();
}

_id_6373() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "send_lobby_in_lobby_type") {
      if(var_1 == 3) {
        self.inrankedlobby = 1;
        var_1 = 1;
      } else
        self.inrankedlobby = 0;

      self._id_537B = var_1;
    }
  }
}

_id_6372() {
  self._id_2419 = -1;
  self _meth_82FF("send_map_load_phase", 1);

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "map_load_phase") {
      self._id_2419 = var_1;

      if(var_1 == 2) {
        self _meth_82FF("send_map_load_phase", 0);
        return;
      }
    }
  }
}

_id_4B5B(var_0) {
  return isDefined(self._id_2419) && self._id_2419 >= var_0;
}

_id_A779(var_0) {
  while(!_id_4B5B(var_0))
    waitframe();
}

_id_A77E() {
  _id_A779(0);
}

_id_A791() {
  _id_A779(1);
}

_id_A777() {
  _id_A779(2);
}

_id_6371() {
  self endon("disconnect");
  self notify("monitorBeachZoneLoaded");
  self endon("monitorBeachZoneLoaded");

  if(isDefined(self._id_16F0) && self._id_16F0) {
    return;
  }
  if(isbot(self) || istestclient(self)) {
    return;
  }
  var_0 = getEntArray("transient_load_guard", "targetname");

  foreach(var_2 in var_0)
  var_2 _meth_8007(self, 1);

  var_4 = getEntArray("transient_load_hint", "targetname");

  foreach(var_6 in var_4)
  var_6 thread _id_63F0();

  _id_A777();
  self._id_16F0 = 1;

  foreach(var_2 in var_0)
  var_2 _meth_8007(self, 0);
}

_id_63F0() {
  level endon("game_ended");
  self endon("deleted");

  for(;;) {
    self waittill("trigger", var_0);

    if(!isPlayer(var_0) && !isDefined(var_0._id_3BAA)) {
      continue;
    }
    if(!isalive(var_0)) {
      continue;
    }
    if(isDefined(var_0._id_2419) && var_0._id_2419 >= 2) {
      continue;
    }
    if(!isDefined(var_0._id_9C65)) {
      var_0._id_9C65 = 1;
      var_0 thread maps\mp\gametypes\_hud_util::_id_3005("Area loading...", 0, 1.0, "remove_transient_hint");
      var_0 thread _id_2396(self);
    }
  }
}

_id_2396(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  while(isDefined(var_0)) {
    if(isDefined(self._id_2419) && self._id_2419 >= 2) {
      break;
    }

    if(!self istouching(var_0)) {
      break;
    }

    waitframe();
  }

  self notify("remove_transient_hint");
  self._id_9C65 = undefined;
}

_id_64BC() {
  if(getdvarint("5866", 0) == 1) {
    return;
  }
  if(isDefined(self._id_64A4) && self._id_64A4) {
    return;
  }
  var_0 = common_scripts\utility::_id_46B5("player_spawn_intermission", "targetname");

  if(isDefined(var_0)) {
    self setOrigin(var_0.origin, 1);
    self._id_64A4 = 1;
  }
}

_id_75D7() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    _id_04E0::_id_870B(0);

    if(self _meth_86BE() && !isDefined(self._id_64A4)) {
      self _meth_86BF(0);
      _id_64BC();
    }

    if(!_func_3B0())
      self freezecontrols(1);

    if(getdvarint("986") == 0)
      self _meth_85C7();

    self _meth_82FF("ui_hide_1v1scores", 1);
    self _meth_85B2(0, "mp_emote_salute");
    self._id_99FD = _func_131();

    if(isDefined(self._id_162C))
      _id_04E0::_id_2DD2("hub_baseNameHudElem");

    if(isDefined(self._id_ACA4))
      _id_04E0::_id_2DD2("hub_zoneHudElem");

    if(isDefined(self._id_177F))
      self._id_177F destroy();

    maps\mp\_utility::giveperk("specialty_marathon");
    maps\mp\_utility::giveperk("specialty_falldamage");
    self._id_6CCE = 0;
    self._id_1EB2 = 1;
    self._id_542B = 1;
    self._id_6CCE = 0;
    self._id_572B = 0;
    self._id_4B84 = 0;
    self._id_5721 = 0;
    self._id_7891 = 0;
    self._id_5722 = 0;
    self._id_5692 = 0;
    self._id_584B = 0;
    self._id_5791 = 0;
    self._id_34D2 = undefined;
    self._id_295A = "spawn_zone_trigger";
    self._id_56C8 = 0;
    self._id_1387 = 0;
    self._id_8C8F = 0;
    self._id_579F = 1;
    self._id_8B93 = 0;
    self._id_56A4 = 0;
    self._id_155F = undefined;
    self._id_5734 = 0;
    self._id_572F = 0;
    self._id_57E0 = 0;
    self._id_5733 = 0;
    self._id_7706 = "none";
    self.primarypaintjobid = 0;
    self.primarycharmguid = 0;
    self._id_835C = "none";
    self.secondarypaintjobid = 0;
    self.secondarycharmguid = 0;
    self._id_60FB = "none";
    self.isintimertag = 0;
    self.tagchallenger = undefined;
    self.hastagbomb = 0;
    self _meth_8114(0);
    self _meth_8112(1);
    self _meth_8113(1);
    self _meth_812A(0);
    self _meth_85BE(0);
    self._id_537B = 0;

    if(_func_3AE())
      _id_04E0::_id_2FA2();
    else
      _id_04E0::_id_3663();

    self._id_162C = _id_04E0::_id_2811("hub_baseNameHudElem", &"HUB_ALLIES_BASENAME", [40, -35], 1, "BOTTOM LEFT");
    self._id_ACA4 = _id_04E0::_id_2811("hub_zoneHudElem", &"HUB_ZONE_SPAWN", [40, -46], 1.5, "BOTTOM LEFT");
    self._id_ACA4.alpha = 0;
    self._id_162C.alpha = 0;
    self._id_ACA4.color = (0.7, 0.62, 0.42);
    self._id_162C.color = (0.81, 0.79, 0.69);
    self._id_162C._id_009A = "default";

    if(!self._id_572A) {
      thread _id_04E0::_id_4F44(self._id_295A);
      self _meth_85BF(0);
    }

    self._id_177F = _func_19B(self);
    self._id_177F.x = 0;
    self._id_177F.y = 0;
    self._id_177F._id_00C6 = "fullscreen";
    self._id_177F._id_01CA = "fullscreen";
    self._id_177F setshader("black", 640, 480);
    self._id_177F.alpha = 0;
    self._id_177F._id_35B2 = "icon";
    self._id_177F._id_6E74 = level._id_A012;
    self._id_177F._id_6E74 maps\mp\gametypes\_hud_util::_id_09A6(self._id_177F);
    self._id_177F.name = "blackout";

    if(getdvarint("intro_anim_debug", 0) == 1) {} else
      _id_04DF::cleanuphubtutorialents();

    if(_func_3AE() == 0)
      thread _id_04E0::_id_63EA();

    self _meth_84B4();
    self _meth_84B7(50, 29, 20, 20);
    thread _id_04DE::_id_1E53();

    if(self._id_572A == 1) {
      _id_04E0::_id_870B(1);
      _id_0482::_id_8A11(self._id_2922);
      continue;
    }

    self._id_2922 = undefined;
    self._id_4E03 = [];
    thread _id_04E0::_id_7B90();
    self _meth_8326();
    _id_0378::_id_8D74("start_hub_music");
  }
}

_id_63B7() {
  self endon("disconnect");
  level endon("game_ended");
  var_0 = getEntArray("officer_tower_collision", "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isDefined(var_0[var_1]))
      var_0[var_1] _meth_8007(self, 1);
  }

  for(;;) {
    if(isDefined(self._id_56D5) && self._id_56D5) {
      if(isDefined(level._id_4F51)) {
        foreach(var_3 in level._id_4F51) {
          if(var_3._id_6113 == "overlook_menu") {
            self _meth_84EB(var_3);
            break;
          }
        }
      }

      return;
    }

    var_5 = _id_21BE();

    if(!isDefined(self._id_56D5)) {
      if(var_5) {
        for(var_1 = 0; var_1 < var_0.size; var_1++) {
          if(isDefined(var_0[var_1]))
            var_0[var_1] _meth_8007(self, 0);
        }

        self._id_56D5 = 1;
      } else
        self._id_56D5 = 0;
    } else if(var_5) {
      for(var_1 = 0; var_1 < var_0.size; var_1++) {
        if(isDefined(var_0[var_1]))
          var_0[var_1] _meth_8007(self, 0);
      }

      self._id_56D5 = 1;
    }

    wait 3;
  }
}

_id_21BE() {
  var_0 = maps\mp\gametypes\_rank::getprestigelevel();
  var_1 = maps\mp\gametypes\_rank::getrankxp();
  var_2 = maps\mp\gametypes\_rank::getrankinfomaxxp(level.maxrank);

  if(var_1 >= var_2 || var_0 > 0)
    return 1;

  return 0;
}

_id_4ADC() {
  level endon("game_ended");

  if(!isDefined(level._id_6CB4))
    level._id_6CB4 = _func_18E("officer_tower_trigger", "targetname");

  if(!isDefined(level._id_6CB4)) {
    return;
  }
  wait 5;
  var_0 = common_scripts\utility::_id_46B5("officer_tower_spawn_1", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  level._id_6CB3 = spawn("script_model", var_0.origin);
  level._id_6CB3 _meth_84C7([500, 500, 0, 0, 0]);
  level._id_6CB3.angles = var_0.angles;
  level._id_6CB3 _meth_8276("mp_hub_doorman_idle");
  level._id_6CB3._id_74B8 = 0;
  level._id_6CB3._id_74B7 = 0;
  level._id_6CB4 thread _id_0478::_id_9DC3(::_id_37BC, ::_id_38F1);
}

_id_37BC(var_0) {
  if(!level._id_6CB3._id_74B8 && !level._id_6CB3._id_74B7) {
    if(self._id_56D5) {
      level._id_6CB3._id_74B8 = 1;
      var_1 = "mp_hub_doorman_salute";
    } else {
      level._id_6CB3._id_74B7 = 1;
      var_1 = "mp_hub_doorman_decline";
      _id_04E0::_id_3010("OverlookDoNotEnter", &"", "Must be level 55 to enter", 200, 1.5);
    }

    level._id_6CB3 _meth_8276(var_1, "animEnded");
    level thread _id_04E0::_id_7889(level._id_6CB3, "mp_hub_doorman_idle", "animEnded");
  } else {
    if(level._id_6CB3._id_74B8) {
      return;
    }
    if(level._id_6CB3._id_74B7) {
      if(self._id_56D5) {
        level._id_6CB3._id_74B8 = 1;
        level._id_6CB3 _meth_8276("mp_hub_doorman_salute", "animEnded");
        level thread _id_04E0::_id_7889(level._id_6CB3, "mp_hub_doorman_idle", "animEnded");
      }
    } else {}
  }
}

_id_38F1(var_0) {
  if(isDefined(self._id_308C["OverlookDoNotEnter"]))
    _id_04E0::_id_2DD2("OverlookDoNotEnter");
}

_id_6B78(var_0, var_1) {
  var_2 = 0;

  if(!var_1 _id_04E0::_id_5790(var_2)) {
    var_1 notify("end_existing_interacts");

    if(var_0 == 0) {
      var_1._id_53DB = 0;
      var_1 thread _id_04DC::_id_4AE0(self);
    }
  }
}

monitorplayerusewithhubkillswitched() {
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1, var_2, var_3);

    if(!isDefined(var_3) || var_2 == var_3) {
      switch (var_0) {
        case "quartermaster_menu":
          _id_04E1::_id_6B88(var_1, var_2, 0);
          break;
        case "headquarters_menu":
          _id_04E1::_id_6B43(var_1, var_2, 0);
          break;
        case "blacksmith_menu":
          var_3 _id_04E1::_id_6AC1(var_1, var_2, 0);
          break;
        case "general_menu":
          var_3 _id_04E1::_id_6BCC(var_1, var_2, var_0);
          break;
        case "mail_officer_menu":
          var_3 _id_04E1::_id_6B55(var_1, var_2);
          break;
        case "cs_drop_opened":
          _id_0468::_id_0A29("openSD", 0);
          break;
        case "cod_tv":
        case "theater_menu":
          var_3 _id_04E1::ontheateropenvlonly(var_1, var_2);
          break;
      }

      continue;
    }
  }
}

_id_63C6() {
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1, var_2, var_3);

    if(!isDefined(var_2) || var_2 != self || !isPlayer(var_2)) {
      continue;
    }
    if(!isDefined(var_3) || var_2 == var_3) {
      switch (var_0) {
        case "quartermaster_menu":
          _id_04E1::_id_6B88(var_1, var_2, 0);
          break;
      }

      continue;
    }

    if(var_0 == "player_interact_menu") {
      if(getdvarint("spv_hub_timer_tag_kswitch", 1) == 0 && var_2.isintimertag && var_3.isintimertag && isDefined(var_2.tagchallenger) && var_2.tagchallenger == var_3)
        var_2 _id_04DC::attemptpasstagbomb(var_3);
      else
        var_3 _id_6B78(var_1, var_2);

      continue;
    }

    switch (var_0) {
      case "quartermaster_menu":
        var_4 = 0;
        var_3 _id_04E1::_id_6B88(var_1, var_2, var_4);
        break;
      case "headquarters_menu":
        var_3 _id_04E1::_id_6B43(var_1, var_2);
        break;
      case "blacksmith_menu":
        var_3 _id_04E1::_id_6AC1(var_1, var_2);
        break;
      case "general_menu":
      case "overlook_menu":
        var_3 _id_04E1::_id_6B40(var_1, var_2);
        break;
      case "mail_officer_menu":
        var_3 _id_04E1::_id_6B55(var_1, var_2);
        break;
      case "onevone_officer_menu":
        var_3 _id_04E1::_id_6B5F(var_1, var_2);
        break;
      case "zombie_officer_menu":
        var_3 _id_04E1::_id_6BD6(var_1, var_2);
        break;
      case "cod_tv":
      case "theater_menu":
        var_3 _id_04E1::_id_6BB5(var_1, var_2);
        break;
      case "r_and_r_menu":
        var_3 _id_04E1::_id_6B8F(var_1, var_2);
        break;
      case "ranked_playlist_menu":
      case "war_playlist_menu":
      case "dom_playlist_menu":
      case "tdm_playlist_menu":
        var_3 _id_04E1::onleaderboardinteract(var_0, var_1, var_2);
        break;
      default:
        var_3 _id_04E1::_id_6BCC(var_1, var_2, var_0);
        break;
    }
  }
}

_id_577F() {
  if(isDefined(self._id_2068))
    return 1;

  return 0;
}

_id_44B2(var_0) {
  var_1 = common_scripts\utility::_id_46AF();

  if(!_func_3AC())
    var_1 = common_scripts\utility::_id_46AC();

  var_2 = self getplayerdata(var_1, "emotes", var_0, "emote");
  return var_2;
}

checkplayemote() {
  var_0 = _func_2D4(self, 1);
  var_1 = self _meth_856A();

  if(_id_577F())
    return 0;

  if(_id_04E0::_id_5790())
    return 0;

  if(self _meth_8178() != "stand" && !_func_293(self.origin + (0, 0, 6), var_1, var_0, self))
    return 0;

  return 1;
}

_id_7219(var_0) {
  if(var_0 != 0) {
    var_1 = _func_330(var_0);
    return _id_04E0::_id_721A(var_1);
  }

  return 0;
}

_id_6385() {
  self endon("disconnect");
  level endon("game_ended");

  if(!isbot(self)) {
    self._id_537A = 0;
    thread _id_63F4();
    thread _id_6382();
    thread _id_63A9();
    thread _id_63D7();
    thread _id_63F8();
    thread _id_63AA();
    thread _id_63E7();
    thread _id_63CE();
    thread monitortriangle();
  }
}

_id_63F4() {
  self endon("disconnect");
  self endon("releasepadmonitors");
  level endon("game_ended");
  self _meth_82E1("upDpad", "+actionslot 1");
  self _meth_82E1("upDpadRelease", "-actionslot 1");

  for(;;) {
    self waittill("upDpad");

    if(checkplayemote()) {
      var_0 = _id_44B2(0);

      if(_id_7219(var_0))
        wait 1;
    }
  }
}

_id_6382() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("releasepadmonitors");
  self _meth_82E1("downDpad", "+actionslot 2");
  self _meth_82E1("downDpadRelease", "-actionslot 2");

  for(;;) {
    self waittill("downDpad");

    if(checkplayemote()) {
      var_0 = _id_44B2(1);

      if(_id_7219(var_0))
        wait 1;
    }
  }
}

_id_63A9() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("releasepadmonitors");
  var_0 = ["", "mp_emote_salute", "mp_emote_clap_cheer", "mp_emote_clap_jump", "mp_emote_chicken_dance_loop"];
  self _meth_82E1("leftDpad", "+actionslot 3");
  var_1 = 1;

  for(;;) {
    self waittill("leftDpad");

    if(checkplayemote()) {
      var_2 = _id_44B2(2);

      if(_id_7219(var_2))
        wait 1;
    }
  }
}

_id_63D7() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("releasepadmonitors");
  self _meth_82E1("rightDpad", "+actionslot 4");
  setdvarifuninitialized("hub_reveal_num_planes", 2);
  setdvarifuninitialized("hub_reveal_cam", 0);

  for(;;) {
    self waittill("rightDpad");

    if(getdvarint("hub_reveal_cam", 0) == 0) {
      if(checkplayemote()) {
        var_0 = _id_44B2(3);

        if(_id_7219(var_0))
          wait 1;
      }

      continue;
    }

    if(getdvarint("hub_reveal_cam", 0) == 1) {
      thread _id_906B();
      wait 1;
    }
  }
}

_id_63AA() {
  level endon("game_ended");
  self endon("disconnect");
  self _meth_82E1("leftTrigger", "+speed_throw");
}

_id_63F9() {
  level endon("game_ended");
  self endon("disconnect");

  if(self._id_537A == 0 && _func_367() && (!isDefined(self._id_572B) || !self._id_572B)) {
    _id_04E0::_id_7471("cao_background_camera");

    if(isDefined(self._id_56A4) && self._id_56A4) {
      if(isDefined(self._id_155F))
        self._id_155F _id_04E0::_id_1543((0, 0, 80), self);
    }

    for(;;) {
      self waittill("luinotifyserver", var_0, var_1);

      if(var_0 == "hub_move_player_to_hub") {
        while(!isDefined(self._id_9092))
          waitframe();

        if(isDefined(self._id_64A4) && self._id_64A4 == 1) {
          if(!isDefined(self.warpingtosupplydrop))
            self setOrigin(self._id_9092);
        }

        self._id_64A4 = 0;
        self.warpingtosupplydrop = undefined;
        self _meth_85EF(&"hub_player_moved_to_hub_spawn");
        _id_04E0::_id_870B(_id_04E0::_id_5790(1));
        continue;
      }

      if(var_0 == "hub_vl_menu_active" && var_1 == 0) {
        _id_04E0::_id_115E();
        _id_04E0::_id_7472();
        break;
      }
    }
  } else if(isDefined(self._id_572B) && self._id_572B)
    return;
}

_id_63F8() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self _meth_82FF("ui_vl_monitor_started", 1);
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 != "hub_is_menu_open") {
      continue;
    }
    if(var_1 == 2)
      _id_64BC();

    if(var_1 >= 1)
      _id_63F9();
  }
}

_id_63E7() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 != "hub_supply_drop_selection") {
      continue;
    }
    var_2 = tablelookup("mp/supplyDropTypes.csv", 1, var_1, 0);

    if(var_2 != "")
      thread _id_04DD::_id_11BF(var_1);
  }
}

_id_63CE() {
  self endon("disconnect");
  self endon("releasepadmonitors");
  level endon("game_ended");
  _id_A791();
  self _meth_82E1("beginSupplyDrop_Input", "+attack");
  self _meth_82E1("beginSupplyDrop_Input", "+attack_akimbo_accessible");

  if(!level._id_258F)
    self _meth_82E1("beginSupplyDrop_Input_KBM", "+smoke");

  for(;;) {
    var_0 = common_scripts\utility::_id_A715("beginSupplyDrop_Input", "beginSupplyDrop_Input_KBM");

    if(!isDefined(var_0)) {
      continue;
    }
    var_1 = level._id_258F || common_scripts\utility::_id_55E0();

    if(var_1 != (var_0 == "beginSupplyDrop_Input")) {
      continue;
    }
    if(level._id_4F50) {
      continue;
    }
    if(isDefined(self._id_56A4) && self._id_56A4) {
      continue;
    }
    var_2 = self _meth_844A("ui_hub_in_shootout");

    if(!_id_04E0::_id_5790() && !var_2)
      self _meth_82FF("ui_show_supply_drop_selection", 1);

    wait 0.1;
  }
}

monitortriangle() {
  self endon("disconnect");
  self endon("releasepadmonitors");
  level endon("game_ended");
  _id_A791();
  self _meth_82E1("beginFriends_Input", "+weapnext");

  for(;;) {
    self waittill("beginFriends_Input");

    if(!level._id_258F && !common_scripts\utility::_id_55E0()) {
      continue;
    }
    if(level._id_4F50) {
      continue;
    }
    if(!_id_04E0::_id_5790())
      self _meth_82FF("ui_hub_show_social_pause", 1);

    wait 1.0;
  }
}

_id_63CD() {
  self endon("death");
  self endon("disconnect");
  self endon("quickchat_client_speak");
  var_0 = ["anyDpadPressed"];
  thread _id_04E0::_id_8636(int(_func_1AE("mp/quickchat.csv", 0, 2)) / 1000, "startChatTimeout", var_0);
  var_1 = common_scripts\utility::_id_A715("anyDpadPressed", "startChatTimeout");

  if(var_1 == "anyDpadPressed")
    thread _id_04E0::_id_8636(int(_func_1AE("mp/quickchat.csv", 0, 3)) / 1000, "chatSelectTimeout", var_0);
  else if(var_1 == "startChatTimeout") {
    thread _id_04E0::_id_3010("startChatTO", &"HUB_QUICKCHAT_TO", undefined, -100, 0.6, 2);
    return;
  }

  var_2 = common_scripts\utility::_id_A715("anyDpadPressed", "chatSelectTimeout");

  if(var_2 == "chatSelectTimeout")
    thread _id_04E0::_id_3010("chatSelectTO", &"HUB_QUICKCHAT_TO", undefined, -100, 0.6, 2);

  return;
}

_id_669F() {
  level.partymembers_cb = _id_04E2::_id_6EA2;
  level thread _id_04E2::_id_631E();
}

_id_A598() {
  level.partymembers_cb = maps\mp\hub_vl_camera::_id_6EA2;
  level._id_A595 = [];
  level._id_AAE2 = [];
  level._id_13B8 = [];
  var_0 = 48;

  for(var_1 = 0; var_1 < var_0; var_1++) {
    level._id_13B8[var_1] = spawnStruct();
    level._id_13B8[var_1]._id_9A1A = 0;
    level._id_13B8[var_1]._id_01D6 = "";
  }

  level._id_6077 = var_0;
  thread maps\mp\hub_vl_camera::_id_631E();
  setDvar("1999", 0);
  level._id_6871 = 4;
  maps\mp\hub_vl_camera::_id_8774();
}

_id_A124(var_0) {
  self endon("disconnect");

  if(!isDefined(self._id_20A9))
    self._id_20A9 = [];

  if(!isDefined(game["challengeStruct"]))
    game["challengeStruct"] = [];

  if(!isDefined(game["challengeStruct"]["limitedChallengesReset"]))
    game["challengeStruct"]["limitedChallengesReset"] = [];

  if(!isDefined(game["challengeStruct"]["challengesCompleted"]))
    game["challengeStruct"]["challengesCompleted"] = [];

  var_1 = maps\mp\gametypes\_hud_util::_id_2098(var_0);

  if(var_1 == 2) {
    maps\mp\gametypes\_hud_util::_id_209F(var_0, 1);
    maps\mp\gametypes\_hud_util::_id_209E(var_0, 0);
  }

  self._id_20A9[var_0] = 1;
}

_id_A125() {
  foreach(var_1 in level._id_4F49) {
    var_2 = maps\mp\gametypes\_hud_util::_id_2098(var_1);

    if(var_2 == 0) {
      var_2 = 1;
      maps\mp\gametypes\_hud_util::_id_209F(var_1, 1);
    }

    self._id_20A9[var_1] = var_2;
  }
}

_id_8C6D(var_0) {
  self endon("disconnect");
  level endon("level_ended");

  if(!isDefined(var_0)) {
    var_1 = _func_1AC(level._id_9956, self.origin);

    foreach(var_3 in var_1) {
      if(!isDefined(var_3._id_745E) || var_3._id_745E == 0) {
        var_0 = var_3;
        break;
      }
    }
  }

  if(!isDefined(var_0)) {
    return;
  }
  self setOrigin(var_0.origin + (0, 5, 0));
  self _meth_833E(var_0.angles + (0, 90, 0));
  wait 0.15;
  self _meth_85C9(1);
  waitframe();
  self _meth_85C9(0);
  self freezecontrols(1);
  _id_04E0::_id_721A("mp_emote_sitting_loop");
}

_id_637D() {
  self waittill("disconnect");
  level endon("game_ended");

  if(isDefined(self._id_572A) && !self._id_572A) {
    if(isDefined(level._id_4F38))
      level._id_4F38._id_787F = common_scripts\utility::_id_0F93(level._id_4F38._id_787F, self);

    self notify("luinotifyserver", "enter_1v1", 0);
  } else if(isDefined(self._id_572A) && self._id_572A)
    self._id_2922 _id_0482::_id_3E22();

  _id_04E0::_id_2386(1);

  if(isDefined(self._id_34CD)) {
    self._id_34CD _id_04E0::_id_2DD2("duelChallenge");
    self._id_34CD _meth_84A7("accept_duel_challenge", "+usereload");
    self._id_34CD _meth_84A7("reject_duel_challenge", "+stance");
  }

  if(isDefined(self._id_A405)) {
    if(isDefined(self._id_A405._id_1739)) {
      self._id_A405._id_1739 delete();
      self._id_A405._id_1739 = undefined;
    }

    self._id_A405 delete();
    self._id_A405 = undefined;
  }

  if(isDefined(self._id_9B66))
    self._id_9B66 delete();

  foreach(var_1 in level.players) {
    if(isDefined(var_1._id_746C)) {
      if(!isDefined(self))
        var_1._id_746C = common_scripts\utility::_id_0FA0(var_1._id_746C);
      else
        var_1._id_746C = common_scripts\utility::_id_0F98(self, var_1._id_746C);

      var_1 _meth_85CD(var_1._id_746C);
    }
  }

  if(isDefined(self._id_8B24))
    self._id_8B24 thread _id_04DB::_id_4B07(undefined, undefined, 1);
}

_id_906B() {
  var_0 = [];
  var_1 = getdvarint("hub_reveal_num_planes", 2);

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = spawn("script_model", (400, -880, 656));
    var_3.angles = (0, 90, 0);
    var_3 setModel("usa_fighter_thunderbolt");
    var_3 _meth_8278("mp_hub_teaser_thunderbolt");
    var_0[var_2] = var_3;
    wait 0.5;
  }

  wait 15;

  foreach(var_3 in var_0)
  var_3 delete();
}
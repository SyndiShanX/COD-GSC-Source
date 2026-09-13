/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_79f95f5f6d9eeb19.gsc
***********************************************/

_id_B04F37F19C6631E0() {
  level.map_interaction_func = ::register_interactions;
  level.player_interaction_monitor = ::level_specific_player_interaction_monitor;
  level.wait_for_interaction_func = ::_id_FE7243424D42CD4B;
  level.interaction_trigger_properties_func = ::interaction_trigger_properties;
}

register_interactions() {
  if(scripts\engine\utility::flag_exist("interactions_initialized"))
    scripts\engine\utility::flag_set("interactions_initialized");
}

_id_FE7243424D42CD4B(_id_DF071553D0996FF9) {
  self notify("interaction_logic_started");
  self endon("interaction_logic_started");
  self endon("stop_interaction_logic");
  self endon("disconnect");

  for(;;) {
    _id_DF071553D0996FF9.triggered = undefined;
    self.interaction_trigger waittill("trigger", player);

    if(!_id_71332A5B74214116::interaction_is_valid(_id_DF071553D0996FF9, player)) {
      continue;
    }
    _id_DF071553D0996FF9.triggered = 1;
    cost = _id_DF071553D0996FF9 _id_71332A5B74214116::interaction_get_cost();

    if(!isDefined(level.interactions[_id_DF071553D0996FF9.script_noteworthy].spend_type))
      level.interactions[_id_DF071553D0996FF9.script_noteworthy].spend_type = "null";

    if(!_id_71332A5B74214116::can_purchase_interaction(_id_DF071553D0996FF9, cost, level.interactions[_id_DF071553D0996FF9.script_noteworthy].spend_type)) {
      level notify("interaction", "purchase_denied", level.interactions[_id_DF071553D0996FF9.script_noteworthy], self);
      thread scripts\cp\cp_vo::try_to_play_vo("no_cash", "zmb_comment_vo", "high", 10, 0, 0, 1, 50);
      _id_71332A5B74214116::interaction_show_fail_reason(_id_DF071553D0996FF9, &"COOP_INTERACTIONS/NEED_MONEY");
      continue;
    }

    thread _id_71332A5B74214116::interaction_post_activate_delay(_id_DF071553D0996FF9);
    level notify("interaction", "purchase", level.interactions[_id_DF071553D0996FF9.script_noteworthy], self);
    _id_E42F7EB456B932F2 = level.interactions[_id_DF071553D0996FF9.script_noteworthy].spend_type;
    thread _id_71332A5B74214116::take_player_money(cost, _id_E42F7EB456B932F2);
    level thread[[level.interactions[_id_DF071553D0996FF9.script_noteworthy].activation_func]](_id_DF071553D0996FF9, self);
    _id_71332A5B74214116::interaction_post_activate_update(_id_DF071553D0996FF9);
    return;
  }
}

level_specific_player_interaction_monitor() {
  self notify("player_interaction_monitor");
  self endon("player_interaction_monitor");
  self endon("disconnect");
  self endon("death");
  _id_B755813C92F9BD4A = 5184;
  _id_925AB147F36BB977 = 9216;

  for(;;) {
    if(isDefined(level.interactions_disabled)) {
      level waittill("interactions_disabled_toggled");
      continue;
    }

    _id_A00884ED3A6D8B4B = self.origin;
    _id_AC3DC6CF8564E576 = undefined;
    _id_717FB99ADD9A6834 = sortbydistancecullbyradius(level.current_interaction_structs, _id_A00884ED3A6D8B4B, 512);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.disabled_interactions.size; _id_AC0E594AC96AA3A8++)
      _id_717FB99ADD9A6834 = scripts\engine\utility::array_remove(_id_717FB99ADD9A6834, self.disabled_interactions[_id_AC0E594AC96AA3A8]);

    if(_id_717FB99ADD9A6834.size == 0 || istrue(self.delay_hint)) {
      self notify("starting_interaction_search");
      waitframe();
      continue;
    }

    _id_4403360414478511 = _id_717FB99ADD9A6834[0];
    _id_581AED15F31BBE01 = distancesquared(_id_4403360414478511.origin, _id_A00884ED3A6D8B4B);

    if(!isDefined(_id_AC3DC6CF8564E576) && _id_581AED15F31BBE01 <= _id_B755813C92F9BD4A)
      _id_AC3DC6CF8564E576 = _id_4403360414478511;
    else if(!isDefined(_id_AC3DC6CF8564E576) && isDefined(level.should_allow_far_search_dist_func)) {
      if(_id_581AED15F31BBE01 <= _id_925AB147F36BB977)
        _id_AC3DC6CF8564E576 = _id_4403360414478511;

      if(isDefined(_id_AC3DC6CF8564E576) && ![[level.should_allow_far_search_dist_func]](_id_AC3DC6CF8564E576))
        _id_AC3DC6CF8564E576 = undefined;
    } else if(!isDefined(_id_AC3DC6CF8564E576) && isDefined(_id_4403360414478511.custom_search_dist)) {
      if(_id_581AED15F31BBE01 <= _id_4403360414478511.custom_search_dist)
        _id_AC3DC6CF8564E576 = _id_4403360414478511;
    }

    if(!isDefined(_id_AC3DC6CF8564E576) || !scripts\engine\utility::array_contains(level.current_interaction_structs, _id_AC3DC6CF8564E576) || !_id_71332A5B74214116::can_use_interaction(_id_AC3DC6CF8564E576)) {
      _id_71332A5B74214116::reset_interaction();
      continue;
    }

    if(!_id_71332A5B74214116::no_previous_interaction_point() || !_id_71332A5B74214116::interaction_point_has_changed(_id_AC3DC6CF8564E576) && _id_71332A5B74214116::interaction_is_button_mash(_id_AC3DC6CF8564E576) || _id_71332A5B74214116::interaction_point_has_changed(_id_AC3DC6CF8564E576))
      _id_71332A5B74214116::set_interaction_point(_id_AC3DC6CF8564E576);

    waitframe();
  }
}

interaction_trigger_properties(interaction_trigger, _id_DF071553D0996FF9, hintstring) {
  switch (_id_DF071553D0996FF9.script_noteworthy) {
    default:
      self.interaction_trigger setusefov(360);
      self.interaction_trigger sethintrequiresholding(0);

      if(isDefined(_id_DF071553D0996FF9.useduration))
        self.interaction_trigger setuseholdduration(_id_DF071553D0996FF9.useduration);

      break;
  }
}

_id_5F2CDAE2726B2ACF() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("scriptables_ready");
  wait 5;
  level thread _id_974D9466C7CA0ECD();
  level thread _id_70516D4AD5B200B1();
  spawnfunc = _id_18A73A64992DD07D::registerambientgroup;
  [[spawnfunc]]("cp_observatory_spawner_storage_jugg", 6, 6, 6, 0.05, 0, "cp_observatory_spawner_storage_jugg", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("cp_observatory_spawner_storage_jugg", ::_id_C7C38DC4842C19A1);
  level waittill("defender_jugg_killed", origin);
  level thread _id_B862C8C3E072A786(origin);
}

_id_1564CE6F2920ECAD() {
  if(istrue(level._id_876100FABF0FCA43)) {
    return;
  }
  level._id_876100FABF0FCA43 = 1;
  level notify("remove_storage_teleporter");
  level._id_C31F51D8148BC79C = _id_18A73A64992DD07D::run_spawn_module("cp_observatory_spawner_storage_jugg");
  wait 1;
  _id_36E4555D3788AD40 = scripts\engine\utility::getStructArray("cp_observatory_lockdoor", "targetname");
  _id_44FE95C601CBBC8A = scripts\engine\utility::getStructArray("cp_observatory_spawner_storage_jugg", "targetname");
  level thread _id_27CA64492371EA5F(_id_44FE95C601CBBC8A[0]);
  _id_CE126B8C53B9993F = scripts\engine\utility::array_combine(_id_36E4555D3788AD40, _id_44FE95C601CBBC8A);

  foreach(smoke in _id_CE126B8C53B9993F) {
    wait(0.2 + randomfloat(0.4));
    magicgrenademanual("smoke_grenade_mp", smoke.origin, (0, 0, 0), 0.3);
    thread scripts\engine\utility::play_sound_in_space("smoke_grenade_expl_trans", smoke.origin);
  }

  level thread _id_48F20B0FE71DD6DF::_id_BB2EF5E778692F44("b", 10);
}

_id_27CA64492371EA5F(struct) {
  _id_2E79DF00671CB070 = scripts\engine\utility::spawn_tag_origin(struct.origin, struct.angles);
  _id_2E79DF00671CB070 playLoopSound("milbase_alarm");
  wait 8;
  _id_2E79DF00671CB070 stoploopsound();
  wait 1;
  _id_2E79DF00671CB070 delete();
}

_id_B862C8C3E072A786(origin) {
  _id_54921A5AB41B1D09 = scripts\engine\utility::drop_to_ground(origin, 100, -300) + (0, 0, 5);
  _id_006F21596340FAAE = spawn("script_model", _id_54921A5AB41B1D09);
  _id_006F21596340FAAE setModel("accessory_locker_key_02");
  _id_006F21596340FAAE.angles = (0, 0, 90);
  _id_006F21596340FAAE.usable = spawn("script_model", _id_54921A5AB41B1D09 + (0, 0, 1));
  _id_006F21596340FAAE.usable setModel("tag_origin");
  _id_006F21596340FAAE.usable.key = _id_006F21596340FAAE;
  _id_006F21596340FAAE.usable thread _id_07BBE309DBBBFF4E();
}

_id_07BBE309DBBBFF4E() {
  self endon("death");
  self makeusable();
  self sethintdisplayrange(192);
  self sethintdisplayfov(80);
  self setuserange(65);
  self setusefov(50);
  self setuseholdduration("duration_none");
  self setCursorHint("HINT_BUTTON");
  self sethintonobstruction("show");
  self setHintString(&"CP_MISSION_DEFENDER/KEY_STORAGE");
  self _meth_DFB78B3E724AD620(1);
  _id_D7DF9E31F6BDC923 = "icon_waypoint_objective_general";
  self._id_F98E48F2527D4205 = scripts\cp_mp\entityheadicons::setheadicon_singleimage(level.players, _id_D7DF9E31F6BDC923, 13, 1, 240, 0, undefined, undefined, 1);

  for(;;) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    thread _id_1213A4E63F1F614A(player);
  }
}

_id_1213A4E63F1F614A(player) {
  self _meth_DFB78B3E724AD620(0);
  player endon("death_or_disconnect");
  player thread scripts\cp\utility::playerplaypickupanim("iw9_ges_pickup");
  wait 0.35;
  player._id_29C61EDD8ADCAB8B = 1;
  alias = "stat_66D4835263B12EE1";
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, alias);

  if(isDefined(self._id_F98E48F2527D4205))
    thread scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self._id_F98E48F2527D4205);

  wait 0.05;
  self.key delete();
  self delete();
}

_id_C7C38DC4842C19A1(group_name, func) {
  thread _id_6437C0FE818C903F();
}

_id_6437C0FE818C903F() {
  self endon("death");
  self.ignoreall = 0;

  if(!isDefined(level._id_A2D3060A4F34AC6F))
    level._id_A2D3060A4F34AC6F = 0;

  level._id_A2D3060A4F34AC6F++;
  _id_04C92B8C0FB87F94(level._id_A2D3060A4F34AC6F);

  for(;;) {
    target = scripts\cp\utility::get_closest_living_player();

    if(isDefined(target))
      self getenemyinfo(target);

    wait 5;
  }
}

_id_04C92B8C0FB87F94(count) {
  self endon("death");

  if(count == 1) {
    return;
  }
  delay = count * 15;
  originalpos = self getclosestreachablepointonnavmesh(self.origin);
  _id_636C8575D7A7768B = squared(100);
  _id_0F1A9809EED7E8F0 = 0;
  self._id_C833409FB72D15FB = 1;
  _id_18A73A64992DD07D::set_goal_radius(150);
  _id_18A73A64992DD07D::set_goal_pos(originalpos);

  while(_id_0F1A9809EED7E8F0 < delay) {
    _id_0F1A9809EED7E8F0++;
    wait 1;

    if(scripts\cp\utility::any_player_nearby(self.origin, _id_636C8575D7A7768B)) {
      break;
    }
  }

  self._id_C833409FB72D15FB = 0;
}

_id_70516D4AD5B200B1() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  thread _id_C4B5AE2C8C384A33();
  scripts\engine\scriptable_door::_id_29BA88E5CE21F3FD(::_id_31C405AA2D21F0B5);
  scripts\engine\scriptable_door::_id_E37078F3D00EF312(::_id_42974A5D66E156B8);
  scripts\engine\scriptable_door::_id_87D7BE37D61CBAE3(::_id_20381C7B081C3F54);
  _id_9792640B164CDEB1 = scripts\engine\utility::getStructArray("cp_observatory_lockdoor", "targetname");
  level._id_FAB1E7371966E8FC = [];

  foreach(_id_1E92D8D3755A9FF8 in _id_9792640B164CDEB1) {
    _id_1E92D8D3755A9FF8.obstacle = createnavbadplacebybounds(_id_1E92D8D3755A9FF8.origin, (70, 70, 70), (0, 0, 0));
    _id_1E92D8D3755A9FF8._id_3089C6859DE1A2DC = getentitylessscriptablearray(undefined, undefined, _id_1E92D8D3755A9FF8.origin, 128, "door");

    foreach(door in _id_1E92D8D3755A9FF8._id_3089C6859DE1A2DC) {
      if(isDefined(door.type) && issubstr(door.type, "invisible")) {
        continue;
      }
      _id_1E92D8D3755A9FF8._id_3089C6859DE1A2DC = door;
      door._id_87ED8CB5B10DBE85 = _id_1E92D8D3755A9FF8;
      level._id_FAB1E7371966E8FC = scripts\engine\utility::array_add(level._id_FAB1E7371966E8FC, _id_1E92D8D3755A9FF8._id_3089C6859DE1A2DC);
      _id_1E92D8D3755A9FF8._id_3089C6859DE1A2DC _id_FBBFE6F05EDA5EB1(_id_1E92D8D3755A9FF8._id_3089C6859DE1A2DC);
    }
  }
}

_id_C4B5AE2C8C384A33() {
  level endon("game_ended");
  level endon("remove_storage_teleporter");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  wait 10;
  _id_6837307E12CF1D8F = 1;

  if(!_id_6837307E12CF1D8F) {
    return;
  }
  radius = 115;
  _id_44FE95C601CBBC8A = scripts\engine\utility::getStructArray("cp_observatory_spawner_storage_jugg", "targetname");
  _id_3004DA8038B93D37 = scripts\engine\utility::getStructArray("cp_intel", "targetname");
  _id_7A5A8B43A2A4D802 = scripts\engine\utility::getclosest(_id_44FE95C601CBBC8A[0].origin, _id_3004DA8038B93D37);
  _id_CDC5DD6C28C9709D = radius * radius;
  locationorigin = spawnStruct();
  locationorigin.origin = _id_7A5A8B43A2A4D802.origin;

  for(;;) {
    foreach(player in level.players) {
      if(distancesquared(player.origin, locationorigin.origin) < _id_CDC5DD6C28C9709D) {
        _id_C00448D30DF1BEA6 = _id_3E19322333AD204C::_id_9472000B5A2CE4FC(locationorigin.origin);
        player setOrigin(getclosestpointonnavmesh(_id_C00448D30DF1BEA6.origin));
        player thread scripts\cp\cp_hud_message::tutorialprint(&"CP_INTEL_IW9/LOCKED", 5);
      }
    }

    wait 0.05;
  }
}

_id_FBBFE6F05EDA5EB1(door) {
  door _meth_9AF4C9B2CC1BF989(1);
  door.blocked = 1;
}

_id_B092780F9EC4496E(door) {
  door _meth_80902296B05BE00A();

  if(isDefined(door._id_5C493302B016B154))
    door._id_5C493302B016B154 _meth_80902296B05BE00A();

  door.blocked = undefined;
  door._id_A16669FDD0578E00 = 1;

  foreach(player in level.players)
  door enablescriptableplayeruse(player);
}

_id_20381C7B081C3F54(scriptable, player) {
  level thread _id_1564CE6F2920ECAD();

  if(isDefined(scriptable._id_87ED8CB5B10DBE85) && isDefined(scriptable._id_87ED8CB5B10DBE85.obstacle)) {
    destroynavobstacle(scriptable._id_87ED8CB5B10DBE85.obstacle);
    scriptable._id_87ED8CB5B10DBE85.obstacle = undefined;
  }
}

_id_31C405AA2D21F0B5(scriptable, player) {
  return &"SCRIPT/DOOR_HINT_LOCKED";
}

_id_42974A5D66E156B8(instance, player, _id_85E3240D30E184E7) {
  if(!istrue(player._id_29C61EDD8ADCAB8B))
    return 0;

  _id_36E4555D3788AD40 = scripts\engine\utility::getStructArray("cp_observatory_lockdoor", "targetname");
  _id_8E45D4AB6F4CE9B5 = scripts\engine\utility::getclosest(player.origin, _id_36E4555D3788AD40, 120);

  if(!isDefined(_id_8E45D4AB6F4CE9B5))
    return 0;

  if(!scripts\engine\utility::within_fov(player.origin, player.angles, _id_8E45D4AB6F4CE9B5.origin, 0.766))
    return 0;

  return 1;
}

_id_974D9466C7CA0ECD() {
  _id_71CF47EBBBE620AC = scripts\engine\utility::getStruct("obs_ghost_intel_03", "targetname");
  _id_DA853F0E79F0049E = spawn("script_model", _id_71CF47EBBBE620AC.origin);
  _id_DA853F0E79F0049E setModel("electronics_usb_thumb_drive");
  _id_DA853F0E79F0049E.angles = _id_71CF47EBBBE620AC.angles;
  level thread _id_E430888E388046F4();
  wait 0.05;
  _id_2B7BFABF0C3FD75A = scripts\engine\utility::getStruct("obs_purchase_intel_03", "targetname");
  level._id_829788CAC20F92CE = spawn("script_model", _id_2B7BFABF0C3FD75A.origin - (0, 0, 8.5));
  level._id_829788CAC20F92CE setModel("tag_origin");
  level._id_829788CAC20F92CE makeusable();
  level._id_829788CAC20F92CE setHintString(&"CP_MISSION_DEFENDER/VENDING_MACHINE");
  level._id_829788CAC20F92CE setCursorHint("HINT_BUTTON");
  level._id_829788CAC20F92CE sethintdisplayrange(64);
  level._id_829788CAC20F92CE sethintdisplayfov(65);
  level._id_829788CAC20F92CE setusefov(15);
  level._id_829788CAC20F92CE setuserange(60);
  level._id_829788CAC20F92CE sethintonobstruction("hide");
  level._id_829788CAC20F92CE _meth_DFB78B3E724AD620(1);
  level._id_829788CAC20F92CE thread _id_9C44F7BD1DF352BA();
  level waittill("obs_purchase_vending_intel");
  level thread scripts\cp\utility::playsoundatpos_safe(_id_DA853F0E79F0049E.origin, "cp_vendingmachine_buy");

  if(soundexists("buystation_deltasquad_buy"))
    level._id_829788CAC20F92CE playsoundtoteam("buystation_deltasquad_buy", "allies");

  level._id_829788CAC20F92CE makeunusable();
  level thread scripts\cp\utility::playsoundatpos_safe(level._id_829788CAC20F92CE.origin, "br_pickup_generic");
  _id_C1FD3785A7BFE37F = scripts\engine\utility::getStruct(_id_71CF47EBBBE620AC.target, "targetname");
  _id_BF2CD90B69751CD0 = scripts\engine\utility::getStruct(_id_C1FD3785A7BFE37F.target, "targetname");
  _id_DA853F0E79F0049E moveTo(_id_C1FD3785A7BFE37F.origin, 6, 4, 0.1);
  wait 6;
  _id_DA853F0E79F0049E moveTo(_id_BF2CD90B69751CD0.origin - (0, 0, 4), 0.5, 0.1, 0.1);
  wait 0.5;
  level._id_5AD7EF60AB40873B = 1;
  level thread scripts\cp\utility::playsoundatpos_safe(_id_DA853F0E79F0049E.origin, "br_pickup_generic");
  _id_DA853F0E79F0049E hide();
  wait 0.1;
  _id_DA853F0E79F0049E delete();
  level._id_829788CAC20F92CE delete();
}

_id_E430888E388046F4() {
  level endon("game_ended");
  _id_05A4604D796FA2EE = undefined;

  foreach(_id_104A0214A4EEC589 in level._id_7BED7FD13ABBBC9C) {
    if(_id_104A0214A4EEC589._id_96477DA1695E035B.info == "obs_intel_usb_03") {
      _id_05A4604D796FA2EE = _id_104A0214A4EEC589;
      break;
    }
  }

  wait 1;

  for(;;) {
    foreach(player in level.players) {
      if(istrue(level._id_5AD7EF60AB40873B) && distance(player.origin, _id_05A4604D796FA2EE.origin) < 500 && !player scripts\cp\intel\cp_intel::_id_6FB0C700A7AAF634(_id_05A4604D796FA2EE)) {
        _id_05A4604D796FA2EE._id_96477DA1695E035B enablescriptablepartplayeruse("intel_interaction", player);
        _id_05A4604D796FA2EE._id_96477DA1695E035B showtoplayer(player);
      } else {
        _id_05A4604D796FA2EE._id_96477DA1695E035B disablescriptablepartplayeruse("intel_interaction", player);
        _id_05A4604D796FA2EE._id_96477DA1695E035B hidefromplayer(player);
      }

      wait 0.05;
    }

    wait 1;
  }
}

_id_9C44F7BD1DF352BA() {
  level endon("game_ended");
  level endon("obs_purchase_vending_intel");

  for(;;) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    if(player _id_3BCAA2CBAF54ABDD::try_take_player_currency(20000))
      level notify("obs_purchase_vending_intel");
  }
}
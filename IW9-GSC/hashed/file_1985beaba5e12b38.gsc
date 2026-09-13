/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1985beaba5e12b38.gsc
***********************************************/

_id_232D129BDE114192() {
  level endon("game_ended");
  self endon("death");
  self endon("unloaded");
  wait 5;

  while(self vehicle_getspeed() > 0.1)
    wait 1;

  if(1) {
    return;
  }
  wait 15;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.riders.size; _id_AC0E594AC96AA3A8++)
    self.riders[_id_AC0E594AC96AA3A8] kill(self.origin);

  level thread _id_18B7E7BF9E8FEAFF();
  wait 0.1;
  self dodamage(self.health + 1000, self.origin);
}

_id_18B7E7BF9E8FEAFF() {
  wait 1;
  level._id_6E5FF6CAE14C4081 = scripts\engine\utility::array_removeundefined(level._id_6E5FF6CAE14C4081);
  level._id_6E5FF6CAE14C4081 = scripts\engine\utility::array_removedead(level._id_6E5FF6CAE14C4081);
}

_id_DAC0E77E51D99A3C() {
  level endon("game_ended");
  self endon("death");
  self endon("unloaded");
  _id_36558E546E29A69A = self.origin;

  for(;;) {
    wait 5;
    startpos = self.origin;
    wait 15;
    _id_4D12D9153651CB6D = self.origin;

    if(isDefined(self.birthtime) && gettime() - 15000 > self.birthtime) {
      return;
    }
    if(distance(startpos, _id_4D12D9153651CB6D) < 500 || self.origin[2] < _id_36558E546E29A69A[2] - 1000) {
      announcement("^1Debug: Enemy Truck Frozen, Killed:" + self.origin);

      foreach(rider in self.riders)
      rider dodamage(rider.health + 1000, rider.origin);

      self dodamage(self.health + 1000, self.origin);
      level._id_6E5FF6CAE14C4081 = scripts\engine\utility::array_removeundefined(level._id_6E5FF6CAE14C4081);
      level._id_6E5FF6CAE14C4081 = scripts\engine\utility::array_removedead(level._id_6E5FF6CAE14C4081);
    }
  }
}

_id_826D32F4C189E323(_id_92DEFECADE96A443) {
  _id_E7281F3FB58EEC0C = scripts\engine\utility::getStructArray(_id_92DEFECADE96A443.spawngroup, "targetname");
  _id_67E2C244A6E8D0BF = scripts\engine\utility::getclosest(level.player.origin, _id_E7281F3FB58EEC0C);
  _id_61066F8690277012 = _id_18A73A64992DD07D::copy_from_level_struct(_id_67E2C244A6E8D0BF);
  _id_273A7E688CEC3E10 = _id_61066F8690277012.level_module_struct;
  _id_273A7E688CEC3E10.targetname = "hack_" + _id_273A7E688CEC3E10.targetname;
  _id_273A7E688CEC3E10.script_parameters = _id_92DEFECADE96A443.script_parameters;
  scripts\engine\utility::_id_1F6C1A9B7564DC61(_id_273A7E688CEC3E10);
  return _id_273A7E688CEC3E10.targetname;
}

_id_23B61F49117D9DBE() {
  if(getdvarint("dvar_6859A455E901A0E7", 0) > 0)
    level._id_215CD837F06FA79E._id_DEF74253F2C565A1[1] = ["bomber_small", 600, "medium"];

  if(getdvarint("dvar_3E535965241B3F5D", 0) > 0)
    level._id_215CD837F06FA79E._id_DEF74253F2C565A1[1] = ["mortar", 600, "medium"];

  if(getdvarint("dvar_DFF8DB614587C640", 0) > 0)
    level._id_215CD837F06FA79E._id_DEF74253F2C565A1[1] = ["turret", 600, "medium"];

  if(getdvarint("dvar_A0648658E22839E1", 0) > 0)
    level._id_215CD837F06FA79E._id_DEF74253F2C565A1[1] = ["truck", 600, "medium"];

  if(getdvarint("dvar_2087EC8BE553B300", 0) > 0)
    level._id_215CD837F06FA79E._id_DEF74253F2C565A1[1] = ["medium", 30, "medium", 30, "medium", 30, "medium", 30, "medium", 30, "medium", 30, "medium", 30, "medium", 30, "medium", 30, "medium", 30, "medium", 30, "medium", 30, "medium", 30, "medium", 30, "medium"];

  if(getdvarint("dvar_6418F157AE139AF1", 0) > 0)
    level._id_215CD837F06FA79E._id_DEF74253F2C565A1[1] = ["soldier", 30, "soldier", 30, "soldier", 30, "soldier", 30, "soldier", 30, "soldier", 30, "soldier", 30, "soldier", 30, "soldier", 30, "soldier", 30, "soldier", 30, "soldier"];

  if(getdvarint("dvar_0E53E9B83BC20CF5", 0) > 0)
    level._id_215CD837F06FA79E._id_DEF74253F2C565A1[1] = ["medium", 30, "soldier", 30, "medium", 30, "soldier", 30, "medium", 30, "soldier", 30, "medium", 30, "soldier", 30, "medium", 30, "soldier", 30, "medium", 30, "soldier"];

  if(getdvarint("dvar_BE34D866BAADAF12", 0) > 0)
    level._id_215CD837F06FA79E._id_DEF74253F2C565A1[1] = ["medium_hover", 600, "medium"];
}

_id_C150B09845347406() {
  self endon("death");

  for(;;)
    waitframe();
}

_id_38681B3333B831D4() {
  if(getdvarint("dvar_A5735B107771D0B4", 0) == 0) {
    return;
  }
  if(!isDefined(level.forced_aitypes))
    level.forced_aitypes = [];

  level.forced_aitypes[level.forced_aitypes.size] = "ar";
}

_id_DB46B9B09A115BA2(_id_41D8BF229CF29051) {
  _id_90BA8F7DF548FDCB = scripts\engine\utility::ter_op(_id_41D8BF229CF29051, ::makeusable, ::makeunusable);

  foreach(crate in level._id_CCDD82907B113C40) {
    if(isDefined(crate) && isDefined(crate._id_0A86F5D2BA9AFBF9))
      crate._id_0A86F5D2BA9AFBF9 call[[_id_90BA8F7DF548FDCB]]();
  }
}

_id_3A4D5473F7E3FC1B() {
  self endon("death");

  for(;;) {
    self waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    level notify("shop_started");
    self makeunusable();
    level thread _id_42E3A60E829D178B();
  }
}

_id_42E3A60E829D178B() {
  level endon("game_ended");
  level._id_989AC7C4FC3D9841 = 0;
  level.cratedropdata.heliheightoffset = 3000;
  level.cratedropdata._id_6AE5AFA97C7F286C = 1;
  wait 1;
  objective_setlabel(level._id_B550D7A337EE4625, &"CP_MISSION_DEFENDER/SUPPLIES_ICON");
  _id_D7B44CB498FDACDB = scripts\engine\utility::getStruct("obj_shops", "targetname");
  objective_position(level._id_B550D7A337EE4625, _id_D7B44CB498FDACDB.origin);
  level notify("defender_start");
}

_id_5333CDA790154851() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  wait 10;
  _id_FBA0426C71E79ED3 = 60000;
  _id_C21454D94A6900F2 = [];

  for(;;) {
    if(isDefined(level.vehicle) && isDefined(level.vehicle.helicopter_crash_locations)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.vehicle.helicopter_crash_locations.size; _id_AC0E594AC96AA3A8++) {
        struct = level.vehicle.helicopter_crash_locations[_id_AC0E594AC96AA3A8];

        if(!isDefined(struct) || !isstruct(struct)) {
          continue;
        }
        if(istrue(struct.claimed)) {
          if(!isDefined(struct._id_29EDF0BB097B10F6)) {
            struct._id_29EDF0BB097B10F6 = gettime();
            _id_C21454D94A6900F2[_id_C21454D94A6900F2.size] = struct;
          } else if(isDefined(struct._id_29EDF0BB097B10F6)) {
            if(gettime() > struct._id_29EDF0BB097B10F6 + _id_FBA0426C71E79ED3) {
              struct._id_29EDF0BB097B10F6 = undefined;
              struct.claimed = undefined;

              if(scripts\engine\utility::array_contains(_id_C21454D94A6900F2, struct))
                _id_C21454D94A6900F2 = scripts\engine\utility::array_remove(_id_C21454D94A6900F2, struct);
            }
          }

          continue;
        }

        if(scripts\engine\utility::array_contains(_id_C21454D94A6900F2, struct)) {
          struct._id_29EDF0BB097B10F6 = undefined;
          _id_C21454D94A6900F2 = scripts\engine\utility::array_remove(_id_C21454D94A6900F2, struct);
        }
      }
    }

    wait 1;
  }
}

_id_34E2AA0AEB370C7A() {
  level._id_CEE48B761F8CA747 = 0;
  type = "military_ammo_restock_train";
  _id_FEDF4B30A2C699E5 = scripts\engine\utility::getStruct("defender_ammocrate", "targetname");
  scriptable = spawnscriptable(type, _id_FEDF4B30A2C699E5.origin, _id_FEDF4B30A2C699E5.angles);
}

_id_C0F4602063394BDD(model) {
  if(!isDefined(model)) {
    return;
  }
  model setscriptablepartstate("military_ammo_restock", "USEABLE_OFF");
  model.interact = spawn("script_model", model.origin + (0, 0, 32));
  model.interact.angles = model.angles;
  model.interact setModel("tag_origin");
  model.interact.targetname = "seq3_cache";
  model.interact makeusable();
  hintstring = &"COOP_CRAFTING/AMMO_CRATE_TAKE";
  model.interact setHintString(hintstring);
  model.interact setCursorHint("HINT_BUTTON");
  model.interact sethintdisplayrange(190);
  model.interact sethintdisplayfov(140);
  model.interact setuserange(105);
  model.interact setusefov(65);
  model.interact sethintonobstruction("show");
  model.interact setuseholdduration("duration_short");
  model.interact thread ammo_cache_think();
  model.interact.headicon = model.interact scripts\cp_mp\entityheadicons::setheadicon_singleimage(level.players, "hud_icon_br_ammo_arlmg", 18, 0, 512, 128);
}

ammo_cache_think() {
  self endon("death");

  for(;;) {
    self waittill("trigger", player);

    if(isDefined(player)) {
      if(!player scripts\cp\utility::is_valid_player()) {
        continue;
      }
      thread ammo_cache_used(player);
    }
  }
}

ammo_cache_used(player) {
  player thread _id_65EC25DA122EFE3C::_id_B6C303E97D2AFE72();
}

_id_321F47CC1200C41E(player) {
  success = player scripts\cp\cp_ammo_crate::supportbox_onusedeployable();

  if(success) {
    foreach(weapon in player.weaponlist) {
      clip_ammo = weaponclipsize(weapon);
      player setweaponammoclip(weapon, clip_ammo);
      player _id_66122A002AFF5D57::_id_4172A10AE7CBDB41(weapon);
    }
  }

  if(success)
    player thread _id_E0A6812A07D8609E();
}

_id_06B2E1228DFBC477(player) {
  success = player scripts\cp\cp_grenade_crate::healthbox_onusedeployable();

  if(success)
    player thread _id_E0A6812A07D8609E();
}

_id_E0A6812A07D8609E() {
  self notify("ammo_cache_success");
  self endon("ammo_cache_success");
  thread _id_66122A002AFF5D57::_id_EE5540242EF172D4();
  self playlocalsound("weap_ammo_pickup");
  thread _id_354C862768CFE202::hudicontype("ammobox");
}

_id_65DFAAE634DF359D() {
  level endon("game_ended");
  wait 1;
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  wait 1;
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Defender Mode / Spawn DeltaSquad\" \"set scr_defendermode_spawndeltasquad 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_557C1ED5649436BB", ::_id_20F44D1C6E9A7244);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Defender Mode / Give Sentrygun\" \"set scr_defendermode_givesentrygun 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_9A92D455378788BC", ::_id_798E4C6D40947D2B);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Defender Mode / Force Hardpoint A\" \"set scr_defendermode_forcedhardpoint_a 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_DF780DA90C5B3B2A", ::_id_A63383F0F34B7811);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Defender Mode / Force Hardpoint B\" \"set scr_defendermode_forcedhardpoint_b 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_DF780CA90C5B38F7", ::_id_A63380F0F34B7178);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Defender Mode / Force Hardpoint C\" \"set scr_defendermode_forcedhardpoint_c 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_DF780BA90C5B36C4", ::_id_A63381F0F34B73AB);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Defender Mode / Spawn JuggKey\" \"set scr_defendermode_spawnjuggkey 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_572E3F4EB13EB6BB", ::_id_FE1F6705D38008F2);
}

_id_20F44D1C6E9A7244() {
  level.players[0] thread _id_757C9AC43A532DAC::_id_A9D99FE0169FDB0A();
}

_id_798E4C6D40947D2B() {
  _id_59CDCDF44A2FA379 = scripts\cp\loot_system::give_munition("brloot_munition_sentry", level.players[0]);
}

_id_A63383F0F34B7811() {
  setDvar("dvar_ACDD33D10BB6166E", "a");
}

_id_A63380F0F34B7178() {
  setDvar("dvar_ACDD33D10BB6166E", "b");
}

_id_A63381F0F34B73AB() {
  setDvar("dvar_ACDD33D10BB6166E", "c");
}

_id_FE1F6705D38008F2() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "spawn_jugg_key"))
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "spawn_jugg_key")]](level.players[0].origin);
}
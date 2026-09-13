/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\munitions.gsc
***********************************************/

init_munitions() {
  level.munitions_table_data = [];
  level.ammoincompatibleweaponslist = ["iw9_la_mike32_mp"];
  setdvarifuninitialized("dvar_F897A05F1AF906A1", 0);
  read_munition_table();
  initkillstreakdata();
  level.unlimitedmunitions = getdvarint("dvar_F897A05F1AF906A1", 0);
  _id_14609B809484646E::_id_8ECE37593311858A(::_id_65A298EC5C2F2FF4);
}

initkillstreakdata() {
  _id_584994FAB4A8712B = spawnStruct();
  level._id_0B23156D776B1D85 = _id_584994FAB4A8712B;
  _id_584994FAB4A8712B.costomnvars = [];
  _id_584994FAB4A8712B.costomnvars[1] = "ui_score_streak_cost";
  _id_584994FAB4A8712B.costomnvars[2] = "ui_score_streak_two_cost";
  _id_584994FAB4A8712B.costomnvars[3] = "ui_score_streak_three_cost";
  _id_584994FAB4A8712B.slotomnvars = [];
  _id_584994FAB4A8712B.slotomnvars[0] = "ui_score_streak_index_0";
  _id_584994FAB4A8712B.slotomnvars[1] = "ui_score_streak_index_1";
  _id_584994FAB4A8712B.slotomnvars[2] = "ui_score_streak_index_2";
  _id_584994FAB4A8712B.slotomnvars[3] = "ui_score_streak_index_3";
  _id_584994FAB4A8712B.availableomnvars = [];
  _id_584994FAB4A8712B.availableomnvars[0] = "ui_score_streak_available_0";
  _id_584994FAB4A8712B.availableomnvars[1] = "ui_score_streak_available_1";
  _id_584994FAB4A8712B.availableomnvars[2] = "ui_score_streak_available_2";
  _id_584994FAB4A8712B.availableomnvars[3] = "ui_score_streak_available_3";
  _id_584994FAB4A8712B._id_8BBE6DC152F1DAE0 = [];
  _id_584994FAB4A8712B._id_8BBE6DC152F1DAE0[1] = "ui_score_streak_last_round_earned_1";
  _id_584994FAB4A8712B._id_8BBE6DC152F1DAE0[2] = "ui_score_streak_last_round_earned_2";
  _id_584994FAB4A8712B._id_8BBE6DC152F1DAE0[3] = "ui_score_streak_last_round_earned_3";
  _id_1F9E754F6B690E33();
}

_id_1F9E754F6B690E33() {
  _id_584994FAB4A8712B = level._id_0B23156D776B1D85;

  if(isDefined(_id_584994FAB4A8712B._id_038F2A11237246AC)) {
    return;
  }
  _id_584994FAB4A8712B._id_038F2A11237246AC = [];
  _id_584994FAB4A8712B._id_2150DA9328528BB9 = [];
  _id_20EE381602C954DB = getscriptbundle(scripts\cp_mp\utility\killstreak_utility::_id_0708853C5D755F72());

  foreach(index, _id_CC673384F6943C85 in _id_20EE381602C954DB._id_386A08793AF08E6C) {
    if(!isnumber(index)) {
      continue;
    }
    if(!isDefined(_id_CC673384F6943C85)) {
      continue;
    }
    if(!isDefined(_id_CC673384F6943C85.ref)) {
      continue;
    }
    _id_2B7CF61AF0CB9960 = _id_CC673384F6943C85.ref;

    if(_id_2B7CF61AF0CB9960 == "none") {
      continue;
    }
    _id_5AD12D18E74C1F78 = _id_CC673384F6943C85._id_D442547D75DFFD09;

    if(!isDefined(_id_5AD12D18E74C1F78)) {
      continue;
    }
    if(_id_5AD12D18E74C1F78 == "killstreak_none") {
      continue;
    }
    if(_id_5AD12D18E74C1F78 == "replace_me") {
      continue;
    }
    _id_D442547D75DFFD09 = getscriptbundle("killstreak:" + _id_5AD12D18E74C1F78);

    if(!isDefined(_id_D442547D75DFFD09)) {
      continue;
    }
    _id_584994FAB4A8712B._id_038F2A11237246AC[_id_2B7CF61AF0CB9960] = _id_D442547D75DFFD09;
    _id_584994FAB4A8712B._id_2150DA9328528BB9[_id_2B7CF61AF0CB9960] = index;
  }
}

_id_65A298EC5C2F2FF4() {
  self.munition_slots = [];
  _id_25B13E44DCA57E67();
}

_id_25B13E44DCA57E67() {
  _id_B8BA56B9EDD59CB7 = 4;
  _id_794A764136E46006 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B8BA56B9EDD59CB7; _id_AC0E594AC96AA3A8++) {
    self.munition_slots[_id_AC0E594AC96AA3A8] = spawnStruct();
    self.munition_slots[_id_AC0E594AC96AA3A8].ref = "none";
    self.munition_slots[_id_AC0E594AC96AA3A8].cooldown = level.munitions_table_data[self.munition_slots[_id_AC0E594AC96AA3A8].ref].cooldown;
    self.munition_slots[_id_AC0E594AC96AA3A8].can_use = 0;
    self.munition_slots[_id_AC0E594AC96AA3A8].cooldown_progress = undefined;
    self.munitions_in_playerdata[_id_AC0E594AC96AA3A8] = spawnStruct();
    self.munitions_in_playerdata[_id_AC0E594AC96AA3A8].ref = self.munition_slots[_id_AC0E594AC96AA3A8].ref;
  }
}

read_munition_table() {
  _id_CB89110314447B2F = 0;

  for(;;) {
    _id_A7F7342ABACA0E34 = tablelookupbyrow("cp/cp_munitiontable.csv", _id_CB89110314447B2F, 1);

    if(_id_A7F7342ABACA0E34 == "") {
      break;
    }

    level.munitions_table_data[_id_A7F7342ABACA0E34] = spawnStruct();
    level.munitions_table_data[_id_A7F7342ABACA0E34].index = int(tablelookupbyrow("cp/cp_munitiontable.csv", _id_CB89110314447B2F, 0));
    level.munitions_table_data[_id_A7F7342ABACA0E34].ref = _id_A7F7342ABACA0E34;
    level.munitions_table_data[_id_A7F7342ABACA0E34].cost = int(tablelookupbyrow("cp/cp_munitiontable.csv", _id_CB89110314447B2F, 4));
    level.munitions_table_data[_id_A7F7342ABACA0E34].cooldown = float(tablelookupbyrow("cp/cp_munitiontable.csv", _id_CB89110314447B2F, 5));
    _id_CB89110314447B2F++;
  }
}

_id_077084F05581A035() {
  self.dpad_selection_index = 0;
  _id_B00605B9047D7F4B = 4;
  _id_B8BA56B9EDD59CB7 = 4;

  if(istrue(level.unlimitedmunitions))
    _id_B8BA56B9EDD59CB7 = 1;

  self setplayerdata("cp", "inventorySlots", "totalSlots", _id_B8BA56B9EDD59CB7);
}

_id_0B64F3836C1D7A06(_id_EA3E3B2121E6713A, val) {
  if(isDefined(_id_EA3E3B2121E6713A)) {
    switch (_id_EA3E3B2121E6713A) {
      case "radial_menu_munition_tap":
        if(!istrue(level._id_C4ED9EB36C678ED4)) {
          break;
        }
      case "radial_menu_munition":
        _id_401C3A2E68AAB0FD = 0;

        if(!istrue(self.isjuggernaut)) {
          if(!player_can_use_munitions(_id_401C3A2E68AAB0FD)) {
            break;
          }
        } else {
          val = _id_346CDE477A4FEF90("nvg");

          if(!isDefined(val)) {
            break;
          }
        }

        if(val >= 0 && val <= 3) {
          _id_A7F7342ABACA0E34 = self.munition_slots[val];

          if(isDefined(_id_A7F7342ABACA0E34) && _id_A7F7342ABACA0E34.ref != "none" && _id_A7F7342ABACA0E34.ref != "empty1" && _id_A7F7342ABACA0E34.ref != "empty2" && _id_A7F7342ABACA0E34.ref != "empty3") {
            if(istrue(can_use_munition(val))) {
              if(_id_A7F7342ABACA0E34.ref == "nvg" && !istrue(level.disable_nvg) && !istrue(self._id_4D572A54ED8571C4)) {
                if(!istrue(self.pers["useNVG"])) {
                  self.pers["useNVG"] = 1;
                  self nightvisionviewon();
                } else {
                  self.pers["useNVG"] = 0;
                  self nightvisionviewoff();
                }

                break;
              }

              if(_id_A7F7342ABACA0E34.ref == "flashlight" && istrue(level._id_0C735D60735EDA5F)) {
                thread _id_435C3F85A3D06576::toggle_flashlight();
                break;
              }

              thread remove_munition_on_use(_id_A7F7342ABACA0E34.ref, val);
              success = giveitembasedoncraftingstruct(_id_A7F7342ABACA0E34.ref);

              if(success) {
                if(is_instant_use_munition(_id_A7F7342ABACA0E34.ref))
                  self notify("munitions_used", _id_A7F7342ABACA0E34.ref);

                scripts\cp\cp_analytics::logevent_munitionused(self, _id_A7F7342ABACA0E34.ref);
              } else
                self notify("remove_munition_on_use");
            }
          }
        }

        break;
      default:
        break;
    }
  }
}

player_can_use_munitions(_id_401C3A2E68AAB0FD) {
  if(istrue(level.disable_munitions)) {
    thread scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
    return 0;
  }

  if(istrue(self.disable_munitions)) {
    thread scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
    return 0;
  }

  if(!isDefined(self.munition_slots)) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold("self.munition_slots undefined");

    return 0;
  }

  if(self isonladder()) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold("IsOnLadder() failed");

    return 0;
  }

  if(istrue(self.spectating)) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold("self.spectating");

    return 0;
  }

  if(isDefined(self.currentpiece)) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold("self.currentPiece defined");

    return 0;
  }

  if(istrue(self.is_fast_traveling)) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold("self.is_fast_traveling");

    return 0;
  }

  if(istrue(self.inlaststand)) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold("self.inLastStand");

    return 0;
  }

  if(istrue(self.instant_revive_buffer)) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold("self.instant_revive_buffer");

    return 0;
  }

  if(istrue(self.isreviving)) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold("self.isReviving");

    return 0;
  }

  if(isDefined(self.placementmodel)) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold("self.placementModel defined");

    return 0;
  }

  if(istrue(self.iscarrying)) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold("self.isCarrying");

    return 0;
  }

  if(isDefined(self.hostagecarried)) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold("self.hostageCarried defined");

    return 0;
  }

  if(istrue(self.bgivensentry)) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold("self.bGivenSentry");

    return 0;
  }

  if(istrue(self.tablet_out)) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold("self.tablet_out");

    return 0;
  }

  if(istrue(self.b_in_vehicle)) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold("self.b_in_vehicle");

    thread scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
    return 0;
  }

  if(istrue(self.waiting_to_spawn)) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold("self.waiting_to_spawn");

    return 0;
  }

  if(self isparachuting()) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold("self IsParachuting()");

    return 0;
  }

  if(self isskydiving()) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold("self IsSkydiving()");

    return 0;
  }

  if(isDefined(self.currentturret)) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold("self.currentTurret defined");

    return 0;
  }

  if(istrue(self.respawn_in_progress)) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold("respawn in progress");

    return 0;
  }

  if(istrue(self.isjuggernaut)) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold("self.isJuggernaut");

    return 0;
  }

  if(isDefined(level.nuclear_core_carrier) && level.nuclear_core_carrier == self) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold("self is nuclear core carrier");

    thread scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
    return 0;
  }

  if(_id_0AFB7E332AEE4BF2::player_in_laststand(self)) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold("player in last stand");

    return 0;
  }

  if(istrue(self.islockedinkidnapanim)) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold("self.isLockedInKidnapAnim");

    return 0;
  }

  if(self isjumping()) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold("self IsJumping()");

    return 0;
  }

  if(!self isonground() && !self _meth_E40102956C887F7C()) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold("self not IsOnGround()");

    return 0;
  }

  if(istrue(self.usingobject)) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold("self.usingObject");

    return 0;
  }

  if(istrue(self.is_riding_heli)) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold("self.is_riding_heli");

    return 0;
  }

  if(istrue(level.regroup_process_started)) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold(" Regroup to plane started so disabled Munitions till process is complete");

    return 0;
  }

  if(istrue(self.dropping_minigun)) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold("Still dropping minigun");

    return 0;
  }

  if(istrue(self.super_activated)) {
    if(self.super._id_5237A188CCDA4D7B == "role_hunter" || self.super._id_5237A188CCDA4D7B == "role_engineer") {
      if(_id_401C3A2E68AAB0FD)
        iprintlnbold("Super ability still active");

      return 0;
    }
  }

  if(istrue(self.gascoughinprogress)) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold("gas cough in progress");

    return 0;
  }

  if(istrue(self.using_mun)) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold("still using munition");

    return 0;
  }

  if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("cp_munitions")) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold("munitions are not allowed");

    return 0;
  }

  if(istrue(self._id_D5AF94588739718C)) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold("using cctv");

    return 0;
  }

  if(istrue(self._id_23A6763562820C70)) {
    if(_id_401C3A2E68AAB0FD)
      iprintlnbold("using oxygen");

    return 0;
  }

  return 1;
}

should_drop_minigun(ref) {
  return 1;
}

remove_munition_on_use(ref, val) {
  self notify("remove_munition_on_use");
  self endon("remove_munition_on_use");

  if(istrue(level.unlimitedmunitions)) {
    return;
  }
  thread send_munition_used_notify(ref, val);
  self waittill("munitions_used", ref);
  remove_munition(val, ref);
}

send_munition_used_notify(ref, val) {
  switch (ref) {
    case "apache":
    case "chopper_gunner":
      self waittill("chopper_gunner_used");
      break;
    case "auto_drone":
      self waittill("auto_drone_used");
      break;
    default:
      return;
  }

  self notify("munitions_used", ref);
}

is_instant_use_munition(ref) {
  switch (ref) {
    case "cruise_missile":
    case "trophysystem":
    case "ac130":
    case "uav":
      return 1;
  }

  return 0;
}

mun_test_monitor() {
  self endon("disconnect");
  _id_251347BBD289C8B3 = level.disable_nvg;

  for(;;) {
    _id_36012B041DE2BE87 = getDvar("dvar_F98DD172396621E2", "");

    if(_id_36012B041DE2BE87 != "") {
      scripts\cp\utility::_id_7BB9F9B4DC700888();
      scripts\cp\equipment\nvg::removenvg();
    } else if(!istrue(level.disable_nvg))
      scripts\cp\equipment\nvg::runnvg();

    wait 0.1;
  }
}

update_lua_inventory_slot(_id_B8E029C9896F52B6) {
  self setclientomnvar("cp_munition_sel_slot_idx", _id_B8E029C9896F52B6);
}

get_selection_index_loop_around(_id_C3DD56819F77263B, _id_A8DAEB9E4DE670F5, _id_18B7AC38B222E55F) {
  if(_id_C3DD56819F77263B > _id_18B7AC38B222E55F)
    return _id_A8DAEB9E4DE670F5;

  if(_id_C3DD56819F77263B < _id_A8DAEB9E4DE670F5)
    return _id_18B7AC38B222E55F;

  return _id_C3DD56819F77263B;
}

clear_legacy_pickup_munitions() {
  self endon("disconnect");
  level endon("game_ended");
  self setclientomnvar("reset_wave_loadout", 5);
  wait 0.5;
  self setplayerdata("cp", "alienSession", "escapedRank0", 0);
  self setplayerdata("cp", "alienSession", "escapedRank1", 0);
  self setplayerdata("cp", "alienSession", "escapedRank2", 0);
  _id_B8BA56B9EDD59CB7 = 4;
  reset_munitions(self, _id_B8BA56B9EDD59CB7);
  assign_lowest_full_slot_to_active();
}

reset_munitions(player, _id_B8BA56B9EDD59CB7) {
  player notify("reset_munitions");
  _id_794A764136E46006 = [];
  _id_B8BA56B9EDD59CB7 = 4;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B8BA56B9EDD59CB7; _id_AC0E594AC96AA3A8++) {
    if(isDefined(player.munition_slots) && isDefined(player.munition_slots[_id_AC0E594AC96AA3A8]) && isDefined(player.munition_slots[_id_AC0E594AC96AA3A8].cooldown_progress))
      _id_794A764136E46006[_id_AC0E594AC96AA3A8] = player.munition_slots[_id_AC0E594AC96AA3A8].cooldown_progress;
    else
      _id_794A764136E46006[_id_AC0E594AC96AA3A8] = undefined;

    _id_A52C671ACCA08378 = player _id_12E2FB553EC1605E::cac_getloadoutselectedidx();

    if(!isDefined(player.munition_slots) || !isDefined(player.munition_slots[_id_AC0E594AC96AA3A8]))
      player.munition_slots[_id_AC0E594AC96AA3A8] = spawnStruct();

    player.munitions_in_playerdata[_id_AC0E594AC96AA3A8] = spawnStruct();

    if(_id_116171939929AF39::allow_munitions(player)) {
      player.munition_slots[_id_AC0E594AC96AA3A8].ref = player get_munition(_id_AC0E594AC96AA3A8);
      player.munitions_in_playerdata[_id_AC0E594AC96AA3A8].ref = player.munition_slots[_id_AC0E594AC96AA3A8].ref;
      player.munition_slots[_id_AC0E594AC96AA3A8].cooldown = level.munitions_table_data[player.munition_slots[_id_AC0E594AC96AA3A8].ref].cooldown;
      player.munition_slots[_id_AC0E594AC96AA3A8].can_use = 0;
      player.munition_slots[_id_AC0E594AC96AA3A8].cooldown_progress = undefined;

      if(isDefined(_id_794A764136E46006[_id_AC0E594AC96AA3A8]))
        player.munition_slots[_id_AC0E594AC96AA3A8].cooldown_progress = _id_794A764136E46006[_id_AC0E594AC96AA3A8];

      if(!istrue(level.unlimitedmunitions)) {
        player.munition_slots[_id_AC0E594AC96AA3A8].can_use = 0;

        if(!scripts\cp\loot_system::is_empty_or_none(_id_AC0E594AC96AA3A8)) {
          player setclientomnvar("cp_munition_1_timer", 1);
          player setclientomnvar("cp_munition_2_timer", 1);
          player setclientomnvar("cp_munition_3_timer", 1);
          player setclientomnvar("cp_munition_4_timer", 1);
          player.munition_slots[_id_AC0E594AC96AA3A8].can_use = 1;
        }
      }
    } else if(!isDefined(player.init_munitions)) {
      player.munition_slots[_id_AC0E594AC96AA3A8].ref = "none";
      player.munition_slots[_id_AC0E594AC96AA3A8].cooldown = level.munitions_table_data[player.munition_slots[_id_AC0E594AC96AA3A8].ref].cooldown;
      player.munition_slots[_id_AC0E594AC96AA3A8].can_use = 0;
      player.munition_slots[_id_AC0E594AC96AA3A8].cooldown_progress = undefined;
    }

    omnvar = undefined;
    _id_A413DAE711968957 = "cp_munition_slot_reset";
    slot = undefined;

    switch (_id_AC0E594AC96AA3A8) {
      case 0:
        omnvar = "cp_munition_slot_1";
        slot = 1;
        break;
      case 1:
        omnvar = "cp_munition_slot_2";
        slot = 2;
        break;
      case 2:
        omnvar = "cp_munition_slot_3";
        slot = 3;
        break;
      case 3:
        omnvar = "cp_munition_slot_4";
        slot = 4;
        break;
    }

    index = level.munitions_table_data[player.munition_slots[_id_AC0E594AC96AA3A8].ref].index;

    if(isDefined(omnvar) && isDefined(index) && isDefined(slot))
      player setclientomnvar(omnvar, index);
  }

  if(!isDefined(player.init_munitions))
    player.init_munitions = 1;

  if(!isDefined(player.loadout_changed_flag))
    player.loadout_changed_flag = 0;

  if(player.loadout_changed_flag == 0)
    _id_6302CA9978061647 = 1;
  else
    _id_6302CA9978061647 = 0;

  player setclientomnvar("cp_loadout_changed", _id_6302CA9978061647);
  player.loadout_changed_flag = _id_6302CA9978061647;

  if(istrue(level.unlimitedmunitions)) {
    player thread cooldown_munition("munition_1_used", "cp_munition_1_timer", player, player.munition_slots[0].ref, player.munition_slots[0].cooldown, 0);
    player thread cooldown_munition("munition_2_used", "cp_munition_2_timer", player, player.munition_slots[1].ref, player.munition_slots[1].cooldown, 1);
    player thread cooldown_munition("munition_3_used", "cp_munition_3_timer", player, player.munition_slots[2].ref, player.munition_slots[2].cooldown, 2);
    player thread cooldown_munition("munition_4_used", "cp_munition_4_timer", player, player.munition_slots[3].ref, player.munition_slots[3].cooldown, 3);
  }
}

_id_AF07AAD35B55FD73(_id_E0190C3433D5B099) {
  if(!isDefined(_id_E0190C3433D5B099))
    return 0;

  if(issubstr(_id_E0190C3433D5B099, "brloot_munition"))
    return 1;

  return 0;
}

get_munition(_id_A52C671ACCA08378) {
  if(scripts\cp\utility::is_wave_gametype())
    _id_A7F7342ABACA0E34 = self getplayerdata(level.loadoutsgroup, "squadMembers", "munitionWaveModeSetups", _id_A52C671ACCA08378, "munition");
  else if(scripts\cp\utility::_id_A3577E8E6C88A56B())
    return "none";
  else {
    if(_id_A52C671ACCA08378 == 3)
      return "none";

    _id_A7F7342ABACA0E34 = self getplayerdata(level.loadoutsgroup, "squadMembers", "munitionSetups", _id_A52C671ACCA08378, "munition");
  }

  return _id_A7F7342ABACA0E34;
}

get_role_munition(_id_A52C671ACCA08378) {
  _id_36012B041DE2BE87 = undefined;

  if(!isDefined(_id_36012B041DE2BE87)) {} else {}

  return _id_36012B041DE2BE87;
}

cooldown_munition(_id_F00B93A05196F767, _id_A64C51188D789C25, player, _id_A7F7342ABACA0E34, _id_6F89268F7DDF91D0, slot, _id_1207E043696EBAF9) {
  level endon("game_ended");
  player endon("disconnect");
  player endon("reset_munitions");
  player notify(_id_F00B93A05196F767 + "_reset");
  player endon(_id_F00B93A05196F767 + "_reset");
  _id_395FC479A3CCD472 = _id_6F89268F7DDF91D0;
  _id_713B970F6576A5C9 = getdvarfloat("dvar_C2DA12EDF7170DD7", 1);
  _id_6F89268F7DDF91D0 = _id_395FC479A3CCD472 * _id_713B970F6576A5C9;
  _id_629D0F5BF2000D64 = undefined;

  for(;;) {
    paused = 0;

    if(scripts\engine\utility::flag_exist("infil_complete") && !scripts\engine\utility::flag("infil_complete"))
      paused = 1;

    if(paused) {
      waitframe();
      continue;
    }

    if(!isDefined(player.munition_slots[slot].cooldown_progress)) {
      player.munition_slots[slot].cooldown_progress = 0;
      player setclientomnvar(_id_A64C51188D789C25, 0);
    }

    if(istrue(_id_1207E043696EBAF9)) {
      player.munition_slots[slot].cooldown_progress = _id_6F89268F7DDF91D0;
      player setclientomnvar(_id_A64C51188D789C25, 1);
      _id_1207E043696EBAF9 = undefined;
    }

    if(player.munition_slots[slot].cooldown_progress < _id_6F89268F7DDF91D0)
      player.munition_slots[slot].can_use = 0;

    while(player.munition_slots[slot].cooldown_progress <= _id_6F89268F7DDF91D0) {
      _id_6E96934D67C36A7C = getdvarfloat("dvar_C2DA12EDF7170DD7", 1);

      if(_id_6E96934D67C36A7C != _id_713B970F6576A5C9) {
        _id_713B970F6576A5C9 = _id_6E96934D67C36A7C;
        _id_6F89268F7DDF91D0 = _id_395FC479A3CCD472 * _id_713B970F6576A5C9;
      }

      if(istrue(player.has_inv_cooldown))
        player.munition_slots[slot].cooldown_progress = _id_6F89268F7DDF91D0 + 1;

      if(_id_6F89268F7DDF91D0 == 0)
        _id_5D3A428E1F92C6BA = 1;
      else
        _id_5D3A428E1F92C6BA = min(player.munition_slots[slot].cooldown_progress / _id_6F89268F7DDF91D0, 1);

      player setclientomnvar(_id_A64C51188D789C25, _id_5D3A428E1F92C6BA);

      if(_id_5D3A428E1F92C6BA < 1) {
        _id_28D1299402599124 = 0.05;
        player.munition_slots[slot].cooldown_progress = player.munition_slots[slot].cooldown_progress + _id_28D1299402599124;
      } else
        break;

      wait 0.05;
    }

    player.munition_slots[slot].can_use = 1;
    _id_F7B6CC6C062A7A43 = "cp_" + _id_A7F7342ABACA0E34;

    if(istrue(_id_629D0F5BF2000D64))
      player thread scripts\cp\cp_hud_message::showsplash(_id_F7B6CC6C062A7A43, undefined, self);

    _id_629D0F5BF2000D64 = 1;
    player waittill(_id_F00B93A05196F767);
    player.munition_slots[slot].cooldown_progress = undefined;
    player.munition_slots[slot].can_use = 0;
    player.munition_slots[slot].source = undefined;
  }
}

remove_munition_from_array(slot, _id_A7F7342ABACA0E34) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.munition_slots.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(self.munitions_in_playerdata[_id_AC0E594AC96AA3A8]) && self.munitions_in_playerdata[_id_AC0E594AC96AA3A8].ref == _id_A7F7342ABACA0E34) {
      if(_id_AC0E594AC96AA3A8 == slot)
        self setclientomnvar("cp_munition_slot_reset", _id_AC0E594AC96AA3A8);

      self.munitions_in_playerdata[_id_AC0E594AC96AA3A8] = undefined;
      self.munition_slots[slot].source = undefined;
      break;
    }
  }
}

munition_source_getridof(name) {
  _id_38CC1DC20C14E9D0 = 0;

  switch (name) {
    case "overwatch":
    case "pickup":
      _id_38CC1DC20C14E9D0 = 1;
      break;
  }

  if(_id_38CC1DC20C14E9D0)
    return 1;

  return 0;
}

can_use_munition(slot) {
  if(self.munition_slots[slot].ref == "juggernaut" && istrue(self.isjuggernaut))
    return 0;

  if(self.munition_slots[slot].ref == "ac130" && istrue(level.gunshipinuse))
    return 0;

  if(self getcurrentweapon().basename == "tac_cover_mp")
    return 0;

  if(istrue(self.munition_slots[slot].can_use))
    return 1;

  return 0;
}

remove_munition(slot, _id_A7F7342ABACA0E34) {
  remove_munition_from_array(slot, _id_A7F7342ABACA0E34);
  _id_1DD5348E4E741473 = "none";

  if(slot == 0) {
    _id_1DD5348E4E741473 = "empty1";
    self setplayerdata("cp", "alienSession", "escapedRank0", 0);
  } else if(slot == 1) {
    _id_1DD5348E4E741473 = "empty2";
    self setplayerdata("cp", "alienSession", "escapedRank1", 0);
  } else if(slot == 2) {
    _id_1DD5348E4E741473 = "empty3";
    self setplayerdata("cp", "alienSession", "escapedRank2", 0);
  }

  give_munition_to_slot(_id_1DD5348E4E741473, slot);
  _id_A64C51188D789C25 = "cp_munition_1_timer";

  switch (slot) {
    case 0:
      _id_A64C51188D789C25 = "cp_munition_1_timer";
      break;
    case 1:
      _id_A64C51188D789C25 = "cp_munition_2_timer";
      break;
    case 2:
      _id_A64C51188D789C25 = "cp_munition_3_timer";
      break;
    case 3:
      _id_A64C51188D789C25 = "cp_munition_4_timer";
      break;
  }

  self setclientomnvar(_id_A64C51188D789C25, 0);
  check_for_empty_munitions();
  assign_highest_full_slot_to_active();
  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(isDefined(checkpoint) && checkpoint != "" && isDefined(self.pers["last_checkpoint"]) && self.pers["last_checkpoint"] != checkpoint)
    thread _id_12E2FB553EC1605E::_id_7DA7BD24B280D295();
}

check_for_empty_munitions() {
  munition_slots_full = 0;
  _id_B8BA56B9EDD59CB7 = self getplayerdata("cp", "inventorySlots", "totalSlots");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B8BA56B9EDD59CB7; _id_AC0E594AC96AA3A8++) {
    if(isDefined(self.munition_slots) && isDefined(self.munition_slots[_id_AC0E594AC96AA3A8])) {
      if(!scripts\cp\loot_system::is_empty_or_none(_id_AC0E594AC96AA3A8))
        munition_slots_full = munition_slots_full + 1;
    }
  }

  self.munition_slots_full = munition_slots_full;
  self setclientomnvar("cp_munition_slots_full", munition_slots_full);
}

_id_346CDE477A4FEF90(_id_5A8F1ACCEC64DC4A) {
  _id_AC0E594AC96AA3A8 = 0;

  foreach(slot in self.munition_slots) {
    if(slot.ref == _id_5A8F1ACCEC64DC4A)
      return _id_AC0E594AC96AA3A8;

    _id_AC0E594AC96AA3A8++;
  }

  return undefined;
}

assign_highest_full_slot_to_active() {
  _id_E06CAB62A254CE40 = 0;

  for(_id_AC0E594AC96AA3A8 = self.munition_slots.size - 1; _id_AC0E594AC96AA3A8 > -1; _id_AC0E594AC96AA3A8--) {
    if(!scripts\cp\loot_system::is_empty_or_none(_id_AC0E594AC96AA3A8)) {
      self.dpad_selection_index = _id_AC0E594AC96AA3A8;
      break;
    } else
      _id_E06CAB62A254CE40 = _id_E06CAB62A254CE40 + 1;
  }

  if(_id_E06CAB62A254CE40 == self.munition_slots.size)
    self.dpad_selection_index = 0;

  update_lua_inventory_slot(self.dpad_selection_index);
}

assign_lowest_full_slot_to_active() {
  _id_E06CAB62A254CE40 = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.munition_slots.size; _id_AC0E594AC96AA3A8++) {
    if(!scripts\cp\loot_system::is_empty_or_none(_id_AC0E594AC96AA3A8)) {
      self.dpad_selection_index = _id_AC0E594AC96AA3A8;
      break;
    } else
      _id_E06CAB62A254CE40 = _id_E06CAB62A254CE40 + 1;
  }

  if(_id_E06CAB62A254CE40 == self.munition_slots.size)
    self.dpad_selection_index = 0;

  update_lua_inventory_slot(self.dpad_selection_index);
}

has_munition(_id_5940A3AC5C0C822C) {
  foreach(slot in self.munition_slots) {
    if(slot.ref == _id_5940A3AC5C0C822C)
      return 1;
  }

  return 0;
}

give_munition_to_slot(_id_A7F7342ABACA0E34, slot, source, _id_E2C50DA23374B895) {
  _id_B8BA56B9EDD59CB7 = update_total_slots(slot);
  player = self;

  if(!isDefined(slot))
    slot = _id_B8BA56B9EDD59CB7 - 1;

  if(!isDefined(_id_E2C50DA23374B895))
    _id_E2C50DA23374B895 = 1;

  if(!isDefined(self.munition_slots) || !isDefined(self.munition_slots[slot]))
    self.munition_slots[slot] = spawnStruct();

  self.munition_slots[slot].ref = _id_A7F7342ABACA0E34;
  self.munition_slots[slot].cooldown = level.munitions_table_data[self.munition_slots[slot].ref].cooldown;
  self.munition_slots[slot].can_use = 1;
  self.munition_slots[slot].cooldown_progress = 1;

  if(isDefined(source)) {
    self.munition_slots[slot].source = source;

    if(isDefined(self.munition_slots[slot].source) && munition_source_getridof(self.munition_slots[slot].source)) {
      if(slot == 0)
        self setplayerdata("cp", "alienSession", "escapedRank0", 1);
      else if(slot == 1)
        self setplayerdata("cp", "alienSession", "escapedRank1", 1);
      else if(slot == 2)
        self setplayerdata("cp", "alienSession", "escapedRank2", 1);
    }
  }

  if(_id_A7F7342ABACA0E34 == "none") {
    if(isDefined(self.munition_slots[slot].source))
      self.munition_slots[slot].source = undefined;
  }

  _id_B8BA56B9EDD59CB7 = self getplayerdata("cp", "inventorySlots", "totalSlots");
  omnvar = undefined;
  _id_F7B6CC6C062A7A43 = player check_for_gl_proj_override(_id_A7F7342ABACA0E34);

  if(!istrue(self.munition_splash_supress))
    _id_F7B6CC6C062A7A43 = "cp_" + _id_F7B6CC6C062A7A43;

  player thread scripts\cp\cp_hud_message::showsplash(_id_F7B6CC6C062A7A43, undefined, self);

  switch (slot) {
    case 0:
      omnvar = "cp_munition_slot_1";
      player thread cooldown_munition("munition_1_used", "cp_munition_1_timer", player, player.munition_slots[0].ref, player.munition_slots[0].cooldown, 0, 1);
      break;
    case 1:
      omnvar = "cp_munition_slot_2";
      player thread cooldown_munition("munition_2_used", "cp_munition_2_timer", player, player.munition_slots[1].ref, player.munition_slots[1].cooldown, 1, 1);
      break;
    case 2:
      omnvar = "cp_munition_slot_3";
      player thread cooldown_munition("munition_3_used", "cp_munition_3_timer", player, player.munition_slots[2].ref, player.munition_slots[2].cooldown, 2, 1);
      break;
    case 3:
      omnvar = "cp_munition_slot_4";
      player thread cooldown_munition("munition_4_used", "cp_munition_4_timer", player, player.munition_slots[3].ref, player.munition_slots[3].cooldown, 3, 1);
      break;
  }

  index = level.munitions_table_data[player.munition_slots[slot].ref].index;

  if(isDefined(omnvar) && isDefined(index))
    player setclientomnvar(omnvar, index);

  if(istrue(_id_E2C50DA23374B895) && getdvarint("dvar_210D16E93F2436F5", 0) == 0)
    player thread _id_E338AED54411D148();

  if(isDefined(player.munition_slots_full) && player.munition_slots_full == 0)
    player check_for_empty_munitions();

  player _meth_B1E64D364CF55B73(player has_munition("nvg"));
}

_id_D3E4275CA1BC1207() {
  self notify("nag_munitions");
}

_id_E338AED54411D148() {
  self notify("nag_munitions");
  self endon("nag_munitions");
  self endon("disconnect");
  wait 12;

  if(getdvarint("dvar_6978B3F150582C40", 1))
    self notify("nag_munitions");

  count = 0;

  while(count < 2) {
    if(istrue(self._id_7269DEEBA689CD65)) {
      self clearhudtutorialmessage();
      wait 5;
      return;
    }

    if(!_id_0AFB7E332AEE4BF2::player_in_laststand(self)) {
      if(!_id_9E1FF2E695FD901D())
        scripts\cp\cp_hud_message::tutorialprint(&"COOP_GAME_PLAY/USE_MUNITION_NAG", 2);
      else
        return;

      count++;
      wait 30;
      continue;
    }

    count++;
    wait 30;
  }
}

_id_9E1FF2E695FD901D() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.munition_slots.size; _id_AC0E594AC96AA3A8++) {
    if(!scripts\cp\loot_system::is_empty_or_none(_id_AC0E594AC96AA3A8))
      return 0;
  }

  return 1;
}

_id_50BE8ABFE68DDBFC() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.munition_slots.size; _id_AC0E594AC96AA3A8++) {
    if(scripts\cp\loot_system::is_empty_or_none(_id_AC0E594AC96AA3A8))
      return 1;
  }

  return 0;
}

update_total_slots(slot) {
  if(!isDefined(slot))
    slot = 5;

  _id_B8BA56B9EDD59CB7 = self getplayerdata("cp", "inventorySlots", "totalSlots");

  if(slot >= _id_B8BA56B9EDD59CB7 && _id_B8BA56B9EDD59CB7 < 4)
    _id_B8BA56B9EDD59CB7 = _id_B8BA56B9EDD59CB7 + 1;

  self setplayerdata("cp", "inventorySlots", "totalSlots", _id_B8BA56B9EDD59CB7);
  return _id_B8BA56B9EDD59CB7;
}

check_for_gl_proj_override(_id_A7F7342ABACA0E34) {
  player = self;

  if(_id_A7F7342ABACA0E34 == "grenade_launcher" && isDefined(player.gl_proj_override))
    return player.gl_proj_override + "_proj";

  return _id_A7F7342ABACA0E34;
}

remove_munitions_in_radius(org, radius, _id_7C64E39970C639FA) {
  _id_1A96B3062BB2C598 = radius * radius;
  _id_AF6D3CFEC354E8E9 = 20;

  if(isDefined(_id_7C64E39970C639FA))
    _id_AF6D3CFEC354E8E9 = _id_7C64E39970C639FA;

  _id_7507F409FEE2B657 = ["brloot_munition", "brloot_munition_airdrop", "brloot_munition_ammo", "brloot_munition_armor", "brloot_munition_c4_launcher", "brloot_munition_cluster_strike", "brloot_munition_cruise_missile", "brloot_munition_cruise_predator", "brloot_munition_deployable_cover", "brloot_munition_grenade_crate", "brloot_munition_grenade_launcher", "brloot_munition_juggernaut", "brloot_munition_precision_airstrike", "brloot_munition_thermite_launcher", "brloot_munition_trophysystem", "brloot_munition_turret", "brloot_munition_uav", "brloot_munition_white_phos"];

  foreach(name in _id_7507F409FEE2B657) {
    _id_792740C4C87CF9FA = getentitylessscriptablearray(undefined, undefined, org, radius, name);
    count = 0;

    foreach(_id_31F869647E8740B4 in _id_792740C4C87CF9FA) {
      _id_31F869647E8740B4 setscriptablepartstate(name, "hidden");
      count++;

      if(count % _id_AF6D3CFEC354E8E9)
        wait 0.1;
    }

    wait 0.1;
  }
}

remove_munitions_globally(_id_1D88CBBB14926330) {
  _id_7507F409FEE2B657 = ["brloot_munition", "brloot_munition_airdrop", "brloot_munition_ammo", "brloot_munition_armor", "brloot_munition_c4_launcher", "brloot_munition_cluster_strike", "brloot_munition_cruise_missile", "brloot_munition_cruise_predator", "brloot_munition_deployable_cover", "brloot_munition_grenade_crate", "brloot_munition_grenade_launcher", "brloot_munition_juggernaut", "brloot_munition_precision_airstrike", "brloot_munition_thermite_launcher", "brloot_munition_trophysystem", "brloot_munition_turret", "brloot_munition_uav", "brloot_munition_white_phos"];

  if(isDefined(_id_1D88CBBB14926330))
    _id_7507F409FEE2B657 = _id_1D88CBBB14926330;

  foreach(name in _id_7507F409FEE2B657) {
    _id_53DB3AFB46EA6459 = getentitylessscriptablearray(undefined, undefined, undefined, undefined, name);

    foreach(_id_31F869647E8740B4 in _id_53DB3AFB46EA6459)
    _id_31F869647E8740B4 setscriptablepartstate(name, "hidden");

    wait 0.1;
  }
}

givegrenadelauncher() {
  self.last_weapon = self getcurrentweapon();

  if(istrue(self.has_gl)) {
    _id_C4ADB5B8C25725B6 = self.equippedweapons;

    foreach(gun in _id_C4ADB5B8C25725B6) {
      if(gun.basename == "iw9_la_mike32_mp") {
        _id_1903A4E1B4C39DE1 = weaponclipsize(gun);
        self setweaponammoclip(gun, _id_1903A4E1B4C39DE1);
      }
    }
  } else {
    _id_37EDE289A37EF621 = "iw9_la_mike32_mp";
    gun = _id_2669878CF5A1B6BC::buildweapon(_id_37EDE289A37EF621);
    self giveweapon(gun);
    _id_1903A4E1B4C39DE1 = weaponclipsize(gun);
    self setweaponammoclip(gun, _id_1903A4E1B4C39DE1);
    self setweaponammostock(gun, 0);
    self switchtoweapon(gun);
    self.has_gl = 1;
    _id_3B64EB40368C1450::set("give_grenade_launcher", "weapon_pickup", 0);
    scripts\cp\utility::_id_4CBAED764C116A25(1);
    self._id_74A98FC784D043A0 = self.disable_munitions;
    self.disable_munitions = 1;
    thread remove_at_ammo_count(gun.basename, 0);
  }

  self notify("munitions_used", "grenade_launcher");
}

_id_0DD25D8D11ACB070() {
  wait 1;
  self waittill("weapon_switch_started");
  self.has_gl = undefined;
}

remove_at_ammo_count(weapon_name, ammo_count) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("weapon_removed");
  childthread _id_0DD25D8D11ACB070();
  weapon = undefined;
  list = self getweaponslist("primary");

  foreach(_id_DE88CD14114C1E24 in list) {
    if(_id_DE88CD14114C1E24.basename == weapon_name) {
      weapon = _id_DE88CD14114C1E24;
      break;
    }
  }

  if(isDefined(weapon)) {
    for(;;) {
      _id_337043BBA3301B3C = self getammocount(weapon);

      if(_id_337043BBA3301B3C <= ammo_count) {
        break;
      }

      if(!isDefined(self.has_gl)) {
        break;
      }

      waitframe();
    }

    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("give_grenade_launcher");
    scripts\cp\utility::_id_4CBAED764C116A25(0);

    if(isDefined(self._id_74A98FC784D043A0)) {
      self.disable_munitions = self._id_74A98FC784D043A0;
      self._id_74A98FC784D043A0 = undefined;
    } else
      self.disable_munitions = 0;

    self takeweapon(weapon);
    _id_929E81472980EC28 = scripts\cp\utility::getweapontoswitchbackto();
    success = thread scripts\cp\cp_weapons::switchtoweaponreliable(_id_929E81472980EC28, 0);
    self.has_gl = undefined;
    self notify("weapon_removed", "grenade_launcher");
  }
}

giveitembasedoncraftingstruct(crafteditem) {
  _id_B03E56D696A8AA7E = 1;
  self._id_7269DEEBA689CD65 = 1;

  switch (crafteditem) {
    case "respawn":
      self iprintln(" RESPAWN SYSTEM IS DEPRECATED. ");
      break;
    case "apache":
    case "chopper_gunner":
      if(istrue(level.no_aerial_munitions) || scripts\cp\cp_objectives::is_objective_active("collect_nuclear_core") || scripts\cp\cp_objectives::is_objective_active("exfil_plane")) {
        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return 0;
      }

      if(_id_74502A9E0EF1F19C::player_has_minigun(self)) {
        _id_74502A9E0EF1F19C::drop_minigun(self);
        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return 0;
      }

      scripts\cp_mp\killstreaks\chopper_gunner::tryusechoppergunner();
      break;
    case "ammo_crate":
      success = giveammocrate();

      if(!istrue(success))
        return 0;

      break;
    case "munitions_crate":
      success = _id_D4D986DBFA3F3AB1();

      if(!istrue(success))
        return 0;

      break;
    case "ac130":
      if(istrue(level.no_aerial_munitions) || scripts\cp\cp_objectives::is_objective_active("collect_nuclear_core") || scripts\cp\cp_objectives::is_objective_active("exfil_plane")) {
        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return 0;
      }

      if(isDefined(level.ac130_activate_function)) {
        self notify("attempt_use_gunship");
        success = self[[level.ac130_activate_function]]();

        if(!istrue(success))
          return 0;
      }

      break;
    case "precision_airstrike":
      if(istrue(level.no_aerial_munitions) || scripts\cp\cp_objectives::is_objective_active("collect_nuclear_core") || scripts\cp\cp_objectives::is_objective_active("exfil_plane")) {
        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return 0;
      }

      scripts\cp_mp\killstreaks\airstrike::tryuseairstrike("precision_airstrike");
      break;
    case "juggernaut":
      scripts\cp_mp\killstreaks\juggernaut::tryusejuggernaut(1);
      break;
    case "assault_suit":
      scripts\cp_mp\killstreaks\juggernaut::tryusejuggernaut(1, 1);
      break;
    case "cruise_missile":
    case "drone_strike":
      if(istrue(level.no_aerial_munitions) || scripts\cp\cp_objectives::is_objective_active("collect_nuclear_core") || scripts\cp\cp_objectives::is_objective_active("exfil_plane")) {
        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return 0;
      }

      result = scripts\cp_mp\killstreaks\cruise_predator::tryusecruisepredator();

      if(istrue(result)) {
        break;
      } else
        return 0;
    case "scout_drone":
      if(scripts\cp\cp_objectives::is_objective_active("collect_nuclear_core") || scripts\cp\cp_objectives::is_objective_active("exfil_plane")) {
        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return 0;
      }

      scripts\cp_mp\killstreaks\helper_drone::tryusehelperdrone("radar_drone_recon");
      _id_189B67B2735B981D::_id_55B08D6D71B41402(self, "activate_drone");
      break;
    case "riot_shield":
      _id_B03E56D696A8AA7E = 0;
      self notify("one_watcher_for_removing_deployables");
      giveriotshield();
      _id_189B67B2735B981D::_id_55B08D6D71B41402(self, "killstreak_used");
      break;
    case "grenade_launcher":
      _id_B03E56D696A8AA7E = 0;
      self notify("one_watcher_for_removing_deployables");
      givegrenadelauncher();
      _id_189B67B2735B981D::_id_55B08D6D71B41402(self, "killstreak_used");
      break;
    case "armor":
      success = givearmorcrate();

      if(!istrue(success))
        return 0;

      _id_189B67B2735B981D::_id_55B08D6D71B41402(self, "killstreak_used");
      break;
    case "manual_turret":
      if(!istrue(self.bgivensentry))
        scripts\cp_mp\killstreaks\manual_turret::tryusemanualturret("manual_turret");

      break;
    case "sentry_turret":
    case "sentry":
      if(!istrue(self.bgivensentry))
        scripts\cp_mp\killstreaks\sentry_gun::tryusesentryturret("sentry_gun");

      break;
    case "uav":
      if(istrue(level.no_aerial_munitions) || scripts\cp\cp_objectives::is_objective_active("collect_nuclear_core") || scripts\cp\cp_objectives::is_objective_active("exfil_plane")) {
        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return 0;
      }

      success = scripts\cp_mp\killstreaks\uav::tryuseuav("uav");

      if(success)
        _id_189B67B2735B981D::_id_55B08D6D71B41402(self, "activate_uav");

      return success;
    case "deployable_cover":
      success = give_deployable_cover();

      if(!istrue(success))
        return 0;

      _id_189B67B2735B981D::_id_55B08D6D71B41402(self, "killstreak_used");
      break;
    case "cluster_spike":
      success = _id_10AD6174C8938599::_id_43FCF054875C96C5();

      if(!istrue(success))
        return 0;

      break;
    case "auto_drone":
      scripts\cp_mp\utility\killstreak_utility::starttabletscreen("auto_drone", 0.05);
      success = _id_0B6E69AC53E6EE66::_id_F5488EBDAE28A1D8();

      if(!istrue(success)) {
        thread scripts\cp_mp\utility\killstreak_utility::tabletdofset(1, 1);
        return 0;
      }

      break;
    case "cluster_strike":
    case "toma_strike":
      if(istrue(level.no_aerial_munitions) || scripts\cp\cp_objectives::is_objective_active("collect_nuclear_core") || scripts\cp\cp_objectives::is_objective_active("exfil_plane")) {
        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return 0;
      }

      scripts\cp_mp\killstreaks\toma_strike::tryusetomastrike();
      break;
    case "nvg":
      thread scripts\cp\equipment\nvg::runnvg();
      break;
    case "trophysystem":
      self giveandfireoffhand("trophy_cp");
      _id_189B67B2735B981D::_id_55B08D6D71B41402(self, "killstreak_used");
      break;
    case "white_phos":
      scripts\cp_mp\killstreaks\white_phosphorus::tryusewpfromstruct("white_phosphorus");
      break;
    case "hover_jet":
      scripts\cp_mp\utility\killstreak_utility::starttabletscreen("hover_jet", 0.75);
      success = _id_1EDDEC53ABF6E24C::tryusehoverjet();

      if(!istrue(success))
        return 0;

      self notify("munitions_used", "hover_jet");
      break;
    case "chopper_support":
      success = scripts\cp_mp\killstreaks\chopper_support::tryusechoppersupport("chopper_support");

      if(!istrue(success))
        return 0;

      self notify("munitions_used", "chopper_support");
      break;
    case "assault_drone":
      success = _id_249F45D992AF1114::_id_E24EF5600F59548E();

      if(!istrue(success))
        return 0;

      _id_189B67B2735B981D::_id_55B08D6D71B41402(self, "activate_drone");
      break;
    case "recon_drone":
      if(istrue(level.no_aerial_munitions)) {
        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return 0;
      }

      success = _id_6D68CFDF0836123C::_id_57FD8A7006975CD6();

      if(!istrue(success))
        return 0;

      _id_189B67B2735B981D::_id_55B08D6D71B41402(self, "activate_drone");
      break;
  }

  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(isDefined(checkpoint) && checkpoint != "" && isDefined(self.pers["last_checkpoint"]) && self.pers["last_checkpoint"] != checkpoint)
    thread _id_12E2FB553EC1605E::_id_7DA7BD24B280D295();

  if(_id_B03E56D696A8AA7E)
    thread watcherforremovingdeployable();

  return 1;
}

watcherforremovingdeployable() {
  self notify("one_watcher_for_removing_deployables");
  self endon("one_watcher_for_removing_deployables");

  for(;;) {
    self waittill("remove_any_active_items");

    if(isDefined(self.last_weapon)) {
      _id_929E81472980EC28 = scripts\cp\utility::getweapontoswitchbackto();
      self switchtoweapon(_id_929E81472980EC28);
      self.last_weapon = undefined;
      scripts\cp\utility::clearlowermessage("crate_prompt");
    }
  }
}

givearmorcrate() {
  return give_deployable_crate("iw8_armor_marker_cp");
}

giveammocrate() {
  return give_deployable_crate("iw8_ammo_marker_cp");
}

_id_D4D986DBFA3F3AB1() {
  return give_deployable_crate("iw8_ammo_marker_cp");
}

give_deployable_crate(_id_E91C88DE8CB8AFB9) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("last_stand");
  objweapon = makeweapon(_id_E91C88DE8CB8AFB9);

  if(!istrue(scripts\cp_mp\utility\weapon_utility::_id_F19F8B4CF085ECBD(objweapon))) {
    self.super_activated = 0;
    _id_56EF8D52FE1B48A1::_id_C5EA07DAC9D83685();
    clientnum = self getentitynumber();
    setomnvar("ui_class_power_reloading", clientnum);
    _id_89656F67C2EA228D = 0.2;
    thread _id_8F741E1E8E870100(_id_89656F67C2EA228D, 975);
    _id_56EF8D52FE1B48A1::superusefinished();
    _id_56EF8D52FE1B48A1::setsuperisinuse(0);
    return undefined;
  }

  msg = scripts\engine\utility::waittill_any_return_6("offhand_fired", "weapon_fired", "offhand_end", "weapon_change", "weapon_gesture_failed", "offhand_pullback");
  self.super_activated = 0;
  _id_56EF8D52FE1B48A1::_id_C5EA07DAC9D83685();
  clientnum = self getentitynumber();
  setomnvar("ui_class_power_reloading", clientnum);

  if(msg == "offhand_pullback" || msg == "weapon_change" || msg == "weapon_gesture_failed") {
    _id_89656F67C2EA228D = 0.2;
    thread _id_8F741E1E8E870100(_id_89656F67C2EA228D, 975);
    _id_56EF8D52FE1B48A1::superusefinished();
    _id_56EF8D52FE1B48A1::setsuperisinuse(0);
    return undefined;
  }

  _id_56EF8D52FE1B48A1::setsuperisinuse(0);
  _id_189B67B2735B981D::_id_55B08D6D71B41402(self, "equipment_deployed");
  return 1;
}

_id_8F741E1E8E870100(_id_89656F67C2EA228D, _id_4EEDBC067A81F686) {
  wait(_id_89656F67C2EA228D);
  _id_56EF8D52FE1B48A1::increase_super_progress(_id_4EEDBC067A81F686);
}

giveriotshield() {
  self.riot_shield_damage = 1000;
  self.last_weapon = self getcurrentweapon();

  if(!istrue(self.has_riot_shield)) {
    gun = "iw9_me_riotshield_mp";
    shield = makeweapon(gun);
    scripts\cp\utility::_giveweapon(shield);
    scripts\cp\cp_weapons::switchtoweaponreliable(shield);
    self.has_riot_shield = 1;
    thread remove_at_shield_death(gun, 0);
  }

  self notify("munitions_used", "riot_shield");
}

remove_at_shield_death(weapon_name, _id_946A167E53DA62ED) {
  level endon("game_ended");
  self endon("disconnect");
  weapon = undefined;
  list = self getweaponslist("primary");

  foreach(_id_DE88CD14114C1E24 in list) {
    if(_id_DE88CD14114C1E24.basename == weapon_name) {
      weapon = _id_DE88CD14114C1E24;
      break;
    }
  }

  if(isDefined(weapon)) {
    while(self.riot_shield_damage > _id_946A167E53DA62ED)
      waitframe();

    self.riot_shield_broken = 1;

    if(isDefined(self.riotshieldmodel))
      scripts\cp\utility::riotshield_detach(1);
    else if(isDefined(self.riotshieldmodelstowed))
      scripts\cp\utility::riotshield_detach(0);

    wait 1;
    self takeweapon(weapon);
    self switchtoweapon(self.last_weapon);
    self.has_riot_shield = undefined;
    self.riot_shield_broken = undefined;
  }
}

givemunitionfromluinotify() {
  self endon("disconnect");
  level endon("game_ended");
  self.dpad_selection_index = 0;
  _id_B00605B9047D7F4B = 4;
  _id_B8BA56B9EDD59CB7 = 4;

  if(istrue(level.unlimitedmunitions))
    _id_B8BA56B9EDD59CB7 = 1;

  self setplayerdata("cp", "inventorySlots", "totalSlots", _id_B8BA56B9EDD59CB7);

  for(;;) {
    self waittill("luinotifyserver", _id_7148C1A6F25491F8, val);

    if(_id_7148C1A6F25491F8 == "radial_menu_munition") {
      _id_D3E4275CA1BC1207();
      _id_401C3A2E68AAB0FD = 0;

      if(!player_can_use_munitions(_id_401C3A2E68AAB0FD)) {
        continue;
      }
      if(val >= 0 && val <= 2) {
        _id_A7F7342ABACA0E34 = self.munition_slots[val];

        if(isDefined(_id_A7F7342ABACA0E34) && _id_A7F7342ABACA0E34.ref != "none" && _id_A7F7342ABACA0E34.ref != "empty1" && _id_A7F7342ABACA0E34.ref != "empty2" && _id_A7F7342ABACA0E34.ref != "empty3") {
          if(istrue(can_use_munition(val))) {
            thread remove_munition_on_use(_id_A7F7342ABACA0E34.ref, val);
            success = giveitembasedoncraftingstruct(_id_A7F7342ABACA0E34.ref);

            if(success) {
              if(is_instant_use_munition(_id_A7F7342ABACA0E34.ref))
                self notify("munitions_used", _id_A7F7342ABACA0E34.ref);

              scripts\cp\cp_analytics::logevent_munitionused(self, _id_A7F7342ABACA0E34.ref);
            } else
              self notify("remove_munition_on_use");
          }
        }
      }
    }
  }
}

give_deployable_cover() {
  if(self isthrowinggrenade()) {
    return;
  }
  self.prev_weapon_taccover = self getcurrentprimaryweapon();
  gun = "tac_cover_mp";
  self giveweapon(gun);
  self switchtoweapon(gun);
  self notifyonplayercommand("equip_deploy_end", "+weapnext");
  self notifyonplayercommand("equip_deploy_end", "+weapprev");
  self notifyonplayercommand("equip_deploy_end", "+actionslot 4");

  if(!self isconsoleplayer()) {
    self notifyonplayercommand("equip_deploy_end", "+actionslot 5");
    self notifyonplayercommand("equip_deploy_end", "+actionslot 6");
    self notifyonplayercommand("equip_deploy_end", "+actionslot 7");
  }

  _id_3B64EB40368C1450::set("deployable_cover", "melee", 0);
  success = fire_deployable_cover();

  if(istrue(success))
    return 1;
  else
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("deployable_cover");

  return undefined;
}

fire_deployable_cover() {
  self endon("equip_deploy_end");
  self endon("last_stand");
  self endon("death_or_disconnect");
  grenade = _id_74502A9E0EF1F19C::waittill_grenade_fire();

  if(isDefined(grenade.weapon_name) && grenade.weapon_name == "tac_cover_mp") {
    success = scripts\cp\powers\cp_tactical_cover::tac_cover_on_fired_super();

    if(istrue(success)) {
      thread scripts\cp\powers\cp_tactical_cover::tac_cover_used(grenade);
      _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("deployable_cover");

      foreach(player in level.players)
      player thread scripts\cp\cp_hud_message::showsplash("cp_used_deployable_cover", undefined, self);

      self notify("munitions_used", "deployable_cover");
      return 1;
    }
  }

  self notify("deploy_cover_failed");
  return undefined;
}
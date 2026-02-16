/****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\s4_armory_kiosk.gsc
****************************************************/

init() {
  _id_07A1::_id_CECC(level._id_CAB3, ::_id_1B86);
  _id_0A9A::_id_C287(::_id_AA71);
  _id_0C8C();
}

_id_8278() {
  if(getdvarint("#x3551c0c650583db54", 0) == 0) {
    return;
  }
  level waittill("prematch_done");
  var_0 = scripts\engine\utility::getStructArray("base_grid_anchor", "targetname");

  foreach(var_2 in level._id_A8E8) {
    var_3 = _id_696D(var_2, var_0);
    var_2._id_10318 = spawn("trigger_radius", var_3.origin, 0, 5, 10);
    var_2 thread _id_8E05();
  }
}

_id_696D(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in var_1) {
    if(!isDefined(var_2)) {
      var_2 = var_5;
      var_3 = distancesquared(var_0.origin, var_5.origin);
      continue;
    }

    var_6 = distancesquared(var_0.origin, var_5.origin);

    if(var_6 < var_3) {
      var_2 = var_5;
      var_3 = distancesquared(var_0.origin, var_5.origin);
      continue;
    }
  }

  return var_2;
}

_id_8E05() {
  self._id_10318 notify("end_duplicate_interact");
  self._id_10318 endon("end_duplicate_interact");
  level endon("game_ended");
  var_0 = self._id_10318;

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isPlayer(var_1) || !scripts\mp\utility\player::isreallyalive(var_1)) {
      continue;
    }
    if(!isDefined(self._id_ADAE) || self._id_ADAE != var_1.team) {
      continue;
    }
    if(isDefined(var_1._id_22A2)) {
      continue;
    }
    if(var_1 _meth_81E0()) {
      var_1 cancelreload();
    }

    var_1 thread _id_0CCB(var_0);
  }
}

_id_0C8C() {
  level._id_CAB4 = getDvar("#x365c055cc86f97665", "");

  if(!isDefined(level._id_CAB4) || level._id_CAB4 == "") {
    level._id_CAB4 = "mp/s4baseKioskPurchases.csv";
  }

  level._id_229D = spawnStruct();
  level._id_229D._id_8B38 = [];
  var_0 = tablelookupgetnumrows(level._id_CAB4);

  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_2 = int(tablelookupbyrow(level._id_CAB4, var_1, 0));
    var_3 = spawnStruct();
    var_3.index = int(tablelookupbyrow(level._id_CAB4, var_1, 0));
    var_3.type = tablelookupbyrow(level._id_CAB4, var_1, 1);
    var_3._id_C189 = tablelookupbyrow(level._id_CAB4, var_1, 2);
    var_3._id_3D91 = int(tablelookupbyrow(level._id_CAB4, var_1, 3));
    level._id_229D._id_8B38[var_2] = var_3;
  }
}

_id_0CCB(var_0) {
  var_1 = self;
  level endon("game_ended");
  var_1 endon("disconnect");
  var_1 endon("death");
  var_1._id_22A2 = var_0;

  if(scripts\mp\gametypes\br_public::_id_878D()) {
    var_1 notify("kiosk_used");
  }

  if(scripts\engine\utility::is_equal(scripts\mp\utility\game::getgametype(), "base") && isDefined(var_0.type) && issubstr(var_0.type, "vehicle")) {
    var_1 scripts\mp\gametypes\s4_base_util::motorcycle_monitor_summonability();
  }

  setomnvar("ui_arena_evo_killstreak_max_flamethrowers", int(scripts\mp\gametypes\arena_evo_tourney_loot::arenatournament_at_max_flamenauts()));
  var_1 setclientomnvar("ui_arena_evo_killstreak_max_uavs", int(scripts\mp\gametypes\arena_evo_tourney_loot::arenatournament_at_max_uavs(var_1.pers["team"])));
  var_1 setclientomnvar("ui_base_purchase_menu_response", 0);

  if(isDefined(var_0._id_AC30)) {
    var_1 setclientomnvar("ui_base_open_purchase_menu", var_0._id_AC30);
  } else {
    var_1 setclientomnvar("ui_base_open_purchase_menu", 1);
  }

  var_1._id_1B85 = 1;
  var_1 thread _id_0DD6(var_0);
}

_id_0BA1(var_0) {
  var_1 = self;
  var_1 setclientomnvar("ui_base_purchase_menu_response", var_0);
  var_1 setclientomnvar("ui_base_open_purchase_menu", 0);
  var_1._id_22A2 = undefined;
  var_1._id_1B85 = undefined;

  if(scripts\mp\utility\game::_id_875D() || scripts\mp\utility\game::isbasegametype()) {
    if(isDefined(var_1.buysplashqueue) && (!istrue(level._id_CA43) || !istrue(level._id_BB9D))) {
      foreach(var_3 in var_1.buysplashqueue) {
        var_1 thread scripts\mp\hud_message::showsplash("item_purchased", var_3);
      }
    }

    var_1.buysplashqueue = [];
  }
}

_id_0CA4(var_0) {
  var_0 _id_0BA1(0);
  var_0 notify("_watchToAutoCloseMenu_end");
}

_id_0CA3(var_0) {
  var_1 = self;
  var_2 = 64;
  var_3 = getdvarfloat("#x3606767d938d99dae", 128) + var_2;
  var_4 = var_3 * var_3;

  for(;;) {
    wait 0.1;
    var_5 = distancesquared(var_1.origin, var_0.origin);

    if(var_5 > var_4) {
      var_1 notify("pushed_too_far");
      break;
    }
  }
}

_id_0DD6(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_1 notify("_watchToAutoCloseMenu_end");
  var_1 endon("_watchToAutoCloseMenu_end");
  var_1 childthread _id_0CA3(var_0);
  scripts\engine\utility::_id_10888(var_1, "death", var_1, "last_stand_start", var_1, "pushed_too_far", level, "game_ended");
  var_1 _id_0BA1(2);
}

_id_0C19(var_0, var_1, var_2) {}

_id_0C00(var_0) {
  var_1 = self;

  if(scripts\mp\utility\game::_id_875D() || scripts\mp\utility\game::isbasegametype()) {
    if(var_0.type == "weapon" && scripts\mp\gametypes\arena_evo_tourney_loot::_id_1AD5(var_0._id_C189)) {
      return 0;
    }
  }

  return var_0._id_3D91;
}

_getloadoutcostforplayer(var_0, var_1) {
  var_2 = self;

  if(!isDefined(var_2.loadoutspurchased)) {
    var_2.loadoutspurchased = 0;
  }

  if(var_2.loadoutspurchased & 1 << var_1) {
    return 0;
  }

  return var_0._id_3D91;
}

_id_0C1A(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = var_3 _id_0C00(var_0);
  var_3 _id_0C5A(var_4);

  if(scripts\mp\utility\game::_id_875D() || scripts\mp\utility\game::isbasegametype()) {
    if(scripts\mp\utility\game::_id_875D()) {
      scripts\mp\gametypes\arena_evo_tourney_loot::_id_0EBF(var_3, var_0._id_C189);
    }

    if(scripts\mp\utility\game::isbasegametype()) {
      scripts\mp\gametypes\s4_base_loot::_id_0EBF(var_3, var_0._id_C189);
    }

    if(var_4 > 0 || var_0._id_C189 == "equip_frag") {
      if(!isDefined(var_3.buysplashqueue)) {
        var_3.buysplashqueue = [];
      }

      var_3.buysplashqueue[var_3.buysplashqueue.size] = var_0.index;
    }
  } else if(var_4 > 0)
    var_3 thread scripts\mp\hud_message::showsplash("item_purchased", var_0.index);
}

_handleloadoutpurchase(var_0, var_1) {
  var_2 = self;
  var_3 = var_2 _getloadoutcostforplayer(var_0, var_1 - 1);
  var_2 _id_0C5A(var_3);

  if(scripts\mp\utility\game::isbasegametype()) {
    scripts\mp\gametypes\s4_base_loot::_id_0EBF(var_2, "custom" + var_1);
    var_2 setclientomnvar("ui_base_equipped_loadout", var_1 - 1);

    if(var_3 > 0) {
      if(!isDefined(var_2.buysplashqueue)) {
        var_2.buysplashqueue = [];
      }

      var_2.buysplashqueue[var_2.buysplashqueue.size] = var_0.index;

      if(!isDefined(var_2.loadoutspurchased)) {
        var_2.loadoutspurchased = 0;
      }

      var_2.loadoutspurchased = var_2.loadoutspurchased | 1 << var_1 - 1;
      var_2 setclientomnvar("ui_base_purchased_loadouts", var_2.loadoutspurchased);
    }
  } else if(var_3 > 0)
    var_2 thread scripts\mp\hud_message::showsplash("item_purchased", var_0.index);
}

_id_0C1D(var_0, var_1) {
  var_2 = scripts\engine\utility::getStructArray("vehicle_spawn_node", "targetname");
  var_3 = undefined;
  var_4 = 1000;

  if(isDefined(var_2) && var_2.size > 0) {
    var_5 = [];
    var_2 = scripts\engine\utility::_id_6369(self.origin, var_2, var_5, undefined, var_4);

    for(var_6 = 0; var_6 < var_2.size; var_6++) {
      var_3 = var_2[var_6];

      if(isDefined(var_3)) {
        var_7 = spawnStruct();
        var_7.origin = var_3.origin;
        var_7.angles = var_3.angles;
        var_8 = var_7.origin + (1, 1, 1);
        var_9 = 150;
        var_10 = [];
        var_11 = scripts\engine\trace::_id_3EE5(0, 0, 0, 0, 0, 1, 0, 0, 0);
        var_12 = scripts\engine\trace::_id_E40C(var_7.origin, var_8, var_9, var_10, var_11);

        if(isDefined(var_12[0])) {
          var_5 = scripts\engine\utility::array_add(var_5, var_3);
          continue;
        }

        if(scripts\engine\utility::is_equal(scripts\mp\utility\game::getgametype(), "base")) {
          thread removeexistingvehicle(var_0._id_C189);
        }

        var_13 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle(var_0._id_C189, var_7, undefined);

        if(var_0._id_C189 == "motorcycle") {
          self.motoid = var_13;
        }

        if(var_13._id_1031E == "s4_tank") {
          thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1017E(var_13, "tag_seat_0", self, undefined, 1);
        } else {
          thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1017E(var_13, "driver", self, undefined, 1);
        }

        switch (level.gametype) {
          case "base":
            level._id_1031A = scripts\engine\utility::_id_1B8D(level._id_1031A, var_13);
            break;
        }

        return 1;
      }
    }
  }

  return 0;
}

removeexistingvehicle(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = level.vehicle._id_E09E._id_8301[var_0];

  if(!isDefined(var_1) || var_1.size == 0) {
    return;
  }
  foreach(var_3 in var_1) {
    if(isDefined(var_3.owner) && var_3.owner == self) {
      var_4 = undefined;
      scripts\cp_mp\vehicles\vehicle_occupancy::_id_1017D(var_3);

      switch (var_0) {
        case "open_jeep":
          var_3 thread scripts\cp_mp\vehicles\open_jeep::open_jeep_deletenextframe();
          var_4 = var_3 gettagorigin("tag_origin");
          break;
        case "s4_tank":
          var_3 thread scripts\cp_mp\vehicles\s4_tank::s4_tank_deletenextframe();
          var_4 = var_3 gettagorigin("tag_origin");
          break;
        case "motorcycle":
          var_3 thread scripts\cp_mp\vehicles\motorcycle::motorcycle_deletenextframe();
          var_4 = var_3 gettagorigin("tag_origin");
          break;
      }

      playFX(scripts\engine\utility::getfx(var_0 + "_explode"), var_4, anglesToForward(var_3.angles), anglestoup(var_3.angles));
    }
  }
}

_id_0DB7(var_0, var_1) {
  var_2 = self;

  if(var_2[[level._id_CAB2]]() < var_2 _id_0C00(var_0)) {
    if(scripts\mp\utility\game::_id_875D() || scripts\mp\utility\game::isbasegametype()) {
      var_2 setclientomnvar("ui_base_purchase_menu_response", 3);
    } else {
      var_2 _id_0BA1(3);
    }

    return 0;
  }

  if(var_0.type == "vehicle") {
    var_3 = scripts\engine\utility::getStructArray("vehicle_spawn_node", "targetname");
    var_4 = undefined;
    var_5 = 1000;

    if(var_0._id_C189 == "motorcycle") {
      if(isDefined(self.motoid) && distancesquared(self.origin, self.motoid.origin) < 1000000) {
        return 0;
      }
    }

    if(isDefined(var_3) && var_3.size > 0) {
      var_6 = [];
      var_3 = scripts\engine\utility::_id_6369(self.origin, var_3, var_6, undefined, var_5);

      for(var_7 = 0; var_7 < var_3.size; var_7++) {
        var_4 = var_3[var_7];

        if(isDefined(var_4)) {
          var_8 = spawnStruct();
          var_8.origin = var_4.origin;
          var_8.angles = var_4.angles;
          var_9 = var_8.origin + (1, 1, 1);
          var_10 = 150;
          var_11 = [];
          var_12 = scripts\engine\trace::_id_3EE5(0, 0, 0, 0, 0, 1, 0, 0, 0);
          var_13 = scripts\engine\trace::_id_E40C(var_8.origin, var_9, var_10, var_11, var_12);

          if(isDefined(var_13[0])) {
            var_6 = scripts\engine\utility::array_add(var_6, var_4);
            continue;
          }

          return 1;
        }
      }
    }

    return 0;
  } else if(var_0.type == "fieldupgrade") {
    if(var_2 scripts\mp\supers::_id_8A79()) {
      var_2 _id_0BA1(6);
      return 0;
    }

    if(!istrue(var_1)) {
      var_14 = var_2 scripts\mp\supers::_id_69B0();

      if(isDefined(var_14) && var_0._id_C189 == var_14) {
        var_2 _id_0BA1(5);
        return 0;
      }
    }
  } else if(var_0.type == "special") {
    switch (var_0._id_C189) {
      case "armor_bundle":
      case "armor":
        break;
    }
  } else if(var_0.type == "killstreak") {
    if(scripts\mp\utility\game::_id_875D()) {
      if(!var_2 scripts\mp\gametypes\arena_evo_tourney_loot::_id_314F(var_0)) {
        var_2 _id_0BA1(5);
        return 0;
      }
    } else if(scripts\mp\utility\game::isbasegametype()) {
      if(!var_2 scripts\mp\gametypes\s4_base_loot::_id_314F(var_0)) {
        var_2 _id_0BA1(5);
        return 0;
      }
    }
  }

  if(scripts\mp\utility\game::_id_875D()) {
    if(isDefined(var_0)) {
      var_15 = var_2 _id_0C00(var_0);
      scripts\mp\gametypes\arena_evo_tourney_util::arenatournament_dlog_record_purchase_event(var_2, var_0._id_C189, var_15);
    }
  } else if(scripts\mp\utility\game::isbasegametype()) {
    if(isDefined(var_0)) {
      var_15 = var_2 _id_0C00(var_0);
      scripts\mp\gametypes\s4_base_util::basedlogrecordplayerpurchaseevent(var_2, var_0._id_C189, var_15);
    }
  }

  return 1;
}

_id_AA71(var_0, var_1) {
  var_2 = self;
  var_3 = var_2._id_22A2;

  if(!istrue(var_2._id_1B85)) {
    return;
  }
  var_4 = "channel: " + var_0;

  if(isDefined(var_1)) {
    var_4 = var_4 + ", index: " + var_1;
  }

  var_5 = getdvarint("#x3299e98609e3b1231", 1);

  if(var_0 == "base_cancel_purchase") {
    _id_0CA4(var_2);
  } else if(var_0 == "base_item_purchase") {
    var_6 = var_1;
    var_7 = level._id_229D._id_8B38[var_6];
    var_8 = var_2 _id_0DB7(var_7, var_5);

    if(var_8) {
      if(var_7.type == "vehicle") {
        var_9 = var_2 _id_0C1D(var_7, var_5);

        if(var_9) {
          var_2 _id_0C5A(var_2 _id_0C00(var_7), var_7.type);
          var_2 thread scripts\mp\hud_message::showsplash("item_purchased", var_6);
          return;
        }

        var_2 scripts\mp\hud_message::_id_DCA2("MP/VEHICLE_PURCHASE_FAILED");
        return;
        return;
      }

      if(var_7.type == "fieldupgrade") {
        var_9 = var_2 _id_0C19(var_7, var_5, 1);
        return;
      }

      if(var_7.type == "weapon") {
        var_9 = var_2 _id_0C1A(var_7, var_5, 1);
        return;
      }

      if(var_7.type == "perk") {
        var_9 = var_2 _id_0C1A(var_7, var_5, 1);
        return;
      }

      if(var_7.type == "equipment") {
        var_9 = var_2 _id_0C1A(var_7, var_5, 1);
        return;
      }

      if(var_7.type == "killstreak") {
        var_9 = var_2 _id_0C1A(var_7, var_5, 1);
        return;
      }

      if(var_7.type == "special") {
        var_9 = var_2 _id_0C1A(var_7, var_5, 1);
        return;
      }

      return;
      return;
      return;
      return;
      return;
      return;
      return;
    }
  } else if(var_0 == "loadout_purchase") {
    var_10 = int(_func_0222("mp/s4BaseKioskPurchases.csv", 2, "loadouts", 0));
    var_7 = level._id_229D._id_8B38[var_10];
    var_9 = var_2 _handleloadoutpurchase(var_7, var_1);
  }
}

_id_0C5A(var_0, var_1) {
  var_2 = self;

  if(var_0 > 0) {
    var_2[[level._id_CAB6]](var_0);
  }

  var_3 = !isDefined(var_1) || var_1 != "vehicle";

  if(var_3 && (scripts\mp\utility\game::_id_875D() || scripts\mp\utility\game::isbasegametype())) {
    var_2 setclientomnvar("ui_arena_update_buy_menu", gettime());
  } else {
    var_2 _id_0BA1(1);
  }
}

_id_1720(var_0) {
  var_0 endon("death_or_disconnect");
  var_1 = var_0._id_03B5;
  var_0 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0.secondaryweaponobj);
  var_0 giveweapon("s4_la_m1bravo_mp");
}

_id_1B86(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(scripts\mp\utility\game::_id_875D() || scripts\mp\utility\game::isbasegametype()) {
    if(scripts\engine\utility::is_equal(var_0.classname, "scriptable_arena_evo_plunder_box_weapons") || scripts\engine\utility::is_equal(var_0.classname, "scriptable_base_plunder_box_weapons")) {
      var_3 _id_07E6::jugg_forceend();
    }
  }

  if(istrue(level.gameended)) {
    return;
  }
  if(!var_3 scripts\cp_mp\utility\player_utility::_isalive() || istrue(var_3.inlaststand)) {
    return;
  }
  if(var_3 scripts\cp_mp\utility\player_utility::_id_8ACE()) {
    return;
  }
  if(var_3 scripts\cp_mp\utility\player_utility::isinvehicle()) {
    return;
  }
  if(var_3 _id_8DFD()) {
    return;
  }
  if(scripts\engine\utility::is_equal(var_0.classname, "scriptable_s4_base_plunder_box_redeploy")) {
    var_3 notify("redeploynotify", "arms_race_redeploy", 2);
  } else {
    if(var_2 == "visible") {
      var_0 setscriptablepartstate(level._id_CAB3, "opening");
      var_0 thread _id_8DFF();
      var_3 thread _id_0CCB(var_0);
      return;
    }

    if(var_2 == "opening" || var_2 == "open") {
      var_3 thread _id_0CCB(var_0);
    }
  }
}

_id_8DFD() {
  if(!isDefined(level._id_CAB1)) {
    return 1;
  }

  return [[level._id_CAB1]](self);
}

_id_8DFF() {
  if(!getdvarint("#x33672ef5d70247c21", 1)) {
    return;
  }
  var_0 = getdvarfloat("#x3f9c481fe376bbaf8", 300);
  var_1 = _func_040F(level.players, self.origin, var_0);

  foreach(var_3 in var_1) {
    if(!isDefined(var_3) || !isalive(var_3)) {
      continue;
    }
    if(var_3 getstance() != "prone") {
      continue;
    }
    var_4 = var_3 _meth_86AD();
    var_0 = var_4[0];
    var_5 = 2.0 * var_4[2];

    if(_func_0036(var_3.origin, var_0, var_5, undefined, 0, 0)) {
      continue;
    }
    var_3 setstance("crouch", 1);
  }
}
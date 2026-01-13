/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\dev.gsc
*********************************************/

init() {}

func_1014E(var_0, var_1, var_2, var_3, var_4, var_5) {}

func_12F00() {}

func_DE5E() {}

reflectionprobe_hide_hp() {}

reflectionprobe_hide_front() {}

_meth_8470() {}

allowmantle() {}

devaliengiveplayersmoney() {}

spam_points_popup() {
  var_0 = ["headshot", "avenger", "longshot", "posthumous", "double", "triple", "multi"];
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    thread scripts\mp\rank::scorepointspopup(100);
    thread scripts\mp\rank::scoreeventpopup(var_0[var_1]);
    wait(2);
  }
}

func_A5AC() {
  for(;;) {
    if(getdvarint("scr_dropAllies") > 0) {
      break;
    }

    wait(1);
  }

  var_0 = undefined;
  foreach(var_2 in level.characters) {
    if(isplayer(var_2) && !isbot(var_2)) {
      var_0 = var_2;
      break;
    }
  }

  if(!isDefined(var_0)) {
    return;
  }

  foreach(var_2 in level.characters) {
    if(level.teambased) {
      if(var_2.team == var_0.team) {
        kick(var_2 getentitynumber());
      }

      continue;
    }

    return;
  }
}

func_53EE() {
  level.var_D788 = getdvarint("scr_power_short_cooldown", 0);
  for(;;) {
    var_0 = getdvarint("scr_power_short_cooldown", 0);
    if(var_0 != level.var_D788) {
      level.var_D788 = var_0;
      foreach(var_2 in level.players) {
        if(isbot(var_2)) {
          continue;
        }

        var_3 = var_2 scripts\mp\powers::getcurrentequipment("primary");
        if(isDefined(var_3)) {
          func_53E4(var_3, "primary");
        }

        var_3 = var_2 scripts\mp\powers::getcurrentequipment("secondary");
        if(isDefined(var_3)) {
          func_53E4(var_3, "secondary");
        }
      }
    }

    wait(0.25);
  }
}

func_53ED() {
  level.var_D7A3 = getdvarint("scr_power_use_cooldown", -1);
  for(;;) {
    var_0 = getdvarint("scr_power_use_cooldown", -1);
    if(var_0 != level.var_D7A3) {
      level.var_D7A3 = var_0;
      foreach(var_2 in level.players) {
        if(isbot(var_2)) {
          continue;
        }

        var_3 = var_2 scripts\mp\powers::getcurrentequipment("primary");
        if(isDefined(var_3)) {
          func_53E4(var_3, "primary");
        }

        var_3 = var_2 scripts\mp\powers::getcurrentequipment("secondary");
        if(isDefined(var_3)) {
          func_53E4(var_3, "secondary");
        }
      }
    }

    wait(0.25);
  }
}

func_53EC() {
  level.var_D777 = getdvarint("scr_power_extra_charge", 0);
  for(;;) {
    var_0 = getdvarint("scr_power_extra_charge", 0);
    if(var_0 != level.var_D777) {
      level.var_D777 = var_0;
      foreach(var_2 in level.players) {
        if(isbot(var_2)) {
          continue;
        }

        var_3 = var_2 scripts\mp\powers::getcurrentequipment("primary");
        if(isDefined(var_3)) {
          func_53E4(var_3, "primary");
        }

        var_3 = var_2 scripts\mp\powers::getcurrentequipment("secondary");
        if(isDefined(var_3)) {
          func_53E4(var_3, "secondary");
        }
      }
    }

    wait(0.25);
  }
}

func_53E5() {
  for(;;) {
    var_0 = getdvar("scr_givepowerprimary", "");
    if(var_0 != "") {
      func_53E4(var_0, "primary");
    }

    var_0 = getdvar("scr_givepowersecondary", "");
    if(var_0 != "") {
      func_53E4(var_0, "secondary");
    }

    wait(0.25);
  }
}

func_53E4(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(isbot(var_3)) {
      continue;
    }

    var_4 = var_3 scripts\mp\powers::getcurrentequipment(var_1);
    if(isDefined(var_4)) {
      var_3 scripts\mp\powers::removepower(var_4);
    }

    var_3 scripts\mp\powers::givepower(var_0, var_1, 0);
  }
}

devlistinventory() {
  var_0 = getdvar("scr_list_inventory", "");
  if(var_0 != "") {
    var_1 = devfindhost();
    if(!isDefined(var_1)) {
      return;
    }

    var_2 = undefined;
    var_3 = undefined;
    var_4 = 0;
    if(var_0 == "all") {
      var_3 = "all weapons";
      var_2 = var_1 getweaponslistall();
    } else if(var_0 == "primaryCurrent") {
      var_3 = "current weapon";
      var_4 = 1;
      var_2 = [var_1 getcurrentweapon()];
    } else {
      var_3 = var_0 + " inventory";
      var_2 = var_1 getweaponslist(var_0);
    }

    var_1 devprintweaponlist(var_2, var_3, var_4);
  }
}

devprintweaponlist(var_0, var_1, var_2) {
  if(isDefined(var_0) && var_0.size > 0) {
    foreach(var_4 in var_0) {
      var_5 = self getweaponammoclip(var_4);
      var_6 = self getweaponammostock(var_4);
      var_7 = "" + var_4 + " " + var_5 + "\" + var_6;
      if(var_2) {
        iprintlnbold(var_7);
      }
    }
  }
}

func_53E6() {
  var_0 = getdvarint("scr_super_short_cooldown", 0);
  for(;;) {
    var_1 = getdvar("scr_givesuper", "");
    if(var_1 != "") {
      var_2 = devfindhost();
      var_2 scripts\mp\supers::stopridingvehicle(var_1);
    }

    if(getdvarint("scr_super_short_cooldown", 0) != 0) {
      if(!var_0) {
        var_0 = 1;
        foreach(var_4 in level.players) {
          if(isbot(var_4)) {
            continue;
          }

          if(var_4 scripts\mp\supers::issupercharging()) {
            var_4 scripts\mp\supers::func_E276();
          }
        }
      }
    } else if(var_0) {
      var_0 = 0;
      foreach(var_4 in level.players) {
        if(isbot(var_4)) {
          continue;
        }

        if(var_4 scripts\mp\supers::issupercharging()) {
          var_4 scripts\mp\supers::func_E276();
        }
      }
    }

    wait(0.25);
  }
}

devfindhost() {
  var_0 = undefined;
  foreach(var_2 in level.players) {
    if(var_2 ishost()) {
      var_0 = var_2;
      break;
    }
  }

  return var_0;
}

func_53F0() {
  var_0 = getdvar("scr_debug_streak_passive", "none");
  for(;;) {
    var_1 = getdvar("scr_debug_streak_passive", "none");
    if(var_0 != var_1) {
      iprintlnbold("All Killstreaks from the DevGui will have " + var_1);
      var_0 = var_1;
    }

    wait(1);
  }
}

watchlethaldelaycancel() {
  for(;;) {
    if(getdvarint("scr_lethalDelayCancel", 0)) {
      scripts\mp\weapons::cancellethaldelay();
      return;
    }

    wait(1);
  }
}

watchsuperdelaycancel() {
  for(;;) {
    if(getdvarint("scr_superDelayCancel", 0)) {
      scripts\mp\supers::cancelsuperdelay();
      return;
    }

    wait(1);
  }
}

watchslowmo() {
  for(;;) {
    if(getdvar("scr_slowmo") != "") {
      break;
    }

    wait(1);
  }

  var_0 = getdvarfloat("scr_slowmo");
  setslowmotion(var_0, var_0, 0);
  thread watchslowmo();
}

func_53E2() {
  for(;;) {
    if(getdvar("scr_jt_devbroshot") != "") {
      iprintlnbold(" BRO ");
      level.doingbroshot = scripts\mp\broshot::initbroshot();
      if(level.doingbroshot) {
        setomnvarforallclients("post_game_state", 6);
        wait(0.1);
        scripts\mp\broshot::startbroshot();
      }
    }

    if(getdvarint("scr_debug_start_broshot")) {
      iprintlnbold("Test Broshot");
      level.doingbroshot = scripts\mp\broshot::forceinitbroshot();
      if(level.doingbroshot) {
        setomnvarforallclients("post_game_state", 6);
        wait(0.1);
        level.players[0] scripts\mp\broshot::startbroshot();
      }
    }

    if(getdvarint("scr_debug_change_rig_broshot")) {
      scripts\mp\broshot::changetestrig(getdvarint("scr_debug_change_rig_broshot"), 1);
      iprintlnbold("Test Rig" + getdvarint("scr_debug_change_rig_broshot"));
    }

    if(getdvarint("scr_debug_assign_taunt_broshot")) {
      scripts\mp\broshot::changetesttaunt(getdvarint("scr_debug_assign_taunt_broshot"));
      iprintlnbold("Test Taunt" + getdvarint("scr_debug_assign_taunt_broshot"));
    }

    if(getdvarint("scr_debug_change_slot_broshot")) {
      scripts\mp\broshot::changetestslot(getdvarint("scr_debug_change_slot_broshot"));
      iprintlnbold("Test Slot Change" + getdvarint("scr_debug_change_slot_broshot"));
    }

    wait(0.05);
  }
}

rangefinder() {
  thread scripts\mp\rangefinder::runmprangefinder();
}
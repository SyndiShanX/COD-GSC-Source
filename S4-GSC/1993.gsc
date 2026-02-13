/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1993.gsc
*************************************************/

init() {}

_id_C19A() {}

_id_C199() {}

_id_7101() {}

_id_7106() {}

_id_48DE() {}

_id_E098() {
  var_0 = ["headshot", "avenger", "longshot", "posthumous", "double", "triple", "multi"];

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    thread scripts\mp\rank::_id_CC13(100);
    thread scripts\mp\rank::_id_CC00(var_0[var_1]);
    wait 2.0;
  }
}

_id_48E5() {
  var_0 = getDvar("#x3ff2ab84304874c96", "");

  if(var_0 != "") {
    var_1 = _id_48E0();

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
      var_2 = var_1 _meth_8191(var_0);
    }

    var_1 _id_48EA(var_2, var_3, var_4);
  }
}

_id_48EA(var_0, var_1, var_2) {
  if(isDefined(var_0) && var_0.size > 0) {
    foreach(var_4 in var_0) {
      var_5 = self getweaponammoclip(var_4);
      var_6 = self getweaponammostock(var_4);
      var_7 = "" + getcompleteweaponname(var_4) + " " + var_5 + "/" + var_6;

      if(var_2) {
        iprintlnbold(var_7);
      }
    }
  } else {}
}

_id_48E2() {
  for(;;) {
    var_0 = getDvar("#x3484596a3de587457", "");

    if(var_0 != "") {
      foreach(var_2 in level.players) {
        var_2 scripts\mp\supers::givesuper(var_0, 0, 1);
      }
    }

    if(getdvarint("#x3473d107f88cf120b", 0) != 0) {
      foreach(var_2 in level.players) {
        if(isbot(var_2)) {
          continue;
        }
        if(!isDefined(var_2 scripts\mp\supers::getcurrentsuper())) {
          continue;
        }
        if(var_2 scripts\mp\supers::_id_8A75()) {
          var_2 scripts\mp\supers::_id_6FF9(var_2 scripts\mp\supers::_id_6DA3() * 0.25);
        }
      }
    }

    wait 0.25;
  }
}

_id_48E1() {
  for(;;) {
    var_0 = getDvar("#x3a84fce7093099e24", "");

    if(var_0 != "") {
      foreach(var_2 in level.players) {
        var_2 _id_0A6C::_id_AFDD(var_0);
      }
    }

    wait 0.25;
  }
}

_id_48E0() {
  var_0 = undefined;

  foreach(var_2 in level.players) {
    if(var_2 ishost()) {
      var_0 = var_2;
      break;
    }
  }

  return var_0;
}

_id_10B9A() {
  for(;;) {
    if(getdvarint("#x36bff51093c4203b0", 0)) {
      scripts\mp\equipment::_id_3160();
      return;
    }

    wait 1.0;
  }
}

_id_10C0A() {
  for(;;) {
    if(getdvarint("#x3cf7ba6c7a36ea14d", 0)) {
      scripts\mp\supers::_id_3165();
      return;
    }

    wait 1.0;
  }
}

_id_10BFA() {
  for(;;) {
    if(getDvar("#x35f8270e3c8ac3428") != "") {
      break;
    }

    wait 1;
  }

  var_0 = getdvarfloat("#x35f8270e3c8ac3428");
  _func_01F0(var_0, var_0, 0.0);
  thread _id_10BFA();
}

_id_C01E() {
  thread _id_0809::_id_CA51();
}

_id_EE61() {
  thread _id_081D::_id_CA52();
}

watchttk() {
  for(;;) {
    var_0 = level.players[0];

    if(getdvarint("#x33d2728ca7c4c1dbe", 0) == 1) {
      var_0 thread watchattackerttk();
      iprintlnbold("Time to kill monitor: ON");
      return;
    }

    waitframe();
  }
}

watchattackerttk() {
  self endon("monitorTTK_off");

  for(;;) {
    self waittill("victim_damaged", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

    if(!isDefined(var_0.ttkdata)) {
      var_9 = spawnStruct();
      var_9._id_F1E8 = gettime();
      var_0.ttkdata = var_9;
    }

    if(!isalive(var_0) && isDefined(var_0.ttkdata)) {
      var_10 = float(gettime() - var_0.ttkdata._id_F1E8) / 1000;
      var_0.ttkdata = undefined;
    }
  }
}

watchdam() {
  for(;;) {
    var_0 = level.players[0];

    if(getdvarint("#x35292bec9cf713295", 0) == 1) {
      var_0 thread watchattackerdam();
      iprintlnbold("Bullet Damage Monitor: ON");
      return;
    }

    waitframe();
  }
}

watchattackerdam() {
  self endon("monitorDam_off");

  for(;;) {
    self waittill("victim_damaged", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

    if(!isDefined(var_0.damdata)) {
      var_9 = spawnStruct();
      var_9.dam = 0;
      var_9.btk = 0;
      var_0.damdata = var_9;
    }

    var_0.damdata.dam = var_0.damdata.dam + var_2;
    var_0.damdata.btk = var_0.damdata.btk + 1;

    if(!isalive(var_0) && isDefined(var_0.damdata)) {
      var_0.damdata = undefined;
    }
  }
}

_id_D083() {
  var_0 = level.players[0];

  for(;;) {
    var_0 = level.players[0];

    if(isDefined(var_0)) {
      break;
    }

    waitframe();
  }

  var_0 notifyonplayercommand("player_self_destruct", "+frag");

  for(;;) {
    if(getdvarint("#x3882e2dff7e82d609", 0) == 1) {
      var_0 waittill("player_self_destruct");
      var_0 _meth_81FA();
    }

    waitframe();
  }
}

_id_4CDB() {
  for(;;) {
    if(getdvarint("#x3c53a30db43ac6c04", 0) == 1) {
      var_0 = level.players[0];
      var_1 = var_0 _id_081D::_id_6CE4();
      _id_0A3E::_id_E119(var_1, (0, 0, 0), var_0);
      setDvar("#x3c53a30db43ac6c04", 0);
    }

    waitframe();
  }
}

_id_10A88() {
  for(;;) {
    if(getdvarint("#x3e14aeb386fe2150e", 0) != 0) {
      var_0 = level.players[0];

      foreach(var_2 in level._id_0F4C) {
        if(istrue(var_2._id_873F)) {
          var_2 scripts\mp\utility\killstreak::_id_4C56(1000000, var_0, var_0, scripts\mp\utility\game::_id_6BE2(var_0.team)[0], var_2.origin, "MOD_EXPLOSIVE", "s4_airstrike_bomb_mp");
        }
      }

      setDvar("#x3e14aeb386fe2150e", 0);
    }

    waitframe();
  }
}

triggerbotusefieldupgrade() {
  for(;;) {
    var_0 = getDvar("#x3d4e5922221952a22", "");

    if(var_0 != "") {
      var_1 = undefined;

      foreach(var_3 in level.players) {
        if(isbot(var_3)) {
          var_1 = var_3;
          break;
        }
      }

      if(isDefined(var_1)) {
        switch (var_0) {
          case "super_equipment_resupply_drop":
            var_5 = makeweapon("s4_equipment_resupply_box_mp");
            var_1 _meth_852A(var_5);
            break;
          case "super_tac_insert":
            var_5 = makeweapon("s4_hand_flare_mp");
            var_1 _meth_852A(var_5);
            break;
          case "super_steel_bib":
            var_1 _id_0A15::_id_E805();
            break;
          case "super_pac_sentry":
            var_1 scripts\mp\killstreaks\killstreaks::_id_F763("pac_sentry");
            break;
          case "super_field_mic":
            var_5 = makeweapon("s4_field_mic_mp");
            var_1 _meth_852A(var_5);
            break;
          case "super_jammer":
            var_5 = makeweapon("s4_jammer_mp");
            var_1 _meth_852A(var_5);
            break;
          case "super_trophy":
            var_5 = makeweapon("s4_trophy_mp");
            var_1 _meth_852A(var_5);
            break;
          case "super_tac_cover":
            var_5 = makeweapon("s4_tac_cover_mp");
            var_1 _meth_852A(var_5);
            break;
        }
      }

      setDvar("#x3d4e5922221952a22", "");
    }

    waitframe();
  }
}

_id_F610() {
  for(;;) {
    var_0 = getDvar("#x3c02040ac739f7809", "");

    if(var_0 != "") {
      var_1 = undefined;

      foreach(var_3 in level.players) {
        if(isbot(var_3)) {
          var_1 = var_3;
          break;
        }
      }

      if(isDefined(var_1)) {
        switch (var_0) {
          case "glide_bomb":
            var_1 _id_09B3::_id_F781();
            break;
          case "guard_dog":
            var_1 _id_0A46::_id_F779(var_0);
            break;
          case "attack_dogs":
            var_1 _id_0A34::_id_F779(var_0);
            break;
          case "juggernaut":
            var_1 _id_07E6::_id_8C08();
            break;
          case "uav":
            var_1 _id_09BD::_id_F7A4("uav");
            break;
          case "counter_spy_plane":
            var_1 _id_09BD::_id_F7A4("counter_spy_plane");
            break;
          case "ball_turret_gunner":
            var_1 _id_09AC::_id_F76C();
            break;
        }
      }

      setDvar("#x3c02040ac739f7809", "");
    }

    waitframe();
  }
}
/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2452.gsc
*************************************************/

_id_548C(var_0) {
  if(!isDefined(var_0._id_5BBD)) {
    var_0._id_5BBD = 1;
  }

  var_1 = _id_6304(var_0);
  _id_396D(var_0);
  level notify("player_entered_ala", var_0);
  var_0 notify("player_entered_ala");
  var_0._id_5784 = 0;

  if(isDefined(level._id_F271)) {
    level._id_F271++;
  }

  var_0._id_F20F = gettime();
  var_0.health = var_0.maxhealth;
  var_0 setorigin(var_1.origin);
  var_0 _meth_8206();
  var_0 setstance("stand");
  var_0 takeallweapons();
  var_0 playershow();
  var_0 scripts\cp\utility::_giveweapon("iw7_gunless_zm", undefined, undefined, 1);
  var_0 scripts\common\utility::_id_1554(0);

  if(isDefined(level._id_B73B)) {
    var_0[[level._id_B73B]](var_0, "afterlife");
  }

  var_0 scripts\cp\utility::_id_5E70();
  var_0 _id_11E7(var_0);
  var_0 _id_D23F(var_0, 0);
  var_0 _id_7DB2(var_0);

  if(isDefined(var_0)) {
    if(_id_34B6(var_0)) {
      var_0 scripts\cp\utility::_id_D5E9("welcome_to_afterlife", &"CP_ZOMBIE_AFTERLIFE_ARCADE/WELCOME", 6.0);
    } else {
      var_0 scripts\cp\utility::_id_D5E9("welcome_to_afterlife_no_self_revives", &"CP_ZOMBIE_AFTERLIFE_ARCADE/NO_REVIVES", 6.0);
    }

    _id_0995::_id_9722(1, var_0, level._id_10C9F, var_0._id_E04D, int(level._id_10C9F / 10) + 1 - var_0._id_F26B);
  }

  if(var_0._id_5BBD) {
    var_0 thread _id_076F::_id_F72D("spawn_arcade_first", "zmb_comment_vo", "highest", 15, 0, 0, 1, 50);
    var_0._id_5BBD = 0;
  } else
    var_0 thread _id_076F::_id_F72D("spawn_arcade", "zmb_comment_vo", "high", 15, 0, 0, 1, 50);

  var_0 _id_C5E5(var_0);
  var_0 thread _id_B446(var_0);
  var_0 thread _id_4685(var_0, var_1.angles);
  var_0 thread _id_2532(var_0);
  var_0 thread _id_B43C(var_0);
  level thread _id_ABF1(var_0, 10);
  var_0 _id_D25C(var_0, 1);
  var_0 _id_11E6(var_0, 1);
  var_0 scripts\cp\utility::_id_78FD(var_0._id_7C83);
  var_0 visionsetnakedforplayer("cp_zmb_afterlife", 1.0);
  var_0 setclientomnvar("zm_ui_player_in_afterlife_arcade", 1);
  var_0 _meth_82F8("player_damaged", 1, 0);
  var_0 _meth_82F8("player_damaged", 2, 0);

  if(scripts\cp\utility::_id_89AE() || level._id_AB30) {
    scripts\engine\utility::_id_5C1B("pause_wave_progression");
    level._id_11085 = 1;

    foreach(var_3 in _id_06FE::_id_68A1("axis")) {
      if(isDefined(var_3._id_4D7A)) {
        continue;
      }
      if(isDefined(var_3._id_1210) && (var_3._id_1210 == "zombie_brute" || var_3._id_1210 == "zombie_grey")) {
        continue;
      }
      var_3._id_4982 = 1;
      var_3 suicide();
    }

    var_0 thread scripts\cp\cp_hud_message::_id_106CB("afterlife", 18);
    thread _id_6F53(var_0);
  }

  if(isDefined(level._id_548D)) {
    [[level._id_548D]](var_0);
  }

  if(isDefined(level._id_0DFB)) {
    var_0 thread[[level._id_0DFB]](var_0);
  } else {
    var_0 thread _id_076F::_id_F72D("ww_afterlife_arrive", "zmb_afterlife_vo", "high", 20, 0, 0, 1);
  }

  if(isDefined(level._id_0DF9)) {
    var_0 thread[[level._id_0DF9]](var_0);
  }
}

_id_B311(var_0) {
  var_0 endon("disconnect");
  var_0 endon("death");
  level endon("game_ended");
  var_0 endon("player_done_exit_afterlife");
  wait(randomintrange(30, 40));

  if(!isDefined(var_0._id_1BBA)) {
    var_0._id_1BBA = ["ww_afterlife_memoir_1", "ww_afterlife_memoir_2", "ww_afterlife_memoir_3", "ww_afterlife_memoir_4", "ww_afterlife_memoir_5", "ww_afterlife_memoir_6", "ww_afterlife_memoir_7", "ww_afterlife_memoir_8"];
  }

  while(var_0._id_1BBA.size > 0) {
    if(randomint(100) < 30) {
      scripts\engine\utility::_id_B2DA(var_0._id_1BBA[0], level._id_10E20.origin);
    }

    var_0._id_1BBA = scripts\engine\utility::array_remove(var_0._id_1BBA, var_0._id_1BBA[0]);

    if(isDefined(var_0._id_1BBA[0])) {
      if(_func_0205(var_0._id_1BBA[0])) {
        wait(randomfloatrange(80.0, 110.0) + _id_076F::_id_6763(var_0._id_1BBA[0]));
      }

      continue;
    }

    wait(randomfloatrange(120.0, 180.0));
  }
}

_id_358E(var_0) {
  wait 10;
  var_1 = "";

  if(var_0._id_F26B >= var_0._id_9C31) {
    var_1 = "ww_afterlife_p4_notoken";
  } else {
    var_2 = ["ww_afterlife_p1_generic", "ww_afterlife_p5_alt_1", "ww_afterlife_arrive"];
    var_1 = scripts\engine\utility::random(var_2);
  }

  if(var_1 == "ww_afterlife_arrive") {
    var_0 thread _id_076F::_id_F72D(var_1, "zmb_afterlife_vo", "high", 20, 0, 0, 1);
    return;
  }

  var_3 = strtok(var_1, "_");
  var_4 = "";
  var_5 = var_3[3];
  var_6 = var_0._id_10643;
  var_7 = strtok(var_6, "_");
  var_8 = var_7[0];

  switch (var_8) {
    case "p5":
    case "p4":
    case "p3":
    case "p2":
    case "p1":
      var_4 = _id_359E(var_8, var_5);
      break;
    default:
      var_4 = var_1;
      break;
  }

  if(_func_0205(var_4)) {
    var_0 thread _id_076F::_id_F72D(var_4, "zmb_afterlife_vo", "high", 60, 1, 0, 1);
  }
}

_id_359E(var_0, var_1) {
  var_2 = "ww_afterlife_";

  for(;;) {
    var_2 = "ww_afterlife_";

    switch (var_1) {
      case "generic":
        var_2 = var_2 + var_0 + "_generic";
        break;
      case "notoken":
        var_2 = var_2 + var_0 + "_notoken";
        break;
      case "alt":
        var_2 = var_2 + var_0 + "_alt_1";
        break;
      default:
        break;
    }

    if(!_func_0205(var_2)) {
      var_3 = ["ww_afterlife_p1_generic", "ww_afterlife_arrive", "ww_afterlife_p5_alt_1"];
      var_2 = scripts\engine\utility::random(var_3);

      if(var_2 == "ww_afterlife_arrive") {
        return var_2;
      } else {
        var_4 = strtok(var_2, "_");
        var_1 = var_4[3];
        continue;
      }
    } else
      return var_2;

    waitframe();
  }

  return var_2;
}

_id_396D(var_0) {
  var_0._id_AE0A = [];
}

_id_6304(var_0) {
  var_1 = scripts\engine\utility::getstructarray("afterlife_arcade", "targetname");

  if(isDefined(level._id_10CC)) {
    var_1 = scripts\engine\utility::array_combine(var_1, level._id_10CC);
  }

  var_1 = scripts\engine\utility::array_randomize(var_1);

  foreach(var_3 in var_1) {
    if(_id_30F9(var_3, var_0)) {
      return var_3;
    }
  }

  return scripts\engine\utility::random(var_1);
}

_id_30F9(var_0, var_1) {
  var_2 = 16;

  foreach(var_4 in level.players) {
    if(var_4 == var_1) {
      continue;
    }
    if(distance2d(var_0.origin, var_4.origin) < var_2) {
      return 0;
    }
  }

  return 1;
}

_id_F70B(var_0) {
  if(_id_85FD(var_0)) {
    _id_5732(var_0);
  }
}

_id_3912(var_0) {
  foreach(var_2 in level._id_105F7) {
    if(isDefined(var_0._id_10646._id_105FC[var_2]) && var_0._id_10646._id_105FC[var_2].size > 0) {
      foreach(var_4 in var_0._id_10646._id_105FC[var_2]) {
        if(isDefined(var_4)) {
          if(issubstr(var_4._id_1446, "afterlife")) {
            var_0 _meth_83EF(var_4._id_1446);
          }
        }
      }
    }
  }

  var_7 = undefined;

  if(isDefined(var_0._id_10646)) {
    if(isDefined(var_0._id_10646._id_10506)) {
      if(isDefined(var_0._id_10646._id_10506._id_1446)) {
        var_7 = var_0._id_10646._id_10506._id_1446;
      }
    }
  }

  if(isDefined(var_7)) {
    var_0 _meth_83EF(var_7);
  }
}

_id_5732(var_0) {
  if(var_0._id_9761 == "wave_complete") {
    var_0._id_C0C9 = "Wave Complete";
  } else {
    var_0._id_C0C9 = "Self Revive";
  }

  if(var_0 hasweapon("iw7_gunless_zm")) {
    var_0 takeweapon("iw7_gunless_zm");
  }

  level thread _id_39B4(var_0);
  level thread _id_3912(var_0);

  if(isDefined(var_0._id_4AA3) && var_0._id_4AA3 >= 1) {
    var_0 scripts\common\utility::_id_1554(1);
  }

  var_0._id_5784 = 1;
  var_0._id_F278 = (gettime() - var_0._id_F20F) / 1000;
  _id_0995::_id_9724(1, var_0, level._id_10C9F, var_0._id_C0C9, var_0._id_F278);
  var_0 scripts\common\utility::_id_158A(0);
  var_0 _id_D25C(var_0, 0);
  var_0 _id_11E6(var_0, 0);
  var_0 scripts\cp\utility::_id_DCB0(var_0._id_7C83);
  var_0 visionsetnakedforplayer("", 0);
  var_0 setclientomnvar("zm_ui_player_in_afterlife_arcade", 0);
  var_0._id_864C = undefined;
  var_0._id_8606 = undefined;
  var_0 setclientomnvar("zombie_afterlife_soul_power_needed", -1);
  var_0 thread _id_B226(var_0);
  var_0 notify("player_done_exit_afterlife");
}

_id_B226(var_0) {
  var_0 endon("disconnect");

  if(isDefined(var_0._id_7D34)) {
    return;
  }
  wait 4.0;

  if(!isDefined(var_0._id_A75B)) {
    var_0._id_A75B = 0;
  }

  var_0._id_A75B++;

  if(var_0._id_A75B == 1) {
    var_0 thread _id_076F::_id_F72D("arcade_token_revive_first", "zmb_comment_vo", "low", 3, 0, 0, 1);
  } else {
    var_0 thread _id_076F::_id_F72D("arcade_token_revive", "zmb_comment_vo", "low", 3, 0, 0, 1);
  }
}

_id_4721() {
  wait 0.1;
  self delete();
}

_id_4685(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("player_exit_afterlife");
  waitframe();
  var_0 setplayerangles(var_1);
}

_id_2532(var_0) {
  var_0 endon("disconnect");
  var_1 = newclienthudelem(var_0);
  var_1.x = 0;
  var_1.y = 0;
  var_1 setshader("black", 640, 480);
  var_1.alignx = "left";
  var_1.aligny = "top";
  var_1.sort = 1;
  var_1.horzalign = "fullscreen";
  var_1.vertalign = "fullscreen";
  var_1.alpha = 1;
  var_1._id_01D6 = 1;
  var_1 fadeovertime(15.0);
  var_1.alpha = 0;
  var_1 scripts\engine\utility::_id_1088B(15.0, var_0, "player_exit_afterlife", level, "game_ended");
  var_1 destroy();
}

_id_11E7(var_0) {
  var_0._id_8388 = _id_0737::_id_6679();
  _id_0737::_id_C5C3();
  var_0._id_8F31 = undefined;
  var_0._id_8388 makeunusable();
  var_0 thread _id_11E8();
  var_0 thread _id_0737::_id_B502();
}

_id_11E8() {
  var_0 = self._id_8388;
  scripts\engine\utility::waittill_any_3("player_exit_afterlife", "spawned", "disconnect");
  var_0._id_7D7E = 0;
}

_id_D25C(var_0, var_1) {
  var_0._id_7D66 = var_1;
}

_id_11E6(var_0, var_1) {
  var_0._id_A521 = var_1;
  var_0._id_A536 = var_1;
}

_id_85FD(var_0) {
  return istrue(var_0._id_7D66);
}

_id_80BD(var_0) {}

_id_80AA(var_0) {}

_id_FE0A(var_0, var_1) {
  if(level.players.size == 1) {
    var_1 _id_0737::_id_8385(var_0, &"CP_ZOMBIE_AFTERLIFE_ARCADE/CANNOT_SPECTATE");
    return;
  }

  var_1._id_BB57 = var_1.origin;
  var_1._id_BB56 = var_1 getplayerangles();
  var_1 _id_072E::_id_54E1();
  var_1 thread _id_576B(var_1);
}

_id_576B(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("player_exit_afterlife");
  var_0 endon("spawned");
  var_0 notifyonplayercommand("release_use_button", "-usereload");
  var_0 notifyonplayercommand("release_use_button", "-activate");
  var_0 notifyonplayercommand("press_use_button", "+usereload");
  var_0 notifyonplayercommand("press_use_button", "+activate");
  var_0 waittill("release_use_button");
  var_0 waittill("press_use_button");
  var_0 scripts\cp\utility::_id_FD26("playing");
  var_0 spawn(var_0._id_BB57, var_0._id_BB56);
  var_0 allowdoublejump(0);
  var_0 allowwallrun(0);
}

_id_FDFF(var_0, var_1) {
  var_1 endon("disconnect");

  if(var_1 scripts\cp\utility::_id_89AE() || level._id_AB30) {
    if(!istrue(level._id_4D8E)) {
      level thread _id_C730();
    }
  }

  if(!isDefined(var_1._id_7D34)) {
    var_1 _id_1080();
  }

  if(isDefined(var_1._id_4AA3) && var_1._id_4AA3 >= 1) {
    var_1 scripts\common\utility::_id_1554(1);
  }

  if(!isDefined(var_1._id_7D34)) {
    _id_A209(var_1, "fast_travel_tube_start", "fast_travel_tube_end");
    var_1 thread _id_C461(0.1);
  }

  var_1 notify("player_exit_afterlife");
  var_1 _id_073B::_id_8302(var_1);
  var_1 setclientomnvar("zombie_afterlife_soul_power_earned", 0);
  var_1 setclientomnvar("zombie_afterlife_soul_power_goal", 0);
  var_1 setclientomnvar("zombie_afterlife_soul_power_needed", -1);
  var_1 _id_D23F(var_1, 0);

  if(var_1 scripts\cp\utility::_id_8580("self_revive")) {
    return;
  }
  if(var_1 scripts\cp\utility::_id_89AE() || level._id_AB30) {
    var_1._id_F26B = var_1._id_D080;
    var_2 = var_1._id_9C31 - var_1._id_F26B;
  } else {
    var_1._id_F26B = var_1._id_F26B + 1;
    var_2 = int(level._id_10C9F / 10) + 1 - var_1._id_F26B;
  }

  var_1 setclientomnvar("zombie_afterlife_self_revive_count", int(max(var_2, 0)));
  var_1 thread _id_D3B0();
}

_id_D3B0() {
  self endon("disconnect");
  wait 0.15;
  self allowdoublejump(0);
  self allowslide(1);
  self allowwallrun(0);
  self allowdodge(0);

  if(isDefined(level._id_B5F8)) {
    self _meth_84A4(level._id_B5F8);
  } else {
    self _meth_84A4("zom_suit");
  }

  self._id_EAF7 = "zom_suit";
}

_id_C730() {
  level endon("game_ended");
  wait 20;
  level._id_11085 = 0;
  scripts\engine\utility::_id_5C04("pause_wave_progression");
}

_id_FBB0(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_1 = 0;

  while(var_1 < 2) {
    level scripts\engine\utility::waittill_any_2("regular_wave_starting", "event_wave_starting");

    if(var_0 scripts\cp\utility::_id_89AE() || level._id_AB30) {
      continue;
    } else {
      var_2 = int(level._id_10C9F / 10) + 1 - var_0._id_F26B;
    }

    var_0 setclientomnvar("zombie_afterlife_self_revive_count", int(max(var_2, 0)));
    var_1++;
  }
}

_id_A209(var_0, var_1, var_2) {
  var_3 = getent(var_1, "targetname");
  var_4 = getent(var_2, "targetname");

  if(!isDefined(var_3) || !isDefined(var_4)) {
    return;
  }
  var_0 earthquakeforplayer(0.3, 0.2, var_0.origin, 200);
  var_0 _meth_8063();
  var_0._id_A521 = 1;
  var_0._id_A536 = 1;
  var_5 = var_3.origin + (0, 0, -45);
  var_6 = var_4.origin + (0, 0, -45);
  var_0._id_85CC = 1;
  var_0 scripts\cp\utility::_id_1566(1);
  var_0 dontinterpolate();
  var_0 setorigin(var_5);
  var_0 setplayerangles(var_3.angles);
  var_0 playlocalsound("zmb_portal_travel_lr");
  var_7 = spawn("script_origin", var_5);
  var_0 playerlinkto(var_7);
  wait 0.1;
  var_7 moveto(var_6, 1);
  var_0 thread _id_C461(0.1);
  wait 1;
  var_0._id_85CC = undefined;

  if(var_0 scripts\cp\utility::_id_88B5()) {
    var_0 scripts\cp\utility::_id_1566(0);
  }

  var_0._id_A521 = 0;
  var_0._id_A536 = 0;

  if(isDefined(level._id_B9F9)) {
    var_8 = anglesToForward((0, 90, 0));
    playFX(level._effect["vfx_zmb_portal_exit_burst"], level._id_B9F9, var_8);
  }

  var_0 _id_1080();
  var_7 thread _id_4721();
}

_id_1080() {
  if(isDefined(self._id_10E0D)) {
    return;
  }
  self._id_10E0D = newclienthudelem(self);
  self._id_10E0D.x = 0;
  self._id_10E0D.y = 0;
  self._id_10E0D setshader("white", 640, 480);
  self._id_10E0D.alignx = "left";
  self._id_10E0D.aligny = "top";
  self._id_10E0D.sort = 1;
  self._id_10E0D.horzalign = "fullscreen";
  self._id_10E0D.vertalign = "fullscreen";
  self._id_10E0D.alpha = 1;
  self._id_10E0D._id_01D6 = 1;
}

_id_C461(var_0) {
  self endon("disconnect");

  if(isDefined(var_0)) {
    wait(var_0);
  }

  if(isDefined(self._id_10E0D)) {
    self._id_10E0D.alpha = 0;
    wait 0.1;

    if(isDefined(self._id_10E0D)) {
      self._id_10E0D destroy();
    }
  }
}

_id_310D(var_0, var_1) {
  if(scripts\cp\utility::_id_89AE() || istrue(level._id_AB30)) {
    return 1;
  }

  if(_id_751B(var_1)) {
    return 1;
  }

  return 0;
}

_id_6751(var_0, var_1) {
  if(_id_34B6(var_1)) {
    if(_id_751B(var_1) || scripts\cp\utility::_id_89AE() || istrue(level._id_AB30)) {
      return &"CP_ZOMBIE_AFTERLIFE_ARCADE/SELFREVIVE_DOOR";
    } else {
      return &"CP_ZOMBIE_AFTERLIFE_ARCADE/NEED_SELFREVIVE_TOKEN";
    }
  } else
    return &"CP_ZOMBIE_AFTERLIFE_ARCADE/NO_MORE_SELF_REVIVES";
}

_id_6F4B(var_0) {
  var_0 thread _id_076F::_id_F72D("arcade_token_earn", "zmb_comment_vo", "low", 3, 0, 0, 1);
  var_0 playlocalsound("zmb_ala_soul_meter_filled");
  var_0 _id_D23F(var_0, 1);
  var_0._id_E04D = 0;
  var_0._id_E04C = 0;
  level thread _id_ABF1(var_0, 165);
  wait 5;
  var_0 thread _id_076F::_id_F72D("ww_afterlife_overstay", "zmb_afterlife_vo", "high", undefined, undefined, undefined, 1);
}

_id_6F53(var_0) {
  var_0 playlocalsound("zmb_ala_soul_meter_filled");
  var_0 _id_D23F(var_0, 1);
  var_0 setclientomnvar("zombie_afterlife_soul_power_needed", -1);
  var_0._id_E04D = 0;
  var_0._id_E04C = 0;
  level thread _id_ABF1(var_0, 165);
}

_id_ABF1(var_0, var_1) {
  if(!isDefined(level._id_1408)) {
    level._id_1409 = getent("ala_revive_door", "targetname");
    var_2 = scripts\engine\utility::getstruct("selfrevive_portal", "targetname");
    level._id_1408 = spawn("script_model", var_2.origin);
    level._id_1408 setModel("tag_origin");
    level._id_1408.angles = var_2.angles;
    wait 0.1;
  }

  if(!isDefined(var_0._id_C7BE)) {
    var_0._id_C7BE = spawn("script_model", level._id_1409.origin + (0, 0, -300));
    var_0._id_C7BE setModel(level._id_1409.model);
    var_0._id_C7BE.angles = level._id_1409.angles;

    foreach(var_4 in level.players) {
      if(var_4 != var_0) {
        var_0._id_C7BE hidefromplayer(var_4);
      }
    }

    wait 0.1;
    var_0._id_C7BE.origin = var_0._id_C7BE.origin + (0, 0, 300);
    wait 0.1;
    level._id_1409 hidefromplayer(var_0);
  }

  var_0._id_C7BE rotateyaw(var_1, 0.2);
  var_6 = level._effect["vfx_zmb_portal_centhub"];

  if(isDefined(level._id_3395)) {
    var_6 = level._id_3395;
  }

  _func_019D(var_6, level._id_1408, "tag_origin", var_0);
}

_id_39B4(var_0) {
  if(isDefined(var_0._id_C7BE)) {
    var_0._id_C7BE.angles = level._id_1409.angles;
  }

  _func_02D1(level._effect["vfx_zmb_portal_centhub"], level._id_1408, "tag_origin", var_0);
}

_id_D23F(var_0, var_1) {
  var_0._id_751B = var_1;

  if(var_1 == 1) {
    var_0 setclientomnvar("zombie_afterlife_has_self_revive_token", 1);
  } else {
    var_0 setclientomnvar("zombie_afterlife_has_self_revive_token", 0);
  }
}

_id_751B(var_0) {
  return istrue(var_0._id_751B);
}

_id_34B6(var_0) {
  if(scripts\cp\utility::_id_89AE() || level._id_AB30) {
    return 1;
  } else if(istrue(var_0._id_75CA)) {
    return 1;
  } else if(var_0._id_F26B >= var_0._id_9C31) {
    return 0;
  } else if(int(level._id_10C9F / 10) + 1 - var_0._id_F26B >= 1) {
    return 1;
  } else {
    return 0;
  }
}

_id_B446(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("player_done_exit_afterlife");
  var_0 scripts\engine\utility::_id_10897("player_exit_afterlife", "spawned");
  var_0 _id_5732(var_0);
}

_id_7EB5() {
  level._id_F271 = 0;
  level._id_B3C5 = ::_id_548C;
}

_id_E5A0() {
  var_0 = spawn("script_origin", (-10100, 114, -1753));
  var_0 playLoopSound("zmb_afterlife_music");
}

_id_B43C(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("player_done_exit_afterlife");
  wait 3.0;

  if(_id_34B6(var_0)) {
    _id_F808(var_0);
  }

  var_0 visionsetnakedforplayer("", 2.0);
}

_id_F808(var_0) {
  var_0 setclientomnvar("zombie_afterlife_soul_power_earned", var_0._id_E04D);
  var_0 setclientomnvar("zombie_afterlife_soul_power_needed", var_0._id_E04E);
  var_0 setclientomnvar("zombie_afterlife_soul_power_goal", var_0._id_E04E);
}

_id_B4FA(var_0) {
  var_0._id_7C83 = [];
}

_id_103F(var_0, var_1) {
  var_0._id_7C83[var_0._id_7C83.size] = var_1;
}

_id_C3CA(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0._id_7C83 = scripts\engine\utility::array_remove(var_0._id_7C83, var_1);
  var_0._id_7C83 = scripts\engine\utility::_id_1BD1(var_0._id_7C83);
}

_id_80B2(var_0) {
  var_0._id_E04D = 0;
  var_0._id_E04C = 0;
  var_0._id_F26B = 0;
  var_0._id_E04E = _id_6762(var_0);
}

_id_6F54(var_0, var_1) {
  if(_id_34B6(var_0) && !_id_751B(var_0)) {
    var_0._id_E04D = var_0._id_E04D + var_1;
    var_0 thread _id_4B70(var_0);
  }
}

_id_4B70(var_0) {
  var_0 notify("display_soul_power_earned");
  level endon("game_ended");
  var_0 endon("display_soul_power_earned");
  var_0 endon("revive");

  while(var_0._id_E04C < min(var_0._id_E04D, var_0._id_E04E)) {
    var_1 = min(var_0._id_E04D, var_0._id_E04E);
    var_2 = var_0._id_E04C + 5;
    var_0._id_E04C = min(var_2, var_1);
    var_0 setclientomnvar("zombie_afterlife_soul_power_earned", int(var_0._id_E04C));
    var_0 setclientomnvar("zombie_afterlife_soul_power_needed", int(var_0._id_E04E - var_0._id_E04C));
    waitframe();
  }

  if(var_0._id_E04D >= var_0._id_E04E) {
    if(_id_34B6(var_0)) {
      _id_6F4B(var_0);
    }
  }
}

_id_7DB2(var_0) {
  if(!isDefined(var_0._id_A766)) {
    var_0._id_A766 = 0;
  }

  var_0._id_A766++;
}

_id_6762(var_0) {
  if(scripts\cp\utility::_id_89AE() || istrue(level._id_AB30)) {
    return 0;
  } else {
    return 200;
  }
}

_id_C1EF() {
  level._id_835D["afterlife_spectate_door"] = &"CP_ZOMBIE_AFTERLIFE_ARCADE/SPECTATE_DOOR";
  _id_0737::_id_C1EE("afterlife_spectate_door", undefined, undefined, undefined, ::_id_FE0A, 0, 0, ::_id_80BD);
  _id_0737::_id_C1EE("afterlife_selfrevive_door", undefined, undefined, ::_id_6751, ::_id_FDFF, 0, 0, ::_id_80AA, ::_id_310D);
}

_id_C5E5(var_0) {
  var_0._id_E04D = 0;
  var_0._id_E04C = 0;
  var_0 setclientomnvar("zombie_afterlife_soul_power_earned", var_0._id_E04D);
}
/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\hub_vl_base.gsc
*********************************************/

func_A59E(param_00) {}

func_A59F(param_00) {}

func_A58F() {
  func_A591();
}

func_A591() {
  setDvar("1932", 0.15);
  setDvar("1175", 3);
  setDvar("190", 1.5);
  function_02BB();
  level.var_6EA3 = ::maps\mp\hub_vl_camera::func_6EA2;
  level.var_A595 = [];
  level.var_AAE2 = [];
  level.var_13B8 = [];
  var_00 = 48;
  for(var_01 = 0; var_01 < var_00; var_01++) {
    level.var_13B8[var_01] = spawnStruct();
    level.var_13B8[var_01].var_9A1A = 0;
    level.var_13B8[var_01].var_01D6 = "";
  }

  level.var_6077 = var_00;
  thread maps\mp\hub_vl_camera::func_631E();
  thread maps\mp\hub_vl_camera::func_6320();
  setDvar("1999", 0);
  level.var_6871 = 4;
  maps\mp\hub_vl_firingrange::func_51D0();
}

func_5167() {}

func_0C0E() {
  if(level.var_A1FE) {
    var_00 = spawnStruct();
  } else {
    var_00 = spawn("script_model", (0, 0, 0), 0);
  }

  var_00.var_01A7 = "free";
  return var_00;
}

func_3E76(param_00) {
  param_00 notify("free_avatar");
  if(level.var_A1FE) {
    for(var_01 = 0; var_01 < 48; var_01++) {
      if(param_00.var_A561[var_01]) {
        var_02 = level.var_744A[var_01];
        if(isDefined(var_02)) {
          maps\mp\hub_vl_camera::func_05E0(var_02 getentitynumber(), param_00.var_20F1, "free");
        }
      }
    }

    return;
  }

  param_00 delete();
}

func_6BA7() {
  level.var_0A41["player"]["on_killed"] = ::func_6A75;
  thread maps\mp\hub_vl_camera::func_A59C();
  thread maps\mp\hub_vl_camera::func_631F();
  thread maps\mp\hub_vl_camera::func_62F9(0);
  thread maps\mp\hub_vl_camera::func_62F8(0);
  thread maps\mp\hub_vl_camera::func_62F4();
  thread func_6323(self);
  func_2F52();
}

func_6A75(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {}

func_734C() {
  if(common_scripts\utility::func_55E0()) {
    var_00 = undefined;
    return isDefined(var_00) && var_00 == "thumbstick_southpaw" || var_00 == "thumbstick_legacy";
  }

  return 0;
}

func_7323(param_00) {
  if(!isDefined(param_00.var_3A08)) {
    if(isDefined(param_00.var_942C)) {
      param_00.var_3A08 = param_00.var_942C;
      return;
    }

    param_00.var_3A08 = 0;
  }
}

func_7283(param_00) {
  if(func_734C()) {
    func_7323(param_00);
    return param_00.var_3A08;
  }

  var_01 = self method_8451();
  return var_01[1];
}

func_738B(param_00) {
  var_01 = 0;
  if(func_734C()) {
    func_7323(param_00);
    var_02 = self getnormalizedmovement();
    var_03 = -12;
    var_04 = var_02[1] * var_03;
    param_00.var_3A08 = angleclamp360(param_00.var_3A08 + var_04);
    var_01 = param_00.var_3A08;
  } else {
    var_02 = self method_8451();
    var_01 = var_02[1];
    if(isDefined(param_00.var_3A08)) {
      param_00.var_3A08 = undefined;
    }
  }

  return var_01;
}

func_7699(param_00, param_01) {
  param_00.var_942C = func_7283(param_00);
  param_00.var_7EF8 = 0;
  param_00.var_942A = param_00.var_001D[1];
  param_00.var_6469 = 0;
  param_00.var_7593 = 0;
  param_00.var_6652 = 0;
  param_00.var_09F8 = 0;
  param_01 = (0, param_01[1], 0);
  if(isDefined(param_01)) {
    param_00.var_001D = param_01;
  }
}

func_13B5(param_00) {
  return level.var_13B8[param_00].var_9A1A > 0;
}

func_8099(param_00, param_01) {
  maps\mp\hub_vl_camera::func_7C75(param_00);
}

func_0BC6() {
  if(level.var_A595.size == 0) {
    return 0;
  }

  foreach(var_02, var_01 in level.var_13B8) {
    if(!isDefined(level.var_A595[var_02])) {
      continue;
    }

    if(var_01.var_9A1A == 0) {
      return 0;
    }
  }

  return 1;
}

func_7E37(param_00) {
  var_01 = undefined;
  foreach(var_04, var_03 in level.var_AAE2) {
    var_01 = level.var_A595[var_03];
    level.var_A595[var_03] = undefined;
    function_02BA(var_01, var_04, 1);
    level.var_AAE2[var_04] = undefined;
  }

  level.var_AAE2[param_00] = 0;
  level.var_13B8[0].var_9A1A = 0;
  level.var_13B8[0].var_01D6 = param_00;
  if(isDefined(var_01)) {
    function_02BA(var_01, param_00);
    level.var_A595[0] = var_01;
  }
}

func_0902(param_00) {
  var_01 = -1;
  var_02 = -1;
  while(var_02 == var_01) {
    var_01++;
    foreach(var_02 in level.var_AAE2) {
      if(var_02 == var_01) {
        break;
      }
    }
  }

  func_A59E("Adding new xuid " + param_00 + " with ownerId=" + var_01 + "\n");
  level.var_AAE2[param_00] = var_01;
  level.var_13B8[var_01].var_01D6 = param_00;
  level.var_13B8[var_01].var_9A1A = 0;
  return var_01;
}

func_13B4(param_00) {
  if(isDefined(level.var_6651)) {
    thread maps\mp\hub_vl_camera::func_8A5F();
  }
}

func_A095() {
  var_00 = 0;
  foreach(var_03, var_02 in level.var_13B8) {
    if(var_02.var_9A1A > 0 && gettime() > var_02.var_9A1A) {
      func_A59E("update_avatars removing ownerId" + var_03 + "\n");
      maps\mp\hub_vl_camera::func_7C75(var_03);
      var_00 = 1;
    }
  }

  if(var_00) {
    wait(0.1);
  }
}

func_8BD4() {
  foreach(var_02, var_01 in level.var_A595) {
    if(var_02 == 0) {
      continue;
    }

    maps\mp\hub_vl_camera::func_8BBB(var_01);
  }
}

func_7E92(param_00, param_01) {
  var_02 = func_738B(param_00);
  var_03 = angleclamp360(var_02 - param_00.var_942C);
  var_04 = getdvarfloat("ui_mouse_char_rot", 0);
  if(var_04 != 0) {
    param_00.var_6469 = angleclamp360(param_00.var_6469 + var_04);
    setdynamicdvar("ui_mouse_char_rot", 0);
  }

  var_05 = maps\mp\hub_vl_camera::func_4590(param_00, var_03, param_01);
  var_05 = var_05 * -1;
  var_06 = angleclamp360(param_00.var_942A + var_05 + param_00.var_6469);
  var_07 = (0, var_06, 0);
  if(function_01EF(param_00)) {
    param_00 setangles(var_07);
    return;
  }

  var_08 = distance(var_07, param_00.var_001D);
  if(var_08 > 0.01) {
    maps\mp\hub_vl_camera::func_05E0(param_00.var_721C getentitynumber(), param_00.var_20F1, "angles", var_07);
  }

  param_00.var_001D = var_07;
}

func_73F8(param_00) {
  var_01 = func_7283(param_00);
  var_02 = angleclamp360(var_01 - param_00.var_942C);
  if(self.var_4B9E == 0) {
    if(abs(var_02) >= 1) {
      param_00.var_942A = param_00.var_001D[1];
      return 1;
    }

    return 0;
  }

  return 1;
}

func_2F52() {
  self notify("kill_enable_weapons");
  self method_812B(0);
}

func_3639() {
  self endon("enter_lobby");
  self endon("kill_enable_weapons");
  var_00 = getdvarint("2454", 0);
  if(var_00 == 1 && self.var_50CA == 1) {
    self method_812B(1);
  }
}

func_37B6(param_00) {
  maps\mp\hub_vl_firingrange::func_2A72();
  var_01 = param_00.var_1E99;
  if(!level.var_A1FE) {
    param_00 setorigin(var_01.var_0116);
    param_00 playerlinkto(var_01, "tag_player");
    param_00 method_81E2(var_01, "tag_player");
  }

  if(isDefined(param_00.var_A595) && isDefined(param_00.var_6A4F) && isDefined(level.var_A595[param_00.var_6A4F])) {
    param_00 func_7699(level.var_A595[param_00.var_6A4F], level.var_A595[param_00.var_6A4F].var_001D);
  }

  param_00.var_50CA = 0;
  param_00 method_812B(0);
  maps\mp\_utility::func_A165("spectator");
}

func_6323(param_00) {
  for(;;) {
    if(isDefined(param_00.var_50CA)) {
      var_01 = getdvarint("2454", 0);
      if(var_01 == 1 && !param_00.var_50CA) {
        var_02 = maps\mp\_utility::func_445D("lobby" + param_00.var_294D + 1);
        var_03 = maps\mp\_utility::func_1E01();
        var_04 = param_00.var_5E01[var_03][var_02];
        var_05 = var_04["primaryWeaponStruct"];
        var_06 = var_04["secondaryWeaponStruct"];
        var_07 = var_04["meleeWeaponStruct"];
        if(isDefined(level.var_A595) && isDefined(param_00.var_6A4F) && isDefined(level.var_A595[param_00.var_6A4F])) {
          param_00 func_7699(level.var_A595[param_00.var_6A4F], level.var_A595[param_00.var_6A4F].var_001D);
        }

        var_08 = [];
        if(isDefined(var_05) && isDefined(var_05.var_48CA) && var_05.var_48CA != 0) {
          var_09 = maps\mp\_utility::func_4737(var_05);
          var_08[var_08.size] = maps\mp\gametypes\_class::func_1D66(var_09, var_04["primaryAttachmentsGUID"][0], var_04["primaryAttachmentsGUID"][1], var_04["primaryAttachmentsGUID"][2], var_04["primaryAttachmentsGUID"][3], var_04["primaryAttachmentsGUID"][4], var_04["primaryAttachmentsGUID"][5], maps\mp\_utility::func_472D(var_05), 0, 0, 0, 0);
        }

        if(isDefined(var_06) && isDefined(var_06.var_48CA) && var_06.var_48CA != 0) {
          var_09 = maps\mp\_utility::func_4737(var_06);
          var_08[var_08.size] = maps\mp\gametypes\_class::func_1D66(var_09, var_04["secondaryAttachmentsGUID"][0], var_04["secondaryAttachmentsGUID"][1], var_04["secondaryAttachmentsGUID"][2], var_04["secondaryAttachmentsGUID"][3], var_04["secondaryAttachmentsGUID"][4], var_04["secondaryAttachmentsGUID"][5], maps\mp\_utility::func_472D(var_06), 0, 0, 0, 0);
        }

        if(isDefined(var_07) && isDefined(var_07.var_48CA) && var_07.var_48CA != 0) {
          var_08[var_08.size] = maps\mp\_utility::func_4737(var_07);
        }

        while(var_08.size > 0) {
          var_0A = param_00 method_8512(var_08);
          if(var_0A == 1) {
            break;
          }

          wait 0.05;
        }

        param_00 method_848C();
        maps\mp\hub_vl_firingrange::func_37B1(param_00);
        param_00 method_8627("mp_no_foley", 1);
        setDvar("1175", 0);
        setDvar("190", 1);
      } else if(var_01 == 0 && param_00.var_50CA) {
        param_00 method_848D();
        param_00 func_3C3C();
        param_00 func_2F52();
        if(isDefined(param_00.var_7704)) {
          param_00 switchtoweapon(param_00.var_7704);
        }

        param_00 notify("enter_lobby");
        func_37B6(param_00);
        param_00 method_8626("mp_no_foley", 1);
        setDvar("1175", 3);
        setDvar("190", 1.5);
      }
    }

    wait 0.05;
  }
}

func_3C3C() {
  var_00 = self;
  var_00 maps\mp\hub_vl_firingrange::func_4864();
  var_01 = var_00 getweaponslistoffhands();
  foreach(var_03 in var_01) {
    var_00 maps\mp\gametypes\_class::func_95EE(var_03);
  }
}

func_636A(param_00) {
  for(;;) {
    param_00 waittill("luinotifyserver", var_01);
    if(var_01 != "hub_firing_range_selected") {
      continue;
    }

    if(isDefined(param_00.var_5721)) {
      wait 0.05;
      param_00 setclientdvar("3078", "1.0");
      param_00 maps\mp\hub_vl_camera::func_8662();
      if(!param_00.var_5721) {
        param_00 maps\mp\gametypes\_hub_range::func_98C7();
        param_00 unlink();
        param_00 method_81E3();
        continue;
      }

      param_00 maps\mp\gametypes\_hub_range::func_21C0();
    }
  }
}
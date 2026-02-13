/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_infils.gsc
*************************************************/

main() {
  var_0 = getent("infil_plane", "script_noteworthy");
  level._id_2BDB = ::_id_90D3;

  if(isDefined(var_0)) {
    var_0 hide();
  }

  setdvarifuninitialized("#x32d048c94541b21e1", 1);
  setdvarifuninitialized("#x34e4b4920fce20de4", 1);
  setdvarifuninitialized("#x3547be7d8c31064c2", 0);
  level._id_7E77 = "";
  level._id_7E69 = 0;

  if(istrue(getdvarint("#x3a9fb72eb1369e20", 0))) {
    level._id_7E77 = getDvar("#x3de5c7f1586eee693", "exclusion");
    level._id_7E69 = 1;
    level._id_31DB = getdvarint("#x33301391dc2126c8f", 1);
  }

  _id_8292();
  _id_81FD();
}

_id_D66D() {
  scripts\mp\utility\player::_id_5265(0);
  self allowmelee(0);
  self disableoffhandweapons();
  level._id_5F50 = ::_id_5F52;
}

_id_5F52() {
  self allowmelee(1);
  self enableoffhandweapons();
}

_id_2E33() {
  self endon("disconnect");

  if(self.class == "") {
    self.class = "custom1";
    self.pers["class"] = "custom1";
  }

  scripts\mp\playerlogic::_id_E337(0);
  self._id_2A61 = 1;
  self notify("brWaitAndSpawnClientComplete");
  self setclientomnvar("ui_br_transition_type", 0);
  self setclientomnvar("ui_br_extended_load_screen", 0);
}

_id_107FA() {
  foreach(var_1 in level.players) {
    var_1 _id_533F();

    if(!isalive(var_1)) {
      var_1 _id_2E33();
    } else {
      var_1._id_2A61 = 1;
    }

    var_1 notify("beginC130");
  }

  if(level.teambased) {
    foreach(var_4 in level._id_EF89) {
      var_5 = scripts\mp\utility\teams::_id_6DCA(var_4, "players");
      var_6 = _id_D851(var_5);

      if(isDefined(var_6)) {
        _id_C244(var_6);
        var_6 thread _id_10A9E(var_4);
      }

      scripts\mp\gametypes\br::_id_FD3C(var_4);
    }
  } else {
    foreach(var_1 in level.players) {
      _id_C244(var_1);
    }
  }

  if(!scripts\mp\gametypes\br_gametypes::_id_8853("oneLife")) {
    level._id_4AE8 = 1;
    setdynamicdvar(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_numLives"), 1);
  }

  level._id_DEC7 = 1;
}

_id_533F() {
  var_0 = self;
  var_0 _meth_86B2(0);
  var_0 _meth_86B3(0);

  if(isDefined(var_0._id_5A0F)) {
    var_0._id_5A0F = 5;
  }

  var_0 _id_0797::_id_AE27();
}

_id_C244(var_0) {
  if(!istrue(var_0._id_8C9A)) {
    var_0._id_8C9A = 1;
    var_0 scripts\mp\gametypes\br_public::_id_FC1A("jumpMasterState", 2);
    var_0 notifyonplayercommand("halo_jump_c130", "+gostand");
    var_0 notifyonplayercommand("br_break_squad", "+breath_sprint");
  }
}

_id_10A9E(var_0) {
  scripts\engine\utility::waittill_any_2("death", "disconnect");
  var_1 = scripts\mp\utility\teams::_id_6DCA(var_0, "players");
  var_2 = _id_D851(var_1);

  if(isDefined(var_2)) {
    _id_C244(var_2);
    var_2 thread _id_10A9E(var_0);
  }
}

_id_AF98() {
  var_0 = (0, 0, 3000);

  if(isDefined(level._id_BBB2) && level._id_BBB2.size > 0) {
    var_1 = scripts\engine\utility::random(level._id_BBB2);
    var_0 = var_1.origin;
  }

  var_2 = (0, randomintrange(0, 360), 0);
  self setorigin(var_0, 1);
  self setplayerangles(var_2);
  wait 0.2;
  thread _id_0797::_id_E6AD(0, 1);
}

_id_90D3() {
  self endon("disconnect");
  var_0 = self;

  if(!isalive(var_0)) {
    var_0 scripts\mp\playerlogic::_id_E337(0);
  }

  if(level.teambased) {
    var_1 = scripts\mp\utility\teams::_id_6DCA(var_0.team, "players");

    if(!isDefined(var_1) || var_1.size == 0) {
      var_1 = [self];
    }

    var_2 = _id_D851(var_1);

    if(isDefined(var_2)) {
      _id_C244(var_2);
    } else {}
  } else {
    var_0 scripts\mp\gametypes\br_public::_id_FC1A("jumpMasterState", 2);
    _id_C244(var_0);
  }

  var_0._id_2A61 = 1;
}

_id_EDC8(var_0) {
  self takeweapon(self.weaponlist[0]);
  var_1 = makeweapon("ks_remote_map_snatch");
  var_2 = self getweaponslistall();

  foreach(var_4 in var_2) {
    if(scripts\mp\utility\weapon::_id_887A(var_4)) {
      continue;
    }
    if(issameweapon(var_1, var_4)) {
      continue;
    }
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_4);
  }

  self.primaryweaponobj = undefined;
  self._id_034C = "none";
  self.pers["primaryWeapon"] = self._id_034C;
  self.secondaryweaponobj = undefined;
  self._id_03B5 = "none";
  self.pers["secondaryWeapon"] = self._id_03B5;

  if(!istrue(var_0)) {
    var_6 = _id_6A53();
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_6, 1);
    thread scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_6);
    self setspawnweapon(var_6, 1);

    if(level._id_992A == 0) {
      self setweaponammoclip(var_6, 0);
      self setweaponammostock(var_6, 0);
    } else {
      self setweaponammoclip(var_6, weaponclipsize(var_6));
      self setweaponammostock(var_6, weaponclipsize(var_6) * (level._id_992A - 1));
    }

    self.secondaryweaponobj = var_6;
    self._id_03B5 = getcompleteweaponname(self.secondaryweaponobj);
    self.pers["secondaryWeapon"] = self._id_03B5;
  }
}

_id_6A53() {
  return scripts\mp\class::buildweapon("s4_pi_mike1911", ["reflex", "none", "none", "none", "none"], "none", "none", -1, undefined, undefined, undefined, undefined, undefined, 0);
}

_id_D851(var_0) {
  if(var_0.size == 0) {
    return undefined;
  }

  var_1 = undefined;

  foreach(var_3 in var_0) {
    if(isDefined(var_3) && var_3 scripts\mp\gametypes\br_public::_id_898B()) {
      return var_3;
    }
  }

  foreach(var_3 in var_0) {
    if(level.onlinegame && var_3 _meth_81BF()) {
      var_1 = var_3;
      break;
    }
  }

  if(!isDefined(var_1)) {
    var_7 = 0;
    var_8 = 0;

    foreach(var_3 in var_0) {
      var_10 = var_7 == isbot(var_3);

      if(var_10) {
        var_8++;
        var_11 = 1.0 / var_8;

        if(randomfloat(1.0) < var_11) {
          var_1 = var_3;
        }
      }
    }
  }

  if(!isDefined(var_1)) {
    foreach(var_3 in var_0) {
      var_1 = var_3;
      break;
    }
  }

  if(!isDefined(var_1)) {
    return undefined;
  }

  var_1 scripts\mp\gametypes\br::_id_D65B(1);

  foreach(var_3 in var_0) {
    if(var_3 != var_1) {
      var_3 scripts\mp\gametypes\br::_id_D65B(0);
    }

    var_16 = scripts\engine\utility::ter_op(var_3 scripts\mp\gametypes\br_public::_id_898B(), 2, 1);
    scripts\mp\gametypes\br_c130::_id_D715(var_3, var_0, var_16);
  }

  return var_1;
}

_id_2CFB(var_0, var_1) {
  var_2 = spawnStruct();

  if(isDefined(var_0)) {
    var_0._id_18E7 = var_2;
    var_2._id_A289 = var_0;
  }

  var_2._id_E76A = getent("infil_plane", "script_noteworthy");

  if(isDefined(var_2._id_E76A)) {
    var_2._id_E76A show();
  } else {
    var_2._id_E76A = spawn("script_model", _func_0093("#x3993dd53959159c8a", (0, 0, 0)));
    var_2._id_E76A setModel("veh8_mil_air_acharlie130_magma_animated");
    var_2._id_E76A._id_3841 = 1;
  }

  var_2._id_3085 = spawn("script_model", var_2._id_E76A.origin);
  var_2._id_3085 setModel("generic_prop_x5");

  if(isDefined(var_0)) {
    var_2._id_3087 = spawn("script_model", var_2._id_A289.origin);
    var_2._id_3087 setModel("generic_prop_x5");
    var_2._id_3087 linkto(var_2._id_A289, "tag_origin", (0, 0, 0), (0, 0, 0));
  }

  _id_E33C(var_2, var_2._id_E76A);

  if(var_1 == "script_model") {
    var_2._id_B7C2 = spawn("script_model", var_2._id_E76A.origin);
    var_2._id_B7C2 setModel("fullbody_usmc_ar_br_infil");
    var_2._id_B7C3 = spawn("script_model", var_2._id_E76A.origin);
    var_2._id_B7C3 setModel("fullbody_usmc_ar_br_infil");
    var_2._id_B7C4 = spawn("script_model", var_2._id_E76A.origin);
    var_2._id_B7C4 setModel("fullbody_usmc_ar_br_infil");
    var_2._id_B7C5 = spawn("script_model", var_2._id_E76A.origin);
    var_2._id_B7C5 setModel("fullbody_usmc_ar_br_infil");
    var_2._id_B7C2 linkto(var_2._id_B758["parent"], "j_prop_1", (0, 0, 0), (0, 0, 0));
    var_2._id_B7C3 linkto(var_2._id_B758["parent"], "j_prop_2", (0, 0, 0), (0, 0, 0));
    var_2._id_B7C4 linkto(var_2._id_B758["parent"], "j_prop_3", (0, 0, 0), (0, 0, 0));
    var_2._id_B7C5 linkto(var_2._id_B758["parent"], "j_prop_4", (0, 0, 0), (0, 0, 0));
    var_2._id_7E26 = "script_model";
  } else {
    var_3 = ["j_prop_1", "j_prop_2", "j_prop_3", "j_prop_4"];

    foreach(var_5 in var_3) {
      _id_E33B(var_2, var_5);
    }

    var_2._id_7E26 = "player";
  }

  var_2._id_1314 = spawn("script_model", var_2._id_E76A.origin);
  var_2._id_1314 setModel("fullbody_usmc_ar_br_infil");

  if(isDefined(var_0)) {
    var_2._id_A289._id_82CD linkto(var_2._id_A289, "", (0, 0, 0), (0, 0, 0));
  }

  var_2._id_1314 linkto(var_2._id_B758["parent"], "j_prop_5", (0, 0, 0), (0, 0, 0));
  var_2._id_3085 linkto(var_2._id_E76A, "", (0, 0, 0), (0, 0, 0));
  var_2._id_39FE = spawnfx(level._effect["vfx_br_infil_cloud_anim"], var_2._id_E76A.origin);
  return var_2;
}

_id_E33C(var_0, var_1) {
  var_0._id_B758["parent"] = spawn("script_model", var_1.origin);
  var_0._id_B758["parent"] setModel("generic_prop_x5");
  var_0._id_B758["parent"] linkto(var_1, "", (0, 0, 0), (0, 0, 0));
}

_id_E33B(var_0, var_1) {
  var_0._id_B758[var_1] = spawn("script_model", var_0._id_B758["parent"] gettagorigin(var_1));
  var_0._id_B758[var_1] setModel("tag_player");
  var_0._id_B758[var_1] linkto(var_0._id_B758["parent"], var_1, (0, 0, 0), (0, 0, 0));
}

_id_68C9(var_0) {}

_id_B86C(var_0) {
  var_1 = "";

  if(var_0 scripts\mp\gametypes\br_public::_id_898B()) {
    var_1 = "br_infil_squad_leader_jump";
  } else {
    var_1 = "br_infil_squadmate_jump";
  }

  var_0 playsoundtoteam(var_1, var_0.team, var_0);
}

_id_10B88(var_0) {
  self endon("death_or_disconnect");

  if(!isDefined(level._id_7E70)) {
    level._id_7E70 = 0;
  }

  self._id_75B6 = 0;
  self waittill("br_jump");
  var_1 = scripts\mp\utility\teams::_id_6DCA(self.team, "players");
  var_2 = [];

  if(self._id_8CA7 == "leader") {
    foreach(var_4 in var_1) {
      if(isDefined(var_4._id_7E64)) {
        var_2[var_2.size] = var_4;
      }
    }
  } else if(self._id_8CA7 == "solo" || self._id_8CA7 == "outOfBounds")
    var_2 = [self];

  var_6 = var_2.size > 0;

  if(var_6) {
    var_7 = getdvarint("#x34e4b4920fce20de4", 1) != 0;

    if(level._id_7E70 >= 100) {
      var_7 = 0;
    }

    var_8 = undefined;

    if(var_7) {
      var_8 = 0;
      [var_10, var_11, var_12] = _id_68C9(var_0);
      var_13["parent"] = spawn("script_model", var_0._id_A289.origin);
      level._id_7E70++;
      var_13["parent"] setModel("generic_prop_x10");
      var_13["parent"] linkto(var_0._id_A289, "tag_body", (0, 0, 0), (0, 0, 0));

      foreach(var_4 in var_2) {
        var_15 = "j_prop_" + (var_4._id_7E64 + 2);
        var_13[var_15] = spawn("script_model", var_13["parent"] gettagorigin(var_15));
        level._id_7E70++;
        var_13[var_15] setModel("tag_player");
        var_13[var_15] linkto(var_13["parent"], var_15, (0, 0, 0), (0, 0, 0));
        var_4 playerlinkto(var_13[var_15], "tag_player");
        var_4 playershow(1);
        var_4 _meth_84FF("scripted_scene", var_12);
        var_4._id_7E64 = undefined;
        var_4 playlocalsound("scr_br_infil_jump_stinger");
        level thread _id_B86C(var_4);
      }

      var_13["parent"] _meth_82CB(var_10, "prop");
      var_17 = _func_0079(var_11);
      var_18 = 1.0;
      var_17 = max(var_17, var_18 + 0.1);
      wait(var_17 - var_18);

      foreach(var_4 in var_2) {
        var_4 cameradefault();
      }

      wait(var_18);

      foreach(var_22 in var_13) {
        var_22 delete();
        level._id_7E70--;
      }
    } else {
      var_8 = 1;
      waittillframeend;
    }

    foreach(var_4 in var_2) {
      var_4._id_7E64 = undefined;
      var_4 _meth_8655();
      var_4 notify("infil_jump_done");
      var_4 scripts\mp\gametypes\br::_id_B6A4();
    }

    if(var_8) {
      waitframe();

      if(isDefined(var_0._id_A289)) {
        if(isDefined(var_0._id_A289._id_B72B) && isDefined(var_0._id_A289._id_41E2)) {
          foreach(var_4 in var_2) {
            var_27 = var_0._id_A289._id_B72B[var_0._id_A289._id_41E2];
            var_4 setorigin(var_0._id_A289.origin + var_27, 1, 1);
            var_0._id_A289._id_41E2++;

            if(var_0._id_A289._id_41E2 == var_0._id_A289._id_B72B.size) {
              var_0._id_A289._id_41E2 = 0;
            }

            var_4 playershow(1);
            level thread _id_B86C(var_4);
          }
        }
      }
    }
  }
}

_id_B855(var_0) {}

_id_B710(var_0) {
  if(!isDefined(self._id_7E64)) {
    self._id_7E64 = 1;
  }

  var_1 = "j_prop_" + self._id_7E64;
  self playerlinkto(var_0._id_B758[var_1], "tag_player");
}

_id_B742(var_0) {}

_id_C16D(var_0) {
  var_0 endon("stopScene");
  var_0._id_E76A waittillmatch("plane", "gored");
  var_1 = _func_03C0("infil_blinking_light", "script_noteworthy");

  foreach(var_3 in var_1) {
    var_3 setscriptablepartstate("light_blinking_slow", "light_on", 1);
  }
}

_id_7133(var_0) {
  var_0 endon("stopScene");
  var_0._id_E76A waittillmatch("plane", "gogreen");
  var_1 = _func_03C0("infil_blinking_light", "script_noteworthy");

  foreach(var_3 in var_1) {
    var_3 setscriptablepartstate("light_blinking_slow", "light_jump", 1);
  }
}

_id_A97B(var_0) {
  var_1 = _func_03C0("infil_blinking_light", "script_noteworthy");

  foreach(var_3 in var_1) {
    var_3 setscriptablepartstate("light_blinking_slow", "light_off_hold", 1);
  }
}

_id_B822(var_0) {
  var_0 endon("stopScene");
  var_0._id_E76A scripts\engine\utility::_id_108E4("plane", "opendoor", 30.0);

  foreach(var_2 in level.players) {
    if(isbot(var_2)) {
      continue;
    }
    var_2 scripts\mp\utility\player::_id_D8F0("100", 1);
  }

  var_0._id_1314 scripts\mp\utility\player::_id_D8F0("100");
}

_id_396E(var_0) {
  foreach(var_2 in level.players) {
    var_2._id_9A67 = undefined;
  }

  var_0._id_1314 scripts\mp\utility\player::_id_D8F0("0");
}

_id_397E() {
  _id_107DB(7.7);

  foreach(var_1 in level.players) {
    var_1 _meth_8680("mp_br_infil_ac130", 30.0);
  }
}

_id_397F() {
  _id_107DB(0.65);

  foreach(var_1 in level.players) {
    var_1 _meth_8680("mp_br_infil_anim", 3.0);
  }
}

_id_397D() {
  _id_107DB(0.5);

  foreach(var_1 in level.players) {
    var_1 _meth_8680("fade_to_black_all_except_music_scripted5_and_amb", 1.0);
  }
}

_id_D6D4() {
  _id_107DB(2.0);

  foreach(var_1 in level.players) {
    var_1 _meth_8680("fade_to_black_all_except_music_and_scripted5", 0.5);
    var_1 _meth_867F("fade_to_black_all_except_music_scripted5_and_amb", 2.0);
  }
}

_id_B318(var_0) {
  thread _id_D6D4();
  _id_B317(var_0);
  _id_F490(var_0);
  _id_52DC(var_0);
}

_id_39FD(var_0) {
  var_0 endon("stopScene");
  var_0._id_E76A waittillmatch("plane", "transitionstart");
  triggerfx(var_0._id_39FE);
}

_id_58A4(var_0) {
  level endon("game_ended");

  if(!isDefined(var_0._id_3087)) {
    return;
  }
  var_1 = newhudelem();
  var_1.x = 0;
  var_1.y = 0;
  var_1 setshader("white", 640, 480);
  var_1.alignx = "left";
  var_1.aligny = "top";
  var_1.horzalign = "fullscreen";
  var_1.vertalign = "fullscreen";
  var_1.sort = -1;
  var_1.color = (0.88, 0.88, 0.88);
  var_1.alpha = 0;
  var_2 = 0.16;
  var_3 = 0.5;
  var_0._id_3087 waittillmatch("camera", "fadeinstart");
  var_1 fadeovertime(var_2);
  var_1.alpha = 1;
  var_0._id_3087 waittillmatch("camera", "fadeoutstart");
  var_1 fadeovertime(var_3);
  var_1.alpha = 0;
  _id_107DB(var_3 + 0.1);
  var_1 destroy();
}

_id_7E4A(var_0) {
  var_1 = getdvarfloat("#x3931e06e107a35919");
  var_2 = getdvarint("#x3beed502923a4c08f");
  var_3 = getdvarint("#x366a409d6a93d9df2");
  var_4 = getdvarfloat("#x3c51757bb6571dfe4");
  setDvar("#x3931e06e107a35919", 1000.0);
  setDvar("#x3beed502923a4c08f", 6);
  setDvar("#x366a409d6a93d9df2", 8);
  setDvar("#x3c51757bb6571dfe4", 0.25);
  var_0 scripts\engine\utility::_id_108C5("infil_reset_light_dvars", "stopScene");
  setDvar("#x3931e06e107a35919", var_1);
  setDvar("#x3beed502923a4c08f", var_2);
  setDvar("#x366a409d6a93d9df2", var_3);
  setDvar("#x3c51757bb6571dfe4", var_4);
}

_id_B317(var_0) {}

_id_46E1(var_0) {
  if(isDefined(var_0._id_A289) && getdvarint("#x3f6ad17a46fd88865", 1) == 1) {
    var_1 = getdvarint("#x331e2ee3e3e6f1978", 8);
    wait(var_1);
    var_2 = var_0._id_A289.origin;
    var_3 = getdvarint("#x395ec053e2734b0ba", 0);

    if(var_3 > 0) {
      var_4 = anglesToForward(var_0._id_A289.angles);
      var_2 = var_0._id_A289.origin + var_4 * var_3;
    }

    foreach(var_6 in level.players) {
      var_6 _meth_87A2(0.0);
      var_6 scripts\mp\gametypes\br_public::_id_B7E6(var_2);
    }
  }
}

_id_E93F(var_0) {
  if(isDefined(var_0._id_A289) && getdvarint("#x3f6ad17a46fd88865", 1) == 1) {
    var_1 = getdvarint("#x33934635b2de5686d", 5);
    wait(var_1);

    foreach(var_3 in level.players) {
      var_3 thread scripts\mp\gametypes\br_public::_id_B67D();
    }
  }
}

_id_F947(var_0) {
  wait(var_0);

  foreach(var_2 in level.players) {
    var_2 scripts\mp\utility\player::_id_0BEE(0);
  }
}

_id_F490(var_0) {
  var_1 = 65;
  var_2 = 14;
  var_3 = 35;
  var_4 = 2.0;
  var_5 = 4;

  if(isDefined(var_0._id_3087)) {
    foreach(var_7 in level.players) {
      var_7 _meth_87A3(0.0);

      if(!isDefined(var_7._id_7E64)) {
        var_7._id_7E64 = 1;
      }

      var_0._id_3086 = "j_prop_" + var_7._id_7E64;
      var_7 _meth_8060();
      var_7 cameralinkto(var_0._id_3087, var_0._id_3086, 1, 1);
      var_7 setclientdvar("#x356e0c9e15809767a", var_1);
      var_7 _meth_8660(var_2, var_3, var_4, var_5);
    }

    thread _id_397D();
  } else {
    foreach(var_7 in level.players) {
      var_7 _meth_87A3(0.0);
    }
  }

  if(isDefined(var_0._id_39FE)) {
    if(isDefined(var_0._id_A289)) {
      var_0._id_39FE.origin = var_0._id_A289.origin;
    }
  }

  var_0._id_E76A hide();
  var_0._id_3085 unlink();
  var_0._id_B758["parent"] unlink();

  if(isDefined(var_0._id_A289)) {
    var_0._id_B758["parent"] linkto(var_0._id_A289, "", (0, 0, 0), (0, 0, 0));
    var_0._id_3085 linkto(var_0._id_A289, "", (0, 0, 0), (0, 0, 0));
    var_0._id_A289 notify("start_moving");
  }

  setomnvar("ui_hide_player_icons", 0);

  foreach(var_7 in level.players) {
    if(!isDefined(var_7)) {
      continue;
    }
    var_7 _meth_82FA("mp_donetsk_infil_ext", 2.0);
  }

  thread _id_397E();
  level thread _id_B319(var_0);

  if(isDefined(var_0._id_3087)) {
    var_0._id_3087 waittillmatch("camera", "end");
  }

  thread _id_F947(1.2);
}

_id_52DC(var_0) {
  thread _id_94B2();
  stopFXOnTag(level._effect["vfx_br_ac130_clouds"], var_0._id_E76A, "tag_body");
  var_0._id_E76A stoploopsound();

  if(isDefined(var_0._id_A289)) {
    var_0._id_A289 playLoopSound("br_ac130_lp");
  }

  foreach(var_2 in level.players) {
    var_2 _meth_87A3(0.0);
    var_2 _meth_8060();
    var_2 setclientdvar("#x356e0c9e15809767a", 65);
    var_2 _meth_865E();
    var_2 scripts\mp\utility\player::_id_D51E();
  }

  level thread _id_E93F(var_0);
}

_id_B319(var_0) {}

_id_7E7E() {
  var_0 = "mp_donetsk_c130_intro";
  _func_01B8(var_0);
}

_id_7E7D() {
  var_0 = "mp_donetsk_c130_intro";
  _func_02E3("lobby_fade", "", 2);

  foreach(var_2 in level.players) {
    var_2 playlocalsound("br_infil_part1_lr");
    var_2 _meth_8680("mp_br_lobby_fade", 1.5);
    var_2 _meth_867F("fade_to_black_all_except_music_and_scripted5", 0.5);
    var_3 = game["music"]["br_infil_intro"].size - 1;
    var_4 = randomint(var_3);
    var_2 setplayermusicstate(game["music"]["br_infil_intro"][var_4]);
  }

  _func_0199(var_0);

  foreach(var_2 in level.players) {
    var_2 setclientomnvar("ui_br_bink_overlay_state", 3);
  }
}

_id_7E7C(var_0, var_1) {
  if(var_0 == "bink_complete") {
    self setclientomnvar("ui_br_bink_overlay_state", 0);
    self _meth_8769();
  }
}

_id_7E7F() {
  _id_0A9A::_id_C287(::_id_7E7C);
  wait 3.2;
}

_id_24A4(var_0, var_1) {
  foreach(var_3 in level.players) {
    var_3 _meth_87A3(-1.0);
  }

  level._id_7E79 = spawnStruct();
  level._id_7E79._id_B7B5 = 0;

  if(!isDefined(var_0)) {
    var_0 = scripts\mp\gametypes\br_c130::_id_4061();
  }

  level._id_7E79._id_2E3A = var_0;
  level._id_7E79._id_F4AB = scripts\mp\gametypes\br_c130::_id_E270(level._id_7E79._id_2E3A);
  level._id_7E79._id_5BC5 = level._id_7E79._id_F4AB + gettime();
  var_5 = _id_2CFB(level._id_29F4, var_1);
  _id_7E7E();

  if(isDefined(level._id_BB92)) {
    [[level._id_BB92]](var_5);
  }

  level._id_7E6A = 1;
  level._id_15CA = 0;
  level._id_29F4 thread _id_7303();
  _id_F49A(level.players, var_1, var_5._id_E76A);

  if(scripts\mp\gametypes\br_public::_id_878D() || scripts\mp\gametypes\br_public::_id_8804()) {
    foreach(var_3 in level.players) {
      if(isPlayer(var_3)) {
        var_3 notify("play_intro");
      }
    }
  }

  _id_7E7D();
  _id_7E7F();
  level thread _id_7E62(0.0, 3.45, 0.6);
  _id_B318(var_5);
  _id_F499(level.players, var_1);
  level._id_7E6A = 0;
  level._id_7E79._id_7E26 = var_1;
  scripts\mp\gametypes\br_public::_id_2BDC("match_start");

  foreach(var_3 in level.players) {
    var_3 thread _id_B6EC();

    if(var_3 _meth_878F()) {
      _id_C25F(var_3);
    }
  }

  if(isDefined(level._id_75FE)) {
    level thread _id_75FF();
  }
}

_id_7E62(var_0, var_1, var_2, var_3) {
  if(!isDefined(level._id_7E65)) {
    level._id_7E65 = newhudelem();
    level._id_7E65.x = 0;
    level._id_7E65.y = 0;
    level._id_7E65 setshader("black", 640, 480);
    level._id_7E65.alignx = "left";
    level._id_7E65.aligny = "top";
    level._id_7E65.horzalign = "fullscreen";
    level._id_7E65.vertalign = "fullscreen";
    level._id_7E65.sort = -1;
  }

  if(isDefined(var_0) && var_0 > 0) {
    foreach(var_5 in level.players) {
      var_5 _meth_867F("iw8_br_infil_fadeout", 0.0);
      var_5 _meth_867F("mp_br_infil_music", 0.0);
    }

    level._id_7E65.alpha = 0;
    level._id_7E65 fadeovertime(var_0);
    level._id_7E65.alpha = 1;
    wait(var_0);
  }

  if(!scripts\mp\gametypes\br_public::_id_8ACA()) {
    level._id_7E65.alpha = 1;

    foreach(var_5 in level.players) {
      var_5 _meth_867F("mp_br_infil_anim", 0.0);
      var_5 _meth_867F("mp_br_infil_ac130", 0.0);
    }
  }

  if(isDefined(var_3)) {
    level waittill(var_3);
  }

  if(isDefined(var_1) && var_1 > 0) {
    wait(var_1);
  }

  if(isDefined(var_2) && var_2 > 0) {
    level._id_7E65.alpha = 1;
    level._id_7E65 fadeovertime(var_2);
    level._id_7E65.alpha = 0;

    foreach(var_5 in level.players) {
      if(!scripts\mp\gametypes\br_public::_id_8ACA()) {
        var_5 _meth_82FA("mp_donetsk_infil_int", var_2);
      }

      var_5 _meth_8680("iw8_br_infil_fadeout", 2);
    }

    wait(var_2);
  }

  level._id_7E65.alpha = 0;
}

_id_7E63(var_0, var_1, var_2) {
  if(!isDefined(level._id_7E83)) {
    level._id_7E83 = newhudelem();
    level._id_7E83.x = 0;
    level._id_7E83.y = 0;
    level._id_7E83 setshader("white", 640, 480);
    level._id_7E83.alignx = "left";
    level._id_7E83.aligny = "top";
    level._id_7E83.horzalign = "fullscreen";
    level._id_7E83.vertalign = "fullscreen";
    level._id_7E83.sort = -1;
  }

  if(isDefined(var_0) && var_0 > 0) {
    level._id_7E83.alpha = 0;
    level._id_7E83 fadeovertime(var_0);
    level._id_7E83.alpha = 1;

    foreach(var_4 in level.players) {
      var_4 _meth_867F("iw8_mp_end_round", var_0);
    }

    _id_107DB(var_0);
  }

  if(isDefined(var_1) && var_1 > 0) {
    _id_107DB(var_1);
  }

  if(isDefined(var_2) && var_2 > 0) {
    level._id_7E83.alpha = 1;
    level._id_7E83 fadeovertime(var_2);
    level._id_7E83.alpha = 0;

    foreach(var_4 in level.players) {
      var_4 _meth_8680("iw8_mp_end_round", var_2);
    }

    _id_107DB(var_2);
  }
}

_id_F49A(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    if(isDefined(var_2)) {
      var_4._id_2E0E = level._id_29F4;
    }

    var_4 scripts\mp\utility\player::_id_7903();
  }

  _id_07C5::_id_C46D();
  setomnvar("ui_hide_player_icons", 1);
  thread _id_7E62(1, 1.5, 1, "prematch_respawn_finished");

  foreach(var_4 in var_0) {
    if(!isDefined(var_4)) {
      continue;
    }
    var_4 _meth_8282(var_2.origin, 1);
  }

  _id_107DB(1);
  setomnvar("ui_in_infil", 1);
  level notify("prematch_fade_done");
  _id_107FA();
  level notify("prematch_respawn_finished");

  foreach(var_4 in var_0) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(!isDefined(var_4.sessionstate) || var_4.sessionstate == "spectator") {
      continue;
    }
    var_4 setorigin(var_2.origin);
  }

  _id_107DB(1.5);

  foreach(var_4 in var_0) {
    if(!isDefined(var_4)) {
      continue;
    }
    var_4 _meth_8283();
    var_4 _id_533F();
  }

  if(var_1 == "script_model") {
    foreach(var_4 in var_0) {
      var_4 playerhide();
    }
  }
}

_id_F499(var_0, var_1) {
  var_2 = var_1 == "script_model";

  foreach(var_4 in var_0) {
    if(scripts\mp\gametypes\br::_id_6516(var_4._id_7904) > 0) {
      var_4 scripts\mp\utility\player::_id_7901();
    }

    var_4 _meth_844E("", 1.0);

    if(var_2) {
      var_4 playershow();
    }
  }

  setomnvar("ui_in_infil", -1);
}

_id_7303() {
  level endon("game_ended");
  self notify("ac130_player_count");
  self endon("ac130_player_count");

  for(;;) {
    setomnvar("ui_br_players_left_in_plane", level._id_7E79._id_B7B5);

    if(!isDefined(self)) {
      break;
    }

    wait 0.5;
  }
}

_id_B6EC() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("joining_Infil");
  var_0 = self;
  var_0._id_2A61 = 1;
  var_0.health = var_0.maxhealth;
  var_0 scripts\mp\gametypes\br_c130::_id_E33E();
  var_0 _id_B7A7();
  var_0 scripts\mp\gametypes\br_public::_id_FC1A("isInInfilPlane", 1);
  level._id_7E79._id_B7B5++;
  var_0 thread _id_B678();
}

_id_B678() {
  level endon("game_ended");
  self endon("death");
  self endon("cancel_c130");
  self endon("br_jump");
  self waittill("disconnect");

  if(isDefined(level._id_7E79) && isDefined(level._id_7E79._id_B7B5)) {
    level._id_7E79._id_B7B5--;
  }
}

_id_B7A7(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  self setclientomnvar("ui_br_infil_started", 1);
  self setclientomnvar("ui_br_infiled", 0);

  if(!var_0) {
    self notifyonplayercommand("halo_jump_c130", "+gostand");
  } else {
    self notifyonplayercommand("halo_jump_solo_c130", "+gostand");
  }

  self notifyonplayercommand("br_pass_squad_leader", "+usereload");
  self notifyonplayercommand("br_pass_squad_leader", "+activate");
}

_id_6B0A() {}

_id_94B3() {}

_id_94B2() {}

_id_81FD() {
  _id_C261("exclusion", ::_id_7443, ::_id_E36E, ::_id_E36F);
}

_id_745D(var_0) {
  var_1 = self;
  var_2 = level._id_7E77;
  var_3 = _id_6AB9(var_2);

  if(!isDefined(var_3)) {
    return;
  }
  return var_1[[var_3]](var_0._id_96CF, var_0.angles);
}

_id_C261(var_0, var_1, var_2, var_3) {
  if(!isDefined(level._id_2A5F)) {
    level._id_2A5F = [];
  }

  var_4 = spawnStruct();
  var_4._id_96E0 = var_1;
  var_4._id_E379 = var_2;
  var_4._id_E36B = var_3;
  level._id_2A5F[var_0] = var_4;
}

_id_6AB9(var_0) {
  if(!isDefined(level._id_2A5F)) {
    return undefined;
  }

  var_1 = level._id_2A5F[var_0];

  if(!isDefined(var_1)) {
    return undefined;
  }

  return var_1._id_96E0;
}

_id_7443(var_0, var_1) {
  var_2 = self;

  if(!istrue(level._id_31DB) && !istrue(var_2._id_8A5D)) {
    return 0;
  }

  [var_4, var_5] = _id_6D59(var_0);
  var_6 = _id_6D56(var_0, var_4, var_5);

  if(isDefined(var_2.team)) {
    var_7 = scripts\mp\utility\player::_id_6DC4(var_2.team);
    var_6 = var_6 * var_7.size;
  }

  if(istrue(level._id_31DB) && !istrue(var_2._id_8A5D)) {
    return var_2 _id_7493(var_0, var_1, var_6);
  }

  foreach(var_9 in level._id_2AB8) {
    var_10 = var_2 _id_6D78();

    if(isDefined(var_10) && var_9 == var_10) {
      if(level._id_31DB) {
        if(var_2 _id_355B(var_9, var_6, var_0, 1)) {
          return 1;
        }
      }

      continue;
    } else if(level._id_31DB) {
      if(!var_2 _id_355B(var_9, var_6, var_0, 0)) {
        return 0;
      }
    }

    if(_func_01A6(var_6 + var_9._id_E2DF, 2) > distance2dsquared(var_9._id_96DD, var_0)) {
      var_2 thread _id_D0C1(50, 2.0);
      var_2 playlocalsound("br_map_selection_error");
      return 0;
    }
  }

  return var_2 _id_C2B7(var_0, var_1, var_6);
}

_id_7493(var_0, var_1, var_2) {
  var_3 = self;

  foreach(var_5 in level._id_2AB8) {
    var_6 = _id_6D78();
    var_7 = 0;

    if(isDefined(var_6) && var_5 == var_6) {
      var_7 = 1;
    }

    if(_func_01A6(var_2 + var_5._id_E2DF, 2) > distance2dsquared(var_5._id_96DD, var_0)) {
      if(var_7) {
        var_8 = var_3 _id_6D39();
        _id_478F(var_8);
        var_3 thread _id_D0C1(56, 2.0);
        var_3 playlocalsound("br_map_selection_placed");
        return 1;
      }

      var_3 thread _id_D0C1(50, 2.0);
      var_3 playlocalsound("br_map_selection_error");
      return 0;
    }

    if(var_7 && var_3 _id_355B(var_5, var_2, var_0, var_7)) {
      return 1;
    }
  }

  return var_3 _id_C2B7(var_0, var_1, var_2);
}

_id_355B(var_0, var_1, var_2, var_3) {
  var_4 = self;

  foreach(var_6 in var_0._id_E019) {
    if(!isDefined(var_6)) {
      continue;
    }
    var_7 = var_4 _id_6D39();

    if(isDefined(var_7) && var_6 == var_7) {
      continue;
    }
    if(_func_01A6(var_1 + var_6._id_E2DF, 2) > distance2dsquared(var_6._id_96DD, var_2)) {
      if(!var_3) {
        var_4 thread _id_D0C1(50, 2.0);
        var_4 playlocalsound("br_map_selection_error");
        return 0;
      }

      var_2 = var_6._id_96DD;
      var_8 = var_6._id_96D7;
      var_1 = var_6._id_E2DF;

      if(isDefined(var_7) && isDefined(var_7._id_372D)) {
        var_7._id_372D delete();
      }

      var_9 = var_4 _id_C2B7(var_2, var_8, var_1);

      if(!var_9) {
        return var_9;
      }

      if(!istrue(var_4._id_8A5D)) {
        var_4 thread _id_D0C1(55, 2.0);
      } else {
        var_4 thread _id_D0C1(54, 2.0);
      }

      return var_9;
    }
  }

  if(!var_3) {
    return 1;
  }

  return 0;
}

_id_D0C1(var_0, var_1) {
  var_2 = self;
  var_2 notify("sendPlayerStatusMessage");
  var_2 endon("sendPlayerStatusMessage");
  var_2 _id_0A99::_id_D5EA(var_0);

  if(isDefined(var_1)) {
    wait(var_1);
    var_2 _id_0A99::_id_D5EA(0);
  }
}

_id_C2B7(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = scripts\engine\trace::_id_3EF6(1);

  if(istrue(var_3._id_8A5D)) {
    var_5 = var_3 _id_6D78();

    if(!isDefined(var_5)) {
      var_5 = var_3 _id_8299();
    }
  } else if(istrue(level._id_31DB)) {
    var_5 = var_3 _id_6D39();

    if(!isDefined(var_5)) {
      var_5 = var_3 _id_828D();
    }
  } else
    return 0;

  var_6 = getdvarfloat("#x3ead72bce44c8bf28", 5500.0);
  var_7 = (0, 0, var_6);
  var_8 = (0, 0, 10000);
  var_9 = var_0 + var_8;
  var_10 = var_0 - var_8;
  var_11 = scripts\engine\trace::ray_trace(var_9, var_10, undefined, var_4);
  var_12 = var_0;

  if(var_11["hittype"] != "hittype_none") {
    var_12 = var_11["position"];
  }

  var_5._id_96DD = var_12 + var_7;

  if(istrue(var_3._id_8A5D)) {
    var_5._id_71D2 = var_12;
  }

  var_5._id_96D7 = var_1;
  var_5._id_E2DF = var_2;
  [var_14, var_15, var_16] = var_5._id_96DD;

  if(isDefined(var_5._id_372D)) {
    var_5._id_372D.origin = (var_14, var_15, var_2);
  } else {
    var_5._id_372D = _func_03EF(var_14, var_15, var_2, var_3);

    if(istrue(var_3._id_8A5D)) {
      var_5._id_372D _meth_872E(1);
    }
  }

  var_17 = scripts\mp\utility\teams::_id_6A59(var_3.team, 0);

  foreach(var_19 in var_17) {
    if(!istrue(var_3._id_8A5D)) {
      var_19 thread _id_D0C1(64, 2.0);
      var_19 playlocalsound("br_map_selection_placed");
      continue;
    }

    var_19 thread _id_D0C1(57, 2.0);
    var_19 playlocalsound("br_map_selection_placed");
  }

  return 1;
}

_id_1D23() {
  var_0 = self;

  if(!isDefined(var_0._id_8A5D)) {
    var_0._id_8A5D = 1;
    var_1 = scripts\mp\utility\teams::_id_6A59(var_0.team, 0);

    foreach(var_3 in var_1) {
      if(var_3 != var_0) {
        var_3._id_8A5D = 0;
      }
    }
  }

  var_5 = (0, 0, 0);

  for(var_6 = 0; var_6 < 3; var_6++) {
    var_7 = randomfloatrange(level._id_9AC4[1][0], level._id_9AC4[0][0]);
    var_8 = randomfloatrange(level._id_9AC4[1][1], level._id_9AC4[0][1]);
    var_5 = (var_7, var_8, 0);
    var_9 = var_0 _id_7443(var_5);

    if(var_9) {
      return 1;
    }
  }

  var_0 _id_C2B7(var_5, undefined, getdvarint("#x3de4cab8fed2c9a9b", 2000));
  return 0;
}

_id_A694(var_0) {
  var_1 = self;
  var_2 = scripts\mp\utility\teams::_id_6A59(var_1.team, 0);
  var_3 = "";

  if(var_0) {
    var_3 = "Safe Spawn Selection Assigned";
  } else {
    var_3 = "Unsafe Spawn Selection Assigned";
  }

  foreach(var_5 in var_2) {
    var_5 iprintlnbold(var_3);
  }
}

_id_F03C() {
  var_0 = self;
  var_0 playershow(1);
  var_0 unlink(1);
  var_1 = var_0 _id_6D78();

  if(isDefined(var_1._id_96DD)) {
    var_2 = var_1._id_96DD;
    var_3 = var_0 _id_6D39();

    if(isDefined(var_3)) {
      var_2 = var_3._id_96DD;
    }

    var_4 = 512;
    var_5 = (0, 60 * var_0._id_2ABC % 360, 0);
    var_6 = anglesToForward(var_5) * var_4;
    var_2 = var_2 + var_6 + (0, 0, randomfloatrange(0, 512));

    if(getdvarint("#x396a7f4ee40772441", 0)) {
      var_0._id_5EC7 = var_2;
      var_0._id_5EC2 = undefined;
      var_0._id_1643 = 1;
      var_0 scripts\mp\playerlogic::_id_E337(0, 0);
    } else {
      var_0 setorigin(var_2, 1);
      var_0 setplayerangles(var_5);
    }
  }

  var_0 _meth_8655();
  var_0 _meth_8283();
  var_0 playershow(1);
  var_0._id_2A61 = 1;
  var_0 setclientomnvar("ui_br_infil_started", 1);
  var_0 setclientomnvar("ui_br_infiled", 1);
  var_0 _id_0797::_id_E6AD(0, 0);
  var_0 scripts\mp\gametypes\br_weapons::_id_29FF();
  scripts\mp\gametypes\br_weapons::_id_2A0C(var_0);
}

_id_BA86() {
  var_0 = self;
  var_1 = var_0 _id_6D39();
  var_2 = var_0 _id_6D78();

  if(isDefined(var_1)) {
    var_0 _meth_8282(var_1._id_96DD, 1);
  } else if(isDefined(var_2)) {
    var_0 _meth_8282(var_2._id_96DD, 1);
  }
}

_id_E36E() {
  setomnvar("ui_match_start_text", "prepare_for_infil");
  scripts\mp\gamelogic::_id_9BF4(10);
  _id_07D1::_id_60C0("end_spawn_selection", 0);
  level notify("begin_infil_map_selection");

  if(!isDefined(level._id_2AB8)) {
    level._id_2AB8 = [];
  }

  foreach(var_1 in level.players) {
    var_1 thread scripts\mp\gametypes\br::_id_B79A();
    var_1._id_8A23 = 1;
  }

  wait 2.0;
  setomnvar("ui_br_map_spawn", 1);
}

_id_E36F() {
  _id_07D1::_id_60C1("end_spawn_selection");
  var_0 = getdvarint("#x340eb5795db6ad524", 0);

  foreach(var_2 in level.players) {
    var_2 notify("cancel_location");
    var_2 thread _id_D0C1(51, 2.0);
    var_3 = var_2 _id_6D78();

    if(!isDefined(var_3)) {
      if(var_0) {
        var_2._id_2BEC = 1;
        continue;
      } else {
        var_4 = var_2 _id_1D23();
        var_2 _id_A694(var_4);
      }
    }

    var_2._id_2BEC = 0;
    var_2._id_8A23 = 0;
    var_2 _id_BA86();
  }

  thread _id_C524();
  wait 4;

  foreach(var_2 in level.players) {
    var_2 thread _id_D0C1(0);
    var_2 scripts\mp\gametypes\br_public::_id_FC1A("jumpMasterState", 0);
  }

  thread _id_10865();
}

_id_10865() {
  level endon("game_ended");
  level waittill("infils_ready");
  setomnvar("ui_br_map_spawn", 0);
}

_id_6D39() {
  var_0 = self;

  if(!istrue(level._id_31DB) || istrue(var_0._id_8A5D)) {
    return undefined;
  }

  var_1 = var_0 _id_6D78();

  if(isDefined(var_0._id_2ABC) && isDefined(var_1)) {
    if(isDefined(var_1._id_E019[var_0._id_2ABC]) && isDefined(var_1._id_E019[var_0._id_2ABC]._id_96DD)) {
      return var_1._id_E019[var_0._id_2ABC];
    }
  }

  return undefined;
}

_id_6D78() {
  var_0 = self;

  if(isDefined(level._id_2AB8) && isDefined(var_0.team) && isDefined(level._id_2AB8[var_0.team]) && isDefined(level._id_2AB8[var_0.team]._id_96DD)) {
    return level._id_2AB8[var_0.team];
  }

  return undefined;
}

_id_828D() {
  var_0 = self;

  if(!istrue(level._id_31DB) || istrue(var_0._id_8A5D)) {
    return undefined;
  }

  var_1 = var_0 _id_6D78();

  if(isDefined(var_1) && isDefined(var_0._id_2ABC)) {
    var_1._id_E019[var_0._id_2ABC] = spawnStruct();
    var_1._id_E019[var_0._id_2ABC]._id_372D = undefined;
    return var_1._id_E019[var_0._id_2ABC];
  }

  return undefined;
}

_id_8299() {
  var_0 = self;

  if(!istrue(var_0._id_8A5D)) {
    return undefined;
  }

  if(isDefined(level._id_2AB8) && isDefined(var_0.team)) {
    level._id_2AB8[var_0.team] = spawnStruct();
    level._id_2AB8[var_0.team]._id_372D = undefined;
    level._id_2AB8[var_0.team]._id_E019 = [];
    return level._id_2AB8[var_0.team];
  }

  return undefined;
}

_id_478F(var_0) {
  if(isDefined(var_0._id_372D)) {
    var_0._id_372D delete();
  }

  var_1 = undefined;
}

_id_4792(var_0) {
  if(isDefined(var_0._id_372D)) {
    var_0._id_372D delete();
  }

  var_0 = undefined;
}

_id_3806() {
  _id_07D1::_id_60C0("end_spawn_selection", 0);

  foreach(var_1 in level.players) {
    var_1 thread scripts\mp\gametypes\br::_id_B7E1();
  }
}

_id_3807() {
  _id_07D1::_id_60C1("end_spawn_selection");
}

_id_C524() {
  wait 25;

  if(isDefined(level._id_2AB8)) {
    foreach(var_1 in level._id_2AB8) {
      if(isDefined(var_1._id_E019)) {
        foreach(var_3 in var_1._id_E019) {
          _id_478F(var_3);
        }
      }

      _id_4792(var_1);
    }
  }
}

_id_6D58() {
  return 5;
}

_id_E370(var_0) {
  foreach(var_2 in level.players) {
    var_2._id_2A61 = 1;
    var_2 setclientomnvar("ui_br_infil_started", 1);
    var_2 setclientomnvar("ui_br_infiled", 1);
  }

  var_4 = _id_2CFB(undefined, var_0);
  _id_B318(var_4);
}

_id_8292() {
  setdvarifuninitialized("#x3a7cc4d8df21a096", 813);
  setdvarifuninitialized("#x3aa0b6d8df49fc84", 1000);
  setdvarifuninitialized("#x3825094de6ada80c5", 625);
  setdvarifuninitialized("#x382739ede6b00de7b", 813);
  setdvarifuninitialized("#x3de4cab8fed2c9a9b", 500);
  setdvarifuninitialized("#x3de28a18fed0409e5", 625);
  setdvarifuninitialized("#x3de4f5b38861563be", 25000);
  setdvarifuninitialized("#x365c96a815a826f6", "continuous");
  level._id_2ABA = ["boneyard", "farm", "lumber", "dam", "smallAirport", "quarry"];
  level._id_2AB9 = ["transit", "hospital", "port", "stadium", "tvStation", "storagetown", "supermarket"];
  level._id_2AB5 = ["gulag", "northDowntown", "southDowntown", "eastAirport", "westAirport"];
  var_0 = getdvarint("#x3a7cc4d8df21a096");
  var_1 = getdvarint("#x3aa0b6d8df49fc84");

  foreach(var_3 in level._id_2ABA) {
    level._id_2AB7[var_3] = spawnStruct();
    level._id_2AB7[var_3]._id_56E0 = var_0;
    level._id_2AB7[var_3]._id_56DF = var_1;
  }

  var_5 = getdvarint("#x3825094de6ada80c5");
  var_6 = getdvarint("#x382739ede6b00de7b");

  foreach(var_3 in level._id_2AB9) {
    level._id_2AB7[var_3] = spawnStruct();
    level._id_2AB7[var_3]._id_56E0 = var_5;
    level._id_2AB7[var_3]._id_56DF = var_6;
  }

  var_9 = getdvarint("#x3de4cab8fed2c9a9b");
  var_10 = getdvarint("#x3de28a18fed0409e5");

  foreach(var_3 in level._id_2AB5) {
    level._id_2AB7[var_3] = spawnStruct();
    level._id_2AB7[var_3]._id_56E0 = var_9;
    level._id_2AB7[var_3]._id_56DF = var_10;
  }

  level._id_2AB7["transit"]._id_B9FE = (-12420, -26792, 0);
  level._id_2AB7["boneyard"]._id_B9FE = (-26542, -21776, 0);
  level._id_2AB7["hospital"]._id_B9FE = (7827, -22240, 0);
  level._id_2AB7["port"]._id_B9FE = (35008, -37117, 0);
  level._id_2AB7["farm"]._id_B9FE = (48757, -25620, 0);
  level._id_2AB7["gulag"]._id_B9FE = (51019, -52257, 0);
  level._id_2AB7["lumber"]._id_B9FE = (51048, -8557, 0);
  level._id_2AB7["stadium"]._id_B9FE = (28873, -9839, 0);
  level._id_2AB7["tvStation"]._id_B9FE = (14423, 4999, 0);
  level._id_2AB7["northDowntown"]._id_B9FE = (20311, -18724, 0);
  level._id_2AB7["southDowntown"]._id_B9FE = (22076, -29372, 0);
  level._id_2AB7["storagetown"]._id_B9FE = (-24594, -3984, 0);
  level._id_2AB7["supermarket"]._id_B9FE = (-12782, -3634, 0);
  level._id_2AB7["eastAirport"]._id_B9FE = (-8280, 5837, 0);
  level._id_2AB7["westAirport"]._id_B9FE = (-21055, 7124, 0);
  level._id_2AB7["dam"]._id_B9FE = (-26873, 32208, 0);
  level._id_2AB7["smallAirport"]._id_B9FE = (5823, 38518, 0);
  level._id_2AB7["quarry"]._id_B9FE = (32653, 26929, 0);
}

_id_6D55(var_0, var_1, var_2, var_3) {
  var_4 = getdvarint("#x3de4f5b38861563be");
  var_5 = distance2d(var_0, var_1);

  if(var_5 > var_4) {
    return getdvarint("#x3843096966fa23547", 2800);
  }

  var_6 = _func_013F(var_3) / (_func_013F(var_2) * var_4);
  var_7 = var_2 * _func_0065(var_6 * var_5);
  return var_7;
}

_id_6D54(var_0, var_1, var_2, var_3) {
  var_4 = var_2 / var_3;
  var_5 = getdvarint("#x3de4f5b38861563be");
  var_6 = distance2d(var_0, var_1);

  if(var_6 > var_5) {
    return getdvarint("#x3843096966fa23547", 2800);
  }

  var_7 = var_6 / var_5;
  var_8 = var_2 * _func_01A6(1 + var_4, var_7);
  return var_8;
}

_id_6D57(var_0, var_1, var_2, var_3) {
  var_4 = getdvarint("#x3de4f5b38861563be");
  var_5 = distance2d(var_0, var_1);

  if(var_5 > var_4) {
    return getdvarint("#x3843096966fa23547", 2800);
  }

  var_6 = var_5 / var_4;
  var_7 = scripts\engine\math::_id_91A9(var_2, var_3, var_6);
  return var_7;
}

_id_6D59(var_0) {
  var_1 = 2147483647;
  var_2 = undefined;

  foreach(var_6, var_4 in level._id_2AB7) {
    var_5 = distance2d(var_0, var_4._id_B9FE);

    if(var_5 < var_1) {
      var_1 = var_5;
      var_2 = var_6;
    }
  }

  return [var_1, var_2];
}

_id_6D56(var_0, var_1, var_2) {
  var_3 = getDvar("#x365c96a815a826f6", "continuous");
  var_4 = level._id_2AB7[var_2];

  switch (var_3) {
    case "continuous":
      var_4._id_E2DF = _id_6D55(var_4._id_B9FE, var_0, var_4._id_56E0, var_4._id_56DF);
      break;
    case "constant":
      var_4._id_E2DF = _id_6D54(var_4._id_B9FE, var_0, var_4._id_56E0, var_4._id_56DF);
      break;
    case "lerp":
      var_4._id_E2DF = _id_6D57(var_4._id_B9FE, var_0, var_4._id_56E0, var_4._id_56DF);
      break;
    default:
      var_4._id_E2DF = getdvarint("#x3843096966fa23547", 2800);
  }

  return var_4._id_E2DF;
}

_id_6ABB() {
  if(istrue(level._id_7E69)) {
    return getdvarfloat("#x38246f377e27dbff8", 2000);
  }

  return getdvarfloat("#x3481e078fe971e1bb", 12000);
}

_id_107DB(var_0) {
  wait(var_0);
}

_id_A279(var_0, var_1, var_2, var_3) {
  self moveto(var_0, var_1, var_2, var_3);
}

_id_C928(var_0, var_1, var_2, var_3) {
  self rotateto(var_0, var_1, var_2, var_3);
}

_id_75FF() {
  var_0 = distance(level._id_29F4._id_AEE7._id_E715, level._id_29F4._id_AEE7._id_5340);
  var_1 = var_0 / scripts\mp\gametypes\br_c130::_id_6940() / level._id_75FE.size;

  for(var_2 = 0; var_2 < level._id_75FE.size; var_2++) {
    wait(var_1);
    level._id_75FE[var_2] notify("halo_jump_c130");
  }

  level._id_75FE = undefined;
}

_id_C25F(var_0) {
  if(!isDefined(level._id_75FE)) {
    level._id_75FE = [];
  }

  level._id_75FE[level._id_75FE.size] = var_0;
}
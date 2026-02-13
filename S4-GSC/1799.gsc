/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1799.gsc
*************************************************/

_id_D161(var_0, var_1) {
  var_0._id_1B26 = int(min(var_1, var_0._id_9C09));
  var_0 setclientomnvar("ui_armor_health_bar", var_0._id_1B26 / var_0._id_9C09);
  var_0 scripts\cp\utility::updateplayerarmordisplay();

  if(isDefined(var_0._id_1B29)) {
    var_0._id_1B29 scripts\cp\utility::_id_FC11(var_0._id_1B26 / var_0._id_9C09);
  }
}

_id_42B7(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(!_id_4C71(var_5, var_9) || var_0._id_1B26 == 0 || var_3 == 0) {
    return var_3;
  }

  var_14 = var_3;
  var_15 = 0;

  if(_func_010F(var_5)) {
    switch (var_0._id_1B3D) {
      case 1:
        var_15 = 0.75;
        break;
      case 2:
        var_15 = 0.55;
        break;
      case 3:
        var_15 = 0.35;
        break;
    }
  } else {
    switch (var_0._id_1B3D) {
      case 1:
        var_15 = 0.75;
        break;
      case 2:
        var_15 = 0.55;
        break;
      case 3:
        var_15 = 0.35;
        break;
    }
  }

  if(isDefined(var_0._id_AFAA)) {
    var_3 = var_3 * var_15 * var_0._id_AFAA["enemy_damage_to_player_armor_scalar"];
  } else {
    var_3 = var_3 * var_15;
  }

  var_16 = var_0._id_1B26;
  var_17 = min(var_16, var_14);
  var_18 = var_16 - var_17;
  var_19 = int(var_3);
  _id_D161(var_0, var_18);
  _id_2BF4(var_0, var_18);
  _id_B1F9(var_0, var_2, var_18);

  if(var_18 <= 0) {
    _id_C431(var_0);
  }

  return var_19;
}

_id_B258(var_0, var_1) {
  var_2 = [];
  var_2["x"] = randomfloatrange(0, 1);
  var_2["y"] = randomfloatrange(0, 1);
  var_2["scale"] = randomfloatrange(0, 1);

  if(!isDefined(var_1._id_DB22)) {
    var_1._id_DB22 = 1;
  }

  if(!istrue(var_1._id_DB22)) {
    return;
  }
  if(var_1 scripts\engine\math::_id_8680(var_0)) {
    var_1 _id_4042("right", "fullscreen_armor_right", 0.05, 3.0, var_2, 1);
    var_1 _id_4042("right", "fullscreen_armor_right_splash", 0.05, 3.0, var_2, 1);
  } else {
    var_1 _id_4042("left", "fullscreen_armor_left", 0.05, 3.0, var_2, 1);
    var_1 _id_4042("left", "fullscreen_armor_left_splash", 0.05, 3.0, var_2, 1);
  }

  var_1._id_DB22 = 0;
}

_id_4042(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = newclienthudelem(self);
  var_6.sort = 12;
  var_6._id_01D6 = 0;
  var_6.horzalign = "fullscreen";
  var_6.vertalign = "fullscreen";
  var_6.alpha = 0;
  var_6._id_018D = 1;
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;
  var_11 = scripts\engine\math::_id_5898(0.9, 1.25, var_4["scale"]);

  switch (var_0) {
    case "left":
      var_6.aligny = "top";
      var_6.alignx = "left";
      var_7 = -640;
      var_8 = scripts\engine\math::_id_5898(-30, 30, var_4["y"]);
      var_10 = var_8;
      var_9 = scripts\engine\math::_id_5898(-55, 0, var_4["x"]);
      break;
    case "right":
      var_6.aligny = "top";
      var_6.alignx = "right";
      var_7 = 1280;
      var_8 = scripts\engine\math::_id_5898(-30, 30, var_4["y"]);
      var_10 = var_8;
      var_9 = scripts\engine\math::_id_5898(0, 55, var_4["x"]) + 640;
      break;
    case "bottom":
      var_6.aligny = "bottom";
      var_6.alignx = "left";
      var_8 = 960;
      var_7 = scripts\engine\math::_id_5898(-15, 15, var_4["x"]);
      var_10 = scripts\engine\math::_id_5898(0, 0, var_4["y"]);
      var_10 = var_10 + 480;
      break;
  }

  var_6.x = var_7;
  var_6.y = var_8;
  var_6 setshader(var_1, 640, 480);
  thread _id_CC6C(var_6);
  thread _id_1882(var_6, var_2, var_3, var_9, var_10, var_11, var_5);
}

_id_1882(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_5 = 1;
  var_0 endon("destroySreenEffectOverlay");

  if(!var_6) {
    var_0 scaleovertime(var_1, int(640 * var_5), int(480 * var_5));
    var_0 moveovertime(var_1);
    var_0.x = var_3;
    var_0.y = var_4;
    var_1 = 0.05;
    var_0.alpha = 1;
    wait 0.05;
  } else {
    var_0 scaleovertime(var_1, int(640 * var_5), int(480 * var_5));
    var_0.x = var_3;
    var_0.y = var_4;
    wait 0.15;
    var_0 fadeovertime(var_1);
    var_0.alpha = 1;
    wait(var_1);
  }

  var_0 fadeovertime(var_2);
  var_0.alpha = 0;
  wait(var_2 + 0.05);
  var_0 notify("destroySreenEffectOverlay");
}

_id_CC6C(var_0) {
  var_0 waittill("destroySreenEffectOverlay");
  self._id_DB22 = 1;
  var_0 destroy();
}

_id_1B39(var_0, var_1, var_2, var_3) {
  if(var_0 == "MOD_FALLING") {
    return 0;
  }

  if(var_0 == "MOD_TRIGGER_HURT") {
    return 0;
  }

  if(var_0 == "MOD_FIRE" && !istrue(var_2._id_7D07)) {
    return 0;
  }

  switch (var_1.basename) {
    case "white_phosphorus_proj_mp":
    case "ac130_105mm_mp":
    case "ac130_40mm_mp":
    case "ac130_25mm_mp":
      return 0;
  }

  if(isDefined(var_3) && istrue(var_3._id_1B36)) {
    return 0;
  }

  return 1;
}

_id_B1F9(var_0, var_1, var_2) {
  var_3 = "cp_hit_indication_armor";

  if(var_2 < 0) {
    var_3 = "plr_armor_gone";
  }

  if(_func_0205(var_3)) {
    if(isPlayer(var_0)) {
      var_0 playlocalsound(var_3);
    }

    if(isPlayer(var_1)) {
      var_1 playlocalsound(var_3);
    }
  }
}

_id_74D5(var_0) {
  return var_0._id_1B26 > 0;
}

_id_2BF4(var_0, var_1) {
  var_2 = var_0 getentitynumber();
  var_3 = int(var_1);
  _id_074E::_id_D4E4("EoGPlayer", var_2, "playerArmor", var_3);
}

_id_FBAF(var_0, var_1) {
  if(istrue(var_0)) {
    var_1 _id_073C::_id_D4BE("body_mp_western_fireteam_west_ar_1_1_lod1", "head_mp_western_fireteam_west_ar_1_1", "viewhands_mp_base_iw8");
  } else {
    var_1 _id_073C::_id_D4BE("head_mp_western_fireteam_west_ar_1_1", "head_mp_western_fireteam_west_ar_1_1", "viewhands_mp_base_iw8");
  }
}

_id_B062(var_0, var_1) {
  if(_id_B4C7(var_1)) {
    return;
  }
  var_0.model delete();
  _id_0737::_id_C3C5(var_0);
  _id_6F80(var_1, var_1._id_9C09);
}

_id_6F80(var_0, var_1, var_2) {
  if(_id_B4C7(var_0)) {
    return;
  }
  var_3 = var_0 getentitynumber();
  setomnvar("ui_armor_gained", var_3);
  var_2 = istrue(var_2);

  if(!var_2) {
    var_0 scripts\common\utility::_id_151F(0, "armor");
    var_0 scripts\common\utility::_id_153E(0, "armor");
    var_0 scripts\common\utility::_id_1554(0, "armor");
    var_0 cancelreload();

    if(!isDefined(var_0._id_32EC)) {
      var_0 _meth_84AF("ges_vest_replace", undefined, 0.3);
    } else {
      var_2 = 1;
    }
  }

  var_0 thread _id_FC0B();

  if(!var_2) {
    wait(var_0 _meth_8495("ges_vest_replace"));
    var_0 playlocalsound("plr_armor_salvage");
  }

  var_0 notify("armorUseSuccess");

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    visionsetpain("pain_mp_night");
  } else {
    visionsetpain("damage_armor");
  }

  _id_2BF4(var_0, var_1);

  if(!var_2) {
    var_0 _meth_8494("ges_vest_replace", 0.45);
    var_0 scripts\common\utility::_id_151F(1, "armor");
    var_0 scripts\common\utility::_id_153E(1, "armor");
    var_0 scripts\common\utility::_id_1554(1, "armor");
  }

  _id_D161(var_0, var_1);
}

_id_B4C3(var_0) {
  return var_0._id_1B26 > 0;
}

_id_B4C7(var_0) {
  return var_0._id_1B26 == var_0._id_9C09;
}

_id_1B46(var_0, var_1) {
  if(_id_B4C7(var_1)) {
    return &"COOP_CRAFTING/ARMOR_FULL";
  } else {
    return &"COOP_CRAFTING/ARMOR_TAKE";
  }
}

_id_FC0A() {
  self endon("armorUseSuccess");
  self endon("disconnect");
  self endon("death");
  wait 0.5;
  var_0 = spawn("script_model", self.origin);
  var_0 setModel("loot_armor");
  var_0 notsolid();
  self playerlinktodelta(var_0);
  scripts\engine\utility::_id_108F5("armorUseCancel", 1.2);
  self unlink();
  var_0 delete();
}

_id_1B4A(var_0) {
  self shellshock("armor_gone", 2.5);
  earthquake(0.3, 0.65, var_0, 5000);
  self _meth_844C(127, self.origin, 0);
}

_id_FC0B() {
  self endon("armorUseCancel");
  self endon("armorUseSuccess");
  var_0 = gettime();
  var_1 = self _meth_8495("ges_vest_replace");

  for(;;) {
    var_2 = gettime() - var_0;
    var_3 = var_2 / (var_1 * 1000);
    waitframe();
  }
}

_id_1B55(var_0) {
  var_0._id_1B26 = 0;
  var_0._id_9C09 = 0;
  var_0._id_1B3D = 0;
  var_0 setclientomnvar("ui_crafting_armor_current_level", 0);
  var_0 setclientomnvar("ui_armor_health_bar", 0);

  if(isDefined(var_0._id_1B29)) {
    var_0._id_1B29 scripts\cp\utility::destroyelem();
  }
}

armorinitonrevival(var_0) {
  var_0._id_1B26 = 0;

  if(var_0._id_9C09 != 0) {
    _id_D161(var_0, var_0._id_1B26);
  }
}

_id_C431(var_0) {
  var_0._id_1B26 = 0;
  var_0 setclientomnvar("ui_armor_health_bar", 0);

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    visionsetpain("pain_mp_night", 0);
  } else {
    visionsetpain("pain_mp", 0);
  }

  if(_func_0205("hit_marker_3d_armor_break")) {
    var_0 playsoundtoplayer("hit_marker_3d_armor_break", var_0);
  }
}

_id_3100(var_0) {
  if(isDefined(var_0._id_3100) && var_0._id_3100 == 0) {
    return 0;
  }

  return 1;
}

_id_D17F(var_0, var_1) {
  var_0._id_3100 = var_1;
}

_id_6ECA(var_0, var_1) {
  var_0._id_1B3D = var_1;

  switch (var_1) {
    case 1:
      var_0._id_9C09 = 300;
      break;
    case 2:
      var_0._id_9C09 = 500;
      break;
    case 3:
      var_0._id_9C09 = 800;
      break;
  }

  var_0 setclientomnvar("ui_crafting_armor_current_level", var_1);

  if(!isDefined(var_0._id_1B29) && var_0._id_1B3D > 0) {}

  _id_D161(var_0, var_0._id_9C09);
}

_id_4C71(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 1;
  }

  if(var_0 == "MOD_BULLET" || var_0 == "MOD_RIFLE_BULLET" || var_0 == "MOD_PISTOL_BULLET" || var_0 == "MOD_MELEE" || var_0 == "MOD_MELEE_WEAPON_BUTT" || var_0 == "MOD_IMPACT") {
    return 1;
  }

  if(_func_010F(var_0)) {
    return 1;
  }

  return 0;
}

get_max_armor_tier() {
  return 3;
}
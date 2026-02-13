/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1857.gsc
*************************************************/

init() {
  _func_01B4(&"CP_MERIT_COMPLETED");

  if(!_id_9CCA()) {
    return;
  }
  level._id_9DE1 = [];
  _id_C276("enemyKilled", ::_id_A2BD);
  level thread onplayerconnect();
}

_id_9CCA() {
  return 0;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(!isDefined(var_0.pers["postGameMerits"])) {
      var_0.pers["postGameMerits"] = 0;
    }

    var_0 thread _id_8220();

    if(isai(var_0)) {
      continue;
    }
    var_0 thread _id_A0F2();
  }
}

_id_8220() {
  self.pers["lastBulletKillTime"] = 0;
  self.pers["bulletStreak"] = 0;
  self._id_57E9 = [];
}

_id_C276(var_0, var_1) {
  if(!isDefined(level._id_9DE1[var_0])) {
    level._id_9DE1[var_0] = [];
  }

  level._id_9DE1[var_0][level._id_9DE1[var_0].size] = var_1;
}

_id_6B5A(var_0) {
  if(isDefined(self._id_9DE2[var_0])) {
    return self._id_9DE2[var_0];
  } else {
    return 0;
  }
}

_id_A2BD(var_0, var_1) {
  var_2 = var_0.attacker;
  var_3 = var_0._id_103C2;

  if(!isDefined(var_2) || !isPlayer(var_2)) {
    return;
  }
  var_2 _id_BD77("mt_kills");
}

_id_541E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("disconnect");
  var_8 = spawnStruct();
  var_8._id_103C2 = self;
  var_8._id_511D = var_0;
  var_8.attacker = var_1;
  var_8._id_7C8D = var_2;
  var_8._id_DE2B = var_3;
  var_8._id_EC0F = var_4;
  var_8._id_E44C = var_5;
  var_8._id_D9E0 = var_6;
  var_8._id_F1E8 = gettime();
  var_8._id_9FFB = var_7;
  var_8._id_103C9 = var_8._id_103C2 isonground();
  _id_4D1D("enemyKilled", var_8);
  var_8.attacker notify("playerKilledMeritsProcessed");
}

_id_4D1D(var_0, var_1) {
  if(!_id_9CCA()) {
    return;
  }
  if(isDefined(var_1)) {
    var_2 = var_1.player;

    if(!isDefined(var_2)) {
      var_2 = var_1.attacker;
    }

    if(isDefined(var_2) && isai(var_2)) {
      return;
    }
  }

  if(getdvarint("#x3960cf6d7734298eb") > 0) {
    return;
  }
  if(!isDefined(level._id_9DE1[var_0])) {
    return;
  }
  if(isDefined(var_1)) {
    for(var_3 = 0; var_3 < level._id_9DE1[var_0].size; var_3++) {
      thread[[level._id_9DE1[var_0][var_3]]](var_1);
    }
  } else {
    for(var_3 = 0; var_3 < level._id_9DE1[var_0].size; var_3++) {
      thread[[level._id_9DE1[var_0][var_3]]]();
    }
  }
}

_id_BD3D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_1)) {
    return;
  }
  if(!isPlayer(var_1)) {
    if(isDefined(var_1.owner) && isPlayer(var_1.owner)) {
      var_1 = var_1.owner;
    } else {
      return;
    }
  }

  var_9 = scripts\cp\utility::_id_6E6D(var_4);
  var_10 = istrue(var_1.inlaststand);
  var_11 = scripts\engine\utility::_id_8794(var_3);
  var_12 = var_1 getstance();
  var_13 = self._id_E3D8;
  var_14 = var_12 == "crouch";
  var_15 = var_12 == "prone" && !var_10;
  var_16 = _func_010F(var_3);
  var_17 = var_3 == "MOD_MELEE";
  var_18 = (istrue(self._id_8569) || istrue(self._id_856F)) && (!var_11 || var_4.basename == "incendiary_ammo_mp");
  var_19 = istrue(self._id_4B40);
  var_20 = istrue(self._id_D9E9);
  var_21 = var_1 issprintsliding();
  var_22 = istrue(self._id_58C9);

  if(isDefined(var_0.owner)) {
    var_23 = var_1 scripts\cp\utility::_id_86EC(var_0, var_4) && var_0.owner == var_1;
  } else {
    var_23 = var_1 scripts\cp\utility::_id_86EC(var_0, var_4);
  }

  var_24 = 0;

  if(isDefined(level._id_146E)) {
    foreach(var_26 in getarraykeys(level._id_146E)) {
      if(scripts\cp\utility::_id_6CE3(var_4) == var_26) {
        var_24 = 1;
        break;
      }
    }
  }

  var_28 = isDefined(var_4) && (var_4.basename == "iw7_dischorddummy_zm" || var_4.basename == "iw7_facemelterdummy_zm" || var_4.basename == "iw7_headcutterdummy_zm" || var_4.basename == "iw7_shredderdummy_zm");
  var_29 = undefined;

  if(isDefined(var_4)) {
    var_29 = scripts\cp\utility::_id_6CE3(var_4);
  }

  var_30 = isDefined(var_29) && (var_29 == "harpoon1" || var_29 == "harpoon2" || var_29 == "harpoon3" || var_29 == "harpoon4");

  if(var_24) {
    if(issubstr(var_4.basename, "g18_")) {
      var_24 = isDefined(var_1._id_750C);
    }
  }

  if(var_16) {
    if(issubstr(var_4.basename, "shuriken")) {
      var_16 = 0;
    } else if(istrue(var_1._id_8E55)) {
      var_16 = 0;
    }
  }

  var_31 = var_4.classname == "weapon_sniper" && var_11;
  var_32 = var_11 && scripts\cp\utility::_id_8891(var_4, var_6, var_3, var_1);

  if(!var_17) {
    switch (var_9) {
      case "weapon_assault":
        var_1 _id_BD77("mt_ar_kills");
        break;
      case "weapon_smg":
        var_1 _id_BD77("mt_smg_kills");
        break;
      case "weapon_lmg":
        var_1 _id_BD77("mt_lmg_kills");
        break;
      case "weapon_shotgun":
        var_1 _id_BD77("mt_shotgun_kills");
        break;
      case "weapon_sniper":
        var_1 _id_BD77("mt_sniper_kills");
        break;
      case "weapon_pistol":
        var_1 _id_BD77("mt_pistol_kills");
        break;
      case "other":
        if(var_28) {
          var_1 _id_BD77("mt_pistol_kills");
        }

        break;
      default:
        break;
    }
  }

  switch (var_13) {
    case "zombie":
      var_1 _id_BD77("mt_zombie_kills");
      break;
    default:
      break;
  }

  if(var_16) {
    var_1 _id_BD77("mt_explosive_kills");
  }

  if(var_17) {
    var_1 _id_BD77("mt_melee_kills");
  }

  if(var_18) {
    var_1 _id_BD77("mt_fire_kills");
  }

  if(var_23) {
    var_1 _id_BD77("mt_trap_kills");
  }

  if(var_24) {
    var_1 _id_BD77("mt_magic_weapon_kills");
  }

  if(var_32) {
    var_1 _id_BD77("mt_headshot_kills");
  }

  if(var_19) {
    var_1 _id_BD77("mt_crawler_kills");
  }

  if(var_20) {
    var_1 _id_BD77("mt_faf_shock_melee_kills");
  }

  if(var_21) {
    var_1 _id_BD77("mt_sliding_kills");
  }

  if(var_28 || var_30) {
    var_1 _id_BD77("mt_quest_weapon_kills");
  }

  if(var_22 && var_18) {
    var_1 _id_BD77("mt_faf_burned_out_kills");
  }

  var_33 = var_4.basename;

  if(getDvar("#x36d16f02578d0ee10") == "cp_rave") {
    if(isDefined(self._id_1210) && self._id_1210 == "zombie_sasquatch") {
      var_1 _id_BD77("mt_dlc1_sasquatch_kills");
    }

    if(var_17) {
      if(var_33 == "iw7_golf_club_mp" || var_33 == "iw7_golf_club_mp_pap1" || var_33 == "iw7_golf_club_mp_pap2") {
        var_1 _id_BD77("mt_dlc1_golf_kills");
      } else if(var_33 == "iw7_spiked_bat_mp" || var_33 == "iw7_spiked_bat_mp_pap1" || var_33 == "iw7_spiked_bat_mp_pap2") {
        var_1 _id_BD77("mt_dlc1_bat_kills");
      } else if(var_33 == "iw7_machete_mp" || var_33 == "iw7_machete_mp_pap1" || var_33 == "iw7_machete_mp_pap2") {
        var_1 _id_BD77("mt_dlc1_machete_kills");
      } else if(var_33 == "iw7_two_headed_axe_mp" || var_33 == "iw7_two_headed_axe_mp_pap1" || var_33 == "iw7_two_headed_axe_mp_pap2") {
        var_1 _id_BD77("mt_dlc1_axe_kills");
      } else if(var_33 == "iw7_lawnmower_zm") {
        var_1 _id_BD77("mt_dlc1_lawnmower_kills");
      }
    }

    if(issubstr(var_33, "harpoon")) {
      var_1 _id_BD77("mt_dlc1_harpoon_kills");
    }

    if(istrue(var_1._id_C04C)) {
      var_1 _id_BD77("mt_dlc1_kills_in_rave");
    }
  }

  if(getDvar("#x36d16f02578d0ee10") == "cp_disco") {
    if(var_33 == "iw7_katana_zm_pap2+camo222" || var_33 == "iw7_katana_windforce_zm") {
      var_1 _id_BD77("mt_dlc2_pap2_katana");
    } else if(var_33 == "iw7_nunchucks_zm_pap2+camo222") {
      var_1 _id_BD77("mt_dlc2_pap2_nunchucks");
    } else if(var_33 == "heart_cp") {
      var_1 _id_BD77("mt_dlc2_heart_kills");
    }

    if(isDefined(self._id_1210) && self._id_1210 == "skater") {
      var_1 _id_BD77("mt_dlc2_roller_skaters");
    }

    if(var_23) {
      var_1 _id_BD77("mt_dlc2_trap_kills");
    } else if(istrue(var_1._id_8E55) && !_id_8589(var_33)) {
      if(var_1._id_8E58 == "dragon") {
        var_1 _id_BD77("mt_dlc2_dragon_kills");
      } else if(var_1._id_8E58 == "crane") {
        var_1 _id_BD77("mt_dlc2_crane_kills");
      } else if(var_1._id_8E58 == "snake") {
        var_1 _id_BD77("mt_dlc2_snake_kills");
      } else if(var_1._id_8E58 == "tiger") {
        var_1 _id_BD77("mt_dlc2_tiger_kills");
      }
    }
  }
}

_id_8589(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0) {
    case "alien_sentry_minigun_4_mp":
    case "iw7_robotzap_zm":
    case "zmb_robotprojectile_mp":
    case "incendiary_ammo_mp":
    case "iw7_electrictrap_zm":
      return 1;
  }

  return 0;
}

_id_BD77(var_0, var_1, var_2) {
  if(!_id_9CCA()) {
    return;
  }
  if(!isPlayer(self) || isai(self)) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!_id_75CF(var_0)) {
    return;
  }
  var_3 = _id_6B5A(var_0);

  if(var_3 == 5) {
    return;
  }
  var_4 = isDefined(level._id_9DE3[var_0]["operation"]);

  if(var_3 > level._id_9DE3[var_0]["targetval"].size) {
    var_5 = var_3 == level._id_9DE3[var_0]["targetval"].size + 1;
    var_6 = isDefined(self._id_AC38) && isDefined(self._id_AC38[var_0]);

    if(var_5 && !var_6) {
      var_3 = level._id_9DE3[var_0]["targetval"].size;
    } else {
      return;
    }
  }

  var_7 = scripts\cp\cp_hud_util::_id_A2BA(var_0);
  var_8 = level._id_9DE3[var_0]["targetval"][var_3];

  if(!isDefined(var_8)) {
    return;
  }
  if(isDefined(var_2) && var_2) {
    var_9 = var_1;
  } else {
    var_9 = var_7 + var_1;
  }

  var_10 = 0;

  if(var_9 >= var_8) {
    var_11 = 1;
    var_10 = var_9 - var_8;
    var_9 = var_8;
  } else
    var_11 = 0;

  if(var_7 < var_9) {
    scripts\cp\cp_hud_util::_id_A2BE(var_0, var_9);
  }

  if(var_11) {
    thread _id_6FDE(var_0, var_3);
    _id_E9BF(var_0);
    _id_6FB8(level._id_9DE3[var_0]["score"][var_3]);
    var_3++;
    scripts\cp\cp_hud_util::_id_A2BF(var_0, var_3);
    self._id_9DE2[var_0] = var_3;
    thread scripts\cp\cp_hud_message::_id_DC8F(var_0);

    if(_id_1A52(var_0)) {
      _id_BD76(var_0);
    }
  }
}

_id_1A52(var_0) {
  if(self._id_9DE2[var_0] >= level._id_9DE3[var_0]["targetval"].size) {
    return 1;
  }

  return 0;
}

_id_67A0() {
  return "mp/splashtable.csv";
}

_id_E9BF(var_0) {
  if(!isDefined(self._id_9DE4)) {
    self._id_9DE4 = [];
  }

  var_1 = 0;

  foreach(var_3 in self._id_9DE4) {
    if(var_3 == var_0) {
      var_1 = 1;
    }
  }

  if(!var_1) {
    self._id_9DE4[self._id_9DE4.size] = var_0;
  }
}

_id_E9C0(var_0) {
  if(!isDefined(self._id_AC37)) {
    self._id_AC37 = [];
  }

  var_1 = 0;

  foreach(var_3 in self._id_AC37) {
    if(var_3 == var_0) {
      var_1 = 1;
      break;
    }
  }

  if(!var_1) {
    self._id_AC37[self._id_AC37.size] = var_0;
  }
}

_id_6FDE(var_0, var_1) {
  self endon("disconnect");
  wait 0.25;
  _id_074E::_id_6F38(int(level._id_9DE3[var_0]["reward"][var_1]));
  _id_0756::giverankxp(var_0, level._id_9DE3[var_0]["reward"][var_1], undefined);
}

_id_6FB8(var_0) {
  var_1 = self getplayerdata("cp", "challengeScore");

  if(isDefined(var_1)) {
    self setplayerdata("cp", "challengeScore", var_1 + var_0);
  }
}

_id_FCC7() {
  self._id_9DE2 = [];
  self endon("disconnect");

  if(!_id_9CCA()) {
    return;
  }
  var_0 = 0;

  foreach(var_5, var_2 in level._id_9DE3) {
    var_0++;

    if(var_0 % 20 == 0) {
      wait 0.05;
    }

    self._id_9DE2[var_5] = 0;
    var_3 = var_2["index"];
    var_4 = scripts\cp\cp_hud_util::_id_A2BB(var_5);
    self._id_9DE2[var_5] = var_4;
  }
}

_id_6B58(var_0) {
  return _func_0222("cp/allMeritsTable.csv", 0, var_0, 5);
}

_id_8B0A(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = _id_6B58(var_0);

  if(isDefined(var_1)) {
    return 1;
  }

  return 0;
}

_id_6E74(var_0) {
  return _id_6B58(var_0);
}

_id_8969(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = _id_6B58(var_0);

  if(isDefined(var_1)) {
    if(var_1 == "perk_slot_0" || var_1 == "perk_slot_1" || var_1 == "perk_slot_2" || var_1 == "proficiency" || var_1 == "equipment" || var_1 == "special_equipment" || var_1 == "attachment" || var_1 == "prestige" || var_1 == "final_killcam" || var_1 == "basic" || var_1 == "humiliation" || var_1 == "precision" || var_1 == "revenge" || var_1 == "elite" || var_1 == "intimidation" || var_1 == "operations" || scripts\cp\utility::_id_8A68(var_1, "killstreaks_")) {
      return 1;
    }
  }

  if(_id_8B0A(var_0)) {
    return 1;
  }

  return 0;
}

_id_9DE0(var_0, var_1, var_2) {
  var_3 = _func_0222(var_0, 0, var_1, 10 + var_2 * 3);
  return int(var_3);
}

_id_9DDE(var_0, var_1, var_2) {
  var_3 = _func_0222(var_0, 0, var_1, 11 + var_2 * 3);
  return int(var_3);
}

_id_9DDF(var_0, var_1, var_2) {
  var_3 = _func_0222(var_0, 0, var_1, 12 + var_2 * 3);
  return int(var_3);
}

_id_2D06(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_2 = 0;

  for(;;) {
    var_4 = tablelookupbyrow(var_0, var_2, 0);

    if(var_4 == "") {
      break;
    }

    var_5 = _id_6B59(var_4);
    level._id_9DE3[var_4] = [];
    level._id_9DE3[var_4]["index"] = var_2;
    level._id_9DE3[var_4]["type"] = var_1;
    level._id_9DE3[var_4]["targetval"] = [];
    level._id_9DE3[var_4]["reward"] = [];
    level._id_9DE3[var_4]["score"] = [];
    level._id_9DE3[var_4]["filter"] = _id_6B58(var_4);
    level._id_9DE3[var_4]["master"] = var_5;

    if(_id_8969(var_4)) {
      level._id_9DE3[var_4]["operation"] = 1;
      level._id_9DE3[var_4]["spReward"] = [];

      if(_id_8B0A(var_4)) {
        var_6 = _id_6E74(var_4);

        if(isDefined(var_6)) {
          level._id_9DE3[var_4]["weapon"] = var_6;
        }
      }
    }

    for(var_7 = 0; var_7 < 5; var_7++) {
      var_8 = _id_9DE0(var_0, var_4, var_7);
      var_9 = _id_9DDE(var_0, var_4, var_7);
      var_10 = _id_9DDF(var_0, var_4, var_7);

      if(var_8 == 0) {
        break;
      }

      level._id_9DE3[var_4]["targetval"][var_7] = var_8;
      level._id_9DE3[var_4]["reward"][var_7] = var_9;
      level._id_9DE3[var_4]["score"][var_7] = var_10;
      var_3 = var_3 + var_9;
    }

    var_4 = tablelookupbyrow(var_0, var_2, 0);
    var_2++;
  }

  return int(var_3);
}

_id_2D05() {
  level._id_9DE3 = [];
  var_0 = 0;
  var_0 = var_0 + _id_2D06("cp/allMeritsTable.csv", 0);
}

_id_892E(var_0) {
  var_1 = level._id_9DE3[var_0]["filter"];

  if(!isDefined(var_1)) {
    return 1;
  }

  return self _meth_81C8(var_1, "challenge");
}

_id_75CF(var_0) {
  return isDefined(level._id_9DE3) && isDefined(level._id_9DE3[var_0]);
}

_id_6B59(var_0) {
  var_1 = _func_0222("cp/allMeritsTable.csv", 0, var_0, 7);

  if(isDefined(var_1) && var_1 == "") {
    return undefined;
  }

  return var_1;
}

_id_BD76(var_0) {
  var_1 = level._id_9DE3[var_0]["master"];

  if(isDefined(var_1)) {
    thread _id_BD77(var_1);
  }
}

_id_A0F2() {
  self endon("disconnect");
  self._id_11B9 = 0.0;

  for(;;) {
    if(self playerads() == 1) {
      self._id_11B9 = self._id_11B9 + 0.05;
    } else {
      self._id_11B9 = 0.0;
    }

    wait 0.05;
  }
}
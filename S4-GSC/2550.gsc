/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2550.gsc
*************************************************/

init() {
  _id_80D0();
  _id_7F26();
  _id_804B();
  _id_7F05();
  _id_7F0B();
  _id_7F06();
  _id_7F04();
  level._id_2849 = 1;
}

_id_7F26() {
  var_0 = "mp/botClassTable.csv";
  level._id_2937 = [];
  var_1 = _id_283E();
  var_2 = 0;

  for(;;) {
    var_2++;
    var_3 = _func_0222(var_0, 0, "botArchetype", var_2);
    var_4 = _func_0222(var_0, 0, "botPersonalities", var_2);
    var_5 = _func_0222(var_0, 0, "botDifficulties", var_2);

    if(!isDefined(var_3) || var_3 == "") {
      break;
    }

    if(!isDefined(var_4) || var_4 == "") {
      break;
    }

    if(!isDefined(var_5) || var_5 == "") {
      break;
    }

    var_6 = [];

    foreach(var_8 in var_1) {
      var_6[var_8] = _func_0222(var_0, 0, var_8, var_2);
    }

    var_10 = strtok(var_3, "|");
    var_11 = strtok(var_4, "| ");
    var_12 = strtok(var_5, "| ");

    foreach(var_14 in var_10) {
      var_14 = "archetype_" + var_14;
      var_6["loadoutArchetype"] = var_14;

      foreach(var_16 in var_11) {
        foreach(var_18 in var_12) {
          var_19 = _id_2845(var_14, var_16, var_18, 1);
          var_20 = spawnStruct();
          var_20._id_96A4 = var_6;
          var_19._id_9691[var_19._id_9691.size] = var_20;
        }
      }
    }
  }
}

_id_80D0() {
  var_0 = "mp/botTemplateTable.csv";
  level._id_2938 = [];
  var_1 = _id_283E();
  var_2 = 0;

  for(;;) {
    var_2++;
    var_3 = _func_0222(var_0, 0, "template_", var_2);

    if(!isDefined(var_3) || var_3 == "") {
      break;
    }

    var_4 = "template_" + var_3;
    level._id_2938[var_4] = [];

    foreach(var_6 in var_1) {
      var_7 = _func_0222(var_0, 0, var_6, var_2);

      if(isDefined(var_7) && var_7 != "") {
        level._id_2938[var_4][var_6] = var_7;
      }
    }
  }
}

_id_7F04() {
  level._id_292B = [];
  level._id_292B["cqb"] = ["archetype_assault"];
  level._id_292B["run_and_gun"] = ["archetype_assault"];
  level._id_292B["camper"] = ["archetype_assault"];
  level._id_292B["default"] = ["archetype_assault"];
}

_id_2756() {
  return getdvarint("#x3708737910fed3648", 1);
}

_id_2841(var_0, var_1, var_2) {
  if(!_func_0127() || 1) {
    return 1;
  }

  if(!_id_2756()) {
    return 0;
  }

  if(var_1 == "specialty_null") {
    return 1;
  }

  if(var_1 == "none") {
    return 1;
  }

  if(var_0 == "equipment") {
    if(getmatchrulesdata("commonOption", "perkRestricted", var_1)) {
      return 0;
    }

    var_0 = "weapon";
  }

  var_3 = var_0 + "Restricted";
  var_4 = var_0 + "ClassRestricted";
  var_5 = "";

  switch (var_0) {
    case "weapon":
      var_5 = scripts\mp\utility\weapon::getweapongroup(var_1);
      break;
    case "attachment":
      var_5 = scripts\mp\utility\weapon::_id_68E5(var_1);
      break;
    case "killstreak":
      var_5 = var_2;
      break;
    case "perk":
      var_5 = "ability_" + level._id_287F[var_1];
      break;
    default:
      return 0;
  }

  if(getmatchrulesdata("commonOption", var_3, var_1)) {
    return 0;
  }

  if(var_5 != "" && getmatchrulesdata("commonOption", var_4, var_5)) {
    return 0;
  }

  return 1;
}

_id_2834(var_0) {
  var_1 = "none";
  var_2 = ["veteran", "hardened", "regular", "recruit"];
  var_2 = scripts\engine\utility::array_randomize(var_2);

  foreach(var_4 in var_2) {
    var_1 = _id_283B("weap_statstable", var_0, "loadoutPrimary", self._id_292A, self._id_B023, var_4);

    if(var_1 != "none") {
      return var_1;
    }
  }

  if(isDefined(level._id_2883)) {
    var_6 = scripts\engine\utility::array_randomize(level._id_2883);

    foreach(var_8 in var_6) {
      foreach(var_4 in var_2) {
        var_1 = _id_283B("weap_statstable", var_0, "loadoutPrimary", var_0["loadoutArchetype"], var_8, var_4);

        if(var_1 != "none") {
          self._id_2788 = var_8;
          return var_1;
        }
      }
    }
  }

  if(_func_0127()) {
    var_12 = 0.0;
    var_13 = 0;

    for(var_14 = "none"; var_13 < 6 && (!isDefined(var_1) || var_1 == "none" || var_1 == ""); var_13++) {
      if(scripts\mp\utility\game::_id_6B32("defaultClasses", _id_2847(), var_13, "class", "inUse")) {
        var_1 = _id_2837(var_13, "loadoutPrimary");

        if(var_1 != "none") {
          var_12 = var_12 + 1.0;

          if(randomfloat(1.0) >= 1.0 / var_12) {
            var_14 = var_1;
          }
        }
      }
    }

    if(var_14 != "none") {
      self._id_2788 = "weapon";
      return var_14;
    }
  }

  self._id_2788 = "weapon";
  return level._id_2789;
}

_id_2847() {
  if(!isDefined(level.teambased) || !level.teambased) {
    return "allies";
  }

  return scripts\mp\bots\bots::_id_27CD();
}

_id_275F() {
  var_0 = ["class1", "class2", "class3", "class4", "class5"];

  if(_func_0127()) {
    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      if(scripts\mp\utility\game::_id_6B32("defaultClasses", _id_2847(), var_1, "class", "inUse")) {
        var_0[var_1] = var_1;
      }
    }
  }

  var_2 = scripts\engine\utility::random(var_0);
  var_4 = [];

  foreach(var_6 in level._id_283E) {
    if(_func_0121(var_2)) {
      var_4[var_6] = _id_2838(var_2, var_6);
      continue;
    }

    var_4[var_6] = _id_2837(var_2, var_6);
  }

  return var_4;
}

_id_2889(var_0) {
  if(isDefined(var_0)) {
    var_1 = level._id_2926[var_0];

    if(isDefined(var_1)) {
      var_2 = strtok(var_1, "| ");

      if(var_2.size > 0) {
        scripts\mp\bots\bots_util::_id_28C8(scripts\engine\utility::random(var_2));
      }
    }
  }
}

_id_283E() {
  var_0 = "mp/botClassTable.csv";

  if(!isDefined(level._id_283E)) {
    level._id_283E = [];
    var_1 = 3;

    for(;;) {
      var_2 = tablelookupbyrow(var_0, var_1, 0);

      if(var_2 == "") {
        break;
      }

      level._id_283E[level._id_283E.size] = var_2;
      var_1++;
    }
  }

  return level._id_283E;
}

_id_2845(var_0, var_1, var_2, var_3) {
  var_4 = _id_2842(var_0, var_1, var_2);

  if(!isDefined(level._id_2937)) {
    level._id_2937 = [];
  }

  if(!isDefined(level._id_2937[var_4]) && var_3) {
    level._id_2937[var_4] = spawnStruct();
    level._id_2937[var_4]._id_9691 = [];
  }

  if(isDefined(level._id_2937[var_4])) {
    return level._id_2937[var_4];
  }
}

_id_2844(var_0, var_1, var_2) {
  var_3 = _id_2845(var_0, var_1, var_2, 0);

  if(isDefined(var_3) && isDefined(var_3._id_9691) && var_3._id_9691.size > 0) {
    var_4 = randomint(var_3._id_9691.size);
    return var_3._id_9691[var_4]._id_96A4;
  }
}

_id_2912(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\utility\weapon::_id_68AC(var_0);

  if(isDefined(var_3) && var_3 != "none") {
    if(!_id_2841("attachment", var_3, undefined)) {
      return 0;
    }

    if(!scripts\engine\utility::array_contains(var_4, var_3)) {
      return 0;
    }
  }

  var_5 = [];
  var_6 = _func_00D6(var_1, 0, var_1.size - 1);
  var_7 = int(_func_00D6(var_1, var_1.size - 1, var_1.size));

  for(var_8 = 1; var_8 < var_7; var_8++) {
    var_9 = var_6 + var_8;

    if(isDefined(var_2[var_9]) && var_2[var_9] != "none") {
      var_5[var_5.size] = var_2[var_9];
    }
  }

  for(var_8 = 0; var_8 < var_5.size; var_8++) {
    var_10 = 0;

    if(var_3 == var_5[var_8]) {
      var_10++;

      if(var_10 == 1) {
        if(!isDefined(level._id_1595[var_3])) {
          return 0;
        }
      } else if(var_10 > 1)
        return 0;
    } else if(isDefined(level._id_27FF[var_3])) {
      if(isDefined(level._id_27FF[var_3][var_5[var_8]])) {
        return 0;
      }
    }
  }

  return 1;
}

_id_2911(var_0, var_1, var_2) {
  if(isDefined(var_1[var_0 + "Attachment"]) && isDefined(level._id_2702[var_1[var_0 + "Attachment"]])) {
    return 1;
  }

  if(isDefined(var_1[var_0 + "Attachment2"]) && isDefined(level._id_2702[var_1[var_0 + "Attachment2"]])) {
    return 1;
  }

  if(isDefined(var_1[var_0 + "Attachment3"]) && isDefined(level._id_2702[var_1[var_0 + "Attachment3"]])) {
    return 1;
  }

  return 0;
}

_id_287C(var_0) {
  return level._id_AFFF[var_0];
}

_id_AFFE(var_0, var_1) {
  if(_id_287C(var_0) > 0) {
    var_2 = [];
    var_2["type"] = var_1;
    var_2["name"] = var_0;
    level._id_287D[level._id_287D.size] = var_2;
    level._id_287F[var_0] = var_1;
  }
}

_id_804B() {
  level._id_AFFF = [];
  var_0 = 1;

  for(;;) {
    var_1 = tablelookupbyrow("mp/perktable.csv", var_0, 1);

    if(var_1 == "") {
      break;
    }

    level._id_AFFF[var_1] = int(tablelookupbyrow("mp/perktable.csv", var_0, 10));
    var_0++;
  }

  level._id_AFFF["none"] = 0;
  level._id_AFFF["specialty_null"] = 0;
  level._id_287D = [];
  level._id_287F = [];
  var_0 = 1;

  for(var_2 = "ability_null"; isDefined(var_2) && var_2 != ""; var_2 = tablelookupbyrow("mp/cacabilitytable.csv", var_0, 1)) {
    var_2 = _func_00D6(var_2, 8);

    for(var_3 = 4; var_3 <= 13; var_3++) {
      var_1 = tablelookupbyrow("mp/cacabilitytable.csv", var_0, var_3);

      if(var_1 != "") {
        _id_AFFE(var_1, var_2);
      }
    }

    var_0++;
  }
}

_id_7F0B() {
  level._id_2927 = [];
  level._id_2926 = [];
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("mp/statstable.csv", var_0, 0);

    if(var_1 == "") {
      break;
    }

    var_2 = tablelookupbyrow("mp/statstable.csv", var_0, 4);
    var_3 = tablelookupbyrow("mp/statstable.csv", var_0, 38);
    var_4 = tablelookupbyrow("mp/statstable.csv", var_0, 40);
    var_5 = tablelookupbyrow("mp/statstable.csv", var_0, 39);

    if(var_4 != "" && var_2 != "" && var_5 != "" && var_3 != "" && bot_loadout_weapon_is_allowed(var_2)) {
      var_6 = "loadoutPrimary";

      if(scripts\mp\utility\weapon::_id_879C(var_2)) {
        var_6 = "loadoutSecondary";
      } else if(!scripts\mp\utility\weapon::_id_879A(var_2)) {
        var_0++;
        continue;
      }

      level._id_2926[var_2] = var_5;

      if(!isDefined(level._id_2927[var_6])) {
        level._id_2927[var_6] = [];
      }

      var_7 = strtok(var_3, "|");
      var_8 = strtok(var_5, "| ");
      var_9 = strtok(var_4, "| ");

      foreach(var_11 in var_7) {
        var_11 = "archetype_" + var_11;

        foreach(var_13 in var_8) {
          foreach(var_15 in var_9) {
            var_16 = _id_2842(var_11, var_13, var_15);

            if(!isDefined(level._id_2927[var_6][var_16])) {
              level._id_2927[var_6][var_16] = [];
            }

            var_17 = level._id_2927[var_6][var_16].size;
            level._id_2927[var_6][var_16][var_17] = var_2;
          }
        }
      }
    }

    var_0++;
  }
}

bot_loadout_weapon_is_allowed(var_0) {
  switch (var_0) {
    case "s4_pi_raygun":
      return 0;
    case "s4_ar_tgun":
      return 0;
    default:
      return 1;
  }
}

_id_283B(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = "none";

  if(var_2 == "loadoutSecondary" && scripts\engine\utility::array_contains(var_1, "specialty_twoprimaries")) {
    var_2 = "loadoutPrimary";
  }

  if(!isDefined(level._id_2927)) {
    return var_6;
  }

  if(!isDefined(level._id_2927[var_2])) {
    return var_6;
  }

  var_7 = _id_2842(var_3, var_4, var_5);

  if(!isDefined(level._id_2927[var_2][var_7])) {
    return var_6;
  }

  var_6 = _id_283A(level._id_2927[var_2][var_7], var_0, var_1, var_2);
  return var_6;
}

_id_2839(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = "specialty_null";

  if(!isDefined(level._id_287D)) {
    return var_6;
  }

  if(!isDefined(level._id_287E)) {
    level._id_287E = [];
  }

  if(!isDefined(level._id_287E[var_0])) {
    var_7 = strtok(var_0, "_");
    var_7[0] = "";
    var_8 = 0;

    if(scripts\engine\utility::array_contains(var_7, "any")) {
      var_8 = 1;
    }

    var_9 = [];

    foreach(var_11 in level._id_287D) {
      if(var_8 || scripts\engine\utility::array_contains(var_7, var_11["type"])) {
        var_9[var_9.size] = var_11["name"];
      }
    }

    level._id_287E[var_0] = var_9;
  }

  if(level._id_287E[var_0].size > 0) {
    var_6 = _id_283A(level._id_287E[var_0], var_1, var_2, var_3);
  }

  return var_6;
}

_id_2910(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_4 - var_3 + 1;

  if(isDefined(var_5)) {
    var_6 = var_5;
  }

  var_7 = 0;
  var_8 = int(_func_00D6(var_1, 11));

  if(var_0 == "specialty_twoprimaries") {
    return 0;
  }

  if(var_0 == "specialty_extra_attachment") {
    return 0;
  }

  if(!_id_2841("perk", var_0)) {
    return 0;
  }

  for(var_9 = var_8 - 1; var_9 > 0; var_9--) {
    var_10 = "loadoutPerk" + var_9;

    if(var_2[var_10] == "none" || var_2[var_10] == "specialty_null") {
      continue;
    }
    if(var_0 == var_2[var_10]) {
      return 0;
    }

    if(var_9 >= var_3 && var_9 <= var_4) {
      var_7 = var_7 + _id_287C(var_2[var_10]);
    }
  }

  if(var_7 + _id_287C(var_0) > var_6) {
    return 0;
  }

  return 1;
}

_id_2838(var_0, var_1) {
  var_2 = int(_func_00D6(var_0, 5, 6)) - 1;

  switch (var_1) {
    case "loadoutPrimary":
      return scripts\mp\class::_id_EC6D(level._id_3809, var_2, 0);
    case "loadoutPrimaryAttachment1":
      return scripts\mp\class::_id_EC6E(level._id_3809, var_2, 0, 0);
    case "loadoutPrimaryAttachment2":
      return scripts\mp\class::_id_EC6E(level._id_3809, var_2, 0, 1);
    case "loadoutPrimaryAttachment3":
      return scripts\mp\class::_id_EC6E(level._id_3809, var_2, 0, 2);
    case "loadoutPrimaryAttachment4":
      return scripts\mp\class::_id_EC6E(level._id_3809, var_2, 0, 3);
    case "loadoutPrimaryAttachment5":
      return scripts\mp\class::_id_EC6E(level._id_3809, var_2, 0, 4);
    case "loadoutPrimaryAttachment6":
      return scripts\mp\class::_id_EC6E(level._id_3809, var_2, 0, 5);
    case "loadoutPrimaryAttachment7":
      return scripts\mp\class::_id_EC6E(level._id_3809, var_2, 0, 6);
    case "loadoutPrimaryAttachment8":
      return scripts\mp\class::_id_EC6E(level._id_3809, var_2, 0, 7);
    case "loadoutPrimaryAttachment9":
      return scripts\mp\class::_id_EC6E(level._id_3809, var_2, 0, 8);
    case "loadoutPrimaryCamo":
      return scripts\mp\class::_id_EC6F(level._id_3809, var_2, 0);
    case "loadoutPrimaryReticle":
      return scripts\mp\class::_id_EC70(level._id_3809, var_2, 0);
    case "loadoutSecondary":
      return scripts\mp\class::_id_EC6D(level._id_3809, var_2, 1);
    case "loadoutSecondaryAttachment1":
      return scripts\mp\class::_id_EC6E(level._id_3809, var_2, 1, 0);
    case "loadoutSecondaryAttachment2":
      return scripts\mp\class::_id_EC6E(level._id_3809, var_2, 1, 1);
    case "loadoutSecondaryAttachment3":
      return scripts\mp\class::_id_EC6E(level._id_3809, var_2, 1, 2);
    case "loadoutSecondaryAttachment4":
      return scripts\mp\class::_id_EC6E(level._id_3809, var_2, 1, 3);
    case "loadoutSecondaryAttachment5":
      return scripts\mp\class::_id_EC6E(level._id_3809, var_2, 1, 4);
    case "loadoutSecondaryAttachment6":
      return scripts\mp\class::_id_EC6E(level._id_3809, var_2, 1, 5);
    case "loadoutSecondaryAttachment7":
      return scripts\mp\class::_id_EC6E(level._id_3809, var_2, 1, 6);
    case "loadoutSecondaryAttachment8":
      return scripts\mp\class::_id_EC6E(level._id_3809, var_2, 1, 7);
    case "loadoutSecondaryAttachment9":
      return scripts\mp\class::_id_EC6E(level._id_3809, var_2, 1, 8);
    case "loadoutSecondaryCamo":
      return scripts\mp\class::_id_EC6F(level._id_3809, var_2, 1);
    case "loadoutSecondaryReticle":
      return scripts\mp\class::_id_EC70(level._id_3809, var_2, 1);
    case "loadoutEquipmentPrimary":
      return scripts\mp\class::_id_EC60(level._id_3809, var_2);
    case "loadoutEquipmentSecondary":
      return scripts\mp\class::_id_EC61(level._id_3809, var_2);
    case "loadoutStreak1":
      return scripts\mp\class::_id_EC67(level._id_3809, var_2, 0);
    case "loadoutStreak2":
      return scripts\mp\class::_id_EC67(level._id_3809, var_2, 1);
    case "loadoutStreak3":
      return scripts\mp\class::_id_EC67(level._id_3809, var_2, 2);
    case "loadoutPerk6":
    case "loadoutPerk5":
    case "loadoutPerk4":
    case "loadoutPerk3":
    case "loadoutPerk2":
    case "loadoutPerk1":
      var_3 = int(_func_00D6(var_1, 11)) - 1;
      var_4 = scripts\mp\class::_id_EC69(level._id_3809, var_2, var_3);

      if(var_4 == "") {
        return "specialty_null";
      }

      return var_4;
    case "loadoutStreakType":
      return scripts\mp\class::_id_6B16("support");
  }

  return var_0;
}

_id_2837(var_0, var_1) {
  var_2 = _id_2847();
  var_3 = scripts\mp\utility\game::_id_6B33(var_2, var_0);
  return var_3[var_1];
}

_id_7F05() {
  level._id_2703 = [];
  level._id_2702 = [];
  var_0 = tablelookupgetnumrows("mp/attachmenttable.csv");

  for(var_1 = 1; var_1 < var_0; var_1++) {
    var_2 = tablelookupbyrow("mp/attachmenttable.csv", var_1, 5);
    var_3 = tablelookupbyrow("mp/attachmenttable.csv", var_1, 20);

    if(var_2 != "" && var_3 != "") {
      var_4 = tablelookupbyrow("mp/attachmenttable.csv", var_1, 11);

      if(var_4 == "TRUE") {
        level._id_2702[var_2] = 1;
      }

      var_5 = strtok(var_3, "| ");

      foreach(var_7 in var_5) {
        if(!isDefined(level._id_2703[var_7])) {
          level._id_2703[var_7] = [];
        }

        if(!scripts\engine\utility::array_contains(level._id_2703[var_7], var_2)) {
          var_8 = level._id_2703[var_7].size;
          level._id_2703[var_7][var_8] = var_2;
        }
      }
    }
  }

  if(!isDefined(level._id_27FF)) {
    level._id_27FF = [];
    level._id_1595 = [];
    var_10 = "mp/attachmentcombos.csv";
    var_11 = 0;

    for(;;) {
      var_11++;
      var_12 = tablelookupbyrow(var_10, 0, var_11);

      if(var_12 == "") {
        break;
      }

      var_1 = 0;

      for(;;) {
        var_1++;
        var_13 = tablelookupbyrow(var_10, var_1, 0);

        if(var_13 == "") {
          break;
        }

        if(var_13 == var_12) {
          if(tablelookupbyrow(var_10, var_1, var_11) != "no") {
            level._id_1595[var_13] = 1;
          }

          continue;
        }

        if(tablelookupbyrow(var_10, var_1, var_11) == "no") {
          level._id_27FF[var_12][var_13] = 1;
        }
      }
    }
  }
}

_id_2835(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "none";

  if(!isDefined(level._id_2703)) {
    return var_5;
  }

  if(!isDefined(level._id_2703[var_4])) {
    return var_5;
  }

  var_5 = _id_283A(level._id_2703[var_4], var_0, var_1, var_2);
  return var_5;
}

_id_7F06() {
  var_0 = "mp/camotable.csv";
  level._id_2716 = [];
  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow(var_0, var_1, scripts\common\utility::_id_6946("camoasset"));

    if(!isDefined(var_2) || var_2 == "") {
      break;
    }

    var_3 = tablelookupbyrow(var_0, var_1, scripts\common\utility::_id_6946("bot_valid"));

    if(isDefined(var_3) && int(var_3)) {
      level._id_2716[level._id_2716.size] = var_2;
    }

    var_1++;
  }
}

_id_2836(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "none";
  return var_5;
}

_id_2843(var_0) {
  var_1 = 8;

  if(isDefined(var_0["loadoutPrimary"]) && var_0["loadoutPrimary"] == "none") {
    var_1 = var_1 + 1;
  }

  if(isDefined(var_0["loadoutSecondary"]) && var_0["loadoutSecondary"] == "none") {
    var_1 = var_1 + 1;
  }

  if(isDefined(var_0["loadoutEquipmentPrimary"]) && var_0["loadoutEquipmentPrimary"] == "none") {
    var_1 = var_1 + 1;
  }

  if(isDefined(var_0["loadoutEquipmentSecondary"]) && var_0["loadoutEquipmentSecondary"] == "none") {
    var_1 = var_1 + 1;
  }

  return var_1;
}

_id_2848(var_0, var_1, var_2, var_3) {
  var_4 = 1;

  if(issubstr(var_2, "loadoutPrimaryAttachment") || issubstr(var_2, "loadoutSecondaryAttachment")) {
    var_4 = _id_2912(var_1["loadoutPrimary"], var_2, var_1, var_3);
    return var_4;
  }

  switch (var_2) {
    case "loadoutArchetype":
      break;
    case "loadoutPrimary":
      var_4 = _id_2841("weapon", var_3);
      break;
    case "loadoutEquipmentSecondary":
    case "loadoutEquipmentPrimary":
      var_4 = _id_2841("equipment", var_3);
      break;
    case "loadoutPrimaryReticle":
      var_4 = _id_2911("loadoutPrimary", var_1, var_3);
      break;
    case "loadoutPrimaryBuff":
      break;
    case "loadoutPrimaryCamo":
      var_4 = !isDefined(self._id_2935) || var_3 == self._id_2935;
      break;
    case "loadoutSecondary":
      var_4 = var_3 != var_1["loadoutPrimary"];
      var_4 = var_4 && _id_2841("weapon", var_3, undefined);
      break;
    case "loadoutSecondaryReticle":
      var_4 = _id_2911("loadoutSecondary", var_1, var_3);
      break;
    case "loadoutSecondaryBuff":
      break;
    case "loadoutSecondaryCamo":
      var_4 = !isDefined(self._id_2936) || var_3 == self._id_2936;
      break;
    case "loadoutStreak3":
    case "loadoutStreak2":
    case "loadoutStreak1":
      var_4 = _id_09F4::_id_281E(var_3, "bots", undefined, var_1["loadoutStreakType"]);
      var_4 = var_4 && _id_2841("killstreak", var_3, var_1["loadoutStreakType"]);
      break;
    case "loadoutStreakType":
      break;
    case "loadoutPerk12":
    case "loadoutPerk11":
    case "loadoutPerk10":
    case "loadoutPerk9":
    case "loadoutPerk8":
    case "loadoutPerk7":
    case "loadoutPerk6":
    case "loadoutPerk5":
    case "loadoutPerk4":
    case "loadoutPerk3":
    case "loadoutPerk2":
    case "loadoutPerk1":
      var_4 = _id_2910(var_3, var_2, var_1, 1, 12, _id_2843(var_1));
      break;
    case "loadoutPerk15":
    case "loadoutPerk14":
    case "loadoutPerk13":
      if(var_1["loadoutStreakType"] != "streaktype_specialist") {
        var_4 = 0;
      } else {
        var_4 = _id_2910(var_3, var_2, var_1, -1, -1);
      }

      break;
    case "loadoutPerk23":
    case "loadoutPerk22":
    case "loadoutPerk21":
    case "loadoutPerk20":
    case "loadoutPerk19":
    case "loadoutPerk18":
    case "loadoutPerk17":
    case "loadoutPerk16":
      if(var_1["loadoutStreakType"] != "streaktype_specialist") {
        var_4 = 0;
      } else {
        var_4 = _id_2910(var_3, var_2, var_1, 16, 23, 8);
      }

      break;
    default:
      break;
  }

  return var_4;
}

_id_283A(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "none";
  var_6 = undefined;
  var_7 = 0.0;

  if(scripts\engine\utility::array_contains(var_0, "specialty_null")) {
    var_5 = "specialty_null";
  }

  if(var_1 == "classtable_any") {
    if(!isDefined(self._id_4565)) {
      self._id_4565 = scripts\engine\utility::random(["class1", "class2", "class3", "class4", "class5"]);
    }

    var_0 = [self._id_4565];
  }

  foreach(var_9 in var_0) {
    var_10 = undefined;

    if(_func_00D6(var_9, 0, 9) == "template_") {
      var_10 = var_9;
      var_11 = level._id_2938[var_9][var_3];
      var_9 = _id_283A(strtok(var_11, "| "), var_1, var_2, var_3, 1);

      if(isDefined(var_10) && isDefined(self._id_36F0[var_10])) {
        return var_9;
      }
    }

    if(var_9 == "attachmenttable") {
      return _id_2835(var_1, var_2, var_3, self._id_B023, self._id_4989);
    }

    if(var_9 == "weap_statstable") {
      return _id_283B(var_1, var_2, var_3, self._id_292A, self._id_B023, self._id_4989);
    }

    if(var_9 == "camotable") {
      return _id_2836(var_1, var_2, var_3, self._id_B023, self._id_4989);
    }

    if(_func_00D6(var_9, 0, 5) == "class" && int(_func_00D6(var_9, 5, 6)) > 0) {
      var_9 = _id_2838(var_9, var_3);
    }

    if(isDefined(level._id_287D) && _func_00D6(var_9, 0, 10) == "perktable_") {
      return _id_2839(var_9, var_1, var_2, var_3, self._id_B023, self._id_4989);
    }

    if(_id_2848(var_1, var_2, var_3, var_9)) {
      var_7 = var_7 + 1.0;
      var_12 = randomfloat(1.0);

      if(var_12 < 1.0 / var_7) {
        var_5 = var_9;
        var_6 = var_10;
      }
    }
  }

  if(isDefined(var_6)) {
    self._id_36F0[var_6] = 1;
  }

  return var_5;
}

_id_283C(var_0) {
  self._id_36F0 = [];

  foreach(var_6, var_2 in var_0) {
    var_3 = undefined;

    if(!isDefined(var_3)) {
      var_5 = strtok(var_2, "| ");
      var_3 = _id_283A(var_5, var_2, var_0, var_6);
    }

    var_0[var_6] = var_3;
  }

  return var_0;
}

_id_2840() {
  var_0 = self _meth_802F();

  if(var_0 == "default") {
    scripts\mp\bots\bots_util::_id_28C4("default");
    var_0 = self _meth_802F();
  }

  return var_0;
}

_id_283F() {
  if(!isDefined(self._id_292A)) {
    var_0 = self _meth_803A();
    var_1 = level._id_292B[var_0];
    var_2 = randomint(var_1.size);
    self._id_292A = var_1[var_2];
  }

  return self._id_292A;
}

_id_27CF() {
  if(isDefined(self.pers["botCustomClasses"])) {
    return self.pers["botCustomClasses"];
  }

  return [];
}

_id_27D0() {
  if(_id_27CF().size > 0) {
    if(isDefined(self.pers["botLauncherClassIndex"])) {
      var_0 = self.pers["botLauncherClassIndex"];
      return self.pers["botCustomClasses"][var_0];
    }
  }

  return undefined;
}

_id_26FB() {
  if(istrue(self._id_2887)) {
    return 0;
  } else if(!isDefined(self.pers["botLastLoadout"])) {
    return 0;
  } else if(istrue(self._id_C68D)) {
    return 0;
  } else if(isDefined(self._id_7552) && !self._id_7552) {
    return 0;
  }

  return 1;
}

_id_283D(var_0) {
  while(!isDefined(level._id_2849)) {
    wait 0.05;
  }

  while(!isDefined(self._id_B023)) {
    wait 0.05;
  }

  var_1 = [];
  var_2 = _id_2840();
  self._id_4989 = var_2;
  var_3 = self _meth_803A();
  var_4 = _id_283F();

  if(!isDefined(self._id_282E)) {
    self._id_2755 = 0;
  }

  self._id_282E = self._id_2755;

  if(isDefined(self.pers["botLastLoadout"]) && istrue(var_0)) {
    return self.pers["botLastLoadout"];
  }

  var_5 = !isDefined(self.pers["botLastLoadoutDifficulty"]) || self.pers["botLastLoadoutDifficulty"] == var_2;
  var_6 = !isDefined(self.pers["botLastLoadoutPersonality"]) || self.pers["botLastLoadoutPersonality"] == var_3;
  var_7 = 0;

  if(!var_5 || !var_6) {
    self.pers["botLastLoadout"] = undefined;
    self.pers["botCustomClasses"] = undefined;
    self.pers["botLauncherClassIndex"] = undefined;
    var_7 = 1;
  }

  var_8 = !var_7 && _id_26FB();

  if(var_8) {
    var_9 = 0.1;
    var_11 = randomfloat(1.0) >= var_9;

    if(var_11) {
      return self.pers["botLastLoadout"];
    }
  }

  self._id_2887 = undefined;

  if(!var_7) {
    var_12 = _id_27D0();
    var_13 = undefined;

    if(isDefined(self._id_C68D) && isDefined(var_12)) {
      self._id_C68D = undefined;
      self._id_2887 = 1;
      var_13 = var_12;
    }

    if(!isDefined(var_13)) {
      var_14 = _id_27CF();
      var_15 = 0;

      if(isDefined(var_12)) {
        if(var_14.size < 5) {
          var_15 = 1;
        }
      } else if(isDefined(self._id_C68D))
        var_15 = 1;
      else if(var_14.size < 4) {
        var_15 = 1;
      }

      if(!var_15) {
        var_13 = scripts\engine\utility::random(var_14);
      }
    }

    if(isDefined(var_13)) {
      self._id_2755++;
      self.pers["botLastLoadout"] = var_13;
      return var_13;
    }
  }

  var_16 = undefined;
  var_17 = _id_2756();

  if(var_17) {
    var_16 = _id_2844(var_4, var_3, var_2);
    var_1 = _id_283C(var_16);

    if(isDefined(level._id_279D["gametype_loadout_modify"])) {
      var_1 = self[[level._id_279D["gametype_loadout_modify"]]](var_1);
    }

    if(_id_2853(var_1)) {
      var_17 = 0;
    }
  }

  if(!var_17) {
    var_1 = _id_275F();
    _id_2889(var_1["loadoutPrimary"]);
  }

  if(var_1["loadoutPrimary"] == "none") {
    self._id_2788 = undefined;
    var_1["loadoutPrimary"] = _id_2834(var_1);
    var_1["loadoutPrimaryCamo"] = "none";
    var_1["loadoutPrimaryAttachment"] = "none";
    var_1["loadoutPrimaryAttachment2"] = "none";
    var_1["loadoutPrimaryAttachment3"] = "none";
    var_1["loadoutPrimaryReticle"] = "none";

    if(isDefined(self._id_2788)) {
      if(self._id_2788 == "weapon") {
        _id_2889(var_1["loadoutPrimary"]);
      } else {
        scripts\mp\bots\bots_util::_id_28C8(self._id_2788);
      }

      var_3 = self._id_B023;
      self._id_2788 = undefined;
    }
  }

  var_18 = getDvar("#x3ce7ac18f1fedeb9d");

  if(var_18 != "") {
    var_1["loadoutPrimary"] = var_18;
  }

  var_19 = isDefined(self._id_C68D);

  if(var_17 && scripts\mp\bots\bots_util::_id_2811()) {
    if(isDefined(var_1["loadoutPrimaryCamo"]) && var_1["loadoutPrimaryCamo"] != "none" && !isDefined(self._id_2935)) {
      self._id_2935 = var_1["loadoutPrimaryCamo"];
    }

    if(isDefined(var_1["loadoutSecondaryCamo"]) && var_1["loadoutSecondaryCamo"] != "none" && !isDefined(self._id_2936)) {
      self._id_2936 = var_1["loadoutSecondaryCamo"];
    }

    if(var_19) {
      var_20 = level._id_28A8[self _meth_802F()];

      if(_id_2841("weapon", var_20, undefined)) {
        var_1["loadoutSecondary"] = level._id_28A8;
        var_1["loadoutSecondaryAttachment"] = "none";
        var_1["loadoutSecondaryAttachment2"] = "none";
        self._id_2887 = 1;
      }

      self._id_C68D = undefined;
    }
  }

  var_1 = _id_2846(var_1);

  if(scripts\mp\bots\bots_util::_id_2811()) {
    if(scripts\engine\utility::array_contains(self.pers["loadoutPerks"], "specialty_twoprimaries")) {
      var_21 = _id_2844("cqb", var_2);
      var_1["loadoutSecondary"] = var_21["loadoutPrimary"];
      var_1["loadoutSecondaryAttachment"] = var_21["loadoutPrimaryAttachment"];
      var_1["loadoutSecondaryAttachment2"] = var_21["loadoutPrimaryAttachment2"];
      var_1 = _id_283C(var_1);
      var_1 = _id_2846(var_1);
    }

    if(scripts\engine\utility::array_contains(self.pers["loadoutPerks"], "specialty_extra_attachment")) {
      var_22 = _id_2844(var_3, var_2);
      var_1["loadoutPrimaryAttachment3"] = var_22["loadoutPrimaryAttachment2"];

      if(scripts\engine\utility::array_contains(self.pers["loadoutPerks"], "specialty_twoprimaries")) {
        var_1["loadoutSecondaryAttachment2"] = var_22["loadoutPrimaryAttachment2"];
      } else {
        var_1["loadoutSecondaryAttachment2"] = var_22["loadoutSecondaryAttachment2"];
      }

      var_1 = _id_283C(var_1);
      var_1 = _id_2846(var_1);
    } else {
      var_1["loadoutSecondaryAttachment2"] = "none";

      if(!_id_2911("loadoutSecondary", var_1, var_1["loadoutSecondaryReticle"])) {
        var_1["loadoutSecondaryReticle"] = "none";
      }
    }
  }

  self._id_2755++;
  self.pers["botLastLoadout"] = var_1;
  self.pers["botLastLoadoutDifficulty"] = var_2;
  self.pers["botLastLoadoutPersonality"] = var_3;

  if(!isDefined(self.pers["botCustomClasses"])) {
    self.pers["botCustomClasses"] = [];
  }

  var_23 = self.pers["botCustomClasses"].size;
  self.pers["botCustomClasses"][var_23] = var_1;

  if(var_19) {
    self.pers["botLauncherClassIndex"] = var_23;
  }

  return var_1;
}

_id_2846(var_0) {
  self.pers["loadoutPerks"] = [];
  self.pers["specialistBonusStreaks"] = [];
  self.pers["specialistStreaks"] = [];
  self.pers["specialistStreakKills"] = [];
  var_1 = 0;
  var_2 = isDefined(var_0["loadoutStreakType"]) && var_0["loadoutStreakType"] == "streaktype_specialist";

  if(var_2) {
    var_0["loadoutStreak1"] = "none";
    var_0["loadoutStreak2"] = "none";
    var_0["loadoutStreak3"] = "none";
  }

  foreach(var_8, var_4 in var_0) {
    if(var_4 == "specialty_null" || var_4 == "none") {
      continue;
    }
    if(_func_00D6(var_8, 0, 11) == "loadoutPerk") {
      var_5 = int(_func_00D6(var_8, 11));

      if(!var_2 && var_5 > 12) {
        continue;
      }
      var_6 = scripts\mp\utility\perk::_id_68FF(var_4);

      if(var_5 <= 12) {
        self.pers["loadoutPerks"][self.pers["loadoutPerks"].size] = var_6;
      } else if(var_5 <= 15) {
        var_0["loadoutStreak" + (var_1 + 1)] = var_6 + "_ks";
        self.pers["specialistStreaks"][self.pers["specialistStreaks"].size] = var_6 + "_ks";
        var_7 = 0;

        if(var_1 > 0) {
          var_7 = self.pers["specialistStreakKills"][self.pers["specialistStreakKills"].size - 1];
        }

        self.pers["specialistStreakKills"][self.pers["specialistStreakKills"].size] = var_7 + _id_287C(var_6) + 2;
        var_1++;
      } else
        self.pers["specialistBonusStreaks"][self.pers["specialistBonusStreaks"].size] = var_6;
    }
  }

  if(var_2 && !isDefined(self.pers["specialistStreakKills"][0])) {
    self.pers["specialistStreakKills"][0] = 0;
    self.pers["specialistStreaks"][0] = "specialty_null";
  }

  if(var_2 && !isDefined(self.pers["specialistStreakKills"][1])) {
    self.pers["specialistStreakKills"][1] = self.pers["specialistStreakKills"][0];
    self.pers["specialistStreaks"][1] = "specialty_null";
  }

  if(var_2 && !isDefined(self.pers["specialistStreakKills"][2])) {
    self.pers["specialistStreakKills"][2] = self.pers["specialistStreakKills"][1];
    self.pers["specialistStreaks"][2] = "specialty_null";
  }

  return var_0;
}

_id_2853(var_0) {
  if(_func_0127()) {
    if(var_0["loadoutPrimary"] == "none") {
      return 1;
    }
  }

  return 0;
}

_id_28CF() {
  var_0 = _id_283F();
  var_1 = self _meth_803A();
  var_2 = _id_2840();
  var_3 = _id_2845(var_0, var_1, var_2, 0);

  if(isDefined(var_3) && isDefined(var_3._id_9691) && var_3._id_9691.size > 0) {
    self._id_3802 = ::_id_283D;
    return 1;
  }

  var_4 = _func_00D6(self.name, 0, self.name.size - 10);
  self._id_3802 = undefined;
  return 0;
}

_id_2842(var_0, var_1, var_2) {
  return var_0 + "_" + var_1 + "_" + var_2;
}

_id_2858() {}
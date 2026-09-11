/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_loadout.gsc
***********************************************/

function init() {
  init_template_table();
  init_class_table();
  init_perktable();
  init_bot_attachmenttable();
  init_bot_weap_statstable();
  init_bot_camotable();
  init_bot_archetypes();
  level.bot_loadouts_initialized = 1;
}

function init_class_table() {
  var_0 = "mp/botClassTable.csv";
  level.botloadoutsets = [];
  var_1 = bot_loadout_fields();
  var_2 = 0;

  for(;;) {
    var_2++;
    var_3 = tablelookup(var_0, 0, "botArchetype", var_2);
    var_4 = tablelookup(var_0, 0, "botPersonalities", var_2);
    var_5 = tablelookup(var_0, 0, "botDifficulties", var_2);

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
      var_6 = tablelookup(var_0, 0, var_8, var_2);
    }

    var_10 = strtok(var_3, "|");
    var_11 = strtok(var_4, "| ");
    var_12 = strtok(var_5, "| ");

    foreach(var_14 in var_10) {
      var_14 = "archetype_" + var_14;
      var_6 = var_14;

      foreach(var_16 in var_11) {
        foreach(var_18 in var_12) {
          var_19 = bot_loadout_set(var_14, var_16, var_18, 1);
          var_20 = spawnStruct();
          var_20.loadoutvalues = var_6;
          var_19.loadouts[var_19.loadouts.size] = var_20;
        }
      }
    }
  }
}

function init_template_table() {
  var_0 = "mp/botTemplateTable.csv";
  level.botloadouttemplates = [];
  var_1 = bot_loadout_fields();
  var_2 = 0;

  for(;;) {
    var_2++;
    var_3 = tablelookup(var_0, 0, "template_", var_2);

    if(!isDefined(var_3) || var_3 == "") {
      break;
    }

    var_4 = "template_" + var_3;
    level.botloadouttemplates[var_4] = [];

    foreach(var_6 in var_1) {
      var_7 = tablelookup(var_0, 0, var_6, var_2);

      if(isDefined(var_7) && var_7 != "") {
        level.botloadouttemplates[var_4][var_6] = var_7;
      }
    }
  }
}

function init_bot_archetypes() {
  level.botarchetypes = [];
  level.botarchetypes["cqb"] = ["archetype_assault"];
  level.botarchetypes["run_and_gun"] = ["archetype_assault"];
  level.botarchetypes["camper"] = ["archetype_assault"];
  level.botarchetypes["default"] = ["archetype_assault"];
}

function cypher_vo_complete() {
  return true;
}

function bot_loadout_item_allowed(var_0, var_1, var_2) {
  if(!isusingmatchrulesdata() || true) {
    return true;
  }

  if(!cypher_vo_complete()) {
    return false;
  }

  if(var_1 == "specialty_null") {
    return true;
  }

  if(var_1 == "none") {
    return true;
  }

  if(var_0 == "equipment") {
    if(getmatchrulesdata("commonOption", "perkRestricted", var_1)) {
      return false;
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
      var_5 = scripts\mp\utility\weapon::getattachmenttype(var_1);
      break;
    case "killstreak":
      var_5 = var_2;
      break;
    case "perk":
      var_5 = "ability_" + level.bot_perktypes[var_1];
      break;
    default:
      return false;
  }

  if(getmatchrulesdata("commonOption", var_3, var_1)) {
    return false;
  }

  if(var_5 != "" && getmatchrulesdata("commonOption", var_4, var_5)) {
    return false;
  }

  return true;
}

function bot_loadout_choose_fallback_primary(var_0) {
  var_1 = "none";
  var_2 = ["veteran", "hardened", "regular", "recruit"];
  var_2 = scripts\engine\utility::array_randomize(var_2);

  foreach(var_4 in var_2) {
    var_1 = bot_loadout_choose_from_statstable("weap_statstable", var_0, "loadoutPrimary", self.botarchetype, self.personality, var_4);

    if(var_1 != "none") {
      return var_1;
    }
  }

  if(isDefined(level.bot_personality_list)) {
    var_6 = scripts\engine\utility::array_randomize(level.bot_personality_list);

    foreach(var_8 in var_6) {
      foreach(var_4 in var_2) {
        var_1 = bot_loadout_choose_from_statstable("weap_statstable", var_0, "loadoutPrimary", var_0["loadoutArchetype"], var_8, var_4);

        if(var_1 != "none") {
          self.bot_fallback_personality = var_8;
          return var_1;
        }
      }
    }
  }

  if(isusingmatchrulesdata()) {
    var_12 = 0;
    var_13 = 0;
    var_14 = "none";

    while(var_13 < 6 && (!isDefined(var_1) || var_1 == "none" || var_1 == "")) {
      if(scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", deactivate_trap_object(), var_13, "class", "inUse")) {
        var_1 = deactivate_track_timers(var_13, "loadoutPrimary");

        if(var_1 != "none") {
          var_12 += 1;

          if(randomfloat(1) >= 1 / var_12) {
            var_14 = var_1;
          }
        }
      }

      var_13++;
    }

    if(var_14 != "none") {
      self.bot_fallback_personality = "weapon";
      return var_14;
    }
  }

  self.bot_fallback_personality = "weapon";
  return level.bot_fallback_weapon;
}

function deactivate_trap_object() {
  if(!isDefined(level.teambased) || !level.teambased) {
    return "allies";
  }

  return scripts\mp\bots\bots::bot_get_player_team();
}

function damage_enemies_in_trigger() {
  var_0 = ["class1", "class2", "class3", "class4", "class5"];

  if(isusingmatchrulesdata()) {
    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      if(scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", deactivate_trap_object(), var_1, "class", "inUse")) {
        var_0 = var_1;
      }
    }
  }

  var_2 = scripts\engine\utility::random(var_0);
  var_3 = [];

  foreach(var_5 in level.bot_loadout_fields) {
    if(isstring(var_2)) {
      var_3 = bot_loadout_choose_from_default_class(var_2, var_5);
      continue;
    }

    var_3 = deactivate_track_timers(var_2, var_5);
  }

  return var_3;
}

function bot_pick_personality_from_weapon(var_0) {
  if(isDefined(var_0)) {
    var_1 = level.bot_weap_personality[var_0];

    if(isDefined(var_1)) {
      var_2 = strtok(var_1, "| ");

      if(var_2.size > 0) {
        scripts\mp\bots\bots_util::bot_set_personality(scripts\engine\utility::random(var_2));
        return;
      }

      return;
    }

    return;
  }
}

function bot_loadout_fields() {
  var_0 = "mp/botClassTable.csv";

  if(!isDefined(level.bot_loadout_fields)) {
    level.bot_loadout_fields = [];

    for(var_1 = 3;; var_1++) {
      var_2 = tablelookupbyrow(var_0, var_1, 0);

      if(var_2 == "") {
        break;
      }

      level.bot_loadout_fields[level.bot_loadout_fields.size] = var_2;
    }
  }

  return level.bot_loadout_fields;
}

function bot_loadout_set(var_0, var_1, var_2, var_3) {
  var_4 = bot_loadout_make_index(var_0, var_1, var_2);

  if(!isDefined(level.botloadoutsets)) {
    level.botloadoutsets = [];
  }

  if(!isDefined(level.botloadoutsets[var_4]) && var_3) {
    level.botloadoutsets[var_4] = spawnStruct();
    level.botloadoutsets[var_4].loadouts = [];
  }

  if(isDefined(level.botloadoutsets[var_4])) {
    return level.botloadoutsets[var_4];
  }
}

function bot_loadout_pick(var_0, var_1, var_2) {
  var_3 = bot_loadout_set(var_0, var_1, var_2, 0);

  if(isDefined(var_3) && isDefined(var_3.loadouts) && var_3.loadouts.size > 0) {
    var_4 = randomint(var_3.loadouts.size);
    return var_3.loadouts[var_4].loadoutvalues;
  }
}

function bot_validate_weapon(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = [];

  if(isDefined(var_1) && var_1 != "none") {
    GscBinSkip0(0x2e, var_7.size, var_1);
  }

  if(isDefined(var_2) && var_2 != "none") {
    GscBinSkip0(0x2e, var_7.size, var_2);
  }

  if(isDefined(var_3) && var_3 != "none") {
    GscBinSkip0(0x2e, var_7.size, var_3);
  }

  if(isDefined(var_4) && var_4 != "none") {
    GscBinSkip0(0x2e, var_7.size, var_4);
  }

  if(isDefined(var_5) && var_5 != "none") {
    GscBinSkip0(0x2e, var_7.size, var_5);
  }

  if(isDefined(var_6) && var_6 != "none") {
    GscBinSkip0(0x2e, var_7.size, var_6);
  }

  var_8 = scripts\mp\utility\weapon::register_wave_spawner(var_0);
  var_9 = scripts\mp\weapons::safechecknum(var_0);
  var_10 = damageskipburndownmedium(var_9);
  var_11 = damageshield_threshold(var_9);

  for(var_12 = 0; var_12 < var_7.size; var_12++) {
    if(!bot_loadout_item_allowed("attachment", var_7[var_12], undefined)) {
      return false;
    }

    if(!scripts\engine\utility::array_contains(var_8, var_7[var_12])) {
      return false;
    }

    var_13 = 0;

    for(var_14 = var_12 - 1; var_14 >= 0; var_14--) {
      if(var_7[var_12] == var_7[var_14]) {
        var_13++;

        if(var_13 == 1) {
          if(!isDefined(var_11[var_7[var_12]])) {
            return false;
          }
        } else if(var_13 > 1) {
          return false;
        }

        continue;
      }

      if(isDefined(var_10[var_7[var_12]])) {
        if(isDefined(var_10[var_7[var_12]][var_7[var_14]])) {
          return false;
        }
      }
    }
  }

  return true;
}

function bot_validate_reticle(var_0, var_1, var_2) {
  if(isDefined(var_1[var_0 + "Attachment"]) && isDefined(level.bot_attachment_reticle[var_1[var_0 + "Attachment"]])) {
    return true;
  }

  if(isDefined(var_1[var_0 + "Attachment2"]) && isDefined(level.bot_attachment_reticle[var_1[var_0 + "Attachment2"]])) {
    return true;
  }

  if(isDefined(var_1[var_0 + "Attachment3"]) && isDefined(level.bot_attachment_reticle[var_1[var_0 + "Attachment3"]])) {
    return true;
  }

  return false;
}

function bot_perk_cost(var_0) {
  return level.perktable_costs[var_0];
}

function perktable_add(var_0, var_1) {
  if(bot_perk_cost(var_0) > 0) {
    var_2 = [];
    GscBinSkip0(0x2e, "type", var_1);
  }
}

function init_perktable() {
  level.perktable_costs = [];

  for(var_0 = 1;; var_0++) {
    var_1 = tablelookupbyrow("mp/perktable.csv", var_0, 1);

    if(var_1 == "") {
      break;
    }

    level.perktable_costs[var_1] = int(tablelookupbyrow("mp/perktable.csv", var_0, 10));
  }

  level.perktable_costs["none"] = 0;
  level.perktable_costs["specialty_null"] = 0;
  level.bot_perktable = [];
  level.bot_perktypes = [];
  var_0 = 1;

  for(var_2 = "ability_null"; isDefined(var_2) && var_2 != ""; var_2 = tablelookupbyrow("mp/cacabilitytable.csv", var_0, 1)) {
    var_2 = getsubstr(var_2, 8);

    for(var_3 = 4; var_3 <= 13; var_3++) {
      var_1 = tablelookupbyrow("mp/cacabilitytable.csv", var_0, var_3);

      if(var_1 != "") {
        perktable_add(var_1, var_2);
      }
    }

    var_0++;
  }
}

function init_bot_weap_statstable() {
  level.bot_weap_statstable = [];
  level.bot_weap_personality = [];

  for(var_0 = 0;; var_0++) {
    var_1 = tablelookupbyrow("mp/statstable.csv", var_0, 0);

    if(var_1 == "") {
      break;
    }

    var_2 = tablelookupbyrow("mp/statstable.csv", var_0, 4);
    var_3 = tablelookupbyrow("mp/statstable.csv", var_0, 38);
    var_4 = tablelookupbyrow("mp/statstable.csv", var_0, 40);
    var_5 = tablelookupbyrow("mp/statstable.csv", var_0, 39);

    if(var_4 != "" && var_2 != "" && var_5 != "" && var_3 != "") {
      if(!scripts\mp\weapons::vehicle_ai_avoidance_cleanup(var_2)) {
        var_0++;
        continue;
      }

      var_6 = "loadoutPrimary";

      if(scripts\mp\utility\weapon::iscacsecondaryweapon(var_2)) {
        var_6 = "loadoutSecondary";
      } else if(!scripts\mp\utility\weapon::iscacprimaryweapon(var_2)) {
        var_0++;
        continue;
      }

      level.bot_weap_personality[var_2] = var_5;

      if(!isDefined(level.bot_weap_statstable[var_6])) {
        level.bot_weap_statstable[var_6] = [];
      }

      var_7 = strtok(var_3, "|");
      var_8 = strtok(var_5, "| ");
      var_9 = strtok(var_4, "| ");

      foreach(var_11 in var_7) {
        var_11 = "archetype_" + var_11;

        foreach(var_13 in var_8) {
          foreach(var_15 in var_9) {
            var_16 = bot_loadout_make_index(var_11, var_13, var_15);

            if(!isDefined(level.bot_weap_statstable[var_6][var_16])) {
              level.bot_weap_statstable[var_6][var_16] = [];
            }

            var_17 = level.bot_weap_statstable[var_6][var_16].size;
            level.bot_weap_statstable[var_6][var_16][var_17] = var_2;
          }
        }
      }
    }
  }
}

function bot_loadout_choose_from_statstable(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = "none";

  if(var_2 == "loadoutSecondary" && scripts\engine\utility::array_contains(var_1, "specialty_twoprimaries")) {
    var_2 = "loadoutPrimary";
  }

  if(!isDefined(level.bot_weap_statstable)) {
    return var_6;
  }

  if(!isDefined(level.bot_weap_statstable[var_2])) {
    return var_6;
  }

  var_7 = bot_loadout_make_index(var_3, var_4, var_5);

  if(!isDefined(level.bot_weap_statstable[var_2][var_7])) {
    return var_6;
  }

  var_6 = bot_loadout_choose_from_set(level.bot_weap_statstable[var_2][var_7], var_0, var_1, var_2);
  return var_6;
}

function bot_loadout_choose_from_perktable(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = "specialty_null";

  if(!isDefined(level.bot_perktable)) {
    return var_6;
  }

  if(!isDefined(level.bot_perktable_groups)) {
    level.bot_perktable_groups = [];
  }

  if(!isDefined(level.bot_perktable_groups[var_0])) {
    var_7 = strtok(var_0, "_");
    GscBinSkip0(0x2e, 0, "");
  }

  if(level.bot_perktable_groups[var_1].size > 0) {
    var_7 = bot_loadout_choose_from_set(level.bot_perktable_groups[var_1], var_2, var_3, var_4);
  }

  return var_7;
}

function bot_validate_perk(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_4 - var_3 + 1;

  if(isDefined(var_5)) {
    var_6 = var_5;
  }

  var_7 = 0;
  var_8 = int(getsubstr(var_1, 11));

  if(var_0 == "specialty_twoprimaries") {
    return false;
  }

  if(var_0 == "specialty_extra_attachment") {
    return false;
  }

  if(!bot_loadout_item_allowed("perk", var_0)) {
    return false;
  }

  for(var_9 = var_8 - 1; var_9 > 0; var_9--) {
    var_10 = "loadoutPerk" + var_9;

    if(var_2[var_10] == "none" || var_2[var_10] == "specialty_null") {
      continue;
    }

    if(var_0 == var_2[var_10]) {
      return false;
    }

    if(var_9 >= var_3 && var_9 <= var_4) {
      var_7 += bot_perk_cost(var_2[var_10]);
    }
  }

  if(var_7 + bot_perk_cost(var_0) > var_6) {
    return false;
  }

  return true;
}

function bot_loadout_choose_from_default_class(var_0, var_1) {
  var_2 = int(getsubstr(var_0, 5, 6)) - 1;

  switch (var_1) {
    case "loadoutPrimary":
      return scripts\mp\class::table_getweapon(level.classtablename, var_2, 0);
    case "loadoutPrimaryAttachment":
      return scripts\mp\class::table_getweaponattachment(level.classtablename, var_2, 0, 0);
    case "loadoutPrimaryAttachment2":
      return scripts\mp\class::table_getweaponattachment(level.classtablename, var_2, 0, 1);
    case "loadoutPrimaryCamo":
      return scripts\mp\class::table_getweaponcamo(level.classtablename, var_2, 0);
    case "loadoutPrimaryReticle":
      return scripts\mp\class::table_getweaponreticle(level.classtablename, var_2, 0);
    case "loadoutSecondary":
      return scripts\mp\class::table_getweapon(level.classtablename, var_2, 1);
    case "loadoutSecondaryAttachment":
      return scripts\mp\class::table_getweaponattachment(level.classtablename, var_2, 1, 0);
    case "loadoutSecondaryAttachment2":
      return scripts\mp\class::table_getweaponattachment(level.classtablename, var_2, 1, 1);
    case "loadoutSecondaryCamo":
      return scripts\mp\class::table_getweaponcamo(level.classtablename, var_2, 1);
    case "loadoutSecondaryReticle":
      return scripts\mp\class::table_getweaponreticle(level.classtablename, var_2, 1);
    case "loadoutEquipmentPrimary":
      return scripts\mp\class::table_getequipmentprimary(level.classtablename, var_2);
    case "loadoutEquipmentSecondary":
      return scripts\mp\class::table_getequipmentsecondary(level.classtablename, var_2);
    case "loadoutStreak1":
      return scripts\mp\class::table_getkillstreak(level.classtablename, var_2, 0);
    case "loadoutStreak2":
      return scripts\mp\class::table_getkillstreak(level.classtablename, var_2, 1);
    case "loadoutStreak3":
      return scripts\mp\class::table_getkillstreak(level.classtablename, var_2, 2);
    case "loadoutPerk6":
    case "loadoutPerk5":
    case "loadoutPerk4":
    case "loadoutPerk3":
    case "loadoutPerk2":
    case "loadoutPerk1":
      var_3 = int(getsubstr(var_1, 11));
      var_4 = scripts\mp\class::table_getperk(level.classtablename, var_2, var_3);

      if(var_4 == "") {
        return "specialty_null";
      }

      var_5 = int(getsubstr(var_4, 0, 1));
      var_6 = int(getsubstr(var_4, 1, 2));
      var_7 = tablelookupbyrow("mp/cacabilitytable.csv", var_5 + 1, var_6 + 3);
      return var_7;
  }

  return var_5;
}

function deactivate_track_timers(var_0, var_1) {
  var_2 = deactivate_trap_object();
  var_3 = scripts\mp\utility\game::getmatchrulesspecialclass(var_2, var_0);
  return var_3[var_1];
}

function init_bot_attachmenttable() {
  level.bot_attachmenttable = [];
  level.bot_attachment_reticle = [];
  var_0 = tablelookupgetnumrows("mp/attachmenttable.csv");

  for(var_1 = 1; var_1 < var_0; var_1++) {
    var_2 = tablelookupbyrow("mp/attachmenttable.csv", var_1, 5);
    var_3 = tablelookupbyrow("mp/attachmenttable.csv", var_1, 20);

    if(var_2 != "" && var_3 != "") {
      var_4 = tablelookupbyrow("mp/attachmenttable.csv", var_1, 11);

      if(var_4 == "TRUE") {
        level.bot_attachment_reticle[var_2] = 1;
      }

      var_5 = strtok(var_3, "| ");

      foreach(var_7 in var_5) {
        if(!isDefined(level.bot_attachmenttable[var_7])) {
          level.bot_attachmenttable[var_7] = [];
        }

        if(!scripts\engine\utility::array_contains(level.bot_attachmenttable[var_7], var_2)) {
          var_8 = level.bot_attachmenttable[var_7].size;
          level.bot_attachmenttable[var_7][var_8] = var_2;
        }
      }
    }
  }

  if(!isDefined(level.deactivate_gas_trap_cloud)) {
    level.deactivate_gas_trap_cloud = [];
    level.brjugg_watchoverheat = [];
    var_10 = str("mp/attachmentcombos.csv");
    var_11 = var_10[0];
    var_12 = var_10[1];
    var_10 = undefined;
    level.deactivate_gas_trap_cloud["default"] = var_11;
    level.brjugg_watchoverheat["default"] = var_12;
    var_13 = str("mp/attachmentcombos_s4.csv");
    var_11 = var_13[0];
    var_12 = var_13[1];
    var_13 = undefined;
    level.deactivate_gas_trap_cloud["s4"] = var_11;
    level.brjugg_watchoverheat["s4"] = var_12;
    return;
  }
}

function str(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = 0;

  for(;;) {
    var_3++;
    var_4 = tablelookupbyrow(var_0, 0, var_3);

    if(var_4 == "") {
      break;
    }

    var_5 = 0;

    for(;;) {
      var_5++;
      var_6 = tablelookupbyrow(var_0, var_5, 0);

      if(var_6 == "") {
        break;
      }

      if(var_6 == var_4) {
        if(tablelookupbyrow(var_0, var_5, var_3) != "no") {
          var_2 = 1;
        }

        continue;
      }

      if(tablelookupbyrow(var_0, var_5, var_3) == "no") {
        var_1[var_6] = 1;
      }
    }
  }

  return [var_1, var_2];
}

function damageskipburndownmedium(var_0) {
  if(isDefined(level.deactivate_gas_trap_cloud[var_0])) {
    return level.deactivate_gas_trap_cloud[var_0];
  }

  return level.deactivate_gas_trap_cloud["default"];
}

function damageshield_threshold(var_0) {
  if(isDefined(level.brjugg_watchoverheat[var_0])) {
    return level.brjugg_watchoverheat[var_0];
  }

  return level.brjugg_watchoverheat["default"];
}

function bot_loadout_choose_from_attachmenttable(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "none";

  if(!isDefined(level.bot_attachmenttable)) {
    return var_5;
  }

  if(!isDefined(level.bot_attachmenttable[var_4])) {
    return var_5;
  }

  var_5 = bot_loadout_choose_from_set(level.bot_attachmenttable[var_4], var_0, var_1, var_2);
  return var_5;
}

function init_bot_camotable() {
  var_0 = "mp/camotable.csv";
  level.bot_camotable = [];

  for(var_1 = 0;; var_1++) {
    var_2 = tablelookupbyrow(var_0, var_1, scripts\common\utility::getcamotablecolumnindex("camoasset"));

    if(!isDefined(var_2) || var_2 == "") {
      break;
    }

    var_3 = tablelookupbyrow(var_0, var_1, scripts\common\utility::getcamotablecolumnindex("bot_valid"));

    if(isDefined(var_3) && int(var_3)) {
      level.bot_camotable[level.bot_camotable.size] = var_2;
    }
  }
}

function bot_loadout_choose_from_camotable(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "none";
  return var_5;
}

function bot_loadout_perk_slots(var_0) {
  var_1 = 8;

  if(isDefined(var_0["loadoutPrimary"]) && var_0["loadoutPrimary"] == "none") {
    var_1 += 1;
  }

  if(isDefined(var_0["loadoutSecondary"]) && var_0["loadoutSecondary"] == "none") {
    var_1 += 1;
  }

  if(isDefined(var_0["loadoutEquipmentPrimary"]) && var_0["loadoutEquipmentPrimary"] == "none") {
    var_1 += 1;
  }

  if(isDefined(var_0["loadoutEquipmentSecondary"]) && var_0["loadoutEquipmentSecondary"] == "none") {
    var_1 += 1;
  }

  return var_1;
}

function bot_loadout_valid_choice(var_0, var_1, var_2, var_3) {
  var_4 = 1;

  switch (var_2) {
    case "loadoutArchetype":
      break;
    case "loadoutPrimary":
      var_4 = bot_loadout_item_allowed("weapon", var_3);
      break;
    case "loadoutEquipmentPrimary":
    case "loadoutEquipmentSecondary":
      var_4 = bot_loadout_item_allowed("equipment", var_3);
      break;
    case "loadoutPrimaryAttachment1":
      var_4 = bot_validate_weapon(var_1["loadoutPrimary"], var_3);
      break;
    case "loadoutPrimaryAttachment2":
      var_4 = bot_validate_weapon(var_1["loadoutPrimary"], var_1["loadoutPrimaryAttachment1"], var_3);
      break;
    case "loadoutPrimaryAttachment3":
      var_4 = bot_validate_weapon(var_1["loadoutPrimary"], var_1["loadoutPrimaryAttachment1"], var_1["loadoutPrimaryAttachment2"], var_3);
      break;
    case "loadoutPrimaryAttachment4":
      var_4 = bot_validate_weapon(var_1["loadoutPrimary"], var_1["loadoutPrimaryAttachment1"], var_1["loadoutPrimaryAttachment2"], var_1["loadoutPrimaryAttachment3"], var_3);
      break;
    case "loadoutPrimaryAttachment5":
      var_4 = bot_validate_weapon(var_1["loadoutPrimary"], var_1["loadoutPrimaryAttachment1"], var_1["loadoutPrimaryAttachment2"], var_1["loadoutPrimaryAttachment3"], var_1["loadoutPrimaryAttachment4"], var_3);
      break;
    case "loadoutPrimaryAttachment6":
      var_4 = bot_validate_weapon(var_1["loadoutPrimary"], var_1["loadoutPrimaryAttachment1"], var_1["loadoutPrimaryAttachment2"], var_1["loadoutPrimaryAttachment3"], var_1["loadoutPrimaryAttachment4"], var_1["loadoutPrimaryAttachment5"], var_3);
      break;
    case "loadoutPrimaryReticle":
      var_4 = bot_validate_reticle("loadoutPrimary", var_1, var_3);
      break;
    case "loadoutPrimaryBuff":
      break;
    case "loadoutPrimaryCamo":
      var_4 = !isDefined(self.debug_gates) || var_3 == self.debug_gates;
      break;
    case "loadoutSecondary":
      var_4 = var_3 != var_1["loadoutPrimary"];
      var_4 = var_4 && bot_loadout_item_allowed("weapon", var_3, undefined);
      break;
    case "loadoutSecondaryAttachment1":
      var_4 = bot_validate_weapon(var_1["loadoutSecondary"], var_3);
      break;
    case "loadoutSecondaryAttachment2":
      var_4 = bot_validate_weapon(var_1["loadoutSecondary"], var_1["loadoutSecondaryAttachment1"], var_3);
      break;
    case "loadoutSecondaryAttachment3":
      var_4 = bot_validate_weapon(var_1["loadoutSecondary"], var_1["loadoutSecondaryAttachment1"], var_1["loadoutSecondaryAttachment2"], var_3);
      break;
    case "loadoutSecondaryAttachment4":
      var_4 = bot_validate_weapon(var_1["loadoutSecondary"], var_1["loadoutSecondaryAttachment1"], var_1["loadoutSecondaryAttachment2"], var_1["loadoutSecondaryAttachment3"], var_3);
      break;
    case "loadoutSecondaryAttachment5":
      var_4 = bot_validate_weapon(var_1["loadoutSecondary"], var_1["loadoutSecondaryAttachment1"], var_1["loadoutSecondaryAttachment2"], var_1["loadoutSecondaryAttachment3"], var_1["loadoutSecondaryAttachment4"], var_3);
      break;
    case "loadoutSecondaryAttachment6":
      var_4 = bot_validate_weapon(var_1["loadoutSecondary"], var_1["loadoutSecondaryAttachment1"], var_1["loadoutSecondaryAttachment2"], var_1["loadoutSecondaryAttachment3"], var_1["loadoutSecondaryAttachment4"], var_1["loadoutSecondaryAttachment5"], var_3);
      break;
    case "loadoutSecondaryReticle":
      var_4 = bot_validate_reticle("loadoutSecondary", var_1, var_3);
      break;
    case "loadoutSecondaryBuff":
      break;
    case "loadoutSecondaryCamo":
      var_4 = !isDefined(self.debug_hintadjustmentthink) || var_3 == self.debug_hintadjustmentthink;
      break;
    case "loadoutStreak2":
    case "loadoutStreak1":
    case "loadoutStreak3":
      var_4 = scripts\mp\bots\bots_killstreaks::bot_killstreak_is_valid_internal(var_3, "bots", undefined, var_1["loadoutStreakType"]);
      var_4 = var_4 && bot_loadout_item_allowed("killstreak", var_3, var_1["loadoutStreakType"]);
      break;
    case "loadoutStreakType":
      break;
    case "loadoutPerk11":
    case "loadoutPerk8":
    case "loadoutPerk9":
    case "loadoutPerk6":
    case "loadoutPerk5":
    case "loadoutPerk4":
    case "loadoutPerk3":
    case "loadoutPerk2":
    case "loadoutPerk1":
    case "loadoutPerk10":
    case "loadoutPerk12":
    case "loadoutPerk7":
      var_4 = bot_validate_perk(var_3, var_2, var_1, 1, 12, bot_loadout_perk_slots(var_1));
      break;
    case "loadoutPerk13":
    case "loadoutPerk14":
    case "loadoutPerk15":
      if(var_1["loadoutStreakType"] != "streaktype_specialist") {
        var_4 = 0;
      } else {
        var_4 = bot_validate_perk(var_3, var_2, var_1, -1, -1);
      }

      break;
    case "loadoutPerk22":
    case "loadoutPerk17":
    case "loadoutPerk23":
    case "loadoutPerk16":
    case "loadoutPerk18":
    case "loadoutPerk19":
    case "loadoutPerk20":
    case "loadoutPerk21":
      if(var_1["loadoutStreakType"] != "streaktype_specialist") {
        var_4 = 0;
      } else {
        var_4 = bot_validate_perk(var_3, var_2, var_1, 16, 23, 8);
      }

      break;
    default:
      break;
  }

  return var_4;
}

function bot_loadout_choose_from_set(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "none";
  var_6 = undefined;
  var_7 = 0;

  if(scripts\engine\utility::array_contains(var_0, "specialty_null")) {
    var_5 = "specialty_null";
  }

  if(var_1 == "classtable_any") {
    if(!isDefined(self.juggernaut_death_watcher)) {
      self.juggernaut_death_watcher = scripts\engine\utility::random(["class1", "class2", "class3", "class4", "class5"]);
    }

    var_0 = [self.juggernaut_death_watcher];
  }

  foreach(var_9 in var_0) {
    var_10 = undefined;

    if(getsubstr(var_9, 0, 9) == "template_") {
      var_10 = var_9;
      var_11 = level.botloadouttemplates[var_9][var_3];
      var_9 = bot_loadout_choose_from_set(strtok(var_11, "| "), var_1, var_2, var_3, 1);

      if(isDefined(var_10) && isDefined(self.chosentemplates[var_10])) {
        return var_9;
      }
    }

    if(var_9 == "attachmenttable") {
      return bot_loadout_choose_from_attachmenttable(var_1, var_2, var_3, self.personality, self.difficulty);
    }

    if(var_9 == "weap_statstable") {
      return bot_loadout_choose_from_statstable(var_1, var_2, var_3, self.botarchetype, self.personality, self.difficulty);
    }

    if(var_9 == "camotable") {
      return bot_loadout_choose_from_camotable(var_1, var_2, var_3, self.personality, self.difficulty);
    }

    if(getsubstr(var_9, 0, 5) == "class" && int(getsubstr(var_9, 5, 6)) > 0) {
      var_9 = bot_loadout_choose_from_default_class(var_9, var_3);
    }

    if(isDefined(level.bot_perktable) && getsubstr(var_9, 0, 10) == "perktable_") {
      return bot_loadout_choose_from_perktable(var_9, var_1, var_2, var_3, self.personality, self.difficulty);
    }

    if(bot_loadout_valid_choice(var_1, var_2, var_3, var_9)) {
      var_7 += 1;
      var_12 = randomfloat(1);

      if(var_12 < 1 / var_7) {
        var_5 = var_9;
        var_6 = var_10;
      }
    }
  }

  if(isDefined(var_6)) {
    self.chosentemplates[var_6] = 1;
  }

  return var_5;
}

function bot_loadout_choose_values(var_0) {
  self.chosentemplates = [];

  foreach(var_2 in var_0) {
    var_3 = undefined;

    if(!isDefined(var_3)) {
      var_5 = strtok(var_2, "| ");
      var_3 = bot_loadout_choose_from_set(var_5, var_2, var_0, var_6);
    }

    var_0 = var_3;
  }

  return var_0;
}

function bot_loadout_get_difficulty() {
  var_0 = self botgetdifficulty();

  if(var_0 == "default") {
    scripts\mp\bots\bots_util::bot_set_difficulty("default");
    var_0 = self botgetdifficulty();
  }

  return var_0;
}

function bot_loadout_get_archetype() {
  if(!isDefined(self.botarchetype)) {
    var_0 = self botgetpersonality();
    var_1 = level.botarchetypes[var_0];
    var_2 = randomint(var_1.size);
    self.botarchetype = var_1[var_2];
  }

  return self.botarchetype;
}

function dangercircleenthidefromplayers() {
  if(isDefined(self.pers["botCustomClasses"])) {
    return self.pers["botCustomClasses"];
  }

  return [];
}

function dangercircletick_carriable() {
  if(dangercircleenthidefromplayers().size > 0) {
    if(isDefined(self.pers["botLauncherClassIndex"])) {
      var_0 = self.pers["botLauncherClassIndex"];
      return self.pers["botCustomClasses"][var_0];
    }
  }

  return undefined;
}

function currentrewarddropindex() {
  if(istrue(self.deadyellow)) {
    return false;
  } else if(!isDefined(self.pers["botLastLoadout"])) {
    return false;
  } else if(istrue(self.respawn_with_launcher)) {
    return false;
  } else if(isDefined(self.hasdied) && !self.hasdied) {
    return false;
  }

  return true;
}

function bot_loadout_class_callback(var_0) {
  while(!isDefined(level.bot_loadouts_initialized)) {
    wait 0.05;
  }

  while(!isDefined(self.personality)) {
    wait 0.05;
  }

  var_1 = [];
  var_2 = bot_loadout_get_difficulty();
  self.difficulty = var_2;
  var_3 = self botgetpersonality();
  var_4 = bot_loadout_get_archetype();

  if(!isDefined(self.deactivate_stealth_settings)) {
    self.cypher_signal_strength_nag = 0;
  }

  self.deactivate_stealth_settings = self.cypher_signal_strength_nag;

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

  var_8 = !var_7 && currentrewarddropindex();

  if(var_8) {
    var_9 = 0.1;
    var_11 = randomfloat(1) >= var_9;

    if(var_11) {
      return self.pers["botLastLoadout"];
    }
  }

  self.deadyellow = undefined;

  if(!var_7) {
    var_12 = dangercircletick_carriable();
    var_13 = undefined;

    if(isDefined(self.respawn_with_launcher) && isDefined(var_12)) {
      self.respawn_with_launcher = undefined;
      self.deadyellow = 1;
      var_13 = var_12;
    }

    if(!isDefined(var_13)) {
      var_14 = dangercircleenthidefromplayers();
      var_15 = 0;

      if(isDefined(var_12)) {
        if(var_14.size < 5) {
          var_15 = 1;
        }
      } else if(isDefined(self.respawn_with_launcher)) {
        var_15 = 1;
      } else if(var_14.size < 4) {
        var_15 = 1;
      }

      if(!var_15) {
        var_13 = scripts\engine\utility::random(var_14);
      }
    }

    if(isDefined(var_13)) {
      self.cypher_signal_strength_nag++;
      self.pers["botLastLoadout"] = var_13;
      return var_13;
    }
  }

  var_16 = undefined;
  var_17 = cypher_vo_complete();

  if(var_17) {
    var_16 = bot_loadout_pick(var_4, var_3, var_2);
    var_1 = bot_loadout_choose_values(var_16);

    if(isDefined(level.bot_funcs["gametype_loadout_modify"])) {
      var_1 = self[[level.bot_funcs["gametype_loadout_modify"]]](var_1);
    }

    if(deactivategastrap(var_1)) {
      var_17 = 0;
    }
  }

  if(!var_17) {
    var_1 = damage_enemies_in_trigger();
    bot_pick_personality_from_weapon(var_1["loadoutPrimary"]);
  }

  if(var_1["loadoutPrimary"] == "none") {
    self.bot_fallback_personality = undefined;
    var_1 = bot_loadout_choose_fallback_primary(var_1);
    var_1 = "none";
    var_1 = "none";
    var_1 = "none";
    var_1 = "none";
    var_1 = "none";

    if(isDefined(self.bot_fallback_personality)) {
      if(self.bot_fallback_personality == "weapon") {
        bot_pick_personality_from_weapon(var_1["loadoutPrimary"]);
      } else {
        scripts\mp\bots\bots_util::bot_set_personality(self.bot_fallback_personality);
      }

      var_3 = self.personality;
      self.bot_fallback_personality = undefined;
    }
  }

  var_18 = isDefined(self.respawn_with_launcher);

  if(var_17 && scripts\mp\bots\bots_util::bot_israndom()) {
    if(isDefined(var_1["loadoutPrimaryCamo"]) && var_1["loadoutPrimaryCamo"] != "none" && !isDefined(self.debug_gates)) {
      self.debug_gates = var_1["loadoutPrimaryCamo"];
    }

    if(isDefined(var_1["loadoutSecondaryCamo"]) && var_1["loadoutSecondaryCamo"] != "none" && !isDefined(self.debug_hintadjustmentthink)) {
      self.debug_hintadjustmentthink = var_1["loadoutSecondaryCamo"];
    }

    if(var_18) {
      var_19 = level.bot_respawn_launcher_name[self botgetdifficulty()];

      if(bot_loadout_item_allowed("weapon", var_19, undefined)) {
        var_1 = level.bot_respawn_launcher_name;
        var_1 = "none";
        var_1 = "none";
        self.deadyellow = 1;
      }

      self.respawn_with_launcher = undefined;
    }
  }

  var_1 = bot_loadout_setup_perks(var_1);

  if(scripts\mp\bots\bots_util::bot_israndom()) {
    if(scripts\engine\utility::array_contains(self.pers["loadoutPerks"], "specialty_twoprimaries")) {
      var_20 = bot_loadout_pick("cqb", var_2);
      var_1 = var_20["loadoutPrimary"];
      var_1 = var_20["loadoutPrimaryAttachment"];
      var_1 = var_20["loadoutPrimaryAttachment2"];
      var_1 = bot_loadout_choose_values(var_1);
      var_1 = bot_loadout_setup_perks(var_1);
    }

    if(scripts\engine\utility::array_contains(self.pers["loadoutPerks"], "specialty_extra_attachment")) {
      var_21 = bot_loadout_pick(var_3, var_2);
      var_1 = var_21["loadoutPrimaryAttachment2"];

      if(scripts\engine\utility::array_contains(self.pers["loadoutPerks"], "specialty_twoprimaries")) {
        var_1 = var_21["loadoutPrimaryAttachment2"];
      } else {
        var_1 = var_21["loadoutSecondaryAttachment2"];
      }

      var_1 = bot_loadout_choose_values(var_1);
      var_1 = bot_loadout_setup_perks(var_1);
    } else {
      var_1 = "none";

      if(!bot_validate_reticle("loadoutSecondary", var_1, var_1["loadoutSecondaryReticle"])) {
        var_1 = "none";
      }
    }
  }

  self.cypher_signal_strength_nag++;
  self.pers["botLastLoadout"] = var_1;
  self.pers["botLastLoadoutDifficulty"] = var_2;
  self.pers["botLastLoadoutPersonality"] = var_3;

  if(!isDefined(self.pers["botCustomClasses"])) {
    self.pers["botCustomClasses"] = [];
  }

  var_22 = self.pers["botCustomClasses"].size;
  self.pers["botCustomClasses"][var_22] = var_1;

  if(var_18) {
    self.pers["botLauncherClassIndex"] = var_22;
  }

  return var_1;
}

function bot_loadout_setup_perks(var_0) {
  self.pers["loadoutPerks"] = [];
  self.pers["specialistBonusStreaks"] = [];
  self.pers["specialistStreaks"] = [];
  self.pers["specialistStreakKills"] = [];
  var_1 = 0;
  var_2 = isDefined(var_0["loadoutStreakType"]) && var_0["loadoutStreakType"] == "streaktype_specialist";

  if(var_2) {
    var_0 = "none";
    var_0 = "none";
    var_0 = "none";
  }

  foreach(var_4 in var_0) {
    if(var_4 == "specialty_null" || var_4 == "none") {
      continue;
    }

    if(getsubstr(var_8, 0, 11) == "loadoutPerk") {
      var_5 = int(getsubstr(var_8, 11));

      if(!var_2 && var_5 > 12) {
        continue;
      }

      var_6 = scripts\mp\utility\perk::getbaseperkname(var_4);

      if(var_5 <= 12) {
        self.pers["loadoutPerks"][self.pers["loadoutPerks"].size] = var_6;
      } else if(var_5 <= 15) {
        var_0 = var_6 + "_ks";
        self.pers["specialistStreaks"][self.pers["specialistStreaks"].size] = var_6 + "_ks";
        var_7 = 0;

        if(var_1 > 0) {
          var_7 = self.pers["specialistStreakKills"][self.pers["specialistStreakKills"].size - 1];
        }

        self.pers["specialistStreakKills"][self.pers["specialistStreakKills"].size] = var_7 + bot_perk_cost(var_6) + 2;
        var_1++;
      } else {
        self.pers["specialistBonusStreaks"][self.pers["specialistBonusStreaks"].size] = var_6;
      }
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

function deactivategastrap(var_0) {
  if(isusingmatchrulesdata()) {
    if(var_0["loadoutPrimary"] == "none") {
      return true;
    }
  }

  return false;
}

function bot_setup_loadout_callback() {
  var_0 = bot_loadout_get_archetype();
  var_1 = self botgetpersonality();
  var_2 = bot_loadout_get_difficulty();
  var_3 = bot_loadout_set(var_0, var_1, var_2, 0);

  if(isDefined(var_3) && isDefined(var_3.loadouts) && var_3.loadouts.size > 0) {
    self.classcallback = &bot_loadout_class_callback;
    return true;
  }

  var_4 = getsubstr(self.name, 0, self.name.size - 10);
  self.classcallback = undefined;
  return false;
}

function bot_loadout_make_index(var_0, var_1, var_2) {
  return var_0 + "_" + var_1 + "_" + var_2;
}

function deactive_trophy_protection() {}
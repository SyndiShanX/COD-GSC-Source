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
  var0 = "mp/botClassTable.csv";
  level.botloadoutsets = [];
  var1 = bot_loadout_fields();
  var2 = 0;

  for(;;) {
    var2++;
    var3 = tablelookup(var0, 0, "botArchetype", var2);
    var4 = tablelookup(var0, 0, "botPersonalities", var2);
    var5 = tablelookup(var0, 0, "botDifficulties", var2);

    if(!isDefined(var3) || var3 == "") {
      break;
    }

    if(!isDefined(var4) || var4 == "") {
      break;
    }

    if(!isDefined(var5) || var5 == "") {
      break;
    }

    var6 = [];

    foreach(var8 in var1) {
      var6 = tablelookup(var0, 0, var8, var2);
    }

    var10 = strtok(var3, "|");
    var11 = strtok(var4, "| ");
    var12 = strtok(var5, "| ");

    foreach(var14 in var10) {
      var14 = "archetype_" + var14;
      var6 = var14;

      foreach(var16 in var11) {
        foreach(var18 in var12) {
          var19 = bot_loadout_set(var14, var16, var18, 1);
          var20 = spawnStruct();
          var20.loadoutvalues = var6;
          var19.loadouts[var19.loadouts.size] = var20;
        }
      }
    }
  }
}

function init_template_table() {
  var0 = "mp/botTemplateTable.csv";
  level.botloadouttemplates = [];
  var1 = bot_loadout_fields();
  var2 = 0;

  for(;;) {
    var2++;
    var3 = tablelookup(var0, 0, "template_", var2);

    if(!isDefined(var3) || var3 == "") {
      break;
    }

    var4 = "template_" + var3;
    level.botloadouttemplates[var4] = [];

    foreach(var6 in var1) {
      var7 = tablelookup(var0, 0, var6, var2);

      if(isDefined(var7) && var7 != "") {
        level.botloadouttemplates[var4][var6] = var7;
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

function bot_loadout_item_allowed(var0, var1, var2) {
  if(!isusingmatchrulesdata() || true) {
    return true;
  }

  if(!cypher_vo_complete()) {
    return false;
  }

  if(var1 == "specialty_null") {
    return true;
  }

  if(var1 == "none") {
    return true;
  }

  if(var0 == "equipment") {
    if(getmatchrulesdata("commonOption", "perkRestricted", var1)) {
      return false;
    }

    var0 = "weapon";
  }

  var3 = var0 + "Restricted";
  var4 = var0 + "ClassRestricted";
  var5 = "";

  switch (var0) {
    case "weapon":
      var5 = scripts\mp\utility\weapon::getweapongroup(var1);
      break;
    case "attachment":
      var5 = scripts\mp\utility\weapon::getattachmenttype(var1);
      break;
    case "killstreak":
      var5 = var2;
      break;
    case "perk":
      var5 = "ability_" + level.bot_perktypes[var1];
      break;
    default:
      return false;
  }

  if(getmatchrulesdata("commonOption", var3, var1)) {
    return false;
  }

  if(var5 != "" && getmatchrulesdata("commonOption", var4, var5)) {
    return false;
  }

  return true;
}

function bot_loadout_choose_fallback_primary(var0) {
  var1 = "none";
  var2 = ["veteran", "hardened", "regular", "recruit"];
  var2 = scripts\engine\utility::array_randomize(var2);

  foreach(var4 in var2) {
    var1 = bot_loadout_choose_from_statstable("weap_statstable", var0, "loadoutPrimary", self.botarchetype, self.personality, var4);

    if(var1 != "none") {
      return var1;
    }
  }

  if(isDefined(level.bot_personality_list)) {
    var6 = scripts\engine\utility::array_randomize(level.bot_personality_list);

    foreach(var8 in var6) {
      foreach(var4 in var2) {
        var1 = bot_loadout_choose_from_statstable("weap_statstable", var0, "loadoutPrimary", var0["loadoutArchetype"], var8, var4);

        if(var1 != "none") {
          self.bot_fallback_personality = var8;
          return var1;
        }
      }
    }
  }

  if(isusingmatchrulesdata()) {
    var12 = 0;
    var13 = 0;
    var14 = "none";

    while(var13 < 6 && (!isDefined(var1) || var1 == "none" || var1 == "")) {
      if(scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", deactivate_trap_object(), var13, "class", "inUse")) {
        var1 = deactivate_track_timers(var13, "loadoutPrimary");

        if(var1 != "none") {
          var12 += 1;

          if(randomfloat(1) >= 1 / var12) {
            var14 = var1;
          }
        }
      }

      var13++;
    }

    if(var14 != "none") {
      self.bot_fallback_personality = "weapon";
      return var14;
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
  var0 = ["class1", "class2", "class3", "class4", "class5"];

  if(isusingmatchrulesdata()) {
    for(var1 = 0; var1 < var0.size; var1++) {
      if(scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", deactivate_trap_object(), var1, "class", "inUse")) {
        var0 = var1;
      }
    }
  }

  var2 = scripts\engine\utility::random(var0);
  var3 = [];

  foreach(var5 in level.bot_loadout_fields) {
    if(isstring(var2)) {
      var3 = bot_loadout_choose_from_default_class(var2, var5);
      continue;
    }

    var3 = deactivate_track_timers(var2, var5);
  }

  return var3;
}

function bot_pick_personality_from_weapon(var0) {
  if(isDefined(var0)) {
    var1 = level.bot_weap_personality[var0];

    if(isDefined(var1)) {
      var2 = strtok(var1, "| ");

      if(var2.size > 0) {
        scripts\mp\bots\bots_util::bot_set_personality(scripts\engine\utility::random(var2));
        return;
      }

      return;
    }

    return;
  }
}

function bot_loadout_fields() {
  var0 = "mp/botClassTable.csv";

  if(!isDefined(level.bot_loadout_fields)) {
    level.bot_loadout_fields = [];

    for(var1 = 3;; var1++) {
      var2 = tablelookupbyrow(var0, var1, 0);

      if(var2 == "") {
        break;
      }

      level.bot_loadout_fields[level.bot_loadout_fields.size] = var2;
    }
  }

  return level.bot_loadout_fields;
}

function bot_loadout_set(var0, var1, var2, var3) {
  var4 = bot_loadout_make_index(var0, var1, var2);

  if(!isDefined(level.botloadoutsets)) {
    level.botloadoutsets = [];
  }

  if(!isDefined(level.botloadoutsets[var4]) && var3) {
    level.botloadoutsets[var4] = spawnStruct();
    level.botloadoutsets[var4].loadouts = [];
  }

  if(isDefined(level.botloadoutsets[var4])) {
    return level.botloadoutsets[var4];
  }
}

function bot_loadout_pick(var0, var1, var2) {
  var3 = bot_loadout_set(var0, var1, var2, 0);

  if(isDefined(var3) && isDefined(var3.loadouts) && var3.loadouts.size > 0) {
    var4 = randomint(var3.loadouts.size);
    return var3.loadouts[var4].loadoutvalues;
  }
}

function bot_validate_weapon(var0, var1, var2, var3, var4, var5, var6) {
  var7 = [];

  if(isDefined(var1) && var1 != "none") {
    GscBinSkip0(0x2e, var7.size, var1);
  }

  if(isDefined(var2) && var2 != "none") {
    GscBinSkip0(0x2e, var7.size, var2);
  }

  if(isDefined(var3) && var3 != "none") {
    GscBinSkip0(0x2e, var7.size, var3);
  }

  if(isDefined(var4) && var4 != "none") {
    GscBinSkip0(0x2e, var7.size, var4);
  }

  if(isDefined(var5) && var5 != "none") {
    GscBinSkip0(0x2e, var7.size, var5);
  }

  if(isDefined(var6) && var6 != "none") {
    GscBinSkip0(0x2e, var7.size, var6);
  }

  var8 = scripts\mp\utility\weapon::register_wave_spawner(var0);
  var9 = scripts\mp\weapons::safechecknum(var0);
  var10 = damageskipburndownmedium(var9);
  var11 = damageshield_threshold(var9);

  for(var12 = 0; var12 < var7.size; var12++) {
    if(!bot_loadout_item_allowed("attachment", var7[var12], undefined)) {
      return false;
    }

    if(!scripts\engine\utility::array_contains(var8, var7[var12])) {
      return false;
    }

    var13 = 0;

    for(var14 = var12 - 1; var14 >= 0; var14--) {
      if(var7[var12] == var7[var14]) {
        var13++;

        if(var13 == 1) {
          if(!isDefined(var11[var7[var12]])) {
            return false;
          }
        } else if(var13 > 1) {
          return false;
        }

        continue;
      }

      if(isDefined(var10[var7[var12]])) {
        if(isDefined(var10[var7[var12]][var7[var14]])) {
          return false;
        }
      }
    }
  }

  return true;
}

function bot_validate_reticle(var0, var1, var2) {
  if(isDefined(var1[var0 + "Attachment"]) && isDefined(level.bot_attachment_reticle[var1[var0 + "Attachment"]])) {
    return true;
  }

  if(isDefined(var1[var0 + "Attachment2"]) && isDefined(level.bot_attachment_reticle[var1[var0 + "Attachment2"]])) {
    return true;
  }

  if(isDefined(var1[var0 + "Attachment3"]) && isDefined(level.bot_attachment_reticle[var1[var0 + "Attachment3"]])) {
    return true;
  }

  return false;
}

function bot_perk_cost(var0) {
  return level.perktable_costs[var0];
}

function perktable_add(var0, var1) {
  if(bot_perk_cost(var0) > 0) {
    var2 = [];
    GscBinSkip0(0x2e, "type", var1);
  }
}

function init_perktable() {
  level.perktable_costs = [];

  for(var0 = 1;; var0++) {
    var1 = tablelookupbyrow("mp/perktable.csv", var0, 1);

    if(var1 == "") {
      break;
    }

    level.perktable_costs[var1] = int(tablelookupbyrow("mp/perktable.csv", var0, 10));
  }

  level.perktable_costs["none"] = 0;
  level.perktable_costs["specialty_null"] = 0;
  level.bot_perktable = [];
  level.bot_perktypes = [];
  var0 = 1;

  for(var2 = "ability_null"; isDefined(var2) && var2 != ""; var2 = tablelookupbyrow("mp/cacabilitytable.csv", var0, 1)) {
    var2 = getsubstr(var2, 8);

    for(var3 = 4; var3 <= 13; var3++) {
      var1 = tablelookupbyrow("mp/cacabilitytable.csv", var0, var3);

      if(var1 != "") {
        perktable_add(var1, var2);
      }
    }

    var0++;
  }
}

function init_bot_weap_statstable() {
  level.bot_weap_statstable = [];
  level.bot_weap_personality = [];

  for(var0 = 0;; var0++) {
    var1 = tablelookupbyrow("mp/statstable.csv", var0, 0);

    if(var1 == "") {
      break;
    }

    var2 = tablelookupbyrow("mp/statstable.csv", var0, 4);
    var3 = tablelookupbyrow("mp/statstable.csv", var0, 38);
    var4 = tablelookupbyrow("mp/statstable.csv", var0, 40);
    var5 = tablelookupbyrow("mp/statstable.csv", var0, 39);

    if(var4 != "" && var2 != "" && var5 != "" && var3 != "") {
      if(!scripts\mp\weapons::vehicle_ai_avoidance_cleanup(var2)) {
        var0++;
        continue;
      }

      var6 = "loadoutPrimary";

      if(scripts\mp\utility\weapon::iscacsecondaryweapon(var2)) {
        var6 = "loadoutSecondary";
      } else if(!scripts\mp\utility\weapon::iscacprimaryweapon(var2)) {
        var0++;
        continue;
      }

      level.bot_weap_personality[var2] = var5;

      if(!isDefined(level.bot_weap_statstable[var6])) {
        level.bot_weap_statstable[var6] = [];
      }

      var7 = strtok(var3, "|");
      var8 = strtok(var5, "| ");
      var9 = strtok(var4, "| ");

      foreach(var11 in var7) {
        var11 = "archetype_" + var11;

        foreach(var13 in var8) {
          foreach(var15 in var9) {
            var16 = bot_loadout_make_index(var11, var13, var15);

            if(!isDefined(level.bot_weap_statstable[var6][var16])) {
              level.bot_weap_statstable[var6][var16] = [];
            }

            var17 = level.bot_weap_statstable[var6][var16].size;
            level.bot_weap_statstable[var6][var16][var17] = var2;
          }
        }
      }
    }
  }
}

function bot_loadout_choose_from_statstable(var0, var1, var2, var3, var4, var5) {
  var6 = "none";

  if(var2 == "loadoutSecondary" && scripts\engine\utility::array_contains(var1, "specialty_twoprimaries")) {
    var2 = "loadoutPrimary";
  }

  if(!isDefined(level.bot_weap_statstable)) {
    return var6;
  }

  if(!isDefined(level.bot_weap_statstable[var2])) {
    return var6;
  }

  var7 = bot_loadout_make_index(var3, var4, var5);

  if(!isDefined(level.bot_weap_statstable[var2][var7])) {
    return var6;
  }

  var6 = bot_loadout_choose_from_set(level.bot_weap_statstable[var2][var7], var0, var1, var2);
  return var6;
}

function bot_loadout_choose_from_perktable(var0, var1, var2, var3, var4, var5) {
  var6 = "specialty_null";

  if(!isDefined(level.bot_perktable)) {
    return var6;
  }

  if(!isDefined(level.bot_perktable_groups)) {
    level.bot_perktable_groups = [];
  }

  if(!isDefined(level.bot_perktable_groups[var0])) {
    var7 = strtok(var0, "_");
    GscBinSkip0(0x2e, 0, "");
  }

  if(level.bot_perktable_groups[var1].size > 0) {
    var7 = bot_loadout_choose_from_set(level.bot_perktable_groups[var1], var2, var3, var4);
  }

  return var7;
}

function bot_validate_perk(var0, var1, var2, var3, var4, var5) {
  var6 = var4 - var3 + 1;

  if(isDefined(var5)) {
    var6 = var5;
  }

  var7 = 0;
  var8 = int(getsubstr(var1, 11));

  if(var0 == "specialty_twoprimaries") {
    return false;
  }

  if(var0 == "specialty_extra_attachment") {
    return false;
  }

  if(!bot_loadout_item_allowed("perk", var0)) {
    return false;
  }

  for(var9 = var8 - 1; var9 > 0; var9--) {
    var10 = "loadoutPerk" + var9;

    if(var2[var10] == "none" || var2[var10] == "specialty_null") {
      continue;
    }

    if(var0 == var2[var10]) {
      return false;
    }

    if(var9 >= var3 && var9 <= var4) {
      var7 += bot_perk_cost(var2[var10]);
    }
  }

  if(var7 + bot_perk_cost(var0) > var6) {
    return false;
  }

  return true;
}

function bot_loadout_choose_from_default_class(var0, var1) {
  var2 = int(getsubstr(var0, 5, 6)) - 1;

  switch (var1) {
    case "loadoutPrimary":
      return scripts\mp\class::table_getweapon(level.classtablename, var2, 0);
    case "loadoutPrimaryAttachment":
      return scripts\mp\class::table_getweaponattachment(level.classtablename, var2, 0, 0);
    case "loadoutPrimaryAttachment2":
      return scripts\mp\class::table_getweaponattachment(level.classtablename, var2, 0, 1);
    case "loadoutPrimaryCamo":
      return scripts\mp\class::table_getweaponcamo(level.classtablename, var2, 0);
    case "loadoutPrimaryReticle":
      return scripts\mp\class::table_getweaponreticle(level.classtablename, var2, 0);
    case "loadoutSecondary":
      return scripts\mp\class::table_getweapon(level.classtablename, var2, 1);
    case "loadoutSecondaryAttachment":
      return scripts\mp\class::table_getweaponattachment(level.classtablename, var2, 1, 0);
    case "loadoutSecondaryAttachment2":
      return scripts\mp\class::table_getweaponattachment(level.classtablename, var2, 1, 1);
    case "loadoutSecondaryCamo":
      return scripts\mp\class::table_getweaponcamo(level.classtablename, var2, 1);
    case "loadoutSecondaryReticle":
      return scripts\mp\class::table_getweaponreticle(level.classtablename, var2, 1);
    case "loadoutEquipmentPrimary":
      return scripts\mp\class::table_getequipmentprimary(level.classtablename, var2);
    case "loadoutEquipmentSecondary":
      return scripts\mp\class::table_getequipmentsecondary(level.classtablename, var2);
    case "loadoutStreak1":
      return scripts\mp\class::table_getkillstreak(level.classtablename, var2, 0);
    case "loadoutStreak2":
      return scripts\mp\class::table_getkillstreak(level.classtablename, var2, 1);
    case "loadoutStreak3":
      return scripts\mp\class::table_getkillstreak(level.classtablename, var2, 2);
    case "loadoutPerk6":
    case "loadoutPerk5":
    case "loadoutPerk4":
    case "loadoutPerk3":
    case "loadoutPerk2":
    case "loadoutPerk1":
      var3 = int(getsubstr(var1, 11));
      var4 = scripts\mp\class::table_getperk(level.classtablename, var2, var3);

      if(var4 == "") {
        return "specialty_null";
      }

      var5 = int(getsubstr(var4, 0, 1));
      var6 = int(getsubstr(var4, 1, 2));
      var7 = tablelookupbyrow("mp/cacabilitytable.csv", var5 + 1, var6 + 3);
      return var7;
  }

  return var5;
}

function deactivate_track_timers(var0, var1) {
  var2 = deactivate_trap_object();
  var3 = scripts\mp\utility\game::getmatchrulesspecialclass(var2, var0);
  return var3[var1];
}

function init_bot_attachmenttable() {
  level.bot_attachmenttable = [];
  level.bot_attachment_reticle = [];
  var0 = tablelookupgetnumrows("mp/attachmenttable.csv");

  for(var1 = 1; var1 < var0; var1++) {
    var2 = tablelookupbyrow("mp/attachmenttable.csv", var1, 5);
    var3 = tablelookupbyrow("mp/attachmenttable.csv", var1, 20);

    if(var2 != "" && var3 != "") {
      var4 = tablelookupbyrow("mp/attachmenttable.csv", var1, 11);

      if(var4 == "TRUE") {
        level.bot_attachment_reticle[var2] = 1;
      }

      var5 = strtok(var3, "| ");

      foreach(var7 in var5) {
        if(!isDefined(level.bot_attachmenttable[var7])) {
          level.bot_attachmenttable[var7] = [];
        }

        if(!scripts\engine\utility::array_contains(level.bot_attachmenttable[var7], var2)) {
          var8 = level.bot_attachmenttable[var7].size;
          level.bot_attachmenttable[var7][var8] = var2;
        }
      }
    }
  }

  if(!isDefined(level.deactivate_gas_trap_cloud)) {
    level.deactivate_gas_trap_cloud = [];
    level.brjugg_watchoverheat = [];
    var10 = str("mp/attachmentcombos.csv");
    var11 = var10[0];
    var12 = var10[1];
    var10 = undefined;
    level.deactivate_gas_trap_cloud["default"] = var11;
    level.brjugg_watchoverheat["default"] = var12;
    var13 = str("mp/attachmentcombos_s4.csv");
    var11 = var13[0];
    var12 = var13[1];
    var13 = undefined;
    level.deactivate_gas_trap_cloud["s4"] = var11;
    level.brjugg_watchoverheat["s4"] = var12;
    return;
  }
}

function str(var0) {
  var1 = [];
  var2 = [];
  var3 = 0;

  for(;;) {
    var3++;
    var4 = tablelookupbyrow(var0, 0, var3);

    if(var4 == "") {
      break;
    }

    var5 = 0;

    for(;;) {
      var5++;
      var6 = tablelookupbyrow(var0, var5, 0);

      if(var6 == "") {
        break;
      }

      if(var6 == var4) {
        if(tablelookupbyrow(var0, var5, var3) != "no") {
          var2 = 1;
        }

        continue;
      }

      if(tablelookupbyrow(var0, var5, var3) == "no") {
        var1[var6] = 1;
      }
    }
  }

  return [var1, var2];
}

function damageskipburndownmedium(var0) {
  if(isDefined(level.deactivate_gas_trap_cloud[var0])) {
    return level.deactivate_gas_trap_cloud[var0];
  }

  return level.deactivate_gas_trap_cloud["default"];
}

function damageshield_threshold(var0) {
  if(isDefined(level.brjugg_watchoverheat[var0])) {
    return level.brjugg_watchoverheat[var0];
  }

  return level.brjugg_watchoverheat["default"];
}

function bot_loadout_choose_from_attachmenttable(var0, var1, var2, var3, var4) {
  var5 = "none";

  if(!isDefined(level.bot_attachmenttable)) {
    return var5;
  }

  if(!isDefined(level.bot_attachmenttable[var4])) {
    return var5;
  }

  var5 = bot_loadout_choose_from_set(level.bot_attachmenttable[var4], var0, var1, var2);
  return var5;
}

function init_bot_camotable() {
  var0 = "mp/camotable.csv";
  level.bot_camotable = [];

  for(var1 = 0;; var1++) {
    var2 = tablelookupbyrow(var0, var1, scripts\common\utility::getcamotablecolumnindex("camoasset"));

    if(!isDefined(var2) || var2 == "") {
      break;
    }

    var3 = tablelookupbyrow(var0, var1, scripts\common\utility::getcamotablecolumnindex("bot_valid"));

    if(isDefined(var3) && int(var3)) {
      level.bot_camotable[level.bot_camotable.size] = var2;
    }
  }
}

function bot_loadout_choose_from_camotable(var0, var1, var2, var3, var4) {
  var5 = "none";
  return var5;
}

function bot_loadout_perk_slots(var0) {
  var1 = 8;

  if(isDefined(var0["loadoutPrimary"]) && var0["loadoutPrimary"] == "none") {
    var1 += 1;
  }

  if(isDefined(var0["loadoutSecondary"]) && var0["loadoutSecondary"] == "none") {
    var1 += 1;
  }

  if(isDefined(var0["loadoutEquipmentPrimary"]) && var0["loadoutEquipmentPrimary"] == "none") {
    var1 += 1;
  }

  if(isDefined(var0["loadoutEquipmentSecondary"]) && var0["loadoutEquipmentSecondary"] == "none") {
    var1 += 1;
  }

  return var1;
}

function bot_loadout_valid_choice(var0, var1, var2, var3) {
  var4 = 1;

  switch (var2) {
    case "loadoutArchetype":
      break;
    case "loadoutPrimary":
      var4 = bot_loadout_item_allowed("weapon", var3);
      break;
    case "loadoutEquipmentPrimary":
    case "loadoutEquipmentSecondary":
      var4 = bot_loadout_item_allowed("equipment", var3);
      break;
    case "loadoutPrimaryAttachment1":
      var4 = bot_validate_weapon(var1["loadoutPrimary"], var3);
      break;
    case "loadoutPrimaryAttachment2":
      var4 = bot_validate_weapon(var1["loadoutPrimary"], var1["loadoutPrimaryAttachment1"], var3);
      break;
    case "loadoutPrimaryAttachment3":
      var4 = bot_validate_weapon(var1["loadoutPrimary"], var1["loadoutPrimaryAttachment1"], var1["loadoutPrimaryAttachment2"], var3);
      break;
    case "loadoutPrimaryAttachment4":
      var4 = bot_validate_weapon(var1["loadoutPrimary"], var1["loadoutPrimaryAttachment1"], var1["loadoutPrimaryAttachment2"], var1["loadoutPrimaryAttachment3"], var3);
      break;
    case "loadoutPrimaryAttachment5":
      var4 = bot_validate_weapon(var1["loadoutPrimary"], var1["loadoutPrimaryAttachment1"], var1["loadoutPrimaryAttachment2"], var1["loadoutPrimaryAttachment3"], var1["loadoutPrimaryAttachment4"], var3);
      break;
    case "loadoutPrimaryAttachment6":
      var4 = bot_validate_weapon(var1["loadoutPrimary"], var1["loadoutPrimaryAttachment1"], var1["loadoutPrimaryAttachment2"], var1["loadoutPrimaryAttachment3"], var1["loadoutPrimaryAttachment4"], var1["loadoutPrimaryAttachment5"], var3);
      break;
    case "loadoutPrimaryReticle":
      var4 = bot_validate_reticle("loadoutPrimary", var1, var3);
      break;
    case "loadoutPrimaryBuff":
      break;
    case "loadoutPrimaryCamo":
      var4 = !isDefined(self.debug_gates) || var3 == self.debug_gates;
      break;
    case "loadoutSecondary":
      var4 = var3 != var1["loadoutPrimary"];
      var4 = var4 && bot_loadout_item_allowed("weapon", var3, undefined);
      break;
    case "loadoutSecondaryAttachment1":
      var4 = bot_validate_weapon(var1["loadoutSecondary"], var3);
      break;
    case "loadoutSecondaryAttachment2":
      var4 = bot_validate_weapon(var1["loadoutSecondary"], var1["loadoutSecondaryAttachment1"], var3);
      break;
    case "loadoutSecondaryAttachment3":
      var4 = bot_validate_weapon(var1["loadoutSecondary"], var1["loadoutSecondaryAttachment1"], var1["loadoutSecondaryAttachment2"], var3);
      break;
    case "loadoutSecondaryAttachment4":
      var4 = bot_validate_weapon(var1["loadoutSecondary"], var1["loadoutSecondaryAttachment1"], var1["loadoutSecondaryAttachment2"], var1["loadoutSecondaryAttachment3"], var3);
      break;
    case "loadoutSecondaryAttachment5":
      var4 = bot_validate_weapon(var1["loadoutSecondary"], var1["loadoutSecondaryAttachment1"], var1["loadoutSecondaryAttachment2"], var1["loadoutSecondaryAttachment3"], var1["loadoutSecondaryAttachment4"], var3);
      break;
    case "loadoutSecondaryAttachment6":
      var4 = bot_validate_weapon(var1["loadoutSecondary"], var1["loadoutSecondaryAttachment1"], var1["loadoutSecondaryAttachment2"], var1["loadoutSecondaryAttachment3"], var1["loadoutSecondaryAttachment4"], var1["loadoutSecondaryAttachment5"], var3);
      break;
    case "loadoutSecondaryReticle":
      var4 = bot_validate_reticle("loadoutSecondary", var1, var3);
      break;
    case "loadoutSecondaryBuff":
      break;
    case "loadoutSecondaryCamo":
      var4 = !isDefined(self.debug_hintadjustmentthink) || var3 == self.debug_hintadjustmentthink;
      break;
    case "loadoutStreak2":
    case "loadoutStreak1":
    case "loadoutStreak3":
      var4 = scripts\mp\bots\bots_killstreaks::bot_killstreak_is_valid_internal(var3, "bots", undefined, var1["loadoutStreakType"]);
      var4 = var4 && bot_loadout_item_allowed("killstreak", var3, var1["loadoutStreakType"]);
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
      var4 = bot_validate_perk(var3, var2, var1, 1, 12, bot_loadout_perk_slots(var1));
      break;
    case "loadoutPerk13":
    case "loadoutPerk14":
    case "loadoutPerk15":
      if(var1["loadoutStreakType"] != "streaktype_specialist") {
        var4 = 0;
      } else {
        var4 = bot_validate_perk(var3, var2, var1, -1, -1);
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
      if(var1["loadoutStreakType"] != "streaktype_specialist") {
        var4 = 0;
      } else {
        var4 = bot_validate_perk(var3, var2, var1, 16, 23, 8);
      }

      break;
    default:
      break;
  }

  return var4;
}

function bot_loadout_choose_from_set(var0, var1, var2, var3, var4) {
  var5 = "none";
  var6 = undefined;
  var7 = 0;

  if(scripts\engine\utility::array_contains(var0, "specialty_null")) {
    var5 = "specialty_null";
  }

  if(var1 == "classtable_any") {
    if(!isDefined(self.juggernaut_death_watcher)) {
      self.juggernaut_death_watcher = scripts\engine\utility::random(["class1", "class2", "class3", "class4", "class5"]);
    }

    var0 = [self.juggernaut_death_watcher];
  }

  foreach(var9 in var0) {
    var10 = undefined;

    if(getsubstr(var9, 0, 9) == "template_") {
      var10 = var9;
      var11 = level.botloadouttemplates[var9][var3];
      var9 = bot_loadout_choose_from_set(strtok(var11, "| "), var1, var2, var3, 1);

      if(isDefined(var10) && isDefined(self.chosentemplates[var10])) {
        return var9;
      }
    }

    if(var9 == "attachmenttable") {
      return bot_loadout_choose_from_attachmenttable(var1, var2, var3, self.personality, self.difficulty);
    }

    if(var9 == "weap_statstable") {
      return bot_loadout_choose_from_statstable(var1, var2, var3, self.botarchetype, self.personality, self.difficulty);
    }

    if(var9 == "camotable") {
      return bot_loadout_choose_from_camotable(var1, var2, var3, self.personality, self.difficulty);
    }

    if(getsubstr(var9, 0, 5) == "class" && int(getsubstr(var9, 5, 6)) > 0) {
      var9 = bot_loadout_choose_from_default_class(var9, var3);
    }

    if(isDefined(level.bot_perktable) && getsubstr(var9, 0, 10) == "perktable_") {
      return bot_loadout_choose_from_perktable(var9, var1, var2, var3, self.personality, self.difficulty);
    }

    if(bot_loadout_valid_choice(var1, var2, var3, var9)) {
      var7 += 1;
      var12 = randomfloat(1);

      if(var12 < 1 / var7) {
        var5 = var9;
        var6 = var10;
      }
    }
  }

  if(isDefined(var6)) {
    self.chosentemplates[var6] = 1;
  }

  return var5;
}

function bot_loadout_choose_values(var0) {
  self.chosentemplates = [];

  foreach(var2 in var0) {
    var3 = undefined;

    if(!isDefined(var3)) {
      var5 = strtok(var2, "| ");
      var3 = bot_loadout_choose_from_set(var5, var2, var0, var6);
    }

    var0 = var3;
  }

  return var0;
}

function bot_loadout_get_difficulty() {
  var0 = self botgetdifficulty();

  if(var0 == "default") {
    scripts\mp\bots\bots_util::bot_set_difficulty("default");
    var0 = self botgetdifficulty();
  }

  return var0;
}

function bot_loadout_get_archetype() {
  if(!isDefined(self.botarchetype)) {
    var0 = self botgetpersonality();
    var1 = level.botarchetypes[var0];
    var2 = randomint(var1.size);
    self.botarchetype = var1[var2];
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
      var0 = self.pers["botLauncherClassIndex"];
      return self.pers["botCustomClasses"][var0];
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

function bot_loadout_class_callback(var0) {
  while(!isDefined(level.bot_loadouts_initialized)) {
    wait 0.05;
  }

  while(!isDefined(self.personality)) {
    wait 0.05;
  }

  var1 = [];
  var2 = bot_loadout_get_difficulty();
  self.difficulty = var2;
  var3 = self botgetpersonality();
  var4 = bot_loadout_get_archetype();

  if(!isDefined(self.deactivate_stealth_settings)) {
    self.cypher_signal_strength_nag = 0;
  }

  self.deactivate_stealth_settings = self.cypher_signal_strength_nag;

  if(isDefined(self.pers["botLastLoadout"]) && istrue(var0)) {
    return self.pers["botLastLoadout"];
  }

  var5 = !isDefined(self.pers["botLastLoadoutDifficulty"]) || self.pers["botLastLoadoutDifficulty"] == var2;
  var6 = !isDefined(self.pers["botLastLoadoutPersonality"]) || self.pers["botLastLoadoutPersonality"] == var3;
  var7 = 0;

  if(!var5 || !var6) {
    self.pers["botLastLoadout"] = undefined;
    self.pers["botCustomClasses"] = undefined;
    self.pers["botLauncherClassIndex"] = undefined;
    var7 = 1;
  }

  var8 = !var7 && currentrewarddropindex();

  if(var8) {
    var9 = 0.1;
    var11 = randomfloat(1) >= var9;

    if(var11) {
      return self.pers["botLastLoadout"];
    }
  }

  self.deadyellow = undefined;

  if(!var7) {
    var12 = dangercircletick_carriable();
    var13 = undefined;

    if(isDefined(self.respawn_with_launcher) && isDefined(var12)) {
      self.respawn_with_launcher = undefined;
      self.deadyellow = 1;
      var13 = var12;
    }

    if(!isDefined(var13)) {
      var14 = dangercircleenthidefromplayers();
      var15 = 0;

      if(isDefined(var12)) {
        if(var14.size < 5) {
          var15 = 1;
        }
      } else if(isDefined(self.respawn_with_launcher)) {
        var15 = 1;
      } else if(var14.size < 4) {
        var15 = 1;
      }

      if(!var15) {
        var13 = scripts\engine\utility::random(var14);
      }
    }

    if(isDefined(var13)) {
      self.cypher_signal_strength_nag++;
      self.pers["botLastLoadout"] = var13;
      return var13;
    }
  }

  var16 = undefined;
  var17 = cypher_vo_complete();

  if(var17) {
    var16 = bot_loadout_pick(var4, var3, var2);
    var1 = bot_loadout_choose_values(var16);

    if(isDefined(level.bot_funcs["gametype_loadout_modify"])) {
      var1 = self[[level.bot_funcs["gametype_loadout_modify"]]](var1);
    }

    if(deactivategastrap(var1)) {
      var17 = 0;
    }
  }

  if(!var17) {
    var1 = damage_enemies_in_trigger();
    bot_pick_personality_from_weapon(var1["loadoutPrimary"]);
  }

  if(var1["loadoutPrimary"] == "none") {
    self.bot_fallback_personality = undefined;
    var1 = bot_loadout_choose_fallback_primary(var1);
    var1 = "none";
    var1 = "none";
    var1 = "none";
    var1 = "none";
    var1 = "none";

    if(isDefined(self.bot_fallback_personality)) {
      if(self.bot_fallback_personality == "weapon") {
        bot_pick_personality_from_weapon(var1["loadoutPrimary"]);
      } else {
        scripts\mp\bots\bots_util::bot_set_personality(self.bot_fallback_personality);
      }

      var3 = self.personality;
      self.bot_fallback_personality = undefined;
    }
  }

  var18 = isDefined(self.respawn_with_launcher);

  if(var17 && scripts\mp\bots\bots_util::bot_israndom()) {
    if(isDefined(var1["loadoutPrimaryCamo"]) && var1["loadoutPrimaryCamo"] != "none" && !isDefined(self.debug_gates)) {
      self.debug_gates = var1["loadoutPrimaryCamo"];
    }

    if(isDefined(var1["loadoutSecondaryCamo"]) && var1["loadoutSecondaryCamo"] != "none" && !isDefined(self.debug_hintadjustmentthink)) {
      self.debug_hintadjustmentthink = var1["loadoutSecondaryCamo"];
    }

    if(var18) {
      var19 = level.bot_respawn_launcher_name[self botgetdifficulty()];

      if(bot_loadout_item_allowed("weapon", var19, undefined)) {
        var1 = level.bot_respawn_launcher_name;
        var1 = "none";
        var1 = "none";
        self.deadyellow = 1;
      }

      self.respawn_with_launcher = undefined;
    }
  }

  var1 = bot_loadout_setup_perks(var1);

  if(scripts\mp\bots\bots_util::bot_israndom()) {
    if(scripts\engine\utility::array_contains(self.pers["loadoutPerks"], "specialty_twoprimaries")) {
      var20 = bot_loadout_pick("cqb", var2);
      var1 = var20["loadoutPrimary"];
      var1 = var20["loadoutPrimaryAttachment"];
      var1 = var20["loadoutPrimaryAttachment2"];
      var1 = bot_loadout_choose_values(var1);
      var1 = bot_loadout_setup_perks(var1);
    }

    if(scripts\engine\utility::array_contains(self.pers["loadoutPerks"], "specialty_extra_attachment")) {
      var21 = bot_loadout_pick(var3, var2);
      var1 = var21["loadoutPrimaryAttachment2"];

      if(scripts\engine\utility::array_contains(self.pers["loadoutPerks"], "specialty_twoprimaries")) {
        var1 = var21["loadoutPrimaryAttachment2"];
      } else {
        var1 = var21["loadoutSecondaryAttachment2"];
      }

      var1 = bot_loadout_choose_values(var1);
      var1 = bot_loadout_setup_perks(var1);
    } else {
      var1 = "none";

      if(!bot_validate_reticle("loadoutSecondary", var1, var1["loadoutSecondaryReticle"])) {
        var1 = "none";
      }
    }
  }

  self.cypher_signal_strength_nag++;
  self.pers["botLastLoadout"] = var1;
  self.pers["botLastLoadoutDifficulty"] = var2;
  self.pers["botLastLoadoutPersonality"] = var3;

  if(!isDefined(self.pers["botCustomClasses"])) {
    self.pers["botCustomClasses"] = [];
  }

  var22 = self.pers["botCustomClasses"].size;
  self.pers["botCustomClasses"][var22] = var1;

  if(var18) {
    self.pers["botLauncherClassIndex"] = var22;
  }

  return var1;
}

function bot_loadout_setup_perks(var0) {
  self.pers["loadoutPerks"] = [];
  self.pers["specialistBonusStreaks"] = [];
  self.pers["specialistStreaks"] = [];
  self.pers["specialistStreakKills"] = [];
  var1 = 0;
  var2 = isDefined(var0["loadoutStreakType"]) && var0["loadoutStreakType"] == "streaktype_specialist";

  if(var2) {
    var0 = "none";
    var0 = "none";
    var0 = "none";
  }

  foreach(var4 in var0) {
    if(var4 == "specialty_null" || var4 == "none") {
      continue;
    }

    if(getsubstr(var8, 0, 11) == "loadoutPerk") {
      var5 = int(getsubstr(var8, 11));

      if(!var2 && var5 > 12) {
        continue;
      }

      var6 = scripts\mp\utility\perk::getbaseperkname(var4);

      if(var5 <= 12) {
        self.pers["loadoutPerks"][self.pers["loadoutPerks"].size] = var6;
      } else if(var5 <= 15) {
        var0 = var6 + "_ks";
        self.pers["specialistStreaks"][self.pers["specialistStreaks"].size] = var6 + "_ks";
        var7 = 0;

        if(var1 > 0) {
          var7 = self.pers["specialistStreakKills"][self.pers["specialistStreakKills"].size - 1];
        }

        self.pers["specialistStreakKills"][self.pers["specialistStreakKills"].size] = var7 + bot_perk_cost(var6) + 2;
        var1++;
      } else {
        self.pers["specialistBonusStreaks"][self.pers["specialistBonusStreaks"].size] = var6;
      }
    }
  }

  if(var2 && !isDefined(self.pers["specialistStreakKills"][0])) {
    self.pers["specialistStreakKills"][0] = 0;
    self.pers["specialistStreaks"][0] = "specialty_null";
  }

  if(var2 && !isDefined(self.pers["specialistStreakKills"][1])) {
    self.pers["specialistStreakKills"][1] = self.pers["specialistStreakKills"][0];
    self.pers["specialistStreaks"][1] = "specialty_null";
  }

  if(var2 && !isDefined(self.pers["specialistStreakKills"][2])) {
    self.pers["specialistStreakKills"][2] = self.pers["specialistStreakKills"][1];
    self.pers["specialistStreaks"][2] = "specialty_null";
  }

  return var0;
}

function deactivategastrap(var0) {
  if(isusingmatchrulesdata()) {
    if(var0["loadoutPrimary"] == "none") {
      return true;
    }
  }

  return false;
}

function bot_setup_loadout_callback() {
  var0 = bot_loadout_get_archetype();
  var1 = self botgetpersonality();
  var2 = bot_loadout_get_difficulty();
  var3 = bot_loadout_set(var0, var1, var2, 0);

  if(isDefined(var3) && isDefined(var3.loadouts) && var3.loadouts.size > 0) {
    self.classcallback = &bot_loadout_class_callback;
    return true;
  }

  var4 = getsubstr(self.name, 0, self.name.size - 10);
  self.classcallback = undefined;
  return false;
}

function bot_loadout_make_index(var0, var1, var2) {
  return var0 + "_" + var1 + "_" + var2;
}

function deactive_trophy_protection() {}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_loadout.gsc
***********************************************/

init() {
  init_template_table();
  init_class_table();
  init_perktable();
  init_bot_attachmenttable();
  init_bot_weap_statstable();
  init_bot_camotable();
  init_bot_archetypes();
  level.bot_loadouts_initialized = 1;
}

init_class_table() {
  var_0 = "_encstr_9A44154823EDEDC0E37B09F72397EFB3E64AB0DA8A120D";
  level.botloadoutsets = [];
  var_1 = bot_loadout_fields();
  var_2 = 0;

  for(;;) {
    var_2++;
    var_3 = tablelookup(var_0, 0, "_encstr_83E70D453FC32718F38C312BF0C8E8", var_2);
    var_4 = tablelookup(var_0, 0, "_encstr_8EED1105AFA339057B9B4850823BCBD03C3DAF", var_2);
    var_5 = tablelookup(var_0, 0, "_encstr_844A1098DE3A444BCC3396B1EA631D2D956E", var_2);

    if(!isDefined(var_3) || var_3 == "_encstr_B40101") {
      break;
    }

    if(!isDefined(var_4) || var_4 == "_encstr_B40101") {
      break;
    }

    if(!isDefined(var_5) || var_5 == "_encstr_B40101") {
      break;
    }

    var_6 = [];

    foreach(var_8 in var_1)
    var_6[var_8] = tablelookup(var_0, 0, var_8, var_2);

    var_10 = strtok(var_3, "_encstr_854C021F");
    var_11 = strtok(var_4, "_encstr_AA07038F10");
    var_12 = strtok(var_5, "_encstr_AA07038F10");

    foreach(var_14 in var_10) {
      var_14 = "_encstr_842D0BD25E98A08515213A0597" + var_14;
      var_6["_encstr_AA2D1188DD6928B843CBA3CDBFBAF5F01972D1"] = var_14;

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

init_template_table() {
  var_0 = "_encstr_A7E11815973F31D7C46BFD03CFFC19A1F3A10B58A03FD818F86D";
  level.botloadouttemplates = [];
  var_1 = bot_loadout_fields();
  var_2 = 0;

  for(;;) {
    var_2++;
    var_3 = tablelookup(var_0, 0, "_encstr_9AC70A81A1A9E81BE170A9AE", var_2);

    if(!isDefined(var_3) || var_3 == "_encstr_B40101") {
      break;
    }

    var_4 = "_encstr_9AC70A81A1A9E81BE170A9AE" + var_3;
    level.botloadouttemplates[var_4] = [];

    foreach(var_6 in var_1) {
      var_7 = tablelookup(var_0, 0, var_6, var_2);

      if(isDefined(var_7) && var_7 != "_encstr_B40101")
        level.botloadouttemplates[var_4][var_6] = var_7;
    }
  }
}

init_bot_archetypes() {
  level.botarchetypes = [];
  level.botarchetypes["_encstr_931904C66102"] = ["_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D"];
  level.botarchetypes["_encstr_BD560C63E89DE9BFF81D7747ADC0"] = ["_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D"];
  level.botarchetypes["_encstr_B892078D2C5BE05927"] = ["_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D"];
  level.botarchetypes["_encstr_8B1608EC43B8D647A113"] = ["_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D"];
}

cypher_vo_complete() {
  return 1;
}

bot_loadout_item_allowed(var_0, var_1, var_2) {
  if(!isusingmatchrulesdata() || 1)
    return 1;

  if(!cypher_vo_complete())
    return 0;

  if(var_1 == "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249")
    return 1;

  if(var_1 == "_encstr_8BBA05185F8B99")
    return 1;

  if(var_0 == "_encstr_BE8F0A272F9B2BE97268AE8B") {
    if(getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_976D0F83ACC95B29B2CD8E4E5A6C3AB291", var_1))
      return 0;

    var_0 = "_encstr_AC20072B9FA9487832";
  }

  var_3 = var_0 + "_encstr_83E00BA4CA6ED1272DC68E5632";
  var_4 = var_0 + "_encstr_856F1086B10BDCE6A42BE647394BC647B291";
  var_5 = "_encstr_B40101";

  switch (var_0) {
    case "_encstr_AC20072B9FA9487832":
      var_5 = scripts\mp\utility\weapon::getweapongroup(var_1);
      break;
    case "_encstr_B19A0BD803A4E10F42E50598BB":
      var_5 = scripts\mp\utility\weapon::getattachmenttype(var_1);
      break;
    case "_encstr_85CE0B9770B02C73A1760F06D2":
      var_5 = var_2;
      break;
    case "_encstr_960D052F10EBF0":
      var_5 = "_encstr_83B00941F61910C33B6737" + level.bot_perktypes[var_1];
      break;
    default:
      return 0;
  }

  if(getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", var_3, var_1))
    return 0;

  if(var_5 != "_encstr_B40101" && getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", var_4, var_5))
    return 0;

  return 1;
}

bot_loadout_choose_fallback_primary(var_0) {
  var_1 = "_encstr_8BBA05185F8B99";
  var_2 = ["_encstr_BAAF081BD348D7E299C8", "_encstr_A7D409342C272359DC59C8", "_encstr_813008928DA89D31A8CA", "_encstr_889F0893CA6CC9BA2D8E"];
  var_2 = scripts\engine\utility::array_randomize(var_2);

  foreach(var_4 in var_2) {
    var_1 = bot_loadout_choose_from_statstable("_encstr_ADFB10335D33F3A793A08FC380AB511A91E5", var_0, "_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243", self.botarchetype, self.personality, var_4);

    if(var_1 != "_encstr_8BBA05185F8B99")
      return var_1;
  }

  if(isDefined(level.bot_personality_list)) {
    var_6 = scripts\engine\utility::array_randomize(level.bot_personality_list);

    foreach(var_8 in var_6) {
      foreach(var_4 in var_2) {
        var_1 = bot_loadout_choose_from_statstable("_encstr_ADFB10335D33F3A793A08FC380AB511A91E5", var_0, "_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243", var_0["_encstr_AA2D1188DD6928B843CBA3CDBFBAF5F01972D1"], var_8, var_4);

        if(var_1 != "_encstr_8BBA05185F8B99") {
          self.bot_fallback_personality = var_8;
          return var_1;
        }
      }
    }
  }

  if(isusingmatchrulesdata()) {
    var_12 = 0.0;
    var_13 = 0;

    for(var_14 = "_encstr_8BBA05185F8B99"; var_13 < 6 && (!isDefined(var_1) || var_1 == "_encstr_8BBA05185F8B99" || var_1 == "_encstr_B40101"); var_13++) {
      if(scripts\mp\utility\game::getmatchrulesdatawithteamandindex("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", deactivate_trap_object(), var_13, "_encstr_959506B911C79707", "_encstr_8C8F065F255DC395")) {
        var_1 = deactivate_track_timers(var_13, "_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243");

        if(var_1 != "_encstr_8BBA05185F8B99") {
          var_12 = var_12 + 1.0;

          if(randomfloat(1.0) >= 1.0 / var_12)
            var_14 = var_1;
        }
      }
    }

    if(var_14 != "_encstr_8BBA05185F8B99") {
      self.bot_fallback_personality = "_encstr_AC20072B9FA9487832";
      return var_14;
    }
  }

  self.bot_fallback_personality = "_encstr_AC20072B9FA9487832";
  return level.bot_fallback_weapon;
}

deactivate_trap_object() {
  if(!isDefined(level.teambased) || !level.teambased)
    return "_encstr_9A8507BA4040188D08";

  return scripts\mp\bots\bots::bot_get_player_team();
}

damage_enemies_in_trigger() {
  var_0 = ["_encstr_A78007C63685CD3789", "_encstr_A18007BB31E23313B5", "_encstr_93800776A44FA3371A", "_encstr_A38007C68D2C9BDC0D", "_encstr_8F800726CADA83A305"];

  if(isusingmatchrulesdata()) {
    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      if(scripts\mp\utility\game::getmatchrulesdatawithteamandindex("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", deactivate_trap_object(), var_1, "_encstr_959506B911C79707", "_encstr_8C8F065F255DC395"))
        var_0[var_1] = var_1;
    }
  }

  var_2 = scripts\engine\utility::random(var_0);
  var_3 = [];

  foreach(var_5 in level.bot_loadout_fields) {
    if(isstring(var_2)) {
      var_3[var_5] = bot_loadout_choose_from_default_class(var_2, var_5);
      continue;
    }

    var_3[var_5] = deactivate_track_timers(var_2, var_5);
  }

  return var_3;
}

bot_pick_personality_from_weapon(var_0) {
  if(isDefined(var_0)) {
    var_1 = level.bot_weap_personality[var_0];

    if(isDefined(var_1)) {
      var_2 = strtok(var_1, "_encstr_AA07038F10");

      if(var_2.size > 0)
        scripts\mp\bots\bots_util::bot_set_personality(scripts\engine\utility::random(var_2));
    }
  }
}

bot_loadout_fields() {
  var_0 = "_encstr_9A44154823EDEDC0E37B09F72397EFB3E64AB0DA8A120D";

  if(!isDefined(level.bot_loadout_fields)) {
    level.bot_loadout_fields = [];
    var_1 = 3;

    for(;;) {
      var_2 = tablelookupbyrow(var_0, var_1, 0);

      if(var_2 == "_encstr_B40101") {
        break;
      }

      level.bot_loadout_fields[level.bot_loadout_fields.size] = var_2;
      var_1++;
    }
  }

  return level.bot_loadout_fields;
}

bot_loadout_set(var_0, var_1, var_2, var_3) {
  var_4 = bot_loadout_make_index(var_0, var_1, var_2);

  if(!isDefined(level.botloadoutsets))
    level.botloadoutsets = [];

  if(!isDefined(level.botloadoutsets[var_4]) && var_3) {
    level.botloadoutsets[var_4] = spawnStruct();
    level.botloadoutsets[var_4].loadouts = [];
  }

  if(isDefined(level.botloadoutsets[var_4]))
    return level.botloadoutsets[var_4];
}

bot_loadout_pick(var_0, var_1, var_2) {
  var_3 = bot_loadout_set(var_0, var_1, var_2, 0);

  if(isDefined(var_3) && isDefined(var_3.loadouts) && var_3.loadouts.size > 0) {
    var_4 = randomint(var_3.loadouts.size);
    return var_3.loadouts[var_4].loadoutvalues;
  }
}

bot_validate_weapon(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = [];

  if(isDefined(var_1) && var_1 != "_encstr_8BBA05185F8B99")
    var_7[var_7.size] = var_1;

  if(isDefined(var_2) && var_2 != "_encstr_8BBA05185F8B99")
    var_7[var_7.size] = var_2;

  if(isDefined(var_3) && var_3 != "_encstr_8BBA05185F8B99")
    var_7[var_7.size] = var_3;

  if(isDefined(var_4) && var_4 != "_encstr_8BBA05185F8B99")
    var_7[var_7.size] = var_4;

  if(isDefined(var_5) && var_5 != "_encstr_8BBA05185F8B99")
    var_7[var_7.size] = var_5;

  if(isDefined(var_6) && var_6 != "_encstr_8BBA05185F8B99")
    var_7[var_7.size] = var_6;

  var_8 = scripts\mp\utility\weapon::register_wave_spawner(var_0);
  var_9 = scripts\mp\weapons::safechecknum(var_0);
  var_10 = damageskipburndownmedium(var_9);
  var_11 = damageshield_threshold(var_9);

  for(var_12 = 0; var_12 < var_7.size; var_12++) {
    if(!bot_loadout_item_allowed("_encstr_B19A0BD803A4E10F42E50598BB", var_7[var_12], undefined))
      return 0;

    if(!scripts\engine\utility::array_contains(var_8, var_7[var_12]))
      return 0;

    var_13 = 0;

    for(var_14 = var_12 - 1; var_14 >= 0; var_14--) {
      if(var_7[var_12] == var_7[var_14]) {
        var_13++;

        if(var_13 == 1) {
          if(!isDefined(var_11[var_7[var_12]]))
            return 0;
        } else if(var_13 > 1)
          return 0;
      } else if(isDefined(var_10[var_7[var_12]])) {
        if(isDefined(var_10[var_7[var_12]][var_7[var_14]]))
          return 0;
      }
    }
  }

  return 1;
}

bot_validate_reticle(var_0, var_1, var_2) {
  if(isDefined(var_1[var_0 + "_encstr_B19A0BD903A4E10F42E50598BB"]) && isDefined(level.bot_attachment_reticle[var_1[var_0 + "_encstr_B19A0BD903A4E10F42E50598BB"]]))
    return 1;

  if(isDefined(var_1[var_0 + "_encstr_B6030C1FA3FB7BD9D81F88E843BA"]) && isDefined(level.bot_attachment_reticle[var_1[var_0 + "_encstr_B6030C1FA3FB7BD9D81F88E843BA"]]))
    return 1;

  if(isDefined(var_1[var_0 + "_encstr_A6030CC1FBA3EF1E2330D78B732F"]) && isDefined(level.bot_attachment_reticle[var_1[var_0 + "_encstr_A6030CC1FBA3EF1E2330D78B732F"]]))
    return 1;

  return 0;
}

bot_perk_cost(var_0) {
  return level.perktable_costs[var_0];
}

perktable_add(var_0, var_1) {
  if(bot_perk_cost(var_0) > 0) {
    var_2 = [];
    var_2["_encstr_81EF05D197C12B"] = var_1;
    var_2["_encstr_84BA05A8CA852B"] = var_0;
    level.bot_perktable[level.bot_perktable.size] = var_2;
    level.bot_perktypes[var_0] = var_1;
  }
}

init_perktable() {
  level.perktable_costs = [];
  var_0 = 1;

  for(;;) {
    var_1 = tablelookupbyrow("_encstr_A3B11105673F630D2328AB079818C54E7F7E4B", var_0, 1);

    if(var_1 == "_encstr_B40101") {
      break;
    }

    level.perktable_costs[var_1] = int(tablelookupbyrow("_encstr_A3B11105673F630D2328AB079818C54E7F7E4B", var_0, 10));
    var_0++;
  }

  level.perktable_costs["_encstr_8BBA05185F8B99"] = 0;
  level.perktable_costs["_encstr_AC9C0FEA0FF30A29692883BF99A00D4249"] = 0;
  level.bot_perktable = [];
  level.bot_perktypes = [];
  var_0 = 1;

  for(var_2 = "_encstr_9BB30D0B89D2C62D3A97AFB9D5C663"; isDefined(var_2) && var_2 != "_encstr_B40101"; var_2 = tablelookupbyrow("_encstr_965317B60E79B1B0360BC45AB15A47CBE85898C65671D8DCCE", var_0, 1)) {
    var_2 = getsubstr(var_2, 8);

    for(var_3 = 4; var_3 <= 13; var_3++) {
      var_1 = tablelookupbyrow("_encstr_965317B60E79B1B0360BC45AB15A47CBE85898C65671D8DCCE", var_0, var_3);

      if(var_1 != "_encstr_B40101")
        perktable_add(var_1, var_2);
    }

    var_0++;
  }
}

init_bot_weap_statstable() {
  level.bot_weap_statstable = [];
  level.bot_weap_personality = [];
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", var_0, 0);

    if(var_1 == "_encstr_B40101") {
      break;
    }

    var_2 = tablelookupbyrow("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", var_0, 4);
    var_3 = tablelookupbyrow("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", var_0, 38);
    var_4 = tablelookupbyrow("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", var_0, 40);
    var_5 = tablelookupbyrow("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", var_0, 39);

    if(var_4 != "_encstr_B40101" && var_2 != "_encstr_B40101" && var_5 != "_encstr_B40101" && var_3 != "_encstr_B40101") {
      if(!scripts\mp\weapons::vehicle_ai_avoidance_cleanup(var_2)) {
        var_0++;
        continue;
      }

      var_6 = "_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243";

      if(scripts\mp\utility\weapon::iscacsecondaryweapon(var_2))
        var_6 = "_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B";
      else if(!scripts\mp\utility\weapon::iscacprimaryweapon(var_2)) {
        var_0++;
        continue;
      }

      level.bot_weap_personality[var_2] = var_5;

      if(!isDefined(level.bot_weap_statstable[var_6]))
        level.bot_weap_statstable[var_6] = [];

      var_7 = strtok(var_3, "_encstr_854C021F");
      var_8 = strtok(var_5, "_encstr_AA07038F10");
      var_9 = strtok(var_4, "_encstr_AA07038F10");

      foreach(var_11 in var_7) {
        var_11 = "_encstr_842D0BD25E98A08515213A0597" + var_11;

        foreach(var_13 in var_8) {
          foreach(var_15 in var_9) {
            var_16 = bot_loadout_make_index(var_11, var_13, var_15);

            if(!isDefined(level.bot_weap_statstable[var_6][var_16]))
              level.bot_weap_statstable[var_6][var_16] = [];

            var_17 = level.bot_weap_statstable[var_6][var_16].size;
            level.bot_weap_statstable[var_6][var_16][var_17] = var_2;
          }
        }
      }
    }

    var_0++;
  }
}

bot_loadout_choose_from_statstable(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = "_encstr_8BBA05185F8B99";

  if(var_2 == "_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B" && scripts\engine\utility::array_contains(var_1, "_encstr_8B4717FBC37D5F8CD0399C8947A0D3A71F7BD282494E2FC728"))
    var_2 = "_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243";

  if(!isDefined(level.bot_weap_statstable))
    return var_6;

  if(!isDefined(level.bot_weap_statstable[var_2]))
    return var_6;

  var_7 = bot_loadout_make_index(var_3, var_4, var_5);

  if(!isDefined(level.bot_weap_statstable[var_2][var_7]))
    return var_6;

  var_6 = bot_loadout_choose_from_set(level.bot_weap_statstable[var_2][var_7], var_0, var_1, var_2);
  return var_6;
}

bot_loadout_choose_from_perktable(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249";

  if(!isDefined(level.bot_perktable))
    return var_6;

  if(!isDefined(level.bot_perktable_groups))
    level.bot_perktable_groups = [];

  if(!isDefined(level.bot_perktable_groups[var_0])) {
    var_7 = strtok(var_0, "_encstr_BA4C02DF");
    var_7[0] = "_encstr_B40101";
    var_8 = 0;

    if(scripts\engine\utility::array_contains(var_7, "_encstr_9A19040BCDBC"))
      var_8 = 1;

    var_9 = [];

    foreach(var_11 in level.bot_perktable) {
      if(var_8 || scripts\engine\utility::array_contains(var_7, var_11["_encstr_81EF05D197C12B"]))
        var_9[var_9.size] = var_11["_encstr_84BA05A8CA852B"];
    }

    level.bot_perktable_groups[var_0] = var_9;
  }

  if(level.bot_perktable_groups[var_0].size > 0)
    var_6 = bot_loadout_choose_from_set(level.bot_perktable_groups[var_0], var_1, var_2, var_3);

  return var_6;
}

bot_validate_perk(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_4 - var_3 + 1;

  if(isDefined(var_5))
    var_6 = var_5;

  var_7 = 0;
  var_8 = int(getsubstr(var_1, 11));

  if(var_0 == "_encstr_8B4717FBC37D5F8CD0399C8947A0D3A71F7BD282494E2FC728")
    return 0;

  if(var_0 == "_encstr_A9A11B6E83ACB1A5C2D83AF2AF593CA3272CAFB08E470B1B34DACA9BE8")
    return 0;

  if(!bot_loadout_item_allowed("_encstr_960D052F10EBF0", var_0))
    return 0;

  for(var_9 = var_8 - 1; var_9 > 0; var_9--) {
    var_10 = "_encstr_AD0E0C49FFD6A830573B7FC143F7" + var_9;

    if(var_2[var_10] == "_encstr_8BBA05185F8B99" || var_2[var_10] == "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249") {
      continue;
    }
    if(var_0 == var_2[var_10])
      return 0;

    if(var_9 >= var_3 && var_9 <= var_4)
      var_7 = var_7 + bot_perk_cost(var_2[var_10]);
  }

  if(var_7 + bot_perk_cost(var_0) > var_6)
    return 0;

  return 1;
}

bot_loadout_choose_from_default_class(var_0, var_1) {
  var_2 = int(getsubstr(var_0, 5, 6)) - 1;

  switch (var_1) {
    case "_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243":
      return scripts\mp\class::table_getweapon(level.classtablename, var_2, 0);
    case "_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878":
      return scripts\mp\class::table_getweaponattachment(level.classtablename, var_2, 0, 0);
    case "_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353":
      return scripts\mp\class::table_getweaponattachment(level.classtablename, var_2, 0, 1);
    case "_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED":
      return scripts\mp\class::table_getweaponcamo(level.classtablename, var_2, 0);
    case "_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3":
      return scripts\mp\class::table_getweaponreticle(level.classtablename, var_2, 0);
    case "_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B":
      return scripts\mp\class::table_getweapon(level.classtablename, var_2, 1);
    case "_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB":
      return scripts\mp\class::table_getweaponattachment(level.classtablename, var_2, 1, 0);
    case "_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7":
      return scripts\mp\class::table_getweaponattachment(level.classtablename, var_2, 1, 1);
    case "_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560":
      return scripts\mp\class::table_getweaponcamo(level.classtablename, var_2, 1);
    case "_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D":
      return scripts\mp\class::table_getweaponreticle(level.classtablename, var_2, 1);
    case "_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB":
      return scripts\mp\class::table_getequipmentprimary(level.classtablename, var_2);
    case "_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B":
      return scripts\mp\class::table_getequipmentsecondary(level.classtablename, var_2);
    case "_encstr_8BBF0F195FB7B9E76303D1F07B3FB3104E":
      return scripts\mp\class::table_getkillstreak(level.classtablename, var_2, 0);
    case "_encstr_8DBF0FD8ED16C8ED57A3A9A39C5685B523":
      return scripts\mp\class::table_getkillstreak(level.classtablename, var_2, 1);
    case "_encstr_A5BF0FD5086FE44D43DCFB7B357B4F0CCB":
      return scripts\mp\class::table_getkillstreak(level.classtablename, var_2, 2);
    case "_encstr_82CB0D234F3FCAE728F362372B5B66":
    case "_encstr_92CB0DB1EDB023BDBAA341AC39D653":
    case "_encstr_BECB0D603591D040ABD3A9DBD39235":
    case "_encstr_81CB0D4DB85834BAFDA97BA7CDAA27":
    case "_encstr_88CB0DC6B70B237B5D1DA02B27AD46":
    case "_encstr_96CB0DB3C7BF3CCF5363C0EA92DCCA":
      var_3 = int(getsubstr(var_1, 11));
      var_4 = scripts\mp\class::table_getperk(level.classtablename, var_2, var_3);

      if(var_4 == "_encstr_B40101")
        return "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249";

      var_5 = int(getsubstr(var_4, 0, 1));
      var_6 = int(getsubstr(var_4, 1, 2));
      var_7 = tablelookupbyrow("_encstr_965317B60E79B1B0360BC45AB15A47CBE85898C65671D8DCCE", var_5 + 1, var_6 + 3);
      return var_7;
  }

  return var_0;
}

deactivate_track_timers(var_0, var_1) {
  var_2 = deactivate_trap_object();
  var_3 = scripts\mp\utility\game::getmatchrulesspecialclass(var_2, var_0);
  return var_3[var_1];
}

init_bot_attachmenttable() {
  level.bot_attachmenttable = [];
  level.bot_attachment_reticle = [];
  var_0 = tablelookupgetnumrows("_encstr_A39F1718AA97B085834F170957BAC0A0644661B0174E683EFB");

  for(var_1 = 1; var_1 < var_0; var_1++) {
    var_2 = tablelookupbyrow("_encstr_A39F1718AA97B085834F170957BAC0A0644661B0174E683EFB", var_1, 5);
    var_3 = tablelookupbyrow("_encstr_A39F1718AA97B085834F170957BAC0A0644661B0174E683EFB", var_1, 20);

    if(var_2 != "_encstr_B40101" && var_3 != "_encstr_B40101") {
      var_4 = tablelookupbyrow("_encstr_A39F1718AA97B085834F170957BAC0A0644661B0174E683EFB", var_1, 11);

      if(var_4 == "_encstr_AAEF05B9394BAB")
        level.bot_attachment_reticle[var_2] = 1;

      var_5 = strtok(var_3, "_encstr_AA07038F10");

      foreach(var_7 in var_5) {
        if(!isDefined(level.bot_attachmenttable[var_7]))
          level.bot_attachmenttable[var_7] = [];

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
    [var_11, var_12] = str("_encstr_BDFB18451FC0A703F1183A82903B7D0BA108DDC23813D28EA798");
    level.deactivate_gas_trap_cloud["_encstr_8B1608EC43B8D647A113"] = var_11;
    level.brjugg_watchoverheat["_encstr_8B1608EC43B8D647A113"] = var_12;
    [var_11, var_12] = str("_encstr_84FF1B1D910A2EAB45A9BA1230150BA3D007859AD780F98F4DA8B2AB7B");
    level.deactivate_gas_trap_cloud["_encstr_BD0703AF7C"] = var_11;
    level.brjugg_watchoverheat["_encstr_BD0703AF7C"] = var_12;
  }
}

str(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = 0;

  for(;;) {
    var_3++;
    var_4 = tablelookupbyrow(var_0, 0, var_3);

    if(var_4 == "_encstr_B40101") {
      break;
    }

    var_5 = 0;

    for(;;) {
      var_5++;
      var_6 = tablelookupbyrow(var_0, var_5, 0);

      if(var_6 == "_encstr_B40101") {
        break;
      }

      if(var_6 == var_4) {
        if(tablelookupbyrow(var_0, var_5, var_3) != "_encstr_BE07036548")
          var_2[var_6] = 1;

        continue;
      }

      if(tablelookupbyrow(var_0, var_5, var_3) == "_encstr_BE07036548")
        var_1[var_4][var_6] = 1;
    }
  }

  return [var_1, var_2];
}

damageskipburndownmedium(var_0) {
  if(isDefined(level.deactivate_gas_trap_cloud[var_0]))
    return level.deactivate_gas_trap_cloud[var_0];

  return level.deactivate_gas_trap_cloud["_encstr_8B1608EC43B8D647A113"];
}

damageshield_threshold(var_0) {
  if(isDefined(level.brjugg_watchoverheat[var_0]))
    return level.brjugg_watchoverheat[var_0];

  return level.brjugg_watchoverheat["_encstr_8B1608EC43B8D647A113"];
}

bot_loadout_choose_from_attachmenttable(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "_encstr_8BBA05185F8B99";

  if(!isDefined(level.bot_attachmenttable))
    return var_5;

  if(!isDefined(level.bot_attachmenttable[var_4]))
    return var_5;

  var_5 = bot_loadout_choose_from_set(level.bot_attachmenttable[var_4], var_0, var_1, var_2);
  return var_5;
}

init_bot_camotable() {
  var_0 = "_encstr_AD521190129FF3D66B6050D730B3BDCAE10A3B";
  level.bot_camotable = [];
  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow(var_0, var_1, scripts\common\utility::getcamotablecolumnindex("_encstr_A1B40AC26FAD22B8C0FBF0B9"));

    if(!isDefined(var_2) || var_2 == "_encstr_B40101") {
      break;
    }

    var_3 = tablelookupbyrow(var_0, var_1, scripts\common\utility::getcamotablecolumnindex("_encstr_AAB20A219ABBC8D006348381"));

    if(isDefined(var_3) && int(var_3))
      level.bot_camotable[level.bot_camotable.size] = var_2;

    var_1++;
  }
}

bot_loadout_choose_from_camotable(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "_encstr_8BBA05185F8B99";
  return var_5;
}

bot_loadout_perk_slots(var_0) {
  var_1 = 8;

  if(isDefined(var_0["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"]) && var_0["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] == "_encstr_8BBA05185F8B99")
    var_1 = var_1 + 1;

  if(isDefined(var_0["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"]) && var_0["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] == "_encstr_8BBA05185F8B99")
    var_1 = var_1 + 1;

  if(isDefined(var_0["_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB"]) && var_0["_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB"] == "_encstr_8BBA05185F8B99")
    var_1 = var_1 + 1;

  if(isDefined(var_0["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"]) && var_0["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"] == "_encstr_8BBA05185F8B99")
    var_1 = var_1 + 1;

  return var_1;
}

bot_loadout_valid_choice(var_0, var_1, var_2, var_3) {
  var_4 = 1;

  switch (var_2) {
    case "_encstr_AA2D1188DD6928B843CBA3CDBFBAF5F01972D1":
      break;
    case "_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243":
      var_4 = bot_loadout_item_allowed("_encstr_AC20072B9FA9487832", var_3);
      break;
    case "_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B":
    case "_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB":
      var_4 = bot_loadout_item_allowed("_encstr_BE8F0A272F9B2BE97268AE8B", var_3);
      break;
    case "_encstr_99651ABB702174E2F32532B2839B5A2A4A795343A8D9A00A3B30037A":
      var_4 = bot_validate_weapon(var_1["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"], var_3);
      break;
    case "_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353":
      var_4 = bot_validate_weapon(var_1["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"], var_1["_encstr_99651ABB702174E2F32532B2839B5A2A4A795343A8D9A00A3B30037A"], var_3);
      break;
    case "_encstr_A7651A1BF6C2C8F6ABA38227966B2CE42F283AE858C61AD6ACB93A66":
      var_4 = bot_validate_weapon(var_1["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"], var_1["_encstr_99651ABB702174E2F32532B2839B5A2A4A795343A8D9A00A3B30037A"], var_1["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"], var_3);
      break;
    case "_encstr_A3651A59EF2658C0A72B6F13C2FF8FA07859E111890E80190F62E3D3":
      var_4 = bot_validate_weapon(var_1["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"], var_1["_encstr_99651ABB702174E2F32532B2839B5A2A4A795343A8D9A00A3B30037A"], var_1["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"], var_1["_encstr_A7651A1BF6C2C8F6ABA38227966B2CE42F283AE858C61AD6ACB93A66"], var_3);
      break;
    case "_encstr_93651AF8AF834247CDD90F92A16BD90BCAC9E41108C6500DAB88D1FB":
      var_4 = bot_validate_weapon(var_1["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"], var_1["_encstr_99651ABB702174E2F32532B2839B5A2A4A795343A8D9A00A3B30037A"], var_1["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"], var_1["_encstr_A7651A1BF6C2C8F6ABA38227966B2CE42F283AE858C61AD6ACB93A66"], var_1["_encstr_A3651A59EF2658C0A72B6F13C2FF8FA07859E111890E80190F62E3D3"], var_3);
      break;
    case "_encstr_91651A14D5079FCA4D61837A4410EFD608EFD323A1914428A8C34B3B":
      var_4 = bot_validate_weapon(var_1["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"], var_1["_encstr_99651ABB702174E2F32532B2839B5A2A4A795343A8D9A00A3B30037A"], var_1["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"], var_1["_encstr_A7651A1BF6C2C8F6ABA38227966B2CE42F283AE858C61AD6ACB93A66"], var_1["_encstr_A3651A59EF2658C0A72B6F13C2FF8FA07859E111890E80190F62E3D3"], var_1["_encstr_93651AF8AF834247CDD90F92A16BD90BCAC9E41108C6500DAB88D1FB"], var_3);
      break;
    case "_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3":
      var_4 = bot_validate_reticle("_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243", var_1, var_3);
      break;
    case "_encstr_B273139C604663E733D37FFAB2609BC5A3B8AB993B":
      break;
    case "_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED":
      var_4 = !isDefined(self.debug_gates) || var_3 == self.debug_gates;
      break;
    case "_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B":
      var_4 = var_3 != var_1["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"];
      var_4 = var_4 && bot_loadout_item_allowed("_encstr_AC20072B9FA9487832", var_3, undefined);
      break;
    case "_encstr_8FDB1C30B012AF674FBDE9CFFA1033A4635D4BB6D541BF1E90C829ED3BAA":
      var_4 = bot_validate_weapon(var_1["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"], var_3);
      break;
    case "_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7":
      var_4 = bot_validate_weapon(var_1["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"], var_1["_encstr_8FDB1C30B012AF674FBDE9CFFA1033A4635D4BB6D541BF1E90C829ED3BAA"], var_3);
      break;
    case "_encstr_ACDB1CC6BD858CF6ABA3D45636F6E623169C2F0A1D8E85C634AD95B98ECC":
      var_4 = bot_validate_weapon(var_1["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"], var_1["_encstr_8FDB1C30B012AF674FBDE9CFFA1033A4635D4BB6D541BF1E90C829ED3BAA"], var_1["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"], var_3);
      break;
    case "_encstr_A1DB1C292712B5A7DD034F97C73DF6E0A74D9011B3E1F77FA393B00593AC":
      var_4 = bot_validate_weapon(var_1["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"], var_1["_encstr_8FDB1C30B012AF674FBDE9CFFA1033A4635D4BB6D541BF1E90C829ED3BAA"], var_1["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"], var_1["_encstr_ACDB1CC6BD858CF6ABA3D45636F6E623169C2F0A1D8E85C634AD95B98ECC"], var_3);
      break;
    case "_encstr_A7DB1C731F0FFAD7182372C7F9F0EE32D7BDAF3FC12D12939868F70DF3CA":
      var_4 = bot_validate_weapon(var_1["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"], var_1["_encstr_8FDB1C30B012AF674FBDE9CFFA1033A4635D4BB6D541BF1E90C829ED3BAA"], var_1["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"], var_1["_encstr_ACDB1CC6BD858CF6ABA3D45636F6E623169C2F0A1D8E85C634AD95B98ECC"], var_1["_encstr_A1DB1C292712B5A7DD034F97C73DF6E0A74D9011B3E1F77FA393B00593AC"], var_3);
      break;
    case "_encstr_A3DB1CC6B72CC8DE57E86AAC36DE7323B0C9CB0AE8A316D843B62BE6A3B1":
      var_4 = bot_validate_weapon(var_1["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"], var_1["_encstr_8FDB1C30B012AF674FBDE9CFFA1033A4635D4BB6D541BF1E90C829ED3BAA"], var_1["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"], var_1["_encstr_ACDB1CC6BD858CF6ABA3D45636F6E623169C2F0A1D8E85C634AD95B98ECC"], var_1["_encstr_A1DB1C292712B5A7DD034F97C73DF6E0A74D9011B3E1F77FA393B00593AC"], var_1["_encstr_A7DB1C731F0FFAD7182372C7F9F0EE32D7BDAF3FC12D12939868F70DF3CA"], var_3);
      break;
    case "_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D":
      var_4 = bot_validate_reticle("_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B", var_1, var_3);
      break;
    case "_encstr_A2F115B1D77A5D080D63EF214ECFD885D21B1375D77214":
      break;
    case "_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560":
      var_4 = !isDefined(self.debug_hintadjustmentthink) || var_3 == self.debug_hintadjustmentthink;
      break;
    case "_encstr_A5BF0FD5086FE44D43DCFB7B357B4F0CCB":
    case "_encstr_8DBF0FD8ED16C8ED57A3A9A39C5685B523":
    case "_encstr_8BBF0F195FB7B9E76303D1F07B3FB3104E":
      var_4 = scripts\mp\bots\bots_killstreaks::bot_killstreak_is_valid_internal(var_3, "_encstr_9B9B05A21F601A", undefined, var_1["_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321"]);
      var_4 = var_4 && bot_loadout_item_allowed("_encstr_85CE0B9770B02C73A1760F06D2", var_3, var_1["_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321"]);
      break;
    case "_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321":
      break;
    case "_encstr_AFC70EAA80DFE3ADD069D8F57DF8E272":
    case "_encstr_A9C70EC1774E30B8DF43F759CB4F4F42":
    case "_encstr_8CC70EA4A02BFA8555FB48A5AB7F5A58":
    case "_encstr_84CB0D229823C7677BF598A58EC046":
    case "_encstr_8ACB0D14A770673F3D0391CAEB1A5A":
    case "_encstr_BDCB0D59B57AA188158BD1608B53CB":
    case "_encstr_82CB0D234F3FCAE728F362372B5B66":
    case "_encstr_92CB0DB1EDB023BDBAA341AC39D653":
    case "_encstr_BECB0D603591D040ABD3A9DBD39235":
    case "_encstr_81CB0D4DB85834BAFDA97BA7CDAA27":
    case "_encstr_88CB0DC6B70B237B5D1DA02B27AD46":
    case "_encstr_96CB0DB3C7BF3CCF5363C0EA92DCCA":
      var_4 = bot_validate_perk(var_3, var_2, var_1, 1, 12, bot_loadout_perk_slots(var_1));
      break;
    case "_encstr_8DC70E59EF2658C0A72B6FF173E7A79A":
    case "_encstr_A5C70EF1F8481B27338B4F5D2BEB871C":
    case "_encstr_9AC70EB1E0AFFC1763700FE94AA4C176":
      if(var_1["_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321"] != "_encstr_AA2F166B1B7A20BFA2CBD3C9A7C9FED005B650A185D958ED")
        var_4 = 0;
      else
        var_4 = bot_validate_perk(var_3, var_2, var_1, -1, -1);

      break;
    case "_encstr_B1C70ED99F777927A34389383BFC555B":
    case "_encstr_A2C70E63DBC28CDEABD1055939B69119":
    case "_encstr_95C70E4BB8486118254BF0A176474A8B":
    case "_encstr_B4C70E593F92B5F0E58B970932D352D7":
    case "_encstr_83C70EF882F75D103B14F99B3AE4BABB":
    case "_encstr_9BC70EE307902DF0633B09CD5313AB3A":
    case "_encstr_86C70EFB97F7022F90BB3A7F5348398F":
    case "_encstr_8BC70E34F0C8CF2FBBE5672B43670215":
      if(var_1["_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321"] != "_encstr_AA2F166B1B7A20BFA2CBD3C9A7C9FED005B650A185D958ED")
        var_4 = 0;
      else
        var_4 = bot_validate_perk(var_3, var_2, var_1, 16, 23, 8);

      break;
    default:
      break;
  }

  return var_4;
}

bot_loadout_choose_from_set(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "_encstr_8BBA05185F8B99";
  var_6 = undefined;
  var_7 = 0.0;

  if(scripts\engine\utility::array_contains(var_0, "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249"))
    var_5 = "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249";

  if(var_1 == "_encstr_A9C70FDF744E88B6DB12B178BA9F67B8E0") {
    if(!isDefined(self.juggernaut_death_watcher))
      self.juggernaut_death_watcher = scripts\engine\utility::random(["_encstr_A78007C63685CD3789", "_encstr_A18007BB31E23313B5", "_encstr_93800776A44FA3371A", "_encstr_A38007C68D2C9BDC0D", "_encstr_8F800726CADA83A305"]);

    var_0 = [self.juggernaut_death_watcher];
  }

  foreach(var_9 in var_0) {
    var_10 = undefined;

    if(getsubstr(var_9, 0, 9) == "_encstr_9AC70A81A1A9E81BE170A9AE") {
      var_10 = var_9;
      var_11 = level.botloadouttemplates[var_9][var_3];
      var_9 = bot_loadout_choose_from_set(strtok(var_11, "_encstr_AA07038F10"), var_1, var_2, var_3, 1);

      if(isDefined(var_10) && isDefined(self.chosentemplates[var_10]))
        return var_9;
    }

    if(var_9 == "_encstr_88731029A1E816DF63F0328AFB450F0EC07B")
      return bot_loadout_choose_from_attachmenttable(var_1, var_2, var_3, self.personality, self.difficulty);

    if(var_9 == "_encstr_ADFB10335D33F3A793A08FC380AB511A91E5")
      return bot_loadout_choose_from_statstable(var_1, var_2, var_3, self.botarchetype, self.personality, self.difficulty);

    if(var_9 == "_encstr_B20C0A67A02DC5230B18A29D")
      return bot_loadout_choose_from_camotable(var_1, var_2, var_3, self.personality, self.difficulty);

    if(getsubstr(var_9, 0, 5) == "_encstr_959506B911C79707" && int(getsubstr(var_9, 5, 6)) > 0)
      var_9 = bot_loadout_choose_from_default_class(var_9, var_3);

    if(isDefined(level.bot_perktable) && getsubstr(var_9, 0, 10) == "_encstr_ACE90BDA82B36A30072828D937")
      return bot_loadout_choose_from_perktable(var_9, var_1, var_2, var_3, self.personality, self.difficulty);

    if(bot_loadout_valid_choice(var_1, var_2, var_3, var_9)) {
      var_7 = var_7 + 1.0;
      var_12 = randomfloat(1.0);

      if(var_12 < 1.0 / var_7) {
        var_5 = var_9;
        var_6 = var_10;
      }
    }
  }

  if(isDefined(var_6))
    self.chosentemplates[var_6] = 1;

  return var_5;
}

bot_loadout_choose_values(var_0) {
  self.chosentemplates = [];

  foreach(var_6, var_2 in var_0) {
    var_3 = undefined;

    if(!isDefined(var_3)) {
      var_5 = strtok(var_2, "_encstr_AA07038F10");
      var_3 = bot_loadout_choose_from_set(var_5, var_2, var_0, var_6);
    }

    var_0[var_6] = var_3;
  }

  return var_0;
}

bot_loadout_get_difficulty() {
  var_0 = self botgetdifficulty();

  if(var_0 == "_encstr_8B1608EC43B8D647A113") {
    scripts\mp\bots\bots_util::bot_set_difficulty("_encstr_8B1608EC43B8D647A113");
    var_0 = self botgetdifficulty();
  }

  return var_0;
}

bot_loadout_get_archetype() {
  if(!isDefined(self.botarchetype)) {
    var_0 = self botgetpersonality();
    var_1 = level.botarchetypes[var_0];
    var_2 = randomint(var_1.size);
    self.botarchetype = var_1[var_2];
  }

  return self.botarchetype;
}

dangercircleenthidefromplayers() {
  if(isDefined(self.pers["_encstr_85F411AE45DB1F3BE35BF8107F0471B7736F9E"]))
    return self.pers["_encstr_85F411AE45DB1F3BE35BF8107F0471B7736F9E"];

  return [];
}

dangercircletick_carriable() {
  if(dangercircleenthidefromplayers().size > 0) {
    if(isDefined(self.pers["_encstr_990A1630472B51FF2360719063D87EE552531324C6F060A3"])) {
      var_0 = self.pers["_encstr_990A1630472B51FF2360719063D87EE552531324C6F060A3"];
      return self.pers["_encstr_85F411AE45DB1F3BE35BF8107F0471B7736F9E"][var_0];
    }
  }

  return undefined;
}

currentrewarddropindex() {
  if(istrue(self.deadyellow))
    return 0;
  else if(!isDefined(self.pers["_encstr_97A20F26B747620BCD4789B7B0917BEA3A"]))
    return 0;
  else if(istrue(self.respawn_with_launcher))
    return 0;
  else if(isDefined(self.hasdied) && !self.hasdied)
    return 0;

  return 1;
}

bot_loadout_class_callback(var_0) {
  while(!isDefined(level.bot_loadouts_initialized))
    wait 0.05;

  while(!isDefined(self.personality))
    wait 0.05;

  var_1 = [];
  var_2 = bot_loadout_get_difficulty();
  self.difficulty = var_2;
  var_3 = self botgetpersonality();
  var_4 = bot_loadout_get_archetype();

  if(!isDefined(self.deactivate_stealth_settings))
    self.cypher_signal_strength_nag = 0;

  self.deactivate_stealth_settings = self.cypher_signal_strength_nag;

  if(isDefined(self.pers["_encstr_97A20F26B747620BCD4789B7B0917BEA3A"]) && istrue(var_0))
    return self.pers["_encstr_97A20F26B747620BCD4789B7B0917BEA3A"];

  var_5 = !isDefined(self.pers["_encstr_856319069D33696132F9EC10B13988D3F3614313F214C18FF5DB39"]) || self.pers["_encstr_856319069D33696132F9EC10B13988D3F3614313F214C18FF5DB39"] == var_2;
  var_6 = !isDefined(self.pers["_encstr_92E71A891DBCA97FE30B793777BAB0B8543A9103821FF0276A673103"]) || self.pers["_encstr_92E71A891DBCA97FE30B793777BAB0B8543A9103821FF0276A673103"] == var_3;
  var_7 = 0;

  if(!var_5 || !var_6) {
    self.pers["_encstr_97A20F26B747620BCD4789B7B0917BEA3A"] = undefined;
    self.pers["_encstr_85F411AE45DB1F3BE35BF8107F0471B7736F9E"] = undefined;
    self.pers["_encstr_990A1630472B51FF2360719063D87EE552531324C6F060A3"] = undefined;
    var_7 = 1;
  }

  var_8 = !var_7 && currentrewarddropindex();

  if(var_8) {
    var_9 = 0.1;
    var_11 = randomfloat(1.0) >= var_9;

    if(var_11)
      return self.pers["_encstr_97A20F26B747620BCD4789B7B0917BEA3A"];
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
        if(var_14.size < 5)
          var_15 = 1;
      } else if(isDefined(self.respawn_with_launcher))
        var_15 = 1;
      else if(var_14.size < 4)
        var_15 = 1;

      if(!var_15)
        var_13 = scripts\engine\utility::random(var_14);
    }

    if(isDefined(var_13)) {
      self.cypher_signal_strength_nag++;
      self.pers["_encstr_97A20F26B747620BCD4789B7B0917BEA3A"] = var_13;
      return var_13;
    }
  }

  var_16 = undefined;
  var_17 = cypher_vo_complete();

  if(var_17) {
    var_16 = bot_loadout_pick(var_4, var_3, var_2);
    var_1 = bot_loadout_choose_values(var_16);

    if(isDefined(level.bot_funcs["_encstr_9BA8189D166B59D1F23895AF8D7BC2467BD58EEBADDE465A33E5"]))
      var_1 = self[[level.bot_funcs["_encstr_9BA8189D166B59D1F23895AF8D7BC2467BD58EEBADDE465A33E5"]]](var_1);

    if(deactivategastrap(var_1))
      var_17 = 0;
  }

  if(!var_17) {
    var_1 = damage_enemies_in_trigger();
    bot_pick_personality_from_weapon(var_1["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"]);
  }

  if(var_1["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] == "_encstr_8BBA05185F8B99") {
    self.bot_fallback_personality = undefined;
    var_1["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = bot_loadout_choose_fallback_primary(var_1);
    var_1["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] = "_encstr_8BBA05185F8B99";
    var_1["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"] = "_encstr_8BBA05185F8B99";
    var_1["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"] = "_encstr_8BBA05185F8B99";
    var_1["_encstr_A7651A1BF6C2C8F6ABA38227966B2CE42F283AE858C61AD6ACB93A66"] = "_encstr_8BBA05185F8B99";
    var_1["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"] = "_encstr_8BBA05185F8B99";

    if(isDefined(self.bot_fallback_personality)) {
      if(self.bot_fallback_personality == "_encstr_AC20072B9FA9487832")
        bot_pick_personality_from_weapon(var_1["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"]);
      else
        scripts\mp\bots\bots_util::bot_set_personality(self.bot_fallback_personality);

      var_3 = self.personality;
      self.bot_fallback_personality = undefined;
    }
  }

  var_18 = isDefined(self.respawn_with_launcher);

  if(var_17 && scripts\mp\bots\bots_util::bot_israndom()) {
    if(isDefined(var_1["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"]) && var_1["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] != "_encstr_8BBA05185F8B99" && !isDefined(self.debug_gates))
      self.debug_gates = var_1["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"];

    if(isDefined(var_1["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"]) && var_1["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"] != "_encstr_8BBA05185F8B99" && !isDefined(self.debug_hintadjustmentthink))
      self.debug_hintadjustmentthink = var_1["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"];

    if(var_18) {
      var_19 = level.bot_respawn_launcher_name[self botgetdifficulty()];

      if(bot_loadout_item_allowed("_encstr_AC20072B9FA9487832", var_19, undefined)) {
        var_1["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = level.bot_respawn_launcher_name;
        var_1["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB"] = "_encstr_8BBA05185F8B99";
        var_1["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = "_encstr_8BBA05185F8B99";
        self.deadyellow = 1;
      }

      self.respawn_with_launcher = undefined;
    }
  }

  var_1 = bot_loadout_setup_perks(var_1);

  if(scripts\mp\bots\bots_util::bot_israndom()) {
    if(scripts\engine\utility::array_contains(self.pers["_encstr_86CB0DFB97F7022F90BB3A7F53487B"], "_encstr_8B4717FBC37D5F8CD0399C8947A0D3A71F7BD282494E2FC728")) {
      var_20 = bot_loadout_pick("_encstr_931904C66102", var_2);
      var_1["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = var_20["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"];
      var_1["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB"] = var_20["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"];
      var_1["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = var_20["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"];
      var_1 = bot_loadout_choose_values(var_1);
      var_1 = bot_loadout_setup_perks(var_1);
    }

    if(scripts\engine\utility::array_contains(self.pers["_encstr_86CB0DFB97F7022F90BB3A7F53487B"], "_encstr_A9A11B6E83ACB1A5C2D83AF2AF593CA3272CAFB08E470B1B34DACA9BE8")) {
      var_21 = bot_loadout_pick(var_3, var_2);
      var_1["_encstr_A7651A1BF6C2C8F6ABA38227966B2CE42F283AE858C61AD6ACB93A66"] = var_21["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"];

      if(scripts\engine\utility::array_contains(self.pers["_encstr_86CB0DFB97F7022F90BB3A7F53487B"], "_encstr_8B4717FBC37D5F8CD0399C8947A0D3A71F7BD282494E2FC728"))
        var_1["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = var_21["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"];
      else
        var_1["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = var_21["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"];

      var_1 = bot_loadout_choose_values(var_1);
      var_1 = bot_loadout_setup_perks(var_1);
    } else {
      var_1["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = "_encstr_8BBA05185F8B99";

      if(!bot_validate_reticle("_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B", var_1, var_1["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"]))
        var_1["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"] = "_encstr_8BBA05185F8B99";
    }
  }

  self.cypher_signal_strength_nag++;
  self.pers["_encstr_97A20F26B747620BCD4789B7B0917BEA3A"] = var_1;
  self.pers["_encstr_856319069D33696132F9EC10B13988D3F3614313F214C18FF5DB39"] = var_2;
  self.pers["_encstr_92E71A891DBCA97FE30B793777BAB0B8543A9103821FF0276A673103"] = var_3;

  if(!isDefined(self.pers["_encstr_85F411AE45DB1F3BE35BF8107F0471B7736F9E"]))
    self.pers["_encstr_85F411AE45DB1F3BE35BF8107F0471B7736F9E"] = [];

  var_22 = self.pers["_encstr_85F411AE45DB1F3BE35BF8107F0471B7736F9E"].size;
  self.pers["_encstr_85F411AE45DB1F3BE35BF8107F0471B7736F9E"][var_22] = var_1;

  if(var_18)
    self.pers["_encstr_990A1630472B51FF2360719063D87EE552531324C6F060A3"] = var_22;

  return var_1;
}

bot_loadout_setup_perks(var_0) {
  self.pers["_encstr_86CB0DFB97F7022F90BB3A7F53487B"] = [];
  self.pers["_encstr_811A1703EA6D4F2B1F4138CB73A8956515532F317D699F57F6"] = [];
  self.pers["_encstr_8ACE12EE4A02976029F370A8FB739BEDAAB66A76"] = [];
  self.pers["_encstr_91E416B90ECA8D962C8D4BDCE86A3A9CCA16B55A5A8D8D37"] = [];
  var_1 = 0;
  var_2 = isDefined(var_0["_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321"]) && var_0["_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321"] == "_encstr_AA2F166B1B7A20BFA2CBD3C9A7C9FED005B650A185D958ED";

  if(var_2) {
    var_0["_encstr_8BBF0F195FB7B9E76303D1F07B3FB3104E"] = "_encstr_8BBA05185F8B99";
    var_0["_encstr_8DBF0FD8ED16C8ED57A3A9A39C5685B523"] = "_encstr_8BBA05185F8B99";
    var_0["_encstr_A5BF0FD5086FE44D43DCFB7B357B4F0CCB"] = "_encstr_8BBA05185F8B99";
  }

  foreach(var_8, var_4 in var_0) {
    if(var_4 == "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249" || var_4 == "_encstr_8BBA05185F8B99") {
      continue;
    }
    if(getsubstr(var_8, 0, 11) == "_encstr_AD0E0C49FFD6A830573B7FC143F7") {
      var_5 = int(getsubstr(var_8, 11));

      if(!var_2 && var_5 > 12) {
        continue;
      }
      var_6 = scripts\mp\utility\perk::getbaseperkname(var_4);

      if(var_5 <= 12)
        self.pers["_encstr_86CB0DFB97F7022F90BB3A7F53487B"][self.pers["_encstr_86CB0DFB97F7022F90BB3A7F53487B"].size] = var_6;
      else if(var_5 <= 15) {
        var_0["_encstr_8AA50E70256120B05BC3BFC9E3628F10" + (var_1 + 1)] = var_6 + "_encstr_8D1A04EBADCD";
        self.pers["_encstr_8ACE12EE4A02976029F370A8FB739BEDAAB66A76"][self.pers["_encstr_8ACE12EE4A02976029F370A8FB739BEDAAB66A76"].size] = var_6 + "_encstr_8D1A04EBADCD";
        var_7 = 0;

        if(var_1 > 0)
          var_7 = self.pers["_encstr_91E416B90ECA8D962C8D4BDCE86A3A9CCA16B55A5A8D8D37"][self.pers["_encstr_91E416B90ECA8D962C8D4BDCE86A3A9CCA16B55A5A8D8D37"].size - 1];

        self.pers["_encstr_91E416B90ECA8D962C8D4BDCE86A3A9CCA16B55A5A8D8D37"][self.pers["_encstr_91E416B90ECA8D962C8D4BDCE86A3A9CCA16B55A5A8D8D37"].size] = var_7 + bot_perk_cost(var_6) + 2;
        var_1++;
      } else
        self.pers["_encstr_811A1703EA6D4F2B1F4138CB73A8956515532F317D699F57F6"][self.pers["_encstr_811A1703EA6D4F2B1F4138CB73A8956515532F317D699F57F6"].size] = var_6;
    }
  }

  if(var_2 && !isDefined(self.pers["_encstr_91E416B90ECA8D962C8D4BDCE86A3A9CCA16B55A5A8D8D37"][0])) {
    self.pers["_encstr_91E416B90ECA8D962C8D4BDCE86A3A9CCA16B55A5A8D8D37"][0] = 0;
    self.pers["_encstr_8ACE12EE4A02976029F370A8FB739BEDAAB66A76"][0] = "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249";
  }

  if(var_2 && !isDefined(self.pers["_encstr_91E416B90ECA8D962C8D4BDCE86A3A9CCA16B55A5A8D8D37"][1])) {
    self.pers["_encstr_91E416B90ECA8D962C8D4BDCE86A3A9CCA16B55A5A8D8D37"][1] = self.pers["_encstr_91E416B90ECA8D962C8D4BDCE86A3A9CCA16B55A5A8D8D37"][0];
    self.pers["_encstr_8ACE12EE4A02976029F370A8FB739BEDAAB66A76"][1] = "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249";
  }

  if(var_2 && !isDefined(self.pers["_encstr_91E416B90ECA8D962C8D4BDCE86A3A9CCA16B55A5A8D8D37"][2])) {
    self.pers["_encstr_91E416B90ECA8D962C8D4BDCE86A3A9CCA16B55A5A8D8D37"][2] = self.pers["_encstr_91E416B90ECA8D962C8D4BDCE86A3A9CCA16B55A5A8D8D37"][1];
    self.pers["_encstr_8ACE12EE4A02976029F370A8FB739BEDAAB66A76"][2] = "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249";
  }

  return var_0;
}

deactivategastrap(var_0) {
  if(isusingmatchrulesdata()) {
    if(var_0["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] == "_encstr_8BBA05185F8B99")
      return 1;
  }

  return 0;
}

bot_setup_loadout_callback() {
  var_0 = bot_loadout_get_archetype();
  var_1 = self botgetpersonality();
  var_2 = bot_loadout_get_difficulty();
  var_3 = bot_loadout_set(var_0, var_1, var_2, 0);

  if(isDefined(var_3) && isDefined(var_3.loadouts) && var_3.loadouts.size > 0) {
    self.classcallback = ::bot_loadout_class_callback;
    return 1;
  }

  var_4 = getsubstr(self.name, 0, self.name.size - 10);
  self.classcallback = undefined;
  return 0;
}

bot_loadout_make_index(var_0, var_1, var_2) {
  return var_0 + "_encstr_BA4C02DF" + var_1 + "_encstr_BA4C02DF" + var_2;
}

deactive_trophy_protection() {}
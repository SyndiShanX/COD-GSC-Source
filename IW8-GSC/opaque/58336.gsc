/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58336.gsc
***********************************************/

claymore_crate_use(var_0, var_1) {
  if(claymore_crate_spawn(var_1)) {
    clean_up_vandalize(var_1);

    if(!circlesettingsassert(var_0, var_1))
      clean_up_strafe(var_1);
  }

  if(clean_up_minigun(var_0))
    claymore_stunned(var_0, var_1, 0);
}

cleanuparenamolotovs(var_0, var_1, var_2, var_3) {
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DF(var_0, var_2);
  var_5 = claymore_crate_player_at_max_ammo(var_0, var_1);
  cleanup_target_stats_thermal(var_0, var_1, var_3);
  claymore_blockdamageuntilframeend(var_1);

  if(var_4) {
    if(!var_5) {
      clean_up_steam_triggers(var_0);
      cleanup_trap_room(var_0, var_1);
    }

    if(clean_up_minigun(var_0))
      claymore_load_spawning(var_0);

    if(!classify_players_based_on_laststand(var_0))
      var_1 thread cleanup_loot_pickups(var_1, var_0);
  }
}

claymore_forceclampangles(var_0, var_1, var_2) {
  clean_up_search(var_0.cleanuplinkent, var_1, 0);
  cleanup_target_stats_thermal(var_0, var_1, var_2);
  claymore_blockdamageuntilframeend(var_1);
  var_3 = claymore_crate_player_at_max_ammo(var_0, var_1);

  if(var_3) {
    clean_up_steam_triggers(var_0);
    circleposattime(var_0);
  }
}

claymore_crate_update_hint_logic_alt(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    cleanup_target_stats(var_0);
    wait 0.5;
  }
}

cleanup_trap_room(var_0, var_1) {
  var_0.cleanupkeybindings = [];
  var_0.cleanuppropcontrolshud = var_1;
  var_0.cleanuplinkent = "_encstr_B40101";

  if(clean_up_eliminate_drone(var_0, var_1))
    cleanup_triggers(var_0, var_1, 1, 9);
  else
    cleanup_triggers(var_0, var_1, 0, 9);

  var_0.cleanupkeybindings = scripts\engine\utility::array_randomize(var_0.cleanupkeybindings);
}

cleanup_triggers(var_0, var_1, var_2, var_3) {
  for(var_4 = var_2; var_4 <= var_3; var_4++) {
    var_5 = civcontroller(var_0, var_1, var_4);

    if(isDefined(var_5) && var_5 > 1) {
      var_6 = circuitbreakerswitchesinit(var_5);

      if(var_6 != "_encstr_B40101") {
        var_0.cleanupkeybindings = scripts\engine\utility::array_add(var_0.cleanupkeybindings, var_6);
        clean_up_ents(var_0, var_5);
      }
    }
  }
}

clean_up_ents(var_0, var_1) {
  var_2 = circletestaroundplayer(var_1);

  if(var_0.cleanuplinkent == "_encstr_B40101")
    var_0.cleanuplinkent = var_2;
  else {}
}

clean_up_eliminate_drone(var_0, var_1) {
  var_2 = civcontroller(var_0, var_1, 0);
  return isDefined(var_2) && var_2 == 1;
}

civcontroller(var_0, var_1, var_2) {
  var_3 = circletimestruct(var_0);

  if(isDefined(var_3)) {
    var_4 = var_1 getplayerdata(level.loadoutsgroup, "_encstr_A97E13D0EB9813572253E03BDC5A98E3720DE3F30A", "_encstr_845115BDC7D2E3400C3F05DBA2FCE8293A530B314F0A38", var_3, "_encstr_8E60072B109FB6EAC7", var_2);
    return var_4;
  } else
    return undefined;
}

circuitbreakerswitchesinit(var_0) {
  var_1 = tablelookup("_encstr_85C018F8532FFEC88D36F3E141C670B52BCBF1A10A678098B22E", 0, var_0, 7);
  return var_1;
}

circletestaroundplayer(var_0) {
  var_1 = tablelookup("_encstr_85C018F8532FFEC88D36F3E141C670B52BCBF1A10A678098B22E", 0, var_0, 8);
  return var_1;
}

claymore_load_spawning(var_0) {
  var_1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0, 1);

  foreach(var_3 in var_1)
  claymore_stunned(var_0, var_3, 0);
}

clean_up_steam_triggers(var_0) {
  var_1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0, 1);

  foreach(var_3 in var_1)
  clean_up_search(var_0.cleanuplinkent, var_3, 0);
}

claymore_stunned(var_0, var_1, var_2) {
  var_3 = claymore_crate_player_at_max_ammo(var_0, var_1);

  if(isDefined(var_0.cleanuplinkent) && isDefined(var_0.cleanupkeybindings) && isDefined(var_1)) {
    if(isDefined(var_0.cleanuppropcontrolshud) && (var_3 || var_2 || var_1 finishzeroarrival())) {
      var_4 = circlesetup(var_0);

      if(!civilians_killed_stat_row(var_0, var_1, var_4)) {
        var_1.cleanuplinkent = var_0.cleanuplinkent;
        var_1.cleanupkeybindingsondeath = var_4;
        var_1 setplayermusicstate(var_0.cleanuplinkent, var_0.cleanupkeybindings);
      }
    }

    if(!var_3 && !var_2)
      var_1 thread clampstepbulletdamage(var_1, var_0);
  }
}

civilians_killed_stat_row(var_0, var_1, var_2) {
  if(!isDefined(var_1.cleanuplinkent))
    return 0;

  if(!isDefined(var_1.cleanupkeybindingsondeath))
    return 0;

  return var_1.cleanuplinkent == var_0.cleanuplinkent && var_1.cleanupkeybindingsondeath == var_2;
}

clean_up_search(var_0, var_1, var_2) {
  if(claymore_crate_spawn(var_1)) {
    if(isDefined(var_0) && isDefined(var_1)) {
      var_1.cleanuplinkent = undefined;
      var_1.cleanupkeybindingsondeath = undefined;
      var_1 clearoverridearchetype_code(var_0);

      if(!var_2)
        var_1 notify("_encstr_92112062851FC39781D80B3388595F4BFD97EE9CEED78AE02BF06F53F9F35913B7BB");
    }
  }
}

claymore_crate_spawn(var_0) {
  return isDefined(var_0.cleanuplinkent) && isDefined(var_0.cleanupkeybindingsondeath);
}

claymore_crate_player_at_max_ammo(var_0, var_1) {
  return isDefined(var_0.cleanuppropcontrolshud) && var_0.cleanuppropcontrolshud == var_1;
}

circleposattime(var_0) {
  var_0.cleanuppropcontrolshud = undefined;
  var_0.cleanupkeybindings = undefined;
  var_0.cleanuplinkent = undefined;
}

classify_players_based_on_laststand(var_0) {
  if(!isDefined(var_0.cleanupkeybindings))
    return 1;

  if(var_0.cleanupkeybindings.size == 0)
    return 1;

  return 0;
}

cleanup_loot_pickups(var_0, var_1) {
  var_0 notify("_encstr_BEED20EB71E082DF9681F3FB487DA7FB60C3734BD7B94BD7CC796A9236CDB37438BF");
  var_0 endon("_encstr_BEED20EB71E082DF9681F3FB487DA7FB60C3734BD7B94BD7CC796A9236CDB37438BF");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  cleanup_spawned_exposed_node(var_0);
  var_2 = civ_thread(var_0);
  cleanupallbutxcratesforteam(var_0, var_1, var_2);

  if(var_0 scripts\engine\utility::is_player_gamepad_enabled())
    var_0 notifyonplayercommand("_encstr_95BE22570E23C247AC7D262C8E47C6CAF54793B06CADCDF51DF6CE76B159AFE68E1647AC", "_encstr_A6E308B2DCE8B0B936B2");
  else
    var_0 notifyonplayercommand("_encstr_95BE22570E23C247AC7D262C8E47C6CAF54793B06CADCDF51DF6CE76B159AFE68E1647AC", "_encstr_ABC00CDC969D431D9DD2B9B4EDDC");

  for(;;) {
    var_0 waittill("_encstr_95BE22570E23C247AC7D262C8E47C6CAF54793B06CADCDF51DF6CE76B159AFE68E1647AC");
    var_3 = circletimernext(var_0);
    cleanupallbutxcratesforteam(var_0, var_1, var_3);
  }
}

cleanupallbutxcratesforteam(var_0, var_1, var_2) {
  switch (var_2) {
    case "_encstr_AB0703DBB9":
      cleanup_goal_population(var_0, var_1);
      break;
    case "_encstr_BA19049F4B2D":
      cleanup_fake_ai_on_death(var_0, var_1);
      break;
  }
}

cleanup_goal_population(var_0, var_1) {
  clean_up_func(var_0, "_encstr_AB0703DBB9");
  claymore_load_spawning(var_1);
}

cleanup_fake_ai_on_death(var_0, var_1) {
  clean_up_func(var_0, "_encstr_BA19049F4B2D");
  clean_up_steam_triggers(var_1);
}

circletimernext(var_0) {
  switch (var_0.pers["_encstr_8227186E061BB1D8351BD030BF4373B9F22F54E19F8149A10CF7"]) {
    case "_encstr_AB0703DBB9":
      return "_encstr_BA19049F4B2D";
    case "_encstr_BA19049F4B2D":
      return "_encstr_AB0703DBB9";
  }
}

cleanup_spawned_exposed_node(var_0) {
  if(!isDefined(var_0.pers["_encstr_8227186E061BB1D8351BD030BF4373B9F22F54E19F8149A10CF7"]))
    clean_up_func(var_0, "_encstr_AB0703DBB9");
}

clean_up_func(var_0, var_1) {
  var_0.pers["_encstr_8227186E061BB1D8351BD030BF4373B9F22F54E19F8149A10CF7"] = var_1;
  var_2 = var_0 calloutmarkerping_entityzoffset("_encstr_A3B62283F021AE82FB774B3F599D5AF579FBFA0E296853F9CD3F572F41CD913B8821F397");

  switch (var_1) {
    case "_encstr_AB0703DBB9":
      var_0 setclientomnvar("_encstr_A3B62283F021AE82FB774B3F599D5AF579FBFA0E296853F9CD3F572F41CD913B8821F397", 1);
      break;
    case "_encstr_BA19049F4B2D":
      var_0 setclientomnvar("_encstr_A3B62283F021AE82FB774B3F599D5AF579FBFA0E296853F9CD3F572F41CD913B8821F397", 2);
      break;
  }
}

claymore_blockdamageuntilframeend(var_0) {
  if(isDefined(var_0)) {
    var_1 = var_0 calloutmarkerping_entityzoffset("_encstr_A3B62283F021AE82FB774B3F599D5AF579FBFA0E296853F9CD3F572F41CD913B8821F397");
    var_0 setclientomnvar("_encstr_A3B62283F021AE82FB774B3F599D5AF579FBFA0E296853F9CD3F572F41CD913B8821F397", 0);
  }
}

civ_thread(var_0) {
  return var_0.pers["_encstr_8227186E061BB1D8351BD030BF4373B9F22F54E19F8149A10CF7"];
}

cleanup_lights(var_0, var_1) {
  return isDefined(var_0.pers["_encstr_8227186E061BB1D8351BD030BF4373B9F22F54E19F8149A10CF7"]) && var_0.pers["_encstr_8227186E061BB1D8351BD030BF4373B9F22F54E19F8149A10CF7"] == var_1;
}

cleanup_target_stats_thermal(var_0, var_1, var_2) {
  var_3 = isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DF(var_0, var_2);

  if(var_3)
    var_1 cleanup_corpses(var_1);
}

cleanup_corpses(var_0) {
  var_0 notify("_encstr_BEED20EB71E082DF9681F3FB487DA7FB60C3734BD7B94BD7CC796A9236CDB37438BF");
}

civ_death() {
  var_0 = level.gametype;

  if(var_0 == "_encstr_B607038AAB") {
    var_1 = getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101");

    if(var_1 != "_encstr_B40101")
      return var_1;
  }

  return var_0;
}

clean_up_minigun(var_0) {
  if(civ_death() == "_encstr_91070301C2")
    return 0;

  if(classify_players_based_on_laststand(var_0))
    return 0;

  if(isDefined(var_0.cleanuppropcontrolshud) && cleanup_lights(var_0.cleanuppropcontrolshud, "_encstr_BA19049F4B2D"))
    return 0;

  return 1;
}

circletimestruct(var_0) {
  switch (var_0.targetname) {
    case "_encstr_86510C82737817CD40B38B720A15":
      return "_encstr_8C1904676089";
    case "_encstr_8C190467402B":
      return "_encstr_8C190467402B";
    case "_encstr_BAC20FBEE6F88945F163A37BD68409923B":
    case "_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6":
      return "_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6";
    case "_encstr_85DE05A6B2AC0E":
      return "_encstr_85DE05A6B2AC0E";
    case "_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F":
    case "_encstr_9A8F0CB1A5E8471BB2EB894B39C8":
      return "_encstr_9A8F0CB1A5E8471BB2EB894B39C8";
    case "_encstr_9A120A1D8536F5E4ED3BB293":
      return "_encstr_9A120A1D8536F5E4ED3BB293";
    case "_encstr_AF390B295782C3585F1B21D8C4":
      if(isDefined(var_0.spawndata.usealtmodel))
        return "_encstr_967E0A830E45C7671D993353";
      else
        return "_encstr_A9F00A8E85CD6DEBBBCAE6D1";
    case "_encstr_99C20BA548E9F27A61D897932B":
      return "_encstr_99C20BA548E9F27A61D897932B";
    case "_encstr_91F511673FA9BB292DD8BAE321179E73A328F3":
      return "_encstr_91F511673FA9BB292DD8BAE321179E73A328F3";
    default:
      return undefined;
  }
}

cleanup_target_stats(var_0) {
  var_1 = var_0 getmovingplatformparent();

  if(clean_up_laser_trap_ents(var_1, var_0)) {
    var_0 thread clean_up_rocket(var_1, var_0);

    if(!clean_up_none(var_1, var_0)) {
      clean_up_strafe(var_0);
      claymoreshitby(var_1, var_0);
    }
  }
}

claymoreshitby(var_0, var_1) {
  claymore_stunned(var_0, var_1, 0);
}

clean_up_strafe(var_0) {
  if(claymore_crate_spawn(var_0)) {
    clean_up_vandalize(var_0);
    clean_up_steam(var_0);
  }
}

clean_up_vandalize(var_0) {
  var_0 notify("_encstr_9BAC278916A31DB1CAAFD1392C1BD637FACD8E2CCDC8969BB33DB9B256D0D2C636CA8AB4B62BEDBAE8");
}

clean_up_rocket(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 notify("_encstr_9BAC278916A31DB1CAAFD1392C1BD637FACD8E2CCDC8969BB33DB9B256D0D2C636CA8AB4B62BEDBAE8");
  var_1 endon("_encstr_9BAC278916A31DB1CAAFD1392C1BD637FACD8E2CCDC8969BB33DB9B256D0D2C636CA8AB4B62BEDBAE8");
  wait 1;
  clean_up_steam(var_1);
}

clampstepbulletdamage(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_92112062851FC39781D80B3388595F4BFD97EE9CEED78AE02BF06F53F9F35913B7BB");
  var_2 = var_0 finishzeroarrival();

  for(;;) {
    wait 0.5;
    var_3 = var_0 finishzeroarrival();

    if(var_3 != var_2) {
      if(var_3) {
        if(clean_up_minigun(var_1))
          claymore_stunned(var_1, var_0, 1);
      } else
        clean_up_search(var_1.cleanuplinkent, var_0, 1);

      var_2 = var_3;
    }
  }
}

clean_up_steam(var_0) {
  clean_up_search(var_0.cleanuplinkent, var_0, 0);
}

clean_up_laser_trap_ents(var_0, var_1) {
  if(!isDefined(var_0))
    return 0;

  if(!var_0 scripts\cp_mp\vehicles\vehicle::isvehicle())
    return 0;

  if(!cleanupallclones(var_0))
    return 0;

  if(!scripts\cp_mp\vehicles\vehicle::_id_141B9(var_0, var_1))
    return 0;

  if(!clean_up_minigun(var_0))
    return 0;

  if(!clean_and_spawn_carriables(var_0, var_1))
    return 0;

  return 1;
}

clean_up_none(var_0, var_1) {
  if(!isDefined(var_1.cleanupkeybindingsondeath))
    return 0;

  var_2 = circlesetup(var_0);
  return var_2 == var_1.cleanupkeybindingsondeath;
}

circlesettingsassert(var_0, var_1) {
  if(classify_players_based_on_laststand(var_0))
    return 0;

  return clean_up_none(var_0, var_1);
}

circlesetup(var_0) {
  var_1 = var_0 getentitynumber() + "_encstr_B40101";
  var_2 = var_0.cleanuppropcontrolshud getentitynumber() + "_encstr_B40101";
  return var_1 + var_2;
}

clean_and_spawn_carriables(var_0, var_1) {
  switch (var_0.targetname) {
    case "_encstr_BAC20FBEE6F88945F163A37BD68409923B":
    case "_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6":
      return _calloutmarkerping_handleluinotify_enemyrepinged::updatelocationbesttime(var_1, var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", -85, 0, 77, 185, 125, 40);
    default:
      return 0;
  }
}

cleanupallclones(var_0) {
  if(isDefined(var_0.targetname)) {
    switch (var_0.targetname) {
      case "_encstr_BAC20FBEE6F88945F163A37BD68409923B":
      case "_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6":
        return 1;
      default:
        return 0;
    }
  } else
    return 0;
}
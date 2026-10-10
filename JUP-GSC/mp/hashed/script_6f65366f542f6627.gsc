/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6f65366f542f6627.gsc
*************************************************/

#using script_220d0eb95a8fab7d;
#using script_2707474774db34b;
#using script_2f11ea014b8bb8eb;
#using script_41387eecc35b88bf;
#using script_443d99fe707f1d9f;
#using script_485622d93fa7e4cf;
#using script_4a6760982b403bad;
#using script_4e6e58ab5d96c2b0;
#using script_55221d469e7b320e;
#using script_62a4f7a62643fe8;
#using script_638d701d263ee1ed;
#using script_6bffae1b97f70547;
#using script_6fc415ff6a905dc1;
#using script_749ff6f56673a813;
#using script_7c875a4a27280806;
#using script_7edf952f8921aa6b;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\currency;
#using scripts\cp_mp\gasmask;
#using scripts\cp_mp\laststand;
#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\pack_a_punch;
#using scripts\cp_mp\squads;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\cp_mp\weapon;
#using scripts\cp_mp\zombie_perks;
#using scripts\engine\throttle;
#using scripts\engine\utility;
#using scripts\mp\equipment;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\br_spectate;
#using scripts\mp\gametypes\ob;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\outofbounds;
#using scripts\mp\perks\perks;
#using scripts\mp\playerlogic;
#using scripts\mp\rank;
#using scripts\mp\scoreboard;
#using scripts\mp\utility\game;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\teams;
#namespace ob_exfil;

function function_3afebc739584a9a() {
  level.var_7cc298fa98ce0c7a = &"SHARED_HINTSTRINGS/EXFIL_START_USE_OB";
  level.var_132e390bddaa01b5 = &scripts\mp\globallogic::blank;
  level.var_3a96331857b5f453 = "EXFIL_OB";
  level.var_f823a30649b48284 = "exfil_activity_ob_definition";
  namespace_9f6a961447bab709::init_exfil();
  thread namespace_bbc151ced3ff8d46::function_751a7af62e6ae0c7();
  level.var_9f9cd6f82b781bde = &function_8b3122340fe584c7;
  level.var_78e0845802741355 = &function_161a9b230a5d1a5e;
  level.var_d8b6115a502e7e76 = &function_9c4759ff6fd51461;
  level.var_35aa4c6db25e81ae = &function_5cef4bea938b2113;
  level.var_38452d51edfb282c = &function_c33400a035a1225d;
  level.var_8873839ca6498959 = &function_22fb8021077168e4;
  level.var_5924b0bd99878b50 = &function_57d6dd6c67840c1f;
  level.var_8c38c7d9dbe77e4 = throttle_initialize("ob_exfil_player", 1, level.framedurationseconds * 3);
  level.var_40e72101aaba1098 = 1;
  callback::add("on_exfil_player_joined", &function_15b6a0884be537b);
  callback::add("on_exfil_player_failure", &function_7d4d9ab56ec899d4);
  callback::add("on_exfil_player_available", &function_8bde2e5e6f81bef5);
  callback::add("on_exfil_ai_spawned", &on_exfil_ai_spawned);
  callback::add("on_exfil_vehicle_spawned", &on_exfil_vehicle_spawned);

  if(istrue(getdvarint(@ "hash_77f6de1d536c1ca1", 1))) {
    callback::add("player_connect", &function_a740433902d7fab1);
    callback::add("player_spawned", &function_a44817e31981b6f1);
    scripts\mp\perks\perks::registerscriptperk("specialty_exfil_contract_percent_reward");
    scripts\mp\perks\perks::registerscriptperk("specialty_exfil_perk_percent_reward");
    scripts\mp\perks\perks::registerscriptperk("specialty_exfil_pap_percent_reward");
    scripts\mp\perks\perks::registerscriptperk("specialty_exfil_mystery_box_percent_reward");
  }

  utility::registersharedfunc("instanceInventory", "isMapToMapExfil", &function_9487b6b2ba44f9db);
  function_8b5b2a3392fc7e2a("ActivityBegin", &function_e2ccdedfebf9e5b1, "REV_OB_EXFIL");

  level thread function_9a3a196103b06cb2();
}

function function_9a3a196103b06cb2() {
  flag_wait("<dev string:x1c>");
  function_6e7290c8ee4f558b("<dev string:x32>");
  function_a9a864379a098ad6("<dev string:x58>", "<dev string:x6d>", &function_4d67fac937774abe);
  function_fe953f000498048f();
}

function function_4d67fac937774abe(params) {
  var_a3ed94a321cc4d1a = getdvarint(@ "hash_bc321023e9100f4", 0);
  setDvar(@ "hash_bc321023e9100f4", !var_a3ed94a321cc4d1a);
}

function function_57d6dd6c67840c1f() {
  return getdvarint(@ "hash_d74ba37ba5c227b0", 1);
}

function function_c33400a035a1225d(s_exfil, player_activator) {
  var_c9b69aecc5c631ed = player_activator scripts\cp_mp\utility\squad_utility::getsquadmembers(undefined, 1);
  s_exfil.var_953c0bb9dec80174 = [player_activator];

  foreach(squad_member in var_c9b69aecc5c631ed) {
    if(isDefined(squad_member.s_exfil) && isDefined(squad_member.s_exfil.var_18da16a5ee3e8314)) {
      if(squad_member == player_activator) {
        player_activator namespace_9f6a961447bab709::function_f246f550360cbdbb();
        s_exfil.var_953c0bb9dec80174 = function_6d6af8144a5131f1(s_exfil.var_953c0bb9dec80174, player_activator);
      }

      continue;
    }

    s_exfil.var_953c0bb9dec80174 = function_6d6af8144a5131f1(s_exfil.var_953c0bb9dec80174, squad_member);
  }

  s_exfil.var_c9164736baf0694a = s_exfil.var_953c0bb9dec80174;

  foreach(player in s_exfil.var_c9164736baf0694a) {
    namespace_d886885225a713a7::function_bbdcd857d0c2a65e(s_exfil.var_18da16a5ee3e8314, player);
    player.s_exfil = s_exfil;
  }

  callback::callback("on_exfil_player_available", s_exfil);
  array_thread(s_exfil.var_c9164736baf0694a, &scripts\mp\hud_message::showsplash, "cp_mp_exfil_inbound");
  wait 2;
}

function function_22fb8021077168e4(var_2fb66334569ccc48) {
  if(getdvarint(@ "hash_3dd989b5ea61ba6f", 1) == 0) {
    return [[level.var_c383b967aa7e551b]]("exfil", var_2fb66334569ccc48);
  }

  utility::flag_wait("aether_storm_initialized");

  if(level.aether_storm.var_719deb8a1a45bb85) {
    return [[level.var_c383b967aa7e551b]]("exfil", var_2fb66334569ccc48);
  }

  var_37b57f82052b28fe = namespace_faa32e45e1d64c2::function_7bf6e6f83216f4bd();
  var_8d1fe1927c807ad3 = (level.aether_storm.expansion_radius - level.aether_storm.starting_radius) / level.aether_storm.var_3f24322be8ae1969;
  var_6a210603df7a6c21 = level.aether_storm.var_647bf2cbf73994dd;
  var_6a210603df7a6c21 -= level.aether_storm.var_be0e041e85848a6d;
  var_6a210603df7a6c21 -= getdvarint(@ "hash_eb873c5e99093d11", 50);
  var_6a210603df7a6c21 -= getdvarint(@ "hash_346baccb7a031727", 7);
  var_1f64da304df07bac = [];

  foreach(s_exfil in var_2fb66334569ccc48) {
    if(s_exfil == var_37b57f82052b28fe) {
      continue;
    }

    var_9c0939a3d83555cf = distance2d(s_exfil.origin, level.aether_storm.starting_origin);
    var_a70ff023d1ffa590 = (var_9c0939a3d83555cf - level.aether_storm.starting_radius) / var_8d1fe1927c807ad3;

    if(var_a70ff023d1ffa590 >= var_6a210603df7a6c21) {
      continue;
    }

    if(isDefined(s_exfil.script_parameters) && s_exfil.script_parameters == "disabled") {
      continue;
    }

    var_1f64da304df07bac[var_1f64da304df07bac.size] = s_exfil;
  }

  return [[level.var_c383b967aa7e551b]]("exfil", var_1f64da304df07bac);
}

function function_9c4759ff6fd51461(player) {
  if(isDefined(self.s_exfil) && istrue(self.s_exfil.b_disabled)) {
    return false;
  }

  if(getdvarint(@ "hash_bc321023e9100f4", 0) || namespace_9f6a961447bab709::function_8d3b8265c47a2223()) {
    return true;
  }

  if(!namespace_cde84ab88f41f1a5::function_6152021549f1836b(player)) {
    return false;
  }

  var_5ba582db1213daa8 = namespace_cde84ab88f41f1a5::function_1c121cfcda39970d(player);
  var_7f92c5f0b69fd724 = 0;

  foreach(var_180e04406de3e180 in var_5ba582db1213daa8) {
    if(istrue(var_180e04406de3e180.success)) {
      var_7f92c5f0b69fd724++;
    }
  }

  if(var_7f92c5f0b69fd724 > 0) {
    return true;
  }

  return false;
}

function function_5cef4bea938b2113(s_exfil, var_6d94a1f3678a98a6) {
  if(getdvarint(@ "hash_37e686acc7d62c47", 0)) {
    return undefined;
  }

  str_difficulty = namespace_4df2ab39b0e96ec7::function_4d8bb2d866771a10(s_exfil.s_exfil_destination.origin);
  var_cad2ff0bf935f3d4 = namespace_9f6a961447bab709::function_7d45a9e5bf7a3d3e(s_exfil);

  if(istrue(var_6d94a1f3678a98a6)) {
    switch (str_difficulty) {
      case #"hash_7bb2cd766703d463":
      case #"hash_a1e09f51896088fb":
      default:
        s_exfil.var_1d39d0784b73d713 = 1;
        s_exfil.var_2744fe7a1690ec17 = 1;
        return ("ai_flood_fill_encounter:" + var_cad2ff0bf935f3d4.var_a015d197dcc7df7);
      case #"hash_af83e47edfa8900a":
        s_exfil.var_1d39d0784b73d713 = 2;
        s_exfil.var_2744fe7a1690ec17 = 1;
        return ("ai_flood_fill_encounter:" + var_cad2ff0bf935f3d4.var_b5560d38a020358c);
      case #"hash_5343b465e56ec9a4":
        s_exfil.var_1d39d0784b73d713 = 3;
        s_exfil.var_2744fe7a1690ec17 = 2;
        return ("ai_flood_fill_encounter:" + var_cad2ff0bf935f3d4.var_595400899d6d9546);
      case #"hash_651f76c0ad6741ec":
        s_exfil.var_1d39d0784b73d713 = 3;
        s_exfil.var_2744fe7a1690ec17 = 2;
        return ("ai_flood_fill_encounter:" + var_cad2ff0bf935f3d4.var_20e1f41a589541eb);
    }

    return;
  }

  switch (str_difficulty) {
    case #"hash_7bb2cd766703d463":
    case #"hash_a1e09f51896088fb":
    default:
      s_exfil.var_1d39d0784b73d713 = 1;
      s_exfil.var_2744fe7a1690ec17 = 1;
      return ("ai_flood_fill_encounter:" + var_cad2ff0bf935f3d4.var_558ecf015b891ba2);
    case #"hash_af83e47edfa8900a":
      s_exfil.var_1d39d0784b73d713 = 2;
      s_exfil.var_2744fe7a1690ec17 = 1;
      return ("ai_flood_fill_encounter:" + var_cad2ff0bf935f3d4.var_d4e9b427c8b60937);
    case #"hash_5343b465e56ec9a4":
      s_exfil.var_1d39d0784b73d713 = 3;
      s_exfil.var_2744fe7a1690ec17 = 2;
      return ("ai_flood_fill_encounter:" + var_cad2ff0bf935f3d4.var_6df3a308b274e929);
    case #"hash_651f76c0ad6741ec":
      s_exfil.var_1d39d0784b73d713 = 3;
      s_exfil.var_2744fe7a1690ec17 = 2;
      return ("ai_flood_fill_encounter:" + var_cad2ff0bf935f3d4.var_6e4ab8cd1b3d7322);
  }
}

function function_8b3122340fe584c7() {
  if(percent_chance(10)) {
    return "actor_jup_spawner_zombie_base_armored_heavy";
  }

  return "actor_jup_spawner_zombie_base";
}

function on_exfil_ai_spawned(params) {
  new_health = getdvarint(@ "hash_30b03a2625dd852c", -1);

  if(new_health > 0) {
    self.health = new_health;
  }

  if(self.basearchetype == "zombie_base") {
    str_difficulty = namespace_4df2ab39b0e96ec7::function_4d8bb2d866771a10(self.origin);

    switch (str_difficulty) {
      case #"hash_7bb2cd766703d463":
        if(percent_chance(20)) {
          str_speed = "sprint";
        }

        break;
      case #"hash_af83e47edfa8900a":
        if(percent_chance(35)) {
          str_speed = "sprint";
        }

        break;
      default:
        break;
    }

    if(isDefined(str_speed)) {
      function_f1e5805da192a1ef(str_speed, "exfil", 24);
    }

    if(isPlayer(self.exfil_player) && isalive(self.exfil_player) && !scripts\mp\utility\player::isinlaststand(self.exfil_player)) {
      self aieventlistenerevent("combat", self.exfil_player, self.exfil_player.origin);
    }
  }
}

function on_exfil_vehicle_spawned(params) {
  if(getdvarint(@ "hash_37aa7620b893be20", 1) != 0) {
    self.var_102945aa439b7b3d = 1;
  }
}

function function_161a9b230a5d1a5e(player, var_83212420e39bdbc2) {
  if(!isDefined(var_83212420e39bdbc2)) {
    var_83212420e39bdbc2 = 0;
  }

  player endon("disconnect");
  assertex(!isDefined(player.exfilpos), "<dev string:x85>");
  s_exfil = player.s_exfil;
  var_576f57af0204c38c = isDefined(player.s_exfil.var_576f57af0204c38c) ? player.s_exfil.var_576f57af0204c38c : player.var_cac91eb6521df629;
  player val::set("exfil", "damage", 0);
  player.var_65be3afaddfe3a79 = 1;
  player setplayerdata(level.var_5d69837cf4db0407, "currentSessionStreakCount", player.var_4b8e8742f0763613.var_ae06e623319b2568);

  if(!istrue(player.var_764da0de2a46452c)) {
    wait 2.5;

    if(namespace_9f6a961447bab709::function_18a23b9f6568641e() && isDefined(var_576f57af0204c38c)) {
      wait getdvarfloat(@ "hash_1862302145751eaf", 13);
    }
  }

  s_exfil notify("exfil_vehicle_gone");
  player.var_65be3afaddfe3a79 = undefined;
  player setplayerdata(level.var_5d69837cf4db0407, "currentSessionStreakCount", 0);

  if(isDefined(var_576f57af0204c38c) && !istrue(player.var_68b9486f4adbcb62)) {
    logstring("==OB EXFIL: " + player.name + " jumped out of exfil vehicle for " + s_exfil.name + " after vehicle started leaving");
    player.var_f52eb40ba99ffa4c = undefined;
    player.var_f7b106ebc7f3abf0 = undefined;
    player.var_764da0de2a46452c = undefined;
    player val::reset("exfil", "damage");
    player setplayermusicstate("");

    if(scripts\mp\outofbounds::isoobimmune(player)) {
      scripts\mp\outofbounds::disableoobimmunity(player);
    }

    return;
  }

  var_1a32758b940764f4 = 1;

  foreach(other_player in level.players) {
    if(!istrue(other_player.var_f52eb40ba99ffa4c) && ob_laststand::function_f3645fa4bfb45a97(other_player)) {
      var_1a32758b940764f4 = 0;
      break;
    }
  }

  if(scripts\mp\utility\player::isinlaststand(player)) {
    player scripts\cp_mp\laststand::finishreviveplayer("self_revive_success", player);
  }

  player callback::callback("ob_exfil_success", s_exfil);
  var_a6b3fae0395f75c3 = "none";

  if(var_83212420e39bdbc2) {
    var_a6b3fae0395f75c3 = "rift_run";
  } else if(isDefined(s_exfil.instance) && isDefined(s_exfil.instance.script_noteworthy)) {
    var_a6b3fae0395f75c3 = s_exfil.instance.script_noteworthy;
  }

  if(istrue(getdvarint(@ "hash_77f6de1d536c1ca1", 1))) {
    player function_86924395ad6e3c5e();
  }

  function_46f56bf948599140(player, var_a6b3fae0395f75c3);

  if(isDefined(s_exfil.instance) && is_equal(s_exfil.instance.script_noteworthy, "quest_exfil")) {
    logstring("quest exfil checking for players");
    var_16e8ded086d83144 = player scripts\cp_mp\utility\squad_utility::getsquadmembers(undefined, 1);

    foreach(squad_member in var_16e8ded086d83144) {
      if(isDefined(s_exfil.str_mission) && namespace_bbc151ced3ff8d46::function_587db41e9361a424(squad_member, s_exfil.str_mission) && var_576f57af0204c38c namespace_bbc151ced3ff8d46::function_c80b9a252474413b(squad_member)) {
        player.var_ec0caef5c0691992 = 1;

        if(!array_contains(level.var_9ec4962076db301b[s_exfil.str_mission].eligible_players, player)) {
          level.var_9ec4962076db301b[s_exfil.str_mission].eligible_players[level.var_9ec4962076db301b[s_exfil.str_mission].eligible_players.size] = player;
        }
      }
    }
  }

  if(isDefined(s_exfil.instance) && is_equal(s_exfil.instance.script_noteworthy, "quest_exfil") && istrue(player.var_ec0caef5c0691992)) {
    if(function_7bfb1ccacdacfd26()) {
      mapname = scripts\cp_mp\utility\game_utility::getmapname();
      logstring("quest exfil initiated in map " + mapname);
      player thread namespace_b3f32c8cb80b8124::function_5751d00ce46557da(1, 1);
      player ob::function_865b1a5a62c49d7(1);
      params = spawnStruct();
      params.player = player;
      params.exfil_chopper = var_576f57af0204c38c;
      params.s_exfil = s_exfil;
      level callback::callback("quest_exfil_complete", params);
      function_f9a207358d70923c(getdvarint(@ "hash_337167177f9034b4", 8), ["exfil_fully_completed"], &function_a5426cbe311426c0, player, s_exfil, var_1a32758b940764f4);
      return;
    } else {
      logstring("Trying to quest exfil from " + (isDefined(s_exfil.name) ? s_exfil.name : "") + " but ob_map_transition_playlist dvar is disabled!");
    }
  }

  thread function_a5426cbe311426c0(player, s_exfil, var_1a32758b940764f4);
}

function function_a5426cbe311426c0(player, s_exfil, var_1a32758b940764f4) {
  if(!isDefined(player)) {
    return;
  }

  player endon("disconnect");
  player thread namespace_b3f32c8cb80b8124::function_5751d00ce46557da(1);
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 1, 0.25);
  player.exfilpos = player.origin;
  wait 0.25;
  throttle::function_f632348cbb773537(level.var_8c38c7d9dbe77e4, player);

  if(isDefined(level.var_db80981879714f15)) {
    player.exfilpos = player[[level.var_db80981879714f15]]();
  }

  player val::set("exfil", "crouch", 0);
  player val::set("exfil", "gesture", 0);
  player val::set("exfil", "allow_jump", 0);
  player val::set("exfil", "killstreaks", 0);
  player val::set("exfil", "melee", 0);
  player val::set("exfil", "offhand_weapons", 0);
  player val::set("exfil", "prone", 0);
  player val::set("exfil", "sprint", 0);
  player val::set("exfil", "supers", 0);
  player val::set("exfil", "usability", 0);
  player val::set("exfil", "weapon", 0);
  player val::set("exfil", "allow_movement", 0);
  player val::set("exfil", "fire", 0);
  player val::set("exfil", "weapon_switch", 0);
  player val::set("exfil", "ignoreme", 1);
  player freezecontrols(1);
  player playerhide();
  player function_30f809c426b6a126();
  function_edff661c569fa3bc(player);
  ob::function_4ce64226f67749c4(player);

  if(isDefined(level.var_4b90dae6c1d817ee) && istrue(level.var_4b90dae6c1d817ee[player.team])) {
    player setclientomnvar("ui_dmz_extract_successful", 2);
  } else {
    fullyextracted = 1;
    var_c9b69aecc5c631ed = player scripts\cp_mp\utility\squad_utility::getsquadmembers();

    foreach(squad_member in var_c9b69aecc5c631ed) {
      if(!istrue(squad_member.var_f52eb40ba99ffa4c)) {
        fullyextracted = 0;
        break;
      }
    }

    if(fullyextracted) {
      if(!isDefined(level.var_4b90dae6c1d817ee)) {
        level.var_4b90dae6c1d817ee = [];
      }

      level.var_4b90dae6c1d817ee[player.team] = 1;
      player setclientomnvar("ui_dmz_extract_successful", 2);
    } else {
      player setclientomnvar("ui_dmz_extract_successful", 1);
    }
  }

  player.var_941b48d7c0cb685b = 1;
  waitframe();

  if(function_a6172e49f7313fd8()) {
    player function_6aa0d0467dfd4624(1);
    player function_80c587026fbc6e0d();
  } else {
    player function_f34b9a983ed02221();
    player scripts\cp_mp\loot\common_inventory::function_389d4cd85d174957();
  }

  waitframe();

  if(issharedfuncdefined("seasonalevents", "getFeaturedLootEventActive")) {
    if(function_f3bb4f4911a1beb2("seasonalevents", "getFeaturedLootEventActive")) {
      function_af5ab021b625cdf8(player);
    }
  }

  player ob::function_865b1a5a62c49d7(1);
  player callback::callback("exfil_success");
  scripts\mp\gamelogic::processlobbydataforclient(player);
  scripts\mp\scoreboard::processcommonplayerdataforplayer(player);
  processlobbydata();
  player namespace_7177e11e3871c8f4::function_1b6b6e760a1bdd78();
  level.skipplaybodycountsound = 1;
  spawnpoint = spawnStruct();
  spawnpoint.origin = player.exfilpos;
  spawnpoint.angles = player.angles;
  player scripts\mp\playerlogic::removefromalivecount(1);
  scripts\mp\utility\teams::validatealivecount("extract", player.team, player);

  if(isDefined(level.var_4b90dae6c1d817ee) && istrue(level.var_4b90dae6c1d817ee[player.team])) {
    if(isDefined(player.exfilpos)) {
      player scripts\mp\playerlogic::spawnintermission(spawnpoint, undefined, 0);
    } else {
      player scripts\mp\gametypes\br_spectate::spawnintermissionatplayer(player);
    }
  } else {
    player thread scripts\mp\playerlogic::spawnspectator(spawnpoint.origin, spawnpoint.angles, var_1a32758b940764f4);
  }

  var_c9b69aecc5c631ed = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
  var_16e8ded086d83144 = player scripts\cp_mp\utility\squad_utility::getsquadmembers(undefined, 1);

  if(!isDefined(var_16e8ded086d83144) || var_16e8ded086d83144.size == 0) {
    thread scripts\mp\gametypes\ob::onsquadeliminated(var_c9b69aecc5c631ed, !var_1a32758b940764f4);
  }

  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 0, 1);
  player setclientomnvar("ui_br_squad_eliminated_active", 1);
  player setclientomnvar("ui_round_end_title", game["round_end"]["victory"]);
  player setclientomnvar("ui_round_end_reason", game["end_reason"]["objective_completed"]);
  player setclientomnvar("ui_disable_inventory", 1);

  if(isDefined(player.matchbonus)) {
    player setclientomnvar("ui_round_end_match_bonus", player.matchbonus);
  }

  player setclientdvar(@ "hash_cbb22e2fb1a57873", 1);

  if(getdvarint(@ "hash_c68e810840841e3a", 0)) {
    player thread function_a7b7a88c16c74042();
  }

  player notify("exfil_fully_completed");
  self notify("exfil_fully_completed");
}

function function_a7b7a88c16c74042() {
  self endon("disconnect");
  wait 2;
  scripts\cp_mp\squads::leavesquad(self.team, self.sessionsquadid);
}

function function_15b6a0884be537b(s_exfil) {}

function function_7d4d9ab56ec899d4(s_exfil) {}

function function_8bde2e5e6f81bef5(s_exfil) {}

function function_a44817e31981b6f1(s_exfil) {
  self endon("<dev string:xa9>");
  var_3352bf952cfc182a = self.name;
  function_6e7290c8ee4f558b("<dev string:xb2>" + var_3352bf952cfc182a + "<dev string:xc9>");
  function_b23a59dfb4ca49a1("<dev string:xce>", "<dev string:xf7>" + var_3352bf952cfc182a + "<dev string:x119>", &function_6c6bfa8bc42fad46);
  function_b23a59dfb4ca49a1("<dev string:x11e>", "<dev string:x148>" + var_3352bf952cfc182a + "<dev string:x119>", &function_730c1d563a35c043);
  function_fe953f000498048f();
}

function function_a740433902d7fab1(s_exfil) {
  thread function_54eab82244c83ff6();
}

function processlobbydata() {
  if(getdvarint(@ "online_mp_clientmatchdata_enabled") != 0) {
    if(matchmakinggame() && !privatematch()) {
      setclientmatchdata("isPublicMatch", 1);
    } else {
      setclientmatchdata("isPublicMatch", 0);
    }

    sendclientmatchdata();
  }
}

function function_30f809c426b6a126() {
  backpacksize = function_1b35b10884bd8d67();
  backpackweapon = function_e2b4c63cab73c1f1();
  weaponslist = self getweaponslistprimaries();

  for(i = 0; i < backpacksize; i++) {
    lootid = function_d870b2c45335bd88(i);
    params = spawnStruct();
    params.lootid = lootid;
    callback::callback("item_exfiled", params);
  }

  foreach(weapon in weaponslist) {
    if(isweapon(weapon)) {
      lootid = weapon::function_89a83ae9a4c4142a(weapon);

      if(isDefined(lootid)) {
        params = spawnStruct();
        params.weapon = weapon;
        params.lootid = lootid;
        callback::callback("weapon_exfiled", params);
      }
    }
  }
}

function function_f34b9a983ed02221() {
  if(!isDefined(level.var_ee6237adc007b5f5)) {
    function_975c9e149cb01216();
  }

  backpacksize = function_1b35b10884bd8d67();
  backpackweapon = function_e2b4c63cab73c1f1();

  if(isDefined(backpackweapon)) {
    itembundle = function_2c85d7675de2e251(backpackweapon);

    if(isDefined(itembundle)) {
      lootid = function_6d15e119c2779a93(itembundle);
      function_d56bb02626a9d806(lootid);
    }

    if(isDefined(lootid) && lootid) {
      namespace_512200f0f9e6ebc9::function_c324d060cde743e3(lootid, 1);
    }
  }

  weaponslist = self getweaponslistprimaries();

  foreach(weapon in weaponslist) {
    variantid = weapon.variantid;

    if(!isDefined(weapon.variantid)) {
      variantid = 0;
    }

    rootname = scripts\cp_mp\weapon::getweaponrootname(weapon);
    ref = rootname;

    if(variantid) {
      ref = rootname + "_v" + variantid;
    }

    lootid = function_2c836ad05e5f634c(ref);
    function_d56bb02626a9d806(lootid);

    if(isDefined(lootid) && lootid) {
      namespace_512200f0f9e6ebc9::function_c324d060cde743e3(lootid, 1);
    }
  }

  callbacks = function_cca8bbe88a39ad41("tactical");
  [itembundle, quantity] = self[[callbacks.var_df9b308efe82294a]]();

  if(isDefined(itembundle)) {
    lootid = function_6d15e119c2779a93(itembundle);
    function_d56bb02626a9d806(lootid);
  }

  callbacks = function_cca8bbe88a39ad41("lethal");
  [itembundle, quantity] = self[[callbacks.var_df9b308efe82294a]]();

  if(isDefined(itembundle)) {
    lootid = function_6d15e119c2779a93(itembundle);
    function_d56bb02626a9d806(lootid);
  }

  callbacks = function_cca8bbe88a39ad41("super");
  [itembundle, quantity] = self[[callbacks.var_df9b308efe82294a]]();

  if(isDefined(itembundle)) {
    lootid = function_6d15e119c2779a93(itembundle);
    function_d56bb02626a9d806(lootid);
  }

  callbacks = function_cca8bbe88a39ad41("killstreak");
  [itembundle, quantity] = self[[callbacks.var_df9b308efe82294a]]();

  if(isDefined(itembundle)) {
    lootid = function_6d15e119c2779a93(itembundle);
    function_d56bb02626a9d806(lootid);
  }
}

function function_975c9e149cb01216() {
  var_c94ee5d51008bad0 = getscriptbundle("acquisitionlist:acquisition_list_jup_ob");

  if(!isDefined(var_c94ee5d51008bad0)) {
    return;
  }

  level.var_ee6237adc007b5f5 = [];
  level.var_b01c6db5b39665a3 = [];

  foreach(var_f4d29a9e1e5f7dde in var_c94ee5d51008bad0.var_c94ee5d51008bad0) {
    if(!isDefined(var_f4d29a9e1e5f7dde.itembundle)) {
      continue;
    }

    var_9a4ab95b2098db46 = getscriptbundle(var_f4d29a9e1e5f7dde.itembundle);
    var_dda2e1ef1d7c6e0d = function_6d15e119c2779a93(var_9a4ab95b2098db46);
    level.var_b01c6db5b39665a3[var_dda2e1ef1d7c6e0d] = var_9a4ab95b2098db46;

    if(!isDefined(var_9a4ab95b2098db46.var_a7141a24829dc197)) {
      continue;
    }

    var_3a11fa1c67269ca0 = getscriptbundle(var_9a4ab95b2098db46.var_a7141a24829dc197);
    var_6014c760d9adff2f = function_6d15e119c2779a93(var_3a11fa1c67269ca0);
    level.var_ee6237adc007b5f5[var_6014c760d9adff2f] = var_3a11fa1c67269ca0;
  }
}

function function_d56bb02626a9d806(lootid) {
  if(!isDefined(lootid) || lootid < 1) {
    return;
  }

  if(!isDefined(level.var_b01c6db5b39665a3[lootid])) {
    return;
  }

  for(i = 0; i < 10; i++) {
    ownedid = self getplayerdata(level.outbreakdata, "rankedMatchData", "squadMembers", "ownedAcquisitionSetup", i, "lootID");

    if(!isDefined(ownedid) || ownedid == 0) {
      self setplayerdata(level.outbreakdata, "rankedMatchData", "squadMembers", "ownedAcquisitionSetup", i, "lootID", lootid);
      return;
    }
  }
}

function function_e2ccdedfebf9e5b1(var_b381b0883bcd4847) {
  activity = self;
  activity namespace_b3f32c8cb80b8124::function_e73a92bbeb2ae323();
}

function function_a9ef0214509af471() {
  if(!isDefined(level.var_ee6237adc007b5f5)) {
    function_975c9e149cb01216();
  }

  var_7838b9df983ad1ea = [];
  var_e41a3129bc5710b = [];
  var_a91c6541c62b2649 = [];

  for(backpackindex = 0; backpackindex < 10; backpackindex++) {
    lootid = common_inventory::function_d870b2c45335bd88(backpackindex);
    var_7838b9df983ad1ea[var_7838b9df983ad1ea.size] = lootid;

    if(isDefined(lootid) && lootid != 0) {
      itembundle = common_item::function_f4a303d532b044a7(lootid);

      if(isDefined(itembundle) && istrue(itembundle.var_72340ceb276c0f64)) {
        if(itembundle.type == "schematic") {
          var_a91c6541c62b2649[var_a91c6541c62b2649.size] = lootid;
          continue;
        }

        if(isDefined(level.var_ee6237adc007b5f5[lootid])) {
          var_e41a3129bc5710b[var_e41a3129bc5710b.size] = lootid;
        }
      }
    }
  }

  return [var_7838b9df983ad1ea, var_e41a3129bc5710b, var_a91c6541c62b2649];
}

function function_dd632640ede8012(var_a1fc16d2ea055338) {
  weapons = self getweaponslistall();

  foreach(weapon in weapons) {
    rootname = scripts\cp_mp\weapon::getweaponrootname(weapon);
    variantid = weapon.variantid;

    if(!isDefined(weapon.variantid)) {
      variantid = 0;
    }

    ref = rootname;

    if(variantid) {
      ref = rootname + "_v" + variantid;
    }

    lootid = function_2c836ad05e5f634c(ref);
    var_a1fc16d2ea055338[var_a1fc16d2ea055338.size] = lootid;
  }

  ref = scripts\mp\equipment::getcurrentequipment("primary");

  if(isDefined(ref)) {
    equipmentammo = scripts\mp\equipment::getequipmentslotammo("primary");
    lootid = scripts\cp_mp\utility\loot::getlootidfromref(ref);
    var_a1fc16d2ea055338[var_a1fc16d2ea055338.size] = lootid;
  }

  ref = scripts\mp\equipment::getcurrentequipment("secondary");

  if(isDefined(ref)) {
    equipmentammo = scripts\mp\equipment::getequipmentslotammo("secondary");
    lootid = scripts\cp_mp\utility\loot::getlootidfromref(ref);
    var_a1fc16d2ea055338[var_a1fc16d2ea055338.size] = lootid;
  }

  ref = scripts\mp\killstreaks\killstreaks::getkillstreakinslot(1);

  if(isDefined(ref)) {
    lootid = scripts\cp_mp\utility\loot::getlootidfromref(ref.streakname);
    var_a1fc16d2ea055338[var_a1fc16d2ea055338.size] = lootid;
  }

  if(istrue(self.hasplatepouch)) {
    lootid = scripts\cp_mp\utility\loot::getlootidfromref("armor_satchel");
    var_a1fc16d2ea055338[var_a1fc16d2ea055338.size] = lootid;
  }

  if(scripts\cp_mp\gasmask::hasgasmask(self)) {
    lootid = scripts\cp_mp\utility\loot::getlootidfromref("gas_mask");
    var_a1fc16d2ea055338[var_a1fc16d2ea055338.size] = lootid;
  }

  itemname = self.equipment["health"];
  itemcount = scripts\mp\equipment::getequipmentslotammo("health");

  if(isDefined(itemname) && isDefined(itemcount) && itemcount > 0) {
    for(i = 0; i < itemcount; i++) {
      lootid = scripts\cp_mp\utility\loot::getlootidfromref("armor_plate");
      var_a1fc16d2ea055338[var_a1fc16d2ea055338.size] = lootid;
    }
  }

  if(self.platecarrierlevel > 1) {
    if(self.platecarrierlevel == 2) {
      lootid = scripts\cp_mp\utility\loot::getlootidfromref("brloot_plate_carrier_2");
      var_a1fc16d2ea055338[var_a1fc16d2ea055338.size] = lootid;
    } else if(self.platecarrierlevel == 3) {
      lootid = scripts\cp_mp\utility\loot::getlootidfromref("brloot_plate_carrier_3");
      var_a1fc16d2ea055338[var_a1fc16d2ea055338.size] = lootid;
    }
  }

  return var_a1fc16d2ea055338;
}

function function_46f56bf948599140(player, var_a6b3fae0395f75c3) {
  current_team = "unset";

  if(isDefined(player.sessionteam)) {
    current_team = player.sessionteam;
  }

  if(isDefined(player.team)) {
    current_team = player.team;
  }

  [var_7838b9df983ad1ea, var_e41a3129bc5710b, var_a91c6541c62b2649] = player function_a9ef0214509af471();
  str_difficulty = namespace_4df2ab39b0e96ec7::function_4d8bb2d866771a10(player.origin);
  var_a1fc16d2ea055338 = [];
  var_a1fc16d2ea055338 = player function_dd632640ede8012(var_a1fc16d2ea055338);
  data = spawnStruct();
  data.player = player;
  data.current_team = current_team;
  data.x = player.origin[0];
  data.y = player.origin[1];
  data.z = player.origin[2];
  data.xrot = player.angles[0];
  data.yrot = player.angles[1];
  data.zrot = player.angles[2];
  data.matchtimeelapsed = int(getsecondspassed());
  data.extractiontype = "0";
  data.essence_total = player currency::function_15975e20bbd2c824("essence");
  data.backpackitems = var_7838b9df983ad1ea;
  data.acquisitionitems = var_e41a3129bc5710b;
  data.schematicitems = var_a91c6541c62b2649;
  data.loadoutitems = var_a1fc16d2ea055338;
  data.difficulty = str_difficulty;
  data.var_a6b3fae0395f75c3 = var_a6b3fae0395f75c3;
  namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_ob_on_exfil", data);
}

function function_edff661c569fa3bc(player) {
  var_5ef3cbc8ae1f14da = currency::function_2e815a7b6d0bbcf6();

  if(!isDefined(var_5ef3cbc8ae1f14da) || !isDefined(isDefined(var_5ef3cbc8ae1f14da.var_fc0c0e46b333a0af))) {
    player points::doscoreevent(#"hash_a664e407eb3e39d4", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
    return;
  }

  var_38e0c8be67fbe5cc = undefined;

  foreach(conversioninfo in var_5ef3cbc8ae1f14da.var_fc0c0e46b333a0af) {
    if(conversioninfo.currency == % "hash_229c022abe3707c5") {
      var_38e0c8be67fbe5cc = conversioninfo;
      break;
    }
  }

  assertex(isDefined(var_38e0c8be67fbe5cc), "<dev string:x168>");
  var_bbf3fc2b4554bbf5 = 0;
  miscitemcount = player armor::function_20b8437058079297();
  var_f4dc9a7cc7dad020 = player currency::function_15975e20bbd2c824("essence");
  backpackindex = 0;

  while(backpackindex < player function_1b35b10884bd8d67()) {
    lootid = player common_inventory::function_d870b2c45335bd88(backpackindex);

    if(!isDefined(lootid) || lootid == 0) {} else {
      quantity = player common_inventory::function_5ce7fe3dca9c1a22(backpackindex);

      if(!isDefined(quantity) || quantity == 0) {} else {
        bundle = common_item::function_f4a303d532b044a7(lootid);

        if(!isDefined(bundle) || !isDefined(bundle.ref)) {} else {
          valueinfo = currency::function_3321003104b9507e(bundle.ref);

          if(isDefined(valueinfo) && isDefined(valueinfo.value)) {
            var_f4dc9a7cc7dad020 += quantity * valueinfo.value;
          } else if(bundle.type == "schematic") {
            var_bbf3fc2b4554bbf5 += 1;
          } else if(!istrue(bundle.var_72340ceb276c0f64)) {
            miscitemcount += istrue(bundle.var_ec7430d9ed0b6e64) ? 1 : quantity;
          }
        }
      }
    }

    backpackindex += 1;
  }

  raritycount = 0;
  var_20a42653a534a1d8 = 0;
  packapunchcount = 0;
  wonderweaponcount = 0;
  primaryweaponobj = player common_item::function_2aeaf88105d3b617(0);

  if(isDefined(primaryweaponobj)) {
    if(weapon::iswonderweapon(primaryweaponobj)) {
      wonderweaponcount += 1;
    } else {
      raritycount += player namespace_736197e4d378b91b::function_75e73212bbe447d9(primaryweaponobj);
      packapunchcount += player pack_a_punch::get_pap_level(primaryweaponobj);

      if(player ammo_mod::has_ammo_mod(primaryweaponobj)) {
        var_20a42653a534a1d8 += 1;
      }
    }
  }

  secondaryweaponobj = player common_item::function_2aeaf88105d3b617(1);

  if(isDefined(secondaryweaponobj)) {
    if(weapon::iswonderweapon(secondaryweaponobj)) {
      wonderweaponcount += 1;
    } else {
      raritycount += player namespace_736197e4d378b91b::function_75e73212bbe447d9(secondaryweaponobj);
      packapunchcount += player pack_a_punch::get_pap_level(secondaryweaponobj);

      if(player ammo_mod::has_ammo_mod(secondaryweaponobj)) {
        var_20a42653a534a1d8 += 1;
      }
    }
  }

  activeperks = player zombie_perks::function_ad6e85c9533ac466();
  var_e476b408a8fec2e8 = activeperks.size;
  extractionxp = rank::getscoreinfoxp(#"hash_a664e407eb3e39d4");
  schematicxp = var_bbf3fc2b4554bbf5 * (isDefined(var_5ef3cbc8ae1f14da.schematicsxp) ? var_5ef3cbc8ae1f14da.schematicsxp : 0);
  var_80fdaf4b8fdc36d6 = miscitemcount * (isDefined(var_5ef3cbc8ae1f14da.miscxp) ? var_5ef3cbc8ae1f14da.miscxp : 0);
  rarityxp = raritycount * (isDefined(var_5ef3cbc8ae1f14da.rarityxp) ? var_5ef3cbc8ae1f14da.rarityxp : 0);
  ammomodxp = var_20a42653a534a1d8 * (isDefined(var_5ef3cbc8ae1f14da.ammomodxp) ? var_5ef3cbc8ae1f14da.ammomodxp : 0);
  packapunchxp = packapunchcount * (isDefined(var_5ef3cbc8ae1f14da.packapunchxp) ? var_5ef3cbc8ae1f14da.packapunchxp : 0);
  wonderweaponxp = wonderweaponcount * (isDefined(var_5ef3cbc8ae1f14da.wonderweaponxp) ? var_5ef3cbc8ae1f14da.wonderweaponxp : 0);
  perkacolaxp = var_e476b408a8fec2e8 * (isDefined(var_5ef3cbc8ae1f14da.perkacolaxp) ? var_5ef3cbc8ae1f14da.perkacolaxp : 0);
  essencexp = var_f4dc9a7cc7dad020 * (isDefined(var_38e0c8be67fbe5cc.ratio) ? var_38e0c8be67fbe5cc.ratio : 0);

  if(isDefined(var_38e0c8be67fbe5cc.max) && var_38e0c8be67fbe5cc.max != 0) {
    essencexp = int(min(essencexp, var_38e0c8be67fbe5cc.max));
  }

  player.var_520e914889cda77e = rarityxp + ammomodxp + packapunchxp;
  player points::doscoreevent(#"hash_a664e407eb3e39d4", undefined, undefined, extractionxp + schematicxp + var_80fdaf4b8fdc36d6 + player.var_520e914889cda77e + wonderweaponxp + perkacolaxp + essencexp, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  player.var_e7faf08f327b0fb5 = int(var_f4dc9a7cc7dad020 * getdvarfloat(@ "hash_eb99be1539a07c71", 0.1));

  if(istrue(player.var_ad19e9b0668cd04d)) {
    player.var_e7faf08f327b0fb5 = getdvarint(@ "hash_3d348ecab9d0504a", 259200);
  }

  if(namespace_9571f642f38c8169::function_a6172e49f7313fd8()) {
    i = 0;

    while(i < 3) {
      player namespace_9571f642f38c8169::function_874d25a7167d2051(5, i, player.var_e7faf08f327b0fb5);
      i += 1;
    }

    i = 0;

    while(i < 3) {
      player namespace_9571f642f38c8169::function_874d25a7167d2051(6, i, player.var_e7faf08f327b0fb5);
      i += 1;
    }

    if(getdvarint(@ "hash_b0b8d806784726d0", 1)) {
      i = 0;

      while(i < 37) {
        player namespace_9571f642f38c8169::function_874d25a7167d2051(11, i, player.var_e7faf08f327b0fb5);
        i += 1;
      }
    }
  }
}

function private function_7bfb1ccacdacfd26() {
  if(getdvarint(@ "hash_4a06c2e18a26d17f", 0)) {
    return true;
  }

  return false;
}

function function_e229d89e0c38206d(players, playlistid) {
  if(function_7bfb1ccacdacfd26()) {
    foreach(player in players) {
      if(!isDefined(player)) {
        continue;
      }

      player callback::callback("map_to_map_transition");
      player.var_ded04cdd264a7e00 = 1;
      player.var_e763169cf4dfd7b2 = spawnStruct();

      if(namespace_9571f642f38c8169::function_a6172e49f7313fd8()) {
        player namespace_9571f642f38c8169::function_6aa0d0467dfd4624(1);
        player namespace_9571f642f38c8169::function_80c587026fbc6e0d();
      }

      if(getdvarint(@ "hash_77f6de1d536c1ca1", 1)) {
        player function_86924395ad6e3c5e();
      }

      logstring("quest exfil MapToMapMatchmaking called for player " + player.name + " entnum " + player getentitynumber() + " playlistID: " + playlistid);
    }

    function_d296788a307d5162(players, playlistid);
  }
}

function function_9487b6b2ba44f9db(player) {
  if(istrue(player.var_ded04cdd264a7e00)) {
    return true;
  }

  if(getdvarint(@ "hash_f68809e89102fb57", 0)) {
    return true;
  }

  return false;
}

function function_54eab82244c83ff6() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("max_containment_init_expired");
  ent_flag_init("exfil_streak_initialized");

  if(getdvarint(@ "hash_7c1b6974d8f89937", 1)) {
    thread function_a75015edefceb836();
    level waittill_any_3("match_start_real_countdown", "match_start_timer_skip", "ob_infil_completed");
  }

  containment_init();
}

function function_a75015edefceb836() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("exfil_streak_initialized");
  var_8f7ab3f27a545702 = getdvarint(@ "hash_35a227a59cec6a51", 30);
  wait var_8f7ab3f27a545702;
  playername = isDefined(self) && isDefined(self.name) ? self.name : "Player";
  logstring("InstanceInventory MWZ Contaiment Level Warning. We waited for the ideal Infil phases to pass but they didn't occurred within " + var_8f7ab3f27a545702 + " seconds for " + playername + "");
  self notify("max_containment_init_expired");
  containment_init();
}

function containment_init() {
  self.var_4b8e8742f0763613 = spawnStruct();
  self.var_4b8e8742f0763613.var_ae06e623319b2568 = 0;
  self.var_4b8e8742f0763613.var_6c51bc050c56493a = 0;
  self.var_4b8e8742f0763613.var_1013af6f1d055a93 = 0;
  self.var_4b8e8742f0763613.var_884e7862cd02ee0a = 0;
  self.var_4b8e8742f0763613.var_11879f765be021e1 = function_cbab630c2a3acda0(self);
  var_76723deda1f19107 = self getplayerdata(level.var_5d69837cf4db0407, "currentStreakCount");

  if(isDefined(level.gametypebundle) && isDefined(level) && isDefined(level.gametypebundle.var_e61e7212585decdd)) {
    foreach(index, s_tier in level.gametypebundle.var_e61e7212585decdd) {
      if(var_76723deda1f19107 >= s_tier.var_7401bd57f180cbb1) {
        self.var_4b8e8742f0763613.var_6c51bc050c56493a = index + 1;
      }
    }
  } else {
    playername = isDefined(self) && isDefined(self.name) ? self.name : "Player";
    logstring("InstanceInventory MWZ Contaiment Level Error. There is no valid Reward Tier List available, " + playername + " won't get any rewards");
  }

  if(ob::function_baf75ba94ab12e1d()) {
    self.var_4b8e8742f0763613.var_ae06e623319b2568 = self.var_e755151728396f5c;
  } else {
    function_2ee217c2644e30b0();
  }

  ent_flag_set("exfil_streak_initialized");
  self notify("exfil_streak_initialized");
}

function function_86924395ad6e3c5e() {
  currentstreak = self getplayerdata(level.var_5d69837cf4db0407, "currentStreakCount");
  beststreak = self getplayerdata(level.var_5d69837cf4db0407, "bestStreakCount");

  if(!function_827fc26017a2344f(self)) {
    self setplayerdata(level.var_5d69837cf4db0407, "currentStreakGainedProgress", 0);
    self setplayerdata(level.var_5d69837cf4db0407, "bestStreakGainedProgress", 0);
    self setplayerdata(level.var_5d69837cf4db0407, "currentSessionStreakCount", 0);
    return;
  }

  newstreak = self.var_4b8e8742f0763613.var_ae06e623319b2568 + currentstreak - self.var_e755151728396f5c;
  self setplayerdata(level.var_5d69837cf4db0407, "currentSessionStreakCount", self.var_4b8e8742f0763613.var_ae06e623319b2568);
  self setplayerdata(level.var_5d69837cf4db0407, "currentStreakGainedProgress", 1);
  self setplayerdata(level.var_5d69837cf4db0407, "currentStreakCount", newstreak);

  if(newstreak > beststreak) {
    self setplayerdata(level.var_5d69837cf4db0407, "bestStreakGainedProgress", 1);
    self setplayerdata(level.var_5d69837cf4db0407, "bestStreakCount", newstreak);
  } else {
    self setplayerdata(level.var_5d69837cf4db0407, "bestStreakGainedProgress", 0);
  }

  function_3c2a023833792e67(self, newstreak);
}

function function_b13047a59d730787() {
  if(isDefined(self.var_4b8e8742f0763613) && !istrue(self.var_57cb31b1d8fd5600)) {
    var_277e5a7de395bb2e = getdvarint(@ "hash_5c869b8df5b17357", 0);

    if(utility::ent_flag("dropped_item") || gettime() > utility::function_a5b14435e3229bed(var_277e5a7de395bb2e)) {
      var_45b3d22c6cca7734 = self.var_4b8e8742f0763613.var_6c51bc050c56493a;

      if(var_45b3d22c6cca7734 <= 1) {
        var_b8fd9cbd6ac969b7 = 0;
      } else {
        tier_reduction = getdvarint(@ "hash_2f1c0c275e3ef7e2", 1) + 1;
        var_b8fd9cbd6ac969b7 = level.gametypebundle.var_e61e7212585decdd[var_45b3d22c6cca7734 - tier_reduction].var_7401bd57f180cbb1;
        self setplayerdata(level.var_5d69837cf4db0407, "currentStreakCount", var_b8fd9cbd6ac969b7);
        var_b0557c2682a12788 = self.var_4b8e8742f0763613.var_ae06e623319b2568 - var_b8fd9cbd6ac969b7;
        self setplayerdata(level.var_5d69837cf4db0407, "currentSessionStreakCount", var_b0557c2682a12788);
        function_3c2a023833792e67(self, var_b8fd9cbd6ac969b7);
      }

      self.var_57cb31b1d8fd5600 = 1;
    }
  }
}

function function_827fc26017a2344f(player) {
  return player.var_4b8e8742f0763613.var_ae06e623319b2568 > 0;
}

function function_cbab630c2a3acda0(player) {
  var_2c949c82af2f8e5e = 0;

  if(ob::function_baf75ba94ab12e1d()) {
    player.var_e755151728396f5c = player getplayerdata(level.var_5d69837cf4db0407, "currentSessionStreakCount");
  } else {
    player.var_e755151728396f5c = 0;
  }

  streak = 0;

  if(namespace_9571f642f38c8169::function_a6172e49f7313fd8()) {
    streakinstance = player namespace_9571f642f38c8169::function_213e09add40997f4(65535, 5);

    if(namespace_9571f642f38c8169::function_3f8c62126708afe6(streakinstance) && isDefined(streakinstance.metadata)) {
      var_e3c4193b3862093a = namespace_9571f642f38c8169::function_f6c6c8920a5333e7(2, streakinstance, 0);

      if(isDefined(var_e3c4193b3862093a)) {
        streak = int(var_e3c4193b3862093a);
        var_2c949c82af2f8e5e = 1;
      } else {
        playername = isDefined(player) && isDefined(player.name) ? player.name : "Player";
        logstring("InstanceInventory MWZ Contaiment Level Error. Can't retrieve Metadata for " + playername + " jup_dmz_exfil_streak, even though Instance Inventory is enabled and the Extraction Streak Sublocation has an item");
      }
    }
  }

  player setplayerdata(level.var_5d69837cf4db0407, "currentStreakGainedProgress", 0);
  player setplayerdata(level.var_5d69837cf4db0407, "bestStreakGainedProgress", 0);
  player setplayerdata(level.var_5d69837cf4db0407, "currentSessionStreakCount", 0);
  player setplayerdata(level.var_5d69837cf4db0407, "currentStreakCount", streak);
  return var_2c949c82af2f8e5e;
}

function function_3c2a023833792e67(player, streak) {
  if(namespace_9571f642f38c8169::function_a6172e49f7313fd8()) {
    if(getdvarint(@ "hash_44e1ee87ef0ef8ad", 1)) {
      streakinstance = player namespace_9571f642f38c8169::function_213e09add40997f4(65535, 5);

      if(namespace_9571f642f38c8169::function_3f8c62126708afe6(streakinstance) && isDefined(streakinstance.metadata) && !istrue(player.var_4b8e8742f0763613.var_11879f765be021e1)) {
        playername = isDefined(player) && isDefined(player.name) ? player.name : "Player";
        logstring("InstanceInventory MWZ Contaiment Level Error: We couldn't initially read the " + playername + " jup_dmz_exfil_streak metadata value for the active operative and we are about to stomp it now at end of match");
      }
    }

    player namespace_9571f642f38c8169::function_b1fcbec168284539(loot::getlootidfromref("jup_dmz_exfil_streak"), 15, 65535, 5, []);
    streakinstance = player namespace_9571f642f38c8169::function_213e09add40997f4(65535, 5);
    player namespace_9571f642f38c8169::function_8715433c6e64940b([2], [streak], streakinstance, 0);
  }
}

function private function_2ee217c2644e30b0() {
  switch (self.var_4b8e8742f0763613.var_6c51bc050c56493a) {
    case 1:
    case 2:
      self.var_4b8e8742f0763613.var_1013af6f1d055a93 = 500;
      break;
    case 3:
    case 4:
      self.var_4b8e8742f0763613.var_1013af6f1d055a93 = 1000;
      break;
    case 5:
    case 6:
      self.var_4b8e8742f0763613.var_1013af6f1d055a93 = 1500;
      break;
    case 7:
    case 8:
      self.var_4b8e8742f0763613.var_1013af6f1d055a93 = 2500;
      break;
    case 9:
    case 10:
      self.var_4b8e8742f0763613.var_1013af6f1d055a93 = 5000;
      break;
  }

  if(self.var_4b8e8742f0763613.var_6c51bc050c56493a >= 2) {
    self.var_4b8e8742f0763613.var_884e7862cd02ee0a = 1;
  }

  if(self.var_4b8e8742f0763613.var_6c51bc050c56493a >= 4) {
    scripts\mp\utility\perk::giveperk("specialty_exfil_perk_percent_reward");
    self setclientomnvar("ui_perk_discount", level.perkbundles["specialty_exfil_perk_percent_reward"].var_7a8b971bedec7699);
  }

  if(self.var_4b8e8742f0763613.var_6c51bc050c56493a >= 6) {
    scripts\mp\utility\perk::giveperk("specialty_exfil_contract_percent_reward");
  }

  if(self.var_4b8e8742f0763613.var_6c51bc050c56493a >= 8) {
    scripts\mp\utility\perk::giveperk("specialty_exfil_mystery_box_percent_reward");
  }

  if(self.var_4b8e8742f0763613.var_6c51bc050c56493a >= 10) {
    scripts\mp\utility\perk::giveperk("specialty_exfil_pap_percent_reward");
  }
}

function function_5ab36fe089f88f56(player, var_150d6bbae4f030fd) {
  player ent_flag_wait("exfil_streak_initialized");
  player.var_4b8e8742f0763613.var_ae06e623319b2568 += var_150d6bbae4f030fd;
  player setplayerdata(level.var_5d69837cf4db0407, "currentSessionStreakCount", player.var_4b8e8742f0763613.var_ae06e623319b2568);
  player setclientomnvar("ui_is_exfil_countdown", 1);
  player setclientomnvar("ui_match_start_countdown", 0);
  waitframe();
  player setclientomnvar("ui_is_exfil_countdown", 0);
  player setclientomnvar("ui_match_start_countdown", -1);
}

function function_6c6bfa8bc42fad46(a_params) {
  if(isDefined(a_params)) {
    player = function_b3818ef99e063667(a_params[0]);
  } else {
    player = level.players[0];
  }

  player.var_4b8e8742f0763613.var_ae06e623319b2568 += 3;
}

function function_730c1d563a35c043(a_params) {
  if(isDefined(a_params)) {
    player = function_b3818ef99e063667(a_params[0]);
  } else {
    player = level.players[0];
  }

  player.var_4b8e8742f0763613.var_6c51bc050c56493a = 10;
  player.var_4b8e8742f0763613.var_ae06e623319b2568 += 10;
  player function_2ee217c2644e30b0();
}

function function_b3818ef99e063667(str_name) {
  foreach(player in level.players) {
    if(player.name == str_name) {
      return player;
    }

    if(isbot(player)) {
      if(issubstr(player.name, str_name)) {
        return player;
      }
    }
  }
}

# /
/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1059e26302ca1a7f.gsc
*************************************************/

#using script_482376d10f69832c;
#using script_4e6e58ab5d96c2b0;
#using script_4fa7e9e11630166c;
#using scripts\asm\shared\mp\utility;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\common\utility;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\cp_mp\interaction;
#using scripts\cp_mp\loot\common_cache;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\utility;
#using scripts\mp\hud_message;
#using scripts\mp\utility\player;
#using scripts\mp\utility\script;
#using scripts\ob\points;
#namespace namespace_58e5629db8a7e86;

function function_f93e244fd14ffe9d(var_8de84d74a1d3c4e6) {
  switch (var_8de84d74a1d3c4e6) {
    case #"hash_6fb5d66c124bebf7":
      var_fa8d6a9a1142977c = getdvarfloat(@ "hash_f5657b8d73912f28", 1);
      level.var_c3fbc3c2dd4e5240[var_8de84d74a1d3c4e6].var_3144cc2ba8121676 = scripts\mp\utility\script::roundup(getdvarint(@ "hash_4342237651b25191", 8) * level.players.size * var_fa8d6a9a1142977c);
      break;
    case #"hash_f7f31c1457e72522":
      var_781c6fca8e5a1d41 = getdvarfloat(@ "hash_360ec5af583eed55", 1);
      level.var_c3fbc3c2dd4e5240[var_8de84d74a1d3c4e6].var_3144cc2ba8121676 = scripts\mp\utility\script::roundup(getdvarint(@ "hash_5f43d805856990ec", 8) * 4 * level.players.size * var_781c6fca8e5a1d41);
      break;
    case #"hash_ac806fefe47e32c1":
      var_6f2cd796f4961fc4 = getdvarfloat(@ "hash_2088073548aeeb10", 1);
      level.var_c3fbc3c2dd4e5240[var_8de84d74a1d3c4e6].var_3144cc2ba8121676 = scripts\mp\utility\script::roundup(getdvarint(@ "hash_fe0703b8cdc1cef3", 10) * level.players.size * var_6f2cd796f4961fc4);
      break;
  }
}

function function_73952f00a88cf059() {
  level.obelisks = [];
  level.var_c3fbc3c2dd4e5240 = [];
  level.var_747eee71c41ccadc = "";
  level.var_6b879e3378fe4f93 = 0;
  level.var_833c19ce35f0fdc0 = 0;
  level.var_b5c75487d8c13198 = 0;
  level.var_f607826b73b56d1c = [10, 7.5, 5];
  level.var_7b2594a08e3287bd = getdvarint(@ "hash_ba7eaa1fe49bc58f", 40);
  level.var_fa6de71fad88eea4 = getdvarint(@ "hash_4e8391c347609f3a", 50);
  obelisk_structs = getStructArray("obeliskspawn", "targetname");

  foreach(obelisk_struct in obelisk_structs) {
    var_8de84d74a1d3c4e6 = obelisk_struct.script_noteworthy;

    if(var_8de84d74a1d3c4e6 == "gloves") {
      level.obelisks[var_8de84d74a1d3c4e6] = spawnscriptable("jup_zm_rift_pedestal_top_scriptable", obelisk_struct.origin + (7, 3, 37), obelisk_struct.angles);
    } else {
      level.obelisks[var_8de84d74a1d3c4e6] = spawnscriptable("jup_zm_rift_pedestal_top_scriptable", obelisk_struct.origin + (0, 0, 40), obelisk_struct.angles);
    }

    level.obelisks[var_8de84d74a1d3c4e6] setscriptablepartstate("fx", "off");
    level.var_c3fbc3c2dd4e5240[var_8de84d74a1d3c4e6] = spawnscriptable("jup_zm_rift_pedestal_base_scriptable", obelisk_struct.origin, obelisk_struct.angles);
    level.var_c3fbc3c2dd4e5240[var_8de84d74a1d3c4e6].element = var_8de84d74a1d3c4e6;
    level.var_c3fbc3c2dd4e5240[var_8de84d74a1d3c4e6].completed = 0;
    level.var_c3fbc3c2dd4e5240[var_8de84d74a1d3c4e6].killcount = 0;
    level.var_c3fbc3c2dd4e5240[var_8de84d74a1d3c4e6] setscriptablepartstate("body", "spawned_" + var_8de84d74a1d3c4e6);
    function_f93e244fd14ffe9d(var_8de84d74a1d3c4e6);
    level.var_c3fbc3c2dd4e5240[var_8de84d74a1d3c4e6] setscriptablepartstate("interact", "on");
    scripts\cp_mp\interaction::function_32645103f7520635(level.var_c3fbc3c2dd4e5240[var_8de84d74a1d3c4e6], &activate_obelisk, undefined, &obelisk_gesture);
    level.var_c3fbc3c2dd4e5240[var_8de84d74a1d3c4e6] scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_dda97bcf0f20e53f);
  }

  callback::add("player_item_pickup", &on_item_pickup);

  init_debug();
}

function function_2e579448e711006c(player, trigger) {
  if(isPlayer(player) && level.var_747eee71c41ccadc != "") {
    if(array_contains(level.activeplayers, player)) {
      level.activeplayers = arrayremove(level.activeplayers, player);
    }
  }
}

function function_60e8e0a397d627c0(player, trigger) {
  if(isPlayer(player) && level.var_747eee71c41ccadc != "") {
    if(!array_contains(level.activeplayers, player)) {
      level.activeplayers = function_6d6af8144a5131f1(level.activeplayers, player);
    }

    if(level.activeplayers.size == level.players.size) {
      level thread function_d931e054b30c7826();
    }
  }
}

function function_d931e054b30c7826() {
  level endon("obelisk_completed");

  if(isDefined(level.var_a693c7faa0efefef)) {
    return;
  }

  var_6923400044bc563d = getdvarint(@ "hash_d6169b622077c125", 120);
  level.var_a693c7faa0efefef = var_6923400044bc563d;

  while(level.var_a693c7faa0efefef >= 0) {
    level.var_a693c7faa0efefef -= 1;

    iprintlnbold(level.var_a693c7faa0efefef + "<dev string:x1c>");

    wait 1;
  }

  if(isDefined(level.obelisks) && isDefined(level.var_747eee71c41ccadc) && isDefined(level.obelisks[level.var_747eee71c41ccadc]) && isDefined(level.obelisks[level.var_747eee71c41ccadc].origin)) {
    var_35a34d194f4c11a0 = scripts\mp\utility\player::getplayersinradius(level.obelisks[level.var_747eee71c41ccadc].origin, 350);

    if(var_35a34d194f4c11a0.size == 0) {
      obelisk_reset();
    }

    level.var_a693c7faa0efefef = undefined;
  }
}

function function_dda97bcf0f20e53f(interact, player) {
  if(level.var_747eee71c41ccadc != "") {
    return {
      #string: &"JUP_OB_s1/SEAL_ALREADY_ACTIVE", #type: "HINT_NOBUTTON"};
  }

  if(!istrue(self.iscompleted)) {
    return {
      #string: &"JUP_OB_s1/ACTIVATE_OBELISK", #type: "HINT_BUTTON"};
  }
}

function obelisk_gesture(player) {
  wait 1.15;

  if(player useButtonPressed()) {
    player forceplaygestureviewmodel("jup_ges_open_portal");
  }
}

function function_32d3a1e04367d812() {
  self endon("obelisk_complete");

  while(level.var_747eee71c41ccadc == "gloves") {
    scripts\common\powerups::powerup_drop("insta_kill", getclosestpointonnavmesh(self.origin) + (0, 0, 30), 15);
    wait 60;
  }
}

function activate_obelisk(player) {
  if(level.var_747eee71c41ccadc != "") {
    return;
  }

  level thread namespace_b3f32c8cb80b8124::function_115bd456be8e071d(level.players, "ob_contract_action_loop");
  self setscriptablepartstate("body", "active_" + self.element);
  self setscriptablepartstate("interact", "off");
  level.var_747eee71c41ccadc = self.element;
  function_f93e244fd14ffe9d(level.var_747eee71c41ccadc);
  level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].var_26adba977a3c7fb1 = spawn("trigger_radius", level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].origin, 0, 350, 350);

  if(!isDefined(level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].orb)) {
    level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].orb = spawnscriptable("jup_zm_rift_pedestal_orb_scriptable", self.origin + (0, 0, 40), self.angles);
  } else {
    level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].orb setscriptablepartstate("body", "active");
  }

  if(issharedfuncdefined("game", "makeEnterExitTrigger")) {
    [[getsharedfunc("game", "makeEnterExitTrigger")]](level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].var_26adba977a3c7fb1, &function_2e579448e711006c, &function_60e8e0a397d627c0);
  }

  level callback::add("on_ai_killed", &function_6e42339d9503b6b7);
  level callback::add("player_laststand", &function_35682bc06e3a7d3a);
  function_6094ec6f1a58a381();
  thread function_658b421b37fd7662();

  if(level.var_747eee71c41ccadc == "gloves") {
    thread function_32d3a1e04367d812();
  } else if(level.var_747eee71c41ccadc == "mirror") {
    function_ee531fb1c8aacd54();
    level.var_74755bce692986a4 = "mirror_fire";
  }

  player thread scripts\mp\hud_message::showsplash("jup_ob_obelisk_activated", undefined, undefined, undefined, 1, "splash_list_jup_ob");
}

function function_6094ec6f1a58a381() {
  if(self.element == "gloves") {
    var_44b27a8e32ebe296 = spawn_request("ai_flood_fill_encounter:ob_s2_mission_obelisk_encounter_" + self.element, self.origin, 300, 1, 1, 0);
    function_bc5315dc37ae4cf(var_44b27a8e32ebe296, &function_b07493f60764eed4, level.var_833c19ce35f0fdc0);
    function_73147cdf5c28d10c(var_44b27a8e32ebe296, &function_64f4df7704af6dc2, self);
    function_e4a67fe4ddca7ed5(var_44b27a8e32ebe296, &function_5d1738a71dc36fa0, self);
    return;
  }

  var_44b27a8e32ebe296 = spawn_request("ai_flood_fill_encounter:ob_s2_mission_obelisk_encounter_" + self.element, self.origin, 1000, 1, 1, 0);
  function_bc5315dc37ae4cf(var_44b27a8e32ebe296, &function_b07493f60764eed4, level.var_833c19ce35f0fdc0);
  function_73147cdf5c28d10c(var_44b27a8e32ebe296, &function_64f4df7704af6dc2, self);
  function_e4a67fe4ddca7ed5(var_44b27a8e32ebe296, &function_5d1738a71dc36fa0, self);
}

function function_658b421b37fd7662() {
  while(level.var_747eee71c41ccadc != "") {
    var_f911aed45eb961a3 = getaiarrayinradius(self.origin, 1000);
    var_35a34d194f4c11a0 = scripts\mp\utility\player::getplayersinradius(level.obelisks[level.var_747eee71c41ccadc].origin, 350);

    foreach(zombie in var_f911aed45eb961a3) {
      if(!isDefined(zombie.var_f89106513931332c)) {
        zombie.var_f89106513931332c = 0;
      }

      var_52d83275cdaec498 = distance2dsquared(zombie.origin, self.origin) < 122500;

      if(level.var_747eee71c41ccadc != "mirror") {
        if(var_52d83275cdaec498 == 1 && zombie.var_f89106513931332c == 0 && isalive(zombie)) {
          zombie function_3ab9164ef76940fd("obelisk_vfx", level.var_747eee71c41ccadc);
          zombie.var_f89106513931332c = 1;
        } else if(var_52d83275cdaec498 == 0 && zombie.var_f89106513931332c == 1) {
          zombie function_3ab9164ef76940fd("obelisk_vfx", "off");
          zombie.var_f89106513931332c = 0;
        }
      }

      if(level.var_747eee71c41ccadc == "mirror" && isDefined(level.var_74755bce692986a4) && level.var_74755bce692986a4 == "mirror_fire") {
        if(var_52d83275cdaec498 == 1 && zombie.var_f89106513931332c == 0 && isalive(zombie)) {
          zombie function_3ab9164ef76940fd("obelisk_vfx", "fire");
        } else if(var_52d83275cdaec498 == 0 && zombie.var_f89106513931332c == 1) {
          zombie function_3ab9164ef76940fd("obelisk_vfx", "off");
          zombie.var_f89106513931332c = 0;
        }

        continue;
      }

      if(level.var_747eee71c41ccadc == "mirror" && isDefined(level.var_74755bce692986a4) && level.var_74755bce692986a4 == "mirror_ice") {
        if(var_52d83275cdaec498 == 1 && zombie.var_f89106513931332c == 0 && isalive(zombie)) {
          zombie function_3ab9164ef76940fd("obelisk_vfx", "ice");
          level.obelisks[level.var_747eee71c41ccadc] setscriptablepartstate("fx", "ice3", 0);
          level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc] setscriptablepartstate("body", "active_mirror_ice", 0);
        } else if(var_52d83275cdaec498 == 0 && zombie.var_f89106513931332c == 1) {
          zombie function_3ab9164ef76940fd("obelisk_vfx", "off");
          zombie.var_f89106513931332c = 0;
        }

        continue;
      }

      if(level.var_747eee71c41ccadc == "mirror" && isDefined(level.var_74755bce692986a4) && level.var_747eee71c41ccadc == "mirror_electric") {
        if(var_52d83275cdaec498 == 1 && zombie.var_f89106513931332c == 0 && isalive(zombie)) {
          zombie function_3ab9164ef76940fd("obelisk_vfx", "electric");
          level.obelisks[level.var_747eee71c41ccadc] setscriptablepartstate("fx", "electric3", 0);
          level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc] setscriptablepartstate("body", "active_mirror_electric", 0);
        } else if(var_52d83275cdaec498 == 0 && zombie.var_f89106513931332c == 1) {
          zombie function_3ab9164ef76940fd("obelisk_vfx", "off");
          zombie.var_f89106513931332c = 0;
        }

        continue;
      }

      if(level.var_747eee71c41ccadc == "mirror" && isDefined(level.var_74755bce692986a4) && level.var_74755bce692986a4 == "mirror_toxic") {
        if(var_52d83275cdaec498 == 1 && zombie.var_f89106513931332c == 0 && isalive(zombie)) {
          zombie function_3ab9164ef76940fd("obelisk_vfx", "toxic");
          level.obelisks[level.var_747eee71c41ccadc] setscriptablepartstate("fx", "toxic3", 0);
          level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc] setscriptablepartstate("body", "active_mirror_toxic", 0);
          continue;
        }

        if(var_52d83275cdaec498 == 0 && zombie.var_f89106513931332c == 1) {
          zombie function_3ab9164ef76940fd("obelisk_vfx", "off");
          zombie.var_f89106513931332c = 0;
        }
      }
    }

    wait 0.2;
  }
}

function function_35682bc06e3a7d3a(params) {
  if(level.var_747eee71c41ccadc != "" && level.var_6d298bb3b2c8bf0 == 0) {
    if(distance2dsquared(self.origin, level.obelisks[level.var_747eee71c41ccadc].origin) < 1000000) {
      if(level.var_b5c75487d8c13198 < level.var_f607826b73b56d1c.size) {
        level.var_6d298bb3b2c8bf0 = level.var_f607826b73b56d1c[level.var_b5c75487d8c13198];
        level.var_b5c75487d8c13198++;
        wait level.var_6d298bb3b2c8bf0;
        level.var_6d298bb3b2c8bf0 = 0;
      }
    }
  }
}

function function_b07493f60764eed4(requestid, var_833c19ce35f0fdc0) {
  if(level.var_747eee71c41ccadc == "") {
    return 0;
  }

  squadsize = level.players.size;
  var_b4a0bb985e832edf = level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].killcount / level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].var_3144cc2ba8121676;
  var_415fd8a0dbe8422f = 1.5 / min(squadsize, 3) + 0.1 * max(3 - var_833c19ce35f0fdc0, 0) - 0.5;
  var_ebae3ffd14f48d6e = 4.5 / min(squadsize, 3) + 0.2 * max(3 - var_833c19ce35f0fdc0, 0) - 0.5;
  waveinterval = var_415fd8a0dbe8422f + (var_ebae3ffd14f48d6e - var_415fd8a0dbe8422f) * (1 - var_b4a0bb985e832edf);
  wait waveinterval + level.var_6d298bb3b2c8bf0;

  if(level.var_747eee71c41ccadc != "") {
    return 1;
  }

  level notify("ai_encounter_shutdown_" + requestid);
  return 0;
}

function function_64f4df7704af6dc2(requestid, userdata) {
  if(level.var_747eee71c41ccadc != "") {
    return 0;
  }

  return 1;
}

function function_5d1738a71dc36fa0(requestid, obelisk, zombie, ai_data) {
  zombie function_65cdab0fc78aba8f(obelisk.origin, 525);
}

function function_6e42339d9503b6b7(params) {
  self function_9322f3cb1cd4111a();
  function_3ab9164ef76940fd("obelisk_vfx", "off");
  var_3e5bef4b6dd3e32a = level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].origin;
  weaponelementtype = scripts\ob\points::function_591305dc9c07499b(params.sweapon, params.eattacker, params.smeansofdeath);

  if(distance2dsquared(self.origin, var_3e5bef4b6dd3e32a) < 122500) {
    if(params.shitloc == "head" && level.var_747eee71c41ccadc == "targets") {
      playFX(getfx("zombie_death"), self.origin);

      if(level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].killcount <= level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].var_3144cc2ba8121676) {
        level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].killcount++;
        function_2b6783f1c69393ff(self.origin + (0, 0, 40), var_3e5bef4b6dd3e32a + (0, 0, 170), 0.25);
      }
    }

    if(params.smeansofdeath == "MOD_MELEE" && level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].element == "gloves") {
      playFX(getfx("zombie_death"), self.origin);

      if(level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].killcount <= level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].var_3144cc2ba8121676) {
        level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].killcount++;
        function_2b6783f1c69393ff(self.origin + (0, 0, 40), var_3e5bef4b6dd3e32a + (0, 0, 170), 0.25);
      }
    }

    if(level.var_747eee71c41ccadc == "mirror" && isDefined(level.var_74755bce692986a4) && level.var_74755bce692986a4 == "mirror_fire" && (params.smeansofdeath == "MOD_ELEMENTAL_FIRE" || weaponelementtype == "fire")) {
      playFX(getfx("zombie_death"), self.origin);

      if(level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].killcount <= int(level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].var_3144cc2ba8121676 / 4 * 1)) {
        level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].killcount++;
        function_2b6783f1c69393ff(self.origin + (0, 0, 40), var_3e5bef4b6dd3e32a + (0, 0, 170), 0.25);
      }
    }

    if(level.var_747eee71c41ccadc == "mirror" && isDefined(level.var_74755bce692986a4) && level.var_74755bce692986a4 == "mirror_ice" && (params.smeansofdeath == "MOD_ELEMENTAL_COLD" || weaponelementtype == "cold")) {
      playFX(getfx("zombie_death"), self.origin);

      if(level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].killcount <= int(level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].var_3144cc2ba8121676 / 4 * 2)) {
        level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].killcount++;
        function_2b6783f1c69393ff(self.origin + (0, 0, 40), var_3e5bef4b6dd3e32a + (0, 0, 170), 0.25);
      }
    }

    if(level.var_747eee71c41ccadc == "mirror" && isDefined(level.var_74755bce692986a4) && level.var_74755bce692986a4 == "mirror_electric" && (params.smeansofdeath == "MOD_ELEMENTAL_ELEC" || weaponelementtype == "electrical")) {
      playFX(getfx("zombie_death"), self.origin);

      if(level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].killcount <= int(level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].var_3144cc2ba8121676 / 4 * 3)) {
        level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].killcount++;
        function_2b6783f1c69393ff(self.origin + (0, 0, 40), var_3e5bef4b6dd3e32a + (0, 0, 170), 0.25);
      }
    }

    if(level.var_747eee71c41ccadc == "mirror" && isDefined(level.var_74755bce692986a4) && level.var_74755bce692986a4 == "mirror_toxic" && (params.smeansofdeath == "MOD_ELEMENTAL_TOXIC" || weaponelementtype == "toxic")) {
      playFX(getfx("zombie_death"), self.origin);

      if(level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].killcount <= int(level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].var_3144cc2ba8121676 / 4 * 4)) {
        level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].killcount++;
        function_2b6783f1c69393ff(self.origin + (0, 0, 40), var_3e5bef4b6dd3e32a + (0, 0, 170), 0.25);
      }
    }

    return;
  }

  iprintln("<dev string:x32>");
}

function function_2b6783f1c69393ff(spawn_origin, goal_position, move_delay) {
  move_delay = utility::default_to(move_delay, 0);
  trail = utility::spawn_model("tag_origin", spawn_origin);
  trail.goal_position = goal_position;
  playFXOnTag(getfx("zombie_soul"), trail, "tag_origin");
  trail thread function_57961c5b765c270(move_delay);
}

function function_57961c5b765c270(move_delay) {
  self endon("death");
  self playSound("evt_ob_rr_obelisk_soul_spawn");
  self playLoopSound("evt_ob_rr_obelisk_soul_lp");

  if(move_delay > 0) {
    wait move_delay;
  }

  self moveTo(self.goal_position, 0.8, 0.2);
  self waittill("movedone");
  playFX(getfx("zombie_soul_impact"), self.goal_position);
  killfxontag(getfx("zombie_soul"), self, "tag_origin");
  playsoundatpos(self.origin, "evt_ob_rr_obelisk_soul_impact");
  function_4234407e34a559f9();
  self delete();
}

function function_4234407e34a559f9() {
  if(level.var_747eee71c41ccadc == "" || !isDefined(level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc])) {
    return;
  }

  var_2da558e8c88e09c = min(level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].killcount / level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].var_3144cc2ba8121676, 1);

  if(var_2da558e8c88e09c >= 0.7 && !istrue(level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].var_6eae333ea647b63a) && isDefined(level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc])) {
    level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].var_6eae333ea647b63a = 1;
    scripts\cp_mp\overlord::playevent("s2_seal_partial", level.players, 7);
  }

  if(isDefined(level.var_74755bce692986a4) && level.var_74755bce692986a4 == "mirror_fire") {
    level.obelisks[level.var_747eee71c41ccadc] setscriptablepartstate("fx", "fire3", 0);
    level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc] setscriptablepartstate("body", "active_mirror_fire", 0);

    if(level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].killcount >= int(level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].var_3144cc2ba8121676 / 4)) {
      level.var_74755bce692986a4 = "mirror_ice";
      level.obelisks[level.var_747eee71c41ccadc] setscriptablepartstate("fx", "ice3", 0);
      level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc] setscriptablepartstate("body", "active_mirror_ice", 0);
    }

    return;
  }

  if(isDefined(level.var_74755bce692986a4) && level.var_74755bce692986a4 == "mirror_ice") {
    level.obelisks[level.var_747eee71c41ccadc] setscriptablepartstate("fx", "ice3", 0);
    level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc] setscriptablepartstate("body", "active_mirror_ice", 0);

    if(level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].killcount >= int(level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].var_3144cc2ba8121676 / 4 * 2)) {
      level.var_74755bce692986a4 = "mirror_electric";
      level.obelisks[level.var_747eee71c41ccadc] setscriptablepartstate("fx", "electric3", 0);
      level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc] setscriptablepartstate("body", "active_mirror_electric", 0);
    }

    return;
  }

  if(isDefined(level.var_74755bce692986a4) && level.var_74755bce692986a4 == "mirror_electric") {
    level.obelisks[level.var_747eee71c41ccadc] setscriptablepartstate("fx", "electric3", 0);
    level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc] setscriptablepartstate("body", "active_mirror_electric", 0);

    if(level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].killcount >= int(level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].var_3144cc2ba8121676 / 4 * 3)) {
      level.var_74755bce692986a4 = "mirror_toxic";
      level.obelisks[level.var_747eee71c41ccadc] setscriptablepartstate("fx", "toxic3", 0);
      level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc] setscriptablepartstate("body", "active_mirror_toxic", 0);
    }

    return;
  }

  if(isDefined(level.var_74755bce692986a4) && level.var_74755bce692986a4 == "mirror_toxic") {
    level.obelisks[level.var_747eee71c41ccadc] setscriptablepartstate("fx", "toxic3", 0);
    level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc] setscriptablepartstate("body", "active_mirror_toxic", 0);

    if(level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].killcount >= level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].var_3144cc2ba8121676) {
      var_22dc3ce7ca3defdd = spawnStruct();
      var_22dc3ce7ca3defdd.origin = level.obelisks[level.var_747eee71c41ccadc].origin;
      var_22dc3ce7ca3defdd.angles = level.obelisks[level.var_747eee71c41ccadc].angles;
      thread obelisk_completed(var_22dc3ce7ca3defdd);
    }

    return;
  }

  if(level.var_747eee71c41ccadc != "mirror" && level.var_747eee71c41ccadc != "") {
    if(var_2da558e8c88e09c >= 1) {
      var_22dc3ce7ca3defdd = spawnStruct();
      var_22dc3ce7ca3defdd.origin = level.obelisks[level.var_747eee71c41ccadc].origin;
      var_22dc3ce7ca3defdd.angles = level.obelisks[level.var_747eee71c41ccadc].angles;
      thread obelisk_completed(var_22dc3ce7ca3defdd);
      return;
    }

    if(var_2da558e8c88e09c * 4 >= level.var_6b879e3378fe4f93 + 1) {
      level.var_6b879e3378fe4f93++;
      level.obelisks[level.var_747eee71c41ccadc] setscriptablepartstate("fx", level.var_747eee71c41ccadc + level.var_6b879e3378fe4f93);
    }
  }
}

function obelisk_reset() {
  var_35a34d194f4c11a0 = scripts\mp\utility\player::getplayersinradius(level.obelisks[level.var_747eee71c41ccadc].origin, 350);

  if(level.var_747eee71c41ccadc != "" && isDefined(level.obelisks[level.var_747eee71c41ccadc]) && var_35a34d194f4c11a0.size == 0) {
    level.obelisks[level.var_747eee71c41ccadc] setscriptablepartstate("fx", "off");
    level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].completed = 0;
    level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].killcount = 0;
    level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].var_6eae333ea647b63a = 0;
    level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc] setscriptablepartstate("body", "spawned_" + level.var_747eee71c41ccadc);
    level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc] setscriptablepartstate("interact", "on");
    level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].orb setscriptablepartstate("body", "done");
    function_3b8b06fe20379e8e();
    level.var_747eee71c41ccadc = "";
    level.var_6b879e3378fe4f93 = 0;
    level.var_b5c75487d8c13198 = 0;
    level callback::remove("on_ai_killed", &function_6e42339d9503b6b7);
    level callback::remove("player_laststand", &function_35682bc06e3a7d3a);
    level thread namespace_b3f32c8cb80b8124::function_115bd456be8e071d(level.players, "ob_contract_lose");

    foreach(player in level.players) {
      player thread scripts\mp\hud_message::showsplash("jup_ob_obelisk_abandoned", undefined, undefined, undefined, 1, "splash_list_jup_ob");
    }

    foreach(player in level.players) {
      if(!array_contains(level.activeplayers, player)) {
        level.activeplayers = function_6d6af8144a5131f1(level.activeplayers, player);
      }
    }

    level.var_a693c7faa0efefef = undefined;
    level.var_74755bce692986a4 = "";
  }
}

function obelisk_completed(var_5535f2813b83d678) {
  if(level.var_747eee71c41ccadc == "") {
    return;
  }

  level.obelisks[level.var_747eee71c41ccadc].iscompleted = 1;
  level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].completed = 1;
  level.obelisks[level.var_747eee71c41ccadc] setscriptablepartstate(#"body", #"destroyed");
  level.obelisks[level.var_747eee71c41ccadc] setscriptablepartstate("fx", level.var_747eee71c41ccadc + "_done");
  level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc] setscriptablepartstate("body", "spawned_" + level.var_747eee71c41ccadc);

  if(isDefined(level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].orb)) {
    level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].orb setscriptablepartstate("body", "done");
  }

  level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc] notify("obelisk_complete");
  level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].var_26adba977a3c7fb1 delete();

  foreach(player in level.players) {
    if(!array_contains(level.activeplayers, player)) {
      level.activeplayers = function_6d6af8144a5131f1(level.activeplayers, player);
    }
  }

  level thread namespace_b3f32c8cb80b8124::function_115bd456be8e071d(level.players, "ob_contract_win");
  var_35a34d194f4c11a0 = scripts\mp\utility\player::getplayersinradius(level.obelisks[level.var_747eee71c41ccadc].origin, 350);
  function_3b8b06fe20379e8e();
  explosionzombies = getaiarrayinradius(var_5535f2813b83d678.origin, 1000, "team_two_hundred");

  foreach(zombie in explosionzombies) {
    if(isalive(zombie) && !istrue(zombie.var_2c94b75746ceabe2)) {
      zombie function_3ab9164ef76940fd("obelisk_vfx", "off");
      zombie kill();
      corpse = zombie getcorpseentity();

      if(isDefined(corpse)) {
        var_a33d2a2c3ffecb81 = corpse.origin - var_5535f2813b83d678.origin + (0, 0, 60);
        var_83fd98f3ac829176 = max(500 - distance2d(corpse.origin, var_5535f2813b83d678.origin), 0) / 4;
        corpse startragdollfromimpact("torso_upper", var_a33d2a2c3ffecb81 * var_83fd98f3ac829176);
      }
    }
  }

  thread function_1163fc6c10bbe21a(var_5535f2813b83d678);
  function_c7311cb3f768f21e("obelisk", 10);
  level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc] setscriptablepartstate("interact", "off");
  level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].killcount = 0;
  level notify("obelisk_completed");
  level.var_747eee71c41ccadc = "";
  level.var_6b879e3378fe4f93 = 0;
  level.var_b5c75487d8c13198 = 0;
  level.var_833c19ce35f0fdc0++;
  level callback::remove("on_ai_killed", &function_6e42339d9503b6b7);
  level callback::remove("player_laststand", &function_35682bc06e3a7d3a);
}

function function_1163fc6c10bbe21a(var_c2d35eda877c6b2c) {
  var_5a2483b8cdfb9542 = level.var_747eee71c41ccadc;
  currentsquad = level.players[0] scripts\cp_mp\utility\squad_utility::getsquadmembers();
  rewardgroup = [];

  foreach(player in currentsquad) {
    rewardgroup[rewardgroup.size] = [player];
  }

  switch (var_5a2483b8cdfb9542) {
    case #"hash_f7f31c1457e72522":
      namespace_e8853d3344e33cf6::function_863be9e39e19fe2f(rewardgroup, var_c2d35eda877c6b2c, &function_becc6a4c10eaa230);
      scripts\cp_mp\overlord::playevent("s2_mirror_completed", level.players);
      break;
    case #"hash_ac806fefe47e32c1":
      namespace_e8853d3344e33cf6::function_863be9e39e19fe2f(rewardgroup, var_c2d35eda877c6b2c, &function_3c140aad312a29cf);
      scripts\cp_mp\overlord::playevent("s2_target_completed", level.players);
      break;
    case #"hash_6fb5d66c124bebf7":
      namespace_e8853d3344e33cf6::function_863be9e39e19fe2f(rewardgroup, var_c2d35eda877c6b2c, &function_f714e94d0aa12025);
      break;
  }
}

function private function_becc6a4c10eaa230(params) {
  cache = spawnStruct();
  items = function_bc2f4857c90f5344("ob_jup_sira_obelisk_reward_mirror_s2", 1);
  common_cache::function_fd95ef820bb2b980(items, cache);
  return cache.contents;
}

function function_e5f38d39d7fe6cd(spawnlocation) {
  scripts\cp_mp\overlord::playevent("s2_rq_get_attuned_drum_ent", level.players);
  currentsquad = level.players[0] scripts\cp_mp\utility\squad_utility::getsquadmembers();
  rewardgroup = [];

  foreach(player in currentsquad) {
    rewardgroup[rewardgroup.size] = [player];
  }

  namespace_e8853d3344e33cf6::function_863be9e39e19fe2f(rewardgroup, spawnlocation, &function_9c0abc4e42f87418);
}

function private function_9c0abc4e42f87418(params) {
  cache = spawnStruct();
  items = function_bc2f4857c90f5344("ob_jup_sira_obelisk_reward_drums_s2", 1);
  common_cache::function_fd95ef820bb2b980(items, cache);
  items = function_bc2f4857c90f5344("ob_jup_items_contracts_riftrun_normal_s2", 3);
  common_cache::function_fd95ef820bb2b980(items, cache);
  return cache.contents;
}

function private function_3c140aad312a29cf(params) {
  cache = spawnStruct();
  items = function_bc2f4857c90f5344("ob_jup_sira_obelisk_reward_targets_s2", 1);
  common_cache::function_fd95ef820bb2b980(items, cache);
  return cache.contents;
}

function private function_f714e94d0aa12025(params) {
  cache = spawnStruct();
  items = function_bc2f4857c90f5344("ob_jup_sira_obelisk_reward_gloves_s2", 1);
  common_cache::function_fd95ef820bb2b980(items, cache);
  return cache.contents;
}

function private function_ee531fb1c8aacd54() {
  function_c183907e5f0b9d23();
  wait 0.5;
  function_61707196a47fd340();
  wait 0.5;
  function_21a7d56b7ecb4370();
  wait 0.5;
  function_ce56fb2e795cd388();
}

function private function_e24351a5fae3b2d8() {
  level.var_6ce6accfd71ba09 setscriptablepartstate("base", "hidden");
  level.var_898eee7892cc441f setscriptablepartstate("vfx", "inactive");

  foreach(player in level.players) {
    level.var_3856824a46e27384 hidefromplayer(player);
  }
}

function private function_fad6d89abaae3305() {
  level.var_43e4d85f1915460 setscriptablepartstate("base", "hidden");
  level.var_3072a4a87c9badbe setscriptablepartstate("vfx", "inactive");

  foreach(player in level.players) {
    level.var_c85b5636f572c6d5 hidefromplayer(player);
  }
}

function private function_59652e97d161907f() {
  level.var_c21c69b6f66e0986 setscriptablepartstate("base", "hidden");
  level.var_7d3732059b615008 setscriptablepartstate("vfx", "inactive");

  foreach(player in level.players) {
    level.var_6e32ce6747857b27 hidefromplayer(player);
  }
}

function private function_a5d7a758ef89288d() {
  level.var_ce316f9a04669f9c setscriptablepartstate("base", "hidden");
  level.var_7b4334f2fe126642 setscriptablepartstate("vfx", "inactive");

  foreach(player in level.players) {
    level.var_efa1466b68876819 hidefromplayer(player);
  }
}

function private function_3b8b06fe20379e8e() {
  if(level.var_747eee71c41ccadc == "mirror") {
    level.var_6ce6accfd71ba09 setscriptablepartstate("base", "hidden");
    level.var_898eee7892cc441f setscriptablepartstate("vfx", "inactive");
    level.var_3856824a46e27384 delete();
    level.var_43e4d85f1915460 setscriptablepartstate("base", "hidden");
    level.var_3072a4a87c9badbe setscriptablepartstate("vfx", "inactive");
    level.var_c85b5636f572c6d5 delete();
    level.var_ce316f9a04669f9c setscriptablepartstate("base", "hidden");
    level.var_7b4334f2fe126642 setscriptablepartstate("vfx", "inactive");
    level.var_efa1466b68876819 delete();
    level.var_c21c69b6f66e0986 setscriptablepartstate("base", "hidden");
    level.var_7d3732059b615008 setscriptablepartstate("vfx", "inactive");
    level.var_6e32ce6747857b27 delete();
  }
}

function private function_c183907e5f0b9d23() {
  var_79621307dd8839f2 = getStruct("mirror_fire", "targetname");

  if(!isDefined(level.var_6ce6accfd71ba09)) {
    var_6ce6accfd71ba09 = spawnscriptable("jup_ob_relic_mirror_elemental", var_79621307dd8839f2.origin, var_79621307dd8839f2.angles);
    var_6ce6accfd71ba09 setscriptablepartstate("base", "base");
    var_898eee7892cc441f = spawnscriptable("jup_ob_relic_mirror_fire_fx", var_79621307dd8839f2.origin, (0, 0, 0));
    var_898eee7892cc441f setscriptablepartstate("vfx", "active");
    level.var_6ce6accfd71ba09 = var_6ce6accfd71ba09;
    level.var_898eee7892cc441f = var_898eee7892cc441f;
  } else {
    level.var_6ce6accfd71ba09 setscriptablepartstate("base", "base");
    level.var_898eee7892cc441f setscriptablepartstate("vfx", "active");
  }

  var_5f809b4b00e4f4bb = var_79621307dd8839f2.origin + vectorNormalize(anglesToForward(var_79621307dd8839f2.angles)) * level.var_7b2594a08e3287bd;
  var_3856824a46e27384 = scripts\cp_mp\interaction::register_interact(var_5f809b4b00e4f4bb, level.var_fa6de71fad88eea4, &function_3698ca59b6cea149);
  var_3856824a46e27384 scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_8d12ae12911e4bbd);
  level.var_3856824a46e27384 = var_3856824a46e27384;
  level.var_3856824a46e27384 setuseholdduration("duration_medium");

  level thread scripts\cp_mp\utility\debug_utility::drawsphere(var_5f809b4b00e4f4bb, level.var_fa6de71fad88eea4, 360, (204, 0, 255));
}

function function_8d12ae12911e4bbd(interact, player) {
  return {
    #string: &"JUP_OB_S2/INTERACT_MIRROR_FIRE", #type: "HINT_BUTTON"};
}

function function_3698ca59b6cea149(player) {
  if(!isDefined(player.var_c8734f756d21f147)) {
    function_6861e62c77ac0239(player);
    level.var_3856824a46e27384 playsoundonmovingent("glass_pane_blowout");
    function_e24351a5fae3b2d8();
  }
}

function private function_21a7d56b7ecb4370() {
  var_125af19c369529f = getStruct("mirror_ice", "targetname");

  if(!isDefined(level.var_43e4d85f1915460)) {
    var_43e4d85f1915460 = spawnscriptable("jup_ob_relic_mirror_elemental", var_125af19c369529f.origin, var_125af19c369529f.angles);
    var_43e4d85f1915460 setscriptablepartstate("base", "base");
    var_3072a4a87c9badbe = spawnscriptable("jup_ob_relic_mirror_ice_fx", var_125af19c369529f.origin, (0, 0, 0));
    var_3072a4a87c9badbe setscriptablepartstate("vfx", "active");
    level.var_43e4d85f1915460 = var_43e4d85f1915460;
    level.var_3072a4a87c9badbe = var_3072a4a87c9badbe;
  } else {
    level.var_43e4d85f1915460 setscriptablepartstate("base", "base");
    level.var_3072a4a87c9badbe setscriptablepartstate("vfx", "active");
  }

  var_5f809b4b00e4f4bb = var_125af19c369529f.origin + vectorNormalize(anglesToForward(var_125af19c369529f.angles)) * level.var_7b2594a08e3287bd;
  var_c85b5636f572c6d5 = scripts\cp_mp\interaction::register_interact(var_5f809b4b00e4f4bb, level.var_fa6de71fad88eea4, &function_c86175c92df1ca46);
  var_c85b5636f572c6d5 scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_154680f1e2915748);
  level.var_c85b5636f572c6d5 = var_c85b5636f572c6d5;
  level.var_c85b5636f572c6d5 setuseholdduration("duration_medium");

  level thread scripts\cp_mp\utility\debug_utility::drawsphere(var_5f809b4b00e4f4bb, level.var_fa6de71fad88eea4, 360, (204, 0, 255));
}

function function_154680f1e2915748(interact, player) {
  return {
    #string: &"JUP_OB_S2/INTERACT_MIRROR_ICE", #type: "HINT_BUTTON"};
}

function function_c86175c92df1ca46(player) {
  function_eb52146767910406(player);
  level.var_c85b5636f572c6d5 playsoundonmovingent("glass_pane_blowout");
  function_fad6d89abaae3305();
}

function private function_ce56fb2e795cd388() {
  var_c72118276c956983 = getStruct("mirror_toxic", "targetname");

  if(!isDefined(level.var_ce316f9a04669f9c)) {
    var_ce316f9a04669f9c = spawnscriptable("jup_ob_relic_mirror_elemental", var_c72118276c956983.origin, var_c72118276c956983.angles);
    var_ce316f9a04669f9c setscriptablepartstate("base", "base");
    var_7b4334f2fe126642 = spawnscriptable("jup_ob_relic_mirror_toxic_fx", var_c72118276c956983.origin, (0, 0, 0));
    var_7b4334f2fe126642 setscriptablepartstate("vfx", "active");
    level.var_ce316f9a04669f9c = var_ce316f9a04669f9c;
    level.var_7b4334f2fe126642 = var_7b4334f2fe126642;
  } else {
    level.var_ce316f9a04669f9c setscriptablepartstate("base", "base");
    level.var_7b4334f2fe126642 setscriptablepartstate("vfx", "active");
  }

  var_5f809b4b00e4f4bb = var_c72118276c956983.origin + vectorNormalize(anglesToForward(var_c72118276c956983.angles)) * level.var_7b2594a08e3287bd;
  var_efa1466b68876819 = scripts\cp_mp\interaction::register_interact(var_5f809b4b00e4f4bb, level.var_fa6de71fad88eea4, &function_6e0aecd9b78368fe);
  var_efa1466b68876819 scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_f3830fa88cd247ac);
  level.var_efa1466b68876819 = var_efa1466b68876819;
  level.var_efa1466b68876819 setuseholdduration("duration_medium");

  level thread scripts\cp_mp\utility\debug_utility::drawsphere(var_5f809b4b00e4f4bb, level.var_fa6de71fad88eea4, 360, (204, 0, 255));
}

function function_f3830fa88cd247ac(interact, player) {
  return {
    #string: &"JUP_OB_S2/INTERACT_MIRROR_TOXIC", #type: "HINT_BUTTON"};
}

function function_6e0aecd9b78368fe(player) {
  function_1a406f57af6cb215(player);
  level.var_efa1466b68876819 playsoundonmovingent("glass_pane_blowout");
  function_a5d7a758ef89288d();
}

function private function_61707196a47fd340() {
  var_eda9caeee98a8fbd = getStruct("mirror_electric", "targetname");

  if(!isDefined(level.var_c21c69b6f66e0986)) {
    var_c21c69b6f66e0986 = spawnscriptable("jup_ob_relic_mirror_elemental", var_eda9caeee98a8fbd.origin, var_eda9caeee98a8fbd.angles);
    var_c21c69b6f66e0986 setscriptablepartstate("base", "base");
    var_7d3732059b615008 = spawnscriptable("jup_ob_relic_mirror_electric_fx", var_eda9caeee98a8fbd.origin, (0, 0, 0));
    var_7d3732059b615008 setscriptablepartstate("vfx", "active");
    level.var_c21c69b6f66e0986 = var_c21c69b6f66e0986;
    level.var_7d3732059b615008 = var_7d3732059b615008;
  } else {
    level.var_c21c69b6f66e0986 setscriptablepartstate("base", "base");
    level.var_7d3732059b615008 setscriptablepartstate("vfx", "active");
  }

  var_5f809b4b00e4f4bb = var_eda9caeee98a8fbd.origin + vectorNormalize(anglesToForward(var_eda9caeee98a8fbd.angles)) * level.var_7b2594a08e3287bd;
  var_6e32ce6747857b27 = scripts\cp_mp\interaction::register_interact(var_5f809b4b00e4f4bb, level.var_fa6de71fad88eea4, &function_3dcc79a1e03c4ed6);
  var_6e32ce6747857b27 scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_f29e02f4668c82c6);
  level.var_6e32ce6747857b27 = var_6e32ce6747857b27;
  level.var_6e32ce6747857b27 setuseholdduration("duration_medium");

  level thread scripts\cp_mp\utility\debug_utility::drawsphere(var_5f809b4b00e4f4bb, level.var_fa6de71fad88eea4, 360, (204, 0, 255));
}

function function_f29e02f4668c82c6(interact, player) {
  return {
    #string: &"JUP_OB_S2/INTERACT_MIRROR_ELECTRIC", #type: "HINT_BUTTON"};
}

function function_3dcc79a1e03c4ed6(player) {
  function_cc1b40686803d79f(player);
  level.var_6e32ce6747857b27 playsoundonmovingent("glass_pane_blowout");
  function_59652e97d161907f();
}

function private function_6861e62c77ac0239(player) {
  itembundlename = "ob_jup_item_ammomod_napalmburst";
  itembundle = getscriptbundle("itemspawnentry:" + itembundlename);
  payload = [#"teamselect", player getentitynumber()];
  a_squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
  item = scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4(itembundle, level.var_6ce6accfd71ba09.origin, undefined, 0, 1, payload);

  if(isDefined(item)) {
    params = spawnStruct();
    params.item = item;
    params.itembundlename = itembundlename;
    params.payload = payload;

    if(isDefined(level.var_8b939fbe0ef2d56b)) {
      player[[level.var_8b939fbe0ef2d56b]](params);
    }
  }
}

function private function_cc1b40686803d79f(player) {
  itembundlename = "ob_jup_item_ammomod_deadwire";
  itembundle = getscriptbundle("itemspawnentry:" + itembundlename);
  payload = [#"teamselect", player getentitynumber()];
  a_squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
  item = scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4(itembundle, level.var_c21c69b6f66e0986.origin, undefined, 0, 1, payload);

  if(isDefined(item)) {
    params = spawnStruct();
    params.item = item;
    params.itembundlename = itembundlename;
    params.payload = payload;

    if(isDefined(level.var_8b939fbe0ef2d56b)) {
      player[[level.var_8b939fbe0ef2d56b]](params);
    }
  }
}

function private function_eb52146767910406(player) {
  itembundlename = "ob_jup_item_ammomod_cryofreeze";
  itembundle = getscriptbundle("itemspawnentry:" + itembundlename);
  payload = [#"teamselect", player getentitynumber()];
  a_squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
  item = scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4(itembundle, level.var_43e4d85f1915460.origin, undefined, 0, 1, payload);

  if(isDefined(item)) {
    params = spawnStruct();
    params.item = item;
    params.itembundlename = itembundlename;
    params.payload = payload;

    if(isDefined(level.var_8b939fbe0ef2d56b)) {
      player[[level.var_8b939fbe0ef2d56b]](params);
    }
  }
}

function private function_1a406f57af6cb215(player) {
  itembundlename = "ob_jup_item_ammomod_brainrot";
  itembundle = getscriptbundle("itemspawnentry:" + itembundlename);
  payload = [#"teamselect", player getentitynumber()];
  a_squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
  item = scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4(itembundle, level.var_ce316f9a04669f9c.origin, undefined, 0, 1, payload);

  if(isDefined(item)) {
    params = spawnStruct();
    params.item = item;
    params.itembundlename = itembundlename;
    params.payload = payload;

    if(isDefined(level.var_8b939fbe0ef2d56b)) {
      player[[level.var_8b939fbe0ef2d56b]](params);
    }
  }
}

function init_debug() {
  function_89adef32695c90ca();
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x51>");
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x69>", "<dev string:x79>", &function_3d5b3aa6ffe90a9e);
  devgui::function_b23a59dfb4ca49a1("<dev string:x89>", "<dev string:xa6>", &common_item::function_f8162124bbb6ece3);
  devgui::function_b23a59dfb4ca49a1("<dev string:xe6>", "<dev string:x10b>", &common_item::function_f8162124bbb6ece3);
  devgui::function_b23a59dfb4ca49a1("<dev string:x153>", "<dev string:x170>", &common_item::function_f8162124bbb6ece3);
  devgui::function_b23a59dfb4ca49a1("<dev string:x1af>", "<dev string:x1d4>", &common_item::function_f8162124bbb6ece3);
  devgui::function_b23a59dfb4ca49a1("<dev string:x21b>", "<dev string:x238>", &common_item::function_f8162124bbb6ece3);
  devgui::function_b23a59dfb4ca49a1("<dev string:x277>", "<dev string:x29c>", &common_item::function_f8162124bbb6ece3);
  devgui::function_b23a59dfb4ca49a1("<dev string:x2e3>", "<dev string:x307>", &common_item::function_f8162124bbb6ece3);
  devgui::function_b23a59dfb4ca49a1("<dev string:x34d>", "<dev string:x371>", &common_item::function_f8162124bbb6ece3);
  devgui::function_b23a59dfb4ca49a1("<dev string:x399>", "<dev string:x3ad>", &common_item::function_f8162124bbb6ece3);
  devgui::function_b23a59dfb4ca49a1("<dev string:x3e2>", "<dev string:x3f6>", &common_item::function_f8162124bbb6ece3);
  scripts\common\devgui::function_fe953f000498048f();

  if(getdvarint(@ "hash_54cc43b8de3fd3f6", 0) == 1) {
    level thread function_4d0f3c1e55531df5();
    level thread function_78d941a3d8a48838();
    level thread function_57ca7c5ac7a77d37();
  }
}

function function_89adef32695c90ca() {
  obelisk_structs = getStructArray("<dev string:x42c>", "<dev string:x43c>");

  foreach(obelisk_struct in obelisk_structs) {
    var_8de84d74a1d3c4e6 = obelisk_struct.script_noteworthy;

    switch (var_8de84d74a1d3c4e6) {
      case #"hash_6fb5d66c124bebf7":
        level thread scripts\cp_mp\utility\debug_utility::drawsphere(obelisk_struct.origin, 800, 99999, (1, 0, 0));
        break;
      case #"hash_f7f31c1457e72522":
        level thread scripts\cp_mp\utility\debug_utility::drawsphere(obelisk_struct.origin, 800, 99999, (0, 0, 1));
        break;
      case #"hash_ac806fefe47e32c1":
        level thread scripts\cp_mp\utility\debug_utility::drawsphere(obelisk_struct.origin, 800, 99999, (0, 1, 0));
        break;
    }
  }
}

function function_3d5b3aa6ffe90a9e(param) {
  if(level.var_747eee71c41ccadc != "<dev string:x469>") {
    level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].killcount = int(level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].var_3144cc2ba8121676 - 1);

    foreach(player in level.players) {
      player setclientomnvar("<dev string:x46d>", int(level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].killcount / level.var_c3fbc3c2dd4e5240[level.var_747eee71c41ccadc].var_3144cc2ba8121676 * 100));
    }
  }
}

function function_4d0f3c1e55531df5() {
  while(true) {
    if(getdvarint(@ "hash_8166a18ad25d5317", 0) == 1) {
      level.obelisks["<dev string:x44a>"] setscriptablepartstate("<dev string:x48d>", "<dev string:x493>");
    }

    if(getdvarint(@ "hash_8166a18ad25d5317", 0) == 2) {
      level.obelisks["<dev string:x44a>"] setscriptablepartstate("<dev string:x48d>", "<dev string:x49e>");
    }

    if(getdvarint(@ "hash_8166a18ad25d5317", 0) == 3) {
      level.obelisks["<dev string:x44a>"] setscriptablepartstate("<dev string:x48d>", "<dev string:x4a9>");
    }

    if(getdvarint(@ "hash_8166a18ad25d5317", 0) == -1) {
      level.obelisks["<dev string:x44a>"] setscriptablepartstate("<dev string:x48d>", "<dev string:x4b4>");
    }

    waitframe();
  }
}

function function_78d941a3d8a48838() {
  while(true) {
    if(getdvarint(@ "hash_274e41a4374653be", 0) == 1) {
      level.obelisks["<dev string:x454>"] setscriptablepartstate("<dev string:x48d>", "<dev string:x4bb>");
    }

    if(getdvarint(@ "hash_274e41a4374653be", 0) == 2) {
      level.obelisks["<dev string:x454>"] setscriptablepartstate("<dev string:x48d>", "<dev string:x4c6>");
    }

    if(getdvarint(@ "hash_274e41a4374653be", 0) == 3) {
      level.obelisks["<dev string:x454>"] setscriptablepartstate("<dev string:x48d>", "<dev string:x4d1>");
    }

    if(getdvarint(@ "hash_274e41a4374653be", 0) == -1) {
      level.obelisks["<dev string:x454>"] setscriptablepartstate("<dev string:x48d>", "<dev string:x4b4>");
    }

    waitframe();
  }
}

function function_57ca7c5ac7a77d37() {
  while(true) {
    if(getdvarint(@ "hash_43a733d2ec5f70f0", 0) == 1) {
      level.obelisks["<dev string:x45e>"] setscriptablepartstate("<dev string:x48d>", "<dev string:x4dc>");
    }

    if(getdvarint(@ "hash_b702408528247f2f", 0) == 2) {
      level.obelisks["<dev string:x45e>"] setscriptablepartstate("<dev string:x48d>", "<dev string:x4e8>");
    }

    if(getdvarint(@ "hash_b702408528247f2f", 0) == 3) {
      level.obelisks["<dev string:x45e>"] setscriptablepartstate("<dev string:x48d>", "<dev string:x4f4>");
    }

    if(getdvarint(@ "hash_b702408528247f2f", 0) == -1) {
      level.obelisks["<dev string:x45e>"] setscriptablepartstate("<dev string:x48d>", "<dev string:x4b4>");
    }

    waitframe();
  }
}

function private on_item_pickup(params) {
  if(isDefined(params.itembundlename) && params.itembundlename == "ob_jup_item_key_rift_gate_season2_gloves") {
    if(!istrue(self.var_7f044f32e5eb64e)) {
      scripts\cp_mp\overlord::playevent("s2_gloves_completed", [self]);
      self.var_7f044f32e5eb64e = 1;
    }
  }

  if(isDefined(params.itembundlename) && params.itembundlename == "ob_jup_item_key_rift_gate_season2_mirror") {
    if(!istrue(self.var_c8e1b4654071581f)) {
      scripts\cp_mp\overlord::playevent("s2_mirror_completed", [self]);
      self.var_c8e1b4654071581f = 1;
    }
  }

  if(isDefined(params.itembundlename) && params.itembundlename == "ob_jup_item_key_rift_gate_season2_targets") {
    if(!istrue(self.var_8fb3a253ecd11795)) {
      scripts\cp_mp\overlord::playevent("s2_target_completed", [self]);
      self.var_8fb3a253ecd11795 = 1;
    }
  }
}
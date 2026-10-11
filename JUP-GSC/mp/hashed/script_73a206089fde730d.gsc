/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_73a206089fde730d.gsc
*************************************************/

#using script_1845b8a2edf19262;
#using script_185660037b9236c1;
#using script_220d0eb95a8fab7d;
#using script_3ab210ea917601e7;
#using script_41387eecc35b88bf;
#using script_4fdefae8b7bcdf73;
#using script_5753ba9c28794a65;
#using script_638d701d263ee1ed;
#using script_6617e2f2bb62b52b;
#using script_7956d56c4922bd1;
#using script_9880b9dc28bc25e;
#using script_d60e0219a7419e0;
#using scripts\common\devgui;
#using scripts\common\values;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\cp_mp\loot\common_cache;
#using scripts\engine\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#namespace namespace_62da3d9355108eea;

function function_97386f131cccf1e6() {
  level.safecrack = spawnStruct();
  level.safecrack.revealradius = getdvarint(@ "hash_de0487f3e5f484a3", 24000);
  level.safecrack.hideicons = getdvarint(@ "hash_3cf3f91f9a2e76d8", 1);
  level.safecrack.enabledefenders = getdvarint(@ "hash_d69ece7d8e88eaad", 1);
  level.safecrack.attractzombies = getdvarint(@ "hash_134e75ab81aab7de", 1);
  level.safecrack.revealradiussq = squared(level.safecrack.revealradius);
  namespace_4a32b5725832011a::function_77a37b3f4896fc9b();

  level thread function_5f76fcafb2d10aa2();
  level thread function_cadf35090e17590();

  function_89384091f7a2dbd("REV_OB_SAFECRACK", 0, &function_c6335e6b5148073c);
  function_89384091f7a2dbd("REV_OB_SAFECRACK", 1, &function_bdfe768bd3eed7fc);
  function_89384091f7a2dbd("REV_OB_SAFECRACK", 2, &function_ed260c1f4a6de9f8);
  function_89384091f7a2dbd("REV_OB_SAFECRACK", 3, &function_f0f250986bb9d773);
}

function function_c6335e6b5148073c() {
  self endon("activity_ended");
  self endon("instance_destroyed");
  self.variant_definition = function_4188e118731a30f4();
  self.variant_settings = function_b9c4aa88ad97ee68(self);
  self.capture_radius = default_to(self.variant_settings.captureradius, 150);
  self.attract_radius = default_to(self.variant_settings.attractradius, 2048);
  self.lose_progress = default_to(self.variant_settings.var_bbb79d5c4f2a37d0, 1);
  self.encounter_bundle = default_to(self.variant_settings.encounter, "jup_ob_safecrack_encounter");
  var_76903f9b275f23d4 = getStruct(self.varianttag, "target");
  assertex(isDefined(var_76903f9b275f23d4), "<dev string:x1c>" + self.varianttag);
  self.origin = var_76903f9b275f23d4.origin;
  self.angles = var_76903f9b275f23d4.angles;
  self.poi = var_76903f9b275f23d4.poi;
  self.region_difficulty = namespace_4df2ab39b0e96ec7::function_4d8bb2d866771a10(self.origin);

  switch (self.region_difficulty) {
    default:
      self.region_difficulty = "difficulty_easy";
    case #"hash_7bb2cd766703d463":
      self.capture_time = default_to(self.variant_settings.var_7d62d3a3e7495df8.capturetime, 75);
      self.var_48c4ba670a4f33fc = default_to(self.variant_settings.var_7d62d3a3e7495df8.lootlist, "ob_jup_items_activity_safecrack_green");
      break;
    case #"hash_af83e47edfa8900a":
      self.capture_time = default_to(self.variant_settings.var_470d2e794702714d.capturetime, 75);
      self.var_48c4ba670a4f33fc = default_to(self.variant_settings.var_470d2e794702714d.lootlist, "ob_jup_items_activity_safecrack_green");
      break;
    case #"hash_5343b465e56ec9a4":
      self.capture_time = default_to(self.variant_settings.var_a9c21290ef4bfa93.capturetime, 75);
      self.var_48c4ba670a4f33fc = default_to(self.variant_settings.var_a9c21290ef4bfa93.lootlist, "ob_jup_items_activity_safecrack_green");
      break;
    case #"hash_651f76c0ad6741ec":
      self.capture_time = default_to(self.variant_settings.var_eabd5412051ca0b8.capturetime, 75);
      self.var_48c4ba670a4f33fc = default_to(self.variant_settings.var_eabd5412051ca0b8.lootlist, "ob_jup_items_activity_safecrack_green");
      break;
  }

  self.capture_radius = getdvarint(hashcat(@ "hash_f72308758abea239", self.varianttag), self.capture_radius);
  self.attract_radius = getdvarint(hashcat(@ "hash_c4827b6b41a3159e", self.varianttag), self.attract_radius);
  self.lose_progress = getdvarint(hashcat(@ "hash_406af6bb3dff6667", self.varianttag), self.lose_progress);
  self.capture_time = getdvarint(hashcat(@ "hash_4795d743464e3550", self.varianttag), self.capture_time);
  self.var_48c4ba670a4f33fc = getDvar(hashcat(@ "hash_66f7a80db137f8e9", self.varianttag), self.var_48c4ba670a4f33fc);
  self.encounter_bundle = getDvar(hashcat(@ "hash_1c069aa79535cca4", self.varianttag), self.encounter_bundle);
  self.capture_time = float(self.capture_time);
  self.var_82fe1c44f0e59dd5 = squared(self.capture_radius);
  self.var_287c8f447c48c9aa = squared(self.attract_radius);
  self.var_614385c59920cb82 = 5;
  self.var_999c4a8370c90a74 = &function_99b95e1bcf411ecd;
  self.var_f6bc8fb4bf53a955 = &function_2ffbd407e258b1f4;
  self.safeunlocked = &function_10ff236142531478;
  self.safe = namespace_4a32b5725832011a::function_12920ead9cafd0e1(self.origin, self.angles);

  if(level.safecrack.enabledefenders) {
    self.safe thread function_74717c53a1ed7f5();
  }

  if(!isDefined(level.safes)) {
    level.safes = [];
  }

  level.safes[level.safes.size] = self.safe;
  self.safe waittill("safe_unlocking");
  function_b6fc2c96b463c007(self);
}

function function_bdfe768bd3eed7fc() {
  self endon("activity_ended");
  self endon("instance_destroyed");
  self.safe waittill("safe_looted");
  endactivity(self, 1);
}

function function_ed260c1f4a6de9f8(activity_succeeded) {
  self endon("instance_destroyed");
  namespace_40713433c91dd86c::function_c402ecda1e84ba27(self.playerparticipants, 0, self.difficulty_region, self.origin);
}

function function_f0f250986bb9d773() {
  self endon("instance_destroyed");
}

function function_58ab5bffacda35c3(safe, part, state, player) {
  if(level.safecrack.attractzombies) {
    safe.zombie_attractor = namespace_5381a59d140f4df8::add_attractor({
      #origin: safe.origin, #safe: safe
    }, 1, safe.activity.attract_radius, 0, undefined, &function_7d06997663e2b19f, 0);
  }
}

function function_74717c53a1ed7f5() {
  self.agents = [];
  self.encounterid = scripts\cp_mp\agents\ai_spawn_director::spawn_request("ai_encounter:" + self.activity.encounter_bundle, self.origin, 1024, 1, 1, 0);

  if(isDefined(self.encounterid)) {
    function_d37068aac7785c04(self.encounterid, self.activity.region_difficulty, 1);
    scripts\cp_mp\agents\ai_spawn_director::function_e4a67fe4ddca7ed5(self.encounterid, &function_111b3e11bf99b915, [self]);
    scripts\cp_mp\agents\ai_spawn_director::function_7a2920be35f4386(self.encounterid, &function_6d930ef0e465d1c6, [self]);
  }
}

function function_111b3e11bf99b915(requestid, userdata, agent, data) {
  agent endon("death");
  safe = userdata[0];

  if(isalive(agent)) {
    safe.agents[safe.agents.size] = agent;

    if(safe.agents.size <= 2) {
      childthread scripts\mp\ai_behavior::function_b11c1964f528574b(agent, 0);
    } else {
      childthread scripts\mp\ai_behavior::function_9bbf1713a14fa580(agent, 512, 256, safe.origin);
    }

    agent function_65cdab0fc78aba8f(safe.origin, safe.activity.capture_radius);
  }
}

function function_6d930ef0e465d1c6(requestid, userdata, wavenumber) {
  safe = userdata[0];

  if(!istrue(safe.reinforcementscalled) && istrue(safe.shouldreinforce)) {
    safe.reinforcementscalled = 1;
    return true;
  }

  return false;
}

function function_2ffbd407e258b1f4() {
  if(level.safecrack.attractzombies) {
    self.zombie_attractor = namespace_5381a59d140f4df8::add_attractor({
      #origin: self.origin, #safe: self
    }, 1, self.activity.attract_radius, 0, undefined, &function_7d06997663e2b19f, 0);
  }
}

function function_10ff236142531478() {
  function_2169641d6a403864(self.encounterid);

  if(level.safecrack.attractzombies) {
    namespace_5381a59d140f4df8::remove_attractor(self.zombie_attractor);
  }
}

function function_99b95e1bcf411ecd() {
  agents = scripts\mp\utility\entity::function_d9ce8fb00f0e5fa1(self.origin, self.activity.attract_radius, "team_hundred_ninety");
  attracted = [];

  foreach(agent in agents) {
    if(!isPlayer(agent)) {
      attracted[attracted.size] = agent;
    }
  }

  agents = attracted;

  foreach(agent in agents) {
    agent thread scripts\mp\ai_behavior::function_a5117518725da028(agent, self.origin, 128, 64, undefined, 1, agents, 0);
    agent ent_flag_init("activity_safe_attracted");
  }

  self.agents = array_combine_unique(self.agents, agents);
}

function function_7d06997663e2b19f(attractor, zombie) {
  safe = attractor.source.safe;

  if(is_equal(zombie.aicategory, "normal") && distance(zombie.origin, safe.origin) > safe.activity.capture_radius / 2) {
    if(zombie.team == "team_two_hundred") {
      safe.agents[safe.agents.size] = zombie;
      return true;
    }
  }

  return false;
}

function function_e34b2762fa082dcc(player) {
  wait 4;
  player thread scripts\mp\hud_message::showsplash("safecrack_revealed", undefined, undefined, undefined, 1, "splash_list_jup_ob");

  foreach(safe in level.safes) {
    if(distance2dsquared(safe.origin, player.origin) <= level.safecrack.revealradiussq) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(safe.objidnum, player);
    }
  }
}

function private function_5f76fcafb2d10aa2() {
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x98>");
  scripts\common\devgui::function_b2159fbbd7ac094e("<dev string:xb8>", @ "hash_e0bb32a9a7b2f71d");
  scripts\common\devgui::function_b2159fbbd7ac094e("<dev string:xc9>", @ "hash_4f2cd88d61f31a05");
  scripts\common\devgui::function_b2159fbbd7ac094e("<dev string:xd7>", @ "hash_7bba049efb029baa");
  scripts\common\devgui::function_b2159fbbd7ac094e("<dev string:xe8>", @ "hash_3ec6799528b8c3a3");
  scripts\common\devgui::function_b2159fbbd7ac094e("<dev string:x101>", @ "hash_e80ff5758ab695aa");
  scripts\common\devgui::function_b2159fbbd7ac094e("<dev string:x116>", @ "hash_ecc9f2ec79830d8");
  scripts\common\devgui::function_b2159fbbd7ac094e("<dev string:x124>", @ "hash_3cf803c8fb8e7b16");
  scripts\common\devgui::function_b2159fbbd7ac094e("<dev string:x13e>", @ "hash_95bcb70ae8cbe4cf");
  scripts\common\devgui::function_b2159fbbd7ac094e("<dev string:x159>", @ "hash_1902f346336c9d19");
  scripts\common\devgui::function_fe953f000498048f();
}

function private function_cadf35090e17590() {
  timer = 0;
  drawframeduration = 10;

  while(true) {
    if(!isDefined(level.safes) || !isDefined(level.players)) {
      wait 5;
      continue;
    }

    if(getdvarint(@ "hash_e0bb32a9a7b2f71d", 0)) {
      setDvar(@ "hash_e0bb32a9a7b2f71d", 0);

      foreach(player in level.players) {
        thread function_e34b2762fa082dcc(player);
      }
    }

    if(getdvarint(@ "hash_4f2cd88d61f31a05", 0)) {
      setDvar(@ "hash_4f2cd88d61f31a05", 0);

      foreach(safe in level.safes) {
        foreach(player in level.players) {
          scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(safe.objidnum, player);
        }
      }
    }

    if(getdvarint(@ "hash_7bba049efb029baa", 0)) {
      foreach(safe in level.safes) {
        function_32d74f3fc1994781(safe, drawframeduration);
        function_bc558b6c272c65e4(safe, drawframeduration);
        function_1071c808c36a9066(safe, drawframeduration);
      }
    }

    if(getdvarint(@ "hash_3ec6799528b8c3a3", 0) && timer == 0) {
      foreach(safe in level.safes) {
        function_32d74f3fc1994781(safe, drawframeduration);
      }
    }

    if(getdvarint(@ "hash_e80ff5758ab695aa", 0) && timer == 0) {
      foreach(safe in level.safes) {
        function_bc558b6c272c65e4(safe, drawframeduration);
      }
    }

    if(getdvarint(@ "hash_ecc9f2ec79830d8", 0) && timer == 0) {
      foreach(safe in level.safes) {
        function_1071c808c36a9066(safe, drawframeduration);
      }
    }

    if(getdvarint(@ "hash_3cf803c8fb8e7b16", 0)) {
      setDvar(@ "hash_3cf803c8fb8e7b16", 0);
      safe_found = 0;

      foreach(player in level.players) {
        sorted_safes = sortbydistance(level.safes, player.origin);

        foreach(safe in sorted_safes) {
          if(!isDefined(safe.progress)) {
            safe function_d5622642498f5a6f(player);
            safe_found = 1;
            break;
          }
        }
      }

      if(!safe_found) {
        iprintln("<dev string:x174>");
      }
    }

    if(getdvarint(@ "hash_95bcb70ae8cbe4cf", 0)) {
      setDvar(@ "hash_95bcb70ae8cbe4cf", 0);
      safe_found = 0;

      foreach(player in level.players) {
        sorted_safes = sortbydistance(level.safes, player.origin);

        foreach(safe in sorted_safes) {
          if(isDefined(safe.progress) && !istrue(safe.unlocked)) {
            safe function_8048ff4bc7646aa();
            safe_found = 1;
            break;
          }
        }
      }

      if(!safe_found) {
        iprintln("<dev string:x1be>");
      }
    }

    if(getdvarint(@ "hash_1902f346336c9d19", 0)) {
      setDvar(@ "hash_1902f346336c9d19", 0);
      safe_found = 0;

      foreach(player in level.players) {
        sorted_safes = sortbydistance(level.safes, player.origin);

        foreach(safe in sorted_safes) {
          if(istrue(safe.unlocked)) {
            safe function_a7c6874cd9ee87de();
            safe_found = 1;
            break;
          }
        }
      }

      if(!safe_found) {
        iprintln("<dev string:x206>");
      }
    }

    waitframe();
    timer++;

    if(timer >= drawframeduration) {
      timer = 0;
    }
  }
}

function function_32d74f3fc1994781(safe, drawframeduration) {
  line(safe.origin, safe.origin + (0, 0, 3000), (1, 0, 1), 1, 0, drawframeduration);
}

function function_bc558b6c272c65e4(safe, drawframeduration) {
  orientedbox(safe scriptablegetmidpoint(), 2 * function_abf76cc289cf03a3("<dev string:x258>"), safe.angles, (1, 1, 1), 0, drawframeduration);
}

function function_1071c808c36a9066(safe, drawframeduration) {
  sphere(safe.origin, safe.activity.capture_radius, (0, 1, 0), 0, drawframeduration);
  sphere(safe.origin, safe.activity.attract_radius, (1, 1, 0), 0, drawframeduration);
}

function function_d5622642498f5a6f(player) {
  level thread function_58ab5bffacda35c3(self, "<dev string:x28e>", "<dev string:x296>", player);
}

function function_8048ff4bc7646aa() {
  self.progress = self.activity.capture_time;
}

function function_a7c6874cd9ee87de() {
  self.contents = [];
  self.weaponslotcontents = undefined;
  common_cache::fillcontentsfromlist(self, self.activity.var_48c4ba670a4f33fc, 5);
}

# /
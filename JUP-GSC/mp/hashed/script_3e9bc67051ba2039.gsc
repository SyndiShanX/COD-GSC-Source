/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3e9bc67051ba2039.gsc
*************************************************/

#using script_2047cdbf5176ba0;
#using script_208955cb4d2c8fb3;
#using script_24fbedba9a7a1ef4;
#using script_41387eecc35b88bf;
#using script_42adcce5878f583;
#using script_6c0b7530cd3a13c2;
#using script_7e41e37180e554f;
#using script_edb8e725d068ac9;
#using scripts\common\callbacks;
#using scripts\common\elevators;
#using scripts\common\utility;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\equipment\haywire;
#using scripts\cp_mp\killstreaks\cluster_spike;
#using scripts\cp_mp\killstreaks\toma_strike;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\killstreaks\emp;
#using scripts\mp\mp_agent;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\player;
#using scripts\mp\utility\weapon;
#namespace namespace_d9c9ac29868e2ca3;

function private autoexec init() {
  function_21711608b2e7d28e();
  level thread function_9031e40019b7ccec();

  if(getdvarint(@ "hash_8ba27ae3ad8fe0ff", 0)) {
    level thread function_27b3015b1e088b91();
    level thread function_180bad6c8e8b1a6b();
  }

  if(getdvarint(@ "hash_56086f6984afa6e1", 1)) {
    level thread function_d5d05315d7f4e66e();
  }

  setdvarifuninitialized(@ "hash_2470a6b53048143", 0);
  setdvarifuninitialized(@ "hash_b41d26bb09b2350", 25);
  setdvarifuninitialized(@ "hash_9933082790c5598b", 60);

  level callback::add("player_damaged", &onplayerdamaged);
}

function autoexec main() {
  namespace_ad1f398af6f48cb1::setup_data("Rainmaker", "WARLORD_RAINMAKER");
  namespace_ad1f398af6f48cb1::function_56e8f78ce1511d35("Rainmaker", &oninitialization);
  scripts\engine\utility::registersharedfunc("warlords", "tile_i_warlord_registration", &function_5e1a85e581201961);
}

function private function_5e1a85e581201961() {
  if(!istrue(scripts\engine\utility::function_f3bb4f4911a1beb2("warlords", "warlordIsDisabled", "WARLORD_RAINMAKER"))) {
    namespace_609d2ee77dae3d8c::function_447c6ab4bea16b52("objective", "REV_OB_WARLORD", &namespace_75b9b66caa533c31::function_8abadf3d8f19384a, &namespace_57e9e22218a370fc::function_fd69cf02ba4d90a2);
  }
}

function function_21711608b2e7d28e() {
  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  var_573d2c3352e69370 = function_f159c10d5cf8f0b4("warlord_rainmaker_artillery_trigger", "script_noteworthy");

  if(var_573d2c3352e69370.size > 0) {
    level.artillerytrigger = var_573d2c3352e69370[0];
  }

  goalvolumes = function_f159c10d5cf8f0b4("noent_volume_info_RainmakerNavigation", "script_noteworthy");
  script_structs = scripts\engine\utility::getStructArray("warlord_rainmaker_pathing_structs", "script_noteworthy");

  foreach(struct in script_structs) {
    foreach(volume in goalvolumes) {
      if(ispointinvolume(struct.origin, volume)) {
        struct.goalvolume = volume;
        volume.var_ce7be1f918d2cc39 = [];
        break;
      }
    }
  }

  foreach(struct in script_structs) {
    function_5cbef930b01d17e1(struct, script_structs);
  }

  function_d485893eeb28fe80(script_structs);
  level.var_35230df813e64681 = goalvolumes;
}

function function_5cbef930b01d17e1(struct, structarray) {
  var_9d111be389b6648e = struct.goalvolume;
  var_9d111be389b6648e.var_a0146786134601f = [];
  tokens = strtoksubstr(struct.script_linkto, " ");

  foreach(linkname in tokens) {
    foreach(var_c9c04a2e50ed1560 in structarray) {
      if(linkname == var_c9c04a2e50ed1560.script_linkname) {
        var_9d111be389b6648e.var_a0146786134601f[var_9d111be389b6648e.var_a0146786134601f.size] = var_c9c04a2e50ed1560.goalvolume;
        break;
      }
    }
  }
}

function function_5a466c09a028e33(goalposition, var_6259a8bbad4aa772, goalvolume) {
  var_c6eff515d04cc390 = spawnStruct();
  var_c6eff515d04cc390.goalposition = goalposition.origin;
  var_c6eff515d04cc390.shootatpos = [];
  tokens = strtoksubstr(goalposition.script_linkto, " ");

  foreach(linkname in tokens) {
    var_c6eff515d04cc390.shootatpos[var_c6eff515d04cc390.shootatpos.size] = var_6259a8bbad4aa772[linkname];
  }

  goalvolume.var_ce7be1f918d2cc39[goalvolume.var_ce7be1f918d2cc39.size] = var_c6eff515d04cc390;
}

function function_d485893eeb28fe80(script_structs) {
  var_600c53aa59b932f2 = scripts\engine\utility::getStructArray("rainmaker_goal_position", "script_noteworthy");
  var_c8b43b8109e5e747 = scripts\engine\utility::getStructArray("rainmaker_shoot_position", "script_noteworthy");
  var_6259a8bbad4aa772 = [];

  foreach(var_d81905a317e06daf in var_c8b43b8109e5e747) {
    var_6259a8bbad4aa772[var_d81905a317e06daf.script_linkname] = var_d81905a317e06daf.origin;
  }

  foreach(goalposition in var_600c53aa59b932f2) {
    foreach(struct in script_structs) {
      if(ispointinvolume(goalposition.origin, struct.goalvolume)) {
        function_5a466c09a028e33(goalposition, var_6259a8bbad4aa772, struct.goalvolume);
        break;
      }
    }
  }
}

function function_9031e40019b7ccec() {
  level endon("rainmaker_death");

  while(!isDefined(level.ob) || !isDefined(level.ob.warlordparameters) || !isDefined(level.ob.warlordparameters["Rainmaker"])) {
    waitframe();
  }

  level.var_c75c33533d4e9c79 = namespace_ad1f398af6f48cb1::function_9acf953fd6bf2e46("Rainmaker");
}

function function_27b3015b1e088b91() {
  level endon("rainmaker_death");

  while(!isDefined(level.var_c75c33533d4e9c79)) {
    waitframe();
  }

  while(true) {
    if(isDefined(level.artillerytrigger)) {
      var_c90f3e9a90341c51 = scripts\mp\utility\player::getplayersinradius(level.artillerytrigger.origin, level.var_c75c33533d4e9c79.var_4e855a88264a2ed0);
      level.var_a687f3c894a818f8 = scripts\mp\utility\player::getplayersinradius(level.artillerytrigger.origin, level.var_c75c33533d4e9c79.var_d874ef4e462b9053);
      level.var_c90f3e9a90341c51 = array_exclude(var_c90f3e9a90341c51, level.var_a687f3c894a818f8);

      if(istrue(level.var_c169c24793aa2510)) {
        function_f3a391532c479335();
      }
    }

    wait 0.5;
  }
}

function function_180bad6c8e8b1a6b() {
  level endon("rainmaker_death");

  while(!isDefined(level.var_c75c33533d4e9c79) || !isDefined(level.artillerytrigger)) {
    waitframe();
  }

  wait 20;
  startpos = (level.artillerytrigger.origin[0], level.artillerytrigger.origin[1], -10000);
  var_90f3c62bbdb013a2 = scripts\mp\mp_agent::spawnnewagentaitype("actor_jup_ob_warlord_rainmaker", startpos, (0, 0, 0), "team_hundred_ninety");

  while(!isDefined(var_90f3c62bbdb013a2)) {
    var_90f3c62bbdb013a2 = scripts\mp\mp_agent::spawnnewagentaitype("actor_jup_ob_warlord_rainmaker", startpos, (0, 0, 0), "team_hundred_ninety");
    wait 1;
  }

  var_90f3c62bbdb013a2.var_5e81359581486a4a = level.var_c75c33533d4e9c79.var_4e855a88264a2ed0 * level.var_c75c33533d4e9c79.var_4e855a88264a2ed0;
  var_90f3c62bbdb013a2.var_ab7ba1695185b1f5 = level.var_c75c33533d4e9c79.var_d874ef4e462b9053 * level.var_c75c33533d4e9c79.var_d874ef4e462b9053;
  var_90f3c62bbdb013a2.var_45f1d0774d6a1062 = &function_c74cf854d6a608a;

  while(true) {
    if(isDefined(level.var_c90f3e9a90341c51) && level.var_c90f3e9a90341c51.size > 0) {
      if(!istrue(level.var_3117f91d1348da07)) {
        level.var_3117f91d1348da07 = 1;
      }

      function_ab9b53e987a83a20();
      var_90f3c62bbdb013a2.var_1ea7003bf817b657 = -1;
      var_90f3c62bbdb013a2.var_f92ea905e823c06b = [];

      foreach(player in level.var_c90f3e9a90341c51) {
        player.strikeindex = var_90f3c62bbdb013a2.var_1ea7003bf817b657 + 1;
        var_90f3c62bbdb013a2 thread scripts\cp_mp\killstreaks\toma_strike::function_5d38cccb518046f6(player, level.var_c75c33533d4e9c79.var_4e855a88264a2ed0, level.var_c75c33533d4e9c79.var_d874ef4e462b9053, level.var_c75c33533d4e9c79.var_a773fecfa7c44bbe);
      }

      wait level.var_c75c33533d4e9c79.var_2ac3c800559f7b7e;
      level.var_c169c24793aa2510 = 0;
    }

    waitframe();
  }
}

function oninitialization(agent, userdata) {
  function_c569e6ff571b9cd8(agent, level.var_c75c33533d4e9c79);
}

function function_c569e6ff571b9cd8(warlord, var_3716647cb96f1f04) {
  warlord.var_2ac3c800559f7b7e = var_3716647cb96f1f04.var_2ac3c800559f7b7e;
  warlord.var_4e855a88264a2ed0 = var_3716647cb96f1f04.var_4e855a88264a2ed0;
  warlord.var_d874ef4e462b9053 = var_3716647cb96f1f04.var_d874ef4e462b9053;
  warlord.var_4dd5c4885e94aaaa = var_3716647cb96f1f04.var_4dd5c4885e94aaaa;
  warlord.var_4cb267f38b5de2f2 = var_3716647cb96f1f04.var_a8b72b0b7f481d0b;
  warlord.var_9e29352ba1d54508 = var_3716647cb96f1f04.var_9e29352ba1d54508;
  warlord.var_fbc8bef50e9d8f8a = var_3716647cb96f1f04.var_fbc8bef50e9d8f8a;
  warlord.var_55811e2f54b0b1 = var_3716647cb96f1f04.var_55811e2f54b0b1;
  warlord.var_4b6686b7eee42901 = var_3716647cb96f1f04.var_deb24674c4e77a47;
  warlord.var_a773fecfa7c44bbe = var_3716647cb96f1f04.var_a773fecfa7c44bbe;
  warlord.var_6c3b39b37008b949 = var_3716647cb96f1f04.var_6c3b39b37008b949;
  warlord.var_fab3766f7a5dd61b = var_3716647cb96f1f04.var_fab3766f7a5dd61b;
  warlord.var_46d620779b96b55 = var_3716647cb96f1f04.var_46d620779b96b55;
  warlord.var_450f1b6abad414f7 = var_3716647cb96f1f04.var_450f1b6abad414f7;
  warlord.var_4c8cea60d20c5df5 = var_3716647cb96f1f04.var_4c8cea60d20c5df5;
  warlord.var_48f5467275b7ca3e = var_3716647cb96f1f04.var_48f5467275b7ca3e;
  warlord.var_561d2e92cbbf977 = var_3716647cb96f1f04.var_561d2e92cbbf977;
  warlord.var_d696242739e0212a = var_3716647cb96f1f04.var_d696242739e0212a;
  warlord.var_e2016d6d8138b836 = var_3716647cb96f1f04.var_e2016d6d8138b836;
  warlord.var_1c811e8ae01b583e = var_3716647cb96f1f04.var_1c811e8ae01b583e;
  warlord.var_687f80ad44cf3cd5 = var_3716647cb96f1f04.var_687f80ad44cf3cd5;
  warlord.var_5d7bb478881057d9 = var_3716647cb96f1f04.var_5d7bb478881057d9;
  warlord.var_ed33c6f7e6054607 = var_3716647cb96f1f04.var_ed33c6f7e6054607;
  warlord.var_80c845eda7764ce0 = var_3716647cb96f1f04.var_80c845eda7764ce0;
  warlord.var_7d606bec79308eb5 = 8;
  warlord.var_85a0f6383a5dd784 = 8;
  warlord.var_717eb05b8fb85cff = 200;
  warlord.disable_blindfire = 1;
  warlord.cannotmelee = 0;
  warlord thread function_68fad80d0201a649();
  self.streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("cluster_spike", self);
  warlord thread function_2b27a80ce1b6f8e7();
  warlord thread function_8f1a85a48ea00b86();
  warlord.callbackdamaged = &function_aa5cad64b9722461;

  warlord thread function_ed2c468813ce976();

  warlord.alreadydroppedweapon = 1;
  warlord.var_cc80b2a7d852fc72 = undefined;
  warlord.var_86a7393c497cf373 = undefined;
}

function function_ed2c468813ce976() {
  level endon("game_ended");
  self endon("death");
  self.debugstrings = [];

  while(true) {
    if(getdvarint(@ "hash_2470a6b53048143")) {
      var_83e5e59396640bcb = self.origin[2] + 50;

      foreach(debugstring in self.debugstrings) {
        print3d((self.origin[0], self.origin[1], var_83e5e59396640bcb), debugstring, (1, 1, 1), 1, 1, 1, 1);
        var_83e5e59396640bcb -= 15;
      }
    }

    waitframe();
  }
}

function function_9458a3d36f35f7f6(debugstring) {
  if(self.debugstrings.size >= 5) {
    self.debugstrings = array_remove_index(self.debugstrings, 0);
  }

  self.debugstrings[self.debugstrings.size] = debugstring;
}

function function_2b27a80ce1b6f8e7() {
  level endon("game_ended");
  self waittill("death");
  level notify("rainmaker_death");

  if(isDefined(self.var_42d423e36841d3f9)) {
    self.var_42d423e36841d3f9 delete();
  }
}

function function_8f1a85a48ea00b86() {
  level endon("game_ended");
  self endon("death");

  while(true) {
    waittill_any_3("goal_reached", "goal", "bad_path");

    if(isDefined(self.var_86a7393c497cf373)) {
      if(self istouching(self.var_86a7393c497cf373)) {
        if(getdvarint(@ "hash_2470a6b53048143")) {
          function_9458a3d36f35f7f6("reached volume");
        }

        self.currentvolume = self.var_86a7393c497cf373;
        self.currentvolume.var_4bf708235e05cf4 = gettime();
        self.var_86a7393c497cf373 = undefined;

        if(isDefined(self.enemy) && istrue(self cansee(self.enemy))) {
          self.var_2e9542e6411fb448 = 1;
        } else {
          function_301a5244fbd79585();
        }

        continue;
      }

      if(getdvarint(@ "hash_2470a6b53048143")) {
        function_9458a3d36f35f7f6("bad path");
      }

      self.var_2e9542e6411fb448 = 1;
      self.currentvolume = undefined;
      self.var_86a7393c497cf373 = undefined;
    }
  }
}

function function_301a5244fbd79585() {
  if(isDefined(self.currentvolume.var_ce7be1f918d2cc39) && self.currentvolume.var_ce7be1f918d2cc39.size > 0) {
    randomindex = randomint(2);

    if(randomindex == 1) {
      namespace_dc53a27a8db8e6bf::function_404390b3c8b3e9d3();
    }

    randomindex = randomint(self.currentvolume.var_ce7be1f918d2cc39.size);
    var_4033403f9569a79b = self.currentvolume.var_ce7be1f918d2cc39[randomindex];

    if(getdvarint(@ "hash_2470a6b53048143")) {
      function_9458a3d36f35f7f6("<dev string:x1c>");
    }

    var_76a0a00188d2de6a = self.var_5d7bb478881057d9;

    for(var_ee62689e58cb405a = 0; var_ee62689e58cb405a < var_4033403f9569a79b.shootatpos.size; var_ee62689e58cb405a++) {
      shootatpos = var_4033403f9569a79b.shootatpos[var_ee62689e58cb405a];
      var_6ee56c2253b6186a = scripts\mp\utility\weapon::_launchgrenade("cluster_spike_proj_mp", (shootatpos[0], shootatpos[1], shootatpos[2]), (0, 0, 0), var_76a0a00188d2de6a);
      var_6ee56c2253b6186a.lifetime = var_76a0a00188d2de6a;
      function_afdfa45c26a8e11e(var_6ee56c2253b6186a, self.secondaryweapon, self.streakinfo, self);
      var_6ee56c2253b6186a thread scripts\cp_mp\killstreaks\cluster_spike::function_daff421c657d09ca(0);
      var_6ee56c2253b6186a thread function_fd6a27936d8258f4();
      var_6ee56c2253b6186a thread function_e631697aecb20a52();
      var_6ee56c2253b6186a thread function_31ed07768061cbbf();
    }
  }
}

function function_68fad80d0201a649() {
  level endon("game_ended");
  self endon("death");
  utility::waittill_any_2("stealth_combat", "startCombatRush");
  var_2189bfeed28cbb65 = self.ob.var_2189bfeed28cbb65;
  var_3ecf047d758de560 = level.ob.var_3ecf047d758de560[var_2189bfeed28cbb65];
  level.var_ce26c3aea06b3627 = var_3ecf047d758de560.activityinstance.agents;

  foreach(bodyguard in level.var_ce26c3aea06b3627) {
    if(!isDefined(bodyguard) || !isalive(bodyguard)) {
      continue;
    }

    bodyguard thread function_7ae3b9570628c398();
  }

  ent_flag_wait("stealth_enabled");

  if(isDefined(self.fnsetstealthstate)) {
    self[[self.fnsetstealthstate]]("combat", undefined);
    self.var_5323a94889eff1de = 1;
    thread function_676d9d58a9b24b2b();
  }
}

function function_7ae3b9570628c398() {
  level endon("game_ended");
  self endon("death");
  ent_flag_wait("stealth_enabled");

  if(isDefined(self.fnsetstealthstate)) {
    self[[self.fnsetstealthstate]]("combat", undefined);
    self.var_5323a94889eff1de = 1;
    self.aggressivemode = 1;
  }
}

function function_676d9d58a9b24b2b() {
  self endon("death");
  self.cqb_wide_target_track = 1;
  self.allowstrafe = 0;
  self.var_2e9542e6411fb448 = 0;

  while(true) {
    var_1b7838e38c0b9cc8 = 0;

    if(!isDefined(self.var_86a7393c497cf373)) {
      var_1b7838e38c0b9cc8 = self.var_2e9542e6411fb448;

      if(!istrue(var_1b7838e38c0b9cc8) && isDefined(self.enemy)) {
        var_1b7838e38c0b9cc8 = istrue(self cansee(self.enemy));

        if(var_1b7838e38c0b9cc8) {
          if(getdvarint(@ "hash_2470a6b53048143")) {
            function_9458a3d36f35f7f6("<dev string:x36>");
          }
        }
      }

      if(!istrue(var_1b7838e38c0b9cc8)) {
        if(isDefined(self.currentvolume) && isDefined(self.currentvolume.var_4bf708235e05cf4)) {
          var_298481071aaa1114 = getdvarint(@ "hash_b41d26bb09b2350", 30);

          if(gettime() > self.currentvolume.var_4bf708235e05cf4 + var_298481071aaa1114 * 1000) {
            var_1b7838e38c0b9cc8 = 1;

            if(getdvarint(@ "hash_2470a6b53048143")) {
              function_9458a3d36f35f7f6("<dev string:x47>");
            }
          }
        }
      }
    }

    if(istrue(var_1b7838e38c0b9cc8)) {
      self.var_abc30858a62a19a = undefined;
      self.favoriteenemy = undefined;
      self.weapon = self.primaryweapon;
      self.var_86a7393c497cf373 = function_b09d8883b33c860e();

      if(isDefined(self.var_86a7393c497cf373)) {
        if(getdvarint(@ "hash_2470a6b53048143")) {
          function_9458a3d36f35f7f6("<dev string:x68>");
        }

        self.allowstrafe = !self.var_2e9542e6411fb448;
        self.var_2e9542e6411fb448 = 0;
        self.currentvolume = undefined;
      } else {
        if(getdvarint(@ "hash_2470a6b53048143")) {
          function_9458a3d36f35f7f6("<dev string:x7f>");
        }
      }

      continue;
    }

    waitframe();
  }
}

function function_82715a7f2354ae05(player, var_d09ffb0c16d28986) {
  if(isDefined(player)) {
    mindist = 100000;
    var_d97c8dfa3affb9d7 = undefined;

    foreach(volume in level.var_35230df813e64681) {
      if(istrue(var_d09ffb0c16d28986)) {
        if(player istouching(volume)) {
          return volume;
        }
      }

      var_f181abaaf01bdb7e = distance2d(player.origin, volume.origin);

      if(var_f181abaaf01bdb7e < mindist) {
        mindist = var_f181abaaf01bdb7e;
        var_d97c8dfa3affb9d7 = volume;
      }
    }

    return var_d97c8dfa3affb9d7;
  }

  return undefined;
}

function function_4dccffe22b56236e(var_4fdb88f131e8d4dd) {
  var_7bd4c04f44071f20 = [var_4fdb88f131e8d4dd];
  var_3c493ac108502466 = 0;
  var_82cd646d8c332eed = undefined;
  var_650e0b1c7a0b3592 = var_7bd4c04f44071f20[0];

  if(isDefined(var_650e0b1c7a0b3592.var_a0146786134601f) && var_650e0b1c7a0b3592.var_a0146786134601f.size == 0) {
    return var_650e0b1c7a0b3592;
  }

  foreach(volume in level.var_35230df813e64681) {
    volume.visited = 0;
  }

  var_7bd4c04f44071f20 = array_remove(var_7bd4c04f44071f20, var_650e0b1c7a0b3592);

  foreach(var_45419c181561e308 in var_650e0b1c7a0b3592.var_a0146786134601f) {
    var_7bd4c04f44071f20[var_7bd4c04f44071f20.size] = var_45419c181561e308;
  }

  enemypos = self.enemy.origin;
  var_49c14f47fcce341 = self.origin;
  var_52292a202c06aad0 = enemypos - var_49c14f47fcce341;
  bestscore = 100;
  maxdistance = 500;
  var_94bfb285a004844b = 200;
  var_7972708881797f96 = clamp(getdvarint(@ "hash_9933082790c5598b", 60), 0, 100);

  while(var_7bd4c04f44071f20.size > 0) {
    var_650e0b1c7a0b3592 = var_7bd4c04f44071f20[0];
    var_7bd4c04f44071f20 = array_remove(var_7bd4c04f44071f20, var_650e0b1c7a0b3592);

    if(var_650e0b1c7a0b3592.visited) {
      continue;
    }

    foreach(var_45419c181561e308 in var_650e0b1c7a0b3592.var_a0146786134601f) {
      if(!var_45419c181561e308.visited) {
        var_7bd4c04f44071f20[var_7bd4c04f44071f20.size] = var_45419c181561e308;
      }
    }

    var_650e0b1c7a0b3592.visited = 1;

    if(isDefined(var_650e0b1c7a0b3592.var_ec4a9cd2bd806a45) && var_650e0b1c7a0b3592.var_ec4a9cd2bd806a45 > gettime()) {
      continue;
    }

    if(self.enemy istouching(var_650e0b1c7a0b3592)) {
      continue;
    }

    var_5ad14a791e92e5de = var_650e0b1c7a0b3592.origin - var_49c14f47fcce341;
    var_8d2cdcc4f6656482 = clamp(length(var_5ad14a791e92e5de), maxdistance * -1, maxdistance);
    var_5e806028e12e5d5c = var_650e0b1c7a0b3592.origin - enemypos;
    var_5e770d4facac279c = clamp(length(var_5e806028e12e5d5c), maxdistance * -1, maxdistance);
    dotresult = vectordot2(var_5ad14a791e92e5de, var_52292a202c06aad0, 1);
    var_f091876222002846 = clamp(dotresult, -1, 1);
    var_b2558b26576482dc = clamp((var_8d2cdcc4f6656482 - var_5e770d4facac279c) / var_94bfb285a004844b, -1, 1);
    var_f091876222002846 *= abs(var_7972708881797f96 - 100);
    var_b2558b26576482dc *= var_7972708881797f96;
    totalscore = var_f091876222002846 + var_b2558b26576482dc;

    if(totalscore < bestscore) {
      var_82cd646d8c332eed = var_650e0b1c7a0b3592;
      bestscore = totalscore;
    }
  }

  return var_82cd646d8c332eed;
}

function function_6e806760e71f12f4() {
  if(isDefined(self.enemy)) {
    var_79735f4f3c50b67f = function_82715a7f2354ae05(self.enemy, 1);
    var_82cd646d8c332eed = function_4dccffe22b56236e(var_79735f4f3c50b67f);
    assertex(isDefined(var_82cd646d8c332eed), "<dev string:x9e>");

    if(isDefined(var_82cd646d8c332eed)) {
      var_82cd646d8c332eed.var_ec4a9cd2bd806a45 = gettime() + self.var_1c811e8ae01b583e;
    } else {
      var_82cd646d8c332eed = function_82715a7f2354ae05(self, 0);
      assertex(isDefined(var_82cd646d8c332eed), "<dev string:xec>");
    }

    return var_82cd646d8c332eed;
  }

  if(isDefined(self.currentvolume)) {
    var_79735f4f3c50b67f = self.currentvolume;
  } else {
    var_79735f4f3c50b67f = function_82715a7f2354ae05(self, 0);
  }

  return var_79735f4f3c50b67f;
}

function function_57a3d585c67d14ce() {
  if(!isDefined(self.var_1e37cec111de0b73)) {
    self.var_1e37cec111de0b73 = [];
  } else if(self.var_1e37cec111de0b73.size > 0) {
    foreach(guard in self.var_1e37cec111de0b73) {
      if(isalive(guard) && guard.team == self.team && guard != self && guard.type != "zombie") {
        guard setgoalvolume(level.artillerytrigger);
      }
    }

    self.var_1e37cec111de0b73 = [];
  }

  var_bf62a00f05bfd1f8 = [];

  foreach(guard in level.var_ce26c3aea06b3627) {
    if(isalive(guard) && guard != self && guard.type != "zombie") {
      var_bf62a00f05bfd1f8[var_bf62a00f05bfd1f8.size] = guard;
    }
  }

  level.var_ce26c3aea06b3627 = var_bf62a00f05bfd1f8;
  var_a9b0b4b9b8c62859 = get_array_of_closest(self.var_d7a4855ccf041ea3, level.var_ce26c3aea06b3627);

  foreach(guard in var_a9b0b4b9b8c62859) {
    if(self.var_1e37cec111de0b73.size >= 2) {
      break;
    }

    self.var_1e37cec111de0b73[self.var_1e37cec111de0b73.size] = guard;
    guard setgoalvolumeauto(self.currentvolume);
  }
}

function function_b09d8883b33c860e() {
  var_cc80b2a7d852fc72 = function_6e806760e71f12f4();

  if(isDefined(var_cc80b2a7d852fc72)) {
    randomindex = randomint(var_cc80b2a7d852fc72.var_ce7be1f918d2cc39.size);
    var_4033403f9569a79b = var_cc80b2a7d852fc72.var_ce7be1f918d2cc39[randomindex];
    self.var_d7a4855ccf041ea3 = var_4033403f9569a79b.goalposition;
    self aisetdesiredspeed(300);

    if(isDefined(self.navobstacle)) {
      destroynavobstacle(self.navobstacle);
    }

    if(isDefined(self.enemy) && isPlayer(self.enemy)) {
      self.navobstacle = createnavbadplacebybounds(self.enemy.origin, (50, 50, 10), self.enemy.angles);
    }

    self setgoalpos(self.var_d7a4855ccf041ea3, 32);

    if(getdvarint(@ "hash_2470a6b53048143")) {
      var_1a4174d99b840ce3 = "<dev string:x125>" + self.var_d7a4855ccf041ea3[0] + "<dev string:x12b>" + self.var_d7a4855ccf041ea3[1] + "<dev string:x12b>" + self.var_d7a4855ccf041ea3[2] + "<dev string:x131>";
      function_9458a3d36f35f7f6("<dev string:x136>" + var_1a4174d99b840ce3);
    }
  }

  return var_cc80b2a7d852fc72;
}

function function_afdfa45c26a8e11e(clusterspike, weaponobj, streakinfo, owner) {
  if(!isDefined(level.clusterspikes)) {
    level.clusterspikes = [];
  }

  if(!isDefined(level.clusterspikes[owner.team])) {
    level.clusterspikes[owner.team] = [];
  }

  if(!isDefined(level.var_c255eb9109a38f9f)) {
    level.var_c255eb9109a38f9f = 0;
  }

  level.var_c255eb9109a38f9f++;
  bundle = level.streakglobals.streakbundles["cluster_spike"];
  clusterspike.owner = owner;
  clusterspike.bundle = bundle;
  clusterspike.team = owner.team;
  clusterspike.ownerid = "ownerID_" + owner getentitynumber();
  clusterspike.clusterid = clusterspike.ownerid + "_" + level.var_c255eb9109a38f9f;
  clusterspike.equipmentref = "cluster_spike_proj_mp";
  clusterspike.weapon_object = weaponobj;
  clusterspike.health = 99999;
  clusterspike.maxhealth = self.var_80c845eda7764ce0;
  clusterspike.lifetime = self.var_5d7bb478881057d9;
  clusterspike.damageoverwrite = self.var_ed33c6f7e6054607;

  if(issharedfuncdefined("cluster_spike", "attachXRays")) {
    clusterspike = [[getsharedfunc("cluster_spike", "attachXRays")]](clusterspike);
  }

  clusterspike.streakinfo = streakinfo;
  clusterspike.damagetaken = 0;
  clusterspike.headiconid = clusterspike scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 10, undefined, undefined, undefined, undefined, 1);
  clusterspike setentityowner(owner);
  clusterspike setotherent(owner);
  clusterspike setCanDamage(1);

  if(isDefined(clusterspike.streakinfo) && issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    clusterspike[[getsharedfunc("killstreak", "addToActiveKillstreakList")]](streakinfo.streakname, "Killstreak_Ground", owner);
  }

  clusterspike scripts\cp_mp\equipment\haywire::function_172d848d58051fdf(&function_7558c2019a377bd9);
  clusterspike scripts\cp_mp\emp_debuff::set_start_emp_callback(&function_4d7b7570ddab816d);
  clusterspike scripts\killstreaks\emp::setemp_applied_callback(&function_4d7b7570ddab816d);
  clusterspike scripts\cp_mp\emp_debuff::set_clear_emp_callback(&function_1d0735b9c8b14634);
  clusterspike scripts\killstreaks\emp::setemp_cleared_callback(&function_1d0735b9c8b14634);
  clusterspike function_49197cd063a740ea(&function_9537ab94dab9a1c0);

  if(isDefined(level.elevators)) {
    foreach(elevators in level.elevators) {
      elevators thread scripts\common\elevators::isentitytouchingdoortrigger(clusterspike);
    }
  }

  if(!isDefined(level.clusterspikes[clusterspike.team][clusterspike.ownerid])) {
    level.clusterspikes[clusterspike.team][clusterspike.ownerid] = [];
  }

  level.clusterspikes[clusterspike.team][clusterspike.ownerid][level.clusterspikes[clusterspike.team][clusterspike.ownerid].size] = clusterspike;
}

function function_e631697aecb20a52() {
  self endon("explode_cluster_spike");
  level endon("game_ended");
  level endon("removed_" + self.clusterid);
  self.owner waittill("death");
  thread scripts\cp_mp\killstreaks\cluster_spike::clusterspike_explode("explode");
}

function function_31ed07768061cbbf() {
  self.owner endon("death");
  level endon("game_ended");
  level waittill("removed_" + self.clusterid);

  if(isDefined(self.owner) && isDefined(self.owner.currentvolume)) {
    var_3da53988b9b3ff04 = self istouching(self.owner.currentvolume);

    if(istrue(var_3da53988b9b3ff04)) {
      if(getdvarint(@ "hash_2470a6b53048143")) {
        self.owner function_9458a3d36f35f7f6("mine in current volume exploded");
      }

      self.owner.var_2e9542e6411fb448 = 1;
    }
  }
}

function onplayerdamaged(sparams) {
  if(!isDefined(sparams)) {
    return;
  }

  if(!isDefined(sparams.idamage) || sparams.idamage <= 0) {
    return;
  }

  if(isDefined(sparams.eattacker) && is_equal(sparams.eattacker.agent_type, "actor_jup_ob_warlord_rainmaker")) {
    if(isDefined(sparams.objweapon) && is_equal(sparams.objweapon.var_9d7facbe889e667c, %"cluster_spike")) {
      sparams.eattacker namespace_dc53a27a8db8e6bf::function_80e71915de4ee2ca(sparams.victim);
    }
  }
}

function function_aa5cad64b9722461(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  idamage = namespace_ad1f398af6f48cb1::function_395c3a00db83ba6(idamage, smeansofdeath, objweapon);

  if(!isDefined(self.var_86a7393c497cf373)) {
    if(getdvarint(@ "hash_2470a6b53048143")) {
      function_9458a3d36f35f7f6("took damage in current volume");
    }

    self.var_2e9542e6411fb448 = 1;
  }

  namespace_daa149ca485fd50a::function_dffac413ed66bcd0(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
}

function function_d5d05315d7f4e66e() {
  level endon("game_ended");

  while(true) {
    level waittill("on_mortar_setup", mortar);

    if(!isDefined(mortar)) {
      continue;
    }

    activityinstance = mortar.activityinstance;

    if(!isDefined(activityinstance) || !isDefined(activityinstance.varianttag) || activityinstance.varianttag != "WARLORD_RAINMAKER") {
      continue;
    }

    thread function_1caad3558a2b6fbd(mortar);
  }
}

function function_1caad3558a2b6fbd(mortar) {
  if(!isDefined(mortar)) {
    assertmsg("<dev string:x155>");
    return;
  }

  mortar.get_mortar_impact_pos = &function_7a7122e8e752d0e;
}

function function_ab9b53e987a83a20() {
  foreach(player in level.var_c90f3e9a90341c51) {
    player.var_5a01d5ecee70342f = 0;
    player.var_563b6b50bcb5c28e = 0;
  }

  foreach(player in level.var_c90f3e9a90341c51) {
    if(!istrue(player.var_5a01d5ecee70342f)) {
      player.var_563b6b50bcb5c28e = 1;
      playersinrange = scripts\mp\utility\player::getplayersinradius(player.origin, level.var_c75c33533d4e9c79.var_561d2e92cbbf977);

      foreach(var_458e8f43d070e248 in playersinrange) {
        if(var_458e8f43d070e248 != player && !istrue(var_458e8f43d070e248.var_563b6b50bcb5c28e)) {
          var_458e8f43d070e248.var_5a01d5ecee70342f = 1;
        }
      }
    }
  }

  level.var_c169c24793aa2510 = 1;
}

function function_f3a391532c479335() {
  foreach(player in level.var_c90f3e9a90341c51) {
    player.var_5a01d5ecee70342f = 0;
  }

  foreach(player in level.var_c90f3e9a90341c51) {
    playersinrange = scripts\mp\utility\player::getplayersinradius(player.origin, level.var_c75c33533d4e9c79.var_561d2e92cbbf977);

    if(istrue(player.var_563b6b50bcb5c28e)) {
      foreach(var_458e8f43d070e248 in playersinrange) {
        if(var_458e8f43d070e248 != player && !istrue(var_458e8f43d070e248.var_563b6b50bcb5c28e)) {
          var_458e8f43d070e248.var_5a01d5ecee70342f = 1;
        }
      }

      continue;
    }

    if(!istrue(player.var_5a01d5ecee70342f)) {
      player.var_563b6b50bcb5c28e = 1;

      foreach(var_458e8f43d070e248 in playersinrange) {
        if(var_458e8f43d070e248 != player && !istrue(var_458e8f43d070e248.var_563b6b50bcb5c28e)) {
          var_458e8f43d070e248.var_5a01d5ecee70342f = 1;
        }
      }
    }
  }
}

function function_cf455b2940f3439b(var_1f703e0077375016, enemyplayer) {
  if(!isDefined(self.var_f92ea905e823c06b)) {
    self.var_f92ea905e823c06b = [];
  }

  var_fab3766f7a5dd61b = level.var_c75c33533d4e9c79.var_fab3766f7a5dd61b.walksetting;
  var_6c3b39b37008b949 = level.var_c75c33533d4e9c79.var_6c3b39b37008b949.walksetting;
  var_450f1b6abad414f7 = level.var_c75c33533d4e9c79.var_450f1b6abad414f7.walksetting;
  var_46d620779b96b55 = level.var_c75c33533d4e9c79.var_46d620779b96b55.walksetting;
  predicttime = level.var_c75c33533d4e9c79.var_4c8cea60d20c5df5.walksetting;
  var_48f5467275b7ca3e = level.var_c75c33533d4e9c79.var_48f5467275b7ca3e.walksetting;

  if(enemyplayer isinvehicle()) {
    var_fab3766f7a5dd61b = level.var_c75c33533d4e9c79.var_fab3766f7a5dd61b.vehiclesetting;
    var_6c3b39b37008b949 = level.var_c75c33533d4e9c79.var_6c3b39b37008b949.vehiclesetting;
    var_450f1b6abad414f7 = level.var_c75c33533d4e9c79.var_450f1b6abad414f7.vehiclesetting;
    var_46d620779b96b55 = level.var_c75c33533d4e9c79.var_46d620779b96b55.vehiclesetting;
    predicttime = level.var_c75c33533d4e9c79.var_4c8cea60d20c5df5.vehiclesetting;
    var_48f5467275b7ca3e = level.var_c75c33533d4e9c79.var_48f5467275b7ca3e.vehiclesetting;
  }

  var_93f11a32145a1e65 = randomfloat(100);

  if(var_6c3b39b37008b949 == 0) {
    var_93f11a32145a1e65 = 100;
  } else if(var_46d620779b96b55 == -180) {
    var_93f11a32145a1e65 = 0;
  }

  var_c2ff1fc2272a57ea = randomfloatrange(var_fab3766f7a5dd61b, var_6c3b39b37008b949);

  if(var_93f11a32145a1e65 > 50) {
    var_c2ff1fc2272a57ea = randomfloatrange(var_450f1b6abad414f7, var_46d620779b96b55);
  }

  enemyvelocity = enemyplayer getvelocity();
  var_8e68e964194ca81c = anglesToForward(enemyplayer getplayerangles());

  if(enemyplayer isinvehicle()) {
    enemyvelocity = enemyplayer.vehicle vehicle_getvelocity();
    var_8e68e964194ca81c = anglesToForward(enemyplayer.vehicle.angles);
  }

  var_541ef460c399d0af = (var_8e68e964194ca81c[0], var_8e68e964194ca81c[1], 0);
  dotresult = vectordot2(var_541ef460c399d0af, enemyvelocity);
  var_9bb55a603d122a0a = length2d(enemyvelocity);

  if(dotresult < 0) {
    var_9bb55a603d122a0a *= -1;
  }

  var_7ae9e8eaecaa7bf0 = var_9bb55a603d122a0a * predicttime * var_541ef460c399d0af;
  var_3609de6106cc37a6 = enemyplayer.origin + var_7ae9e8eaecaa7bf0;
  var_374077be0cb948ed = distance2dsquared(self.origin, var_3609de6106cc37a6);
  attackdirection = rotatevector(var_541ef460c399d0af, (0, var_c2ff1fc2272a57ea, 0));
  var_fdc0f8e513727c = int(ceil(level.var_c75c33533d4e9c79.var_4dd5c4885e94aaaa / 2));
  var_7027c3682be5b65e = randomintrange(int(var_fdc0f8e513727c), level.var_c75c33533d4e9c79.var_4dd5c4885e94aaaa - 1);
  var_3afb58537e1a70b = var_3609de6106cc37a6 - attackdirection * var_48f5467275b7ca3e * var_7027c3682be5b65e;
  self.var_f92ea905e823c06b[enemyplayer.strikeindex] = [];

  for(i = 0; i < level.var_c75c33533d4e9c79.var_4dd5c4885e94aaaa; i++) {
    self.var_f92ea905e823c06b[enemyplayer.strikeindex][i] = var_3afb58537e1a70b + attackdirection * var_48f5467275b7ca3e * i;
  }
}

function function_c74cf854d6a608a(strikeindex, var_1f703e0077375016, enemyplayer) {
  if(strikeindex == 0) {
    function_cf455b2940f3439b(var_1f703e0077375016, enemyplayer);
  }

  if(!enemyplayer.var_563b6b50bcb5c28e) {
    return undefined;
  }

  targetposition = enemyplayer.origin;
  predictposition = self.var_f92ea905e823c06b[enemyplayer.strikeindex][strikeindex];
  distancesq = distance2dsquared(self.origin, enemyplayer.origin);
  var_1875ce76d9a825a1 = distance2dsquared(self.origin, predictposition);

  if(distancesq >= self.var_5e81359581486a4a || distancesq <= self.var_ab7ba1695185b1f5 || var_1875ce76d9a825a1 >= self.var_5e81359581486a4a || var_1875ce76d9a825a1 <= self.var_ab7ba1695185b1f5 || !enemyplayer _isalive()) {
    targetposition = undefined;
  } else if(istrue(enemyplayer.inlaststand) && isDefined(enemyplayer.var_26c0564a02fd4085)) {
    targetposition = enemyplayer.var_26c0564a02fd4085;
  } else {
    targetposition = predictposition;
    enemyplayer.var_26c0564a02fd4085 = enemyplayer.origin;
  }

  return targetposition;
}

function function_7a7122e8e752d0e(mortar) {
  if(!isDefined(mortar.current_target)) {
    return undefined;
  }

  targetplayer = mortar.current_target;
  var_1e5f51b3e019ba0e = targetplayer getvelocity();
  var_b9b8f5f328f2ea66 = vectorNormalize(var_1e5f51b3e019ba0e);

  if(targetplayer isinvehicle()) {
    var_1e5f51b3e019ba0e = targetplayer.vehicle vehicle_getvelocity();
    var_b9b8f5f328f2ea66 = anglesToForward(targetplayer.vehicle.angles);
  }

  var_a5c4c8f847138d19 = (var_b9b8f5f328f2ea66[0], var_b9b8f5f328f2ea66[1], 0);
  dotresult = vectordot2(var_a5c4c8f847138d19, var_1e5f51b3e019ba0e);
  var_a70df942d629dc64 = length2d(var_1e5f51b3e019ba0e);

  if(dotresult < 0) {
    var_a70df942d629dc64 *= -1;
  }

  predicttime = mortar.var_1115d9ebad86e77;
  var_7ae9e8eaecaa7bf0 = var_a70df942d629dc64 * predicttime * var_a5c4c8f847138d19;
  var_5ff1ff224dfc1f00 = targetplayer.origin + var_7ae9e8eaecaa7bf0;

  var_9aa85e169936c47b = 5;

  if(getdvarint(@ "hash_4563c903992d7a07", 0)) {
    level thread scripts\mp\utility\debug::drawsphere(targetplayer.origin, 5, var_9aa85e169936c47b, (1, 0, 0));
    level thread scripts\mp\utility\debug::drawline(mortar.origin, targetplayer.origin, var_9aa85e169936c47b, (1, 0, 0));
    level thread scripts\mp\utility\debug::drawsphere(var_5ff1ff224dfc1f00, 5, var_9aa85e169936c47b, (0, 1, 0));
    level thread scripts\mp\utility\debug::drawline(mortar.origin, var_5ff1ff224dfc1f00, var_9aa85e169936c47b, (0, 1, 0));
    level thread scripts\mp\utility\debug::drawline(targetplayer.origin, targetplayer.origin + 100 * var_a5c4c8f847138d19, var_9aa85e169936c47b, (1, 1, 0));
  }

  ignorearray = [];
  ignorearray[ignorearray.size] = targetplayer;
  trace = scripts\engine\trace::ray_trace(var_5ff1ff224dfc1f00 + (0, 0, 500), var_5ff1ff224dfc1f00, ignorearray);
  return trace["position"];
}
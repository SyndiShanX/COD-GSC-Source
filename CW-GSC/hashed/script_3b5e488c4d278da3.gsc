/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3b5e488c4d278da3.gsc
***********************************************/

#using script_27347f09888ad15;
#using script_34ab99a4ca1a43d;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_world;
#using scripts\core_common\item_world_util;
#using scripts\core_common\math_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm\powerup\zm_powerup_naughty_or_nice;
#using scripts\zm_common\aats\ammomods\ammomod_cryofreeze;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#namespace namespace_3bb7295f;

function private autoexec __init__system__() {
  system::register(#"hash_4e2289c68f35238d", &preinit, &init, undefined, undefined);
}

function preinit() {
  if((is_true(getgametypesetting(#"hash_7e8e34cc69a77e0b")) || getdvarint(#"hash_40bd34b35079cf2e", 0) > 0) && (zm_utility::is_classic() || util::get_game_type() === # "zholiday")) {
    setDvar(#"hash_34cae673a047c202", 1);
  }
}

function init() {
  if((is_true(getgametypesetting(#"hash_7e8e34cc69a77e0b")) || getdvarint(#"hash_40bd34b35079cf2e", 0) > 0) && (zm_utility::is_classic() || util::get_game_type() === # "zholiday")) {
    namespace_679a22ba::function_3ba2f5dd(#"hash_9c00f9e4e4bd95a", #"silver_ai_zombie_xmas");
    namespace_679a22ba::function_3ba2f5dd(#"hash_539facc2c096b82", #"silver_ai_zombie_heavy_xmas");
    namespace_679a22ba::function_3ba2f5dd(#"hash_208e2483f559ccd2", #"silver_ai_dog_xmas");
    namespace_679a22ba::function_3ba2f5dd(#"hash_47bae14a2b1b4511", #"silver_ai_zombie_mega_xmas");
    level.var_8f576c00 = [# "hash_5214ebcccbd95a36": # "hash_796dff2ea842c1ac", #"hash_19ef16d1ba01a5": # "hash_7725a0435b44b1e5", #"hash_12a17ab3df5889eb": # "hash_2792674ef4fce09f", #"hash_53f4e0daa341a161": # "hash_156c697af81feaf9", #"spawner_zm_steiner": # "hash_43b8d4f24851653e", #"hash_7f957e36b4f6160f": # "hash_5e24e4aa952bb1bb", #"spawner_zm_steiner_split_radiation_blast": # "hash_2c0da7720a1c2f90", #"hash_6904f5c7bef64405": # "hash_1d599c94a087ca05", #"spawner_zm_steiner_split_radiation_bomb": # "hash_16d309f1ce9e015a"];
    level.overridezombiespawn = &function_767a6a84;
    level.var_9d098364 = # "hash_43b8d4f24851653e";
    level.var_c42bdd1b = # "hash_2c0da7720a1c2f90";
    level.var_dc38daf = # "hash_16d309f1ce9e015a";
    level.var_d3d40dcb = # "hash_156c697af81feaf9";
    level.var_68b26ea = # "hash_2c0da7720a1c2f90";
    level.var_887c5017 = # "hash_16d309f1ce9e015a";
    level.var_9e513533 = # "c_t9_zmb_zombie_heavy_helmet_xmas";
    level.var_eea9f85a = # "c_t9_zmb_zombie_heavy_torso_armor_xmas";
    level.var_1a4cc228[# "hash_796dff2ea842c1ac"] = [# "hash_7f5ab1dc6cfb5e8b", #"hash_7d3fe2134df8b974", #"hash_7808152e8467362f", #"hash_50645fbb1e049528", #"hash_4cc6bea1049efc55", #"hash_9c9737cf22069a5", #"hash_55cd178e8d6db2aa"];
    level.var_1a4cc228[# "hash_2792674ef4fce09f"] = [# "hash_7247a6e723dbd7ab"];
    level.var_1a4cc228[# "hash_2c0da7720a1c2f90"] = [# "hash_78bcaad275fa3c26"];
    level.var_1a4cc228[# "hash_16d309f1ce9e015a"] = [# "hash_5392a8401b0e3133"];
    level.var_1a4cc228[# "hash_7725a0435b44b1e5"] = [# "hash_4062a2032d2c9a34"];
    level.var_f546b995 = "winter";
    level thread function_3a268da9();
    callback::on_ai_damage(&on_ai_damaged);
    callback::on_ai_killed(&on_ai_killed);
    level.var_77143112 = [];
    level.var_76dd228a = [];
    a_s_snowball_piles = struct::get_array("snowball_pile", "targetname");
    var_3e0f6c4b = struct::get_array("snow_mound", "targetname");

    foreach(var_97ba446e in var_3e0f6c4b) {
      temp_ent = spawn("script_origin", var_97ba446e.origin);
      zone = temp_ent zm_utility::get_current_zone(1);
      temp_ent delete();

      if(isDefined(zone)) {
        zone.var_b5490369 = 1;
        var_97ba446e.zone = zone;

        if(!isDefined(level.var_77143112)) {
          level.var_77143112 = [];
        } else if(!isarray(level.var_77143112)) {
          level.var_77143112 = array(level.var_77143112);
        }

        if(!isinarray(level.var_77143112, zone)) {
          level.var_77143112[level.var_77143112.size] = zone;
        }

        if(!isDefined(zone.var_6284d1b2)) {
          zone.var_6284d1b2 = [];
        }

        if(!isDefined(zone.var_6284d1b2)) {
          zone.var_6284d1b2 = [];
        } else if(!isarray(zone.var_6284d1b2)) {
          zone.var_6284d1b2 = array(zone.var_6284d1b2);
        }

        if(!isinarray(zone.var_6284d1b2, var_97ba446e)) {
          zone.var_6284d1b2[zone.var_6284d1b2.size] = var_97ba446e;
        }

        if(!isDefined(zone.var_a5015123)) {
          zone.var_a5015123 = [];
        }
      }
    }

    foreach(s_snowball_pile in a_s_snowball_piles) {
      temp_ent = spawn("script_origin", s_snowball_pile.origin);
      zone = temp_ent zm_utility::get_current_zone(1);
      temp_ent delete();

      if(isDefined(zone)) {
        zone.var_fbc00b53 = 1;
        s_snowball_pile.zone = zone;

        if(!isDefined(level.var_76dd228a)) {
          level.var_76dd228a = [];
        } else if(!isarray(level.var_76dd228a)) {
          level.var_76dd228a = array(level.var_76dd228a);
        }

        if(!isinarray(level.var_76dd228a, zone)) {
          level.var_76dd228a[level.var_76dd228a.size] = zone;
        }

        if(!isDefined(zone.var_45d884e6)) {
          zone.var_45d884e6 = [];
        }

        if(!isDefined(zone.var_45d884e6)) {
          zone.var_45d884e6 = [];
        } else if(!isarray(zone.var_45d884e6)) {
          zone.var_45d884e6 = array(zone.var_45d884e6);
        }

        if(!isinarray(zone.var_45d884e6, s_snowball_pile)) {
          zone.var_45d884e6[zone.var_45d884e6.size] = s_snowball_pile;
        }

        if(!isDefined(zone.var_4acb65df)) {
          zone.var_4acb65df = [];
        }
      }
    }

    function_bf79a643();
    function_a05df3a7();
    level thread function_128f3b6b();
    level.var_162c45e4 = 1;
    level.var_72182681 = 1;
    thread function_e71942eb();
    callback::on_spawned(&function_8f677e13);
  }
}

function function_e71942eb() {
  level endon(#"end_game");
  waittillframeend();
  level flag::wait_till("all_players_spawned");
  players = getplayers();

  foreach(player in players) {
    player thread function_6f65e552();
    player function_8f677e13();
  }
}

function function_6f65e552() {
  self endon(#"death", #"disconnect");
  var_4531f22a = 0;

  while(true) {
    if(var_4531f22a >= 3) {
      return;
    }

    self waittill(#"loadout_given");
    var_4531f22a++;
    self function_8f677e13();
    wait 1;
  }
}

function function_767a6a84(spawner, target_name, spawn_point, round_number) {
  if(isDefined(level.var_8f576c00[round_number.aitype])) {
    return spawnactor(level.var_8f576c00[round_number.aitype], round_number.origin, round_number.angles, 0, 1, 0, round_number);
  }

  return round_number spawnfromspawner(0, 1);
}

function function_a05df3a7() {
  var_2c4241da = struct::get_array("xmas_tree", "targetname");

  foreach(location in var_2c4241da) {
    tree = spawn("script_model", location.origin);
    tree.angles = location.angles;
    tree setModel("p9_zm_silver_foliage_tree_christmas_full");
    tree solid();
    tree disconnectpaths();
  }
}

function function_bf79a643() {
  foreach(zone in level.var_76dd228a) {
    if(!isDefined(zone.var_6cff21f5)) {
      zone.var_6cff21f5 = 0;
    }

    if(isDefined(zone.var_4acb65df)) {
      function_1eaaceab(zone.var_4acb65df);

      if(zone.var_6cff21f5 < 3) {
        index = 0;

        if(zone.var_45d884e6.size === 0) {
          continue;
        } else if(zone.var_45d884e6.size > 1) {
          index = randomint(zone.var_45d884e6.size);
        }

        var_e779ff3c = 0;
        players_in_range = getplayers(undefined, zone.var_45d884e6[index].origin, 910);
        players = getplayers();

        foreach(player in players) {
          if(player util::is_looking_at(zone.var_45d884e6[index], 0.8, 1, (0, 0, 16))) {
            var_e779ff3c = 1;
          }
        }

        if(is_true(zone.var_fbc00b53) || var_e779ff3c === 0 && players_in_range.size === 0) {
          zone.var_45d884e6[index] function_f5527ca2(zone);
          arrayremoveindex(zone.var_45d884e6, index);
        }
      }
    }

    zone.var_fbc00b53 = 0;
  }

  foreach(zone in level.var_77143112) {
    if(!isDefined(zone.var_e600b8df)) {
      zone.var_e600b8df = 0;
    }

    if(isDefined(zone.var_a5015123)) {
      function_1eaaceab(zone.var_a5015123);

      if(zone.var_e600b8df < 2) {
        index = 0;

        if(zone.var_6284d1b2.size === 0) {
          continue;
        } else if(zone.var_6284d1b2.size > 1) {
          index = randomint(zone.var_6284d1b2.size);
        }

        var_e779ff3c = 0;
        players_in_range = getplayers(undefined, zone.var_6284d1b2[index].origin, 910);
        players = getplayers();

        foreach(player in players) {
          if(player util::is_looking_at(zone.var_6284d1b2[index], 0.8, 1, (0, 0, 32))) {
            var_e779ff3c = 1;
          }
        }

        if(is_true(zone.var_b5490369) || var_e779ff3c === 0 && players_in_range.size === 0 && (!isDefined(zone.var_6284d1b2[index].var_9ae54d14) || zone.var_6284d1b2[index].var_9ae54d14 < gettime() - 30000)) {
          zone.var_6284d1b2[index] function_4d68903d(zone);
          arrayremoveindex(zone.var_6284d1b2, index);
        }
      }
    }

    zone.var_b5490369 = 0;
  }
}

function function_128f3b6b() {
  while(true) {
    level waittill(#"end_of_round");
    function_bf79a643();
  }
}

function private function_dd028fcb(e_player) {
  var_d49d10b0 = e_player zm_loadout::get_player_lethal_grenade();
  self sethintstring(#"hash_302511d2e9a9429b");
  return true;
}

function private function_608b90b4() {
  self endon(#"end_game", #"death");
  self.var_e95e6830 = 5;

  while(true) {
    s_notify = self waittill(#"trigger_activated");
    e_player = s_notify.e_who;
    e_player thread function_79ef6b93(self);

    if(!is_true(e_player.var_61fca2c3)) {
      e_player.var_61fca2c3 = 1;
    }

    if(self.var_e95e6830 <= 0) {
      if(!isDefined(self.zone.var_45d884e6)) {
        self.zone.var_45d884e6 = [];
      } else if(!isarray(self.zone.var_45d884e6)) {
        self.zone.var_45d884e6 = array(self.zone.var_45d884e6);
      }

      if(!isinarray(self.zone.var_45d884e6, self.mound)) {
        self.zone.var_45d884e6[self.zone.var_45d884e6.size] = self.mound;
      }

      self.zone.var_6cff21f5--;
      zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
      playFX("maps/ltm/fx9_winter_snowball_pile_pickup", self.origin);
      self delete();
    }
  }
}

function function_8f677e13() {
  self endon(#"disconnect", #"death");
  waittillframeend();
  item = function_4ba8fde("snowball_item_sr");
  currentweapon = self getcurrentweapon();

  if(isDefined(item)) {
    if(self item_inventory::function_bba770de(item.itementry) === 5) {
      return;
    }

    var_fbf4dc0d = self item_inventory::function_bba770de(item.itementry);
    var_ff2621e6 = 5 - var_fbf4dc0d;
    item.itementry.amount = var_ff2621e6;
    var_fa3df96 = self item_inventory::function_e66dcff5(item);

    if(isDefined(var_fa3df96)) {
      if(!item_world_util::function_db35e94f(item.networkid)) {
        item.networkid = item_world_util::function_970b8d86(var_fa3df96);
      }

      item.hidetime = 0;

      if(self.inventory.items[var_fa3df96].networkid != 32767 && self.inventory.items[var_fa3df96].itementry.name != item.itementry.name) {
        self item_inventory::function_fba40e6c(item);
      } else {
        item_world::function_de2018e3(item, self, var_fa3df96);
      }
    } else {
      item_world::function_de2018e3(item, self, var_fa3df96);
    }

    item.itementry.amount = 1;
  }
}

function function_79ef6b93(snowball_pile) {
  self endon(#"disconnect", #"death");
  self playSound("fly_pickup_snowball");
  item = function_4ba8fde("snowball_item_sr");
  currentweapon = self getcurrentweapon();

  if(isDefined(item)) {
    if(self item_inventory::function_bba770de(item.itementry) === 5) {
      return;
    }

    var_fbf4dc0d = self item_inventory::function_bba770de(item.itementry);
    var_ff2621e6 = 5 - var_fbf4dc0d;

    if(var_ff2621e6 > snowball_pile.var_e95e6830) {
      var_ff2621e6 = snowball_pile.var_e95e6830;
    }

    item.itementry.amount = var_ff2621e6;
    var_fa3df96 = self item_inventory::function_e66dcff5(item);

    if(isDefined(var_fa3df96)) {
      if(!item_world_util::function_db35e94f(item.networkid)) {
        item.networkid = item_world_util::function_970b8d86(var_fa3df96);
      }

      item.hidetime = 0;

      if(self.inventory.items[var_fa3df96].networkid != 32767 && self.inventory.items[var_fa3df96].itementry.name != item.itementry.name) {
        self item_inventory::function_fba40e6c(item);

        for(i = 0; i < var_ff2621e6 - 1; i++) {
          item_world::function_de2018e3(item, self, var_fa3df96);
        }
      } else {
        for(i = 0; i < var_ff2621e6; i++) {
          item_world::function_de2018e3(item, self, var_fa3df96);
        }
      }
    } else {
      for(i = 0; i < var_ff2621e6; i++) {
        item_world::function_de2018e3(item, self, var_fa3df96);
      }
    }

    item.itementry.amount = 1;

    if(snowball_pile.model_state === 1) {
      snowball_pile.model_state = 0;
      playFX("maps/ltm/fx9_winter_snowball_pile_pickup", self.origin);
      snowball_pile setModel("p8_wz_snowball_pile_sml");
    }

    if(var_ff2621e6 > 0) {
      playFX("maps/ltm/fx9_winter_snowball_pile_pickup", snowball_pile.origin);
    }

    snowball_pile.var_e95e6830 -= var_ff2621e6;
  }
}

function function_f5527ca2(zone) {
  playFX("maps/ltm/fx9_winter_snowball_pile_pickup", self.origin);
  snowball_pile = util::spawn_model("p8_wz_snowball_pile", self.origin, self.angles);
  snowball_pile.targetname = "snowball_pile";
  snowball_pile.angles = self.angles;
  snowball_pile setModel("p8_wz_snowball_pile");
  snowball_pile.mound = self;
  snowball_pile.zone = zone;
  snowball_pile.zone.var_6cff21f5++;
  snowball_pile.model_state = 1;
  snowball_pile function_619a5c20();
  snowball_pile zm_unitrigger::create(&function_dd028fcb, 64);
  snowball_pile.s_unitrigger.origin += (0, 0, 32);
  function_1eaaceab(zone.var_4acb65df);

  if(!isDefined(zone.var_4acb65df)) {
    zone.var_4acb65df = [];
  } else if(!isarray(zone.var_4acb65df)) {
    zone.var_4acb65df = array(zone.var_4acb65df);
  }

  if(!isinarray(zone.var_4acb65df, snowball_pile)) {
    zone.var_4acb65df[zone.var_4acb65df.size] = snowball_pile;
  }

  snowball_pile thread function_608b90b4();
}

function function_4d68903d(zone) {
  self endon(#"death");
  playFX("_t7/snow/fx_snow_impact_lg", self.origin + (0, 0, 30));
  snowman = util::spawn_model("p9_nt6x_win_snowman", self.origin, self.angles);
  snowman.takedamage = 1;
  snowman.health = 100;
  snowman.var_493b77d4 = 1;
  snowman.var_defc3cee = 1;
  snowman.mound = self;
  snowman.zone = zone;
  snowman.zone.var_e600b8df++;
  snowman.spawn_time = gettime();
  snowman.var_5d6eb0f1 = 1;
  snowman.rattle_sound = # "hash_52c65a6a82b13cfd";
  snowman disconnectpaths();
  snowman solid();
  snowman setCanDamage(1);
  self.var_38409c6 = "snowman";
  self.snowman = snowman;
  function_1eaaceab(zone.var_a5015123);

  if(!isDefined(zone.var_a5015123)) {
    zone.var_a5015123 = [];
  } else if(!isarray(zone.var_a5015123)) {
    zone.var_a5015123 = array(zone.var_a5015123);
  }

  if(!isinarray(zone.var_a5015123, snowman)) {
    zone.var_a5015123[zone.var_a5015123.size] = snowman;
  }

  snowman thread function_dc8f034(self.snowman);
  var_c416888f = randomint(100);

  if(var_c416888f < 100) {
    snowman thread function_36043197();
  }
}

function function_36043197() {
  self endon(#"death");
  var_47b592ad = randomfloatrange(1250, 7000);
  level flag::wait_till("gameplay_started");

  while(true) {
    players = function_a1ef346b(#"allies", self.origin, 750);

    if(players.size === 0) {
      self.spawn_time = gettime();
    }

    foreach(player in players) {
      if(player util::is_looking_at(self, 0.8, 1, (0, 0, 32))) {
        if(self.spawn_time < gettime() - var_47b592ad) {
          if(!isDefined(self.var_bd710417)) {
            self.var_bd710417 = [];
          }

          if(isDefined(self.var_bd710417[player getentitynumber()])) {
            if(self.var_bd710417[player getentitynumber()] === 0) {
              self.var_bd710417[player getentitynumber()] = gettime();
            } else if(self.var_bd710417[player getentitynumber()] < gettime() - 500) {
              if(!is_true(self.var_624e969b)) {
                self thread zm_utility::function_e77fca72();
              }

              wait 0.5;
              self.zone.var_e600b8df--;
              self.var_9d1762d6 = 1;
              self.mound thread function_87490b97(self.zone);
              self.mound.var_9ae54d14 = gettime();
              self function_856d0105();
              return;
            }
          } else {
            self.var_bd710417[player getentitynumber()] = gettime();
          }
        }

        continue;
      }

      self.var_bd710417[player getentitynumber()] = 0;
    }

    wait 0.25;
  }
}

function function_87490b97(zone) {
  self endon(#"death");
  spawner = level.zombie_spawners[0];
  ai = zombie_utility::spawn_zombie(spawner, spawner.targetname, self);
  self function_a9114898(self.snowman.origin, self.snowman.angles);

  if(!isDefined(zone.var_6284d1b2)) {
    zone.var_6284d1b2 = [];
  } else if(!isarray(zone.var_6284d1b2)) {
    zone.var_6284d1b2 = array(zone.var_6284d1b2);
  }

  if(!isinarray(zone.var_6284d1b2, self)) {
    zone.var_6284d1b2[zone.var_6284d1b2.size] = self;
  }
}

function function_a9114898(origin, angles) {
  self endon(#"death");
  fwd = anglesToForward(angles);
  up = anglestoup(angles);
  playFX("maps/ltm/fx9_winter_snowman_dest", origin, fwd, up);
  playsoundatposition(#"hash_a00a48925a72e55", origin + (0, 0, 30));
}

function function_dc8f034(snowman) {
  self endon(#"death");

  while(true) {
    waitresult = self waittill(#"damage");
    self function_96244838(waitresult.weapon, waitresult.attacker);

    if(self.health <= 0) {
      self.mound function_a9114898(self.origin, self.angles);
      self function_83cb84d3(#"hash_24af9f98f7899474", 1, 0);
      self.zone.var_e600b8df--;

      if(!isDefined(self.zone.var_6284d1b2)) {
        self.zone.var_6284d1b2 = [];
      } else if(!isarray(self.zone.var_6284d1b2)) {
        self.zone.var_6284d1b2 = array(self.zone.var_6284d1b2);
      }

      if(!isinarray(self.zone.var_6284d1b2, self.mound)) {
        self.zone.var_6284d1b2[self.zone.var_6284d1b2.size] = self.mound;
      }

      self.mound.var_9ae54d14 = gettime();
      self function_856d0105();
      return;
    }
  }
}

function function_856d0105() {
  if(isDefined(self)) {
    self deletedelay();
  }
}

function function_3a268da9(params) {
  self endon(#"endgame");

  while(true) {
    waitresult = level waittill(#"consumed_item");

    if(waitresult.itemname === "item_zm_ltm_holiday_gift_01" || waitresult.itemname === "item_zm_ltm_holiday_gift_02" || waitresult.itemname === "item_zm_ltm_holiday_gift_03") {
      switch (waitresult.itemname) {
        case # "item_zm_ltm_holiday_gift_01":
          waitresult.item function_83cb84d3(#"hash_3adefdb432d5b064", 0, 1, waitresult.item.var_7b02ac6a);
          break;
        case # "item_zm_ltm_holiday_gift_02":
          waitresult.item function_83cb84d3(#"hash_3adefdb432d5b064", 0, 1, waitresult.item.var_7b02ac6a);
          break;
        case # "item_zm_ltm_holiday_gift_03":
          waitresult.item function_83cb84d3(#"hash_3adefdb432d5b064", 0, 1, waitresult.item.var_7b02ac6a);
          break;
      }
    }

    waitframe(1);
  }
}

function function_83cb84d3(var_20287981, var_3798631c, var_b9012667, var_63942b62, var_6ff6be61) {
  var_7580ce3e = spawnStruct();
  var_7580ce3e.origin = self.origin;
  var_7580ce3e.angles = self.angles;
  var_7580ce3e.var_738dfc81 = 1;
  var_7580ce3e.scriptmodel = self;

  if(var_3798631c === 1 && is_true(level.var_72182681) && !is_true(var_6ff6be61)) {
    level.var_72182681 = 0;
    var_9b2da190 = "ltm_chest_item_list";
  } else if(var_3798631c === 1 && is_true(level.var_162c45e4) && is_true(var_6ff6be61)) {
    level.var_162c45e4 = 0;
    var_9b2da190 = "ltm_chest_item_list";
  } else if(var_3798631c === 1) {
    var_9b2da190 = namespace_58949729::function_fd5e77fa(var_20287981);
  } else if(var_b9012667 === 1) {
    var_59364773 = 0;

    if(var_63942b62 === 1) {
      var_59364773 = 1;
    }

    var_9b2da190 = namespace_58949729::function_257d7203(var_20287981, var_59364773);
  } else {
    var_9b2da190 = namespace_58949729::function_257d7203(var_20287981);
  }

  if(var_b9012667 === 1) {
    level thread namespace_58949729::function_f82f361c(var_7580ce3e, var_9b2da190, 0, 1);
  } else {
    level thread namespace_58949729::function_f82f361c(var_7580ce3e, var_9b2da190, 2, 1);
  }

  var_7580ce3e struct::delete();
}

function function_96244838(weapon, attacker) {
  self endon(#"death");

  if(isDefined(weapon) && isDefined(attacker) && isPlayer(attacker)) {
    var_594a2d34 = isDefined(weapon) && isDefined(weapon.var_965cc0b3) && weapon.var_965cc0b3;
    attacker util::show_hit_marker(0, var_594a2d34);
  }
}

function on_ai_damaged(params) {
  if(params.weapon.name === # "snowball" && !(self.zm_ai_category === # "elite")) {
    if(!isDefined(self.var_2b2c16c7)) {
      self.var_2b2c16c7 = {};
    }

    self.var_2b2c16c7 = {
      #time: gettime(), #player: params.eattacker
    };

    if(params.idamage >= self.health) {
      self.var_b69c12bc = 0;
    }

    if(params.eattacker zm_powerups::is_insta_kill_active()) {
      self.var_958cf9c5 = 1;
      return;
    }

    self thread ammomod_cryofreeze::function_f00409f3(params.eattacker, undefined, params.weapon, 0, 3);
  }
}

function on_ai_killed(params) {
  if(self.var_958cf9c5 === 1 && isDefined(self.var_2b2c16c7) && self.var_2b2c16c7.time > gettime() - 4000) {
    self.var_aa2ce9a4 = 1;

    if(zm_utility::is_player_valid(self.var_2b2c16c7.player, 0, 0)) {
      if(self.var_2b2c16c7.player === params.eattacker) {
        scoreevents::processscoreevent(#"hash_62d538ab42fe8565", params.eattacker, self, params.weapon);
      } else {
        scoreevents::processscoreevent(#"hash_1fb5d644e5408000", params.eattacker, self, params.weapon);
      }
    }

    self function_83cb84d3(#"hash_24af9f98f7899474", 1, 0, undefined, 1);
  }
}
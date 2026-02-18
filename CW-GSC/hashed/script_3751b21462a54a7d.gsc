/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3751b21462a54a7d.gsc
***********************************************/

#using script_18077945bb84ede7;
#using script_19367cd29a4485db;
#using script_2c5daa95f8fec03c;
#using script_5f261a5d57de5f7c;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\healthoverlay;
#using scripts\core_common\item_inventory;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#namespace namespace_791d0451;

function private autoexec __init__system__() {
  system::register(#"hash_2d064899850813e2", &preinit, &postinit, undefined, undefined);
}

function preinit() {
  level.var_fcb9f1fb = [];
  callback::on_spawned(&on_player_spawn);
  callback::on_item_pickup(&on_item_pickup);

  level.var_c0f77370 = &function_c0f77370;

  level.var_c723ac75 = [];
  function_e854b81f(#"hash_47d7a8105237c88", #"hash_afdc97f440fbcec", #"hash_afdcc7f440fc205", #"hash_afdcb7f440fc052", #"hash_afdc67f440fb7d3", #"hash_afdc57f440fb620");
  function_e854b81f(#"talent_quickrevive", #"hash_504b41f717f8931a", #"hash_504b40f717f89167", #"hash_504b3ff717f88fb4", #"hash_504b3ef717f88e01", #"hash_504b3df717f88c4e");
  function_e854b81f(#"talent_speedcola", #"hash_520b5db0216b778a", #"hash_520b5cb0216b75d7", #"hash_520b5bb0216b7424", #"hash_520b5ab0216b7271", #"hash_520b59b0216b70be");
  function_e854b81f(#"talent_doubletap", #"talent_doubletap", #"talent_doubletap", #"talent_doubletap", #"talent_doubletap", #"talent_doubletap");
  function_e854b81f(#"talent_deadshot", #"hash_1f95b48e4a49df4a", #"hash_1f95b38e4a49dd97", #"hash_1f95b28e4a49dbe4", #"hash_1f95b18e4a49da31", #"hash_1f95b08e4a49d87e");
  function_e854b81f(#"talent_staminup", #"hash_17ccbaee64daa05b", #"hash_17ccbbee64daa20e", #"hash_17ccbcee64daa3c1", #"hash_17ccbdee64daa574", #"hash_17ccbeee64daa727");
  function_e854b81f(#"talent_elemental_pop", #"talent_elemental_pop_1", #"talent_elemental_pop_2", #"talent_elemental_pop_3", #"talent_elemental_pop_4", #"talent_elemental_pop_5");
  function_e854b81f(#"hash_38c08136902fd553", #"hash_59dbecf72baaa96f", #"hash_59dbedf72baaab22", #"hash_59dbeef72baaacd5", #"hash_59dbe7f72baaa0f0", #"hash_59dbe8f72baaa2a3");
  function_e854b81f(#"talent_mulekick", #"talent_mulekick_1", #"talent_mulekick_2", #"talent_mulekick_3", #"talent_mulekick_4", #"talent_mulekick_5");
  function_e854b81f(#"talent_deathperception", #"talent_deathperception_1", #"talent_deathperception_2", #"talent_deathperception_3", #"talent_deathperception_4", #"talent_deathperception_5");
  function_e854b81f(#"talent_phdslider", #"talent_phdslider_1", #"talent_phdslider_2", #"talent_phdslider_3", #"talent_phdslider_4", #"talent_phdslider_5");
  clientfield::register_clientuimodel("zm_perks_per_controller.count", 1, 4, "int", 0);

  for(i = 1; i <= 10; i++) {
    clientfield::register_clientuimodel("zm_perks_per_controller." + i + ".itemIndex", 1, 8, "int", 0);
    clientfield::register_clientuimodel("zm_perks_per_controller." + i + ".lost", 1, 2, "int", 0);
  }

  callback::add_callback(#"on_host_migration_end", &on_host_migration_end);
}

function postinit() {}

function function_e854b81f(var_24303d72, ...) {
  var_50846129 = [];

  if(!isDefined(var_50846129)) {
    var_50846129 = [];
  } else if(!isarray(var_50846129)) {
    var_50846129 = array(var_50846129);
  }

  var_50846129[var_50846129.size] = var_24303d72;

  for(i = 0; i < vararg.size; i++) {
    if(!isDefined(var_50846129)) {
      var_50846129 = [];
    } else if(!isarray(var_50846129)) {
      var_50846129 = array(var_50846129);
    }

    var_50846129[var_50846129.size] = vararg[i];
  }

  level.var_c723ac75[var_24303d72] = var_50846129;
}

function function_1b16bd84(var_24303d72, tier) {
  var_8c590502 = isDefined(getgametypesetting(#"hash_3c2c78e639bfd3c6")) ? getgametypesetting(#"hash_3c2c78e639bfd3c6") : 0;

  if(var_8c590502 > 0) {
    tier = var_8c590502;
  }

  var_50846129 = level.var_c723ac75[var_24303d72];

  if(!isDefined(var_50846129)) {
    return var_24303d72;
  }

  talent = var_50846129[tier];

  if(!isDefined(talent)) {
    return var_24303d72;
  }

  return talent;
}

function function_1050b262(talent, func) {
  if(isDefined(talent) && isDefined(func)) {
    level.var_fcb9f1fb[talent] = func;
  }
}

function function_56cedda7(perk) {
  if(!isPlayer(self) || !isDefined(self.var_7341f980)) {
    return false;
  }

  foreach(var_7387d8e1 in self.var_7341f980) {
    if(perk == var_7387d8e1) {
      return true;
    }
  }

  return false;
}

function function_12b698fa(statname) {
  var_8c590502 = isDefined(getgametypesetting(#"hash_3c2c78e639bfd3c6")) ? getgametypesetting(#"hash_3c2c78e639bfd3c6") : 0;

  if(var_8c590502 > 0) {
    return var_8c590502;
  }

  return self stats::function_6d50f14b(#"cacloadouts", #"upgrade_tiers", statname);
}

function function_b852953c(var_aac3d74d) {
  item_index = getitemindexfromref(var_aac3d74d);
  var_438da649 = function_b143666d(item_index, 5);
  var_40e28ba = var_438da649.var_cd070e56;

  if(!isDefined(var_40e28ba) || var_40e28ba == # "") {
    return var_aac3d74d;
  }

  tier = self function_12b698fa(var_40e28ba);
  return function_1b16bd84(var_aac3d74d, tier);
}

function function_a0a66726() {
  if(!isPlayer(self)) {
    return;
  }

  if(!isDefined(self.var_7341f980)) {
    return;
  }

  var_fc14f601 = [];

  foreach(var_91b99f7 in self.var_7341f980) {
    itemindex = 0;

    if(isDefined(var_91b99f7) && ishash(var_91b99f7) && var_91b99f7 != # "") {
      itemindex = getitemindexfromref(var_91b99f7);
    }

    if(itemindex > 0) {
      if(!isDefined(var_fc14f601)) {
        var_fc14f601 = [];
      } else if(!isarray(var_fc14f601)) {
        var_fc14f601 = array(var_fc14f601);
      }

      if(!isinarray(var_fc14f601, var_91b99f7)) {
        var_fc14f601[var_fc14f601.size] = var_91b99f7;
      }
    }
  }

  self.var_7341f980 = var_fc14f601;
}

function function_a173ab53() {
  if(!isPlayer(self)) {
    return 0;
  }

  self function_a0a66726();
  count = 0;

  if(isDefined(self.var_7341f980)) {
    count = self.var_7341f980.size;

    for(i = 1; i <= 10; i++) {
      itemindex = 0;
      var_91b99f7 = self.var_7341f980[i - 1];

      if(isDefined(var_91b99f7)) {
        itemindex = getitemindexfromref(var_91b99f7);
      }

      clientfield::set_player_uimodel("zm_perks_per_controller." + i + ".itemIndex", itemindex);
      var_58257a54 = 0;

      if(isDefined(self.var_1f3077f0)) {
        foreach(var_9aaeaf22 in self.var_1f3077f0) {
          if(var_9aaeaf22 === var_91b99f7) {
            var_58257a54 = 1;
            break;
          }
        }
      }

      if(self namespace_e86ffa8::function_33d837e4(5)) {
        clientfield::set_player_uimodel("zm_perks_per_controller." + i + ".lost", 2);
        continue;
      }

      clientfield::set_player_uimodel("zm_perks_per_controller." + i + ".lost", var_58257a54);
    }
  }

  clientfield::set_player_uimodel("zm_perks_per_controller.count", count);
}

function function_4c5d2b62() {
  cost = 2500;

  if(isDefined(self.var_7341f980)) {
    cost += self.var_7341f980.size * 500;
  }

  return cost;
}

function function_3fecad82(talent, var_6e2cc6cb = 1, var_96b5aff5 = # "") {
  if(!isPlayer(self) || !isDefined(self.var_7341f980)) {
    return;
  }

  round_number = zm_utility::get_round_number();

  if(self.var_7341f980.size == 0 && zm_utility::is_classic()) {
    self.var_5c68806 = [];
    self.var_c545ae9c = round_number;
    self.var_5c68806[round_number] = talent;
    self.var_5c68806[round_number + 1] = # "none";
    self.var_5c68806[round_number + 2] = # "none";
    self.var_5c68806[round_number + 3] = # "none";
    self.var_5c68806[round_number + 4] = # "none";
    self.var_5c68806[round_number + 5] = # "none";
    self.var_5c68806[round_number + 6] = # "none";
    self.var_5c68806[round_number + 7] = # "none";
    self.var_5c68806[round_number + 8] = # "none";
    self.var_5c68806[round_number + 9] = # "none";
  } else if(isDefined(self.var_5c68806) && isDefined(self.var_c545ae9c) && zm_utility::is_classic()) {
    if(!isinarray(self.var_5c68806, talent)) {
      self.var_5c68806[round_number] = talent;
    }

    var_55c38743 = 1;

    for(i = 0; i < 10; i++) {
      if(self.var_5c68806[self.var_c545ae9c + i] == # "none") {
        var_55c38743 = 0;
      }
    }

    if(var_55c38743) {
      self zm_stats::increment_challenge_stat(#"hash_9f4ad7eba874404");
    }
  }

  if(!isDefined(self.var_7341f980)) {
    self.var_7341f980 = [];
  } else if(!isarray(self.var_7341f980)) {
    self.var_7341f980 = array(self.var_7341f980);
  }

  if(!isinarray(self.var_7341f980, talent)) {
    self.var_7341f980[self.var_7341f980.size] = talent;
  }

  self function_a173ab53();
  self item_inventory::function_9f438f15();

  if(isDefined(level.var_fcb9f1fb) && isDefined(level.var_fcb9f1fb[talent])) {
    self[[level.var_fcb9f1fb[talent]]]();
  }

  self notify(#"perk_acquired", {
    #var_16c042b8: talent
  });

  switch (talent) {
    case # "hash_504b40f717f89167":
    case # "hash_504b3ff717f88fb4":
    case # "hash_504b41f717f8931a":
    case # "hash_504b3ef717f88e01":
    case # "hash_504b3df717f88c4e":
    case # "talent_quickrevive":
      var_6d3b160e = self.var_7341f980[self.var_7341f980.size - 1];

      if(var_6d3b160e != # "talent_quickrevive" || var_6d3b160e != # "hash_504b41f717f8931a" || var_6d3b160e != # "hash_504b40f717f89167" || var_6d3b160e != # "hash_504b3ff717f88fb4" || var_6d3b160e != # "hash_504b3ef717f88e01" || var_6d3b160e != # "hash_504b3df717f88c4e") {
        self.var_7341f980[self.var_7341f980.size - 1] = self.var_7341f980[0];
        self.var_7341f980[0] = var_6d3b160e;
      }

      if(var_6e2cc6cb) {
        self perk_give_bottle_begin(#"talent_quickrevive");
      }

      break;
    case # "talent_speedcola":
    case # "hash_520b5db0216b778a":
    case # "hash_520b5cb0216b75d7":
    case # "hash_520b5bb0216b7424":
    case # "hash_520b5ab0216b7271":
    case # "hash_520b59b0216b70be":
      if(var_6e2cc6cb) {
        self perk_give_bottle_begin(#"talent_speedcola");
      }

      break;
    case # "hash_1f95b28e4a49dbe4":
    case # "hash_1f95b08e4a49d87e":
    case # "hash_1f95b18e4a49da31":
    case # "hash_1f95b38e4a49dd97":
    case # "hash_1f95b48e4a49df4a":
    case # "talent_deadshot":
      if(var_6e2cc6cb) {
        self perk_give_bottle_begin(#"talent_deadshot");
      }

      break;
    case # "talent_doubletap":
    case # "talent_doubletap":
    case # "talent_doubletap":
    case # "talent_doubletap":
    case # "talent_doubletap":
    case # "talent_doubletap":
      if(var_6e2cc6cb) {
        self perk_give_bottle_begin(#"talent_doubletap");
      }

      break;
    case # "hash_47d7a8105237c88":
    case # "hash_afdc57f440fb620":
    case # "hash_afdc67f440fb7d3":
    case # "hash_afdc97f440fbcec":
    case # "hash_afdcb7f440fc052":
    case # "hash_afdcc7f440fc205":
      if(var_6e2cc6cb) {
        self perk_give_bottle_begin(#"hash_47d7a8105237c88");
      }

      healthoverlay::function_d2880c8f();
      break;
    case # "hash_17ccbcee64daa3c1":
    case # "hash_17ccbdee64daa574":
    case # "hash_17ccbeee64daa727":
    case # "hash_17ccbbee64daa20e":
    case # "hash_17ccbaee64daa05b":
    case # "talent_staminup":
      if(var_6e2cc6cb) {
        self perk_give_bottle_begin(#"talent_staminup");
      }

      break;
    case # "talent_elemental_pop":
    case # "talent_elemental_pop_2":
    case # "talent_elemental_pop_3":
    case # "talent_elemental_pop_1":
    case # "talent_elemental_pop_4":
    case # "talent_elemental_pop_5":
      if(var_6e2cc6cb) {
        self perk_give_bottle_begin(#"talent_elemental_pop");
      }

      break;
    case # "hash_38c08136902fd553":
    case # "hash_59dbe8f72baaa2a3":
    case # "hash_59dbecf72baaa96f":
    case # "hash_59dbedf72baaab22":
    case # "hash_59dbeef72baaacd5":
    case # "hash_59dbe7f72baaa0f0":
      if(var_6e2cc6cb) {
        self perk_give_bottle_begin(#"hash_38c08136902fd553");
      }

      break;
    case # "talent_mulekick_5":
    case # "talent_mulekick_4":
    case # "talent_mulekick_3":
    case # "talent_mulekick_2":
    case # "talent_mulekick_1":
    case # "talent_mulekick":
      if(var_6e2cc6cb) {
        self perk_give_bottle_begin(#"talent_mulekick");
      }

      break;
    case # "talent_deathperception":
    case # "talent_deathperception_2":
    case # "talent_deathperception_3":
    case # "talent_deathperception_4":
    case # "talent_deathperception_5":
    case # "talent_deathperception_1":
      if(var_6e2cc6cb) {
        self perk_give_bottle_begin(#"talent_deathperception");
      }

      break;
    case # "talent_phdslider_3":
    case # "talent_phdslider_2":
    case # "talent_phdslider_5":
    case # "talent_phdslider_4":
    case # "talent_phdslider":
    case # "talent_phdslider_1":
      if(var_6e2cc6cb) {
        self perk_give_bottle_begin(#"talent_phdslider");
      }

      break;
  }

  self.var_77c69799 += 1;
  self function_b4083162(talent, var_96b5aff5);
  var_3dab8681 = namespace_e86ffa8::function_cde018a9(talent);

  if(isDefined(level._custom_perks[var_3dab8681]) && isDefined(level._custom_perks[var_3dab8681].player_thread_give)) {
    self thread[[level._custom_perks[var_3dab8681].player_thread_give]]();
  }

  if(isDefined(level._custom_perks[var_3dab8681]) && isDefined(level._custom_perks[var_3dab8681].clientfield_set)) {
    self[[level._custom_perks[var_3dab8681].clientfield_set]](1);
  }
}

function private function_b4083162(talent, var_96b5aff5) {
  if(isPlayer(self)) {
    switch (var_96b5aff5) {
      case 1:
        source = # "world";
        break;
      case 2:
        source = # "wonderfizz";
        break;
      default:
        source = # "hash_a6101af5e5d2384";
        break;
    }

    var_4f88d102 = {
      #var_aa8a99e8: function_f8d53445(), #var_13f78fc7: zm_utility::function_e3025ca5(), #var_75c4407f: zm_utility::get_round_number(), #perk: talent, #var_96b5aff5: source, #var_2abfe4d3: self.var_77c69799, #perks_active: self.var_7341f980.size, #var_fa7f8efb: self namespace_2a9f256a::function_6f3fd157()
    };
    self function_678f57c8(#"hash_1c64557e9577551e", var_4f88d102);
  }
}

function private function_2cceca7b() {
  return self isgrappling() || self isusingoffhand() || self function_55acff10(1);
}

function perk_give_bottle_begin(str_perk) {
  if(!function_2cceca7b()) {
    weapon = get_perk_weapon(str_perk);
    self giveweapon(weapon);
    self switchtooffhand(weapon);
    self thread gestures::function_f3e2696f(self, weapon, undefined, 2.5, undefined, undefined, undefined);
  }
}

function get_perk_weapon(str_perk) {
  switch (str_perk) {
    case # "talent_quickrevive":
      weapon = getweapon(#"zombie_perk_bottle_revive");
      return weapon;
    case # "talent_speedcola":
      weapon = getweapon(#"zombie_perk_bottle_sleight");
      return weapon;
    case # "talent_deadshot":
      weapon = getweapon(#"zombie_perk_bottle_deadshot");
      return weapon;
    case # "talent_doubletap":
      weapon = getweapon(#"zombie_perk_bottle_doubletap");
      return weapon;
    case # "hash_47d7a8105237c88":
      weapon = getweapon(#"zombie_perk_bottle_jugg");
      return weapon;
    case # "talent_staminup":
      weapon = getweapon(#"zombie_perk_bottle_marathon");
      return weapon;
    case # "talent_elemental_pop":
      weapon = getweapon(#"zombie_perk_bottle_elemental_pop");
      return weapon;
    case # "hash_38c08136902fd553":
      weapon = getweapon(#"zombie_perk_bottle_tombstone");
      return weapon;
    case # "talent_mulekick":
      weapon = getweapon(#"zombie_perk_bottle_mulekick");
      return weapon;
    case # "talent_deathperception":
      weapon = getweapon(#"zombie_perk_bottle_death_perception");
      return weapon;
    case # "talent_phdslider":
      weapon = getweapon(#"zombie_perk_bottle_slider");
      return weapon;
  }
}

function function_4c1d0e25(perk, var_b2d43592 = 0, var_cd9efd85 = 0) {
  if(!isPlayer(self) || !isDefined(self.var_7341f980)) {
    return;
  }

  if(var_b2d43592) {
    self.var_1f3077f0 = isDefined(self.var_1f3077f0) ? self.var_1f3077f0 : [];

    if(!isDefined(self.var_1f3077f0)) {
      self.var_1f3077f0 = [];
    } else if(!isarray(self.var_1f3077f0)) {
      self.var_1f3077f0 = array(self.var_1f3077f0);
    }

    self.var_1f3077f0[self.var_1f3077f0.size] = perk;

    if(var_cd9efd85) {
      self.var_ff5d288f = isDefined(self.var_ff5d288f) ? self.var_ff5d288f : [];

      if(!isDefined(self.var_ff5d288f)) {
        self.var_ff5d288f = [];
      } else if(!isarray(self.var_ff5d288f)) {
        self.var_ff5d288f = array(self.var_ff5d288f);
      }

      self.var_ff5d288f[self.var_ff5d288f.size] = perk;
    }

    self function_a173ab53();
    return;
  }

  arrayremovevalue(self.var_7341f980, perk);
  self function_a173ab53();
  self item_inventory::function_9f438f15();
  var_3dab8681 = namespace_e86ffa8::function_cde018a9(perk);

  if(isDefined(level._custom_perks[var_3dab8681]) && isDefined(level._custom_perks[var_3dab8681].clientfield_set)) {
    self[[level._custom_perks[var_3dab8681].clientfield_set]](0);
  }

  if(isDefined(level._custom_perks[var_3dab8681]) && isDefined(level._custom_perks[var_3dab8681].player_thread_take)) {
    self thread[[level._custom_perks[var_3dab8681].player_thread_take]](0, undefined, undefined, -1);
  }
}

function function_4af7e89f() {
  if(!isPlayer(self) || !isDefined(self.var_1f3077f0)) {
    return;
  }

  foreach(perk in self.var_1f3077f0) {
    self function_4c1d0e25(perk);
  }

  self.var_1f3077f0 = undefined;
  self.var_ff5d288f = undefined;
}

function on_player_spawn() {
  if(!isDefined(self.var_7341f980)) {
    self.var_7341f980 = [];
  }

  if(!isDefined(self.var_77c69799)) {
    self.var_77c69799 = 0;
  }
}

function on_item_pickup(params) {
  item = params.item;

  if(isPlayer(self)) {
    if(isDefined(item.itementry)) {
      if(item.itementry.itemtype === # "survival_perk") {
        if(isDefined(item.itementry.talents)) {
          foreach(talent in item.itementry.talents) {
            if(isDefined(talent.talent)) {
              talent = self function_b852953c(talent.talent);
              function_3fecad82(talent, 1, 1);
            }
          }
        }

        return;
      }

      if(item.itementry.itemtype === # "armor") {}
    }
  }
}

function on_host_migration_end(params) {
  if(isPlayer(self)) {
    self item_inventory::function_9f438f15();
  }
}

function function_c5fb4741(var_79291fdb = 0) {
  self endon(#"death");
  self endon(#"hash_7d1062382b3d7c69");
  var_3354472e = array("mus_perks_jugganog_jingle", "mus_perks_speed_jingle", "mus_perks_revive_jingle", "mus_perks_stamin_jingle", "mus_perks_deadshot_jingle", "mus_perks_elementalpop_jingle", "mus_perks_tombstone_jingle", "mus_perks_mulekick_jingle", "mus_perks_deathperception_jingle", "mus_perks_phd_jingle");
  var_8f2bdcca = self function_381f04ca();

  while(true) {
    wait randomintrange(120, 300);

    if(self ishidden()) {
      continue;
    }

    if(var_79291fdb) {
      var_8f2bdcca = var_3354472e[randomintrange(0, var_3354472e.size)];
    }

    if(!is_true(self.var_c000552f) && isDefined(var_8f2bdcca)) {
      self.var_c000552f = 1;
      var_dfeb1fd = float(max(isDefined(soundgetplaybacktime(var_8f2bdcca)) ? soundgetplaybacktime(var_8f2bdcca) : 500, 500)) / 1000;
      playsoundatposition(var_8f2bdcca, self.origin + (0, 0, 50));
      wait var_dfeb1fd;
      self.var_c000552f = 0;
    }
  }
}

function function_381f04ca() {
  str_alias = undefined;

  if(isDefined(self.targetname)) {
    switch (self.targetname) {
      case # "vending_revive":
        str_alias = "mus_perks_revive_jingle";
        break;
      case # "vending_sleight":
        str_alias = "mus_perks_speed_jingle";
        break;
      case # "vending_marathon":
        str_alias = "mus_perks_stamin_jingle";
        break;
      case # "vending_deadshot":
        str_alias = "mus_perks_deadshot_jingle";
        break;
      case # "vending_elemental_pop":
        str_alias = "mus_perks_elementalpop_jingle";
        break;
      case # "vending_jugg":
        str_alias = "mus_perks_jugganog_jingle";
        break;
      case # "vending_tombstone":
        str_alias = "mus_perks_tombstone_jingle";
        break;
      case # "vending_mulekick":
        str_alias = "mus_perks_mulekick_jingle";
        break;
      case # "vending_deathperception":
        str_alias = "mus_perks_deathperception_jingle";
        break;
      case # "vending_divetonuke":
        str_alias = "mus_perks_phd_jingle";
        break;
    }
  }

  return str_alias;
}

function function_3e9d8a8e(var_11868f5d) {
  self endon(#"death");

  if(is_true(self.var_c000552f)) {
    return;
  }

  str_alias = undefined;

  switch (var_11868f5d) {
    case # "hash_47d7a8105237c88":
    case # "hash_afdc57f440fb620":
    case # "hash_afdc67f440fb7d3":
    case # "hash_afdc97f440fbcec":
    case # "hash_afdcb7f440fc052":
    case # "hash_afdcc7f440fc205":
      str_alias = # "mus_perks_jugganog_sting";
      break;
    case # "hash_504b41f717f8931a":
    case # "talent_quickrevive":
    case # "hash_504b40f717f89167":
    case # "hash_504b3ff717f88fb4":
    case # "hash_504b3ef717f88e01":
    case # "hash_504b3df717f88c4e":
      str_alias = # "mus_perks_revive_sting";
      break;
    case # "talent_speedcola":
    case # "hash_520b59b0216b70be":
    case # "hash_520b5ab0216b7271":
    case # "hash_520b5bb0216b7424":
    case # "hash_520b5cb0216b75d7":
    case # "hash_520b5db0216b778a":
      str_alias = # "mus_perks_speed_sting";
      break;
    case # "hash_1f95b48e4a49df4a":
    case # "talent_deadshot":
    case # "hash_1f95b28e4a49dbe4":
    case # "hash_1f95b08e4a49d87e":
    case # "hash_1f95b18e4a49da31":
    case # "hash_1f95b38e4a49dd97":
      str_alias = # "mus_perks_deadshot_sting";
      break;
    case # "hash_17ccbbee64daa20e":
    case # "hash_17ccbaee64daa05b":
    case # "talent_staminup":
    case # "hash_17ccbeee64daa727":
    case # "hash_17ccbdee64daa574":
    case # "hash_17ccbcee64daa3c1":
      str_alias = # "mus_perks_stamin_sting";
      break;
    case # "talent_elemental_pop":
    case # "talent_elemental_pop_2":
    case # "talent_elemental_pop_3":
    case # "talent_elemental_pop_1":
    case # "talent_elemental_pop_4":
    case # "talent_elemental_pop_5":
      str_alias = # "mus_perks_elementalpop_sting";
      break;
    case # "talent_doubletap":
    case # "talent_doubletap":
    case # "talent_doubletap":
    case # "talent_doubletap":
    case # "talent_doubletap":
    case # "talent_doubletap":
      str_alias = # "hash_25791821a46525d9";
      break;
    case # "hash_59dbe8f72baaa2a3":
    case # "hash_59dbecf72baaa96f":
    case # "hash_59dbedf72baaab22":
    case # "hash_59dbeef72baaacd5":
    case # "hash_59dbe7f72baaa0f0":
    case # "hash_38c08136902fd553":
      str_alias = # "mus_perks_tombstone_sting";
      break;
    case # "talent_mulekick_5":
    case # "talent_mulekick_4":
    case # "talent_mulekick_3":
    case # "talent_mulekick_2":
    case # "talent_mulekick_1":
    case # "talent_mulekick":
      if(self.targetname === "wonderfizz") {
        str_alias = # "mus_perks_mulekick_sting";
      } else {
        str_alias = # "hash_239089c47153028b";
      }

      break;
    case # "talent_deathperception":
    case # "talent_deathperception_2":
    case # "talent_deathperception_3":
    case # "talent_deathperception_4":
    case # "talent_deathperception_5":
    case # "talent_deathperception_1":
      str_alias = # "mus_perks_deathperception_sting";
      break;
    case # "talent_phdslider_5":
    case # "talent_phdslider":
    case # "talent_phdslider_1":
    case # "talent_phdslider_3":
    case # "talent_phdslider_2":
    case # "talent_phdslider_4":
      str_alias = # "mus_perks_phd_sting";
      break;
  }

  if(isDefined(str_alias)) {
    self.var_c000552f = 1;
    playsoundatposition(str_alias, self.origin + (0, 0, 50));
    wait 5;
    self.var_c000552f = 0;
  }
}

function function_cc0055e9(talent) {
  if(!isDefined(talent)) {
    return false;
  }

  switch (talent) {
    case # "hash_47d7a8105237c88":
    case # "hash_afdc57f440fb620":
    case # "hash_afdc67f440fb7d3":
    case # "hash_afdc97f440fbcec":
    case # "hash_afdcb7f440fc052":
    case # "hash_afdcc7f440fc205":
      if(!is_true(getgametypesetting(#"hash_350adc73849f66ad"))) {
        return false;
      }

      break;
    case # "hash_504b41f717f8931a":
    case # "talent_quickrevive":
    case # "hash_504b40f717f89167":
    case # "hash_504b3ff717f88fb4":
    case # "hash_504b3ef717f88e01":
    case # "hash_504b3df717f88c4e":
      if(!is_true(getgametypesetting(#"hash_790760c24def02df"))) {
        return false;
      }

      break;
    case # "talent_speedcola":
    case # "hash_520b59b0216b70be":
    case # "hash_520b5ab0216b7271":
    case # "hash_520b5bb0216b7424":
    case # "hash_520b5cb0216b75d7":
    case # "hash_520b5db0216b778a":
      if(!is_true(getgametypesetting(#"hash_3ad94f36f9fe01c3"))) {
        return false;
      }

      break;
    case # "hash_1f95b48e4a49df4a":
    case # "talent_deadshot":
    case # "hash_1f95b28e4a49dbe4":
    case # "hash_1f95b08e4a49d87e":
    case # "hash_1f95b18e4a49da31":
    case # "hash_1f95b38e4a49dd97":
      if(!is_true(getgametypesetting(#"hash_6c0eea959e1beea9"))) {
        return false;
      }

      break;
    case # "hash_17ccbbee64daa20e":
    case # "hash_17ccbaee64daa05b":
    case # "talent_staminup":
    case # "hash_17ccbeee64daa727":
    case # "hash_17ccbdee64daa574":
    case # "hash_17ccbcee64daa3c1":
      if(!is_true(getgametypesetting(#"hash_1eae2946efd5fc50"))) {
        return false;
      }

      break;
    case # "talent_elemental_pop":
    case # "talent_elemental_pop_2":
    case # "talent_elemental_pop_3":
    case # "talent_elemental_pop_1":
    case # "talent_elemental_pop_4":
    case # "talent_elemental_pop_5":
      if(!is_true(getgametypesetting(#"hash_4a821fd3ce297dbb"))) {
        return false;
      }

      break;
    case # "talent_doubletap":
    case # "talent_doubletap":
    case # "talent_doubletap":
    case # "talent_doubletap":
    case # "talent_doubletap":
    case # "talent_doubletap":
      return false;
    case # "hash_59dbe8f72baaa2a3":
    case # "hash_59dbecf72baaa96f":
    case # "hash_59dbedf72baaab22":
    case # "hash_59dbeef72baaacd5":
    case # "hash_59dbe7f72baaa0f0":
    case # "hash_38c08136902fd553":
      if(!is_true(getgametypesetting(#"hash_21f347fcb9fbef2a"))) {
        return false;
      }

      break;
    case # "talent_mulekick_5":
    case # "talent_mulekick_4":
    case # "talent_mulekick_3":
    case # "talent_mulekick_2":
    case # "talent_mulekick_1":
    case # "talent_mulekick":
      if(!is_true(getgametypesetting(#"hash_616a22c5c1ebe5b8"))) {
        return false;
      }

      break;
    case # "talent_deathperception":
    case # "talent_deathperception_2":
    case # "talent_deathperception_3":
    case # "talent_deathperception_4":
    case # "talent_deathperception_5":
    case # "talent_deathperception_1":
      if(!is_true(getgametypesetting(#"hash_45fa8995b51490e8"))) {
        return false;
      }

      break;
    case # "talent_phdslider_5":
    case # "talent_phdslider":
    case # "talent_phdslider_1":
    case # "talent_phdslider_3":
    case # "talent_phdslider_2":
    case # "talent_phdslider_4":
      if(!is_true(getgametypesetting(#"hash_4b8929fb898a9e80"))) {
        return false;
      }

      break;
  }

  return true;
}

function function_c0f77370() {
  level endon(#"game_ended");
  level.var_6f4eb990 = "<dev string:x38>";
  namespace_420b39d3::function_d8ef0f00(&function_1d36527d);
  adddebugcommand("<dev string:x3c>" + "<dev string:x89>" + "<dev string:x8e>");
  adddebugcommand("<dev string:x93>" + "<dev string:xde>" + "<dev string:x8e>");
  adddebugcommand("<dev string:xe3>" + "<dev string:x12e>" + "<dev string:x8e>");
  adddebugcommand("<dev string:x133>" + "<dev string:x17e>" + "<dev string:x8e>");
  adddebugcommand("<dev string:x183>" + "<dev string:x1ce>" + "<dev string:x8e>");
  adddebugcommand("<dev string:x1d3>" + "<dev string:x21e>" + "<dev string:x8e>");
  adddebugcommand("<dev string:x223>" + function_9e72a96(#"talent_quickrevive") + "<dev string:x8e>");
  adddebugcommand("<dev string:x26d>" + function_9e72a96(#"talent_speedcola") + "<dev string:x8e>");
  adddebugcommand("<dev string:x2b3>" + function_9e72a96(#"talent_deadshot") + "<dev string:x8e>");
  adddebugcommand("<dev string:x2f7>" + function_9e72a96(#"hash_47d7a8105237c88") + "<dev string:x8e>");
  adddebugcommand("<dev string:x33c>" + function_9e72a96(#"talent_staminup") + "<dev string:x8e>");
  adddebugcommand("<dev string:x380>" + function_9e72a96(#"talent_elemental_pop") + "<dev string:x8e>");
  adddebugcommand("<dev string:x3c9>" + function_9e72a96(#"hash_38c08136902fd553") + "<dev string:x8e>");
  adddebugcommand("<dev string:x40e>" + function_9e72a96(#"talent_mulekick") + "<dev string:x8e>");
  adddebugcommand("<dev string:x453>" + function_9e72a96(#"talent_deathperception") + "<dev string:x8e>");
  adddebugcommand("<dev string:x49f>" + function_9e72a96(#"talent_phdslider") + "<dev string:x8e>");
  adddebugcommand("<dev string:x4e5>" + function_9e72a96(#"talent_quickrevive") + "<dev string:x8e>");
  adddebugcommand("<dev string:x530>" + function_9e72a96(#"talent_speedcola") + "<dev string:x8e>");
}

function function_1d36527d(params) {
  tokens = strtok(params.value, "<dev string:x575>");

  if(!tokens.size || tokens[0] != "<dev string:x57a>" && tokens[0] != "<dev string:x58b>" && tokens[0] != "<dev string:x59c>" && tokens[0] != "<dev string:x5b1>") {
    return;
  }

  foreach(player in getplayers()) {
    if(tokens[0] === # "hash_6149e7b90451c6cd") {
      switch (tokens[1]) {
        case # "0":
          level.var_6f4eb990 = "<dev string:x38>";
          break;
        case # "1":
          level.var_6f4eb990 = "<dev string:x5c6>";
          break;
        case # "2":
          level.var_6f4eb990 = "<dev string:x5cc>";
          break;
        case # "3":
          level.var_6f4eb990 = "<dev string:x5d2>";
          break;
        case # "4":
          level.var_6f4eb990 = "<dev string:x5d8>";
          break;
        case # "5":
          level.var_6f4eb990 = "<dev string:x5de>";
          break;
      }

      continue;
    }

    if(tokens[0] === # "hash_24d26fc861b6ec66") {
      player function_3fecad82(hash(tokens[1] + level.var_6f4eb990), 0);
      continue;
    }

    if(tokens[0] === # "hash_2b274b2e4aa51e00") {
      if(player.var_7341f980.size > 0) {
        player function_4c1d0e25(player.var_7341f980[player.var_7341f980.size - 1]);
      }

      continue;
    }

    foreach(talent in player.var_7341f980) {
      player function_4c1d0e25(talent);
    }
  }
}
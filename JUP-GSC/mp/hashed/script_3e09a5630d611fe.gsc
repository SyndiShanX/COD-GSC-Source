/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3e09a5630d611fe.gsc
************************************************/

#using script_3008e3767a2a503c;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\engine\utility;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#namespace namespace_e862d960d61679ed;

function init() {
  level.lootitems = [];
  SetDvars();
  level.var_82b5ecc31717c4d4 = getdvarint(@ "hash_fba804ece774767a", 0) == 1;
  level.conf_fx["vanish"] = loadfx("vfx/core/impacts/small_snowhit");
  level.var_78a0087bea386662 = spawnStruct();
  level.var_78a0087bea386662.var_d04b4a9729479cad = &function_d04b4a9729479cad;
  level.var_78a0087bea386662.var_c80fb54710c9e5aa = &function_c80fb54710c9e5aa;
  level.var_78a0087bea386662.var_e807776b16dce7d4 = &get_reward;
  level.var_78a0087bea386662.onuse = &on_use;
  level.var_78a0087bea386662.var_d70ec56158c8530b = &function_d70ec56158c8530b;
  level.var_78a0087bea386662.var_35ad50d0a725c013 = &get_payload;
  level.var_e191e47360df882c = getdvarfloat(@ "hash_f392490d3e81dd36", 30);
}

function SetDvars() {
  setdvarifuninitialized(@ "hash_8d2054eb767885c0", 0.4);
  setdvarifuninitialized(@ "hash_db7a7896756f4c35", 0.4);
  setdvarifuninitialized(@ "hash_7d79b068a44a9c12", 0.2);
}

function function_d04b4a9729479cad() {
  return "ob_trickrtreat_loot";
}

function get_reward() {
  values = [1, 2, 3];
  weights = [getdvarfloat(@ "hash_8d2054eb767885c0"), getdvarfloat(@ "hash_db7a7896756f4c35"), getdvarfloat(@ "hash_7d79b068a44a9c12")];
  reward = weighted_array_randomize(values, weights);
  return reward;
}

function get_payload(player) {
  payload = [#"teamselect", player getentitynumber()];
  return payload;
}

function on_use(player) {
  if(isDefined(player.owner)) {
    player = player.owner;
  }

  switch (self.reward) {
    case 1:
      if(!isDefined(player.var_ee9bfea6c204ee1b)) {
        player.var_ee9bfea6c204ee1b = 0;
      }

      if(!isDefined(player.var_bc629c5fff0af845)) {
        player.var_bc629c5fff0af845 = 0;
      }

      player.var_ee9bfea6c204ee1b += 1;
      player.var_bc629c5fff0af845 += self.rewardcount;

      if(!isDefined(level.var_ee9bfea6c204ee1b)) {
        level.var_ee9bfea6c204ee1b = 0;
      }

      if(!isDefined(level.var_bc629c5fff0af845)) {
        level.var_bc629c5fff0af845 = 0;
      }

      level.var_ee9bfea6c204ee1b += 1;
      level.var_bc629c5fff0af845 += self.rewardcount;
      break;
    case 2:
      if(!isDefined(player.var_35f93f47b6c8e7d6)) {
        player.var_35f93f47b6c8e7d6 = 0;
      }

      if(!isDefined(player.var_64479d98631b7f44)) {
        player.var_64479d98631b7f44 = 0;
      }

      player.var_35f93f47b6c8e7d6 += 1;
      player.var_64479d98631b7f44 += self.rewardcount;

      if(!isDefined(level.var_35f93f47b6c8e7d6)) {
        level.var_35f93f47b6c8e7d6 = 0;
      }

      if(!isDefined(level.var_64479d98631b7f44)) {
        level.var_64479d98631b7f44 = 0;
      }

      level.var_35f93f47b6c8e7d6 += 1;
      level.var_64479d98631b7f44 += self.rewardcount;
      break;
    case 3:
      if(!isDefined(player.var_de86cab269eaee61)) {
        player.var_de86cab269eaee61 = 0;
      }

      if(!isDefined(player.var_ea4ec8e5a8b097ab)) {
        player.var_ea4ec8e5a8b097ab = 0;
      }

      player.var_de86cab269eaee61 += 1;
      player.var_ea4ec8e5a8b097ab += self.rewardcount;

      if(!isDefined(level.var_de86cab269eaee61)) {
        level.var_de86cab269eaee61 = 0;
      }

      if(!isDefined(level.var_ea4ec8e5a8b097ab)) {
        level.var_ea4ec8e5a8b097ab = 0;
      }

      level.var_de86cab269eaee61 += 1;
      level.var_ea4ec8e5a8b097ab += self.rewardcount;
      break;
    default:
      if(!isDefined(player.var_bdb2fe85c37c51c0)) {
        player.var_bdb2fe85c37c51c0 = 0;
      }

      if(!isDefined(player.var_b812d573a696f26)) {
        player.var_b812d573a696f26 = 0;
      }

      player.var_bdb2fe85c37c51c0 += 1;
      player.var_b812d573a696f26 += self.rewardcount;

      if(!isDefined(level.var_bdb2fe85c37c51c0)) {
        level.var_bdb2fe85c37c51c0 = 0;
      }

      if(!isDefined(level.var_b812d573a696f26)) {
        level.var_b812d573a696f26 = 0;
      }

      level.var_bdb2fe85c37c51c0 += 1;
      level.var_b812d573a696f26 += self.rewardcount;
      break;
  }

  player scripts\cp_mp\challenges::function_8359cadd253f9604(player, "event_trt_candy", self.rewardcount);
  player function_77f5f08a39a2d9f8(self.reward, self.rewardcount);
  player playsoundtoplayer("mp_trickrtreat_candy_pickup_player", player);
  thread function_4ebd84f3e771db5();
}

function function_c80fb54710c9e5aa(reward) {
  scriptablename = [[level.var_78a0087bea386662.var_d04b4a9729479cad]]();

  if(reward == 1) {
    self setscriptablepartstate(scriptablename, "small");
    return;
  }

  if(reward == 2) {
    self setscriptablepartstate(scriptablename, "medium");
    return;
  }

  if(reward == 3) {
    self setscriptablepartstate(scriptablename, "large");
  }
}

function function_d70ec56158c8530b(reward, var_401241f67709b018) {
  if(isDefined(reward)) {
    switch (var_401241f67709b018) {
      case #"hash_1380581f5144c465":
        var_57f7615bfae4f666 = hashcat(@ "hash_9b18672271153aba", var_401241f67709b018, "_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 2);
        break;
      case #"hash_99a38be9e88b5244":
        var_57f7615bfae4f666 = hashcat(@ "hash_9b18672271153aba", var_401241f67709b018, "_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 4);
        break;
      case #"hash_f297af39454fdc7b":
        var_57f7615bfae4f666 = hashcat(@ "hash_9b18672271153aba", var_401241f67709b018, "_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 4);
        break;
      case #"hash_99d5ac2f7a4d8083":
        var_57f7615bfae4f666 = hashcat(@ "hash_9b18672271153aba", var_401241f67709b018, "_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 6);
        break;
      case #"hash_1967f0e49ca5666a":
        var_57f7615bfae4f666 = hashcat(@ "hash_9b18672271153aba", var_401241f67709b018, "_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 6);
        break;
      case #"hash_8c089e813083e510":
        var_57f7615bfae4f666 = hashcat(@ "hash_9b18672271153aba", var_401241f67709b018, "_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 6);
        break;
      case #"hash_7b0e2f2ed84f34":
        var_57f7615bfae4f666 = hashcat(@ "hash_9b18672271153aba", var_401241f67709b018, "_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 6);
        break;
      case #"hash_7e8a002ed096276c":
        var_57f7615bfae4f666 = hashcat(@ "hash_9b18672271153aba", var_401241f67709b018, "_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 6);
        break;
      case #"hash_44aaeb0edd152195":
        var_57f7615bfae4f666 = hashcat(@ "hash_9b18672271153aba", var_401241f67709b018, "_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 6);
        break;
      case #"hash_84dc6b9f27a3589a":
        var_57f7615bfae4f666 = hashcat(@ "hash_9b18672271153aba", var_401241f67709b018, "_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 6);
        break;
      default:
        var_d7d1886440562afd = 2;
        break;
    }

    var_3a8d021bea0facd9 = getdvarint(@ "hash_4f836fbe97a31a4e", 1);

    if(var_3a8d021bea0facd9 == 2) {
      var_d7d1886440562afd *= getdvarfloat(@ "hash_94766bf2a11f0d23", 1.5);
    } else if(var_3a8d021bea0facd9 == 3) {
      var_d7d1886440562afd *= getdvarfloat(@ "hash_2fd3420b49098a86", 2);
    } else if(var_3a8d021bea0facd9 == 4) {
      var_d7d1886440562afd *= getdvarfloat(@ "hash_a413b48273b3f39", 2);
    }

    var_d7d1886440562afd = int(var_d7d1886440562afd);

    switch (reward) {
      case 1:
        var_d7d1886440562afd *= 3;

        if(!isDefined(level.var_509a4e442b1026ae)) {
          level.var_509a4e442b1026ae = 0;
        }

        if(!isDefined(level.var_3d9321fad7de61fc)) {
          level.var_3d9321fad7de61fc = 0;
        }

        level.var_509a4e442b1026ae += 1;
        level.var_3d9321fad7de61fc += var_d7d1886440562afd;
        break;
      case 2:
        var_d7d1886440562afd *= 6;

        if(!isDefined(level.var_ef645306c7d37997)) {
          level.var_ef645306c7d37997 = 0;
        }

        if(!isDefined(level.var_a57db3076bd3b939)) {
          level.var_a57db3076bd3b939 = 0;
        }

        level.var_ef645306c7d37997 += 1;
        level.var_a57db3076bd3b939 += var_d7d1886440562afd;
        break;
      case 3:
        var_d7d1886440562afd *= 12;

        if(!isDefined(level.var_f32504269cbbbe30)) {
          level.var_f32504269cbbbe30 = 0;
        }

        if(!isDefined(level.var_4870c7ef3543bfe)) {
          level.var_4870c7ef3543bfe = 0;
        }

        level.var_f32504269cbbbe30 += 1;
        level.var_4870c7ef3543bfe += var_d7d1886440562afd;
        break;
      case 4:
        var_d7d1886440562afd = 2;

        if(!isDefined(level.var_ec8144a5f732f17d)) {
          level.var_ec8144a5f732f17d = 0;
        }

        if(!isDefined(level.var_e4ccbbc61262c427)) {
          level.var_e4ccbbc61262c427 = 0;
        }

        level.var_ec8144a5f732f17d += 1;
        level.var_e4ccbbc61262c427 += var_d7d1886440562afd;
        break;
    }

    return var_d7d1886440562afd;
  }

  return 2;
}

function function_77f5f08a39a2d9f8(reward, amount) {
  if(!isDefined(self.pers["event_collectables"])) {
    self.pers["event_collectables"] = [];
  }

  if(!isDefined(self.pers["event_collectables"]["total_collectable_1"])) {
    self.pers["event_collectables"]["total_collectable_1"] = 0;
  }

  self.pers["event_collectables"]["total_collectable_1"] = self.pers["event_collectables"]["total_collectable_1"] + amount;
  self setclientomnvar("ui_collectable_1", self.pers["event_collectables"]["total_collectable_1"]);
}
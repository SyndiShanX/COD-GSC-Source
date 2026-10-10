/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3d3105ba2325c3d6.gsc
*************************************************/

#using script_3008e3767a2a503c;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\engine\utility;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#namespace namespace_29148a860fd5d5e1;

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
  level.var_e191e47360df882c = getdvarfloat(@ "hash_f392490d3e81dd36", 30);
}

function SetDvars() {
  setdvarifuninitialized(@ "hash_74822a7ee2049480", 0.25);
  setdvarifuninitialized(@ "hash_ce850e1d9a8797f5", 0.25);
  setdvarifuninitialized(@ "hash_8fae92f7f71f88d2", 0.25);
  setdvarifuninitialized(@ "hash_6510b02bd7cdff97", 0.25);
}

function function_d04b4a9729479cad() {
  return "altered_strain_loot";
}

function get_reward() {
  values = [1, 2, 3, 4];
  weights = [getdvarfloat(@ "hash_74822a7ee2049480"), getdvarfloat(@ "hash_ce850e1d9a8797f5"), getdvarfloat(@ "hash_8fae92f7f71f88d2"), getdvarfloat(@ "hash_6510b02bd7cdff97")];
  reward = weighted_array_randomize(values, weights);
  return reward;
}

function on_use(player) {
  if(isDefined(player.owner)) {
    player = player.owner;
  }

  switch (self.reward) {
    case 1:
      if(!isDefined(player.var_a626037fc1135883)) {
        player.var_a626037fc1135883 = 0;
      }

      player.var_a626037fc1135883 += self.rewardcount;

      if(!isDefined(level.var_83038e43b07056d7)) {
        level.var_83038e43b07056d7 = 0;
      }

      level.var_83038e43b07056d7 += self.rewardcount;
      player scripts\cp_mp\challenges::function_8359cadd253f9604(player, "event_altered_strain_pickup_1", self.rewardcount);
      break;
    case 2:
      if(!isDefined(player.var_9e87abcf9e7e4df2)) {
        player.var_9e87abcf9e7e4df2 = 0;
      }

      player.var_9e87abcf9e7e4df2 += self.rewardcount;

      if(!isDefined(level.var_cf161f4cfb70efe2)) {
        level.var_cf161f4cfb70efe2 = 0;
      }

      level.var_cf161f4cfb70efe2 += self.rewardcount;
      player scripts\cp_mp\challenges::function_8359cadd253f9604(player, "event_altered_strain_pickup_2", self.rewardcount);
      break;
    case 3:
      if(!isDefined(player.var_72620be67f8f3c61)) {
        player.var_72620be67f8f3c61 = 0;
      }

      player.var_72620be67f8f3c61 += self.rewardcount;

      if(!isDefined(level.var_15bdc538172e950d)) {
        level.var_15bdc538172e950d = 0;
      }

      level.var_15bdc538172e950d += self.rewardcount;
      player scripts\cp_mp\challenges::function_8359cadd253f9604(player, "event_altered_strain_pickup_3", self.rewardcount);
      break;
    case 4:
      if(!isDefined(player.var_b6cf555814d1e58)) {
        player.var_b6cf555814d1e58 = 0;
      }

      player.var_b6cf555814d1e58 += self.rewardcount;

      if(!isDefined(level.var_c38b6521a52c79c8)) {
        level.var_c38b6521a52c79c8 = 0;
      }

      level.var_c38b6521a52c79c8 += self.rewardcount;
      player scripts\cp_mp\challenges::function_8359cadd253f9604(player, "event_altered_strain_pickup_4", self.rewardcount);
      break;
  }

  player function_77f5f08a39a2d9f8(self.reward, self.rewardcount);
  player playsoundtoplayer("mp_altered_strain_dna_pickup_player", player);
  player playsoundtoteam("mp_altered_strain_dna_pickup_enemy", getotherteam(player.team)[0], player);
  player playsoundtoteam("mp_altered_strain_dna_pickup_ally", player.team, player);
  thread function_4ebd84f3e771db5();
}

function function_c80fb54710c9e5aa(reward) {
  scriptablename = [[level.var_78a0087bea386662.var_d04b4a9729479cad]]();

  if(reward == 1) {
    self setscriptablepartstate(scriptablename, "blue");
    return;
  }

  if(reward == 2) {
    self setscriptablepartstate(scriptablename, "orange");
    return;
  }

  if(reward == 3) {
    self setscriptablepartstate(scriptablename, "yellow");
    return;
  }

  if(reward == 4) {
    self setscriptablepartstate(scriptablename, "magenta");
  }
}

function function_d70ec56158c8530b(reward, var_401241f67709b018) {
  if(isDefined(reward)) {
    switch (var_401241f67709b018) {
      case #"hash_1380581f5144c465":
        var_57f7615bfae4f666 = hashcat(@ "hash_9671058829ae1590", var_401241f67709b018, "_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 2);
        break;
      case #"hash_99a38be9e88b5244":
        var_57f7615bfae4f666 = hashcat(@ "hash_9671058829ae1590", var_401241f67709b018, "_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 4);
        break;
      case #"hash_f297af39454fdc7b":
        var_57f7615bfae4f666 = hashcat(@ "hash_9671058829ae1590", var_401241f67709b018, "_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 4);
        break;
      case #"hash_99d5ac2f7a4d8083":
        var_57f7615bfae4f666 = hashcat(@ "hash_9671058829ae1590", var_401241f67709b018, "_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 6);
        break;
      case #"hash_1967f0e49ca5666a":
        var_57f7615bfae4f666 = hashcat(@ "hash_9671058829ae1590", var_401241f67709b018, "_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 6);
        break;
      case #"hash_8c089e813083e510":
        var_57f7615bfae4f666 = hashcat(@ "hash_9671058829ae1590", var_401241f67709b018, "_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 6);
        break;
      case #"hash_7b0e2f2ed84f34":
        var_57f7615bfae4f666 = hashcat(@ "hash_9671058829ae1590", var_401241f67709b018, "_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 6);
        break;
      case #"hash_7e8a002ed096276c":
        var_57f7615bfae4f666 = hashcat(@ "hash_9671058829ae1590", var_401241f67709b018, "_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 6);
        break;
      case #"hash_44aaeb0edd152195":
        var_57f7615bfae4f666 = hashcat(@ "hash_9671058829ae1590", var_401241f67709b018, "_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 6);
        break;
      case #"hash_84dc6b9f27a3589a":
        var_57f7615bfae4f666 = hashcat(@ "hash_9671058829ae1590", var_401241f67709b018, "_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 6);
        break;
      default:
        var_d7d1886440562afd = 2;
        break;
    }

    var_3a8d021bea0facd9 = getdvarint(@ "hash_4f836fbe97a31a4e", 1);

    if(var_3a8d021bea0facd9 == 2) {
      var_d7d1886440562afd *= getdvarfloat(@ "hash_24000380a33d5ed", 1.5);
    } else if(var_3a8d021bea0facd9 == 3) {
      var_d7d1886440562afd *= getdvarfloat(@ "hash_67236ea7d445e068", 2);
    } else if(var_3a8d021bea0facd9 == 4) {
      var_d7d1886440562afd *= getdvarfloat(@ "hash_c9a50952e931015f", 2);
    }

    var_d7d1886440562afd = int(var_d7d1886440562afd);

    switch (reward) {
      case 1:
        if(!isDefined(level.var_bda7b509e0070322)) {
          level.var_bda7b509e0070322 = 0;
        }

        level.var_bda7b509e0070322 += var_d7d1886440562afd;
        break;
      case 2:
        if(!isDefined(level.var_4c8a9411af3d9e8b)) {
          level.var_4c8a9411af3d9e8b = 0;
        }

        level.var_4c8a9411af3d9e8b += var_d7d1886440562afd;
        break;
      case 3:
        if(!isDefined(level.var_6bef474a253283e4)) {
          level.var_6bef474a253283e4 = 0;
        }

        level.var_6bef474a253283e4 += var_d7d1886440562afd;
        break;
      case 4:
        if(!isDefined(level.var_b63c2e64bc31f205)) {
          level.var_b63c2e64bc31f205 = 0;
        }

        level.var_b63c2e64bc31f205 += var_d7d1886440562afd;
        break;
    }

    return var_d7d1886440562afd;
  }

  return 2;
}
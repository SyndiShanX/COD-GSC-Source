/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3008e3767a2a503c.gsc
*************************************************/

#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\engine\utility;
#using scripts\mp\gameobjects;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#namespace namespace_876949a26c07c757;

function init() {
  level.lootitems = [];
  SetDvars();
  level.var_82b5ecc31717c4d4 = getdvarint(@ "hash_fba804ece774767a", 0) == 1;
  level.conf_fx["vanish"] = loadfx("vfx/core/impacts/small_snowhit");
  level.var_78a0087bea386662 = spawnStruct();
  level.var_78a0087bea386662.var_d04b4a9729479cad = &function_d04b4a9729479cad;
  level.var_78a0087bea386662.var_c80fb54710c9e5aa = &function_c80fb54710c9e5aa;
  level.var_78a0087bea386662.var_e807776b16dce7d4 = &get_reward;
  level.var_78a0087bea386662.onuse = &onuse;
  level.var_78a0087bea386662.var_d70ec56158c8530b = &function_d70ec56158c8530b;
  level.var_e191e47360df882c = getdvarfloat(@ "hash_f392490d3e81dd36", 30);
}

function SetDvars() {
  setdvarifuninitialized(@ "hash_c98b32754e2d7c86", 0.25);
  setdvarifuninitialized(@ "hash_f305666815da5e5f", 0.25);
  setdvarifuninitialized(@ "hash_805ad2ae010a9d84", 0.25);
  setdvarifuninitialized(@ "hash_d1deadfc50d1019d", 0.25);
  setdvarifuninitialized(@ "hash_57bb434e1ec5cadf", 1);
  setdvarifuninitialized(@ "hash_6c7cb07518465806", 1);
  setdvarifuninitialized(@ "hash_18dfce6e263f19a1", 1);
  setdvarifuninitialized(@ "hash_b0d7c0c4e891a448", 1);
}

function function_cb76a70c61b52b33() {
  victim = self;
  var_401241f67709b018 = undefined;

  if(victim.type == "human") {
    if(victim scripts\common\ai::is_warlord()) {
      var_401241f67709b018 = "warlord";
    } else {
      var_401241f67709b018 = "soldier";
    }
  } else if(victim.type == "zombie") {
    if(victim.aicategory == "boss" || victim.aicategory == "elite" || victim.aicategory == "special") {
      if(victim.subclass == "zombie_abom_mega") {
        var_401241f67709b018 = victim.subclass;
      } else {
        var_401241f67709b018 = victim.aicategory;
      }
    } else {
      var_401241f67709b018 = victim.subclass;
    }
  }

  return var_401241f67709b018;
}

function function_7502f58e600e74a2(victim, attacker, victimnotification, meansofdeath) {
  var_2db3d5c614236fa9 = victim function_2db3d5c614236fa9(attacker);

  if(!var_2db3d5c614236fa9) {
    return;
  }

  if(isagent(attacker) && isDefined(attacker.owner)) {
    attacker = attacker.owner;
  }

  var_8b7d4a024c529d6f = function_bc3c5e354753e249()[2];
  upangles = (0, 0, 0);
  var_650440c6a1642e7e = victim.angles;

  if(victim scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
    var_650440c6a1642e7e = victim getworldupreferenceangles();
    upangles = anglestoup(var_650440c6a1642e7e);

    if(upangles[2] < 0) {
      var_8b7d4a024c529d6f *= -1;
    }
  }

  useteam = "any";
  reward = [[level.var_78a0087bea386662.var_e807776b16dce7d4]]();
  var_401241f67709b018 = victim function_cb76a70c61b52b33();
  rewardcount = [[level.var_78a0087bea386662.var_d70ec56158c8530b]](reward, var_401241f67709b018);
  visuals = [];
  visuals[0] = spawnscriptable([[level.var_78a0087bea386662.var_d04b4a9729479cad]](), (0, 0, 0));
  visuals[0][[level.var_78a0087bea386662.var_c80fb54710c9e5aa]](reward);
  visuals[0] setasgametypeobjective();

  while(level.lootitems.size >= getdvarint(@ "hash_fc6e41604850dfd9", 40)) {
    item = level.lootitems[0];
    level.lootitems = array_remove(level.lootitems, item);
    item thread function_4ebd84f3e771db5();
  }

  trigger = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);

  if(victim scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
    if(upangles[2] < 0) {
      visuals[0].angles = var_650440c6a1642e7e;
    }
  }

  usetime = 0;
  lootitem = scripts\mp\gameobjects::createuseobject(useteam, trigger, visuals, (0, 0, 16), undefined, 1);
  lootitem.onuse = level.var_78a0087bea386662.onuse;
  lootitem scripts\mp\gameobjects::setusetime(usetime);
  lootitem.victim = victim;
  lootitem.victimteam = victim.team;
  lootitem.offset3d = (0, 0, 24);
  lootitem.var_ae93baab9975552b = gettime();
  lootitem thread function_db8b5d2d6301c494();
  pos = victim.origin + (0, 0, var_8b7d4a024c529d6f);
  lootitem.curorigin = pos;
  lootitem.trigger.origin = pos;
  lootitem.visuals[0].origin = pos;
  lootitem scripts\mp\gameobjects::initializetagpathvariables();
  lootitem scripts\mp\gameobjects::allowuse(useteam);
  lootitem.ownerteam = "neutral";
  lootitem.reward = reward;
  lootitem.rewardcount = rewardcount;
  level.lootitems = array_add(level.lootitems, lootitem);
  level notify(victimnotification, lootitem);
}

function function_db8b5d2d6301c494() {
  lootitem = self;
  lootitem endon("death");
  level endon("game_ended");
  wait level.var_e191e47360df882c;
  lootitem thread function_4ebd84f3e771db5();
}

function function_2db3d5c614236fa9(attacker) {
  if(isDefined(self.switching_teams)) {
    return 0;
  }

  if(isDefined(attacker) && attacker == self) {
    return 0;
  }

  if(level.teambased && isDefined(attacker) && isDefined(attacker.team) && attacker.team == self.team) {
    return 0;
  }

  if(isreallyalive(self)) {
    return 0;
  }

  var_401241f67709b018 = function_cb76a70c61b52b33();
  var_d9b5e34033d80256 = function_c7d4beb7bb6ef442(var_401241f67709b018);

  if(randomint(100) < var_d9b5e34033d80256) {
    return 1;
  }

  return 0;
}

function function_c7d4beb7bb6ef442(var_401241f67709b018) {
  dropchance = 100;

  switch (var_401241f67709b018) {
    case #"hash_1380581f5144c465":
      var_f405c1a2e39e05e5 = hashcat(@ "hash_23c25e028f38bb70", var_401241f67709b018, "_dropChance");
      dropchance = getdvarint(var_f405c1a2e39e05e5, 100);
      break;
    case #"hash_99a38be9e88b5244":
      var_f405c1a2e39e05e5 = hashcat(@ "hash_23c25e028f38bb70", var_401241f67709b018, "_dropChance");
      dropchance = getdvarint(var_f405c1a2e39e05e5, 100);
      break;
    case #"hash_f297af39454fdc7b":
      var_f405c1a2e39e05e5 = hashcat(@ "hash_23c25e028f38bb70", var_401241f67709b018, "_dropChance");
      dropchance = getdvarint(var_f405c1a2e39e05e5, 100);
      break;
    case #"hash_99d5ac2f7a4d8083":
      var_f405c1a2e39e05e5 = hashcat(@ "hash_23c25e028f38bb70", var_401241f67709b018, "_dropChance");
      dropchance = getdvarint(var_f405c1a2e39e05e5, 100);
      break;
    case #"hash_1967f0e49ca5666a":
      var_f405c1a2e39e05e5 = hashcat(@ "hash_23c25e028f38bb70", var_401241f67709b018, "_dropChance");
      dropchance = getdvarint(var_f405c1a2e39e05e5, 100);
      break;
    case #"hash_8c089e813083e510":
      var_f405c1a2e39e05e5 = hashcat(@ "hash_23c25e028f38bb70", var_401241f67709b018, "_dropChance");
      dropchance = getdvarint(var_f405c1a2e39e05e5, 100);
      break;
    case #"hash_7b0e2f2ed84f34":
      var_f405c1a2e39e05e5 = hashcat(@ "hash_23c25e028f38bb70", var_401241f67709b018, "_dropChance");
      dropchance = getdvarint(var_f405c1a2e39e05e5, 100);
      break;
    case #"hash_7e8a002ed096276c":
      var_f405c1a2e39e05e5 = hashcat(@ "hash_23c25e028f38bb70", var_401241f67709b018, "_dropChance");
      dropchance = getdvarint(var_f405c1a2e39e05e5, 100);
      break;
    case #"hash_44aaeb0edd152195":
      var_f405c1a2e39e05e5 = hashcat(@ "hash_23c25e028f38bb70", var_401241f67709b018, "_dropChance");
      dropchance = getdvarint(var_f405c1a2e39e05e5, 100);
      break;
    case #"hash_84dc6b9f27a3589a":
      var_f405c1a2e39e05e5 = hashcat(@ "hash_23c25e028f38bb70", var_401241f67709b018, "_dropChance");
      dropchance = getdvarint(var_f405c1a2e39e05e5, 100);
      break;
  }

  if(!isDefined(dropchance)) {
    dropchance = 100;
  }

  return dropchance;
}

function function_bc3c5e354753e249() {
  return (0, 0, 36);
}

function function_22bd898a1e929cf2() {
  self.attacker = undefined;
  self notify("reset");
  self.visuals[0] setscriptablepartstate([[level.var_78a0087bea386662.var_d04b4a9729479cad]](), "hidden");
  self.curorigin = (0, 0, 1000);
  self.trigger.origin = (0, 0, 1000);
  self.visuals[0].origin = (0, 0, 1000);
  scripts\mp\gameobjects::allowuse("none");
}

function onuse(player) {
  if(isDefined(player.owner)) {
    player = player.owner;
  }

  switch (self.reward) {
    case 1:
      if(!isDefined(player.var_b982ceb2ab8a2f94)) {
        player.var_b982ceb2ab8a2f94 = 0;
      }

      player.var_b982ceb2ab8a2f94 += self.rewardcount;
      player scripts\cp_mp\challenges::function_8359cadd253f9604(player, "event_countdown_pickup_0", self.rewardcount);
      break;
    case 2:
      if(!isDefined(player.var_67439179191b54a3)) {
        player.var_67439179191b54a3 = 0;
      }

      player.var_67439179191b54a3 += self.rewardcount;
      player scripts\cp_mp\challenges::function_8359cadd253f9604(player, "event_countdown_pickup_1", self.rewardcount);
      break;
    case 3:
      if(!isDefined(player.var_4fc80c2800aff392)) {
        player.var_4fc80c2800aff392 = 0;
      }

      player.var_4fc80c2800aff392 += self.rewardcount;
      player scripts\cp_mp\challenges::function_8359cadd253f9604(player, "event_countdown_pickup_2", self.rewardcount);
      break;
    case 4:
      if(!isDefined(player.var_fc45de226f41cf01)) {
        player.var_fc45de226f41cf01 = 0;
      }

      player.var_fc45de226f41cf01 += self.rewardcount;
      player scripts\cp_mp\challenges::function_8359cadd253f9604(player, "event_countdown_pickup_3", self.rewardcount);
      break;
  }

  player function_77f5f08a39a2d9f8(self.reward, self.rewardcount);
  player playsoundtoplayer("mp_countdown_dna_pickup_player", player);
  player playsoundtoteam("mp_countdown_dna_pickup_enemy", getotherteam(player.team)[0], player);
  player playsoundtoteam("mp_countdown_dna_pickup_ally", player.team, player);
  thread function_4ebd84f3e771db5();
}

function function_4ebd84f3e771db5() {
  if(istrue(self.var_2fc3fea26006d3a6)) {
    return;
  }

  self.var_2fc3fea26006d3a6 = 1;
  scripts\mp\gameobjects::allowuse("none");
  playFX(level.conf_fx["vanish"], self.curorigin);
  self notify("reset");
  waitframe();

  if(!isDefined(self)) {
    return;
  }

  self notify("death");

  for(i = 0; i < self.visuals.size; i++) {
    if(isDefined(self.visuals[i])) {
      self.visuals[i] freescriptable();
    }
  }

  if(!isDefined(self.skipminimapids)) {
    thread scripts\mp\gameobjects::deleteuseobject();
  }

  if(array_contains(level.lootitems, self)) {
    level.lootitems = array_remove(level.lootitems, self);
  }
}

function function_d04b4a9729479cad() {
  return "countdown_loot";
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

function get_reward() {
  values = [1, 2, 3, 4];
  weights = [getdvarfloat(@ "hash_c98b32754e2d7c86"), getdvarfloat(@ "hash_f305666815da5e5f"), getdvarfloat(@ "hash_805ad2ae010a9d84"), getdvarfloat(@ "hash_d1deadfc50d1019d")];
  reward = weighted_array_randomize(values, weights);
  return reward;
}

function weighted_array_randomize(array, weights) {
  assert(array.size == weights.size);
  cumulative_weight = 0;

  for(i = 0; i < weights.size; i++) {
    cumulative_weight += weights[i];
  }

  random_weight = randomfloat(cumulative_weight);
  running_total = 0;

  for(i = 0; i < array.size; i++) {
    running_total += weights[i];

    if(running_total >= random_weight) {
      return array[i];
    }
  }
}

function function_d70ec56158c8530b(reward, var_401241f67709b018) {
  if(isDefined(reward)) {
    switch (var_401241f67709b018) {
      case #"hash_1380581f5144c465":
        var_57f7615bfae4f666 = hashcat(@ "hash_23c25e028f38bb70", var_401241f67709b018, "_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 2);
        break;
      case #"hash_99a38be9e88b5244":
        var_57f7615bfae4f666 = hashcat(@ "hash_23c25e028f38bb70", var_401241f67709b018, "_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 4);
        break;
      case #"hash_f297af39454fdc7b":
        var_57f7615bfae4f666 = hashcat(@ "hash_23c25e028f38bb70", var_401241f67709b018, "_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 4);
        break;
      case #"hash_99d5ac2f7a4d8083":
        var_57f7615bfae4f666 = hashcat(@ "hash_23c25e028f38bb70", var_401241f67709b018, "_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 6);
        break;
      case #"hash_1967f0e49ca5666a":
        var_57f7615bfae4f666 = hashcat(@ "hash_23c25e028f38bb70", var_401241f67709b018, "_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 6);
        break;
      case #"hash_8c089e813083e510":
        var_57f7615bfae4f666 = hashcat(@ "hash_23c25e028f38bb70", var_401241f67709b018, "_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 6);
        break;
      case #"hash_7b0e2f2ed84f34":
        var_57f7615bfae4f666 = hashcat(@ "hash_23c25e028f38bb70", var_401241f67709b018, "_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 6);
        break;
      case #"hash_7e8a002ed096276c":
        var_57f7615bfae4f666 = hashcat(@ "hash_23c25e028f38bb70", var_401241f67709b018, "_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 6);
        break;
      case #"hash_44aaeb0edd152195":
        var_57f7615bfae4f666 = hashcat(@ "hash_23c25e028f38bb70", var_401241f67709b018, "_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 6);
        break;
      case #"hash_84dc6b9f27a3589a":
        var_57f7615bfae4f666 = hashcat(@ "hash_23c25e028f38bb70", var_401241f67709b018, "_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 6);
        break;
      default:
        var_d7d1886440562afd = 2;
        break;
    }

    var_3a8d021bea0facd9 = getdvarint(@ "hash_4f836fbe97a31a4e", 1);

    if(var_3a8d021bea0facd9 == 2) {
      var_d7d1886440562afd *= getdvarfloat(@ "hash_21b9212e6d7ff14d", 1.5);
    } else if(var_3a8d021bea0facd9 == 3) {
      var_d7d1886440562afd *= getdvarfloat(@ "hash_58be13d9db46fbc8", 2);
    } else if(var_3a8d021bea0facd9 == 4) {
      var_d7d1886440562afd *= getdvarfloat(@ "hash_69221a284669be3f", 2);
    }

    return int(var_d7d1886440562afd);
  }

  return 2;
}

function function_77f5f08a39a2d9f8(reward, amount) {
  switch (reward) {
    case 1:
      if(!isDefined(self.total_collectable_1)) {
        self.total_collectable_1 = 0;
      }

      self.total_collectable_1 += amount;
      self setclientomnvar("ui_collectable_1", self.total_collectable_1);
      break;
    case 2:
      if(!isDefined(self.total_collectable_2)) {
        self.total_collectable_2 = 0;
      }

      self.total_collectable_2 += amount;
      self setclientomnvar("ui_collectable_2", self.total_collectable_2);
      break;
    case 3:
      if(!isDefined(self.total_collectable_3)) {
        self.total_collectable_3 = 0;
      }

      self.total_collectable_3 += amount;
      self setclientomnvar("ui_collectable_3", self.total_collectable_3);
      break;
    case 4:
      if(!isDefined(self.total_collectable_4)) {
        self.total_collectable_4 = 0;
      }

      self.total_collectable_4 += amount;
      self setclientomnvar("ui_collectable_4", self.total_collectable_4);
      break;
  }
}
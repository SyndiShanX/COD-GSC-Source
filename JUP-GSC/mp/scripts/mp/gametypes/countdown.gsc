/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\countdown.gsc
***********************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\engine\utility;
#using scripts\mp\gameobjects;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#namespace countdown;

function init() {
  level.lootitems = [];
  SetDvars();
  level.var_82b5ecc31717c4d4 = getdvarint(@ "hash_fba804ece774767a", 0) == 1;
  level.conf_fx["vanish"] = loadfx("vfx/core/impacts/small_snowhit");
  level.var_78a0087bea386662 = spawnStruct();
  level.var_78a0087bea386662.var_d04b4a9729479cad = &function_d04b4a9729479cad;
  level.var_78a0087bea386662.var_c80fb54710c9e5aa = &function_c80fb54710c9e5aa;
  level.var_78a0087bea386662.var_e807776b16dce7d4 = &get_reward;
  level.var_78a0087bea386662.var_d70ec56158c8530b = &function_fba8eb934ad3b08b;
  level.var_78a0087bea386662.onuse = &on_use;
  level callback::add("player_disconnect", &onplayerdisconnect);
  thread function_899920a5f5f76a4b();
}

function SetDvars() {
  setdvarifuninitialized(@ "hash_c98b32754e2d7c86", 0.25);
  setdvarifuninitialized(@ "hash_f305666815da5e5f", 0.25);
  setdvarifuninitialized(@ "hash_805ad2ae010a9d84", 0.25);
  setdvarifuninitialized(@ "hash_d1deadfc50d1019d", 0.25);

  if(getgametype() == "xfire") {
    setdvarifuninitialized(@ "hash_30ac4415ff58708e", 1);
  }
}

function function_7502f58e600e74a2(victim, attacker, victimnotification, meansofdeath) {
  var_2db3d5c614236fa9 = victim function_2db3d5c614236fa9(attacker);

  if(!var_2db3d5c614236fa9) {
    return;
  }

  if(isagent(victim) && (getgametype() != "koth_horde_haunting" || victim.type != "zombie")) {
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
  rewardcount = [[level.var_78a0087bea386662.var_d70ec56158c8530b]](reward);

  if(getgametype() == "koth_horde_haunting" && isDefined(victim.type) && victim.type == "zombie") {
    victim.guid = victim getuniqueid();
  }

  if(isDefined(level.lootitems[victim.guid])) {
    function_4ebd84f3e771db5(victim.guid, 1);
  }

  visuals = [];
  payload = undefined;

  if(isDefined(level.var_78a0087bea386662.var_35ad50d0a725c013)) {
    payload = [[level.var_78a0087bea386662.var_35ad50d0a725c013]](attacker);
  }

  visuals[0] = spawnscriptable([[level.var_78a0087bea386662.var_d04b4a9729479cad]](), (0, 0, 0), (0, 0, 0), undefined, payload);
  visuals[0][[level.var_78a0087bea386662.var_c80fb54710c9e5aa]](reward);
  visuals[0] setasgametypeobjective();
  trigger = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);

  if(victim scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
    if(upangles[2] < 0) {
      visuals[0].angles = var_650440c6a1642e7e;
    }
  }

  usetime = 0;
  level.lootitems[victim.guid] = scripts\mp\gameobjects::createuseobject(useteam, trigger, visuals, (0, 0, 16));
  level.lootitems[victim.guid].onuse = level.var_78a0087bea386662.onuse;
  level.lootitems[victim.guid] scripts\mp\gameobjects::setusetime(usetime);
  level.lootitems[victim.guid].victim = victim;
  level.lootitems[victim.guid].victimteam = victim.team;
  level.lootitems[victim.guid].offset3d = (0, 0, 24);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(level.lootitems[victim.guid].objidnum, level.lootitems[victim.guid].offset3d[2]);
  attacker thread function_b08b83755bcac562(level.lootitems[victim.guid]);
  pos = victim.origin + (0, 0, var_8b7d4a024c529d6f);
  level.lootitems[victim.guid].curorigin = pos;
  level.lootitems[victim.guid].trigger.origin = pos;
  level.lootitems[victim.guid].visuals[0].origin = pos;
  level.lootitems[victim.guid] scripts\mp\gameobjects::initializetagpathvariables();
  level.lootitems[victim.guid] scripts\mp\gameobjects::allowuse(useteam);
  level.lootitems[victim.guid].attacker = attacker;
  level.lootitems[victim.guid].attackerteam = attacker.team;
  level.lootitems[victim.guid].ownerteam = "neutral";
  level.lootitems[victim.guid].reward = reward;
  level.lootitems[victim.guid].rewardcount = rewardcount;
  level.lootitems[victim.guid].guid = victim.guid;

  if(isDefined(level.lootitems[victim.guid].objidnum) && level.lootitems[victim.guid].objidnum != -1) {
    objid = level.lootitems[victim.guid].objidnum;
    state = "current";

    if(!istrue(level.var_82b5ecc31717c4d4)) {
      state = "active";
    }

    scripts\mp\objidpoolmanager::update_objective_state(objid, state);
    scripts\mp\objidpoolmanager::update_objective_position(objid, victim.origin + (0, 0, 36));
    scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
    scripts\mp\objidpoolmanager::objective_set_play_intro(level.lootitems[victim.guid].objidnum, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(level.lootitems[victim.guid].objidnum, 0);
    scripts\mp\objidpoolmanager::function_98ba077848896a3(level.lootitems[victim.guid].objidnum, 0);
    scripts\mp\objidpoolmanager::function_f21e9b2e78de984b(level.lootitems[victim.guid].objidnum, 800, 1600);
  }

  level notify(victimnotification, level.lootitems[victim.guid]);
}

function function_2db3d5c614236fa9(attacker) {
  if(getgametype() == "br") {
    return false;
  }

  if(isDefined(self.switching_teams)) {
    return false;
  }

  if(isDefined(attacker) && attacker == self) {
    return false;
  }

  if(level.teambased && isDefined(attacker) && isDefined(attacker.team) && isDefined(self.team) && attacker.team == self.team) {
    return false;
  }

  if(isDefined(attacker) && !isDefined(attacker.team) && (attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn")) {
    return false;
  }

  if(isreallyalive(self)) {
    return false;
  }

  if(istrue(attacker.var_7affdedf6874a6b)) {
    return false;
  }

  return true;
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

  if(self.objidnum != -1) {
    scripts\mp\objidpoolmanager::update_objective_state(self.objidnum, "done");
  }
}

function on_use(player) {
  if(isDefined(player.owner)) {
    player = player.owner;
  }

  switch (self.reward) {
    case 1:
      if(!isDefined(player.var_b982ceb2ab8a2f94)) {
        player.var_b982ceb2ab8a2f94 = 0;
      }

      player.var_b982ceb2ab8a2f94 += self.rewardcount;

      if(!isDefined(level.var_73dbc3b2132b4b04)) {
        level.var_73dbc3b2132b4b04 = 0;
      }

      level.var_73dbc3b2132b4b04 += self.rewardcount;
      player scripts\cp_mp\challenges::function_8359cadd253f9604(player, "event_countdown_pickup_0", self.rewardcount);
      break;
    case 2:
      if(!isDefined(player.var_67439179191b54a3)) {
        player.var_67439179191b54a3 = 0;
      }

      player.var_67439179191b54a3 += self.rewardcount;

      if(!isDefined(level.var_b6930f6a626cecb7)) {
        level.var_b6930f6a626cecb7 = 0;
      }

      level.var_b6930f6a626cecb7 += self.rewardcount;
      player scripts\cp_mp\challenges::function_8359cadd253f9604(player, "event_countdown_pickup_1", self.rewardcount);
      break;
    case 3:
      if(!isDefined(player.var_4fc80c2800aff392)) {
        player.var_4fc80c2800aff392 = 0;
      }

      player.var_4fc80c2800aff392 += self.rewardcount;

      if(!isDefined(level.var_1337e1a54678ffc2)) {
        level.var_1337e1a54678ffc2 = 0;
      }

      level.var_1337e1a54678ffc2 += self.rewardcount;
      player scripts\cp_mp\challenges::function_8359cadd253f9604(player, "event_countdown_pickup_2", self.rewardcount);
      break;
    case 4:
      if(!isDefined(player.var_fc45de226f41cf01)) {
        player.var_fc45de226f41cf01 = 0;
      }

      player.var_fc45de226f41cf01 += self.rewardcount;

      if(!isDefined(level.var_d01465a3daf800ed)) {
        level.var_d01465a3daf800ed = 0;
      }

      level.var_d01465a3daf800ed += self.rewardcount;
      player scripts\cp_mp\challenges::function_8359cadd253f9604(player, "event_countdown_pickup_3", self.rewardcount);
      break;
  }

  player function_77f5f08a39a2d9f8(self.reward, self.rewardcount);
  player playsoundtoplayer("mp_countdown_dna_pickup_player", player);
  player playsoundtoteam("mp_countdown_dna_pickup_enemy", getotherteam(player.team)[0], player);
  player playsoundtoteam("mp_countdown_dna_pickup_ally", player.team, player);
  thread function_4ebd84f3e771db5(self.victim.guid, undefined, player);
}

function function_b08b83755bcac562(lootitem) {
  level endon("game_ended");
  self endon("disconnect");
  lootitem endon("death");

  while(true) {
    self waittill("joined_team");
    thread function_4ebd84f3e771db5(lootitem.victim.guid, 1);
  }
}

function function_4ebd84f3e771db5(guid, notifyattacker, collector) {
  if(isDefined(level.lootitems[guid])) {
    level.lootitems[guid] scripts\mp\gameobjects::allowuse("none");
    playFX(level.conf_fx["vanish"], level.lootitems[guid].curorigin);
    level.lootitems[guid] notify("reset");
    waitframe();

    if(!isDefined(level.lootitems[guid])) {
      return;
    }

    level.lootitems[guid] notify("death");

    for(i = 0; i < level.lootitems[guid].visuals.size; i++) {
      level.lootitems[guid].visuals[i] freescriptable();
    }

    if(!isDefined(level.lootitems[guid].skipminimapids)) {
      level.lootitems[guid] thread scripts\mp\gameobjects::deleteuseobject();
    }

    level.lootitems[guid] = undefined;
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

function function_fba8eb934ad3b08b(reward) {
  if(isDefined(reward)) {
    switch (reward) {
      case 1:
        var_57f7615bfae4f666 = hashcat(@ "hash_5cb5d505bd928620", getbasegametype(), "_reward_0_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 17);

        if(!isDefined(level.var_ea10260a5b2419f9)) {
          level.var_ea10260a5b2419f9 = 0;
        }

        level.var_ea10260a5b2419f9 += var_d7d1886440562afd;
        break;
      case 2:
        var_57f7615bfae4f666 = hashcat(@ "hash_5cb5d505bd928620", getbasegametype(), "_reward_1_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 17);

        if(!isDefined(level.var_3125ff37539a8b02)) {
          level.var_3125ff37539a8b02 = 0;
        }

        level.var_3125ff37539a8b02 += var_d7d1886440562afd;
        break;
      case 3:
        var_57f7615bfae4f666 = hashcat(@ "hash_5cb5d505bd928620", getbasegametype(), "_reward_2_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 15);

        if(!isDefined(level.var_7fbee291ee102c6b)) {
          level.var_7fbee291ee102c6b = 0;
        }

        level.var_7fbee291ee102c6b += var_d7d1886440562afd;
        break;
      case 4:
        var_57f7615bfae4f666 = hashcat(@ "hash_5cb5d505bd928620", getbasegametype(), "_reward_3_amount");
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 17);

        if(!isDefined(level.var_6141ba5646bcb9c4)) {
          level.var_6141ba5646bcb9c4 = 0;
        }

        level.var_6141ba5646bcb9c4 += var_d7d1886440562afd;
        break;
      default:
        var_d7d1886440562afd = 17;
        break;
    }

    return var_d7d1886440562afd;
  }

  return 17;
}

function function_77f5f08a39a2d9f8(reward, amount) {
  if(!isDefined(self.pers["event_collectables"])) {
    self.pers["event_collectables"] = [];
  }

  switch (reward) {
    case 1:
      if(!isDefined(self.pers["event_collectables"]["total_collectable_1"])) {
        self.pers["event_collectables"]["total_collectable_1"] = 0;
      }

      self.pers["event_collectables"]["total_collectable_1"] = self.pers["event_collectables"]["total_collectable_1"] + amount;
      self setclientomnvar("ui_collectable_1", self.pers["event_collectables"]["total_collectable_1"]);
      break;
    case 2:
      if(!isDefined(self.pers["event_collectables"]["total_collectable_2"])) {
        self.pers["event_collectables"]["total_collectable_2"] = 0;
      }

      self.pers["event_collectables"]["total_collectable_2"] = self.pers["event_collectables"]["total_collectable_2"] + amount;
      self setclientomnvar("ui_collectable_2", self.pers["event_collectables"]["total_collectable_2"]);
      break;
    case 3:
      if(!isDefined(self.pers["event_collectables"]["total_collectable_3"])) {
        self.pers["event_collectables"]["total_collectable_3"] = 0;
      }

      self.pers["event_collectables"]["total_collectable_3"] = self.pers["event_collectables"]["total_collectable_3"] + amount;
      self setclientomnvar("ui_collectable_3", self.pers["event_collectables"]["total_collectable_3"]);
      break;
    case 4:
      if(!isDefined(self.pers["event_collectables"]["total_collectable_4"])) {
        self.pers["event_collectables"]["total_collectable_4"] = 0;
      }

      self.pers["event_collectables"]["total_collectable_4"] = self.pers["event_collectables"]["total_collectable_4"] + amount;
      self setclientomnvar("ui_collectable_4", self.pers["event_collectables"]["total_collectable_4"]);
      break;
  }
}

function function_899920a5f5f76a4b() {
  level endon("game_ended");

  while(!isDefined(level.players) || level.players.size < 1) {
    wait 0.5;
  }

  foreach(player in level.players) {
    player thread function_d6f787b4c0967913();
  }
}

function function_d6f787b4c0967913() {
  level endon("game_ended");
  self endon("disconnect");

  while(!isDefined(self.pers)) {
    waitframe();
  }

  if(!isDefined(self.pers["event_collectables"])) {
    return;
  }

  if(isDefined(self.pers["event_collectables"]["total_collectable_1"])) {
    self setclientomnvar("ui_collectable_1", self.pers["event_collectables"]["total_collectable_1"]);
  }

  if(isDefined(self.pers["event_collectables"]["total_collectable_2"])) {
    self setclientomnvar("ui_collectable_2", self.pers["event_collectables"]["total_collectable_2"]);
  }

  if(isDefined(self.pers["event_collectables"]["total_collectable_3"])) {
    self setclientomnvar("ui_collectable_3", self.pers["event_collectables"]["total_collectable_3"]);
  }

  if(isDefined(self.pers["event_collectables"]["total_collectable_4"])) {
    self setclientomnvar("ui_collectable_4", self.pers["event_collectables"]["total_collectable_4"]);
  }
}

function onplayerdisconnect(params) {
  if(isDefined(self.guid)) {
    thread function_4ebd84f3e771db5(self.guid, 1);
  }
}
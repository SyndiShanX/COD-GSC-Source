/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\trickrtreat.gsc
************************************************/

#using script_44b8991c2b01716a;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\playerachievements;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\gametypes\countdown;
#using scripts\mp\gametypes\trickrtreat;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#namespace trickrtreat;

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
  level.var_78a0087bea386662.var_35ad50d0a725c013 = &get_payload;
  utility::registersharedfunc("game", "trickrtreatAchievementStateFetched", &function_695f31c017a09ce5);
  level callback::add("player_connect", &onplayerconnect);
  level callback::add("player_disconnect", &onplayerdisconnect);
  thread function_899920a5f5f76a4b();
  function_ea4aaa2f9aad1dbc(45976, 1000000);
  level.var_83cceb8b2020997c = ["bp_haunting_punish_1", "bp_haunting_punish_2"];
  level.var_7a45642e3586f6d5 = 1;
}

function SetDvars() {
  setdvarifuninitialized(@ "hash_e44c66b854aeeebb", 0);
  setdvarifuninitialized(@ "hash_8d2054eb767885c0", 0.333333);
  setdvarifuninitialized(@ "hash_db7a7896756f4c35", 0.333333);
  setdvarifuninitialized(@ "hash_7d79b068a44a9c12", 0.333333);
  setdvarifuninitialized(@ "hash_2a96a32653965c73", 0.333333);
  setdvarifuninitialized(@ "hash_2a96a42653965ea6", 0.333333);
  setdvarifuninitialized(@ "hash_2a96a526539660d9", 0.333333);
  setdvarifuninitialized(@ "hash_6326b90bd33eec6f", 1);
  setdvarifuninitialized(@ "hash_2200efb3f46607b", 4);
  setdvarifuninitialized(@ "hash_2191da8084e2a00d", 5625);
  setdvarifuninitialized(@ "hash_5f60d5026cd2c8b0", 1);
  setdvarifuninitialized(@ "hash_51facc094fa68ceb", 1);
  setdvarifuninitialized(@ "hash_e81b83bf110b7c8d", 200);
  setdvarifuninitialized(@ "hash_2f168a7cfe717697", 20);
  setdvarifuninitialized(@ "hash_1119a59db5e68d71", 1);
  setdvarifuninitialized(@ "hash_4f63ef44f4328c06", 110);
  setdvarifuninitialized(@ "hash_4c87c583ae49e672", 150);
  setdvarifuninitialized(@ "hash_2113f81f93f5fe2e", 0.9);
  setdvarifuninitialized(@ "hash_a929e525622180dc", 1);
  setdvarifuninitialized(@ "hash_7a2b51f4615759d3", 5);
}

function function_d04b4a9729479cad() {
  return "trickrtreat_loot";
}

function get_reward() {
  values = [1, 2, 3];
  var_5994a3fa21cf8136 = scripts\mp\gametypes\trickrtreat::function_9d900983f9f0809b();

  switch (var_5994a3fa21cf8136) {
    case #"hash_fa21c4f6bd5e3815":
      weights = [getdvarfloat(@ "hash_2a96a32653965c73"), getdvarfloat(@ "hash_2a96a42653965ea6"), getdvarfloat(@ "hash_2a96a526539660d9")];
      break;
    case #"hash_fa24c8f6bd607cf8":
      weights = [getdvarfloat(@ "hash_8d2054eb767885c0"), getdvarfloat(@ "hash_db7a7896756f4c35"), getdvarfloat(@ "hash_7d79b068a44a9c12")];
      break;
    default:
      weights = [getdvarfloat(@ "hash_8d2054eb767885c0"), getdvarfloat(@ "hash_db7a7896756f4c35"), getdvarfloat(@ "hash_7d79b068a44a9c12")];
      break;
  }

  reward = weighted_array_randomize(values, weights);
  return reward;
}

function function_fba8eb934ad3b08b(reward) {
  if(isDefined(reward)) {
    var_57f7615bfae4f666 = scripts\mp\gametypes\trickrtreat::function_c3b312fdf727fe94(reward);

    switch (reward) {
      case 1:
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 18);

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
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 35);

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
        var_d7d1886440562afd = getdvarint(var_57f7615bfae4f666, 70);

        if(!isDefined(level.var_f32504269cbbbe30)) {
          level.var_f32504269cbbbe30 = 0;
        }

        if(!isDefined(level.var_4870c7ef3543bfe)) {
          level.var_4870c7ef3543bfe = 0;
        }

        level.var_f32504269cbbbe30 += 1;
        level.var_4870c7ef3543bfe += var_d7d1886440562afd;
        break;
      default:
        var_d7d1886440562afd = 35;

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

  return 35;
}

function on_use(player) {
  if(getdvarint(@ "hash_a929e525622180dc") == 1) {
    if(player != self.attacker) {
      return;
    }
  }

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
  thread function_4ebd84f3e771db5(self.guid, undefined, player);
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

function get_payload(player) {
  payload = [#"teamselect", player getentitynumber()];
  return payload;
}

function playerstancechanged(newstance) {
  curtime = gettime();

  if(newstance == "crouch") {
    if(isDefined(self.lastkillvictimpos) && !self isshooting()) {
      if(distancesquared(self.lastkillvictimpos, self.origin) < getdvarfloat(@ "hash_2191da8084e2a00d")) {
        timesincelastcrouch = curtime - self.laststancetimes["crouch"];
        timesincelastkill = curtime - self.lastkilltime;

        if(timesincelastcrouch < 750 && timesincelastkill < 8000) {
          if(isDefined(self.var_3e6101fe7812a0e0) && self.var_3e6101fe7812a0e0 + 1 >= getdvarint(@ "hash_2200efb3f46607b")) {
            thread function_89d89d2cbde23371();
          } else {
            if(isDefined(self.var_3e6101fe7812a0e0)) {
              self.var_3e6101fe7812a0e0 += 1;
              return;
            }

            self.var_3e6101fe7812a0e0 = 1;
            return;
          }
        } else {
          self.var_3e6101fe7812a0e0 = 1;
          return;
        }
      }
    }

    self.var_3e6101fe7812a0e0 = 0;
  }
}

function function_89d89d2cbde23371() {
  randomnum = randomint(level.var_83cceb8b2020997c.size);
  var_9ba0d32850eee4c8 = namespace_2db04a57a1b9bf62::function_f7fe427d574911c(level.var_83cceb8b2020997c[randomnum], self, 1, 0);
  var_ff9054123c7d2ac9 = makeweapon("jackolantern");

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    if(scripts\cp_mp\armor::hasarmor()) {
      scripts\cp_mp\armor::damagearmor(getdvarfloat(@ "hash_4c87c583ae49e672"));
    } else {
      self dodamage(self.health * getdvarfloat(@ "hash_2113f81f93f5fe2e"), self.origin, self, undefined, "MOD_TRIGGER_HURT", var_ff9054123c7d2ac9);
    }

    return;
  }

  self dodamage(self.health * getdvarfloat(@ "hash_2113f81f93f5fe2e"), self.origin, self, undefined, "MOD_TRIGGER_HURT", var_ff9054123c7d2ac9);
}

function function_92e1ac992073f2dd() {
  level endon("game_ended");

  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  level.var_29ac6b93266dfc1a = [];
  var_29ac6b93266dfc1a = getStructArray("jackolantern", "script_noteworthy");

  foreach(jackolantern in var_29ac6b93266dfc1a) {
    grenade = self launchgrenade("jackolantern", jackolantern.origin + (0, 0, 4), (0, 0, 0));
    level.var_29ac6b93266dfc1a = array_add(level.var_29ac6b93266dfc1a, grenade);

    if(getdvarint(@ "hash_51facc094fa68ceb") == 1) {
      grenade thread function_58265930964b758e();
      grenade thread function_49a4caecd2d14a8f();
    }
  }
}

function function_58265930964b758e() {
  level endon("game_ended");
  self.health = getdvarint(@ "hash_e81b83bf110b7c8d");
  self setCanDamage(1);
  self setCanRadiusDamage(1);

  while(isDefined(self)) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(isDefined(attacker) && (istrue(attacker.isjuggernaut) || istrue(attacker.var_967123630ad7ddc6)) || isDefined(objweapon) && scripts\cp_mp\weapon::iskillstreakweapon(objweapon)) {
      if(isDefined(self) && isDefined(self.health)) {
        self.health += damage;
        continue;
      }
    }

    if(isDefined(self) && isDefined(self.health) && self.health <= 0) {
      if(isPlayer(attacker)) {
        if(!isDefined(inflictor) || !isDefined(inflictor.birthtime) || !isDefined(inflictor.owner) || !isDefined(inflictor.owner.deathtime) || inflictor.birthtime > inflictor.owner.deathtime) {
          attacker thread function_89d89d2cbde23371();
        }
      }

      self setscriptablepartstate("trickrtreat_jackolantern", "hidden");
      function_68193adc1593a0e(self);
    }
  }
}

function function_49a4caecd2d14a8f() {
  level endon("game_ended");

  while(isDefined(self)) {
    wait getdvarint(@ "hash_1119a59db5e68d71");

    if(isDefined(self) && isDefined(self.health) && self.health < getdvarint(@ "hash_e81b83bf110b7c8d")) {
      if(self.health + getdvarint(@ "hash_2f168a7cfe717697") > getdvarint(@ "hash_e81b83bf110b7c8d")) {
        self.health = getdvarint(@ "hash_e81b83bf110b7c8d");
        continue;
      }

      self.health += getdvarint(@ "hash_2f168a7cfe717697");
    }
  }
}

function function_68193adc1593a0e(var_9b43d82978786687) {
  foreach(jackolantern in level.var_29ac6b93266dfc1a) {
    if(isDefined(jackolantern) && jackolantern getscriptablepartstate("trickrtreat_jackolantern") == "hidden" && jackolantern != var_9b43d82978786687) {
      jackolantern setscriptablepartstate("trickrtreat_jackolantern", "visible");
      jackolantern.health = getdvarint(@ "hash_e81b83bf110b7c8d");
      return;
    }
  }
}

function onplayerconnect(params) {
  if(!matchmakinggame()) {
    thread function_539593ba238cc26c();
  }

  foreach(achievementid, struct in level.var_cb71fe1ecc4006b5) {
    scripts\cp_mp\playerachievements::getstate(self, achievementid);
  }

  if(getdvarint(@ "hash_5f60d5026cd2c8b0") == 1 && !istrue(level.var_29ee19180d278beb)) {
    thread function_92e1ac992073f2dd();
    level.var_29ee19180d278beb = 1;
  }
}

function function_ea4aaa2f9aad1dbc(achievementid, var_7ab6dba5e9adbffb) {
  if(!isDefined(level.var_cb71fe1ecc4006b5)) {
    level.var_cb71fe1ecc4006b5 = [];
  }

  if(!isDefined(level.var_cb71fe1ecc4006b5[achievementid])) {
    level.var_cb71fe1ecc4006b5[achievementid] = spawnStruct();
  }

  struct = level.var_cb71fe1ecc4006b5[achievementid];
  struct.achievementid = achievementid;
  struct.var_7ab6dba5e9adbffb = var_7ab6dba5e9adbffb;
}

function function_539593ba238cc26c() {
  self endon("disconnect");

  if(getdvarint(@ "hash_e44c66b854aeeebb", 0) == 1) {
    [achievementid, progressdata] = function_5ba9e679fe13fe5e(45976, 1000000);
    function_695f31c017a09ce5(achievementid, progressdata);
  }
}

function function_5ba9e679fe13fe5e(achievementid, var_51c6029a1deceecf) {
  progressdata = spawnStruct();
  progressdata.progress_values = [];
  progressdata.progress_values[0] = spawnStruct();
  progressdata.progress_values[0].progress_id = scripts\cp_mp\playerachievements::function_691880160b33d133("progress");
  progressdata.progress_values[0].progress = var_51c6029a1deceecf;
  return [achievementid, progressdata];
}

function function_695f31c017a09ce5(achievementid, progressdata) {
  if(!isDefined(level.var_cb71fe1ecc4006b5[achievementid])) {
    return;
  }

  var_cb821ca45b880504 = scripts\cp_mp\playerachievements::function_691880160b33d133("progress");
  progress = 0;

  for(index = 0; index < progressdata.progress_values.size; index++) {
    progress_id = progressdata.progress_values[index].progress_id;

    if(is_equal(var_cb821ca45b880504, progress_id)) {
      progress = progressdata.progress_values[index].progress;
      break;
    }
  }

  if(progress >= level.var_cb71fe1ecc4006b5[achievementid].var_7ab6dba5e9adbffb) {
    self.var_7affdedf6874a6b = 1;
  }
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
}

function function_9d900983f9f0809b() {
  var_aea64aefd16db220 = scripts\cp_mp\utility\game_utility::isbrstylegametype();
  basegametype = scripts\cp_mp\utility\game_utility::getbasegametype();

  if(isDefined(var_aea64aefd16db220) && var_aea64aefd16db220) {
    if(isDefined(basegametype) && basegametype != "ob") {
      return "br";
    } else {
      return "ob";
    }

    return;
  }

  if(isDefined(var_aea64aefd16db220) && !var_aea64aefd16db220) {
    return "mp";
  }

  return "default";
}

function function_c3b312fdf727fe94(reward) {
  var_5994a3fa21cf8136 = scripts\mp\gametypes\trickrtreat::function_9d900983f9f0809b();

  switch (var_5994a3fa21cf8136) {
    case #"hash_fa21c4f6bd5e3815":
      return hashcat(@ "hash_70a72aab7c49d929", reward, "_amount");
    case #"hash_fa24c8f6bd607cf8":
      return hashcat(@ "hash_75fdea4f42f7cf36", getbasegametype(), "_reward_", reward, "_amount");
    default:
      return hashcat(@ "hash_397bf8488876f353");
  }
}
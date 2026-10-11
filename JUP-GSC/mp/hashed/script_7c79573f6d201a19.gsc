/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7c79573f6d201a19.gsc
*************************************************/

#using script_40e63dd222434655;
#using script_4f76bee355450e6d;
#using script_59ff79d681bb860c;
#using script_64acb6ce534155b7;
#using script_7fc58c95ee47d870;
#using script_ca34b05781dbece;
#using script_d74ae0b4aa21186;
#using scripts\engine\utility;
#using scripts\mp\bots\bots_util;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\utility\player;
#namespace pickup;

function function_eda57308516bfc5f() {
  decision = function_bffb5b682a4ef6a2(&evaluatescore, undefined, undefined, &function_b97e27a7552f6031);
  decision function_7fe87b5456bf27b8();
  return decision;
}

function function_b97e27a7552f6031(argument1, argument2) {
  return argument1.entity == argument2.entity;
}

function evaluatescore(bot) {
  if(scripts\mp\gamelogic::inprematch()) {
    return 0;
  }

  result = spawnStruct();
  result.finalscore = 0;
  result.finaltarget = undefined;
  var_32028db58afc5fa9 = bot namespace_10ca308be68952f::getevent();
  var_e58460405b36b647 = bot namespace_a88fd88e39d4308::getevent();
  var_ec10c084410e83fc = bot namespace_9d48dceb90164d92::getevent();
  function_cec7c34920151fa();
  gamestage = function_1c51f7c46a848ddd();
  var_9073e5955eaebe2c = function_9d1ab012058221bb(gamestage, self.constants.var_e23500dbd314bae2, self.constants.var_e58a5e1efeb78937);
  evaluateentityarray(bot, var_32028db58afc5fa9, result, gamestage, var_9073e5955eaebe2c);
  evaluateentityarray(bot, var_e58460405b36b647, result, gamestage, var_9073e5955eaebe2c);
  evaluateentityarray(bot, var_ec10c084410e83fc, result, gamestage, var_9073e5955eaebe2c);

  if(bot function_9612d351d714efb1()) {
    result.finalscore += self.constants.var_65789424b6d020cc;
  }

  if(isDefined(self.var_8ff05874bbb1ac7c) && self.var_8ff05874bbb1ac7c.score > result.finalscore) {
    self.var_df9d35d9b4bee654 = self.var_8ff05874bbb1ac7c;
    return self.var_8ff05874bbb1ac7c.score;
  }

  if(isDefined(result.finaltarget) && isDefined(result.finaltarget.entity)) {
    targetentity = result.finaltarget.entity;
    entitypos = targetentity.origin;
    var_564aa5b5974905d9 = function_f8350ab882cc2439(entitypos);
    distsq = distancesquared(entitypos, var_564aa5b5974905d9);

    if(distsq > self.constants.var_aeaac16f3357bcae) {
      targetentity.var_2a6f82a735950253 = 1;
      return 0;
    }

    self.var_df9d35d9b4bee654 = createactionbase("pickup", result.finaltarget, "main", "id:" + targetentity.index + " location:" + entitypos, &actionprocess, self, &function_f4caae7e8af9d32c, self.constants.var_57228f75b014a7b8, self.constants.var_daec6fd98c7cee50);
  }

  return result.finalscore;
}

function evaluateentityarray(bot, entarray, result, gamestage, var_9073e5955eaebe2c) {
  assert(isDefined(result.finalscore));
  oncontract = undefined;

  if(getdvarint(@ "hash_82bde055b11e6698", 0)) {
    oncontract = array_contains(level.questinfo.teamsonquests, bot.team);
  } else {
    oncontract = namespace_1eb3c4e0e28fac71::function_7094c7010c5e3827(bot.team);
  }

  foreach(ent in entarray) {
    if(!isDefined(ent.entity)) {
      continue;
    }

    if(ent.type == "") {
      continue;
    }

    if(function_d4454868dbb4e0ab(ent)) {
      continue;
    }

    if(ent.type == "tablet") {
      if(oncontract) {
        continue;
      }

      itemscore = function_60067bf70f45d4dd(bot, ent, gamestage);
    } else if(ent.type == "airdrop_loadout") {
      itemscore = function_4d09767d744e71e(bot, ent, var_9073e5955eaebe2c);
    } else {
      itemscore = function_dc1a77b6a8234cd(bot, ent, var_9073e5955eaebe2c);
    }

    if(!isDefined(itemscore)) {
      continue;
    }

    var_7d9a6d00a336393b = scripts\mp\gametypes\br_circle_util::gettimetilldangerforpoint(ent.entity.origin);

    if(var_7d9a6d00a336393b >= 0) {
      var_40f4b7920a0ca8a0 = function_9d1ab012058221bb(var_7d9a6d00a336393b, self.constants.var_93bcc2b99d24433f, self.constants.var_5107f0b927dad2b);
      itemscore += var_40f4b7920a0ca8a0;
    }

    itemscore += function_4e58bf49977d1bfd(ent);

    if(itemscore > result.finalscore) {
      result.finaltarget = ent;
      result.finalscore = itemscore;
    }
  }
}

function function_dc1a77b6a8234cd(bot, loot, var_9073e5955eaebe2c) {
  itemscore = 0;
  var_5732ae178f7310e6 = distance(loot.entity.origin, bot.origin);

  if(var_5732ae178f7310e6 > self.constants.var_65a3f0d7a3f96f0f) {
    return itemscore;
  }

  valuetable = self.constants.valuetable;
  var_76dabee05a567f15 = bot function_bbc2d6967287dc7(loot.entity.type, valuetable);
  var_98ac27fd131b6faf = 0;

  if(!istrue(var_76dabee05a567f15)) {
    return undefined;
  }

  var_98ac27fd131b6faf = ter_op(isDefined(valuetable.lootvalue[loot.entity.type]), valuetable.lootvalue[loot.entity.type], valuetable.typevalue[getxhash(loot.type)]);

  if(bot function_bcb0778bb33e86de(loot.entity.origin) && var_98ac27fd131b6faf > 0) {
    if(loot.type == "cache" || loot.type == "ammo_restock") {
      evaluatedistance = ter_op(function_f6be8129663916fd(loot.entity), 0, var_5732ae178f7310e6);
      itemscore = function_9d1ab012058221bb(evaluatedistance, self.constants.var_6c134b04a6e15e0f, self.constants.var_eea720f577a76b0b) + var_9073e5955eaebe2c;
    } else if(var_5732ae178f7310e6 < self.constants.var_5dcbc5ccec64f7de) {
      itemscore = var_98ac27fd131b6faf + var_9073e5955eaebe2c;
    } else if(var_5732ae178f7310e6 < self.constants.sightrange) {
      itemscore = ter_op(bot function_2f201ca20292ad12(loot.entity.origin), var_98ac27fd131b6faf + var_9073e5955eaebe2c, 0);
    }
  }

  return itemscore;
}

function function_60067bf70f45d4dd(bot, contract, gamestage) {
  itemscore = 0;

  if(bot function_bcb0778bb33e86de(contract.entity.origin)) {
    type = undefined;

    if(getdvarint(@ "hash_82bde055b11e6698", 0)) {
      type = contract.entity.tablettype;
    } else {
      type = contract.entity.tablettype.ref;
    }

    switch (type) {
      case #"hash_96e641d7fe5b1cf1":
        var_61ef9eafd8abb6be = self.constants.var_b516486de7d13311;
        break;
      case #"hash_1cc92bad632fbc15":
        var_61ef9eafd8abb6be = self.constants.var_de1c985391b99a2b;
        break;
      case #"hash_5c57b61aa79410db":
        var_61ef9eafd8abb6be = self.constants.var_e749e36fec025a10;
        break;
      case #"hash_7b0c576c4a7e4890":
        var_61ef9eafd8abb6be = self.constants.var_3f74fc9a89bd6f1e;
        break;
      case #"hash_d0eb63c46c25ef55":
        var_61ef9eafd8abb6be = self.constants.var_2ecab98395f8d2f8;
        break;
      default:
        return 0;
    }

    itemscore = function_9d1ab012058221bb(gamestage, self.constants.var_2e392955e7388247, var_61ef9eafd8abb6be);

    if(itemscore > 0) {
      var_5732ae178f7310e6 = distance(contract.entity.origin, bot.origin);
      evaluatedistance = ter_op(function_f6be8129663916fd(contract.entity), 0, var_5732ae178f7310e6);
      itemscore += function_9d1ab012058221bb(evaluatedistance, self.constants.var_7604b66fc0bf7887, self.constants.var_9ba7c398de3ab6b8);
    }
  }

  return itemscore;
}

function function_4d09767d744e71e(bot, airdrop, var_9073e5955eaebe2c) {
  itemscore = self.constants.var_c0c5b5dd018dc8cf;
  var_5732ae178f7310e6 = distance(airdrop.entity.origin, bot.origin);
  evaluatedistance = ter_op(function_f6be8129663916fd(airdrop.entity), 0, var_5732ae178f7310e6);
  itemscore += function_9d1ab012058221bb(evaluatedistance, self.constants.var_18143b1f14cc381d, self.constants.var_c82fa9468a010a2);
  itemscore += var_9073e5955eaebe2c;
  return itemscore;
}

function function_f6be8129663916fd(entity) {
  if(isDefined(self.var_16bd053d665e8c13)) {
    return (self.var_16bd053d665e8c13.entity == entity);
  }

  return false;
}

function function_2f201ca20292ad12(point) {
  var_ccbd7e93d84d42e8 = self botpredictseepoint(point);
  var_e1b57ec944a64540 = 40;

  if(isvector(var_ccbd7e93d84d42e8)) {
    return (abs(var_ccbd7e93d84d42e8[2] - point[2]) < var_e1b57ec944a64540);
  }

  return false;
}

function actionprocess(bot) {
  assert(isDefined(self.argument) && isDefined(self.argument.entity));
  target = self.argument;
  self.decision.var_16bd053d665e8c13 = target;
  var_ee2eea100343d059 = target.type == "cache";
  var_60df4d40bba49d3c = target.type == "ammo_restock";
  var_54addd2a9a7ccdf2 = target.type == "airdrop_loadout";
  var_fe2e596fd1c7fa49 = !var_ee2eea100343d059 && !var_60df4d40bba49d3c && !var_54addd2a9a7ccdf2;
  var_e6a27152696418bd = 0;
  var_a02b95b69b3e316 = 0;
  targetscope = 56;
  targetpos = undefined;

  if(var_60df4d40bba49d3c || var_54addd2a9a7ccdf2) {
    targetpos = function_f8350ab882cc2439(target.entity.origin);
  } else if(var_ee2eea100343d059) {
    targetscope = 24;
    var_90a93951e4c15e03 = 45;
    pos = target.entity.origin + anglestoleft(target.entity.angles) * var_90a93951e4c15e03;
    targetpos = function_f8350ab882cc2439(pos);
  } else {
    targetpos = target.entity.origin;
  }

  bot setscriptgoal(targetpos, targetscope);

  while(true) {
    result = bot waittill_any_in_array_or_timeout(["goal", "bad_path"], 1);

    if(result == "goal") {
      bot function_8b201bccc0aa3695(targetpos, 0.5);

      if(var_ee2eea100343d059) {
        if(!bot function_d75cf6c7882b3bc4(target.entity)) {
          bot botpressbutton("use", 0.25);
        }

        function_f519820317d400ea();
        var_be48ed4e05efe5cf = 45;
        var_60c1a9bc1584ef28 = 1.5;
        bot function_d1acad1ee42b2b2f(target.entity, var_60c1a9bc1584ef28, var_be48ed4e05efe5cf);
      } else if(var_60df4d40bba49d3c) {
        bot botpressbutton("use", 0.25);
        self.decision function_2d9fcd6970321ba(target);
      } else if(var_54addd2a9a7ccdf2) {
        if(!isDefined(target.entity)) {
          return "airdrop has been consumed";
        } else if(target.entity.inuse) {
          return "airdrop is in use";
        }

        function_f3cf203834e48c6d("<dev string:x1c>");

        wait 1.5;
        bot namespace_bc2665cbe6cf4e1f::function_5b54ecc3b227f84d();
        self.decision function_2d9fcd6970321ba(target);
      } else {
        if(var_a02b95b69b3e316 || function_a8b0c59fb4582264(target.entity)) {
          return "Target missed";
        }

        pickupresult = scripts\mp\gametypes\br_pickups::lootused(target.entity, undefined, "visible", bot, 0);

        if(!isDefined(pickupresult)) {
          return "Target missed";
        } else if(!pickupresult) {
          if(isDefined(target.entity)) {
            self.decision function_2d9fcd6970321ba(target);
            return ("Can't pick up " + target.entity.type);
          } else {
            return ("Can't pick up missed " + target.type);
          }
        }

        if(isDefined(target.entity.lootsource) && target.entity.lootsource == "cache") {
          function_f519820317d400ea();
        }
      }

      break;
    }

    if(result == "bad_path") {
      self.decision function_2d9fcd6970321ba(target);
      return result;
    }

    if(result == "timeout") {
      if(var_ee2eea100343d059) {
        if(!var_e6a27152696418bd) {
          var_e6a27152696418bd = function_a12ee73ed183cb4f(target.entity);
        }

        if(var_e6a27152696418bd && bot canseetargetposition(targetpos, self.decision.constants.sightrange)) {
          return "Cache is open";
        }

        continue;
      }

      if(var_fe2e596fd1c7fa49) {
        if(!var_a02b95b69b3e316) {
          var_a02b95b69b3e316 = function_a8b0c59fb4582264(target.entity);
        }

        if(var_a02b95b69b3e316 && bot canseetargetposition(targetpos, self.decision.constants.sightrange)) {
          return "Can't see target";
        }
      }
    }
  }
}

function function_d75cf6c7882b3bc4(lootcache) {
  currentstate = lootcache getscriptablepartstate("body", 1);

  if(!isDefined(currentstate)) {
    return 0;
  }

  switch (currentstate) {
    case #"hash_6508078488d5273a":
    case #"hash_80a322219de080cb":
    case #"hash_c8b4e464ad01036b":
      scripts\mp\gametypes\br_lootcache::lootcacheused(lootcache, "body", currentstate, self);
      return 1;
    case #"hash_33d00c02a93d1b5e":
    case #"hash_7381879eb9689156":
    case #"hash_7c3dfb169613e676":
    case #"hash_985b75d07cfeddbf":
    case #"hash_ca3f53e474155975":
    case #"hash_f31862086b1bb0a8":
      return 1;
    default:
      return 0;
  }
}

function function_f519820317d400ea() {
  if(randomfloat(1) < 0.5) {
    function_f3cf203834e48c6d("<dev string:x34>");

    var_9b9ffcd51fca002a = randomfloatrange(2.5, 5);
    wait var_9b9ffcd51fca002a;

    function_f3cf203834e48c6d("<dev string:x4b>");
  }
}

function function_a12ee73ed183cb4f(lootcache) {
  currentstate = lootcache getscriptablepartstate("body", 1);
  return isDefined(currentstate) && (currentstate == "fully_opening_unusable" || currentstate == "fully_open_unusable" || currentstate == "closed_to_fully_open_unusable");
}

function function_a8b0c59fb4582264(entity) {
  if(!isDefined(entity)) {
    return true;
  }

  var_cf94f6893f81b1af = "hidden";
  currentstate = entity getscriptablepartstate(entity.type, 1);
  return isDefined(currentstate) && currentstate == var_cf94f6893f81b1af;
}

function canseetargetposition(targetpos, sightrange) {
  var_cc838cbb6f1a700b = distancesquared(targetpos, self.origin) < squared(sightrange);
  return var_cc838cbb6f1a700b && function_2f201ca20292ad12(targetpos);
}

function function_f4caae7e8af9d32c(action) {
  action.decision.var_16bd053d665e8c13 = undefined;
}

function function_7fe87b5456bf27b8() {
  self.blacklist = [];
}

function function_2d9fcd6970321ba(loot) {
  if(isDefined(loot.entity) && function_d4454868dbb4e0ab(loot)) {
    return;
  }

  self.blacklist[self.blacklist.size] = loot;
}

function function_d4454868dbb4e0ab(loot) {
  foreach(item in self.blacklist) {
    if(loot.entity.index == item.entity.index) {
      return true;
    }
  }

  return false;
}

function function_cec7c34920151fa() {
  if(self.blacklist.size == 0) {
    return;
  }

  newlist = [];

  foreach(item in self.blacklist) {
    if(isDefined(item.entity)) {
      newlist[newlist.size] = item;
    }
  }

  self.blacklist = newlist;
}

function function_54f633f649764ea9(bot, excludeloot) {
  function_cec7c34920151fa();
  excludeentity = undefined;

  if(isDefined(excludeloot) && isDefined(excludeloot.entity)) {
    excludeentity = excludeloot.entity;
  }

  var_a8d1793197306629 = bot namespace_10ca308be68952f::getevent();
  var_a8d1793197306629 = array_randomize(var_a8d1793197306629);

  foreach(loot in var_a8d1793197306629) {
    isvalidloot = bot function_bcb0778bb33e86de(loot.entity.origin) && (!isDefined(excludeentity) || excludeentity != loot.entity) && !function_d4454868dbb4e0ab(loot);

    if(isvalidloot) {
      return loot;
    }
  }

  return undefined;
}
/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_683a55734f15d50e.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2474a362752098d2;
#using script_2a5bf5b4a00cee0d;
#using script_350cffecd05ef6cf;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5549681e1669c11a;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_74a56359b7d02ab6;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_41f5b853;

function init() {
  clientfield::register("scriptmover", "world_loot_type", 1, 8, "int");
  level.doa.var_f69d6693 = [];
  level.doa.var_2f6aa12d = [];
  function_5fd93de5("treasure chest", 1, "zombietron_treasure_chest_01", undefined, &function_650efe1c, 0);
  function_5fd93de5("golden treasure chest", 2, "zombietron_treasure_chest_02", undefined, &function_650efe1c, 0);
  function_5fd93de5("stone chest", 3, "zombietron_treasure_chest_03", undefined, &function_650efe1c, 0);
  function_5fd93de5("bronze weapon chest", 4, "zombietron_treasure_chest_small_01", undefined, &function_650efe1c, 0);
  function_5fd93de5("golden treasure chest XL", 5, "zombietron_treasure_chest_02_xl", undefined, &function_650efe1c, 1);
  function_5fd93de5("loot_basket", 6, "zombietron_loot_basket", &function_92a92219, &function_650efe1c, 0);
  function_5fd93de5("loot_crate", 12, "zombietron_loot_crate", &function_b3f8d2d5, &function_650efe1c, 0);
  function_5fd93de5("pirate chest", 5, "zombietron_pirate_chest", undefined, &function_650efe1c, 1, 0);
  function_5fd93de5("surprisebox1", 8, "zombietron_gift_box_stripe", undefined, &function_650efe1c, 1, 0, 5);
  function_5fd93de5("roforb", 9, "p7_zm_gen_apoth_corpt_engine_light_ball", undefined, &function_650efe1c, 1, 0, 6, -1);
  function_5fd93de5("trinket_box", 10, "zombietron_trinket_box", undefined, &function_650efe1c, 0, 0, 7);
  function_5fd93de5("arcade_machine1", 11, "zombietron_arcademachine", undefined, &function_7df596c3, 0, 0, 9);
  level.doa.var_b1f49ea1 = [];
  level.doa.var_4a9603d0 = [];
  function_f9bfcf6f(1, 400);
  function_f9bfcf6f(6, 20);
  function_f9bfcf6f(24, 15);
  function_f9bfcf6f(17, 15);
  function_f9bfcf6f(18, 15);
  function_f9bfcf6f(19, 15);
  function_f9bfcf6f(13, 15);
  function_f9bfcf6f(10, 15);
  function_f9bfcf6f(42, 10);
  function_f9bfcf6f(20, 10);
  function_f9bfcf6f(15, 5);
  function_f9bfcf6f(22, 5);
  function_f9bfcf6f(45, 5);
  function_f9bfcf6f(28, 5);
  function_f9bfcf6f(29, 5);
  function_f9bfcf6f(9, 4);
  function_f9bfcf6f(8, 3);
  function_f9bfcf6f(14, 1);
  function_f9bfcf6f(16, 1);
}

function function_f9bfcf6f(type, weight) {
  level.doa.var_b1f49ea1[type] = type;
  level.doa.var_4a9603d0[type] = weight;
}

function random_weighted(array, weights) {
  assert(array.size == weights.size);

  if(array.size > 0) {
    var_766a145f = 0;
    keys = getarraykeys(array);

    foreach(key in keys) {
      var_766a145f += weights[key];
    }

    var_ca23d24f = randomfloatrange(0, var_766a145f);
    var_da00fb33 = keys[0];

    for(i = 0; i < keys.size && var_ca23d24f >= 0; i++) {
      var_da00fb33 = keys[i];
      var_ca23d24f -= weights[var_da00fb33];
    }

    return array[var_da00fb33];
  }

  assert(0);
  return 0;
}

function function_60eeb02c(spawninfo) {
  self setModel(spawninfo.modelname);
  self solid();
  self disconnectpaths();
  self.modelname = spawninfo.modelname;
  self.angles = spawninfo.angles;
  self.targetname = spawninfo.targetname;
  self.script_noteworthy = spawninfo.script_noteworthy;
  self.var_d6118311 = spawninfo.var_d6118311;
  self.loottype = spawninfo.loottype;
  self.data = spawninfo.data;
  self.locked = spawninfo.locked;
  self.defname = spawninfo.defname;
  self.radius = spawninfo.radius;
  self.context = spawninfo.context;
  self.var_cbff4088 = spawninfo.var_cbff4088;
  self.var_e254c3ed = spawninfo.var_e254c3ed;
  self.spawninfo = spawninfo;
  spawninfo.script_model = self;

  if(isDefined(self.var_e254c3ed)) {
    self[[self.var_e254c3ed]]();
  }
}

function spawnlootitem(origin, angles, lootname, radius, context) {
  if(lootname === # "fate") {
    if(context != 2) {
      return;
    }

    fate = namespace_1c2a96f9::function_1324dc3b();

    if(!isDefined(fate)) {
      return;
    }

    def = {
      #modelname: fate.model, #type: 7, #data: fate, #locked: 0, #name: # "fate", #var_d6118311: 4
    };
  } else {
    def = function_9acb7d7a(lootname);
  }

  assert(isDefined(def), "<dev string:x38>");
  namespace_1e25ad94::debugmsg("Spawning Loot (" + def.modelname + ") at " + origin);
  var_a1f88ae1 = namespace_ec06fe4a::spawnmodel(origin, def.modelname);

  if(!isDefined(var_a1f88ae1)) {
    return;
  }

  initinfo = {
    #modelname: def.modelname, #angles: angles, #origin: origin, #targetname: namespace_ec06fe4a::function_3390402b(), #script_noteworthy: "world_loot", #var_d6118311: def.var_d6118311, #loottype: def.type, #data: def.data, #locked: def.locked, #defname: def.name, #radius: radius, #context: context, #var_cbff4088: def.var_cbff4088, #var_e254c3ed: def.var_e254c3ed
  };
  var_a1f88ae1 function_60eeb02c(initinfo);
  level.doa.var_b8ef1466[level.doa.var_b8ef1466.size] = var_a1f88ae1.spawninfo;
  return var_a1f88ae1;
}

function function_9acb7d7a(name) {
  foreach(item in level.doa.var_f69d6693) {
    if(item.name === name) {
      return item;
    }
  }

  return level.doa.var_2f6aa12d[randomint(level.doa.var_2f6aa12d.size)];
}

function function_dcd8be88(type) {
  foreach(item in level.doa.var_f69d6693) {
    if(item.type == type) {
      return item.var_ecdc444;
    }
  }
}

function function_dca53316(name) {
  if(isDefined(name)) {
    foreach(item in level.doa.var_f69d6693) {
      if(item.name === name) {
        return item.modelname;
      }
    }
  }

  item = level.doa.var_f69d6693[randomint(level.doa.var_f69d6693.size)];
  return item.modelname;
}

function function_2732d95(name) {
  foreach(item in level.doa.var_f69d6693) {
    if(item.name === name) {
      return item.type;
    }
  }
}

function function_aeb57dc6(name) {
  foreach(item in level.doa.var_f69d6693) {
    if(item.modelname === name) {
      return item.type;
    }
  }
}

function function_dea1324e(type) {
  foreach(item in level.doa.var_f69d6693) {
    if(item.type === type) {
      return item.locked;
    }
  }
}

function function_5fd93de5(name, type, modelname, var_e254c3ed, var_ecdc444, locked = 0, var_641be55e = 1, var_5653e2ee = 3, var_950bcf12 = 1) {
  s_loot = spawnStruct();
  s_loot.name = name;
  s_loot.type = type;
  s_loot.locked = locked;
  s_loot.modelname = modelname;
  s_loot.var_e254c3ed = var_e254c3ed;
  s_loot.var_ecdc444 = var_ecdc444;
  s_loot.var_d6118311 = var_5653e2ee;
  s_loot.var_cbff4088 = var_950bcf12;
  level.doa.var_f69d6693[level.doa.var_f69d6693.size] = s_loot;

  if(var_641be55e) {
    level.doa.var_2f6aa12d[level.doa.var_2f6aa12d.size] = s_loot;
  }
}

function function_4d27013d(item) {
  namespace_1e25ad94::debugmsg("Loot Opened");
  var_2f0b512f = function_dcd8be88(item.loottype);
  assert(isDefined(var_2f0b512f), "<dev string:x53>");
  level thread[[var_2f0b512f]](item);
}

function function_7df596c3(item) {
  switch (item.loottype) {
    case 11:
      rooms = array("slideways", "slideways2", "slideways3", "slideways4", "slideways5");
      room = namespace_5a917022::function_c8892b0f(rooms[randomint(rooms.size)]);
      var_4200bfbf = [];
      var_4200bfbf[0] = {
        #origin: item.origin, #angles: item.angles + (0, 270, 0)
      };
      var_4200bfbf[1] = {
        #origin: var_4200bfbf[0].origin + (30, 0, 0), #angles: var_4200bfbf[0].angles
      };
      var_4200bfbf[2] = {
        #origin: var_4200bfbf[0].origin + (-30, 0, 0), #angles: var_4200bfbf[0].angles
      };
      var_4200bfbf[3] = {
        #origin: var_4200bfbf[0].origin + (0, 30, 0), #angles: var_4200bfbf[0].angles
      };
      idx = 0;

      foreach(player in getplayers()) {
        player setorigin(var_4200bfbf[idx].origin);
        player setplayerangles(var_4200bfbf[idx].angles);
        idx++;
      }

      level thread namespace_5a917022::function_a9f78bf(var_4200bfbf, room);
      level waittill(#"hash_1b322de3d2e3e781");
      break;
    default:
      assert(0);
      break;
  }
}

function function_650efe1c(item) {
  switch (item.loottype) {
    case 1:
      namespace_1e25ad94::debugmsg("Loot Opened - Large Bronze");
      break;
    case 2:
      namespace_1e25ad94::debugmsg("Loot Opened - Large Golden");
      break;
    case 3:
      namespace_1e25ad94::debugmsg("Loot Opened - Large Stone");
      break;
    case 4:
      namespace_1e25ad94::debugmsg("Loot Opened - Medium Bronze");
      break;
    case 5:
      namespace_1e25ad94::debugmsg("Loot Opened - XL Golden");
      break;
    case 6:
      namespace_1e25ad94::debugmsg("Loot Opened - Basket");
      break;
    case 12:
      namespace_1e25ad94::debugmsg("Loot Opened - Crate");
      break;
    case 8:
      namespace_1e25ad94::debugmsg("Loot Opened - Gift Box");
      break;
    case 9:
      namespace_1e25ad94::debugmsg("Loot Opened - ROF ORB");
      break;
    case 10:
      namespace_1e25ad94::debugmsg("Loot Opened - TRINKET BOX");
      break;
  }

  level thread function_389aad25(item, item.loottype);
}

function function_389aad25(item, type) {
  item endon(#"death");
  item namespace_e32bb68::function_3a59ec34("zmb_box_interact");
  original = item.origin;
  var_3e2d48b2 = "glow_white";
  reward = 1;
  rare = 0;
  var_9e20508c = 10;
  radius = isDefined(item.radius) ? item.radius : 128;
  scenedef = # "hash_7a2190c40fdc3bbc";

  switch (type) {
    case 1:
      reward = "treasure";
      break;
    case 2:
      var_3e2d48b2 = "glow_yellow";
      fxtrail = "player_trail_yellow";
      reward = "treasure_horde";
      scenedef = # "hash_30c46dd666dd7707";
      var_9e20508c = 16;
      break;
    case 3:
      reward = "items";
      break;
    case 4:
      reward = "weapon_cache";
      break;
    case 5:
      var_3e2d48b2 = "glow_yellow";
      fxtrail = "player_trail_yellow";
      reward = "treasure_horde_plus";
      scenedef = # "hash_78fd0527319f0425";
      var_9e20508c = 64;
      var_2468c36a = "fireworks";
      break;
    case 10:
      var_3e2d48b2 = "glow_yellow";
      fxtrail = "player_trail_yellow";
      scenedef = # "hash_7a2190c40fdc3bbc";
      var_9e20508c = 2;
      roll = randomint(100);

      if(roll > 96) {
        reward = "extraLife";
      } else if(roll > 75) {
        reward = "nuke";
      } else if(roll > 50) {
        reward = "boost";
      } else {
        reward = "chickens";
        var_9e20508c = 5;
      }

      break;
    case 8:
      var_3e2d48b2 = "glow_yellow";
      fxtrail = "player_trail_yellow";
      scenedef = # "hash_7a2190c40fdc3bbc";
      reward = "extraLife";
      var_9e20508c = 2;
      var_2468c36a = "fireworks";
      break;
    case 6:
      item dodamage(item.health, item.origin);
      return;
    case 12:
      item dodamage(item.health, item.origin);
      return;
    case 9:
      var_3e2d48b2 = "glow_blue";
      fxtrail = "player_trail_blue";
      scenedef = # "hash_78fd0527319f0425";
      var_2468c36a = "lightningStrike";
      nodelete = 1;
      level.doa.var_2e2d85d4 = 1;
      reward = undefined;
      break;
  }

  item namespace_83eb6304::function_3ecfde67(var_3e2d48b2);

  if(isDefined(fxtrail)) {
    item namespace_83eb6304::function_3ecfde67(fxtrail);
  }

  item notsolid();
  item scene::play(scenedef, item);
  item waittill(#"scenes_done");

  if(isDefined(var_2468c36a)) {
    item namespace_83eb6304::function_3ecfde67(var_2468c36a);
  }

  item namespace_e32bb68::function_3a59ec34("zmb_chest_explode");

  if(!is_true(nodelete)) {
    item namespace_ec06fe4a::function_8c808737();
    item notsolid();
  }

  item namespace_83eb6304::turnofffx(var_3e2d48b2);

  if(isDefined(fxtrail)) {
    item namespace_83eb6304::turnofffx(fxtrail);
  }

  if(isDefined(reward)) {
    if(isDefined(item.target)) {
      targets = struct::get_array(item.target, "targetname");

      if(targets.size > 0) {
        var_9e20508c = int(var_9e20508c / targets.size);

        foreach(target in targets) {
          function_d2c582ec(target.origin, var_9e20508c, radius, reward);
        }
      }
    } else {
      function_d2c582ec(item.origin, var_9e20508c, radius, reward);
    }
  }

  item connectpaths();
  wait 1;

  if(!is_true(nodelete)) {
    item delete();
  }
}

function function_d2c582ec(origin, var_9e20508c, radius, reward, flag) {
  switch (flag) {
    case # "treasure_horde_plus":
      namespace_dfc652ee::function_d06cbfe8(var_9e20508c, radius >> 1, reward);

      if(randomint(100) < 20) {
        namespace_dfc652ee::function_ad7ac41b(var_9e20508c, 1, 32, 16, 1);
      }

      if(randomint(100) < 10) {
        namespace_dfc652ee::function_ad7ac41b(var_9e20508c, 1, 32, 14, 1);
      }
    case # "treasure_horde":
      namespace_dfc652ee::function_68442ee7(var_9e20508c, radius, reward, 1);
      namespace_dfc652ee::function_d06cbfe8(var_9e20508c, radius >> 2, reward);
    case # "treasure":
      namespace_dfc652ee::function_68442ee7(var_9e20508c, radius, reward);
      break;
    case # "extralife":
      namespace_dfc652ee::function_ad7ac41b(var_9e20508c, radius, 32, 16, 1);
      break;
    case # "boost":
      namespace_dfc652ee::function_ad7ac41b(var_9e20508c, radius, 32, 9, 1);
      break;
    case # "nuke":
      namespace_dfc652ee::function_ad7ac41b(var_9e20508c, radius, 32, 8, 1);
      break;
    case # "chickens":
      namespace_dfc652ee::function_ad7ac41b(var_9e20508c, radius, 32, 15, 1);
      break;
    case # "items":
      while(radius) {
        radius--;
        function_e2b14b6(var_9e20508c + (randomintrange(-60, 60), randomintrange(-60, 60), 0), (0, 0, 0));
      }

      break;
    case # "weapon_cache":
      var_d7d0ebdd = namespace_dfc652ee::function_57160cba(6);
      namespace_dfc652ee::itemspawn(var_d7d0ebdd, var_9e20508c + (randomintrange(-60, 60), randomintrange(-60, 60), 0), undefined, undefined, 1);
      namespace_dfc652ee::itemspawn(var_d7d0ebdd, var_9e20508c + (randomintrange(-60, 60), randomintrange(-60, 60), 0), undefined, undefined, 1);
      namespace_dfc652ee::itemspawn(var_d7d0ebdd, var_9e20508c + (randomintrange(-60, 60), randomintrange(-60, 60), 0), undefined, undefined, 1);
      namespace_dfc652ee::itemspawn(var_d7d0ebdd, var_9e20508c + (randomintrange(-60, 60), randomintrange(-60, 60), 0), undefined, undefined, 1);
      namespace_dfc652ee::itemspawn(var_d7d0ebdd, var_9e20508c + (randomintrange(-60, 60), randomintrange(-60, 60), 0), undefined, undefined, 1);
      namespace_dfc652ee::itemspawn(var_d7d0ebdd, var_9e20508c + (randomintrange(-60, 60), randomintrange(-60, 60), 0), undefined, undefined, 1);
      namespace_dfc652ee::itemspawn(var_d7d0ebdd, var_9e20508c + (randomintrange(-60, 60), randomintrange(-60, 60), 0), undefined, undefined, 1);
      namespace_dfc652ee::itemspawn(var_d7d0ebdd, var_9e20508c + (randomintrange(-60, 60), randomintrange(-60, 60), 0), undefined, undefined, 1);
      namespace_dfc652ee::itemspawn(var_d7d0ebdd, var_9e20508c + (randomintrange(-60, 60), randomintrange(-60, 60), 0), undefined, undefined, 1);
      break;
    default:
      namespace_dfc652ee::function_ad7ac41b(var_9e20508c, radius, reward, flag, 1);
      break;
  }
}

function function_92a92219() {
  self.takedamage = 1;
  self.health = 575;
  self thread function_8534e7be();
}

function function_b3f8d2d5(def) {
  function_92a92219();
  self.crate = 1;
}

function function_8534e7be() {
  self endon(#"death");

  while(self.health > 0) {
    result = self waittill(#"damage");

    if(result.amount > self.health) {
      if(isDefined(self.spawninfo)) {
        self.spawninfo.activated = 1;
        arrayremovevalue(level.doa.var_b8ef1466, self.spawninfo);
        level.doa.var_c793b1bb[level.doa.var_c793b1bb.size] = self.spawninfo;
      }

      self.health += result.amount;
      self thread basketexplo(is_true(self.crate));
      return;
    }
  }
}

function function_e2b14b6(origin, angles) {
  type = random_weighted(level.doa.var_b1f49ea1, level.doa.var_4a9603d0);

  if(!isDefined(type) || type == 0) {
    return;
  }

  while(!isDefined(type) || type == 42 && !isDefined(level.doa.var_182fb75a)) {
    waitframe(1);
    type = random_weighted(level.doa.var_b1f49ea1, level.doa.var_4a9603d0);
  }

  def = namespace_dfc652ee::function_57160cba(type);

  if(type == 13) {
    namespace_dfc652ee::function_b8f6a8cd(def, origin, 1, 1, randomfloatrange(0.25, 1.25));
    return;
  }

  namespace_dfc652ee::itemspawn(def, origin, angles, undefined, 1);
}

function basketexplo(var_7ef2dd9c = 0) {
  origin = self.origin;
  angles = self.angles;
  self namespace_83eb6304::function_3ecfde67("basketExplo");
  self namespace_e32bb68::function_3a59ec34("zmb_basket_explode");

  if(isDefined(self.owner)) {
    self.owner.activated = 1;
  }

  wait 0.15;

  if(var_7ef2dd9c) {
    function_e2b14b6(origin + (randomintrange(-12, 12), randomintrange(-12, 12), randomint(10)), angles);
    function_e2b14b6(origin + (randomintrange(-12, 12), randomintrange(-12, 12), randomint(10)), angles);
    function_e2b14b6(origin + (randomintrange(-12, 12), randomintrange(-12, 12), randomint(10)), angles);
  } else {
    function_e2b14b6(origin, angles);
  }

  if(isDefined(self)) {
    self namespace_ec06fe4a::function_8c808737();
    self connectpaths();
  }

  wait 0.2;

  if(isDefined(self)) {
    self delete();
  }
}
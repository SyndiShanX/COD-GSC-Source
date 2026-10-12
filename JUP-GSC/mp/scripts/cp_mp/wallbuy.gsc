/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\wallbuy.gsc
***********************************************/

#using script_443d99fe707f1d9f;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\content_manager;
#using scripts\cp_mp\currency;
#using scripts\cp_mp\interaction;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\weapons;
#namespace wallbuy;

function init_wallbuy(var_9280820d730cbb33) {
  flag_init("wallbuy_ready");
  level.wallbuybundle = getscriptbundle("wallbuy:" + level.gamemodebundle.wallbuybundle);
  scripts\cp_mp\content_manager::register_script("wallbuy", &function_d7cd77868ae1e1cf);
  level.var_c8e039bf171c3584 = default_to(level.weaponmetadata["wallbuy_settings"].var_13d48225bc483f59, "essence");
  level.wallbuy_cost = default_to(level.weaponmetadata["wallbuy_settings"].var_2e57b9b53a463b3b, 1000);
  level.var_9280820d730cbb33 = [];
  level function_e2b981c1ea3f16bb(var_9280820d730cbb33);

  level thread function_3b908ba6fc40daf4();

  level._effect["vfx_wallbuy_reveal_xlg"] = loadfx(default_to(level.wallbuybundle.var_2a2ce972227ade52, "vfx/jup/ob/gameplay/zm/vfx_wallbuy_reveal_xlg.vfx"));

  if(!istrue(level.gamemodebundle.var_7746f48b0ed07126)) {
    level thread function_fc548d70e78f7672();
  } else {
    level callback::add("ob_content_process_create_script", &function_817c8799aa3c100b);
  }

  level callback::add("on_round_end", &on_round_end);
}

function function_3b908ba6fc40daf4() {
  function_6e7290c8ee4f558b("<dev string:x1c>");
  function_a9a864379a098ad6("<dev string:x2c>", "<dev string:x46>", &function_b5a3a7840d51404a, 0);
  function_fe953f000498048f();
}

function function_fc548d70e78f7672() {
  level endon("game_ended");
  waittillframeend();
  wait 1;
  level scripts\engine\utility::flag_wait("StartGameTypeCallbackFinished");
  mapdestinations = getStructArray("content_destination", "variantname");

  if(isDefined(mapdestinations) && mapdestinations.size > 0) {
    foreach(destination in mapdestinations) {
      level function_ebf02b0dd91b2553(destination);
    }
  }

  flag_set("wallbuy_ready");
}

function function_ebf02b0dd91b2553(destination) {
  foreach(location in destination.locations) {
    wallbuy = location.instances["wallbuy"];

    if(isDefined(wallbuy)) {
      foreach(instance in wallbuy.versions) {
        scripts\cp_mp\content_manager::spawn_instance(instance);
      }
    }
  }
}

function function_817c8799aa3c100b(sparams) {
  level.ob_wallbuys = [];
  var_3c3122af5c02bd7 = getStructArray("content_struct", "variantname");
  var_fa6d1b1ae29d0e32 = [];

  foreach(struct in var_3c3122af5c02bd7) {
    if(!isDefined(struct.var_2dda78d4f81fa52f) && isDefined(struct.content_key) && struct.content_key == "wallbuy_spawn") {
      var_fa6d1b1ae29d0e32[var_fa6d1b1ae29d0e32.size] = struct;
    }
  }

  if(isDefined(level.var_c383b967aa7e551b)) {
    var_fa6d1b1ae29d0e32 = [[level.var_c383b967aa7e551b]]("wallbuy", var_fa6d1b1ae29d0e32);
  }

  foreach(struct in var_fa6d1b1ae29d0e32) {
    wallbuyinstance = function_502812469b62f7e9(struct);
    level.ob_wallbuys = array_add(level.ob_wallbuys, wallbuyinstance);
  }

  callback::callback("ob_wallbuys_create_script_done");
  flag_set("wallbuy_ready");
}

function function_d7cd77868ae1e1cf(struct) {
  assert(isstruct(struct), "<dev string:x60>");

  if(isDefined(level.var_2a4098e63ea03444)) {
    return;
  }

  spawn_points = struct.contentgroups["wallbuy_spawn"];

  if(isDefined(spawn_points)) {
    foreach(point in spawn_points) {
      point function_502812469b62f7e9(point, undefined);
    }
  }
}

function function_e2b981c1ea3f16bb(var_9280820d730cbb33) {
  if(isDefined(level.weaponmetadata)) {
    var_9280820d730cbb33 = [];

    foreach(str_weapon_name, s_weapon in level.weaponmetadata) {
      if(isstruct(s_weapon) && isDefined(s_weapon.var_3f8c2b14fee7c570)) {
        var_9280820d730cbb33[str_weapon_name] = s_weapon;
      }
    }
  }

  if(!isDefined(var_9280820d730cbb33)) {
    assertmsg("<dev string:x7e>");
  }

  level.var_9280820d730cbb33 = var_9280820d730cbb33;
}

function function_81deca73d6175a9f(point, forcedregion) {
  defaultweapon = "ob_jup_item_weapon_ar_bromeo805";
  regiondifficulty = "difficulty_undefined";

  if(!isDefined(forcedregion)) {
    if(isfunction(level.var_8241e0d86017df29)) {
      regiondifficulty = [[level.var_8241e0d86017df29]](point);
    }
  } else {
    regiondifficulty = forcedregion;
  }

  if(regiondifficulty != "difficulty_undefined" && isDefined(level.wallbuybundle.var_cdf4932cd16b6e4a)) {
    regionweaponlist = 0;

    switch (regiondifficulty) {
      case #"hash_7bb2cd766703d463":
        regionweaponlist = level.wallbuybundle.var_ed65d59790f580ff;
        break;
      case #"hash_af83e47edfa8900a":
        regionweaponlist = level.wallbuybundle.var_418e7db783eb7192;
        break;
      case #"hash_5343b465e56ec9a4":
        regionweaponlist = level.wallbuybundle.var_54091de8661b6114;
        break;
      default:
        regionweaponlist = level.wallbuybundle.var_54091de8661b6114;
        break;
    }

    if(isDefined(regionweaponlist)) {
      var_d2b6ab469c785a9c = function_bc2f4857c90f5344(regionweaponlist, 1);
      var_50c7ac5966675b5f = getscriptbundle("itemspawnentry:" + var_d2b6ab469c785a9c[0]);

      if(isDefined(var_50c7ac5966675b5f) && isDefined(var_50c7ac5966675b5f.baseweapon)) {
        return var_50c7ac5966675b5f.baseweapon;
      }

      return defaultweapon;
    }
  }

  println("<dev string:xa2>");
  return defaultweapon;
}

function function_17f886f2f83d4aee(structspawn, weapon_name) {
  difficulty = undefined;

  switch (weapon_name) {
    case #"hash_b2e10c40219f4a4e":
      return [weapon_name, 1];
    case #"hash_effd2298700f0b22":
      return [weapon_name, 1, "difficulty_easy"];
    case #"hash_b2671eb78c100817":
      return [weapon_name, 1, "difficulty_normal"];
    case #"hash_b0f23a91ee977869":
      return [weapon_name, 1, "difficulty_hard"];
  }

  return [weapon_name, 0];
}

function function_8bcac17d9bd3492b(structspawn, weapon_name) {
  weaponcheck = function_17f886f2f83d4aee(structspawn, weapon_name);
  weapon_name = weaponcheck[0];
  var_60b4527dfd61e530 = weaponcheck[1];
  region_difficulty = weaponcheck[2];

  if(var_60b4527dfd61e530) {
    weapon_name = function_81deca73d6175a9f(structspawn.origin, region_difficulty);
  }

  return weapon_name;
}

function function_502812469b62f7e9(structspawn, forcedrarity) {
  weapon_name = structspawn.script_noteworthy;
  weapon_name = function_8bcac17d9bd3492b(structspawn, weapon_name);

  if(!isDefined(weapon_name)) {
    assert("<dev string:xf1>");
  }

  weapon = makeweapon(weapon_name);
  weapon_root_name = weapon.var_9d7facbe889e667c;
  scriptablename = function_5075f6a4731236e6(weapon_root_name);

  if(isDefined(scriptablename)) {
    rarity = structspawn function_832a1fa43c4f3c7a();

    if(isDefined(forcedrarity)) {
      rarity = forcedrarity;
    }

    wallbuy_cost = function_86989ab07942c980(weapon_root_name, rarity);
    wallbuy_weapon = function_ad4352ac1dfd7c59(weapon_root_name);
    wallbuy_item = function_3683d3c5ee60fb1e(weapon_root_name);
    var_2dda78d4f81fa52f = spawnscriptable(scriptablename, structspawn.origin, structspawn.angles);

    switch (rarity) {
      case #"hash_883ff07272b4f9c":
        var_2dda78d4f81fa52f setscriptablepartstate("wallbuy", "green");
        break;
      case #"hash_778bb52ecd08072d":
        var_2dda78d4f81fa52f setscriptablepartstate("wallbuy", "blue");
        break;
      case #"hash_598a30e44f53045f":
        var_2dda78d4f81fa52f setscriptablepartstate("wallbuy", "purple");
        break;
      case #"hash_35bb3bd014c77f4b":
        var_2dda78d4f81fa52f setscriptablepartstate("wallbuy", "orange");
        break;
      default:
        var_2dda78d4f81fa52f setscriptablepartstate("wallbuy", "base");
        break;
    }

    var_2dda78d4f81fa52f = scripts\cp_mp\interaction::function_32645103f7520635(var_2dda78d4f81fa52f, &function_6a2e5e2579f83b94);
    var_2dda78d4f81fa52f scripts\cp_mp\interaction::function_9a0883b5a0999dac();
    var_2dda78d4f81fa52f scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_46baa6f0b88523d2);
    var_2dda78d4f81fa52f.cost = wallbuy_cost;
    var_2dda78d4f81fa52f.weapon = wallbuy_weapon;
    var_2dda78d4f81fa52f.weapon_name = weapon_name;
    var_2dda78d4f81fa52f.rarity = rarity;
    var_2dda78d4f81fa52f.scriptable_name = scriptablename;
    var_2dda78d4f81fa52f.itementry = wallbuy_item;
    var_2dda78d4f81fa52f.weapon_root_name = weapon_root_name;
    structspawn.var_2dda78d4f81fa52f = var_2dda78d4f81fa52f;
    return structspawn;
  }
}

function function_46baa6f0b88523d2(usable, player) {
  if(istrue(player.var_214d8a7c520784a9)) {
    return {
      #string: &"", #type: "HINT_NOBUTTON"};
  }

  if(istrue(player.interactions_disabled)) {
    return {
      #string: &"", #type: "HINT_NOBUTTON"};
  }

  if(isweapon(player.tertiaryweaponobj) && player getcurrentweapon() == player.tertiaryweaponobj) {
    return {
      #string: &"SHARED_HINTSTRINGS/WALLBUY_HINT_TERTIARY_DISABLED", #type: "HINT_NOBUTTON"};
  }

  theweapon = usable.weapon;
  theweapon = makeweapon(theweapon);
  theweapon = theweapon.displayname;
  thecost = usable.cost;
  therarity = usable.rarity;
  playercurrency = player currency::function_15975e20bbd2c824("essence");

  if(playercurrency < thecost) {
    switch (therarity) {
      case #"hash_1393412d7401c646":
        return {
          #params: [thecost, theweapon], #string: &"SHARED_HINTSTRINGS/WALLBUY_HINT_WHITE_ESSENCE_NOT_ENOUGH", #type: "HINT_BUTTON"};
      case #"hash_883ff07272b4f9c":
        return {
          #params: [thecost, theweapon], #string: &"SHARED_HINTSTRINGS/WALLBUY_HINT_GREEN_ESSENCE_NOT_ENOUGH", #type: "HINT_BUTTON"};
      case #"hash_778bb52ecd08072d":
        return {
          #params: [thecost, theweapon], #string: &"SHARED_HINTSTRINGS/WALLBUY_HINT_BLUE_ESSENCE_NOT_ENOUGH", #type: "HINT_BUTTON"};
      case #"hash_598a30e44f53045f":
        return {
          #params: [thecost, theweapon], #string: &"SHARED_HINTSTRINGS/WALLBUY_HINT_PURPLE_ESSENCE_NOT_ENOUGH", #type: "HINT_BUTTON"};
      case #"hash_35bb3bd014c77f4b":
        return {
          #params: [thecost, theweapon], #string: &"SHARED_HINTSTRINGS/WALLBUY_HINT_ORANGE_ESSENCE_NOT_ENOUGH", #type: "HINT_BUTTON"};
    }
  } else {
    switch (therarity) {
      case #"hash_1393412d7401c646":
        return {
          #params: [thecost, theweapon], #string: &"SHARED_HINTSTRINGS/WALLBUY_HINT_WHITE_ESSENCE", #type: "HINT_BUTTON"};
      case #"hash_883ff07272b4f9c":
        return {
          #params: [thecost, theweapon], #string: &"SHARED_HINTSTRINGS/WALLBUY_HINT_GREEN_ESSENCE", #type: "HINT_BUTTON"};
      case #"hash_778bb52ecd08072d":
        return {
          #params: [thecost, theweapon], #string: &"SHARED_HINTSTRINGS/WALLBUY_HINT_BLUE_ESSENCE", #type: "HINT_BUTTON"};
      case #"hash_598a30e44f53045f":
        return {
          #params: [thecost, theweapon], #string: &"SHARED_HINTSTRINGS/WALLBUY_HINT_PURPLE_ESSENCE", #type: "HINT_BUTTON"};
      case #"hash_35bb3bd014c77f4b":
        return {
          #params: [thecost, theweapon], #string: &"SHARED_HINTSTRINGS/WALLBUY_HINT_ORANGE_ESSENCE", #type: "HINT_BUTTON"};
    }
  }

  return {
    #params: [thecost, theweapon], #string: &"SHARED_HINTSTRINGS/WALLBUY_HINT_WHITE_ESSENCE", #type: "HINT_BUTTON"};
}

function function_832a1fa43c4f3c7a() {
  if(isDefined(self.script_string) && self.script_string != "") {
    return self.script_string;
  }

  rarity = "white";
  return rarity;
}

function function_3683d3c5ee60fb1e(weapon_name) {
  if(isDefined(weapon_name) && isDefined(level.var_9280820d730cbb33[weapon_name]) && isDefined(level.var_9280820d730cbb33[weapon_name].itementry)) {
    return level.var_9280820d730cbb33[weapon_name].itementry;
  }
}

function function_ad4352ac1dfd7c59(weapon_name) {
  if(isDefined(weapon_name) && isDefined(level.var_9280820d730cbb33[weapon_name]) && isDefined(level.var_9280820d730cbb33[weapon_name].weapon)) {
    return level.var_9280820d730cbb33[weapon_name].weapon;
  }
}

function function_5075f6a4731236e6(weapon_name) {
  if(isDefined(weapon_name) && !isDefined(level.var_9280820d730cbb33[weapon_name])) {
    println("<dev string:x125>" + getxhashsourcename(weapon_name) + "<dev string:x13a>");
  }

  if(isDefined(weapon_name) && isDefined(level.var_9280820d730cbb33[weapon_name]) && isDefined(level.var_9280820d730cbb33[weapon_name].var_3f8c2b14fee7c570)) {
    return level.var_9280820d730cbb33[weapon_name].var_3f8c2b14fee7c570;
  }
}

function function_86989ab07942c980(weapon_root_name, rarity) {
  cost = level.wallbuy_cost;

  if(isDefined(level.var_9280820d730cbb33) && isDefined(level.var_9280820d730cbb33[weapon_root_name])) {
    if(isDefined(level.var_9280820d730cbb33[weapon_root_name].var_814d114cd3786973)) {
      cost = level.var_9280820d730cbb33[weapon_root_name].var_814d114cd3786973;
    }

    switch (rarity) {
      case #"hash_883ff07272b4f9c":
        if(isDefined(level.var_9280820d730cbb33[weapon_root_name].var_32c129d7629dfd37)) {
          cost = level.var_9280820d730cbb33[weapon_root_name].var_32c129d7629dfd37;
        } else {
          cost += 500;
        }

        break;
      case #"hash_778bb52ecd08072d":
        if(isDefined(level.var_9280820d730cbb33[weapon_root_name].var_2ad1686ad07dbc22)) {
          cost = level.var_9280820d730cbb33[weapon_root_name].var_2ad1686ad07dbc22;
        } else {
          cost += 1500;
        }

        break;
      case #"hash_598a30e44f53045f":
        if(isDefined(level.var_9280820d730cbb33[weapon_root_name].var_bc634e28ac5febd8)) {
          cost = level.var_9280820d730cbb33[weapon_root_name].var_bc634e28ac5febd8;
        } else {
          cost += 2500;
        }

        break;
      case #"hash_35bb3bd014c77f4b":
        if(isDefined(level.var_9280820d730cbb33[weapon_root_name].var_422e0abbedb57cc8)) {
          cost = level.var_9280820d730cbb33[weapon_root_name].var_422e0abbedb57cc8;
        } else {
          cost += 3500;
        }

        break;
      default:
        if(isDefined(level.var_9280820d730cbb33[weapon_root_name].var_814d114cd3786973)) {
          cost = level.var_9280820d730cbb33[weapon_root_name].var_814d114cd3786973;
        } else {
          cost = 1000;
        }

        break;
    }
  } else {
    switch (rarity) {
      case #"hash_883ff07272b4f9c":
        cost += 500;
        break;
      case #"hash_778bb52ecd08072d":
        cost += 1500;
        break;
      case #"hash_598a30e44f53045f":
        cost += 2500;
        break;
      case #"hash_35bb3bd014c77f4b":
        cost += 3500;
        break;
      default:
        cost = 1000;
        break;
    }
  }

  return cost;
}

function function_6a2e5e2579f83b94(player) {
  if(!isPlayer(player) || !isDefined(self.cost) || !isDefined(self.weapon_name)) {
    assert("<dev string:x163>");
    return;
  }

  if(istrue(player.var_214d8a7c520784a9)) {
    return;
  }

  if(istrue(player.interactions_disabled)) {
    return;
  }

  if(isweapon(player.tertiaryweaponobj) && player getcurrentweapon() == player.tertiaryweaponobj) {
    return;
  }

  if(player attempt_purchase(level.var_c8e039bf171c3584, self.cost, undefined, undefined, #"wallbuy", self.weapon_name)) {
    if(!isDefined(self.gunmodel)) {
      gunmodel = function_c26e1057f3dfbc52(self.weapon_name, self.origin, (self.angles[0], self.angles[1] - 180, self.angles[2]));
      self.gunmodel = gunmodel;
      var_a49f3378e7b03e7b = (0, -5, 0);
      var_ce61d73cfdee619d = gunmodel localtoworldcoords(var_a49f3378e7b03e7b);
      gunmodel notsolid();
      var_5ce5bf640ea164d = (0, 0.5, 0);
      var_d993a04208646bdc = 1;
      targetposworld = gunmodel localtoworldcoords(var_5ce5bf640ea164d);
      gunmodel.origin = var_ce61d73cfdee619d;
      gunmodel moveTo(targetposworld, var_d993a04208646bdc);
    }

    if(isDefined(self.itementry)) {
      item_entry = self.itementry;

      if(isDefined(self.rarity) && self.rarity != "white") {
        item_entry = item_entry + "_" + self.rarity;
      }

      item_bundle = getscriptbundle("itemspawnentry:" + item_entry);
      item_scriptable = item_bundle.scriptable;
      fakeitem = spawnStruct();
      fakeitem.weaponobj = namespace_b4f2af6fa775d9b::function_777497d9d98fa0b8(item_bundle);
      clipammo = 0;
      stockammo = 0;

      if(isDefined(fakeitem.weaponobj)) {
        clipammo = weaponclipsize(fakeitem.weaponobj);
        stockammo = weaponmaxammo(fakeitem.weaponobj);
      } else {
        clipammo = weaponclipsize(self.weapon);
        stockammo = weaponmaxammo(self.weapon);
      }

      fakeitem.count = function_7209c8cd4b2e3afd(clipammo);
      fakeitem.weaponstockammo = stockammo;
      weapontogive = player function_7f6f62ba8dfd0da0(item_bundle, fakeitem);

      if(isarray(weapontogive) && isDefined(weapontogive[1]) && isweapon(weapontogive[1])) {
        weapontogive = weapontogive[1];
      }
    } else {
      if(getdvarint(@ "hash_b56cc9f1a82d6fd1")) {
        num_attachments = function_7fa5860a8e414317(self.rarity);
        weapontogive = scripts\mp\weapons::function_71dc088dc384ef8d(self.weapon_name, num_attachments, 1);
      } else {
        weapontogive = scripts\cp_mp\weapon::buildweapon(self.weapon_name);
      }

      player.droppeddeathweapon = undefined;
      player scripts\mp\weapons::dropweaponfordeath(undefined, "");
      player.droppeddeathweapon = undefined;
      player giveweapon(weapontogive);
      player setweaponammoclip(weapontogive, weaponclipsize(weapontogive));
      player setweaponammostock(weapontogive, weaponmaxammo(weapontogive));
      player switchtoweaponimmediate(weapontogive);
    }

    playsoundatpos(self.origin, "evt_zm_core_wallbuy_purchase");
    params = spawnStruct();
    params.objweapon = weapontogive;
    params.cost = self.cost;
    params.rarity = self.rarity;
    params.lootid = function_2c836ad05e5f634c(item_bundle.ref);
    player callback::callback("wallbuy_purchase", params);
  }
}

function function_7fa5860a8e414317(rarity) {
  num_attachments = 0;

  switch (rarity) {
    case #"hash_1393412d7401c646":
      num_attachments = 1;
      break;
    case #"hash_883ff07272b4f9c":
      num_attachments = 2;
      break;
    case #"hash_778bb52ecd08072d":
      num_attachments = 3;
      break;
    case #"hash_598a30e44f53045f":
      num_attachments = 4;
      break;
    case #"hash_35bb3bd014c77f4b":
      num_attachments = 5;
      break;
  }

  return num_attachments;
}

function function_b5a3a7840d51404a() {
  foreach(instance in level.contentmanager.spawnedinstances["<dev string:x1bc>"]) {
    foreach(wallbuy_spawn in instance.contentgroups["<dev string:x1c7>"]) {
      if(isDefined(wallbuy_spawn.var_2dda78d4f81fa52f)) {
        nextrarity = "<dev string:x1d8>";

        if(isDefined(wallbuy_spawn.var_2dda78d4f81fa52f.rarity)) {
          switch (wallbuy_spawn.var_2dda78d4f81fa52f.rarity) {
            case #"hash_1393412d7401c646":
              nextrarity = "<dev string:x1eb>";
              break;
            case #"hash_883ff07272b4f9c":
              nextrarity = "<dev string:x1f4>";
              break;
            case #"hash_778bb52ecd08072d":
              nextrarity = "<dev string:x1fc>";
              break;
            case #"hash_598a30e44f53045f":
              nextrarity = "<dev string:x1d8>";
              break;
            case #"hash_35bb3bd014c77f4b":
              nextrarity = "<dev string:x1d8>";
              break;
          }
        }

        wallbuy_spawn function_e898734a6a951c57(wallbuy_spawn, nextrarity);
        waitframe();
      }
    }
  }
}

function function_e898734a6a951c57(structspawn, rarity) {
  assert(isDefined(structspawn.var_2dda78d4f81fa52f));
  playFX(getfx("vfx_wallbuy_reveal_xlg"), structspawn.origin);

  switch (rarity) {
    case #"hash_883ff07272b4f9c":
      cost = function_86989ab07942c980(structspawn.var_2dda78d4f81fa52f.weapon_root_name, "green");
      structspawn.var_2dda78d4f81fa52f.cost = cost;
      structspawn.var_2dda78d4f81fa52f.rarity = "green";
      structspawn.var_2dda78d4f81fa52f setscriptablepartstate("wallbuy", "green");
      break;
    case #"hash_778bb52ecd08072d":
      cost = function_86989ab07942c980(structspawn.var_2dda78d4f81fa52f.weapon_root_name, "blue");
      structspawn.var_2dda78d4f81fa52f.cost = cost;
      structspawn.var_2dda78d4f81fa52f.rarity = "blue";
      structspawn.var_2dda78d4f81fa52f setscriptablepartstate("wallbuy", "blue");
      break;
    case #"hash_598a30e44f53045f":
      cost = function_86989ab07942c980(structspawn.var_2dda78d4f81fa52f.weapon_root_name, "purple");
      structspawn.var_2dda78d4f81fa52f.cost = cost;
      structspawn.var_2dda78d4f81fa52f.rarity = "purple";
      structspawn.var_2dda78d4f81fa52f setscriptablepartstate("wallbuy", "purple");
      break;
    case #"hash_35bb3bd014c77f4b":
      cost = function_86989ab07942c980(structspawn.var_2dda78d4f81fa52f.weapon_root_name, "orange");
      structspawn.var_2dda78d4f81fa52f.cost = cost;
      structspawn.var_2dda78d4f81fa52f.rarity = "orange";
      structspawn.var_2dda78d4f81fa52f setscriptablepartstate("wallbuy", "orange");
      break;
    default:
      cost = function_86989ab07942c980(structspawn.var_2dda78d4f81fa52f.weapon_root_name, "white");
      structspawn.var_2dda78d4f81fa52f.cost = cost;
      structspawn.var_2dda78d4f81fa52f setscriptablepartstate("wallbuy", "base");
      break;
  }
}

function on_round_end(params) {
  if(!isDefined(level.contentmanager.spawnedinstances["wallbuy"])) {
    return;
  }

  if(level.round_number % 5 == 0) {
    round_number = level.round_number;

    foreach(instance in level.contentmanager.spawnedinstances["wallbuy"]) {
      if(isDefined(instance.contentgroups) && instance.contentgroups.size > 0) {
        foreach(wallbuy_spawn in instance.contentgroups["wallbuy_spawn"]) {
          if(isDefined(wallbuy_spawn.var_2dda78d4f81fa52f) && isDefined(wallbuy_spawn.var_2dda78d4f81fa52f.rarity) && wallbuy_spawn.var_2dda78d4f81fa52f.rarity != "orange") {
            n_chance = 0;

            switch (round_number) {
              case 5:
                if(wallbuy_spawn.var_2dda78d4f81fa52f.rarity == "blue") {
                  n_chance = default_to(level.wallbuybundle.var_bb25eb01f6acca96, 8);
                } else if(wallbuy_spawn.var_2dda78d4f81fa52f.rarity == "purple") {
                  n_chance = default_to(level.wallbuybundle.var_b87a6e25da817d60, 6);
                } else {
                  n_chance = default_to(level.wallbuybundle.var_2d12668ccc083233, 23);
                }

                break;
              case 10:
                if(wallbuy_spawn.var_2dda78d4f81fa52f.rarity == "blue") {
                  n_chance = default_to(level.wallbuybundle.var_413ff3517e14bd56, 10);
                } else if(wallbuy_spawn.var_2dda78d4f81fa52f.rarity == "purple") {
                  n_chance = default_to(level.wallbuybundle.var_36cf253f8ad9ef94, 7);
                } else {
                  n_chance = default_to(level.wallbuybundle.var_27bb22a4b619553d, 45);
                }

                break;
              case 15:
                if(wallbuy_spawn.var_2dda78d4f81fa52f.rarity == "blue") {
                  n_chance = default_to(level.wallbuybundle.var_413ff8517e14c855, 19);
                } else if(wallbuy_spawn.var_2dda78d4f81fa52f.rarity == "purple") {
                  n_chance = default_to(level.wallbuybundle.var_36cf223f8ad9e8fb, 9);
                } else {
                  n_chance = default_to(level.wallbuybundle.var_27bb1da4b6194a3e, 74);
                }

                break;
              case 20:
                if(wallbuy_spawn.var_2dda78d4f81fa52f.rarity == "blue") {
                  n_chance = default_to(level.wallbuybundle.var_413b8d517e0fe72d, 44);
                } else if(wallbuy_spawn.var_2dda78d4f81fa52f.rarity == "purple") {
                  n_chance = default_to(level.wallbuybundle.var_36dc973f8ae8fecf, 9);
                } else {
                  n_chance = default_to(level.wallbuybundle.var_27bf88a4b61e2b66, 84);
                }

                break;
              case 25:
                if(wallbuy_spawn.var_2dda78d4f81fa52f.rarity == "blue") {
                  n_chance = default_to(level.wallbuybundle.var_413b88517e0fdc2e, 73);
                } else if(wallbuy_spawn.var_2dda78d4f81fa52f.rarity == "purple") {
                  n_chance = default_to(level.wallbuybundle.var_36dc923f8ae8f3d0, 18);
                } else {
                  n_chance = default_to(level.wallbuybundle.var_27bf8da4b61e3665, 95);
                }

                break;
              case 30:
                if(wallbuy_spawn.var_2dda78d4f81fa52f.rarity == "blue") {
                  n_chance = default_to(level.wallbuybundle.var_413707517e0acaa4, 90);
                } else if(wallbuy_spawn.var_2dda78d4f81fa52f.rarity == "purple") {
                  n_chance = default_to(level.wallbuybundle.var_36d8113f8ae3e246, 43);
                } else {
                  n_chance = default_to(level.wallbuybundle.var_27c40ea4b62347ef, 100);
                }

                break;
              case 35:
                if(wallbuy_spawn.var_2dda78d4f81fa52f.rarity == "blue") {
                  n_chance = default_to(level.wallbuybundle.var_413704517e0ac40b, 100);
                } else if(wallbuy_spawn.var_2dda78d4f81fa52f.rarity == "purple") {
                  n_chance = default_to(level.wallbuybundle.var_36d8163f8ae3ed45, 63);
                } else {
                  n_chance = default_to(level.wallbuybundle.var_27c409a4b6233cf0, 100);
                }

                break;
              case 40:
              default:
                if(wallbuy_spawn.var_2dda78d4f81fa52f.rarity == "blue") {
                  n_chance = default_to(level.wallbuybundle.var_413301517e06c79b, 100);
                } else if(wallbuy_spawn.var_2dda78d4f81fa52f.rarity == "purple") {
                  n_chance = default_to(level.wallbuybundle.var_36c2133f8acbb379, 90);
                } else {
                  n_chance = default_to(level.wallbuybundle.var_27a584a4b601f990, 100);
                }

                break;
            }

            if(percent_chance(n_chance)) {
              switch (wallbuy_spawn.var_2dda78d4f81fa52f.rarity) {
                case #"hash_1393412d7401c646":
                  new_rarity = "green";
                  break;
                case #"hash_883ff07272b4f9c":
                  new_rarity = "blue";
                  break;
                case #"hash_778bb52ecd08072d":
                  new_rarity = "purple";
                  break;
                case #"hash_598a30e44f53045f":
                default:
                  new_rarity = "orange";
                  break;
              }

              function_e898734a6a951c57(wallbuy_spawn, new_rarity);
              waitframe();
            }
          }
        }
      }
    }
  }
}
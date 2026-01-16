/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_crafting.gsc
***************************************/

init() {
  if(!isDefined(level.placeableconfigs))
    level.placeableconfigs = [];

  level thread crafting_onplayerconnect();
  level.trophy_use_pickupfunc = ::trophy_use_pickupfunc;
  level.custom_pet_bomb_check = ::crafting_pet_trap_check;
  level.resetplayercraftingitemsonrespawn = ::resetplayercraftingitemsonrespawn;

  if(!maps\mp\alien\_utility::is_chaos_mode())
    setup_recipes();
}

setup_recipes() {
  var_0 = ["tesla", "grenade", "trap", "weapon", "sticky"];

  if(isDefined(level.recipe_setup_func))
    var_0 = [
      [level.recipe_setup_func]
    ]();

  var_1 = getEntArray("crafting_recipe_table", "targetname");

  foreach(var_3 in var_1) {
    var_3.is_recipe_table = 1;
    maps\mp\alien\_outline_proto::add_to_outline_weapon_watch_list(var_3, 0);
    var_4 = common_scripts\utility::array_randomize(var_0);

    if(isDefined(var_3.script_noteworthy))
      var_4 = strtok(var_3.script_noteworthy, " ");

    if(isDefined(var_3.target)) {
      var_5 = getEntArray(var_3.target, "targetname");

      foreach(var_8, var_7 in var_5) {
        var_7 makeusable();

        switch (var_4[var_8]) {
          case "tesla":
            var_7 sethintstring(&"ALIEN_CRAFTING_RECIPE_TESLA");
            break;
          case "weapon":
            var_7 sethintstring(&"ALIEN_CRAFTING_RECIPE_VENOM");
            break;
          case "grenade":
            var_7 sethintstring(&"ALIEN_CRAFTING_RECIPE_GRENADE");
            break;
          case "trap":
            var_7 sethintstring(&"ALIEN_CRAFTING_RECIPE_HYPNO");
            break;
          case "sticky":
            var_7 sethintstring(&"ALIEN_CRAFTING_RECIPE_STICKY");
            break;
          case "cortexgrenade":
            var_7 sethintstring(&"ALIEN_CRAFTING_RECIPE_CORTEXGRENADE");
            break;
          case "cortexweapon":
            var_7 sethintstring(&"ALIEN_CRAFTING_RECIPE_CORTEXWEAPON");
            break;
          case "vgrenade":
            var_7 sethintstring(&"ALIEN_CRAFTING_RECIPE_VGRENADE");
            break;
        }

        var_7.recipe_name = var_4[var_8];
        var_7 thread wait_for_recipe_use();
      }

      continue;
    }

    var_3 makeusable();

    if(!isDefined(level.recipe_names_list))
      level.recipe_names_list = var_4;

    var_9 = common_scripts\utility::random(level.recipe_names_list);

    switch (var_9) {
      case "tesla":
        var_3 sethintstring(&"ALIEN_CRAFTING_RECIPE_TESLA");
        break;
      case "weapon":
        var_3 sethintstring(&"ALIEN_CRAFTING_RECIPE_VENOM");
        break;
      case "grenade":
        var_3 sethintstring(&"ALIEN_CRAFTING_RECIPE_GRENADE");
        break;
      case "trap":
        var_3 sethintstring(&"ALIEN_CRAFTING_RECIPE_HYPNO");
        break;
      case "sticky":
        var_3 sethintstring(&"ALIEN_CRAFTING_RECIPE_STICKY");
        break;
      case "vgrenade":
        var_3 sethintstring(&"ALIEN_CRAFTING_RECIPE_VGRENADE");
        break;
    }

    var_3.recipe_name = var_9;
    var_3 thread wait_for_recipe_use();
    level.recipe_names_list = common_scripts\utility::array_remove(level.recipe_names_list, var_9);

    if(level.recipe_names_list.size <= 0) {
      level.recipe_names_list = var_4;
      var_9 = common_scripts\utility::random(level.recipe_names_list);
      level.recipe_names_list = common_scripts\utility::array_remove(level.recipe_names_list, var_9);
    }
  }
}

check_for_player_near_crafting_table() {
  self endon("disconnect");
  var_0 = 21025;

  for(;;) {
    var_1 = getEntArray("crafting_recipe_table", "targetname");

    if(isDefined(self.inlaststand) && self.inlaststand || isDefined(self.usingremote) || maps\mp\alien\_utility::is_true(self.iscarrying)) {
      wait 0.05;
      continue;
    }

    foreach(var_3 in var_1) {
      if(distancesquared(var_3.origin, self.origin) < var_0) {
        if(isDefined(self.current_crafting_recipe) && self.craftingitems.size > 0) {
          if(!isDefined(self.new_schematic))
            maps\mp\_utility::setlowermessage("crafting_warn", & "ALIEN_CRAFTING_WARNING_LOSEITEMS", undefined, 10);

          while(player_should_see_craft_warning(var_3, var_0, 0))
            wait 0.05;
        }

        self.new_schematic = undefined;
        maps\mp\_utility::clearlowermessage("crafting_warn");
      }
    }

    wait 1;
  }
}

player_should_see_craft_warning(var_0, var_1, var_2) {
  if(distancesquared(var_0.origin, self.origin) > var_1)
    return 0;

  if(self.inlaststand)
    return 0;

  if(isDefined(self.usingremote))
    return 0;

  if(maps\mp\alien\_utility::is_true(var_2))
    return 1;
  else if(maps\mp\alien\_utility::is_true(self.iscarrying))
    return 0;

  return 1;
}

wait_for_recipe_use() {
  for(;;) {
    self waittill("trigger", var_0);

    if(isDefined(var_0.inlaststand) && var_0.inlaststand || isDefined(var_0.usingremote) || maps\mp\alien\_utility::is_true(var_0.iscarrying)) {
      continue;
    }
    var_1 = undefined;

    if(var_0 maps\mp\alien\_prestige::prestige_getnodeployables() == 1.0) {
      var_0 maps\mp\_utility::setlowermessage("cant_buy", & "ALIENS_PRESTIGE_NO_DEPLOYABLES_PICKUP", 3);
      continue;
    }

    if((self.recipe_name == "weapon" || self.recipe_name == "cortexweapon") && var_0 maps\mp\alien\_prestige::prestige_getpistolsonly() == 1) {
      var_0 maps\mp\_utility::setlowermessage("cant_buy", & "ALIEN_COLLECTIBLES_PLAYER_NERFED", 3);
      continue;
    }

    if(!isDefined(var_0.current_crafting_recipe)) {
      var_0.current_crafting_recipe = self.recipe_name;
      var_0 setclientomnvar("ui_alien_craft_recipe", get_index_for_recipe(self.recipe_name));
    } else if(var_0.current_crafting_recipe == self.recipe_name) {
      var_0 maps\mp\_utility::setlowermessage("cant_buy", & "ALIEN_CRAFTING_ALREADY_HAVE", 3);
      continue;
    } else {
      var_1 = var_0.craftingitems;
      var_0 take_crafting_items();
      var_0.current_crafting_recipe = self.recipe_name;
      var_0 setclientomnvar("ui_alien_craft_recipe", get_index_for_recipe(self.recipe_name));
      var_0 setclientomnvar("ui_alien_hudcraftinginfo", -1);
    }

    var_0.new_schematic = 1;
    var_0 set_crafting_ingredients(var_1);

    switch (var_0.current_crafting_recipe) {
      case "weapon":
        var_0 iprintlnbold(&"ALIEN_CRAFTING_GOT_VENOM_RECIPE");
        break;
      case "grenade":
        var_0 iprintlnbold(&"ALIEN_CRAFTING_GOT_GRENADE_RECIPE");
        break;
      case "trap":
        var_0 iprintlnbold(&"ALIEN_CRAFTING_GOT_TRAP_RECIPE");
        break;
      case "tesla":
        var_0 iprintlnbold(&"ALIEN_CRAFTING_GOT_TESLA_RECIPE");
        break;
      case "sticky":
        var_0 iprintlnbold(&"ALIEN_CRAFTING_GOT_STICKY_RECIPE");
        break;
      case "vgrenade":
        var_0 iprintlnbold(&"ALIEN_CRAFTING_GOT_VGRENADE_RECIPE");
        break;
      case "cortexgrenade":
        level notify("dlc_vo_notify", "nx_grenade_schematic", var_0);
        var_0 iprintlnbold(&"ALIEN_CRAFTING_GOT_NX1_GRENADE");
        break;
      case "cortexweapon":
        level notify("dlc_vo_notify", "nx_weapon_schematic", var_0);
        var_0 iprintlnbold(&"ALIEN_CRAFTING_GOT_NX1");
        break;
    }
  }
}

set_crafting_ingredients(var_0) {
  if(!isDefined(self.current_crafting_recipe)) {
    return;
  }
  switch (self.current_crafting_recipe) {
    case "weapon":
      self.crafting_ingredient_list = ["venomx", "nucleicbattery"];
      self.swappable_crafting_ingredient_list = ["bluebiolum", "biolum", "orangebiolum", "amethystbiolum"];

      if(level.script == "mp_alien_dlc3")
        self.swappable_crafting_ingredient_list = ["bluebiolum", "biolum", "orangebiolum", "bbiolum"];

      break;
    case "grenade":
      self.crafting_ingredient_list = ["fuse", "tnt"];
      self.swappable_crafting_ingredient_list = ["pipe"];
      break;
    case "sticky":
      self.crafting_ingredient_list = ["fuse", "tnt"];
      self.swappable_crafting_ingredient_list = ["resin"];
      break;
    case "trap":
      self.crafting_ingredient_list = ["biolum", "cellbattery"];
      self.swappable_crafting_ingredient_list = ["pressureplate"];
      break;
    case "tesla":
      self.crafting_ingredient_list = ["amolecular", "wire"];
      self.swappable_crafting_ingredient_list = ["cellbattery", "nucleicbattery", "liquidbattery"];
      break;
    case "vgrenade":
      self.crafting_ingredient_list = ["detonator", "casing"];
      self.swappable_crafting_ingredient_list = ["bluebiolum", "bbiolum", "orangebiolum", "biolum"];
      break;
    case "cortexgrenade":
      self.crafting_ingredient_list = ["casing", "cortexgel"];
      self.swappable_crafting_ingredient_list = ["fuse"];
      break;
    case "cortexweapon":
      self.crafting_ingredient_list = ["cortexhousing", "substrate"];
      self.swappable_crafting_ingredient_list = ["liquidbattery"];
      break;
  }

  if(isDefined(var_0)) {
    foreach(var_2 in var_0) {
      if(common_scripts\utility::array_contains(self.crafting_ingredient_list, var_2)) {
        self.crafting_ingredient_list = common_scripts\utility::array_remove(self.crafting_ingredient_list, var_2);
        maps\mp\alien\_pillage::give_crafting_item(var_2);
        continue;
      }

      if(common_scripts\utility::array_contains(self.swappable_crafting_ingredient_list, var_2))
        maps\mp\alien\_pillage::give_crafting_item(var_2);
    }
  }
}

get_index_for_recipe(var_0) {
  switch (var_0) {
    case "weapon":
      return 201;
    case "grenade":
      return 202;
    case "trap":
      return 203;
    case "tesla":
      return 204;
    case "sticky":
      return 205;
    case "vgrenade":
      return 206;
    case "cortexweapon":
      return 207;
    case "cortexgrenade":
      return 208;
  }
}

crafting_onplayerconnect() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
    var_0.craftingitems = [];
    var_0.crafted_items = [];
    var_0 thread crafting_menu_monitor();
    var_0 thread check_for_player_near_crafting_table();
  }
}

resetplayercraftingitemsonrespawn() {
  var_0 = undefined;

  if(isDefined(self.craftingitems))
    var_0 = self.craftingitems;

  self.craftingitems = [];

  if(isDefined(var_0) && var_0.size > 0) {
    var_1 = common_scripts\utility::array_remove_duplicates(var_0);

    foreach(var_1 in var_0)
    maps\mp\alien\_pillage::give_crafting_item(var_1);
  }
}

giveplaceable(var_0) {
  var_1 = createplaceable(var_0);
  self.carrieditem = var_1;
  var_2 = onbegincarrying(var_0, var_1, 1);
  self.carrieditem = undefined;
  return isDefined(var_1);
}

createplaceable(var_0) {
  if(isDefined(self.iscarrying) && self.iscarrying) {
    return;
  }
  var_1 = level.placeableconfigs[var_0];
  var_2 = spawn("script_model", self.origin);
  var_2 setModel(var_1.modelbase);
  var_2.angles = self.angles;
  var_2.owner = self;
  var_2.team = self.team;
  var_2.config = var_1;
  var_2.firstplacement = 1;
  var_2 setup_placeable_tags(var_0);

  if(isDefined(var_1.oncreatedelegate))
    var_2[[var_1.oncreatedelegate]](var_0);

  var_2 deactivate(var_0);
  var_2 thread timeout(var_0);
  var_2 thread handleuse(var_0);
  var_2 thread ongameended(var_0);
  return var_2;
}

handleuse(var_0) {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_1);

    if(!maps\mp\_utility::isreallyalive(var_1)) {
      continue;
    }
    if(isDefined(level.drill_carrier) && var_1 == level.drill_carrier) {
      continue;
    }
    if(isDefined(self getlinkedparent()))
      self unlink();

    var_1 onbegincarrying(var_0, self, 0);
  }
}

onbegincarrying(var_0, var_1, var_2) {
  self endon("death");
  self endon("last_stand");
  self endon("disconnect");
  var_1 setup_placeable_tags(var_0);
  var_1 thread oncarried(var_0, self);
  common_scripts\utility::_disableweapon();

  if(!isai(self)) {
    self notifyonplayercommand("placePlaceable", "+attack");
    self notifyonplayercommand("placePlaceable", "+attack_akimbo_accessible");
    self notifyonplayercommand("tryaction", "+actionslot 1");
    self notifyonplayercommand("tryaction", "+actionslot 2");
    self notifyonplayercommand("tryaction", "+actionslot 3");
    self notifyonplayercommand("tryaction", "+actionslot 4");

    if(!maps\mp\alien\_utility::is_chaos_mode())
      self notifyonplayercommand("cancelPlaceable", "weapnext");

    if(!level.console) {
      self notifyonplayercommand("tryaction", "+actionslot 5");
      self notifyonplayercommand("tryaction", "+actionslot 6");
      self notifyonplayercommand("tryaction", "+actionslot 7");
    }
  }

  for(;;) {
    var_3 = common_scripts\utility::waittill_any_return("placePlaceable", "cancelPlaceable", "force_cancel_placement", "last_stand", "tryaction");

    if(!isDefined(var_1)) {
      common_scripts\utility::_enableweapon();
      return 1;
    } else if(var_3 == "cancelPlaceable" && var_2 || var_3 == "force_cancel_placement") {
      var_1 oncancel(var_0, var_3 == "force_cancel_placement" && !isDefined(var_1.firstplacement), "canceled");
      return 0;
    } else if(var_3 == "tryaction") {
      maps\mp\_utility::setlowermessage("cant_buy", & "ALIEN_COLLECTIBLES_PLAYER_HOLDING", 3);
      continue;
    } else if(var_1.canbeplaced) {
      var_1 thread onplaced(var_0);
      common_scripts\utility::_enableweapon();
      return 1;
    }
  }
}

setup_placeable_tags(var_0) {
  switch (var_0) {
    case "amolecular_cellbattery_wire":
      self hidepart("tag_tesla_swap_large");
      self hidepart("tag_tesla_swap_med");
      break;
    case "amolecular_liquidbattery_wire":
      self hidepart("tag_tesla_swap_large");
      self hidepart("tag_tesla_swap_small");
      break;
    case "amolecular_nucleicbattery_wire":
      self hidepart("tag_tesla_swap_small");
      self hidepart("tag_tesla_swap_med");
      break;
  }
}

oncancel(var_0, var_1, var_2) {
  if(isDefined(self.carriedby) && isalive(self.carriedby)) {
    var_3 = self.carriedby;
    var_3 forceusehintoff();
    var_3.iscarrying = undefined;
    var_3.carrieditem = undefined;
    var_3 common_scripts\utility::_enableweapon();

    if(isDefined(var_2) && (var_2 == "last_stand" || var_2 == "canceled")) {
      if(isDefined(var_3.current_crafting_recipe)) {
        var_3.craftingitems = [];
        var_4 = strtok(var_0, "_");

        foreach(var_6 in var_4)
        var_3 maps\mp\alien\_pillage::give_crafting_item(var_6);
      }
    }
  }

  if(isDefined(self.carriedobj))
    self.carriedobj delete();

  var_8 = level.placeableconfigs[var_0];

  if(isDefined(var_8.oncanceldelegate))
    self[[var_8.oncanceldelegate]](var_0);

  if(isDefined(var_1) && var_1)
    maps\mp\gametypes\_weapons::equipmentdeletevfx();

  if(isDefined(self.attack_bolt))
    self.attack_bolt delete();

  self delete();
}

onplaced(var_0) {
  var_1 = level.placeableconfigs[var_0];
  var_2 = (0, 0, 0);

  if(var_0 == "placeable_generator")
    var_2 = (0, 0, 2);

  self.origin = self.placementorigin + var_2;
  self.angles = self.carriedobj.angles;
  self playSound(var_1.placedsfx);
  showplacedmodel(var_0);

  if(isDefined(var_1.onplaceddelegate))
    self[[var_1.onplaceddelegate]](var_0);

  if(var_0 != "placeable_generator") {
    self setcursorhint("HINT_NOICON");
    self sethintstring(var_1.hintstring);
  }

  if(isDefined(self.firstplacement) && var_0 != "placeable_generator") {
    level notify("dlc_vo_notify", var_1.item_name_ref, self.owner);
    self.owner take_crafting_items();
    self.owner take_crafting_recipe();
    self.owner add_to_crafted_item_list(var_0, self);

    if(should_calculate_crafting_score())
      maps\mp\alien\_gamescore::calculate_player_encounter_scores(self.owner, ["item_crafting"]);
  }

  var_3 = self.owner;
  var_3 forceusehintoff();
  var_3.iscarrying = undefined;
  self.carriedby = undefined;
  self.isplaced = 1;
  self.firstplacement = undefined;
  thread handledamage(var_0);
  thread handledeath(var_0);
  setup_placeable_tags(var_0);
  self makeusable();
  self.targetname = "crafted_item";
  common_scripts\utility::make_entity_sentient_mp(self.owner.team);

  if(issentient(self))
    self setthreatbiasgroup("DogsDontAttack");

  foreach(var_5 in level.players) {
    if(var_5 == var_3) {
      self enableplayeruse(var_5);
      continue;
    }

    self disableplayeruse(var_5);
  }

  if(isDefined(self.shouldsplash)) {
    level thread maps\mp\_utility::teamplayercardsplash(var_1.splashname, var_3);
    self.shouldsplash = 0;
  }

  var_7 = spawnStruct();
  var_7.linkparent = self.moving_platform;
  var_7.playdeathfx = 1;
  var_7.endonstring = "carried";

  if(isDefined(var_1.onmovingplatformcollision))
    var_7.deathoverridecallback = var_1.onmovingplatformcollision;

  thread maps\mp\_movers::handle_moving_platforms(var_7);
  thread watchplayerconnected();
  self notify("placed");
  self.carriedobj delete();
  self.carriedobj = undefined;
  thread autodestruct_on_owner_disconnect();
}

oncarried(var_0, var_1) {
  var_2 = level.placeableconfigs[var_0];
  self.carriedobj = var_1 createcarriedobject(var_0);
  self.carriedobj setup_placeable_tags(var_0);
  self.isplaced = undefined;
  self.carriedby = var_1;
  var_1.iscarrying = 1;
  deactivate(var_0);
  hideplacedmodel(var_0);

  if(isDefined(var_2.oncarrieddelegate))
    self[[var_2.oncarrieddelegate]](var_0);

  thread updateplacement(var_0, var_1);
  thread oncarrierdeath(var_0, var_1);
  self notify("carried");

  if(isDefined(var_2.item_class) && var_2.item_class == "tesla") {
    level notify("cancel_ball_lightning");
    level.creating_ball_lightning = undefined;
  }
}

updateplacement(var_0, var_1) {
  var_1 endon("death");
  var_1 endon("disconnect");
  level endon("game_ended");
  self endon("placed");
  self endon("death");
  self.canbeplaced = 1;
  var_2 = -1;
  var_3 = level.placeableconfigs[var_0];
  var_4 = (0, 0, 0);

  if(isDefined(var_3.placementoffsetz))
    var_4 = (0, 0, var_3.placementoffsetz);

  var_5 = self.carriedobj;

  for(;;) {
    var_6 = var_1 canplayerplacesentry(1, var_3.placementradius);

    if(!isDefined(self)) {
      return;
    }
    self.placementorigin = var_6["origin"];
    var_5.origin = self.placementorigin + var_4;
    var_5.angles = var_6["angles"];
    self.canbeplaced = var_1 isonground() && var_6["result"] && abs(self.placementorigin[2] - var_1.origin[2]) < var_3.placementheighttolerance;
    var_7 = getEntArray("crafted_item", "targetname");
    var_8 = [];

    foreach(var_10 in var_7) {
      if(!isDefined(var_10.model)) {
        continue;
      }
      if(var_10 == self) {
        continue;
      }
      if(var_10.model == "alien_crafting_tesla_trap" || var_10.model == "alien_crafting_hypno_trap" || var_10.model == "alien_portable_generator")
        var_8[var_8.size] = var_10;
    }

    foreach(var_13 in var_8) {
      if(distancesquared(var_5.origin, var_13.origin) < 4096) {
        self.canbeplaced = 0;
        break;
      }
    }

    if(isDefined(var_6["entity"]))
      self.moving_platform = var_6["entity"];
    else
      self.moving_platform = undefined;

    if(self.canbeplaced != var_2) {
      var_5 hide();

      if(self.canbeplaced) {
        var_5 setModel(var_3.modelplacement);
        var_5 setup_placeable_tags(var_0);

        if(isDefined(self.firstplacement))
          var_1 forceusehinton(var_3.placestring);
        else
          var_1 forceusehinton(var_3.placestringnocancel);
      } else {
        var_5 setModel(var_3.modelplacementfailed);
        var_5 setup_placeable_tags(var_0);
        var_1 forceusehinton(var_3.cannotplacestring);
      }

      var_5 show();
    }

    var_2 = self.canbeplaced;
    wait 0.05;
  }
}

deactivate(var_0) {
  self makeunusable();
  self freeentitysentient();
  var_1 = level.placeableconfigs[var_0];

  if(isDefined(var_1.ondeactivedelegate))
    self[[var_1.ondeactivedelegate]](var_0);

  if(var_1.item_class == "trap")
    thread kill_pettrap_fx();
}

kill_pettrap_fx() {
  killfxontag(level._effect["actuator_idle"], self, "tag_fx");
}

handledamage(var_0) {
  self endon("carried");
  var_1 = level.placeableconfigs[var_0];
  maps\mp\gametypes\_damage::monitordamage(var_1.maxhealth, var_1.damagefeedback, ::handledeathdamage, ::modifydamage, 1);
}

modifydamage(var_0, var_1, var_2, var_3) {
  var_4 = var_3;
  var_5 = self.config;

  if(isDefined(var_5.allowmeleedamage) && var_5.allowmeleedamage)
    var_4 = maps\mp\gametypes\_damage::handlemeleedamage(var_1, var_2, var_4);

  if(isDefined(var_5.allowempdamage) && var_5.allowempdamage)
    var_4 = maps\mp\gametypes\_damage::handleempdamage(var_1, var_2, var_4);

  var_4 = maps\mp\gametypes\_damage::handlemissiledamage(var_1, var_2, var_4);
  var_4 = maps\mp\gametypes\_damage::handlegrenadedamage(var_1, var_2, var_4);
  var_4 = maps\mp\gametypes\_damage::handleapdamage(var_1, var_2, var_4, var_0);

  if(isDefined(var_5.modifydamage))
    var_4 = self[[var_5.modifydamage]](var_1, var_2, var_4);

  return var_4;
}

handledeathdamage(var_0, var_1, var_2, var_3) {
  var_4 = self.config;
  var_5 = maps\mp\gametypes\_damage::onkillstreakkilled(var_0, var_1, var_2, var_3, var_4.xppopup, var_4.destroyedvo);

  if(var_5 && isDefined(var_4.ondestroyeddelegate))
    self[[var_4.ondestroyeddelegate]](self.streakname, var_0, self.owner, var_2);
}

handledeath(var_0) {
  self endon("carried");
  var_1 = self.owner;
  self waittill("death");
  var_2 = level.placeableconfigs[var_0];

  if(isDefined(self.attack_bolt)) {
    wait 0.1;

    if(isDefined(self.attack_bolt))
      self.attack_bolt delete();
  }

  if(isDefined(self)) {
    deactivate(var_0);

    if(isDefined(var_2.ondeathdelegate))
      self[[var_2.ondeathdelegate]](var_0);

    self delete();

    if(isDefined(var_1))
      var_1 remove_from_crafted_item_list(var_0);
  }

  if(isDefined(var_2.item_class) && var_2.item_class == "tesla") {
    level notify("cancel_ball_lightning");
    level.creating_ball_lightning = undefined;
  }
}

oncarrierdeath(var_0, var_1) {
  self endon("placed");
  self endon("death");
  var_1 endon("disconnect");
  var_2 = var_1 common_scripts\utility::waittill_any_return("death", "last_stand");
  var_3 = undefined;
  oncancel(var_0, var_3, var_2);
}

ongameended(var_0) {
  self endon("death");
  level waittill("game_ended");
  cleanup(var_0);
}

cleanup(var_0) {
  if(isDefined(self.isplaced))
    self notify("death");
  else
    oncancel(var_0);
}

watchplayerconnected() {
  self endon("death");

  for(;;) {
    level waittill("connected", var_0);
    thread onplayerconnected(var_0);
  }
}

onplayerconnected(var_0) {
  self endon("death");
  var_0 endon("disconnect");
  var_0 waittill("spawned_player");
  self disableplayeruse(var_0);
}

timeout(var_0) {
  self endon("death");
  level endon("game_ended");
  var_1 = level.placeableconfigs[var_0];
  var_2 = var_1.lifespan;

  while(var_2 > 0.0) {
    wait 1.0;
    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();

    if(!isDefined(self.carriedby))
      var_2 = var_2 - 1.0;
  }

  if(isDefined(self.owner) && isDefined(var_1.gonevo))
    self.owner thread maps\mp\_utility::leaderdialogonplayer(var_1.gonevo);

  self notify("death");
}

showplacedmodel(var_0) {
  self show();
}

hideplacedmodel(var_0) {
  self hide();
}

createcarriedobject(var_0) {
  if(isDefined(self.iscarrying) && self.iscarrying) {
    return;
  }
  var_1 = spawnturret("misc_turret", self.origin + (0, 0, 25), "sentry_minigun_mp");
  var_1.angles = self.angles;
  var_1.owner = self;
  var_2 = level.placeableconfigs[var_0];
  var_1 setModel(var_2.modelbase);
  var_1 maketurretinoperable();
  var_1 setturretmodechangewait(1);
  var_1 setmode("sentry_offline");
  var_1 makeunusable();
  var_1 setsentryowner(self);
  var_1 setsentrycarrier(self);
  var_1 setCanDamage(0);
  var_1 setcontents(0);
  var_1.companion_distance = 62500;
  return var_1;
}

crafting_menu_monitor() {
  self endon("disconnect");
  var_0 = "craft_current_item";

  for(;;) {
    self waittillmatch("luinotifyserver", var_0);
    wait 0.5;

    if(maps\mp\alien\_utility::is_true(self.laststand) || !isalive(self)) {
      continue;
    }
    var_1 = combine_inventory_items();
    var_1 = crafting_table_check(var_1);

    if(maps\mp\alien\_utility::is_true(self.iscarrying) || isDefined(level.drill_carrier) && self == level.drill_carrier || maps\mp\alien\_utility::has_special_weapon() || self isusingturret() || maps\mp\_utility::isusingremote() || self.is_holding_deployable) {
      self playlocalsound("ui_craft_fail");
      maps\mp\_utility::setlowermessage("no_items", & "ALIEN_CRAFTING_CANT_CRAFT", 4);
      continue;
    }

    check_for_existing_crafting_item(var_1);

    if(isDefined(var_1) && var_1 != "none") {
      if(is_placeable_item(var_1)) {
        thread maps\mp\alien\_crafting_traps::tryuseplaceable(var_1);
        self playlocalsound("extinction_item_pickup");
        take_crafting_items();
        self setclientomnvar("ui_alien_hudcraftinginfo", -1);
        maps\mp\_utility::setlowermessage("crafted", & "ALIEN_CRAFTING_CRAFT_SUCCESS", 4);
        self playlocalsound("ui_craft_success");

        if(isDefined(level.update_achievement_craft_items_func))
          self[[level.update_achievement_craft_items_func]](level.placeableconfigs[var_1].item_name_ref);
      } else if(is_weapon_item(var_1)) {
        var_2 = 0;

        switch (level.placeableconfigs[var_1].item_name_ref) {
          case "pipe_bomb":
            if(maps\mp\alien\_crafting_traps::can_craft_pipe_bomb())
              var_2 = 1;
            else {
              maps\mp\_utility::setlowermessage("no_items", & "ALIEN_CRAFTING_NO_CRAFT_EXPLOSIVE", 3);
              self playlocalsound("ui_craft_deny");
            }

            break;
          case "sticky_flare":
            if(maps\mp\alien\_crafting_traps::can_craft_sticky_flare())
              var_2 = 1;
            else {
              maps\mp\_utility::setlowermessage("no_items", & "ALIEN_CRAFTING_NO_CRAFT_TACTICAL", 3);
              self playlocalsound("ui_craft_deny");
            }

            break;
          case "venomfx_grenade":
          case "venomlx_grenade":
          case "venomx_grenade_alt":
          case "venomx_grenade":
            if(maps\mp\alien\_crafting_traps::can_craft_venom_grenade())
              var_2 = 1;
            else {
              maps\mp\_utility::setlowermessage("no_items", & "ALIEN_CRAFTING_NO_CRAFT_EXPLOSIVE", 3);
              self playlocalsound("ui_craft_deny");
            }

            break;
          case "cortex_grenade":
            if(maps\mp\alien\_crafting_traps::can_craft_cortex_grenade())
              var_2 = 1;
            else {
              maps\mp\_utility::setlowermessage("no_items", & "ALIEN_CRAFTING_NO_CRAFT_EXPLOSIVE", 3);
              self playlocalsound("ui_craft_deny");
            }

            break;
          case "cortex_weapon":
            give_cortex_weapon(level.placeableconfigs[var_1].item_name_ref);
            var_2 = 1;
            break;
          case "venom_turret":
          case "venom_basic_alt":
          case "venom_basic":
          case "venom_lightning":
          case "venom_fire":
            give_venom_weapon(level.placeableconfigs[var_1].item_name_ref);
            var_2 = 1;
            break;
        }

        if(var_2) {
          thread maps\mp\alien\_crafting_traps::trygiveweapon(var_1);
          self playlocalsound("extinction_item_pickup");
          take_crafting_items();
          take_crafting_recipe();
          maps\mp\_utility::setlowermessage("no_items", & "ALIEN_CRAFTING_CRAFT_SUCCESS", 4);
          self playlocalsound("ui_craft_success");

          if(should_calculate_crafting_score())
            maps\mp\alien\_gamescore::calculate_player_encounter_scores(self, ["item_crafting"]);

          if(isDefined(level.update_achievement_craft_items_func))
            self[[level.update_achievement_craft_items_func]](level.placeableconfigs[var_1].item_name_ref);
        }
      }
    } else
      maps\mp\_utility::setlowermessage("no_items", & "ALIEN_CRAFTING_ALREADY_HAVE", 3);

    wait 1;
  }
}

give_venom_weapon(var_0) {
  level notify("dlc_vo_notify", var_0, self);
  var_1 = undefined;

  switch (var_0) {
    case "venom_basic_alt":
    case "venom_basic":
      var_1 = "iw6_aliendlc11_mp";
      self takeweapon("iw6_aliendlc11li_mp");
      self takeweapon("iw6_aliendlc11fi_mp");
      self takeweapon("iw6_aliendlc11sp_mp");
      break;
    case "venom_lightning":
      var_1 = "iw6_aliendlc11li_mp";
      self takeweapon("iw6_aliendlc11_mp");
      self takeweapon("iw6_aliendlc11fi_mp");
      self takeweapon("iw6_aliendlc11sp_mp");
      break;
    case "venom_fire":
      var_1 = "iw6_aliendlc11fi_mp";
      self takeweapon("iw6_aliendlc11li_mp");
      self takeweapon("iw6_aliendlc11_mp");
      self takeweapon("iw6_aliendlc11sp_mp");
      break;
    case "venom_turret":
      var_1 = "iw6_aliendlc11sp_mp";
      self takeweapon("iw6_aliendlc11li_mp");
      self takeweapon("iw6_aliendlc11fi_mp");
      self takeweapon("iw6_aliendlc11_mp");
      break;
  }

  if(!isDefined(self.numadditionalprimaries) || self.numadditionalprimaries == 0)
    maps\mp\alien\_utility::_enableadditionalprimaryweapon();

  self giveweapon(var_1);
  self switchtoweapon(var_1);
  var_2 = 2;

  if(maps\mp\alien\_prestige::prestige_getminammo() != 1)
    var_2 = 1;

  self setweaponammoclip(var_1, var_2);
  self setweaponammostock(var_1, var_2);
  level notify("venom_crafted");
}

give_cortex_weapon(var_0) {
  if(self hasweapon("iw6_aliendlc41_mp")) {
    return;
  }
  level notify("dlc_vo_notify", var_0, self);

  if(!isDefined(self.numadditionalprimaries) || self.numadditionalprimaries == 0)
    maps\mp\alien\_utility::_enableadditionalprimaryweapon();

  self giveweapon("iw6_aliendlc41_mp");
  self switchtoweapon("iw6_aliendlc41_mp");
  var_1 = 10;

  if(self _meth_842C("nerf_min_ammo"))
    var_1 = 5;

  self setweaponammoclip("iw6_aliendlc41_mp", var_1);
  self setweaponammostock("iw6_aliendlc41_mp", 0);
  level notify("cortex_crafted");
  thread show_cortex_hint();
}

show_cortex_hint() {
  maps\mp\_utility::setlowermessage("nx1_hint", & "MP_ALIEN_LAST_NX1_HINT", 4);
}

is_placeable_item(var_0) {
  if(!isDefined(level.placeableconfigs[var_0]))
    return 0;

  if(level.placeableconfigs[var_0].item_class == "grenade" || level.placeableconfigs[var_0].item_class == "weapon" || level.placeableconfigs[var_0].item_class == "vgrenade" || level.placeableconfigs[var_0].item_class == "cortexweapon" || level.placeableconfigs[var_0].item_class == "cortexgrenade")
    return 0;

  return 1;
}

is_weapon_item(var_0) {
  if(!isDefined(level.placeableconfigs[var_0]))
    return 0;

  if(level.placeableconfigs[var_0].item_class == "grenade" || level.placeableconfigs[var_0].item_class == "weapon" || level.placeableconfigs[var_0].item_class == "vgrenade" || level.placeableconfigs[var_0].item_class == "cortexweapon" || level.placeableconfigs[var_0].item_class == "cortexgrenade")
    return 1;

  return 0;
}

combine_inventory_items() {
  var_0 = "";
  self.craftingitems = common_scripts\utility::alphabetize(self.craftingitems);

  for(var_1 = 0; var_1 <= self.craftingitems.size - 1; var_1++) {
    var_2 = self.craftingitems[var_1];

    if(isDefined(var_2)) {
      if(var_1 == 0) {
        var_0 = var_2;
        continue;
      }

      var_0 = var_0 + "_" + var_2;
    }
  }

  return var_0;
}

crafting_table_check(var_0) {
  foreach(var_2 in level.placeableconfigs) {
    if(var_0 == var_2.streakname)
      return var_2.streakname;
  }

  return "none";
}

take_crafting_items() {
  self.craftingitems = [];
  self setclientomnvar("ui_alien_craft_slot_1", 0);
  self setclientomnvar("ui_alien_craft_slot_2", 0);
  self setclientomnvar("ui_alien_craft_slot_3", 0);
  set_crafting_ingredients();
}

check_for_existing_crafting_item(var_0) {
  var_1 = get_crafted_item_type(var_0);

  if(isDefined(self.crafted_items[var_1]))
    self.crafted_items[var_1] notify("death");
}

add_to_crafted_item_list(var_0, var_1) {
  self.crafted_items[get_crafted_item_type(var_0)] = var_1;
}

get_crafted_item_type(var_0) {
  var_1 = level.placeableconfigs[var_0].modelbase;
  return var_1;
}

remove_from_crafted_item_list(var_0) {
  self.crafted_items[var_0] = undefined;
}

trophy_use_pickupfunc(var_0) {
  return isDefined(var_0) && var_0 == "iw6_aliendlc21_mp";
}

crafting_pet_trap_check() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(isDefined(var_2.crafted_items) && isDefined(var_2.crafted_items["biolum_cellbattery_pressureplate"]))
      var_0++;
  }

  return var_0;
}

take_crafting_recipe() {
  self.current_crafting_recipe = undefined;
  self setclientomnvar("ui_alien_craft_recipe", 200);
  self setclientomnvar("ui_alien_hudcraftinginfo", -1);
}

autodestruct_on_owner_disconnect() {
  self endon("death");
  self endon("carried");
  self.owner waittill("disconnect");
  self notify("death");
}

should_calculate_crafting_score() {
  if(maps\mp\alien\_utility::is_chaos_mode())
    return 0;

  var_0 = 0;

  switch (getdvar("ui_mapname")) {
    case "mp_alien_last":
    case "mp_alien_beacon":
      var_0 = 1;
      break;
  }

  return var_0;
}
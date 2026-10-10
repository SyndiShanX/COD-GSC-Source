/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3113b52a395cd586.gsc
*************************************************/

#using script_11f4fc0fd23c7bed;
#using script_12668187dcf15b96;
#using script_2d9d24f7c63ac143;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\interaction;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\br_lootcache;
#namespace namespace_e192b53669adb26d;

function init() {
  if(!isDefined(level.tool_use)) {
    level.tool_use = spawnStruct();
    level.tool_use.var_a32b4464bd2b3a84 = [];
    level.tool_use.var_3162ebc254b69b75 = [];
    level.tool_use.var_833ab01147ed4eba = getdvarint(@ "hash_3f606843a775b487", 1);
  }

  if(!isDefined(level.br_pickups)) {
    level waittill("br_pickups_init");
  }

  function_69ac00aaca3df9d2();
  scripts\engine\scriptable::function_8daea885ec058271(&function_9ea56c6edd53918);
  namespace_7f114a09d9ee51c3::init();
  level.tool_use.init = 1;

  level thread init_debug();
}

function private function_69ac00aaca3df9d2() {
  if(!isDefined(level.gamemodebundle) || !isDefined(level.gamemodebundle.ingredienttooluselistbundlename)) {
    printlog("parseToolUseBundles: Unable to find gamemode bundle or ingredient tool use bundle");
    return;
  }

  ingredienttooluselistbundlename = level.gamemodebundle.ingredienttooluselistbundlename;

  if(!isstring(ingredienttooluselistbundlename) || ingredienttooluselistbundlename.size == 0) {
    printlog("parseToolUseBundles: Invalid type or value for ingredientToolUseListBundleName");
    return;
  }

  var_48b94be65b2a158e = getscriptbundle(hashcat(%"hash_174a600b1b827dac", ingredienttooluselistbundlename));

  if(!isDefined(var_48b94be65b2a158e)) {
    printlog("parseToolUseBundles: Invalid Ingredient List Bundle: " + var_48b94be65b2a158e);
    return;
  }

  foreach(index, entry in var_48b94be65b2a158e.var_a7bf6c1051d7f068) {
    var_2fb0e88235a5834f = function_908fc5a1f259c42c(entry.useweaponsettings);

    if(!isDefined(var_2fb0e88235a5834f)) {
      printlog("parseToolUseBundles: Invalid tool use settings asset at hintEntityToolUseList[" + index + "] in bundle " + ingredienttooluselistbundlename);
      continue;
    }

    toolsettings = spawnStruct();
    toolsettings.var_12db389f0fecd79e = var_2fb0e88235a5834f;
    toolsettings.var_2c8f270f17725f28 = "UseWeaponFlow";
    level.tool_use.var_3162ebc254b69b75[level.tool_use.var_3162ebc254b69b75.size] = toolsettings;
  }

  foreach(index, entry in var_48b94be65b2a158e.var_12c7b012c140fe7f) {
    scriptablename = entry.var_5e40f85b57215816;

    if(!isDefined(scriptablename)) {
      printlog("parseToolUseBundles: Invalid ingredient at scriptableToolUseList[" + index + "] in bundle " + ingredienttooluselistbundlename);
      continue;
    }

    var_2fb0e88235a5834f = function_908fc5a1f259c42c(entry.useweaponsettings);

    if(!isDefined(var_2fb0e88235a5834f)) {
      printlog("parseToolUseBundles: Invalid tool use settings asset at scriptableToolUseList[" + index + "] in bundle " + ingredienttooluselistbundlename);
      continue;
    }

    toolsettings = spawnStruct();
    toolsettings.var_12db389f0fecd79e = var_2fb0e88235a5834f;
    toolsettings.var_3c1a3a6d974c9683 = scripts\engine\utility::default_to(entry.var_3c1a3a6d974c9683, 0);
    toolsettings.usepositionoffset = function_cc974f6066708dc9(entry.usepositionoffset, (0, 0, 0));
    toolsettings.var_78003ee028921cf3 = scripts\engine\utility::default_to(entry.var_78003ee028921cf3, 0);
    toolsettings.useangles = function_cc974f6066708dc9(entry.useangles, (0, 0, 0));
    toolsettings.usepartname = scripts\engine\utility::default_to(entry.usepartname, #"");
    toolsettings.usestatename = scripts\engine\utility::default_to(entry.usestatename, #"");
    toolsettings.var_dbaa4837728a65f3 = scripts\engine\utility::default_to(entry.var_dbaa4837728a65f3, #"");
    toolsettings.var_68c5bd011a549dd = scripts\engine\utility::default_to(entry.var_68c5bd011a549dd, &"MP_DMZ_LOCKS/LOCKED");
    toolsettings.var_e2842446eec2f014 = scripts\engine\utility::default_to(entry.var_e2842446eec2f014, &"MP_DMZ_LOCKS/LOCKED");
    toolsettings.var_2c8f270f17725f28 = scripts\engine\utility::default_to(entry.var_2c8f270f17725f28, "UseWeaponFlow");
    toolsettings.var_1652909a360b82eb = scripts\engine\utility::default_to(entry.var_1652909a360b82eb, 0);
    toolsettings.var_93b9ec961aa25883 = scripts\engine\utility::default_to(entry.var_93b9ec961aa25883, "");
    toolsettings.var_4883db9641b2fef8 = scripts\engine\utility::default_to(entry.var_4883db9641b2fef8, "");
    level.tool_use.var_a32b4464bd2b3a84[scriptablename] = toolsettings;
  }
}

function private function_908fc5a1f259c42c(bundlename) {
  if(!isDefined(bundlename)) {
    return undefined;
  }

  bundle = getscriptbundle(hashcat(%"hash_6c3f91c9ca035a07", bundlename));

  if(!isDefined(bundle) || !isDefined(bundle.var_2fb0e88235a5834f) || bundle.var_2fb0e88235a5834f.size == 0) {
    return undefined;
  }

  var_2fb0e88235a5834f = [];

  foreach(entry in bundle.var_2fb0e88235a5834f) {
    useweapon = scripts\engine\utility::default_to(entry.var_b48a3f44acc6764, "");
    lootname = scripts\engine\utility::default_to(entry.var_77c4f32bb26a1a85, "");
    lootid = scripts\cp_mp\utility\loot::getlootidfromref(lootname);

    if(!isDefined(lootid)) {
      printlog("parseToolUseBundles: cannot find loot id for " + lootname);
      continue;
    }

    settings = spawnStruct();
    settings.lootid = lootid;
    settings.lootname = lootname;
    settings.useweapon = useweapon;
    settings.stances = function_4d102b9311261fd5(entry.stances);
    settings.fovsettings = function_89b3458a046bf612(entry.fovsettings);
    var_2fb0e88235a5834f[var_2fb0e88235a5834f.size] = settings;
  }

  return var_2fb0e88235a5834f;
}

function private function_89b3458a046bf612(data) {
  if(istrue(data.var_e5d42093389bc2fa)) {
    fovsettings = spawnStruct();
    fovsettings.var_e5d42093389bc2fa = 1;
    fovsettings.var_ca93049c5125808c = scripts\engine\utility::default_to(data.var_ca93049c5125808c, 0);
    fovsettings.var_982c3ed6dfe551e5 = scripts\engine\utility::default_to(data.var_982c3ed6dfe551e5, 0);
    fovsettings.var_c02e41f0dc3063fd = scripts\engine\utility::default_to(data.var_c02e41f0dc3063fd, 0);
    fovsettings.var_6350817fe4bb8114 = scripts\engine\utility::default_to(data.var_6350817fe4bb8114, 0);
    return fovsettings;
  }

  return undefined;
}

function private function_4d102b9311261fd5(data) {
  stances = [];

  if(isDefined(data)) {
    stances["stand"] = data.allowsstand;
    stances["crouch"] = data.allowscrouch;
    stances["prone"] = data.allowsprone;
  }

  return stances;
}

function function_a6b3ae56de1dc2c8(useposition, usedurationms, usetext, toolindex, var_2ca0e2098daf8b8d) {
  hintentity = scripts\mp\gameobjects::createhintobject(useposition, "HINT_BUTTON", undefined, usetext, undefined, usedurationms, "show", undefined, 120, 125, 120);
  hintentity.useduration = usedurationms;
  hintentity.toolindex = toolindex;
  hintentity.var_2ca0e2098daf8b8d = var_2ca0e2098daf8b8d;
  level thread function_de3bba90c47cfcf2(hintentity);
}

function private function_de3bba90c47cfcf2(hintentity) {
  level endon("game_ended");
  hintentity endon("death");

  while(true) {
    hintentity waittill("trigger_progress", player);

    if(!isDefined(hintentity.tool_user)) {
      toolsettings = level.tool_use.var_3162ebc254b69b75[hintentity.toolindex];

      if(isDefined(toolsettings) && hintentity function_ee3c484dddf76a86(player, toolsettings)) {
        thread startinteraction(player, hintentity, hintentity.useduration, toolsettings);
        hintentity waittill("use_finished", useresult);

        if(istrue(useresult)) {
          hintentity waittill("use_animation_finished");

          if(istrue(hintentity.var_2ca0e2098daf8b8d)) {
            break;
          }
        }
      }
    }
  }

  hintentity delete();
}

function function_9c3bc425fad907df(scriptableinstance) {
  level endon("game_ended");

  while(!isDefined(level.tool_use) || !istrue(level.tool_use.init)) {
    waitframe();
  }

  if(!isDefined(scriptableinstance) || !isDefined(scriptableinstance.type)) {
    printlog("enableToolInteraction: failed due to invalid self or self.type");
    return;
  }

  toolsettings = level.tool_use.var_a32b4464bd2b3a84[scriptableinstance.type];

  if(!isDefined(toolsettings)) {
    printlog("enableToolInteraction: failed due to invalid toolsettings");
    return;
  }

  partname = toolsettings.usepartname;
  statename = toolsettings.usestatename;

  if(!isDefined(partname) || !isDefined(statename) || !scriptableinstance getscriptableparthasstate(partname, statename)) {
    printlog("enableToolInteraction: failed due to invalid part/state names");
    return;
  }

  scriptableinstance setscriptablepartstate(partname, statename);
  scriptableinstance scripts\cp_mp\interaction::function_98fc2e3f04194a50(&function_92012e88222eb9bf);
  scriptableinstance scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_c25b12b39f2f27d5);

  if(toolsettings.var_2c8f270f17725f28 == "DMZDrillFlow") {
    scriptableinstance namespace_7f114a09d9ee51c3::function_1feb17858cd36268();
  }
}

function function_9ea56c6edd53918(instance, part, state, player, useduration) {
  toolsettings = level.tool_use.var_a32b4464bd2b3a84[instance.type];

  if(!isDefined(toolsettings)) {
    return;
  }

  if(!isDefined(state) || function_1823ff50bb28148d(state) != toolsettings.usestatename) {
    return;
  }

  if(!isDefined(part) || function_1823ff50bb28148d(part) != toolsettings.usepartname) {
    return;
  }

  if(isDefined(instance.tool_user)) {
    return;
  }

  if(!instance function_ee3c484dddf76a86(player, toolsettings)) {
    return;
  }

  instance.isscriptable = 1;
  thread startinteraction(player, instance, useduration, toolsettings);
}

function function_92012e88222eb9bf(scriptable, player) {
  return scriptable function_ee3c484dddf76a86(player);
}

function function_c25b12b39f2f27d5(scriptable, player) {
  toolsettings = level.tool_use.var_a32b4464bd2b3a84[scriptable.type];
  var_e8160f0a47c4c779 = function_df126e61db751279(toolsettings, player);

  if(isDefined(toolsettings)) {
    if(isDefined(var_e8160f0a47c4c779)) {
      if(isDefined(var_e8160f0a47c4c779.stackquantity)) {
        return {
          #params: [var_e8160f0a47c4c779.stackquantity], #string: toolsettings.var_68c5bd011a549dd, #type: "HINT_BUTTON"};
      } else if(function_eb1b65c6da4a9c55()) {
        return {
          #string: toolsettings.var_68c5bd011a549dd, #type: "HINT_BUTTON"};
      }
    } else {
      return {
        #string: toolsettings.var_e2842446eec2f014, #type: "HINT_BUTTON"};
    }

    return;
  }

  return {
    #string: &"MP_DMZ_LOCKS/LOCKED", #type: "HINT_BUTTON"};
}

function function_df126e61db751279(toolsettings, player) {
  if(!isDefined(player) || !isDefined(toolsettings)) {
    return undefined;
  }

  var_56922af9a10f5866 = undefined;
  smalleststackindex = undefined;
  var_185ddeff6f79e975 = undefined;

  if(function_eb1b65c6da4a9c55()) {
    var_56922af9a10f5866 = 0;
  } else {
    foreach(index, entry in toolsettings.var_12db389f0fecd79e) {
      [var_8e43a8e305aaebf4, currquantity] = player namespace_aead94004cf4c147::function_d9749a7ab0c838d3(entry.lootname);

      if(!isDefined(var_8e43a8e305aaebf4)) {
        continue;
      }

      if(!isDefined(var_185ddeff6f79e975) || currquantity < var_185ddeff6f79e975) {
        var_185ddeff6f79e975 = currquantity;
        var_56922af9a10f5866 = index;
        smalleststackindex = var_8e43a8e305aaebf4;
      }
    }
  }

  result = spawnStruct();
  result.stackindex = smalleststackindex;
  result.toolindex = var_56922af9a10f5866;
  result.stackquantity = var_185ddeff6f79e975;
  return result;
}

function function_15237da5e7dc7fe6(instance, player, var_50a96a161eeba9a0, toolsettings) {
  level endon("game_ended");

  if(istrue(instance.isscriptable) && isDefined(toolsettings)) {
    partname = toolsettings.usepartname;
    newstatename = toolsettings.var_dbaa4837728a65f3;

    if(isDefined(partname) && isDefined(newstatename) && instance getscriptableparthasstate(partname, newstatename)) {
      instance setscriptablepartstate(partname, newstatename);
    }
  }

  if(isDefined(instance) && isDefined(instance.var_5fe3b18c69f51bb8)) {
    level thread[[instance.var_5fe3b18c69f51bb8]](instance, player);
  }

  if(isDefined(player) && isDefined(var_50a96a161eeba9a0)) {
    player namespace_aead94004cf4c147::function_db1dd76061352e5b(var_50a96a161eeba9a0, 1);
  }

  instance scripts\cp_mp\interaction::function_98fc2e3f04194a50();
  instance scripts\cp_mp\interaction::function_e6c63f16f2258b80();
  instance waittill("use_animation_finished");

  if(istrue(instance.isscriptable) && instance scriptableislootcache() && !isDefined(instance.opener)) {
    scripts\mp\gametypes\br_lootcache::function_c56e597e3aa81261(instance, player);
  }
}

function private startinteraction(player, instance, useduration, toolsettings) {
  assert(isDefined(toolsettings.var_2c8f270f17725f28));

  switch (toolsettings.var_2c8f270f17725f28) {
    case #"hash_65b4e30dcc739a00":
      function_a3c0c6ebb66b718e(player, instance, useduration, toolsettings);
      break;
    case #"hash_baaeb5714bfa5a09":
      namespace_7f114a09d9ee51c3::function_28fc0d8bad595704(player, instance, useduration, toolsettings);
      break;
    default:
      assertmsg("<dev string:x1c>");
      break;
  }
}

function private function_a3c0c6ebb66b718e(player, instance, useduration, toolsettings) {
  level endon("game_ended");
  assert(isDefined(instance) && !isDefined(instance.tool_user));
  assert(isDefined(player) && isDefined(useduration) && isDefined(toolsettings));
  instance.tool_user = player;
  instance function_35e3d48918b548bc(0, instance.tool_user);
  var_e8160f0a47c4c779 = function_df126e61db751279(toolsettings, player);
  assert(isDefined(var_e8160f0a47c4c779));
  var_643cb175c27e8967 = toolsettings.var_12db389f0fecd79e[var_e8160f0a47c4c779.toolindex];
  assert(isDefined(var_643cb175c27e8967));
  lootname = var_643cb175c27e8967.lootname;
  useweaponname = var_643cb175c27e8967.useweapon;
  player function_bffd72a3766031d2(1, var_643cb175c27e8967.stances);
  player thread function_d8106ff3211f102d(instance, toolsettings);
  useweapon = makeweapon(useweaponname);
  assert(isDefined(useweapon));
  player thread function_7db3f060257e57ca(useweapon, toolsettings, var_643cb175c27e8967);
  player thread function_38e09559680e7d91(var_e8160f0a47c4c779.stackindex, lootname, 1);
  useresult = function_bac176a6bce74e7b(player, instance, useduration);
  instance notify("use_finished", useresult);

  if(istrue(useresult)) {
    thread function_15237da5e7dc7fe6(instance, player, var_e8160f0a47c4c779.stackindex, toolsettings);
    player thread function_38e09559680e7d91(var_e8160f0a47c4c779.stackindex, lootname, 1);
  }

  instance function_9f662288c13b7217(0, instance.tool_user);
  var_9a456461b47468e4 = isDefined(var_e8160f0a47c4c779.stackquantity) && var_e8160f0a47c4c779.stackquantity == 1;
  player thread function_a1d7b3bec1fdac12(useweapon, useresult, var_9a456461b47468e4, var_643cb175c27e8967);
  player function_60894d03ab457534(useweapon);

  if(isDefined(player)) {
    player unlink();

    if(isDefined(self.linktoent)) {
      player.linktoent delete();
      player.linktoent = undefined;
    }

    player function_bffd72a3766031d2(0);
    player thread function_38e09559680e7d91(var_e8160f0a47c4c779.stackindex, lootname, 0);
  }

  instance.tool_user = undefined;
  instance function_35e3d48918b548bc(1);
  instance notify("use_animation_finished");
}

function function_bac176a6bce74e7b(player, instance, useduration) {
  level endon("game_ended");
  holdtime = 0;

  while(true) {
    if(!isDefined(player) || !isalive(player) || !isDefined(instance) || !player useButtonPressed()) {
      break;
    }

    if(holdtime >= useduration) {
      return true;
    }

    holdtime += level.framedurationseconds * 1000;
    waitframe();
  }

  return false;
}

function private function_7db3f060257e57ca(useweapon, toolsettings, var_643cb175c27e8967) {
  if(!isDefined(useweapon)) {
    return;
  }

  lastweapon = self getcurrentweapon();
  assert(isDefined(lastweapon));
  switchimmediate = 0;

  if(lastweapon == useweapon) {
    assert(isDefined(self.lastnonuseweapon));
    lastweapon = self.lastnonuseweapon;
  }

  assert(lastweapon != useweapon);
  self.lastnonuseweapon = lastweapon;
  setammo = 0;
  _giveweapon(useweapon, undefined, undefined, 0);
  self setweaponammostock(useweapon, setammo);
  self setweaponammoclip(useweapon, setammo);
  thread scripts\mp\gameobjects::switchtouseweapon(useweapon, switchimmediate);
  thread function_4b2a64d118730cb7(var_643cb175c27e8967);
  function_1652909a360b82eb(toolsettings);
}

function private function_1652909a360b82eb(toolsettings) {
  if(!isDefined(toolsettings)) {
    return;
  }

  if(istrue(toolsettings.var_1652909a360b82eb)) {
    self setentitysoundcontext(toolsettings.var_93b9ec961aa25883, toolsettings.var_4883db9641b2fef8);
  }
}

function private function_a1d7b3bec1fdac12(useweapon, useresult, lastuse, var_643cb175c27e8967) {
  if(!isDefined(useweapon)) {
    return;
  }

  var_c9f07c0481b9634a = 1;

  if(istrue(useresult)) {
    setammo = ter_op(istrue(lastuse), 0, 1);
    self setweaponammostock(useweapon, setammo);
    self setweaponammoclip(useweapon, setammo);
    var_c9f07c0481b9634a = 0;
  }

  if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(useweapon)) {
    abortmonitoredweaponswitch(useweapon);
  } else {
    var_efcc85f1a7d3a7db = self gethighpriorityweapon();

    if(isDefined(var_efcc85f1a7d3a7db) && var_efcc85f1a7d3a7db == useweapon) {
      self clearhighpriorityweapon(var_efcc85f1a7d3a7db);
    }

    thread getridofweapon(useweapon, var_c9f07c0481b9634a);
  }

  thread resetplayerfov(useresult, var_643cb175c27e8967);
}

function private function_4b2a64d118730cb7(var_643cb175c27e8967) {
  level endon("game_ended");

  if(!isDefined(var_643cb175c27e8967) || !isDefined(var_643cb175c27e8967.fovsettings)) {
    return;
  }

  fovsettings = var_643cb175c27e8967.fovsettings;

  if(!istrue(fovsettings.var_e5d42093389bc2fa)) {
    return;
  }

  waittime = fovsettings.var_ca93049c5125808c / 1000;
  lerpduration = fovsettings.var_982c3ed6dfe551e5 / 1000;
  wait waittime;

  if(isDefined(self)) {
    self lerpfovscalefactor(0, lerpduration);
  }
}

function private resetplayerfov(useresult, var_643cb175c27e8967) {
  level endon("game_ended");

  if(!isDefined(var_643cb175c27e8967) || !isDefined(var_643cb175c27e8967.fovsettings)) {
    return;
  }

  fovsettings = var_643cb175c27e8967.fovsettings;

  if(!istrue(fovsettings.var_e5d42093389bc2fa)) {
    return;
  }

  waittime = 0;
  lerpduration = 0.2;

  if(istrue(useresult)) {
    waittime = fovsettings.var_c02e41f0dc3063fd / 1000;
    lerpduration = fovsettings.var_6350817fe4bb8114 / 1000;
  }

  wait waittime;

  if(isDefined(self)) {
    self lerpfovscalefactor(1, lerpduration);
  }
}

function private function_60894d03ab457534(useweapon) {
  level endon("game_ended");

  while(true) {
    if(!istrue(self.connected) || !isalive(self)) {
      break;
    }

    weapon = self getcurrentweapon();

    if(!isDefined(weapon) || !isDefined(useweapon) || weapon != useweapon) {
      break;
    }

    waitframe();
  }
}

function function_ee3c484dddf76a86(player, toolsettings) {
  if(!isDefined(player)) {
    return false;
  }

  if(function_eb1b65c6da4a9c55()) {
    return true;
  }

  if(!isDefined(toolsettings)) {
    if(isDefined(self.type)) {
      toolsettings = level.tool_use.var_a32b4464bd2b3a84[self.type];
    } else {
      toolsettings = level.tool_use.var_3162ebc254b69b75[self.toolindex];
    }
  }

  if(!isDefined(toolsettings)) {
    return false;
  }

  foreach(entry in toolsettings.var_12db389f0fecd79e) {
    if(player namespace_aead94004cf4c147::function_36b1968bfe78916b(entry.lootid)) {
      return true;
    }
  }

  return false;
}

function function_35e3d48918b548bc(toggleon, excludeplayer) {
  foreach(player in level.players) {
    if(!isDefined(player) || !isalive(player)) {
      continue;
    }

    if(isDefined(excludeplayer) && player == excludeplayer) {
      continue;
    }

    function_9f662288c13b7217(toggleon, player);
  }
}

function private function_9f662288c13b7217(toggleon, player) {
  assert(isDefined(player));

  if(istrue(self.isscriptable)) {
    if(toggleon) {
      self enablescriptableplayeruse(player);
    } else {
      self disablescriptableplayeruse(player);
    }

    return;
  }

  if(toggleon) {
    self enableplayeruse(player);
    return;
  }

  self disableplayeruse(player);
}

function private function_bffd72a3766031d2(var_8fda2f947e5c9e14, var_6edcc4c0efa28272) {
  controls = ["allow_movement", "allow_jump", "melee", "offhand_primary_weapons", "offhand_secondary_weapons", "crouch", "prone", "stand"];

  if(istrue(var_8fda2f947e5c9e14)) {
    currstance = self getstance();
    assert(isDefined(currstance));
    desiredstance = ter_op(isDefined(var_6edcc4c0efa28272) && istrue(var_6edcc4c0efa28272[currstance]), currstance, "stand");

    switch (desiredstance) {
      case #"hash_c6775c88e38f7803":
        controls = array_remove(controls, "stand");
        break;
      case #"hash_d91940431ed7c605":
        controls = array_remove(controls, "prone");
        break;
      case #"hash_3fed0cbd303639eb":
        controls = array_remove(controls, "crouch");
        break;
      default:
        break;
    }

    val::set_array("exgm_tool_interaction", controls, 0);
    return;
  }

  val::reset_array("exgm_tool_interaction", controls);
}

function private function_d8106ff3211f102d(scriptable, toolsettings) {
  assert(isDefined(toolsettings) && isDefined(scriptable));
  scriptable endon("use_animation_finished");
  [playerorigin, playerangles] = function_8443dcfc48098ab6(scriptable, toolsettings);

  if(distancesquared(playerorigin, self.origin) >= squared(0.1)) {
    playerorigindropped = player_drop_to_ground(playerorigin, 15, 60, -60);
    playerorigin = (playerorigin[0], playerorigin[1], playerorigindropped[2]);
  }

  self.linktoent = spawn_tag_origin(self.origin, self.angles);
  self playerlinktodelta(self.linktoent, "tag_origin", 1, 0, 0, 0, 0, 1);
  movetime = getdvarfloat(@ "hash_a36bc8fcbb54637f", 0.3);
  self.linktoent moveTo(playerorigin, movetime);
  self.linktoent rotateTo(playerangles, movetime);
  wait movetime;

  if(isDefined(self)) {
    self setOrigin(playerorigin);
    self setplayerangles(playerangles);
  }
}

function function_8443dcfc48098ab6(scriptable, toolsettings) {
  assert(isDefined(toolsettings) && isDefined(scriptable));
  playerorigin = self.origin;
  playerangles = self.angles;

  if(istrue(toolsettings.var_3c1a3a6d974c9683)) {
    playerorigin = scriptable.origin + rotatevector(toolsettings.usepositionoffset, scriptable.angles);
  }

  if(istrue(toolsettings.var_78003ee028921cf3)) {
    playerangles = combineangles(scriptable.angles, toolsettings.useangles);
  }

  return [playerorigin, playerangles];
}

function private function_4258c140bef4fdab(remainingusecount, maxusecount, var_2bb24aa5b6557593) {
  infoarray = 0;

  if(!isDefined(remainingusecount)) {
    remainingusecount = 0;
  }

  if(!isDefined(maxusecount)) {
    maxusecount = 0;
  }

  if(isDefined(var_2bb24aa5b6557593)) {
    if(istrue(var_2bb24aa5b6557593)) {
      var_2bb24aa5b6557593 = 1;
    } else {
      var_2bb24aa5b6557593 = 0;
    }
  } else {
    var_2bb24aa5b6557593 = 0;
  }

  infoarray |= remainingusecount << 0;
  infoarray |= maxusecount << 4;
  infoarray |= var_2bb24aa5b6557593 << 8;
  self setclientomnvar("ui_tool_use_info", int(infoarray));
}

function private function_2e7de122fc7cd023() {
  return isDefined(level.gamemodebundle) && istrue(level.gamemodebundle.var_51fe99dfa5384b12);
}

function private function_38e09559680e7d91(backpackstackindex, var_c94ffa886eb2612e, var_2bb24aa5b6557593) {
  if(!function_2e7de122fc7cd023() || !isDefined(backpackstackindex) || !isDefined(var_c94ffa886eb2612e)) {
    return;
  }

  remainingusecount = namespace_aead94004cf4c147::function_897b29adb37f06a7(backpackstackindex);

  if(!isDefined(remainingusecount)) {
    return;
  }

  var_9c994389856e9b10 = namespace_aead94004cf4c147::function_dee7316da051a630(var_c94ffa886eb2612e);

  if(!isDefined(var_9c994389856e9b10)) {
    return;
  }

  if(istrue(var_2bb24aa5b6557593)) {
    function_4258c140bef4fdab(remainingusecount, var_9c994389856e9b10, 1);
    return;
  }

  function_4258c140bef4fdab(0, 0, 0);
}

function private function_eb1b65c6da4a9c55() {
  return isDefined(level.tool_use) && istrue(level.tool_use.var_833ab01147ed4eba);
}

function private function_cc974f6066708dc9(vector, default_vector) {
  if(!isDefined(vector)) {
    return default_vector;
  }

  return (scripts\engine\utility::default_to(vector.x, default_vector[0]), scripts\engine\utility::default_to(vector.y, default_vector[1]), scripts\engine\utility::default_to(vector.z, default_vector[2]));
}

function private printlog(text) {
  println("<dev string:x5d>" + text);
}

function private init_debug() {
  level endon("<dev string:x7a>");

  while(true) {
    if(getdvarint(@ "hash_49a67262a39b39ab", -1) >= 0) {
      toolindex = getdvarint(@ "hash_49a67262a39b39ab", -1);
      setDvar(@ "hash_49a67262a39b39ab", -1);
      level thread function_5df9ee7cc2ee2ece(toolindex);
    }

    if(getdvarint(@ "hash_fccff3252f2106a5", 0) >= 1) {
      level thread function_7084e044e0ba070a();
    }

    waitframe();
  }
}

function private function_5df9ee7cc2ee2ece(toolindex) {
  playerorigin = level.players[0].origin;
  playerforward = anglesToForward(level.players[0].angles);
  var_c35db60fca6b4eb7 = (playerforward[0], playerforward[1], 0);
  playerup = (0, 0, 1);
  useposition = playerorigin + var_c35db60fca6b4eb7 * 50 + playerup * 35;
  usedurationms = 3000;
  usetext = &"<dev string:x88>";
  var_2ca0e2098daf8b8d = 1;
  function_a6b3ae56de1dc2c8(useposition, usedurationms, usetext, toolindex, var_2ca0e2098daf8b8d);
}

function private function_c1c6eddd67bf7457(player, weapon, var_2feb0814d8b653e0) {
  if(isDefined(weapon)) {
    return [var_2feb0814d8b653e0, function_7b2b4dc5f3dfb2c9(weapon), player iscurrentweapon(weapon), player isswitchingtoweaponwithmonitoring(weapon)];
  }

  return [var_2feb0814d8b653e0, "<dev string:x9f>", "<dev string:x9f>", "<dev string:x9f>"];
}

function private function_7084e044e0ba070a() {
  player = level.players[0];

  if(!isDefined(player)) {
    return;
  }

  offsety = 20;
  debugposx = 50;
  debugposy = 500;
  debugtextcolor = (0, 1, 0);
  debugtextscale = 1;
  var_9712576966b33c8b = 1;
  tabletitle = "<dev string:xaa>";
  var_cd8110645a9a2632 = ["<dev string:xb9>", "<dev string:xc9>", "<dev string:xd7>", "<dev string:xea>"];
  var_871bdbc7e5abb341 = [];
  var_871bdbc7e5abb341[0] = function_c1c6eddd67bf7457(player, player getcurrentweapon(), "<dev string:x10f>");
  var_871bdbc7e5abb341[1] = function_c1c6eddd67bf7457(player, player getcurrentmonitoredweaponswitchweapon(), "<dev string:x123>");
  var_871bdbc7e5abb341[2] = function_c1c6eddd67bf7457(player, player gethighpriorityweapon(), "<dev string:x14c>");
  tablesize = namespace_36be7f9eab6ca7bc::function_b1ea22d278623807(debugposx, debugposy, tabletitle, var_cd8110645a9a2632, var_871bdbc7e5abb341, debugtextcolor, debugtextscale, var_9712576966b33c8b);
  debugposy += tablesize[1];
  debugtext = "<dev string:x165>" + player isanymonitoredweaponswitchinprogress();
  printtoscreen2d(debugposx, debugposy, debugtext, debugtextcolor, debugtextscale, var_9712576966b33c8b);
  debugposy += offsety;
}

# /
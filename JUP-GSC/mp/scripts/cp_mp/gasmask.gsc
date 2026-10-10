/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\gasmask.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\white_phosphorus;
#using scripts\cp_mp\utility\loot;
#using scripts\engine\utility;
#namespace gasmask;

function init(gasmaskhealth, gasmasktype, gasmaskmaxhealth) {
  var_e7cdf2f6d8feb3 = 2;

  if(isDefined(gasmasktype)) {
    if(gasmasktype == "brloot_equip_gasmask_scuba") {
      var_e7cdf2f6d8feb3 = 4;
      self.usingscubagasmask = 1;

      if(self isswimunderwater()) {
        function_f3bb4f4911a1beb2("scubaGasMask", "updateScubaGasmask", self, 1);
      }
    } else {
      if(istrue(self.usingscubagasmask)) {
        self.usingscubagasmask = undefined;
        function_f3bb4f4911a1beb2("scubaGasMask", "updateScubaGasmask", self, 0);
      }

      if(gasmasktype == "brloot_equip_gasmask_durable" || gasmasktype == "gas_mask_durable") {
        var_e7cdf2f6d8feb3 = 3;
      }
    }
  } else {
    self.usingscubagasmask = undefined;
  }

  isbr = issharedfuncdefined("game", "isBRStyleGameType") && [[getsharedfunc("game", "isBRStyleGameType")]]();

  if(!isDefined(level.gasmask_resist)) {
    if(isDefined(level.gametypebundle.var_1609c0ff0b876e9f)) {
      level.gasmask_resist = level.gametypebundle.var_1609c0ff0b876e9f;
    } else if(isbr) {
      level.gasmask_resist = getdvarfloat(@ "hash_3ddd1d0a30b7b07c", 0);
    } else {
      level.gasmask_resist = 0.2;
    }
  }

  maxhealth = ter_op(isDefined(gasmaskmaxhealth), gasmaskmaxhealth, getmaxhealth(gasmasktype));
  self.gasmaskhealth = maxhealth;
  self.gasmaskmaxhealth = maxhealth;
  self.gasmasktype = ter_op(isDefined(gasmasktype), gasmasktype, "brloot_equip_gasmask");
  self.headgeartype = "gas_mask";

  if(istrue(self.usingscubagasmask)) {
    thread function_f3bb4f4911a1beb2("scubaGasMask", "monitorScubaGasMaskDamage");
  }

  if(isDefined(gasmaskhealth)) {
    self.gasmaskhealth = gasmaskhealth;
  }

  if(isbr) {
    level.gasmaskhealthperpip = self.gasmaskhealth / 6;
  }

  level.gasmaskmaxhealth = maxhealth;
  self setclientomnvar("ui_head_equip_class", var_e7cdf2f6d8feb3);
  self setclientomnvar("ui_gasmask_damage", self.gasmaskhealth / maxhealth);
}

function ai_init() {
  self.has_gasmask = 1;
  self.gasmaskhealth = 180;
  mask_model = spawn("script_model", (0, 0, 0));
  mask_model setModel("hat_gasmask");
  mask_model linkTo(self, "j_head", (7, 0, 0), (0, 0, 0));
  self.gasmask = mask_model;
  function_c9d4cf3c20195afa(mask_model);
}

function function_c9d4cf3c20195afa(mask) {
  self waittill("death");

  if(isDefined(mask)) {
    mask unlink();
    mask hide();
  }
}

function getmaxhealth(var_1680a35fe50dc05e) {
  maxhealth = undefined;
  isbr = issharedfuncdefined("game", "isBRStyleGameType") && [[getsharedfunc("game", "isBRStyleGameType")]]();

  if(isDefined(var_1680a35fe50dc05e)) {
    if(isbr) {
      var_d7254484f0bd62f = level.br_pickups.counts[var_1680a35fe50dc05e];

      if(isDefined(var_d7254484f0bd62f)) {
        maxhealth = var_d7254484f0bd62f;
      } else {
        switch (var_1680a35fe50dc05e) {
          case #"hash_d01e387e6d238502":
            maxhealth = 200;
            break;
          default:
            break;
        }
      }
    } else {
      switch (var_1680a35fe50dc05e) {
        case #"hash_d01e387e6d238502":
          maxhealth = 200;
          break;
        default:
          break;
      }
    }
  }

  if(!isDefined(maxhealth)) {
    if(isbr) {
      maxhealth = getdvarint(@ "hash_acad4ff93022ff44", 100);
    } else {
      maxhealth = 180;
    }
  }

  return maxhealth;
}

function getscriptablename(var_d5f96a53f7f4002e) {
  var_1680a35fe50dc05e = undefined;

  switch (var_d5f96a53f7f4002e) {
    case #"hash_2d1a1b811aed6b26":
    case #"hash_4808e1f340e11163":
    case #"hash_dcf82d1f65a6b16e":
      var_1680a35fe50dc05e = "brloot_equip_gasmask";
      break;
    case #"hash_d01e387e6d238502":
      var_1680a35fe50dc05e = "brloot_equip_gasmask_durable";
      break;
    default:
      break;
  }

  return var_1680a35fe50dc05e;
}

function processdamage(damage) {
  if(isDefined(level.var_5ae6eccb437278eb) && istrue([[level.var_5ae6eccb437278eb]](self))) {
    return;
  }

  if(!isDefined(self.gasmaskhealth) || !isDefined(self.gasmaskmaxhealth)) {
    return;
  }

  isbr = issharedfuncdefined("game", "isBRStyleGameType") && [[getsharedfunc("game", "isBRStyleGameType")]]();
  var_c8898166ad0dccc9 = self.gasmaskhealth / self.gasmaskmaxhealth;
  self.gasmaskhealth -= damage;
  self.gasmaskhealth = int(max(0, self.gasmaskhealth));

  if(isbr) {
    var_b8b6fa3d6f2f0b8c = (self.gasmaskhealth + 1) / self.gasmaskmaxhealth;
  } else {
    var_b8b6fa3d6f2f0b8c = self.gasmaskhealth / self.gasmaskmaxhealth;
  }

  var_b8b6fa3d6f2f0b8c = clamp(var_b8b6fa3d6f2f0b8c, 0, 1);
  self setclientomnvar("ui_gasmask_damage", var_b8b6fa3d6f2f0b8c);

  if(istrue(self.var_ca27f3fd3dad0c1f)) {
    self setclientomnvar("loot_container_quantity_0", self.gasmaskhealth);
  }

  if(istrue(level.gametypebundle.var_c837fd49542eec31)) {
    if(self.gasmaskhealth <= self.gasmaskmaxhealth * level.gametypebundle.var_664628601763fe81 && self.gasmaskhealth + damage >= self.gasmaskmaxhealth * level.gametypebundle.var_664628601763fe81) {
      setbrokenoverlaymaterial("gasmask_overlay_delta2_crack_stage1");
    } else if(self.gasmaskhealth <= self.gasmaskmaxhealth * level.gametypebundle.var_459c1608ab5e08b && self.gasmaskhealth + damage >= self.gasmaskmaxhealth * level.gametypebundle.var_459c1608ab5e08b) {
      setbrokenoverlaymaterial("gasmask_overlay_delta2_crack_stage2");
    }
  }

  if(self.gasmaskhealth <= 0) {
    if(isDefined(level.headgeardata) && isDefined(level.headgeardata.gear["gas_mask"])) {
      utility::function_f3bb4f4911a1beb2("headgear", "breakHeadGear", "gas_mask");
    } else if(isbr && issharedfuncdefined("gasmask", "breakGasMaskBR")) {
      self[[getsharedfunc("gasmask", "breakGasMaskBR")]]();
    } else if(isDefined(level.var_f929c426097f1647)) {
      self[[level.var_f929c426097f1647]]();
    } else {
      breakgasmask();
    }

    if(istrue(self.var_ca27f3fd3dad0c1f)) {
      utility::function_f3bb4f4911a1beb2("headgear", "resetGasMaskRemovalDelay");

      if(isDefined(self.var_2fa5b49969def47) && self.var_2fa5b49969def47.contents.size > 0) {
        self.var_2fa5b49969def47.contents[0]["quantity"] = 0;
      }

      utility::function_f3bb4f4911a1beb2("game", "closeLootableContainer", self.var_2fa5b49969def47, self);
    }
  } else if(isbr) {
    var_d89463b5f4f6be0c = floor(var_c8898166ad0dccc9 * 6 + 0.5);
    var_14642d90cc419ff7 = floor(var_b8b6fa3d6f2f0b8c * 6 + 0.5);

    if(var_d89463b5f4f6be0c > var_14642d90cc419ff7) {
      self playsoundtoplayer("br_gas_mask_crack_plr", self);
    }
  }

  if(!isDefined(self.gasdamagebuffer)) {
    self.gasdamagebuffer = 0;
  }

  assertex(isDefined(level.gasmask_resist), "<dev string:x1c>");
  self.gasdamagebuffer += damage * level.gasmask_resist;
  damagetoplayer = floor(self.gasdamagebuffer);

  if(damagetoplayer >= 1) {
    self dodamage(damagetoplayer, self.origin, self, undefined, "MOD_TRIGGER_HURT");
    self.gasdamagebuffer -= damagetoplayer;
  }
}

function function_4262ecea32819701(damage) {
  self.gasmaskhealth -= damage;
  self.gasmaskhealth = max(0, self.gasmaskhealth);

  if(self.gasmaskhealth <= 0) {
    if(isDefined(self.gasmask)) {
      self.gasmask unlink();
      self.gasmask hide();
      self.has_gasmask = 0;
    }
  }
}

function didgasmaskpipschange(oldhealth, newhealth) {
  isbr = issharedfuncdefined("game", "isBRStyleGameType") && [[getsharedfunc("game", "isBRStyleGameType")]]();

  if(!isbr) {
    return false;
  }

  if(!isDefined(self.gasmaskmaxhealth)) {
    self.gasmaskmaxhealth = getdvarint(@ "hash_acad4ff93022ff44", 100);
  }

  oldhealthpercentage = oldhealth / self.gasmaskmaxhealth;
  newhealthpercentage = newhealth / self.gasmaskmaxhealth;
  var_d89463b5f4f6be0c = floor(oldhealthpercentage * 6 + 0.5);
  var_14642d90cc419ff7 = floor(newhealthpercentage * 6 + 0.5);
  return var_d89463b5f4f6be0c != var_14642d90cc419ff7;
}

function equipgasmask() {
  self endon("death_or_disconnect");
  self playsoundtoplayer("br_gas_mask_on_plr", self);
  weaponnone = makeweapon("none");
  curweap = self getcurrentweapon();

  if(!issameweapon(curweap, weaponnone)) {
    if(utility::iscp()) {
      self forceplaygestureviewmodel("ges_magma_gas_mask_on");
    } else {
      self forceplaygestureviewmodel("ges_visor_down");
    }
  }

  self.gasmaskswapinprogress = 1;
  wait 0.338;
  self.gasmaskswapinprogress = 0;
  self.gasmaskequipped = 1;
  scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudiosupression();
  self attach("hat_gasmask");
  self.var_def787c3aedbce76 = 1;
  createoverlay();

  if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
    self function_555e2d32e2756625("gasmask_female");
  } else {
    self function_555e2d32e2756625("gasmask_male");
  }

  self notify("gasmask_equipped");
}

function removegasmask() {
  self endon("death_or_disconnect");

  if(!istrue(self.gasmaskequipped)) {
    return;
  }

  self playsoundtoplayer("br_gas_mask_off_plr", self);
  weaponnone = makeweapon("none");
  curweap = self getcurrentweapon();

  if(!issameweapon(curweap, weaponnone)) {
    if(utility::iscp()) {
      self forceplaygestureviewmodel("ges_magma_gas_mask_off");
    } else {
      self forceplaygestureviewmodel("ges_visor_up");
    }
  }

  self.gasmaskswapinprogress = 1;
  wait 0.521;
  self.gasmaskswapinprogress = 0;
  self.gasmaskequipped = 0;
  scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudiosupression();

  if(istrue(self.var_def787c3aedbce76)) {
    self detach("hat_gasmask");
    self.var_def787c3aedbce76 = undefined;
  }

  destroyoverlay();

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref) && self.operatorcustomization.skinref + "" == "355") {
    self function_555e2d32e2756625("gasmask_female");
  } else if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
    self function_555e2d32e2756625("female");
  } else if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref) && self.operatorcustomization.skinref + "" == "319") {
    self setentitysoundcontext("gender", "bongmask_male");
  } else if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref) && self.operatorcustomization.skinref + "" == "319") {
    self setentitysoundcontext("gender", "bongmask_male");
  } else {
    self function_555e2d32e2756625("");
  }

  self notify("gasmask_unequipped");
}

function breakgasmask() {
  if(!istrue(self.gasmaskequipped)) {
    return;
  }

  self.gasmaskequipped = 0;
  self playsoundtoplayer("br_gas_mask_break_plr", self);

  if(istrue(self.var_def787c3aedbce76)) {
    self detach("hat_gasmask");
    self.var_def787c3aedbce76 = undefined;
  }

  destroyoverlay();

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref) && self.operatorcustomization.skinref + "" == "355") {
    self function_555e2d32e2756625("gasmask_female");
  } else if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
    self function_555e2d32e2756625("female");
  } else if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref) && self.operatorcustomization.skinref + "" == "319") {
    self setentitysoundcontext("gender", "bongmask_male");
  } else if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref) && self.operatorcustomization.skinref + "" == "597") {
    self setentitysoundcontext("gender", "bongmask_male");
  } else {
    self function_555e2d32e2756625("");
  }

  self playsoundtoplayer("br_gas_mask_depleted_plr", self);
  self setclientomnvar("ui_head_equip_class", 0);
  self setclientomnvar("ui_gasmask_damage", 0);
  self notify("gasmask_unequipped");
}

function createoverlay(fadeintime, delaytime) {
  self.gasmaskoverlay = newclienthudelem(self);
  self.gasmaskoverlay.x = 0;
  self.gasmaskoverlay.y = 0;
  self.gasmaskoverlay.alignx = "left";
  self.gasmaskoverlay.aligny = "top";
  self.gasmaskoverlay.horzalign = "fullscreen";
  self.gasmaskoverlay.vertalign = "fullscreen";
  self.gasmaskoverlay setshader("gasmask_overlay_delta2", 640, 480);
  self.gasmaskoverlay.sort = -10;
  self.gasmaskoverlay.archived = 1;
  self.gasmaskoverlay.scramblerdisabled = 1;

  if(issharedfuncdefined("game", "isBRStyleGameType")) {
    if([[getsharedfunc("game", "isBRStyleGameType")]]()) {
      self.gasmaskoverlay.alpha = 0;

      if(isDefined(fadeintime)) {
        if(isDefined(delaytime)) {
          wait delaytime;
        }

        if(isDefined(self.gasmaskoverlay)) {
          self.gasmaskoverlay fadeovertime(fadeintime);
        }
      }
    }
  }

  if(istrue(level.gametypebundle.var_c837fd49542eec31)) {
    if(self.gasmaskhealth <= self.gasmaskmaxhealth * level.gametypebundle.var_459c1608ab5e08b) {
      setbrokenoverlaymaterial("gasmask_overlay_delta2_crack_stage2");
    } else if(self.gasmaskhealth <= self.gasmaskmaxhealth * level.gametypebundle.var_664628601763fe81) {
      setbrokenoverlaymaterial("gasmask_overlay_delta2_crack_stage1");
    }
  }

  if(isDefined(self.gasmaskoverlay)) {
    self.gasmaskoverlay.alpha = 1;
    self.gasmaskoverlay.lowresbackground = 1;
  }
}

function setbrokenoverlaymaterial(material) {
  if(isDefined(self.gasmaskoverlay)) {
    if(isDefined(material)) {
      self.gasmaskoverlay setshader(material, 640, 480);
      return;
    }

    self.gasmaskoverlay setshader("gasmask_overlay_delta2_broken", 640, 480);
  }
}

function fadeoutoverlay(fadeouttime) {
  self.gasmaskoverlay.alpha = 1;
  self.gasmaskoverlay fadeovertime(fadeouttime);
  self.gasmaskoverlay.alpha = 0;
}

function destroyoverlay(fadeouttime, delaytime) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(!isDefined(self.gasmaskoverlay)) {
    return;
  }

  if(isDefined(fadeouttime)) {
    if(isDefined(delaytime)) {
      wait delaytime;
    }

    if(isDefined(self.gasmaskoverlay)) {
      fadeoutoverlay(fadeouttime);
      wait fadeouttime;
    }
  }

  if(isDefined(self.gasmaskoverlay)) {
    self.gasmaskoverlay destroy();
    self.gasmaskoverlay = undefined;
  }
}

function hasgasmask(player) {
  return isDefined(player.gasmaskhealth);
}

function function_260708c89a11f0c3(player) {
  return istrue(player.gasmaskequipped);
}

function function_27e68abe09612a13(player) {
  return isDefined(player.gasmaskhealth) && player.gasmaskhealth > 0;
}

function function_385d397d3fab6715(player) {
  if(hasgasmask(player)) {
    return player.gasmasktype;
  }

  return undefined;
}

function function_2bcab76045fdd1fa(player) {
  if(function_27e68abe09612a13(player)) {
    return player.gasmaskhealth;
  }

  return 0;
}

function function_d036366985435d3(player, pickupent) {
  if(!isDefined(player.gasmaskhealth) || self.gasmaskhealth == 0) {
    return true;
  }

  return pickupent.count > self.gasmaskhealth;
}

function function_58687e8e71126788() {
  self.gasmaskmaxhealth = undefined;
  self.gasmaskhealth = undefined;
  self.var_fe63300b318b76b0 = undefined;
  self setclientomnvar("ui_gas_mask", 0);
  self setclientomnvar("ui_head_equip_class", 0);
  self setclientomnvar("ui_gasmask_damage", 0);
}

function private function_5cca4d88774d105c() {
  if(self isthrowinggrenade() || self ismeleeing() || self isdiving() || self function_9cc921a57ff4deb5() || self isonladder() || self[[scripts\engine\utility::getsharedfunc("player", "isPlayerADS")]]()) {
    return false;
  }

  return true;
}

function private function_68d0674be04effcf() {
  if(istrue(self function_6dc7592b72983dc0())) {
    return false;
  }

  if(istrue(self.var_893c74118f0f4c3e)) {
    return false;
  }

  if(!utility::function_f3bb4f4911a1beb2("player", "isAliveAndNotInLastStand", self)) {
    return false;
  }

  if(!utility::function_f3bb4f4911a1beb2("game", "isBackpackInventoryEnabled")) {
    return false;
  }

  if(istrue(self.gasmaskswapinprogress)) {
    return false;
  }

  if(utility::function_f3bb4f4911a1beb2("game", "isContainerOpen", self)) {
    return false;
  }

  if(isDefined(self.var_f7ff6a8d6c6a2804) && self.var_f7ff6a8d6c6a2804 > gettime()) {
    return false;
  }

  if(!function_5cca4d88774d105c()) {
    return false;
  }

  return true;
}

function private function_960e55afc8644ee5() {
  backpacksize = utility::function_f3bb4f4911a1beb2("game", "getPlayerBackpackSize", self);
  var_f4d1d255166d0b8a = 0;
  var_a58c1fca5d8a5b2 = undefined;

  for(index = 0; index < backpacksize; index++) {
    lootid = utility::function_f3bb4f4911a1beb2("game", "getLootIDAtBackpackIndex", index);

    if(lootid != 0) {
      scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);

      if(utility::function_f3bb4f4911a1beb2("game", "isGasMask", scriptablename) && !issubstr(scriptablename, "scuba")) {
        var_f4d1d255166d0b8a = 1;
        var_a58c1fca5d8a5b2 = index;

        if(scriptablename == "brloot_equip_gasmask_durable") {
          break;
        }
      }
    }
  }

  if(var_f4d1d255166d0b8a) {
    thread utility::function_f3bb4f4911a1beb2("game", "equipBackpackItem", var_a58c1fca5d8a5b2);
    self.var_f7ff6a8d6c6a2804 = gettime() + 1660;
    return true;
  }

  return false;
}

function private function_d143d66d458e4cab() {
  lootid = self.gasmasktype == "brloot_equip_gasmask_durable" ? utility::function_f3bb4f4911a1beb2("game", "getGasMaskLootID", "brloot_equip_gasmask_durable") : utility::function_f3bb4f4911a1beb2("game", "getGasMaskLootID", "brloot_equip_gasmask");
  quantity = int(self.gasmaskhealth);

  if(utility::function_f3bb4f4911a1beb2("game", "getBagTypeForPlayer", self) != "bgfull") {
    if(function_27e68abe09612a13(self)) {
      utility::function_f3bb4f4911a1beb2("game", "lootItem", lootid, quantity, undefined, 1, 1, 1);
    }

    thread utility::function_f3bb4f4911a1beb2("game", "quickDropGasMaskItem", self, 1);
    self.var_f7ff6a8d6c6a2804 = gettime() + 1660;
    return true;
  }

  return false;
}

function function_156ee9d604eac35c() {
  self endon("disconnect");
  self notify("monitorGasMaskInputSwap");
  self endon("monitorGasMaskInputSwap");

  if(isai(self) || getdvarint(@ "hash_6abec80390cd0d0e", 0) == 1) {
    return;
  }

  waitframe();
  self notifyonplayercommand("attemptSwapGasMask", "gas_mask_toggle");
  thread function_1dd66b55d430e603();

  while(true) {
    self waittill("attemptSwapGasMask");

    if(getdvarint(@ "hash_6abec80390cd0d0e", 0) == 1) {
      waitframe();
      continue;
    }

    if(!function_68d0674be04effcf()) {
      waitframe();
      continue;
    }

    if(hasgasmask(self)) {
      if(!function_d143d66d458e4cab()) {
        waitframe();
        continue;
      }
    } else if(!function_960e55afc8644ee5()) {
      waitframe();
      continue;
    }

    self.var_893c74118f0f4c3e = 1;
    utility::waittill_notify_or_timeout("gas_mask_swap_complete", 2);
    self.var_893c74118f0f4c3e = 0;
    waitframe();
  }
}

function private function_1dd66b55d430e603() {
  waittill_any_2("disconnect", "monitorGasMaskInputSwap");

  if(isDefined(self)) {
    self notifyonplayercommandremove("attemptSwapGasMask", "gas_mask_toggle");
  }
}
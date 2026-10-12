/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\gasmask.gsc
***********************************************/



#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\white_phosphorus;
#using scripts\engine\utility;
#namespace gasmask;

function init(gasmaskhealth, gasmasktype, gasmaskmaxhealth) {
  gasmaskid = 2;

  if(isDefined(gasmasktype)) {
    if(gasmasktype == "brloot_equip_gasmask_scuba") {
      gasmaskid = 4;
      self.usingscubagasmask = 1;
    } else {
      self.usingscubagasmask = undefined;

      if(gasmasktype == "brloot_equip_gasmask_durable" || gasmasktype == "gas_mask_durable") {
        gasmaskid = 3;
      }
    }
  } else {
    self.usingscubagasmask = undefined;
  }

  isbr = issharedfuncdefined("game", "isBRStyleGameType") && [[getsharedfunc("game", "isBRStyleGameType")]]();

  if(!isDefined(level.gasmask_resist)) {
    if(isDefined(level.gametypebundle.gasmaskresistance)) {
      level.gasmask_resist = level.gametypebundle.gasmaskresistance;
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

  if(isDefined(gasmaskhealth)) {
    self.gasmaskhealth = gasmaskhealth;
  }

  if(isbr) {
    level.gasmaskhealthperpip = self.gasmaskhealth / 6;
  }

  level.gasmaskmaxhealth = maxhealth;
  level.var_e79884673ac9666e = getdvarint(@ "hash_f221cc8f9519efe", 1);
  self setclientomnvar("ui_head_equip_class", gasmaskid);
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

function getmaxhealth(gasmaskscriptablename) {
  maxhealth = undefined;
  isbr = issharedfuncdefined("game", "isBRStyleGameType") && [[getsharedfunc("game", "isBRStyleGameType")]]();

  if(isDefined(gasmaskscriptablename)) {
    if(isbr) {
      loottablehealthoverride = level.br_pickups.counts[gasmaskscriptablename];

      if(isDefined(loottablehealthoverride)) {
        maxhealth = loottablehealthoverride;
      } else {
        switch (gasmaskscriptablename) {
          case #"hash_d01e387e6d238502":
            maxhealth = 220;
            break;
          default:
            break;
        }
      }
    } else {
      switch (gasmaskscriptablename) {
        case #"hash_d01e387e6d238502":
          maxhealth = 220;
          break;
        default:
          break;
      }
    }
  }

  if(!isDefined(maxhealth)) {
    if(isbr) {
      maxhealth = getdvarint(@ "hash_acad4ff93022ff44", 110);
    } else {
      maxhealth = 180;
    }
  }

  return maxhealth;
}

function getscriptablename(var_d5f96a53f7f4002e) {
  gasmaskscriptablename = undefined;

  switch (var_d5f96a53f7f4002e) {
    case #"hash_2d1a1b811aed6b26":
    case #"hash_4808e1f340e11163":
    case #"hash_dcf82d1f65a6b16e":
      gasmaskscriptablename = "brloot_equip_gasmask";
      break;
    case #"hash_d01e387e6d238502":
      gasmaskscriptablename = "brloot_equip_gasmask_durable";
      break;
    default:
      break;
  }

  return gasmaskscriptablename;
}

function processdamage(damage) {
  isbr = issharedfuncdefined("game", "isBRStyleGameType") && [[getsharedfunc("game", "isBRStyleGameType")]]();
  var_c8898166ad0dccc9 = self.gasmaskhealth / self.gasmaskmaxhealth;
  self.gasmaskhealth -= damage;
  self.gasmaskhealth = max(0, self.gasmaskhealth);

  if(isbr) {
    gasmaskhealthpercentage = (self.gasmaskhealth + 1) / self.gasmaskmaxhealth;
  } else {
    gasmaskhealthpercentage = self.gasmaskhealth / self.gasmaskmaxhealth;
  }

  gasmaskhealthpercentage = clamp(gasmaskhealthpercentage, 0, 1);
  self setclientomnvar("ui_gasmask_damage", gasmaskhealthpercentage);

  if(istrue(level.gametypebundle.var_c837fd49542eec31)) {
    if(self.gasmaskhealth <= self.gasmaskmaxhealth * level.gametypebundle.gasmaskcrackthresholdone && self.gasmaskhealth + damage >= self.gasmaskmaxhealth * level.gametypebundle.gasmaskcrackthresholdone) {
      setbrokenoverlaymaterial("gasmask_overlay_delta2_crack_stage1");
    } else if(self.gasmaskhealth <= self.gasmaskmaxhealth * level.gametypebundle.gasmaskcrackthresholdtwo && self.gasmaskhealth + damage >= self.gasmaskmaxhealth * level.gametypebundle.gasmaskcrackthresholdtwo) {
      setbrokenoverlaymaterial("gasmask_overlay_delta2_crack_stage2");
    }
  }

  if(self.gasmaskhealth <= 0) {
    if(isbr && issharedfuncdefined("gasmask", "breakGasMaskBR")) {
      self[[getsharedfunc("gasmask", "breakGasMaskBR")]]();
    } else if(isDefined(level.gasmaskbreakfunc)) {
      self[[level.gasmaskbreakfunc]]();
    } else {
      breakgasmask();
    }
  } else if(isbr) {
    oldpips = floor(var_c8898166ad0dccc9 * 6 + 0.5);
    newpips = floor(gasmaskhealthpercentage * 6 + 0.5);

    if(oldpips > newpips) {
      self playsoundtoplayer("br_gas_mask_crack_plr", self);
    }
  }

  if(!isDefined(self.gasdamagebuffer)) {
    self.gasdamagebuffer = 0;
  }

  assertex(isDefined(level.gasmask_resist), "level.gasMask_resist needs to have a valid value.");
  self.gasdamagebuffer += damage * level.gasmask_resist;
  damagetoplayer = floor(self.gasdamagebuffer);

  if(damagetoplayer >= 1) {
    self dodamage(damagetoplayer, self.origin, self, undefined, "MOD_TRIGGER_HURT");
    self.gasdamagebuffer -= damagetoplayer;
  }
}

function aiprocessdamage(damage) {
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
    self.gasmaskmaxhealth = getdvarint(@ "hash_acad4ff93022ff44", 110);
  }

  oldhealthpercentage = oldhealth / self.gasmaskmaxhealth;
  newhealthpercentage = newhealth / self.gasmaskmaxhealth;
  oldpips = floor(oldhealthpercentage * 6 + 0.5);
  newpips = floor(newhealthpercentage * 6 + 0.5);
  return oldpips != newpips;
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
  self detach("hat_gasmask");
  destroyoverlay();

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref) && self.operatorcustomization.skinref + "" == "355") {
    self function_555e2d32e2756625("gasmask_female");
  } else if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
    self function_555e2d32e2756625("female");
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
  self detach("hat_gasmask");
  destroyoverlay();

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref) && self.operatorcustomization.skinref + "" == "355") {
    self function_555e2d32e2756625("gasmask_female");
  } else if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
    self function_555e2d32e2756625("female");
  } else if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref) && self.operatorcustomization.skinref + "" == "319") {
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
    if(self.gasmaskhealth <= self.gasmaskmaxhealth * level.gametypebundle.gasmaskcrackthresholdtwo) {
      setbrokenoverlaymaterial("gasmask_overlay_delta2_crack_stage2");
    } else if(self.gasmaskhealth <= self.gasmaskmaxhealth * level.gametypebundle.gasmaskcrackthresholdone) {
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

function isgasmaskequipped(player) {
  return istrue(player.gasmaskequipped);
}

function function_27e68abe09612a13(player) {
  return isDefined(player.gasmaskhealth) && player.gasmaskhealth > 0;
}

function cleanupgasmask() {
  self.gasmaskmaxhealth = undefined;
  self.gasmaskhealth = undefined;
  self.gasmaskrequests = undefined;
  self setclientomnvar("ui_gas_mask", 0);
  self setclientomnvar("ui_head_equip_class", 0);
  self setclientomnvar("ui_gasmask_damage", 0);
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\gasmask.gsc
***********************************************/

function init(var_0, var_1) {
  var_2 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br";

  if(var_2) {
    var_3 = removestructfromlevelarray(var_1);
  } else {
    var_3 = 180;
  }

  if(!isDefined(level.plundermusicfourth)) {
    if(var_3) {
      level.plundermusicfourth = getdvarfloat("scr_br_gasMask_resist", 0);
    } else {
      level.plundermusicfourth = 0.2;
    }
  }

  self.gasmaskhealth = var_3;
  self.plunderpads = var_3;
  self.plundersilentcountdownendtime = var_2;
  var_4 = 2;

  if(unlocked_escape_door(var_2)) {
    var_4 = 3;
  }

  if(isDefined(var_1)) {
    self.gasmaskhealth = var_1;
  }

  if(var_3) {
    level.plunderonfirstpickup = self.gasmaskhealth / 6;
  }

  level.plunderpads = var_3;
  self setclientomnvar("ui_head_equip_class", var_4);
  self setclientomnvar("ui_gasmask_damage", self.gasmaskhealth / var_3);
}

function unlocked_escape_door(var_0) {
  return isDefined(var_0) && var_0 == "brloot_equip_gasmask_durable";
}

function removestructfromlevelarray(var_0) {
  if(unlocked_escape_door(var_0)) {
    return level.br_pickups.counts["brloot_equip_gasmask_durable"];
  }

  return level.br_pickups.counts["brloot_equip_gasmask"];
}

function respawnplayers(var_0) {
  return floor(var_0 * 6 + 0.5);
}

function processdamage(var_0) {
  var_1 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br";
  var_2 = self.gasmaskhealth / self.plunderpads;
  self.gasmaskhealth -= var_0;
  self.gasmaskhealth = max(0, self.gasmaskhealth);
  var_3 = self.gasmaskhealth / self.plunderpads;
  self setclientomnvar("ui_gasmask_damage", var_3);

  if(self.gasmaskhealth <= 0) {
    if(var_1 && scripts\cp_mp\utility\script_utility::issharedfuncdefined("gasmask", "breakGasMaskBR")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("gasmask", "breakGasMaskBR")]]();
    } else {
      breakgasmask();
    }
  } else if(var_1) {
    var_4 = respawnplayers(var_2);
    var_5 = respawnplayers(var_3);

    if(var_4 > var_5) {
      self playsoundtoplayer("br_gas_mask_crack_plr", self);
    }
  }

  if(!isDefined(self.gasdamagebuffer)) {
    self.gasdamagebuffer = 0;
  }

  self.gasdamagebuffer += var_0 * level.plundermusicfourth;
  var_6 = floor(self.gasdamagebuffer);

  if(var_6 >= 1) {
    self dodamage(var_6, self.origin, self, undefined, "MOD_TRIGGER_HURT");
    self.gasdamagebuffer -= var_6;
    return;
  }
}

function lights_setup_plane(var_0, var_1) {
  var_2 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br";

  if(!var_2) {
    return false;
  }

  if(!isDefined(self.plunderpads)) {
    self.plunderpads = removestructfromlevelarray(self.plundersilentcountdownendtime);
  }

  var_3 = var_0 / self.plunderpads;
  var_4 = var_1 / self.plunderpads;
  var_5 = respawnplayers(var_3);
  var_6 = respawnplayers(var_4);
  return var_5 != var_6;
}

function equipgasmask() {
  self endon("death_or_disconnect");
  self playsoundtoplayer("br_gas_mask_on_plr", self);
  var_0 = getcompleteweaponname("none");
  var_1 = self getcurrentweapon();

  if(!isnullweapon(var_1, var_0)) {
    self forceplaygestureviewmodel("ges_visor_down");
  }

  self.gasmaskswapinprogress = 1;
  wait 0.338;
  self.gasmaskswapinprogress = 0;
  self.gasmaskequipped = 1;
  scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudiosupression();
  var_2 = "hat_gasmask";

  if(scripts\cp_mp\utility\game_utility::ref_140AA()) {
    var_2 = "hat_gasmask_ch3";
  }

  if(istrue(self.operatorcustomization.spawn_carriables_from_prefabs_percentage)) {
    self attach(var_2);
  }

  createoverlay();

  if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
    self method_87aa("gasmask_female");
    return;
  }

  self method_87aa("gasmask_male");
}

function removegasmask() {
  self endon("death_or_disconnect");

  if(!istrue(self.gasmaskequipped)) {
    return;
  }

  self playsoundtoplayer("br_gas_mask_off_plr", self);
  var_0 = getcompleteweaponname("none");
  var_1 = self getcurrentweapon();

  if(!isnullweapon(var_1, var_0)) {
    self forceplaygestureviewmodel("ges_visor_up");
  }

  self.gasmaskswapinprogress = 1;
  wait 0.521;
  self.gasmaskswapinprogress = 0;
  self.gasmaskequipped = 0;
  scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudiosupression();
  var_2 = "hat_gasmask";

  if(scripts\cp_mp\utility\game_utility::ref_140AA()) {
    var_2 = "hat_gasmask_ch3";
  }

  if(istrue(self.operatorcustomization.spawn_carriables_from_prefabs_percentage)) {
    self detach(var_2);
  }

  destroyoverlay();

  if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
    self method_87aa("female");
    return;
  }

  self method_87aa("");
}

function breakgasmask() {
  if(!istrue(self.gasmaskequipped)) {
    return;
  }

  self.gasmaskequipped = 0;
  self playsoundtoplayer("br_gas_mask_crack_plr", self);
  var_0 = "hat_gasmask";

  if(scripts\cp_mp\utility\game_utility::ref_140AA()) {
    var_0 = "hat_gasmask_ch3";
  }

  if(istrue(self.operatorcustomization.spawn_carriables_from_prefabs_percentage)) {
    self detach(var_0);
  }

  destroyoverlay();

  if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
    self method_87aa("female");
  } else {
    self method_87aa("");
  }

  self playsoundtoplayer("br_gas_mask_depleted_plr", self);
  self setclientomnvar("ui_head_equip_class", 0);
  self setclientomnvar("ui_gasmask_damage", 0);
}

function createoverlay(var_0, var_1) {
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

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br") {
      self.gasmaskoverlay.alpha = 0;

      if(isDefined(var_0)) {
        if(isDefined(var_1)) {
          wait var_1;
        }

        if(isDefined(self.gasmaskoverlay)) {
          self.gasmaskoverlay fadeovertime(var_0);
        }
      }
    }
  }

  if(isDefined(self.gasmaskoverlay)) {
    self.gasmaskoverlay.alpha = 1;
    self.gasmaskoverlay.lowresbackground = 1;
    return;
  }
}

function ref_1312F() {
  if(isDefined(self.gasmaskoverlay)) {
    self.gasmaskoverlay setshader("gasmask_overlay_delta2_broken", 640, 480);
    return;
  }
}

function patch_weapons_on_rack_cleararea(var_0) {
  self.gasmaskoverlay.alpha = 1;
  self.gasmaskoverlay fadeovertime(var_0);
  self.gasmaskoverlay.alpha = 0;
}

function destroyoverlay(var_0, var_1) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(!isDefined(self.gasmaskoverlay)) {
    return;
  }

  if(isDefined(var_0)) {
    if(isDefined(var_1)) {
      wait var_1;
    }

    if(isDefined(self.gasmaskoverlay)) {
      patch_weapons_on_rack_cleararea(var_0);
      wait var_0;
    }
  }

  if(isDefined(self.gasmaskoverlay)) {
    self.gasmaskoverlay destroy();
    self.gasmaskoverlay = undefined;
    return;
  }
}

function hasgasmask(var_0) {
  return isDefined(var_0.gasmaskhealth);
}
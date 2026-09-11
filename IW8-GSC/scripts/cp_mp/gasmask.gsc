/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\gasmask.gsc
***********************************************/

function init(var0, var1) {
  var2 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br";

  if(var2) {
    var3 = removestructfromlevelarray(var1);
  } else {
    var3 = 180;
  }

  if(!isDefined(level.plundermusicfourth)) {
    if(var3) {
      level.plundermusicfourth = getdvarfloat("scr_br_gasMask_resist", 0);
    } else {
      level.plundermusicfourth = 0.2;
    }
  }

  self.gasmaskhealth = var3;
  self.plunderpads = var3;
  self.plundersilentcountdownendtime = var2;
  var4 = 2;

  if(unlocked_escape_door(var2)) {
    var4 = 3;
  }

  if(isDefined(var1)) {
    self.gasmaskhealth = var1;
  }

  if(var3) {
    level.plunderonfirstpickup = self.gasmaskhealth / 6;
  }

  level.plunderpads = var3;
  self setclientomnvar("ui_head_equip_class", var4);
  self setclientomnvar("ui_gasmask_damage", self.gasmaskhealth / var3);
}

function unlocked_escape_door(var0) {
  return isDefined(var0) && var0 == "brloot_equip_gasmask_durable";
}

function removestructfromlevelarray(var0) {
  if(unlocked_escape_door(var0)) {
    return level.br_pickups.counts["brloot_equip_gasmask_durable"];
  }

  return level.br_pickups.counts["brloot_equip_gasmask"];
}

function respawnplayers(var0) {
  return floor(var0 * 6 + 0.5);
}

function processdamage(var0) {
  var1 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br";
  var2 = self.gasmaskhealth / self.plunderpads;
  self.gasmaskhealth -= var0;
  self.gasmaskhealth = max(0, self.gasmaskhealth);
  var3 = self.gasmaskhealth / self.plunderpads;
  self setclientomnvar("ui_gasmask_damage", var3);

  if(self.gasmaskhealth <= 0) {
    if(var1 && scripts\cp_mp\utility\script_utility::issharedfuncdefined("gasmask", "breakGasMaskBR")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("gasmask", "breakGasMaskBR")]]();
    } else {
      breakgasmask();
    }
  } else if(var1) {
    var4 = respawnplayers(var2);
    var5 = respawnplayers(var3);

    if(var4 > var5) {
      self playsoundtoplayer("br_gas_mask_crack_plr", self);
    }
  }

  if(!isDefined(self.gasdamagebuffer)) {
    self.gasdamagebuffer = 0;
  }

  self.gasdamagebuffer += var0 * level.plundermusicfourth;
  var6 = floor(self.gasdamagebuffer);

  if(var6 >= 1) {
    self dodamage(var6, self.origin, self, undefined, "MOD_TRIGGER_HURT");
    self.gasdamagebuffer -= var6;
    return;
  }
}

function lights_setup_plane(var0, var1) {
  var2 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br";

  if(!var2) {
    return false;
  }

  if(!isDefined(self.plunderpads)) {
    self.plunderpads = removestructfromlevelarray(self.plundersilentcountdownendtime);
  }

  var3 = var0 / self.plunderpads;
  var4 = var1 / self.plunderpads;
  var5 = respawnplayers(var3);
  var6 = respawnplayers(var4);
  return var5 != var6;
}

function equipgasmask() {
  self endon("death_or_disconnect");
  self playsoundtoplayer("br_gas_mask_on_plr", self);
  var0 = getcompleteweaponname("none");
  var1 = self getcurrentweapon();

  if(!isnullweapon(var1, var0)) {
    self forceplaygestureviewmodel("ges_visor_down");
  }

  self.gasmaskswapinprogress = 1;
  wait 0.338;
  self.gasmaskswapinprogress = 0;
  self.gasmaskequipped = 1;
  scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudiosupression();
  var2 = "hat_gasmask";

  if(scripts\cp_mp\utility\game_utility::ref_140aa()) {
    var2 = "hat_gasmask_ch3";
  }

  if(istrue(self.operatorcustomization.spawn_carriables_from_prefabs_percentage)) {
    self attach(var2);
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
  var0 = getcompleteweaponname("none");
  var1 = self getcurrentweapon();

  if(!isnullweapon(var1, var0)) {
    self forceplaygestureviewmodel("ges_visor_up");
  }

  self.gasmaskswapinprogress = 1;
  wait 0.521;
  self.gasmaskswapinprogress = 0;
  self.gasmaskequipped = 0;
  scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudiosupression();
  var2 = "hat_gasmask";

  if(scripts\cp_mp\utility\game_utility::ref_140aa()) {
    var2 = "hat_gasmask_ch3";
  }

  if(istrue(self.operatorcustomization.spawn_carriables_from_prefabs_percentage)) {
    self detach(var2);
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
  var0 = "hat_gasmask";

  if(scripts\cp_mp\utility\game_utility::ref_140aa()) {
    var0 = "hat_gasmask_ch3";
  }

  if(istrue(self.operatorcustomization.spawn_carriables_from_prefabs_percentage)) {
    self detach(var0);
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

function createoverlay(var0, var1) {
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

      if(isDefined(var0)) {
        if(isDefined(var1)) {
          wait var1;
        }

        if(isDefined(self.gasmaskoverlay)) {
          self.gasmaskoverlay fadeovertime(var0);
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

function ref_1312f() {
  if(isDefined(self.gasmaskoverlay)) {
    self.gasmaskoverlay setshader("gasmask_overlay_delta2_broken", 640, 480);
    return;
  }
}

function patch_weapons_on_rack_cleararea(var0) {
  self.gasmaskoverlay.alpha = 1;
  self.gasmaskoverlay fadeovertime(var0);
  self.gasmaskoverlay.alpha = 0;
}

function destroyoverlay(var0, var1) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(!isDefined(self.gasmaskoverlay)) {
    return;
  }

  if(isDefined(var0)) {
    if(isDefined(var1)) {
      wait var1;
    }

    if(isDefined(self.gasmaskoverlay)) {
      patch_weapons_on_rack_cleararea(var0);
      wait var0;
    }
  }

  if(isDefined(self.gasmaskoverlay)) {
    self.gasmaskoverlay destroy();
    self.gasmaskoverlay = undefined;
    return;
  }
}

function hasgasmask(var0) {
  return isDefined(var0.gasmaskhealth);
}
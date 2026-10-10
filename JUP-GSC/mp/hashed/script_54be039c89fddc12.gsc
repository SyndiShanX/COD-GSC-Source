/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_54be039c89fddc12.gsc
*************************************************/

#using scripts\common\devgui;
#using scripts\cp_mp\gasmask;
#using scripts\cp_mp\killstreaks\white_phosphorus;
#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\loot\common_item;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\utility\player;
#namespace namespace_6236231ba2ba2d74;

function function_db1254dca5eaf211() {
  level.var_f26b4e7eb9af8155 = &function_cdf7f2f6bd3207;
  level.var_c57ee1e174e42601 = &function_8206bc54a1ed73cb;
  level.var_f929c426097f1647 = &breakgasmask;
  level.var_9e3e0db450eec0f7 = getdvarint(@ "hash_41e94c252e1d9247", 1);
  level.var_28231449ea8976a1 = getdvarint(@ "hash_e04e2774c39ed0d1", 1);
  level.gasmasklootid = function_2c836ad05e5f634c("gas_mask");
  level.var_479d8ef7f76a4df6 = function_2c836ad05e5f634c("gas_mask_durable");
  level.var_534e97d34ef9fa29 = [level.gasmasklootid, level.var_479d8ef7f76a4df6];
  function_900f562c61c6a5d6("gasmask", &function_9726a41ef12198aa, &function_921a9118b4577d3e, undefined, &function_95271caae9eaad97, &function_22065872fdfd2315);
}

function function_9726a41ef12198aa(itembundle, item, autouse) {
  scripts\cp_mp\gasmask::init(item.count, itembundle.ref, itembundle.maxcount);
  return false;
}

function function_921a9118b4577d3e(itembundle, item, autouse, allowswap) {
  if(isDefined(self.gasmaskhealth)) {
    return false;
  }

  return true;
}

function function_95271caae9eaad97() {
  itembundle = undefined;
  quantity = 0;

  if(!scripts\cp_mp\gasmask::hasgasmask(self)) {
    return [itembundle, quantity];
  }

  var_acdff55c23d1f9f = self.gasmasktype;

  if(!isDefined(var_acdff55c23d1f9f)) {
    return [itembundle, quantity];
  }

  var_6864ed104531914d = function_61d960957fcf3ca0(var_acdff55c23d1f9f);

  if(isDefined(var_6864ed104531914d)) {
    itembundle = getscriptbundle("itemspawnentry:" + var_6864ed104531914d);
    quantity = self.gasmaskhealth;
  }

  return [itembundle, quantity];
}

function function_22065872fdfd2315() {
  function_febe5318d593116();
}

function function_febe5318d593116() {
  if(istrue(self.gasmaskswapinprogress)) {
    waittill_notify_or_timeout("gas_mask_swap_complete", 2);
  }

  if(istrue(self.gasmaskequipped) && istrue(self.var_def787c3aedbce76)) {
    scripts\cp_mp\gasmask::removegasmask();
    self.gasmaskswapinprogress = 0;
  } else {
    self[[level.var_c57ee1e174e42601]]("all");
  }

  scripts\cp_mp\gasmask::function_58687e8e71126788();
}

function function_cdf7f2f6bd3207(request) {
  if(!isDefined(self.var_fe63300b318b76b0)) {
    self.var_fe63300b318b76b0 = [];
  }

  if(isDefined(self.var_fe63300b318b76b0[request])) {
    return;
  }

  self.var_fe63300b318b76b0[request] = 1;
  thread function_2202e74632488bac();
}

function function_8206bc54a1ed73cb(request) {
  if(!isDefined(self.var_fe63300b318b76b0)) {
    self.var_fe63300b318b76b0 = [];
  }

  if(request == "all") {
    foreach(request, data in self.var_fe63300b318b76b0) {
      self.var_fe63300b318b76b0[request] = undefined;
    }

    thread function_2202e74632488bac();
    return;
  } else if(!isDefined(self.var_fe63300b318b76b0[request])) {
    return;
  }

  self.var_fe63300b318b76b0[request] = undefined;
  thread function_2202e74632488bac();
}

function function_2202e74632488bac() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  while(function_aeffe7dc479451ad()) {
    wait 0.1;
  }

  if(istrue(self.gasmaskswapinprogress)) {
    waittill_notify_or_timeout("gas_mask_swap_complete", 2);
    waitframe();
  }

  self notify("gasMaskUpdateOnOff");
  self endon("gasMaskUpdateOnOff");
  waittillframeend();

  if(istrue(self.gasmaskequipped) && (!isDefined(self.var_fe63300b318b76b0) || !self.var_fe63300b318b76b0.size)) {
    thread removegasmask();
    return;
  }

  if(!istrue(self.gasmaskequipped) && isDefined(self.var_fe63300b318b76b0) && self.var_fe63300b318b76b0.size) {
    thread equipgasmask();
  }
}

function function_aeffe7dc479451ad() {
  player = self;
  delaygesture = 0;
  delaygesture |= player isreloading();
  delaygesture |= player isthrowinggrenade();
  delaygesture |= player isdiving();
  delaygesture |= player issprintsliding();
  delaygesture |= player scripts\mp\utility\player::isplayerads();
  return delaygesture;
}

function function_28b827d98b0cc603() {
  player = self;
  preventgesture = 0;
  preventgesture |= player isinfreefall();
  preventgesture |= player isparachuting();
  preventgesture |= player isbasejumpavailable();

  if(level.var_28231449ea8976a1 != 0) {
    preventgesture |= player isjumping();
  }

  return !preventgesture;
}

function equipgasmask() {
  self endon("game_ended");
  self endon("death_or_disconnect");
  self playsoundtoplayer("br_gas_mask_on_plr", self);
  self.gasmaskswapinprogress = 1;
  thread delayedattach(0.2);
  var_9f955950f47f8532 = self getgestureanimlength("iw9_vm_ges_gasmask_on");
  assert(0.2 < var_9f955950f47f8532);

  if(function_28b827d98b0cc603()) {
    thread scripts\mp\gametypes\br_public::playerplaygestureweaponanim("iw8_ges_plyr_gasmask_on", var_9f955950f47f8532);
  }

  self setclientomnvar("ui_gas_mask", 2);
  wait var_9f955950f47f8532;
  self.gasmaskswapinprogress = 0;
  self notify("gas_mask_swap_complete");
  self.gasmaskequipped = 1;
  scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudiosupression();

  if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
    self function_555e2d32e2756625("gasmask_female");
  } else {
    self function_555e2d32e2756625("gasmask_male");
  }

  if(isDefined(self.gasmaskhealth) && self.gasmaskhealth <= 0) {
    breakgasmask();
  }
}

function removegasmask() {
  self endon("game_ended");
  self endon("death_or_disconnect");

  if(!istrue(self.gasmaskequipped)) {
    return;
  }

  self playsoundtoplayer("br_gas_mask_off_plr", self);
  fadeouttime = self getgestureanimlength("iw9_vm_ges_gasmask_off");
  thread delayeddetach(1.3);

  if(function_28b827d98b0cc603()) {
    thread scripts\mp\gametypes\br_public::playerplaygestureweaponanim("iw8_ges_plyr_gasmask_off", fadeouttime);
  }

  self.gasmaskswapinprogress = 1;
  self setclientomnvar("ui_gas_mask", 1);
  wait fadeouttime;
  self.gasmaskswapinprogress = 0;
  self notify("gas_mask_swap_complete");
  scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudiosupression();

  if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
    self function_555e2d32e2756625("female");
  } else {
    self function_555e2d32e2756625("");
  }

  if(isDefined(self.gasmaskhealth) && self.gasmaskhealth <= 0) {
    function_58687e8e71126788();
  }
}

function breakgasmask() {
  if(!istrue(self.gasmaskequipped)) {
    return;
  }

  self playsoundtoplayer("br_gas_mask_crack_plr", self);
  thread delayeddetachbreak(0.6);

  if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
    self function_555e2d32e2756625("female");
  } else {
    self function_555e2d32e2756625("");
  }

  self playsoundtoplayer("br_gas_mask_depleted_plr", self);
  function_58687e8e71126788();
  fadeouttime = self getgestureanimlength("iw9_vm_ges_gasmask_break");
  thread scripts\mp\gametypes\br_public::playerplaygestureweaponanim("iw8_ges_plyr_gasmask_break", fadeouttime);
  self.gasmaskswapinprogress = 1;
  self setclientomnvar("ui_gas_mask", 3);
  wait fadeouttime;

  if(isDefined(self)) {
    self.gasmaskswapinprogress = 0;
    self notify("gas_mask_swap_complete");
    function_8e9b00a1d2b23d72();
  }
}

function delayedattach(delaytime) {
  self endon("game_end");
  self endon("death_or_disconnect");

  if(isDefined(delaytime) && delaytime > 0) {
    wait delaytime;
  }

  self attach("hat_child_hadir_gas_mask_wm_br", "j_head");
  wait 0.5;
  scripts\cp_mp\gasmask::createoverlay();
}

function delayeddetach(delaytime) {
  self endon("game_end");
  self endon("death_or_disconnect");
  wait 0.35;
  scripts\cp_mp\gasmask::destroyoverlay();

  if(isDefined(delaytime) && delaytime > 0.35) {
    wait delaytime - 0.35;
  }

  if(self.gasmaskequipped) {
    self detach("hat_child_hadir_gas_mask_wm_br", "j_head");
    self.gasmaskequipped = 0;
  }
}

function delayeddetachbreak(delaytime) {
  self endon("game_end");
  self endon("death_or_disconnect");
  scripts\cp_mp\gasmask::destroyoverlay();

  if(isDefined(delaytime) && delaytime > 0.1) {
    wait delaytime - 0.1;
  }

  wait 0.1;

  if(self.gasmaskequipped) {
    self detach("hat_child_hadir_gas_mask_wm_br", "j_head");
    self.gasmaskequipped = 0;
  }
}

function function_8e9b00a1d2b23d72() {
  player = self;

  if(!inventory_isenabled()) {
    return;
  }

  var_d035435a9237f3d = function_b27f0c7dafeadb3(level.var_479d8ef7f76a4df6);

  if(!var_d035435a9237f3d) {
    function_b27f0c7dafeadb3(level.gasmasklootid);
  }
}

function function_b27f0c7dafeadb3(targetlootid, var_6e3ef3bd8bb4967a) {
  backpacksize = function_1b35b10884bd8d67();

  for(i = 0; i < backpacksize; i++) {
    currentlootid = function_d870b2c45335bd88(i);

    if(currentlootid == targetlootid) {
      if(!istrue(var_6e3ef3bd8bb4967a)) {
        function_777092be5abab355(i);
      }

      return true;
    }
  }

  return false;
}

function function_58687e8e71126788() {
  self.gasmaskmaxhealth = undefined;
  self.gasmaskhealth = undefined;
  self.var_fe63300b318b76b0 = undefined;
  self setclientomnvar("ui_gas_mask", 0);
  self setclientomnvar("ui_head_equip_class", 0);
  self setclientomnvar("ui_gasmask_damage", 0);
}
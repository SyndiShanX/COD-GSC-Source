/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\equipment\adrenaline.gsc
**************************************************/

#using script_1174abedbefe9ada;
#using script_74b851b7aa1ef32d;
#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\talking_gun;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\equipment;
#using scripts\mp\gamelogic;
#using scripts\mp\supers\super_deadsilence;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#using scripts\mp\weapons;
#namespace adrenaline;

function function_22fd49689920fdb1() {
  level.var_151df843343d146 = 160;
  level.var_52a6b416b67aad73 = 0;
  var_6f4586deecb9973a = equipment::function_2cbf1e7261f0c42a("equip_adrenaline");

  if(isDefined(var_6f4586deecb9973a)) {
    level.var_151df843343d146 = default_to(var_6f4586deecb9973a.var_1b96072ac8b3137e, 120);
    level.var_52a6b416b67aad73 = default_to(var_6f4586deecb9973a.var_603039d101d23221, 0);
  }

  var_358d8a3d2c32cbe6 = getdvarint(@ "hash_3b85029cf1af7129", -1);
  var_2eb18ada2bfe5edb = getdvarint(@ "hash_d94cba8f8128ba00", -1);

  if(var_358d8a3d2c32cbe6 >= 0) {
    level.var_151df843343d146 = var_358d8a3d2c32cbe6;
  }

  if(var_2eb18ada2bfe5edb >= 0) {
    level.var_52a6b416b67aad73 = var_2eb18ada2bfe5edb;
  }

  level.var_289e4697f2efe65d = getdvarfloat(@ "hash_16b5cecddf1fd9a2", 0.07);
}

function useadrenaline(equipmentref) {
  self endon("disconnect");
  self endon("removeAdrenaline");
  scripts\cp_mp\talking_gun::function_55b08d6d71b41402(self, "self_apply");
  wait level.var_52a6b416b67aad73;

  if(self.health != self.maxhealth) {
    hasattacker = 0;

    if(isDefined(self.attackers)) {
      foreach(attacker in self.attackers) {
        if(is_equal(attacker, self)) {
          continue;
        }

        hasattacker = 1;
        break;
      }
    }

    if(hasattacker && (!scripts\cp_mp\utility\game_utility::isbrstylegametype() || !namespace_7789f919216d38a2::function_76ef3c8b8171d2d(self.origin))) {
      namespace_a850435086c88de3::doonactionscoreevent(0, "adrenalineHeal", 15);
    }
  }

  self notify("force_regeneration");
  scripts\mp\gamelogic::sethasdonecombat(self, 1);
  adrenaline_missiononuse();
  self.adrenalinepoweractive = 1;

  if(self.health > 0 && self.health < self.maxhealth) {
    scripts\cp_mp\challenges::function_b0f754c8a379154e("equip_adrenaline", self, undefined, function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"use"));
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    thread function_46920ff2cd83de61();
  }

  self refreshsprinttime();
  childthread adrenaline_removeonplayernotifies();
  childthread adrenaline_removeondamage();
  childthread adrenaline_removeongameend();

  if(!istrue(self.var_ae0c9ad0db0fa6b8)) {
    var_6f4586deecb9973a = equipment::function_2cbf1e7261f0c42a("equip_adrenaline");

    if(!isDefined(var_6f4586deecb9973a)) {
      return true;
    }

    if(istrue(var_6f4586deecb9973a.var_773f79399f415050)) {
      rechargetime = isDefined(var_6f4586deecb9973a.var_d68b7235ae27c0ca) ? var_6f4586deecb9973a.var_d68b7235ae27c0ca : 30;
      thread adrenalinerecharge(rechargetime);
    }
  }

  return true;
}

function removeadrenaline() {
  if(istrue(self.adrenalinepoweractive)) {
    self notify("removeAdrenaline");
    self.adrenalinepoweractive = undefined;
  }
}

function adrenalinerecharge(rechargetime) {
  self notify("adrenalineRecharge");
  self endon("disconnect");
  self endon("adrenalineRecharge");
  level endon("game_ended");

  while(true) {
    equipment = equipment::getcurrentequipment("secondary");

    if(!isDefined(equipment) || equipment != "equip_adrenaline") {
      return;
    }

    if(!isDefined(self.rechargeequipmentstate)) {
      self.rechargeequipmentstate = spawnStruct();
      self.rechargeequipmentstate.progress = [];
      self.rechargeequipmentstate.recharged = [];
    } else {
      self.rechargeequipmentstate.recharged["secondary"] = undefined;
    }

    ammo = equipment::getequipmentammo(equipment);
    ammomax = equipment::getequipmentmaxammo(equipment);
    state = self.rechargeequipmentstate;
    rechargeperupdate = 0.5 / rechargetime;

    if(!isDefined(state.progress["secondary"])) {
      state.progress["secondary"] = 0;
    }

    if(ammo < ammomax) {
      state.progress["secondary"] = state.progress["secondary"] + rechargeperupdate;
    } else {
      state.progress["secondary"] = 0;
    }

    if(state.progress["secondary"] > 1 || abs(state.progress["secondary"] - 1) < 0.001) {
      equipment::incrementequipmentslotammo("secondary", 1);
      state.progress["secondary"] = 0;
      state.recharged["secondary"] = 1;
    }

    function_1a1fd182d2636f1f();
    wait 0.5;
  }
}

function function_1a1fd182d2636f1f() {
  tacticalprogress = 0;
  var_7732b71eb53c0af1 = -1;

  if(isDefined(self) && isDefined(self.rechargeequipmentstate)) {
    stats::initpersstat("restockCount");
    state = self.rechargeequipmentstate;

    if(isDefined(state.progress["secondary"])) {
      tacticalprogress = state.progress["secondary"];
    }

    foreach(slot, _ in state.recharged) {
      if(slot == "secondary") {
        var_7732b71eb53c0af1 += 2;
        self playlocalsound("ui_restock_tactical");
        stats::incpersstat("restockCount", 1);
      }
    }
  }

  self setclientomnvar("ui_tactical_recharge_progress", tacticalprogress);
  self setclientomnvar("ui_recharge_notify", var_7732b71eb53c0af1);
  self setpowerprogress("secondary", tacticalprogress);
}

function onequipmenttaken(equipmentref, slot) {
  removeadrenaline();
}

function onequipmentfired(equipmentref, slot, objweapon) {
  if(self isthrowingbackgrenade()) {
    self function_9b5704d0633b87fa();

    if(isDefined(objweapon)) {
      ammo = self getweaponammoclip(objweapon);
      newammo = int(max(ammo - 1, 0));
      self setweaponammoclip(objweapon, newammo);
    }
  }

  useadrenaline(equipmentref);
}

function gethealthpersec() {
  return level.var_151df843343d146;
}

function adrenaline_removeonplayernotifies() {
  waittill_any_2("death", "healed");
  thread removeadrenaline();
}

function adrenaline_removeondamage() {
  while(true) {
    self waittill("damage", idamage, eattacker, vdir, vpoint, smeansofdeath, smodelname, stagname, spartname, idflags, objweapon);

    if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && (smeansofdeath == "MOD_TRIGGER_HURT" || smeansofdeath == "MOD_UNKNOWN")) {
      continue;
    }

    thread removeadrenaline();
    return;
  }
}

function adrenaline_removeongameend() {
  level waittill("game_ended");
  thread removeadrenaline();

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    thread removeadrenalinespeed();
  }
}

function adrenaline_missiononuse() {
  if(self.health >= self.maxhealth) {
    self.usedadrenalineatfullhp = 1;
    thread adrenaline_missionondeaththink();
  }
}

function adrenaline_missionondeaththink() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("adrenaline_missionOnDeathThink");
  self endon("adrenaline_missionOnDeathThink");
  self waittill("death");
  self.usedadrenalineatfullhp = undefined;
}

function removeadrenalinespeed() {
  if(istrue(self.adrenalinespeed)) {
    self notify("removeAdrenalineSpeed");
    self.adrenalinespeed = undefined;
  }
}

function function_72775122d66e19f4() {
  self waittill("death");
  thread removeadrenalinespeed();
}

function function_46920ff2cd83de61() {
  self endon("disconnect");
  level endon("game_ended");
  self.adrenalinespeed = 0;
  self lerpfovbypreset("zombiedefault");
  self setclientomnvar("ui_speedboost_overlay", 0);

  for(i = 0; i < 5; i++) {
    self.adrenalinespeed += level.var_289e4697f2efe65d;
    scripts\mp\weapons::updatemovespeedscale();
    wait 0.2;
  }

  wait 0.5;
  self lerpfovbypreset("default_2seconds");
  thread scripts\mp\supers\super_deadsilence::superdeadsilence_endhudsequence();

  for(i = 0; i < 5; i++) {
    self.adrenalinespeed -= level.var_289e4697f2efe65d;
    scripts\mp\weapons::updatemovespeedscale();
    wait 0.2;
  }

  self.adrenalinespeed = 0;
}
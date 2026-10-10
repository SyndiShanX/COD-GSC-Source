/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\helmet.gsc
***********************************************/

#using script_2d9d24f7c63ac143;
#using scripts\common\utility;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_headgear;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\utility\player;
#namespace helmet;

function autoexec auto_init() {
  if(!istrue(getmatchrulesdata("helmetData", "enabled"))) {
    return;
  }

  thread function_18646af290fbfbb2();
  level.helmetdata = spawnStruct();
  level.helmetdata.var_bc47c031cc42316 = getmatchrulesdata("helmetData", "durability");
  level.helmetdata.threshold = getmatchrulesdata("helmetData", "damageThreshold");
  level.helmetdata.var_692dbeea010dcd1 = getmatchrulesdata("helmetData", "damageClamp");
  level.helmetdata.excludedweaponclasses = getmatchrulesdata("helmetData", "excludedWeaponClasses");
  level.helmetdata.excludedmeansofdeath = getmatchrulesdata("helmetData", "excludedMeansOfDeath");
  assertex(level.helmetdata.threshold - level.helmetdata.var_692dbeea010dcd1 == 1, "<dev string:x1c>");
  utility::registersharedfunc("helmet", "modifyHelmetDamage", &modifyhelmetdamage);
  utility::registersharedfunc("helmet", "helmet_wasBroke", &helmet_wasbroke);
  utility::registersharedfunc("helmet", "updateProtectionState", &function_299cd501b61c0d3c);
}

function function_18646af290fbfbb2() {
  if(!isDefined(level.headgeardata)) {
    level waittill("headgear_init");
  }

  if(isDefined(level.headgeardata) && utility::issharedfuncdefined("headgear", "registerHeadGear")) {
    headgeardata = spawnStruct();
    headgeardata.var_4fe5d2ab2f7dbd0 = &hashelmet;
    headgeardata.var_8965dea27a03f00f = &function_a1207d6155a4cb21;
    headgeardata.var_10b068badc49b1ad = &function_820310353aa408e;
    headgeardata.var_d2148115f2c3c399 = &function_d036366985435d3;
    headgeardata.var_9b9af82c327f6a63 = &function_a3a56edac9b26e89;
    headgeardata.var_8928676cf7288c90 = &function_914175cb65959c24;
    headgeardata.var_f830d658f5f0af18 = &init;
    headgeardata.breakfunc = &breakhelmet;
    headgeardata.var_fe0fd9391666371 = &function_9ad6194c61c4bd34;
    headgeardata.var_a7d8d38f4018a344 = &function_da78138ef883afb9;
    headgeardata.var_4aeed0bec3628793 = &function_d01dc4dc9edc024;
    headgeardata.var_2cb986fd5f1717f0 = &function_2a823033fec9c3a3;
    headgeardata.var_573fe16545e70f6a = &function_47f53709b7a29a77;
    headgeardata.var_bb61027a51ec1e05 = &function_99410e7ff54d683c;
    [[utility::getsharedfunc("headgear", "registerHeadGear")]]("helmet", headgeardata);
  }
}

function function_5ce1095d3ebdaa68(shitloc, partname) {
  if(shitloc == "head" || shitloc == "helmet" || shitloc == "neck") {
    return 1;
  }

  if(isDefined(partname)) {
    return scripts\cp_mp\utility\damage_utility::function_b656251147d7d40b(partname);
  }

  return 0;
}

function modifyhelmetdamage(attacker, victim, idamage, var_c619bd3ead94932e, objweapon, shitloc, partname, smeansofdeath) {
  if(isPlayer(attacker)) {
    helmet_clearbroke(attacker);
  }

  if(function_4aef917a60fe6683(victim)) {
    var_b0bc7939c659f729 = 1;

    if(getdvarint(@ "hash_fc28fbd9295bad17", 0) == 0) {
      if(victim.health + var_c619bd3ead94932e <= level.helmetdata.var_692dbeea010dcd1) {
        var_b0bc7939c659f729 = 0;
      }
    }

    modifieddamage = idamage + var_c619bd3ead94932e;

    if(var_b0bc7939c659f729 && function_5ce1095d3ebdaa68(shitloc, partname)) {
      modifieddamage = victim modifydamage(modifieddamage, attacker, objweapon, smeansofdeath);
    }

    idamage = modifieddamage - var_c619bd3ead94932e;
  }

  return [idamage, var_c619bd3ead94932e];
}

function init(var_5698e367753e03ba, var_113085cb6cb9173c, var_c36a76d3071e80ae) {
  var_f6ba8d6e6a3dcf59 = 5;
  var_bc47c031cc42316 = ter_op(isDefined(var_c36a76d3071e80ae), var_c36a76d3071e80ae, level.helmetdata.var_bc47c031cc42316);
  self.var_5698e367753e03ba = var_bc47c031cc42316;
  self.var_113085cb6cb9173c = ter_op(isDefined(var_113085cb6cb9173c), var_113085cb6cb9173c, "brloot_equip_helmet");
  self.headgeartype = "helmet";
  isbr = issharedfuncdefined("game", "isBRStyleGameType") && [[getsharedfunc("game", "isBRStyleGameType")]]();

  if(isbr) {
    level.var_64e0c53009427bca = self.var_5698e367753e03ba / 6;
  }

  self setclientomnvar("ui_head_equip_class", var_f6ba8d6e6a3dcf59);
  self setclientomnvar("ui_gasmask_damage", self.var_5698e367753e03ba / var_bc47c031cc42316);
}

function function_820310353aa408e() {
  return getdvarint(@ "hash_ce0fed1fd6f9e303", 1) == 1;
}

function getscriptablename(var_b14a276853a7becd) {
  var_52bae67b850d8400 = undefined;

  switch (var_b14a276853a7becd) {
    case #"hash_1c62bcd1f60e106c":
    case #"hash_8a1772f5f912c880":
      var_52bae67b850d8400 = "brloot_equip_helmet";
      break;
    case #"hash_e1f05d0a4963cf16":
      var_52bae67b850d8400 = "brloot_equip_reinforced_helmet";
      break;
    default:
      break;
  }

  return var_52bae67b850d8400;
}

function modifydamage(damage, attacker, objweapon, smeansofdeath) {
  outdamage = damage;
  var_e7ec701163e1b30c = level.helmetdata.var_692dbeea010dcd1;
  damagethreshold = level.helmetdata.threshold;

  if(function_91b88df2883c5dd(objweapon) && function_d9824ece84e7fe6(smeansofdeath)) {
    if(damage >= damagethreshold) {
      outdamage = var_e7ec701163e1b30c;
      self.var_5698e367753e03ba -= 1;
    }
  }

  if(self.var_5698e367753e03ba <= 0) {
    if(isDefined(level.headgeardata) && isDefined(level.headgeardata.gear["helmet"])) {
      scripts\mp\gametypes\br_headgear::breakheadgear("helmet", attacker);
    } else {
      breakhelmet();
    }

    helmet_setbroke(attacker);
  }

  return outdamage;
}

function function_91b88df2883c5dd(objweapon) {
  if(issubstr(level.helmetdata.excludedweaponclasses, objweapon.classname)) {
    return false;
  }

  return true;
}

function function_d9824ece84e7fe6(smeansofdeath) {
  if(issubstr(level.helmetdata.excludedmeansofdeath, smeansofdeath)) {
    return false;
  }

  return true;
}

function setbrokenoverlaymaterial(material) {
  if(isDefined(self.var_d59ea89f027676fc)) {
    if(isDefined(material)) {
      self.var_d59ea89f027676fc setshader(material, 640, 480);
      return;
    }

    self.var_d59ea89f027676fc setshader("gasmask_overlay_delta2_broken", 640, 480);
  }
}

function hashelmet(player) {
  return isDefined(player.var_5698e367753e03ba);
}

function function_a1207d6155a4cb21(player) {
  return istrue(player.var_5b9dafb6c753684);
}

function function_99410e7ff54d683c() {
  function_52dad6cd70b673b2();
}

function function_e0e91b770d992a81() {
  player = self;
  delaygesture = 0;
  delaygesture |= player isreloading();
  delaygesture |= player isthrowinggrenade();
  delaygesture |= player isdiving();
  delaygesture |= player issprintsliding();
  delaygesture |= player scripts\mp\utility\player::isplayerads();
  return delaygesture;
}

function function_d9d43450e3d74d25() {
  player = self;
  preventgesture = 0;
  preventgesture |= player isinfreefall();
  preventgesture |= player isskydiving();
  preventgesture |= player isparachuting();
  preventgesture |= player isbasejumpavailable();
  preventgesture |= player ismantling();
  return !preventgesture;
}

function function_da78138ef883afb9() {
  self playsoundtoplayer("br_gas_mask_on_plr", self);
}

function function_d01dc4dc9edc024() {
  self.var_5b9dafb6c753684 = 1;
  function_299cd501b61c0d3c(self);

  if(isDefined(self.var_5698e367753e03ba) && self.var_5698e367753e03ba <= 0) {
    if(isDefined(level.headgeardata) && isDefined(level.headgeardata.gear["helmet"])) {
      scripts\mp\gametypes\br_headgear::breakheadgear("helmet");
      return;
    }

    breakhelmet();
  }
}

function function_2a823033fec9c3a3() {
  self playsoundtoplayer("br_gas_mask_off_plr", self);
}

function function_47f53709b7a29a77() {
  if(isDefined(self.var_5698e367753e03ba) && self.var_5698e367753e03ba <= 0) {
    function_52dad6cd70b673b2();
  }
}

function breakhelmet(attacker) {
  if(!istrue(self.var_5b9dafb6c753684)) {
    return;
  }

  if(isDefined(attacker) && isDefined(self.var_113085cb6cb9173c) && istrue(self.var_113085cb6cb9173c == "brloot_equip_reinforced_helmet")) {
    attacker playsoundtoplayer("hit_marker_3d_reinforce_helmet_break", attacker);
  } else {
    self playsoundtoplayer("br_gas_mask_break_plr", self);
    self playsoundtoplayer("br_gas_mask_depleted_plr", self);
  }

  function_52dad6cd70b673b2();
  function_9ad6194c61c4bd34();
}

function function_52dad6cd70b673b2() {
  self.var_5b9dafb6c753684 = undefined;
  self.var_13bc0a60757228ba = undefined;
  self.var_5698e367753e03ba = undefined;
  self.var_113085cb6cb9173c = undefined;
  self.headgeartype = undefined;
  self setclientomnvar("ui_gas_mask", 0);
  self setclientomnvar("ui_head_equip_class", 0);
  self setclientomnvar("ui_gasmask_damage", 0);
}

function function_9ad6194c61c4bd34() {
  player = self;

  if(!player namespace_aead94004cf4c147::isbackpackinventoryenabled()) {
    return;
  }

  var_d035435a9237f3d = player scripts\mp\gametypes\br_pickups::function_b76f69ce63757cea("brloot_equip_reinforced_helmet");

  if(!var_d035435a9237f3d) {
    player scripts\mp\gametypes\br_pickups::function_b76f69ce63757cea("brloot_equip_helmet");
  }
}

function function_d036366985435d3(player, pickupent) {
  if(!istrue(player.var_5b9dafb6c753684) || self.var_5698e367753e03ba == 0) {
    return true;
  }

  return pickupent.count > self.var_5698e367753e03ba;
}

function function_a3a56edac9b26e89(player) {
  if(function_a1207d6155a4cb21(player)) {
    return player.var_113085cb6cb9173c;
  }

  return undefined;
}

function function_4aef917a60fe6683(player) {
  return isDefined(player.var_5698e367753e03ba) && player.var_5698e367753e03ba > 0;
}

function function_914175cb65959c24(player) {
  if(function_4aef917a60fe6683(player)) {
    return player.var_5698e367753e03ba;
  }

  return 0;
}

function helmet_wasbroke(attacker) {
  return isDefined(attacker.var_46019d40799ece5f) && gettime() == attacker.var_46019d40799ece5f;
}

function helmet_setbroke(attacker) {
  attacker.var_46019d40799ece5f = gettime();
}

function helmet_clearbroke(attacker) {
  attacker.var_46019d40799ece5f = undefined;
}

function function_299cd501b61c0d3c(player) {
  if(!function_a1207d6155a4cb21(player)) {
    return;
  }

  currentstate = player getclientomnvar("ui_helmet_protection_state");
  var_1247e7bf97720271 = player.health + player.armorhealth > level.helmetdata.var_692dbeea010dcd1;

  if(currentstate != var_1247e7bf97720271) {
    player setclientomnvar("ui_helmet_protection_state", var_1247e7bf97720271);
  }
}
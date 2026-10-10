/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_268c558ddb2267aa.gsc
*************************************************/

#using scripts\common\damage_effects;
#using scripts\common\values;
#using scripts\cp_mp\killstreaks\white_phosphorus;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\engine\utility;
#using scripts\mp\class;
#using scripts\mp\equipment\gas_grenade;
#using scripts\mp\equipment\temp_v;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\weapons;
#namespace namespace_5e1ef10a2cd37246;

function function_41c4a42ae28c7e16() {
  if(!isDefined(level.var_b35fc6d4a1b9424f)) {
    return;
  }

  if(!isDefined(level.var_b35fc6d4a1b9424f.powers)) {
    return;
  }

  level.var_b35fc6d4a1b9424f.powers["melee"] = function_ea71e04a720a17ae();
}

function function_ea71e04a720a17ae() {
  config = spawnStruct();
  config.maxhealth = 1000;
  config.startinghealth = config.maxhealth;
  config.movespeedscalar = getdvarfloat(@ "hash_8e4a9b19254b5834", 0.5);
  config.maxvehicledamagedivisor = 3;
  config.classstruct = function_fb01d574364a561();
  config.allowscallback = &function_d3796b128ec7a952;
  config.perks = ["specialty_huntmaster", "specialty_tac_resist", "specialty_hustle", "specialty_eod"];
  return config;
}

function function_8db15a70b73b907e() {
  assertex(isDefined(level.var_b35fc6d4a1b9424f.powers["<dev string:x1c>"]));
  return level.var_b35fc6d4a1b9424f.powers["melee"];
}

function function_d3796b128ec7a952(isactivated) {
  if(isactivated) {
    blockedvalues = ["ads", "weapon_switch", "weapon_pickup", "weapon_switch_clip", "reload"];
    scripts\common\values::set_array("melee_superpower", blockedvalues, 0);
    return;
  }

  scripts\common\values::reset_all("melee_superpower");
}

function function_c54f7da664700b4b() {
  assert(isreallyalive(self));
  self.var_2bb368acf8b4df7d = 1;
  scripts\mp\equipment\gas_grenade::gas_updateplayereffects();
  var_912cd62cf459e05c = function_8db15a70b73b907e();
  var_2e37bfd92800e030 = spawnStruct();
  var_2e37bfd92800e030.config = var_912cd62cf459e05c;
  var_2e37bfd92800e030.prevhealth = self.health;
  var_2e37bfd92800e030.maxhealth = self.maxhealth;
  var_2e37bfd92800e030.prevspeedscale = ter_op(isDefined(self.playerstreakspeedscale), self.playerstreakspeedscale, 0);
  var_2e37bfd92800e030.maskomnvar = "ui_gas_mask_juggernaut";
  self.maxhealth = var_912cd62cf459e05c.maxhealth;
  self.health = var_912cd62cf459e05c.startinghealth;
  scripts\mp\weapons::savetogglescopestates();
  scripts\mp\weapons::savealtstates();

  if(isDefined(level.clearbrinventory)) {
    self[[level.clearbrinventory]]();
  }

  self.lastdroppableweaponobj = undefined;

  if(isDefined(var_912cd62cf459e05c.classstruct)) {
    var_2e37bfd92800e030.prevclass = self.lastclass;
    var_2e37bfd92800e030.prevclassstruct = self.classstruct;
    scripts\mp\class::loadout_updateclass(var_912cd62cf459e05c.classstruct, "superpower");
    scripts\mp\class::preloadandqueueclassstruct(var_912cd62cf459e05c.classstruct, 1, 1);
    scripts\mp\class::giveloadout(self.team, "superpower", 0, 1);
  }

  foreach(perk in var_912cd62cf459e05c.perks) {
    scripts\mp\utility\perk::giveperk(perk);
  }

  self[[var_912cd62cf459e05c.allowscallback]](1);
  scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudiosupression();
  self.playerstreakspeedscale = var_912cd62cf459e05c.movespeedscalar;
  scripts\mp\weapons::updatemovespeedscale();
  self.var_eeeda506d0a854e = var_2e37bfd92800e030;
  function_d0d55fbccb850211();
  scripts\cp_mp\utility\killstreak_utility::function_3f55c1fb553a4775(self);
  self notify("tempV_start", "melee");
  thread function_3a82a23975071040();
  thread function_4a4634fd5341faa5();
  thread function_ebbdb959c319dbf4();
  thread function_4bde88943fe1ed4a(self.var_eeeda506d0a854e);
  scripts\common\damage_effects::onexitdeathsdoor(1);
}

function function_fb01d574364a561() {
  classstruct = scripts\mp\class::loadout_getclassstruct();
  classstruct.loadoutarchetype = "archetype_assault";
  classstruct.loadoutprimary = "iw9_me_superfists_mp";
  classstruct.loadoutsecondary = "none";
  classstruct.loadoutequipmentprimary = "equip_throwing_knife";
  return classstruct;
}

function function_3a82a23975071040() {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  function_9c66adbb62a5ef8();
}

function function_4a4634fd5341faa5() {
  self endon("disconnect");
  self endon("tempV_meleeEnd");
  level waittill("game_ended");
  self.maxhealth = self.var_eeeda506d0a854e.prevmaxhealth;
  self.health = self.var_eeeda506d0a854e.prevhealth;
  function_9c66adbb62a5ef8();
}

function function_ebbdb959c319dbf4() {
  level endon("game_ended");
  self endon("tempV_meleeEnd");
  var_eeeda506d0a854e = self.var_eeeda506d0a854e;
  self waittill("disconnect");

  if(isDefined(self)) {
    self.maxhealth = var_eeeda506d0a854e.prevmaxhealth;
    self.health = var_eeeda506d0a854e.prevhealth;
  }
}

function function_d0d55fbccb850211() {
  self notify("tempV_melee_mask_on");
  var_eeeda506d0a854e = self.var_eeeda506d0a854e;

  if(!isDefined(self.var_ffa2b1ee380f2ea4) && !isDefined(self.var_f7dd37e04de8ff0e)) {
    self.var_ffa2b1ee380f2ea4 = "mask_on";
    self.var_f7dd37e04de8ff0e = 1;
  }

  self setclientomnvar("ui_assault_suit_on", 0);
  scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", self.var_ffa2b1ee380f2ea4);
  self setclientomnvar(var_eeeda506d0a854e.maskomnvar, self.var_f7dd37e04de8ff0e);
}

function function_1210f1bc7a0d8940(var_eeeda506d0a854e, retainstate) {
  self notify("tempV_melee_mask_off");

  if(!istrue(retainstate)) {
    self.var_ffa2b1ee380f2ea4 = undefined;
    self.var_f7dd37e04de8ff0e = undefined;
  }

  scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", "off");
  self setclientomnvar(var_eeeda506d0a854e.maskomnvar, 0);
}

function function_9c66adbb62a5ef8() {
  if(!isDefined(self)) {
    return;
  }

  assert(istrue(self.var_2bb368acf8b4df7d));
  assert(isDefined(self.var_eeeda506d0a854e));
  self notify("tempV_end");
  var_eeeda506d0a854e = self.var_eeeda506d0a854e;
  var_912cd62cf459e05c = var_eeeda506d0a854e.config;
  self.musicplaying = undefined;
  self.var_a23031c04df01bf = undefined;
  self.var_59651a2893429638 = undefined;
  function_1210f1bc7a0d8940(self.var_eeeda506d0a854e);
  self[[var_912cd62cf459e05c.allowscallback]](1);
  scripts\cp_mp\utility\killstreak_utility::function_17576a4cdcd447a7(self);

  if(isreallyalive(self)) {
    self.maxhealth = var_eeeda506d0a854e.prevmaxhealth;
    self.health = var_eeeda506d0a854e.prevhealth;
    scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudiosupression();

    if(isDefined(var_912cd62cf459e05c.classstruct)) {
      scripts\mp\class::respawnitems_assignrespawnitems(var_eeeda506d0a854e.respawnitems);
      scripts\mp\class::giveloadout(self.team, var_eeeda506d0a854e.prevclass, 0, 1, 1);
    }

    foreach(perk, unused in var_912cd62cf459e05c.perks) {
      scripts\mp\utility\perk::removeperk(perk);
    }
  }

  self.playerstreakspeedscale = var_eeeda506d0a854e.prevspeedscale;
  scripts\mp\weapons::updatemovespeedscale();
  self.var_eeeda506d0a854e = undefined;
  self.var_2bb368acf8b4df7d = undefined;
}

function function_4bde88943fe1ed4a(var_eeeda506d0a854e) {
  self endon("juggernaut_end");
  self endon("death or disconnect");
  level endon("game_ended");
  startinghealth = self.health;
  stage1damage = startinghealth - startinghealth * 0.1;
  stage2damage = startinghealth - startinghealth * 0.35;
  stage3damage = startinghealth - startinghealth * 0.6;
  stage4damage = startinghealth - startinghealth * 0.85;
  overlaystate = 1;
  var_ea0a3076fb747a79 = overlaystate;
  overlaystatelabel = "mask_on";

  while(true) {
    waittill_any_2("damage", "jugg_health_regen");

    if(self.health <= stage4damage) {
      overlaystatelabel = "mask_damage_critical";
      overlaystate = 5;
    } else if(self.health <= stage3damage) {
      overlaystatelabel = "mask_damage_high";
      overlaystate = 4;
    } else if(self.health <= stage2damage) {
      overlaystatelabel = "mask_damage_med";
      overlaystate = 3;
    } else if(self.health <= stage1damage) {
      overlaystatelabel = "mask_damage_low";
      overlaystate = 2;
    } else {
      overlaystatelabel = "mask_on";
      overlaystate = 1;
    }

    if(var_ea0a3076fb747a79 != overlaystate) {
      scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", overlaystatelabel);
      self setclientomnvar(var_eeeda506d0a854e.maskomnvar, overlaystate);
      var_ea0a3076fb747a79 = overlaystate;
      self.var_ffa2b1ee380f2ea4 = overlaystatelabel;
      self.var_f7dd37e04de8ff0e = overlaystate;
    }
  }
}
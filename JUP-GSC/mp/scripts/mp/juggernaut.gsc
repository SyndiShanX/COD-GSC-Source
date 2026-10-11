/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\juggernaut.gsc
***********************************************/

#using script_74b851b7aa1ef32d;
#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\execution;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\juggernaut;
#using scripts\cp_mp\killstreaks\white_phosphorus;
#using scripts\cp_mp\talking_gun;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\class;
#using scripts\mp\equipment;
#using scripts\mp\equipment\gas_grenade;
#using scripts\mp\gameobjects;
#using scripts\mp\hud_message;
#using scripts\mp\perks\perkpackage;
#using scripts\mp\supers;
#using scripts\mp\teams;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\script;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;
#namespace juggernaut;

function init() {
  level.activejuggernauts = [];
  level.var_ed61c38f5c8bb414 = ["pristine", "damaged"];
  level.var_13819795c6ee9ff8 = ["helmet", "neckguard", "backpack", "shoulderpad_l", "shoulderpad_r", "forearmpad_l", "forearmpad_r", "qamis", "thighpad_l", "thighpad_r"];

  setdevdvarifuninitialized(@ "hash_caba4093ed4a5d5d", 0);
  setdevdvarifuninitialized(@ "hash_63bf655a03b825eb", 0);
  setdevdvarifuninitialized(@ "hash_ae2c4f86ffaf24db", 0);
  setdevdvarifuninitialized(@ "hash_4f7da19a233d6916", 0);
}

function jugg_makejuggernaut(juggconfig, streakinfo, bundle) {
  assert(isreallyalive(self));

  if(scripts\engine\utility::callsharedfunc("escort", "isZombie") || istrue(level.var_39faa7e60a6a717c)) {
    bundle = level.streakglobals.streakbundles["juggernaut_mutant"];

    if(isDefined(level.var_3b500f50aa9520a4)) {
      bundle = [[level.var_3b500f50aa9520a4]](bundle);
    }

    juggconfig = scripts\cp_mp\killstreaks\juggernaut::function_23f0145756ed19cb(bundle);
  }

  validstance = function_a5af0a72ac912a3d(juggconfig);

  if(!isDefined(validstance)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS/JUGG_CANNOT_BECOME");
    return false;
  }

  needtochangestance = validstance != self getstance();
  self.isjuggernaut = 1;
  scripts\mp\battlechatter_mp::disablebattlechatter(self);
  scripts\mp\equipment\gas_grenade::gas_updateplayereffects();
  juggcontext = spawnStruct();
  juggcontext.juggconfig = juggconfig;
  customization = scripts\mp\teams::getoperatorcustomization();
  juggcontext.prevhealth = self.health;
  juggcontext.prevmaxhealth = self.maxhealth;
  juggcontext.prevbody = customization[0];
  juggcontext.prevhead = customization[1];
  juggcontext.prevviewmodel = self getcustomizationviewmodel();
  juggcontext.prevspeedscale = self.playerstreakspeedscale;
  juggcontext.prevsuit = self.suit;
  juggcontext.prevclothtype = self.clothtype;
  juggcontext.var_aaac4cd2da0aa927 = self.operatorcustomization.geartype;
  juggcontext.maskomnvar = "ui_gas_mask_juggernaut";

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.execution)) {
    juggcontext.prevexecution = self.operatorcustomization.execution;
  }

  if(isDefined(self.super)) {
    juggcontext.var_c18e401ced26383c = getcurrentsuperpoints();
  }

  if(!isDefined(juggconfig.usearmorparts)) {
    juggconfig.usearmorparts = 1;
  }

  if(callsharedfunc("escort", "isZombie") || istrue(level.var_39faa7e60a6a717c)) {
    juggconfig.usearmorparts = 0;
    juggconfig.perks = [];
  }

  if(juggconfig.usearmorparts) {
    juggcontext.partshealth = [];
    juggcontext.partshealth["head_health"] = ter_op(isDefined(juggconfig.head_health), juggconfig.head_health, 100);
    juggcontext.partshealth["torso_upper_health"] = ter_op(isDefined(juggconfig.torso_upper_health), juggconfig.torso_upper_health, 100);
    juggcontext.partshealth["torso_lower_health"] = ter_op(isDefined(juggconfig.torso_lower_health), juggconfig.torso_lower_health, 100);
    juggcontext.partshealth["right_upper_arm_health"] = ter_op(isDefined(juggconfig.right_upper_arm_health), juggconfig.right_upper_arm_health, 100);
    juggcontext.partshealth["right_lower_arm_health"] = ter_op(isDefined(juggconfig.right_lower_arm_health), juggconfig.right_lower_arm_health, 100);
    juggcontext.partshealth["left_upper_arm_health"] = ter_op(isDefined(juggconfig.left_upper_arm_health), juggconfig.left_upper_arm_health, 100);
    juggcontext.partshealth["left_lower_arm_health"] = ter_op(isDefined(juggconfig.left_lower_arm_health), juggconfig.left_lower_arm_health, 100);
    juggcontext.partshealth["right_leg_health"] = ter_op(isDefined(juggconfig.right_leg_health), juggconfig.right_leg_health, 100);
    juggcontext.partshealth["left_leg_health"] = ter_op(isDefined(juggconfig.left_leg_health), juggconfig.left_leg_health, 100);
    self.var_a23031c04df01bf = &function_4217f11ffb352425;
  }

  juggcontext.executionlist = ["execution_mp_juggernaut_01", "execution_mp_juggernaut_02", "execution_mp_juggernaut_03"];
  self.maxhealth = juggconfig.maxhealth;
  self.health = juggconfig.startinghealth;
  self.var_59651a2893429638 = 0;
  scripts\mp\weapons::savetogglescopestates();
  scripts\mp\weapons::savealtstates();

  if(isDefined(level.clearbrinventory) && !istrue(self.gulag)) {
    self[[level.clearbrinventory]]();
  }

  if(isDefined(juggconfig.classstruct) && !scripts\mp\utility\game::isjuggermoshgamemode()) {
    respawnitems = scripts\mp\class::respawnitems_saveplayeritemstostruct();

    if(isDefined(level.var_dc475334f61b89d)) {
      [[level.var_dc475334f61b89d]](respawnitems);
    }

    juggcontext.respawnitems = respawnitems;
    juggcontext.prevclass = self.lastclass;
    juggcontext.prevclassstruct = self.classstruct;
    scripts\mp\class::loadout_updateclass(juggconfig.classstruct, "juggernaut");
    scripts\mp\class::preloadandqueueclassstruct(juggconfig.classstruct, 1, 1);
    scripts\mp\class::giveloadout(self.team, "juggernaut", 0, 1);

    if(isDefined(juggconfig.classstruct.loadoutequipmentprimary) && isDefined(juggconfig.var_238382d33b25a18a) && juggconfig.var_238382d33b25a18a > 1) {
      scripts\mp\equipment::incrementequipmentammo(juggconfig.classstruct.loadoutequipmentprimary, juggconfig.var_238382d33b25a18a - 1);
    }

    if(isDefined(juggconfig.classstruct.loadoutequipmentsecondary) && isDefined(juggconfig.var_2c455d4333df379f) && juggconfig.var_2c455d4333df379f > 1) {
      scripts\mp\equipment::incrementequipmentammo(juggconfig.classstruct.loadoutequipmentsecondary, juggconfig.var_2c455d4333df379f - 1);
    }

    var_676dfe39dfe67969 = isDefined(juggconfig.classstruct.loadoutequipmentprimary) && isDefined(juggconfig.var_238382d33b25a18a) && juggconfig.var_238382d33b25a18a > 0;
    var_66b2e33eabc9522d = isDefined(juggconfig.classstruct.loadoutequipmentsecondary) && isDefined(juggconfig.var_2c455d4333df379f) && juggconfig.var_2c455d4333df379f > 0;
    var_3227d3b8596888f9 = 0;

    if(var_676dfe39dfe67969 && var_66b2e33eabc9522d) {
      var_3227d3b8596888f9 = 3;
    } else if(var_676dfe39dfe67969) {
      var_3227d3b8596888f9 = 1;
    } else if(var_66b2e33eabc9522d) {
      var_3227d3b8596888f9 = 2;
    }

    self setclientomnvar("ui_gas_mask_juggernaut_equipment", var_3227d3b8596888f9);
  }

  self.lastdroppableweaponobj = undefined;

  foreach(perk, unused in juggconfig.perks) {
    giveperk(perk);
  }

  if(istrue(self.pickedupcoreminigun)) {
    val::group_reset("fakeJugg");
    self.pickedupcoreminigun = undefined;
  }

  jugg_toggleallows(juggconfig.allows, 0);
  self skydive_setbasejumpingstatus(0);
  scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudiosupression();
  self function_ecdccfda4326de02();
  jugg_setModel(juggconfig);
  self.playerstreakspeedscale = juggconfig.movespeedscalar;
  scripts\mp\weapons::updatemovespeedscale();
  self.juggcontext = juggcontext;
  _setsuit(juggconfig.suit);
  self setclothtype(getxhash(juggconfig.clothtype));
  self setgeartype(juggconfig.geartype);
  jugg_enableoverlay(juggcontext);
  function_3f55c1fb553a4775(self);

  if(getdvarint(@ "hash_4f7da19a233d6916", 0)) {
    function_551e4a3bb31658bc(juggcontext.juggconfig.execution);
  }

  if(juggconfig.infiniteammo) {
    thread infiniteammothread(juggconfig.infiniteammoupdaterate, undefined, 1);
  } else {
    weaponslist = self getweaponslistall();

    foreach(weapon in weaponslist) {
      if(!function_a585b2993726d3b(juggconfig, weapon.basename)) {
        continue;
      }

      self setweaponammoclip(weapon, weaponclipsize(weapon));

      if(jugg_canreload()) {
        self givemaxammo(weapon);
        thread jugg_managestockammo(weapon);
      }
    }
  }

  self.streakinfo = streakinfo;
  self notify("juggernaut_start");
  thread scripts\mp\gameobjects::onjuggernaut();

  if(!isDefined(bundle)) {
    bundle = level.streakglobals.streakbundles["juggernaut"];
  }

  if(isDefined(streakinfo)) {
    thread jugg_watchmusictoggle(streakinfo.streakname);
  } else {
    thread jugg_watchmusictoggle();
  }

  thread jugg_watchfordeath();
  thread jugg_watchforgameend();
  thread jugg_watchfordisconnect();
  thread jugg_watchforfire();
  thread jugg_watchherodrop();
  thread function_5b7c34dbc50c3c4e(juggconfig.usearmorparts);
  thread jugg_watchoverlaydamagestates(self.juggcontext);
  thread jugg_watchforoverlayexecutiontoggle();
  thread function_e7282c5ce62c103d();
  thread function_24b195a997fe1263();
  thread function_eb351ef41167c059(bundle);

  if(!(isDefined(bundle) && istrue(bundle.var_5496352e07d93f72)) && jugg_canparachute()) {
    self skydive_setbasejumpingstatus(1);
    self skydive_setdeploymentstatus(1);
    self skydive_cutparachuteon();
  }

  if(isDefined(level.addjuggfunctionality)) {
    self[[level.addjuggfunctionality]]();
  }

  self.var_64ad02e4f03697a0 = isDefined(bundle) && istrue(bundle.var_64ad02e4f03697a0);

  if(istrue(self.var_64ad02e4f03697a0)) {
    self setstance("stand");
  } else if(needtochangestance) {
    self setstance(validstance);
  }

  scripts\common\damage_effects::onexitdeathsdoor(1);
  self.var_9c1941d3bc009d2e = isDefined(bundle) && istrue(bundle.var_9c1941d3bc009d2e);
  self.var_7e5d64139d5dabb6 = isDefined(bundle) && istrue(bundle.var_7e5d64139d5dabb6);
  jugg_addtoactivejugglist();
  namespace_a850435086c88de3::doonactionscoreevent(2, "juggernautEquipped");
  scripts\cp_mp\talking_gun::function_55b08d6d71b41402(self, "become_juggernaut");
  function_a5a593f3ab4f7077(bundle, self, self.team);

  if(isDefined(level.var_7e9532b5406cfa7d)) {
    self[[level.var_7e9532b5406cfa7d]]();
  }

  return true;
}

function jugg_removejuggernaut(is_death) {
  if(!isDefined(self)) {
    return;
  }

  assert(istrue(self.isjuggernaut));
  assert(isDefined(self.juggcontext));
  self notify("juggernaut_end");
  juggcontext = self.juggcontext;
  juggconfig = juggcontext.juggconfig;
  self setscriptablepartstate("remove_juggernaut", "remove", 0);
  self.musicplaying = undefined;
  self.var_a23031c04df01bf = undefined;
  self.var_59651a2893429638 = undefined;
  jugg_disableoverlay(juggcontext);
  jugg_toggleallows(juggconfig.allows, 1);
  function_17576a4cdcd447a7(self);

  if(isreallyalive(self)) {
    self.maxhealth = juggcontext.prevmaxhealth;
    self.health = juggcontext.prevhealth;
    scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudiosupression();

    if(isDefined(juggconfig.classstruct)) {
      scripts\mp\class::respawnitems_assignrespawnitems(juggcontext.respawnitems);
      scripts\mp\class::giveloadout(self.team, juggcontext.prevclass, 0, 1, 1);
    }

    if(isDefined(juggcontext.var_c18e401ced26383c)) {
      setsuperbasepoints(juggcontext.var_c18e401ced26383c);
    }

    foreach(perk, unused in juggconfig.perks) {
      removeperk(perk);
    }
  }

  if(juggconfig.infiniteammo) {
    stopinfiniteammothread();
  }

  jugg_restoremodel(juggcontext);
  self.playerstreakspeedscale = juggcontext.prevspeedscale;
  scripts\mp\weapons::updatemovespeedscale();

  if(istrue(is_death)) {
    self endon("disconnect");
    waitframe();
  }

  _setsuit(juggcontext.prevsuit);
  self setclothtype(getxhash(juggcontext.prevclothtype));
  self setgeartype(juggcontext.var_aaac4cd2da0aa927);
  self setscriptablepartstate("juggernaut", "neutral", 0);

  if(isDefined(juggcontext.prevexecution)) {
    scripts\cp_mp\execution::_giveexecution(juggcontext.prevexecution);
  }

  if(jugg_canparachute()) {
    self skydive_setbasejumpingstatus(1);
    self skydive_setdeploymentstatus(1);
    self skydive_cutparachuteon();
  } else {
    self skydive_setbasejumpingstatus(0);
    self skydive_setdeploymentstatus(0);
    self skydive_cutparachuteoff();
  }

  if(istrue(self.var_64ad02e4f03697a0)) {
    self setstance("stand");
  }

  self.isjuggernaut = 0;
  self.juggcontext = undefined;
  self.streakinfo = undefined;
  self.var_64ad02e4f03697a0 = undefined;
  self.var_9c1941d3bc009d2e = 0;
  self.var_7e5d64139d5dabb6 = undefined;
  scripts\mp\battlechatter_mp::enablebattlechatter(self);
}

function jugg_createconfig(skipallows, additionalallows) {
  config = spawnStruct();
  config.maxhealth = 3000;
  config.startinghealth = config.maxhealth;
  config.movespeedscalar = -0.2;
  config.maxvehicledamagedivisor = 5;

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    config.maxvehicledamagedivisor = 3;
  }

  config.forcetostand = 1;
  config.suit = "iw9_juggernaut_mp";
  config.geartype = "milhvygr";
  config.infiniteammo = 0;
  config.infiniteammoupdaterate = undefined;
  config.usearmorparts = 1;
  config.classstruct = jugg_getdefaultclassstruct();
  config.allows = [];
  config.allows["stick_kill"] = 1;
  config.allows["health_regen"] = 1;
  config.allows["one_hit_melee_victim"] = 1;
  config.allows["flashed"] = 1;
  config.allows["stunned"] = 1;
  config.allows["prone"] = 1;
  config.allows["equipment_primary"] = 1;
  config.allows["equipment_secondary"] = 1;
  config.allows["supers"] = 1;
  config.allows["killstreaks"] = 1;
  config.allows["slide"] = 1;
  config.allows["weapon_pickup"] = 1;
  config.allows["execution_victim"] = 1;
  config.allows["cough_gesture"] = 1;
  config.allows["offhand_throwback"] = 1;
  config.perks = [];
  config.perks["specialty_stun_resistance"] = 1;
  config.perks["specialty_sharp_focus"] = 1;
  config.perks["specialty_melee_resist"] = 1;
  config.perks["specialty_blastshield"] = 1;
  config.perks["specialty_armorpiercing"] = 1;
  return config;
}

function jugg_toggleallows(allows, allowed) {
  if(!allowed) {
    foreach(allow_name, used in allows) {
      if(used) {
        allow_name = tolower(allow_name);
        val::set("juggernaut", allow_name, 0);
      }
    }
  }

  if(!istrue(level.disablemount)) {
    if(!allowed) {
      val::set("juggernaut", "mount_top", 0);
      val::set("juggernaut", "mount_side", 0);
      return;
    }

    val::reset_all("juggernaut");
  }
}

function jugg_getdefaultclassstruct() {
  classstruct = scripts\mp\class::loadout_getclassstruct();
  classstruct.loadoutarchetype = "archetype_assault";
  classstruct.loadoutprimary = "iw9_minigunksjugg_mp";
  classstruct.loadoutsecondary = "iw9_pi_golf18_mp";
  return classstruct;
}

function jugg_watchmusictoggle(streakname) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("juggernaut_end");
  audio_waittime = 0;

  if(!isbot(self) && !isagent(self)) {
    if(istrue(level.var_39faa7e60a6a717c)) {
      self notifyonplayercommand("toggle_music", "+actionslot 4");
    } else {
      self notifyonplayercommand("toggle_music", "+actionslot 3");
    }

    self notifyonplayercommand("toggle_music", "killstreak_wheel");
  }

  var_e5c8d9d7e001af68 = makeweapon("ks_gesture_jugg_music_mp");
  gesturefiretime = weaponfiretime(var_e5c8d9d7e001af68);

  if(!isDefined(self.musicplaying)) {
    var_aa73ba383f8079ea = self getjuggdefaultmusicenabled();
    self.musicplaying = var_aa73ba383f8079ea;
  }

  if(!istrue(self.musicplaying)) {
    self setscriptablepartstate("juggernaut", "neutral", 0);
  } else if(isDefined(streakname) && streakname == "juggernaut_recon") {
    self setscriptablepartstate("juggernaut", "music_recon", 0);
  } else if(isDefined(level.music_style) && level.music_style == "mexico") {
    self setscriptablepartstate("juggernaut", "music_mx", 0);
  } else {
    self setscriptablepartstate("juggernaut", "music", 0);
  }

  if(scripts\mp\utility\game::isjuggermoshgamemode()) {
    self setscriptablepartstate("juggernaut", "neutral", 0);
  }

  if(scripts\cp_mp\utility\game_utility::ismagellanmode()) {
    self setclientomnvar("ui_enable_juggernaut_music", istrue(self.musicplaying));
  }

  while(true) {
    self waittill("toggle_music");

    if(scripts\mp\utility\game::isjuggermoshgamemode()) {
      continue;
    }

    if(self isonladder() || self ismantling()) {
      continue;
    }

    self giveandfireoffhand(var_e5c8d9d7e001af68);
    self playsoundonmovingent("mp_jugg_mus_toggle_foley");
    self playlocalsound("mp_jugg_mus_toggle_button");
    var_6e79fbf50c8ea64f = 0.2;

    if(istrue(self.musicplaying)) {
      var_6e79fbf50c8ea64f = 0.65;
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_6e79fbf50c8ea64f);

    if(istrue(self.musicplaying)) {
      self.musicplaying = 0;
      self setscriptablepartstate("juggernaut", "neutral", 0);
    } else {
      self.musicplaying = 1;

      if(isDefined(streakname) && streakname == "juggernaut_recon") {
        self setscriptablepartstate("juggernaut", "music_recon", 0);
      } else {
        self setscriptablepartstate("juggernaut", "music", 0);
      }
    }

    if(scripts\cp_mp\utility\game_utility::ismagellanmode()) {
      self setclientomnvar("ui_enable_juggernaut_music", istrue(self.musicplaying));
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1.5);
  }
}

function jugg_watchfordeath() {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");

  if(isDefined(self.juggcontext)) {
    childthread jugg_removejuggernaut(1);
  }
}

function jugg_watchforgameend() {
  self endon("disconnect");
  self endon("juggernaut_end");
  juggcontext = self.juggcontext;
  level waittill("game_ended");
  self.maxhealth = juggcontext.prevmaxhealth;
  self.health = juggcontext.prevhealth;
  jugg_disableoverlay(juggcontext);
  self setscriptablepartstate("juggernaut", "neutral", 0);
}

function jugg_watchfordisconnect() {
  self endon("juggernaut_end");
  juggcontext = self.juggcontext;
  self waittill("disconnect");

  if(isDefined(self)) {
    self.maxhealth = juggcontext.prevmaxhealth;
    self.health = juggcontext.prevhealth;
  }
}

function jugg_watchforfire() {
  self endon("juggernaut_end");

  while(true) {
    self waittill("weapon_fired");

    if(isDefined(self.streakinfo) && isDefined(self.streakinfo.shots_fired)) {
      self.streakinfo.shots_fired++;
    }
  }
}

function jugg_getjuggmodels(juggconfig) {
  models = [];

  if(isDefined(juggconfig.bodymodel)) {
    models["body"] = juggconfig.bodymodel;
  } else {
    models["body"] = "body_sp_opforce_aq_jugg_basebody";
  }

  if(isDefined(juggconfig.headmodel)) {
    models["head"] = juggconfig.headmodel;
  } else {
    models["head"] = "head_sp_opforce_aq_jugg";
  }

  if(isDefined(juggconfig.viewmodel)) {
    models["view"] = juggconfig.viewmodel;
  } else {
    models["view"] = "mp_vm_arms_jugg_aq_iw9_1_1";
  }

  return models;
}

function jugg_setModel(juggconfig) {
  models = jugg_getjuggmodels(juggconfig);

  if(isDefined(self.headmodel)) {
    self detach(self.headmodel);
  }

  bodymodelname = models["body"];
  headmodelname = models["head"];
  viewmodelname = models["view"];
  self setModel(bodymodelname);
  self setviewmodel(viewmodelname);
  self attach(headmodelname, "", 1);
  self.headmodel = headmodelname;
}

function jugg_restoremodel(juggcontext) {
  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    self setcustomization(juggcontext.prevbody, juggcontext.prevhead);
    scripts\mp\teams::setcharactermodels(juggcontext.prevbody, juggcontext.prevhead, juggcontext.prevviewmodel);
  }
}

function function_a5af0a72ac912a3d(juggconfig) {
  validstance = undefined;
  curstance = self getstance();

  if(curstance != "stand") {
    var_d906346cab6e17c8 = !istrue(juggconfig.forcetostand) && !isDefined(juggconfig.allows["crouch"]) || istrue(juggconfig.allowcrouch);
    var_6900f3419d3c4dd0 = !istrue(juggconfig.forcetostand) && !isDefined(juggconfig.allows["prone"]) || istrue(juggconfig.allowprone);
    contentoverride = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1, 1, 0);

    if(!var_d906346cab6e17c8 && !var_6900f3419d3c4dd0) {
      validstance = "stand";
    } else if(curstance == "crouch") {
      if(!var_d906346cab6e17c8) {
        canstand = scripts\engine\trace::ray_trace_passed(self.origin, getstancetop("stand"), self, contentoverride);

        if(canstand) {
          validstance = "stand";
        }
      } else {
        validstance = "crouch";
      }
    } else if(curstance == "prone") {
      if(!var_6900f3419d3c4dd0) {
        if(var_d906346cab6e17c8) {
          cancrouch = scripts\engine\trace::ray_trace_passed(self.origin, getstancetop("crouch"), self, contentoverride);

          if(cancrouch) {
            validstance = "crouch";
          }
        } else {
          canstand = scripts\engine\trace::ray_trace_passed(self.origin, getstancetop("stand"), self, contentoverride);

          if(canstand) {
            validstance = "stand";
          }
        }
      } else {
        validstance = "prone";
      }
    }
  } else {
    validstance = "stand";
  }

  return validstance;
}

function function_e7282c5ce62c103d() {
  self endon("juggernaut_end");
  self endon("death_or_disconnect");
  level endon("game_ended");
  juggcontext = self.juggcontext;

  while(true) {
    self waittill("remote_enter");
    jugg_disableoverlay(juggcontext, 1);
    self waittill("remote_exit");
    jugg_enableoverlay(juggcontext);
  }
}

function jugg_watchoverlaydamagestates(juggcontext) {
  self endon("juggernaut_end");
  self endon("death or disconnect");
  level endon("game_ended");

  if(scripts\mp\utility\game::isjuggermoshgamemode() || scripts\mp\utility\game::getgametype() == "warrior") {
    return;
  }

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
      self setclientomnvar(juggcontext.maskomnvar, overlaystate);
      var_ea0a3076fb747a79 = overlaystate;
      self.juggoverlaystatelabel = overlaystatelabel;
      self.juggoverlaystate = overlaystate;
    }
  }
}

function jugg_watchforoverlayexecutiontoggle() {
  self endon("juggernaut_end");
  self endon("death_or_disconnect");
  level endon("game_ended");
  juggcontext = self.juggcontext;
  var_2bf9392cab435cdf = 0;

  while(true) {
    if(!self isinexecutionattack()) {
      if(istrue(var_2bf9392cab435cdf)) {
        jugg_enableoverlay(juggcontext);
        var_2bf9392cab435cdf = 0;

        if(getdvarint(@ "hash_4f7da19a233d6916", 0)) {
          function_551e4a3bb31658bc("random");
        }
      }

      waitframe();
      continue;
    }

    if(!istrue(var_2bf9392cab435cdf)) {
      jugg_disableoverlay(juggcontext, 1);
      var_2bf9392cab435cdf = 1;
    }

    waitframe();
  }
}

function private function_e657bb1fe2ef34a8() {
  juggcontext = self.juggcontext;
  currentexecution = self.var_3be02516d5f4bff0;
  var_986a24725e33212a = [];

  foreach(execution in juggcontext.executionlist) {
    if(isDefined(currentexecution) && execution == currentexecution) {
      continue;
    }

    var_986a24725e33212a[var_986a24725e33212a.size] = execution;
  }

  newexecution = var_986a24725e33212a[randomint(var_986a24725e33212a.size)];

  if(!isDefined(newexecution)) {
    newexecution = currentexecution;
  }

  return newexecution;
}

function private function_551e4a3bb31658bc(executionref) {
  juggcontext = self.juggcontext;
  var_329dd2016317e381 = executionref;

  if(!isDefined(var_329dd2016317e381) || executionref == "random") {
    var_329dd2016317e381 = function_e657bb1fe2ef34a8();
  }

  scripts\cp_mp\execution::_giveexecution(var_329dd2016317e381);
  self.var_3be02516d5f4bff0 = var_329dd2016317e381;
}

function private function_24b195a997fe1263() {
  self endon("disconnect");
  self endon("juggernaut_end");
  config = self.juggcontext.juggconfig;
  swimweapon = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845(config.classstruct.loadoutsecondary);
  inwater = 0;

  while(true) {
    if(self isswimming()) {
      if(!istrue(inwater)) {
        scripts\cp_mp\utility\inventory_utility::_giveweapon(swimweapon, undefined, undefined, 1);
        self switchtoweaponimmediate(swimweapon);
        inwater = 1;
      }
    } else if(istrue(inwater)) {
      if(scripts\engine\utility::issharedfuncdefined("juggMosh", "swimExitSwitchToWeapon")) {
        self[[scripts\engine\utility::getsharedfunc("juggMosh", "swimExitSwitchToWeapon")]](swimweapon);
        inwater = 0;
        wait 0.05;
        continue;
      }

      scripts\cp_mp\utility\inventory_utility::_takeweapon(swimweapon);
      self switchtoweaponimmediate(jugg_getminigunweapon());
      inwater = 0;
    }

    wait 0.05;
  }
}

function private function_eb351ef41167c059(bundle) {
  self endon("disconnect");
  self endon("juggernaut_end");

  if(!isDefined(bundle.juggernautduration) || bundle.juggernautduration <= 0) {
    return;
  }

  config = self.juggcontext.juggconfig;
  self.loadoutfieldupgrade1 = "super_juggernaut";
  thread scripts\mp\perks\perkpackage::perkpackage_initperkpackages();
  var_35c21af2867bac3c = 0;
  pointsneeded = getsuperpointsneeded();

  if(pointsneeded <= 0) {
    return;
  }

  while(var_35c21af2867bac3c < bundle.juggernautduration) {
    var_35c21af2867bac3c += 0.1;
    setsuperbasepoints((1 - var_35c21af2867bac3c / bundle.juggernautduration) * pointsneeded);
    wait 0.1;
  }

  thread jugg_removejuggernaut();
}

function private jugg_enableoverlay(juggcontext, forcereset) {
  if(scripts\mp\utility\game::isjuggermoshgamemode() || scripts\mp\utility\game::getgametype() == "warrior") {
    return;
  }

  self notify("jugg_mask_on");

  if(!isDefined(self.juggoverlaystatelabel) && !isDefined(self.juggoverlaystate) || istrue(forcereset)) {
    self.juggoverlaystatelabel = "mask_on";
    self.juggoverlaystate = 1;
  }

  self setclientomnvar("ui_assault_suit_on", 0);
  scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", self.juggoverlaystatelabel);
  self setclientomnvar(juggcontext.maskomnvar, self.juggoverlaystate);
}

function private jugg_disableoverlay(juggcontext, retainstate) {
  self notify("jugg_mask_off");

  if(!istrue(retainstate)) {
    self.juggoverlaystatelabel = undefined;
    self.juggoverlaystate = undefined;
  }

  scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", "off");
  self setclientomnvar(juggcontext.maskomnvar, 0);
}

function jugg_getmovespeedscalar() {
  return -0.2;
}

function jugg_getminigunweapon() {
  assertex(scripts\mp\utility\killstreak::isjuggernaut(), "<dev string:x1c>");
  minigunweaponobj = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845(self.juggcontext.juggconfig.classstruct.loadoutprimary);
  return minigunweaponobj;
}

function jugg_canreload() {
  assertex(scripts\mp\utility\killstreak::isjuggernaut(), "<dev string:x79>");
  return istrue(self.juggcontext.juggconfig.usereload);
}

function jugg_canuseweaponpickups() {
  assertex(scripts\mp\utility\killstreak::isjuggernaut(), "<dev string:xcb>");
  return istrue(self.juggcontext.juggconfig.useweaponpickups);
}

function jugg_managestockammo(weapon) {
  self endon("juggernaut_end");
  level endon("game_ended");
  stockammo = self getweaponammostock(weapon);
  thread jugg_watchmanualreload(weapon, stockammo);
  thread jugg_watchammo(weapon, stockammo);

  while(true) {
    self waittill("minigun_restock");
    self setweaponammostock(weapon, stockammo);
  }
}

function jugg_watchmanualreload(weapon, startingstockammo) {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  level endon("game_ended");

  while(true) {
    if(self reloadbuttonPressed()) {
      currentstockammo = self getweaponammostock(weapon);

      if(currentstockammo < startingstockammo) {
        self notify("minigun_restock");
      }
    }

    waitframe();
  }
}

function jugg_watchammo(weapon, startingstockammo) {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  level endon("game_ended");

  while(true) {
    currentclipammo = self getweaponammoclip(weapon);

    if(currentclipammo == 0) {
      currentstockammo = self getweaponammostock(weapon);

      if(currentstockammo < startingstockammo) {
        self notify("minigun_restock");
      }
    }

    waitframe();
  }
}

function jugg_addtoactivejugglist() {
  if(!isDefined(level.activejuggernauts)) {
    level.activejuggernauts = [];
  }

  level.activejuggernauts[level.activejuggernauts.size] = self;
  thread jugg_watchforremovejugg();
}

function jugg_watchforremovejugg() {
  level endon("game_ended");
  waittill_any_in_array_return_no_endon_death(["juggernaut_end", "disconnect"]);
  jugg_removefromactivejugglist();
}

function jugg_removefromactivejugglist() {
  if(!isDefined(self)) {
    level.activejuggernauts = array_removeundefined(level.activejuggernauts);
    return;
  }

  level.activejuggernauts = array_remove(level.activejuggernauts, self);
}

function jugg_watchherodrop() {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  level endon("game_ended");
  juggconfig = self.juggcontext.juggconfig;
  juggconfig.herodrop = 0;

  while(true) {
    thread function_12928f267a4a789c(juggconfig);
    self waittill("perform_hero_drop");

    if(!istrue(juggconfig.herodrop)) {
      juggconfig.herodrop = 1;
      [damagemax, damagemin] = [2000, 500];

      if(isDefined(level.var_d467dc0100a60a11) && isDefined(level.var_d48ace0100cc32ff)) {
        [damagemax, damagemin] = [level.var_d467dc0100a60a11, level.var_d48ace0100cc32ff];
      }

      self radiusdamage(self.origin, 300, damagemax, damagemin, self, "MOD_CRUSH");

      if(isDefined(level.var_acc9df39da68b525)) {
        self[[level.var_acc9df39da68b525]]();
      }

      thread jugg_setherodropscriptable(juggconfig);
    }
  }
}

function function_12928f267a4a789c(juggconfig) {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  self endon("perform_hero_drop");
  level endon("game_ended");
  droploop = 0;
  var_87bd779b6eb7ebb5 = 0.5;
  delaycounter = var_87bd779b6eb7ebb5;
  var_29c3e7e659ebd38c = getdvarint(@ "bg_falldamageminheight");

  if(!isDefined(var_29c3e7e659ebd38c)) {
    var_29c3e7e659ebd38c = 225;
  }

  while(true) {
    if(function_ba71f6475f1c75d9()) {
      delaycounter -= level.framedurationseconds;

      if(delaycounter <= 0) {
        delaycounter = 0;

        if(!istrue(droploop)) {
          var_c2d7296c1d69dc0f = scripts\engine\trace::ray_trace_passed(self.origin, self.origin - (0, 0, var_29c3e7e659ebd38c), self);

          if(istrue(var_c2d7296c1d69dc0f)) {
            droploop = 1;
            self setscriptablepartstate("heroDiveVfx", "falling", 0);
          }
        }
      }
    } else if(istrue(droploop) && !istrue(juggconfig.herodrop)) {
      droploop = 0;
      delaycounter = var_87bd779b6eb7ebb5;
      self setscriptablepartstate("heroDiveVfx", "off", 0);
    }

    waitframe();
  }
}

function function_ba71f6475f1c75d9() {
  if(self ismantling()) {
    return false;
  }

  if(self isonladder()) {
    return false;
  }

  if(scripts\cp_mp\utility\player_utility::isinvehicle(1)) {
    return false;
  }

  if(!self isonground()) {
    if(self isparachuting()) {
      return false;
    }

    if(self isswimming()) {
      return false;
    }

    return true;
  }

  return false;
}

function jugg_setherodropscriptable(juggconfig) {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  level endon("game_ended");
  self setscriptablepartstate("heroDiveVfx", "impact", 0);
  wait 1;
  self setscriptablepartstate("heroDiveVfx", "off", 0);
  juggconfig.herodrop = 0;
}

function jugg_modifyfalldamage() {
  if(self isskydiving()) {
    self skydive_interrupt();
  }

  self notify("perform_hero_drop");
  return false;
}

function jugg_modifyvehicletoplayerdamage(originaldamage, meansofdeath) {
  maxhealth = self.maxhealth;
  config = self.juggcontext.juggconfig;
  damagescale = 0.5;
  var_db8996c1c1e56963 = 10;

  if(isDefined(meansofdeath) && isexplosivedamagemod(meansofdeath)) {
    damagescale = 7;
    var_db8996c1c1e56963 = config.maxvehicledamagedivisor;
  }

  vehicledamage = originaldamage * damagescale;
  maxvehicledamage = maxhealth / var_db8996c1c1e56963;
  modifieddamage = scripts\mp\utility\script::roundup(min(maxvehicledamage, vehicledamage));
  return int(modifieddamage);
}

function jugg_modifyherodroptoplayerdamage(originaldamage) {
  return int(originaldamage / 2);
}

function jugg_canparachute() {
  canparachute = 0;
  parachuteeverywhere = 0;

  parachuteeverywhere = getdvarint(@ "hash_174506584f9d388e", 0) == 1;

  if(isusingmatchrulesdata() && getmatchrulesdata("commonOption", "allowParachute") || parachuteeverywhere || scripts\mp\utility\game::gametypesupportsbasejumping() && scripts\mp\utility\game::mapsupportsbasejumping()) {
    canparachute = 1;
  }

  return canparachute;
}

function function_8e6b2de818370baa(parts, state) {
  if(!isDefined(state)) {
    assertmsg("<dev string:x133>");
    return;
  }

  partstoset = [];

  if(isarray(parts)) {
    partstoset = array_combine(partstoset, parts);
  } else {
    partstoset[partstoset.size] = parts;
  }

  foreach(part in partstoset) {
    self setscriptablepartstate(part, state, 0);

    iprintln("<dev string:x15b>" + part + "<dev string:x167>" + state + "<dev string:x176>");
  }
}

function function_4217f11ffb352425(damage, shitloc, smeansofdeath, attacker) {
  var_1f48003b8e69560c = function_c0aa811f7b45687c(shitloc, smeansofdeath, attacker);

  if(!isDefined(var_1f48003b8e69560c)) {
    if(isDefined(attacker) && isDefined(shitloc) && isPlayer(attacker)) {
      attacker iprintln("<dev string:x17b>" + shitloc);
    }

    return;
  }

  function_b47072bcd58c0c99(var_1f48003b8e69560c, damage);
}

function function_c0aa811f7b45687c(shitloc, smeansofdeath, attacker) {
  var_1f48003b8e69560c = undefined;

  if(isheadshot(shitloc, smeansofdeath, attacker)) {
    var_1f48003b8e69560c = "head_health";
  } else if(istorsouppershot(shitloc, smeansofdeath, attacker)) {
    var_1f48003b8e69560c = "torso_upper_health";
  } else if(function_77ed09d75c0c7165(shitloc, smeansofdeath, attacker)) {
    var_1f48003b8e69560c = "torso_lower_health";
  } else if(function_24278eb0ec1e2953(shitloc, smeansofdeath, attacker)) {
    var_1f48003b8e69560c = "right_upper_arm_health";
  } else if(function_bf1efc7185168448(shitloc, smeansofdeath, attacker)) {
    var_1f48003b8e69560c = "right_lower_arm_health";
  } else if(function_82850161196df912(shitloc, smeansofdeath, attacker)) {
    var_1f48003b8e69560c = "left_upper_arm_health";
  } else if(function_d7395809e0049a49(shitloc, smeansofdeath, attacker)) {
    var_1f48003b8e69560c = "left_lower_arm_health";
  } else if(isrightlegshot(shitloc, smeansofdeath, attacker)) {
    var_1f48003b8e69560c = "right_leg_health";
  } else if(isleftlegshot(shitloc, smeansofdeath, attacker)) {
    var_1f48003b8e69560c = "left_leg_health";
  }

  if(isDefined(shitloc) && shitloc != "<dev string:x1c4>" && isDefined(attacker) && isPlayer(attacker)) {
    attacker iprintlnbold("<dev string:x1cc>" + shitloc);
  }

  return var_1f48003b8e69560c;
}

function private function_b47072bcd58c0c99(part, damage) {
  if(isDefined(self.juggcontext.var_5f03cad2b199e1bc)) {
    self[[self.juggcontext.var_5f03cad2b199e1bc]](part, damage);
  }

  if(isDefined(self.juggcontext.partshealth[part])) {
    self.juggcontext.partshealth[part] -= damage;

    if(part == "head_health") {
      if(self.juggcontext.partshealth[part] <= 0) {
        self.juggcontext.partshealth[part] = undefined;
        function_8e6b2de818370baa(part, "destroyed");
      } else if(self.juggcontext.partshealth[part] <= 50) {
        function_8e6b2de818370baa(part, "damaged");
      }

      return;
    }

    if(self.juggcontext.partshealth[part] <= 0) {
      self.juggcontext.partshealth[part] = undefined;
      function_8e6b2de818370baa(part, "damaged");
    }
  }
}

function private function_5b7c34dbc50c3c4e(usearmorparts) {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  level endon("game_ended");
  state = usearmorparts ? "pristine" : "off";
  function_8e6b2de818370baa(level.var_13819795c6ee9ff8, state);

  if(usearmorparts) {
    childthread function_5e9c6b97e4c3c059();
    childthread function_59469cc44ca7fa81();
  }
}

function private function_a585b2993726d3b(config, weaponref) {
  if(!isDefined(weaponref) || weaponref == "none") {
    return false;
  }

  if(isDefined(config.classstruct.loadoutprimary) && weaponref == config.classstruct.loadoutprimary) {
    return true;
  }

  if(isDefined(config.classstruct.loadoutsecondary) && weaponref == config.classstruct.loadoutsecondary) {
    return true;
  }

  return false;
}

function private function_5e9c6b97e4c3c059() {
  juggcontext = self.juggcontext;
  juggconfig = juggcontext.juggconfig;

  while(true) {
    armorstateindex = getdvarint(@ "hash_63bf655a03b825eb", 0);

    if(!armorstateindex) {
      waitframe();
      continue;
    }

    armorstate = function_354f191d8b1ec22d(armorstateindex - 1);
    var_f05a031dc1df54df = "<dev string:x1e6>";
    var_5aa83db0e5d721db = armorstate;

    if(armorstate == "<dev string:x1f5>") {
      var_5aa83db0e5d721db = "<dev string:x200>";
    }

    function_8e6b2de818370baa(var_f05a031dc1df54df, var_5aa83db0e5d721db);
    helmetpart = "<dev string:x20d>";
    var_e0aad72b2cb25382 = armorstate;

    if(armorstate == "<dev string:x1f5>") {
      var_e0aad72b2cb25382 = "<dev string:x217>";
    }

    function_8e6b2de818370baa(helmetpart, var_e0aad72b2cb25382);
    partstoset = ["<dev string:x21e>", "<dev string:x234>", "<dev string:x24a>", "<dev string:x264>", "<dev string:x27e>", "<dev string:x297>", "<dev string:x2b0>", "<dev string:x2c4>", "<dev string:x2d7>", "<dev string:x2e4>", "<dev string:x2f0>", "<dev string:x301>", "<dev string:x312>", "<dev string:x322>", "<dev string:x332>", "<dev string:x33b>", "<dev string:x349>"];
    function_8e6b2de818370baa(partstoset, armorstate);

    if(armorstate == "<dev string:x357>") {
      juggcontext.partshealth["<dev string:x1e6>"] = ter_op(isDefined(juggconfig.head_health), juggconfig.head_health, 100);
      juggcontext.partshealth["<dev string:x21e>"] = ter_op(isDefined(juggconfig.torso_upper_health), juggconfig.torso_upper_health, 100);
      juggcontext.partshealth["<dev string:x234>"] = ter_op(isDefined(juggconfig.torso_lower_health), juggconfig.torso_lower_health, 100);
      juggcontext.partshealth["<dev string:x24a>"] = ter_op(isDefined(juggconfig.right_upper_arm_health), juggconfig.right_upper_arm_health, 100);
      juggcontext.partshealth["<dev string:x264>"] = ter_op(isDefined(juggconfig.right_lower_arm_health), juggconfig.right_lower_arm_health, 100);
      juggcontext.partshealth["<dev string:x27e>"] = ter_op(isDefined(juggconfig.left_upper_arm_health), juggconfig.left_upper_arm_health, 100);
      juggcontext.partshealth["<dev string:x297>"] = ter_op(isDefined(juggconfig.left_lower_arm_health), juggconfig.left_lower_arm_health, 100);
      juggcontext.partshealth["<dev string:x2b0>"] = ter_op(isDefined(juggconfig.right_leg_health), juggconfig.right_leg_health, 100);
      juggcontext.partshealth["<dev string:x2c4>"] = ter_op(isDefined(juggconfig.left_leg_health), juggconfig.left_leg_health, 100);
    } else {
      juggcontext.partshealth["<dev string:x1e6>"] = undefined;
      juggcontext.partshealth["<dev string:x21e>"] = undefined;
      juggcontext.partshealth["<dev string:x234>"] = undefined;
      juggcontext.partshealth["<dev string:x24a>"] = undefined;
      juggcontext.partshealth["<dev string:x264>"] = undefined;
      juggcontext.partshealth["<dev string:x27e>"] = undefined;
      juggcontext.partshealth["<dev string:x297>"] = undefined;
      juggcontext.partshealth["<dev string:x2b0>"] = undefined;
      juggcontext.partshealth["<dev string:x2c4>"] = undefined;
    }

    setDvar(@ "hash_63bf655a03b825eb", 0);
    waitframe();
  }
}

function private function_59469cc44ca7fa81() {
  armorstate = "<dev string:x357>";

  while(true) {
    var_d131f91d9bea09f3 = getdvarint(@ "hash_ae2c4f86ffaf24db", 0);

    if(!var_d131f91d9bea09f3) {
      waitframe();
      continue;
    }

    armorpart = function_1e84eeb2a6f4129d(var_d131f91d9bea09f3 - 1);

    if(armorstate == "<dev string:x357>") {
      armorstate = "<dev string:x1f5>";

      if(armorpart == "<dev string:x20d>") {
        armorstate = "<dev string:x217>";
      }
    } else {
      armorstate = "<dev string:x357>";
    }

    function_8e6b2de818370baa(armorpart, armorstate);
    setDvar(@ "hash_ae2c4f86ffaf24db", 0);
    waitframe();
  }
}

function private function_354f191d8b1ec22d(index) {
  return level.var_ed61c38f5c8bb414[index];
}

function private function_1e84eeb2a6f4129d(index) {
  return level.var_13819795c6ee9ff8[index];
}

# /
/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\equipment\throwing_knife.gsc
******************************************************/

function throwing_knife_init() {
  level.throwingknifemaxpickups = getdvarfloat("scr_throwingKnifeCount", 12);
  level.throwingknifepickuptimeout = getdvarfloat("scr_throwingKnifeTimeout", 20);
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("throwing_knife", "init")]]();
}

function throwing_knife_ongive(var0, var1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("throwing_knife", "onGive")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("throwing_knife", "onGive")]](var0, var1);
    return;
  }
}

function throwing_knife_ontake(var0, var1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("throwing_knife", "onTake")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("throwing_knife", "onTake")]](var0, var1);
    return;
  }
}

function throwing_knife_used(var0) {
  var0 makeunusable();

  if(!isDefined(var0.equipmentref)) {
    if(var0.weapon_name == "throwingknife_fire_mp") {
      var0.equipmentref = "equip_throwing_knife_fire";
    } else if(var0.weapon_name == "throwingknife_electric_mp") {
      var0.equipmentref = "equip_throwing_knife_electric";
    } else {
      var0.equipmentref = "equip_throwing_knife";
    }
  }

  var1 = undefined;
  var2 = undefined;
  var3 = self.name;
  var0 waittill("missile_stuck", var1, var2, var4, var5, var6, var7);
  var0.surfacetype = var4;
  level notify("grenade_exploded_during_stealth", var0, "throwingknife_mp", var3);
  var8 = isDefined(var2) && var2 == "j_riotshield_offset";
  var9 = isDefined(var2) && var2 == "tag_weapon";
  var10 = isDefined(var1) && (isPlayer(var1) || isagent(var1));
  var11 = var0.weapon_name == "throwingknife_fire_mp";
  var12 = var0.weapon_name == "throwingknife_electric_mp";
  var13 = var0.weapon_name == "throwingknife_drill_mp";

  if(var11 || var12 || var13) {
    var0 setscriptablepartstate("igniteWick", "active", 0);

    if(isDefined(level.ref_132a4) && [[level.ref_132a4.make_control_station_interaction]](var0)) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("throwing_knife", "shallowWater")]](var0);
    }

    if(var10 && !var8) {
      var0 setscriptablepartstate("playerImpact", "impact", 0);

      if(!isalive(var1) && var11) {
        var14 = relic_healthpacks_killfunc(var2);

        if(isDefined(var14)) {
          var15 = var1 getcorpseentity();
          var15 setscriptablepartstate("burning", var14, 0);
        }
      }
    } else {
      var0 setscriptablepartstate("genericImpact", "impact", 0);
    }
  } else {
    var0 setscriptablepartstate("showLocation", "active", 0);
  }

  throwing_knife_makepickup(var0);
}

function relic_healthpacks_killfunc(var0) {
  switch (var0) {
    case "j_helmet":
      return "head";
    case "j_head":
      return "head";
    case "j_neck":
      return "head";
    case "j_spineupper":
      return "torso";
    case "j_spinelower":
      return "torso";
    case "j_shoulder_ri":
      return "armR";
    case "j_shoulder_le":
      return "armL";
    case "j_elbow_ri":
      return "armR";
    case "j_elbow_le":
      return "armL";
    case "j_wrist_ri":
      return "armR";
    case "j_wrist_le":
      return "armL";
    case "j_hip_ri":
      return "legR";
    case "j_hip_le":
      return "legL";
    case "j_knee_ri":
      return "legR";
    case "j_knee_le":
      return "legL";
    case "j_ankle_ri":
      return "legR";
    case "j_ankle_le":
      return "legL";
    default:
      return undefined;
  }
}

function throwing_knife_makepickup() {
  self makeunusable();
  var0 = spawn("trigger_radius", self.origin, 0, 64, 64);
  var0.targetname = "dropped_knife";
  var0 enablelinkTo();
  var0 linkTo(self);
  self.knife_trigger = var0;

  if(!isDefined(level.throwingknives)) {
    level.throwingknives = [];
  }

  var1 = [self];

  foreach(var3 in level.throwingknives) {
    if(var1.size >= level.throwingknifemaxpickups) {
      if(isDefined(var3)) {
        throwing_knife_deletepickup(var3);
      }

      continue;
    }

    if(isDefined(var3)) {
      var1 = var3;
    }
  }

  level.throwingknives = var1;
  thread throwing_knife_watchpickup();
  thread throwing_knife_watchpickuptimeout();
}

function throwing_knife_watchpickup() {
  self endon("death");

  for(;;) {
    self.knife_trigger waittill("trigger", var0);

    if(!isPlayer(var0)) {
      continue;
    }

    if(!var0 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(!var0 hasweapon(self.weapon_object)) {
      continue;
    }

    if(throwing_knife_trytopickup(var0, self.equipmentref)) {
      thread throwing_knife_deletepickup();
    }
  }
}

function throwing_knife_watchpickuptimeout() {
  self endon("death");
  wait level.throwingknifepickuptimeout;

  if(isDefined(self.equipmentref) && self.equipmentref == "equip_throwing_knife_fire") {
    self playSound("weap_knife_fire_burn_end");
  }

  thread throwing_knife_deletepickup();
}

function throwing_knife_deletepickup() {
  if(isDefined(self.knife_trigger)) {
    self.knife_trigger delete();
  }

  self delete();
}

function throwing_knife_trytopickup(var0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("throwing_knife", "tryToPickup")) {
    var1 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("throwing_knife", "tryToPickup")]](var0);
    return var1;
  }

  return 1;
}
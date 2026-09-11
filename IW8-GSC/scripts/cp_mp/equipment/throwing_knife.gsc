/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\equipment\throwing_knife.gsc
******************************************************/

function throwing_knife_init() {
  level.throwingknifemaxpickups = getdvarfloat("scr_throwingKnifeCount", 12);
  level.throwingknifepickuptimeout = getdvarfloat("scr_throwingKnifeTimeout", 20);
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("throwing_knife", "init")]]();
}

function throwing_knife_ongive(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("throwing_knife", "onGive")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("throwing_knife", "onGive")]](var_0, var_1);
    return;
  }
}

function throwing_knife_ontake(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("throwing_knife", "onTake")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("throwing_knife", "onTake")]](var_0, var_1);
    return;
  }
}

function throwing_knife_used(var_0) {
  var_0 makeunusable();

  if(!isDefined(var_0.equipmentref)) {
    if(var_0.weapon_name == "throwingknife_fire_mp") {
      var_0.equipmentref = "equip_throwing_knife_fire";
    } else if(var_0.weapon_name == "throwingknife_electric_mp") {
      var_0.equipmentref = "equip_throwing_knife_electric";
    } else {
      var_0.equipmentref = "equip_throwing_knife";
    }
  }

  var_1 = undefined;
  var_2 = undefined;
  var_3 = self.name;
  var_0 waittill("missile_stuck", var_1, var_2, var_4, var_5, var_6, var_7);
  var_0.surfacetype = var_4;
  level notify("grenade_exploded_during_stealth", var_0, "throwingknife_mp", var_3);
  var_8 = isDefined(var_2) && var_2 == "j_riotshield_offset";
  var_9 = isDefined(var_2) && var_2 == "tag_weapon";
  var_10 = isDefined(var_1) && (isPlayer(var_1) || isagent(var_1));
  var_11 = var_0.weapon_name == "throwingknife_fire_mp";
  var_12 = var_0.weapon_name == "throwingknife_electric_mp";
  var_13 = var_0.weapon_name == "throwingknife_drill_mp";

  if(var_11 || var_12 || var_13) {
    var_0 setscriptablepartstate("igniteWick", "active", 0);

    if(isDefined(level.ref_132a4) && [[level.ref_132a4.make_control_station_interaction]](var_0)) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("throwing_knife", "shallowWater")]](var_0);
    }

    if(var_10 && !var_8) {
      var_0 setscriptablepartstate("playerImpact", "impact", 0);

      if(!isalive(var_1) && var_11) {
        var_14 = relic_healthpacks_killfunc(var_2);

        if(isDefined(var_14)) {
          var_15 = var_1 getcorpseentity();
          var_15 setscriptablepartstate("burning", var_14, 0);
        }
      }
    } else {
      var_0 setscriptablepartstate("genericImpact", "impact", 0);
    }
  } else {
    var_0 setscriptablepartstate("showLocation", "active", 0);
  }

  throwing_knife_makepickup(var_0);
}

function relic_healthpacks_killfunc(var_0) {
  switch (var_0) {
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
  var_0 = spawn("trigger_radius", self.origin, 0, 64, 64);
  var_0.targetname = "dropped_knife";
  var_0 enablelinkTo();
  var_0 linkTo(self);
  self.knife_trigger = var_0;

  if(!isDefined(level.throwingknives)) {
    level.throwingknives = [];
  }

  var_1 = [self];

  foreach(var_3 in level.throwingknives) {
    if(var_1.size >= level.throwingknifemaxpickups) {
      if(isDefined(var_3)) {
        throwing_knife_deletepickup(var_3);
      }

      continue;
    }

    if(isDefined(var_3)) {
      var_1 = var_3;
    }
  }

  level.throwingknives = var_1;
  thread throwing_knife_watchpickup();
  thread throwing_knife_watchpickuptimeout();
}

function throwing_knife_watchpickup() {
  self endon("death");

  for(;;) {
    self.knife_trigger waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }

    if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(!var_0 hasweapon(self.weapon_object)) {
      continue;
    }

    if(throwing_knife_trytopickup(var_0, self.equipmentref)) {
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

function throwing_knife_trytopickup(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("throwing_knife", "tryToPickup")) {
    var_1 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("throwing_knife", "tryToPickup")]](var_0);
    return var_1;
  }

  return 1;
}
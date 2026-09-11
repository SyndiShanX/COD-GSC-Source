/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\cargo_truck_mg_cp.gsc
*****************************************************/

function tr_vis_facing_dist_add_override(var_0) {
  if(!isDefined(level.chopper_sound_fade_and_delete)) {
    level.chopper_sound_fade_and_delete = [];
    return;
  }
}

function ref_1403e(var_0) {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("end_launcher");
  var_1 = registeronrespawn(var_0);
  var_2 = registerontimerexpired(var_1);
  thread chopperexfil_introsound(var_0, var_1, var_2);
}

function handlerelicmartyrdomgas() {
  self waittill("end_launcher");
  wait 6;
  self notify("cleanupImpactWatcher");
}

function chopperexfil_introsound(var_0, var_1, var_2) {
  self notify("cleanupImpactWatcher");
  self endon("disconnect");
  self endon("cleanupImpactWatcher");
  GscBinSkip4(0x35);
}

function setup_tut_zones(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(ref_1331f(var_5, var_0, var_1, var_2)) {
    ref_12ac6(var_0, var_4, var_7, var_8);
  } else if(ref_132f1(var_1)) {
    var_0 delete();
    return;
  } else if(ref_13309(var_1)) {
    linktoent(var_0, var_1, var_2);
  }

  if(isDefined(var_9)) {
    [[var_9]](var_0, var_1, var_2, var_3, var_5);
    return;
  }
}

function ref_1360f(var_0, var_1, var_2, var_3) {
  var_4 = regroup_points(var_3);
  var_5 = spawn("script_model", var_0);
  var_5 setModel(var_4);
  var_5.angles = vectortoangles(var_1) + (90, 0, 0);
  ref_13142(var_5, var_2);
  var_5.owner = self;
  var_5.brush = var_2;
  var_5.weapon = var_3;
  var_5.tut_bots_forcelaststand_onspawn = 1;

  if(ref_1330e(var_2)) {
    var_5 = ref_11aa3(var_5);
  }

  thread countdownendcallback();
  ref_11ab4(var_5);
  return var_5;
}

function ref_1330e(var_0) {
  if(var_0 == "bolt_default") {
    return true;
  }

  return false;
}

function ref_11aa3(var_0) {
  var_1 = var_0.origin + anglesToForward(var_0.angles) * 15;
  var_2 = axistoangles(anglestoup(var_0.angles), anglestoright(var_0.angles), anglesToForward(var_0.angles));
  var_3 = spawn("trigger_rotatable_radius", var_1, 0, 64, 79);
  var_3.angles = var_2;
  var_3.targetname = "bolt_pickup";
  var_3 enablelinkTo();
  var_3 linkTo(var_0);
  var_0.ref_12357 = var_3;
  thread cosfov();
  return var_0;
}

function ref_12c15(var_0) {
  var_0 notify("removePickup");

  if(isDefined(var_0.ref_12357)) {
    var_0.ref_12357 delete();
    return;
  }
}

function cosfov() {
  self endon("entitydeleted");
  self endon("removePickup");
  wait 2;

  for(;;) {
    self.ref_12357 waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }

    if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(isDefined(self.stuckenemyentity) && isalive(self.stuckenemyentity)) {
      continue;
    }

    var_1 = register_boss_spawners(var_0 getweaponslistprimaries());

    if(!isDefined(var_1)) {
      continue;
    }

    if(correctcodeentered(var_0, var_1)) {
      self delete();
    }
  }
}

function register_boss_spawners(var_0) {
  foreach(var_2 in var_0) {
    if(var_2 hasattachment("mag_me_t9ballisticknife") && self.brush == "bolt_default") {
      return var_2;
    }
  }

  return undefined;
}

function correctcodeentered(var_0) {
  var_1 = weaponmaxammo(var_0);
  var_2 = self getweaponammostock(var_0);

  if(var_2 >= var_1) {
    return false;
  }

  var_3 = int(min(var_1, var_2 + 1));
  self setweaponammostock(var_0, var_3);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "giveAmmoType")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "giveAmmoType")]](self, "brloot_ammo_rocket", 1, 0);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "hudIconType")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "hudIconType")]]("throwingknife");
  }

  return true;
}

function ref_13142(var_0) {
  switch (var_0) {
    default:
      self.last_saydefuse_time = 1;
      break;
  }
}

function ref_13143(var_0) {
  self endon("entitydeleted");
  wait var_0;
  self.last_saydefuse_time = 1;
  ref_11ab4();
}

function ref_11ab4(var_0) {
  if(isDefined(var_0)) {
    var_1 = [var_0];
  } else {
    var_1 = [];
  }

  foreach(var_3 in level.chopper_sound_fade_and_delete) {
    if(!isDefined(var_3)) {
      continue;
    }

    if(isDefined(var_3)) {
      if(var_1.size >= 7 && var_3.last_saydefuse_time) {
        var_3 delete();
        continue;
      }

      var_1 = var_3;
    }
  }

  level.chopper_sound_fade_and_delete = var_1;
}

function registeronrespawn(var_0) {
  return "bolt_default";
}

function registerontimerexpired(var_0) {}

function regroup_points(var_0) {
  var_1 = 0;
  var_1 = getweaponvariantindex(var_0);

  if(isDefined(var_1)) {
    switch (var_1) {
      case 1:
        return "weapon_wm_special_t9ballisticknife_projectile_v2";
      default:
        break;
    }
  }

  return "weapon_wm_special_t9ballisticknife_projectile";
}

function ref_1331f(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2) && isDefined(var_3)) {
    return 1;
  }

  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0) {
    case "glass_solid":
    case "glass_pane":
      return 1;
  }

  if(use_trace_radius(var_2)) {
    return 1;
  }

  if(use_struct(var_2)) {
    return 1;
  }

  switch (var_0) {
    case "metal_car":
    case "metal_tank":
    case "metal_helicopter":
    case "metal_thin":
    case "metal_thick":
    case "metal_grate":
    case "riotshield":
      return 1;
    default:
      return 0;
  }
}

function ref_12ac6(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\math::vector_reflect(var_2, var_1);
  var_5 = abs(vectordot(var_2, var_1));
  var_6 = scripts\engine\math::factor_value(2300, 1000, var_5);
  var_4 *= var_6;
  var_0 physicslaunchserver(var_3, var_4);
}

function ref_132f1(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(isagent(var_0) && trytoplaydamagesound(var_0) && !isalive(var_0) && !isDefined(var_0 getcorpseentity())) {
    return true;
  }

  return false;
}

function ref_13309(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(isDefined(var_0.classname) && var_0.classname == "weapon_scavenger_bag_mp") {
    return false;
  }

  return true;
}

function trytoplaydamagesound() {
  return istrue(isDefined(self.unittype) && self.unittype == "suicidebomber");
}

function linktoent(var_0, var_1, var_2) {
  if((isPlayer(var_1) || isagent(var_1)) && !isalive(var_1)) {
    var_3 = var_1 getcorpseentity();

    if(isDefined(var_3)) {
      var_1 = var_3;
    }
  }

  if(isPlayer(var_1)) {
    var_0 hidefromplayer(var_1);

    if(isDefined(var_0.ref_12357)) {
      var_0.ref_12357 hidefromplayer(var_1);
    }
  }

  if(isDefined(var_2)) {
    var_0 linkTo(var_1, var_2);
  } else {
    var_0 linkTo(var_1);
  }

  if(get_center_loc_among_target_players(var_1)) {
    var_0.stuckenemyentity = var_1;
    thread ref_12c28(var_0);
  }

  var_0 notsolid();
  thread courtyard_intel_sequence(var_0);
  thread cosmeticattachment(var_0, var_1);
  thread cosmeticattachment(var_0, var_1);
  thread cosmeticattachment(var_0, var_1);
}

function ref_140ca() {
  if(isDefined(self) && istrue(self.tut_bots_forcelaststand_onspawn)) {
    return 1;
  }
}

function ref_12c28(var_0) {
  self endon("entitydeleted");
  var_0 scripts\engine\utility::ref_143a6("entitydeleted", "death", "disconnect");

  if(!ref_140ca()) {
    return;
  }

  self.stuckenemyentity = undefined;

  if(isDefined(var_0) && isDefined(var_0.nocorpse)) {
    self delete();
    return;
  }
}

function courtyard_intel_sequence(var_0) {
  self endon("entitydeleted");
  var_0 scripts\engine\utility::ref_143a5("entitydeleted", "disconnect");

  if(!ref_140ca()) {
    return;
  }

  course_triggers_expl();
}

function course_triggers_expl(var_0) {
  if(!isDefined(var_0)) {
    var_0 = (0, 0, 100);
  }

  if(self islinked()) {
    self unlink();
  }

  if(!isDefined(self.model) || self.model == "tag_origin") {
    return;
  }

  self solid();
  self physicslaunchserver(self.origin, var_0);
}

function cosmeticattachment(var_0, var_1) {
  self endon("entitydeleted");
  var_0 waittill(var_1);

  if(!ref_140ca()) {
    return;
  }

  self delete();
}

function countdownendcallback() {
  self waittill("entitydeleted");

  if(isDefined(self.ref_12357)) {
    self.ref_12357 delete();
  }

  if(isDefined(self.grenade)) {
    self.grenade delete();
    return;
  }
}

function use_trace_radius(var_0) {
  if(!isPlayer(var_0)) {
    return 0;
  }

  if(scripts\mp\utility\player::isenemy(var_0)) {
    return 0;
  }

  return 1;
}

function use_struct(var_0) {
  if(!isagent(var_0)) {
    return false;
  }

  if(isDefined(var_0.agentteam) && self.team == var_0.agentteam) {
    return true;
  }

  return false;
}

function get_center_loc_among_target_players(var_0) {
  var_1 = 0;

  if(isPlayer(var_0) || isagent(var_0)) {
    var_1 = 1;
  }

  if(var_0 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    var_1 = 1;
  }

  if(isDefined(var_0.classname)) {
    if(var_0.classname == "misc_turret") {
      var_1 = 1;
    }

    if(var_0.classname == "script_model") {
      if(isDefined(var_0.streakinfo) && (var_0.streakinfo.streakname == "uav" || var_0.streakinfo.streakname == "gunship")) {
        var_1 = 1;
      }
    }
  }

  if(isDefined(var_0.equipmentref)) {
    if(var_0.equipmentref == "equip_tac_cover") {
      var_1 = 1;
    }
  }

  return var_1;
}
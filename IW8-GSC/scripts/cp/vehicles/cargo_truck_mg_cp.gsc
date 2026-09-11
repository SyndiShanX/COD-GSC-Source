/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\cargo_truck_mg_cp.gsc
*****************************************************/

function tr_vis_facing_dist_add_override(var0) {
  if(!isDefined(level.chopper_sound_fade_and_delete)) {
    level.chopper_sound_fade_and_delete = [];
    return;
  }
}

function ref_1403e(var0) {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("end_launcher");
  var1 = registeronrespawn(var0);
  var2 = registerontimerexpired(var1);
  thread chopperexfil_introsound(var0, var1, var2);
}

function handlerelicmartyrdomgas() {
  self waittill("end_launcher");
  wait 6;
  self notify("cleanupImpactWatcher");
}

function chopperexfil_introsound(var0, var1, var2) {
  self notify("cleanupImpactWatcher");
  self endon("disconnect");
  self endon("cleanupImpactWatcher");
  GscBinSkip4(0x35);
}

function setup_tut_zones(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(ref_1331f(var5, var0, var1, var2)) {
    ref_12ac6(var0, var4, var7, var8);
  } else if(ref_132f1(var1)) {
    var0 delete();
    return;
  } else if(ref_13309(var1)) {
    linktoent(var0, var1, var2);
  }

  if(isDefined(var9)) {
    [[var9]](var0, var1, var2, var3, var5);
    return;
  }
}

function ref_1360f(var0, var1, var2, var3) {
  var4 = regroup_points(var3);
  var5 = spawn("script_model", var0);
  var5 setModel(var4);
  var5.angles = vectortoangles(var1) + (90, 0, 0);
  ref_13142(var5, var2);
  var5.owner = self;
  var5.brush = var2;
  var5.weapon = var3;
  var5.tut_bots_forcelaststand_onspawn = 1;

  if(ref_1330e(var2)) {
    var5 = ref_11aa3(var5);
  }

  thread countdownendcallback();
  ref_11ab4(var5);
  return var5;
}

function ref_1330e(var0) {
  if(var0 == "bolt_default") {
    return true;
  }

  return false;
}

function ref_11aa3(var0) {
  var1 = var0.origin + anglesToForward(var0.angles) * 15;
  var2 = axistoangles(anglestoup(var0.angles), anglestoright(var0.angles), anglesToForward(var0.angles));
  var3 = spawn("trigger_rotatable_radius", var1, 0, 64, 79);
  var3.angles = var2;
  var3.targetname = "bolt_pickup";
  var3 enablelinkTo();
  var3 linkTo(var0);
  var0.ref_12357 = var3;
  thread cosfov();
  return var0;
}

function ref_12c15(var0) {
  var0 notify("removePickup");

  if(isDefined(var0.ref_12357)) {
    var0.ref_12357 delete();
    return;
  }
}

function cosfov() {
  self endon("entitydeleted");
  self endon("removePickup");
  wait 2;

  for(;;) {
    self.ref_12357 waittill("trigger", var0);

    if(!isPlayer(var0)) {
      continue;
    }

    if(!var0 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(isDefined(self.stuckenemyentity) && isalive(self.stuckenemyentity)) {
      continue;
    }

    var1 = register_boss_spawners(var0 getweaponslistprimaries());

    if(!isDefined(var1)) {
      continue;
    }

    if(correctcodeentered(var0, var1)) {
      self delete();
    }
  }
}

function register_boss_spawners(var0) {
  foreach(var2 in var0) {
    if(var2 hasattachment("mag_me_t9ballisticknife") && self.brush == "bolt_default") {
      return var2;
    }
  }

  return undefined;
}

function correctcodeentered(var0) {
  var1 = weaponmaxammo(var0);
  var2 = self getweaponammostock(var0);

  if(var2 >= var1) {
    return false;
  }

  var3 = int(min(var1, var2 + 1));
  self setweaponammostock(var0, var3);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "giveAmmoType")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "giveAmmoType")]](self, "brloot_ammo_rocket", 1, 0);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "hudIconType")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "hudIconType")]]("throwingknife");
  }

  return true;
}

function ref_13142(var0) {
  switch (var0) {
    default:
      self.last_saydefuse_time = 1;
      break;
  }
}

function ref_13143(var0) {
  self endon("entitydeleted");
  wait var0;
  self.last_saydefuse_time = 1;
  ref_11ab4();
}

function ref_11ab4(var0) {
  if(isDefined(var0)) {
    var1 = [var0];
  } else {
    var1 = [];
  }

  foreach(var3 in level.chopper_sound_fade_and_delete) {
    if(!isDefined(var3)) {
      continue;
    }

    if(isDefined(var3)) {
      if(var1.size >= 7 && var3.last_saydefuse_time) {
        var3 delete();
        continue;
      }

      var1 = var3;
    }
  }

  level.chopper_sound_fade_and_delete = var1;
}

function registeronrespawn(var0) {
  return "bolt_default";
}

function registerontimerexpired(var0) {}

function regroup_points(var0) {
  var1 = 0;
  var1 = getweaponvariantindex(var0);

  if(isDefined(var1)) {
    switch (var1) {
      case 1:
        return "weapon_wm_special_t9ballisticknife_projectile_v2";
      default:
        break;
    }
  }

  return "weapon_wm_special_t9ballisticknife_projectile";
}

function ref_1331f(var0, var1, var2, var3) {
  if(!isDefined(var2) && isDefined(var3)) {
    return 1;
  }

  if(!isDefined(var0)) {
    return 0;
  }

  switch (var0) {
    case "glass_solid":
    case "glass_pane":
      return 1;
  }

  if(use_trace_radius(var2)) {
    return 1;
  }

  if(use_struct(var2)) {
    return 1;
  }

  switch (var0) {
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

function ref_12ac6(var0, var1, var2, var3) {
  var4 = scripts\engine\math::vector_reflect(var2, var1);
  var5 = abs(vectordot(var2, var1));
  var6 = scripts\engine\math::factor_value(2300, 1000, var5);
  var4 *= var6;
  var0 physicslaunchserver(var3, var4);
}

function ref_132f1(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(isagent(var0) && trytoplaydamagesound(var0) && !isalive(var0) && !isDefined(var0 getcorpseentity())) {
    return true;
  }

  return false;
}

function ref_13309(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(isDefined(var0.classname) && var0.classname == "weapon_scavenger_bag_mp") {
    return false;
  }

  return true;
}

function trytoplaydamagesound() {
  return istrue(isDefined(self.unittype) && self.unittype == "suicidebomber");
}

function linktoent(var0, var1, var2) {
  if((isPlayer(var1) || isagent(var1)) && !isalive(var1)) {
    var3 = var1 getcorpseentity();

    if(isDefined(var3)) {
      var1 = var3;
    }
  }

  if(isPlayer(var1)) {
    var0 hidefromplayer(var1);

    if(isDefined(var0.ref_12357)) {
      var0.ref_12357 hidefromplayer(var1);
    }
  }

  if(isDefined(var2)) {
    var0 linkTo(var1, var2);
  } else {
    var0 linkTo(var1);
  }

  if(get_center_loc_among_target_players(var1)) {
    var0.stuckenemyentity = var1;
    thread ref_12c28(var0);
  }

  var0 notsolid();
  thread courtyard_intel_sequence(var0);
  thread cosmeticattachment(var0, var1);
  thread cosmeticattachment(var0, var1);
  thread cosmeticattachment(var0, var1);
}

function ref_140ca() {
  if(isDefined(self) && istrue(self.tut_bots_forcelaststand_onspawn)) {
    return 1;
  }
}

function ref_12c28(var0) {
  self endon("entitydeleted");
  var0 scripts\engine\utility::ref_143a6("entitydeleted", "death", "disconnect");

  if(!ref_140ca()) {
    return;
  }

  self.stuckenemyentity = undefined;

  if(isDefined(var0) && isDefined(var0.nocorpse)) {
    self delete();
    return;
  }
}

function courtyard_intel_sequence(var0) {
  self endon("entitydeleted");
  var0 scripts\engine\utility::ref_143a5("entitydeleted", "disconnect");

  if(!ref_140ca()) {
    return;
  }

  course_triggers_expl();
}

function course_triggers_expl(var0) {
  if(!isDefined(var0)) {
    var0 = (0, 0, 100);
  }

  if(self islinked()) {
    self unlink();
  }

  if(!isDefined(self.model) || self.model == "tag_origin") {
    return;
  }

  self solid();
  self physicslaunchserver(self.origin, var0);
}

function cosmeticattachment(var0, var1) {
  self endon("entitydeleted");
  var0 waittill(var1);

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

function use_trace_radius(var0) {
  if(!isPlayer(var0)) {
    return 0;
  }

  if(scripts\mp\utility\player::isenemy(var0)) {
    return 0;
  }

  return 1;
}

function use_struct(var0) {
  if(!isagent(var0)) {
    return false;
  }

  if(isDefined(var0.agentteam) && self.team == var0.agentteam) {
    return true;
  }

  return false;
}

function get_center_loc_among_target_players(var0) {
  var1 = 0;

  if(isPlayer(var0) || isagent(var0)) {
    var1 = 1;
  }

  if(var0 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    var1 = 1;
  }

  if(isDefined(var0.classname)) {
    if(var0.classname == "misc_turret") {
      var1 = 1;
    }

    if(var0.classname == "script_model") {
      if(isDefined(var0.streakinfo) && (var0.streakinfo.streakname == "uav" || var0.streakinfo.streakname == "gunship")) {
        var1 = 1;
      }
    }
  }

  if(isDefined(var0.equipmentref)) {
    if(var0.equipmentref == "equip_tac_cover") {
      var1 = 1;
    }
  }

  return var1;
}
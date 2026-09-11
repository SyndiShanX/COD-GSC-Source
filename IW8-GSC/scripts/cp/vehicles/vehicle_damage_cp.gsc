/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\vehicle_damage_cp.gsc
*****************************************************/

function teleport_text_updated(var0) {
  if(!isDefined(level.init_weapon_variant_spawns)) {
    level.init_weapon_variant_spawns = [];
    return;
  }
}

function initarmor(var0) {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("end_launcher");
  var1 = relic_mythic_can_do_pain(var0);
  var2 = relic_mythic_do_pain(var1);
  thread init_wind_tunnels(var0, var1, var2);
}

function handlerelicmartyrdomgas() {
  self waittill("end_launcher");
  wait 6;
  self notify("cleanupImpactWatcher");
}

function init_wind_tunnels(var0, var1, var2) {
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

function start_authentication_timer(var0, var1, var2, var3, var4) {}

function start_bomb_vest_defusal(var0, var1, var2, var3, var4) {
  var0 setscriptablepartstate("effects", "impact");

  if(isDefined(var1) && (isPlayer(var1) || isagent(var1))) {
    var5 = 1.1;
  } else {
    var5 = 2;
  }

  var1.grenade = magicgrenademanual("semtex_bolt_mp", var1.origin, (0, 0, 0), var5);
  var1.grenade.angles = var1.angles;
  var1.grenade linkTo(var1, "tag_origin");
  thread onsupportboxusedbyplayer(var1, var5);
}

function start_bomb_vest_defusal_sequence(var0, var1, var2, var3, var4) {
  var0.surfacetype = var4;
  var0 setscriptablepartstate("effects", "impact");
  thread ref_13b25(var0, var1, var2, var3);
  var5 = 0;

  if(isDefined(level.ref_132a4) && [[level.ref_132a4.lowpopallowtweaks]](var0)) {
    var5 = 1;
  }

  if(!var5) {
    thread ref_13b24(var0, var1);
  }

  thread ref_13b23(var0, var5);
}

function start_box_set_up(var0, var1, var2, var3, var4) {
  if(ref_13937(var1, var4)) {
    var0 setscriptablepartstate("impact", "active");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "gas_createTrigger")) {
      GscBinSkip1(0x74, scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "gas_createTrigger"), var0.origin, self, 5, 0.45);
    }

    thread ref_13936(var0);
    return;
  }

  var0 setscriptablepartstate("impact", "dud");
}

function onsupportboxusedbyplayer(var0, var1) {
  self endon("disconnect");
  var0 endon("entitydeleted");
  var0.grenade scripts\engine\utility::ref_143bf(var1, "explode");
  var0 setscriptablepartstate("effects", "explode");
  var2 = getcompleteweaponname("semtex_bolt_mp");
  var3 = getcompleteweaponname("semtex_bolt_splash_mp");
  var2.ref_121d9 = var0.weapon;
  var3.ref_121d9 = var0.weapon;

  if(isDefined(var0.stuckenemyentity) && isalive(var0.stuckenemyentity)) {
    var0.stuckenemyentity scripts\cp_mp\utility\damage_utility::playerplunderbankcallback();
    var0.stuckenemyentity dodamage(65, var0.origin, self, undefined, "MOD_EXPLOSIVE", var2);
    var0.stuckenemyentity scripts\cp_mp\utility\damage_utility::playerplunderbankdeposit();
  }

  radiusdamage(var0.origin, 160, 65, 35, self, "MOD_EXPLOSIVE", var3);
  wait 0.4;

  if(!ref_140ca(var0)) {
    return;
  }

  var0 delete();
}

function ref_13b25(var0, var1, var2, var3) {
  self endon("disconnect");
  var0 endon("entitydeleted");
  var4 = getcompleteweaponname("thermite_bolt_mp");
  var4.ref_121d9 = var0.weapon;

  if(isDefined(var0.stuckenemyentity) && isalive(var0.stuckenemyentity)) {
    if(var1 scripts\cp_mp\vehicles\vehicle::isvehicle() || isDefined(var1.classname) && var1.classname == "misc_turret") {
      var5 = 1;
    } else {
      var5 = 0.25;
    }

    var6 = int(4.5 / var5);

    while(isDefined(var2) && isDefined(var1) && isalive(var2) && var6 > 0) {
      var2 scripts\cp_mp\utility\damage_utility::playerplunderbankcallback();
      var2 dodamage(5, var1.origin, self, var1, "MOD_FIRE", var5, var4);
      var2 scripts\cp_mp\utility\damage_utility::playerplunderbankdeposit();
      var6--;
      wait var5;
    }

    return;
  }
}

function ref_13b24(var0, var1) {
  self endon("disconnect");
  var0 endon("entitydeleted");
  var2 = int(18);
  var3 = getcompleteweaponname("thermite_bolt_radius_mp");
  var3.ref_121d9 = var0.weapon;
  var0.ref_13b28 = var3.basename;

  while(var2 > 0) {
    if(isDefined(var0.stuckenemyentity) && isalive(var0.stuckenemyentity)) {
      var0.stuckenemyentity scripts\cp_mp\utility\damage_utility::adddamagemodifier("thermiteBoltStuck", 0, 0, &ref_13b1c);
    }

    var0 radiusdamage(var0.origin, 50, 5, 3, self, "MOD_FIRE", var3);

    if(isDefined(var0.stuckenemyentity) && isalive(var0.stuckenemyentity)) {
      var0.stuckenemyentity scripts\cp_mp\utility\damage_utility::removedamagemodifier("thermiteBoltStuck", 0);
    }

    var2--;
    wait 0.25;
  }
}

function ref_13b1c(var0, var1, var2, var3, var4, var5, var6) {
  if(!isDefined(var0)) {
    return true;
  }

  if(!isDefined(var0.ref_13b28) || var0.ref_13b28 != "thermite_bolt_radius_mp") {
    return true;
  }

  if(!isDefined(var0.stuckenemyentity) || var0.stuckenemyentity != var2) {
    return true;
  }

  return false;
}

function ref_13b23(var0, var1) {
  var0 endon("entitydeleted");

  if(!var1) {
    wait 4.5;

    if(!ref_140ca(var0)) {
      return;
    }

    var0 setscriptablepartstate("effects", "burnEnd");
    wait randomfloatrange(0.3, 2);

    if(!ref_140ca(var0)) {
      return;
    }
  }

  course_triggers_expl(var0);
  var0 setModel("weapon_wm_sn_crossbow_bolt_fire_static_dst");
}

function ref_13936(var0) {
  var0 endon("entitydeleted");
  wait 0.5;

  if(!ref_140ca(var0)) {
    return;
  }

  var0 delete();
}

function ref_13937(var0, var1) {
  if(!isDefined(var0)) {
    return false;
  }

  if(!isPlayer(var0) && !isagent(var0)) {
    return false;
  }

  if(isDefined(var0.team) && self.team == var0.team) {
    return false;
  }

  if(var1 == "riotshield") {
    return false;
  }

  return true;
}

function ref_1362b(var0, var1, var2, var3) {
  var4 = regroup_points(var2);
  var5 = spawn("script_model", var0);
  var5 setModel(var4);
  var5.angles = vectortoangles(var1);
  ref_13142(var5, var2);
  var5.owner = self;
  var5.brush = var2;
  var5.weapon = var3;
  var5.uavnoneid = 1;

  if(ref_1330e(var2)) {
    var5 = ref_11aa3(var5);
  }

  thread countdownendcallback();
  ref_11ab4(var5);
  return var5;
}

function ref_1330e(var0) {
  if(var0 == "bolt_default" || var0 == "bolt_stun") {
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
    if(var2 hasattachment("ammo_crossbow") && self.brush == "bolt_default") {
      return var2;
    }

    if(var2 hasattachment("mag_sn_t9crossbow") && self.brush == "bolt_default") {
      return var2;
    }

    if(var2 hasattachment("boltstun_crossbow") && self.brush == "bolt_stun") {
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

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "hudIconType")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "hudIconType")]]("crossbowbolt");
  }

  return true;
}

function ref_13142(var0) {
  switch (var0) {
    case "bolt_fire":
      thread ref_13143(5);
      self.last_saydefuse_time = 0;
      break;
    case "bolt_explo":
      self.last_saydefuse_time = 0;
      break;
    case "bolt_stun":
      thread ref_13143(0.5);
      self.last_saydefuse_time = 0;
      break;
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

  foreach(var3 in level.init_weapon_variant_spawns) {
    if(!isDefined(var3)) {
      continue;
    }

    if(isDefined(var3)) {
      if(var1.size >= 24 && var3.last_saydefuse_time) {
        var3 delete();
        continue;
      }

      var1 = var3;
    }
  }

  level.init_weapon_variant_spawns = var1;
}

function relic_mythic_can_do_pain(var0) {
  var1 = "";

  foreach(var3 in var0.attachments) {
    if(issubstr(var3, "bolt")) {
      var1 = var3;
      break;
    }
  }

  switch (var1) {
    case "boltcarbon_crossbow":
      return "bolt_carbon";
    case "boltexplo_crossbow":
      return "bolt_explo";
    case "boltfire_crossbow":
      return "bolt_fire";
    case "boltstun_crossbow":
      return "bolt_stun";
    default:
      return "bolt_default";
  }
}

function relic_mythic_do_pain(var0) {
  switch (var0) {
    case "bolt_carbon":
      return &start_authentication_timer;
    case "bolt_explo":
      return &start_bomb_vest_defusal;
    case "bolt_fire":
      return &start_bomb_vest_defusal_sequence;
    case "bolt_stun":
      return &start_box_set_up;
    default:
      return;
  }
}

function regroup_points(var0) {
  switch (var0) {
    case "bolt_carbon":
      return "weapon_wm_sn_crossbow_bolt_carbon_static";
    case "bolt_explo":
      return "weapon_wm_sn_crossbow_bolt_explosive_static";
    case "bolt_fire":
      return "weapon_wm_sn_crossbow_bolt_fire_static";
    case "bolt_stun":
      return "weapon_wm_sn_crossbow_bolt_stun_static";
    default:
      return "weapon_wm_sn_crossbow_bolt_static";
  }
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

  if(var1.brush == "bolt_explo") {
    return 0;
  }

  if(use_trace_radius(var2)) {
    return 1;
  }

  if(use_struct(var2)) {
    return 1;
  }

  switch (var0) {
    case "asphalt_wet":
    case "asphalt_dry":
    case "riotshield":
      return 1;
    case "metal_car":
    case "metal_tank":
    case "metal_helicopter":
    case "metal_thin":
    case "metal_thick":
    case "metal_grate":
      if(var1.brush == "bolt_fire") {
        return 0;
      } else {
        return 1;
      }
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

  if(isPlayer(var1) && var0.brush != "bolt_stun") {
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
  if(isDefined(self) && istrue(self.uavnoneid)) {
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

  if(!isDefined(self.model) || self.model == "tag_origin" || self.model == "") {
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
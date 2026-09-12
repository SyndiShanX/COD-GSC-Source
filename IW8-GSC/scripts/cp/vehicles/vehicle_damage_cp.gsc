/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\vehicle_damage_cp.gsc
*****************************************************/

function teleport_text_updated(var_0) {
  if(!isDefined(level.init_weapon_variant_spawns)) {
    level.init_weapon_variant_spawns = [];
    return;
  }
}

function initarmor(var_0) {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("end_launcher");
  var_1 = relic_mythic_can_do_pain(var_0);
  var_2 = relic_mythic_do_pain(var_1);
  thread init_wind_tunnels(var_0, var_1, var_2);
}

function handlerelicmartyrdomgas() {
  self waittill("end_launcher");
  wait 6;
  self notify("cleanupImpactWatcher");
}

function init_wind_tunnels(var_0, var_1, var_2) {
  self notify("cleanupImpactWatcher");
  self endon("disconnect");
  self endon("cleanupImpactWatcher");
  GscBinSkip4(0x35);
}

function setup_tut_zones(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(ref_1331F(var_5, var_0, var_1, var_2)) {
    ref_12AC6(var_0, var_4, var_7, var_8);
  } else if(ref_132F1(var_1)) {
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

function start_authentication_timer(var_0, var_1, var_2, var_3, var_4) {}

function start_bomb_vest_defusal(var_0, var_1, var_2, var_3, var_4) {
  var_0 setscriptablepartstate("effects", "impact");

  if(isDefined(var_1) && (isPlayer(var_1) || isagent(var_1))) {
    var_5 = 1.1;
  } else {
    var_5 = 2;
  }

  var_1.grenade = magicgrenademanual("semtex_bolt_mp", var_1.origin, (0, 0, 0), var_5);
  var_1.grenade.angles = var_1.angles;
  var_1.grenade linkTo(var_1, "tag_origin");
  thread onsupportboxusedbyplayer(var_1, var_5);
}

function start_bomb_vest_defusal_sequence(var_0, var_1, var_2, var_3, var_4) {
  var_0.surfacetype = var_4;
  var_0 setscriptablepartstate("effects", "impact");
  thread ref_13B25(var_0, var_1, var_2, var_3);
  var_5 = 0;

  if(isDefined(level.ref_132A4) && [[level.ref_132A4.lowpopallowtweaks]](var_0)) {
    var_5 = 1;
  }

  if(!var_5) {
    thread ref_13B24(var_0, var_1);
  }

  thread ref_13B23(var_0, var_5);
}

function start_box_set_up(var_0, var_1, var_2, var_3, var_4) {
  if(ref_13937(var_1, var_4)) {
    var_0 setscriptablepartstate("impact", "active");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "gas_createTrigger")) {
      GscBinSkip1(0x74, scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "gas_createTrigger"), var_0.origin, self, 5, 0.45);
    }

    thread ref_13936(var_0);
    return;
  }

  var_0 setscriptablepartstate("impact", "dud");
}

function onsupportboxusedbyplayer(var_0, var_1) {
  self endon("disconnect");
  var_0 endon("entitydeleted");
  var_0.grenade scripts\engine\utility::ref_143BF(var_1, "explode");
  var_0 setscriptablepartstate("effects", "explode");
  var_2 = getcompleteweaponname("semtex_bolt_mp");
  var_3 = getcompleteweaponname("semtex_bolt_splash_mp");
  var_2.ref_121D9 = var_0.weapon;
  var_3.ref_121D9 = var_0.weapon;

  if(isDefined(var_0.stuckenemyentity) && isalive(var_0.stuckenemyentity)) {
    var_0.stuckenemyentity scripts\cp_mp\utility\damage_utility::playerplunderbankcallback();
    var_0.stuckenemyentity dodamage(65, var_0.origin, self, undefined, "MOD_EXPLOSIVE", var_2);
    var_0.stuckenemyentity scripts\cp_mp\utility\damage_utility::playerplunderbankdeposit();
  }

  radiusdamage(var_0.origin, 160, 65, 35, self, "MOD_EXPLOSIVE", var_3);
  wait 0.4;

  if(!ref_140CA(var_0)) {
    return;
  }

  var_0 delete();
}

function ref_13B25(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  var_0 endon("entitydeleted");
  var_4 = getcompleteweaponname("thermite_bolt_mp");
  var_4.ref_121D9 = var_0.weapon;

  if(isDefined(var_0.stuckenemyentity) && isalive(var_0.stuckenemyentity)) {
    if(var_1 scripts\cp_mp\vehicles\vehicle::isvehicle() || isDefined(var_1.classname) && var_1.classname == "misc_turret") {
      var_5 = 1;
    } else {
      var_5 = 0.25;
    }

    var_6 = int(4.5 / var_5);

    while(isDefined(var_2) && isDefined(var_1) && isalive(var_2) && var_6 > 0) {
      var_2 scripts\cp_mp\utility\damage_utility::playerplunderbankcallback();
      var_2 dodamage(5, var_1.origin, self, var_1, "MOD_FIRE", var_5, var_4);
      var_2 scripts\cp_mp\utility\damage_utility::playerplunderbankdeposit();
      var_6--;
      wait var_5;
    }

    return;
  }
}

function ref_13B24(var_0, var_1) {
  self endon("disconnect");
  var_0 endon("entitydeleted");
  var_2 = int(18);
  var_3 = getcompleteweaponname("thermite_bolt_radius_mp");
  var_3.ref_121D9 = var_0.weapon;
  var_0.ref_13B28 = var_3.basename;

  while(var_2 > 0) {
    if(isDefined(var_0.stuckenemyentity) && isalive(var_0.stuckenemyentity)) {
      var_0.stuckenemyentity scripts\cp_mp\utility\damage_utility::adddamagemodifier("thermiteBoltStuck", 0, 0, &ref_13B1C);
    }

    var_0 radiusdamage(var_0.origin, 50, 5, 3, self, "MOD_FIRE", var_3);

    if(isDefined(var_0.stuckenemyentity) && isalive(var_0.stuckenemyentity)) {
      var_0.stuckenemyentity scripts\cp_mp\utility\damage_utility::removedamagemodifier("thermiteBoltStuck", 0);
    }

    var_2--;
    wait 0.25;
  }
}

function ref_13B1C(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_0)) {
    return true;
  }

  if(!isDefined(var_0.ref_13B28) || var_0.ref_13B28 != "thermite_bolt_radius_mp") {
    return true;
  }

  if(!isDefined(var_0.stuckenemyentity) || var_0.stuckenemyentity != var_2) {
    return true;
  }

  return false;
}

function ref_13B23(var_0, var_1) {
  var_0 endon("entitydeleted");

  if(!var_1) {
    wait 4.5;

    if(!ref_140CA(var_0)) {
      return;
    }

    var_0 setscriptablepartstate("effects", "burnEnd");
    wait randomfloatrange(0.3, 2);

    if(!ref_140CA(var_0)) {
      return;
    }
  }

  course_triggers_expl(var_0);
  var_0 setModel("weapon_wm_sn_crossbow_bolt_fire_static_dst");
}

function ref_13936(var_0) {
  var_0 endon("entitydeleted");
  wait 0.5;

  if(!ref_140CA(var_0)) {
    return;
  }

  var_0 delete();
}

function ref_13937(var_0, var_1) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(!isPlayer(var_0) && !isagent(var_0)) {
    return false;
  }

  if(isDefined(var_0.team) && self.team == var_0.team) {
    return false;
  }

  if(var_1 == "riotshield") {
    return false;
  }

  return true;
}

function ref_1362B(var_0, var_1, var_2, var_3) {
  var_4 = regroup_points(var_2);
  var_5 = spawn("script_model", var_0);
  var_5 setModel(var_4);
  var_5.angles = vectortoangles(var_1);
  ref_13142(var_5, var_2);
  var_5.owner = self;
  var_5.brush = var_2;
  var_5.weapon = var_3;
  var_5.uavnoneid = 1;

  if(ref_1330E(var_2)) {
    var_5 = ref_11AA3(var_5);
  }

  thread countdownendcallback();
  ref_11AB4(var_5);
  return var_5;
}

function ref_1330E(var_0) {
  if(var_0 == "bolt_default" || var_0 == "bolt_stun") {
    return true;
  }

  return false;
}

function ref_11AA3(var_0) {
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

function ref_12C15(var_0) {
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
    if(var_2 hasattachment("ammo_crossbow") && self.brush == "bolt_default") {
      return var_2;
    }

    if(var_2 hasattachment("mag_sn_t9crossbow") && self.brush == "bolt_default") {
      return var_2;
    }

    if(var_2 hasattachment("boltstun_crossbow") && self.brush == "bolt_stun") {
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

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "hudIconType")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "hudIconType")]]("crossbowbolt");
  }

  return true;
}

function ref_13142(var_0) {
  switch (var_0) {
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

function ref_13143(var_0) {
  self endon("entitydeleted");
  wait var_0;
  self.last_saydefuse_time = 1;
  ref_11AB4();
}

function ref_11AB4(var_0) {
  if(isDefined(var_0)) {
    var_1 = [var_0];
  } else {
    var_1 = [];
  }

  foreach(var_3 in level.init_weapon_variant_spawns) {
    if(!isDefined(var_3)) {
      continue;
    }

    if(isDefined(var_3)) {
      if(var_1.size >= 24 && var_3.last_saydefuse_time) {
        var_3 delete();
        continue;
      }

      var_1 = var_3;
    }
  }

  level.init_weapon_variant_spawns = var_1;
}

function relic_mythic_can_do_pain(var_0) {
  var_1 = "";

  foreach(var_3 in var_0.attachments) {
    if(issubstr(var_3, "bolt")) {
      var_1 = var_3;
      break;
    }
  }

  switch (var_1) {
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

function relic_mythic_do_pain(var_0) {
  switch (var_0) {
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

function regroup_points(var_0) {
  switch (var_0) {
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

function ref_1331F(var_0, var_1, var_2, var_3) {
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

  if(var_1.brush == "bolt_explo") {
    return 0;
  }

  if(use_trace_radius(var_2)) {
    return 1;
  }

  if(use_struct(var_2)) {
    return 1;
  }

  switch (var_0) {
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
      if(var_1.brush == "bolt_fire") {
        return 0;
      } else {
        return 1;
      }
    default:
      return 0;
  }
}

function ref_12AC6(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\math::vector_reflect(var_2, var_1);
  var_5 = abs(vectordot(var_2, var_1));
  var_6 = scripts\engine\math::factor_value(2300, 1000, var_5);
  var_4 *= var_6;
  var_0 physicslaunchserver(var_3, var_4);
}

function ref_132F1(var_0) {
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

  if(isPlayer(var_1) && var_0.brush != "bolt_stun") {
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
    thread ref_12C28(var_0);
  }

  var_0 notsolid();
  thread courtyard_intel_sequence(var_0);
  thread cosmeticattachment(var_0, var_1);
  thread cosmeticattachment(var_0, var_1);
  thread cosmeticattachment(var_0, var_1);
}

function ref_140CA() {
  if(isDefined(self) && istrue(self.uavnoneid)) {
    return 1;
  }
}

function ref_12C28(var_0) {
  self endon("entitydeleted");
  var_0 scripts\engine\utility::ref_143A6("entitydeleted", "death", "disconnect");

  if(!ref_140CA()) {
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
  var_0 scripts\engine\utility::ref_143A5("entitydeleted", "disconnect");

  if(!ref_140CA()) {
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

  if(!isDefined(self.model) || self.model == "tag_origin" || self.model == "") {
    return;
  }

  self solid();
  self physicslaunchserver(self.origin, var_0);
}

function cosmeticattachment(var_0, var_1) {
  self endon("entitydeleted");
  var_0 waittill(var_1);

  if(!ref_140CA()) {
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
/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\omnvar_utility.gsc
****************************************************/

function tr_vis_facing_dist_add_override(var_0) {
  if(!isDefined(level.ref_14675)) {
    level.ref_14675 = [];
    return;
  }
}

function ref_1403E(var_0) {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("end_launcher");
  var_1 = safehouse_restart(var_0);

  if(var_1 == "mag_xmike109") {
    return;
  }

  var_2 = safehouse_revive_and_move_players(var_1);
  thread start_chopper_boss(var_0, var_1, var_2);
}

function handlerelicmartyrdomgas() {
  self waittill("end_launcher");
  wait 6;
  self notify("cleanupXMike109ImpactWatcher");
}

function start_chopper_boss(var_0, var_1, var_2) {
  self notify("cleanupXMike109ImpactWatcher");
  self endon("disconnect");
  self endon("cleanupXMike109ImpactWatcher");
  GscBinSkip4(0x35);
}

function setup_tut_zones(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = ref_1331F(var_4, var_9, var_0, var_1, var_3, var_6);
  var_12 = ref_1368B(var_7, var_6, var_9, var_5, var_11, var_3, var_10);

  if(ref_132F1(var_0)) {
    var_12 delete();
    return;
  } else if(ref_13309(var_0, var_11)) {
    linktoent(var_12, var_0, var_1);
  }

  if(isDefined(var_8)) {
    [[var_8]](var_12, var_0, var_1, var_2, var_4, var_11);
    return;
  }
}

function start_bomb_vest_defusal(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 0.1;
  var_0.grenade = magicgrenademanual("semtex_xmike109_mp", var_0.origin, (0, 0, 0), var_6);
  var_0.grenade.angles = var_0.angles;
  var_0.grenade linkTo(var_0, "tag_origin");
  thread ref_128CC(var_0, var_6, var_3);
}

function start_bomb_vest_defusal_sequence(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread ref_128CD(var_0, var_1, var_2, var_3, var_5);
}

function start_bomb_vest_global_timer(var_0, var_1, var_2, var_3, var_4, var_5) {}

function ref_128CC(var_0, var_1, var_2) {
  self endon("disconnect");
  var_0 endon("entitydeleted");
  var_0.grenade scripts\engine\utility::ref_143BF(var_1, "explode");
  var_0 setscriptablepartstate("effects", "explode");
  var_3 = getcompleteweaponname("semtex_xmike109_mp");
  var_4 = getcompleteweaponname("semtex_xmike109_splash_mp");
  var_3.ref_121D9 = var_0.weapon;
  var_4.ref_121D9 = var_0.weapon;
  glassradiusdamage(var_0.origin, 150, 50, 1);

  if(isDefined(var_0.stuckenemyentity) && isalive(var_0.stuckenemyentity)) {
    var_0.stuckenemyentity scripts\cp_mp\utility\damage_utility::playerplunderbankcallback();
    var_0.stuckenemyentity dodamage(175, var_0.origin, self, self, "MOD_EXPLOSIVE", var_3, var_2);
    var_0.stuckenemyentity scripts\cp_mp\utility\damage_utility::playerplunderbankdeposit();
  }

  getplaylistname(var_0.origin, 9, 35, 15, 25, 60, 14, self, "MOD_EXPLOSIVE", var_4);
  wait 0.4;

  if(!ref_140D4(var_0)) {
    return;
  }

  var_0 delete();
}

function ref_128CD(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_0.unset_relic_hideobjicons)) {
    var_0 setscriptablepartstate("effects", "reflectThermite");
    ref_1437F(var_0);
  }

  var_0 setscriptablepartstate("effects", "burn");
  thread ref_13B2B(var_0);
  thread ref_13B27(var_0);
  thread ref_13B26(var_0);
}

function ref_1437F(var_0) {
  var_0 endon("stuckWaitTimeout");
  thread ref_128D1();
  var_0 waittill("missile_stuck", var_1, var_2);

  if(isDefined(var_1)) {
    linktoent(var_0, var_1, var_2);
    var_0.debug_listing_helis = 1;
    return;
  }
}

function ref_128D1() {
  wait 3;

  if(isDefined(self)) {
    self notify("stuckWaitTimeout");
    return;
  }
}

function ref_13B2B(var_0) {
  self endon("disconnect");
  var_0 endon("entitydeleted");
  var_1 = getcompleteweaponname("thermite_xmike109_mp");
  var_1.ref_121D9 = var_0.weapon;

  if(isDefined(var_0.stuckenemyentity) && isalive(var_0.stuckenemyentity)) {
    if(var_0.stuckenemyentity scripts\cp_mp\vehicles\vehicle::isvehicle() || isDefined(var_0.stuckenemyentity.classname) && var_0.stuckenemyentity.classname == "misc_turret") {
      var_2 = 0.95;
    } else {
      var_2 = 0.25;
    }

    if(istrue(var_1.debug_listing_helis)) {
      var_1.stuckenemyentity dodamage(80, var_1.origin, self, var_1, "MOD_FIRE", var_2);
    }

    var_3 = int(3 / var_2);

    while(isDefined(var_1) && isDefined(var_1.stuckenemyentity) && isalive(var_1.stuckenemyentity) && var_3 >= 0) {
      var_1.stuckenemyentity scripts\cp_mp\utility\damage_utility::playerplunderbankcallback();
      var_1.stuckenemyentity dodamage(3, var_1.origin, self, var_1, "MOD_FIRE", var_2);
      var_1.stuckenemyentity scripts\cp_mp\utility\damage_utility::playerplunderbankdeposit();
      var_3--;
      wait var_2;
    }

    return;
  }
}

function ref_13B27(var_0) {
  self endon("disconnect");
  var_0 endon("entitydeleted");
  var_1 = int(12);
  var_2 = getcompleteweaponname("thermite_xmike109_radius_mp");
  var_2.ref_121D9 = var_0.weapon;
  var_0.ref_13B28 = var_2.basename;

  while(var_1 > 0) {
    if(isDefined(var_0.stuckenemyentity) && isalive(var_0.stuckenemyentity)) {
      var_0.stuckenemyentity scripts\cp_mp\utility\damage_utility::adddamagemodifier("thermite25mmStuck", 0, 0, &ref_13B1C);
    }

    var_0 radiusdamage(var_0.origin, 50, 2, 2, self, "MOD_FIRE", var_2);

    if(isDefined(var_0.stuckenemyentity) && isalive(var_0.stuckenemyentity)) {
      var_0.stuckenemyentity scripts\cp_mp\utility\damage_utility::removedamagemodifier("thermite25mmStuck", 0);
    }

    var_1--;
    wait 0.25;
  }
}

function ref_13B1C(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_0)) {
    return true;
  }

  if(!isDefined(var_0.ref_13B28) || var_0.ref_13B28 != "thermite_xmike109_radius_mp") {
    return true;
  }

  if(!isDefined(var_0.stuckenemyentity) || var_0.stuckenemyentity != var_2) {
    return true;
  }

  return false;
}

function ref_13B26(var_0) {
  var_0 endon("entitydeleted");
  wait 3;

  if(!ref_140D4(var_0)) {
    return;
  }

  var_0 setscriptablepartstate("effects", "burnout");
  var_0 setscriptablepartstate("visibility", "hide");
  wait randomfloatrange(0.3, 2);

  if(!ref_140D4(var_0)) {
    return;
  }

  wait randomfloatrange(2, 3);
  var_0 delete();
}

function ref_1368B(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_4 && var_2 == "thermal") {
    var_7 = ref_12AC9(var_5, var_1, var_0, 1, var_6);
    var_8 = var_0 + var_5 * 10;
    var_9 = magicgrenademanual("xmike109_grenade", var_8, var_7, 10);
    var_9.unset_relic_hideobjicons = 1;
    playFX(scripts\engine\utility::getfx("xmike109ThermiteBounce"), var_0, var_5);
  } else {
    var_9 = spawn("script_model", var_1);
    var_9 setModel("weapon_wm_sn_xmike109_projectile");
    var_9.origin = var_1;

    if(var_5) {
      var_7 = ref_12AC9(var_6, var_2, var_1, 0, var_9);
      var_9 physicslaunchserver(var_1, var_7);
    }
  }

  var_9.angles = vectortoangles(var_2);
  ref_13142(var_9, var_3);
  var_9.owner = self;
  var_9.brush = var_3;
  var_9.weapon = var_4;
  var_9.vehicle_collision_ignorefutureevent = 1;
  thread ref_128CB();
  ref_11AB5(var_9);
  return var_9;
}

function ref_13142(var_0) {
  switch (var_0) {
    case "thermal":
      thread ref_13143(3.5);
      self.last_saydefuse_time = 0;
      break;
    case "explosive":
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
  ref_11AB5();
}

function ref_11AB5(var_0) {
  if(isDefined(var_0)) {
    var_1 = [var_0];
  } else {
    var_1 = [];
  }

  foreach(var_3 in level.ref_14675) {
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

  level.ref_14675 = var_1;
}

function safehouse_restart(var_0) {
  var_1 = "";

  foreach(var_3 in var_0.attachments) {
    if(issubstr(var_3, "calcust1")) {
      var_1 = "calcust1_xmike109";
      break;
    }

    if(issubstr(var_3, "calcust2")) {
      var_1 = "calcust2_xmike109";
      break;
    }
  }

  switch (var_1) {
    case "calcust2_xmike109":
      return "thermal";
    case "calcust1_xmike109":
      return "explosive";
    default:
      return "default";
  }
}

function safehouse_revive_and_move_players(var_0) {
  switch (var_0) {
    case "thermal":
      return &start_bomb_vest_defusal_sequence;
    case "explosive":
      return &start_bomb_vest_defusal;
    default:
      return &start_bomb_vest_global_timer;
  }
}

function ref_1331F(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_0)) {
    var_0 = "";
  }

  if(var_0 == "riotshield") {
    return 1;
  }

  if(var_1 != "thermal") {
    return 0;
  }

  if(!isDefined(var_2) && isDefined(var_3)) {
    return 1;
  }

  if(use_trace_radius(var_2) || use_struct(var_2)) {
    return 1;
  }

  if(unpause_wave_hud(var_2) || unpause_dmz_scoring(var_2)) {
    return 0;
  }

  if(isDefined(var_2)) {
    if(var_2 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      return 0;
    }

    if(isDefined(var_2.equipmentref) && var_2.equipmentref == "equip_tac_cover") {
      return 0;
    }
  }

  switch (var_0) {
    case "glass_solid":
    case "glass_pane":
    case "riotshield":
      return 1;
    default:
      var_6 = abs(vectordot(var_5, var_4));

      if(var_6 < 0.2) {
        return 1;
      }

      return 0;
  }
}

function ref_12AC9(var_0, var_1, var_2, var_3, var_4) {
  if(var_3) {
    var_5 = 1500;
    var_6 = 500;
    var_7 = 150;
  } else {
    var_5 = 500;
    var_6 = 500;
    var_7 = 500;
  }

  if(isDefined(var_7)) {
    var_8 = var_4;
    var_9 = 0;
  } else {
    var_8 = scripts\engine\math::vector_reflect(var_6, var_5);
    var_8 = vectorlerp(var_8, var_5, 0.2);
    var_9 = abs(vectordot(var_6, var_5));
  }

  if(var_9 < 0.2) {
    var_9 = scripts\engine\math::normalize_value(0, 0.2, var_9);
    var_10 = scripts\engine\math::factor_value(var_7, var_8, var_9);
  } else {
    var_10 = scripts\engine\math::normalize_value(0.2, 1, var_10);
    var_10 = scripts\engine\math::factor_value(var_9, var_8, var_10);
  }

  var_9 *= var_10;
  return var_9;
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

function ref_13309(var_0, var_1) {
  if(var_1 || !isDefined(var_0)) {
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

  if(!istrue(var_0.unset_relic_hideobjicons)) {
    var_0 notsolid();
  }

  thread ref_128D0(var_0);
  thread ref_128CA(var_0, var_1);
  thread ref_128CA(var_0, var_1);
  thread ref_128CA(var_0, var_1);
}

function ref_140D4() {
  if(isDefined(self) && istrue(self.vehicle_collision_ignorefutureevent)) {
    return 1;
  }
}

function ref_12C28(var_0) {
  self endon("entitydeleted");
  var_0 scripts\engine\utility::ref_143A6("entitydeleted", "death", "disconnect");

  if(!ref_140D4()) {
    return;
  }

  self.stuckenemyentity = undefined;

  if(isDefined(var_0) && isDefined(var_0.nocorpse)) {
    self delete();
    return;
  }
}

function ref_128D0(var_0) {
  self endon("entitydeleted");

  if(isagent(var_0)) {
    var_0 waittill("entitydeleted");
  } else {
    var_0 scripts\engine\utility::ref_143A5("entitydeleted", "disconnect");
  }

  if(!ref_140D4()) {
    return;
  }

  ref_128CF();
}

function ref_128CF(var_0) {
  if(!isDefined(var_0)) {
    var_0 = (0, 0, 100);
  }

  if(self islinked()) {
    self unlink();
  }

  if(!istrue(self.unset_relic_hideobjicons)) {
    self solid();
  }

  self physicslaunchserver(self.origin, var_0);
}

function ref_128CA(var_0, var_1) {
  self endon("entitydeleted");
  var_0 waittill(var_1);

  if(!ref_140D4()) {
    return;
  }

  self delete();
}

function ref_128CB() {
  self waittill("entitydeleted");

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

function unpause_wave_hud(var_0) {
  if(!isPlayer(var_0)) {
    return 0;
  }

  if(scripts\mp\utility\player::isenemy(var_0)) {
    return 1;
  }

  return 0;
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

function unpause_dmz_scoring(var_0) {
  if(!isagent(var_0)) {
    return false;
  }

  if(isDefined(var_0.agentteam) && self.team == var_0.agentteam) {
    return false;
  }

  return true;
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
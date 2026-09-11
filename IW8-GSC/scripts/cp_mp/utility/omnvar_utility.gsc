/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\omnvar_utility.gsc
****************************************************/

function tr_vis_facing_dist_add_override(var0) {
  if(!isDefined(level.ref_14675)) {
    level.ref_14675 = [];
    return;
  }
}

function ref_1403e(var0) {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("end_launcher");
  var1 = safehouse_restart(var0);

  if(var1 == "mag_xmike109") {
    return;
  }

  var2 = safehouse_revive_and_move_players(var1);
  thread start_chopper_boss(var0, var1, var2);
}

function handlerelicmartyrdomgas() {
  self waittill("end_launcher");
  wait 6;
  self notify("cleanupXMike109ImpactWatcher");
}

function start_chopper_boss(var0, var1, var2) {
  self notify("cleanupXMike109ImpactWatcher");
  self endon("disconnect");
  self endon("cleanupXMike109ImpactWatcher");
  GscBinSkip4(0x35);
}

function setup_tut_zones(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  var11 = ref_1331f(var4, var9, var0, var1, var3, var6);
  var12 = ref_1368b(var7, var6, var9, var5, var11, var3, var10);

  if(ref_132f1(var0)) {
    var12 delete();
    return;
  } else if(ref_13309(var0, var11)) {
    linktoent(var12, var0, var1);
  }

  if(isDefined(var8)) {
    [[var8]](var12, var0, var1, var2, var4, var11);
    return;
  }
}

function start_bomb_vest_defusal(var0, var1, var2, var3, var4, var5) {
  var6 = 0.1;
  var0.grenade = magicgrenademanual("semtex_xmike109_mp", var0.origin, (0, 0, 0), var6);
  var0.grenade.angles = var0.angles;
  var0.grenade linkTo(var0, "tag_origin");
  thread ref_128cc(var0, var6, var3);
}

function start_bomb_vest_defusal_sequence(var0, var1, var2, var3, var4, var5) {
  thread ref_128cd(var0, var1, var2, var3, var5);
}

function start_bomb_vest_global_timer(var0, var1, var2, var3, var4, var5) {}

function ref_128cc(var0, var1, var2) {
  self endon("disconnect");
  var0 endon("entitydeleted");
  var0.grenade scripts\engine\utility::ref_143bf(var1, "explode");
  var0 setscriptablepartstate("effects", "explode");
  var3 = getcompleteweaponname("semtex_xmike109_mp");
  var4 = getcompleteweaponname("semtex_xmike109_splash_mp");
  var3.ref_121d9 = var0.weapon;
  var4.ref_121d9 = var0.weapon;
  glassradiusdamage(var0.origin, 150, 50, 1);

  if(isDefined(var0.stuckenemyentity) && isalive(var0.stuckenemyentity)) {
    var0.stuckenemyentity scripts\cp_mp\utility\damage_utility::playerplunderbankcallback();
    var0.stuckenemyentity dodamage(175, var0.origin, self, self, "MOD_EXPLOSIVE", var3, var2);
    var0.stuckenemyentity scripts\cp_mp\utility\damage_utility::playerplunderbankdeposit();
  }

  getplaylistname(var0.origin, 9, 35, 15, 25, 60, 14, self, "MOD_EXPLOSIVE", var4);
  wait 0.4;

  if(!ref_140d4(var0)) {
    return;
  }

  var0 delete();
}

function ref_128cd(var0, var1, var2, var3, var4) {
  if(istrue(var0.unset_relic_hideobjicons)) {
    var0 setscriptablepartstate("effects", "reflectThermite");
    ref_1437f(var0);
  }

  var0 setscriptablepartstate("effects", "burn");
  thread ref_13b2b(var0);
  thread ref_13b27(var0);
  thread ref_13b26(var0);
}

function ref_1437f(var0) {
  var0 endon("stuckWaitTimeout");
  thread ref_128d1();
  var0 waittill("missile_stuck", var1, var2);

  if(isDefined(var1)) {
    linktoent(var0, var1, var2);
    var0.debug_listing_helis = 1;
    return;
  }
}

function ref_128d1() {
  wait 3;

  if(isDefined(self)) {
    self notify("stuckWaitTimeout");
    return;
  }
}

function ref_13b2b(var0) {
  self endon("disconnect");
  var0 endon("entitydeleted");
  var1 = getcompleteweaponname("thermite_xmike109_mp");
  var1.ref_121d9 = var0.weapon;

  if(isDefined(var0.stuckenemyentity) && isalive(var0.stuckenemyentity)) {
    if(var0.stuckenemyentity scripts\cp_mp\vehicles\vehicle::isvehicle() || isDefined(var0.stuckenemyentity.classname) && var0.stuckenemyentity.classname == "misc_turret") {
      var2 = 0.95;
    } else {
      var2 = 0.25;
    }

    if(istrue(var1.debug_listing_helis)) {
      var1.stuckenemyentity dodamage(80, var1.origin, self, var1, "MOD_FIRE", var2);
    }

    var3 = int(3 / var2);

    while(isDefined(var1) && isDefined(var1.stuckenemyentity) && isalive(var1.stuckenemyentity) && var3 >= 0) {
      var1.stuckenemyentity scripts\cp_mp\utility\damage_utility::playerplunderbankcallback();
      var1.stuckenemyentity dodamage(3, var1.origin, self, var1, "MOD_FIRE", var2);
      var1.stuckenemyentity scripts\cp_mp\utility\damage_utility::playerplunderbankdeposit();
      var3--;
      wait var2;
    }

    return;
  }
}

function ref_13b27(var0) {
  self endon("disconnect");
  var0 endon("entitydeleted");
  var1 = int(12);
  var2 = getcompleteweaponname("thermite_xmike109_radius_mp");
  var2.ref_121d9 = var0.weapon;
  var0.ref_13b28 = var2.basename;

  while(var1 > 0) {
    if(isDefined(var0.stuckenemyentity) && isalive(var0.stuckenemyentity)) {
      var0.stuckenemyentity scripts\cp_mp\utility\damage_utility::adddamagemodifier("thermite25mmStuck", 0, 0, &ref_13b1c);
    }

    var0 radiusdamage(var0.origin, 50, 2, 2, self, "MOD_FIRE", var2);

    if(isDefined(var0.stuckenemyentity) && isalive(var0.stuckenemyentity)) {
      var0.stuckenemyentity scripts\cp_mp\utility\damage_utility::removedamagemodifier("thermite25mmStuck", 0);
    }

    var1--;
    wait 0.25;
  }
}

function ref_13b1c(var0, var1, var2, var3, var4, var5, var6) {
  if(!isDefined(var0)) {
    return true;
  }

  if(!isDefined(var0.ref_13b28) || var0.ref_13b28 != "thermite_xmike109_radius_mp") {
    return true;
  }

  if(!isDefined(var0.stuckenemyentity) || var0.stuckenemyentity != var2) {
    return true;
  }

  return false;
}

function ref_13b26(var0) {
  var0 endon("entitydeleted");
  wait 3;

  if(!ref_140d4(var0)) {
    return;
  }

  var0 setscriptablepartstate("effects", "burnout");
  var0 setscriptablepartstate("visibility", "hide");
  wait randomfloatrange(0.3, 2);

  if(!ref_140d4(var0)) {
    return;
  }

  wait randomfloatrange(2, 3);
  var0 delete();
}

function ref_1368b(var0, var1, var2, var3, var4, var5, var6) {
  if(var4 && var2 == "thermal") {
    var7 = ref_12ac9(var5, var1, var0, 1, var6);
    var8 = var0 + var5 * 10;
    var9 = magicgrenademanual("xmike109_grenade", var8, var7, 10);
    var9.unset_relic_hideobjicons = 1;
    playFX(scripts\engine\utility::getfx("xmike109ThermiteBounce"), var0, var5);
  } else {
    var9 = spawn("script_model", var1);
    var9 setModel("weapon_wm_sn_xmike109_projectile");
    var9.origin = var1;

    if(var5) {
      var7 = ref_12ac9(var6, var2, var1, 0, var9);
      var9 physicslaunchserver(var1, var7);
    }
  }

  var9.angles = vectortoangles(var2);
  ref_13142(var9, var3);
  var9.owner = self;
  var9.brush = var3;
  var9.weapon = var4;
  var9.vehicle_collision_ignorefutureevent = 1;
  thread ref_128cb();
  ref_11ab5(var9);
  return var9;
}

function ref_13142(var0) {
  switch (var0) {
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

function ref_13143(var0) {
  self endon("entitydeleted");
  wait var0;
  self.last_saydefuse_time = 1;
  ref_11ab5();
}

function ref_11ab5(var0) {
  if(isDefined(var0)) {
    var1 = [var0];
  } else {
    var1 = [];
  }

  foreach(var3 in level.ref_14675) {
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

  level.ref_14675 = var1;
}

function safehouse_restart(var0) {
  var1 = "";

  foreach(var3 in var0.attachments) {
    if(issubstr(var3, "calcust1")) {
      var1 = "calcust1_xmike109";
      break;
    }

    if(issubstr(var3, "calcust2")) {
      var1 = "calcust2_xmike109";
      break;
    }
  }

  switch (var1) {
    case "calcust2_xmike109":
      return "thermal";
    case "calcust1_xmike109":
      return "explosive";
    default:
      return "default";
  }
}

function safehouse_revive_and_move_players(var0) {
  switch (var0) {
    case "thermal":
      return &start_bomb_vest_defusal_sequence;
    case "explosive":
      return &start_bomb_vest_defusal;
    default:
      return &start_bomb_vest_global_timer;
  }
}

function ref_1331f(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var0)) {
    var0 = "";
  }

  if(var0 == "riotshield") {
    return 1;
  }

  if(var1 != "thermal") {
    return 0;
  }

  if(!isDefined(var2) && isDefined(var3)) {
    return 1;
  }

  if(use_trace_radius(var2) || use_struct(var2)) {
    return 1;
  }

  if(unpause_wave_hud(var2) || unpause_dmz_scoring(var2)) {
    return 0;
  }

  if(isDefined(var2)) {
    if(var2 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      return 0;
    }

    if(isDefined(var2.equipmentref) && var2.equipmentref == "equip_tac_cover") {
      return 0;
    }
  }

  switch (var0) {
    case "glass_solid":
    case "glass_pane":
    case "riotshield":
      return 1;
    default:
      var6 = abs(vectordot(var5, var4));

      if(var6 < 0.2) {
        return 1;
      }

      return 0;
  }
}

function ref_12ac9(var0, var1, var2, var3, var4) {
  if(var3) {
    var5 = 1500;
    var6 = 500;
    var7 = 150;
  } else {
    var5 = 500;
    var6 = 500;
    var7 = 500;
  }

  if(isDefined(var7)) {
    var8 = var4;
    var9 = 0;
  } else {
    var8 = scripts\engine\math::vector_reflect(var6, var5);
    var8 = vectorlerp(var8, var5, 0.2);
    var9 = abs(vectordot(var6, var5));
  }

  if(var9 < 0.2) {
    var9 = scripts\engine\math::normalize_value(0, 0.2, var9);
    var10 = scripts\engine\math::factor_value(var7, var8, var9);
  } else {
    var10 = scripts\engine\math::normalize_value(0.2, 1, var10);
    var10 = scripts\engine\math::factor_value(var9, var8, var10);
  }

  var9 *= var10;
  return var9;
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

function ref_13309(var0, var1) {
  if(var1 || !isDefined(var0)) {
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

  if(!istrue(var0.unset_relic_hideobjicons)) {
    var0 notsolid();
  }

  thread ref_128d0(var0);
  thread ref_128ca(var0, var1);
  thread ref_128ca(var0, var1);
  thread ref_128ca(var0, var1);
}

function ref_140d4() {
  if(isDefined(self) && istrue(self.vehicle_collision_ignorefutureevent)) {
    return 1;
  }
}

function ref_12c28(var0) {
  self endon("entitydeleted");
  var0 scripts\engine\utility::ref_143a6("entitydeleted", "death", "disconnect");

  if(!ref_140d4()) {
    return;
  }

  self.stuckenemyentity = undefined;

  if(isDefined(var0) && isDefined(var0.nocorpse)) {
    self delete();
    return;
  }
}

function ref_128d0(var0) {
  self endon("entitydeleted");

  if(isagent(var0)) {
    var0 waittill("entitydeleted");
  } else {
    var0 scripts\engine\utility::ref_143a5("entitydeleted", "disconnect");
  }

  if(!ref_140d4()) {
    return;
  }

  ref_128cf();
}

function ref_128cf(var0) {
  if(!isDefined(var0)) {
    var0 = (0, 0, 100);
  }

  if(self islinked()) {
    self unlink();
  }

  if(!istrue(self.unset_relic_hideobjicons)) {
    self solid();
  }

  self physicslaunchserver(self.origin, var0);
}

function ref_128ca(var0, var1) {
  self endon("entitydeleted");
  var0 waittill(var1);

  if(!ref_140d4()) {
    return;
  }

  self delete();
}

function ref_128cb() {
  self waittill("entitydeleted");

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

function unpause_wave_hud(var0) {
  if(!isPlayer(var0)) {
    return 0;
  }

  if(scripts\mp\utility\player::isenemy(var0)) {
    return 1;
  }

  return 0;
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

function unpause_dmz_scoring(var0) {
  if(!isagent(var0)) {
    return false;
  }

  if(isDefined(var0.agentteam) && self.team == var0.agentteam) {
    return false;
  }

  return true;
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
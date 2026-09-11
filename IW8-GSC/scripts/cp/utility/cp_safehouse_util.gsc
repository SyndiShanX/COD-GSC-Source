/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\cp_safehouse_util.gsc
****************************************************/

function tr_vis_facing_dist_add_override(var0) {}

function ref_1403e(var0) {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("end_launcher");
  var1 = register_outer_room_spawners(var0);

  if(var1 == "mag_aalpha12") {
    return;
  }

  var2 = register_player_character(var1);
  thread start_chopper_boss(var0, var1, var2);
}

function handlerelicmartyrdomgas() {
  self waittill("end_launcher");
  wait 6;
  self notify("cleanupaalpha12ImpactWatcher");
}

function start_chopper_boss(var0, var1, var2) {
  self notify("cleanupaalpha12ImpactWatcher");
  self endon("disconnect");
  self endon("cleanupaalpha12ImpactWatcher");
  GscBinSkip4(0x35);
}

function setup_tut_zones(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  var10 = ref_1331f(var4, var9, var0, var1, var3, var6);

  if(var10) {
    var7 = ref_12ac9(var3, var6, var7, 0);
  }

  var11 = ref_1368b(var7, var6, var9, var5, var10, var3);

  if(ref_132f1(var0)) {
    var11 delete();
    return;
  } else if(ref_13309(var0, var10)) {
    linktoent(var11, var0, var1);
  }

  if(isDefined(var8)) {
    [[var8]](var11, var2, var7, var3);
    return;
  }
}

function start_bomb_vest_defusal(var0, var1, var2, var3) {
  thread ref_128cc(var0, var1, var2, var3);
}

function start_bomb_vest_global_timer(var0, var1, var2, var3) {}

function ref_128cc(var0, var1, var2, var3) {
  self endon("disconnect");
  var0 endon("entitydeleted");
  var0 scripts\engine\utility::ref_143bf(0, "explode");
  playFX(level._effect["aalpha12_explo"], var2, var3);
  var4 = getcompleteweaponname("semtex_aalpha12_mp");
  var5 = getcompleteweaponname("semtex_aalpha12_splash_mp");
  var4.ref_121d9 = var0.weapon;
  var5.ref_121d9 = var0.weapon;
  var4.ref_136fa = var5;
  glassradiusdamage(var0.origin, 130, 50, 1);

  if(isDefined(var0.stuckenemyentity) && isalive(var0.stuckenemyentity)) {
    var0.stuckenemyentity scripts\cp_mp\utility\damage_utility::playerplunderbankcallback();
    var0.stuckenemyentity dodamage(1, var0.origin, self, self, "MOD_EXPLOSIVE", var4, var1);
    var0.stuckenemyentity scripts\cp_mp\utility\damage_utility::playerplunderbankdeposit();
  }

  getplaylistname(var0.origin, 11, 25, 12, 25, 35, 14, self, "MOD_EXPLOSIVE", var5);
  wait 0.4;

  if(!ref_140d4(var0)) {
    return;
  }

  var0 delete();
}

function ref_1368b(var0, var1, var2, var3, var4, var5) {
  var6 = magicgrenademanual("semtex_aalpha12_mp", var0, (0, 0, 0), 0);
  var6.angles = vectortoangles(var5);
  var6.unset_relic_hideobjicons = 1;
  var6.owner = self;
  var6.brush = var2;
  var6.weapon = var3;
  var6.turn_on_light_when_elevator_close_by = 1;
  return var6;
}

function register_outer_room_spawners(var0) {
  var1 = "";

  if(var0 hasattachment("calcustmags_aalpha12")) {
    return "explosive";
  }

  return "default";
}

function register_player_character(var0) {
  switch (var0) {
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
    return true;
  }

  return false;
}

function ref_12ac9(var0, var1, var2, var3) {
  return var2 + var0 * 25;
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
  if(isDefined(self) && istrue(self.turn_on_light_when_elevator_close_by)) {
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
    self physicslaunchserver(self.origin, var0);
    return;
  }
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
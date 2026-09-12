/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\cp_safehouse_util.gsc
****************************************************/

function tr_vis_facing_dist_add_override(var_0) {}

function ref_1403E(var_0) {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("end_launcher");
  var_1 = register_outer_room_spawners(var_0);

  if(var_1 == "mag_aalpha12") {
    return;
  }

  var_2 = register_player_character(var_1);
  thread start_chopper_boss(var_0, var_1, var_2);
}

function handlerelicmartyrdomgas() {
  self waittill("end_launcher");
  wait 6;
  self notify("cleanupaalpha12ImpactWatcher");
}

function start_chopper_boss(var_0, var_1, var_2) {
  self notify("cleanupaalpha12ImpactWatcher");
  self endon("disconnect");
  self endon("cleanupaalpha12ImpactWatcher");
  GscBinSkip4(0x35);
}

function setup_tut_zones(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = ref_1331F(var_4, var_9, var_0, var_1, var_3, var_6);

  if(var_10) {
    var_7 = ref_12AC9(var_3, var_6, var_7, 0);
  }

  var_11 = ref_1368B(var_7, var_6, var_9, var_5, var_10, var_3);

  if(ref_132F1(var_0)) {
    var_11 delete();
    return;
  } else if(ref_13309(var_0, var_10)) {
    linktoent(var_11, var_0, var_1);
  }

  if(isDefined(var_8)) {
    [[var_8]](var_11, var_2, var_7, var_3);
    return;
  }
}

function start_bomb_vest_defusal(var_0, var_1, var_2, var_3) {
  thread ref_128CC(var_0, var_1, var_2, var_3);
}

function start_bomb_vest_global_timer(var_0, var_1, var_2, var_3) {}

function ref_128CC(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  var_0 endon("entitydeleted");
  var_0 scripts\engine\utility::ref_143BF(0, "explode");
  playFX(level._effect["aalpha12_explo"], var_2, var_3);
  var_4 = getcompleteweaponname("semtex_aalpha12_mp");
  var_5 = getcompleteweaponname("semtex_aalpha12_splash_mp");
  var_4.ref_121D9 = var_0.weapon;
  var_5.ref_121D9 = var_0.weapon;
  var_4.ref_136FA = var_5;
  glassradiusdamage(var_0.origin, 130, 50, 1);

  if(isDefined(var_0.stuckenemyentity) && isalive(var_0.stuckenemyentity)) {
    var_0.stuckenemyentity scripts\cp_mp\utility\damage_utility::playerplunderbankcallback();
    var_0.stuckenemyentity dodamage(1, var_0.origin, self, self, "MOD_EXPLOSIVE", var_4, var_1);
    var_0.stuckenemyentity scripts\cp_mp\utility\damage_utility::playerplunderbankdeposit();
  }

  getplaylistname(var_0.origin, 11, 25, 12, 25, 35, 14, self, "MOD_EXPLOSIVE", var_5);
  wait 0.4;

  if(!ref_140D4(var_0)) {
    return;
  }

  var_0 delete();
}

function ref_1368B(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = magicgrenademanual("semtex_aalpha12_mp", var_0, (0, 0, 0), 0);
  var_6.angles = vectortoangles(var_5);
  var_6.unset_relic_hideobjicons = 1;
  var_6.owner = self;
  var_6.brush = var_2;
  var_6.weapon = var_3;
  var_6.turn_on_light_when_elevator_close_by = 1;
  return var_6;
}

function register_outer_room_spawners(var_0) {
  var_1 = "";

  if(var_0 hasattachment("calcustmags_aalpha12")) {
    return "explosive";
  }

  return "default";
}

function register_player_character(var_0) {
  switch (var_0) {
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
    return true;
  }

  return false;
}

function ref_12AC9(var_0, var_1, var_2, var_3) {
  return var_2 + var_0 * 25;
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
  if(isDefined(self) && istrue(self.turn_on_light_when_elevator_close_by)) {
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
    self physicslaunchserver(self.origin, var_0);
    return;
  }
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
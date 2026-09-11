/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\to_blitz.gsc
***********************************************/

function main() {
  maintacopsinit();
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();

  if(isusingmatchrulesdata()) {
    scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  }

  maintacopspostinit();
  level.startedfromtacops = 0;
  level.onstartgametype = &onstartgametype;
}

function maintacops() {
  maintacopsinit();
  maintacopspostinit();
  level.waypointcolors["waypoint_capture_take"] = "neutral";
  level.waypointbgtype["waypoint_capture_take"] = 2;
  level.startedfromtacops = 1;
  onstartgametype(1);
}

function maintacopsinit() {
  level.tacopssublevel = "to_blitz";
  level.currentmode = "to_blitz";
  setomnvar("ui_tac_ops_submode", level.currentmode);
}

function maintacopspostinit() {
  if(isusingmatchrulesdata()) {
    level.initializematchrules = &initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar("to_blitz", 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar("to_blitz", 10);
    scripts\mp\utility\game::registerscorelimitdvar("to_blitz", 65);
    scripts\mp\utility\game::registerroundlimitdvar("to_blitz", 1);
    scripts\mp\utility\game::registerwinlimitdvar("to_blitz", 1);
    scripts\mp\utility\game::registernumlivesdvar("to_blitz", 0);
    scripts\mp\utility\game::registerhalftimedvar("to_blitz", 0);
    scripts\mp\utility\game::registerdogtagsenableddvar("to_blitz", 0);
    level.matchrules_damagemultiplier = 0;
  }

  updategametypedvars();
  level.teambased = 1;
  level.onnormaldeath = &onnormaldeath;
  level.modeonspawnplayer = &onspawnplayer;
  level.ontimelimit = &scripts\mp\gamelogic::default_ontimelimit;
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_to_blitz_waverespawndelay", 5);
  setdynamicdvar("scr_to_blitz_waverespawndelay_alt", 10);
  setdynamicdvar("scr_conf_pointsPerConfirm", getmatchrulesdata("confData", "pointsPerConfirm"));
  setdynamicdvar("scr_conf_pointsPerDeny", getmatchrulesdata("confData", "pointsPerDeny"));
  setdynamicdvar("scr_conf_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("conf", 0);
  setdynamicdvar("scr_conf_promode", 0);
}

function onstartgametype(var_0) {
  GscBinSkip1(0x45, 0, "dd");
}

function setupbradleys() {
  level.tankobjkeys = [];
  var_0 = scripts\engine\utility::getStructArray("tank_spawn", "targetname");
  var_1 = 0;

  foreach(var_3 in var_0) {}

  thread initobjicons();
  setomnvar("ui_tacops_tank_a_health_percent", 1);
  setomnvar("ui_tacops_tank_b_health_percent", 1);
}

function bradleydamagewatcher() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  level endon("switch_modes");

  for(;;) {
    self waittill("damage", var_0);

    if(self.tacopsindex == 0) {
      setomnvar("ui_tacops_tank_a_health_percent", (self.maxhealth - self.damagetaken) / self.maxhealth);
      continue;
    }

    if(self.tacopsindex == 1) {
      setomnvar("ui_tacops_tank_b_health_percent", (self.maxhealth - self.damagetaken) / self.maxhealth);
    }
  }
}

function setuptankendgoal() {
  level waittill("goal_opened");
  var_0 = getEnt("tank_goal", "targetname");

  if(!isDefined(var_0)) {
    spawnmanualdomflag();
    return;
  }

  level.objectives = [];
  level.objectives[0] = var_0;
  var_1 = scripts\mp\gametypes\obj_dom::setupobjective(level.objectives[0]);
  var_1.onuse = &dompoint_onuse;
  level.objectives[0] = var_1;
  level.flagcapturetime = 1;
  level.flagneutralization = 1;
  waitframe();
  var_1.nocarryobject = 1;
  var_1 scripts\mp\gameobjects::setkeyobject(level.tankobjkeys);
  var_1 scripts\mp\gameobjects::setownerteam("axis");
  var_1 scripts\mp\gameobjects::setvisibleteam("any");
  var_1 scripts\mp\gameobjects::allowuse("enemy");
  var_1 scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
}

function bradley_handletacopsdamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;

  if(var_3 == "MOD_MELEE") {
    return 0;
  }

  if(var_1.team == "allies") {
    return 0;
  }

  var_4 = getmodifiedtankdamage(var_1, var_2, var_3, var_4, 3000, 10, 15, 20);
  var_0.damage = var_4;
  return var_4;
}

function getmodifiedtankdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = undefined;

  if(var_2 != "MOD_MELEE") {
    switch (var_1.basename) {
      case "kineticpulse_emp_mp":
      case "c4_mp_p":
      case "super_trophy_mp":
        self.largeprojectiledamage = 1;
        var_9 = var_5;
        break;
      case "tur_bradley_tacops_mp":
      case "switch_blade_child_mp":
      case "drone_hive_projectile_mp":
      case "tur_bradley_mp":
      case "emp_grenade_mp":
      case "iw8_la_juliet_mp":
      case "iw8_la_rpapa7_mp":
      case "iw8_la_kgolf_mp":
      case "iw8_la_gromeo_mp":
      case "iw8_la_t9freefire_mp":
      case "iw8_la_t9standard_mp":
        self.largeprojectiledamage = 1;
        var_9 = var_6;
        break;
      case "power_exploding_drone_mp":
      case "sentry_shock_missile_mp":
      case "jackal_cannon_mp":
      case "pop_rocket_proj_mp":
      case "artillery_mp":
        self.largeprojectiledamage = 0;
        var_9 = var_7;
        break;
      default:
        self.largeprojectiledamage = 0;
        break;
    }
  }

  if(isDefined(var_8)) {
    self.largeprojectiledamage = var_8;
  }

  if(self.largeprojectiledamage == 0) {
    return 0;
  }

  if(isDefined(var_9) && isDefined(var_2) && (var_2 == "MOD_EXPLOSIVE" || var_2 == "MOD_EXPLOSIVE_BULLET" || var_2 == "MOD_PROJECTILE" || var_2 == "MOD_PROJECTILE_SPLASH" || var_2 == "MOD_GRENADE")) {
    var_3 = ceil(var_4 / var_9);
  }

  if(isDefined(var_0) && isDefined(self.owner)) {
    if(isDefined(var_0.owner)) {
      var_0 = var_0.owner;
    }

    if(var_0 == self.owner) {
      var_3 = ceil(var_3 / 2);
    }
  }

  return int(var_3);
}

function bradley_handlefataltacopsdamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;

  if(level.teambased) {
    var_6 = "";

    if(isDefined(var_1) && isDefined(var_1.team)) {
      var_6 = var_1.team;
    }

    if(var_6 != self.team) {}
  } else if(isDefined(var_1) && (!isDefined(self.owner) || self.owner != var_1)) {}

  self.trackedobject scripts\mp\gameobjects::deletetrackedobject();
  thread bradley_vehicledestroy(var_1, var_2, var_3, 0);

  if(self.tacopsindex == 0) {
    setomnvar("ui_tacops_tank_a_health_percent", 0);
    return;
  }

  if(self.tacopsindex == 1) {
    setomnvar("ui_tacops_tank_b_health_percent", 0);
    return;
  }
}

function bradley_vehicledestroy(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.attacker = var_0;
  var_4.objweapon = var_1;
  var_4.meansofdeath = var_2;
  scripts\cp_mp\vehicles\light_tank::light_tank_explode(var_4, var_3);
  level.to_blitzactivebradleys--;

  if(level.to_blitzactivebradleys == 0) {
    if(isDefined(level.onphaseend)) {
      game["attackers"] = "allies";
      game["defenders"] = "axis";
      [[level.onphaseend]]("axis");
      return;
    }

    thread scripts\mp\gamelogic::endgame("axis", game["end_reason"][game["attackers"] + "_eliminated"]);
    return;
  }
}

function initspawns() {
  var_0 = level.tacopsspawns;
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_toblitz_spawn_allies", 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_toblitz_spawn_axis", 1);
  var_0.to_blitz_spawns = [];
  var_0.to_blitz_spawns["allies"] = scripts\mp\spawnlogic::getspawnpointarray("mp_toblitz_spawn_allies");
  var_0.to_blitz_spawns["axis"] = scripts\mp\spawnlogic::getspawnpointarray("mp_toblitz_spawn_axis");

  if(var_0.to_blitz_spawns["allies"].size <= 0) {
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_front_spawn_allies");
    var_0.to_blitz_spawns["allies"] = scripts\mp\spawnlogic::getspawnpointarray("mp_front_spawn_allies");
  }

  if(var_0.to_blitz_spawns["axis"].size <= 0) {
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_front_spawn_axis");
    var_0.to_blitz_spawns["axis"] = scripts\mp\spawnlogic::getspawnpointarray("mp_front_spawn_axis");
    return;
  }
}

function getspawnpoint() {
  var_0 = level.tacopsspawns;
  var_1 = self.pers["team"];
  var_2 = scripts\mp\tac_ops_map::filterspawnpoints(var_0.to_blitz_spawns[var_1]);
  var_3 = undefined;
  return var_3;
}

function activatespawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("TDM");
  scripts\mp\tac_ops_map::setactivemapconfig("to_blitz", "allies");
  scripts\mp\tac_ops_map::setactivemapconfig("to_blitz", "axis");
  level.getspawnpoint = &getspawnpoint;
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
}

function onnormaldeath(var_0, var_1, var_2, var_3, var_4) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4);
}

function onspawnplayer() {
  if(self.team == "axis") {
    thread onspawnfinished();
  }

  var_0 = 0;

  if(self.team == "allies") {
    var_0 = 1;
  } else if(self.team == "axis") {
    var_0 = 2;
  }

  self setclientomnvar("ui_tacops_team", var_0);
  scripts\mp\tac_ops\roles_utility::kitspawn();
}

function onspawnfinished() {
  self endon("death_or_disconnect");
  self waittill("giveLoadout");
  scripts\mp\equipment::giveequipment("equip_c4", "primary");
  var_0 = self getweaponslist("primary");

  foreach(var_2 in var_0) {
    var_3 = getweaponbasename(var_2);

    switch (var_3) {
      case "iw8_la_lapha_mp":
      case "iw8_la_juliet_mp":
      case "iw8_la_rpapa7_mp":
      case "iw8_la_t9freefire_mp":
        var_4 = getcompleteweaponname("iw8_pi_usierra45_mp");
        scripts\cp_mp\utility\inventory_utility::takeweaponwhensafe(var_2);
        self giveweapon(var_4);
        self givestartammo(var_4);
        break;
    }
  }
}

function setuprpgcaches() {
  level.rpg7caches = [];
  var_0 = getEntArray("rpg_cache", "targetname");
  var_1 = getEntArray("rpg_use_trigger", "targetname");

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = spawn("script_model", var_0[var_2].origin);
    var_3 setModel("care_package_iw7_dummy");
    var_3.angles = var_0[var_2].angles;
    var_0[var_2] scripts\mp\utility\outline::outlineenableforteam(var_0[var_2], "axis", "outline_nodepth_cyan", "lowest");
    var_0[var_2].ownerteam = "axis";
    var_0[var_2].interactteam = "friendly";
    var_0[var_2].exclusiveuse = 0;
    var_0[var_2].curprogress = 0;
    var_0[var_2].usetime = 0;
    var_0[var_2].userate = 1;
    var_0[var_2].id = "care_package";
    var_0[var_2].skiptouching = 1;
    var_0[var_2].trigger = var_1[var_2];
    var_0[var_2].trigger.angles = var_0[var_2].angles;
    var_0[var_2].trigger setCursorHint("HINT_NOICON");
    var_0[var_2].trigger setHintString(&"MP/PICKUP_RPG7");
    var_0[var_2].trigger.team = "axis";
    var_0[var_2].trigger.destination = var_0[var_2].origin;
    var_0[var_2].onuse = &rpgcrateenduse;
    var_0[var_2] thread scripts\mp\gameobjects::useobjectusethink();
    thread rpgcrateuseteamupdater(var_0[var_2]);
    level.rpg7caches[level.rpg7caches.size] = var_0[var_2];
  }
}

function rpgcrateenduse(var_0) {
  var_0 setclientomnvar("ui_securing", 0);
  var_0 setclientomnvar("ui_securing_progress", 0.01);
  var_1 = var_0.lastdroppableweaponobj;
  var_2 = var_0 dropitem(var_1);

  if(isDefined(var_2)) {
    var_2.owner = var_0;
    var_2.targetname = "dropped_weapon";
    var_2 thread scripts\mp\weapons::watchpickup(var_0);
    var_2 thread scripts\mp\weapons::deletepickupafterawhile();
  }

  var_0 giveweapon("iw8_la_rpapa7_mp");
  var_0 givestartammo("iw8_la_rpapa7_mp");
  var_0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch("iw8_la_rpapa7_mp", 1);
  var_0 scripts\mp\weapons::ref_1316b(getcompleteweaponname("iw8_la_rpapa7_mp"));
}

function rpgcrateuseteamupdater(var_0) {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    setusablebyteam(var_0);
    level waittill("joined_team");
  }
}

function setusablebyteam(var_0) {
  foreach(var_2 in level.players) {
    if(var_2.team != var_0) {
      self.trigger disableplayeruse(var_2);
      continue;
    }

    self.trigger enableplayeruse(var_2);
  }
}

function initobjicons() {
  foreach(var_1 in level.bradley.activevehicles["allies"]) {
    var_1.trackedobject = var_1 scripts\mp\gameobjects::createtrackedobject(var_1, (0, 0, 0));
    var_1.trackedobject.objidpingfriendly = 0;
    var_1.trackedobject.objidpingenemy = 1;
    var_1.trackedobject.objpingdelay = 0.05;
    var_1.trackedobject.visibleteam = "any";
    var_1.invulnerable = 1;
    var_1.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.icontake, level.iconkill);
    thread watchiconupdater();
  }
}

function watchiconupdater() {
  level endon("game_ended");

  for(;;) {
    scripts\engine\utility::ref_143a6("bradley_driverUpdate", "death", "bradley_vehicleExit");
    var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "driver");

    if(isDefined(var_0) && isDefined(self.trackedobject.visibleteam)) {
      self.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconkill);
      continue;
    }

    if(isDefined(self.trackedobject.visibleteam)) {
      self.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.icontake, level.iconkill);
    }
  }
}

function seticonnames() {
  level.waypointcolors["waypoint_capture_take"] = "neutral";
  level.waypointbgtype["waypoint_capture_take"] = 2;
  level.icontake = "waypoint_capture_take";
  level.iconkill = "waypoint_capture_kill";
  level.iconneutral = "koth_neutral";
  level.iconcapture = "koth_enemy";
  level.icondefend = "koth_friendly";
  level.iconcontested = "waypoint_hardpoint_contested";
  level.icontaking = "waypoint_taking_chevron";
  level.iconlosing = "waypoint_hardpoint_losing";
}

function setupbarriers() {
  var_0 = getEntArray("barrier_checkpoint", "targetname");

  foreach(var_2 in var_0) {
    var_2 setCanDamage(1);
    var_2.health = 10000;
    var_2.team = "axis";
    thread barriermonitordamage();
    thread barriermonitordeath();
  }

  level.totalbarriers = var_0.size;
}

function barriermonitordamage() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("damage", var_0);
    iprintln("Wall hit for " + var_0 + ", health left " + self.health);
  }
}

function barriermonitordeath() {
  level endon("game_ended");
  self waittill("death");
  iprintln("Wall DEAD");
  thread barrier_destroy();
}

function barrier_deathfunc(var_0, var_1, var_2, var_3, var_4) {
  if(level.teambased) {
    var_5 = "";

    if(isDefined(var_0) && isDefined(var_0.team)) {
      var_5 = var_0.team;
    }

    if(var_5 != self.team) {}
  } else if(isDefined(var_0) && (!isDefined(self.owner) || self.owner != var_0)) {}

  thread barrier_destroy(var_0, var_1, var_2, 0);
}

function barrier_destroy(var_0, var_1, var_2, var_3) {
  playFX(level.barrier_explode, self.origin);
  playFX(level.barrier_explode, self.origin + (0, -150, 0));
  playFX(level.barrier_explode, self.origin + (0, 150, 0));
  playFX(level.barrier_explode, self.origin + (150, 0, 0));
  playFX(level.barrier_explode, self.origin + (-150, 0, 0));
  playrumbleonposition("grenade_rumble", self.origin);
  earthquake(0.75, 2, self.origin, 2000);
  self delete();
  level.totalbarriers--;

  if(level.totalbarriers == 0) {
    level notify("goal_opened");
    return;
  }
}

function barrier_dmgfunc(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 == "MOD_MELEE") {
    return 0;
  }

  if(var_0.team == self.team) {
    return 0;
  }

  var_3 = getmodifiedbarrierdamage(var_0, var_1, var_2, var_3, 10000, 10, 15, 50);
  return var_3;
}

function getmodifiedbarrierdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = var_1.isalternate;
  var_10 = 0;

  if(istrue(var_9)) {
    var_11 = scripts\mp\utility\weapon::getweaponattachmentsbasenames(var_1);

    foreach(var_13 in var_11) {
      if(var_13 == "gl") {
        var_10 = 1;
        break;
      }
    }
  }

  var_15 = undefined;

  if(var_2 != "MOD_MELEE") {
    switch (var_1.basename) {
      case "iw8_la_lapha_mp":
      case "c4_mp_p":
      case "iw8_la_juliet_mp":
      case "iw8_la_rpapa7_mp":
      case "iw8_la_t9freefire_mp":
        self.largeprojectiledamage = 1;
        var_15 = var_5;
        break;
      case "switch_blade_child_mp":
      case "drone_hive_projectile_mp":
      case "tur_bradley_mp":
        self.largeprojectiledamage = 1;
        var_15 = var_6;
        break;
      case "jackal_cannon_mp":
      case "lighttank_mp":
      case "artillery_mp":
        self.largeprojectiledamage = 0;
        var_15 = var_7;
        break;
      case "iw7_arclassic_mp":
        if(istrue(var_10)) {
          self.largeprojectiledamage = 0;
          var_15 = var_7;
        }

        break;
      default:
        var_3 = 0;
        break;
    }
  }

  if(isDefined(var_8)) {
    self.largeprojectiledamage = var_8;
  }

  if(isDefined(var_15) && isDefined(var_2) && (var_2 == "MOD_EXPLOSIVE" || var_2 == "MOD_EXPLOSIVE_BULLET" || var_2 == "MOD_PROJECTILE" || var_2 == "MOD_PROJECTILE_SPLASH" || var_2 == "MOD_GRENADE")) {
    var_3 = ceil(var_4 / var_15);
  }

  if(isDefined(var_0) && isDefined(self.owner)) {
    if(isDefined(var_0.owner)) {
      var_0 = var_0.owner;
    }

    if(var_0 == self.owner) {
      var_3 = ceil(var_3 / 2);
    }
  }

  return int(var_3);
}

function ontimelimit() {
  if(isDefined(level.onphaseend)) {
    var_0 = scripts\mp\gamescore::freight_lift_door_switch(0);
    [[level.onphaseend]](var_0);
  }

  scripts\mp\gamescore::_setteamscore("axis", 1, 0);
  thread scripts\mp\gamelogic::endgame("axis", game["end_reason"]["objective_completed"]);
}

function spawnmanualdomflag() {
  level.flagcapturetime = 1;
  level.flagneutralization = 1;
  var_0 = spawnStruct();
  var_0.origin = (7524, 11709, 308);
  var_0.angles = (0, 0, 0);
  var_1 = spawn("trigger_radius", var_0.origin, 0, 160, 128);
  var_1.radius = 160;
  var_0.trigger = var_1;
  var_0.trigger.script_label = "";
  var_0.ownerteam = "neutral";
  var_2 = var_0.origin + (0, 0, 32);
  var_3 = var_0.origin + (0, 0, -32);
  var_4 = scripts\engine\trace::ray_trace(var_2, var_3, undefined, scripts\engine\trace::create_default_contents(1));
  var_0.origin = var_4["position"];
  var_0.upangles = vectortoangles(var_4["normal"]);
  var_0.forward = anglesToForward(var_0.upangles);
  var_0.right = anglestoright(var_0.upangles);
  var_0.visuals[0] = spawn("script_model", var_0.origin);
  var_0.visuals[0].angles = var_0.angles;
  var_5 = scripts\mp\gameobjects::createuseobject("neutral", var_0.trigger, var_0.visuals, (0, 0, 100));
  var_5 scripts\mp\gameobjects::allowuse("enemy");
  var_5 scripts\mp\gameobjects::setusetime(1);
  var_5 scripts\mp\gameobjects::setusetext(&"MP/SECURING_POSITION");
  var_6 = "";
  var_5.label = var_6;
  var_5 scripts\mp\gameobjects::setobjectivestatusicons(level.iconfriendlyextract3d, level.icondefend);
  var_5 scripts\mp\gameobjects::setvisibleteam("any");
  var_5.onuse = &dompoint_onuse;
  var_5.onbeginuse = &scripts\mp\gametypes\obj_dom::dompoint_onusebegin;
  var_5.onuseupdate = &scripts\mp\gametypes\obj_dom::dompoint_onuseupdate;
  var_5.onenduse = &scripts\mp\gametypes\obj_dom::dompoint_onuseend;
  var_5.oncontested = &scripts\mp\gametypes\obj_dom::dompoint_oncontested;
  var_5.onuncontested = &scripts\mp\gametypes\obj_dom::dompoint_onuncontested;
  var_5.nousebar = 1;
  var_5.id = "domFlag";
  var_5.claimgracetime = level.flagcapturetime * 1000;
  var_5.firstcapture = 1;
  var_5 scripts\mp\gameobjects::setkeyobject(level.tankobjkeys);
  var_5.nocarryobject = 1;
  level.objectives = [];
  level.objectives[0] = var_5;
  var_2 = var_0.visuals[0].origin + (0, 0, 32);
  var_3 = var_0.visuals[0].origin + (0, 0, -32);
  var_7 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_8 = [];
  var_4 = scripts\engine\trace::ray_trace(var_2, var_3, var_8, var_7);
  var_5.baseeffectpos = var_4["position"];
  var_9 = vectortoangles(var_4["normal"]);
  var_5.baseeffectforward = anglesToForward(var_9);
  var_10 = spawn("script_model", var_5.baseeffectpos);
  var_10 setModel("dom_flag_scriptable");
  var_10.angles = generateaxisanglesfromforwardvector(var_5.baseeffectforward, var_10.angles);
  var_5.scriptable = var_10;
  var_5.vfxnamemod = "";

  if(var_5.trigger.radius == 160) {
    var_5.vfxnamemod = "_160";
  } else if(var_5.trigger.radius == 90) {
    var_5.vfxnamemod = "_90";
  } else if(var_5.trigger.radius == 315) {
    var_5.vfxnamemod = "_300";
  }

  var_5 scripts\mp\gameobjects::setownerteam("axis");
  var_5 scripts\mp\gameobjects::setvisibleteam("any");
  var_5 scripts\mp\gameobjects::allowuse("enemy");
  var_5 scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
  var_5 scripts\mp\gametypes\obj_dom::updateflagstate("axis", 0);
}

function dompoint_onuse(var_0) {
  scripts\mp\gametypes\obj_dom::dompoint_onuse(var_0);

  if(var_0.team == "allies") {
    scripts\mp\gamescore::_setteamscore("allies", 1, 0);
    thread scripts\mp\gamelogic::endgame("allies", game["end_reason"]["objective_completed"]);
    return;
  }
}
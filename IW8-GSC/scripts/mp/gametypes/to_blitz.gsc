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

function onstartgametype(var0) {
  GscBinSkip1(0x45, 0, "dd");
}

function setupbradleys() {
  level.tankobjkeys = [];
  var0 = scripts\engine\utility::getStructArray("tank_spawn", "targetname");
  var1 = 0;

  foreach(var3 in var0) {}

  thread initobjicons();
  setomnvar("ui_tacops_tank_a_health_percent", 1);
  setomnvar("ui_tacops_tank_b_health_percent", 1);
}

function bradleydamagewatcher() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  level endon("switch_modes");

  for(;;) {
    self waittill("damage", var0);

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
  var0 = getEnt("tank_goal", "targetname");

  if(!isDefined(var0)) {
    spawnmanualdomflag();
    return;
  }

  level.objectives = [];
  level.objectives[0] = var0;
  var1 = scripts\mp\gametypes\obj_dom::setupobjective(level.objectives[0]);
  var1.onuse = &dompoint_onuse;
  level.objectives[0] = var1;
  level.flagcapturetime = 1;
  level.flagneutralization = 1;
  waitframe();
  var1.nocarryobject = 1;
  var1 scripts\mp\gameobjects::setkeyobject(level.tankobjkeys);
  var1 scripts\mp\gameobjects::setownerteam("axis");
  var1 scripts\mp\gameobjects::setvisibleteam("any");
  var1 scripts\mp\gameobjects::allowuse("enemy");
  var1 scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
}

function bradley_handletacopsdamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var0.idflags;

  if(var3 == "MOD_MELEE") {
    return 0;
  }

  if(var1.team == "allies") {
    return 0;
  }

  var4 = getmodifiedtankdamage(var1, var2, var3, var4, 3000, 10, 15, 20);
  var0.damage = var4;
  return var4;
}

function getmodifiedtankdamage(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var9 = undefined;

  if(var2 != "MOD_MELEE") {
    switch (var1.basename) {
      case "kineticpulse_emp_mp":
      case "c4_mp_p":
      case "super_trophy_mp":
        self.largeprojectiledamage = 1;
        var9 = var5;
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
        var9 = var6;
        break;
      case "power_exploding_drone_mp":
      case "sentry_shock_missile_mp":
      case "jackal_cannon_mp":
      case "pop_rocket_proj_mp":
      case "artillery_mp":
        self.largeprojectiledamage = 0;
        var9 = var7;
        break;
      default:
        self.largeprojectiledamage = 0;
        break;
    }
  }

  if(isDefined(var8)) {
    self.largeprojectiledamage = var8;
  }

  if(self.largeprojectiledamage == 0) {
    return 0;
  }

  if(isDefined(var9) && isDefined(var2) && (var2 == "MOD_EXPLOSIVE" || var2 == "MOD_EXPLOSIVE_BULLET" || var2 == "MOD_PROJECTILE" || var2 == "MOD_PROJECTILE_SPLASH" || var2 == "MOD_GRENADE")) {
    var3 = ceil(var4 / var9);
  }

  if(isDefined(var0) && isDefined(self.owner)) {
    if(isDefined(var0.owner)) {
      var0 = var0.owner;
    }

    if(var0 == self.owner) {
      var3 = ceil(var3 / 2);
    }
  }

  return int(var3);
}

function bradley_handlefataltacopsdamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var0.idflags;

  if(level.teambased) {
    var6 = "";

    if(isDefined(var1) && isDefined(var1.team)) {
      var6 = var1.team;
    }

    if(var6 != self.team) {}
  } else if(isDefined(var1) && (!isDefined(self.owner) || self.owner != var1)) {}

  self.trackedobject scripts\mp\gameobjects::deletetrackedobject();
  thread bradley_vehicledestroy(var1, var2, var3, 0);

  if(self.tacopsindex == 0) {
    setomnvar("ui_tacops_tank_a_health_percent", 0);
    return;
  }

  if(self.tacopsindex == 1) {
    setomnvar("ui_tacops_tank_b_health_percent", 0);
    return;
  }
}

function bradley_vehicledestroy(var0, var1, var2, var3) {
  var4 = spawnStruct();
  var4.attacker = var0;
  var4.objweapon = var1;
  var4.meansofdeath = var2;
  scripts\cp_mp\vehicles\light_tank::light_tank_explode(var4, var3);
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
  var0 = level.tacopsspawns;
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_toblitz_spawn_allies", 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_toblitz_spawn_axis", 1);
  var0.to_blitz_spawns = [];
  var0.to_blitz_spawns["allies"] = scripts\mp\spawnlogic::getspawnpointarray("mp_toblitz_spawn_allies");
  var0.to_blitz_spawns["axis"] = scripts\mp\spawnlogic::getspawnpointarray("mp_toblitz_spawn_axis");

  if(var0.to_blitz_spawns["allies"].size <= 0) {
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_front_spawn_allies");
    var0.to_blitz_spawns["allies"] = scripts\mp\spawnlogic::getspawnpointarray("mp_front_spawn_allies");
  }

  if(var0.to_blitz_spawns["axis"].size <= 0) {
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_front_spawn_axis");
    var0.to_blitz_spawns["axis"] = scripts\mp\spawnlogic::getspawnpointarray("mp_front_spawn_axis");
    return;
  }
}

function getspawnpoint() {
  var0 = level.tacopsspawns;
  var1 = self.pers["team"];
  var2 = scripts\mp\tac_ops_map::filterspawnpoints(var0.to_blitz_spawns[var1]);
  var3 = undefined;
  return var3;
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

function onnormaldeath(var0, var1, var2, var3, var4) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var0, var1, var2, var3, var4);
}

function onspawnplayer() {
  if(self.team == "axis") {
    thread onspawnfinished();
  }

  var0 = 0;

  if(self.team == "allies") {
    var0 = 1;
  } else if(self.team == "axis") {
    var0 = 2;
  }

  self setclientomnvar("ui_tacops_team", var0);
  scripts\mp\tac_ops\roles_utility::kitspawn();
}

function onspawnfinished() {
  self endon("death_or_disconnect");
  self waittill("giveLoadout");
  scripts\mp\equipment::giveequipment("equip_c4", "primary");
  var0 = self getweaponslist("primary");

  foreach(var2 in var0) {
    var3 = getweaponbasename(var2);

    switch (var3) {
      case "iw8_la_lapha_mp":
      case "iw8_la_juliet_mp":
      case "iw8_la_rpapa7_mp":
      case "iw8_la_t9freefire_mp":
        var4 = getcompleteweaponname("iw8_pi_usierra45_mp");
        scripts\cp_mp\utility\inventory_utility::takeweaponwhensafe(var2);
        self giveweapon(var4);
        self givestartammo(var4);
        break;
    }
  }
}

function setuprpgcaches() {
  level.rpg7caches = [];
  var0 = getEntArray("rpg_cache", "targetname");
  var1 = getEntArray("rpg_use_trigger", "targetname");

  for(var2 = 0; var2 < var0.size; var2++) {
    var3 = spawn("script_model", var0[var2].origin);
    var3 setModel("care_package_iw7_dummy");
    var3.angles = var0[var2].angles;
    var0[var2] scripts\mp\utility\outline::outlineenableforteam(var0[var2], "axis", "outline_nodepth_cyan", "lowest");
    var0[var2].ownerteam = "axis";
    var0[var2].interactteam = "friendly";
    var0[var2].exclusiveuse = 0;
    var0[var2].curprogress = 0;
    var0[var2].usetime = 0;
    var0[var2].userate = 1;
    var0[var2].id = "care_package";
    var0[var2].skiptouching = 1;
    var0[var2].trigger = var1[var2];
    var0[var2].trigger.angles = var0[var2].angles;
    var0[var2].trigger setCursorHint("HINT_NOICON");
    var0[var2].trigger setHintString(&"MP/PICKUP_RPG7");
    var0[var2].trigger.team = "axis";
    var0[var2].trigger.destination = var0[var2].origin;
    var0[var2].onuse = &rpgcrateenduse;
    var0[var2] thread scripts\mp\gameobjects::useobjectusethink();
    thread rpgcrateuseteamupdater(var0[var2]);
    level.rpg7caches[level.rpg7caches.size] = var0[var2];
  }
}

function rpgcrateenduse(var0) {
  var0 setclientomnvar("ui_securing", 0);
  var0 setclientomnvar("ui_securing_progress", 0.01);
  var1 = var0.lastdroppableweaponobj;
  var2 = var0 dropitem(var1);

  if(isDefined(var2)) {
    var2.owner = var0;
    var2.targetname = "dropped_weapon";
    var2 thread scripts\mp\weapons::watchpickup(var0);
    var2 thread scripts\mp\weapons::deletepickupafterawhile();
  }

  var0 giveweapon("iw8_la_rpapa7_mp");
  var0 givestartammo("iw8_la_rpapa7_mp");
  var0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch("iw8_la_rpapa7_mp", 1);
  var0 scripts\mp\weapons::ref_1316b(getcompleteweaponname("iw8_la_rpapa7_mp"));
}

function rpgcrateuseteamupdater(var0) {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    setusablebyteam(var0);
    level waittill("joined_team");
  }
}

function setusablebyteam(var0) {
  foreach(var2 in level.players) {
    if(var2.team != var0) {
      self.trigger disableplayeruse(var2);
      continue;
    }

    self.trigger enableplayeruse(var2);
  }
}

function initobjicons() {
  foreach(var1 in level.bradley.activevehicles["allies"]) {
    var1.trackedobject = var1 scripts\mp\gameobjects::createtrackedobject(var1, (0, 0, 0));
    var1.trackedobject.objidpingfriendly = 0;
    var1.trackedobject.objidpingenemy = 1;
    var1.trackedobject.objpingdelay = 0.05;
    var1.trackedobject.visibleteam = "any";
    var1.invulnerable = 1;
    var1.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.icontake, level.iconkill);
    thread watchiconupdater();
  }
}

function watchiconupdater() {
  level endon("game_ended");

  for(;;) {
    scripts\engine\utility::ref_143a6("bradley_driverUpdate", "death", "bradley_vehicleExit");
    var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "driver");

    if(isDefined(var0) && isDefined(self.trackedobject.visibleteam)) {
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
  var0 = getEntArray("barrier_checkpoint", "targetname");

  foreach(var2 in var0) {
    var2 setCanDamage(1);
    var2.health = 10000;
    var2.team = "axis";
    thread barriermonitordamage();
    thread barriermonitordeath();
  }

  level.totalbarriers = var0.size;
}

function barriermonitordamage() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("damage", var0);
    iprintln("Wall hit for " + var0 + ", health left " + self.health);
  }
}

function barriermonitordeath() {
  level endon("game_ended");
  self waittill("death");
  iprintln("Wall DEAD");
  thread barrier_destroy();
}

function barrier_deathfunc(var0, var1, var2, var3, var4) {
  if(level.teambased) {
    var5 = "";

    if(isDefined(var0) && isDefined(var0.team)) {
      var5 = var0.team;
    }

    if(var5 != self.team) {}
  } else if(isDefined(var0) && (!isDefined(self.owner) || self.owner != var0)) {}

  thread barrier_destroy(var0, var1, var2, 0);
}

function barrier_destroy(var0, var1, var2, var3) {
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

function barrier_dmgfunc(var0, var1, var2, var3, var4) {
  if(var2 == "MOD_MELEE") {
    return 0;
  }

  if(var0.team == self.team) {
    return 0;
  }

  var3 = getmodifiedbarrierdamage(var0, var1, var2, var3, 10000, 10, 15, 50);
  return var3;
}

function getmodifiedbarrierdamage(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var9 = var1.isalternate;
  var10 = 0;

  if(istrue(var9)) {
    var11 = scripts\mp\utility\weapon::getweaponattachmentsbasenames(var1);

    foreach(var13 in var11) {
      if(var13 == "gl") {
        var10 = 1;
        break;
      }
    }
  }

  var15 = undefined;

  if(var2 != "MOD_MELEE") {
    switch (var1.basename) {
      case "iw8_la_lapha_mp":
      case "c4_mp_p":
      case "iw8_la_juliet_mp":
      case "iw8_la_rpapa7_mp":
      case "iw8_la_t9freefire_mp":
        self.largeprojectiledamage = 1;
        var15 = var5;
        break;
      case "switch_blade_child_mp":
      case "drone_hive_projectile_mp":
      case "tur_bradley_mp":
        self.largeprojectiledamage = 1;
        var15 = var6;
        break;
      case "jackal_cannon_mp":
      case "lighttank_mp":
      case "artillery_mp":
        self.largeprojectiledamage = 0;
        var15 = var7;
        break;
      case "iw7_arclassic_mp":
        if(istrue(var10)) {
          self.largeprojectiledamage = 0;
          var15 = var7;
        }

        break;
      default:
        var3 = 0;
        break;
    }
  }

  if(isDefined(var8)) {
    self.largeprojectiledamage = var8;
  }

  if(isDefined(var15) && isDefined(var2) && (var2 == "MOD_EXPLOSIVE" || var2 == "MOD_EXPLOSIVE_BULLET" || var2 == "MOD_PROJECTILE" || var2 == "MOD_PROJECTILE_SPLASH" || var2 == "MOD_GRENADE")) {
    var3 = ceil(var4 / var15);
  }

  if(isDefined(var0) && isDefined(self.owner)) {
    if(isDefined(var0.owner)) {
      var0 = var0.owner;
    }

    if(var0 == self.owner) {
      var3 = ceil(var3 / 2);
    }
  }

  return int(var3);
}

function ontimelimit() {
  if(isDefined(level.onphaseend)) {
    var0 = scripts\mp\gamescore::freight_lift_door_switch(0);
    [[level.onphaseend]](var0);
  }

  scripts\mp\gamescore::_setteamscore("axis", 1, 0);
  thread scripts\mp\gamelogic::endgame("axis", game["end_reason"]["objective_completed"]);
}

function spawnmanualdomflag() {
  level.flagcapturetime = 1;
  level.flagneutralization = 1;
  var0 = spawnStruct();
  var0.origin = (7524, 11709, 308);
  var0.angles = (0, 0, 0);
  var1 = spawn("trigger_radius", var0.origin, 0, 160, 128);
  var1.radius = 160;
  var0.trigger = var1;
  var0.trigger.script_label = "";
  var0.ownerteam = "neutral";
  var2 = var0.origin + (0, 0, 32);
  var3 = var0.origin + (0, 0, -32);
  var4 = scripts\engine\trace::ray_trace(var2, var3, undefined, scripts\engine\trace::create_default_contents(1));
  var0.origin = var4["position"];
  var0.upangles = vectortoangles(var4["normal"]);
  var0.forward = anglesToForward(var0.upangles);
  var0.right = anglestoright(var0.upangles);
  var0.visuals[0] = spawn("script_model", var0.origin);
  var0.visuals[0].angles = var0.angles;
  var5 = scripts\mp\gameobjects::createuseobject("neutral", var0.trigger, var0.visuals, (0, 0, 100));
  var5 scripts\mp\gameobjects::allowuse("enemy");
  var5 scripts\mp\gameobjects::setusetime(1);
  var5 scripts\mp\gameobjects::setusetext(&"MP/SECURING_POSITION");
  var6 = "";
  var5.label = var6;
  var5 scripts\mp\gameobjects::setobjectivestatusicons(level.iconfriendlyextract3d, level.icondefend);
  var5 scripts\mp\gameobjects::setvisibleteam("any");
  var5.onuse = &dompoint_onuse;
  var5.onbeginuse = &scripts\mp\gametypes\obj_dom::dompoint_onusebegin;
  var5.onuseupdate = &scripts\mp\gametypes\obj_dom::dompoint_onuseupdate;
  var5.onenduse = &scripts\mp\gametypes\obj_dom::dompoint_onuseend;
  var5.oncontested = &scripts\mp\gametypes\obj_dom::dompoint_oncontested;
  var5.onuncontested = &scripts\mp\gametypes\obj_dom::dompoint_onuncontested;
  var5.nousebar = 1;
  var5.id = "domFlag";
  var5.claimgracetime = level.flagcapturetime * 1000;
  var5.firstcapture = 1;
  var5 scripts\mp\gameobjects::setkeyobject(level.tankobjkeys);
  var5.nocarryobject = 1;
  level.objectives = [];
  level.objectives[0] = var5;
  var2 = var0.visuals[0].origin + (0, 0, 32);
  var3 = var0.visuals[0].origin + (0, 0, -32);
  var7 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var8 = [];
  var4 = scripts\engine\trace::ray_trace(var2, var3, var8, var7);
  var5.baseeffectpos = var4["position"];
  var9 = vectortoangles(var4["normal"]);
  var5.baseeffectforward = anglesToForward(var9);
  var10 = spawn("script_model", var5.baseeffectpos);
  var10 setModel("dom_flag_scriptable");
  var10.angles = generateaxisanglesfromforwardvector(var5.baseeffectforward, var10.angles);
  var5.scriptable = var10;
  var5.vfxnamemod = "";

  if(var5.trigger.radius == 160) {
    var5.vfxnamemod = "_160";
  } else if(var5.trigger.radius == 90) {
    var5.vfxnamemod = "_90";
  } else if(var5.trigger.radius == 315) {
    var5.vfxnamemod = "_300";
  }

  var5 scripts\mp\gameobjects::setownerteam("axis");
  var5 scripts\mp\gameobjects::setvisibleteam("any");
  var5 scripts\mp\gameobjects::allowuse("enemy");
  var5 scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
  var5 scripts\mp\gametypes\obj_dom::updateflagstate("axis", 0);
}

function dompoint_onuse(var0) {
  scripts\mp\gametypes\obj_dom::dompoint_onuse(var0);

  if(var0.team == "allies") {
    scripts\mp\gamescore::_setteamscore("allies", 1, 0);
    thread scripts\mp\gamelogic::endgame("allies", game["end_reason"]["objective_completed"]);
    return;
  }
}
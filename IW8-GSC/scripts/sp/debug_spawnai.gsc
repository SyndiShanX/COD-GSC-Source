/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\debug_spawnai.gsc
***********************************************/

function spawn_ai_mode() {}

function init_spawners() {
  var0 = level.debug.spawnaimode;
  var0.realspawners = [];
  var0.listaitypes = [];
  var1 = [];
  var2 = getspawnerarray();

  foreach(var4 in var2) {
    if(!isDefined(var0.realspawners[var4.classname])) {
      var0.realspawners[var4.classname] = var4;
      var0.listaitypes[var0.listaitypes.size] = var4.classname;
    }
  }

  var0.listaitypes = scripts\engine\utility::alphabetize(var0.listaitypes);
}

function input() {
  var0 = undefined;
  var1 = level.debug.spawnaimode;
  updategameon();

  if(var1.gameon) {
    return;
  }

  if(var1.selectedaitype == "undefined" && isDefined(level.debug.spawnaimode.heldspawner)) {
    clear_heldspawner();
  }

  foreach(var3 in var1.placedspawners) {
    if(distancesquared(var3.origin, level.debug.cursor_pos) < 2304) {
      var0 = var3;
      break;
    }
  }

  if(isDefined(var0)) {
    clear_heldspawner();
    highlightent(var0);
  }

  if(!canpressuse()) {
    return;
  }

  if(!isDefined(var0)) {
    if(isDefined(var1.selectedents)) {} else {
      unhighlightent();
    }
  }

  if(isDefined(var1.highlightent)) {
    if(level.player useButtonPressed()) {
      var5 = undefined;

      if(isDefined(var1.selectedents)) {
        foreach(var7 in var1.selectedents) {
          if(var7 == var1.highlightent) {
            var5 = var7;
            break;
          }
        }
      }

      if(isDefined(var5)) {
        removeselected(var5);
      } else {
        addselected(var1.highlightent);
      }

      delayusetime();
      return;
    }

    if(level.player buttonPressed("del")) {
      var2.placedspawners = scripts\engine\utility::array_remove(var2.placedspawners, var2.highlightent);
      var2.highlightent delete();
      return;
    }

    return;
  }
}

function gameon_toggle() {
  updategameon(1);
  return level.debug.spawnaimode.gameon;
}

function updategameon(var0) {
  if(!canpressuse()) {
    return;
  }

  if(level.player meleeButtonPressed() || isDefined(var0)) {
    level.debug.spawnaimode.gameon = !level.debug.spawnaimode.gameon;

    if(level.debug.spawnaimode.gameon) {
      thread gameon_thread();
    } else {
      gameoff();
    }

    delayusetime();
    return;
  }
}

function canpressuse() {
  return gettime() > level.debug.spawnaimode.nextusepress;
}

function delayusetime() {
  level.debug.spawnaimode.nextusepress = gettime() + 400;
}

function assigngoalpos(var0, var1) {
  self.spawnai_goalpos = var0;
  self.spawnai_goalradius = var1;
  thread drawassignedgoalpos();
}

function drawassignedgoalpos() {
  self endon("death");
  self endon("selected");
  level endon("gameOn");

  for(;;) {
    waitframe();
    drawgoalpos(self.spawnai_goalpos, self.spawnai_goalradius);
  }
}

function highlightent(var0) {
  if(isDefined(level.debug.spawnaimode.highlightent) && level.debug.spawnaimode.highlightent == var0) {
    return;
  }

  unhighlightent();
  var0 hudoutlineenable("outline_nodepth_orange");
  level.debug.spawnaimode.highlightent = var0;
}

function unhighlightent() {
  if(!isDefined(level.debug.spawnaimode.highlightent)) {
    return;
  }

  level.debug.spawnaimode.highlightent hudoutlinedisable();
  level.debug.spawnaimode.highlightent = undefined;
}

function addselected(var0) {
  if(!isDefined(level.debug.spawnaimode.selectedents)) {
    level.debug.spawnaimode.selectedents = [];
  }

  level.debug.spawnaimode.selectedents[level.debug.spawnaimode.selectedents.size] = var0;
  var0 hudoutlineenable("outline_nodepth_cyan");
  var0 notify("selected");
  level.debug.spawnaimode.highlightent = undefined;
}

function removeselected(var0) {
  level.debug.spawnaimode.selectedents = scripts\engine\utility::array_remove(level.debug.spawnaimode.selectedents, var0);
  var0 hudoutlinedisable();

  if(level.debug.spawnaimode.selectedents.size == 0) {
    level.debug.spawnaimode.selectedents = undefined;
    return;
  }
}

function drawgoalpos(var0, var1) {
  var2 = (1, 1, 1);
}

function createspawner() {
  var0 = level.debug.spawnaimode;
  var1 = get_spawner(var0.selectedaitype);
  var2 = scripts\engine\sp\utility::dronespawn_bodyonly(var1);
  var2.aitype = var1.classname;
  var2.pathpoints = [];
  return var2;
}

function get_spawner(var0) {
  return level.debug.spawnaimode.realspawners[var0];
}

function spawnguy() {
  var0 = level.debug.spawnaimode;
  var1 = var0.realspawners[randomint(var0.realspawners.size)];

  for(;;) {
    var1.count += 1;
    var2 = var1.origin;
    var1.origin = level.debug.cursor_pos;
    stripspawner(var1);
    var3 = var1 scripts\engine\sp\utility::spawn_ai(1);
    restorespawner(var1);
    var1.origin = var2;

    if(!scripts\common\ai::spawn_failed(var3)) {
      var3.ignoreme = 1;
      var3.ignoreall = 1;
      var3 clearenemy();
      var3.spawnai_realspawner = var1;
      break;
    }
  }

  var3.spawnai_linkent = scripts\engine\utility::spawn_tag_origin(var3.origin);
  var3 linkTo(var3.spawnai_linkent);
  return var3;
}

function tryplacespawner() {
  var0 = (0, 0, 0);
  var1 = level.debug.spawnaimode;

  if(var1.mode != "default") {
    return;
  }

  clear_heldspawner();
  var1.heldspawner = createspawner();
  thread heldspawner_think();
}

function heldspawner_think() {
  self endon("death");
  var0 = level.debug.spawnaimode;

  for(;;) {
    self.origin = level.debug.cursor_pos;

    if(canpressuse() && level.player useButtonPressed()) {
      if(getaicount() > 32) {
        var0.placedspawners[0].guy delete();
        var0.placedspawners = scripts\engine\utility::array_remove_index(var0.placedspawners, 0);
      }

      var0.placedspawners[var0.placedspawners.size] = self;
      var0.highlightent = self;
      var0.heldspawner = undefined;
      thread edit_spawner();
      delayusetime();
      break;
    }

    waitframe();
  }
}

function clear_aitype() {
  clear_heldspawner();
  level.debug.spawnaimode.selectedaitype = "undefined";
  return "undefined";
}

function clear_heldspawner() {
  if(isDefined(level.debug.spawnaimode.heldspawner)) {
    level.debug.spawnaimode.heldspawner delete();
    return;
  }
}

function set_mode(var0) {
  level.debug.spawnaimode.mode = var0;
}

function gameon_thread() {
  var0 = level.debug.spawnaimode;
  var1 = 3;
  var2 = gettime() + var1 * 1000;
  setDvar("scr_debug_spawnAIModeGameON", 1);
  var3 = newhudelem();
  var3.x = 320;
  var3.y = 100;
  var3.alignx = "center";
  var3.vertalign = "fullscreen";
  var3.horzalign = "fullscreen";
  var3 setvalue(var1);
  var3.fontscale = 1.5;

  while(getdvarint("scr_debug_spawnAIModeGameON") == 1) {
    if(!var0.gamestarted) {
      var4 = (var2 - gettime()) * 0.001;
      var4 = int(var4 / 0.1) * 0.1;

      if(var4 <= 0) {
        var3 settext("GAME ON!");
        var0.gamestarted = 1;

        if(isDefined(var3)) {
          var3 scripts\engine\utility::delaycall(1, &destroy);
        }

        gameon();
      } else {
        var3 setvalue(var4);
      }
    }

    waitframe();
  }

  if(isDefined(var3)) {
    var3 scripts\engine\utility::delaycall(0.5, &destroy);
  }

  var0.gamestarted = 0;
}

function gameoff() {
  setDvar("scr_debug_spawnAIModeGameON", 0);

  foreach(var1 in level.debug.spawnaimode.placedspawners) {
    if(isalive(var1.guy)) {
      var1.guy delete();
    }

    var1 show();
  }
}

function gameon() {
  foreach(var1 in level.debug.spawnaimode.placedspawners) {
    var1 hide();
    var2 = havemapentseffects(var1.aitype, var1.origin, var1.angles, 1);

    if(isDefined(var2)) {
      var2.pathpoints = var1.pathpoints;
      var1.guy = var2;
      thread guy_think();
    }
  }
}

function guy_think() {
  self endon("death");

  foreach(var1 in self.pathpoints) {
    scripts\sp\spawner::go_to_node(var1);
  }
}

function menu_default() {
  var0 = level.debug.spawnaimode;
  var1 = "spawnai_main";
  scripts\sp\debug_menu::add_menu(var1, "Main");
  scripts\sp\debug_menu::add_menuoptions(var1, "Game On", &gameon_toggle, undefined, getdvarint("scr_debug_spawnAIModeGameON"));
  scripts\sp\debug_menu::add_menuoptions(var1, "Place Spawner", &pick_aitype, &clear_aitype, var0.selectedaitype);
  scripts\sp\debug_menu::add_menuoptions(var1, "Edit Spawner", &edit_spawner);
  scripts\sp\debug_menu::enable_menu(var1);
}

function pick_aitype() {
  var0 = scripts\sp\debug_menu::menu_get_selected_optionsvalue();
  var1 = level.debug.spawnaimode;

  if(var1.selectedaitype == "undefined") {
    var2 = 12 * (var1.selectedaitype.size + 1);
  } else {
    var2 = 12 * (var2.selectedaitype.size - 7);
  }

  var3 = scripts\sp\debug_menu::list_menu(var2.listaitypes, var1.x + var2, var1.y);

  if(!isDefined(var3)) {
    return undefined;
  }

  var2.selectedaitype = var2.listaitypes[var3];
  tryplacespawner();
  return getsubstr(var2.selectedaitype, 6);
}

function edit_spawner() {
  var0 = scripts\sp\debug_menu::get_current_menu_name();
  clear_aitype();

  if(!isDefined(level.debug.spawnaimode.highlightent) || !isDefined(level.debug.spawnaimode.highlightent.aitype)) {
    return;
  }

  set_mode("edit_spawner");
  scripts\sp\debug_menu::disable_menu("current_menu");
  var1 = "spawnai_editspawner";

  if(scripts\sp\debug_menu::menu_exists(var1)) {
    scripts\sp\debug_menu::destroy_menu(var1);
  }

  scripts\sp\debug_menu::add_menu(var1, "Edit Spawner");
  scripts\sp\debug_menu::add_menuoptions(var1, "Add Path Points", &add_pathpoints);
  scripts\sp\debug_menu::add_menuoptions(var1, "Goal Radius", &menu_goalradius_inc, &menu_goalradius_dec, level.debug.spawnaimode.goalradius);
  scripts\sp\debug_menu::add_menuoptions(var1, "Clear Path Points", &clear_pathpoints);
  scripts\sp\debug_menu::add_menuoptions(var1, "Exit", &scripts\sp\debug_menu::exit_menu);
  scripts\sp\debug_menu::add_menuent(var1, level.debug.spawnaimode.highlightent);
  scripts\sp\debug_menu::enable_menu(var1);
  thread edit_spawner_exit(level);
}

function edit_spawner_exit(var0) {
  var1 = level.debug.spawnaimode.highlightent;

  for(;;) {
    draw_spawner_edit_path(var1);

    if(scripts\sp\debug_menu::can_exit()) {
      break;
    }

    waitframe();
  }

  scripts\sp\debug_menu::disable_menu("current_menu");
  set_mode("default");

  if(isDefined(var0)) {
    scripts\sp\debug_menu::enable_menu(var0);
    return;
  }
}

function menu_goalradius_inc() {
  level.debug.spawnaimode.goalradius += 2;
  level.debug.spawnaimode.goalradius = min(level.debug.spawnaimode.goalradius, 2048);
  return level.debug.spawnaimode.goalradius;
}

function menu_goalradius_dec() {
  level.debug.spawnaimode.goalradius -= 2;
  level.debug.spawnaimode.goalradius = max(level.debug.spawnaimode.goalradius, 4);
  return level.debug.spawnaimode.goalradius;
}

function draw_spawner_edit_path() {
  var0 = self;

  foreach(var2 in self.pathpoints) {
    var0 = var2;
  }
}

function add_pathpoints() {
  if(!isDefined(self.pathpoints)) {
    self.pathpoints = [];
  }

  var0 = spawnStruct();
  var0.origin = level.debug.cursor_pos;
  var0.angles = (0, 0, 0);
  var0.radius = level.debug.spawnaimode.goalradius;

  foreach(var2 in self.pathpoints) {
    if(distancesquared(var2.origin, var0.origin) < 16) {
      return;
    }
  }

  self.pathpoints[self.pathpoints.size] = var0;
}

function clear_pathpoints() {
  self.pathpoints = [];
}

function stripspawner() {
  if(isDefined(self.target)) {
    self.og_target = self.target;
    self.target = undefined;
  }

  if(isDefined(self.script_dontshootwhilemoving)) {
    self.og_script_dontshootwhilemoving = self.script_dontshootwhilemoving;
    self.script_dontshootwhilemoving = undefined;
  }

  if(isDefined(self.script_deathflag)) {
    self.og_script_deathflag = self.script_deathflag;
    self.script_deathflag = undefined;
  }

  if(isDefined(self.script_attackeraccuracy)) {
    self.og_script_attackeraccuracy = self.script_attackeraccuracy;
    self.script_attackeraccuracy = undefined;
  }

  if(isDefined(self.script_startrunning)) {
    self.og_script_startrunning = self.script_startrunning;
    self.script_startrunning = undefined;
  }

  if(isDefined(self.script_deathtime)) {
    self.og_script_deathtime = self.script_deathtime;
    self.script_deathtime = undefined;
  }

  if(isDefined(self.script_nosurprise)) {
    self.og_script_nosurprise = self.script_nosurprise;
    self.script_nosurprise = undefined;
  }

  if(isDefined(self.script_nobloodpool)) {
    self.og_script_nobloodpool = self.script_nobloodpool;
    self.script_nobloodpool = undefined;
  }

  if(isDefined(self.script_animname)) {
    self.og_script_animname = self.script_animname;
    self.script_animname = undefined;
  }

  if(isDefined(self.script_laser)) {
    self.og_script_laser = self.script_laser;
    self.script_laser = undefined;
  }

  if(isDefined(self.script_danger_react)) {
    self.og_script_danger_react = self.script_danger_react;
    self.script_danger_react = undefined;
  }

  if(isDefined(self.script_faceenemydist)) {
    self.og_script_faceenemydist = self.script_faceenemydist;
    self.script_faceenemydist = undefined;
  }

  if(isDefined(self.script_forcecolor)) {
    self.og_script_forcecolor = self.script_forcecolor;
    self.script_forcecolor = undefined;
  }

  if(isDefined(self.dontdropweapon)) {
    self.og_dontdropweapon = self.dontdropweapon;
    self.dontdropweapon = undefined;
  }

  if(isDefined(self.script_fixednode)) {
    self.og_script_fixednode = self.script_fixednode;
    self.script_fixednode = undefined;
  }

  if(isDefined(self.script_no_reorient)) {
    self.og_script_no_reorient = self.script_no_reorient;
    self.script_no_reorient = undefined;
  }

  if(isDefined(self.script_goalvolume)) {
    self.og_script_no_reorient = self.script_no_reorient;
    self.script_no_reorient = undefined;
  }

  if(isDefined(self.script_stealthgroup)) {
    self.og_script_stealthgroup = self.script_stealthgroup;
    self.script_stealthgroup = undefined;
  }

  if(isDefined(self.script_threatbiasgroup)) {
    self.og_script_threatbiasgroup = self.script_threatbiasgroup;
    self.script_threatbiasgroup = undefined;
  }

  if(isDefined(self.script_bcdialog)) {
    self.og_script_bcdialog = self.script_bcdialog;
    self.script_bcdialog = undefined;
  }

  if(isDefined(self.script_accuracy)) {
    self.og_script_accuracy = self.script_accuracy;
    self.script_accuracy = undefined;
  }

  if(isDefined(self.script_ignoreme)) {
    self.og_script_ignoreme = self.script_ignoreme;
    self.script_ignoreme = undefined;
  }

  if(isDefined(self.script_ignore_suppression)) {
    self.og_script_ignore_suppression = self.script_ignore_suppression;
    self.script_ignore_suppression = undefined;
  }

  if(isDefined(self.script_ignoreall)) {
    self.og_script_ignoreall = self.script_ignoreall;
    self.script_ignoreall = undefined;
  }

  if(isDefined(self.script_no_seeker)) {
    self.og_script_no_seeker = self.script_no_seeker;
    self.script_no_seeker = undefined;
  }

  if(isDefined(self.script_offhands)) {
    self.og_script_offhands = self.script_offhands;
    self.script_offhands = undefined;
  }

  if(isDefined(self.script_favoriteenemy)) {
    self.og_script_favoriteenemy = self.script_favoriteenemy;
    self.script_favoriteenemy = undefined;
  }

  if(isDefined(self.script_sightrange)) {
    self.og_script_sightrange = self.script_sightrange;
    self.script_sightrange = undefined;
  }

  if(isDefined(self.script_fightdist)) {
    self.og_script_fightdist = self.script_fightdist;
    self.script_fightdist = undefined;
  }

  if(isDefined(self.script_maxdist)) {
    self.og_script_maxdist = self.script_maxdist;
    self.script_maxdist = undefined;
  }

  if(isDefined(self.script_longdeath)) {
    self.og_script_longdeath = self.script_longdeath;
    self.script_longdeath = undefined;
  }

  if(isDefined(self.script_diequietly)) {
    self.og_script_diequietly = self.script_diequietly;
    self.script_diequietly = undefined;
  }

  if(isDefined(self.script_noragdoll)) {
    self.og_script_noragdoll = self.script_noragdoll;
    self.script_noragdoll = undefined;
  }

  if(isDefined(self.script_pacifist)) {
    self.og_script_pacifist = self.script_pacifist;
    self.script_pacifist = undefined;
  }

  if(isDefined(self.script_bulletshield)) {
    self.og_script_bulletshield = self.script_bulletshield;
    self.script_bulletshield = undefined;
  }

  if(isDefined(self.script_startinghealth)) {
    self.og_script_startinghealth = self.script_startinghealth;
    self.script_startinghealth = undefined;
  }

  if(isDefined(self.script_nodrop)) {
    self.og_script_nodrop = self.script_nodrop;
    self.script_nodrop = undefined;
  }

  if(isDefined(self.script_demeanor)) {
    self.og_script_demeanor = self.script_demeanor;
    self.script_demeanor = undefined;
    return;
  }
}

function restorespawner() {
  if(isDefined(self.og_target)) {
    self.target = self.og_target;
    self.og_target = undefined;
  }

  if(isDefined(self.og_script_dontshootwhilemoving)) {
    self.script_dontshootwhilemoving = self.og_script_dontshootwhilemoving;
    self.og_script_dontshootwhilemoving = undefined;
  }

  if(isDefined(self.og_script_deathflag)) {
    self.script_deathflag = self.og_script_deathflag;
    self.og_script_deathflag = undefined;
  }

  if(isDefined(self.og_script_attackeraccuracy)) {
    self.script_attackeraccuracy = self.og_script_attackeraccuracy;
    self.og_script_attackeraccuracy = undefined;
  }

  if(isDefined(self.og_script_startrunning)) {
    self.script_startrunning = self.og_script_startrunning;
    self.og_script_startrunning = undefined;
  }

  if(isDefined(self.og_script_deathtime)) {
    self.script_deathtime = self.og_script_deathtime;
    self.og_script_deathtime = undefined;
  }

  if(isDefined(self.og_script_nosurprise)) {
    self.script_nosurprise = self.og_script_nosurprise;
    self.og_script_nosurprise = undefined;
  }

  if(isDefined(self.og_script_nobloodpool)) {
    self.script_nobloodpool = self.og_script_nobloodpool;
    self.og_script_nobloodpool = undefined;
  }

  if(isDefined(self.og_script_animname)) {
    self.script_animname = self.og_script_animname;
    self.og_script_animname = undefined;
  }

  if(isDefined(self.og_script_laser)) {
    self.script_laser = self.og_script_laser;
    self.og_script_laser = undefined;
  }

  if(isDefined(self.og_script_danger_react)) {
    self.script_danger_react = self.og_script_danger_react;
    self.og_script_danger_react = undefined;
  }

  if(isDefined(self.og_script_faceenemydist)) {
    self.script_faceenemydist = self.og_script_faceenemydist;
    self.og_script_faceenemydist = undefined;
  }

  if(isDefined(self.og_script_forcecolor)) {
    self.script_forcecolor = self.og_script_forcecolor;
    self.og_script_forcecolor = undefined;
  }

  if(isDefined(self.og_dontdropweapon)) {
    self.dontdropweapon = self.og_dontdropweapon;
    self.og_dontdropweapon = undefined;
  }

  if(isDefined(self.og_script_fixednode)) {
    self.script_fixednode = self.og_script_fixednode;
    self.og_script_fixednode = undefined;
  }

  if(isDefined(self.og_script_no_reorient)) {
    self.script_no_reorient = self.og_script_no_reorient;
    self.og_script_no_reorient = undefined;
  }

  if(isDefined(self.og_script_goalvolume)) {
    self.script_goalvolume = self.og_script_goalvolume;
    self.og_script_goalvolume = undefined;
  }

  if(isDefined(self.og_script_stealthgroup)) {
    self.script_stealthgroup = self.og_script_stealthgroup;
    self.og_script_stealthgroup = undefined;
  }

  if(isDefined(self.og_script_threatbiasgroup)) {
    self.script_threatbiasgroup = self.og_script_threatbiasgroup;
    self.og_script_threatbiasgroup = undefined;
  }

  if(isDefined(self.og_script_bcdialog)) {
    self.script_bcdialog = self.og_script_bcdialog;
    self.og_script_bcdialog = undefined;
  }

  if(isDefined(self.og_script_accuracy)) {
    self.script_accuracy = self.og_script_accuracy;
    self.og_script_accuracy = undefined;
  }

  if(isDefined(self.og_script_ignoreme)) {
    self.script_ignoreme = self.og_script_ignoreme;
    self.og_script_ignoreme = undefined;
  }

  if(isDefined(self.og_script_ignore_suppression)) {
    self.script_ignore_suppression = self.og_script_ignore_suppression;
    self.og_script_ignore_suppression = undefined;
  }

  if(isDefined(self.og_script_ignoreall)) {
    self.script_ignoreall = self.og_script_ignoreall;
    self.og_script_ignoreall = undefined;
  }

  if(isDefined(self.og_script_no_seeker)) {
    self.script_no_seeker = self.og_script_no_seeker;
    self.og_script_no_seeker = undefined;
  }

  if(isDefined(self.og_script_offhands)) {
    self.script_offhands = self.og_script_offhands;
    self.og_script_offhands = undefined;
  }

  if(isDefined(self.og_script_favoriteenemy)) {
    self.script_favoriteenemy = self.og_script_favoriteenemy;
    self.og_script_favoriteenemy = undefined;
  }

  if(isDefined(self.og_script_sightrange)) {
    self.script_sightrange = self.og_script_sightrange;
    self.og_script_sightrange = undefined;
  }

  if(isDefined(self.og_script_fightdist)) {
    self.script_fightdist = self.og_script_fightdist;
    self.og_script_fightdist = undefined;
  }

  if(isDefined(self.og_script_maxdist)) {
    self.script_maxdist = self.og_script_maxdist;
    self.og_script_maxdist = undefined;
  }

  if(isDefined(self.og_script_longdeath)) {
    self.script_longdeath = self.og_script_longdeath;
    self.og_script_longdeath = undefined;
  }

  if(isDefined(self.og_script_diequietly)) {
    self.script_diequietly = self.og_script_diequietly;
    self.og_script_diequietly = undefined;
  }

  if(isDefined(self.og_script_noragdoll)) {
    self.script_noragdoll = self.og_script_noragdoll;
    self.og_script_noragdoll = undefined;
  }

  if(isDefined(self.og_script_pacifist)) {
    self.script_pacifist = self.og_script_pacifist;
    self.og_script_pacifist = undefined;
  }

  if(isDefined(self.og_script_bulletshield)) {
    self.script_bulletshield = self.og_script_bulletshield;
    self.og_script_bulletshield = undefined;
  }

  if(isDefined(self.og_script_startinghealth)) {
    self.script_startinghealth = self.og_script_startinghealth;
    self.og_script_startinghealth = undefined;
  }

  if(isDefined(self.og_script_nodrop)) {
    self.script_nodrop = self.og_script_nodrop;
    self.og_script_nodrop = undefined;
  }

  if(isDefined(self.og_script_demeanor)) {
    self.script_demeanor = self.og_script_demeanor;
    self.og_script_demeanor = undefined;
    return;
  }
}

function get_colortable() {
  GscBinSkip1(0x45, "white", (0.996094, 0.996094, 0.996094));
}
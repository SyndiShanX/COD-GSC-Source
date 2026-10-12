/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\debug_spawnai.gsc
***********************************************/



#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\sp\utility_code;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\debug;
#using scripts\sp\debug_menu;
#using scripts\sp\spawner;
#using scripts\sp\utility;
#namespace debug_spawnai;

function spawn_ai_mode() {
  dvar = @ "hash_5d83147342337f0b";
  dvar_running = @ "hash_f6ac786807a5e9cb";
  setDvar(@ "hash_bb1a296df27c0f74", 0);
  spawners = getspawnerarray();

  if(spawners.size == 0) {
    println("<dev string:x1c>");
    return;
  }

  spawnaimode = spawnStruct();
  spawnaimode.nextusepress = 0;
  spawnaimode.gameon = 0;
  spawnaimode.gamestarted = 0;
  spawnaimode.placedspawners = [];
  spawnaimode.selectedaitype = "<dev string:x44>";
  spawnaimode.mode = "<dev string:x4e>";
  spawnaimode.storedweapons = scripts\sp\debug::take_weapons_away();

  if(level.start_point == "<dev string:x56>") {
    scripts\sp\spawner::main();
  }

  spawnaimode.goalradius = 64;
  level.debug.spawnaimode = spawnaimode;
  init_spawners();
  thread scripts\sp\debug::debug_cursor(1);
  setDvar(dvar_running, 1);
  init_menus();
  menu_default();

  while(getdvarint(dvar)) {
    input();
    waitframe();
  }

  scripts\sp\debug::give_weapons_back(spawnaimode.storedweapons);
  level.debug.spawnaimode = undefined;
  possible_menus = ["<dev string:x5e>"];

  foreach(menuname in possible_menus) {
    disable_menu("<dev string:x6b>");
    destroy_menu(menuname);
  }

  setDvar(dvar_running, 0);
  level notify("<dev string:x78>");
}

function init_spawners() {
  spawnaimode = level.debug.spawnaimode;
  spawnaimode.realspawners = [];
  spawnaimode.listaitypes = [];
  classnames = [];
  spawners = getspawnerarray();

  foreach(spawner in spawners) {
    if(!isDefined(spawnaimode.realspawners[spawner.classname])) {
      spawnaimode.realspawners[spawner.classname] = spawner;
      spawnaimode.listaitypes[spawnaimode.listaitypes.size] = spawner.classname;
    }
  }

  spawnaimode.listaitypes = alphabetize(spawnaimode.listaitypes);
}

function input() {
  closespawner = undefined;
  spawnaimode = level.debug.spawnaimode;
  updategameon();

  if(spawnaimode.gameon) {
    return;
  }

  if(spawnaimode.selectedaitype == "undefined" && isDefined(level.debug.spawnaimode.heldspawner)) {
    clear_heldspawner();
  }

  foreach(spawner in spawnaimode.placedspawners) {
    if(distancesquared(spawner.origin, level.debug.cursor_pos) < 2304) {
      closespawner = spawner;
      break;
    }
  }

  if(isDefined(closespawner)) {
    clear_heldspawner();
    highlightent(closespawner);
  }

  if(!canpressuse()) {
    return;
  }

  if(!isDefined(closespawner)) {
    if(isDefined(spawnaimode.selectedents)) {} else {
      unhighlightent();
    }
  }

  if(isDefined(spawnaimode.highlightent)) {
    if(level.player useButtonPressed()) {
      removeselected = undefined;

      if(isDefined(spawnaimode.selectedents)) {
        foreach(ent in spawnaimode.selectedents) {
          if(ent == spawnaimode.highlightent) {
            removeselected = ent;
            break;
          }
        }
      }

      if(isDefined(removeselected)) {
        removeselected(removeselected);
      } else {
        addselected(spawnaimode.highlightent);
      }

      delayusetime();
      return;
    }

    if(level.player buttonPressed("del")) {
      spawnaimode.placedspawners = array_remove(spawnaimode.placedspawners, spawnaimode.highlightent);
      spawnaimode.highlightent delete();
    }
  }
}

function gameon_toggle() {
  updategameon(1);
  return level.debug.spawnaimode.gameon;
}

function updategameon(toggle) {
  if(!canpressuse()) {
    return;
  }

  if(level.player meleeButtonPressed() || isDefined(toggle)) {
    level.debug.spawnaimode.gameon = !level.debug.spawnaimode.gameon;

    if(level.debug.spawnaimode.gameon) {
      thread gameon_thread();
    } else {
      gameoff();
    }

    delayusetime();
  }
}

function canpressuse() {
  return gettime() > level.debug.spawnaimode.nextusepress;
}

function delayusetime() {
  level.debug.spawnaimode.nextusepress = gettime() + 400;
}

function assigngoalpos(pos, radius) {
  self.spawnai_goalpos = pos;
  self.spawnai_goalradius = radius;
  thread drawassignedgoalpos();
}

function drawassignedgoalpos() {
  self endon("death");
  self endon("selected");
  level endon("gameOn");

  while(true) {
    waitframe();
    drawgoalpos(self.spawnai_goalpos, self.spawnai_goalradius);
  }
}

function highlightent(ent) {
  if(isDefined(level.debug.spawnaimode.highlightent) && level.debug.spawnaimode.highlightent == ent) {
    return;
  }

  unhighlightent();
  ent hudoutlineenable("outline_nodepth_orange");
  level.debug.spawnaimode.highlightent = ent;
}

function unhighlightent() {
  if(!isDefined(level.debug.spawnaimode.highlightent)) {
    return;
  }

  level.debug.spawnaimode.highlightent hudoutlinedisable();
  level.debug.spawnaimode.highlightent = undefined;
}

function addselected(ent) {
  if(!isDefined(level.debug.spawnaimode.selectedents)) {
    level.debug.spawnaimode.selectedents = [];
  }

  level.debug.spawnaimode.selectedents[level.debug.spawnaimode.selectedents.size] = ent;
  ent hudoutlineenable("outline_nodepth_cyan");
  ent notify("selected");
  level.debug.spawnaimode.highlightent = undefined;
}

function removeselected(ent) {
  level.debug.spawnaimode.selectedents = array_remove(level.debug.spawnaimode.selectedents, ent);
  ent hudoutlinedisable();

  if(level.debug.spawnaimode.selectedents.size == 0) {
    level.debug.spawnaimode.selectedents = undefined;
  }
}

function drawgoalpos(pos, radius) {
  color = (1, 1, 1);
  line(self.origin, pos, color);
  cylinder(pos, pos + (0, 0, 0.0001), radius, color);
}

function createspawner() {
  spawnaimode = level.debug.spawnaimode;
  spawner = get_spawner(spawnaimode.selectedaitype);
  ent = dronespawn_bodyonly(spawner);
  ent.aitype = spawner.classname;
  ent.pathpoints = [];
  return ent;
}

function get_spawner(classname) {
  return level.debug.spawnaimode.realspawners[classname];
}

function spawnguy() {
  spawnaimode = level.debug.spawnaimode;
  spawner = spawnaimode.realspawners[randomint(spawnaimode.realspawners.size)];

  while(true) {
    spawner.count += 1;
    og_origin = spawner.origin;
    spawner.origin = level.debug.cursor_pos;
    spawner stripspawner();
    guy = spawner spawn_ai(1);
    spawner restorespawner();
    spawner.origin = og_origin;

    if(!spawn_failed(guy)) {
      guy.ignoreme = 1;
      guy.ignoreall = 1;
      guy clearenemy();
      guy.spawnai_realspawner = spawner;
      break;
    }
  }

  guy.spawnai_linkent = spawn_tag_origin(guy.origin);
  guy linkTo(guy.spawnai_linkent);
  return guy;
}

function tryplacespawner() {
  angles = (0, 0, 0);
  spawnaimode = level.debug.spawnaimode;

  if(spawnaimode.mode != "default") {
    return;
  }

  clear_heldspawner();
  spawnaimode.heldspawner = createspawner();
  spawnaimode.heldspawner thread heldspawner_think();
}

function heldspawner_think() {
  self endon("death");
  spawnaimode = level.debug.spawnaimode;

  while(true) {
    self.origin = level.debug.cursor_pos;

    if(canpressuse() && level.player useButtonPressed()) {
      if(getaicount() > 32) {
        spawnaimode.placedspawners[0].guy delete();
        spawnaimode.placedspawners = array_remove_index(spawnaimode.placedspawners, 0);
      }

      spawnaimode.placedspawners[spawnaimode.placedspawners.size] = self;
      spawnaimode.highlightent = self;
      spawnaimode.heldspawner = undefined;
      level thread edit_spawner();
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
  }
}

function set_mode(mode) {
  level.debug.spawnaimode.mode = mode;
}

function gameon_thread() {
  spawnaimode = level.debug.spawnaimode;
  duration = 3;
  endtime = gettime() + duration * 1000;
  setDvar(@ "hash_bb1a296df27c0f74", 1);
  hud = newhudelem();
  hud.x = 320;
  hud.y = 100;
  hud.alignx = "center";
  hud.vertalign = "fullscreen";
  hud.horzalign = "fullscreen";
  hud setvalue(duration);
  hud.fontscale = 1.5;

  while(getdvarint(@ "hash_bb1a296df27c0f74") == 1) {
    if(!spawnaimode.gamestarted) {
      time = (endtime - gettime()) * 0.001;
      time = int(time / 0.1) * 0.1;

      if(time <= 0) {
        hud settext("GAME ON!");
        spawnaimode.gamestarted = 1;

        if(isDefined(hud)) {
          hud delaycall(1, &destroy);
        }

        gameon();
      } else {
        hud setvalue(time);
      }
    }

    waitframe();
  }

  if(isDefined(hud)) {
    hud delaycall(0.5, &destroy);
  }

  spawnaimode.gamestarted = 0;
}

function gameoff() {
  setDvar(@ "hash_bb1a296df27c0f74", 0);

  foreach(spawner in level.debug.spawnaimode.placedspawners) {
    if(isalive(spawner.guy)) {
      spawner.guy delete();
    }

    spawner show();
  }
}

function gameon() {
  foreach(spawner in level.debug.spawnaimode.placedspawners) {
    spawner hide();
    guy = dospawnaitype(spawner.aitype, spawner.origin, spawner.angles, 1);

    if(isDefined(guy)) {
      guy.pathpoints = spawner.pathpoints;
      spawner.guy = guy;
      guy thread guy_think();
    }
  }
}

function guy_think() {
  self endon("death");

  foreach(point in self.pathpoints) {
    scripts\sp\spawner::go_to_node(point);
  }
}

function menu_default() {
  spawnaimode = level.debug.spawnaimode;
  menu = "spawnai_main";
  add_menu(menu, "Main");
  add_menuoptions(menu, "Game On", &gameon_toggle, undefined, getdvarint(@ "hash_bb1a296df27c0f74"));
  add_menuoptions(menu, "Place Spawner", &pick_aitype, &clear_aitype, spawnaimode.selectedaitype);
  add_menuoptions(menu, "Edit Spawner", &edit_spawner);
  enable_menu(menu);
}

function pick_aitype() {
  hud = menu_get_selected_optionsvalue();
  spawnaimode = level.debug.spawnaimode;

  if(spawnaimode.selectedaitype == "undefined") {
    x_add = 12 * (spawnaimode.selectedaitype.size + 1);
  } else {
    x_add = 12 * (spawnaimode.selectedaitype.size - 7);
  }

  num = list_menu(spawnaimode.listaitypes, hud.x + x_add, hud.y);

  if(!isDefined(num)) {
    return undefined;
  }

  spawnaimode.selectedaitype = spawnaimode.listaitypes[num];
  tryplacespawner();
  return getsubstr(spawnaimode.selectedaitype, 6);
}

function edit_spawner() {
  prev_menu = get_current_menu_name();
  clear_aitype();

  if(!isDefined(level.debug.spawnaimode.highlightent) || !isDefined(level.debug.spawnaimode.highlightent.aitype)) {
    return;
  }

  set_mode("edit_spawner");
  disable_menu("current_menu");
  menu = "spawnai_editspawner";

  if(menu_exists(menu)) {
    destroy_menu(menu);
  }

  add_menu(menu, "Edit Spawner");
  add_menuoptions(menu, "Add Path Points", &add_pathpoints);
  add_menuoptions(menu, "Goal Radius", &menu_goalradius_inc, &menu_goalradius_dec, level.debug.spawnaimode.goalradius);
  add_menuoptions(menu, "Clear Path Points", &clear_pathpoints);
  add_menuoptions(menu, "Exit", &exit_menu);
  add_menuent(menu, level.debug.spawnaimode.highlightent);
  enable_menu(menu);
  level thread edit_spawner_exit(prev_menu);
}

function edit_spawner_exit(prev_menu) {
  spawner = level.debug.spawnaimode.highlightent;

  while(true) {
    spawner draw_spawner_edit_path();

    if(can_exit()) {
      break;
    }

    waitframe();
  }

  disable_menu("current_menu");
  set_mode("default");

  if(isDefined(prev_menu)) {
    enable_menu(prev_menu);
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
  prevpoint = self;

  foreach(point in self.pathpoints) {
    line(prevpoint.origin, point.origin);
    prevpoint = point;
    cylinder(point.origin, point.origin + (0, 0, 0.0001), point.radius, (1, 1, 1));
  }

  line(prevpoint.origin, level.debug.cursor_pos);
  cylinder(level.debug.cursor_pos, level.debug.cursor_pos + (0, 0, 0.0001), level.debug.spawnaimode.goalradius, (1, 1, 1));
}

function add_pathpoints() {
  if(!isDefined(self.pathpoints)) {
    self.pathpoints = [];
  }

  struct = spawnStruct();
  struct.origin = level.debug.cursor_pos;
  struct.angles = (0, 0, 0);
  struct.radius = level.debug.spawnaimode.goalradius;

  foreach(point in self.pathpoints) {
    if(distancesquared(point.origin, struct.origin) < 16) {
      return;
    }
  }

  self.pathpoints[self.pathpoints.size] = struct;
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
  }
}

function get_colortable() {
  colortable["white"] = (255, 255, 255) / 256;
  colortable["red"] = (255, 0, 0) / 256;
  colortable["green"] = (0, 255, 0) / 256;
  colortable["blue"] = (0, 0, 255) / 256;
  colortable["magenta"] = (255, 0, 255) / 256;
  colortable["cyan"] = (0, 255, 255) / 256;
  colortable["yellow"] = (255, 255, 0) / 256;
  colortable["black"] = (0, 0, 0) / 256;
  colortable["aquamarine"] = (112, 219, 147) / 256;
  colortable["brass"] = (181, 166, 66) / 256;
  colortable["cadet blue"] = (95, 159, 159) / 256;
  colortable["copper"] = (184, 115, 51) / 256;
  colortable["dark green"] = (47, 79, 47) / 256;
  colortable["dark orchid"] = (153, 50, 205) / 256;
  colortable["dark purple"] = (135, 31, 120) / 256;
  colortable["dark wood"] = (133, 94, 66) / 256;
  colortable["dim grey"] = (84, 84, 84) / 256;
  colortable["firebrick"] = (142, 35, 35) / 256;
  colortable["flesh"] = (245, 204, 176) / 256;
  colortable["forest green"] = (35, 142, 35) / 256;
  colortable["gold"] = (205, 127, 50) / 256;
  colortable["goldenrod"] = (219, 219, 112) / 256;
  colortable["grey"] = (192, 192, 192) / 256;
  colortable["green copper"] = (82, 127, 118) / 256;
  colortable["khaki"] = (159, 159, 95) / 256;
  colortable["maroon"] = (142, 35, 107) / 256;
  colortable["midnight blue"] = (47, 47, 79) / 256;
  colortable["new tan"] = (235, 199, 158) / 256;
  colortable["old gold"] = (207, 181, 59) / 256;
  colortable["orange"] = (255, 127, 0) / 256;
  colortable["orchid"] = (219, 112, 219) / 256;
  colortable["quartz"] = (217, 217, 243) / 256;
  colortable["rich blue"] = (89, 89, 171) / 256;
  colortable["scarlet"] = (140, 23, 23) / 256;
  colortable["sea green"] = (35, 142, 104) / 256;
  colortable["chocolate"] = (107, 66, 38) / 256;
  colortable["sienna"] = (142, 107, 35) / 256;
  colortable["slate blue"] = (0, 127, 255) / 256;
  colortable["spring green"] = (0, 255, 127) / 256;
  colortable["steel blue"] = (35, 107, 142) / 256;
  colortable["summer sky"] = (56, 176, 222) / 256;
  colortable["tan"] = (219, 147, 112) / 256;
  colortable["turquoise"] = (173, 234, 234) / 256;
  colortable["very dark brown"] = (92, 64, 51) / 256;
  colortable["violet"] = (79, 47, 79) / 256;
  colortable["violet red"] = (204, 50, 153) / 256;
  colortable["yellow "] = (153, 204, 50) / 256;
  return colortable;
}
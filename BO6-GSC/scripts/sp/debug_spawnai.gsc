/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\debug_spawnai.gsc
****************************************/

#using scripts\common\ai;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\debug;
#using scripts\sp\debug_menu;
#using scripts\sp\spawner;
#namespace debug_spawnai;

function spawn_ai_mode() {
  dvar = @ "hash_5d83147342337f0b";
  dvar_running = @ "hash_f6ac786807a5e9cb";
  setDvar(@ "hash_bb1a296df27c0f74", 0);
  spawners = getspawnerarray();

  if(spawners.size == 0) {
    println("<dev string:x24>");
    return;
  }

  spawnaimode = spawnStruct();
  spawnaimode.nextusepress = 0;
  spawnaimode.gameon = 0;
  spawnaimode.gamestarted = 0;
  spawnaimode.placedspawners = [];
  spawnaimode.selectedaitype = "<dev string:x4f>";
  spawnaimode.mode = "<dev string:x5c>";
  spawnaimode.storedweapons = debug::take_weapons_away();

  if(level.start_point == "<dev string:x67>") {
    spawner::main();
  }

  spawnaimode.goalradius = 64;
  level.debug.spawnaimode = spawnaimode;
  init_spawners();
  thread debug::debug_cursor(1);
  setDvar(dvar_running, 1);
  debug_menu::init_menus();
  menu_default();

  while(getdvarint(dvar)) {
    input();
    waitframe();
  }

  debug::give_weapons_back(spawnaimode.storedweapons);
  level.debug.spawnaimode = undefined;
  possible_menus = ["<dev string:x72>"];

  foreach(menuname in possible_menus) {
    debug_menu::disable_menu("<dev string:x82>");
    debug_menu::destroy_menu(menuname);
  }

  setDvar(dvar_running, 0);
  level notify("<dev string:x92>");
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

  spawnaimode.listaitypes = utility::alphabetize(spawnaimode.listaitypes);
}

function input() {
  closespawner = undefined;
  spawnaimode = level.debug.spawnaimode;
  updategameon();

  if(spawnaimode.gameon) {
    return;
  }

  if(spawnaimode.selectedaitype == "\xed\x1d\va\x1e\xf6\xe5\x88\x8a" && isDefined(level.debug.spawnaimode.heldspawner)) {
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

    if(level.player buttonPressed("Qv\r")) {
      spawnaimode.placedspawners = arrayremove(spawnaimode.placedspawners, spawnaimode.highlightent);
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
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x9e\x91\n\x19^\x9a\x84=");
  level endon("OP\xf1,fj");

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
  ent hudoutlineenable("\xf6\xb2EQ\"\xa9\xc8\xd6t\xd6\xa3\x94\xe8\x95lF>\xdd4\xc4\x14\x94");
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
  ent hudoutlineenable("\xff\xed\xc0\xc6\x9f\x15$\xb2%A\xd7G\xb0\x90I]\xb7\xf6\x06\xab");
  ent notify("\x9e\x91\n\x19^\x9a\x84=");
  level.debug.spawnaimode.highlightent = undefined;
}

function removeselected(ent) {
  level.debug.spawnaimode.selectedents = arrayremove(level.debug.spawnaimode.selectedents, ent);
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
  ent = utility_sp::dronespawn_bodyonly(spawner);
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
    guy = spawner utility_sp::spawn_ai(1);
    spawner restorespawner();
    spawner.origin = og_origin;

    if(!ai::spawn_failed(guy)) {
      guy.ignoreme = 1;
      guy.ignoreall = 1;
      guy clearenemy();
      guy.spawnai_realspawner = spawner;
      break;
    }
  }

  guy.spawnai_linkent = utility::spawn_tag_origin(guy.origin);
  guy linkTo(guy.spawnai_linkent);
  return guy;
}

function tryplacespawner() {
  angles = (0, 0, 0);
  spawnaimode = level.debug.spawnaimode;

  if(spawnaimode.mode != "\x91\xca\xcc\v\xab\xd8:") {
    return;
  }

  clear_heldspawner();
  spawnaimode.heldspawner = createspawner();
  spawnaimode.heldspawner thread heldspawner_think();
}

function heldspawner_think() {
  self endon("\x1e\xfd\xd1\xa2\a");
  spawnaimode = level.debug.spawnaimode;

  while(true) {
    self.origin = level.debug.cursor_pos;

    if(canpressuse() && level.player useButtonPressed()) {
      if(getaicount() > 32) {
        spawnaimode.placedspawners[0].guy delete();
        spawnaimode.placedspawners = utility::array_remove_index(spawnaimode.placedspawners, 0);
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
  level.debug.spawnaimode.selectedaitype = "\xed\x1d\va\x1e\xf6\xe5\x88\x8a";
  return "\xed\x1d\va\x1e\xf6\xe5\x88\x8a";
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
  hud.alignx = "O\xd5!\xe8\xd4\x9d";
  hud.vertalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  hud.horzalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  hud setvalue(duration);
  hud.fontscale = 1.5;

  while(getdvarint(@ "hash_bb1a296df27c0f74") == 1) {
    if(!spawnaimode.gamestarted) {
      time = (endtime - gettime()) * 0.001;
      time = int(time / 0.1) * 0.1;

      if(time <= 0) {
        hud settext("\xe1rSa(/\xd0\xeb");
        spawnaimode.gamestarted = 1;

        if(isDefined(hud)) {
          hud utility::delaycall(1, &destroy);
        }

        gameon();
      } else {
        hud setvalue(time);
      }
    }

    waitframe();
  }

  if(isDefined(hud)) {
    hud utility::delaycall(0.5, &destroy);
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
  self endon("\x1e\xfd\xd1\xa2\a");

  foreach(point in self.pathpoints) {
    spawner::go_to_node(point);
  }
}

function menu_default() {
  spawnaimode = level.debug.spawnaimode;
  menu = "\x03\xc6\x17\x9f\xd3X\x80\x1f\xbc\x18\xd1\xff";
  debug_menu::add_menu(menu, "\xe1\xf0\x81\x9b");
  debug_menu::add_menuoptions(menu, "S\x14\xcd5f\xe76", &gameon_toggle, undefined, getdvarint(@ "hash_bb1a296df27c0f74"));
  debug_menu::add_menuoptions(menu, "\x05\x1b\x166\xac\x04j\aX\xbb\xdc\xb2'", &pick_aitype, &clear_aitype, spawnaimode.selectedaitype);
  debug_menu::add_menuoptions(menu, "\xab\xec\xfe\xc3\v\xb3G\xbf\x9b\x1b\xe3\xac", &edit_spawner);
  debug_menu::enable_menu(menu);
}

function pick_aitype() {
  hud = debug_menu::menu_get_selected_optionsvalue();
  spawnaimode = level.debug.spawnaimode;

  if(spawnaimode.selectedaitype == "\xed\x1d\va\x1e\xf6\xe5\x88\x8a") {
    x_add = 12 * (spawnaimode.selectedaitype.size + 1);
  } else {
    x_add = 12 * (spawnaimode.selectedaitype.size - 7);
  }

  num = debug_menu::list_menu(spawnaimode.listaitypes, hud.x + x_add, hud.y);

  if(!isDefined(num)) {
    return undefined;
  }

  spawnaimode.selectedaitype = spawnaimode.listaitypes[num];
  tryplacespawner();
  return getsubstr(spawnaimode.selectedaitype, 6);
}

function edit_spawner() {
  prev_menu = debug_menu::get_current_menu_name();
  clear_aitype();

  if(!(isDefined(level.debug.spawnaimode.highlightent) && isDefined(level.debug.spawnaimode.highlightent.aitype))) {
    return;
  }

  set_mode("&r\xee{9\x01,\x9a\x19\xcf\x98w");
  debug_menu::disable_menu("\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH");
  menu = "77}\xa8\xd8\x9b3p\x03OSBA\xba8\xb3\xaar\x13";

  if(debug_menu::menu_exists(menu)) {
    debug_menu::destroy_menu(menu);
  }

  debug_menu::add_menu(menu, "\xab\xec\xfe\xc3\v\xb3G\xbf\x9b\x1b\xe3\xac");
  debug_menu::add_menuoptions(menu, "\x82d2\x04A\xc2\xd1h\x80({K\xe6\x1dn", &add_pathpoints);
  debug_menu::add_menuoptions(menu, "\rS\x8d\xf2h\xf1\xa3\xb0Xo\xf8", &menu_goalradius_inc, &menu_goalradius_dec, level.debug.spawnaimode.goalradius);
  debug_menu::add_menuoptions(menu, "\x01\xa7\x1f_\xa9\xe2T\xe5i\xc0\xd2`\xf0\x98\xeb\x89q", &clear_pathpoints);
  debug_menu::add_menuoptions(menu, "p\xb0\xc0\xda", &debug_menu::exit_menu);
  debug_menu::add_menuent(menu, level.debug.spawnaimode.highlightent);
  debug_menu::enable_menu(menu);
  level thread edit_spawner_exit(prev_menu);
}

function edit_spawner_exit(prev_menu) {
  spawner = level.debug.spawnaimode.highlightent;

  while(true) {
    spawner draw_spawner_edit_path();

    if(debug_menu::can_exit()) {
      break;
    }

    waitframe();
  }

  debug_menu::disable_menu("\xec\xdd\x0eO@\xdb\xae\xac\x86^\xdaH");
  set_mode("\x91\xca\xcc\v\xab\xd8:");

  if(isDefined(prev_menu)) {
    debug_menu::enable_menu(prev_menu);
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
  colortable["e\xac\x11}\xfd"] = (255, 255, 255) / 256;
  colortable["\x9b\x9b\v"] = (255, 0, 0) / 256;
  colortable["n*f\x1dw"] = (0, 255, 0) / 256;
  colortable["\xfb\xa0M\xd7"] = (0, 0, 255) / 256;
  colortable["\x83\x9ct^\xf6&\x91"] = (255, 0, 255) / 256;
  colortable["\xc6\xf5\x92\xc6"] = (0, 255, 255) / 256;
  colortable["^\xca\x8d6\xbdw"] = (255, 255, 0) / 256;
  colortable["\x8a-\v\xa1\xbd"] = (0, 0, 0) / 256;
  colortable["\x05K\xbb\x12\xd0\xda\xb1\x9f~e"] = (112, 219, 147) / 256;
  colortable["\x15\xea\\\x83\xfd"] = (181, 166, 66) / 256;
  colortable["\x18G\xc5mU\x9eG\n\x1a\x90"] = (95, 159, 159) / 256;
  colortable["\x96#\xf9w\xf7\x9d"] = (184, 115, 51) / 256;
  colortable["\x8e\xc8\xde\xc4\x1f\xd6T\xf22\xff"] = (47, 79, 47) / 256;
  colortable["\t\xae\xb0\x86\x84o\xdf\xa1\xd4U\xed"] = (153, 50, 205) / 256;
  colortable[" \xbf\x1f+K\xb9\v\x19\xa1MP"] = (135, 31, 120) / 256;
  colortable["\xd9\x973\xa2\x1aW\xfd\xc0\xb9"] = (133, 94, 66) / 256;
  colortable["\xf4ZnQ\xbdx\x94t"] = (84, 84, 84) / 256;
  colortable["\xfe/s\x9cT|\xb8\xfc\x11"] = (142, 35, 35) / 256;
  colortable[";Z\x0f\xdaH"] = (245, 204, 176) / 256;
  colortable["J!\x95[\x80/<\a%\xdd\x7fh"] = (35, 142, 35) / 256;
  colortable["\xb3\xbd\xa8\f"] = (205, 127, 50) / 256;
  colortable["PC\xa0D{\x98s\xcb\xc2"] = (219, 219, 112) / 256;
  colortable["\xd9B-\xc7"] = (192, 192, 192) / 256;
  colortable["<\xae\x15t\xech\xc3\x17\xb9\xeeC-"] = (82, 127, 118) / 256;
  colortable["6\xb9|\xb7\x9c"] = (159, 159, 95) / 256;
  colortable["\x80\xe4\xaf\xbd\x10\xf2"] = (142, 35, 107) / 256;
  colortable["\x14a5\x10\x94\xffz\"P\x01\x9b\x01%"] = (47, 47, 79) / 256;
  colortable["\xd7f\xf7\xa4\xc0H\x9b"] = (235, 199, 158) / 256;
  colortable["G\xf4\x8f\x92<7B\xf1"] = (207, 181, 59) / 256;
  colortable["\xb7\xc9\v\xdc\xceV"] = (255, 127, 0) / 256;
  colortable["\x9e\xf8x\xee\x15\x1a"] = (219, 112, 219) / 256;
  colortable["B\xc5\x92\xda]E"] = (217, 217, 243) / 256;
  colortable["\xba\xa5\x12\x80V\xa68\x8f\x80"] = (89, 89, 171) / 256;
  colortable["\xcb\xfb\xd5\xd1\x18_b"] = (140, 23, 23) / 256;
  colortable["\x8a\xf5\xe6\xbd\x8e\xf9\x10\xbd\x7f"] = (35, 142, 104) / 256;
  colortable["\xb1\xa1\xdb6\xbd\xc6atV"] = (107, 66, 38) / 256;
  colortable["3\x87\x114\xea\xf6"] = (142, 107, 35) / 256;
  colortable["\x9bcX\xa3Y\x01\xc4c\xd5\xac"] = (0, 127, 255) / 256;
  colortable["6\x14\xfc\x8cZO5dU\x86m\x84"] = (0, 255, 127) / 256;
  colortable["m]\xfb\x84\x98\xba\x118\x1d\xbd"] = (35, 107, 142) / 256;
  colortable["\x87AM\xf2\xad\x98l\xd3\xab\xaa"] = (56, 176, 222) / 256;
  colortable[">\x86e"] = (219, 147, 112) / 256;
  colortable["v\x11\x8fDb\xed\b\xab\xfd"] = (173, 234, 234) / 256;
  colortable["\x9dV9\xcb\x01d\x85\xc9\xb5\x021\xe4\xdbw\xe6"] = (92, 64, 51) / 256;
  colortable["\xecK\xedcV:"] = (79, 47, 79) / 256;
  colortable["\x0f\x02\xa7z\xe0a\xc1#-j"] = (204, 50, 153) / 256;
  colortable["\xd54s}
  };\
  x1b "] = (153, 204, 50) / 256;
  return colortable;
}
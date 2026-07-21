/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\debug_spawnai.gsc
***********************************************/

spawn_ai_mode() {}

init_spawners() {
  var_0 = level.debug.spawnaimode;
  var_0.realspawners = [];
  var_0.listaitypes = [];
  var_1 = [];
  var_2 = getspawnerarray();

  foreach(var_4 in var_2) {
    if(!isDefined(var_0.realspawners[var_4.classname])) {
      var_0.realspawners[var_4.classname] = var_4;
      var_0.listaitypes[var_0.listaitypes.size] = var_4.classname;
    }
  }

  var_0.listaitypes = scripts\engine\utility::alphabetize(var_0.listaitypes);
}

input() {
  var_0 = undefined;
  var_1 = level.debug.spawnaimode;
  updategameon();

  if(var_1.gameon) {
    return;
  }
  if(var_1.selectedaitype == "undefined" && isDefined(level.debug.spawnaimode.heldspawner))
    clear_heldspawner();

  foreach(var_3 in var_1.placedspawners) {
    if(distancesquared(var_3.origin, level.debug.cursor_pos) < 2304) {
      var_0 = var_3;
      break;
    }
  }

  if(isDefined(var_0)) {
    clear_heldspawner();
    highlightent(var_0);
  }

  if(!canpressuse()) {
    return;
  }
  if(!isDefined(var_0)) {
    if(isDefined(var_1.selectedents)) {} else
      unhighlightent();
  }

  if(isDefined(var_1.highlightent)) {
    if(level.player useButtonPressed()) {
      var_5 = undefined;

      if(isDefined(var_1.selectedents)) {
        foreach(var_7 in var_1.selectedents) {
          if(var_7 == var_1.highlightent) {
            var_5 = var_7;
            break;
          }
        }
      }

      if(isDefined(var_5))
        removeselected(var_5);
      else
        addselected(var_1.highlightent);

      delayusetime();
      return;
    } else if(level.player buttonPressed("del")) {
      var_1.placedspawners = scripts\engine\utility::array_remove(var_1.placedspawners, var_1.highlightent);
      var_1.highlightent delete();
    }
  }
}

gameon_toggle() {
  updategameon(1);
  return level.debug.spawnaimode.gameon;
}

updategameon(var_0) {
  if(!canpressuse()) {
    return;
  }
  if(level.player meleeButtonPressed() || isDefined(var_0)) {
    level.debug.spawnaimode.gameon = !level.debug.spawnaimode.gameon;

    if(level.debug.spawnaimode.gameon)
      thread gameon_thread();
    else
      gameoff();

    delayusetime();
  }
}

canpressuse() {
  return gettime() > level.debug.spawnaimode.nextusepress;
}

delayusetime() {
  level.debug.spawnaimode.nextusepress = gettime() + 400;
}

assigngoalpos(var_0, var_1) {
  self.spawnai_goalpos = var_0;
  self.spawnai_goalradius = var_1;
  thread drawassignedgoalpos();
}

drawassignedgoalpos() {
  self endon("death");
  self endon("selected");
  level endon("gameOn");

  for(;;) {
    waitframe();
    drawgoalpos(self.spawnai_goalpos, self.spawnai_goalradius);
  }
}

highlightent(var_0) {
  if(isDefined(level.debug.spawnaimode.highlightent) && level.debug.spawnaimode.highlightent == var_0) {
    return;
  }
  unhighlightent();
  var_0 hudoutlineenable("outline_nodepth_orange");
  level.debug.spawnaimode.highlightent = var_0;
}

unhighlightent() {
  if(!isDefined(level.debug.spawnaimode.highlightent)) {
    return;
  }
  level.debug.spawnaimode.highlightent hudoutlinedisable();
  level.debug.spawnaimode.highlightent = undefined;
}

addselected(var_0) {
  if(!isDefined(level.debug.spawnaimode.selectedents))
    level.debug.spawnaimode.selectedents = [];

  level.debug.spawnaimode.selectedents[level.debug.spawnaimode.selectedents.size] = var_0;
  var_0 hudoutlineenable("outline_nodepth_cyan");
  var_0 notify("selected");
  level.debug.spawnaimode.highlightent = undefined;
}

removeselected(var_0) {
  level.debug.spawnaimode.selectedents = scripts\engine\utility::array_remove(level.debug.spawnaimode.selectedents, var_0);
  var_0 hudoutlinedisable();

  if(level.debug.spawnaimode.selectedents.size == 0)
    level.debug.spawnaimode.selectedents = undefined;
}

drawgoalpos(var_0, var_1) {
  var_2 = (1, 1, 1);
}

createspawner() {
  var_0 = level.debug.spawnaimode;
  var_1 = get_spawner(var_0.selectedaitype);
  var_2 = scripts\engine\sp\utility::dronespawn_bodyonly(var_1);
  var_2.aitype = var_1.classname;
  var_2.pathpoints = [];
  return var_2;
}

get_spawner(var_0) {
  return level.debug.spawnaimode.realspawners[var_0];
}

spawnguy() {
  var_0 = level.debug.spawnaimode;
  var_1 = var_0.realspawners[randomint(var_0.realspawners.size)];

  for(;;) {
    var_1.count = var_1.count + 1;
    var_2 = var_1.origin;
    var_1.origin = level.debug.cursor_pos;
    var_1 stripspawner();
    var_3 = var_1 scripts\engine\sp\utility::spawn_ai(1);
    var_1 restorespawner();
    var_1.origin = var_2;

    if(!scripts\common\ai::spawn_failed(var_3)) {
      var_3.ignoreme = 1;
      var_3.ignoreall = 1;
      var_3 clearenemy();
      var_3.spawnai_realspawner = var_1;
      break;
    }
  }

  var_3.spawnai_linkent = scripts\engine\utility::spawn_tag_origin(var_3.origin);
  var_3 linkTo(var_3.spawnai_linkent);
  return var_3;
}

tryplacespawner() {
  var_0 = (0, 0, 0);
  var_1 = level.debug.spawnaimode;

  if(var_1.mode != "default") {
    return;
  }
  clear_heldspawner();
  var_1.heldspawner = createspawner();
  var_1.heldspawner thread heldspawner_think();
}

heldspawner_think() {
  self endon("death");
  var_0 = level.debug.spawnaimode;

  for(;;) {
    self.origin = level.debug.cursor_pos;

    if(canpressuse() && level.player useButtonPressed()) {
      if(getaicount() > 32) {
        var_0.placedspawners[0].guy delete();
        var_0.placedspawners = scripts\engine\utility::array_remove_index(var_0.placedspawners, 0);
      }

      var_0.placedspawners[var_0.placedspawners.size] = self;
      var_0.highlightent = self;
      var_0.heldspawner = undefined;
      level thread edit_spawner();
      delayusetime();
      break;
    }

    waitframe();
  }
}

clear_aitype() {
  clear_heldspawner();
  level.debug.spawnaimode.selectedaitype = "undefined";
  return "undefined";
}

clear_heldspawner() {
  if(isDefined(level.debug.spawnaimode.heldspawner))
    level.debug.spawnaimode.heldspawner delete();
}

set_mode(var_0) {
  level.debug.spawnaimode.mode = var_0;
}

gameon_thread() {
  var_0 = level.debug.spawnaimode;
  var_1 = 3;
  var_2 = gettime() + var_1 * 1000;
  setDvar("scr_debug_spawnAIModeGameON", 1);
  var_3 = newhudelem();
  var_3.x = 320;
  var_3.y = 100;
  var_3.alignx = "center";
  var_3.vertalign = "fullscreen";
  var_3.horzalign = "fullscreen";
  var_3 setvalue(var_1);
  var_3.fontscale = 1.5;

  while(getdvarint("scr_debug_spawnAIModeGameON") == 1) {
    if(!var_0.gamestarted) {
      var_4 = (var_2 - gettime()) * 0.001;
      var_4 = int(var_4 / 0.1) * 0.1;

      if(var_4 <= 0) {
        var_3 settext("GAME ON!");
        var_0.gamestarted = 1;

        if(isDefined(var_3))
          var_3 scripts\engine\utility::delaycall(1, ::destroy);

        gameon();
      } else
        var_3 setvalue(var_4);
    }

    waitframe();
  }

  if(isDefined(var_3))
    var_3 scripts\engine\utility::delaycall(0.5, ::destroy);

  var_0.gamestarted = 0;
}

gameoff() {
  setDvar("scr_debug_spawnAIModeGameON", 0);

  foreach(var_1 in level.debug.spawnaimode.placedspawners) {
    if(isalive(var_1.guy))
      var_1.guy delete();

    var_1 show();
  }
}

gameon() {
  foreach(var_1 in level.debug.spawnaimode.placedspawners) {
    var_1 hide();
    var_2 = havemapentseffects(var_1.aitype, var_1.origin, var_1.angles, 1);

    if(isDefined(var_2)) {
      var_2.pathpoints = var_1.pathpoints;
      var_1.guy = var_2;
      var_2 thread guy_think();
    }
  }
}

guy_think() {
  self endon("death");

  foreach(var_1 in self.pathpoints)
  scripts\sp\spawner::go_to_node(var_1);
}

menu_default() {
  var_0 = level.debug.spawnaimode;
  var_1 = "spawnai_main";
  scripts\sp\debug_menu::add_menu(var_1, "Main");
  scripts\sp\debug_menu::add_menuoptions(var_1, "Game On", ::gameon_toggle, undefined, getdvarint("scr_debug_spawnAIModeGameON"));
  scripts\sp\debug_menu::add_menuoptions(var_1, "Place Spawner", ::pick_aitype, ::clear_aitype, var_0.selectedaitype);
  scripts\sp\debug_menu::add_menuoptions(var_1, "Edit Spawner", ::edit_spawner);
  scripts\sp\debug_menu::enable_menu(var_1);
}

pick_aitype() {
  var_0 = scripts\sp\debug_menu::menu_get_selected_optionsvalue();
  var_1 = level.debug.spawnaimode;

  if(var_1.selectedaitype == "undefined")
    var_2 = 12 * (var_1.selectedaitype.size + 1);
  else
    var_2 = 12 * (var_1.selectedaitype.size - 7);

  var_3 = scripts\sp\debug_menu::list_menu(var_1.listaitypes, var_0.x + var_2, var_0.y);

  if(!isDefined(var_3))
    return undefined;

  var_1.selectedaitype = var_1.listaitypes[var_3];
  tryplacespawner();
  return getsubstr(var_1.selectedaitype, 6);
}

edit_spawner() {
  var_0 = scripts\sp\debug_menu::get_current_menu_name();
  clear_aitype();

  if(!isDefined(level.debug.spawnaimode.highlightent) || !isDefined(level.debug.spawnaimode.highlightent.aitype)) {
    return;
  }
  set_mode("edit_spawner");
  scripts\sp\debug_menu::disable_menu("current_menu");
  var_1 = "spawnai_editspawner";

  if(scripts\sp\debug_menu::menu_exists(var_1))
    scripts\sp\debug_menu::destroy_menu(var_1);

  scripts\sp\debug_menu::add_menu(var_1, "Edit Spawner");
  scripts\sp\debug_menu::add_menuoptions(var_1, "Add Path Points", ::add_pathpoints);
  scripts\sp\debug_menu::add_menuoptions(var_1, "Goal Radius", ::menu_goalradius_inc, ::menu_goalradius_dec, level.debug.spawnaimode.goalradius);
  scripts\sp\debug_menu::add_menuoptions(var_1, "Clear Path Points", ::clear_pathpoints);
  scripts\sp\debug_menu::add_menuoptions(var_1, "Exit", scripts\sp\debug_menu::exit_menu);
  scripts\sp\debug_menu::add_menuent(var_1, level.debug.spawnaimode.highlightent);
  scripts\sp\debug_menu::enable_menu(var_1);
  level thread edit_spawner_exit(var_0);
}

edit_spawner_exit(var_0) {
  var_1 = level.debug.spawnaimode.highlightent;

  for(;;) {
    var_1 draw_spawner_edit_path();

    if(scripts\sp\debug_menu::can_exit()) {
      break;
    }

    waitframe();
  }

  scripts\sp\debug_menu::disable_menu("current_menu");
  set_mode("default");

  if(isDefined(var_0))
    scripts\sp\debug_menu::enable_menu(var_0);
}

menu_goalradius_inc() {
  level.debug.spawnaimode.goalradius = level.debug.spawnaimode.goalradius + 2;
  level.debug.spawnaimode.goalradius = min(level.debug.spawnaimode.goalradius, 2048);
  return level.debug.spawnaimode.goalradius;
}

menu_goalradius_dec() {
  level.debug.spawnaimode.goalradius = level.debug.spawnaimode.goalradius - 2;
  level.debug.spawnaimode.goalradius = max(level.debug.spawnaimode.goalradius, 4);
  return level.debug.spawnaimode.goalradius;
}

draw_spawner_edit_path() {
  var_0 = self;

  foreach(var_3, var_2 in self.pathpoints)
  var_0 = var_2;
}

add_pathpoints() {
  if(!isDefined(self.pathpoints))
    self.pathpoints = [];

  var_0 = spawnStruct();
  var_0.origin = level.debug.cursor_pos;
  var_0.angles = (0, 0, 0);
  var_0.radius = level.debug.spawnaimode.goalradius;

  foreach(var_2 in self.pathpoints) {
    if(distancesquared(var_2.origin, var_0.origin) < 16)
      return;
  }

  self.pathpoints[self.pathpoints.size] = var_0;
}

clear_pathpoints() {
  self.pathpoints = [];
}

stripspawner() {
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

restorespawner() {
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

get_colortable() {
  var_0["white"] = (0.996094, 0.996094, 0.996094);
  var_0["red"] = (0.996094, 0, 0);
  var_0["green"] = (0, 0.996094, 0);
  var_0["blue"] = (0, 0, 0.996094);
  var_0["magenta"] = (0.996094, 0, 0.996094);
  var_0["cyan"] = (0, 0.996094, 0.996094);
  var_0["yellow"] = (0.996094, 0.996094, 0);
  var_0["black"] = (0, 0, 0);
  var_0["aquamarine"] = (0.4375, 0.855469, 0.574219);
  var_0["brass"] = (0.707031, 0.648438, 0.257812);
  var_0["cadet blue"] = (0.371094, 0.621094, 0.621094);
  var_0["copper"] = (0.71875, 0.449219, 0.199219);
  var_0["dark green"] = (0.183594, 0.308594, 0.183594);
  var_0["dark orchid"] = (0.597656, 0.195312, 0.800781);
  var_0["dark purple"] = (0.527344, 0.121094, 0.46875);
  var_0["dark wood"] = (0.519531, 0.367188, 0.257812);
  var_0["dim grey"] = (0.328125, 0.328125, 0.328125);
  var_0["firebrick"] = (0.554688, 0.136719, 0.136719);
  var_0["flesh"] = (0.957031, 0.796875, 0.6875);
  var_0["forest green"] = (0.136719, 0.554688, 0.136719);
  var_0["gold"] = (0.800781, 0.496094, 0.195312);
  var_0["goldenrod"] = (0.855469, 0.855469, 0.4375);
  var_0["grey"] = (0.75, 0.75, 0.75);
  var_0["green copper"] = (0.320312, 0.496094, 0.460938);
  var_0["khaki"] = (0.621094, 0.621094, 0.371094);
  var_0["maroon"] = (0.554688, 0.136719, 0.417969);
  var_0["midnight blue"] = (0.183594, 0.183594, 0.308594);
  var_0["new tan"] = (0.917969, 0.777344, 0.617188);
  var_0["old gold"] = (0.808594, 0.707031, 0.230469);
  var_0["orange"] = (0.996094, 0.496094, 0);
  var_0["orchid"] = (0.855469, 0.4375, 0.855469);
  var_0["quartz"] = (0.847656, 0.847656, 0.949219);
  var_0["rich blue"] = (0.347656, 0.347656, 0.667969);
  var_0["scarlet"] = (0.546875, 0.0898438, 0.0898438);
  var_0["sea green"] = (0.136719, 0.554688, 0.40625);
  var_0["chocolate"] = (0.417969, 0.257812, 0.148438);
  var_0["sienna"] = (0.554688, 0.417969, 0.136719);
  var_0["slate blue"] = (0, 0.496094, 0.996094);
  var_0["spring green"] = (0, 0.996094, 0.496094);
  var_0["steel blue"] = (0.136719, 0.417969, 0.554688);
  var_0["summer sky"] = (0.21875, 0.6875, 0.867188);
  var_0["tan"] = (0.855469, 0.574219, 0.4375);
  var_0["turquoise"] = (0.675781, 0.914062, 0.914062);
  var_0["very dark brown"] = (0.359375, 0.25, 0.199219);
  var_0["violet"] = (0.308594, 0.183594, 0.308594);
  var_0["violet red"] = (0.796875, 0.195312, 0.597656);
  var_0["yellow "] = (0.597656, 0.796875, 0.195312);
  return var_0;
}
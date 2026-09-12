/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_m_cargo\mp_m_cargo.gsc
*****************************************************/

function main() {
  scripts\mp\maps\mp_m_cargo\mp_m_cargo_precache::main();
  scripts\mp\maps\mp_m_cargo\gen\mp_m_cargo_art::main();
  scripts\mp\maps\mp_m_cargo\mp_m_cargo_fx::main();
  scripts\mp\maps\mp_m_cargo\mp_m_cargo_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_m_cargo", "codcaster_compass_map_mp_m_cargo");
  scripts\cp_mp\utility\game_utility::registerarenamap();
  level.requiresminstartspawns = 0;
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread ref_139c6();
  thread playerspawnexfilchopper();
  thread get_recently_shot_at_by_rpg();
  thread player_fired_gun_monitor();
  thread increase_accuracy_after_delay();
}

function player_fired_gun_monitor() {
  var_0 = getEnt("mount32", "targetname");
  var_1 = spawn("script_model", (-337, -264, 92));
  var_1.angles = (270, 0, -45);
  var_1 clonebrushmodeltoscriptmodel(var_0, 1);
  var_2 = getEnt("mount64", "targetname");
  var_3 = spawn("script_model", (58, 7, 5));
  var_3.angles = (0, 80, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2, 1);
  var_4 = getEnt("tactical_cover_col", "targetname");
  var_5 = spawn("script_model", (-368, 244, 2));
  var_5.angles = (0, 90, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getEnt("tactical_cover_col", "targetname");
  var_7 = spawn("script_model", (-368, 152, 2));
  var_7.angles = (0, 90, 0);
  var_7 clonebrushmodeltoscriptmodel(var_6);
}

function increase_accuracy_after_delay() {
  var_0 = spawn("script_model", (267.67, 222.004, 11.5));
  var_0.angles = (0, 270, 0);
  var_0 setModel("weapon_wm_la_juliet_missile_fat");
  var_1 = spawn("script_model", (267.67, 222.01, 26.0559));
  var_1.angles = (0, 90, -180);
  var_1 setModel("weapon_wm_la_juliet_missile_fat");
  var_2 = spawn("script_model", (267.67, 222.004, 37.5));
  var_2.angles = (0, 270, 0);
  var_2 setModel("weapon_wm_la_juliet_missile_fat");
}

function ref_139c6() {
  var_0 = getEnt("swayCrate", "targetname");
  var_1 = getEntArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    var_3 linkTo(var_0);
  }

  thread ref_139c8(var_0);
  thread ref_11fa8();
}

function ref_11fa8() {
  var_0 = getEnt("ocean", "targetname");
  var_1 = 7;
  var_0 rotateTo((0, 0, -1.5), 5, 2.25, 2.25);
  wait 5;

  for(;;) {
    var_0 rotateTo((0, 0, 1.5), var_1, var_1 * 0.45, var_1 * 0.45);
    wait var_1;
    var_0 rotateTo((0, 0, -1.5), var_1, var_1 * 0.45, var_1 * 0.45);
    wait var_1;
  }
}

function ref_139c8(var_0) {
  var_1 = 4;

  for(;;) {
    var_2 = 7;
    var_1 *= -1;
    var_0.goalang = (randomfloatrange(-1.5, 1.5), randomfloatrange(-15, 15), var_1);
    var_0 rotateTo(var_0.goalang, var_2, var_2 * 0.45, var_2 * 0.45);
    wait var_2;
    scripts\engine\utility::exploder("left");
    var_1 *= -1;
    var_0.goalang = (randomfloatrange(-1.5, 1.5), randomfloatrange(-15, 15), var_1);
    var_0 rotateTo(var_0.goalang, var_2, var_2 * 0.45, var_2 * 0.45);
    wait var_2;
    scripts\engine\utility::exploder("right");
  }
}

function playerspawnexfilchopper() {
  var_0 = getEnt("swayCrate", "targetname");
  var_1 = (0, 0, -386.09);

  for(;;) {
    waitframe();
    var_2 = var_0.angles * (0, 0, 3);
    var_3 = anglestoup(var_2);
    var_4 = var_3 * -386.09;
    waitframe();
    physics_setgravity(var_4);
    waitframe();
    physicsjolt((0, 0, 0), 1024, 1000, (0.1, 0.1, 0.1));
    waitframe();
  }
}

function get_recently_shot_at_by_rpg() {
  while(!istrue(game["gamestarted"])) {
    waitframe();
  }

  if(scripts\mp\utility\game::getgametype() == "arena") {
    var_0 = getEntArray("toy", "targetname");
    var_1 = getEntArray("magic", "targetname");
  } else {
    var_0 = getEntArray("magic", "targetname");
    var_1 = getEntArray("toy", "targetname");
  }

  level.ref_11f3c = 0;

  foreach(var_3 in var_1) {
    thread trackhiddenobj(var_3);
  }

  level.ref_11f3e = 0;

  foreach(var_3 in var_0) {
    thread ref_13c4c(var_3);
  }

  while(level.ref_11f3c < var_1.size && level.ref_11f3e == 0) {
    wait 1;
  }

  if(level.ref_11f3e == 0) {
    for(var_7 = 30; var_7 > 0; var_7--) {
      var_8 = (randomintrange(-400, 400), randomintrange(-400, 400), 800);
      var_9 = spawn("script_model", var_8);
      var_9 setModel("p7_spl_toy_beach_ball_01_clean");
      var_9 physicslaunchserver((0, 0, 0), (0, 0, 0), -500);
      wait 0.1;
    }

    return;
  }
}

function trackhiddenobj(var_0) {
  level endon("game_ended");
  self setCanDamage(1);
  self.found = [];

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);

    if(isDefined(var_10)) {
      if(var_5 == "MOD_EXPLOSIVE" || var_5 == "MOD_GRENADE_SPLASH") {
        continue;
      }
    } else if(isDefined(var_14.streakinfo) && scripts\mp\utility\killstreak::iskillstreak(var_14.streakinfo.streakname)) {
      self.health = 5;
      continue;
    }

    if(!isDefined(self.found[var_2.guid])) {
      self.found[var_2.guid] = 1;

      if(!isDefined(var_2.hiddenobjcount)) {
        var_2.hiddenobjcount = 1;
      } else {
        var_2.hiddenobjcount++;
      }
    }

    if(self.health <= 0) {
      break;
    }
  }

  level.ref_11f3c++;
  self delete();
}

function ref_13c4c(var_0) {
  level endon("game_ended");
  self setCanDamage(1);
  self.found = [];

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);

    if(isDefined(var_10)) {
      if(var_5 == "MOD_EXPLOSIVE" || var_5 == "MOD_GRENADE_SPLASH") {
        continue;
      }
    } else if(isDefined(var_14.streakinfo) && scripts\mp\utility\killstreak::iskillstreak(var_14.streakinfo.streakname)) {
      self.health = 5;
      continue;
    }

    if(!isDefined(self.found[var_2.guid])) {
      self.found[var_2.guid] = 1;

      if(!isDefined(var_2.hiddenobjcount)) {
        var_2.hiddenobjcount = 1;
      } else {
        var_2.hiddenobjcount++;
      }
    }

    if(self.health <= 0) {
      break;
    }
  }

  level.ref_11f3e++;
  self delete();
}
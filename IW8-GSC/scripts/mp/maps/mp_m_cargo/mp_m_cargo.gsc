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
  setDvar("PKKMTTRQO", 8);
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
  var0 = getEnt("mount32", "targetname");
  var1 = spawn("script_model", (-337, -264, 92));
  var1.angles = (270, 0, -45);
  var1 clonebrushmodeltoscriptmodel(var0, 1);
  var2 = getEnt("mount64", "targetname");
  var3 = spawn("script_model", (58, 7, 5));
  var3.angles = (0, 80, 0);
  var3 clonebrushmodeltoscriptmodel(var2, 1);
  var4 = getEnt("tactical_cover_col", "targetname");
  var5 = spawn("script_model", (-368, 244, 2));
  var5.angles = (0, 90, 0);
  var5 clonebrushmodeltoscriptmodel(var4);
  var6 = getEnt("tactical_cover_col", "targetname");
  var7 = spawn("script_model", (-368, 152, 2));
  var7.angles = (0, 90, 0);
  var7 clonebrushmodeltoscriptmodel(var6);
}

function increase_accuracy_after_delay() {
  var0 = spawn("script_model", (267.67, 222.004, 11.5));
  var0.angles = (0, 270, 0);
  var0 setModel("weapon_wm_la_juliet_missile_fat");
  var1 = spawn("script_model", (267.67, 222.01, 26.0559));
  var1.angles = (0, 90, -180);
  var1 setModel("weapon_wm_la_juliet_missile_fat");
  var2 = spawn("script_model", (267.67, 222.004, 37.5));
  var2.angles = (0, 270, 0);
  var2 setModel("weapon_wm_la_juliet_missile_fat");
}

function ref_139c6() {
  var0 = getEnt("swayCrate", "targetname");
  var1 = getEntArray(var0.target, "targetname");

  foreach(var3 in var1) {
    var3 linkTo(var0);
  }

  thread ref_139c8(var0);
  thread ref_11fa8();
}

function ref_11fa8() {
  var0 = getEnt("ocean", "targetname");
  var1 = 7;
  var0 rotateTo((0, 0, -1.5), 5, 2.25, 2.25);
  wait 5;

  for(;;) {
    var0 rotateTo((0, 0, 1.5), var1, var1 * 0.45, var1 * 0.45);
    wait var1;
    var0 rotateTo((0, 0, -1.5), var1, var1 * 0.45, var1 * 0.45);
    wait var1;
  }
}

function ref_139c8(var0) {
  var1 = 4;

  for(;;) {
    var2 = 7;
    var1 *= -1;
    var0.goalang = (randomfloatrange(-1.5, 1.5), randomfloatrange(-15, 15), var1);
    var0 rotateTo(var0.goalang, var2, var2 * 0.45, var2 * 0.45);
    wait var2;
    scripts\engine\utility::exploder("left");
    var1 *= -1;
    var0.goalang = (randomfloatrange(-1.5, 1.5), randomfloatrange(-15, 15), var1);
    var0 rotateTo(var0.goalang, var2, var2 * 0.45, var2 * 0.45);
    wait var2;
    scripts\engine\utility::exploder("right");
  }
}

function playerspawnexfilchopper() {
  var0 = getEnt("swayCrate", "targetname");
  var1 = (0, 0, -386.09);

  for(;;) {
    waitframe();
    var2 = var0.angles * (0, 0, 3);
    var3 = anglestoup(var2);
    var4 = var3 * -386.09;
    waitframe();
    physics_setgravity(var4);
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
    var0 = getEntArray("toy", "targetname");
    var1 = getEntArray("magic", "targetname");
  } else {
    var0 = getEntArray("magic", "targetname");
    var1 = getEntArray("toy", "targetname");
  }

  level.ref_11f3c = 0;

  foreach(var3 in var1) {
    thread trackhiddenobj(var3);
  }

  level.ref_11f3e = 0;

  foreach(var3 in var0) {
    thread ref_13c4c(var3);
  }

  while(level.ref_11f3c < var1.size && level.ref_11f3e == 0) {
    wait 1;
  }

  if(level.ref_11f3e == 0) {
    for(var7 = 30; var7 > 0; var7--) {
      var8 = (randomintrange(-400, 400), randomintrange(-400, 400), 800);
      var9 = spawn("script_model", var8);
      var9 setModel("p7_spl_toy_beach_ball_01_clean");
      var9 physicslaunchserver((0, 0, 0), (0, 0, 0), -500);
      wait 0.1;
    }

    return;
  }
}

function trackhiddenobj(var0) {
  level endon("game_ended");
  self setCanDamage(1);
  self.found = [];

  for(;;) {
    self waittill("damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14);

    if(isDefined(var10)) {
      if(var5 == "MOD_EXPLOSIVE" || var5 == "MOD_GRENADE_SPLASH") {
        continue;
      }
    } else if(isDefined(var14.streakinfo) && scripts\mp\utility\killstreak::iskillstreak(var14.streakinfo.streakname)) {
      self.health = 5;
      continue;
    }

    if(!isDefined(self.found[var2.guid])) {
      self.found[var2.guid] = 1;

      if(!isDefined(var2.hiddenobjcount)) {
        var2.hiddenobjcount = 1;
      } else {
        var2.hiddenobjcount++;
      }
    }

    if(self.health <= 0) {
      break;
    }
  }

  level.ref_11f3c++;
  self delete();
}

function ref_13c4c(var0) {
  level endon("game_ended");
  self setCanDamage(1);
  self.found = [];

  for(;;) {
    self waittill("damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14);

    if(isDefined(var10)) {
      if(var5 == "MOD_EXPLOSIVE" || var5 == "MOD_GRENADE_SPLASH") {
        continue;
      }
    } else if(isDefined(var14.streakinfo) && scripts\mp\utility\killstreak::iskillstreak(var14.streakinfo.streakname)) {
      self.health = 5;
      continue;
    }

    if(!isDefined(self.found[var2.guid])) {
      self.found[var2.guid] = 1;

      if(!isDefined(var2.hiddenobjcount)) {
        var2.hiddenobjcount = 1;
      } else {
        var2.hiddenobjcount++;
      }
    }

    if(self.health <= 0) {
      break;
    }
  }

  level.ref_11f3e++;
  self delete();
}
/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3f770f4f52b1ecf6.gsc
*************************************************/

#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace namespace_359eabeed0aa16a9;

function function_1bdc76359002a87d() {}

function function_6c1e0eb333fee7fe() {
  thread function_d2c67316e3340d42();
  thread deathcleanup();
  self endon("death");
  self endon("disconnect");
  self endon("showing_final_killcam");
  childthread function_6a4d394e7f9fc34e();
}

function function_6a4d394e7f9fc34e() {
  while(true) {
    if(isDefined(self.currentweapon) && function_a48875a04bede9a6(self.currentweapon)) {
      if(isDefined(level.var_ca0f41fe9610167a) && level.var_ca0f41fe9610167a) {
        childthread function_844dc249ef1b3a5e();
      } else {
        childthread function_48c1bb804931bb07();
      }

      childthread function_808cd37a5a40862d();
    }

    self waittill("weapon_change");
  }
}

function function_a48875a04bede9a6(weaponobj) {
  if(isDefined(weaponobj) && isDefined(weaponobj.scope) && string_starts_with(weaponobj.scope, "snscope_drop")) {
    return true;
  }

  return false;
}

function function_48c1bb804931bb07() {
  self endon("weapon_change");
  contents = create_contents(1, 1, 1, 0, 0, 1, 0, 0, 0, 0);

  while(true) {
    waitframe();

    if(!self playerads()) {
      continue;
    }

    start = self getEye();
    end = ray_trace(start, start + anglesToForward(level.player getplayerangles()) * 99999, undefined, contents)["position"];
    distance = length(start - end);
    self setclientomnvar("ui_scope_range_finder_distance", int(distance * 0.0254));
  }
}

function function_844dc249ef1b3a5e() {
  self endon("weapon_change");
  thread function_46d948b40cc362dc();
  contents = create_contents(1, 1, 1, 0, 0, 1, 0, 0, 0, 0);

  while(true) {
    waitframe();

    while(isDefined(level.target_guy)) {
      waitframe();
    }

    thread function_3e83a8605613947c(contents);

    while(!isDefined(level.target_guy)) {
      waitframe();
    }

    level notify("target_sighted");
  }
}

function function_3e83a8605613947c(contents) {
  level endon("target_sighted");

  while(true) {
    waitframe();

    if(!self playerads()) {
      continue;
    }

    start = self getEye();
    end = ray_trace(start, start + anglesToForward(level.player getplayerangles()) * 99999, undefined, contents)["position"];
    distance = length(start - end);
    self setclientomnvar("ui_scope_range_finder_distance", int(distance * 0.0254));
  }
}

function function_46d948b40cc362dc() {
  lastenemy = undefined;
  thread function_86dae4285c17eba2();

  while(true) {
    waitframe();
    enemies = getaiarray("axis");

    if(enemies.size <= 0) {
      while(enemies.size <= 0) {
        waitframe();
        enemies = getaiarray("axis");
      }
    }

    currentenemy = [[self.var_921001ec11dc92ab]](enemies);

    if(!isDefined(currentenemy)) {
      continue;
    }

    if(!isDefined(lastenemy) || lastenemy != currentenemy) {
      level notify("target_changed");
    }

    lastenemy = currentenemy;
    waittillframeend();
    thread targetenemy(currentenemy);
  }
}

function function_86dae4285c17eba2() {
  for(startingenemies = undefined; !isDefined(startingenemies); startingenemies = getaiarray("axis")) {
    waitframe();
  }

  while(true) {
    waitframe();
    currentenemies = getaiarray("axis");

    if(!isDefined(currentenemies)) {
      continue;
    }

    if(currentenemies.size < startingenemies.size) {
      startingenemies = currentenemies;
      continue;
    }

    if(currentenemies.size > startingenemies.size) {
      level notify("scope_timeout");
      startingenemies = currentenemies;
    }
  }
}

function targetenemy(enemy) {
  enemy endon("death");
  level endon("target_changed");

  while(true) {
    waitframe();

    if(!self playerads()) {
      continue;
    }

    start = self getEye();
    distance = length(start - enemy.origin);
    self setclientomnvar("ui_scope_range_finder_distance", int(distance * 0.0254));
  }
}

function function_808cd37a5a40862d() {
  self endon("weapon_change");

  while(true) {
    if(isDefined(level.var_ca0f41fe9610167a) && level.var_ca0f41fe9610167a) {
      function_e8ca271588171c26();
    } else if(self playerads() == 1 && self sprintbuttonPressed()) {
      pressstarttime = gettime();

      while(self playerads() == 1 && self sprintbuttonPressed()) {
        waitframe();
      }

      if(self playerads() == 1) {
        timepressed = gettime() - pressstarttime;

        if(timepressed < 200) {
          function_e8ca271588171c26();
        }
      }
    }

    waitframe();
  }
}

function function_e8ca271588171c26() {
  range = self getclientomnvar("ui_scope_range_finder_distance");

  if(range < 30) {
    range = 0;
  }

  self setclientomnvar("ui_scope_range_finder_distance_locked", int(range));
  drop = function_621629aca9bfb262(range);
  self setclientomnvar("ui_scope_range_finder_bulletdrop", int(drop));
  self setclientomnvar("ui_scope_range_finder_bulletdrop_update", 1);
  waitframe();
  self setclientomnvar("ui_scope_range_finder_bulletdrop_update", 0);
}

function function_621629aca9bfb262(range) {
  drop = math::normalize_value(0, 2000, range);
  factor = math::factor_value(0, 200, drop);

  if(isDefined(level.var_27b61226a83766df)) {
    factor *= 2.9;
  } else {
    factor *= 1.2;
  }

  return factor;
}

function function_d2c67316e3340d42() {
  waittill_any_3("death", "disconnect", "showing_final_killcam");
}

function deathcleanup() {
  self endon("disconnect");
  waittill_any_2("death", "showing_final_killcam");
}
/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_3f770f4f52b1ecf6.gsc
*****************************************************/

#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace namespace_ca5b5e341426058c;

function function_dd090a211af8d814() {}

function function_6c7faf63f08b41d3() {
  thread function_857d54743f13dc4b();
  thread deathcleanup();
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  self endon("\xb9\xc3\x96\xf6P\xf8\xden\x8eDY\xf1U\xbc\xdf\xaa\xbe\xa0n\xa2\xd9");
  childthread function_b3229fbc4939d76f();
}

function function_b3229fbc4939d76f() {
  while(true) {
    if(isDefined(self.currentweapon) && function_42174c74d6ec62bf(self.currentweapon)) {
      if(isDefined(level.var_c48433173098a1a3) && level.var_c48433173098a1a3) {
        childthread targetdistanceupdate();
      } else {
        childthread function_6211f72351ecfe02();
      }

      childthread function_3062982788ef6e0c();
    }

    self waittill("Jz\xaf\x02A\xf5\xfcX\x96Z\x98YY");
  }
}

function function_42174c74d6ec62bf(weaponobj) {
  if(isDefined(weaponobj) && isDefined(weaponobj.scope) && utility::string_starts_with(weaponobj.scope, "\x81\xdd\x83\xb9\xb1\x8b\xc1\xd6\xacQ\x84S")) {
    return true;
  }

  return false;
}

function function_6211f72351ecfe02() {
  self endon("Jz\xaf\x02A\xf5\xfcX\x96Z\x98YY");
  contents = trace::create_contents(1, 1, 1, 0, 0, 1, 0, 0, 0, 0);

  while(true) {
    waitframe();

    if(!self playerads()) {
      continue;
    }

    start = self getEye();
    end = trace::ray_trace(start, start + anglesToForward(level.player getplayerangles()) * 99999, undefined, contents)["\xc1\xbd\xdci\xe8i{7"];
    distance = length(start - end);
    self setclientomnvar("\xd5$\x87\x19\xaf\x97Vu=w..\xcc\x84\x80L\xfb\xa3n\xa3\x18@0\xb8@\xd3\xa9BZs", int(distance * 0.0254));
  }
}

function targetdistanceupdate() {
  self endon("Jz\xaf\x02A\xf5\xfcX\x96Z\x98YY");
  thread targetenemychanged();
  contents = trace::create_contents(1, 1, 1, 0, 0, 1, 0, 0, 0, 0);

  while(true) {
    waitframe();

    while(isDefined(level.target_guy)) {
      waitframe();
    }

    thread function_216aec63892778b9(contents);

    while(!isDefined(level.target_guy)) {
      waitframe();
    }

    level notify("s]\x99)\xed\x99V\xe5~\x05\x91GP\r");
  }
}

function function_216aec63892778b9(contents) {
  level endon("s]\x99)\xed\x99V\xe5~\x05\x91GP\r");

  while(true) {
    waitframe();

    if(!self playerads()) {
      continue;
    }

    start = self getEye();
    end = trace::ray_trace(start, start + anglesToForward(level.player getplayerangles()) * 99999, undefined, contents)["\xc1\xbd\xdci\xe8i{7"];
    distance = length(start - end);
    self setclientomnvar("\xd5$\x87\x19\xaf\x97Vu=w..\xcc\x84\x80L\xfb\xa3n\xa3\x18@0\xb8@\xd3\xa9BZs", int(distance * 0.0254));
  }
}

function targetenemychanged() {
  lastenemy = undefined;
  thread function_e5c491ff0bea9277();

  while(true) {
    waitframe();
    enemies = getaiarray("?\xb1\xc0\x9a");

    if(enemies.size <= 0) {
      while(enemies.size <= 0) {
        waitframe();
        enemies = getaiarray("?\xb1\xc0\x9a");
      }
    }

    currentenemy = [[self.var_7b68b69bf27e516a]](enemies);

    if(!isDefined(currentenemy)) {
      continue;
    }

    if(!isDefined(lastenemy) || lastenemy != currentenemy) {
      level notify("y\xc8-\x98_\xf7\x1el\xa0\xf1*U^\x9a");
    }

    lastenemy = currentenemy;
    waittillframeend();
    thread targetenemy(currentenemy);
  }
}

function function_e5c491ff0bea9277() {
  for(startingenemies = undefined; !isDefined(startingenemies); startingenemies = getaiarray("?\xb1\xc0\x9a")) {
    waitframe();
  }

  while(true) {
    waitframe();
    currentenemies = getaiarray("?\xb1\xc0\x9a");

    if(!isDefined(currentenemies)) {
      continue;
    }

    if(currentenemies.size < startingenemies.size) {
      startingenemies = currentenemies;
      continue;
    }

    if(currentenemies.size > startingenemies.size) {
      level notify("tY\x17\xec\xed\xfc35|%\xa9C\xd8");
      startingenemies = currentenemies;
    }
  }
}

function targetenemy(enemy) {
  enemy endon("\x1e\xfd\xd1\xa2\a");
  level endon("y\xc8-\x98_\xf7\x1el\xa0\xf1*U^\x9a");

  while(true) {
    waitframe();

    if(!self playerads()) {
      continue;
    }

    start = self getEye();
    distance = length(start - enemy.origin);
    self setclientomnvar("\xd5$\x87\x19\xaf\x97Vu=w..\xcc\x84\x80L\xfb\xa3n\xa3\x18@0\xb8@\xd3\xa9BZs", int(distance * 0.0254));
  }
}

function function_3062982788ef6e0c() {
  self endon("Jz\xaf\x02A\xf5\xfcX\x96Z\x98YY");

  while(true) {
    if(isDefined(level.var_c48433173098a1a3) && level.var_c48433173098a1a3) {
      function_93925317d9e739ab();
    } else if(self playerads() == 1 && self sprintbuttonPressed()) {
      pressstarttime = gettime();

      while(self playerads() == 1 && self sprintbuttonPressed()) {
        waitframe();
      }

      if(self playerads() == 1) {
        timepressed = gettime() - pressstarttime;

        if(timepressed < 200) {
          function_93925317d9e739ab();
        }
      }
    }

    waitframe();
  }
}

function function_93925317d9e739ab() {
  range = self getclientomnvar("\xd5$\x87\x19\xaf\x97Vu=w..\xcc\x84\x80L\xfb\xa3n\xa3\x18@0\xb8@\xd3\xa9BZs");

  if(range < 30) {
    range = 0;
  }

  self setclientomnvar("J\x89W\xde\x81t@\x1a\xe3\xb4Dnx\xf7\xfb\f,\xcb\xa6b$\xfd?\x05\xc3\xeb\xf2i\x81\xe0\xe3x\x9f\x13\xe3B\x12", int(range));
  drop = function_b2b581c82979ef6f(range);
  self setclientomnvar("\xb0Z($c\xacO\xf9\xd0r\x9a\x8eD(\x90\x8a6\xcfF\xd5(\x9a\xa50,\f\xc7j\xbc\xcd<T", int(drop));
  self setclientomnvar("v\xbf\xc4\xff\xc6\xfd2\b\xff\neF\xfb\xfe\xb8\xc8Y\x01YM\x1e+#\xbb#r<k\xb8\xb9\xffd\x0fq\xe8\x95\xeb\x95\xf6", 1);
  waitframe();
  self setclientomnvar("v\xbf\xc4\xff\xc6\xfd2\b\xff\neF\xfb\xfe\xb8\xc8Y\x01YM\x1e+#\xbb#r<k\xb8\xb9\xffd\x0fq\xe8\x95\xeb\x95\xf6", 0);
}

function function_b2b581c82979ef6f(range) {
  drop = math::normalize_value(0, 2000, range);
  factor = math::factor_value(0, 200, drop);

  if(isDefined(level.var_b97bf1060d624182)) {
    factor *= 2.9;
  } else {
    factor *= 1.2;
  }

  return factor;
}

function function_857d54743f13dc4b() {
  utility::waittill_any("\x1e\xfd\xd1\xa2\a", "\xf4\x9c \x0f\xaa\x9d\xbf,a\x16", "\xb9\xc3\x96\xf6P\xf8\xden\x8eDY\xf1U\xbc\xdf\xaa\xbe\xa0n\xa2\xd9");
}

function deathcleanup() {
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  utility::waittill_any("\x1e\xfd\xd1\xa2\a", "\xb9\xc3\x96\xf6P\xf8\xden\x8eDY\xf1U\xbc\xdf\xaa\xbe\xa0n\xa2\xd9");
}
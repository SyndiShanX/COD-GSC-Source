/*****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\equipment\noisemaker_tranquilizer_trap.gsc
*****************************************************************/

#using script_53f4e6352b0b2425;
#using scripts\aitypes\stealth;
#using scripts\anim\shared;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\equipment\offhands;
#using scripts\sp\player\cursor_hint;
#namespace noisemaker_tranquilizer_trap;

function private autoexec function_544c3ac2bb39f9d7() {
  offhands::registerprecachefunc("t!{\xa3\x9e\xd9\xbc\x95\xcdb\xaet\xbc*O\xb8V\x8b\xae\xf8\xc7h\xc3\x1e9\x10\x13\x19\xf4Y\xad\x96", &precache);
}

function private precache(offhand) {
  level.g_effect["[t\xdb<=V\xb5\xc3\x18U^\xd5@}X\x85w\x1d\xefH\x96}"] = loadfxasset("y\v\xbeG\xaeF\xd0v\xbc\x01EqDkJ\xe9\x91\x12\xf1*\xd4\xddm\x1el$\xd37\xd7\x99n\xa7)\xb1\xa6x![\xb3)\xcb");
  level.g_effect["\xb5\xf3q\xaa\x12\xfe@z?\x82G\xf5\v\xb8l\x1d"] = loadfxasset("!\x06\x994#\xf27\xf2\x02\x17\xc2\xe7<\b\xf0-]0\xab\xb3\xe4\x10i2\nd\xb3\xe9\xfey\xceA=>\x18\xbb\xa2\xa2H.\nc");
  offhands::registeroffhandfirefunc(offhand, &function_9ae4d1f112319a56);
  offhands::overrideweaponoffhandtype("t!{\xa3\x9e\xd9\xbc\x95\xcdb\xaet\xbc*O\xb8V\x8b\xae\xf8\xc7h\xc3\x1e9\x10\x13\x19\xf4Y\xad\x96", 0);
  level.var_af45ebdaefe0c22e = [];
}

function private hitai() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("d\xd9b~\xf2\x9f\x15\x93T\xd1\x04\x1a\x18");
  self waittill("\a\x9c\xde\xd4\x95\xb1\xa3\xd2\xc6\xac\xeb\x96\xb5\a\x85\x8d:\xfa,Z");
  self.var_340e466c3733e571 = self.origin;
  trapdetonate();
}

function private function_9ae4d1f112319a56(trap, weapon) {
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");
  trap endon("\x1e\xfd\xd1\xa2\a");
  trap endon("\a\x9c\xde\xd4\x95\xb1\xa3\xd2\xc6\xac\xeb\x96\xb5\a\x85\x8d:\xfa,Z");

  if(!isDefined(trap)) {
    return;
  }

  trap.weapon = weapon;
  trap.owner = self;
  trap thread whizby();
  trap thread hitai();
  trap waittill("d\xd9b~\xf2\x9f\x15\x93T\xd1\x04\x1a\x18", stuckto, hitent);
  trap.origin += anglestoup(trap.angles) * -1.5;
  player thread offhands::function_1ddd67f9826838b(trap, weapon, &"hash_2f5dac97704b151a", "\xa3\xfbj\x80xe\xea\x88\b\xbd\x9f~L\vP\x17S\xcf*\t\x0f");
  level.var_af45ebdaefe0c22e = utility::array_add(level.var_af45ebdaefe0c22e, trap);
  level notify("n\xb2w\xaf7o\xd2\xb9+kame\x9c\xd7:9\x85s\xe2\xba\x96\x1b\xb4\x9e+N\xeb:\xc9\x16\x0e");
  trap playSound("j\x03\xe7W\xfeWgk\xd0\x95\xc6\xa0\x0fs\xb6\x15\xb1\x99X\n\xf4\xad\x11}\xff\x9eH\x90\xf5E\xef\fIy!\x0e");
  trap thread traplanded();
}

function private traplanded() {
  trap = self;
  var_2a341968c1f4dec7 = undefined;
  var_77ba6a393d0bdd31 = getaiarrayinradius(trap.origin, 650, "?\xb1\xc0\x9a");

  if(var_77ba6a393d0bdd31.size > 0) {
    var_2a341968c1f4dec7 = var_77ba6a393d0bdd31[0];
  } else {
    allai = getaiarray("?\xb1\xc0\x9a");

    if(allai.size > 0) {
      var_2a341968c1f4dec7 = allai[0];
    }
  }

  closest = 651;
  closestguy = undefined;
  forwardpoint = coordtransform((0, 0, 12), trap.origin, trap.angles);
  navmeshpoint = getclosestpointonnavmesh(forwardpoint, var_2a341968c1f4dec7, undefined, 1);

  if(navmeshpoint[2] > trap.origin[2]) {
    var_4a6589653ff23d7a = forwardpoint - (0, 0, 72);
    navmeshpoint = getclosestpointonnavmesh(var_4a6589653ff23d7a, var_2a341968c1f4dec7, undefined, 1);
  }

  height_adj = max(navmeshpoint[2], self.origin[2] - 72);
  self.var_340e466c3733e571 = (self.origin[0], self.origin[1], height_adj);

  if(getdvarint(@ "hash_969d30c92edd477d", 0) > 0) {
    sphere(trap.origin, 12, (1, 0, 0), 0, 300);
    sphere(navmeshpoint, 15, (0, 1, 0), 0, 300);
  }

  var_975cadba35c0c89a = 0;

  foreach(guy in var_77ba6a393d0bdd31) {
    if(var_975cadba35c0c89a >= 2) {
      waitframe();
      var_975cadba35c0c89a = 0;
    }

    path = guy findpath(guy.origin, navmeshpoint);

    if(path.size >= 2 && distance2dsquared(path[path.size - 1], navmeshpoint) < 144) {
      pathdist = getpathlength(path);

      if(getdvarint(@ "hash_969d30c92edd477d", 0) > 0) {
        print3d(guy.origin + (0, 0, 60), pathdist, (1, 1, 0), 1, 1, 20, 1);
      }

      if(pathdist > 0 && pathdist < closest) {
        closest = pathdist;
        closestguy = guy;
      }
    }

    var_975cadba35c0c89a++;
  }

  if(isDefined(closestguy)) {
    closestguy.var_61954a64f0f570e = 12;
    closestguy.var_bd205cab10879a81 = navmeshpoint;
    closestguy aieventlistenerevent("\x8d\x10%\x06I\xa5\xf3\xb4\xc4\x91\xc0B\v5\xb7}", trap, navmeshpoint);
    event = spawnStruct();
    event.typeorig = "\x8d\x10%\x06I\xa5\xf3\xb4\xc4\x91\xc0B\v5\xb7}";
    event.entity = trap;
    event.receiver = closestguy;
    event.type = "\xc2\x99.K\xdd\x9fBw>]\x8e";
    event.position = trap.origin;
    event.investigate_pos = trap.origin;
    event.look_pos = trap.origin;
    closestguy stealth::function_c966b7ad504723e2(event);

    if(getdvarint(@ "hash_969d30c92edd477d", 0) > 0) {
      print3d(closestguy getEye(), "<dev string:x24>", (1, 1, 0), 1, 1, 20, 1);
    }
  }

  if(!isDefined(closestguy) && getdvarint(@ "hash_969d30c92edd477d", 0) > 0) {
    print3d(trap.origin, "<dev string:x29>", (1, 0, 0), 1, 1, 20, 1);
  }

  trap thread function_81494030540538d9();
  trap thread function_6861129b13cd7803();
  trap thread cleanupwatcher();
}

function private whizby() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("d\xd9b~\xf2\x9f\x15\x93T\xd1\x04\x1a\x18");
  trap = self;
  throwpos = self.origin;

  while(true) {
    wait 0.1;

    if(getdvarint(@ "hash_969d30c92edd477d", 0) > 0) {
      sphere(trap.origin, 8, (1, 0, 0), 0, 15);
    }

    var_77ba6a393d0bdd31 = getaiarrayinradius(trap.origin, 200, "?\xb1\xc0\x9a");

    foreach(guy in var_77ba6a393d0bdd31) {
      if(distance2dsquared(guy.origin, trap.origin) <= 5184) {
        guy aieventlistenerevent("\x9c\xae\x01\x94\xb8\xb5F\xc1\x94\row", trap, throwpos);
      }
    }
  }
}

function private function_81494030540538d9() {
  self endon("\x1e\xfd\xd1\xa2\a");
  wait 1;

  while(true) {
    enemy_list = getaiarrayinradius(self.var_340e466c3733e571, 80, "?\xb1\xc0\x9a");

    foreach(guy in enemy_list) {
      if(!guy utility::ent_flag("w\xc7\xe5\xd8\x84\x87\x9b\xac\xfbGF\x1b\xd4") && guy function_67025198c0e87bd1(self)) {
        trapdetonate();
        return;
      }
    }

    wait 0.25;
  }
}

function private function_6861129b13cd7803() {
  self notify("B\x16\x11 r\x02\x90K\xbd!\xefz\xb2,Px");
  self endon("B\x16\x11 r\x02\x90K\xbd!\xefz\xb2,Px");
  self endon("\x1e\xfd\xd1\xa2\a");
  self setCanDamage(1);
  self.health = 2147483647;
  self.maxhealth = 2147483647;
  self waittill("\fU`\xc0y\x95", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
  trapdetonate();
}

function private playhitfx(traporigin) {
  guy = self;
  var_ccf9426ec6a5903e = guy function_d14ffed505fa7704();
  hitlocationtag = var_ccf9426ec6a5903e[0];
  hitlocationoffset = var_ccf9426ec6a5903e[1];
  fxent = guy utility::function_94c66bbed3da2a18();
  fxorigin = guy gettagorigin(hitlocationtag);
  fxdirvec = vectorNormalize(fxorigin - traporigin);
  fxangles = vectortoangles(fxdirvec);
  fxent.origin = fxorigin + fxdirvec * hitlocationoffset;
  fxent.angles = fxangles;
  fxent linkTo(guy, hitlocationtag);
  playFXOnTag(level.g_effect["\xb5\xf3q\xaa\x12\xfe@z?\x82G\xf5\v\xb8l\x1d"], fxent, "\xec\xbfK|\au\xcd\xc2\x19<");
  corpseentnum = guy getentitynumber();
  var_149c063f98e257f2 = 5;
  msg = utility::waittill_notify_or_timeout_return("\xc4\x956{m+\xd7\xd8\xdeN\x0ene", var_149c063f98e257f2);

  if(msg == "\xc4\x956{m+\xd7\xd8\xdeN\x0ene") {
    corpse = getentbynum(corpseentnum);

    if(isactorcorpse(corpse)) {
      linger_time = 10;
      corpse utility::waittill_notify_or_timeout("\x1e\xfd\xd1\xa2\a", linger_time);
    }
  }

  fxent delete();
}

function private trapdetonate() {
  self notify("\x9f1WlM\xc2U\xd5XZ\x91\x10\xf5\x0f\xf7\xd2,@");
  waitframe();
  trap = self;

  if(getdvarint(@ "hash_969d30c92edd477d", 0) > 0) {
    sphere(trap.origin, 100, (0.8, 0, 0), 0, 20);
  }

  snd::play("V\xb8p\xbe\xe6\xbdZnY\xda\x85[\xb2r\xeb\xd19\v\xcdq\xaei\x8dK\xf4V'\xfa\xc2l:\xa5\xd9\v:\xb2", trap.origin);
  playFX(level.g_effect["[t\xdb<=V\xb5\xc3\x18U^\xd5@}X\x85w\x1d\xefH\x96}"], trap.origin, anglesToForward(trap.angles), anglestoup(trap.angles));
  allai = getaiarrayinradius(self.var_340e466c3733e571, 100);

  foreach(guy in allai) {
    if(guy function_67025198c0e87bd1(trap)) {
      guy thread playhitfx(trap.origin);
      guy.lastattacker = trap.owner;

      if(guy function_c763e4827a831226()) {
        guy dodamage(1, trap.origin, trap.owner, trap);
        continue;
      }

      if(guy.team != "O\x15\x1b\xad\x9ff") {
        guy.diequietly = 1;
        guy.allowlongdeath = 0;
        guy shared::dropallaiweapons();
        guy setragdollnobloodpoolfx(1);
      }

      guy dodamage(guy.health, trap.origin, trap.owner, trap, undefined, trap.weapon);
    }
  }

  trap cursor_hint::remove_cursor_hint();
  trap delete();
}

function private function_67025198c0e87bd1(trap) {
  targetguy = self;
  sourceorigin = trap.origin + anglestoup(trap.angles) * 6;
  targetorigin = targetguy gettagorigin("\x13'$\xc4\xf8l\x16\xdf");

  if(getdvarint(@ "hash_969d30c92edd477d", 0) > 0) {
    line(sourceorigin, targetorigin, (0, 1, 0), 1, 0, 200);
  }

  result = trace::ray_trace(sourceorigin, targetorigin);

  if(result["\x06\xfb\xa6\n]\xf5\xc0@"] == 0 || isDefined(result["\x1f\xa8\x10WP\xa9"]) && result["\x1f\xa8\x10WP\xa9"] == targetguy) {
    return true;
  }

  return false;
}

function private function_d14ffed505fa7704() {
  tags = ["\xa6\xeb\x1ae\x85#", "$\x9b\xd1\xd1(A\x8c@f\x80\xf6\xfd", "\x13'$\xc4\xf8l\x16\xdf", "\xc1F\"to\x9c\xd8\x9c\x1c", "\xb0\xe1)\x0e\xbe\xf5\x9c\xed\xb4"];
  offsets = [-3, -7.5, -7.5, -3, -3];
  index = randomint(tags.size);
  return [tags[index], offsets[index]];
}

function private function_c763e4827a831226() {
  return istrue(self.enablehealthbar);
}

function private cleanupwatcher() {
  trap = self;
  trap waittill("\x1e\xfd\xd1\xa2\a");
  level.var_af45ebdaefe0c22e = arrayremove(level.var_af45ebdaefe0c22e, trap);
}

function private getpathlength(path) {
  totallength = 0;

  for(i = 0; i < path.size - 1; i++) {
    totallength += distance(path[i], path[i + 1]);
  }

  return totallength;
}
/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\utility.gsc
********************************/

#using_animtree("generic_human");

initanimtree(var_0) {
  self clearanim( % body, 0.3);
  self setanim( % body, 1, 0);

  if(var_0 != "pain" && var_0 != "death")
    self.a.special = "none";

  self.a.aimweight = 1.0;
  self.a.aimweight_start = 1.0;
  self.a.aimweight_end = 1.0;
  self.a.aimweight_transframes = 0;
  self.a.aimweight_t = 0;
  updateisincombattimer();
}

updateanimpose() {
  if(isdefined(self.desired_anim_pose) && self.desired_anim_pose != self.a.pose) {
    if(self.a.pose == "prone")
      exitpronewrapper(0.5);

    if(self.desired_anim_pose == "prone") {
      self setproneanimnodes(-45, 45, % prone_legs_down, % exposed_aiming, % prone_legs_up);
      enterpronewrapper(0.5);
      self setanimknoball(lookupanim("default_prone", "straight_level"), % body, 1, 0.1, 1);
    }
  }

  self.desired_anim_pose = undefined;
}

initialize(var_0) {
  if(isdefined(self.longdeathstarting)) {
    if(var_0 != "pain" && var_0 != "death")
      self kill(self.origin);

    if(var_0 != "pain") {
      self.longdeathstarting = undefined;
      self notify("kill_long_death");
    }
  }

  if(isdefined(self.a.mayonlydie) && var_0 != "death")
    self kill(self.origin);

  if(isdefined(self.a.postscriptfunc)) {
    var_1 = self.a.postscriptfunc;
    self.a.postscriptfunc = undefined;
    [
      [var_1]
    ](var_0);
  }

  if(var_0 != "combat" && var_0 != "pain" && var_0 != "death" && usingsidearm())
    animscripts\combat::switchtolastweapon(lookupanim("combat", "pistol_to_primary"), 1);

  if(var_0 != "combat" && var_0 != "move" && var_0 != "pain")
    self.a.magicreloadwhenreachenemy = undefined;

  if(var_0 != "death")
    self.a.nodeath = 0;

  if(isdefined(self.isholdinggrenade) && (var_0 == "pain" || var_0 == "death" || var_0 == "flashed"))
    animscripts\combat_utility::dropgrenade();

  self.isholdinggrenade = undefined;
  animscripts\squadmanager::aiupdateanimstate(var_0);
  self.covernode = undefined;
  self.suppressed = 0;
  self.isreloading = 0;
  self.changingcoverpos = 0;
  self.a.aimidlethread = undefined;
  self.a.scriptstarttime = gettime();
  self.a.atconcealmentnode = 0;

  if(isdefined(self.node) && (self.node.type == "Conceal Prone" || self.node.type == "Conceal Crouch" || self.node.type == "Conceal Stand"))
    self.a.atconcealmentnode = 1;

  initanimtree(var_0);
  updateanimpose();
}

getpreferredweapon() {
  if(isdefined(self.wantshotgun) && self.wantshotgun) {
    if(isshotgun(self.primaryweapon))
      return self.primaryweapon;
    else if(isshotgun(self.secondaryweapon))
      return self.secondaryweapon;
  }

  return self.primaryweapon;
}

badplacer(var_0, var_1, var_2) {
  for (var_3 = 0; var_3 < var_0 * 20; var_3++) {
    for (var_4 = 0; var_4 < 10; var_4++) {
      var_5 = (0, randomint(360), 0);
      var_6 = anglestoforward(var_5);
      var_7 = var_6 * var_2;
    }

    wait 0.05;
  }
}

printdisplaceinfo() {
  self endon("death");
  self notify("displaceprint");
  self endon("displaceprint");

  for (;;)
    wait 0.05;
}

isincombat(var_0) {
  if(isdefined(self.enemy))
    return 1;

  return self.a.combatendtime > gettime();
}

updateisincombattimer() {
  if(isdefined(self.enemy))
    self.a.combatendtime = gettime() + anim.combatmemorytimeconst + randomint(anim.combatmemorytimerand);
}

getenemyeyepos() {
  if(isdefined(self.enemy)) {
    if(common_scripts\utility::flag("_cloaked_stealth_enabled"))
      self.a.lastenemypos = animscripts\combat_utility::get_last_known_shoot_pos(self.enemy);
    else
      self.a.lastenemypos = self.enemy getshootatpos();

    self.a.lastenemytime = gettime();
    return self.a.lastenemypos;
  } else if(isdefined(self.a.lastenemytime) && isdefined(self.a.lastenemypos) && self.a.lastenemytime + 3000 < gettime())
    return self.a.lastenemypos;
  else {
    var_0 = self getshootatpos();
    var_0 = var_0 + (196 * self.lookforward[0], 196 * self.lookforward[1], 196 * self.lookforward[2]);
    return var_0;
  }
}

getnodeforwardyaw(var_0) {
  if(!isdefined(self.heat)) {
    if(isnodecoverleft(var_0))
      return var_0.angles[1] + 90;
    else if(isnodecoverright(var_0))
      return var_0.angles[1] - 90;
    else if(var_0.type == "Cover Multi") {
      if(isdefined(self.cover) && isdefined(self.cover.state)) {
        if(self.cover.state == "right")
          return var_0.angles[1] - 90;
        else if(self.cover.state == "left")
          return var_0.angles[1] + 90;
      }
    }
  }

  return var_0.angles[1];
}

getnodeyawtoorigin(var_0) {
  if(isdefined(self.node))
    var_1 = self.node.angles[1] - getyaw(var_0);
  else
    var_1 = self.angles[1] - getyaw(var_0);

  var_1 = angleclamp180(var_1);
  return var_1;
}

getnodeyawtoenemy() {
  var_0 = undefined;

  if(isdefined(self.enemy))
    var_0 = self.enemy.origin;
  else {
    if(isdefined(self.node))
      var_1 = anglestoforward(self.node.angles);
    else
      var_1 = anglestoforward(self.angles);

    var_1 = var_1 * 150;
    var_0 = self.origin + var_1;
  }

  if(isdefined(self.node))
    var_2 = self.node.angles[1] - getyaw(var_0);
  else
    var_2 = self.angles[1] - getyaw(var_0);

  var_2 = angleclamp180(var_2);
  return var_2;
}

getyawtospot(var_0) {
  if(isspaceai()) {
    var_1 = anglestoforward(self.angles);
    var_2 = rotatepointaroundvector(var_1, var_0 - self.origin, self.angles[2] * -1);
    var_0 = var_2 + self.origin;
  }

  var_3 = self.angles[1] - getyaw(var_0);
  var_3 = angleclamp180(var_3);
  return var_3;
}

getyawtoenemy() {
  var_0 = undefined;

  if(isdefined(self.enemy))
    var_0 = self.enemy.origin;
  else {
    var_1 = anglestoforward(self.angles);
    var_1 = var_1 * 150;
    var_0 = self.origin + var_1;
  }

  var_2 = self.angles[1] - getyaw(var_0);
  var_2 = angleclamp180(var_2);
  return var_2;
}

getyaw(var_0) {
  return vectortoyaw(var_0 - self.origin);
}

getyaw2d(var_0) {
  var_1 = vectortoangles((var_0[0], var_0[1], 0) - (self.origin[0], self.origin[1], 0));
  return var_1[1];
}

absyawtoenemy() {
  var_0 = self.angles[1] - getyaw(self.enemy.origin);
  var_0 = angleclamp180(var_0);

  if(var_0 < 0)
    var_0 = -1 * var_0;

  return var_0;
}

absyawtoenemy2d() {
  var_0 = self.angles[1] - getyaw2d(self.enemy.origin);
  var_0 = angleclamp180(var_0);

  if(var_0 < 0)
    var_0 = -1 * var_0;

  return var_0;
}

absyawtoorigin(var_0) {
  var_1 = self.angles[1] - getyaw(var_0);
  var_1 = angleclamp180(var_1);

  if(var_1 < 0)
    var_1 = -1 * var_1;

  return var_1;
}

absyawtoangles(var_0) {
  var_1 = self.angles[1] - var_0;
  var_1 = angleclamp180(var_1);

  if(var_1 < 0)
    var_1 = -1 * var_1;

  return var_1;
}

getyawfromorigin(var_0, var_1) {
  var_2 = vectortoangles(var_0 - var_1);
  return var_2[1];
}

getyawtotag(var_0, var_1) {
  var_2 = self gettagangles(var_0)[1] - getyawfromorigin(var_1, self gettagorigin(var_0));
  var_2 = angleclamp180(var_2);
  return var_2;
}

getyawtoorigin(var_0) {
  if(isdefined(self.type) && (self.type == "Cover Up 3D" || self.type == "Cover Left 3D" || self.type == "Cover Right 3D" || self.type == "Exposed 3D")) {
    var_1 = gettruenodeangles(self);
    var_2 = anglestoforward(var_1);
    var_3 = rotatepointaroundvector(var_2, var_0 - self.origin, var_1[2] * -1);
    var_3 = var_3 + self.origin;
    var_4 = var_1[1] - getyaw(var_3);
    var_4 = angleclamp180(var_4);
    return var_4;
  }

  var_4 = self.angles[1] - getyaw(var_0);
  var_4 = angleclamp180(var_4);
  return var_4;
}

geteyeyawtoorigin(var_0) {
  var_1 = self gettagangles("TAG_EYE")[1] - getyaw(var_0);
  var_1 = angleclamp180(var_1);
  return var_1;
}

isstanceallowedwrapper(var_0) {
  if(isdefined(self.covernode))
    return self.covernode doesnodeallowstance(var_0);

  return self isstanceallowed(var_0);
}

choosepose(var_0) {
  if(!isdefined(var_0))
    var_0 = self.a.pose;

  switch (var_0) {
    case "stand":
      if(isstanceallowedwrapper("stand"))
        var_1 = "stand";
      else if(isstanceallowedwrapper("crouch"))
        var_1 = "crouch";
      else if(isstanceallowedwrapper("prone"))
        var_1 = "prone";
      else
        var_1 = "stand";

      break;
    case "crouch":
      if(isstanceallowedwrapper("crouch"))
        var_1 = "crouch";
      else if(isstanceallowedwrapper("stand"))
        var_1 = "stand";
      else if(isstanceallowedwrapper("prone"))
        var_1 = "prone";
      else
        var_1 = "crouch";

      break;
    case "prone":
      if(isstanceallowedwrapper("prone"))
        var_1 = "prone";
      else if(isstanceallowedwrapper("crouch"))
        var_1 = "crouch";
      else if(isstanceallowedwrapper("stand"))
        var_1 = "stand";
      else
        var_1 = "prone";

      break;
    default:
      var_1 = "stand";
      break;
  }

  return var_1;
}

getclaimednode() {
  var_0 = self.node;

  if(isdefined(var_0) && (self nearnode(var_0) || isdefined(self.covernode) && var_0 == self.covernode))
    return var_0;

  return undefined;
}

getnodetype() {
  var_0 = getclaimednode();

  if(isdefined(var_0))
    return var_0.type;

  return "none";
}

getnodedirection() {
  var_0 = getclaimednode();

  if(isdefined(var_0))
    return var_0.angles[1];

  return self.desiredangle;
}

getnodeforward() {
  var_0 = getclaimednode();

  if(isdefined(var_0))
    return anglestoforward(var_0.angles);

  return anglestoforward(self.angles);
}

getnodeorigin() {
  var_0 = getclaimednode();

  if(isdefined(var_0))
    return var_0.origin;

  return self.origin;
}

safemod(var_0, var_1) {
  var_2 = int(var_0) % var_1;
  var_2 = var_2 + var_1;
  return var_2 % var_1;
}

absangleclamp180(var_0) {
  return abs(angleclamp180(var_0));
}

quadrantanimweights(var_0) {
  var_1 = cos(var_0);
  var_2 = sin(var_0);
  var_3["front"] = 0;
  var_3["right"] = 0;
  var_3["back"] = 0;
  var_3["left"] = 0;

  if(isdefined(self.alwaysrunforward)) {
    var_3["front"] = 1;
    return var_3;
  }

  if(var_1 > 0) {
    if(var_2 > var_1)
      var_3["left"] = 1;
    else if(var_2 < -1 * var_1)
      var_3["right"] = 1;
    else
      var_3["front"] = 1;
  } else {
    var_4 = -1 * var_1;

    if(var_2 > var_4)
      var_3["left"] = 1;
    else if(var_2 < var_1)
      var_3["right"] = 1;
    else
      var_3["back"] = 1;
  }

  return var_3;
}

getquadrant(var_0) {
  var_0 = angleclamp(var_0);

  if(var_0 < 45 || var_0 > 315)
    var_1 = "front";
  else if(var_0 < 135)
    var_1 = "left";
  else if(var_0 < 225)
    var_1 = "back";
  else
    var_1 = "right";

  return var_1;
}

isinset(var_0, var_1) {
  for (var_2 = var_1.size - 1; var_2 >= 0; var_2--) {
    if(var_0 == var_1[var_2])
      return 1;
  }

  return 0;
}

playanim(var_0) {
  if(isdefined(var_0)) {
    self setflaggedanimknoballrestart("playAnim", var_0, % animscript_root, 1, 0.1, 1);
    var_1 = getanimlength(var_0);
    var_1 = 3 * var_1 + 1;
    thread notifyaftertime("time is up", "time is up", var_1);
    self waittill("time is up");
    self notify("enddrawstring");
  }
}

notifyaftertime(var_0, var_1, var_2) {
  self endon("death");
  self endon(var_1);
  wait(var_2);
  self notify(var_0);
}

drawstring(var_0) {
  self endon("killanimscript");
  self endon("enddrawstring");

  for (;;)
    wait 0.05;
}

drawstringtime(var_0, var_1, var_2, var_3) {
  var_4 = var_3 * 20;

  for (var_5 = 0; var_5 < var_4; var_5++)
    wait 0.05;
}

showlastenemysightpos(var_0) {
  self notify("got known enemy2");
  self endon("got known enemy2");
  self endon("death");

  if(!isdefined(self.enemy)) {
    return;
  }
  if(self.enemy.team == "allies")
    var_1 = (0.4, 0.7, 1);
  else
    var_1 = (1, 0.7, 0.4);

  for (;;) {
    wait 0.05;

    if(!isdefined(self.lastenemysightpos))
      continue;
  }
}

hasenemysightpos() {
  if(isdefined(self.node))
    return canseeenemyfromexposed() || cansuppressenemyfromexposed();
  else
    return canseeenemy() || cansuppressenemy();
}

getenemysightpos() {
  return self.goodshootpos;
}

util_ignorecurrentsightpos() {
  if(!hasenemysightpos()) {
    return;
  }
  self.ignoresightpos = getenemysightpos();
  self.ignoreorigin = self.origin;
}

util_evaluateknownenemylocation() {
  if(!hasenemysightpos())
    return 0;

  var_0 = self getmuzzlepos();
  var_1 = self getshootatpos() - var_0;

  if(isdefined(self.ignoresightpos) && isdefined(self.ignoreorigin)) {
    if(distance(self.origin, self.ignoreorigin) < 25)
      return 0;
  }

  self.ignoresightpos = undefined;
  var_2 = self canshoot(getenemysightpos(), var_1);

  if(!var_2) {
    self.ignoresightpos = getenemysightpos();
    return 0;
  }

  return 1;
}

debugtimeout() {
  wait 5;
  self notify("timeout");
}

debugposinternal(var_0, var_1, var_2) {
  self endon("death");
  self notify("stop debug " + var_0);
  self endon("stop debug " + var_0);
  var_3 = spawnstruct();
  var_3 thread debugtimeout();
  var_3 endon("timeout");

  if(self.enemy.team == "allies")
    var_4 = (0.4, 0.7, 1);
  else
    var_4 = (1, 0.7, 0.4);

  for (;;)
    wait 0.05;
}

debugpos(var_0, var_1) {
  thread debugposinternal(var_0, var_1, 2.15);
}

debugpossize(var_0, var_1, var_2) {
  thread debugposinternal(var_0, var_1, var_2);
}

debugburstprint(var_0, var_1) {
  var_2 = var_0 / var_1;
  var_3 = undefined;

  if(var_0 == self.bulletsinclip)
    var_3 = "all rounds";
  else if(var_2 < 0.25)
    var_3 = "small burst";
  else if(var_2 < 0.5)
    var_3 = "med burst";
  else
    var_3 = "long burst";

  thread debugpossize(self.origin + (0, 0, 42), var_3, 1.5);
  thread debugpos(self.origin + (0, 0, 60), "Suppressing");
}

printshootproc() {
  self endon("death");
  self notify("stop shoot " + self.export);
  self endon("stop shoot " + self.export);
  var_0 = 0.25;
  var_1 = var_0 * 20;

  for (var_2 = 0; var_2 < var_1; var_2 = var_2 + 1)
    wait 0.05;
}

printshoot() {}

showdebugproc(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_4 = var_3 * 20;

  for (var_5 = 0; var_5 < var_4; var_5 = var_5 + 1)
    wait 0.05;
}

showdebugline(var_0, var_1, var_2, var_3) {
  thread showdebugproc(var_0, var_1 + (0, 0, -5), var_2, var_3);
}

shootenemywrapper(var_0) {
  if(!isdefined(var_0))
    var_0 = 1;

  [[anim.shootenemywrapper_func]](var_0);
}

shootenemywrapper_normal(var_0) {
  self.a.lastshoottime = gettime();
  maps\_gameskill::set_accuracy_based_on_situation();
  self notify("shooting");
  self shoot(1, undefined, var_0);
}

shootenemywrapper_shootnotify(var_0) {
  level notify("an_enemy_shot", self);
  shootenemywrapper_normal(var_0);
}

shootposwrapper(var_0, var_1) {
  var_2 = bulletspread(self getmuzzlepos(), var_0, 4);
  self.a.lastshoottime = gettime();

  if(!isdefined(var_1))
    var_1 = 1;

  self notify("shooting");
  self shoot(1, var_2, var_1);
}

throwgun() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setmodel("temp");
  var_0.origin = self gettagorigin("tag_weapon_right") + (50, 50, 0);
  var_0.angles = self gettagangles("tag_weapon_right");
  var_1 = anglestoright(var_0.angles);
  var_1 = var_1 * 15;
  var_2 = anglestoforward(var_0.angles);
  var_2 = var_2 * 15;
  var_0 movegravity((0, 50, 150), 100);
  var_3 = "weapon_" + self.weapon;
  var_4 = spawn(var_3, var_0.origin);
  var_4.angles = self gettagangles("tag_weapon_right");
  var_4 linkto(var_0);
  var_5 = var_0.origin;

  while (isdefined(var_4) && isdefined(var_4.origin)) {
    var_6 = var_5;
    var_7 = var_0.origin;
    var_8 = vectortoangles(var_7 - var_6);
    var_2 = anglestoforward(var_8);
    var_2 = var_2 * 4;
    var_9 = bullettrace(var_7, var_7 + var_2, 1, var_4);

    if(isalive(var_9["entity"]) && var_9["entity"] == self) {
      wait 0.05;
      continue;
    }

    if(var_9["fraction"] < 1.0) {
      break;
    }

    var_5 = var_0.origin;
    wait 0.05;
  }

  if(isdefined(var_4) && isdefined(var_4.origin))
    var_4 unlink();

  var_0 delete();
}

personalcoldbreath() {
  var_0 = "TAG_EYE";
  self endon("death");
  self notify("stop personal effect");
  self endon("stop personal effect");

  while (isdefined(self)) {
    wait 0.05;

    if(!isdefined(self)) {
      break;
    }

    if(isdefined(self.a.movement) && self.a.movement == "stop") {
      if(isdefined(self.isindoor) && self.isindoor == 1) {
        continue;
      }
      playfxontag(level._effect["cold_breath"], self, var_0);
      wait(2.5 + randomfloat(3));
      continue;
    }

    wait 0.5;
  }
}

personalcoldbreathstop() {
  self notify("stop personal effect");
}

personalcoldbreathspawner() {
  self endon("death");
  self notify("stop personal effect");
  self endon("stop personal effect");

  for (;;) {
    self waittill("spawned", var_0);

    if(maps\_utility::spawn_failed(var_0)) {
      continue;
    }
    var_0 thread personalcoldbreath();
  }
}

issuppressedwrapper() {
  if(isdefined(self.forcesuppression))
    return self.forcesuppression;

  if(self.suppressionmeter <= self.suppressionthreshold)
    return 0;

  return self issuppressed();
}

isspaceai() {
  return isdefined(self.swimmer) && self.swimmer == 1 && (isdefined(self.space) && self.space == 1);
}

gettruenodeangles(var_0) {
  if(!isdefined(var_0))
    return (0, 0, 0);

  if(!isdefined(var_0.script_angles))
    return var_0.angles;

  var_1 = var_0.angles;
  var_2 = angleclamp180(var_1[0] + var_0.script_angles[0]);
  var_3 = var_1[1];
  var_4 = angleclamp180(var_1[2] + var_0.script_angles[2]);
  return (var_2, var_3, var_4);
}

ispartiallysuppressedwrapper() {
  if(self.suppressionmeter <= self.suppressionthreshold * 0.25)
    return 0;

  return self issuppressed();
}

getnodeoffset(var_0, var_1) {
  if(isdefined(var_0.offset))
    return var_0.offset;

  var_2 = (-26, 0.4, 36);
  var_3 = (-32, 7, 63);
  var_4 = (43.5, 11, 36);
  var_5 = (36, 8.3, 63);
  var_6 = (3.5, -12.5, 45);
  var_7 = (-3.7, -22, 63);
  var_8 = 0;
  var_9 = (0, 0, 0);
  var_10 = anglestoright(var_0.angles);
  var_11 = anglestoforward(var_0.angles);

  if(!isdefined(var_1)) {
    var_1 = var_0.type;

    if(var_1 == "Cover Multi")
      var_1 = getcovermultipretendtype(var_0);
  }

  switch (var_1) {
    case "Cover Left":
    case "Cover Left 3D":
      if(var_0 gethighestnodestance() == "crouch")
        var_9 = calculatenodeoffset(var_10, var_11, var_2);
      else
        var_9 = calculatenodeoffset(var_10, var_11, var_3);

      break;
    case "Cover Right":
    case "Cover Right 3D":
      if(var_0 gethighestnodestance() == "crouch")
        var_9 = calculatenodeoffset(var_10, var_11, var_4);
      else
        var_9 = calculatenodeoffset(var_10, var_11, var_5);

      break;
    case "Turret":
    case "Cover Stand":
    case "Conceal Stand":
      var_9 = calculatenodeoffset(var_10, var_11, var_7);
      break;
    case "Cover Crouch Window":
    case "Cover Crouch":
    case "Conceal Crouch":
      var_9 = calculatenodeoffset(var_10, var_11, var_6);
      break;
  }

  var_0.offset = var_9;
  return var_0.offset;
}

calculatenodeoffset(var_0, var_1, var_2) {
  return var_0 * var_2[0] + var_1 * var_2[1] + (0, 0, var_2[2]);
}

recentlysawenemy() {
  return isdefined(self.enemy) && self seerecently(self.enemy, 5);
}

canseeenemy(var_0) {
  if(!isdefined(self.enemy))
    return 0;

  if(common_scripts\utility::flag("_cloaked_stealth_enabled")) {
    if(isdefined(self.enemy_who_surprised_me) && self.enemy_who_surprised_me == self.enemy)
      return 1;
    else
      return self cansee(self.enemy);
  }

  if(isdefined(var_0) && self cansee(self.enemy, var_0) || self cansee(self.enemy)) {
    if(!checkpitchvisibility(self geteye(), self.enemy getshootatpos()))
      return 0;

    self.goodshootpos = getenemyeyepos();
    dontgiveuponsuppressionyet();
    return 1;
  }

  return 0;
}

canseeenemyfromexposed() {
  if(!isdefined(self.enemy)) {
    self.goodshootpos = undefined;
    return 0;
  }

  var_0 = getenemyeyepos();

  if(!isdefined(self.node))
    var_1 = self cansee(self.enemy);
  else
    var_1 = canseepointfromexposedatnode(var_0, self.node);

  if(var_1) {
    self.goodshootpos = var_0;
    dontgiveuponsuppressionyet();
  } else {}

  return var_1;
}

canseepointfromexposedatnode(var_0, var_1) {
  if(isnodecoverleft(var_1) || isnodecoverright(var_1) || isnodecovermulticorner(var_1)) {
    if(!animscripts\corner::canseepointfromexposedatcorner(var_0, var_1))
      return 0;
  }

  var_2 = getnodeoffset(var_1);
  var_3 = var_1.origin + var_2;

  if(!checkpitchvisibility(var_3, var_0, var_1))
    return 0;

  if(!sighttracepassed(var_3, var_0, 0, undefined)) {
    if(var_1.type == "Cover Crouch" || var_1.type == "Conceal Crouch") {
      var_3 = (0, 0, 64) + var_1.origin;
      return sighttracepassed(var_3, var_0, 0, undefined);
    }

    if(isspaceai() && var_1.type == "Cover Up 3D") {
      var_4 = anglestoup(self.angles);
      var_3 = var_1.origin + (var_4[0] * 32, var_4[1] * 32, var_4[2] * 32);
      return sighttracepassed(var_3, var_0, 0, undefined);
    }

    return 0;
  }

  return 1;
}

isnodecovermulticorner(var_0) {
  if(var_0.type != "Cover Multi")
    return 0;

  if(!isdefined(self.cover))
    return 0;

  if(isdefined(self.cover.state))
    return self.cover.state == "right" || self.cover.state == "left";

  if(isdefined(self.cover.arrivalnodetype))
    return self.cover.arrivalnodetype == "right" || self.cover.arrivalnodetype == "left";

  return 0;
}

getcovermultipretendtype(var_0, var_1) {
  if(!isdefined(var_1))
    var_1 = var_0 animscripts\cover_multi::covermulti_getnonrandomvaliddir();

  switch (var_1) {
    case "right":
      return "Cover Right";
    case "left":
      return "Cover Left";
    case "stand":
      return "Cover Stand";
    case "crouch":
      return "Cover Crouch";
    default:
  }
}

checkpitchvisibility(var_0, var_1, var_2) {
  var_3 = self.downaimlimit - anim.aimpitchdifftolerance;
  var_4 = self.upaimlimit + anim.aimpitchdifftolerance;
  var_5 = angleclamp180(vectortoangles(var_1 - var_0)[0]);

  if(var_5 > var_4)
    return 0;

  if(var_5 < var_3) {
    if(isdefined(var_2) && var_2.type != "Cover Crouch" && var_2.type != "Conceal Crouch")
      return 0;

    if(var_5 < anim.covercrouchleanpitch + var_3)
      return 0;
  }

  return 1;
}

dontgiveuponsuppressionyet() {
  self.a.shouldresetgiveuponsuppressiontimer = 1;
}

updategiveuponsuppressiontimer() {
  if(!isdefined(self.a.shouldresetgiveuponsuppressiontimer))
    self.a.shouldresetgiveuponsuppressiontimer = 1;

  if(self.a.shouldresetgiveuponsuppressiontimer) {
    self.a.giveuponsuppressiontime = gettime() + randomintrange(15000, 30000);
    self.a.shouldresetgiveuponsuppressiontimer = 0;
  }
}

showlines(var_0, var_1, var_2) {
  for (;;) {
    wait 0.05;
    wait 0.05;
  }
}

aisuppressai() {
  if(!self canattackenemynode())
    return 0;

  var_0 = undefined;

  if(isdefined(self.enemy.node)) {
    var_1 = getnodeoffset(self.enemy.node);
    var_0 = self.enemy.node.origin + var_1;
  } else if(common_scripts\utility::flag("_cloaked_stealth_enabled"))
    var_0 = animscripts\combat_utility::get_last_known_shoot_pos(self.enemy);
  else
    var_0 = self.enemy getshootatpos();

  if(!self canshoot(var_0))
    return 0;

  if(self.script == "combat") {
    if(!sighttracepassed(self geteye(), self getmuzzlepos(), 0, undefined))
      return 0;
  }

  self.goodshootpos = var_0;
  return 1;
}

cansuppressenemyfromexposed() {
  if(!hassuppressableenemy()) {
    self.goodshootpos = undefined;
    return 0;
  }

  if(!isplayer(self.enemy))
    return aisuppressai();

  if(isdefined(self.node)) {
    if(isnodecoverleft(self.node) || isnodecoverright(self.node)) {
      if(!animscripts\corner::canseepointfromexposedatcorner(getenemyeyepos(), self.node))
        return 0;
    }

    var_0 = getnodeoffset(self.node);
    var_1 = self.node.origin + var_0;
  } else
    var_1 = self getmuzzlepos();

  if(!checkpitchvisibility(var_1, self.lastenemysightpos))
    return 0;

  return findgoodsuppressspot(var_1);
}

cansuppressenemy() {
  if(!hassuppressableenemy()) {
    self.goodshootpos = undefined;
    return 0;
  }

  if(!isplayer(self.enemy))
    return aisuppressai();

  var_0 = self getmuzzlepos();

  if(!checkpitchvisibility(var_0, self.lastenemysightpos))
    return 0;

  return findgoodsuppressspot(var_0);
}

hassuppressableenemy() {
  if(!isdefined(self.enemy))
    return 0;

  if(!isdefined(self.lastenemysightpos))
    return 0;

  updategiveuponsuppressiontimer();

  if(gettime() > self.a.giveuponsuppressiontime)
    return 0;

  if(!needrecalculatesuppressspot())
    return isdefined(self.goodshootpos);

  return 1;
}

canseeandshootpoint(var_0) {
  if(!sighttracepassed(self getshootatpos(), var_0, 0, undefined))
    return 0;

  if(self.a.weaponpos["right"] == "none")
    return 0;

  var_1 = self getmuzzlepos();
  return sighttracepassed(var_1, var_0, 0, undefined);
}

needrecalculatesuppressspot() {
  if(isdefined(self.goodshootpos) && !canseeandshootpoint(self.goodshootpos))
    return 1;

  return !isdefined(self.lastenemysightposold) || self.lastenemysightposold != self.lastenemysightpos || distancesquared(self.lastenemysightposselforigin, self.origin) > 1024;
}

findgoodsuppressspot(var_0) {
  if(!needrecalculatesuppressspot())
    return isdefined(self.goodshootpos);

  if(isdefined(self.enemy) && distancesquared(self.origin, self.enemy.origin) > squared(self.enemy.maxvisibledist)) {
    self.goodshootpos = undefined;
    return 0;
  }

  if(!sighttracepassed(self getshootatpos(), var_0, 0, undefined)) {
    self.goodshootpos = undefined;
    return 0;
  }

  self.lastenemysightposselforigin = self.origin;
  self.lastenemysightposold = self.lastenemysightpos;
  var_1 = getenemyeyepos();
  var_2 = bullettrace(self.lastenemysightpos, var_1, 0, undefined);
  var_3 = var_2["position"];
  var_4 = self.lastenemysightpos - var_3;
  var_5 = vectornormalize(self.lastenemysightpos - var_0);
  var_4 = var_4 - var_5 * vectordot(var_4, var_5);
  var_6 = 20.0;
  var_7 = int(length(var_4) / var_6 + 0.5);

  if(var_7 < 1)
    var_7 = 1;

  if(var_7 > 20)
    var_7 = 20;

  var_8 = self.lastenemysightpos - var_3;
  var_8 = (var_8[0] / var_7, var_8[1] / var_7, var_8[2] / var_7);
  var_7++;
  var_9 = var_3;
  self.goodshootpos = undefined;
  var_10 = 0;
  var_11 = 2;

  for (var_12 = 0; var_12 < var_7 + var_11; var_12++) {
    var_13 = sighttracepassed(var_0, var_9, 0, undefined);
    var_14 = var_9;

    if(var_12 == var_7 - 1)
      var_8 = var_8 - var_5 * vectordot(var_8, var_5);

    var_9 = var_9 + var_8;

    if(var_13) {
      var_10++;
      self.goodshootpos = var_14;

      if(var_12 > 0 && var_10 < var_11 && var_12 < var_7 + var_11 - 1) {
        continue;
      }
      return 1;
    } else
      var_10 = 0;
  }

  return isdefined(self.goodshootpos);
}

anim_array(var_0, var_1) {
  var_2 = var_0.size;
  var_3 = randomint(var_2);

  if(var_2 == 1)
    return var_0[0];

  var_4 = 0;
  var_5 = 0;

  for (var_6 = 0; var_6 < var_2; var_6++)
    var_5 = var_5 + var_1[var_6];

  var_7 = randomfloat(var_5);
  var_8 = 0;

  for (var_6 = 0; var_6 < var_2; var_6++) {
    var_8 = var_8 + var_1[var_6];

    if(var_7 >= var_8) {
      continue;
    }
    var_3 = var_6;
    break;
  }

  return var_0[var_3];
}

print3dtime(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_0 / 0.05;

  for (var_7 = 0; var_7 < var_6; var_7++)
    wait 0.05;
}

print3drise(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 100.0;
  var_6 = 0;
  var_0 = var_0 + common_scripts\utility::randomvector(30);

  for (var_7 = 0; var_7 < var_5; var_7++) {
    var_6 = var_6 + 0.5;
    wait 0.05;
  }
}

crossproduct(var_0, var_1) {
  return var_0[0] * var_1[1] - var_0[1] * var_1[0] > 0;
}

getgrenademodel() {
  return getweaponmodel(self.grenadeweapon);
}

sawenemymove(var_0) {
  if(!isdefined(var_0))
    var_0 = 500;

  return gettime() - self.personalsighttime < var_0;
}

canthrowgrenade() {
  if(!self.grenadeammo)
    return 0;

  if(self.script_forcegrenade)
    return 1;

  return isplayer(self.enemy);
}

usingboltactionweapon() {
  return weaponisboltaction(self.weapon);
}

random_weight(var_0) {
  var_1 = randomint(var_0.size);

  if(var_0.size > 1) {
    var_2 = 0;

    for (var_3 = 0; var_3 < var_0.size; var_3++)
      var_2 = var_2 + var_0[var_3];

    var_4 = randomfloat(var_2);
    var_2 = 0;

    for (var_3 = 0; var_3 < var_0.size; var_3++) {
      var_2 = var_2 + var_0[var_3];

      if(var_4 < var_2) {
        var_1 = var_3;
        break;
      }
    }
  }

  return var_1;
}

setfootstepeffect(var_0, var_1) {
  if(!isdefined(anim.optionalstepeffects))
    anim.optionalstepeffects = [];

  anim.optionalstepeffects[var_0] = 1;
  level._effect["step_" + var_0] = var_1;
}

setfootstepeffectsmall(var_0, var_1) {
  if(!isdefined(anim.optionalstepeffectssmall))
    anim.optionalstepeffectssmall = [];

  anim.optionalstepeffectssmall[var_0] = 1;
  level._effect["step_small_" + var_0] = var_1;
}

unsetfootstepeffect(var_0) {
  if(isdefined(anim.optionalstepeffects))
    anim.optionalstepeffects[var_0] = undefined;

  level._effect["step_" + var_0] = undefined;
}

unsetfootstepeffectsmall(var_0) {
  if(isdefined(anim.optionalstepeffectssmall))
    anim.optionalstepeffectssmall[var_0] = undefined;

  level._effect["step_small_" + var_0] = undefined;
}

setnotetrackeffect(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isdefined(var_2))
    var_2 = "all";

  if(!isdefined(level._notetrackfx))
    level._notetrackfx = [];

  level._notetrackfx[var_0][var_2] = spawnstruct();
  level._notetrackfx[var_0][var_2].tag = var_1;
  level._notetrackfx[var_0][var_2].fx = var_3;
  anim.notetracks[var_0] = animscripts\notetracks::customnotetrackfx;
  setnotetracksound(var_0, var_2, var_4, var_5);
}

setnotetracksound(var_0, var_1, var_2, var_3) {
  if(!isdefined(var_1))
    var_1 = "all";

  if(!isdefined(level._notetrackfx))
    level._notetrackfx = [];

  if(isdefined(level._notetrackfx[var_0][var_1]))
    var_4 = level._notetrackfx[var_0][var_1];
  else {
    var_4 = spawnstruct();
    level._notetrackfx[var_0][var_1] = var_4;
  }

  anim.notetracks[var_0] = animscripts\notetracks::customnotetrackfx;

  if(isdefined(var_2))
    var_4.sound_prefix = var_2;

  if(isdefined(var_3))
    var_4.sound_suffix = var_3;
}

persistentdebugline(var_0, var_1) {
  self endon("death");
  level notify("newdebugline");
  level endon("newdebugline");

  for (;;)
    wait 0.05;
}

enterpronewrapper(var_0) {
  thread enterpronewrapperproc(var_0);
}

enterpronewrapperproc(var_0) {
  self _meth_856F();
  self endon("death");
  self notify("anim_prone_change");
  self endon("anim_prone_change");
  self enterprone(var_0, isdefined(self.a.onback));
  self waittill("killanimscript");

  if(self.a.pose != "prone" && !isdefined(self.a.onback))
    self.a.pose = "prone";
}

exitpronewrapper(var_0) {
  thread exitpronewrapperproc(var_0);
}

exitpronewrapperproc(var_0) {
  self _meth_856E();
  self endon("death");
  self notify("anim_prone_change");
  self endon("anim_prone_change");
  self exitprone(var_0);
  self waittill("killanimscript");

  if(self.a.pose == "prone")
    self.a.pose = "crouch";
}

canblindfire() {
  if(self.a.atconcealmentnode)
    return 0;

  if(!animscripts\weaponlist::usingautomaticweapon())
    return 0;

  if(weaponclass(self.weapon) == "mg")
    return 0;

  if(isdefined(self.disable_blindfire) && self.disable_blindfire == 1)
    return 0;

  return 1;
}

canhitsuppressspot() {
  if(!hasenemysightpos())
    return 0;

  var_0 = self getmuzzlepos();
  return sighttracepassed(var_0, getenemysightpos(), 0, undefined);
}

getmoveanim(var_0) {
  return self.a.moveanimset[var_0];
}

gettwitchanim(var_0) {
  if(isdefined(self.a.lastloopcountfortwitch) && self.a.lastloopcountfortwitch == self.a.runloopcount)
    return self.a.lasttwitchanims;

  var_1 = randomint(var_0.size);
  self.a.lasttwitchanims = var_0[var_1];
  self.a.lastloopcountfortwitch = self.a.runloopcount;
  return var_0[var_1];
}

randomanimoftwo(var_0, var_1) {
  if(randomint(2))
    return var_0;
  else
    return var_1;
}

animarray(var_0) {
  return self.a.array[var_0];
}

animarrayanyexist(var_0) {
  return isdefined(self.a.array[var_0]) && self.a.array[var_0].size > 0;
}

animarraypickrandom(var_0) {
  var_1 = randomint(self.a.array[var_0].size);
  return self.a.array[var_0][var_1];
}

array(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  var_14 = [];

  if(isdefined(var_0))
    var_14[0] = var_0;
  else
    return var_14;

  if(isdefined(var_1))
    var_14[1] = var_1;
  else
    return var_14;

  if(isdefined(var_2))
    var_14[2] = var_2;
  else
    return var_14;

  if(isdefined(var_3))
    var_14[3] = var_3;
  else
    return var_14;

  if(isdefined(var_4))
    var_14[4] = var_4;
  else
    return var_14;

  if(isdefined(var_5))
    var_14[5] = var_5;
  else
    return var_14;

  if(isdefined(var_6))
    var_14[6] = var_6;
  else
    return var_14;

  if(isdefined(var_7))
    var_14[7] = var_7;
  else
    return var_14;

  if(isdefined(var_8))
    var_14[8] = var_8;
  else
    return var_14;

  if(isdefined(var_9))
    var_14[9] = var_9;
  else
    return var_14;

  if(isdefined(var_10))
    var_14[10] = var_10;
  else
    return var_14;

  if(isdefined(var_11))
    var_14[11] = var_11;
  else
    return var_14;

  if(isdefined(var_12))
    var_14[12] = var_12;
  else
    return var_14;

  if(isdefined(var_13))
    var_14[13] = var_13;

  return var_14;
}

getaiprimaryweapon() {
  return self.primaryweapon;
}

getaisecondaryweapon() {
  return self.secondaryweapon;
}

getaisidearmweapon() {
  return self.sidearm;
}

getaicurrentweapon() {
  return self.weapon;
}

usingprimary() {
  return self.weapon == self.primaryweapon && self.weapon != "none";
}

usingsecondary() {
  return self.weapon == self.secondaryweapon && self.weapon != "none";
}

usingsidearm() {
  return self.weapon == self.sidearm && self.weapon != "none";
}

getaicurrentweaponslot() {
  if(self.weapon == self.primaryweapon)
    return "primary";
  else if(self.weapon == self.secondaryweapon)
    return "secondary";
  else if(self.weapon == self.sidearm)
    return "sidearm";
  else {}
}

aihasweapon(var_0) {
  if(isdefined(self.weaponinfo[var_0]))
    return 1;

  return 0;
}

getanimendpos(var_0) {
  var_1 = getmovedelta(var_0, 0, 1);
  return self localtoworldcoords(var_1);
}

damagelocationisany(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isdefined(var_0))
    return 0;

  if(self.damagelocation == var_0)
    return 1;

  if(!isdefined(var_1))
    return 0;

  if(self.damagelocation == var_1)
    return 1;

  if(!isdefined(var_2))
    return 0;

  if(self.damagelocation == var_2)
    return 1;

  if(!isdefined(var_3))
    return 0;

  if(self.damagelocation == var_3)
    return 1;

  if(!isdefined(var_4))
    return 0;

  if(self.damagelocation == var_4)
    return 1;

  if(!isdefined(var_5))
    return 0;

  if(self.damagelocation == var_5)
    return 1;

  if(!isdefined(var_6))
    return 0;

  if(self.damagelocation == var_6)
    return 1;

  if(!isdefined(var_7))
    return 0;

  if(self.damagelocation == var_7)
    return 1;

  if(!isdefined(var_8))
    return 0;

  if(self.damagelocation == var_8)
    return 1;

  if(!isdefined(var_9))
    return 0;

  if(self.damagelocation == var_9)
    return 1;

  if(!isdefined(var_10))
    return 0;

  if(self.damagelocation == var_10)
    return 1;

  return 0;
}

usingpistol() {
  if(!isdefined(self.weapon))
    return 0;

  return weaponclass(self.weapon) == "pistol";
}

usingrocketlauncher() {
  if(!isdefined(self.weapon))
    return 0;

  return weaponclass(self.weapon) == "rocketlauncher";
}

usingmg() {
  if(!isdefined(self.weapon))
    return 0;

  return weaponclass(self.weapon) == "mg";
}

usingshotgun() {
  if(!isdefined(self.weapon))
    return 0;

  return weaponclass(self.weapon) == "spread";
}

usingsmg() {
  if(!isdefined(self.weapon))
    return 0;

  return weaponclass(self.weapon) == "smg";
}

usingriflelikeweapon() {
  if(!isdefined(self.weapon))
    return 0;

  var_0 = weaponclass(self.weapon);

  switch (var_0) {
    case "rifle":
    case "sniper":
    case "smg":
    case "spread":
    case "mg":
      return 1;
  }

  return 0;
}

shoulddroprocketlauncher(var_0) {
  return isdefined(self.secondaryweapon) && self.secondaryweapon != "none" && (var_0 < squared(512) || self.a.rockets < 1);
}

ragdolldeath(var_0) {
  self endon("killanimscript");
  var_1 = self.origin;
  var_2 = (0, 0, 0);

  for (;;) {
    wait 0.05;
    var_3 = distance(self.origin, var_1);
    var_1 = self.origin;

    if(self.health == 1) {
      self.a.nodeath = 1;
      self startragdoll();
      self clearanim(var_0, 0.1);
      wait 0.05;
      physicsexplosionsphere(var_1, 600, 0, var_3 * 0.1);
      self notify("killanimscript");
      return;
    }
  }
}

is_free_running() {
  return isdefined(self.free_running);
}

shouldcqb() {
  return isdefined(self.cqbwalking) && !isdefined(self.grenade);
}

iscqbwalking() {
  return isdefined(self.cqbwalking);
}

is_in_casual_standing_stance() {
  var_0 = [ % casual_stand_idle, % casual_stand_idle_trans_in, % casual_stand_idle_trans_out, % casual_stand_idle_twitch, % casual_stand_idle_twitchb, % casual_stand_v2_idle, % casual_stand_v2_twitch_radio, % casual_stand_v2_twitch_shift, % casual_stand_v2_twitch_talk, % smg_casual_stand_idle_trans_in, % smg_casual_stand_idle_trans_out];

  foreach(var_2 in var_0) {
    if(self getanimweight(var_2) != 0.0)
      return 1;
  }

  return 0;
}

setunstableground(var_0) {
  if(var_0) {
    self.custommoveanimset["run"] = lookupanimarray("unstable_run");
    self.custommoveanimset["walk"] = lookupanimarray("unstable_walk");
    self.isunstableground = 1;
  } else {
    self.custommoveanimset["run"] = undefined;
    self.custommoveanimset["walk"] = undefined;
    self.isunstableground = 0;
  }
}

isunstableground() {
  return isdefined(self.isunstableground);
}

setalwaysusepistol(var_0) {
  if(!isdefined(var_0)) {
    return;
  }
  if(var_0) {
    self.custommoveanimset["run"] = lookupanimarray("pistol_move");
    self.custommoveanimset["walk"] = lookupanimarray("pistol_move");
    self.alwaysusepistol = 1;
    self allowedstances("stand");
    self.no_pistol_switch = 1;
    self.dontshootwhilemoving = 1;
    self.disablebulletwhizbyreaction = 1;
  } else {
    self.custommoveanimset["run"] = undefined;
    self.custommoveanimset["walk"] = undefined;
    self.alwaysusepistol = undefined;
    self allowedstances("stand", "crouch", "prone");
    self.no_pistol_switch = undefined;
    self.dontshootwhilemoving = undefined;
    self.disablebulletwhizbyreaction = undefined;
  }
}

iscqbwalkingorfacingenemy() {
  return !self.facemotion || isdefined(self.cqbwalking);
}

randomizeidleset() {
  self.a.idleset = randomint(2);
}

isshotgun(var_0) {
  return weaponclass(var_0) == "spread";
}

issniperrifle(var_0) {
  return weaponclass(var_0) == "sniper";
}

weapon_pump_action_shotgun() {
  return self.weapon != "none" && weaponisboltaction(self.weapon) && weaponclass(self.weapon) == "spread";
}

getrandomintfromseed(var_0, var_1) {
  var_2 = var_0 % anim.randominttablesize;
  return anim.randominttable[var_2] % var_1;
}

getcurrentweaponslotname() {
  if(usingsecondary())
    return "secondary";

  if(usingsidearm())
    return "sidearm";

  return "primary";
}

isnodecoverleft(var_0) {
  return var_0.type == "Cover Left" || var_0.type == "Cover Left 3D";
}

isnodecoverright(var_0) {
  return var_0.type == "Cover Right" || var_0.type == "Cover Right 3D";
}

isnodecover3d(var_0) {
  return var_0.type == "Cover Left 3D" || var_0.type == "Cover Right 3D" || var_0.type == "Cover Up 3D";
}

lookupanim(var_0, var_1) {
  if(isdefined(anim.forced_s1_motionset) || isdefined(anim.forced_s1_motionset_overided))
    maps\_utility::enable_s1_motionset(1);

  if(isdefined(self.animarchetype)) {
    if(isdefined(anim.archetypes[self.animarchetype][var_0]) && isdefined(anim.archetypes[self.animarchetype][var_0][var_1]))
      return anim.archetypes[self.animarchetype][var_0][var_1];
  }

  return anim.archetypes["soldier"][var_0][var_1];
}

lookupanimarray(var_0) {
  if(isdefined(anim.forced_s1_motionset) || isdefined(anim.forced_s1_motionset_overided))
    maps\_utility::enable_s1_motionset(1);

  if(isdefined(self.animarchetype)) {
    if(isdefined(anim.archetypes[self.animarchetype][var_0])) {
      if(isdefined(anim.archetypes["soldier"][var_0])) {
        var_1 = anim.archetypes["soldier"][var_0];

        foreach(var_4, var_3 in anim.archetypes[self.animarchetype][var_0])
        var_1[var_4] = var_3;

        return var_1;
      }

      return anim.archetypes[self.animarchetype][var_0];
    }
  }

  return anim.archetypes["soldier"][var_0];
}

lookuptransitionanim(var_0, var_1, var_2) {
  if(isdefined(self.animarchetype)) {
    if(isdefined(anim.archetypes[self.animarchetype][var_0]) && isdefined(anim.archetypes[self.animarchetype][var_0][var_1]) && isdefined(anim.archetypes[self.animarchetype][var_0][var_1][var_2]))
      return anim.archetypes[self.animarchetype][var_0][var_1][var_2];

    if(isdefined(anim.archetypes[self.animarchetype][var_0]) && isdefined(anim.archetypes[self.animarchetype][var_0][var_1]))
      return anim.archetypes[self.animarchetype][var_0][var_1];
  }

  return anim.archetypes["soldier"][var_0][var_1][var_2];
}

lookupdoganim(var_0, var_1) {
  if(isdefined(self.animarchetype)) {
    if(isdefined(anim.archetypes[self.animarchetype][var_0]) && isdefined(anim.archetypes[self.animarchetype][var_0][var_1]))
      return anim.archetypes[self.animarchetype][var_0][var_1];
  }

  return anim.archetypes["dog"][var_0][var_1];
}

isdoingpain() {
  if(isdefined(self.a.paintime) && isdefined(self.a.painanimlength)) {
    var_0 = self.a.paintime + self.a.painanimlength * 1000;
    var_1 = gettime() < var_0;

    if(!var_1)
      self.a.painanimlength = 0;

    return var_1;
  }

  return 0;
}

get_trajectory_x_given_time(var_0, var_1, var_2, var_3) {
  return var_0 + var_1 * var_3 + 0.5 * var_2 * squared(var_3);
}

get_trajectory_time_given_x(var_0, var_1, var_2, var_3) {
  if(var_3 == 0) {
    if(var_2 == 0)
      return 999999;

    return (var_1 - var_0) / var_2;
  }

  var_4 = 0.5 * var_3;
  var_5 = var_2;
  var_6 = var_0 - var_1;
  var_7 = squared(var_5) - 4 * var_4 * var_6;

  if(var_7 < 0)
    return 999999;

  var_8 = (-1 * var_5 - sqrt(var_7)) / (2 * var_4);

  if(var_8 >= 0)
    return var_8;

  var_8 = (-1 * var_5 + sqrt(var_7)) / (2 * var_4);
  return var_8;
}

get_trajectory_v_given_x(var_0, var_1, var_2, var_3) {
  var_4 = get_trajectory_time_given_x(var_0, var_1, var_2, var_3);
  var_5 = var_2 + var_3 * var_4;
  return var_5;
}

follow_enemy_with_laser(var_0, var_1) {
  if(!isdefined(var_0) || var_1 == "") {
    return;
  }
  if(!isdefined(var_0.laser_follower))
    var_0.laser_follower = 1;
  else
    return;

  if(var_0 gettagindex("tag_flash") == -1) {
    var_0.laser_follower = undefined;
    return;
  }

  var_2 = spawn("script_model", var_0 gettagorigin("tag_flash"));

  if(!isdefined(var_2)) {
    var_0.laser_follower = undefined;
    return;
  }

  var_2 setmodel("tag_laser");
  var_2 laseron(var_1);
  var_3 = cos(10);
  var_4 = 0.5;

  for (;;) {
    if(!isdefined(var_0) || !isalive(var_0)) {
      break;
    }

    if(isdefined(var_0.enemy)) {
      var_2.origin = var_0 gettagorigin("tag_flash");
      var_5 = var_0 gettagangles("tag_flash");
      var_6 = vectornormalize(var_0.enemy getshootatpos() - var_2.origin);
      var_7 = anglestoforward(var_5);
      var_8 = vectornormalize(var_6);
      var_9 = vectortoangles(var_8);
      var_10 = vectordot(var_7, var_8);

      if(var_10 > var_3) {
        var_2 laseron(var_1);
        var_11 = vectortoangles(var_6) + (randomfloatrange(-1 * var_4, var_4), randomfloatrange(-1 * var_4, var_4), randomfloatrange(-1 * var_4, var_4));
        var_2.angles = vectorlerp(var_2.angles, var_11, 0.15);
      } else
        var_2 laseroff();
    }

    waitframe();
  }

  var_2 laseroff();
  var_2 delete();

  if(isdefined(var_0))
    var_0.laser_follower = undefined;
}

getreacttobulletchance() {
  if(isdefined(self.a.reacttobulletchance))
    return self.a.reacttobulletchance;

  return getdvarfloat("ai_reactToBulletChance");
}

checkforturnwithanim(var_0) {
  var_1 = getanimlength(var_0);
  var_2 = self getanimtime(var_0);
  var_3 = var_2 + 0.05 * self.movetransitionrate / var_1;

  if(var_3 > 1)
    var_3 = 1;

  var_4 = getmovedelta(var_0, var_2, var_3);
  var_5 = length(var_4);
  return self _meth_8571(var_5);
}

set_run_twitch_animation(var_0) {
  self.noruntwitch = !var_0;
}

set_team_run_twitch_animation(var_0, var_1) {
  if(!isdefined(level.h1_team_run_twitch_enabled)) {
    level.h1_team_run_twitch_enabled = [];
    level.h1_team_run_twitch_enabled["allies"] = 0;
    level.h1_team_run_twitch_enabled["axis"] = 0;
    level.h1_team_run_twitch_enabled["neutral"] = 0;
  }

  var_2 = getaiarray(var_0);

  foreach(var_4 in var_2)
  var_4.noruntwitch = !var_1;

  if(level.h1_team_run_twitch_enabled[var_0] != var_1)
    level.h1_team_run_twitch_enabled[var_0] = var_1;
}

using_improved_transitions() {
  return 1;
}

using_tight_turn_anims() {
  if(isdefined(level.script))
    var_0 = level.script;
  else
    var_0 = tolower(getdvar("mapname"));

  if(isdefined(getdvar("debug_force_tight_turn")) && getdvarint("debug_force_tight_turn"))
    return 1;

  if(isai(self) && isdefined(self.disable_tight_turn))
    return !self.disable_tight_turn;

  switch (var_0) {
    case "village_defend":
    case "village_assault":
    case "sniperescape":
    case "scoutsniper":
    case "launchfacility_b":
    case "launchfacility_a":
    case "killhouse":
    case "jeepride":
    case "icbm":
    case "hunted":
    case "coup":
    case "cargoship":
    case "bog_b":
    case "bog_a":
    case "blackout":
    case "ambush":
    case "airplane":
    case "aftermath":
    case "ac130":
    case "airlift":
    case "armada":
      return 1;
  }

  return 1;
}

using_cqb_tight_turn_20() {
  if(isdefined(level.script))
    var_0 = level.script;
  else
    var_0 = tolower(getdvar("mapname"));

  if(getdvarint("use_CQB_tight_turn_20", 0))
    return 1;

  switch (var_0) {
    case "village_defend":
    case "village_assault":
    case "sniperescape":
    case "scoutsniper":
    case "launchfacility_b":
    case "launchfacility_a":
    case "killhouse":
    case "jeepride":
    case "icbm":
    case "hunted":
    case "coup":
    case "cargoship":
    case "bog_b":
    case "bog_a":
    case "blackout":
    case "ambush":
    case "airplane":
    case "aftermath":
    case "ac130":
    case "airlift":
    case "armada":
      return 1;
  }

  return 1;
}

using_exit_node_to_cover_arrival_early_out() {
  if(getdvarint("force_enable_cover_arrival_early_out", 0))
    return 1;

  if(isdefined(level.script))
    var_0 = level.script;
  else
    var_0 = tolower(getdvar("mapname"));

  switch (var_0) {
    case "village_defend":
    case "village_assault":
    case "sniperescape":
    case "scoutsniper":
    case "launchfacility_b":
    case "launchfacility_a":
    case "killhouse":
    case "jeepride":
    case "icbm":
    case "hunted":
    case "coup":
    case "cargoship":
    case "bog_b":
    case "bog_a":
    case "blackout":
    case "ambush":
    case "airplane":
    case "aftermath":
    case "ac130":
    case "airlift":
    case "armada":
      return 1;
  }

  return 1;
}

using_cover_transition_angle_correction() {
  if(isdefined(level.script))
    var_0 = level.script;
  else
    var_0 = tolower(getdvar("mapname"));

  if(getdvarint("use_cover_transition_angle_correction", 0))
    return 1;

  switch (var_0) {
    case "village_defend":
    case "village_assault":
    case "sniperescape":
    case "scoutsniper":
    case "launchfacility_b":
    case "launchfacility_a":
    case "killhouse":
    case "jeepride":
    case "icbm":
    case "hunted":
    case "coup":
    case "cargoship":
    case "bog_b":
    case "bog_a":
    case "blackout":
    case "ambush":
    case "airplane":
    case "aftermath":
    case "ac130":
    case "airlift":
    case "armada":
      return 1;
  }

  return 0;
}
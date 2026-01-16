/******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\shoot_behavior.gsc
******************************************/

decidewhatandhowtoshoot(var_0) {
  self endon("killanimscript");
  self notify("stop_deciding_how_to_shoot");
  self endon("stop_deciding_how_to_shoot");
  self endon("death");
  maps\_gameskill::resetmisstime();
  self.shootobjective = var_0;
  self.shootent = undefined;
  self.shootpos = undefined;
  self.shootstyle = "none";
  self.fastburst = 0;
  self.shouldreturntocover = undefined;

  if(!isdefined(self.changingcoverpos))
    self.changingcoverpos = 0;

  var_1 = isdefined(self.covernode) && self.covernode.type != "Cover Prone" && self.covernode.type != "Conceal Prone";

  if(var_1)
    wait 0.05;

  var_2 = self.shootent;
  var_3 = self.shootpos;
  var_4 = self.shootstyle;

  if(isdefined(self.has_ir)) {
    self.a.laseron = 1;
    animscripts\shared::updatelaserstatus();
  }

  if(animscripts\combat_utility::issniper())
    resetsniperaim();

  if(var_1 && (!self.a.atconcealmentnode || !animscripts\utility::canseeenemy()))
    thread watchforincomingfire();

  thread runonshootbehaviorend();
  self.ambushendtime = undefined;

  for (;;) {
    if(isdefined(self.shootposoverride)) {
      if(!isdefined(self.enemy)) {
        self.shootpos = self.shootposoverride;
        self.shootposoverride = undefined;
        waitabit();
      } else
        self.shootposoverride = undefined;
    }

    var_5 = undefined;

    if(self.weapon == "none")
      nogunshoot();
    else if(animscripts\utility::usingrocketlauncher())
      var_5 = rpgshoot();
    else if(animscripts\utility::usingsidearm() || isdefined(self.alwaysusepistol))
      var_5 = pistolshoot();
    else
      var_5 = rifleshoot();

    if(isdefined(self.a.specialshootbehavior))
      [[self.a.specialshootbehavior]]();

    if(checkchanged(var_2, self.shootent) || !isdefined(self.shootent) && checkchanged(var_3, self.shootpos) || checkchanged(var_4, self.shootstyle))
      self notify("shoot_behavior_change");

    var_2 = self.shootent;
    var_3 = self.shootpos;
    var_4 = self.shootstyle;

    if(!isdefined(var_5))
      waitabit();
  }
}

waitabit() {
  self endon("enemy");
  self endon("done_changing_cover_pos");
  self endon("weapon_position_change");
  self endon("enemy_visible");

  if(isdefined(self.shootent)) {
    self.shootent endon("death");
    self endon("do_slow_things");
    wait 0.05;

    while (isdefined(self.shootent)) {
      if(common_scripts\utility::flag("_cloaked_stealth_enabled"))
        self.shootpos = animscripts\combat_utility::get_last_known_shoot_pos(self.shootent);
      else
        self.shootpos = self.shootent getshootatpos();

      wait 0.05;
    }
  } else
    self waittill("do_slow_things");
}

nogunshoot() {
  self.shootent = undefined;
  self.shootpos = undefined;
  self.shootstyle = "none";
  self.shootobjective = "normal";
}

shouldsuppress() {
  return !animscripts\combat_utility::issniper() && !animscripts\utility::isshotgun(self.weapon);
}

shouldshootenemyent() {
  if(!animscripts\utility::canseeenemy())
    return 0;

  return 1;
}

rifleshootobjectivenormal() {
  if(!shouldshootenemyent()) {
    if(animscripts\combat_utility::issniper())
      resetsniperaim();

    if(self.doingambush) {
      self.shootobjective = "ambush";
      return "retry";
    }

    if(!isdefined(self.enemy))
      havenothingtoshoot();
    else {
      markenemyposinvisible();

      if((self.providecoveringfire || randomint(5) > 0) && shouldsuppress())
        self.shootobjective = "suppress";
      else
        self.shootobjective = "ambush";

      return "retry";
    }
  } else {
    setshootenttoenemy();
    setshootstyleforvisibleenemy();
  }
}

rifleshootobjectivesuppress(var_0) {
  if(!var_0)
    havenothingtoshoot();
  else {
    self.shootent = undefined;
    self.shootpos = animscripts\utility::getenemysightpos();
    setshootstyleforsuppression();
  }
}

rifleshootobjectiveambush(var_0) {
  self.shootstyle = "none";
  self.shootent = undefined;

  if(!var_0) {
    getambushshootpos();

    if(shouldstopambushing()) {
      self.ambushendtime = undefined;
      self notify("return_to_cover");
      self.shouldreturntocover = 1;
    }
  } else {
    self.shootpos = animscripts\utility::getenemysightpos();

    if(shouldstopambushing()) {
      self.ambushendtime = undefined;

      if(shouldsuppress())
        self.shootobjective = "suppress";

      if(randomint(3) == 0) {
        self notify("return_to_cover");
        self.shouldreturntocover = 1;
      }

      return "retry";
    }
  }
}

getambushshootpos() {
  if(isdefined(self.enemy) && self cansee(self.enemy)) {
    setshootenttoenemy();
    return;
  }

  var_0 = self getanglestolikelyenemypath();

  if(!isdefined(var_0)) {
    if(isdefined(self.covernode))
      var_0 = self.covernode.angles;
    else if(isdefined(self.ambushnode))
      var_0 = self.ambushnode.angles;
    else
      var_0 = self.angles;
  }

  var_1 = 1024;

  if(isdefined(self.enemy))
    var_1 = distance(self.origin, self.enemy.origin);

  var_2 = self geteye() + anglestoforward(var_0) * var_1;

  if(!isdefined(self.shootpos) || distancesquared(var_2, self.shootpos) > 25)
    self.shootpos = var_2;
}

rifleshoot() {
  if(self.shootobjective == "normal")
    rifleshootobjectivenormal();
  else {
    if(shouldshootenemyent()) {
      self.shootobjective = "normal";
      self.ambushendtime = undefined;
      return "retry";
    }

    markenemyposinvisible();

    if(animscripts\combat_utility::issniper())
      resetsniperaim();

    var_0 = animscripts\utility::cansuppressenemy();

    if(self.shootobjective == "suppress" || self.team == "allies" && !isdefined(self.enemy) && !var_0)
      rifleshootobjectivesuppress(var_0);
    else
      rifleshootobjectiveambush(var_0);
  }
}

shouldstopambushing() {
  if(!isdefined(self.ambushendtime)) {
    if(self isbadguy())
      self.ambushendtime = gettime() + randomintrange(10000, 60000);
    else
      self.ambushendtime = gettime() + randomintrange(4000, 10000);
  }

  return self.ambushendtime < gettime();
}

rpgshoot() {
  if(!shouldshootenemyent()) {
    markenemyposinvisible();
    havenothingtoshoot();
    return;
  }

  setshootenttoenemy();
  setshootstyle("single", 0);
  var_0 = lengthsquared(self.origin - self.shootpos);

  if(var_0 < squared(512)) {
    self notify("return_to_cover");
    self.shouldreturntocover = 1;
    return;
  }
}

pistolshoot() {
  if(self.shootobjective == "normal") {
    if(!shouldshootenemyent()) {
      if(!isdefined(self.enemy)) {
        havenothingtoshoot();
        return;
      } else {
        markenemyposinvisible();
        self.shootobjective = "ambush";
        return "retry";
      }
    } else {
      setshootenttoenemy();
      setshootstyle("single", 0);
    }
  } else {
    if(shouldshootenemyent()) {
      self.shootobjective = "normal";
      self.ambushendtime = undefined;
      return "retry";
    }

    markenemyposinvisible();
    self.shootent = undefined;
    self.shootstyle = "none";
    self.shootpos = animscripts\utility::getenemysightpos();

    if(!isdefined(self.ambushendtime))
      self.ambushendtime = gettime() + randomintrange(4000, 8000);

    if(self.ambushendtime < gettime()) {
      self.shootobjective = "normal";
      self.ambushendtime = undefined;
      return "retry";
    }
  }
}

markenemyposinvisible() {
  if(isdefined(self.enemy) && !self.changingcoverpos && self.script != "combat") {
    if(isai(self.enemy) && isdefined(self.enemy.script) && (self.enemy.script == "cover_stand" || self.enemy.script == "cover_crouch")) {
      if(isdefined(self.enemy.a.covermode) && self.enemy.a.covermode == "hide")
        return;
    }

    self.couldntseeenemypos = self.enemy.origin;
  }
}

watchforincomingfire() {
  self endon("killanimscript");
  self endon("stop_deciding_how_to_shoot");

  for (;;) {
    self waittill("suppression");

    if(self.suppressionmeter > self.suppressionthreshold) {
      if(readytoreturntocover()) {
        self notify("return_to_cover");
        self.shouldreturntocover = 1;
      }
    }
  }
}

readytoreturntocover() {
  if(self.changingcoverpos)
    return 0;

  if(!isdefined(self.enemy) || !self cansee(self.enemy))
    return 1;

  if(gettime() < self.coverposestablishedtime + 800)
    return 0;

  if(isplayer(self.enemy) && self.enemy.health < self.enemy.maxhealth * 0.5) {
    if(gettime() < self.coverposestablishedtime + 3000)
      return 0;
  }

  return 1;
}

runonshootbehaviorend() {
  self endon("death");
  common_scripts\utility::waittill_any("killanimscript", "stop_deciding_how_to_shoot");
  self.a.laseron = 0;
  animscripts\shared::updatelaserstatus();
}

checkchanged(var_0, var_1) {
  if(isdefined(var_0) != isdefined(var_1))
    return 1;

  if(!isdefined(var_1))
    return 0;

  return var_0 != var_1;
}

setshootenttoenemy() {
  self.shootent = self.enemy;

  if(common_scripts\utility::flag("_cloaked_stealth_enabled")) {
    if(isdefined(self.enemy_who_surprised_me) && self.enemy_who_surprised_me == self.enemy)
      self.shootpos = self.shootent getshootatpos();
    else
      self.shootpos = animscripts\combat_utility::get_last_known_shoot_pos(self.shootent);
  } else
    self.shootpos = self.shootent getshootatpos();
}

havenothingtoshoot() {
  self.shootent = undefined;
  self.shootpos = undefined;
  self.shootstyle = "none";

  if(self.doingambush)
    self.shootobjective = "ambush";

  if(!self.changingcoverpos) {
    self notify("return_to_cover");
    self.shouldreturntocover = 1;
  }
}

shouldbeajerk() {
  return level.gameskill == 3 && isplayer(self.enemy);
}

setshootstyleforvisibleenemy() {
  if(isdefined(self.shootent.enemy) && isdefined(self.shootent.enemy.syncedmeleetarget))
    return setshootstyle("single", 0);

  if(animscripts\combat_utility::issniper())
    return setshootstyle("single", 0);

  if(animscripts\utility::isshotgun(self.weapon))
    return setshootstyle("single", 0);

  if(weaponclass(self.weapon) == "grenade")
    return setshootstyle("single", 0);

  if(weaponburstcount(self.weapon) > 0)
    return setshootstyle("burst", 0);

  if(isdefined(self.juggernaut) && self.juggernaut || isdefined(self.mech) && self.mech)
    return setshootstyle("full", 1);

  var_0 = distancesquared(self getshootatpos(), self.shootpos);
  var_1 = weaponclass(self.weapon) == "mg";

  if(var_1)
    return setshootstyle("full", 0);

  if(var_0 < 90000) {
    if(isdefined(self.shootent) && isdefined(self.shootent.magic_bullet_shield))
      return setshootstyle("single", 0);
    else
      return setshootstyle("full", 0);
  } else if(var_0 < 810000 || shouldbeajerk())
    return setshootstyle("burst", 1);
  else if(self.providecoveringfire || var_1 || var_0 < 2560000) {
    if(shoulddosemiforvariety())
      return setshootstyle("semi", 0);
    else
      return setshootstyle("burst", 0);
  }

  return setshootstyle("single", 0);
}

setshootstyleforsuppression() {
  var_0 = distancesquared(self getshootatpos(), self.shootpos);

  if(weaponissemiauto(self.weapon)) {
    if(var_0 < 2560000)
      return setshootstyle("semi", 0);

    return setshootstyle("single", 0);
  }

  if(weaponclass(self.weapon) == "mg")
    return setshootstyle("full", 0);

  if(self.providecoveringfire || var_0 < 1690000) {
    if(shoulddosemiforvariety())
      return setshootstyle("semi", 0);
    else
      return setshootstyle("burst", 0);
  }

  return setshootstyle("single", 0);
}

setshootstyle(var_0, var_1) {
  self.shootstyle = var_0;
  self.fastburst = var_1;
}

shoulddosemiforvariety() {
  if(weaponclass(self.weapon) != "rifle")
    return 0;

  if(self.team != "allies")
    return 0;

  var_0 = animscripts\utility::safemod(int(self.origin[1]), 10000) + 2000;
  var_1 = int(self.origin[0]) + gettime();
  return var_1 % (2 * var_0) > var_0;
}

resetsniperaim() {
  self.snipershotcount = 0;
  self.sniperhitcount = 0;
  thread sniper_glint_behavior();
}

sniper_glint_behavior() {
  self endon("killanimscript");
  self endon("enemy");
  self endon("return_to_cover");
  self notify("new_glint_thread");
  self endon("new_glint_thread");

  if(isdefined(self.disable_sniper_glint) && self.disable_sniper_glint) {
    return;
  }
  if(!isdefined(level._effect["sniper_glint"])) {
    return;
  }
  if(!isalive(self.enemy)) {
    return;
  }
  var_0 = common_scripts\utility::getfx("sniper_glint");
  wait 0.2;

  for (;;) {
    if(self.weapon == self.primaryweapon && animscripts\combat_utility::player_sees_my_scope()) {
      if(distancesquared(self.origin, self.enemy.origin) > 65536)
        playfxontag(var_0, self, "tag_flash");

      var_1 = randomfloatrange(3, 5);
      wait(var_1);
    }

    wait 0.2;
  }
}
/******************************************
 * Decompiled and Edited by SyndiShanX
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

  if(!isDefined(self.changingcoverpos)) {
    self.changingcoverpos = 0;
  }

  var_1 = isDefined(self.covernode) && self.covernode.type != "Cover Prone" && self.covernode.type != "Conceal Prone";

  if(var_1) {
    wait 0.05;
  }

  var_2 = self.shootent;
  var_3 = self.shootpos;
  var_4 = self.shootstyle;

  if(!isDefined(self.has_no_ir)) {
    self.a.laseron = 1;
    animscripts\shared::updatelaserstatus();
  }

  if(animscripts\combat_utility::issniper()) {
    resetsniperaim();
  }

  if(var_1 && (!self.a.atconcealmentnode || !animscripts\utility::canseeenemy())) {
    thread watchforincomingfire();
  }

  thread runonshootbehaviorend();
  self.ambushendtime = undefined;

  for(;;) {
    if(isDefined(self.shootposoverride)) {
      if(!isDefined(self.enemy)) {
        self.shootpos = self.shootposoverride;
        self.shootposoverride = undefined;
        waitabit();
      } else
        self.shootposoverride = undefined;
    }

    var_5 = undefined;

    if(self.weapon == "none") {
      nogunshoot();
    }
    else if(animscripts\utility::usingrocketlauncher()) {
      var_5 = rpgshoot();
    }
    else if(animscripts\utility::usingsidearm()) {
      var_5 = pistolshoot();
    }
    else {
      var_5 = rifleshoot();
    }

    if(isDefined(self.a.specialshootbehavior)) {
      [[self.a.specialshootbehavior]]();
    }

    if(checkchanged(var_2, self.shootent) || !isDefined(self.shootent) && checkchanged(var_3, self.shootpos) || checkchanged(var_4, self.shootstyle)) {
      self notify("shoot_behavior_change");
    }

    var_2 = self.shootent;
    var_3 = self.shootpos;
    var_4 = self.shootstyle;

    if(!isDefined(var_5)) {
      waitabit();
    }
  }
}

waitabit() {
  self endon("enemy");
  self endon("done_changing_cover_pos");
  self endon("weapon_position_change");
  self endon("enemy_visible");

  if(isDefined(self.shootent)) {
    self.shootent endon("death");
    self endon("do_slow_things");
    wait 0.05;

    while(isDefined(self.shootent)) {
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
  if(!animscripts\utility::canseeenemy()) {
    return 0;
  }

  if(!isDefined(self.covernode) && !self canshootenemy()) {
    return 0;
  }

  return 1;
}

rifleshootobjectivenormal() {
  if(!shouldshootenemyent()) {
    if(animscripts\combat_utility::issniper()) {
      resetsniperaim();
    }

    if(self.doingambush) {
      self.shootobjective = "ambush";
      return "retry";
    }

    if(!isDefined(self.enemy)) {
      havenothingtoshoot();
    }
    else {
      markenemyposinvisible();

      if((self.providecoveringfire || randomint(5) > 0) && shouldsuppress()) {
        self.shootobjective = "suppress";
      }
      else {
        self.shootobjective = "ambush";
      }

      return "retry";
    }
  } else {
    setshootenttoenemy();
    setshootstyleforvisibleenemy();
  }
}

rifleshootobjectivesuppress(var_0) {
  if(!var_0) {
    havenothingtoshoot();
  }
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

      if(shouldsuppress()) {
        self.shootobjective = "suppress";
      }

      if(randomint(3) == 0) {
        self notify("return_to_cover");
        self.shouldreturntocover = 1;
      }

      return "retry";
    }
  }
}

getambushshootpos() {
  if(isDefined(self.enemy) && self cansee(self.enemy)) {
    setshootenttoenemy();
    return;
  }

  var_0 = self getanglestolikelyenemypath();

  if(!isDefined(var_0)) {
    if(isDefined(self.covernode)) {
      var_0 = self.covernode.angles;
    }
    else if(isDefined(self.ambushnode)) {
      var_0 = self.ambushnode.angles;
    }
    else if(isDefined(self.enemy)) {
      var_0 = vectortoangles(self lastknownpos(self.enemy) - self.origin);
    }
    else {
      var_0 = self.angles;
    }
  }

  var_1 = 1024;

  if(isDefined(self.enemy)) {
    var_1 = distance(self.origin, self.enemy.origin);
  }

  var_2 = self getEye() + anglesToForward(var_0) * var_1;

  if(!isDefined(self.shootpos) || distancesquared(var_2, self.shootpos) > 25) {
    self.shootpos = var_2;
  }
}

rifleshoot() {
  if(self.shootobjective == "normal") {
    rifleshootobjectivenormal();
  }
  else {
    if(shouldshootenemyent()) {
      self.shootobjective = "normal";
      self.ambushendtime = undefined;
      return "retry";
    }

    markenemyposinvisible();

    if(animscripts\combat_utility::issniper()) {
      resetsniperaim();
    }

    var_0 = animscripts\utility::cansuppressenemy();

    if(self.shootobjective == "suppress" || self.team == "allies" && !isDefined(self.enemy) && !var_0) {
      rifleshootobjectivesuppress(var_0);
    }
    else {
      rifleshootobjectiveambush(var_0);
    }
  }
}

shouldstopambushing() {
  if(!isDefined(self.ambushendtime)) {
    if(self isbadguy()) {
      self.ambushendtime = gettime() + randomintrange(10000, 60000);
    }
    else {
      self.ambushendtime = gettime() + randomintrange(4000, 10000);
    }
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
      if(!isDefined(self.enemy)) {
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

    if(!isDefined(self.ambushendtime)) {
      self.ambushendtime = gettime() + randomintrange(4000, 8000);
    }

    if(self.ambushendtime < gettime()) {
      self.shootobjective = "normal";
      self.ambushendtime = undefined;
      return "retry";
    }
  }
}

markenemyposinvisible() {
  if(isDefined(self.enemy) && !self.changingcoverpos && self.script != "combat") {
    if(isai(self.enemy) && isDefined(self.enemy.script) && (self.enemy.script == "cover_stand" || self.enemy.script == "cover_crouch")) {
      if(isDefined(self.enemy.a.covermode) && self.enemy.a.covermode == "hide") {
        return;
      }
    }

    self.couldntseeenemypos = self.enemy.origin;
  }
}

watchforincomingfire() {
  self endon("killanimscript");
  self endon("stop_deciding_how_to_shoot");

  for(;;) {
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
  if(self.changingcoverpos) {
    return 0;
  }

  if(!isDefined(self.enemy) || !self cansee(self.enemy)) {
    return 1;
  }

  if(gettime() < self.coverposestablishedtime + 800) {
    return 0;
  }

  if(isplayer(self.enemy) && self.enemy.health < self.enemy.maxhealth * 0.5) {
    if(gettime() < self.coverposestablishedtime + 3000) {
      return 0;
    }
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
  if(isDefined(var_0) != isDefined(var_1)) {
    return 1;
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  return var_0 != var_1;
}

setshootenttoenemy() {
  self.shootent = self.enemy;
  self.shootpos = self.shootent getshootatpos();
}

havenothingtoshoot() {
  self.shootent = undefined;
  self.shootpos = undefined;
  self.shootstyle = "none";

  if(self.doingambush) {
    self.shootobjective = "ambush";
  }

  if(!self.changingcoverpos) {
    self notify("return_to_cover");
    self.shouldreturntocover = 1;
  }
}

shouldbeajerk() {
  return level.gameskill == 3 && isplayer(self.enemy);
}

setshootstyleforvisibleenemy() {
  if(isDefined(self.shootent.enemy) && isDefined(self.shootent.enemy.syncedmeleetarget)) {
    return setshootstyle("single", 0);
  }

  if(animscripts\combat_utility::issniper()) {
    return setshootstyle("single", 0);
  }

  if(animscripts\utility::isshotgun(self.weapon)) {
    if(animscripts\utility::weapon_pump_action_shotgun()) {
      return setshootstyle("single", 0);
    }
    else {
      return setshootstyle("semi", 0);
    }
  }

  if(weaponclass(self.weapon) == "grenade") {
    return setshootstyle("single", 0);
  }

  if(weaponburstcount(self.weapon) > 0) {
    return setshootstyle("burst", 0);
  }

  if(isDefined(self.juggernaut) && self.juggernaut) {
    return setshootstyle("full", 1);
  }

  var_0 = distancesquared(self getshootatpos(), self.shootpos);
  var_1 = weaponclass(self.weapon) == "mg";

  if(self.providecoveringfire && var_1) {
    return setshootstyle("full", 0);
  }

  if(var_0 < 62500) {
    if(isDefined(self.shootent) && isDefined(self.shootent.magic_bullet_shield)) {
      return setshootstyle("single", 0);
    }
    else {
      return setshootstyle("full", 0);
    }
  } else if(var_0 < 810000 || shouldbeajerk()) {
    if(weaponissemiauto(self.weapon) || shoulddosemiforvariety()) {
      return setshootstyle("semi", 1);
    }
    else {
      return setshootstyle("burst", 1);
    }
  } else if(self.providecoveringfire || var_1 || var_0 < 2560000) {
    if(shoulddosemiforvariety()) {
      return setshootstyle("semi", 0);
    }
    else {
      return setshootstyle("burst", 0);
    }
  }

  return setshootstyle("single", 0);
}

setshootstyleforsuppression() {
  var_0 = distancesquared(self getshootatpos(), self.shootpos);

  if(weaponissemiauto(self.weapon)) {
    if(var_0 < 2560000) {
      return setshootstyle("semi", 0);
    }

    return setshootstyle("single", 0);
  }

  if(weaponclass(self.weapon) == "mg") {
    return setshootstyle("full", 0);
  }

  if(self.providecoveringfire || var_0 < 2560000) {
    if(shoulddosemiforvariety()) {
      return setshootstyle("semi", 0);
    }
    else {
      return setshootstyle("burst", 0);
    }
  }

  return setshootstyle("single", 0);
}

setshootstyle(var_0, var_1) {
  self.shootstyle = var_0;
  self.fastburst = var_1;
}

shoulddosemiforvariety() {
  if(weaponclass(self.weapon) != "rifle") {
    return 0;
  }

  if(self.team != "allies") {
    return 0;
  }

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

  if(isDefined(self.disable_sniper_glint) && self.disable_sniper_glint) {
    return;
  }
  if(!isDefined(level._effect["sniper_glint"])) {
    return;
  }
  if(!isalive(self.enemy)) {
    return;
  }
  var_0 = common_scripts\utility::getfx("sniper_glint");
  wait 0.2;

  for(;;) {
    if(self.weapon == self.primaryweapon && animscripts\combat_utility::player_sees_my_scope()) {
      if(distancesquared(self.origin, self.enemy.origin) > 65536) {
        playFXOnTag(var_0, self, "tag_flash");
      }

      var_1 = randomfloatrange(3, 5);
      wait(var_1);
    }

    wait 0.2;
  }
}
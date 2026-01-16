/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\shoot_behavior.gsc
******************************************/

#include common_scripts\utility;
#include animscripts\combat_utility;
#include animscripts\utility;
#include animscripts\shared;
#include maps\_utility;
#include maps\_gameskill;

decidewhatandhowtoshoot(objective) {
  self endon("killanimscript");
  self notify("stop_deciding_how_to_shoot");
  self endon("stop_deciding_how_to_shoot");
  self endon("death");
  assert(isDefined(objective));
  maps\_gameskill::resetmisstime();
  self.shootobjective = objective;
  self.shootent = undefined;
  self.shootpos = undefined;
  self.shootstyle = "none";
  self.fastburst = 0;
  self.shouldreturntocover = 0;

  if(!isDefined(self.changingcoverpos))
    self.changingcoverpos = 0;

  atcover = isDefined(self.covernode) && self.covernode.type != "Cover Prone" && self.covernode.type != "Conceal Prone";

  if(atcover)
    wait 0.05;

  prevshootent = self.shootent;
  prevshootpos = self.shootpos;
  prevshootstyle = self.shootstyle;
  self animscripts\shared::updatelaserstatus(1);

  if(self issniper())
    self resetsniperaim(1);

  if(atcover && (!self.a.atconcealmentnode || !self canseeenemy()))
    thread watchforincomingfire();

  thread runonshootbehaviorend();
  self.ambushendtime = undefined;

  while(true) {
    assert(self.shootobjective == "normal" || self.shootobjective == "suppress" || self.shootobjective == "ambush");
    assert(!isDefined(self.shootent) || isDefined(self.shootpos));
    result = undefined;

    if(self.weapon == "none")
      nogunshoot();
    else if(!self.a.allow_shooting) {
      setshootstyle("none", 0);

      if(isDefined(self.enemy))
        setshootent(self.enemy);
    } else if(self weaponanims() == "rocketlauncher")
      result = rpgshoot();
    else if(self.weaponclass == "pistol")
      result = pistolshoot();
    else if(self.weaponclass == "spread")
      result = shotgunshoot();
    else if(self.weaponclass == "gas")
      result = flamethrower_shoot();
    else if(usinggrenadelauncher())
      result = grenadeshoot();
    else
      result = rifleshoot();

    if(checkchanged(prevshootent, self.shootent) || !isDefined(self.shootent) && checkchanged(prevshootpos, self.shootpos) || checkchanged(prevshootstyle, self.shootstyle))
      self notify("shoot_behavior_change");

    prevshootent = self.shootent;
    prevshootpos = self.shootpos;
    prevshootstyle = self.shootstyle;

    if(!isDefined(result))
      waitabit();
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
  println("^1Warning: AI at " + self.origin + ", entnum " + self getentnum() + ", export " + self.export+" trying to shoot but has no gun");

  self.shootent = undefined;
  self.shootpos = undefined;
  self.shootstyle = "none";
  self.shootobjective = "normal";
}

shouldsuppress() {
  return !self issniper() && !weapon_spread();
}

rifleshoot() {
  if(self.shootobjective == "normal") {
    if(!canseeenemy()) {
      if(self issniper())
        self resetsniperaim();

      if(!isDefined(self.enemy))
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
      setshootent(self.enemy);
      self setshootstyleforvisibleenemy();
    }
  } else {
    if(canseeenemy()) {
      self.shootobjective = "normal";
      self.ambushendtime = undefined;
      return "retry";
    }

    markenemyposinvisible();

    if(self issniper())
      self resetsniperaim();

    if(!cansuppressenemy()) {
      if(self.shootobjective == "suppress" || self.team == "allies" && !isvalidenemy(self.enemy))
        havenothingtoshoot();
      else {
        assert(self.shootobjective == "ambush");
        self.shootstyle = "none";
        likelyenemydir = self getanglestolikelyenemypath();

        if(!isDefined(likelyenemydir)) {
          if(isDefined(self.covernode))
            likelyenemydir = self.covernode.angles;
          else
            likelyenemydir = self.angles;
        }

        self.shootent = undefined;
        dist = 1024;

        if(isDefined(self.enemy))
          dist = distance(self.origin, self.enemy.origin);

        newshootpos = self geteye() + anglestoforward(likelyenemydir) * dist;

        if(!isDefined(self.shootpos) || distancesquared(newshootpos, self.shootpos) > 25)
          self.shootpos = newshootpos;

        if(shouldstopambushing()) {
          self.ambushendtime = undefined;
          self notify("return_to_cover");
          self.shouldreturntocover = 1;
        }
      }
    } else {
      self.shootent = undefined;
      self.shootpos = getenemysightpos();

      if(self.shootobjective == "suppress")
        self setshootstyleforsuppression();
      else {
        assert(self.shootobjective == "ambush");
        self.shootstyle = "none";

        if(self shouldstopambushing()) {
          if(shouldsuppress())
            self.shootobjective = "suppress";

          self.ambushendtime = undefined;

          if(randomint(3) == 0) {
            self notify("return_to_cover");
            self.shouldreturntocover = 1;
          }

          return "retry";
        }
      }
    }
  }
}

shouldstopambushing() {
  if(!isDefined(self.ambushendtime)) {
    if(self.team == "allies")
      self.ambushendtime = gettime() + randomintrange(4000, 10000);
    else
      self.ambushendtime = gettime() + randomintrange(40000, 60000);
  }

  return self.ambushendtime < gettime();
}

rpgshootexplodable() {
  self endon("death");
  enemy = self.enemy;
  weapon = self.weapon;
  assert(isDefined(enemy));
  assert(isDefined(enemy._explodable_targets));
  target = undefined;

  if(enemy._explodable_targets.size > 0) {
    for(i = 0; i < enemy._explodable_targets.size; i++) {
      target = enemy._explodable_targets[i];

      if(isDefined(target) && self cansee(target))
        self setentitytarget(target);
    }
  }

  if(isDefined(target)) {
    while(isDefined(target) && isalive(enemy) && self.weapon == weapon)
      wait 0.05;

    self clearentitytarget();
  }
}

rpgshoot() {
  if(!canseeenemy()) {
    markenemyposinvisible();
    havenothingtoshoot();
    return;
  }

  if(isDefined(self.enemy) && isDefined(self.enemy._explodable_targets))
    self thread rpgshootexplodable();

  setshootent(self.enemy);
  self.shootstyle = "single";
  distsqtoshootpos = lengthsquared(self.origin - self.shootpos);

  if(distsqtoshootpos < 262144) {
    self notify("return_to_cover");
    self.shouldreturntocover = 1;
    return;
  }
}

grenadeshoot() {
  if(!canseeenemy()) {
    markenemyposinvisible();
    havenothingtoshoot();
    return;
  }

  setshootent(self.enemy);

  if(self.bulletsinclip > 1)
    self.shootstyle = "burst";
  else
    self.shootstyle = "single";
}

shotgunshoot() {
  if(!canseeenemy()) {
    havenothingtoshoot();
    return;
  }

  setshootent(self.enemy);
  self.shootstyle = "single";
}

flamethrower_shoot() {
  if(!canseeenemy()) {
    havenothingtoshoot();
    return;
  }

  setshootent(self.enemy);
  self.shootstyle = "full";
}

pistolshoot() {
  if(self.shootobjective == "normal") {
    if(!canseeenemy()) {
      if(!isDefined(self.enemy)) {
        havenothingtoshoot();
        return;
      } else {
        markenemyposinvisible();
        self.shootobjective = "ambush";
        return "retry";
      }
    } else {
      setshootent(self.enemy);
      self.shootstyle = "semi";
    }
  } else {
    if(canseeenemy()) {
      self.shootobjective = "normal";
      self.ambushendtime = undefined;
      return "retry";
    }

    markenemyposinvisible();

    if(cansuppressenemy()) {
      self.shootent = undefined;
      self.shootpos = getenemysightpos();
    }

    self.shootstyle = "none";

    if(!isDefined(self.ambushendtime))
      self.ambushendtime = gettime() + randomintrange(4000, 8000);

    if(self.ambushendtime < gettime()) {
      self.shootobjective = "normal";
      self.ambushendtime = undefined;
      return "retry";
    }
  }
}

markenemyposinvisible() {
  if(isDefined(self.enemy) && !self.changingcoverpos && self.a.script != "combat") {
    if(isai(self.enemy) && isDefined(self.enemy.a.script) && (self.enemy.a.script == "cover_stand" || self.enemy.a.script == "cover_crouch")) {
      if(isDefined(self.enemy.a.covermode) && self.enemy.a.covermode == "Hide")
        return;
    }

    self.couldntseeenemypos = self.enemy.origin;
  }
}

watchforincomingfire() {
  self endon("killanimscript");
  self endon("stop_deciding_how_to_shoot");

  while(true) {
    self waittill("suppression");

    if(self.suppressionmeter > self.suppressionthreshold) {
      if(self readytoreturntocover()) {
        self notify("return_to_cover");
        self.shouldreturntocover = 1;
      }
    }
  }
}

readytoreturntocover() {
  if(self.changingcoverpos)
    return false;

  if(isDefined(self.isramboing) && self.isramboing)
    return false;

  assert(isDefined(self.coverposestablishedtime));

  if(!isvalidenemy(self.enemy) || !self cansee(self.enemy))
    return true;

  if(gettime() < self.coverposestablishedtime + 800)
    return false;

  if(isplayer(self.enemy) && self.enemy.health < self.enemy.maxhealth * 0.5) {
    if(gettime() < self.coverposestablishedtime + 3000)
      return false;
  }

  return true;
}

runonshootbehaviorend() {
  self endon("death");
  self waittill_any("killanimscript", "stop_deciding_how_to_shoot", "return_to_cover");
  self animscripts\shared::updatelaserstatus(0);
}

checkchanged(prevval, newval) {
  if(isDefined(prevval) != isDefined(newval))
    return true;

  if(!isDefined(newval)) {
    assert(!isDefined(prevval));
    return false;
  }

  return prevval != newval;
}

setshootent(ent) {
  if(!isDefined(ent)) {
    return;
  }
  self.shootent = ent;
  self.shootpos = self.shootent getshootatpos();
}

havenothingtoshoot() {
  self.shootent = undefined;
  self.shootpos = undefined;
  self.shootstyle = "none";

  if(!self.changingcoverpos) {
    self notify("return_to_cover");
    self.shouldreturntocover = 1;
  }
}

shootingplayerathigherdifficulty() {
  return level.gameskill == 3 && isplayer(self.enemy);
}

setshootstyleforvisibleenemy() {
  assert(isDefined(self.shootpos));
  assert(isDefined(self.shootent));

  if(isDefined(self.shootent.enemy) && isDefined(self.shootent.enemy.syncedmeleetarget))
    return setshootstyle("single", 0);

  if(self issniper() || self weapon_spread())
    return setshootstyle("single", 0);

  distancesq = distancesquared(self getshootatpos(), self.shootpos);

  if(weaponissemiauto(self.weapon)) {
    if(distancesq < 2560000 || shootingplayerathigherdifficulty())
      return setshootstyle("semi", 0);

    return setshootstyle("single", 0);
  }

  if(self.weaponclass == "mg")
    return setshootstyle("full", 0);

  if(distancesq < 90000) {
    if(isDefined(self.shootent) && isDefined(self.shootent.magic_bullet_shield))
      return setshootstyle("single", 0);
    else
      return setshootstyle("full", 0);
  } else if(distancesq < 810000 || shootingplayerathigherdifficulty())
    return setshootstyle("burst", 1);

  if(self.providecoveringfire || distancesq < 2560000) {
    if(shoulddosemiforvariety())
      return setshootstyle("semi", 0);
    else
      return setshootstyle("burst", 0);
  }

  return setshootstyle("single", 0);
}

setshootstyleforsuppression() {
  assert(isDefined(self.shootpos));
  distancesq = distancesquared(self getshootatpos(), self.shootpos);
  assert(!self issniper());
  assert(!self weapon_spread());

  if(weaponissemiauto(self.weapon)) {
    if(distancesq < 2560000)
      return setshootstyle("semi", 0);

    return setshootstyle("single", 0);
  }

  if(self.weaponclass == "mg")
    return setshootstyle("full", 0);

  if(self.providecoveringfire || distancesq < 1690000) {
    if(shoulddosemiforvariety())
      return setshootstyle("semi", 0);
    else
      return setshootstyle("burst", 0);
  }

  return setshootstyle("single", 0);
}

setshootstyle(style, fastburst) {
  self.shootstyle = style;
  self.fastburst = fastburst;
}

shoulddosemiforvariety() {
  if(self.weaponclass != "rifle") {
  }

  return 0;

  if(!isDefined(self.semiforvarietycheck))
    self.semiforvarietycheck = 0;

  time = gettime();

  if(time < self.semiforvarietycheck)
    return 0;

  if(randomint(100) < 50)
    dosemi = 1;
  else
    dosemi = 0;

  self.semiforvarietycheck = time + 10000;
  return dosemi;
}

resetsniperaim(considermissing) {
  assert(self issniper());
  self.snipershotcount = 0;
  self.sniperhitcount = 0;

  if(isDefined(considermissing))
    self.lastmissedenemy = undefined;
}

showsniperglint() {
  if(!self issniper()) {
    return;
  }
  if(is_true(self.disable_sniper_glint)) {
    return;
  }
  if(!isDefined(self.enemy)) {
    return;
  }
  if(self.team == "allies") {
    return;
  }
  if(!isDefined(level._effect["sniper_glint"])) {
    return;
  }
  if(distancesquared(self.origin, self.enemy.origin) > 65536)
    playfxontag(level._effect["sniper_glint"], self, "tag_flash");
}
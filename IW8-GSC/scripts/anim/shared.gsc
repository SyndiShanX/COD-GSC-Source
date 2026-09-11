/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\shared.gsc
***********************************************/

function placeweaponon(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;

  if(issameweapon(var_0)) {
    var_3 = var_0;
    var_4 = createheadicon(var_0);
  } else {
    var_3 = asmdevgetallstates(var_0);
    var_4 = var_0;
  }

  self notify("weapon_position_change");
  var_5 = self.weaponinfo[var_4].position;

  if(var_1 != "none" && isDefined(self.a.weaponpos[var_1]) && self.a.weaponpos[var_1] == var_3) {
    return;
  }

  detachallweaponmodels();

  if(var_5 != "none") {
    detachweapon(var_3);
  }

  if(var_1 == "none") {
    updateattachedweaponmodels();
    return;
  }

  if(!getqueuedspleveltransients(self.a.weaponpos[var_1])) {
    detachweapon(self.a.weaponpos[var_1]);
  }

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(var_2 && (var_1 == "left" || var_1 == "right")) {
    attachweapon(var_3, var_1);
    self.weapon = var_3;
  } else {
    attachweapon(var_3, var_1);
  }

  updateattachedweaponmodels();
}

function detachweapon(var_0) {
  var_1 = createheadicon(var_0);
  self.a.weaponpos[self.weaponinfo[var_1].position] = undefined;
  self.weaponinfo[var_1].position = "none";
}

function attachweapon(var_0, var_1) {
  var_2 = createheadicon(var_0);
  self.weaponinfo[var_2].position = var_1;
  self.a.weaponpos[var_1] = var_0;

  if(!getqueuedspleveltransients(self.a.weaponposdropping[var_1])) {
    self notify("end_weapon_drop_" + var_1);
    self.a.weaponposdropping[var_1] = undefined;
    return;
  }
}

function getweaponforpos(var_0) {
  var_1 = self.a.weaponpos[var_0];

  if(getqueuedspleveltransients(var_1)) {
    return self.a.weaponposdropping[var_0];
  }

  return var_1;
}

function detachallweaponmodels() {
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, "right");
}

function updateattachedweaponmodels() {
  var_0 = [];
  var_1 = [];
  var_2 = [];
  var_0 = "right";
  var_0 = "left";
  var_0 = "chest";
  var_0 = "back";
  var_0 = "thigh";

  foreach(var_4 in var_0) {
    var_5 = var_1.size;
    var_6 = getweaponforpos(var_4);

    if(!getqueuedspleveltransients(var_6) && !nullweapon(var_6)) {
      var_7 = createheadicon(var_6);

      if(self.weaponinfo[var_7].useclip && !self.weaponinfo[var_7].hasclip) {
        var_6 = var_6 withoutattachment(var_6.magazine);
      }
    }

    if(isDefined(var_6)) {
      var_8 = gettagforpos(var_4);

      if(self tagexists(var_8)) {
        var_1 = var_6;
        var_2 = var_8;
      }
    }
  }

  self updateentitywithweapons(var_1[0], var_2[0], var_1[1], var_2[1], var_1[2], var_2[2], var_1[3], var_2[3]);
  updatelaserstatus();
}

function updatelaserstatus() {
  if(isDefined(self.custom_laser_function)) {
    [[self.custom_laser_function]]();
    return;
  }

  if(!isDefined(self.a.weaponpos) || getqueuedspleveltransients(self.a.weaponpos["right"])) {
    return;
  }

  if(canuselaser()) {
    self laseron();
    return;
  }

  self laseroff();
}

function canuselaser() {
  if(!self.a.laseron) {
    return 0;
  }

  if(scripts\anim\utility_common::isshotgun(self.weapon)) {
    return 0;
  }

  return isalive(self);
}

function gettagforpos(var_0) {
  switch (var_0) {
    case "chest":
      return "tag_stowed_chest";
    case "back":
      return "tag_stowed_back";
    case "left":
      return "tag_weapon_left";
    case "right":
      return "tag_weapon_right";
    case "hand":
      return "tag_accessory_right";
    case "thigh":
      return "tag_stowed_thigh";
    default:
      break;
  }
}

function dropaiweaponinternal(var_0) {
  var_1 = createheadicon(var_0);
  var_2 = self.weaponinfo[var_1].position;

  if(self.dropweapon && var_2 != "none") {
    thread dropweaponwrapper(var_0, var_2);
  }

  detachweapon(var_0);

  if(var_0 == self.weapon) {
    self.weapon = isundefinedweapon();
  }

  if(var_0 == self.primaryweapon) {
    self.primaryweapon = isundefinedweapon();
  }

  if(var_0 == self.secondaryweapon) {
    self.secondaryweapon = isundefinedweapon();
  }

  if(var_0 == self.sidearm) {
    if(!nullweapon(self.primaryweapon)) {
      dropaiweaponinternal(self.primaryweapon);
    }

    self.sidearm = isundefinedweapon();
    return;
  }
}

function dropaiweapon(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self.weapon;
  }

  if(nullweapon(var_0)) {
    return;
  }

  if(isDefined(self.nodrop)) {
    return;
  }

  detachallweaponmodels();
  dropaiweaponinternal(var_0);

  if(nullweapon(self.primaryweapon)) {
    if(!nullweapon(self.weapon)) {
      self.primaryweapon = self.weapon;
    } else if(!nullweapon(self.secondaryweapon)) {
      self.primaryweapon = self.secondaryweapon;
    } else if(!nullweapon(self.sidearm)) {
      self.primaryweapon = self.sidearm;
    }

    if(self.primaryweapon == self.secondaryweapon) {
      self.secondaryweapon = isundefinedweapon();
    }
  }

  updateattachedweaponmodels();
}

function dropallaiweapons() {
  if(isDefined(self.nodrop)) {
    return "none";
  }

  if(!isDefined(self.a) || !isDefined(self.a.weaponpos)) {
    return;
  }

  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, "left");
}

function dropweaponwrapper(var_0, var_1) {
  if(self isragdoll()) {
    return "none";
  }

  self.a.weaponposdropping[var_1] = var_0;
  var_2 = var_0;
  var_3 = var_0.basename;

  if(issubstr(tolower(var_3), "_ai")) {
    var_3 = getsubstr(var_3, 0, var_3.size - 3);
    var_2 = getcompleteweaponname(var_3, var_0.attachments);
  }

  thread setdroppedweaponammo(var_2);

  if(isagent(self)) {
    if(isDefined(level.dropped_weapon_func)) {
      self thread[[level.dropped_weapon_func]](var_2, var_1);
    } else {
      self dropweaponnovelocity(var_2, var_1);
    }
  } else if(canaiflingweapon(self)) {
    if(var_1 == "back" || var_1 == "thigh") {
      var_4 = "tag_stowed_" + var_1;
    } else {
      var_4 = "tag_weapon_" + var_2;
    }

    if(!scripts\engine\utility::hastag(self.model, var_4)) {
      self dropweapon(var_3, var_2, 0);
      self endon("end_weapon_drop_" + var_2);
      waitframe();
      return;
    }

    var_5 = self gettagorigin(var_4);
    self endon("end_weapon_drop_" + var_2);
    waitframe();

    if(!isDefined(self)) {
      return;
    }

    var_6 = self gettagorigin(var_4);
    var_7 = self gettagangles(var_4);
    var_8 = createheadicon(var_3);
    var_9 = spawn("weapon_" + var_8, var_6);
    var_9.angles = var_7;
    var_10 = var_6 - var_5;
    var_11 = vectorNormalize(var_10);
    var_12 = 20;
    var_13 = 50;
    var_14 = min(length(var_10) * var_12, var_13);
    var_15 = var_11 * var_14;
    var_16 = (0, 0, 950);
    var_17 = var_6 + var_11 * -1;
    var_18 = var_15 + var_16;

    if(weaponclass(var_3) == "pistol") {
      var_18 *= 0.5;
    }

    var_9 physicslaunchserveritem(var_17, var_18);
  } else {
    self dropweapon(var_3, var_2, 0);
    self endon("end_weapon_drop_" + var_2);
    waitframe();
  }

  if(!isDefined(self)) {
    return;
  }

  if(isagent(self) && !isalive(self)) {
    return;
  }

  detachallweaponmodels();
  self.a.weaponposdropping[var_2] = undefined;
  updateattachedweaponmodels();
}

function canaiflingweapon(var_0) {
  if(!getdvarint("scr_ai_fling_gun", 0)) {
    return false;
  }

  if(!scripts\common\utility::issp()) {
    return false;
  }

  if(!isDefined(var_0.lastattacker)) {
    return false;
  }

  if(!isPlayer(var_0.lastattacker)) {
    return false;
  }

  if(isexplosivedamagemod(var_0.damagemod)) {
    return true;
  }

  var_1 = 300;

  if(distance(var_0.lastattacker.origin, var_0.origin) < var_1) {
    return false;
  }

  return true;
}

function setdroppedweaponammo(var_0) {
  self waittill("weapon_dropped", var_1);
  var_1 endon("death");

  if(isDefined(var_0) && isvaliddroppedweapon(var_0)) {
    if(isDefined(var_1)) {
      var_1 physics_registerforcollisioncallback();
      thread weapondrop_physics_callback_monitor(var_1);
      var_2 = getsubstr(var_1.classname, 7, var_1.classname.size);
      setscriptammo(var_1, var_2, self);
      return;
    }

    return;
  }
}

function isvaliddroppedweapon(var_0) {
  if(var_0.ismelee) {
    return false;
  }

  return true;
}

function weapondrop_physics_callback_monitor(var_0) {
  self endon("death");
  self endon("timeout");
  thread weapondrop_physics_timeout(2);
  self waittill("collision", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  var_9 = physics_getsurfacetypefromflags(var_4);
  var_10 = getsubstr(var_9["name"], 9);

  if(var_10 == "user_terrain1") {
    var_10 = "user_terrain_1";
  }

  if(isDefined(var_0.classname) && isDefined(self)) {
    var_11 = "weap_drop_med";

    switch (var_0.classname) {
      case "rifle":
        var_11 = "weap_drop_med";
        break;
      case "smg":
        var_11 = "weap_drop_small";
        break;
      case "mg":
        var_11 = "weap_drop_xlarge";
        break;
      case "spread":
        var_11 = "weap_drop_large";
        break;
      case "sniper":
        var_11 = "weap_drop_large";
        break;
      case "pistol":
        var_11 = "weap_drop_pistol";
        break;
      case "grenade":
        var_11 = "weap_drop_launcher";
        break;
      case "rocketlauncher":
        var_11 = "weap_drop_launcher";
        break;
    }

    if(soundexists(var_11)) {
      self playsurfacesound(var_11, var_10);
      return;
    }

    return;
  }
}

function weapondrop_physics_timeout(var_0) {
  wait var_0;
  self notify("timeout");
}

function getaimyawtoshootentorpos() {
  if(!isDefined(self.shootent)) {
    if(!isDefined(self.shootpos)) {
      return 0;
    }

    return scripts\engine\utility::getaimyawtopoint(self.shootpos);
  }

  return scripts\engine\utility::getaimyawtopoint(self.shootent getshootatpos());
}

function getaimpitchtoshootentorpos() {
  var_0 = getpitchtoshootentorpos();

  if(self.script == "cover_crouch" && isDefined(self.a.covermode) && self.a.covermode == "lean") {
    var_0 -= anim.covercrouchleanpitch;
  }

  return var_0;
}

function getpitchtoshootentorpos() {
  if(!isDefined(self.shootent)) {
    if(!isDefined(self.shootpos)) {
      return 0;
    }

    return scripts\anim\combat_utility::getpitchtoshootspot(self.shootpos);
  }

  return scripts\anim\combat_utility::getpitchtoshootspot(self.shootent getshootatpos());
}

function ramboaim(var_0) {
  self endon("killanimscript");
  ramboaiminternal(var_0);
}

function ramboaiminternal(var_0) {}

function decidenumshotsforburst() {
  var_0 = 0;
  var_1 = weaponburstcount(self.weapon);

  if(var_1) {
    var_0 = var_1;
  } else if(scripts\anim\weaponlist::usingsemiautoweapon()) {
    var_0 = anim.semifirenumshots[randomint(anim.semifirenumshots.size)];
  } else if(self.fastburst) {
    var_0 = anim.fastburstfirenumshots[randomint(anim.fastburstfirenumshots.size)];
  } else {
    var_0 = anim.burstfirenumshots[randomint(anim.burstfirenumshots.size)];
  }

  if(var_0 <= self.bulletsinclip) {
    return var_0;
  }

  if(self.bulletsinclip <= 0) {
    return 1;
  }

  return self.bulletsinclip;
}

function decidenumshotsforfull() {
  var_0 = self.bulletsinclip;

  if(weaponclass(self.weapon) == "mg") {
    var_1 = randomfloat(10);

    if(var_1 < 3) {
      var_0 = randomintrange(2, 6);
    } else if(var_1 < 8) {
      var_0 = randomintrange(6, 12);
    } else {
      var_0 = randomintrange(12, 20);
    }
  }

  return var_0;
}

function hideweaponmagattachment(var_0) {
  self.weaponinfo[var_0].hasclip = 0;
  updateattachedweaponmodels();
}

function showweaponmagattachment(var_0) {
  self.weaponinfo[var_0].hasclip = 1;
  updateattachedweaponmodels();
}

function handledropclip(var_0) {
  self endon("abort_reload");
  self endon(var_0 + "_finished");
  var_1 = self.weapon;
  var_2 = createheadicon(var_1);
  var_3 = undefined;

  if(self.weaponinfo[var_2].useclip) {
    var_3 = getweaponclipmodel(self.weapon);
  }

  if(self.weaponinfo[var_2].hasclip) {
    if(scripts\anim\utility_common::isusingsidearm()) {
      self playSound("weap_reload_pistol_clipout_npc");
    } else {
      self playSound("weap_reload_smg_clipout_npc");
    }

    if(isDefined(var_3)) {
      hideweaponmagattachment(var_2);
      thread dropclipmodel(var_3, "tag_clip");
    }
  }

  var_4 = 0;

  while(!var_4) {
    self waittill(var_0, var_5);

    if(!isarray(var_5)) {
      var_5 = [var_5];
    }

    foreach(var_7 in var_5) {
      switch (var_7) {
        case "attach clip left":
          if(isDefined(var_3)) {
            self attach(var_3, "tag_accessory_left");
          }

          scripts\anim\weaponlist::refillclip();
          break;
        case "attach clip right":
          if(isDefined(var_3)) {
            self attach(var_3, "tag_accessory_right");
          }

          scripts\anim\weaponlist::refillclip();
          break;
        case "detach clip nohand":
          if(isDefined(var_3)) {
            self detach(var_3, "tag_accessory_right");
          }

          break;
        case "detach clip right":
          if(isDefined(var_3)) {
            self detach(var_3, "tag_accessory_right");

            if(var_1 == self.weapon) {
              showweaponmagattachment(var_2);
            } else {
              self.weaponinfo[createheadicon(self.weapon)].hasclip = 1;
              self.weaponinfo[var_2].hasclip = 1;
            }

            self notify("clip_detached");
          }

          self.a.needstorechamber = 0;
          var_4 = 1;
          break;
        case "detach clip left":
          if(isDefined(var_3)) {
            self detach(var_3, "tag_accessory_left");

            if(var_1 == self.weapon) {
              showweaponmagattachment(var_2);
            } else {
              self.weaponinfo[createheadicon(self.weapon)].hasclip = 1;
              self.weaponinfo[var_2].hasclip = 1;
            }

            self notify("clip_detached");
          }

          self.a.needstorechamber = 0;
          var_4 = 1;
          break;
      }
    }
  }
}

function dropclipmodel(var_0, var_1) {}

function movetonodeovertime(var_0, var_1) {
  self endon("killanimscript");
  var_2 = var_0.origin;
  var_3 = distancesquared(self.origin, var_2);

  if(var_3 < 1) {
    self safeteleport(var_2);
    return;
  }

  if(var_3 > 256 && !self maymovetopoint(var_2, !scripts\engine\utility::actor_is3d())) {
    return;
  }

  self.keepclaimednodeifvalid = 1;
  var_4 = distance(self.origin, var_2);
  var_5 = int(var_1 * 20);

  for(var_6 = 0; var_6 < var_5; var_6++) {
    var_2 = var_0.origin;
    var_7 = self.origin - var_2;
    var_7 = vectorNormalize(var_7);
    var_8 = var_2 + var_7 * var_4;
    var_9 = var_8 + (var_2 - var_8) * (var_6 + 1) / var_5;
    self safeteleport(var_9);
    wait 0.05;
  }

  self.keepclaimednodeifvalid = 0;
}

function returntrue() {
  return true;
}

#using_animtree("generic_human");

function playlookanimation(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = &returntrue;
  }

  for(var_3 = 0; var_3 < var_1 * 10; var_3++) {
    if(isalive(self.enemy)) {
      if(scripts\anim\utility_common::canseeenemy() && [[var_2]]()) {
        return;
      }
    }

    if(scripts\anim\utility_common::issuppressedwrapper() && [[var_2]]()) {
      return;
    }

    self setanimknoball(var_0, %body, 1, 0.1);
    wait 0.1;
  }
}

function throwdownweapon(var_0) {
  self endon("killanimscript");
  placeweaponon(self.secondaryweapon, "right");
  scripts\common\gameskill::didsomethingotherthanshooting();
}

function rpgplayerrepulsor() {
  var_0 = rpgplayerrepulsor_getnummisses();

  if(var_0 == 0) {
    return;
  }

  self endon("death");

  for(;;) {
    level waittill("an_enemy_shot", var_1);

    if(var_1 != self) {
      continue;
    }

    if(!isDefined(var_1.enemy)) {
      continue;
    }

    if(!isPlayer(var_1.enemy)) {
      continue;
    }

    if(isDefined(level.createrpgrepulsors) && level.createrpgrepulsors == 0) {
      continue;
    }

    thread rpgplayerrepulsor_create(var_1.enemy);
    var_0--;

    if(var_0 <= 0) {
      return;
    }
  }
}

function rpgplayerrepulsor_getnummisses() {
  var_0 = scripts\common\utility::getdifficulty();

  switch (var_0) {
    case "gimp":
    case "easy":
      return 2;
    case "difficult":
    case "hard":
    case "medium":
    case "mp":
      return 1;
    case "fu":
      return 0;
  }

  return 2;
}

function rpgplayerrepulsor_create(var_0) {
  var_1 = missile_createrepulsorent(var_0, 5000, 800);
  wait 4;
  missile_deleteattractor(var_1);
}

function pickandsetforceweapon() {
  if(isDefined(self.weaponoverride) && self.weaponoverride) {
    return;
  }

  if(scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), self.origin, 0.173648)) {
    return;
  }

  var_0 = undefined;

  if(distancesquared(self.origin, self.enemy.origin) < self.closeweaponmaxdist * self.closeweaponmaxdist) {
    var_0 = self.forcedweaponclose;
  } else {
    var_0 = self.forcedweaponfar;
  }

  if(var_0 != self.weapon) {
    forceuseweapon(var_0, "primary");
    self.weapon_stow setModel(getweaponmodel(self.forcedweapon));
    self.forcedweapon = var_0;
    return;
  }
}

function forceuseweapon(var_0, var_1) {
  var_2 = undefined;

  if(issameweapon(var_0)) {
    var_2 = var_0;
  } else {
    var_2 = [[level.fnbuildweapon]](var_0);
  }

  if(istrue(self.script_fakeactor) || istrue(self.script_drone)) {
    scripts\common\ai::gun_remove();
    scripts\common\ai::set_start_cash(getweaponattachmentworldmodels(var_2));
    return;
  }

  if(!scripts\common\utility::isweaponinitialized(var_2)) {
    scripts\common\utility::initweapon(var_2);
  }

  var_3 = !nullweapon(self.weapon);
  var_4 = scripts\anim\utility_common::isusingsidearm();
  var_5 = var_1 == "sidearm";
  var_6 = var_1 == "secondary";

  if(var_3 && var_4 != var_5) {
    if(var_4) {
      var_7 = "none";
    } else if(var_7) {
      var_7 = "back";
    } else {
      var_7 = "chest";
    }

    placeweaponon(self.weapon, var_7);
    self.lastweapon = self.weapon;
  } else {
    self.lastweapon = var_4;
  }

  placeweaponon(var_4, "right");

  if(var_7) {
    self.sidearm = var_4;
  } else if(var_7) {
    self.secondaryweapon = var_4;
  } else {
    self.primaryweapon = var_4;
  }

  self.weapon = var_4;
  self.bulletsinclip = weaponclipsize(self.weapon);
  self notify("weapon_switch_done");
  updateweaponarchetype(weaponclass(self.weapon));
}

function updateweaponarchetype(var_0) {
  if(!isDefined(self._blackboard) || scripts\asm\asm_bb::bb_isanimScripted() || !isDefined(self.asm) || !isDefined(self.asm.archetype)) {
    return;
  }

  var_1 = scripts\asm\shared\utility::getbasearchetype();

  if(var_0 == "pistol" && archetypeassetloaded(var_1 + "_pistol")) {
    scripts\asm\shared\utility::setoverridearchetype("weapon", var_1 + "_pistol");
    return;
  }

  if(var_0 == "mg" && archetypeassetloaded(var_1 + "_lmg")) {
    scripts\asm\shared\utility::setoverridearchetype("weapon", var_1 + "_lmg");
    return;
  }

  scripts\asm\shared\utility::clearoverridearchetype("weapon");
}

function everusessecondaryweapon() {
  if(scripts\anim\utility_common::isshotgun(self.secondaryweapon)) {
    return true;
  }

  if(weaponclass(self.primaryweapon) == "rocketlauncher") {
    return true;
  }

  return false;
}

function default_weaponsetup(var_0) {
  if(!isDefined(self.stowsidearmposition)) {
    if(istrue(self.bhasthighholster)) {
      self.stowsidearmposition = "thigh";
    } else {
      self.stowsidearmposition = anim.stowsidearmpositiondefault;
    }
  }

  if(istrue(self.scriptedweaponfailed)) {
    if(isDefined(level.fnscriptedweaponassignment)) {
      if(isDefined(self.scriptedweaponfailed_primaryarray)) {
        self.primaryweapon = [[level.fnscriptedweaponassignment]](self.scriptedweaponfailed_primaryarray);
        self.scriptedweaponfailed_primaryarray = undefined;
      }

      if(isDefined(self.scriptedweaponfailed_sidearmarray)) {
        self.sidearm = [[level.fnscriptedweaponassignment]](self.scriptedweaponfailed_sidearmarray, "sidearm");
        self.scriptedweaponfailed_sidearmarray = undefined;
      }

      if(isDefined(self.scriptedweaponfailed_secondaryarray)) {
        self.secondaryweapon = [[level.fnscriptedweaponassignment]](self.scriptedweaponfailed_secondaryarray);
        self.scriptedweaponfailed_secondaryarray = undefined;
      }
    }
  } else if(!istrue(self.usescriptedweapon) && (!isDefined(self.agent_type) || !(self.agent_type == "actor_enemy_cp_rus_desert_ar_ak_laser" || self.agent_type == "actor_enemy_cp_rus_desert_sniper_nvg"))) {
    if(!scripts\common\utility::issp()) {
      if(issameweapon(self.primaryweapon)) {
        var_1 = getweaponbasename(self.primaryweapon);

        if(!scripts\common\utility::iscp()) {
          var_1 = [[level.fngetweaponrootname]](var_1);
        }

        if(var_1 != "none") {
          self.primaryweapon = [[level.fnbuildweapon]](var_1, [], "none", "none");
        }
      } else {
        self.primaryweapon = [[level.fnbuildweapon]](self.primaryweapon, [], "none", "none");
      }

      if(issameweapon(self.secondaryweapon)) {
        var_1 = getweaponbasename(self.secondaryweapon);

        if(!scripts\common\utility::iscp()) {
          var_1 = [[level.fngetweaponrootname]](var_1);
        }

        if(var_1 != "none") {
          self.secondaryweapon = [[level.fnbuildweapon]](var_1, [], "none", "none");
        }
      } else {
        self.secondaryweapon = [[level.fnbuildweapon]](self.secondaryweapon, [], "none", "none");
      }

      if(issameweapon(self.sidearm)) {
        var_1 = getweaponbasename(self.sidearm);

        if(!scripts\common\utility::iscp()) {
          var_1 = [[level.fngetweaponrootname]](var_1);
        }

        if(var_1 != "none") {
          self.sidearm = [[level.fnbuildweapon]](var_1, [], "none", "none");
        }
      } else {
        self.sidearm = [[level.fnbuildweapon]](self.sidearm, [], "none", "none");
      }
    } else {
      self.primaryweapon = [[level.fnbuildweapon]](self.primaryweapon, []);
      self.secondaryweapon = [[level.fnbuildweapon]](self.secondaryweapon, []);
      self.sidearm = [[level.fnbuildweapon]](self.sidearm, []);
    }
  }

  scripts\common\utility::initweapon(self.primaryweapon);
  scripts\common\utility::initweapon(self.secondaryweapon);
  scripts\common\utility::initweapon(self.sidearm);
  var_2 = self.classname;

  if(isagent(self)) {
    var_2 = self.agent_type;
  }

  self setdefaultaimlimits();
  self.a.weaponpos = [];
  self.a.weaponposdropping = [];
  self.lastweapon = self.weapon;
  var_3 = scripts\anim\utility_common::usingrocketlauncher();
  self.a.neverlean = var_3;

  if(var_3) {
    thread rpgplayerrepulsor();
  }

  self.rocketammo = 100;
  placeweaponon(self.primaryweapon, "right");

  if(scripts\anim\utility_common::isshotgun(self.secondaryweapon)) {
    placeweaponon(self.secondaryweapon, "back");
  }

  if(!nullweapon(self.sidearm) && isDefined(self.stowsidearmposition)) {
    placeweaponon(self.sidearm, self.stowsidearmposition);
  }

  if(self.team != "allies") {
    self.has_no_ir = 1;
  }

  scripts\anim\weaponlist::refillclip();
}

function initdeaths() {
  anim.numdeathsuntilcrawlingpain = randomintrange(0, 15);
  anim.numdeathsuntilcornergrenadedeath = randomintrange(0, 10);
  anim.nextcrawlingpaintime = gettime() + randomintrange(0, 20000);
  anim.nextcrawlingpaintimefromlegdamage = gettime() + randomintrange(0, 10000);
  anim.nextcornergrenadedeathtime = gettime() + randomintrange(0, 15000);
  anim.nextbalconydeathtime = gettime() + randomintrange(0, 1000);
}

function initadvancetoenemy() {
  level.lastadvancetoenemytime = [];
  level.lastadvancetoenemytime["axis"] = 0;
  level.lastadvancetoenemytime["allies"] = 0;
  level.lastadvancetoenemytime["team3"] = 0;
  level.lastadvancetoenemytime["neutral"] = 0;
  level.lastadvancetoenemydest = [];
  level.lastadvancetoenemydest["axis"] = (0, 0, 0);
  level.lastadvancetoenemydest["allies"] = (0, 0, 0);
  level.lastadvancetoenemydest["team3"] = (0, 0, 0);
  level.lastadvancetoenemydest["neutral"] = (0, 0, 0);
  level.lastadvancetoenemysrc = [];
  level.lastadvancetoenemysrc["axis"] = (0, 0, 0);
  level.lastadvancetoenemysrc["allies"] = (0, 0, 0);
  level.lastadvancetoenemysrc["team3"] = (0, 0, 0);
  level.lastadvancetoenemysrc["neutral"] = (0, 0, 0);
  level.lastadvancetoenemyattacker = [];
  level.advancetoenemygroup = [];
  level.advancetoenemygroup["axis"] = 0;
  level.advancetoenemygroup["allies"] = 0;
  level.advancetoenemygroup["team3"] = 0;
  level.advancetoenemygroup["neutral"] = 0;
  level.advancetoenemyinterval = 2000;
  level.advancetoenemygroupmax = 3;
}

function initmeleecharges() {
  anim.meleechargetimers["c6"] = 0;
  anim.meleechargeintervals["c6"] = 9000;
  anim.meleechargeplayertimers["c6"] = 0;
  anim.meleechargeplayerintervals["c6"] = 15000;
  anim.meleechargetimers["seeker"] = 0;
  anim.meleechargeintervals["seeker"] = 9000;
  anim.meleechargeplayertimers["seeker"] = 0;
  anim.meleechargeplayerintervals["seeker"] = 15000;
}

function init_squadmanager() {
  if(isDefined(anim.squadinitialized) && anim.squadinitialized) {
    return;
  }

  anim.squadcreatefuncs = [];
  anim.squadcreatestrings = [];
  anim.squads = [];
  anim.squadindex = [];
  anim.squadrand = 0;
  anim.squadinitialized = 1;
}

function initanimvars() {
  anim.animflagnameindex = 0;
  anim.combatmemorytimeconst = 10000;
  anim.combatmemorytimerand = 6000;
  anim.weaponsetupfuncs = [];
  anim.weaponsetupfuncs["c12"] = &c12_weaponsetup;
  anim.dismemberheavyfx = [];
  anim.weaponstowfunction = &pickandsetforceweapon;

  if(!isDefined(anim.optionalstepeffects)) {
    anim.optionalstepeffects = [];
  }

  if(!isDefined(anim.optionalstepeffectssmall)) {
    anim.optionalstepeffectssmall = [];
  }

  if(!isDefined(anim.optionalfootprinteffects)) {
    anim.optionalfootprinteffects = [];
  }

  if(!isDefined(anim.shootenemywrapper_func)) {
    anim.shootenemywrapper_func = &scripts\anim\utility::shootenemywrapper_shootnotify;
  }

  if(!isDefined(anim.shootposwrapper_func)) {
    anim.shootposwrapper_func = &scripts\anim\utility::shootposwrapper;
  }

  anim.fire_notetrack_functions = [];
  anim.lastcarexplosiontime = -100000;
  anim.burstfirenumshots = scripts\anim\utility::array(1, 2, 2, 2, 3, 3, 3, 3, 4, 4, 5);
  anim.fastburstfirenumshots = scripts\anim\utility::array(2, 3, 3, 3, 4, 4, 4, 5, 5);
  anim.semifirenumshots = scripts\anim\utility::array(1, 2, 2, 3, 3, 4, 4, 4, 4, 5, 5, 5);
  anim.badplaces = [];
  anim.badplaceint = 0;
}

function c12_getweapontypeforweapon() {
  if(scripts\anim\utility_common::usingrocketlauncher()) {
    return "rocket";
  } else if(scripts\anim\utility_common::usingriflelikeweapon()) {
    return "minigun";
  }

  return undefined;
}

function c12_weaponsetup() {
  self.weapons = [];

  if(!nullweapon(self.primaryweapon)) {
    self.weapon = self.primaryweapon;
    self.weapons["right"] = c12_getweapontypeforweapon();
  }

  if(!nullweapon(self.secondaryweapon)) {
    self.weapon = self.secondaryweapon;
    self.weapons["left"] = c12_getweapontypeforweapon();
  }

  self.weapon = isundefinedweapon();
  self.bulletsinclip = 1;
}

function initwindowtraverse() {
  level.window_down_height[0] = -36.8552;
  level.window_down_height[1] = -27.0095;
  level.window_down_height[2] = -15.5981;
  level.window_down_height[3] = -4.37769;
  level.window_down_height[4] = 17.7776;
  level.window_down_height[5] = 59.8499;
  level.window_down_height[6] = 104.808;
  level.window_down_height[7] = 152.325;
  level.window_down_height[8] = 201.052;
  level.window_down_height[9] = 250.244;
  level.window_down_height[10] = 298.971;
  level.window_down_height[11] = 330.681;
}

function setuprandomtable() {
  anim.randominttablesize = 60;
  anim.randominttable = [];

  for(var_0 = 0; var_0 < anim.randominttablesize; var_0++) {
    anim.randominttable[var_0] = var_0;
  }

  for(var_0 = 0; var_0 < anim.randominttablesize; var_0++) {
    var_1 = randomint(anim.randominttablesize);
    var_2 = anim.randominttable[var_0];
    anim.randominttable[var_0] = anim.randominttable[var_1];
    anim.randominttable[var_1] = var_2;
  }
}

function setupweapons() {
  self endon("death");
  scripts\engine\utility::flag_wait("load_finished");

  if(isDefined(anim.weaponsetupfuncs) && isDefined(anim.weaponsetupfuncs[self.unittype])) {
    self[[anim.weaponsetupfuncs[self.unittype]]]();
    return;
  }

  default_weaponsetup();
}

function setscriptammo(var_0, var_1, var_2) {
  if(isDefined(var_1.script_ammo_clip)) {
    self itemweaponsetammo(var_1.script_ammo_clip, var_1.script_ammo_extra);
  } else if(isDefined(var_1.script_ammo_extra)) {
    self itemweaponsetammo(var_1.script_ammo_clip, var_1.script_ammo_extra);
  }

  if(isDefined(var_1.script_ammo_alt_clip)) {
    self itemweaponsetammo(var_1.script_ammo_alt_clip, var_1.script_ammo_alt_extra, undefined, 1);
  } else if(isDefined(var_1.script_ammo_alt_extra)) {
    self itemweaponsetammo(var_1.script_ammo_alt_clip, var_1.script_ammo_alt_extra, undefined, 1);
  }

  if(isDefined(var_1.script_ammo_max)) {
    self itemweaponsetammo(weaponclipsize(self), weaponmaxammo(self));
  }

  if(istrue(var_2)) {
    self itemweaponsetammo(1, 6, 0, 1);
    return;
  }

  if(issubstr(var_0, "ub_golf25_sp") || issubstr(var_0, "ub_mike203_sp")) {
    self itemweaponsetammo(1, 1, 0, 1);
    return;
  }
}
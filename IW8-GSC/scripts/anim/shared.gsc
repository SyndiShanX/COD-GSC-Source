/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\shared.gsc
***********************************************/

function placeweaponon(var0, var1, var2) {
  var3 = undefined;
  var4 = undefined;

  if(issameweapon(var0)) {
    var3 = var0;
    var4 = createheadicon(var0);
  } else {
    var3 = asmdevgetallstates(var0);
    var4 = var0;
  }

  self notify("weapon_position_change");
  var5 = self.weaponinfo[var4].position;

  if(var1 != "none" && isDefined(self.a.weaponpos[var1]) && self.a.weaponpos[var1] == var3) {
    return;
  }

  detachallweaponmodels();

  if(var5 != "none") {
    detachweapon(var3);
  }

  if(var1 == "none") {
    updateattachedweaponmodels();
    return;
  }

  if(!getqueuedspleveltransients(self.a.weaponpos[var1])) {
    detachweapon(self.a.weaponpos[var1]);
  }

  if(!isDefined(var2)) {
    var2 = 1;
  }

  if(var2 && (var1 == "left" || var1 == "right")) {
    attachweapon(var3, var1);
    self.weapon = var3;
  } else {
    attachweapon(var3, var1);
  }

  updateattachedweaponmodels();
}

function detachweapon(var0) {
  var1 = createheadicon(var0);
  self.a.weaponpos[self.weaponinfo[var1].position] = undefined;
  self.weaponinfo[var1].position = "none";
}

function attachweapon(var0, var1) {
  var2 = createheadicon(var0);
  self.weaponinfo[var2].position = var1;
  self.a.weaponpos[var1] = var0;

  if(!getqueuedspleveltransients(self.a.weaponposdropping[var1])) {
    self notify("end_weapon_drop_" + var1);
    self.a.weaponposdropping[var1] = undefined;
    return;
  }
}

function getweaponforpos(var0) {
  var1 = self.a.weaponpos[var0];

  if(getqueuedspleveltransients(var1)) {
    return self.a.weaponposdropping[var0];
  }

  return var1;
}

function detachallweaponmodels() {
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "right");
}

function updateattachedweaponmodels() {
  var0 = [];
  var1 = [];
  var2 = [];
  var0 = "right";
  var0 = "left";
  var0 = "chest";
  var0 = "back";
  var0 = "thigh";

  foreach(var4 in var0) {
    var5 = var1.size;
    var6 = getweaponforpos(var4);

    if(!getqueuedspleveltransients(var6) && !nullweapon(var6)) {
      var7 = createheadicon(var6);

      if(self.weaponinfo[var7].useclip && !self.weaponinfo[var7].hasclip) {
        var6 = var6 withoutattachment(var6.magazine);
      }
    }

    if(isDefined(var6)) {
      var8 = gettagforpos(var4);

      if(self tagexists(var8)) {
        var1 = var6;
        var2 = var8;
      }
    }
  }

  self updateentitywithweapons(var1[0], var2[0], var1[1], var2[1], var1[2], var2[2], var1[3], var2[3]);
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

function gettagforpos(var0) {
  switch (var0) {
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

function dropaiweaponinternal(var0) {
  var1 = createheadicon(var0);
  var2 = self.weaponinfo[var1].position;

  if(self.dropweapon && var2 != "none") {
    thread dropweaponwrapper(var0, var2);
  }

  detachweapon(var0);

  if(var0 == self.weapon) {
    self.weapon = isundefinedweapon();
  }

  if(var0 == self.primaryweapon) {
    self.primaryweapon = isundefinedweapon();
  }

  if(var0 == self.secondaryweapon) {
    self.secondaryweapon = isundefinedweapon();
  }

  if(var0 == self.sidearm) {
    if(!nullweapon(self.primaryweapon)) {
      dropaiweaponinternal(self.primaryweapon);
    }

    self.sidearm = isundefinedweapon();
    return;
  }
}

function dropaiweapon(var0) {
  if(!isDefined(var0)) {
    var0 = self.weapon;
  }

  if(nullweapon(var0)) {
    return;
  }

  if(isDefined(self.nodrop)) {
    return;
  }

  detachallweaponmodels();
  dropaiweaponinternal(var0);

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

  var0 = [];
  GscBinSkip0(0x2e, var0.size, "left");
}

function dropweaponwrapper(var0, var1) {
  if(self isragdoll()) {
    return "none";
  }

  self.a.weaponposdropping[var1] = var0;
  var2 = var0;
  var3 = var0.basename;

  if(issubstr(tolower(var3), "_ai")) {
    var3 = getsubstr(var3, 0, var3.size - 3);
    var2 = getcompleteweaponname(var3, var0.attachments);
  }

  thread setdroppedweaponammo(var2);

  if(isagent(self)) {
    if(isDefined(level.dropped_weapon_func)) {
      self thread[[level.dropped_weapon_func]](var2, var1);
    } else {
      self dropweaponnovelocity(var2, var1);
    }
  } else if(canaiflingweapon(self)) {
    if(var1 == "back" || var1 == "thigh") {
      var4 = "tag_stowed_" + var1;
    } else {
      var4 = "tag_weapon_" + var2;
    }

    if(!scripts\engine\utility::hastag(self.model, var4)) {
      self dropweapon(var3, var2, 0);
      self endon("end_weapon_drop_" + var2);
      waitframe();
      return;
    }

    var5 = self gettagorigin(var4);
    self endon("end_weapon_drop_" + var2);
    waitframe();

    if(!isDefined(self)) {
      return;
    }

    var6 = self gettagorigin(var4);
    var7 = self gettagangles(var4);
    var8 = createheadicon(var3);
    var9 = spawn("weapon_" + var8, var6);
    var9.angles = var7;
    var10 = var6 - var5;
    var11 = vectorNormalize(var10);
    var12 = 20;
    var13 = 50;
    var14 = min(length(var10) * var12, var13);
    var15 = var11 * var14;
    var16 = (0, 0, 950);
    var17 = var6 + var11 * -1;
    var18 = var15 + var16;

    if(weaponclass(var3) == "pistol") {
      var18 *= 0.5;
    }

    var9 physicslaunchserveritem(var17, var18);
  } else {
    self dropweapon(var3, var2, 0);
    self endon("end_weapon_drop_" + var2);
    waitframe();
  }

  if(!isDefined(self)) {
    return;
  }

  if(isagent(self) && !isalive(self)) {
    return;
  }

  detachallweaponmodels();
  self.a.weaponposdropping[var2] = undefined;
  updateattachedweaponmodels();
}

function canaiflingweapon(var0) {
  if(!getdvarint("scr_ai_fling_gun", 0)) {
    return false;
  }

  if(!scripts\common\utility::issp()) {
    return false;
  }

  if(!isDefined(var0.lastattacker)) {
    return false;
  }

  if(!isPlayer(var0.lastattacker)) {
    return false;
  }

  if(isexplosivedamagemod(var0.damagemod)) {
    return true;
  }

  var1 = 300;

  if(distance(var0.lastattacker.origin, var0.origin) < var1) {
    return false;
  }

  return true;
}

function setdroppedweaponammo(var0) {
  self waittill("weapon_dropped", var1);
  var1 endon("death");

  if(isDefined(var0) && isvaliddroppedweapon(var0)) {
    if(isDefined(var1)) {
      var1 physics_registerforcollisioncallback();
      thread weapondrop_physics_callback_monitor(var1);
      var2 = getsubstr(var1.classname, 7, var1.classname.size);
      setscriptammo(var1, var2, self);
      return;
    }

    return;
  }
}

function isvaliddroppedweapon(var0) {
  if(var0.ismelee) {
    return false;
  }

  return true;
}

function weapondrop_physics_callback_monitor(var0) {
  self endon("death");
  self endon("timeout");
  thread weapondrop_physics_timeout(2);
  self waittill("collision", var1, var2, var3, var4, var5, var6, var7, var8);
  var9 = physics_getsurfacetypefromflags(var4);
  var10 = getsubstr(var9["name"], 9);

  if(var10 == "user_terrain1") {
    var10 = "user_terrain_1";
  }

  if(isDefined(var0.classname) && isDefined(self)) {
    var11 = "weap_drop_med";

    switch (var0.classname) {
      case "rifle":
        var11 = "weap_drop_med";
        break;
      case "smg":
        var11 = "weap_drop_small";
        break;
      case "mg":
        var11 = "weap_drop_xlarge";
        break;
      case "spread":
        var11 = "weap_drop_large";
        break;
      case "sniper":
        var11 = "weap_drop_large";
        break;
      case "pistol":
        var11 = "weap_drop_pistol";
        break;
      case "grenade":
        var11 = "weap_drop_launcher";
        break;
      case "rocketlauncher":
        var11 = "weap_drop_launcher";
        break;
    }

    if(soundexists(var11)) {
      self playsurfacesound(var11, var10);
      return;
    }

    return;
  }
}

function weapondrop_physics_timeout(var0) {
  wait var0;
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
  var0 = getpitchtoshootentorpos();

  if(self.script == "cover_crouch" && isDefined(self.a.covermode) && self.a.covermode == "lean") {
    var0 -= anim.covercrouchleanpitch;
  }

  return var0;
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

function ramboaim(var0) {
  self endon("killanimscript");
  ramboaiminternal(var0);
}

function ramboaiminternal(var0) {}

function decidenumshotsforburst() {
  var0 = 0;
  var1 = weaponburstcount(self.weapon);

  if(var1) {
    var0 = var1;
  } else if(scripts\anim\weaponlist::usingsemiautoweapon()) {
    var0 = anim.semifirenumshots[randomint(anim.semifirenumshots.size)];
  } else if(self.fastburst) {
    var0 = anim.fastburstfirenumshots[randomint(anim.fastburstfirenumshots.size)];
  } else {
    var0 = anim.burstfirenumshots[randomint(anim.burstfirenumshots.size)];
  }

  if(var0 <= self.bulletsinclip) {
    return var0;
  }

  if(self.bulletsinclip <= 0) {
    return 1;
  }

  return self.bulletsinclip;
}

function decidenumshotsforfull() {
  var0 = self.bulletsinclip;

  if(weaponclass(self.weapon) == "mg") {
    var1 = randomfloat(10);

    if(var1 < 3) {
      var0 = randomintrange(2, 6);
    } else if(var1 < 8) {
      var0 = randomintrange(6, 12);
    } else {
      var0 = randomintrange(12, 20);
    }
  }

  return var0;
}

function hideweaponmagattachment(var0) {
  self.weaponinfo[var0].hasclip = 0;
  updateattachedweaponmodels();
}

function showweaponmagattachment(var0) {
  self.weaponinfo[var0].hasclip = 1;
  updateattachedweaponmodels();
}

function handledropclip(var0) {
  self endon("abort_reload");
  self endon(var0 + "_finished");
  var1 = self.weapon;
  var2 = createheadicon(var1);
  var3 = undefined;

  if(self.weaponinfo[var2].useclip) {
    var3 = getweaponclipmodel(self.weapon);
  }

  if(self.weaponinfo[var2].hasclip) {
    if(scripts\anim\utility_common::isusingsidearm()) {
      self playSound("weap_reload_pistol_clipout_npc");
    } else {
      self playSound("weap_reload_smg_clipout_npc");
    }

    if(isDefined(var3)) {
      hideweaponmagattachment(var2);
      thread dropclipmodel(var3, "tag_clip");
    }
  }

  var4 = 0;

  while(!var4) {
    self waittill(var0, var5);

    if(!isarray(var5)) {
      var5 = [var5];
    }

    foreach(var7 in var5) {
      switch (var7) {
        case "attach clip left":
          if(isDefined(var3)) {
            self attach(var3, "tag_accessory_left");
          }

          scripts\anim\weaponlist::refillclip();
          break;
        case "attach clip right":
          if(isDefined(var3)) {
            self attach(var3, "tag_accessory_right");
          }

          scripts\anim\weaponlist::refillclip();
          break;
        case "detach clip nohand":
          if(isDefined(var3)) {
            self detach(var3, "tag_accessory_right");
          }

          break;
        case "detach clip right":
          if(isDefined(var3)) {
            self detach(var3, "tag_accessory_right");

            if(var1 == self.weapon) {
              showweaponmagattachment(var2);
            } else {
              self.weaponinfo[createheadicon(self.weapon)].hasclip = 1;
              self.weaponinfo[var2].hasclip = 1;
            }

            self notify("clip_detached");
          }

          self.a.needstorechamber = 0;
          var4 = 1;
          break;
        case "detach clip left":
          if(isDefined(var3)) {
            self detach(var3, "tag_accessory_left");

            if(var1 == self.weapon) {
              showweaponmagattachment(var2);
            } else {
              self.weaponinfo[createheadicon(self.weapon)].hasclip = 1;
              self.weaponinfo[var2].hasclip = 1;
            }

            self notify("clip_detached");
          }

          self.a.needstorechamber = 0;
          var4 = 1;
          break;
      }
    }
  }
}

function dropclipmodel(var0, var1) {}

function movetonodeovertime(var0, var1) {
  self endon("killanimscript");
  var2 = var0.origin;
  var3 = distancesquared(self.origin, var2);

  if(var3 < 1) {
    self safeteleport(var2);
    return;
  }

  if(var3 > 256 && !self maymovetopoint(var2, !scripts\engine\utility::actor_is3d())) {
    return;
  }

  self.keepclaimednodeifvalid = 1;
  var4 = distance(self.origin, var2);
  var5 = int(var1 * 20);

  for(var6 = 0; var6 < var5; var6++) {
    var2 = var0.origin;
    var7 = self.origin - var2;
    var7 = vectorNormalize(var7);
    var8 = var2 + var7 * var4;
    var9 = var8 + (var2 - var8) * (var6 + 1) / var5;
    self safeteleport(var9);
    wait 0.05;
  }

  self.keepclaimednodeifvalid = 0;
}

function returntrue() {
  return true;
}

#using_animtree("generic_human");

function playlookanimation(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = &returntrue;
  }

  for(var3 = 0; var3 < var1 * 10; var3++) {
    if(isalive(self.enemy)) {
      if(scripts\anim\utility_common::canseeenemy() && [[var2]]()) {
        return;
      }
    }

    if(scripts\anim\utility_common::issuppressedwrapper() && [[var2]]()) {
      return;
    }

    self setanimknoball(var0, %body, 1, 0.1);
    wait 0.1;
  }
}

function throwdownweapon(var0) {
  self endon("killanimscript");
  placeweaponon(self.secondaryweapon, "right");
  scripts\common\gameskill::didsomethingotherthanshooting();
}

function rpgplayerrepulsor() {
  var0 = rpgplayerrepulsor_getnummisses();

  if(var0 == 0) {
    return;
  }

  self endon("death");

  for(;;) {
    level waittill("an_enemy_shot", var1);

    if(var1 != self) {
      continue;
    }

    if(!isDefined(var1.enemy)) {
      continue;
    }

    if(!isPlayer(var1.enemy)) {
      continue;
    }

    if(isDefined(level.createrpgrepulsors) && level.createrpgrepulsors == 0) {
      continue;
    }

    thread rpgplayerrepulsor_create(var1.enemy);
    var0--;

    if(var0 <= 0) {
      return;
    }
  }
}

function rpgplayerrepulsor_getnummisses() {
  var0 = scripts\common\utility::getdifficulty();

  switch (var0) {
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

function rpgplayerrepulsor_create(var0) {
  var1 = missile_createrepulsorent(var0, 5000, 800);
  wait 4;
  missile_deleteattractor(var1);
}

function pickandsetforceweapon() {
  if(isDefined(self.weaponoverride) && self.weaponoverride) {
    return;
  }

  if(scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), self.origin, 0.173648)) {
    return;
  }

  var0 = undefined;

  if(distancesquared(self.origin, self.enemy.origin) < self.closeweaponmaxdist * self.closeweaponmaxdist) {
    var0 = self.forcedweaponclose;
  } else {
    var0 = self.forcedweaponfar;
  }

  if(var0 != self.weapon) {
    forceuseweapon(var0, "primary");
    self.weapon_stow setModel(getweaponmodel(self.forcedweapon));
    self.forcedweapon = var0;
    return;
  }
}

function forceuseweapon(var0, var1) {
  var2 = undefined;

  if(issameweapon(var0)) {
    var2 = var0;
  } else {
    var2 = [[level.fnbuildweapon]](var0);
  }

  if(istrue(self.script_fakeactor) || istrue(self.script_drone)) {
    scripts\common\ai::gun_remove();
    scripts\common\ai::set_start_cash(getweaponattachmentworldmodels(var2));
    return;
  }

  if(!scripts\common\utility::isweaponinitialized(var2)) {
    scripts\common\utility::initweapon(var2);
  }

  var3 = !nullweapon(self.weapon);
  var4 = scripts\anim\utility_common::isusingsidearm();
  var5 = var1 == "sidearm";
  var6 = var1 == "secondary";

  if(var3 && var4 != var5) {
    if(var4) {
      var7 = "none";
    } else if(var7) {
      var7 = "back";
    } else {
      var7 = "chest";
    }

    placeweaponon(self.weapon, var7);
    self.lastweapon = self.weapon;
  } else {
    self.lastweapon = var4;
  }

  placeweaponon(var4, "right");

  if(var7) {
    self.sidearm = var4;
  } else if(var7) {
    self.secondaryweapon = var4;
  } else {
    self.primaryweapon = var4;
  }

  self.weapon = var4;
  self.bulletsinclip = weaponclipsize(self.weapon);
  self notify("weapon_switch_done");
  updateweaponarchetype(weaponclass(self.weapon));
}

function updateweaponarchetype(var0) {
  if(!isDefined(self._blackboard) || scripts\asm\asm_bb::bb_isanimScripted() || !isDefined(self.asm) || !isDefined(self.asm.archetype)) {
    return;
  }

  var1 = scripts\asm\shared\utility::getbasearchetype();

  if(var0 == "pistol" && archetypeassetloaded(var1 + "_pistol")) {
    scripts\asm\shared\utility::setoverridearchetype("weapon", var1 + "_pistol");
    return;
  }

  if(var0 == "mg" && archetypeassetloaded(var1 + "_lmg")) {
    scripts\asm\shared\utility::setoverridearchetype("weapon", var1 + "_lmg");
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

function default_weaponsetup(var0) {
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
        var1 = getweaponbasename(self.primaryweapon);

        if(!scripts\common\utility::iscp()) {
          var1 = [[level.fngetweaponrootname]](var1);
        }

        if(var1 != "none") {
          self.primaryweapon = [[level.fnbuildweapon]](var1, [], "none", "none");
        }
      } else {
        self.primaryweapon = [[level.fnbuildweapon]](self.primaryweapon, [], "none", "none");
      }

      if(issameweapon(self.secondaryweapon)) {
        var1 = getweaponbasename(self.secondaryweapon);

        if(!scripts\common\utility::iscp()) {
          var1 = [[level.fngetweaponrootname]](var1);
        }

        if(var1 != "none") {
          self.secondaryweapon = [[level.fnbuildweapon]](var1, [], "none", "none");
        }
      } else {
        self.secondaryweapon = [[level.fnbuildweapon]](self.secondaryweapon, [], "none", "none");
      }

      if(issameweapon(self.sidearm)) {
        var1 = getweaponbasename(self.sidearm);

        if(!scripts\common\utility::iscp()) {
          var1 = [[level.fngetweaponrootname]](var1);
        }

        if(var1 != "none") {
          self.sidearm = [[level.fnbuildweapon]](var1, [], "none", "none");
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
  var2 = self.classname;

  if(isagent(self)) {
    var2 = self.agent_type;
  }

  self setdefaultaimlimits();
  self.a.weaponpos = [];
  self.a.weaponposdropping = [];
  self.lastweapon = self.weapon;
  var3 = scripts\anim\utility_common::usingrocketlauncher();
  self.a.neverlean = var3;

  if(var3) {
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

  for(var0 = 0; var0 < anim.randominttablesize; var0++) {
    anim.randominttable[var0] = var0;
  }

  for(var0 = 0; var0 < anim.randominttablesize; var0++) {
    var1 = randomint(anim.randominttablesize);
    var2 = anim.randominttable[var0];
    anim.randominttable[var0] = anim.randominttable[var1];
    anim.randominttable[var1] = var2;
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

function setscriptammo(var0, var1, var2) {
  if(isDefined(var1.script_ammo_clip)) {
    self itemweaponsetammo(var1.script_ammo_clip, var1.script_ammo_extra);
  } else if(isDefined(var1.script_ammo_extra)) {
    self itemweaponsetammo(var1.script_ammo_clip, var1.script_ammo_extra);
  }

  if(isDefined(var1.script_ammo_alt_clip)) {
    self itemweaponsetammo(var1.script_ammo_alt_clip, var1.script_ammo_alt_extra, undefined, 1);
  } else if(isDefined(var1.script_ammo_alt_extra)) {
    self itemweaponsetammo(var1.script_ammo_alt_clip, var1.script_ammo_alt_extra, undefined, 1);
  }

  if(isDefined(var1.script_ammo_max)) {
    self itemweaponsetammo(weaponclipsize(self), weaponmaxammo(self));
  }

  if(istrue(var2)) {
    self itemweaponsetammo(1, 6, 0, 1);
    return;
  }

  if(issubstr(var0, "ub_golf25_sp") || issubstr(var0, "ub_mike203_sp")) {
    self itemweaponsetammo(1, 1, 0, 1);
    return;
  }
}
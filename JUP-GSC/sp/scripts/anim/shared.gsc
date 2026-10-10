/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\anim\shared.gsc
***********************************************/

#using scripts\anim\animselector;
#using scripts\anim\combat_utility;
#using scripts\anim\shared;
#using scripts\anim\utility;
#using scripts\anim\utility_common;
#using scripts\anim\weaponlist;
#using scripts\asm\asm_bb;
#using scripts\common\ai;
#using scripts\common\ai_lookat;
#using scripts\common\gameskill;
#using scripts\common\notetrack;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace shared;

function placeweaponon(weapon, position, activeweapon) {
  assert(isDefined(weapon));
  var_9843089f949dca89 = undefined;
  placeweaponname = undefined;

  if(isweapon(weapon)) {
    var_9843089f949dca89 = weapon;
    placeweaponname = getcompleteweaponname(weapon);
  } else {
    var_9843089f949dca89 = makeweaponfromstring(weapon);
    placeweaponname = weapon;
  }

  assert(aihasweapon(var_9843089f949dca89));
  self notify("weapon_position_change");
  curposition = self.weaponinfo[placeweaponname].position;
  assert(curposition == "none" || isDefined(self.a.weaponpos[curposition]) && self.a.weaponpos[curposition] == var_9843089f949dca89);

  if(position != "none" && isDefined(self.a.weaponpos[position]) && self.a.weaponpos[position] == var_9843089f949dca89) {
    return;
  }

  detachallweaponmodels();

  if(curposition != "none") {
    detachweapon(var_9843089f949dca89);
  }

  if(position == "none") {
    updateattachedweaponmodels();
    return;
  }

  if(!isundefinedweapon(self.a.weaponpos[position])) {
    detachweapon(self.a.weaponpos[position]);
  }

  if(!isDefined(activeweapon)) {
    activeweapon = 1;
  }

  if(activeweapon && (position == "left" || position == "right")) {
    attachweapon(var_9843089f949dca89, position);
    self.weapon = var_9843089f949dca89;
  } else {
    attachweapon(var_9843089f949dca89, position);
  }

  updateattachedweaponmodels();
}

function detachweapon(objweapon) {
  assert(isweapon(objweapon));
  weaponname = getcompleteweaponname(objweapon);
  self.a.weaponpos[self.weaponinfo[weaponname].position] = undefined;
  self.weaponinfo[weaponname].position = "none";
}

function attachweapon(objweapon, position) {
  assert(isweapon(objweapon));
  weaponname = getcompleteweaponname(objweapon);
  self.weaponinfo[weaponname].position = position;
  self.a.weaponpos[position] = objweapon;

  if(!isundefinedweapon(self.a.weaponposdropping[position])) {
    self notify("end_weapon_drop_" + position);
    self.a.weaponposdropping[position] = undefined;
  }
}

function getweaponforpos(position) {
  if(!isDefined(self.a)) {
    return undefined;
  }

  if(!isDefined(self.a.weaponpos)) {
    return undefined;
  }

  weapon = self.a.weaponpos[position];

  if(isundefinedweapon(weapon)) {
    return self.a.weaponposdropping[position];
  }

  assert(isundefinedweapon(self.a.weaponposdropping[position]));
  return weapon;
}

function detachallweaponmodels() {
  positions = [];
  positions[positions.size] = "right";
  positions[positions.size] = "left";
  positions[positions.size] = "chest";
  positions[positions.size] = "back";
  positions[positions.size] = "thigh";
  positions[positions.size] = "inhand";
  self laseroff();

  foreach(position in positions) {
    weapon = getweaponforpos(position);

    if(isundefinedweapon(weapon)) {
      continue;
    }

    if(weapontype(weapon) == "riotshield" && isDefined(self.shieldmodelvariant)) {
      if(isDefined(self.shieldbroken) && self.shieldbroken) {
        playFXOnTag(getfx("riot_shield_dmg"), self, "TAG_BRASS");
        self.shieldbroken = undefined;
      }
    }
  }

  self updateentitywithweapons();
}

function updateattachedweaponmodels() {
  positions = [];
  weapons = [];
  tags = [];
  positions[positions.size] = "right";
  positions[positions.size] = "left";
  positions[positions.size] = "chest";
  positions[positions.size] = "back";
  positions[positions.size] = "thigh";
  positions[positions.size] = "inhand";

  if(!isDefined(self.a)) {
    return;
  }

  if(!isDefined(self.a.weaponpos)) {
    return;
  }

  foreach(position in positions) {
    iweapon = weapons.size;
    weapon = getweaponforpos(position);

    if(!isundefinedweapon(weapon) && !isnullweapon(weapon)) {
      weaponname = getcompleteweaponname(weapon);

      if(self.weaponinfo[weaponname].useclip && !self.weaponinfo[weaponname].hasclip) {
        assert(isDefined(weapon.magazine));
        weapon = weapon withoutattachment(weapon.magazine);
      }
    }

    if(isDefined(weapon)) {
      tagforpos = gettagforpos(position);

      if(self tagexists(tagforpos)) {
        weapons[iweapon] = weapon;
        tags[tags.size] = tagforpos;
      }
    }
  }

  if(weapons.size > 4) {
    assertmsg("<dev string:x1c>");
  }

  self updateentitywithweapons(weapons[0], tags[0], weapons[1], tags[1], weapons[2], tags[2], weapons[3], tags[3]);
  self updatelaserstatus();
}

function gettagforpos(position) {
  switch (position) {
    case #"hash_fc2fdaa21f480e36":
      return "tag_stowed_chest";
    case #"hash_5163a22eb8c03302":
      return "tag_stowed_back";
    case #"hash_c9b3133a17a3b2d0":
      return "tag_weapon_left";
    case #"hash_96815ce4f2a3dbc5":
      return "tag_weapon_right";
    case #"hash_cc8437548a4a4480":
      return "tag_accessory_right";
    case #"hash_c274ab81bf2a0f8f":
      return "tag_stowed_thigh";
    case #"hash_40f6fb4e52241d83":
      return "tag_inhand";
    default:
      assertmsg("unknown weapon placement position: " + position);
      break;
  }
}

function dropaiweaponinternal(weapon) {
  if(function_335d7d001eb868f()) {
    if(weapon hasattachment(self.var_e0675e48962c6d55)) {
      scripts\anim\shared::detachweapon(weapon);
      weapon = weapon withoutattachment(self.var_e0675e48962c6d55);
      scripts\anim\shared::forceuseweapon(weapon, self.var_b5ce31099294cf74);
    }
  }

  weaponname = getcompleteweaponname(weapon);
  position = self.weaponinfo[weaponname].position;

  if(self.dropweapon && position != "none") {
    thread dropweaponwrapper(weapon, position);
  }

  detachweapon(weapon);

  if(weapon == self.weapon) {
    self.weapon = nullweapon();
  }

  if(weapon == self.primaryweapon) {
    self.primaryweapon = nullweapon();
  }

  if(weapon == self.secondaryweapon) {
    self.secondaryweapon = nullweapon();
  }

  if(weapon == self.sidearm) {
    if(!isnullweapon(self.primaryweapon)) {
      dropaiweaponinternal(self.primaryweapon);
    }

    self.sidearm = nullweapon();
  }
}

function dropaiweapon(weapon) {
  if(!isDefined(weapon)) {
    weapon = self.weapon;
  }

  assert(isweapon(weapon));

  if(isnullweapon(weapon)) {
    return;
  }

  if(isDefined(self.nodrop)) {
    return;
  }

  detachallweaponmodels();
  dropaiweaponinternal(weapon);

  if(isnullweapon(self.primaryweapon)) {
    if(!isnullweapon(self.weapon)) {
      self.primaryweapon = self.weapon;
    } else if(!isnullweapon(self.secondaryweapon)) {
      self.primaryweapon = self.secondaryweapon;
    } else if(!isnullweapon(self.sidearm)) {
      self.primaryweapon = self.sidearm;
    }

    if(self.primaryweapon == self.secondaryweapon) {
      self.secondaryweapon = nullweapon();
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

  positions = [];
  positions[positions.size] = "left";
  positions[positions.size] = "right";
  positions[positions.size] = "chest";
  positions[positions.size] = "back";
  positions[positions.size] = "thigh";
  positions[positions.size] = "inhand";
  detachallweaponmodels();

  foreach(position in positions) {
    weapon = self.a.weaponpos[position];

    if(isundefinedweapon(weapon)) {
      continue;
    }

    weaponname = getcompleteweaponname(weapon);
    self.weaponinfo[weaponname].position = "none";
    self.a.weaponpos[position] = undefined;

    if(function_335d7d001eb868f()) {
      if(weapon hasattachment(self.var_e0675e48962c6d55)) {
        weapon = weapon withoutattachment(self.var_e0675e48962c6d55);
      }
    }

    if(self.dropweapon) {
      thread dropweaponwrapper(weapon, position);
    }
  }

  self.weapon = nullweapon();
  updateattachedweaponmodels();
}

function dropweaponwrapper(weapon, position) {
  if(self isragdoll()) {
    return "none";
  }

  assert(isundefinedweapon(self.a.weaponposdropping[position]));
  self.a.weaponposdropping[position] = weapon;
  actualdroppedweapon = weapon;
  baseweaponname = weapon.basename;

  if(issubstr(tolower(baseweaponname), "_ai")) {
    baseweaponname = getsubstr(baseweaponname, 0, baseweaponname.size - 3);
    actualdroppedweapon = makeweapon(baseweaponname, weapon.attachments);
    assertex(actualdroppedweapon.basename != "none", "Dropped weapon is null. Is " + weapon.basename + " an _AI weapon and the non _AI version isn't loaded?");
  }

  thread setdroppedweaponammo(actualdroppedweapon);

  if(isagent(self)) {
    if(isDefined(level.dropped_weapon_func)) {
      self thread[[level.dropped_weapon_func]](actualdroppedweapon, position);
    } else {
      self dropweaponnovelocity(actualdroppedweapon, position);
    }

    if(isalive(self)) {
      waitframe();
    }
  } else if(canaiflingweapon(self)) {
    if(position == "back" || position == "thigh") {
      tagname = "tag_stowed_" + position;
    } else {
      tagname = "tag_weapon_" + position;
    }

    if(!hastag(self.model, tagname)) {
      self dropweapon(actualdroppedweapon, position, 0);
      self endon("end_weapon_drop_" + position);
      waitframe();
      return;
    }

    previoustagorigin = self gettagorigin(tagname);
    self endon("end_weapon_drop_" + position);
    waitframe();

    if(!isDefined(self)) {
      return;
    }

    tagorigin = self gettagorigin(tagname);
    tagangles = self gettagangles(tagname);
    var_93cd9b84a4e18201 = getcompleteweaponname(actualdroppedweapon);
    droppedweaponentity = spawn("weapon_" + var_93cd9b84a4e18201, tagorigin);
    droppedweaponentity.angles = tagangles;
    tagdelta = tagorigin - previoustagorigin;
    var_f437bc51b4d819fa = vectorNormalize(tagdelta);
    var_c0f18187ba0798ec = 20;
    var_6a8655e4b569b964 = 50;
    var_737df2e9aaf94a3e = min(length(tagdelta) * var_c0f18187ba0798ec, var_6a8655e4b569b964);
    tagvelocity = var_f437bc51b4d819fa * var_737df2e9aaf94a3e;
    var_4e12423804db75ad = (0, 0, 950);
    launchvelocity = tagvelocity + var_4e12423804db75ad;
    droppedweaponentity physicslaunchserveritem(tagorigin, launchvelocity);

    if(weaponclass(actualdroppedweapon) == "pistol") {
      reductionamount = 0.2;
      bodyid = droppedweaponentity physics_getbodyid(0);
      bodyangvel = physics_getbodyangvel(bodyid) * reductionamount;
      physics_setbodyangvel(bodyid, bodyangvel[0], bodyangvel[1], bodyangvel[2]);
    }

    function_f3bb4f4911a1beb2("loot", "dropWeapon", droppedweaponentity);
    self notify("weapon_dropped", droppedweaponentity);
  } else {
    self dropweapon(actualdroppedweapon, position, 0);
    self endon("end_weapon_drop_" + position);
    waitframe();
  }

  if(!isDefined(self)) {
    return;
  }

  if(isagent(self) && !isalive(self)) {
    return;
  }

  detachallweaponmodels();
  self.a.weaponposdropping[position] = undefined;
  updateattachedweaponmodels();
}

function function_335d7d001eb868f() {
  if(isDefined(self.var_e0675e48962c6d55)) {
    return true;
  }

  return false;
}

function canaiflingweapon(ai) {
  if(!issp()) {
    return false;
  }

  if(!isDefined(ai.lastattacker)) {
    return false;
  }

  if(!isPlayer(ai.lastattacker)) {
    return false;
  }

  if(isexplosivedamagemod(ai.damagemod)) {
    return true;
  }

  return true;
}

function setdroppedweaponammo(actualdroppedweapon) {
  self waittill("weapon_dropped", droppedweapon);
  droppedweapon endon("death");

  if(isDefined(actualdroppedweapon) && isvaliddroppedweapon(actualdroppedweapon)) {
    if(isDefined(droppedweapon)) {
      droppedweapon physics_registerforcollisioncallback();
      droppedweapon thread weapondrop_physics_callback_monitor(actualdroppedweapon);
      weaponname = getsubstr(droppedweapon.classname, 7, droppedweapon.classname.size);
      droppedweapon setscriptammo(weaponname, self);
    }
  }
}

function isvaliddroppedweapon(weapon) {
  if(weapon.ismelee) {
    return false;
  }

  return true;
}

function weapondrop_physics_callback_monitor(droppedent) {
  self endon("death");
  self endon("timeout");
  thread weapondrop_physics_timeout(2);
  self waittill("collision", body0, body1, flag0, flag1, position, normal, impulse, ent);
  surface = physics_getsurfacetypefromflags(flag1);
  surfacetype = getsubstr(surface["name"], 9);

  if(surfacetype == "user_terrain1") {
    surfacetype = "user_terrain_1";
  }

  if(isDefined(droppedent.classname) && isDefined(self)) {
    self function_7d738013c1cfbc9d(surfacetype);
  }
}

function weapondrop_physics_timeout(time) {
  wait time;
  self notify("timeout");
}

function getaimyawtoshootentorpos() {
  if(!isDefined(self.shootent)) {
    if(!isDefined(self.shootpos)) {
      return 0;
    }

    return getaimyawtopoint(self.shootpos);
  }

  return getaimyawtopoint(self.shootent getshootatpos());
}

function getaimpitchtoshootentorpos() {
  pitch = getpitchtoshootentorpos();

  if(self.script == "cover_crouch" && isDefined(self.a.covermode) && self.a.covermode == "lean") {
    pitch -= anim.covercrouchleanpitch;
  }

  return pitch;
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

function ramboaim(baseyaw) {
  self endon("killanimscript");
  ramboaiminternal(baseyaw);
}

function ramboaiminternal(baseyaw) {}

function decidenumshotsforburst() {
  numshots = 0;
  var_8ba699667e1a6d48 = weaponburstcount(self.weapon);

  if(var_8ba699667e1a6d48) {
    numshots = var_8ba699667e1a6d48;
  } else if(scripts\anim\weaponlist::usingsemiautoweapon()) {
    numshots = anim.semifirenumshots[randomint(anim.semifirenumshots.size)];
  } else if(self.fastburst) {
    numshots = anim.fastburstfirenumshots[randomint(anim.fastburstfirenumshots.size)];
  } else {
    numshots = anim.burstfirenumshots[randomint(anim.burstfirenumshots.size)];
  }

  if(numshots <= self.bulletsinclip) {
    return numshots;
  }

  assertex(self.bulletsinclip >= 0, self.bulletsinclip);

  if(self.bulletsinclip <= 0) {
    return 1;
  }

  return self.bulletsinclip;
}

function decidenumshotsforfull() {
  numshots = self.bulletsinclip;

  if(weaponclass(self.weapon) == "mg") {
    choice = randomfloat(10);

    if(choice < 3) {
      numshots = randomintrange(2, 6);
    } else if(choice < 8) {
      numshots = randomintrange(6, 12);
    } else {
      numshots = randomintrange(12, 20);
    }
  }

  return numshots;
}

function hideweaponmagattachment(weaponname) {
  self.weaponinfo[weaponname].hasclip = 0;
  updateattachedweaponmodels();
}

function showweaponmagattachment(weaponname) {
  self.weaponinfo[weaponname].hasclip = 1;
  updateattachedweaponmodels();
}

function handledropclip(flagname) {
  self endon("abort_reload");
  self endon(flagname + "_finished");

  self.var_2615bb1fb16a4696 = gettime();

  clipweapon = self.weapon;
  clipweaponname = getcompleteweaponname(clipweapon);
  clipmodel = undefined;

  if(self.weaponinfo[clipweaponname].useclip) {
    clipmodel = getweaponclipmodel(self.weapon);
  }

  if(isDefined(clipmodel)) {
    thread function_f50e9da2dab043f5(4, flagname, clipmodel);
  }

  if(self.weaponinfo[clipweaponname].hasclip) {
    if(isusingsidearm()) {
      self playSound("weap_reload_pistol_clipout_npc");
    } else {
      self playSound("weap_reload_smg_clipout_npc");
    }

    if(isDefined(clipmodel)) {
      hideweaponmagattachment(clipweaponname);
      thread dropclipmodel(clipmodel, "tag_clip");
    }
  }

  bdone = 0;

  while(!bdone) {
    self waittill(flagname, notes);

    if(!isarray(notes)) {
      notes = [notes];
    }

    foreach(notetrack in notes) {
      switch (notetrack) {
        case #"hash_5b5aa4b849bd2c6b":
          if(isDefined(clipmodel)) {
            self attach(clipmodel, "tag_accessory_left");
          }

          break;
        case #"hash_ae1cecd9e4889cf4":
          if(isDefined(clipmodel)) {
            self attach(clipmodel, "tag_accessory_right");
          }

          break;
        case #"hash_cd781db409868556":
          if(isDefined(clipmodel)) {
            self detach(clipmodel, "tag_accessory_right");
          }

          break;
        case #"hash_d4a17c4550fa75c2":
          if(isDefined(clipmodel)) {
            self detach(clipmodel, "tag_accessory_right");

            if(clipweapon == self.weapon) {
              showweaponmagattachment(clipweaponname);
            } else {
              self.weaponinfo[getcompleteweaponname(self.weapon)].hasclip = 1;
              self.weaponinfo[clipweaponname].hasclip = 1;
            }

            self notify("clip_detached");
          }

          scripts\anim\weaponlist::refillclip();
          bdone = 1;
          break;
        case #"hash_5d086fcae9cf9da1":
          if(isDefined(clipmodel)) {
            self detach(clipmodel, "tag_accessory_left");

            if(clipweapon == self.weapon) {
              showweaponmagattachment(clipweaponname);
            } else {
              self.weaponinfo[getcompleteweaponname(self.weapon)].hasclip = 1;
              self.weaponinfo[clipweaponname].hasclip = 1;
            }

            self notify("clip_detached");
          }

          scripts\anim\weaponlist::refillclip();
          bdone = 1;
          break;
      }
    }
  }
}

function dropclipmodel(clipmodel, tagname) {}

function function_f50e9da2dab043f5(waittime, statename, clipmodel) {
  self endon("<dev string:x47>");
  self endon("<dev string:x4d>");
  self endon("<dev string:x5a>");
  wait waittime;
  msg1 = "<dev string:x68>" + self getentitynumber() + "<dev string:x6c>" + waittime + "<dev string:xa2>";
  msg2 = "<dev string:xac>" + statename + "<dev string:xb8>" + clipmodel + "<dev string:xc8>" + self.weapon.basename + "<dev string:xd9>";
  msg3 = "<dev string:xdb>";
  msg4 = "<dev string:x129>";
  assertmsg(msg1 + "<dev string:x17d>" + msg2 + "<dev string:x17d>" + msg3 + "<dev string:x17d>" + msg4);
}

function movetonodeovertime(node, time) {
  self endon("killanimscript");
  nodeorigin = node.origin;
  distsq = distancesquared(self.origin, nodeorigin);

  if(distsq < 1) {
    self safeteleport(nodeorigin);
    return;
  }

  if(distsq > 256 && !self maymovetopoint(nodeorigin, !actor_is3d())) {
    println("<dev string:x17f>" + nodeorigin + "<dev string:x1ac>");
    return;
  }

  self.keepclaimednodeifvalid = 1;
  startdist = distance(self.origin, nodeorigin);
  frames = int(time * 20);

  for(i = 0; i < frames; i++) {
    nodeorigin = node.origin;
    var_e907009ead5acaf2 = self.origin - nodeorigin;
    var_e907009ead5acaf2 = vectorNormalize(var_e907009ead5acaf2);
    adjustedstartpos = nodeorigin + var_e907009ead5acaf2 * startdist;
    lerppos = adjustedstartpos + (nodeorigin - adjustedstartpos) * (i + 1) / frames;
    self safeteleport(lerppos);
    wait 0.05;
  }

  self.keepclaimednodeifvalid = 0;
}

function returntrue() {
  return true;
}

#using_animtree("generic_human");

function playlookanimation(lookanim, looktime, var_3eda4dd47f961142) {
  if(!isDefined(var_3eda4dd47f961142)) {
    var_3eda4dd47f961142 = &returntrue;
  }

  for(i = 0; i < looktime * 10; i++) {
    if(isalive(self.enemy)) {
      if(canseeenemy() && [[var_3eda4dd47f961142]]()) {
        return;
      }
    }

    if(issuppressedwrapper() && [[var_3eda4dd47f961142]]()) {
      return;
    }

    self setanimknoball(lookanim, %body, 1, 0.1);
    wait 0.1;
  }
}

function throwdownweapon(swapanim) {
  self endon("killanimscript");
  scripts\anim\shared::placeweaponon(self.secondaryweapon, "right");
  scripts\common\gameskill::didsomethingotherthanshooting();
}

function rpgplayerrepulsor() {
  misses_remaining = rpgplayerrepulsor_getnummisses();

  if(misses_remaining == 0) {
    return;
  }

  self endon("death");

  for(;;) {
    self waittill("shooting");

    if(isDefined(level.var_28b2c05eb31d987)) {
      self[[level.var_28b2c05eb31d987]]();
      continue;
    }

    if(function_a560b5ed33bedc96()) {
      level thread rpgplayerrepulsor_create(self.enemy);
      misses_remaining--;

      if(misses_remaining <= 0) {
        return;
      }
    }
  }
}

function function_a560b5ed33bedc96() {
  if(isDefined(level.createrpgrepulsors) && !level.createrpgrepulsors) {
    return false;
  }

  if(isDefined(self.enemy) && isPlayer(self.enemy)) {
    return true;
  }

  return false;
}

function rpgplayerrepulsor_getnummisses() {
  skill = utility::getdifficulty();

  switch (skill) {
    case #"hash_22ce4003c1e5227b":
    case #"hash_ba826b0f31b00b60":
      return 2;
    case #"hash_420f6837f7efa409":
    case #"hash_c71b112fe04823d6":
    case #"hash_cc9157548a55043c":
      return 1;
    case #"hash_fa14cdf6bd53b8e4":
      return 0;
  }

  return 2;
}

function rpgplayerrepulsor_create(ent) {
  ent notify("stop_prev_repulsor");
  ent endon("stop_prev_repulsor");

  if(!isDefined(ent.var_f7cd0afed33249f)) {
    ent.var_f7cd0afed33249f = missile_createrepulsorent(ent, 5000, 800);
  }

  repulsor = ent.var_f7cd0afed33249f;
  ent waittill_notify_or_timeout("death", 4);
  missile_deleteattractor(repulsor);
  ent.var_f7cd0afed33249f = undefined;
}

function pickandsetforceweapon() {
  if(isDefined(self.weaponoverride) && self.weaponoverride) {
    return;
  }

  if(scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), self.origin, 0.173648)) {
    return;
  }

  objweapon = undefined;

  if(distancesquared(self.origin, self.enemy.origin) < self.closeweaponmaxdist * self.closeweaponmaxdist) {
    objweapon = self.forcedweaponclose;
  } else {
    objweapon = self.forcedweaponfar;
  }

  if(objweapon != self.weapon) {
    forceuseweapon(objweapon, "primary");
    self.weapon_stow setModel(getweaponmodel(self.forcedweapon));
    self.forcedweapon = objweapon;
  }
}

function forceuseweapon(newweapon, targetslot) {
  assert(isDefined(newweapon));
  assert(isDefined(targetslot));
  assertex(targetslot == "primary" || targetslot == "secondary" || targetslot == "sidearm", "Target slot is either primary, secondary or sidearm.");
  newweaponobj = undefined;

  if(isweapon(newweapon)) {
    assert(!isnullweapon(newweapon));
    newweaponobj = newweapon;
  } else {
    assert(newweapon != "none");
    newweaponobj = [[level.fnbuildweapon]](newweapon);
  }

  if(istrue(self.script_fakeactor) || istrue(self.script_drone)) {
    scripts\common\ai::gun_remove();
    scripts\common\ai::gun_create_fake(getweaponattachmentworldmodels(newweaponobj));
    return;
  }

  if(!utility::isweaponinitialized(newweaponobj)) {
    utility::initweapon(newweaponobj);
  }

  hasweapon = !isnullweapon(self.weapon);
  iscurrentsidearm = scripts\anim\utility_common::isusingsidearm();
  isnewsidearm = targetslot == "sidearm";
  isnewsecondary = targetslot == "secondary";

  if(hasweapon && iscurrentsidearm != isnewsidearm) {
    assert(self.weapon != newweaponobj);

    if(iscurrentsidearm) {
      var_86d39f2fc4d668d5 = "none";
    } else if(isnewsecondary) {
      var_86d39f2fc4d668d5 = "back";
    } else {
      var_86d39f2fc4d668d5 = "chest";
    }

    placeweaponon(self.weapon, var_86d39f2fc4d668d5);
    self.lastweapon = self.weapon;
  } else {
    self.lastweapon = newweaponobj;
  }

  scripts\anim\shared::placeweaponon(newweaponobj, "right");

  if(isnewsidearm) {
    self.sidearm = newweaponobj;
  } else if(isnewsecondary) {
    self.secondaryweapon = newweaponobj;
  } else {
    self.primaryweapon = newweaponobj;
  }

  self.weapon = newweaponobj;
  self.bulletsinclip = weaponclipsize(self.weapon);
  self notify("weapon_switch_done");
  updateweaponarchetype(weaponclass(self.weapon));
}

function updateweaponarchetype(weapclass) {
  if(!isDefined(self._blackboard) || scripts\asm\asm_bb::bb_isanimScripted() || !isDefined(self.asm) || !isDefined(self.animsetname)) {
    return;
  }

  if(self function_18cb2157393fbf5b()) {
    return;
  }

  var_b363904de331d30 = self getbasearchetype();

  if(weapclass == "pistol" && archetypeassetloaded(self.animsetname + "_pistol")) {
    self setoverridearchetype("weapon", self.animsetname + "_pistol");
    return;
  }

  if(weapclass == "pistol" && archetypeassetloaded(var_b363904de331d30 + "_pistol")) {
    self setoverridearchetype("weapon", var_b363904de331d30 + "_pistol");
    return;
  }

  if(weapclass == "mg" && archetypeassetloaded(self.animsetname + "_lmg")) {
    self setoverridearchetype("weapon", self.animsetname + "_lmg");
    return;
  }

  if(weapclass == "mg" && archetypeassetloaded(var_b363904de331d30 + "_lmg")) {
    self setoverridearchetype("weapon", var_b363904de331d30 + "_lmg");
    return;
  }

  self clearoverridearchetype("weapon");
}

function everusessecondaryweapon() {
  if(isshotgun(self.secondaryweapon)) {
    return true;
  }

  if(weaponclass(self.primaryweapon) == "rocketlauncher") {
    return true;
  }

  return false;
}

function default_weaponsetup(scriptedweaponassignment) {
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
  } else if(!istrue(self.usescriptedweapon) && !isDefined(self.agent_type)) {
    if(!issp()) {
      if(!isweapon(self.primaryweapon)) {
        self.primaryweapon = [[level.fnbuildweapon]](self.primaryweapon, [], "none", "none");
      }

      if(!isweapon(self.secondaryweapon)) {
        self.secondaryweapon = [[level.fnbuildweapon]](self.secondaryweapon, [], "none", "none");
      }

      if(!isweapon(self.sidearm)) {
        self.sidearm = [[level.fnbuildweapon]](self.sidearm, [], "none", "none");
      }
    } else {
      self.primaryweapon = [[level.fnbuildweapon]](self.primaryweapon, []);
      self.secondaryweapon = [[level.fnbuildweapon]](self.secondaryweapon, []);
      self.sidearm = [[level.fnbuildweapon]](self.sidearm, []);
    }
  }

  utility::initweapon(nullweapon());

  if(!isnullweapon(self.primaryweapon)) {
    utility::initweapon(self.primaryweapon);
  }

  if(!isnullweapon(self.secondaryweapon)) {
    utility::initweapon(self.secondaryweapon);
  }

  if(!isnullweapon(self.sidearm)) {
    utility::initweapon(self.sidearm);
  }

  validatesidearm();
  self setdefaultaimlimits();
  self.a.weaponpos = [];
  self.a.weaponposdropping = [];
  self.lastweapon = self.weapon;

  if(usingrocketlauncher()) {
    thread scripts\anim\shared::rpgplayerrepulsor();
  }

  self.rocketammo = 100;

  if(!isnullweapon(self.primaryweapon)) {
    scripts\anim\shared::placeweaponon(self.primaryweapon, "right");
  }

  if(isshotgun(self.secondaryweapon)) {
    scripts\anim\shared::placeweaponon(self.secondaryweapon, "back");
  }

  if(!isnullweapon(self.sidearm) && isDefined(self.stowsidearmposition)) {
    scripts\anim\shared::placeweaponon(self.sidearm, self.stowsidearmposition);
  }

  if(self isbadguy()) {
    self.has_no_ir = 1;
  }

  scripts\anim\weaponlist::refillclip();
}

function validatesidearm() {
  if(self.primaryweapon == self.sidearm && !isnullweapon(self.primaryweapon)) {
    exportstring = ter_op(isDefined(self.export), self.export, "<dev string:x1cf>");
    classnamestring = ter_op(isagent(self), self.agent_type, self.classname);
    assertmsg("<dev string:x1d0>" + classnamestring + "<dev string:x1d5>" + exportstring + "<dev string:x1e5>" + getcompleteweaponname(self.primaryweapon) + "<dev string:x211>");
  }

  if(self.secondaryweapon == self.sidearm && !isnullweapon(self.secondaryweapon) && everusessecondaryweapon()) {
    exportstring = ter_op(isDefined(self.export), self.export, "<dev string:x1cf>");
    classnamestring = ter_op(isagent(self), self.agent_type, self.classname);
    assertmsg("<dev string:x1d0>" + classnamestring + "<dev string:x1d5>" + exportstring + "<dev string:x214>" + getcompleteweaponname(self.primaryweapon) + "<dev string:x211>");
  }
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

  thread scripts\anim\combat_utility::showgrenadetimers();
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
  anim.weaponstowfunction = &scripts\anim\shared::pickandsetforceweapon;

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
    anim.shootenemywrapper_func = &shootenemywrapper_shootnotify;
  }

  if(!isDefined(anim.shootposwrapper_func)) {
    anim.shootposwrapper_func = &shootposwrapper;
  }

  setglobalaimsettings();
  anim.fire_notetrack_functions = [];
  anim.lastcarexplosiontime = -100000;
  anim.burstfirenumshots = [1, 2, 2, 2, 3, 3, 3, 3, 4, 4, 5];
  anim.fastburstfirenumshots = [2, 3, 3, 3, 4, 4, 4, 5, 5];
  anim.semifirenumshots = [1, 2, 2, 3, 3, 4, 4, 4, 4, 5, 5, 5];
  anim.badplaces = [];
  anim.badplaceint = 0;
  anim.nodeyaws = [];
  anim.grenadethrowanims = [];
  anim.grenadethrowoffsets = [];
  anim.var_432836e99816347c = [];

  if(!isDefined(anim.var_91bc951178da9f3b)) {
    anim.var_91bc951178da9f3b = &scripts\common\ai_lookat::enablelookatentity;
    anim.var_8122f7efa052c448 = &scripts\common\ai_lookat::disablelookatentity;
  }

  if(!isDefined(anim.var_c65f21298ce83c9c)) {
    anim.var_c65f21298ce83c9c = &detachallweaponmodels;
    anim.var_f240ef0c84eac2b2 = &updateattachedweaponmodels;
  }

  initgestures();
  initmaxspeedforpathlengthtable();
  scripts\anim\animselector::init();
}

function initgestures() {
  gestures = [];
  gestures[gestures.size] = "point_casual";
  gestures[gestures.size] = "point_military";
  gestures[gestures.size] = "yes";
  gestures[gestures.size] = "no";
  gestures[gestures.size] = "hold";
  gestures[gestures.size] = "talk";
  gestures[gestures.size] = "shrug";
  gestures[gestures.size] = "getdown";
  gestures[gestures.size] = "nvg_on";
  gestures[gestures.size] = "nvg_off";
  gestures[gestures.size] = "beckon";
  gestures[gestures.size] = "lookback_right";
  gestures[gestures.size] = "wrist_com_lower";
  gestures[gestures.size] = "wrist_com_raise";
  anim.gestures = gestures;
}

function setglobalaimsettings() {
  anim.covercrouchleanpitch = 55;
  anim.aimyawdifffartolerance = 10;
  anim.aimyawdiffclosedistsq = 4096;
  anim.aimyawdiffclosetolerance = 45;
  anim.aimpitchdifftolerance = 20;
  anim.painyawdifffartolerance = 25;
  anim.painyawdiffclosedistsq = anim.aimyawdiffclosedistsq;
  anim.painyawdiffclosetolerance = anim.aimyawdiffclosetolerance;
  anim.painpitchdifftolerance = 30;
  anim.maxanglecheckyawdelta = 65;
  anim.maxanglecheckpitchdelta = 65;
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

  if(!isnullweapon(self.primaryweapon)) {
    self.weapon = self.primaryweapon;
    self.weapons["right"] = c12_getweapontypeforweapon();
  }

  if(!isnullweapon(self.secondaryweapon)) {
    self.weapon = self.secondaryweapon;
    self.weapons["left"] = c12_getweapontypeforweapon();
  }

  self.weapon = nullweapon();
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

  for(i = 0; i < anim.randominttablesize; i++) {
    anim.randominttable[i] = i;
  }

  for(i = 0; i < anim.randominttablesize; i++) {
    switchwith = randomint(anim.randominttablesize);
    temp = anim.randominttable[i];
    anim.randominttable[i] = anim.randominttable[switchwith];
    anim.randominttable[switchwith] = temp;
  }
}

function setupweapons() {
  self endon("death");
  flag_wait("load_finished");

  if(isDefined(anim.weaponsetupfuncs) && isDefined(anim.weaponsetupfuncs[self.unittype])) {
    self[[anim.weaponsetupfuncs[self.unittype]]]();
    return;
  }

  default_weaponsetup();
}

function setscriptammo(weaponname, inherit_from, placedub) {
  if(isDefined(inherit_from.script_ammo_clip)) {
    assertex(isDefined(inherit_from.script_ammo_clip), "Need to set a value for script_ammo_clip");
    assertex(isDefined(inherit_from.script_ammo_extra), "Must also set, 'script_ammo_extra' when setting script_ammo_clip.");
    self itemweaponsetammo(inherit_from.script_ammo_clip, inherit_from.script_ammo_extra);
  } else if(isDefined(inherit_from.script_ammo_extra)) {
    assertex(isDefined(inherit_from.script_ammo_extra), "Need to set a value for script_ammo_extra");
    assertex(isDefined(inherit_from.script_ammo_clip), "Must also set, 'script_ammo_clip' when setting script_ammo_extra.");
    self itemweaponsetammo(inherit_from.script_ammo_clip, inherit_from.script_ammo_extra);
  }

  if(isDefined(inherit_from.script_ammo_alt_clip)) {
    assertex(isDefined(inherit_from.script_ammo_alt_clip), "Need to set a value for script_ammo_alt_clip");
    assertex(isDefined(inherit_from.script_ammo_extra), "Must also set, 'script_ammo_extra' when setting script_ammo_alt_clip.");
    self itemweaponsetammo(inherit_from.script_ammo_alt_clip, inherit_from.script_ammo_alt_extra, undefined, 1);
  } else if(isDefined(inherit_from.script_ammo_alt_extra)) {
    assertex(isDefined(inherit_from.script_ammo_alt_extra), "Need to set a value for script_ammo_alt_extra");
    assertex(isDefined(inherit_from.script_ammo_clip), "Must also set, 'script_ammo_clip' when setting script_ammo_alt_extra.");
    self itemweaponsetammo(inherit_from.script_ammo_alt_clip, inherit_from.script_ammo_alt_extra, undefined, 1);
  }

  if(isDefined(inherit_from.script_ammo_max)) {
    self itemweaponsetammo(weaponclipsize(self), weaponmaxammo(self));
  }

  if(istrue(placedub)) {
    self itemweaponsetammo(1, 6, 0, 1);
    return;
  }

  if(issubstr(weaponname, "ub_golf25_sp") || issubstr(weaponname, "ub_mike203_sp")) {
    self itemweaponsetammo(1, 1, 0, 1);
  }
}
/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\shared.gsc
**************************************/

#using scripts\anim\animselector;
#using scripts\anim\combat_utility;
#using scripts\anim\utility;
#using scripts\anim\utility_common;
#using scripts\anim\weaponlist;
#using scripts\asm\asm_bb;
#using scripts\common\ai;
#using scripts\common\ai_lookat;
#using scripts\common\gameskill;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace shared;

function placeweaponon(weapon, position, activeweapon) {
  assert(isDefined(weapon));
  placeweaponobj = undefined;
  placeweaponname = undefined;

  if(isweapon(weapon)) {
    placeweaponobj = weapon;
    placeweaponname = getcompleteweaponname(weapon);
  } else {
    placeweaponobj = makeweaponfromstring(weapon);
    placeweaponname = weapon;
  }

  assert(utility::aihasweapon(placeweaponobj));
  self notify("weapon_position_change");
  curposition = self.weaponinfo[placeweaponname].position;
  assert(curposition == "<dev string:x24>" || self.a.weaponpos[curposition] == placeweaponobj);

  if(position != "none" && isDefined(self.a.weaponpos[position]) && self.a.weaponpos[position] == placeweaponobj) {
    return;
  }

  detachallweaponmodels();

  if(curposition != "none") {
    detachweapon(placeweaponobj);
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
    attachweapon(placeweaponobj, position);
    self.weapon = placeweaponobj;
  } else {
    attachweapon(placeweaponobj, position);
  }

  updateattachedweaponmodels();
}

function detachweapon(objweapon) {
  assert(isweapon(objweapon));
  weaponname = getcompleteweaponname(objweapon);

  if(isDefined(self.weaponinfo[weaponname].position)) {
    self.a.weaponpos[self.weaponinfo[weaponname].position] = undefined;
    self.weaponinfo[weaponname].position = "none";
  }
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
  positions = ["right", "left", "chest", "back", "thigh", "inhand"];
  self laseroff();

  foreach(position in positions) {
    weapon = getweaponforpos(position);

    if(isundefinedweapon(weapon)) {
      continue;
    }

    if(weapontype(weapon) == "riotshield" && isDefined(self.shieldmodelvariant)) {
      if(isDefined(self.shieldbroken) && self.shieldbroken) {
        playFXOnTag(utility::getfx("riot_shield_dmg"), self, "TAG_BRASS");
        self.shieldbroken = undefined;
      }
    }
  }

  self updateentitywithweapons();
}

function updateattachedweaponmodels() {
  weapons = [];
  tags = [];
  positions = ["right", "left", "chest", "back", "thigh", "inhand"];

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
    assertmsg("<dev string:x2c>");
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
      assertmsg("<dev string:x5a>" + position);
      break;
  }
}

function dropaiweaponinternal(weapon) {
  if(function_9b735f27e5cc1ed8()) {
    if(weapon hasattachment(self.flashlight_attachment)) {
      detachweapon(weapon);
      weapon = weapon withoutattachment(self.flashlight_attachment);
      forceuseweapon(weapon, self.flashlight_slot);
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

  if(!(isDefined(self.a) && isDefined(self.a.weaponpos))) {
    return;
  }

  positions = ["left", "right", "chest", "back", "thigh", "inhand"];
  detachallweaponmodels();

  foreach(position in positions) {
    weapon = self.a.weaponpos[position];

    if(isundefinedweapon(weapon)) {
      continue;
    }

    weaponname = getcompleteweaponname(weapon);
    self.weaponinfo[weaponname].position = "none";
    self.a.weaponpos[position] = undefined;

    if(function_9b735f27e5cc1ed8()) {
      if(weapon hasattachment(self.flashlight_attachment)) {
        weapon = weapon withoutattachment(self.flashlight_attachment);
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
  if(self isragdoll() && !self.forceweapondrop) {
    return "none";
  }

  assert(isundefinedweapon(self.a.weaponposdropping[position]));
  self.a.weaponposdropping[position] = weapon;
  actualdroppedweapon = weapon;
  baseweaponname = weapon.basename;

  if(issubstr(tolower(baseweaponname), "_ai")) {
    baseweaponname = getsubstr(baseweaponname, 0, baseweaponname.size - 3);
    attachments = weapon.attachments;

    if(self.var_c4f0a8627b548c6d) {
      attachments = getweapondefaultattachments(baseweaponname);
    }

    actualdroppedweapon = makeweapon(baseweaponname, attachments);
    assert(actualdroppedweapon.basename != "<dev string:x24>", "<dev string:x81>" + weapon.basename + "<dev string:xa0>");
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

    if(!utility::hastag(self.model, tagname)) {
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
    weaponcompletename = getcompleteweaponname(actualdroppedweapon);
    droppedweaponentity = spawn("weapon_" + weaponcompletename, tagorigin);
    droppedweaponentity.angles = tagangles;
    tagdelta = tagorigin - previoustagorigin;
    normalizedtagdelta = vectorNormalize(tagdelta);
    tagvelocityscalar = 20;
    maximumtagvelocity = 50;
    tagvelocitymagnitude = min(length(tagdelta) * tagvelocityscalar, maximumtagvelocity);
    tagvelocity = normalizedtagdelta * tagvelocitymagnitude;
    var_70527808f50923fa = (0, 0, 950);
    launchvelocity = tagvelocity + var_70527808f50923fa;

    if(isDefined(self.weapondroppos.origin)) {
      tagorigin = self.weapondroppos.origin;
      tagangles = self.weapondroppos.angles ?? (0, 0, 0);
      launchvelocity = self.weapondroppos.velocity ?? launchvelocity;

      if(self.weapondroppos.local) {
        tagorigin = coordtransform(tagorigin, self.origin, self.angles);
        tagangles = combineangles(self.angles, tagangles);

        if(isDefined(self.weapondroppos.velocity)) {
          launchvelocity = rotatevector(launchvelocity, self.angles);
        }
      }
    }

    droppedweaponentity physicslaunchserveritem(tagorigin, launchvelocity);

    if(weaponclass(actualdroppedweapon) == "pistol") {
      reductionamount = 0.2;
      bodyid = droppedweaponentity physics_getbodyid(0);
      bodyangvel = physics_getbodyangvel(bodyid) * reductionamount;
      physics_setbodyangvel(bodyid, bodyangvel[0], bodyangvel[1], bodyangvel[2]);
    }

    level notify("weapon_dropped_ai", droppedweaponentity);
    self notify("weapon_dropped", droppedweaponentity);
  } else {
    weaponent = self dropweapon(actualdroppedweapon, position, 0);
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

function function_9b735f27e5cc1ed8() {
  if(isDefined(self.flashlight_attachment)) {
    return true;
  }

  return false;
}

function canaiflingweapon(ai) {
  if(!utility::issp()) {
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

  if(isvaliddroppedweapon(actualdroppedweapon)) {
    if(isDefined(droppedweapon)) {
      droppedweapon physics_registerforcollisioncallback();
      droppedweapon thread weapondrop_physics_callback_monitor(actualdroppedweapon);
      weaponname = getsubstr(droppedweapon.classname, 7, droppedweapon.classname.size);
      droppedweapon setscriptammo(weaponname, self);
    }
  }

  utility::callsharedfunc(#"loot", #"dropweapon", droppedweapon);
  thread utility::callsharedfunc(#"loot", #"dropWeaponPost", droppedweapon);
  basename = "";

  if(isweapon(droppedweapon)) {
    basename = getweaponbasename(droppedweapon);
  } else if(isweapon(actualdroppedweapon)) {
    basename = getweaponbasename(actualdroppedweapon);
  }

  if(isDefined(self.weaponlootitem[basename]) && isent(droppedweapon)) {
    droppedweapon function_e44c4b30d4be97f6(self.weaponlootitem[basename]);
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
    self playweapondropsound(surfacetype);
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

    return utility::getaimyawtopoint(self.shootpos);
  }

  return utility::getaimyawtopoint(self.shootent getshootatpos());
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

    return combat_utility::getpitchtoshootspot(self.shootpos);
  }

  return combat_utility::getpitchtoshootspot(self.shootent getshootatpos());
}

function ramboaim(baseyaw) {
  self endon("killanimscript");
  ramboaiminternal(baseyaw);
}

function ramboaiminternal(baseyaw) {}

function decidenumshotsforburst() {
  numshots = 0;
  fixedburstcount = weaponburstcount(self.weapon);

  if(fixedburstcount) {
    numshots = fixedburstcount;
  } else if(weaponlist::usingsemiautoweapon()) {
    numshots = anim.semifirenumshots[randomint(anim.semifirenumshots.size)];
  } else if(self.fastburst) {
    numshots = anim.fastburstfirenumshots[randomint(anim.fastburstfirenumshots.size)];
  } else {
    numshots = anim.burstfirenumshots[randomint(anim.burstfirenumshots.size)];
  }

  if(numshots <= self.bulletsinclip) {
    return numshots;
  }

  assert(self.bulletsinclip >= 0, self.bulletsinclip);

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

  self.var_ff4c8b05d3ce4627 = gettime();

  clipweapon = self.weapon;
  clipweaponname = getcompleteweaponname(clipweapon);
  clipmodel = undefined;

  if(self.weaponinfo[clipweaponname].useclip) {
    clipmodel = getweaponclipmodel(self.weapon);
  }

  if(isDefined(clipmodel)) {
    thread function_4c55a5c08debdb0c(4, flagname, clipmodel);
  }

  if(self.weaponinfo[clipweaponname].hasclip) {
    if(utility_common::isusingsidearm()) {
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

          weaponlist::refillclip();
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

          weaponlist::refillclip();
          bdone = 1;
          break;
      }
    }
  }
}

function dropclipmodel(clipmodel, tagname) {}

function function_4c55a5c08debdb0c(waittime, statename, clipmodel) {
  self endon("<dev string:xd8>");
  self endon("<dev string:xe1>");
  self endon("<dev string:xf1>");
  wait waittime;
  msg1 = "<dev string:x102>" + self getentitynumber() + "<dev string:x109>" + waittime + "<dev string:x142>";
  msg2 = "<dev string:x14f>" + statename + "<dev string:x15e>" + clipmodel + "<dev string:x171>" + self.weapon.basename + "<dev string:x185>";
  msg3 = "<dev string:x18a>";
  msg4 = "<dev string:x1db>";
  assertmsg(msg1 + "<dev string:x232>" + msg2 + "<dev string:x232>" + msg3 + "<dev string:x232>" + msg4);
}

function movetonodeovertime(node, time) {
  self endon("killanimscript");
  nodeorigin = node.origin;
  distsq = distancesquared(self.origin, nodeorigin);

  if(distsq < 1) {
    self safeteleport(nodeorigin);
    return;
  }

  if(distsq > 256 && !self maymovetopoint(nodeorigin, !utility::actor_is3d())) {
    println("<dev string:x237>" + nodeorigin + "<dev string:x267>");
    return;
  }

  self.keepclaimednodeifvalid = 1;
  startdist = distance(self.origin, nodeorigin);
  frames = int(time * 20);

  for(i = 0; i < frames; i++) {
    nodeorigin = node.origin;
    nodetoself = self.origin - nodeorigin;
    nodetoself = vectorNormalize(nodetoself);
    adjustedstartpos = nodeorigin + nodetoself * startdist;
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

function playlookanimation(lookanim, looktime, canstopcallback) {
  if(!isDefined(canstopcallback)) {
    canstopcallback = &returntrue;
  }

  for(i = 0; i < looktime * 10; i++) {
    if(isalive(self.enemy)) {
      if(utility_common::canseeenemy() && [[canstopcallback]]()) {
        return;
      }
    }

    if(utility_common::issuppressedwrapper() && [[canstopcallback]]()) {
      return;
    }

    self setanimknoball(lookanim, %body, 1, 0.1);
    wait 0.1;
  }
}

function throwdownweapon(swapanim) {
  self endon("killanimscript");
  placeweaponon(self.secondaryweapon, "right");
  gameskill::didsomethingotherthanshooting();
}

function rpgplayerrepulsor() {
  misses_remaining = rpgplayerrepulsor_getnummisses();

  if(misses_remaining == 0) {
    return;
  }

  self endon("death");

  for(;;) {
    self waittill("shooting");

    if(isDefined(level.var_4dce2a16c34c05b8)) {
      self[[level.var_4dce2a16c34c05b8]]();
      continue;
    }

    if(function_74931e0d742238ab()) {
      level thread rpgplayerrepulsor_create(self.enemy);
      misses_remaining--;

      if(misses_remaining <= 0) {
        return;
      }
    }
  }
}

function function_74931e0d742238ab() {
  if(isDefined(level.createrpgrepulsors) && !level.createrpgrepulsors) {
    return false;
  }

  if(isPlayer(self.enemy)) {
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

  if(!isDefined(ent.var_47894f862f7e492a)) {
    ent.var_47894f862f7e492a = missile_createrepulsorent(ent, 5000, 800);
  }

  repulsor = ent.var_47894f862f7e492a;
  ent utility::waittill_notify_or_timeout("death", 4);
  missile_deleteattractor(repulsor);
  ent.var_47894f862f7e492a = undefined;
}

function pickandsetforceweapon() {
  if(isDefined(self.weaponoverride) && self.weaponoverride) {
    return;
  }

  if(utility::within_fov(level.player.origin, level.player getplayerangles(), self.origin, 0.173648)) {
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
  assert(targetslot == "<dev string:x28d>" || targetslot == "<dev string:x298>" || targetslot == "<dev string:x2a5>", "<dev string:x2b0>");
  newweaponobj = undefined;

  if(isweapon(newweapon)) {
    assert(!isnullweapon(newweapon));
    newweaponobj = newweapon;
  } else {
    assert(newweapon != "<dev string:x24>");
    newweaponobj = [[level.fnbuildweapon]](newweapon);
  }

  if(self.script_fakeactor || self.script_drone) {
    ai::gun_remove();
    ai::gun_create_fake(getweaponattachmentworldmodels(newweaponobj));
    return;
  }

  if(!utility::isweaponinitialized(newweaponobj)) {
    utility::initweapon(newweaponobj);
  }

  hasweapon = !isnullweapon(self.weapon);
  iscurrentsidearm = utility_common::isusingsidearm();
  isnewsidearm = targetslot == "sidearm";
  isnewsecondary = targetslot == "secondary";

  if(hasweapon && iscurrentsidearm != isnewsidearm) {
    assert(self.weapon != newweaponobj);

    if(iscurrentsidearm) {
      holstertarget = "none";
    } else if(isnewsecondary) {
      holstertarget = "back";
    } else {
      holstertarget = "chest";
    }

    placeweaponon(self.weapon, holstertarget);
    self.lastweapon = self.weapon;
  } else {
    self.lastweapon = newweaponobj;
  }

  placeweaponon(newweaponobj, "right");

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
  if(!isDefined(self._blackboard) || asm_bb::bb_isanimScripted() || !(isDefined(self.asm) && isDefined(self.animsetname))) {
    return;
  }

  if(self ignoreweaponarchetypes()) {
    return;
  }

  basearchetypename = self getbasearchetype();

  if(weapclass == "pistol" && archetypeassetloaded(self.animsetname + "_pistol")) {
    self setoverridearchetype("weapon", self.animsetname + "_pistol", 1);
    return;
  }

  if(weapclass == "pistol" && archetypeassetloaded(basearchetypename + "_pistol")) {
    self setoverridearchetype("weapon", basearchetypename + "_pistol", 1);
    return;
  }

  if(weapclass == "mg" && archetypeassetloaded(self.animsetname + "_lmg")) {
    self setoverridearchetype("weapon", self.animsetname + "_lmg", 1);
    return;
  }

  if(weapclass == "mg" && archetypeassetloaded(basearchetypename + "_lmg")) {
    self setoverridearchetype("weapon", basearchetypename + "_lmg", 1);
    return;
  }

  if(weapclass == "rocketlauncher" && archetypeassetloaded(self.animsetname + "_rpg")) {
    self setoverridearchetype("weapon", self.animsetname + "_rpg", 1);
    return;
  }

  if(weapclass == "rocketlauncher" && archetypeassetloaded(basearchetypename + "_rpg")) {
    self setoverridearchetype("weapon", basearchetypename + "_rpg", 1);
    return;
  }

  self clearoverridearchetype("weapon");
}

function everusessecondaryweapon() {
  if(utility_common::isshotgun(self.secondaryweapon)) {
    return true;
  }

  if(weaponclass(self.primaryweapon) == "rocketlauncher") {
    return true;
  }

  return false;
}

function default_weaponsetup(scriptedweaponassignment) {
  if(!isDefined(self.stowsidearmposition)) {
    if(self.bhasthighholster) {
      self.stowsidearmposition = "thigh";
    } else {
      self.stowsidearmposition = anim.stowsidearmpositiondefault;
    }
  }

  if(self.scriptedweaponfailed) {
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
  } else if(self.usescriptedweapon && isDefined(level.fnscriptedweaponassignment)) {
    self.primaryweapon = [[level.fnscriptedweaponassignment]](self.primaryweapon);
    self.secondaryweapon = [[level.fnscriptedweaponassignment]](self.secondaryweapon);
    self.sidearm = [[level.fnscriptedweaponassignment]](self.sidearm, "sidearm");
  } else if(!self.usescriptedweapon && !isDefined(self.agent_type)) {
    if(!utility::issp()) {
      if(!isweapon(self.primaryweapon)) {
        self.primaryweapon = [[level.fnbuildweapon]](self.primaryweapon, [], "camo_none", "none");
      }

      if(!isweapon(self.secondaryweapon)) {
        self.secondaryweapon = [[level.fnbuildweapon]](self.secondaryweapon, [], "camo_none", "none");
      }

      if(!isweapon(self.sidearm)) {
        self.sidearm = [[level.fnbuildweapon]](self.sidearm, [], "camo_none", "none");
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

  if(utility_common::usingrocketlauncher()) {
    thread rpgplayerrepulsor();
  }

  self.rocketammo = 100;

  if(!isnullweapon(self.primaryweapon)) {
    placeweaponon(self.primaryweapon, "right");
  }

  if(utility_common::isshotgun(self.secondaryweapon)) {
    placeweaponon(self.secondaryweapon, "back");
  }

  if(!isnullweapon(self.sidearm) && isDefined(self.stowsidearmposition)) {
    placeweaponon(self.sidearm, self.stowsidearmposition);
  }

  if(utility::issp() && self isbadguy()) {
    self.has_no_ir = 1;
  }

  weaponlist::refillclip();
}

function validatesidearm() {
  if(self.primaryweapon == self.sidearm && !isnullweapon(self.primaryweapon)) {
    exportstring = self.export ?? "<dev string:x2e8>";
    classnamestring = isagent(self) ? self.agent_type : self.classname;
    assertmsg("<dev string:x2ec>" + classnamestring + "<dev string:x2f4>" + exportstring + "<dev string:x307>" + getcompleteweaponname(self.primaryweapon) + "<dev string:x336>");
  }

  if(self.secondaryweapon == self.sidearm && !isnullweapon(self.secondaryweapon) && everusessecondaryweapon()) {
    exportstring = self.export ?? "<dev string:x2e8>";
    classnamestring = isagent(self) ? self.agent_type : self.classname;
    assertmsg("<dev string:x2ec>" + classnamestring + "<dev string:x2f4>" + exportstring + "<dev string:x33c>" + getcompleteweaponname(self.primaryweapon) + "<dev string:x336>");
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

  thread combat_utility::showgrenadetimers();
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
    anim.shootenemywrapper_func = &utility::shootenemywrapper_shootnotify;
  }

  if(!isDefined(anim.shootposwrapper_func)) {
    anim.shootposwrapper_func = &utility::shootposwrapper;
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
  anim.var_50d4237318a10673 = [];

  if(!isDefined(anim.var_7a467f51952fc7be)) {
    anim.var_7a467f51952fc7be = &ai_lookat::enablelookatentity;
    anim.var_89690e2f5b3c4893 = &ai_lookat::disablelookatentity;
  }

  if(!isDefined(anim.var_5458eb88a5c60307)) {
    anim.var_5458eb88a5c60307 = &detachallweaponmodels;
    anim.var_a539877b0796cf31 = &updateattachedweaponmodels;
  }

  initgestures();
  initmaxspeedforpathlengthtable();
  animselector::init();
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
  if(utility_common::usingrocketlauncher()) {
    return "rocket";
  } else if(utility_common::function_2fff89909fdbfbab(self.weapon)) {
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
  utility::flag_wait("load_finished");

  if(isDefined(anim.weaponsetupfuncs) && isDefined(anim.weaponsetupfuncs[self.unittype])) {
    self[[anim.weaponsetupfuncs[self.unittype]]]();
    return;
  }

  default_weaponsetup();
}

function setscriptammo(weaponname, inherit_from, placedub) {
  if(isDefined(inherit_from.script_ammo_clip)) {
    assert(isDefined(inherit_from.script_ammo_clip), "<dev string:x36d>");
    assert(isDefined(inherit_from.script_ammo_extra), "<dev string:x399>");
    self itemweaponsetammo(inherit_from.script_ammo_clip, inherit_from.script_ammo_extra);
  } else if(isDefined(inherit_from.script_ammo_extra)) {
    assert(isDefined(inherit_from.script_ammo_extra), "<dev string:x3de>");
    assert(isDefined(inherit_from.script_ammo_clip), "<dev string:x40b>");
    self itemweaponsetammo(inherit_from.script_ammo_clip, inherit_from.script_ammo_extra);
  }

  if(isDefined(inherit_from.script_ammo_alt_clip)) {
    assert(isDefined(inherit_from.script_ammo_alt_clip), "<dev string:x450>");
    assert(isDefined(inherit_from.script_ammo_extra), "<dev string:x480>");
    self itemweaponsetammo(inherit_from.script_ammo_alt_clip, inherit_from.script_ammo_alt_extra, undefined, 1);
  } else if(isDefined(inherit_from.script_ammo_alt_extra)) {
    assert(isDefined(inherit_from.script_ammo_alt_extra), "<dev string:x4c9>");
    assert(isDefined(inherit_from.script_ammo_clip), "<dev string:x4fa>");
    self itemweaponsetammo(inherit_from.script_ammo_alt_clip, inherit_from.script_ammo_alt_extra, undefined, 1);
  }

  if(isDefined(inherit_from.script_ammo_max)) {
    self itemweaponsetammo(weaponclipsize(self), weaponmaxammo(self));
  }

  if(placedub) {
    self itemweaponsetammo(1, 6, 0, 1);
    return;
  }

  if(issubstr(weaponname, "ub_golf25_sp") || issubstr(weaponname, "ub_mike203_sp")) {
    self itemweaponsetammo(1, 1, 0, 1);
  }
}
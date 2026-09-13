/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\shared.gsc
***********************************************/

placeweaponon(weapon, position, _id_B9976CC76957A593) {
  _id_9843089F949DCA89 = undefined;
  _id_9C4DF3D7151C3FCF = undefined;

  if(isweapon(weapon)) {
    _id_9843089F949DCA89 = weapon;
    _id_9C4DF3D7151C3FCF = getcompleteweaponname(weapon);
  } else {
    _id_9843089F949DCA89 = makeweaponfromstring(weapon);
    _id_9C4DF3D7151C3FCF = weapon;
  }

  self notify("weapon_position_change");
  _id_D10D32063978B096 = self.weaponinfo[_id_9C4DF3D7151C3FCF].position;

  if(position != "none" && isDefined(self.a.weaponpos[position]) && self.a.weaponpos[position] == _id_9843089F949DCA89) {
    return;
  }
  detachallweaponmodels();

  if(_id_D10D32063978B096 != "none")
    detachweapon(_id_9843089F949DCA89);

  if(position == "none") {
    updateattachedweaponmodels();
    return;
  }

  if(!isundefinedweapon(self.a.weaponpos[position]))
    detachweapon(self.a.weaponpos[position]);

  if(!isDefined(_id_B9976CC76957A593))
    _id_B9976CC76957A593 = 1;

  if(_id_B9976CC76957A593 && (position == "left" || position == "right")) {
    attachweapon(_id_9843089F949DCA89, position);
    self.weapon = _id_9843089F949DCA89;
  } else
    attachweapon(_id_9843089F949DCA89, position);

  updateattachedweaponmodels();
}

detachweapon(objweapon) {
  weaponname = getcompleteweaponname(objweapon);
  self.a.weaponpos[self.weaponinfo[weaponname].position] = undefined;
  self.weaponinfo[weaponname].position = "none";
}

attachweapon(objweapon, position) {
  weaponname = getcompleteweaponname(objweapon);
  self.weaponinfo[weaponname].position = position;
  self.a.weaponpos[position] = objweapon;

  if(!isundefinedweapon(self.a.weaponposdropping[position])) {
    self notify("end_weapon_drop_" + position);
    self.a.weaponposdropping[position] = undefined;
  }
}

getweaponforpos(position) {
  weapon = self.a.weaponpos[position];

  if(isundefinedweapon(weapon))
    return self.a.weaponposdropping[position];

  return weapon;
}

detachallweaponmodels() {
  _id_E4B7E99A96C8829F = [];
  _id_E4B7E99A96C8829F[_id_E4B7E99A96C8829F.size] = "right";
  _id_E4B7E99A96C8829F[_id_E4B7E99A96C8829F.size] = "left";
  _id_E4B7E99A96C8829F[_id_E4B7E99A96C8829F.size] = "chest";
  _id_E4B7E99A96C8829F[_id_E4B7E99A96C8829F.size] = "back";
  _id_E4B7E99A96C8829F[_id_E4B7E99A96C8829F.size] = "thigh";
  _id_E4B7E99A96C8829F[_id_E4B7E99A96C8829F.size] = "inhand";
  self laseroff();

  foreach(position in _id_E4B7E99A96C8829F) {
    weapon = getweaponforpos(position);

    if(isundefinedweapon(weapon)) {
      continue;
    }
    if(weapontype(weapon) == "riotshield" && isDefined(self.shieldmodelvariant)) {
      if(isDefined(self.shieldbroken) && self.shieldbroken) {
        playFXOnTag(scripts\engine\utility::getfx("riot_shield_dmg"), self, "TAG_BRASS");
        self.shieldbroken = undefined;
      }
    }
  }

  self updateentitywithweapons();
}

updateattachedweaponmodels() {
  _id_E4B7E99A96C8829F = [];
  weapons = [];
  tags = [];
  _id_E4B7E99A96C8829F[_id_E4B7E99A96C8829F.size] = "right";
  _id_E4B7E99A96C8829F[_id_E4B7E99A96C8829F.size] = "left";
  _id_E4B7E99A96C8829F[_id_E4B7E99A96C8829F.size] = "chest";
  _id_E4B7E99A96C8829F[_id_E4B7E99A96C8829F.size] = "back";
  _id_E4B7E99A96C8829F[_id_E4B7E99A96C8829F.size] = "thigh";
  _id_E4B7E99A96C8829F[_id_E4B7E99A96C8829F.size] = "inhand";

  foreach(position in _id_E4B7E99A96C8829F) {
    _id_65B529AEC2728DDC = weapons.size;
    weapon = getweaponforpos(position);

    if(!isundefinedweapon(weapon) && !isnullweapon(weapon)) {
      weaponname = getcompleteweaponname(weapon);

      if(self.weaponinfo[weaponname].useclip && !self.weaponinfo[weaponname].hasclip)
        weapon = weapon withoutattachment(weapon.magazine);
    }

    if(isDefined(weapon)) {
      _id_21BA9B0D87884688 = gettagforpos(position);

      if(self tagexists(_id_21BA9B0D87884688)) {
        weapons[_id_65B529AEC2728DDC] = weapon;
        tags[tags.size] = _id_21BA9B0D87884688;
      }
    }
  }

  self updateentitywithweapons(weapons[0], tags[0], weapons[1], tags[1], weapons[2], tags[2], weapons[3], tags[3]);
  self updatelaserstatus();
}

gettagforpos(position) {
  switch (position) {
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
    case "inhand":
      return "tag_inhand";
    default:
      break;
  }
}

dropaiweaponinternal(weapon) {
  if(_id_0335D7D001EB868F()) {
    if(weapon hasattachment(self._id_E0675E48962C6D55)) {
      detachweapon(weapon);
      weapon = weapon withoutattachment(self._id_E0675E48962C6D55);
      forceuseweapon(weapon, self._id_B5CE31099294CF74);
    }
  }

  weaponname = getcompleteweaponname(weapon);
  position = self.weaponinfo[weaponname].position;

  if(self.dropweapon && position != "none")
    thread dropweaponwrapper(weapon, position);

  detachweapon(weapon);

  if(weapon == self.weapon)
    self.weapon = nullweapon();

  if(weapon == self.primaryweapon)
    self.primaryweapon = nullweapon();

  if(weapon == self.secondaryweapon)
    self.secondaryweapon = nullweapon();

  if(weapon == self.sidearm) {
    if(!isnullweapon(self.primaryweapon))
      dropaiweaponinternal(self.primaryweapon);

    self.sidearm = nullweapon();
  }
}

dropaiweapon(weapon) {
  if(!isDefined(weapon))
    weapon = self.weapon;

  if(isnullweapon(weapon)) {
    return;
  }
  if(isDefined(self.nodrop)) {
    return;
  }
  detachallweaponmodels();
  dropaiweaponinternal(weapon);

  if(isnullweapon(self.primaryweapon)) {
    if(!isnullweapon(self.weapon))
      self.primaryweapon = self.weapon;
    else if(!isnullweapon(self.secondaryweapon))
      self.primaryweapon = self.secondaryweapon;
    else if(!isnullweapon(self.sidearm))
      self.primaryweapon = self.sidearm;

    if(self.primaryweapon == self.secondaryweapon)
      self.secondaryweapon = nullweapon();
  }

  updateattachedweaponmodels();
}

dropallaiweapons() {
  if(isDefined(self.nodrop))
    return "none";

  if(!isDefined(self.a) || !isDefined(self.a.weaponpos)) {
    return;
  }
  _id_E4B7E99A96C8829F = [];
  _id_E4B7E99A96C8829F[_id_E4B7E99A96C8829F.size] = "left";
  _id_E4B7E99A96C8829F[_id_E4B7E99A96C8829F.size] = "right";
  _id_E4B7E99A96C8829F[_id_E4B7E99A96C8829F.size] = "chest";
  _id_E4B7E99A96C8829F[_id_E4B7E99A96C8829F.size] = "back";
  _id_E4B7E99A96C8829F[_id_E4B7E99A96C8829F.size] = "thigh";
  _id_E4B7E99A96C8829F[_id_E4B7E99A96C8829F.size] = "inhand";
  detachallweaponmodels();

  foreach(position in _id_E4B7E99A96C8829F) {
    weapon = self.a.weaponpos[position];

    if(isundefinedweapon(weapon)) {
      continue;
    }
    weaponname = getcompleteweaponname(weapon);
    self.weaponinfo[weaponname].position = "none";
    self.a.weaponpos[position] = undefined;

    if(_id_0335D7D001EB868F()) {
      if(weapon hasattachment(self._id_E0675E48962C6D55))
        weapon = weapon withoutattachment(self._id_E0675E48962C6D55);
    }

    if(self.dropweapon)
      thread dropweaponwrapper(weapon, position);
  }

  self.weapon = nullweapon();
  updateattachedweaponmodels();
}

dropweaponwrapper(weapon, position) {
  if(self isragdoll())
    return "none";

  self.a.weaponposdropping[position] = weapon;
  _id_CD9ABE0E758CBDF7 = weapon;
  _id_92FCE7B1696254E3 = weapon.basename;

  if(issubstr(tolower(_id_92FCE7B1696254E3), "_ai")) {
    _id_92FCE7B1696254E3 = getsubstr(_id_92FCE7B1696254E3, 0, _id_92FCE7B1696254E3.size - 3);
    _id_CD9ABE0E758CBDF7 = makeweapon(_id_92FCE7B1696254E3, weapon.attachments);
  }

  thread setdroppedweaponammo(_id_CD9ABE0E758CBDF7);

  if(isagent(self)) {
    if(isDefined(level.dropped_weapon_func))
      self thread[[level.dropped_weapon_func]](_id_CD9ABE0E758CBDF7, position);
    else
      self dropweaponnovelocity(_id_CD9ABE0E758CBDF7, position);
  } else if(canaiflingweapon(self)) {
    if(position == "back" || position == "thigh")
      tagname = "tag_stowed_" + position;
    else
      tagname = "tag_weapon_" + position;

    if(!scripts\engine\utility::hastag(self.model, tagname)) {
      self dropweapon(_id_CD9ABE0E758CBDF7, position, 0);
      self endon("end_weapon_drop_" + position);
      waitframe();
      return;
    }

    _id_AB0DC1928066D386 = self gettagorigin(tagname);
    self endon("end_weapon_drop_" + position);
    waitframe();

    if(!isDefined(self)) {
      return;
    }
    tagorigin = self gettagorigin(tagname);
    _id_A43B0202C06E0907 = self gettagangles(tagname);
    _id_93CD9B84A4E18201 = getcompleteweaponname(_id_CD9ABE0E758CBDF7);
    _id_AC9BC7D09525B92A = spawn("weapon_" + _id_93CD9B84A4E18201, tagorigin);
    _id_AC9BC7D09525B92A.angles = _id_A43B0202C06E0907;
    _id_F10BC4073A536D2F = tagorigin - _id_AB0DC1928066D386;
    _id_F437BC51B4D819FA = vectorNormalize(_id_F10BC4073A536D2F);
    _id_C0F18187BA0798EC = 20;
    _id_6A8655E4B569B964 = 50;
    _id_737DF2E9AAF94A3E = min(length(_id_F10BC4073A536D2F) * _id_C0F18187BA0798EC, _id_6A8655E4B569B964);
    _id_309C91CE1EE4F500 = _id_F437BC51B4D819FA * _id_737DF2E9AAF94A3E;
    _id_4E12423804DB75AD = (0, 0, 950);
    _id_7331D469160F6A41 = _id_309C91CE1EE4F500 + _id_4E12423804DB75AD;
    _id_AC9BC7D09525B92A physicslaunchserveritem(tagorigin, _id_7331D469160F6A41);

    if(weaponclass(_id_CD9ABE0E758CBDF7) == "pistol") {
      _id_3D437F1697570E9A = 0.2;
      _id_212A44A5393C3B34 = _id_AC9BC7D09525B92A physics_getbodyid(0);
      _id_B3A3FF9A9E7E3EAA = physics_getbodyangvel(_id_212A44A5393C3B34) * _id_3D437F1697570E9A;
      physics_setbodyangvel(_id_212A44A5393C3B34, _id_B3A3FF9A9E7E3EAA[0], _id_B3A3FF9A9E7E3EAA[1], _id_B3A3FF9A9E7E3EAA[2]);
    }

    self notify("weapon_dropped", _id_AC9BC7D09525B92A);
  } else {
    self dropweapon(_id_CD9ABE0E758CBDF7, position, 0);
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

_id_0335D7D001EB868F() {
  if(isDefined(self._id_E0675E48962C6D55))
    return 1;

  return 0;
}

canaiflingweapon(ai) {
  if(!scripts\common\utility::issp())
    return 0;

  if(!isDefined(ai.lastattacker))
    return 0;

  if(!isPlayer(ai.lastattacker))
    return 0;

  if(isexplosivedamagemod(ai.damagemod))
    return 1;

  return 1;
}

setdroppedweaponammo(_id_CD9ABE0E758CBDF7) {
  self waittill("weapon_dropped", _id_0D2346943E5CB1F5);
  _id_0D2346943E5CB1F5 endon("death");

  if(isDefined(_id_CD9ABE0E758CBDF7) && isvaliddroppedweapon(_id_CD9ABE0E758CBDF7)) {
    if(isDefined(_id_0D2346943E5CB1F5)) {
      _id_0D2346943E5CB1F5 physics_registerforcollisioncallback();
      _id_0D2346943E5CB1F5 thread weapondrop_physics_callback_monitor(_id_CD9ABE0E758CBDF7);
      weaponname = getsubstr(_id_0D2346943E5CB1F5.classname, 7, _id_0D2346943E5CB1F5.classname.size);
      _id_0D2346943E5CB1F5 setscriptammo(weaponname, self);
    }
  }
}

isvaliddroppedweapon(weapon) {
  if(weapon.ismelee)
    return 0;

  return 1;
}

weapondrop_physics_callback_monitor(_id_47DCFBC98E2103EE) {
  self endon("death");
  self endon("timeout");
  thread weapondrop_physics_timeout(2);
  self waittill("collision", body0, body1, flag0, flag1, position, normal, _id_D71630B8BAF84FA8, ent);
  _id_895F3C282BC9FC68 = physics_getsurfacetypefromflags(flag1);
  surfacetype = getsubstr(_id_895F3C282BC9FC68["name"], 9);

  if(surfacetype == "user_terrain1")
    surfacetype = "user_terrain_1";

  if(isDefined(_id_47DCFBC98E2103EE.classname) && isDefined(self)) {
    alias = "weap_drop_med";

    switch (_id_47DCFBC98E2103EE.classname) {
      case "rifle":
        alias = "weap_drop_med";
        break;
      case "smg":
        alias = "weap_drop_small";
        break;
      case "mg":
        alias = "weap_drop_xlarge";
        break;
      case "spread":
        alias = "weap_drop_large";
        break;
      case "sniper":
        alias = "weap_drop_large";
        break;
      case "pistol":
        alias = "weap_drop_pistol";
        break;
      case "grenade":
        alias = "weap_drop_launcher";
        break;
      case "rocketlauncher":
        alias = "weap_drop_launcher";
        break;
    }

    if(soundexists(alias))
      self playsurfacesound(alias, surfacetype);
    else {}
  }
}

weapondrop_physics_timeout(time) {
  wait(time);
  self notify("timeout");
}

getaimyawtoshootentorpos() {
  if(!isDefined(self.shootent)) {
    if(!isDefined(self.shootpos))
      return 0;

    return scripts\engine\utility::getaimyawtopoint(self.shootpos);
  }

  return scripts\engine\utility::getaimyawtopoint(self.shootent getshootatpos());
}

getaimpitchtoshootentorpos() {
  pitch = getpitchtoshootentorpos();

  if(self.script == "cover_crouch" && isDefined(self.a.covermode) && self.a.covermode == "lean")
    pitch = pitch - anim.covercrouchleanpitch;

  return pitch;
}

getpitchtoshootentorpos() {
  if(!isDefined(self.shootent)) {
    if(!isDefined(self.shootpos))
      return 0;

    return _id_13D1C402F1421C35::getpitchtoshootspot(self.shootpos);
  }

  return _id_13D1C402F1421C35::getpitchtoshootspot(self.shootent getshootatpos());
}

ramboaim(_id_7BF015C40AC296B7) {
  self endon("killanimscript");
  ramboaiminternal(_id_7BF015C40AC296B7);
}

ramboaiminternal(_id_7BF015C40AC296B7) {}

decidenumshotsforburst() {
  _id_89F949A75D92E1A4 = 0;
  _id_8BA699667E1A6D48 = weaponburstcount(self.weapon);

  if(_id_8BA699667E1A6D48)
    _id_89F949A75D92E1A4 = _id_8BA699667E1A6D48;
  else if(_id_76FF4BA096A6F8AA::usingsemiautoweapon())
    _id_89F949A75D92E1A4 = anim.semifirenumshots[randomint(anim.semifirenumshots.size)];
  else if(self.fastburst)
    _id_89F949A75D92E1A4 = anim.fastburstfirenumshots[randomint(anim.fastburstfirenumshots.size)];
  else
    _id_89F949A75D92E1A4 = anim.burstfirenumshots[randomint(anim.burstfirenumshots.size)];

  if(_id_89F949A75D92E1A4 <= self.bulletsinclip)
    return _id_89F949A75D92E1A4;

  if(self.bulletsinclip <= 0)
    return 1;

  return self.bulletsinclip;
}

decidenumshotsforfull() {
  _id_89F949A75D92E1A4 = self.bulletsinclip;

  if(weaponclass(self.weapon) == "mg") {
    _id_DC061F521C45D732 = randomfloat(10);

    if(_id_DC061F521C45D732 < 3)
      _id_89F949A75D92E1A4 = randomintrange(2, 6);
    else if(_id_DC061F521C45D732 < 8)
      _id_89F949A75D92E1A4 = randomintrange(6, 12);
    else
      _id_89F949A75D92E1A4 = randomintrange(12, 20);
  }

  return _id_89F949A75D92E1A4;
}

hideweaponmagattachment(weaponname) {
  self.weaponinfo[weaponname].hasclip = 0;
  updateattachedweaponmodels();
}

showweaponmagattachment(weaponname) {
  self.weaponinfo[weaponname].hasclip = 1;
  updateattachedweaponmodels();
}

handledropclip(flagname) {
  self endon("abort_reload");
  self endon(flagname + "_finished");
  _id_3B19FE4716BEB04F = self.weapon;
  _id_E73086718813698C = getcompleteweaponname(_id_3B19FE4716BEB04F);
  clipmodel = undefined;

  if(self.weaponinfo[_id_E73086718813698C].useclip)
    clipmodel = getweaponclipmodel(self.weapon);

  if(self.weaponinfo[_id_E73086718813698C].hasclip) {
    if(_id_2B79931B08683E0A::isusingsidearm())
      self playSound("weap_reload_pistol_clipout_npc");
    else
      self playSound("weap_reload_smg_clipout_npc");

    if(isDefined(clipmodel)) {
      hideweaponmagattachment(_id_E73086718813698C);
      thread dropclipmodel(clipmodel, "tag_clip");
    }
  }

  _id_3CBA51F785093D95 = 0;

  while(!_id_3CBA51F785093D95) {
    self waittill(flagname, notes);

    if(!isarray(notes))
      notes = [notes];

    foreach(notetrack in notes) {
      switch (notetrack) {
        case "attach clip left":
          if(isDefined(clipmodel))
            self attach(clipmodel, "tag_accessory_left");

          break;
        case "attach clip right":
          if(isDefined(clipmodel))
            self attach(clipmodel, "tag_accessory_right");

          break;
        case "detach clip nohand":
          if(isDefined(clipmodel))
            self detach(clipmodel, "tag_accessory_right");

          break;
        case "detach clip right":
          if(isDefined(clipmodel)) {
            self detach(clipmodel, "tag_accessory_right");

            if(_id_3B19FE4716BEB04F == self.weapon)
              showweaponmagattachment(_id_E73086718813698C);
            else {
              self.weaponinfo[getcompleteweaponname(self.weapon)].hasclip = 1;
              self.weaponinfo[_id_E73086718813698C].hasclip = 1;
            }

            self notify("clip_detached");
          }

          _id_76FF4BA096A6F8AA::refillclip();
          _id_3CBA51F785093D95 = 1;
          break;
        case "detach clip left":
          if(isDefined(clipmodel)) {
            self detach(clipmodel, "tag_accessory_left");

            if(_id_3B19FE4716BEB04F == self.weapon)
              showweaponmagattachment(_id_E73086718813698C);
            else {
              self.weaponinfo[getcompleteweaponname(self.weapon)].hasclip = 1;
              self.weaponinfo[_id_E73086718813698C].hasclip = 1;
            }

            self notify("clip_detached");
          }

          _id_76FF4BA096A6F8AA::refillclip();
          _id_3CBA51F785093D95 = 1;
          break;
      }
    }
  }
}

dropclipmodel(clipmodel, tagname) {}

movetonodeovertime(node, time) {
  self endon("killanimscript");
  _id_49C14B71E6A5DB4B = node.origin;
  distsq = distancesquared(self.origin, _id_49C14B71E6A5DB4B);

  if(distsq < 1) {
    self safeteleport(_id_49C14B71E6A5DB4B);
    return;
  }

  if(distsq > 256 && !self maymovetopoint(_id_49C14B71E6A5DB4B, !scripts\engine\utility::actor_is3d())) {
    return;
  }
  self.keepclaimednodeifvalid = 1;
  _id_694B3083479CD273 = distance(self.origin, _id_49C14B71E6A5DB4B);
  _id_1AAD8F38CB38F703 = int(time * 20);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1AAD8F38CB38F703; _id_AC0E594AC96AA3A8++) {
    _id_49C14B71E6A5DB4B = node.origin;
    _id_E907009EAD5ACAF2 = self.origin - _id_49C14B71E6A5DB4B;
    _id_E907009EAD5ACAF2 = vectorNormalize(_id_E907009EAD5ACAF2);
    _id_8BFD5D34319579A5 = _id_49C14B71E6A5DB4B + _id_E907009EAD5ACAF2 * _id_694B3083479CD273;
    _id_D3D9736A622B6F4E = _id_8BFD5D34319579A5 + (_id_49C14B71E6A5DB4B - _id_8BFD5D34319579A5) * ((_id_AC0E594AC96AA3A8 + 1) / _id_1AAD8F38CB38F703);
    self safeteleport(_id_D3D9736A622B6F4E);
    wait 0.05;
  }

  self.keepclaimednodeifvalid = 0;
}

returntrue() {
  return 1;
}

#using_animtree("generic_human");

playlookanimation(_id_7694F8C1890D15E3, _id_CB58849338C969FB, _id_3EDA4DD47F961142) {
  if(!isDefined(_id_3EDA4DD47F961142))
    _id_3EDA4DD47F961142 = ::returntrue;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_CB58849338C969FB * 10; _id_AC0E594AC96AA3A8++) {
    if(isalive(self.enemy)) {
      if(_id_2B79931B08683E0A::canseeenemy() && [[_id_3EDA4DD47F961142]]())
        return;
    }

    if(_id_2B79931B08683E0A::issuppressedwrapper() && [[_id_3EDA4DD47F961142]]()) {
      return;
    }
    self setanimknoball(_id_7694F8C1890D15E3, %body, 1, 0.1);
    wait 0.1;
  }
}

throwdownweapon(_id_F449515CC6577BBB) {
  self endon("killanimscript");
  placeweaponon(self.secondaryweapon, "right");
  scripts\common\gameskill::didsomethingotherthanshooting();
}

rpgplayerrepulsor() {
  _id_8705205DEB31416A = rpgplayerrepulsor_getnummisses();

  if(_id_8705205DEB31416A == 0) {
    return;
  }
  self endon("death");

  for(;;) {
    self waittill("shooting");

    if(isDefined(level._id_028B2C05EB31D987)) {
      self[[level._id_028B2C05EB31D987]]();
      continue;
    }

    if(_id_A560B5ED33BEDC96()) {
      level thread rpgplayerrepulsor_create(self.enemy);
      _id_8705205DEB31416A--;

      if(_id_8705205DEB31416A <= 0)
        return;
    }
  }
}

_id_A560B5ED33BEDC96() {
  if(isDefined(level.createrpgrepulsors) && !level.createrpgrepulsors)
    return 0;

  if(isDefined(self.enemy) && isPlayer(self.enemy))
    return 1;

  return 0;
}

rpgplayerrepulsor_getnummisses() {
  _id_37E81DD20E1CDACA = scripts\common\utility::getdifficulty();

  switch (_id_37E81DD20E1CDACA) {
    case "gimp":
    case "easy":
      return 2;
    case "difficult":
    case "hard":
    case "medium":
      return 1;
    case "fu":
      return 0;
  }

  return 2;
}

rpgplayerrepulsor_create(ent) {
  ent notify("stop_prev_repulsor");
  ent endon("stop_prev_repulsor");

  if(!isDefined(ent._id_0F7CD0AFED33249F))
    ent._id_0F7CD0AFED33249F = missile_createrepulsorent(ent, 5000, 800);

  repulsor = ent._id_0F7CD0AFED33249F;
  ent scripts\engine\utility::waittill_notify_or_timeout("death", 4);
  missile_deleteattractor(repulsor);
  ent._id_0F7CD0AFED33249F = undefined;
}

pickandsetforceweapon() {
  if(isDefined(self.weaponoverride) && self.weaponoverride) {
    return;
  }
  if(scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), self.origin, 0.173648)) {
    return;
  }
  objweapon = undefined;

  if(distancesquared(self.origin, self.enemy.origin) < self.closeweaponmaxdist * self.closeweaponmaxdist)
    objweapon = self.forcedweaponclose;
  else
    objweapon = self.forcedweaponfar;

  if(objweapon != self.weapon) {
    forceuseweapon(objweapon, "primary");
    self.weapon_stow setModel(getweaponmodel(self.forcedweapon));
    self.forcedweapon = objweapon;
  }
}

forceuseweapon(_id_DD515FCF025B2E79, _id_CACEA726B31F0198) {
  _id_66B3DB972AC1531E = undefined;

  if(isweapon(_id_DD515FCF025B2E79))
    _id_66B3DB972AC1531E = _id_DD515FCF025B2E79;
  else
    _id_66B3DB972AC1531E = [[level.fnbuildweapon]](_id_DD515FCF025B2E79);

  if(istrue(self.script_fakeactor) || istrue(self.script_drone)) {
    scripts\common\ai::gun_remove();
    scripts\common\ai::gun_create_fake(getweaponattachmentworldmodels(_id_66B3DB972AC1531E));
    return;
  }

  if(!scripts\common\utility::isweaponinitialized(_id_66B3DB972AC1531E))
    scripts\common\utility::initweapon(_id_66B3DB972AC1531E);

  hasweapon = !isnullweapon(self.weapon);
  _id_26066068C8C080DD = _id_2B79931B08683E0A::isusingsidearm();
  _id_8B0C7B8B1B21DDB8 = _id_CACEA726B31F0198 == "sidearm";
  _id_12F0E03EDE4BBD79 = _id_CACEA726B31F0198 == "secondary";

  if(hasweapon && _id_26066068C8C080DD != _id_8B0C7B8B1B21DDB8) {
    if(_id_26066068C8C080DD)
      _id_86D39F2FC4D668D5 = "none";
    else if(_id_12F0E03EDE4BBD79)
      _id_86D39F2FC4D668D5 = "back";
    else
      _id_86D39F2FC4D668D5 = "chest";

    placeweaponon(self.weapon, _id_86D39F2FC4D668D5);
    self.lastweapon = self.weapon;
  } else
    self.lastweapon = _id_66B3DB972AC1531E;

  placeweaponon(_id_66B3DB972AC1531E, "right");

  if(_id_8B0C7B8B1B21DDB8)
    self.sidearm = _id_66B3DB972AC1531E;
  else if(_id_12F0E03EDE4BBD79)
    self.secondaryweapon = _id_66B3DB972AC1531E;
  else
    self.primaryweapon = _id_66B3DB972AC1531E;

  self.weapon = _id_66B3DB972AC1531E;
  self.bulletsinclip = weaponclipsize(self.weapon);
  self notify("weapon_switch_done");
  updateweaponarchetype(weaponclass(self.weapon));
}

updateweaponarchetype(_id_0DD6BF5F9DBA888C) {
  if(!isDefined(self._blackboard) || scripts\asm\asm_bb::bb_isanimScripted() || !isDefined(self.asm) || !isDefined(self._id_AE3EA15396B65C1F)) {
    return;
  }
  basearchetype = self getbasearchetype();

  if(_id_0DD6BF5F9DBA888C == "pistol" && archetypeassetloaded(basearchetype + "_pistol"))
    self setoverridearchetype("weapon", basearchetype + "_pistol");
  else if(_id_0DD6BF5F9DBA888C == "mg" && archetypeassetloaded(basearchetype + "_lmg"))
    self setoverridearchetype("weapon", basearchetype + "_lmg");
  else
    self clearoverridearchetype("weapon");
}

everusessecondaryweapon() {
  if(_id_2B79931B08683E0A::isshotgun(self.secondaryweapon))
    return 1;

  if(weaponclass(self.primaryweapon) == "rocketlauncher")
    return 1;

  return 0;
}

default_weaponsetup(_id_4FA6C3F27E072CB6) {
  if(!isDefined(self.stowsidearmposition)) {
    if(istrue(self.bhasthighholster))
      self.stowsidearmposition = "thigh";
    else
      self.stowsidearmposition = anim.stowsidearmpositiondefault;
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
      if(!isweapon(self.primaryweapon))
        self.primaryweapon = [[level.fnbuildweapon]](self.primaryweapon, [], "none", "none");

      if(!isweapon(self.secondaryweapon))
        self.secondaryweapon = [[level.fnbuildweapon]](self.secondaryweapon, [], "none", "none");

      if(!isweapon(self.sidearm))
        self.sidearm = [[level.fnbuildweapon]](self.sidearm, [], "none", "none");
    } else {
      self.primaryweapon = [[level.fnbuildweapon]](self.primaryweapon, []);
      self.secondaryweapon = [[level.fnbuildweapon]](self.secondaryweapon, []);
      self.sidearm = [[level.fnbuildweapon]](self.sidearm, []);
    }
  }

  scripts\common\utility::initweapon(nullweapon());

  if(!isnullweapon(self.primaryweapon))
    scripts\common\utility::initweapon(self.primaryweapon);

  if(!isnullweapon(self.secondaryweapon))
    scripts\common\utility::initweapon(self.secondaryweapon);

  if(!isnullweapon(self.sidearm))
    scripts\common\utility::initweapon(self.sidearm);

  _id_C7C0F2B1FF4110CE();
  self setdefaultaimlimits();
  self.a.weaponpos = [];
  self.a.weaponposdropping = [];
  self.lastweapon = self.weapon;

  if(_id_2B79931B08683E0A::usingrocketlauncher())
    thread rpgplayerrepulsor();

  self.rocketammo = 100;

  if(!isnullweapon(self.primaryweapon))
    placeweaponon(self.primaryweapon, "right");

  if(_id_2B79931B08683E0A::isshotgun(self.secondaryweapon))
    placeweaponon(self.secondaryweapon, "back");

  if(!isnullweapon(self.sidearm) && isDefined(self.stowsidearmposition))
    placeweaponon(self.sidearm, self.stowsidearmposition);

  if(self isbadguy())
    self.has_no_ir = 1;

  _id_76FF4BA096A6F8AA::refillclip();
}

_id_C7C0F2B1FF4110CE() {}

initmeleecharges() {
  anim.meleechargetimers["c6"] = 0;
  anim.meleechargeintervals["c6"] = 9000;
  anim.meleechargeplayertimers["c6"] = 0;
  anim.meleechargeplayerintervals["c6"] = 15000;
  anim.meleechargetimers["seeker"] = 0;
  anim.meleechargeintervals["seeker"] = 9000;
  anim.meleechargeplayertimers["seeker"] = 0;
  anim.meleechargeplayerintervals["seeker"] = 15000;
}

init_squadmanager() {
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

initanimvars() {
  anim.animflagnameindex = 0;
  anim.combatmemorytimeconst = 10000;
  anim.combatmemorytimerand = 6000;
  anim.weaponsetupfuncs = [];
  anim.weaponsetupfuncs["c12"] = ::c12_weaponsetup;
  anim.dismemberheavyfx = [];
  anim.weaponstowfunction = ::pickandsetforceweapon;

  if(!isDefined(anim.optionalstepeffects))
    anim.optionalstepeffects = [];

  if(!isDefined(anim.optionalstepeffectssmall))
    anim.optionalstepeffectssmall = [];

  if(!isDefined(anim.optionalfootprinteffects))
    anim.optionalfootprinteffects = [];

  if(!isDefined(anim.shootenemywrapper_func))
    anim.shootenemywrapper_func = _id_7E4D332E911E1B90::shootenemywrapper_shootnotify;

  if(!isDefined(anim.shootposwrapper_func))
    anim.shootposwrapper_func = _id_7E4D332E911E1B90::shootposwrapper;

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
  anim._id_432836E99816347C = [];

  if(!isDefined(anim._id_91BC951178DA9F3B)) {
    anim._id_91BC951178DA9F3B = _id_7D535542E36D66F9::_id_6FBEA72303085C6F;
    anim._id_8122F7EFA052C448 = _id_7D535542E36D66F9::_id_1E1767FDC6980106;
  }

  if(!isDefined(anim._id_C65F21298CE83C9C)) {
    anim._id_C65F21298CE83C9C = ::detachallweaponmodels;
    anim._id_F240EF0C84EAC2B2 = ::updateattachedweaponmodels;
  }

  initgestures();
  initmaxspeedforpathlengthtable();
  _id_469E0E48A1796CA6::init();
}

initgestures() {
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

setglobalaimsettings() {
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

c12_getweapontypeforweapon() {
  if(_id_2B79931B08683E0A::usingrocketlauncher())
    return "rocket";
  else if(_id_2B79931B08683E0A::usingriflelikeweapon())
    return "minigun";

  return undefined;
}

c12_weaponsetup() {
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

initwindowtraverse() {
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

setuprandomtable() {
  anim.randominttablesize = 60;
  anim.randominttable = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < anim.randominttablesize; _id_AC0E594AC96AA3A8++)
    anim.randominttable[_id_AC0E594AC96AA3A8] = _id_AC0E594AC96AA3A8;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < anim.randominttablesize; _id_AC0E594AC96AA3A8++) {
    _id_AFE2BC520FC88E81 = randomint(anim.randominttablesize);
    temp = anim.randominttable[_id_AC0E594AC96AA3A8];
    anim.randominttable[_id_AC0E594AC96AA3A8] = anim.randominttable[_id_AFE2BC520FC88E81];
    anim.randominttable[_id_AFE2BC520FC88E81] = temp;
  }
}

setupweapons() {
  self endon("death");
  scripts\engine\utility::flag_wait("load_finished");

  if(isDefined(anim.weaponsetupfuncs) && isDefined(anim.weaponsetupfuncs[self.unittype]))
    self[[anim.weaponsetupfuncs[self.unittype]]]();
  else
    default_weaponsetup();
}

setscriptammo(weaponname, _id_DAA4B1537E4B3981, _id_294F7847D19DCBDB) {
  if(isDefined(_id_DAA4B1537E4B3981.script_ammo_clip))
    self itemweaponsetammo(_id_DAA4B1537E4B3981.script_ammo_clip, _id_DAA4B1537E4B3981.script_ammo_extra);
  else if(isDefined(_id_DAA4B1537E4B3981.script_ammo_extra))
    self itemweaponsetammo(_id_DAA4B1537E4B3981.script_ammo_clip, _id_DAA4B1537E4B3981.script_ammo_extra);

  if(isDefined(_id_DAA4B1537E4B3981.script_ammo_alt_clip))
    self itemweaponsetammo(_id_DAA4B1537E4B3981.script_ammo_alt_clip, _id_DAA4B1537E4B3981.script_ammo_alt_extra, undefined, 1);
  else if(isDefined(_id_DAA4B1537E4B3981.script_ammo_alt_extra))
    self itemweaponsetammo(_id_DAA4B1537E4B3981.script_ammo_alt_clip, _id_DAA4B1537E4B3981.script_ammo_alt_extra, undefined, 1);

  if(isDefined(_id_DAA4B1537E4B3981.script_ammo_max))
    self itemweaponsetammo(weaponclipsize(self), weaponmaxammo(self));

  if(istrue(_id_294F7847D19DCBDB))
    self itemweaponsetammo(1, 6, 0, 1);
  else if(issubstr(weaponname, "ub_golf25_sp") || issubstr(weaponname, "ub_mike203_sp"))
    self itemweaponsetammo(1, 1, 0, 1);
}